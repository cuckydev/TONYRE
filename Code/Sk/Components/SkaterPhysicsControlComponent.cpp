//****************************************************************************
//* MODULE:         Sk/Components
//* FILENAME:       SkaterPhysicsControlComponent.cpp
//* OWNER:          Dan
//* CREATION DATE:  3/7/3
//****************************************************************************

#include <Sk/Components/SkaterPhysicsControlComponent.h>

#include <Gel/Object/compositeobject.h>
#include <Gel/Object/compositeobjectmanager.h>
#include <Gel/Scripting/checksum.h>
#include <Gel/Scripting/script.h>
#include <Gel/Scripting/struct.h>
#include <Gel/Scripting/symboltable.h>
#include <Gel/Components/TriggerComponent.h>
#include <Gel/Components/WalkComponent.h>
#include <Gel/Components/SkaterCameraComponent.h>
#include <Gel/Components/WalkCameraComponent.h>

#ifdef TESTING_GUNSLINGER
#include <Gel/Components/ridercomponent.h>
#endif

#include <Sk/Modules/Skate/skate.h>
#include <Sk/Components/SkaterCorePhysicsComponent.h>
#include <Sk/Components/SkaterRotateComponent.h>
#include <Sk/Components/SkaterAdjustPhysicsComponent.h>
#include <Sk/Components/SkaterFinalizePhysicsComponent.h>
#include <Sk/Components/SkaterStateComponent.h>

namespace Obj
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
CBaseComponent* CSkaterPhysicsControlComponent::s_create()
{
	return static_cast< CBaseComponent* >( new CSkaterPhysicsControlComponent );	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CSkaterPhysicsControlComponent::CSkaterPhysicsControlComponent() : CBaseComponent()
{
	SetType( CRC_SKATERPHYSICSCONTROL );
	
	mp_core_physics_component = nullptr;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
CSkaterPhysicsControlComponent::~CSkaterPhysicsControlComponent()
{
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterPhysicsControlComponent::InitFromStructure( Script::CStruct* pParams )
{
	(void)pParams;

	Dbg_MsgAssert(GetObj()->GetType() == SKATE_TYPE_SKATER, ("CSkaterPhysicsControlComponent added to non-skater composite object"));
	
	m_physics_suspended = false;
}


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterPhysicsControlComponent::Finalize(  )
{
	mp_core_physics_component = GetSkaterCorePhysicsComponentFromObject(GetObj());
	mp_state_component = GetSkaterStateComponentFromObject(GetObj());
	
	Dbg_Assert(mp_core_physics_component);
	Dbg_Assert(mp_state_component);
	
	mp_state_component->m_physics_state = NO_STATE;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterPhysicsControlComponent::RefreshFromStructure( Script::CStruct* pParams )
{
	InitFromStructure(pParams);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterPhysicsControlComponent::Update()
{
	m_restarted_this_frame = false;
	
	// SkaterPhysicsControlComponent is inactive when physics is NOT suspended.  When physics is suspended SkaterPhysicsControlComponent handles
	// setting the skater's display matrix.
	if (!m_physics_suspended) return;
	
	switch (mp_state_component->m_physics_state)
	{
		case SKATING:
			GetObj()->SetDisplayMatrix(mp_core_physics_component->m_lerping_display_matrix);
			break;
		
		case WALKING:
			GetObj()->SetDisplayMatrix(GetObj()->GetMatrix());
			break;
			
		default:
			Dbg_MsgAssert(false, ("No skater physics state switched on before first skater update"));
	}
	
	// If the skater is unsuspended, the physics components will unsuspend as well.  We must check for this and resuspend
	if (!mp_core_physics_component->IsSuspended())
	{
		suspend_physics(true);
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CBaseComponent::EMemberFunctionResult CSkaterPhysicsControlComponent::CallMemberFunction( uint32 Checksum, Script::CStruct* pParams, Script::CScript* pScript )
{
	(void)pParams;

	switch ( Checksum )
	{
		// @script | PausePhysics | PausePhysics will stop all programmatic movement and rotation of the skater
		case Crc::ConstCRC("PausePhysics"):
			if (!m_physics_suspended)
			{
				suspend_physics(true);
			}
			break;
			
        // @script | UnPausePhysics | 
		case Crc::ConstCRC( "UnPausePhysics"):
			if (m_physics_suspended)
			{
				suspend_physics(false);
			}
			break;
			
		case Crc::ConstCRC("Walking"):
			return IsWalking() ? CBaseComponent::MF_TRUE : CBaseComponent::MF_FALSE;
			
		case Crc::ConstCRC("Skating"):
			return IsSkating() ? CBaseComponent::MF_TRUE : CBaseComponent::MF_FALSE;
			
		case Crc::ConstCRC("Driving"):
			return IsDriving() ? CBaseComponent::MF_TRUE : CBaseComponent::MF_FALSE;
			
		case Crc::ConstCRC("SetDriving"):
			mp_state_component->m_driving = true;
			break;
			
		case Crc::ConstCRC("UnsetDriving"):
			mp_state_component->m_driving = false;
			break;
			
		case Crc::ConstCRC("GetTimeSincePhysicsSwitch"):
			pScript->GetParams()->AddFloat(Crc::ConstCRC("TimeSincePhysicsSwitch"), Tmr::ElapsedTime(m_physics_state_switch_time_stamp) * (1.0f / 1000.0f));
			break;
			
		case Crc::ConstCRC("GetPreviousPhysicsStateDuration"):
			pScript->GetParams()->AddFloat(Crc::ConstCRC("PreviousPhysicsStateDuration"), m_previous_physics_state_duration * (1.0f / 1000.0f));
			break;
			
		case Crc::ConstCRC("SkaterPhysicsControl_SwitchWalkingToSkating"):
			switch_walking_to_skating();
			break;
			
		case Crc::ConstCRC("SkaterPhysicsControl_SwitchSkatingToWalking"):
			switch_skating_to_walking();
			break;
			
		case Crc::ConstCRC("SetBoardMissing"):
			m_board_missing = true;
			break;
			
		case Crc::ConstCRC( "UnsetBoardMissing"):
			m_board_missing = false;
			break;
		
		case Crc::ConstCRC("IsBoardMissing"):
			return m_board_missing ? CBaseComponent::MF_TRUE : CBaseComponent::MF_FALSE;
			
#		ifdef TESTING_GUNSLINGER
		case Crc::ConstCRC("SkaterPhysicsControl_SwitchWalkingToRiding"):
			switch_walking_to_riding();
			break;

		case Crc::ConstCRC("SkaterPhysicsControl_SwitchRidingToWalking"):
			switch_riding_to_walking();
			break;
#		endif

		default:
			return CBaseComponent::MF_NOT_EXECUTED;
	}
    return CBaseComponent::MF_TRUE;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterPhysicsControlComponent::GetDebugInfo(Script::CStruct *p_info)
{
#ifdef	__DEBUG_CODE__
	Dbg_MsgAssert(p_info,("nullptr p_info sent to CSkaterPhysicsControlComponent::GetDebugInfo"));
	
	p_info->AddChecksum("m_physics_suspended", m_physics_suspended ? Crc::ConstCRC( "true") : Crc::ConstCRC("false"));
	p_info->AddInteger("m_physics_state", mp_state_component->m_physics_state);

	CBaseComponent::GetDebugInfo(p_info);	  
#endif				 
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterPhysicsControlComponent::suspend_physics ( bool suspend )
{
	m_physics_suspended = suspend;
	
	// If the skater is suspended, we don't want to unsuspend the physics components.  We only want to change the CSkaterPhysicsControlComponent state.
	if (!suspend && GetObj()->IsSuspended()) return;
    
	switch (mp_state_component->m_physics_state)
	{
		case SKATING:
			Dbg_Assert(mp_core_physics_component);
			Dbg_Assert(GetSkaterRotateComponentFromObject(GetObj()));
			Dbg_Assert(GetSkaterAdjustPhysicsComponentFromObject(GetObj()));
			Dbg_Assert(GetSkaterFinalizePhysicsComponentFromObject(GetObj()));
			
			mp_core_physics_component->Suspend(suspend);
			GetSkaterRotateComponentFromObject(GetObj())->Suspend(suspend);
			GetSkaterAdjustPhysicsComponentFromObject(GetObj())->Suspend(suspend);
			GetSkaterFinalizePhysicsComponentFromObject(GetObj())->Suspend(suspend);
			break;

		case WALKING:
			Dbg_Assert(GetWalkComponentFromObject(GetObj()));
			
			GetWalkComponentFromObject(GetObj())->Suspend(suspend);
			break;
			
		default:
			Dbg_Assert(false);
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterPhysicsControlComponent::switch_walking_to_skating (   )
{
	if (mp_state_component->m_physics_state == SKATING) return;
	
	m_previous_physics_state_duration = Tmr::ElapsedTime(m_physics_state_switch_time_stamp);
	m_physics_state_switch_time_stamp = Tmr::GetTime();
	
	CWalkComponent* p_walk_component = GetWalkComponentFromObject(GetObj());
	CCompositeObject* p_skater_cam = get_skater_camera();
	CSkaterCameraComponent* p_skater_camera_component = GetSkaterCameraComponentFromObject(p_skater_cam);
	CWalkCameraComponent* p_walk_camera_component = GetWalkCameraComponentFromObject(p_skater_cam);
	
	Dbg_Assert(p_walk_component);
	Dbg_Assert(p_skater_camera_component);
	Dbg_Assert(p_walk_camera_component);
	
	// switch off walking
	
	p_walk_component->CleanUpWalkState();
	p_walk_component->Suspend(true);
	
	p_walk_camera_component->Suspend(true);
	
	// switch on skating

	mp_state_component->m_physics_state = SKATING;
	
	mp_core_physics_component->Suspend(false);
	mp_core_physics_component->ReadySkateState(p_walk_component->GetState() == CWalkComponent::WALKING_GROUND, p_walk_component->GetRailData(), p_walk_component->GetAcidDropData());
	
	GetSkaterRotateComponentFromObject(GetObj())->Suspend(false);
	GetSkaterAdjustPhysicsComponentFromObject(GetObj())->Suspend(false);
	GetSkaterFinalizePhysicsComponentFromObject(GetObj())->Suspend(false);
	
	p_skater_camera_component->Suspend(false);
	
	// exchange camera states
	SCameraState camera_state;
	p_walk_camera_component->GetCameraState(camera_state);
	p_skater_camera_component->ReadyForActivation(camera_state);
	
	// reapply the physics suspend state
	if (m_physics_suspended)
	{
		suspend_physics(m_physics_suspended);
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterPhysicsControlComponent::switch_skating_to_walking (   )
{
	if (mp_state_component->m_physics_state == WALKING) return;
	
	m_previous_physics_state_duration = Tmr::ElapsedTime(m_physics_state_switch_time_stamp);
	m_physics_state_switch_time_stamp = Tmr::GetTime();
	
	CWalkComponent* p_walk_component = GetWalkComponentFromObject(GetObj());
	CCompositeObject* p_skater_cam = get_skater_camera();
	CSkaterCameraComponent* p_skater_camera_component = GetSkaterCameraComponentFromObject(p_skater_cam);
	CWalkCameraComponent* p_walk_camera_component = GetWalkCameraComponentFromObject(p_skater_cam);
	
	Dbg_Assert(p_walk_component);
	Dbg_Assert(p_skater_camera_component);
	Dbg_Assert(p_walk_camera_component);
	
	// switch off skating
	
	bool ground = mp_core_physics_component->GetState() == GROUND;
	mp_core_physics_component->CleanUpSkateState();
	mp_core_physics_component->Suspend(true);

	GetSkaterRotateComponentFromObject(GetObj())->Suspend(true);
	GetSkaterAdjustPhysicsComponentFromObject(GetObj())->Suspend(true);
	GetSkaterFinalizePhysicsComponentFromObject(GetObj())->Suspend(true);

	p_skater_camera_component->Suspend(true);
	
	// switch on walking
		
	mp_state_component->m_physics_state = WALKING;
	
	p_walk_component->Suspend(false);
	p_walk_component->ReadyWalkState(ground);
	
	p_walk_camera_component->Suspend(false);
	
	// exchange camera states
	SCameraState camera_state;
	p_skater_camera_component->GetCameraState(camera_state);
	p_walk_camera_component->ReadyForActivation(camera_state);
	
	// reapply the physics suspend state
	if (m_physics_suspended)
	{
		suspend_physics(m_physics_suspended);
	}
}


#ifdef TESTING_GUNSLINGER
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CSkaterPhysicsControlComponent::switch_walking_to_riding( void )
{
	if (mp_state_component->m_physics_state == SKATING) return;
	if (mp_state_component->m_physics_state == RIDING) return;
	
	CRiderComponent*		p_rider_component			= GetRiderComponentFromObject(GetObj());

	// Use the rider component to check that this switch is valid.
	if(	p_rider_component->ReadyRiderState( true ))
	{
		CWalkComponent*			p_walk_component			= GetWalkComponentFromObject(GetObj());
		CCompositeObject*		p_skater_cam				= get_skater_camera();
		CSkaterCameraComponent*	p_skater_camera_component	= GetSkaterCameraComponentFromObject(p_skater_cam);
		CWalkCameraComponent*	p_walk_camera_component		= GetWalkCameraComponentFromObject(p_skater_cam);
	
		Dbg_Assert(p_walk_component);
		Dbg_Assert(p_skater_camera_component);
		Dbg_Assert(p_walk_camera_component);
	
		// switch off walking
		p_walk_component->Suspend(true);
		p_walk_camera_component->Suspend(true);
	
		// switch on riding
		mp_state_component->m_physics_state = RIDING;
	
//		mp_core_physics_component->Suspend(false);
//		mp_core_physics_component->ReadySkateState(p_walk_component->GetState() == CWalkComponent::WALKING_GROUND, p_walk_component->GetRailData());
		p_rider_component->Suspend( false );
	
//		GetSkaterRotateComponentFromObject(GetObj())->Suspend(false);
//		GetSkaterAdjustPhysicsComponentFromObject(GetObj())->Suspend(false);
//		GetSkaterFinalizePhysicsComponentFromObject(GetObj())->Suspend(false);
//		GetSkaterCleanupStateComponentFromObject(GetObj())->Suspend(false);
	
//		p_skater_camera_component->Suspend(false);
	
		// exchange camera states
//		SCameraState camera_state;
//		p_walk_camera_component->GetCameraState(camera_state);
//		p_skater_camera_component->ReadyForActivation(camera_state);
	
		// reapply the physics suspend state
		if (m_physics_suspended)
		{
			suspend_physics(m_physics_suspended);
		}
	}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CSkaterPhysicsControlComponent::switch_riding_to_walking( void )
{
//	if (mp_state_component->m_physics_state == WALKING) return;
	
	CWalkComponent*			p_walk_component = GetWalkComponentFromObject(GetObj());
	CRiderComponent*		p_rider_component			= GetRiderComponentFromObject(GetObj());
	CCompositeObject*		p_skater_cam = get_skater_camera();
	CSkaterCameraComponent*	p_skater_camera_component = GetSkaterCameraComponentFromObject(p_skater_cam);
	CWalkCameraComponent*	p_walk_camera_component = GetWalkCameraComponentFromObject(p_skater_cam);
	
	Dbg_Assert(p_walk_component);
	Dbg_Assert(p_skater_camera_component);
	Dbg_Assert(p_walk_camera_component);
	
	// switch off skating
	mp_core_physics_component->Suspend(true);

	GetSkaterRotateComponentFromObject(GetObj())->Suspend(true);
	GetSkaterAdjustPhysicsComponentFromObject(GetObj())->Suspend(true);
	GetSkaterFinalizePhysicsComponentFromObject(GetObj())->Suspend(true);
//	GetSkaterCleanupStateComponentFromObject(GetObj())->Suspend(true);

	p_skater_camera_component->Suspend(true);
	
	// Switch off riding.
	p_rider_component->Suspend( true );

	// switch on walking
	mp_state_component->m_physics_state = WALKING;
	
	p_walk_component->Suspend(false);
	p_walk_component->ReadyWalkState(mp_core_physics_component->GetState() == GROUND);
	p_walk_camera_component->Suspend( false );
	
	// exchange camera states
//	SCameraState camera_state;
//	p_skater_camera_component->GetCameraState( camera_state );
//	p_walk_camera_component->ReadyForActivation( camera_state );
	
	// reapply the physics suspend state
	if (m_physics_suspended)
	{
		suspend_physics(m_physics_suspended);
	}
}



#endif




}
