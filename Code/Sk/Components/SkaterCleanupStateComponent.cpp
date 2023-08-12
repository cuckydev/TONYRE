//****************************************************************************
//* MODULE:         Sk/Components
//* FILENAME:       SkaterCleanupStateComponent.cpp
//* OWNER:        	Dan
//* CREATION DATE:  3/26/3
//****************************************************************************

#include <Sk/Components/SkaterCleanupStateComponent.h>
#include <Sk/Components/SkaterStateComponent.h>

#include <Gel/Object/compositeobject.h>
#include <Gel/Scripting/checksum.h>
#include <Gel/Scripting/script.h>
#include <Gel/Scripting/struct.h>
#include <Gel/Components/SuspendComponent.h>

#include <Sys/Replay/replay.h>

namespace Obj
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
CBaseComponent* CSkaterCleanupStateComponent::s_create()
{
	return static_cast< CBaseComponent* >( new CSkaterCleanupStateComponent );	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CSkaterCleanupStateComponent::CSkaterCleanupStateComponent() : CBaseComponent()
{
	SetType( CRC_SKATERCLEANUPSTATE );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
CSkaterCleanupStateComponent::~CSkaterCleanupStateComponent()
{
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterCleanupStateComponent::InitFromStructure( Script::CStruct* pParams )
{
	(void)pParams;
	mp_state_component = nullptr;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterCleanupStateComponent::RefreshFromStructure( Script::CStruct* pParams )
{
	(void)pParams;
	InitFromStructure(pParams);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterCleanupStateComponent::Finalize(   )
{
	mp_state_component = GetSkaterStateComponentFromObject(GetObj());
	
	Dbg_Assert(mp_state_component);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterCleanupStateComponent::Update()
{
	// Make sure the sparks are off if not on a rail
	if (GetSkater()->mSparksRequireRail && mp_state_component->GetState() != RAIL)
	{
		GetSkater()->SparksOff();
	}
		
	// Dan: shouldn't need to do this; the suspend components update themselves
	// Perform LOD/culling/occluding
	// NOTE: Move to CModeldComponent::Update?  Ask Gary about this.
	// GetSuspendComponentFromObject(GetObj())->CheckModelActive();
	
	// Don't update the shadow if running a replay. The replay code will update it, using the replay dummy skater's position and matrix.
	// if (!Replay::RunningReplay())
	// {
	GetSkater()->UpdateShadow(GetObj()->m_pos, GetObj()->m_matrix);
	// }
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CBaseComponent::EMemberFunctionResult CSkaterCleanupStateComponent::CallMemberFunction( uint32 Checksum, Script::CStruct* pParams, Script::CScript* pScript )
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

void CSkaterCleanupStateComponent::GetDebugInfo(Script::CStruct *p_info)
{
	(void)p_info;
#ifdef	__DEBUG_CODE__
	Dbg_MsgAssert(p_info,("nullptr p_info sent to CSkaterCleanupStateComponent::GetDebugInfo"));

	CBaseComponent::GetDebugInfo(p_info);	  
#endif				 
}
	
}
