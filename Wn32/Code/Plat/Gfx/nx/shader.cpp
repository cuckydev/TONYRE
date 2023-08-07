#include "shader.h"

namespace NxWn32
{
	// Shader compile
	static GLuint CompileSource(GLenum type, const char *src)
	{
		// Create shader
		GLuint shader = glCreateShader(type);

		// Compile source
		glShaderSource(shader, 1, &src, NULL);
		glCompileShader(shader);

		// Check for errors
		GLint status;
		glGetShaderiv(shader, GL_COMPILE_STATUS, &status);

		if (status != GL_TRUE)
		{
			char msg[512];
			glGetShaderInfoLog(shader, 512, nullptr, msg);
			Dbg_MsgAssert(status == GL_TRUE, (msg));
			return 0;
		}

		return shader;
	}

	sShader::sShader(const char *vertex, const char *fragment)
	{
		// Compile shaders
		GLuint vertex_shader = CompileSource(GL_VERTEX_SHADER, vertex);
		GLuint fragment_shader = CompileSource(GL_FRAGMENT_SHADER, fragment);

		// Create program
		program = glCreateProgram();

		// Attach shaders
		glAttachShader(program, vertex_shader);
		glAttachShader(program, fragment_shader);

		// Link program
		glLinkProgram(program);

		// Check for errors
		GLint status;
		glGetProgramiv(program, GL_LINK_STATUS, &status);

		if (status != GL_TRUE)
		{
			char msg[512];
			glGetProgramInfoLog(program, 512, nullptr, msg);
			Dbg_MsgAssert(status == GL_TRUE, (msg));
			return;
		}

		// Delete shaders
		glDeleteShader(vertex_shader);
		glDeleteShader(fragment_shader);
	}

	sShader::~sShader()
	{
		// Delete program
		glDeleteProgram(program);
	}
} // namespace NxWn32
