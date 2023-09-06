///////////////////////////////////////////////////////////////////////////////
// p_NxTexture.cpp

#include <Gfx/nx.h>
#include <Plat/Gfx/p_nxtexture.h>
#include <Sys/File/filesys.h>

#include "Com/texturedecode.h"

#include <Windows.h>

namespace Nx
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CXboxTexture::CXboxTexture() :  m_transparent( false ), mp_texture( nullptr )
{
	m_num_mipmaps = 0;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CXboxTexture::~CXboxTexture()
{
	if( mp_texture )
	{
		delete mp_texture;
	}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CXboxTexture::SetEngineTexture( NxWn32::sTexture *p_texture )
{
	Dbg_AssertPtr(p_texture);
	mp_texture	= p_texture;
	m_checksum	= p_texture->Checksum;
}




/////////////////////////////////////////////////////////////////////////////////////
// Private classes
//

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool CXboxTexture::plat_load_texture( const char *p_texture_name, bool sprite, bool alloc_vram )
{
	(void)alloc_vram;
	(void)sprite;

	char filename[256];

	strcpy( filename, p_texture_name );
	
	// Append '.img.xbx' to the end.
	strcat( filename, ".img.xbx" );

	mp_texture = NxWn32::LoadTexture(filename);

	return true;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool CXboxTexture::plat_replace_texture( CTexture *p_texture )
{
	(void)p_texture;
	// CXboxTexture *p_xbox_texture = static_cast<CXboxTexture *>(p_texture);

	// Go through and copy the texture.
	// NxWn32::sTexture *p_src = p_xbox_texture->GetEngineTexture();
	NxWn32::sTexture *p_dst = GetEngineTexture();

	// TODO: actually copy
	glDeleteTextures(1, &p_dst->GLTexture);
	glGenTextures(1, &p_dst->GLTexture);
	return true;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool CXboxTexture::plat_add_to_vram( void )
{								 	
	// Meaningless on Xbox, added to remove annoying debug stub output.
	return false;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool CXboxTexture::plat_remove_from_vram( void )
{								 	
	// Meaningless on Xbox, added to remove annoying debug stub output.
	return false;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
uint16	CXboxTexture::plat_get_width() const
{
	if( mp_texture )
		return mp_texture->ActualWidth;

	return 0;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

uint16	CXboxTexture::plat_get_height() const
{
	if( mp_texture )
		return mp_texture->ActualHeight;

	return 0;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

uint8	CXboxTexture::plat_get_bitdepth() const
{
	if( mp_texture )
		return mp_texture->TexelDepth;

	return 0;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

uint8	CXboxTexture::plat_get_num_mipmaps() const
{
	return m_num_mipmaps;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool	CXboxTexture::plat_is_transparent() const
{
	return m_transparent;
}

////////////////////////////////////////////////////////////////////////////////////
// Here's a machine specific implementation of CTexDict

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CXboxTexDict::CXboxTexDict( uint32 checksum ) : CTexDict( checksum )
{
	(void)checksum;
	// Load nothing
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CXboxTexDict::CXboxTexDict( const char *p_tex_dict_name ) : CTexDict( p_tex_dict_name, true )
{
	 LoadTextureDictionary( p_tex_dict_name );	// the derived class will does this
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CXboxTexDict::~CXboxTexDict()
{
	UnloadTextureDictionary();				// the derived class does this
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool CXboxTexDict::LoadTextureDictionary( const char *p_tex_dict_name )
{
	// Count the number of entries in the lookup table. If it is empty, it is safe
	// to delete it and create a new, optimum sized one during the load process itself.
	if( mp_texture_lookup )
	{
		int num_items = 0;
		mp_texture_lookup->IterateStart();
		while( mp_texture_lookup->IterateNext())
			++num_items;

		if( num_items == 0 )
			mp_texture_lookup = Nx::LoadTextureFile( p_tex_dict_name, mp_texture_lookup, true );
		else
			Nx::LoadTextureFile( p_tex_dict_name, mp_texture_lookup );
	}
	else
	{
		Nx::LoadTextureFile( p_tex_dict_name, mp_texture_lookup );
	}
	return true;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool CXboxTexDict::LoadTextureDictionaryFromMemory( void *p_mem )
{
	// Count the number of entries in the lookup table. If it is empty, it is safe
	// to delete it and create a new, optimum sized one during the load process itself.
	if( mp_texture_lookup )
	{
		int num_items = 0;
		mp_texture_lookup->IterateStart();
		while( mp_texture_lookup->IterateNext())
			++num_items;

		if( num_items == 0 )
			mp_texture_lookup =	Nx::LoadTextureFileFromMemory( &p_mem, mp_texture_lookup, true );
		else
			Nx::LoadTextureFileFromMemory( &p_mem, mp_texture_lookup );
	}
	else
	{
		Nx::LoadTextureFileFromMemory( &p_mem, mp_texture_lookup );
	}
	return true;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool CXboxTexDict::UnloadTextureDictionary( void )
{
	return true;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CTexture *CXboxTexDict::plat_load_texture( const char *p_texture_name, bool sprite, bool alloc_vram )
{
	(void)alloc_vram;

	CXboxTexture *p_texture = new CXboxTexture;
	if( !p_texture->LoadTexture( p_texture_name, sprite ))
	{
		Dbg_Error("Can't load texture %s", p_texture_name);
	}
	return p_texture;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CTexture *CXboxTexDict::plat_reload_texture( const char *p_texture_name )
{
	(void)p_texture_name;
	return nullptr;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool CXboxTexDict::plat_unload_texture( CTexture *p_texture )
{
	delete p_texture;

	return true;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CXboxTexDict::plat_add_texture( CTexture *p_texture )
{
	(void)p_texture;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool CXboxTexDict::plat_remove_texture( CTexture *p_texture )
{
	(void)p_texture;
	return false;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
#define MemoryRead( dst, size, num, src )	CopyMemory(( dst ), ( src ), (( num ) * ( size )));	\
											( src ) += (( num ) * ( size ))

Lst::HashTable<Nx::CTexture>* LoadTextureFileFromMemory( void **pp_mem, Lst::HashTable<Nx::CTexture> *p_texture_table, bool okay_to_rebuild_texture_table )
{
	uint8 *p_data = (uint8*)( *pp_mem );

	// Read the texture file version and number of textures.
	int version, num_textures;
	MemoryRead( &version, sizeof( int ), 1, p_data );
	MemoryRead( &num_textures, sizeof( int ), 1, p_data );

	// If allowed, rebuild the texture table to the optimum size, using the same heap as the original table.
	if( okay_to_rebuild_texture_table )
	{
		uint32 optimal_table_size	= num_textures * 2;
		uint32 test					= 2;
		uint32 size					= 1;
		for( ;; test <<= 1, ++size )
		{
			// Check if this iteration of table size is sufficient, or if we have hit the maximum size.
			if(( optimal_table_size <= test ) || ( size >= 12 ))
			{
				delete p_texture_table;
				p_texture_table = new Lst::HashTable<Nx::CTexture>( size );
				break;
			}
		}
	}

	for( int t = 0; t < num_textures; ++t )
	{
		// Create the engine level texture.
		NxWn32::sTexture *p_texture = new NxWn32::sTexture;

		uint32 base_width, base_height, levels, texel_depth, palette_depth, dxt, palette_size;
		MemoryRead( &p_texture->Checksum,	sizeof( uint32 ), 1, p_data );
		MemoryRead( &base_width,			sizeof( uint32 ), 1, p_data );
		MemoryRead( &base_height,			sizeof( uint32 ), 1, p_data );
		MemoryRead( &levels,				sizeof( uint32 ), 1, p_data );
		MemoryRead( &texel_depth,			sizeof( uint32 ), 1, p_data );
		MemoryRead( &palette_depth,			sizeof( uint32 ), 1, p_data );
		MemoryRead( &dxt,					sizeof( uint32 ), 1, p_data );
		MemoryRead( &palette_size,			sizeof( uint32 ), 1, p_data );

		p_texture->BaseWidth	= (uint16)base_width;
		p_texture->BaseHeight	= (uint16)base_height;
		p_texture->Levels		= (uint8)levels;
		p_texture->TexelDepth	= (uint8)texel_depth;
		p_texture->PaletteDepth	= (uint8)palette_depth;
		p_texture->DXT			= (uint8)dxt;
		
		// Load palette
		uint8 pal[256 * 4] = {};
		if (palette_size > 0)
			MemoryRead(pal, palette_size, 1, p_data);

		// Create texture
		glGenTextures(1, &p_texture->GLTexture);
		glBindTexture(GL_TEXTURE_2D, p_texture->GLTexture);

		// Set mipmaps range
		glTexParameteri(p_texture->GLTexture, GL_TEXTURE_BASE_LEVEL, 0);
		glTexParameteri(p_texture->GLTexture, GL_TEXTURE_MAX_LEVEL, levels);

		// Disable mipmaps and clamp to edges
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

		// Determine texture format
		void (*TextureDecodeLambda)(const uint8 *in_buffer, const uint8 *pal, uint8 *out_buffer, size_t width, size_t height);

		if (p_texture->DXT > 0)
		{
			if ((p_texture->DXT == 1) || (p_texture->DXT == 2))
			{
				TextureDecodeLambda = [](const uint8 *in_buffer, const uint8 *pal, uint8 *out_buffer, size_t width, size_t height)
				{
					(void)pal;
					TextureDecode::DXT1_Decode(in_buffer, out_buffer, width, height);
				};
			}
			else if (p_texture->DXT == 5)
			{
				TextureDecodeLambda = [](const uint8 *in_buffer, const uint8 *pal, uint8 *out_buffer, size_t width, size_t height)
				{
					(void)pal;
					TextureDecode::DXT5_Decode(in_buffer, out_buffer, width, height);
				};
			}
			else
			{
				Dbg_Assert(0);
				return nullptr;
			}
		}
		else if (p_texture->TexelDepth == 8)
		{
			TextureDecodeLambda = TextureDecode::Pal_Decode;
		}
		else if (p_texture->TexelDepth == 16)
		{
			TextureDecodeLambda = [](const uint8 *in_buffer, const uint8 *pal, uint8 *out_buffer, size_t width, size_t height)
			{
				(void)pal;
				TextureDecode::Short_Decode(in_buffer, out_buffer, width, height);
			};
		}
		else if (p_texture->TexelDepth == 32)
		{
			TextureDecodeLambda = [](const uint8 *in_buffer, const uint8 *pal, uint8 *out_buffer, size_t width, size_t height)
			{
				(void)pal;
				TextureDecode::Long_Decode(in_buffer, out_buffer, width, height);
			};
		}
		else
		{
			Dbg_Assert(0);
			return nullptr;
		}
		
		// Decode texture
		for (uint8 mip_level = 0; mip_level < p_texture->Levels; ++mip_level)
		{
			// Read input data
			uint32 texture_level_data_size;
			MemoryRead(&texture_level_data_size, sizeof( uint32 ), 1, p_data);

			uint8 *in_buffer = new uint8[texture_level_data_size];
			MemoryRead(in_buffer, texture_level_data_size, 1, p_data);

			// Decode texture
			uint8 *out_buffer = new uint8[base_width * base_height * 4];
			TextureDecodeLambda(in_buffer, pal, out_buffer, base_width, base_height);
			delete[] in_buffer;

			// Store to texture
			glTexImage2D(GL_TEXTURE_2D, mip_level, GL_RGBA, base_width, base_height, 0, GL_RGBA, GL_UNSIGNED_BYTE, out_buffer);
			delete[] out_buffer;

			// Shift down to next mip level
			base_width >>= 1;
			base_height >>= 1;
		}

		// Add this texture to the table.
		Nx::CXboxTexture *p_xbox_texture = new Nx::CXboxTexture();
		p_xbox_texture->SetEngineTexture( p_texture );
		p_texture_table->PutItem( p_texture->Checksum, p_xbox_texture );
	}
	return p_texture_table;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
Lst::HashTable<Nx::CTexture>* LoadTextureFile( const char *Filename, Lst::HashTable<Nx::CTexture> *p_texture_table, bool okay_to_rebuild_texture_table )
{
	// Open the texture file.
	void *p_FH = File::Open( Filename, "rb" );
	if( !p_FH )
	{
		Dbg_Message( "Couldn't open texture file %s\n", Filename );
		return p_texture_table;
	}

	// Read the texture file version and number of textures.
	int version, num_textures;
	File::Read( &version, sizeof( int ), 1, p_FH );
	File::Read( &num_textures, sizeof( int ), 1, p_FH );

	// If allowed, rebuild the texture table to the optimum size, using the same heap as the original table.
	if( okay_to_rebuild_texture_table )
	{
		uint32 optimal_table_size	= num_textures * 2;
		uint32 test					= 2;
		uint32 size					= 1;
		for( ;; test <<= 1, ++size )
		{
			// Check if this iteration of table size is sufficient, or if we have hit the maximum size.
			if(( optimal_table_size <= test ) || ( size >= 12 ))
			{
				delete p_texture_table;
				p_texture_table = new Lst::HashTable<Nx::CTexture>( size );
				break;
			}
		}
	}

	for( int t = 0; t < num_textures; ++t )
	{
		// Create the engine level texture.
		NxWn32::sTexture *p_texture = new NxWn32::sTexture;

		uint32 base_width, base_height, levels, texel_depth, palette_depth, dxt, palette_size;
		File::Read( &p_texture->Checksum,	sizeof( uint32 ), 1, p_FH );
		File::Read( &base_width,			sizeof( uint32 ), 1, p_FH );
		File::Read( &base_height,			sizeof( uint32 ), 1, p_FH );
		File::Read( &levels,				sizeof( uint32 ), 1, p_FH );
		File::Read( &texel_depth,			sizeof( uint32 ), 1, p_FH );
		File::Read( &palette_depth,			sizeof( uint32 ), 1, p_FH );
		File::Read( &dxt,					sizeof( uint32 ), 1, p_FH );
		File::Read( &palette_size,			sizeof( uint32 ), 1, p_FH );

		p_texture->BaseWidth	= (uint16)base_width;
		p_texture->BaseHeight	= (uint16)base_height;
		p_texture->Levels		= (uint8)levels;
		p_texture->TexelDepth	= (uint8)texel_depth;
		p_texture->PaletteDepth	= (uint8)palette_depth;
		p_texture->DXT			= (uint8)dxt;
		
		// Load palette
		uint8 pal[256 * 4] = {};
		if (palette_size > 0)
			File::Read(pal, 4, palette_size, p_FH);

		// Create texture
		glGenTextures(1, &p_texture->GLTexture);
		glBindTexture(GL_TEXTURE_2D, p_texture->GLTexture);

		// Set mipmaps range
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_BASE_LEVEL, 0);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAX_LEVEL, levels - 1);

		// Disable mipmaps and clamp to edges
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR_MIPMAP_LINEAR);
		glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

		// Determine texture format
		void (*TextureDecodeLambda)(const uint8 *in_buffer, const uint8 *pal, uint8 *out_buffer, size_t width, size_t height);

		if( p_texture->DXT > 0 )
		{
			if(( p_texture->DXT == 1 ) || ( p_texture->DXT == 2 ))
			{
				TextureDecodeLambda = +[](const uint8 *in_buffer, const uint8 *pal, uint8 *out_buffer, size_t width, size_t height)
				{
					(void)pal;
					TextureDecode::DXT1_Decode(in_buffer, out_buffer, width, height);
				};
			}
			else if( p_texture->DXT == 5 )
			{
				TextureDecodeLambda = +[](const uint8 *in_buffer, const uint8 *pal, uint8 *out_buffer, size_t width, size_t height)
				{
					(void)pal;
					TextureDecode::DXT5_Decode(in_buffer, out_buffer, width, height);
				};
			}
			else
			{
				Dbg_Assert( 0 );
				return nullptr;
			}
		}
		else if( p_texture->TexelDepth == 8 )
		{
			TextureDecodeLambda = TextureDecode::Pal_Decode;
		}
		else if( p_texture->TexelDepth == 16 )
		{
			TextureDecodeLambda = +[](const uint8 *in_buffer, const uint8 *pal, uint8 *out_buffer, size_t width, size_t height)
			{
				(void)pal;
				TextureDecode::Short_Decode(in_buffer, out_buffer, width, height);
			};
		}
		else if( p_texture->TexelDepth == 32 )
		{
			TextureDecodeLambda = +[](const uint8 *in_buffer, const uint8 *pal, uint8 *out_buffer, size_t width, size_t height)
			{
				(void)pal;
				TextureDecode::Long_Decode(in_buffer, out_buffer, width, height);
			};
		}
		else
		{
			Dbg_Assert( 0 );
			return nullptr;
		}

		// Decode texture
		for (uint8 mip_level = 0; mip_level < p_texture->Levels; mip_level++)
		{
			// Read input data
			uint32 texture_level_data_size;
			File::Read(&texture_level_data_size, sizeof(uint32), 1, p_FH);

			uint8 *in_buffer = new uint8[texture_level_data_size];
			File::Read(in_buffer, texture_level_data_size, 1, p_FH);

			// Decode texture
			uint8 *out_buffer = new uint8[base_width * base_height * 4];
			TextureDecodeLambda(in_buffer, pal, out_buffer, base_width, base_height);
			delete[] in_buffer;

			// Store to texture
			glTexImage2D(GL_TEXTURE_2D, mip_level, GL_RGBA, base_width, base_height, 0, GL_RGBA, GL_UNSIGNED_BYTE, out_buffer);
			delete[] out_buffer;

			// Shift down to next mip level
			base_width >>= 1;
			base_height >>= 1;
		}
		
		// Add this texture to the table.
		Nx::CXboxTexture *p_xbox_texture = new Nx::CXboxTexture();
		p_xbox_texture->SetEngineTexture( p_texture );
		p_texture_table->PutItem( p_texture->Checksum, p_xbox_texture );
	}
	File::Close( p_FH );

	return p_texture_table;
}


} // Namespace Nx  			
				
				
