#include "texturedecode.h"

namespace TextureDecode
{
	// 32-bit texture write to .bmp
	void WriteToBmp(const char *sign, uint8 *out, size_t width, size_t height)
	{
		// Open file
		static char buf[512];
		static int i = 0;
		sprintf(buf, "out%d%s.tga", i++, sign);

		for (char *p = buf; *p != '\0'; p++)
			if (*p == '/' || *p == '\\')
				*p = '_';

		FILE *fp = fopen(buf, "wb");

		// Write header
		uint8_t header[18] = { 0,0,2,0,0,0,0,0,0,0,0,0, (uint8_t)(width % 256), (uint8_t)(width / 256), (uint8_t)(height % 256), (uint8_t)(height / 256), 32, 0x20 };
		fwrite(&header, 18, 1, fp);

		for (size_t i = 0; i < width * height * 4; i += 4)
		{
			fputc(out[2], fp);
			fputc(out[1], fp);
			fputc(out[0], fp);
			fputc(out[3], fp);
			out += 4;
		}

		fclose(fp);
	}

	// Texture unswizzler
	void Swizzle_Decode(const uint8 *source, uint8 *out, size_t width, size_t height)
	{
		
	}

	// DXT1 decode
	static void DXT1_DecodeBlock(const uint8 *source, uint8 *out, size_t pitch)
	{
		// Get the two base colors
		uint16 c0 = ((uint16)source[0] << 0) | ((uint16)source[1] << 8);
		uint16 c1 = ((uint16)source[2] << 0) | ((uint16)source[3] << 8);
		source += 4;

		// Promote to RGB
		uint8_t c[4][4];

		c[0][0] = ((c0 >> 11) & 0x1F) * 0xFF / 0x1F;
		c[0][1] = ((c0 >> 5) & 0x3F) * 0xFF / 0x3F;
		c[0][2] = ((c0 >> 0) & 0x1F) * 0xFF / 0x1F;
		c[0][3] = 0xFF;

		c[1][0] = ((c1 >> 11) & 0x1F) * 0xFF / 0x1F;
		c[1][1] = ((c1 >> 5) & 0x3F) * 0xFF / 0x3F;
		c[1][2] = ((c1 >> 0) & 0x1F) * 0xFF / 0x1F;
		c[1][3] = 0xFF;

		// Get blend colors
		if (c0 > c1)
		{
			// Four-color block
			c[2][0] = ((uint16)c[0][0] * 2 + c[1][0]) / 3;
			c[2][1] = ((uint16)c[0][1] * 2 + c[1][1]) / 3;
			c[2][2] = ((uint16)c[0][2] * 2 + c[1][2]) / 3;
			c[2][3] = 0xFF;

			c[3][0] = ((uint16)c[1][0] * 2 + c[0][0]) / 3;
			c[3][1] = ((uint16)c[1][1] * 2 + c[0][1]) / 3;
			c[3][2] = ((uint16)c[1][2] * 2 + c[0][2]) / 3;
			c[3][3] = 0xFF;
		}
		else
		{
			// Three-color block
			c[2][0] = ((uint16)c[0][0] + c[1][0]) / 2;
			c[2][1] = ((uint16)c[0][1] + c[1][1]) / 2;
			c[2][2] = ((uint16)c[0][2] + c[1][2]) / 2;
			c[2][3] = 0xFF;

			c[3][0] = 0x00;
			c[3][1] = 0x00;
			c[3][2] = 0x00;
			c[3][3] = 0x00;
		}

		// Write colors
		for (int y = 0; y < 4; y++)
		{
			int code = *source++;
			for (int i = 0; i < 4; i++)
			{
				int bit = code & 0x03;
				*out++ = c[bit][0];
				*out++ = c[bit][1];
				*out++ = c[bit][2];
				*out++ = c[bit][3];
				code >>= 2;
			}
			out += pitch - (4 * 4);
		}
	}

	void DXT1_Decode(const uint8 *source, uint8 *out, size_t width, size_t height)
	{
		// Decode blocks
		for (size_t y = 0; y < height; y += 4)
		{
			for (size_t x = 0; x < width; x += 4)
			{
				DXT1_DecodeBlock(source, out, width * 4);
				source += 8;
				out += 4 * 4;
			}
			out += width * 4 * 3;
		}
	}

	// DXT5 decode
	static void DXT5_DecodeBlock(const uint8 *source, uint8 *out, size_t pitch)
	{
		// Get the base colors and alphas
		uint8_t a[8];
		a[0] = source[0];
		a[1] = source[1];
		unsigned long long ac = ((unsigned long long)source[2] << 0) | ((unsigned long long)source[3] << 8) | ((unsigned long long)source[4] << 16) |
			((unsigned long long)source[5] << 24) | ((unsigned long long)source[6] << 32) | ((unsigned long long)source[7] << 40);

		uint16 c0 = ((uint16)source[8] << 0) | ((uint16)source[9] << 8);
		uint16 c1 = ((uint16)source[10] << 0) | ((uint16)source[11] << 8);
		source += 12;

		// Promote to RGB
		uint8_t c[4][3];

		c[0][0] = ((c0 >> 11) & 0x1F) * 0xFF / 0x1F;
		c[0][1] = ((c0 >> 5) & 0x3F) * 0xFF / 0x3F;
		c[0][2] = ((c0 >> 0) & 0x1F) * 0xFF / 0x1F;

		c[1][0] = ((c1 >> 11) & 0x1F) * 0xFF / 0x1F;
		c[1][1] = ((c1 >> 5) & 0x3F) * 0xFF / 0x3F;
		c[1][2] = ((c1 >> 0) & 0x1F) * 0xFF / 0x1F;

		// Four-color block
		c[2][0] = ((uint16)c[0][0] * 2 + c[1][0]) / 3;
		c[2][1] = ((uint16)c[0][1] * 2 + c[1][1]) / 3;
		c[2][2] = ((uint16)c[0][2] * 2 + c[1][2]) / 3;

		c[3][0] = ((uint16)c[1][0] * 2 + c[0][0]) / 3;
		c[3][1] = ((uint16)c[1][1] * 2 + c[0][1]) / 3;
		c[3][2] = ((uint16)c[1][2] * 2 + c[0][2]) / 3;

		// Calculate derived alphas
		a[2] = ((sint16)a[0] + ((sint16)a[1] - (sint16)a[0]) * 1 / 7);
		a[3] = ((sint16)a[0] + ((sint16)a[1] - (sint16)a[0]) * 2 / 7);
		a[4] = ((sint16)a[0] + ((sint16)a[1] - (sint16)a[0]) * 3 / 7);
		a[5] = ((sint16)a[0] + ((sint16)a[1] - (sint16)a[0]) * 4 / 7);
		a[6] = ((sint16)a[0] + ((sint16)a[1] - (sint16)a[0]) * 5 / 7);
		a[7] = ((sint16)a[0] + ((sint16)a[1] - (sint16)a[0]) * 6 / 7);

		// Write colors
		for (int y = 0; y < 4; y++)
		{
			int code = *source++;
			for (int i = 0; i < 4; i++)
			{
				int bit = code & 0x03;
				*out++ = c[bit][0];
				*out++ = c[bit][1];
				*out++ = c[bit][2];
				*out++ = a[ac & 0x07];
				ac >>= 3;
				code >>= 2;
			}
			out += pitch - (4 * 4);
		}
	}

	void DXT5_Decode(const uint8 *source, uint8 *out, size_t width, size_t height)
	{
		// Decode blocks
		for (size_t y = 0; y < height; y += 4)
		{
			for (size_t x = 0; x < width; x += 4)
			{
				DXT5_DecodeBlock(source, out, width * 4);
				source += 16;
				out += 4 * 4;
			}
			out += width * 4 * 3;
		}
	}

	// Palette decode
	void Pal_Decode(const uint8 *source, const uint8 *pal, uint8 *out, size_t width, size_t height)
	{
		for (size_t i = 0; i < width * height; i++)
		{
			const uint8 *palp = pal + *source++ * 4;
			out[0] = palp[2]; // NOTE: reading in the order of D3DCOLOR, which is ARGB little-endian
			out[1] = palp[1];
			out[2] = palp[0];
			out[3] = palp[3];
			out += 4;
		}
	}

	// Short decode
	void Short_Decode(const uint8 *source, uint8 *out, size_t width, size_t height)
	{
		for (size_t i = 0; i < width * height; i++)
		{
			uint16 c = ((uint16)source[0] << 0) | ((uint16)source[1] << 8);
			source += 2;
			out[0] = ((c >> 10) & 0x1F) * 0xFF / 0x1F;
			out[1] = ((c >> 5) & 0x1F) * 0xFF / 0x1F;
			out[2] = ((c >> 0) & 0x1F) * 0xFF / 0x1F;
			out[3] = (c & 0x8000) ? 0xFF : 0x00;
			out += 4;
		}
	}

	// Long decode
	void Long_Decode(const uint8 *source, uint8 *out, size_t width, size_t height)
	{
		for (size_t i = 0; i < width * height; i++)
		{
			out[0] = source[2];
			out[1] = source[1];
			out[2] = source[0];
			out[3] = source[3];
			source += 4;
			out += 4;
		}
	}

	// PS2 decode
	void Ps2_Decode(const uint8 *source, uint8 *out, size_t width, size_t height)
	{
		for (size_t i = 0; i < width * height; i++)
		{
			uint16 c = ((uint16)source[0] << 0) | ((uint16)source[1] << 8);
			source += 2;
			out[0] = ((c >> 0) & 0x1F) * 0xFF / 0x1F;
			out[1] = ((c >> 5) & 0x1F) * 0xFF / 0x1F;
			out[2] = ((c >> 10) & 0x1F) * 0xFF / 0x1F;
			out[3] = (c & 0x8000) ? 0xFF : 0x00;
			out += 4;
		}
	}

} // namespace TextureDecode
