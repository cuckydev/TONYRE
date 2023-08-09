/*****************************************************************************
**																			**
**			              Neversoft Entertainment			                **
**																		   	**
**				   Copyright (C) 1999 - All Rights Reserved				   	**
**																			**
******************************************************************************
**																			**
**	Project:		GFX (Graphics Library)									**
**																			**
**	Module:			Game Engine (GEL)	 									**
**																			**
**	File name:		p_music.cpp												**
**																			**
**	Created:		07/24/01	-	dc										**
**																			**
**	Description:	Xbox specific .wma streaming code						**
**																			**
*****************************************************************************/


/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/

#include <SDL.h>

#include <core/macros.h>
#include <core/defines.h>
#include <core/math.h>
#include <core/crc.h>

#include "p_music.h"

#include <sys/config/config.h>
#include <gel/soundfx/soundfx.h>

/*****************************************************************************
**								DBG Information								**
*****************************************************************************/

/*****************************************************************************
**								  Externals									**
*****************************************************************************/

namespace Pcm
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void PCMAudio_Init( void )
{
	Dbg_Assert(SDL_WasInit(0) != 0);
}



/******************************************************************/
/*                                                                */
/* Call every frame to make sure music and stream buffers are	  */
/* loaded and current status is checked each frame...			  */
/*                                                                */
/******************************************************************/
int PCMAudio_Update( void )
{
	return 0;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void PCMAudio_StopMusic( bool waitPlease )
{
	
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void PCMAudio_StopStream( int whichStream, bool waitPlease )
{
	
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void PCMAudio_StopStreams( void )
{
	
}


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

// This is temp code for the preload streams.  It just calls the normal one.

static uint32 sPreLoadChecksum[NUM_STREAMS];
static uint32 sPreLoadMusicChecksum;

/******************************************************************/
/*                                                                */
/* Get a stream loaded into a buffer, but don't play yet		  */
/*                                                                */
/******************************************************************/
bool PCMAudio_PreLoadStream( uint32 checksum, int whichStream )
{
	return true;
}



/******************************************************************/
/*                                                                */
/* Returns true if preload done. Assumes that caller is calling	  */
/* this on a preloaded, but not yet played, stream. The results	  */
/* are meaningless otherwise.									  */
/*                                                                */
/******************************************************************/
bool PCMAudio_PreLoadStreamDone( int whichStream )
{
	return true;
}



/******************************************************************/
/*                                                                */
/* Tells a preloaded stream to start playing.					  */
/* Must call PCMAudio_PreLoadStreamDone() first to guarantee that */
/* it starts immediately.										  */
/*                                                                */
/******************************************************************/
bool PCMAudio_StartPreLoadedStream( int whichStream, Sfx::sVolume *p_volume, float pitch )
{
	return true;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool PCMAudio_PreLoadMusicStream( uint32 checksum )
{
	return true;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool PCMAudio_PreLoadMusicStreamDone( void )
{
	return true;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool PCMAudio_StartPreLoadedMusicStream( void )
{
	return true;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
int PCMAudio_GetMusicStatus( void )
{
	return PCM_STATUS_PLAYING;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
int PCMAudio_GetStreamStatus( int whichStream )
{
	return PCM_STATUS_PLAYING;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void PCMAudio_Pause( bool pause, int ch )
{
	
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool PCMAudio_TrackExists( const char *pTrackName, int ch )
{
	return true;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool PCMAudio_LoadMusicHeader( const char *nameOfFile )
{
	// Legacy call left over from PS2 code.
	return true;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool PCMAudio_LoadStreamHeader( const char *nameOfFile )
{
	// Legacy call left over from PS2 code.
	return true;
}


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
uint32 PCMAudio_FindNameFromChecksum( uint32 checksum, int ch )
{
	return 0;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool PCMAudio_SetStreamVolume( Sfx::sVolume *p_volume, int whichStream )
{
	return true;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
int PCMAudio_SetMusicVolume( float volume )
{
	return true;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool PCMAudio_SetStreamPitch( float fPitch, int whichStream )
{
	return true;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool PCMAudio_PlayMusicTrack( uint32 checksum )
{
	return false;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool PCMAudio_PlayMusicTrack( const char *filename )
{
	return true;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool PCMAudio_PlaySoundtrackMusicTrack( int soundtrack, int track )
{
	return true;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool PCMAudio_StartStream( int whichStream )
{
	return true;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool PCMAudio_PlayStream( uint32 checksum, int whichStream, Sfx::sVolume *p_volume, float fPitch, bool preload )
{
	return true;
}


} // namespace PCM
