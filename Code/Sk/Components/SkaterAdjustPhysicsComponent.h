//****************************************************************************
//* MODULE:         Sk/Components
//* FILENAME:       SkaterAdjustPhysicsComponent.h
//* OWNER:          Dan
//* CREATION DATE:  3/26/3
//****************************************************************************

#ifndef __COMPONENTS_SKATERADJUSTPHYSICSCOMPONENT_H__
#define __COMPONENTS_SKATERADJUSTPHYSICSCOMPONENT_H__

#include <Core/Defines.h>
#include <Core/support.h>

#include <Gel/Object/basecomponent.h>

#include <Sk/Objects/skater.h>

#define		CRC_SKATERADJUSTPHYSICS Crc::ConstCRC("SkaterAdjustPhysics")

#define		GetSkaterAdjustPhysicsComponent() ((Obj::CSkaterAdjustPhysicsComponent*)GetComponent(CRC_SKATERADJUSTPHYSICS))
#define		GetSkaterAdjustPhysicsComponentFromObject(pObj) ((Obj::CSkaterAdjustPhysicsComponent*)(pObj)->GetComponent(CRC_SKATERADJUSTPHYSICS))

namespace Script
{
    class CScript;
    class CStruct;
}
              
namespace Obj
{
	class CSkaterCorePhysicsComponent;
	class CModelComponent;
	class CShadowComponent;
	class CMovableContactComponent;
	class CSkaterStateComponent;
	class CSkaterNonLocalNetLogicComponent;

class CSkaterAdjustPhysicsComponent : public CBaseComponent
{
	friend class CSkaterNonLocalNetLogicComponent;
	
public:
    CSkaterAdjustPhysicsComponent();
    virtual ~CSkaterAdjustPhysicsComponent();

public:
    virtual void            		Update();
    virtual void            		InitFromStructure( Script::CStruct* pParams );
    virtual void            		RefreshFromStructure( Script::CStruct* pParams );
    virtual void            		Finalize();
    
    virtual EMemberFunctionResult   CallMemberFunction( uint32 Checksum, Script::CStruct* pParams, Script::CScript* pScript );
	virtual void 					GetDebugInfo( Script::CStruct* p_info );

	static CBaseComponent*			s_create();
	
	CSkater*						GetSkater() { return static_cast< CSkater* >(GetObj()); }
	
	bool							UberFriggedThisFrame (  ) { return m_uber_frigged_this_frame; }
	
private:
	void							uber_frig (   );
	void							check_inside_objects (   );
	
private:
	int								m_nudge;						// counter for which nudges to attempt if we get stuck in an uberfrig

	bool							m_uber_frigged_this_frame;
	
	// peer components
	CSkaterCorePhysicsComponent*	mp_core_physics_component;
	CModelComponent*				mp_model_component;
	CShadowComponent*				mp_shadow_component;
	CMovableContactComponent*		mp_movable_contact_component;
	CSkaterStateComponent*			mp_state_component;
};

}

#endif
