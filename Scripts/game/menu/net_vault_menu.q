
(best_green) = [ 40 128 40 120 ] 
SCRIPT (create_downloads_menu) 
	(dialog_box_exit) 
	(FormatText) (ChecksumName) = (rgba) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(build_top_and_bottom_blocks) 
	(make_mainmenu_3d_plane) 
	(SetScreenElementLock) (id) = (menu_parts_anchor) (off) 
	(CreateScreenElement) { 
		(type) = (ContainerElement) 
		(parent) = (menu_parts_anchor) 
		(id) = (downloads_anchor) 
		(pos) = PAIR(-5, 800) 
	} 
	(make_new_menu) { (menu_id) = (downloads_menu) 
		(vmenu_id) = (downloads_vmenu) 
		(parent) = (downloads_anchor) 
		(pos) = PAIR(80, 85) 
	} 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (downloads_anchor) 
		(font) = (testtitle) 
		(text) = "DOWNLOAD" 
		(scale) = 1.50000000000 
		(pos) = PAIR(170.00000000000, 86.00000000000) 
		(just) = [ (center) (top) ] 
		(rgba) = [ 128 128 128 98 ] 
		(not_focusable) 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (downloads_anchor) 
		(texture) = (regions) 
		(scale) = 1 
		(pos) = PAIR(39.00000000000, 82.00000000000) 
		(just) = [ (left) (top) ] 
		(rgba) = <rgba> 
		(scale) = PAIR(1.02499997616, 1.00000000000) 
		(alpha) = 0.60000002384 
		(not_focusable) 
	} 
	(SetScreenElementProps) { (id) = (downloads_menu) (event_handlers) = [ { (pad_back) (generic_menu_pad_back) (params) = { (callback) = (back_from_downloads_menu) } } ] } 
	(downloads_menu_add_item) (text) = "" (not_focusable) = (not_focusable) 
	(downloads_menu_add_item) { 
		(text) = "Parks" 
		(id) = (menu_down_parks) 
		(pad_choose_script) = (download_content) 
		(pad_choose_params) = { (type) = (parks) } 
	} 
	(downloads_menu_add_item) { 
		(text) = "Skater/Story" 
		(id) = (menu_down_skaters) 
		(pad_choose_script) = (download_content) 
		(pad_choose_params) = { (type) = (skaters) } 
	} 
	(downloads_menu_add_item) { 
		(text) = "Tricks" 
		(id) = (menu_down_tricks) 
		(pad_choose_script) = (download_content) 
		(pad_choose_params) = { (type) = (tricks) } 
	} 
	(downloads_menu_add_item) { 
		(text) = "Goals" 
		(id) = (menu_down_goals) 
		(pad_choose_script) = (download_content) 
		(pad_choose_params) = { (type) = (goals) } 
		(last_menu_item) = (last_menu_item) 
	} 
	(RunScriptOnScreenElement) (lobby_list_animate_in) (id) = (downloads_anchor) (params) = { (id) = (downloads_anchor) } 
	(FireEvent) (type) = (unfocus) (target) = (sub_menu) 
	(FireEvent) (type) = (focus) (target) = (downloads_menu) 
	(AssignAlias) (id) = (menu_parts_anchor) (alias) = (current_menu_anchor) 
ENDSCRIPT

SCRIPT (downloads_menu_add_item) (parent) = (downloads_vmenu) 
	(theme_menu_add_item) { (parent) = <parent> (centered) <...> (menu) = 2 (middle_scale) = PAIR(2.09999990463, 1.00000000000) (static_width) (highlight_bar_scale) = PAIR(2.00000000000, 0.69999998808) } 
ENDSCRIPT

SCRIPT (back_from_downloads_menu) 
	(FireEvent) (type) = (unfocus) (target) = (downloads_menu) 
	(DestroyScreenElement) (id) = (downloads_anchor) 
	(FireEvent) (type) = (focus) (target) = (sub_menu) 
ENDSCRIPT

SCRIPT (create_uploads_menu) 
	(dialog_box_exit) 
	(FormatText) (ChecksumName) = (rgba) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(build_top_and_bottom_blocks) 
	(make_mainmenu_3d_plane) 
	(SetScreenElementLock) (id) = (menu_parts_anchor) (off) 
	(CreateScreenElement) { 
		(type) = (ContainerElement) 
		(parent) = (menu_parts_anchor) 
		(id) = (uploads_anchor) 
		(pos) = PAIR(-5.00000000000, 800.00000000000) 
	} 
	(make_new_menu) { (menu_id) = (uploads_menu) 
		(vmenu_id) = (uploads_vmenu) 
		(parent) = (uploads_anchor) 
		(pos) = PAIR(80.00000000000, 85.00000000000) 
	} 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (uploads_anchor) 
		(font) = (testtitle) 
		(text) = "UPLOAD" 
		(scale) = 1.50000000000 
		(pos) = PAIR(170.00000000000, 86.00000000000) 
		(just) = [ (center) (top) ] 
		(rgba) = [ 128 128 128 98 ] 
		(not_focusable) 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (uploads_anchor) 
		(texture) = (regions) 
		(scale) = 1 
		(pos) = PAIR(39.00000000000, 82.00000000000) 
		(just) = [ (left) (top) ] 
		(rgba) = <rgba> 
		(scale) = PAIR(1.02499997616, 1.00000000000) 
		(alpha) = 0.60000002384 
		(not_focusable) 
	} 
	(SetScreenElementProps) { (id) = (uploads_menu) (event_handlers) = [ { (pad_back) (generic_menu_pad_back) (params) = { (callback) = (back_from_uploads_menu) } } ] } 
	(downloads_menu_add_item) (text) = "" (not_focusable) = (not_focusable) (parent) = (uploads_vmenu) 
	(downloads_menu_add_item) { 
		(parent) = (uploads_vmenu) 
		(text) = "Parks" 
		(id) = (menu_down_parks) 
		(pad_choose_script) = (launch_upload_file_sequence) 
		(pad_choose_params) = { (type) = (park) } 
	} 
	(downloads_menu_add_item) { 
		(parent) = (uploads_vmenu) 
		(text) = "Skater/Story" 
		(id) = (menu_down_skaters) 
		(pad_choose_script) = (launch_upload_file_sequence) 
		(pad_choose_params) = { (type) = (optionsandpros) } 
	} 
	(downloads_menu_add_item) { 
		(parent) = (uploads_vmenu) 
		(text) = "Tricks" 
		(id) = (menu_down_tricks) 
		(pad_choose_script) = (launch_upload_file_sequence) 
		(pad_choose_params) = { (type) = (cat) } 
	} 
	(downloads_menu_add_item) { 
		(parent) = (uploads_vmenu) 
		(text) = "Goals" 
		(id) = (menu_down_goals) 
		(pad_choose_script) = (launch_upload_file_sequence) 
		(pad_choose_params) = { (type) = (CreatedGoals) } 
		(last_menu_item) = (last_menu_item) 
	} 
	(RunScriptOnScreenElement) (lobby_list_animate_in) (id) = (uploads_anchor) (params) = { (id) = (uploads_anchor) } 
	(FireEvent) (type) = (unfocus) (target) = (sub_menu) 
	(FireEvent) (type) = (focus) (target) = (uploads_menu) 
	(AssignAlias) (id) = (menu_parts_anchor) (alias) = (current_menu_anchor) 
ENDSCRIPT

SCRIPT (back_from_uploads_menu) 
	(FireEvent) (type) = (unfocus) (target) = (uploads_menu) 
	(DestroyScreenElement) (id) = (uploads_anchor) 
	(FireEvent) (type) = (focus) (target) = (sub_menu) 
ENDSCRIPT

SCRIPT (net_vault_menu_create) 
	(pulse_blur) 
	(dialog_box_exit) 
	IF (ObjectExists) (id) = (current_menu_anchor) 
		(DestroyScreenElement) (id) = (current_menu_anchor) 
	ENDIF 
	(SetScreenElementLock) (id) = (root_window) (off) 
	(FormatText) (ChecksumName) = (on_rgba) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(FormatText) (ChecksumName) = (off_rgba) "%i_UNHIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(CreateScreenElement) { 
		(type) = (ContainerElement) 
		(parent) = (root_window) 
		(id) = (vault_bg_anchor) 
		(dims) = PAIR(640.00000000000, 480.00000000000) 
		(pos) = PAIR(320.00000000000, 240.00000000000) 
	} 
	(AssignAlias) (id) = (vault_bg_anchor) (alias) = (current_menu_anchor) 
	(create_helper_text) (generic_helper_text_up_down_left_right) 
	IF (GotParam) (type) 
		SWITCH <type> 
			CASE (parks) 
				(title) = "PARK VAULT" 
			CASE (goals) 
				(title) = "GOAL VAULT" 
			CASE (tricks) 
				(title) = "TRICK VAULT" 
			CASE (skaters) 
				(title) = "SKATER VAULT" 
			DEFAULT 
				(title) = "NEVERSOFT VAULT" 
		ENDSWITCH 
	ELSE 
		(title) = "NEVERSOFT VAULT" 
	ENDIF 
	(FormatText) (ChecksumName) = (title_icon) "%i_vault" (i) = ( (THEME_PREFIXES) [ (current_theme_prefix) ] ) 
	(build_theme_sub_title) (title) = <title> (title_icon) = <title_icon> 
	(build_top_and_bottom_blocks) (bot_z) = 15 
	(make_mainmenu_3d_plane) 
	(CreateScreenElement) { 
		(type) = (ContainerElement) 
		(parent) = (vault_bg_anchor) 
		(id) = (vault_menu_anchor) 
		(dims) = PAIR(640.00000000000, 480.00000000000) 
		(pos) = PAIR(320.00000000000, 840.00000000000) 
	} 
	(AssignAlias) (id) = (vault_menu_anchor) (alias) = (current_menu_anchor) 
	(theme_background) (width) = 7 (pos) = PAIR(320.00000000000, 63.00000000000) (num_parts) = 10 (static) = (static) (dark_menu) = (dark_menu) 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (current_menu_anchor) 
		(texture) = (white2) 
		(scale) = PAIR(71.30000305176, 8.00000000000) 
		(pos) = PAIR(35.00000000000, 63.00000000000) 
		(just) = [ (left) (top) ] 
		(rgba) = [ 0 0 0 128 ] 
		(alpha) = 0.80000001192 
		(z_priority) = 2 
	} 
	(text) = "" 
	(rgba) = <on_rgba> 
	(star_alpha) = 0 
	IF (GotParam) (category) 
		IF ( <category> = "Best" ) 
			(text) = "Best of the Best" 
			(rgba) = (best_green) 
			(star_alpha) = 1 
		ELSE 
			(text) = <category> 
		ENDIF 
	ENDIF 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (current_menu_anchor) 
		(id) = (net_vault_menu_category) 
		(text) = <text> 
		(scale) = 1.39999997616 
		(font) = (small) 
		(rgba) = <rgba> 
		(pos) = PAIR(63.00000000000, 85.00000000000) 
		(just) = [ (left) (center) ] 
		(z_priority) = 3 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (current_menu_anchor) 
		(id) = (net_vault_menu_left_arrow) 
		(texture) = (left_arrow) 
		(scale) = PAIR(1.00000000000, 1.00000000000) 
		(pos) = PAIR(60.00000000000, 83.00000000000) 
		(just) = [ (right) (center) ] 
		(alpha) = 0.50000000000 
		(z_priority) = 3 
	} 
	(GetStackedScreenElementPos) (X) (id) = (net_vault_menu_category) (offset) = PAIR(5.00000000000, 13.00000000000) 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (current_menu_anchor) 
		(id) = (net_vault_menu_right_arrow) 
		(texture) = (right_arrow) 
		(scale) = PAIR(1.00000000000, 1.00000000000) 
		(pos) = <pos> 
		(just) = [ (left) (center) ] 
		(alpha) = 0.50000000000 
		(z_priority) = 3 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (current_menu_anchor) 
		(texture) = (neversoft) 
		(scale) = PAIR(1.75000000000, 1.29999995232) 
		(pos) = PAIR(305.00000000000, 55.00000000000) 
		(just) = [ (left) (top) ] 
		(alpha) = 0.30000001192 
		(z_priority) = 3 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (current_menu_anchor) 
		(id) = (best_star) 
		(texture) = (best) 
		(scale) = 1 
		(pos) = PAIR(535.00000000000, 63.00000000000) 
		(just) = [ (left) (top) ] 
		(rgba) = (best_green) 
		(alpha) = <star_alpha> 
		(z_priority) = 3 
	} 
	(CreateScreenElement) { 
		(type) = (VScrollingMenu) 
		(parent) = (current_menu_anchor) 
		(id) = (net_vault_vscrollingmenu) 
		(pos) = PAIR(50.00000000000, 130.00000000000) 
		(dims) = PAIR(400.00000000000, 180.00000000000) 
		(just) = [ (left) (top) ] 
	} 
	(CreateScreenElement) { 
		(type) = (VMenu) 
		(parent) = (net_vault_vscrollingmenu) 
		(id) = (net_vault_vmenu) 
		(pos) = PAIR(0.00000000000, 0.00000000000) 
		(just) = [ (left) (top) ] 
		(internal_just) = [ (left) (top) ] 
		(event_handlers) = [ { (pad_back) (generic_menu_pad_back_sound) } 
			{ (pad_back) (back_from_vault) } 
			{ (pad_down) (menu_vert_blink_arrow) (params) = { (id) = (down_arrow) } } 
			{ (pad_up) (menu_vert_blink_arrow) (params) = { (id) = (up_arrow) } } 
			{ (pad_up) (generic_menu_up_or_down_sound) (params) = { (up) } } 
			{ (pad_down) (generic_menu_up_or_down_sound) (params) = { (down) } } 
			{ (pad_left) (net_vault_menu_prev_category) } 
			{ (pad_right) (net_vault_menu_next_category) } 
		] 
		(dont_allow_wrap) 
	} 
	(AssignAlias) (id) = (net_vault_vmenu) (alias) = (current_menu) 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (vault_bg_anchor) 
		(id) = (globe) 
		(texture) = (globe) 
		(scale) = 1.29999995232 
		(pos) = PAIR(320.00000000000, 560.00000000000) 
		(just) = [ (center) (center) ] 
		(alpha) = 0.30000001192 
		(z_priority) = -1 
	} 
	IF (GotParam) (type) 
		SWITCH <type> 
			CASE (parks) 
				(create_net_vault_parks_menu) 
			CASE (goals) 
				(create_net_vault_goals_menu) 
			CASE (tricks) 
				(create_net_vault_tricks_menu) 
			CASE (skaters) 
				(create_net_vault_skaters_menu) 
			DEFAULT 
				(printf) "bad type in net_vault_menu_create---------------------------------------" 
				(printstruct) <...> 
		ENDSWITCH 
	ENDIF 
	(FillVaultMenu) 
	(RunScriptOnScreenElement) (id) = (net_vault_vscrollingmenu) (reset_vault_scrolling_menu) 
	(RunScriptOnScreenElement) (id) = (globe) (rotate_internet_options_globe) 
	(RunScriptOnScreenElement) (id) = (vault_menu_anchor) (online_stats_animate_in) (params) = { (id) = (vault_menu_anchor) } 
	(FireEvent) (type) = (focus) (target) = (current_menu) 
ENDSCRIPT

SCRIPT (reset_vault_scrolling_menu) 
	(wait) 2 (gameframes) 
	(SetScreenElementProps) (id) = (net_vault_vscrollingmenu) (reset_window_top) 
ENDSCRIPT

SCRIPT (create_net_vault_parks_menu) 
	IF (ScreenElementExists) (id) = (net_vault_submenu_anchor) 
		(DestroyScreenElement) (id) = (net_vault_submenu_anchor) 
	ENDIF 
	(SetScreenElementLock) (off) (id) = (vault_menu_anchor) 
	(FormatText) (ChecksumName) = (on_rgba) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(FormatText) (ChecksumName) = (off_rgba) "%i_UNHIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(CreateScreenElement) { 
		(type) = (ContainerElement) 
		(parent) = (vault_menu_anchor) 
		(id) = (net_vault_submenu_anchor) 
		(dims) = PAIR(640.00000000000, 480.00000000000) 
		(pos) = PAIR(320.00000000000, 240.00000000000) 
	} 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (net_vault_submenu_anchor) 
		(text) = "Park Name" 
		(scale) = 1 
		(font) = (dialog) 
		(rgba) = <on_rgba> 
		(pos) = PAIR(90.00000000000, 115.00000000000) 
		(just) = [ (left) (center) ] 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (net_vault_submenu_anchor) 
		(id) = (up_arrow) 
		(texture) = (up_arrow) 
		(scale) = 1 
		(pos) = PAIR(240.00000000000, 115.00000000000) 
		(just) = [ (center) (center) ] 
		(alpha) = 0.50000000000 
		(z_priority) = 3 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (net_vault_submenu_anchor) 
		(id) = (down_arrow) 
		(texture) = (down_arrow) 
		(scale) = 1 
		(pos) = PAIR(240.00000000000, 314.00000000000) 
		(just) = [ (center) (center) ] 
		(alpha) = 0.50000000000 
		(z_priority) = 3 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (net_vault_submenu_anchor) 
		(texture) = (white2) 
		(scale) = PAIR(0.80000001192, 28.29999923706) 
		(pos) = PAIR(260.00000000000, 127.00000000000) 
		(just) = [ (left) (top) ] 
		(rgba) = [ 0 0 0 128 ] 
		(alpha) = 0.80000001192 
		(z_priority) = 2 
	} 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (net_vault_submenu_anchor) 
		(text) = "Creator" 
		(scale) = 1 
		(font) = (dialog) 
		(rgba) = <on_rgba> 
		(pos) = PAIR(265.00000000000, 115.00000000000) 
		(just) = [ (left) (center) ] 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (net_vault_submenu_anchor) 
		(texture) = (white2) 
		(scale) = PAIR(0.80000001192, 28.29999923706) 
		(pos) = PAIR(470.00000000000, 127.00000000000) 
		(just) = [ (left) (top) ] 
		(rgba) = [ 0 0 0 128 ] 
		(alpha) = 0.80000001192 
		(z_priority) = 2 
	} 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (net_vault_submenu_anchor) 
		(text) = "Size" 
		(scale) = 1 
		(font) = (dialog) 
		(rgba) = <on_rgba> 
		(pos) = PAIR(480.00000000000, 115.00000000000) 
		(just) = [ (left) (center) ] 
	} 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (net_vault_submenu_anchor) 
		(id) = (description_text) 
		(text) = "" 
		(scale) = 0.80000001192 
		(font) = (dialog) 
		(rgba) = <off_rgba> 
		(pos) = PAIR(320.00000000000, 324.00000000000) 
		(just) = [ (center) (top) ] 
	} 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (net_vault_submenu_anchor) 
		(id) = (pieces_text) 
		(text) = "pieces" 
		(scale) = 0.80000001192 
		(font) = (dialog) 
		(rgba) = <off_rgba> 
		(pos) = PAIR(100.00000000000, 338.00000000000) 
		(just) = [ (center) (top) ] 
	} 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (net_vault_submenu_anchor) 
		(id) = (gap_text) 
		(text) = "" 
		(scale) = 0.80000001192 
		(font) = (dialog) 
		(rgba) = <off_rgba> 
		(pos) = PAIR(200.00000000000, 338.00000000000) 
		(just) = [ (center) (top) ] 
	} 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (net_vault_submenu_anchor) 
		(id) = (goal_text) 
		(text) = "" 
		(scale) = 0.80000001192 
		(font) = (dialog) 
		(rgba) = <off_rgba> 
		(pos) = PAIR(300.00000000000, 338.00000000000) 
		(just) = [ (center) (top) ] 
	} 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (net_vault_submenu_anchor) 
		(id) = (theme_text) 
		(text) = "" 
		(scale) = 0.80000001192 
		(font) = (dialog) 
		(rgba) = <off_rgba> 
		(pos) = PAIR(400.00000000000, 338.00000000000) 
		(just) = [ (left) (top) ] 
	} 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (net_vault_submenu_anchor) 
		(id) = (tod_text) 
		(text) = "" 
		(scale) = 0.80000001192 
		(font) = (dialog) 
		(rgba) = <off_rgba> 
		(pos) = PAIR(500.00000000000, 338.00000000000) 
		(just) = [ (center) (top) ] 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (net_vault_submenu_anchor) 
		(texture) = (white2) 
		(scale) = PAIR(71.30000305176, 4.00000000000) 
		(pos) = PAIR(320.00000000000, 324.00000000000) 
		(just) = [ (center) (top) ] 
		(rgba) = [ 0 0 0 128 ] 
		(alpha) = 0.80000001192 
		(z_priority) = 2 
	} 
ENDSCRIPT

SCRIPT (create_net_vault_skaters_menu) 
	IF (ScreenElementExists) (id) = (net_vault_submenu_anchor) 
		(DestroyScreenElement) (id) = (net_vault_submenu_anchor) 
	ENDIF 
	(SetScreenElementLock) (off) (id) = (vault_menu_anchor) 
	(FormatText) (ChecksumName) = (on_rgba) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(FormatText) (ChecksumName) = (off_rgba) "%i_UNHIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(CreateScreenElement) { 
		(type) = (ContainerElement) 
		(parent) = (vault_menu_anchor) 
		(id) = (net_vault_submenu_anchor) 
		(dims) = PAIR(640.00000000000, 480.00000000000) 
		(pos) = PAIR(320.00000000000, 240.00000000000) 
	} 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (net_vault_submenu_anchor) 
		(text) = "Skater Name" 
		(scale) = 1 
		(font) = (dialog) 
		(rgba) = <on_rgba> 
		(pos) = PAIR(90.00000000000, 115.00000000000) 
		(just) = [ (left) (center) ] 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (net_vault_submenu_anchor) 
		(id) = (up_arrow) 
		(texture) = (up_arrow) 
		(scale) = 1 
		(pos) = PAIR(240.00000000000, 115.00000000000) 
		(just) = [ (center) (center) ] 
		(alpha) = 0.50000000000 
		(z_priority) = 3 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (net_vault_submenu_anchor) 
		(id) = (down_arrow) 
		(texture) = (down_arrow) 
		(scale) = 1 
		(pos) = PAIR(240.00000000000, 314.00000000000) 
		(just) = [ (center) (center) ] 
		(alpha) = 0.50000000000 
		(z_priority) = 3 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (net_vault_submenu_anchor) 
		(texture) = (white2) 
		(scale) = PAIR(0.80000001192, 28.29999923706) 
		(pos) = PAIR(260.00000000000, 127.00000000000) 
		(just) = [ (left) (top) ] 
		(rgba) = [ 0 0 0 128 ] 
		(alpha) = 0.80000001192 
		(z_priority) = 2 
	} 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (net_vault_submenu_anchor) 
		(text) = "Creator" 
		(scale) = 1 
		(font) = (dialog) 
		(rgba) = <on_rgba> 
		(pos) = PAIR(265.00000000000, 115.00000000000) 
		(just) = [ (left) (center) ] 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (net_vault_submenu_anchor) 
		(texture) = (white2) 
		(scale) = PAIR(0.80000001192, 28.29999923706) 
		(pos) = PAIR(470.00000000000, 127.00000000000) 
		(just) = [ (left) (top) ] 
		(rgba) = [ 0 0 0 128 ] 
		(alpha) = 0.80000001192 
		(z_priority) = 2 
	} 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (net_vault_submenu_anchor) 
		(text) = "Sex" 
		(scale) = 1 
		(font) = (dialog) 
		(rgba) = <on_rgba> 
		(pos) = PAIR(480.00000000000, 115.00000000000) 
		(just) = [ (left) (center) ] 
	} 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (net_vault_submenu_anchor) 
		(id) = (description_text) 
		(text) = "" 
		(scale) = 0.80000001192 
		(font) = (dialog) 
		(rgba) = <off_rgba> 
		(pos) = PAIR(320.00000000000, 324.00000000000) 
		(just) = [ (center) (top) ] 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (net_vault_submenu_anchor) 
		(texture) = (white2) 
		(scale) = PAIR(71.30000305176, 4.00000000000) 
		(pos) = PAIR(320.00000000000, 324.00000000000) 
		(just) = [ (center) (top) ] 
		(rgba) = [ 0 0 0 128 ] 
		(alpha) = 0.80000001192 
		(z_priority) = 2 
	} 
ENDSCRIPT

SCRIPT (create_net_vault_goals_menu) 
	IF (ScreenElementExists) (id) = (net_vault_submenu_anchor) 
		(DestroyScreenElement) (id) = (net_vault_submenu_anchor) 
	ENDIF 
	(SetScreenElementLock) (off) (id) = (vault_menu_anchor) 
	(FormatText) (ChecksumName) = (on_rgba) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(FormatText) (ChecksumName) = (off_rgba) "%i_UNHIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(CreateScreenElement) { 
		(type) = (ContainerElement) 
		(parent) = (vault_menu_anchor) 
		(id) = (net_vault_submenu_anchor) 
		(dims) = PAIR(640.00000000000, 480.00000000000) 
		(pos) = PAIR(320.00000000000, 240.00000000000) 
	} 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (net_vault_submenu_anchor) 
		(text) = "Goal List" 
		(scale) = 1 
		(font) = (dialog) 
		(rgba) = <on_rgba> 
		(pos) = PAIR(90.00000000000, 115.00000000000) 
		(just) = [ (left) (center) ] 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (net_vault_submenu_anchor) 
		(id) = (up_arrow) 
		(texture) = (up_arrow) 
		(scale) = 1 
		(pos) = PAIR(240.00000000000, 115.00000000000) 
		(just) = [ (center) (center) ] 
		(alpha) = 0.50000000000 
		(z_priority) = 3 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (net_vault_submenu_anchor) 
		(id) = (down_arrow) 
		(texture) = (down_arrow) 
		(scale) = 1 
		(pos) = PAIR(240.00000000000, 314.00000000000) 
		(just) = [ (center) (center) ] 
		(alpha) = 0.50000000000 
		(z_priority) = 3 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (net_vault_submenu_anchor) 
		(texture) = (white2) 
		(scale) = PAIR(0.80000001192, 28.29999923706) 
		(pos) = PAIR(260.00000000000, 127.00000000000) 
		(just) = [ (left) (top) ] 
		(rgba) = [ 0 0 0 128 ] 
		(alpha) = 0.80000001192 
		(z_priority) = 2 
	} 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (net_vault_submenu_anchor) 
		(text) = "Creator" 
		(scale) = 1 
		(font) = (dialog) 
		(rgba) = <on_rgba> 
		(pos) = PAIR(265.00000000000, 115.00000000000) 
		(just) = [ (left) (center) ] 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (net_vault_submenu_anchor) 
		(texture) = (white2) 
		(scale) = PAIR(0.80000001192, 28.29999923706) 
		(pos) = PAIR(470.00000000000, 127.00000000000) 
		(just) = [ (left) (top) ] 
		(rgba) = [ 0 0 0 128 ] 
		(alpha) = 0.80000001192 
		(z_priority) = 2 
	} 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (net_vault_submenu_anchor) 
		(text) = "Num Goals" 
		(scale) = 1 
		(font) = (dialog) 
		(rgba) = <on_rgba> 
		(pos) = PAIR(480.00000000000, 115.00000000000) 
		(just) = [ (left) (center) ] 
	} 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (net_vault_submenu_anchor) 
		(id) = (description_text) 
		(text) = "" 
		(scale) = 0.80000001192 
		(font) = (dialog) 
		(rgba) = <off_rgba> 
		(pos) = PAIR(320.00000000000, 324.00000000000) 
		(just) = [ (center) (top) ] 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (net_vault_submenu_anchor) 
		(texture) = (white2) 
		(scale) = PAIR(71.30000305176, 4.00000000000) 
		(pos) = PAIR(320.00000000000, 324.00000000000) 
		(just) = [ (center) (top) ] 
		(rgba) = [ 0 0 0 128 ] 
		(alpha) = 0.80000001192 
		(z_priority) = 2 
	} 
ENDSCRIPT

SCRIPT (create_net_vault_tricks_menu) 
	IF (ScreenElementExists) (id) = (net_vault_submenu_anchor) 
		(DestroyScreenElement) (id) = (net_vault_submenu_anchor) 
	ENDIF 
	(SetScreenElementLock) (off) (id) = (vault_menu_anchor) 
	(FormatText) (ChecksumName) = (on_rgba) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(FormatText) (ChecksumName) = (off_rgba) "%i_UNHIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(CreateScreenElement) { 
		(type) = (ContainerElement) 
		(parent) = (vault_menu_anchor) 
		(id) = (net_vault_submenu_anchor) 
		(dims) = PAIR(640.00000000000, 480.00000000000) 
		(pos) = PAIR(320.00000000000, 240.00000000000) 
	} 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (net_vault_submenu_anchor) 
		(text) = "Trick Name" 
		(scale) = 1 
		(font) = (dialog) 
		(rgba) = <on_rgba> 
		(pos) = PAIR(90.00000000000, 115.00000000000) 
		(just) = [ (left) (center) ] 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (net_vault_submenu_anchor) 
		(id) = (up_arrow) 
		(texture) = (up_arrow) 
		(scale) = 1 
		(pos) = PAIR(240.00000000000, 115.00000000000) 
		(just) = [ (center) (center) ] 
		(alpha) = 0.50000000000 
		(z_priority) = 3 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (net_vault_submenu_anchor) 
		(id) = (down_arrow) 
		(texture) = (down_arrow) 
		(scale) = 1 
		(pos) = PAIR(240.00000000000, 314.00000000000) 
		(just) = [ (center) (center) ] 
		(alpha) = 0.50000000000 
		(z_priority) = 3 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (net_vault_submenu_anchor) 
		(texture) = (white2) 
		(scale) = PAIR(0.80000001192, 28.29999923706) 
		(pos) = PAIR(260.00000000000, 127.00000000000) 
		(just) = [ (left) (top) ] 
		(rgba) = [ 0 0 0 128 ] 
		(alpha) = 0.80000001192 
		(z_priority) = 2 
	} 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (net_vault_submenu_anchor) 
		(text) = "Creator" 
		(scale) = 1 
		(font) = (dialog) 
		(rgba) = <on_rgba> 
		(pos) = PAIR(265.00000000000, 115.00000000000) 
		(just) = [ (left) (center) ] 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (net_vault_submenu_anchor) 
		(texture) = (white2) 
		(scale) = PAIR(0.80000001192, 28.29999923706) 
		(pos) = PAIR(470.00000000000, 127.00000000000) 
		(just) = [ (left) (top) ] 
		(rgba) = [ 0 0 0 128 ] 
		(alpha) = 0.80000001192 
		(z_priority) = 2 
	} 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (net_vault_submenu_anchor) 
		(text) = "Score" 
		(scale) = 1 
		(font) = (dialog) 
		(rgba) = <on_rgba> 
		(pos) = PAIR(480.00000000000, 115.00000000000) 
		(just) = [ (left) (center) ] 
	} 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (net_vault_submenu_anchor) 
		(id) = (description_text) 
		(text) = "" 
		(scale) = 0.80000001192 
		(font) = (dialog) 
		(rgba) = <off_rgba> 
		(pos) = PAIR(320.00000000000, 324.00000000000) 
		(just) = [ (center) (top) ] 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (net_vault_submenu_anchor) 
		(texture) = (white2) 
		(scale) = PAIR(71.30000305176, 4.00000000000) 
		(pos) = PAIR(320.00000000000, 324.00000000000) 
		(just) = [ (center) (top) ] 
		(rgba) = [ 0 0 0 128 ] 
		(alpha) = 0.80000001192 
		(z_priority) = 2 
	} 
ENDSCRIPT

SCRIPT (net_vault_menu_add_park) 
	(printstruct) <...> 
	(CreateScreenElement) { 
		(type) = (ContainerElement) 
		(parent) = (current_menu) 
		(dims) = PAIR(400.00000000000, 18.00000000000) 
		(pos) = PAIR(0.00000000000, 0.00000000000) 
		(event_handlers) = [ { (focus) (net_vault_menu_focus) (params) = { (type) = (parks) } } 
			{ (unfocus) (net_vault_menu_unfocus) (params) = { (type) = (parks) } } 
			{ (pad_choose) (download_selected_file) (params) = { (type) = (parks) <pad_choose_params> } } 
			{ (pad_choose) (generic_menu_pad_choose_sound) } 
		] 
	} 
	<anchor_id> = <id> 
	IF (GotParam) (description) 
		<anchor_id> : (SetTags) (description) = <description> (num_gaps) = <num_gaps> (num_goals) = <num_goals> (num_pieces) = <num_pieces> (tod_script) = <tod_script> (theme) = <theme> 
	ELSE 
		<anchor_id> : (SetTags) (description) = "Description goes here... oops!" (num_gaps) = <num_gaps> (num_goals) = <num_goals> (num_pieces) = <num_pieces> (tod_script) = <tod_script> (theme) = <theme> 
	ENDIF 
	(net_vault_menu_add_text) (anchor_id) = <anchor_id> (text) = <name> (pos) = PAIR(0.00000000000, 0.00000000000) 
	(net_vault_menu_add_text) (anchor_id) = <anchor_id> (text) = <creator> (pos) = PAIR(220.00000000000, 0.00000000000) 
	(net_vault_menu_add_text) (anchor_id) = <anchor_id> (text) = <size> (pos) = PAIR(445.00000000000, 0.00000000000) 
	IF (GotParam) (focus) 
		(net_vault_menu_add_text) (anchor_id) = <anchor_id> (text) = <focus> (pos) = PAIR(410.00000000000, 0.00000000000) 
	ENDIF 
	IF (GotParam) (downloads) 
		(FormatText) (TextName) = (downloads_string) "%i" (i) = <downloads> 
		(net_vault_menu_add_text) (anchor_id) = <anchor_id> (text) = <downloads_string> (pos) = PAIR(470.00000000000, 0.00000000000) 
	ENDIF 
ENDSCRIPT

SCRIPT (net_vault_menu_add_goal) 
	(CreateScreenElement) { 
		(type) = (ContainerElement) 
		(parent) = (current_menu) 
		(dims) = PAIR(400.00000000000, 18.00000000000) 
		(pos) = PAIR(0.00000000000, 0.00000000000) 
		(event_handlers) = [ { (focus) (net_vault_menu_focus) (params) = { (type) = (goals) } } 
			{ (unfocus) (net_vault_menu_unfocus) (params) = { (type) = (goals) } } 
			{ (pad_choose) (download_selected_file) (params) = { (type) = (goals) <pad_choose_params> } } 
			{ (pad_choose) (generic_menu_pad_choose_sound) } 
		] 
	} 
	<anchor_id> = <id> 
	IF (GotParam) (description) 
		<anchor_id> : (SetTags) (description) = <description> (num_goals) = <num_goals> 
	ELSE 
		<anchor_id> : (SetTags) (description) = "Description goes here... oops!" (num_goals) = <num_goals> 
	ENDIF 
	(net_vault_menu_add_text) (anchor_id) = <anchor_id> (text) = <name> (pos) = PAIR(0.00000000000, 0.00000000000) 
	(net_vault_menu_add_text) (anchor_id) = <anchor_id> (text) = <creator> (pos) = PAIR(220.00000000000, 0.00000000000) 
	(FormatText) (TextName) = (string) "%i" (i) = <num_goals> 
	(net_vault_menu_add_text) (anchor_id) = <anchor_id> (text) = <string> (pos) = PAIR(445.00000000000, 0.00000000000) 
	IF (GotParam) (focus) 
		(net_vault_menu_add_text) (anchor_id) = <anchor_id> (text) = <focus> (pos) = PAIR(410.00000000000, 0.00000000000) 
	ENDIF 
	IF (GotParam) (downloads) 
		(FormatText) (TextName) = (downloads_string) "%i" (i) = <downloads> 
		(net_vault_menu_add_text) (anchor_id) = <anchor_id> (text) = <downloads_string> (pos) = PAIR(470.00000000000, 0.00000000000) 
	ENDIF 
ENDSCRIPT

SCRIPT (net_vault_menu_add_trick) 
	(CreateScreenElement) { 
		(type) = (ContainerElement) 
		(parent) = (current_menu) 
		(dims) = PAIR(400.00000000000, 18.00000000000) 
		(pos) = PAIR(0.00000000000, 0.00000000000) 
		(event_handlers) = [ { (focus) (net_vault_menu_focus) (params) = { (type) = (tricks) } } 
			{ (unfocus) (net_vault_menu_unfocus) (params) = { (type) = (tricks) } } 
			{ (pad_choose) (download_selected_file) (params) = { (type) = (tricks) <pad_choose_params> } } 
			{ (pad_choose) (generic_menu_pad_choose_sound) } 
		] 
	} 
	<anchor_id> = <id> 
	IF (GotParam) (description) 
		<anchor_id> : (SetTags) (description) = <description> (score) = <score> 
	ELSE 
		<anchor_id> : (SetTags) (description) = "Description goes here... oops!" (score) = <score> 
	ENDIF 
	(net_vault_menu_add_text) (anchor_id) = <anchor_id> (text) = <name> (pos) = PAIR(0.00000000000, 0.00000000000) 
	(net_vault_menu_add_text) (anchor_id) = <anchor_id> (text) = <creator> (pos) = PAIR(220.00000000000, 0.00000000000) 
	(FormatText) (TextName) = (string) "%i" (i) = <score> 
	(net_vault_menu_add_text) (anchor_id) = <anchor_id> (text) = <string> (pos) = PAIR(445.00000000000, 0.00000000000) 
	IF (GotParam) (focus) 
		(net_vault_menu_add_text) (anchor_id) = <anchor_id> (text) = <focus> (pos) = PAIR(410.00000000000, 0.00000000000) 
	ENDIF 
	IF (GotParam) (downloads) 
		(FormatText) (TextName) = (downloads_string) "%i" (i) = <downloads> 
		(net_vault_menu_add_text) (anchor_id) = <anchor_id> (text) = <downloads_string> (pos) = PAIR(470.00000000000, 0.00000000000) 
	ENDIF 
ENDSCRIPT

SCRIPT (net_vault_menu_add_skater) 
	(printf) "net_vault_menu_add_skater" 
	(CreateScreenElement) { 
		(type) = (ContainerElement) 
		(parent) = (current_menu) 
		(dims) = PAIR(400.00000000000, 18.00000000000) 
		(pos) = PAIR(0.00000000000, 0.00000000000) 
		(event_handlers) = [ { (focus) (net_vault_menu_focus) (params) = { (type) = (skaters) } } 
			{ (unfocus) (net_vault_menu_unfocus) (params) = { (type) = (skaters) } } 
			{ (pad_choose) (download_selected_file) (params) = { (type) = (skaters) <pad_choose_params> } } 
			{ (pad_choose) (generic_menu_pad_choose_sound) } 
		] 
	} 
	<anchor_id> = <id> 
	IF (GotParam) (description) 
		<anchor_id> : (SetTags) (description) = <description> (is_male) = <is_male> 
	ELSE 
		<anchor_id> : (SetTags) (description) = "Description goes here... oops!" (is_male) = <is_male> 
	ENDIF 
	(net_vault_menu_add_text) (anchor_id) = <anchor_id> (text) = <name> (pos) = PAIR(0.00000000000, 0.00000000000) 
	(net_vault_menu_add_text) (anchor_id) = <anchor_id> (text) = <creator> (pos) = PAIR(220.00000000000, 0.00000000000) 
	IF ( <is_male> = 1 ) 
		(string) = "Male" 
	ELSE 
		(string) = "Female" 
	ENDIF 
	(net_vault_menu_add_text) (anchor_id) = <anchor_id> (text) = <string> (pos) = PAIR(445.00000000000, 0.00000000000) 
	IF (GotParam) (focus) 
		(net_vault_menu_add_text) (anchor_id) = <anchor_id> (text) = <focus> (pos) = PAIR(410.00000000000, 0.00000000000) 
	ENDIF 
	IF (GotParam) (downloads) 
		(FormatText) (TextName) = (downloads_string) "%i" (i) = <downloads> 
		(net_vault_menu_add_text) (anchor_id) = <anchor_id> (text) = <downloads_string> (pos) = PAIR(470.00000000000, 0.00000000000) 
	ENDIF 
ENDSCRIPT

SCRIPT (net_vault_menu_add_text) 
	(FormatText) (ChecksumName) = (rgba) "%i_UNHIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = <anchor_id> 
		(font) = (dialog) 
		(text) = <text> 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(scale) = 0.80000001192 
		(rgba) = <rgba> 
	} 
ENDSCRIPT

SCRIPT (net_vault_menu_focus) 
	(GetTags) 
	(FormatText) (ChecksumName) = (rgba) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(net_vault_menu_change_text_color) { 
		(id) = <id> 
		(rgba) = <rgba> 
	} 
	IF (GotParam) (description) 
		IF (ScreenElementExists) (id) = (description_text) 
			(SetScreenElementProps) (id) = (description_text) (text) = <description> 
		ENDIF 
	ENDIF 
	IF (GotParam) (score) 
		IF (ScreenElementExists) (id) = (score_text) 
			(FormatText) (TextName) = (score_string) "Score: %i" (i) = <score> 
			(SetScreenElementProps) (id) = (score_text) (text) = <score_string> 
		ENDIF 
	ENDIF 
	IF (GotParam) (num_goals) 
		IF (ScreenElementExists) (id) = (goal_text) 
			(FormatText) (TextName) = (string) "Goals: %i" (i) = <num_goals> 
			(SetScreenElementProps) (id) = (goal_text) (text) = <string> 
		ENDIF 
	ENDIF 
	IF (GotParam) (is_male) 
		IF (ScreenElementExists) (id) = (sex_text) 
			IF ( <is_male> = 1 ) 
				(SetScreenElementProps) (id) = (sex_text) (text) = "Male" 
			ELSE 
				(SetScreenElementProps) (id) = (sex_text) (text) = "Female" 
			ENDIF 
		ENDIF 
	ENDIF 
	IF (GotParam) (num_pieces) 
		IF (ScreenElementExists) (id) = (pieces_text) 
			(FormatText) (TextName) = (string) "Pieces: %i" (i) = <num_pieces> 
			(SetScreenElementProps) (id) = (pieces_text) (text) = <string> 
		ENDIF 
	ENDIF 
	IF (GotParam) (num_gaps) 
		IF (ScreenElementExists) (id) = (gap_text) 
			(FormatText) (TextName) = (string) "Gaps: %i" (i) = <num_gaps> 
			(SetScreenElementProps) (id) = (gap_text) (text) = <string> 
		ENDIF 
	ENDIF 
	IF (GotParam) (tod_script) 
		IF (ScreenElementExists) (id) = (tod_text) 
			SWITCH <tod_script> 
				CASE (set_tod_day) 
					(SetScreenElementProps) (id) = (tod_text) (text) = "Day" 
				CASE (set_tod_night) 
					(SetScreenElementProps) (id) = (tod_text) (text) = "Night" 
				CASE (set_tod_morning) 
					(SetScreenElementProps) (id) = (tod_text) (text) = "Morning" 
				CASE (set_tod_evening) 
					(SetScreenElementProps) (id) = (tod_text) (text) = "Evening" 
				CASE (set_tod_rain) 
					(SetScreenElementProps) (id) = (tod_text) (text) = "Rain" 
				CASE (set_tod_newrain) 
					(SetScreenElementProps) (id) = (tod_text) (text) = "New Rain" 
				CASE (set_tod_snow) 
					(SetScreenElementProps) (id) = (tod_text) (text) = "Snow" 
				CASE (default) 
					(SetScreenElementProps) (id) = (tod_text) (text) = "Default" 
			ENDSWITCH 
		ENDIF 
	ENDIF 
	IF (GotParam) (theme) 
		IF (ScreenElementExists) (id) = (theme_text) 
			SWITCH <theme> 
				CASE 0 
					(SetScreenElementProps) (id) = (theme_text) (text) = "Suburbia" 
				CASE 1 
					(SetScreenElementProps) (id) = (theme_text) (text) = "City Rooftop" 
				CASE 2 
					(SetScreenElementProps) (id) = (theme_text) (text) = "Lost Island" 
				CASE 3 
					(SetScreenElementProps) (id) = (theme_text) (text) = "Warehouse" 
				CASE 4 
					(SetScreenElementProps) (id) = (theme_text) (text) = "Prison Yard" 
			ENDSWITCH 
		ENDIF 
	ENDIF 
	(generic_menu_update_arrows) (menu_id) = (net_vault_vmenu) (up_arrow_id) = (net_vault_menu_up_arrow) (down_arrow_id) = (net_vault_menu_down_arrow) 
ENDSCRIPT

SCRIPT (net_vault_menu_change_text_color) 
	<child> = 0 
	BEGIN 
		IF (ScreenElementExists) (id) = { <id> (child) = <child> } 
			(SetScreenElementProps) (id) = { <id> (child) = <child> } (rgba) = <rgba> 
			(child) = ( <child> + 1 ) 
		ELSE 
			BREAK 
		ENDIF 
	REPEAT 
ENDSCRIPT

SCRIPT (net_vault_menu_unfocus) 
	(GetTags) 
	(FormatText) (ChecksumName) = (rgba) "%i_UNHIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(net_vault_menu_change_text_color) { 
		(id) = <id> 
		(rgba) = <rgba> 
	} 
ENDSCRIPT

SCRIPT (refresh_scrolling_menu) 
	(SetScreenElementLock) (id) = (net_vault_vmenu) (on) 
	(SetScreenElementLock) (id) = (net_vault_vmenu) (off) 
	(SetScreenElementLock) (id) = (net_vault_vscrollingmenu) (on) 
	(SetScreenElementLock) (id) = (net_vault_vscrollingmenu) (off) 
	(FireEvent) (type) = (focus) (target) = (current_menu) 
ENDSCRIPT

SCRIPT (clear_vault_focus_info) 
	IF (ScreenElementExists) (id) = (description_text) 
		(SetScreenElementProps) (id) = (description_text) (text) = "" 
	ENDIF 
	IF (ScreenElementExists) (id) = (score_text) 
		(SetScreenElementProps) (id) = (score_text) (text) = "" 
	ENDIF 
	IF (ScreenElementExists) (id) = (goal_text) 
		(SetScreenElementProps) (id) = (goal_text) (text) = "" 
	ENDIF 
	IF (ScreenElementExists) (id) = (sex_text) 
		(SetScreenElementProps) (id) = (sex_text) (text) = "" 
	ENDIF 
	IF (ScreenElementExists) (id) = (gap_text) 
		(SetScreenElementProps) (id) = (gap_text) (text) = "" 
	ENDIF 
	IF (ScreenElementExists) (id) = (pieces_text) 
		(SetScreenElementProps) (id) = (pieces_text) (text) = "" 
	ENDIF 
	IF (ScreenElementExists) (id) = (theme_text) 
		(SetScreenElementProps) (id) = (theme_text) (text) = "" 
	ENDIF 
	IF (ScreenElementExists) (id) = (tod_text) 
		(SetScreenElementProps) (id) = (tod_text) (text) = "" 
	ENDIF 
ENDSCRIPT

SCRIPT (net_vault_menu_prev_category) 
	(printf) "********** net_vault_menu_prev_category" 
	(DestroyScreenElement) (id) = (net_vault_vmenu) (preserve_parent) 
	(clear_vault_focus_info) 
	(PrevVaultCategory) 
	(FillVaultMenu) 
	(menu_horiz_blink_arrow) (arrow_id) = (net_vault_menu_left_arrow) 
	(net_vault_menu_refresh_category) <...> 
	(refresh_scrolling_menu) 
ENDSCRIPT

SCRIPT (net_vault_menu_next_category) 
	(printf) "********** net_vault_menu_next_category" 
	(DestroyScreenElement) (id) = (net_vault_vmenu) (preserve_parent) 
	(clear_vault_focus_info) 
	(NextVaultCategory) 
	(FillVaultMenu) 
	(menu_horiz_blink_arrow) (arrow_id) = (net_vault_menu_right_arrow) 
	(net_vault_menu_refresh_category) <...> 
	(refresh_scrolling_menu) 
ENDSCRIPT

SCRIPT (net_vault_menu_refresh_category) 
	IF ( <category> = "Best" ) 
		(text) = "Best of the Best" 
		(rgba) = (best_green) 
		(star_alpha) = 1 
	ELSE 
		(text) = <category> 
		(FormatText) (ChecksumName) = (on_rgba) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
		(rgba) = <on_rgba> 
		(star_alpha) = 0 
	ENDIF 
	(SetScreenElementProps) { 
		(id) = (net_vault_menu_category) 
		(text) = <text> 
		(rgba) = <rgba> 
	} 
	(GetStackedScreenElementPos) (X) (id) = (net_vault_menu_category) (offset) = PAIR(5.00000000000, 13.00000000000) 
	(SetScreenElementProps) { 
		(id) = (net_vault_menu_right_arrow) 
		(pos) = <pos> 
	} 
	(DoScreenElementMorph) { 
		(id) = (best_star) 
		(alpha) = <star_alpha> 
	} 
	(SetScreenElementProps) { 
		(id) = (net_vault_vmenu) 
		(event_handlers) = [ { (pad_left) (net_vault_menu_prev_category) } 
			{ (pad_right) (net_vault_menu_next_category) } 
		] (replace_handlers) 
	} 
ENDSCRIPT

SCRIPT (back_from_vault) 
	(net_vault_menu_exit) 
	(create_internet_options) 
ENDSCRIPT

SCRIPT (net_vault_menu_exit) 
	(FreeDirectoryListing) 
	(SetScreenElementLock) (id) = (root_window) (off) 
	IF (ScreenElementExists) (id) = (vault_bg_anchor) 
		(DestroyScreenElement) (id) = (vault_bg_anchor) 
	ENDIF 
	IF (ObjectExists) (id) = (current_menu_anchor) 
		(DestroyScreenElement) (id) = (current_menu_anchor) 
		(wait) 1 (gameframe) 
		(SetScreenElementLock) (id) = (root_window) (off) 
	ENDIF 
ENDSCRIPT


