#include <string.h>
#include <core/defines.h>
#include <core/debug.h>
#include <stdio.h>
#include <stdlib.h>
#include <sys/file/filesys.h>
#include "nx_init.h"
#include "chars.h"
#include "texture.h"
#include "render.h"

#include "Com/texturedecode.h"

namespace NxWn32
{


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
sTexture::sTexture()
{
	GLTexture = 0;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
sTexture::~sTexture()
{
	// Delete texture
	glDeleteTextures(1, &GLTexture);
	/*
	ULONG rr;

	if( pD3DTexture )
	{
		rr = pD3DTexture->Release();
		Dbg_Assert( rr == 0 );

		// Ensure that this texture is no longer referenced in the EngineGlobals.
		for( int p = 0; p < 4; ++p )
		{
			if( EngineGlobals.p_texture[p] == pD3DTexture )
			{
				set_texture( p, nullptr );
			}
		}
	}
	if( pD3DPalette )
	{
		rr = pD3DPalette->Release();
		Dbg_Assert( rr == 0 );
	}
	if( pD3DSurface )
	{
		rr = pD3DSurface->Release();
		Dbg_Assert( rr == 0 );
	}
	*/
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void sTexture::Set( int pass )
{
	// Set this texture as the active texture for a specific pass.
	// set_texture( pass, pD3DTexture, pD3DPalette );
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool sTexture::SetRenderTarget( int width, int height, int depth, int z_depth )
{
	/*
	HRESULT		hr;
	
	if( pD3DTexture )
	{
		pD3DTexture->Release();
	}
	if( pD3DPalette )
	{
		pD3DPalette->Release();
	}

	// Create the shadow buffer (essentially just a depth buffer).
	hr = D3DDevice_CreateTexture( width, height, 1, 0, D3DFMT_LIN_D24S8, 0, &pD3DTexture );
	Dbg_Assert( hr == D3D_OK );
	if( hr == D3D_OK )
	{
		// Set fields to reflect surface characteristics.
		Checksum		= 0;
		BaseWidth		= ActualWidth	= width;
		BaseHeight		= ActualHeight	= height;
		Levels			= 1;
		TexelDepth		= depth;
		PaletteDepth	= 0;
		DXT				= 0;
		return true;
	}
	*/
	return false;
}



// Eeeek - the .img contains PS2 specific register values for bit depth.
// Use these values to convert them.
#define PSMCT32		0x00
#define PSMCT24		0x01
#define PSMCT16		0x02
#define PSMCT16S	0x0A
#define PS_GPU24	0x12
#define PSMT8		0x13
#define PSMT4		0x14
#define PSMT8H		0x1B
#define PSMT4HL		0x24
#define PSMT4HH		0x2C
#define PSMZ32		0x30
#define PSMZ24		0x31
#define PSMZ16		0x32
#define PSMZ16S		0x3A



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
static bool is_power_of_two( uint32 a )
{
	if( a == 0 )
	{
		return false;
	}
	return (( a & ( a - 1 )) == 0 );
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
sTexture *LoadTexture( const char *p_filename )
{
	struct sIMGHeader
	{
		uint32	version;
		uint32	checksum;
		uint32	width;
		uint32	height;
		uint32	bit_depth;
		uint32	clut_bit_depth;
		uint16	original_width;
		uint16	original_height;
		uint32	palette_data_size;
	};

	void *p_FH = File::Open( p_filename, "rb" );
	
	if( p_FH )
	{
		// Read header.
		sIMGHeader header;
		File::Read( &header, sizeof( sIMGHeader ), 1, p_FH );
		
		// Bits per texel and palette size.
		switch( header.bit_depth )
		{
			case PSMCT32:
				header.bit_depth = 32;
				break;
			case PSMCT16:
				header.bit_depth = 16;
				break;
			case PSMT8:
				header.bit_depth = 8;
				break;
			default:
				Dbg_Assert( 0 );
		}

		// Bits per clut entry.
		if(	header.bit_depth < 16 )
		{
			switch( header.clut_bit_depth )
			{
				case PSMCT32:
					header.clut_bit_depth = 32;
					break;
				default:
					Dbg_Assert( 0 );
			}
		}
		else
		{
			header.clut_bit_depth = 0;
		}
		
		{
			// Create the texture object.
			sTexture *p_texture = new sTexture();

			// Create palette if required
			uint8 pal[256][4] = {};
			if( header.clut_bit_depth > 0 )
			{
				// Read clut bitmap data.
				Dbg_Assert(header.palette_data_size <= sizeof( pal ));
				int len	= File::Read( pal, header.palette_data_size, 1, p_FH );
				Dbg_MsgAssert( len == header.palette_data_size, ( "Couldn't read clut from texture file %s", p_filename ));
			}

			// Read texture bitmap data
			size_t num_bytes = (((header.bit_depth / 8) * (header.width) * (header.height)) + 3) & 0xFFFFFFFC;
			uint8 *source_data = new uint8[num_bytes];
			int len = File::Read(source_data, num_bytes, 1, p_FH);
			Dbg_MsgAssert(len == num_bytes, ("couldn't read texture data from texture file %s", p_filename));
			File::Close(p_FH);

			// Convert to 32 bit
			uint8 *texture_data = new uint8[header.width * header.height * 4];

			switch (header.bit_depth)
			{
				case 8:
					TextureDecode::Pal_Decode(source_data, &pal[0][0], texture_data, header.width, header.height);
					break;
				case 16:
					TextureDecode::Ps2_Decode(source_data, texture_data, header.width, header.height);
					break;
				case 32:
					TextureDecode::Long_Decode(source_data, texture_data, header.width, header.height);
					break;
				default:
					Dbg_Assert(0);
			}
			delete[] source_data;

			// Create texture
			glGenTextures(1, &p_texture->GLTexture);
			glBindTexture(GL_TEXTURE_2D, p_texture->GLTexture);

			// Disable mipmaps
			glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);

			// Unswizzle texture
			if (is_power_of_two(header.width) && is_power_of_two(header.height))
			{
				uint8 *unswizzled_texture_data = new uint8[header.width * header.height * 4];
				TextureDecode::Swizzle_Decode(texture_data, unswizzled_texture_data, header.width, header.height);
				delete[] texture_data;

				// Write to texture
				glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, header.width, header.height, 0, GL_RGBA, GL_UNSIGNED_BYTE, unswizzled_texture_data);
				
				delete[] unswizzled_texture_data;

				// Set size
				p_texture->BaseWidth = header.width;
				p_texture->BaseHeight = header.height;
				p_texture->ActualWidth = header.original_width;
				p_texture->ActualHeight = header.original_height;
			}
			else
			{
				// Write to texture
				glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, header.original_width, header.original_height, 0, GL_RGBA, GL_UNSIGNED_BYTE, texture_data);
				delete[] texture_data;

				// Set size
				p_texture->BaseWidth = header.original_width;
				p_texture->BaseHeight = header.original_height;
				p_texture->ActualWidth = header.original_width;
				p_texture->ActualHeight = header.original_height;
			}

			// Set up some member values
			p_texture->PaletteDepth	= (uint8)header.clut_bit_depth;
			p_texture->TexelDepth	= (uint8)header.bit_depth;
			p_texture->DXT			= 0;
			p_texture->Levels		= 1;
			
			return p_texture;
		}
	}
	return nullptr;
}


} // namespace NxWn32

