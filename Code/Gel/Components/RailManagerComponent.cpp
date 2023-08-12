//****************************************************************************
//* MODULE:         Gel/Components
//* FILENAME:       RailManagerComponent.cpp
//* OWNER:          Dave Cowling
//* CREATION DATE:  02/17/03
//****************************************************************************

// The CEmptyComponent class is an skeletal version of a component
// It is intended that you use this as the basis for creating new
// components.  
// To create a new component called "Watch", (CWatchComponent):
//  - copy emptycomponent.cpp/.h to watchcomponent.cpp/.h
//  - in both files, search and replace "Empty" with "Watch", preserving the case
//  - in WatchComponent.h, update the CRCD value of CRC_WATCH
//  - in CompositeObjectManager.cpp, in the CCompositeObjectManager constructor, add:
//		  	RegisterComponent(CRC_WATCH,			CWatchComponent::s_create); 
//  - and add the include of the header
//			#include <Gel/Components/watchcomponent.h> 
//  - Add it to build\gel.mkf, like:
//          $(NGEL)/components/WatchComponent.cpp
//  - Fill in the OWNER (yourself) and the CREATION DATE (today's date) in the .cpp and the .h files
//	- Insert code as needed and remove generic comments
//  - remove these comments
//  - add comments specfic to the component, explaining its usage
#include <Gel/Components/RailManagerComponent.h>

#include <Gel/Object/compositeobject.h>
#include <Gel/Scripting/struct.h>

#include <Gel/Components/NodeArrayComponent.h>

namespace Obj
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
// s_create is what is registered with the component factory 
// object, (currently the CCompositeObjectManager) 
// s_create	returns a CBaseComponent*, as it is to be used
// by factor creation schemes that do not care what type of
// component is being created
// **  after you've finished creating this component, be sure to
// **  add it to the list of registered functions in the
// **  CCompositeObjectManager constructor  
CBaseComponent* CRailManagerComponent::s_create()
{
	return static_cast< CBaseComponent* >( new CRailManagerComponent );	
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
// All components set their type, which is a unique 32-bit number
// (the CRC of their name), which is used to identify the component	
CRailManagerComponent::CRailManagerComponent() : CBaseComponent()
{
	SetType( CRC_RAILMANAGER );
	mp_rail_manager = nullptr;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CRailManagerComponent::~CRailManagerComponent()
{
	// Remove the CRailManager if present.
	if( mp_rail_manager )
	{
		delete mp_rail_manager;
	}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
// InitFromStructure is passed a Script::CStruct that contains a
// number of parameters to initialize this component
// this currently is the contents of a node
// but you can pass in anything you like.	
void CRailManagerComponent::InitFromStructure( Script::CStruct* pParams )
{
	(void)pParams;

	// There needs to be a NodeArrayComponent attached for the RailManagerComponent to operate.
	CNodeArrayComponent *p_nodearray_component = GetNodeArrayComponentFromObject( GetObj());
	Dbg_MsgAssert( p_nodearray_component, ( "RailManagerComponent created without NodeArrayComponent" ));

	// Remove any existing CRailManager.
	if( mp_rail_manager )
	{
		delete mp_rail_manager;
	}

	// Create a rail manager, and parse the node array for the rails.
	mp_rail_manager = new Obj::CRailManager();
	mp_rail_manager->AddRailsFromNodeArray( p_nodearray_component->GetNodeArray());
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
// RefreshFromStructure is passed a Script::CStruct that contains a
// number of parameters to initialize this component
// this currently is the contents of a node
// but you can pass in anything you like.	
void CRailManagerComponent::RefreshFromStructure( Script::CStruct* pParams )
{
	InitFromStructure( pParams );
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
// The component's Update() function is called from the CCompositeObject's 
// Update() function.  That is called every game frame by the CCompositeObjectManager
// from the s_logic_code function that the CCompositeObjectManager registers
// with the task manger.
void CRailManagerComponent::Update()
{
	// Doing nothing, so tell code to do nothing next time around
	Suspend(true);
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
// Given the "Checksum" of a script command, then possibly handle it
// if it's a command that this component will handle	
CBaseComponent::EMemberFunctionResult CRailManagerComponent::CallMemberFunction( uint32 Checksum, Script::CStruct* pParams, Script::CScript* pScript )
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
void CRailManagerComponent::GetDebugInfo( Script::CStruct *p_info )
{
#ifdef	__DEBUG_CODE__
	Dbg_MsgAssert( p_info, ("nullptr p_info sent to CRailManagerComponent::GetDebugInfo" ));

	// Add the number of Rail Manager nodes.
	if( mp_rail_manager )
	{
		p_info->AddInteger("RailManager.m_num_nodes", mp_rail_manager->GetNumNodes());
		p_info->AddString("RailManager.m_is_transformed", mp_rail_manager->IsMoving() ? "yes" : "no" );
	}

	// We call the base component's GetDebugInfo, so we can add info from the common base component.
	CBaseComponent::GetDebugInfo( p_info );
#endif				 
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

Mth::Matrix CRailManagerComponent::UpdateRailManager (   )
{
	Dbg_Assert(mp_rail_manager);

	// form a transformation matrix
	Mth::Matrix total_mat = GetObj()->GetMatrix();
	total_mat[X][W] = 0.0f;
	total_mat[Y][W] = 0.0f;
	total_mat[Z][W] = 0.0f;
	total_mat[W] = GetObj()->GetPos();
	total_mat[W][W] = 1.0f;

	mp_rail_manager->UpdateTransform(total_mat);
	
	return total_mat;
}
	
}
