//****************************************************************************
//* MODULE:         Gfx
//* FILENAME:       p_nxParticle.cpp
//* OWNER:          Dave Cowling
//* CREATION DATE:  3/27/2002
//****************************************************************************

#include <Core/Defines.h>
#include "Plat/Gfx/nx/nx_init.h"
#include "Plat/Gfx/p_nxparticle.h"
// #include "Plat/Gfx/p_nxparticleline.h"
// #include "Plat/Gfx/p_nxparticleflat.h"
// #include "Plat/Gfx/p_nxparticleshaded.h"
// #include "Plat/Gfx/p_nxparticlesmooth.h"
// #include "Plat/Gfx/p_nxparticleglow.h"
// #include "Plat/Gfx/p_nxparticlestar.h"
// #include "Plat/Gfx/p_nxparticlesmoothstar.h"
// #include "Plat/Gfx/p_nxparticleribbon.h"
// #include "Plat/Gfx/p_nxparticlesmoothribbon.h"
// #include "Plat/Gfx/p_nxparticleribbontrail.h"
// #include "Plat/Gfx/p_nxparticleglowribbontrail.h"

namespace Nx
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CParticle *plat_create_particle( uint32 checksum, uint32 type_checksum, int max_particles, int max_streams, uint32 texture_checksum, uint32 blendmode_checksum, int fix, int num_segments, float split, int history )
{
	(void)type_checksum;
	(void)max_streams;
	(void)texture_checksum;
	(void)blendmode_checksum;
	(void)fix;
	(void)num_segments;
	(void)split;
	(void)history;

	/*
	switch( type_checksum )
	{
		case 0x2eeb4b09:	// Line
		{
			CXboxParticleLine *p_particle = new CXboxParticleLine( checksum, max_particles, texture_checksum, blendmode_checksum, fix, num_segments, split );
			return static_cast<CParticle*>( p_particle );
		}

		case 0xaab555bb:	// Flat
		{
			CXboxParticleFlat *p_particle = new CXboxParticleFlat( checksum, max_particles, texture_checksum, blendmode_checksum, fix, num_segments, split );
			return static_cast<CParticle*>( p_particle );
		}

		case 0xf4d8d486:	// Shaded
		{
			CXboxParticleShaded *p_particle = new CXboxParticleShaded( checksum, max_particles, texture_checksum, blendmode_checksum, fix );
			return static_cast<CParticle*>( p_particle );
		}
		
		case 0x8addac1f:	// Smooth
		{
			CXboxParticleSmooth *p_particle = new CXboxParticleSmooth( checksum, max_particles, texture_checksum, blendmode_checksum, fix, num_segments, split );
			return static_cast<CParticle*>( p_particle );
		}
		
		case 0x15834eea:	// Glow
		{
			CXboxParticleGlow *p_particle = new CXboxParticleGlow( checksum, max_particles, texture_checksum, blendmode_checksum, fix, num_segments, split );
			return static_cast<CParticle*>( p_particle );
		}

		case 0x3624a5eb:	// Star
		{
			CXboxParticleStar *p_particle = new CXboxParticleStar( checksum, max_particles, texture_checksum, blendmode_checksum, fix, num_segments, split );
			return static_cast<CParticle*>( p_particle );
		}
		
		case 0x97cb7a9:		// SmoothStar
		{
			CXboxParticleSmoothStar *p_particle = new CXboxParticleSmoothStar( checksum, max_particles, texture_checksum, blendmode_checksum, fix, num_segments, split );
			return static_cast<CParticle*>( p_particle );
		}

		case 0xee6fc5b:		// Ribbon
		{
			CXboxParticleRibbon *p_particle = new CXboxParticleRibbon( checksum, max_particles, texture_checksum, blendmode_checksum, fix, num_segments, split, history );
			return static_cast<CParticle*>( p_particle );
		}

		case 0x3f109fcc:	// SmoothRibbon
		{
			CXboxParticleSmoothRibbon *p_particle = new CXboxParticleSmoothRibbon( checksum, max_particles, texture_checksum, blendmode_checksum, fix, num_segments, split, history );
			return static_cast<CParticle*>( p_particle );
		}

		case 0xc4d5a4cb:	// RibbonTrail
		{
			CXboxParticleRibbonTrail *p_particle = new CXboxParticleRibbonTrail( checksum, max_particles, texture_checksum, blendmode_checksum, fix, num_segments, split, history );
			return static_cast<CParticle*>( p_particle );
		}

		case 0x7ec7252d:	// GlowRibbonTrail
		{
			CXboxParticleGlowRibbonTrail *p_particle = new CXboxParticleGlowRibbonTrail( checksum, max_particles, texture_checksum, blendmode_checksum, fix, num_segments, split, history );
			return static_cast<CParticle*>( p_particle );
		}

		case 0xdedfc057:	// NewFlat
		{
			// Just default to old flat for now.
			CXboxParticleFlat *p_particle = new CXboxParticleFlat( checksum, max_particles, texture_checksum, blendmode_checksum, fix, num_segments, split );
			return static_cast<CParticle*>( p_particle );
		}

		default:
		{
			Dbg_MsgAssert( 0, ( "Unsupported particle type" ));
			break;
		}
	}
	*/
	return new CParticle(checksum, max_particles);
	// return nullptr;
}

} // Nx

				


