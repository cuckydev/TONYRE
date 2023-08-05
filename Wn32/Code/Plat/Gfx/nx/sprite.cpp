#include <string.h>
#include <core/defines.h>
#include <core/macros.h>
#include <core/debug.h>
#include <sys/config/config.h>
#include <sys/file/filesys.h>
#include "nx_init.h"
#include "scene.h"
#include "render.h"
#include "sprite.h"

namespace NxWn32
{

// Shaders
static const char *vertex_shader = R"(#version 330 core
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

static const char *fragment_shader = R"(#version 330 core
in vec2 f_uv;
in vec4 f_col;

layout(location = 0) out vec4 o_col;

uniform sampler2D u_texture_0;

void main()
{
	o_col = texture(u_texture_0, f_uv) * f_col;
}
)";

/******************************************************************/
/*                                                                */
/* SDraw2D														  */
/*                                                                */
/******************************************************************/

SDraw2D *SDraw2D::sp_2D_draw_list = nullptr;

sShader *SDraw2D::sp_shader = nullptr;
GlMesh *SDraw2D::sp_mesh = nullptr;

GLuint SDraw2D::sp_current_texture = 0;
std::vector<sVert2D> SDraw2D::m_verts;
std::vector<GLushort> SDraw2D::m_indices;

void SDraw2D::Submit(void)
{
	// Check if any data was pushed
	if (m_verts.empty())
		return;

	// Set blend
	glBlendFunc(GL_SRC_ALPHA, GL_ONE_MINUS_SRC_ALPHA);
	glEnable(GL_BLEND);

	// Send vertex and index data to GPU
	sp_mesh->Bind();
	glBufferData(GL_ARRAY_BUFFER, m_verts.size() * sizeof(sVert2D), m_verts.data(), GL_STATIC_DRAW);
	glBufferData(GL_ELEMENT_ARRAY_BUFFER, m_indices.size() * sizeof(GLushort), m_indices.data(), GL_STATIC_DRAW);

	// Draw
	glUseProgram(sp_shader->program);

	glBindTexture(GL_TEXTURE_2D, sp_current_texture);

	glDrawElements(GL_TRIANGLES, m_indices.size(), GL_UNSIGNED_SHORT, nullptr);

	// Clear buffers
	m_verts.clear();
	m_indices.clear();
}

void SDraw2D::Init(void)
{
	// Compile shader
	sp_shader = new sShader(vertex_shader, fragment_shader);
	sp_mesh = new GlMesh();

	// Set VAO layout
	sp_mesh->Bind();
	glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, sizeof(sVert2D), (void*)offsetof(sVert2D, x));
	glVertexAttribPointer(1, 2, GL_FLOAT, GL_FALSE, sizeof(sVert2D), (void*)offsetof(sVert2D, u));
	glVertexAttribPointer(2, 4, GL_FLOAT, GL_FALSE, sizeof(sVert2D), (void*)offsetof(sVert2D, r));
	glEnableVertexAttribArray(0);
	glEnableVertexAttribArray(1);
	glEnableVertexAttribArray(2);
}


/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
SDraw2D::SDraw2D( float pri, bool hide )
{
	m_hidden	= hide;
	m_pri		= pri;
	m_zvalue	= 0.0f;

	mp_next = nullptr;

	// add to draw list
	if( !m_hidden )
	{
		InsertDrawList();
	}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
SDraw2D::~SDraw2D()
{
	// Try removing from draw list
	RemoveDrawList();
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void SDraw2D::SetPriority( float pri )
{
	if( m_pri != pri )
	{
		m_pri = pri;

		// By removing and re-inserting, we re-sort the list
		if( !m_hidden )
		{
			RemoveDrawList();
			InsertDrawList();
		}
	}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void SDraw2D::SetZValue( float z )
{
	m_zvalue = z;

	if( z > 0.0f )
	{
		// Set the priority to zero so it will always draw before everything else.
		SetPriority( 0.0f );
	}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void SDraw2D::SetHidden( bool hide )
{
	if (m_hidden != hide)
	{
		m_hidden = hide;
		if (hide)
		{
			RemoveDrawList();
		} else {
			InsertDrawList();
		}
	}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void SDraw2D::DrawAll( void )
{
	// Draw all the 2D objects in the list
	SDraw2D *pDraw = sp_2D_draw_list;

	while (pDraw)
	{
		pDraw->BeginDraw();
		pDraw->Draw();
		pDraw->EndDraw();

		pDraw = pDraw->mp_next;
	}

	Submit();

	/*
	static uint32 z_test_required = 0;
	
	set_blend_mode( vBLEND_MODE_BLEND );
	set_render_state( RS_UVADDRESSMODE0, 0x00010001UL );
	set_render_state( RS_ZBIAS, 0 );

	// Set the alpha cutoff value.
	set_render_state( RS_ALPHACUTOFF, 1 );

	set_render_state( RS_ZWRITEENABLE,	0 );
	set_texture( 1, nullptr );
	set_texture( 2, nullptr );
	set_texture( 3, nullptr );

	if( EngineGlobals.color_sign[0] != ( D3DTSIGN_RUNSIGNED | D3DTSIGN_GUNSIGNED | D3DTSIGN_BUNSIGNED ))
	{
		EngineGlobals.color_sign[0] = ( D3DTSIGN_RUNSIGNED | D3DTSIGN_GUNSIGNED | D3DTSIGN_BUNSIGNED );
		D3DDevice_SetTextureStageState( 0, D3DTSS_COLORSIGN, D3DTSIGN_RUNSIGNED | D3DTSIGN_GUNSIGNED | D3DTSIGN_BUNSIGNED );
	}

	// Unfortunately, now that we have 3D text, we may need to enable the z test for some strings.
	set_render_state( RS_ZTESTENABLE,	z_test_required );

	SDraw2D *pDraw	= sp_2D_draw_list;
	uint32	z_test	= 0;

	while( pDraw )
	{
		if (!pDraw->m_hidden)
		{
			pDraw->BeginDraw();
			pDraw->Draw();
			pDraw->EndDraw();

			if(( z_test == 0 ) && ( pDraw->GetZValue() > 0.0f ))
			{
				// There is at least one peice of text with nonzero z, so we need to z test.
				z_test = 1;
			}
		}
		pDraw = pDraw->mp_next;
	}

	z_test_required = z_test;
	*/
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void SDraw2D::InsertDrawList( void )
{
	if (!sp_2D_draw_list || (m_pri <= sp_2D_draw_list->m_pri))
	{
		// Empty or start of list.
		mp_next = sp_2D_draw_list;
		sp_2D_draw_list	= this;
	}
	else
	{
		SDraw2D *p_cur = sp_2D_draw_list;
	
		// Find where to insert
		while (p_cur->mp_next)
		{
			if (m_pri <= p_cur->mp_next->m_pri)
				break;
			p_cur = p_cur->mp_next;
		}

		// Insert at this point.
		mp_next = p_cur->mp_next;
		p_cur->mp_next = this;
	}
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void SDraw2D::RemoveDrawList( void )
{
	// Take out from draw list
	if (sp_2D_draw_list == this)
	{
		sp_2D_draw_list = mp_next;
	} 
	else if (sp_2D_draw_list)
	{
		SDraw2D *p_cur = sp_2D_draw_list;

		while(p_cur->mp_next)
		{
			if (p_cur->mp_next == this)
			{
				p_cur->mp_next = mp_next;
				break;
			}

			p_cur = p_cur->mp_next;
		}
	}
}

/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
sSprite::sSprite( float pri ) : SDraw2D( pri, true )
{
	mp_texture = nullptr;
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
sSprite::~sSprite()
{
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void sSprite::BeginDraw( void )
{
	// Check if we need to change the render state
	if (mp_texture->GLTexture != SDraw2D::sp_current_texture)
	{
		Submit();
		SDraw2D::sp_current_texture = mp_texture->GLTexture;
	}

	/*
	set_vertex_shader( D3DFVF_XYZRHW | D3DFVF_DIFFUSE | D3DFVF_TEX1 | D3DFVF_TEXCOORDSIZE2( 0 ));

	if( mp_texture )
	{
		set_pixel_shader( PixelShader4 );
		set_texture( 0, mp_texture->pD3DTexture, mp_texture->pD3DPalette );
	}
	else
	{
		set_pixel_shader( PixelShader5 );
		set_texture( 0, nullptr );
	}
	*/
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void sSprite::Draw( void )
{
	// Get UVs
	float u0 = 0.0f;
	float v0 = 1.0f;
	float u1 = 1.0f;
	float v1 = 0.0f;

	// Get coordinates
	float x0 = -(m_xhot * m_scale_x);
	float y0 = -(m_yhot * m_scale_y);
	float x1 = x0 + (m_width * m_scale_x);
	float y1 = y0 + (m_height * m_scale_y);

	// Get color
	float r = ((m_rgba >> 0) & 0xFF) / 255.0f;
	float g = ((m_rgba >> 8) & 0xFF) / 255.0f;
	float b = ((m_rgba >> 16) & 0xFF) / 255.0f;
	float a = ((m_rgba >> 24) & 0xFF) / 255.0f;

	// r = g = b = a = 1.0f;

	// Get points
	Mth::Vector p0(x0, y0, 0.0f, 0.0f);
	Mth::Vector p1(x1, y0, 0.0f, 0.0f);
	Mth::Vector p2(x0, y1, 0.0f, 0.0f);
	Mth::Vector p3(x1, y1, 0.0f, 0.0f);

	p0.RotateZ(m_rot);
	p1.RotateZ(m_rot);
	p2.RotateZ(m_rot);
	p3.RotateZ(m_rot);

	p0[X] = SCREEN_CONV_X(p0[X] + m_xpos);
	p0[Y] = SCREEN_CONV_Y(p0[Y] + m_ypos);
	p1[X] = SCREEN_CONV_X(p1[X] + m_xpos);
	p1[Y] = SCREEN_CONV_Y(p1[Y] + m_ypos);
	p2[X] = SCREEN_CONV_X(p2[X] + m_xpos);
	p2[Y] = SCREEN_CONV_Y(p2[Y] + m_ypos);
	p3[X] = SCREEN_CONV_X(p3[X] + m_xpos);
	p3[Y] = SCREEN_CONV_Y(p3[Y] + m_ypos);

	// Push vertices
	size_t vi = m_verts.size();

	m_verts.push_back(sVert2D{
		p0[X], p0[Y], 0.0f,
		u0, v0,
		r, g, b, a
	});
	m_verts.push_back(sVert2D{
		p1[X], p1[Y], 0.0f,
		u1, v0,
		r, g, b, a
	});
	m_verts.push_back(sVert2D{
		p2[X], p2[Y], 0.0f,
		u0, v1,
		r, g, b, a
	});
	m_verts.push_back(sVert2D{
		p3[X], p3[Y], 0.0f,
		u1, v1,
		r, g, b, a
	});

	// Push indices
	m_indices.push_back(vi + 0);
	m_indices.push_back(vi + 1);
	m_indices.push_back(vi + 2);
	m_indices.push_back(vi + 2);
	m_indices.push_back(vi + 1);
	m_indices.push_back(vi + 3);
}



/******************************************************************/
/*                                                                */
/*                                                                */
/******************************************************************/
void sSprite::EndDraw( void )
{
	// Vertices have been submitted - nothing more to do.
}



} // namespace NxWn32

