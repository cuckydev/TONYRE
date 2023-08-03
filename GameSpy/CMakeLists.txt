# Compile GameSpy SDK
add_library(GameSpy STATIC
	"SDK/src/GameSpy/md5c.c"
)
target_include_directories(GameSpy PUBLIC "SDK/src/GameSpy")
