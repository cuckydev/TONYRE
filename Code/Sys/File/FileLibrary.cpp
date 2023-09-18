//****************************************************************************
//* MODULE:         File
//* FILENAME:       FileLibrary.cpp
//* OWNER:          Gary Jesdanun
//* CREATION DATE:  01/21/2003
//****************************************************************************

/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/

#include <Sys/File/FileLibrary.h>

#include <Sys/File/AsyncFilesys.h>
#include <Sys/File/filesys.h>
#include <Gel/Scripting/checksum.h>
#include <Gel/Scripting/script.h>

#include <Sys/Mem/memman.h>

/*****************************************************************************
**								DBG Information								**
*****************************************************************************/

namespace File
{

/*****************************************************************************
**								  Externals									**
*****************************************************************************/

/*****************************************************************************
**								   Defines									**
*****************************************************************************/

/*****************************************************************************
**								Private Types								**
*****************************************************************************/

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

struct SLibHeader
{
	uint32	versionNumber;
	int		numFiles;
};

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
**							  Private Functions								**
*****************************************************************************/

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void filesync_async_callback(File::CAsyncFileHandle*, File::EAsyncFunctionType function, int result, unsigned int arg0, unsigned int arg1)
{
	// Dbg_Message("Got callback from %x", arg0);
	if (function == File::FUNC_READ)
	{
		CFileLibrary* p_data = (CFileLibrary*)arg0;
		bool assertOnFail = (bool)arg1;

		p_data->PostLoad( assertOnFail, result );
	}
}

/*****************************************************************************
**							  Public Functions								**
*****************************************************************************/

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
				   
CFileLibrary::CFileLibrary()
{
#ifndef __PLAT_NGC__
	mp_baseBuffer = nullptr;
	mp_fileBuffer = nullptr;
#endif		// __PLAT_NGC__
	mp_fileHandle = nullptr;
	m_dataLoaded = false;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CFileLibrary::~CFileLibrary()
{
#ifdef __PLAT_NGC__
	NsARAM::free( m_aramOffset );
#else
	if ( mp_baseBuffer )
	{
		delete[] mp_baseBuffer;
		mp_baseBuffer = nullptr;
	}
#endif		// __PLAT_NGC__
	
	if ( mp_fileHandle )
	{
		Dbg_MsgAssert( m_dataLoaded, ( "Can't delete CFileLibrary while it is still being loaded" ) );
		File::CAsyncFileLoader::sClose( mp_fileHandle );
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
				   
bool CFileLibrary::LoadFinished() const
{
	return m_dataLoaded;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CFileLibrary::PostLoad( bool assertOnFail, int file_size )
{
	(void)assertOnFail;

	// Handle end of async, if that was used
	if ( mp_fileHandle )
	{
		File::CAsyncFileLoader::sClose( mp_fileHandle );
		mp_fileHandle = nullptr;
	}
	
	Dbg_MsgAssert( (file_size & 0x3) == 0, ( "Size of file is not multiple of 4 (%d bytes)", file_size ) );

	char *pFileData = mp_fileBuffer;
	SLibHeader* pHeader = (SLibHeader*)pFileData;
	
	pFileData += sizeof( SLibHeader );
#ifndef __PLAT_NGC__
	if ( pFileData > ( mp_fileBuffer + file_size ) )
	{
		// out of bounds
		goto load_fail;
	}
#endif		// __PLAT_NGC__

	m_numFiles = pHeader->numFiles;

#ifndef __PLAT_NGC__
	Dbg_MsgAssert( m_numFiles > 0, ( "No files found in lib mp_fileBuffer = %p", mp_fileBuffer ) );
    Dbg_MsgAssert( m_numFiles < vMAX_LIB_FILES, ( "Too many subfiles found in lib (%d files, max=%d)", m_numFiles, vMAX_LIB_FILES ) );
#endif		// __PLAT_NGC__

	// read in table of contents information
	memcpy( &m_fileInfo, pFileData, (sizeof(SFileInfo) * m_numFiles) );
	pFileData += (sizeof(SFileInfo) * m_numFiles);
#ifndef __PLAT_NGC__
	if ( pFileData > ( mp_fileBuffer + file_size ) )
	{
		// out of bounds
		goto load_fail;
	}
#endif		// __PLAT_NGC__
	
	for ( int i = 0; i < m_numFiles; i++ )
	{
#ifdef __PLAT_NGC__
		m_fileOffsets[i] = (uint32)(m_aramOffset + m_fileInfo[i].fileOffset);
		mp_filePointers[i] = nullptr;
#else
		mp_filePointers[i] = (uint32*)(mp_fileBuffer + m_fileInfo[i].fileOffset);
#endif		// __PLAT_NGC__
		Dbg_Message( "File %d @ %08x %s [%d bytes]", i, m_fileInfo[i].fileNameChecksum, Script::FindChecksumName(m_fileInfo[i].fileExtensionChecksum), m_fileInfo[i].fileSize );
	}
	
#if 0
#ifndef __PLAT_NGC__
	// to reduce the amount of temp memory needed, we first load the LIB file
	// on the bottom up heap, and then copy sub-file individually onto the top
	// down heap (as we reallocate shrink the original LIB file on the bottom up heap)
	for ( int i = m_numFiles - 1; i >= 0; i-- )
	{
		int file_size = m_fileInfo[i].fileSize;
		
		uint32* pTempFilePointer = mp_filePointers[i];
		
		// GJ:  When I first wrote this class, I wanted to make it generic, 
		// but it gradually became more cutscene-specific to fix
		// memory issues.  For example, the following uses the
		// "cutscene heap" to reduce temp memory overhead.  Perhaps
		// later on, I can just store the appropriate top/bottomheap pointers
		// during initialization
		Dbg_MsgAssert( Mem::Manager::sHandle().CutsceneTopDownHeap(), ( "No cutscene heap?" ) ); 
		Mem::Manager::sHandle().PushContext(Mem::Manager::sHandle().CutsceneTopDownHeap());
		mp_filePointers[i] = (uint32*)Mem::Malloc( file_size );
		memcpy( mp_filePointers[i], pTempFilePointer, file_size );
		Mem::Manager::sHandle().PopContext();
		
#ifdef	__NOPT_ASSERT__
		uint8* pOldBuffer = mp_baseBuffer;
#endif
		
		Dbg_MsgAssert( Mem::Manager::sHandle().CutsceneBottomUpHeap(), ( "No cutscene heap?" ) ); 
		Mem::Manager::sHandle().PushContext(Mem::Manager::sHandle().CutsceneBottomUpHeap());
		mp_baseBuffer = (uint8*)Mem::ReallocateShrink( Mem::GetAllocSize(mp_baseBuffer) - file_size, mp_baseBuffer );
		Dbg_MsgAssert( mp_baseBuffer == pOldBuffer, ( "Pointer was not supposed to change except for shrinking" ) );
		Mem::Manager::sHandle().PopContext();
	}

	// by this point, all that should be left in the original block
	// is the header, which we don't need any more
	Mem::Free( mp_baseBuffer );
	mp_baseBuffer = nullptr;
	mp_fileBuffer = nullptr;
#endif		// __PLAT_NGC__
#endif

	// if the data is ready to be accessed
	m_dataLoaded = true;

	return true;

#ifndef __PLAT_NGC__
load_fail:
	Dbg_MsgAssert( 0, ( "Parsing of library failed" ) );
	return false;
#endif		// __PLAT_NGC__
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool CFileLibrary::Load( const char* p_fileName, bool assertOnFail, bool async_load )
{
	Dbg_MsgAssert( !async_load, ( "Cutscenes aren't supposed to be async loaded anymore" ) );
	int file_size;
	
	mp_baseBuffer = LoadAlloc( p_fileName, &file_size );
	mp_fileBuffer = mp_baseBuffer;
	
	return PostLoad(assertOnFail, file_size);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
				   
int CFileLibrary::GetNumFiles() const 
{
	return m_numFiles;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
				   
uint32* CFileLibrary::GetFileData( int index )
{
	Dbg_MsgAssert( index >= 0 && index < m_numFiles, ( "Out of range file index %d", index ) );
	return mp_filePointers[index];
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
				   
const SFileInfo* CFileLibrary::GetFileInfo( int index ) const
{
	Dbg_MsgAssert( index >= 0 && index < m_numFiles, ( "Out of range file index %d", index ) );
	return &m_fileInfo[index];
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
				   
const SFileInfo* CFileLibrary::GetFileInfo( uint32 name, uint32 extension, bool assertOnFail ) const
{
	for ( int index = 0; index < m_numFiles; index++ )
	{
		if ( m_fileInfo[index].fileNameChecksum == name && m_fileInfo[index].fileExtensionChecksum == extension )
		{
			return &m_fileInfo[index];
		}
	}

	if ( assertOnFail )
	{
		Dbg_MsgAssert( 0, ( "Couldn't find file %08x %08x\n", name, extension ) );
	}

	return nullptr;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
				   
uint32* CFileLibrary::GetFileData( uint32 name, uint32 extension, bool assertOnFail )
{
	for ( int index = 0; index < m_numFiles; index++ )
	{
		if ( m_fileInfo[index].fileNameChecksum == name && m_fileInfo[index].fileExtensionChecksum == extension )
		{
			return GetFileData( index );
		}
	}

	if ( assertOnFail )
	{
		Dbg_MsgAssert( 0, ( "Couldn't find file %08x %08x\n", name, extension ) );
	}

	return nullptr;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
				   
bool CFileLibrary::ClearFile( uint32 name, uint32 extension )
{
	bool success = false;

	for ( int index = 0; index < m_numFiles; index++ )
	{
		if ( m_fileInfo[index].fileNameChecksum == name && m_fileInfo[index].fileExtensionChecksum == extension )
		{
			// Mem::Free( mp_filePointers[index] );
			mp_filePointers[index] = nullptr;
			success = true;
		}
	}

	return success;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
				   
bool CFileLibrary::FileExists( uint32 name, uint32 extension )
{
	for ( int index = 0; index < m_numFiles; index++ )
	{
		if ( m_fileInfo[index].fileNameChecksum == name && m_fileInfo[index].fileExtensionChecksum == extension )
		{
			return true;
		}
	}

	return false;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
				   
} // namespace File
