#include <SDL.h>

#include "Sys/Config/config.h"
#include "nx_init.h"
#include "sprite.h"
#include "anim.h"
#include "chars.h"
#include "scene.h"
#include "render.h"
#include "instance.h"
#include "gamma.h"
#include "grass.h"
#include "shader.h"

namespace NxWn32
{

sEngineGlobals	EngineGlobals;


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

static double s_next_frame;
static constexpr double c_frame_time = 1000.0 / 60.0;

void WaitForNextFrame(void)
{
	// Wait until next frame
	while (1)
	{
		double now = (double)SDL_GetTicks64();
		if (now >= s_next_frame)
		{
			s_next_frame += c_frame_time;
			break;
		}
		if (now >= s_next_frame + (c_frame_time * 5.0f))
		{
			s_next_frame = now + c_frame_time;
			break;
		}
		SDL_Delay(1);
	}
}

void InitialiseEngine( void )
{
	// Request an OpenGL 3.3 context
	SDL_GL_SetAttribute(SDL_GL_CONTEXT_MAJOR_VERSION, 3);
	SDL_GL_SetAttribute(SDL_GL_CONTEXT_MINOR_VERSION, 3);
	SDL_GL_SetAttribute(SDL_GL_CONTEXT_PROFILE_MASK, SDL_GL_CONTEXT_PROFILE_CORE);

#ifndef NDEBUG
	SDL_GL_SetAttribute(SDL_GL_CONTEXT_FLAGS, SDL_GL_CONTEXT_DEBUG_FLAG);
#endif

	SDL_GL_SetAttribute(SDL_GL_ACCELERATED_VISUAL, 1);

	// Enable MSAA
	// SDL_GL_SetAttribute(SDL_GL_MULTISAMPLEBUFFERS, 1);
	// SDL_GL_SetAttribute(SDL_GL_MULTISAMPLESAMPLES, 8);

	// Create window
	int width = 720 * 16 / 9;
	int height = 720;

	EngineGlobals.window = SDL_CreateWindow("Tony Hawk's Underground", SDL_WINDOWPOS_CENTERED, SDL_WINDOWPOS_CENTERED, width, height, SDL_WINDOW_SHOWN | SDL_WINDOW_OPENGL | SDL_WINDOW_RESIZABLE);
	Dbg_AssertPtr(EngineGlobals.window);

	set_dimensions(width, height);

	// Create OpenGL context
	EngineGlobals.context = SDL_GL_CreateContext(EngineGlobals.window);
	Dbg_AssertPtr(EngineGlobals.context);

	// Load glad
	if (!gladLoadGLLoader(SDL_GL_GetProcAddress))
		Dbg_MsgAssert(0, ("Failed to initialize GLAD"));

	// Check if OpenGL 3.3 is supported
	if (!GLAD_GL_VERSION_3_3)
		Dbg_MsgAssert(0, ("OpenGL 3.3 not supported"));

	// Disable vsync
	SDL_GL_SetSwapInterval(0);

	// Initalize 2D render
	SDraw2D::Init();

	// Initialize frame counter
	s_next_frame = (double)SDL_GetTicks64();

	// Enable vsync
	if (SDL_GL_SetSwapInterval(-1) < 0)
		SDL_GL_SetSwapInterval(1);

	// Create backbuffer FBO
	EngineGlobals.backbuffer = new sFBO(width, height, true);
	EngineGlobals.blurbuffer = new sFBO(width, height, true);

	// Create fullscreen quad
	EngineGlobals.fullscreen_quad = new GlMesh();

	static GLfloat quad_data[6 * 4] = {
		-1.0f, -1.0f, 0.0f, 1.0f, 0.0f, 0.0f, // Bottom left
		1.0f, -1.0f, 0.0f, 1.0f, 1.0f, 0.0f, // Bottom right
		1.0f, 1.0f, 0.0f, 1.0f, 1.0f, 1.0f, // Top right
		-1.0f, 1.0f, 0.0f, 1.0f, 0.0f, 1.0f // Top left
	};
	static GLushort quad_indices[6] = {
		0, 1, 2, // Triangle 1
		0, 2, 3 // Triangle 2
	};

	EngineGlobals.fullscreen_quad->Bind();

	glEnableVertexAttribArray(0);
	glVertexAttribPointer(0, 4, GL_FLOAT, GL_FALSE, 6 * sizeof(GLfloat), (void*)0);

	glEnableVertexAttribArray(1);
	glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, 6 * sizeof(GLfloat), (void*)(4 * sizeof(GLfloat)));

	EngineGlobals.fullscreen_quad->Submit(quad_data, sizeof(quad_data), quad_indices, sizeof(quad_indices));

	/*
	D3DPRESENT_PARAMETERS   params;
	DWORD					video_flags = XGetVideoFlags();

	EngineGlobals.loadingbar_timer_event	= 0;
	
	// Setup default values for the screen conversion macro.
	EngineGlobals.screen_conv_x_multiplier	= 640.0f / 640.0f;
	EngineGlobals.screen_conv_y_multiplier	= 480.0f / 480.0f;
	EngineGlobals.screen_conv_x_offset		= 0;
	EngineGlobals.screen_conv_y_offset		= 16;
	
	ZeroMemory( &params, sizeof( D3DPRESENT_PARAMETERS ));

	// This setting required for any multisample presentation.
	params.SwapEffect						= D3DSWAPEFFECT_DISCARD;

	// Let D3D create the depth-stencil buffer for us.
	params.EnableAutoDepthStencil			= TRUE;

	// Select default refresh rate and presentation interval. Note: When we switch to the December SDK
	// we can use the ONE_OR_IMMEDIATE value (if the tearing looks okay).
	if(( Config::GetDisplayType() == Config::DISPLAY_TYPE_PAL ) && ( Config::FPS() == 60 ))
	{
		// PAL 60Hz has been selected - need to set this refresh rate explicitly.
		params.FullScreen_RefreshRateInHz	= 60;
	}
	else
	{
		params.FullScreen_RefreshRateInHz	= D3DPRESENT_RATE_DEFAULT;
	}
//	params.FullScreen_PresentationInterval	= D3DPRESENT_INTERVAL_ONE;
	params.FullScreen_PresentationInterval	= D3DPRESENT_INTERVAL_ONE_OR_IMMEDIATE;
//	params.FullScreen_PresentationInterval	= D3DPRESENT_INTERVAL_IMMEDIATE;

	// Set up the back buffer format.
	params.BackBufferCount					= 1;
	params.BackBufferWidth					= 640;
	params.BackBufferHeight					= 480;
	params.BackBufferFormat					= D3DFMT_LIN_X8R8G8B8;

	// Set up the Z-stencil buffer format and multisample format.
	params.AutoDepthStencilFormat			= D3DFMT_D24S8;
//	params.MultiSampleType					= D3DMULTISAMPLE_NONE;
	params.MultiSampleType					= D3DMULTISAMPLE_2_SAMPLES_MULTISAMPLE_LINEAR;
//	params.MultiSampleType					= D3DMULTISAMPLE_2_SAMPLES_MULTISAMPLE_QUINCUNX;
//	params.MultiSampleType					= D3DMULTISAMPLE_4_SAMPLES_SUPERSAMPLE_LINEAR;

	// Set flag for widescreen where appropriate.
	if( video_flags & XC_VIDEO_FLAGS_WIDESCREEN )
	{
		params.Flags			|= D3DPRESENTFLAG_WIDESCREEN;

		// Optionally set up 720�480 back buffer.
		// Set up 16:9 projection transform.
	}

	
	// Set flag for progrssive scan where appropriate.
	if( video_flags & XC_VIDEO_FLAGS_HDTV_720p )
	{
		params.Flags			|= D3DPRESENTFLAG_PROGRESSIVE | D3DPRESENTFLAG_WIDESCREEN;
		params.BackBufferWidth	= 1280;
		params.BackBufferHeight	= 720;

		// Turn off FSAA.
		params.MultiSampleType	= D3DMULTISAMPLE_NONE;

		EngineGlobals.screen_conv_x_multiplier	= 1280.0f / 704.0f;
		EngineGlobals.screen_conv_y_multiplier	= 720.0f / 480.0f;
		EngineGlobals.screen_conv_x_offset		= 32;
		EngineGlobals.screen_conv_y_offset		= 32;
	}
	else if( video_flags & XC_VIDEO_FLAGS_HDTV_480p )
	{
		params.Flags			|= D3DPRESENTFLAG_PROGRESSIVE;
	}
//	else if( video_flags & XC_VIDEO_FLAGS_HDTV_1080i )
//	{
//		params.Flags							|= D3DPRESENTFLAG_INTERLACED | D3DPRESENTFLAG_WIDESCREEN | D3DPRESENTFLAG_FIELD;
//		params.BackBufferWidth					= 1920;
//		params.BackBufferHeight					= 540;
//		params.BackBufferFormat					= D3DFMT_LIN_R5G6B5;
//		params.AutoDepthStencilFormat			= D3DFMT_D16;
//		params.FullScreen_PresentationInterval	= D3DPRESENT_INTERVAL_TWO;
//
//		// Turn off FSAA.
//		params.MultiSampleType	= D3DMULTISAMPLE_NONE;
//
//		EngineGlobals.screen_conv_x_multiplier	= 1920.0f / 704.0f;
//		EngineGlobals.screen_conv_y_multiplier	= 1080.0f / 480.0f;
//		EngineGlobals.screen_conv_x_offset		= 32;
//		EngineGlobals.screen_conv_y_offset		= 16;
//	}
	else
	{
		params.Flags			|= D3DPRESENTFLAG_INTERLACED;
	}
	
	if( params.BackBufferWidth == 640 )
	{
		params.Flags			|= D3DPRESENTFLAG_10X11PIXELASPECTRATIO;
	}
	
	// The default push buffer size is 512k. Double this to reduce stalls from filling the push buffer.
	Direct3D_SetPushBufferSize( 2 * 512 * 1024, 32 * 1024 );
	
	if( D3D_OK != Direct3D_CreateDevice(	D3DADAPTER_DEFAULT,
											D3DDEVTYPE_HAL,
											nullptr,
											D3DCREATE_HARDWARE_VERTEXPROCESSING,	// Note: may want to consider adding the PUREDEVICE flag here also.
											&params,
											&EngineGlobals.p_Device ))
	{
		// Failed to start up engine. Bad!
		exit( 0 );
	}

	// Also create the render surface we will use when doing screen blur. (Creating this at 32bit depth also, since still
	// takes up less memory than 720p buffers).
	if( params.BackBufferWidth <= 640 )
	{
		D3DDevice_CreateRenderTarget( 640, 480, D3DFMT_LIN_X8R8G8B8, 0, 0, &EngineGlobals.p_BlurSurface[0] );
		D3DDevice_CreateRenderTarget( 320, 240, D3DFMT_LIN_X8R8G8B8, 0, 0, &EngineGlobals.p_BlurSurface[1] );
		D3DDevice_CreateRenderTarget( 160, 120, D3DFMT_LIN_X8R8G8B8, 0, 0, &EngineGlobals.p_BlurSurface[2] );
		D3DDevice_CreateRenderTarget(  80,  60, D3DFMT_LIN_X8R8G8B8, 0, 0, &EngineGlobals.p_BlurSurface[3] );
	}
	
	// Obtain pointers to the render and Z-stencil surfaces. Doing this increases their reference counts, so release
	// them following the operation.
	D3DDevice_GetRenderTarget( &EngineGlobals.p_RenderSurface );
	D3DDevice_GetDepthStencilSurface( &EngineGlobals.p_ZStencilSurface );

	LPDIRECT3DSURFACE8 pBackBuffer;
    D3DDevice_GetBackBuffer( 0, 0, &pBackBuffer );
	
	// Get back buffer information.
	EngineGlobals.backbuffer_width	= params.BackBufferWidth;
	EngineGlobals.backbuffer_height	= params.BackBufferHeight;
	EngineGlobals.backbuffer_format	= params.BackBufferFormat;
	EngineGlobals.zstencil_depth	= ( params.AutoDepthStencilFormat == D3DFMT_D16 ) ? 16 : 32;
	
	// Get blur buffer information.
	if( EngineGlobals.p_BlurSurface[0] )
	{
		D3DSURFACE_DESC blur_surface_desc;
		EngineGlobals.p_BlurSurface[0]->GetDesc( &blur_surface_desc );
		EngineGlobals.blurbuffer_format	= blur_surface_desc.Format;
	}
	
	// Set our renderstate to a known state.
	InitialiseRenderstates();

	// Set default gamma values.
	SetGammaNormalized( 0.14f, 0.13f, 0.12f );

	// Initialise the memory resident font, used for fatal i/o error messages etc.
	EngineGlobals.p_memory_resident_font = InitialiseMemoryResidentFont();

	// Code to enable detailed timing. Need to link with d3d8i.lib.
//	DmEnableGPUCounter( TRUE );
//	D3DPERF_SetShowFrameRateInterval( 1000 );
//	D3DPERF_GetStatistics()->m_dwDumpFPSInfoMask |= D3DPERF_DUMP_FPS_PERFPROFILE;

	// Now that the D3DDevice is created, it's safe to install vsync handlers.
	Tmr::InstallVSyncHandlers();

	// Load up the bump textures.
//	LoadBumpTextures();
	*/
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void FatalFileError( uint32 error )
{
	(void)error;

	/*
	static char*	p_error_message_english[2]	= {	"There's a problem with the disc you're using.",
													"It may be dirty or damaged." };
	static char*	p_error_message_french[2]	= {	"Le disque utilis� pr�sente une anomalie.",
													"Il est peut-�tre sale ou endommag�." };
	static char*	p_error_message_german[2]	= {	"Bei der benutzten CD ist ein Problem aufgetreten.",
													"M�glicherweise ist sie verschmutzt oder besch�digt." };

	// Turn off the loading bar if it is active.
	if( EngineGlobals.loadingbar_timer_event != 0 )
	{
		timeKillEvent( EngineGlobals.loadingbar_timer_event );
		EngineGlobals.loadingbar_timer_event = 0;
	}

	// Ensure the graphics device has been initialised at this point.
	if( EngineGlobals.p_Device == nullptr )
	{
		InitialiseEngine();
	}

	// Wait for any rendering to complete.
	EngineGlobals.p_Device->BlockUntilIdle();

	char*	p_error_message[2];
	switch( Config::GetLanguage())
	{
		case Config::LANGUAGE_FRENCH:
		{
			p_error_message[0] = p_error_message_french[0];
			p_error_message[1] = p_error_message_french[1];
			break;
		}
		case Config::LANGUAGE_GERMAN:
		{
			p_error_message[0] = p_error_message_german[0];
			p_error_message[1] = p_error_message_german[1];
			break;
		}
		default:
		{
			p_error_message[0] = p_error_message_english[0];
			p_error_message[1] = p_error_message_english[1];
			break;
		}

	}

	// Set up the text string used for the error message.
	SText error_text;
	error_text.mp_font		= (SFont*)EngineGlobals.p_memory_resident_font;
	error_text.m_xpos		= 48.0f;
	error_text.m_ypos		= 128.0f;
	error_text.m_xscale		= 0.8f;
	error_text.m_yscale		= 1.0f;
	error_text.m_rgba		= 0x80808080;
	error_text.mp_next		= nullptr;

	set_texture( 1, nullptr );
	set_texture( 2, nullptr );
	set_texture( 3, nullptr );

	// Want an infinite loop here.
	while( true )
	{
		D3DDevice_Swap( D3DSWAP_DEFAULT );

		// Now that the swap instruction has been pushed, clear the buffer for next frame.
		D3DDevice_Clear( 0, nullptr, D3DCLEAR_TARGET | D3DCLEAR_ZBUFFER | D3DCLEAR_STENCIL, 0x00000000, 1.0f, 0 );

		set_blend_mode( vBLEND_MODE_BLEND );
		set_texture( 0, nullptr );

		set_render_state( RS_UVADDRESSMODE0,	0x00010001UL );
		set_render_state( RS_ZBIAS,				0 );
		set_render_state( RS_ALPHACUTOFF,		1 );
		set_render_state( RS_ZWRITEENABLE,		0 );

		D3DDevice_SetTextureStageState( 0, D3DTSS_COLORSIGN, D3DTSIGN_RUNSIGNED | D3DTSIGN_GUNSIGNED | D3DTSIGN_BUNSIGNED );
		D3DDevice_SetTextureStageState( 0, D3DTSS_TEXTURETRANSFORMFLAGS, D3DTTFF_DISABLE );
		D3DDevice_SetTextureStageState( 0, D3DTSS_TEXCOORDINDEX, D3DTSS_TCI_PASSTHRU | 0 );

		error_text.mp_string	= p_error_message[0];
		error_text.m_ypos		= error_text.m_ypos - 16.0f;
		error_text.BeginDraw();
		error_text.Draw();
		error_text.EndDraw();

		error_text.mp_string	= p_error_message[1];
		error_text.m_ypos		= error_text.m_ypos + 16.0f;
		error_text.BeginDraw();
		error_text.Draw();
		error_text.EndDraw();
	}
	*/
}



} // namespace NxWn32

