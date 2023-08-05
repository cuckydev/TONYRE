//****************************************************************************
//* MODULE:         Sk/Components
//* FILENAME:       SkaterEndRunComponent.cpp
//* OWNER:          Dan
//* CREATION DATE:  3/28/3
//****************************************************************************

#include <sk/components/skaterendruncomponent.h>
#include <sk/modules/skate/skate.h>
#include <sk/modules/skate/gamemode.h>
#include <sk/gamenet/gamenet.h>
#include <sk/objects/skater.h>

#include <gel/object/compositeobject.h>
#include <gel/scripting/checksum.h>
#include <gel/scripting/script.h>
#include <gel/scripting/struct.h>
#include <gel/scripting/symboltable.h>
#include <gel/objtrack.h>

#define	FLAGEXCEPTION(X) GetObj()->SelfEvent(X)

namespace Obj
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CBaseComponent* CSkaterEndRunComponent::s_create()
{
	return static_cast< CBaseComponent* >( new CSkaterEndRunComponent );	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CSkaterEndRunComponent::CSkaterEndRunComponent() : CBaseComponent()
{
	SetType( CRC_SKATERENDRUN );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
CSkaterEndRunComponent::~CSkaterEndRunComponent()
{
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterEndRunComponent::InitFromStructure( Script::CStruct* pParams )
{
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterEndRunComponent::RefreshFromStructure( Script::CStruct* pParams )
{
	InitFromStructure(pParams);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterEndRunComponent::Update()
{
	if (!Mdl::Skate::Instance()->IsMultiplayerGame())
	{
		Suspend(true);
		return;
	}
	
	if( static_cast< CSkater* >(GetObj())->IsLocalClient())
	{
		if (m_flags.Test(FINISHED_END_OF_RUN) && !GameNet::Manager::Instance()->HaveSentEndOfRunMessage())
		{
			GameNet::Manager::Instance()->SendEndOfRunMessage();
		}
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CBaseComponent::EMemberFunctionResult CSkaterEndRunComponent::CallMemberFunction( uint32 Checksum, Script::CStruct* pParams, Script::CScript* pScript )
{
	switch ( Checksum )
	{
        // @script | EndOfRunDone | 
		case Crc::ConstCRC("EndOfRunDone"):
			m_flags.Set(FINISHED_END_OF_RUN);
			m_flags.Clear(IS_ENDING_RUN);
			break;
		
		case Crc::ConstCRC("RunStarted"):
			m_flags.Clear(STARTED_END_OF_RUN);
			m_flags.Clear( STARTED_GOAL_END_OF_RUN );
			m_flags.Clear(FINISHED_END_OF_RUN);
			m_flags.Clear( FINISHED_GOAL_END_OF_RUN );
			m_flags.Clear(IS_ENDING_RUN);
			m_flags.Clear(IS_ENDING_GOAL);
			break;

		case Crc::ConstCRC("EndOfRunStarted"):
			m_flags.Set(STARTED_END_OF_RUN);
			break;

		case Crc::ConstCRC("Goal_EndOfRunStarted"):
			m_flags.Set(STARTED_GOAL_END_OF_RUN);
			break;
			
		// @script | Goal_EndOfRunDone | 
		case Crc::ConstCRC("Goal_EndOfRunDone"):
			m_flags.Set(FINISHED_GOAL_END_OF_RUN);
			m_flags.Clear(IS_ENDING_GOAL);
			break;
			
		case Crc::ConstCRC("IsInEndOfRun"):
			return (m_flags.Test(STARTED_END_OF_RUN) && !m_flags.Test(FINISHED_END_OF_RUN)) ? CBaseComponent::MF_TRUE : CBaseComponent::MF_FALSE;
			
		default:
			return CBaseComponent::MF_NOT_EXECUTED;
	}
    return CBaseComponent::MF_TRUE;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterEndRunComponent::GetDebugInfo(Script::CStruct *p_info)
{
#ifdef	__DEBUG_CODE__
	Dbg_MsgAssert(p_info,("nullptr p_info sent to CSkaterEndRunComponent::GetDebugInfo"));
	
	p_info->AddChecksum(Crc::ConstCRC("STARTED_END_OF_RUN"), m_flags.Test(STARTED_END_OF_RUN) ? Crc::ConstCRC( "true") : Crc::ConstCRC("false"));
	p_info->AddChecksum(Crc::ConstCRC("FINISHED_END_OF_RUN"), m_flags.Test(FINISHED_END_OF_RUN) ? Crc::ConstCRC( "true") : Crc::ConstCRC("false"));
	p_info->AddChecksum(Crc::ConstCRC("IS_ENDING_RUN"), m_flags.Test(IS_ENDING_RUN) ? Crc::ConstCRC( "true") : Crc::ConstCRC("false"));
	p_info->AddChecksum(Crc::ConstCRC("STARTED_GOAL_END_OF_RUN"), m_flags.Test(STARTED_GOAL_END_OF_RUN) ? Crc::ConstCRC( "true") : Crc::ConstCRC("false"));
	p_info->AddChecksum(Crc::ConstCRC("FINISHED_GOAL_END_OF_RUN"), m_flags.Test(FINISHED_GOAL_END_OF_RUN) ? Crc::ConstCRC( "true") : Crc::ConstCRC("false"));
	p_info->AddChecksum(Crc::ConstCRC("IS_ENDING_GOAL"), m_flags.Test(IS_ENDING_GOAL) ? Crc::ConstCRC( "true") : Crc::ConstCRC("false"));

	CBaseComponent::GetDebugInfo(p_info);	  
#endif				 
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterEndRunComponent::EndRun ( bool force_end )
{
	if (force_end || Mdl::Skate::Instance()->GetGameMode()->ShouldStopAtZero())
	{
		if (!m_flags.Test(IS_ENDING_RUN) && !m_flags.Test(FINISHED_END_OF_RUN))
		{
			//DumpUnwindStack( 20, 0 );
			m_flags.Set(IS_ENDING_RUN);
			if (static_cast< CSkater* >(GetObj())->IsLocalClient())
			{
				Script::RunScript(Crc::ConstCRC("ForceEndOfRun"), nullptr, GetObj());
			}
		}
	}
	else
	{
		//DumpUnwindStack( 20, 0 );
		FLAGEXCEPTION(Crc::ConstCRC("RunHasEnded"));
		m_flags.Clear(FINISHED_END_OF_RUN);
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterEndRunComponent::EndGoalRun ( bool force_end )
{
	m_flags.Clear(FINISHED_GOAL_END_OF_RUN);
	FLAGEXCEPTION( Crc::ConstCRC("GoalHasEnded") );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CSkaterEndRunComponent::RunHasEnded (   )
{
	return m_flags.Test(FINISHED_END_OF_RUN);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CSkaterEndRunComponent::GoalRunHasEnded (   )
{
	return m_flags.Test(FINISHED_GOAL_END_OF_RUN);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CSkaterEndRunComponent::StartedEndOfRun (   )
{
	return m_flags.Test(STARTED_END_OF_RUN);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterEndRunComponent::ClearStartedEndOfRunFlag (   )
{
	m_flags.Clear(STARTED_END_OF_RUN);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CSkaterEndRunComponent::StartedGoalEndOfRun (   )
{
	return m_flags.Test(STARTED_GOAL_END_OF_RUN);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterEndRunComponent::ClearStartedGoalEndOfRunFlag (   )
{
	m_flags.Clear(STARTED_GOAL_END_OF_RUN);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CSkaterEndRunComponent::IsEndingRun (   )
{
	return m_flags.Test(IS_ENDING_RUN);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterEndRunComponent::ClearIsEndingRun (   )
{
	m_flags.Clear(IS_ENDING_RUN);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

Flags<int>	CSkaterEndRunComponent::GetFlags( void )
{
	return m_flags;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void	CSkaterEndRunComponent::SetFlags( Flags<int> flags )
{
	m_flags = flags;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

}
