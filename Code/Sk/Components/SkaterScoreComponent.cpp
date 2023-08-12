//****************************************************************************
//* MODULE:         Sk/Components
//* FILENAME:       SkaterScoreComponent.cpp
//* OWNER:          Dan
//* CREATION DATE:  3/12/3
//****************************************************************************

#include <Sk/Components/SkaterScoreComponent.h>
#include <Sk/Objects/skatercareer.h>
#include <Sk/GameNet/GameMsg.h>
#include <Sk/Modules/Skate/skate.h>

#include <Gel/Object/compositeobject.h>
#include <Gel/Scripting/checksum.h>
#include <Gel/Scripting/script.h>
#include <Gel/Scripting/struct.h>
#include <Gel/Scripting/symboltable.h>

extern bool g_CheatsEnabled;

namespace Obj
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CBaseComponent* CSkaterScoreComponent::s_create()
{
	return static_cast< CBaseComponent* >( new CSkaterScoreComponent );	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CSkaterScoreComponent::CSkaterScoreComponent() : CBaseComponent()
{
	SetType( CRC_SKATERSCORE );
	mp_score = nullptr;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
CSkaterScoreComponent::~CSkaterScoreComponent()
{
	if (mp_score)
	{
		delete mp_score;
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterScoreComponent::InitFromStructure( Script::CStruct* pParams )
{
	(void)pParams;

	Dbg_MsgAssert(GetObj()->GetType() == SKATE_TYPE_SKATER, ("CSkaterScoreComponent added to non-skater composite object"));
	
	if (!mp_score)
	{
		mp_score = new Mdl::Score();
		mp_score->SetSkaterId(GetObj()->GetID());
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterScoreComponent::RefreshFromStructure( Script::CStruct* pParams )
{
	InitFromStructure(pParams);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterScoreComponent::Update()
{
	// NOTE: in fact, non-local skaters may not need a score component at all
	if (!GetSkater()->IsLocalClient())
	{
		Suspend(true);
		return;
	}
	
	mp_score->Update();
	
	if (GetSkater()->m_always_special || Mdl::Skate::Instance()->GetCareer()->GetCheat(Crc::ConstCRC("CHEAT_ALWAYS_SPECIAL")))
	{
		// Here, set the flag. It may seem redundant, but the above line is very likely
		// to be hacked by gameshark. They probably won't notice this one, which will
		// set the flags as if they had actually enabled the cheat -- which enables us
		// to detect that it has been turned on more easily.
		Mdl::Skate::Instance()->GetCareer()->SetGlobalFlag( Script::GetInteger(Crc::ConstCRC("CHEAT_ALWAYS_SPECIAL")));
		mp_score->ForceSpecial();
		g_CheatsEnabled = true;
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CBaseComponent::EMemberFunctionResult CSkaterScoreComponent::CallMemberFunction( uint32 Checksum, Script::CStruct* pParams, Script::CScript* pScript )
{
	switch ( Checksum )
	{
		// @script | LastScoreLandedGreaterThan | Multiplayer-safe version 
		// of SkaterLastScoreLandedGreaterThan
		// Example: if LastScoreLandedGreaterThan 2000 --do cool stuff-- endif
		// @uparm 1 | Score (int)
		case Crc::ConstCRC("LastScoreLandedGreaterThan"):
		{
			int score;
			pParams->GetInteger(NO_NAME, &score, Script::ASSERT);
			return mp_score->GetLastScoreLanded() > score ? CBaseComponent::MF_TRUE : CBaseComponent::MF_FALSE;
		}
		
		// @script | LastScoreLandedLessThan | Multiplayer-safe version 
		// of SkaterLastScoreLandedLessThan
		// Example: if LastScoreLandedLessThan 2000 --do cool stuff-- endif
		// @uparm 1 | Score (int)
		case Crc::ConstCRC("LastScoreLandedLessThan"):
		{
			int score;
			pParams->GetInteger(NO_NAME, &score, Script::ASSERT);
			return mp_score->GetLastScoreLanded() < score ? CBaseComponent::MF_TRUE : CBaseComponent::MF_FALSE;
		}
		
		// @script | TotalScoreGreaterThan | Multiplayer-safe version 
		// of SkaterTotalScoreGreaterThan
		// Example: if TotalScoreGreaterThan 2000 --do cool stuff-- endif
		// @uparm 1 | Score (int)
		case Crc::ConstCRC("TotalScoreGreaterThan"):
		{
			int score;
			pParams->GetInteger(NO_NAME, &score, Script::ASSERT);
			return mp_score->GetTotalScore() > score ? CBaseComponent::MF_TRUE : CBaseComponent::MF_FALSE;
		}
			
		// @script | TotalScoreLessThan | Multiplayer-safe version 
		// of SkaterTotalScoreLessThan
		// Example: if TotalScoreLessThan 2000 --do cool stuff-- endif
		// @uparm 1 | Score (int)
		case Crc::ConstCRC("TotalScoreLessThan"):
		{
			int score;
			pParams->GetInteger(NO_NAME, &score, Script::ASSERT);
			return mp_score->GetTotalScore() < score ? CBaseComponent::MF_TRUE : CBaseComponent::MF_FALSE;
		}
			
		// @script | CurrentScorePotGreaterThan | Multiplayer-safe version 
		// of SkaterCurrentScorePotGreaterThan
		// Example: if CurrentScorePotGreaterThan 2000 --do cool stuff-- endif
		// @uparm 1 | Score (int)
		case Crc::ConstCRC("CurrentScorePotGreaterThan"):
		{
			int score;
			pParams->GetInteger(NO_NAME, &score, Script::ASSERT);
			return mp_score->GetScorePotValue() > score ? CBaseComponent::MF_TRUE : CBaseComponent::MF_FALSE;
		}

		// @script | GetTotalScore | returns the total score of the skater
		// in TotalScore
		case Crc::ConstCRC( "GetTotalScore" ):
		{
			pScript->GetParams()->AddInteger( Crc::ConstCRC( "TotalScore" ), mp_score->GetTotalScore() );
			return CBaseComponent::MF_TRUE;
		}
			
		// @script | CurrentScorePotLessThan | Multiplayer-safe version 
		// of SkaterCurrentScorePotLessThan
		// Example: if CurrentScorePotLessThan 2000 --do cool stuff-- endif
		// @uparm 1 | Score (int)
		case Crc::ConstCRC("CurrentScorePotLessThan"):
		{
			int score;
			pParams->GetInteger(NO_NAME, &score, Script::ASSERT);
			return mp_score->GetScorePotValue() < score ? CBaseComponent::MF_TRUE : CBaseComponent::MF_FALSE;
		}
		
		// @script | GetNumberOfNonGapTricks | returns number of non-gap tricks currently in the combo
		case Crc::ConstCRC("GetNumberOfNonGapTricks"):
			pScript->GetParams()->AddInteger(Crc::ConstCRC("NumberOfNonGapTricks"), mp_score->GetNumberOfNonGapTricks());
			break;
		
        // @script | GotSpecial | true if special is active
		case Crc::ConstCRC("GotSpecial"):	
			return mp_score->GetSpecialState() ? CBaseComponent::MF_TRUE : CBaseComponent::MF_FALSE;
        
		// @script | TweakTrick | 
        // @uparm 0 | tweak
		case Crc::ConstCRC("TweakTrick"):
		{
			int Tweak = 0;
			pParams->GetInteger(NO_NAME, &Tweak);
			
			mp_score->TweakTrick(Tweak);
			break;
		}
			
		// @script | IsLatestTrick | 
		case Crc::ConstCRC("IsLatestTrick"):
		{
			uint32 key_combo;
			if (pParams->GetChecksum(Crc::ConstCRC("KeyCombo"), &key_combo))
			{
				int spin = 0;
				if (pParams->GetInteger(Crc::ConstCRC("Spin"), &spin))
				{
					Dbg_MsgAssert(spin % 180 == 0, ("IsLatestTrick called with a spin value of %i which is not a multiple of 180", spin));
					spin /= 180;
				}
				
				int num_taps = 1;
				pParams->GetInteger(Crc::ConstCRC("NumTaps"), &num_taps);
				
				return mp_score->IsLatestTrick(key_combo, spin, false, num_taps) ? CBaseComponent::MF_TRUE : CBaseComponent::MF_FALSE;
			}
			else
			{
				const char* trick_text;
				if (pParams->GetString(Crc::ConstCRC("TrickText"), &trick_text))
				{
					int spin = 0;
					if (pParams->GetInteger(Crc::ConstCRC("Spin"), &spin))
					{
						Dbg_MsgAssert(spin % 180 == 0, ("IsLatestTrick called with a spin value of %i which is not a multiple of 180", spin));
						spin /= 180;
					}
					
					int num_taps = 1;
					pParams->GetInteger(Crc::ConstCRC("NumTaps"), &num_taps);
					
					return mp_score->IsLatestTrickByName(Script::GenerateCRC(trick_text), spin, false, num_taps) ? CBaseComponent::MF_TRUE : CBaseComponent::MF_FALSE;
				}
				else
				{
					Dbg_MsgAssert(false, ("IsLatestTrick must have either a KeyCombo or a TrickText parameter"));
				}
			}
			break; // NOTE: Originally fallthrough
		}

		default:
			return CBaseComponent::MF_NOT_EXECUTED;
	}
    return CBaseComponent::MF_TRUE;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterScoreComponent::GetDebugInfo(Script::CStruct *p_info)
{
#ifdef	__DEBUG_CODE__
	Dbg_MsgAssert(p_info,("nullptr p_info sent to CSkaterScoreComponent::GetDebugInfo"));
	
	CBaseComponent::GetDebugInfo(p_info);	  
#endif				 
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterScoreComponent::Reset (   )
{
	mp_score->Reset();

	mp_score->SetBalanceMeter(false);
	mp_score->SetManualMeter(false);
}

}
