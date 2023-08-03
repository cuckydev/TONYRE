# Compile GameSpy SDK
add_library(GameSpy STATIC
	"Code/md5c.c"
)
target_include_directories(GameSpy PUBLIC "Code")
