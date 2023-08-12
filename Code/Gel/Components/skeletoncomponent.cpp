//****************************************************************************
//* MODULE:         Gel/Components
//* FILENAME:       SkeletonComponent.cpp
//* OWNER:          Gary Jesdanun
//* CREATION DATE:  10/22/2002
//****************************************************************************

#include <Gel/Components/skeletoncomponent.h>

#include <Gel/AssMan/AssMan.h>
#include <Gel/Object/compositeobject.h>
#include <Gel/Object/compositeobjectmanager.h>
#include <Gel/Scripting/checksum.h>
#include <Gel/Scripting/script.h>
#include <Gel/Scripting/struct.h>
#include <Gel/Scripting/symboltable.h>

#include <Gfx/Skeleton.h>

// TODO:  These won't be needed after the initial
// matrix data gets moved to the SKE file
#include <Core/crc.h>
#include <Core/math.h>
#include <Gfx/NxAnimCache.h>
#include <Gfx/BonedAnim.h>
#include <Gfx/NxMiscFX.h>

// GJ:  CSkeletonComponent is supposed to be a wrapper
// around the Gfx::CSkeleton, which contains a skeletal
// object's final, post-blend matrix buffer.  It should
// be pretty dumb;  neither the CSkeletonComponent nor
// the Gfx::CSkeleton should contain any blending or 
// procedural anim data or functionality.  Furthermore, 
// it shouldn't know anything about animation flipping
// or skateboard rotation.   	    

namespace Obj
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
// This static function is what is registered with the component factory 
// object, (currently the CCompositeObjectManager) 
CBaseComponent* CSkeletonComponent::s_create()
{
	return static_cast< CBaseComponent* >( new CSkeletonComponent );	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkeletonComponent::init_skeleton( uint32 skeleton_name )
{
	Dbg_MsgAssert( mp_skeleton == nullptr, ( "Component already has skeleton." ) );
    
	Gfx::CSkeletonData* pSkeletonData = (Gfx::CSkeletonData*)Ass::CAssMan::Instance()->GetAsset( skeleton_name, false );

	if ( !pSkeletonData )
	{
		Dbg_MsgAssert( 0, ("Unrecognized skeleton %s. (Is skeleton.q up to date?)", Script::FindChecksumName(skeleton_name)) );
	}
    
	mp_skeleton = new Gfx::CSkeleton( pSkeletonData );   
    Dbg_MsgAssert( mp_skeleton, ( "Couldn't create skeleton" ) );

    Dbg_MsgAssert( mp_skeleton->GetNumBones() > 0, ( "Skeleton needs at least one bone" ) );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
CSkeletonComponent::CSkeletonComponent() : CBaseComponent()
{
	SetType( CRC_SKELETON );

    mp_skeleton = nullptr;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
CSkeletonComponent::~CSkeletonComponent()
{
    Dbg_MsgAssert( mp_skeleton, ( "No skeleton had been initialized" ) );
    
    if ( mp_skeleton )
    {
        delete mp_skeleton;
    }
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
void CSkeletonComponent::InitFromStructure( Script::CStruct* pParams )
{
    uint32 skeletonName;

    if ( !pParams->GetChecksum( Crc::ConstCRC("skeleton"), &skeletonName, Script::NO_ASSERT ) )
	{
		pParams->GetChecksum( Crc::ConstCRC("skeletonName"), &skeletonName, Script::ASSERT );
	}

    init_skeleton( skeletonName );

	int maxBoneSkipLOD;
	if(( pParams->GetInteger( Crc::ConstCRC("max_bone_skip_lod"), &maxBoneSkipLOD )) && mp_skeleton )
	{
		mp_skeleton->SetMaxBoneSkipLOD( maxBoneSkipLOD );
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
void CSkeletonComponent::Update()
{
	// Doing nothing, so tell code to do nothing next time around
	Suspend(true);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
Gfx::CSkeleton* CSkeletonComponent::GetSkeleton()
{
    return mp_skeleton;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CBaseComponent::EMemberFunctionResult CSkeletonComponent::CallMemberFunction( uint32 Checksum, Script::CStruct* pParams, Script::CScript* pScript )
{
	switch (Checksum)
    {
		// @script | Obj_SetBoneActive | changes whether the bone should be updated once per frame
		case 0x20f7b992: // Obj_SetBoneActive
		{
			Dbg_MsgAssert( mp_skeleton, ( "Obj_SetBoneActive on object without a skeleton" ) );
			
			uint32 boneName;
			pParams->GetChecksum( Crc::ConstCRC("bone"), &boneName, Script::ASSERT );
			
			int enabled;
			pParams->GetInteger( Crc::ConstCRC("active"), &enabled, Script::ASSERT );

			Dbg_Assert( mp_skeleton );
            mp_skeleton->SetBoneActive( boneName, enabled );

			break;
		}

		case 0xbe1c58ca:	// Obj_GetBonePosition
		{
			Mth::Vector bonePos(0.0f,0.0f,0.0f,1.0f);

			uint32 boneName;
			pParams->GetChecksum( Crc::ConstCRC("bone"), &boneName, Script::ASSERT );
			bool success = GetBoneWorldPosition( boneName, &bonePos );
			
			// make sure we have somewhere to return the data
			Dbg_Assert( pScript && pScript->GetParams() );
			pScript->GetParams()->AddFloat( Crc::ConstCRC("x"), bonePos[X] );
			pScript->GetParams()->AddFloat( Crc::ConstCRC("y"), bonePos[Y] );
			pScript->GetParams()->AddFloat( Crc::ConstCRC("z"), bonePos[Z] );
		
			return success ? CBaseComponent::MF_TRUE : CBaseComponent::MF_FALSE;
		}
		
		// @script | TextureSplat | create a texture splat
        // @parm float | size | 
        // @parmopt float | lifetime | 5.0 | lifetime in seconds
        // @parmopt float | radius | 0.0 | radius
        // @parmopt float | dropdown_length | 3.0 | dropdown length in feet
        // @parmopt float | forward | | distance forward of the origin that this spat goes, assuming no bone specififed		
        // @parmopt string | bone || bone name
        // @parmopt string | name || texture name
        // @parmopt string | trail || indicates that this splat should start or join a trail
		case Crc::ConstCRC("TextureSplat"):
			
		// @script | Skeleton_SpawnTextureSplat | create a texture splat
		// @parm float | size | 
		// @parmopt float | lifetime | 5.0 | lifetime in seconds
		// @parmopt float | radius | 0.0 | radius
		// @parmopt float | dropdown_length | 3.0 | dropdown length in feet
		// @parmopt float | forward | | distance forward of the origin that this spat goes, assuming no bone specififed		
		// @parmopt string | bone || bone name
		// @parmopt string | name || texture name
		// @parmopt string | trail || indicates that this splat should start or join a trail
		case Crc::ConstCRC("Skeleton_SpawnTextureSplat"):
		{	
			float		size;
			float		radius				= 0.0f;
			float		lifetime			= 5.0f;
			float		dropdown_length		= 3.0f;
			float 		forward 			= 0.0f;
			bool		trail				= pParams->ContainsFlag( 0x4d977a70 /*"trail"*/ );
			bool		dropdown_vertical	= pParams->ContainsFlag( 0x7ee6c892 /*"dropdown_vertical"*/ );
			uint32		bone_name_checksum  = 0;
			const char*	p_texture_name;
			Mth::Vector	pos;

			pParams->GetFloat( Crc::ConstCRC("size"), &size );
			pParams->GetFloat( Crc::ConstCRC("radius"), &radius );
			pParams->GetFloat( Crc::ConstCRC("lifetime"), &lifetime );
			pParams->GetFloat( Crc::ConstCRC("dropdown_length"), &dropdown_length );
			
			if( !( pParams->GetText( "name", &p_texture_name )))
			{
				Dbg_MsgAssert( 0, ("%s\nTextureSplat requires a texture name"));
			}

			if( !(pParams->GetChecksumOrStringChecksum( "bone", &bone_name_checksum )))
			{
				if (!pParams->GetFloat( Crc::ConstCRC("forward"), &forward ))
				{
					Dbg_MsgAssert( 0, ("%s\nTextureSplat requires a bone name"));
				}
				else
				{
					pos = GetObj()->GetPos();
					pos += forward * GetObj()->GetMatrix()[Z];
				}
			}

			SpawnTextureSplat( pos, bone_name_checksum, size, radius, lifetime, dropdown_length, p_texture_name, trail, dropdown_vertical );
            break;
		}
		
		// @script | Skeleton_SpawnCompositeObject | creates a rigidbody at the specified bone's position and orientation
		// finish autoducking
		case Crc::ConstCRC("Skeleton_SpawnCompositeObject"):
		{
			uint32 bone_name;
			pParams->GetChecksum(Crc::ConstCRC("bone"), &bone_name, Script::ASSERT);
			
			Mth::Vector offset;
			offset.Set();
			pParams->GetVector(Crc::ConstCRC("offset"), &offset);
			
			Script::CArray* p_component_array;
			pParams->GetArray(Crc::ConstCRC("components"), &p_component_array, Script::ASSERT);
			
			Script::CStruct* p_params;
			pParams->GetStructure(Crc::ConstCRC("params"), &p_params, Script::ASSERT);
			
			Mth::Vector relative_vel;
			pParams->GetVector(Crc::ConstCRC( "vel"), &relative_vel, Script::ASSERT);
			
			Mth::Vector relative_rotvel;
			pParams->GetVector(Crc::ConstCRC("rotvel"), &relative_rotvel, Script::ASSERT);
			
			float object_vel_factor = 1.0f;
			pParams->GetFloat(Crc::ConstCRC("object_vel_factor"), &object_vel_factor);
			
			SpawnCompositeObject(bone_name, p_component_array, p_params, object_vel_factor, relative_vel, relative_rotvel, offset);
			break;
		}

        default:
            return CBaseComponent::MF_NOT_EXECUTED;
    }

    return CBaseComponent::MF_TRUE;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CSkeletonComponent::GetBonePosition( uint32 boneName, Mth::Vector* pBonePos )
{
	Dbg_Assert(mp_skeleton);
	return mp_skeleton->GetBonePosition(boneName, pBonePos);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CSkeletonComponent::GetBoneWorldPosition( uint32 boneName, Mth::Vector* pBonePos )
{
	Dbg_Assert(mp_skeleton);
	
	if ( !mp_skeleton->GetBonePosition( boneName, pBonePos ) )
	{
		pBonePos->Set( 0.0f, 0.0f, 0.0f );
	}

	// now tranform it by the position of the object
    Mth::Matrix rootMatrix;
    rootMatrix = GetObj()->GetMatrix();
    rootMatrix[Mth::POS] = GetObj()->GetPos();
	rootMatrix[Mth::POS][W] = 1.0f;
	Mth::Vector vec = rootMatrix.Transform(* pBonePos );
	(*pBonePos) = vec;

	return false;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkeletonComponent::SpawnTextureSplat( Mth::Vector& pos, uint32 bone_name_checksum, float size, float radius, float lifetime, float dropdown_length, const char *p_texture_name, bool trail, bool dropdown_vertical )
{
	Mth::Vector bone_pos;
	if (!bone_name_checksum)
	{
		bone_pos = pos;
	}
	else
	{
		GetBoneWorldPosition( bone_name_checksum, &bone_pos );
	}

	// Convert dropdown_length from feet to inches.
	dropdown_length *= 12.0f;
	
	// Calculate the end position by dropping down 3 feet along the skater's up vector, or 'world up',
	// depending on the dropdown_vertical flag.
	Mth::Vector end;
	if( dropdown_vertical )
	{
		end = bone_pos - ( Mth::Vector( 0.0f, 1.0f, 0.0f ) * dropdown_length );
	}
	else
	{
		end = bone_pos - ( GetObj()->GetMatrix().GetUp() * dropdown_length );
	}
	
	// In some cases, the bone can be beneath geometry (trucks during a revert), so move the start position up slightly.
	bone_pos += ( GetObj()->GetMatrix().GetUp() * 12.0f );
	
	// Calculate radial offset for end position.
	if( radius > 0.0f )
	{
		float x_offset = -radius + (( radius * 2.0f ) * (float)rand() / RAND_MAX );
		float z_offset = -radius + (( radius * 2.0f ) * (float)rand() / RAND_MAX );

		end += ( GetObj()->GetMatrix().GetRight() * x_offset );
		end += ( GetObj()->GetMatrix().GetAt() * z_offset );
	}
	
	Nx::TextureSplat( bone_pos, end, size, lifetime, p_texture_name, trail ? bone_name_checksum : 0 );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkeletonComponent::SpawnCompositeObject ( uint32 bone_name, Script::CArray* pArray, Script::CStruct* pParams,
	float object_vel_factor, Mth::Vector& relative_vel, Mth::Vector& relative_rotvel, Mth::Vector& offset )
{
	Dbg_Assert(pArray);
	Dbg_Assert(pParams);
	
	CSkeletonComponent* p_skeleton_component = GetSkeletonComponentFromObject(GetObj());
	Dbg_Assert(p_skeleton_component);

	// get the bone's matrix
	Mth::Matrix bone_matrix;
	p_skeleton_component->GetSkeleton()->GetBoneMatrix(bone_name, &bone_matrix);
	
	// build the object's matrix
	Mth::Matrix object_matrix = GetObj()->GetMatrix();
	object_matrix[W] = GetObj()->GetPos();
	object_matrix[X][W] = 0.0f;
	object_matrix[Y][W] = 0.0f;
	object_matrix[Z][W] = 0.0f;
	
	// NOTE: gludge to fix skater board model's coordinate system to match board bone's system
	Mth::Vector temp;
	temp = bone_matrix[Y];
	bone_matrix[Y] = bone_matrix[Z];
	bone_matrix[Z] = -temp;
	offset[W] = 0.0f;
	bone_matrix[W] += offset;
	
	// map the bone to world space
	bone_matrix *= object_matrix;
	
	// write the bone state into the composite object parameters
	
	pParams->AddVector(Crc::ConstCRC("pos"), bone_matrix[W]);
	
	Mth::Quat orientation(bone_matrix);
	if (orientation.GetScalar() > 0.0f)
	{
		pParams->AddVector(Crc::ConstCRC("orientation"), orientation.GetVector());
	}
	else
	{
		pParams->AddVector(Crc::ConstCRC("orientation"), -orientation.GetVector());
	}
	
	// setup rigidbody's initial velocity
	Mth::Vector vel = object_vel_factor * GetObj()->GetVel() + GetObj()->GetMatrix().Rotate(relative_vel);
	pParams->AddVector(Crc::ConstCRC( "vel"), vel);
	
	// setup rigidbody's initial rotational velocity
	Mth::Vector rotvel = GetObj()->GetMatrix().Rotate(relative_rotvel);
	pParams->AddVector(Crc::ConstCRC("rotvel"), rotvel);
	
	CCompositeObjectManager::Instance()->CreateCompositeObjectFromNode(pArray, pParams);
}

}

