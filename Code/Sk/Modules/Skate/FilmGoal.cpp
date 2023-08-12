// filming goal

#include <Sk/Modules/Skate/GoalManager.h>
#include <Sk/Modules/Skate/FilmGoal.h>
#include <Sk/Modules/Skate/skate.h>

#include <Sk/Objects/skater.h>

#include <Gel/Object/compositeobject.h>

#include <Gel/Components/modelcomponent.h>

#include <Gel/Scripting/checksum.h>

#include <Gfx/nx.h>
#include <Gfx/NxModel.h>

namespace Game
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CFilmGoal::CFilmGoal( Script::CStruct* pParams ) : CGoal( pParams )
{
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
CFilmGoal::~CFilmGoal()
{
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool CFilmGoal::Activate()
{
	m_timeOnCamera = 0;
	m_timeRequired = m_totalTime = 0;
	m_numShotsRequired = 0;
	m_filming = false;

	// script param for displaying time on camera...
	mp_params->AddInteger( Crc::ConstCRC( "time_on_camera" ), 0 );
	
	int time_required;
	if ( mp_params->GetInteger( Crc::ConstCRC("total_time_required"), &time_required, Script::NO_ASSERT ) )
	{
		m_timeRequired = (Tmr::Time)( time_required * 1000 );
		int total_time;
		mp_params->GetInteger( Crc::ConstCRC("time"), &total_time, Script::ASSERT );
		m_totalTime *= (Tmr::Time)( total_time * 1000 );
	}
	else if ( !mp_params->GetInteger( Crc::ConstCRC("total_shots_required"), &m_numShotsRequired, Script::NO_ASSERT ) )
	{
		Dbg_MsgAssert( 0, ( "Film goal %s requires either total_time_required or total_shots_required", Script::FindChecksumName( GetGoalId() ) ) );
	}	
	return CGoal::Activate();
}


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool CFilmGoal::Update()
{
	mp_params->AddInteger( Crc::ConstCRC("last_time_on_camera"), (int)m_timeOnCamera );

    if ( IsActive() && !IsPaused() )
	{
		// check if they're still looking at the target object
		bool should_win = false;
		if ( m_filming )
		{
			if ( target_object_visible() )
			{
				m_timeOnCamera += (Tmr::Time)( Tmr::FrameLength() * 1000 );
				
				// script param for displaying time on camera...
				mp_params->AddInteger( Crc::ConstCRC( "time_on_camera" ), (int)m_timeOnCamera );
			}
			// printf( "on camera: %i, required: %i\n", (int)m_timeOnCamera, (int)m_timeRequired );
	
			if ( m_timeOnCamera >= m_timeRequired )
			{
				should_win = true;
			}
			else if ( m_timeRequired - m_timeOnCamera > m_timeLeft )
			{
				// can't possibly win!
				CGoalManager* pGoalManager = GetGoalManager();
				Dbg_Assert( pGoalManager );
				return pGoalManager->LoseGoal( GetGoalId() );
			}
		}
		else if ( m_numShotsRequired && m_numShotsAchieved >= m_numShotsRequired )
		{
			should_win = true;
		}
	
		if ( should_win )
		{
			CGoalManager* pGoalManager = GetGoalManager();
			Dbg_Assert( pGoalManager );
			return pGoalManager->WinGoal( GetGoalId() );		
		}
		else
			return CGoal::Update();
	}
	else
		return CGoal::Update();
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
bool CFilmGoal::Deactivate( bool force, bool affect_tree )
{
	return CGoal::Deactivate( force, affect_tree );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CFilmGoal::CheckpointHit()
{
	Dbg_MsgAssert( m_numShotsRequired, ( "GoalManager_FilmCheckpoint called on a non-checkpoint goal." ) );
	if ( target_object_visible() )
	{
		m_numShotsAchieved++;

		if ( m_numShotsAchieved > m_numShotsRequired )
		{
			CGoalManager* pGoalManager = GetGoalManager();
			Dbg_Assert( pGoalManager );
			pGoalManager->WinGoal( GetGoalId() );
		}
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
// does a visibility check as well as a distance check - you can't just
// look at him from a mile away
bool CFilmGoal::target_object_visible()
{
	uint32 target_obj_id;
	mp_params->GetChecksum( Crc::ConstCRC( "film_target" ), &target_obj_id, Script::ASSERT );
	Obj::CCompositeObject* pTargetObj = (Obj::CCompositeObject*)Obj::ResolveToObject( target_obj_id );
	Dbg_Assert( pTargetObj );

	bool visible = false;
	if ( pTargetObj )
	{
		Obj::CModelComponent* pTargetObjModelComponent = GetModelComponentFromObject( pTargetObj );
		Mth::Vector sphere = pTargetObjModelComponent->GetModel()->GetBoundingSphere();
		Mth::Vector position = sphere;
		position[3] = 1.0f;
		position *= pTargetObj->GetMatrix();
		position += pTargetObj->GetPos();
		//if ( ( Nx::CEngine::sIsVisible( position, sphere[3] ) ) )
		if ( ( Nx::CEngine::sIsVisible( position, 6.0f ) ) ) // TT#2555 (Mick), use a 6 inch radius sphere te ensure we can really see him
		{
			// get the cam
			Mdl::Skate * skate_mod = Mdl::Skate::Instance();
			Obj::CSkater* pSkater = skate_mod->GetLocalSkater();
			Dbg_Assert( pSkater );
			Gfx::Camera* pCurrentCamera = pSkater->GetActiveCamera();

			float distance_to_target = Mth::Distance( pCurrentCamera->GetPos(), pTargetObj->GetPos() );
			int max_distance;
			mp_params->GetInteger( Crc::ConstCRC("max_distance_to_target"), &max_distance, Script::ASSERT );
			if ( distance_to_target < (float)max_distance )
			{
				visible = true;
			}
		}
	}
	return visible;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void CFilmGoal::StartFilming()
{
	Dbg_MsgAssert( m_timeRequired, ( "StartFilming called on a non-filming goal." ) );
	m_filming = true;
}

}	// namespace Game

