// horse goal subclass

#include <Sk/Modules/Skate/GoalManager.h>
#include <Sk/Modules/Skate/HorseGoal.h>

#include <Sk/Modules/Skate/skate.h>
#include <Sk/Modules/Skate/score.h>

#include <Gel/Scripting/struct.h>
#include <Gel/Scripting/array.h>

#include <Sk/Objects/skater.h>

namespace Game
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
CHorseGoal::CHorseGoal( Script::CStruct* pParams ) : CGoal( pParams )
{
	// nothing special
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
CHorseGoal::~CHorseGoal()
{
	// nothing yet
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
void CHorseGoal::CheckScore()
{
	// get the right flag
	Script::CArray* pHorseSpots;
	mp_params->GetArray("horse_spots", &pHorseSpots, Script::ASSERT);

	int score;
	uint32 flag;

	size_t size = pHorseSpots->GetSize();
	if (size == 0)
		return;

	size_t i = 0;
	while (1)
	{
		Script::CStruct *pSpot = pHorseSpots->GetStructure(i);
		pSpot->GetChecksum("flag", &flag, Script::ASSERT);

		int flag_value;
		mp_goalFlags->GetInteger(flag, &flag_value, Script::ASSERT);
		
		// find the first unset flag
		if ( flag_value == 0 )
		{
			if (!pSpot->GetInteger( "score", &score, Script::NO_ASSERT))
				mp_params->GetInteger( "score", &score, Script::ASSERT);
			break;
		}

		if (++i == size)
			return;
	}

	// check the score
	Mdl::Skate *skate_mod = Mdl::Skate::Instance();
	Obj::CSkater* pSkater = skate_mod->GetLocalSkater();
	Mdl::Score* pScore = pSkater->GetScoreObject();

	int last_score_landed = pScore->GetLastScoreLanded();
	if (last_score_landed > 0)
	{
		uint32 goalId = GetGoalId();
		CGoalManager* pGoalManager = GetGoalManager();
		if ( last_score_landed > score )
		{			
			pGoalManager->SetGoalFlag(goalId, flag, 1);
			pGoalManager->NextTourSpot(goalId);
		}
		else
			pGoalManager->LoseGoal(goalId);
	}
	mp_params->AddInteger("should_check_trick", 0);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
bool CHorseGoal::ShouldExpire()
{
	int should_check_trick = 0;
	mp_params->GetInteger( "should_check_trick", &should_check_trick, Script::ASSERT );

	if ( should_check_trick == 1 )
		return false;
	
	return CGoal::ShouldExpire();
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
bool CHorseGoal::IsExpired()
{
	int should_check_trick = 0;
	mp_params->GetInteger( "should_check_trick", &should_check_trick, Script::ASSERT );

	if ( should_check_trick == 1 )
		return false;
	
	return CGoal::IsExpired();
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
void CHorseGoal::Expire()
{
	CGoal::Expire();
}

}	// namespace Game
