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

		for (size_t j = 0; j < width * height * 4; j += 4)
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
		size_t i;
		size_t swizzle_w;
		size_t swizzle_s;
		size_t swizzle_x;
		size_t x;
		size_t y;
		size_t twiddle_i;
		size_t swizzle_h;
		size_t chars;
		size_t swizzle_y;
		size_t swizzle_z;

		i = 0;
		chars = height * width;
		if (chars == 0)
			return;
		swizzle_w = width >> 1;
		swizzle_s = height >> 1;
		swizzle_h = height >> 1;
		while (1)
		{
			swizzle_x = 1;
			swizzle_z = swizzle_w;
			x = 0;
			y = 0;
			swizzle_y = 1;
			twiddle_i = 1;
			while (swizzle_z)
			{
				swizzle_z >>= 1;
				if ((twiddle_i & i) != 0)
					x |= swizzle_x;
				swizzle_x <<= 1;
				twiddle_i <<= 1;
				if (swizzle_s)
				{
					SwizzleS:
					swizzle_s >>= 1;
					if ((twiddle_i & i) != 0)
						y |= swizzle_y;
					swizzle_y <<= 1;
					twiddle_i <<= 1;
				}
			}
			if (swizzle_s)
				goto SwizzleS;

			uint8 *outp = &out[4 * (x + width * y)];
			outp[0] = source[0];
			outp[1] = source[1];
			outp[2] = source[2];
			outp[3] = source[3];
			source += 4;

			++i;
			if (i < chars)
			{
				swizzle_w = width >> 1;
				swizzle_s = swizzle_h;
				continue;
			}
			return;
		}
	}

	// DXT1 decode
	static void DXT1_DecodeBlock(const uint8 *source, uint8 *out, size_t pitch)
	{
		// Get the two base colors
		uint16 c0 = ((uint16)source[0] << 0) | ((uint16)source[1] << 8);
		uint16 c1 = ((uint16)source[2] << 0) | ((uint16)source[3] << 8);
		source += 4;

		// Promote to RGB
		uint8 c[4][4];

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
		uint8 a[8];
		a[0] = source[0];
		a[1] = source[1];
		unsigned long long ac = ((unsigned long long)source[2] << 0) | ((unsigned long long)source[3] << 8) | ((unsigned long long)source[4] << 16) |
			((unsigned long long)source[5] << 24) | ((unsigned long long)source[6] << 32) | ((unsigned long long)source[7] << 40);

		uint16 c0 = ((uint16)source[8] << 0) | ((uint16)source[9] << 8);
		uint16 c1 = ((uint16)source[10] << 0) | ((uint16)source[11] << 8);
		source += 12;

		// Promote to RGB
		uint8 c[4][3];

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
		if (a[1] > a[0])
		{
			for (int i = 2; i < 6; i++)
				a[i] = ((6 - i) * (uint16)a[0] + (i - 1) * (uint16)a[1]) / 5;
			a[6] = 0x00;
			a[7] = 0xFF;
		}
		else
		{
			for (int i = 2; i < 8; i++)
				a[i] = ((8 - i) * (uint16)a[0] + (i - 1) * (uint16)a[1]) / 7;
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
