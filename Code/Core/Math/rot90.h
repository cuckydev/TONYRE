///////////////////////////////////////////////////////////////////////////////////////
// rot90.h
//

#pragma once

#include <Core/Defines.h>

namespace Mth
{

// Rotation values for 90 degree increment Rotation (uses no multiplication)
enum ERot90 : uint8 {
	ROT_0 = 0,
	ROT_90,
	ROT_180,
	ROT_270,
	NUM_ROTS
};

// Integer rotate
void			RotateY90( ERot90 angle, int32& x, int32& y, int32& z );

}
