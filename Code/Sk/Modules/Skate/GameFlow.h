/*****************************************************************************
**																			**
**			              Neversoft Entertainment.			                **
**																		   	**
**				   Copyright (C) 1999 - All Rights Reserved				   	**
**																			**
******************************************************************************
**																			**
**	Project:		PS2														**
**																			**
**	Module:			Skate													**
**																			**
**	File name:		Skate/GameFlow.h										**
**																			**
**	Created by:		04/27/01	-	gj										**
**																			**
**	Description:	Defines various game flows								**
**																			**
*****************************************************************************/

#ifndef __MODULES_SKATE_GAMEFLOW_H
#define __MODULES_SKATE_GAMEFLOW_H

/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/


#ifndef __GEL_OBJECT_H
#include <gel/object.h>
#endif

/*****************************************************************************
**								   Defines									**
*****************************************************************************/

namespace Mdl
{
 


/*****************************************************************************
**							Class Definitions								**
*****************************************************************************/

class  CGameFlow  : public Spt::Class
{
	

	public:
		CGameFlow();
		virtual						~CGameFlow();
		void						Reset( uint32 script_checksum );
		void						Update();
		bool						Pause( bool paused );

		void						SetTesterScript(uint32 testerScript, Script::CStruct *p_params);
		bool						KillTesterScript();

	protected:
		bool						m_paused;
		Script::CScript*			mp_gameFlowScript;
		bool						m_requestNewScript;
		uint32						m_requestedScript;
		
		Script::CScript*			mp_tester_script;
};

/*****************************************************************************
**							 Private Declarations							**
*****************************************************************************/


/*****************************************************************************
**							  Private Prototypes							**
*****************************************************************************/


/*****************************************************************************
**							  Public Declarations							**
*****************************************************************************/

/*****************************************************************************
**							   Public Prototypes							**
*****************************************************************************/

/*****************************************************************************
**						Inline Functions									**
*****************************************************************************/


} // namespace Mdl

#endif // __MODULES_SKATE_GAMEFLOW_H