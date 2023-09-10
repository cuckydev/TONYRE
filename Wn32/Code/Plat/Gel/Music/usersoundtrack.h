#pragma once

#include <Core/Defines.h>

#include <string>
#include <vector>
#include <filesystem>

namespace UserSoundtrack
{
	// Track definition
	struct Track
	{
		std::filesystem::path path;
	};

	struct Soundtrack
	{
		std::string name;
		std::vector<Track> tracks;
	};

	typedef std::vector<Soundtrack> Soundtracks;

	// Get soundtracks
	const Soundtracks &GetSoundtracks();
}
