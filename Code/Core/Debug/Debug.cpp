/*****************************************************************************
**																			**
**			              Neversoft Entertainment							**
**																		   	**
**				   Copyright (C) 1999 - All Rights Reserved				   	**
**																			**
******************************************************************************
**																			**
**	Project:		Core Library											**
**																			**
**	Module:			Debug (DBG)			 									**
**																			**
**	File name:		debug.cpp												**
**																			**
**	Created by:		05/27/99	-	mjb										**
**																			**
**	Description:	Debug message support.									**
**																			**
*****************************************************************************/


/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/

#define __ERROR_STRINGS__

#include <stdio.h>
#include <stdarg.h>
#include <Core/Defines.h>
#include <Core/Debug.h>
#include <Sys/Config/config.h>
#include <Sys/timer.h>
#include <Sys/Mem/memman.h>

#ifdef	__PLAT_NGC__
#include <dolphin.h>
#endif	// __PLAT_NGC__

#ifdef	__NOPT_ASSERT__

/*****************************************************************************
**								DBG Information								**
*****************************************************************************/

Dbg_DefineProject( Core, "Core Library")



namespace Dbg
{



/*****************************************************************************
**								  Externals									**
*****************************************************************************/

extern void					set_up ( void );
extern void					close_down ( void );
extern OutputCode			default_print;
extern AssertTrap			default_trap;

/*****************************************************************************
**								   Defines									**
*****************************************************************************/

static const int vBUFFER_SIZE = 512;

/*****************************************************************************
**								Private Types								**
*****************************************************************************/


/*****************************************************************************
**								 Private Data								**
*****************************************************************************/

static	char					s_sprintf_buffer[vBUFFER_SIZE];
static	char					s_printf_buffer[vBUFFER_SIZE];
static	Flags< Level >			s_level_mask = mNONE;

#ifdef	__NOPT_DEBUG__
static const char *s_typename[] =
{
	"ERROR!!",
	"WARNING",
	"Notify ",
	"Message"
};
#endif

static 	OutputCode*		output;


// public for Dbg_ Macros
char*			sprintf_pad	=  s_sprintf_buffer;
char*			printf_pad	=  s_printf_buffer;
#ifdef	__NOPT_DEBUG__
Signature*		current_sig;
#endif

/*****************************************************************************
**								 Public Data								**
*****************************************************************************/

#ifdef	__NOPT_DEBUG__
Project*		RegisteredProjects = nullptr;
Module*			RegisteredModules = nullptr;
#endif
/*****************************************************************************
**							  Private Prototypes							**
*****************************************************************************/

void	print(const char* text );

/*****************************************************************************
**							   Private Functions							**
*****************************************************************************/

static void		s_prefixed_output( Level level, const char* text, va_list args )
{	
	

	Dbg_AssertPtr( text );
	Dbg_Assert( level >= vERROR );
	Dbg_Assert( level <= vMESSAGE );

	if ( s_level_mask.Test( level ))
	{
		return;
	}
	
#ifdef	__NOPT_DEBUG__
    if(current_sig) {
        printf("[%s] %s - ",
               s_typename[level],
               &current_sig->GetName());
    }
#endif

	vsprintf( printf_pad, text, args);

	Dbg::print( printf_pad );
	Dbg::print( "\n" );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void		pad_printf( const char* text, ... )
{
	

	Dbg_AssertPtr( text );

	va_list args;

	va_start( args, text );

	vsprintf( sprintf_pad, text, args);
	
	va_end( args );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void		print( const char* text )
{
	

	if ( output )
	{
		output( text );
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void		message (const char *text, ... )
{	
	

	Dbg_AssertPtr( text );
	

	if ( s_level_mask.TestMask ( mMESSAGE ))
	{
		return;
	}

	va_list args;
	
	va_start( args, text );
	s_prefixed_output( vMESSAGE, text, args );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void		notify(const char *text, ... )
{
	

	Dbg_AssertPtr( text );
	
	if ( s_level_mask.TestMask ( mNOTIFY ))
	{
		return;
	}

	va_list args;
	
	va_start( args, text );
	s_prefixed_output( vNOTIFY, text, args );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void		warning(const char *text, ... )
{
	

	Dbg_AssertPtr( text );
	
	if ( s_level_mask.TestMask ( mWARNING ))
	{
		return;
	}

	va_list args;
	
	va_start( args, text );
	s_prefixed_output( vWARNING, text, args );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void		error(const char *text, ... )
{
	

	Dbg_AssertPtr( text );
	
	if ( s_level_mask.TestMask ( mERROR ))
	{
		return;
	}

	va_list args;
	
	va_start( args, text );
	s_prefixed_output( vERROR, text, args );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void		set_output( OutputCode* handler )
{
	

	Dbg_AssertPtr( handler );

	output = handler;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void		level_mask( Flags< Mask > mask )
{
	

	s_level_mask.SetMask( mask );
}


/*****************************************************************************
**							   Public Functions								**
*****************************************************************************/

void		SetUp( void )
{
	

	set_trap( default_trap );
	set_output( Dbg::default_print ); 		  	
#ifdef	__NOPT_DEBUG__
	set_up();						// platform specific setup
#endif
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void		CloseDown( void )
{
	

#ifdef	__NOPT_DEBUG__
	close_down();					// platform specific closedown
#endif
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/


} // namespace Dbg

#endif	//	__NOPT_DEBUG__

#ifdef	__PLAT_NGPS__
extern "C"
{
int snputs(const char* pszStr);
}
#endif


uint32	quick_check_checksum(uint32 _i, const char *_s, const char *f, int line);
					  
uint32	check_checksum(uint32 _i, const char *_s, const char *f, int line)
{
	(void)_s;
	(void)f;
	(void)line;
	#ifdef	__PLAT_NGPS__
	uint32* ra;											
	asm ( "daddu %0, $31, $0" : "=r" (ra) );			
	
	Dbg_MsgAssert(_i == Crc::GenerateCRCFromString(_s),("%s:%d: Checksum 0x%x does not match %s, should be 0x%x",f,line,_i,_s,Crc::GenerateCRCFromString(_s)));

	// After the assert has been run once, there is no need to run it again, so
	// patch up the calling code to call quick_check_checksum instead 	
	// we just need to inspect the code just before ra, 
	// make sure it contains the instructions for calling "check_checksum"
	// and replace it with the equivalent for "quick_check_checksum"
	// This will still all get compiled out for the release build
	// but this method lets us validata all usages of CRCD that get called.	

	// Note, due to I-Cache, this code might still be executed several times
	// as the routine will continue to be called until the cache entry for the
	// call is overwritten


	uint32	JAL_check_checksum  = 0x0c000000 + ((uint32)check_checksum >> 2);
	uint32	JAL_quick_check_checksum  = 0x0c000000 + ((uint32)quick_check_checksum >> 2);

	if (ra[-2] == JAL_check_checksum)
	{
		ra[-2] = JAL_quick_check_checksum;
	}
	
	return	quick_check_checksum(_i,_s,f,line); 
	#else
	return _i;
	#endif
}
					  
uint32	quick_check_checksum(uint32 _i, const char *_s, const char *f, int line)
{
	(void)_s;
	(void)f;
	(void)line;
	return	_i; 
}
					  
					  
