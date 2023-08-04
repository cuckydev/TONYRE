//****************************************************************************
//* MODULE:         Gel/Components
//* FILENAME:       NodeArrayComponent.cpp
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
//			#include <gel/components/watchcomponent.h> 
//  - Add it to build\gel.mkf, like:
//          $(NGEL)/components/WatchComponent.cpp\
//  - Fill in the OWNER (yourself) and the CREATION DATE (today's date) in the .cpp and the .h files
//	- Insert code as needed and remove generic comments
//  - remove these comments
//  - add comments specfic to the component, explaining its usage
#include <gel/components/nodearraycomponent.h>

#include <gel/assman/assman.h>
#include <gel/object/compositeobject.h>
#include <gel/scripting/struct.h>

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
CBaseComponent* CNodeArrayComponent::s_create()
{
	return static_cast< CBaseComponent* >( new CNodeArrayComponent );	
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
// All components set their type, which is a unique 32-bit number
// (the CRC of their name), which is used to identify the component	
CNodeArrayComponent::CNodeArrayComponent() : CBaseComponent()
{
	SetType( CRC_NODEARRAY );

	mp_node_array = nullptr;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CNodeArrayComponent::~CNodeArrayComponent()
{
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
// InitFromStructure is passed a Script::CStruct that contains a
// number of parameters to initialize this component
// this currently is the contents of a node
// but you can pass in anything you like.	
void CNodeArrayComponent::InitFromStructure( Script::CStruct* pParams )
{
	// Obtain the model name from the structure. At a later date, perhaps the node could override the .qb name.
	const char *p_model_name = nullptr;
	if( !pParams->GetText( 0x286a8d26, &p_model_name ))
	{
		// This is currently an error.
		Dbg_MsgAssert( 0, ( "Attempting to create NodeArrayComponent from node with no model name" ));
		return;
	}

	// Generate the .qb name from the model name.
	char nodearray_filename[256];
	strcpy( nodearray_filename, "models\\" );
	strcat( nodearray_filename, p_model_name );
	char *p_ext = strstr( nodearray_filename, "." );
	if( p_ext )
	{
		strcpy( p_ext, ".qb" );
	}
	else
	{
		strcat( nodearray_filename, ".qb" );
	}

	// Ask the Asset Manager for the .qb - it will be loaded if it is not yet memory resident.
	Ass::CAssMan *p_ass_man = Ass::CAssMan::Instance();
	mp_node_array = (Script::CArray*)p_ass_man->LoadOrGetAsset( nodearray_filename, false, false, false, 0 );
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
// RefreshFromStructure is passed a Script::CStruct that contains a
// number of parameters to initialize this component
// this currently is the contents of a node
// but you can pass in anything you like.	
void CNodeArrayComponent::RefreshFromStructure( Script::CStruct* pParams )
{
	// Obtain the model name from the structure. At a later date, perhaps the node could override the .qb name.
	const char *p_model_name = nullptr;
	if( !pParams->GetText( 0x286a8d26, &p_model_name ))
	{
		// Not an error during a refresh, just exit with existing values maintained.
		return;
	}

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
void CNodeArrayComponent::Update()
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
CBaseComponent::EMemberFunctionResult CNodeArrayComponent::CallMemberFunction( uint32 Checksum, Script::CStruct* pParams, Script::CScript* pScript )
{
	switch( Checksum )
	{
/*
        // @script | DoSomething | does some functionality
		case 0xbb4ad101:		// DoSomething
			DoSomething();
			break;

        // @script | ValueIsTrue | returns a boolean value
		case 0x769260f7:		// ValueIsTrue
		{
			return ValueIsTrue() ? CBaseComponent::MF_TRUE : CBaseComponent::MF_FALSE;
		}
		break;
*/

		default:
			return CBaseComponent::MF_NOT_EXECUTED;
	}

	// the "default" case of the switch statement handles
	// unrecognized functions;  if we make it down here,
	// that means that the component already handled it
	// somehow
    return CBaseComponent::MF_TRUE;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CNodeArrayComponent::GetDebugInfo( Script::CStruct *p_info )
{
#ifdef	__DEBUG_CODE__
	Dbg_MsgAssert( p_info, ("nullptr p_info sent to CNodeArrayComponent::GetDebugInfo" ));

	// Add any script components to the p_info structure,
	// and they will be displayed in the script debugger (qdebug.exe)
	// you will need to add the names to debugger_names.q, if they are not existing checksums
	p_info->AddArray( "mp_node_array", mp_node_array );

	// We call the base component's GetDebugInfo, so we can add info from the common base component.
	CBaseComponent::GetDebugInfo( p_info );
#endif				 
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
}
