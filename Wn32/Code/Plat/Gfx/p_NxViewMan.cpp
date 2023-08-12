/////////////////////////////////////////////////////////////////////////////
// p_NxViewMan.cpp - Xbox platform specific interface to CViewportManager

#include <Core/Defines.h>

#include "Gfx/NxViewMan.h"
#include "Plat/Gfx/p_NxViewport.h"

namespace	Nx
{


/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
// Functions


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CViewport *CViewportManager::s_plat_create_viewport( const Mth::Rect *rect, Gfx::Camera *cam )
{
	return new CXboxViewport( rect, cam );
}

} 
 
