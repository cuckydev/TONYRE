#include <stdio.h>
#include <string.h>

#include <Core/Defines.h>
#include <Core/support.h>

#include "p_filesys.h"
#include <Sys/File/AsyncFilesys.h>
#include <Sys/File/PRE.h>
#include <Sys/Config/config.h>

// #include <Gfx/xbox/nx/nx_init.h>

#ifdef __PLAT_WN32__
#include <Windows.h>
#endif
#ifdef __PLAT_LINUX__
#include <unistd.h>
#endif

#include <fstream>
#include <unordered_map>

// NOTE: The filesystem indexing has a significant impact on startup time
// We should consider making something to just make all the paths on the host lowercase
// This will work for now, though

namespace File
{
	// Convert a game path to a standard path
	// The game paths are case-insensitive, but the file system may be case-sensitive
	// The game also often uses backslashes instead of forward slashes, so we'll standardize those too
	static std::string StandardPath(const std::string &path)
	{
		std::string result = path;
		for (char &c : result)
		{
			if (c >= 'A' && c <= 'Z')
				c = 'a' + (c - 'A');
			if (c == '/')
				c = '\\';
		}
		return result;
	}

	// Index the file system
	typedef std::unordered_map<std::string, std::filesystem::path> Index;

	static void IndexDirectory(Index &index, const std::filesystem::path &root, const std::filesystem::path &path)
	{
		for (auto &entry : std::filesystem::directory_iterator(path))
		{
			if (entry.is_regular_file())
			{
				std::filesystem::path rel = std::filesystem::relative(entry.path(), root);
				index[StandardPath(rel.string())] = entry.path();
			}
			else if (entry.is_directory())
			{
				IndexDirectory(index, root, entry.path());
			}
		}
	}

	static Index IndexFilesystem()
	{
		// Index data path
		Index index;

		std::filesystem::path data_path = DataPath();
		for (auto &entry : std::filesystem::directory_iterator(data_path))
		{
			if (entry.is_regular_file())
			{
				std::filesystem::path rel = std::filesystem::relative(entry.path(), data_path);
				index[StandardPath(rel.string())] = entry.path();
			}
			else if (entry.is_directory())
			{
				std::string dir_name = StandardPath(entry.path().filename().string());
				if (dir_name == "music" || dir_name == "streams") // Don't index music or streams, those are indexed elsewhere
					continue;
				IndexDirectory(index, data_path, entry.path());
			}
		}

		return index;
	}

	// Return module path
	static std::filesystem::path GetModulePath()
	{
#if defined(__PLAT_WN32__)
		// Get module name
		std::basic_string<WCHAR> module_name(MAX_PATH, '\0');

		while (1)
		{
			DWORD decceded = GetModuleFileNameW(nullptr, module_name.data(), (DWORD)module_name.size());
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
#elif defined(__PLAT_LINUX__)
		return std::filesystem::canonical("/proc/self/exe").remove_filename();
#endif
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

	// File handle
	struct sFileHandle
	{
		std::ifstream file;
		size_t filesize = 0;

		sFileHandle(const std::filesystem::path &path) : file(path, std::ios::binary)
		{
			if (file.is_open())
				filesize = (size_t)std::filesystem::file_size(path);
		}
	};

	static void *prefopen(const char *filename, const char *mode)
	{
		(void)mode;

		// Standardize file name
		std::string name = StandardPath(filename);

		// Get file extension
		std::string extension;
		
		size_t dot_pos = name.find_last_of('.');
		if (dot_pos != std::string::npos)
			extension = name.substr(dot_pos);

		// Remove extension if .xbx or .ps2
		if (extension == ".xbx" || extension == ".ps2")
			name = name.substr(0, dot_pos);

		// Find the path in the index
		static const Index index = IndexFilesystem();

		auto it = index.find(name);
		if (it == index.end())
			return nullptr;

		// Open the file
		sFileHandle *h_file = new sFileHandle(it->second);

		if (!h_file->file.is_open())
		{
			delete h_file;
			return nullptr;
		}

		return h_file;
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

	size_t GetFileSize( void* pFP )
	{
		Dbg_MsgAssert( pFP, ( "nullptr pFP sent to GetFileSize" ));

		if( PreMgr::sPreEnabled())
		{
			size_t retval = PreMgr::pre_get_file_size( (PreFile::FileHandle *) pFP );
			if( PreMgr::sPreExecuteSuccess())
				return retval;
		}
	
		sFileHandle *h_file = (sFileHandle*)pFP;
		return h_file->filesize;
	}

	size_t GetFilePosition( void *pFP )
	{
		Dbg_MsgAssert( pFP, ( "nullptr pFP sent to GetFilePosition" ));

		if( PreMgr::sPreEnabled())
		{
			size_t retval = PreMgr::pre_get_file_position((PreFile::FileHandle*)pFP );
			if( PreMgr::sPreExecuteSuccess())
				return retval;
		}

		sFileHandle *h_file = (sFileHandle *)pFP;
		return (size_t)h_file->file.tellg();
	}

	void InitQuickFileSystem( void )
	{
	}

	size_t	CanFileBeLoadedQuickly( const char* filename )
	{
		(void)filename;
		return 0;
	}

	bool LoadFileQuicklyPlease( const char* filename, char *addr )
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

		sFileHandle *h_file = (sFileHandle *)pFP;
		delete h_file;
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

		sFileHandle *h_file = (sFileHandle*)pFP;
		h_file->file.read((char*)addr, size * count);
		return (size_t)h_file->file.gcount();
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

	int Seek( void *pFP, ptrdiff_t offset, int origin )
	{
		if( PreMgr::sPreEnabled())
		{
			int retval = PreMgr::pre_fseek((PreFile::FileHandle *) pFP, offset, origin);
			if( PreMgr::sPreExecuteSuccess())
				return retval;
		}

		sFileHandle *h_file = (sFileHandle*)pFP;
		h_file->file.seekg(offset, (origin == SEEK_CUR) ? std::ios::cur : ((origin == SEEK_SET) ? std::ios::beg : std::ios::end));
		return (int)h_file->file.tellg();
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


