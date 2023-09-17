
(goal_goalattack_genericParams) = { 
	(goal_text) = "You must complete all of the goals to win!" 
	(unlimited_time) = 1 
	(no_restart) 
	(net) 
	(init) = (goal_goalattack_init) 
	(activate) = (goal_goalattack_activate) 
	(deactivate) = (goal_goalattack_deactivate) 
	(expire) = (goal_goalattack_expire) 
	(goal_description) = "Goal Attack!" 
} 
SCRIPT (goal_goalattack_init) 
ENDSCRIPT

SCRIPT (goal_goalattack_activate) 
	IF (InNetGame) 
		IF (IsObserving) 
			(FormatText) (TextName) = (msg_text) "\\c2Goal Attack \\n\\c0Complete all selected goals.\\n" 
			(create_panel_block) (id) = (mp_goal_text) (text) = <msg_text> (style) = (panel_message_goal) (final_pos) = <msg_pos> 
		ENDIF 
	ENDIF 
	(ResetScore) 
	(GoalManager_ClearLastGoal) 
	(GoalManager_SetCanStartGoal) 1 
ENDSCRIPT

SCRIPT (goal_goalattack_deactivate) 
	(GoalManager_ClearLastGoal) 
	IF (ObjectExists) (id) = (mp_goal_text) 
		(DestroyScreenElement) (id) = (mp_goal_text) 
	ENDIF 
	IF (ScreenElementExists) (id) = (goal_retry_anchor) 
		(DestroyScreenElement) (id) = (goal_retry_anchor) 
	ENDIF 
ENDSCRIPT

SCRIPT (goalattack_done) 
	(dialog_box_exit) 
	(do_backend_retry) 
ENDSCRIPT

SCRIPT (goal_goalattack_expire) 
	IF (ObjectExists) (id) = (goal_message) 
		(DestroyScreenElement) (id) = (goal_message) 
	ENDIF 
	(printf) "goal_goalattack_expire" 
	(GoalManager_LoseGoal) (name) = <goal_id> 
	IF (OnServer) 
		(CalculateFinalScores) 
		(SendGameOverToObservers) 
		(SpawnScript) (wait_then_create_rankings) (params) = { (score_title_text) = "GOALS" } 
	ELSE 
		(create_rankings) (score_title_text) = "GOALS" 
	ENDIF 
ENDSCRIPT

SCRIPT (AddGoal_GoalAttack) 
	(GoalManager_AddGoal) (name) = (goalattack) { 
		(params) = { (goal_goalattack_genericParams) 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT (StartGoal_GoalAttack) 
	(GoalManager_EditGoal) (name) = (goalattack) (params) = <...> 
	(GoalManager_ActivateGoal) (name) = (goalattack) 
ENDSCRIPT

SCRIPT (back_to_game_options) 
	(dialog_box_exit) 
	(create_network_game_options_menu) 
ENDSCRIPT

SCRIPT (create_choose_goals_menu) 
	IF (ObjectExists) (id) = (current_menu_anchor) 
		(DestroyScreenElement) (id) = (current_menu_anchor) 
	ENDIF 
	(GoalManager_HidePoints) 
	(hide_net_player_names) 
	IF (ObjectExists) (id) = (current_menu_anchor) 
		(DestroyScreenElement) (id) = (current_menu_anchor) 
	ENDIF 
	(SetScreenElementLock) (id) = (root_window) (off) 
	(CreateScreenElement) { 
		(type) = (ContainerElement) 
		(parent) = (root_window) 
		(id) = (goals_anchor) 
		(dims) = PAIR(640, 480) 
		(pos) = PAIR(320, 240) 
	} 
	(AssignAlias) (id) = (goals_anchor) (alias) = (current_menu_anchor) 
	(kill_start_key_binding) 
	(FormatText) (ChecksumName) = (title_icon) "%i_options" (i) = ( (THEME_PREFIXES) [ (current_theme_prefix) ] ) 
	(build_theme_sub_title) (title) = "CHOOSE GOALS" (title_icon) = <title_icon> 
	(FormatText) (ChecksumName) = (paused_icon) "%i_paused_icon" (i) = ( (THEME_PREFIXES) [ (current_theme_prefix) ] ) 
	(build_theme_box_icons) (icon_texture) = <paused_icon> 
	(build_grunge_piece) 
	(build_top_bar) (pos) = PAIR(0, 62) 
	(CreateScreenElement) { 
		(type) = (ContainerElement) 
		(parent) = (goals_anchor) 
		(id) = (goals_menu) 
		(dims) = PAIR(640, 480) 
		(pos) = PAIR(320, 640) 
	} 
	(AssignAlias) (id) = (goals_menu) (alias) = (current_menu_anchor) 
	(theme_background) (width) = 6.34999990463 (pos) = PAIR(320.00000000000, 85.00000000000) (num_parts) = 10.50000000000 
	<root_pos> = PAIR(80.00000000000, 25.00000000000) 
	(FormatText) (ChecksumName) = (text_rgba) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (current_menu_anchor) 
		(id) = (view_goals_menu_top_bar) 
		(texture) = (black) 
		(rgba) = [ 0 0 0 85 ] 
		(scale) = PAIR(130.00000000000, 7.00000000000) 
		(pos) = PAIR(65.00000000000, 87.00000000000) 
		(just) = [ (left) (top) ] 
		(z_priority) = 2 
	} 
	(GetStackedScreenElementPos) (Y) (id) = <id> (offset) = PAIR(6.00000000000, -25.00000000000) 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (current_menu_anchor) 
		(font) = (dialog) 
		(text) = "Goals" 
		(rgba) = <text_rgba> 
		(scale) = 1 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(z_priority) = 3 
	} 
	(GetStackedScreenElementPos) (X) (id) = <id> (offset) = PAIR(115.00000000000, 0.00000000000) 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (current_menu_anchor) 
		(id) = (view_goals_menu_up_arrow) 
		(texture) = (up_arrow) 
		(rgba) = [ 128 128 128 85 ] 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(z_priority) = 3 
	} 
	(GetStackedScreenElementPos) (X) (id) = <id> (offset) = PAIR(210.00000000000, 0.00000000000) 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (current_menu_anchor) 
		(font) = (dialog) 
		(text) = "On/Off" 
		(rgba) = <text_rgba> 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(scale) = 1 
		(z_priority) = 3 
	} 
	(GetStackedScreenElementPos) (Y) (id) = (view_goals_menu_top_bar) (offset) = PAIR(60.00000000000, 0.00000000000) 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (current_menu_anchor) 
		(texture) = (black) 
		(scale) = PAIR(2.00000000000, 68.00000000000) 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(rgba) = [ 0 0 0 0 ] 
	} 
	(GetStackedScreenElementPos) (X) (id) = <id> (offset) = PAIR(355.00000000000, 0.00000000000) 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (current_menu_anchor) 
		(texture) = (black) 
		(scale) = PAIR(2.00000000000, 68.00000000000) 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(rgba) = [ 0 0 0 0 ] 
	} 
	(GetStackedScreenElementPos) (Y) (id) = (view_goals_menu_top_bar) (offset) = PAIR(0.00000000000, 250.00000000000) 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (current_menu_anchor) 
		(texture) = (black) 
		(rgba) = [ 0 0 0 0 ] 
		(scale) = PAIR(124.00000000000, 6.00000000000) 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(z_priority) = 2 
	} 
	(GetStackedScreenElementPos) (Y) (id) = (view_goals_menu_up_arrow) (offset) = PAIR(0.00000000000, 260.00000000000) 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (current_menu_anchor) 
		(id) = (view_goals_menu_down_arrow) 
		(texture) = (down_arrow) 
		(rgba) = [ 128 128 128 85 ] 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(z_priority) = 3 
	} 
	(GetStackedScreenElementPos) (Y) (id) = (view_goals_menu_top_bar) (offset) = PAIR(20.00000000000, 5.00000000000) 
	(CreateScreenElement) { 
		(type) = (VScrollingMenu) 
		(parent) = (current_menu_anchor) 
		(dims) = PAIR(640.00000000000, 245.00000000000) 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(internal_just) = [ (center) (top) ] 
	} 
	(CreateScreenElement) { 
		(type) = (VMenu) 
		(parent) = <id> 
		(id) = (goals_vmenu) 
		(pos) = PAIR(0.00000000000, 0.00000000000) 
		(just) = [ (left) (top) ] 
		(internal_just) = [ (left) (top) ] 
		(dont_allow_wrap) 
		(event_handlers) = [ 
			{ (pad_up) (set_which_arrow) (params) = { (arrow) = (view_goals_menu_up_arrow) } } 
			{ (pad_down) (set_which_arrow) (params) = { (arrow) = (view_goals_menu_down_arrow) } } 
			{ (pad_up) (generic_menu_up_or_down_sound) (params) = { (up) } } 
			{ (pad_down) (generic_menu_up_or_down_sound) (params) = { (down) } } 
			{ (pad_back) (generic_menu_pad_back_sound) } 
		] 
	} 
	(AssignAlias) (id) = (goals_vmenu) (alias) = (current_menu) 
	(DoScreenElementMorph) (id) = (current_menu_anchor) (pos) = PAIR(320.00000000000, 240.00000000000) (time) = 0.20000000298 
	(FireEvent) (type) = (focus) (target) = (current_menu) 
	(SetScreenElementProps) { (id) = (current_menu) 
		(event_handlers) = [ 
			{ (pad_back) (generic_menu_pad_back) (params) = { (callback) = (exit_choose_goals_menu) } } 
		] 
	} 
	(GoalManager_AddGoalChoices) 
	(create_helper_text) (generic_helper_text) 
ENDSCRIPT

SCRIPT (exit_choose_goals_menu) 
	IF (ObjectExists) (id) = (goals_anchor) 
		(DestroyScreenElement) (id) = (goals_anchor) 
		(wait) 1 (gameframe) 
	ENDIF 
	IF (ObjectExists) (id) = (box_icon) 
		(DestroyScreenElement) (id) = (box_icon) 
		(wait) 1 (gameframe) 
	ENDIF 
	IF (ObjectExists) (id) = (box_icon_2) 
		(DestroyScreenElement) (id) = (box_icon_2) 
		(wait) 1 (gameframe) 
	ENDIF 
	IF (ObjectExists) (id) = (grunge_anchor) 
		(DestroyScreenElement) (id) = (grunge_anchor) 
		(wait) 1 (gameframe) 
	ENDIF 
	(create_network_game_options_menu) 
ENDSCRIPT

SCRIPT (hide_net_player_names) 
	IF (GotParam) (on) 
		(scale) = 1 
	ELSE 
		(scale) = 0 
	ENDIF 
	(index) = 0 
	BEGIN 
		IF (ScreenElementExists) (id) = { (net_score_menu) (child) = <index> } 
			(DoScreenElementMorph) (id) = { (net_score_menu) (child) = <index> } (scale) = <scale> (time) = 0 
		ENDIF 
	REPEAT 8 
ENDSCRIPT

SCRIPT (choose_goals_menu_set_events) 
	(FormatText) (ChecksumName) = (off_rgba) "%i_UNHIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(FormatText) (ChecksumName) = (on_rgba) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(CreateScreenElement) { 
		(type) = (ContainerElement) 
		(parent) = (current_menu) 
		(just) = [ (left) (top) ] 
		(internal_just) = [ (left) (top) ] 
		(dims) = PAIR(640.00000000000, 20.00000000000) 
		(event_handlers) = [ { (focus) (choose_goals_menu_focus) } 
			{ (unfocus) (choose_goals_menu_unfocus) } 
			{ (pad_choose) (choose_goals_menu_choose) (params) = { (name) = <goal_id> } } 
		] 
	} 
	<row_container_id> = <id> 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = <row_container_id> 
		(just) = [ (left) (center) ] 
		(font) = (small) 
		(text) = <text> 
		(scale) = 0.80000001192 
		(rgba) = <off_rgba> 
	} 
	(GetScreenElementDims) (id) = <id> 
	IF ( <width> > 310 ) 
		(printf) <width> 
		(DoScreenElementMorph) (time) = 0 (id) = <id> (scale) = ( 0.80000001192 * 310.00000000000 / <width> ) 
	ENDIF 
	(highlight_angle) = RANDOM_NO_REPEAT(1, 1, 1, 1, 1, 1, 1, 1, 1, 1) RANDOMCASE 2 RANDOMCASE -2 RANDOMCASE 3 RANDOMCASE -3 RANDOMCASE 3.50000000000 RANDOMCASE -3 RANDOMCASE 5 RANDOMCASE -4 RANDOMCASE 2.50000000000 RANDOMCASE -4.50000000000 RANDOMEND 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = <row_container_id> 
		(texture) = (de_highlight_bar) 
		(pos) = PAIR(-25.00000000000, 0.00000000000) 
		(just) = [ (left) (center) ] 
		(rgba) = [ 0 0 0 0 ] 
		(z_priority) = 3 
		(scale) = PAIR(4.09999990463, 0.69999998808) 
		(rot_angle) = ( <highlight_angle> / 4 ) 
	} 
	IF (GoalManager_GoalIsSelected) (name) = <goal_id> 
		<check_rgba> = <on_rgba> 
	ELSE 
		<check_rgba> = [ 0 0 0 0 ] 
	ENDIF 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = <row_container_id> 
		(just) = [ (left) (center) ] 
		(font) = (small) 
		(texture) = (checkbox) 
		(pos) = PAIR(420.00000000000, 0.00000000000) 
		(scale) = 0.50000000000 
		(rgba) = <off_rgba> 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = <row_container_id> 
		(just) = [ (left) (center) ] 
		(font) = (small) 
		(texture) = (checkmark) 
		(pos) = PAIR(420.00000000000, -2.00000000000) 
		(scale) = 0.75000000000 
		(rgba) = <check_rgba> 
		(z_priority) = 10 
	} 
ENDSCRIPT

SCRIPT (view_selected_goals_menu_set_events) 
	(FormatText) (ChecksumName) = (off_rgba) "%i_UNHIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(FormatText) (ChecksumName) = (on_rgba) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(CreateScreenElement) { 
		(type) = (ContainerElement) 
		(parent) = (current_menu) 
		(just) = [ (left) (top) ] 
		(internal_just) = [ (left) (top) ] 
		(dims) = PAIR(640.00000000000, 20.00000000000) 
		(event_handlers) = [ { (focus) (choose_goals_menu_focus) } 
			{ (unfocus) (choose_goals_menu_unfocus) } 
		] 
	} 
	<row_container_id> = <id> 
	(GoalManager_ReplaceTrickText) (name) = <goal_id> 
	(wait) 200 
	(printstruct) <...> 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = <row_container_id> 
		(just) = [ (left) (center) ] 
		(font) = (small) 
		(text) = <text> 
		(scale) = 0.80000001192 
		(rgba) = <off_rgba> 
	} 
	(highlight_angle) = RANDOM_NO_REPEAT(1, 1, 1, 1, 1, 1, 1, 1, 1, 1) RANDOMCASE 2 RANDOMCASE -2 RANDOMCASE 3 RANDOMCASE -3 RANDOMCASE 3.50000000000 RANDOMCASE -3 RANDOMCASE 5 RANDOMCASE -4 RANDOMCASE 2.50000000000 RANDOMCASE -4.50000000000 RANDOMEND 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = <row_container_id> 
		(texture) = (de_highlight_bar) 
		(pos) = PAIR(-25.00000000000, 0.00000000000) 
		(just) = [ (left) (center) ] 
		(rgba) = [ 0 0 0 0 ] 
		(z_priority) = 3 
		(scale) = PAIR(4.09999990463, 0.69999998808) 
		(rot_angle) = ( <highlight_angle> / 4 ) 
	} 
	IF (GoalManager_HasWonGoal) (name) = <goal_id> 
		<check_rgba> = <on_rgba> 
	ELSE 
		<check_rgba> = [ 0 0 0 0 ] 
	ENDIF 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = <row_container_id> 
		(just) = [ (left) (center) ] 
		(font) = (small) 
		(texture) = (checkbox) 
		(pos) = PAIR(420.00000000000, 0.00000000000) 
		(scale) = 0.50000000000 
		(rgba) = <off_rgba> 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = <row_container_id> 
		(just) = [ (left) (center) ] 
		(font) = (small) 
		(texture) = (checkmark) 
		(pos) = PAIR(420.00000000000, 0.00000000000) 
		(scale) = 0.75000000000 
		(rgba) = <check_rgba> 
		(z_priority) = 10 
	} 
ENDSCRIPT

SCRIPT (choose_goals_menu_choose) 
	(GetTags) 
	(FormatText) (ChecksumName) = (text_rgba) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	IF (OnServer) 
		(GoalManager_ToggleGoalSelection) <...> 
	ELSE 
		(GoalManager_ToggleGoalSelection) <...> 
		(FCFSRequestToggleGoalSelection) <...> 
	ENDIF 
	(wait) 0.20000000298 (seconds) 
	IF (GoalManager_GoalIsSelected) (name) = <name> 
		(DoScreenElementMorph) { 
			(id) = { <id> (child) = 3 } 
			(rgba) = <text_rgba> 
		} 
	ELSE 
		(DoScreenElementMorph) { 
			(id) = { <id> (child) = 3 } 
			(rgba) = [ 0 0 0 0 ] 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT (choose_goals_menu_focus) 
	(GetTags) 
	(FormatText) (ChecksumName) = (text_rgba) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(RunScriptOnScreenElement) (id) = { <id> (child) = 0 } (text_twitch_effect2) 
	(GetScreenElementDims) (id) = { <id> (child) = 0 } 
	IF ( <width> > 305 ) 
		(printf) <width> 
		(DoScreenElementMorph) (time) = 0 (id) = { <id> (child) = 0 } (scale) = ( 0.80000001192 * 310.00000000000 / <width> ) (rgba) = <text_rgba> 
	ELSE 
		(DoScreenElementMorph) { 
			(id) = { <id> (child) = 0 } 
			(rgba) = <text_rgba> 
			(scale) = ( 0.80000001192 * ( ( <width> + 5.00000000000 ) / <width> ) ) 
		} 
	ENDIF 
	(FormatText) (ChecksumName) = (bar_rgba) "%i_HIGHLIGHT_BAR_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(SetScreenElementProps) { 
		(id) = { <id> (child) = 1 } 
		(rgba) = <bar_rgba> 
	} 
	IF (GotParam) (first_item) 
		(SetScreenElementProps) { 
			(id) = (view_goals_menu_up_arrow) 
			(rgba) = [ 128 128 128 0 ] 
		} 
	ELSE 
		(SetScreenElementProps) { 
			(id) = (view_goals_menu_up_arrow) 
			(rgba) = [ 128 128 128 85 ] 
		} 
	ENDIF 
	IF (GotParam) (last_item) 
		(SetScreenElementProps) { 
			(id) = (view_goals_menu_down_arrow) 
			(rgba) = [ 128 128 128 0 ] 
		} 
	ELSE 
		(SetScreenElementProps) { 
			(id) = (view_goals_menu_down_arrow) 
			(rgba) = [ 128 128 128 85 ] 
		} 
	ENDIF 
	(goals_vmenu) : (GetTags) 
	IF (GotParam) (arrow_id) 
		(menu_vert_blink_arrow) { (id) = <arrow_id> } 
	ENDIF 
ENDSCRIPT

SCRIPT (choose_goals_menu_unfocus) 
	(GetTags) 
	(FormatText) (ChecksumName) = (text_rgba) "%i_UNHIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(KillSpawnedScript) (name) = (text_twitch_effect2) 
	(DoScreenElementMorph) { 
		(id) = { <id> (child) = 0 } 
		(rgba) = <text_rgba> 
		(scale) = 0.80000001192 
	} 
	(GetScreenElementDims) (id) = { <id> (child) = 0 } 
	IF ( <width> > 310 ) 
		(printf) <width> 
		(DoScreenElementMorph) (time) = 0 (id) = { <id> (child) = 0 } (scale) = ( 0.80000001192 * 310.00000000000 / <width> ) 
	ENDIF 
	(SetScreenElementProps) { 
		(id) = { <id> (child) = 1 } 
		(rgba) = [ 0 0 0 0 ] 
	} 
ENDSCRIPT

SCRIPT (toggle_selection) 
	IF (OnServer) 
		(GoalManager_ToggleGoalSelection) <...> 
	ELSE 
		(GoalManager_ToggleGoalSelection) <...> 
		(FCFSRequestToggleGoalSelection) <...> 
	ENDIF 
ENDSCRIPT

SCRIPT (wait_and_create_view_selected_goals_menu) 
	(wait) 120 (frames) 
	(create_view_selected_goals_menu) <...> 
ENDSCRIPT

SCRIPT (create_view_selected_goals_menu) 
	IF (ObjectExists) (id) = (current_menu_anchor) 
		(DestroyScreenElement) (id) = (current_menu_anchor) 
	ENDIF 
	(edit_tricks_menu_exit) (just_remove) 
	IF NOT (GotParam) (from_pause) 
		(exit_pause_menu) 
	ENDIF 
	(hide_current_goal) 
	(destroy_onscreen_keyboard) 
	(dialog_box_exit) 
	(GoalManager_HidePoints) 
	(pause_balance_meter) 
	(pause_run_timer) 
	(kill_start_key_binding) 
	(SetScreenElementLock) (id) = (root_window) (off) 
	(CreateScreenElement) { 
		(type) = (ContainerElement) 
		(parent) = (root_window) 
		(id) = (goals_anchor) 
		(dims) = PAIR(640.00000000000, 480.00000000000) 
		(pos) = PAIR(320.00000000000, 240.00000000000) 
	} 
	(AssignAlias) (id) = (goals_anchor) (alias) = (current_menu_anchor) 
	(kill_start_key_binding) 
	(FormatText) (ChecksumName) = (title_icon) "%i_options" (i) = ( (THEME_PREFIXES) [ (current_theme_prefix) ] ) 
	IF (GotParam) (goal_summary) 
		(build_theme_sub_title) (title) = "GOAL LIST" (title_icon) = <title_icon> 
	ELSE 
		(build_theme_sub_title) (title) = "VIEW GOALS" (title_icon) = <title_icon> 
	ENDIF 
	(FormatText) (ChecksumName) = (paused_icon) "%i_paused_icon" (i) = ( (THEME_PREFIXES) [ (current_theme_prefix) ] ) 
	(build_theme_box_icons) (icon_texture) = <paused_icon> 
	(build_grunge_piece) 
	(build_top_bar) (pos) = PAIR(0.00000000000, 62.00000000000) 
	(CreateScreenElement) { 
		(type) = (ContainerElement) 
		(parent) = (goals_anchor) 
		(id) = (goals_menu) 
		(dims) = PAIR(640.00000000000, 480.00000000000) 
		(pos) = PAIR(320.00000000000, 640.00000000000) 
	} 
	(theme_background) (width) = 6.34999990463 (pos) = PAIR(320.00000000000, 85.00000000000) (num_parts) = 10.50000000000 
	<root_pos> = PAIR(80.00000000000, 25.00000000000) 
	(FormatText) (ChecksumName) = (text_rgba) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (current_menu_anchor) 
		(id) = (view_goals_menu_top_bar) 
		(texture) = (black) 
		(rgba) = [ 0 0 0 85 ] 
		(scale) = PAIR(130.00000000000, 7.00000000000) 
		(pos) = PAIR(65.00000000000, 87.00000000000) 
		(just) = [ (left) (top) ] 
		(z_priority) = 2 
	} 
	(GetStackedScreenElementPos) (Y) (id) = <id> (offset) = PAIR(6.00000000000, -25.00000000000) 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (current_menu_anchor) 
		(font) = (dialog) 
		(text) = "Goals" 
		(rgba) = <text_rgba> 
		(scale) = 1 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(z_priority) = 3 
	} 
	(GetStackedScreenElementPos) (X) (id) = <id> (offset) = PAIR(115.00000000000, 0.00000000000) 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (current_menu_anchor) 
		(id) = (view_goals_menu_up_arrow) 
		(texture) = (up_arrow) 
		(rgba) = [ 128 128 128 85 ] 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(z_priority) = 3 
	} 
	(GetStackedScreenElementPos) (X) (id) = <id> (offset) = PAIR(190.00000000000, 0.00000000000) 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = (current_menu_anchor) 
		(font) = (dialog) 
		(text) = "Completed" 
		(rgba) = <text_rgba> 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(scale) = 1 
		(z_priority) = 3 
	} 
	(GetStackedScreenElementPos) (Y) (id) = (view_goals_menu_top_bar) (offset) = PAIR(60.00000000000, 0.00000000000) 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (current_menu_anchor) 
		(texture) = (black) 
		(scale) = PAIR(2.00000000000, 68.00000000000) 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(rgba) = [ 0 0 0 0 ] 
	} 
	(GetStackedScreenElementPos) (X) (id) = <id> (offset) = PAIR(355.00000000000, 0.00000000000) 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (current_menu_anchor) 
		(texture) = (black) 
		(scale) = PAIR(2.00000000000, 68.00000000000) 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(rgba) = [ 0 0 0 0 ] 
	} 
	(GetStackedScreenElementPos) (Y) (id) = (view_goals_menu_top_bar) (offset) = PAIR(0.00000000000, 250.00000000000) 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (current_menu_anchor) 
		(texture) = (black) 
		(rgba) = [ 0 0 0 0 ] 
		(scale) = PAIR(124.00000000000, 6.00000000000) 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(z_priority) = 2 
	} 
	(GetStackedScreenElementPos) (Y) (id) = (view_goals_menu_up_arrow) (offset) = PAIR(0.00000000000, 260.00000000000) 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (current_menu_anchor) 
		(id) = (view_goals_menu_down_arrow) 
		(texture) = (down_arrow) 
		(rgba) = [ 128 128 128 85 ] 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(z_priority) = 3 
	} 
	(GetStackedScreenElementPos) (Y) (id) = (view_goals_menu_top_bar) (offset) = PAIR(20.00000000000, 5.00000000000) 
	(CreateScreenElement) { 
		(type) = (VScrollingMenu) 
		(parent) = (current_menu_anchor) 
		(dims) = PAIR(640.00000000000, 245.00000000000) 
		(pos) = <pos> 
		(just) = [ (left) (top) ] 
		(internal_just) = [ (center) (top) ] 
	} 
	(CreateScreenElement) { 
		(type) = (VMenu) 
		(parent) = <id> 
		(id) = (goals_vmenu) 
		(pos) = PAIR(0.00000000000, 0.00000000000) 
		(just) = [ (left) (top) ] 
		(internal_just) = [ (left) (top) ] 
		(dont_allow_wrap) 
		(event_handlers) = [ 
			{ (pad_up) (set_which_arrow) (params) = { (arrow) = (view_goals_menu_up_arrow) } } 
			{ (pad_down) (set_which_arrow) (params) = { (arrow) = (view_goals_menu_down_arrow) } } 
			{ (pad_up) (generic_menu_up_or_down_sound) (params) = { (up) } } 
			{ (pad_down) (generic_menu_up_or_down_sound) (params) = { (down) } } 
			{ (pad_back) (generic_menu_pad_back_sound) } 
		] 
	} 
	(AssignAlias) (id) = (goals_vmenu) (alias) = (current_menu) 
	(DoScreenElementMorph) (id) = (current_menu_anchor) (pos) = PAIR(320.00000000000, 240.00000000000) (time) = 0.20000000298 
	(FireEvent) (type) = (focus) (target) = (current_menu) 
	IF (GotParam) (goal_summary) 
		(SetScreenElementProps) { (id) = (current_menu) 
			(event_handlers) = [ 
				{ (pad_back) (generic_menu_pad_back) (params) = { (callback) = (close_goals_menu) } } 
			] 
		} 
	ELSE 
		(SetScreenElementProps) { (id) = (current_menu) 
			(event_handlers) = [ 
				{ (pad_back) (generic_menu_pad_back) (params) = { (callback) = (exit_view_goals_menu) } } 
			] 
		} 
	ENDIF 
	(GoalManager_AddGoalChoices) (selected_only) 
	(create_helper_text) (helper_text_elements) = [ { (text) = "\\m1 = Back" } ] 
ENDSCRIPT

SCRIPT (exit_view_goals_menu) 
	IF (ObjectExists) (id) = (goals_anchor) 
		(DestroyScreenElement) (id) = (goals_anchor) 
		(wait) 1 (gameframe) 
	ENDIF 
	IF (ObjectExists) (id) = (box_icon) 
		(DestroyScreenElement) (id) = (box_icon) 
		(wait) 1 (gameframe) 
	ENDIF 
	IF (ObjectExists) (id) = (box_icon_2) 
		(DestroyScreenElement) (id) = (box_icon_2) 
		(wait) 1 (gameframe) 
	ENDIF 
	IF (ObjectExists) (id) = (grunge_anchor) 
		(DestroyScreenElement) (id) = (grunge_anchor) 
		(wait) 1 (gameframe) 
	ENDIF 
	(create_pause_menu) 
ENDSCRIPT

SCRIPT (close_goals_menu) 
	IF (ObjectExists) (id) = (goals_anchor) 
		(DestroyScreenElement) (id) = (goals_anchor) 
		(wait) 1 (gameframe) 
	ENDIF 
	IF (ObjectExists) (id) = (box_icon) 
		(DestroyScreenElement) (id) = (box_icon) 
		(wait) 1 (gameframe) 
	ENDIF 
	IF (ObjectExists) (id) = (box_icon_2) 
		(DestroyScreenElement) (id) = (box_icon_2) 
		(wait) 1 (gameframe) 
	ENDIF 
	IF (ObjectExists) (id) = (grunge_anchor) 
		(DestroyScreenElement) (id) = (grunge_anchor) 
		(wait) 1 (gameframe) 
	ENDIF 
	(GoalManager_ShowPoints) 
	(unpause_balance_meter) 
	(unpause_run_timer) 
	(restore_start_key_binding) 
	IF (ObjectExists) (id) = (view_goals_menu) 
		(exit_pause_menu) 
	ENDIF 
ENDSCRIPT

SCRIPT (goal_attack_completed_goal) 
	(FormatText) (TextName) = (msg_text) "Goal Completed! %i to go!" (i) = <NumGoalsLeft> 
	(create_net_panel_message) (text) = <msg_text> (style) = (net_team_panel_message) 
ENDSCRIPT

SCRIPT (goal_attack_completed_goal_other_same_team) 
	(FormatText) (TextName) = (msg_text) "%n Completed %t! %i to go!" (n) = <PlayerName> (t) = <GoalText> (i) = <NumGoalsLeft> 
	(create_net_panel_message) (text) = <msg_text> (style) = (net_team_panel_message) 
ENDSCRIPT

SCRIPT (goal_attack_started_goal_other_same_team) 
	(FormatText) (TextName) = (msg_text) "%n Started %t!" (n) = <PlayerName> (t) = <GoalText> 
	(create_net_panel_message) (text) = <msg_text> (style) = (net_team_panel_message) 
ENDSCRIPT


