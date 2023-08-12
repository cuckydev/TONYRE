//****************************************************************************
//* MODULE:         Sk/Components
//* FILENAME:       SkaterCleanupStateComponent.h
//* OWNER:        	Dan
//* CREATION DATE:  3/26/3
//****************************************************************************

#ifndef __COMPONENTS_SKATERCLEANUPSTATECOMPONENT_H__
#define __COMPONENTS_SKATERCLEANUPSTATECOMPONENT_H__

#include <Core/Defines.h>
#include <Core/support.h>

#include <Sk/Objects/skater.h>

#include <Gel/Object/basecomponent.h>

#define		CRC_SKATERCLEANUPSTATE Crc::ConstCRC("SkaterCleanupState")

#define		GetSkaterCleanupStateComponent() ((Obj::CSkaterCleanupStateComponent*)GetComponent(CRC_SKATERCLEANUPSTATE))
#define		GetSkaterCleanupStateComponentFromObject(pObj) ((Obj::CSkaterCleanupStateComponent*)(pObj)->GetComponent(CRC_SKATERCLEANUPSTATE))

namespace Script
{
    class CScript;
    class CStruct;
}
              
namespace Obj
{
	class CSkaterStateComponent;

class CSkaterCleanupStateComponent : public CBaseComponent
{
public:
    CSkaterCleanupStateComponent();
    virtual ~CSkaterCleanupStateComponent();

public:
    virtual void            		Update();
	virtual void					Finalize(   );
    virtual void            		InitFromStructure( Script::CStruct* pParams );
    virtual void            		RefreshFromStructure( Script::CStruct* pParams );
    
    virtual EMemberFunctionResult   CallMemberFunction( uint32 Checksum, Script::CStruct* pParams, Script::CScript* pScript );
	virtual void 					GetDebugInfo( Script::CStruct* p_info );

	static CBaseComponent*			s_create();
	
	CSkater*						GetSkater() { return static_cast< CSkater* >(GetObj()); }
	
private:
	CSkaterStateComponent*			mp_state_component;
};

}

#endif
