//****************************************************************************
//* MODULE:         Sk/Components
//* FILENAME:       SkaterBalanceTrickComponent.cpp
//* OWNER:          Dan
//* CREATION DATE:  328/3
//****************************************************************************

#include <Sk/Components/SkaterBalanceTrickComponent.h>
#include <Sk/Components/SkaterScoreComponent.h>

#include <Gel/Object/compositeobject.h>
#include <Gel/Components/animationcomponent.h>
#include <Gel/Scripting/checksum.h>
#include <Gel/Scripting/script.h>
#include <Gel/Scripting/struct.h>
#include <Gel/Scripting/symboltable.h>

namespace Obj
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CBaseComponent* CSkaterBalanceTrickComponent::s_create()
{
	return static_cast< CBaseComponent* >( new CSkaterBalanceTrickComponent );	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CSkaterBalanceTrickComponent::CSkaterBalanceTrickComponent() : CBaseComponent()
{
	SetType( CRC_SKATERBALANCETRICK );
	
	mp_animation_component = nullptr;
	
	mpBalanceParams = nullptr;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
CSkaterBalanceTrickComponent::~CSkaterBalanceTrickComponent()
{
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterBalanceTrickComponent::InitFromStructure( Script::CStruct* pParams )
{
	(void)pParams;

	mManual.Init(GetSkater());
	mGrind.Init(GetSkater());
	mLip.Init(GetSkater());
	mSkitch.Init(GetSkater());
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterBalanceTrickComponent::RefreshFromStructure( Script::CStruct* pParams )
{
	InitFromStructure(pParams);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterBalanceTrickComponent::Finalize (   )
{
	
	mp_animation_component = GetAnimationComponentFromObject(GetObj());
	
	Dbg_Assert(mp_animation_component);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterBalanceTrickComponent::Update()
{
	Suspend(true);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CBaseComponent::EMemberFunctionResult CSkaterBalanceTrickComponent::CallMemberFunction( uint32 Checksum, Script::CStruct* pParams, Script::CScript* pScript )
{
	switch ( Checksum )
	{
        // @script | SetWobbleDetails | gets called from the animation
		// component's PlayAnim handler (needs to come after the
		// animation has launched...)
		case Crc::ConstCRC("SetWobbleDetails"):
		{
			// Intercepts the animation component's PlayAnim member function and handle's skater specific logic
			
			// If this is a wobbling balance anim, then allow the manual or grind to programmatically wobble it.
			if (pParams->ContainsFlag(Crc::ConstCRC("Wobble")))
			{
				mManual.EnableWobble();
				mGrind.EnableWobble();
				mLip.EnableWobble();
				mSkitch.EnableWobble();
			}	
			
			Script::CStruct* p_wobble_params = Script::GetStructure(Crc::ConstCRC("DefaultWobbleParams"), Script::ASSERT);
			pParams->GetStructure(Crc::ConstCRC("WobbleParams"), &p_wobble_params);
			set_wobble_params(p_wobble_params);
			
			return CBaseComponent::MF_TRUE;
		}
		
        // @script | DoBalanceTrick | 
        // @parmopt int | Tweak | 0 | 
        // @parm name | ButtonA | 
        // @parm name | ButtonB |                       
        // @parmopt name | Type | 0 | balance trick type (NoseManual, 
        // Manual, Grind, Slide, Lip)
        // @flag DoFlipCheck | If set, the range anim will be played backwards if the skater is flipped.
        // @flag PlayRangeAnimBackwards | If set, the range anim will be played backwards. Can be
		// used in conjunction with DoFlipCheck. Ie, if both flags are set, then the anim will be
		// played forwards if the skater is flipped.
		// @flag ClearCheese | If set this will reset any previous cheese.
        // @parmopt structure | BalanceParams | | If not specified then the balance trick will use
		// the params defined by the script globals LipParams, or ManualParams etc depending on the
		// Type value. 
		case Crc::ConstCRC("DoBalanceTrick"):	  
		{
			if (mpBalanceParams)
			{
				delete mpBalanceParams;
				mpBalanceParams = nullptr;
			}
			Script::CStruct* p_balance_params = nullptr;
			if (pParams->GetStructure(Crc::ConstCRC("BalanceParams"), &p_balance_params))
			{
				set_balance_trick_params(p_balance_params);
			}
			
			int Tweak = 0;
			pParams->GetInteger(Crc::ConstCRC("Tweak"), &Tweak);
			
			uint32 ButtonA = 0;
			uint32 ButtonB = 0;
			pParams->GetChecksum(Crc::ConstCRC("ButtonA"), &ButtonA, Script::ASSERT);
			pParams->GetChecksum(Crc::ConstCRC("ButtonB"), &ButtonB, Script::ASSERT);
			
			uint32 NewBalanceTrickType = 0;
			pParams->GetChecksum(Crc::ConstCRC("Type"), &NewBalanceTrickType);

			// Do nothing if already doing the same type of balance trick.  This is so that the meter does not glitch when switching to
			// a balance trick from another balance trick where there is no StopBalanceTrick script command in between.
			if (mBalanceTrickType == NewBalanceTrickType) break;
			mBalanceTrickType = NewBalanceTrickType;
			
			bool DoFlipCheck = pParams->ContainsFlag(Crc::ConstCRC("DoFlipCheck"));
			bool PlayRangeAnimBackwards = pParams->ContainsFlag(Crc::ConstCRC( "PlayRangeAnimBackwards"));
			
			// This needed because for the extra grind tricks (eg left triangle triangle) the
			// DoBalanceTrick command gets called twice in a row, once for the first time the grind is detected
			// by the first triangle, then again once the extra trick is detected.
			// In that case the cheese needs to be reset otherwise it thinks you've jumped and re-railed & you
			// fall off straight away.
			bool clear_cheese=pParams->ContainsFlag(Crc::ConstCRC("ClearCheese"));
				
			switch (mBalanceTrickType)
			{
				case 0:
					Dbg_MsgAssert(false, ("\n%s\nMust specify a type in DoBalanceTrick, eg Type=NoseManual", pScript->GetScriptInfo()));
					break;
					
				case Crc::ConstCRC( "NoseManual"):
				case Crc::ConstCRC("Manual"):
					if (clear_cheese)
					{
						mManual.Reset();
					}	
					mManual.UpdateRecord();
					mManual.SetUp(ButtonA, ButtonB, Tweak, DoFlipCheck, PlayRangeAnimBackwards);
					break;
					
				case Crc::ConstCRC("Grind"):
				case Crc::ConstCRC("Slide"):
					if (clear_cheese)
					{
						mGrind.Reset();
					}	
					mGrind.UpdateRecord();
					mGrind.SetUp(ButtonA, ButtonB, Tweak, DoFlipCheck, PlayRangeAnimBackwards);
					break;
					
				case Crc::ConstCRC("Lip"):
					if (clear_cheese)
					{
						mLip.Reset();
					}	
					mLip.UpdateRecord();
					mLip.SetUp(ButtonA, ButtonB, Tweak, DoFlipCheck, PlayRangeAnimBackwards);
					break;
					
				case Crc::ConstCRC("Skitch"):
					if (clear_cheese)
					{
						mSkitch.Reset();
					}	
					mSkitch.UpdateRecord();
					mSkitch.SetUp(ButtonA, ButtonB, Tweak, DoFlipCheck, PlayRangeAnimBackwards);
					break;
					
				default:	
					Dbg_Assert(false);
					break;
			}		
			break;
		}
		
        // @script | AdjustBalance | Make minor adjustments, nudges, to the current balance trick, if any
        // @parmopt float | TimeAdd | 0.0 | 
        // @parmopt float | LeanAdd | 0.0 | 
        // @parmopt float | SpeedAdd | 0.0 | 
        // @parmopt float | TimeMult | 1.0 | 
        // @parmopt float | LeanMult | 1.0 | 
        // @parmopt float | SpeedMult | 1.0 | 
		case Crc::ConstCRC("AdjustBalance"):
		{
			if (mBalanceTrickType)
			{
				float TimeMult = 1.0f;
				float LeanMult = 1.0f;
				float SpeedMult = 1.0f;
				float TimeAdd = 0.0f;
				float LeanAdd = 0.0f;
				float SpeedAdd = 0.0f;
				pParams->GetFloat(Crc::ConstCRC("TimeAdd"), &TimeAdd);
				pParams->GetFloat(Crc::ConstCRC( "LeanAdd"), &LeanAdd);
				pParams->GetFloat(Crc::ConstCRC("SpeedAdd"), &SpeedAdd);
				pParams->GetFloat(Crc::ConstCRC("TimeMult"), &TimeMult);
				pParams->GetFloat(Crc::ConstCRC("LeanMult"), &LeanMult);
				pParams->GetFloat(Crc::ConstCRC("SpeedMult"), &SpeedMult);

				// Get whichever balance trick we are doing	
				CManual* pBalance;
				switch (mBalanceTrickType)
				{
					case Crc::ConstCRC("Grind"):
					case Crc::ConstCRC("Slide"):
						pBalance = &mGrind;
						break;
						
					case Crc::ConstCRC("Lip"):
						pBalance = &mLip;
						break;
					
					case Crc::ConstCRC("Skitch"):
						pBalance = &mSkitch;
						break;
						
					case Crc::ConstCRC( "NoseManual"):
					case Crc::ConstCRC("Manual"):
						pBalance = &mManual;
						break;
						
					default:
						pBalance = nullptr;
						Dbg_Assert(false);
				}
	
				pBalance->mManualTime *= TimeMult;
				pBalance->mManualTime += TimeAdd;
				if (pBalance->mManualTime < 0.0f)
				{
					pBalance->mManualTime = 0.0f;
				}
				pBalance->mManualLean *= LeanMult;
				pBalance->mManualLean += LeanAdd * Mth::Sgn(pBalance->mManualLean);
				pBalance->mManualLeanDir *= SpeedMult;
				pBalance->mManualLeanDir += SpeedAdd  * Mth::Sgn(pBalance->mManualLeanDir);
			}
			break;
		}

        // @script | StopBalanceTrick | 
		case Crc::ConstCRC("StopBalanceTrick"):
			stop_balance_trick();
			break;
		
        // @script | StartBalanceTrick | 
		case Crc::ConstCRC("StartBalanceTrick"):
			mDoingBalanceTrick = true;
			break;
			
		case Crc::ConstCRC("SwitchOffBalanceMeter"):
		{
			CSkaterScoreComponent* p_score_component = GetSkaterScoreComponentFromObject(GetObj());
			Dbg_Assert(p_score_component);
			
			p_score_component->GetScore()->SetBalanceMeter(false);
			p_score_component->GetScore()->SetManualMeter(false);
			
			mManual.SwitchOffMeters();
			mGrind.SwitchOffMeters();
			mLip.SwitchOffMeters();
			mSkitch.SwitchOffMeters();
			break;
		}
			
        // @script | SwitchOnBalanceMeter |
		case Crc::ConstCRC("SwitchOnBalanceMeter"):
			mManual.SwitchOnMeters();
			mGrind.SwitchOnMeters();
			mLip.SwitchOnMeters();
			mSkitch.SwitchOnMeters();
			break;
			
		default:
			return CBaseComponent::MF_NOT_EXECUTED;
	}
    return CBaseComponent::MF_TRUE;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterBalanceTrickComponent::GetDebugInfo(Script::CStruct *p_info)
{
#ifdef	__DEBUG_CODE__
	Dbg_MsgAssert(p_info,("nullptr p_info sent to CSkaterBalanceTrickComponent::GetDebugInfo"));
	
	p_info->AddChecksum("mDoingBalanceTrick", mDoingBalanceTrick ? Crc::ConstCRC( "true") : Crc::ConstCRC("false"));
	p_info->AddChecksum("mBalanceTrickType", mBalanceTrickType);

	CBaseComponent::GetDebugInfo(p_info);	  
#endif				 
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterBalanceTrickComponent::ClearMaxTimes (   )
{
   	mManual.ClearMaxTime();
	mGrind.ClearMaxTime();
	mLip.ClearMaxTime();
	mSkitch.ClearMaxTime();
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterBalanceTrickComponent::UpdateRecord (   )
{
	mManual.UpdateRecord();		   
	mGrind.UpdateRecord();		   
	mLip.UpdateRecord();		   
	mSkitch.UpdateRecord();		   
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterBalanceTrickComponent::Reset (   )
{
	mManual.Reset();
	mGrind.Reset();
	mSkitch.Reset();
	mLip.Reset();
	
	mBalanceTrickType = 0;
	mDoingBalanceTrick = false;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
void CSkaterBalanceTrickComponent::ExcludeBalanceButtons ( int& numButtonsToIgnore, uint32 pButtonsToIgnore[] )
{
	// If a balance trick is being done, then this will stop the buttons being used to control the balance from
	// generating the events used to trigger tricks.
	// Otherwise, ChrisR can't do kickflips by very quickly jumping out of a grind & kickflipping by rolling
	// from X to Square.
	
	// Note, in case of problems later:
	// Now, potentially a button could be pressed just before the balance trick,
	// then released during the balance trick, and the release would not get recorded as an event.
	// So if the event buffer were analysed, it would appear that the button was still pressed.
	// However, this does not seem to cause any problems, because generally if we want to know if a button
	// is pressed right now we just read the pad. Just noting this if any problems occur later.
	switch (mBalanceTrickType)
	{
		case Crc::ConstCRC( "NoseManual"):
		case Crc::ConstCRC("Manual"):
			numButtonsToIgnore = 2;
			pButtonsToIgnore[0] = mManual.mButtonAChecksum;
			pButtonsToIgnore[1] = mManual.mButtonBChecksum;
			break;
			
		case Crc::ConstCRC("Lip"):
			numButtonsToIgnore = 2;
			pButtonsToIgnore[0] = mLip.mButtonAChecksum;
			pButtonsToIgnore[1] = mLip.mButtonBChecksum;
			break;
			
		case Crc::ConstCRC("Grind"):
		case Crc::ConstCRC("Slide"):
			numButtonsToIgnore = 2;
			pButtonsToIgnore[0] = mGrind.mButtonAChecksum;
			pButtonsToIgnore[1] = mGrind.mButtonBChecksum;
			break;			
			
		case Crc::ConstCRC("Skitch"):
			numButtonsToIgnore = 2;
			pButtonsToIgnore[0] = mSkitch.mButtonAChecksum;
			pButtonsToIgnore[1] = mSkitch.mButtonBChecksum;
			break;
			
		default:	
			numButtonsToIgnore = 0;
			break;
	}		
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

float CSkaterBalanceTrickComponent::GetBalanceStat ( uint32 Checksum )
{
	// If some custom params have been set, use them.
	if (mpBalanceParams)
	{
		return GetSkater()->GetScriptedStat(Checksum, mpBalanceParams);
	}
		
	switch (mBalanceTrickType)
	{
		case Crc::ConstCRC( "NoseManual"):
		case Crc::ConstCRC("Manual"):
			return GetSkater()->GetScriptedStat(Checksum, Script::GetStructure(Crc::ConstCRC("ManualParams")));
			
		case Crc::ConstCRC("Grind"):
		case Crc::ConstCRC("Slide"):
			return GetSkater()->GetScriptedStat(Checksum, Script::GetStructure(Crc::ConstCRC("GrindParams")));
			
		case Crc::ConstCRC("Lip"):
			return GetSkater()->GetScriptedStat(Checksum, Script::GetStructure(Crc::ConstCRC("LipParams")));
		
		case Crc::ConstCRC("Skitch"):
			return GetSkater()->GetScriptedStat(Checksum, Script::GetStructure(Crc::ConstCRC("SkitchParams")));
			
		default:
			Dbg_Assert(false);
			return 0.0f;
	}	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
void CSkaterBalanceTrickComponent::ClearBalanceParameters (   )
{
	if (mpBalanceParams)
	{
		delete mpBalanceParams;
		mpBalanceParams = nullptr;
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterBalanceTrickComponent::stop_balance_trick (   )
{
	// Stops doing any balance trick.
	// Called when going into the lip state, and also called by the StopBalanceTrick script command.
	mManual.Stop();	
	mGrind.Stop();	
	mLip.Stop();	
	mSkitch.Stop();
		
	mBalanceTrickType = 0;
	mDoingBalanceTrick = false;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterBalanceTrickComponent::set_wobble_params ( Script::CStruct *pParams )
{
	if (!GetObj()->GetScript())
	{
		GetObj()->SetScript(new Script::CScript);
	}

	Dbg_Assert(pParams);

	// Extract all the wobble details and stick them in WobbleDetails, then send that to SetWobbleDetails
	
	Script::CStruct* pStat = nullptr;
	Gfx::SWobbleDetails theWobbleDetails;

	pParams->GetStructure(Crc::ConstCRC("WobbleAmpA"), &pStat, Script::ASSERT);
	theWobbleDetails.wobbleAmpA = GetSkater()->GetScriptedStat(pStat);

	pParams->GetStructure(Crc::ConstCRC("WobbleAmpB"), &pStat, Script::ASSERT);
	theWobbleDetails.wobbleAmpB = GetSkater()->GetScriptedStat(pStat);

	pParams->GetStructure(Crc::ConstCRC( "WobbleK1"), &pStat, Script::ASSERT);
	theWobbleDetails.wobbleK1 = GetSkater()->GetScriptedStat(pStat);

	pParams->GetStructure(Crc::ConstCRC("WobbleK2"), &pStat, Script::ASSERT);
	theWobbleDetails.wobbleK2 = GetSkater()->GetScriptedStat(pStat);

	pParams->GetStructure(Crc::ConstCRC("SpazFactor"), &pStat, Script::ASSERT);
	theWobbleDetails.spazFactor = GetSkater()->GetScriptedStat(pStat);

	mp_animation_component->SetWobbleDetails(theWobbleDetails, true);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterBalanceTrickComponent::set_balance_trick_params ( Script::CStruct *pParams )
{
	Dbg_Assert(pParams);

	if (!mpBalanceParams)
	{
		mpBalanceParams = new Script::CStruct;
	}
	mpBalanceParams->Clear();
	mpBalanceParams->AppendStructure(pParams);	
}

}
