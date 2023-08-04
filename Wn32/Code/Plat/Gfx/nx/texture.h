#ifndef __TEXTURE_H
#define __TEXTURE_H

#include "nx_init.h"

#include <core/HashTable.h>

namespace NxWn32
{

struct sTexture
{
						sTexture();
						~sTexture();
						
	bool				SetRenderTarget( int width, int height, int depth, int z_depth );
	void				Set( int pass );

	uint32				Checksum;
	uint16				BaseWidth, BaseHeight;		// The size of the D3D texture (will be power of 2).
	uint16				ActualWidth, ActualHeight;	// The size of the texture itself (may not be power of 2).

	uint8				Levels;
	uint8				TexelDepth;
	uint8				PaletteDepth;
	uint8				DXT;

	GLuint GLTexture;
};

sTexture	*LoadTexture( const char *p_filename );

} // namespace NxWn32

#endif // __TEXTURE_H

