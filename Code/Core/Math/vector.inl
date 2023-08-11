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
**	Module:			Math (Mth)			   									**
**																			**
**	File name:		core/math/Vector.h										**
**																			**
**	Created:		11/29/99	-	mjb										**
**																			**
**	Description:	Vector Math Class										**
**																			**
*****************************************************************************/

#pragma once

/*****************************************************************************
**							Private Inline Functions						**
*****************************************************************************/

namespace Mth
{



/*****************************************************************************
**							Public Inline Functions							**
*****************************************************************************/

// Unitialized vectors always need overwriting
// for now we debug this by setting them to a NaN value
// which we can check for later (and some platforms will check automatically)


inline Vector::Vector()
{
	col[X] = 0.0f;
	col[Y] = 0.0f;
	col[Z] = 0.0f;
	col[W] = 1.0f;
}

inline Vector::Vector ( ENoInitType )
{
    // DO NOTHING
	col[X] = 0.0f;
	col[Y] = 0.0f;
	col[Z] = 0.0f;
	col[W] = 0.0f;
}

inline Vector::Vector ( float cx, float cy, float cz)
{	
	col[X] = cx;
	col[Y] = cy;
	col[Z] = cz;
	col[W] = 1.0f;
}


inline Vector::Vector(float cx, float cy, float cz, float cw)
{			
	col[X] = cx;
	col[Y] = cy;
	col[Z] = cz;
	col[W] = cw;
}


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

#ifndef		DEBUG_UNINIT_VECTORS
#ifndef		DEBUG_OVERFLOW_VECTORS

inline const float&		Vector::operator[] ( sint i ) const
{
	return col[i];
}

#endif
#endif

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline float&			Vector::operator[] ( sint i )
{
	
	
//	Dbg_MsgAssert (( i >= X && i < NUM_ELEMENTS ),( "index out of range" ));
	
	return col[i];
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline bool					Vector::operator== ( const Vector& v ) const
{	
	

	return (( col[X] == v[X] ) && 
			( col[Y] == v[Y] ) &&
			( col[Z] == v[Z] ) &&
			( col[W] == v[W] ));
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline bool					Vector::operator!= ( const Vector& v ) const
{	
	

	return !( *this == v );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline Vector&		Vector::operator+= ( const Vector& v )
{
	
	
	col[X] += v[X];
	col[Y] += v[Y];
	col[Z] += v[Z];
	col[W] += v[W];
	
	return *this;
}		

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline Vector&		Vector::operator-= ( const Vector& v )
{
	
	
	col[X] -= v[X];
	col[Y] -= v[Y];
	col[Z] -= v[Z];
	col[W] -= v[W];
	
	return *this;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline Vector&		Vector::operator*= ( const float s )
{
	
	
	col[X] *= s;
	col[Y] *= s;
	col[Z] *= s;
	col[W] *= s;
	
	return *this;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline Vector&		Vector::operator/= ( float s )
{
	
	
	Dbg_MsgAssert( s != 0,( "Divide by zero" ));

	s = 1.0f / s;
	
	col[X] *= s;
	col[Y] *= s;
	col[Z] *= s;
	col[W] *= s;
	
	return *this;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline Vector&		Vector::operator*= ( const Vector& v )
{
	col[X] *= v[X];
	col[Y] *= v[Y];
	col[Z] *= v[Z];
	col[W] *= v[W];
	return *this;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline Vector&		Vector::operator/= ( const Vector& v )
{
	
	

	Dbg_MsgAssert( v[X] != 0,( "Divide by zero X" ));
	Dbg_MsgAssert( v[Y] != 0,( "Divide by zero Y" ));
	Dbg_MsgAssert( v[Z] != 0,( "Divide by zero Z" ));
	Dbg_MsgAssert( v[W] != 0,( "Divide by zero W" ));

	col[X] /= v[X];
	col[Y] /= v[Y];
	col[Z] /= v[Z];
	col[W] /= v[W];
	
	return *this;
}


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline Vector&		Vector::operator*= ( const Matrix& mat )
{	

	#ifdef	__USE_VU0__
	sceVu0ApplyMatrix((sceVu0FVECTOR)this,(sceVu0FMATRIX)&mat,(sceVu0FVECTOR)this);
	#else		
	
	Vector	v=*this;

	col[X] = v[X] * mat[X][X] + v[Y] * mat[Y][X] + v[Z] * mat[Z][X] + v[W] * mat[W][X];
	col[Y] = v[X] * mat[X][Y] + v[Y] * mat[Y][Y] + v[Z] * mat[Z][Y] + v[W] * mat[W][Y];
	col[Z] = v[X] * mat[X][Z] + v[Y] * mat[Y][Z] + v[Z] * mat[Z][Z] + v[W] * mat[W][Z];
	col[W] = v[X] * mat[X][W] + v[Y] * mat[Y][W] + v[Z] * mat[Z][W] + v[W] * mat[W][W];

	#endif
	
	return *this;
}


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline Vector&		Vector::Set ( float cx, float cy, float cz, float cw )
{
	
	
	col[X] = cx;
	col[Y] = cy;
	col[Z] = cz;
	col[W] = cw;

	return *this;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline float			Vector::LengthSqr	( void ) const
{
	

	return (( col[X] * col[X] ) + 
			( col[Y] * col[Y] ) +
			( col[Z] * col[Z] ));
}
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline float			Vector::Length ( void ) const
{
	
	
	return sqrtf ( LengthSqr ());
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline Vector&		Vector::Negate ( void )
{
	

	col[X] = -col[X];
	col[Y] = -col[Y];
	col[Z] = -col[Z];
	
	return *this;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline Vector&		Vector::Negate ( const Vector& src )
{
	

	col[X] = -src[X];
	col[Y] = -src[Y];
	col[Z] = -src[Z];
	
	return *this;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/


inline Vector&		Vector::Normalize( )
{	
	float l = Length();
	if ( l > 0.0f ) 
	{
		l = 1.0f / l;

		col[X] *= l;
		col[Y] *= l;
		col[Z] *= l;
	}
	else
	{
//		Dbg_MsgAssert(0,("Normalizing vector of zero length"));
	}
	return *this;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline Vector&		Vector::Normalize	( float len )
{	
	

	float l = Length();
	if ( l > 0.0f ) 
	{
		l = len / l;

		col[X] *= l;
		col[Y] *= l;
		col[Z] *= l;
	}
	else
	{
//		Dbg_MsgAssert(0,("Normalizing vector of zero length"));
	}
	return *this;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline Vector&		Vector::ShearX ( float shy, float shz )
{	
	
	
	col[X] += (( col[Y] * shy ) + ( col[Z] * shz ));
	
	return *this;

}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline Vector&		Vector::ShearY ( float shx, float shz )
{	
	

	col[Y] += (( col[X] * shx ) + ( col[Z] * shz ));
	
	return *this;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline Vector&		Vector::ShearZ ( float shx, float shy )
{	
	

	col[Z] += (( col[X] * shx ) + ( col[Y] * shy ));
	
	return *this;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline Vector&		Vector::RotateX ( float s, float c )
{	
	

	float y = ( c * col[Y] ) - ( s * col[Z] );
	float z = ( s * col[Y] ) + ( c * col[Z] );
	
	col[Y] = y;
	col[Z] = z;
	
	return *this;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline Vector&		Vector::RotateY ( float s, float c )
{	
	

	float x = (  c * col[X] ) + ( s * col[Z] );
	float z = ( -s * col[X] ) + ( c * col[Z] );
	
	col[X] = x;
	col[Z] = z;
	
	return *this;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline Vector&		Vector::RotateZ ( float s, float c )
{
	
	
	float x = ( c * col[X] ) - ( s * col[Y] );
	float y = ( s * col[X] ) + ( c * col[Y] );
	
	col[X] = x;
	col[Y] = y;

	return *this;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline Vector&		Vector::RotateX	( float angle )	
{	
	

	return RotateX ( sinf ( angle ), cosf ( angle ));
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline Vector&		Vector::RotateY	( float angle )	
{
	
	
	return RotateY ( sinf ( angle ), cosf ( angle ));
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline Vector&		Vector::RotateZ	( float angle )	
{
	
	
	return RotateZ ( sinf ( angle ), cosf ( angle ));
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline Vector&		Vector::Rotate ( const Quat& quat )	
{
	
	
	*this = quat.Rotate ( *this );

  	return *this;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline Vector&		Vector::Rotate ( const Matrix& mat )	
{
	
	
	*this = mat.Rotate ( *this );

  	return *this;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline Vector&		Vector::Rotate ( const Vector& axis, const float angle )	
{
	
#if 0
	Matrix	mat( axis, angle );
	*this = mat.Rotate( *this );
#else
	Quat	quat( axis, angle );
	*this = quat.Rotate( *this );
#endif

  	return *this;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline Vector&		Vector::Scale ( float scale )
{
	col[X] *= scale;
	col[Y] *= scale;
	col[Z] *= scale;
	col[W] *= scale;

	return *this;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline Vector&		Vector::Scale ( const Vector& scale )
{
	col[X] *= scale[X];
	col[Y] *= scale[Y];
	col[Z] *= scale[Z];
	col[W] *= scale[W];

	return *this;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline Vector&		Vector::ClampMin	( float min )
{
	

	col[X] = Mth::ClampMin ( col[X], min );
	col[Y] = Mth::ClampMin ( col[Y], min );
	col[Z] = Mth::ClampMin ( col[Z], min );
	col[W] = Mth::ClampMin ( col[W], min );
	
	return *this;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline Vector&		Vector::ClampMax	( float max )
{
	

	col[X] = Mth::ClampMax ( col[X], max );
	col[Y] = Mth::ClampMax ( col[Y], max );
	col[Z] = Mth::ClampMax ( col[Z], max );
	col[W] = Mth::ClampMax ( col[W], max );
	
	return *this;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline Vector&		Vector::Clamp	( float min, float max )
{
	

	col[X] = Mth::ClampMin ( Mth::ClampMax ( col[X], max ), min );
	col[Y] = Mth::ClampMin ( Mth::ClampMax ( col[Y], max ), min );
	col[Z] = Mth::ClampMin ( Mth::ClampMax ( col[Z], max ), min );
	col[W] = Mth::ClampMin ( Mth::ClampMax ( col[W], max ), min );
	
	return *this;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline Vector&		Vector::ClampMin	( Vector& min )
{
	

	col[X] = Mth::ClampMin ( col[X], min[X] );
	col[Y] = Mth::ClampMin ( col[Y], min[Y] );
	col[Z] = Mth::ClampMin ( col[Z], min[Z] );
	col[W] = Mth::ClampMin ( col[W], min[W] );
	
	return *this;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline Vector&		Vector::ClampMax	( Vector& max )
{
	

	col[X] = Mth::ClampMax ( col[X], max[X] );
	col[Y] = Mth::ClampMax ( col[Y], max[Y] );
	col[Z] = Mth::ClampMax ( col[Z], max[Z] );
	col[W] = Mth::ClampMax ( col[W], max[W] );
	
	return *this;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline Vector&		Vector::Clamp	( Vector& min, Vector& max )
{
	

	col[X] = Mth::ClampMin ( Mth::ClampMax ( col[X], max[X] ), min[X] );
	col[Y] = Mth::ClampMin ( Mth::ClampMax ( col[Y], max[Y] ), min[Y] );
	col[Z] = Mth::ClampMin ( Mth::ClampMax ( col[Z], max[Z] ), min[Z] );
	col[W] = Mth::ClampMin ( Mth::ClampMax ( col[W], max[W] ), min[W] );
	
	return *this;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline	float	Vector::GetX( void ) const
{
	

	return col[X];
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline	float	Vector::GetY( void ) const
{
	
	
	return col[Y];
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline	float	Vector::GetZ( void ) const
{
	
	
	return col[Z];
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline	float	Vector::GetW( void ) const
{
	
	
	return col[W];
}


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline	Vector	operator+	( const Vector& v1, const Vector& v2 )
{	
	
	
	return Vector ( v1[X] + v2[X], v1[Y] + v2[Y], v1[Z] + v2[Z], v1[W] + v2[W] );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline	Vector	operator-	( const Vector& v1, const Vector& v2 )
{
	

	return Vector ( v1[X] - v2[X], v1[Y] - v2[Y], v1[Z] - v2[Z], v1[W] - v2[W] );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline	Vector	operator*	( const Vector& v, const float s )
{
	
	
	return Vector ( v[X] * s, v[Y] * s, v[Z] * s, v[W] * s );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline	Vector	operator*	( const float s, const Vector& v )
{
	

	return v * s;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline Vector	operator* ( const Vector& v, const Matrix& m )
{	

	#ifdef	__USE_VU0__
	// Mick:
	Mth::Vector	result;
	sceVu0ApplyMatrix((sceVu0FVECTOR)&result,(sceVu0FMATRIX)&m,(sceVu0FVECTOR)&v);
	return result;
	#else	
	// Mick:  This is REALLY SLOW, as it calls Mth::Matrix operator[]	
	return Vector ( v[X] * m[X][X] + v[Y] * m[Y][X] + v[Z] * m[Z][X] + v[W] * m[W][X],
					v[X] * m[X][Y] + v[Y] * m[Y][Y] + v[Z] * m[Z][Y] + v[W] * m[W][Y],
					v[X] * m[X][Z] + v[Y] * m[Y][Z] + v[Z] * m[Z][Z] + v[W] * m[W][Z],
					v[X] * m[X][W] + v[Y] * m[Y][W] + v[Z] * m[Z][W] + v[W] * m[W][W]);
	#endif
}


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline	Vector	operator/	( const Vector& v, const float s )
{
	

	Dbg_MsgAssert (( s != 0.0f ),( "Divide by Zero" ));
																							  
	float r = 1.0f / s; 
	
	return v * r;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline	Vector	operator-	( const Vector& v )
{
	
	
	return Vector ( -v[X], -v[Y], -v[Z], -v[W] );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline	float	DotProduct ( const Vector& v1, const Vector& v2 ) 
{
	
	
	return ( v1[X] * v2[X] ) + ( v1[Y] * v2[Y] ) + ( v1[Z] * v2[Z] );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline	Vector	CrossProduct ( const Vector& v1, const Vector& v2 ) 
{	
	return Vector (( v1[Y] * v2[Z] ) - ( v1[Z] * v2[Y] ),
				   ( v1[Z] * v2[X] ) - ( v1[X] * v2[Z] ),
				   ( v1[X] * v2[Y] ) - ( v1[Y] * v2[X] ),
				   0.0f );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline	Vector	Clamp ( const Vector& v, float min, float max )
{	
	

	Vector f = v;
	
	f.Clamp ( min, max );

	return f;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline	Vector	Clamp ( const Vector& v, Vector& min, Vector& max )
{	
	

	Vector f = v;
	
	f.Clamp ( min, max );

	return f;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline	float	Distance ( const Vector& v1, const Vector& v2 )
{	
	
	
	Vector d = v1 - v2;
	
	return sqrtf ( DotProduct ( d, d ));
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline	float	DistanceSqr ( const Vector& v1, const Vector& v2 )
{
	

	Vector d = v1 - v2;
	
	return ( DotProduct ( d, d ));
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline	bool	Equal ( const Vector& v1, const Vector& v2, const float tol )
{	
	

	return ( Equal ( v1[X], v2[X], tol ) && 
			 Equal ( v1[Y], v2[Y], tol ) && 
			 Equal ( v1[Z], v2[Z], tol ));
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline	Vector	Lerp ( const Vector& v1, const Vector& v2, const float val )
{	
	
	
	return Vector ( v1 + ( v2 - v1 ) * val );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline	Vector	LinearMap ( const Vector& v1, const Vector& v2, float value, float value_min, float value_max )
{
	return Vector ( v1 + ( v2 - v1 ) * ( (value - value_min) / (value_max - value_min) ) );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline	Vector	Min ( const Vector& v1, const Vector& v2 )
{
	
	
	return Vector ( Min ( v1[X], v2[X] ), 
					Min ( v1[Y], v2[Y] ),
					Min ( v1[Z], v2[Z] ));
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline	Vector	Max ( const Vector& v1, const Vector& v2 )
{	
	
	
	return Vector ( Max ( v1[X], v2[X] ), 
					Max ( v1[Y], v2[Y] ),
					Max ( v1[Z], v2[Z] ));
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline	Vector	Min ( const Vector& v, float c )	
{	
	
	
	return Min ( v, Vector ( c, c, c, 1.0f ));
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline	Vector	Max ( const Vector& v, float c )	
{
	
	
	return Max ( v, Vector ( c, c, c, 0.0f ));
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline	void	Swap ( Vector& a, Vector& b )
{
	
	
	Vector t = a;
	
	a = b;
	b = t;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline Vector&		Vector::ZeroIfShorterThan ( float length )	
{
	

	if (LengthSqr() < length *length)
	{
		Set(0.0f,0.0f,0.0f,0.0f);		
	}
	
  	return *this;
}


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline std::ostream& operator<< (std::ostream& os, const Vector& v )
{
	return os << "( " << v[X] << ", " << v[Y] << ", " << v[Z] << ", " << v[W] << " )";
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

} // namespace Mth
