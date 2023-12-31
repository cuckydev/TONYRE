//****************************************************************************
//* MODULE:         Gel/Components
//* FILENAME:       CameraComponent.cpp
//* OWNER:          Dave Cowling
//* CREATION DATE:  02/21/03
//****************************************************************************

#include <Gel/Components/CameraComponent.h>

#include <Gel/Object/compositeobject.h>
#include <Gel/Object/compositeobjectmanager.h>
#include <Gel/Scripting/checksum.h>
#include <Gel/Scripting/script.h>
#include <Gel/Scripting/struct.h>

namespace Obj
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CBaseComponent* CCameraComponent::s_create()
{
	return static_cast< CBaseComponent* >( new CCameraComponent );	
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CCameraComponent::CCameraComponent() : CBaseComponent()
{
	SetType( CRC_CAMERA );

	// Enabled by default.
	m_enabled = true;

	// Create and attach a Gfx::Camera.
	mp_camera = new Gfx::Camera();
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CCameraComponent::~CCameraComponent()
{
	// Destroy the Gfx::Camera.
	delete mp_camera;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CCameraComponent::InitFromStructure( Script::CStruct* pParams )
{
	(void)pParams;

	// cameras must have a very low priority to insure that all objects update before they do (most importantly, the skater)
	CCompositeObjectManager::Instance()->SetObjectPriority(*GetObj(), -1000);
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CCameraComponent::RefreshFromStructure( Script::CStruct* pParams )
{
	InitFromStructure(pParams);
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CCameraComponent::Update()
{
	if( m_enabled )
	{
		// Use the position and orientation of the parent object to position and orient the attached camera.
		Mth::Vector pos = GetObj()->GetPos();
		Mth::Matrix mat = GetObj()->GetMatrix();

		// Set the Display pos of the object to the actual pos, so we can attach a model
		// to the camera
		GetObj()->SetDisplayMatrix(mat);

		mp_camera->SetPos( pos );
		mp_camera->SetMatrix( mat );
	}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CBaseComponent::EMemberFunctionResult CCameraComponent::CallMemberFunction( uint32 Checksum, Script::CStruct* pParams, Script::CScript* pScript )
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
void CCameraComponent::GetDebugInfo(Script::CStruct *p_info)
{
#ifdef	__DEBUG_CODE__
	Dbg_MsgAssert(p_info,("nullptr p_info sent to CCameraComponent::GetDebugInfo"));

	// Add any script components to the p_info structure,
	// and they will be displayed in the script debugger (qdebug.exe)
	// you will need to add the names to debugger_names.q, if they are not existing checksums

	/*	Example:
	p_info->AddInteger("m_never_suspend",m_never_suspend);
	p_info->AddFloat("m_suspend_distance",m_suspend_distance);
	*/
	
	// We call the base component's GetDebugInfo, so we can add info from the common base component.
	CBaseComponent::GetDebugInfo(p_info);	  
#endif				 
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CCameraComponent::Enable( bool enable )
{
	m_enabled = enable;

	// Go through and enable other attached components?
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
const Mth::Vector &CCameraComponent::GetPosition( void ) const
{
	return GetObj()->GetPos();
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CCameraComponent::SetPosition( Mth::Vector& pos )
{
 	GetObj()->SetPos( pos );
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
Mth::Matrix& CCameraComponent::GetMatrix( void )
{
	return GetObj()->GetMatrix();
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CCameraComponent::StoreOldPosition( void )
{
	if( mp_camera )
	{
		mp_camera->StoreOldPos();
	}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CCameraComponent::SetHFOV( float hfov )
{
	if( mp_camera )
	{
		mp_camera->SetHFOV( hfov );
	}
}



}