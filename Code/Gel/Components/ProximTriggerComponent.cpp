//****************************************************************************
//* MODULE:         Gel/Components
//* FILENAME:       ProximTriggerComponent.cpp
//* OWNER:          Dan
//* CREATION DATE:  2/28/3
//****************************************************************************

#include <Gel/Components/ProximTriggerComponent.h>

#include <Gel/Object/compositeobjectmanager.h>
#include <Gel/Object/compositeobject.h>
#include <Gel/Scripting/checksum.h>
#include <Gel/Scripting/script.h>
#include <Gel/Scripting/struct.h>

#include <Sk/Objects/proxim.h>
#include <Sk/Modules/Skate/skate.h>

namespace Obj
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CBaseComponent* CProximTriggerComponent::s_create()
{
	return static_cast< CBaseComponent* >( new CProximTriggerComponent );	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CProximTriggerComponent::CProximTriggerComponent() : CBaseComponent()
{
	SetType( CRC_PROXIMTRIGGER );
	
	if (!Mdl::Skate::Instance()->mpProximManager)
	{
		Dbg_Message("ProximTriggerComponent created before ProximManager; ProximNodes will not work");
		return;
	}
	
	Dbg_MsgAssert(Mdl::Skate::Instance()->mpProximManager, ("ProximTriggerComponent created before ProximManager"));
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
CProximTriggerComponent::~CProximTriggerComponent()
{
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CProximTriggerComponent::InitFromStructure( Script::CStruct* pParams )
{
	if (pParams->ContainsComponentNamed(Crc::ConstCRC( "ProximTriggerTarget")))
	{
		uint32 script_target_id;
		pParams->GetChecksum(Crc::ConstCRC( "ProximTriggerTarget"), &script_target_id);
		
		mp_script_target_object = static_cast< CCompositeObject* >(CCompositeObjectManager::Instance()->GetObjectByID(script_target_id));
		Dbg_MsgAssert(mp_script_target_object, ("ProximTriggerComponent given unidentifiable target object"));
	}
	
	m_active = false;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CProximTriggerComponent::RefreshFromStructure( Script::CStruct* pParams )
{
	InitFromStructure(pParams);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CProximTriggerComponent::Update()
{
	if (!m_active) return;
	ProximUpdate();
}

void CProximTriggerComponent::ProximUpdate()
{

	#if 0	
	
	Dbg_Assert(mp_script_target_object);
	
	uint32 proxim_trigger_mask = Mdl::Skate::Instance()->mpProximManager->GetProximTriggerMask(m_viewport);
	
	Proxim_Update(proxim_trigger_mask, mp_script_target_object, GetObj()->GetPos());
	#endif
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CBaseComponent::EMemberFunctionResult CProximTriggerComponent::CallMemberFunction( uint32 Checksum, Script::CStruct* pParams, Script::CScript* pScript )
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

void CProximTriggerComponent::GetDebugInfo(Script::CStruct *p_info)
{
#ifdef	__DEBUG_CODE__
	Dbg_MsgAssert(p_info, ("nullptr p_info sent to CProximTriggerComponent::GetDebugInfo"));
	
	p_info->AddChecksum("mp_script_target_object", mp_script_target_object->GetID());
	p_info->AddInteger("proxim_trigger_mask", Mdl::Skate::Instance()->mpProximManager->GetProximTriggerMask(m_viewport));

	CBaseComponent::GetDebugInfo(p_info);	  
#endif				 
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
void CProximTriggerComponent::SetScriptTarget ( CCompositeObject* p_script_target_object )
{
	Dbg_Assert(p_script_target_object);
	mp_script_target_object = p_script_target_object;
}

}
