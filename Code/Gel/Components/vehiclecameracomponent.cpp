//****************************************************************************
//* MODULE:         Gel/Components
//* FILENAME:       VehicleCameraComponent.cpp
//* OWNER:          Dan
//* CREATION DATE:  2/10/3
//****************************************************************************

#include <Core/Defines.h>
#include <Core/math.h>
									 
#include <Gel/Components/vehiclecameracomponent.h>
#include <Gel/Components/vehiclecomponent.h>
#include <Gel/Components/CameraComponent.h>
#include <Gel/Components/CameraLookAroundComponent.h>
#include <Gel/Components/CameraUtil.h>

#include <Gel/Object/compositeobject.h>
#include <Gel/Object/compositeobjectmanager.h>
#include <Gel/Scripting/checksum.h>
#include <Gel/Scripting/script.h>
#include <Gel/Scripting/struct.h>

#define MESSAGE(a) { printf("M:%s:%i: %s\n", __FILE__ + 15, __LINE__, a); }
#define DUMPI(a) { printf("D:%s:%i: " #a " = %i\n", __FILE__ + 15, __LINE__, a); }
#define DUMPB(a) { printf("D:%s:%i: " #a " = %s\n", __FILE__ + 15, __LINE__, a ? "true" : "false"); }
#define DUMPF(a) { printf("D:%s:%i: " #a " = %g\n", __FILE__ + 15, __LINE__, a); }
#define DUMPE(a) { printf("D:%s:%i: " #a " = %e\n", __FILE__ + 15, __LINE__, a); }
#define DUMPS(a) { printf("D:%s:%i: " #a " = %s\n", __FILE__ + 15, __LINE__, a); }
#define DUMPP(a) { printf("D:%s:%i: " #a " = %p\n", __FILE__ + 15, __LINE__, a); }
#define DUMPV(a) { printf("D:%s:%i: " #a " = %g, %g, %g\n", __FILE__ + 15, __LINE__, (a)[X], (a)[Y], (a)[Z]); }
#define DUMP4(a) { printf("D:%s:%i: " #a " = %g, %g, %g, %g\n", __FILE__ + 15, __LINE__, (a)[X], (a)[Y], (a)[Z], (a)[W]); }
#define DUMPM(a) { DUMP4(a[X]); DUMP4(a[Y]); DUMP4(a[Z]); DUMP4(a[W]); }
#define MARK { printf("K:%s:%i: %s\n", __FILE__ + 15, __LINE__, __PRETTY_FUNCTION__); }
#define PERIODIC(n) for (static int p__ = 0; (p__ = ++p__ % (n)) == 0; )

#define vVELOCITY_WEIGHT_DROP_THRESHOLD				MPH_TO_IPS(15.0f)
#define vLOCK_ATTRACTOR_VELOCITY_THRESHOLD			MPH_TO_IPS(5000000.0f)
#define vSTATE_CHANGE_DELAY (1.0f)

namespace Obj
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
CBaseComponent* CVehicleCameraComponent::s_create()
{
	return static_cast< CBaseComponent* >( new CVehicleCameraComponent );	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CVehicleCameraComponent::CVehicleCameraComponent() : CBaseComponent()
{
	SetType( CRC_VEHICLECAMERA );
	
	m_offset_height = FEET(5.0f);
	m_offset_distance = FEET(12.0f);
	
	m_alignment_rate = 3.0f;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
CVehicleCameraComponent::~CVehicleCameraComponent()
{
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CVehicleCameraComponent::InitFromStructure( Script::CStruct* pParams )
{
	uint32 subject_id;
	
	if (pParams->ContainsComponentNamed(Crc::ConstCRC( "subject")))
	{
		pParams->GetChecksum(Crc::ConstCRC( "subject"), &subject_id, Script::ASSERT);
		mp_subject = static_cast< CCompositeObject* >(CCompositeObjectManager::Instance()->GetObjectByID(subject_id));
		Dbg_MsgAssert(mp_subject, ("Vehicle camera given subject which is not a composite object"));
		mp_subject_vehicle_component = static_cast< CVehicleComponent* >(mp_subject->GetComponent(CRC_VEHICLE));
		Dbg_MsgAssert(mp_subject_vehicle_component, ("Vehicle camera given subject which contains no vehicle component"));
	}
		
	pParams->GetFloat(Crc::ConstCRC("alignment_rate"), &m_alignment_rate);
	
	pParams->GetFloat(Crc::ConstCRC("offset_height"), &m_offset_height);
	
	pParams->GetFloat(Crc::ConstCRC("offset_distance"), &m_offset_distance);
	
	pParams->GetFloat(Crc::ConstCRC("angle"), &m_angle);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CVehicleCameraComponent::RefreshFromStructure( Script::CStruct* pParams )
{
	InitFromStructure(pParams);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CVehicleCameraComponent::Finalize (   )
{
	mp_camera_lookaround_component = GetCameraLookAroundComponentFromObject(GetObj());
	
	Dbg_Assert(mp_camera_lookaround_component);
	
	reset_camera();
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CVehicleCameraComponent::Update()
{
	// NOTE: plenty of room for optimiziation
	
	GetCameraComponentFromObject(GetObj())->StoreOldPosition();
	
	calculate_attractor_direction();
	
	// Due to rounding errors this can sometimes be > |1|, which hoses acosf(), so limit here.
	float angular_distance = acosf(Mth::Clamp(Mth::DotProduct(m_direction, m_attractor_direction), -1.0f, 1.0f));
	if (angular_distance > Mth::PI / 2.0f)
	{
		angular_distance = Mth::PI - angular_distance;
	}
	
	bool sign = Mth::CrossProduct(m_direction, m_attractor_direction)[Y] > 0.0f;
	
	float step = m_alignment_rate * angular_distance * Tmr::FrameLength();
	
	if (step > angular_distance)
	{
		step = angular_distance;
	}
	
	m_direction.RotateY((sign ? 1.0f : -1.0f) * step);
	m_direction.Normalize();
	
	calculate_dependent_variables();
	
	ApplyCameraCollisionDetection(
		m_pos, 
		m_orientation_matrix, 
		m_pos - m_offset_distance * m_orientation_matrix[Z], 
		m_pos - m_offset_distance * m_orientation_matrix[Z], 
		false, 
		false
	);
	
	apply_state();
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CBaseComponent::EMemberFunctionResult CVehicleCameraComponent::CallMemberFunction( uint32 Checksum, Script::CStruct* pParams, Script::CScript* pScript )
{
	(void)pScript;

	switch ( Checksum )
	{
		case Crc::ConstCRC( "VehicleCamera_Reset"):
			RefreshFromStructure(pParams);
			Finalize();
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

void CVehicleCameraComponent::GetDebugInfo(Script::CStruct *p_info)
{
#ifdef	__DEBUG_CODE__
	Dbg_MsgAssert(p_info,("nullptr p_info sent to C......Component::GetDebugInfo"));
	
	p_info->AddChecksum("mp_subject", mp_subject->GetID());

	CBaseComponent::GetDebugInfo(p_info);	  
#endif				 
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CVehicleCameraComponent::reset_camera (   )
{
	mp_camera_lookaround_component->mLookaroundHeading = 0.0f;
	mp_camera_lookaround_component->mLookaroundTilt = 0.0f;
	mp_camera_lookaround_component->mLookaroundLock = false;
	
	m_attractor_direction = -mp_subject->GetMatrix()[Z];
	m_attractor_direction[Y] = 0.0f;
	m_attractor_direction.Normalize();
	
	calculate_attractor_direction();
	
	m_direction = m_attractor_direction;
	
	calculate_dependent_variables();
	
	apply_state();
	
	GetCameraComponentFromObject(GetObj())->Update();
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CVehicleCameraComponent::calculate_attractor_direction (   )
{
	Mth::Vector vel_direction = -mp_subject_vehicle_component->GetVel();
	vel_direction[Y] = 0.0f;
	float vel = vel_direction.Length();
	vel_direction.Normalize();
	
	if (mp_subject_vehicle_component->GetNumWheelsInContact() < 2)
	{
		// if vel under certain threshold, we lock the attractor
		if (vel < vLOCK_ATTRACTOR_VELOCITY_THRESHOLD)
		{
			return;
		}
		
		m_attractor_direction = vel_direction;
	}
	else
	{
		float vel_weight = Mth::ClampMax(vel / vVELOCITY_WEIGHT_DROP_THRESHOLD, 1.0f) * Mth::DotProduct(vel_direction, -mp_subject->GetMatrix()[Z]);
		
		m_attractor_direction = -mp_subject->GetMatrix()[Z];
		m_attractor_direction[Y] = 0.0f;
		m_attractor_direction.Normalize();
		
		if (vel_weight > 0.0f)
		{
			m_attractor_direction += vel_weight * vel_direction;
			m_attractor_direction.Normalize();
		}
		
		// NOTE: potential bug if car is pointing straight down
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CVehicleCameraComponent::calculate_dependent_variables (   )
{
	Mth::Vector frame_direction = m_direction;
	frame_direction.RotateY(mp_camera_lookaround_component->mLookaroundHeading);
	
	m_orientation_matrix[X].Set(frame_direction[Z], 0.0f, -frame_direction[X]);
	m_orientation_matrix[Y].Set(0.0f, 1.0f, 0.0f);
	m_orientation_matrix[Z] = frame_direction;
	m_orientation_matrix[W].Set();
	
	m_pos = mp_subject->GetPos() + Mth::Vector(m_offset_distance * frame_direction[X], m_offset_height, m_offset_distance * frame_direction[Z]);
	
	m_orientation_matrix.RotateZLocal(DEGREES_TO_RADIANS(m_angle));
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CVehicleCameraComponent::apply_state (   )
{
	m_pos[W] = 1.0f;
	m_orientation_matrix[X][W] = 0.0f;
	m_orientation_matrix[Y][W] = 0.0f;
	m_orientation_matrix[Z][W] = 0.0f;
	
	GetObj()->SetPos(m_pos);
	GetObj()->SetMatrix(m_orientation_matrix);
	GetObj()->SetDisplayMatrix(m_orientation_matrix);
}

}
