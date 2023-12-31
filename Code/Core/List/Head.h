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
**	Module:			List (LST_)												**
**																			**
**	File name:		Core/List/Head.h										**
**																			**
**	Created: 		05/27/99	-	mjb										**
**																			**
*****************************************************************************/

#pragma once

/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/

#include <Core/support.h>
#include <Core/List/Node.h>

/*****************************************************************************
**								   Defines									**
*****************************************************************************/

namespace Lst
{



/*****************************************************************************
**							Class Definitions								**
*****************************************************************************/

/***********************************************************************
 *
 * Class:			Head
 *
 * Description:		Linked-list head node. 
 *
 ***********************************************************************/

nTemplateSubClass( _T, Head, Node< _T > )
{

public:
					Head( void );
	virtual			~Head( void ) override;

	void			Merge( Head< _T >* dest );		// Source list will be empty after merge
	uint			CountItems( void );
	Node< _T >*		GetItem( uint number );			// Zero-based ( 0 will return first node )
	
	void			AddNode( Node< _T >* node );	// Using priority
	void			AddNodeFromTail( Node< _T >* node );	// Using priority, search backwards from tail (i.e same-priorties are appended rather than pre-pended)
	bool			AddUniqueSequence( Node< _T >* node );	// Only add if priority is unique
																		// and priority decreases
	void			AddToTail( Node< _T >* node );
	void			AddToHead( Node< _T >* node );

	void			RemoveAllNodes( void );
	void			DestroyAllNodes( void );  		// ONLY USE FOR INHERITED LISTS
	bool			IsEmpty( void );

	Node< _T >*		FirstItem();					// get first node, or nullptr if none 


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
Head< _T >::Head( void )
: Node< _T > ( reinterpret_cast < _T* >( Node<_T>::vHEAD_NODE ) ) 
{
	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline	
Head< _T >::~Head( void )
{
	

	Dbg_MsgAssert(this->IsEmpty(),( "List is not empty" ));
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline	
void	Head< _T >::AddNode( Node< _T >* node )
{
	Dbg_AssertType(node, Node<_T>);
	Dbg_MsgAssert(this->is_head(), ("Object is not a list"));
	Dbg_MsgAssert(!node->InList(), ("Object is already in a list"));

	Node<_T> *node_ptr = this;
	typename Node<_T>::Priority new_pri = node->GetPri();

	while (( node_ptr = node_ptr->GetNext() ) != nullptr)
	{
		if ( node_ptr->GetPri() <= new_pri )
		{
			node_ptr->Insert( node );
			return;
		}
	}

	this->Insert( node );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline	
void	Head< _T >::AddNodeFromTail( Node< _T >* node )
{
	Dbg_AssertType(node, Node<_T>);
	Dbg_MsgAssert(this->is_head(), ("Object is not a list"));
	Dbg_MsgAssert(!node->InList(), ("Object is already in a list"));

	Node<_T> *node_ptr = this;
	typename Node<_T>::Priority new_pri = node->GetPri();

	while (( node_ptr = node_ptr->GetPrev() ) != nullptr)
	{
		if ( node_ptr->GetPri() >= new_pri )
		{
			node_ptr->Append( node );
			return;
		}
	}

	this->Append( node );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline
bool	Head< _T >::AddUniqueSequence( Node< _T >* node )
{
	Dbg_AssertType(node, Node<_T>);
	Dbg_MsgAssert(this->is_head(), ("Object is not a list"));
	Dbg_MsgAssert(!node->InList(), ("Object is already in a list"));

	Node<_T> *node_ptr = this;
	typename Node<_T>::Priority new_pri = node->GetPri();

	while (( node_ptr = node_ptr->GetNext() ) != nullptr)
	{
		if ( node_ptr->GetPri() == new_pri )
		{
			return false;
		}
		else if ( node_ptr->GetPri() > new_pri )
		{
			node_ptr->Insert( node );
			return true;
		}
	}

	this->Insert( node );
	return true;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline	
void		Head< _T >::Merge( Head< _T >* dest )
{
	Dbg_AssertType( dest, Head< _T > );
	Dbg_MsgAssert( this->is_head (),( "Object is not a list" ));
	Dbg_MsgAssert( dest->is_head (),( "Object is not a list" ));

	Node< _T > *first = this->next;	
	Node< _T > *last = this->prev;
	Node< _T > *node = dest->GetPrev();
	
	if ( this == first )			// source list is empty
	{
	   	return;
	}
	
	node->SetNext( first );
	first->SetPrev( node );

	last->SetNext( dest );
	dest->SetPrev( last );
	
	this->node_init();					// make the source list empty
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline	
Node< _T >*		Head< _T >::GetItem( uint number )
{
	Dbg_MsgAssert( this->is_head (),( "Object is not a list" ));

	Node< _T >*		node = this->GetNext();

	while ( node )
	{
		if ( number-- == 0 )
		{
			return node;
		}

		node = node->GetNext();
	}

	Dbg_Warning( "Item requested (%d) out of range (%d)", number, CountItems() );
	return nullptr;
}


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

// Return the firs node in the list that this is the head of

template < class _T > inline	
Node< _T >*		Head< _T >::FirstItem( )
{
	Dbg_MsgAssert( this->is_head (),( "Object is not a list" ));
	return this->GetNext();
}


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template <class _T > inline	
uint		Head< _T >::CountItems( void )
{
	Dbg_MsgAssert( this->is_head (),( "Object is not a list" ));

	uint count = 0;
	Node< _T > *node = this->GetNext();

	while ( node )
	{
		count++;
		node = node->GetNext();
	}
	return count;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template <class _T> inline	
void		Head< _T >::RemoveAllNodes( void )
{
	Dbg_MsgAssert( this->is_head (),( "Object is not a list" ));

	Node< _T > *next_nd;
	Node< _T > *node = this->GetNext();

	while ( node )
	{
		next_nd = node->GetNext();
		node->Remove();
		node = next_nd;
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template <class _T> inline	
void		Head< _T >::DestroyAllNodes( void )
{
	Dbg_MsgAssert( this->is_head (),( "Object is not a list" ));

	Node< _T > *next_nd;
	Node< _T > *node = this->GetNext();

	while ( node )
	{
		next_nd = node->GetNext();
//		node->Remove();
		delete node;
		node = next_nd;
	}
}


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
template <class _T> inline	
void		Head< _T >::AddToTail( Node< _T >* node )
{
	Dbg_AssertType( node, Node< _T > );
	Dbg_MsgAssert( this->is_head (),( "Object is not a list" ));
	Dbg_MsgAssert( !node->InList (),( "Node is already in a list" ));

	this->Insert ( node );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template <class _T> inline	
void		Head< _T >::AddToHead ( Node< _T >* node )
{
	Dbg_AssertType( node, Node< _T > );
	Dbg_MsgAssert( this->is_head(),(( "Object is not a list" )));
	Dbg_MsgAssert( !node->InList(),(( "Node is already in a list" )));

	this->Append( node );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template <class _T> inline
bool		Head< _T >::IsEmpty( void )
{
	Dbg_MsgAssert ( this->is_head(),( "Object is not a list" ));
	return ( !this->InList() );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

} // namespace Lst
