
goal_editor_placement_mode = 0 
in_create_a_goal = 0 
SCRIPT set_in_create_a_goal 
	Change in_create_a_goal = 1 
ENDSCRIPT

SCRIPT reset_in_create_a_goal 
	Change in_create_a_goal = 0 
ENDSCRIPT

SCRIPT my_exit_pause_menu 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	pause_menu_gradient off 
	SetScreenElementProps id = root_window tags = { menu_state = off } 
	IF CustomParkMode editing 
		IF NOT GotParam DoNotSwitchEditorState 
			SetParkEditorState state = edit 
			SetParkEditorPauseMode unpause 
		ENDIF 
	ENDIF 
	restore_start_key_binding 
ENDSCRIPT

SCRIPT parked_create_a_goal 
	Change check_for_unplugged_controllers = 0 
	SwitchOffRailEditor 
	DisassociateFromObject 
	my_exit_pause_menu 
	SetParkEditorPauseMode pause 
	PauseSkaters 
	HideSkaterAndMiscSkaterEffects 
	kill_start_key_binding 
	create_existing_goals_menu 
	Change check_for_unplugged_controllers = 1 
ENDSCRIPT

SCRIPT existing_goals_menu_back 
	reset_in_create_a_goal 
	IF CustomParkMode editing 
		goto generic_menu_pad_back params = { callback = exit_pause_menu } 
	ELSE 
		goto generic_menu_pad_back params = { callback = create_pause_menu } 
	ENDIF 
ENDSCRIPT

SCRIPT create_existing_goals_menu 
	IF NOT GameModeEquals is_creategoals 
		ScriptAssert "Game mode is not CreateGoals !" 
	ENDIF 
	hide_current_goal 
	dialog_box_exit 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	set_in_create_a_goal 
	array_size = 0 
	GetCurrentLevel 
	IF ChecksumEquals a = <level> b = Load_Sk5Ed_gameplay 
		level = Load_Sk5Ed 
	ENDIF 
	GoalEditor : GetEditedGoalsInfo level = <level> 
	IF GotParam EditedGoalsInfo 
		GetArraySize <EditedGoalsInfo> 
	ENDIF 
	pause_menu_gradient on 
	FormatText ChecksumName = title_icon "%i_sound" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	num_lines = ( <array_size> + 1 ) 
	IF ( <num_lines> > 8 ) 
		num_lines = 8 
	ENDIF 
	make_new_themed_scrolling_menu title = "CREATED GOALS" title_icon = <title_icon> dims = ( PAIR(300, 0) + PAIR(0, 1) * 23 * <num_lines> ) 
	SetScreenElementProps { 
		id = sub_menu 
		event_handlers = [ { pad_back generic_menu_pad_back params = { callback = existing_goals_menu_back } } ] 
		replace_handlers 
	} 
	IF ( <array_size> = 0 ) 
		params = { last_item } 
	ELSE 
		params = { } 
	ENDIF 
	IF GoalEditor : MaxEditedGoalsReached level = <level> 
		params = ( <params> + { not_focusable = not_focusable } ) 
	ENDIF 
	theme_menu_add_item { 
		first_item 
		text = "Create new goal" 
		pad_choose_script = create_goal_type_select_menu 
		centered = 1 
		no_bg 
		<params> 
	} 
	IF ( <array_size> > 0 ) 
		i = 0 
		BEGIN 
			params = { 
				text = ( ( <EditedGoalsInfo> [ <i> ] ) . view_goals_text ) 
				pad_choose_script = select_created_goal 
				pad_choose_params = { goal_id = ( ( <EditedGoalsInfo> [ <i> ] ) . goal_id ) } 
				centered 
				no_bg 
				no_sound 
			} 
			IF ( <i> = ( <array_size> -1 ) ) 
				params = ( <params> + { last_item } ) 
			ENDIF 
			theme_menu_add_item <params> 
			i = ( <i> + 1 ) 
		REPEAT <array_size> 
	ENDIF 
	finish_themed_scrolling_menu 
ENDSCRIPT

SCRIPT select_created_goal 
	end_current_goal_run 
	GoalEditor : SetCurrentEditorGoal goal_id = <goal_id> 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	create_edit_goal_menu go_back_to_goal_list_menu 
ENDSCRIPT

SCRIPT load_goals 
	printf "TODO" 
ENDSCRIPT

SCRIPT save_goals 
	printf "TODO" 
ENDSCRIPT

goals_menu_info = 
[ 
	{ 
		name = "SKATE letters" 
		type = skate 
	} 
	{ 
		name = "COMBO letters" 
		type = combo 
	} 
	{ 
		name = "High Score" 
		type = HighScore 
	} 
	{ 
		name = "High Combo" 
		type = HighCombo 
	} 
	{ 
		name = "Skate-Tricks" 
		type = Skatetris 
	} 
	{ 
		name = "Combo Skate-Tricks" 
		type = ComboSkatetris 
	} 
	{ 
		name = "Tricktris" 
		type = TrickTris 
	} 
	{ 
		name = "Gap" 
		type = gap 
	} 
] 
SCRIPT create_goal_type_select_menu 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	destroy_goal_panel_messages 
	set_in_create_a_goal 
	FormatText ChecksumName = title_icon "%i_trick" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	make_new_themed_sub_menu title = "SELECT GOAL TYPE" title_icon = <title_icon> 
	SetScreenElementProps { 
		id = sub_menu 
		event_handlers = [ { pad_back generic_menu_pad_back params = { callback = create_existing_goals_menu } } 
		] 
		replace_handlers 
	} 
	CreateGapList 
	IF ( <array_size> = 0 ) 
		no_gaps = 1 
	ENDIF 
	RemoveParameter GapList 
	GetArraySize goals_menu_info 
	i = 0 
	BEGIN 
		IF ( <i> = 0 ) 
			first_item = first_item 
		ELSE 
			RemoveParameter first_item 
		ENDIF 
		not_focusable = ( goals_menu_info [ <i> ] . not_focusable ) 
		IF ( goals_menu_info [ <i> ] . type = gap ) 
			IF CustomParkMode editing 
				IF GotParam no_gaps 
					not_focusable = not_focusable 
				ENDIF 
			ELSE 
				IF ( <num_gaps_got> = 0 ) 
					not_focusable = not_focusable 
				ENDIF 
			ENDIF 
		ENDIF 
		theme_menu_add_item { 
			<first_item> 
			not_focusable = <not_focusable> 
			text = ( goals_menu_info [ <i> ] . name ) 
			pad_choose_script = goal_editor_set_type 
			pad_choose_params = { type = ( goals_menu_info [ <i> ] . type ) } 
			centered = 1 
		} 
		i = ( <i> + 1 ) 
	REPEAT <array_size> 
	theme_menu_add_item { 
		text = "Done" 
		pad_choose_script = create_existing_goals_menu 
		last_item 
		centered = 1 
		last_menu_item = 1 
	} 
	finish_themed_sub_menu 
ENDSCRIPT

SCRIPT edit_goal_pad_start 
	generic_menu_pad_choose_sound 
	GoalEditor : Suspend 
	set_in_create_a_goal 
	IF ScreenElementExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	IF GoalEditor : GoalHasAllPositionsSet 
		text = "Quit editing goal?" 
	ELSE 
		text = "Quit editing and erase goal?" 
	ENDIF 
	create_dialog_box { title = "Quit" 
		text = <text> 
		pos = PAIR(310, 240) 
		just = [ center center ] 
		text_rgba = [ 88 105 112 128 ] 
		pad_back_script = edit_goal_continue 
		pad_back_params = { make_sound } 
		buttons = 
		[ 
			{ font = small text = "No" pad_choose_script = edit_goal_continue } 
			{ font = small text = "Yes" pad_choose_script = edit_goal_quit } 
		] 
	} 
ENDSCRIPT

SCRIPT edit_goal_continue 
	IF GotParam make_sound 
		generic_menu_pad_back_sound 
	ENDIF 
	dialog_box_exit 
	SetScreenElementProps { 
		id = root_window 
		replace_handlers 
		event_handlers = 
		[ 
			{ 
				pad_start 
				edit_goal_pad_start 
			} 
		] 
	} 
	create_cag_helper_text 
	Debounce X time = 0.20000000298 clear = 1 
	Debounce Triangle time = 0.20000000298 clear = 1 
	GoalEditor : Unsuspend 
ENDSCRIPT

SCRIPT edit_goal_quit 
	GoalEditor : RefreshGoalCursorPosition 
	dialog_box_exit 
	Change goal_editor_placement_mode = 0 
	IF GoalEditor : GoalHasAllPositionsSet 
		create_edit_goal_menu go_back_to_goal_list_menu 
	ELSE 
		edit_goal_menu_back 
	ENDIF 
ENDSCRIPT

SCRIPT goal_editor_set_type 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	pause_menu_gradient off 
	end_current_goal_run 
	HideSkaterAndMiscSkaterEffects 
	destroy_goal_panel_messages 
	SetScreenElementProps { 
		id = root_window 
		replace_handlers 
		event_handlers = 
		[ 
			{ 
				pad_start 
				edit_goal_pad_start 
			} 
		] 
	} 
	delete_goal_editor_marker_objects 
	IF GoalEditor : FindUnfinishedGoal type = <type> 
		GoalEditor : EditGoal 
	ELSE 
		goal_name = "" 
		SWITCH <type> 
			CASE skate 
				goal_name = "Skate letters" 
			CASE combo 
				goal_name = "Combo letters" 
			CASE HighScore 
				goal_name = "High Score" 
			CASE HighCombo 
				goal_name = "High Combo" 
			CASE Skatetris 
				goal_name = "Skate-Tricks" 
			CASE ComboSkatetris 
				goal_name = "Combo Skate-Tricks" 
			CASE TrickTris 
				goal_name = "Tricktris" 
			CASE gap 
				goal_name = "Gaps" 
		ENDSWITCH 
		IF GoalEditor : GoalExists goal_name = <goal_name> 
			suffix = 2 
			BEGIN 
				FormatText TextName = new_name "%s %d" s = <goal_name> d = <suffix> 
				IF NOT GoalEditor : GoalExists goal_name = <new_name> 
					BREAK 
				ENDIF 
				suffix = ( <suffix> + 1 ) 
			REPEAT 
			goal_name = <new_name> 
		ENDIF 
		GoalEditor : NewEditorGoal 
		GoalEditor : SetEditorGoalType type = <type> 
		GoalEditor : SetEditorGoalName name = <goal_name> 
	ENDIF 
	Debounce X time = 0.20000000298 clear = 1 
	Debounce Triangle time = 0.20000000298 clear = 1 
	GoalEditor : unpause 
	GoalEditor : Unsuspend 
	GoalEditor : Unhide 
	Change goal_editor_placement_mode = 1 
	IF CustomParkMode editing 
		GetParkEditorCursorPos 
		RebuildParkNodeArray 
	ELSE 
		skater : GetLastGroundPos 
	ENDIF 
	GoalEditor : EditorCam_Initialise position = <pos> 
	SetActiveCamera id = GoalEditor 
	create_cag_helper_text PedPosition 
ENDSCRIPT

SCRIPT create_cag_helper_text 
	IF GotParam PedPosition 
		<cag_helper_text> = cag_helper_text_no_back 
		IF IsXBox 
			<cag_helper_text> = cag_helper_text_no_back_xbox 
		ENDIF 
		IF IsNGC 
			<cag_helper_text> = cag_helper_text_no_back_ngc 
		ENDIF 
	ELSE 
		<cag_helper_text> = cag_helper_text 
		IF IsXBox 
			<cag_helper_text> = cag_helper_text_xbox 
		ENDIF 
		IF IsNGC 
			<cag_helper_text> = cag_helper_text_ngc 
		ENDIF 
	ENDIF 
	SetScreenElementLock id = root_window off 
	create_helper_text <cag_helper_text> parent = root_window 
	SetScreenElementLock id = root_window off 
ENDSCRIPT

SCRIPT create_edit_goal_menu 
	GoalManager_HidePoints 
	GoalManager_HideGoalPoints 
	destroy_goal_panel_messages 
	SetParkEditorPauseMode pause 
	pause_menu_gradient on 
	set_in_create_a_goal 
	FormatText ChecksumName = title_icon "%i_trick" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	make_new_themed_sub_menu title = "EDIT GOAL" title_icon = <title_icon> pos = PAIR(235.00000000000, 80.00000000000) 
	GoalEditor : GetCurrentEditedGoalInfo 
	IF GotParam go_back_to_goal_list_menu 
		back_params = { go_back_to_goal_list_menu } 
	ELSE 
		back_params = { } 
	ENDIF 
	SetScreenElementProps { 
		id = sub_menu 
		event_handlers = [ { pad_back generic_menu_pad_back params = { callback = edit_goal_menu_back params = <back_params> } } 
		] 
		replace_handlers 
	} 
	SWITCH <goal_type> 
		CASE HighScore 
			high_score_text = "Set High Score" 
		CASE HighCombo 
			high_score_text = "Set High Combo Score" 
	ENDSWITCH 
	SWITCH <goal_type> 
		CASE HighScore 
		CASE HighCombo 
			theme_menu_add_number_item { 
				text = <high_score_text> 
				id = goal_score 
				min = 1000 
				max = 10000000 
				step = 1000 
				value = <score> 
				pad_left_script = goal_update_score 
				pad_right_script = goal_update_score 
				first_item 
				text_pos = PAIR(75.00000000000, -5.00000000000) 
			} 
		CASE Skatetris 
			theme_menu_add_item { 
				text = "Edit Skate-Tricks" 
				pad_choose_script = create_edit_skatetris_menu pad_choose_params = <back_params> 
				first_item 
				text_pos = PAIR(75.00000000000, -5.00000000000) 
			} 
		CASE ComboSkatetris 
			theme_menu_add_item { 
				text = "   Edit Combo Skate-Tricks" 
				pad_choose_script = create_edit_skatetris_menu pad_choose_params = <back_params> 
				first_item 
				text_pos = PAIR(75.00000000000, -5.00000000000) 
			} 
		CASE TrickTris 
			theme_menu_add_item { 
				text = "Edit Tricktris" 
				pad_choose_script = create_edit_skatetris_menu pad_choose_params = <back_params> 
				first_item 
				text_pos = PAIR(75.00000000000, -5.00000000000) 
			} 
		CASE gap 
			RemoveParameter not_focusable 
			CreateGapList 
			IF ( <array_size> = 0 ) 
				extra_text = "Error! Gaps deleted" 
				not_focusable = 1 
			ELSE 
				IF GotParam Gaps 
					GetArraySize <Gaps> 
					FormatText TextName = extra_text "%d gaps chosen" d = <array_size> 
				ELSE 
					extra_text = "No gaps chosen" 
				ENDIF 
			ENDIF 
			theme_menu_add_item { 
				text = "Pick gaps" 
				not_focusable = <not_focusable> 
				extra_text = <extra_text> 
				pad_choose_script = create_gap_select_menu 
				first_item 
				text_pos = PAIR(75.00000000000, -5.00000000000) 
			} 
			theme_menu_add_item { 
				text = "Required Trick" 
				extra_text = <required_trick_name> 
				pad_choose_script = input_required_trick_name 
				text_pos = PAIR(75.00000000000, -5.00000000000) 
			} 
	ENDSWITCH 
	theme_menu_add_item { 
		text = "Edit positions" 
		pad_choose_script = edit_goal 
		text_pos = PAIR(75.00000000000, -5.00000000000) 
	} 
	theme_menu_add_number_item { 
		text = "Set Time Limit" 
		id = goal_time 
		min = 15 
		max = 3600 
		step = 5 
		value = <time_limit> 
		text_pos = PAIR(75.00000000000, -5.00000000000) 
		pad_left_script = goal_update_time_limit 
		pad_right_script = goal_update_time_limit 
	} 
	theme_menu_add_item { 
		text = "Name Goal" 
		extra_text = <view_goals_text> 
		text_pos = PAIR(75.00000000000, -5.00000000000) 
		pad_choose_script = name_goal 
	} 
	theme_menu_add_item { 
		text = "Name Ped" 
		extra_text = <ped_name> 
		text_pos = PAIR(75.00000000000, -5.00000000000) 
		pad_choose_script = name_goal_ped 
	} 
	theme_menu_add_item { 
		text = "Set Goal Text" 
		text_pos = PAIR(75.00000000000, -5.00000000000) 
		pad_choose_script = set_goal_text 
	} 
	theme_menu_add_item { 
		text = "Edit Win Message" 
		text_pos = PAIR(75.00000000000, -5.00000000000) 
		pad_choose_script = edit_goal_win_message 
	} 
	theme_menu_add_number_item { 
		text = "Control" 
		text_pos = PAIR(75.00000000000, -5.00000000000) 
		id = goal_control 
		value = 3 
	} 
	update_control_text control_type = <control_type> 
	SetScreenElementProps { 
		id = goal_control 
		event_handlers = [ 
			{ pad_left goal_update_control params = { dir = -1 } } 
			{ pad_right goal_update_control } 
		] 
		replace_handlers 
	} 
	theme_menu_add_item { 
		text = "Delete Goal" 
		text_pos = PAIR(75.00000000000, -5.00000000000) 
		pad_choose_script = delete_goal 
		no_sound 
	} 
	IF NOT CustomParkMode editing 
		RemoveParameter not_focusable 
		IF ( <goal_type> = gap ) 
			IF NOT GotParam Gaps 
				not_focusable = not_focusable 
			ENDIF 
		ENDIF 
		theme_menu_add_item { 
			text = "Test Goal" 
			text_pos = PAIR(75.00000000000, -5.00000000000) 
			pad_choose_script = test_goal 
			not_focusable = <not_focusable> 
		} 
	ENDIF 
	theme_menu_add_item { 
		text = "Done" 
		pad_choose_script = edit_goal_menu_back 
		no_sound 
		last_item 
		text_pos = PAIR(75.00000000000, -5.00000000000) 
		last_menu_item = 1 
	} 
	finish_themed_sub_menu 
	create_helper_text generic_helper_text_up_down_adjust 
ENDSCRIPT

SCRIPT generate_control_name 
	SWITCH <control_type> 
		CASE JunkerCar 
			RETURN control_text = "Muscle Car" 
		CASE RallyCar 
			RETURN control_text = "Rally Car" 
		CASE ImpalaCar 
			RETURN control_text = "Trashed Car" 
		CASE TaxiCar 
			RETURN control_text = "Taxi Car" 
		CASE PoliceCar 
			RETURN control_text = "Police Car" 
		CASE ElCaminoCar 
			RETURN control_text = "Surfer Car" 
		CASE LadaCar 
			RETURN control_text = "Russian Car" 
		CASE MiniBajaCar 
			RETURN control_text = "Mini Baja Car" 
		CASE LimoCar 
			RETURN control_text = "Limousine" 
		CASE LeafBlower 
			RETURN control_text = "Leaf Blower Car" 
		CASE WalkOnly 
			RETURN control_text = "Walk Only" 
		CASE Walk 
			RETURN control_text = "Walk" 
		CASE skate 
			RETURN control_text = "Skate" 
		CASE SecurityCart 
			RETURN control_text = "Security Cart" 
		CASE GardnersCart 
			RETURN control_text = "Gardener\'s Cart" 
		CASE Blimp 
			RETURN control_text = "Blimp" 
		DEFAULT 
			RETURN control_text = "Update goal_editor_menu.q !!" 
	ENDSWITCH 
ENDSCRIPT

SCRIPT update_control_text 
	generate_control_name control_type = <control_type> 
	SetScreenElementProps { id = { goal_control child = 3 } text = <control_text> } 
	GetStackedScreenElementPos X id = { goal_control child = 3 } offset = PAIR(3.00000000000, 2.00000000000) 
	SetScreenElementProps { id = { goal_control child = 5 } pos = <pos> } 
ENDSCRIPT

control_types_basic = [ skate Walk WalkOnly ] 
control_types_NJ = [ skate Walk WalkOnly RallyCar ] 
control_types_NY = [ skate Walk WalkOnly ImpalaCar ] 
control_types_FL = [ skate Walk WalkOnly PoliceCar ] 
control_types_SD = [ skate Walk WalkOnly GardnersCart SecurityCart ] 
control_types_HI = [ skate Walk WalkOnly ElCaminoCar ] 
control_types_VC = [ skate Walk WalkOnly LeafBlower LimoCar ] 
control_types_SJ = [ skate Walk WalkOnly ] 
control_types_RU = [ skate Walk WalkOnly LadaCar ] 
control_types_SE = [ skate Walk WalkOnly MiniBajaCar ] 
control_types_Sk5Ed = [ skate Walk WalkOnly MiniBajaCar JunkerCar ] 
SCRIPT goal_update_control dir = 1 
	GoalEditor : GetCurrentEditedGoalInfo 
	SWITCH <goal_type> 
		CASE skate 
		CASE gap 
		CASE HighScore 
			GetCurrentLevel 
			SWITCH <level> 
				CASE Load_NJ 
					control_types = control_types_NJ 
				CASE Load_NY 
					control_types = control_types_NY 
				CASE Load_FL 
					control_types = control_types_FL 
				CASE Load_SD 
					control_types = control_types_SD 
				CASE Load_HI 
					control_types = control_types_HI 
				CASE Load_VC 
					control_types = control_types_VC 
				CASE Load_SJ 
					control_types = control_types_SJ 
				CASE Load_RU 
					control_types = control_types_RU 
				CASE Load_SE 
					control_types = control_types_SE 
				CASE Load_Sk5Ed 
				CASE Load_Sk5Ed_gameplay 
					control_types = control_types_Sk5Ed 
				DEFAULT 
					control_types = control_types_basic 
			ENDSWITCH 
		DEFAULT 
			control_types = control_types_basic 
	ENDSWITCH 
	GetArraySize <control_types> 
	i = 0 
	BEGIN 
		IF ChecksumEquals a = ( <control_types> [ <i> ] ) b = <control_type> 
			BREAK 
		ENDIF 
		i = ( <i> + 1 ) 
	REPEAT <array_size> 
	IF NOT ( <i> < <array_size> ) 
		printf "Control type %s not found in list of available types!" s = <control_type> 
		RETURN 
	ENDIF 
	i = ( <i> + <dir> ) 
	IF NOT ( <i> < <array_size> ) 
		i = 0 
	ENDIF 
	IF ( <i> < 0 ) 
		i = ( <array_size> -1 ) 
	ENDIF 
	control_type = ( <control_types> [ <i> ] ) 
	GoalEditor : SetGoalControlType <control_type> 
	update_control_text control_type = <control_type> 
ENDSCRIPT

SCRIPT edit_goal_menu_back 
	edit_goal_menu_exit no_exit_pause 
	generic_menu_pad_choose_sound 
	IF CustomParkMode editing 
		parked_continue_editing 
	ELSE 
		create_existing_goals_menu 
	ENDIF 
ENDSCRIPT

SCRIPT create_gap_select_menu 
	CreateGapList 
	num_menu_lines = <array_size> 
	IF ( <num_menu_lines> > 10 ) 
		num_menu_lines = 10 
	ENDIF 
	IF ( <num_menu_lines> = 0 ) 
		RETURN 
	ENDIF 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	FormatText ChecksumName = title_icon "%i_trick" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	make_new_themed_scrolling_menu title = "SELECT GAPS" title_icon = <title_icon> dims = ( PAIR(300.00000000000, 0.00000000000) + PAIR(0.00000000000, 1.00000000000) * 23 * <num_menu_lines> ) 
	SetScreenElementProps { 
		id = sub_menu 
		event_handlers = [ { pad_back create_edit_goal_menu } 
			{ pad_back generic_menu_pad_back_sound } 
		] 
		replace_handlers 
	} 
	IF ( <array_size> > 0 ) 
		i = 0 
		BEGIN 
			params = { } 
			IF ( <i> = 0 ) 
				params = { first_item } 
			ENDIF 
			IF ( <i> = <array_size> -1 ) 
				params = ( <params> + { last_item } ) 
			ENDIF 
			IF CustomParkMode editing 
			ELSE 
				IF ( <GapList> [ <i> ] . times = 0 ) 
					params = ( <params> + { not_focusable = not_focusable } ) 
				ENDIF 
			ENDIF 
			IF GoalEditor : EditedGoalGotGap gap_number = <i> 
				value = 1 
			ELSE 
				value = 0 
			ENDIF 
			FormatText ChecksumName = id "check%d" d = <i> 
			theme_menu_add_checkbox_item { 
				value = <value> 
				id = <id> 
				text = ( <GapList> [ <i> ] . gap_name ) 
				pad_choose_script = toggle_gap_on_off 
				pad_choose_params = { gap_number = <i> } 
				focus_script = gap_select_menu_focus 
				focus_params = ( <GapList> [ <i> ] ) 
				<params> 
				no_bg = no_bg 
			} 
			i = ( <i> + 1 ) 
		REPEAT <array_size> 
	ENDIF 
	finish_themed_scrolling_menu wide_menu 
ENDSCRIPT

SCRIPT toggle_gap_on_off 
	IF GoalEditor : EditedGoalGotGap gap_number = <gap_number> 
		GoalEditor : EditedGoalRemoveGap gap_number = <gap_number> 
		theme_set_checkbox value = 0 
	ELSE 
		GoalEditor : EditedGoalAddGap gap_number = <gap_number> 
		theme_set_checkbox value = 1 
	ENDIF 
ENDSCRIPT

SCRIPT gap_select_menu_focus 
	IF NOT CustomParkMode editing 
		gap_menu_focus_show_gap <...> 
	ENDIF 
	theme_checkbox_focus 
ENDSCRIPT

SCRIPT create_edit_skatetris_menu 
	count_chosen_combo_sets 
	IF ( <num_chosen_combo_sets> = 0 ) 
		gotopreserveparams create_key_combos_menu 
	ENDIF 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	GoalEditor : GetCurrentEditedGoalInfo 
	FormatText ChecksumName = title_icon "%i_trick" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	SWITCH <goal_type> 
		CASE ComboSkatetris 
			make_new_themed_sub_menu title = "COMBO SKATE-TRICKS" title_icon = <title_icon> 
		CASE TrickTris 
			make_new_themed_sub_menu title = "EDIT TRICKTRIS" title_icon = <title_icon> 
		DEFAULT 
			make_new_themed_sub_menu title = "EDIT SKATE-TRICKS" title_icon = <title_icon> 
	ENDSWITCH 
	IF GotParam go_back_to_goal_list_menu 
		back_params = { go_back_to_goal_list_menu } 
	ELSE 
		back_params = { } 
	ENDIF 
	SetScreenElementProps { 
		id = sub_menu 
		event_handlers = [ { pad_back create_edit_goal_menu params = <back_params> } 
			{ pad_back generic_menu_pad_back_sound } 
		] 
		replace_handlers 
	} 
	theme_menu_add_item { 
		first_item 
		text = "Key combos" 
		pad_choose_script = create_key_combos_menu 
		pad_choose_params = <back_params> 
		centered = 1 
	} 
	theme_menu_add_number_item { 
		text = "Spin" 
		id = goal_spin 
		min = 0 
		max = 900 
		step = 180 
		avoid = 180 
		value = <spin> 
		pad_left_script = goal_update_spin 
		pad_right_script = goal_update_spin 
	} 
	goal_update_spin value = <spin> 
	SWITCH <goal_type> 
		CASE ComboSkatetris 
			IF GotParam single_combo 
				value = 1 
				params = { } 
				NoSkatetrisParams = 1 
			ELSE 
				value = 0 
				params = { on } 
			ENDIF 
			theme_menu_add_checkbox_item { 
				value = <value> 
				id = SingleCombo 
				text = "Single Combo" 
				pad_choose_script = change_single_combo pad_choose_params = <params> 
			} 
			IF NOT GotParam NoSkatetrisParams 
				max = <max_tricks> 
			ELSE 
				max = 15 
			ENDIF 
			IF ( <combo_size> > <max> ) 
				combo_size = <max> 
				GoalEditor : SetGoalSpecificParams combo_size = <max> 
			ENDIF 
			theme_menu_add_number_item { 
				text = "Combo size" 
				id = goal_combo_size 
				min = 1 
				max = <max> 
				step = 1 
				value = <combo_size> 
				pad_left_script = goal_update_combo_size 
				pad_right_script = goal_update_combo_size 
			} 
		CASE TrickTris 
			theme_menu_add_number_item { 
				text = "Block size" 
				id = goal_block_size 
				min = 1 
				max = 15 
				step = 1 
				value = <tricktris_block_size> 
				pad_left_script = goal_update_tricktris_block_size 
				pad_right_script = goal_update_tricktris_block_size 
			} 
			theme_menu_add_number_item { 
				text = "Total to win" 
				id = goal_total_to_win 
				min = 1 
				max = 1000 
				step = 1 
				value = <tricktris_total_to_win> 
				pad_left_script = goal_update_tricktris_total_to_win 
				pad_right_script = goal_update_tricktris_total_to_win 
			} 
			NoSkatetrisParams = 1 
	ENDSWITCH 
	IF NOT GotParam NoSkatetrisParams 
		theme_menu_add_number_item { 
			text = "Acceleration interval" 
			id = goal_acceleration_interval 
			min = 1 
			max = 10 
			step = 1 
			value = <acceleration_interval> 
			pad_left_script = goal_update_acceleration_interval 
			pad_right_script = goal_update_acceleration_interval 
		} 
		percent = ( <acceleration_percent> * 100 + 0.00999999978 ) 
		CastToInteger percent 
		theme_menu_add_number_item { 
			text = "Acceleration percent" 
			id = goal_acceleration_percent 
			min = 1 
			max = 100 
			step = 1 
			value = <percent> 
			pad_left_script = goal_update_acceleration_percent 
			pad_right_script = goal_update_acceleration_percent 
		} 
		theme_menu_add_number_item { 
			text = "Trick time" 
			id = goal_trick_time 
			min = 5 
			max = 3000 
			step = 5 
			value = <trick_time> 
			pad_left_script = goal_update_trick_time 
			pad_right_script = goal_update_trick_time 
		} 
		theme_menu_add_number_item { 
			text = "Time to stop adding tricks" 
			id = goal_time_to_stop_adding_tricks 
			min = 5 
			max = <time_limit> 
			step = 5 
			value = <time_to_stop_adding_tricks> 
			pad_left_script = goal_update_time_to_stop_adding_tricks 
			pad_right_script = goal_update_time_to_stop_adding_tricks 
		} 
		theme_menu_add_number_item { 
			text = "Max tricks" 
			id = goal_max_tricks 
			min = 1 
			max = 15 
			step = 1 
			value = <max_tricks> 
			pad_left_script = goal_update_max_tricks 
			pad_right_script = goal_update_max_tricks 
		} 
	ENDIF 
	theme_menu_add_item { 
		text = "Done" 
		pad_choose_script = create_edit_goal_menu 
		pad_choose_params = <back_params> 
		last_menu_item = 1 
	} 
	finish_themed_sub_menu 
	create_helper_text generic_helper_text_up_down_adjust 
ENDSCRIPT

SCRIPT edit_skatetris_cancel_keyboard 
	destroy_onscreen_keyboard 
	create_edit_skatetris_menu 
ENDSCRIPT

SCRIPT count_chosen_combo_sets 
	GetArraySize cag_skatetris_key_combos 
	num_chosen_combo_sets = 0 
	IF ( <array_size> > 0 ) 
		i = 0 
		BEGIN 
			IF GoalEditor : GetKeyComboSet set_index = <i> 
				num_chosen_combo_sets = ( <num_chosen_combo_sets> + 1 ) 
			ENDIF 
			i = ( <i> + 1 ) 
		REPEAT <array_size> 
	ENDIF 
	RETURN num_chosen_combo_sets = <num_chosen_combo_sets> 
ENDSCRIPT

SCRIPT update_combo_sets_done_focusability 
	count_chosen_combo_sets 
	IF ( <num_chosen_combo_sets> > 0 ) 
		SetScreenElementProps { id = combo_sets_done child = 0 focusable } 
		FormatText ChecksumName = off_color "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
		SetScreenElementProps { id = { combo_sets_done child = 0 } rgba = <off_color> } 
	ELSE 
		SetScreenElementProps { id = combo_sets_done child = 0 not_focusable } 
		SetScreenElementProps { id = { combo_sets_done child = 0 } rgba = [ 64 , 64 , 64 , 64 ] } 
	ENDIF 
ENDSCRIPT

SCRIPT create_key_combos_menu 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	FormatText ChecksumName = title_icon "%i_trick" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	make_new_themed_sub_menu title = "SELECT KEY COMBOS" title_icon = <title_icon> 
	IF GotParam go_back_to_goal_list_menu 
		back_params = { go_back_to_goal_list_menu } 
	ELSE 
		back_params = { } 
	ENDIF 
	SetScreenElementProps { 
		id = sub_menu 
		event_handlers = [ { pad_back create_edit_goal_menu params = <back_params> } 
			{ pad_back generic_menu_pad_back_sound } 
		] 
		replace_handlers 
	} 
	GetArraySize cag_skatetris_key_combos 
	IF ( <array_size> > 0 ) 
		i = 0 
		BEGIN 
			params = { } 
			IF ( <i> = 0 ) 
				params = { first_item } 
			ENDIF 
			IF GoalEditor : GetKeyComboSet set_index = <i> 
				value = 1 
			ELSE 
				value = 0 
			ENDIF 
			FormatText ChecksumName = id "check%d" d = <i> 
			theme_menu_add_checkbox_item { 
				value = <value> 
				id = <id> 
				text = ( cag_skatetris_key_combos [ <i> ] . text ) 
				pad_choose_script = toggle_keycombo_set_on_off 
				pad_choose_params = { set_index = <i> } 
				<params> 
			} 
			i = ( <i> + 1 ) 
		REPEAT <array_size> 
	ENDIF 
	theme_menu_add_item { 
		text = "Done" 
		id = combo_sets_done 
		pad_choose_script = create_edit_skatetris_menu 
		pad_choose_params = <back_params> 
		last_menu_item = 1 
	} 
	update_combo_sets_done_focusability 
	finish_themed_sub_menu 
ENDSCRIPT

SCRIPT toggle_keycombo_set_on_off 
	IF GoalEditor : GetKeyComboSet set_index = <set_index> 
		GoalEditor : RemoveKeyComboSet set_index = <set_index> 
		theme_set_checkbox value = 0 
	ELSE 
		GoalEditor : AddKeyComboSet set_index = <set_index> 
		theme_set_checkbox value = 1 
	ENDIF 
	update_combo_sets_done_focusability 
ENDSCRIPT

SCRIPT remove_key_combo_set 
	GoalEditor : RemoveKeyComboSet set_index = <set_index> 
	IF GotParam go_back_to_goal_list_menu 
		goto create_key_combos_menu params = { go_back_to_goal_list_menu } 
	ELSE 
		goto create_key_combos_menu 
	ENDIF 
ENDSCRIPT

SCRIPT goal_update_spin 
	GoalEditor : SetGoalSpecificParams spin = <value> 
	IF ( <value> = 0 ) 
		SetScreenElementProps { id = { goal_spin child = 3 } text = "Off" } 
		goal_spin : theme_menu_update_number_item_right_arrow 
	ENDIF 
ENDSCRIPT

SCRIPT change_single_combo 
	IF GotParam on 
		GoalEditor : SetGoalSpecificParams single_combo 
	ELSE 
		GoalEditor : RemoveGoalSpecificFlag single_combo 
	ENDIF 
	create_edit_skatetris_menu 
	IF NOT GotParam on 
		GoalEditor : GetCurrentEditedGoalInfo 
		validate_max_tricks max_tricks = <max_tricks> combo_size = <combo_size> 
	ENDIF 
ENDSCRIPT

SCRIPT goal_update_combo_size 
	GoalEditor : SetGoalSpecificParams combo_size = <value> 
	GoalEditor : GetCurrentEditedGoalInfo 
	IF NOT GotParam single_combo 
		IF GotParam max_tricks 
			validate_max_tricks max_tricks = <max_tricks> combo_size = <combo_size> 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT validate_max_tricks 
	RemoveParameter update_required 
	BEGIN 
		blocks = ( <max_tricks> / <combo_size> ) 
		IF ( <blocks> -1 + <blocks> * <combo_size> < 17 ) 
			BREAK 
		ENDIF 
		update_required = 1 
		max_tricks = ( <max_tricks> -1 ) 
	REPEAT 20 
	IF GotParam update_required 
		GoalEditor : SetGoalSpecificParams max_tricks = <max_tricks> 
		FireEvent target = goal_max_tricks type = pad_left data = { value = <max_tricks> NoStep } 
	ENDIF 
ENDSCRIPT

SCRIPT goal_update_tricktris_block_size 
	GoalEditor : SetGoalSpecificParams tricktris_block_size = <value> 
ENDSCRIPT

SCRIPT goal_update_tricktris_total_to_win 
	GoalEditor : SetGoalSpecificParams tricktris_total_to_win = <value> 
ENDSCRIPT

SCRIPT goal_update_acceleration_interval 
	GoalEditor : SetGoalSpecificParams acceleration_interval = <value> 
ENDSCRIPT

SCRIPT goal_update_acceleration_percent 
	GoalEditor : SetGoalSpecificParams acceleration_percent = ( <value> / 100.00000000000 ) 
ENDSCRIPT

SCRIPT goal_update_trick_time 
	GoalEditor : SetGoalSpecificParams trick_time = <value> 
ENDSCRIPT

SCRIPT goal_update_time_to_stop_adding_tricks 
	GoalEditor : SetGoalSpecificParams time_to_stop_adding_tricks = <value> 
ENDSCRIPT

SCRIPT goal_update_max_tricks 
	GoalEditor : SetGoalSpecificParams max_tricks = <value> 
	GoalEditor : GetCurrentEditedGoalInfo 
	IF GotParam combo_size 
		FireEvent target = goal_combo_size type = pad_left data = { max = <value> NoStep } 
		IF ( <combo_size> > <value> ) 
			combo_size = <value> 
			GoalEditor : SetGoalSpecificParams combo_size = <combo_size> 
			FireEvent target = goal_combo_size type = pad_left data = { value = <combo_size> NoStep } 
		ENDIF 
		RemoveParameter update_required 
		BEGIN 
			blocks = ( <max_tricks> / <combo_size> ) 
			IF ( <blocks> -1 + <blocks> * <combo_size> < 17 ) 
				BREAK 
			ENDIF 
			update_required = 1 
			combo_size = ( <combo_size> + 1 ) 
		REPEAT 20 
		IF GotParam update_required 
			GoalEditor : SetGoalSpecificParams combo_size = <combo_size> 
			FireEvent target = goal_combo_size type = pad_left data = { value = <combo_size> NoStep } 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT input_required_trick_name 
	IF ScreenElementExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	GoalEditor : GetCurrentEditedGoalInfo 
	create_onscreen_keyboard { allow_cancel 
		max_length = 50 
		keyboard_cancel_script = cag_cancel_keyboard 
		keyboard_done_script = set_required_trick_name 
		keyboard_title = "REQUIRED TRICK" 
		text = <required_trick_name> 
	} 
ENDSCRIPT

SCRIPT set_required_trick_name 
	GetTextElementString id = keyboard_current_string 
	GoalEditor : SetGoalSpecificParams required_trick_name = <string> 
	cag_cancel_keyboard 
ENDSCRIPT

SCRIPT test_goal 
	edit_goal_menu_exit 
	UnpauseGame 
	skater : Vibrate off 
	GoalManager_ShowPoints 
	GoalManager_ShowGoalPoints 
	GoalEditor : GetCurrentEditedGoalId 
	GoalManager_EditGoal name = <goal_id> params = { testing_goal } 
	GoalManager_ActivateGoal name = <goal_id> 
ENDSCRIPT

SCRIPT edit_goal 
	edit_goal_menu_exit DoNotSwitchEditorState NoDeactivate 
	destroy_goal_panel_messages 
	PauseGame 
	delete_goal_editor_marker_objects 
	SetActiveCamera id = GoalEditor 
	set_in_create_a_goal 
	pause_trick_text 
	end_current_goal_run 
	IF LevelIs Load_Sk5Ed 
		SwitchOffRailEditor 
		SetParkEditorPauseMode pause 
	ENDIF 
	PauseSkater 0 
	HideSkaterAndMiscSkaterEffects 
	Debounce X time = 0.20000000298 clear = 1 
	Debounce Triangle time = 0.20000000298 clear = 1 
	GoalEditor : unpause 
	GoalEditor : Unsuspend 
	GoalEditor : Unhide 
	Change goal_editor_placement_mode = 1 
	SetScreenElementProps { 
		id = root_window 
		replace_handlers 
		event_handlers = 
		[ 
			{ 
				pad_start 
				edit_goal_pad_start 
			} 
		] 
	} 
	IF ObjectExists id = goal_start_dialog 
		DestroyScreenElement id = goal_start_dialog 
	ENDIF 
	GoalEditor : GetCurrentEditedGoalId 
	IF GoalManager_GoalExists name = <goal_id> 
		GoalManager_RemoveGoal name = <goal_id> 
	ENDIF 
	GoalEditor : EditGoal 
	SetActiveCamera id = GoalEditor 
	create_cag_helper_text PedPosition 
ENDSCRIPT

SCRIPT name_goal 
	IF ScreenElementExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	GoalEditor : GetCurrentEditedGoalInfo 
	create_onscreen_keyboard { allow_cancel 
		max_length = 16 
		min_length = 1 
		keyboard_cancel_script = cag_cancel_keyboard 
		keyboard_done_script = set_cag_goal_name 
		keyboard_title = "GOAL NAME" 
		text = <view_goals_text> 
	} 
ENDSCRIPT

SCRIPT cag_cancel_keyboard 
	destroy_onscreen_keyboard 
	create_edit_goal_menu 
ENDSCRIPT

SCRIPT set_cag_goal_name 
	GetTextElementString id = keyboard_current_string 
	GoalEditor : SetEditorGoalName name = <string> 
	cag_cancel_keyboard 
ENDSCRIPT

SCRIPT name_goal_ped 
	IF ScreenElementExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	GoalEditor : GetCurrentEditedGoalInfo 
	create_onscreen_keyboard { allow_cancel 
		max_length = 16 
		keyboard_cancel_script = cag_cancel_keyboard 
		keyboard_done_script = set_cag_ped_name 
		keyboard_title = "PED NAME" 
		text = <ped_name> 
	} 
ENDSCRIPT

SCRIPT set_cag_ped_name 
	GetTextElementString id = keyboard_current_string 
	GoalEditor : SetEditorPedName name = <string> 
	cag_cancel_keyboard 
ENDSCRIPT

SCRIPT set_goal_text 
	IF ScreenElementExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	GoalEditor : GetCurrentEditedGoalInfo 
	create_onscreen_keyboard { allow_cancel 
		text_block 
		max_length = 99 
		keyboard_cancel_script = cag_cancel_keyboard 
		keyboard_done_script = set_cag_goal_text 
		keyboard_title = "GOAL TEXT" 
		text = <goal_description> 
	} 
ENDSCRIPT

SCRIPT set_cag_goal_text 
	GetTextElementString id = keyboard_current_string 
	GoalEditor : SetEditorGoalDescription text = <string> 
	cag_cancel_keyboard 
ENDSCRIPT

SCRIPT goal_update_score 
	GoalEditor : SetGoalScore <value> 
ENDSCRIPT

SCRIPT goal_update_time_limit 
	GoalEditor : SetGoalTimeLimit <value> 
ENDSCRIPT

SCRIPT edit_goal_win_message 
	IF ScreenElementExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	GoalEditor : GetCurrentEditedGoalInfo 
	create_onscreen_keyboard { allow_cancel 
		text_block 
		max_length = 99 
		keyboard_cancel_script = cag_cancel_keyboard 
		keyboard_done_script = set_goal_win_message 
		keyboard_title = "WIN MESSAGE" 
		text = <win_message> 
	} 
ENDSCRIPT

SCRIPT set_goal_win_message 
	GetTextElementString id = keyboard_current_string 
	GoalEditor : SetEditorGoalWinMessage text = <string> 
	cag_cancel_keyboard 
ENDSCRIPT

SCRIPT delete_goal 
	edit_goal_menu_exit no_exit_pause 
	generic_menu_pad_choose_sound 
	set_in_create_a_goal 
	IF ScreenElementExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	GoalEditor : GetCurrentEditedGoalInfo 
	FormatText TextName = text "Are you sure you want to delete the goal %s ?" s = <view_goals_text> 
	create_dialog_box { title = "Delete Goal" 
		text = <text> 
		pos = PAIR(310.00000000000, 183.00000000000) 
		just = [ center center ] 
		text_rgba = [ 88 105 112 128 ] 
		buttons = 
		[ 
			{ font = small text = "No" pad_choose_script = delete_created_goal_dont_accept } 
			{ font = small text = "Yes" pad_choose_script = delete_created_goal_accept } 
		] 
	} 
ENDSCRIPT

SCRIPT delete_created_goal_accept 
	Change check_for_unplugged_controllers = 0 
	GoalEditor : RemovedCreatedGoal 
	create_existing_goals_menu 
	Change check_for_unplugged_controllers = 1 
ENDSCRIPT

SCRIPT delete_created_goal_dont_accept 
	dialog_box_exit 
	create_edit_goal_menu 
ENDSCRIPT

SCRIPT edit_goal_menu_exit 
	reset_in_create_a_goal 
	skater : Vibrate off 
	IF GotParam no_exit_pause 
	ELSE 
		IF GotParam DoNotSwitchEditorState 
			my_exit_pause_menu DoNotSwitchEditorState 
		ELSE 
			my_exit_pause_menu 
		ENDIF 
		end_current_goal_run 
	ENDIF 
	IF NOT GotParam NoDeactivate 
		DeactivateGoalEditor 
	ENDIF 
	GoalEditor : GetCurrentEditedGoalInfo 
	IF GoalManager_GoalExists name = <goal_id> 
		GoalManager_RemoveGoal name = <goal_id> 
	ENDIF 
	IF NOT GoalEditor : GoalHasAllPositionsSet 
		GoalEditor : RemovedCreatedGoal 
		DontAddTheGoal = 1 
	ENDIF 
	IF ( <goal_type> = gap ) 
		IF NOT GotParam Gaps 
			DontAddTheGoal = 1 
		ENDIF 
	ENDIF 
	IF NOT GotParam DontAddTheGoal 
		GoalEditor : AddEditedGoalToGoalManager MarkUnbeaten 
	ENDIF 
	IF IsAlive name = <pro_name> 
		<pro_name> : Die 
	ENDIF 
	IF NOT GotParam DontAddTheGoal 
		GoalEditor : WriteEditedGoalNodePositions 
		GoalManager_InitializeGoal name = <goal_id> 
	ENDIF 
	IF GotParam no_exit_pause 
		PauseSkater 0 
		UnpauseGame 
		PauseGame 
	ENDIF 
ENDSCRIPT

SCRIPT delete_goal_editor_marker_objects 
	i = 0 
	BEGIN 
		FormatText ChecksumName = object "GoalEditorMarkerObject%d" d = <i> 
		IF ObjectExists id = <object> 
			<object> : Die 
		ENDIF 
		i = ( <i> + 1 ) 
	REPEAT 7 
ENDSCRIPT

SCRIPT DeactivateGoalEditor 
	GoalEditor : Hide 
	GoalEditor : Suspend 
	IF ObjectExists id = helper_text_anchor 
		DestroyScreenElement id = helper_text_anchor 
	ENDIF 
	delete_goal_editor_marker_objects 
	IF CustomParkMode editing 
		SetActiveCamera id = parked_cam 
	ELSE 
		SetActiveCamera id = skatercam0 
		UnPauseSkater 0 
		skater : AddSkaterToWorld 
	ENDIF 
ENDSCRIPT

SCRIPT goal_editor_finished_placing_letters 
	Change goal_editor_placement_mode = 0 
	GoalEditor : Hide 
	GoalEditor : Suspend 
	create_edit_goal_menu 
ENDSCRIPT


