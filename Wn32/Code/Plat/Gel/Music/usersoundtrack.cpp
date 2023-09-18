#include "usersoundtrack.h"

#include <Plat/Sys/File/p_filesys.h>

#include <filesystem>

namespace UserSoundtrack
{
	// User soundtrack indexer
	Soundtracks IndexSoundtracks()
	{
		// Get user soundtrack path
		std::filesystem::path usersoundtrack_path = File::ModulePath() / "Soundtracks";
		if (!std::filesystem::exists(usersoundtrack_path))
			return Soundtracks();

		// Iterate over folders in user soundtrack path
		Soundtracks soundtracks;
		for (const auto &soundtrack_entry : std::filesystem::directory_iterator(usersoundtrack_path))
		{
			// Check if entry is a directory
			if (soundtrack_entry.is_directory())
			{
				// Create soundtrack
				Soundtrack soundtrack;
				std::filesystem::path::string_type name = soundtrack_entry.path().filename().native();
				
				soundtrack.name.reserve(name.size());
				for (auto &c : name)
				{
					if (c >= 0x20 && c < 0x80)
						soundtrack.name.push_back((char)c);
					else
						soundtrack.name.push_back('?');
				}

				// Iterate over files in soundtrack path
				for (const auto &song_entry : std::filesystem::recursive_directory_iterator(soundtrack_entry.path()))
				{
					// Check if entry is a file
					if (song_entry.is_regular_file())
					{
						// Create track
						Track track;
						track.path = song_entry.path();

						// Add track to soundtrack
						soundtrack.tracks.push_back(track);
					}
				}

				// Add soundtrack to soundtracks
				soundtracks.push_back(soundtrack);
			}
		}

		return soundtracks;
	}

	// Get soundtracks
	const Soundtracks &GetSoundtracks()
	{
		static Soundtracks soundtracks(IndexSoundtracks());
		return soundtracks;
	}
}