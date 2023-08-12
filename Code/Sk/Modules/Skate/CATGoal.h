// Create-A-Trick goal!

#pragma once

#include <Core/Defines.h>

#include <Sk/Modules/Skate/GoalManager.h>

namespace Game
{

class CCatGoal : public CGoal
{

public:
						CCatGoal( Script::CStruct* pParams );
	virtual				~CCatGoal();

	bool				Activate();
	bool				Deactivate( bool force = false, bool affect_tree = true );
protected:
};

}
