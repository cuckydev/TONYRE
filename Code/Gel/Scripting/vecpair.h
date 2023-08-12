#ifndef	__SCRIPTING_VECPAIR_H
#define	__SCRIPTING_VECPAIR_H

#ifndef __CORE_DEFINES_H
#include <Core/Defines.h>
#endif

#ifndef __SYS_MEM_POOLABLE_H
#include <Sys/Mem/Poolable.h>
#endif

namespace Script
{

// Note: These are not derived from CClass to avoid the extra memory overhead due to the virtual destructor.

class CVector : public Mem::CPoolable<CVector>
{
public:
	CVector();
	// No copy constructor or assignement operators needed, the defaults will work.

	union
	{
		CVector *mpNext;
		float mX;
	};	
	
	float mY;
	float mZ;
};

class CPair : public Mem::CPoolable<CPair>
{
public:
	CPair();
	// No copy constructor or assignement operators needed, the defaults will work.

	union
	{
		CPair *mpNext;
		float mX;
	};	
	
	float mY;
};

} // namespace Script

#endif // #ifndef	__SCRIPTING_VECPAIR_H
