# Wn32 platform library
add_library(TonyRE.Wn32 STATIC
	# Core
	"Code/Plat/Core/Debug/P_debug.cpp"

	# Gel
	"Code/Plat/Gel/Movies/p_movies.cpp"
	"Code/Plat/Gel/Movies/p_movies.h"

	"Code/Plat/Gel/Music/p_music.cpp"
	"Code/Plat/Gel/Music/p_music.h"
	"Code/Plat/Gel/Music/usersoundtrack.cpp"
	"Code/Plat/Gel/Music/usersoundtrack.h"

	"Code/Plat/Gel/SoundFX/p_sfx.cpp"
	"Code/Plat/Gel/SoundFX/p_sfx.h"

	# Gfx
	"Code/Plat/Gfx/nx/anim.cpp"
	"Code/Plat/Gfx/nx/anim.h"
	"Code/Plat/Gfx/nx/anim_vertdefs.h"
	"Code/Plat/Gfx/nx/billboard.cpp"
	"Code/Plat/Gfx/nx/billboard.h"
	"Code/Plat/Gfx/nx/chars.cpp"
	"Code/Plat/Gfx/nx/chars.h"
	"Code/Plat/Gfx/nx/gamma.cpp"
	"Code/Plat/Gfx/nx/gamma.h"
	"Code/Plat/Gfx/nx/grass.cpp"
	"Code/Plat/Gfx/nx/grass.h"
	"Code/Plat/Gfx/nx/instance.cpp"
	"Code/Plat/Gfx/nx/instance.h"
	"Code/Plat/Gfx/nx/material.cpp"
	"Code/Plat/Gfx/nx/material.h"
	"Code/Plat/Gfx/nx/mesh.cpp"
	"Code/Plat/Gfx/nx/mesh.h"
	"Code/Plat/Gfx/nx/nx_init.cpp"
	"Code/Plat/Gfx/nx/nx_init.h"
	"Code/Plat/Gfx/nx/occlude.cpp"
	"Code/Plat/Gfx/nx/occlude.h"
	"Code/Plat/Gfx/nx/render.cpp"
	"Code/Plat/Gfx/nx/render.h"
	"Code/Plat/Gfx/nx/scene.cpp"
	"Code/Plat/Gfx/nx/scene.h"
	"Code/Plat/Gfx/nx/shader.cpp"
	"Code/Plat/Gfx/nx/shader.h"
	"Code/Plat/Gfx/nx/sprite.cpp"
	"Code/Plat/Gfx/nx/sprite.h"
	"Code/Plat/Gfx/nx/texture.cpp"
	"Code/Plat/Gfx/nx/texture.h"
	"Code/Plat/Gfx/nx/xbmemfnt.h"
	
	"Code/Plat/Gfx/p_gfxman.cpp"
	"Code/Plat/Gfx/p_memview.cpp"
	"Code/Plat/Gfx/p_memview.h"
	"Code/Plat/Gfx/p_nx.cpp"
	"Code/Plat/Gfx/p_nxfont.cpp"
	"Code/Plat/Gfx/p_nxfont.h"
	"Code/Plat/Gfx/p_nxfontman.cpp"
	"Code/Plat/Gfx/p_NxGeom.cpp"
	"Code/Plat/Gfx/p_NxGeom.h"
	"Code/Plat/Gfx/p_NxImposter.cpp"
	"Code/Plat/Gfx/p_NxImposter.h"
	"Code/Plat/Gfx/p_NxLight.cpp"
	"Code/Plat/Gfx/p_NxLight.h"
	"Code/Plat/Gfx/p_NxLightMan.cpp"
	"Code/Plat/Gfx/p_NxLoadScreen.cpp"
	"Code/Plat/Gfx/p_NxMesh.cpp"
	"Code/Plat/Gfx/p_NxMesh.h"
	"Code/Plat/Gfx/p_nxmiscfx.cpp"
	"Code/Plat/Gfx/p_NxModel.cpp"
	"Code/Plat/Gfx/p_NxModel.h"
	"Code/Plat/Gfx/p_nxnewparticle.cpp"
	"Code/Plat/Gfx/p_nxnewparticle.h"
	"Code/Plat/Gfx/p_nxnewparticlemgr.cpp"
	"Code/Plat/Gfx/p_nxnewparticlemgr.h"
	"Code/Plat/Gfx/p_nxparticle.cpp"
	"Code/Plat/Gfx/p_nxparticle.h"
	"Code/Plat/Gfx/p_nxscene.cpp"
	"Code/Plat/Gfx/p_nxscene.h"
	"Code/Plat/Gfx/p_nxsector.cpp"
	"Code/Plat/Gfx/p_nxsector.h"
	"Code/Plat/Gfx/p_NxSprite.cpp"
	"Code/Plat/Gfx/p_NxSprite.h"
	"Code/Plat/Gfx/p_nxtexman.cpp"
	"Code/Plat/Gfx/p_nxtexture.cpp"
	"Code/Plat/Gfx/p_nxtexture.h"
	"Code/Plat/Gfx/p_NxViewMan.cpp"
	"Code/Plat/Gfx/p_NxViewport.cpp"
	"Code/Plat/Gfx/p_NxViewport.h"
	"Code/Plat/Gfx/p_nxweather.cpp"
	"Code/Plat/Gfx/p_nxweather.h"
	"Code/Plat/Gfx/p_NxWin2D.cpp"
	"Code/Plat/Gfx/p_NxWin2D.h"

	# Sk
	"Code/Plat/Sk/GameNet/p_auth.cpp"
	"Code/Plat/Sk/GameNet/p_auth.h"
	"Code/Plat/Sk/GameNet/p_buddy.cpp"
	"Code/Plat/Sk/GameNet/p_buddy.h"
	"Code/Plat/Sk/GameNet/p_match.cpp"
	"Code/Plat/Sk/GameNet/p_match.h"
	"Code/Plat/Sk/GameNet/p_voice.cpp"
	"Code/Plat/Sk/GameNet/p_voice.h"

	# Sys
	"Code/Plat/Sys/Config/p_config.cpp"
	
	"Code/Plat/Sys/File/p_AsyncFilesys.cpp"
	"Code/Plat/Sys/File/p_AsyncFilesys.cpp"
	"Code/Plat/Sys/File/p_filesys.cpp"

	"Code/Plat/Sys/MemCard/p_McMan.cpp"

	"Code/Plat/Sys/SIO/p_keyboard.cpp"
	"Code/Plat/Sys/SIO/p_siodev.cpp"
	"Code/Plat/Sys/SIO/p_sioman.cpp"

	"Code/Plat/Sys/p_timer.cpp"
)
target_link_libraries(TonyRE.Wn32 PUBLIC TonyRE.Common)
target_include_directories(TonyRE.Wn32 PUBLIC "Code")

# Set platform defines
target_compile_definitions(TonyRE.Wn32 PUBLIC __PLAT_WN32__)

# Link libraries
target_link_libraries(TonyRE.Wn32 PUBLIC Ws2_32 SDL2-static glad glm)
