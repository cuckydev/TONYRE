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
#include <sys/timer.h>
#include <sys/profiler.h>
#include <sys/config/config.h>

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

#define	vSMOOTH_N  4	

static uint64 s_vblank = 0;
static uint64 s_total_vblanks = 0;
static uint64 s_stored_vblank = 0;

struct STimerInfo
{
	float	render_length;
	double	uncapped_render_length;
	int		render_buffer[vSMOOTH_N];
	uint64	render_vblank;
	uint64	render_last_vblank;
	int		render_index;
};

static STimerInfo gTimerInfo;
static STimerInfo gStoredTimerInfo;
static float xrate = 60.0f;

static void InitTimerInfo(void)
{
	static bool xrate_set = false;

	if (!xrate_set)
	{
		xrate = (float)Config::FPS();
		xrate_set = true;
	}

	gTimerInfo.render_length = 0.01666666f;		// defualt to 1/60th
	gTimerInfo.uncapped_render_length = 0.01666666f;		// defualt to 1/60th
	for (int i = 0; i < vSMOOTH_N; i++)
	{
		gTimerInfo.render_buffer[i] = 1;
	}
	gTimerInfo.render_vblank = 0;
	gTimerInfo.render_last_vblank = 0;
	gTimerInfo.render_index = 0;

	gStoredTimerInfo = gTimerInfo;

	s_stored_vblank = 0;
	s_vblank = 0;
}

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
/******************************************************************

Manager::Manager ( void )
{
	Dbg_MemberFunction;
	
	// Set the start count.
	start_count = timeGetTime();	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************

Manager::~Manager ( void )
{
	Dbg_MemberFunction;    
}

/*****************************************************************************
**							   Public Functions								**
*****************************************************************************/
 
void Init(void)
{
	InitTimerInfo();
}

void DeInit(void)
{

}

uint64 GetRenderFrame(void)
{
	return 0;
}

uint64 GetTimeInCPUCycles(void)
{
	return 0;
}

Time GetTime ( void )
{
	return GetTickCount64();
}

MicroSeconds GetTimeInUSeconds( void )
{
	return GetTickCount64() * 1000;
}

void OncePerRender(void)
{
	#	ifdef STOPWATCH_STUFF
	Script::IncrementStopwatchFrameIndices();
	Script::DumpFunctionTimes();
	Script::ResetFunctionCounts();
	#	endif

	int total = 0;
	int uncapped_total = 0;

	for (int i = 0; i < vSMOOTH_N; ++i)
	{
		int diff = gTimerInfo.render_buffer[i];
		uncapped_total += diff;

		// Handle very bad values.
		if (diff > 10 || diff < 0)
		{
			diff = 1;
		}

		// Clamp to 4.
		if (diff > 4)
		{
			diff = 4;
		}
		total += diff;
	}

	gTimerInfo.render_length = (float)total / (float)vSMOOTH_N;

	if (gTimerInfo.render_length < 1.0f)
	{
		gTimerInfo.render_length = 1.0f;
	}

	gTimerInfo.uncapped_render_length = (double)uncapped_total / (double)vSMOOTH_N;
}

uint64 GetVblanks(void)
{
	return 0; // IDK YET
}

float FrameLength()
{
	return 1000.0f / 60.0f;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

} // namespace Tmr
