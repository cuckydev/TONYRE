/*****************************************************************************
**																			**
**					   	  Neversoft Entertainment							**
**																		   	**
**				   Copyright (C) 2002 - All Rights Reserved				   	**
**																			**
******************************************************************************
**																			**
**	Project:		PS2														**
**																			**
**	Module:			Nx														**
**																			**
**	File name:		Collision.h												**
**																			**
**	Created: 		02/15/2002	-	grj										**
**																			**
*****************************************************************************/

#ifndef	__GEL_COLLISION_H
#define	__GEL_COLLISION_H

/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/

#ifndef __CORE_DEFINES_H
#include <core/defines.h>
#endif
#include <core/math.h>
#include <core/math/geometry.h>

#include <gfx/Image/ImageBasic.h>
#include <gfx/nxflags.h>

#include <gel/collision/collenums.h>
#include <gel/collision/colltridata.h>

/*****************************************************************************
**								   Defines									**
*****************************************************************************/

namespace Obj
{
	class CCompositeObject;
}

namespace Nx
{
	
const int MAX_NUM_2D_COLLISIONS_REPORTED = 32;


// Forward declarations
class CCollObj;
class CCollMulti;
class CCollStatic;
struct CollData;
class CBatchTriCollMan;
class CCollCache;

struct SCollSurface
{
    Mth::Vector	normal;			/**< Triangle normal */
    Mth::Vector	point;			/**< First triangle vertex */
    int			index;			/**< Index of surface in object (if applicable) */
    //Mth::Vector * vertices[3];	/**< Pointers to three triangle vertices */
};

// structure used to record the collision of a single triangle with a 2D object; a collision test for a 2D object will generate a set of these
struct S2DCollSurface
{
	struct S2DCollEndpoint
	{
		Mth::Vector point;			// endpoint position
		Mth::Vector tangent;		// normalized tangent vector to the endpoint
		char tangent_exists;		// if a tangent of the endpoint is defined
	};
	
	S2DCollEndpoint ends[2];		// endpoints of the line cut through the triangle by the collision
	
	Mth::Vector	normal;				// normal of the collided triangle
	
	uint32 node_name;
	char trigger;
};

struct CollData
{
	SCollSurface	surface;
	float	dist;   
	uint16	ignore_1;			// bitmask, ignore poly if flags matching tis mask are 1
	uint16	ignore_0;			// ditto, but for flags that are 0
	uint16	flags;
	ETerrainType terrain;
	CCollObj *p_coll_object;	// the sector (object) with which we collided
	uint32	node_name;			// checsum of name of node associated with this object
	uint32	script;				// set to the script checksum of the object (or nullptr if none)
	void	(*callback)( CollData* p_col_data);	   // a callback called every frame
	void 	*p_callback_data;		// 	pointer to some data the callback can use

	Obj::CCompositeObject *mp_callback_object;	// set only during callbacks
	
	char 	coll_found;
	char	trigger;			// true if it was a trigger	(if mFD_TRIGGER flag is set on the colliding face)
};

// collision data generated by a collision test for a 2D object
struct S2DCollData
{
	S2DCollSurface	p_surfaces[MAX_NUM_2D_COLLISIONS_REPORTED];	// surfaces collided with
	int 			num_surfaces;								// number of surfaces collided with
	uint16			ignore_1;
	uint16			ignore_0;
};

// enum used internally by the rectangle collision code to keep track of which triangle edge a collision line endpoint is at
enum ETriangleEdgeType
{
	NO_TRIANGLE_EDGE, TRIANGLE_EDGE_V0_V1, TRIANGLE_EDGE_V1_V2, TRIANGLE_EDGE_V2_V0
};

/*****************************************************************************
**							Class Definitions								**
*****************************************************************************/

////////////////////////////////////////////////////////////////
// The base class for collision
class CCollObj
{
public:
						CCollObj();
	virtual				~CCollObj();

	uint32				GetChecksum() const;
	void				SetChecksum(uint32 checksum);	// For cloning
	uint16				GetObjectFlags() const;
	void				SetObjectFlags(uint16 flags);
	void				ClearObjectFlags(uint16 flags);

	//
	virtual bool		IsTriangleCollision() const { return false; }	// by default, no triangle collision

	//
	virtual uint32		GetFaceFlags(int face_idx) const = 0;
	virtual uint16		GetFaceTerrainType(int face_idx) const = 0;

	//
	virtual void		SetGeometry(CCollObjTriData *p_geom_data);
	CCollObjTriData *	GetGeometry() const;

	//
	virtual void		SetWorldPosition(const Mth::Vector & pos) = 0;
	virtual void		SetOrientation(const Mth::Matrix & orient) = 0;

	// The Get functions are virtual in case Static and Movable differ at a later point
	virtual const Mth::Vector &	GetWorldPosition() const = 0;
	virtual const Mth::Matrix &	GetOrientation() const = 0;
	virtual Mth::Vector GetVertexPos(int vert_idx) const = 0;

	virtual Obj::CCompositeObject *GetMovingObject() const;
	virtual void				SetMovingObject(Obj::CCompositeObject *p_movable_object);

	// Clone
	virtual CCollObj *	Clone(bool instance = false) = 0;

	// The virtual collision functions
	virtual bool		WithinBBox(const Mth::CBBox & testBBox) = 0;		// VERY quick test to see if we're in bbox range.
																			// Derived class may always return TRUE if it isn't
																			// worth checking.
	virtual bool		CollisionWithLine(const Mth::Line & testLine, const Mth::Vector & lineDir, CollData *p_data,  Mth::CBBox *p_bbox) = 0;
	virtual bool		CollisionWithRectangle(const Mth::Rectangle& testRect, const Mth::CBBox& testRectBBox, S2DCollData *p_coll_data) = 0;

	// Wireframe drawing
	virtual void		DebugRender(uint32 ignore_1, uint32 ignore_0) = 0;

	// Conversion functions
	static CollType		sConvertTypeChecksum(uint32 checksum);

	// Collision creation
	static CCollObj *	sCreateStaticCollision(CollType type, Nx::CCollObjTriData *p_coll_obj_data, int num_coll_objects);
	static CCollObj *	sCreateMovableCollision(CollType type, Nx::CCollObjTriData *p_coll_obj_data, int num_coll_objects,
												Obj::CCompositeObject *p_object);

	// Does collision against all the static collision in the SuperSectors
	static bool			sFindNearestStaticCollision(Mth::Line &is, CollData *p_data, void *p_callback = nullptr, CCollCache *p_cache = nullptr);
	static bool			sFindFarStaticCollision(Mth::Line &is, CollData *p_data, void *p_callback = nullptr, CCollCache *p_cache = nullptr);

	// Does collision against all the movable collision
	static Obj::CCompositeObject *	sFindNearestMovableCollision(Mth::Line &is, CollData *p_data, void *p_callback = nullptr, CCollCache *p_cache = nullptr);
	static Obj::CCompositeObject *	sFindFarMovableCollision(Mth::Line &is, CollData *p_data, void *p_callback = nullptr, CCollCache *p_cache = nullptr);

	// Does rect collision against all the static collision
	static bool			sFindRectangleStaticCollision(Mth::Rectangle& rect, S2DCollData* p_coll_data, CCollCache* p_cache = nullptr);
	
	// Triangle collision function
	static bool			sRayTriangleCollision(const Mth::Vector *rayStart, const Mth::Vector *rayDir,
											  Mth::Vector *v0, Mth::Vector *v1, Mth::Vector *v2, float *distance);
	
	static bool			sRectangleTriangleCollision(const Mth::Rectangle *rect,
													const Mth::Vector *v0, const Mth::Vector *v1, const Mth::Vector *v2,
													Mth::Vector p_collision_endpoints[2], ETriangleEdgeType p_collision_triangle_edges[2] );
	
	// 2D line-line collision function
	static bool			s2DLineLineCollision ( float p_start_X, float p_start_Y, float p_delta_X, float p_delta_Y,
											   float q_start_X, float q_start_Y, float q_delta_X, float q_delta_Y, float *s );
	
protected:
	virtual Mth::CBBox *get_bbox();											// Gets the quick bbox

	// Called on every collision found.  Returns true if this was the best collision so far.
	static bool			s_found_collision(const Mth::Line *p_is, CCollObj *p_coll_object, SCollSurface *p_collSurface,
										  float distance, CollData *p_collData);

	uint32				m_checksum;
	uint16				m_Flags;

	// Triangle data, similar to CCollSector's
	CCollObjTriData		*mp_coll_tri_data;

	static const float	sLINE_BOX_EXTENT;				 // Extent of box around collision line

	// Friends
	friend CCollMulti;
	friend CBatchTriCollMan;
	friend CCollCache;
};

////////////////////////////////////////////////////////////////
// Collision List
class CCollMulti : public CCollObj
{
public:
						CCollMulti();
	virtual				~CCollMulti();

	//
	virtual bool		IsTriangleCollision() const;

	//
	virtual void		SetWorldPosition(const Mth::Vector & pos);
	virtual void		SetOrientation(const Mth::Matrix & orient);
	// The following Get functions must be defined, but should never be called
	virtual void		SetGeometry(CCollObjTriData *p_geom_data);
	virtual const Mth::Vector &	GetWorldPosition() const;
	virtual const Mth::Matrix &	GetOrientation() const;
	virtual uint32		GetFaceFlags(int face_idx) const;
	virtual uint16		GetFaceTerrainType(int face_idx) const;
	virtual Mth::Vector GetVertexPos(int vert_idx) const;

	virtual Obj::CCompositeObject *GetMovingObject() const;
	virtual void		SetMovingObject(Obj::CCompositeObject *p_movable_object);

	// Add to collision list
	void				AddCollision(CCollObj *p_collision);

	// Clone
	virtual CCollObj *	Clone(bool instance = false);

	// The virtual collision functions
	virtual bool		WithinBBox(const Mth::CBBox & testBBox);			// VERY quick test to see if we're in bbox range.
																			// Derived class may always return TRUE if it isn't
																			// worth checking.
	virtual bool		CollisionWithLine(const Mth::Line & testLine, const Mth::Vector & lineDir, CollData *p_data, Mth::CBBox *p_bbox);
	virtual bool		CollisionWithRectangle(const Mth::Rectangle& testRect, const Mth::CBBox& testRectBBox, S2DCollData *p_coll_data);

	// Wireframe drawing
	virtual void		DebugRender(uint32 ignore_1, uint32 ignore_0);

protected:
	virtual Mth::CBBox *get_bbox();											// Gets the quick bbox

private:
	void				update_world_bbox();

	// 
	Lst::Head<CCollObj> *mp_collision_list;
	Mth::CBBox			m_world_bbox;
	bool				m_movement_changed;				// Set to true every time SetWorldPosition() is called
	bool				m_world_bbox_valid;

	// Pointer to moving object
	Obj::CCompositeObject	*mp_movable_object;
};

////////////////////////////////////////////////////////////////
// Static object collision
class CCollStatic : public CCollObj
{
public:
	virtual				~CCollStatic();

	//
	virtual void		SetWorldPosition(const Mth::Vector & pos);
	virtual void		SetOrientation(const Mth::Matrix & orient);
	virtual const Mth::Vector &	GetWorldPosition() const;
	virtual const Mth::Matrix &	GetOrientation() const;
	virtual Mth::Vector GetVertexPos(int vert_idx) const;

	// SuperSector ID access
	uint8				GetSuperSectorID() const;
	void				SetSuperSectorID(uint8);

	virtual void		RotateY(const Mth::Vector & world_origin, Mth::ERot90 rot_y) = 0;
	virtual void		Scale(const Mth::Vector & world_origin, const Mth::Vector& scale) = 0;


protected:
						CCollStatic();	// Only the derived classes should call this

	// The position and orientation are already factored into the collision
	// data, unlike the Movable counterpart.
//	Mth::Vector			m_world_pos;
//	Mth::Matrix			m_orient;
	static	Mth::Vector	sWorldPos;		// just a dummy for now....
	static	Mth::Matrix	sOrient;		// just a dummy for now....

	//
	uint8				m_op_id;		// SuperSector ID
};

////////////////////////////////////////////////////////////////
// Movable object collision
class CCollMovable : public CCollObj
{
public:
	virtual				~CCollMovable();

	//
	virtual void		SetWorldPosition(const Mth::Vector & pos);
	virtual void		SetOrientation(const Mth::Matrix & orient);
	virtual const Mth::Vector &	GetWorldPosition() const;
	virtual const Mth::Matrix &	GetOrientation() const;
	virtual Mth::Vector GetVertexPos(int vert_idx) const;

	virtual Obj::CCompositeObject *GetMovingObject() const;
	virtual void				SetMovingObject(Obj::CCompositeObject *p_movable_object);

protected:
						CCollMovable();	// Only the derived classes should call this

	void				convert_line_to_local(const Mth::Line &world_line, Mth::Line &local_line);

	// These will be set by the CMovableObject
	Mth::Vector			m_world_pos;
	Mth::Matrix			m_orient;
	Mth::Matrix			m_orient_transpose;

	// Pointer to moving object
	Obj::CCompositeObject	*mp_movable_object;
};

////////////////////////////////////////////////////////////////
// Movable collision using axis-aligned bounding box data
class CCollMovBBox : public CCollMovable
{
public:
						CCollMovBBox();
						CCollMovBBox(CCollObjTriData *p_coll_data);
	virtual				~CCollMovBBox();

	virtual void		SetGeometry(CCollObjTriData *p_geom_data);	// Also sets the bounding box based on it
	void				SetBoundingBox(const Mth::CBBox & bbox);	// Sets bounding box (will go away)

	virtual uint32		GetFaceFlags(int face_idx) const;
	virtual uint16		GetFaceTerrainType(int face_idx) const;

	// Clone
	virtual CCollObj *	Clone(bool instance = false);

	// The virtual collision functions
	virtual bool		WithinBBox(const Mth::CBBox & testBBox); 			// Will always return TRUE because it isn't
																			// worth checking.
	virtual bool		CollisionWithLine(const Mth::Line & testLine, const Mth::Vector & lineDir, CollData *p_data, Mth::CBBox *p_bbox);
	virtual bool		CollisionWithRectangle(const Mth::Rectangle& testRect, const Mth::CBBox& testRectBBox, S2DCollData *p_coll_data);

	// Wireframe drawing
	virtual void		DebugRender(uint32 ignore_1, uint32 ignore_0);

private:
	Mth::CBBox			m_bbox;

	// Face data (bbox is considered one face)
	uint32				m_flags;
	uint16				m_terrain_type;			// terrain type
	Image::RGBA			m_rgba;					// just one color
};

////////////////////////////////////////////////////////////////
// Movable collision using triangles
class CCollStaticTri : public CCollStatic
{
public:
						CCollStaticTri();
						CCollStaticTri(CCollObjTriData *p_coll_data);
	virtual				~CCollStaticTri();

	//
	virtual bool		IsTriangleCollision() const { return true; }

	//virtual void		SetGeometry(CCollObjTriData *p_geom_data);
	virtual void		SetWorldPosition(const Mth::Vector & pos);
	virtual void		SetOrientation(const Mth::Matrix & orient);

	virtual uint32		GetFaceFlags(int face_idx) const;
	virtual uint16		GetFaceTerrainType(int face_idx) const;

	// Clone
	virtual CCollObj *	Clone(bool instance = false);

	virtual void		RotateY(const Mth::Vector & world_origin, Mth::ERot90 rot_y);
	virtual void		Scale(const Mth::Vector & world_origin, const Mth::Vector& scale);

	// The virtual collision functions
	virtual bool		WithinBBox(const Mth::CBBox & testBBox);			// VERY quick test to see if we're in bbox range.
	virtual bool		CollisionWithLine(const Mth::Line & testLine, const Mth::Vector & lineDir, CollData *p_data, Mth::CBBox *p_bbox);
	virtual bool		CollisionWithRectangle(const Mth::Rectangle& testRect, const Mth::CBBox& testRectBBox, S2DCollData *p_coll_data);

	void				ProcessOcclusion();			  
			  
	// Wireframe drawing
	virtual void		DebugRender(uint32 ignore_1, uint32 ignore_0);
	void				CheckForHoles();
	

private:
};

////////////////////////////////////////////////////////////////
// Movable collision using triangles
class CCollMovTri : public CCollMovable
{
public:
						CCollMovTri();
						CCollMovTri(CCollObjTriData *p_coll_data);
	virtual				~CCollMovTri();

	//
	virtual bool		IsTriangleCollision() const { return true; }

	virtual void		SetGeometry(CCollObjTriData *p_geom_data);
	virtual void		SetWorldPosition(const Mth::Vector & pos);
	virtual void		SetOrientation(const Mth::Matrix & orient);

	virtual uint32		GetFaceFlags(int face_idx) const;
	virtual uint16		GetFaceTerrainType(int face_idx) const;

	// Clone
	virtual CCollObj *	Clone(bool instance = false);

	// The virtual collision functions
	virtual bool		WithinBBox(const Mth::CBBox & testBBox);			// VERY quick test to see if we're in bbox range.
	virtual bool		CollisionWithLine(const Mth::Line & testLine, const Mth::Vector & lineDir, CollData *p_data, Mth::CBBox *p_bbox);
	virtual bool		CollisionWithRectangle(const Mth::Rectangle& testRect, const Mth::CBBox& testRectBBox, S2DCollData* p_coll_data);

	// Wireframe drawing
	virtual void		DebugRender(uint32 ignore_1, uint32 ignore_0);

protected:
	virtual Mth::CBBox *get_bbox();											// Gets the quick bbox

private:
	void				update_world_bbox();

	float				m_max_radius;					// maximum radius that encompases geometry around the origin
	bool				m_movement_changed;				// Set to true every time SetWorldPosition() is called
	Mth::CBBox			m_world_bbox;					// approx bbox in world space that is guaranteed to encompass geometry
};


///////////////////////////////////////////////////////////////////////
//
// Inline functions
//

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline uint32			CCollObj::GetChecksum() const
{
	return m_checksum;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline uint16			CCollObj::GetObjectFlags() const
{
	return m_Flags;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline void				CCollObj::SetGeometry(CCollObjTriData *p_geom_data)
{
	mp_coll_tri_data = p_geom_data;
	// This only works for non-instanced collision
	if (p_geom_data) m_checksum = p_geom_data->GetChecksum();
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline CCollObjTriData *CCollObj::GetGeometry() const
{
	return mp_coll_tri_data;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline void				CCollObj::SetObjectFlags(uint16 flags)
{
	m_Flags |= flags;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline void				CCollObj::ClearObjectFlags(uint16 flags)
{
	m_Flags &= ~flags;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline Mth::CBBox *		CCollObj::get_bbox()
{
	return nullptr;		// default is none
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline void				CCollStatic::SetWorldPosition(const Mth::Vector & pos)
{
//	m_world_pos = pos;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline const Mth::Vector &	CCollStatic::GetWorldPosition() const
{
//	return m_world_pos;
	return sWorldPos;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline void				CCollStatic::SetOrientation(const Mth::Matrix & orient)
{
//	m_orient[X] = orient[X];	// Just the 3x3
//	m_orient[Y] = orient[Y];
//	m_orient[Z] = orient[Z];
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline const Mth::Matrix &	CCollStatic::GetOrientation() const
{
//	return m_orient;
	return sOrient;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline uint8				CCollStatic::GetSuperSectorID() const
{
	return m_op_id;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline void					CCollStatic::SetSuperSectorID(uint8 id)
{
	m_op_id = id;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline void				CCollMovable::SetWorldPosition(const Mth::Vector & pos)
{
	m_world_pos = pos;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline const Mth::Vector &	CCollMovable::GetWorldPosition() const
{
	return m_world_pos;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline void				CCollMovable::SetOrientation(const Mth::Matrix & orient)
{
	m_orient[X] = orient[X];	// Just the 3x3
	m_orient[Y] = orient[Y];
	m_orient[Z] = orient[Z];

	m_orient_transpose.Transpose(m_orient);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline const Mth::Matrix &	CCollMovable::GetOrientation() const
{
	return m_orient;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline void					CCollMovBBox::SetBoundingBox(const Mth::CBBox & bbox)
{
	m_bbox = bbox;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline bool					CCollMovBBox::WithinBBox(const Mth::CBBox & testBBox)
{
	// Will always return TRUE because it isn't worth checking
	return true;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline void					CCollMovTri::SetWorldPosition(const Mth::Vector & pos)
{
	CCollMovable::SetWorldPosition(pos);
	m_movement_changed = true;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline void					CCollMovTri::SetOrientation(const Mth::Matrix & orient)
{
	CCollMovable::SetOrientation(orient);
}


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline void					CCollMovTri::update_world_bbox()
{
	m_world_bbox.SetMin(Mth::Vector(-m_max_radius + m_world_pos[X], -m_max_radius + m_world_pos[Y], -m_max_radius + m_world_pos[Z]));
	m_world_bbox.SetMax(Mth::Vector( m_max_radius + m_world_pos[X],  m_max_radius + m_world_pos[Y],  m_max_radius + m_world_pos[Z]));
}


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

inline Mth::CBBox *			CCollMovTri::get_bbox()
{
	if (m_movement_changed)
	{
		update_world_bbox();
		m_movement_changed = false;
	}

	return &m_world_bbox;
}


} // namespace Nx

#endif  //	__GEL_COLLISION_H
