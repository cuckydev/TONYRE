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
**	File name:		core/sys/mem/memptr.h									**
**																			**
*****************************************************************************/

#ifndef	__SYS_MEM_MEMPTR_H
#define	__SYS_MEM_MEMPTR_H

/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/

#ifndef __CORE_DEFINES_H
#include <core/defines.h>
#endif

#include <core/support.h>

#include <core/support/support.h>

/*****************************************************************************
**								   Defines									**
*****************************************************************************/

namespace Mem
{

/*****************************************************************************
**							     Type Defines								**
*****************************************************************************/

nTemplateBaseClass( _T, PtrToConst )
{
	
public :

		PtrToConst( const _T* ptr = nullptr );
		~PtrToConst( void );

		template < class _NewT > PtrToConst( const PtrToConst< _NewT >& rhs ); 	// needed to support inheritance correctly

		template < class _NewT > PtrToConst<_T>&		operator = ( const PtrToConst< _NewT >& rhs );	// template assignment operator

		PtrToConst<_T>&		operator = ( const _T* ptr );

		PtrToConst<_T>&		operator++ ( void ); 							// ++ptr   
		const PtrToConst<_T>	operator++ ( int ); 							// ptr++   
		PtrToConst<_T>&		operator-- ( void );							// --ptr
		const PtrToConst<_T>	operator-- ( int );								// ptr--
		PtrToConst<_T>&		operator+= ( int val );
		PtrToConst<_T>&		operator-= ( int val );

		bool					operator ! () const;                    		// operator! - use to test for null
		
		const _T&				operator * () const;
		const _T*				operator -> () const;																	
		const _T*				Addr( void ) const;								// Retrieve 'dumb' pointer
		
protected:
		_T *m_ptr;
};

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

nTemplateSubClass( _T, Ptr, PtrToConst<_T> )
{

	
public :
		Ptr( const _T* ptr = nullptr );
		~Ptr( void );

		template < class _NewT > Ptr( const Ptr< _NewT >& rhs );	

		template < class _NewT > Ptr<_T> &operator = ( const Ptr< _NewT >& rhs );			// template assignment operator

		Ptr<_T>&				operator = ( const _T* ptr );
		_T&						operator * ( void ) const; 
		_T*						operator -> ( void ) const;
		_T*						Addr( void ) const;

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

/******************************************************************/
/*                                                                */
/* PtrToConst<_T>                                               */
/*                                                                */
/******************************************************************/

template < class _T > inline
PtrToConst<_T>::PtrToConst(const _T* ptr) : m_ptr((_T*)ptr)
{
	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline	
PtrToConst<_T>::~PtrToConst( void )
{
	

}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
template < class _T > template < class _NewT > inline
PtrToConst<_T>::PtrToConst( const PtrToConst<_NewT> &rhs) : m_ptr((_T*)rhs.Addr())
{

}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > template < class _NewT > inline
PtrToConst<_T> &PtrToConst<_T>::operator = ( const PtrToConst< _NewT >& rhs ) 
{
	m_ptr = (_T*)rhs.Addr();
	return *this;	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline
PtrToConst<_T>&		PtrToConst<_T>::operator = ( const _T* ptr ) 
{
	m_ptr = (_T*)ptr;
	return *this;	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline
const _T&		PtrToConst<_T>::operator * ( void ) const 
{
	Dbg_AssertType(m_ptr, _T );
	return *((const _T*)m_ptr);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline
PtrToConst<_T>&	PtrToConst<_T>::operator+= ( int val )
{
	m_ptr += val;
	Dbg_AssertType(m_ptr, _T);
	return *this;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline
PtrToConst<_T>&	PtrToConst<_T>::operator-= ( int val )
{
	m_ptr -= val;
	Dbg_AssertType(m_ptr, _T);
	return *this;
}


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline
PtrToConst<_T>&	PtrToConst<_T>::operator++ ( void )
{
	*this += 1;
	return *this;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline
const PtrToConst<_T>	PtrToConst<_T>::operator++ ( int )
{
	PtrToConst<_T> old = *this;
	++(*this);
	return old;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline
PtrToConst<_T>&	PtrToConst<_T>::operator-- ( void )
{
	Dbg_AssertType(m_ptr, _T );
	*this -= 1;
	return *this;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline
const PtrToConst<_T>	PtrToConst<_T>::operator-- ( int )
{
	Dbg_AssertType(m_ptr, _T);
	PtrToConst<_T> old = *this;
	--(*this);
	return old;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline
const _T *PtrToConst<_T>::operator->( void ) const 
{
	Dbg_AssertType(m_ptr, _T );
	return m_ptr;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline
bool PtrToConst<_T>::operator!( void ) const 
{
	return (m_ptr == nullptr );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline
const _T *PtrToConst<_T>::Addr(void) const 
{
	return m_ptr;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline
const PtrToConst<_T> operator+ ( const PtrToConst<_T>& lhs, int rhs )
{
	PtrToConst<_T>	ret = lhs;
	ret += rhs;
	return ret;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline
const PtrToConst<_T> operator- ( const PtrToConst<_T>& lhs, int rhs )
{
	PtrToConst<_T>	ret = lhs;
	ret -= rhs;
	return ret;
}




/******************************************************************/
/*                                                                */
/* Ptr<_T>                                                      */
/*                                                                */
/******************************************************************/

template < class _T > inline   
Ptr<_T>::Ptr( const _T* ptr ) : PtrToConst<_T>( ptr )
{
	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline	
Ptr<_T>::~Ptr( void )
{
	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
template < class _T > template < class _NewT > inline
Ptr<_T>::Ptr( const Ptr< _NewT >& rhs ) : PtrToConst<_T>( rhs )
{

}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > template < class _NewT > inline
Ptr<_T> &Ptr<_T>::operator= ( const Ptr< _NewT >& rhs ) 
{
	this->m_ptr = (_T*)rhs.Addr();
	return *this;	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline
Ptr<_T> &Ptr<_T>::operator= ( const _T* ptr ) 
{
	this->m_ptr = (_T*)ptr;
	return *this;	
}


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline
_T &Ptr<_T>::operator * ( void ) const 
{
	Dbg_AssertType(this->m_ptr, _T );
	return *this->m_ptr;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline
_T *Ptr<_T>::operator -> ( void ) const 
{
	Dbg_AssertType(this->m_ptr, _T );
	return this->m_ptr;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline
_T *Ptr<_T>::Addr ( void ) const 
{
	return this->m_ptr;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

} // namespace Mem

#endif  // __SYS_MEM_MEMPTR_H								
