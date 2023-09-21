/*****************************************************************************
**																			**
**			              Neversoft Entertainment			                **
**																		   	**
**				   Copyright (C) 1999 - All Rights Reserved				   	**
**																			**
******************************************************************************
**																			**
**	Project:		SYS Library												**
**																			**
**	Module:			SYS (SYS_) 												**
**																			**
**	File name:		sioman.cpp												**
**																			**
**	Created:		05/26/2000	-	spg										**
**																			**
**	Description:	Serial IO Manager										**
**																			**
*****************************************************************************/


/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/

#include <SDL.h>

#include <Core/Defines.h>

#include <Sys/sioman.h>
#include <Sys/siodev.h>
#include <Sys/SIO/keyboard.h>

#include <Gel/module.h>

#include <Gel/Music/music.h>

/*****************************************************************************
**								DBG Information								**
*****************************************************************************/

extern int KeyboardInit(void);

namespace SIO
{

/*****************************************************************************
**								  Externals									**
*****************************************************************************/


/*****************************************************************************
**								Private Types								**
*****************************************************************************/


/*****************************************************************************
**								 Private Data								**
*****************************************************************************/

DefineSingletonClass( Manager, "Serial IO Manager" );

/*****************************************************************************
**								 Public Data								**
*****************************************************************************/



/*****************************************************************************
**							  Private Prototypes							**
*****************************************************************************/


/*****************************************************************************
**							   Private Functions							**
*****************************************************************************/

void Manager::process_devices(const Tsk::Task< Manager::DeviceList > &task)
{
	Device*					device;
	Lst::Search< Device >	    sh;
	Manager::DeviceList&	device_list = task.GetData();

	device = sh.FirstItem ( device_list );

	while ( device )
	{
		Dbg_AssertType ( device, Device );

		device->process();
		device = sh.NextItem();
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

Device* Manager::create_device( int index, int port, int slot )
{
	Device *device;
	
	device = new Device( index, port, slot );

	return device;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

/*****************************************************************************
**							   Public Functions								**
*****************************************************************************/

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
Manager::Manager ( void )
{
	// Initialize SDL
	Dbg_MsgAssert(SDL_Init(SDL_INIT_VIDEO | SDL_INIT_AUDIO | SDL_INIT_JOYSTICK | SDL_INIT_GAMECONTROLLER | SDL_INIT_HAPTIC) == 0, ("Failed to initialize SDL: %s", SDL_GetError()));

	m_process_devices_task = new Tsk::Task< DeviceList >(Manager::process_devices, m_devices);

	// Create devices
	for (int i = 0; i < SIO::vMAX_PORT; i++)
	{
		Device *p_device;

		if ((p_device = create_device(i, i, 0)) != nullptr)
		{
			m_devices.AddToTail(p_device->m_node);
			p_device->Acquire();
		}
	}

	// Initialize music
	// TODO: This should be moved elsewhere
	if (!Pcm::NoMusicPlease())
	{
		Pcm::Init();
	}

	// Print SDL all connected game controllers
	printf("VVV SDL GAME CONTROLLERS VVV\n");
	for (int i = 0; i < SDL_NumJoysticks(); i++)
	{
		if (SDL_IsGameController(i))
			printf("Found game controller: %s (player index %d)\n", SDL_GameControllerNameForIndex(i), SDL_GameControllerGetPlayerIndex(SDL_GameControllerOpen(i)));
		else
			printf("Found joystick: %s\n", SDL_JoystickNameForIndex(i));
	}
	printf("VVV SDL GAME CONTROLLERS ^^^\n");

	/*
	int i, index;

	XDEVICE_PREALLOC_TYPE xdpt[] = {{ XDEVICE_TYPE_GAMEPAD,			4 },
									{ XDEVICE_TYPE_MEMORY_UNIT,		1 }};

	// Initialize the peripherals.
	XInitDevices( sizeof( xdpt ) / sizeof( XDEVICE_PREALLOC_TYPE ), xdpt );

	// Create the keyboard queue.
//	XInputDebugInitKeyboardQueue( &xdkp );

	m_process_devices_task = new Tsk::Task< DeviceList > ( Manager::process_devices, m_devices );
	
	// Pause briefly here to give the system time to enumerate the attached devices.
	Sleep( 1000 );

	index = 0;
	for( i = 0; i < SIO::vMAX_PORT; i++ )
	{
		Device* p_device;

		if(( p_device = create_device( index, i, 0 )))
		{
			m_devices.AddToTail( p_device->m_node );
			p_device->Acquire();
			index++;
		}
	}
	
	if( !Pcm::NoMusicPlease())
	{
		Pcm::Init();
	}

	Dbg_Message( "Initialized Controller lib\n" );
	*/
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
Manager::~Manager( void )
{
	Device*					device;
	Device*					next;
	Lst::Search< Device >	sh;
	
	device = sh.FirstItem ( m_devices );
	
	while ( device )
	{
		Dbg_AssertType ( device, Device );
	
		next = sh.NextItem();
	
		delete device;
		device = next;
	}

	delete m_process_devices_task;

#	if KEYBOARD_ON
	// Initialize the keyboard.
	KeyboardDeinit();
#	endif

	Dbg_Message( "Shut down IOP Controller Lib\n" );
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void Manager::ProcessDevices( void )
{
	Device*					device;
	Lst::Search< Device >	sh;
	Manager::DeviceList&	device_list = m_devices;

	device = sh.FirstItem( device_list );

	while( device )
	{
		Dbg_AssertType ( device, Device );

		device->process();
		device = sh.NextItem();
	}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
Device* Manager::GetDevice( int port, int slot )
{
	Lst::Search<Device> sh;
	
	for (Device *device = sh.FirstItem(m_devices); device; device = sh.NextItem())
	{
		if ((device->GetPort() == port) && (device->GetSlot() == slot))
			return device;
	}
	return nullptr;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
Device* Manager::GetDeviceByIndex( int index )
{
	Lst::Search<Device> sh;
	
	for (Device *device = sh.FirstItem(m_devices); device; device = sh.NextItem())
	{
		if (device->GetIndex() == index)
			return device;
	}
	return nullptr;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void Manager::Pause()
{
	Lst::Search<Device> sh;
	
	for(Device *device = sh.FirstItem(m_devices); device; device = sh.NextItem())
		device->Pause();
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void Manager::UnPause( void )
{
	Lst::Search<Device> sh;

	for (Device *device = sh.FirstItem(m_devices); device; device = sh.NextItem())
		device->UnPause();
}


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

} // namespace SIO
