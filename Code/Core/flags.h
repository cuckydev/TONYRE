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
**	File name:		core/flags.h											**
**																			**
**	Created:		10/27/99	-	mjb										**
**																			**
*****************************************************************************/

#ifndef __CORE_FLAGS_H
#define __CORE_FLAGS_H

/*****************************************************************************
**								   Includes									**
*****************************************************************************/
	

/*****************************************************************************
**								   Defines									**
*****************************************************************************/


/*****************************************************************************
**							Class Definitions								**
*****************************************************************************/

/************************************************************************
 *																		*
 * Class:			flags												*
 *																		*
 * Description:		Template class for flags. 						 	*
 *																		*
 *																		*
 ***********************************************************************/

template < class _T >
class Flags
{

public:
					
				Flags ( void );
				Flags ( const uint val );

	void		ClearAll ( void );
	void		Clear ( _T flag_index );
	void		ClearMask ( const uint& f );
	void		Set ( _T flag_index, bool on = true );	
	void		SetAll ( void );
	void		SetMask ( const uint& mask );
	void		SetVal ( const uint& f );
	bool		TestAny ( void ) const;
	bool		Test ( _T flag_index ) const;
	bool		TestMask ( const uint& mask ) const;
	bool		TestMaskAny ( const uint& mask ) const;
	bool		TestMaskAll ( const uint& mask ) const;
	void		Toggle ( _T flag_index );
	
				operator uint (void) const;
	Flags&		operator= ( const Flags& src );
	Flags&		operator= ( const uint& val );

private:

	uint		flag;
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
Flags< _T >::Flags ( void )
: flag ( 0 )
{

}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/


template < class _T > inline
Flags< _T >::Flags ( const uint val ) 
: flag ( val )
{

}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline
void	Flags< _T >::ClearAll ( void )
{
	flag = 0;
}

											
											
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline
void	Flags< _T >::Clear ( _T flag_index )
{
	flag &= ~( 1 << static_cast< uint >( flag_index ));
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline
void	Flags< _T >::ClearMask ( const uint& f )
{
	flag &= ~f;
}
	
	
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline
void	Flags< _T >::Set ( _T flag_index, bool on )
{
	if ( on )
	{
		flag |= ( 1 << static_cast< uint >( flag_index ));
	}
	else
	{
		flag &= ~( 1 << static_cast< uint >( flag_index ));
	}
}
	
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline
void	Flags< _T >::SetAll ( void )
{
	flag = vUINT_MAX;
}                   

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline
void	Flags< _T >::SetMask ( const uint& mask )
{
	flag |= mask;
}
	
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline
void	Flags< _T >::SetVal ( const uint& f )
{
	flag = f;
}
	
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline
bool	Flags< _T >::TestAny ( void ) const
{
	return ( flag != 0 );
}
	
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline
bool	Flags< _T >::Test ( _T flag_index ) const
{
	return  (( flag & ( 1 << static_cast< uint >( flag_index ))) != 0 );
}
	
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline
bool	Flags< _T >::TestMask ( const uint& mask ) const
{
	return TestMaskAny(mask);
}
	
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline
bool	Flags< _T >::TestMaskAny ( const uint& mask ) const
{
	return (( flag & mask ) != 0 );
}
	
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline
bool	Flags< _T >::TestMaskAll ( const uint& mask ) const
{
	return (( flag & mask ) == mask );
}
	
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline
void	Flags< _T >::Toggle ( _T flag_index )
{
	flag ^= ( 1 << static_cast< uint >( flag_index ));
}	

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline
Flags< _T >::operator uint (void) const
{
	return flag;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline
Flags< _T >&	Flags< _T >::operator= ( const Flags< _T >& src )
{
	flag = static_cast< uint >( src.flag );
	
	return *this;
}
	
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

template < class _T > inline
Flags< _T >&	Flags< _T >::operator= ( const uint& val )
{
	flag = val;
	
	return *this;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

/*
template < class _T > inline
ostream& operator<< ( ostream& os, const Flags< _T >& src )
{
	return os << static_cast< uint >( src );
}
*/

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
#endif	//	__CORE_FLAGS_H





