///////////////////////////////////////////////////////////////////////////////////////
//
// AsyncFilesys.cpp		GRJ 8 Oct 2002
//
// Asynchronous file system
//
///////////////////////////////////////////////////////////////////////////////////////

#include <Sys/File/AsyncFilesys.h>
#include <Gel/mainloop.h>

namespace File
{

///////////////////////////////////////////////////////////////////////////////////////
// Constants
//

const uint32	CAsyncFileHandle::MAX_FILE_SIZE = (uint32) ((uint64) (1ULL << 31) - 1);	// 1 Gig (Because we are using signed, we lose a bit)


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CAsyncFileHandle::CAsyncFileHandle()
{
	init();
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void				CAsyncFileHandle::init()
{
	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CAsyncFileHandle::~CAsyncFileHandle()
{
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool		CAsyncFileHandle::IsBusy( void )
{
	return false;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

int					CAsyncFileHandle::WaitForIO( void )
{
	return 0;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void				CAsyncFileHandle::SetPriority( int priority )
{
	(void)priority;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void				CAsyncFileHandle::SetStream( bool stream )
{
	(void)stream;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void				CAsyncFileHandle::SetDestination( EAsyncMemoryType destination )
{
	(void)destination;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void				CAsyncFileHandle::SetBufferSize( size_t buffer_size )
{
	(void)buffer_size;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void				CAsyncFileHandle::SetBlocking( bool block )
{
	(void)block;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void				CAsyncFileHandle::SetCallback( AsyncCallback p_callback, unsigned int arg0, unsigned int arg1)
{
	(void)p_callback;
	(void)arg0;
	(void)arg1;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
size_t				CAsyncFileHandle::GetFileSize( void )
{
	return 0;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

size_t				CAsyncFileHandle::Load(void *p_buffer)
{
	(void)p_buffer;
	return 0;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

size_t				CAsyncFileHandle::Read(void *p_buffer, size_t size, size_t count)
{
	(void)p_buffer;
	(void)size;
	(void)count;
	return 0;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

size_t				CAsyncFileHandle::Write(void *p_buffer, size_t size, size_t count)
{
	(void)p_buffer;
	(void)size;
	(void)count;
	return 0;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

int					CAsyncFileHandle::Seek(long offset, int origin)
{
	(void)offset;
	(void)origin;
	return 0;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void				CAsyncFileHandle::io_callback(EAsyncFunctionType function, int result, uint32 data)
{
	(void)function;
	(void)result;
	(void)data;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void				CAsyncFileHandle::post_io_callback()
{
	
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool				CAsyncFileHandle::open(const char *filename, bool blocking, int priority)
{
	(void)filename;
	(void)blocking;
	(void)priority;
	return false;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool				CAsyncFileHandle::close()
{
	return false;
}

/******************************************************************/
/*                                                                */
/* plat stubs													  */
/*                                                                */
/******************************************************************/

void				CAsyncFileHandle::plat_init()
{
	printf ("STUB: CAsyncFileHandle::Init\n");
}

bool				CAsyncFileHandle::plat_open(const char *filename)
{
	(void)filename;

	printf ("STUB: CAsyncFileHandle::Open\n");

	return false;
}

bool				CAsyncFileHandle::plat_close()
{
	printf ("STUB: CAsyncFileHandle::Close\n");

	return false;
}

bool		CAsyncFileHandle::plat_is_done()
{
	printf ("STUB: CAsyncFileHandle::IsDone\n");

	return false;
}

bool		CAsyncFileHandle::plat_is_busy()
{
	printf ("STUB: CAsyncFileHandle::IsBusy\n");

	return false;
}

bool				CAsyncFileHandle::plat_is_eof() const
{
	printf ("STUB: CAsyncFileHandle::IsEOF\n");

	return false;
}

void				CAsyncFileHandle::plat_set_priority( int priority )
{
	(void)priority;

	printf ("STUB: CAsyncFileHandle::SetPriority\n");
}

void				CAsyncFileHandle::plat_set_stream( bool stream )
{
	(void)stream;

	printf ("STUB: CAsyncFileHandle::SetStream\n");
}

void				CAsyncFileHandle::plat_set_destination( EAsyncMemoryType destination )
{
	(void)destination;

	printf ("STUB: CAsyncFileHandle::SetDestination\n");
}

void				CAsyncFileHandle::plat_set_buffer_size( size_t buffer_size )
{
	(void)buffer_size;

	printf ("STUB: CAsyncFileHandle::SetBufferSize\n");
}

void				CAsyncFileHandle::plat_set_blocking( bool block )
{
	(void)block;

	printf ("STUB: CAsyncFileHandle::SetBlocking\n");
}

size_t				CAsyncFileHandle::plat_load(void *p_buffer)
{
	(void)p_buffer;

	printf ("STUB: CAsyncFileHandle::Load\n");

	return 0;
}

size_t				CAsyncFileHandle::plat_read(void *p_buffer, size_t size, size_t count)
{
	(void)p_buffer;
	(void)size;
	(void)count;

	printf ("STUB: CAsyncFileHandle::Read\n");

	return 0;
}

size_t				CAsyncFileHandle::plat_write(void *p_buffer, size_t size, size_t count)
{
	(void)p_buffer;
	(void)size;
	(void)count;

	printf ("STUB: CAsyncFileHandle::Write\n");

	return 0;
}

char *				CAsyncFileHandle::plat_get_s(char *p_buffer, int maxlen)
{
	(void)p_buffer;
	(void)maxlen;

	printf ("STUB: CAsyncFileHandle::GetS\n");

	return nullptr;
}

int					CAsyncFileHandle::plat_seek(long offset, int origin)
{
	(void)offset;
	(void)origin;

	printf ("STUB: CAsyncFileHandle::Seek\n");

	return 0;
}

///////////////////////////////////////////////////////////////////////////////////////

CAsyncFileHandle	*	CAsyncFileLoader::s_file_handles[MAX_FILE_HANDLES];
int						CAsyncFileLoader::s_free_handle_index = 0;

int			CAsyncFileLoader::s_manager_busy_count = 0;
bool			CAsyncFileLoader::s_new_io_completion = false;

CAsyncFileLoader::SCallback	CAsyncFileLoader::s_callback_list[2][MAX_PENDING_CALLBACKS];
int							CAsyncFileLoader::s_num_callbacks[2] = { 0, 0 };
int										CAsyncFileLoader::s_cur_callback_list_index = 0;

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void				CAsyncFileLoader::sInit()
{
	s_free_handle_index = 0;
	s_plat_init();
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void				CAsyncFileLoader::sCleanup()
{
	s_plat_cleanup();
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool				CAsyncFileLoader::sAsyncSupported()
{
	return s_plat_async_supported();
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool				CAsyncFileLoader::sExist(const char *filename)
{
	return s_plat_exist(filename);
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CAsyncFileHandle *	CAsyncFileLoader::sOpen(const char *filename, bool blocking, int priority)
{
	CAsyncFileHandle *p_file_handle = s_get_file_handle();

	if (p_file_handle)
	{
		if (!p_file_handle->open(filename, blocking, priority))
		{
			//Dbg_MsgAssert(0, ("Error opening Async file %s", filename));
			s_free_file_handle(p_file_handle);
			return nullptr;
		}

		return p_file_handle;
	}
	else
	{
		Dbg_MsgAssert(0, ("Out of Async handles"));
		return nullptr;
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool				CAsyncFileLoader::sClose(CAsyncFileHandle *p_file_handle)
{

	bool result = p_file_handle->close();

	bool free_result = s_free_file_handle(p_file_handle);
	if ( !free_result )
	{
		Dbg_MsgAssert(0, ("sClose(): Can't find async handle in CAsyncFileLoader"));
	}

	return result;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void				CAsyncFileLoader::sWaitForIOEvent(bool all_io_events)
{
	bool done = false;

	while (!done)
	{
		printf("CAsyncFileLoader waiting for io completion: busy count %d completion %d\n", s_manager_busy_count, s_new_io_completion);

		// Wait for an event
		while (!s_new_io_completion)
			;

		printf("CAsyncFileLoader got completion: busy count %d completion %d\n", s_manager_busy_count, s_new_io_completion);

		// execute callbacks
		s_execute_callback_list();

		done = true;	// assume we are done for now
		if (all_io_events)
		{
			for (int i = 0; i < MAX_FILE_HANDLES; i++)
			{
				if (s_file_handles[i]->IsBusy())
				{
					printf("CAsyncFileLoader still needs to wait for file handle %d\n", i);
					Dbg_MsgAssert(s_manager_busy_count, ("CAsyncFileLoader busy count is 0 while file handle %d is busy", i));
					done = false;
					break;
				}
			}
		}
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool				CAsyncFileLoader::sAsyncInUse()
{
#if 0
	for (int i = 0; i < MAX_FILE_HANDLES; i++)
	{
		if (s_file_handles[i]->IsBusy())
		{
			return true;
		}
	}

	return false;
#endif

	Dbg_MsgAssert(s_manager_busy_count >= 0, ("CAsyncFileLoader busy count is negative: %d", s_manager_busy_count));
	return s_manager_busy_count > 0;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

CAsyncFileHandle *	CAsyncFileLoader::s_get_file_handle()
{
	if (s_free_handle_index < MAX_FILE_HANDLES)
	{
		// Find a non-busy handle and exchange with busy, if necessary
		if (s_file_handles[s_free_handle_index]->IsBusy())
		{
			int i;
			for (i = s_free_handle_index + 1; i < MAX_FILE_HANDLES; i++)
			{
				if (!s_file_handles[i]->IsBusy())
				{
					CAsyncFileHandle *p_temp = s_file_handles[i];
					s_file_handles[i] = s_file_handles[s_free_handle_index];
					s_file_handles[s_free_handle_index] = p_temp;
					break;
				}
			}
			
			// If we are full, wait for this one
			if (i == MAX_FILE_HANDLES)
			{
				Dbg_Message("CAsyncFileLoader::sOpen(): waiting for old handle to finish up");
				s_file_handles[s_free_handle_index]->WaitForIO();
				Dbg_Message("CAsyncFileLoader::sOpen(): done waiting.");
			}
		}

		s_file_handles[s_free_handle_index]->init();		// Clear out any old stuff first

		return s_file_handles[s_free_handle_index++];
	}
	else
	{
		return nullptr;
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

bool				CAsyncFileLoader::s_free_file_handle(CAsyncFileHandle *p_file_handle)
{
	Dbg_Assert(s_free_handle_index);

	for (int i = 0; i < MAX_FILE_HANDLES; i++)
	{
		if (p_file_handle == s_file_handles[i])
		{
			// Found it, exchange it with last open handle
			s_file_handles[i] = s_file_handles[--s_free_handle_index];
			s_file_handles[s_free_handle_index] = p_file_handle;
			return true;
		}
	}

	return false;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void				CAsyncFileLoader::s_add_callback(CAsyncFileHandle *p_file, EAsyncFunctionType function, int result)
{
	// This will be called from an interrupt
	//scePrintf("Adding callback for handle %x\n", p_file);
	Dbg_MsgAssert(s_num_callbacks[s_cur_callback_list_index] < MAX_PENDING_CALLBACKS, ("add_callback(): list is full"));

	SCallback * p_callback_entry =  &s_callback_list[s_cur_callback_list_index][s_num_callbacks[s_cur_callback_list_index]++];

	p_callback_entry->mp_file_handle	= p_file;
	p_callback_entry->m_function		= function;
	p_callback_entry->m_result			= result;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void				CAsyncFileLoader::s_update()
{
	s_plat_update();
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void				CAsyncFileLoader::s_execute_callback_list()
{
	s_plat_swap_callback_list();
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

DefineSingletonClass( CAsyncFilePoll, "Async File System Poll module" );

CAsyncFilePoll::CAsyncFilePoll()
{
	mp_logic_task = new Tsk::Task< CAsyncFilePoll > ( CAsyncFilePoll::s_logic_code, *this );
}

CAsyncFilePoll::~CAsyncFilePoll()
{
	delete mp_logic_task;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CAsyncFilePoll::v_start_cb ( void )
{
	Mlp::Manager * mlp_manager = Mlp::Manager::Instance();
	mlp_manager->AddLogicTask( *mp_logic_task );
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CAsyncFilePoll::v_stop_cb ( void )
{
	mp_logic_task->Remove();
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

void CAsyncFilePoll::s_logic_code ( const Tsk::Task< CAsyncFilePoll >& task )
{
	(void)task;
	CAsyncFileLoader::s_update();
	CAsyncFileLoader::s_execute_callback_list();
}

}



