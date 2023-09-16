#include "Mixer.h"

#include <SDL.h>

#include <Plat/Gel/SoundFX/p_sfx.h>
#include <Plat/Gel/Music/p_music.h>

namespace Audio
{
	// Audio device
	static SDL_AudioDeviceID s_audio_device = 0;

	// Audio callback
	void AudioCallback(void *userdata, Uint8 *stream, int len)
	{
		(void)userdata;

		// Clear the stream
		std::fill((float*)stream, (float*)(stream + len), 0.0f);

		// Mix music
		Pcm::PCMAudio_Mix((char*)stream, len);

		// Mix sound effects
		Sfx::MixSoundFX((char*)stream, len);
	}

	// Mixer API
	void Init()
	{
		// Check if audio is already initialised
		if (s_audio_device != 0)
			return;

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

	void Lock()
	{
		// Lock audio device
		SDL_LockAudioDevice(s_audio_device);
	}

	void Unlock()
	{
		// Unlock audio device
		SDL_UnlockAudioDevice(s_audio_device);
	}
}
