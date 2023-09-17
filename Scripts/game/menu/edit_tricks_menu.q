
(edit_tricks_menu_1_index) = 0 
(edit_tricks_menu_2_index) = 0 
(loading_cat_from_edit_tricks) = 0 
SCRIPT (create_edit_tricks_menu) 
	(pulse_blur) 
	(hide_current_goal) 
	IF (ScreenElementExists) (id) = (edit_tricks_menu_parts_anchor) 
		(DestroyScreenElement) (id) = (edit_tricks_menu_parts_anchor) 
	ENDIF 
	(change) (loading_cat_from_edit_tricks) = 0 
	(dialog_box_exit) 
	(FormatText) (ChecksumName) = (title_icon) "%i_trick" (i) = ( (THEME_PREFIXES) [ (current_theme_prefix) ] ) 
	<firefight_active> = 0 
	IF (GoalManager_GoalExists) (name) = (firefight) 
		IF (GoalManager_GoalIsActive) (name) = (firefight) 
			<firefight_active> = 1 
		ENDIF 
	ENDIF 
	IF ( <firefight_active> = 1 ) 
		(make_new_themed_sub_menu) (title) = "VIEW TRICKS" (title_icon) = <title_icon> 
	ELSE 
		IF (GoalManager_HasActiveGoals) 
			(make_new_themed_sub_menu) (title) = "VIEW TRICKS" (title_icon) = <title_icon> 
		ELSE 
			<trick_attack_active> = 0 
			IF (GoalManager_GoalExists) (name) = (trickattack) 
				IF (GoalManager_GoalIsActive) (name) = (trickattack) 
					<trick_attack_active> = 1 
				ENDIF 
			ENDIF 
			IF ( <trick_attack_active> = 1 ) 
				(make_new_themed_sub_menu) (title) = "VIEW TRICKS" (title_icon) = <title_icon> 
			ELSE 
				(make_new_themed_sub_menu) (title) = "EDIT TRICKS" (title_icon) = <title_icon> 
			ENDIF 
		ENDIF 
	ENDIF 
	IF NOT (LevelIs) (load_skateshop) 
		(PauseMusicAndStreams) 1 
		(pause_menu_gradient) (on) 
	ELSE 
	ENDIF 
	IF (GotParam) (from_ss_menu) 
		(SetScreenElementProps) { 
			(id) = (sub_menu) 
			(event_handlers) = [ { (pad_back) (generic_menu_pad_back) (params) = { (callback) = (edit_tricks_menu_exit) (from_ss_menu) } } 
			] 
			(replace_handlers) 
		} 
	ELSE 
		(SetScreenElementProps) { 
			(id) = (sub_menu) 
			(event_handlers) = [ { (pad_back) (generic_menu_pad_back) (params) = { (callback) = (edit_tricks_menu_exit) } } 
			] 
			(replace_handlers) 
		} 
	ENDIF 
	(theme_menu_add_item) { 
		(first_item) 
		(text) = "Grab Tricks" 
		(pad_choose_script) = (create_edit_tricks_sub_menu) 
		(pad_choose_params) = { (type) = (grab_tricks) } 
		(centered) = 1 
	} 
	(theme_menu_add_item) { 
		(text) = "Flip Tricks" 
		(pad_choose_script) = (create_edit_tricks_sub_menu) 
		(pad_choose_params) = { (type) = (flip_tricks) } 
		(centered) = 1 
	} 
	(theme_menu_add_item) { 
		(text) = "Lip Tricks" 
		(pad_choose_script) = (create_edit_tricks_sub_menu) 
		(pad_choose_params) = { (type) = (lip_tricks) } 
		(centered) = 1 
	} 
	(theme_menu_add_item) { 
		(text) = "Special Tricks" 
		(pad_choose_script) = (create_edit_tricks_sub_menu) 
		(pad_choose_params) = { (type) = (special_tricks) } 
		(centered) = 1 
	} 
	IF NOT (InNetGame) 
		<has_active_goals> = 0 
		IF (GoalManager_HasActiveGoals) 
			<has_active_goals> = 1 
		ELSE 
			IF (GoalManager_GoalExists) (name) = (trickattack) 
				IF (GoalManager_GoalIsActive) (name) = (trickattack) 
					<has_active_goals> = 1 
				ENDIF 
			ENDIF 
		ENDIF 
		IF NOT ( <has_active_goals> = 1 ) 
			(theme_menu_add_item) { 
				(centered) = 1 
				(text) = "Load Created Trick" 
				(pad_choose_script) = (launch_load_cat_sequence2) 
				(pad_choose_params) = { } 
			} 
		ENDIF 
	ENDIF 
	IF (GotParam) (from_ss_menu) 
		(theme_menu_add_item) { 
			(text) = "Done" 
			(pad_choose_script) = (edit_tricks_menu_exit) 
			(pad_choose_params) = { (from_ss_menu) } 
			(last_item) 
			(centered) = 1 
			(last_menu_item) = 1 
		} 
	ELSE 
		(theme_menu_add_item) { 
			(text) = "Done" 
			(pad_choose_script) = (edit_tricks_menu_exit) 
			(last_item) 
			(centered) = 1 
			(last_menu_item) = 1 
		} 
	ENDIF 
	(finish_themed_sub_menu) 
	IF (LevelIs) (load_skateshop) 
		(CreateScreenElement) { 
			(type) = (SpriteElement) 
			(parent) = (current_menu_anchor) 
			(id) = (so_rotating_bg) 
			(texture) = (bg_vector_1) 
			(rgba) = [ 23 58 75 15 ] 
			(just) = [ (center) , (center) ] 
			(pos) = PAIR(210, 180) 
			(z_priority) = -4 
		} 
		(CreateScreenElement) { 
			(type) = (SpriteElement) 
			(parent) = (current_menu_anchor) 
			(id) = (so_rotating_bg2) 
			(texture) = (bg_vector_1) 
			(rgba) = [ 100 25 3 15 ] 
			(just) = [ (center) , (center) ] 
			(pos) = PAIR(210, 180) 
			(z_priority) = -3 
		} 
		(spawnscript) (chap_new_rotating_bg) (params) = { (id) = (so_rotating_bg) (scale) = 1.39999997616 (rot_angle) = -5752 } 
		(spawnscript) (chap_new_rotating_bg_2) (params) = { (id) = (so_rotating_bg2) (scale) = 1.10000002384 (rot_angle) = -5752 } 
	ENDIF 
ENDSCRIPT

SCRIPT (create_edit_tricks_sub_menu) 
	(pulse_blur) 
	IF (ObjectExists) (id) = (current_menu_anchor) 
		(DestroyScreenElement) (id) = (current_menu_anchor) 
	ENDIF 
	(GoalManager_HidePoints) 
	(GoalManager_HideGoalPoints) 
	(SetScreenElementLock) (id) = (root_window) (off) 
	SWITCH <type> 
		CASE (grab_tricks) 
			<title> = "GRAB TRICKS" 
			<icon_texture> = (pa_grab) 
			<key_combo_array> = (edit_tricks_menu_grab_key_combos) 
			<trick_type> = (GrabTrick) 
			<vertical_bar_offset> = PAIR(75.00000000000, 17.00000000000) 
			<key_combo_highlight_bar_scale> = PAIR(3.90000009537, 0.69999998808) 
			<key_combo_highlight_bar_pos> = PAIR(140.00000000000, -10.00000000000) 
			<key_combo_short_highlight_bar_scale> = PAIR(1.00000000000, 0.69999998808) 
			<key_combo_short_highlight_bar_pos> = PAIR(-42.00000000000, -10.00000000000) 
			<trick_highlight_bar_scale> = PAIR(2.90000009537, 0.69999998808) 
			(FormatText) (ChecksumName) = (title_icon) "%i_grab" (i) = ( (THEME_PREFIXES) [ (current_theme_prefix) ] ) 
		CASE (flip_tricks) 
			<title> = "FLIP TRICKS" 
			<icon_texture> = (pa_flip) 
			<key_combo_array> = (edit_tricks_menu_flip_key_combos) 
			<trick_type> = (FlipTrick) 
			<vertical_bar_offset> = PAIR(75.00000000000, 17.00000000000) 
			<key_combo_highlight_bar_scale> = PAIR(3.90000009537, 0.69999998808) 
			<key_combo_highlight_bar_pos> = PAIR(140.00000000000, -10.00000000000) 
			<key_combo_short_highlight_bar_scale> = PAIR(1.00000000000, 0.69999998808) 
			<key_combo_short_highlight_bar_pos> = PAIR(-42.00000000000, -10.00000000000) 
			<trick_highlight_bar_scale> = PAIR(2.90000009537, 0.69999998808) 
			(FormatText) (ChecksumName) = (title_icon) "%i_flip" (i) = ( (THEME_PREFIXES) [ (current_theme_prefix) ] ) 
		CASE (lip_tricks) 
			<title> = "LIP TRICKS" 
			<icon_texture> = (pa_lip) 
			<key_combo_array> = (edit_tricks_menu_lip_key_combos) 
			<trick_type> = (LipMacro2) 
			<vertical_bar_offset> = PAIR(75.00000000000, 17.00000000000) 
			<key_combo_highlight_bar_scale> = PAIR(3.90000009537, 0.69999998808) 
			<key_combo_highlight_bar_pos> = PAIR(140.00000000000, -10.00000000000) 
			<key_combo_short_highlight_bar_scale> = PAIR(1.00000000000, 0.69999998808) 
			<key_combo_short_highlight_bar_pos> = PAIR(-42.00000000000, -10.00000000000) 
			<trick_highlight_bar_scale> = PAIR(2.90000009537, 0.69999998808) 
			(FormatText) (ChecksumName) = (title_icon) "%i_lip" (i) = ( (THEME_PREFIXES) [ (current_theme_prefix) ] ) 
		CASE (special_tricks) 
			<title> = "SPECIAL TRICKS" 
			<icon_texture> = (pa_special) 
			<vertical_bar_offset> = PAIR(30.00000000000, 17.00000000000) 
			<trick_type> = (special_tricks) 
			(FormatText) (ChecksumName) = (title_icon) "%i_special" (i) = ( (THEME_PREFIXES) [ (current_theme_prefix) ] ) 
	ENDSWITCH 
	(CreateScreenElement) { 
		(type) = (ContainerElement) 
		(parent) = (root_window) 
		(id) = (edit_tricks_sub_menu_anchor) 
		(dims) = PAIR(640.00000000000, 480.00000000000) 
		(pos) = PAIR(320.00000000000, 240.00000000000) 
	} 
	(AssignAlias) (id) = (edit_tricks_sub_menu_anchor) (alias) = (current_menu_anchor) 
	<firefight_active> = 0 
	IF (GoalManager_GoalExists) (name) = (firefight) 
		IF (GoalManager_GoalIsActive) (name) = (firefight) 
			<firefight_active> = 1 
		ENDIF 
	ENDIF 
	IF ( <firefight_active> = 1 ) 
		(create_helper_text) (generic_helper_text_no_accept) 
	ELSE 
		IF (GoalManager_HasActiveGoals) 
			(create_helper_text) (generic_helper_text_no_accept) 
		ELSE 
			<trick_attack_active> = 0 
			IF (GoalManager_GoalExists) (name) = (trickattack) 
				IF (GoalManager_GoalIsActive) (name) = (trickattack) 
					<trick_attack_active> = 1 
				ENDIF 
			ENDIF 
			IF ( <trick_attack_active> = 1 ) 
				(create_helper_text) (generic_helper_text_no_accept) 
			ELSE 
				(create_helper_text) (generic_helper_text) 
			ENDIF 
		ENDIF 
	ENDIF 
	(build_theme_sub_title) (title) = <title> (title_icon) = <title_icon> 
	IF (LevelIs) (load_skateshop) 
		(CreateScreenElement) { 
			(type) = (SpriteElement) 
			(parent) = (current_menu_anchor) 
			(id) = (so_rotating_bg) 
			(texture) = (bg_vector_1) 
			(rgba) = [ 23 58 75 15 ] 
			(just) = [ (center) , (center) ] 
			(pos) = PAIR(210.00000000000, 180.00000000000) 
			(z_priority) = -4 
		} 
		(CreateScreenElement) { 
			(type) = (SpriteElement) 
			(parent) = (current_menu_anchor) 
			(id) = (so_rotating_bg2) 
			(texture) = (bg_vector_1) 
			(rgba) = [ 100 25 3 15 ] 
			(just) = [ (center) , (center) ] 
			(pos) = PAIR(210.00000000000, 180.00000000000) 
			(z_priority) = -3 
		} 
		(spawnscript) (chap_new_rotating_bg) (params) = { (id) = (so_rotating_bg) (scale) = 1.39999997616 (rot_angle) = -5752 } 
		(spawnscript) (chap_new_rotating_bg_2) (params) = { (id) = (so_rotating_bg2) (scale) = 1.10000002384 (rot_angle) = -5752 } 
	ENDIF 
	(CreateScreenElement) { 
		(type) = (ContainerElement) 
		(parent) = (edit_tricks_sub_menu_anchor) 
		(id) = (edit_tricks_menu_parts_anchor) 
		(dims) = PAIR(640.00000000000, 480.00000000000) 
		(pos) = PAIR(320.00000000000, 840.00000000000) 
	} 
	IF (LevelIs) (load_skateshop) 
		(build_top_and_bottom_blocks) 
		(make_mainmenu_3d_plane) 
		<root_pos> = PAIR(40.00000000000, -2.00000000000) 
		(theme_background) (width) = 6 (pos) = PAIR(320.00000000000, 63.00000000000) (num_parts) = 10.50000000000 (parent) = (edit_tricks_menu_parts_anchor) 
	ELSE 
		(FormatText) (ChecksumName) = (paused_icon) "%i_paused_icon" (i) = ( (THEME_PREFIXES) [ (current_theme_prefix) ] ) 
		(build_theme_box_icons) (icon_texture) = <paused_icon> 
		(build_grunge_piece) 
		(build_top_bar) (pos) = PAIR(0.00000000000, 62.00000000000) 
		<root_pos> = PAIR(40.00000000000, 20.00000000000) 
		(theme_background) (width) = 6 (pos) = PAIR(320.00000000000, 85.00000000000) (num_parts) = 10.50000000000 (parent) = (edit_tricks_menu_parts_anchor) 
	ENDIF 
	(AssignAlias) (id) = (edit_tricks_menu_parts_anchor) (alias) = (current_menu_anchor) 
	(CreateScreenElement) { 
		(type) = (ContainerElement) 
		(parent) = (current_menu_anchor) 
		(id) = (edit_tricks_sub_menu_title) 
		(pos) = ( <root_pos> + PAIR(80.00000000000, 70.00000000000) ) 
	} 
	(GetStackedScreenElementPos) (Y) (id) = <id> (offset) = PAIR(-53.00000000000, -5.00000000000) 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (current_menu_anchor) 
		(texture) = (black) 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(scale) = PAIR(126.00000000000, 7.00000000000) 
		(rgba) = [ 0 0 0 128 ] 
		(z_priority) = 2 
	} 
	(GetStackedScreenElementPos) (Y) (id) = (edit_tricks_sub_menu_title) (offset) = PAIR(60.00000000000, 42.00000000000) 
	(CreateScreenElement) { 
		(type) = (VMenu) 
		(parent) = (current_menu_anchor) 
		(id) = (edit_tricks_menu_1) 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(event_handlers) = [ { (pad_back) (generic_menu_pad_back) (params) = { (callback) = (edit_tricks_sub_menu_exit) } } 
			{ (pad_up) (generic_menu_up_or_down_sound) (params) = { (up) } } 
			{ (pad_down) (generic_menu_up_or_down_sound) (params) = { (down) } } 
			{ (pad_back) (generic_menu_pad_back_sound) } 
			{ (focus) (edit_tricks_menu_create_current_mapping_list) (params) = { (key_combo_array) = <key_combo_array> (type) = <type> } } 
			{ (unfocus) (edit_tricks_menu_destroy_current_mapping_list) } 
		] 
		(dont_allow_wrap) 
	} 
	(GetStackedScreenElementPos) (Y) (id) = (edit_tricks_sub_menu_title) (offset) = <vertical_bar_offset> 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (current_menu_anchor) 
		(id) = (edit_tricks_menu_vertical_bar) 
		(texture) = (black) 
		(rgba) = [ 0 0 0 128 ] 
		(scale) = PAIR(2.00000000000, 70.00000000000) 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(z_priority) = 4 
	} 
	<vertical_bar_id> = <id> 
	(GetStackedScreenElementPos) (X) (id) = <vertical_bar_id> (offset) = PAIR(8.00000000000, 24.00000000000) 
	(CreateScreenElement) { 
		(type) = (VScrollingMenu) 
		(parent) = (current_menu_anchor) 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(dims) = PAIR(400.00000000000, 240.00000000000) 
		(internal_just) = [ (left) (top) ] 
	} 
	<vscrolling_menu_id> = <id> 
	(CreateScreenElement) { 
		(type) = (VMenu) 
		(parent) = <vscrolling_menu_id> 
		(id) = (edit_tricks_menu_2) 
		(pos) = PAIR(0.00000000000, 0.00000000000) 
		(just) = [ (left) (top) ] 
		(dont_allow_wrap) 
		(event_handlers) = [ { (focus) (edit_tricks_menu_show_on_focus) } 
			{ (unfocus) (edit_tricks_menu_hide_on_unfocus) (params) = <unfocus_params> } 
			{ (pad_back) (edit_tricks_menu_back_from_trick_list) } 
			{ (pad_up) (set_which_arrow) (params) = { (arrow) = (edit_tricks_menu_up_arrow) } } 
			{ (pad_down) (set_which_arrow) (params) = { (arrow) = (edit_tricks_menu_down_arrow) } } 
			{ (pad_up) (generic_menu_up_or_down_sound) (params) = { (up) } } 
			{ (pad_down) (generic_menu_up_or_down_sound) (params) = { (down) } } 
			{ (pad_back) (generic_menu_pad_back_sound) } 
		] 
	} 
	(edit_tricks_menu_2) : (SetTags) (scrolling_parent) = <vscrolling_menu_id> 
	IF ( <trick_type> = (special_tricks) ) 
		(create_special_tricks_menu) 
		RETURN 
	ENDIF 
	(GetStackedScreenElementPos) (X) (id) = <vertical_bar_id> (offset) = PAIR(48.00000000000, 5.00000000000) 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (current_menu_anchor) 
		(id) = (edit_tricks_menu_up_arrow) 
		(texture) = (up_arrow) 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(scale) = 0.89999997616 
		(rgba) = [ 128 128 128 0 ] 
		(z_priority) = 3 
	} 
	(GetStackedScreenElementPos) (Y) (id) = <id> (offset) = PAIR(0.00000000000, 245.00000000000) 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (current_menu_anchor) 
		(id) = (edit_tricks_menu_down_arrow) 
		(texture) = (down_arrow) 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(scale) = 0.89999997616 
		(rgba) = [ 128 128 128 0 ] 
		(z_priority) = 4 
	} 
	(FormatText) (ChecksumName) = (text_rgba) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(GetStackedScreenElementPos) (Y) (id) = (edit_tricks_sub_menu_title) (offset) = PAIR(-7.00000000000, -2.00000000000) 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (current_menu_anchor) 
		(font) = (dialog) 
		(text) = "Combo" 
		(scale) = 0.89999997616 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(rgba) = <text_rgba> 
		(z_priority) = 3 
	} 
	IF ( <type> = (lip_tricks) ) 
		<tap_info_text> = "Trick" 
	ELSE 
		<tap_info_text> = "Single tap / Double tap" 
	ENDIF 
	(GetStackedScreenElementPos) (X) (id) = <vertical_bar_id> (offset) = PAIR(5.00000000000, -18.00000000000) 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (current_menu_anchor) 
		(id) = (double_tap_info) 
		(font) = (dialog) 
		(text) = <tap_info_text> 
		(rgba) = <text_rgba> 
		(pos) = <pos> 
		(scale) = 0.89999997616 
		(just) = [ (left) (top) ] 
		(z_priority) = 3 
	} 
	IF (GotParam) (key_combo_array) 
		(GetArraySize) <key_combo_array> 
		<index> = 0 
		BEGIN 
			(edit_tricks_sub_menu_add_key_combo) { 
				(key_combo) = ( <key_combo_array> [ <index> ] ) 
				(highlight_bar_scale) = <key_combo_highlight_bar_scale> 
				(short_highlight_bar_scale) = <key_combo_short_highlight_bar_scale> 
				(highlight_bar_pos) = <key_combo_highlight_bar_pos> 
				(short_highlight_bar_pos) = <key_combo_short_highlight_bar_pos> 
			} 
			<index> = ( <index> + 1 ) 
		REPEAT <array_size> 
	ENDIF 
	IF (GotParam) (trick_type) 
		IF (GetConfigurableTricksFromType) (type) = <trick_type> <special> 
			IF (GotParam) (ConfigurableCats) 
				(GetArraySize) <ConfigurableCats> 
				IF ( <array_size> = 0 ) 
					(RemoveParameter) (ConfigurableCats) 
				ENDIF 
			ENDIF 
			(GetArraySize) <ConfigurableTricks> 
			<index> = 0 
			IF ( <array_size> > 0 ) 
				BEGIN 
					<trick_name> = ( <ConfigurableTricks> [ <index> ] ) 
					IF NOT (TrickIsLocked) (trick) = <trick_name> 
						(RemoveParameter) (extra_trick_string) 
						(GetTrickDisplayText) (trick) = <trick_name> 
						IF NOT ( <type> = (lip_tricks) ) 
							IF (GotParam) (extra_trick_string) 
								(FormatText) (TextName) = (trick_display_text) "%f / %s" (f) = <trick_display_text> (s) = <extra_trick_string> 
							ENDIF 
						ENDIF 
						IF ( <index> = ( <array_size> - 1 ) ) 
							IF NOT (GotParam) (ConfigurableCats) 
								(edit_tricks_sub_menu_add_trick) { 
									(text) = <trick_display_text> 
									(trick) = <trick_name> 
									(focus_params) = { (last_item) (highlight_bar_scale) = <trick_highlight_bar_scale> } 
									(pad_choose_params) = { (new_trick) = <trick_name> (callback) = (edit_tricks_menu_back_from_trick_list) } 
								} 
							ELSE 
								(edit_tricks_sub_menu_add_trick) { 
									(text) = <trick_display_text> 
									(trick) = <trick_name> 
									(focus_params) = { (highlight_bar_scale) = <trick_highlight_bar_scale> } 
									(pad_choose_params) = { (new_trick) = <trick_name> (callback) = (edit_tricks_menu_back_from_trick_list) } 
								} 
							ENDIF 
						ELSE 
							IF ( <index> = 0 ) 
								(edit_tricks_sub_menu_add_trick) { 
									(text) = <trick_display_text> 
									(trick) = <trick_name> 
									(focus_params) = { (first_item) (highlight_bar_scale) = <trick_highlight_bar_scale> } 
									(pad_choose_params) = { (new_trick) = <trick_name> (callback) = (edit_tricks_menu_back_from_trick_list) } 
								} 
							ELSE 
								(edit_tricks_sub_menu_add_trick) { 
									(text) = <trick_display_text> 
									(trick) = <trick_name> 
									(focus_params) = { (highlight_bar_scale) = <trick_highlight_bar_scale> } 
									(pad_choose_params) = { (new_trick) = <trick_name> (callback) = (edit_tricks_menu_back_from_trick_list) } 
								} 
							ENDIF 
						ENDIF 
						<index> = ( <index> + 1 ) 
					ENDIF 
				REPEAT <array_size> 
				IF (GotParam) (ConfigurableCats) 
					(GetArraySize) <ConfigurableCats> 
					IF ( <array_size> > 0 ) 
						(edit_tricks_sub_menu_add_header) { 
							(text) = "Created Tricks" 
						} 
						(index) = 0 
						BEGIN 
							<cat_num> = ( <ConfigurableCats> [ <index> ] ) 
							(get_CAT_other_param_values) (trick_index) = <cat_num> 
							IF (GotParam) (name) 
								(printf) "name = %n" (n) = <name> 
							ELSE 
								(name) = "didn\'t get name" 
							ENDIF 
							(trick_display_text) = <name> 
							IF ( <index> = ( <array_size> - 1 ) ) 
								(edit_tricks_sub_menu_add_trick) { 
									(text) = <trick_display_text> 
									(trick) = <trick_display_text> 
									(focus_params) = { (last_item) (highlight_bar_scale) = <trick_highlight_bar_scale> } 
									(pad_choose_params) = { (new_trick) = <cat_num> (createdtrick) (callback) = (edit_tricks_menu_back_from_trick_list) } 
								} 
							ELSE 
								(edit_tricks_sub_menu_add_trick) { 
									(text) = <trick_display_text> 
									(trick) = <trick_display_text> 
									(focus_params) = { (highlight_bar_scale) = <trick_highlight_bar_scale> } 
									(pad_choose_params) = { (new_trick) = <cat_num> (createdtrick) (callback) = (edit_tricks_menu_back_from_trick_list) } 
								} 
							ENDIF 
							<index> = ( <index> + 1 ) 
						REPEAT <array_size> 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
		(SetScreenElementLock) (id) = (edit_tricks_menu_2) (on) 
		(SetScreenElementLock) (id) = (edit_tricks_menu_2) (off) 
		(FireEvent) (type) = (focus) (target) = (edit_tricks_menu_2) 
		(FireEvent) (type) = (unfocus) (target) = (edit_tricks_menu_2) 
		(edit_tricks_menu_back_from_trick_list) 
	ENDIF 
	(DoScreenElementMorph) (id) = (edit_tricks_menu_parts_anchor) (pos) = PAIR(320.00000000000, 240.00000000000) (time) = 0.20000000298 
	(AssignAlias) (id) = (edit_tricks_sub_menu_anchor) (alias) = (current_menu_anchor) 
	(FireEvent) (type) = (focus) (target) = (edit_tricks_menu_1) 
ENDSCRIPT

SCRIPT (create_special_tricks_menu) 
	(special_tricks_menu_fill_trick_list) 
	(FireEvent) (type) = (unfocus) (target) = (edit_tricks_menu_2) 
	(SetScreenElementProps) { 
		(id) = (edit_tricks_menu_1) 
		(event_handlers) = [ { (focus) (edit_tricks_menu_special_tricks_focus) } ] 
		(replace_handlers) 
	} 
	(GetCurrentSkaterProfileIndex) 
	(GetSkaterProfileInfo) (player) = <currentSkaterProfileIndex> 
	<index> = 1 
	BEGIN 
		(special_tricks_menu_add_slot) (index) = <index> 
		<index> = ( <index> + 1 ) 
	REPEAT <max_specials> 
	(FormatText) (ChecksumName) = (text_rgba) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(GetStackedScreenElementPos) (Y) (id) = (edit_tricks_sub_menu_title) (offset) = PAIR(40.00000000000, 0.00000000000) 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (edit_tricks_menu_parts_anchor) 
		(font) = (dialog) 
		(text) = "Trick" 
		(scale) = 0.89999997616 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(rgba) = <text_rgba> 
		(z_priority) = 3 
	} 
	(GetStackedScreenElementPos) (X) (id) = <id> (offset) = PAIR(260.00000000000, 0.00000000000) 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (edit_tricks_menu_parts_anchor) 
		(font) = (dialog) 
		(text) = "Combo" 
		(scale) = 0.89999997616 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(rgba) = <text_rgba> 
		(z_priority) = 3 
	} 
	(GetStackedScreenElementPos) (X) (id) = (edit_tricks_menu_vertical_bar) (offset) = PAIR(50.00000000000, 5.00000000000) 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (edit_tricks_menu_parts_anchor) 
		(id) = (edit_tricks_menu_up_arrow) 
		(texture) = (up_arrow) 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(scale) = 0.89999997616 
		(rgba) = [ 128 128 128 0 ] 
		(z_priority) = 3 
	} 
	(GetStackedScreenElementPos) (Y) (id) = <id> (offset) = PAIR(0.00000000000, 247.00000000000) 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (edit_tricks_menu_parts_anchor) 
		(id) = (edit_tricks_menu_down_arrow) 
		(texture) = (down_arrow) 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(scale) = 0.89999997616 
		(rgba) = [ 128 128 128 0 ] 
		(z_priority) = 4 
	} 
	(GetStackedScreenElementPos) (X) (id) = (edit_tricks_menu_vertical_bar) (offset) = PAIR(280.00000000000, 0.00000000000) 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (edit_tricks_menu_parts_anchor) 
		(id) = (special_tricks_menu_second_vertical_bar) 
		(texture) = (black) 
		(rgba) = [ 0 0 0 128 ] 
		(scale) = PAIR(2.00000000000, 70.00000000000) 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(z_priority) = 9 
	} 
	(special_tricks_menu_create_menu_3) 
	(DoScreenElementMorph) (id) = (edit_tricks_menu_parts_anchor) (pos) = PAIR(320.00000000000, 240.00000000000) (time) = 0.20000000298 
	(AssignAlias) (id) = (edit_tricks_sub_menu_anchor) (alias) = (current_menu_anchor) 
	(FireEvent) (type) = (focus) (target) = (edit_tricks_menu_1) 
ENDSCRIPT

SCRIPT (special_tricks_menu_create_menu_3) 
	(SetScreenElementLock) (id) = (current_menu_anchor) (off) 
	IF (ObjectExists) (id) = (special_tricks_menu_key_combo_up_arrow) 
		(DestroyScreenElement) (id) = (special_tricks_menu_key_combo_up_arrow) 
	ENDIF 
	IF (ObjectExists) (id) = (special_tricks_menu_key_combo_down_arrow) 
		(DestroyScreenElement) (id) = (special_tricks_menu_key_combo_down_arrow) 
	ENDIF 
	(GetStackedScreenElementPos) (X) (id) = (special_tricks_menu_second_vertical_bar) (offset) = PAIR(35.00000000000, 5.00000000000) 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (edit_tricks_menu_parts_anchor) 
		(id) = (special_tricks_menu_key_combo_up_arrow) 
		(texture) = (up_arrow) 
		(scale) = 0.89999997616 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(rgba) = [ 128 128 128 0 ] 
	} 
	(GetStackedScreenElementPos) (Y) (id) = (special_tricks_menu_key_combo_up_arrow) (offset) = PAIR(65.00000000000, 13.00000000000) 
	(CreateScreenElement) { 
		(type) = (VScrollingMenu) 
		(parent) = (current_menu_anchor) 
		(id) = (edit_tricks_menu_3_parent) 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(dims) = PAIR(300.00000000000, 244.00000000000) 
		(internal_just) = [ (left) (top) ] 
	} 
	(CreateScreenElement) { 
		(type) = (VMenu) 
		(parent) = <id> 
		(id) = (edit_tricks_menu_3) 
		(just) = [ (left) (top) ] 
		(event_handlers) = [ { (focus) (edit_tricks_menu_show_on_focus) } 
			{ (unfocus) (edit_tricks_menu_hide_on_unfocus) } 
			{ (pad_back) (special_tricks_menu_goto_trick_list) } 
			{ (pad_up) (set_which_arrow) (params) = { (arrow) = (special_tricks_menu_key_combo_up_arrow) } } 
			{ (pad_down) (set_which_arrow) (params) = { (arrow) = (special_tricks_menu_key_combo_down_arrow) } } 
			{ (pad_up) (generic_menu_up_or_down_sound) (params) = { (up) } } 
			{ (pad_down) (generic_menu_up_or_down_sound) (params) = { (down) } } 
			{ (pad_back) (generic_menu_pad_back_sound) } 
		] 
		(dont_allow_wrap) 
	} 
	(GetStackedScreenElementPos) (Y) (id) = (special_tricks_menu_key_combo_up_arrow) (offset) = PAIR(0.00000000000, 245.00000000000) 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (current_menu_anchor) 
		(id) = (special_tricks_menu_key_combo_down_arrow) 
		(texture) = (down_arrow) 
		(scale) = 0.89999997616 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(rgba) = [ 128 128 128 0 ] 
	} 
ENDSCRIPT

SCRIPT (special_tricks_menu_create_current_mapping_list) 
	(printf) "special_tricks_menu_create_current_mapping_list" 
	IF (ScreenElementExists) (id) = (special_tricks_current_mapping) 
		(DestroyScreenElement) (id) = (special_tricks_current_mapping) 
	ENDIF 
	(FireEvent) (type) = (unfocus) (target) = (edit_tricks_menu_3) 
	(SetScreenElementLock) (id) = (edit_tricks_menu_parts_anchor) (off) 
	(GetStackedScreenElementPos) (X) (id) = (edit_tricks_menu_vertical_bar) (offset) = PAIR(0.00000000000, 10.00000000000) 
	(CreateScreenElement) { 
		(type) = (VMenu) 
		(parent) = (edit_tricks_menu_parts_anchor) 
		(id) = (special_tricks_current_mapping) 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
	} 
	(GetCurrentSkaterProfileIndex) 
	(GetSkaterProfileInfo) (player) = <currentSkaterProfileIndex> 
	<index> = 0 
	BEGIN 
		(special_tricks_menu_add_special_to_mapping) (index) = <index> 
		<index> = ( <index> + 1 ) 
	REPEAT <max_specials> 
	(edit_tricks_menu_assign_current_menu_alias) 
ENDSCRIPT

SCRIPT (edit_tricks_menu_create_current_mapping_list) 
	IF (ObjectExists) (id) = (edit_tricks_menu_current_mapping) 
		(DestroyScreenElement) (id) = (edit_tricks_menu_current_mapping) 
	ENDIF 
	(FormatText) (ChecksumName) = (text_rgba) "%i_UNHIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(SetScreenElementLock) (id) = (edit_tricks_menu_parts_anchor) (off) 
	(GetStackedScreenElementPos) (X) (id) = (edit_tricks_menu_vertical_bar) (offset) = PAIR(10.00000000000, 27.00000000000) 
	(CreateScreenElement) { 
		(type) = (VMenu) 
		(parent) = (edit_tricks_menu_parts_anchor) 
		(id) = (edit_tricks_menu_current_mapping) 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
	} 
	IF (GotParam) (key_combo_array) 
		(GetArraySize) <key_combo_array> 
		<index> = 0 
		BEGIN 
			(CreateScreenElement) { 
				(type) = (ContainerElement) 
				(parent) = (edit_tricks_menu_current_mapping) 
				(dims) = PAIR(100.00000000000, 22.00000000000) 
			} 
			IF (GoalManager_GetTrickFromKeyCombo) (key_combo) = ( <key_combo_array> [ <index> ] ) 
				IF NOT ( <type> = (lip_tricks) ) 
					IF (GotParam) (extra_trick_string) 
						(FormatText) (TextName) = (trick_string) "%f / %s" (f) = <trick_string> (s) = <extra_trick_string> 
					ENDIF 
				ENDIF 
				IF (GotParam) (cat_num) 
					(get_CAT_other_param_values) (trick_index) = <cat_num> 
					IF (GotParam) (name) 
						(printf) "name = %n" (n) = <name> 
					ELSE 
						(name) = "didn\'t get name" 
					ENDIF 
					(trick_string) = <name> 
				ENDIF 
				(CreateScreenElement) { 
					(type) = (TextElement) 
					(parent) = <id> 
					(font) = (small) 
					(rgba) = <text_rgba> 
					(text) = <trick_string> 
					(pos) = PAIR(-5.00000000000, 0.00000000000) 
					(scale) = 0.75000000000 
					(just) = [ (left) (center) ] 
				} 
			ENDIF 
			<index> = ( <index> + 1 ) 
			(RemoveParameter) (extra_trick_string) 
			(RemoveParameter) (cat_num) 
		REPEAT <array_size> 
	ENDIF 
	(edit_tricks_menu_assign_current_menu_alias) 
ENDSCRIPT

SCRIPT (edit_tricks_menu_destroy_current_mapping_list) 
	IF (ObjectExists) (id) = (edit_tricks_menu_current_mapping) 
		(DestroyScreenElement) (id) = (edit_tricks_menu_current_mapping) 
	ENDIF 
ENDSCRIPT

SCRIPT (special_tricks_menu_fill_trick_list) 
	(ForEachIn) (special_trick_types) (do) = (special_tricks_menu_add_type) 
ENDSCRIPT

SCRIPT (edit_tricks_menu_add_item) { (parent) = (current_menu) 
		(font) = (small) 
		(focus_script) = (edit_tricks_menu_focus) 
		(unfocus_script) = (edit_tricks_menu_unfocus) 
		(pad_choose_script) = (nullscript) 
		(text_pos) = PAIR(100.00000000000, -8.00000000000) 
		(bg_scale) = PAIR(64.00000000000, 6.00000000000) 
		(bg_pos) = PAIR(-30.00000000000, -18.00000000000) 
		(dims) = PAIR(100.00000000000, 24.00000000000) 
		(text_just) = [ (center) (center) ] 
	} 
	(FormatText) (ChecksumName) = (rgba) "%i_UNHIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(CreateScreenElement) { 
		(type) = (ContainerElement) 
		(parent) = <parent> 
		(id) = <id> 
		(dims) = <dims> 
		(event_handlers) = [ { (focus) <focus_script> (params) = <focus_params> } 
			{ (unfocus) <unfocus_script> (params) = <unfocus_params> } 
			{ (pad_choose) (generic_menu_pad_choose_sound) } 
			{ (pad_start) (generic_menu_pad_choose_sound) } 
			{ (pad_choose) <pad_choose_script> (params) = <pad_choose_params> } 
			{ (pad_start) <pad_choose_script> (params) = <pad_choose_params> } 
		] 
		<not_focusable> 
	} 
	<anchor_id> = <id> 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = <anchor_id> 
		(font) = (small) 
		(text) = <text> 
		(pos) = <text_pos> 
		(just) = <text_just> 
		(rgba) = <rgba> 
		(z_priority) = 4 
		(scale) = <text_scale> 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = <anchor_id> 
		(texture) = (black) 
		(scale) = <bg_scale> 
		(pos) = <bg_pos> 
		(just) = [ (left) (top) ] 
		(rgba) = [ 0 0 0 85 ] 
		(z_priority) = 0 
	} 
	<cap_texture> = (grungeframe_mid) 
	IF (GotParam) (first_item) 
		<cap_texture> = (grungeframe_top) 
	ELSE 
		IF (GotParam) (last_item) 
			<cap_texture> = (grungeframe_bot) 
		ENDIF 
	ENDIF 
	(GetStackedScreenElementPos) (X) (id) = <id> (offset) = PAIR(-15.00000000000, 0.00000000000) 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = <anchor_id> 
		(texture) = <cap_texture> 
		(pos) = <pos> 
		(scale) = PAIR(1.00000000000, 0.75000000000) 
		(rgba) = [ 128 128 128 70 ] 
		(just) = [ (left) (top) ] 
		(z_priority) = -1 
	} 
	IF (GotParam) (add_deck_line) 
		(CreateScreenElement) { 
			(type) = (SpriteElement) 
			(parent) = <anchor_id> 
			(texture) = (black) 
			(pos) = <text_pos> 
			(scale) = PAIR(40.00000000000, 0.25000000000) 
			(rgba) = [ 18 87 18 128 ] 
			(alpha) = 0 
			(just) = [ (center) (top) ] 
			(z_priority) = 5 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT (edit_tricks_sub_menu_add_key_combo) { (pad_choose_script) = (edit_tricks_menu_goto_trick_list) 
		(highlight_bar_scale) = PAIR(1.00000000000, 0.69999998808) 
		(parent) = (edit_tricks_menu_1) 
	} 
	<firefight_active> = 0 
	IF (GoalManager_GoalExists) (name) = (firefight) 
		IF (GoalManager_GoalIsActive) (name) = (firefight) 
			<firefight_active> = 1 
		ENDIF 
	ENDIF 
	IF ( <firefight_active> = 1 ) 
		(pad_choose_script) = (nullscript) 
	ENDIF 
	IF (GoalManager_HasActiveGoals) 
		(pad_choose_script) = (nullscript) 
	ENDIF 
	IF (GoalManager_GoalExists) (name) = (trickattack) 
		IF (GoalManager_GoalIsActive) (name) = (trickattack) 
			(pad_choose_script) = (nullscript) 
		ENDIF 
	ENDIF 
	IF NOT (GotParam) (focus_params) 
		(focus_params) = { (highlight_bar_scale) = <highlight_bar_scale> 
			(highlight_bar_pos) = <highlight_bar_pos> 
		} 
	ENDIF 
	(SetScreenElementLock) (id) = <parent> (off) 
	(CreateScreenElement) { 
		(type) = (ContainerElement) 
		(parent) = <parent> 
		(dims) = PAIR(100.00000000000, 22.00000000000) 
		(event_handlers) = [ { (focus) (edit_tricks_menu_key_combo_focus) (params) = <focus_params> } 
			{ (unfocus) (edit_tricks_menu_key_combo_unfocus) } 
		] 
		(tags) = { (tag_grid_x) = <index> } 
		<not_focusable> 
	} 
	<anchor_id> = <id> 
	IF NOT (GotParam) (pad_choose_params) 
		(pad_choose_params) = { 
			(key_combo) = <key_combo> 
			(index) = <index> 
			(id) = <anchor_id> 
			(highlight_script) = (edit_tricks_menu_key_combo_focus) 
			(highlight_bar_scale) = <short_highlight_bar_scale> 
			(highlight_bar_pos) = <short_highlight_bar_pos> 
		} 
	ENDIF 
	(SetScreenElementProps) { 
		(id) = <anchor_id> 
		(event_handlers) = [ { (pad_choose) <pad_choose_script> (params) = <pad_choose_params> } 
			{ (pad_start) <pad_choose_script> (params) = <pad_choose_params> } 
			{ (pad_choose) (generic_menu_pad_choose_sound) } 
		] 
	} 
	IF (GotParam) (not_focusable) 
		<text_rgba> = [ 70 70 70 90 ] 
	ELSE 
		<text_rgba> = [ 128 128 128 128 ] 
	ENDIF 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = <anchor_id> 
		(font) = (small) 
		(text) = ( (goal_tetris_trick_text) . <key_combo> ) 
		(rgba) = <text_rgba> 
		(scale) = 0.69999998808 
		(pos) = PAIR(0.00000000000, 0.00000000000) 
		(just) = [ (right) (center) ] 
		(z_priority) = 4 
	} 
ENDSCRIPT

SCRIPT (edit_tricks_sub_menu_add_trick) (pad_choose_script) = (edit_tricks_menu_bind_trick) 
	(FormatText) (ChecksumName) = (text_rgba) "%i_UNHIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(CreateScreenElement) { 
		(type) = (ContainerElement) 
		(parent) = (edit_tricks_menu_2) 
		(dims) = PAIR(400.00000000000, 24.00000000000) 
		(event_handlers) = [ { (focus) (edit_tricks_menu_focus) (params) = <focus_params> } 
			{ (unfocus) (edit_tricks_menu_unfocus) (params) = { (rgba) = <text_rgba> } } 
			{ (pad_choose) <pad_choose_script> (params) = <pad_choose_params> } 
			{ (pad_start) <pad_choose_script> (params) = <pad_choose_params> } 
			{ (pad_choose) (generic_menu_pad_choose_sound) } 
		] 
	} 
	<anchor_id> = <id> 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = <anchor_id> 
		(font) = (small) 
		(text) = <text> 
		(pos) = PAIR(0.00000000000, 0.00000000000) 
		(just) = [ (left) (top) ] 
		(rgba) = <text_rgba> 
		(scale) = 0.75000000000 
	} 
ENDSCRIPT

SCRIPT (edit_tricks_sub_menu_add_header) 
	(FormatText) (ChecksumName) = (text_rgba) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(CreateScreenElement) { 
		(type) = (ContainerElement) 
		(parent) = (edit_tricks_menu_2) 
		(dims) = PAIR(400.00000000000, 24.00000000000) 
		(not_focusable) 
	} 
	<anchor_id> = <id> 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = <anchor_id> 
		(font) = (small) 
		(text) = <text> 
		(pos) = PAIR(0.00000000000, 0.00000000000) 
		(just) = [ (left) (top) ] 
		(rgba) = <text_rgba> 
		(scale) = 0.75000000000 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = <anchor_id> 
		(texture) = (white2) 
		(pos) = PAIR(-10.00000000000, 0.00000000000) 
		(just) = [ (left) (top) ] 
		(rgba) = [ 0 0 0 100 ] 
		(scale) = PAIR(46.00000000000, 2.25000000000) 
		(z_priority) = 2 
	} 
ENDSCRIPT

SCRIPT (special_tricks_menu_add_slot) { (pad_choose_script) = (special_tricks_menu_goto_trick_list) 
		(highlight_bar_scale) = PAIR(3.90000009537, 0.69999998808) 
		(highlight_bar_pos) = PAIR(-105.00000000000, -18.00000000000) 
	} 
	<firefight_active> = 0 
	IF (GoalManager_GoalExists) (name) = (firefight) 
		IF (GoalManager_GoalIsActive) (name) = (firefight) 
			<firefight_active> = 1 
		ENDIF 
	ENDIF 
	IF ( <firefight_active> = 1 ) 
		(pad_choose_script) = (nullscript) 
	ENDIF 
	IF (GoalManager_HasActiveGoals) 
		(pad_choose_script) = (nullscript) 
	ENDIF 
	IF (GoalManager_GoalExists) (name) = (trickattack) 
		IF (GoalManager_GoalIsActive) (name) = (trickattack) 
			(pad_choose_script) = (nullscript) 
		ENDIF 
	ENDIF 
	(FormatText) (ChecksumName) = (unhighlight_color) "%i_UNHIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(CreateScreenElement) { 
		(type) = (ContainerElement) 
		(parent) = (edit_tricks_menu_1) 
		(dims) = PAIR(40.00000000000, 22.00000000000) 
		(event_handlers) = [ { (focus) (edit_tricks_menu_focus) (params) = { (highlight_bar_pos) = <highlight_bar_pos> (highlight_bar_scale) = <highlight_bar_scale> (first_item) (last_item) (no_arrows) } } 
			{ (unfocus) (edit_tricks_menu_unfocus) (params) = { (rgba) = [ 90 90 90 100 ] } } 
			{ (pad_choose) <pad_choose_script> (params) = { (highlight_script) = (edit_tricks_menu_focus) (highlight_bar_scale) = PAIR(0.60000002384, 0.69999998808) (highlight_bar_pos) = <highlight_bar_pos> (index) = <index> } } 
			{ (pad_start) <pad_choose_script> (params) = { (highlight_script) = (edit_tricks_menu_focus) (highlight_bar_scale) = PAIR(0.60000002384, 0.69999998808) (highlight_bar_pos) = <highlight_bar_pos> (index) = <index> } } 
			{ (pad_choose) (generic_menu_pad_choose_sound) } 
		] 
		(tags) = { (tag_grid_x) = <index> } 
	} 
	<anchor_id> = <id> 
	(FormatText) (TextName) = (slot_num) "%s-" (s) = <index> 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = <anchor_id> 
		(font) = (small) 
		(text) = <slot_num> 
		(pos) = PAIR(-60.00000000000, -5.00000000000) 
		(just) = [ (center) (center) ] 
		(rgba) = <unhighlight_color> 
		(z_priority) = 4 
		(scale) = 0.75000000000 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = <anchor_id> 
		(texture) = (de_highlight_bar) 
		(pos) = PAIR(-105.00000000000, -10.00000000000) 
		(just) = [ (center) (center) ] 
		(rgba) = [ 128 128 128 0 ] 
		(scale) = <highlight_bar_scale> 
		(z_priority) = 3 
	} 
ENDSCRIPT

SCRIPT (special_tricks_menu_add_special_to_mapping) 
	(printf) "special_tricks_menu_add_special_to_mapping" 
	(GetSpecialTrickInfo) (index) = <index> 
	(FormatText) (ChecksumName) = (unhighlight_color) "%i_UNHIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(CreateScreenElement) { 
		(type) = (ContainerElement) 
		(parent) = (special_tricks_current_mapping) 
		(dims) = PAIR(40.00000000000, 22.00000000000) 
	} 
	<anchor_id> = <id> 
	IF ( <special_trickname> = (Unassigned) ) 
		<trick_display_text> = "Unassigned" 
	ELSE 
		IF ( <isCat> = 1 ) 
			(get_CAT_other_param_values) (trick_index) = <special_trickname> 
			IF (GotParam) (name) 
				(printf) "name = %n" (n) = <name> 
			ELSE 
				(name) = "didn\'t get name" 
			ENDIF 
			(trick_display_text) = <name> 
		ELSE 
			(GetTrickDisplayText) (trick) = <special_trickname> 
		ENDIF 
	ENDIF 
	IF ( <special_trickslot> = (Unassigned) ) 
		<special_trickslot_text> = "" 
	ELSE 
		<special_trickslot_text> = ( (goal_tetris_trick_text) . <special_trickslot> ) 
	ENDIF 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = <anchor_id> 
		(font) = (small) 
		(scale) = 0.75000000000 
		(text) = <trick_display_text> 
		(pos) = PAIR(10.00000000000, 0.00000000000) 
		(just) = [ (left) (top) ] 
		(rgba) = <unhighlight_color> 
	} 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = <anchor_id> 
		(font) = (small) 
		(scale) = 0.75000000000 
		(text) = <special_trickslot_text> 
		(pos) = PAIR(320.00000000000, 0.00000000000) 
		(just) = [ (left) (top) ] 
	} 
ENDSCRIPT

SCRIPT (special_tricks_menu_add_type) 
	(printf) "special_tricks_menu_add_type" 
	(GetConfigurableTricksFromType) (type) = <type> (special) 
	(SetScreenElementLock) (id) = (edit_tricks_menu_2) (off) 
	(CreateScreenElement) { 
		(type) = (ContainerElement) 
		(parent) = (edit_tricks_menu_2) 
		(dims) = PAIR(40.00000000000, 24.00000000000) 
		(not_focusable) 
	} 
	<anchor_id> = <id> 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = <anchor_id> 
		(font) = (dialog) 
		(text) = <Heading> 
		(rgba) = [ 100 100 100 100 ] 
		(pos) = PAIR(0.00000000000, 0.00000000000) 
		(scale) = 0.89999997616 
		(just) = [ (left) (top) ] 
		(z_priority) = 2 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = <anchor_id> 
		(texture) = (black) 
		(rgba) = [ 0 0 0 128 ] 
		(scale) = PAIR(71.00000000000, 6.00000000000) 
		(pos) = PAIR(-10.00000000000, 0.00000000000) 
		(just) = [ (left) (top) ] 
		(z_priority) = 1 
	} 
	IF NOT (GotParam) (add_cats) 
		(GetArraySize) <ConfigurableTricks> 
		<index> = 0 
		BEGIN 
			IF ( ( <index> = 0 ) & ( <type> = (FlipTrick) ) ) 
				<first_item> = (first_item) 
			ELSE 
				(RemoveParameter) (first_item) 
				IF ( ( <index> = ( <array_size> - 1 ) ) & ( <type> = (Manual) ) ) 
				ELSE 
					(RemoveParameter) (last_item) 
				ENDIF 
			ENDIF 
			(is_trick_locked) (trick) = ( <ConfigurableTricks> [ <index> ] ) 
			IF ( <trick_is_locked> = 0 ) 
				(special_tricks_menu_add_trick) { 
					(trick) = ( <ConfigurableTricks> [ <index> ] ) 
					(type) = <type> 
					(first_item) = <first_item> 
					(last_item) = <last_item> 
				} 
			ENDIF 
			<index> = ( <index> + 1 ) 
		REPEAT <array_size> 
	ELSE 
		IF (GotParam) (ConfigurableCats) 
			(GetArraySize) <ConfigurableCats> 
			IF ( <array_size> > 0 ) 
				(index) = 0 
				BEGIN 
					<cat_num> = ( <ConfigurableCats> [ <index> ] ) 
					(get_CAT_other_param_values) (trick_index) = <cat_num> 
					IF (GotParam) (name) 
						(printf) "name = %n" (n) = <name> 
					ELSE 
						(name) = "didn\'t get name" 
					ENDIF 
					(trick_display_text) = <name> 
					IF ( <index> = ( <array_size> - 1 ) ) 
						(special_tricks_menu_add_trick) { 
							(text) = <trick_display_text> 
							(trick) = <trick_display_text> 
							(type) = (CAT) 
							(cat_num) = <cat_num> 
							(last_item) = (last_item) 
						} 
					ELSE 
						(special_tricks_menu_add_trick) { 
							(text) = <trick_display_text> 
							(trick) = <trick_display_text> 
							(type) = (CAT) 
							(cat_num) = <cat_num> 
						} 
					ENDIF 
					<index> = ( <index> + 1 ) 
				REPEAT <array_size> 
			ENDIF 
		ENDIF 
	ENDIF 
	(CreateScreenElement) { 
		(type) = (ContainerElement) 
		(parent) = (edit_tricks_menu_2) 
		(dims) = PAIR(40.00000000000, 24.00000000000) 
		(not_focusable) 
	} 
ENDSCRIPT

SCRIPT (is_trick_locked) 
	IF NOT (GotParam) (trick) 
		RETURN 
	ENDIF 
	(skater) = ( ( <trick> . (params) ) . (skater) ) 
	IF NOT (GotParam) (skater) 
		RETURN (trick_is_locked) = 0 
	ENDIF 
	(GetArraySize) (master_skater_list) 
	(index) = 0 
	BEGIN 
		(name) = ( ( (master_skater_list) [ <index> ] ) . (name) ) 
		IF ( <name> = <skater> ) 
			(flag) = ( ( (master_skater_list) [ <index> ] ) . (unlock_flag) ) 
			BREAK 
		ENDIF 
		(index) = ( <index> + 1 ) 
	REPEAT <array_size> 
	IF (GetGlobalFlag) (flag) = <flag> 
		RETURN (trick_is_locked) = 0 
	ELSE 
		RETURN (trick_is_locked) = 1 
	ENDIF 
ENDSCRIPT

SCRIPT (special_tricks_menu_add_trick) 
	IF (GotParam) (first_item) 
		(focus_params) = { (first_item) } 
	ELSE 
		IF (GotParam) (last_item) 
			(focus_params) = { (last_item) } 
		ENDIF 
	ENDIF 
	IF NOT ( <type> = (CAT) ) 
		(trick_name_string) = ( <trick> . (params) . (name) ) 
	ELSE 
		(trick_name_string) = <text> 
	ENDIF 
	(CreateScreenElement) { 
		(type) = (ContainerElement) 
		(parent) = (edit_tricks_menu_2) 
		(dims) = PAIR(40.00000000000, 24.00000000000) 
	} 
	<anchor_id> = <id> 
	(FormatText) (ChecksumName) = (highlight_color) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(SetScreenElementProps) { 
		(id) = <anchor_id> 
		(event_handlers) = [ { (focus) (special_tricks_menu_focus) (params) = <focus_params> } 
			{ (unfocus) (special_tricks_menu_unfocus) (params) = { (rgba) = [ 90 90 90 100 ] } } 
			{ (pad_choose) (special_tricks_menu_select_trick) (params) = { (rgba) = <highlight_color> (highlight_bar_scale) = PAIR(2.25000000000, 0.69999998808) (trick) = <trick> (type) = <type> (id) = <anchor_id> (cat_num) = <cat_num> } } 
			{ (pad_start) (special_tricks_menu_select_trick) (params) = { (rgba) = <highlight_color> (highlight_bar_scale) = PAIR(2.25000000000, 0.69999998808) (trick) = <trick> (type) = <type> (id) = <anchor_id> (cat_num) = <cat_num> } } 
			{ (pad_choose) (generic_menu_pad_choose_sound) } 
		] 
	} 
	(FormatText) (ChecksumName) = (unhighlight_color) "%i_UNHIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	IF NOT ( <type> = (CAT) ) 
		(GetTrickDisplayText) (trick) = <trick> 
	ELSE 
		(trick_display_text) = <text> 
	ENDIF 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = <anchor_id> 
		(font) = (small) 
		(text) = <trick_display_text> 
		(rgba) = <unhighlight_color> 
		(pos) = PAIR(0.00000000000, 0.00000000000) 
		(just) = [ (left) (top) ] 
		(scale) = 0.80000001192 
	} 
ENDSCRIPT

SCRIPT (edit_tricks_menu_focus) (highlight_bar_scale) = PAIR(1.00000000000, 0.69999998808) (highlight_bar_pos) = PAIR(-10.00000000000, -2.00000000000) 
	(GetTags) 
	(SetScreenElementLock) (id) = <id> (off) 
	(KillSpawnedScript) (name) = (do_random_effect) 
	(KillSpawnedScript) (name) = (text_twitch_effect2) 
	(FormatText) (ChecksumName) = (highlight_color) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	IF (GotParam) (flagged_deck) 
		(RunScriptOnScreenElement) (id) = { <id> (child) = 0 } (do_scale_up) (params) = { (rgba) = [ 99 121 6 128 ] } 
	ELSE 
		(RunScriptOnScreenElement) (id) = { <id> (child) = 0 } (text_twitch_effect3) 
		(SetScreenElementProps) (id) = { <id> (child) = 0 } (rgba) = <highlight_color> 
	ENDIF 
	IF (ObjectExists) (id) = (edit_tricks_menu_highlight_bar) 
		(DestroyScreenElement) (id) = (edit_tricks_menu_highlight_bar) 
	ENDIF 
	(FormatText) (ChecksumName) = (bar_rgba) "%i_HIGHLIGHT_BAR_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(highlight_angle) = RANDOM_NO_REPEAT(1, 1, 1, 1, 1, 1, 1, 1, 1, 1) RANDOMCASE 2 RANDOMCASE -2 RANDOMCASE 3 RANDOMCASE -3 RANDOMCASE 3.50000000000 RANDOMCASE -3 RANDOMCASE 5 RANDOMCASE -4 RANDOMCASE 2.50000000000 RANDOMCASE -4.50000000000 RANDOMEND 
	IF ( <highlight_bar_scale> . PAIR(1.00000000000, 0.00000000000) > 1 ) 
		(highlight_angle) = ( <highlight_angle> / ( <highlight_bar_scale> . PAIR(1.00000000000, 0.00000000000) ) ) 
	ENDIF 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = <id> 
		(id) = (edit_tricks_menu_highlight_bar) 
		(texture) = (de_highlight_bar) 
		(rgba) = <bar_rgba> 
		(pos) = <highlight_bar_pos> 
		(just) = [ (left) (top) ] 
		(scale) = <highlight_bar_scale> 
		(z_priority) = 3 
		(rot_angle) = <highlight_angle> 
	} 
	IF NOT (GotParam) (no_arrows) 
		IF (ObjectExists) (id) = (edit_tricks_menu_up_arrow) 
			IF (GotParam) (first_item) 
				(SetScreenElementProps) { 
					(id) = (edit_tricks_menu_up_arrow) 
					(rgba) = [ 128 128 128 0 ] 
				} 
			ELSE 
				(SetScreenElementProps) { 
					(id) = (edit_tricks_menu_up_arrow) 
					(rgba) = [ 128 128 128 85 ] 
				} 
			ENDIF 
		ENDIF 
		IF (ObjectExists) (id) = (edit_tricks_menu_down_arrow) 
			IF (GotParam) (last_item) 
				(SetScreenElementProps) { 
					(id) = (edit_tricks_menu_down_arrow) 
					(rgba) = [ 128 128 128 0 ] 
				} 
			ELSE 
				(SetScreenElementProps) { 
					(id) = (edit_tricks_menu_down_arrow) 
					(rgba) = [ 128 128 128 85 ] 
				} 
			ENDIF 
		ENDIF 
		IF ( (ObjectExists) (id) = (edit_tricks_menu_up_arrow) ) 
			(AssignAlias) (id) = (edit_tricks_menu_2) (alias) = (current_menu) 
			(edit_tricks_menu_2) : (GetTags) 
			IF (GotParam) (arrow_id) 
				(menu_vert_blink_arrow) { (id) = <arrow_id> } 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT (edit_tricks_menu_unfocus) 
	(GetTags) 
	(FormatText) (ChecksumName) = (unhighlight_color) "%i_UNHIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(KillSpawnedScript) (name) = (text_twitch_effect3) 
	(DoScreenElementMorph) (id) = { <id> (child) = 0 } (scale) = 1 (relative_scale) 
	IF (GotParam) (flagged_deck) 
		(RunScriptOnScreenElement) (id) = { <id> (child) = 0 } (do_scale_down) (params) = { (rgba) = [ 25 83 67 128 ] (no_sound) } 
	ELSE 
		(SetScreenElementProps) (id) = { <id> (child) = 0 } (rgba) = <unhighlight_color> 
	ENDIF 
	IF (ObjectExists) (id) = (edit_tricks_menu_highlight_bar) 
		(DestroyScreenElement) (id) = (edit_tricks_menu_highlight_bar) 
	ENDIF 
ENDSCRIPT

SCRIPT (special_tricks_menu_focus) (highlight_bar_scale) = PAIR(2.25000000000, 0.69999998808) 
	(GetTags) 
	(RunScriptOnScreenElement) (id) = { <id> (child) = 0 } (text_twitch_effect3) 
	(FormatText) (ChecksumName) = (highlight_color) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(SetScreenElementProps) (id) = { <id> (child) = 0 } (rgba) = <highlight_color> 
	(SetScreenElementLock) (id) = <id> (off) 
	(highlight_angle) = RANDOM_NO_REPEAT(1, 1, 1, 1, 1, 1, 1, 1, 1, 1) RANDOMCASE 2 RANDOMCASE -2 RANDOMCASE 3 RANDOMCASE -3 RANDOMCASE 3.50000000000 RANDOMCASE -3 RANDOMCASE 5 RANDOMCASE -4 RANDOMCASE 2.50000000000 RANDOMCASE -4.50000000000 RANDOMEND 
	(highlight_angle) = ( <highlight_angle> / ( <highlight_bar_scale> . PAIR(1.00000000000, 0.00000000000) ) ) 
	(FormatText) (ChecksumName) = (bar_color) "%i_HIGHLIGHT_BAR_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = <id> 
		(texture) = (de_highlight_bar) 
		(pos) = PAIR(135.00000000000, 10.00000000000) 
		(rgba) = <bar_color> 
		(scale) = <highlight_bar_scale> 
		(just) = [ (center) (center) ] 
		(rot_angle) = <highlight_angle> 
	} 
	IF (ObjectExists) (id) = (edit_tricks_menu_up_arrow) 
		IF (GotParam) (first_item) 
			(SetScreenElementProps) { 
				(id) = (edit_tricks_menu_up_arrow) 
				(rgba) = [ 128 128 128 0 ] 
			} 
		ELSE 
			(SetScreenElementProps) { 
				(id) = (edit_tricks_menu_up_arrow) 
				(rgba) = [ 128 128 128 85 ] 
			} 
		ENDIF 
	ENDIF 
	IF (ObjectExists) (id) = (edit_tricks_menu_down_arrow) 
		IF (GotParam) (last_item) 
			(SetScreenElementProps) { 
				(id) = (edit_tricks_menu_down_arrow) 
				(rgba) = [ 128 128 128 0 ] 
			} 
		ELSE 
			(SetScreenElementProps) { 
				(id) = (edit_tricks_menu_down_arrow) 
				(rgba) = [ 128 128 128 85 ] 
			} 
		ENDIF 
	ENDIF 
	IF (ScreenElementExists) (id) = (edit_tricks_menu_up_arrow) 
		(AssignAlias) (id) = (edit_tricks_menu_2) (alias) = (current_menu) 
		(edit_tricks_menu_2) : (GetTags) 
		IF (GotParam) (first_item) 
			(SetScreenElementProps) (id) = <scrolling_parent> (reset_window_top) 
		ENDIF 
		IF (GotParam) (last_item) 
			(SetScreenElementProps) (id) = <scrolling_parent> (reset_window_bottom) 
		ENDIF 
		IF NOT (GotParam) (first_item) 
			IF NOT (GotParam) (last_item) 
				IF (GotParam) (arrow_id) 
					(menu_vert_blink_arrow) { (id) = <arrow_id> } 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT (special_tricks_menu_unfocus) 
	(GetTags) 
	(KillSpawnedScript) (name) = (text_twitch_effect3) 
	(DoScreenElementMorph) (id) = { <id> (child) = 0 } (scale) = 1 (relative_scale) 
	(FormatText) (ChecksumName) = (unhighlight_color) "%i_UNHIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(SetScreenElementProps) (id) = { <id> (child) = 0 } (rgba) = <unhighlight_color> 
	(DestroyScreenElement) (id) = { <id> (child) = 1 } 
ENDSCRIPT

SCRIPT (edit_tricks_menu_key_combo_focus) (highlight_bar_pos) = PAIR(-42.00000000000, -10.00000000000) 
	(GetTags) 
	(FormatText) (ChecksumName) = (bar_color) "%i_HIGHLIGHT_BAR_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(highlight_angle) = RANDOM_NO_REPEAT(1, 1, 1, 1, 1, 1, 1, 1, 1, 1) RANDOMCASE 2 RANDOMCASE -2 RANDOMCASE 3 RANDOMCASE -3 RANDOMCASE 3.50000000000 RANDOMCASE -3 RANDOMCASE 5 RANDOMCASE -4 RANDOMCASE 2.50000000000 RANDOMCASE -4.50000000000 RANDOMEND 
	(highlight_angle) = ( <highlight_angle> / ( <highlight_bar_scale> . PAIR(1.00000000000, 0.00000000000) ) ) 
	IF (GotParam) (rgba) 
		(DoScreenElementMorph) { 
			(id) = { <id> (child) = 0 } 
			(rgba) = <rgba> 
			(relative_scale) 
		} 
	ENDIF 
	(RunScriptOnScreenElement) (id) = { <id> (child) = 0 } (text_twitch_effect2) (params) = { (scale) = 1.20000004768 (scale2) = 1.25000000000 } 
	(SetScreenElementLock) (id) = <id> (off) 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = <id> 
		(id) = (key_combo_highlight_bar) 
		(texture) = (de_highlight_bar) 
		(scale) = <highlight_bar_scale> 
		(pos) = <highlight_bar_pos> 
		(just) = [ (center) (top) ] 
		(rgba) = <bar_color> 
		(z_priority) = 3 
		(rot_angle) = <highlight_angle> 
	} 
	IF (GotParam) (up_arrow_id) 
		IF (GotParam) (first_item) 
			(SetScreenElementProps) { 
				(id) = <up_arrow_id> 
				(rgba) = [ 128 128 128 0 ] 
			} 
		ELSE 
			(SetScreenElementProps) { 
				(id) = <up_arrow_id> 
				(rgba) = [ 128 128 128 85 ] 
			} 
		ENDIF 
	ENDIF 
	IF (GotParam) (down_arrow_id) 
		IF (GotParam) (last_item) 
			(SetScreenElementProps) { 
				(id) = <down_arrow_id> 
				(rgba) = [ 128 128 128 0 ] 
			} 
		ELSE 
			(SetScreenElementProps) { 
				(id) = <down_arrow_id> 
				(rgba) = [ 128 128 128 85 ] 
			} 
		ENDIF 
	ENDIF 
	IF ( (ObjectExists) (id) = (special_tricks_menu_key_combo_up_arrow) ) 
		(AssignAlias) (id) = (edit_tricks_menu_3) (alias) = (current_menu) 
		(edit_tricks_menu_3) : (GetTags) 
		IF (GotParam) (arrow_id) 
			(menu_vert_blink_arrow) { (id) = <arrow_id> } 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT (edit_tricks_menu_key_combo_unfocus) 
	(GetTags) 
	(KillSpawnedScript) (name) = (text_twitch_effect2) 
	(DoScreenElementMorph) { 
		(id) = { <id> (child) = 0 } 
		(scale) = 1 
		(relative_scale) 
	} 
	IF (ObjectExists) (id) = (key_combo_highlight_bar) 
		(DestroyScreenElement) (id) = (key_combo_highlight_bar) 
	ENDIF 
ENDSCRIPT

SCRIPT (edit_tricks_menu_goto_trick_list) 
	(FireEvent) (type) = (unfocus) (target) = (edit_tricks_menu_1) 
	(edit_tricks_menu_1_index) = <index> 
	IF (GotParam) (key_combo) 
		(SetScreenElementProps) { 
			(id) = (edit_tricks_menu_2) 
			(tags) = { (new_key_combo) = <key_combo> } 
		} 
	ENDIF 
	IF (GotParam) (highlight_script) 
		(RunScriptOnScreenElement) (id) = <id> <highlight_script> (params) = { (highlight_bar_scale) = <highlight_bar_scale> } 
	ENDIF 
	(FireEvent) (type) = (focus) (target) = (edit_tricks_menu_2) 
ENDSCRIPT

SCRIPT (edit_tricks_menu_special_tricks_focus) 
	(special_tricks_menu_create_current_mapping_list) 
ENDSCRIPT

SCRIPT (special_tricks_menu_goto_trick_list) 
	(GetTags) 
	IF (ObjectExists) (id) = (special_tricks_temp_trick_highlight_bar) 
		(DestroyScreenElement) (id) = (special_tricks_temp_trick_highlight_bar) 
	ENDIF 
	IF (GotParam) (element_to_unfocus) 
		(SetScreenElementProps) { 
			(id) = <element_to_unfocus> 
			(rgba) = [ 90 90 90 100 ] 
		} 
	ENDIF 
	IF (ObjectExists) (id) = (special_tricks_current_mapping) 
		(DestroyScreenElement) (id) = (special_tricks_current_mapping) 
	ENDIF 
	(FireEvent) (type) = (unfocus) (target) = (edit_tricks_menu_1) 
	IF (GotParam) (index) 
		(SetScreenElementProps) { 
			(id) = (edit_tricks_menu_2) 
			(tags) = { (index) = ( <index> - 1 ) } 
		} 
	ENDIF 
	IF (GotParam) (highlight_script) 
		(RunScriptOnScreenElement) (id) = <id> <highlight_script> (params) = { (highlight_bar_pos) = <highlight_bar_pos> (highlight_bar_scale) = <highlight_bar_scale> } 
	ENDIF 
	(SetScreenElementLock) (id) = (edit_tricks_menu_2) (on) 
	(SetScreenElementLock) (id) = (edit_tricks_menu_2) (off) 
	(FireEvent) (type) = (unfocus) (target) = (edit_tricks_menu_3) 
	IF (GotParam) (index) 
		(GetSpecialTrickInfo) (index) = ( <index> - 1 ) 
		IF ( <special_trickslot> = (Unassigned) ) 
			(FireEvent) (type) = (focus) (target) = (edit_tricks_menu_2) 
		ELSE 
			IF ( <isCat> = 1 ) 
				(get_CAT_other_param_values) (trick_index) = <special_trickname> 
				IF (GotParam) (name) 
					(printf) "name = %n" (n) = <name> 
				ELSE 
					(name) = "didn\'t get name" 
				ENDIF 
				(special_trickname_string) = <name> 
			ELSE 
				<special_trickname_string> = ( ( <special_trickname> ) . (params) . (name) ) 
			ENDIF 
			(FormatText) (ChecksumName) = (special_trickname_checksum) "%s" (s) = <special_trickname_string> 
			(FireEvent) (type) = (focus) (target) = (edit_tricks_menu_2) (data) = { (child_id) = <special_trickname_checksum> } 
		ENDIF 
	ELSE 
		(FireEvent) (type) = (focus) (target) = (edit_tricks_menu_2) 
	ENDIF 
ENDSCRIPT

SCRIPT (edit_tricks_menu_back_from_trick_list) 
	IF (ObjectExists) (id) = (key_combo_highlight_bar) 
		(DestroyScreenElement) (id) = (key_combo_highlight_bar) 
	ENDIF 
	(FireEvent) (type) = (unfocus) (target) = (edit_tricks_menu_2) 
	IF (ObjectExists) (id) = (edit_tricks_menu_1) 
		(FireEvent) (type) = (focus) (target) = (edit_tricks_menu_1) (data) = { (grid_index) = (edit_tricks_menu_1_index) } 
	ENDIF 
	IF (ObjectExists) (id) = (edit_tricks_menu_up_arrow) 
		(SetScreenElementProps) { 
			(id) = (edit_tricks_menu_up_arrow) 
			(rgba) = [ 128 128 128 0 ] 
		} 
	ENDIF 
	IF (ObjectExists) (id) = (edit_tricks_menu_down_arrow) 
		(SetScreenElementProps) { 
			(id) = (edit_tricks_menu_down_arrow) 
			(rgba) = [ 128 128 128 0 ] 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT (edit_tricks_menu_bind_trick) 
	(printf) "edit_tricks_menu_bind_trick" 
	IF NOT (GotParam) (new_key_combo) 
		(edit_tricks_menu_2) : (GetTags) 
	ENDIF 
	IF NOT (GotParam) (new_key_combo) 
		(printf) "no new_key_combo" 
		RETURN 
	ENDIF 
	IF NOT (GotParam) (new_trick) 
		(printf) "no new_trick" 
		RETURN 
	ENDIF 
	IF (InSplitScreenGame) 
		<update_mappings> = 0 
	ELSE 
		<update_mappings> = 1 
	ENDIF 
	IF (GotParam) (special) 
		IF (GoalManager_GetTrickFromKeyCombo) (special) (key_combo) = <new_key_combo> 
			(printf) "special key combo already bound" 
			(BindTrickToKeyCombo) { 
				(special) 
				(index) = <current_index> 
				(key_combo) = (Unassigned) 
				(trick) = (Unassigned) 
				(update_mappings) = <update_mappings> 
			} 
		ENDIF 
		IF (GetKeyComboBoundToTrick) (special) (trick) = <new_trick> (cat_num) = <new_trick> 
			(BindTrickToKeyCombo) { 
				(special) 
				(index) = <current_index> 
				(key_combo) = (Unassigned) 
				(trick) = (Unassigned) 
				(update_mappings) = <update_mappings> 
			} 
		ENDIF 
	ELSE 
		IF NOT (GotParam) (createdtrick) 
			IF (GetKeyComboBoundToTrick) (trick) = <new_trick> (cat_num) = <new_trick> 
				(printf) "trick already bound 1" 
				IF (GoalManager_GetTrickFromKeyCombo) (key_combo) = <new_key_combo> 
					(printf) "rebinding 1" 
					(BindTrickToKeyCombo) { 
						(key_combo) = <current_key_combo> 
						(trick) = <trick_checksum> 
						(trick) = <cat_num> 
						(update_mappings) = <update_mappings> 
					} 
				ENDIF 
			ENDIF 
		ELSE 
			IF (GetKeyComboBoundToTrick) (trick) = <new_trick> (cat_num) = <new_trick> 
				(printf) "trick already bound 2" 
				IF (GoalManager_GetTrickFromKeyCombo) (key_combo) = <new_key_combo> 
					(printf) "rebinding 2" 
					IF (GotParam) (trick_checksum) 
						(BindTrickToKeyCombo) { 
							(key_combo) = <current_key_combo> 
							(trick) = <trick_checksum> 
							(update_mappings) = <update_mappings> 
						} 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
	IF (GotParam) (special) 
		IF (GotParam) (createdtrick) 
			(printf) "binding new special created trick" 
			(BindTrickToKeyCombo) { 
				(special) 
				(index) = <index> 
				(key_combo) = <new_key_combo> 
				(trick) = <new_trick> 
				(update_mappings) = <update_mappings> 
				(CAT) 
			} 
		ELSE 
			(printf) "binding new special trick" 
			(BindTrickToKeyCombo) { 
				(special) 
				(index) = <index> 
				(key_combo) = <new_key_combo> 
				(trick) = <new_trick> 
				(update_mappings) = <update_mappings> 
			} 
		ENDIF 
	ELSE 
		(printf) "binding new trick" 
		(BindTrickToKeyCombo) { 
			(key_combo) = <new_key_combo> 
			(trick) = <new_trick> 
			(update_mappings) = <update_mappings> 
		} 
	ENDIF 
	(GetCurrentSkaterProfileIndex) 
	IF (InSplitScreenGame) 
		(printf) "in a split screen game" 
	ELSE 
		(UpdateTrickMappings) (skater) = <currentSkaterProfileIndex> 
	ENDIF 
	(GoalManager_ReplaceTrickText) (all) 
	IF (GotParam) (callback) 
		<callback> 
	ENDIF 
ENDSCRIPT

SCRIPT (special_tricks_menu_select_trick) 
	(printf) "special_tricks_menu_select_trick" 
	(FireEvent) (type) = (unfocus) (target) = (edit_tricks_menu_2) 
	(DoScreenElementMorph) { 
		(id) = (edit_tricks_menu_2) 
		(alpha) = 1 
	} 
	IF (GotParam) (id) 
		(FormatText) (ChecksumName) = (highlight_color) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
		(SetScreenElementProps) { 
			(id) = { <id> (child) = 0 } 
			(rgba) = <highlight_color> 
		} 
		(SetScreenElementProps) { 
			(id) = (edit_tricks_menu_3) 
			(event_handlers) = [ { (pad_back) (special_tricks_menu_goto_trick_list) (params) = { (element_to_unfocus) = <id> } } ] 
			(replace_handlers) 
		} 
		(FormatText) (ChecksumName) = (bar_color) "%i_HIGHLIGHT_BAR_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
		(highlight_angle) = RANDOM_NO_REPEAT(1, 1, 1, 1, 1, 1, 1, 1, 1, 1) RANDOMCASE 2 RANDOMCASE -2 RANDOMCASE 3 RANDOMCASE -3 RANDOMCASE 3.50000000000 RANDOMCASE -3 RANDOMCASE 5 RANDOMCASE -4 RANDOMCASE 2.50000000000 RANDOMCASE -4.50000000000 RANDOMEND 
		(highlight_angle) = ( <highlight_angle> / ( <highlight_bar_scale> . PAIR(1.00000000000, 0.00000000000) ) ) 
		(CreateScreenElement) { 
			(type) = (SpriteElement) 
			(parent) = <id> 
			(id) = (special_tricks_temp_trick_highlight_bar) 
			(texture) = (de_highlight_bar) 
			(pos) = PAIR(-10.00000000000, -1.00000000000) 
			(rgba) = <bar_color> 
			(scale) = <highlight_bar_scale> 
			(just) = [ (left) (top) ] 
			(rot_angle) = <highlight_angle> 
		} 
	ENDIF 
	(DestroyScreenElement) (id) = (edit_tricks_menu_3_parent) 
	(special_tricks_menu_create_menu_3) 
	(edit_tricks_menu_3) : (SetTags) (trick) = <trick> 
	SWITCH <type> 
		CASE (FlipTrick) 
		CASE (GrabTrick) 
		CASE (CAT) 
			<key_combo_array> = (special_trick_air_key_combos) 
		CASE (LipMacro2) 
			<key_combo_array> = (special_trick_lip_key_combos) 
		CASE (GrindTrick) 
			<key_combo_array> = (special_trick_grind_key_combos) 
		CASE (Manual) 
			<key_combo_array> = (special_trick_manual_key_combos) 
		DEFAULT 
			(printstruct) <...> 
			(script_assert) "Unknown type" 
	ENDSWITCH 
	(printf) "type = %i" (i) = <type> 
	IF ( <type> = (CAT) ) 
		(printf) "type = cat" 
		(pad_choose_params) = { (createdtrick) = (createdtrick) 
			(cat_num) = <cat_num> 
		} 
	ELSE 
		(printf) "type doesn\'t = cat" 
		(pad_choose_params) = { } 
	ENDIF 
	(GetArraySize) <key_combo_array> 
	<key_combo_index> = 0 
	BEGIN 
		IF ( <key_combo_index> = 0 ) 
			<first_item> = (first_item) 
		ELSE 
			IF ( <key_combo_index> = ( <array_size> - 1 ) ) 
				<last_item> = (last_item) 
			ENDIF 
		ENDIF 
		IF (GoalManager_GetTrickFromKeyCombo) (special) (key_combo) = ( <key_combo_array> [ <key_combo_index> ] ) 
			(edit_tricks_menu_2) : (GetTags) 
			(GetSpecialTrickInfo) (index) = <index> 
			IF NOT ( <special_trickslot> = ( <key_combo_array> [ <key_combo_index> ] ) ) 
				<not_focusable> = (not_focusable) 
			ENDIF 
		ENDIF 
		(edit_tricks_sub_menu_add_key_combo) { 
			(key_combo) = ( <key_combo_array> [ <key_combo_index> ] ) 
			(parent) = (edit_tricks_menu_3) 
			(pad_choose_script) = (special_tricks_menu_select_key_combo) 
			(focus_params) = { (highlight_bar_scale) = PAIR(1.00000000000, 0.69999998808) 
				(up_arrow_id) = (special_tricks_menu_key_combo_up_arrow) 
				(down_arrow_id) = (special_tricks_menu_key_combo_down_arrow) 
				(key_combo) = ( <key_combo_array> [ <key_combo_index> ] ) 
				<first_item> 
				<last_item> 
			} 
			(pad_choose_params) = { <pad_choose_params> 
				(id) = <anchor_id> 
				(highlight_script) = (edit_tricks_menu_key_combo_focus) 
				(highlight_bar_scale) = <short_highlight_bar_scale> 
				(key_combo) = ( <key_combo_array> [ <key_combo_index> ] ) 
				(index) = <key_combo_index> 
			} 
			(not_focusable) = <not_focusable> 
		} 
		(RemoveParameter) (first_item) 
		(RemoveParameter) (last_item) 
		(RemoveParameter) (not_focusable) 
		<key_combo_index> = ( <key_combo_index> + 1 ) 
	REPEAT <array_size> 
	(SetScreenElementLock) (id) = (edit_tricks_menu_3) (on) 
	(SetScreenElementLock) (id) = (edit_tricks_menu_3_parent) (on) 
	(FireEvent) (type) = (focus) (target) = (edit_tricks_menu_3) 
ENDSCRIPT

SCRIPT (special_tricks_menu_select_key_combo) 
	(edit_tricks_menu_2) : (GetTags) 
	(edit_tricks_menu_3) : (GetTags) 
	(printf) "special_tricks_menu_select_key_combo" 
	IF NOT (GotParam) (createdtrick) 
		(edit_tricks_menu_bind_trick) (new_key_combo) = <key_combo> (new_trick) = <trick> (index) = <index> (special) 
	ELSE 
		(edit_tricks_menu_bind_trick) (new_key_combo) = <key_combo> (new_trick) = <cat_num> (index) = <index> (special) (createdtrick) 
	ENDIF 
	(special_tricks_menu_goto_trick_list) 
	(edit_tricks_menu_back_from_trick_list) 
ENDSCRIPT

SCRIPT (edit_tricks_menu_show_on_focus) 
	(GetTags) 
	(DoMorph) (alpha) = 1 
ENDSCRIPT

SCRIPT (edit_tricks_menu_hide_on_unfocus) 
	(DoMorph) (alpha) = 0 
	IF (ObjectExists) (id) = (special_tricks_menu_key_combo_up_arrow) 
		(SetScreenElementProps) { 
			(id) = (special_tricks_menu_key_combo_up_arrow) 
			(rgba) = [ 128 128 128 0 ] 
		} 
	ENDIF 
	IF (ObjectExists) (id) = (special_tricks_menu_key_combo_down_arrow) 
		(SetScreenElementProps) { 
			(id) = (special_tricks_menu_key_combo_down_arrow) 
			(rgba) = [ 128 128 128 0 ] 
		} 
	ENDIF 
	IF (ObjectExists) (id) = (edit_tricks_menu_up_arrow) 
		(SetScreenElementProps) { 
			(id) = (edit_tricks_menu_up_arrow) 
			(rgba) = [ 128 128 128 0 ] 
		} 
	ENDIF 
	IF (ObjectExists) (id) = (edit_tricks_menu_down_arrow) 
		(SetScreenElementProps) { 
			(id) = (edit_tricks_menu_down_arrow) 
			(rgba) = [ 128 128 128 0 ] 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT (edit_tricks_menu_assign_current_menu_alias) 
	IF NOT (GotParam) (id) 
		(GetTags) 
	ENDIF 
	(AssignAlias) (id) = <id> (alias) = (current_menu) 
ENDSCRIPT

SCRIPT (edit_tricks_menu_exit) 
	IF (GotParam) (just_remove) 
		IF (ScreenElementExists) (id) = (current_menu_anchor) 
			(DestroyScreenElement) (id) = (current_menu_anchor) 
		ENDIF 
		IF (ScreenElementExists) (id) = (edit_tricks_sub_menu_anchor) 
			(DestroyScreenElement) (id) = (edit_tricks_sub_menu_anchor) 
		ENDIF 
		RETURN 
	ENDIF 
	IF (LevelIs) (load_skateshop) 
		(skater) : (add_skater_to_world) 
		(restore_start_key_binding) 
		(MakeSkaterGoto) (SkaterSelectAI) 
		(launch_ss_menu) (no_animate) 
	ELSE 
		(restore_start_key_binding) 
		IF (InNetGame) 
			(create_pause_menu) 
		ELSE 
			(edit_skater_options_menu) 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT (edit_tricks_sub_menu_exit) 
	IF (ObjectExists) (id) = (edit_tricks_sub_menu_anchor) 
		(DestroyScreenElement) (id) = (edit_tricks_sub_menu_anchor) 
		(wait) 1 (frame) 
	ENDIF 
	(GoalManager_ShowPoints) 
	IF NOT (GoalManager_HasActiveGoals) 
		(GoalManager_ShowGoalPoints) 
	ENDIF 
	(create_edit_tricks_menu) 
ENDSCRIPT

(edit_tricks_menu_grab_key_combos) = [ 
	(Air_CircleD) 
	(Air_CircleDL) 
	(Air_CircleDR) 
	(Air_CircleL) 
	(Air_CircleR) 
	(Air_CircleU) 
	(Air_CircleUL) 
	(Air_CircleUR) 
	(Air_D_D_Circle) 
	(Air_L_L_Circle) 
	(Air_R_R_Circle) 
	(Air_U_U_Circle) 
] 
(edit_tricks_menu_lip_key_combos) = [ 
	(Lip_TriangleD) 
	(Lip_TriangleDL) 
	(Lip_TriangleDR) 
	(Lip_TriangleL) 
	(Lip_TriangleR) 
	(Lip_TriangleU) 
	(Lip_TriangleUL) 
	(Lip_TriangleUR) 
] 
(edit_tricks_menu_flip_key_combos) = [ 
	(Air_SquareD) 
	(Air_SquareDL) 
	(Air_SquareDR) 
	(Air_SquareL) 
	(Air_SquareR) 
	(Air_SquareU) 
	(Air_SquareUL) 
	(Air_SquareUR) 
	(Air_D_D_Square) 
	(Air_L_L_Square) 
	(Air_R_R_Square) 
	(Air_U_U_Square) 
] 
(special_trick_types) = [ 
	{ (type) = (FlipTrick) (Heading) = "Air Tricks" } 
	{ (type) = (GrabTrick) (Heading) = "Grab Tricks" } 
	{ (type) = (LipMacro2) (Heading) = "Lip Tricks" } 
	{ (type) = (GrindTrick) (Heading) = "Grind Tricks" } 
	{ (type) = (Manual) (Heading) = "Manual Tricks" } 
	{ (type) = (GrabTrick) (Heading) = "Created Tricks" (add_cats) } 
] 
(special_trick_air_key_combos) = [ 
	(SpAir_D_L_Circle) 
	(SpAir_D_R_Circle) 
	(SpAir_D_U_Circle) 
	(SpAir_L_D_Circle) 
	(SpAir_L_R_Circle) 
	(SpAir_L_U_Circle) 
	(SpAir_R_D_Circle) 
	(SpAir_R_L_Circle) 
	(SpAir_R_U_Circle) 
	(SpAir_U_D_Circle) 
	(SpAir_U_L_Circle) 
	(SpAir_U_R_Circle) 
	(SpAir_D_L_Square) 
	(SpAir_D_R_Square) 
	(SpAir_D_U_Square) 
	(SpAir_L_D_Square) 
	(SpAir_L_R_Square) 
	(SpAir_L_U_Square) 
	(SpAir_R_D_Square) 
	(SpAir_R_L_Square) 
	(SpAir_R_U_Square) 
	(SpAir_U_D_Square) 
	(SpAir_U_L_Square) 
	(SpAir_U_R_Square) 
] 
(special_trick_grind_key_combos) = [ 
	(SpGrind_D_L_Triangle) 
	(SpGrind_D_R_Triangle) 
	(SpGrind_D_U_Triangle) 
	(SpGrind_L_D_Triangle) 
	(SpGrind_L_R_Triangle) 
	(SpGrind_L_U_Triangle) 
	(SpGrind_R_D_Triangle) 
	(SpGrind_R_L_Triangle) 
	(SpGrind_R_U_Triangle) 
	(SpGrind_U_D_Triangle) 
	(SpGrind_U_L_Triangle) 
	(SpGrind_U_R_Triangle) 
] 
(special_trick_lip_key_combos) = [ 
	(SpLip_D_L_Triangle) 
	(SpLip_D_R_Triangle) 
	(SpLip_D_U_Triangle) 
	(SpLip_L_D_Triangle) 
	(SpLip_L_R_Triangle) 
	(SpLip_L_U_Triangle) 
	(SpLip_R_D_Triangle) 
	(SpLip_R_L_Triangle) 
	(SpLip_R_U_Triangle) 
	(SpLip_U_D_Triangle) 
	(SpLip_U_L_Triangle) 
	(SpLip_U_R_Triangle) 
	(SpLip_U_U_Triangle) 
] 
(special_trick_manual_key_combos) = [ 
	(SpMan_D_L_Triangle) 
	(SpMan_D_R_Triangle) 
	(SpMan_D_U_Triangle) 
	(SpMan_L_D_Triangle) 
	(SpMan_L_R_Triangle) 
	(SpMan_L_U_Triangle) 
	(SpMan_R_D_Triangle) 
	(SpMan_R_L_Triangle) 
	(SpMan_R_U_Triangle) 
	(SpMan_U_D_Triangle) 
	(SpMan_U_L_Triangle) 
	(SpMan_U_R_Triangle) 
] 

