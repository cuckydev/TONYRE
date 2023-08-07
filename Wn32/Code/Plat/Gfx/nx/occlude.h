#ifndef	__OCCLUDE_H__
#define	__OCCLUDE_H__

#include <Core/Defines.h>

#include <Core/math.h>

#include "nx_init.h"

namespace NxWn32
{
	void AddOcclusionPoly( Mth::Vector &v0, Mth::Vector &v1, Mth::Vector &v2, Mth::Vector &v3, uint32 checksum = 0 );
	void EnableOcclusionPoly( uint32 checksum, bool available );
	void RemoveAllOcclusionPolys( void );
	void BuildOccluders( Mth::Vector *p_cam_pos, int view );
	bool TestSphereAgainstOccluders(const glm::vec3 &p_center, float radius, uint32 meshes = 1 );
}

#endif

