#pragma once

#include "nx_init.h"

namespace NxWn32
{
	// FBO class
	class sFBO
	{
		private:
			// OpenGL FBO objects
			GLuint m_fbo = 0;
			GLuint m_color_texture = 0;
			GLuint m_depth_rbo = 0;

		public:
			// Constructor
			sFBO(unsigned int width, unsigned int height, bool has_z)
			{
				// Generate FBO
				glGenFramebuffers(1, &m_fbo);
				glBindFramebuffer(GL_FRAMEBUFFER, m_fbo);

				// Generate color texture
				glGenTextures(1, &m_color_texture);
				glBindTexture(GL_TEXTURE_2D, m_color_texture);

				// Set texture parameters
				glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_LINEAR);
				glTexParameteri(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_LINEAR);

				// Set texture data
				glTexImage2D(GL_TEXTURE_2D, 0, GL_RGB, width, height, 0, GL_RGB, GL_UNSIGNED_BYTE, nullptr);

				// Attach texture to FBO
				glFramebufferTexture2D(GL_FRAMEBUFFER, GL_COLOR_ATTACHMENT0, GL_TEXTURE_2D, m_color_texture, 0);

				// Generate depth buffer if needed
				if (has_z)
				{
					// Generate RBO
					glGenRenderbuffers(1, &m_depth_rbo);
					glBindRenderbuffer(GL_RENDERBUFFER, m_depth_rbo);

					// Set RBO storage
					glRenderbufferStorage(GL_RENDERBUFFER, GL_DEPTH_COMPONENT24, width, height);

					// Attach RBO to FBO
					glFramebufferRenderbuffer(GL_FRAMEBUFFER, GL_DEPTH_ATTACHMENT, GL_RENDERBUFFER, m_depth_rbo);
				}
			}

			// Destructor
			~sFBO()
			{
				glDeleteFramebuffers(1, &m_fbo);
				glDeleteTextures(1, &m_color_texture);
				glDeleteRenderbuffers(1, &m_depth_rbo);
			}

			// Bind FBO
			void BindFBO()
			{
				glBindFramebuffer(GL_FRAMEBUFFER, m_fbo);
			}

			// Bind color texture
			void BindColorTexture()
			{
				glBindTexture(GL_TEXTURE_2D, m_color_texture);
			}
	};
}
