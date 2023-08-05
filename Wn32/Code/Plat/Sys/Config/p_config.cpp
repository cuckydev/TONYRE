// Config Manager stuff. KSH 20 Mar 2002
#include <sys/config/config.h>

namespace Config
{

void Plat_Init(sint argc, char** argv)
{
	gHardware = HARDWARE_WIN32;
	gLanguage = LANGUAGE_ENGLISH;	
	gGotExtraMemory = true;
	gCD = true; // Weird name but this is actually a flag to enable developer mode
}

} // namespace Config

