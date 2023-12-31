/*****************************************************************************
**																			**
**					   	  Neversoft Entertainment							**
**																		   	**
**				   Copyright (C) 1999 - All Rights Reserved				   	**
**																			**
******************************************************************************
**																			**
**	Project:		GEL (Game Engine Library)								**
**																			**
**	Module:			Module  (MDL)											**
**																			**
**	File name:		Gel/module.h											**
**																			**
**	Created: 		05/27/99	-	mjb										**
**																			**
*****************************************************************************/

#pragma once

/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/

#include <Core/support.h>
#include <Core/Task.h>

/*****************************************************************************
**								   Defines									**
*****************************************************************************/

namespace Mdl
{

class Manager;

/*****************************************************************************
**							Class Definitions								**
*****************************************************************************/

class  Module  : public Spt::Class
{
	

	friend class			Manager;

	friend Tsk::Task< Manager >::Code	MDL_process_modules;

public :

							Module ( void );
	virtual	 				~Module ( void );

	void					Lock ( void );
	void					Unlock ( void );

	bool					Running ( void ) const;
	bool					Locked ( void ) const;

private :

	enum State
	{
		vSTOPPED,
		vRUNNING
	};

	enum Command
	{
		vNONE,
		vSTART,
		vSTOP,
		vRESTART,
	};
	virtual	void			v_start_cb ( void ) = 0;
	virtual	void			v_stop_cb ( void ) = 0;

	State					state;
	Command					command;
	bool					locked;
	Lst::Node<Module>*		node;

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

inline void			Module::Lock ( void )
{
   	

	locked = true;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline void			Module::Unlock ( void )
{
   	

	locked = false;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline	bool		Module::Locked ( void ) const
{
   	

	return locked;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline bool			Module::Running ( void ) const
{
   	

	return ( state == vRUNNING );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

} // namespace Mdl
