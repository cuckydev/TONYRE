//****************************************************************************
//* MODULE:         Sk/Components
//* FILENAME:       SkaterFloatingNameComponent.h
//* OWNER:			Dan
//* CREATION DATE:  3/13/3
//****************************************************************************

#include <Sk/Components/SkaterFloatingNameComponent.h>
#include <Sk/GameNet/GameNet.h>
#include <Sk/Modules/Skate/GameMode.h>

#include <Gfx/2D/ScreenElement2.h>
#include <Gfx/2D/ScreenElemMan.h>

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

CBaseComponent* CSkaterFloatingNameComponent::s_create()
{
	return static_cast< CBaseComponent* >( new CSkaterFloatingNameComponent );	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CSkaterFloatingNameComponent::CSkaterFloatingNameComponent() : CBaseComponent()
{
	SetType( CRC_SKATERFLOATINGNAME );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
CSkaterFloatingNameComponent::~CSkaterFloatingNameComponent()
{
	Script::CStruct* pParams = new Script::CStruct;
	pParams->AddChecksum(Crc::ConstCRC("id"), m_screen_element_id);
	
	Script::RunScript(Crc::ConstCRC("destroy_object_label"), pParams);
	
	delete pParams;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterFloatingNameComponent::InitFromStructure( Script::CStruct* pParams )
{
	(void)pParams;

	Dbg_MsgAssert(GetObj()->GetType() == SKATE_TYPE_SKATER, ("CSkaterFloatingNameComponent added to non-skater composite object"));
	
	switch (GetObj()->GetID())
	{
		case 0:
			m_screen_element_id = Crc::ConstCRC("skater_name_0");
			break;
		case 1:
			m_screen_element_id = Crc::ConstCRC("skater_name_1");
			break;
		case 2:
			m_screen_element_id = Crc::ConstCRC( "skater_name_2");
			break;
		case 3:
			m_screen_element_id = Crc::ConstCRC("skater_name_3");
			break;
		case 4:
			m_screen_element_id = Crc::ConstCRC("skater_name_4");
			break;
		case 5:
			m_screen_element_id = Crc::ConstCRC("skater_name_5");
			break;
		case 6:
			m_screen_element_id = Crc::ConstCRC( "skater_name_6");
			break;
		case 7:
			m_screen_element_id = Crc::ConstCRC("skater_name_7");
			break;
		default:
			Dbg_MsgAssert(false, ("CSkaterFloatingNameComponent in CCompositeObject with ID of 8 or greater"));
			return;
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterFloatingNameComponent::RefreshFromStructure( Script::CStruct* pParams )
{
	InitFromStructure(pParams);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterFloatingNameComponent::Update()
{
	if (!GameNet::Manager::Instance()->InNetGame() || !GameNet::Manager::Instance()->ShouldDrawPlayerNames())
	{
		Suspend(true);
		return;
	}
	
	if (!GetSkater()->IsInWorld()) return;
	
	GameNet::PlayerInfo* player = GameNet::Manager::Instance()->GetPlayerByObjectID(GetObj()->GetID());
	
	float offset;
	if (GameNet::Manager::Instance()->GetCurrentlyObservedPlayer() == player)
	{
		offset = FEET(8.0f);
	}
	else
	{
		offset = FEET(10.0f);
	}

	Script::CStruct* pParams = new Script::CStruct;
	pParams->AddChecksum(Crc::ConstCRC("id"), m_screen_element_id);

	int color_index;
	if (Mdl::Skate::Instance()->GetGameMode()->IsTeamGame())
	{
		color_index = player->m_Team + 2;
	}
	else
	{
		color_index = GetObj()->GetID() + 2;
	}

	char text[64];
	sprintf(text, "\\c%d%s", color_index, GetSkater()->GetDisplayName());
	pParams->AddString(Crc::ConstCRC("text"), text);
	pParams->AddVector(Crc::ConstCRC("pos3D"), GetObj()->m_pos[X], GetObj()->m_pos[Y] + offset, GetObj()->m_pos[Z]);

	Front::CScreenElement *p_name_elem = Front::CScreenElementManager::Instance()->GetElement(m_screen_element_id);
	if (p_name_elem)
	{
		p_name_elem->SetProperties(pParams);
	}
	else
	{
		Script::RunScript(Crc::ConstCRC("create_object_label"), pParams);
	}
	
	delete pParams;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CBaseComponent::EMemberFunctionResult CSkaterFloatingNameComponent::CallMemberFunction( uint32 Checksum, Script::CStruct* pParams, Script::CScript* pScript )
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

void CSkaterFloatingNameComponent::GetDebugInfo ( Script::CStruct *p_info )
{
#ifdef	__DEBUG_CODE__
	Dbg_MsgAssert(p_info,("nullptr p_info sent to CSkaterFloatingNameComponent::GetDebugInfo"));
	
	CBaseComponent::GetDebugInfo(p_info);	  
#endif				 
}
	
}
