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
**	Module:			Support (SPT)											**
**																			**
**	Created:		06/10/99	mjb											**
**																			**
**	File name:		core/support/class.h									**
**																			**
**	Description:	Base class from which  classes are derived if they want	**
**                  their memory zeroed	when instantiated (via new)        	**
**																			**
*****************************************************************************/

#pragma once

#include <core/defines.h>

/*****************************************************************************
**								   Defines									**
*****************************************************************************/

#define ZERO_CLASS_MEM
 
namespace Mem
{
	class Allocator;
}

namespace Spt
{

class Class
{
	public:
	
	#if (defined ( ZERO_CLASS_MEM ))
		void *operator new( size_t size );
		void *operator new[] ( size_t size );
		void *operator new( size_t size, bool assert_on_fail );
		void *operator new[] ( size_t size, bool assert_on_fail );
		void *operator new( size_t size, Mem::Allocator* pAlloc, bool assert_on_fail = true );
		void *operator new[]( size_t size, Mem::Allocator* pAlloc, bool assert_on_fail = true );
		void *operator new( size_t size, void* pLocation );
		void *operator new[]( size_t size, void* pLocation );

		void operator delete(void *pMem) noexcept;
		void operator delete[](void *pMem) noexcept;
		void operator delete(void *pMem, bool assert_on_fail) noexcept;
		void operator delete[](void *pMem, bool assert_on_fail) noexcept;
		void operator delete(void *pMem, Mem::Allocator *pAlloc, bool assert_on_fail) noexcept;
		void operator delete[](void *pMem, Mem::Allocator *pAlloc, bool assert_on_fail) noexcept;
		void operator delete(void *pMem, void *pLocation) noexcept;
		void operator delete[](void *pMem, void *pLocation) noexcept;
	#endif // ZERO_CLASS_MEM
};

} // namespace Spt
