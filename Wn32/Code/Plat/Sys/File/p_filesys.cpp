#include <Windows.h>
#include <stdio.h>
#include <string.h>

#include <Core/Defines.h>
#include <Core/support.h>

#include "p_filesys.h"
#include <Sys/File/AsyncFilesys.h>
#include <Sys/File/PRE.h>
#include <Sys/Config/config.h>

// #include <Gfx/xbox/nx/nx_init.h>

namespace File
{

#define READBUFFERSIZE				10240
#define	PREPEND_START_POS			8

	// Return module path
	static std::filesystem::path GetModulePath()
	{
		// Get module namethe
		std::basic_string<WCHAR> module_name(MAX_PATH, '\0');

		while (1)
		{
			DWORD decceded = GetModuleFileNameW(nullptr, module_name.data(), module_name.size());
			if (decceded < module_name.size())
			{
				module_name.resize(decceded);
				break;
			}
			else
			{
				module_name.resize(module_name.size() * 2);
			}
		}

		// Remove filename
		std::filesystem::path module_path(module_name);
		module_path.remove_filename();
		return module_path;
	}

	std::filesystem::path ModulePath()
	{
		static std::filesystem::path module_path = GetModulePath();
		return module_path;
	}

	// Return data path
	static std::filesystem::path GetDataPath()
	{
		// Get module path
		return ModulePath() / "Data";
	}

	std::filesystem::path DataPath()
	{
		static std::filesystem::path data_path = GetDataPath();
		return data_path;
	}

	static void* prefopen( const char *filename, const char *mode )
	{
		// Process file name
		std::filesystem::path file_path(filename);

		// If name ends with .xbx, remove
		if (file_path.extension() == ".xbx" || file_path.extension() == ".Xbx")
			file_path.replace_extension();

		// If name ends with .ps2, remove
		if (file_path.extension() == ".ps2")
			file_path.replace_extension();

		// Open the file
		std::filesystem::path full_path = DataPath() / file_path;
		HANDLE h_file = CreateFileW(full_path.native().c_str(), GENERIC_READ, FILE_SHARE_READ, nullptr, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, nullptr);

		// Deal with various error returns.
		if (h_file == INVALID_HANDLE_VALUE)
		{
			DWORD error = GetLastError();

			// Need to exclude this error from the test, since screenshot and other code sometimes check to see if a file exists, and it
			// is valid to just return the error code if it doesn't.
			if (error != ERROR_FILE_NOT_FOUND)
			{
				std::cerr << "Error opening file " << full_path << std::endl;
				Dbg_Assert(0);
			}
			return nullptr;
		}
		else
		{
			// All is well.
			return h_file;
		}
	}

	void InstallFileSystem( void )
	{
	#	if 0
		// This is where we start the thread that will deal with copying commonly used data from the DVD to the utility
		// region (z:\) on the HD.
		pLoader = new CThreadedLevelLoader();

		SLevelDesc level_descs[] = {{ "pre\\alc.prx" },
									{ "pre\\alccol.prx" },
									{ "pre\\alcscn.prx" },
									{ "pre\\anims.prx" },
									{ "pre\\bits.prx" },
									{ "pre\\cnv.prx" },
									{ "pre\\cnvcol.prx" },
									{ "pre\\cnvscn.prx" },
									{ "pre\\fonts.prx" },
									{ "pre\\jnk.prx" },
									{ "pre\\jnkcol.prx" },
									{ "pre\\jnkscn.prx" },
									{ "pre\\kon.prx" },
									{ "pre\\koncol.prx" },
									{ "pre\\konscn.prx" },
									{ "pre\\lon.prx" },
									{ "pre\\loncol.prx" },
									{ "pre\\lonscn.prx" },
									{ "pre\\qb.prx" },
									{ "pre\\sch.prx" },
									{ "pre\\schcol.prx" },
									{ "pre\\schscn.prx" },
									{ "pre\\sf2.prx" },
									{ "pre\\sf2col.prx" },
									{ "pre\\sf2scn.prx" },
									{ "pre\\skaterparts.prx" },
									{ "pre\\skater_sounds.prx" },
									{ "pre\\skateshop.prx" },
									{ "pre\\skateshopcol.prx" },
									{ "pre\\skateshopscn.prx" },
									{ "pre\\skeletons.prx" },
									{ "pre\\zoo.prx" },
									{ "pre\\zoocol.prx" },
									{ "pre\\zooscn.prx" }};

		static BYTE data_buffer[32 * 1024];
		pLoader->Initialize( level_descs, 34, data_buffer, 32 * 1024, &OkayToUseUtilityDrive );
		pLoader->AsyncStreamLevel( 0 );
	#	endif

		// Initialise the async file system.
		File::CAsyncFileLoader::sInit();
	}

	long GetFileSize( void* pFP )
	{
		Dbg_MsgAssert( pFP, ( "nullptr pFP sent to GetFileSize" ));

		if( PreMgr::sPreEnabled())
		{
			int retval = PreMgr::pre_get_file_size( (PreFile::FileHandle *) pFP );
			if( PreMgr::sPreExecuteSuccess())
				return retval;
		}
	
		LARGE_INTEGER	li;
		GetFileSizeEx((HANDLE)pFP, &li );
		return (long)li.LowPart;
	}

	long GetFilePosition( void *pFP )
	{
		Dbg_MsgAssert( pFP, ( "nullptr pFP sent to GetFilePosition" ));

		if( PreMgr::sPreEnabled())
		{
			int retval = PreMgr::pre_get_file_position((PreFile::FileHandle*)pFP );
			if( PreMgr::sPreExecuteSuccess())
				return retval;
		}

		long pos = SetFilePointer(	(HANDLE)pFP,	// Handle to file
									0,				// Bytes to move pointer
									0,				// High bytes to move pointer
									FILE_CURRENT );	// Starting point
		return pos;
	}

	void InitQuickFileSystem( void )
	{
	}

	uint32	CanFileBeLoadedQuickly( const char* filename )
	{
		(void)filename;
		return 0;
	}

	bool LoadFileQuicklyPlease( const char* filename, uint8 *addr )
	{
		(void)filename;
		(void)addr;
		return false;
	}

	void StopStreaming( void )
	{
	}

	void UninstallFileSystem( void )
	{
	}

	bool Exist( const char *filename )
	{
		if (PreMgr::sPreEnabled())
		{
			bool retval = PreMgr::pre_fexist(filename);
			if (PreMgr::sPreExecuteSuccess())
				return retval;
		}

		void *p_result = prefopen( filename, "rb" );
		if( p_result != nullptr )
		{
			Close( p_result );
		}

		return( p_result != nullptr );
	}

	void *Open( const char *filename, const char *access )
	{
		if (PreMgr::sPreEnabled())
		{
			void * retval = PreMgr::pre_fopen(filename, access);
			if (PreMgr::sPreExecuteSuccess())
				return retval;
		}

		return prefopen( filename, access );
	}

	int Close( void *pFP )
	{
		if (PreMgr::sPreEnabled())
		{
			int retval = PreMgr::pre_fclose((PreFile::FileHandle *) pFP);
			if (PreMgr::sPreExecuteSuccess())
				return retval;
		}

		CloseHandle((HANDLE)pFP );

		return 0;
	}

	size_t Read( void *addr, size_t size, size_t count, void *pFP )
	{
		if (PreMgr::sPreEnabled())
		{
			size_t retval = PreMgr::pre_fread( addr, size, count, (PreFile::FileHandle*)pFP );
			if( PreMgr::sPreExecuteSuccess())
				return retval;
		}

		DWORD bytes_read;
		if( ReadFile((HANDLE)pFP, addr, size * count, &bytes_read, nullptr ))
		{
			// All is well.
			return bytes_read;
		}
		else
		{
			// Read error.
			DWORD last_error = GetLastError();

			if( last_error == ERROR_HANDLE_EOF )
			{
				// Continue in this case.
				return bytes_read;
			}

			// NxWn32::FatalFileError( last_error );
			return bytes_read;
		}
	}
	
	size_t ReadInt( void *addr, void *pFP )
	{
		return Read( addr, 4, 1, pFP );
	}

	size_t Write( const void *addr, size_t size, size_t count, void *pFP )
	{
		if (PreMgr::sPreEnabled())
		{
			size_t retval = PreMgr::pre_fwrite(addr, size, count, (PreFile::FileHandle *) pFP);
			if (PreMgr::sPreExecuteSuccess())
				return retval;
		}
		return 0;
	}

	char * GetS( char *buffer, int maxlen, void *pFP )
	{
		if (PreMgr::sPreEnabled())
		{
			char * retval = PreMgr::pre_fgets(buffer, maxlen, (PreFile::FileHandle *) pFP);
			if (PreMgr::sPreExecuteSuccess())
				return retval;
		}
		return nullptr;
	}

	int PutS( const char *buffer, void *pFP )
	{
		if (PreMgr::sPreEnabled())
		{
			int retval = PreMgr::pre_fputs(buffer, (PreFile::FileHandle *) pFP);
			if (PreMgr::sPreExecuteSuccess())
				return retval;
		}
		return 0;
	}

	int Eof( void *pFP )
	{
		if (PreMgr::sPreEnabled())
		{
			int retval = PreMgr::pre_feof((PreFile::FileHandle *) pFP);
			if (PreMgr::sPreExecuteSuccess())
				return retval;
		}
		return 0;
	}

	int Seek( void *pFP, long offset, int origin )
	{
		if( PreMgr::sPreEnabled())
		{
			int retval = PreMgr::pre_fseek((PreFile::FileHandle *) pFP, offset, origin);
			if( PreMgr::sPreExecuteSuccess())
				return retval;
		}
		return SetFilePointer((HANDLE)pFP, offset, nullptr, ( origin == SEEK_CUR ) ? FILE_CURRENT : (( origin == SEEK_SET ) ? FILE_BEGIN : FILE_END ));
	}

	int Flush( void *pFP )
	{
		if (PreMgr::sPreEnabled())
		{
			int retval = PreMgr::pre_fflush((PreFile::FileHandle *) pFP);
			if (PreMgr::sPreExecuteSuccess())
				return retval;
		}
		return 0;
	}

} // namespace File


