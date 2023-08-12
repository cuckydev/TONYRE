///////////////////////////////////////////////////////////////////////////////
// p_NxScene.h

#ifndef	__GFX_P_NX_SCENE_H__
#define	__GFX_P_NX_SCENE_H__

#include "Gfx/nx.h"
#include "Plat/Gfx/nx/scene.h"

namespace Nx
{

/////////////////////////////////////////////////////////////////////////////////////
// Private classes
//
// Here's a machine specific implementation of the CScene
class	CXboxScene : public CScene
{
public:

								CXboxScene( int sector_table_size = 10 );
	NxWn32::sScene *			GetEngineScene() const						{ return mp_engine_scene; }
	void						SetEngineScene( NxWn32::sScene *p_scene )	{ mp_engine_scene = p_scene; }
	void						DestroySectorMeshes( void );

private:		// It's all private, as it is machine specific
	virtual void				plat_post_load();	
	virtual bool				plat_load_textures( const char *p_name );	// load textures 
	virtual bool				plat_load_collision( const char *p_name );	// load collision data
	virtual bool				plat_unload_add_scene( void );
	virtual	CSector	*			plat_create_sector();	 					// empty sector


	NxWn32::sScene				*mp_engine_scene;

};

} // Namespace Nx  			

#endif
