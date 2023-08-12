/*****************************************************************************
**																			**
**			              Neversoft Entertainment							**
**																		   	**
**				   Copyright (C) 1999 - All Rights Reserved				   	**
**																			**
******************************************************************************
**																			**
**	Project:		SYS Library												**
**																			**
**	Module:			Timer (TMR)			 									**
**																			**
**	File name:		ngps/p_timer.cpp										**
**																			**
**	Created by:		09/25/00	-	dc										**
**																			**
**	Description:	XBox System Timer										**
**																			**
*****************************************************************************/


/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/

#include <windows.h>
#include <mmsystem.h>
#include <time.h>
#include <Sys/timer.h>
#include <Sys/Profiler.h>
#include <Sys/Config/config.h>

#include <Plat/Gfx/nx/nx_init.h>

/*****************************************************************************
**							  DBG Information								**
*****************************************************************************/

namespace Tmr 
{

/*****************************************************************************
**								  Externals									**
*****************************************************************************/

/*****************************************************************************
**								   Defines									**
*****************************************************************************/

/*****************************************************************************
**								Private Types								**
*****************************************************************************/

/*****************************************************************************
**								 Private Data								**
*****************************************************************************/

//static clock_t			start_count;

static float s_slomo = 1.0f;

/*****************************************************************************
**								 Public Data								**
*****************************************************************************/

/*****************************************************************************
**							  Private Prototypes							**
*****************************************************************************/

/*****************************************************************************
**							   Private Functions							**
*****************************************************************************/

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

/*

Manager::Manager ( void )
{
	Dbg_MemberFunction;
	
	// Set the start count.
	start_count = timeGetTime();	
}
*/

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

/*
Manager::~Manager ( void )
{
	Dbg_MemberFunction;    
}
*/

/*****************************************************************************
**							   Public Functions								**
*****************************************************************************/
 
void Init(void)
{

}

void DeInit(void)
{

}

void RestartClock(void)
{

}

uint64 GetRenderFrame(void)
{
	return NxWn32::EngineGlobals.frame_count;
}

uint64 GetTimeInCPUCycles(void)
{
	return GetTickCount64();
}

Time GetTime ( void )
{
	return (Time)GetTickCount64();
}

MicroSeconds GetTimeInUSeconds( void )
{
	return GetTickCount64() * 1000;
}

float GetSlomo(void)
{
	return s_slomo;
}

void SetSlomo(float slomo)
{
	s_slomo = slomo;
}

// when pausing the game, call this to store the current state of OncePerRender( ) (only essential in replay mode)
void StoreTimerInfo(void)
{
}

void RecallTimerInfo(void)
{
}

void OncePerRender(void)
{
	
}

uint64 GetVblanks(void)
{
	return NxWn32::EngineGlobals.frame_count;
}

float FrameLength()
{
	return 1.0f / 60.0f * GetSlomo();
}

double UncappedFrameLength()
{
	return 1.0 / 60.0;
}

void VSync(void)
{
	// uint64 now = GetVblanks();
	// while (now == GetVblanks());
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

} // namespace Tmr
