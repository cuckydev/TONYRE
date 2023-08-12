/*****************************************************************************
**																			**
**					   	  Neversoft Entertainment							**
**																		   	**
**				   Copyright (C) 1999 - All Rights Reserved				   	**
**																			**
******************************************************************************
**																			**
**	Project:		GEL (Game Engine Library)								**
**																			**
**	Module:			ps2 movies												**
**																			**
**	File name:		Gel/movies/ngps/p_movies.h 								**
**																			**
**	Created: 		6/27/01	-	dc											**
**																			**
*****************************************************************************/

#ifndef __P_MOVIES_H
#define __P_MOVIES_H

/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/

#include <Core/Defines.h>
#include <Core/singleton.h>
#include <Core/List.h>
#include <Core/macros.h>

#include <bink.h>

namespace Flx
{

	void PMovies_PlayMovie( const char *pName );

} // namespace Flx

#endif	// __P_MOVIES_H



