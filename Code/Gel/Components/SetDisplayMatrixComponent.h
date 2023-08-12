//****************************************************************************
//* MODULE:         Gel/Components
//* FILENAME:       SetDisplayMatrixComponent.h
//* OWNER:          Dan
//* CREATION DATE:  8/6/3
//****************************************************************************

#ifndef __COMPONENTS_SETDISPLAYMATRIXCOMPONENT_H__
#define __COMPONENTS_SETDISPLAYMATRIXCOMPONENT_H__

#include <Core/Defines.h>
#include <Core/support.h>

#include <Gel/Object/basecomponent.h>

#define		CRC_SETDISPLAYMATRIX Crc::ConstCRC("SetDisplayMatrix")

#define		GetSetDisplayMatrixComponent() ((Obj::CSetDisplayMatrixComponent*)GetComponent(CRC_SETDISPLAYMATRIX))
#define		GetSetDisplayMatrixComponentFromObject(pObj) ((Obj::CSetDisplayMatrixComponent*)(pObj)->GetComponent(CRC_SETDISPLAYMATRIX))

namespace Script
{
    class CScript;
    class CStruct;
}
              
namespace Obj
{

class CSetDisplayMatrixComponent : public CBaseComponent
{
public:
    CSetDisplayMatrixComponent();
    virtual ~CSetDisplayMatrixComponent();

public:
	virtual void					InitFromStructure( Script::CStruct* pParams );
	virtual void					RefreshFromStructure( Script::CStruct* pParams );
    virtual void            		Update();
    
    virtual EMemberFunctionResult   CallMemberFunction( uint32 Checksum, Script::CStruct* pParams, Script::CScript* pScript );
	virtual void 					GetDebugInfo( Script::CStruct* p_info );

	static CBaseComponent*			s_create();
};

}

#endif
