// Create-A-Trick goal!

#include <Sk/Modules/Skate/CATGoal.h>
#include <Sk/Modules/Skate/GoalManager.h>

namespace Game
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CCatGoal::CCatGoal( Script::CStruct* pParams ) : CGoal( pParams )
{
	// uh...
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CCatGoal::~CCatGoal()
{
	// hmm...
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool CCatGoal::Activate()
{
	return CGoal::Activate();
}
	
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CCatGoal::Deactivate( bool force, bool affect_tree )
{
	return CGoal::Deactivate( force, affect_tree );
}


}	// namespace game
