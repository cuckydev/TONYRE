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

#include <time.h>
#include <Sys/timer.h>
#include <Sys/Profiler.h>
#include <Sys/Config/config.h>

#include <Plat/Gfx/nx/nx_init.h>

#include <chrono>

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

static double GetDoubleTime(void)
{
	const auto current = std::chrono::steady_clock::now().time_since_epoch();
	double seconds = std::chrono::duration<double>(current).count();
	return seconds;
	/*
	static LARGE_INTEGER freq;
	static bool first = true;
	if (first)
	{
		QueryPerformanceFrequency(&freq);
		first = false;
	}
	LARGE_INTEGER now;
	QueryPerformanceCounter(&now);
	return (double)now.QuadPart / (double)freq.QuadPart;
	*/
}
 
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
	return GetTimeInUSeconds();
}

Time GetTime ( void )
{
	return (Time)(GetDoubleTime() * 1000.0);
}

MicroSeconds GetTimeInUSeconds( void )
{
	return (MicroSeconds)(GetDoubleTime() * 1000000.0);
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

double delta = 0.001;
void OncePerRender(void)
{
	static double last_tick = GetDoubleTime();
	double now = GetDoubleTime();
	delta = now - last_tick;
	if (delta < 0.001)
		delta = 0.001;
	last_tick = now;
}

uint64 GetVblanks(void)
{
	return NxWn32::EngineGlobals.frame_count;
}

float FrameLength()
{
	return (float)(UncappedFrameLength() * GetSlomo());
}

double UncappedFrameLength()
{
	return delta;
	// return 1.0 / 60.0;
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
