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
**	Module:			Support	(SPT)											**
**																			**
**	File name:		core/support/lock.h										**
**																			**
**	Created: 		05/27/99	-	mjb										**
**																			**
*****************************************************************************/

#ifndef __CORE_LOCK_H
#define __CORE_LOCK_H

/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/

#include <Core/support.h>

/*****************************************************************************
**								   Defines									**
*****************************************************************************/


namespace Spt
{



/*****************************************************************************
**							Class Definitions								**
*****************************************************************************/

class  Access  : public Spt::Class
{
	

public :

				Access();

	void		Forbid( void );
	void		Permit( void );
	void		Enable( void );
	bool		HaveAccess( void );

private :

	sint		m_count;
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
**						Inline Functions									**
*****************************************************************************/

inline	Access::Access()
: m_count( 0 )
{
	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline	void		Access::Forbid( void )
{
	

	m_count++;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline	void		Access::Permit( void )
{
	

	m_count--;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline	void		Access::Enable( void )
{
	

	m_count = 0;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline	bool		Access::HaveAccess ( void )
{
	

	return( m_count == 0 );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

} // namespace Spt

#endif	// __CORE_LOCK_H

