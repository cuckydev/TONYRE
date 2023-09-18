//****************************************************************************
//* MODULE:         Gfx
//* FILENAME:       NxQuickAnim.h
//* OWNER:          Gary Jesdanun
//* CREATION DATE:  2/4/2003
//****************************************************************************

#ifndef	__GFX_NXQUICKANIM_H__
#define	__GFX_NXQUICKANIM_H__

// The CQuickAnim is a per-object interface to the CBonedAnimFrameData
// (which is raw animation data).  Because multiple objects can be playing 
// the same animation at the same time, we can't do anything fancy like 
// caching pointers inside the CBonedAnimFrameData;  however, since each 
// object has its own CQuickAnim, we can store pointers or decompress data
// or whatever here.  I've decided to give this class a p-line interface
// so that different platforms can implement different optimizations
// based on whether speed or memory is the bottleneck.  							
							
/*****************************************************************************
**							  	  Includes									**
*****************************************************************************/

#include <Core/Defines.h>
#include <Core/support.h>

#include <Gfx/BonedAnimTypes.h>

/*****************************************************************************
**								   Defines									**
*****************************************************************************/

/*****************************************************************************
**							Forward Declarations							**
*****************************************************************************/

namespace Gfx
{
	class CBonedAnimFrameData;
}

namespace Obj
{
	class CObject;
}

namespace Mth
{
	class Quat;
	class Vector;
}

namespace Nx
{

/*****************************************************************************
**							   Class Definitions							**
*****************************************************************************/

class CQuickAnim : public Spt::Class
{
public:
	CQuickAnim();
	virtual ~CQuickAnim();

public:
	void						SetAnimAssetName( uint32 animAssetName );
	void						GetInterpolatedFrames( Mth::Quat* pRotations, Mth::Vector* pTranslations, uint32* pSkipList, uint32 skipIndex, float time );
	void						GetInterpolatedHiResFrames( Mth::Quat* pRotations, Mth::Vector* pTranslations, float time );
	void						Enable(bool enabled);
	size_t						GetNumBones();
	void						ResetCustomKeys();
	float						GetDuration();
	uint32						GetBoneName( int i );
	bool						ProcessCustomKeys( float startTimeInclusive, float endTimeExclusive, Obj::CObject* pObject );

private:
    // The virtual functions will have a stub implementation in p_nxquickanim.cpp
	virtual	void				plat_get_interpolated_frames( Mth::Quat* pRotations, Mth::Vector* pTranslations, uint32* pSkipList, uint32 skipIndex, float time );

protected:
	Gfx::CBonedAnimFrameData*	mp_frameData = nullptr;
	uint32						m_animAssetName = 0;

public:
	Gfx::SQuickAnimPointers		m_quickAnimPointers;
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

/*****************************************************************************
**								Inline Functions							**
*****************************************************************************/

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
	
} // namespace Gfx

#endif	// __GFX_NXQUICKANIM_H__
