//****************************************************************************
//* MODULE:         Gfx
//* FILENAME:       BaseAnimController.cpp
//* OWNER:          Gary Jesdanun
//* CREATION DATE:  2/06/2003
//****************************************************************************

#include <Gfx/baseanimcontroller.h>

#include <Gel/Components/skeletoncomponent.h>
#include <Gel/Object/compositeobject.h>

#include <Gel/Scripting/script.h>
#include <Gel/Scripting/struct.h>
							 
#include <Gfx/blendchannel.h>
#include <Gfx/Skeleton.h>
						  
namespace Gfx
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CBaseAnimController::CBaseAnimController( CBlendChannel* pBlendChannel ) : mp_blendChannel( pBlendChannel )
{
	m_name = 0;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CBaseAnimController::~CBaseAnimController()
{
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CBaseAnimController::InitFromStructure( Script::CStruct* pParams )
{
	pParams->GetChecksum( Crc::ConstCRC("id"), &m_name, Script::NO_ASSERT );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CBaseAnimController::Update()
{
	Dbg_Assert( 0 );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CBaseAnimController::GetPose( Gfx::CPose* pResultPose )
{
	(void)pResultPose;
	// not handled
	return false;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CBaseAnimController::GetDebugInfo( Script::CStruct* p_info )
{
	(void)p_info;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

EAnimFunctionResult CBaseAnimController::CallMemberFunction( uint32 Checksum, Script::CStruct* pParams, Script::CScript* pScript )
{
	(void)Checksum;
	(void)pParams;
	(void)pScript;
	return AF_NOT_EXECUTED;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

Obj::CCompositeObject* CBaseAnimController::GetObj()
{
	return mp_blendChannel->GetObj();
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

Gfx::CSkeleton* CBaseAnimController::GetSkeleton()
{
	Obj::CSkeletonComponent* pSkeletonComponent = GetSkeletonComponentFromObject( GetObj() );
	if ( pSkeletonComponent )
	{
		return pSkeletonComponent->GetSkeleton();
	}

	return nullptr;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

}
