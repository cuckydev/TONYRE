#ifndef __MODULES_PCM_PCM_H
#define __MODULES_PCM_PCM_H

#define NUM_STREAMS 3

#define PCM_RPC_ARG_NUM_INTS 16

#define DEFAULT_PITCH	0x1000

// VAG header structure
typedef struct
{
	char ID[4];
	int version;
	char reserved1[4];
	int dataSize;
	int sampleFreq;
	char reserved2[12];
	char name[16];
} VagHeader;

#define SIZE_OF_VAGHEADER ( sizeof( VagHeader ) )

// sound stuff:
#define SB_BUF_SIZE ( 1024 * 32 )		// hex 2000
#define SB_BUF_HALF ( SB_BUF_SIZE / 2 )	// hex 1000
#define SB_BUF_SIZE_WITH_PADDING	( SB_BUF_SIZE + 0x40 )

// spu ram layout:
// first valid address for use in SPU RAM
#define SPU_RAM_SIZE					0x1fffff
#define SB_FIRST_USEABLE_ADDR			0x5010

//#define STRAY_VOICE_BLOCKER_SIZE		128
//#define STRAY_VOICE_BLOCKER_SPU_ADDR	SB_TOP
//#define STREAM_SPU_ADDR					( STRAY_VOICE_BLOCKER_SPU_ADDR + STRAY_VOICE_BLOCKER_SIZE )
#define STREAM_SPU_ADDR					SB_FIRST_USEABLE_ADDR

// slip in room for 3 streaming VAGS ( 2 for stereo music and one extra stream ):
//#define SINGLE_STREAM_BUFFER_SIZE 2048
#define TOTAL_SPU_REQUIRED_FOR_STREAMS		( SB_BUF_SIZE_WITH_PADDING * 4 )
#define MUSIC_L_SPU_BUF_LOC					( STREAM_SPU_ADDR + 0x40 )
#define MUSIC_R_SPU_BUF_LOC					( MUSIC_L_SPU_BUF_LOC + SB_BUF_SIZE_WITH_PADDING )
#define STREAM_SPU_BUF_LOC( i )				( MUSIC_R_SPU_BUF_LOC + ( ( 1 + ( i ) ) * SB_BUF_SIZE_WITH_PADDING ) )

#define END_OF_STREAMS						( STREAM_SPU_ADDR + TOTAL_SPU_REQUIRED_FOR_STREAMS + 0x40 )

//#define RAM_NEEDED_FOR_EFFECTS		0	// FUCK the effects...
#define	RAM_NEEDED_FOR_EFFECTS			0xade0 // enough for HALL reverb
//#define	RAM_NEEDED_FOR_EFFECTS		0xF6C0 // enough for space echo
 
#define REVERB_ONLY_ON_CORE_0			1

#if !REVERB_ONLY_ON_CORE_0

#define CORE_1_EFFECTS_START_ADDRESS	END_OF_STREAMS
#define CORE_1_EFFECTS_END_ADDRESS		0x02ffff // has to be on a 0xffff boundary!!
#if ( ( CORE_1_EFFECTS_END_ADDRESS - CORE_1_EFFECTS_START_ADDRESS ) < RAM_NEEDED_FOR_EFFECTS )
#error "not enough space for core 0 effects!"
#endif

#define BASE_WAVE_DATA_ADDR				CORE_0_EFFECTS_END_ADDRESS

#else
#define BASE_WAVE_DATA_ADDR				END_OF_STREAMS
#endif

#define CORE_0_EFFECTS_START_ADDRESS	( SPU_RAM_SIZE - RAM_NEEDED_FOR_EFFECTS )
#define CORE_0_EFFECTS_END_ADDRESS		( SPU_RAM_SIZE )
#define END_WAVE_DATA_ADDR				( CORE_0_EFFECTS_START_ADDRESS  - 0x40 )

// used by temporary sounds and permanently loaded sounds...
#define MAX_SPU_RAM_AVAILABLE			( END_WAVE_DATA_ADDR - BASE_WAVE_DATA_ADDR )

//#define MUSIC_R_SPU_BUF_LOC		SB_TOP
//#define MUSIC_L_SPU_BUF_LOC		( MUSIC_R_SPU_BUF_LOC + SB_BUF_SIZE )
//#define STREAM_SPU_BUF_LOC		( MUSIC_L_SPU_BUF_LOC + SB_BUF_SIZE )

// iop buffer taking streams off of the CD:
#define MUSIC_IOP_BUFFER_SIZE				( 1024 * 192 )  // must be a multiple of 4k!
#define MUSIC_HALF_IOP_BUFFER_SIZE			( MUSIC_IOP_BUFFER_SIZE / 2 )  // must be a multiple of 2k!
#define STREAM_IOP_BUFFER_SIZE				( 1024 * /*128*/64 )  // must be a multiple of 4k!
#define STREAM_HALF_IOP_BUFFER_SIZE			( STREAM_IOP_BUFFER_SIZE / 2 )  // must be a multiple of 2k!

// must match values in pcm_com.c!!!
#define TOTAL_IOP_BUFFER_SIZE_NEEDED		( ( MUSIC_IOP_BUFFER_SIZE * 2 ) + ( STREAM_IOP_BUFFER_SIZE * NUM_STREAMS ) )
#define ALLIGN_REQUIREMENT					64
#define SECTOR_SIZE							( 2048 )
#define NUM_SECTORS_PER_STREAM_BUFFER		( STREAM_IOP_BUFFER_SIZE / SECTOR_SIZE )
#define NUM_SECTORS_PER_STREAM_HALF_BUFFER	( NUM_SECTORS_PER_STREAM_BUFFER / 2 )
#define NUM_SECTORS_PER_MUSIC_BUFFER		( MUSIC_IOP_BUFFER_SIZE / SECTOR_SIZE )
#define NUM_SECTORS_PER_MUSIC_HALF_BUFFER	( NUM_SECTORS_PER_MUSIC_BUFFER / 2 )

#define MUSIC_L_IOP_OFFSET	0
#define MUSIC_R_IOP_OFFSET	( MUSIC_HALF_IOP_BUFFER_SIZE )  // interwoven with the L IOP buffer... and shit
#define STREAM_IOP_OFFSET( ch )				( ( 2 * MUSIC_IOP_BUFFER_SIZE ) + ( STREAM_IOP_BUFFER_SIZE * ( ch ) ) )

#define MUSIC_L_VOICE	22
#define MUSIC_R_VOICE	23
#define MUSIC_CORE		1

#define STREAM_VOICE( i ) ( 23 - ( i ) )
#define STREAM_CORE		0

// RPC command:
#define EzADPCM_COMMAND_MASK			0xfff0
#define EzADPCM_CH_MASK					0x000f
	
#define EzADPCM_INIT					0x0000
#define EzADPCM_QUIT					0x0010
#define EzADPCM_PLAYMUSIC				0x0020
#define EzADPCM_STOPMUSIC				0x0030
#define EzADPCM_PLAYSTREAM				0x0040
#define EzADPCM_STOPSTREAM				0x0070
#define EzADPCM_STOPSTREAMS				0x00a0
#define EzADPCM_SETMUSICVOL				0x00b0
#define EzADPCM_SETSTREAMVOL			0x00c0
#define EzADPCM_SETSTREAMVOLANDPITCH	0x00d0
#define EzADPCM_GETSTATUS				0x00e0
#define EzADPCM_GETMUSICSTATUS			0x00f0
#define EzADPCM_PAUSEMUSIC				0x0100
#define EzADPCM_PAUSESTREAM				0x0110
#define EzADPCM_PAUSESTREAMS			0x0120
#define EzADPCM_SETSTREAMGLOBVOL		0x0130
#define EzADPCM_SDINIT					0x7ff0

// for GETSTREAMSTATUS or GETMUSICSTATUS:
#define PCM_STATUS					0x0001f000
#define PCM_STATUS_IDLE		   		0x00000000
#define PCM_STATUS_PRELOAD			0x00001000
#define PCM_STATUS_READY_TO_STOP	0x00002000
#define PCM_STATUS_NEED_UPDATE		0x00003000
#define PCM_STATUS_RUNNING			0x00005000
#define PCM_STATUS_TERMINATE		0x00006000

// flags for GETSTATUS
#define PCMSTATUS_NEED_MUSIC_BUFFER_0	( 1 << 0 )
#define PCMSTATUS_NEED_MUSIC_BUFFER_1	( 1 << 1 )
#define PCMSTATUS_NEED_STREAM0_BUFFER_0	( 1 << 2 ) // don't change the order of these!!! IMPORTANT!
#define PCMSTATUS_NEED_STREAM1_BUFFER_0	( 1 << 3 )
#define PCMSTATUS_NEED_STREAM2_BUFFER_0	( 1 << 4 )
#define PCMSTATUS_NEED_STREAM0_BUFFER_1	( 1 << 5 )
#define PCMSTATUS_NEED_STREAM1_BUFFER_1	( 1 << 6 )
#define PCMSTATUS_NEED_STREAM2_BUFFER_1	( 1 << 7 )
#define PCMSTATUS_MUSIC_PLAYING			( 1 << 8 )
#define PCMSTATUS_STREAM0_PLAYING		( 1 << 9 )
#define PCMSTATUS_STREAM1_PLAYING		( 1 << 10 )
#define PCMSTATUS_STREAM2_PLAYING		( 1 << 11 )
#define PCMSTATUS_LOAD_MUSIC			( 1 << 12 )
#define PCMSTATUS_LOAD_STREAM0			( 1 << 13 )
#define PCMSTATUS_LOAD_STREAM1			( 1 << 14 )
#define PCMSTATUS_LOAD_STREAM2			( 1 << 15 )
#define PCMSTATUS_INITIALIZED			( 1 << 16 )

// macros:
#define PCMSTATUS_NEED_STREAM_BUFFER_0( xxx )	( PCMSTATUS_NEED_STREAM0_BUFFER_0 << ( xxx ) )
#define PCMSTATUS_NEED_STREAM_BUFFER_1( xxx )	( PCMSTATUS_NEED_STREAM0_BUFFER_1 << ( xxx ) )
#define PCMSTATUS_STREAM_PLAYING( xxx )			( PCMSTATUS_STREAM0_PLAYING << ( xxx ) )
#define PCMSTATUS_LOAD_STREAM( xxx )			( PCMSTATUS_LOAD_STREAM0 << ( xxx ) )
// Module ID number
#define EzADPCM_DEV 0x00012345

/* ----------------------------------------------------------------
 *	End on File
 * ---------------------------------------------------------------- */
#endif // __MODULES_PCM_PCM_H
/* DON'T ADD STUFF AFTER THIS */
