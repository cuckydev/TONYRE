#define MINIAUDIO_IMPLEMENTATION
#define MA_NO_ENCODING
#define MA_NO_DEVICE_IO
#define MA_NO_THREADING
#define MA_NO_GENERATION
#define MA_NO_RESOURCE_MANAGER
#define MA_NO_RUNTIME_LINKING

// Disable some warnings for clang
#if defined(__clang__)
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wnonportable-include-path"
#pragma clang diagnostic ignored "-Wtautological-constant-out-of-range-compare"
#endif

#include <miniaudio.h>

#if defined(__clang__)
#pragma clang diagnostic pop
#endif
