//****************************************************************************
//* MODULE:         Gel/Components
//* FILENAME:       FloatingLabelComponent.h
//* OWNER:			Dan
//* CREATION DATE:  3/13/3
//****************************************************************************

#include <gel/components/floatinglabelcomponent.h>
#include <sk/gamenet/gamenet.h>
#include <sk/modules/skate/gamemode.h>

#include <gfx/2d/screenelement2.h>
#include <gfx/2d/screenelemman.h>

#include <gel/object/compositeobject.h>
#include <gel/scripting/checksum.h>
#include <gel/scripting/script.h>
#include <gel/scripting/struct.h>

namespace Obj
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CBaseComponent* CFloatingLabelComponent::s_create()
{
	return static_cast< CBaseComponent* >( new CFloatingLabelComponent );	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CFloatingLabelComponent::CFloatingLabelComponent() : CBaseComponent()
{
	SetType( CRC_FLOATINGLABEL );
	
	strcpy(m_string, "Unset Label");
	m_color_index = 2;
	m_y_offset = 10.0f * 12.0f;
	m_screen_element_id = 0;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
CFloatingLabelComponent::~CFloatingLabelComponent()
{
	Script::CStruct* pParams = pParams = new Script::CStruct;
	pParams->AddChecksum(Crc::ConstCRC("id"), m_screen_element_id);
	
	Script::RunScript(Crc::ConstCRC("destroy_object_label"), pParams);
	
	delete pParams;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CFloatingLabelComponent::InitFromStructure( Script::CStruct* pParams )
{
	const char* string;
	if (pParams->GetString(Crc::ConstCRC("string"), &string))
	{
		strncpy(m_string, string, 64);
	}
	pParams->GetInteger(Crc::ConstCRC("color"), &m_color_index);
	pParams->GetFloat(Crc::ConstCRC("y_offset"), &m_y_offset);
	pParams->GetChecksum(Crc::ConstCRC("screen_element_id"), &m_screen_element_id);
	
	Dbg_MsgAssert(m_screen_element_id, ("FloatingLabelComponent has bad screen_elemend_id"));
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CFloatingLabelComponent::RefreshFromStructure( Script::CStruct* pParams )
{
	InitFromStructure(pParams);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CFloatingLabelComponent::Update()
{
	Script::CStruct* pParams = new Script::CStruct;
	pParams->AddChecksum(Crc::ConstCRC("id"), m_screen_element_id);
	
	char text[64];
	sprintf(text, "\\c%d%s", m_color_index, m_string);

	pParams->AddString(Crc::ConstCRC("text"), text);
	pParams->AddVector(Crc::ConstCRC("pos3D"), GetObj()->m_pos[X], GetObj()->m_pos[Y] + m_y_offset, GetObj()->m_pos[Z]);

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

CBaseComponent::EMemberFunctionResult CFloatingLabelComponent::CallMemberFunction( uint32 Checksum, Script::CStruct* pParams, Script::CScript* pScript )
{
	switch ( Checksum )
	{
		default:
			return CBaseComponent::MF_NOT_EXECUTED;
	}
    return CBaseComponent::MF_TRUE;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CFloatingLabelComponent::GetDebugInfo ( Script::CStruct *p_info )
{
#ifdef	__DEBUG_CODE__
	Dbg_MsgAssert(p_info,("nullptr p_info sent to CFloatingLabelComponent::GetDebugInfo"));
	
	p_info->AddString(Crc::ConstCRC("m_string"), m_string);
	p_info->AddInteger(Crc::ConstCRC("m_color_index"), m_color_index);
	p_info->AddFloat(Crc::ConstCRC("m_y_offset"), m_y_offset);
	p_info->AddChecksum(Crc::ConstCRC("m_screen_element_id"), m_screen_element_id);
	
	CBaseComponent::GetDebugInfo(p_info);	  
#endif				 
}
	
}
