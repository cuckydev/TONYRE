//****************************************************************************
//* MODULE:         Gfx
//* FILENAME:       NxMesh.cpp
//* OWNER:          Gary Jesdanun
//* CREATION DATE:  2/15/2002
//****************************************************************************

#include <Gfx/nx.h>
#include <Gfx/NxMesh.h>
#include <Gfx/NxHierarchy.h>

#include <Gel/Collision/Collision.h>
#include <Gel/Collision/CollTriData.h>

#include <Sys/File/pip.h>

#include <cstring>

namespace Nx
{

/*****************************************************************************
**							   Private Functions							**
*****************************************************************************/

///////////////////////////////////////////////////////////////////////////////
// Stub versions of all platform specific functions are provided here:
// so engine implementors can leave certain functionality until later
						
/*****************************************************************************
**								Public Functions							**
*****************************************************************************/

// These functions are the platform independent part of the interface to 
// the platform specific code
// parameter checking can go here....
// although we might just want to have these functions inline, or not have them at all?


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CMesh::CMesh()
{
	m_CASRemovalMask = 0;

	// In case it isn't loaded below the p-line
	mp_hierarchyObjects = nullptr;
	m_numHierarchyObjects = 0;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CMesh::~CMesh()
{
	// Remove Collision
	if (mp_coll_data)
		delete[] mp_coll_data;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool			CMesh::LoadCollision(const char *p_name)
{
	
	// for now collision is kind of assumed to be platform independent
	static char s_pip_name[200];
	strcpy(s_pip_name, p_name);
	char *p_ext = strstr(s_pip_name, ".");
	if (p_ext)
	{
		strcpy(p_ext, ".col.");
	} else {
		strcat(s_pip_name, ".col.");
	}
	strcat(s_pip_name, CEngine::sGetPlatformExtension());

//	Dbg_Message ( "Loading collision %s....", s_pip_name );

	char *p_orig_base_addr = (char*)Pip::Load(s_pip_name);
	if (p_orig_base_addr == nullptr)
	{
		Dbg_Error("Could not open collision file\n");
		return false;
	}

	size_t p_orig_base_size = Pip::GetFileSize(s_pip_name);
	// void *p_orig_base_end = p_orig_base_addr + p_orig_base_size;

	mp_coll_data = Nx::CCollObjTriData::TranslateCollisionData(p_orig_base_addr, p_orig_base_size);
	char *p_base_addr = mp_coll_data;

	Pip::Unload(s_pip_name);

	if (p_base_addr != nullptr)
	{
		Nx::CCollObjTriData::SReadHeader *p_header = (Nx::CCollObjTriData::SReadHeader*)p_base_addr;
		p_base_addr += sizeof(Nx::CCollObjTriData::SReadHeader);

		Dbg_MsgAssert(p_header->m_version == 9, ("Collision version must be at least 9."));

		// reserve space for objects
		m_num_coll_objects = p_header->m_num_objects;
		mp_coll_objects = (Nx::CCollObjTriData *) p_base_addr;

		// Calculate base addresses for vert and face arrays
		uint8 *p_base_vert_addr = (uint8 *) (mp_coll_objects + m_num_coll_objects);

#ifdef FIXED_POINT_VERTICES
		uint8 *p_base_intensity_addr = p_base_vert_addr + (p_header->m_total_num_verts_large * Nx::CCollObjTriData::GetVertElemSize() +
														   p_header->m_total_num_verts_small * Nx::CCollObjTriData::GetVertSmallElemSize());
		uint8 *p_base_face_addr = p_base_intensity_addr + p_header->m_total_num_verts;
		p_base_face_addr = (uint8 *)(((uintptr_t)(p_base_face_addr + 3)) & ~0x3); // Align to 32 bit boundary
#else
		uint8 *p_base_intensity_addr = nullptr;
		uint8 *p_base_face_addr = p_base_vert_addr + (p_header->m_total_num_verts * Nx::CCollObjTriData::GetVertElemSize());
		p_base_face_addr = (uint8 *)(((uintptr_t)(p_base_face_addr+15)) & 0xFFFFFFF0);	// Align to 128 bit boundary
#endif // FIXED_POINT_VERTICES

		// Calculate addresses for BSP arrays
		uint8 *p_node_array_size = p_base_face_addr + (p_header->m_total_num_faces_large * Nx::CCollObjTriData::GetFaceElemSize() +
													   p_header->m_total_num_faces_small * Nx::CCollObjTriData::GetFaceSmallElemSize());
		p_node_array_size += ( p_header->m_total_num_faces_large & 1 ) ? 2 : 0;

		uint32 node_array_size = *((uint32 *)p_node_array_size);
		uint8 *p_base_node_addr = p_node_array_size + 4;
		uint8 *p_base_face_idx_addr = p_base_node_addr + node_array_size;

		// Read objects
		for (uint32 oidx = 0; oidx < p_header->m_num_objects; oidx++)
		{
			if (node_array_size != 0)
			{
				mp_coll_objects[oidx].InitCollObjTriData(nullptr, p_base_vert_addr, p_base_intensity_addr, p_base_face_addr, p_base_node_addr, p_base_face_idx_addr);
				mp_coll_objects[oidx].InitBSPTree();

				// Add to mesh bbox
				m_collision_bbox.AddPoint(mp_coll_objects[oidx].GetBBox().GetMin());
				m_collision_bbox.AddPoint(mp_coll_objects[oidx].GetBBox().GetMax());
			}
			else
			{
				m_num_coll_objects = 0;
				break;
			}
		}

	}

//	Dbg_Message ( "successfully loaded collision" );

	if (m_num_coll_objects > 0)
	{
#if 0
		// Add to CSectors
		for (int i = 0; i < m_num_coll_objects; i++)
		{
			CSector *p_sector = GetSector(mp_coll_objects[i].GetChecksum());
			if (p_sector)	// Don't assert now since there may not be renderable data
			{
				Dbg_MsgAssert(p_sector, ("LoadCollision: Can't find CSector with checksum %x", mp_coll_objects[i].GetChecksum()));
				p_sector->AddCollSector(&(mp_coll_objects[i]));
			}
		}
#endif
	}

	return true;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

Nx::CHierarchyObject* CMesh::GetHierarchy()
{
	return mp_hierarchyObjects;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

int CMesh::GetNumObjectsInHierarchy()
{
	return m_numHierarchyObjects;
}


} // Nx

