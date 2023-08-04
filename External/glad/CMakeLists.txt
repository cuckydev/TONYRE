# Compile glad library
add_library(glad STATIC
	"src/glad.c"
	"include/glad/glad.h"
	"include/khr/khrplatform.h"
)
target_include_directories(glad PUBLIC "include")
