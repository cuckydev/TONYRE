/*****************************************************************************
**																			**
**			              Neversoft Entertainment.			                **
**																		   	**
**				   Copyright (C) 2000 - All Rights Reserved				   	**
**																			**
******************************************************************************
**																			**
**	Project:		skate3													**
**																			**
**	Module:									 								**
**																			**
**	File name:																**
**																			**
**	Created by:		rjm														**
**																			**
**	Description:						 									**
**																			**
*****************************************************************************/

// start autoduck documentation
// @DOC pre
// @module pre | None
// @subindex Scripting Database
// @index script | pre

/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/

#include <Core/Defines.h>
//#include <Core/HashTable.h>
#include <Core/StringHashTable.h>
#include <Sys/File/PRE.h>
#include <Sys/File/filesys.h>
#include <Sys/File/AsyncFilesys.h>
#include <Sys/Config/config.h>

// cd shared by the music streaming stuff...  ASSERT if file access attempted
// while music is streaming:
#include <Gel/Music/music.h>

// script stuff
#include <Gel/Scripting/struct.h> 
#include <Gel/Scripting/symboltable.h>

#include <cstring>

/*****************************************************************************
**								DBG Information								**
*****************************************************************************/

#define DEBUG_PRE 0

#define	PRE_NAME_OFFSET 16		// was 12, but then I added an extra checksum field

namespace File
{



/*****************************************************************************
**								  Externals									**
*****************************************************************************/

/*****************************************************************************
**								   Defines									**
*****************************************************************************/

#define CURRENT_PRE_VERSION	0xabcd0003			// as of 3/14/2001
//#define CURRENT_PRE_VERSION	0xabcd0001		// until 3/14/2001

#define RINGBUFFERSIZE		 4096	/* N size of ring buffer */	
#define MATCHLIMIT		   18	/* F upper limit for match_length */
#define THRESHOLD	2   /* encode string into position and length */

#define WriteOut(x) 	{*pOut++ = x;}

/*****************************************************************************
**								Private Types								**
*****************************************************************************/

/*****************************************************************************
**								 Private Data								**
*****************************************************************************/

PreMgr *PreMgr::sp_mgr = nullptr;
bool    PreMgr::s_lastExecuteSuccess = false; 

/*****************************************************************************
**								 Public Data								**
*****************************************************************************/

/*****************************************************************************
**							  Private Prototypes							**
*****************************************************************************/

/*****************************************************************************
**							  Private Functions								**
*****************************************************************************/



#define USE_BUFFER	1		 // we don't need no stinking buffer!!!!
 
#if USE_BUFFER
#ifdef	__PLAT_NGPS__
// ring buffer is just over 4K 4096+17), 
// so fits nicely in the PS2's 16K scratchpad 
unsigned char	text_buf[RINGBUFFERSIZE + MATCHLIMIT - 1];	
// Note:  if we try to use the scratchpad, like this
// then the code actually runs slower
// if we want to optimize this, then it should
// be hand crafted in assembly, using 128bit registers
//	const unsigned char * text_buf = (unsigned char*) 0x70000000;
//	#define text_buf ((unsigned char*) 0x70000000)
#else
unsigned char
		text_buf[RINGBUFFERSIZE + MATCHLIMIT - 1];	/* ring buffer of size N,
			with extra F-1 bytes to facilitate string comparison */
#endif
#endif


#define	ReadInto(x)		if (!Len) break; Len--; x = *pIn++ 
#define	ReadInto2(x)	Len--; x = *pIn++ 	  // version that knows Len is Ok


// Decode an LZSS encoded stream
// Runs at approx 12MB/s on PS2	 without scratchpad (which slows it down in C)
// a 32x CD would run at 4.8MB/sec, although we seem to get a lot less than this
// with our current file system, more like 600K per seconds.....
// Need to write a fast streaming file system....

void DecodeLZSS(unsigned char *pIn, unsigned char *pOut, int Len)	/* Just the reverse of Encode(). */
{
	int  i, j, k, r, c;
//	uint64	LongWord;
//	int bytes = 0;
//	unsigned char *pScratch;
	unsigned int  flags;

	// Ensure we have decent values for the decode length
	Dbg_Assert(( Len >= 0 ) && ( Len < 0x2000000 ));

	if(( Len < 0 ) || ( Len >= 0x2000000 ))
	{
		while( 1 );
	}


//	int basetime =  (int) Tmr::ElapsedTime(0);
//	int len = Len;

//	int	OutBytes = 4;
//	int	OutWord = 0;

	#if USE_BUFFER
	for (i = 0; i < RINGBUFFERSIZE - MATCHLIMIT; i++)
		 text_buf[i] = ' ';
	r = RINGBUFFERSIZE - MATCHLIMIT;
	#else
	r = RINGBUFFERSIZE - MATCHLIMIT;
	#endif
	flags = 0;
	for ( ; ; )
	{
		if (((flags >>= 1) & 256) == 0)
		{
			ReadInto(c);
			flags = c | 0xff00;			/* uses higher byte cleverly */
		}										/* to count eight */
		if (flags & 1)
		{
			ReadInto(c);
			//			putc(c, outfile);
			WriteOut((unsigned char)c);
			#if USE_BUFFER
			text_buf[r++] = (unsigned char)c;
			r &= (RINGBUFFERSIZE - 1);
			#else
			r++;
//			r &= (RINGBUFFERSIZE - 1);	  // don't need to wrap r until it is used
			#endif
		}
		else
		{
			ReadInto(i);			
			ReadInto2(j);			// note, don't need to check len on this one.... 
			
			i |= ((j & 0xf0) << 4);						// i is 12 bit offset
			
			#if !USE_BUFFER
			j = (j & 0x0f) + THRESHOLD+1;				// j is 4 bit length (above the threshold)
			unsigned char *pStream;
			r &= (RINGBUFFERSIZE - 1);					// wrap r around before it is used
			pStream = pOut - r;					  		// get base of block
			if (i>=r)										// if offset > r, then
				pStream -= RINGBUFFERSIZE;				// it's the previous block
			pStream += i;									// add in the offset to the base
			r+=j;												// add size to r
			while (j--)										// copy j bytes
				WriteOut(*pStream++);
			#else
			
			j = (j & 0x0f) + THRESHOLD;				// j is 4 bit length (above the threshold)
			for (k = 0; k <= j; k++)					// just copy the bytes
			{
				c =  text_buf[(i+k) & (RINGBUFFERSIZE - 1)]; 
				WriteOut((unsigned char)c);
				text_buf[r++] = (unsigned char)c;
				r &= (RINGBUFFERSIZE - 1);
			}
			#endif
		}
	}
//	int Time = (int) Tmr::ElapsedTime(basetime);
//	if (Time > 5)
//	{
//		printf("decomp time is %d ms, for %d bytes,  %d bytes/second\n", Time,len, len * 1000 /Time );
//	}

}

void EndOfDecodeLZSS( void )
{
} 


void PreFile::s_delete_file(_File *pFile, void *pData)
{
	(void)pData;

	Dbg_Assert(pFile);
	delete pFile;
}




PreFile::PreFile(char *p_file_buffer, bool useBottomUpHeap)
{
	m_use_bottom_up_heap=useBottomUpHeap;
	
	mp_table = new Lst::StringHashTable<_File>(4);	

	Dbg_AssertPtr(p_file_buffer);

	mp_buffer = p_file_buffer;
	#ifdef __NOPT_ASSERT__
	uint version = 	*((int *) (mp_buffer + 4));
	Dbg_MsgAssert(version == CURRENT_PRE_VERSION,( "PRE file version (%x) not current (%x)",version,CURRENT_PRE_VERSION));
	#endif
	m_numEntries = *((int *)(mp_buffer + 8));

	char *pEntry = mp_buffer + 12;
	for (int i = 0; i < m_numEntries; i++)
	{
		int data_size 				= *((int *) pEntry);
		int compressed_data_size 	= *((int *) (pEntry + 4));
		int text_size	 			= *((short *) (pEntry + 8));
		int actual_data_size = (compressed_data_size != 0) ? compressed_data_size : data_size;
		
		char *pName = pEntry + PRE_NAME_OFFSET;
		char *pCompressedData = pEntry + PRE_NAME_OFFSET + text_size;
		
		_File *pFile = new _File;

		if (!mp_table->GetItem(pName)) 
		{
			// file is not in table, safe to add
			mp_table->PutItem(pName, pFile);
			
			pFile->compressedDataSize = compressed_data_size;
			pFile->pCompressedData = pCompressedData; 
			pFile->pData = nullptr;
			pFile->m_position = 0;
			pFile->m_filesize = data_size;
		}
		else
			// Somehow, file is already in table, just kill it
			// Later, I'll want to add an assert
			delete pFile;
		
#		if DEBUG_PRE
		printf("   %s, size %d\n", pName, data_size);
#		endif
		
		pEntry += PRE_NAME_OFFSET + text_size + ((actual_data_size + 3) & (~3));
	}

#	if DEBUG_PRE
	printf("Done loading PRE\n");
#	endif
	
	mp_activeFile = nullptr;
	m_numOpenAsyncFiles = 0;
}



PreFile::~PreFile()
{
	delete[] mp_buffer;
	mp_table->HandleCallback(s_delete_file, nullptr);
	mp_table->FlushAllItems();

	delete mp_table;

	Dbg_MsgAssert(m_numOpenAsyncFiles == 0, ("Can't unload Pre because there are still %d async files open", m_numOpenAsyncFiles));
}


bool PreFile::FileExists(const char *pName)
{
	
	_File *pFile = mp_table->GetItem(pName, false);
	return (pFile != nullptr);
}

// returns handle pointer
PreFile::FileHandle *PreFile::GetContainedFile(const char *pName)
{
	
	_File *pFile = mp_table->GetItem(pName, false);
	if (!pFile) 
		return nullptr;
	
	PreFile::FileHandle *pHandle = pFile;
	//// kinda roundabout, but sets mp_activeFile
	GetContainedFileByHandle(pHandle);
	
#ifdef __PLAT_NGC__
	NsDisplay::doReset();
#endif		// __PLAT_NGC__

	// do we need to fetch file data?
	if (!mp_activeFile->pData)
	{
		if (mp_activeFile->compressedDataSize)
		{
			mp_activeFile->pData = new char[mp_activeFile->m_filesize];
			// need to uncompress data
			DecodeLZSS((unsigned char*)mp_activeFile->pCompressedData, (unsigned char *)mp_activeFile->pData, (int)mp_activeFile->compressedDataSize);
		}
	}

	

	return pHandle;
}


// allocate memory and load file directly from a pre file, if it is there
// This avoids the problem of having to have the decompressed file in memory twice
// when we are loading directly, like with Pip::Load()
// using this enables us to actually load network game, where there is 1MB less heap during loading
//
// returns a pointer to the file in memory
// or nullptr if the file is not in this pre file.
// optional parameter p_dest, if set to anything other then nullptr, then load file to this destination
char *PreFile::LoadContainedFile(const char *pName, size_t *p_size, char *p_dest)
{

//	printf ("LoadContainedFile(%s\n",pName);
	
	_File *pFile = mp_table->GetItem(pName, false);
	if (!pFile)
		return nullptr;
	
	*p_size = pFile->m_filesize;

	// If destination was passed as nullptr, then allocate memory	
	if (!p_dest)
		p_dest = new char[pFile->m_filesize];
	
	// do we need to deompress file data?
	if (!pFile->pData)
	{
		if (pFile->compressedDataSize)
		{
			// need to uncompress data
			//DecodeLZSS(mp_activeFile->pCompressedData, mp_activeFile->pData, mp_activeFile->compressedDataSize);	
			DecodeLZSS((unsigned char*)pFile->pCompressedData, (unsigned char*)p_dest, (int)pFile->compressedDataSize);	
		}
		else
		{
			memcpy(p_dest,(void*)pFile->pCompressedData,pFile->m_filesize);
		}
	}
	else
	{
//		printf ("Copying %d bytes from %p to %p\n",pFile->sky.SOF,p_dest,(void*)pFile->pData);
		memcpy(p_dest,(void*)pFile->pData,pFile->m_filesize);
	}
	return  p_dest;
}
	


char *PreFile::GetContainedFileByHandle(PreFile::FileHandle *pHandle)
{
	mp_table->IterateStart();
	_File *pFile = mp_table->IterateNext();
	while(pFile)
	{
		char *pCompressedData = pFile->pCompressedData;
		if (pCompressedData && pFile == pHandle)
		{
			mp_activeFile = pFile;
			
			if (mp_activeFile->compressedDataSize)
				return mp_activeFile->pData;
			else
				return mp_activeFile->pCompressedData;
		}
		pFile = mp_table->IterateNext();
	}

	return nullptr;
}



void PreFile::Reset()
{
	
	Dbg_AssertPtr(mp_activeFile);

	mp_activeFile->m_position = 0;
}



size_t PreFile::Read(void *addr, size_t count)
{
	
	Dbg_AssertPtr(mp_activeFile);

	size_t seek_offs = mp_activeFile->m_position;
	size_t limit = mp_activeFile->m_filesize - seek_offs;
	size_t copy_number = (count <= limit) ? count : limit;
	if (mp_activeFile->compressedDataSize)
	{
		Dbg_MsgAssert(mp_activeFile->pData,( "file not uncompressed"));
		memcpy(addr, mp_activeFile->pData + mp_activeFile->m_position, copy_number);
	}
	else
	{
		memcpy(addr, mp_activeFile->pCompressedData + mp_activeFile->m_position, copy_number);
	}

	mp_activeFile->m_position += copy_number;

#if DEBUG_PRE
		printf("PRE: read %d bytes from file, handle 0x%x\n", copy_number, (int) mp_activeFile->pData);
#endif
	return copy_number;
}



int PreFile::Eof()
{
	
	Dbg_AssertPtr(mp_activeFile);

	if (mp_activeFile->m_position >= mp_activeFile->m_filesize)
	{
#if DEBUG_PRE
		printf("PRE: at end of file\n");
#endif
		return 1;
	}

#if DEBUG_PRE
	printf("PRE: not at end of file\n");
#endif
	return 0;
}



void PreFile::Open(bool async)
{
	if (async)
	{
		m_numOpenAsyncFiles++;
	}
}

void PreFile::Close(bool async)
{
	
	//Dbg_MsgAssert(mp_activeFile->pData,( "file not uncompressed"));

	if (mp_activeFile->pData)
		delete mp_activeFile->pData;
	mp_activeFile->pData = nullptr;

	if (async)
	{
		m_numOpenAsyncFiles--;
		Dbg_MsgAssert(m_numOpenAsyncFiles >= 0, ("PreFile: m_numOpenAsyncFiles is negative after Close()"));
	}
}



int PreFile::Seek(ptrdiff_t offset, int origin)
{
	size_t old_pos = mp_activeFile->m_position;

	// SEEK_CUR, SEEK_END, SEEK_SET
	switch(origin)
	{
		case SEEK_CUR:
			mp_activeFile->m_position += offset;
			break;
		case SEEK_END:
			mp_activeFile->m_position = mp_activeFile->m_filesize - offset;
			break;
		case SEEK_SET:
			mp_activeFile->m_position = (size_t)offset;
			break;
		default:
			return -1;
	}

	if (mp_activeFile->m_position > mp_activeFile->m_filesize)
	{
		mp_activeFile->m_position = old_pos;
		return -1;
	}

	return 0;
}



PreMgr::PreMgr() 
{
	mp_table = new Lst::StringHashTable<PreFile>(4);

	sp_mgr = this;


	mp_activeHandle = nullptr;
	mp_activeData = nullptr;

	mp_activeNonPreHandle = nullptr;

	m_num_pending_pre_files = 0;
}



PreMgr::~PreMgr()
{
	delete mp_table;
}



// Returns handle
// Not frequently called
PreFile::FileHandle *PreMgr::getContainedFile(const char *pName)
{
	
	Dbg_AssertPtr(pName);

	// replace all '/' with '\'
	char cleaned_name[128];
	const char *pCharIn = pName;
	char *pCharOut = cleaned_name;
	while (1)
	{
		*pCharOut = *pCharIn;
		if (*pCharIn == '\0') break;
		if (*pCharOut == '/') *pCharOut = '\\';
		pCharIn++;
		pCharOut++;		
	}

	PreFile::FileHandle *pHandle = nullptr;

	mp_table->IterateStart();
	PreFile *pPre = mp_table->IterateNext();
	while(pPre)
	{
		pHandle = pPre->GetContainedFile(cleaned_name);
		if (pHandle) 
		{
			mp_activePre = pPre;
			mp_activeHandle = pHandle;
			mp_activeData = pPre->GetContainedFileByHandle(pHandle);
#			ifdef __PLAT_NGPS__
			scePrintf("+++ %s is in PRE\n", cleaned_name);
#			endif
			return pHandle;
		}
		pPre = mp_table->IterateNext();
	}

#	ifdef __PLAT_NGPS__
	scePrintf("--- %s not found in PRE\n", cleaned_name);
#	endif
	return nullptr;
}

// returns true if the file exists in any of the pre files
bool	PreMgr::fileExists(const char *pName)
{
	Dbg_AssertPtr(pName);
	// replace all '/' with '\'
	char cleaned_name[128];
	const char *pCharIn = pName;
	char *pCharOut = cleaned_name;
	while (1)
	{
		*pCharOut = *pCharIn;
		if (*pCharIn == '\0') break;
		if (*pCharOut == '/') *pCharOut = '\\';
		pCharIn++;
		pCharOut++;		
	}

	mp_table->IterateStart();
	PreFile *pPre = mp_table->IterateNext();
	while(pPre)
	{
		if (pPre->FileExists(cleaned_name))
		{
			return true;
		}
		pPre = mp_table->IterateNext();
	}
	return false;
}



// returns pointer to data
char *PreMgr::getContainedFileByHandle(PreFile::FileHandle *pHandle)
{
	
	Dbg_AssertPtr(pHandle);

	// if we know that the file in question is not in the PRE system,
	// then it's a regular file, don't waste time looking for it
	if (mp_activeNonPreHandle == pHandle)
		return nullptr;
	
	if (mp_activeHandle == pHandle)
		// mp_activePre will be unchanged
		return mp_activeData;
	
	char *pData = nullptr;
	mp_table->IterateStart();
	PreFile *pPre = mp_table->IterateNext();
	while(pPre)
	{
		pData = pPre->GetContainedFileByHandle(pHandle);
		if (pData)
		{
			mp_activePre = pPre;
			mp_activeHandle = pHandle;
			mp_activeData = pData;			
			return pData;
		}
		pPre = mp_table->IterateNext();
	}

	// obviously this file is not in the PRE system, mark as such
	mp_activeNonPreHandle = pHandle;
	return nullptr;
}



// there's a wrapper around this now, so that we can do
// some memory-context switching
void PreMgr::loadPre(const char *pFilename, bool async, bool dont_assert, bool useBottomUpHeap)
{
#ifdef DVDETH
	m_blockPreLoading = true;
#else
	m_blockPreLoading = (bool) Script::GetInt("block_pre_loading", false);
#endif		// DVDETH 

	if (m_blockPreLoading)
		return;

	// Turn off async for platforms that don't support it
	if (!File::CAsyncFileLoader::sAsyncSupported())
	{
		async = false;
	}

	if( !async && Pcm::UsingCD() )
	{
		Dbg_MsgAssert( 0,( "File access forbidden while PCM audio is in progress." ));
		return;
	}

	// Moved this to below the Pcm::UsingCD() call as that is used (bad!!) to turn off
	// music and streams.
#	ifdef __PLAT_NGPS__
//	scePrintf("Loading PRE file %s...\n", pFilename);
#	endif

	char fullname[256];
	sprintf(fullname, "pre\\%s", pFilename);

	#ifdef TONYRE_THUG2
	fullname[strlen(fullname) - 1] = 'x';
	#endif

#if !defined( __PLAT_NGC__ ) || ( defined( __PLAT_NGC__ ) && !defined( __NOPT_FINAL__ ) )
	Tmr::Time basetime = Tmr::ElapsedTime(0);
#endif

	size_t file_size;
	char *pFile = nullptr;

	// Try loading asynchronously
	if (async)
	{
		Dbg_MsgAssert(m_num_pending_pre_files < MAX_NUM_ASYNC_LOADS, ("Too many async LoadPre's pending"));

		CAsyncFileHandle *p_fileHandle = CAsyncFileLoader::sOpen( fullname, !async );
		if (p_fileHandle)
		{
			Dbg_Assert(0);
			return;
			#if 0
			Dbg_MsgAssert(strlen(pFilename) < MAX_COMPACT_FILE_NAME, ("Pre file name %s is greater than %d bytes", pFilename, MAX_COMPACT_FILE_NAME - 1));

			// Add to pending list
			strcpy(m_pending_pre_files[m_num_pending_pre_files].m_file_name, pFilename);
			m_pending_pre_files[m_num_pending_pre_files++].mp_file_handle = p_fileHandle;

			file_size = p_fileHandle->GetFileSize();
			Dbg_MsgAssert(file_size, ("Pre file size is 0"));

			pFile = new char[file_size];

			// Set the callback
			p_fileHandle->SetCallback(async_callback, (unsigned int) this, (unsigned int) pFile);

			// read the file in
			p_fileHandle->Read( pFile, 1, file_size );
			return;
			#endif
		}
	}

	// If we got here, we didn't do an async load
	file_size = CanFileBeLoadedQuickly( fullname );
	if ( file_size )
	{
		pFile = new char[file_size];
		bool fileLoaded = LoadFileQuicklyPlease( fullname, pFile );
		if ( !fileLoaded )
		{
			printf( "pre file %s failed to load quickly.\n", fullname );
			Dbg_MsgAssert( 0,( "Fire Matt - pre file didn't load quickly." ));
		}
	}
	else
	{
			void *fp = File::Open(fullname, "rb");
			if (!fp)
			{
			// always run the code below if CD build
				if (dont_assert || Config::CD()) 
				{
					printf("couldn't open %s\n", fullname);
					return;
				}
				Dbg_MsgAssert(0,( "couldn't open %s\n", fullname));
			}


			file_size = File::GetFileSize(fp);
			
			pFile = new char[file_size];
			File::Read(pFile, 1, file_size, fp);

			size_t read_file_size = *((uint32 *) pFile);
			Dbg_MsgAssert(file_size == read_file_size,( "%s has incorrect file size: %d vs. expected %d\n", fullname, file_size, read_file_size));
			if (Config::CD())
			{
				if (file_size != read_file_size) printf("%s has incorrect file size\n", fullname);
			}

			File::Close(fp);
		}

#	if !defined( __PLAT_NGC__ ) || ( defined( __PLAT_NGC__ ) && !defined( __NOPT_FINAL__ ) )
	printf("load time for file %s size %zu is %d ms\n", pFilename, file_size, (int) Tmr::ElapsedTime(basetime));
#endif

	// the PRE file object winds up at the top of the heap, too. This is fine because
	// it will be unloaded at the same time as the big file buffer
	if (useBottomUpHeap)
	{
		if (!mp_table->PutItem(pFilename, new PreFile(pFile,useBottomUpHeap)))
			Dbg_MsgAssert(0,( "PRE %s loaded twice", pFilename));
	}
	else
	{
		if (!mp_table->PutItem(pFilename, new PreFile(pFile)))
			Dbg_MsgAssert(0,( "PRE %s loaded twice", pFilename));
	}		
}

// Finishes the loading sequence
void   	PreMgr::postLoadPre(CAsyncFileHandle *p_file_handle, char *pData, int size)
{
	(void)size;

	// Find entry in pending list
	for (int i = 0; i < m_num_pending_pre_files; i++)
	{
		if (m_pending_pre_files[i].mp_file_handle == p_file_handle)
		{
			// the PRE file object winds up at the top of the heap, too. This is fine because
			// it will be unloaded at the same time as the big file buffer
			if (!mp_table->PutItem(m_pending_pre_files[i].m_file_name, new PreFile(pData)))
			{
				Dbg_MsgAssert(0,( "PRE %s loaded twice", m_pending_pre_files[i].m_file_name));
			}

			// Copy last one to this position
			m_pending_pre_files[i] = m_pending_pre_files[--m_num_pending_pre_files];
			return;
		}
	}

	Dbg_MsgAssert(0, ("PreMgr::postLoadPre(): Can't find entry in pending Pre file list"));
}

// Handles all the async callbacks.  Makes sure we only do something on the appropriate callback
void	PreMgr::async_callback(CAsyncFileHandle *p_file_handle, EAsyncFunctionType function,
							   int result, unsigned int arg0, unsigned int arg1)
{
	(void)p_file_handle;
	(void)function;
	(void)result;
	(void)arg0;
	(void)arg1;
}

// Returns point in string where it will fit in compact space
char *	PreMgr::getCompactFileName(char *pName)
{
	size_t length = strlen(pName);

	if (length < MAX_COMPACT_FILE_NAME)
	{
		return pName;
	}
	else
	{
		size_t offset = length - (MAX_COMPACT_FILE_NAME - 1);

		return pName + offset;
		//return (char *) ((int) pName + offset);
	}
}

/*****************************************************************************
**							  Public Functions								**
*****************************************************************************/


DefineSingletonClass(PreMgr, "PRE Manager");



bool PreMgr::InPre(const char *pFilename)
{
	

	return mp_table->GetItem( pFilename );
}



void PreMgr::LoadPre(const char *pFilename, bool async, bool dont_assert, bool useBottomUpHeap)
{
	loadPre(pFilename, async, dont_assert, useBottomUpHeap);
}


// This function exisits for historical reasons
void PreMgr::LoadPrePermanently(const char *pFilename, bool async, bool dont_assert)
{

	// Load the pre file...
	// This will go on the top-down heap by default
	LoadPre(pFilename, async, dont_assert);

}



void PreMgr::UnloadPre(const char *pFilename, bool dont_assert)
{
#	ifdef __PLAT_NGPS__
//	scePrintf("Unloading PRE file %s\n", pFilename);
#	endif
	//printf("Unloading PRE file %s\n", pFilename);
	
	if (m_blockPreLoading)
		return;
	
	PreFile *pThePre = mp_table->GetItem(pFilename);
	if (!pThePre)
	{
		if (dont_assert) return;
#	ifndef __PLAT_NGC__
		Dbg_MsgAssert(0,( "PRE file %s not in PRE manager", pFilename));
#	endif
	}

	mp_table->FlushItem(pFilename);
	delete pThePre;
}

bool PreMgr::IsLoadPreFinished(const char *pFilename)
{
	// If it's in the pending list, it isn't done loading
	for (int i = 0; i < m_num_pending_pre_files; i++)
	{
		if (strcmp(m_pending_pre_files[i].m_file_name, pFilename) == 0)
		{
			return false;
		}
	}

	Dbg_MsgAssert(InPre(pFilename), ("IsLoadPreFinished(): Can't find Pre file"));

	return true;
}

bool PreMgr::AllLoadPreFinished()
{
	return m_num_pending_pre_files == 0;
}

void PreMgr::WaitLoadPre(const char *pFilename)
{
	while (!IsLoadPreFinished(pFilename))
	{
		// We got to call this to allow callbacks to come through
		CAsyncFileLoader::sWaitForIOEvent(false);
	}
}

void PreMgr::WaitAllLoadPre()
{
	while (!AllLoadPreFinished())
	{
		// We got to call this to allow callbacks to come through
		CAsyncFileLoader::sWaitForIOEvent(false);
	}
}

bool PreMgr::sPreEnabled()
{
	return sp_mgr != nullptr;
}

bool PreMgr::sPreExecuteSuccess()
{
	return s_lastExecuteSuccess; 
}

bool PreMgr::pre_fexist(const char *name)
{
	
	Dbg_MsgAssert(name,( "requesting file nullptr"));	
	
	if (sp_mgr->fileExists(name)) 
	{
#		if DEBUG_PRE
		printf("PRE: file %s exists\n", name);
#		endif
		s_lastExecuteSuccess = true;
		return true;
	}
//	if ( Pcm::UsingCD( ) )
//	{
//		Dbg_MsgAssert( 0,( "File access forbidden while PCM audio is in progress." ));
//		return false;
//	}

	return s_lastExecuteSuccess = false;
}



PreFile::FileHandle *PreMgr::pre_fopen(const char *name, const char *access, bool async)
{
	Dbg_MsgAssert(name,( "trying to open file nullptr"));	

	PreFile::FileHandle *pHandle = sp_mgr->getContainedFile(name);
	if (pHandle)
	{
		sp_mgr->mp_activePre->Open(async);

		// if we are going to write the file, we want to use the regular file system
		const char *pChar = access;
		bool am_writing = false;
		while(*pChar)
		{
			if (*pChar != 'r' && *pChar != 'b')
				am_writing = true;
			pChar++;
		}
		
		if (am_writing)
		{
#			ifdef __PLAT_NGPS__
//			scePrintf("    writing file %s\n", name);
#			endif

			// am writing, so we don't need file open in PRE system
			sp_mgr->mp_activePre->Close(async);
		}
		else
		{
			// we're reading the file from the PRE system
#			if DEBUG_PRE
			printf("PRE: opened file %s, handle is 0x%x\n", name, (int) pHandle);
#			endif
			sp_mgr->mp_activePre->Reset();
			s_lastExecuteSuccess = true;
			return pHandle;
		}
	}

//	// if we get here, we are using the regular file system
//	if ( Pcm::UsingCD( ) )
//	{
//		Dbg_MsgAssert( 0,( "File access forbidden while PCM audio is in progress." ));
//		return nullptr;
//	}

	s_lastExecuteSuccess = false;
	return nullptr;

	//return pHandle;
}



int PreMgr::pre_fclose(PreFile::FileHandle *fptr, bool async)
{
	Dbg_MsgAssert(fptr,( "calling fclose with invalid file ptr"));	
	
	char *pData = sp_mgr->getContainedFileByHandle(fptr);
	if (pData)
	{
#if DEBUG_PRE
		printf("PRE: closed file, handle 0x%x\n", (int) fptr);
#endif
		sp_mgr->mp_activePre->Close(async);
		s_lastExecuteSuccess = true;
		return 0;
	}
	
	s_lastExecuteSuccess = false;
	return 0;
}



size_t PreMgr::pre_fread(void *addr, size_t size, size_t count, PreFile::FileHandle *fptr)
{
	Dbg_MsgAssert(fptr,( "calling fread with invalid file ptr"));		

	char *pData = sp_mgr->getContainedFileByHandle(fptr);
	if (pData)
	{
		// read from a simulated file stream in PRE file
		Dbg_AssertPtr(sp_mgr->mp_activePre);
		s_lastExecuteSuccess = true;
		return sp_mgr->mp_activePre->Read(addr, size * count);
	}
//	if ( Pcm::UsingCD( ) )
//	{
//		Dbg_MsgAssert( 0,( "File access forbidden while PCM audio is in progress." ));
//		return 0;
//	}
	
	s_lastExecuteSuccess = false;
	return 0;
}



size_t  PreMgr::pre_fwrite(const void *addr, size_t size, size_t count, PreFile::FileHandle *fptr)
{
	(void)addr;
	(void)size;
	(void)count;

	char *pData = sp_mgr->getContainedFileByHandle(fptr);
	Dbg_MsgAssert(!pData,( "can't write to a PRE file"));
	
//	if ( Pcm::UsingCD( ) )
//	{
//		Dbg_MsgAssert( 0,( "File access forbidden while PCM audio is in progress." ));
//		return 0;
//	}

	s_lastExecuteSuccess = false;
	return 0;
}



char *PreMgr::pre_fgets(char *buffer, int maxLen, PreFile::FileHandle *fptr)
{
	(void)buffer;
	(void)maxLen;

	char *pData = sp_mgr->getContainedFileByHandle(fptr);
	Dbg_MsgAssert(!pData,( "can't do string ops on a PRE file"));
	
	s_lastExecuteSuccess = false;
	return nullptr;
}



int PreMgr::pre_fputs(const char *buffer, PreFile::FileHandle *fptr)
{
	(void)buffer;

	char *pData = sp_mgr->getContainedFileByHandle(fptr);
	Dbg_MsgAssert(!pData,( "can't do string ops on a PRE file"));
	
	s_lastExecuteSuccess = false;
	return 0;
}



int PreMgr::pre_feof(PreFile::FileHandle *fptr)
{
	Dbg_MsgAssert(fptr,( "calling feof with invalid file ptr"));		

	char *pData = sp_mgr->getContainedFileByHandle(fptr);
	if (pData)
	{
		Dbg_AssertPtr(sp_mgr->mp_activePre);
		s_lastExecuteSuccess = true;
		return sp_mgr->mp_activePre->Eof();
	}
	
	s_lastExecuteSuccess = false;
	return 0;
}



int PreMgr::pre_fseek(PreFile::FileHandle *fptr, ptrdiff_t offset, int origin)
{
	char *pData = sp_mgr->getContainedFileByHandle(fptr);
	if (pData)
	{
		s_lastExecuteSuccess = true;
		return sp_mgr->mp_activePre->Seek(offset, origin);
	}

	Dbg_MsgAssert(!pData,( "seek not supported for PRE file"));
	s_lastExecuteSuccess = false;
	return 0;
}



int PreMgr::pre_fflush(PreFile::FileHandle *fptr)
{
	char *pData = sp_mgr->getContainedFileByHandle(fptr);
	Dbg_MsgAssert(!pData,( "flush not supported for PRE file"));
	
	s_lastExecuteSuccess = false;
	return 0;
}



int PreMgr::pre_ftell(PreFile::FileHandle *fptr)
{
	char *pData = sp_mgr->getContainedFileByHandle(fptr);
	Dbg_MsgAssert(!pData,( "tell supported for PRE file"));
	
	s_lastExecuteSuccess = false;
	return 0;
}


size_t	PreMgr::pre_get_file_size(PreFile::FileHandle *fptr)
{
	char *pData = sp_mgr->getContainedFileByHandle(fptr);
	if (pData)
	{
		s_lastExecuteSuccess = true;
		return sp_mgr->mp_activePre->GetFileSize();
	}

	Dbg_MsgAssert(!pData,( "get_file_size not supported for PRE file"));
	s_lastExecuteSuccess = false;
	return 0;
}

size_t PreMgr::pre_get_file_position(PreFile::FileHandle *fptr)
{
	char *pData = sp_mgr->getContainedFileByHandle(fptr);
	if (pData)
	{
		s_lastExecuteSuccess = true;
		return sp_mgr->mp_activePre->GetFilePosition();
	}

	Dbg_MsgAssert(!pData,( "get_file_position not supported for PRE file"));
	s_lastExecuteSuccess = false;
	return 0;
}


// @script | InPreFile | 
// @uparm "string" | filename
bool ScriptInPreFile(Script::CStruct *pParams, Script::CScript *pScript)
{
	(void)pScript;

	const char *pFilename;
	pParams->GetText(NONAME, &pFilename, true);

	PreMgr* pre_mgr = PreMgr::Instance();
	return pre_mgr->InPre(pFilename);
}



// @script | LoadPreFile | 
// @uparm "string" | filename
// @flag async | Load Asynchronously
// @flag dont_assert | 
// @flag use_bottom_up_heap | 
bool ScriptLoadPreFile(Script::CStruct *pParams, Script::CScript *pScript)
{
	(void)pScript;

	const char *pFilename;
	pParams->GetText(NONAME, &pFilename, true);

	PreMgr* pre_mgr = PreMgr::Instance();
	pre_mgr->LoadPre(pFilename, 
					 pParams->ContainsFlag(Crc::ConstCRC("async")),
					pParams->ContainsFlag(Crc::ConstCRC("dont_assert")),
					pParams->ContainsFlag(Crc::ConstCRC("use_bottom_up_heap")));
	return true;
}



// @script | UnloadPreFile | 
// @flag BoardsPre | 
// @flag dont_assert | 
// @uparm "string" | filename
bool ScriptUnloadPreFile(Script::CStruct *pParams, Script::CScript *pScript)
{
	(void)pScript;

	PreMgr* pre_mgr = PreMgr::Instance();
	
	if (pParams->ContainsFlag("BoardsPre"))
	{
		
//		Mdl::Skate * pSkate = Mdl::Skate::Instance();
//		pSkate->UnloadBoardPreIfPresent(pParams->ContainsFlag("dont_assert"));
		printf ("STUBBED:  Unload BoardsPre, in ScriptUnloadPreFile\n");
		return true;
	}
	
	const char *pFilename;
	pParams->GetText(NONAME, &pFilename, true);

	pre_mgr->UnloadPre(pFilename, pParams->ContainsFlag("dont_assert"));
	return true;
}

// @script | IsLoadPreFinished | Returns true if Pre file has finished loading
// @uparm "string" | filename
bool ScriptIsLoadPreFinished(Script::CStruct *pParams, Script::CScript *pScript)
{
	(void)pScript;

	PreMgr* pre_mgr = PreMgr::Instance();

	const char *pFilename;
	pParams->GetText(NONAME, &pFilename, true);

	return pre_mgr->IsLoadPreFinished(pFilename);
}

// @script | AllLoadPreFinished | Returns true if all LoadPre commands have completed
bool ScriptAllLoadPreFinished(Script::CStruct *pParams, Script::CScript *pScript)
{
	(void)pParams;
	(void)pScript;

	PreMgr* pre_mgr = PreMgr::Instance();

	return pre_mgr->AllLoadPreFinished();
}

// @script | WaitLoadPre | Waits for Pre file to finished loading
// @uparm "string" | filename
bool ScriptWaitLoadPre(Script::CStruct *pParams, Script::CScript *pScript)
{
	(void)pScript;

	PreMgr* pre_mgr = PreMgr::Instance();

	const char *pFilename;
	pParams->GetText(NONAME, &pFilename, true);

	pre_mgr->WaitLoadPre(pFilename);
	return true;
}

// @script | WaitAllLoadPre | Waits for all Pre files to finished loading
bool ScriptWaitAllLoadPre(Script::CStruct *pParams, Script::CScript *pScript)
{
	(void)pParams;
	(void)pScript;

	PreMgr* pre_mgr = PreMgr::Instance();

	pre_mgr->WaitAllLoadPre();
	return true;
}

// if a file is in a pre, then:
// allocate memory for the file
// if file is uncompressed
//   copy it down
// else
//   decompress

char *PreMgr::LoadFile(const char *pName, size_t *p_size, char *p_dest)
{
// NOTE: THIS IS JUST CUT AND PASTE FROM Pre::fileExists
	Dbg_AssertPtr(pName);
	// replace all '/' with '\'
	char cleaned_name[128];
	const char *pCharIn = pName;
	char *pCharOut = cleaned_name;
	while (1)
	{
		*pCharOut = *pCharIn;
		if (*pCharIn == '\0') break;
		if (*pCharOut == '/') *pCharOut = '\\';
		pCharIn++;
		pCharOut++;		
	}

	mp_table->IterateStart();
	PreFile *pPre = mp_table->IterateNext();
	while(pPre)
	{
		
		char *p_data = pPre->LoadContainedFile(cleaned_name, p_size, p_dest);
		if (p_data)
		{
			return p_data;
		}
		pPre = mp_table->IterateNext();
	}
	return nullptr;

}



} // namespace File




