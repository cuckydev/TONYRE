#include "shader.h"

#include <string>

namespace NxWn32
{
	// 2D shaders
	static std::string sprite_vertex = R"(#version 330 core
layout (location = 0) in vec3 i_pos;
layout (location = 1) in vec2 i_uv;
layout (location = 2) in vec4 i_col;

out vec2 f_uv;
out vec4 f_col;

void main()
{
	gl_Position = vec4(-1.0 + i_pos.x / 320.0, 1.0 - i_pos.y / 240.0, i_pos.z, 1.0);
	f_uv = i_uv;
	f_col = i_col;
}
)";

	static std::string sprite_fragment = R"(#version 330 core
in vec2 f_uv;
in vec4 f_col;

layout (location = 0) out vec4 o_col;

uniform sampler2D u_texture[4];

void main()
{
	o_col = texture(u_texture[0], f_uv) * f_col;
}
)";

	// 3D shaders
	static std::string basic_vertex = R"(#version 330 core
layout (location = 0) in vec3 i_pos;
layout (location = 3) in vec3 i_nor;
layout (location = 4) in vec4 i_col;
layout (location = 5) in vec2 i_uv[4];

out vec2 f_uv[4];
out vec4 f_col;

uniform vec3 u_col;

uniform mat4 u_m;
uniform mat4 u_v;
uniform mat4 u_p;

void main()
{
	// Transform
	gl_Position = (u_p * u_v * u_m) * vec4(i_pos, 1.0f);
	vec4 nor = u_m * vec4(i_nor, 0.0f);

	// Pass UV and color
	f_uv[0] = i_uv[0];
	f_uv[1] = i_uv[1];
	f_uv[2] = i_uv[2];
	f_uv[3] = i_uv[3];
	f_col = vec4((i_col.rgb * 2.0f) * u_col, i_col.a * 2.0f) * vec4(vec3(0.8f + dot(i_nor, vec3(1.0f, 1.0f, 0.0f)) * 0.2f), 1.0f);
}
	)";

	static std::string boned_vertex = R"(#version 330 core
layout (location = 0) in vec3 i_pos;
layout (location = 1) in vec3 i_weight;
layout (location = 2) in uvec4 i_index;
layout (location = 3) in vec3 i_nor;
layout (location = 4) in vec4 i_col;
layout (location = 5) in vec2 i_uv[4];

out vec2 f_uv[4];
out vec4 f_col;

uniform vec3 u_col;

uniform mat4 u_m;
uniform mat4 u_v;
uniform mat4 u_p;

uniform mat4 u_bone[55];

void main()
{
	// Get skinned position and normal
	vec3 skin_pos = vec3(0.0f);
	vec3 skin_nor = vec3(0.0f);

	for (int i = 0; i < 3; i++)
	{
		mat4 bone = u_bone[i_index[i]];
		float weight = i_weight[i];
		skin_pos += vec3(bone * vec4(i_pos, 1.0f)) * weight;
		skin_nor += vec3(bone * vec4(i_nor, 0.0f)) * weight;
	}

	// Transform
	gl_Position = (u_p * u_v * u_m) * vec4(skin_pos, 1.0f);
	skin_nor = (u_m * vec4(skin_nor, 0.0f)).xyz;

	// Pass UV and color
	f_uv[0] = i_uv[0];
	f_uv[1] = i_uv[1];
	f_uv[2] = i_uv[2];
	f_uv[3] = i_uv[3];
	f_col = vec4((i_col.rgb * 2.0f) * u_col, i_col.a * 2.0f) * vec4(vec3(0.675f + dot(skin_nor, vec3(0.707106f, 0.707106f, 0.0f)) * 0.325f), 1.0f);
}
	)";

	static std::string basic_fragment = R"(#version 330 core
const uint MATFLAG_UV_WIBBLE = (1u<<0u);
const uint MATFLAG_VC_WIBBLE = (1u<<1u);
const uint MATFLAG_TEXTURED = (1u<<2u);
const uint MATFLAG_ENVIRONMENT = (1u<<3u);
const uint MATFLAG_DECAL = (1u<<4u);
const uint MATFLAG_SMOOTH = (1u<<5u);
const uint MATFLAG_TRANSPARENT = (1u<<6u);
const uint MATFLAG_PASS_COLOR_LOCKED = (1u<<7u);
const uint MATFLAG_SPECULAR = (1u<<8u); // Specular lighting is enabled on this material (Pass0).
const uint MATFLAG_BUMP_SIGNED_TEXTURE = (1u<<9u); // This pass uses an offset texture which needs to be treated as signed data.
const uint MATFLAG_BUMP_LOAD_MATRIX = (1u<<10u); // This pass requires the bump mapping matrix elements to be set up.
const uint MATFLAG_PASS_TEXTURE_ANIMATES = (1u<<11u); // This pass has a texture which animates.
const uint MATFLAG_PASS_IGNORE_VERTEX_ALPHA = (1u<<12u); // This pass should not have the texel alpha modulated by the vertex alpha.
const uint MATFLAG_EXPLICIT_UV_WIBBLE = (1u<<14u); // Uses explicit uv wibble (set via script) rather than calculated.
const uint MATFLAG_WATER_EFFECT = (1u<<27u); // This material should be processed to provide the water effect.
const uint MATFLAG_NO_MAT_COL_MOD = (1u<<28u); // No material color modulation required (all passes have m.rgb = 0.5).

in vec2 f_uv[4];
in vec4 f_col;

layout (location = 0) out vec4 o_col;

uniform sampler2D u_texture[4];

uniform uint u_passes;

uniform uvec4 u_pass_flag;

void main()
{
	vec4 accum = vec4(0.0f);
	for (uint i = 0u; i < u_passes; i++)
	{
		uint flag = u_pass_flag[i];

		vec4 texel = f_col;
		if ((flag & MATFLAG_PASS_IGNORE_VERTEX_ALPHA) != 0u)
			texel.a = 1.0f;

		if ((flag & MATFLAG_TEXTURED) != 0u)
		{
			texel *= texture(u_texture[i], f_uv[i]);
		}
		
		accum += texel;
	}
	o_col = accum;
}
	)";

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

		// Set texture uniforms
		glUseProgram(program);
		for (int i = 0; i < 4; i++)
			glUniform1i(glGetUniformLocation(program, ("u_texture[" + std::to_string(i) + "]").c_str()), i);
	}

	sShader::~sShader()
	{
		// Delete program
		glDeleteProgram(program);
	}

	// Shader programs
	sShader *SpriteShader()
	{
		static sShader shader(sprite_vertex.c_str(), sprite_fragment.c_str());
		return &shader;
	}

	sShader *BasicShader()
	{
		static sShader shader(basic_vertex.c_str(), basic_fragment.c_str());
		return &shader;
	}

	sShader *BonedShader()
	{
		static sShader shader(boned_vertex.c_str(), basic_fragment.c_str());
		return &shader;
	}

} // namespace NxWn32
