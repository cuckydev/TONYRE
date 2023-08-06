/*****************************************************************************
**																			**
**					   	  Neversoft Entertainment							**
**																		   	**
**				   Copyright (C) 1999 - All Rights Reserved				   	**
**																			**
******************************************************************************
**																			**
**	Project:		Core Library											**
**																			**
**	Module:			Standard Header											**
**																			**
**	File name:		core/defines.h											**
**																			**
**	Created:		05/27/99	-	mjb										**
**																			**
**	All code depends on the definitions in this files						**
**	It should be included in every file										**
**																			**
*****************************************************************************/

#pragma once

/*****************************************************************************
**								   Includes									**
*****************************************************************************/

#include <iostream>
#include <cstdint>

/*****************************************************************************
**								   Defines									**
*****************************************************************************/

#define vINT8_MAX   		0x7F
#define vINT8_MIN   		0x81
#define vINT16_MAX   		0x7FFF
#define vINT16_MIN   		0x8001
#define vINT32_MAX   		0x7FFFFFFF
#define vINT32_MIN   		0x80000001
#define vINT64_MAX   		0x7FFFFFFFFFFFFFFF
#define vINT64_MIN   		0x8000000000000001

#define vUINT8_MAX   		0xFF
#define vUINT16_MAX   		0xFFFF
#define vUINT32_MAX   		0xFFFFFFFF
#define vUINT64_MAX   		0xFFFFFFFFFFFFFFFF

#ifndef TRUE
#define FALSE				0
#define TRUE				(!FALSE)
#endif

/*****************************************************************************
**							     Type Defines								**
*****************************************************************************/

typedef int8_t int8;
typedef int16_t int16;

typedef uint32_t uint;
typedef uint8_t uint8;
typedef uint16_t uint16;

typedef int32_t sint;
typedef int8_t sint8;
typedef int16_t sint16;

#define vINT_MAX			vINT32_MAX
#define vINT_MIN			vINT32_MIN
#define vUINT_MAX			vUINT32_MAX

typedef int32_t int32;
typedef uint32_t uint32;
typedef int32_t sint32;
typedef int64_t int64;
typedef uint64_t uint64;
typedef int64_t sint64;

#define	vINT_BITS			32
#define	vPTR_BITS			32

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

// Alignment macros

#define nAlign(bits) alignas(bits>>3)

#define	nPad64(X)	uint64		_pad##X;
#define	nPad32(X)	uint32		_pad##X;
#define	nPad16(X)	uint16		_pad##X;
#define	nPad8(X)	uint8		_pad##X;

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

// version stamping

#define __nTIME__		__TIME__
#define __nDATE__		__DATE__

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

#define nBit(b)				( 1 << (b) )

typedef	sint				nID;
typedef	sint8				nID8;
typedef	sint16				nID16;
typedef	sint32				nID32;
typedef	sint64				nID64;

#define	nMakeID(a,b,c,d)		( (nID) ( ( (nID) (a) ) << 24 | ( (nID) (b) ) << 16 |	\
								( (nID) (c) ) << 8 | ( (nID) (d) ) ) )


//	nMakeStructID() differs from nMakeID in that struct IDs are always
//	readable from a memory dump, where as IDs would be reversed on little
//	endian machines

#if		__CPU_BIG_ENDIAN__
#define	nMakeStructID(a,b,c,d) ( (nID) ( ((nID)(a))<<24 | ((nID)(b))<<16 | \
										  ((nID)(c))<<8  | ((nID)(d)) ))
#else
#define	nMakeStructID(a,b,c,d) ( (ID) ( ((nID)(d))<<24 | ((nID)(c))<<16 | \
										  ((nID)(b))<<8  | ((nID)(a)) ))
#endif

/*****************************************************************************
**									Macros									**
*****************************************************************************/

#define	nReverse32(L)	( (( (L)>>24 ) & 0xff) | (((L)>>8) &0xff00) | (((L)<<8)&0xff0000) | (((L)<<24)&0xff000000))
#define	nReverse16(L)	( (( (L)>>8 ) & 0xff) | (((L)<<8)&0xff00) )

#if	__CPU_BIG_ENDIAN__

#define	nBgEn32(L) 	(L)
#define	nBgEn16(L) 	(L)

#define	nLtEn32(L)	nReverse32(L)
#define	nLtEn16(L)	nReverse16(L)

#else

#define	nBgEn32(L) 	nReverse32(L)
#define	nBgEn16(L) 	nReverse16(L)

#define	nLtEn32(L)	(L)
#define	nLtEn16(L)	(L)

#endif

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

#define __CPU_WORD_BALIGN__    4		// Memory word byte alignment

#define PTR_ALIGNMASK	 ( vUINT_MAX << __CPU_WORD_BALIGN__)

// The alignment macros align elements for fastest access

#define nAligned(P) 		( !( (uint) (P) & (~PTR_ALIGNMASK) ) )
#define nAlignDown(P) 		(void*)( (uint) (P) & PTR_ALIGNMASK )
#define nAlignUp(P)			(void*)( ( (uint) (P) + ( 1 << __CPU_WORD_BALIGN__ ) - 1 ) & PTR_ALIGNMASK )
#define nAlignedBy(P,A) 	( !( (uint) (P) & ( ~(vUINT_MAX << (A) ) ) ) )
#define nAlignDownBy(P,A) 	(void*)( (uint) (P) & (vUINT_MAX << (A) ) )
#define nAlignUpBy(P,A)		(void*)( ( (uint) (P) + ( 1 << (A) ) - 1 ) & ( vUINT_MAX <<( A ) ) )
#define nStorage(X)			nAlignUp ( (X) + 1 )

/****************************************************************************/

#define	nAddPointer(P,X)		(void*) ( (uint) (P) + (uint) (X) )
#define	nSubPointer(P,X)		(void*) ( (uint) (P) - (uint) (X) )

/****************************************************************************/

/*****************************************************************************
**								   Includes									**
*****************************************************************************/

#include <core/debug.h>

#include <core/support.h>
#include <sys/mem/memman.h>

#include <core/crc.h>

#include <Plat/Gfx/p_memview.h>

/******************************************************************/
/* Global new/delete operators                                    */
/*                                                                */
/******************************************************************/
inline void* 	operator new( size_t size )
{
	return Mem::Manager::sHandle().New( size, true );
}
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline void* 	operator new[] ( size_t size )
{
	return Mem::Manager::sHandle().New( size, true );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline void* 	operator new( size_t size, bool assert_on_fail )
{
	return Mem::Manager::sHandle().New( size, assert_on_fail );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline void* 	operator new[] ( size_t size, bool assert_on_fail )
{
	return Mem::Manager::sHandle().New( size, assert_on_fail );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline void*	operator new( size_t size, Mem::Allocator* pAlloc, bool assert_on_fail = true )
{
	return Mem::Manager::sHandle().New( size, assert_on_fail, pAlloc );
}
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline void*	operator new[]( size_t size, Mem::Allocator* pAlloc, bool assert_on_fail = true )
{
	return Mem::Manager::sHandle().New( size, assert_on_fail, pAlloc );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

// inline void* 	operator new( size_t size, void* pLocation )
// {
// 	return pLocation;
// }

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

// inline void* 	operator new[]( size_t size, void* pLocation )
// {
// 	return pLocation;
// }

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline void 	operator delete( void* pAddr )
{
	Mem::Manager::sHandle().Delete( pAddr );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline void 	operator delete[]( void* pAddr )
{
	Mem::Manager::sHandle().Delete( pAddr );
}

/******************************************************************/
/* only used when exception is thrown in constructor              */
/*                                                                */
/******************************************************************

inline void	operator delete( void* pAddr, Mem::Allocator* pAlloc )
{
	Mem::Manager * mem_man = Mem::Manager::Instance();
	Mem::Manager::sHandle().Delete( pAddr );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************

inline void	operator delete[]( void* pAddr, Mem::Allocator* pAlloc )
{
	Mem::Manager * mem_man = Mem::Manager::Instance();
	Mem::Manager::sHandle().Delete( pAddr );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************

inline void 	operator delete( void*, void* pLocation )
{
	return;
}
*/
