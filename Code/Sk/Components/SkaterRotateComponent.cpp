//****************************************************************************
//* MODULE:         Sk/Components
//* FILENAME:       SkaterRotateComponent.cpp
//* OWNER:          Dan
//* CREATION DATE:  3/6/3
//****************************************************************************

#include <Sk/Components/SkaterRotateComponent.h>
#include <Sk/Components/SkaterCorePhysicsComponent.h>
#include <Sk/Scripting/nodearray.h>

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

CBaseComponent* CSkaterRotateComponent::s_create()
{
	return static_cast< CBaseComponent* >( new CSkaterRotateComponent );	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CSkaterRotateComponent::CSkaterRotateComponent() : CBaseComponent()
{
	SetType( CRC_SKATERROTATE );
	
	mp_core_physics_component = nullptr;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
CSkaterRotateComponent::~CSkaterRotateComponent()
{
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterRotateComponent::InitFromStructure( Script::CStruct* pParams )
{
	(void)pParams;
	for (int n = 3; n--; )
		mp_rotations[n].active = false;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterRotateComponent::RefreshFromStructure( Script::CStruct* pParams )
{
	InitFromStructure(pParams);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterRotateComponent::Finalize (   )
{
	mp_core_physics_component = GetSkaterCorePhysicsComponentFromObject(GetObj());
	
	Dbg_Assert(mp_core_physics_component);	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterRotateComponent::Update()
{
	Mth::Matrix rotation_matrix;
	
	for (int n = X; n < Z + 1; n++)
	{
		SRotation& rotation = mp_rotations[n];
		
		if (!rotation.active) continue;
		
		float amount = Tmr::FrameLength() * rotation.angle_step;
		
		rotation.angle_traversed += Mth::Abs(amount);
		
		if (rotation.angle_traversed >= rotation.angle)
		{
			rotation.active = false;
			amount -= Mth::Sgn(amount) * (rotation.angle_traversed - rotation.angle);
		}
		
		Mth::CreateRotateMatrix(rotation_matrix, n, amount);
		
		GetObj()->m_matrix = rotation_matrix * GetObj()->m_matrix;
		mp_core_physics_component->m_lerping_display_matrix = rotation_matrix * mp_core_physics_component->m_lerping_display_matrix;;
	}
	
	if (!mp_rotations[0].active && !mp_rotations[1].active && !mp_rotations[2].active)
	{
		Suspend(true);
	}
}		

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CBaseComponent::EMemberFunctionResult CSkaterRotateComponent::CallMemberFunction( uint32 Checksum, Script::CStruct* pParams, Script::CScript* pScript )
{
	(void)pScript;

	switch ( Checksum )
	{
        // @script | Rotate | 
        // @parmopt float | Duration | 0.0 | duration time (default is ms)
        // @flag seconds | time in seconds
        // @flag frames | time in frames
        // @parmopt float | x | 0.0 | x rotation angle
        // @parmopt float | y | 0.0 | y rotation angle
        // @parmopt float | z | 0.0 | z rotation angle
        // @parmopt name | Node | | Node to point to. Currently only supported if a duration is specified.
		case Crc::ConstCRC("Rotate"):
		{
			float duration;
			if (pParams->GetFloat(Crc::ConstCRC("Duration"), &duration))
			{
				Dbg_MsgAssert(duration > 0.0f, ("Zero or negative Rotate Duration"));
				
				if (pParams->ContainsFlag(Crc::ConstCRC("Seconds")) || pParams->ContainsFlag(Crc::ConstCRC("Second")))
				{
					// Seconds is what we want, so nothing to do
				}
				else if (pParams->ContainsFlag(Crc::ConstCRC( "Frames")) || pParams->ContainsFlag(Crc::ConstCRC("Frame")))
				{
					// Convert from frames to seconds
					duration /= 60.0f;
				}
				else
				{
					// Convert from milliseconds to seconds
					duration /= 1000.0f;
				}	

				if (pParams->GetFloat(Crc::ConstCRC("x"), &mp_rotations[X].angle))
				{
					mp_rotations[X].duration = duration;
					mp_rotations[X].angle_step = Mth::DegToRad(mp_rotations[X].angle / mp_rotations[X].duration);
					mp_rotations[X].angle = Mth::Abs(Mth::DegToRad(mp_rotations[X].angle));
					mp_rotations[X].angle_traversed = 0.0f;
					mp_rotations[X].active = true;
				}	
				if (pParams->GetFloat(Crc::ConstCRC( "y"), &mp_rotations[Y].angle))
				{
					mp_rotations[Y].duration = duration;
					mp_rotations[Y].angle_step = Mth::DegToRad(mp_rotations[Y].angle / mp_rotations[Y].duration);
					mp_rotations[Y].angle = Mth::Abs(Mth::DegToRad(mp_rotations[Y].angle));
					mp_rotations[Y].angle_traversed = 0.0f;
					mp_rotations[Y].active = true;
				}	
				if (pParams->GetFloat(Crc::ConstCRC("z"), &mp_rotations[Z].angle))
				{
					mp_rotations[Z].duration = duration;
					mp_rotations[Z].angle_step = Mth::DegToRad(mp_rotations[Z].angle / mp_rotations[Z].duration);
					mp_rotations[Z].angle = Mth::Abs(Mth::DegToRad(mp_rotations[Z].angle));
					mp_rotations[Z].angle_traversed = 0.0f;
					mp_rotations[Z].active = true;
				}	
				
				// If a node is specified, turn to point to it instead.
				// Added by Ken for use by Brad when making the skater turn around when he goes outside the level limits.
				uint32 node_name = 0;
				if (pParams->GetChecksum(Crc::ConstCRC("Node"), &node_name))
				{
					int node = SkateScript::FindNamedNode(node_name);
					Mth::Vector node_pos;
					SkateScript::GetPosition(node, &node_pos);
				
					mp_rotations[Y].angle = Mth::RadToDeg(Mth::GetAngle(GetObj()->m_matrix, node_pos - GetObj()->m_pos));
					
					mp_rotations[Y].duration = duration;
					mp_rotations[Y].angle_step = Mth::DegToRad(mp_rotations[Y].angle / mp_rotations[Y].duration);
					mp_rotations[Y].angle = Mth::Abs(Mth::DegToRad(mp_rotations[Y].angle));
					mp_rotations[Y].angle_traversed = 0.0f;
					mp_rotations[Y].active = true;
				}
				
				Suspend(false);
			} // END if duration specified
			else
			{
				// rotate immediately
				float angle;
				if (pParams->GetFloat(Crc::ConstCRC("x"), &angle))
				{
					GetObj()->m_matrix.RotateXLocal(Mth::DegToRad(angle));				
					mp_core_physics_component->ResetLerpingMatrix();
				}
				else if (pParams->GetFloat(Crc::ConstCRC( "y"), &angle))
				{
					GetObj()->m_matrix.RotateYLocal(Mth::DegToRad(angle));				
					mp_core_physics_component->ResetLerpingMatrix();
				}
				else if (pParams->GetFloat(Crc::ConstCRC("z"), &angle))
				{
					GetObj()->m_matrix.RotateZLocal(Mth::DegToRad(angle));
					mp_core_physics_component->ResetLerpingMatrix();
				}
				else
				{
					// if no parameters are given, rotate 180 degrees about Y
					GetObj()->m_matrix[Z].Negate();
					GetObj()->m_matrix[X].Negate();
					mp_core_physics_component->ResetLerpingMatrix();
					
					mp_core_physics_component->mRail_Backwards = !mp_core_physics_component->mRail_Backwards;
				}
			} // END else no Duration specified	
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

void CSkaterRotateComponent::GetDebugInfo(Script::CStruct *p_info)
{
#ifdef	__DEBUG_CODE__
	Dbg_MsgAssert(p_info,("nullptr p_info sent to CSkaterRotateComponent::GetDebugInfo"));
	
	Script::CArray* p_rotations_array = new Script::CArray;
	p_rotations_array->SetSizeAndType(3, ESYMBOLTYPE_STRUCTURE);
	for (int n = 3; n--; )
	{
		SRotation& rotation = mp_rotations[n];
		
		Script::CStruct* p_rotation_struct = new Script::CStruct;
		p_rotation_struct->AddInteger("active", rotation.active);
		p_rotation_struct->AddFloat("angle", rotation.angle);
		p_rotation_struct->AddFloat("duration", rotation.duration);
		p_rotation_struct->AddFloat("angle_step", rotation.angle_step);
		p_rotation_struct->AddFloat("angle_traversed", rotation.angle_traversed);
		
		p_rotations_array->SetStructure(n, p_rotation_struct);
	}
	p_info->AddArrayPointer("mp_rotations", p_rotations_array);

	CBaseComponent::GetDebugInfo(p_info);	  
#endif				 
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterRotateComponent::StopAllRotation (   )
{
	for (int n = 3; n--; )
	{
		mp_rotations[n].active = false;
	}
}
  
}
