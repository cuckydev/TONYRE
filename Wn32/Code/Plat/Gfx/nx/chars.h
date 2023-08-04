#ifndef __CHARS_H
#define __CHARS_H

#include <Plat/Gfx/nx/sprite.h>

namespace NxWn32
{


typedef struct
{
	float	u0, v0, u1, v1;
	uint16	w, h;
	uint16	Baseline;
}
SChar;


struct SFont
{
public:
	uint32		GetDefaultHeight() const;
	uint32		GetDefaultBase() const;

//	void		BeginText(uint32 rgba, float Scale);
//	void		DrawString(char *String, float x0, float y0);
//	void		EndText(void);
	void		QueryString(char *String, float &width, float &height);

	//char Name[16];
	uint32		DefaultHeight = 0, DefaultBase = 0;
	SChar		*pChars = nullptr;
	uint8		Map[256] = {};
	uint8		SpecialMap[32] = {};
//	uint8		*pVifData;
//	uint32		VifSize;
//	uint64		RegTEX0, RegTEX1;
	SFont		*pNext = nullptr;

	sint16		mCharSpacing = 0;
	sint16		mSpaceSpacing = 0;
	uint32		mRGBATab[16] = {};
	
	// IDirect3DTexture8*	pD3DTexture;		// To do - these should probably be replaced with an sTexture.
	// IDirect3DPalette8*	pD3DPalette;
};



SFont*		InitialiseMemoryResidentFont( void );
SFont*		LoadFont( const char* Filename, bool memory_resident = false );
void		UnloadFont( SFont * );
void		SetTextWindow( uint16 x0, uint16 x1, uint16 y0, uint16 y1 );


struct SText : public SDraw2D
{
	public:
					SText( float pri = 0.0f );
	virtual			~SText();

	SFont			*mp_font = nullptr;

	char			*mp_string = nullptr;
	float			m_xpos = 0.0f;
	float			m_ypos = 0.0f;
	float			m_xscale = 0.0f;
	float			m_yscale = 0.0f;
	uint32			m_rgba = 0;
	bool			m_color_override = false;
	
	// used in conjunction with BeginDraw()
	// if set, use specified font instead of mp_font
	// if not, use mp_font
	static SFont *	spOverrideFont;

	void			BeginDraw( void );
	void			Draw( void );
	void			EndDraw( void );
};

void SwizzleTexture( void *dstBuffer, void *srcBuffer, int width, int height, int32 depth, int32 stride );


extern uint32 FontVramBase;
extern SFont *pFontList;
extern SFont *pButtonsFont;


} // namespace NxWn32


#endif // __CHARS_H
