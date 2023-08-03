// find x gaps
#include <sk/modules/skate/GoalManager.h>
#include <sk/modules/skate/FindGapsGoal.h>

#include <sk/objects/skater.h>

#include <sk/modules/skate/skate.h>
#include <sk/modules/skate/score.h>

// #include <gel/scripting/utils.h>

namespace Game
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CFindGapsGoal::CFindGapsGoal( Script::CStruct* pParams ) : CGoal( pParams )
{
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CFindGapsGoal::~CFindGapsGoal()
{
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool CFindGapsGoal::Activate()
{
	mp_params->RemoveComponent( Crc::ConstCRC("completedGaps") );
	Script::CStruct* pCompletedGaps = new Script::CStruct();
	mp_params->AddStructure( Crc::ConstCRC("completedGaps"), pCompletedGaps );
	delete pCompletedGaps;

	mp_params->AddInteger( Crc::ConstCRC("num_gaps_found"), 0 );
	mp_params->AddInteger( Crc::ConstCRC("number_collected"), 0 );

	int num_gaps_to_find;
	mp_params->GetInteger( Crc::ConstCRC("num_gaps_to_find"), &num_gaps_to_find, Script::ASSERT );
	Dbg_MsgAssert( num_gaps_to_find > 0, ( "find gaps goal activated but num_gaps_to_find <= 0!" ) );

	return CGoal::Activate();
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool CFindGapsGoal::Deactivate( bool force, bool affect_tree )
{
	return CGoal::Deactivate();
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CFindGapsGoal::CheckGaps()
{
	// printf("CFindGapsGoal::CheckGaps\n");
	Mdl::Skate* skate_mod = Mdl::Skate::Instance();
	Obj::CSkater* pSkater = skate_mod->GetLocalSkater();

	Script::CStruct* pCompletedGaps;
	mp_params->GetStructure( Crc::ConstCRC("completedGaps"), &pCompletedGaps, Script::ASSERT );

	int num_gaps_found;
	mp_params->GetInteger( Crc::ConstCRC("num_gaps_found"), &num_gaps_found, Script::ASSERT );

	Mdl::Score* pScore = pSkater->GetScoreObject();
	int numTricks = pScore->GetCurrentTrickCount();
	bool found_gap = false;
	for ( int i = 0; i < numTricks; i++ )
	{
		if ( pScore->TrickIsGap( i ) )
		{
			uint32 gap_name = pScore->GetTrickId( i );
			if ( !pCompletedGaps->ContainsComponentNamed( gap_name ) )
			{
				pCompletedGaps->AddInteger( gap_name, 1 );
				num_gaps_found++;
				found_gap = true;
			}
		}
	}
	mp_params->AddInteger( Crc::ConstCRC("num_gaps_found"), num_gaps_found );
	mp_params->AddInteger( Crc::ConstCRC("number_collected"), num_gaps_found );

	if ( found_gap )
	{
		Script::CStruct* pScriptParams = new Script::CStruct();
		pScriptParams->AddChecksum( Crc::ConstCRC("goal_id"), GetGoalId() );
		Script::RunScript( Crc::ConstCRC("goal_find_gaps_found_gap"), pScriptParams );
		delete pScriptParams;
	}
}


}	// namespace Game
