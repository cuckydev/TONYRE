//****************************************************************************
//* MODULE:         Gfx
//* FILENAME:       bonedanim.h
//* OWNER:          Gary Jesdanun
//* CREATION DATE:  11/14/2001
//****************************************************************************

#ifndef __GFX_BONEDANIM_H
#define __GFX_BONEDANIM_H

/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/

#include <Core/Defines.h>
#include <Core/support.h>
#include <Core/math.h>

#include <Core/String/CString.h>

#include <Sys/File/AsyncFilesys.h>

#include <Gfx/CustomAnimKey.h>

/*****************************************************************************
**								   Defines									**
*****************************************************************************/

/*****************************************************************************
**							Forward Declarations							**
*****************************************************************************/

namespace Nx
{
	class CQuickAnim;
}

namespace Obj
{
	class CObject;
}

namespace File
{
	class CAsyncFileHandle;
}
			 
namespace Gfx
{
	class CAnimQKey;
	class CAnimTKey;
	struct SAnimCustomKey;
	struct SQuickAnimPointers;

/*****************************************************************************
**							   Class Definitions							**
*****************************************************************************/

// Raw Animation Data
class CBonedAnimFrameData
{
public:
    CBonedAnimFrameData();
    ~CBonedAnimFrameData();

public:
    bool    			   	Load(uint32* pData, int file_size, bool assertOnFail);
    bool    			   	Load(const char* p_fileName, bool assertOnFail, bool async, bool use_pip = false);
    bool    			   	PostLoad(bool assertOnFail, int file_size, bool delete_buffer = true);
	bool					LoadFinished();
	bool					IsValidTime(float time);
	float					GetDuration();
	size_t					GetNumBones();
	uint32					GetBoneName(size_t index );
    bool					GetInterpolatedFrames(Mth::Quat* pRotations, Mth::Vector* pTranslations, float time, Nx::CQuickAnim* = nullptr);
    bool					GetCompressedInterpolatedFrames(Mth::Quat* pRotations, Mth::Vector* pTranslations, float time, Nx::CQuickAnim* = nullptr);
    bool					GetCompressedInterpolatedPartialFrames(Mth::Quat* pRotations, Mth::Vector* pTranslations, float time, Nx::CQuickAnim* = nullptr);
    bool					GetInterpolatedCameraFrames(Mth::Quat* pRotations, Mth::Vector* pTranslations, float time, Nx::CQuickAnim* = nullptr);
	bool					ResetCustomKeys( void );
	bool					ProcessCustomKeys( float startTimeInclusive, float endTimeExclusive, Obj::CObject* pObject, bool endInclusive = false );

	CAnimQKey*				GetQFrames( void ) { return (CAnimQKey*)mp_qFrames; }
	CAnimTKey*				GetTFrames( void ) { return (CAnimTKey*)mp_tFrames; }

	void					SetQFrames( CAnimQKey * p_q ) { mp_qFrames = (char*)p_q; }
	void					SetTFrames( CAnimTKey * p_t ) { mp_tFrames = (char*)p_t; }

protected:	
	size_t get_num_customkeys();
	CCustomAnimKey *get_custom_key(size_t index );

	size_t get_num_qkeys( void * p_frame_data, size_t boneIndex ) const;
	size_t get_num_tkeys( void * p_frame_data, size_t boneIndex ) const;
	void set_num_qkeys(size_t boneIndex, size_t numKeys );
	void set_num_tkeys(size_t boneIndex, size_t numKeys );

	bool is_hires() const;

	static void async_callback(File::CAsyncFileHandle *, File::EAsyncFunctionType function, int result, unsigned int arg0, unsigned int arg1);

protected:
//	bool intermediate_read_stream(void* pStream);
    bool plat_read_stream(uint8* pData, bool delete_buffer = true);
    bool plat_read_compressed_stream(uint8* pData, bool delete_buffer = true);
	bool plat_dma_to_aram(size_t qbytes = 0, size_t tbytes = 0, uint32 flags = 0 );
	
protected:
	float m_duration;		  // could be a short
	uint32 m_flags;
	size_t m_numBones;

	// file buffer (the only malloc'ed pointer)
	char *mp_fileBuffer;
	File::CAsyncFileHandle *mp_fileHandle;
	size_t m_fileSize;

	// massive block of all Q-frames and T-frames
	char *mp_qFrames;
	char *mp_tFrames;

	// per-bone pointers into the massive block of Q-frames and T-frames
	void *mp_perBoneFrames;

	// list of bone names (for object anims only)
	uint32 *mp_boneNames;
		
	// original number of bones + list of bone masks (for partial anims only)
	uint32 *mp_partialAnimData;

	uint32 m_fileNameCRC;

	// custom keys (for cameras, changing parent bones, etc.)
	CCustomAnimKey **mpp_customAnimKeyList;

	uint16 *mp_perBoneQFrameSize;
	uint16 *mp_perBoneTFrameSize;
	
	size_t m_num_qFrames;
	size_t m_num_tFrames;
	size_t m_num_customKeys;
	
	short m_printDebugInfo:1;
	short m_dataLoaded:1;
	short m_pipped:1;
};

/*****************************************************************************
**							 Private Declarations							**
*****************************************************************************/

/*****************************************************************************
**							  Private Prototypes							**
*****************************************************************************/

/*****************************************************************************
**							  Public Declarations							**
*****************************************************************************/

/*****************************************************************************
**							   Public Prototypes							**
*****************************************************************************/

bool InitQ48Table( const char* pFileName, bool assertOnFail = true );
bool InitT48Table( const char* pFileName, bool assertOnFail = true );

/*****************************************************************************
**								Inline Functions							**
*****************************************************************************/

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
inline float CBonedAnimFrameData::GetDuration()
{
	return m_duration;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
inline size_t CBonedAnimFrameData::GetNumBones()
{
	return m_numBones;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
inline bool CBonedAnimFrameData::LoadFinished()
{
	return m_dataLoaded;
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
} // namespace Gfx

#endif	// __GFX_BONEDANIM_H
