//****************************************************************************
//* MODULE:         Gel/Components
//* FILENAME:       StaticVehicleComponent.cpp
//* OWNER:          Dan
//* CREATION DATE:  8/6/3
//****************************************************************************

#include <Gel/Components/StaticVehicleComponent.h>
#include <Gel/Components/modelcomponent.h>
#include <Gel/Components/skeletoncomponent.h>

#include <Gel/Object/compositeobject.h>
#include <Gel/Scripting/checksum.h>
#include <Gel/Scripting/script.h>
#include <Gel/Scripting/struct.h>

#include <Gfx/NxHierarchy.h>
#include <Gfx/NxModel.h>
#include <Gfx/Skeleton.h>

namespace Obj
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
CBaseComponent* CStaticVehicleComponent::s_create()
{
	return static_cast< CBaseComponent* >( new CStaticVehicleComponent );	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CStaticVehicleComponent::CStaticVehicleComponent() : CBaseComponent()
{
	SetType( CRC_STATICVEHICLE );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
CStaticVehicleComponent::~CStaticVehicleComponent()
{
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CStaticVehicleComponent::InitFromStructure( Script::CStruct* pParams )
{
	(void)pParams;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CStaticVehicleComponent::Finalize()
{
	CModelComponent* p_model_component = static_cast< CModelComponent* >(GetModelComponentFromObject(GetObj()));
	Dbg_Assert(p_model_component);
	Nx::CModel* p_model = p_model_component->GetModel();
	Dbg_Assert(p_model);
	Nx::CHierarchyObject* p_hierarchy_objects = p_model->GetHierarchy();
	Dbg_Assert(p_hierarchy_objects);
	
	Mth::Vector p_wheels [ CVehicleComponent::vVP_NUM_WHEELS ];
	
	for (int n = CVehicleComponent::vVP_NUM_WHEELS; n--; )
	{
		Mth::Vector& wheel_pos = p_wheels[n];
		
		Mth::Matrix wheel_matrix = (p_hierarchy_objects + 2 + n)->GetSetupMatrix();
		
		// rotate out of max coordinate system
		wheel_pos[X] = -wheel_matrix[W][X];
		wheel_pos[Y] = wheel_matrix[W][Z];
		wheel_pos[Z] = -wheel_matrix[W][Y];
		wheel_pos[W] = 1.0f;
	}
	
	Mth::Matrix body_matrix = (p_hierarchy_objects + 1)->GetSetupMatrix();
	Mth::Vector body_pos;
	body_pos[X] = -body_matrix[W][X];
	body_pos[Y] = body_matrix[W][Z];
	body_pos[Z] = -body_matrix[W][Y];
	body_pos[W] = 1.0f;
	
	CSkeletonComponent* p_skeleton_component = static_cast< CSkeletonComponent* >(GetSkeletonComponentFromObject(GetObj()));
	Dbg_Assert(p_skeleton_component);
	Dbg_Assert(p_skeleton_component->GetSkeleton());
	Mth::Matrix* p_matrices = p_skeleton_component->GetSkeleton()->GetMatrices();
	for (int i = 0; i < p_skeleton_component->GetSkeleton()->GetNumBones(); i++)
	{
		Mth::Matrix& matrix = p_matrices[i];
		
		// setup the matrix for each bone in the skeleton
		
		// shadow
		if (i == 0)
		{
			matrix.Zero();
		}
		
		// body
		else if (i == 1)
		{
			matrix.Zero();
			matrix[X][X] = 1.0f;
			matrix[Y][Z] = -1.0f;
			matrix[Z][Y] = 1.0f;
			matrix[W] = body_pos;
		}
		
		// wheel
		else
		{
			Mth::Vector& wheel_pos = p_wheels[i - 2];
			
			matrix.Zero();
			matrix[X][X] = -1.0f;
			matrix[Y][Z] = 1.0f;
			matrix[Z][Y] = 1.0f;
			matrix[W] = wheel_pos;
		}
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CStaticVehicleComponent::RefreshFromStructure( Script::CStruct* pParams )
{
	InitFromStructure(pParams);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CStaticVehicleComponent::Update()
{
	Suspend(true);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CBaseComponent::EMemberFunctionResult CStaticVehicleComponent::CallMemberFunction( uint32 Checksum, Script::CStruct* pParams, Script::CScript* pScript )
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

void CStaticVehicleComponent::GetDebugInfo(Script::CStruct *p_info)
{
	Dbg_MsgAssert(p_info,("nullptr p_info sent to CStaticVehicleComponent::GetDebugInfo"));
	
	CBaseComponent::GetDebugInfo(p_info);	  
}
	
}
