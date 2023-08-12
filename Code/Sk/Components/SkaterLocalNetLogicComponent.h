//****************************************************************************
//* MODULE:         Sk/Components
//* FILENAME:       SkaterLocalNetLogicComponent.cpp
//* OWNER:          Dan
//* CREATION DATE:  3/12/3
//****************************************************************************

#ifndef __COMPONENTS_SKATERLOCALNETLOGICCOMPONENT_H__
#define __COMPONENTS_SKATERLOCALNETLOGICCOMPONENT_H__

#include <Core/Defines.h>
#include <Core/support.h>

#include <Gel/Object/basecomponent.h>

#include <Sk/Objects/skater.h>

#define		CRC_SKATERLOCALNETLOGIC Crc::ConstCRC("SkaterLocalNetLogic")

#define		GetSkaterLocalNetLogicComponent() ((Obj::CSkaterLocalNetLogicComponent*)GetComponent(CRC_SKATERLOCALNETLOGIC))
#define		GetSkaterLocalNetLogicComponentFromObject(pObj) ((Obj::CSkaterLocalNetLogicComponent*)(pObj)->GetComponent(CRC_SKATERLOCALNETLOGIC))

namespace Script
{
    class CScript;
    class CStruct;
}
              
namespace Obj
{
	class CSkaterCorePhysicsComponent;
	class CSkaterStateComponent;

class CSkaterLocalNetLogicComponent : public CBaseComponent
{
public:
    CSkaterLocalNetLogicComponent();
    virtual ~CSkaterLocalNetLogicComponent();

public:
    virtual void            		Update();
    virtual void            		InitFromStructure( Script::CStruct* pParams );
    virtual void            		RefreshFromStructure( Script::CStruct* pParams );
    virtual void            		Finalize();
    
    virtual EMemberFunctionResult   CallMemberFunction( uint32 Checksum, Script::CStruct* pParams, Script::CScript* pScript );
	virtual void 					GetDebugInfo( Script::CStruct* p_info );

	static CBaseComponent*			s_create();
	
	CSkater*						GetSkater() { return static_cast< CSkater* >(GetObj()); }
	
	static int						sHandleStealMessage( Net::MsgHandlerContext* context );
	
private:
	void							network_update();
	int								get_update_flags();
	
	Tmr::Time						m_last_update_time;
	
	char							m_last_sent_terrain;
	short							m_last_sent_pos[3];
	short							m_last_sent_rot[3];
	Flags< int >					m_last_sent_flags;
	Flags< int >					m_last_sent_end_run_flags;
	char							m_last_sent_state;
	char							m_last_sent_doing_trick;
	char							m_last_sent_walking;
	char							m_last_sent_driving;
	size_t							m_last_sent_rail;
	
private:
	CSkaterStateComponent*			mp_state_component;
	CSkaterCorePhysicsComponent*	mp_physics_component;
};

}

#endif
