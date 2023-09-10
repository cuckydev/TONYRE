/*****************************************************************************
**																			**
**			              Neversoft Entertainment			                **
**																		   	**
**				   Copyright (C) 1999 - All Rights Reserved				   	**
**																			**
******************************************************************************
**																			**
**	Project:		GFX (Graphics Library)									**
**																			**
**	Module:			Game Engine (GEL)	 									**
**																			**
**	File name:		p_music.cpp												**
**																			**
**	Created:		07/24/01	-	dc										**
**																			**
**	Description:	Xbox specific .wma streaming code						**
**																			**
*****************************************************************************/


/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/

#include <SDL.h>

#include <Windows.h>

#include <Core/macros.h>
#include <Core/Defines.h>
#include <Core/math.h>
#include <Core/crc.h>

#include "p_music.h"

#include "usersoundtrack.h"

#include <Sys/Config/config.h>
#include <Gel/SoundFX/soundfx.h>

#include <miniaudio.h>

#include <string>
#include <vector>
#include <memory>

#include <thread>
#include <atomic>

#include <mutex>
#include <condition_variable>

#include <functional>

/*****************************************************************************
**								  Externals									**
*****************************************************************************/

namespace Pcm
{

// Music decoder using miniaudio
class Streamer
{
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

		bool paused = false;
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
					std::copy(buffer[db_i].get() + db_point, buffer[db_i].get() + db_point + db_out, out);
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

		virtual size_t Stream(char *p, size_t bytes) = 0;

		void Pause() { paused = true; }
		void Resume() { paused = false; }
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
};

class MusicDecoder : public Streamer
{
	private:
		ma_decoder decoder;

	public:
		MusicDecoder(const char *name)
		{
			ma_decoder_config config = ma_decoder_config_init(ma_format_f32, 5, 48000);
			ma_decoder_init_file(name, &config, &decoder);
		}

	private:
		size_t Stream(char *p, size_t bytes) override
		{
			// Read from decoder
			ma_uint64 frames_read = 0;
			ma_decoder_read_pcm_frames(&decoder, p, bytes / (sizeof(float) * 5), &frames_read);
			return (size_t)(frames_read * (sizeof(float) * 5));
		}
};

// Audio device
SDL_AudioDeviceID s_audio_device;

MusicDecoder *decoder = nullptr;

// Audio callback
void AudioCallback(void *userdata, Uint8 *stream, int len)
{
	(void)userdata;

	// Clear the stream
	memset(stream, 0, len);
	if (decoder != nullptr)
		decoder->Request((char*)stream, len);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void PCMAudio_Init( void )
{
	// Audio device spec
	SDL_AudioSpec s_wanted_spec = {};
	s_wanted_spec.format = AUDIO_F32SYS;
	s_wanted_spec.freq = 48000;
	s_wanted_spec.channels = 5;
	s_wanted_spec.samples = 1024;
	s_wanted_spec.callback = AudioCallback;

	// Open audio device
	s_audio_device = SDL_OpenAudioDevice(nullptr, 0, &s_wanted_spec, nullptr, SDL_AUDIO_ALLOW_SAMPLES_CHANGE);
	Dbg_Assert(s_audio_device > 0);

	// Start audio
	SDL_PauseAudioDevice(s_audio_device, 0);
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
	SDL_LockAudioDevice(s_audio_device);
	if (decoder != nullptr)
	{
		delete decoder;
		decoder = nullptr;
	}
	SDL_UnlockAudioDevice(s_audio_device);
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void PCMAudio_StopStream( int whichStream, bool waitPlease )
{
	(void)whichStream;
	(void)waitPlease;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void PCMAudio_StopStreams( void )
{
	
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
	(void)checksum;
	(void)whichStream;
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
	return true;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool PCMAudio_PreLoadMusicStream( uint32 checksum )
{
	(void)checksum;
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
	return true;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
int PCMAudio_GetMusicStatus( void )
{
	if (decoder == nullptr)
		return PCM_STATUS_FREE;
	else if (decoder->IsPlaying())
		return PCM_STATUS_PLAYING;
	else
		return PCM_STATUS_FREE;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
int PCMAudio_GetStreamStatus( int whichStream )
{
	(void)whichStream;
	return PCM_STATUS_PLAYING;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void PCMAudio_Pause( bool pause, int ch )
{
	(void)pause;
	(void)ch;

	SDL_LockAudioDevice(s_audio_device);
	if (ch == MUSIC_CHANNEL)
	{
		if (decoder != nullptr)
		{
			if (pause)
				decoder->Pause();
			else
				decoder->Resume();
		}
	}
	SDL_UnlockAudioDevice(s_audio_device);
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
	(void)checksum;
	(void)ch;
	return 0;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool PCMAudio_SetStreamVolume( Sfx::sVolume *p_volume, int whichStream )
{
	(void)p_volume;
	(void)whichStream;
	return true;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
int PCMAudio_SetMusicVolume( float volume )
{
	(void)volume;
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
	return false;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool PCMAudio_PlayMusicTrack( const char *filename )
{
	// Play song
	SDL_LockAudioDevice(s_audio_device);
	if (decoder != nullptr)
		delete decoder;
	std::string name = std::string(filename) + ".flac";
	decoder = new MusicDecoder(name.c_str());
	SDL_UnlockAudioDevice(s_audio_device);
	return true;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool PCMAudio_PlaySoundtrackMusicTrack( int soundtrack, int track )
{
	// Play song
	SDL_LockAudioDevice(s_audio_device);
	if (decoder != nullptr)
		delete decoder;
	const UserSoundtrack::Soundtracks &soundtracks = UserSoundtrack::GetSoundtracks();
	std::string name = soundtracks.at(soundtrack).tracks.at(track).path.string();
	decoder = new MusicDecoder(name.c_str());
	SDL_UnlockAudioDevice(s_audio_device);
	return true;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool PCMAudio_StartStream( int whichStream )
{
	(void)whichStream;
	return true;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool PCMAudio_PlayStream( uint32 checksum, int whichStream, Sfx::sVolume *p_volume, float fPitch, bool preload )
{
	(void)checksum;
	(void)whichStream;
	(void)p_volume;
	(void)fPitch;
	(void)preload;
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
