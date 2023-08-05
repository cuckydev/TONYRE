#ifndef __SPRITE_H
#define __SPRITE_H

#include <vector>

#include "texture.h"
#include "shader.h"

namespace NxWn32
{
	struct sVert2D
	{
		float x, y, z;
		float u, v;
		float r, g, b, a;
	};

	struct SDraw2D
	{
			SDraw2D( float pri = 0.0f, bool hide = true );
			virtual ~SDraw2D( void );

			void SetPriority( float pri );
			float GetPriority(void) const { return m_pri; }
			void SetZValue( float z );
			float GetZValue( void ) { return m_zvalue; }

			void SetHidden( bool hide );
			bool IsHidden(void) const { return m_hidden; }

			// members
			SDraw2D *mp_next;

			// Statics
			static void Init(void);

			static void DrawAll( void );

		private:
			void InsertDrawList( void );
			void RemoveDrawList( void );

			virtual void BeginDraw( void ) = 0;
			virtual void Draw( void ) = 0;
			virtual void EndDraw( void ) = 0;

			// Not even the derived classes should have direct access
			bool m_hidden;
			float m_pri;
			float m_zvalue;

			// 2D draw list (sorted by priority);
			static SDraw2D *sp_2D_draw_list;

			// Mesh and shader
			static sShader *sp_shader;
			static GlMesh *sp_mesh;

			// Render state
			static sTexture *sp_current_texture;
			// static std::vector<sVert2D> m_verts;
			// static std::vector<GLushort> m_indices;

			static void Submit(void);
	};


	struct sSprite : public SDraw2D
	{
		public:
			sSprite( float pri = 0.0f );
			~sSprite();

			sTexture		*mp_texture = nullptr;

			float			m_xpos;
			float			m_ypos;
			uint16			m_width;
			uint16			m_height;
			float			m_scale_x;
			float			m_scale_y;
			float			m_xhot;
			float			m_yhot;
			float			m_rot;
			uint32			m_rgba;

		private:
			void					BeginDraw();
			void					Draw();
			void					EndDraw(void);
	};


} // namespace NxWn32


#endif // __SPRITE_H
