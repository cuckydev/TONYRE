//****************************************************************************
//* MODULE:         Sk/Objects
//* FILENAME:       SkaterProfile.cpp
//* OWNER:          Gary Jesdanun
//* CREATION DATE:  11/29/2000
//****************************************************************************

/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/

#include <Sk/Objects/SkaterProfile.h>

#include <Gel/Scripting/array.h>
#include <Gel/Scripting/checksum.h>
#include <Gel/Scripting/component.h>
#include <Gel/Scripting/script.h>
#include <Gel/Scripting/symboltable.h>
#include <Gel/Scripting/utils.h>
#include <Gel/Components/trickcomponent.h>

#include <Gfx/CasUtils.h>
#include <Gfx/FaceTexture.h>

// If possible, try to remove the dependency on these include files...
#include <Sk/Modules/Skate/skate.h>
#include <Sk/Objects/skater.h>                         // for updatetrickmapping
#include <Sk/Objects/PlayerProfileManager.h>           // for updatetrickmapping

/*****************************************************************************
**								DBG Information								**
*****************************************************************************/

namespace Obj
{

// TODO:  Add trick-config and special-trick-config classes.

/*****************************************************************************
**								  Externals									**
*****************************************************************************/

/*****************************************************************************
**								   Defines									**
*****************************************************************************/

/*****************************************************************************
**								Private Types								**
*****************************************************************************/

/*****************************************************************************
**								 Private Data								**
*****************************************************************************/
	
/*****************************************************************************
**								 Public Data								**
*****************************************************************************/

/*****************************************************************************
**							  Private Prototypes							**
*****************************************************************************/

/*****************************************************************************
**							   Private Functions							**
*****************************************************************************/

/*****************************************************************************
**							   Public Functions								**
*****************************************************************************/

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CSkaterProfile::CSkaterProfile(void)
{
	Reset();
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CSkaterProfile::CSkaterProfile(const CSkaterProfile& skaterProfile)
{
	// use the overridden assignment operator
	*this = skaterProfile;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CSkaterProfile& CSkaterProfile::operator=(const CSkaterProfile& skaterProfile)
{
	if ( &skaterProfile == this )
	{
		return *this;
	}

	// use the overridden assignment operator
	m_Appearance = skaterProfile.m_Appearance;

	// info assignment is okay, bec. structs have an overridden assignment operator
	m_Info = skaterProfile.m_Info;

	return *this;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CSkaterProfile::Reset(Script::CStruct* pParams)
{
	// this should get called once at the beginning of the game,
	// and then whenever you want to clear it out to its initial state
	// (like creating a new pro)

	// destroy the face texture, if one exists
	m_Appearance.DestroyFaceTexture();
	
	m_Appearance.Init();
	
	m_Info.Clear();

	Script::CStruct* pTemp;
	
	// TODO:  The trick mapping and the specials
	// should be in their own structures, not within the
	// info...

	// at a minimum, the info structure must contain the trick_mapping structure
	pTemp = new Script::CStruct;
	m_Info.AddComponent( Crc::ConstCRC("trick_mapping"), ESYMBOLTYPE_STRUCTUREPOINTER, pTemp );

	// as well as a special tricks array
	pTemp = new Script::CStruct;
	m_Info.AddComponent( Crc::ConstCRC("specials"), ESYMBOLTYPE_STRUCTUREPOINTER, pTemp );

	if ( pParams )
	{
		//	Dbg_Message( "Alternate constructor for skater profile called\n");

		uint32 appearanceStructure;
		pParams->GetChecksum( Crc::ConstCRC("default_appearance"), &appearanceStructure, true );
		m_Appearance.Load( appearanceStructure );

		// set the trick style, whether he's a pro, etc.
		m_Info.Clear();
		m_Info.AppendStructure( pParams );

		if ( !IsPro() )
		{
			// create a face texture, only if it's a custom skater
			m_Appearance.CreateFaceTexture();
			
			// for debugging purposes, set up a test face
			// Gfx::CFaceTexture* pFaceTexture = m_Appearance.GetFaceTexture();
			// pFaceTexture->LoadFace( "faces\\CS_NSN_head_test_kurt" );
		}		

		// initialize the trick mappings to the default values, defined in protricks.q
		uint32 trickMappingChecksum;
		pParams->GetChecksum( Crc::ConstCRC("default_trick_mapping"), &trickMappingChecksum, Script::ASSERT );

		Script::CStruct* pGlobalTrickMappingStructure;
		pGlobalTrickMappingStructure = Script::GetStructure(trickMappingChecksum, Script::ASSERT);

		Script::CStruct* pLocalTrickMappingStructure;
		m_Info.GetStructure( Crc::ConstCRC("trick_mapping"), &pLocalTrickMappingStructure, Script::ASSERT );
		pLocalTrickMappingStructure->Clear();
		pLocalTrickMappingStructure->AppendStructure( pGlobalTrickMappingStructure );
	}
	else
	{
//		Dbg_Message( "Warning: profile was created without valid data" );
	}
	
	return true;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CSkaterProfile::PartialReset(Script::CStruct* pParams)
{
	// destroy the face texture, if one exists
	m_Appearance.DestroyFaceTexture();
	
	m_Appearance.Init();
	
    Script::CStruct* pTemp;
	
    // at a minimum, the info structure must contain the trick_mapping structure
	pTemp = new Script::CStruct;
	m_Info.AddComponent( Crc::ConstCRC("trick_mapping"), ESYMBOLTYPE_STRUCTUREPOINTER, pTemp );

	// as well as a special tricks array
	pTemp = new Script::CStruct;
	m_Info.AddComponent( Crc::ConstCRC("specials"), ESYMBOLTYPE_STRUCTUREPOINTER, pTemp );

	if ( pParams )
	{
        uint32 appearanceStructure;
		pParams->GetChecksum( Crc::ConstCRC("default_appearance"), &appearanceStructure, true );
		m_Appearance.Load( appearanceStructure );

        // copy just the info I want into it
        const char* name;
        int num;
        uint32 checksum;

        pParams->GetString( Crc::ConstCRC("display_name"), &name, Script::ASSERT );
        m_Info.AddString("display_name", name );
        pParams->GetString( Crc::ConstCRC("first_name"), &name, Script::ASSERT );
        m_Info.AddString("first_name", name );
        pParams->GetString( Crc::ConstCRC("file_name"), &name, Script::ASSERT );
        m_Info.AddString("file_name", name );
        pParams->GetString( Crc::ConstCRC("hometown"), &name, Script::ASSERT );
        m_Info.AddString("hometown", name );

        pParams->GetInteger( Crc::ConstCRC("skater_index"), &num, Script::ASSERT );
        m_Info.AddInteger("skater_index", num );
        pParams->GetInteger( Crc::ConstCRC("is_pro"), &num, Script::ASSERT );
        m_Info.AddInteger("is_pro", num );
        pParams->GetInteger( Crc::ConstCRC("is_male"), &num, Script::ASSERT );
        m_Info.AddInteger("is_male", num );
        pParams->GetInteger( Crc::ConstCRC("is_head_locked"), &num, Script::ASSERT );
        m_Info.AddInteger("is_head_locked", num );
        pParams->GetInteger( Crc::ConstCRC("is_locked"), &num, Script::ASSERT );
        m_Info.AddInteger("is_locked", num );
        pParams->GetInteger( Crc::ConstCRC("is_hidden"), &num, Script::NO_ASSERT );
        m_Info.AddInteger("is_hidden", num );
        pParams->GetInteger( Crc::ConstCRC("age"), &num, Script::ASSERT );
        m_Info.AddInteger("age", num );
        
        pParams->GetChecksum( Crc::ConstCRC("name"), &checksum, Script::ASSERT );
        m_Info.AddChecksum("name", checksum );
        pParams->GetChecksum( Crc::ConstCRC("stance"), &checksum, Script::ASSERT );
        m_Info.AddChecksum("stance", checksum );
        pParams->GetChecksum( Crc::ConstCRC("pushstyle"), &checksum, Script::ASSERT );
        m_Info.AddChecksum("pushstyle", checksum );
        pParams->GetChecksum( Crc::ConstCRC("trickstyle"), &checksum, Script::ASSERT );
        m_Info.AddChecksum("trickstyle", checksum );

        Script::CStruct* p_special;
        pParams->GetStructure( Crc::ConstCRC("specials"), &p_special, Script::ASSERT );
        m_Info.AddStructure("specials", p_special );
        
#ifdef __PLAT_NGPS__
        if ( !IsPro() )
		{
			Mem::Manager::sHandle().PushContext(Mem::Manager::sHandle().SkaterInfoHeap());

			// create a face texture, only if it's a custom skater
			m_Appearance.CreateFaceTexture();
			
			// for debugging purposes, set up a test face
			// Gfx::CFaceTexture* pFaceTexture = m_Appearance.GetFaceTexture();
			// pFaceTexture->LoadFace( "faces\\CS_NSN_head_test_kurt" );
			
			Mem::Manager::sHandle().PopContext();
		}
#endif

		// initialize the trick mappings to the default values, defined in protricks.q
		uint32 trickMappingChecksum;
		pParams->GetChecksum( Crc::ConstCRC("default_trick_mapping"), &trickMappingChecksum, Script::ASSERT );

		Script::CStruct* pGlobalTrickMappingStructure;
		pGlobalTrickMappingStructure = Script::GetStructure(trickMappingChecksum, Script::ASSERT);

		Script::CStruct* pLocalTrickMappingStructure;
		m_Info.GetStructure( Crc::ConstCRC("trick_mapping"), &pLocalTrickMappingStructure, Script::ASSERT );
		pLocalTrickMappingStructure->Clear();
		pLocalTrickMappingStructure->AppendStructure( pGlobalTrickMappingStructure );
	}
	else
	{
//		Dbg_Message( "Warning: profile was created without valid data" );
	}
	
	return true;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

size_t CSkaterProfile::WriteToBuffer(uint8 *pBuffer, size_t BufferSize, bool ignoreFaceData )
{
	size_t totalSize = 0;
	size_t chunkSize = 0;

	chunkSize = m_Appearance.WriteToBuffer(pBuffer, BufferSize, ignoreFaceData);
	totalSize += chunkSize;

	// write out trick mappings
	BufferSize -= chunkSize;
	pBuffer += chunkSize;
//	compress_trick_mappings( "trick_mapping" );
	chunkSize = Script::WriteToBuffer(GetTrickMapping( Crc::ConstCRC("trick_mapping") ), pBuffer, BufferSize );
	totalSize += chunkSize;
//	decompress_trick_mappings( "trick_mapping" );

	// write out special tricks...  these could
	// theoretically be compressed, but not using
	// the same method as the regular tricks
	// (because they're in a different format)
	BufferSize -= chunkSize;
	pBuffer += chunkSize;
	Script::CStruct* pSpecialsStructure = GetSpecialTricksStructure();
	chunkSize = Script::WriteToBuffer(pSpecialsStructure, pBuffer, BufferSize);
	totalSize += chunkSize;

	// write out any extra info that needs to go across
	// (i.e. stats, name, etc.)
	// (some data, such as your default specials
	// and your default appearance, aren't needed)
	BufferSize -= chunkSize;
	pBuffer += chunkSize;
	chunkSize = write_extra_info_to_buffer(pBuffer, BufferSize);
	totalSize += chunkSize;
	
	return totalSize;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

uint8* CSkaterProfile::ReadFromBuffer(uint8 *pBuffer)
{
	pBuffer = m_Appearance.ReadFromBuffer(pBuffer);

	GetTrickMapping( Crc::ConstCRC("trick_mapping") )->Clear();
	pBuffer = Script::ReadFromBuffer(GetTrickMapping( Crc::ConstCRC("trick_mapping") ), pBuffer);
	
//	decompress_trick_mappings( "trick_mapping" );

	Script::CStruct* pStructure = GetSpecialTricksStructure();
	Dbg_Assert( pStructure );
	pStructure->Clear();
	pBuffer = Script::ReadFromBuffer(pStructure, pBuffer);

	// read any extra info that is needed in-game
	// (some data, such as your default specials
	// and your default appearance, aren't needed)
	pBuffer = read_extra_info_from_buffer(pBuffer);
	
	return pBuffer;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

size_t CSkaterProfile::write_extra_info_to_buffer(uint8 *pBuffer, size_t BufferSize)
{	
	Script::CStruct* pTempStructure = new Script::CStruct;

	Dbg_Assert( pTempStructure );
	
	// for each component in info, see if it's needed in-game...
	// such as the stats, trick style, etc.
	// (most of the other information is only needed in the front end)
	Script::CComponent *pComp = m_Info.GetNextComponent();
	while ( pComp )
	{
		Script::CComponent* pNextComp = m_Info.GetNextComponent( pComp );

		switch ( pComp->mNameChecksum )
		{
			case 0xa1dc81f9:	// name
			case 0x7d02bcc3:	// stance
			case 0xc15dbf86:	// pushstyle
				pTempStructure->AddComponent( pComp->mNameChecksum, ESYMBOLTYPE_NAME, (int)pComp->mChecksum );
				break;

			case 0x2ab66cb8:	// display_name
			case 0x2820e997:	// file_name
			case 0x562e3ecd:	// first_name
				pTempStructure->AddComponent( pComp->mNameChecksum, ESYMBOLTYPE_STRING, pComp->mpString );
				break;

			case 0x439f4704:	// air
			case 0xaf895b3f:	// run
			case 0x9b65d7b8:	// ollie
			case 0xf0d90109:	// speed
			case 0xedf5db70:	// spin
			case 0x9016b4e7:	// switch
			case 0xf73a13e3:	// rail_balance
			case 0xae798769:	// lip_balance
			case 0xb1fc0722:	// manual_balance
			case 0xd82f8ac8:	// is_pro
			case 0x6dcb497c:	// flip_speed
			case 0x3f813177:	// is_male
				pTempStructure->AddComponent( pComp->mNameChecksum, ESYMBOLTYPE_INTEGER, (int)pComp->mIntegerValue );
				break;

			default:
				// doesn't need to go across
				break;
		}

		pComp = pNextComp;
	}

	size_t totalSize = Script::WriteToBuffer(pTempStructure, pBuffer, BufferSize);
	
	delete pTempStructure;
	
	return totalSize;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

uint8* CSkaterProfile::read_extra_info_from_buffer(uint8 *pBuffer)
{
	Script::CStruct* pTempStructure = new Script::CStruct;

	pBuffer = Script::ReadFromBuffer(pTempStructure, pBuffer);

	m_Info.AppendStructure( pTempStructure );
	
	delete pTempStructure;
	
	return pBuffer;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterProfile::compress_trick_mappings( const char* pTrickMappingName )
{

	Mdl::Skate* skate_mod = Mdl::Skate::Instance();
	CTrickChecksumTable* pTrickChecksumTable = skate_mod->GetTrickChecksumTable();

	Script::CStruct* pTempStructure;
	if ( !m_Info.GetStructure( pTrickMappingName, &pTempStructure ) )
	{
		Dbg_MsgAssert( 0, ( "Trick mapping %s not found...  already compressed?", pTrickMappingName ) );
	}

	int compressed = 0;
	pTempStructure->GetInteger( Crc::ConstCRC("compressed"), &compressed );
	if ( compressed )
	{
		Dbg_MsgAssert( 0, ( "This structure is already compressed" ) );
		return;
	}

	// take all the integers, and convert them to checksums
	Script::CComponent *pComp = pTempStructure->GetNextComponent();
	while ( pComp )
	{
		Script::CComponent* pNextComp = pTempStructure->GetNextComponent( pComp );


		if (pComp && pComp->mType==ESYMBOLTYPE_NAME && pComp->mNameChecksum != Crc::ConstCRC("compressed") )
		{
			int compressedIndex = pTrickChecksumTable->GetIndexFromChecksum( pComp->mChecksum );
			if ( compressedIndex != -1 )
			{			
				uint32	nameChecksum = pComp->mNameChecksum; // Mick, need to store this now, as we are about to remove pComp
				pTempStructure->RemoveComponent( nameChecksum );
				pTempStructure->AddComponent( nameChecksum, ESYMBOLTYPE_INTEGER, compressedIndex );
			}
		}
		pComp = pNextComp;
	}

	// add the compressed flag
	pTempStructure->AddComponent( Crc::ConstCRC("compressed"), ESYMBOLTYPE_INTEGER, 1 );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterProfile::decompress_trick_mappings( const char* pTrickMappingName )
{
	
	Mdl::Skate* skate_mod = Mdl::Skate::Instance();
	CTrickChecksumTable* pTrickChecksumTable = skate_mod->GetTrickChecksumTable();
	
	Script::CStruct* pTempStructure;
	if ( !m_Info.GetStructure( pTrickMappingName, &pTempStructure ) )
	{
		Dbg_MsgAssert( 0, ( "Trick mapping %s not found...  already compressed?", pTrickMappingName ) );
	}

	int compressed = 0;
	pTempStructure->GetInteger( Crc::ConstCRC("compressed"), &compressed );
	if ( !compressed )
	{
#ifdef __NOPT_ASSERT__
		Script::PrintContents(&m_Info);
		Script::PrintContents(pTempStructure);
#endif		
		Dbg_MsgAssert( 0, ( "This structure is not compressed" ) );
		return;
	}

	// take all the integers, and convert them to checksums
	Script::CComponent *pComp = pTempStructure->GetNextComponent();
	while ( pComp )
	{
		Script::CComponent* pNextComp = pTempStructure->GetNextComponent( pComp );

		if (pComp && pComp->mType==ESYMBOLTYPE_INTEGER && pComp->mNameChecksum != Crc::ConstCRC("compressed") )
		{
			int uncompressedChecksum = pTrickChecksumTable->GetChecksumFromIndex( pComp->mIntegerValue );
			uint32	nameChecksum = pComp->mNameChecksum; // Mick, need to store this now, as we are about to remove pComp
			pTempStructure->RemoveComponent( nameChecksum );
			pTempStructure->AddComponent( nameChecksum, ESYMBOLTYPE_NAME, uncompressedChecksum );
		}

		pComp = pNextComp;
	}

	// reset the compressed flag
	pTempStructure->AddComponent( Crc::ConstCRC("compressed"), ESYMBOLTYPE_INTEGER, 0 );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterProfile::WriteIntoStructure( Script::CStruct* pStuff )
{	
	Dbg_MsgAssert(pStuff,("nullptr pStuff"));
	
	Script::CStruct *pSkaterInfo=new Script::CStruct;

	pSkaterInfo->AddComponent( Crc::ConstCRC("version_number"), ESYMBOLTYPE_INTEGER, CSkaterProfile::vVERSION_NUMBER );
	
	Script::CStruct *pTemp=nullptr;
	
	if (!IsPro())
	{
		pTemp=new Script::CStruct;
		pTemp->AppendStructure( m_Appearance.GetStructure() );
		pSkaterInfo->AddComponent( Crc::ConstCRC("Appearance"), ESYMBOLTYPE_STRUCTUREPOINTER, pTemp );
	}
		
	Gfx::CFaceTexture* pFaceTexture = m_Appearance.GetFaceTexture();
	if ( pFaceTexture && pFaceTexture->IsValid() )
	{
		pTemp=new Script::CStruct;
		pFaceTexture->WriteIntoStructure( pTemp );
		pSkaterInfo->AddComponent( Crc::ConstCRC("FaceTexture"), ESYMBOLTYPE_STRUCTUREPOINTER, pTemp );
	}

	pTemp=new Script::CStruct;
	pTemp->AppendStructure(&m_Info);
	pSkaterInfo->AddComponent( Crc::ConstCRC("Info"), ESYMBOLTYPE_STRUCTUREPOINTER, pTemp );

	uint32 Name=GetSkaterNameChecksum();
	//pSkaterInfo->AddComponent(Crc::ConstCRC("DeckFlags"),ESYMBOLTYPE_INTEGER,(int)Front::GetDeckFlags(Name));
	pSkaterInfo->AddComponent( Crc::ConstCRC("DeckFlags"), ESYMBOLTYPE_INTEGER, 0 );
	
	pStuff->AddComponent(Name, ESYMBOLTYPE_STRUCTUREPOINTER, pSkaterInfo);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterProfile::ReadFromStructure( uint32 SkaterName, Script::CStruct* pStuff )
{
	// should only get called for pros,
	// otherwise we need to implement face texture loading

	Dbg_MsgAssert(pStuff,("nullptr pStuff"));
	
	Script::CStruct *pSkaterInfo=nullptr;
	pStuff->GetStructure(SkaterName,&pSkaterInfo);
	// If no skater, just return. Could be no skater if a new skater name has been added, but autoloading off
	// a memory card with no info for that skater, so no assert.
	if (!pSkaterInfo)
	{
		return;
	}	
		
	Script::CStruct *pTemp=nullptr;
	
	// There may not be an Appearance member, eg for the Pros.	
	if (pSkaterInfo->GetStructure( Crc::ConstCRC("Appearance"), &pTemp ))
	{
		m_Appearance.Load(pTemp);
	}	
		
	pTemp=nullptr;
	pSkaterInfo->GetStructure( Crc::ConstCRC("Info"), &pTemp );
	m_Info.Clear();
	m_Info.AppendStructure( pTemp);
	
	// First deck is always unlocked, so make sure this is the default just in case DeckFlags is not found.
	int DeckFlags=1;
	pSkaterInfo->GetInteger( Crc::ConstCRC("DeckFlags"), &DeckFlags );
	
	//Front::SetDeckFlags(SkaterName,(uint32)DeckFlags);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

int CSkaterProfile::GetStatValue( uint32 property )
{
	int value;
	m_Info.GetInteger( property, &value, true );
	return value;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CSkaterProfile::SetPropertyValue( uint32 property, int value )
{
	if ( value >= 0 && value <= 10 )
	{
		m_Info.AddInteger( property, value );
		return true;
	}
	return false;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CSkaterProfile::AwardStatPoint( int inc_val )
{
	int value;
	m_Info.GetInteger( Crc::ConstCRC("points_available"), &value, true );
	value+=inc_val;
	m_Info.AddComponent( Crc::ConstCRC("points_available"), ESYMBOLTYPE_INTEGER, value );
	return true;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

int CSkaterProfile::GetNumStatPointsAvailable()
{
	int value;
	m_Info.GetInteger( Crc::ConstCRC("points_available"), &value, true );
	return value;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CSkaterProfile::AwardSpecialTrickSlot( int inc_val )
{
	int value;
	m_Info.GetInteger( Crc::ConstCRC("max_specials"), &value, true );
	value+=inc_val;
	m_Info.AddComponent( Crc::ConstCRC("max_specials"), ESYMBOLTYPE_INTEGER, value );
	return true;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

uint32 CSkaterProfile::GetNumSpecialTrickSlots( void )
{
	int value;
	m_Info.GetInteger( Crc::ConstCRC("max_specials"), &value, true );
	return value;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

SSpecialTrickInfo CSkaterProfile::GetSpecialTrickInfo( int slot_num )
{	
	SSpecialTrickInfo theInfo;
	
	Script::CStruct* pStructure = GetSpecialTricksStructure();
	Dbg_Assert( pStructure );

	Script::CArray* pArray;
	pStructure->GetArray( NONAME, &pArray, true );
	Dbg_MsgAssert( pArray->GetSize() == vMAXSPECIALTRICKSLOTS, ( "Expected %i elements in specials array instead of %d", vMAXSPECIALTRICKSLOTS, pArray->GetSize() ) );

	if ( !(slot_num >= 0 && slot_num < (int)pArray->GetSize()) )
	{
		Script::PrintContents( &m_Info );
		Script::PrintContents( pStructure );
		Dbg_MsgAssert( 0, ( "Slot index %d is out of range (must be between 0 and %d", slot_num, vMAXSPECIALTRICKSLOTS ) );
	}
	
	Script::CStruct* pSubStructure = pArray->GetStructure( slot_num );
	pSubStructure->GetChecksum( Crc::ConstCRC("trickname"), &theInfo.m_TrickName, true );
	pSubStructure->GetChecksum( Crc::ConstCRC("trickslot"), &theInfo.m_TrickSlot, true );
	int is_cat = 0;
	pSubStructure->GetInteger( Crc::ConstCRC("isCat"), &is_cat, false );
	if ( is_cat != 0 )
	{
		theInfo.m_isCat = true;
	}
	
	return theInfo;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CSkaterProfile::SetSpecialTrickInfo( int slot_num, const SSpecialTrickInfo& theInfo, bool update_mappings )
{
	Script::CStruct* pStructure = GetSpecialTricksStructure();
	Dbg_Assert( pStructure );

	Script::CArray* pArray;
	pStructure->GetArray( NONAME, &pArray, true );
	Dbg_MsgAssert( pArray->GetSize() == vMAXSPECIALTRICKSLOTS, ( "Expected %i elements in specials array instead of %d", vMAXSPECIALTRICKSLOTS, pArray->GetSize() ) );

	if ( !(slot_num >= 0 && slot_num < (int)pArray->GetSize()) )
	{
		// out of range index...
		// this is possible if you press the square button while on the "Done" element
		// this isn't the best place to screen this out, but it's the safest...
		return false;
	}
	
	uint32 trickName = theInfo.m_TrickName;
	uint32 trickSlot = theInfo.m_TrickSlot;

	if ( theInfo.IsUnassigned() )
	{
		// if the incoming trick is "unassigned"
		// then clear that slot
		trickName = Crc::ConstCRC("unassigned");
		trickSlot = Crc::ConstCRC("unassigned");
	}
	
	Script::CStruct* pSubStructure = pArray->GetStructure( slot_num );
	pSubStructure->AddComponent( Crc::ConstCRC("trickname"), ESYMBOLTYPE_NAME, (int)trickName );
	pSubStructure->AddComponent( Crc::ConstCRC("trickslot"), ESYMBOLTYPE_NAME, (int)trickSlot );

	if ( theInfo.m_isCat )
	{
		pSubStructure->AddInteger( Crc::ConstCRC("isCat"), 1 );
	}
	else
		pSubStructure->RemoveComponent( Crc::ConstCRC("isCat") );

	// now that a trick config has changed,
	// update the trick mappings on any existing skaters
	if ( update_mappings )
	{
        Mdl::Skate * pSkate = Mdl::Skate::Instance();
        Obj::CSkater* pSkater = pSkate->GetLocalSkater();
        if ( pSkater )
         {
            Obj::CTrickComponent* pTrickComponent = GetTrickComponentFromObject(pSkater);
    		Dbg_Assert( pTrickComponent );
    		pTrickComponent->UpdateTrickMappings( this );
        }
	}
	Script::RunScript( Crc::ConstCRC("disable_replays") );
	return true;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

uint32	CSkaterProfile::GetChecksumValue( uint32 field_id )
{
	uint32 value = 0;

	switch ( field_id )
	{
		case 0xc15dbf86:	// pushstyle
		{
			m_Info.GetChecksum( Crc::ConstCRC("pushstyle"), &value, true );
		}
		break;
		case 0x7d02bcc3:	// stance
		{
			m_Info.GetChecksum( Crc::ConstCRC("stance"), &value, true );
		}
		break;
		default:
			Dbg_MsgAssert( 0, ("Unrecognized property %s", Script::FindChecksumName(field_id) ) );
			break;
	}

	return value;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterProfile::SetSkaterProperty( uint32 field_id, const char* pPropertyString )
{
	Dbg_Message("Stub:  setting skater property %s: %s", Script::FindChecksumName(field_id), pPropertyString);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

Str::String	CSkaterProfile::GetUIString( const char* pFieldName )
{
	return GetUIString( Script::GenerateCRC( pFieldName ) );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

Str::String	CSkaterProfile::GetUIString( uint32 fieldID )
{
	(void)fieldID;
	return "Unimplemented";
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

Script::CStruct* CSkaterProfile::GetTrickMapping( uint32 TrickMappingName )
{
	// pTrickMapping must be "trick_mapping"...  specials are accessed through special trick slots
	Dbg_Assert( TrickMappingName==Crc::ConstCRC("trick_mapping") );
	
	Script::CStruct* pTrickMappingStructure;
	m_Info.GetStructure(TrickMappingName,&pTrickMappingStructure,Script::ASSERT);
	return pTrickMappingStructure;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

Script::CStruct* CSkaterProfile::GetSpecialTricksStructure()
{
	Script::CStruct* pTrickMappingStructure;
	m_Info.GetStructure( Crc::ConstCRC("specials"), &pTrickMappingStructure, Script::ASSERT);
	return pTrickMappingStructure;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

uint32 CSkaterProfile::GetSkaterNameChecksum( void )
{
	uint32 checksum;
	m_Info.GetChecksum( Crc::ConstCRC("name"), &checksum, true );
	return checksum;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CSkaterProfile::IsPro()
{
	int is_pro;
	m_Info.GetInteger( Crc::ConstCRC("is_pro"), &is_pro, true );
	return is_pro;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CSkaterProfile::HeadIsLocked()
{
	int is_locked;
	m_Info.GetInteger( Crc::ConstCRC("is_head_locked"), &is_locked, true );
	return is_locked;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CSkaterProfile::IsLocked()
{
	int is_locked;
	m_Info.GetInteger( Crc::ConstCRC("is_locked"), &is_locked, true );
	return is_locked;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CSkaterProfile::IsSecret()
{
	return m_Info.ContainsFlag( Crc::ConstCRC("is_secret") );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterProfile::SetHeadIsLocked( bool is_locked )
{
	m_Info.AddComponent( Crc::ConstCRC("is_head_locked"), ESYMBOLTYPE_INTEGER, (int)is_locked );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

const char *CSkaterProfile::GetCASFileName()
{
	const char *p_file_name="Unimplemented";
	m_Info.GetString( Crc::ConstCRC("CASFileName"), &p_file_name);
	return p_file_name;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterProfile::SetCASFileName(const char *pFileName)
{
	m_Info.AddString( Crc::ConstCRC("CASFileName"), pFileName );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

const char* CSkaterProfile::GetDisplayName()
{
	const char* pDisplayName;
	m_Info.GetText( Crc::ConstCRC("display_name"), &pDisplayName, Script::ASSERT );
	return pDisplayName;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterProfile::ResetDefaultAppearance()
{
	Dbg_Message( "Stub:  Reset appearance here" );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterProfile::ResetDefaultStats()
{
	Dbg_Message( "Stub:  Reset stats here" );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CSkaterProfile::ResetDefaultTricks()
{
	Dbg_Message( "Stub:  Reset tricks here" );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

} // namespace Obj
