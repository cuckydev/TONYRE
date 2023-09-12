#pragma once

#include <Core/Defines.h>

#include <miniaudio.h>

namespace Audio
{
	// Mixer API
	void Init();

	void Lock();
	void Unlock();
}
