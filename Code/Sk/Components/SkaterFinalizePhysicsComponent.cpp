//****************************************************************************
//* MODULE:         sk/Components
//* FILENAME:       SkaterFinalizePhysicsComponent.cpp
//* OWNER:          Dan
//* CREATION DATE:  3/26/3
//****************************************************************************

#include <Sk/Components/SkaterFinalizePhysicsComponent.h>
#include <Sk/Components/SkaterCorePhysicsComponent.h>
#include <Sk/Components/SkaterStateComponent.h>
#include <Sk/Components/SkaterLoopingSoundComponent.h>
#include <Sk/Components/SkaterSoundComponent.h>

#include <Gel/Object/compositeobject.h>
#include <Gel/Scripting/checksum.h>
#include <Gel/Scripting/script.h>
#include <Gel/Scripting/struct.h>
				  
namespace Obj
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CBaseComponent* CSkaterFinalizePhysicsComponent::s_create()
{
	return static_cast< CBaseComponent* >( new CSkaterFinalizePhysicsComponent );	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CSkaterFinalizePhysicsComponent::CSkaterFinalizePhysicsComponent() : CBaseComponent()
{
	SetType( CRC_SKATERFINALIZEPHYSICS );

	mp_core_physics_component = nullptr;
	mp_state_component = nullptr;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
CSkaterFinalizePhysicsComponent::~CSkaterFinalizePhysicsComponent()
{
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterFinalizePhysicsComponent::InitFromStructure( Script::CStruct* pParams )
{
	(void)pParams;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterFinalizePhysicsComponent::RefreshFromStructure( Script::CStruct* pParams )
{
	(void)pParams;

	InitFromStructure(pParams);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterFinalizePhysicsComponent::Finalize (   )
{
	mp_core_physics_component = GetSkaterCorePhysicsComponentFromObject(GetObj());
	mp_state_component = GetSkaterStateComponentFromObject(GetObj());
		
	Dbg_Assert(mp_core_physics_component);
	Dbg_Assert(mp_state_component);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterFinalizePhysicsComponent::Update()
{
	// setup the state component
	
	// Logic for setting/not setting the flag for telling the camera whether to look down on the skater or not.
	if (mp_core_physics_component->m_began_frame_in_lip_state && mp_state_component->GetState() != LIP)
	{
		// This flag is sort of badly named now, it really means we changed from the lip state to something other than GROUND or LIP.
		mp_state_component->mJumpedOutOfLipTrick = false;
		if (mp_state_component->GetState() == AIR)
		{
			// we only want to set this flag if we jumped straight up; meaning the x and z velocities are close to zero
			if (Mth::Abs(GetObj()->m_vel[X]) < 1.0f && Mth::Abs(GetObj()->m_vel[Z]) < 1.0f)
			{
				mp_state_component->mJumpedOutOfLipTrick = true;
			}				
		}
	}
	
	// this flag needs clearing whenever we get out of the air
	if (mp_state_component->GetState() != AIR)
	{
		mp_state_component->mJumpedOutOfLipTrick = false;
	}
	
	mp_state_component->m_camera_display_normal = mp_core_physics_component->m_display_normal;
	mp_state_component->m_camera_current_normal = mp_core_physics_component->m_current_normal;
	
	// make sure the matrices don't get distorted
	GetObj()->m_matrix.OrthoNormalizeAbout(Y);
	mp_core_physics_component->m_lerping_display_matrix.OrthoNormalizeAbout(Y);
	
	// if any part of the matrix has collapsed, then we will neet to patch it up	
	// Note, this is a very rare occurence; probably only occurs when you hit things perfectly at right angles, so
	// you attempt to orthonormalize about an axis that that is now coincident with another axis
	// would not happen if we rotated the matrix, or used quaternions
	if (GetObj()->m_matrix.PatchOrthogonality())
	{
		mp_core_physics_component->ResetLerpingMatrix();
	}
	
	// Extract the informations from the physics object that we need for rendering
	GetObj()->SetDisplayMatrix(mp_core_physics_component->m_lerping_display_matrix);
	
	#ifdef __USER_DAN__
	// Gfx::AddDebugArrow(GetObj()->GetPos(), GetObj()->GetPos() + 60.0f * GetObj()->GetDisplayMatrix()[Z], RED, 0, 1);
	// Gfx::AddDebugArrow(GetObj()->GetPos(), GetObj()->GetPos() + 60.0f * GetObj()->GetDisplayMatrix()[X], BLUE, 0, 1);
	// Gfx::AddDebugArrow(GetObj()->GetPos(), GetObj()->GetPos() + 60.0f * GetObj()->GetDisplayMatrix()[Y], GREEN, 0, 1);
	#endif
	
	// update the sound components' state
	
	Obj::CSkaterSoundComponent *pSoundComponent = GetSkaterSoundComponentFromObject( GetObj() );
	Dbg_Assert( pSoundComponent );
	
	pSoundComponent->SetIsRailSliding( mp_state_component->GetFlag(RAIL_SLIDING) );
	pSoundComponent->SetTerrain( mp_state_component->GetTerrain() );
	
	Obj::CSkaterLoopingSoundComponent *pLoopingSoundComponent = GetSkaterLoopingSoundComponentFromObject( GetObj() );
	Dbg_Assert( pLoopingSoundComponent );
	
	float speed_fraction = sqrtf( GetObj()->GetVel()[X] * GetObj()->GetVel()[X] + GetObj()->GetVel()[Z] * GetObj()->GetVel()[Z] ) / GetSkater()->GetScriptedStat(Crc::ConstCRC("Skater_Max_Max_Speed_Stat") );
	pLoopingSoundComponent->SetSpeedFraction( speed_fraction );
	pLoopingSoundComponent->SetIsBailing(mp_state_component->GetFlag(IS_BAILING));
	pLoopingSoundComponent->SetIsRailSliding( mp_state_component->GetFlag(RAIL_SLIDING) );
	pLoopingSoundComponent->SetTerrain( mp_state_component->GetTerrain() );
	pLoopingSoundComponent->SetState( mp_state_component->GetState() );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CBaseComponent::EMemberFunctionResult CSkaterFinalizePhysicsComponent::CallMemberFunction( uint32 Checksum, Script::CStruct* pParams, Script::CScript* pScript )
{
	(void)Checksum;
	(void)pParams;
	(void)pScript;
	
	return CBaseComponent::MF_NOT_EXECUTED;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterFinalizePhysicsComponent::GetDebugInfo(Script::CStruct *p_info)
{
#ifdef	__DEBUG_CODE__
	Dbg_MsgAssert(p_info,("nullptr p_info sent to CSkaterFinalizePhysicsComponent::GetDebugInfo"));
	
	CBaseComponent::GetDebugInfo(p_info);	  
#endif				 
}
	
}
