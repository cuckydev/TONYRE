/*****************************************************************************
**																			**
**			              Neversoft Entertainment	                        **
**																		   	**
**				   Copyright (C) 1999 - All Rights Reserved				   	**
**																			**
******************************************************************************
**																			**
**	Project:		Sys Library												**
**																			**
**	Module:			Memory Manager (Mem)									**
**																			**
**	Created:		03/20/00	-	mjb										**
**																			**
**	File name:		core/Sys/Mem/heap.h										**
**																			**
*****************************************************************************/

#ifndef	__SYS_MEM_HEAP_H
#define	__SYS_MEM_HEAP_H

/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/

#ifndef __CORE_DEFINES_H
#include <Core/Defines.h>
#endif
#include "alloc.h"

/*****************************************************************************
**								   Defines									**
*****************************************************************************/

namespace Mem
{



/*****************************************************************************
**							     Type Defines								**
*****************************************************************************/

class Region;

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
class  Heap : public  Allocator 			
{
	
	
	friend class Manager;

public :
		
								Heap( Region* region, Direction dir = vBOTTOM_UP, const char* p_name = "unknown heap" );

	int							LargestFreeBlock();
	
private :
	
	virtual		void*			allocate( size_t size, bool assert_on_fail ) override;
	virtual		void			free( BlockHeader* pHeader ) override;

	virtual		int				available() override;
	virtual		void* 			reallocate_down( size_t new_size, void *pOld ) override;
	virtual		void*			reallocate_up( size_t newSize, void *pOld ) override;
	virtual		void*			reallocate_shrink( size_t newSize, void *pOld ) override;
	
				
				BlockHeader*	next_addr( BlockHeader* pHeader );
};


/*****************************************************************************
**							 Private Declarations							**
*****************************************************************************/

/*****************************************************************************
**							  Private Prototypes							**
*****************************************************************************/

/*****************************************************************************
**							  Public Declarations							**
*****************************************************************************/

/*****************************************************************************
**							   Public Prototypes							**
*****************************************************************************/

/*****************************************************************************
**								Inline Functions							**
*****************************************************************************/

} // namespace Mem

#endif  // __SYS_MEM_HEAP_H
