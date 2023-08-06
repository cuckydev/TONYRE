#ifndef __SK_HEAP_SIZES_H
#define __SK_HEAP_SIZES_H

// Sizes of heaps

#ifdef	__NOPT_ASSERT__
// K: On debug builds line number info is included in the qb's so add in another 500K for it.
// On release builds the line number info is excluded by passing the nolinenumbers switch to
// cleanass when it is called from easyburn.bat
#define	SCRIPT_HEAP_SIZE					(3824000+500000+130000)
#else
#define	SCRIPT_HEAP_SIZE					(3824000+130000)	   
#endif

// Mick: Note the FRONTEND_HEAP_SIZE encompasses both Frontend and Net heaps.
// as they share the same region, with Net being top down.
#define	FRONTEND_HEAP_SIZE					(1100000)  	 	// was 800000

#define NETMISC_HEAP_SIZE					(160000)
#define	BOOTSTRAP_FRONTEND_HEAP_SIZE		(FRONTEND_HEAP_SIZE-100000)		// we have no network play in bootstrap mode  
#define INTERNET_HEAP_SIZE					(450000)
#define PROFILER_HEAP_SIZE					(60000)

// GJ:  I temporarily increased the size
// of the skater info heap until we can figure
// out how the face texture pathway is going to
// work (right now, I need a heap that wouldn't
// get destroyed when changing levels, to store
// 17K worth of temporary face texture data)
//#define	SKATERINFO_HEAP_SIZE			 	(40000)
// Mick: Increased it again for 2P
#define	SKATERINFO_HEAP_SIZE			 	(60000+2000+20000)	// extra 2000 for skater cams +20K for 2p fragmentation concerns

#define	SKATER_HEAP_SIZE				 	(120000-40000+1000-2000)	// default size of skater heap, minus 2000 since skater cams moved to skater info heap
#define	SKATER_GEOM_HEAP_SIZE			 	(680000 - 16000)	// default size of skater heap, plus a little extra cause we were running out for E3
#define	THEME_HEAP_SIZE     			 	(204800)		// theme textures heap size

#endif // __SK_HEAP_SIZES_H

