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
**	Module:			Movies													**
**																			**
**	File name:		Gel/movies/ngc/p_movies.h 								**
**																			**
**	Created: 		8/27/01	-	dc											**
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

namespace Flx
{

void PMovies_PlayMovie( const char *pName );

bool Movie_Render( void );

} // namespace Flx

#endif	// __P_MOVIES_H



