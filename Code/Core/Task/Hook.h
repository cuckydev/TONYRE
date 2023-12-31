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
**	Module:			Task (TSK_)												**
**																			**
**	File name:		Core/Task/Hook.h										**
**																			**
**	Created: 		05/27/99	-	mjb										**
**																			**
*****************************************************************************/

#ifndef	__CORE_TASK_HOOK_H
#define	__CORE_TASK_HOOK_H

/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/

/*****************************************************************************
**								   Defines									**
*****************************************************************************/

namespace Tsk
{



/*****************************************************************************
**							Class Definitions								**
*****************************************************************************/

/***********************************************************************
 *
 * Class:			BaseHook
 *
 * Description:		abstract base class for code hook 
 *					defines minimal interface
 *
 ***********************************************************************/

class  BaseHook  : public Spt::Class					
{
	

public :
	
	virtual void	Call( void ) const = 0;

protected :

	BaseHook( void ) {}
	virtual ~BaseHook() = default;

};

/***********************************************************************
 *
 * Class:			Hook< _T >
 *
 * Description:		derived template class for hook with typed data field
 *
 ***********************************************************************/

nTemplateSubClass( _T, Hook, BaseHook )
{
	

public :

	typedef void	( Code )( const Hook< _T >& );

	Hook( Code* code, _T& data );
	virtual ~Hook() = default;
	
	void			Call( void ) const;
	_T&				GetData( void ) const;

private :

	Code* const		code;
	_T&				data;

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

template < class _T > inline 
Hook< _T >::Hook( Code* _code, _T& _data ) : code( _code ), data( _data )
{
	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline 
void	Hook< _T >::Call( void ) const
{
	
	
	Dbg_AssertPtr( code );
	code( *this );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline 
_T&		Hook< _T >::GetData( void ) const
{
	
	
	Dbg_AssertType( &data, _T );
	return data;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

} // namespace Tsk

#endif	// __CORE_TASK_HOOK_H


