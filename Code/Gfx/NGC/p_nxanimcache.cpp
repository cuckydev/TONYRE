//****************************************************************************
//* MODULE:         Gfx
//* FILENAME:       p_NxAnimCache.cpp
//* OWNER:          Gary Jesdanun
//* CREATION DATE:  5/06/2002
//****************************************************************************

#include <gfx/ngc/p_nxanimcache.h>

namespace Nx
{

/*****************************************************************************
**							   Private Functions							**
*****************************************************************************/
						
/*****************************************************************************
**								Public Functions							**
*****************************************************************************/

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CNgcAnimCache::CNgcAnimCache( int lookupTableSize ) : CAnimCache( lookupTableSize )
{
	// Machine specific code here ............
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CNgcAnimCache::~CNgcAnimCache()
{
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

} // Nx
				

