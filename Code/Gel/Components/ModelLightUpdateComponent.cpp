//****************************************************************************
//* MODULE:         Gel/Components
//* FILENAME:       ModelLightUpdateComponent.cpp
//* OWNER:          Garrett
//* CREATION DATE:  07/10/03
//****************************************************************************

// The CModelLightUpdateComponent class is used to update the brightness of
// the model lights if nothing else is currently doing it.  Because it has
// to do extra collision checks, this component should only be used if there
// is no other way to get the brightness from an existing feeler.  For now,
// all you need to do is create the component on an object that already has
// a ModelComponent with "UseModelLights" set in the InitStructure.

#include <Gel/Components/ModelLightUpdateComponent.h>
#include <Gel/Components/modelcomponent.h>

#include <Gfx/NxLight.h>
#include <Gfx/NxModel.h>

#include <Gel/Object/compositeobject.h>
#include <Gel/Scripting/checksum.h>
#include <Gel/Scripting/script.h>
#include <Gel/Scripting/struct.h>

#include <Sk/Engine/feeler.h>

namespace Obj
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
CBaseComponent* CModelLightUpdateComponent::s_create()
{
	return static_cast< CBaseComponent* >( new CModelLightUpdateComponent );	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CModelLightUpdateComponent::CModelLightUpdateComponent() : CBaseComponent()
{
	SetType( CRC_MODELLIGHTUPDATE );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
CModelLightUpdateComponent::~CModelLightUpdateComponent()
{
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CModelLightUpdateComponent::InitFromStructure( Script::CStruct* pParams )
{
	(void)pParams;
	// ** Add code to parse the structure, and initialize the component

}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CModelLightUpdateComponent::Finalize()
{
	mp_model_component =  GetModelComponentFromObject( GetObj() );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CModelLightUpdateComponent::RefreshFromStructure( Script::CStruct* pParams )
{
	InitFromStructure(pParams);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CModelLightUpdateComponent::Update()
{
	// Find the closest ground collision and extract the brightness from it.
	// logic extracted from CAdjustComponent::uber_frig

	CFeeler feeler;
	
	feeler.m_start = GetObj()->m_pos;
	feeler.m_end = GetObj()->m_pos;

	// Very minor adjustment to move origin away from vert walls
	feeler.m_start += GetObj()->m_matrix[Y] * 0.001f;
	
	feeler.m_start[Y] += 8.0f;
	feeler.m_end[Y] -= FEET(400);
		   
	if (!feeler.GetCollision()) return;

	Dbg_Assert(mp_model_component);

	if (feeler.IsBrightnessAvailable())
	{
		Nx::CModelLights *p_model_lights = mp_model_component->GetModel()->GetModelLights();
		if (p_model_lights)
		{
			p_model_lights->SetBrightness(feeler.GetBrightness());
		} 
	}
	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CBaseComponent::EMemberFunctionResult CModelLightUpdateComponent::CallMemberFunction( uint32 Checksum, Script::CStruct* pParams, Script::CScript* pScript )
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

void CModelLightUpdateComponent::GetDebugInfo(Script::CStruct *p_info)
{
	Dbg_MsgAssert(p_info,("nullptr p_info sent to CModelLightUpdateComponent::GetDebugInfo"));

	// Add any script components to the p_info structure,
	// and they will be displayed in the script debugger (qdebug.exe)
	// you will need to add the names to debugger_names.q, if they are not existing checksums

	/*	Example:
	p_info->AddInteger(Crc::ConstCRC("m_never_suspend"),m_never_suspend);
	p_info->AddFloat(Crc::ConstCRC("m_suspend_distance"),m_suspend_distance);
	*/
	
// we call the base component's GetDebugInfo, so we can add info from the common base component										 
	CBaseComponent::GetDebugInfo(p_info);	  
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
}
