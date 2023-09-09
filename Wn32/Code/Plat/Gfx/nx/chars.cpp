#include <stdlib.h>
#include <string.h>

#include <Core/Defines.h>
#include <Core/Debug.h>
#include <Core/String/stringutils.h>
#include <Core/macros.h>
#include <Gfx/NxFontMan.h>
#include <Sys/Config/config.h>
#include <Sys/File/filesys.h>

#include "nx_init.h"
#include "render.h"
#include "chars.h"
#include "xbmemfnt.h"

#include "Com/texturedecode.h"


/*


	
.fnt file format (by Ryan)
--------------------------

	4	File size in bytes
	4	Number of characters
	4	Default height
	4	Default base
	
	?	Character table (see below)
	?	Texture (see below)

	Character
	2	Baseline (how many pixels down relative to top of image)
	2	Ascii value

	Texture
	4	Size of texture
	2	Width
	2	Height
	2	Bit depth
	6	Padding
	W*H	Raw data
	0-3	Padding for uint32 alignment
	1K	Palette data
	4	Number of subtextures
	?	Subtexture table (see below)

	Subtexture
	2	X
	2	Y
	2	W
	2	H
	
*/


namespace NxWn32
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
SFont			*pFontList;
SFont			*pButtonsFont				= nullptr;
SFont			*SText::spOverrideFont		= nullptr;

const uint32	CHARS_PER_BUFFER			= 256;

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
SFont* InitialiseMemoryResidentFont( void )
{
	return LoadFont((const char*)xbmemfnt, true );
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
SFont* LoadFont( const char *Filename, bool memory_resident )
{
	SFont*	pFont;
	SChar*	pChar;
	uint8*	pData;
	void*	p_FH = nullptr;
	uint32 i;
	uint32 NumChars, Width, Height, NumBytes;
	size_t Len;

	// Build the full filename.
	char filename[128];

	if( !memory_resident )
	{
		strcpy( filename, "fonts/" );
		strcat( filename, Filename );
		strcat( filename, ".fnt.xbx" );
	}
	
	// Open the font file.
	if( !memory_resident )
		p_FH = File::Open( filename, "rb" );

	// Allocate memory for the font structure.
	pFont = new SFont();

	// Allocate a temporary buffer.
	uint8 FontBuf[2048];

	// Load file header.
	if( !memory_resident )
	{
		Len = File::Read( FontBuf, 16, 1, p_FH );
		Dbg_MsgAssert( Len == 16, ( "couldn't read file header from font file %s", Filename ));
	}
	else
	{
		CopyMemory( FontBuf, Filename, 16 );
		Filename += 16;
	}

	NumChars			 = ((uint32 *)FontBuf)[1];
	pFont->DefaultHeight = ((uint32 *)FontBuf)[2];
	pFont->DefaultBase	 = ((uint32 *)FontBuf)[3];

	// Clear character map to zero.
	memset( pFont->Map, 0, 256 );
	memset( pFont->SpecialMap, 0, 32 );

	// Allocate memory for character table.
	pFont->pChars = new SChar[NumChars];

	// Load character map and character table.
	if( !memory_resident )
	{
		Len = File::Read( FontBuf, NumChars << 2, 1, p_FH );
		Dbg_MsgAssert( Len == ( NumChars << 2 ), ( "couldn't read character table in font file %s", Filename ));
	}
	else
	{
		CopyMemory( FontBuf, Filename, NumChars << 2 );
		Filename += NumChars << 2;
	}

	for( i = 0, pChar = pFont->pChars, pData = FontBuf; i < NumChars; i++,pChar++,pData += 4 )
	{
		pChar->Baseline							= ((uint16 *)pData)[0];
		sint16 ascii_val = ((sint16 *)pData)[1];
		if (ascii_val >= 0)
			pFont->Map[(uint8) ascii_val] = (uint8)i;
		else
		{
			Dbg_Assert(ascii_val >= -32)
			pFont->SpecialMap[(uint8)(-ascii_val - 1)] = (uint8)i;
		}
	}

	// If there is a null character in the font, make characters that could not be found
	// in the font display that instead of 'A'
	if( pFont->SpecialMap[31] != 0 )
	{
		for( i = 0; i < 256; ++i ) 
		{
			if( pFont->Map[i] == 0 && i != 'A' && i != 'a')
				pFont->Map[i] = pFont->SpecialMap[31];

			if( i < 31 && pFont->SpecialMap[i] == 0 )
				pFont->SpecialMap[i] = pFont->SpecialMap[31];
		}
	}	
	
	// Load texture header.
	if( !memory_resident )
	{
		Len = File::Read( FontBuf, 16, 1, p_FH );
		Dbg_MsgAssert( Len == 16, ( "couldn't read texture header from font file %s", Filename ));
	}
	else
	{
		CopyMemory( FontBuf, Filename, 16 );
		Filename += 16;
	}

	Width	= ((uint16 *)FontBuf)[2];
	Height	= ((uint16 *)FontBuf)[3];
	// Depth = ((uint16 *)FontBuf)[4];

	// Create texture
	glGenTextures(1, &pFont->GLTexture);
	glBindTexture(GL_TEXTURE_2D, pFont->GLTexture);

	// Set mipmap range
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_BASE_LEVEL, 0);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAX_LEVEL,  0);

	// Disable mipmaps and clamp to edges
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_CLAMP_TO_EDGE);
	glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_CLAMP_TO_EDGE);

	// Read texture bitmap data (into temp buffer so we can then swizzle it).
	NumBytes = ( Width * Height + 3 ) & 0xFFFFFFFC;

	uint8* p_texel_data = new uint8[NumBytes];
	if( !memory_resident )
	{
		Len = File::Read(p_texel_data, NumBytes, 1, p_FH );
		Dbg_MsgAssert( Len == NumBytes, ( "Couldn't read texture bitmap from font file %s", Filename ));
	}
	else
	{
		CopyMemory(p_texel_data, Filename, NumBytes );
		Filename += NumBytes;
	}
	
	// Read clut bitmap data.
	uint8 p_clut[256][4] = {};

	if( !memory_resident )
	{
		Len	= File::Read(p_clut, sizeof(p_clut), 1, p_FH);
		Dbg_MsgAssert(Len == sizeof(p_clut), ("couldn't read clut bitmap from font file %s", Filename));
	}
	else
	{
		CopyMemory(p_clut, Filename, sizeof(p_clut));
		Filename += sizeof(p_clut);
	}

	// Decode palettized texture
	uint8 *p_texture = new uint8[NumBytes * 4];

	uint8 *p_texture_p = p_texture;
	uint8 *p_texel_data_p = p_texel_data;
	for( i = 0; i < NumBytes; ++i )
	{
		uint8 *p = p_clut[*p_texel_data_p++];
		*p_texture_p++ = p[0];
		*p_texture_p++ = p[1];
		*p_texture_p++ = p[2];
		*p_texture_p++ = (p[3] >= 0x80) ? 0xFF : (p[3] * 2); // Alpha is halved, PS2 remnant?
	}
	delete[] p_texel_data;

	// Read into texture
	glTexImage2D(GL_TEXTURE_2D, 0, GL_RGBA, Width, Height, 0, GL_RGBA, GL_UNSIGNED_BYTE, p_texture);
	delete[] p_texture;

	// Skip numsubtextures, and load subtextures.
	if( !memory_resident )
	{
		Len = File::Read( FontBuf, ( NumChars << 3 ) + 4, 1, p_FH );
		Dbg_MsgAssert( Len == ( NumChars << 3 ) + 4, ( "couldn't read subtexture table from font file %s", Filename ));
	}
	else
	{
		CopyMemory( FontBuf, Filename, ( NumChars << 3 ) + 4 );
		Filename += ( NumChars << 3 ) + 4;
	}

	for( i = 0, pChar = pFont->pChars, pData = FontBuf + 4; i < NumChars; i++, pChar++, pData += 8 )
	{
		uint16 x	= ((uint16 *)pData )[0];
		uint16 y	= ((uint16 *)pData )[1];
		uint16 w	= ((uint16 *)pData )[2];
		uint16 h	= ((uint16 *)pData )[3];
		
		pChar->w	= w;
		pChar->h	= h;
		pChar->u0	= (float)x / (float)Width;
		pChar->v0	= (float)y / (float)Height;
		pChar->u1	= pChar->u0 + ((float)w / (float)Width );
		pChar->v1	= pChar->v0 + ((float)h / (float)Height );
	}

	// Add font to font list.
	pFont->pNext	= pFontList;
	pFontList		= pFont;

	// We're done with the font file now.
	if( !memory_resident )
		File::Close( p_FH );
	
	// this will serve as the default spacing
	pFont->mSpaceSpacing = pFont->pChars[pFont->Map['I']].w;
	
	return pFont;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void UnloadFont( SFont *pFont )
{
	SFont*	pPrevFont;
	int		found = 0;

	// Find font and unchain from list.
	if( pFontList == pFont )
	{
		found=1;
		pFontList = pFontList->pNext;
	}
	else
	{
		for( pPrevFont=pFontList; pPrevFont->pNext; pPrevFont=pPrevFont->pNext )
		{
			if( pPrevFont->pNext == pFont )
			{
				found = 1;
				pPrevFont->pNext = pFont->pNext;
				break;
			}
		}
	}

	Dbg_MsgAssert( found, ( "Attempt to unload font which has not been loaded" ));

	// Delete texture
	glDeleteTextures( 1, &pFont->GLTexture );

	// Free memory.
	delete [] pFont->pChars;
	delete pFont;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
uint32 SFont::GetDefaultHeight() const
{
	return DefaultHeight;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
uint32 SFont::GetDefaultBase() const
{
	return DefaultBase;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void SFont::QueryString( const char *String, float &width, float &height )
{
	SChar	*pChar;
	const char	*pLetter;
	int		x0,x1;

	x0 = 0;

	for (pLetter=String;; pLetter++)
	{
		pChar = nullptr;
		// may be overridden by the '\b' tag
		SFont *p_font = this;
		
		// acount for tags (might be multiple ones in a row)
		bool got_char_tag = false; // tag resulting in output of character
		while (*pLetter == '\\' && !got_char_tag)
		{
			pLetter++;
			if (*pLetter == '\\')
				break;

			switch(*pLetter)
			{
				case '\\':
					got_char_tag = true;
					break;
				case 'c':
				case 'C':
					pLetter += 2; // skip over "c#"
					break;
				case 's':
				case 'S':
				{
					pLetter++; // skip "s"
					uint digit = Str::DehexifyDigit(pLetter);
					pChar = pChars + SpecialMap[digit];
					got_char_tag = true;
					break;
				}
				case 'b':
				case 'B':
				{
					pLetter++; // skip "b"
					uint digit = Str::DehexifyDigit(pLetter);
					
					// switch over to buttons font, the regular font will be used again on the next character

					p_font = pButtonsFont;
					Dbg_Assert(p_font);
					pChar = p_font->pChars + p_font->SpecialMap[digit];
					got_char_tag = true;
					break;
				}
				case 'm':
				case 'M':
				{
					pLetter++; // skip "m"
					char button_char = Nx::CFontManager::sMapMetaCharacterToButton(pLetter);
					uint digit = Str::DehexifyDigit(&button_char);
					
					p_font = pButtonsFont;
					Dbg_Assert(p_font);
					pChar = p_font->pChars + p_font->SpecialMap[digit];
					got_char_tag = true;
					break;
				}
				default:
					Dbg_MsgAssert(0, ("unknown tag"));
					break;
			}
		} // end while
		
		if (*pLetter == '\0') break;
		
		if (*pLetter!=' ' || pChar)
		{
			if (!pChar)
				pChar = p_font->pChars + p_font->Map[(uint8)*pLetter];
			x1 = x0 + pChar->w;
		}
		else
		{
			x1 = x0 + mSpaceSpacing;
		}

		//x0 = x1 + mCharSpacing + 1;
		x0 = x1 + mCharSpacing;
	}

	width  = (float)x0;
	height = (float)DefaultHeight;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
SText::SText( float pri ) : SDraw2D( pri, true )
{
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
SText::~SText( void )
{
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void SText::BeginDraw( void )
{
	// Check if we need to change the render state
	SFont *p_font = (spOverrideFont) ? spOverrideFont : mp_font;
	if (p_font->GLTexture != SDraw2D::sp_current_texture)
	{
		Submit();
		SDraw2D::sp_current_texture = p_font->GLTexture;
	}
	// p_locked_font_vertex_buffer = &( font_vertex_buffer[0] );
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void SText::Draw( void )
{
	SChar	*pChar;
	char	*pLetter;
	float	u0,v0,x0,y0,u1,v1,x1,y1,yt;

	x0 = SCREEN_CONV_X( m_xpos );
	y0 = SCREEN_CONV_Y( m_ypos );

	float char_spacing	= (float)mp_font->mCharSpacing * m_xscale;
	float space_spacing = (float)mp_font->mSpaceSpacing * m_xscale;
	
	// Get color
	float r = ((m_rgba >> 0) & 0xFF) / 128.0f;
	float g = ((m_rgba >> 8) & 0xFF) / 128.0f;
	float b = ((m_rgba >> 16) & 0xFF) / 128.0f;
	float a = ((m_rgba >> 24) & 0xFF) / 128.0f;
	
	float text_z = GetZValue();
	
	for( pLetter = mp_string;; pLetter++ )
	{
		pChar = nullptr;
		SFont *p_font = mp_font;

		// sFontVert* p_vert = ((sFontVert*)p_locked_font_vertex_buffer ) + font_vertex_offset;

		// acount for tags (might be multiple ones in a row)
		bool got_char_tag = false; // tag resulting in output of character
		while (*pLetter == '\\' && !got_char_tag)
		{
			pLetter++;

			switch(*pLetter)
			{
				case '\\':
					got_char_tag = true;
					break;
				case 'c':
				case 'C':
				{
					pLetter++;	// skip "c"					
					uint digit = Str::DehexifyDigit(pLetter);
					pLetter++; // skip "#"
					
					// Set active color from font.
					if( digit == 0 || m_color_override)
					{
						// Switch from RGBA to BGRA format.
						r = (( m_rgba >> 0 ) & 0xFF) / 128.0f;
						g = (( m_rgba >> 8 ) & 0xFF) / 128.0f;
						b = (( m_rgba >> 16 ) & 0xFF) / 128.0f;
						a = (( m_rgba >> 24 ) & 0xFF) / 128.0f;
					}
					else
					{
						// Switch from RGBA to BGRA format.
						uint32 color	= mp_font->mRGBATab[digit-1];
						r = ((color >> 0) & 0xFF) / 128.0f;
						g = ((color >> 8) & 0xFF) / 128.0f;
						b = ((color >> 16) & 0xFF) / 128.0f;
						a = ((color >> 24) & 0xFF) / 128.0f;
					}
					break;
				}
				case 's':
				case 'S':
				{
					pLetter++;	// skip "s"
					uint digit = Str::DehexifyDigit(pLetter);
					
					pChar = mp_font->pChars + mp_font->SpecialMap[digit];
					got_char_tag = true;
					
					break;
				}
				case 'b':
				case 'B':
				{
					// 'B' stands for button, accesses the button font

					pLetter++; // skip "b"
					uint digit = Str::DehexifyDigit( pLetter );
					
					// switch to the buttons font!
					p_font = pButtonsFont;
					Dbg_Assert( p_font );
					
					pChar = p_font->pChars + p_font->SpecialMap[digit];
					got_char_tag = true;

					EndDraw();
					spOverrideFont = p_font;
					BeginDraw();

					// Reset the vertex data pointer.
					// p_vert = ((sFontVert*)p_locked_font_vertex_buffer ) + font_vertex_offset;
					
					break;
				}
				default:
				{
					Dbg_MsgAssert( 0, ( "unknown tag" ));
					break;
				}
			}
		} // end while
		
		if (*pLetter == '\0') break;
		
		if( *pLetter != ' ' || pChar)
		{
			if (!pChar)
				pChar = p_font->pChars + p_font->Map[(uint8) *pLetter];
			yt = y0 + ((float)(p_font->DefaultBase - pChar->Baseline) * m_yscale) * EngineGlobals.screen_conv_y_multiplier;
			u0 = pChar->u0;
			v0 = pChar->v0;
			u1 = pChar->u1;
			v1 = pChar->v1;
			x1 = x0 + (pChar->w * m_xscale * EngineGlobals.screen_conv_x_multiplier);
			y1 = yt + (pChar->h * m_yscale * EngineGlobals.screen_conv_y_multiplier);
		}
		else
		{
			x0 += (space_spacing + char_spacing) * EngineGlobals.screen_conv_x_multiplier;
			continue;
		}

		// Push vertices
		size_t vi = m_verts.size();

		m_verts.push_back(sVert2D{
			x0, yt, text_z,
			u0, v0,
			r, g, b, a
		});
		m_verts.push_back(sVert2D{
			x0, y1, text_z,
			u0, v1,
			r, g, b, a
		});
		m_verts.push_back(sVert2D{
			x1, y1, text_z,
			u1, v1,
			r, g, b, a
		});
		m_verts.push_back(sVert2D{
			x1, yt, text_z,
			u1, v0,
			r, g, b, a
		});

		// Push indices
		m_indices.push_back((GLushort)(vi + 0));
		m_indices.push_back((GLushort)(vi + 1));
		m_indices.push_back((GLushort)(vi + 2));
		m_indices.push_back((GLushort)(vi + 0));
		m_indices.push_back((GLushort)(vi + 2));
		m_indices.push_back((GLushort)(vi + 3));

		/*
		p_vert->x	= x0;
		p_vert->y	= yt;
		p_vert->z	= text_z;
		p_vert->rhw	= 0.0f;
		p_vert->col	= current_color;
		p_vert->u	= u0;
		p_vert->v	= v0;
		++p_vert;

		p_vert->x	= x0;
		p_vert->y	= y1;
		p_vert->z	= text_z;
		p_vert->rhw	= 0.0f;
		p_vert->col	= current_color;
		p_vert->u	= u0;
		p_vert->v	= v1;
		++p_vert;

		p_vert->x	= x1;
		p_vert->y	= y1;
		p_vert->z	= text_z;
		p_vert->rhw	= 0.0f;
		p_vert->col	= current_color;
		p_vert->u	= u1;
		p_vert->v	= v1;
		++p_vert;

		p_vert->x	= x1;
		p_vert->y	= yt;
		p_vert->z	= text_z;
		p_vert->rhw	= 0.0f;
		p_vert->col	= current_color;
		p_vert->u	= u1;
		p_vert->v	= v0;
		*/

		/*
		font_vertex_offset += 4;

		if( font_vertex_offset >= ( CHARS_PER_BUFFER * 4 ))
		{
			// Draw this buffer and cycle through to the next.
			EndDraw();
			BeginDraw();
		}
		*/

		x0 = x1 + (char_spacing * EngineGlobals.screen_conv_x_multiplier);

		if( p_font != mp_font )
		{
			// We just used the button font, so return to the regular one.
			EndDraw();
			BeginDraw();
		}
	}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void SText::EndDraw( void )
{
	/*
	if( font_vertex_offset > 0 )
	{
		// Subsequent processing within Draw() will use this font
		// Draw() may call this function to temporarily switch fonts
		SFont *p_font = ( spOverrideFont ) ? spOverrideFont : mp_font;
		
		// Set up the render state and submit.
		set_pixel_shader( PixelShader4 );
		set_vertex_shader( D3DFVF_XYZRHW | D3DFVF_DIFFUSE | D3DFVF_TEX1 | D3DFVF_TEXCOORDSIZE2( 0 ));

		set_texture( 0, p_font->pD3DTexture, p_font->pD3DPalette );

		EngineGlobals.p_Device->DrawVerticesUP( D3DPT_QUADLIST, font_vertex_offset, &( font_vertex_buffer[0] ), sizeof( sFontVert ));

		// Reset offset.
		font_vertex_offset = 0;

		// We can now return to using the regular font (no override).
		spOverrideFont = nullptr;
	}
	*/
	// Clear font override
	spOverrideFont = nullptr;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void SetTextWindow( uint16 x0, uint16 x1, uint16 y0, uint16 y1 )
{
	(void)x0;
	(void)x1;
	(void)y0;
	(void)y1;
}

} // namespace Xbox

