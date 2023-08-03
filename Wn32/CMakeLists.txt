# Wn32 platform library
add_library(TonyRE.Wn32 STATIC
	# Core
	"Code/Plat/Core/Debug/P_debug.cpp"

	# Gel
	"Code/Plat/Gel/Movies/p_movies.cpp"
	"Code/Plat/Gel/Movies/p_movies.h"

	"Code/Plat/Gel/SoundFX/p_sfx.cpp"
	"Code/Plat/Gel/SoundFX/p_sfx.h"

	# Gfx
	"Code/Plat/Gfx/p_nx.cpp"

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

# Link winsock
target_link_libraries(TonyRE.Wn32 PUBLIC Ws2_32)
