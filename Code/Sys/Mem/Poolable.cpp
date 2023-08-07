#include <sys/mem/CompactPool.h>
#include <sys/mem/Poolable.h>

namespace Mem
{

	int gHeapPools = false;			// set to true to use debug heap instead of pools

template<>
CCompactPool *CPoolable<PoolTest>::sp_pool[POOL_STACK_SIZE] = {nullptr,nullptr};
template<>
bool CPoolable<PoolTest>::s_internallyCreatedPool[POOL_STACK_SIZE] = {false,false};
template<>
int CPoolable<PoolTest>::s_currentPool=0;						


PoolTest::PoolTest()
{
	printf("created PoolTest object\n");
}




PoolTest::~PoolTest()
{
	printf("~PoolTest()\n");
}




}
