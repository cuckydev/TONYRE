//****************************************************************************
//* MODULE:         Gel/Components
//* FILENAME:       WalkCameraComponent.cpp
//* OWNER:          Dan
//* CREATION DATE:  4/9/3
//****************************************************************************

#ifdef TESTING_GUNSLINGER

// Replace the entire contents of this file with the new file.
#include <Gel/Components/gunslingerwalkcameracomponent.cpp>

#else

#include <Gel/Components/WalkCameraComponent.h>
#include <Core/Math/slerp.h>
#include <Gel/Object/compositeobject.h>
#include <Gel/Object/compositeobjectmanager.h>
#include <Gel/Components/WalkComponent.h>
#include <Gel/Components/CameraUtil.h>
#include <Gel/Components/CameraLookAroundComponent.h>
#include <Gel/Components/CameraComponent.h>
#include <Sk/Components/SkaterPhysicsControlComponent.h>
#include <Gel/Components/SkaterCameraComponent.h>
#include <Gel/Scripting/checksum.h>
#include <Gel/Scripting/script.h>
#include <Gel/Scripting/struct.h>
#include <Gfx/debuggfx.h>

namespace Obj
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
CBaseComponent* CWalkCameraComponent::s_create()
{
	return static_cast< CBaseComponent* >( new CWalkCameraComponent );	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CWalkCameraComponent::CWalkCameraComponent() : CBaseComponent()
{
	SetType( CRC_WALKCAMERA );
	m_last_tripod_pos.Set();
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
CWalkCameraComponent::~CWalkCameraComponent()
{
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CWalkCameraComponent::InitFromStructure( Script::CStruct* pParams )
{
	uint32 target_id = 0 ;
	pParams->GetChecksum("CameraTarget", &target_id, Script::ASSERT);
	
	CCompositeObject* p_target = static_cast< CCompositeObject* >(CCompositeObjectManager::Instance()->GetObjectByID(target_id));
	Dbg_MsgAssert(p_target, ("Bad CameraTarget given to WalkCameraComponent"));
		
	set_target(p_target);
	
	m_last_dot = 1.0f;
	m_current_zoom = 1.0f;
	
	m_last_actual_matrix = GetObj()->GetMatrix();
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CWalkCameraComponent::RefreshFromStructure( Script::CStruct* pParams )
{
	InitFromStructure(pParams);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CWalkCameraComponent::Finalize()
{
	mp_lookaround_component = GetCameraLookAroundComponentFromObject(GetObj());
	mp_camera_component = GetCameraComponentFromObject(GetObj());
	mp_skater_camera_component = GetSkaterCameraComponentFromObject(GetObj());
	
	Dbg_Assert(mp_lookaround_component);
	Dbg_Assert(mp_camera_component);
	Dbg_Assert(mp_skater_camera_component);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CWalkCameraComponent::Update()
{
	if (!mp_target) return;
	
	// optimization KLUDGE
	if (mp_target_physics_control_component && mp_target_physics_control_component->IsDriving())
	{
		GetObj()->Pause(true);
		return;
	}
	
	if (mp_target->HasTeleported())
	{
		m_instant_count = 3;
	}

	bool instantly;
	if (m_instant_count > 0)
	{
		--m_instant_count;
		instantly = true;
	}
	else if (m_reset)
	{
		instantly = true;
	}
	else
	{
		instantly = false;
	}
	
	mp_camera_component->StoreOldPosition();

	float frame_length = Tmr::FrameLength();
	
	// get input
	float horiz_control = GetInputComponentFromObject(GetObj())->GetControlPad().m_scaled_rightX;

	// restore camera position from last frame, previous to refocusing and collision detection
	GetObj()->GetMatrix() = m_last_actual_matrix;

	Mth::Vector	target_facing = -GetObj()->GetMatrix()[Z];
	target_facing[Y] = 0.0f;
	target_facing.Normalize();
	
	Mth::Vector subject_facing = mp_target->GetMatrix()[Z];
	subject_facing[Y] = 0.0f;
	subject_facing.Normalize();
	
	// two options; we either use our old facing as the target facing or use the subject's facing as the target facing
	bool use_subject_facing = true;
	
	// if in a flush request
	if (m_flush_request_active)
	{
		// always use the subject's matrix
	}
	// if controlling camera
	else if (horiz_control != 0.0f)
	{
		use_subject_facing = false;
	}
	// if the subject's facing is towards the camera
	else if (Mth::DotProduct(target_facing, subject_facing) < cosf(Mth::DegToRad(s_get_param(Crc::ConstCRC("lock_angle")))))
	{
		use_subject_facing = false;
	}
	// if the subject is moving very slowly
	else // if (!mp_target_walk_component->UseDPadCamera())
	{
		float full_slerp_speed;
		float min_slerp_speed;
		if (!mp_target_walk_component->UseDPadCamera())
		{
			full_slerp_speed = s_get_param(Crc::ConstCRC("full_slerp_speed"));
			min_slerp_speed = s_get_param(Crc::ConstCRC("min_slerp_speed"));
		}
		else
		{
			full_slerp_speed = s_get_param(Crc::ConstCRC("dpad_full_slerp_speed"));
			min_slerp_speed = s_get_param(Crc::ConstCRC( "dpad_min_slerp_speed"));
		}
		
		float target_vel = sqrtf(mp_target->GetVel()[X] * mp_target->GetVel()[X] + mp_target->GetVel()[Z] * mp_target->GetVel()[Z]);
		if (target_vel < full_slerp_speed)
		{
			use_subject_facing = false;
			
			// for a middle range of velocities, lerp to use of the subject's matrix
			if (target_vel > min_slerp_speed)
			{
				target_facing = Mth::LinearMap(
					target_facing,
					subject_facing,
					target_vel,
					min_slerp_speed,
					full_slerp_speed
				);
				target_facing.Normalize();
			}
		}
	}
	
	if (use_subject_facing || m_reset)
	{
		target_facing = subject_facing;
	}
	
	// control over target facing
	if (horiz_control != 0.0f && !m_flush_request_active)
	{
		target_facing.RotateY(s_get_param(Crc::ConstCRC("facing_control")) * horiz_control);
	}
	
	if (m_override_active)
	{
		target_facing = m_override_facing;
		target_facing.RotateY(mp_lookaround_component->mLookaroundHeading);
	}
	
	// build target matrix
	Mth::Matrix target_matrix;
	target_matrix[Z] = target_facing;
	target_matrix[Y].Set(0.0f, 1.0f, 0.0f);
	target_matrix[X].Set(target_facing[Z], 0.0f, -target_facing[X]);
	target_matrix[W].Set();
	
	// apply lookaround adjustments to the matrix
	target_matrix.RotateXLocal(mp_skater_camera_component->mTilt + mp_lookaround_component->mLookaroundTilt);
	
	target_matrix[X] = -target_matrix[X];
	target_matrix[Z] = -target_matrix[Z];
	
	// use later for camera position
	Mth::Vector up = mp_target->GetMatrix()[Y];
	
	if (!instantly)
	{
		if (Mth::DotProduct(target_matrix[X], GetObj()->GetMatrix()[X]) > CAMERA_SLERP_STOP
			&& Mth::DotProduct(target_matrix[Y], GetObj()->GetMatrix()[Y]) > CAMERA_SLERP_STOP
			&& Mth::DotProduct(target_matrix[Z], GetObj()->GetMatrix()[Z]) > CAMERA_SLERP_STOP)
		{
			// we're already at our target, so don't do anything
			
			// turn off any flush request
			if (m_flush_request_active)
			{
				m_flush_request_active = false;
				mp_target_walk_component->SetForwardControlLock(false);
			}
		}
		else
		{
			// slerp to the target matrix
			
			Mth::SlerpInterpolator slerper(&GetObj()->GetMatrix(), &target_matrix);
			
			// standard slerp rate
			float slerp = s_get_param(Crc::ConstCRC( "matrix_slerp_rate"));
			
			// running slerp rate adjustment
			if (mp_target_walk_component->IsRunning())
			{
				slerp *= s_get_param(Crc::ConstCRC("run_slerp_factor"));
			}
			
			// animation wait and ladder slerp rate adjustment
			// NOTE: replace with target facing override?
			if (mp_target_walk_component->GetState() == CWalkComponent::WALKING_ANIMWAIT || mp_target_walk_component->GetState() == CWalkComponent::WALKING_LADDER)
			{
				slerp *= 2.0f;
			}
			
			// if controlling the facing
			if (horiz_control != 0.0f && !m_flush_request_active)
			{
				slerp *= s_get_param(Crc::ConstCRC("control_slerp_factor")) * Mth::Abs(horiz_control);
			}
			
			// flush request slerp adjustment
			if (m_flush_request_active)
			{
				slerp *= s_get_param(Crc::ConstCRC("flush_slerp_factor"));
			}
			
			if (m_override_active)
			{
				// can't override flush speed
				if (m_flush_request_active)
				{
					slerp = s_get_param(Crc::ConstCRC( "matrix_slerp_rate")) * s_get_param(Crc::ConstCRC("flush_slerp_factor"));
				}
				else
				{
					slerp = m_override_slerp_rate;
				}
			}
			
			// apply the slerping
			slerper.getMatrix(&GetObj()->GetMatrix(), GetTimeAdjustedSlerp(slerp, frame_length));

			// calculate for the skater camera
			m_last_dot = Mth::DotProduct(m_last_actual_matrix[Z], GetObj()->GetMatrix()[Z]);
		}
	}
	else
	{
		GetObj()->GetMatrix() = target_matrix;
	}
	
	// At this point, GetObj()->GetMatrix() is valid to store.
	m_last_actual_matrix = GetObj()->GetMatrix();
	
	// Set camera position to be the same as the skater.
	Mth::Vector	camera_pos = get_tripod_pos(instantly);
	
	// Calculate zoom
	float above, behind;
	calculate_zoom(above, behind);
	
	camera_pos += GetObj()->GetMatrix()[Z] * behind + up * above;
	
	Mth::Vector	focus_pos = mp_target->GetPos() + up * above;
	
	// Focus the camera directly on the target object
	
	target_matrix[Z] = focus_pos - camera_pos;
	target_matrix[Z].Normalize();

	// Read back the Y from the current matrix.
	target_matrix[Y] = GetObj()->GetMatrix()[Y];

	// Generate new orthonormal X and Y axes.
	target_matrix[X] = Mth::CrossProduct(target_matrix[Y], target_matrix[Z]);
	target_matrix[X].Normalize();
	target_matrix[Y] = Mth::CrossProduct(target_matrix[Z], target_matrix[X]);
	target_matrix[Y].Normalize();

	// Write back into camera matrix.
	// Since camera points in -Z, but player in +Z, we must negate the X and Z axes
	GetObj()->GetMatrix()[X]	= -target_matrix[X];
	GetObj()->GetMatrix()[Y] = target_matrix[Y];
	GetObj()->GetMatrix()[Z] = -target_matrix[Z];
	
	// clean up matrix
	GetObj()->GetMatrix()[X][W] = 0.0f;
	GetObj()->GetMatrix()[Y][W] = 0.0f;
	GetObj()->GetMatrix()[Z][W] = 0.0f;
	GetObj()->GetMatrix()[W].Set(0.0f, 0.0f, 0.0f, 1.0f);
	
	// Now do collision detection.
	ApplyCameraCollisionDetection(
		camera_pos,
		GetObj()->GetMatrix(),
		camera_pos - GetObj()->GetMatrix()[Z] * behind + mp_target_walk_component->GetCameraCollisionTargetOffset(),
		focus_pos
	);
	
	#ifdef __USER_DAN__
	if (Script::GetInteger(Crc::ConstCRC("walking_debug_lines")))
	{
		Gfx::AddDebugStar(focus_pos, 24.0f, MAKE_RGB(255, 200, 0), 1);
	}
	#endif
	
	camera_pos[W] = 1.0f;
	GetObj()->SetPos(camera_pos);
	
	// reset old position if in instant update
	if (instantly)
	{
		mp_camera_component->StoreOldPosition();
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CBaseComponent::EMemberFunctionResult CWalkCameraComponent::CallMemberFunction( uint32 Checksum, Script::CStruct* pParams, Script::CScript* pScript )
{
	(void)pParams;
	(void)pScript;

	switch ( Checksum )
	{
		// @script | WalkCamera_FlushRequest | Force the camera to lerp quickly to behind the walker
		case Crc::ConstCRC("WalkCamera_FlushRequest"):
			FlushRequest();
			break;
			
		// @script | WalkCamera_Reset | Teleports the camera to behind the target
		case Crc::ConstCRC("WalkCamera_Reset"):
			Reset();
			break;
			
		default:
			return CBaseComponent::MF_NOT_EXECUTED;
	}
    return CBaseComponent::MF_TRUE;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CWalkCameraComponent::GetDebugInfo(Script::CStruct *p_info)
{
#ifdef	__DEBUG_CODE__
	Dbg_MsgAssert(p_info,("nullptr p_info sent to CWalkCameraComponent::GetDebugInfo"));

	CBaseComponent::GetDebugInfo(p_info);	  
#endif				 
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CWalkCameraComponent::ReadyForActivation ( const SCameraState& state )
{
	Dbg_MsgAssert(mp_target, ("Walk camera (%s) has nullptr target", Script::FindChecksumName(GetObj()->GetID())));
	
	m_last_tripod_pos = state.lastTripodPos;
	m_last_actual_matrix = state.lastActualMatrix;
	m_last_dot = state.lastDot;
	m_current_zoom = state.lastZoom;
	m_flush_request_active = false;
	mp_target_walk_component->SetForwardControlLock(false);
	m_instant_count = 0;
	
	mp_lookaround_component->mLookaroundHeading = 0.0f;
	mp_lookaround_component->mLookaroundLock = false;
	
	m_override_active = false;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CWalkCameraComponent::GetCameraState ( SCameraState& state )
{
	state.lastActualMatrix = m_last_actual_matrix;
	state.lastTripodPos = m_last_tripod_pos;
	state.lastDot = m_last_dot;
	state.lastZoom = m_current_zoom;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CWalkCameraComponent::FlushRequest (   )
{
	m_flush_request_active = true;
	mp_target_walk_component->SetForwardControlLock(true);
	
	// flush requests zero skater cam lookaround
	mp_lookaround_component->mLookaroundHeading = 0.0f;
	mp_lookaround_component->mLookaroundTilt = 0.0f;
	mp_lookaround_component->mLookaroundZoom = 1.0f;
	mp_lookaround_component->mLookaroundLock = false;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CWalkCameraComponent::Reset (   )
{
	m_reset = true;
	Update();
	m_reset = false;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CWalkCameraComponent::set_target ( CCompositeObject* p_target )
{
	if (p_target)
	{
		mp_target = p_target;
		
		mp_target_walk_component = GetWalkComponentFromObject(mp_target);
		Dbg_Assert(mp_target_walk_component);
		
		mp_target_physics_control_component = GetSkaterPhysicsControlComponentFromObject(mp_target);
		Dbg_Assert(mp_target_physics_control_component);
	}
	else
	{
		mp_target = nullptr;
		mp_target_walk_component = nullptr;
		mp_target_physics_control_component = nullptr;
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

Mth::Vector CWalkCameraComponent::get_tripod_pos( bool instantly )
{
	if (instantly)
	{
		m_last_tripod_pos = mp_target->GetPos();
	}
	else
	{
		float lerp_xz = GetTimeAdjustedSlerp(mp_skater_camera_component->mLerpXZ, Tmr::FrameLength());
		float lerp_y = GetTimeAdjustedSlerp(mp_skater_camera_component->mLerpY, Tmr::FrameLength());
		
		const Mth::Vector& target_pos = mp_target->GetPos();

		m_last_tripod_pos.Set(
			Mth::Lerp(m_last_tripod_pos[X], target_pos[X], lerp_xz),
			Mth::Lerp(m_last_tripod_pos[Y], target_pos[Y], lerp_y),
			Mth::Lerp(m_last_tripod_pos[Z], target_pos[Z], lerp_xz)
		);
	}

	return m_last_tripod_pos;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CWalkCameraComponent::calculate_zoom ( float& above, float& behind )
{
	float target_zoom = 1.0f;

	// If lookaround override is set, factor in the lookaround override zoom.
	if (mp_lookaround_component->mLookaroundOverride && mp_lookaround_component->mLookaroundZoom != 1.0f)
	{
		target_zoom *= mp_lookaround_component->mLookaroundZoom;
	}
	
	m_current_zoom += ((target_zoom - m_current_zoom) * mp_skater_camera_component->mZoomLerp);
	
	behind = mp_skater_camera_component->mBehind * m_current_zoom;

	// Behind is also shortened when the lookaround camera is tilting upwards.
	if (mp_lookaround_component->mLookaroundTilt < 0.0f)
	{
		float max_tilt = 3.14f * 0.2f;
		behind = behind * (0.4f + (0.6f * ((max_tilt + mp_lookaround_component->mLookaroundTilt) / max_tilt)));
	}

	// Use lip_trick_above when doing a lip trick.
	float above_val = mp_skater_camera_component->mAbove;
	
	// Figure above tending towards the perfect above, if zoom is < 1.0.
	if (m_current_zoom < 1.0f)
	{
		above = SKATERCAMERACOMPONENT_PERFECT_ABOVE + ((above_val - SKATERCAMERACOMPONENT_PERFECT_ABOVE) * m_current_zoom);
	}
	else
	{
		above = above_val;
	}
}

}

#endif // TESTING_GUNSLINGER
