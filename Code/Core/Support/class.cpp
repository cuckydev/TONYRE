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
**	Module:			Support (SPT) 											**
**																			**
**	File name:		class.cpp												**
**																			**
**	Created by:		06/10/99	-	mjb										**
**																			**
**	Description:	Base class from which all other classes are derived.	**
**																			**
*****************************************************************************/

/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/

#include <stdio.h>
#include <string.h>

#include <Core/Defines.h>
#include <Core/support.h>
#include <Sys/Mem/memman.h>

/*****************************************************************************
**							  DBG Information								**
*****************************************************************************/

#define NUM_ADDRESS 0		// Change this to 8 to have a handy list of addresses to check.
							// If set to 0, no extra code/data will be generated.
							// Remember to change to 8, compile, then get the addresses in question
							// as the act of adding this code/data will change your addresses.
#if NUM_ADDRESS > 0
uint32 gAddress[NUM_ADDRESS] =
{
	0x81701061,
	0x81700ee1,
	0x81700d61,
	0x81700be1,
	0x81700a61,
	0x817008e1,
	0x81700761,
	0x817005e1
};

static void check_address( void * p, int size )
{
	for ( int lp = 0; lp < 8; lp++ )
	{
		if ( gAddress[lp] == ((uint32)p) ) {
			Dbg_Message( "We found the address we're looing for: 0x%08x (%d)\n", (uint32)p, size );
		}
	}
}

#else
#define check_address(a,b)
#endif

#ifdef __PLAT_NGC__

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
static inline void* 	operator new( size_t size )
{
//	Dbg_SetPlacementNew( false );
	void * rv = Mem::Manager::sHandle().New( size, true );
	check_address( rv, size );
	return rv;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
static inline void* 	operator new[] ( size_t size )
{
//	Dbg_SetPlacementNew( false );
	void * rv = Mem::Manager::sHandle().New( size, true );
	check_address( rv, size );
	return rv;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
static inline void 	operator delete( void* pAddr )
{
	Mem::Manager::sHandle().Delete( pAddr );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
static inline void 	operator delete[]( void* pAddr )
{
	Mem::Manager::sHandle().Delete( pAddr );
}

#endif		// __PLAT_NGC__



namespace Spt
{

/******************************************************************/
/* new operators - same as global + zero-ed memory                */
/*                                                                */
/******************************************************************/

#if (defined ( ZERO_CLASS_MEM ))

void* 	Class::operator new( size_t size )
{
	void *ptr = ::operator new(size);
	memset(ptr, 0, size);
	return ptr;
}

void* 	Class::operator new[] ( size_t size )
{
	void *ptr = ::operator new(size);
	memset(ptr, 0, size);
	return ptr;
}

void* 	Class::operator new( size_t size, bool assert_on_fail )
{
	(void)assert_on_fail;
	void *ptr = ::operator new(size);
	memset(ptr, 0, size);
	return ptr;
}

void* 	Class::operator new[] ( size_t size, bool assert_on_fail )
{
	(void)assert_on_fail;
	void *ptr = ::operator new(size);
	memset(ptr, 0, size);
	return ptr;
}

void*	Class::operator new( size_t size, Mem::Allocator* pAlloc, bool assert_on_fail )
{
	(void)pAlloc;
	(void)assert_on_fail;
	void *ptr = ::operator new(size);
	memset(ptr, 0, size);
	return ptr;
}

void*	Class::operator new[]( size_t size, Mem::Allocator* pAlloc, bool assert_on_fail )
{
	(void)pAlloc;
	(void)assert_on_fail;
	void *ptr = ::operator new(size);
	memset(ptr, 0, size);
	return ptr;
}

void* 	Class::operator new( size_t size, void* pLocation )
{
	memset(pLocation, 0, size);
	return pLocation;
}

void* 	Class::operator new[]( size_t size, void* pLocation )
{
	memset(pLocation, 0, size);
	return pLocation;
}

void Class::operator delete(void *pMem) noexcept { free(pMem); }
void Class::operator delete[](void *pMem) noexcept { free(pMem); }
void Class::operator delete(void *pMem, bool assert_on_fail) noexcept { (void)assert_on_fail;  free(pMem); }
void Class::operator delete[](void *pMem, bool assert_on_fail) noexcept { (void)assert_on_fail; free(pMem); }
void Class::operator delete(void *pMem, Mem::Allocator *pAlloc, bool assert_on_fail) noexcept { (void)pAlloc; (void)assert_on_fail; free(pMem); }
void Class::operator delete[](void *pMem, Mem::Allocator *pAlloc, bool assert_on_fail) noexcept { (void)pAlloc; (void)assert_on_fail; free(pMem); }
void Class::operator delete(void *pMem, void *pLocation) noexcept { (void)pMem; (void)pLocation; }
void Class::operator delete[](void *pMem, void *pLocation) noexcept { (void)pMem; (void)pLocation; }

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
#endif
} // namespace Spt

