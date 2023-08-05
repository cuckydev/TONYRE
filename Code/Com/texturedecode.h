#pragma once

#include <core/defines.h>

namespace TextureDecode
{
	// Texture decoding
	void WriteToBmp(const char *sign, uint8 *out, size_t width, size_t height);
	void DXT1_Decode(const uint8 *source, uint8 *out, size_t width, size_t height);
	void DXT5_Decode(const uint8 *source, uint8 *out, size_t width, size_t height);
	void Pal_Decode(const uint8 *source, const uint8 *pal, uint8 *out, size_t width, size_t height);
	void Short_Decode(const uint8 *source, uint8 *out, size_t width, size_t height);
	void Long_Decode(const uint8 *source, uint8 *out, size_t width, size_t height);
	void Ps2_Decode(const uint8 *source, uint8 *out, size_t width, size_t height);
}
