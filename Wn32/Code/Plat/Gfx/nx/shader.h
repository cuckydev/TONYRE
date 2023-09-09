#pragma once

#include "nx_init.h"

namespace NxWn32
{
	class sShader
	{
		public:
			// Shader program and shaders
			GLuint program;

		public:
			sShader(const char *vertex, const char *fragment);
			~sShader();
	};

	sShader *SpriteShader();
	sShader *BasicShader();
	sShader *BonedShader();
} // namespace NxWn32
