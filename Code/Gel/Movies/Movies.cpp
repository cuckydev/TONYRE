/*****************************************************************************
**																			**
**			              Neversoft Entertainment			                **
**																		   	**
**				   Copyright (C) 1999 - All Rights Reserved				   	**
**																			**
******************************************************************************
**																			**
**	Project:		GEL (Game Engine Library)								**
**																			**
**	Module:			GEL					 									**
**																			**
**	File name:		movies.cpp												**
**																			**
**	Created:		5/14/1	-	mjd											**
**																			**
**	Description:	streaming movies										**
**																			**
*****************************************************************************/


/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/

#include <core/defines.h>
#include <core/macros.h>
#include <core/singleton.h>

#include <Plat/p_movies.h>

#include <sys/profiler.h>


/*****************************************************************************
**								DBG Information								**
*****************************************************************************/



namespace Flx
{



void PlayMovie( const char *pMovieName )
{
	PMovies_PlayMovie( pMovieName );
}

}  // namespace Flx
