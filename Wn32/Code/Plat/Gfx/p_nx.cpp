#include <Windows.h>
#include	<sys/file/filesys.h>

#include	"gfx\camera.h"
#include	"gfx\gfxman.h"
#include	"gfx\nx.h"
#include	"gfx\nxtexman.h"
#include	"gfx\nxviewman.h"
#include	"gfx\NxQuickAnim.h"
#include	"gfx\NxParticleMgr.h"
#include	"gfx\NxMiscFX.h"
#include	"gfx\debuggfx.h"
// #include	"gfx\xbox\p_NxSector.h"
// #include	"gfx\xbox\p_NxScene.h"
// #include	"gfx\xbox\p_NxModel.h"
// #include	"gfx\xbox\p_NxGeom.h"
// #include	"gfx\xbox\p_NxMesh.h"
// #include	"gfx\xbox\p_NxSprite.h"
// #include	"gfx\xbox\p_NxTexture.h"
// #include	"gfx\xbox\p_NxParticle.h"
// #include	"gfx\xbox\p_NxTextured3dPoly.h"
// #include	"gfx\xbox\p_NxNewParticleMgr.h"
// #include	"gfx\xbox\p_NxWeather.h"
#include	"core\math.h"
#include 	"sk\engine\SuperSector.h"					
#include 	"gel\scripting\script.h"

namespace Nx
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	void CEngine::s_plat_start_engine(void)
	{
		
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	void CEngine::s_plat_pre_render(void)
	{
		
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	void CEngine::s_plat_post_render(void)
	{
		
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	void CEngine::s_plat_render_world(void)
	{
		
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	CScene *CEngine::s_plat_create_scene(const char *p_name, CTexDict *p_tex_dict, bool add_super_sectors)
	{
		return nullptr;
	}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	CScene *CEngine::s_plat_load_scene_from_memory(void *p_mem, CTexDict *p_tex_dict, bool add_super_sectors, bool is_sky, bool is_dictionary)
	{
		return nullptr;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	CScene *CEngine::s_plat_load_scene(const char *p_name, CTexDict *p_tex_dict, bool add_super_sectors, bool is_sky, bool is_dictionary)
	{
		return nullptr;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	bool CEngine::s_plat_unload_scene(CScene *p_scene)
	{
		return true;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	bool CEngine::s_plat_add_scene(CScene *p_scene, const char *p_filename)
	{
		// Function to incrementally add geometry to a scene - should NOT be getting called on Xbox.
		Dbg_Assert(0);
		return false;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	//CTexDict* CEngine::s_plat_load_textures( const char* p_name )
	//{
	//	NxXbox::LoadTextureFile( p_name );
	//	return NULL;
	//}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	CModel *CEngine::s_plat_init_model(void)
	{
		return nullptr;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	bool CEngine::s_plat_uninit_model(CModel *pModel)
	{
		return true;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	CGeom *CEngine::s_plat_init_geom(void)
	{
		return nullptr;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	bool CEngine::s_plat_uninit_geom(CGeom *p_geom)
	{
		return true;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	CQuickAnim *CEngine::s_plat_init_quick_anim()
	{
		return nullptr;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	void CEngine::s_plat_uninit_quick_anim(CQuickAnim *pQuickAnim)
	{
		return;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	CMesh *CEngine::s_plat_load_mesh(const char *pMeshFileName, Nx::CTexDict *pTexDict, uint32 texDictOffset, bool isSkin, bool doShadowVolume)
	{
		return nullptr;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	CMesh *CEngine::s_plat_load_mesh(uint32 id, uint32 *p_model_data, int model_data_size, uint8 *p_cas_data, Nx::CTexDict *pTexDict, uint32 texDictOffset, bool isSkin, bool doShadowVolume)
	{
		return nullptr;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	bool CEngine::s_plat_unload_mesh(CMesh *pMesh)
	{
		return true;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	void CEngine::s_plat_set_mesh_scaling_parameters(SMeshScalingParameters *pParams)
	{

	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	CSprite *CEngine::s_plat_create_sprite(CWindow2D *p_window)
	{
		return nullptr;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	bool CEngine::s_plat_destroy_sprite(CSprite *p_sprite)
	{
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
		
		return true;
	}


	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	Nx::CTexture *CEngine::s_plat_create_render_target_texture(int width, int height, int depth, int z_depth)
	{
		return nullptr;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	void CEngine::s_plat_project_texture_into_scene(Nx::CTexture *p_texture, Nx::CModel *p_model, Nx::CScene *p_scene)
	{
		
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	void CEngine::s_plat_set_projection_texture_camera(Nx::CTexture *p_texture, Gfx::Camera *p_camera)
	{
		
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	void CEngine::s_plat_stop_projection_texture(Nx::CTexture *p_texture)
	{
		
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	void CEngine::s_plat_add_occlusion_poly(uint32 num_verts, Mth::Vector *p_vert_array, uint32 checksum)
	{
		
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	void CEngine::s_plat_enable_occlusion_poly(uint32 checksum, bool enable)
	{
		
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
		return true;
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	void CEngine::s_plat_set_max_multipass_distance(float dist)
	{
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
		return "";
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	void CEngine::s_plat_set_letterbox(bool letterbox)
	{
	}



	/******************************************************************/
	/*                                                                */
	/*                                                                */
	/******************************************************************/
	void CEngine::s_plat_set_color_buffer_clear(bool clear)
	{
	}

} // namespace Nx
