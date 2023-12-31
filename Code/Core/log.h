#ifndef __CORE_DEBUG_LOG_H
#define __CORE_DEBUG_LOG_H

namespace Log
{
void Init();
void AddEntry(const char *p_fileName, int lineNumber, const char *p_functionName, const char *p_message=nullptr);
}

#endif // #ifndef __CORE_DEBUG_LOG_H

