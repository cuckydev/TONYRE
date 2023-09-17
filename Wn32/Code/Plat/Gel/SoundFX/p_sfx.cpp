#include <Core/macros.h>
#include <Sys/File/filesys.h>
#include <Gel/SoundFX/soundfx.h>
#include <Gel/Music/music.h>

#include "p_sfx.h"

#include <Plat/Audio/Mixer.h>

#include <Com/snd.h>

#include <memory>

namespace Sfx
{
	// Volume constants
	static constexpr float SOUND_VOLUME = 0.5f; // PC sounds are much too loud

	// Sfx volume percentage
	float gSfxVolume = 100.0f;

	// Sound class
	class CXBSound
	{
		public:
			std::unique_ptr<unsigned char[]> data;
			size_t size = 0;

			struct BlockHeader
			{
				uint32 id;
				uint32 size;
			};

			struct RIFFHeader
			{
				BlockHeader header;
				uint32 id;
			};

			struct Format
			{
				uint16 format;
				uint16 channels;
				uint32 sample_rate;
				uint32 bytes_per_second;
				uint16 block_align;
				uint16 bits_per_sample;
			} format = {};
			bool looping = false;

			CXBSound(void *fp)
			{
				// Read RIFF header
				RIFFHeader riff_header;
				if (File::Read(&riff_header, sizeof(RIFFHeader), 1, fp) != sizeof(RIFFHeader))
				{
					Dbg_MsgAssert(0, ("Invalid RIFF header"));
				}
				Dbg_MsgAssert(riff_header.header.id == 'FFIR', ("Invalid RIFF header"));
				Dbg_MsgAssert(riff_header.id == 'EVAW', ("Invalid RIFF header"));

				// Read headers
				while (1)
				{
					BlockHeader header;
					if (File::Read(&header, sizeof(BlockHeader), 1, fp) != sizeof(BlockHeader))
						break;

					switch (header.id)
					{
						case ' tmf':
						{
							// Read format
							if (header.size < sizeof(Format))
							{
								// Header size is smaller than required
								Dbg_MsgAssert(0, ("Invalid format header"));
							}
							else
							{
								// Read format header
								// Some sounds have larger format blocks, so we need to account for that here
								if (File::Read(&format, sizeof(Format), 1, fp) != sizeof(Format))
								{
									Dbg_MsgAssert(0, ("Failed to read format header"));
								}
								File::Seek(fp, header.size - sizeof(Format), SEEK_CUR);
							}
							break;
						}
						case 'atad':
						{
							// Read data
							size = header.size;
							data = std::make_unique<unsigned char[]>(size);
							File::Read(data.get(), size, 1, fp);
							break;
						}
						case 'lpms':
						{
							// Read loop data
							if (header.size >= (0x1C + 0x4))
							{
								// Read DWORD at 0x1C
								File::Seek(fp, 0x1C, SEEK_CUR);

								uint32 smpl_loops = 0;
								File::Read(&smpl_loops, sizeof(uint32), 1, fp);
								if (smpl_loops)
									looping = true;

								// Skip rest of block
								File::Seek(fp, header.size - (0x1C + 0x4), SEEK_CUR);
							}
							else
							{
								// Skip block
								File::Seek(fp, header.size, SEEK_CUR);
							}
							break;
						}
						default:
						{
							// Skip unknown block
							File::Seek(fp, header.size, SEEK_CUR);
							break;
						}
					}
				}

				// Verify file was read
				Dbg_AssertPtr(data);
			}
	};

	// Mixer
	static Snd::Sound sounds[NUM_VOICES] = {};

	void MixSoundFX(char *buffer, size_t size)
	{
		// Mix sounds
		for (auto &i : sounds)
			i.Mix(buffer, size);
	}

	// Get free voice index
	static int getFreeVoice(void)
	{
		// Look for a sound that is not playing
		for (size_t i = 0; i < NUM_VOICES; i++)
		{
			if (!sounds[i].IsPlaying())
				return i;
		}
		return -1;
	}

	// Sound API
	void InitSoundFX(CSfxManager *p_sfx_manager)
	{
		// Initialize mixer
		Audio::Init();
	}

	void CleanUpSoundFX(void)
	{
		// This just resets the SPU RAM pointer on the PS2. However, on Xbox it needs to explicitly
		// delete any sounds that were not marked as permanent at load time.
		StopAllSoundFX();
		SetReverbPlease(0);

		for (int i = 0; i < NumWavesInTable; ++i)
		{
			PlatformWaveInfo *p_info = &(WaveTable[PERM_WAVE_TABLE_MAX_ENTRIES + i].platformWaveInfo);
			Dbg_Assert(p_info->p_sound_data);
			delete p_info->p_sound_data;
			p_info->p_sound_data = nullptr;
		}
		NumWavesInTable = 0;
	}

	void StopAllSoundFX(void)
	{
		Pcm::StopMusic();
		Pcm::StopStreams();

		for (size_t i = 0; i < NUM_VOICES; i++)
			StopSoundPlease(i);
	}

	int GetMemAvailable(void)
	{
		return 0;
	}

	bool LoadSoundPlease(const char *sfxName, uint32 checksum, PlatformWaveInfo *pInfo, bool loadPerm)
	{
		Dbg_Assert(pInfo);

		// Open sound file
		std::string sound_name = "sounds/" + std::string(sfxName) + ".snd";
		void *fp = File::Open(sound_name.c_str(), "rb");
		if (!fp)
			return false;

		// Create sound
		pInfo->p_sound_data = new CXBSound(fp);
		File::Close(fp);

		pInfo->looping = pInfo->p_sound_data->looping;
		pInfo->permanent = loadPerm;

		return true;
	}

	//int	PlaySoundPlease( PlatformWaveInfo *pInfo, float volL, float volR, float pitch )
	int	PlaySoundPlease(PlatformWaveInfo *pInfo, sVolume *p_vol, float pitch)
	{
		Dbg_Assert(pInfo);

		Audio::Lock();

		// Get free voice
		int voice = getFreeVoice();
		if (voice < 0)
		{
			Audio::Unlock();
			return -1;
		}

		// Setup sound
		Snd::Sound *sound = &sounds[voice];

		sound->SetPointer(pInfo->p_sound_data->data.get(), pInfo->p_sound_data->size, pInfo->p_sound_data->format.sample_rate);
		sound->Play();
		sound->SetLooping(pInfo->p_sound_data->looping);

		SetVoiceParameters(voice, p_vol, pitch);

		Audio::Unlock();
		return voice;
	}

	void StopSoundPlease(int voice)
	{
		Audio::Lock();
		sounds[voice].Stop();
		Audio::Unlock();
	}

	void SetVolumePlease(float volumeLevel)
	{
		gSfxVolume = volumeLevel;
	}

	void PauseSoundsPlease(void)
	{
		sVolume vol;
		vol.SetSilent();

		// Just turn the volume down on all playing voices...
		for (size_t i = 0; i < NUM_VOICES; i++)
		{
			if (VoiceIsOn(i))
				SetVoiceParameters(i, &vol);
		}
	}

	void SetReverbPlease(float reverbLevel, int reverbMode, bool instant)
	{
		if (reverbMode == 0)
		{
			// Default to plain.
			reverbMode = 20;
		}
		reverbMode = 20;
	}

	bool VoiceIsOn(int voice)
	{
		Audio::Lock();
		bool playing = sounds[voice].IsPlaying();
		Audio::Unlock();
		return playing;
	}

	//void SetVoiceParameters( int voice, float volL, float volR, float pitch )
	void SetVoiceParameters(int voice, sVolume *p_vol, float pitch)
	{
		Audio::Lock();

		// Setup sound
		Snd::Sound *sound = &sounds[voice];

		// Set pitch
		sound->SetPitch(pitch);

		// Get volume coefficients
		float coefs[5] = {};

		if (!p_vol->IsSilent())
		{
			switch (p_vol->GetVolumeType())
			{
				case VOLUME_TYPE_5_CHANNEL_DOLBY5_1:
				{
					coefs[0] = p_vol->GetChannelVolume(0);
					coefs[1] = p_vol->GetChannelVolume(1);
					coefs[2] = p_vol->GetChannelVolume(4);
					coefs[3] = p_vol->GetChannelVolume(2);
					coefs[4] = p_vol->GetChannelVolume(3);
					break;
				}
				case VOLUME_TYPE_BASIC_2_CHANNEL:
				{
					coefs[0] = p_vol->GetChannelVolume(0);
					coefs[1] = p_vol->GetChannelVolume(1);
					coefs[2] = (p_vol->GetChannelVolume(0) + p_vol->GetChannelVolume(1)) * 0.5f;
					coefs[3] = p_vol->GetChannelVolume(0) * 0.5f;
					coefs[4] = p_vol->GetChannelVolume(1) * 0.5f;
					break;
				}
				case VOLUME_TYPE_2_CHANNEL_DOLBYII:
				{
					Dbg_Assert(0);
					break;
				}
			}
		}

		// Adjust for volume setting
		for (int i = 0; i < 5; i++)
		{
			coefs[i] = (coefs[i] / 100.0f) * (gSfxVolume / 100.0f);
			if (coefs[i] > 1.0f)
				coefs[i] = 1.0f;
			coefs[i] *= SOUND_VOLUME;
		}

		// Set volume
		sound->SetVolume(coefs);

		Audio::Unlock();
	}

	void PerFrameUpdate(void)
	{
		
	}
} // namespace Sfx
