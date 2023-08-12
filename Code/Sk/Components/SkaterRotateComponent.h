//****************************************************************************
//* MODULE:         Sk/Components
//* FILENAME:       SkaterRotateComponent.h
//* OWNER:          Dan
//* CREATION DATE:  3/6/3
//****************************************************************************

#ifndef __COMPONENTS_SKATERROTATECOMPONENT_H__
#define __COMPONENTS_SKATERROTATECOMPONENT_H__

#include <Core/Defines.h>
#include <Core/support.h>

#include <Gel/Object/basecomponent.h>

#include <Sk/Objects/skater.h>

#define		CRC_SKATERROTATE Crc::ConstCRC("SkaterRotate")

#define		GetSkaterRotateComponent() ((Obj::CSkaterRotateComponent*)GetComponent(CRC_SKATERROTATE))
#define		GetSkaterRotateComponentFromObject(pObj) ((Obj::CSkaterRotateComponent*)(pObj)->GetComponent(CRC_SKATERROTATE))

namespace Script
{
    class CScript;
    class CStruct;
}
              
namespace Obj
{
	class CSkaterCorePhysicsComponent;

class CSkaterRotateComponent : public CBaseComponent
{
	struct SRotation
	{
		float angle;
		float duration;
		float angle_step;
		float angle_traversed;
		bool active;
	};
	
public:
    CSkaterRotateComponent();
    virtual ~CSkaterRotateComponent();

public:
    virtual void            		Update();
    virtual void            		InitFromStructure( Script::CStruct* pParams );
    virtual void            		RefreshFromStructure( Script::CStruct* pParams );
    virtual void            		Finalize();
    
    virtual EMemberFunctionResult   CallMemberFunction( uint32 Checksum, Script::CStruct* pParams, Script::CScript* pScript );
	virtual void 					GetDebugInfo( Script::CStruct* p_info );

	static CBaseComponent*			s_create();
	
	bool							IsApplyingRotation ( unsigned axis );
	void							StopAllRotation (   );
	
	CSkater*						GetSkater() { return static_cast< CSkater* >(GetObj()); }
	
private:
	SRotation						mp_rotations[3];
	
	// peer components
	CSkaterCorePhysicsComponent*	mp_core_physics_component;
};

inline bool CSkaterRotateComponent::IsApplyingRotation ( unsigned axis )
{
	Dbg_Assert(axis < 3);
	return mp_rotations[axis].active;
}

}

#endif
