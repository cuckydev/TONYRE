/////////////////////////////////////////////////////////////////////////////
// p_NxLightMan.cpp - Xbox platform specific interface to CLightManager

#include <core/defines.h>
#include "gfx/NxLightMan.h"
#include "Plat/Gfx/p_NxLight.h"
#include "Plat/Gfx/nx/nx_init.h"

namespace Nx
{


/////////////////////////////////////////////////////////////////////////////////////
/////////////////////////////////////////////////////////////////////////////////////
// Functions


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CLightManager::s_plat_update_engine( void )
{
	/*
	NxWn32::EngineGlobals.ambient_light_color[0] = s_world_lights.m_light_ambient_rgba.r * ( 1.0f / 128.0f ) * s_ambient_brightness;
	NxWn32::EngineGlobals.ambient_light_color[1] = s_world_lights.m_light_ambient_rgba.g * ( 1.0f / 128.0f ) * s_ambient_brightness;
	NxWn32::EngineGlobals.ambient_light_color[2] = s_world_lights.m_light_ambient_rgba.b * ( 1.0f / 128.0f ) * s_ambient_brightness;

	for( int i = 0; i < 2; ++i )
	{
		Image::RGBA	dif = CLightManager::sGetLightDiffuseColor( i );
		NxWn32::EngineGlobals.directional_light_color[( i * 8 ) + 4] = dif.r * ( 1.0f / 128.0f ) * s_diffuse_brightness[i];
		NxWn32::EngineGlobals.directional_light_color[( i * 8 ) + 5] = dif.g * ( 1.0f / 128.0f ) * s_diffuse_brightness[i];
		NxWn32::EngineGlobals.directional_light_color[( i * 8 ) + 6] = dif.b * ( 1.0f / 128.0f ) * s_diffuse_brightness[i];

		Mth::Vector dir = CLightManager::sGetLightDirection( i );
		NxWn32::EngineGlobals.directional_light_color[( i * 8 ) + 0] = -dir[X];
		NxWn32::EngineGlobals.directional_light_color[( i * 8 ) + 1] = -dir[Y];
		NxWn32::EngineGlobals.directional_light_color[( i * 8 ) + 2] = -dir[Z];
	}

	// Set third color to black.
	NxWn32::EngineGlobals.directional_light_color[( 2 * 8 ) + 4] = 0.0f;
	NxWn32::EngineGlobals.directional_light_color[( 2 * 8 ) + 5] = 0.0f;
	NxWn32::EngineGlobals.directional_light_color[( 2 * 8 ) + 6] = 0.0f;
	*/
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CLightManager::s_plat_update_lights( void )
{
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool CLightManager::s_plat_set_light_ambient_color( void )
{
	/*
	NxWn32::EngineGlobals.ambient_light_color[0] = s_world_lights.m_light_ambient_rgba.r * ( 1.0f / 128.0f ) * s_ambient_brightness;
	NxWn32::EngineGlobals.ambient_light_color[1] = s_world_lights.m_light_ambient_rgba.g * ( 1.0f / 128.0f ) * s_ambient_brightness;
	NxWn32::EngineGlobals.ambient_light_color[2] = s_world_lights.m_light_ambient_rgba.b * ( 1.0f / 128.0f ) * s_ambient_brightness;
	*/
	return true;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
Image::RGBA	CLightManager::s_plat_get_light_ambient_color()
{
	return Image::RGBA(); // s_world_lights.m_light_ambient_rgba;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool CLightManager::s_plat_set_light_direction( int light_index )
{
	/*
	int array_index = ( light_index * 8 );
	
	NxWn32::EngineGlobals.directional_light_color[array_index]		= -s_world_lights.m_light_direction[light_index][X];
	NxWn32::EngineGlobals.directional_light_color[array_index + 1]	= -s_world_lights.m_light_direction[light_index][Y];
	NxWn32::EngineGlobals.directional_light_color[array_index + 2]	= -s_world_lights.m_light_direction[light_index][Z];
	*/
	return true;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
const Mth::Vector & CLightManager::s_plat_get_light_direction( int light_index )
{
	// static Mth::Vector dir;
	// dir.Set( s_world_lights.m_light_direction[light_index][X], s_world_lights.m_light_direction[light_index][Y], s_world_lights.m_light_direction[light_index][Z] );
	static Mth::Vector why_ref;
	return why_ref;
}




/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool CLightManager::s_plat_set_light_diffuse_color( int light_index )
{
	/*
	int array_index = ( light_index * 8 ) + 4;
	
	NxWn32::EngineGlobals.directional_light_color[array_index]		= s_world_lights.m_light_diffuse_rgba[light_index].r * ( 1.0f / 128.0f ) * s_diffuse_brightness[light_index];
	NxWn32::EngineGlobals.directional_light_color[array_index + 1]	= s_world_lights.m_light_diffuse_rgba[light_index].g * ( 1.0f / 128.0f ) * s_diffuse_brightness[light_index];
	NxWn32::EngineGlobals.directional_light_color[array_index + 2]	= s_world_lights.m_light_diffuse_rgba[light_index].b * ( 1.0f / 128.0f ) * s_diffuse_brightness[light_index];
	*/
	return true;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
Image::RGBA	CLightManager::s_plat_get_light_diffuse_color( int light_index )
{
	return Image::RGBA(); // s_world_lights.m_light_diffuse_rgba[light_index];
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CLightManager::s_plat_update_colors( void )
{
	/*
	s_plat_set_light_ambient_color();
	for( int i = 0; i < MAX_LIGHTS; ++i )
	{
		s_plat_set_light_diffuse_color( i );
	}
	*/
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CModelLights *CLightManager::s_plat_create_model_lights()
{
	return new CXboxModelLights;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool CLightManager::s_plat_free_model_lights( CModelLights *p_model_lights )
{
	Dbg_Assert( p_model_lights );

	delete p_model_lights;

	return true;
}



} 
 
