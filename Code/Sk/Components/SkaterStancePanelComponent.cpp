//****************************************************************************
//* MODULE:         Sk/Components
//* FILENAME:       SkaterStancePanelComponent.cpp
//* OWNER:          Dan
//* CREATION DATE:  2/25/3
//****************************************************************************

#include <sk/components/skaterstancepanelcomponent.h>

#include <gel/object/compositeobject.h>
#include <gel/scripting/checksum.h>
#include <gel/scripting/script.h>
#include <gel/scripting/struct.h>

#include <gfx/2d/spriteelement.h>
#include <gfx/2d/screenelemman.h>

namespace Obj
{
	
// Component giving script control through a composite object over the input pad vibrators of the composite object's input handler.
	
// Only composite objects corresponding to local clients should be given this component.
	
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
CBaseComponent* CSkaterStancePanelComponent::s_create()
{
	return static_cast< CBaseComponent* >( new CSkaterStancePanelComponent );	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CSkaterStancePanelComponent::CSkaterStancePanelComponent() : CBaseComponent()
{
	SetType( CRC_SKATERSTANCEPANEL );
	
	mp_core_physics_component = nullptr;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
CSkaterStancePanelComponent::~CSkaterStancePanelComponent()
{
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterStancePanelComponent::InitFromStructure( Script::CStruct* pParams )
{
	m_last_stance = -1;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterStancePanelComponent::RefreshFromStructure( Script::CStruct* pParams )
{
	InitFromStructure(pParams);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterStancePanelComponent::Finalize (   )
{
	mp_core_physics_component = GetSkaterCorePhysicsComponentFromObject(GetObj());
	
	Dbg_Assert(mp_core_physics_component);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterStancePanelComponent::Update()
{
	Front::CSpriteElement* p_stance_icon = static_cast< Front::CSpriteElement* >(Front::CScreenElementManager::Instance()->GetElement(
		Crc::ConstCRC("the_boardstance_sprite") + static_cast< CSkater* >(GetObj())->GetHeapIndex()
	).Convert());
	
	Dbg_Assert(p_stance_icon);
	
	int stance = determine_stance();
	
	if (stance == m_last_stance) return;
	m_last_stance = stance;
	
	if (stance == 5)
	{
		p_stance_icon->SetAlpha(0.0f, Front::CScreenElement::FORCE_INSTANT);
	}
	else
	{
		const static uint32 sp_texture_checksums[] =
		{
            Crc::ConstCRC("nollie_icon"),
            Crc::ConstCRC("fakie_icon"),
			Crc::ConstCRC("switch_icon"),
            Crc::ConstCRC("sw_pressure_icon"),
            Crc::ConstCRC("pressure_icon")
		};
		
		p_stance_icon->SetTexture(sp_texture_checksums[stance]);
		p_stance_icon->SetAlpha(1.0f, Front::CScreenElement::FORCE_INSTANT);
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CBaseComponent::EMemberFunctionResult CSkaterStancePanelComponent::CallMemberFunction( uint32 Checksum, Script::CStruct* pParams, Script::CScript* pScript )
{
	switch ( Checksum )
	{
        // @script | InNollie | true if in nollie
		case Crc::ConstCRC("InNollie"):
			return m_in_nollie ? CBaseComponent::MF_TRUE : CBaseComponent::MF_FALSE;
			break;

        // @script | NollieOn | sets nollie to on (check with InNollie)
		case Crc::ConstCRC("NollieOn"):
			if (m_in_nollie == false)
			{
				m_in_nollie = true;
				GetObj()->BroadcastEvent(Crc::ConstCRC("SkaterEnterNollie"));
			}
			break;

        // @script | NollieOff | sets nollie to off (check with InNollie)
		case Crc::ConstCRC("NollieOff"):
			if (m_in_nollie == true)
			{
				m_in_nollie = false;
				GetObj()->BroadcastEvent(Crc::ConstCRC("SkaterExitNollie"));
			}
			break;

        // @script | InPressure | true if in pressure
        case Crc::ConstCRC("InPressure"):
			return m_in_pressure ? CBaseComponent::MF_TRUE : CBaseComponent::MF_FALSE;
			break;

        // @script | PressureOn | sets pressure to on (check with InPressure)
		case CRCC(0xa23d710,"PressureOn"):
			if (m_in_pressure == false)
			{
				m_in_pressure = true;
				GetObj()->BroadcastEvent(Crc::ConstCRC("SkaterEnterPressure"));
			}
			break;

        // @script | PressureOff | sets pressure to off (check with InPressure)
		case Crc::ConstCRC("PressureOff"):
			if (m_in_pressure == true)
			{
				m_in_pressure = false;
				GetObj()->BroadcastEvent(Crc::ConstCRC("SkaterExitPressure"));
			}
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

void CSkaterStancePanelComponent::GetDebugInfo ( Script::CStruct *p_info )
{
#ifdef	__DEBUG_CODE__
	Dbg_MsgAssert(p_info,("nullptr p_info sent to CSkaterStancePanelComponent::GetDebugInfo"));
	
	p_info->AddInteger("stance", determine_stance());

	CBaseComponent::GetDebugInfo(p_info);	  
#endif				 
}

}
