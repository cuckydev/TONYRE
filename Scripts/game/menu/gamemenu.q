
ALWAYSPLAYMUSIC = 1 
HIDEHUD = 0 
DEVKIT_LEVELS = 1 
meta_button_map_ps2 = [ 
	3 
	0 
	0 
	1 
	2 
	2 
	1 
	1 
	2 
	1 
	14 
	15 
	0 
	1 
	2 
	16 
	17 
	2 
	1 
	17 
	17 
	17 
	18 
	16 
	16 
	16 
	0 
	0 
	0 
	0 
	0 
	0 
] 
meta_button_map_gamecube = [ 
	3 
	1 
	0 
	1 
	2 
	2 
	1 
	1 
	2 
	0 
	14 
	15 
	1 
	2 
	2 
	14 
	15 
	0 
	0 
	9 
	15 
	18 
	9 
	2 
	14 
	14 
	0 
	0 
	0 
	0 
	0 
	0 
] 
meta_button_map_xbox = [ 
	3 
	2 
	0 
	1 
	2 
	2 
	1 
	1 
	0 
	1 
	14 
	15 
	2 
	1 
	1 
	14 
	15 
	0 
	0 
	17 
	15 
	18 
	17 
	16 
	14 
	14 
	0 
	0 
	0 
	0 
	0 
	0 
] 
smallfont_colors = [ 
	[ 128 128 128 100 ] 
	[ 102 26 8 100 ] 
	[ 17 64 116 100 ] 
	[ 9 107 36 100 ] 
	[ 123 99 3 100 ] 
	[ 0 128 128 100 ] 
	[ 128 0 128 100 ] 
	[ 30 50 80 100 ] 
	[ 88 105 112 128 ] 
] 
dialogfont_colors = [ 
	[ 88 105 112 128 ] 
	[ 102 26 8 100 ] 
	[ 17 64 116 100 ] 
	[ 9 107 36 100 ] 
	[ 123 99 3 100 ] 
	[ 127 102 0 100 ] 
	[ 100 100 128 100 ] 
] 
SCRIPT new_screen_element_test 
	PushMemProfile "Fonts and Bitmaps" 
	ScreenElementSystemInit 
	LoadLevelPreFile "panelsprites.pre" 
	FormatText ChecksumName = font_colors "%i_FONT_COLORS" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	LoadFont "testtitle" char_spacing = -4.50000000000 space_spacing = 13 
	LoadFont "newtrickfont" char_spacing = -1 space_spacing = 14 color_tab = newtrickfont_colors 
	LoadFont "small" char_spacing = -3.09999990463 space_spacing = 12 color_tab = <font_colors> 
	LoadFont "newtimerfont" char_spacing = 0.50000000000 
	LoadFont "dialog" char_spacing = -3.00000000000 space_spacing = 12 color_tab = <font_colors> 
	LoadFont buttons_font 
	load_textures_to_main_memory 
	UnLoadPreFile "panelsprites.pre" dont_assert 
	setup_main_button_event_mappings 
	SetScreenElementProps { 
		id = root_window 
		tags = { menu_state = off } 
	} 
	FireEvent type = focus target = root_window 
	PopMemProfile 
	load_theme_textures_to_main_memory 
	create_panel_stuff 
ENDSCRIPT

SCRIPT handle_pause_continue 
	IF GotParam pause_controller 
		IF NOT ( <pause_controller> = <device_num> ) 
			RETURN 
		ENDIF 
	ENDIF 
	exit_pause_menu 
ENDSCRIPT

is_changing_levels = 0 
SCRIPT handle_start_pressed 
	root_window : GetTags 
	IF ( is_changing_levels = 1 ) 
		RETURN 
	ENDIF 
	IF LevelIs load_skateshop 
		RETURN 
	ENDIF 
	IF ChecksumEquals a = <menu_state> b = on 
		IF GotParam pause_controller 
			IF NOT ( <pause_controller> = -1 ) 
				IF NOT ( <device_num> = <pause_controller> ) 
					RETURN 
				ENDIF 
			ENDIF 
		ENDIF 
		IF NOT InNetGame 
			UnpauseGame 
		ENDIF 
		exit_pause_menu 
		change inside_pause = 0 
	ENDIF 
	IF ChecksumEquals a = <menu_state> b = off 
		change viewer_buttons_enabled = 0 
		IF NOT InMultiPlayerGame 
			IF NOT ControllerBoundToSkater controller = <device_num> skater = 0 
				RETURN 
			ENDIF 
		ELSE 
			IF InSplitScreenGame 
				IF NOT ControllerBoundToSkater controller = <device_num> skater = 0 
					IF NOT ControllerBoundToSkater controller = <device_num> skater = 1 
						RETURN 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
		SetTags pause_controller = <device_num> 
		possibly_remove_temp_special_trick 
		KillSpawnedScript name = goal_accept_trigger 
		IF NOT InNetGame 
			GetSkaterId 
			IF GetSkaterCamAnimParams skater = <objId> 
				IF ( <allow_pause> = 0 ) 
					RETURN 
				ENDIF 
			ENDIF 
			printf "-------------------- PAUSING GAME ----------------------" 
			PauseGame 
			GoalManager_PauseAllGoals 
			wait 1 gameframe 
			pause_trick_text 
			pause_balance_meter 
			pause_run_timer 
			kill_blur 
			IF ObjectExists id = speech_box_anchor 
				DoScreenElementMorph id = speech_box_anchor scale = 0 
			ENDIF 
			IF ScreenElementExists id = goal_start_dialog 
				DestroyScreenElement id = goal_start_dialog 
			ENDIF 
			IF ObjectExists id = ped_speech_dialog 
				DestroyScreenElement id = ped_speech_dialog 
			ENDIF 
			IF ObjectExists id = goal_retry_anchor 
				DestroyScreenElement id = goal_retry_anchor 
			ENDIF 
			hide_goal_panel_messages 
		ENDIF 
		create_pause_menu device_num = <device_num> 
	ENDIF 
ENDSCRIPT

SCRIPT restore_start_key_binding 
	SetScreenElementProps { 
		id = root_window 
		event_handlers = [ { pad_start handle_start_pressed } ] 
		replace_handlers 
	} 
ENDSCRIPT

SCRIPT kill_start_key_binding 
	SetScreenElementProps { 
		id = root_window 
		event_handlers = [ { pad_start null_script } ] 
		replace_handlers 
	} 
ENDSCRIPT

SCRIPT make_new_ingame_menu 
	make_new_menu <...> 
ENDSCRIPT

SCRIPT make_new_menu { menu_title = "" 
		padding_scale = 1.14999997616 
		internal_scale = 1 
		pos = PAIR(230.00000000000, 109.00000000000) 
		dims = PAIR(200.00000000000, 100.00000000000) 
		internal_just = [ left top ] 
		parent = root_window 
		just = [ center center ] 
		scrolling_menu_offset = PAIR(0.00000000000, 10.00000000000) 
	} 
	<pos> = ( <pos> + PAIR(0.00000000000, 12.00000000000) ) 
	SetScreenElementLock id = <parent> off 
	CreateScreenElement { 
		type = ContainerElement 
		parent = <parent> 
		id = <menu_id> 
		font = small 
		pos = PAIR(320.00000000000, 240.00000000000) 
		scale = 1 
		dims = PAIR(640.00000000000, 480.00000000000) 
		focusable_child = <vmenu_id> 
	} 
	SWITCH <type> 
		CASE VScrollingMenu 
			IF GotParam scrolling_menu_title_id 
				CreateScreenElement { 
					type = TextElement 
					parent = <menu_id> 
					id = <scrolling_menu_title_id> 
					font = testtitle 
					text = <menu_title> 
					scale = 1.39999997616 
					pos = <pos> 
					just = [ left top ] 
					rgba = MENU_TITLE_COLOR 
					not_focusable 
				} 
				GetStackedScreenElementPos Y id = <id> offset = <scrolling_menu_offset> 
			ENDIF 
			CreateScreenElement { 
				type = VScrollingMenu 
				parent = <menu_id> 
				id = <scrolling_menu_id> 
				pos = <pos> 
				just = [ left top ] 
				dims = <dims> 
				scale = <scale> 
				internal_just = [ left top ] 
				num_items_to_show = <num_items_to_show> 
			} 
			<vscrolling_menu_id> = <id> 
			CreateScreenElement { 
				type = VMenu 
				parent = <vscrolling_menu_id> 
				id = <vmenu_id> 
				dims = <dims> 
				dims = <dims> 
				font = small 
				just = [ left top ] 
				pos = PAIR(0.00000000000, 0.00000000000) 
				scale = <scale> 
				regular_space_amount = <regular_space_amount> 
				padding_scale = <padding_scale> 
				internal_scale = <internal_scale> 
				internal_just = <internal_just> 
				<dont_allow_wrap> 
				event_handlers = [ { pad_up generic_menu_up_or_down_sound params = { up } } 
					{ pad_down generic_menu_up_or_down_sound params = { down } } 
				] 
			} 
		DEFAULT 
			CreateScreenElement { 
				type = VMenu 
				parent = <menu_id> 
				id = <vmenu_id> 
				font = small 
				just = [ left top ] 
				pos = <pos> 
				padding_scale = <padding_scale> 
				internal_scale = <internal_scale> 
				internal_just = <internal_just> 
				<dont_allow_wrap> 
				event_handlers = [ { pad_up generic_menu_up_or_down_sound params = { up } } 
					{ pad_down generic_menu_up_or_down_sound params = { down } } 
				] 
			} 
			IF NOT GotParam no_menu_title 
				CreateScreenElement { 
					type = TextElement 
					parent = <vmenu_id> 
					font = testtitle 
					text = <menu_title> 
					scale = 1.39999997616 
					rgba = MENU_TITLE_COLOR 
					not_focusable 
				} 
			ENDIF 
	ENDSWITCH 
	IF NOT GotParam no_alias 
		AssignAlias id = <menu_id> alias = current_menu_anchor 
	ENDIF 
	AssignAlias id = <vmenu_id> alias = current_menu 
	IF GotParam helper_text 
		create_helper_text <helper_text> 
	ENDIF 
ENDSCRIPT

SCRIPT make_new_sprite_menu menu_id = main_menu_anchor vmenu_id = main_menu pad_back_script = exit_pause_menu pos = PAIR(320.00000000000, 240.00000000000) parent = root_window 
	SetScreenElementLock id = root_window off 
	CreateScreenElement { 
		type = ContainerElement 
		parent = <parent> 
		id = <menu_id> 
		font = small 
		pos = <pos> 
		just = [ center center ] 
		scale = 0 
		dims = PAIR(640.00000000000, 480.00000000000) 
		focusable_child = <vmenu_id> 
	} 
	IF GotParam menu_title 
		CreateScreenElement { 
			type = SpriteElement 
			parent = <menu_id> 
			texture = <menu_title> 
			pos = PAIR(330.00000000000, 60.00000000000) 
			just = [ left top ] 
			rgba = [ 128 128 128 70 ] 
		} 
	ENDIF 
	CreateScreenElement { 
		type = VMenu 
		parent = <menu_id> 
		id = <vmenu_id> 
		font = small 
		just = [ left top ] 
		pos = PAIR(120.00000000000, 80.00000000000) 
		internal_just = [ right top ] 
		event_handlers = [ { pad_back generic_menu_pad_back_sound } 
			{ pad_back <pad_back_script> params = <pad_back_params> } 
			{ pad_up generic_menu_up_or_down_sound params = { up } } 
			{ pad_down generic_menu_up_or_down_sound params = { down } } 
		] 
	} 
	AssignAlias id = <menu_id> alias = current_menu_anchor 
	AssignAlias id = <vmenu_id> alias = current_menu 
ENDSCRIPT

SCRIPT make_new_pause_menu menu_id = main_menu_anchor vmenu_id = main_menu pad_back_script = exit_pause_menu pos = PAIR(320.00000000000, 240.00000000000) parent = root_window 
	SetScreenElementLock id = root_window off 
	CreateScreenElement { 
		type = ContainerElement 
		parent = <parent> 
		id = pause_menu_parts_anchor 
		dims = PAIR(640.00000000000, 480.00000000000) 
		pos = PAIR(320.00000000000, 240.00000000000) 
	} 
	CreateScreenElement { 
		type = ContainerElement 
		parent = pause_menu_parts_anchor 
		id = <menu_id> 
		font = small 
		pos = <pos> 
		just = [ center center ] 
		scale = 0 
		dims = PAIR(640.00000000000, 480.00000000000) 
		focusable_child = <vmenu_id> 
	} 
	IF GotParam menu_title 
		CreateScreenElement { 
			type = SpriteElement 
			parent = <menu_id> 
			texture = <menu_title> 
			pos = PAIR(330.00000000000, 60.00000000000) 
			just = [ left top ] 
			rgba = [ 128 128 128 70 ] 
		} 
	ENDIF 
	CreateScreenElement { 
		type = VMenu 
		parent = <menu_id> 
		id = <vmenu_id> 
		font = small 
		just = [ left top ] 
		pos = PAIR(120.00000000000, 80.00000000000) 
		internal_just = [ right top ] 
		event_handlers = [ { pad_back generic_pause_exit_sound } 
			{ pad_back <pad_back_script> params = <pad_back_params> } 
			{ pad_up generic_menu_up_or_down_sound params = { up } } 
			{ pad_down generic_menu_up_or_down_sound params = { down } } 
		] 
	} 
	AssignAlias id = pause_menu_parts_anchor alias = current_menu_anchor 
	AssignAlias id = <vmenu_id> alias = current_menu 
ENDSCRIPT

SCRIPT set_menu_bg parent = current_menu_anchor 
	<number_of_slices> = 7 
	<slice_height> = 32 
	<slice_scale> = PAIR(1.00000000000, 1.25000000000) 
	<slice_height> = ( ( PAIR(0.00000000000, 1.00000000000) . <slice_scale> ) * <slice_height> ) 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <parent> 
		texture = paused 
		pos = PAIR(153.00000000000, 69.00000000000) 
		just = [ left top ] 
		rgba = [ 118 118 128 120 ] 
	} 
	GetStackedScreenElementPos X id = <id> offset = PAIR(-8.00000000000, 0.00000000000) 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <parent> 
		texture = SlicePause_1 
		pos = <pos> 
		just = [ left top ] 
		scale = <paused_bar_scale> 
	} 
	IF ObjectExists id = current_menu 
		SetScreenElementLock id = current_menu on 
		GetScreenElementDims id = current_menu 
		GetScreenElementPosition id = <id> 
		<top_of_first_slice> = ( <ScreenElementPos> . PAIR(0.00000000000, 1.00000000000) ) 
		GetScreenElementPosition id = current_menu 
		<top_of_menu> = ( <ScreenElementPos> . PAIR(0.00000000000, 1.00000000000) ) 
		<height> = ( <height> - <slice_height> ) 
		<height> = ( <height> + ( <top_of_menu> - <top_of_first_slice> ) ) 
		<draw_all> = 0 
	ELSE 
		<height> = 400 
		<draw_all> = 1 
	ENDIF 
	<last_slice> = 1 
	BEGIN 
		IF ( <draw_all> = 0 ) 
			IF ( ( <height> < 0 ) | ( <last_slice> = <number_of_slices> ) ) 
				BREAK 
			ENDIF 
		ELSE 
			IF ( <last_slice> = <number_of_slices> ) 
				BREAK 
			ENDIF 
		ENDIF 
		<last_slice> = ( <last_slice> + 1 ) 
		FormatText ChecksumName = texture_name "SlicePause_%i" i = <last_slice> 
		GetStackedScreenElementPos Y id = <id> 
		CreateScreenElement { 
			type = SpriteElement 
			parent = <parent> 
			texture = <texture_name> 
			pos = <pos> 
			just = [ left top ] 
			scale = <slice_scale> 
		} 
		<height> = ( <height> - <slice_height> ) 
	REPEAT 
ENDSCRIPT

SCRIPT set_sub_bg { parent = current_menu_anchor 
		pos = PAIR(326.00000000000, 115.00000000000) 
		scale = PAIR(1.16999995708, 1.10000002384) 
		just = [ center top ] 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <parent> 
		texture = options_bg 
		draw_behind_parent 
		pos = <pos> 
		scale = <scale> 
		just = <just> 
		rgba = [ 128 128 128 128 ] 
		z_priority = 1 
	} 
ENDSCRIPT

SCRIPT set_sub_bg_goal goal_mid_scale = PAIR(14.80000019073, 1.33000004292) pos = PAIR(250.00000000000, 23.00000000000) goal_end_scale = PAIR(1.00000000000, 1.33000004292) 
	CreateScreenElement { 
		type = SpriteElement 
		parent = current_menu_anchor 
		texture = options_bg 
		draw_behind_parent 
		pos = <pos> 
		scale = PAIR(1.10000002384, 1.00000000000) 
		just = [ center top ] 
		rgba = [ 128 128 128 128 ] 
		z_priority = 0 
	} 
	GetStackedScreenElementPos Y id = <id> offset = PAIR(5.00000000000, -36.00000000000) 
	CreateScreenElement { 
		type = SpriteElement 
		parent = current_menu_anchor 
		texture = goal_left 
		draw_behind_parent 
		pos = <pos> 
		scale = <goal_end_scale> 
		just = [ left top ] 
		rgba = [ 56 60 71 118 ] 
		z_priority = 0 
	} 
	GetStackedScreenElementPos X id = <id> 
	CreateScreenElement { 
		type = SpriteElement 
		parent = current_menu_anchor 
		texture = goal_mid 
		draw_behind_parent 
		pos = <pos> 
		scale = <goal_mid_scale> 
		just = [ left top ] 
		rgba = [ 56 60 71 118 ] 
		z_priority = 0 
	} 
	GetStackedScreenElementPos X id = <id> 
	CreateScreenElement { 
		type = SpriteElement 
		parent = current_menu_anchor 
		texture = goal_right 
		draw_behind_parent 
		pos = <pos> 
		scale = <goal_end_scale> 
		just = [ left top ] 
		rgba = [ 56 60 71 118 ] 
		z_priority = 0 
	} 
ENDSCRIPT

SCRIPT create_icon pos = PAIR(176.00000000000, 115.00000000000) parent = current_menu_anchor scale = PAIR(0.94999998808, 0.94999998808) z_priority = 5 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <parent> 
		id = <id> 
		pos = <pos> 
		scale = <scale> 
		just = [ left top ] 
		rgba = icon_color 
		z_priority = <z_priority> 
		texture = <texture> 
	} 
ENDSCRIPT

SCRIPT make_text_sprite pos = PAIR(215.00000000000, 15.00000000000) just = [ center center ] scale = 0.44999998808 
	IF GotParam id 
		CreateScreenElement { 
			type = SpriteElement 
			parent = <parent> 
			id = <id> 
			texture = <texture> 
			pos = <pos> 
			rgba = [ 0 0 0 0 ] 
			just = <just> 
			scale = <scale> 
			z_priority = 2 
		} 
	ELSE 
		CreateScreenElement { 
			type = SpriteElement 
			parent = <parent> 
			texture = <texture> 
			pos = <pos> 
			rgba = [ 0 0 0 0 ] 
			just = <just> 
			scale = <scale> 
			z_priority = 2 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT create_career_startup_menu 
	skater : PausePhysics 
	skater : RemoveSkaterFromWorld 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	unhide_root_window 
	GoalManager_HideGoalPoints 
	GoalManager_HidePoints 
	pause_menu_gradient on 
	PauseMusicAndStreams 1 
	wait 1 seconds 
	hide_dumb_peds 
	make_new_menu { 
		pos = PAIR(120.00000000000, 150.00000000000) 
		internal_just = [ center center ] 
		menu_id = startup_menu 
		vmenu_id = startup_vmenu 
		menu_title = "" 
	} 
	build_top_and_bottom_blocks scale = PAIR(1.20000004768, 1.00000000000) 
	story_text = "Continue Story" 
	pos1 = PAIR(270.00000000000, 205.00000000000) 
	pos2 = PAIR(395.00000000000, 205.00000000000) 
	FormatText ChecksumName = bracket_texture "%i_sub_frame" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	CreateScreenElement { 
		type = SpriteElement 
		parent = current_menu_anchor 
		id = left_bracket 
		texture = <bracket_texture> 
		pos = <pos1> 
		scale = PAIR(1.00000000000, 1.00000000000) 
		z_priority = 1 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = current_menu_anchor 
		id = right_bracket 
		texture = <bracket_texture> 
		pos = <pos2> 
		scale = PAIR(1.00000000000, 1.00000000000) 
		z_priority = 1 
		rot_angle = 180 
	} 
	create_helper_text generic_helper_text_no_back 
	kill_start_key_binding 
	make_main_menu_item { text = <story_text> 
		pad_choose_script = exit_career_startup_menu 
		pad_choose_params = { } 
		just = [ center center ] 
		mark_first_input 
	} 
	make_main_menu_item { text = "Main Menu" 
		pad_choose_script = exit_career_startup_menu_to_mainmenu 
		pad_choose_params = { } 
		just = [ center center ] 
	} 
	FireEvent type = focus target = current_menu_anchor 
ENDSCRIPT

SCRIPT hide_dumb_peds 
	<index> = 0 
	GetCurrentLevel 
	SWITCH <level> 
		CASE load_nj 
			<index> = 0 
		CASE load_ny 
			<index> = 1 
		CASE load_fl 
			<index> = 2 
		CASE load_sd 
			<index> = 3 
		CASE load_hi 
			<index> = 4 
		CASE load_vc 
			<index> = 5 
		CASE load_sj 
			<index> = 6 
		CASE load_ru 
			<index> = 7 
		CASE load_se 
			<index> = 8 
		DEFAULT 
			RETURN 
	ENDSWITCH 
	<array> = ( LEVEL_PEDS_HIDE [ <index> ] ) 
	GetArraySize <array> 
	IF ( <array_size> > 0 ) 
		<index> = 0 
		BEGIN 
			<id> = ( <array> [ <index> ] ) 
			IF GotParam unhide 
				IF ObjectExists id = <id> 
					IF isAlive name = <id> 
						<id> : Ped_StartMoving 
						<id> : unhide 
					ENDIF 
				ENDIF 
			ELSE 
				IF ObjectExists id = <id> 
					IF isAlive name = <id> 
						<id> : Ped_StopMoving 
						<id> : hide 
					ENDIF 
				ENDIF 
			ENDIF 
			<index> = ( <index> + 1 ) 
		REPEAT <array_size> 
	ENDIF 
ENDSCRIPT

SCRIPT reset_show_career_startup_menu 
	wait 1 second 
	change show_career_startup_menu = 0 
ENDSCRIPT

SCRIPT exit_career_startup_menu 
	mark_first_input_received <...> 
	DestroyScreenElement id = current_menu_anchor 
	pause_menu_gradient off 
	restore_start_key_binding 
	PauseStream 0 
	PauseMusic 0 
	hide_dumb_peds unhide 
	skater : UnpausePhysics 
	skater : AddSkaterToWorld 
	GoalManager_ShowPoints 
	GoalManager_ShowGoalPoints 
	GoalManager_GetCurrentChapterAndStage 
	GetCurrentLevel 
	IF ( ( <currentchapter> = 0 ) & ( <currentstage> = 0 ) & ( <level> = load_nj ) ) 
		ShownChapterTitle 
	ENDIF 
ENDSCRIPT

SCRIPT exit_career_startup_menu_to_mainmenu 
	change_level level = load_skateshop 
ENDSCRIPT

SCRIPT hide_everything 
	DoScreenElementMorph id = root_window time = 0 scale = 0 
ENDSCRIPT

SCRIPT unhide_everything 
	DoScreenElementMorph id = root_window time = 0 scale = 1 
ENDSCRIPT

SCRIPT hide_landing_msg 
	IF ObjectExists id = perfect 
		DoScreenElementMorph id = perfect time = 0 alpha = 0 
	ENDIF 
	IF ObjectExists id = perfect2 
		DoScreenElementMorph id = perfect2 time = 0 alpha = 0 
	ENDIF 
ENDSCRIPT

SCRIPT unhide_landing_msg 
	IF ObjectExists id = perfect 
		DoScreenElementMorph id = perfect time = 0 alpha = 0.50000000000 
	ENDIF 
	IF ObjectExists id = perfect2 
		DoScreenElementMorph id = perfect2 time = 0 alpha = 0.50000000000 
	ENDIF 
ENDSCRIPT

SCRIPT hide_3d_goal_arrow 
	IF ScreenElementExists id = DesignerCreated_3DArrowPointer 
		DoScreenElementMorph id = DesignerCreated_3DArrowPointer pos = PAIR(320.00000000000, -300.00000000000) 
	ENDIF 
	IF ScreenElementExists id = race_arrow 
		DoScreenElementMorph id = race_arrow pos = PAIR(320.00000000000, -300.00000000000) 
	ENDIF 
	IF ScreenElementExists id = ctf_arrow 
		DoScreenElementMorph id = ctf_arrow pos = PAIR(320.00000000000, -300.00000000000) 
	ENDIF 
ENDSCRIPT

SCRIPT unhide_3d_goal_arrow 
	IF ScreenElementExists id = DesignerCreated_3DArrowPointer 
		DoScreenElementMorph id = DesignerCreated_3DArrowPointer pos = PAIR(320.00000000000, 70.00000000000) 
	ENDIF 
	IF ScreenElementExists id = race_arrow 
		DoScreenElementMorph id = race_arrow pos = PAIR(320.00000000000, 70.00000000000) 
	ENDIF 
	IF ScreenElementExists id = ctf_arrow 
		DoScreenElementMorph id = ctf_arrow pos = PAIR(320.00000000000, 70.00000000000) 
	ENDIF 
ENDSCRIPT

SCRIPT hide_net_scores 
	IF ObjectExists id = net_score_1 
		DoScreenElementMorph id = net_score_1 time = 0 scale = 0 
	ENDIF 
	IF ObjectExists id = net_score_2 
		DoScreenElementMorph id = net_score_2 time = 0 scale = 0 
	ENDIF 
	IF ObjectExists id = net_score_3 
		DoScreenElementMorph id = net_score_3 time = 0 scale = 0 
	ENDIF 
	IF ObjectExists id = net_score_4 
		DoScreenElementMorph id = net_score_4 time = 0 scale = 0 
	ENDIF 
	IF ObjectExists id = net_score_5 
		DoScreenElementMorph id = net_score_5 time = 0 scale = 0 
	ENDIF 
	IF ObjectExists id = net_score_6 
		DoScreenElementMorph id = net_score_6 time = 0 scale = 0 
	ENDIF 
	IF ObjectExists id = net_score_7 
		DoScreenElementMorph id = net_score_7 time = 0 scale = 0 
	ENDIF 
	IF ObjectExists id = net_score_8 
		DoScreenElementMorph id = net_score_8 time = 0 scale = 0 
	ENDIF 
ENDSCRIPT

SCRIPT unhide_net_scores 
	IF ObjectExists id = net_score_1 
		DoScreenElementMorph id = net_score_1 time = 0 scale = 0.89999997616 
	ENDIF 
	IF ObjectExists id = net_score_2 
		DoScreenElementMorph id = net_score_2 time = 0 scale = 0.89999997616 
	ENDIF 
	IF ObjectExists id = net_score_3 
		DoScreenElementMorph id = net_score_3 time = 0 scale = 0.89999997616 
	ENDIF 
	IF ObjectExists id = net_score_4 
		DoScreenElementMorph id = net_score_4 time = 0 scale = 0.89999997616 
	ENDIF 
	IF ObjectExists id = net_score_5 
		DoScreenElementMorph id = net_score_5 time = 0 scale = 0.89999997616 
	ENDIF 
	IF ObjectExists id = net_score_6 
		DoScreenElementMorph id = net_score_6 time = 0 scale = 0.89999997616 
	ENDIF 
	IF ObjectExists id = net_score_7 
		DoScreenElementMorph id = net_score_7 time = 0 scale = 0.89999997616 
	ENDIF 
	IF ObjectExists id = net_score_8 
		DoScreenElementMorph id = net_score_8 time = 0 scale = 0.89999997616 
	ENDIF 
ENDSCRIPT

SCRIPT hide_current_goal 
	IF ObjectExists id = current_goal 
		DoScreenElementMorph id = current_goal time = 0 scale = 0 
	ENDIF 
	IF ObjectExists id = mp_goal_text 
		DoScreenElementMorph id = mp_goal_text time = 0 scale = 0 
	ENDIF 
	IF ObjectExists id = sc_goal_text 
		DoScreenElementMorph id = sc_goal_text time = 0 scale = 0 
	ENDIF 
	IF ObjectExists id = Eric_score 
		DoScreenElementMorph id = Eric_score time = 0 scale = 0 
	ENDIF 
	hide_key_combo_text 
ENDSCRIPT

comp_texts = [ Eric_Text Ron_Text Johnny_Text Chicken_Text Raven_Text final_scores goal_comp_out_of_bounds_warning ] 
SCRIPT hide_comp_text 
	GetArraySize comp_texts 
	<index> = 0 
	BEGIN 
		<id> = ( comp_texts [ <index> ] ) 
		IF ObjectExists id = <id> 
			DoScreenElementMorph id = <id> time = 0 scale = 0 
		ENDIF 
		<index> = ( <index> + 1 ) 
	REPEAT <array_size> 
ENDSCRIPT

SCRIPT unhide_comp_text 
	GetArraySize comp_texts 
	<index> = 0 
	BEGIN 
		<id> = ( comp_texts [ <index> ] ) 
		IF ObjectExists id = <id> 
			DoScreenElementMorph id = <id> time = 0 scale = 1 
		ENDIF 
		<index> = ( <index> + 1 ) 
	REPEAT <array_size> 
ENDSCRIPT

SCRIPT unhide_current_goal 
	IF ObjectExists id = current_goal 
		DoScreenElementMorph id = current_goal time = 0 scale = 0.82999998331 
	ENDIF 
	IF ObjectExists id = mp_goal_text 
		DoScreenElementMorph id = mp_goal_text time = 0 scale = 0.82999998331 
	ENDIF 
	IF ObjectExists id = sc_goal_text 
		DoScreenElementMorph id = sc_goal_text time = 0 scale = 0.82999998331 
	ENDIF 
	IF ObjectExists id = Eric_score 
		DoScreenElementMorph id = Eric_score time = 0 scale = 0.82999998331 
	ENDIF 
	unhide_key_combo_text 
ENDSCRIPT

SCRIPT hide_death_msg 
	IF ObjectExists id = death_message 
		DoScreenElementMorph id = death_message time = 0 scale = 0 
	ENDIF 
ENDSCRIPT

SCRIPT unhide_death_msg 
	IF ObjectExists id = death_message 
		DoScreenElementMorph id = death_message time = 0 scale = 1 
	ENDIF 
ENDSCRIPT

SCRIPT hide_tips 
	IF ObjectExists id = skater_hint 
		DoScreenElementMorph id = skater_hint time = 0 pos = PAIR(320.00000000000, 11050.00000000000) 
	ENDIF 
ENDSCRIPT

SCRIPT unhide_tips 
	IF ObjectExists id = skater_hint 
		DoScreenElementMorph id = skater_hint time = 0 pos = PAIR(320.00000000000, 150.00000000000) 
	ENDIF 
ENDSCRIPT

SCRIPT pause_rain 
	IF IsSoundPlaying TestLight01 
		change Paused_Light_Rain = 1 
	ENDIF 
	IF IsSoundPlaying TestMedium02 
		change Paused_Heavy_Rain = 1 
	ENDIF 
ENDSCRIPT

SCRIPT unpause_rain 
	IF NOT LevelIs load_skateshop 
		IF ( Paused_Light_Rain = 1 ) 
			IF IsSoundPlaying TestLight01 
				IF NOT GotParam dont_unpause_rain_sounds 
					IF ( Inside_Light_Rain = 1 ) 
						SetSoundParams TestLight01 vol = ( LightRainVolume * 0.10000000149 ) 
					ELSE 
						SetSoundParams TestLight01 vol = LightRainVolume 
					ENDIF 
				ENDIF 
			ENDIF 
			change Paused_Light_Rain = 0 
		ENDIF 
		IF ( Paused_Heavy_Rain = 1 ) 
			IF IsSoundPlaying TestLight02 
				IF NOT GotParam dont_unpause_rain_sounds 
					IF ( Inside_Heavy_Rain = 1 ) 
						SetSoundParams TestLight02 vol = ( LightRainVolume * 0.10000000149 ) 
					ELSE 
						SetSoundParams TestLight02 vol = LightRainVolume 
					ENDIF 
				ENDIF 
			ENDIF 
			IF IsSoundPlaying TestMedium02 
				IF NOT GotParam dont_unpause_rain_sounds 
					IF ( Inside_Heavy_Rain = 1 ) 
						SetSoundParams TestMedium02 vol = ( MediumRainVolume * 0.10000000149 ) 
					ELSE 
						SetSoundParams TestMedium02 vol = MediumRainVolume 
					ENDIF 
				ENDIF 
			ENDIF 
			change Paused_Heavy_Rain = 0 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT create_pause_menu 
	dialog_box_exit 
	IF CustomParkMode editing 
		SetParkEditorPauseMode pause 
	ENDIF 
	IF NOT GotParam no_sound 
	ENDIF 
	unhide_root_window 
	IF ( inside_pause = 1 ) 
		pulse_blur 
	ENDIF 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	IF ObjectExists id = console_message_vmenu 
		DoScreenElementMorph id = console_message_vmenu time = 0 scale = 0 
	ENDIF 
	IF ObjectExists id = first_time_goal_info 
		DestroyScreenElement id = first_time_goal_info 
	ENDIF 
	IF ScreenElementExists id = cutscene_camera_hud_anchor 
		change camera_hud_is_hidden = 1 
		DoScreenElementMorph id = cutscene_camera_hud_anchor alpha = 0 
	ENDIF 
	IF ScreenElementExists id = nightvision_hud_anchor 
		change nightvision_hud_is_hidden = 1 
		DoScreenElementMorph id = nightvision_hud_anchor alpha = 0 
	ENDIF 
	GoalManager_HideGoalPoints 
	GoalManager_HidePoints 
	hide_3d_goal_arrow 
	hide_landing_msg 
	hide_chaper_intro_title 
	hide_console_window 
	goal_skate_hide_letters 
	hide_combo_letters 
	hide_net_scores 
	hide_stat_message 
	hide_comp_text 
	unhide_current_goal 
	hide_tips 
	pause_trick_text 
	hide_death_msg 
	pause_menu_gradient on 
	IF InNetGame 
		IF NOT IsObserving 
			skater : NetDisablePlayerInput 
		ENDIF 
	ELSE 
		IF CustomParkMode editing 
			parked_setup_main_menu 
			PauseMusicAndStreams 1 
			build_pause_menu_parts 
			RETURN 
		ENDIF 
		IF CustomParkMode testing 
			parked_setup_test_play_menu 
			PauseMusicAndStreams 1 
			build_pause_menu_parts 
			RETURN 
		ENDIF 
		IF InSplitScreenGame 
			create_mp_pause_menu 
			PauseMusicAndStreams 1 
			build_pause_menu_parts 
			RETURN 
		ENDIF 
	ENDIF 
	IF ( inside_pause = 0 ) 
		IF MusicIsPaused 
			change music_was_paused = 1 
		ELSE 
			change music_was_paused = 0 
		ENDIF 
	ENDIF 
	PauseMusicAndStreams 1 
	pause_rain 
	IF ( in_cat_preview_mode = 1 ) 
		create_CAT_pause_menu 
		RETURN 
	ENDIF 
	set_theme_icons 
	IF GotParam no_exit 
		make_new_pause_menu menu_id = pause_menu vmenu_id = pause_vmenu pad_back_script = nullscript pos = PAIR(320.00000000000, 540.00000000000) 
	ELSE 
		make_new_pause_menu menu_id = pause_menu vmenu_id = pause_vmenu pad_back_script = handle_start_pressed pos = PAIR(320.00000000000, 540.00000000000) 
	ENDIF 
	IF NOT GotParam no_exit 
		create_helper_text generic_helper_text 
	ELSE 
		create_helper_text generic_helper_text_no_back 
	ENDIF 
	kill_start_key_binding 
	add_music_track_text pos = PAIR(900.00000000000, 320.00000000000) 
	IF GameModeEquals is_singlesession 
		make_sprite_menu_item text = "Continue" id = menu_continue pad_choose_script = handle_pause_continue pad_choose_sound = generic_pause_exit_sound 
		make_text_sprite texture = <continue_icon> parent = menu_continue 
		SetScreenElementProps { 
			id = menu_continue 
			event_handlers = [ 
				{ focus PlayHelperDesc params = { continue_helper_desc use_bg } } 
				{ unfocus StopHelperDesc } 
			] 
		} 
		IF GoalManager_goalIsActive name = TrickAttack 
			make_sprite_menu_item { 
				text = "Retry High Score Run" 
				id = menu_retry_high_score_run 
				pad_choose_script = menu_select 
				pad_choose_params = { stop_streams menu_select_script = RetryCurrentGoal } 
			} 
			make_text_sprite texture = <retry_icon> parent = menu_retry_high_score_run 
			SetScreenElementProps { 
				id = menu_retry_high_score_run 
				event_handlers = [ 
					{ focus PlayHelperDesc params = { retry_hsr_helper_desc use_bg } } 
					{ unfocus StopHelperDesc } 
				] 
			} 
			make_sprite_menu_item { 
				text = "End High Score Run" 
				id = menu_end_high_score_run 
				pad_choose_script = menu_select 
				pad_choose_params = { menu_select_script = end_high_score_run } 
			} 
			make_text_sprite texture = <end_icon> parent = menu_end_high_score_run 
			SetScreenElementProps { 
				id = menu_end_high_score_run 
				event_handlers = [ 
					{ focus PlayHelperDesc params = { end_hsr_helper_desc use_bg } } 
					{ unfocus StopHelperDesc } 
				] 
			} 
		ELSE 
			make_sprite_menu_item { 
				text = "Start High Score Run" 
				id = menu_start_high_score_run 
				pad_choose_script = menu_select 
				pad_choose_params = { menu_select_script = TrickAttack_MenuStartRun } 
			} 
			make_text_sprite texture = <retry_icon> parent = menu_start_high_score_run 
			SetScreenElementProps { 
				id = menu_start_high_score_run 
				event_handlers = [ 
					{ focus PlayHelperDesc params = { start_hsr_helper_desc use_bg } } 
					{ unfocus StopHelperDesc } 
				] 
			} 
		ENDIF 
	ELSE 
		IF NOT GotParam no_exit 
			make_sprite_menu_item text = "Continue" id = menu_continue pad_choose_script = handle_pause_continue pad_choose_sound = generic_pause_exit_sound 
			make_text_sprite texture = <continue_icon> parent = menu_continue 
			SetScreenElementProps { 
				id = menu_continue 
				event_handlers = [ 
					{ focus PlayHelperDesc params = { continue_helper_desc use_bg } } 
					{ unfocus StopHelperDesc } 
				] 
			} 
		ENDIF 
	ENDIF 
	IF GameModeEquals is_goal_attack 
		IF NOT IsObserving 
			IF GoalManager_CanRetryGoal 
				IF GoalManager_GetLastGoalId 
					IF NOT GoalManager_HasWonGoal name = <goal_id> 
						make_sprite_menu_item text = "Retry Last Goal" id = menu_retry_goal pad_choose_script = menu_select pad_choose_params = { stop_vibration menu_select_script = RetryCurrentGoal } 
						make_text_sprite texture = <retry_icon> parent = menu_retry_goal 
						SetScreenElementProps { 
							id = menu_retry_goal 
							event_handlers = [ 
								{ focus PlayHelperDesc params = { retry_goal_helper_desc use_bg } } 
								{ unfocus StopHelperDesc } 
							] 
						} 
					ENDIF 
				ENDIF 
			ENDIF 
			IF GoalManager_HasActiveGoals 
				make_sprite_menu_item text = "End Current Goal" id = menu_end_current_goal pad_choose_script = menu_select pad_choose_params = { menu_select_script = end_current_goal_run } 
				make_text_sprite texture = <end_icon> parent = menu_end_current_goal 
				SetScreenElementProps { 
					id = menu_end_current_goal 
					event_handlers = [ 
						{ focus PlayHelperDesc params = { end_run_helper_desc use_bg } } 
						{ unfocus StopHelperDesc } 
					] 
				} 
			ENDIF 
		ENDIF 
		make_sprite_menu_item text = "View Goals" id = menu_view_goals pad_choose_script = create_view_selected_goals_menu pad_choose_params = { from_pause } 
		make_text_sprite texture = <view_icon> parent = menu_view_goals 
		SetScreenElementProps { 
			id = menu_view_goals 
			event_handlers = [ 
				{ focus PlayHelperDesc params = { view_goal_cag_helper_desc use_bg } } 
				{ unfocus StopHelperDesc } 
			] 
		} 
	ENDIF 
	IF GameModeEquals is_singlesession 
		IF ( GoalManager_HasActiveGoals ) 
			tricks_uneditable = 1 
		ELSE 
			IF ( driving_parked_car = 1 ) 
				tricks_uneditable = 1 
			ELSE 
				IF GoalManager_goalIsActive name = TrickAttack 
					tricks_uneditable = 1 
				ENDIF 
			ENDIF 
		ENDIF 
		IF GotParam tricks_uneditable 
			make_theme_menu_item { 
				text = "Create A Trick" 
				id = menu_cat 
				pad_choose_script = create_pre_cat_menu 
				not_focusable = not_focusable 
			} 
		ELSE 
			make_sprite_menu_item { 
				text = "Create A Trick" 
				id = menu_cat 
				pad_choose_script = create_pre_cat_menu 
			} 
			make_text_sprite texture = <new_icon> parent = menu_cat 
			SetScreenElementProps { 
				id = menu_cat 
				event_handlers = [ 
					{ focus PlayHelperDesc params = { cat_helper_desc use_bg } } 
					{ unfocus StopHelperDesc } 
				] 
			} 
		ENDIF 
	ENDIF 
	IF GameModeEquals is_career 
		IF GoalManager_IsInCompetition 
			GoalManager_GetGoalParams name = <goal_id> 
			IF GotParam already_ended_run 
				IF ( <already_ended_run> = 0 ) 
					make_sprite_menu_item text = "End Current Run" id = menu_end_run pad_choose_script = goal_comp_end_current_run 
					make_text_sprite texture = <end_icon> parent = menu_end_run 
					SetScreenElementProps { 
						id = menu_end_run 
						event_handlers = [ 
							{ focus PlayHelperDesc params = { end_run_helper_desc use_bg } } 
							{ unfocus StopHelperDesc } 
						] 
					} 
				ENDIF 
			ENDIF 
		ENDIF 
		IF GoalManager_CanRetryGoal 
			make_sprite_menu_item text = "Retry Last Goal" id = menu_retry_goal pad_choose_script = menu_select pad_choose_params = { stop_vibration stop_streams menu_select_script = RetryCurrentGoal } 
			make_text_sprite texture = <retry_icon> parent = menu_retry_goal 
			SetScreenElementProps { 
				id = menu_retry_goal 
				event_handlers = [ 
					{ focus PlayHelperDesc params = { retry_goal_helper_desc use_bg } } 
					{ unfocus StopHelperDesc } 
				] 
			} 
		ENDIF 
		IF GoalManager_HasActiveGoals 
			make_sprite_menu_item text = "End Current Goal" id = menu_end_current_goal pad_choose_script = menu_select pad_choose_params = { menu_select_script = end_current_goal_run } 
			make_text_sprite texture = <end_icon> parent = menu_end_current_goal 
			SetScreenElementProps { 
				id = menu_end_current_goal 
				event_handlers = [ 
					{ focus PlayHelperDesc params = { end_run_helper_desc use_bg } } 
					{ unfocus StopHelperDesc } 
				] 
			} 
		ENDIF 
		make_sprite_menu_item text = "View Goals" id = menu_chapters pad_choose_script = create_chapter_menu 
		make_text_sprite texture = <view_icon> parent = menu_chapters 
		SetScreenElementProps { 
			id = menu_chapters 
			event_handlers = [ 
				{ focus PlayHelperDesc params = { view_goal_helper_desc use_bg } } 
				{ unfocus StopHelperDesc } 
			] 
		} 
	ELSE 
		IF GameModeEquals is_creategoals 
			IF GoalManager_CanRetryGoal 
				make_sprite_menu_item text = "Retry Last Goal" id = menu_retry_goal pad_choose_script = menu_select pad_choose_params = { stop_vibration stop_streams menu_select_script = RetryCurrentGoal } 
				make_text_sprite texture = <retry_icon> parent = menu_retry_goal 
				SetScreenElementProps { 
					id = menu_retry_goal 
					event_handlers = [ 
						{ focus PlayHelperDesc params = { retry_goal_helper_desc use_bg } } 
						{ unfocus StopHelperDesc } 
					] 
				} 
			ENDIF 
			IF GoalManager_HasActiveGoals 
				make_sprite_menu_item text = "End Current Goal" id = menu_end_current_goal pad_choose_script = menu_select pad_choose_params = { menu_select_script = end_current_goal_run } 
				make_text_sprite texture = <end_icon> parent = menu_end_current_goal 
				SetScreenElementProps { 
					id = menu_end_current_goal 
					event_handlers = [ 
						{ focus PlayHelperDesc params = { end_run_helper_desc use_bg } } 
						{ unfocus StopHelperDesc } 
					] 
				} 
			ENDIF 
			make_sprite_menu_item text = "View Goals" id = menu_view_goals pad_choose_script = create_view_goals_menu 
			make_text_sprite texture = <view_icon> parent = menu_view_goals 
			SetScreenElementProps { 
				id = menu_view_goals 
				event_handlers = [ 
					{ focus PlayHelperDesc params = { view_goal_cag_helper_desc use_bg } } 
					{ unfocus StopHelperDesc } 
				] 
			} 
			IF NOT LevelIs load_sk5ed_gameplay 
				make_sprite_menu_item text = "Create A Goal" id = menu_create_a_goal pad_choose_script = create_existing_goals_menu 
				make_text_sprite texture = <new_icon> parent = menu_create_a_goal 
				SetScreenElementProps { 
					id = menu_create_a_goal 
					event_handlers = [ 
						{ focus PlayHelperDesc params = { create_goal_helper_desc use_bg } } 
						{ unfocus StopHelperDesc } 
					] 
				} 
			ENDIF 
		ENDIF 
	ENDIF 
	IF GameModeEquals is_creategoals 
		IF NOT LevelIs load_sk5ed_gameplay 
			make_sprite_menu_item text = "Load goals" id = menu_load_goals pad_choose_script = prompt_launch_cag_pause_load 
			make_text_sprite texture = <load_icon> parent = menu_load_goals 
			SetScreenElementProps { 
				id = menu_load_goals 
				event_handlers = [ 
					{ focus PlayHelperDesc params = { load_goal_helper_desc use_bg } } 
					{ unfocus StopHelperDesc } 
				] 
			} 
			GoalEditor : GetNumEditedGoals ExcludeParkEditorGoals 
			IF ( <NumGoals> = 0 ) 
				no_edited_goals = 1 
			ENDIF 
			make_sprite_menu_item text = "Save goals" id = menu_save_goals pad_choose_script = launch_pause_menu_save_created_goals not_focusable = <no_edited_goals> 
			make_text_sprite texture = <save_icon> parent = menu_save_goals 
			SetScreenElementProps { 
				id = menu_save_goals 
				event_handlers = [ 
					{ focus PlayHelperDesc params = { save_goal_helper_desc use_bg } } 
					{ unfocus StopHelperDesc } 
				] 
			} 
		ENDIF 
	ENDIF 
	IF NOT InNetGame 
		make_sprite_menu_item text = "Change level" id = menu_level_select pad_choose_script = launch_level_select_menu 
		make_text_sprite texture = <level_icon> parent = menu_level_select 
		SetScreenElementProps { 
			id = menu_level_select 
			event_handlers = [ 
				{ focus PlayHelperDesc params = { change_level_helper_desc use_bg } } 
				{ unfocus StopHelperDesc } 
			] 
		} 
	ENDIF 
	IF NOT InNetGame 
		make_sprite_menu_item text = "Edit Skater/Tricks" id = menu_cas pad_choose_script = edit_skater_options_menu 
		make_text_sprite texture = <edit_skater_icon> parent = menu_cas 
		SetScreenElementProps { 
			id = menu_cas 
			event_handlers = [ 
				{ focus PlayHelperDesc params = { edit_skater_helper_desc use_bg } } 
				{ unfocus StopHelperDesc } 
			] 
		} 
	ENDIF 
	IF InNetGame 
		IF IsHost 
			IF GameModeEquals is_lobby 
				IF NOT NetworkGamePending 
					IF NOT ChangeLevelPending 
						make_sprite_menu_item text = "Start Game" id = menu_network_start_select pad_choose_script = network_game_options_selected 
						make_text_sprite texture = <retry_icon> parent = menu_network_start_select 
						SetScreenElementProps { 
							id = menu_network_start_select 
							event_handlers = [ 
								{ focus PlayHelperDesc params = { start_game_helper_desc use_bg } } 
								{ unfocus StopHelperDesc } 
							] 
						} 
					ENDIF 
				ENDIF 
			ELSE 
				make_sprite_menu_item text = "End Current Game" id = menu_network_end_select pad_choose_script = network_end_game_selected 
				make_text_sprite texture = <end_icon> parent = menu_network_end_select 
				SetScreenElementProps { 
					id = menu_network_end_select 
					event_handlers = [ 
						{ focus PlayHelperDesc params = { end_game_helper_desc use_bg } } 
						{ unfocus StopHelperDesc } 
					] 
				} 
			ENDIF 
		ENDIF 
	ENDIF 
	IF InNetGame 
		IF OnServer 
			IF OnXbox 
				make_sprite_menu_item text = "Host Options" id = menu_network_server_opts_select pad_choose_script = network_options_selected 
				SetScreenElementProps { 
					id = menu_network_server_opts_select 
					event_handlers = [ 
						{ focus PlayHelperDesc params = { host_options_helper_desc use_bg } } 
						{ unfocus StopHelperDesc } 
					] 
				} 
			ELSE 
				make_sprite_menu_item text = "Server Options" id = menu_network_server_opts_select pad_choose_script = network_options_selected 
				SetScreenElementProps { 
					id = menu_network_server_opts_select 
					event_handlers = [ 
						{ focus PlayHelperDesc params = { server_options_helper_desc use_bg } } 
						{ unfocus StopHelperDesc } 
					] 
				} 
			ENDIF 
			make_text_sprite texture = <online_icon> parent = menu_network_server_opts_select 
		ENDIF 
		IF IsHost 
			IF GameModeEquals is_lobby 
				IF NOT OnServer 
					IF OnXbox 
						make_sprite_menu_item text = "Host Options" id = menu_network_server_opts_select pad_choose_script = network_options_selected 
						SetScreenElementProps { 
							id = menu_network_server_opts_select 
							event_handlers = [ 
								{ focus PlayHelperDesc params = { host_options_helper_desc use_bg } } 
								{ unfocus StopHelperDesc } 
							] 
						} 
					ELSE 
						make_sprite_menu_item text = "Server Options" id = menu_network_server_opts_select pad_choose_script = network_options_selected 
						SetScreenElementProps { 
							id = menu_network_server_opts_select 
							event_handlers = [ 
								{ focus PlayHelperDesc params = { server_options_helper_desc use_bg } } 
								{ unfocus StopHelperDesc } 
							] 
						} 
					ENDIF 
					make_text_sprite texture = <online_icon> parent = menu_network_server_opts_select 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
	make_sprite_menu_item text = "Options" id = menu_options pad_choose_script = create_options_menu 
	make_text_sprite texture = <options_icon> parent = menu_options 
	SetScreenElementProps { 
		id = menu_options 
		event_handlers = [ 
			{ focus PlayHelperDesc params = { pause_options_helper_desc use_bg } } 
			{ unfocus StopHelperDesc } 
		] 
	} 
	IF InNetGame 
		IF NOT IsObserving 
			<firefight_active> = 0 
			IF GoalManager_GoalExists name = firefight 
				IF GoalManager_goalIsActive name = firefight 
					<firefight_active> = 1 
				ENDIF 
			ENDIF 
			IF ( <firefight_active> = 1 ) 
				<trick_text> = "View Tricks" 
				<trick_helper> = view_tricks_helper_desc 
			ELSE 
				IF NOT GoalManager_HasActiveGoals 
					<trick_text> = "Edit Tricks" 
					<trick_helper> = edit_tricks_helper_desc 
				ELSE 
					<trick_text> = "View Tricks" 
					<trick_helper> = view_tricks_helper_desc 
				ENDIF 
			ENDIF 
			FormatText ChecksumName = trick_icon "%i_trick" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
			make_sprite_menu_item text = <trick_text> id = menu_cas pad_choose_script = create_edit_tricks_menu 
			make_text_sprite texture = <trick_icon> parent = menu_cas 
			SetScreenElementProps { 
				id = menu_cas 
				event_handlers = [ 
					{ focus PlayHelperDesc params = { <trick_helper> use_bg } } 
					{ unfocus StopHelperDesc } 
				] 
			} 
		ENDIF 
	ENDIF 
	FormatText ChecksumName = online_icon "%i_online" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	IF InNetGame 
		IF IsHost 
			IF GameModeEquals is_lobby 
				IF NOT NetworkGamePending 
					IF NOT ChangeLevelPending 
						make_sprite_menu_item text = "Change level" id = menu_level_select pad_choose_script = launch_level_select_menu pad_choose_params = { show_warning } 
						make_text_sprite texture = <level_icon> parent = menu_level_select 
						SetScreenElementProps { 
							id = menu_level_select 
							event_handlers = [ 
								{ focus PlayHelperDesc params = { change_level_helper_desc use_bg } } 
								{ unfocus StopHelperDesc } 
							] 
						} 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
		IF OnXbox 
			IF IsTrue bootstrap_build 
				make_sprite_menu_item text = "Player List" id = menu_network_remove_select pad_choose_script = launch_remove_players_menu not_focusable = not_focusable 
				make_text_sprite texture = <career_ops_icon> parent = menu_network_remove_select 
				SetScreenElementProps { 
					id = menu_network_remove_select 
					event_handlers = [ 
						{ focus PlayHelperDesc params = { player_list_helper_desc use_bg } } 
						{ unfocus StopHelperDesc } 
					] 
				} 
			ELSE 
				make_sprite_menu_item text = "Player List" id = menu_network_player_list_select pad_choose_script = launch_player_list_menu 
				make_text_sprite texture = <career_ops_icon> parent = menu_network_player_list_select 
				SetScreenElementProps { 
					id = menu_network_player_list_select 
					event_handlers = [ 
						{ focus PlayHelperDesc params = { player_list_helper_desc use_bg } } 
						{ unfocus StopHelperDesc } 
					] 
				} 
				IF ProfileLoggedIn 
					make_sprite_menu_item text = "Homie List" id = menu_network_homie_list_select pad_choose_script = launch_homie_list 
					make_text_sprite texture = <options_icon> parent = menu_network_homie_list_select 
					SetScreenElementProps { 
						id = menu_network_homie_list_select 
						event_handlers = [ 
							{ focus PlayHelperDesc params = { homie_list_helper_desc use_bg } } 
							{ unfocus StopHelperDesc } 
						] 
					} 
				ENDIF 
			ENDIF 
		ENDIF 
	ELSE 
		IF NOT GameModeEquals is_creategoals 
			make_sprite_menu_item text = "Save Game" id = menu_save_game pad_choose_script = launch_pause_menu_save_game_sequence 
			make_text_sprite texture = <save_icon> parent = menu_save_game 
			SetScreenElementProps { 
				id = menu_save_game 
				event_handlers = [ 
					{ focus PlayHelperDesc params = { save_game_helper_desc use_bg } } 
					{ unfocus StopHelperDesc } 
				] 
			} 
		ENDIF 
		make_sprite_menu_item text = "View Gaps" id = menu_skip_to_gap pad_choose_script = launch_gap_menu 
		make_text_sprite texture = <gap_icon> parent = menu_skip_to_gap 
		SetScreenElementProps { 
			id = menu_skip_to_gap 
			event_handlers = [ 
				{ focus PlayHelperDesc params = { view_gaps_helper_desc use_bg } } 
				{ unfocus StopHelperDesc } 
			] 
		} 
		IF GameModeEquals is_career 
			GetCurrentSkaterProfileIndex 
			GetSkaterProfileInfo player = <currentSkaterProfileIndex> 
			IF ( <name> = custom ) 
				make_sprite_menu_item text = "View Stats" id = menu_edit_stats pad_choose_script = create_stats_menu 
				make_text_sprite texture = <stats_icon> parent = menu_edit_stats 
				SetScreenElementProps { 
					id = menu_edit_stats 
					event_handlers = [ 
						{ focus PlayHelperDesc params = { view_stats_helper_desc use_bg } } 
						{ unfocus StopHelperDesc } 
					] 
				} 
			ENDIF 
		ENDIF 
		IF NOT CD 
			make_sprite_menu_item text = "Goto Restart" id = menu_skip_to_restart pad_choose_script = launch_restart_menu 
			make_text_sprite texture = <model_icon> parent = menu_skip_to_restart 
			SetScreenElementProps { 
				id = menu_skip_to_restart 
				event_handlers = [ 
					{ focus PlayHelperDesc params = { goto_restart_helper_desc use_bg } } 
					{ unfocus StopHelperDesc } 
				] 
			} 
		ENDIF 
	ENDIF 
	IF NOT CD 
		make_sprite_menu_item text = "Debug Menu" id = debug_menu pad_choose_script = create_debug_menu 
		make_text_sprite texture = <model_icon> parent = debug_menu 
		make_sprite_menu_item text = "Test Menu" id = test_menu pad_choose_script = create_test_menu 
		make_text_sprite texture = <model_icon> parent = test_menu 
	ENDIF 
	IF InNetGame 
		make_sprite_menu_item text = "Chat Message" id = menu_chat pad_choose_script = launch_chat_keyboard 
		make_text_sprite texture = <name_cat_icon> parent = menu_chat 
		SetScreenElementProps { 
			id = menu_chat 
			event_handlers = [ 
				{ focus PlayHelperDesc params = { chat_msg_helper_desc use_bg } } 
				{ unfocus StopHelperDesc } 
			] 
		} 
		IF NOT OnServer 
			IF NOT IsObserving 
				IF InInternetMode 
					IF IsTrue bootstrap_build 
						IF NOT GoalManager_HasActiveGoals 
							make_sprite_menu_item text = "Observe" id = menu_network_observe_select pad_choose_script = chose_observe not_focusable = not_focusable 
							make_text_sprite texture = <options_icon> parent = menu_network_observe_select 
						ENDIF 
					ELSE 
						IF NOT GoalManager_HasActiveGoals 
							make_sprite_menu_item text = "Observe" id = menu_network_observe_select pad_choose_script = chose_observe 
							make_text_sprite texture = <options_icon> parent = menu_network_observe_select 
						ENDIF 
					ENDIF 
					IF ScreenElementExists id = menu_network_observe_select 
						SetScreenElementProps { 
							id = menu_network_observe_select 
							event_handlers = [ 
								{ focus PlayHelperDesc params = { observe_helper_desc use_bg } } 
								{ unfocus StopHelperDesc } 
							] 
						} 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
		make_sprite_menu_item text = "Quit" id = menu_quit pad_choose_script = generic_menu_pad_choose pad_choose_params = { callback = launch_quit_game_dialog } 
		make_text_sprite texture = <quit_icon> parent = menu_quit 
		SetScreenElementProps { 
			id = menu_quit 
			event_handlers = [ 
				{ focus PlayHelperDesc params = { quit_helper_desc use_bg } } 
				{ unfocus StopHelperDesc } 
			] 
		} 
	ELSE 
		IF CustomParkMode testing 
			printf "PARK EDITOR TEST PLAY MENU" 
			make_sprite_menu_item text = "Back to editor" id = menu_skateshop pad_choose_script = menu_confirm_quit pad_choose_params = { yes_script = exit_test_play } 
			make_text_sprite texture = <back_icon> parent = menu_skateshop 
			SetScreenElementProps { 
				id = menu_skateshop 
				event_handlers = [ 
					{ focus PlayHelperDesc params = { back_editor_desc use_bg } } 
					{ unfocus StopHelperDesc } 
				] 
			} 
		ELSE 
			make_sprite_menu_item text = "Quit" id = menu_skateshop pad_choose_script = generic_menu_pad_choose pad_choose_params = { callback = menu_confirm_quit } 
			make_text_sprite texture = <quit_icon> parent = menu_skateshop 
			SetScreenElementProps { 
				id = menu_skateshop 
				event_handlers = [ 
					{ focus PlayHelperDesc params = { quit_helper_desc use_bg } } 
					{ unfocus StopHelperDesc } 
				] 
			} 
		ENDIF 
	ENDIF 
	kill_blur start = 0 
	build_pause_menu_parts show_deck = show_deck 
ENDSCRIPT

SCRIPT prompt_launch_cag_pause_load 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	create_dialog_box { title = "Load Goals" 
		text = #"Warning !\\nAny unsaved changes to your current CREATED GOALS will be lost.\\nContinue ?" 
		pos = PAIR(320.00000000000, 240.00000000000) 
		text_dims = PAIR(400.00000000000, 0.00000000000) 
		just = [ center center ] 
		text_rgba = [ 88 105 112 128 ] 
		text_scale = 1 
		buttons = [ { font = small text = "Yes" pad_choose_script = launch_pause_menu_load_created_goals } 
			{ font = small text = "No" pad_choose_script = no_launch_cag_pause_load } 
		] 
	} 
ENDSCRIPT

SCRIPT no_launch_cag_pause_load 
	dialog_box_exit 
	create_pause_menu 
ENDSCRIPT

SCRIPT edit_skater_options_menu 
	hide_current_goal 
	FormatText ChecksumName = title_icon "%i_edit_skater" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	make_new_themed_option_menu title = "EDIT SKATER" title_icon = <title_icon> 
	pause_show_deck parent = current_menu_anchor no_slide 
	IF LevelIs load_skateshop 
		pad_back_script = skateshop_practice_pause_menu 
	ELSE 
		pad_back_script = create_pause_menu 
	ENDIF 
	GoalManager_HideGoalPoints 
	GoalManager_HidePoints 
	unhide_root_window 
	SetScreenElementProps { id = options_menu 
		event_handlers = [ 
			{ pad_back generic_menu_pad_back params = { callback = <pad_back_script> } } 
		] 
	} 
	IF ( GoalManager_HasActiveGoals ) 
		tricks_uneditable = 1 
	ELSE 
		IF ( driving_parked_car = 1 ) 
			tricks_uneditable = 1 
		ELSE 
			IF GoalManager_goalIsActive name = TrickAttack 
				tricks_uneditable = 1 
			ENDIF 
		ENDIF 
	ENDIF 
	IF GotParam tricks_uneditable 
		make_theme_menu_item { 
			text = "View Tricks" 
			id = menu_edit_tricks 
			pad_choose_script = create_edit_tricks_menu 
		} 
		IF NOT GameModeEquals is_singlesession 
			make_theme_menu_item { 
				text = "Create A Trick" 
				id = menu_cat 
				pad_choose_script = create_pre_cat_menu 
				not_focusable = not_focusable 
			} 
		ENDIF 
	ELSE 
		make_theme_menu_item { 
			text = "Edit Tricks" 
			id = menu_edit_tricks 
			pad_choose_script = create_edit_tricks_menu 
		} 
		IF NOT GameModeEquals is_singlesession 
			make_theme_menu_item { 
				text = "Create A Trick" 
				id = menu_cat 
				pad_choose_script = create_pre_cat_menu 
			} 
		ENDIF 
	ENDIF 
	select_skater_get_current_skater_name 
	IF ( <current_skater> = custom ) 
		IF NOT LevelIs load_sk5ed_gameplay 
			make_theme_menu_item { 
				text = "Edit Appearance" 
				id = menu_edit_appearance 
				pad_choose_script = maybe_edit_skater 
				pad_choose_params = { yes_script = pause_launch_level yes_params = { level = load_cas } } 
			} 
			IF ( ( GetGlobalFlag flag = BOARDSHOP_UNLOCKED ) | ( all_levels_unlocked = 1 ) ) 
				make_theme_menu_item { text = "Skateshop" 
					id = menu_shop 
					pad_choose_script = maybe_edit_skater 
					pad_choose_params = { yes_script = pause_launch_level yes_params = { level = load_boardshop } } 
				} 
			ELSE 
				IF CD 
					make_theme_menu_item { text = "Skateshop" 
						id = menu_shop 
						pad_choose_script = null_script 
						not_focusable = not_focusable 
					} 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
	build_top_bar pos = PAIR(-400.00000000000, 62.00000000000) 
	DoScreenElementMorph id = top_bar_anchor time = 0.20000000298 pos = PAIR(0.00000000000, 62.00000000000) 
	FireEvent type = focus target = current_menu_anchor 
ENDSCRIPT

SCRIPT maybe_edit_skater 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	wait 2 frames 
	create_dialog_box { title = "Edit Confirmation" 
		text = "Exit the current level to change options?" 
		pos = PAIR(320.00000000000, 240.00000000000) 
		just = [ center center ] 
		text_rgba = [ 88 105 112 128 ] 
		text_scale = 1 
		pad_back_script = no_edit_skater 
		buttons = [ { font = small text = "Yes" pad_choose_script = <yes_script> pad_choose_params = <yes_params> } 
			{ font = small text = "No" pad_choose_script = no_edit_skater } 
		] 
	} 
ENDSCRIPT

SCRIPT no_edit_skater 
	dialog_box_exit 
	wait 1 frame 
	edit_skater_options_menu 
ENDSCRIPT

music_was_paused = 0 
inside_pause = 0 
SCRIPT create_mp_pause_menu 
	SetButtonEventMappings unblock_menu_input 
	make_new_pause_menu menu_id = pause_menu vmenu_id = pause_vmenu pad_back_script = handle_start_pressed pos = PAIR(320.00000000000, 540.00000000000) 
	kill_start_key_binding 
	create_helper_text generic_helper_text 
	set_theme_icons 
	add_music_track_text pos = PAIR(900.00000000000, 350.00000000000) 
	make_sprite_menu_item text = "Continue" id = menu_continue pad_choose_script = handle_start_pressed 
	make_text_sprite texture = <continue_icon> parent = menu_continue 
	make_sprite_menu_item text = "End Current Game" id = menu_network_end_select pad_choose_script = network_end_game_selected 
	make_text_sprite texture = <end_icon> parent = menu_network_end_select 
	make_sprite_menu_item text = "Options" id = menu_mp_options pad_choose_script = generic_menu_pad_choose pad_choose_params = { callback = create_options_menu } 
	make_text_sprite texture = <options_icon> parent = menu_mp_options 
	make_sprite_menu_item text = "Quit" id = menu_skateshop pad_choose_script = generic_menu_pad_choose pad_choose_params = { callback = menu_confirm_quit } 
	make_text_sprite texture = <quit_icon> parent = menu_skateshop 
	RunScriptOnScreenElement id = pause_menu menu_onscreen 
ENDSCRIPT

SCRIPT exit_pause_menu menu_id = current_menu_anchor 
	change check_for_unplugged_controllers = 0 
	IF ScreenElementExists id = current_menu_anchor 
		FireEvent type = unfocus target = current_menu_anchor 
	ENDIF 
	Debounce X time = 0.30000001192 
	Debounce Triangle time = 0.30000001192 
	pause_menu_gradient off 
	change inside_pause = 0 
	change no_focus_sound = 1 
	change viewer_buttons_enabled = 1 
	GoalManager_ShowGoalPoints 
	GoalManager_ShowPoints 
	unhide_3d_goal_arrow 
	unhide_landing_msg 
	unhide_stat_message 
	unhide_chaper_intro_title 
	unhide_tips 
	goal_skate_unhide_letters 
	unhide_combo_letters 
	unhide_death_msg 
	unhide_comp_text 
	unpause_trick_text 
	IF InNetGame 
		IF NOT IsObserving 
			IF ObjectExists id = skater 
				skater : NetEnablePlayerInput 
			ENDIF 
		ENDIF 
	ENDIF 
	UnpauseGame 
	possibly_add_temp_special_trick 
	PauseStream 0 
	IF GoalManager_HasActiveGoals 
		IF ( music_was_paused = 0 ) 
			PauseMusic 0 
		ENDIF 
	ELSE 
		IF IsTrue ALWAYSPLAYMUSIC 
			IF ( music_was_paused = 0 ) 
				PauseMusic 0 
			ENDIF 
		ENDIF 
	ENDIF 
	unpause_rain 
	IF NOT InNetGame 
		unpause_trick_text 
	ENDIF 
	Unpause_Balance_Meter 
	unpause_run_timer 
	IF ObjectExists id = speech_box_anchor 
		DoScreenElementMorph id = speech_box_anchor scale = 1 
	ENDIF 
	IF ObjectExists id = goal_start_dialog 
		DoScreenElementMorph id = goal_start_dialog scale = 1 
	ENDIF 
	IF ObjectExists id = ped_speech_dialog 
		DoScreenElementMorph id = ped_speech_dialog scale = 1 
	ENDIF 
	IF ScreenElementExists id = cutscene_camera_hud_anchor 
		IF ( camera_hud_is_hidden = 1 ) 
			change camera_hud_is_hidden = 0 
			DoScreenElementMorph id = cutscene_camera_hud_anchor alpha = 1 
		ENDIF 
	ENDIF 
	IF ScreenElementExists id = nightvision_hud_anchor 
		IF ( nightvision_hud_is_hidden = 1 ) 
			change nightvision_hud_is_hidden = 0 
			DoScreenElementMorph id = nightvision_hud_anchor alpha = 1 
		ENDIF 
	ENDIF 
	show_goal_panel_messages 
	IF NOT RunningReplay 
		GoalManager_UnPauseAllGoals 
	ENDIF 
	IF ObjectExists id = <menu_id> 
		DestroyScreenElement id = <menu_id> 
	ENDIF 
	kill_pause_menu_cams 
	SetScreenElementProps id = root_window tags = { menu_state = off } 
	IF NOT InMultiPlayerGame 
		GoalManager_ShowPoints 
		IF NOT GoalManager_HasActiveGoals 
			GoalManager_ShowGoalPoints 
		ELSE 
			GoalManager_HideGoalPoints 
		ENDIF 
	ENDIF 
	IF CustomParkMode editing 
		IF NOT GotParam DoNotSwitchEditorState 
			SetParkEditorState state = edit 
			SetParkEditorPauseMode unpause 
		ENDIF 
	ENDIF 
	restore_start_key_binding 
	IF ObjectExists id = console_message_vmenu 
		DoScreenElementMorph id = console_message_vmenu time = 0 scale = 1 
	ENDIF 
	IF ( HIDEHUD = 1 ) 
		printf "hiding" 
		hide_root_window 
	ENDIF 
	IF GetGlobalFlag flag = NO_DISPLAY_HUD 
		GoalManager_HideGoalPoints 
		GoalManager_HidePoints 
	ENDIF 
	IF NOT GetGlobalFlag flag = NO_DISPLAY_CHATWINDOW 
		unhide_console_window 
	ELSE 
		hide_console_window 
	ENDIF 
	IF NOT GetGlobalFlag flag = NO_DISPLAY_NET_SCORES 
		unhide_net_scores 
	ELSE 
		hide_net_scores 
	ENDIF 
	change check_for_unplugged_controllers = 1 
ENDSCRIPT

SCRIPT pause_launch_level 
	skater : StatsManager_Reset 
	IF ( ( <level> = load_boardshop ) | ( <level> = load_cas ) ) 
		temp = <level> 
		GetCurrentLevel 
		array = return_to_level 
		SetArrayElement arrayname = array index = 0 newvalue = <level> 
		level = <temp> 
	ENDIF 
	change_level <...> 
ENDSCRIPT

SCRIPT kill_pause_menu_cams 
	kill_proset_cams 
ENDSCRIPT

SCRIPT set_custom_restart 
	skater : SetCustomRestart Set 
ENDSCRIPT

SCRIPT skip_to_custom_restart 
	skater : SkipToCustomRestart 
ENDSCRIPT

SCRIPT launch_restart_menu 
	RunScriptOnScreenElement id = current_menu_anchor animate_out callback = create_restart_menu 
ENDSCRIPT

SCRIPT create_restart_menu 
	hide_current_goal 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	FormatText ChecksumName = title_icon "%i_options" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	make_new_themed_scrolling_menu title = "RESTART" title_icon = <title_icon> dims = PAIR(600.00000000000, 237.00000000000) pos = PAIR(229.00000000000, 80.00000000000) right_bracket_z = 1 
	SetScreenElementProps { id = sub_menu 
		event_handlers = [ 
			{ pad_back generic_menu_pad_back params = { callback = create_pause_menu } } 
		] 
	} 
	create_helper_text generic_helper_text 
	kill_start_key_binding 
	AddRestartsToMenu initial_scale = 1.00000000000 
	theme_menu_add_item text = "Done" pad_choose_script = create_pause_menu no_bg last_item = last_item centered = centered 
	finish_themed_scrolling_menu 
ENDSCRIPT

SCRIPT skip_to_selected_restart 
	ResetSkaters <...> 
	exit_pause_menu 
ENDSCRIPT

SCRIPT preview_restart 
	pulse_blur start = 200 speed = 5 
	ResetSkaters <...> 
	SetProps rgba = [ 128 128 0 128 ] 
	DoMorph time = 0.25000000000 scale = 1.00000000000 
ENDSCRIPT

SCRIPT scale_down_restart 
	SetProps rgba = [ 88 105 112 128 ] 
	DoMorph time = 0.25000000000 scale = 0.80000001192 
ENDSCRIPT

SCRIPT launch_pause_menu cur_menu = current_menu_anchor 
	printf "why was this called?" 
ENDSCRIPT

SCRIPT menu_confirm_quit { 
		yes_script = level_select_change_level_quit 
		no_script = menu_quit_no 
		back_script = menu_quit_no 
		title = "QUIT?" 
		text = "Are you sure?" 
		text_dims = PAIR(200.00000000000, 0.00000000000) 
		params = { } 
	} 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	IF NOT IsTrue bootstrap_build 
		create_error_box { title = <title> 
			text = <text> 
			pos = PAIR(310.00000000000, 240.00000000000) 
			just = [ center center ] 
			text_rgba = [ 88 105 112 128 ] 
			text_dims = <text_dims> 
			pad_back_script = <back_script> 
			pad_back_params = <params> 
			buttons = [ { font = small text = "Yes" pad_choose_script = <yes_script> pad_choose_params = { level = load_skateshop <params> } } 
				{ font = small text = "No" pad_choose_script = <no_script> pad_choose_params = <params> } 
			] 
		} 
	ELSE 
		create_error_box { title = <title> 
			text = "Exit Demo?" 
			pos = PAIR(310.00000000000, 240.00000000000) 
			just = [ center center ] 
			text_rgba = [ 88 105 112 128 ] 
			pad_back_script = <back_script> 
			buttons = [ { font = small text = "Yes" pad_choose_script = bootstrap_quit } 
				{ font = small text = "No" pad_choose_script = <back_script> } 
			] 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT menu_confirm_quit_park_editor { 
		yes_script = launch_park_editor_save_park_sequence 
		no_script = parked_quit 
		back_script = menu_quit_no 
		title = "Save Park?" 
	} 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	IF IsParkUnsaved 
		IF isxbox 
			error_text = "Network Play may cause you to lose unsaved changes to this park. Save it now?" 
		ELSE 
			IF isngc 
				error_text = "Do you want to save your park before quitting?" 
			ELSE 
				error_text = "Playing online or downloading a new park will cause you to lose unsaved changes to this park. Save it now?" 
			ENDIF 
		ENDIF 
		create_error_box { title = <title> 
			text = <error_text> 
			pos = PAIR(310.00000000000, 240.00000000000) 
			just = [ center center ] 
			text_rgba = [ 88 105 112 128 ] 
			pad_back_script = <back_script> 
			buttons = [ { font = small text = "Yes" pad_choose_script = <yes_script> pad_choose_params = { level = load_skateshop } } 
				{ font = small text = "No" pad_choose_script = <no_script> pad_choose_params = { level = load_skateshop } } 
			] 
		} 
	ELSE 
		<no_script> level = load_skateshop 
	ENDIF 
ENDSCRIPT

SCRIPT level_select_change_level_quit 
	DisplayLoadingScreen blank 
	GoalManager_DeactivateAllGoals 
	GoalManager_LevelUnload 
	MakeSkaterGoto SkaterInit 
	SetButtonEventMappings block_menu_input 
	RailEditor : DestroyEditedRailSectors 
	printf "leaving and destroying server" 
	SetParkEditorState state = off 
	chosen_leave_server 
	SetGameType career 
	SetCurrentGameType 
	SetStatOverride 
	setservermode on 
	StartServer 
	SetJoinMode JOIN_MODE_PLAY 
	printf "attempting to join server" 
	JoinServer 
	printf "waiting" 
	BEGIN 
		printf "waiting 1 frame" 
		IF JoinServerComplete 
			BREAK 
		ELSE 
			wait 1 
		ENDIF 
		printf "still waiting" 
	REPEAT 
	printf "attempting to change level" 
	level_select_change_level <...> 
	SetButtonEventMappings unblock_menu_input 
ENDSCRIPT

SCRIPT menu_quit_no 
	generic_menu_pad_back_sound 
	dialog_box_exit 
	create_pause_menu 
ENDSCRIPT

SCRIPT menu_cash_no 
	dialog_box_exit 
	create_options_menu 
ENDSCRIPT

SCRIPT bootstrap_quit 
	dialog_box_exit 
	SetButtonEventMappings block_menu_input 
	skater : DisablePlayerInput 
	PauseGame 
	Cleanup 
	DisplayLoadingScreen "loadscrn_marketing" 
	wait 5 seconds 
	exitdemo 
ENDSCRIPT

SCRIPT launch_set_pro_skater_menu 
	RunScriptOnScreenElement id = current_menu_anchor animate_out callback = create_set_pro_skater_menu 
ENDSCRIPT

SCRIPT make_select_set_pro_skater_line 
	make_text_sub_menu_item text = <text> pad_choose_script = set_pro_skater pad_choose_params = <...> 
ENDSCRIPT

SCRIPT create_set_pro_skater_menu 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	make_new_menu menu_id = set_pro_skater_menu vmenu_id = set_pro_skater_vmenu menu_title = "PRO SKATERS" 
	set_theme_icons 
	IF LevelIs load_skateshop 
		KillSkaterCamAnim all 
		PlaySkaterCamAnim name = SS_SkaterChoosing play_hold 
		SetScreenElementProps { 
			id = set_pro_skater_menu 
			event_handlers = [ { pad_back create_main_menu } ] 
			replace_handlers 
		} 
		make_text_sub_menu_item { text = "Continue" 
			pad_choose_script = skateshop_transition 
			pad_choose_params = { new_menu_script = launch_ss_menu } 
		} 
	ELSE 
		SetScreenElementProps { 
			id = set_pro_skater_menu 
			event_handlers = [ { pad_back create_debug_menu } ] 
			replace_handlers 
		} 
	ENDIF 
	add_set_pro_skater_to_menu 
	RunScriptOnScreenElement id = current_menu_anchor animate_in params = { final_pos = PAIR(320.00000000000, 134.00000000000) } 
ENDSCRIPT

SCRIPT set_pro_skater 
	printf "Set pro skater here" 
	load_pro_skater { profile = 0 skater = 0 <...> } 
	IF LevelIs load_skateshop 
		printf "we\'re in the skateshop" 
		launch_ss_menu 
	ELSE 
		exit_pause_menu 
	ENDIF 
ENDSCRIPT

SCRIPT launch_change_skater_appearance_menu 
	RunScriptOnScreenElement id = current_menu_anchor animate_out callback = create_change_skater_appearance_menu 
ENDSCRIPT

SCRIPT make_select_change_skater_appearance_line 
	make_text_sub_menu_item text = <text> pad_choose_script = change_skater_appearance pad_choose_params = { <...> } 
ENDSCRIPT

SCRIPT create_change_skater_appearance_menu 
	make_new_menu menu_id = change_skater_appearance_menu vmenu_id = change_skater_appearance_vmenu menu_title = "APPEARANCE" 
	set_theme_icons 
	SetScreenElementProps { id = change_skater_appearance_menu event_handlers = [ 
			{ pad_back create_pause_menu } 
		] 
	} 
	add_change_skater_appearance_to_menu 
	RunScriptOnScreenElement id = current_menu_anchor animate_in 
ENDSCRIPT

SCRIPT change_skater_appearance 
	printf "Change skater appearance here" 
	InitSkaterModel skater = 0 <...> 
	exit_pause_menu 
ENDSCRIPT

SCRIPT create_debug_menu 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	pause_menu_gradient off 
	make_new_menu { 
		menu_id = debug_menu 
		vmenu_id = debug_vmenu 
		menu_title = "DEBUG" 
		type = VScrollingMenu 
		dims = PAIR(200.00000000000, 350.00000000000) 
		padding_scale = 0.94999998808 
		pos = PAIR(243.00000000000, 50.00000000000) 
	} 
	SetScreenElementProps { id = debug_menu 
		event_handlers = [ 
			{ pad_back generic_menu_pad_back params = { callback = create_pause_menu } } 
		] 
	} 
	set_theme_icons 
	make_text_sub_menu_item text = "Auto Rail Level" id = menu_autoraillevel pad_choose_script = autorail_level 
	make_text_sub_menu_item text = "Time Of Day" id = menu_timeofday pad_choose_script = launch_timeofday_menu 
	make_text_sub_menu_item text = "Lighting Tool" id = menu_lighting pad_choose_script = launch_lighting_tool 
	make_text_sub_menu_item text = "Set Pro Skater" id = menu_set_pro_skater pad_choose_script = create_set_pro_skater_menu 
	make_text_sub_menu_item text = "Rail Display Toggle" pad_choose_script = toggle_rails 
	make_text_sub_menu_item text = "Bouncy Object Debug Display Toggle" pad_choose_script = toggle_rigidbody 
	make_text_sub_menu_item text = "Toggle Profiler" id = menu_profiler pad_choose_script = launch_toggle_profiler 
	make_text_sub_menu_item text = "Toggle Poly Count" id = menu_poly pad_choose_script = show_poly_count 
	make_text_sub_menu_item text = "Toggle Free Memory" id = menu_mem pad_choose_script = show_free_mem 
	IF CD 
		make_text_sub_menu_item text = "Start AutoTest" id = menu_start_autotest pad_choose_script = menu_start_autotest 
		make_text_sub_menu_item text = "Stop AutoTest" id = menu_stop_autotest pad_choose_script = menu_stop_autotest 
	ENDIF 
	make_text_sub_menu_item text = "Wireframe Toggle" pad_choose_script = toggle_wireframe 
	make_text_sub_menu_item text = "Show Vert Polys" pad_choose_script = toggle_show_polys pad_choose_params = { showscript = show_vert } 
	make_text_sub_menu_item text = "Show Wallride Polys" pad_choose_script = toggle_show_polys pad_choose_params = { showscript = show_wallride } 
	make_text_sub_menu_item text = "Show Trigger Polys" pad_choose_script = toggle_show_polys pad_choose_params = { showscript = show_trigger } 
	make_text_sub_menu_item text = "Show Camera Polys" pad_choose_script = toggle_show_polys pad_choose_params = { showscript = show_camera_collide } 
	make_text_sub_menu_item text = "Show Not Skateable" pad_choose_script = toggle_show_polys pad_choose_params = { showscript = show_not_skatable } 
	make_text_sub_menu_item text = "Show skater shadow" pad_choose_script = toggle_show_polys pad_choose_params = { showscript = show_skater_shadow } 
	make_text_sub_menu_item text = "Show no skater shadow" pad_choose_script = toggle_show_polys pad_choose_params = { showscript = show_no_skater_shadow } 
	make_text_sub_menu_item text = "Show no skater shadow wall" pad_choose_script = toggle_show_polys pad_choose_params = { showscript = show_no_skater_shadow_wall } 
	make_text_sub_menu_item text = "CheckForHoles (Slow)" pad_choose_script = hole_check 
	make_text_sub_menu_item text = "Hide HUD" pad_choose_script = debug_menu_hide_hud 
	make_text_sub_menu_item text = "Done" id = menu_done pad_choose_script = create_pause_menu 
	RunScriptOnScreenElement id = current_menu_anchor animate_in params = { final_pos = PAIR(320.00000000000, 134.00000000000) } 
ENDSCRIPT

SCRIPT debug_menu_hide_hud 
	UnpauseGame 
	exit_pause_menu 
	hide_root_window 
ENDSCRIPT

SCRIPT create_test_menu 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	pause_menu_gradient off 
	dialog_box_exit 
	make_new_menu { 
		menu_id = debug_menu 
		vmenu_id = debug_vmenu 
		menu_title = "TEST" 
		type = VScrollingMenu 
		dims = PAIR(200.00000000000, 350.00000000000) 
		padding_scale = 0.94999998808 
		pos = PAIR(243.00000000000, 50.00000000000) 
	} 
	SetScreenElementProps { id = debug_menu 
		event_handlers = [ 
			{ pad_back create_pause_menu } 
		] 
	} 
	set_theme_icons 
	make_text_sub_menu_item text = "View Humans" id = menu_view_human_models pad_choose_script = launch_view_models_menu pad_choose_params = { model_set = human } 
	make_text_sub_menu_item text = "View Animals" id = menu_view_animal_models pad_choose_script = launch_view_models_menu pad_choose_params = { model_set = animal } 
	make_text_sub_menu_item text = "View Cars" id = menu_view_car_models pad_choose_script = launch_view_models_menu pad_choose_params = { model_set = car } 
	make_text_sub_menu_item text = "View Cutscenes" id = menu_view_cutscenes pad_choose_script = launch_view_cutscenes_menu 
	make_text_sub_menu_item text = "dialog box" id = menu_dialog pad_choose_script = create_test_dialog 
	make_text_sub_menu_item text = "Interface Themes" id = menu_themes pad_choose_script = swap_themes_menu 
	make_text_sub_menu_item text = "Scrolling Menu" id = menu_scroll pad_choose_script = test_scrolling_menu 
	make_text_sub_menu_item text = "Face Texture Test" id = menu_face_texture pad_choose_script = face_texture_test 
	make_text_sub_menu_item text = "View High Scores" id = menu_hs_displaye pad_choose_script = high_scores_menu_create pad_choose_params = { new_initials = "ABC" } 
	make_text_sub_menu_item text = "Keyboard" pad_choose_script = launch_keyboard 
	IF CareerLevelis LevelNum_Sch 
		make_text_sub_menu_item text = "Screensaver" pad_choose_script = screensaver 
	ENDIF 
	make_text_sub_menu_item text = "Done" id = menu_done pad_choose_script = create_pause_menu 
	RunScriptOnScreenElement id = current_menu_anchor animate_in params = { final_pos = PAIR(320.00000000000, 134.00000000000) } 
ENDSCRIPT

SCRIPT autorail_level 
	Autorail 
ENDSCRIPT

SCRIPT screensaver 
	spawnscript create_startup_menu 
	exit_pause_menu 
ENDSCRIPT

SCRIPT hole_check 
	checkforholes 
	create_pause_menu 
ENDSCRIPT

SCRIPT launch_toggle_profiler 
	ToggleMetrics 
	create_pause_menu 
ENDSCRIPT

SCRIPT launch_Dumpshots 
	Dumpshots 
	create_pause_menu 
ENDSCRIPT

SCRIPT toggle_rails 
	ToggleRails 
	pulse_item 
ENDSCRIPT

SCRIPT toggle_rigidbody 
	ToggleRigidBodyDebug 
	pulse_item 
ENDSCRIPT

SCRIPT toggle_wireframe 
	togglerendermode 
	show_all 
	pulse_item 
ENDSCRIPT

free_mem_on = 0 
SCRIPT show_free_mem 
	IF ( free_mem_on = 0 ) 
		change free_mem_on = 1 
		DoScreenElementMorph { 
			id = the_score_sprite 
			scale = 0 
		} 
		DoScreenElementMorph { 
			id = the_score 
			scale = 0 
		} 
		DoScreenElementMorph { 
			id = cash_goal_sprite 
			scale = 0 
		} 
		DoScreenElementMorph { 
			id = goal_points_text 
			scale = 0 
		} 
		DoScreenElementMorph { 
			id = cash_text 
			scale = 0 
		} 
		SetScreenElementLock id = root_window off 
		IF ObjectExists id = free_mem_anchor 
			DestroyScreenElement id = free_mem_anchor 
			wait 0.20000000298 seconds 
		ENDIF 
		CreateScreenElement { 
			type = ContainerElement 
			parent = root_window 
			id = free_mem_anchor 
			pos = PAIR(30.00000000000, 40.00000000000) 
			just = [ center center ] 
			internal_just = [ left center ] 
		} 
		CreateScreenElement { 
			type = TextElement 
			parent = free_mem_anchor 
			pos = PAIR(0.00000000000, -15.00000000000) 
			text = "Free Memory" 
			font = dialog 
			rgba = [ 60 60 100 100 ] 
			just = [ left center ] 
			scale = 0.80000001192 
		} 
		CreateScreenElement { 
			type = TextElement 
			parent = free_mem_anchor 
			id = topdown_heap_text 
			pos = PAIR(0.00000000000, 0.00000000000) 
			text = "" 
			font = dialog 
			rgba = [ 58 108 58 100 ] 
			just = [ left center ] 
			scale = 0.80000001192 
		} 
		CreateScreenElement { 
			type = TextElement 
			parent = free_mem_anchor 
			id = script_heap_text 
			pos = PAIR(0.00000000000, 15.00000000000) 
			text = "" 
			font = dialog 
			rgba = [ 58 108 58 100 ] 
			just = [ left center ] 
			scale = 0.80000001192 
		} 
		SetScreenElementLock id = root_window on 
		spawnscript RefreshFreeMemoryDisplay 
	ELSE 
		change free_mem_on = 0 
		KillSpawnedScript name = RefreshFreeMemoryDisplay 
		wait 0.20000000298 seconds 
		IF ObjectExists id = free_mem_anchor 
			DestroyScreenElement id = free_mem_anchor 
		ENDIF 
		DoScreenElementMorph { 
			id = the_score_sprite 
			scale = 1 
		} 
		DoScreenElementMorph { 
			id = the_score 
			scale = 1 
		} 
		DoScreenElementMorph { 
			id = cash_goal_sprite 
			scale = 1 
		} 
		DoScreenElementMorph { 
			id = goal_points_text 
			scale = 1 
		} 
		DoScreenElementMorph { 
			id = cash_text 
			scale = 1 
		} 
	ENDIF 
ENDSCRIPT

freemem_script_lowest = 999999999 
freemem_main_lowest = 999999999 
SCRIPT RefreshFreeMemoryDisplay interval = 1.00000000000 
	BEGIN 
		DisplayFreeMem 
		wait <interval> seconds 
	REPEAT 
ENDSCRIPT

SCRIPT UpdateDisplayFreeMemory 
	IF ObjectExists id = free_mem_anchor 
		FormatText ChecksumName = context_name "Script" 
		IF ( <id> = <context_name> ) 
			FormatText textname = script_heap "Script: %m (%nK) low: %o (%pK)" m = <free_mem> n = ( <free_mem> / 1024 ) o = min_free_mem p = ( <min_free_mem> / 1024 ) UseCommas 
			SetScreenElementProps id = script_heap_text text = <script_heap> 
		ENDIF 
		FormatText ChecksumName = context_name "Top Down" 
		IF ( <id> = <context_name> ) 
			FormatText textname = main_heap "Main: %m (%nK) low: %o (%pK)" m = <free_mem> n = ( <free_mem> / 1024 ) o = min_free_mem p = ( <min_free_mem> / 1024 ) UseCommas 
			SetScreenElementProps id = topdown_heap_text text = <main_heap> 
		ENDIF 
	ELSE 
		KillSpawnedScript id = RefreshFreeMemoryDisplay 
		change free_mem_on = 0 
	ENDIF 
ENDSCRIPT

SCRIPT toggle_show_all 
	show_all 
ENDSCRIPT

SCRIPT toggle_show_polys showscript = show_vert 
	<showscript> 
	pulse_item 
ENDSCRIPT

SCRIPT launch_keyboard 
	DestroyScreenElement id = current_menu_anchor 
	create_onscreen_keyboard 
ENDSCRIPT

SCRIPT launch_level_select_menu 
	change check_for_unplugged_controllers = 0 
	hide_current_goal 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	IF ScreenElementExists id = main_menu_bg_anchor 
		DestroyScreenElement id = main_menu_bg_anchor 
	ENDIF 
	IF NOT LevelIs load_skateshop 
		fadetoblack on id = fade_out_anchor create_script = create_chapter_fade_piece alpha = 1 time = 0.40000000596 
		wait 0.50000000000 seconds 
	ENDIF 
	load_level_select_textures_to_main_memory 
	SetMenuPadMappings [ active 
		use_as_first 
	] 
	create_level_select_menu <...> 
	change check_for_unplugged_controllers = 1 
ENDSCRIPT

SCRIPT create_level_select_menu pad_back_script = level_select_menu_exit 
	printf "create_level_select_menu PARAMETERS = " 
	IF InNetGame 
		show_warning = show_warning 
	ENDIF 
	SetScreenElementLock id = root_window off 
	pulse_blur 
	FormatText ChecksumName = highlight_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	IF ( in_server_options = 1 ) 
		from_server_options = from_server_options 
		net_pad_back = 0 
		pad_back_script = network_level_select_pad_back 
	ELSE 
		RemoveParameter from_server_options 
	ENDIF 
	IF NOT GotParam no_cam_anim 
	ENDIF 
	CreateScreenElement { 
		type = ContainerElement 
		parent = root_window 
		id = level_select_anchor 
		dims = PAIR(640.00000000000, 480.00000000000) 
		pos = PAIR(320.00000000000, 240.00000000000) 
	} 
	AssignAlias id = level_select_anchor alias = current_menu_anchor 
	create_helper_text generic_helper_text 
	kill_start_key_binding 
	GoalManager_HidePoints 
	hide_current_goal 
	FormatText ChecksumName = title_icon "%i_level" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	build_theme_sub_title title = "LEVEL SELECT" title_icon = <title_icon> right_bracket_z = 4 static 
	FormatText ChecksumName = paused_icon "%i_paused_icon" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	build_theme_box_icons icon_texture = <paused_icon> static 
	build_top_bar pos = PAIR(-400.00000000000, 62.00000000000) z_priority = 4 static 
	build_top_and_bottom_blocks top_z = 3 static 
	build_level_select_map 
	level_select_create_menu_block pad_back_script = <pad_back_script> <...> 
	IF IsTrue Demo_Build 
		ForEachIn e3_level_select_menu_level_info do = level_select_menu_add_item params = <...> 
	ELSE 
		RemoveParameter text 
		RemoveParameter name 
		ForEachIn level_select_menu_level_info do = level_select_menu_add_item params = <...> 
	ENDIF 
	DoScreenElementMorph id = level_select_anchor_middle pos = PAIR(320.00000000000, 640.00000000000) 
	IF GotParam from_server_options 
		level_select_vmenu : SetTags from_server_options 
	ENDIF 
	FireEvent type = focus target = level_select_vmenu 
	spawnscript chap_moving_bg 
	SetButtonEventMappings block_menu_input 
	wait 3 gameframes 
	SetScreenElementProps id = level_select_scrolling_menu reset_window_top 
	PlaySound DE_MenuFlyUp vol = 100 
	PlaySound DE_PauseFlyIn vol = 100 
	DoScreenElementMorph id = top_bar_anchor time = 0.20000000298 pos = PAIR(0.00000000000, 62.00000000000) 
	DoScreenElementMorph id = level_select_anchor_middle pos = PAIR(320.00000000000, 240.00000000000) time = 0.20000000298 
	DoScreenElementMorph id = level_select_map_anchor time = 0.30000001192 alpha = 1.00000000000 
	IF NOT LevelIs load_skateshop 
		spawnscript fadetoblack params = { off id = fade_out_anchor } 
		pause_menu_gradient off 
	ENDIF 
	wait 0.20000000298 seconds 
	SetButtonEventMappings unblock_menu_input 
ENDSCRIPT

SCRIPT level_select_create_menu_block 
	IF ObjectExists id = level_select_anchor_middle 
		DestroyScreenElement id = level_select_anchor_middle 
	ENDIF 
	CreateScreenElement { 
		type = ContainerElement 
		parent = level_select_anchor 
		id = level_select_anchor_middle 
		dims = PAIR(640.00000000000, 480.00000000000) 
		pos = PAIR(320.00000000000, 240.00000000000) 
	} 
	CreateScreenElement { 
		type = VScrollingMenu 
		parent = level_select_anchor_middle 
		id = level_select_scrolling_menu 
		pos = PAIR(480.00000000000, 120.00000000000) 
		just = [ left top ] 
		dims = PAIR(300.00000000000, 203.00000000000) 
	} 
	theme_background parent = level_select_scrolling_menu width = 1.50000000000 pos = PAIR(0.00000000000, -15.00000000000) num_parts = 7.09999990463 z_priority = 1 dark_menu = dark_menu static = static 
	IF NOT GameModeEquals is_career 
		get_num_levels_unlocked 
		IF NOT ( all_levels_unlocked = 1 ) 
			IF NOT ( <num_unlocked> = 12 ) 
				FormatText ChecksumName = unhighlight_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
				GetStackedScreenElementPos X id = bg_box_vmenu 
				CreateScreenElement { 
					type = ContainerElement 
					parent = bg_box_vmenu 
					pos = <pos> 
				} 
				CreateScreenElement { 
					type = TextBlockElement 
					parent = <id> 
					text = "Play \\c1Story Mode\\c0 to unlock more levels!" 
					dims = PAIR(300.00000000000, 0.00000000000) 
					allow_expansion 
					pos = PAIR(0.00000000000, -20.00000000000) 
					line_spacing = 0.69999998808 
					font = dialog 
					rgba = <unhighlight_rgba> 
					just = [ center top ] 
					scale = 0.80000001192 
					z_priority = 4 
				} 
			ENDIF 
		ENDIF 
	ENDIF 
	CreateScreenElement { 
		type = VMenu 
		parent = level_select_scrolling_menu 
		id = level_select_vmenu 
		just = [ left top ] 
		internal_just = [ left center ] 
		event_handlers = [ { pad_back generic_menu_pad_back params = { callback = <pad_back_script> <...> } } 
			{ pad_up generic_menu_up_or_down_sound params = { up } } 
			{ pad_down generic_menu_up_or_down_sound params = { down } } 
			{ pad_back generic_menu_pad_back_sound } 
		] 
		padding_scale = 0.89999997616 
		replace_handlers 
	} 
	AssignAlias id = level_select_vmenu alias = current_menu 
	IF GameModeEquals is_career 
		goals_title_rgba = [ 88 105 112 128 ] 
	ELSE 
		goals_title_rgba = [ 0 0 0 0 ] 
	ENDIF 
ENDSCRIPT

SCRIPT get_num_levels_unlocked 
	GetArraySize level_select_menu_level_info 
	<num_unlocked> = 0 
	<index> = 0 
	BEGIN 
		IF NOT ( ( ( level_select_menu_level_info [ <index> ] ) . level ) = load_sk5ed_gameplay ) 
			IF NOT ( ( ( level_select_menu_level_info [ <index> ] ) . level ) = load_TestLevel ) 
				IF NOT ( ( ( level_select_menu_level_info [ <index> ] ) . level ) = load_Default ) 
					IF NOT StructureContains structure = ( ( level_select_menu_level_info [ <index> ] ) ) DEVKIT_ONLY 
						<level_num> = ( ( level_select_menu_level_info [ <index> ] ) . level_num ) 
						IF GetGlobalFlag flag = ( ( level_select_menu_level_info [ <index> ] ) . flag ) 
							<num_unlocked> = ( <num_unlocked> + 1 ) 
						ENDIF 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
		<index> = ( <index> + 1 ) 
	REPEAT ( <array_size> ) 
	RETURN num_unlocked = <num_unlocked> 
ENDSCRIPT

SCRIPT level_select_menu_add_item highlight_bar_pos = PAIR(0.00000000000, 10.00000000000) highlight_bar_scale = PAIR(1.60000002384, 0.69999998808) created_park_number = 11 
	IF ( ( GameModeEquals is_career ) & ( <level_num> = <created_park_number> ) ) 
		RETURN 
	ENDIF 
	IF CD 
		IF ( <level_num> = 30 ) 
			RETURN 
		ENDIF 
	ENDIF 
	IF ( DEVKIT_LEVELS = 0 ) 
		IF GotParam DEVKIT_ONLY 
			RETURN 
		ENDIF 
	ENDIF 
	IF GameModeEquals is_creategoals 
		CountNumCreatedGoalsWon level = <level> 
		IF ( <num_goals> ) 
			FormatText textname = text "%s  %d/%e" s = <text> d = <num_goals_won> e = <num_goals> 
		ENDIF 
	ENDIF 
	IF ( in_server_options = 1 ) 
		GetPreferenceChecksum pref_type = network goals 
		IF ( <checksum> = goals_created ) 
			CountNumCreatedGoalsWon level = <level> 
			IF ( <num_goals> ) 
				FormatText textname = text "%s  (%e)" s = <text> e = <num_goals> 
			ENDIF 
		ENDIF 
	ELSE 
		IF InNetGame 
			GetPreferenceChecksum pref_type = network goals 
			IF ( <checksum> = goals_created ) 
				CountNumCreatedGoalsWon level = <level> 
				IF ( <num_goals> ) 
					FormatText textname = text "%s  (%e)" s = <text> e = <num_goals> 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
	IF ( ( <level_num> = <created_park_number> ) | ( <level_num> = ( <created_park_number> + 4 ) ) ) 
		CreateScreenElement { 
			type = ContainerElement 
			parent = current_menu 
			dims = PAIR(256.00000000000, 22.00000000000) 
			not_focusable 
		} 
		CreateScreenElement { 
			type = SpriteElement 
			parent = <id> 
			texture = black 
			scale = PAIR(50.00000000000, 1.00000000000) 
			rgba = [ 0 0 0 80 ] 
			pos = PAIR(0.00000000000, 10.00000000000) 
			just = [ center center ] 
		} 
	ENDIF 
	FormatText ChecksumName = unhighlighted_color "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	<can_afford_level> = 0 
	<in_locked_group> = 0 
	IF IntegerEquals a = all_levels_unlocked b = 1 
		<rgba> = <unhighlighted_color> 
		alpha = 1.00000000000 
		IF ( <level_num> = <created_park_number> ) 
			<pad_choose_script> = level_select_created_park_menu 
		ELSE 
			IF ( in_server_options = 1 ) 
				<pad_choose_script> = level_select_menu_exit 
			ELSE 
				<pad_choose_script> = level_select_change_level 
			ENDIF 
		ENDIF 
		<pad_choose_params> = <...> 
		<locked> = 0 
	ELSE 
		IF GetGlobalFlag flag = <flag> 
			printf <flag> 
			<rgba> = <unhighlighted_color> 
			alpha = 1.00000000000 
			IF ( <level_num> = <created_park_number> ) 
				<pad_choose_script> = level_select_created_park_menu 
			ELSE 
				IF ( in_server_options = 1 ) 
					<pad_choose_script> = level_select_menu_exit 
				ELSE 
					<pad_choose_script> = level_select_change_level 
				ENDIF 
			ENDIF 
			<pad_choose_params> = <...> 
			<locked> = 0 
		ELSE 
			<rgba> = [ 47 42 38 128 ] 
			alpha = 0.50000000000 
			not_focusable = not_focusable 
			text = "??????????" 
			<pad_choose_script> = level_select_invalid_choice 
			<locked> = 1 
		ENDIF 
	ENDIF 
	CreateScreenElement { 
		type = ContainerElement 
		parent = current_menu 
		id = <level> 
		dims = PAIR(256.00000000000, 20.00000000000) 
		event_handlers = [ { pad_choose generic_menu_pad_choose_sound } 
			{ pad_start generic_menu_pad_choose_sound } 
			{ pad_choose <pad_choose_script> params = <pad_choose_params> } 
			{ pad_start <pad_choose_script> params = <pad_choose_params> } 
			{ focus level_select_menu_focus params = { level_num = <level_num> text_alpha = <alpha> highlighted_text_rgba = <highlight_rgba> } } 
			{ unfocus level_select_menu_unfocus params = { level_num = <level_num> text_rgba = <rgba> text_alpha = <alpha> } } 
		] 
		replace_handlers 
		<not_focusable> 
	} 
	CreateScreenElement { 
		type = TextElement 
		parent = <id> 
		font = small 
		just = [ center top ] 
		text = <text> 
		rgba = <rgba> 
		alpha = <alpha> 
		z_priority = 4 
	} 
	highlight_angle = RANDOM_NO_REPEAT(1, 1, 1, 1, 1, 1, 1, 1, 1, 1) RANDOMCASE 2 RANDOMCASE -2 RANDOMCASE 3 RANDOMCASE -3 RANDOMCASE 3.50000000000 RANDOMCASE -3 RANDOMCASE 5 RANDOMCASE -4 RANDOMCASE 2.50000000000 RANDOMCASE -4.50000000000 RANDOMEND 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <level> 
		texture = DE_highlight_bar 
		pos = <highlight_bar_pos> 
		rgba = [ 0 0 0 0 ] 
		just = [ center center ] 
		scale = <highlight_bar_scale> 
		z_priority = 2 
		rot_angle = <highlight_angle> 
	} 
	IF GotParam cross_it_out 
		CreateScreenElement { 
			type = SpriteElement 
			parent = <anchor_id> 
			texture = streak_2 
			pos = <highlight_bar_pos> 
			rgba = <line_rgba> 
			just = [ center center ] 
			scale = <highlight_bar_scale> 
			z_priority = 2 
			rot_angle = <highlight_angle> 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT build_level_select_map map_rgba = [ 108 113 128 30 ] pos = PAIR(-30.00000000000, 240.00000000000) map_scale = PAIR(1.00000000000, 1.10000002384) 
	IF GotParam other_pos 
		pos = PAIR(320.00000000000, 240.00000000000) 
	ENDIF 
	FormatText ChecksumName = color1 "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	color2 = ( <color1> ) 
	SetArrayElement arrayname = color2 index = 3 newvalue = 80 
	dot_rgba = [ 128 128 128 128 ] 
	secret_dot_rgba = [ 20 20 90 128 ] 
	CreateScreenElement { 
		type = SpriteElement 
		parent = current_menu_anchor 
		id = blue_bg 
		texture = chapter_bg 
		rgba = [ 17 36 47 128 ] 
		just = [ left top ] 
		pos = PAIR(0.00000000000, 100.00000000000) 
		scale = PAIR(6.50000000000, 3.00000000000) 
		z_priority = -5 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = current_menu_anchor 
		id = black_bg 
		texture = black 
		rgba = [ 27 46 57 128 ] 
		just = [ left top ] 
		pos = PAIR(450.00000000000, 100.00000000000) 
		scale = PAIR(60.00000000000, 80.00000000000) 
		z_priority = -6 
	} 
	CreateScreenElement { 
		type = ContainerElement 
		parent = current_menu_anchor 
		id = level_select_map_anchor 
		pos = <pos> 
		dims = PAIR(640.00000000000, 480.00000000000) 
		alpha = 0 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = level_select_map_anchor 
		id = moving_bg 
		texture = bg_elements 
		rgba = <color2> 
		just = [ left top ] 
		pos = PAIR(0.00000000000, 70.00000000000) 
		scale = PAIR(8.00000000000, 4.00000000000) 
		z_priority = -4 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = level_select_map_anchor 
		id = map_piece_1 
		texture = map_graphic_1 
		rgba = <map_rgba> 
		just = [ left top ] 
		pos = PAIR(0.00000000000, 100.00000000000) 
		scale = <map_scale> 
		z_priority = -3 
	} 
	GetStackedScreenElementPos X id = <id> 
	CreateScreenElement { 
		type = SpriteElement 
		parent = level_select_map_anchor 
		texture = map_graphic_2 
		rgba = <map_rgba> 
		just = [ left top ] 
		pos = <pos> 
		scale = <map_scale> 
		z_priority = -3 
	} 
	GetStackedScreenElementPos X id = <id> 
	CreateScreenElement { 
		type = SpriteElement 
		parent = level_select_map_anchor 
		id = map_piece_3 
		texture = map_graphic_3 
		rgba = <map_rgba> 
		just = [ left top ] 
		pos = <pos> 
		scale = <map_scale> 
		z_priority = -3 
	} 
	GetStackedScreenElementPos Y id = <id> 
	CreateScreenElement { 
		type = SpriteElement 
		parent = level_select_map_anchor 
		texture = map_graphic_4 
		rgba = <map_rgba> 
		just = [ left top ] 
		pos = <pos> 
		scale = <map_scale> 
		z_priority = -3 
	} 
	GetStackedScreenElementPos X id = <id> offset = PAIR(30.00000000000, -20.00000000000) 
	CreateScreenElement { 
		type = SpriteElement 
		parent = level_select_map_anchor 
		texture = map_graphic_6 
		rgba = <map_rgba> 
		just = [ left top ] 
		pos = <pos> 
		scale = <map_scale> 
		z_priority = -3 
	} 
	GetStackedScreenElementPos X id = map_piece_3 offset = PAIR(30.00000000000, 50.00000000000) 
	CreateScreenElement { 
		type = SpriteElement 
		parent = level_select_map_anchor 
		texture = map_graphic_5 
		rgba = <map_rgba> 
		just = [ left top ] 
		pos = <pos> 
		scale = <map_scale> 
		z_priority = -3 
	} 
	GetStackedScreenElementPos X id = <id> offset = PAIR(0.00000000000, -50.00000000000) 
	CreateScreenElement { 
		type = SpriteElement 
		parent = level_select_map_anchor 
		texture = map_graphic_1 
		rgba = <map_rgba> 
		just = [ left top ] 
		pos = <pos> 
		scale = <map_scale> 
		z_priority = -3 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = level_select_map_anchor 
		id = dot_1 
		texture = level_dot 
		rgba = <dot_rgba> 
		just = [ center center ] 
		pos = PAIR(554.00000000000, 190.00000000000) 
		scale = 1 
		z_priority = -2 
	} 
	IF ( ( GetGlobalFlag flag = LEVEL_UNLOCKED_NY ) | ( IntegerEquals a = all_levels_unlocked b = 1 ) ) 
		CreateScreenElement { 
			type = SpriteElement 
			parent = level_select_map_anchor 
			id = dot_2 
			texture = level_dot 
			rgba = <dot_rgba> 
			just = [ center center ] 
			pos = PAIR(540.00000000000, 200.00000000000) 
			scale = 1 
			z_priority = -1 
		} 
	ENDIF 
	IF ( ( GetGlobalFlag flag = LEVEL_UNLOCKED_FL ) | ( IntegerEquals a = all_levels_unlocked b = 1 ) ) 
		CreateScreenElement { 
			type = SpriteElement 
			parent = level_select_map_anchor 
			id = dot_3 
			texture = level_dot 
			rgba = <dot_rgba> 
			just = [ center center ] 
			pos = PAIR(532.00000000000, 228.00000000000) 
			scale = 1 
			z_priority = -2 
		} 
	ENDIF 
	IF ( ( GetGlobalFlag flag = LEVEL_UNLOCKED_SD ) | ( IntegerEquals a = all_levels_unlocked b = 1 ) ) 
		CreateScreenElement { 
			type = SpriteElement 
			parent = level_select_map_anchor 
			id = dot_4 
			texture = level_dot 
			rgba = <dot_rgba> 
			just = [ center center ] 
			pos = PAIR(472.00000000000, 223.00000000000) 
			scale = 1 
			z_priority = -2 
		} 
	ENDIF 
	IF ( ( GetGlobalFlag flag = LEVEL_UNLOCKED_HI ) | ( IntegerEquals a = all_levels_unlocked b = 1 ) ) 
		CreateScreenElement { 
			type = SpriteElement 
			parent = level_select_map_anchor 
			id = dot_5 
			texture = level_dot 
			rgba = <dot_rgba> 
			just = [ center center ] 
			pos = PAIR(405.00000000000, 220.00000000000) 
			scale = 1 
			z_priority = -2 
		} 
	ENDIF 
	IF ( ( GetGlobalFlag flag = LEVEL_UNLOCKED_VC ) | ( IntegerEquals a = all_levels_unlocked b = 1 ) ) 
		CreateScreenElement { 
			type = SpriteElement 
			parent = level_select_map_anchor 
			id = dot_6 
			texture = level_dot 
			rgba = <dot_rgba> 
			just = [ center center ] 
			pos = PAIR(455.00000000000, 173.00000000000) 
			scale = 1 
			z_priority = -2 
		} 
	ENDIF 
	IF ( ( GetGlobalFlag flag = LEVEL_UNLOCKED_RU ) | ( IntegerEquals a = all_levels_unlocked b = 1 ) ) 
		CreateScreenElement { 
			type = SpriteElement 
			parent = level_select_map_anchor 
			id = dot_8 
			texture = level_dot 
			rgba = <dot_rgba> 
			just = [ center center ] 
			pos = PAIR(78.00000000000, 160.00000000000) 
			scale = 1 
			z_priority = -2 
		} 
		CreateScreenElement { 
			type = SpriteElement 
			parent = level_select_map_anchor 
			id = dot_82 
			texture = level_dot 
			rgba = <dot_rgba> 
			just = [ center center ] 
			pos = PAIR(813.00000000000, 160.00000000000) 
			scale = 1 
			z_priority = -2 
		} 
	ENDIF 
	IF ( ( GetGlobalFlag flag = LEVEL_UNLOCKED_AU ) | ( IntegerEquals a = all_levels_unlocked b = 1 ) ) 
		CreateScreenElement { 
			type = SpriteElement 
			parent = level_select_map_anchor 
			id = dot_9 
			texture = level_dot 
			rgba = <dot_rgba> 
			just = [ center center ] 
			pos = PAIR(290.00000000000, 350.00000000000) 
			scale = 1 
			z_priority = -2 
		} 
	ENDIF 
	IF ( ( GetGlobalFlag flag = LEVEL_UNLOCKED_SE ) | ( IntegerEquals a = all_levels_unlocked b = 1 ) ) 
		CreateScreenElement { 
			type = SpriteElement 
			parent = level_select_map_anchor 
			id = dot_10 
			texture = level_dot 
			rgba = <dot_rgba> 
			just = [ center center ] 
			pos = PAIR(290.00000000000, 350.00000000000) 
			scale = 1 
			z_priority = -2 
		} 
	ENDIF 
	IF ( ( GetGlobalFlag flag = LEVEL_UNLOCKED_VN ) | ( IntegerEquals a = all_levels_unlocked b = 1 ) ) 
		CreateScreenElement { 
			type = SpriteElement 
			parent = level_select_map_anchor 
			id = dot_16 
			texture = secret_level_dot 
			rgba = <secret_dot_rgba> 
			just = [ center center ] 
			pos = PAIR(467.00000000000, 213.00000000000) 
			scale = 1 
			z_priority = -0.50000000000 
		} 
	ENDIF 
	IF ( ( GetGlobalFlag flag = LEVEL_UNLOCKED_HN ) | ( IntegerEquals a = all_levels_unlocked b = 1 ) ) 
		CreateScreenElement { 
			type = SpriteElement 
			parent = level_select_map_anchor 
			id = dot_17 
			texture = secret_level_dot 
			rgba = <secret_dot_rgba> 
			just = [ center center ] 
			pos = PAIR(492.00000000000, 183.00000000000) 
			scale = 1 
			z_priority = -0.50000000000 
		} 
	ENDIF 
	IF ( ( GetGlobalFlag flag = LEVEL_UNLOCKED_SC2 ) | ( IntegerEquals a = all_levels_unlocked b = 1 ) ) 
		CreateScreenElement { 
			type = SpriteElement 
			parent = level_select_map_anchor 
			id = dot_15 
			texture = secret_level_dot 
			rgba = <secret_dot_rgba> 
			just = [ center center ] 
			pos = PAIR(478.00000000000, 215.00000000000) 
			scale = 1 
			z_priority = -0.50000000000 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT level_select_scroll_map time = 0.44999998808 new_x = -30 
	wait 4 gameframes 
	IF NOT ScreenElementExists id = level_select_map_anchor 
		RETURN 
	ENDIF 
	IF GotParam other_pos 
		new_x = 320 
	ENDIF 
	GetScreenElementProps id = level_select_map_anchor 
	one = 1 
	current_x = ( <pos> . PAIR(1.00000000000, 0.00000000000) ) 
	dif_x = ( <new_x> - <current_x> ) 
	IF ( 0 > <dif_x> ) 
		dif_x = ( -1 * <dif_x> ) 
	ENDIF 
	time = ( <time> * ( <dif_x> / 350 ) ) 
	IF GotParam other_pos 
		DoScreenElementMorph id = level_select_map_anchor pos = PAIR(320.00000000000, 240.00000000000) time = <time> 
	ELSE 
		DoScreenElementMorph id = level_select_map_anchor pos = PAIR(-30.00000000000, 240.00000000000) time = <time> 
	ENDIF 
ENDSCRIPT

SCRIPT network_level_select_pad_back 
	<net_pad_back> = 1 
	level_select_menu_exit <...> 
ENDSCRIPT

SCRIPT level_select_menu_exit 
	KillSpawnedScript name = level_select_scroll_map 
	KillSpawnedScript name = chap_moving_bg 
	KillSpawnedScript name = Level_Select_draw_line 
	KillSpawnedScript name = Level_Select_star_effect 
	kill_level_select_cams 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
		load_level_select_textures_to_main_memory unload 
	ENDIF 
	IF GotParam no_new_menu 
		unhide_current_goal 
		RETURN 
	ENDIF 
	IF LevelIs load_skateshop 
		GoalManager_HideGoalPoints 
		IF ( in_server_options = 1 ) 
			IF ( <net_pad_back> = 0 ) 
				prefs = network 
				field = "level" 
				string = <text> 
				checksum = <level> 
				select_host_option <...> 
			ENDIF 
			IF ObjectExists id = host_options_menu 
				DestroyScreenElement id = host_options_menu 
			ENDIF 
			KillSkaterCamAnim all 
			PlaySkaterCamAnim name = SS_MenuCam play_hold 
			create_network_host_options_menu 
		ELSE 
			launch_ss_menu <...> no_animate 
		ENDIF 
	ELSE 
		IF GotParam end_run 
			create_end_run_menu 
		ELSE 
			GoalManager_ShowPoints 
			IF GoalManager_HasActiveGoals 
				GoalManager_HideGoalPoints 
				IF ScreenElementExists id = current_goal 
					DoScreenElementMorph { 
						id = current_goal 
						restore_alpha 
					} 
				ENDIF 
				IF ScreenElementExists id = current_goal_key_combo_text 
					DoScreenElementMorph { 
						id = current_goal_key_combo_text 
						restore_alpha 
					} 
				ENDIF 
			ELSE 
				GoalManager_ShowGoalPoints 
			ENDIF 
			create_pause_menu 
		ENDIF 
	ENDIF 
ENDSCRIPT

hidden_level_dot = 0 
SCRIPT level_select_menu_focus 
	GetTags 
	GetScreenElementProps id = <id> 
	menu_item_pos = <pos> 
	KillSpawnedScript Level_Select_star_effect 
	IF ( ( <level_num> = 8 ) | ( <level_num> = 9 ) | ( <level_num> = 10 ) | ( <level_num> = 13 ) ) 
		KillSpawnedScript name = level_select_scroll_map 
		spawnscript level_select_scroll_map params = { other_pos } 
	ELSE 
		KillSpawnedScript name = level_select_scroll_map 
		spawnscript level_select_scroll_map 
	ENDIF 
	IF ( <level_num> > 10 & 18 > <level_num> ) 
		star_rgba = [ 20 20 100 128 ] 
	ELSE 
		FormatText ChecksumName = star_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	ENDIF 
	FormatText ChecksumName = current_level_dot_id "dot_%i" i = <level_num> 
	IF ( <level_num> = 7 ) 
		current_level_dot_id = dot_6 
	ENDIF 
	IF ( <level_num> = 8 ) 
		DoScreenElementMorph id = dot_6 alpha = 1 time = 0.10000000149 
	ENDIF 
	IF ScreenElementExists id = selected_level_star 
		KillSpawnedScript name = Level_Select_star_effect 
		DestroyScreenElement id = selected_level_star 
		IF ScreenElementExists id = selected_level_star2 
			DestroyScreenElement id = selected_level_star2 
		ENDIF 
	ENDIF 
	IF ScreenElementExists id = selected_level_line 
		KillSpawnedScript name = Level_Select_draw_line 
		DestroyScreenElement id = selected_level_line 
	ENDIF 
	IF ScreenElementExists id = <current_level_dot_id> 
		GetScreenElementProps id = <current_level_dot_id> 
		SetScreenElementLock off id = level_select_map_anchor 
		CreateScreenElement { 
			type = SpriteElement 
			parent = level_select_map_anchor 
			id = selected_level_star 
			texture = level_selected_dot 
			rgba = <star_rgba> 
			just = [ center center ] 
			pos = <pos> 
			scale = 0 
			z_priority = 0 
		} 
		DoScreenElementMorph id = <current_level_dot_id> alpha = 0 
		change hidden_level_dot = <level_num> 
		DoScreenElementMorph id = selected_level_star scale = 0.80000001192 rot_angle = 0 time = 0.25000000000 
		spawnscript Level_Select_draw_line params = { star_rgba = <star_rgba> menu_item_pos = <menu_item_pos> star_pos = <pos> } 
		RunScriptOnScreenElement id = selected_level_star Level_Select_star_effect params = { star_rgba = <star_rgba> menu_item_pos = <menu_item_pos> star_pos = <pos> } 
	ENDIF 
	main_theme_focus <...> 
ENDSCRIPT

SCRIPT Level_Select_draw_line 
	IF ScreenElementExists id = selected_level_line 
		KillSpawnedScript name = Level_Select_draw_line 
		DestroyScreenElement id = selected_level_line 
	ENDIF 
	SetScreenElementLock off id = level_select_map_anchor 
	CreateScreenElement { 
		type = SpriteElement 
		parent = level_select_map_anchor 
		id = selected_level_line 
		texture = streak_2 
		rgba = <star_rgba> 
		just = [ left center ] 
		pos = PAIR(0.00000000000, 0.00000000000) 
		scale = 1 
		z_priority = 3 
		rot_angle = 0 
		alpha = 0 
	} 
	wait 1 gameframe 
	IF NOT ScreenElementExists id = level_select_map_anchor 
		RETURN 
	ENDIF 
	BEGIN 
		GetScreenElementProps id = level_select_map_anchor 
		map_anchor_pos = <pos> 
		star_absolute_pos = ( <star_pos> + <map_anchor_pos> ) 
		GetScreenElementProps id = level_select_anchor_middle 
		middle_anchor_pos = <pos> 
		GetScreenElementProps id = level_select_scrolling_menu 
		scrolling_menu_pos = <pos> 
		GetScreenElementProps id = level_select_vmenu 
		vmenu_pos = <pos> 
		item_absolute_pos = ( <middle_anchor_pos> + <scrolling_menu_pos> + <vmenu_pos> + <menu_item_pos> ) 
		relative_pos = ( <item_absolute_pos> - <star_absolute_pos> ) 
		rel_x = ( <relative_pos> . PAIR(1.00000000000, 0.00000000000) ) 
		rel_y = ( <relative_pos> . PAIR(0.00000000000, 1.00000000000) ) 
		IF NOT ( <rel_x> = 0 ) 
			atan ( <rel_y> / <rel_x> ) 
			line_angle = ( ( <atan> * 1 ) ) 
			sin ( <atan> ) 
			line_length = ( <rel_y> / <sin> ) 
			line_scale = ( ( <line_length> / 64 ) * PAIR(1.00000000000, 0.00000000000) + PAIR(0.00000000000, 1.00000000000) ) 
			DoScreenElementMorph { 
				id = selected_level_line 
				pos = <star_pos> 
				scale = <line_scale> 
				rot_angle = <line_angle> 
				alpha = 0.60000002384 
			} 
		ENDIF 
		wait 1 gameframe 
	REPEAT 
ENDSCRIPT

SCRIPT Level_Select_star_effect 
	wait 0.25000000000 seconds 
	SetScreenElementLock off id = level_select_map_anchor 
	CreateScreenElement { 
		type = SpriteElement 
		parent = level_select_map_anchor 
		id = selected_level_star2 
		texture = level_selected_dot 
		rgba = <star_rgba> 
		just = [ center center ] 
		pos = <star_pos> 
		scale = 0.80000001192 
		z_priority = 0 
		alpha = 0.40000000596 
	} 
	BEGIN 
		DoScreenElementMorph id = selected_level_star2 scale = 3.00000000000 alpha = 0 time = 0.50000000000 
		wait 0.50000000000 seconds 
		DoScreenElementMorph id = selected_level_star2 scale = 0.80000001192 alpha = 0.40000000596 
		wait 0.50000000000 seconds 
	REPEAT 
ENDSCRIPT

SCRIPT level_select_menu_unfocus 
	GetTags 
	FormatText ChecksumName = hidden_dot "dot_%i" i = hidden_level_dot 
	IF ScreenElementExists id = <hidden_dot> 
		DoScreenElementMorph id = <hidden_dot> alpha = 1 time = 0.10000000149 
		change hidden_level_dot = 0 
	ENDIF 
	main_theme_unfocus <...> 
ENDSCRIPT

created_park_warning = 0 
SCRIPT level_select_created_park_menu 
	make_new_skateshop_menu { 
		parent = level_select_anchor_middle 
		pos = PAIR(620.00000000000, 125.00000000000) 
		internal_just = [ left center ] 
		menu_id = created_park_menu 
		vmenu_id = created_park_vmenu 
		menu_title = "" 
	} 
	DoScreenElementMorph id = created_park_menu pos = PAIR(520.00000000000, 240.00000000000) time = 0.10000000149 
	theme_background parent = created_park_menu id = created_park_bg width = 1.50000000000 pos = PAIR(710.00000000000, 106.00000000000) num_parts = 3 z_priority = 1 dark_menu = dark_menu static = static 
	kill_start_key_binding 
	IF GotParam show_warning 
		change created_park_warning = 1 
	ENDIF 
	GetCustomParkName 
	IF ( <name> = "" ) 
		<name> = "unnamed park" 
	ENDIF 
	CreateScreenElement { 
		type = TextElement 
		parent = created_park_menu 
		pos = PAIR(710.00000000000, 110.00000000000) 
		font = dialog 
		text = <name> 
		just = [ center top ] 
		scale = 1 
		rgba = [ 128 128 128 80 ] 
		not_focusable 
		z_priority = 2 
	} 
	truncate_string id = <id> max_width = 200 
	CreateScreenElement { 
		type = SpriteElement 
		parent = created_park_menu 
		texture = black 
		pos = PAIR(710.00000000000, 109.00000000000) 
		rgba = [ 0 0 0 60 ] 
		scale = PAIR(52.00000000000, 7.00000000000) 
		just = [ center top ] 
		z_priority = 2 
	} 
	SetScreenElementProps { 
		id = created_park_vmenu 
		event_handlers = [ 
			{ pad_back generic_menu_pad_back_sound } 
			{ pad_back level_select_created_park_menu_exit params = { from_server_options = <from_server_options> } } 
		] 
		replace_handlers 
	} 
	IF GotParam from_server_options 
		created_park_menu_add_item { text = #"Play Park" 
			id = created_park_play_park 
			pad_choose_script = created_park_launch 
			pad_choose_params = { from_server_options } 
		} 
	ELSE 
		created_park_menu_add_item { text = #"Play Park" 
			id = created_park_play_park 
			pad_choose_script = created_park_launch 
			pad_choose_params = { } 
		} 
	ENDIF 
	IF GotParam from_server_options 
		created_park_menu_add_item { text = #"Load Park" 
			id = created_park_load_park 
			pad_choose_script = confirm_load_park 
			pad_choose_params = { load_park from_server_options } 
		} 
	ELSE 
		created_park_menu_add_item { text = #"Load Park" 
			id = created_park_load_park 
			pad_choose_script = confirm_load_park 
			pad_choose_params = { load_park } 
		} 
	ENDIF 
	IF GotParam from_server_options 
		created_park_menu_add_item { text = #"Pre-Made Parks" 
			id = created_park_premade 
			pad_choose_script = level_select_created_park_menu_exit 
			pad_choose_params = { park_list from_server_options } 
		} 
	ELSE 
		created_park_menu_add_item { text = #"Pre-Made Parks" 
			id = created_park_premade 
			pad_choose_script = level_select_created_park_menu_exit 
			pad_choose_params = { park_list } 
		} 
	ENDIF 
	created_park_menu_add_item { text = #"back" 
		id = created_park_back 
		pad_choose_script = level_select_created_park_menu_exit 
		pad_choose_params = { } 
	} 
	FireEvent type = unfocus target = level_select_vmenu 
	FireEvent type = focus target = created_park_vmenu 
	SetButtonEventMappings block_menu_input 
	DoScreenElementMorph id = created_park_menu pos = PAIR(320.00000000000, 240.00000000000) time = 0.15000000596 
	wait 0.10000000149 seconds 
	DoScreenElementMorph id = level_select_anchor_middle pos = PAIR(85.00000000000, 240.00000000000) time = 0.15000000596 
	SetButtonEventMappings unblock_menu_input 
	SetScreenElementProps id = title_text text = "CREATED PARKS" 
ENDSCRIPT

SCRIPT created_park_menu_add_item 
	highlight_bar_scale = PAIR(1.60000002384, 0.69999998808) 
	centered = centered 
	no_bg = no_bg 
	theme_menu_add_item <...> 
ENDSCRIPT

SCRIPT created_park_launch 
	IF ( in_server_options = 1 ) 
		GetParkEditorMaxPlayers 
		GetNetworkNumPlayers 
		IF InNetGame 
			IF ( <num_players> > <MaxPlayers> ) 
				level_select_created_park_menu_exit from_server_options 
				KillSpawnedScript name = level_select_scroll_map 
				KillSpawnedScript name = chap_moving_bg 
				KillSpawnedScript name = Level_Select_draw_line 
				KillSpawnedScript name = Level_Select_star_effect 
				IF ObjectExists id = current_menu_anchor 
					DestroyScreenElement id = current_menu_anchor 
				ENDIF 
				load_level_select_textures_to_main_memory unload 
				goto mcmess_ErrorbadParkMaxPlayers params = { num_players = <num_players> MaxPlayers = <MaxPlayers> back_script = return_to_created_park_menu back_params = { from_server_options } } 
			ENDIF 
		ENDIF 
	ENDIF 
	GetParkEditorMaxPlayers 
	GetNetworkNumPlayers 
	IF InNetGame 
		IF ( <num_players> > <MaxPlayers> ) 
			level_select_created_park_menu_exit from_server_options 
			KillSpawnedScript name = level_select_scroll_map 
			KillSpawnedScript name = chap_moving_bg 
			KillSpawnedScript name = Level_Select_draw_line 
			KillSpawnedScript name = Level_Select_star_effect 
			IF ObjectExists id = current_menu_anchor 
				DestroyScreenElement id = current_menu_anchor 
			ENDIF 
			load_level_select_textures_to_main_memory unload 
			goto mcmess_ErrorbadParkMaxPlayers params = { num_players = <num_players> MaxPlayers = <MaxPlayers> back_script = return_to_created_park_menu back_params = { from_server_options } } 
		ENDIF 
	ENDIF 
	IF ( in_server_options = 1 ) 
		level_select_created_park_menu_exit from_server_options 
		level = load_sk5ed_gameplay 
		string = "Created Park" 
		level_select_menu_exit from_server_options net_pad_back = 0 <...> 
	ELSE 
		IF InNetGame 
			change created_park_warning = 0 
			level_select_change_level level = load_sk5ed_gameplay <...> show_warning 
		ELSE 
			level_select_change_level level = load_sk5ed_gameplay <...> 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT confirm_load_park 
	level_select_created_park_menu_exit 
	KillSpawnedScript name = level_select_scroll_map 
	KillSpawnedScript name = chap_moving_bg 
	KillSpawnedScript name = Level_Select_draw_line 
	KillSpawnedScript name = Level_Select_star_effect 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	load_level_select_textures_to_main_memory unload 
	IF GotParam from_server_options 
		change still_in_net_area = 1 
		IF IsParkUnsaved 
			menu_confirm_quit { yes_script = launch_level_select_load_park_sequence 
				title = "Replace unsaved park?" 
				text_dims = PAIR(330.00000000000, 0.00000000000) 
				back_script = return_to_created_park_menu 
				no_script = return_to_created_park_menu 
				params = { from_server_options } 
			} 
		ELSE 
			launch_level_select_load_park_sequence 
		ENDIF 
	ELSE 
		IF IsParkUnsaved 
			IF LevelIs load_skateshop 
				no_animate = no_animate 
			ENDIF 
			menu_confirm_quit { yes_script = launch_level_select_load_park_sequence 
				title = "Replace unsaved park?" 
				text_dims = PAIR(330.00000000000, 0.00000000000) 
				no_animate = <no_animate> 
				back_script = return_to_created_park_menu 
				no_script = return_to_created_park_menu 
			} 
		ELSE 
			launch_level_select_load_park_sequence 
		ENDIF 
	ENDIF 
	IF LevelIs load_skateshop 
		skater : hide 
		KillSkaterCamAnim all 
		PlaySkaterCamAnim skater = 0 name = mainmenu_camera03 play_hold 
	ENDIF 
ENDSCRIPT

still_in_net_area = 0 
SCRIPT return_to_created_park_menu 
	dialog_box_exit 
	kill_start_key_binding 
	launch_level_select_menu <...> 
	level_select_created_park_menu <...> 
ENDSCRIPT

SCRIPT level_select_created_park_menu_exit 
	IF GotParam park_list 
		level_select_created_park_list <...> 
	ELSE 
		SetButtonEventMappings block_menu_input 
		DoScreenElementMorph id = level_select_anchor_middle pos = PAIR(320.00000000000, 240.00000000000) time = 0.20000000298 
		wait 0.20000000298 seconds 
		DoScreenElementMorph id = created_park_menu pos = PAIR(420.00000000000, 240.00000000000) time = 0.10000000149 
		wait 0.10000000149 seconds 
		SetScreenElementProps id = title_text text = "LEVEL SELECT" 
		SetButtonEventMappings unblock_menu_input 
		IF ObjectExists id = created_park_menu 
			DestroyScreenElement id = created_park_menu 
		ENDIF 
		IF ObjectExists id = premade_park_menu 
			DestroyScreenElement id = premade_park_menu 
		ENDIF 
	ENDIF 
	IF GotParam launch_level 
		printf "launching created level" 
	ENDIF 
	IF GotParam load_park 
		printf "launching created level" 
	ENDIF 
	IF NOT GotParam park_list 
		AssignAlias id = level_select_anchor alias = current_menu_anchor 
		FireEvent type = focus target = level_select_vmenu 
	ENDIF 
ENDSCRIPT

SCRIPT level_select_created_park_list 
	printf "level_select_created_park_list" 
	dialog_box_exit 
	IF ScreenElementExists id = level_select_anchor_middle 
		dark_menu = dark_menu 
		delta_pos = PAIR(0.00000000000, 0.00000000000) 
		parent = level_select_anchor_middle 
	ELSE 
		IF ObjectExists id = current_menu_anchor 
			DestroyScreenElement id = current_menu_anchor 
		ENDIF 
		delta_pos = PAIR(-400.00000000000, 0.00000000000) 
		parent = root_window 
	ENDIF 
	IF GotParam in_park_editor 
		FormatText ChecksumName = title_icon "%i_load" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
		make_new_themed_scrolling_menu title = "PRE-MADE PARKS" title_icon = <title_icon> 
	ELSE 
		make_new_skateshop_menu { 
			parent = <parent> 
			pos = ( PAIR(620.00000000000, 100.00000000000) + <delta_pos> ) 
			dims = PAIR(200.00000000000, 191.00000000000) 
			internal_just = [ left center ] 
			menu_id = premade_park_menu 
			scrolling_menu_id = premade_park_scrolling_menu 
			vmenu_id = premade_park_vmenu 
			menu_title = "" 
			type = VScrollingMenu 
			scrolling_menu_title_id = "" 
			dont_allow_wrap = dont_allow_wrap 
			padding_scale = 0.89999997616 
		} 
		IF ScreenElementExists id = level_select_anchor_middle 
			DoScreenElementMorph id = premade_park_menu pos = PAIR(320.00000000000, 640.00000000000) 
		ENDIF 
	ENDIF 
	kill_start_key_binding 
	IF NOT GotParam in_park_editor 
		theme_background parent = premade_park_menu id = premade_park_bg width = 1.50000000000 pos = ( PAIR(710.00000000000, 106.00000000000) + <delta_pos> ) num_parts = 7.50000000000 z_priority = 1 dark_menu = <dark_menu> static = static 
	ENDIF 
	IF GotParam in_park_editor 
		create_helper_text generic_helper_text 
	ENDIF 
	IF GotParam from_server_options 
		pad_back_params = { from_server_options } 
	ELSE 
		pad_back_params = { } 
	ENDIF 
	IF NOT GotParam in_park_editor 
		SetScreenElementProps { 
			id = premade_park_vmenu 
			event_handlers = [ { pad_back generic_menu_pad_back params = { callback = level_select_created_park_list_exit <pad_back_params> } } ] 
			replace_handlers 
		} 
	ELSE 
		SetScreenElementProps { 
			id = sub_menu 
			event_handlers = [ { pad_back generic_menu_pad_back params = { callback = level_select_created_park_list_exit <...> } } ] 
			replace_handlers 
		} 
	ENDIF 
	GetArraySize premade_parks_info 
	index = 0 
	BEGIN 
		created_park_menu_add_item { text = ( premade_parks_info [ <index> ] . name ) 
			pad_choose_script = maybe_load_premade_park 
			pad_choose_params = { <pad_back_params> slot = ( premade_parks_info [ <index> ] . slot ) max = ( premade_parks_info [ <index> ] . max ) } 
		} 
		<index> = ( <index> + 1 ) 
	REPEAT <array_size> 
	IF ScreenElementExists id = level_select_vmenu 
		FireEvent type = unfocus target = level_select_vmenu 
	ENDIF 
	IF ScreenElementExists id = level_select_anchor_middle 
		SetButtonEventMappings block_menu_input 
		DoScreenElementMorph id = premade_park_menu pos = PAIR(320.00000000000, 240.00000000000) time = 0.30000001192 
		wait 0.25000000000 seconds 
		DoScreenElementMorph id = created_park_menu pos = PAIR(320.00000000000, 0.00000000000) time = 0.15000000596 
		wait 0.05000000075 seconds 
		SetScreenElementProps id = title_text text = "PRE-MADE PARKS" 
		FireEvent type = unfocus target = created_park_vmenu 
		FireEvent type = focus target = premade_park_vmenu 
		SetButtonEventMappings unblock_menu_input 
	ENDIF 
	IF GotParam in_park_editor 
		theme_menu_add_item text = "Done" id = menu_done scale = 1.00000000000 pad_choose_script = create_pause_menu no_bg highlight_bar_scale = PAIR(1.70000004768, 0.80000001192) 
		finish_themed_scrolling_menu bg_width = 1.50000000000 time = 0.20000000298 
	ENDIF 
ENDSCRIPT

SCRIPT maybe_load_premade_park 
	GetNetworkNumPlayers 
	IF InNetGame 
		IF ( <num_players> > <max> ) 
			level_select_created_park_menu_exit from_server_options 
			KillSpawnedScript name = level_select_scroll_map 
			KillSpawnedScript name = chap_moving_bg 
			KillSpawnedScript name = Level_Select_draw_line 
			KillSpawnedScript name = Level_Select_star_effect 
			IF ObjectExists id = current_menu_anchor 
				DestroyScreenElement id = current_menu_anchor 
			ENDIF 
			load_level_select_textures_to_main_memory unload 
			goto mcmess_ErrorbadParkMaxPlayers params = { num_players = <num_players> MaxPlayers = <max> back_script = return_to_created_park_menu back_params = { from_server_options } } 
		ENDIF 
	ENDIF 
	level_select_created_park_list_exit <...> 
ENDSCRIPT

SCRIPT level_select_created_park_list_exit 
	IF ObjectExists id = level_select_anchor 
		IF NOT GotParam slot 
			SetButtonEventMappings block_menu_input 
			DoScreenElementMorph id = created_park_menu pos = PAIR(320.00000000000, 240.00000000000) time = 0.15000000596 
			wait 0.05000000075 seconds 
			DoScreenElementMorph id = premade_park_menu pos = PAIR(320.00000000000, 640.00000000000) time = 0.30000001192 
			wait 0.25000000000 seconds 
			SetScreenElementProps id = title_text text = "CREATED PARKS" 
			FireEvent type = focus target = created_park_vmenu 
			SetButtonEventMappings unblock_menu_input 
			AssignAlias id = level_select_anchor alias = current_menu_anchor 
		ENDIF 
	ELSE 
		in_park_ed = 1 
	ENDIF 
	IF ObjectExists id = premade_park_menu 
		DestroyScreenElement id = premade_park_menu 
	ENDIF 
	IF GotParam slot 
		printf "loading from disk" 
		IF GotParam in_park_ed 
			printf "in the park editor" 
			parked_load_from_disk slot = <slot> 
		ELSE 
			IF GotParam from_server_options 
				LoadParkFromDisk slot = <slot> block_rebuild 
				created_park_launch from_server_options 
			ELSE 
				LoadParkFromDisk slot = <slot> block_rebuild 
				created_park_launch 
			ENDIF 
		ENDIF 
	ELSE 
		IF GotParam in_park_editor 
			create_pause_menu 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT premade_park_wait_message 
	DoScreenElementMorph id = current_menu_anchor scale = 0 
	create_error_box title = "Loading..." text = "Please wait while the pre-made park is loaded." 
	FireEvent type = showed_wait_message target = system 
ENDSCRIPT

SCRIPT level_select_hide_info 
	DoMorph scale = 0 
ENDSCRIPT

SCRIPT level_select_animate_info 
	DoMorph scale = 1 
ENDSCRIPT

SCRIPT level_select_play_cam 
	kill_level_select_cams 
	IF LevelIs load_skateshop 
		KillSkaterCamAnim all 
		PlaySkaterCamAnim skater = 0 name = SS_LevelSelect play_hold 
	ELSE 
		PlaySkaterCamAnim skater = 0 name = MapGuy_ViewCam play_hold 
		SetSkaterCamAnimShouldPause name = MapGuy_ViewCam 0 
	ENDIF 
ENDSCRIPT

SCRIPT kill_level_select_cams 
	KillSkaterCamAnim name = MapGuy_ViewCam 
ENDSCRIPT

SCRIPT really_change_level 
	IF OnServer 
		change_level <...> 
	ELSE 
		IF IsHost 
			FCFSRequestChangeLevel <...> 
		ENDIF 
	ENDIF 
ENDSCRIPT

return_to_level = [ null ] 
SCRIPT level_select_change_level 
	GoalManager_ShowPoints 
	IF NOT GoalManager_HasActiveGoals 
		GoalManager_ShowGoalPoints 
	ENDIF 
	IF ScreenElementExists id = level_select_anchor 
		DestroyScreenElement id = level_select_anchor 
		load_level_select_textures_to_main_memory unload 
	ENDIF 
	IF ScreenElementExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	IF LevelIs load_sk5ed 
		load_parked_textures_to_main_memory unload 
	ENDIF 
	IF LevelIs load_skateshop 
		SetColorBufferClear clear = 0 
	ENDIF 
	IF LevelIs load_skateshop 
		load_mainmenu_textures_to_main_memory unload 
	ENDIF 
	IF LevelIs load_sk5ed_gameplay 
		RailEditor : DestroyEditedRailSectors DoNotUpdateSuperSectors 
	ENDIF 
	kill_level_select_cams 
	IF GameModeEquals is_career 
		IF NOT LevelIs load_skateshop 
			IF ( ( <level> = load_boardshop ) | ( <level> = load_cas ) ) 
				temp = <level> 
				GetCurrentLevel 
				array = return_to_level 
				SetArrayElement arrayname = array index = 0 newvalue = <level> 
				level = <temp> 
			ENDIF 
		ENDIF 
	ENDIF 
	IF CD 
		IF IsCustomPark 
			really_change_level <...> 
		ELSE 
			IF NOT LevelIs <level> 
				really_change_level <...> 
			ELSE 
				IF GotParam chose_same_level_script 
					<chose_same_level_script> 
				ELSE 
					IF GotParam end_run 
						level_select_menu_exit end_run 
						RETURN 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
	ELSE 
		really_change_level <...> 
	ENDIF 
	level_select_menu_exit no_new_menu 
	exit_pause_menu 
ENDSCRIPT

SCRIPT level_select_invalid_choice 
ENDSCRIPT

SCRIPT hide_main_menu_anchor 
	DoMorph time = 0 scale = 0 
ENDSCRIPT

SCRIPT show_main_menu_anchor 
	DoMorph time = 0 scale = 1 
ENDSCRIPT

e3_level_select_menu_level_info = [ 
	{ text = "New Jersey" level_num = 1 points_to_unlock = 0 num_am_goals = 0 num_goals = 0 flag = LEVEL_UNLOCKED_NJ level = load_nj taxi_id = Cab_sign_1_College } 
	{ text = "Manhattan" level_num = 2 points_to_unlock = 8 num_am_goals = 0 num_goals = 0 flag = LEVEL_UNLOCKED_NY level = load_ny } 
	{ text = "Tampa" level_num = 3 points_to_unlock = 8 num_am_goals = 0 num_goals = 0 flag = LEVEL_UNLOCKED_FL level = load_fl } 
] 
level_select_menu_level_info = [ 
	{ text = "New Jersey" level_num = 1 points_to_unlock = 0 num_am_goals = 0 num_goals = 0 flag = LEVEL_UNLOCKED_NJ level = load_nj } 
	{ text = "Manhattan" level_num = 2 points_to_unlock = 8 num_am_goals = 0 num_goals = 0 flag = LEVEL_UNLOCKED_NY level = load_ny } 
	{ text = "Tampa" level_num = 3 points_to_unlock = 8 num_am_goals = 0 num_goals = 0 flag = LEVEL_UNLOCKED_FL level = load_fl } 
	{ text = "San Diego" level_num = 4 points_to_unlock = 8 num_am_goals = 0 num_goals = 0 flag = LEVEL_UNLOCKED_SD level = load_sd } 
	{ text = "Hawaii" level_num = 5 points_to_unlock = 8 num_am_goals = 0 num_goals = 0 flag = LEVEL_UNLOCKED_HI level = load_hi } 
	{ text = "Vancouver" level_num = 6 points_to_unlock = 8 num_am_goals = 0 num_goals = 0 flag = LEVEL_UNLOCKED_VC level = load_vc } 
	{ text = "Slam City Jam" level_num = 7 points_to_unlock = 8 num_am_goals = 0 num_goals = 0 flag = LEVEL_UNLOCKED_SP level = load_sj } 
	{ text = "Moscow" level_num = 8 points_to_unlock = 8 num_am_goals = 0 num_goals = 0 flag = LEVEL_UNLOCKED_RU level = load_ru } 
	{ text = "Hotter Than Hell" level_num = 10 points_to_unlock = 8 num_am_goals = 0 num_goals = 0 flag = LEVEL_UNLOCKED_SE level = load_se } 
	{ text = "Created Park" level_num = 11 points_to_unlock = 0 num_am_goals = 0 num_goals = 0 flag = LEVEL_UNLOCKED_SCH level = load_sk5ed_gameplay } 
	{ text = "School II" level_num = 15 points_to_unlock = 0 num_am_goals = 0 num_goals = 0 flag = LEVEL_UNLOCKED_SC2 level = load_SC2 } 
	{ text = "Venice" level_num = 16 points_to_unlock = 0 num_am_goals = 0 num_goals = 0 flag = LEVEL_UNLOCKED_VN level = load_VN } 
	{ text = "Hangar" level_num = 17 points_to_unlock = 0 num_am_goals = 0 num_goals = 0 flag = LEVEL_UNLOCKED_HN level = load_HN } 
	{ text = "West Side" level_num = 18 points_to_unlock = -1 num_am_goals = 0 num_goals = 0 flag = LEVEL_UNLOCKED_SCH level = load_WWW DEVKIT_ONLY } 
	{ text = "TestLevel" level_num = 21 points_to_unlock = -1 num_am_goals = 0 num_goals = 0 flag = LEVEL_UNLOCKED_NJ level = load_TestLevel DEVKIT_ONLY } 
	{ text = "Default" level_num = 30 points_to_unlock = -1 num_am_goals = 0 num_goals = 0 flag = LEVEL_UNLOCKED_NJ level = load_Default DEVKIT_ONLY } 
] 
premade_parks_info = [ 
	{ name = "Skatechupitchu" slot = 1 max = 5 } 
	{ name = "Slacka-land" slot = 2 max = 6 } 
	{ name = "SP\'s Ville" slot = 3 max = 4 } 
	{ name = "AndyTHPS Park" slot = 4 max = 7 } 
	{ name = "Fontucky Speedway" slot = 5 max = 7 } 
	{ name = "Montana Undrgrnd" slot = 6 max = 8 } 
	{ name = "DDT Underground" slot = 7 max = 6 } 
	{ name = "Ji Land3" slot = 8 max = 5 } 
	{ name = "Skate Mountain" slot = 9 max = 7 } 
] 
SCRIPT create_options_menu 
	hide_current_goal 
	FormatText ChecksumName = title_icon "%i_options" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	make_new_themed_option_menu title = "OPTIONS" title_icon = <title_icon> 
	pause_show_deck parent = current_menu_anchor no_slide 
	IF LevelIs load_skateshop 
		pad_back_script = skateshop_practice_pause_menu 
	ELSE 
		pad_back_script = create_pause_menu 
	ENDIF 
	GoalManager_HideGoalPoints 
	GoalManager_HidePoints 
	unhide_root_window 
	SetScreenElementProps { id = options_menu 
		event_handlers = [ 
			{ pad_back generic_menu_pad_back params = { callback = <pad_back_script> } } 
		] 
	} 
	IF NOT ( Demo_Build ) 
		IF GameModeEquals is_career 
			make_theme_menu_item text = "Game Progress" id = menu_game_progress pad_choose_script = game_progress_menu_create 
		ENDIF 
		IF GameModeEquals is_singlesession 
			IF NOT InSplitScreenGame 
				IF NOT InNetGame 
					make_theme_menu_item text = "High Scores" id = menu_high_scores pad_choose_script = high_scores_menu_create pad_choose_params = { from_pause = from_pause } 
				ENDIF 
			ENDIF 
		ENDIF 
		IF NOT InMultiPlayerGame 
			IF isngc 
				SWITCH camera_angle 
					CASE 0 
						camera_text = "Camera Angle: 1" 
					CASE 1 
						camera_text = "Camera Angle: 2" 
					CASE 2 
						camera_text = "Camera Angle: 3" 
					CASE 3 
						camera_text = "Camera Angle: 4" 
				ENDSWITCH 
				make_theme_menu_item text = <camera_text> id = menu_camera pad_choose_script = toggle_camera_angle pad_choose_params = { } 
			ENDIF 
			make_theme_menu_item text = "Cheats" id = menu_real_cheats pad_choose_script = create_real_cheats_menu 
			IF NOT CD 
				make_theme_menu_item text = "Cheats: Debug" id = menu_cheats pad_choose_script = launch_cheats_menu 
			ENDIF 
		ELSE 
			IF InNetGame 
				IF GameModeEquals is_lobby 
					IF GoalManager_HasActiveGoals count_all 
					ELSE 
					ENDIF 
				ENDIF 
				IF NOT ( ( IsTrue bootstrap_build ) | ( IsTrue Demo_Build ) ) 
					IF NOT CD 
						make_theme_menu_item text = "Cheats: DO NOT TEST" id = menu_cheats pad_choose_script = launch_cheats_menu 
					ENDIF 
				ENDIF 
			ELSE 
			ENDIF 
		ENDIF 
	ENDIF 
	IF isxbox 
		make_theme_menu_item text = "Adjust Gamma" id = menu_gamma pad_choose_script = create_gamma_menu 
	ELSE 
		make_theme_menu_item text = "Screen Mode" id = menu_screen pad_choose_script = generic_menu_pad_choose pad_choose_params = { callback = create_screen_menu } 
	ENDIF 
	make_theme_menu_item text = "Sound Options" id = menu_sound_options pad_choose_script = launch_sound_options_menu pad_choose_params = { from_options } 
	IF NOT InSplitScreenGame 
		IF NOT InNetGame 
			make_theme_menu_item { text = #"Control Setup" 
				id = options_controller 
				pad_choose_script = create_controller_config_menu 
				pad_choose_params = { controller_number = 1 from_options } 
				centered 
				no_bg 
			} 
		ENDIF 
	ENDIF 
	make_theme_menu_item text = "Display Options" id = menu_display_options pad_choose_script = launch_display_options_menu pad_choose_params = { from_options } 
	IF NOT InNetGame 
		make_theme_menu_item text = "Interface Themes" id = menu_themes pad_choose_script = swap_themes_menu pad_choose_params = { from_options = from_options } 
	ENDIF 
	IF InNetGame 
		IF InTeamGame 
			GetPreferenceString pref_type = network score_display 
			make_theme_menu_item text = "Score Display Mode" id = menu_score_display pad_choose_script = create_options_score_display_menu 
			make_theme_menu_item text = <ui_string> id = menu_score_display_str rgba = [ 80 80 80 128 ] not_focusable 
		ENDIF 
		GetPreferenceString pref_type = network auto_brake 
		FormatText textname = AutoBrake_toggle_text "Auto-Brake: %s" s = <ui_string> 
		make_theme_menu_item text = <AutoBrake_toggle_text> id = menu_auto_brake pad_choose_script = toggle_auto_brake_option toggle_pos = PAIR(163.00000000000, 12.00000000000) 
	ELSE 
		IF NOT ObjectExists id = menu_real_cheats 
			make_theme_menu_item text = "Cheats" id = menu_real_cheats pad_choose_script = create_real_cheats_menu 
		ENDIF 
	ENDIF 
	<show_cutscene_menu> = 1 
	IF Pal 
		IF isngc 
			<show_cutscene_menu> = 0 
		ENDIF 
	ENDIF 
	IF ( <show_cutscene_menu> = 1 ) 
		IF GameModeEquals is_career 
			has_cutscenes 
			IF ( <does_have_cutscenes> = 1 ) 
				make_theme_menu_item text = "Watch Cutscenes" id = menu_watch_cutscenes pad_choose_script = create_watch_cutscenes_menu 
			ELSE 
				make_theme_menu_item text = "Watch Cutscenes" id = menu_watch_cutscenes not_focusable = not_focusable 
			ENDIF 
		ENDIF 
	ENDIF 
	PrintStruct <...> 
	IF InNetGame 
		IF GameModeEquals is_lobby 
			IF IsObserving 
				NoCustomRestarts = 1 
			ELSE 
				IF NOT ObjectExists id = skater 
					NoCustomRestarts = 1 
				ELSE 
					IF skater : Skating 
						IF skater : OnLip 
							NoCustomRestarts = 1 
						ELSE 
							IF skater : OnRail 
								NoCustomRestarts = 1 
							ENDIF 
						ENDIF 
					ELSE 
						IF skater : Walking 
							skater : Walk_GetState 
							IF ( <state> = WALKING_HANG | <state> = WALKING_LADDER | <state> = WALKING_ANIMWAIT ) 
								NoCustomRestarts = 1 
							ENDIF 
						ENDIF 
					ENDIF 
				ENDIF 
			ENDIF 
			PrintStruct <...> 
			IF NOT GotParam NoCustomRestarts 
				make_theme_menu_item { 
					text = "Set Restart" 
					id = menu_set_custom 
					pad_choose_script = menu_select 
					pad_choose_params = { menu_select_script = set_custom_restart } 
				} 
				IF skater : SetCustomRestart 
					make_theme_menu_item text = "Goto Cust Restart" id = menu_skip_to_custom pad_choose_script = menu_select pad_choose_params = { menu_select_script = skip_to_custom_restart } 
				ENDIF 
			ENDIF 
		ENDIF 
	ELSE 
		IF GoalManager_HasActiveGoals count_all 
			NoCustomRestarts = 1 
		ELSE 
			IF skater : PlayerInputIsDisabled 
				NoCustomRestarts = 1 
			ELSE 
				IF GameModeEquals is_creategoals 
					NoCustomRestarts = 1 
				ELSE 
					IF skater : Skating 
						IF skater : OnLip 
							NoCustomRestarts = 1 
						ELSE 
							IF skater : OnRail 
								NoCustomRestarts = 1 
							ENDIF 
						ENDIF 
					ELSE 
						IF skater : Walking 
							skater : Walk_GetState 
							IF ( <state> = WALKING_HANG | <state> = WALKING_LADDER | <state> = WALKING_ANIMWAIT ) 
								NoCustomRestarts = 1 
							ENDIF 
						ENDIF 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
		IF NOT GotParam NoCustomRestarts 
			IF NOT GameModeEquals is_creategoals 
				make_theme_menu_item text = "Set Restart" id = menu_set_custom pad_choose_script = menu_select pad_choose_params = { menu_select_script = set_custom_restart } 
			ENDIF 
			IF skater : SetCustomRestart 
				make_theme_menu_item text = "Goto Cust Restart" id = menu_skip_to_custom pad_choose_script = menu_select pad_choose_params = { menu_select_script = skip_to_custom_restart } 
			ENDIF 
		ENDIF 
	ENDIF 
	make_theme_menu_item text = "Done" id = menu_done pad_choose_script = <pad_back_script> pad_choose_params = { no_sound } 
	add_music_track_text 
	build_top_bar pos = PAIR(-400.00000000000, 62.00000000000) 
	DoScreenElementMorph id = top_bar_anchor time = 0.20000000298 pos = PAIR(0.00000000000, 62.00000000000) 
	FireEvent type = focus target = current_menu_anchor 
ENDSCRIPT

SCRIPT options_menu_add_toggle_item { focus_script = do_scale_up 
		unfocus_script = do_scale_down 
		pad_choose_script = nullscript 
		font_face = small 
		parent_menu_id = current_menu 
		scale = 1 
		rgba = [ 50 50 50 90 ] 
		toggle_pos = PAIR(195.00000000000, 12.00000000000) 
		on_off_text = "On" 
	} 
	IF GotParam not_focusable 
		CreateScreenElement { 
			type = TextElement 
			parent = <parent_menu_id> 
			id = <id> 
			text = <text> 
			font = <font_face> 
			rgba = [ 30 30 30 128 ] 
			scale = <scale> 
			dims = <dims> 
			not_focusable 
		} 
	ELSE 
		CreateScreenElement { 
			type = TextElement 
			parent = <parent_menu_id> 
			id = <id> 
			text = <text> 
			font = <font_face> 
			rgba = <rgba> 
			scale = <scale> 
			dims = <dims> 
			event_handlers = [ 
				{ focus <focus_script> params = <focus_params> } 
				{ unfocus <unfocus_script> params = <unfocus_params> } 
				{ pad_choose generic_menu_pad_choose_sound } 
				{ pad_start generic_menu_pad_choose_sound } 
				{ pad_choose <pad_choose_script> params = <pad_choose_params> } 
				{ pad_start <pad_choose_script> params = <pad_choose_params> } 
			] 
		} 
		CreateScreenElement { 
			type = TextElement 
			parent = <id> 
			pos = <toggle_pos> 
			text = <on_off_text> 
			font = <font_face> 
			rgba = <rgba> 
			scale = <scale> 
		} 
	ENDIF 
ENDSCRIPT

camera_angle = 0 
SCRIPT toggle_camera_angle 
	SWITCH camera_angle 
		CASE 0 
			change camera_angle = 1 
			SetScreenElementProps id = { menu_camera child = 0 } text = "Camera Angle: 2" 
			ToggleSkaterCamMode skater = 0 
		CASE 1 
			change camera_angle = 2 
			SetScreenElementProps id = { menu_camera child = 0 } text = "Camera Angle: 3" 
			ToggleSkaterCamMode skater = 0 
		CASE 2 
			change camera_angle = 3 
			SetScreenElementProps id = { menu_camera child = 0 } text = "Camera Angle: 4" 
			ToggleSkaterCamMode skater = 0 
		CASE 3 
			change camera_angle = 0 
			SetScreenElementProps id = { menu_camera child = 0 } text = "Camera Angle: 1" 
			ToggleSkaterCamMode skater = 0 
	ENDSWITCH 
ENDSCRIPT

SCRIPT create_watch_cutscenes_menu back_script = create_options_menu 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	FormatText ChecksumName = title_icon "%i_options" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	make_new_themed_sub_menu title = "CUTSCENES" title_icon = <title_icon> 
	SetScreenElementProps { id = sub_menu 
		event_handlers = [ 
			{ pad_back generic_menu_pad_back params = { callback = <back_script> } } 
		] 
	} 
	add_viewed_cutscenes_to_menu 
	theme_menu_add_item text = "Done" pad_choose_script = generic_menu_pad_choose pad_choose_params = { callback = <back_script> } centered last_menu_item = last_menu_item 
	finish_themed_sub_menu 
ENDSCRIPT

SCRIPT has_cutscenes 
	GetCurrentLevel 
	SWITCH <level> 
		CASE load_nj 
		CASE load_ny 
		CASE load_fl 
		CASE load_sd 
		CASE load_hi 
		CASE load_vc 
		CASE load_sj 
		CASE load_ru 
			RETURN does_have_cutscenes = 1 
		DEFAULT 
			RETURN does_have_cutscenes = 0 
	ENDSWITCH 
ENDSCRIPT

SCRIPT add_viewed_cutscenes_to_menu 
	GetCurrentLevel 
	SWITCH <level> 
		CASE load_nj 
			<cutscene_list> = cutscene_unlock_list_nj 
		CASE load_ny 
			<cutscene_list> = cutscene_unlock_list_ny 
		CASE load_fl 
			<cutscene_list> = cutscene_unlock_list_fl 
		CASE load_sd 
			<cutscene_list> = cutscene_unlock_list_sd 
		CASE load_hi 
			<cutscene_list> = cutscene_unlock_list_hi 
		CASE load_vc 
			<cutscene_list> = cutscene_unlock_list_vc 
		CASE load_sj 
			<cutscene_list> = cutscene_unlock_list_sj 
		CASE load_ru 
			<cutscene_list> = cutscene_unlock_list_ru 
		DEFAULT 
			RETURN 
	ENDSWITCH 
	GetArraySize <cutscene_list> 
	<index> = 0 
	BEGIN 
		IF NOT isngc 
			<skip_me> = 0 
		ELSE 
			IF StructureContains structure = ( ( ( <cutscene_list> ) [ <index> ] ) ) not_with_ngc 
				<skip_me> = 1 
			ELSE 
				<skip_me> = 0 
			ENDIF 
		ENDIF 
		IF GetGlobalFlag flag = ( ( ( <cutscene_list> ) [ <index> ] ) . flag ) 
			IF StructureContains structure = ( ( ( <cutscene_list> ) [ <index> ] ) ) name2 
				IF ( <skip_me> = 0 ) 
					theme_menu_add_item { 
						text = ( ( ( <cutscene_list> ) [ <index> ] ) . text ) 
						pad_choose_script = watch_cutscene 
						pad_choose_params = { name = ( ( ( <cutscene_list> ) [ <index> ] ) . name ) name2 = ( ( ( <cutscene_list> ) [ <index> ] ) . name2 ) tod_action = ( ( ( <cutscene_list> ) [ <index> ] ) . tod_action ) tod_action2 = ( ( ( <cutscene_list> ) [ <index> ] ) . tod_action2 ) tod_action3 = ( ( ( <cutscene_list> ) [ <index> ] ) . tod_action3 ) } 
						centered 
					} 
				ENDIF 
			ELSE 
				IF ( <skip_me> = 0 ) 
					theme_menu_add_item { 
						text = ( ( ( <cutscene_list> ) [ <index> ] ) . text ) 
						pad_choose_script = watch_cutscene 
						pad_choose_params = { name = ( ( ( <cutscene_list> ) [ <index> ] ) . name ) tod_action = ( ( ( <cutscene_list> ) [ <index> ] ) . tod_action ) tod_action2 = ( ( ( <cutscene_list> ) [ <index> ] ) . tod_action2 ) } 
						centered 
					} 
				ENDIF 
			ENDIF 
		ENDIF 
		<index> = ( <index> + 1 ) 
	REPEAT <array_size> 
ENDSCRIPT

SCRIPT watch_cutscene 
	Debounce X 2.50000000000 
	pause_menu_gradient off 
	IF GotParam tod_action 
		script_change_tod tod_action = <tod_action> 
	ENDIF 
	IF GotParam tod_action2 
		script_change_tod tod_action = <tod_action2> 
	ENDIF 
	UnpauseGame 
	Debounce X 2.50000000000 
	PauseMusic 0 
	IF NOT GotParam name2 
		PlayCutscene <...> from_cutscene_menu dont_send_skater_to_hand_brake exitScript = watch_cutscene_done 
	ELSE 
		PlayCutscene { 
			name = <name> 
			from_cutscene_menu 
			dont_send_skater_to_hand_brake 
			unload_anims = 1 
			reload_anims = 0 
			unload_goals = 1 
			reload_goals = 0 
			exitScript = spawn_next_cutscene 
			exitParams = { name = <name2> from_cutscene_menu dont_send_skater_to_hand_brake tod_action = <tod_action3> unload_anims = 0 reload_anims = 1 unload_goals = 0 reload_goals = 1 exitScript = watch_cutscene_done } 
		} 
	ENDIF 
	RunScriptOnScreenElement id = current_menu_anchor menu_offscreen 
ENDSCRIPT

SCRIPT watch_cutscene_done 
	PauseGame 
	PauseMusic 1 
	Debounce X 0.50000000000 
	pause_menu_gradient on 
	create_watch_cutscenes_menu 
ENDSCRIPT

SCRIPT create_real_cheats_menu back_script = create_options_menu 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	IF InSplitScreenGame 
		GoalManager_HidePoints 
	ENDIF 
	FormatText ChecksumName = title_icon "%i_cheats" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	IF InNetGame 
		make_new_themed_scrolling_menu title = "ADVANCED OPTIONS" title_icon = <title_icon> dims = PAIR(600.00000000000, 237.00000000000) pos = PAIR(229.00000000000, 80.00000000000) right_bracket_z = 1 
	ELSE 
		make_new_themed_scrolling_menu title = "CHEATS" title_icon = <title_icon> dims = PAIR(600.00000000000, 237.00000000000) pos = PAIR(229.00000000000, 80.00000000000) right_bracket_z = 1 
	ENDIF 
	SetScreenElementProps { id = sub_menu 
		event_handlers = [ 
			{ pad_back generic_menu_pad_back params = { callback = <back_script> } } 
		] 
	} 
	create_helper_text generic_helper_text_toggle 
	kill_start_key_binding 
	IF NOT InNetGame 
		IF GetGlobalFlag flag = CHEAT_UNLOCKED_1 
			make_cheats_menu_item text = "Cool Specials" cheat_flag = CHEAT_COOL_SPECIAL_TRICKS pad_choose_script = toggle_cheat pad_choose_params = { on_callback = nullscript off_callback = nullscript } 
		ENDIF 
	ENDIF 
	IF NOT InNetGame 
		IF GetGlobalFlag flag = CHEAT_UNLOCKED_3 
			make_cheats_menu_item { 
				text = "Kid Mode" 
				cheat_flag = CHEAT_KID 
				pad_choose_script = toggle_cheat 
				pad_choose_params = { 
					on_callback = refresh_skater_model_for_cheats 
					off_callback = refresh_skater_model_for_cheats 
				} 
			} 
		ENDIF 
	ENDIF 
	IF NOT InNetGame 
		IF GetGlobalFlag flag = CHEAT_UNLOCKED_5 
			make_cheats_menu_item { 
				text = "RollerSkates" 
				cheat_flag = CHEAT_HOVERBOARD 
				pad_choose_script = toggle_cheat 
				pad_choose_params = { 
					on_callback = refresh_skater_model_for_cheats 
					off_callback = refresh_skater_model_for_cheats 
				} 
			} 
		ENDIF 
	ENDIF 
	IF GetGlobalFlag flag = CHEAT_UNLOCKED_10 
		make_cheats_menu_item text = "Flame" cheat_flag = CHEAT_FLAME pad_choose_script = toggle_cheat pad_choose_params = { on_callback = nullscript off_callback = nullscript } 
	ENDIF 
	IF NOT InNetGame 
		IF GetGlobalFlag flag = CHEAT_UNLOCKED_12 
			make_cheats_menu_item text = "Always Special" cheat_flag = CHEAT_ALWAYS_SPECIAL pad_choose_script = toggle_cheat pad_choose_params = { on_callback = nullscript off_callback = nullscript } 
		ENDIF 
	ENDIF 
	IF NOT InNetGame 
		IF GetGlobalFlag flag = CHEAT_UNLOCKED_13 
			make_cheats_menu_item text = "Perfect Rail" cheat_flag = CHEAT_PERFECT_RAIL pad_choose_script = toggle_cheat pad_choose_params = { on_callback = nullscript off_callback = nullscript } 
		ENDIF 
	ENDIF 
	IF NOT InNetGame 
		IF GetGlobalFlag flag = CHEAT_UNLOCKED_14 
			make_cheats_menu_item text = "Perfect Skitch" cheat_flag = CHEAT_PERFECT_SKITCH pad_choose_script = toggle_cheat pad_choose_params = { on_callback = nullscript off_callback = nullscript } 
		ENDIF 
	ENDIF 
	IF NOT InNetGame 
		IF GetGlobalFlag flag = CHEAT_UNLOCKED_16 
			make_cheats_menu_item text = "Perfect Manual" cheat_flag = CHEAT_PERFECT_MANUAL pad_choose_script = toggle_cheat pad_choose_params = { on_callback = nullscript off_callback = nullscript } 
		ENDIF 
	ENDIF 
	IF NOT InNetGame 
		IF GetGlobalFlag flag = CHEAT_UNLOCKED_17 
			make_cheats_menu_item text = "Moon Gravity" cheat_flag = CHEAT_MOON pad_choose_script = toggle_cheat pad_choose_params = { on_callback = nullscript off_callback = nullscript } 
		ENDIF 
	ENDIF 
	IF InNetGame 
		IF IsHost 
			make_cheats_menu_item text = "No Reverts" cheat_flag = FLAG_G_EXPERT_MODE_NO_REVERTS pad_choose_script = toggle_cheat pad_choose_params = { on_callback = nullscript off_callback = nullscript reverse } 
			make_cheats_menu_item text = "No Walking" cheat_flag = FLAG_G_EXPERT_MODE_NO_WALKING pad_choose_script = toggle_cheat pad_choose_params = { on_callback = nullscript off_callback = nullscript reverse } 
			make_cheats_menu_item text = "No Manuals" cheat_flag = FLAG_G_EXPERT_MODE_NO_MANUALS pad_choose_script = toggle_cheat pad_choose_params = { on_callback = nullscript off_callback = nullscript reverse } 
			make_cheats_menu_item text = "No Bal. Meters" cheat_flag = NO_G_DISPLAY_BALANCE pad_choose_script = toggle_cheat pad_choose_params = { on_callback = nullscript off_callback = nullscript reverse } 
		ENDIF 
	ENDIF 
	theme_menu_add_item text = "Done" id = menu_done scale = 1.00000000000 pad_choose_script = <back_script> no_bg highlight_bar_scale = PAIR(2.79999995232, 0.80000001192) 
	finish_themed_scrolling_menu bg_width = 4.00000000000 time = 0.20000000298 
	set_theme_icons 
ENDSCRIPT

SCRIPT make_cheats_menu_item { focus_script = do_scale_up 
		unfocus_script = do_scale_down 
		pad_choose_script = nullscript 
		font_face = small 
		parent_menu_id = current_menu 
		scale = 0.80000001192 
		dims = PAIR(350.00000000000, 14.00000000000) 
		rgba = [ 88 105 112 128 ] 
	} 
	pad_choose_params = { cheat_flag = <cheat_flag> <pad_choose_params> } 
	IF GotParam not_focusable 
		CreateScreenElement { 
			type = TextElement 
			parent = <parent_menu_id> 
			id = <id> 
			text = <text> 
			font = <font_face> 
			rgba = [ 30 30 30 128 ] 
			scale = <scale> 
			dims = <dims> 
			not_focusable 
		} 
	ELSE 
		IF ( GetGlobalFlag flag = <cheat_flag> ) 
			on_off_text = "On" 
		ELSE 
			on_off_text = "Off" 
		ENDIF 
		theme_menu_add_item text = <text> id = <checksum> highlight_bar_scale = PAIR(2.79999995232, 0.80000001192) extra_text = <on_off_text> no_bg pad_choose_script = <pad_choose_script> pad_choose_params = <pad_choose_params> 
	ENDIF 
ENDSCRIPT

SCRIPT choose_boolean_option 
	set_preferences_from_ui prefs = network <...> 
	create_options_menu 
ENDSCRIPT

SCRIPT back_from_boolean_menus 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	create_options_menu 
ENDSCRIPT

SCRIPT create_options_score_display_menu 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	FormatText ChecksumName = title_icon "%i_options" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	make_new_themed_sub_menu title = "SCORE DISPLAY MODE" title_icon = <title_icon> right_bracket_alpha = 0.00000000000 
	SetScreenElementProps { 
		id = current_menu 
		event_handlers = [ { pad_back generic_menu_pad_back params = { callback = back_from_boolean_menus } } ] 
		replace_handlers 
	} 
	theme_menu_add_item text = "Show Players" centered id = menu_players pad_choose_script = choose_boolean_option pad_choose_params = { field = "score_display" checksum = score_players string = "Show Players" } 
	theme_menu_add_item text = "Show Teams" centered id = menu_teams pad_choose_script = choose_boolean_option pad_choose_params = { field = "score_display" checksum = score_teams string = "Show Teams" } 
	theme_menu_add_item text = "Done" pad_choose_script = back_from_boolean_menus last_menu_item = last_menu_item 
	finish_themed_sub_menu 
ENDSCRIPT

SCRIPT toggle_show_name_option 
	GetTags 
	GetPreferenceString pref_type = network show_names 
	IF ( <ui_string> = "Off" ) 
		text = "On" 
		set_preferences_from_ui prefs = network field = "show_names" checksum = boolean_true string = "On" 
		SetScreenElementProps id = { <id> child = 0 } text = "Player Names: On" 
	ELSE 
		text = "Off" 
		set_preferences_from_ui prefs = network field = "show_names" checksum = boolean_false string = "Off" 
		SetScreenElementProps id = { <id> child = 0 } text = "Player Names: Off" 
		destroy_all_player_names 
	ENDIF 
ENDSCRIPT

SCRIPT toggle_auto_brake_option 
	GetTags 
	GetPreferenceString pref_type = network auto_brake 
	IF ( <ui_string> = "Off" ) 
		text = "On" 
		set_preferences_from_ui prefs = network field = "auto_brake" checksum = boolean_true string = "On" 
		SetScreenElementProps id = { <id> child = 0 } text = "Auto-Brake: On" 
	ELSE 
		text = "Off" 
		set_preferences_from_ui prefs = network field = "auto_brake" checksum = boolean_false string = "Off" 
		SetScreenElementProps id = { <id> child = 0 } text = "Auto-Brake: Off" 
	ENDIF 
ENDSCRIPT

SCRIPT create_gamma_menu 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	FormatText ChecksumName = title_icon "%i_options" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	make_new_themed_sub_menu title = "GAMMA" title_icon = <title_icon> 
	SetScreenElementProps { 
		id = sub_menu 
		event_handlers = [ { pad_back create_options_menu } ] 
		replace_handlers 
	} 
	set_theme_icons 
	GetGammaValues 
	FormatText textname = red_text "%i" i = <red> 
	FormatText textname = green_text "%i" i = <green> 
	FormatText textname = blue_text "%i" i = <blue> 
	theme_menu_add_item text = "Red: " extra_text = <red_text> id = gamma_menu_red 
	theme_menu_add_item text = "Green: " extra_text = <green_text> id = gamma_menu_green 
	theme_menu_add_item text = "Blue: " extra_text = <blue_text> id = gamma_menu_blue 
	theme_menu_add_item text = "Done" id = gamma_menu_done pad_choose_script = create_options_menu last_menu_item = last_menu_item 
	SetScreenElementProps { 
		id = gamma_menu_red 
		event_handlers = [ { pad_left gamma_menu_turn_down params = { color = red } } 
			{ pad_right gamma_menu_turn_up params = { color = red } } 
		] 
		replace_handlers 
	} 
	SetScreenElementProps { 
		id = gamma_menu_green 
		event_handlers = [ { pad_left gamma_menu_turn_down params = { color = green } } 
			{ pad_right gamma_menu_turn_up params = { color = green } } 
		] 
		replace_handlers 
	} 
	SetScreenElementProps { 
		id = gamma_menu_blue 
		event_handlers = [ { pad_left gamma_menu_turn_down params = { color = blue } } 
			{ pad_right gamma_menu_turn_up params = { color = blue } } 
		] 
		replace_handlers 
	} 
	create_helper_text { helper_text_elements = [ { text = "\\b7/\\b4=Select" } 
			{ text = "\\b6/\\b5=Adjust" } 
			{ text = "\\bm=Accept" } 
			{ text = "\\bn=Back" } 
		] 
	} 
	finish_themed_sub_menu 
ENDSCRIPT

SCRIPT gamma_menu_create_child 
	SetScreenElementLock id = <parent> off 
	CreateScreenElement { 
		type = TextElement 
		parent = <parent> 
		text = <text> 
		font = small 
		just = [ right top ] 
		pos = PAIR(150.00000000000, 0.00000000000) 
	} 
ENDSCRIPT

SCRIPT gamma_menu_check_levels 
	GetGammaValues 
	FormatText textname = red_text "%i" i = <red> 
	FormatText textname = green_text "%i" i = <green> 
	FormatText textname = blue_text "%i" i = <blue> 
	SetScreenElementLock id = gamma_menu_red off 
	SetScreenElementLock id = gamma_menu_green off 
	SetScreenElementLock id = gamma_menu_blue off 
	SetScreenElementProps { 
		id = { gamma_menu_red child = 3 } 
		text = <red_text> 
	} 
	SetScreenElementProps { 
		id = { gamma_menu_green child = 3 } 
		text = <green_text> 
	} 
	SetScreenElementProps { 
		id = { gamma_menu_blue child = 3 } 
		text = <blue_text> 
	} 
ENDSCRIPT

SCRIPT gamma_menu_turn_up 
	GetGammaValues 
	SWITCH <color> 
		CASE red 
			IF NOT ( <red> > 99 ) 
				PlaySound MenuUp 
			ENDIF 
		CASE blue 
			IF NOT ( <blue> > 99 ) 
				PlaySound MenuUp 
			ENDIF 
		CASE green 
			IF NOT ( <green> > 99 ) 
				PlaySound MenuUp 
			ENDIF 
	ENDSWITCH 
	ApplyChangeGamma <...> change = 0.00999999978 
	wait 1 frame 
	gamma_menu_check_levels 
ENDSCRIPT

SCRIPT gamma_menu_turn_down 
	GetGammaValues 
	SWITCH <color> 
		CASE red 
			IF NOT ( 1 > <red> ) 
				PlaySound MenuUp 
			ENDIF 
		CASE blue 
			IF NOT ( 1 > <blue> ) 
				PlaySound MenuUp 
			ENDIF 
		CASE green 
			IF NOT ( 1 > <green> ) 
				PlaySound MenuUp 
			ENDIF 
	ENDSWITCH 
	ApplyChangeGamma <...> change = -0.00999999978 
	wait 1 frame 
	gamma_menu_check_levels 
ENDSCRIPT

SCRIPT create_split_menu callback_script = create_options_menu 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	FormatText ChecksumName = title_icon "%i_2_player" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	make_new_themed_sub_menu title = "SCREEN SETUP" title_icon = <title_icon> right_bracket_alpha = 0.00000000000 
	SetScreenElementProps { 
		id = sub_menu 
		event_handlers = [ { pad_back generic_menu_pad_back params = { callback = <callback_script> } } ] 
		replace_handlers 
	} 
	theme_menu_add_item text = "Horizontal" pad_choose_script = generic_menu_pad_choose centered = centered pad_choose_params = { <...> callback = split_setup_horizontal } 
	theme_menu_add_item text = "Vertical" last_menu_item = 1 centered = centered pad_choose_script = generic_menu_pad_choose pad_choose_params = { <...> callback = split_setup_vertical } 
	GoalManager_HideGoalPoints 
	GoalManager_HidePoints 
	finish_themed_sub_menu 
ENDSCRIPT

SCRIPT create_screen_menu callback_script = create_options_menu 
	FormatText ChecksumName = title_icon "%i_screen" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	make_new_themed_sub_menu title = "SCREEN" title_icon = <title_icon> 
	IF LevelIs load_skateshop 
		callback_script = create_setup_options_menu 
	ELSE 
		callback_script = create_options_menu 
	ENDIF 
	SetScreenElementProps { 
		id = sub_menu 
		event_handlers = [ { pad_back generic_menu_pad_back params = { callback = <callback_script> } } ] 
		replace_handlers 
	} 
	IF LevelIs load_skateshop 
		build_screen_menu_graphic 
	ENDIF 
	IF IsPS2 
		theme_menu_add_item text = "Standard" extra_text = "4:3" pad_choose_script = change_screen_mode pad_choose_params = { standard callback = screen_setup_standard mm_bg } 
		theme_menu_add_item text = "Widescreen" extra_text = "16:9" pad_choose_script = change_screen_mode pad_choose_params = { wide callback = screen_setup_widescreen mm_bg } 
		theme_menu_add_item text = "Letterbox" extra_text = "16:9" pad_choose_script = change_screen_mode pad_choose_params = { letter callback = screen_setup_letterbox mm_bg } 
	ENDIF 
	IF isngc 
		theme_menu_add_item text = "Standard" extra_text = "4:3" pad_choose_script = change_screen_mode pad_choose_params = { standard callback = screen_setup_standard mm_bg } 
		theme_menu_add_item text = "Widescreen" extra_text = "16:9" pad_choose_script = change_screen_mode pad_choose_params = { wide callback = screen_setup_widescreen mm_bg } 
	ENDIF 
	IF NOT IsTrue bootstrap_build 
		theme_menu_add_item text = "Done" id = screen_menu_done pad_choose_script = <callback_script> last_menu_item = 1 
	ENDIF 
	finish_themed_sub_menu 
ENDSCRIPT

SCRIPT change_screen_mode 
	IF LevelIs load_skateshop 
		KillSpawnedScript name = morph_tv_scan_line 
		IF GotParam standard 
			DoScreenElementMorph id = tv scale = PAIR(1.00000000000, 0.80000001192) 
			DoScreenElementMorph id = tv_thug_logo scale = PAIR(1.00000000000, 1.00000000000) 
			DoScreenElementMorph id = tv_black_bar alpha = 0 
			DoScreenElementMorph id = tv_black_bar2 alpha = 0 
		ENDIF 
		IF GotParam wide 
			DoScreenElementMorph id = tv scale = PAIR(1.52999997139, 0.80000001192) 
			DoScreenElementMorph id = tv_thug_logo scale = PAIR(1.52999997139, 1.00000000000) 
			DoScreenElementMorph id = tv_black_bar alpha = 0 
			DoScreenElementMorph id = tv_black_bar2 alpha = 0 
			scale = PAIR(32.00000000000, 0.25000000000) scale2 = PAIR(35.00000000000, 0.25000000000) 
			pos = PAIR(31.00000000000, -53.00000000000) pos2 = PAIR(-3.00000000000, 38.00000000000) 
		ENDIF 
		IF GotParam letter 
			DoScreenElementMorph id = tv scale = PAIR(1.00000000000, 0.80000001192) 
			DoScreenElementMorph id = tv_thug_logo scale = PAIR(1.25000000000, 0.80000001192) 
			DoScreenElementMorph id = tv_black_bar alpha = 1 
			DoScreenElementMorph id = tv_black_bar2 alpha = 1 
		ENDIF 
		RunScriptOnScreenElement id = tv_white_line morph_tv_scan_line params = { scale = <scale> scale2 = <scale2> pos = <pos> pos2 = <pos2> } 
	ENDIF 
	<callback> <...> 
ENDSCRIPT

SCRIPT build_screen_menu_graphic logo_scale = PAIR(1.00000000000, 1.00000000000) alpha = 0 tv_scale = PAIR(1.00000000000, 0.80000001192) 
	IF ( current_screen_mode = widescreen_screen_mode ) 
		logo_scale = PAIR(1.52999997139, 1.00000000000) 
		tv_scale = PAIR(1.52999997139, 0.80000001192) 
	ELSE 
		IF ( current_screen_mode = letterbox_screen_mode ) 
			logo_scale = PAIR(1.25000000000, 0.80000001192) 
			alpha = 1 
		ENDIF 
	ENDIF 
	CreateScreenElement { 
		type = ContainerElement 
		parent = current_menu_anchor 
		pos = PAIR(470.00000000000, 220.00000000000) 
		scale = 0.89999997616 
	} 
	anchor_id = <id> 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <anchor_id> 
		id = tv 
		texture = sc_icon_1 
		pos = PAIR(0.00000000000, 0.00000000000) 
		rot_angle = 20 
		just = [ center center ] 
		scale = <tv_scale> 
		alpha = 0.30000001192 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <anchor_id> 
		id = tv_thug_logo 
		texture = sc_icon_2 
		pos = PAIR(8.00000000000, -12.00000000000) 
		rot_angle = 20 
		just = [ center center ] 
		scale = <logo_scale> 
		alpha = 0.50000000000 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <anchor_id> 
		id = tv_black_bar 
		texture = white2 
		pos = PAIR(-56.00000000000, -90.00000000000) 
		rot_angle = 20 
		scale = PAIR(23.00000000000, 2.50000000000) 
		rgba = [ 0 0 0 128 ] 
		just = [ left top ] 
		alpha = <alpha> 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <anchor_id> 
		id = tv_black_bar2 
		texture = white2 
		pos = PAIR(-78.00000000000, -5.00000000000) 
		rot_angle = 20 
		scale = PAIR(21.00000000000, 2.50000000000) 
		rgba = [ 0 0 0 128 ] 
		just = [ left top ] 
		alpha = <alpha> 
	} 
	IF ( current_screen_mode = widescreen_screen_mode ) 
		scale = PAIR(32.00000000000, 0.25000000000) scale2 = PAIR(35.00000000000, 0.25000000000) 
		pos = PAIR(31.00000000000, -53.00000000000) pos2 = PAIR(-3.00000000000, 38.00000000000) 
	ENDIF 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <anchor_id> 
		id = tv_white_line 
		texture = white2 
		pos = PAIR(28.00000000000, -55.00000000000) 
		scale = <scale> 
		rot_angle = 20 
		just = [ center top ] 
		alpha = 0.10000000149 
		z_priority = 5 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = current_menu_anchor 
		id = so_rotating_bg 
		texture = bg_vector_1 
		rgba = [ 23 58 75 15 ] 
		just = [ center , center ] 
		pos = PAIR(210.00000000000, 180.00000000000) 
		z_priority = -4 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = current_menu_anchor 
		id = so_rotating_bg2 
		texture = bg_vector_1 
		rgba = [ 100 25 3 15 ] 
		just = [ center , center ] 
		pos = PAIR(210.00000000000, 180.00000000000) 
		z_priority = -3 
	} 
	spawnscript chap_new_rotating_bg params = { id = so_rotating_bg scale = 1.39999997616 rot_angle = -5752 } 
	spawnscript chap_new_rotating_bg_2 params = { id = so_rotating_bg2 scale = 1.10000002384 rot_angle = -5752 } 
	RunScriptOnScreenElement id = tv_thug_logo tv_logo_twitch 
	RunScriptOnScreenElement id = tv_white_line morph_tv_scan_line params = { scale = <scale> scale2 = <scale2> pos = <pos> pos2 = <pos2> } 
ENDSCRIPT

SCRIPT morph_tv_scan_line scale = PAIR(21.00000000000, 0.25000000000) scale2 = PAIR(22.79999923706, 0.25000000000) pos = PAIR(28.00000000000, -55.00000000000) pos2 = PAIR(-6.00000000000, 38.00000000000) 
	BEGIN 
		DoMorph pos = <pos> scale = <scale2> 
		DoMorph pos = <pos2> scale = <scale> time = 1.50000000000 
	REPEAT 
ENDSCRIPT

SCRIPT tv_logo_twitch id = tv_thug_logo time = 0.75000000000 
	BEGIN 
		DoScreenElementMorph id = <id> time = <time> scale = PAIR(1.00999999046, 0.99900001287) alpha = 0.44999998808 relative_scale 
		wait <time> seconds 
		DoScreenElementMorph id = <id> time = <time> scale = 1.00000000000 alpha = 0.50000000000 relative_scale 
		wait <time> seconds 
	REPEAT 
ENDSCRIPT

SCRIPT screen_option_update_hud_toggle 
	IF ( HIDEHUD = 1 ) 
		FormatText textname = text "HUD: off" 
	ELSE 
		FormatText textname = text "HUD: on" 
	ENDIF 
	SetScreenElementProps { 
		id = screen_option_hide_hud 
		text = <text> 
	} 
ENDSCRIPT

SCRIPT screen_setup_hide_hud 
	IF ( HIDEHUD = 0 ) 
		change HIDEHUD = 1 
	ELSE 
		change HIDEHUD = 0 
	ENDIF 
	screen_option_update_hud_toggle 
ENDSCRIPT

SCRIPT split_setup_horizontal 
	printf "changing split mode to horizontal" 
	SetScreenMode split_horizontal 
	ScreenElementSystemCleanup 
	IF GotParam end_run 
		create_end_run_menu 
	ELSE 
		create_pause_menu 
	ENDIF 
	UpdateScore 
	SetActivecamera id = skatercam0 viewport = 0 
	SetActivecamera id = skatercam1 viewport = 1 
ENDSCRIPT

SCRIPT split_setup_vertical 
	printf "changing split mode to vertical" 
	SetScreenMode split_vertical 
	ScreenElementSystemCleanup 
	IF GotParam end_run 
		create_end_run_menu 
	ELSE 
		create_pause_menu 
	ENDIF 
	UpdateScore 
	SetActivecamera id = skatercam0 viewport = 0 
	SetActivecamera id = skatercam1 viewport = 1 
ENDSCRIPT

SCRIPT launch_cheats_menu 
	RunScriptOnScreenElement id = current_menu_anchor animate_out callback = create_cheats_menu 
ENDSCRIPT

SCRIPT create_cheats_menu 
	GoalManager_HidePoints 
	GoalManager_HideGoalPoints 
	make_new_menu { 
		padding_scale = 1 
		menu_id = cheats_menu 
		vmenu_id = cheats_vmenu 
		menu_title = "CHEATS" 
		padding_scale = 0.89999997616 
		pos = PAIR(230.00000000000, 40.00000000000) 
		helper_text = generic_helper_text 
	} 
	kill_start_key_binding 
	SetScreenElementProps { id = cheats_menu 
		event_handlers = [ { pad_back create_options_menu } ] 
	} 
	make_text_sub_menu_item text = "Time of Day" pad_choose_script = launch_timeofday_menu 
	make_text_sub_menu_item text = "View Cutscenes" pad_choose_script = launch_view_cutscenes_menu 
	make_toggle_menu_item id = cheats_menu_level_lock text = "Levels unlocked: " pad_choose_script = cheats_menu_change_level_lock 
	make_text_sub_menu_item text = "Advance Stage" pad_choose_script = cheats_menu_advance_stage 
	make_text_sub_menu_item text = "Set Chapter/Stage" pad_choose_script = launch_chapter_stage_menu 
	make_text_sub_menu_item text = "100 Stat Points" pad_choose_script = cheats_menu_100_stat_points 
	IF GoalManager_HasActiveGoals 
		make_text_sub_menu_item text = "Beat current goal" pad_choose_script = cheats_menu_beat_current_goal 
	ENDIF 
	make_text_sub_menu_item text = "Unlock all chapters" pad_choose_script = unlock_all_chapters 
	make_text_sub_menu_item text = "Unlock all stats goals" pad_choose_script = cheats_menu_UnlockAllStatsGoals 
	make_text_sub_menu_item text = "Score 5 million points" pad_choose_script = cheats_menu_score5mil 
	make_text_sub_menu_item text = "Mark all goals unbeaten" pad_choose_script = cheats_menu_UnBeatAllGoals 
	make_text_sub_menu_item text = "Set Difficulty Level" pad_choose_script = launch_cheats_menu_select_difficulty 
	RunScriptOnScreenElement id = cheats_menu_level_lock cheats_menu_check_level_lock 
	FireEvent type = focus target = cheats_menu 
ENDSCRIPT

SCRIPT cheats_menu_change_flag 
	GetTags 
	IF GetGlobalFlag flag = <flag> 
		UnSetGlobalFlag flag = <flag> 
		toggle_menu_item_off id = <id> 
	ELSE 
		SetGlobalFlag flag = <flag> 
		toggle_menu_item_on id = <id> 
	ENDIF 
ENDSCRIPT

SCRIPT cheats_menu_check_flag 
	GetTags 
	IF GetGlobalFlag flag = <flag> 
		toggle_menu_item_on id = <id> 
	ELSE 
		toggle_menu_item_off id = <id> 
	ENDIF 
ENDSCRIPT

SCRIPT cheats_menu_check_level_lock 
	GetTags 
	IF IntegerEquals a = all_levels_unlocked b = 1 
		toggle_menu_item_on id = <id> 
	ELSE 
		toggle_menu_item_off id = <id> 
	ENDIF 
ENDSCRIPT

SCRIPT cheats_menu_change_level_lock 
	GetTags 
	IF IntegerEquals a = all_levels_unlocked b = 1 
		toggle_menu_item_off id = <id> 
		change all_levels_unlocked = 0 
	ELSE 
		IF IntegerEquals a = all_levels_unlocked b = 0 
			toggle_menu_item_on id = <id> 
			change all_levels_unlocked = 1 
		ENDIF 
	ENDIF 
	pulse_item 
ENDSCRIPT

SCRIPT cheats_menu_check_cool_special 
	GetTags 
	IF IntegerEquals a = COOL_SPECIAL_TRICKS b = 1 
		toggle_menu_item_on id = <id> 
	ELSE 
		toggle_menu_item_off id = <id> 
	ENDIF 
ENDSCRIPT

SCRIPT cheats_menu_change_cool_special 
	GetTags 
	IF IntegerEquals a = COOL_SPECIAL_TRICKS b = 1 
		toggle_menu_item_off id = <id> 
		change COOL_SPECIAL_TRICKS = 0 
	ELSE 
		IF IntegerEquals a = COOL_SPECIAL_TRICKS b = 0 
			toggle_menu_item_on id = <id> 
			change COOL_SPECIAL_TRICKS = 1 
		ENDIF 
	ENDIF 
	pulse_item 
ENDSCRIPT

SCRIPT cheats_menu_100_stat_points 
	AwardStatPoint 100 
	pulse_item 
ENDSCRIPT

SCRIPT cheats_menu_UnlockAllGoals 
	GoalManager_UnlockAllGoals 
	pulse_item 
ENDSCRIPT

SCRIPT cheats_menu_UnlockAllStatsGoals 
	skater : StatsManager_UnlockAmGoals 
	skater : StatsManager_UnlockProGoals 
	pulse_item 
ENDSCRIPT

SCRIPT cheats_menu_score5mil 
	skater : SetTrickName "You cheat like Kurt" 
	skater : SetTrickScore 5000000 
	skater : display 
ENDSCRIPT

SCRIPT cheats_menu_turnPro 
	GoalManager_TurnPro 
ENDSCRIPT

SCRIPT cheats_menu_UnBeatAllGoals 
	GoalManager_UnBeatAllGoals 
	GoalManager_UninitializeAllGoals 
	GoalManager_InitializeAllGoals 
ENDSCRIPT

SCRIPT cheats_menu_addgoalpoint 
	GoalManager_AddGoalPoint 
ENDSCRIPT

SCRIPT cheats_menu_unlockProChallenges 
	GoalManager_UnlockProSpecificChallenges 
ENDSCRIPT

SCRIPT cheats_menu_cash 
	GoalManager_AddCash 5000 
ENDSCRIPT

SCRIPT cheats_menu_beat_current_goal 
	IF GoalManager_GetActiveGoalId 
		exit_pause_menu 
		GoalManager_WinGoal name = <goal_id> 
	ENDIF 
ENDSCRIPT

SCRIPT cheats_menu_advance_stage 
	exit_pause_menu 
	GoalManager_DeactivateAllGoals 
	GoalManager_GetCurrentChapterAndStage 
	GoalManager_AdvanceStage force 
	<stage_struct> = ( ( CHAPTER_COMPLETION_SCRIPTS [ <currentchapter> ] ) [ <currentstage> ] ) 
	IF StructureContains structure = <stage_struct> script_name 
		<stage_script> = ( <stage_struct> . script_name ) 
	ENDIF 
	IF StructureContains structure = <stage_struct> params 
		<stage_script_params> = ( <stage_struct> . params ) 
	ENDIF 
	<stage_script> <stage_script_params> just_won_goal 
ENDSCRIPT

SCRIPT launch_cheats_menu_select_difficulty 
	IF ScreenElementExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	make_new_menu { 
		menu_id = cheats_select_difficulty_menu 
		vmenu_id = cheats_select_difficulty_vmenu 
		menu_title = "SET DIFFICULTY" 
		helper_text = generic_helper_text_left_right 
	} 
	make_text_sub_menu_item { 
		text = "Easy" 
		id = cheats_difficulty_easy 
		pad_choose_script = cheats_menu_set_difficulty 
		pad_choose_params = { difficulty = 0 } 
	} 
	make_text_sub_menu_item { 
		text = "Normal" 
		id = cheats_difficulty_normal 
		pad_choose_script = cheats_menu_set_difficulty 
		pad_choose_params = { difficulty = 1 } 
	} 
	make_text_sub_menu_item { 
		text = "Sick" 
		id = cheats_difficulty_sick 
		pad_choose_script = cheats_menu_set_difficulty 
		pad_choose_params = { difficulty = 2 } 
	} 
	FireEvent type = focus target = cheats_select_difficulty_menu 
ENDSCRIPT

SCRIPT cheats_menu_set_difficulty 
	GoalManager_SetDifficultyLevel <difficulty> 
	GoalManager_UninitializeAllGoals 
	GoalManager_InitializeAllGoals 
	launch_cheats_menu 
ENDSCRIPT

SCRIPT launch_chapter_stage_menu 
	RunScriptOnScreenElement id = current_menu_anchor animate_out callback = create_chapter_stage_menu 
ENDSCRIPT

SCRIPT create_chapter_stage_menu 
	GoalManager_GetCurrentChapterAndStage 
	SetScreenElementLock id = root_window off 
	make_new_menu { 
		menu_id = chapter_stage_menu 
		vmenu_id = chapter_stage_vmenu 
		menu_title = "SET CHAPTER/STAGE" 
		helper_text = generic_helper_text_left_right 
	} 
	CreateScreenElement { 
		type = ContainerElement 
		parent = chapter_stage_vmenu 
		id = chapter_stage_menu_chapter_container 
		dims = PAIR(100.00000000000, 20.00000000000) 
		event_handlers = [ 
			{ focus chapter_stage_menu_focus } 
			{ unfocus chapter_stage_menu_unfocus } 
			{ pad_right chapter_stage_menu_change params = { chapter right } } 
			{ pad_left chapter_stage_menu_change params = { chapter left } } 
		] 
	} 
	CreateScreenElement { 
		type = ContainerElement 
		parent = chapter_stage_vmenu 
		id = chapter_stage_menu_stage_container 
		dims = PAIR(100.00000000000, 20.00000000000) 
		event_handlers = [ 
			{ focus chapter_stage_menu_focus } 
			{ unfocus chapter_stage_menu_unfocus } 
			{ pad_right chapter_stage_menu_change params = { stage right } } 
			{ pad_left chapter_stage_menu_change params = { stage left } } 
		] 
	} 
	CreateScreenElement { 
		type = TextElement 
		parent = chapter_stage_vmenu 
		font = small 
		text = "Done" 
		event_handlers = [ 
			{ pad_choose chapter_stage_menu_done } 
			{ focus do_scale_up } 
			{ unfocus do_scale_down } 
		] 
		rgba = [ 128 128 128 128 ] 
	} 
	CreateScreenElement { 
		type = TextElement 
		parent = chapter_stage_menu_chapter_container 
		font = small 
		text = "Chapter" 
		just = [ left top ] 
		rgba = [ 128 128 128 128 ] 
	} 
	CreateScreenElement { 
		type = TextElement 
		parent = chapter_stage_menu_stage_container 
		font = small 
		text = "Stage" 
		just = [ left top ] 
		rgba = [ 128 128 128 128 ] 
	} 
	FormatText textname = currentChapterText "%i" i = <currentchapter> 
	CreateScreenElement { 
		type = TextElement 
		parent = chapter_stage_menu_chapter_container 
		font = small 
		text = <currentChapterText> 
		just = [ right top ] 
		rgba = [ 128 128 128 128 ] 
		pos = PAIR(120.00000000000, 0.00000000000) 
	} 
	FormatText textname = currentStageText "%i" i = <currentstage> 
	CreateScreenElement { 
		type = TextElement 
		parent = chapter_stage_menu_stage_container 
		font = small 
		text = <currentStageText> 
		just = [ right top ] 
		rgba = [ 128 128 128 128 ] 
		pos = PAIR(120.00000000000, 0.00000000000) 
	} 
	FireEvent type = focus target = chapter_stage_vmenu 
ENDSCRIPT

SCRIPT chapter_stage_menu_focus 
	GetTags 
	RunScriptOnScreenElement id = { <id> child = 1 } do_scale_up 
ENDSCRIPT

SCRIPT chapter_stage_menu_unfocus 
	GetTags 
	RunScriptOnScreenElement id = { <id> child = 1 } do_scale_down 
ENDSCRIPT

SCRIPT chapter_stage_menu_change 
	GoalManager_GetCurrentChapterAndStage 
	IF GotParam left 
		<change> = -1 
	ELSE 
		<change> = 1 
	ENDIF 
	IF GotParam chapter 
		<currentchapter> = ( <currentchapter> + <change> ) 
		IF ( <currentchapter> < 0 ) 
			RETURN 
		ELSE 
			IF ( <currentchapter> > 30 ) 
				RETURN 
			ENDIF 
		ENDIF 
	ELSE 
		<currentstage> = ( <currentstage> + <change> ) 
		IF ( <currentstage> < 0 ) 
			RETURN 
		ELSE 
			IF ( <currentstage> > 10 ) 
				RETURN 
			ENDIF 
		ENDIF 
	ENDIF 
	GoalManager_SetCurrentChapterAndStage chapter = <currentchapter> stage = <currentstage> 
	GetTags 
	IF GotParam chapter 
		FormatText textname = chapterText "%i" i = <currentchapter> 
		SetScreenElementProps { 
			id = { <id> child = 1 } 
			text = <chapterText> 
		} 
	ELSE 
		FormatText textname = stageText "%i" i = <currentstage> 
		SetScreenElementProps { 
			id = { <id> child = 1 } 
			text = <stageText> 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT chapter_stage_menu_done 
	GoalManager_DeactivateAllGoals 
	GoalManager_UninitializeAllGoals 
	GoalManager_InitializeAllGoals 
	launch_cheats_menu 
ENDSCRIPT

SCRIPT create_controller_config_menu 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	IF GotParam controller_number 
		IF ( <controller_number> = -1 ) 
			FormatText textname = menu_title "COMMON" n = <controller_number> 
		ELSE 
			FormatText textname = menu_title "PLAYER %n" n = <controller_number> 
		ENDIF 
		helper_text = { helper_text_elements = [ { text = "\\b7/\\b4 = Select" } 
				{ text = "\\b6/\\b5 = Adjust" } 
				{ text = "\\bn = Back" } 
				{ text = "\\bm = Accept" } 
			] 
		} 
	ELSE 
		menu_title = "CONTROL SETUP" 
		helper_text = { helper_text_elements = [ { text = "\\b7/\\b4 = Select" } 
				{ text = "\\bn = Back" } 
				{ text = "\\bm = Accept" } 
			] 
		} 
	ENDIF 
	FormatText ChecksumName = title_icon "%i_control" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	make_new_themed_sub_menu title = <menu_title> title_icon = <title_icon> 
	IF LevelIs load_skateshop 
		build_top_and_bottom_blocks 
		make_mainmenu_3d_plane 
		change joystick_pushed = 0 
		control_options_graphic 
		SetScreenElementProps { id = sub_vmenu event_handlers = [ 
				{ pad_up animate_joystick params = { dir = up } } 
				{ pad_down animate_joystick params = { dir = down } } 
			] 
		} 
	ENDIF 
	kill_start_key_binding 
	IF isngc 
		<vibration_text> = "Rumble" 
	ELSE 
		<vibration_text> = "Vibration" 
	ENDIF 
	IF GotParam from_options 
		<from_options> = from_options 
	ENDIF 
	IF GotParam controller_number 
		IF GotParam from_options 
			SetScreenElementProps { id = sub_menu 
				event_handlers = [ 
					{ pad_back generic_menu_pad_back params = { callback = controller_config_exit from_options = <from_options> } } 
				] 
			} 
		ELSE 
			SetScreenElementProps { id = sub_menu 
				event_handlers = [ 
					{ pad_back generic_menu_pad_back params = { callback = create_controller_config_menu from_options = <from_options> } } 
				] 
			} 
		ENDIF 
		IF NOT ( <controller_number> = -1 ) 
			theme_menu_add_item { text = <vibration_text> 
				id = menu_vibration 
				focus_script = controller_config_focus 
				unfocus_script = controller_config_unfocus 
				pad_choose_script = nullscript 
			} 
			theme_menu_add_item { text = "Autokick" 
				id = menu_autokick 
				focus_script = controller_config_focus 
				unfocus_script = controller_config_unfocus 
				pad_choose_script = nullscript 
			} 
			theme_menu_add_item { text = "180 Spin Taps" 
				id = menu_spintaps 
				focus_script = controller_config_focus 
				unfocus_script = controller_config_unfocus 
				pad_choose_script = nullscript 
			} 
		ENDIF 
		IF ( <controller_number> = 1 ) 
			IF NOT LevelIs load_skateshop 
				IF ( ( InNetGame ) & ( GetGlobalFlag flag = FLAG_G_EXPERT_MODE_NO_REVERTS ) ) 
					theme_menu_add_item { text = "No Reverts" 
						id = menu_reverts 
						focus_script = controller_config_focus 
						unfocus_script = controller_config_unfocus 
						pad_choose_script = nullscript 
						not_focusable = not_focusable 
					} 
				ELSE 
					theme_menu_add_item { text = "No Reverts" 
						id = menu_reverts 
						focus_script = controller_config_focus 
						unfocus_script = controller_config_unfocus 
						pad_choose_script = nullscript 
					} 
				ENDIF 
				IF ( ( InNetGame ) & ( GetGlobalFlag flag = FLAG_G_EXPERT_MODE_NO_MANUALS ) ) 
					theme_menu_add_item { text = "No Manuals" 
						id = menu_manuals 
						focus_script = controller_config_focus 
						unfocus_script = controller_config_unfocus 
						pad_choose_script = nullscript 
						not_focusable = not_focusable 
					} 
				ELSE 
					theme_menu_add_item { text = "No Manuals" 
						id = menu_manuals 
						focus_script = controller_config_focus 
						unfocus_script = controller_config_unfocus 
						pad_choose_script = nullscript 
					} 
				ENDIF 
				IF ( ( InNetGame ) & ( GetGlobalFlag flag = FLAG_G_EXPERT_MODE_NO_WALKING ) ) 
					theme_menu_add_item { text = "No Walking" 
						id = menu_walking 
						focus_script = controller_config_focus 
						unfocus_script = controller_config_unfocus 
						pad_choose_script = nullscript 
						not_focusable = not_focusable 
					} 
				ELSE 
					theme_menu_add_item { text = "No Walking" 
						id = menu_walking 
						focus_script = controller_config_focus 
						unfocus_script = controller_config_unfocus 
						pad_choose_script = nullscript 
					} 
				ENDIF 
			ENDIF 
		ENDIF 
		IF ( <controller_number> = -1 ) 
			IF ( ( InNetGame ) & ( GetGlobalFlag flag = FLAG_G_EXPERT_MODE_NO_REVERTS ) ) 
				theme_menu_add_item { text = "No Reverts" 
					id = menu_reverts 
					focus_script = controller_config_focus 
					unfocus_script = controller_config_unfocus 
					pad_choose_script = nullscript 
					not_focusable = not_focusable 
				} 
			ELSE 
				theme_menu_add_item { text = "No Reverts" 
					id = menu_reverts 
					focus_script = controller_config_focus 
					unfocus_script = controller_config_unfocus 
					pad_choose_script = nullscript 
				} 
			ENDIF 
			IF ( ( InNetGame ) & ( GetGlobalFlag flag = FLAG_G_EXPERT_MODE_NO_MANUALS ) ) 
				theme_menu_add_item { text = "No Manuals" 
					id = menu_manuals 
					focus_script = controller_config_focus 
					unfocus_script = controller_config_unfocus 
					pad_choose_script = nullscript 
					not_focusable = not_focusable 
				} 
			ELSE 
				theme_menu_add_item { text = "No Manuals" 
					id = menu_manuals 
					focus_script = controller_config_focus 
					unfocus_script = controller_config_unfocus 
					pad_choose_script = nullscript 
				} 
			ENDIF 
			IF ( ( InNetGame ) & ( GetGlobalFlag flag = FLAG_G_EXPERT_MODE_NO_WALKING ) ) 
				theme_menu_add_item { text = "No Walking" 
					id = menu_walking 
					focus_script = controller_config_focus 
					unfocus_script = controller_config_unfocus 
					pad_choose_script = nullscript 
					not_focusable = not_focusable 
				} 
			ELSE 
				theme_menu_add_item { text = "No Walking" 
					id = menu_walking 
					focus_script = controller_config_focus 
					unfocus_script = controller_config_unfocus 
					pad_choose_script = nullscript 
				} 
			ENDIF 
		ENDIF 
		IF GotParam from_options 
			theme_menu_add_item { text = "Done" 
				id = menu_done 
				pad_choose_script = generic_menu_pad_choose 
				pad_choose_params = { callback = controller_config_exit from_options = <from_options> } 
				last_menu_item = last_menu_item 
			} 
		ELSE 
			theme_menu_add_item { text = "Done" 
				id = menu_done 
				pad_choose_script = generic_menu_pad_choose 
				pad_choose_params = { callback = create_controller_config_menu from_options = <from_options> } 
				last_menu_item = last_menu_item 
			} 
		ENDIF 
		control_config_show_values controller_number = <controller_number> 
	ELSE 
		SetScreenElementProps { id = sub_menu 
			event_handlers = [ 
				{ pad_back generic_menu_pad_back params = { callback = controller_config_exit from_options = <from_options> } } 
			] 
		} 
		theme_menu_add_item { text = "Player 1" 
			id = menu_controller_1 
			pad_choose_script = generic_menu_pad_choose 
			pad_choose_params = { callback = create_controller_config_menu controller_number = 1 from_options = <from_options> } 
			centered 
		} 
		theme_menu_add_item { text = "Player 2" 
			id = menu_controller_2 
			pad_choose_script = generic_menu_pad_choose 
			pad_choose_params = { callback = create_controller_config_menu controller_number = 2 from_options = <from_options> } 
			centered 
		} 
		theme_menu_add_item { text = "Common" 
			id = menu_controller_x 
			pad_choose_script = generic_menu_pad_choose 
			pad_choose_params = { callback = create_controller_config_menu controller_number = -1 from_options = <from_options> } 
			centered 
		} 
		theme_menu_add_item { text = "Done" 
			id = menu_done 
			pad_choose_script = generic_menu_pad_choose 
			pad_choose_params = { callback = controller_config_exit from_options = <from_options> } 
			last_menu_item = last_menu_item 
			centered 
		} 
	ENDIF 
	finish_themed_sub_menu 
	create_helper_text <helper_text> 
ENDSCRIPT

SCRIPT controller_config_exit 
	KillSpawnedScript name = chap_new_rotating_bg 
	KillSpawnedScript name = chap_new_rotating_bg2 
	KillSpawnedScript name = shake_projector 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	IF GotParam from_options 
		create_options_menu 
	ELSE 
		create_setup_options_menu 
	ENDIF 
ENDSCRIPT

SCRIPT control_change_values 
	player = ( <controller_number> - 1 ) 
	IF GotParam vibration 
		KillSpawnedScript name = control_menu_vibrate_controller 
		VibrateController port = <player> actuator = 1 percent = 0 
		IF VibrationIsOn <player> 
			VibrationOff <player> 
			SetScreenElementProps id = menu_vibration_value text = "off" 
		ELSE 
			VibrationOn <player> 
			SetScreenElementProps id = menu_vibration_value text = "on" 
			spawnscript control_menu_vibrate_controller params = <...> 
		ENDIF 
	ENDIF 
	IF GotParam autokick 
		IF AutokickIsOn <player> 
			AutokickOff <player> 
			SetScreenElementProps id = menu_autokick_value text = "off" 
		ELSE 
			AutokickOn <player> 
			SetScreenElementProps id = menu_autokick_value text = "on" 
		ENDIF 
	ENDIF 
	IF GotParam spintaps 
		IF SpinTapsAreOn <player> 
			SpinTapsOff <player> 
			SetScreenElementProps id = menu_spintaps_value text = "off" 
		ELSE 
			SpinTapsOn <player> 
			SetScreenElementProps id = menu_spintaps_value text = "on" 
		ENDIF 
	ENDIF 
	IF GotParam reverts 
		IF NOT ( GetGlobalFlag flag = FLAG_EXPERT_MODE_NO_REVERTS ) 
			SetGlobalFlag flag = FLAG_EXPERT_MODE_NO_REVERTS 
			SetScreenElementProps id = menu_reverts_value text = "on" 
		ELSE 
			UnSetGlobalFlag flag = FLAG_EXPERT_MODE_NO_REVERTS 
			SetScreenElementProps id = menu_reverts_value text = "off" 
		ENDIF 
	ENDIF 
	IF GotParam manuals 
		IF NOT ( GetGlobalFlag flag = FLAG_EXPERT_MODE_NO_MANUALS ) 
			SetGlobalFlag flag = FLAG_EXPERT_MODE_NO_MANUALS 
			SetScreenElementProps id = menu_manuals_value text = "on" 
		ELSE 
			UnSetGlobalFlag flag = FLAG_EXPERT_MODE_NO_MANUALS 
			SetScreenElementProps id = menu_manuals_value text = "off" 
		ENDIF 
	ENDIF 
	IF GotParam Walking 
		IF NOT ( GetGlobalFlag flag = FLAG_EXPERT_MODE_NO_WALKING ) 
			SetGlobalFlag flag = FLAG_EXPERT_MODE_NO_WALKING 
			SetScreenElementProps id = menu_walking_value text = "on" 
		ELSE 
			UnSetGlobalFlag flag = FLAG_EXPERT_MODE_NO_WALKING 
			SetScreenElementProps id = menu_walking_value text = "off" 
		ENDIF 
	ENDIF 
	GetTags 
	IF GotParam left 
		RunScriptOnScreenElement id = { <id> child = 5 } menu_blink_arrow 
	ELSE 
		RunScriptOnScreenElement id = { <id> child = 6 } menu_blink_arrow 
	ENDIF 
	generic_menu_pad_choose_sound 
	TemporarilyDisableInput time = 100 
ENDSCRIPT

SCRIPT control_menu_vibrate_controller 
	IF ScreenElementExists id = joystick_anchor 
		spawnscript shake_projector params = { id = joystick_anchor amplitude = 5 time = 0.05000000075 } 
	ENDIF 
	IF LevelIs load_skateshop 
		VibrateController port = <player> actuator = 1 percent = 70 
		wait 250 
		VibrateController port = <player> actuator = 1 percent = 0 
		KillSpawnedScript name = shake_projector 
	ELSE 
		index = 0 
		BEGIN 
			IF ControllerBoundToSkater controller = <index> skater = <player> 
				VibrateController port = <index> actuator = 1 percent = 70 
				wait 250 
				VibrateController port = <index> actuator = 1 percent = 0 
				KillSpawnedScript name = shake_projector 
				BREAK 
			ENDIF 
			index = ( <index> + 1 ) 
		REPEAT 4 
	ENDIF 
	IF ScreenElementExists id = joystick_anchor 
		DoScreenElementMorph id = joystick_anchor pos = PAIR(340.00000000000, 30.00000000000) time = 0.10000000149 
	ENDIF 
ENDSCRIPT

joystick_pushed = 0 
SCRIPT control_config_show_values 
	FormatText ChecksumName = text_color "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	player = ( <controller_number> - 1 ) 
	IF NOT ( <controller_number> = -1 ) 
		IF VibrationIsOn <player> 
			vibration_value = "on" 
		ELSE 
			vibration_value = "off" 
		ENDIF 
		IF AutokickIsOn <player> 
			autokick_value = "on" 
		ELSE 
			autokick_value = "off" 
		ENDIF 
		IF SpinTapsAreOn <player> 
			spintaps_value = "on" 
		ELSE 
			spintaps_value = "off" 
		ENDIF 
	ENDIF 
	IF ( <controller_number> = 1 ) 
		IF NOT LevelIs load_skateshop 
			IF NOT ( GetGlobalFlag flag = FLAG_EXPERT_MODE_NO_REVERTS ) 
				reverts_value = "off" 
			ELSE 
				reverts_value = "on" 
			ENDIF 
			IF NOT ( GetGlobalFlag flag = FLAG_EXPERT_MODE_NO_WALKING ) 
				walking_value = "off" 
			ELSE 
				walking_value = "on" 
			ENDIF 
			IF NOT ( GetGlobalFlag flag = FLAG_EXPERT_MODE_NO_MANUALS ) 
				manuals_value = "off" 
			ELSE 
				manuals_value = "on" 
			ENDIF 
		ENDIF 
	ENDIF 
	IF ( <controller_number> = -1 ) 
		IF NOT ( GetGlobalFlag flag = FLAG_EXPERT_MODE_NO_REVERTS ) 
			reverts_value = "off" 
		ELSE 
			reverts_value = "on" 
		ENDIF 
		IF NOT ( GetGlobalFlag flag = FLAG_EXPERT_MODE_NO_WALKING ) 
			walking_value = "off" 
		ELSE 
			walking_value = "on" 
		ENDIF 
		IF NOT ( GetGlobalFlag flag = FLAG_EXPERT_MODE_NO_MANUALS ) 
			manuals_value = "off" 
		ELSE 
			manuals_value = "on" 
		ENDIF 
	ENDIF 
	IF NOT ( <controller_number> = -1 ) 
		CreateScreenElement { 
			type = TextElement 
			parent = menu_vibration 
			id = menu_vibration_value 
			font = small 
			just = [ center top ] 
			pos = PAIR(142.00000000000, -17.00000000000) 
			text = <vibration_value> 
			rgba = <text_color> 
		} 
		CreateScreenElement { 
			type = SpriteElement 
			parent = menu_vibration 
			texture = left_arrow 
			rgba = [ 128 128 128 0 ] 
			pos = PAIR(122.00000000000, -17.00000000000) 
			just = [ right top ] 
			scale = 0.75000000000 
		} 
		CreateScreenElement { 
			type = SpriteElement 
			parent = menu_vibration 
			texture = right_arrow 
			rgba = [ 128 128 128 0 ] 
			pos = PAIR(162.00000000000, -17.00000000000) 
			just = [ left top ] 
			scale = 0.75000000000 
		} 
		CreateScreenElement { 
			type = TextElement 
			parent = menu_autokick 
			id = menu_autokick_value 
			font = small 
			just = [ center top ] 
			pos = PAIR(142.00000000000, -17.00000000000) 
			text = <autokick_value> 
			rgba = <text_color> 
		} 
		CreateScreenElement { 
			type = SpriteElement 
			parent = menu_autokick 
			texture = left_arrow 
			rgba = [ 128 128 128 0 ] 
			pos = PAIR(122.00000000000, -17.00000000000) 
			just = [ right top ] 
			scale = 0.75000000000 
		} 
		CreateScreenElement { 
			type = SpriteElement 
			parent = menu_autokick 
			texture = right_arrow 
			rgba = [ 128 128 128 0 ] 
			pos = PAIR(162.00000000000, -17.00000000000) 
			just = [ left top ] 
			scale = 0.75000000000 
		} 
		CreateScreenElement { 
			type = TextElement 
			parent = menu_spintaps 
			id = menu_spintaps_value 
			font = small 
			just = [ center top ] 
			pos = PAIR(142.00000000000, -17.00000000000) 
			text = <spintaps_value> 
			rgba = <text_color> 
		} 
		CreateScreenElement { 
			type = SpriteElement 
			parent = menu_spintaps 
			texture = left_arrow 
			rgba = [ 128 128 128 0 ] 
			pos = PAIR(122.00000000000, -17.00000000000) 
			just = [ right top ] 
			scale = 0.75000000000 
		} 
		CreateScreenElement { 
			type = SpriteElement 
			parent = menu_spintaps 
			texture = right_arrow 
			rgba = [ 128 128 128 0 ] 
			pos = PAIR(162.00000000000, -17.00000000000) 
			just = [ left top ] 
			scale = 0.75000000000 
		} 
	ENDIF 
	IF ( <controller_number> = 1 ) 
		IF NOT LevelIs load_skateshop 
			IF ( ( InNetGame ) & ( GetGlobalFlag flag = FLAG_G_EXPERT_MODE_NO_REVERTS ) ) 
				<rgba> = [ 60 60 60 75 ] 
			ELSE 
				<rgba> = <text_color> 
			ENDIF 
			CreateScreenElement { 
				type = TextElement 
				parent = menu_reverts 
				id = menu_reverts_value 
				font = small 
				just = [ center top ] 
				pos = PAIR(142.00000000000, -17.00000000000) 
				text = <reverts_value> 
				rgba = <rgba> 
			} 
			CreateScreenElement { 
				type = SpriteElement 
				parent = menu_reverts 
				texture = left_arrow 
				rgba = [ 128 128 128 0 ] 
				pos = PAIR(122.00000000000, -17.00000000000) 
				just = [ right top ] 
				scale = 0.75000000000 
			} 
			CreateScreenElement { 
				type = SpriteElement 
				parent = menu_reverts 
				texture = right_arrow 
				rgba = [ 128 128 128 0 ] 
				pos = PAIR(162.00000000000, -17.00000000000) 
				just = [ left top ] 
				scale = 0.75000000000 
			} 
			IF ( ( InNetGame ) & ( GetGlobalFlag flag = FLAG_G_EXPERT_MODE_NO_MANUALS ) ) 
				<rgba> = [ 60 60 60 75 ] 
			ELSE 
				<rgba> = <text_color> 
			ENDIF 
			CreateScreenElement { 
				type = TextElement 
				parent = menu_manuals 
				id = menu_manuals_value 
				font = small 
				just = [ center top ] 
				pos = PAIR(142.00000000000, -17.00000000000) 
				text = <manuals_value> 
				rgba = <rgba> 
			} 
			CreateScreenElement { 
				type = SpriteElement 
				parent = menu_manuals 
				texture = left_arrow 
				rgba = [ 128 128 128 0 ] 
				pos = PAIR(122.00000000000, -17.00000000000) 
				just = [ right top ] 
				scale = 0.75000000000 
			} 
			CreateScreenElement { 
				type = SpriteElement 
				parent = menu_manuals 
				texture = right_arrow 
				rgba = [ 128 128 128 0 ] 
				pos = PAIR(162.00000000000, -17.00000000000) 
				just = [ left top ] 
				scale = 0.75000000000 
			} 
			IF ( ( InNetGame ) & ( GetGlobalFlag flag = FLAG_G_EXPERT_MODE_NO_WALKING ) ) 
				<rgba> = [ 60 60 60 75 ] 
			ELSE 
				<rgba> = <text_color> 
			ENDIF 
			CreateScreenElement { 
				type = TextElement 
				parent = menu_walking 
				id = menu_walking_value 
				font = small 
				just = [ center top ] 
				pos = PAIR(142.00000000000, -17.00000000000) 
				text = <walking_value> 
				rgba = <rgba> 
			} 
			CreateScreenElement { 
				type = SpriteElement 
				parent = menu_walking 
				texture = left_arrow 
				rgba = [ 128 128 128 0 ] 
				pos = PAIR(122.00000000000, -17.00000000000) 
				just = [ right top ] 
				scale = 0.75000000000 
			} 
			CreateScreenElement { 
				type = SpriteElement 
				parent = menu_walking 
				texture = right_arrow 
				rgba = [ 128 128 128 0 ] 
				pos = PAIR(162.00000000000, -17.00000000000) 
				just = [ left top ] 
				scale = 0.75000000000 
			} 
		ENDIF 
	ENDIF 
	IF ( <controller_number> = -1 ) 
		IF ( ( InNetGame ) & ( GetGlobalFlag flag = FLAG_G_EXPERT_MODE_NO_REVERTS ) ) 
			<rgba> = [ 60 60 60 75 ] 
		ELSE 
			<rgba> = <text_color> 
		ENDIF 
		CreateScreenElement { 
			type = TextElement 
			parent = menu_reverts 
			id = menu_reverts_value 
			font = small 
			just = [ center top ] 
			pos = PAIR(142.00000000000, -17.00000000000) 
			text = <reverts_value> 
			rgba = <rgba> 
		} 
		CreateScreenElement { 
			type = SpriteElement 
			parent = menu_reverts 
			texture = left_arrow 
			rgba = [ 128 128 128 0 ] 
			pos = PAIR(122.00000000000, -17.00000000000) 
			just = [ right top ] 
			scale = 0.75000000000 
		} 
		CreateScreenElement { 
			type = SpriteElement 
			parent = menu_reverts 
			texture = right_arrow 
			rgba = [ 128 128 128 0 ] 
			pos = PAIR(162.00000000000, -17.00000000000) 
			just = [ left top ] 
			scale = 0.75000000000 
		} 
		IF ( ( InNetGame ) & ( GetGlobalFlag flag = FLAG_G_EXPERT_MODE_NO_MANUALS ) ) 
			<rgba> = [ 60 60 60 75 ] 
		ELSE 
			<rgba> = <text_color> 
		ENDIF 
		CreateScreenElement { 
			type = TextElement 
			parent = menu_manuals 
			id = menu_manuals_value 
			font = small 
			just = [ center top ] 
			pos = PAIR(142.00000000000, -17.00000000000) 
			text = <manuals_value> 
			rgba = <rgba> 
		} 
		CreateScreenElement { 
			type = SpriteElement 
			parent = menu_manuals 
			texture = left_arrow 
			rgba = [ 128 128 128 0 ] 
			pos = PAIR(122.00000000000, -17.00000000000) 
			just = [ right top ] 
			scale = 0.75000000000 
		} 
		CreateScreenElement { 
			type = SpriteElement 
			parent = menu_manuals 
			texture = right_arrow 
			rgba = [ 128 128 128 0 ] 
			pos = PAIR(162.00000000000, -17.00000000000) 
			just = [ left top ] 
			scale = 0.75000000000 
		} 
		IF ( ( InNetGame ) & ( GetGlobalFlag flag = FLAG_G_EXPERT_MODE_NO_WALKING ) ) 
			<rgba> = [ 60 60 60 75 ] 
		ELSE 
			<rgba> = <text_color> 
		ENDIF 
		CreateScreenElement { 
			type = TextElement 
			parent = menu_walking 
			id = menu_walking_value 
			font = small 
			just = [ center top ] 
			pos = PAIR(142.00000000000, -17.00000000000) 
			text = <walking_value> 
			rgba = <rgba> 
		} 
		CreateScreenElement { 
			type = SpriteElement 
			parent = menu_walking 
			texture = left_arrow 
			rgba = [ 128 128 128 0 ] 
			pos = PAIR(122.00000000000, -17.00000000000) 
			just = [ right top ] 
			scale = 0.75000000000 
		} 
		CreateScreenElement { 
			type = SpriteElement 
			parent = menu_walking 
			texture = right_arrow 
			rgba = [ 128 128 128 0 ] 
			pos = PAIR(162.00000000000, -17.00000000000) 
			just = [ left top ] 
			scale = 0.75000000000 
		} 
	ENDIF 
	IF LevelIs load_skateshop 
		pad_left_2 = animate_joystick 
		pad_right_2 = animate_joystick 
	ELSE 
		pad_left_2 = null_script 
		pad_right_2 = null_script 
	ENDIF 
	IF NOT ( <controller_number> = -1 ) 
		SetScreenElementProps { 
			id = menu_vibration 
			event_handlers = [ { pad_left control_change_values params = { vibration controller_number = <controller_number> left } } 
				{ pad_right control_change_values params = { vibration controller_number = <controller_number> } } 
				{ pad_left <pad_left_2> params = { dir = left } } 
				{ pad_right <pad_right_2> params = { dir = right } } 
			] 
			replace_handlers 
		} 
		SetScreenElementProps { 
			id = menu_autokick 
			event_handlers = [ { pad_left control_change_values params = { autokick controller_number = <controller_number> left } } 
				{ pad_right control_change_values params = { autokick controller_number = <controller_number> } } 
				{ pad_left <pad_left_2> params = { dir = left } } 
				{ pad_right <pad_right_2> params = { dir = right } } 
			] 
			replace_handlers 
		} 
		SetScreenElementProps { 
			id = menu_spintaps 
			event_handlers = [ { pad_left control_change_values params = { spintaps controller_number = <controller_number> left } } 
				{ pad_right control_change_values params = { spintaps controller_number = <controller_number> } } 
				{ pad_left <pad_left_2> params = { dir = left } } 
				{ pad_right <pad_right_2> params = { dir = right } } 
			] 
			replace_handlers 
		} 
	ENDIF 
	IF ( <controller_number> = 1 ) 
		IF NOT LevelIs load_skateshop 
			SetScreenElementProps { 
				id = menu_reverts 
				event_handlers = [ { pad_left control_change_values params = { reverts controller_number = <controller_number> left } } 
					{ pad_right control_change_values params = { reverts controller_number = <controller_number> } } 
					{ pad_left <pad_left_2> params = { dir = left } } 
					{ pad_right <pad_right_2> params = { dir = right } } 
				] 
				replace_handlers 
			} 
			SetScreenElementProps { 
				id = menu_walking 
				event_handlers = [ { pad_left control_change_values params = { Walking controller_number = <controller_number> left } } 
					{ pad_right control_change_values params = { Walking controller_number = <controller_number> } } 
					{ pad_left <pad_left_2> params = { dir = left } } 
					{ pad_right <pad_right_2> params = { dir = right } } 
				] 
				replace_handlers 
			} 
			SetScreenElementProps { 
				id = menu_manuals 
				event_handlers = [ { pad_left control_change_values params = { manuals controller_number = <controller_number> left } } 
					{ pad_right control_change_values params = { manuals controller_number = <controller_number> } } 
					{ pad_left <pad_left_2> params = { dir = left } } 
					{ pad_right <pad_right_2> params = { dir = right } } 
				] 
				replace_handlers 
			} 
		ENDIF 
	ENDIF 
	IF ( <controller_number> = -1 ) 
		SetScreenElementProps { 
			id = menu_reverts 
			event_handlers = [ { pad_left control_change_values params = { reverts controller_number = <controller_number> left } } 
				{ pad_right control_change_values params = { reverts controller_number = <controller_number> } } 
				{ pad_left <pad_left_2> params = { dir = left } } 
				{ pad_right <pad_right_2> params = { dir = right } } 
			] 
			replace_handlers 
		} 
		SetScreenElementProps { 
			id = menu_walking 
			event_handlers = [ { pad_left control_change_values params = { Walking controller_number = <controller_number> left } } 
				{ pad_right control_change_values params = { Walking controller_number = <controller_number> } } 
				{ pad_left <pad_left_2> params = { dir = left } } 
				{ pad_right <pad_right_2> params = { dir = right } } 
			] 
			replace_handlers 
		} 
		SetScreenElementProps { 
			id = menu_manuals 
			event_handlers = [ { pad_left control_change_values params = { manuals controller_number = <controller_number> left } } 
				{ pad_right control_change_values params = { manuals controller_number = <controller_number> } } 
				{ pad_left <pad_left_2> params = { dir = left } } 
				{ pad_right <pad_right_2> params = { dir = right } } 
			] 
			replace_handlers 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT controller_config_focus 
	GetTags 
	FormatText ChecksumName = text_color "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = arrow_color "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	main_theme_focus <...> 
	SetScreenElementProps { id = { <id> child = 4 } rgba = <text_color> } 
	SetScreenElementProps { id = { <id> child = 5 } rgba = <arrow_color> } 
	SetScreenElementProps { id = { <id> child = 6 } rgba = <arrow_color> } 
ENDSCRIPT

SCRIPT controller_config_unfocus 
	GetTags 
	FormatText ChecksumName = text_color "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	main_theme_unfocus <...> 
	SetScreenElementProps { id = { <id> child = 4 } rgba = <text_color> } 
	SetScreenElementProps { id = { <id> child = 5 } rgba = [ 128 128 128 0 ] } 
	SetScreenElementProps { id = { <id> child = 6 } rgba = [ 128 128 128 0 ] } 
ENDSCRIPT

SCRIPT create_view_goals_menu 
	hide_current_goal 
	GoalManager_HidePoints 
	GoalManager_HideGoalPoints 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
		wait 1 gameframe 
	ENDIF 
	SetScreenElementLock id = root_window off 
	CreateScreenElement { 
		type = ContainerElement 
		parent = root_window 
		id = view_goals_menu 
		dims = PAIR(640.00000000000, 480.00000000000) 
		pos = PAIR(320.00000000000, 240.00000000000) 
	} 
	AssignAlias id = view_goals_menu alias = current_menu_anchor 
	create_helper_text helper_text_elements = [ { text = "\\b7/\\b4 = Select" } 
		{ text = "\\bn = Back" } 
		{ text = "\\bm = Jump to Goal (if unlocked)" } 
	] 
	FormatText ChecksumName = title_icon "%i_gap" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	build_theme_sub_title title = "GOALS" title_icon = <title_icon> 
	FormatText ChecksumName = paused_icon "%i_paused_icon" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	build_theme_box_icons icon_texture = <paused_icon> 
	build_grunge_piece 
	build_top_bar pos = PAIR(0.00000000000, 62.00000000000) 
	theme_background width = 6.34999990463 pos = PAIR(320.00000000000, 85.00000000000) num_parts = 10.50000000000 
	<root_pos> = PAIR(80.00000000000, 25.00000000000) 
	FormatText ChecksumName = text_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = untext_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	CreateScreenElement { 
		type = SpriteElement 
		parent = current_menu_anchor 
		texture = black 
		pos = PAIR(57.00000000000, 87.00000000000) 
		just = [ left top ] 
		rgba = [ 0 0 0 85 ] 
		scale = PAIR(130.00000000000, 5.00000000000) 
		z_priority = 2 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = current_menu_anchor 
		id = view_goals_menu_up_arrow 
		texture = up_arrow 
		pos = PAIR(320.00000000000, 88.00000000000) 
		just = [ left top ] 
		rgba = [ 128 128 128 128 ] 
		z_priority = 3 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = current_menu_anchor 
		id = view_goals_menu_down_arrow 
		texture = down_arrow 
		pos = PAIR(320.00000000000, 372.00000000000) 
		just = [ left top ] 
		rgba = [ 128 128 128 128 ] 
		z_priority = 3 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = current_menu_anchor 
		texture = black 
		pos = PAIR(57.00000000000, 370.00000000000) 
		just = [ left top ] 
		rgba = [ 0 0 0 85 ] 
		scale = PAIR(130.00000000000, 5.00000000000) 
		z_priority = 2 
	} 
	CreateScreenElement { 
		type = VScrollingMenu 
		parent = current_menu_anchor 
		dims = PAIR(640.00000000000, 264.00000000000) 
		pos = PAIR(80.00000000000, 110.00000000000) 
		just = [ left top ] 
		internal_just = [ center top ] 
	} 
	CreateScreenElement { 
		type = VMenu 
		parent = <id> 
		id = view_goals_vmenu 
		pos = PAIR(0.00000000000, 0.00000000000) 
		just = [ left top ] 
		internal_just = [ left top ] 
		dont_allow_wrap 
		event_handlers = [ 
			{ pad_down menu_vert_blink_arrow params = { id = view_goals_menu_down_arrow } } 
			{ pad_up menu_vert_blink_arrow params = { id = view_goals_menu_up_arrow } } 
			{ pad_up generic_menu_up_or_down_sound params = { up } } 
			{ pad_down generic_menu_up_or_down_sound params = { down } } 
			{ pad_back generic_menu_pad_back_sound } 
			{ pad_back view_goals_menu_exit params = { callback = create_pause_menu } } 
		] 
	} 
	AssignAlias id = view_goals_vmenu alias = current_menu 
	GoalManager_AddViewGoalsList 
	FireEvent type = focus target = view_goals_vmenu 
ENDSCRIPT

SCRIPT view_goals_menu_add_item 
	CreateScreenElement { 
		type = ContainerElement 
		parent = current_menu 
		id = <goal_id> 
		dims = PAIR(500.00000000000, 24.00000000000) 
	} 
	FormatText ChecksumName = text_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = highlighted_text_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	CreateScreenElement { 
		type = TextElement 
		parent = <goal_id> 
		rgba = <text_rgba> 
		text = <text> 
		font = dialog 
		pos = PAIR(0.00000000000, 0.00000000000) 
		just = [ left top ] 
	} 
	IF GotParam bogus 
		SetScreenElementProps { 
			id = <goal_id> 
			event_handlers = [ 
				{ focus view_goals_menu_focus_beaten } 
				{ unfocus view_goals_menu_unfocus_beaten } 
			] 
		} 
		RETURN 
	ENDIF 
	highlight_angle = RANDOM_NO_REPEAT(1, 1, 1, 1, 1, 1, 1, 1, 1, 1) RANDOMCASE 2 RANDOMCASE -2 RANDOMCASE 3 RANDOMCASE -3 RANDOMCASE 3.50000000000 RANDOMCASE -3 RANDOMCASE 5 RANDOMCASE -4 RANDOMCASE 2.50000000000 RANDOMCASE -4.50000000000 RANDOMEND 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <goal_id> 
		texture = DE_highlight_bar 
		pos = PAIR(240.00000000000, 10.00000000000) 
		just = [ center center ] 
		rgba = [ 0 0 0 0 ] 
		z_priority = 3 
		scale = PAIR(4.09999990463, 0.69999998808) 
		rot_angle = ( <highlight_angle> / 4 ) 
	} 
	CreateScreenElement { 
		type = TextElement 
		parent = <goal_id> 
		rgba = <text_rgba> 
		text = " " 
		font = dialog 
		pos = PAIR(0.00000000000, 0.00000000000) 
		just = [ left top ] 
	} 
	IF GoalManager_HasWonGoal name = <goal_id> 
		SetScreenElementProps { 
			id = <goal_id> 
			event_handlers = [ 
				{ focus view_goals_menu_focus_beaten } 
				{ unfocus view_goals_menu_unfocus_beaten } 
				{ pad_choose view_goals_menu_start_beaten_goal params = { goal_id = <goal_id> } } 
				{ pad_start view_goals_menu_start_beaten_goal params = { goal_id = <goal_id> } } 
				{ pad_choose generic_menu_pad_choose_sound } 
			] 
		} 
		GetScreenElementDims id = { <goal_id> child = 0 } 
		CreateScreenElement { 
			type = SpriteElement 
			parent = { <goal_id> child = 1 } 
			texture = white2 
			pos = PAIR(2.00000000000, 16.00000000000) 
			just = [ left center ] 
			rgba = <highlighted_text_rgba> 
			alpha = 1 
			z_priority = 10 
			scale = PAIR(15.50000000000, 0.15000000596) 
		} 
	ELSE 
		IF GoalManager_GoalIsLocked name = <goal_id> 
			IF IsTrue bootstrap_build 
				<locked_text> = "NOT IN DEMO" 
			ELSE 
				GoalManager_GetGoalParams name = <goal_id> 
				IF GotParam pro_goal 
					<locked_text> = "Complete Pro Challenge to unlock" 
				ELSE 
					<locked_text> = "Locked" 
				ENDIF 
			ENDIF 
			view_goals_menu_set_color { 
				id = <goal_id> 
				rgba = <text_rgba> 
				text = <locked_text> 
			} 
			SetScreenElementProps { 
				id = <goal_id> 
				event_handlers = [ 
					{ focus view_goals_menu_focus_locked } 
					{ unfocus view_goals_menu_unfocus_locked } 
					{ pad_choose view_goals_menu_pad_choose_locked } 
					{ pad_start view_goals_menu_pad_choose_locked } 
				] 
				replace_handlers 
			} 
		ELSE 
			IF GoalManager_HasSeenGoal name = <goal_id> 
				view_goals_menu_set_color { 
					id = <goal_id> 
					rgba = <text_rgba> 
				} 
				SetScreenElementProps { 
					id = <goal_id> 
					event_handlers = [ 
						{ focus view_goals_menu_focus_unlocked params = { goal_id = <goal_id> } } 
						{ unfocus view_goals_menu_unfocus_unlocked params = { goal_id = <goal_id> } } 
						{ pad_choose view_goals_menu_start_goal params = { goal_id = <goal_id> } } 
						{ pad_start view_goals_menu_start_goal params = { goal_id = <goal_id> } } 
					] 
					replace_handlers 
				} 
			ELSE 
				view_goals_menu_set_color { 
					id = <goal_id> 
					rgba = [ 42 42 38 128 ] 
					text = "??????????" 
				} 
				SetScreenElementProps { 
					id = <goal_id> 
					event_handlers = [ 
						{ focus view_goals_menu_focus_locked params = { goal_id = <goal_id> } } 
						{ unfocus view_goals_menu_unfocus_locked params = { goal_id = <goal_id> } } 
						{ pad_choose view_goals_menu_pad_choose_locked } 
						{ pad_start view_goals_menu_pad_choose_locked } 
					] 
					replace_handlers 
				} 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT view_goals_menu_set_color 
	SetScreenElementProps { 
		id = { <id> child = 0 } 
		rgba = <rgba> 
		text = <text> 
	} 
	<id> : GetTags 
	IF GotParam win_record 
		SetScreenElementProps { 
			id = { <id> child = 1 } 
			rgba = <rgba> 
			scale = <scale> 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT view_goals_menu_focus_locked 
	generic_menu_update_arrows { 
		menu_id = view_goals_vmenu 
		up_arrow_id = view_goals_menu_up_arrow 
		down_arrow_id = view_goals_menu_down_arrow 
	} 
	GetTags 
	main_theme_focus 
	IF GotParam goal_id 
		view_goals_menu_play_preview_cam <...> 
	ENDIF 
ENDSCRIPT

SCRIPT view_goals_menu_unfocus_locked 
	GetTags 
	generic_menu_pad_up_down_sound 
	main_theme_unfocus 
	IF GotParam goal_id 
		view_goals_menu_kill_preview_cam <...> 
	ENDIF 
ENDSCRIPT

SCRIPT view_goals_menu_focus_unlocked 
	generic_menu_update_arrows { 
		menu_id = view_goals_vmenu 
		up_arrow_id = view_goals_menu_up_arrow 
		down_arrow_id = view_goals_menu_down_arrow 
	} 
	GetTags 
	FormatText ChecksumName = highlighted_text_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = bar_rgba "%i_HIGHLIGHT_BAR_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	DoScreenElementMorph { 
		id = { <id> child = 0 } 
		rgba = <highlighted_text_rgba> 
		scale = 1.10000002384 
		relative_scale 
	} 
	IF ScreenElementExists id = { <id> child = 2 } 
		DoScreenElementMorph { 
			id = { <id> child = 2 } 
			rgba = <highlighted_text_rgba> 
			scale = 1.10000002384 
			relative_scale 
		} 
	ENDIF 
	SetScreenElementProps { 
		id = { <id> child = 1 } 
		rgba = <bar_rgba> 
	} 
	IF ScreenElementExists id = scrolling_menu_up_arrow 
		IF GotParam first_item 
			DoScreenElementMorph id = scrolling_menu_up_arrow alpha = 0 
		ELSE 
			DoScreenElementMorph id = scrolling_menu_up_arrow alpha = 1 
		ENDIF 
	ENDIF 
	IF ScreenElementExists id = scrolling_menu_down_arrow 
		IF GotParam last_item 
			DoScreenElementMorph id = scrolling_menu_down_arrow alpha = 0 
		ELSE 
			DoScreenElementMorph id = scrolling_menu_down_arrow alpha = 1 
		ENDIF 
	ENDIF 
	RunScriptOnScreenElement id = <id> text_twitch_effect 
	view_goals_menu_play_preview_cam <...> 
ENDSCRIPT

SCRIPT view_goals_menu_unfocus_unlocked 
	GetTags 
	generic_menu_pad_up_down_sound 
	FormatText ChecksumName = text_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	KillSpawnedScript name = text_twitch_effect 
	DoScreenElementMorph { 
		id = { <id> child = 0 } 
		rgba = <text_rgba> 
		alpha = <text_alpha> 
		scale = 1 
	} 
	IF ScreenElementExists id = { <id> child = 2 } 
		DoScreenElementMorph { 
			id = { <id> child = 2 } 
			rgba = <text_rgba> 
			alpha = <text_alpha> 
			scale = 1 
		} 
	ENDIF 
	SetScreenElementProps { 
		id = { <id> child = 1 } 
		rgba = [ 128 128 128 0 ] 
	} 
	view_goals_menu_kill_preview_cam <...> 
ENDSCRIPT

SCRIPT view_goals_menu_focus_beaten 
	generic_menu_update_arrows { 
		menu_id = view_goals_vmenu 
		up_arrow_id = view_goals_menu_up_arrow 
		down_arrow_id = view_goals_menu_down_arrow 
	} 
	GetTags 
	FormatText ChecksumName = highlighted_text_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = bar_rgba "%i_HIGHLIGHT_BAR_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	DoScreenElementMorph { 
		id = { <id> child = 0 } 
		rgba = <highlighted_text_rgba> 
		scale = 1.10000002384 
		relative_scale 
	} 
	IF ScreenElementExists id = { <id> child = 2 } 
		DoScreenElementMorph { 
			id = { <id> child = 2 } 
			rgba = <highlighted_text_rgba> 
			scale = 1.10000002384 
			relative_scale 
		} 
	ENDIF 
	SetScreenElementProps { 
		id = { <id> child = 1 } 
		rgba = <bar_rgba> 
	} 
	IF ScreenElementExists id = scrolling_menu_up_arrow 
		IF GotParam first_item 
			DoScreenElementMorph id = scrolling_menu_up_arrow alpha = 0 
		ELSE 
			DoScreenElementMorph id = scrolling_menu_up_arrow alpha = 1 
		ENDIF 
	ENDIF 
	IF ScreenElementExists id = scrolling_menu_down_arrow 
		IF GotParam last_item 
			DoScreenElementMorph id = scrolling_menu_down_arrow alpha = 0 
		ELSE 
			DoScreenElementMorph id = scrolling_menu_down_arrow alpha = 1 
		ENDIF 
	ENDIF 
	RunScriptOnScreenElement id = <id> text_twitch_effect 
ENDSCRIPT

SCRIPT view_goals_menu_unfocus_beaten 
	GetTags 
	generic_menu_pad_up_down_sound 
	FormatText ChecksumName = text_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	KillSpawnedScript name = text_twitch_effect 
	DoScreenElementMorph { 
		id = { <id> child = 0 } 
		rgba = <text_rgba> 
		alpha = <text_alpha> 
		scale = 1 
	} 
	IF ScreenElementExists id = { <id> child = 2 } 
		DoScreenElementMorph { 
			id = { <id> child = 2 } 
			rgba = <text_rgba> 
			alpha = <text_alpha> 
			scale = 1 
		} 
	ENDIF 
	SetScreenElementProps { 
		id = { <id> child = 1 } 
		rgba = [ 128 128 128 0 ] 
	} 
ENDSCRIPT

SCRIPT view_goals_menu_pad_choose_locked 
ENDSCRIPT

SCRIPT view_goals_menu_start_goal 
	view_goals_menu_exit callback = exit_pause_menu 
	GoalManager_DeactivateAllGoals 
	goal_accept_trigger goal_id = <goal_id> force_start 
ENDSCRIPT

SCRIPT view_goals_menu_start_beaten_goal 
	view_goals_menu_exit callback = exit_pause_menu 
	GoalManager_DeactivateAllGoals 
	goal_accept_trigger goal_id = <goal_id> force_start 
ENDSCRIPT

SCRIPT view_goals_menu_play_preview_cam 
	GoalManager_GetGoalParams name = <goal_id> 
	IF isAlive name = <trigger_obj_id> 
		IF NOT ObjectExists id = Menu_Cam 
			create_menu_camera 
		ELSE 
			Menu_Cam : unpause 
		ENDIF 
		<trigger_obj_id> : Obj_GetPosition 
		Menu_Cam : Obj_SetPosition Position = ( <pos> + VECTOR(0.00000000000, 40.00000000000, 110.00000000000) ) 
		Menu_Cam : Obj_SetOrientation Y = 0 
		<trigger_obj_id> : Obj_GetOrientation 
		<trigger_obj_id> : Obj_SetOrientation Y = 0 
		SetActivecamera id = Menu_Cam 
		SetSkaterCamAnimShouldPause name = <goal_id> should_pause = 0 
		<trigger_obj_id> : unpause 
		wait 5 frames 
		<trigger_obj_id> : pause 
	ENDIF 
	view_goals_vmenu : SetTags current_cam_anim = <goal_id> 
ENDSCRIPT

SCRIPT view_goals_menu_kill_preview_cam 
	GetSkaterId 
	KillSkaterCamAnim skater = <objId> name = <goal_id> 
ENDSCRIPT

SCRIPT view_goals_menu_exit 
	IF ScreenElementExists id = view_goals_vmenu 
		view_goals_vmenu : GetTags 
		IF GotParam current_cam_anim 
			GetSkaterId 
			KillSkaterCamAnim skater = <objId> name = <current_cam_anim> 
		ENDIF 
	ENDIF 
	restore_skater_camera 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
		wait 1 gameframe 
	ENDIF 
	GoalManager_ShowPoints 
	IF NOT GoalManager_HasActiveGoals 
		GoalManager_ShowGoalPoints 
	ENDIF 
	<callback> 
ENDSCRIPT

SCRIPT create_stats_menu 
	hide_current_goal 
	helper_text = { helper_text_elements = [ { text = "\\b7/\\b4/\\b6/\\b5 = Select" } 
			{ text = "\\bn = Back" } 
		] 
	} 
	FormatText ChecksumName = title_icon "%i_stats" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	make_new_themed_sub_menu { 
		title = "STATS" 
		title_icon = <title_icon> 
		pos = PAIR(60.00000000000, 97.00000000000) 
		skateshop_pos = PAIR(60.00000000000, 97.00000000000) 
		dims = PAIR(640.00000000000, 480.00000000000) 
		helper_text = <helper_text> 
		no_menu_title = no_menu_title 
	} 
	FormatText ChecksumName = off_color "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = on_color "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	CreateScreenElement { 
		type = VMenu 
		parent = sub_menu 
		id = sub_vmenu2 
		font = small 
		just = [ left top ] 
		pos = PAIR(310.00000000000, 109.00000000000) 
		padding_scale = 1.14999997616 
		internal_scale = 1 
		internal_just = [ left top ] 
		event_handlers = [ { pad_up generic_menu_up_or_down_sound params = { up } } 
			{ pad_down generic_menu_up_or_down_sound params = { down } } 
			{ pad_back generic_menu_pad_back params = { callback = stats_menu_exit } } 
		] 
	} 
	SetScreenElementProps { 
		id = sub_menu 
		event_handlers = [ { pad_back generic_menu_pad_back params = { callback = stats_menu_exit } } ] 
		replace_handlers 
	} 
	GetArraySize stat_names 
	<index> = 0 
	BEGIN 
		RemoveParameter pad_right_script 
		RemoveParameter pad_left_script 
		IF ( <index> > ( ( <array_size> / 2 ) - 1 ) ) 
			parent = sub_vmenu2 
			pad_left_script = focus_stats_vmenu 
			child = ( <index> - ( <array_size> / 2 ) ) 
		ELSE 
			parent = sub_vmenu 
			pad_right_script = focus_stats_vmenu2 
			child = <index> 
		ENDIF 
		stats_menu_add_item { ( stat_names [ <index> ] ) 
			index = <index> 
			stats_parent = <parent> 
			pad_right_script = <pad_right_script> 
			pad_left_script = <pad_left_script> 
			pad_right_params = { grid_index = ( <child> ) } 
			pad_left_params = { grid_index = ( <child> ) } 
		} 
		SetScreenElementProps { 
			id = { <parent> child = <child> } 
			tags = { tag_grid_x = <child> } 
		} 
		<index> = ( <index> + 1 ) 
	REPEAT <array_size> 
	FormatText textname = stat_title "%i:" i = ( ( stat_names [ 0 ] ) . string ) 
	CreateScreenElement { 
		type = TextElement 
		parent = sub_menu 
		id = stat_title 
		pos = PAIR(240.00000000000, 215.00000000000) 
		font = small 
		just = [ right top ] 
		scale = 1.50000000000 
		text = <stat_title> 
		rgba = <on_color> 
		z_priority = 4 
	} 
	CreateScreenElement { 
		type = TextElement 
		parent = sub_menu 
		id = stat_count 
		pos = PAIR(270.00000000000, 215.00000000000) 
		font = small 
		just = [ right top ] 
		scale = 1.50000000000 
		text = "" 
		rgba = <on_color> 
		z_priority = 4 
	} 
	CreateScreenElement { 
		type = TextElement 
		parent = sub_menu 
		pos = PAIR(270.00000000000, 215.00000000000) 
		font = small 
		just = [ left top ] 
		scale = 1.50000000000 
		text = "/10" 
		rgba = <on_color> 
		z_priority = 4 
	} 
	CreateScreenElement { 
		type = TextBlockElement 
		parent = sub_menu 
		id = stat_point_description 
		dims = PAIR(280.00000000000, 0.00000000000) 
		pos = PAIR(330.00000000000, 215.00000000000) 
		font = small 
		just = [ left top ] 
		scale = 0.89999997616 
		text = ( ( stat_names [ 0 ] ) . description ) 
		line_spacing = 0.69999998808 
		internal_just = [ left top ] 
		rgba = <off_color> 
		allow_expansion 
		z_priority = 4 
	} 
	build_stat_goals_menu 
	theme_background width = 6.40000009537 pos = PAIR(320.00000000000, 85.00000000000) num_parts = 10.50000000000 parent = sub_menu 
	CreateScreenElement { 
		type = SpriteElement 
		parent = sub_menu 
		texture = white2 
		pos = PAIR(320.00000000000, 250.00000000000) 
		just = [ center top ] 
		scale = PAIR(63.50000000000, 0.25000000000) 
		rgba = <on_color> 
		alpha = 0.69999998808 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = sub_menu 
		texture = white2 
		pos = PAIR(322.00000000000, 212.00000000000) 
		just = [ center top ] 
		scale = PAIR(63.50000000000, 0.25000000000) 
		rgba = <on_color> 
		alpha = 0.69999998808 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = sub_menu 
		texture = black 
		pos = PAIR(322.00000000000, 214.00000000000) 
		just = [ center top ] 
		scale = PAIR(0.55000001192, 9.50000000000) 
		rgba = <on_color> 
		alpha = 0.69999998808 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = sub_menu 
		texture = black 
		pos = PAIR(320.00000000000, 214.00000000000) 
		just = [ center top ] 
		scale = PAIR(132.00000000000, 44.00000000000) 
		rgba = [ 0 0 0 88 ] 
		alpha = 0.69999998808 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = sub_menu 
		texture = black 
		pos = PAIR(320.00000000000, 212.00000000000) 
		just = [ center top ] 
		scale = PAIR(128.00000000000, 9.00000000000) 
		rgba = [ 0 0 0 118 ] 
		alpha = 0.69999998808 
	} 
	IF NOT LevelIs load_skateshop 
		finish_themed_sub_menu pos = PAIR(320.00000000000, 720.00000000000) 
		DoScreenElementMorph id = sub_menu time = 0.00000000000 pos = PAIR(320.00000000000, 720.00000000000) 
		DoScreenElementMorph id = sub_menu time = 0.50000000000 pos = PAIR(320.00000000000, 240.00000000000) 
	ELSE 
		skater : remove_skater_from_world 
		PlaySound DE_MenuFlyUp vol = 100 
		DoScreenElementMorph id = sub_menu time = 0.00000000000 pos = PAIR(320.00000000000, 720.00000000000) 
		DoScreenElementMorph id = sub_menu time = 0.50000000000 pos = PAIR(320.00000000000, 218.00000000000) 
		FireEvent type = focus target = sub_menu 
	ENDIF 
ENDSCRIPT

SCRIPT update_stats_menu_count 
	GetArraySize stats_goals 
	index = 0 
	count = 3 
	BEGIN 
		IF ( ( ( stats_goals [ <index> ] ) . stattype ) = <name> ) 
			skater : StatsManager_GetGoalStatus <index> 
			IF ( <status> = 1 ) 
				count = ( <count> + 1 ) 
			ENDIF 
		ENDIF 
		index = ( <index> + 1 ) 
	REPEAT <array_size> 
	FormatText textname = text "%i" i = <count> 
	SetScreenElementProps id = stat_count text = <text> 
ENDSCRIPT

SCRIPT build_stat_goals_menu stat_type = air 
	FormatText ChecksumName = on_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	IF ScreenElementExists id = stat_goal_menu 
		DestroyScreenElement id = stat_goal_menu 
	ENDIF 
	CreateScreenElement { 
		type = VMenu 
		parent = sub_menu 
		id = stat_goal_menu 
		font = dialog 
		just = [ center top ] 
		pos = PAIR(320.00000000000, 265.00000000000) 
		padding_scale = 0.75000000000 
		internal_scale = 1 
		internal_just = [ center top ] 
	} 
	GetArraySize stats_goals 
	index = 0 
	BEGIN 
		skater : StatsManager_GetGoalStatus <index> 
		IF ( ( ( stats_goals [ <index> ] ) . stattype ) = <stat_type> ) 
			SWITCH <status> 
				CASE 2 
					text = "Turn Am to Unlock" 
					alpha = 0.50000000000 
				CASE 3 
					text = "Turn Pro to Unlock" 
					alpha = 0.50000000000 
				DEFAULT 
					GoalManager_GetDifficultyLevel 
					string = ( ( stats_goals [ <index> ] ) . text ) 
					value = ( ( stats_goals [ <index> ] ) . value [ <difficulty_level> ] ) 
					IF StructureContains structure = ( stats_goals [ <index> ] ) value_string 
						vstring = ( ( stats_goals [ <index> ] ) . value_string [ <difficulty_level> ] ) 
					ENDIF 
					IF NOT StructureContains structure = ( stats_goals [ <index> ] ) no_commas 
						FormatText textname = text <string> i = <value> s = <vstring> UseCommas 
					ELSE 
						FormatText textname = text <string> i = <value> s = <vstring> 
					ENDIF 
					alpha = 1.00000000000 
			ENDSWITCH 
			IF ( <status> = 1 ) 
				rgba = [ 30 30 30 80 ] 
			ELSE 
				rgba = <on_rgba> 
			ENDIF 
			CreateScreenElement { 
				type = ContainerElement 
				parent = stat_goal_menu 
				just = [ center top ] 
				internal_just = [ center center ] 
				dims = PAIR(0.00000000000, 20.00000000000) 
			} 
			anchor_id = <id> 
			CreateScreenElement { 
				type = TextElement 
				parent = <anchor_id> 
				font = dialog 
				just = [ center top ] 
				scale = 0.80000001192 
				text = <text> 
				rgba = <rgba> 
				z_priority = 4 
				alpha = <alpha> 
			} 
			GetScreenElementDims id = <id> 
			scale = PAIR(127.00000000000, 0.50000000000) 
			IF ( <status> = 1 ) 
				CreateScreenElement { 
					type = SpriteElement 
					parent = <anchor_id> 
					texture = black 
					just = [ center center ] 
					scale = <scale> 
					pos = PAIR(0.00000000000, 10.00000000000) 
					rgba = <rgba> 
					z_priority = 5 
					alpha = <alpha> 
				} 
			ENDIF 
		ENDIF 
		index = ( <index> + 1 ) 
	REPEAT <array_size> 
ENDSCRIPT

SCRIPT focus_stats_vmenu 
	PlaySound MenuUp vol = 100 
	FireEvent type = unfocus target = sub_vmenu2 
	FireEvent type = focus target = sub_vmenu data = { grid_index = <grid_index> } 
ENDSCRIPT

SCRIPT focus_stats_vmenu2 
	PlaySound MenuUp vol = 100 
	FireEvent type = unfocus target = sub_vmenu 
	FireEvent type = focus target = sub_vmenu2 data = { grid_index = <grid_index> } 
ENDSCRIPT

SCRIPT stats_menu_create_stats_block parent = current_menu scale = 1 pos = PAIR(180.00000000000, 147.00000000000) 
	CreateScreenElement { 
		type = ContainerElement 
		parent = <parent> 
		id = stats_block_anchor 
		pos = <pos> 
		just = [ left top ] 
		dims = PAIR(640.00000000000, 480.00000000000) 
		scale = <scale> 
	} 
	<stats_parent> = <id> 
	IF GotParam on 
		on = on 
	ENDIF 
	GetArraySize stat_names 
	<index> = 0 
	BEGIN 
		stats_menu_add_item ( stat_names [ <index> ] ) <...> on = <on> 
		<index> = ( <index> + 1 ) 
	REPEAT <array_size> 
	<pos> = ( PAIR(0.00000000000, 1.00000000000) * ( 23 * ( <index> + 1 ) ) ) 
	<pos> = ( <pos> + PAIR(150.00000000000, -12.00000000000) ) 
	CreateScreenElement { 
		type = ContainerElement 
		parent = stats_block_anchor 
		id = stats_bottom_anchor 
		dims = PAIR(200.00000000000, 20.00000000000) 
		pos = <pos> 
		z_priority = 10 
	} 
ENDSCRIPT

SCRIPT stats_menu_add_item z_priority = 2 highlight_bar_scale = PAIR(3.09999990463, 0.69999998808) highlight_bar_pos = PAIR(90.00000000000, -7.00000000000) pad_right_script = null_script pad_left_script = null_script 
	FormatText ChecksumName = row_id "stats_menu_names_%n" n = <index> 
	<pos> = ( PAIR(0.00000000000, 1.00000000000) * ( 23 * ( <index> + 1 ) ) ) 
	<pos> = ( <pos> + PAIR(150.00000000000, -12.00000000000) ) 
	CreateScreenElement { 
		type = ContainerElement 
		parent = <stats_parent> 
		id = <row_id> 
		dims = PAIR(200.00000000000, 20.00000000000) 
		pos = <pos> 
		just = [ center center ] 
		event_handlers = [ 
			{ focus stats_menu_focus params = { name = <name> row_id = <row_id> string = <string> description = <description> } } 
			{ unfocus stats_menu_unfocus params = { name = <name> row_id = <row_id> } } 
			{ pad_right <pad_right_script> params = <pad_right_params> } 
			{ pad_left <pad_left_script> params = <pad_left_params> } 
		] 
	} 
	<anchor_id> = <id> 
	IF GotParam not_focusable 
		SetScreenElementProps { 
			id = <anchor_id> 
			not_focusable 
		} 
	ENDIF 
	FormatText ChecksumName = text_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	IF GotParam short_string 
		<string> = <short_string> 
	ENDIF 
	CreateScreenElement { 
		type = TextElement 
		parent = <anchor_id> 
		rgba = <text_rgba> 
		font = small 
		text = <string> 
		z_priority = <z_priority> 
		just = [ right center ] 
		pos = PAIR(95.00000000000, -5.00000000000) 
	} 
	IF GotParam on 
		FormatText ChecksumName = highlight_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	ELSE 
		highlight_rgba = [ 50 50 50 128 ] 
	ENDIF 
	build_stat_slider parent = <row_id> pos = PAIR(95.00000000000, -5.00000000000) on = <on> 
	stats_menu_update_row <...> highlight_rgba = <highlight_rgba> bar_bg_rgba = [ 100 100 100 128 ] 
ENDSCRIPT

SCRIPT build_stat_slider 
	root_pos = <pos> 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <parent> 
		texture = framebody 
		rgba = [ 128 128 128 100 ] 
		scale = PAIR(3.00000000000, 1.00000000000) 
		pos = <root_pos> 
		just = [ left center ] 
		z_priority = 1 
	} 
	body_id = <id> 
	GetStackedScreenElementPos id = <body_id> X 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <parent> 
		texture = framecap 
		rgba = [ 128 128 128 100 ] 
		scale = PAIR(1.00000000000, 1.00000000000) 
		pos = <pos> 
		just = [ left top ] 
		z_priority = 1 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <parent> 
		texture = statbody 
		rgba = [ 128 128 128 100 ] 
		scale = PAIR(1.00000000000, 1.00000000000) 
		pos = ( <root_pos> + PAIR(0.00000000000, 0.00000000000) ) 
		just = [ left center ] 
		z_priority = 2 
	} 
	GetStackedScreenElementPos id = <body_id> X offset = PAIR(15.00000000000, 4.00000000000) 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <parent> 
		texture = statcap 
		rgba = [ 128 128 128 100 ] 
		scale = PAIR(1.00000000000, 1.00000000000) 
		pos = <pos> 
		just = [ left top ] 
		z_priority = 2 
	} 
ENDSCRIPT

SCRIPT stats_menu_fire_pad_down 
	FireEvent type = pad_down target = <target> 
ENDSCRIPT

stats_color_1 = [ 40 0 0 80 ] 
stats_color_2 = [ 128 0 0 80 ] 
SCRIPT stats_menu_update_row highlight_rgba = [ 100 100 100 80 ] locked_highlight_rgba = [ 50 50 50 80 ] slider_rgba = [ 128 128 128 0 ] 
	IF IsTrue gary_debug 
		IF GotParam skater_name 
			script_assert "Get rid of skater name" 
		ENDIF 
	ENDIF 
	GetStatValue <name> 
	IF ( <stat_value> > 0 ) 
		IF ( <stat_value> > 9 ) 
			scale_value = 9 
		ELSE 
			scale_value = <stat_value> 
		ENDIF 
		scale = ( <scale_value> * PAIR(0.38499999046, 0.00000000000) + PAIR(0.00000000000, 1.00000000000) ) 
		DoScreenElementMorph { 
			id = { <row_id> child = 1 } 
			rgba = <bar_bg_rgba> 
		} 
		DoScreenElementMorph { 
			id = { <row_id> child = 2 } 
			rgba = <bar_bg_rgba> 
		} 
		DoScreenElementMorph { 
			id = { <row_id> child = 3 } 
			rgba = <highlight_rgba> 
			scale = <scale> 
		} 
		GetStackedScreenElementPos X id = { <row_id> child = 3 } 
		IF ( <stat_value> > 9 ) 
			DoScreenElementMorph { 
				id = { <row_id> child = 4 } 
				rgba = <highlight_rgba> 
				alpha = 1.00000000000 
			} 
		ELSE 
			DoScreenElementMorph { 
				id = { <row_id> child = 4 } 
				alpha = 0 
			} 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT stats_menu_get_original_stat_value 
	<stat_name> = <name> 
	IF GotParam skater_name 
		GetSkaterProfileInfoByName name = <skater_name> 
	ELSE 
		GetCurrentSkaterProfileIndex 
		GetSkaterProfileInfo player = <currentSkaterProfileIndex> 
	ENDIF 
	IF ( <name> = custom ) 
		RETURN original_stat_value = 0 
	ENDIF 
	GetArraySize master_skater_list 
	<index> = 0 
	BEGIN 
		IF ( ( ( master_skater_list [ <index> ] ) . name ) = <name> ) 
			<original_stat_value> = ( ( master_skater_list [ <index> ] ) . <stat_name> ) 
			BREAK 
		ENDIF 
		<index> = ( <index> + 1 ) 
	REPEAT <array_size> 
	IF NOT GotParam original_stat_value 
		script_assert "couldn\'t find the stat!" 
	ENDIF 
	RETURN original_stat_value = <original_stat_value> 
ENDSCRIPT

SCRIPT stats_menu_change_stat 
	GetCurrentSkaterProfileIndex 
	GetNumStatPointsAvailable player = <currentSkaterProfileIndex> 
	GetStatValue <name> 
	IF ( <change> < 0 ) 
		IF ( <stat_value> < 1 ) 
			RETURN 
		ENDIF 
	ENDIF 
	IF ( <change> > 0 ) 
		IF ( <stat_value> > 9 ) 
			RETURN 
		ENDIF 
	ENDIF 
	IF ( <points_available> < <change> ) 
		RETURN 
	ENDIF 
	stats_menu_get_original_stat_value name = <name> 
	IF ( ( <stat_value> + <change> ) < <original_stat_value> ) 
		RETURN 
	ENDIF 
	PlaySound menu03 vol = 100 
	AwardStatPoint ( <change> * -1 ) 
	GetNumStatPointsAvailable player = <currentSkaterProfileIndex> 
	FormatText textname = points_text "%i" i = <points_available> 
	SetScreenElementProps { 
		id = stat_points_available 
		text = <points_text> 
	} 
	<stat_value> = ( <stat_value> + <change> ) 
	SetSkaterProfileProperty player = <currentSkaterProfileIndex> <name> <stat_value> 
	IF LevelIs load_skateshop 
		UpdateSkaterStats player = 0 
	ELSE 
		UpdateSkaterStats player = <currentSkaterProfileIndex> 
	ENDIF 
	FormatText ChecksumName = highlight_rgba "%i_STAT_ON" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = locked_highlight_rgba "%i_DEF_STAT_ON" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	stats_menu_update_row name = <name> row_id = <row_id> slider_rgba = [ 128 128 128 100 ] highlight_rgba = <highlight_rgba> locked_highlight_rgba = <locked_highlight_rgba> 
	IF GotParam update_all_skaters 
		<stat_name> = <name> 
		GetSkaterProfileInfo player = <currentSkaterProfileIndex> 
		ForEachSkaterProfile { 
			do = stats_menu_change_other_skater_stats 
			params = { change = <change> 
				current_skater_name = <name> 
				stat_name = <stat_name> 
			} 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT stats_menu_focus 
	FormatText ChecksumName = highlight_rgba "%i_STAT_ON" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	stats_menu_update_row { 
		name = <name> 
		row_id = <row_id> 
		highlight_rgba = <highlight_rgba> 
		bar_bg_rgba = <highlight_rgba> 
	} 
	stats_menu_done_focus <...> 
ENDSCRIPT

SCRIPT stats_menu_unfocus 
	stats_menu_update_row name = <name> row_id = <row_id> highlight_rgba = [ 50 50 50 100 ] bar_bg_rgba = [ 100 100 100 128 ] 
	stats_menu_done_unfocus <...> 
ENDSCRIPT

SCRIPT stats_menu_done_focus description = "" 
	GetTags 
	FormatText ChecksumName = text_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	SetScreenElementProps { 
		id = { <id> child = 0 } 
		rgba = <text_rgba> 
	} 
	RunScriptOnScreenElement id = <id> text_twitch_effect params = { no_extra } 
	IF ObjectExists id = stat_title 
		FormatText textname = stat_title "%i:" i = <string> 
		SetScreenElementProps { 
			id = stat_title 
			text = <stat_title> 
		} 
	ENDIF 
	update_stats_menu_count name = <name> 
	IF ObjectExists id = stat_point_description 
		SetScreenElementProps { 
			id = stat_point_description 
			text = <description> 
		} 
	ENDIF 
	build_stat_goals_menu stat_type = <name> 
ENDSCRIPT

SCRIPT stats_menu_done_unfocus 
	GetTags 
	KillSpawnedScript name = text_twitch_effect 
	FormatText ChecksumName = text_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	SetScreenElementProps { 
		id = { <id> child = 0 } 
		rgba = <text_rgba> 
	} 
ENDSCRIPT

SCRIPT stats_menu_change_other_skater_stats 
	IF ( <current_skater_name> = <name> ) 
		RETURN 
	ENDIF 
	IF ( <change> < 0 ) 
		RETURN 
	ENDIF 
	IF ( <change> > <points_available> ) 
		RETURN 
	ENDIF 
	GetStatValue skater = <name> <stat_name> 
	IF ( <stat_value> = 10 ) 
		GetArraySize stat_names 
		<index> = 0 
		BEGIN 
			<stat_name> = ( ( stat_names [ <index> ] ) . name ) 
			GetStatValue skater = <name> <stat_name> 
			IF ( <stat_value> < 10 ) 
				BREAK 
			ENDIF 
			<index> = ( <index> + 1 ) 
			IF ( <index> = <array_size> ) 
				RETURN 
			ENDIF 
		REPEAT <array_size> 
	ENDIF 
	SWITCH <stat_name> 
		CASE air 
			SetSkaterProfileInfoByName name = <name> params = { air = ( <stat_value> + <change> ) } 
		CASE run 
			SetSkaterProfileInfoByName name = <name> params = { run = ( <stat_value> + <change> ) } 
		CASE ollie 
			SetSkaterProfileInfoByName name = <name> params = { ollie = ( <stat_value> + <change> ) } 
		CASE speed 
			SetSkaterProfileInfoByName name = <name> params = { speed = ( <stat_value> + <change> ) } 
		CASE spin 
			SetSkaterProfileInfoByName name = <name> params = { spin = ( <stat_value> + <change> ) } 
		CASE switch 
			SetSkaterProfileInfoByName name = <name> params = { switch = ( <stat_value> + <change> ) } 
		CASE flip_speed 
			SetSkaterProfileInfoByName name = <name> params = { flip_speed = ( <stat_value> + <change> ) } 
		CASE rail_balance 
			SetSkaterProfileInfoByName name = <name> params = { rail_balance = ( <stat_value> + <change> ) } 
		CASE lip_balance 
			SetSkaterProfileInfoByName name = <name> params = { lip_balance = ( <stat_value> + <change> ) } 
		CASE manual_balance 
			SetSkaterProfileInfoByName name = <name> params = { manual_balance = ( <stat_value> + <change> ) } 
		DEFAULT 
			script_assert "bad stat name" 
	ENDSWITCH 
	<points_available> = ( <points_available> - <change> ) 
	IF NOT SetSkaterProfileInfoByName name = <name> params = { points_available = <points_available> } 
		printf "############### couldn\'t change points available!" 
	ENDIF 
ENDSCRIPT

SCRIPT stats_menu_exit 
	IF LevelIs load_skateshop 
		skater : add_skater_to_world 
		launch_ss_menu 
	ELSE 
		create_pause_menu 
	ENDIF 
ENDSCRIPT

SCRIPT launch_gamemode_menu 
	RunScriptOnScreenElement id = current_menu_anchor animate_out callback = create_gamemode_menu 
ENDSCRIPT

SCRIPT create_gamemode_menu 
	make_new_menu menu_id = gamemode_menu vmenu_id = gamemode_vmenu menu_title = "GAMEMODE" helper_text = generic_helper_text 
	SetScreenElementProps { id = gamemode_menu 
		event_handlers = [ 
			{ pad_back create_options_menu } 
		] 
	} 
	make_text_sub_menu_item text = "Career Mode" id = gamemode_career_mode pad_choose_script = change_gamemode_career_menu 
	make_text_sub_menu_item text = "Single Session" id = gamemode_single_session pad_choose_script = change_gamemode_singlesession_menu 
	make_text_sub_menu_item text = "Free Skate" id = gamemode_free_skate pad_choose_script = change_gamemode_freeskate_menu 
	make_text_sub_menu_item text = "Quickstart 2P" id = gamemode_quickstart_2p 
	make_text_sub_menu_item text = "Quickstart Server" id = gamemode_quickstart_server 
	make_text_sub_menu_item text = "back" id = gamemode_back pad_choose_script = create_options_menu 
	RunScriptOnScreenElement id = current_menu_anchor animate_in 
ENDSCRIPT

SCRIPT change_gamemode_career 
	printf "********** CHANGING GAME MODE TO CAREER" 
	SetGameType career 
	SetCurrentGameType 
ENDSCRIPT

SCRIPT change_gamemode_net 
	printf "********** CHANGING GAME MODE TO NET!!!" 
	SetGameType net 
	SetCurrentGameType 
ENDSCRIPT

SCRIPT change_gamemode_singlesession 
	SetGameType singlesession 
	SetCurrentGameType 
ENDSCRIPT

SCRIPT change_gamemode_freeskate_2p 
	SetGameType freeskate2p 
	SetCurrentGameType 
ENDSCRIPT

SCRIPT change_gamemode_freeskate 
	SetGameType freeskate 
	SetCurrentGameType 
ENDSCRIPT

SCRIPT change_gamemode_creategoals 
	SetGameType creategoals 
	SetCurrentGameType 
ENDSCRIPT

SCRIPT change_gamemode_career_menu 
	exit_pause_menu 
	SetGameType career 
	SetCurrentGameType 
	Retry 
ENDSCRIPT

SCRIPT change_gamemode_singlesession_menu 
	kill_all_panel_messages 
	SetGameType singlesession 
	SetCurrentGameType 
	GoalManager_DeactivateAllGoals 
	change EndOfReplayShouldJumpToPauseMenu = 0 
	Retry 
ENDSCRIPT

SCRIPT change_gamemode_freeskate_menu 
	exit_pause_menu 
	SetGameType freeskate 
	SetCurrentGameType 
	Retry 
ENDSCRIPT

SCRIPT menu_start_autotest 
	SetTesterScript test_advance 
	exit_pause_menu 
ENDSCRIPT

SCRIPT menu_stop_autotest 
	KillTesterScript 
	exit_pause_menu 
ENDSCRIPT

SCRIPT fake_button 
	FireEvent type = <type> source = system target = system data = { controller = 0 device_num = 0 } 
ENDSCRIPT

SCRIPT test_advance 
	BEGIN 
		<loops> = 5 
		BEGIN 
			wait 10 gameframes 
			IF IsMovieQueued 
				printf "AUTOTEST: In Cutscene/Movie/Camanim" 
				printf "AUTOTEST: Fake X" 
				fake_button type = pad_x 
				<loops> = 5 
			ELSE 
				IF NOT ScreenElementExists id = current_menu_anchor 
					printf "AUTOTEST: Menu Gone" 
					printf "AUTOTEST: Fake X and start" 
					fake_button type = pad_x 
					fake_button type = pad_down 
					<loops> = ( <loops> -1 ) 
				ELSE 
					printf "AUTOTEST: Fake Start" 
					fake_button type = pad_start 
					fake_button type = pad_down 
					<loops> = 5 
				ENDIF 
			ENDIF 
			IF ( <loops> = 0 ) 
				BREAK 
			ENDIF 
		REPEAT 
		printf "AUTOTEST: Advancing in 3 seconds" 
		wait 150 gameframes 
		printf "AUTOTEST: Advance" 
		cheats_menu_advance_stage 
	REPEAT 
ENDSCRIPT

SCRIPT launch_menu_test 
	RunScriptOnScreenElement id = current_menu_anchor animate_out callback = create_menu_test_menu 
ENDSCRIPT

SCRIPT menu_select menu_select_script = item_chosen 
	IF GotParam stop_streams 
		StopStream 
	ENDIF 
	IF GotParam stop_vibration 
	ENDIF 
	exit_pause_menu 
	<menu_select_script> 
ENDSCRIPT

SCRIPT item_chosen menu_id = current_menu_anchor 
	printf "item_chosen" 
	RunScriptOnScreenElement id = <menu_id> animate_out callback = create_pause_menu 
ENDSCRIPT

SCRIPT make_text_sub_menu_item { focus_script = do_scale_up 
		unfocus_script = do_scale_down 
		pad_choose_script = nullscript 
		font_face = small 
		parent_menu_id = current_menu 
		scale = 1 
		rgba = [ 88 105 112 128 ] 
	} 
	IF GotParam not_focusable 
		CreateScreenElement { 
			type = TextElement 
			parent = <parent_menu_id> 
			id = <id> 
			text = <text> 
			font = <font_face> 
			rgba = <rgba> 
			scale = <scale> 
			event_handlers = [ 
				{ focus <focus_script> params = <focus_params> } 
				{ unfocus <unfocus_script> params = <unfocus_params> } 
				{ pad_choose <pad_choose_script> params = <pad_choose_params> } 
				{ pad_start <pad_choose_script> params = <pad_choose_params> } 
			] 
			not_focusable 
		} 
	ELSE 
		IF GotParam no_choose_sound 
			CreateScreenElement { 
				type = TextElement 
				parent = <parent_menu_id> 
				id = <id> 
				text = <text> 
				font = <font_face> 
				rgba = <rgba> 
				scale = <scale> 
				event_handlers = [ 
					{ focus <focus_script> params = <focus_params> } 
					{ unfocus <unfocus_script> params = <unfocus_params> } 
					{ pad_choose <pad_choose_script> params = <pad_choose_params> } 
					{ pad_start <pad_choose_script> params = <pad_choose_params> } 
				] 
			} 
		ELSE 
			CreateScreenElement { 
				type = TextElement 
				parent = <parent_menu_id> 
				id = <id> 
				text = <text> 
				font = <font_face> 
				rgba = <rgba> 
				scale = <scale> 
				event_handlers = [ 
					{ focus <focus_script> params = <focus_params> } 
					{ unfocus <unfocus_script> params = <unfocus_params> } 
					{ pad_choose generic_menu_pad_choose_sound } 
					{ pad_start generic_menu_pad_choose_sound } 
					{ pad_choose <pad_choose_script> params = <pad_choose_params> } 
					{ pad_start <pad_choose_script> params = <pad_choose_params> } 
				] 
			} 
		ENDIF 
	ENDIF 
	IF GotParam pad_circle_script 
		SetScreenElementProps { id = <id> 
			event_handlers = [ 
				{ pad_circle <pad_circle_script> params = <pad_circle_params> } 
			] 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT make_text_menu_item { focus_script = do_scale_up 
		unfocus_script = do_scale_down 
		pad_choose_script = item_chosen 
		pad_back_script = exit_pause_menu 
	font_face = small } 
	CreateScreenElement { 
		type = TextElement parent = current_menu 
		id = <id> 
		text = <text> 
		font = <font_face> 
		rgba = [ 128 128 128 75 ] 
		event_handlers = [ 
			{ focus <focus_script> } 
			{ unfocus <unfocus_script> } 
			{ pad_choose <pad_choose_script> params = <pad_choose_params> } 
			{ pad_back <pad_back_script> } 
		] 
	} 
ENDSCRIPT

SCRIPT make_sprite_menu_item 
	make_theme_menu_item <...> dims = PAIR(300.00000000000, 20.70000076294) focus_script = sprite_focus unfocus_script = sprite_unfocus 
ENDSCRIPT

SCRIPT make_sprite_sub_menu_item { focus_script = sprite_focus 
		text = "Default sprite text" 
		unfocus_script = sprite_unfocus 
		pad_choose_script = item_chosen 
	} 
	CreateScreenElement { 
		type = TextElement parent = current_menu 
		rgba = [ 92 92 92 70 ] 
		id = <id> 
		font = small 
		text = <text> 
		scale = 1.00000000000 
		pos = PAIR(320.00000000000, 240.00000000000) 
		just = [ center center ] 
		event_handlers = [ 
			{ focus <focus_script> params = { text = <text> } } 
			{ unfocus <unfocus_script> } 
			{ pad_choose <pad_choose_script> params = <pad_choose_params> } 
		] 
	} 
ENDSCRIPT

SCRIPT make_toggle_menu_item { font = small 
		child_pos = { PAIR(210.00000000000, 0.00000000000) relative } 
		rgba = [ 88 105 112 128 ] 
		child_rgba = [ 88 105 112 128 ] 
		just = [ right top ] 
		child_just = [ left top ] 
		child_scale = 1 
		focus_script = do_scale_up 
		unfocus_script = do_scale_down 
		pad_choose_script = item_chosen 
		toggle_text = "off" 
	} 
	CreateScreenElement { 
		type = TextElement 
		parent = current_menu 
		id = <id> 
		font = <font> 
		pos = <pos> 
		rgba = <rgba> 
		just = <just> 
		text = <text> 
		scale = <scale> 
		event_handlers = [ 
			{ focus <focus_script> params = <focus_params> } 
			{ unfocus <unfocus_script> params = <unfocus_params> } 
			{ pad_choose <pad_choose_script> params = <pad_choose_params> } 
			{ pad_start <pad_choose_script> params = <pad_choose_params> } 
		] 
	} 
	CreateScreenElement { 
		type = TextElement 
		parent = <id> 
		font = <font> 
		pos = <child_pos> 
		rgba = <child_rgba> 
		just = <child_just> 
		text = <toggle_text> 
		scale = <child_scale> 
	} 
ENDSCRIPT

SCRIPT toggle_menu_item_on { 
		toggle_text = "on" 
	} 
	SetScreenElementProps { 
		id = { <id> child = 0 } 
		text = <toggle_text> 
	} 
ENDSCRIPT

SCRIPT toggle_menu_item_off { 
		toggle_text = "off" 
	} 
	SetScreenElementProps { 
		id = { <id> child = 0 } 
		text = <toggle_text> 
	} 
ENDSCRIPT

SCRIPT animate_in 
	SetButtonEventMappings block_menu_input 
	SetScreenElementProps id = root_window tags = { menu_state = entering } 
	DoMorph time = 0 scale = 0 alpha = 0 
	FireEvent type = focus target = <menu_id> 
	DoMorph time = 0.07000000030 scale = 1.10000002384 alpha = 0.40000000596 
	DoMorph time = 0.07000000030 scale = 0.94999998808 alpha = 1 
	DoMorph time = 0.07000000030 scale = 1.00000000000 
	SetScreenElementProps id = root_window tags = { menu_state = on } 
	IF NOT GotParam dont_unblock 
		SetButtonEventMappings unblock_menu_input 
	ENDIF 
ENDSCRIPT

SCRIPT menu_onscreen menu_id = current_menu_anchor 
	DoMorph scale = 1 time = 0 
	IF GotParam pos 
		DoMorph pos = <pos> 
	ENDIF 
	SetProps just = [ center center ] 
	GetTags 
	IF GotParam focus_child 
		FireEvent type = focus target = <menu_id> data = { child_id = <focus_child> } 
	ELSE 
		FireEvent type = focus target = <id> 
	ENDIF 
	IF NOT GotParam preserve_menu_state 
		SetScreenElementProps id = root_window tags = { menu_state = on } 
	ENDIF 
ENDSCRIPT

SCRIPT animate_out menu_id = current_menu_anchor 
	SetButtonEventMappings block_menu_input 
	SetScreenElementProps id = root_window tags = { menu_state = leaving } 
	GetTags 
	SetProps just = [ center center ] 
	DoMorph time = 0 scale = 1.00000000000 
	DoMorph time = 0.07000000030 scale = 1.29999995232 
	DoMorph time = 0.05000000075 scale = 1.39999997616 alpha = 0.05000000075 
	DoMorph time = 0.15000000596 scale = 0.00000000000 alpha = 0 
	SetScreenElementProps id = root_window tags = { menu_state = off } 
	SetScreenElementLock id = root_window off 
	DestroyScreenElement id = <menu_id> 
	SetButtonEventMappings unblock_menu_input 
ENDSCRIPT

SCRIPT menu_offscreen 
	SetScreenElementProps id = root_window tags = { menu_state = off } 
	SetScreenElementLock id = root_window off 
	GetTags 
	FireEvent type = unfocus target = <id> 
	DestroyScreenElement id = <id> recurse 
ENDSCRIPT

SCRIPT scale_sprite_up 
	DoMorph time = 0 scale = 0 alpha = 0.50000000000 
	DoMorph time = 0.30000001192 rot_angle = -360 scale = 1 alpha = 0.85000002384 
ENDSCRIPT

SCRIPT scale_sprite_down 
	DoMorph time = 0 rot_angle = 0 scale = 0 
ENDSCRIPT

SCRIPT do_scale_up rgba = [ 127 102 0 100 ] 
	GetTags 
	SetProps rgba = <rgba> 
	RunScriptOnScreenElement id = <id> do_random_effect params = { id = <id> } 
ENDSCRIPT

SCRIPT do_scale_down rgba = [ 88 105 112 128 ] 
	IF NOT GotParam no_sound 
		generic_menu_pad_up_down_sound 
	ENDIF 
	KillSpawnedScript name = do_random_effect 
	SetProps no_blur_effect 
	SetProps rgba = <rgba> 
ENDSCRIPT

SCRIPT do_random_effect 
	GetTags 
	SetTags random_effect_done = 0 
	RunScriptOnScreenElement id = <id> do_random_effect2 
	BEGIN 
		GetTags 
		IF ( <random_effect_done> = 1 ) 
			SetTags random_effect_done = 0 
			RunScriptOnScreenElement id = <id> do_random_effect2 params = { 
				id = <id> 
				effect = RANDOM(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1) RANDOMCASE 2 RANDOMCASE 3 RANDOMCASE 5 RANDOMCASE 8 RANDOMCASE 2 RANDOMCASE 3 RANDOMCASE 5 RANDOMCASE 2 RANDOMCASE 3 RANDOMCASE 5 RANDOMCASE 2 RANDOMCASE 10 RANDOMCASE 3 RANDOMCASE 2 RANDOMCASE 3 RANDOMCASE 5 RANDOMCASE 2 RANDOMCASE 3 RANDOMCASE 8 RANDOMCASE 3 RANDOMCASE 5 RANDOMCASE 9 RANDOMCASE 2 RANDOMCASE 3 RANDOMCASE 5 RANDOMCASE 2 RANDOMCASE 3 RANDOMCASE 5 RANDOMCASE 6 RANDOMCASE 2 RANDOMCASE 3 RANDOMCASE 9 RANDOMCASE 5 RANDOMCASE 3 RANDOMCASE 2 RANDOMCASE 3 RANDOMCASE 5 RANDOMCASE 2 RANDOMCASE 3 RANDOMCASE 5 RANDOMCASE 2 RANDOMCASE 3 RANDOMCASE 5 RANDOMCASE 6 RANDOMCASE 7 RANDOMCASE 1 RANDOMEND 
			} 
		ENDIF 
		wait 10 frame 
	REPEAT 
ENDSCRIPT

SCRIPT do_random_effect2 
	SWITCH <effect> 
		CASE 1 
			DoMorph time = 0.03999999911 scale = PAIR(1.10000002384, 0.94999998808) alpha = 0.10000000149 relative_scale 
			DoMorph time = 0.03999999911 scale = 1 alpha = 1 relative_scale 
		CASE 2 
			DoMorph time = 0.05000000075 pos = { PAIR(-0.75000000000, 0.50000000000) relative } 
			DoMorph time = 0.05000000075 pos = { PAIR(1.50000000000, -1.00000000000) relative } 
			DoMorph time = 0.05000000075 pos = { PAIR(-0.75000000000, 0.50000000000) relative } 
		CASE 3 
			DoMorph time = 0.05000000075 alpha = 0.60000002384 
			DoMorph time = 0.05000000075 alpha = 1 
		CASE 4 
			SetProps blur_effect 
			do_blur_effect_highlight 
			SetProps no_blur_effect 
		CASE 5 
			DoMorph time = 0.05000000075 pos = { PAIR(-1.50000000000, 0.50000000000) relative } 
			DoMorph time = 0.05000000075 pos = { PAIR(3.00000000000, -1.00000000000) relative } 
			DoMorph time = 0.05000000075 pos = { PAIR(-1.50000000000, 0.50000000000) relative } 
		CASE 6 
			DoMorph time = 0.05000000075 pos = { PAIR(-0.75000000000, 1.50000000000) relative } 
			DoMorph time = 0.05000000075 pos = { PAIR(1.50000000000, -3.00000000000) relative } 
			DoMorph time = 0.05000000075 pos = { PAIR(-0.75000000000, 1.50000000000) relative } 
		CASE 7 
			SetProps blur_effect 
			do_blur_effect_accept 
			SetProps no_blur_effect 
		CASE 8 
			DoMorph time = 0.05000000075 scale = 1.10000002384 relative_scale 
			DoMorph time = 0.05000000075 scale = 1 relative_scale 
		CASE 9 
			DoMorph time = 0.03999999911 scale = PAIR(0.94999998808, 0.64999997616) alpha = 0.80000001192 relative_scale 
			DoMorph time = 0.03999999911 scale = 1 alpha = 1 relative_scale 
		CASE 10 
			DoMorph time = 0.05000000075 pos = { PAIR(-2.00000000000, 0.00000000000) relative } 
			DoMorph time = 0.05000000075 pos = { PAIR(4.00000000000, 0.00000000000) relative } 
			DoMorph time = 0.05000000075 pos = { PAIR(-2.00000000000, 0.00000000000) relative } 
		DEFAULT 
			SetProps blur_effect 
			do_blur_effect 
			SetProps no_blur_effect 
	ENDSWITCH 
	SetTags random_effect_done = 1 
ENDSCRIPT

SCRIPT hide_root_window 
	DoScreenElementMorph id = root_window scale = 0 
ENDSCRIPT

SCRIPT unhide_root_window 
	DoScreenElementMorph id = root_window scale = 1 
ENDSCRIPT

SCRIPT generic_menu_update_arrows menu_id = current_menu 
	IF NOT ObjectExists id = <up_arrow_id> 
		RETURN 
	ENDIF 
	IF NOT ObjectExists id = <down_arrow_id> 
		RETURN 
	ENDIF 
	IF MenuSelectedIndexIs id = <menu_id> first 
		SetScreenElementProps { 
			id = <up_arrow_id> 
			rgba = [ 128 128 128 0 ] 
		} 
	ELSE 
		SetScreenElementProps { 
			id = <up_arrow_id> 
			rgba = [ 128 128 128 128 ] 
		} 
	ENDIF 
	IF MenuSelectedIndexIs id = <menu_id> last 
		SetScreenElementProps { 
			id = <down_arrow_id> 
			rgba = [ 128 128 128 0 ] 
		} 
	ELSE 
		SetScreenElementProps { 
			id = <down_arrow_id> 
			rgba = [ 128 128 128 128 ] 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT generic_menu_pad_back 
	printf "generic_menu_pad_back Parameters = " 
	generic_menu_pad_back_sound 
	IF GotParam callback 
		<callback> <...> 
	ENDIF 
ENDSCRIPT

SCRIPT generic_menu_pad_choose 
	IF GotParam callback 
		<callback> <...> 
	ENDIF 
ENDSCRIPT

SCRIPT generic_menu_buzzer_sound 
	PlaySound GUI_Buzzer01 vol = 100 
ENDSCRIPT

SCRIPT generic_menu_pad_back_sound 
	PlaySound DE_MenuBack vol = 100 
ENDSCRIPT

SCRIPT generic_menu_pad_up_down_sound 
ENDSCRIPT

SCRIPT generic_menu_pad_choose_sound 
	PlaySound DE_MenuSelect vol = 100 
ENDSCRIPT

disable_menu_sounds = 0 
SCRIPT generic_menu_up_or_down_sound menu_id = current_menu 
	IF ( disable_menu_sounds = 0 ) 
		IF GotParam up 
			PlaySound MenuUp vol = 100 
		ENDIF 
		IF GotParam down 
			PlaySound MenuUp pitch = 87.62000274658 vol = 100 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT generic_menu_scroll_sideways_sound 
	IF ( disable_menu_sounds = 0 ) 
		PlaySound MenuUp vol = 100 
	ENDIF 
ENDSCRIPT

SCRIPT parked_scroll_sideways_sound 
	PlaySound MenuUp vol = 100 
ENDSCRIPT

SCRIPT generic_keyboard_sound 
ENDSCRIPT

SCRIPT theme_menu_pad_choose_sound 
	PlaySound DE_MenuSelect vol = 100 
ENDSCRIPT

SCRIPT generic_pause_exit_sound 
	PlaySound PauseExit 
ENDSCRIPT

SCRIPT show_container 
	IF NOT GotParam id 
		printf "show_container missing param id" 
		RETURN 
	ENDIF 
	GetScreenElementDims id = <id> 
	scale = ( ( <width> / 4 ) * PAIR(1.00000000000, 0.00000000000) + ( <height> / 4 ) * PAIR(0.00000000000, 1.00000000000) ) 
	CreateScreenElement { 
		type = SpriteElement 
		texture = black 
		parent = <id> 
		pos = PAIR(0.00000000000, 0.00000000000) 
		just = [ left top ] 
		rgba = [ 0 128 0 128 ] 
		scale = <scale> 
		z_priority = -10 
	} 
ENDSCRIPT

SCRIPT pause_show_deck active_viewport = 0 node = TRG_Restart01 parent = root_window 
	kill_pause_deck 
	IF NOT ObjectExists id = skater 
		RETURN 
	ENDIF 
	IF IsObserving 
		RETURN 
	ENDIF 
	IF NOT ScreenElementExists id = <parent> 
		printf "WARNING: pause_show_deck couldn\'t find parent %s" s = <parent> 
		RETURN 
	ENDIF 
	SetScreenElementLock id = <parent> off 
	IF GotParam no_slide 
		pos = PAIR(360.00000000000, 220.00000000000) 
	ELSE 
		pos = PAIR(800.00000000000, 220.00000000000) 
	ENDIF 
	GetSkaterId 
	CreateScreenElement { 
		parent = <parent> 
		type = Element3d 
		id = pause_deck 
		SkeletonName = thps5_human 
		CloneModel = <objId> 
		CloneModelGeoms = [ board ] 
		TexDictOffset = 20 
		pos = <pos> 
		CameraZ = -6 
		scale = 0.11999999732 
		Tilt = 0 
		PivotPoint = VECTOR(0.00000000000, 4.11999988556, 0.00000000000) 
		active_viewport = <active_viewport> 
		AngleOrderXYZ 
		anglex = -1.57000005245 
		angley = 0 
		anglez = 0.40000000596 
	} 
	spawnscript rotate_pause_deck <no_slide> 
ENDSCRIPT

SCRIPT kill_pause_deck 
	IF ObjectExists id = pause_deck 
		KillSpawnedScript name = rotate_pause_deck 
		DestroyScreenElement id = pause_deck 
	ENDIF 
ENDSCRIPT

SCRIPT rotate_pause_deck 
	IF NOT ObjectExists id = pause_deck 
		RETURN 
	ENDIF 
	rot_angle = 0 
	DoScreenElementMorph time = 0.25000000000 id = pause_deck pos = PAIR(360.00000000000, 220.00000000000) 
	BEGIN 
		IF NOT ObjectExists id = pause_deck 
			RETURN 
		ENDIF 
		SetScreenElementProps id = pause_deck angley = <rot_angle> 
		rot_angle = ( <rot_angle> + 0.06250000000 ) 
		wait 1 gameframes 
	REPEAT 
ENDSCRIPT

SCRIPT pause_deck_sync_to_skater_graphic 
	GetCurrentSkaterProfileIndex 
	IF GetPlayerAppearancePart player = <currentSkaterProfileIndex> part = deck_graphic 
		GetActualCASOptionStruct part = deck_graphic desc_id = <desc_id> 
	ENDIF 
ENDSCRIPT

SCRIPT pause_deck_sync_to_skater_griptape 
	GetCurrentSkaterProfileIndex 
	IF GetPlayerAppearancePart player = <currentSkaterProfileIndex> part = griptape 
		GetActualCASOptionStruct part = griptape desc_id = <desc_id> 
	ENDIF 
ENDSCRIPT

SCRIPT fadetoblack time = 0.50000000000 alpha = 0.50000000000 z_priority = 0 rgba = [ 0 0 0 128 ] scale = PAIR(300.00000000000, 200.00000000000) texture = black id = screenfader pos = PAIR(320.00000000000, 240.00000000000) 
	IF GotParam on 
		IF NOT ScreenElementExists id = <id> 
			SetScreenElementLock off id = root_window 
			IF NOT GotParam create_script 
				CreateScreenElement { 
					type = SpriteElement 
					parent = root_window 
					id = <id> 
					texture = <texture> 
					pos = <pos> 
					rgba = <rgba> 
					just = [ center center ] 
					scale = <scale> 
					alpha = 0 
					z_priority = <z_priority> 
				} 
			ELSE 
				<create_script> 
			ENDIF 
			DoScreenElementMorph id = <id> time = <time> alpha = <alpha> 
		ENDIF 
	ENDIF 
	IF GotParam off 
		IF ScreenElementExists id = <id> 
			DoScreenElementMorph id = <id> time = <time> alpha = 0 
			wait <time> seconds 
			IF ScreenElementExists id = <id> 
				DestroyScreenElement id = <id> 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

boardshop_deck_price = 50 
unlock_sponsor_boards = 0 
in_boardshop = 0 
SCRIPT launch_boardshop 
	SetGameType freeskate 
	SetCurrentGameType 
	DisplayLoadingScreen freeze 
	select_skater_get_current_skater_name 
	IF NOT ( <current_skater> = custom ) 
		load_pro_skater name = custom 
	ENDIF 
	main_menu_play_level level = load_boardshop 
ENDSCRIPT

entered_skateshop_through_door = 0 
SCRIPT set_boardshop_cam 
	IF NOT GotParam no_wait 
		wait 3 gameframe 
		GoalManager_HidePoints 
	ENDIF 
	IF LevelIs load_boardshop 
		skater : Obj_MoveToNode name = skateshop_player_restart orient 
		MakeSkaterGoto SkateShopAI params = { NoSFX CAS_Screen } 
		KillSkaterCamAnim all 
		PlaySkaterCamAnim name = skateshop_startcam play_hold 
	ENDIF 
ENDSCRIPT

SCRIPT launch_boardshop_menu 
	load_boardshop_textures_to_main_memory 
	SetScreenElementLock id = root_window off 
	pulse_blur 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	IF GotParam parent_index 
		change edit_skater_menu_level_1_index = <parent_index> 
	ENDIF 
	IF ( unlock_sponsor_boards = 1 ) 
		unlock_sponsor_decks 
	ENDIF 
	spawnscript set_boardshop_cam 
	boardshop_create_initial_menus 
ENDSCRIPT

SCRIPT create_end_run_menu 
	dialog_box_exit 
	SetGameType freeskate2p 
	SetCurrentGameType 
	PauseMusicAndStreams 
	PauseGame 
	pause_menu_gradient on 
	kill_start_key_binding 
	FormatText ChecksumName = title_icon "%i_2_player" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	make_new_themed_option_menu title = "2 PLAYERS" title_icon = <title_icon> right_bracket_alpha = 0.00000000000 
	create_helper_text generic_helper_text_no_back 
	set_theme_icons 
	make_sprite_menu_item text = "Start Game" id = menu_end_run_start_game pad_choose_script = create_network_game_options_menu pad_choose_params = { end_run } 
	make_text_sprite texture = <continue_icon> parent = menu_end_run_start_game 
	make_sprite_menu_item text = "Change Levels" id = menu_end_run_change_levels pad_choose_script = launch_level_select_menu pad_choose_params = { end_run } 
	make_text_sprite texture = <level_icon> parent = menu_end_run_change_levels 
	make_sprite_menu_item text = "Split Mode" id = menu_end_run_split_mode pad_choose_script = create_split_menu pad_choose_params = { callback_script = create_end_run_menu end_run } 
	make_text_sprite texture = <split_icon> parent = menu_end_run_split_mode 
	make_sprite_menu_item text = "Quit" id = menu_end_run_quit pad_choose_script = menu_confirm_quit pad_choose_params = { no_script = create_end_run_menu back_script = create_end_run_menu } 
	make_text_sprite texture = <quit_icon> parent = menu_end_run_quit 
	build_top_bar pos = PAIR(0.00000000000, 62.00000000000) 
	GoalManager_HideGoalPoints 
	GoalManager_HidePoints 
	FireEvent type = focus target = current_menu_anchor 
ENDSCRIPT


