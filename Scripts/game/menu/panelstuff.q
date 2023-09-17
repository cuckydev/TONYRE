(balance_meter_info) = { 
	(bar_positions) = [ 
		PAIR(320, 165) 
		PAIR(250, 224) 
	] 
	(bar_positions_mp_h) = [ 
		PAIR(320, 70) 
		PAIR(250, 130) 
	] 
	(bar_positions_mp_v) = [ 
		PAIR(140, 130) 
		PAIR(80, 224) 
	] 
	(arrow_positions) = [ 
		PAIR(0, -17) 
		PAIR(10, -17) 
		PAIR(20, -15) 
		PAIR(30, -11) 
		PAIR(40, -6) 
		PAIR(50, 1) 
		PAIR(60, 12) 
	] 
} 
(special_bar_colors) = (default_bar_colors) 
(default_bar_colors) = [ 
	[ 128 0 9 128 ] 
	[ 81 107 128 128 ] 
	[ 128 0 9 128 ] 
] 
(special_bar_iterpolator_rate) = 0.10000000149 
SCRIPT (hide_panel_stuff) 
	(printf) "*************** HIDING PANEL STUFF *********************" 
	IF (ObjectExists) (id) = (player1_panel_container) 
		(printf) "*************** HIDING PANEL STUFF 2 *********************" 
		(DoScreenElementMorph) { 
			(id) = (player1_panel_container) 
			(alpha) = 0 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT (show_panel_stuff) 
	(printf) "*************** SHOWING PANEL STUFF *********************" 
	IF (ObjectExists) (id) = (player1_panel_container) 
		(printf) "*************** HIDING PANEL STUFF 2 *********************" 
		(DoScreenElementMorph) { 
			(id) = (player1_panel_container) 
			(alpha) = 1 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT (destroy_panel_stuff) 
	IF (ScreenElementExists) (id) = (player1_panel_container) 
		(DestroyScreenElement) (id) = (player1_panel_container) 
	ENDIF 
	IF (ScreenElementExists) (id) = (player2_panel_container) 
		(DestroyScreenElement) (id) = (player2_panel_container) 
	ENDIF 
	IF (ScreenElementExists) (id) = (the_time) 
		(DestroyScreenElement) (id) = (the_time) 
	ENDIF 
	IF (ScreenElementExists) (id) = (current_goal) 
		(DestroyScreenElement) (id) = (current_goal) 
	ENDIF 
	IF (ScreenElementExists) (id) = (current_goal_key_combo_text) 
		(DestroyScreenElement) (id) = (current_goal_key_combo_text) 
	ENDIF 
	IF (ScreenElementExists) (id) = (cash_goal_sprite) 
		(DestroyScreenElement) (id) = (cash_goal_sprite) 
	ENDIF 
	IF (ScreenElementExists) (id) = (cash_text) 
		(DestroyScreenElement) (id) = (cash_text) 
	ENDIF 
	IF (ScreenElementExists) (id) = (goal_points_text) 
		(DestroyScreenElement) (id) = (goal_points_text) 
	ENDIF 
	IF (ScreenElementExists) (id) = (minigame_timer) 
		(DestroyScreenElement) (id) = (minigame_timer) 
	ENDIF 
	IF (ScreenElementExists) (id) = (minigame_timer) 
		(DestroyScreenElement) (id) = (minigame_timer) 
	ENDIF 
	IF (ScreenElementExists) (id) = (net_score_menu) 
		(DestroyScreenElement) (id) = (net_score_menu) 
	ENDIF 
ENDSCRIPT

SCRIPT (create_panel_stuff) 
	IF (InSplitScreenGame) 
		(ScriptGetScreenMode) 
		SWITCH <screen_mode> 
			CASE (horse1) 
			CASE (horse2) 
			CASE (split_vertical) 
			CASE (one_camera) 
				(timer_pos) = PAIR(285.00000000000, 20.00000000000) 
				(timer_scale) = 1.00000000000 
				IF (GameModeEquals) (is_horse) 
					(trick_text_dims) = PAIR(575.00000000000, 70.00000000000) 
					(trick_text_pos) = PAIR(287.00000000000, 2.00000000000) 
					(player1_panel_dims) = PAIR(640.00000000000, 448.00000000000) 
					(player1_panel_pos) = PAIR(0.00000000000, 0.00000000000) 
					(player2_panel_dims) = PAIR(640.00000000000, 448.00000000000) 
					(player2_panel_pos) = PAIR(0.00000000000, 0.00000000000) 
				ELSE 
					(trick_text_dims) = PAIR(240.00000000000, 70.00000000000) 
					(trick_text_pos) = PAIR(120.00000000000, 2.00000000000) 
					(player1_panel_dims) = PAIR(320.00000000000, 448.00000000000) 
					(player1_panel_pos) = PAIR(0.00000000000, 0.00000000000) 
					(player2_panel_dims) = PAIR(320.00000000000, 448.00000000000) 
					(player2_panel_pos) = PAIR(320.00000000000, 0.00000000000) 
				ENDIF 
				(CreateScreenElement) { 
					(id) = (player1_panel_container) 
					(type) = (ContainerElement) 
					(parent) = (root_window) 
					(scale) = 1.00000000000 
					(dims) = PAIR(320.00000000000, 448.00000000000) 
					(pos) = PAIR(0.00000000000, 0.00000000000) 
					(just) = [ (top) (left) ] 
				} 
				(CreateScreenElement) { 
					(id) = (player2_panel_container) 
					(type) = (ContainerElement) 
					(parent) = (root_window) 
					(scale) = 1.00000000000 
					(dims) = <player2_panel_dims> 
					(pos) = <player2_panel_pos> 
					(just) = [ (top) (left) ] 
				} 
			CASE (split_horizontal) 
				(trick_text_dims) = PAIR(575.00000000000, 30.00000000000) 
				(trick_text_pos) = PAIR(287.00000000000, 2.00000000000) 
				(timer_pos) = PAIR(300.00000000000, 20.00000000000) 
				(timer_scale) = 1.00000000000 
				(CreateScreenElement) { 
					(id) = (player1_panel_container) 
					(type) = (ContainerElement) 
					(parent) = (root_window) 
					(scale) = 1.00000000000 
					(dims) = <player1_panel_dims> 
					(pos) = <player1_panel_pos> 
					(just) = [ (top) (left) ] 
				} 
				(CreateScreenElement) { 
					(id) = (player2_panel_container) 
					(type) = (ContainerElement) 
					(parent) = (root_window) 
					(scale) = 1.00000000000 
					(dims) = PAIR(640.00000000000, 224.00000000000) 
					(pos) = PAIR(0.00000000000, 224.00000000000) 
					(just) = [ (top) (left) ] 
				} 
		ENDSWITCH 
	ELSE 
		(trick_text_dims) = PAIR(575.00000000000, 70.00000000000) 
		(trick_text_pos) = PAIR(287.00000000000, 2.00000000000) 
		(timer_pos) = PAIR(300.00000000000, 20.00000000000) 
		(timer_scale) = 1.29999995232 
		(CreateScreenElement) { 
			(id) = (player1_panel_container) 
			(type) = (ContainerElement) 
			(parent) = (root_window) 
			(scale) = 1.00000000000 
			(dims) = PAIR(640.00000000000, 448.00000000000) 
			(pos) = PAIR(0.00000000000, 0.00000000000) 
			(just) = [ (top) (left) ] 
		} 
	ENDIF 
	IF (ScreenElementExists) (id) = (goal_retry_pad_select) 
		(DestroyScreenElement) (id) = (goal_retry_pad_select) 
	ENDIF 
	(CreateScreenElement) { 
		(type) = (ContainerElement) 
		(parent) = (root_window) 
		(id) = (goal_retry_pad_select) 
		(pos) = PAIR(0.00000000000, 0.00000000000) 
		(dims) = PAIR(0.00000000000, 0.00000000000) 
		(event_handlers) = [ 
			{ (pad_select) (goal_retry_select_handler) } 
		] 
	} 
	(FireEvent) (type) = (focus) (target) = (goal_retry_pad_select) 
	(CreateScreenElement) { 
		(id) = (the_time) 
		(type) = (textelement) 
		(parent) = (root_window) 
		(font) = (newtimerfont) 
		(text) = "" 
		(scale) = <timer_scale> 
		(pos) = <timer_pos> 
		(just) = [ (center) (top) ] 
		(rgba) = [ 128 128 128 68 ] 
		(z_priority) = -1 
	} 
	(CreateScreenElement) { 
		(id) = (current_goal) 
		(type) = (TextBlockElement) 
		(parent) = (root_window) 
		(font) = (small) 
		(internal_scale) = 0.80000001192 
		(text) = " " 
		(pos) = PAIR(620.00000000000, 10.00000000000) 
		(just) = [ (right) (top) ] 
		(internal_just) = [ (center) (top) ] 
		(dims) = PAIR(250.00000000000, 100.00000000000) 
		(rgba) = [ 128 128 128 110 ] 
		(shadow) 
		(shadow_offs) = PAIR(0.50000000000, 0.50000000000) 
		(shadow_rgba) = [ 30 30 30 100 ] 
	} 
	(FormatText) (ChecksumName) = (cash_color) "%i_HUD_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (root_window) 
		(id) = (cash_goal_sprite) 
		(texture) = (cash_goal) 
		(scale) = 0 
		(just) = [ (left) (top) ] 
		(pos) = PAIR(473.00000000000, 28.00000000000) 
		(alpha) = 0 
		(rgba) = <cash_color> 
		(z_priority) = -10 
	} 
	(CreateScreenElement) { 
		(type) = (textelement) 
		(parent) = (root_window) 
		(id) = (cash_text) 
		(font) = (small) 
		(text) = " " 
		(scale) = 0 
		(pos) = PAIR(563.00000000000, 25.00000000000) 
		(just) = [ (left) (top) ] 
		(rgba) = [ 105 105 105 128 ] 
	} 
	(CreateScreenElement) { 
		(type) = (textelement) 
		(parent) = (root_window) 
		(id) = (goal_points_text) 
		(font) = (small) 
		(pos) = PAIR(585.00000000000, 40.00000000000) 
		(just) = [ (left) (top) ] 
		(scale) = 0 
		(rgba) = [ 105 105 105 128 ] 
		(text) = " " 
	} 
	(CreateScreenElement) { 
		(type) = (textelement) 
		(parent) = (root_window) 
		(id) = (minigame_timer) 
		(font) = (small) 
		(pos) = PAIR(19.00000000000, 180.00000000000) 
		(just) = [ (left) , (top) ] 
		(scale) = 0.80000001192 
		(rgba) = [ 26 51 83 128 ] 
	} 
	(CreateScreenElement) { 
		(id) = (the_score) 
		(type) = (textelement) 
		(parent) = (player1_panel_container) 
		(font) = (small) 
		(text) = "0" 
		(scale) = 1.00000000000 
		(pos) = PAIR(136.00000000000, 27.00000000000) 
		(just) = [ (left) (top) ] 
		(rgba) = [ 105 105 105 128 ] 
	} 
	(FormatText) (ChecksumName) = (score_color) "%i_HUD_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(FormatText) (ChecksumName) = (special_color) "%i_HUD_SPECIAL_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(CreateScreenElement) { 
		(id) = (the_score_sprite) 
		(type) = (SpriteElement) 
		(parent) = (the_score) 
		(texture) = (score_small) 
		(scale) = PAIR(1.20000004768, 0.85000002384) 
		(pos) = PAIR(-17.00000000000, 23.00000000000) 
		(rgba) = <score_color> 
	} 
	(CreateScreenElement) { 
		(id) = (the_special_bar_special) 
		(type) = (SpriteElement) 
		(parent) = (the_score_sprite) 
		(texture) = (special) 
		(scale) = PAIR(1.73000001907, 0.87000000477) 
		(pos) = PAIR(10.00000000000, 34.00000000000) 
		(just) = [ (left) (top) ] 
		(rgba) = <special_color> 
		(z_priority) = 5000 
	} 
	(CreateScreenElement) { 
		(id) = (the_special_bar_sprite) 
		(type) = (SpriteElement) 
		(parent) = (the_score_sprite) 
		(texture) = (specialbar) 
		(scale) = PAIR(1.00000000000, 1.20000004768) 
		(pos) = PAIR(9.00000000000, 35.00000000000) 
		(just) = [ (left) (top) ] 
		(rgba) = [ 128 128 128 100 ] 
	} 
	(CreateScreenElement) { 
		(id) = (the_boardstance_sprite) 
		(type) = (SpriteElement) 
		(parent) = (the_score_sprite) 
		(texture) = (nollie_icon) 
		(scale) = PAIR(0.75000000000, 1.29999995232) 
		(just) = [ (left) (top) ] 
		(pos) = PAIR(123.00000000000, 45.00000000000) 
		(rot_angle) = 90 
		(rgba) = [ 128 128 128 78 ] 
	} 
	(FormatText) (ChecksumName) = (sponsor_texture) "%i_sponsor" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(CreateScreenElement) { 
		(id) = (generic_sponsor_logo) 
		(type) = (SpriteElement) 
		(parent) = (the_score_sprite) 
		(texture) = <sponsor_texture> 
		(scale) = PAIR(0.85000002384, 0.85000002384) 
		(just) = [ (left) (top) ] 
		(pos) = PAIR(-32.00000000000, 0.00000000000) 
		(rgba) = [ 128 128 128 108 ] 
		(z_priority) = 3 
	} 
	(CreateScreenElement) { 
		(id) = (trick_text_container) 
		(type) = (ContainerElement) 
		(parent) = (player1_panel_container) 
		(scale) = 1.00000000000 
		(dims) = <trick_text_dims> 
		(just) = [ (center) (center) ] 
		(alpha) = 0.00000000000 
	} 
	(CreateScreenElement) { 
		(id) = (the_trick_text) 
		(type) = (TextBlockElement) 
		(parent) = (trick_text_container) 
		(scale) = 1.00000000000 
		(pos) = { PAIR(0.50000000000, 0.00000000000) (proportional) } 
		(dims) = <trick_text_dims> 
		(just) = [ (center) (top) ] 
		(internal_just) = [ (center) (top) ] 
		(font) = (newtrickfont) 
		(text) = " " 
		(internal_scale) = 0.69999998808 
		(alpha) = 1.00000000000 
		(tags) = { (tag_state) = (inactive) } 
		(shadow) 
		(shadow_offs) = PAIR(1.00000000000, 1.00000000000) 
		(shadow_rgba) = [ 30 30 30 75 ] 
		(z_priority) = 0 
	} 
	(CreateScreenElement) { 
		(id) = (the_score_pot_text) 
		(type) = (textelement) 
		(parent) = (trick_text_container) 
		(scale) = 1.00000000000 
		(pos) = { PAIR(0.50000000000, 0.00000000000) (proportional) } 
		(just) = [ (center) (bottom) ] 
		(font) = (small) 
		(text) = " " 
		(alpha) = 1.00000000000 
		(z_priority) = 0 
	} 
	(reset_trick_text_appearance) (the_score_pot_text_id) = (the_score_pot_text) (the_trick_text_id) = (the_trick_text) (trick_text_container_id) = (trick_text_container) 
	(CreateScreenElement) { 
		(id) = (the_balance_meter) 
		(type) = (SpriteElement) 
		(parent) = (player1_panel_container) 
		(texture) = (balancemeter) 
		(scale) = 1.00000000000 
		(just) = [ (center) (center) ] 
		(rgba) = [ 128 128 128 0 ] 
		(tags) = { (tag_turned_on) = 0 (tag_mode) = (balance) } 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (the_balance_meter) 
		(texture) = (balancearrow_glow) 
		(scale) = 1.20000004768 
		(pos) = PAIR(0.00000000000, 0.00000000000) 
		(just) = [ (center) (center) ] 
		(rgba) = [ 128 128 128 0 ] 
		(z_priority) = 3 
	} 
	IF (InSplitScreenGame) 
		(ScriptGetScreenMode) 
		(ScriptGetScreenMode) 
		SWITCH <screen_mode> 
			CASE (split_vertical) 
				(CreateScreenElement) { 
					(id) = (the_run_timer) 
					(type) = (SpriteElement) 
					(parent) = (player1_panel_container) 
					(texture) = (watch) 
					(scale) = 1.00000000000 
					(just) = [ (center) (center) ] 
					(pos) = PAIR(240.00000000000, 240.00000000000) 
					(alpha) = 0 
					(rgba) = [ 128 128 128 90 ] 
					(tags) = { (tag_turned_on) = 0 (tag_mode) = (balance) } 
				} 
			CASE (split_horizontal) 
				(CreateScreenElement) { 
					(id) = (the_run_timer) 
					(type) = (SpriteElement) 
					(parent) = (player1_panel_container) 
					(texture) = (watch) 
					(scale) = 1.00000000000 
					(just) = [ (center) (center) ] 
					(pos) = PAIR(500.00000000000, 120.00000000000) 
					(alpha) = 0 
					(rgba) = [ 128 128 128 90 ] 
					(tags) = { (tag_turned_on) = 0 (tag_mode) = (balance) } 
				} 
			DEFAULT 
				(CreateScreenElement) { 
					(id) = (the_run_timer) 
					(type) = (SpriteElement) 
					(parent) = (player1_panel_container) 
					(texture) = (watch) 
					(scale) = 1.00000000000 
					(just) = [ (center) (center) ] 
					(pos) = PAIR(400.00000000000, 240.00000000000) 
					(alpha) = 0 
					(rgba) = [ 128 128 128 90 ] 
					(tags) = { (tag_turned_on) = 0 (tag_mode) = (balance) } 
				} 
		ENDSWITCH 
	ELSE 
		(CreateScreenElement) { 
			(id) = (the_run_timer) 
			(type) = (SpriteElement) 
			(parent) = (player1_panel_container) 
			(texture) = (watch) 
			(scale) = 1.00000000000 
			(just) = [ (center) (center) ] 
			(pos) = PAIR(400.00000000000, 240.00000000000) 
			(alpha) = 0 
			(rgba) = [ 128 128 128 90 ] 
			(tags) = { (tag_turned_on) = 0 (tag_mode) = (balance) } 
		} 
	ENDIF 
	(CreateScreenElement) { 
		(id) = (the_run_timer_hand) 
		(type) = (SpriteElement) 
		(parent) = (the_run_timer) 
		(texture) = (hand) 
		(scale) = 1.00000000000 
		(pos) = PAIR(24.00000000000, 24.00000000000) 
		(just) = [ (center) (center) ] 
		(rgba) = [ 128 128 128 128 ] 
		(z_priority) = 5 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (the_run_timer) 
		(texture) = (time_1) 
		(scale) = 1.00000000000 
		(pos) = PAIR(7.00000000000, 8.00000000000) 
		(just) = [ (left) (top) ] 
		(rgba) = [ 128 128 128 128 ] 
		(z_priority) = 3 
	} 
	(GetStackedScreenElementPos) (Y) (id) = <id> 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (the_run_timer) 
		(texture) = (time_2) 
		(scale) = 1.00000000000 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(rgba) = [ 128 128 128 128 ] 
		(z_priority) = 3 
	} 
	(GetStackedScreenElementPos) (Y) (id) = <id> 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (the_run_timer) 
		(texture) = (time_3) 
		(scale) = 1.00000000000 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(rgba) = [ 128 128 128 128 ] 
		(z_priority) = 3 
	} 
	(GetStackedScreenElementPos) (Y) (id) = <id> 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (the_run_timer) 
		(texture) = (time_4) 
		(scale) = 1.00000000000 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(rgba) = [ 128 128 128 128 ] 
		(z_priority) = 3 
	} 
	(GetStackedScreenElementPos) (Y) (id) = <id> 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (the_run_timer) 
		(texture) = (time_5) 
		(scale) = 1.00000000000 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(rgba) = [ 128 128 128 128 ] 
		(z_priority) = 3 
	} 
	(GetStackedScreenElementPos) (Y) (id) = <id> 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (the_run_timer) 
		(texture) = (time_6) 
		(scale) = 1.00000000000 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(rgba) = [ 128 128 128 128 ] 
		(z_priority) = 3 
	} 
	(GetStackedScreenElementPos) (Y) (id) = <id> 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (the_run_timer) 
		(texture) = (time_7) 
		(scale) = 1.00000000000 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(rgba) = [ 128 128 128 128 ] 
		(z_priority) = 3 
	} 
	(GetStackedScreenElementPos) (Y) (id) = <id> 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (the_run_timer) 
		(texture) = (time_8) 
		(scale) = 1.00000000000 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(rgba) = [ 128 128 128 128 ] 
		(z_priority) = 3 
	} 
	IF (InSplitScreenGame) 
		(CreateScreenElement) { 
			(id) = ( (the_score) + 1 ) 
			(type) = (textelement) 
			(parent) = (player2_panel_container) 
			(font) = (small) 
			(text) = "0" 
			(scale) = 1.00000000000 
			(pos) = PAIR(136.00000000000, 27.00000000000) 
			(just) = [ (left) (top) ] 
			(rgba) = [ 105 105 105 128 ] 
		} 
		(FormatText) (ChecksumName) = (score_color) "%i_HUD_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
		(FormatText) (ChecksumName) = (special_color) "%i_HUD_SPECIAL_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
		(CreateScreenElement) { 
			(id) = ( (the_score_sprite) + 1 ) 
			(type) = (SpriteElement) 
			(parent) = ( (the_score) + 1 ) 
			(texture) = (score_small) 
			(scale) = PAIR(1.20000004768, 0.85000002384) 
			(pos) = PAIR(-17.00000000000, 23.00000000000) 
			(rgba) = <score_color> 
		} 
		(CreateScreenElement) { 
			(id) = ( (the_special_bar_special) + 1 ) 
			(type) = (SpriteElement) 
			(parent) = ( (the_score_sprite) + 1 ) 
			(texture) = (special) 
			(scale) = PAIR(1.73000001907, 0.87000000477) 
			(pos) = PAIR(10.00000000000, 34.00000000000) 
			(just) = [ (left) (top) ] 
			(rgba) = <special_color> 
			(z_priority) = 5000 
		} 
		(CreateScreenElement) { 
			(id) = ( (the_special_bar_sprite) + 1 ) 
			(type) = (SpriteElement) 
			(parent) = ( (the_score_sprite) + 1 ) 
			(texture) = (specialbar) 
			(scale) = PAIR(1.00000000000, 1.20000004768) 
			(pos) = PAIR(9.00000000000, 35.00000000000) 
			(just) = [ (left) (top) ] 
			(rgba) = [ 128 128 128 100 ] 
		} 
		(CreateScreenElement) { 
			(id) = ( (the_boardstance_sprite) + 1 ) 
			(type) = (SpriteElement) 
			(parent) = ( (the_score_sprite) + 1 ) 
			(texture) = (nollie_icon) 
			(scale) = PAIR(0.75000000000, 1.29999995232) 
			(just) = [ (left) (top) ] 
			(pos) = PAIR(123.00000000000, 45.00000000000) 
			(rot_angle) = 90 
			(rgba) = [ 128 128 128 78 ] 
		} 
		(CreateScreenElement) { 
			(id) = ( (generic_sponsor_logo) + 1 ) 
			(type) = (SpriteElement) 
			(parent) = ( (the_score_sprite) + 1 ) 
			(texture) = <sponsor_texture> 
			(scale) = PAIR(0.85000002384, 0.85000002384) 
			(just) = [ (left) (top) ] 
			(pos) = PAIR(-32.00000000000, 0.00000000000) 
			(rgba) = [ 128 128 128 108 ] 
			(z_priority) = 3 
		} 
		(CreateScreenElement) { 
			(id) = ( (trick_text_container) + 1 ) 
			(type) = (ContainerElement) 
			(parent) = (player2_panel_container) 
			(scale) = 1.00000000000 
			(dims) = <trick_text_dims> 
			(just) = [ (center) (center) ] 
			(alpha) = 0.00000000000 
		} 
		(CreateScreenElement) { 
			(id) = ( (the_trick_text) + 1 ) 
			(type) = (TextBlockElement) 
			(parent) = ( (trick_text_container) + 1 ) 
			(scale) = 1.00000000000 
			(pos) = { PAIR(0.50000000000, 0.00000000000) (proportional) } 
			(dims) = <trick_text_dims> 
			(just) = [ (center) (top) ] 
			(internal_just) = [ (center) (top) ] 
			(font) = (newtrickfont) 
			(text) = " " 
			(internal_scale) = 0.69999998808 
			(alpha) = 1.00000000000 
			(tags) = { (tag_state) = (inactive) } 
			(shadow) 
			(shadow_offs) = PAIR(1.00000000000, 1.00000000000) 
			(shadow_rgba) = [ 30 30 30 75 ] 
			(z_priority) = 0 
		} 
		(CreateScreenElement) { 
			(id) = ( (the_score_pot_text) + 1 ) 
			(type) = (textelement) 
			(parent) = ( (trick_text_container) + 1 ) 
			(scale) = 1.00000000000 
			(pos) = <trick_text_pos> 
			(just) = [ (center) (bottom) ] 
			(font) = (small) 
			(text) = " " 
			(alpha) = 1.00000000000 
			(z_priority) = 0 
		} 
		(reset_trick_text_appearance) (the_score_pot_text_id) = ( (the_score_pot_text) + 1 ) (the_trick_text_id) = ( (the_trick_text) + 1 ) (trick_text_container_id) = ( (trick_text_container) + 1 ) 
		(CreateScreenElement) { 
			(id) = ( (the_balance_meter) + 1 ) 
			(type) = (SpriteElement) 
			(parent) = (player2_panel_container) 
			(texture) = (balancemeter) 
			(scale) = 1.00000000000 
			(just) = [ (center) (center) ] 
			(rgba) = [ 128 128 128 0 ] 
			(tags) = { (tag_turned_on) = 0 (tag_mode) = (balance) } 
		} 
		(CreateScreenElement) { 
			(type) = (SpriteElement) 
			(parent) = ( (the_balance_meter) + 1 ) 
			(texture) = (balancearrow_glow) 
			(scale) = 1.20000004768 
			(pos) = PAIR(0.00000000000, 0.00000000000) 
			(just) = [ (center) (center) ] 
			(rgba) = [ 128 128 128 0 ] 
		} 
		(ScriptGetScreenMode) 
		SWITCH <screen_mode> 
			CASE (split_vertical) 
				(CreateScreenElement) { 
					(id) = ( (the_run_timer) + 1 ) 
					(type) = (SpriteElement) 
					(parent) = (player2_panel_container) 
					(texture) = (watch) 
					(scale) = 1.00000000000 
					(just) = [ (center) (center) ] 
					(pos) = PAIR(240.00000000000, 240.00000000000) 
					(alpha) = 0 
					(rgba) = [ 128 128 128 90 ] 
					(tags) = { (tag_turned_on) = 0 (tag_mode) = (balance) } 
				} 
			CASE (split_horizontal) 
				(CreateScreenElement) { 
					(id) = ( (the_run_timer) + 1 ) 
					(type) = (SpriteElement) 
					(parent) = (player2_panel_container) 
					(texture) = (watch) 
					(scale) = 1.00000000000 
					(just) = [ (center) (center) ] 
					(pos) = PAIR(500.00000000000, 120.00000000000) 
					(alpha) = 0 
					(rgba) = [ 128 128 128 90 ] 
					(tags) = { (tag_turned_on) = 0 (tag_mode) = (balance) } 
				} 
			DEFAULT 
				(CreateScreenElement) { 
					(id) = ( (the_run_timer) + 1 ) 
					(type) = (SpriteElement) 
					(parent) = (player2_panel_container) 
					(texture) = (watch) 
					(scale) = 1.00000000000 
					(just) = [ (center) (center) ] 
					(pos) = PAIR(400.00000000000, 240.00000000000) 
					(alpha) = 0 
					(rgba) = [ 128 128 128 90 ] 
					(tags) = { (tag_turned_on) = 0 (tag_mode) = (balance) } 
				} 
		ENDSWITCH 
		(CreateScreenElement) { 
			(id) = ( (the_run_timer_hand) + 1 ) 
			(type) = (SpriteElement) 
			(parent) = ( (the_run_timer) + 1 ) 
			(texture) = (hand) 
			(scale) = 1.00000000000 
			(pos) = PAIR(24.00000000000, 24.00000000000) 
			(just) = [ (center) (center) ] 
			(rgba) = [ 128 128 128 128 ] 
			(z_priority) = 5 
		} 
		(CreateScreenElement) { 
			(type) = (SpriteElement) 
			(parent) = ( (the_run_timer) + 1 ) 
			(texture) = (time_1) 
			(scale) = 1.00000000000 
			(pos) = PAIR(7.00000000000, 8.00000000000) 
			(just) = [ (left) (top) ] 
			(rgba) = [ 128 128 128 128 ] 
			(z_priority) = 3 
		} 
		(GetStackedScreenElementPos) (Y) (id) = <id> 
		(CreateScreenElement) { 
			(type) = (SpriteElement) 
			(parent) = ( (the_run_timer) + 1 ) 
			(texture) = (time_2) 
			(scale) = 1.00000000000 
			(pos) = <pos> 
			(just) = [ (left) (top) ] 
			(rgba) = [ 128 128 128 128 ] 
			(z_priority) = 3 
		} 
		(GetStackedScreenElementPos) (Y) (id) = <id> 
		(CreateScreenElement) { 
			(type) = (SpriteElement) 
			(parent) = ( (the_run_timer) + 1 ) 
			(texture) = (time_3) 
			(scale) = 1.00000000000 
			(pos) = <pos> 
			(just) = [ (left) (top) ] 
			(rgba) = [ 128 128 128 128 ] 
			(z_priority) = 3 
		} 
		(GetStackedScreenElementPos) (Y) (id) = <id> 
		(CreateScreenElement) { 
			(type) = (SpriteElement) 
			(parent) = ( (the_run_timer) + 1 ) 
			(texture) = (time_4) 
			(scale) = 1.00000000000 
			(pos) = <pos> 
			(just) = [ (left) (top) ] 
			(rgba) = [ 128 128 128 128 ] 
			(z_priority) = 3 
		} 
		(GetStackedScreenElementPos) (Y) (id) = <id> 
		(CreateScreenElement) { 
			(type) = (SpriteElement) 
			(parent) = ( (the_run_timer) + 1 ) 
			(texture) = (time_5) 
			(scale) = 1.00000000000 
			(pos) = <pos> 
			(just) = [ (left) (top) ] 
			(rgba) = [ 128 128 128 128 ] 
			(z_priority) = 3 
		} 
		(GetStackedScreenElementPos) (Y) (id) = <id> 
		(CreateScreenElement) { 
			(type) = (SpriteElement) 
			(parent) = ( (the_run_timer) + 1 ) 
			(texture) = (time_6) 
			(scale) = 1.00000000000 
			(pos) = <pos> 
			(just) = [ (left) (top) ] 
			(rgba) = [ 128 128 128 128 ] 
			(z_priority) = 3 
		} 
		(GetStackedScreenElementPos) (Y) (id) = <id> 
		(CreateScreenElement) { 
			(type) = (SpriteElement) 
			(parent) = ( (the_run_timer) + 1 ) 
			(texture) = (time_7) 
			(scale) = 1.00000000000 
			(pos) = <pos> 
			(just) = [ (left) (top) ] 
			(rgba) = [ 128 128 128 128 ] 
			(z_priority) = 3 
		} 
		(GetStackedScreenElementPos) (Y) (id) = <id> 
		(CreateScreenElement) { 
			(type) = (SpriteElement) 
			(parent) = ( (the_run_timer) + 1 ) 
			(texture) = (time_8) 
			(scale) = 1.00000000000 
			(pos) = <pos> 
			(just) = [ (left) (top) ] 
			(rgba) = [ 128 128 128 128 ] 
			(z_priority) = 3 
		} 
	ENDIF 
	IF (GetGlobalFlag) (flag) = (NO_DISPLAY_HUD) 
		(GoalManager_HidePoints) 
		(GoalManager_HideGoalPoints) 
	ENDIF 
	IF (InNetGame) 
		IF (IsObserving) 
			(hide_panel_stuff) 
		ENDIF 
		(create_score_menu) 
	ENDIF 
ENDSCRIPT

(newtrickfont_colors) = [ 
	[ 0 128 230 60 ] 
	[ 200 90 11 60 ] 
	[ 0 128 0 60 ] 
	[ 128 0 0 60 ] 
	[ 88 105 112 128 ] 
] 
SCRIPT (UpdateScorepot) 
	IF (GetGlobalFlag) (flag) = (NO_DISPLAY_BASESCORE) 
		(DoScreenElementMorph) (id) = (the_score_pot_text) (alpha) = 0.00000000000 (remember_alpha) 
		IF (InSplitScreenGame) 
			IF (ScreenElementExists) (id) = ( (the_score_pot_text) + 1 ) 
				(DoScreenElementMorph) (id) = ( (the_score_pot_text) + 1 ) (alpha) = 0.00000000000 (remember_alpha) 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT (UpdateTrickText) 
	IF (GetGlobalFlag) (flag) = (NO_DISPLAY_TRICKSTRING) 
		(DoScreenElementMorph) (id) = (the_trick_text) (alpha) = 0.00000000000 (remember_alpha) 
		(SetScreenElementProps) (id) = (the_trick_text) (override_encoded_rgba) (remember_override_rgba_state) 
		IF (InSplitScreenGame) 
			IF (ScreenElementExists) (id) = ( (the_trick_text) + 1 ) 
				(DoScreenElementMorph) (id) = ( (the_trick_text) + 1 ) (alpha) = 0.00000000000 (remember_alpha) 
				(SetScreenElementProps) (id) = ( (the_trick_text) + 1 ) (override_encoded_rgba) (remember_override_rgba_state) 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT (pause_trick_text) 
	(SetScreenElementProps) (id) = (the_trick_text) (hide) 
	IF (InSplitScreenGame) 
		IF (ScreenElementExists) (id) = ( (the_trick_text) + 1 ) 
			(SetScreenElementProps) (id) = ( (the_trick_text) + 1 ) (hide) 
		ENDIF 
	ENDIF 
	(SetScreenElementProps) (id) = (the_score_pot_text) (hide) 
	IF (InSplitScreenGame) 
		IF (ScreenElementExists) (id) = ( (the_score_pot_text) + 1 ) 
			(SetScreenElementProps) (id) = ( (the_score_pot_text) + 1 ) (hide) 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT (unpause_trick_text) 
	IF NOT (GetGlobalFlag) (flag) = (NO_DISPLAY_TRICKSTRING) 
		(SetScreenElementProps) (id) = (the_trick_text) (unhide) 
		IF (InSplitScreenGame) 
			IF (ScreenElementExists) (id) = ( (the_trick_text) + 1 ) 
				(SetScreenElementProps) (id) = ( (the_trick_text) + 1 ) (unhide) 
			ENDIF 
		ENDIF 
	ENDIF 
	IF NOT (GetGlobalFlag) (flag) = (NO_DISPLAY_BASESCORE) 
		(SetScreenElementProps) (id) = (the_score_pot_text) (unhide) 
		IF (InSplitScreenGame) 
			IF (ScreenElementExists) (id) = ( (the_score_pot_text) + 1 ) 
				(SetScreenElementProps) (id) = ( (the_score_pot_text) + 1 ) (unhide) 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT (trick_text_pulse) 
	IF NOT (GetGlobalFlag) (flag) = (NO_DISPLAY_TRICKSTRING) 
		(TerminateObjectsScripts) (id) = <trick_text_container_id> 
		(TerminateObjectsScripts) (id) = <the_trick_text_id> 
		(RunScriptOnScreenElement) (id) = <the_trick_text_id> (do_trick_text_pulse) (params) = { <...> } 
	ENDIF 
	IF NOT (GetGlobalFlag) (flag) = (NO_DISPLAY_BASESCORE) 
		(TerminateObjectsScripts) (id) = <the_score_pot_text_id> (script_name) = (do_score_pot_text_landed) 
		(RunScriptOnScreenElement) (id) = <the_trick_text_id> (do_trick_text_pulse) (params) = { <...> } 
	ENDIF 
ENDSCRIPT

SCRIPT (do_trick_text_pulse) 
	(reset_trick_text_appearance) <...> 
	IF NOT (GetGlobalFlag) (flag) = (NO_DISPLAY_TRICKSTRING) 
		IF (InSplitScreenGame) 
			(ScriptGetScreenMode) 
			IF ( <screen_mode> = (split_vertical) ) 
				(DoMorph) (scale) = 1.00000000000 (time) = 0.20000000298 
				(DoMorph) (scale) = 0.60000002384 (time) = 0.30000001192 
				(DoMorph) (scale) = 0.94999998808 (time) = 0.40000000596 
			ELSE 
				(DoMorph) (scale) = 1.20000004768 (time) = 0.20000000298 
				(DoMorph) (scale) = 0.89999997616 (time) = 0.30000001192 
				(DoMorph) (scale) = 1.00000000000 (time) = 0.40000000596 
			ENDIF 
		ELSE 
			(DoMorph) (scale) = 1.20000004768 (time) = 0.20000000298 
			(DoMorph) (scale) = 0.89999997616 (time) = 0.30000001192 
			(DoMorph) (scale) = 1.00000000000 (time) = 0.40000000596 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT (trick_text_landed) 
	IF NOT (GetGlobalFlag) (flag) = (NO_DISPLAY_TRICKSTRING) 
		(TerminateObjectsScripts) (id) = <trick_text_container_id> 
		(TerminateObjectsScripts) (id) = <the_trick_text_id> 
	ENDIF 
	IF NOT (GetGlobalFlag) (flag) = (NO_DISPLAY_BASESCORE) 
		(TerminateObjectsScripts) (id) = <the_score_pot_text_id> 
	ENDIF 
	(RunScriptOnScreenElement) (id) = <the_score_pot_text_id> (do_score_pot_text_landed) (params) = { <...> } 
	(RunScriptOnScreenElement) (id) = <the_trick_text_id> (do_trick_text_landed) (params) = { <...> } 
ENDSCRIPT

SCRIPT (do_trick_text_landed) 
	(reset_trick_text_appearance) <...> 
	IF NOT (GetGlobalFlag) (flag) = (NO_DISPLAY_TRICKSTRING) 
		IF (InSplitScreenGame) 
			(ScriptGetScreenMode) 
			IF ( <screen_mode> = (split_vertical) ) 
				(DoMorph) (scale) = 0 (time) = 0 
				(DoMorph) (scale) = 1.79999995232 (time) = 0.20000000298 
				(DoMorph) (scale) = 0.50000000000 (time) = 0.07999999821 
				(DoMorph) (scale) = 1.00000000000 (time) = 0.05000000075 
				(DoMorph) (scale) = 0.80000001192 (time) = 0.03999999911 
				(DoMorph) (scale) = 1.00000000000 (time) = 0.03999999911 
			ELSE 
				(DoMorph) (scale) = 0 (time) = 0 
				(DoMorph) (scale) = 1.39999997616 (time) = 0.20000000298 
				(DoMorph) (scale) = 0.80000001192 (time) = 0.07999999821 
				(DoMorph) (scale) = 1.20000004768 (time) = 0.05000000075 
				(DoMorph) (scale) = 0.89999997616 (time) = 0.03999999911 
				(DoMorph) (scale) = 1.00000000000 (time) = 0.03999999911 
			ENDIF 
		ELSE 
			(DoMorph) (scale) = 0 (time) = 0 
			(DoMorph) (scale) = 1.39999997616 (time) = 0.20000000298 
			(DoMorph) (scale) = 0.80000001192 (time) = 0.07999999821 
			(DoMorph) (scale) = 1.20000004768 (time) = 0.05000000075 
			(DoMorph) (scale) = 0.89999997616 (time) = 0.03999999911 
			(DoMorph) (scale) = 1.00000000000 (time) = 0.03999999911 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT (do_score_pot_text_landed) 
	IF NOT (GetGlobalFlag) (flag) = (NO_DISPLAY_BASESCORE) 
		(wait) 1 (gameframe) 
		(SetScreenElementProps) (id) = <the_score_pot_text_id> (rgba) = [ 42 80 128 120 ] 
		(SetScreenElementProps) (id) = <the_score_pot_text_id> (override_encoded_rgba) 
		IF (InSplitScreenGame) 
			(ScriptGetScreenMode) 
			IF ( <screen_mode> = (split_vertical) ) 
				(DoMorph) (scale) = 0 (time) = 0 
				(DoMorph) (scale) = 1.29999995232 (time) = 0.20000000298 
				(DoMorph) (scale) = 0.50000000000 (time) = 0.07999999821 
				(DoMorph) (scale) = 1.00000000000 (time) = 0.05000000075 
				(DoMorph) (scale) = 0.80000001192 (time) = 0.03999999911 
				(DoMorph) (scale) = 1.20000004768 (time) = 0.03999999911 
			ELSE 
				(DoMorph) (scale) = 0 (time) = 0.05000000075 
				(DoMorph) (scale) = 1.79999995232 (time) = 0.11999999732 
				(DoMorph) (scale) = 0.80000001192 (time) = 0.10000000149 
				(DoMorph) (scale) = 1.50000000000 (time) = 0.07000000030 
				(DoMorph) (scale) = 0.89999997616 (time) = 0.07000000030 
				(DoMorph) (scale) = 1.29999995232 (time) = 0.05000000075 
				(DoMorph) (scale) = 1.00000000000 (time) = 0.05000000075 
				(DoMorph) (scale) = 1.25000000000 (time) = 0.03999999911 
				(DoMorph) (scale) = 1.10000002384 (time) = 0.02999999933 
				(DoMorph) (scale) = 1.20000004768 (time) = 0.01999999955 
			ENDIF 
		ELSE 
			(DoMorph) (scale) = 0 (time) = 0.05000000075 
			(DoMorph) (scale) = 1.79999995232 (time) = 0.11999999732 
			(DoMorph) (scale) = 0.80000001192 (time) = 0.10000000149 
			(DoMorph) (scale) = 1.50000000000 (time) = 0.07000000030 
			(DoMorph) (scale) = 0.89999997616 (time) = 0.07000000030 
			(DoMorph) (scale) = 1.29999995232 (time) = 0.05000000075 
			(DoMorph) (scale) = 1.00000000000 (time) = 0.05000000075 
			(DoMorph) (scale) = 1.25000000000 (time) = 0.03999999911 
			(DoMorph) (scale) = 1.10000002384 (time) = 0.02999999933 
			(DoMorph) (scale) = 1.20000004768 (time) = 0.01999999955 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT (trick_text_countdown) 
	IF NOT (GetGlobalFlag) (flag) = (NO_DISPLAY_TRICKSTRING) 
		(TerminateObjectsScripts) (id) = <trick_text_container_id> 
		(TerminateObjectsScripts) (id) = <the_trick_text_id> 
	ENDIF 
	(RunScriptOnScreenElement) (id) = <the_trick_text_id> (do_trick_text_countdown) (params) = { <...> } 
ENDSCRIPT

SCRIPT (do_trick_text_countdown) 
	IF NOT (GetGlobalFlag) (flag) = (NO_DISPLAY_TRICKSTRING) 
		(DoMorph) (scale) = 0.00000000000 (time) = 0.50000000000 
		(DoMorph) (alpha) = 0.00000000000 
	ENDIF 
ENDSCRIPT

SCRIPT (trick_text_bail) 
	IF NOT (GetGlobalFlag) (flag) = (NO_DISPLAY_TRICKSTRING) 
		(TerminateObjectsScripts) (id) = <trick_text_container_id> 
		(TerminateObjectsScripts) (id) = <the_trick_text_id> 
	ENDIF 
	(RunScriptOnScreenElement) (id) = <trick_text_container_id> (do_trick_text_bail) (params) = { <...> } 
ENDSCRIPT

SCRIPT (do_trick_text_bail) 
	(reset_trick_text_appearance) <...> 
	IF NOT (GetGlobalFlag) (flag) = (NO_DISPLAY_BASESCORE) 
		(SetScreenElementProps) (id) = <the_score_pot_text_id> (rgba) = [ 128 32 32 80 ] 
	ENDIF 
	IF NOT (GetGlobalFlag) (flag) = (NO_DISPLAY_TRICKSTRING) 
		(GetTextElementString) (id) = <the_trick_text_id> 
		(SetScreenElementProps) (id) = <the_trick_text_id> (rgba) = [ 128 32 32 80 ] (text) = <string> 
		(SetScreenElementProps) (id) = <the_trick_text_id> (override_encoded_rgba) 
	ENDIF 
	(wait) 0.05000000075 (seconds) 
	IF (InSplitScreenGame) 
		(ScriptGetScreenMode) 
		IF ( <screen_mode> = (split_vertical) ) 
			(DoMorph) (alpha) = 0 (scale) = 0 (time) = 0 
			(DoMorph) (pos) = { PAIR(0.00000000000, 25.00000000000) (relative) } (scale) = PAIR(0.40000000596, 0.69999998808) (alpha) = 1 (time) = 0.05000000075 
			(DoMorph) (pos) = { PAIR(0.00000000000, -25.00000000000) (relative) } (scale) = 0.40000000596 (time) = 0.10000000149 
			(DoMorph) (pos) = { PAIR(0.00000000000, 20.00000000000) (relative) } (scale) = 0.80000001192 (time) = 0.05999999866 
			(DoMorph) (pos) = { PAIR(0.00000000000, -20.00000000000) (relative) } (scale) = 0.60000002384 (time) = 0.05999999866 
			(DoMorph) (pos) = { PAIR(0.00000000000, 10.00000000000) (relative) } (scale) = 0.80000001192 (time) = 0.05000000075 
		ELSE 
			(DoMorph) (alpha) = 0 (scale) = 0 (time) = 0 
			(DoMorph) (pos) = { PAIR(0.00000000000, 25.00000000000) (relative) } (scale) = PAIR(0.69999998808, 1.79999995232) (alpha) = 1 (time) = 0.05000000075 
			(DoMorph) (pos) = { PAIR(0.00000000000, -25.00000000000) (relative) } (scale) = 0.89999997616 (time) = 0.10000000149 
			(DoMorph) (pos) = { PAIR(0.00000000000, 20.00000000000) (relative) } (scale) = 1.14999997616 (time) = 0.05999999866 
			(DoMorph) (pos) = { PAIR(0.00000000000, -20.00000000000) (relative) } (scale) = 1.12000000477 (time) = 0.05999999866 
			(DoMorph) (pos) = { PAIR(0.00000000000, 10.00000000000) (relative) } (scale) = 1.10000002384 (time) = 0.05000000075 
		ENDIF 
	ELSE 
		(DoMorph) (alpha) = 0 (scale) = 0 (time) = 0 
		(DoMorph) (pos) = { PAIR(0.00000000000, 25.00000000000) (relative) } (scale) = PAIR(0.69999998808, 1.79999995232) (alpha) = 1 (time) = 0.05000000075 
		(DoMorph) (pos) = { PAIR(0.00000000000, -25.00000000000) (relative) } (scale) = 0.89999997616 (time) = 0.10000000149 
		(DoMorph) (pos) = { PAIR(0.00000000000, 20.00000000000) (relative) } (scale) = 1.14999997616 (time) = 0.05999999866 
		(DoMorph) (pos) = { PAIR(0.00000000000, -20.00000000000) (relative) } (scale) = 1.12000000477 (time) = 0.05999999866 
		(DoMorph) (pos) = { PAIR(0.00000000000, 10.00000000000) (relative) } (scale) = 1.10000002384 (time) = 0.05000000075 
	ENDIF 
	(DoMorph) (pos) = { PAIR(0.00000000000, -10.00000000000) (relative) } (time) = 0.05000000075 
	(DoMorph) (pos) = { PAIR(0.00000000000, 5.00000000000) (relative) } (time) = 0.03999999911 
	(DoMorph) (pos) = { PAIR(0.00000000000, -5.00000000000) (relative) } (time) = 0.03999999911 
	(wait) 1.29999995232 (seconds) 
	(DoMorph) (pos) = { PAIR(-2.00000000000, 4.00000000000) (relative) } (time) = 0.05000000075 
	(DoMorph) (pos) = { PAIR(-3.00000000000, 6.00000000000) (relative) } (time) = 0.05000000075 
	(DoMorph) (pos) = { PAIR(5.00000000000, 1.00000000000) (relative) } (time) = 0.05000000075 
	(DoMorph) (pos) = { PAIR(-3.00000000000, -4.00000000000) (relative) } (time) = 0.05000000075 
	(DoMorph) (pos) = { PAIR(2.00000000000, -5.00000000000) (relative) } (time) = 0.05000000075 
	(DoMorph) (pos) = { PAIR(4.00000000000, -1.00000000000) (relative) } (time) = 0.05000000075 
	(DoMorph) (pos) = { PAIR(-3.00000000000, 2.00000000000) (relative) } (time) = 0.05000000075 
	(DoMorph) (pos) = { PAIR(4.00000000000, -5.00000000000) (relative) } (time) = 0.05000000075 
	(DoMorph) (pos) = { PAIR(-1.00000000000, 2.00000000000) (relative) } (time) = 0.05000000075 
	(DoMorph) (pos) = { PAIR(-3.00000000000, -4.00000000000) (relative) } (time) = 0.05000000075 
	(DoMorph) (pos) = { PAIR(2.00000000000, -4.00000000000) (relative) } (time) = 0.05000000075 
	(DoMorph) (pos) = { PAIR(3.00000000000, -6.00000000000) (relative) } (time) = 0.05000000075 
	(DoMorph) (pos) = { PAIR(-5.00000000000, -1.00000000000) (relative) } (time) = 0.05000000075 
	(DoMorph) (pos) = { PAIR(3.00000000000, 4.00000000000) (relative) } (time) = 0.05000000075 
	(DoMorph) (pos) = { PAIR(-2.00000000000, 5.00000000000) (relative) } (time) = 0.05000000075 
	(DoMorph) (pos) = { PAIR(-4.00000000000, 1.00000000000) (relative) } (time) = 0.05000000075 
	(DoMorph) (pos) = { PAIR(3.00000000000, -2.00000000000) (relative) } (time) = 0.05000000075 
	(DoMorph) (pos) = { PAIR(-4.00000000000, 5.00000000000) (relative) } (time) = 0.05000000075 
	(DoMorph) (pos) = { PAIR(1.00000000000, -2.00000000000) (relative) } (time) = 0.05000000075 
	(DoMorph) (pos) = { PAIR(3.00000000000, 4.00000000000) (relative) } (time) = 0.05000000075 
	RANDOM(1, 1, 1, 1, 1, 1, 1, 1, 1, 1) RANDOMCASE (runtwoscripts) (script_text) = (bail1) (script_score) = (bail1) <...> 
		RANDOMCASE (runtwoscripts) (script_text) = (bail1) (script_score) = (bail1) <...> 
		RANDOMCASE (runtwoscripts) (script_text) = (bail2) (script_score) = (bail3) <...> 
		RANDOMCASE (runtwoscripts) (script_text) = (bail4) (script_score) = (bail5) <...> 
		RANDOMCASE (runtwoscripts) (script_text) = (bail5) (script_score) = (bail4) <...> 
		RANDOMCASE (runtwoscripts) (script_text) = (bail1) (script_score) = (bail6) <...> 
		RANDOMCASE (runtwoscripts) (script_text) = (bail6) (script_score) = (bail6) <...> 
		RANDOMCASE (runtwoscripts) (script_text) = (bail4) (script_score) = (bail4) <...> 
		RANDOMCASE (runtwoscripts) (script_text) = (bail5) (script_score) = (bail5) <...> 
		RANDOMCASE (runtwoscripts) (script_text) = (bail2) (script_score) = (bail1) <...> 
	RANDOMEND 
ENDSCRIPT

SCRIPT (runtwoscripts) 
	IF NOT (GetGlobalFlag) (flag) = (NO_DISPLAY_TRICKSTRING) 
		(RunScriptOnScreenElement) (id) = <the_trick_text_id> <script_text> 
	ENDIF 
	IF NOT (GetGlobalFlag) (flag) = (NO_DISPLAY_BASESCORE) 
		(RunScriptOnScreenElement) (id) = <the_score_pot_text_id> <script_score> 
	ENDIF 
ENDSCRIPT

SCRIPT (bail1) 
	(DoMorph) (pos) = { PAIR(0.00000000000, 0.00000000000) (relative) } (time) = 0.10000000149 (scale) = 1.89999997616 (fast_in) 
	(DoMorph) (pos) = { PAIR(0.00000000000, 0.00000000000) (relative) } (time) = 0.30000001192 (scale) = 3.00000000000 (alpha) = 0 (fast_in) 
	(DoMorph) (pos) = { PAIR(0.00000000000, 0.00000000000) (relative) } (scale) = 1.00000000000 (alpha) = 0 (fast_in) 
ENDSCRIPT

SCRIPT (bail2) 
	(DoMorph) (pos) = { PAIR(0.00000000000, -5.00000000000) (relative) } (time) = 0.40000000596 
	(DoMorph) (pos) = { PAIR(0.00000000000, 448.00000000000) (relative) } (time) = 0.69999998808 (fast_in) 
	(DoMorph) (alpha) = 0.00000000000 
	(DoMorph) (pos) = { PAIR(0.00000000000, -443.00000000000) (relative) } (scale) = 1.00000000000 (alpha) = 0 (fast_in) 
ENDSCRIPT

SCRIPT (bail3) 
	(wait) 0.10000000149 (second) 
	(DoMorph) (pos) = { PAIR(0.00000000000, -5.00000000000) (relative) } (time) = 0.20000000298 
	(DoMorph) (pos) = { PAIR(3.00000000000, 0.00000000000) (relative) } (time) = 0.05000000075 
	(DoMorph) (pos) = { PAIR(-3.00000000000, 0.00000000000) (relative) } (time) = 0.05000000075 
	(DoMorph) (pos) = { PAIR(4.00000000000, 0.00000000000) (relative) } (time) = 0.05000000075 
	(DoMorph) (pos) = { PAIR(-4.00000000000, 0.00000000000) (relative) } (time) = 0.05000000075 
	(DoMorph) (pos) = { PAIR(0.00000000000, 448.00000000000) (relative) } (time) = 0.50000000000 (fast_in) 
	(DoMorph) (alpha) = 0.00000000000 
	(DoMorph) (pos) = { PAIR(0.00000000000, -443.00000000000) (relative) } (scale) = 1.00000000000 (alpha) = 0 (fast_in) 
ENDSCRIPT

SCRIPT (bail4) 
	(DoMorph) (pos) = { PAIR(-15.00000000000, 0.00000000000) (relative) } (time) = 0.10000000149 
	(DoMorph) (pos) = { PAIR(0.00000000000, 4.00000000000) (relative) } (time) = 0.01999999955 
	(DoMorph) (pos) = { PAIR(0.00000000000, -4.00000000000) (relative) } (time) = 0.01999999955 
	(DoMorph) (pos) = { PAIR(0.00000000000, 2.00000000000) (relative) } (time) = 0.01999999955 
	(DoMorph) (pos) = { PAIR(0.00000000000, -2.00000000000) (relative) } (time) = 0.01999999955 
	(DoMorph) (pos) = { PAIR(150.00000000000, 0.00000000000) (relative) } (time) = 0.05999999866 (alpha) = 0.69999998808 
	(DoMorph) (pos) = { PAIR(200.00000000000, 0.00000000000) (relative) } (scale) = PAIR(2.00000000000, 0.10000000149) (time) = 0.05999999866 (alpha) = 0 (fast_in) 
	(DoMorph) (pos) = { PAIR(200.00000000000, 0.00000000000) (relative) } (time) = 0 
	(DoMorph) (pos) = { PAIR(-535.00000000000, 0.00000000000) (relative) } (scale) = 1.00000000000 (alpha) = 0 (fast_in) 
ENDSCRIPT

SCRIPT (bail5) 
	(DoMorph) (pos) = { PAIR(15.00000000000, 0.00000000000) (relative) } (time) = 0.10000000149 
	(DoMorph) (pos) = { PAIR(0.00000000000, 4.00000000000) (relative) } (time) = 0.01999999955 
	(DoMorph) (pos) = { PAIR(0.00000000000, -4.00000000000) (relative) } (time) = 0.01999999955 
	(DoMorph) (pos) = { PAIR(0.00000000000, 2.00000000000) (relative) } (time) = 0.01999999955 
	(DoMorph) (pos) = { PAIR(0.00000000000, -2.00000000000) (relative) } (time) = 0.01999999955 
	(DoMorph) (pos) = { PAIR(-150.00000000000, 0.00000000000) (relative) } (time) = 0.05999999866 (alpha) = 0.69999998808 
	(DoMorph) (pos) = { PAIR(-200.00000000000, 0.00000000000) (relative) } (scale) = PAIR(2.00000000000, 0.10000000149) (time) = 0.05999999866 (alpha) = 0 (fast_in) 
	(DoMorph) (pos) = { PAIR(-200.00000000000, 0.00000000000) (relative) } (time) = 0 
	(DoMorph) (pos) = { PAIR(535.00000000000, 0.00000000000) (relative) } (scale) = 1.00000000000 (alpha) = 0 (fast_in) 
ENDSCRIPT

SCRIPT (bail6) 
	(DoMorph) (pos) = { PAIR(0.00000000000, 0.00000000000) (relative) } (time) = 0.20000000298 (scale) = 1.29999995232 (alpha) = 0.60000002384 (fast_in) 
	(wait) 0.20000000298 (second) 
	(DoMorph) (pos) = { PAIR(0.00000000000, 0.00000000000) (relative) } (time) = 0.15000000596 (scale) = 0 (alpha) = 0 (fast_in) 
ENDSCRIPT

SCRIPT (reset_just_trick_text_appearance) 
	IF NOT (GetGlobalFlag) (flag) = (NO_DISPLAY_TRICKSTRING) 
		IF (InSplitScreenGame) 
			IF (GameModeEquals) (is_horse) 
				(trick_text_pos) = PAIR(320.00000000000, 410.00000000000) 
				(text_scale) = 1.00000000000 
			ELSE 
				(ScriptGetScreenMode) 
				SWITCH <screen_mode> 
					CASE (split_vertical) 
					CASE (one_camera) 
						(trick_text_pos) = PAIR(142.00000000000, 410.00000000000) 
						(text_scale) = 0.94999998808 
					CASE (split_horizontal) 
						(trick_text_pos) = PAIR(320.00000000000, 200.00000000000) 
						(text_scale) = 1.00000000000 
				ENDSWITCH 
			ENDIF 
			(DoScreenElementMorph) { 
				(id) = <trick_text_container_id> 
				(alpha) = 1.00000000000 
				(pos) = <trick_text_pos> 
				(just) = [ (center) (top) ] 
				(scale) = <text_scale> 
			} 
			(DoScreenElementMorph) { 
				(id) = <the_trick_text_id> 
				(scale) = <text_scale> 
				(pos) = { PAIR(0.50000000000, 0.00000000000) (proportional) } 
				(just) = [ (center) (top) ] 
				(internal_just) = [ (center) (top) ] 
				(internal_scale) = 0.69999998808 
				(alpha) = 1.00000000000 
			} 
			(SetScreenElementProps) (id) = <the_trick_text_id> (dont_override_encoded_rgba) 
			(SetScreenElementProps) (id) = <the_trick_text_id> (rgba) = [ 128 128 128 80 ] 
		ELSE 
			(DoScreenElementMorph) { 
				(id) = <trick_text_container_id> 
				(alpha) = 1.00000000000 
				(pos) = PAIR(320.00000000000, 410.00000000000) 
				(scale) = 1.00000000000 
			} 
			(DoScreenElementMorph) { 
				(id) = <the_trick_text_id> 
				(scale) = 1.00000000000 
				(pos) = { PAIR(0.50000000000, 0.00000000000) (proportional) } 
				(just) = [ (center) (top) ] 
				(internal_just) = [ (center) (top) ] 
				(internal_scale) = 0.69999998808 
				(alpha) = 1.00000000000 
			} 
			(SetScreenElementProps) (id) = <the_trick_text_id> (dont_override_encoded_rgba) 
			(SetScreenElementProps) (id) = <the_trick_text_id> (rgba) = [ 128 128 128 80 ] 
		ENDIF 
	ELSE 
		IF (InSplitScreenGame) 
			IF (GameModeEquals) (is_horse) 
				(trick_text_pos) = PAIR(320.00000000000, 410.00000000000) 
				(text_scale) = 1.00000000000 
			ELSE 
				(ScriptGetScreenMode) 
				SWITCH <screen_mode> 
					CASE (split_vertical) 
					CASE (one_camera) 
						(trick_text_pos) = PAIR(142.00000000000, 410.00000000000) 
						(text_scale) = 0.94999998808 
					CASE (split_horizontal) 
						(trick_text_pos) = PAIR(320.00000000000, 200.00000000000) 
						(text_scale) = 1.00000000000 
				ENDSWITCH 
			ENDIF 
			(DoScreenElementMorph) { 
				(id) = <trick_text_container_id> 
				(alpha) = 1.00000000000 
				(pos) = <trick_text_pos> 
				(just) = [ (center) (top) ] 
				(scale) = <text_scale> 
			} 
		ELSE 
			(DoScreenElementMorph) { 
				(id) = <trick_text_container_id> 
				(alpha) = 1.00000000000 
				(pos) = PAIR(320.00000000000, 410.00000000000) 
				(scale) = 1.00000000000 
			} 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT (reset_trick_text_appearance) 
	(TerminateObjectsScripts) (id) = <the_trick_text_id> (script_name) = (bail1) 
	(TerminateObjectsScripts) (id) = <the_trick_text_id> (script_name) = (bail2) 
	(TerminateObjectsScripts) (id) = <the_trick_text_id> (script_name) = (bail3) 
	(TerminateObjectsScripts) (id) = <the_trick_text_id> (script_name) = (bail4) 
	(TerminateObjectsScripts) (id) = <the_trick_text_id> (script_name) = (bail5) 
	(TerminateObjectsScripts) (id) = <the_trick_text_id> (script_name) = (bail6) 
	(reset_just_trick_text_appearance) <...> 
	IF NOT (GetGlobalFlag) (flag) = (NO_DISPLAY_BASESCORE) 
		(TerminateObjectsScripts) (id) = <the_score_pot_text_id> (script_name) = (bail1) 
		(TerminateObjectsScripts) (id) = <the_score_pot_text_id> (script_name) = (bail2) 
		(TerminateObjectsScripts) (id) = <the_score_pot_text_id> (script_name) = (bail3) 
		(TerminateObjectsScripts) (id) = <the_score_pot_text_id> (script_name) = (bail4) 
		(TerminateObjectsScripts) (id) = <the_score_pot_text_id> (script_name) = (bail5) 
		(TerminateObjectsScripts) (id) = <the_score_pot_text_id> (script_name) = (bail6) 
		(SetScreenElementProps) (id) = <the_score_pot_text_id> (rgba) = [ 127 102 0 85 ] 
		(SetScreenElementProps) (id) = <the_score_pot_text_id> (dont_override_encoded_rgba) 
		IF (InSplitScreenGame) 
			IF (GameModeEquals) (is_horse) 
				(DoScreenElementMorph) { 
					(id) = <the_score_pot_text_id> 
					(scale) = 1.00000000000 
					(pos) = PAIR(287.00000000000, 2.00000000000) 
					(just) = [ (center) (bottom) ] 
					(alpha) = 1.00000000000 
				} 
			ELSE 
				(ScriptGetScreenMode) 
				SWITCH <screen_mode> 
					CASE (split_vertical) 
					CASE (one_camera) 
						(DoScreenElementMorph) { 
							(id) = <the_score_pot_text_id> 
							(scale) = 1.00000000000 
							(pos) = PAIR(120.00000000000, 2.00000000000) 
							(just) = [ (center) (bottom) ] 
							(alpha) = 1.00000000000 
						} 
					CASE (split_horizontal) 
						(DoScreenElementMorph) { 
							(id) = <the_score_pot_text_id> 
							(scale) = 1.00000000000 
							(pos) = PAIR(287.00000000000, 2.00000000000) 
							(just) = [ (center) (bottom) ] 
							(alpha) = 1.00000000000 
						} 
				ENDSWITCH 
			ENDIF 
		ELSE 
			(DoScreenElementMorph) { 
				(id) = <the_score_pot_text_id> 
				(scale) = 1.00000000000 
				(pos) = PAIR(287.00000000000, 2.00000000000) 
				(just) = [ (center) (bottom) ] 
				(alpha) = 1.00000000000 
			} 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT (HideClock) 
	(KillSpawnedScript) (name) = (clock_morph) 
	(DoScreenElementMorph) { (id) = (the_time) (alpha) = 0 } 
ENDSCRIPT

SCRIPT (ShowClock) 
	(DoScreenElementMorph) { (id) = (the_time) (alpha) = 1 } 
ENDSCRIPT

SCRIPT (hide_balance_meter) 
	(SetScreenElementProps) (id) = <id> (tags) = { (tag_turned_on) = 0 } 
	(RunScriptOnScreenElement) (id) = <id> (do_hide_balance_meter) (params) = { (id) = <id> } 
ENDSCRIPT

SCRIPT (pause_balance_meter) 
	(RunScriptOnScreenElement) (id) = (the_balance_meter) (do_hide_balance_meter) (params) = { (id) = (the_balance_meter) } 
	IF (InSplitScreenGame) 
		(RunScriptOnScreenElement) (id) = ( (the_balance_meter) + 1 ) (do_hide_balance_meter) (params) = { (id) = ( (the_balance_meter) + 1 ) } 
	ENDIF 
ENDSCRIPT

SCRIPT (do_hide_balance_meter) 
	(SetScreenElementProps) (id) = <id> (rgba) = [ 128 128 128 0 ] 
	(SetScreenElementProps) (id) = { <id> (child) = 0 } (rgba) = [ 128 128 128 0 ] 
ENDSCRIPT

SCRIPT (show_balance_meter) 
	IF NOT (GetGlobalFlag) (flag) = (NO_DISPLAY_BALANCE) 
		IF NOT ( ( (InNetGame) ) & ( (GetGlobalFlag) (flag) = (NO_G_DISPLAY_BALANCE) ) ) 
			(SetScreenElementProps) (id) = <id> (tags) = { (tag_turned_on) = 1 } 
			(RunScriptOnScreenElement) (id) = <id> (do_show_balance_meter) (params) = { (id) = <id> } 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT (unpause_balance_meter) 
	(RunScriptOnScreenElement) (id) = (the_balance_meter) (do_show_balance_meter) (params) = { (id) = (the_balance_meter) } 
	IF (InSplitScreenGame) 
		(RunScriptOnScreenElement) (id) = ( (the_balance_meter) + 1 ) (do_show_balance_meter) (params) = { (id) = ( (the_balance_meter) + 1 ) } 
	ENDIF 
ENDSCRIPT

SCRIPT (do_show_balance_meter) 
	IF NOT (GetGlobalFlag) (flag) = (NO_DISPLAY_BALANCE) 
		IF NOT ( ( (InNetGame) ) & ( (GetGlobalFlag) (flag) = (NO_G_DISPLAY_BALANCE) ) ) 
			(GetTags) 
			(FormatText) (ChecksumName) = (balance_meter_color) "%i_BALANCE_METER_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
			(FormatText) (ChecksumName) = (balance_arrow_color) "%i_BALANCE_ARROW_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
			IF (IntegerEquals) (a) = <tag_turned_on> (b) = 1 
				(SetScreenElementProps) (id) = <id> (rgba) = <balance_meter_color> 
				(SetScreenElementProps) (id) = { <id> (child) = 0 } (rgba) = <balance_arrow_color> 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT (hide_run_timer) 
	IF (ObjectExists) (id) = <id> 
		(SetScreenElementProps) (id) = <id> (tags) = { (tag_turned_on) = 0 } 
		(RunScriptOnScreenElement) (id) = <id> (do_hide_run_timer) (params) = { (id) = <id> } 
	ENDIF 
ENDSCRIPT

SCRIPT (pause_run_timer) 
	(RunScriptOnScreenElement) (id) = (the_run_timer) (do_hide_run_timer) (params) = { (id) = (the_run_timer) } 
	IF (ScreenElementExists) (id) = ( (the_run_timer) + 1 ) 
		(RunScriptOnScreenElement) (id) = ( (the_run_timer) + 1 ) (do_hide_run_timer) (params) = { (id) = ( (the_run_timer) + 1 ) } 
	ENDIF 
ENDSCRIPT

SCRIPT (do_hide_run_timer) 
	(DoScreenElementMorph) (id) = <id> (alpha) = 0 
ENDSCRIPT

SCRIPT (show_run_timer) 
	(GetScreenElementPosition) (id) = <id> 
	(SetScreenElementProps) (id) = <id> (tags) = { (tag_turned_on) = 1 } 
	(RunScriptOnScreenElement) (id) = <id> (do_show_run_timer) (params) = { (id) = <id> } 
	(DoScreenElementMorph) (id) = { <id> (child) = 1 } (alpha) = 0 
	(DoScreenElementMorph) (id) = { <id> (child) = 2 } (alpha) = 0 
	(DoScreenElementMorph) (id) = { <id> (child) = 3 } (alpha) = 0 
	(DoScreenElementMorph) (id) = { <id> (child) = 4 } (alpha) = 0 
	(DoScreenElementMorph) (id) = { <id> (child) = 5 } (alpha) = 0 
	(DoScreenElementMorph) (id) = { <id> (child) = 6 } (alpha) = 0 
	(DoScreenElementMorph) (id) = { <id> (child) = 7 } (alpha) = 0 
	(DoScreenElementMorph) (id) = { <id> (child) = 8 } (alpha) = 0 
	IF ( <rot_angle> > 320 ) 
		(DoScreenElementMorph) (id) = { <id> (child) = 1 } (alpha) = 1 
	ENDIF 
	IF ( <rot_angle> > 280 ) 
		(DoScreenElementMorph) (id) = { <id> (child) = 2 } (alpha) = 1 
	ENDIF 
	IF ( <rot_angle> > 240 ) 
		(DoScreenElementMorph) (id) = { <id> (child) = 3 } (alpha) = 1 
	ENDIF 
	IF ( <rot_angle> > 200 ) 
		(DoScreenElementMorph) (id) = { <id> (child) = 4 } (alpha) = 1 
	ENDIF 
	IF ( <rot_angle> > 160 ) 
		(DoScreenElementMorph) (id) = { <id> (child) = 5 } (alpha) = 1 
	ENDIF 
	IF ( <rot_angle> > 120 ) 
		(DoScreenElementMorph) (id) = { <id> (child) = 6 } (alpha) = 1 
	ENDIF 
	IF ( <rot_angle> > 80 ) 
		(DoScreenElementMorph) (id) = { <id> (child) = 7 } (alpha) = 1 
	ENDIF 
	IF ( <rot_angle> > 40 ) 
		(DoScreenElementMorph) (id) = { <id> (child) = 8 } (alpha) = 1 
	ENDIF 
ENDSCRIPT

SCRIPT (soft_hide_run_timer) 
	(SetScreenElementProps) (id) = <id> (tags) = { (tag_turned_on) = 0 } 
	(RunScriptOnScreenElement) (id) = <id> (do_soft_hide_run_timer) (params) = { (id) = <id> } 
ENDSCRIPT

SCRIPT (do_soft_hide_run_timer) 
	(DoScreenElementMorph) (id) = <id> (alpha) = 0 (time) = 0.30000001192 
ENDSCRIPT

SCRIPT (unpause_run_timer) 
	(RunScriptOnScreenElement) (id) = (the_run_timer) (do_show_run_timer) (params) = { (id) = (the_run_timer) } 
	IF (InSplitScreenGame) 
		(RunScriptOnScreenElement) (id) = ( (the_run_timer) + 1 ) (do_show_run_timer) (params) = { (id) = ( (the_run_timer) + 1 ) } 
	ENDIF 
ENDSCRIPT

SCRIPT (do_show_run_timer) 
	(GetTags) 
	IF (IntegerEquals) (a) = <tag_turned_on> (b) = 1 
		(DoScreenElementMorph) (id) = <id> (alpha) = 1 
	ENDIF 
ENDSCRIPT

SCRIPT (hide_run_timer_piece) 
	IF ( 320 > <rot_angle> ) 
		(DoScreenElementMorph) (id) = { <id> (child) = 1 } (alpha) = 0 
	ENDIF 
	IF ( 280 > <rot_angle> ) 
		(DoScreenElementMorph) (id) = { <id> (child) = 2 } (alpha) = 0 
	ENDIF 
	IF ( 240 > <rot_angle> ) 
		(DoScreenElementMorph) (id) = { <id> (child) = 3 } (alpha) = 0 
	ENDIF 
	IF ( 200 > <rot_angle> ) 
		(DoScreenElementMorph) (id) = { <id> (child) = 4 } (alpha) = 0 
	ENDIF 
	IF ( 160 > <rot_angle> ) 
		(DoScreenElementMorph) (id) = { <id> (child) = 5 } (alpha) = 0 
	ENDIF 
	IF ( 120 > <rot_angle> ) 
		(DoScreenElementMorph) (id) = { <id> (child) = 6 } (alpha) = 0 
	ENDIF 
	IF ( 80 > <rot_angle> ) 
		(DoScreenElementMorph) (id) = { <id> (child) = 7 } (alpha) = 0 
	ENDIF 
	IF ( 40 > <rot_angle> ) 
		(DoScreenElementMorph) (id) = { <id> (child) = 8 } (alpha) = 0 
	ENDIF 
ENDSCRIPT

SCRIPT (blink_run_timer) 
	BEGIN 
		(DoScreenElementMorph) (id) = <id> (alpha) = 0.30000001192 (time) = 0.05000000075 
		(wait) 5 (gameframes) 
		(DoScreenElementMorph) (id) = <id> (alpha) = 1 (time) = 0.05000000075 
		(wait) 5 (gameframes) 
	REPEAT 
ENDSCRIPT

SCRIPT (start_oldtime_effects) 
	(start_bg_grain_effect) 
	(start_flashinglines_effect) 
	(start_cigburn_effect) 
	(start_hairghost_effect) 
ENDSCRIPT

SCRIPT (end_oldtime_effects) 
	(end_bg_grain_effect) 
	(end_flashinglines_effect) 
	(end_cigburn_effect) 
	(end_hairghost_effect) 
ENDSCRIPT

SCRIPT (start_bg_grain_effect) 
	(KillSpawnedScript) (name) = (tv_outline_pulse) 
	IF (ObjectExists) (id) = (tv_outline) 
		(DestroyScreenElement) (id) = (tv_outline) 
	ENDIF 
	(SetScreenElementLock) (id) = (root_window) (off) 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (root_window) 
		(id) = (tv_outline) 
		(texture) = (bg_grain) 
		(scale) = PAIR(5.00000000000, 7.50000000000) 
		(just) = [ (left) (top) ] 
		(z_priority) = 2000 
		(pos) = PAIR(0.00000000000, 0.00000000000) 
	} 
	(SetScreenElementLock) (id) = (root_window) (on) 
	(SpawnScript) (tv_outline_pulse) 
ENDSCRIPT

SCRIPT (tv_outline_pulse) 
	(DoScreenElementMorph) (id) = (tv_outline) (time) = 0 (alpha) = 0 
	(DoScreenElementMorph) (id) = (tv_outline) (time) = 1 (alpha) = 0.15000000596 
	(wait) 0.15000000596 (seconds) 
	BEGIN 
		IF (ObjectExists) (id) = (tv_outline) 
			(alpha) = ( ( RANDOM_RANGE PAIR(200.00000000000, 280.00000000000) ) * 0.00400000019 ) 
			(time) = ( ( RANDOM_RANGE PAIR(5.00000000000, 50.00000000000) ) * 0.00999999978 ) 
			(DoScreenElementMorph) (id) = (tv_outline) (time) = <time> (alpha) = <alpha> 
			(wait) <time> (seconds) 
			(time) = ( ( RANDOM_RANGE PAIR(5.00000000000, 20.00000000000) ) * 0.00999999978 ) 
			(DoScreenElementMorph) (id) = (tv_outline) (time) = <time> (alpha) = 0.60000002384 
			(wait) <time> (seconds) 
		ENDIF 
	REPEAT 
ENDSCRIPT

SCRIPT (end_bg_grain_effect) 
	(KillSpawnedScript) (name) = (tv_outline_pulse) 
	IF (ObjectExists) (id) = (tv_outline) 
		(DestroyScreenElement) (id) = (tv_outline) 
	ENDIF 
ENDSCRIPT

(flashingline_intensity) = 2 
SCRIPT (start_flashinglines_effect) 
	(KillSpawnedScript) (name) = (flash_lines) 
	IF (ObjectExists) (id) = (line_container) 
		(DestroyScreenElement) (id) = (line_container) 
	ENDIF 
	(SetScreenElementLock) (id) = (root_window) (off) 
	(CreateScreenElement) { 
		(type) = (ContainerElement) 
		(parent) = (root_window) 
		(id) = (line_container) 
		(dims) = PAIR(640.00000000000, 480.00000000000) 
		(pos) = PAIR(0.00000000000, 0.00000000000) 
		(just) = [ (left) (top) ] 
	} 
	BEGIN 
		(CreateScreenElement) { 
			(type) = (SpriteElement) 
			(parent) = (line_container) 
			(scale) = PAIR(0.25000000000, 120.00000000000) 
			(texture) = (white2) 
			(rgba) = [ 0 0 0 128 ] 
			(just) = [ (left) (top) ] 
			(z_priority) = 1999 
		} 
	REPEAT 6 
	(SetScreenElementLock) (id) = (line_container) (on) 
	(SetScreenElementLock) (id) = (root_window) (on) 
	(SpawnScript) (flash_lines) 
ENDSCRIPT

SCRIPT (flash_lines) 
	BEGIN 
		<index> = 0 
		BEGIN 
			<x> = RANDOM_RANGE PAIR(0.00000000000, 640.00000000000) 
			<pos> = ( PAIR(1.00000000000, 0.00000000000) * <x> ) 
			IF (ObjectExists) (id) = (line_container) 
				(DoScreenElementMorph) (id) = { (line_container) (child) = <index> } (time) = 0 (alpha) = 0.20000000298 (pos) = <pos> 
			ENDIF 
			<index> = ( <index> + 1 ) 
			(wait) 1 (frame) 
		REPEAT (flashingline_intensity) 
		BEGIN 
			IF ( <index> = 6 ) 
				BREAK 
			ENDIF 
			IF (ObjectExists) (id) = (line_container) 
				(DoScreenElementMorph) (id) = { (line_container) (child) = <index> } (time) = 0 (alpha) = 0 
			ENDIF 
			(wait) 1 (frame) 
			<index> = ( <index> + 1 ) 
		REPEAT 
		(wait) 1 (frame) 
	REPEAT 
ENDSCRIPT

SCRIPT (end_flashinglines_effect) 
	(KillSpawnedScript) (name) = (flash_lines) 
	IF (ObjectExists) (id) = (line_container) 
		(DestroyScreenElement) (id) = (line_container) 
	ENDIF 
ENDSCRIPT

SCRIPT (start_cigburn_effect) 
	(KillSpawnedScript) (name) = (flash_cigburn) 
	IF (ObjectExists) (id) = (cig_burn) 
		(DestroyScreenElement) (id) = (cig_burn) 
	ENDIF 
	(SetScreenElementLock) (id) = (root_window) (off) 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(id) = (cig_burn) 
		(parent) = (root_window) 
		(pos) = PAIR(560.00000000000, 50.00000000000) 
		(texture) = (recdot) 
		(scale) = PAIR(3.00000000000, 1.00000000000) 
		(z_priority) = 1998 
		(rgba) = [ 0 0 0 128 ] 
	} 
	(SetScreenElementLock) (id) = (root_window) (on) 
	(SpawnScript) (flash_cigburn) 
ENDSCRIPT

SCRIPT (flash_cigburn) 
	(DoScreenElementMorph) (id) = (cig_burn) (time) = 0 (alpha) = 0 
	BEGIN 
		IF (ObjectExists) (id) = (cig_burn) 
			(DoScreenElementMorph) (id) = (cig_burn) (time) = 0 (alpha) = 0.50000000000 
			<time> = ( RANDOM_RANGE PAIR(5.00000000000, 15.00000000000) ) 
			(wait) <time> (frames) 
			<time> = ( RANDOM_RANGE PAIR(10.00000000000, 30.00000000000) ) 
			(DoScreenElementMorph) (id) = (cig_burn) (time) = 0 (alpha) = 0 
			(wait) <time> (frames) 
			(DoScreenElementMorph) (id) = (cig_burn) (time) = 0 (alpha) = 0.50000000000 
			<time> = ( RANDOM_RANGE PAIR(5.00000000000, 15.00000000000) ) 
			(wait) <time> (frames) 
			<time> = ( RANDOM_RANGE PAIR(10.00000000000, 30.00000000000) ) 
			(DoScreenElementMorph) (id) = (cig_burn) (time) = 0 (alpha) = 0 
			(wait) <time> (frames) 
			(DoScreenElementMorph) (id) = (cig_burn) (time) = 0 (alpha) = 0.50000000000 
			<time> = ( RANDOM_RANGE PAIR(5.00000000000, 15.00000000000) ) 
			(wait) <time> (frames) 
			<time> = ( RANDOM_RANGE PAIR(10.00000000000, 30.00000000000) ) 
			(DoScreenElementMorph) (id) = (cig_burn) (time) = 0 (alpha) = 0 
			(wait) <time> (frames) 
			(DoScreenElementMorph) (id) = (cig_burn) (time) = 0 (alpha) = 0 
			<time> = ( RANDOM_RANGE PAIR(4.00000000000, 7.00000000000) ) 
			(wait) <time> (seconds) 
		ENDIF 
		(wait) 1 (frame) 
	REPEAT 
ENDSCRIPT

SCRIPT (end_cigburn_effect) 
	(KillSpawnedScript) (name) = (flash_cigburn) 
	IF (ObjectExists) (id) = (cig_burn) 
		(DestroyScreenElement) (id) = (cig_burn) 
	ENDIF 
ENDSCRIPT

SCRIPT (start_hairghost_effect) 
	(KillSpawnedScript) (name) = (flash_hairghost) 
	IF (ObjectExists) (id) = (hair_ghost) 
		(DestroyScreenElement) (id) = (hair_ghost) 
	ENDIF 
	(SetScreenElementLock) (id) = (root_window) (off) 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(id) = (hair_ghost) 
		(parent) = (root_window) 
		(pos) = PAIR(320.00000000000, 240.00000000000) 
		(texture) = (hair) 
		(scale) = PAIR(3.00000000000, 1.00000000000) 
		(z_priority) = 2001 
		(rgba) = [ 0 0 0 128 ] 
	} 
	(SetScreenElementLock) (id) = (root_window) (on) 
	(SpawnScript) (flash_hairghost) 
ENDSCRIPT

SCRIPT (flash_hairghost) 
	BEGIN 
		IF (ObjectExists) (id) = (hair_ghost) 
			<theta> = ( RANDOM_RANGE PAIR(0.00000000000, 360.00000000000) ) 
			<x> = ( RANDOM_RANGE PAIR(0.00000000000, 640.00000000000) ) 
			<Y> = ( RANDOM_RANGE PAIR(0.00000000000, 480.00000000000) ) 
			<pos> = ( PAIR(1.00000000000, 0.00000000000) * <x> + PAIR(0.00000000000, 1.00000000000) * <Y> ) 
			(DoScreenElementMorph) (id) = (hair_ghost) (time) = 0 (alpha) = 0.50000000000 (pos) = <pos> (rot_angle) = <theta> 
			<time> = ( RANDOM_RANGE PAIR(20.00000000000, 40.00000000000) ) 
			(wait) <time> (frames) 
			(DoScreenElementMorph) (id) = (hair_ghost) (time) = 0 (alpha) = 0 
			<time> = ( RANDOM_RANGE PAIR(1.00000000000, 2.00000000000) ) 
			(wait) <time> (seconds) 
		ENDIF 
		(wait) 1 (frame) 
	REPEAT 
ENDSCRIPT

SCRIPT (end_hairghost_effect) 
	(KillSpawnedScript) (name) = (flash_hairghost) 
	IF (ObjectExists) (id) = (hair_ghost) 
		(DestroyScreenElement) (id) = (hair_ghost) 
	ENDIF 
ENDSCRIPT


