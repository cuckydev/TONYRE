#ifndef	__GFX_P_NX_PARTICLELine_H__
#define	__GFX_P_NX_PARTICLELine_H__
    
#include "gfx/xbox/p_nxparticle.h"
                   
namespace Nx
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
/////////////////////////////////////////////////////////////////////////////////////
//
// Here's a machine specific implementation of the CParticle
    
class CXboxParticleLine : public CParticle
{
public:
								CXboxParticleLine();
								CXboxParticleLine( uint32 checksum, int max_particles, uint32 texture_checksum, uint32 blendmode_checksum, int fix, int num_segments, float split );
	virtual						~CXboxParticleLine();

	NxXbox::sParticleSystem*	GetEngineParticle( void )	{ return mp_engine_particle; }
	private:					// It's all private, as it is machine specific
	void						plat_render( void );
	void						plat_get_position( int entry, int list, float * x, float * y, float * z );
	void						plat_set_position( int entry, int list, float x, float y, float z );
	void						plat_add_position( int entry, int list, float x, float y, float z );
	int							plat_get_num_vertex_lists( void );
	int							plat_get_num_particle_colors( void );

	void						plat_set_sr( int entry, uint8 value );
	void						plat_set_sg( int entry, uint8 value );
	void						plat_set_sb( int entry, uint8 value );
	void						plat_set_sa( int entry, uint8 value );
	void						plat_set_mr( int entry, uint8 value );
	void						plat_set_mg( int entry, uint8 value );
	void						plat_set_mb( int entry, uint8 value );
	void						plat_set_ma( int entry, uint8 value );
	void						plat_set_er( int entry, uint8 value );
	void						plat_set_eg( int entry, uint8 value );
	void						plat_set_eb( int entry, uint8 value );
	void						plat_set_ea( int entry, uint8 value );
		
	float*						mp_vertices[2];
	uint32*						mp_colors;
	uint64						m_blend;
	NxXbox::sParticleSystem*	mp_engine_particle;

	Image::RGBA					m_start_color[2];			// Start color for each corner.
	Image::RGBA					m_mid_color[2];				// Mid color for each corner.
	Image::RGBA					m_end_color[2];				// End color for each corner.
};

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
} // Nx


#endif 






