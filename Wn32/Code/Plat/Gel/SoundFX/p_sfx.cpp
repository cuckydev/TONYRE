#include <Core/macros.h>
#include <Sys/File/filesys.h>
#include <Gel/SoundFX/soundfx.h>
#include <Gel/Music/music.h>

#include "p_sfx.h"

namespace Sfx
{

	// Sfx volume percentage
	float gSfxVolume = 100.0f;

	// Get free voice index
	static int getFreeVoice(void)
	{
		return -1;
	}

	// Sound API
	void InitSoundFX(CSfxManager *p_sfx_manager)
	{
		
	}

	void CleanUpSoundFX(void)
	{
		// This just resets the SPU RAM pointer on the PS2. However, on Xbox it needs to explicitly
		// delete any sounds that were not marked as permanent at load time.
		
	}

	void StopAllSoundFX(void)
	{
		Pcm::StopMusic();
		Pcm::StopStreams();

		for (int i = 0; i < NUM_VOICES; ++i)
		{
			StopSoundPlease(i);
		}
	}

	int GetMemAvailable(void)
	{
		return 0;
	}

	bool LoadSoundPlease(const char *sfxName, uint32 checksum, PlatformWaveInfo *pInfo, bool loadPerm)
	{
		Dbg_Assert(pInfo);

		return true;
	}

	//int	PlaySoundPlease( PlatformWaveInfo *pInfo, float volL, float volR, float pitch )
	int	PlaySoundPlease(PlatformWaveInfo *pInfo, sVolume *p_vol, float pitch)
	{
		Dbg_Assert(pInfo);

		return -1;
	}

	void StopSoundPlease(int voice)
	{
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
		for (int i = 0; i < NUM_VOICES; i++)
		{
			if (VoiceIsOn(i))
			{
	//			SetVoiceParameters( i, 0.0f, 0.0f );
				SetVoiceParameters(i, &vol);
			}
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
		return false;
	}

	//void SetVoiceParameters( int voice, float volL, float volR, float pitch )
	void SetVoiceParameters(int voice, sVolume *p_vol, float pitch)
	{
		
	}

	void PerFrameUpdate(void)
	{
		
	}
} // namespace Sfx
