/*	Useful little macros...
	
	Add any macros you want into this:
*/

#ifndef __USEFUL_LITTLE_MACROS_H__
#define __USEFUL_LITTLE_MACROS_H__

#include <Core/Defines.h>
#include <Core/support.h>

#include <Plat/Gfx/nx/nx_init.h>

#define PERCENT_MULT			( ( 1.0f ) / 100.0f )
#define PERCENT( x, percent )	( ( ( ( ( float )( x ) ) * ( ( float )( percent ) ) ) * PERCENT_MULT ) )

#define		IPU			(1.0f)			// Inches per unit					
																
#define		INCHES(x)						((float)(x))
#define		INCHES_PER_SECOND(x)			((float)(x))
#define		INCHES_PER_SECOND_SQUARED(x)	((float)(x))

#define 	FEET_TO_INCHES( x )				( x * 12.0f )
#define		FEET(x)							((float)(x*12.0f))					  

#define 	FEET_PER_MILE					5280.0f
#define 	MPH_TO_INCHES_PER_SECOND( x )	( ( ( x ) * FEET_PER_MILE * 12.0f ) / ( 60.0f * 60.0f ) )
#define		MPH_TO_IPS( x )					MPH_TO_INCHES_PER_SECOND( x )
#define		INCHES_PER_SECOND_TO_MPH( x )	( ( x ) / 12.0f / FEET_PER_MILE * 60.0f * 60.0f )
#define		IPS_TO_MPH( x )					INCHES_PER_SECOND_TO_MPH( x )

#define		RADIANS_PER_SECOND_TO_RPM( x )	(9.5496f * ( x ))
#define		RPM_TO_RADIANS_PER_SECOND( x )	(0.10472f * ( x ))

#define		DEGREES_TO_RADIANS( x ) 		( ( x ) * ( 2.0f * Mth::PI / 360.0f ) )
#define		RADIANS_TO_DEGREES( x ) 		( ( x ) / ( DEGREES_TO_RADIANS( 1.0f ) ) )
#define		THE_NUMBER_OF_THE_BEAST			666



// Takes screen coordinates in 'default' screen space - 640x448 - and converts them based on PAL and system defines.


// Convert from logical to SCREEN coordinates
#define SCREEN_CONV_X( x ) ((( x ) * NxWn32::EngineGlobals.screen_conv_x_multiplier ) + NxWn32::EngineGlobals.screen_conv_x_offset )
#define SCREEN_CONV_Y( y ) ((( y ) * NxWn32::EngineGlobals.screen_conv_y_multiplier ) + NxWn32::EngineGlobals.screen_conv_y_offset )

// Convert from screen to LOGICAL coordinates
#define		LOGICAL_CONV_X( x ) (x)
#define		LOGICAL_CONV_Y( y ) (y)

#endif // __USEFUL_LITTLE_MACROS_H__

