#pragma once

#include <core/defines.h>

namespace TextureDecode
{
	// Texture decoding
	void DXT1_Decode(const uint8 *source, uint8 *out, size_t width, size_t height);
	void DXT5_Decode(const uint8 *source, uint8 *out, size_t width, size_t height);
	void Pal_Decode(const uint8 *source, const uint8 *pal, uint8 *out, size_t width, size_t height);
	void Short_Decode(const uint8 *source, uint8 *out, size_t width, size_t height);
	void Long_Decode(const uint8 *source, uint8 *out, size_t width, size_t height);
}
