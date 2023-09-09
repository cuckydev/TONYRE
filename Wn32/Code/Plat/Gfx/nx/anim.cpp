#include <Windows.h>

#include <stdio.h>
#include <stdlib.h>

#include <Core/Defines.h>
#include <Core/Debug.h>
#include <Core/HashTable.h>
#include <Core/math.h>
#include <Core/Math/geometry.h>
#include <Sys/File/filesys.h>
#include <Sys/timer.h>

#include "nx_init.h"
#include "mesh.h"
#include "scene.h"
#include "anim.h"
#include "shader.h"

// #include "anim_vertdefs.h"
// 
// #include "WeightedMeshVS_VXC_1Weight.h"
// #include "WeightedMeshVS_VXC_2Weight.h"
// #include "WeightedMeshVS_VXC_3Weight.h"
// 
// #include "WeightedMeshVS_VXC_Specular_1Weight.h"
// #include "WeightedMeshVS_VXC_Specular_2Weight.h"
// #include "WeightedMeshVS_VXC_Specular_3Weight.h"
// 
// #include "WeightedMeshVS_VXC_1Weight_UVTransform.h"
// #include "WeightedMeshVS_VXC_2Weight_UVTransform.h"
// #include "WeightedMeshVS_VXC_3Weight_UVTransform.h"
// 
// #include "WeightedMeshVS_VXC_1Weight_SBPassThru.h"
// #include "WeightedMeshVS_VXC_2Weight_SBPassThru.h"
// #include "WeightedMeshVS_VXC_3Weight_SBPassThru.h"
// 
// #include "WeightedMeshVertexShader_SBWrite.h"
// #include "ShadowBufferStaticGeomVS.h"
// #include "BillboardScreenAlignedVS.h"
// #include "ParticleFlatVS.h"
// #include "ParticleNewFlatVS.h"
// #include "ParticleNewFlatPointSpriteVS.h"

/*
DWORD WeightedMeshVS_VXC_1Weight;
DWORD WeightedMeshVS_VXC_2Weight;
DWORD WeightedMeshVS_VXC_3Weight;
DWORD WeightedMeshVS_VXC_Specular_1Weight;
DWORD WeightedMeshVS_VXC_Specular_2Weight;
DWORD WeightedMeshVS_VXC_Specular_3Weight;
DWORD WeightedMeshVS_VXC_1Weight_UVTransform;
DWORD WeightedMeshVS_VXC_2Weight_UVTransform;
DWORD WeightedMeshVS_VXC_3Weight_UVTransform;
DWORD WeightedMeshVertexShader_SBWrite;
DWORD WeightedMeshVS_VXC_1Weight_SBPassThru;
DWORD WeightedMeshVS_VXC_2Weight_SBPassThru;
DWORD WeightedMeshVS_VXC_3Weight_SBPassThru;
DWORD WeightedMeshVertexShader_VXC_SBPassThru;
DWORD BillboardScreenAlignedVS;
DWORD ParticleFlatVS;
DWORD ParticleNewFlatVS;
DWORD ParticleNewFlatPointSpriteVS;
DWORD ShadowBufferStaticGeomVS;
*/

namespace NxWn32
{
	/*
	// Vertex color attenuation, 4 sets of tex coords.
	static DWORD WeightedMeshVertexShaderVertColUV4Decl[] = {
	D3DVSD_STREAM( 0 ),
	D3DVSD_REG( VSD_REG_POS,		D3DVSDT_FLOAT3 ),		// Position.
	D3DVSD_REG( VSD_REG_WEIGHTS,	D3DVSDT_NORMPACKED3 ),	// Weights.
	D3DVSD_REG( VSD_REG_INDICES,	D3DVSDT_SHORT4 ),		// Indices.
	D3DVSD_REG( VSD_REG_NORMAL,		D3DVSDT_NORMPACKED3 ),	// Normals.
	D3DVSD_REG( VSD_REG_COLOR,		D3DVSDT_D3DCOLOR ),		// Diffuse color.
	D3DVSD_REG( VSD_REG_TEXCOORDS0,	D3DVSDT_FLOAT2 ),		// Texture coordinates 0.
	D3DVSD_REG( VSD_REG_TEXCOORDS1,	D3DVSDT_FLOAT2 ),		// Texture coordinates 1.
	D3DVSD_REG( VSD_REG_TEXCOORDS2,	D3DVSDT_FLOAT2 ),		// Texture coordinates 2.
	D3DVSD_REG( VSD_REG_TEXCOORDS3,	D3DVSDT_FLOAT2 ),		// Texture coordinates 3.
	D3DVSD_END() };
	
	// Billboards.
	static DWORD BillboardVSDecl[] = {
	D3DVSD_STREAM( 0 ),
	D3DVSD_REG( 0,	D3DVSDT_FLOAT3 ),		// Position (actually pivot position).
	D3DVSD_REG( 1,	D3DVSDT_FLOAT3 ),		// Normal (actually position of point relative to pivot).
	D3DVSD_REG( 2,	D3DVSDT_D3DCOLOR ),		// Diffuse color.
	D3DVSD_REG( 3,	D3DVSDT_FLOAT2 ),		// Texture coordinates 0.
	D3DVSD_REG( 4,	D3DVSDT_FLOAT2 ),		// Texture coordinates 1.
	D3DVSD_REG( 5,	D3DVSDT_FLOAT2 ),		// Texture coordinates 2.
	D3DVSD_REG( 6,	D3DVSDT_FLOAT2 ),		// Texture coordinates 3.
	D3DVSD_END() };

	// Particles.
	static DWORD ParticleFlatVSDecl[] = {
	D3DVSD_STREAM( 0 ),
	D3DVSD_REG( 0,	D3DVSDT_D3DCOLOR ),		// Diffuse color (start)
	D3DVSD_REG( 1,	D3DVSDT_D3DCOLOR ),		// Diffuse color (end)
	D3DVSD_REG( 2,	D3DVSDT_SHORT2 ),		// Indices.
	D3DVSD_END() };

	// New, Ps2 style particles using PointSprites.
	static DWORD NewParticleFlatVSDecl[] = {
	D3DVSD_STREAM( 0 ),
	D3DVSD_REG( 0,	D3DVSDT_FLOAT4 ),		// Random 4-element 'R' vector.
	D3DVSD_REG( 1,	D3DVSDT_FLOAT2 ),		// Time and color interpolator.
	D3DVSD_REG( 2,	D3DVSDT_D3DCOLOR ),		// Diffuse color (start)
	D3DVSD_REG( 3,	D3DVSDT_D3DCOLOR ),		// Diffuse color (end)
	D3DVSD_END() };

	// Shadow buffer, static geom.
	static DWORD ShadowBufferStaticGeomVSDecl[] = {
	D3DVSD_STREAM( 0 ),
	D3DVSD_REG( 0,	D3DVSDT_FLOAT3 ),		// Position.
	D3DVSD_REG( 1,	D3DVSDT_D3DCOLOR ),		// Diffuse color.
	D3DVSD_REG( 2,	D3DVSDT_FLOAT2 ),		// Texture coordinates 0.
	D3DVSD_REG( 3,	D3DVSDT_FLOAT2 ),		// Texture coordinates 1.
	D3DVSD_REG( 4,	D3DVSDT_FLOAT2 ),		// Texture coordinates 2.
	D3DVSD_END() };
	*/
	
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
DWORD GetVertexShader( bool vertex_colors, bool specular, uint32 max_weights_used )
{
	(void)vertex_colors;
	(void)specular;
	(void)max_weights_used;

	/*
	Dbg_Assert( max_weights_used > 0 );
	
	if( vertex_colors )
	{
		if( max_weights_used == 1 )
		{
			return ( specular ) ? WeightedMeshVS_VXC_Specular_1Weight : WeightedMeshVS_VXC_1Weight;
		}
		else if( max_weights_used == 2 )
		{
			return ( specular ) ? WeightedMeshVS_VXC_Specular_2Weight : WeightedMeshVS_VXC_2Weight;
		}
		else if( max_weights_used == 3 )
		{
			return ( specular ) ? WeightedMeshVS_VXC_Specular_3Weight : WeightedMeshVS_VXC_3Weight;
		}
	}

	Dbg_Assert( 0 );
	return 0;
	*/
	return 0;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CreateWeightedMeshVertexShaders( void )
{
	/*
	static bool created_shaders = false;

	if( !created_shaders )
	{
		created_shaders = true;

		if( D3D_OK != D3DDevice_CreateVertexShader(	WeightedMeshVertexShaderVertColUV4Decl,
													dwWeightedMeshVS_VXC_1WeightVertexShader,	// Defined in the header file from xsasm.
													&WeightedMeshVS_VXC_1Weight,
													0 ))
		{
			exit( 0 );
		}
		if( D3D_OK != D3DDevice_CreateVertexShader(	WeightedMeshVertexShaderVertColUV4Decl,
													dwWeightedMeshVS_VXC_2WeightVertexShader,	// Defined in the header file from xsasm.
													&WeightedMeshVS_VXC_2Weight,
													0 ))
		{
			exit( 0 );
		}
		if( D3D_OK != D3DDevice_CreateVertexShader(	WeightedMeshVertexShaderVertColUV4Decl,
													dwWeightedMeshVS_VXC_3WeightVertexShader,	// Defined in the header file from xsasm.
													&WeightedMeshVS_VXC_3Weight,
													0 ))
		{
			exit( 0 );
		}

		if( D3D_OK != D3DDevice_CreateVertexShader(	WeightedMeshVertexShaderVertColUV4Decl,
													dwWeightedMeshVS_VXC_Specular_1WeightVertexShader,	// Defined in the header file from xsasm.
													&WeightedMeshVS_VXC_Specular_1Weight,
													0 ))
		{
			exit( 0 );
		}
		if( D3D_OK != D3DDevice_CreateVertexShader(	WeightedMeshVertexShaderVertColUV4Decl,
													dwWeightedMeshVS_VXC_Specular_2WeightVertexShader,	// Defined in the header file from xsasm.
													&WeightedMeshVS_VXC_Specular_2Weight,
													0 ))
		{
			exit( 0 );
		}
		if( D3D_OK != D3DDevice_CreateVertexShader(	WeightedMeshVertexShaderVertColUV4Decl,
													dwWeightedMeshVS_VXC_Specular_3WeightVertexShader,	// Defined in the header file from xsasm.
													&WeightedMeshVS_VXC_Specular_3Weight,
													0 ))
		{
			exit( 0 );
		}

		if( D3D_OK != D3DDevice_CreateVertexShader(	WeightedMeshVertexShaderVertColUV4Decl,
													dwWeightedMeshVS_VXC_1Weight_UVTransformVertexShader,	// Defined in the header file from xsasm.
													&WeightedMeshVS_VXC_1Weight_UVTransform,
													0 ))
		{
			exit( 0 );
		}

		if( D3D_OK != D3DDevice_CreateVertexShader(	WeightedMeshVertexShaderVertColUV4Decl,
													dwWeightedMeshVS_VXC_2Weight_UVTransformVertexShader,	// Defined in the header file from xsasm.
													&WeightedMeshVS_VXC_2Weight_UVTransform,
													0 ))
		{
			exit( 0 );
		}

		if( D3D_OK != D3DDevice_CreateVertexShader(	WeightedMeshVertexShaderVertColUV4Decl,
													dwWeightedMeshVS_VXC_3Weight_UVTransformVertexShader,	// Defined in the header file from xsasm.
													&WeightedMeshVS_VXC_3Weight_UVTransform,
													0 ))
		{
			exit( 0 );
		}

		if( D3D_OK != D3DDevice_CreateVertexShader(	WeightedMeshVertexShaderVertColUV4Decl,
													dwWeightedMeshVertexShader_SBWriteVertexShader,	// Defined in the header file from xsasm.
													&WeightedMeshVertexShader_SBWrite,
													0 ))
		{
			exit( 0 );
		}

		if( D3D_OK != D3DDevice_CreateVertexShader(	WeightedMeshVertexShaderVertColUV4Decl,
													dwWeightedMeshVS_VXC_1Weight_SBPassThruVertexShader,	// Defined in the header file from xsasm.
													&WeightedMeshVS_VXC_1Weight_SBPassThru,
													0 ))
		{
			exit( 0 );
		}

		if( D3D_OK != D3DDevice_CreateVertexShader(	WeightedMeshVertexShaderVertColUV4Decl,
													dwWeightedMeshVS_VXC_2Weight_SBPassThruVertexShader,	// Defined in the header file from xsasm.
													&WeightedMeshVS_VXC_2Weight_SBPassThru,
													0 ))
		{
			exit( 0 );
		}

		if( D3D_OK != D3DDevice_CreateVertexShader(	WeightedMeshVertexShaderVertColUV4Decl,
													dwWeightedMeshVS_VXC_3Weight_SBPassThruVertexShader,	// Defined in the header file from xsasm.
													&WeightedMeshVS_VXC_3Weight_SBPassThru,
													0 ))
		{
			exit( 0 );
		}

		if( D3D_OK != D3DDevice_CreateVertexShader(	BillboardVSDecl,
													dwBillboardScreenAlignedVSVertexShader,					// Defined in the header file from xsasm.
													&BillboardScreenAlignedVS,
													0 ))
		{
			exit( 0 );
		}


		if( D3D_OK != D3DDevice_CreateVertexShader(	ParticleFlatVSDecl,
													dwParticleFlatVSVertexShader,							// Defined in the header file from xsasm.
													&ParticleFlatVS,
													0 ))
		{
			exit( 0 );
		}

		if( D3D_OK != D3DDevice_CreateVertexShader(	ParticleFlatVSDecl,
													dwParticleNewFlatVSVertexShader,						// Defined in the header file from xsasm.
													&ParticleNewFlatVS,
													0 ))
		{
			exit( 0 );
		}

		if( D3D_OK != D3DDevice_CreateVertexShader(	NewParticleFlatVSDecl,
													dwParticleNewFlatPointSpriteVSVertexShader,				// Defined in the header file from xsasm.
													&ParticleNewFlatPointSpriteVS,
													0 ))
		{
			exit( 0 );
		}
		if( D3D_OK != D3DDevice_CreateVertexShader(	ShadowBufferStaticGeomVSDecl,
													dwShadowBufferStaticGeomVSVertexShader,					// Defined in the header file from xsasm.
													&ShadowBufferStaticGeomVS,
													0 ))
		{
			exit( 0 );
		}
	}
	*/
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void setup_weighted_mesh_vertex_shader( void *p_root_matrix, void *p_bone_matrices, int num_bone_matrices )
{
	(void)p_root_matrix;
	(void)p_bone_matrices;
	(void)num_bone_matrices;

	// Get boned shader
	sShader *shader = BonedShader();
	glUseProgram(shader->program);

	// Send matrices
	float *inner = (float *)p_bone_matrices;

	for (int i = 0; i < num_bone_matrices; i++)
	{
		// Send matrix to shader
		char uniform_name[32];
		sprintf(uniform_name, "u_bone[%d]", i);

		glUniformMatrix4fv(glGetUniformLocation(shader->program, uniform_name), 1, GL_FALSE, inner);
		inner += 16;
	}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void startup_weighted_mesh_vertex_shader( void )
{
	// Switch to 192 constant mode, removing the lock on the reserved constants c-38 and c-37.
	// D3DDevice_SetShaderConstantMode( D3DSCM_192CONSTANTS | D3DSCM_NORESERVEDCONSTANTS );

	// Flag the custom pipeline is in operation.
	// EngineGlobals.custom_pipeline_enabled = true;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void shutdown_weighted_mesh_vertex_shader( void )
{
	// Switch back to 96 constant mode.
	// D3DDevice_SetShaderConstantMode( D3DSCM_96CONSTANTS );

	// Flag the custom pipeline is no longer in operation.
	// EngineGlobals.custom_pipeline_enabled = false;
}


} // namespace NxWn32