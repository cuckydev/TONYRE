#include <Core/macros.h>
#include <Core/Defines.h>
#include <Core/math.h>
#include <Core/crc.h>

#include "p_music.h"

#include "usersoundtrack.h"

#include <Sys/Config/config.h>
#include <Gel/SoundFX/soundfx.h>
#include <Gel/Scripting/checksum.h>

#include <Plat/Audio/Mixer.h>

#include <Plat/Sys/File/p_filesys.h>

#include <mutex>
#include <thread>
#include <functional>
#include <fstream>

#include <Windows.h>

namespace Pcm
{
	// Volume constants
	static constexpr float MUSIC_VOLUME = 1.0f;
	static constexpr float STREAM_VOLUME = 0.5f; // Streams are too loud, ripped from PS2

	// Music decoder using miniaudio
	class Streamer
	{
		#if 0
		private:
			std::unique_ptr<char> buffer[2];
			size_t buffer_size[2] = {};
			size_t buffer_read[2] = {};

			size_t new_buffer_size = 0;

			size_t db_i = 0, db_point = 0, db_left = 0;
			bool db_streaming[2] = {};

			std::mutex db_mutex;
			std::condition_variable db_cv;
			size_t db_cv_i = 0;

			std::thread db_thread = std::thread([this]() {
				while (1)
				{
					// Wait to be given a new index
					size_t i;
					{
						std::unique_lock<std::mutex> db_lock(db_mutex);
						db_cv.wait(db_lock);
						i = db_cv_i;
					}
					if (i == 2)
						return;

					// Stream into index
					buffer_read[i] = Stream(buffer[i].get(), buffer_size[i]);
					db_thread_busy = false;
				}
				});
			std::atomic<bool> db_thread_busy;

			bool paused = true;
			bool playing = true;

		public:
			virtual ~Streamer()
			{
				// Kill thread
				{
					std::unique_lock<std::mutex> db_lock(db_mutex);
					db_cv_i = 2;
					db_cv.notify_all();
				}
				db_thread.join();
			}

			size_t Request(char *out, size_t bytes)
			{
				// If stopped or paused, return 0
				if (!playing || paused)
					return 0;

				// Set next buffer size
				size_t want_new_buffer_size = bytes * 32;
				if (want_new_buffer_size > new_buffer_size)
					new_buffer_size = want_new_buffer_size;

				// If current buffer isn't ready, start streaming in
				if (!buffer[db_i])
					StartStream(db_i);

				// Read in buffers
				size_t to_read = bytes;

				while (to_read > 0)
				{
					// Wait for this buffer to be ready
					if (db_streaming[db_i])
					{
						// Wait for thread to finish
						if (db_thread_busy)
							break;

						// Start streaming
						db_streaming[db_i] = false;
						db_point = 0;
						db_left = buffer_read[db_i];
					}

					// If next buffer isn't ready, start streaming in
					if (!db_streaming[db_i ^ 1])
						StartStream(db_i ^ 1);

					// Read the rest of the current buffer in
					if (db_left > 0)
					{
						// Get bytes we can read from the current buffer
						size_t db_out = bytes;
						if (db_out > db_left)
							db_out = db_left;

						// Copy them to the output buffer
						for (size_t i = 0; i < db_out; i++)
							out[i] += buffer[db_i].get()[db_point + i];
						db_point += db_out;
						db_left -= db_out;

						// Update the output pointer and bytes left to read
						to_read -= db_out;
						out += db_out;
					}

					// If buffer is completed, swap
					if (db_left == 0)
					{
						if (buffer_read[db_i] < buffer_size[db_i])
						{
							playing = false;
							return bytes - to_read;
						}
						db_i ^= 1;
					}
				}

				return bytes;
			}

			virtual void Rewind() = 0;
			virtual size_t Stream(char *p, size_t bytes) = 0;

			void Pause() { paused = true; }
			void Resume() { paused = false; }

			void Stop()
			{
				paused = true;
				playing = true;
			}

			bool IsPaused() const { return paused; }
			bool IsPlaying() const { return playing; }

		private:
			void StartStream(size_t i)
			{
				// If buffer is smaller than our new buffer size, resize it
				if (buffer_size[i] < new_buffer_size)
				{
					buffer[i].reset();
					buffer[i].reset(new char[new_buffer_size]);
					buffer_size[i] = new_buffer_size;
				}

				// Start streaming thread
				{
					std::lock_guard<std::mutex> lock(db_mutex);
					db_cv_i = i;
					db_cv.notify_all();
				}

				db_streaming[i] = true;
				db_thread_busy = true;
			}
		#endif
		private:
			std::vector<char> buffer;

			bool paused = true;
			bool playing = true;

			float volume[5] = { 1.0f, 1.0f, 1.0f, 1.0f, 1.0f };

		public:
			virtual void Rewind() = 0;
			virtual size_t Stream(char *p, size_t bytes) = 0;

			size_t Mix(char *out, size_t bytes)
			{
				// If stopped or paused, return 0
				if (!playing || paused)
					return 0;

				// Read in buffer
				if (buffer.size() < bytes)
					buffer.resize(bytes);

				size_t read = Stream(buffer.data(), bytes);
				if (read < bytes)
					playing = false;

				// Accumulate
				float *a = (float*)out;
				float *b = (float*)buffer.data();
				for (size_t i = 0; i < read / sizeof(float) / 5; i++)
				{
					for (int c = 0; c < 5; c++)
						*a++ += *b++ * volume[c];
				}

				return read;
			}

			void Play()
			{
				paused = false;
			}

			void Pause()
			{
				paused = true;
			}

			void Stop()
			{
				Rewind();
				paused = true;
				playing = true;
			}

			bool IsPaused() const { return paused; }
			bool IsPlaying() const { return playing; }

			void SetVolume(float *coefs)
			{
				for (int i = 0; i < 5; i++)
					volume[i] = coefs[i];
			}
	};

	class MusicDecoder : public Streamer
	{
		private:
			ma_decoder decoder = {};
			std::ifstream file;

		public:
			MusicDecoder(std::filesystem::path path) : file(path, std::ios::binary)
			{
				ma_decoder_config config = ma_decoder_config_init(ma_format_f32, 5, 48000);
				ma_decoder_init(
					[](ma_decoder *pDecoder, void *pBufferOut, size_t bytesToRead, size_t *pBytesRead) -> ma_result
					{
						MusicDecoder *self = (MusicDecoder *)pDecoder->pUserData;
						self->file.read((char*)pBufferOut, bytesToRead);
						if (pBytesRead != nullptr)
							*pBytesRead = self->file.gcount();
						return MA_SUCCESS;
					},
					[](ma_decoder *pDecoder, ma_int64 byteOffset, ma_seek_origin origin) -> ma_result
					{
						MusicDecoder *self = (MusicDecoder*)pDecoder->pUserData;
						switch (origin)
						{
							case ma_seek_origin_start:
								self->file.seekg(byteOffset, std::ios::beg);
								break;
							case ma_seek_origin_current:
								self->file.seekg(byteOffset, std::ios::cur);
								break;
							case ma_seek_origin_end:
								self->file.seekg(byteOffset, std::ios::end);
								break;
						}
						return MA_SUCCESS;
					},
					this,
					&config,
					&decoder
				);
			}

			~MusicDecoder()
			{

			}

		private:
			void Rewind() override
			{
				ma_decoder_seek_to_pcm_frame(&decoder, 0);
			}

			size_t Stream(char *p, size_t bytes) override
			{
				// Read from decoder
				ma_uint64 frames_read = 0;
				ma_decoder_read_pcm_frames(&decoder, p, bytes / (sizeof(float) * 5), &frames_read);
				return (size_t)(frames_read * (sizeof(float) * 5));
			}
	};

	// Mixing streams
	Streamer *music_stream = nullptr;
	Streamer *stream_stream[NUM_STREAMS] = {};

	// Mixer
	void PCMAudio_Mix(char *buffer, size_t size)
	{
		// Mix music
		if (music_stream != nullptr)
			music_stream->Mix(buffer, size);

		// Mix streams
		for (auto &i : stream_stream)
			if (i != nullptr)
				i->Mix(buffer, size);
	}

	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	static std::unordered_map<uint32, std::string> music_paths;
	static std::unordered_map<uint32, std::string> stream_paths;

	static std::unordered_map<uint32, std::string> Index(std::filesystem::path path)
	{
		std::unordered_map<uint32, std::string> paths;
		for (auto &i : std::filesystem::recursive_directory_iterator(path))
		{
			if (i.is_regular_file())
			{
				std::string name = i.path().stem().string();
				uint32 checksum = Crc::GenerateCRCFromString(name.c_str());
				paths[checksum] = std::filesystem::relative(i.path(), File::DataPath()).string();
			}
		}
		return paths;
	}

	void PCMAudio_Init( void )
	{
		// Initialize mixer
		Audio::Init();

		// Index music and streams
		music_paths = Index(File::DataPath() / "music");
		stream_paths = Index(File::DataPath() / "streams");
	}



	/******************************************************************/
	/*                                                                */
	/* Call every frame to make sure music and stream buffers are	  */
	/* loaded and current status is checked each frame...			  */
	/*                                                                */
	/******************************************************************/
	int PCMAudio_Update( void )
	{
		return 0;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	void PCMAudio_StopMusic( bool waitPlease )
	{
		(void)waitPlease;

		Audio::Lock();

		if (music_stream != nullptr)
		{
			delete music_stream;
			music_stream = nullptr;
		}

		Audio::Unlock();
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	void PCMAudio_StopStream( int whichStream, bool waitPlease )
	{
		(void)waitPlease;

		Audio::Lock();

		if (stream_stream[whichStream] != nullptr)
		{
			delete stream_stream[whichStream];
			stream_stream[whichStream] = nullptr;
		}

		Audio::Unlock();
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	void PCMAudio_StopStreams( void )
	{
		Audio::Lock();

		for (auto &i : stream_stream)
		{
			if (i != nullptr)
			{
				delete i;
				i = nullptr;
			}
		}

		Audio::Unlock();
	}


	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/

	// This is temp code for the preload streams.  It just calls the normal one.

	// static uint32 sPreLoadChecksum[NUM_STREAMS];
	// static uint32 sPreLoadMusicChecksum;

	/******************************************************************/
	/*                                                                */
	/* Get a stream loaded into a buffer, but don't play yet		  */
	/*                                                                */
	/******************************************************************/
	bool PCMAudio_PreLoadStream( uint32 checksum, int whichStream )
	{
		PCMAudio_PlayStream(checksum, whichStream, nullptr, 0.0f, true);
		return true;
	}



	/******************************************************************/
	/*                                                                */
	/* Returns true if preload done. Assumes that caller is calling	  */
	/* this on a preloaded, but not yet played, stream. The results	  */
	/* are meaningless otherwise.									  */
	/*                                                                */
	/******************************************************************/
	bool PCMAudio_PreLoadStreamDone( int whichStream )
	{
		(void)whichStream;
		return true;
	}



	/******************************************************************/
	/*                                                                */
	/* Tells a preloaded stream to start playing.					  */
	/* Must call PCMAudio_PreLoadStreamDone() first to guarantee that */
	/* it starts immediately.										  */
	/*                                                                */
	/******************************************************************/
	bool PCMAudio_StartPreLoadedStream( int whichStream, Sfx::sVolume *p_volume, float pitch )
	{
		(void)whichStream;
		(void)p_volume;
		(void)pitch;

		PCMAudio_SetStreamVolume(p_volume, whichStream);

		Audio::Lock();

		if (stream_stream[whichStream] != nullptr)
			stream_stream[whichStream]->Play();

		Audio::Unlock();
		
		return true;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	bool PCMAudio_PreLoadMusicStream( uint32 checksum )
	{
		auto it = music_paths.find(checksum);
		if (it == music_paths.end())
			return false;

		Audio::Lock();

		if (music_stream != nullptr)
			delete music_stream;
		music_stream = new MusicDecoder(File::DataPath() / it->second);

		Audio::Unlock();
		return true;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	bool PCMAudio_PreLoadMusicStreamDone( void )
	{
		return true;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	bool PCMAudio_StartPreLoadedMusicStream( void )
	{
		Audio::Lock();
		if (music_stream != nullptr)
			music_stream->Play();
		Audio::Unlock();
		return true;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	int PCMAudio_GetMusicStatus( void )
	{
		Audio::Lock();

		int status;
		if (music_stream == nullptr)
			status = PCM_STATUS_FREE;
		else if (music_stream->IsPlaying())
			status = PCM_STATUS_PLAYING;
		else
			status = PCM_STATUS_FREE;

		Audio::Unlock();
		return status;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	int PCMAudio_GetStreamStatus( int whichStream )
	{
		Audio::Lock();

		int status;
		Streamer *stream = stream_stream[whichStream];
		if (stream == nullptr)
			status = PCM_STATUS_FREE;
		else if (stream->IsPlaying())
			status = PCM_STATUS_PLAYING;
		else
			status = PCM_STATUS_FREE;
		
		Audio::Unlock();
		return status;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	void PCMAudio_Pause( bool pause, int ch )
	{
		(void)pause;
		(void)ch;

		Audio::Lock();

		if (ch == MUSIC_CHANNEL)
		{
			if (music_stream != nullptr)
			{
				if (pause)
					music_stream->Pause();
				else
					music_stream->Play();
			}
		}
		else
		{
			for (auto &i : stream_stream)
			{
				if (i != nullptr)
				{
					if (pause)
						i->Pause();
					else
						i->Play();
				}
			}
		}

		Audio::Unlock();
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	bool PCMAudio_TrackExists( const char *pTrackName, int ch )
	{
		(void)pTrackName;
		(void)ch;

		return true;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	bool PCMAudio_LoadMusicHeader( const char *nameOfFile )
	{
		(void)nameOfFile;
		// Legacy call left over from PS2 code.
		return true;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	bool PCMAudio_LoadStreamHeader( const char *nameOfFile )
	{
		(void)nameOfFile;
		// Legacy call left over from PS2 code.
		return true;
	}


	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	uint32 PCMAudio_FindNameFromChecksum( uint32 checksum, int ch )
	{
		if (ch != EXTRA_CHANNEL)
			return 0;

		auto it = stream_paths.find(checksum);
		if (it == stream_paths.end())
			return 0;

		return checksum;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	bool PCMAudio_SetStreamVolume( Sfx::sVolume *p_volume, int whichStream )
	{
		Audio::Lock();

		if (stream_stream[whichStream] != nullptr)
		{
			Spt::SingletonPtr< Sfx::CSfxManager > sfx_manager;

			float coef[5] = {};

			switch (p_volume->GetVolumeType())
			{
				case Sfx::VOLUME_TYPE_5_CHANNEL_DOLBY5_1:
				{
					// NOTE: sVolume is in the order of FL, C, FR, BL, BR
					// So we need to swap C and FR to match what the mixer expects
					coef[0] = PERCENT(sfx_manager->GetMainVolume(), p_volume->GetChannelVolume(0)) / 100.0f * STREAM_VOLUME;
					coef[1] = PERCENT(sfx_manager->GetMainVolume(), p_volume->GetChannelVolume(1)) / 100.0f * STREAM_VOLUME;
					coef[2] = PERCENT(sfx_manager->GetMainVolume(), p_volume->GetChannelVolume(4)) / 100.0f * STREAM_VOLUME;
					coef[3] = PERCENT(sfx_manager->GetMainVolume(), p_volume->GetChannelVolume(2)) / 100.0f * STREAM_VOLUME;
					coef[4] = PERCENT(sfx_manager->GetMainVolume(), p_volume->GetChannelVolume(3)) / 100.0f * STREAM_VOLUME;
					break;
				}
				case Sfx::VOLUME_TYPE_2_CHANNEL_DOLBYII:
				{
					coef[0] = PERCENT(sfx_manager->GetMainVolume(), p_volume->GetChannelVolume(0)) / 100.0f * STREAM_VOLUME;
					coef[1] = PERCENT(sfx_manager->GetMainVolume(), p_volume->GetChannelVolume(1)) / 100.0f * STREAM_VOLUME;
					break;
				}
				case Sfx::VOLUME_TYPE_BASIC_2_CHANNEL:
				{
					coef[0] = PERCENT(sfx_manager->GetMainVolume(), p_volume->GetChannelVolume(0)) / 100.0f * STREAM_VOLUME;
					coef[1] = PERCENT(sfx_manager->GetMainVolume(), p_volume->GetChannelVolume(1)) / 100.0f * STREAM_VOLUME;
					break;
				}
			}

			stream_stream[whichStream]->SetVolume(coef);
		}

		Audio::Unlock();
		return true;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	int PCMAudio_SetMusicVolume( float volume )
	{
		(void)volume;

		Audio::Lock();

		if (music_stream != nullptr)
		{
			float coef[5] = {};
			coef[0] = volume / 100.0f;
			coef[1] = volume / 100.0f;
			coef[2] = volume / 100.0f;
			coef[3] = volume / 100.0f;
			coef[4] = volume / 100.0f;
			music_stream->SetVolume(coef);
		}

		Audio::Unlock();
		return true;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	bool PCMAudio_SetStreamPitch( float fPitch, int whichStream )
	{
		(void)fPitch;
		(void)whichStream;
		return true;
	}

	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	bool PCMAudio_PlayMusicTrack( uint32 checksum )
	{
		(void)checksum;
		Dbg_Assert(0);
		return false;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	bool PCMAudio_PlayMusicTrack( const char *filename )
	{
		// Play song
		Audio::Lock();
		
		if (music_stream != nullptr)
			delete music_stream;

		std::string name = std::string(filename) + ".wav";
		music_stream = new MusicDecoder(File::DataPath() / name);
		music_stream->Play();

		Audio::Unlock();
		return true;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	bool PCMAudio_PlaySoundtrackMusicTrack( int soundtrack, int track )
	{
		// Play song
		Audio::Lock();

		if (music_stream != nullptr)
			delete music_stream;

		const UserSoundtrack::Soundtracks &soundtracks = UserSoundtrack::GetSoundtracks();
		music_stream = new MusicDecoder(soundtracks.at(soundtrack).tracks.at(track).path);
		music_stream->Play();

		Audio::Unlock();
		return true;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	bool PCMAudio_StartStream( int whichStream )
	{
		Audio::Lock();

		if (stream_stream[whichStream] != nullptr)
			stream_stream[whichStream]->Play();

		Audio::Unlock();

		return true;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	bool PCMAudio_PlayStream( uint32 checksum, int whichStream, Sfx::sVolume *p_volume, float fPitch, bool preload )
	{
		(void)fPitch;

		auto it = stream_paths.find(checksum);
		if (it == stream_paths.end())
			return false;

		Audio::Lock();

		if (stream_stream[whichStream] != nullptr)
			delete stream_stream[whichStream];

		stream_stream[whichStream] = new MusicDecoder(File::DataPath() / it->second);
		if (!preload)
			stream_stream[whichStream]->Play();

		if (p_volume != nullptr)
			PCMAudio_SetStreamVolume(p_volume, whichStream);

		Audio::Unlock();

		return true;
	}

	// User soundtracks
	size_t GetNumSoundtracks()
	{
		const UserSoundtrack::Soundtracks &soundtracks = UserSoundtrack::GetSoundtracks();
		return soundtracks.size();
	}

	size_t GetSoundtrackNumSongs(size_t i)
	{
		const UserSoundtrack::Soundtracks &soundtracks = UserSoundtrack::GetSoundtracks();
		return soundtracks.at(i).tracks.size();
	}

	const char *GetSoundtrackName(size_t i)
	{
		const UserSoundtrack::Soundtracks &soundtracks = UserSoundtrack::GetSoundtracks();
		return soundtracks.at(i).name.c_str();
	}

} // namespace PCM
