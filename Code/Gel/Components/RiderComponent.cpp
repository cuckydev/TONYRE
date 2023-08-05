//****************************************************************************
//* MODULE:         Gel/Components
//* FILENAME:       RiderComponent.cpp
//* OWNER:          Dan
//* CREATION DATE:  4/2/3
//****************************************************************************

#include <gel/components/ridercomponent.h>
#include <gel/components/inputcomponent.h>
#include <gel/components/animationcomponent.h>
#include <gel/components/modelcomponent.h>
#include <gel/components/triggercomponent.h>
#include <gel/components/movablecontactcomponent.h>

#include <gel/object/compositeobject.h>
#include <gel/object/compositeobjectmanager.h>
#include <gel/scripting/checksum.h>
#include <gel/scripting/script.h>
#include <gel/scripting/struct.h>
#include <gel/scripting/symboltable.h>
#include <gel/collision/collcache.h>

#include <sk/engine/feeler.h>
#include <sk/modules/skate/skate.h>
#include <sk/components/skaterphysicscontrolcomponent.h>



namespace Obj
{
	
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CBaseComponent* CRiderComponent::s_create()
{
	return static_cast< CBaseComponent* >( new CRiderComponent );	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CRiderComponent::CRiderComponent() : CBaseComponent()
{
	SetType( CRC_RIDER );
	
	mp_collision_cache = Nx::CCollCacheManager::sCreateCollCache();
	
	mp_input_component				= nullptr;
	mp_animation_component			= nullptr;
	mp_movable_contact_component	= nullptr;
	mp_horse_component				= nullptr;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CRiderComponent::~CRiderComponent()
{
	Nx::CCollCacheManager::sDestroyCollCache(mp_collision_cache);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
void CRiderComponent::Finalize()
{
	mp_input_component = GetInputComponentFromObject(GetObj());
	mp_animation_component = GetAnimationComponentFromObject(GetObj());
	mp_model_component = GetModelComponentFromObject(GetObj());
	mp_trigger_component = GetTriggerComponentFromObject(GetObj());
	mp_physics_control_component = GetSkaterPhysicsControlComponentFromObject(GetObj());
	mp_movable_contact_component = GetMovableContactComponentFromObject(GetObj());
	
	Dbg_Assert(mp_input_component);
	Dbg_Assert(mp_animation_component);
	Dbg_Assert(mp_model_component);
	Dbg_Assert(mp_trigger_component);
	Dbg_Assert(mp_physics_control_component);
	Dbg_Assert(mp_movable_contact_component);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CRiderComponent::InitFromStructure( Script::CStruct* pParams )
{
	uint32 camera_id;
	if (pParams->GetChecksum(Crc::ConstCRC("camera"), &camera_id))
	{
		CCompositeObject* p_camera = static_cast< CCompositeObject* >(CCompositeObjectManager::Instance()->GetObjectByID(camera_id));
		Dbg_MsgAssert(mp_camera, ("No such camera object"));
		SetAssociatedCamera(p_camera);
	}
	
	m_script_drag_factor = 1.0f;
}
		 
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CRiderComponent::RefreshFromStructure( Script::CStruct* pParams )
{
	InitFromStructure(pParams);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CRiderComponent::Update()
{
	if( mp_horse_component == nullptr )
	{
		return;
	}

	// TEMP: debounce R1 after a transition
//	if (m_ignore_grab_button && !mp_input_component->GetControlPad().m_R1.GetPressed())
//	{
//		m_ignore_grab_button = false;
//	}
	
	// zero the frame event
	m_last_frame_event = m_frame_event;
	m_frame_event = 0;
	
	// get input
//    get_controller_input();
	
	// extract initial state for this frame from the object
	m_frame_start_pos = m_pos = GetObj()->GetPos();
	
	m_horizontal_vel = GetObj()->GetVel();
	m_horizontal_vel[Y] = 0.0f;
	m_vertical_vel = GetObj()->GetVel()[Y];
	
	// note that m_facing and m_upward will often not be orthogonal, but will always span a plan
	
	// generally straight up, but now after a transition from skating
	m_upward = GetObj()->GetMatrix()[Y];
	
	m_facing = GetObj()->GetMatrix()[Z];
	m_facing[Y] = 0.0f;
	float length = m_facing.Length();
	if (length < 0.001f)
	{
		// upward facing orientation matrix
		m_facing = -GetObj()->GetMatrix()[Y];
		m_facing[Y] = 0.0f;
		m_facing.Normalize();
		
		// since m_upward is now in the same plan as m_facing, push m_upward up a touch
		m_upward[Y] += 0.01f;
		m_upward.Normalize();
	}
	else
	{
		m_facing /= length;
	}
	
	// set the frame length
	m_frame_length = Tmr::FrameLength();
	
	// go to our true Y position
	m_curb_float_height_adjusted = false;
	m_pos[Y] -= m_curb_float_height;
	
	// switch logic based on walking state
	go_on_horse_state();
	
//	switch (m_state)
//	{
//		case WALKING_GROUND:
//			go_on_ground_state();
//			break;
//
//		case WALKING_AIR:
//			go_in_air_state();
//			break;
//																	  
//		case WALKING_HOP:
//			go_hop_state();
//			break;
//																	  
//		case WALKING_HANG:
//			go_hang_state();
//			break;
//            
//		case WALKING_LADDER:
//			go_ladder_state();
//          break;
//			
//		case WALKING_ANIMWAIT:
//			go_anim_wait_state (   );
//			break;
//	}
	
	// the there's no curb to adjust due to, lerp down to zero
//	if (!m_curb_float_height_adjusted)
//	{
//		m_curb_float_height = Mth::Lerp(m_curb_float_height, 0.0f, s_get_param(Crc::ConstCRC("curb_float_lerp_down_rate")) * m_frame_length);
//	}
	
	// adjust back to our curb float Y position
//	m_pos[Y] += m_curb_float_height;
	
	// scripts may have restarted us / switched us to skating
//	if (should_bail_from_frame()) return;
	
	// keep the object from falling through holes in the geometry
//	if (m_state == WALKING_GROUND || m_state == WALKING_AIR)
//	{
//		uber_frig();
//	}
	
	// rotate to upright
//	lerp_upright();
	
	// setup the object based on this frame's walking
//	copy_state_into_object();
	
//	Dbg_Assert(m_frame_event);
//	GetObj()->SelfEvent(m_frame_event);
	
	// set the animation speeds
//	switch (m_anim_scale_speed)
//	{
//		case RUNNING:
//			if (m_anim_standard_speed > 0.0f)
//			{
//				mp_animation_component->SetAnimSpeed(m_anim_effective_speed / m_anim_standard_speed, false, false);
//			}
//			break;
//			
//		case HANGMOVE:
//			mp_animation_component->SetAnimSpeed(m_anim_effective_speed / s_get_param(Crc::ConstCRC("hang_move_speed")), false, false);
//			break;
//					
//		case LADDERMOVE:
//			mp_animation_component->SetAnimSpeed(m_anim_effective_speed / s_get_param(Crc::ConstCRC( "ladder_move_speed")), false, false);
//			break;
//	
//		default:
//			break;
//	}
	
	// camera controls
	// NOTE: script parameters
//	switch (m_frame_event)
//	{
//		case Crc::ConstCRC("Hop"):
//			mp_camera_component->SetOverrides(m_facing, 0.05f);
//			break;
//		
//		case Crc::ConstCRC("HangMoveLeft"):
//		{
//			Mth::Vector facing = m_facing;
//			facing.RotateY(-0.95f);
//			mp_camera_component->SetOverrides(facing, 0.05f);
//			break;
//		}
//			
//		case Crc::ConstCRC("HangMoveRight"):
//		{
//			Mth::Vector facing = m_facing;
//			facing.RotateY(0.95f);
//			mp_camera_component->SetOverrides(facing, 0.05f);
//			break;
//		}
//					
//		case Crc::ConstCRC("Hang"):
//			mp_camera_component->SetOverrides(m_facing, 0.05f);
//			break;
//		
//		case Crc::ConstCRC("Ladder"):
//		case Crc::ConstCRC("LadderMoveUp"):
//		case Crc::ConstCRC("LadderMoveDown"):
//			mp_camera_component->SetOverrides(m_facing, 0.05f);
//			break;
//					
//		case Crc::ConstCRC("AnimWait"):
//			if (m_anim_wait_camera_mode == AWC_CURRENT)
//			{
//				mp_camera_component->SetOverrides(m_facing, 0.05f);
//			}
//			else
//			{
//				mp_camera_component->SetOverrides(m_drift_goal_facing, 0.05f);
//			}
//			break;
//	
//		default:
//			mp_camera_component->UnsetOverrides();
//			break;
//	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CBaseComponent::EMemberFunctionResult CRiderComponent::CallMemberFunction( uint32 Checksum, Script::CStruct* pParams, Script::CScript* pScript )
{
	switch ( Checksum )
	{
#		if 0
		// @script | Rider_Ground |
		case Crc::ConstCRC("Rider_Ground"):
			return m_state == WALKING_GROUND ? CBaseComponent::MF_TRUE : CBaseComponent::MF_FALSE;
			
		// @script | Rider_Air |
		case Crc::ConstCRC("Rider_Air"):
			return m_state == WALKING_AIR ? CBaseComponent::MF_TRUE : CBaseComponent::MF_FALSE;
			
		// @script | Rider_Hang |
		case Crc::ConstCRC("Rider_Hang"):
			return m_state == WALKING_HANG ? CBaseComponent::MF_TRUE : CBaseComponent::MF_FALSE;
			
		// @script | Rider_Ladder |
		case Crc::ConstCRC("Rider_Ladder"):
			return m_state == WALKING_LADDER ? CBaseComponent::MF_TRUE : CBaseComponent::MF_FALSE;
			
		// @script | Rider_GetStateTime | Loads the time in milliseconds since last state change.
		case Crc::ConstCRC("Rider_GetStateTime"):
			pScript->GetParams()->AddInteger(Crc::ConstCRC("StateTime"), Tmr::ElapsedTime(m_state_timestamp));
			break;
		
		// @script | Rider_Jump |
		case Crc::ConstCRC("Rider_Jump"):
		{
			// jump strength scales with the length the jump button has been held
			jump(Mth::Lerp(
				s_get_param(Crc::ConstCRC("min_jump_factor")), 
				1.0f,
				Mth::ClampMax(mp_input_component->GetControlPad().m_x.GetPressedTime() / s_get_param(Crc::ConstCRC("hold_time_for_max_jump")), 1.0f)
			));
			break;
		}
		
		case Crc::ConstCRC("Rider_HangJump"):
		{
			// jump strength scales with the length the jump button has been held
			jump(s_get_param(Crc::ConstCRC("hang_jump_factor")), true);
			break;
		}
		
		// @script | Rider_SetDragFactor |
		case Crc::ConstCRC("Rider_SetDragFactor"):
			pParams->GetFloat(NO_NAME, &m_script_drag_factor);
			break;
			
		case Crc::ConstCRC("Rider_ResetDragFactor"):
			m_script_drag_factor = 1.0f;
			break;
			
		case Crc::ConstCRC("Rider_GetSpeedScale"):
		{
			uint32 checksum;
			if (m_anim_effective_speed < s_get_param(Crc::ConstCRC("max_slow_walk_speed")))
			{
				checksum = Crc::ConstCRC("WALK_SLOW");
			}
			else if (m_anim_effective_speed < s_get_param(Crc::ConstCRC("max_fast_walk_speed")))
			{
				checksum = Crc::ConstCRC( "WALK_FAST");
			}
			else if (m_anim_effective_speed < s_get_param(Crc::ConstCRC("max_slow_run_speed")))
			{
				checksum = Crc::ConstCRC("RUN_SLOW");
			}
			else
			{
				checksum = Crc::ConstCRC("RUN_FAST");
			}
			pScript->GetParams()->AddChecksum(Crc::ConstCRC( "SpeedScale"), checksum);
			
			break;
		}
		
		// @script | Rider_ScaleAnimSpeed | Sets the manner in which the walk animations speeds should be scaled.
		// @flag Off | No animation speed scaling.
		// @flag Run | Scale animation speeds against running speed.
		// @flag Rider | Scale animation speeds against walking speed.
		case Crc::ConstCRC("Rider_ScaleAnimSpeed"):
			if (pParams->ContainsFlag(Crc::ConstCRC("Off")))
			{
				if (m_anim_scale_speed != OFF)
				{
					m_anim_scale_speed = OFF;
					mp_animation_component->SetAnimSpeed(1.0f, false, true);
				}
			}
			else if (pParams->ContainsFlag(Crc::ConstCRC("Run")))
			{
				m_anim_scale_speed = RUNNING;
			}
			else if (pParams->ContainsFlag(Crc::ConstCRC("HangMove")))
			{
				m_anim_scale_speed = HANGMOVE;
			}
			else if (pParams->ContainsFlag(Crc::ConstCRC("LadderMove")))
			{
				m_anim_scale_speed = LADDERMOVE;
			}
			else
			{
				Dbg_MsgAssert(false, ("Rider_ScaleAnimSpeed requires Off, Run, or Rider flag"));
			}
			
			pParams->GetFloat(Crc::ConstCRC("StandardSpeed"), &m_anim_standard_speed);
			break;
			
		// @script | Rider_AnimWaitComplete | Signal from script that the walk component should leave its animation wait
		case Crc::ConstCRC("Rider_AnimWaitComplete"):
			anim_wait_complete();
			break;
				   			
		// @script | Rider_GetHangInitAnimType | Determine which type of initial hang animation should be played
		case Crc::ConstCRC("Rider_GetHangInitAnimType"):
			// m_initial_hang_animation is set when the hang rail is filtered
			pScript->GetParams()->AddChecksum(Crc::ConstCRC("HangInitAnimType"), m_initial_hang_animation);
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
void CRiderComponent::GetDebugInfo(Script::CStruct *p_info)
{
	Dbg_MsgAssert(p_info,("nullptr p_info sent to CRiderComponent::GetDebugInfo"));
	
	switch (m_state)
	{
		case WALKING_GROUND:
			p_info->AddChecksum(Crc::ConstCRC("m_state"), Crc::ConstCRC("GROUND"));
			break;
		case WALKING_AIR:
			p_info->AddChecksum(Crc::ConstCRC("m_state"), Crc::ConstCRC("AIR"));
			break;
		case WALKING_HOP:
			p_info->AddChecksum(Crc::ConstCRC("m_state"), Crc::ConstCRC("HOP"));
			break;										 
		case WALKING_HANG:
			p_info->AddChecksum(Crc::ConstCRC("m_state"), Crc::ConstCRC("HANG"));
			break;										 
        case WALKING_LADDER:
			p_info->AddChecksum(Crc::ConstCRC("m_state"), Crc::ConstCRC("LADDER"));
			break;										 
        case WALKING_ANIMWAIT:
			p_info->AddChecksum(Crc::ConstCRC("m_state"), Crc::ConstCRC("ANIMWAIT"));
			break;										 
	}

	CBaseComponent::GetDebugInfo(p_info);	  
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CRiderComponent::SetAssociatedCamera( CCompositeObject* camera_obj )
{
//	mp_camera = camera_obj;
//	Dbg_Assert(mp_camera);
//	mp_camera_component = GetWalkCameraComponentFromObject(mp_camera);
//	Dbg_MsgAssert(mp_camera_component, ("No RiderCameraComponent in camera object"));
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool CRiderComponent::ReadyRiderState( bool to_ground_state )
{
	// setup the state in preparation for being in walking mode next object update
	MARK;
	
	// Firstly ensure that there is a valid horse nearby.
	mp_horse_component						= nullptr;

	Obj::CHorseComponent* p_horse_component = static_cast<Obj::CHorseComponent*>( Obj::CCompositeObjectManager::Instance()->GetFirstComponentByType( CRC_HORSE ));
	while( p_horse_component )
	{
		Obj::CCompositeObject*	p_horse		= p_horse_component->GetObj();
		Mth::Vector				horse_pos	= p_horse->GetPos();
		float					dist		= Mth::Distance( GetObj()->GetPos(), horse_pos );
		if( dist < 60.0f )
		{
			mp_horse_component				= p_horse_component;
			break;
		}
		p_horse_component					= static_cast<Obj::CHorseComponent*>( p_horse_component->GetNextSameType());
	}

	if( mp_horse_component == nullptr )
	{
		// Don't want to proceed.
		return false;

	}
	
	printf( "ReadyRiderState() found horse\n" );

	mp_horse_component->AcceptRiderMount( GetObj());

	// always reset the state timestamp
    m_state_timestamp = Tmr::GetTime();

	if (to_ground_state)
	{
		set_state(WALKING_GROUND);
		
		// will be incorrect for one frame
		m_ground_normal.Set(0.0f, 1.0f, 0.0);
		
		m_last_ground_feeler_valid = false;
		
		GetObj()->GetVel()[Y] = 0.0f;
	}
	else
	{
		set_state(WALKING_AIR);
		
		// set primary air direction in the direction of velocity
		m_primary_air_direction = GetObj()->GetVel();
		m_primary_air_direction[Y] = 0.0f;
		float length = m_primary_air_direction.Length();
		if (length < 0.001f)
		{
			// or facing
			m_primary_air_direction = GetObj()->GetMatrix()[Z];
			m_primary_air_direction[Y] = 0.0f;
			length = m_primary_air_direction.Length();
			if (length < 0.001f)
			{
				// or future facing
				m_primary_air_direction = -GetObj()->GetMatrix()[Y];
				m_primary_air_direction[Y] = 0.0f;
				length = m_primary_air_direction.Length();
			}
		}
		m_primary_air_direction /= length;
		
//		leave_movable_contact_for_air(GetObj()->GetVel(), GetObj()->GetVel()[Y]);
	}

	m_curb_float_height = 0.0f;
	
	m_last_frame_event = 0;

	return true;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CRiderComponent::go_on_horse_state( void )
{
	Mth::Vector pos;
	Mth::Matrix	mat, display_mat;

	pos			= mp_horse_component->GetPos();
	mat			= mp_horse_component->GetMatrix();
	display_mat	= mp_horse_component->GetDisplayMatrix();

	GetObj()->SetPos( pos );
	GetObj()->SetMatrix( mat );
	GetObj()->SetDisplayMatrix( display_mat );

	// Check for trying to dismount a horse, triggered on triangle.
	if( mp_input_component->GetControlPad().m_triangle.GetTriggered())
	{
		mp_input_component->GetControlPad().m_triangle.ClearTrigger();

		// Get the control component.
		CSkaterPhysicsControlComponent*	p_control_component = GetSkaterPhysicsControlComponentFromObject( GetObj());
		p_control_component->CallMemberFunction( Crc::ConstCRC( "SkaterPhysicsControl_SwitchRidingToWalking"), nullptr, nullptr );

		mp_horse_component->AcceptRiderDismount( GetObj());

		m_frame_event = Crc::ConstCRC( "Stand" );
		GetObj()->SelfEvent( m_frame_event );
		return;
	}

	CAnimationComponent*	p_anim_component	= GetAnimationComponentFromObject( GetObj());

	Script::CStruct* p_temp_struct = new Script::CStruct();

	// Decide which animation to play.
	switch( mp_horse_component->GetAnimation())
	{
		case Crc::ConstCRC("Horse_Jump"):
		{
			p_temp_struct->AddChecksum( Crc::ConstCRC("Anim"), Crc::ConstCRC("Rider_Jump"));
			p_temp_struct->AddChecksum( (uint32)0, 0xfe09fe09/*"NoRestart"*/);
			p_anim_component->PlayAnim( p_temp_struct, nullptr, 0.3f );
			break;
		}
		case Crc::ConstCRC( "Horse_Airidle" ):
		{
			p_temp_struct->AddChecksum( Crc::ConstCRC("Anim"), Crc::ConstCRC("Rider_Airidle"));
			p_temp_struct->AddChecksum( (uint32)0, 0xfe09fe09/*"NoRestart"*/);
			p_temp_struct->AddChecksum( (uint32)0, 0x4f792e6c/*"Cycle"*/);
			p_anim_component->PlayAnim( p_temp_struct, nullptr, 0.3f );
			break;
		}
		case Crc::ConstCRC( "Horse_Land" ):
		{
			p_temp_struct->AddChecksum( Crc::ConstCRC("Anim"), Crc::ConstCRC("Rider_Land"));
			p_temp_struct->AddChecksum( (uint32)0, 0xfe09fe09/*"NoRestart"*/);
			p_anim_component->PlayAnim( p_temp_struct, nullptr, 0.3f );
			break;
		}
		case Crc::ConstCRC("Horse_Walk"):
		{
			p_temp_struct->AddChecksum( Crc::ConstCRC("Anim"), Crc::ConstCRC("Rider_Walk"));
			p_temp_struct->AddChecksum( (uint32)0, 0xfe09fe09/*"NoRestart"*/);
			p_temp_struct->AddChecksum( (uint32)0, 0x4f792e6c/*"Cycle"*/);
			p_anim_component->PlayAnim( p_temp_struct, nullptr, 0.3f );
			break;
		}
		case Crc::ConstCRC("Horse_Trot"):
		{
			p_temp_struct->AddChecksum( Crc::ConstCRC("Anim"), Crc::ConstCRC("Rider_Trot"));
			p_temp_struct->AddChecksum( (uint32)0, 0xfe09fe09/*"NoRestart"*/);
			p_temp_struct->AddChecksum( (uint32)0, 0x4f792e6c/*"Cycle"*/);
			p_anim_component->PlayAnim( p_temp_struct, nullptr, 0.3f );
			break;
		}
		case Crc::ConstCRC("Horse_Canter"):
		{
			p_temp_struct->AddChecksum( Crc::ConstCRC("Anim"), Crc::ConstCRC("Rider_Canter"));
			p_temp_struct->AddChecksum( (uint32)0, 0xfe09fe09/*"NoRestart"*/);
			p_temp_struct->AddChecksum( (uint32)0, 0x4f792e6c/*"Cycle"*/);
			p_anim_component->PlayAnim( p_temp_struct, nullptr, 0.3f );
			break;
		}
		case Crc::ConstCRC("Horse_Gallop"):
		{
			p_temp_struct->AddChecksum( Crc::ConstCRC("Anim"), Crc::ConstCRC("Rider_Gallop"));
			p_temp_struct->AddChecksum( (uint32)0, 0xfe09fe09/*"NoRestart"*/);
			p_temp_struct->AddChecksum( (uint32)0, 0x4f792e6c/*"Cycle"*/);
			p_anim_component->PlayAnim( p_temp_struct, nullptr, 0.3f );
			break;
		}
		case Crc::ConstCRC("Horse_StandIdle"):
		default:
		{
			p_temp_struct->AddChecksum( Crc::ConstCRC("Anim"), Crc::ConstCRC("Rider_StandIdle"));
			p_temp_struct->AddChecksum( (uint32)0, 0xfe09fe09/*"NoRestart"*/);
			p_temp_struct->AddChecksum( (uint32)0, 0x4f792e6c/*"Cycle"*/);
			p_anim_component->PlayAnim( p_temp_struct, nullptr, 0.3f );
			break;
		}
	}

	delete p_temp_struct;
}








/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CRiderComponent::go_on_ground_state (   )
{
#	if 0

	account_for_movable_contact();
	
	setup_collision_cache();
	
	// calculate initial horizontal speed
	float horizontal_speed = m_horizontal_vel.Length();
	
	calculate_horizontal_speed_and_facing(horizontal_speed);
	
	// calculate this frame's movement
	m_horizontal_vel = horizontal_speed * m_facing;
	
	// prevent movement into walls
	if (adjust_horizonal_vel_for_environment(true))
	{
		// turn to face newly adjusted velocity
		adjust_facing_for_adjusted_horizontal_vel();
	}
	
	// if we are wall pushing, we may have decided to switch states during adjust_horizonal_vel_for_environment based on our environment
	if (m_state != WALKING_GROUND || should_bail_from_frame())
	{
		CFeeler::sClearDefaultCache();
		return;
	}
	
	// apply movement for this frame
	m_pos += m_horizontal_vel * m_frame_length;
	
	// snap up and down curbs and perhaps switch to air
	respond_to_ground();
	if (m_state != WALKING_GROUND || should_bail_from_frame())
	{
		CFeeler::sClearDefaultCache();
		return;
	}
	
	adjust_curb_float_height();
	
	// insure that we do not slip through the cracks in the collision geometry which are a side-effect of moving collidable objects
	if (CCompositeObject* p_inside_object = mp_movable_contact_component->CheckInsideObjects(m_pos, m_frame_start_pos))
	{
		MESSAGE("WALKING_GROUND, within moving object");
		
		// allow it to push us forward, causing a bit of a stumble
		m_horizontal_vel = p_inside_object->GetVel();
		m_horizontal_vel[Y] = 0.0f;
		m_vertical_vel = 0.0f;
		
		float speed_sqr = m_horizontal_vel.LengthSqr();
		if (speed_sqr > (10.0f * 10.0f))
		{
			m_facing = m_horizontal_vel * (1.0f / sqrtf(speed_sqr));
		}
	}
	
	CFeeler::sClearDefaultCache();
#	endif
}


}

