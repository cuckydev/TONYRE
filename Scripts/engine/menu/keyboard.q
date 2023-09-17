
(keyboard_current_charset) = (alphanumeric_lower) 
(keyboard_text_scale) = PAIR(0.95, 0.55) 
(keyboard_button_scale) = PAIR(1, 1.6) 
(keyboard_caps_lock) = 0 
(keyboard_text_block_width) = 360 
SCRIPT (create_onscreen_keyboard) { (keyboard_title) = "KEYBOARD" 
		(keyboard_cancel_script) = (keyboard_cancel) 
		(pos) = PAIR(320, 240) 
		(max_length) = 20 
		(display_text) = "_" 
		(text) = "" 
		(display_text_scale) = 0.85000002384 
		(display_text_offset) = PAIR(0.00000000000, 0.00000000000) 
	} 
	(change) (keyboard_toggling_char_set) = 0 
	(FormatText) (ChecksumName) = (highlight_color) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(FormatText) (ChecksumName) = (unhighlight_color) "%i_UNHIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(destroy_onscreen_keyboard) 
	(SetScreenElementLock) (id) = (root_window) (off) 
	IF (GotParam) (no_buttons) 
		(CreateScreenElement) { 
			(type) = (ContainerElement) 
			(parent) = (root_window) 
			(id) = (keyboard_anchor) 
			(pos) = <pos> 
			(dims) = PAIR(640.00000000000, 480.00000000000) 
			(z_priority) = 15 
		} 
	ELSE 
		(CreateScreenElement) { 
			(type) = (ContainerElement) 
			(parent) = (root_window) 
			(id) = (keyboard_bg_anchor) 
			(pos) = <pos> 
			(dims) = PAIR(640.00000000000, 480.00000000000) 
		} 
		(CreateScreenElement) { 
			(type) = (ContainerElement) 
			(parent) = (keyboard_bg_anchor) 
			(id) = (keyboard_anchor) 
			(focusable_child) = (keyboard_vmenu) 
			(pos) = <pos> 
			(dims) = PAIR(640.00000000000, 480.00000000000) 
		} 
	ENDIF 
	(AssignAlias) (id) = (keyboard_anchor) (alias) = (current_menu_anchor) 
	IF (GotParam) (password) 
		(keyboard_anchor) : (SetTags) (password) 
	ENDIF 
	IF NOT (GotParam) (no_buttons) 
		IF (GotParam) (allow_cancel) 
			(create_helper_text) { (helper_text_elements) = [ 
					{ (text) = "\\bn=Cancel " } 
					{ (text) = "\\bm=Accept" } 
				] 
				(helper_pos) = <helper_pos> 
				(parent) = (keyboard_bg_anchor) 
			} 
		ELSE 
			(create_helper_text) { (helper_text_elements) = [ 
					{ (text) = "\\bm=Accept" } 
				] 
				(helper_pos) = <helper_pos> 
				(parent) = (keyboard_bg_anchor) 
			} 
		ENDIF 
	ENDIF 
	<org_text> = <text> 
	(FormatText) (TextName) = (text) "%s_" (s) = <text> 
	(SetScreenElementProps) { 
		(id) = (keyboard_anchor) 
		(event_handlers) = [ { (pad_choose) (keyboard_done) (params) = <...> } 
			{ (pad_back) (generic_menu_pad_back) (params) = { (callback) = <keyboard_cancel_script> <keyboard_cancel_params> } } 
		] 
	} 
	IF (GotParam) (no_buttons) 
		(keyboard_anchor) : (SetTags) (no_buttons) 
		(SetScreenElementProps) { 
			(id) = (keyboard_anchor) 
			(event_handlers) = [ { (pad_choose) (keyboard_done) (params) = <...> } 
				{ (pad_back) (generic_menu_pad_back) (params) = { (callback) = <keyboard_cancel_script> <keyboard_cancel_params> } } 
			] 
		} 
		(CreateScreenElement) { 
			(type) = (TextElement) 
			(parent) = (keyboard_anchor) 
			(font) = (testtitle) 
			(id) = (kb_no_button_hdr) 
			(text) = <display_text> 
			(pos) = PAIR(320.00000000000, 65.00000000000) 
			(just) = [ (center) (top) ] 
			(z_priority) = 15 
		} 
		IF (GotParam) (text_block) 
			(CreateScreenElement) { 
				(type) = (TextBlockElement) 
				(parent) = (keyboard_anchor) 
				(id) = (keyboard_display_string) 
				(allow_expansion) 
				(font) = (dialog) 
				(just) = [ (center) (top) ] 
				(text) = "_" 
				(internal_just) = [ (center) (center) ] 
				(not_focusable) 
				(pos) = PAIR(320.00000000000, 85.00000000000) 
				(dims) = ( PAIR(1.00000000000, 0.00000000000) * (keyboard_text_block_width) + PAIR(0.00000000000, 10.00000000000) ) 
			} 
		ELSE 
			(CreateScreenElement) { 
				(type) = (TextElement) 
				(parent) = (keyboard_anchor) 
				(id) = (keyboard_display_string) 
				(font) = (dialog) 
				(just) = [ (center) (top) ] 
				(text) = "_" 
				(not_focusable) 
				(pos) = PAIR(320.00000000000, 85.00000000000) 
			} 
		ENDIF 
		(printf) "*** 9" 
		IF (GotParam) (password) 
			(GetTextElementLength) (id) = (keyboard_display_string) 
			(SetScreenElementProps) (id) = (keyboard_display_string) (text) = "" 
			IF ( <length> > 1 ) 
				BEGIN 
					(TextElementConcatenate) (id) = (keyboard_display_string) "*" 
				REPEAT ( <length> -1 ) 
				(TextElementConcatenate) (id) = (keyboard_display_string) "_" 
			ENDIF 
		ENDIF 
		(CreateScreenElement) { 
			(type) = (TextBlockElement) 
			(parent) = (keyboard_anchor) 
			(id) = (keyboard_current_string) 
			(font) = (dialog) 
			(just) = [ (center) (top) ] 
			(text) = <org_text> 
			(not_focusable) 
			(pos) = PAIR(320.00000000000, 85.00000000000) 
			(dims) = ( PAIR(1.00000000000, 0.00000000000) * (keyboard_text_block_width) + PAIR(0.00000000000, 10.00000000000) ) 
			(allow_expansion) 
			(scale) = 0 
		} 
		IF (GotParam) (allowed_characters) 
			(keyboard_current_string) : (SetTags) (allowed_characters) = <allowed_characters> 
		ENDIF 
		IF (GotParam) (max_length) 
			IF ( <max_length> < 1 ) 
				(script_assert) "create_onscreen_keyboard called with bad max_length" 
			ENDIF 
			BEGIN 
				(GetTextElementLength) (id) = (keyboard_current_string) 
				IF ( <length> > <max_length> ) 
					(TextElementBackspace) (id) = (keyboard_current_string) 
					(TextElementBackspace) (id) = (keyboard_display_string) 
				ELSE 
					BREAK 
				ENDIF 
			REPEAT 
		ENDIF 
		(FireEvent) (type) = (focus) (target) = (keyboard_anchor) 
	ELSE 
		IF (GotParam) (text_block) 
			(theme_dialog_background) { (parent) = (keyboard_anchor) 
				(width) = 3.50000000000 
				(pos) = PAIR(320.00000000000, 163.00000000000) 
				(num_parts) = 2 
				(z_priority) = 1 
				(top_height) = 1 
				(no_icon) = (no_icon) 
			} 
		ELSE 
			(theme_dialog_background) { (parent) = (keyboard_anchor) 
				(width) = 3.50000000000 
				(pos) = PAIR(320.00000000000, 163.00000000000) 
				(num_parts) = 0 
				(z_priority) = 1 
				(top_height) = 1 
				(no_icon) = (no_icon) 
			} 
		ENDIF 
		IF NOT (GotParam) (no_buttons) 
			IF (LevelIs) (load_skateshop) 
				(build_top_and_bottom_blocks) (parent) = (keyboard_bg_anchor) (bot_z) = 10 
				IF (GotParam) (in_ss) 
					(make_mainmenu_3d_plane) { 
						(parent) = (keyboard_bg_anchor) 
						(model) = "mainmenu_bg\\mainmenu_bg.mdl" 
						(scale) = PAIR(1.25000000000, 1.25000000000) 
						(pos) = PAIR(360.00000000000, 217.00000000000) 
					} 
					(CreateScreenElement) { 
						(type) = (SpriteElement) 
						(parent) = (keyboard_bg_anchor) 
						(id) = (mm_building) 
						(texture) = (ss_sidewall) 
						(just) = [ (center) (center) ] 
						(scale) = PAIR(2.00000000000, 1.79999995232) 
						(pos) = PAIR(-40.00000000000, 195.00000000000) 
						(z_priority) = -3 
						(alpha) = 1 
					} 
					(make_mainmenu_clouds) (parent) = (keyboard_bg_anchor) 
				ELSE 
					(make_mainmenu_3d_plane) (parent) = (keyboard_bg_anchor) 
					IF (GotParam) (in_net_lobby) 
						IF NOT (ScreenElementExists) (id) = (globe) 
							(CreateScreenElement) { 
								(type) = (SpriteElement) 
								(parent) = (keyboard_bg_anchor) 
								(id) = (globe) 
								(texture) = (globe) 
								(scale) = 1 
								(pos) = PAIR(550.00000000000, 240.00000000000) 
								(just) = [ (center) (center) ] 
								(alpha) = 0.20000000298 
								(z_priority) = -1 
							} 
							(RunScriptOnScreenElement) (id) = (globe) (rotate_internet_options_globe) 
						ENDIF 
					ENDIF 
					IF (GotParam) (in_profile_options) 
						(CreateScreenElement) { 
							(type) = (SpriteElement) 
							(parent) = (keyboard_bg_anchor) 
							(id) = (globe) 
							(texture) = (globe) 
							(scale) = 1.29999995232 
							(pos) = PAIR(320.00000000000, 560.00000000000) 
							(just) = [ (center) (center) ] 
							(alpha) = 0.30000001192 
							(z_priority) = -1 
						} 
						(RunScriptOnScreenElement) (id) = (globe) (rotate_internet_options_globe) 
					ENDIF 
				ENDIF 
			ELSE 
				(pause_menu_gradient) (on) 
			ENDIF 
		ENDIF 
		IF ( <keyboard_title> = "ENTER CHEAT" ) 
			(FormatText) (ChecksumName) = (title_icon) "%i_cheats" (i) = ( (THEME_PREFIXES) [ (current_theme_prefix) ] ) (parent) = (keyboard_bg_anchor) 
		ELSE 
			IF ( <keyboard_title> = "ENTER MESSAGE" ) 
				(FormatText) (ChecksumName) = (title_icon) "%i_name_cat" (i) = ( (THEME_PREFIXES) [ (current_theme_prefix) ] ) (parent) = (keyboard_bg_anchor) 
			ELSE 
				(FormatText) (ChecksumName) = (title_icon) "%i_options" (i) = ( (THEME_PREFIXES) [ (current_theme_prefix) ] ) (parent) = (keyboard_bg_anchor) 
			ENDIF 
		ENDIF 
		(build_theme_sub_title) (title) = <keyboard_title> (title_icon) = <title_icon> (parent) = (keyboard_bg_anchor) 
		IF NOT (LevelIs) (load_skateshop) 
			(FormatText) (ChecksumName) = (paused_icon) "%i_paused_icon" (i) = ( (THEME_PREFIXES) [ (current_theme_prefix) ] ) 
			(build_theme_box_icons) (icon_texture) = <paused_icon> (parent) = (keyboard_bg_anchor) 
			(build_grunge_piece) (parent) = (keyboard_bg_anchor) 
			(build_top_bar) (pos) = PAIR(0.00000000000, 62.00000000000) (parent) = (keyboard_bg_anchor) 
		ENDIF 
		IF (GotParam) (text_block) 
			(CreateScreenElement) { 
				(type) = (VMenu) 
				(parent) = (keyboard_anchor) 
				(id) = (keyboard_vmenu) 
				(pos) = PAIR(320.00000000000, 197.00000000000) 
				(internal_just) = [ (center) (top) ] 
				(regular_space_amount) = 30 
				(event_handlers) = [ 
					{ (pad_up) (keyboard_change_key_sound) } 
					{ (pad_down) (keyboard_change_key_sound) } 
				] 
			} 
			IF NOT (GotParam) (no_back) 
				(SetScreenElementProps) { 
					(id) = (keyboard_vmenu) 
					(event_handlers) = [ 
						{ (pad_back) (generic_menu_pad_back) (params) = { (callback) = <keyboard_cancel_script> <keyboard_cancel_params> } } 
					] 
				} 
			ELSE 
				(kill_start_key_binding) 
			ENDIF 
		ELSE 
			(CreateScreenElement) { 
				(type) = (VMenu) 
				(parent) = (keyboard_anchor) 
				(id) = (keyboard_vmenu) 
				(pos) = PAIR(320.00000000000, 197.00000000000) 
				(internal_just) = [ (center) (top) ] 
				(regular_space_amount) = 30 
				(event_handlers) = [ 
					{ (pad_up) (keyboard_change_key_sound) } 
					{ (pad_down) (keyboard_change_key_sound) } 
				] 
			} 
			IF NOT (GotParam) (no_back) 
				(SetScreenElementProps) { 
					(id) = (keyboard_vmenu) 
					(event_handlers) = [ 
						{ (pad_back) (generic_menu_pad_back) (params) = { (callback) = <keyboard_cancel_script> <keyboard_cancel_params> } } 
					] 
				} 
			ELSE 
				(kill_start_key_binding) 
			ENDIF 
		ENDIF 
		IF NOT (GotParam) (no_back) 
			(SetScreenElementProps) { 
				(id) = (keyboard_vmenu) 
				(event_handlers) = [ 
					{ (pad_back) (generic_menu_pad_back) (params) = { (callback) = <keyboard_cancel_script> <keyboard_cancel_params> } } 
				] 
			} 
		ELSE 
			(kill_start_key_binding) 
		ENDIF 
		IF (GotParam) (text_block) 
			(keyboard_anchor) : (SetTags) (text_block) 
			(CreateScreenElement) { 
				(type) = (ContainerElement) 
				(parent) = (keyboard_vmenu) 
				(internal_just) = [ (center) (center) ] 
				(dims) = PAIR(10.00000000000, 20.00000000000) 
				(not_focusable) 
			} 
			(CreateScreenElement) { 
				(type) = (TextBlockElement) 
				(parent) = (keyboard_anchor) 
				(id) = (keyboard_display_string) 
				(font) = (dialog) 
				(just) = [ (center) (top) ] 
				(internal_just) = [ (left) (center) ] 
				(text) = <text> 
				(not_focusable) 
				(pos) = PAIR(320.00000000000, 197.00000000000) 
				(dims) = ( PAIR(1.00000000000, 0.00000000000) * (keyboard_text_block_width) + PAIR(20.00000000000, 400.00000000000) ) 
				(allow_expansion) 
				(line_spacing) = 0.86000001431 
				(scale) = 0.85000002384 
				(rgba) = <unhighlight_color> 
			} 
		ELSE 
			(CreateScreenElement) { 
				(type) = (ContainerElement) 
				(parent) = (keyboard_vmenu) 
				(id) = (keyboard_display_string_container) 
				(dims) = PAIR(10.00000000000, 20.00000000000) 
				(not_focusable) 
			} 
			(CreateScreenElement) { 
				(type) = (TextElement) 
				(parent) = <id> 
				(id) = (keyboard_display_string) 
				(pos) = ( PAIR(-139.00000000000, 7.00000000000) + <display_text_offset> ) 
				(font) = (dialog) 
				(just) = [ (left) (top) ] 
				(text) = <text> 
				(scale) = <display_text_scale> 
				(not_focusable) 
				(rgba) = <unhighlight_color> 
			} 
		ENDIF 
		IF (GotParam) (password) 
			(GetTextElementLength) (id) = (keyboard_display_string) 
			(SetScreenElementProps) (id) = (keyboard_display_string) (text) = "" 
			IF ( <length> > 1 ) 
				BEGIN 
					(TextElementConcatenate) (id) = (keyboard_display_string) "*" 
				REPEAT ( <length> -1 ) 
				(TextElementConcatenate) (id) = (keyboard_display_string) "_" 
			ENDIF 
		ENDIF 
		IF (GotParam) (text_block) 
			(CreateScreenElement) { 
				(type) = (TextBlockElement) 
				(parent) = (keyboard_anchor) 
				(id) = (keyboard_current_string) 
				(font) = (dialog) 
				(just) = [ (center) (top) ] 
				(text) = <org_text> 
				(not_focusable) 
				(pos) = PAIR(320.00000000000, 85.00000000000) 
				(dims) = ( PAIR(1.00000000000, 0.00000000000) * (keyboard_text_block_width) + PAIR(0.00000000000, 20.00000000000) ) 
				(allow_expansion) 
				(scale) = 0 
			} 
		ELSE 
			(CreateScreenElement) { 
				(type) = (TextElement) 
				(parent) = (keyboard_anchor) 
				(id) = (keyboard_current_string) 
				(font) = (dialog) 
				(just) = [ (center) (top) ] 
				(text) = <org_text> 
				(not_focusable) 
				(pos) = PAIR(320.00000000000, 85.00000000000) 
				(scale) = 0 
			} 
		ENDIF 
		IF (GotParam) (allowed_characters) 
			(keyboard_current_string) : (SetTags) (allowed_characters) = <allowed_characters> 
		ENDIF 
		IF (GotParam) (max_length) 
			IF ( <max_length> < 1 ) 
				(script_assert) "create_onscreen_keyboard called with bad max_length" 
			ENDIF 
			BEGIN 
				(GetTextElementLength) (id) = (keyboard_current_string) 
				IF ( <length> > <max_length> ) 
					(TextElementBackspace) (id) = (keyboard_current_string) 
					(TextElementBackspace) (id) = (keyboard_display_string) 
				ELSE 
					BREAK 
				ENDIF 
			REPEAT 
		ENDIF 
		(CreateScreenElement) { 
			(type) = (SpriteElement) 
			(parent) = (keyboard_anchor) 
			(id) = (keyboard_options_bg) 
			(texture) = (options_bg) 
			(scale) = PAIR(1.00000000000, 1.00000000000) 
			(rgba) = [ 0 0 0 0 ] 
			(just) = [ (center) (center) ] 
			(pos) = PAIR(267.00000000000, 80.00000000000) 
		} 
		(change) (keyboard_current_charset) = (alphanumeric_lower) 
		(FireEvent) (type) = (focus) (target) = (keyboard_vmenu) 
		(DoScreenElementMorph) (id) = (keyboard_anchor) (pos) = PAIR(320.00000000000, 600.00000000000) 
		(DoScreenElementMorph) (id) = (keyboard_anchor) (pos) = PAIR(320.00000000000, 240.00000000000) (time) = 0.30000001192 
	ENDIF 
	IF NOT (GotParam) (no_buttons) 
		(AssignAlias) (id) = (keyboard_bg_anchor) (alias) = (current_menu_anchor) 
	ENDIF 
	(StartKeyboardHandler) (max_length) = <max_length> 
ENDSCRIPT

SCRIPT (keyboard_character_set_guide) 
	(CreateScreenElement) { 
		(type) = (ContainerElement) 
		(parent) = (keyboard_vmenu) 
		(id) = (char_guide_anchor) 
		(not_focusable) 
	} 
	(guide_box_rgba) = [ 35 35 35 80 ] 
	(FormatText) (ChecksumName) = (highlight_color) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(FormatText) (ChecksumName) = (unhighlight_color) "%i_UNHIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (char_guide_anchor) 
		(id) = (char_guide_l2) 
		(font) = (dialog) 
		(rgba) = [ 128 128 128 100 ] 
		(just) = [ (left) (top) ] 
		(text) = #"\\mf" 
		(not_focusable) 
		(pos) = PAIR(-160.00000000000, -6.00000000000) 
		(scale) = PAIR(0.69999998808, 0.80000001192) 
		(z_priority) = 5 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (char_guide_anchor) 
		(id) = (char_guide_left_arrow) 
		(texture) = (left_arrow) 
		(scale) = PAIR(0.75000000000, 0.64999997616) 
		(rgba) = <highlight_color> 
		(just) = [ (left) (top) ] 
		(pos) = PAIR(-140.00000000000, -4.00000000000) 
		(z_priority) = 5 
	} 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (char_guide_anchor) 
		(id) = (char_guide_symbols) 
		(font) = (small) 
		(rgba) = <unhighlight_color> 
		(just) = [ (left) (top) ] 
		(text) = #"SYMBOLS" 
		(not_focusable) 
		(pos) = PAIR(-127.00000000000, -3.00000000000) 
		(scale) = 0.77999997139 
		(z_priority) = 5 
	} 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (char_guide_anchor) 
		(id) = (char_guide_allcaps) 
		(font) = (small) 
		(rgba) = <unhighlight_color> 
		(just) = [ (left) (top) ] 
		(text) = #" ALL-CAPS" 
		(not_focusable) 
		(pos) = PAIR(-62.00000000000, -3.00000000000) 
		(scale) = 0.77999997139 
		(z_priority) = 5 
	} 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (char_guide_anchor) 
		(id) = (char_guide_lower) 
		(font) = (small) 
		(rgba) = <highlight_color> 
		(just) = [ (left) (top) ] 
		(text) = #"  LOWER" 
		(not_focusable) 
		(pos) = PAIR(5.00000000000, -3.00000000000) 
		(scale) = 0.77999997139 
		(z_priority) = 5 
	} 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (char_guide_anchor) 
		(id) = (char_guide_foreign) 
		(font) = (small) 
		(rgba) = <unhighlight_color> 
		(just) = [ (left) (top) ] 
		(text) = #"FOREIGN" 
		(not_focusable) 
		(pos) = PAIR(72.00000000000, -3.00000000000) 
		(scale) = 0.77999997139 
		(z_priority) = 5 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (char_guide_anchor) 
		(id) = (char_guide_right_arrow) 
		(texture) = (right_arrow) 
		(scale) = PAIR(0.75000000000, 0.64999997616) 
		(rgba) = <highlight_color> 
		(just) = [ (left) (top) ] 
		(pos) = PAIR(130.00000000000, -4.00000000000) 
		(z_priority) = 5 
	} 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (char_guide_anchor) 
		(id) = (char_guide_r2) 
		(font) = (dialog) 
		(rgba) = [ 128 128 128 100 ] 
		(just) = [ (left) (top) ] 
		(text) = #"\\mg" 
		(not_focusable) 
		(pos) = PAIR(140.00000000000, -6.00000000000) 
		(scale) = PAIR(0.69999998808, 0.80000001192) 
		(z_priority) = 5 
	} 
ENDSCRIPT

SCRIPT (keyboard_create_key_sprites) 
	(keyboard_add_hmenu) (id) = (keyboard_row_1) 
	(keyboard_add_hmenu) (id) = (keyboard_row_2) 
	(keyboard_add_hmenu) (id) = (keyboard_row_3) 
	(keyboard_add_hmenu) (id) = (keyboard_row_4) 
	(keyboard_add_hmenu) (id) = (keyboard_row_5) 
	(keyboard_add_hmenu) (id) = (keyboard_row_6) 
	(keyboard_add_generic_buttons_to_hmenu) (hmenu_id) = (keyboard_row_1) (number_of_buttons) = 10 
	(keyboard_add_generic_buttons_to_hmenu) (hmenu_id) = (keyboard_row_2) (number_of_buttons) = 10 
	(keyboard_add_generic_buttons_to_hmenu) (hmenu_id) = (keyboard_row_3) (number_of_buttons) = 10 
	(keyboard_add_generic_buttons_to_hmenu) (hmenu_id) = (keyboard_row_4) (number_of_buttons) = 6 
	(keyboard_add_special_button) { 
		(hmenu_id) = (keyboard_row_4) 
		(pad_choose_script) = (keyboard_handle_backspace) 
		(text) = "Backspace" 
		(pad_button_text) = "\\m9" 
		(text_pos) = PAIR(124.00000000000, 8.00000000000) 
		(pad_button_pos) = PAIR(25.00000000000, 8.00000000000) 
		(text_scale) = PAIR(0.85000002384, 0.55000001192) 
		(width) = 128 
		(grid_x) = 6 
	} 
	(keyboard_add_special_button) { 
		(hmenu_id) = (keyboard_row_5) 
		(pad_choose_script) = (keyboard_handle_shift) 
		(pad_choose_params) = { (max_length) = <max_length> } 
		(text) = "Shift" 
		(text_id) = (shift_text) 
		(text_pos) = PAIR(47.00000000000, 2.00000000000) 
		(width) = 96 
		(grid_x) = 0 
	} 
	(keyboard_add_special_button) { 
		(hmenu_id) = (keyboard_row_5) 
		(pad_choose_script) = (keyboard_handle_caps) 
		(pad_choose_params) = { (max_length) = <max_length> } 
		(text) = "Caps Lk" 
		(text_id) = (caps_lock_text) 
		(text_pos) = PAIR(47.00000000000, 2.00000000000) 
		(text_scale) = PAIR(0.94999998808, 0.55000001192) 
		(width) = 96 
		(grid_x) = 3 
	} 
	(keyboard_add_special_button) { 
		(hmenu_id) = (keyboard_row_5) 
		(pad_choose_script) = (keyboard_handle_space) 
		(pad_choose_params) = { (max_length) = <max_length> } 
		(text) = "Space" 
		(pad_button_text) = "\\m8" 
		(text_pos) = PAIR(95.00000000000, 8.00000000000) 
		(pad_button_pos) = PAIR(40.00000000000, 8.00000000000) 
		(width) = 128 
		(grid_x) = 6 
	} 
	(keyboard_add_special_button) { 
		(hmenu_id) = (keyboard_row_6) 
		(pad_choose_script) = (keyboard_done) (pad_choose_params) = <...> 
		(button_id) = (keyboard_done_button) 
		(text) = "Done" 
		(text_pos) = PAIR(62.00000000000, 2.00000000000) 
		(width) = 128 
		(grid_x) = 0 
	} 
	IF (GotParam) (allow_cancel) 
		(SetScreenElementProps) { 
			(id) = (keyboard_vmenu) 
			(event_handlers) = [ { (pad_back) (generic_menu_pad_back) (params) = { (callback) = <keyboard_cancel_script> <keyboard_cancel_params> } } ] 
			(replace_handlers) 
		} 
		(keyboard_add_special_button) { 
			(hmenu_id) = (keyboard_row_6) 
			(pad_choose_script) = (generic_menu_pad_back) (params) <keyboard_cancel_script> 
			(pad_choose_params) = { (callback) = <keyboard_cancel_script> <keyboard_cancel_params> } 
			(text) = "Cancel" 
			(pad_button_text) = "\\m1" 
			(text_pos) = PAIR(106.00000000000, 8.00000000000) 
			(pad_button_pos) = PAIR(37.00000000000, 8.00000000000) 
			(width) = 128 
			(grid_x) = 6 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT (keyboard_change_charset) 
	BEGIN 
		IF (GetNextArrayElement) <charset> (index) = <index> 
			(keyboard_change_key_row) (row) = <element> (row_number) = <index> (max_length) = <max_length> 
		ELSE 
			BREAK 
		ENDIF 
	REPEAT 
ENDSCRIPT

SCRIPT (keyboard_change_key_row) 
	(FormatText) (ChecksumName) = (hmenu_id) "keyboard_row_%i" (i) = ( <row_number> + 1 ) 
	BEGIN 
		IF (GetNextArrayElement) <row> (index) = <index> 
			(SetScreenElementProps) { 
				(id) = { <hmenu_id> (child) = { <index> (child) = 0 } } 
				(text) = <element> 
				(replace_handlers) 
			} 
			(SetScreenElementProps) { 
				(id) = { <hmenu_id> (child) = <index> } 
				(tags) = { (tag_grid_x) = <index> } 
			} 
			(keyboard_set_button_events) { 
				(hmenu_id) = <hmenu_id> 
				(index) = <index> 
				(text) = <element> 
				(max_length) = <max_length> 
			} 
		ELSE 
			BREAK 
		ENDIF 
	REPEAT 
ENDSCRIPT

SCRIPT (destroy_onscreen_keyboard) 
	(KillSpawnedScript) (name) = (keyboard_key_focus) 
	IF (ObjectExists) (id) = (keyboard_anchor) 
		(DestroyScreenElement) (id) = (keyboard_anchor) 
	ENDIF 
	IF (ObjectExists) (id) = (keyboard_bg_anchor) 
		(DestroyScreenElement) (id) = (keyboard_bg_anchor) 
	ENDIF 
	(StopKeyboardHandler) 
	(change) (keyboard_caps_lock) = 0 
	(RemoveTextureFromVram) "generic_key" (no_assert) 
	(RemoveTextureFromVram) "key_left" (no_assert) 
	(RemoveTextureFromVram) "key_middle" (no_assert) 
	(RemoveTextureFromVram) "key_right" (no_assert) 
	(RemoveTextureFromVram) "PA_fonts" (no_assert) 
	(RemoveTextureFromVram) "goal_right" (no_assert) 
	(RemoveTextureFromVram) "goal_left" (no_assert) 
	(RemoveTextureFromVram) "right_arrow" (no_assert) 
	(RemoveTextureFromVram) "left_arrow" (no_assert) 
ENDSCRIPT

SCRIPT (keyboard_add_hmenu) 
	(CreateScreenElement) { 
		(type) = (Hmenu) 
		(parent) = (keyboard_vmenu) 
		(id) = <id> 
		(internal_just) = [ (left) (center) ] 
		(event_handlers) = [ { (pad_left) (keyboard_change_key_sound) } 
			{ (pad_right) (keyboard_change_key_sound) } 
		] 
	} 
ENDSCRIPT

SCRIPT (keyboard_add_generic_buttons_to_hmenu) 
	(FormatText) (ChecksumName) = (button_rgba) "%i_KEY_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	BEGIN 
		(CreateScreenElement) { 
			(type) = (SpriteElement) 
			(parent) = <hmenu_id> 
			(rgba) = <button_rgba> 
			(texture) = (generic_key) 
			(scale) = (keyboard_button_scale) 
		} 
		(keyboard_create_dummy_text) (id) = <id> 
	REPEAT <number_of_buttons> 
ENDSCRIPT

SCRIPT (keyboard_set_button_events) 
	IF (GotParam) (id) 
		IF (ObjectExists) (id) = <id> 
			(SetScreenElementProps) { 
				(id) = <id> 
				(event_handlers) = [ { (focus) (keyboard_button_focus) } 
					{ (unfocus) (keyboard_button_unfocus) } 
					{ (pad_choose) (keyboard_button_pressed) (params) = { (text) = <text> (max_length) = <max_length> } } 
					{ (pad_start) (keyboard_button_pressed) (params) = { (text) = <text> (max_length) = <max_length> } } 
				] 
				(replace_handlers) 
			} 
		ENDIF 
	ELSE 
		IF (ObjectExists) (id) = <hmenu_id> 
			IF (ObjectExists) (id) = { <hmenu_id> (child) = <index> } 
				(SetScreenElementProps) { 
					(id) = { <hmenu_id> (child) = <index> } 
					(event_handlers) = [ { (focus) (keyboard_button_focus) } 
						{ (unfocus) (keyboard_button_unfocus) } 
						{ (pad_choose) (keyboard_button_pressed) (params) = { (text) = <text> (max_length) = <max_length> } } 
						{ (pad_start) (keyboard_button_pressed) (params) = { (text) = <text> (max_length) = <max_length> } } 
					] 
					(replace_handlers) 
				} 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT (keyboard_create_dummy_text) 
	(FormatText) (ChecksumName) = (unhighlight_color) "%i_UNHIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = <id> 
		(rgba) = <unhighlight_color> 
		(just) = [ (center) (center) ] 
		(pos) = PAIR(17.00000000000, 8.00000000000) 
		(scale) = (keyboard_text_scale) 
		(event_handlers) = [ { (focus) (keyboard_text_focus) } 
			{ (unfocus) (keyboard_text_unfocus) } 
		] 
		(font) = (dialog) 
	} 
ENDSCRIPT

SCRIPT (keyboard_add_special_button) { (text_pos) = PAIR(121.00000000000, 8.00000000000) 
		(text_scale) = (keyboard_text_scale) 
		(pad_button_pos) = PAIR(33.00000000000, 8.00000000000) 
		(button_scale) = (keyboard_button_scale) 
		(width) = 32 
	} 
	(FormatText) (ChecksumName) = (button_rgba) "%i_KEY_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(CreateScreenElement) { 
		(type) = (ContainerElement) 
		(id) = <button_id> 
		(parent) = <hmenu_id> 
		(tags) = { (tag_grid_x) = <grid_x> (tag_txt_offset) = ( 2 + ( <width> - 16 ) / 4 ) } 
		(dims) = ( PAIR(1.00000000000, 0.00000000000) * <width> + PAIR(0.00000000000, 35.00000000000) ) 
		(internal_just) = [ (center) (center) ] 
	} 
	<parent_id> = <id> 
	<root_pos> = PAIR(5.00000000000, 18.00000000000) 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = <parent_id> 
		(scale) = <button_scale> 
		(texture) = (key_left) 
		(rgba) = <button_rgba> 
		(pos) = <root_pos> 
	} 
	<button_id> = <id> 
	<iterations> = ( ( <width> - 16 ) / 4 ) 
	<dx> = 4 
	BEGIN 
		(CreateScreenElement) { 
			(type) = (SpriteElement) 
			(parent) = <parent_id> 
			(texture) = (key_middle) 
			(scale) = ( (keyboard_button_scale) + PAIR(0.10000000149, 0.00000000000) ) 
			(rgba) = <button_rgba> 
			(pos) = ( PAIR(1.00000000000, 0.00000000000) * <dx> + <root_pos> ) 
			(not_focusable) 
		} 
		<dx> = ( <dx> + 4 ) 
	REPEAT <iterations> 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = <parent_id> 
		(scale) = <button_scale> 
		(texture) = (key_right) 
		(rgba) = <button_rgba> 
		(not_focusable) 
		(pos) = ( PAIR(1.00000000000, 0.00000000000) * <dx> + <root_pos> ) 
	} 
	IF ( ( <text> = "space" ) | ( <text> = "backspace" ) ) 
		(SetScreenElementProps) { 
			(id) = <parent_id> 
			(event_handlers) = [ { (focus) (keyboard_button_focus) } 
				{ (unfocus) (keyboard_button_unfocus) } 
				{ (pad_choose) <pad_choose_script> (params) = <pad_choose_params> } 
				{ (pad_start) <pad_choose_script> (params) = <pad_choose_params> } 
			] 
			(replace_handlers) 
		} 
	ELSE 
		(SetScreenElementProps) { 
			(id) = <parent_id> 
			(event_handlers) = [ { (focus) (keyboard_button_focus) } 
				{ (unfocus) (keyboard_button_unfocus) } 
				{ (pad_choose) (generic_keyboard_sound) } 
				{ (pad_start) (generic_keyboard_sound) } 
				{ (pad_choose) <pad_choose_script> (params) = <pad_choose_params> } 
				{ (pad_start) <pad_choose_script> (params) = <pad_choose_params> } 
			] 
			(replace_handlers) 
		} 
	ENDIF 
	IF (GotParam) (pad_button_text) 
		(CreateScreenElement) { 
			(type) = (TextElement) 
			(parent) = <parent_id> 
			(z_priority) = 10 
			(scale) = ( <text_scale> + PAIR(0.00000000000, 0.20000000298) ) 
			(font) = (small) 
			(text) = <pad_button_text> 
			(pos) = ( <pad_button_pos> + PAIR(0.00000000000, 10.00000000000) ) 
			(just) = [ (right) (center) ] 
		} 
	ENDIF 
	IF (GotParam) (pad_button_text) 
		(GetStackedScreenElementPos) (X) (id) = <id> (offset) = PAIR(3.00000000000, 0.00000000000) 
		<text_pos> = <pos> 
		<text_just> = [ (left) (top) ] 
	ELSE 
		(GetScreenElementPosition) (id) = <button_id> 
		<text_pos> = ( <text_pos> + PAIR(0.00000000000, 8.00000000000) ) 
		<text_just> = [ (center) (top) ] 
	ENDIF 
	(FormatText) (ChecksumName) = (unhighlight_color) "%i_UNHIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = <parent_id> 
		(z_priority) = 10 
		(font) = (dialog) 
		(id) = <text_id> 
		(text) = <text> 
		(pos) = <text_pos> 
		(scale) = ( <text_scale> + PAIR(0.00000000000, 0.20000000298) ) 
		(just) = <text_just> 
		(rgba) = <unhighlight_color> 
		(event_handlers) = [ { (focus) (keyboard_text_focus) } 
			{ (unfocus) (keyboard_text_unfocus) } 
		] 
	} 
ENDSCRIPT

SCRIPT (keyboard_button_focus) 
	(GetTags) 
	<txt_offset> = 0 
	IF (GotParam) (tag_txt_offset) 
		<txt_offset> = <tag_txt_offset> 
	ENDIF 
	IF (ScreenElementExists) (id) = { <id> (child) = ( <txt_offset> + 1 ) } 
		(RunScriptOnScreenElement) (id) = { <id> (child) = ( <txt_offset> + 1 ) } (keyboard_text_focus) 
		(SpawnScript) (keyboard_key_focus) (params) = { (id) = <id> (org_scale) = PAIR(1.00000000000, 1.04999995232) } 
	ELSE 
		IF (GotParam) (tag_txt_offset) 
			(RunScriptOnScreenElement) (id) = { <id> (child) = <txt_offset> } (keyboard_text_focus) 
			(SpawnScript) (keyboard_key_focus) (params) = { (id) = <id> (org_scale) = PAIR(1.00000000000, 1.04999995232) } 
		ELSE 
			(RunScriptOnScreenElement) (id) = { <id> (child) = <txt_offset> } (keyboard_text_focus) 
			(SpawnScript) (keyboard_key_focus) (params) = { (id) = <id> (org_scale) = PAIR(1.00000000000, 1.60000002384) } 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT (keyboard_button_unfocus) 
	(GetTags) 
	<txt_offset> = 0 
	IF (GotParam) (tag_txt_offset) 
		<txt_offset> = <tag_txt_offset> 
	ENDIF 
	IF (ScreenElementExists) (id) = { <id> (child) = ( <txt_offset> + 1 ) } 
		(RunScriptOnScreenElement) (id) = { <id> (child) = ( <txt_offset> + 1 ) } (keyboard_text_unfocus) 
		(KillSpawnedScript) (name) = (keyboard_key_focus) 
		(DoScreenElementMorph) (id) = <id> (time) = 0 (scale) = PAIR(1.00000000000, 1.00000000000) 
	ELSE 
		IF (GotParam) (tag_txt_offset) 
			(RunScriptOnScreenElement) (id) = { <id> (child) = <txt_offset> } (keyboard_text_unfocus) 
			(KillSpawnedScript) (name) = (keyboard_key_focus) 
			(DoScreenElementMorph) (id) = <id> (time) = 0 (scale) = PAIR(1.00000000000, 1.00000000000) 
		ELSE 
			(RunScriptOnScreenElement) (id) = { <id> (child) = <txt_offset> } (keyboard_text_unfocus) 
			(KillSpawnedScript) (name) = (keyboard_key_focus) 
			(DoScreenElementMorph) (id) = <id> (time) = 0 (scale) = PAIR(1.00000000000, 1.60000002384) 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT (keyboard_key_focus) 
	BEGIN 
		IF (ObjectExists) (id) = <id> 
			(DoScreenElementMorph) (id) = <id> (time) = 0.02999999933 (scale) = ( <org_scale> * 1.04999995232 ) 
		ENDIF 
		(wait) 0.20000000298 (second) 
		IF (ObjectExists) (id) = <id> 
			(DoScreenElementMorph) (id) = <id> (time) = 0.02999999933 (scale) = ( <org_scale> * 0.94999998808 ) 
		ENDIF 
		(wait) 0.20000000298 (second) 
	REPEAT 
ENDSCRIPT

SCRIPT (keyboard_text_focus) 
	(FormatText) (ChecksumName) = (highlight_color) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(SetProps) (rgba) = <highlight_color> 
ENDSCRIPT

SCRIPT (keyboard_text_unfocus) 
	(FormatText) (ChecksumName) = (unhighlight_color) "%i_UNHIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(SetProps) (rgba) = <unhighlight_color> 
ENDSCRIPT

SCRIPT (keyboard_button_pressed) 
	IF ( <text> = "\\\\" ) 
		<text> = "\\" 
	ENDIF 
	IF ( <text> = "\\" ) 
		(PlaySound) (GUI_Buzzer01) 
		RETURN 
	ENDIF 
	IF ( <text> = "%" ) 
		(PlaySound) (GUI_Buzzer01) 
		RETURN 
	ENDIF 
	IF (GotParam) (max_length) 
		(GetTextElementLength) (id) = (keyboard_current_string) 
		IF ( <length> > ( <max_length> - 1 ) ) 
			(PlaySound) (GUI_Buzzer01) 
			RETURN 
		ENDIF 
	ENDIF 
	(keyboard_current_string) : (GetTags) 
	IF (GotParam) (allowed_characters) 
		IF (ArrayContains) (array) = <allowed_characters> (contains) = <text> 
			(PlaySound) (MenuUp) 
		ELSE 
			(PlaySound) (GUI_Buzzer01) 
			RETURN 
		ENDIF 
	ELSE 
		(PlaySound) (MenuUp) 
	ENDIF 
	IF ( <text> = "\\" ) 
		<text> = "\\\\" 
	ENDIF 
	(GetScreenElementDims) (id) = (keyboard_display_string) 
	IF ( <height> > 40 ) 
		<last_line> = (last_line) 
	ENDIF 
	IF (TextElementConcatenate) (id) = (keyboard_current_string) <text> (enforce_max_width) <last_line> 
		(keyboard_anchor) : (GetTags) 
		IF (GotParam) (password) 
			(TextElementBackspace) (id) = (keyboard_display_string) 
			(FormatText) (TextName) = (text_w_cursor) "%s_" (s) = "*" 
			(TextElementConcatenate) (id) = (keyboard_display_string) <text_w_cursor> (enforce_max_width) <last_line> 
		ELSE 
			(TextElementBackspace) (id) = (keyboard_display_string) 
			(FormatText) (TextName) = (text_w_cursor) "%s_" (s) = <text> 
			(TextElementConcatenate) (id) = (keyboard_display_string) <text_w_cursor> (enforce_max_width) <last_line> 
		ENDIF 
		(GetScreenElementDims) (id) = (keyboard_display_string) 
		IF (GotParam) (no_buttons) 
			(max_string_width) = 550 
		ELSE 
			(max_string_width) = 300 
		ENDIF 
		IF (ScreenElementExists) (id) = (keyboard_display_string_container) 
			IF ( <width> > <max_string_width> ) 
				(TextElementBackspace) (id) = (keyboard_display_string) 
				(TextElementBackspace) (id) = (keyboard_display_string) 
				(TextElementBackspace) (id) = (keyboard_current_string) 
				(PlaySound) (GUI_Buzzer01) 
			ENDIF 
		ELSE 
			(printf) "%s %t" (s) = <height> (t) = <width> 
			IF ( <height> > 80 ) 
				(TextElementBackspace) (id) = (keyboard_display_string) 
				(TextElementBackspace) (id) = (keyboard_current_string) 
				IF NOT ( <text> = " " ) 
					(TextElementBackspace) (id) = (keyboard_display_string) 
					(TextElementConcatenate) (id) = (keyboard_display_string) " " (enforce_max_width) <last_line> 
				ENDIF 
				(printf) "string reached end of keyboard!" 
				(PlaySound) (GUI_Buzzer01) 
			ENDIF 
		ENDIF 
		SWITCH (keyboard_current_charset) 
			CASE (alphanumeric_lower) 
				IF (IsTrue) (keyboard_caps_lock) 
					(keyboard_change_charset) (charset) = (alphanumeric_charset_upper) (max_length) = <max_length> 
					(change) (keyboard_current_charset) = (alphanumeric_upper) 
				ENDIF 
			CASE (alphanumeric_upper) 
				IF NOT (IsTrue) (keyboard_caps_lock) 
					(keyboard_change_charset) (charset) = (alphanumeric_charset_lower) (max_length) = <max_length> 
					(change) (keyboard_current_charset) = (alphanumeric_lower) 
				ENDIF 
		ENDSWITCH 
	ELSE 
		(printf) "string too long!" 
	ENDIF 
ENDSCRIPT

(keyboard_toggling_char_set) = 0 
SCRIPT (keyboard_handle_L2) 
	IF ( (keyboard_toggling_char_set) = 1 ) 
		RETURN 
	ENDIF 
	(change) (keyboard_toggling_char_set) = 1 
	(FormatText) (ChecksumName) = (highlight_color) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	SWITCH (keyboard_current_charset) 
		CASE (alphanumeric_lower) 
			(keyboard_change_charset) (charset) = (alphanumeric_charset_upper) (max_length) = <max_length> 
			(change) (keyboard_current_charset) = (alphanumeric_upper) 
			(reset_char_guides) 
			(SetScreenElementProps) (id) = (char_guide_allcaps) (rgba) = <highlight_color> 
			(change) (keyboard_caps_lock) = 1 
		CASE (alphanumeric_upper) 
			(keyboard_change_charset) (charset) = (punctuation_charset) (max_length) = <max_length> 
			(change) (keyboard_current_charset) = (punctuation_charset) 
			(reset_char_guides) 
			(SetScreenElementProps) (id) = (char_guide_symbols) (rgba) = <highlight_color> 
		CASE (punctuation_charset) 
			(keyboard_change_charset) (charset) = (foreign_charset) (max_length) = <max_length> 
			(change) (keyboard_current_charset) = (foreign_charset) 
			(reset_char_guides) 
			(SetScreenElementProps) (id) = (char_guide_foreign) (rgba) = <highlight_color> 
		CASE (foreign_charset) 
			(keyboard_change_charset) (charset) = (alphanumeric_charset_lower) (max_length) = <max_length> 
			(change) (keyboard_current_charset) = (alphanumeric_lower) 
			(reset_char_guides) 
			(SetScreenElementProps) (id) = (char_guide_lower) (rgba) = <highlight_color> 
	ENDSWITCH 
	(RunScriptOnScreenElement) (menu_blink_arrow) (id) = (char_guide_left_arrow) 
	(PlaySound) (MenuUp) 
	(wait) 0.30000001192 (seconds) 
	(change) (keyboard_toggling_char_set) = 0 
ENDSCRIPT

SCRIPT (keyboard_handle_R2) 
	IF ( (keyboard_toggling_char_set) = 1 ) 
		RETURN 
	ENDIF 
	(change) (keyboard_toggling_char_set) = 1 
	(FormatText) (ChecksumName) = (highlight_color) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	SWITCH (keyboard_current_charset) 
		CASE (alphanumeric_lower) 
			(keyboard_change_charset) (charset) = (foreign_charset) (max_length) = <max_length> 
			(change) (keyboard_current_charset) = (foreign_charset) 
			(reset_char_guides) 
			(SetScreenElementProps) (id) = (char_guide_foreign) (rgba) = <highlight_color> 
		CASE (alphanumeric_upper) 
			(keyboard_change_charset) (charset) = (alphanumeric_charset_lower) (max_length) = <max_length> 
			(change) (keyboard_current_charset) = (alphanumeric_lower) 
			(reset_char_guides) 
			(SetScreenElementProps) (id) = (char_guide_lower) (rgba) = <highlight_color> 
		CASE (punctuation_charset) 
			(keyboard_change_charset) (charset) = (alphanumeric_charset_upper) (max_length) = <max_length> 
			(change) (keyboard_current_charset) = (alphanumeric_upper) 
			(reset_char_guides) 
			(SetScreenElementProps) (id) = (char_guide_allcaps) (rgba) = <highlight_color> 
			(change) (keyboard_caps_lock) = 1 
		CASE (foreign_charset) 
			(keyboard_change_charset) (charset) = (punctuation_charset) (max_length) = <max_length> 
			(change) (keyboard_current_charset) = (punctuation_charset) 
			(reset_char_guides) 
			(SetScreenElementProps) (id) = (char_guide_symbols) (rgba) = <highlight_color> 
	ENDSWITCH 
	(RunScriptOnScreenElement) (menu_blink_arrow) (id) = (char_guide_right_arrow) 
	(PlaySound) (MenuUp) 
	(wait) 0.30000001192 (seconds) 
	(change) (keyboard_toggling_char_set) = 0 
ENDSCRIPT

SCRIPT (reset_char_guides) 
	(FormatText) (ChecksumName) = (unhighlight_color) "%i_UNHIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(SetScreenElementProps) (id) = (char_guide_allcaps) (rgba) = <unhighlight_color> 
	(SetScreenElementProps) (id) = (char_guide_lower) (rgba) = <unhighlight_color> 
	(SetScreenElementProps) (id) = (char_guide_symbols) (rgba) = <unhighlight_color> 
	(SetScreenElementProps) (id) = (char_guide_foreign) (rgba) = <unhighlight_color> 
	(change) (keyboard_caps_lock) = 0 
ENDSCRIPT

SCRIPT (keyboard_handle_shift) 
	(PlaySound) (MenuUp) 
	SWITCH (keyboard_current_charset) 
		CASE (alphanumeric_lower) 
			(keyboard_change_charset) (charset) = (alphanumeric_charset_upper) (max_length) = <max_length> 
			(change) (keyboard_current_charset) = (alphanumeric_upper) 
		CASE (alphanumeric_upper) 
			(keyboard_change_charset) (charset) = (alphanumeric_charset_lower) (max_length) = <max_length> 
			(change) (keyboard_current_charset) = (alphanumeric_lower) 
	ENDSWITCH 
ENDSCRIPT

SCRIPT (keyboard_handle_backspace) 
	(PlaySound) (menu03) (vol) = 60 (pitch) = 55 
	(TextElementBackspace) (id) = (keyboard_display_string) 
	(TextElementBackspace) (id) = (keyboard_display_string) 
	(TextElementConcatenate) (id) = (keyboard_display_string) "_" 
	IF NOT (TextElementBackspace) (id) = (keyboard_current_string) 
	ENDIF 
ENDSCRIPT

SCRIPT (keyboard_handle_space) 
	(keyboard_button_pressed) (text) = " " (max_length) = <max_length> 
ENDSCRIPT

SCRIPT (keyboard_handle_caps) 
	(FormatText) (ChecksumName) = (highlight_color) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(PlaySound) (MenuUp) 
	SWITCH (keyboard_current_charset) 
		CASE (alphanumeric_upper) 
			(keyboard_change_charset) (charset) = (alphanumeric_charset_lower) (max_length) = <max_length> 
			(change) (keyboard_current_charset) = (alphanumeric_lower) 
			(reset_char_guides) 
			(SetScreenElementProps) (id) = (char_guide_lower) (rgba) = <highlight_color> 
			(change) (keyboard_caps_lock) = 0 
		CASE (alphanumeric_lower) 
			(keyboard_change_charset) (charset) = (alphanumeric_charset_upper) (max_length) = <max_length> 
			(change) (keyboard_current_charset) = (alphanumeric_upper) 
			(reset_char_guides) 
			(SetScreenElementProps) (id) = (char_guide_allcaps) (rgba) = <highlight_color> 
			(change) (keyboard_caps_lock) = 1 
		CASE (punctuation_charset) 
			(keyboard_change_charset) (charset) = (alphanumeric_charset_upper) (max_length) = <max_length> 
			(change) (keyboard_current_charset) = (alphanumeric_upper) 
			(reset_char_guides) 
			(SetScreenElementProps) (id) = (char_guide_allcaps) (rgba) = <highlight_color> 
			(change) (keyboard_caps_lock) = 1 
		CASE (foreign_charset) 
			(keyboard_change_charset) (charset) = (alphanumeric_charset_upper) (max_length) = <max_length> 
			(change) (keyboard_current_charset) = (alphanumeric_upper) 
			(reset_char_guides) 
			(SetScreenElementProps) (id) = (char_guide_allcaps) (rgba) = <highlight_color> 
			(change) (keyboard_caps_lock) = 1 
		DEFAULT 
	ENDSWITCH 
ENDSCRIPT

SCRIPT (keyboard_done) 
	(generic_menu_pad_choose_sound) 
	(SetButtonEventMappings) (unblock_menu_input) 
	IF (GotParam) (min_length) 
		(GetTextElementLengthTrim) (id) = (keyboard_current_string) 
		IF ( <length> < <min_length> ) 
			(printf) "Not enough characters" 
			RETURN 
		ENDIF 
	ENDIF 
	(change) (keyboard_current_charset) = (alphanumeric_lower) 
	(change) (keyboard_caps_lock) = 0 
	IF (GotParam) (keyboard_done_script) 
		(printf) "calling done script" 
		(GotoPreserveParams) <keyboard_done_script> 
	ELSE 
		(GetTextElementString) (id) = (keyboard_current_string) 
		IF (GotParam) (string) 
			(printf) "%s" (s) = <string> 
		ENDIF 
		(destroy_onscreen_keyboard) 
		(exit_pause_menu) 
	ENDIF 
ENDSCRIPT

SCRIPT (keyboard_cancel) 
	(destroy_onscreen_keyboard) 
	(exit_pause_menu) 
ENDSCRIPT

(alphanumeric_charset_lower) = [ [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "0" ] 
	[ "a" "b" "c" "d" "e" "f" "g" "h" "i" "j" ] 
	[ "k" "l" "m" "n" "o" "p" "q" "r" "s" "t" ] 
	[ "u" "v" "w" "x" "y" "z" ] 
] 
(alphanumeric_charset_upper) = [ [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "0" ] 
	[ "A" "B" "C" "D" "E" "F" "G" "H" "I" "J" ] 
	[ "K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" ] 
	[ "U" "V" "W" "X" "Y" "Z" ] 
] 
(punctuation_charset) = [ [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "0" ] 
	[ "." "," "!" "?" "-" "\xA6" "\'" "+" "/" "^" ] 
	[ "#" "$" "{" "*" "@" "`" "&" ":" "<" ">" ] 
	[ "_" "-" "\xA1" "=" "(" ")" ] 
] 
(foreign_charset) = [ [ "\xDF" "\xC4" "\xDC" "\xD6" "\xE0" "\xE2" "\xEA" "\xE8" "\xE9" "\xEB" ] 
	[ "\xEC" "\xEE" "\xEF" "\xF4" "\xF2" "\xD6" "\xF9" "\xFB" "\xDC" "\xE7" ] 
	[ "\x9C" "\xFC" "\xE4" "\xF6" "\xE1" "\xF3" "\xFA" "\xED" "\xF1" "\xAE" ] 
	[ "\xA1" "\xBF" "\xE4" "\xFC" "\xC9" "\xA9" ] 
] 
(standard_charset) = { 
	(alphanumeric_charset) 
	(allow_punctuation) 
	(allow_spaces) 
} 
(gapname_charset) = { 
	(alphanumeric_charset) 
	(allow_basic_punctuation) 
	(allow_spaces) 
} 
(ip_charset) = { 
	(ip_control) 
	(allow_numbers) 
	(allow_period) 
} 
(alphanumeric_charset) = { 
	(allow_numbers) 
	(allow_uppercase) 
	(allow_lowercase) 
	(allow_foreign) 
} 
(horse_charset) = { 
	(allow_numbers) 
	(allow_uppercase) 
	(allow_lowercase) 
} 
SCRIPT (truncate_string) (max_width) = 100 
	(GetScreenElementDims) (id) = <id> 
	IF ( <max_width> > <width> ) 
		RETURN 
	ENDIF 
	(GetTextElementLength) (id) = <id> 
	IF ( 2 > <length> ) 
		(printf) "too short... can\'t truncate text" 
		RETURN 
	ENDIF 
	(initial_width) = <width> 
	(printf) "initial width = %w max width = %m" (w) = <width> (m) = <max_width> 
	(TextElementConcatenate) (id) = <id> "..." 
	(GetScreenElementDims) (id) = <id> 
	(extra_width) = ( <width> - <initial_width> ) 
	(TextElementBackspace) (id) = <id> 
	(TextElementBackspace) (id) = <id> 
	(TextElementBackspace) (id) = <id> 
	BEGIN 
		(GetScreenElementDims) (id) = <id> 
		IF ( ( <width> + <extra_width> ) > <max_width> ) 
			(TextElementBackspace) (id) = <id> 
		ELSE 
			BREAK 
		ENDIF 
		(GetTextElementLength) (id) = <id> 
		IF ( 0 = <length> ) 
			RETURN 
		ENDIF 
	REPEAT 
	(TextElementConcatenate) (id) = <id> "..." 
	(GetScreenElementDims) (id) = <id> 
	(printf) "final width = %w" (w) = <width> 
ENDSCRIPT

SCRIPT (keyboard_change_key_sound) 
	(PlaySound) (menu03) (vol) = 40 
ENDSCRIPT

SCRIPT (keyboard_update_cursor) (scale) = PAIR(1.29999995232, 1.00000000000) 
	IF (ScreenElementExists) (id) = (keyboard_cursor) 
		(DestroyScreenElement) (id) = (keyboard_cursor) 
	ENDIF 
	(keyboard_anchor) : (GetTags) 
	IF (GotParam) (no_buttons) 
		(GetStackedScreenElementPos) (X) (id) = (keyboard_display_string) (offset) = PAIR(0.00000000000, 0.00000000000) 
	ELSE 
		IF (GotParam) (text_block) 
			(GetStackedScreenElementPos) (X) (Y) (id) = (keyboard_display_string) (offset) = PAIR(100000.00000000000, 0.00000000000) 
			(scale) = PAIR(0.80000001192, 0.50000000000) 
		ELSE 
			(GetStackedScreenElementPos) (X) (id) = (keyboard_display_string) (offset) = PAIR(310.00000000000, 79.00000000000) 
		ENDIF 
	ENDIF 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (keyboard_anchor) 
		(id) = (keyboard_cursor) 
		(font) = (small) 
		(text) = "_" 
		(scale) = <scale> 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(rgba) = [ 128 128 128 128 ] 
		(z_priority) = 3 
	} 
	(RunScriptOnScreenElement) (id) = (keyboard_cursor) (keyboard_blink_cursor) 
ENDSCRIPT

SCRIPT (keyboard_blink_cursor) (wait_time) = 0.15000000596 
	BEGIN 
		(DoMorph) (time) = <wait_time> 
		(DoMorph) (alpha) = 0 
		(DoMorph) (time) = <wait_time> 
		(DoMorph) (alpha) = 1 
	REPEAT 
ENDSCRIPT


