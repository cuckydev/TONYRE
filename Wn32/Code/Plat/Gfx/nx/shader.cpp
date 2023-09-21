#include "shader.h"

#include "render.h"
#include "material.h"

#include <string>
#include <unordered_set>

namespace NxWn32
{
	// Direct shaders
	static std::string direct_vertex = R"(#version 330 core
layout (location = 0) in vec4 i_pos;
layout (location = 1) in vec2 i_uv;

out vec2 f_uv;

void main()
{
	gl_Position = i_pos;
	f_uv = i_uv;
}
)";

	static std::string direct_fragment = R"(#version 330 core
in vec2 f_uv;

layout (location = 0) out vec4 o_col;

uniform sampler2D u_texture[4];

uniform vec4 u_col;

void main()
{
	o_col = texture(u_texture[0], f_uv) * u_col;
}
)";

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

	// 3D shader header
	static std::string shader_header = R"(#version 330 core
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

const uint vBLEND_MODE_DIFFUSE = 0u;
const uint vBLEND_MODE_ADD = 1u;
const uint vBLEND_MODE_ADD_FIXED = 2u;
const uint vBLEND_MODE_SUBTRACT = 3u;
const uint vBLEND_MODE_SUB_FIXED = 4u;
const uint vBLEND_MODE_BLEND = 5u;
const uint vBLEND_MODE_BLEND_FIXED = 6u;
const uint vBLEND_MODE_MODULATE = 7u;
const uint vBLEND_MODE_MODULATE_FIXED = 8u;
const uint vBLEND_MODE_BRIGHTEN = 9u;
const uint vBLEND_MODE_BRIGHTEN_FIXED = 10u;
const uint vBLEND_MODE_GLOSS_MAP = 11u;
const uint vBLEND_MODE_BLEND_PREVIOUS_MASK = 12u;
const uint vBLEND_MODE_BLEND_INVERSE_PREVIOUS_MASK = 13u;

uniform uint u_passes;
uniform uvec4 u_pass_flag;

uniform uint u_ignore_bf;

uniform mat4 u_env_mat[4];

	)";

	// 3D shaders
	static std::string basic_vertex = shader_header + R"(
layout (location = 0) in vec3 i_pos;
layout (location = 3) in vec3 i_nor;
layout (location = 4) in vec4 i_col;
layout (location = 5) in vec2 i_uv[4];

out vec2 f_uv[4];
out vec4 f_col;

uniform mat4 u_m;
uniform mat4 u_v;
uniform mat4 u_p;

void main()
{
	// Transform
	vec4 pos = (u_p * u_v * u_m) * vec4(i_pos, 1.0f);
	vec3 nor = (u_m * vec4(i_nor, 0.0f)).xyz;

	vec4 vpos = (u_v * u_m) * vec4(i_pos, 1.0f);
	vec3 vnor = (u_v * vec4(nor, 0.0f)).xyz;

	gl_Position = pos;

	// Pass pass information
	for (uint i = 0u; i < u_passes; i++)
	{
		uint flag = u_pass_flag[i];

		// Check if environment mapped
		if ((flag & MATFLAG_ENVIRONMENT) != 0u)
		{
			// Pass reflection vector
			// TODO: This is not correct
			f_uv[i] = (u_env_mat[i] * vec4(reflect(normalize(vpos.xyz), vnor), 1.0f)).xy;
		}
		else
		{
			// Pass texture coordinates
			f_uv[i] = i_uv[i];
		}
	}

	// Pass vertex color
	f_col = i_col;
}
	)";

	static std::string boned_vertex = shader_header + R"(
layout (location = 0) in vec3 i_pos;
layout (location = 1) in vec3 i_weight;
layout (location = 2) in uvec4 i_index;
layout (location = 3) in vec3 i_nor;
layout (location = 4) in vec4 i_col;
layout (location = 5) in vec2 i_uv[4];

out vec2 f_uv[4];
out vec4 f_col;

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
	vec4 pos = (u_p * u_v * u_m) * vec4(skin_pos, 1.0f);
	vec3 nor = (u_m * vec4(skin_nor, 0.0f)).xyz;
	vec3 vnor = (u_v * vec4(nor, 0.0f)).xyz;

	gl_Position = pos;

	// Pass pass information
	for (uint i = 0u; i < u_passes; i++)
	{
		uint flag = u_pass_flag[i];

		// Check if environment mapped
		if ((flag & MATFLAG_ENVIRONMENT) != 0u)
		{
			// Pass reflection vector
			// TODO: This is not correct
			f_uv[i] = (u_env_mat[i] * vec4(reflect(normalize(pos.xyz), vnor), 1.0f)).xy;
		}
		else
		{
			// Pass texture coordinates
			f_uv[i] = i_uv[i];
		}
	}

	// Pass vertex color
	f_col = i_col;
}
	)";

	static std::string basic_fragment = shader_header + R"(
in vec2 f_uv[4];
in vec4 f_col;

layout (location = 0) out vec4 o_col;

uniform sampler2D u_texture[4];

uniform uint u_blend[4];
uniform vec4 u_col[4];

void main()
{
	// Sample textures
	vec4 t[4];
	for (uint i = 0u; i < u_passes; i++)
	{
		if ((u_pass_flag[i] & MATFLAG_TEXTURED) != 0u)
		{
			if (i == 0u)
				t[i] = texture(u_texture[0], f_uv[i]);
			else if (i == 1u)
				t[i] = texture(u_texture[1], f_uv[i]);
			else if (i == 2u)
				t[i] = texture(u_texture[2], f_uv[i]);
			else if (i == 3u)
				t[i] = texture(u_texture[3], f_uv[i]);
		}
		else
		{
			t[i] = vec4(1.0f);
		}
	}

	// Accumulate first pass
	vec4 r0 = vec4(t[0].rgb * u_col[0].rgb, 0.0f);
	if ((u_pass_flag[0] & MATFLAG_PASS_IGNORE_VERTEX_ALPHA) != 0u)
		r0.a = t[0].a;
	else
		r0.a = t[0].a * f_col.a * 2.0f;

	r0.rgb *= f_col.rgb * 4.0f;

	// Accumulate remaining passes
	vec4 rl = r0;
	for (uint i = 1u; i < u_passes; i++)
	{
		uint flag = u_pass_flag[i];
		vec4 col = u_col[i];

		// Accumulate pass
		vec4 r = vec4(t[i].rgb * col.rgb, 0.0f);
		if ((flag & MATFLAG_PASS_IGNORE_VERTEX_ALPHA) != 0u)
			r.a = t[i].a;
		else
			r.a = t[i].a * f_col.a * 2.0f;
		
		r.rgb *= f_col.rgb * 4.0f;

		// Blend pass
		switch (u_blend[i])
		{
			case vBLEND_MODE_ADD:
				r0.rgb = r.rgb * r.a + r0.rgb;
				break;
			case vBLEND_MODE_ADD_FIXED:
				r0.rgb = r.rgb * col.a + r0.rgb;
				break;
			case vBLEND_MODE_SUBTRACT:
				r0.rgb = r.rgb * -r.a + r0.rgb;
				break;
			case vBLEND_MODE_SUB_FIXED:
				r0.rgb = r.rgb * -col.a + r0.rgb;
				break;
			case vBLEND_MODE_BLEND:
				r0.rgb = mix(r0.rgb, r.rgb, r.a);
				break;
			case vBLEND_MODE_BLEND_FIXED:
				r0.rgb = mix(r0.rgb, r.rgb, col.a);
				break;
			case vBLEND_MODE_MODULATE:
				r0.rgb = r0.rgb * r.a;
				break;
			case vBLEND_MODE_MODULATE_FIXED:
				r0.rgb = r0.rgb * col.a;
				break;
			case vBLEND_MODE_BRIGHTEN:
				r0.rgb = r0.rgb + r0.rgb * r.a;
				break;
			case vBLEND_MODE_BRIGHTEN_FIXED:
				r0.rgb = r0.rgb + r0.rgb * col.a;
				break;
			case vBLEND_MODE_BLEND_PREVIOUS_MASK:
				r0.rgb = mix(r0.rgb, r.rgb, rl.a);
				break;
			case vBLEND_MODE_BLEND_INVERSE_PREVIOUS_MASK:
				r0.rgb = mix(r.rgb, r0.rgb, rl.a);
				break;
			case vBLEND_MODE_GLOSS_MAP:
				break;
		}
		
		rl = r;
	}

	o_col = r0;
}
	)";

	// Shader compile
	static GLuint CompileSource(GLenum type, const char *src)
	{
		// Create shader
		GLuint shader = glCreateShader(type);

		// Compile source
		glShaderSource(shader, 1, &src, nullptr);
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
	sShader *DirectShader()
	{
		static sShader shader(direct_vertex.c_str(), direct_fragment.c_str());
		return &shader;
	}

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
