#ifndef __TEXTURE_H
#define __TEXTURE_H

#include "nx_init.h"

#include <Core/HashTable.h>

namespace NxWn32
{

struct sTexture
{
	sTexture();
	~sTexture();
	
	bool SetRenderTarget( int width, int height, int depth, int z_depth );
	void Set( int pass );

	void Upload();

	uint32 Checksum;

	uint16 BaseWidth, BaseHeight;		// The size of the D3D texture (will be power of 2).
	uint16 ActualWidth, ActualHeight;	// The size of the texture itself (may not be power of 2).
	uint8 Levels;

	size_t GetDataSize() const
	{
		size_t base_width = BaseWidth;
		size_t base_height = BaseHeight;

		size_t size = 0;
		for (uint8 mip_level = 0; mip_level < Levels; mip_level++)
		{
			size += (base_width * base_height * 4);
			base_width >>= 1;
			base_height >>= 1;
		}

		return size;
	}

	uint8 TexelDepth;
	uint8 PaletteDepth;
	uint8 DXT;

	GLuint GLTexture = 0;
	uint8 *Data = nullptr;
};

sTexture *LoadTexture( const char *p_filename );

} // namespace NxWn32

#endif // __TEXTURE_H

