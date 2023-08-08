#ifndef __SCENE_H
#define __SCENE_H


#include <core/defines.h>
#include <core/math.h>
#include <core/math/geometry.h>
#include <gfx/NxHierarchy.h>
#include "texture.h"
#include "mesh.h"
#include "material.h"
#include "anim.h"

namespace NxWn32
{


struct sMeshEntry
{
	sMesh *mp_mesh = nullptr; // Pointer to mesh.
	int m_bbox = 0;// Bounding box index.
};

#define SCENE_FLAG_RENDERING_SHADOW		( 1 << 7 )
#define SCENE_FLAG_RECEIVE_SHADOWS		( 1 << 8 )
#define SCENE_FLAG_SELF_SHADOWS			( 1 << 9 )

struct sScene
{
	sScene( void );
	~sScene( void );

	sMaterial *GetMaterial( uint32 checksum );
	void CountMeshes( int num_meshes, sMesh **pp_meshes );
	void CreateMeshArrays( void );
	void AddMeshes( int num_meshes, sMesh **pp_meshes );
	void RemoveMeshes( int num_meshes, sMesh **pp_meshes );
	void SortMeshes( void );
	sMesh *GetMeshByLoadOrder( int load_order );
	void FigureBoundingVolumes( void );
	void HidePolys( uint32 mask, sCASData *p_cas_data, uint32 num_entries );
	
	uint32 m_flags = 0;

	int NumTextures = 0;
	uint8 *pTexBuffer = nullptr;
	uint8 *pTexDma = nullptr;
	sTexture *pTextures = nullptr;

	int NumMaterials = 0;
	Lst::HashTable<sMaterial> *pMaterialTable = nullptr;
	
	sMesh **m_meshes = nullptr;
	int m_num_mesh_entries = 0;
	int m_num_semitransparent_mesh_entries = 0; // Used for making scene level draw order decisions.
	int m_num_filled_mesh_entries = 0;
	int m_first_semitransparent_entry = 0;
	int m_first_dynamic_sort_entry = 0;
	int m_num_dynamic_sort_entries = 0;
	
	class CInstance *pInstances = nullptr;

	static sScene *pHead;
	sScene *pNext = nullptr;

	bool m_is_dictionary = false;

	Mth::CBBox m_bbox = Mth::CBBox();
	glm::vec3 m_sphere_center = glm::vec3();
	float m_sphere_radius = 0.0f;

	// For mesh heirarchies.
	int m_numHierarchyObjects = 0;
	Nx::CHierarchyObject *mp_hierarchyObjects = nullptr;
};


sScene	*LoadScene( const char *Filename, sScene *pScene );
void	DeleteScene( sScene *pScene );
int		sort_by_material_draw_order( const void *p1, const void *p2 );


} // namespace NxWn32


#endif // __SCENE_H

