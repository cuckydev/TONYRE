//****************************************************************************
//* MODULE:         Sk/Components
//* FILENAME:       SkaterStateComponent.cpp
//* OWNER:          Dan
//* CREATION DATE:  3/31/3
//****************************************************************************

#include <sk/components/skaterstatecomponent.h>

#include <gel/object/compositeobject.h>
#include <gel/scripting/checksum.h>
#include <gel/scripting/script.h>
#include <gel/scripting/struct.h>

/*
 * Holds all skater state which is needed by both local and nonlocal clients.  This way, code external to the skater can access this information in a
 * consistent manner, without having to know which components within the skater are controling the state.
 *
 * Currently, state within the core physics component has not been moved into theis component.
 */
 
namespace Obj
{
//											Fireball										
static uint32 s_powerups[vNUM_POWERUPS] = { 0xd039432c };

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
CBaseComponent* CSkaterStateComponent::s_create()
{
	return static_cast< CBaseComponent* >( new CSkaterStateComponent );	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CSkaterStateComponent::CSkaterStateComponent() : CBaseComponent()
{
	int i;

	SetType( CRC_SKATERSTATE );
	for( i = 0; i < vNUM_POWERUPS; i++ )
	{
		m_powerups[i] = false;
	}
	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
CSkaterStateComponent::~CSkaterStateComponent()
{
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterStateComponent::InitFromStructure( Script::CStruct* pParams )
{
	m_state = AIR;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterStateComponent::RefreshFromStructure( Script::CStruct* pParams )
{
	InitFromStructure(pParams);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterStateComponent::Update()
{
	Suspend(true);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CBaseComponent::EMemberFunctionResult CSkaterStateComponent::CallMemberFunction( uint32 Checksum, Script::CStruct* pParams, Script::CScript* pScript )
{
	switch ( Checksum )
	{
        // @script | DoingTrick | true if we're doing a trick
		case 0x58ad903f: // DoingTrick
			return DoingTrick() ? CBaseComponent::MF_TRUE : CBaseComponent::MF_FALSE;
			break;
			
		case 0xb07ac662: // HasPowerup
		{
			uint32 type;

			pParams->GetChecksum( NONAME, &type, true );
			return HasPowerup( type ) ? CBaseComponent::MF_TRUE : CBaseComponent::MF_FALSE;
			break;
		}

		case 0xe11b7ca:	// PickedUpPowerup
		{
			uint32 type;

			pParams->GetChecksum( NONAME, &type, true );
			PickedUpPowerup( type );
			break;
		}
		
		// @script | GetTerrain | returns the number of the terrain in 'terrain'
		case Crc::ConstCRC("GetTerrain"):
			pScript->GetParams()->AddInteger(Crc::ConstCRC("terrain"), m_terrain);
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

void CSkaterStateComponent::GetDebugInfo(Script::CStruct *p_info)
{
#ifdef	__DEBUG_CODE__
	Dbg_MsgAssert(p_info,("nullptr p_info sent to CSkaterStateComponent::GetDebugInfo"));
	
	const uint32 p_state_checksums [   ] =
	{
		Crc::ConstCRC("GROUND"),
		Crc::ConstCRC("AIR"),
		Crc::ConstCRC("WALL"),
		Crc::ConstCRC("LIP"),
		Crc::ConstCRC("RAIL"),
		Crc::ConstCRC("WALLPLANT")
	};
	
	const uint32 p_flag_checksums [ NUM_ESKATERFLAGS ] =
	{
		Crc::ConstCRC("TENSE"),
		Crc::ConstCRC("FLIPPED"),
		Crc::ConstCRC("VERT_AIR"),
		Crc::ConstCRC("TRACKING_VERT"),
		Crc::ConstCRC("LAST_POLY_WAS_VERT"),
		Crc::ConstCRC("CAN_BREAK_VERT"),
		Crc::ConstCRC("CAN_RERAIL"),
		Crc::ConstCRC("RAIL_SLIDING"),
		Crc::ConstCRC("CAN_HIT_CAR"),
		Crc::ConstCRC("AUTOTURN"),
		Crc::ConstCRC("IS_BAILING"),
		Crc::ConstCRC("SPINE_PHYSICS"),
		Crc::ConstCRC("IN_RECOVERY"),
		Crc::ConstCRC("SKITCHING"),
		Crc::ConstCRC("OVERRIDE_CANCEL_GROUND"),
		Crc::ConstCRC("SNAPPED_OVER_CURB"),
		Crc::ConstCRC("SNAPPED"),
		Crc::ConstCRC("IN_ACID_DROP"),
		Crc::ConstCRC("AIR_ACID_DROP_DISALLOWED"),
		Crc::ConstCRC("CANCEL_WALL_PUSH"),
		Crc::ConstCRC("NO_ORIENTATION_CONTROL"),
		Crc::ConstCRC("NEW_RAIL")
	};
	
	p_info->AddChecksum(Crc::ConstCRC("m_state"), p_state_checksums[m_state]);
	for (int flag = 0; flag < NUM_ESKATERFLAGS; flag++)
	{
		p_info->AddChecksum(p_flag_checksums[flag], GetFlag(static_cast< ESkaterFlag >(flag)) ? CRCD(0x203b372, "true") : Crc::ConstCRC("false"));
	}
	
	CBaseComponent::GetDebugInfo(p_info);	  
#endif				 
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterStateComponent::Reset (   )
{
	SetDoingTrick(false);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

static int	s_get_powerup_index( uint32 type )
{
	int i;

	for( i = 0; i < vNUM_POWERUPS; i++ )
	{
		if( s_powerups[i] == type )
		{
			return i;
		}
	}

	return -1;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CSkaterStateComponent::HasPowerup( uint32 type )
{
	int index;

	index = s_get_powerup_index( type );
	if( index == -1 )
	{
		return false;
	}
	
	return m_powerups[index];
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterStateComponent::ClearPowerups( void )
{
	int i;

	for( i = 0; i < vNUM_POWERUPS; i++ )
	{
		m_powerups[i] = false;
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterStateComponent::PickedUpPowerup( uint32 type )
{
	int index;

	index = s_get_powerup_index( type );
	if( index == -1 )
	{
		return;
	}
	
	m_powerups[index] = true;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

}
