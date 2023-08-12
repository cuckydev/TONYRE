#include	<Sys/File/filesys.h>

#include	<Gfx/camera.h>
#include	<Gfx/gfxman.h>
#include	<Gfx/nx.h>
#include	<Gfx/NxTexMan.h>
#include	<Gfx/NxViewMan.h>
#include	<Gfx/NxQuickAnim.h>
#include	<Gfx/nxparticlemgr.h>
#include	<Gfx/NxMiscFX.h>
#include	<Gfx/debuggfx.h>
#include	<Core\math.h>
#include 	<Sk/Engine/SuperSector.h>
#include 	<Gel/Scripting/script.h>

#include "p_NxMesh.h"
#include "p_NxGeom.h"
#include "p_NxSprite.h"
#include "p_NxModel.h"
#include "p_nxnewparticlemgr.h"
#include "p_nxweather.h"

#include "nx/nx_init.h"
#include "nx/scene.h"
#include "nx/render.h"
#include "nx/occlude.h"

namespace Nx
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	void CEngine::s_plat_start_engine(void)
	{
		// Initialize engine
		NxWn32::InitialiseEngine();

		mp_particle_manager = new CXboxNewParticleManager;
		mp_weather = new CXboxWeather;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	void CEngine::s_plat_pre_render(void)
	{
		// Handle SDL events
		SDL_Event event;
		while (SDL_PollEvent(&event))
		{
			switch (event.type)
			{
				case SDL_QUIT:
					// exit(0);
					break;
			}
		}
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	void CEngine::s_plat_post_render(void)
	{
		// Swap window
		SDL_GL_SwapWindow(NxWn32::EngineGlobals.window);

		// Clear the screen for next frame
		glm::vec3 &clear_color = NxWn32::EngineGlobals.clear_color;
		glClearColor(clear_color.r, clear_color.g, clear_color.b, 1.0f);
		glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

		// Increment frame counter
		NxWn32::EngineGlobals.frame_count++;

		// Wait for next frame (60 fps)
		NxWn32::WaitForNextFrame();
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	void CEngine::s_plat_render_world(void)
	{
		// Process imposters
		CEngine::sGetImposterManager()->ProcessImposters();

		// Draw viewports
		int num_viewports = CViewportManager::sGetNumActiveViewports();
		for (int v = 0; v < num_viewports; ++v)
		{
			// Get viewport and camera
			CViewport *p_cur_viewport = CViewportManager::sGetActiveViewport(v);
			Gfx::Camera *p_cur_camera = p_cur_viewport->GetCamera();

			if (p_cur_camera == nullptr)
				continue;

			// There is no bounding box transform for rendering the world.
			NxWn32::set_frustum_bbox_transform(nullptr);

			// Set up the camera..
			float aspect_ratio = p_cur_viewport->GetAspectRatio();

			NxWn32::set_camera(&(p_cur_camera->GetMatrix()), &(p_cur_camera->GetPos()), p_cur_camera->GetAdjustedHFOV(), aspect_ratio);

			// Render the non-sky world scenes.
			for (int i = 0; i < MAX_LOADED_SCENES; i++)
			{
				if (sp_loaded_scenes[i] != nullptr)
				{
					CXboxScene *pXboxScene = static_cast<CXboxScene*>(sp_loaded_scenes[i]);
					if (!pXboxScene->IsSky())
					{
						// Build relevant occlusion poly list, now that the camera is set.
						NxWn32::BuildOccluders(&(p_cur_camera->GetPos()), v);

						// Render scene
						pXboxScene->GetEngineScene()->m_flags |= SCENE_FLAG_RECEIVE_SHADOWS;
						NxWn32::render_scene(pXboxScene->GetEngineScene(), NxWn32::vRENDER_OPAQUE | NxWn32::vRENDER_OCCLUDED | NxWn32::vRENDER_SORT_FRONT_TO_BACK | NxWn32::vRENDER_BILLBOARDS, v);
					}
				}
			}

			// Render the sky, followed by all the non-sky semitransparent scene geometry. There is no bounding box transform for rendering the world.
			NxWn32::set_frustum_bbox_transform(nullptr);

			// Render imposters
			CEngine::sGetImposterManager()->DrawImposters();

			// Render opaque instances
			NxWn32::render_instances(NxWn32::vRENDER_OPAQUE);

			// Render all semitransparent instances.
			NxWn32::render_instances(NxWn32::vRENDER_SEMITRANSPARENT | NxWn32::vRENDER_INSTANCE_PRE_WORLD_SEMITRANSPARENT);

			// Render the non - sky semitransparent scene geometry.
			// Setting the depth clip control to clamp here means that semitransparent periphary objects that would usually cull out
			// are now drawn correctly (since they will clamp at 1.0, and the z test is <=).
			for (int i = 0; i < MAX_LOADED_SCENES; i++)
			{
				if (sp_loaded_scenes[i])
				{
					CXboxScene *pXboxScene = static_cast<CXboxScene *>(sp_loaded_scenes[i]);
					if (!pXboxScene->IsSky())
					{
						// Build relevant occlusion poly list, now that the camera is set.
						NxWn32::render_scene(pXboxScene->GetEngineScene(), NxWn32::vRENDER_SEMITRANSPARENT |
							NxWn32::vRENDER_OCCLUDED |
							NxWn32::vRENDER_BILLBOARDS, v);
					}
				}
			}

			// Render all semitransparent instances.
			NxWn32::render_instances(NxWn32::vRENDER_SEMITRANSPARENT | NxWn32::vRENDER_INSTANCE_POST_WORLD_SEMITRANSPARENT);
		}

		// Draw 2D sprites
		NxWn32::SDraw2D::DrawAll();
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	CScene *CEngine::s_plat_create_scene(const char *p_name, CTexDict *p_tex_dict, bool add_super_sectors)
	{
		(void)p_name;
		(void)p_tex_dict;

		// Create scene class instance
		CXboxScene *p_xbox_scene = new CXboxScene;
		CScene *p_new_scene = p_xbox_scene;
		p_new_scene->SetInSuperSectors(add_super_sectors);
		p_new_scene->SetIsSky(false);

		// Create a new sScene so the engine can track assets for this scene.
		NxWn32::sScene *p_engine_scene = new NxWn32::sScene();
		p_xbox_scene->SetEngineScene(p_engine_scene);

		return p_new_scene;
	}

	#define MemoryRead( dst, size, num, src )	CopyMemory(( dst ), ( src ), (( num ) * ( size )));	\
											( src ) += (( num ) * ( size ))

	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	CScene *CEngine::s_plat_load_scene_from_memory(void *p_mem, CTexDict *p_tex_dict, bool add_super_sectors, bool is_sky, bool is_dictionary)
	{
		uint8 *p_data = (uint8 *)p_mem;
		CSector *pSector;
		CXboxSector *pXboxSector;

		// Create a new sScene so the engine can track assets for this scene.
		NxWn32::sScene *p_engine_scene = new NxWn32::sScene();

		// Set the dictionary flag.
		p_engine_scene->m_is_dictionary = is_dictionary;

		// Version numbers.
		uint32 mat_version, mesh_version, vert_version;
		MemoryRead(&mat_version, sizeof(uint32), 1, p_data);
		MemoryRead(&mesh_version, sizeof(uint32), 1, p_data);
		MemoryRead(&vert_version, sizeof(uint32), 1, p_data);

		// Import materials (they will now be associated at the engine-level with this scene).
		p_engine_scene->pMaterialTable = NxWn32::LoadMaterialsFromMemory((void**)&p_data, p_tex_dict->GetTexLookup());

		// Read number of sectors.
		int num_sectors;
		MemoryRead(&num_sectors, sizeof(int), 1, p_data);

		// Figure optimum hash table lookup size.
		uint32 optimal_table_size = num_sectors * 2;
		uint32 test = 2;
		uint32 size = 1;
		for (;; test <<= 1, ++size)
		{
			// Check if this iteration of table size is sufficient, or if we have hit the maximum size.
			if ((optimal_table_size <= test) || (size >= 12))
			{
				break;
			}
		}

		// Create scene class instance, using optimum size sector table.
		CScene *new_scene = new CXboxScene(size);
		new_scene->SetInSuperSectors(add_super_sectors);
		new_scene->SetIsSky(is_sky);

		// Get a scene id from the engine.
		CXboxScene *p_new_xbox_scene = static_cast<CXboxScene *>(new_scene);
		p_new_xbox_scene->SetEngineScene(p_engine_scene);

		for (int s = 0; s < num_sectors; ++s)
		{
			// Create a new sector to hold the incoming details.
			pSector = p_new_xbox_scene->CreateSector();
			pXboxSector = static_cast<CXboxSector *>(pSector);

			// Generate a hanging geom for the sector, used for creating level objects etc.
			CXboxGeom *p_xbox_geom = new CXboxGeom();
			p_xbox_geom->SetScene(p_new_xbox_scene);
			pXboxSector->SetGeom(p_xbox_geom);

			// Prepare CXboxGeom for receiving data.
			p_xbox_geom->InitMeshList();

			// Load sector data.
			if (pXboxSector->LoadFromMemory((void **)&p_data))
			{
				new_scene->AddSector(pSector);
			}
		}

		// At this point get the engine scene to figure it's bounding volumes.
		p_engine_scene->FigureBoundingVolumes();

		// Read hierarchy information.
		int num_hierarchy_objects;
		MemoryRead(&num_hierarchy_objects, sizeof(int), 1, p_data);

		if (num_hierarchy_objects > 0)
		{
			p_engine_scene->mp_hierarchyObjects = new CHierarchyObject[num_hierarchy_objects];
			MemoryRead(p_engine_scene->mp_hierarchyObjects, sizeof(CHierarchyObject), num_hierarchy_objects, p_data);
			p_engine_scene->m_numHierarchyObjects = num_hierarchy_objects;
		}

		return new_scene;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	CScene *CEngine::s_plat_load_scene(const char *p_name, CTexDict *p_tex_dict, bool add_super_sectors, bool is_sky, bool is_dictionary)
	{
		CSector *pSector;
		CXboxSector *pXboxSector;

		Dbg_Message("loading scene from file %s\n", p_name);

		// Create a new NxWn32::sScene so the engine can track assets for this scene.
		NxWn32::sScene *p_engine_scene = new NxWn32::sScene();

		// Set the dictionary flag.
		p_engine_scene->m_is_dictionary = is_dictionary;

		// Open the scene file.
		void *p_file = File::Open(p_name, "rb");
		if (!p_file)
		{
			Dbg_MsgAssert(p_file, ("Couldn't open scene file %s\n", p_name));
			return nullptr;
		}

		// Version numbers.
		uint32 mat_version, mesh_version, vert_version;
		File::Read(&mat_version, sizeof(uint32), 1, p_file);
		File::Read(&mesh_version, sizeof(uint32), 1, p_file);
		File::Read(&vert_version, sizeof(uint32), 1, p_file);

		// Import materials (they will now be associated at the engine-level with this scene).
		p_engine_scene->pMaterialTable = NxWn32::LoadMaterials(p_file, p_tex_dict->GetTexLookup());

		// Read number of sectors.
		int num_sectors;
		File::Read(&num_sectors, sizeof(int), 1, p_file);

		// Figure optimum hash table lookup size.
		uint32 optimal_table_size = num_sectors * 2;
		uint32 test = 2;
		uint32 size = 1;
		for (;; test <<= 1, ++size)
		{
			// Check if this iteration of table size is sufficient, or if we have hit the maximum size.
			if ((optimal_table_size <= test) || (size >= 12))
			{
				break;
			}
		}

		// Create scene class instance, using optimum size sector table.
		CScene *new_scene = new CXboxScene(size);
		new_scene->SetInSuperSectors(add_super_sectors);
		new_scene->SetIsSky(is_sky);

		// Get a scene id from the engine.
		CXboxScene *p_new_xbox_scene = static_cast<CXboxScene *>(new_scene);
		p_new_xbox_scene->SetEngineScene(p_engine_scene);

		for (int s = 0; s < num_sectors; ++s)
		{
			// Create a new sector to hold the incoming details.
			pSector = p_new_xbox_scene->CreateSector();
			pXboxSector = static_cast<CXboxSector *>(pSector);

			// Generate a hanging geom for the sector, used for creating level objects etc.
			CXboxGeom *p_xbox_geom = new CXboxGeom();
			p_xbox_geom->SetScene(p_new_xbox_scene);
			pXboxSector->SetGeom(p_xbox_geom);

			// Prepare CXboxGeom for receiving data.
			p_xbox_geom->InitMeshList();

			// Load sector data.
			if (pXboxSector->LoadFromFile(p_file))
			{
				new_scene->AddSector(pSector);
			}
		}

		// At this point get the engine scene to figure it's bounding volumes.
		p_engine_scene->FigureBoundingVolumes();

		// Read hierarchy information.
		int num_hierarchy_objects;
		File::Read(&num_hierarchy_objects, sizeof(int), 1, p_file);

		if (num_hierarchy_objects > 0)
		{
			p_engine_scene->mp_hierarchyObjects = new CHierarchyObject[num_hierarchy_objects];
			File::Read(p_engine_scene->mp_hierarchyObjects, sizeof(CHierarchyObject), num_hierarchy_objects, p_file);
			p_engine_scene->m_numHierarchyObjects = num_hierarchy_objects;
		}

		File::Close(p_file);

		return new_scene;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	bool CEngine::s_plat_unload_scene(CScene *p_scene)
	{
		Dbg_MsgAssert(p_scene, ("Trying to delete a NULL scene"));

		CXboxScene *p_xbox_scene = (CXboxScene *)p_scene;

		// Ask the engine to remove the associated meshes for each sector in the scene.
		p_xbox_scene->DestroySectorMeshes();

		// Get the engine specific scene data and pass it to the engine to delete.
		NxWn32::DeleteScene(p_xbox_scene->GetEngineScene());
		p_xbox_scene->SetEngineScene(NULL);

		return true;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	bool CEngine::s_plat_add_scene(CScene *p_scene, const char *p_filename)
	{
		(void)p_scene;
		(void)p_filename;
		// Function to incrementally add geometry to a scene - should NOT be getting called on Xbox.
		Dbg_Assert(0);
		return false;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	/*
	CTexDict* CEngine::s_plat_load_textures( const char* p_name )
	{
		// NxWn32::LoadTextureFile( p_name );
		return nullptr;
	}
	*/



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	CModel *CEngine::s_plat_init_model(void)
	{
		return new CXboxModel;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	bool CEngine::s_plat_uninit_model(CModel *pModel)
	{
		delete pModel;
		return true;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	CGeom *CEngine::s_plat_init_geom(void)
	{
		CXboxGeom *pGeom = new CXboxGeom;
		return pGeom;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	bool CEngine::s_plat_uninit_geom(CGeom *p_geom)
	{
		delete p_geom;
		return true;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	CQuickAnim *CEngine::s_plat_init_quick_anim()
	{
		CQuickAnim *pQuickAnim = new CQuickAnim;
		return pQuickAnim;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	void CEngine::s_plat_uninit_quick_anim(CQuickAnim *pQuickAnim)
	{
		delete pQuickAnim;
		return;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	CMesh *CEngine::s_plat_load_mesh(const char *pMeshFileName, Nx::CTexDict *pTexDict, uint32 texDictOffset, bool isSkin, bool doShadowVolume)
	{
		(void)texDictOffset;
		(void)isSkin;
		(void)doShadowVolume;

		// Load the scene.
		Nx::CScene *p_scene = Nx::CEngine::s_plat_load_scene(pMeshFileName, pTexDict, false, false, false);

		// Store the checksum of the scene name.
		p_scene->SetID(Script::GenerateCRC(pMeshFileName)); // store the checksum of the scene name

		p_scene->SetTexDict(pTexDict);
		p_scene->PostLoad(pMeshFileName);

		// Disable cutscene scaling
		NxWn32::DisableMeshScaling();

		// Create mesh
		CXboxMesh *pMesh = new CXboxMesh(pMeshFileName);

		Nx::CXboxScene *p_xbox_scene = static_cast<Nx::CXboxScene*>(p_scene);
		pMesh->SetScene(p_xbox_scene);
		pMesh->SetTexDict(pTexDict);

		return pMesh;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	CMesh *CEngine::s_plat_load_mesh(uint32 id, uint32 *p_model_data, int model_data_size, uint8 *p_cas_data, Nx::CTexDict *pTexDict, uint32 texDictOffset, bool isSkin, bool doShadowVolume)
	{
		(void)model_data_size;
		(void)texDictOffset;
		(void)isSkin;
		(void)doShadowVolume;

		// Convert the id into a usable string.
		Dbg_Assert(id > 0);
		char id_as_string[16];
		sprintf(id_as_string, "%d\n", id);

		// Load the scene.
		Nx::CScene *p_scene = Nx::CEngine::s_plat_load_scene_from_memory(p_model_data, pTexDict, false, false, false);

		// Store the checksum of the scene name.
		p_scene->SetID(Script::GenerateCRC(id_as_string));

		p_scene->SetTexDict(pTexDict);
		p_scene->PostLoad(id_as_string);

		CXboxMesh *pMesh = new CXboxMesh();

		// Set CAS data for mesh.
		pMesh->SetCASData(p_cas_data);

		// Disable any scaling.
		NxWn32::DisableMeshScaling();

		Nx::CXboxScene *p_xbox_scene = static_cast<Nx::CXboxScene *>(p_scene);
		pMesh->SetScene(p_xbox_scene);
		pMesh->SetTexDict(pTexDict);
		return pMesh;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	bool CEngine::s_plat_unload_mesh(CMesh *pMesh)
	{
		delete pMesh;
		return true;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	void CEngine::s_plat_set_mesh_scaling_parameters(SMeshScalingParameters *pParams)
	{
		NxWn32::SetMeshScalingParameters(pParams);
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	CSprite *CEngine::s_plat_create_sprite(CWindow2D *p_window)
	{
		(void)p_window;
		return new CXboxSprite;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	bool CEngine::s_plat_destroy_sprite(CSprite *p_sprite)
	{
		delete p_sprite;
		return true;
	}

	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/

	CTextured3dPoly *CEngine::s_plat_create_textured_3d_poly()
	{
		return nullptr;
	}

	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/

	bool		CEngine::s_plat_destroy_textured_3d_poly(CTextured3dPoly *p_poly)
	{
		(void)p_poly;
		return true;
	}


	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	Nx::CTexture *CEngine::s_plat_create_render_target_texture(int width, int height, int depth, int z_depth)
	{
		(void)width;
		(void)height;
		(void)depth;
		(void)z_depth;
		return nullptr;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	void CEngine::s_plat_project_texture_into_scene(Nx::CTexture *p_texture, Nx::CModel *p_model, Nx::CScene *p_scene)
	{
		(void)p_texture;
		(void)p_model;
		(void)p_scene;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	void CEngine::s_plat_set_projection_texture_camera(Nx::CTexture *p_texture, Gfx::Camera *p_camera)
	{
		(void)p_texture;
		(void)p_camera;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	void CEngine::s_plat_stop_projection_texture(Nx::CTexture *p_texture)
	{
		(void)p_texture;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	void CEngine::s_plat_add_occlusion_poly(uint32 num_verts, Mth::Vector *p_vert_array, uint32 checksum)
	{
		(void)num_verts;
		(void)p_vert_array;
		(void)checksum;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	void CEngine::s_plat_enable_occlusion_poly(uint32 checksum, bool enable)
	{
		(void)checksum;
		(void)enable;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	void CEngine::s_plat_remove_all_occlusion_polys(void)
	{
		
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	// returns true if the sphere at "center", with the "radius"
	// is visible to the current camera
	// (note, currently this is the last frame's camera on PS2)
	bool CEngine::s_plat_is_visible(Mth::Vector &center, float radius)
	{
		(void)center;
		(void)radius;
		return true;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	void CEngine::s_plat_set_max_multipass_distance(float dist)
	{
		(void)dist;
		// Has no meaning for Xbox.
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	const char *CEngine::s_plat_get_platform_extension(void)
	{
		// String literals are statically allocated so can be returned safely, (Bjarne, p90)
		return "Xbx";
	}


	/******************************************************************/
	// Wait for any pending asyncronous rendering to finish, so rendering
	// data can be unloaded
	/******************************************************************/
	void CEngine::s_plat_finish_rendering()
	{
		
	}

	/******************************************************************/
	// Set the amount that the previous frame is blended with this frame
	// 0 = none	  	(just see current frame) 	
	// 128 = 50/50
	// 255 = 100% 	(so you only see the previous frame)												  
	/******************************************************************/
	void CEngine::s_plat_set_screen_blur(uint32 amount)
	{
		(void)amount;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	int	CEngine::s_plat_get_num_soundtracks(void)
	{
		return 0;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	const char *CEngine::s_plat_get_soundtrack_name(int soundtrack_number)
	{
		(void)soundtrack_number;
		return "";
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	void CEngine::s_plat_set_letterbox(bool letterbox)
	{
		(void)letterbox;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	void CEngine::s_plat_set_color_buffer_clear(bool clear)
	{
		(void)clear;
	}

} // namespace Nx
