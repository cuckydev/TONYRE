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
**	File name:		p_soundtrack.cpp										**
**																			**
**	Created:		11/29/01	-	dc										**
**																			**
**	Description:	Xbox specific user soundtrack code						**
**																			**
*****************************************************************************/


/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/

#include <xtl.h>
#include <Core/macros.h>
#include <Core/Defines.h>
#include <Core/math.h>
#include <Sys/File/xbox/hed.h>
#include <Gel/SoundFX/soundfx.h>

#include "p_music.h"
#include "p_soundtrack.h"

/*****************************************************************************
**								DBG Information								**
*****************************************************************************/

/*****************************************************************************
**								  Externals									**
*****************************************************************************/

namespace Pcm
{

/*****************************************************************************
**								   Defines									**
*****************************************************************************/

#define MAX_SOUNDTRACKS	100

/*****************************************************************************
**								Private Types								**
*****************************************************************************/

/*****************************************************************************
**								 Private Data								**
*****************************************************************************/

XSOUNDTRACK_DATA	soundtrackData[MAX_SOUNDTRACKS];
bool				initialised = false;

/*****************************************************************************
**								 Public Data								**
*****************************************************************************/

int gNumSoundtracks = 0;

/*****************************************************************************
**							   Private Functions							**
*****************************************************************************/

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/


/*****************************************************************************
**							   Public Functions								**
*****************************************************************************/

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
int GetNumSoundtracks( void )
{
	BOOL				rv;
	HANDLE				h_strack;

	if( initialised )
	{
		return gNumSoundtracks;
	}

	initialised		= true;
	gNumSoundtracks	= 0;

	h_strack = XFindFirstSoundtrack( &soundtrackData[gNumSoundtracks] );
	if( h_strack != INVALID_HANDLE_VALUE )
	{
		do
		{
			++gNumSoundtracks;

			// Don't go over the maximum (should be a system-limit of 100 anyway).
			if( gNumSoundtracks >= MAX_SOUNDTRACKS )
			{
				break;
			}

			rv = XFindNextSoundtrack( h_strack, &soundtrackData[gNumSoundtracks] );
		}	
		while( rv );
	}

	return gNumSoundtracks;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
const WCHAR* GetSoundtrackName( int soundtrack )
{
	if( soundtrack < gNumSoundtracks )
	{
		return soundtrackData[soundtrack].szName;
	}
	return nullptr;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
unsigned int GetSoundtrackNumSongs( int soundtrack )
{
	if( soundtrack < gNumSoundtracks )
	{
		return soundtrackData[soundtrack].uSongCount;
	}
	return nullptr;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
const WCHAR* GetSongName( int soundtrack, int track )
{
	static WCHAR wcSongName[MAX_SONG_NAME];

	if( soundtrack < gNumSoundtracks )
	{
		// Check the track is within limits.
		if((UINT)track < soundtrackData[soundtrack].uSongCount )
		{
			DWORD dwSongID;
			DWORD dwSongLength;

			BOOL rv = XGetSoundtrackSongInfo(	soundtrackData[soundtrack].uSoundtrackId,
												track,
												&dwSongID,
												&dwSongLength,
												wcSongName,
												MAX_SONG_NAME );

			if( rv )
			{
				return wcSongName;
			}
		}
	}
	return nullptr;
}


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
HANDLE GetSoundtrackWMAHandle( int soundtrack, int track )
{
	if( soundtrack < gNumSoundtracks )
	{
		// Check the track is within limits.
		if((UINT)track < soundtrackData[soundtrack].uSongCount )
		{
			DWORD dwSongID;
			DWORD dwSongLength;

			BOOL rv = XGetSoundtrackSongInfo(	soundtrackData[soundtrack].uSoundtrackId,
												track,
												&dwSongID,
												&dwSongLength,
												nullptr,
												0 );

			if( rv )
			{
				// Second parameter is true for asynchronous mode reads.
				HANDLE h_song = XOpenSoundtrackSong( dwSongID, TRUE );
				return h_song;
			}
		}
	}
	return INVALID_HANDLE_VALUE;
}




} // namespace PCM
