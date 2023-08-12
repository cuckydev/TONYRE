/*****************************************************************************
**																			**
**			              Neversoft Entertainment.			                **
**																		   	**
**				   Copyright (C) 1999 - All Rights Reserved				   	**
**																			**
******************************************************************************
**																			**
**	Project:		PS2														**
**																			**
**	Module:			Nx								 						**
**																			**
**	File name:		gel\collision\BatchTriColl.cpp 							**
**																			**
**	Created by:		04/12/02	-	grj										**
**																			**
**	Description:															**
**																			**
*****************************************************************************/

/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/

#include <Core/Defines.h>

#include <Gel/Collision/BatchTriColl.h>
#include <Gel/Collision/Collision.h>

#ifdef	__PLAT_NGPS__
#include <libdma.h>
#include <devvu0.h>
#include <Gfx/ngps/nx/interrupts.h>
#include <Gfx/ngps/nx/resource.h>
#endif //__PLAT_NGPS__

/*****************************************************************************
**								DBG Information								**
*****************************************************************************/



namespace Nx
{

#ifdef BATCH_TRI_COLLISION

CollData *		CBatchTriColl::sp_coll_data;

volatile bool	CBatchTriCollMan::s_processing = false;
volatile bool	CBatchTriCollMan::s_result_processing = false;
volatile int	CBatchTriCollMan::s_nested = 0;
volatile bool	CBatchTriCollMan::s_found_collision = false;
CBatchTriColl 	CBatchTriCollMan::s_tri_collision_array[MAX_BATCH_COLLISIONS][2];
int				CBatchTriCollMan::s_current_array = 0;
int				CBatchTriCollMan::s_array_size = 0;
int				CBatchTriCollMan::s_next_idx_to_batch = 0;
int				CBatchTriCollMan::s_num_collisions = 0;
#ifdef __PLAT_NGPS__
int 			CBatchTriCollMan::s_collision_handler_id = -1;
bool 			CBatchTriCollMan::s_use_vu0_micro = false;
#endif

//----------------------------------------------------------------------------
//

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool	CBatchTriCollMan::sInit(CollData *p_coll_data)
{
	// Check for nesting; abort if true
	if (s_processing)
	{
		s_nested++;
		return false;
	}

	Dbg_Assert(s_processing == false);

	s_array_size = 0;
	s_next_idx_to_batch = 0;
	s_found_collision = false;

	CBatchTriColl::sp_coll_data = p_coll_data;

#ifdef	__PLAT_NGPS__
    // install interrupt handler for render completion
	if (s_collision_handler_id == -1)
	{
		s_collision_handler_id = AddIntcHandler(INTC_VU0, s_collision_done, 0);
		EnableIntc(INTC_VU0);
		sceDevVu0PutTBit(1);		// Use T-bit interrupt
	}
#endif //	__PLAT_NGPS__

	return true;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void	CBatchTriCollMan::sFinish()
{
	if (s_nested)
	{
		s_nested--;
		Dbg_Assert(s_nested >= 0);
		return;
	}

	// For now, don't wait for collision to finish, since we
	// are trying to avoid a stall here.  But this will probably
	// cause deadlock situations once it is on the VU0.
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void	CBatchTriCollMan::sAddTriCollision(const Mth::Line &test_line, const Mth::Vector &test_line_dir,
										   CCollObj *p_collision_obj, FaceIndex face_index)
{
	Dbg_Assert(s_nested == 0);

	CBatchTriColl *p_tri_collision;
	p_tri_collision = &(s_tri_collision_array[s_array_size++][s_current_array]);

	p_tri_collision->m_test_line = test_line;
	p_tri_collision->m_test_line_dir = test_line_dir;
	p_tri_collision->mp_collision_obj = p_collision_obj;
	p_tri_collision->m_face_index = face_index;

	//Dbg_Assert(s_array_size <= MAX_BATCH_COLLISIONS);
	if (s_array_size == MAX_BATCH_COLLISIONS)
	{
//		sWaitTriCollisions();		// make sure were done working
		sStartNewTriCollisions();

		//s_switch_buffers();
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool	CBatchTriCollMan::sRemoveTriCollision(CBatchTriColl *p_tri_collision)
{
	return false;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void	CBatchTriCollMan::sStartNewTriCollisions()
{
	Dbg_Assert(s_nested == 0);

	sWaitTriCollisions();		// make sure were done working
	Dbg_Assert(!s_processing);

	// Check if we have anything to do
	if (s_next_idx_to_batch >= s_array_size)
	{
		return;
	}

	s_processing = true;

#ifdef	__PLAT_NGPS__
	if(s_use_vu0_micro)
	{
		uint128 *p_vu0_mem = (uint128*)0x11004000;		// VU0 data memory

		// Write out sizes first
		uint32 *p_vu0_word_mem = (uint32 *) (p_vu0_mem++);
		*(p_vu0_word_mem++) = s_next_idx_to_batch;
		*(p_vu0_word_mem++) = s_array_size;

		for (int i = s_next_idx_to_batch; i < s_array_size; i++)
		{
			const CBatchTriColl &tri_coll = s_tri_collision_array[i][s_current_array];

			Mth::Vector *v0, *v1, *v2;
			if (tri_coll.mp_collision_obj->mp_coll_tri_data->m_use_face_small)
			{
				CCollObjTriData::SFaceSmall *face = &(tri_coll.mp_collision_obj->mp_coll_tri_data->mp_face_small[tri_coll.m_face_index]);

				v0 = &tri_coll.mp_collision_obj->mp_coll_tri_data->mp_vert_pos[face->m_vertex_index[0]];
				v1 = &tri_coll.mp_collision_obj->mp_coll_tri_data->mp_vert_pos[face->m_vertex_index[1]];
				v2 = &tri_coll.mp_collision_obj->mp_coll_tri_data->mp_vert_pos[face->m_vertex_index[2]];
			} else {
				CCollObjTriData::SFace *face = &(tri_coll.mp_collision_obj->mp_coll_tri_data->mp_faces[tri_coll.m_face_index]);

				v0 = &tri_coll.mp_collision_obj->mp_coll_tri_data->mp_vert_pos[face->m_vertex_index[0]];
				v1 = &tri_coll.mp_collision_obj->mp_coll_tri_data->mp_vert_pos[face->m_vertex_index[1]];
				v2 = &tri_coll.mp_collision_obj->mp_coll_tri_data->mp_vert_pos[face->m_vertex_index[2]];
			}

			*(p_vu0_mem++) = *((uint128*) &(tri_coll.m_test_line.m_start));
			*(p_vu0_mem++) = *((uint128*) &(tri_coll.m_test_line_dir));
			*(p_vu0_mem++) = *((uint128*) v0);
			*(p_vu0_mem++) = *((uint128*) v1);
			*(p_vu0_mem++) = *((uint128*) v2);
		}

		//FlushCache(WRITEBACK_DCACHE);

		//sceDevVu0PutTBit(1);		// Use T-bit interrupt

		// Switch the buffers before we make the call (in case it finishes immediately)
		s_switch_buffers();X
	}
	else
#endif //	__PLAT_NGPS__
	{
		// Just do it manually now
		for (int i = s_next_idx_to_batch; i < s_array_size; i++)
		{
			const CBatchTriColl &tri_coll = s_tri_collision_array[i][s_current_array];

			Mth::Vector *v0, *v1, *v2;
			if (tri_coll.mp_collision_obj->mp_coll_tri_data->m_use_face_small)
			{
				CCollObjTriData::SFaceSmall *face = &(tri_coll.mp_collision_obj->mp_coll_tri_data->mp_face_small[tri_coll.m_face_index]);

				v0 = &tri_coll.mp_collision_obj->mp_coll_tri_data->mp_vert_pos[face->m_vertex_index[0]];
				v1 = &tri_coll.mp_collision_obj->mp_coll_tri_data->mp_vert_pos[face->m_vertex_index[1]];
				v2 = &tri_coll.mp_collision_obj->mp_coll_tri_data->mp_vert_pos[face->m_vertex_index[2]];
			} else {
				CCollObjTriData::SFace *face = &(tri_coll.mp_collision_obj->mp_coll_tri_data->mp_faces[tri_coll.m_face_index]);

				v0 = &tri_coll.mp_collision_obj->mp_coll_tri_data->mp_vert_pos[face->m_vertex_index[0]];
				v1 = &tri_coll.mp_collision_obj->mp_coll_tri_data->mp_vert_pos[face->m_vertex_index[1]];
				v2 = &tri_coll.mp_collision_obj->mp_coll_tri_data->mp_vert_pos[face->m_vertex_index[2]];
			}

			float distance;
#ifdef	__PLAT_NGPS__
			if (vu0RayTriangleCollision(&tri_coll.m_test_line.m_start, &tri_coll.m_test_line_dir, v0, v1, v2, &distance))
#else
			if (CCollObj::sRayTriangleCollision(&tri_coll.m_test_line.m_start, &tri_coll.m_test_line_dir,
												v0, v1, v2, &distance))
#endif
			{
				SCollSurface collisionSurface;

				/* We've got one */
				collisionSurface.point = (*v0);
				collisionSurface.index = tri_coll.m_face_index;

				// Find normal
				Mth::Vector vTmp1(*v1 - *v0);
				Mth::Vector vTmp2(*v2 - *v0);
				collisionSurface.normal = Mth::CrossProduct(vTmp1, vTmp2);
				collisionSurface.normal.Normalize();

				if (CCollObj::s_found_collision(&tri_coll.m_test_line, tri_coll.mp_collision_obj, &collisionSurface, distance, CBatchTriColl::sp_coll_data))
				{
					s_found_collision = true;
				}
			}
		}
		s_processing = false;		// Just for manual version

		s_switch_buffers();
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

int		CBatchTriCollMan::s_collision_done(int arg)
{	
	return 0;
}


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void	CBatchTriCollMan::s_process_results()
{
#ifdef	__PLAT_NGPS__
	SCollOutput *p_output = (SCollOutput*)0x11004010;		// VU0 data memory
	int previous_array = s_current_array ^ 1;
	for (int i = 0; i < s_num_collisions; i++)
	{
		const CBatchTriColl &tri_coll = s_tri_collision_array[p_output->index][previous_array];

		Mth::Vector *v0, *v1, *v2;
		if (tri_coll.mp_collision_obj->mp_coll_tri_data->m_use_face_small)
		{
			CCollObjTriData::SFaceSmall *face = &(tri_coll.mp_collision_obj->mp_coll_tri_data->mp_face_small[tri_coll.m_face_index]);

			v0 = &tri_coll.mp_collision_obj->mp_coll_tri_data->mp_vert_pos[face->m_vertex_index[0]];
			v1 = &tri_coll.mp_collision_obj->mp_coll_tri_data->mp_vert_pos[face->m_vertex_index[1]];
			v2 = &tri_coll.mp_collision_obj->mp_coll_tri_data->mp_vert_pos[face->m_vertex_index[2]];
		} else {
			CCollObjTriData::SFace *face = &(tri_coll.mp_collision_obj->mp_coll_tri_data->mp_faces[tri_coll.m_face_index]);

			v0 = &tri_coll.mp_collision_obj->mp_coll_tri_data->mp_vert_pos[face->m_vertex_index[0]];
			v1 = &tri_coll.mp_collision_obj->mp_coll_tri_data->mp_vert_pos[face->m_vertex_index[1]];
			v2 = &tri_coll.mp_collision_obj->mp_coll_tri_data->mp_vert_pos[face->m_vertex_index[2]];
		}

		SCollSurface collisionSurface;

		/* We've got one */
		collisionSurface.point = (*v0);
		collisionSurface.index = tri_coll.m_face_index;

		// Find normal
		Mth::Vector vTmp1(*v1 - *v0);
		Mth::Vector vTmp2(*v2 - *v0);
		collisionSurface.normal = Mth::CrossProduct(vTmp1, vTmp2);
		collisionSurface.normal.Normalize();

		if (CCollObj::s_found_collision(&tri_coll.m_test_line, tri_coll.mp_collision_obj, &collisionSurface, p_output->distance, CBatchTriColl::sp_coll_data))
		{
			s_found_collision = true;
		}

		p_output++;
	}

	s_result_processing = false;
#else
	Dbg_Assert(s_result_processing);
#endif //	__PLAT_NGPS__
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool	CBatchTriCollMan::sWaitTriCollisions()
{
	// Wait for collision to finish
	while (s_processing)
		;

	if (s_result_processing)
	{
		s_process_results();
	}

	return s_found_collision;
}

#ifdef	__PLAT_NGPS__
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool	CBatchTriCollMan::sUseVU0Micro()
{
	// Make sure we're not in the middle of something
	Dbg_Assert(!s_processing);
	Dbg_Assert(!s_result_processing);

	return s_use_vu0_micro = NxPs2::CSystemResources::sRequestResource(NxPs2::CSystemResources::vVU0_MEMORY);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void	CBatchTriCollMan::sDisableVU0Micro()
{
	// Make sure we're not in the middle of something
	Dbg_Assert(!s_processing);
	Dbg_Assert(!s_result_processing);

	if (s_use_vu0_micro)
	{
		NxPs2::CSystemResources::sFreeResource(NxPs2::CSystemResources::vVU0_MEMORY);
		s_use_vu0_micro = false;
	}
}
#endif	//	__PLAT_NGPS__

#endif	// BATCH_TRI_COLLISION

} // namespace Nx

