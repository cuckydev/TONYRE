/*****************************************************************************
**																			**
**			              Neversoft Entertainment			                **
**																		   	**
**				   Copyright (C) 1999 - All Rights Reserved				   	**
**																			**
******************************************************************************
**																			**
**	Project:		GFX (Graphics Library)									**
**																			**
**	Module:			Graphics (GFX)		 									**
**																			**
**	File name:		p_gfxman.cpp											**
**																			**
**	Created:		07/26/99	-	mjb										**
**																			**
**	Description:	Graphics device manager									**
**																			**
*****************************************************************************/


/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/
		
#include <Windows.h>
#include <sys/file/filesys.h>
#include <gfx/gfxman.h>
#include <Plat/Gfx/nx/nx_init.h>
#include <Plat/Gfx/nx/gamma.h>

/*****************************************************************************
**								DBG Information								**
*****************************************************************************/


/*****************************************************************************
**								  Externals									**
*****************************************************************************/

namespace Gfx
{


/*****************************************************************************
**								   Defines									**
*****************************************************************************/

/*****************************************************************************
**								Private Types								**
*****************************************************************************/

/*****************************************************************************
**								 Private Data								**
*****************************************************************************/

/*****************************************************************************
**								 Public Data								**
*****************************************************************************/

/*****************************************************************************
**							  Private Prototypes							**
*****************************************************************************/

/*****************************************************************************
**							   Private Functions							**
*****************************************************************************/

/*****************************************************************************
**							   Public Functions								**
*****************************************************************************/

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void Manager::SetGammaNormalized( float fr, float fg, float fb )
{
	NxWn32::SetGammaNormalized( fr, fg, fb );
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void Manager::GetGammaNormalized( float *fr, float *fg, float *fb )
{
	NxWn32::GetGammaNormalized( fr, fg, fb );
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void Manager::DumpVRAMUsage( void )
{
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void Manager::ScreenShot( const char *fileroot )
{
	/*
	// Called twice per frame - once to request the screenshot, and once (post Swap()), to actually perform it.
	if( NxWn32::EngineGlobals.screenshot_name[0] == 0 )
	{
		strcpy( NxWn32::EngineGlobals.screenshot_name, fileroot );
		return;
	}
	
	char fileName[32];
	char fullFileName[64];
	
	// Try to find a good filename of the format filebasexxx.bmp. "Good" is defined here as one that isn't already used.
	for( int i = 0;; ++i )
	{
		sprintf( fileName, "screens\\%s%03d.bmp", fileroot, i );

		// Found an unused one! Yay!
		if( !File::Exist( fileName ))
		{
			sprintf( fullFileName, "d:\\data\\screens\\%s%03d.bmp", fileroot, i );
			break;
		}
	}
	
	// Obtain the render surface.
	IDirect3DSurface8 *p_render_target = NxWn32::EngineGlobals.p_RenderSurface;

	// Get the surface description, just for s and g.
	D3DSURFACE_DESC surface_desc;
	p_render_target->GetDesc( &surface_desc );

	// This is great - this function spits surfaces straight out into a file.
	HRESULT hr = XGWriteSurfaceToFile( p_render_target, fullFileName );
	Dbg_Assert( hr == S_OK );
	*/
}






/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/


} // namespace Gfx
