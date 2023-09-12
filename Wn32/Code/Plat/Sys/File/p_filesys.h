#pragma once

#include <Core/Defines.h>

#include <Sys/File/filesys.h>

#include <filesystem>

namespace File
{
	// Return module path
	std::filesystem::path ModulePath();

	// Return data path
	std::filesystem::path DataPath();
}
