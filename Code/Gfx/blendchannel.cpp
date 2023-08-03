//****************************************************************************
//* MODULE:         Gfx
//* FILENAME:       BlendChannel.cpp
//* OWNER:          Gary Jesdanun
//* CREATION DATE:  12/12/2002
//****************************************************************************

#include <gfx/blendchannel.h>

#include <gel/object/compositeobject.h>

#include <gel/components/animationcomponent.h>

#include <gel/scripting/array.h>
#include <gel/scripting/checksum.h>
#include <gel/scripting/struct.h>
#include <gel/scripting/symboltable.h>
#include <gel/scripting/utils.h>
							 
#include <gfx/baseanimcontroller.h>
#include <gfx/bonedanim.h>
#include <gfx/nx.h>
#include <gfx/nxanimcache.h>
#include <gfx/pose.h>
#include <gfx/skeleton.h>
#include <gfx/subanimcontroller.h>

#include <sys/timer.h>
				  
namespace Gfx
{

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CBlendChannel::CBlendChannel( Obj::CCompositeObject* pCompositeObject )
{
	m_numControllers = 0;

	// immediately starts active when it's created
	m_status = ANIM_STATUS_ACTIVE;

	mp_object = pCompositeObject;
	Dbg_MsgAssert( mp_object, ( "Blend channel has no object" ) );
}

// how to handle conflicts between controllers?
// you should really only have either the boned anim or the wobble controller
// maybe each item should have its own local time...

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CBlendChannel::~CBlendChannel()
{
	remove_controllers();

	// wipe out any old keys
	delete_custom_keys();
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CBaseAnimController* CBlendChannel::AddController( Script::CStruct* pParams )
{
	uint32 type;
	pParams->GetChecksum( Crc::ConstCRC("type"), &type, Script::ASSERT );

	CBaseAnimController* pController = NULL;

	int priority = 500;

	switch ( type )
	{
		case 0xcb4533ff:	// bonedanim
			{
				pController = new CBonedAnimController( this );
			}
			break;

		case 0xd079853e:	// ik
			{
				pController = new CIKController( this );
			}
			break;

		case 0x6d941203:	// wobble
			{
				pController = new CWobbleController( this );
			}
			break;
										 
		case 0xcfc5b380:	// pose
			{
				pController = new CPoseController( this );
			}
			break;

		case 0xfdf0436c:	// proceduralanim
			{
				pController = new CProceduralAnimController( this );
			}
			break;
		
		case 0xdf5c091a:	// fliprotate
			{
				pController = new CFlipRotateController( this );
				
				// make it be processed later
				// (so that partial anims can take effect of flipping)
				priority = 100;
			}
			break;
	
		case 0x26205db6:	// lookat
			{
				pController = new CLookAtController( this );
			}
			break;
		
		case 0x659bf355:	// partialanim
			{
				pController = new CPartialAnimController( this );
			}
			break;

		default:
			{
				Dbg_MsgAssert( 0, ( "Unrecognized controller %s", Script::FindChecksumName(type) ) );
			}
	}

	// override priority, if necessary
	pParams->GetInteger( Crc::ConstCRC("priority"), &priority, Script::NO_ASSERT );

	Dbg_MsgAssert( pController, ( "No controller" ) );
	pController->InitFromStructure( pParams );
	pController->SetPriority( priority );
	add_controller( pController, priority );

	return pController;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CBlendChannel::add_controller( CBaseAnimController* pAnimController, int priority )
{
	Dbg_MsgAssert( m_numControllers < vMAX_CONTROLLERS, ( "Too many controllers for this channel on %s", Script::FindChecksumName( GetObj()->GetID() ) ) );	
	Dbg_MsgAssert( pAnimController, ( "No controller" ) );
		
	int i = 0;
	for ( i = 0; i < m_numControllers; i++ )
	{
		if ( priority > mp_controllers[i]->GetPriority() )
		{
			// shift all of them
			for ( int j = m_numControllers; j > i; j-- )
			{
				mp_controllers[j] = mp_controllers[j - 1];
			}
			
			break;
		}
	}

	mp_controllers[i] = pAnimController;
	m_numControllers++;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CBlendChannel::remove_controllers()
{
	for ( int i = 0; i < m_numControllers; i++ )
	{
		delete mp_controllers[i];
		mp_controllers[i] = NULL;
	}

	m_numControllers = 0;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CBlendChannel::remove_controller( CBaseAnimController* pAnimController )
{
	// TODO:  Should make sure that high-level
	// function is not currently traversing the list...
	
	for ( int i = 0; i < m_numControllers; i++ )
	{
		if ( pAnimController == mp_controllers[i] )
		{
			delete mp_controllers[i];
			mp_controllers[i] = NULL;

			// shift the rest of them
			for ( int j = i; j < m_numControllers - 1; j++ )
			{
				mp_controllers[j] = mp_controllers[j + 1];
			}

			m_numControllers--;
			return;
		}
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CBaseAnimController* CBlendChannel::get_controller_by_id( uint32 id )
{
	for ( int i = 0; i < m_numControllers; i++ )
	{
		if ( mp_controllers[i]->GetID() == id )
		{
			return mp_controllers[i];
		}
	}

	// not found
	return NULL;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CBlendChannel::Update()
{
	// reset the anim complete field for this frame
	m_animComplete = false;

	if ( GetStatus() == ANIM_STATUS_DEGENERATING )
	{
		m_degenerationTime -= ( m_blendSpeed * Tmr::FrameRatio() );
		if ( m_degenerationTime <= 0.0f )
		{								    
			// This animation is no longer active.
			SetStatus( ANIM_STATUS_INACTIVE );
		}
		else if ( ( m_degenerationTime * m_degenerationTimeToBlendMultiplier ) < 0.0f )
		{
			// Check for being too small to care about.
			SetStatus( ANIM_STATUS_INACTIVE ); 
		}
	}
	else
	{
		// don't really need to do this any more, because
		// the update happens in the CBonedAnimController...
		//		CAnimChannel::Update();
	}
	
	if ( GetStatus() == ANIM_STATUS_ACTIVE )
	{
		for ( int i = 0; i < m_numControllers; i++ )
		{
			// one of these update functions should set the correct m_time for this frame
			mp_controllers[i]->Update();
		}
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CBlendChannel::GetPose( Gfx::CPose* pResultPose )
{
	for ( int i = 0; i < m_numControllers; i++ )
	{
		mp_controllers[i]->GetPose( pResultPose );
	}

	return true;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CBlendChannel::Degenerate( float blend_period )
{
	if ( blend_period == 0.0f )
	{
		// no point in degenerating it
		// so consider it "done"
		SetStatus( ANIM_STATUS_INACTIVE );
	}

	// only degenerate if it's active
	if( GetStatus() == ANIM_STATUS_ACTIVE )
	{
		SetStatus( ANIM_STATUS_DEGENERATING );
		m_degenerationTime = blend_period;
		return true;
	}

	return false;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

float CBlendChannel::GetBlendValue()
{
	EAnimStatus theStatus = GetStatus();

	switch ( theStatus )
	{
		case ANIM_STATUS_ACTIVE:
			return 1.0f;
		case ANIM_STATUS_INACTIVE:
			return 0.0f;
		case ANIM_STATUS_DEGENERATING:
			return m_degenerationTime * m_degenerationTimeToBlendMultiplier;
		default:
			Dbg_Assert( 0 );
			return 0.0f;
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CBlendChannel::GetDebugInfo( Script::CStruct* p_info )
{
#ifdef	__DEBUG_CODE__
	CAnimChannel::GetDebugInfo( p_info );
	
	for ( int i = 0; i < m_numControllers; i++ )
	{
		mp_controllers[i]->GetDebugInfo( p_info );
	}

	p_info->AddFloat( Crc::ConstCRC("m_degenerationTime"), m_degenerationTime );
	p_info->AddFloat( Crc::ConstCRC("m_degenerationTimeToBlendMultiplier"), m_degenerationTimeToBlendMultiplier );
	
	uint32 status_checksum = 0;
	switch ( m_status )
	{
		case ANIM_STATUS_INACTIVE:
			status_checksum = Crc::ConstCRC("ANIM_STATUS_INACTIVE");
			break;
		case ANIM_STATUS_DEGENERATING:
			status_checksum = Crc::ConstCRC("ANIM_STATUS_DEGENERATING");
			break;
		case ANIM_STATUS_ACTIVE:
			status_checksum = Crc::ConstCRC("ANIM_STATUS_ACTIVE");
			break;
		default:
			Dbg_MsgAssert( 0, ( "Unknown status found in CBlendChannel::GetDebugInfo.  Was the enum changed?" ) );
			break;
	}
	p_info->AddChecksum( Crc::ConstCRC("m_status"), status_checksum );
#endif				 
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CBlendChannel::Reset()
{
	CAnimChannel::Reset();

    m_status									= ANIM_STATUS_INACTIVE;

	m_degenerationTime						    = 0.0f;
	m_degenerationTimeToBlendMultiplier	        = 0.0f;	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CBlendChannel::InvalidateCache()
{
	for ( int i = 0; i < m_numControllers; i++ )
	{
		mp_controllers[i]->CallMemberFunction( Crc::ConstCRC("InvalidateCache"), NULL, NULL );
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

EAnimStatus CBlendChannel::GetStatus() const
{
	return m_status;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CBlendChannel::SetStatus( EAnimStatus status )
{
	m_status = status;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CBlendChannel::IsActive()
{
	return ( GetStatus() != Gfx::ANIM_STATUS_INACTIVE );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CBlendChannel::IsDegenerating()
{
	return ( GetStatus() == Gfx::ANIM_STATUS_DEGENERATING );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CBlendChannel::PlaySequence( uint32 anim_name, float start_time, float end_time, EAnimLoopingType loop_type, float blend_period, float speed, bool flipped )
{
	// clear out any old custom keys, and add the new ones
	delete_custom_keys();
	add_custom_keys( anim_name );
	
	m_status = ANIM_STATUS_ACTIVE;
	
	m_blendSpeed = speed / 60.0f;

	Script::CStruct* pTempParams = NULL;
	 
	if ( loop_type == Gfx::LOOPING_WOBBLE )
	{
		pTempParams = new Script::CStruct;
		pTempParams->AddChecksum( Crc::ConstCRC("type"), Crc::ConstCRC("wobble") );
		this->AddController( pTempParams );
		delete pTempParams;
	}
	else
	{
		pTempParams= new Script::CStruct;
		pTempParams->AddChecksum( Crc::ConstCRC("type"), Crc::ConstCRC("bonedanim") );
		this->AddController( pTempParams );
		delete pTempParams;
	}

	pTempParams= new Script::CStruct;
	pTempParams->AddChecksum( Crc::ConstCRC("type"), Crc::ConstCRC("fliprotate") );
    pTempParams->AddInteger( "flipped", flipped );
	this->AddController( pTempParams );
	delete pTempParams;

#if 0
	// if it's the skater, then add a procedural anim controller
	if ( GetObj()->GetID() == 0 )
	{
		pTempParams = new Script::CStruct;
		pTempParams->AddChecksum( Crc::ConstCRC("type"), Crc::ConstCRC("proceduralanim") );
		this->AddController( pTempParams );
		delete pTempParams;
	}
#endif
	
#if 0
	// if it's the skater, then add a partial anim controller
	if ( GetObj()->GetID() == 0 )
	{
		pTempParams = new Script::CStruct;
		pTempParams->AddChecksum( Crc::ConstCRC("type"), Crc::ConstCRC("partialanim") );
		pTempParams->AddChecksum( Crc::ConstCRC("animname"), Script::GenerateCRC("Taunt1") );
		pTempParams->AddFloat( Crc::ConstCRC("starttime"), 0.0f );
		pTempParams->AddFloat( Crc::ConstCRC("endtime"), 1.0f );
		pTempParams->AddInteger( Crc::ConstCRC("looptype"), Gfx::LOOPING_CYCLE );
		pTempParams->AddFloat( Crc::ConstCRC("blendperiod"), 0.0f );
		pTempParams->AddFloat( Crc::ConstCRC("speed"), 1.0f );
		this->AddController( pTempParams );
		delete pTempParams;
	}
#endif

	pTempParams = new Script::CStruct;
	pTempParams->AddFloat( Crc::ConstCRC("wobbleTargetAlpha"), 0.0f );
	for ( int i = 0; i < m_numControllers; i++ )
	{
		mp_controllers[i]->CallMemberFunction( Crc::ConstCRC("setWobbleTarget"), pTempParams, NULL );
	}
	delete pTempParams;

	pTempParams = new Script::CStruct;
	pTempParams->AddChecksum( Crc::ConstCRC("animname"), anim_name );
	pTempParams->AddFloat( Crc::ConstCRC("starttime"), start_time );
	pTempParams->AddFloat( Crc::ConstCRC("endtime"), end_time );
	pTempParams->AddInteger( Crc::ConstCRC("looptype"), loop_type );
	pTempParams->AddFloat( Crc::ConstCRC("blendperiod"), blend_period );
	pTempParams->AddFloat( Crc::ConstCRC("speed"), speed );
	for ( int i = 0; i < m_numControllers; i++ )
	{
		mp_controllers[i]->CallMemberFunction( Crc::ConstCRC("PlaySequence"), pTempParams, NULL );
	}
	delete pTempParams;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CBlendChannel::delete_custom_keys()
{
	m_customAnimKeyList.DestroyAllNodes();
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CBlendChannel::add_custom_keys( uint32 animName )
{
	Obj::CAnimationComponent* pAnimationComponent = GetAnimationComponentFromObject( GetObj() );
	if ( !pAnimationComponent )
	{
		return;
	}

	uint32 animEventTableName = pAnimationComponent->GetAnimEventTableName();
	if ( !animEventTableName )
	{
		return;
	}

	Script::CStruct* pAnimEventTable = Script::GetStructure( animEventTableName, Script::ASSERT );
	if ( pAnimEventTable )
	{
		Script::CArray* pSubArray;
		if ( pAnimEventTable->GetArray( animName, &pSubArray, Script::NO_ASSERT ) )
		{
			for ( uint32 i = 0; i < pSubArray->GetSize(); i++ )
			{
				Script::CStruct* pSubStruct;
				pSubStruct = pSubArray->GetStructure( i );
    
				int frame = 0;
				// if the frame is not specified, then look for a time value
				if ( !pSubStruct->GetInteger( Crc::ConstCRC("frame"), &frame, Script::NO_ASSERT ) )
				{
					float keyTime = 0.0f;
						pSubStruct->GetFloat( Crc::ConstCRC("time"), &keyTime, Script::ASSERT );
						frame = (int)(keyTime * 60.0f);
				}

                uint32 eventType;
				pSubStruct->GetChecksum( Crc::ConstCRC("event"), &eventType, Script::ASSERT );

				Script::CStruct* pEventParams = NULL;
				pSubStruct->GetStructure( Crc::ConstCRC("params"), &pEventParams, Script::NO_ASSERT );
                
				Gfx::CCustomAnimKey* pKey = new Gfx::CEventKey( frame, eventType, pEventParams );
				pKey->SetActive( true );
				m_customAnimKeyList.AddToTail( pKey );
			}
		}													  
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CBlendChannel::ResetCustomKeys()
{
	int customKeyCount = m_customAnimKeyList.CountItems();
	for ( int i = 0; i < customKeyCount; i++ )
	{
		Gfx::CCustomAnimKey* pKey = (Gfx::CCustomAnimKey*)m_customAnimKeyList.GetItem(i);
		pKey->SetActive( true );
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CBlendChannel::ProcessCustomKeys( float startTime, float endTime )
{
	// Only fire off events on the primary anim
	if ( GetStatus() == ANIM_STATUS_ACTIVE )
	{
		startTime *= 60.0f;
		endTime *= 60.0f;

		// we've just looped, so reset the keys
		if ( m_direction == ANIM_DIR_FORWARDS )
		{
			if ( startTime > endTime )
			{
				ResetCustomKeys();
				startTime = m_startTime;
			}
		}
		else
		{
			if ( endTime > startTime )
			{
				ResetCustomKeys();
				startTime = m_startTime;
			}
		}

		int customKeyCount = m_customAnimKeyList.CountItems();
		for ( int i = 0; i < customKeyCount; i++ )
		{
			Gfx::CCustomAnimKey* pKey = (Gfx::CCustomAnimKey*)m_customAnimKeyList.GetItem(i);
			if ( pKey->WithinRange( startTime, endTime ) )
			{
//				printf( "Processing key at %f (%f %f)\n", 0.0f, startTime, endTime );
				pKey->ProcessKey( GetObj() );
			}
			else
			{
//				printf( "Not processing key at %f (%f %f)\n", custom_key_time, startTime, endTime );
			}
		}
	}
	
	// TODO:  reset the custom keys when it loops?
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

EAnimFunctionResult CBlendChannel::CallMemberFunction( uint32 Checksum, Script::CStruct* pParams, Script::CScript* pScript )
{
	switch ( Checksum )
	{
		case 0x83654874:	// AddAnimController
		{
			AddController( pParams );
			return AF_TRUE;
		}
		break;

		case 0x986d274e:	// RemoveAnimController
		{
			uint32 id;
			pParams->GetChecksum( Crc::ConstCRC("id"), &id, Script::ASSERT );
			CBaseAnimController* pAnimController = get_controller_by_id( id );
			if ( pAnimController )
			{
				remove_controller( pAnimController );
			}
		}
		break;
	}

	for ( int i = 0; i < m_numControllers; i++ )
	{
		EAnimFunctionResult theResult = mp_controllers[i]->CallMemberFunction( Checksum, pParams, pScript );
		
		if ( theResult != AF_NOT_EXECUTED )
		{
			return theResult;
		}
	}
	
	return AF_NOT_EXECUTED;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

Obj::CCompositeObject* CBlendChannel::GetObj()
{
	return mp_object;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

}
