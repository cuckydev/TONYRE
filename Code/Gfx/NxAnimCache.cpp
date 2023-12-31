//****************************************************************************
//* MODULE:         Gfx
//* FILENAME:       NxAnimCache.cpp
//* OWNER:          Gary Jesdanun
//* CREATION DATE:  5/06/2002
//****************************************************************************

#include <Gfx/NxAnimCache.h>

#include <Gel/AssMan/AssMan.h>

#include <Gel/Scripting/checksum.h>
#include <Gel/Scripting/script.h>

#include <Gfx/BonedAnim.h>
#include <Gfx/nx.h>

namespace Nx
{

/*****************************************************************************
**							   Private Functions							**
*****************************************************************************/

///////////////////////////////////////////////////////////////////////////////
// Stub versions of all platform specific functions are provided here:
// so engine implementors can leave certain functionality until later
// (Mick Perforce: added line) 
						
/*****************************************************************************
**								Public Functions							**
*****************************************************************************/

// These functions are the platform independent part of the interface to 
// the platform specific code
// parameter checking can go here....
// although we might just want to have these functions inline, or not have them at all?

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

Gfx::CBonedAnimFrameData* GetCachedAnim( uint32 animChecksum, bool assertOnFail )
{
	if ( animChecksum == 0 )
	{
		return nullptr;
	}

	Ass::CAssMan* ass_man = Ass::CAssMan::Instance();
	return (Gfx::CBonedAnimFrameData*)ass_man->GetAsset( animChecksum, assertOnFail );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

} // Nx
