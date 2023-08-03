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
#include <core/defines.h>
#include <core/support.h>
#include <core/debug.h>

#include <sys/config/config.h>

#ifndef __PLAT_WN32__
#include <gfx/gfxman.h>
#endif // __PLAT_WN32__

#ifdef __PLAT_NGPS__
int DumpUnwindStack( int iMaxDepth, int *pDest );
#include <libdev.h>
#endif

#ifdef __PLAT_NGC__
#include <dolphin.h>
#define _output OSReport
#else
#define _output printf
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

static const int vASSERT_BUFFER_SIZE = 512;

/*****************************************************************************
**								Private Types								**
*****************************************************************************/


/*****************************************************************************
**							  Private Prototypes							**
*****************************************************************************/


/*****************************************************************************
**								 Private Data								**
*****************************************************************************/

static 	AssertTrap*		assert_trap_handler = NULL;
static 	bool			screen_assert_active = false;

// made public for Dbg_ Macros
char*			msg_null_pointer		= "Null Pointer";
char*			msg_misaligned_pointer	= "Pointer not aligned";			 
char*			msg_pointer_to_free_mem	= "Pointer to free mem";
char*			msg_unknown_reason		= "No reason supplied";
char*			msg_type_mismatch		= "Type Mismatch: \"%s\" is of type \"%s\" - not a valid \"%s\"";

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

void		Assert( char* file, uint line, char* reason )
{
	static	char		assert_buffer1[vASSERT_BUFFER_SIZE];
	static	char		assert_buffer3[vASSERT_BUFFER_SIZE];
	static	char*		tmp1 = assert_buffer1; 
	static	char*		tmp3 = assert_buffer3; 


#if 1 // !( defined ( __PLAT_XBOX__ ) || defined ( __PLAT_WN32__ ))
	
	static int again = 0;
	if (again) 
	{
		_output ("MEM CONTEXT: %s\n",Mem::Manager::sHandle().GetContextName());
				
		_output( "LOOPED ASSERTION: %s(%d)\n%s\n\n", 
			file, line, reason );
		_output ("Real Assertion: %s\n%s\n",tmp1,tmp3);
		while (1);			// and hang... 
	}
	again = 1;
	
	_output ("\n--------------------------------------------------\nPLEASE COPY FROM A FEW LINES ABOVE HERE\n\nCURRENT MEM CONTEXT: %s\n\n"
			,Mem::Manager::sHandle().GetContextName());
	Mem::Manager& mem_man = Mem::Manager::sHandle();
//	Mem::Heap* heap = mem_man.TopDownHeap();
//	Mem::Region* region = heap->ParentRegion();
//	_output ("TopDown  Fragmentation %7dK, in %5d Blocks\n",heap->mFreeMem.m_count / 1024, heap->mFreeBlocks.m_count);
//	_output ("         used          %7dK, in %5d Blocks\n",heap->mUsedMem.m_count / 1024, heap->mUsedBlocks.m_count);
//	heap = mem_man.BottomUpHeap();
//	_output ("BottomUp Fragmentation %7dK, in %5d Blocks\n",heap->mFreeMem.m_count / 1024, heap->mFreeBlocks.m_count);
//	_output ("         used          %7dK, in %5d Blocks\n",heap->mUsedMem.m_count / 1024, heap->mUsedBlocks.m_count);
//	_output ("Shared Region %dK free out of %d K available\n", region->MemAvailable() / 1024, region->TotalSize() / 1024 );

	_output("Name            Used  Frag  Free   Min  Blocks\n");
	_output("--------------- ----- ----- ---- ------ ------\n");
	Mem::Heap* heap;
	for (heap = mem_man.FirstHeap(); heap != NULL; heap = mem_man.NextHeap(heap))
	{		
			Mem::Region* region = heap->ParentRegion();			
			_output( "%12s: %5dK %4dK %4dK %4dK  %5d \n",
					heap->GetName(),
					heap->mUsedMem.m_count / 1024,
					heap->mFreeMem.m_count / 1024,
					region->MemAvailable() / 1024,
					region->MinMemAvailable() / 1024,
					heap->mUsedBlocks.m_count
					);										
	}
	
	_output( "FILE:      %s(%d)\nASSERTION: %s\n\n", 
		file, line, reason ); 
	_output( tmp1, "FILE:      %s(%d) ", file, line ); 
	_output( tmp3, "ASSERTION: %s", reason ); 
	// attempt to dump the call stack
	// requires that you have the correct .map file, along with the executable
	#ifndef __PLAT_WN32__
	MemView_FindLeaks();
	#endif
		
	_output( "\nCALL STACK ..........................\n\n");
	
	#ifdef __PLAT_NGPS__
	DumpUnwindStack( 40, NULL );
	#endif
		
	
#endif

	// Trigger Visual Studio breakpoint
	#ifdef __PLAT_WN32__
		__asm int 3;
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

	if ( assert_trap_handler != NULL )
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
