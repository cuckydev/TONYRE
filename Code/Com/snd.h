#pragma once

#include "ima.h"

#include <memory>

namespace Snd
{
	class Sound
	{
		private:
			// IMA state
			IMA::IMA ima;

			// Sound state
			bool playing = false;
			bool paused = false;

			unsigned long frequency = 0;
			unsigned long coord = 0, step = 0;
			signed short sample_a = 0, sample_b = 0;

			float Fetch()
			{
				// Check if stopped or paused
				if (!playing || paused)
					return 0.0f;

				// Increment coordinate
				coord += step;
				while (coord >= 0x10000)
				{
					// Check if at end
					if (ima.AtEnd())
					{
						playing = false;
						return 0.0f;
					}

					// Fetch new sample
					sample_a = sample_b;
					sample_b = ima.Fetch();

					// Update coordinate
					coord -= 0x10000;
				}

				// Interpolate
				signed long sample = sample_a + (((unsigned long long)coord * (sample_b - sample_a)) >> 16);
				return (float)sample / (float)0x8000;
			}

			float volume[5] = { 1.0f, 1.0f, 1.0f, 1.0f, 1.0f };

		public:
			// Constructor
			Sound() {}
			Sound(unsigned char *_data, size_t _size, unsigned long _frequency)
			{
				// Setup stream
				SetPointer(_data, _size, _frequency);
			}

			void SetPointer(unsigned char *_data, size_t _size, unsigned long _frequency)
			{
				// Setup IMA stream
				ima.SetPointer(_data, _size);

				// Setup sound stream
				coord = 0;
				sample_a = ima.Fetch();
				sample_b = ima.Fetch();

				// Setup frequency
				frequency = _frequency;
			}

			void Rewind()
			{
				// Rewind stream
				ima.Rewind();

				// Setup sound stream
				coord = 0;
				sample_a = ima.Fetch();
				sample_b = ima.Fetch();
			}

			void Play()
			{
				// Start playing
				playing = true;
				paused = false;
			}

			void Pause()
			{
				// Toggle paused
				paused = true;
			}

			void Stop()
			{
				// Stop playing
				Rewind();
				playing = false;
			}

			bool IsPlaying()
			{
				// Return playing state
				return playing;
			}

			bool IsPaused()
			{
				// Return paused state
				return paused;
			}

			void SetVolume(float *coef)
			{
				// Set volume
				volume[0] = coef[0];
				volume[1] = coef[1];
				volume[2] = coef[2];
				volume[3] = coef[3];
				volume[4] = coef[4];
			}

			void SetPitch(float pitch)
			{
				// Set pitch
				step = (unsigned long)((pitch / 100.0f) * (float)frequency / (float)48000 * (float)0x10000);
			}

			void Mix(char *buffer, size_t bytes)
			{
				// Check if playing
				if (!playing || paused)
					return;

				// Mix sound
				float *out = (float*)buffer;
				for (size_t i = 0; i < bytes / (sizeof(float) * 5); i++)
				{
					float sample = Fetch();
					for (size_t c = 0; c < 5; c++)
						*out++ += sample * volume[c];
				}
			}
	};
}
