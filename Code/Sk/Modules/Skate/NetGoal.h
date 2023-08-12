#ifndef __SK_MODULES_SKATE_NETGOAL_H__
#define __SK_MODULES_SKATE_NETGOAL_H__

#ifndef __CORE_DEFINES_H
    #include <Core/Defines.h>
#endif

#include <Sk/Modules/Skate/GoalManager.h>

namespace Game
{


class CNetGoal : public CGoal
{

public:
					CNetGoal( Script::CStruct* pParams );
	virtual			~CNetGoal();
	
	bool			Update();
	bool			Deactivate( bool force = false, bool affect_tree = true );
	bool			Activate();
	bool			IsExpired();
	void			Expire();

protected:
	bool			m_initialized;
};

}

#endif
