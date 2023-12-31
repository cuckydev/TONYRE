/*****************************************************************************
**																			**
**			              Neversoft Entertainment.			                **
**																		   	**
**				   Copyright (C) 2001 - All Rights Reserved				   	**
**																			**
******************************************************************************
**																			**
**	Project:																**
**																			**
**	Module:									 								**
**																			**
**	File name:																**
**																			**
**	Created by:		rjm, 1/23/2001											**
**																			**
**	Description:						 									**
**																			**
*****************************************************************************/

#pragma once

/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/

#include <Core/Defines.h>
#include <Sys/File/AsyncTypes.h>

namespace Lst
{
	template<class _V> class StringHashTable;
}

namespace Script
{
	class CStruct;
	class CScript;
}	

/*****************************************************************************
**								   Defines									**
*****************************************************************************/


namespace File
{

						


/*****************************************************************************
**							Class Definitions								**
*****************************************************************************/

/*****************************************************************************
**							 Private Declarations							**
*****************************************************************************/

/*****************************************************************************
**							  Private Prototypes							**
*****************************************************************************/

/*****************************************************************************
**							  Public Declarations							**
*****************************************************************************/

bool ScriptInPreFile(Script::CStruct *pParams, Script::CScript *pScript);
bool ScriptLoadPreFile(Script::CStruct *pParams, Script::CScript *pScript);
bool ScriptUnloadPreFile(Script::CStruct *pParams, Script::CScript *pScript);

bool ScriptIsLoadPreFinished(Script::CStruct *pParams, Script::CScript *pScript);
bool ScriptAllLoadPreFinished(Script::CStruct *pParams, Script::CScript *pScript);
bool ScriptWaitLoadPre(Script::CStruct *pParams, Script::CScript *pScript);
bool ScriptWaitAllLoadPre(Script::CStruct *pParams, Script::CScript *pScript);

/*****************************************************************************
**							   Public Prototypes							**
*****************************************************************************/


/*****************************************************************************
**								Inline Functions							**
*****************************************************************************/

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

class CAsyncFileHandle;
class PreMgr;
class  PreFile  : public Spt::Class
{
	

public:

	// The actual PRE file (it is public so that FileHandle can be made public).
	struct _File
	{
		size_t compressedDataSize;
		char * pCompressedData;
		char * pData;
		size_t m_position;
		size_t m_filesize;
	};

	// Just typedef a file handle type since the file itself contains all the info
	typedef _File FileHandle;

	PreFile(char *p_file_buffer, bool useBottomUpHeap=false);
	~PreFile();
	
	
	
	bool FileExists(const char *pName);
	char *LoadContainedFile(const char *pName, size_t *p_size, char *p_dest = nullptr);
	FileHandle *GetContainedFile(const char *pName);
	char *GetContainedFileByHandle(FileHandle *pHandle);

	void Reset();
	size_t Read(void *addr, size_t count);
	int Eof();
	void Open(bool async);
	void Close(bool async);
	int Seek(ptrdiff_t offset, int origin);
	size_t TellActive( void )				{ if( mp_activeFile ){ return mp_activeFile->m_position; }else{ return 0; }}
	size_t GetFileSize( void )			{ if( mp_activeFile ){ return mp_activeFile->m_filesize; }else{ return 0; }}
	size_t GetFilePosition( void )		{ if( mp_activeFile ){ return mp_activeFile->m_position; }else{ return 0; }}

private:

	static void s_delete_file(_File *pFile, void *pData);
	
	char *mp_buffer = nullptr;
	int m_numEntries = 0;
	
	// maps filenames to pointers
	Lst::StringHashTable<_File> *mp_table = nullptr;

	_File *mp_activeFile = nullptr;

	int m_numOpenAsyncFiles = 0;
	
	bool m_use_bottom_up_heap = false;
};




class  PreMgr  : public Spt::Class
{
	
	DeclareSingletonClass(PreMgr);

public:
	bool InPre(const char *pFilename);
	void LoadPre(const char *pFilename, bool async, bool dont_assert = false, bool useBottomUpHeap=false);
	void LoadPrePermanently(const char *pFilename, bool async, bool dont_assert = false);
	void UnloadPre(const char *pFilename, bool dont_assert = false);
	char *LoadFile(const char *pName, size_t *p_size, char *p_dest = nullptr);

	// Async check functions
	bool IsLoadPreFinished(const char *pFilename);
	bool AllLoadPreFinished();
	void WaitLoadPre(const char *pFilename);
	void WaitAllLoadPre();

	static bool sPreEnabled();
	static bool sPreExecuteSuccess();
	
	static bool					pre_fexist(const char *name);
	static PreFile::FileHandle *pre_fopen(const char *name, const char *access, bool async = false);
	static int					pre_fclose(PreFile::FileHandle *fptr, bool async = false);
	static size_t				pre_fread(void *addr, size_t size, size_t count, PreFile::FileHandle *fptr);
	static size_t				pre_fwrite(const void *addr, size_t size, size_t count, PreFile::FileHandle *fptr);
	static char *				pre_fgets(char *buffer, int maxLen, PreFile::FileHandle *fptr);
	static int					pre_fputs(const char *buffer, PreFile::FileHandle *fptr);
	static int					pre_feof(PreFile::FileHandle *fptr);
	static int					pre_fseek(PreFile::FileHandle *fptr, ptrdiff_t offset, int origin);
	static int					pre_fflush(PreFile::FileHandle *fptr);
	static int					pre_ftell(PreFile::FileHandle *fptr);
	static size_t				pre_get_file_size(PreFile::FileHandle *fptr);
	static size_t				pre_get_file_position(PreFile::FileHandle *fptr);

private:
	// Constants
	enum
	{
		MAX_COMPACT_FILE_NAME = 64,				// Only store the right-most characters of the filename to save space
		MAX_NUM_ASYNC_LOADS = 8,
	};

	// Holds data for pending async loads
	struct SPendingAsync
	{
		CAsyncFileHandle *mp_file_handle = nullptr;
		char m_file_name[MAX_COMPACT_FILE_NAME] = {};
	};

	PreMgr();
	~PreMgr();

	void loadPre(const char *pFilename, bool async, bool dont_assert = false, bool useBottomUpHeap=false);
	void postLoadPre(CAsyncFileHandle *p_file_handle, char *pData, int size);
	bool fileExists(const char *pName);
	PreFile::FileHandle *getContainedFile(const char *pName);
	char *getContainedFileByHandle(PreFile::FileHandle *pHandle);

	static char *getCompactFileName(char *pName); // Returns point in string where it will fit in compact space

	static void async_callback(CAsyncFileHandle *p_file_handle, EAsyncFunctionType function, int result, unsigned int arg0, unsigned int arg1);

	PreFile *mp_activePre = nullptr;
	PreFile::FileHandle *mp_activeHandle = nullptr;
	char *mp_activeData = nullptr;
	// handle of current file being accessed from regular file system, for quick check
	void *mp_activeNonPreHandle = nullptr;

	static bool s_lastExecuteSuccess;
	static PreMgr *sp_mgr;
	
	Lst::StringHashTable<PreFile> *mp_table = nullptr;

	bool m_blockPreLoading = false;

	// Async status
	SPendingAsync m_pending_pre_files[MAX_NUM_ASYNC_LOADS] = {};
	int m_num_pending_pre_files = 0;
};


} // namespace File
