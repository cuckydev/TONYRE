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
**	File name:		assert.cpp												**
**																			**
**	Created by:		05/27/99	-	mjb										**
**																			**
**	Description:	Assert support code										**
**																			**
*****************************************************************************/


/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/

#include <stdio.h>
#include <Core/Defines.h>
#include <Core/support.h>
#include <Core/Debug.h>

#include <Sys/Config/config.h>

#ifdef __PLAT_WN32__
#include <Windows.h>
#endif

#ifdef __NOPT_ASSERT__

/*****************************************************************************
**								DBG Information								**
*****************************************************************************/


namespace Dbg
{



/*****************************************************************************
**								  Externals									**
*****************************************************************************/


/*****************************************************************************
**								   Defines									**
*****************************************************************************/

static const int vASSERT_BUFFER_SIZE = 1024;

/*****************************************************************************
**								Private Types								**
*****************************************************************************/


/*****************************************************************************
**							  Private Prototypes							**
*****************************************************************************/


/*****************************************************************************
**								 Private Data								**
*****************************************************************************/

static 	AssertTrap*		assert_trap_handler = nullptr;
static 	bool			screen_assert_active = false;

// made public for Dbg_ Macros
const char *msg_null_pointer = "Null Pointer";
const char *msg_misaligned_pointer = "Pointer not aligned";			 
const char *msg_pointer_to_free_mem = "Pointer to free mem";
const char *msg_unknown_reason = "No reason supplied";
const char *msg_type_mismatch = "Type Mismatch: \"%s\" is of type \"%s\" - not a valid \"%s\"";

/*****************************************************************************
**								 Public Data								**
*****************************************************************************/


/*****************************************************************************
**							   Private Functions							**
*****************************************************************************/

void	set_trap( AssertTrap* trap ) 
{
	assert_trap_handler = trap;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void	screen_assert( bool on ) 
{
	screen_assert_active = on;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void		Assert( const char* file, uint line, const char* reason )
{
	// Show an assertion failure dialog box
	static char assert_buffer1[vASSERT_BUFFER_SIZE];
	sprintf(assert_buffer1, "ASSERTION FAILED:\n\n%s (%d)\n\n%s\n\n", file, line, reason);
	
	#ifdef __PLAT_WN32__
		// Check if debugger is present
		if (IsDebuggerPresent())
		{
			// There will be a breakpoint triggered later on..
			fprintf(stderr, "%s", assert_buffer1);
		}
		else
		{
			// Show dialog box
			MessageBox(nullptr, assert_buffer1, "Assertion Failure", MB_OK | MB_ICONERROR);
		}
	#else
		// Output to stderr
		fprintf(stderr, "%s", assert_buffer1);
	#endif
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

#if ( defined ( __PLAT_XBOX__ ) || defined ( __PLAT_WN32__ ))
void		assert_vcc( char* file, uint line, char* reason )
{
	static	char		assert_buffer[vASSERT_BUFFER_SIZE];
	static	char*		tmp = assert_buffer; 

	sprintf( tmp, "ASSERTION: %s(%d)\n%s\n\n", 
		file, line, reason ); 

	if ( assert_trap_handler != nullptr )
	{
		Dbg_Printf( "%s\n", tmp );
		assert_trap_handler( tmp );
	}
	else
	{
		Dbg_Printf( "%s\n", tmp );
		Dbg_Printf( "!!NO TRAP HANDLER SET!!\n" );
	}
}
#endif // #ifdef __PLAT_XBOX__

/*****************************************************************************
**							   Public Functions								**
*****************************************************************************/

} // namespace Dbg

#endif	//__NOPT_DEBUG__
