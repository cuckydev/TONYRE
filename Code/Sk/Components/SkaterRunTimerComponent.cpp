//****************************************************************************
//* MODULE:         Sk/Components
//* FILENAME:       SkaterRunTimerComponent.cpp
//* OWNER:          Dan
//* CREATION DATE:  7/17/3
//****************************************************************************

#include <sk/components/skaterruntimercomponent.h>

#include <gel/object/compositeobject.h>
#include <gel/scripting/checksum.h>
#include <gel/scripting/script.h>
#include <gel/scripting/struct.h>
#include <gel/components/walkcomponent.h>

namespace Obj
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
CBaseComponent* CSkaterRunTimerComponent::s_create()
{
	return static_cast< CBaseComponent* >( new CSkaterRunTimerComponent );	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CSkaterRunTimerComponent::CSkaterRunTimerComponent() : CBaseComponent()
{
	SetType( CRC_SKATERRUNTIMER );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
CSkaterRunTimerComponent::~CSkaterRunTimerComponent()
{
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterRunTimerComponent::InitFromStructure( Script::CStruct* pParams )
{
	m_state = INACTIVE;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterRunTimerComponent::RefreshFromStructure( Script::CStruct* pParams )
{
	InitFromStructure(pParams);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterRunTimerComponent::Finalize()
{
	mp_walk_component = GetWalkComponentFromObject(GetObj());
	
	Dbg_Assert(mp_walk_component);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterRunTimerComponent::Update()
{
	if (m_state == ACTIVE_RUNNING)
	{
		switch (mp_walk_component->GetState())
		{
			case CWalkComponent::WALKING_HANG:
			case CWalkComponent::WALKING_LADDER:
			case CWalkComponent::WALKING_ANIMWAIT:
				m_timer -= Script::GetFloat(Crc::ConstCRC("Hang_Run_Timer_Speed_Adjustment")) * Tmr::FrameLength();
				break;
				
			default:
				m_timer -= Tmr::FrameLength();
				break;
		}
		
		if (m_timer < 0.0f)
		{
			set_state(ACTIVE_TIME_UP);
			GetObj()->SelfEvent(Crc::ConstCRC("RunTimerUp"));
		}
	}
	else if (m_state == ACTIVE_TIME_UP)
	{
		GetObj()->SelfEvent(Crc::ConstCRC("RunTimerUp"));
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CBaseComponent::EMemberFunctionResult CSkaterRunTimerComponent::CallMemberFunction( uint32 Checksum, Script::CStruct* pParams, Script::CScript* pScript )
{
	switch ( Checksum )
	{
		// @script | RunTimer_Pause | pauses the run timer
		case Crc::ConstCRC("RunTimer_Pause"):
			pause();
			break;
		
		// @script | RunTimer_UnPause | unpauses the run timer
		case Crc::ConstCRC("RunTimer_UnPause"):
			unpause();
			break;
			
		// @script | RunTimer_GetFactorComplete | returns the time left of the run timer as a float between zero and one in FactorComplete
		case Crc::ConstCRC("RunTimer_GetFactorComplete"):
			pScript->GetParams()->AddFloat(Crc::ConstCRC("FactorComplete"), m_timer / GetSkater()->GetScriptedStat(CRCD(0xb84f532, "Physics_RunTimer_Duration")));
			break;
			
		// @script | RunTimer_GetRunTimerControllerId | returns the id of the display controller script for the run timer in RunTimerControllerId
		case Crc::ConstCRC("RunTimer_GetRunTimerControllerId"):
			pScript->GetParams()->AddChecksum(Crc::ConstCRC("RunTimerControllerId"), get_run_timer_controller_id());
			break; 
			
		// @script | RunTimer_GetRunTimerId | returns the id of the display controller script for the run timer in RunTimerId
		case Crc::ConstCRC("RunTimer_GetRunTimerId"):
			pScript->GetParams()->AddChecksum(Crc::ConstCRC("RunTimerId"), Crc::ConstCRC("the_run_timer") + GetSkater()->GetSkaterNumber());
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

void CSkaterRunTimerComponent::GetDebugInfo(Script::CStruct *p_info)
{
	Dbg_MsgAssert(p_info,("NULL p_info sent to CSkaterRunTimerComponent::GetDebugInfo"));
	
	static const uint32 states [   ] =
	{
		Crc::ConstCRC("INACTIVE"),
		Crc::ConstCRC("ACTIVE_RUNNING"),
		Crc::ConstCRC("ACTIVE_PAUSED"),
		Crc::ConstCRC("ACTIVE_TIME_UP")
	};
	p_info->AddChecksum(Crc::ConstCRC("m_state"), states[m_state]);
	
	p_info->AddFloat(Crc::ConstCRC("m_timer"), m_timer);

	CBaseComponent::GetDebugInfo(p_info);	  
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterRunTimerComponent::ComboEnded (   )
{
	if (Script::FindSpawnedScriptWithID(get_run_timer_controller_id()))
	{
		CTracker::Instance()->LaunchEvent(Crc::ConstCRC("HideRunTimer"), get_run_timer_controller_id(), GetObj()->GetID());
	}
	
	set_state(INACTIVE);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterRunTimerComponent::unpause (   )
{
	if (m_state == INACTIVE) return;
		
	set_state(m_timer > 0.0f ? ACTIVE_RUNNING : ACTIVE_TIME_UP);
	
	if (m_unpause_count < vRT_NUM_TIME_CHUNKS)
	{
		float max_timer = (vRT_NUM_TIME_CHUNKS - m_unpause_count) * GetSkater()->GetScriptedStat(CRCD(0xb84f532, "Physics_RunTimer_Duration")) / vRT_NUM_TIME_CHUNKS;
		m_timer = Mth::Min(m_timer, max_timer);
	}
	
	m_unpause_count++;
	
	CTracker::Instance()->LaunchEvent(Crc::ConstCRC("ShowRunTimer"), get_run_timer_controller_id(), GetObj()->GetID());
}

}
