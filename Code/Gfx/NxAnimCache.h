//****************************************************************************
//* MODULE:         Gfx
//* FILENAME:       NxAnimCache.cpp
//* OWNER:          Gary Jesdanun
//* CREATION DATE:  5/06/2002
//****************************************************************************

#ifndef	__GFX_NXANIMCACHE_H__
#define	__GFX_NXANIMCACHE_H__
                   
#include <Core/Defines.h>
#include <Core/support.h>

namespace Gfx
{
	class CBonedAnimFrameData;
};

namespace Nx
{

Gfx::CBonedAnimFrameData* GetCachedAnim( uint32 animChecksum, bool assertOnFail = true );

}

#endif // __GFX_NXANIMCACHE_H__
