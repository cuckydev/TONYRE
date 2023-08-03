# Wn32 platform library
add_library(TonyRE.Wn32 STATIC
	"Code/Plat/p_config.cpp"
	"Code/Plat/P_debug.cpp"
	"Code/Plat/p_movies.cpp"
	"Code/Plat/p_movies.h"
	"Code/Plat/p_sfx.cpp"
	"Code/Plat/p_sfx.h"
	"Code/Plat/p_timer.cpp"
)

target_link_libraries(TonyRE.Wn32 PUBLIC TonyRE.Common)

target_include_directories(TonyRE.Wn32 PUBLIC "Code")

# Set platform defines
target_compile_definitions(TonyRE.Wn32 PUBLIC __PLAT_WN32__)

# Link winsock
target_link_libraries(TonyRE.Wn32 PUBLIC Ws2_32)
