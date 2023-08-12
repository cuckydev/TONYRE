/*****************************************************************************
**																			**
**					   	  Neversoft Entertainment							**
**																		   	**
**				   Copyright (C) 1999 - All Rights Reserved				   	**
**																			**
******************************************************************************
**																			**
**	Project:		Core Library											**
**																			**
**	Module:			Math (MTH)			   									**
**																			**
**	File name:		core/math.h												**
**																			**
**	Created:		11/23/99	-	mjb										**
**																			**
**	Description:	Math Library											**
**																			**
*****************************************************************************/

#ifndef __CORE_MATH_H
#define __CORE_MATH_H

/*****************************************************************************
**								   Includes									**
*****************************************************************************/

#include <math.h>


// The following overlaoded functions will make sure that if you accidently call a double version of
// a trig function with a float argument, then it will simply call the float version
// (double precision is very very slow on the PS2)
/*
#ifndef __PLAT_XBOX__
inline  float  acos( float x ) {return acosf( x );}          
inline  float  asin( float x ) {return asinf( x );}          
inline  float  atan( float x ) {return atanf( x );}          
inline  float  atan2( float x, float y){return  atan2f( x , y );} 
inline  float   cos( float x ) {return cosf( x );}           
inline  float   sin( float x ) {return sinf( x );}           
inline  float   tan( float x ) {return tanf( x );}           
inline  float   fabs( float x ) {return fabsf( x );}           
#endif // ifndef __PLAT_XBOX__
*/



#ifndef __CORE_DEFINES_H
#include <Core/Defines.h>
#endif
#include <Core/support.h>
#include <Core/Math/math.h>
#include <Core/Math/vector.h>
#include <Core/Math/matrix.h>
#include <Core/Math/quat.h>		  		// need quat.h before matrix, but after vector (for the GetScalar function)

#include <Core/Math/vector.inl>
#include <Core/Math/matrix.inl>
#include <Core/Math/quat.inl>
#include <Core/Math/rect.h>

	
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/


#endif // __CORE_MATH_H
