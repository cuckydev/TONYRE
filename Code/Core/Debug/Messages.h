/*****************************************************************************
**																			**
**					   	  Neversoft Entertainment							**
**																		   	**
**				   Copyright (C) 1999 - All Rights Reserved				   	**
**																			**
******************************************************************************
**																			**
**	Project:		Core Library											**
**																			**
**	Module:			Debug (Dbg_)											**
**																			**
**	File name:		core/debug/messages.h									**
**																			**
**	Created:		05/27/99	-	mjb										**
**																			**
*****************************************************************************/

#ifndef __CORE_DEBUG_MESSAGES_H
#define __CORE_DEBUG_MESSAGES_H

/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/

#include <Core/flags.h>

#include <Core/Debug/Signatrs.h>
#include <Core/Debug/Project.h>
#include <Core/Debug/Module.h>

#ifdef __NOPT_ASSERT__

/*****************************************************************************
**								   Defines									**
*****************************************************************************/
namespace Dbg
{


enum Level
{
	vERROR,
	vWARNING,
	vNOTIFY,
	vMESSAGE,
	vPRINTF
};

enum Mask
{
	mERROR		=	(1<<vERROR),
	mWARNING	= 	(1<<vWARNING),
	mNOTIFY		=	(1<<vNOTIFY),
	mMESSAGE	=	(1<<vMESSAGE),
	mPRINTF		=	(1<<vPRINTF),
	mALL		=	( mERROR	|
					  mWARNING	|
					  mNOTIFY	|
					  mMESSAGE	|
					  mPRINTF ),
	mNONE		=	0
};

/*****************************************************************************
**							     Type Defines								**
*****************************************************************************/

typedef void ( OutputCode )(const char* );

/*****************************************************************************
**							 Private Declarations							**
*****************************************************************************/

extern 	char*				sprintf_pad;
#ifdef	__NOPT_DEBUG__
extern	Signature*			current_sig;
#endif
extern	OutputCode			default_print;

/*****************************************************************************
**							  Private Prototypes							**
*****************************************************************************/

void	set_output( OutputCode* handler = default_print );
void	level_mask( Flags< Mask > mask );
void	message( const char* text, ...);
void	notify ( const char* text, ...);
void	warning( const char* text, ...);
void	error  ( const char* text, ...);

/*****************************************************************************
**							  Public Declarations							**
*****************************************************************************/

/*****************************************************************************
**							   Public Prototypes							**
*****************************************************************************/

} // namespace Dbg

/*****************************************************************************
**									Macros									**
*****************************************************************************/

#if (defined ( __PLAT_XBOX__ ) || defined( __PLAT_WN32__ ))

inline void Dbg_SetOutput(const char *A ...) { (void)A; };
#define	Dbg_LevelMask(A) { Dbg::level_mask(A); }

inline void Dbg_Printf( const char* A ... ) { (void)A; };
inline void Dbg_Message( const char* A ... )	{ (void)A; };
inline void Dbg_Notify( const char* A ... )		{ (void)A; };
inline void Dbg_Warning( const char* A ... )	{ (void)A; };
inline void Dbg_Error( const char* A ... )		{ (void)A; };

#else

#define	Dbg_SetOutput(A...)		{ Dbg::set_output(##A); 	}
#define	Dbg_LevelMask(A)		{ Dbg::level_mask(A); 		}


#ifdef	__NOPT_DEBUG__
#define Dbg_Printf(...)		{ printf(__VA_ARGS__); 		}
#define Dbg_Message(...) 		{ /*Dbg::current_sig = &Dbg_signature;*/ Dbg::message(__VA_ARGS__);	}
#define Dbg_Notify(...) 		{ /*Dbg::current_sig = &Dbg_signature;*/ Dbg::notify(__VA_ARGS__);	}
#define Dbg_Warning(...) 		{ /*Dbg::current_sig = &Dbg_signature;*/ Dbg::warning(__VA_ARGS__);	}
#define Dbg_Error(...) 		{ /*Dbg::current_sig = &Dbg_signature;*/ Dbg::error(__VA_ARGS__);	}
#else
#define Dbg_Printf(...)		{ printf(__VA_ARGS__); 		}
#define Dbg_Message(...) 		{ Dbg::message(__VA_ARGS__);	}
#define Dbg_Notify(...) 		{ Dbg::notify(__VA_ARGS__);	}
#define Dbg_Warning(...) 		{ Dbg::warning(__VA_ARGS__);	}
#define Dbg_Error(...) 		{ Dbg::error(__VA_ARGS__);	}
#endif

#endif	// __PLAT_XBOX__

/*****************************************************************************
**									Stubs									**
*****************************************************************************/

#else

inline void Dbg_SetOutput( const char* A ... )	{};
#define	Dbg_LevelMask(A)
inline void Dbg_Printf( const char* A ... )		{};
inline void Dbg_Message( const char* A ... )	{};
inline void Dbg_Notify( const char* A ... )		{};
inline void Dbg_Warning( const char* A ... )	{};
inline void Dbg_Error( const char* A ... )		{};

#endif	// __NOPT_MESSAGES__

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/

// A special printf function that only works for Ryan
// (since I love them so much)

#if defined ( __PLAT_XBOX__ ) || defined ( __PLAT_WN32__ )
inline void Ryan(const char* A ...) { (void)A; };
inline void Ken(const char* A ...) { (void)A; };
inline void Matt(const char* A ...) { (void)A; };
#else

#ifdef __USER_RYAN__
#define Ryan(A...)  printf(##A) 		
#else
#define Ryan(A...)
#endif

#if defined(__USER_KEN__) && defined(__NOPT_DEBUG__)
#define Ken(A...)  printf(##A) 		
#else
#define Ken(A...)
#endif

#if  defined(__USER_MATT__) && defined(__NOPT_DEBUG__)
#define Matt(A...)  printf(##A) 		
#else
#define Matt(A...)
#endif

#endif

#endif	// __CORE_DEBUG_MESSAGES_H
