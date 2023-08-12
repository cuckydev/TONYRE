//****************************************************************************
//* MODULE:         Gel/Components
//* FILENAME:       RailManagerComponent.h
//* OWNER:          Dave Cowling
//* CREATION DATE:  02/17/03
//****************************************************************************

#ifndef __COMPONENTS_RAILMANAGERCOMPONENT_H__
#define __COMPONENTS_RAILMANAGERCOMPONENT_H__

#include <Core/Defines.h>
#include <Core/support.h>

#include <Gel/Object/basecomponent.h>

#include <Sk/Objects/rail.h>

// Just thinking about it - a generic way of accessing the component				 
#define		CRC_RAILMANAGER								Crc::ConstCRC( "RailManager" )
#define		GetRailManagerComponent()					((Obj::CRailManagerComponent*)GetComponent( CRC_RAILMANAGER ))
#define		GetRailManagerComponentFromObject( pObj )	((Obj::CRailManagerComponent*)(pObj)->GetComponent( CRC_RAILMANAGER ))

namespace Script
{
    class CScript;
    class CStruct;
}
              
namespace Obj
{

class CRailManagerComponent : public CBaseComponent
{
public:
    CRailManagerComponent();
    virtual ~CRailManagerComponent();

public:
    virtual void            		Update();
    virtual void            		InitFromStructure( Script::CStruct* pParams );
    virtual void            		RefreshFromStructure( Script::CStruct* pParams );
    
    virtual EMemberFunctionResult   CallMemberFunction( uint32 Checksum, Script::CStruct* pParams, Script::CScript* pScript );
	virtual void 					GetDebugInfo( Script::CStruct* p_info );

	static CBaseComponent*			s_create();
	
	Mth::Matrix						UpdateRailManager (   );

	virtual Obj::CRailManager*		GetRailManager( void )	{ return mp_rail_manager; }

private:
	Obj::CRailManager*				mp_rail_manager;
};

}

#endif
