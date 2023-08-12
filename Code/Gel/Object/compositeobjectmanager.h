//****************************************************************************
//* MODULE:         Gel/Object
//* FILENAME:       compositeobjectmanager.h
//* OWNER:          Mick West
//* CREATION DATE:  10/17/2002
//****************************************************************************

#ifndef __OBJECT_COMPOSITEMANAGER_H__
#define __OBJECT_COMPOSITEMANAGER_H__

#include <Core/Defines.h>
#include <Core/Support/support.h>
#include <Core/Task/Task.h>
#include <Gel/object.h>
#include <Gel/Object/compositeobject.h>
#include <Gel/objman.h>
                          
namespace Obj
{

// Pointer to member.  See Bjarne, Page 418
// not sure if we can use these instead of function pointers to static functions
// (for now, use the old fasioned way)
//typedef	CBaseComponent * (Obj::CBaseComponent *PComponent)();	// Pointer to member of CBaseComponent

struct	SRegisteredComponent
{
	uint32				mComponentID;		   		
	CBaseComponent*		(*mpCreateFunction)();
};


class CCompositeObjectManager : public Obj::CGeneralManager
{

	enum 
	{
				vMAX_COMPONENTS=128						
	};

public:
						CCompositeObjectManager();
    virtual 			~CCompositeObjectManager();

	void 				Update();
	void 				Pause( bool paused );
	
	CCompositeObject*	CreateCompositeObject();
	CCompositeObject* 	CreateCompositeObjectFromNode(Script::CArray *pArray, Script::CStruct *pNodeData, bool finalize=true);

	void				RegisterComponent(uint32 id, CBaseComponent *(p_create_function)(), void(p_register_function)() = nullptr); 
	CBaseComponent*		CreateComponent(uint32 id);
    
	CBaseComponent*		GetFirstComponentByType( uint32 id );
	void				AddComponentByType( CBaseComponent *p_component );
	void				RemoveComponentByType( CBaseComponent *p_component );

protected:
	static Tsk::Task< CCompositeObjectManager >::Code   	s_logic_code; 
	Tsk::Task< CCompositeObjectManager >*				    mp_logic_task;	

	uint32													m_num_components;
	SRegisteredComponent									m_registered_components[vMAX_COMPONENTS];

	static CBaseComponent									*mp_components_by_type[vMAX_COMPONENTS];
	
	DeclareSingletonClass( CCompositeObjectManager );
};

}

#endif
