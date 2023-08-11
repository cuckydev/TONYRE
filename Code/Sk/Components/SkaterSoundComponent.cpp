//****************************************************************************
//* MODULE:         Sk/Components
//* FILENAME:       SkaterSoundComponent.cpp
//* OWNER:			Dan
//* CREATION DATE:  2/27/3
//****************************************************************************

#include <sk/components/skatersoundcomponent.h>

#include <gel/object/compositeobject.h>
#include <gel/scripting/checksum.h>
#include <gel/scripting/script.h>
#include <gel/scripting/struct.h>
#include <gel/scripting/symboltable.h>
#include <gel/environment/terrain.h>

#include <sk/modules/skate/skate.h>

namespace Obj
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CBaseComponent* CSkaterSoundComponent::s_create()
{
	return static_cast< CBaseComponent* >( new CSkaterSoundComponent );	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CSkaterSoundComponent::CSkaterSoundComponent() : CBaseComponent()
{
	SetType( CRC_SKATERSOUND );
	
	m_is_rail_sliding = false;
	m_max_speed = 1.0f;
	m_vol_mult = 1.0f;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
CSkaterSoundComponent::~CSkaterSoundComponent()
{
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterSoundComponent::InitFromStructure( Script::CStruct* pParams )
{
	float vol_mult;
	if (pParams->GetFloat( Crc::ConstCRC("volume_mult"), &vol_mult))
	{
		SetVolumeMultiplier(vol_mult);
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterSoundComponent::RefreshFromStructure( Script::CStruct* pParams )
{
	InitFromStructure(pParams);
}


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterSoundComponent::Update()
{
	// As a minor optimization, CSkaterSoundComponent is always suspended.
	Suspend(true);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CBaseComponent::EMemberFunctionResult CSkaterSoundComponent::CallMemberFunction( uint32 Checksum, Script::CStruct* pParams, Script::CScript* pScript )
{
	(void)pScript;
	(void)pParams;

	switch ( Checksum )
	{
        // @script | PlayJumpSound |
		case Crc::ConstCRC( "PlayJumpSound"):
		{
			switch ( m_stateType )
			{
				case GROUND:
				case AIR:
					PlayJumpSound(GetObj()->GetVel().Length() / m_max_speed);
					break;
					 
				case RAIL:
					PlayJumpSound(GetObj()->GetVel().Length() / m_max_speed);
				
				default:
					break;
			}
			break;
		}
		
        // @script | PlayLandSound | 
		case Crc::ConstCRC("PlayLandSound"):
		{
			switch ( m_stateType )
			{
				case GROUND:
				case AIR:
					PlayLandSound(Mth::Abs(GetObj()->GetVel()[Y]) / m_max_speed);
					break;
					
				case RAIL:
					PlayLandSound(GetObj()->GetVel().Length() / m_max_speed);
					break;
					
				default:
					break;
			}
			break;
		}
		
		// @script | PlayBonkSound |
		case Crc::ConstCRC("PlayBonkSound"):
		{
			PlayBonkSound(GetObj()->GetVel().Length() / m_max_speed);
			break;
		}
		
        // @script | PlayCessSound | 
		case Crc::ConstCRC("PlayCessSound"):
		{
			PlayCessSound(GetObj()->GetVel().Length() / m_max_speed);
			break;
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

void CSkaterSoundComponent::GetDebugInfo(Script::CStruct *p_info)
{
#ifdef	__DEBUG_CODE__
	Dbg_MsgAssert(p_info,("nullptr p_info sent to CSkaterSoundComponent::GetDebugInfo"));

	CBaseComponent::GetDebugInfo(p_info);	  
#endif				 
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterSoundComponent::PlayLandSound ( float speed_fraction )
{
	ETerrainType terrain;
	if ( m_stateType == GROUND || m_stateType == AIR )
	{
		terrain = m_lastTerrain;
	}
	else
	{
		terrain = m_terrain;
	}
	
	PlayLandSound(speed_fraction, terrain);
}
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterSoundComponent::PlayLandSound ( float speed_fraction, ETerrainType terrain )
{
	Env::ETerrainActionType table;
	if ( m_stateType == RAIL )
	{
		table = m_is_rail_sliding ? Env::vTABLE_SLIDELAND : Env::vTABLE_GRINDLAND;
	}
	else
	{
		table = Env::vTABLE_LAND;
	}
	
	speed_fraction *= 100.0f;
	
	#ifdef __NOPT_ASSERT__
	if (Script::GetInteger(Crc::ConstCRC("debug_skater_triggered_sounds")))
	{
		Dbg_Message("Playing sound [land]:   %.1f", speed_fraction);
	}
	#endif
	
	Env::CTerrainManager::sPlaySfx(table, terrain, GetObj()->GetPos(), speed_fraction * m_vol_mult, speed_fraction, speed_fraction);
}
   
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterSoundComponent::PlayJumpSound ( float speed_fraction )
{
	ETerrainType terrain;
	if ( m_stateType == GROUND || m_stateType == AIR )
	{
		terrain = m_lastTerrain;
	}
	else
	{
		terrain = m_terrain;
	}
	
	PlayJumpSound(speed_fraction, terrain);
}
   
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterSoundComponent::PlayJumpSound ( float speed_fraction, ETerrainType terrain )
{
	PlayJumpSound(speed_fraction, terrain, m_stateType);
}
   
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterSoundComponent::PlayJumpSound ( float speed_fraction, ETerrainType terrain, EStateType stateType )
{
	Env::ETerrainActionType table;
	if ( stateType == RAIL )
	{
		table = m_is_rail_sliding ? Env::vTABLE_SLIDEJUMP : Env::vTABLE_GRINDJUMP; 
	}
	else
	{
		table = Env::vTABLE_JUMP;
	}
	
	speed_fraction *= 100.0f;
	
	#ifdef __NOPT_ASSERT__
	if (Script::GetInteger(Crc::ConstCRC("debug_skater_triggered_sounds")))
	{
		Dbg_Message("Playing sound [ollie]:  %.1f", speed_fraction);
	}
	#endif

	Env::CTerrainManager::sPlaySfx(table, terrain, GetObj()->GetPos(), speed_fraction * m_vol_mult, speed_fraction, speed_fraction);
}
   
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterSoundComponent::PlayBonkSound ( float speed_fraction )
{
	PlayBonkSound(speed_fraction, m_terrain);
}
   
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterSoundComponent::PlayBonkSound ( float speed_fraction, ETerrainType terrain )
{
	speed_fraction *= 100.0f;
	
	#ifdef __NOPT_ASSERT__
	if (Script::GetInteger(Crc::ConstCRC("debug_skater_triggered_sounds")))
	{
		Dbg_Message("Playing sound [bonk]:   %.1f", speed_fraction);
	}
	#endif

	Env::CTerrainManager::sPlaySfx(Env::vTABLE_BONK, terrain, GetObj()->GetPos(), speed_fraction * m_vol_mult, speed_fraction, speed_fraction);
}
   
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterSoundComponent::PlayCessSound ( float speed_fraction )
{
	PlayCessSound(speed_fraction, m_terrain);
}
   
/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterSoundComponent::PlayCessSound ( float speed_fraction, ETerrainType terrain )
{
	speed_fraction *= 100.0f;
	
	#ifdef __NOPT_ASSERT__
	if (Script::GetInteger(Crc::ConstCRC("debug_skater_triggered_sounds")))
	{
		Dbg_Message("Playing sound [revert]: %.1f", speed_fraction);
	}
	#endif

	Env::CTerrainManager::sPlaySfx(Env::vTABLE_CESS, terrain, GetObj()->GetPos(), speed_fraction * m_vol_mult, speed_fraction, speed_fraction);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterSoundComponent::SetVolumeMultiplier( float mult )
{
	Dbg_MsgAssert( mult >= 0.0f && mult <= 1.0f, ( "SetVolumeMultiplier called with bad mult value: %f", mult ) );
	m_vol_mult = mult;
}

}
