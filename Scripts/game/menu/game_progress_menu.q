
SCRIPT game_progress_menu_create 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	GoalManager_HidePoints 
	GoalManager_HideGoalPoints 
	IF NOT LevelIs load_skateshop 
		PauseMusicAndStreams 1 
	ELSE 
		skater : remove_skater_from_world 
	ENDIF 
	SetScreenElementLock id = root_window off 
	CreateScreenElement { 
		type = ContainerElement 
		parent = root_window 
		id = progress_anchor 
		dims = PAIR(640, 480) 
		pos = PAIR(320, 240) 
	} 
	AssignAlias id = progress_anchor alias = current_menu_anchor 
	create_helper_text { helper_text_elements = [ { text = "\\b7/\\b4 = Select" } 
			{ text = "\\bn = Back" } 
		] 
	} 
	kill_start_key_binding 
	FormatText ChecksumName = title_icon "%i_pro" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	build_theme_sub_title title = "GAME PROGRESS" title_icon = <title_icon> 
	FormatText ChecksumName = paused_icon "%i_paused_icon" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	IF LevelIs load_skateshop 
		build_top_and_bottom_blocks 
		make_mainmenu_3d_plane 
	ELSE 
		build_theme_box_icons icon_texture = <paused_icon> 
		build_grunge_piece 
		build_top_bar pos = PAIR(0, 62) 
	ENDIF 
	CreateScreenElement { 
		type = ContainerElement 
		parent = progress_anchor 
		id = progress_menu 
		dims = PAIR(640, 480) 
		pos = PAIR(320, 640) 
	} 
	AssignAlias id = progress_menu alias = current_menu_anchor 
	theme_background width = 6.34999990463 pos = PAIR(320.00000000000, 85.00000000000) num_parts = 10.50000000000 
	<root_pos> = PAIR(80.00000000000, 25.00000000000) 
	FormatText ChecksumName = text_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = icon_color "%i_ICON_ON_VALUE" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	GetStackedScreenElementPos X id = <id> offset = PAIR(115.00000000000, 0.00000000000) 
	CreateScreenElement { 
		type = SpriteElement 
		parent = current_menu_anchor 
		id = view_progress_menu_up_arrow 
		texture = up_arrow 
		rgba = [ 128 128 128 85 ] 
		pos = PAIR(300.00000000000, 90.00000000000) 
		just = [ left top ] 
		z_priority = 3 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = current_menu_anchor 
		texture = black 
		scale = PAIR(2.00000000000, 75.00000000000) 
		pos = PAIR(380.00000000000, 90.00000000000) 
		just = [ left top ] 
		rgba = [ 0 0 0 128 ] 
	} 
	GetStackedScreenElementPos Y id = view_progress_menu_up_arrow offset = PAIR(0.00000000000, 260.00000000000) 
	CreateScreenElement { 
		type = SpriteElement 
		parent = current_menu_anchor 
		id = view_progress_menu_down_arrow 
		texture = down_arrow 
		rgba = [ 128 128 128 85 ] 
		pos = <pos> 
		just = [ left top ] 
		z_priority = 3 
	} 
	CreateScreenElement { 
		type = VScrollingMenu 
		parent = current_menu_anchor 
		id = vs1 
		dims = PAIR(640.00000000000, 245.00000000000) 
		pos = PAIR(54.00000000000, 110.00000000000) 
		just = [ left top ] 
		internal_just = [ center top ] 
	} 
	CreateScreenElement { 
		type = VMenu 
		parent = <id> 
		id = progress_vmenu 
		pos = PAIR(0.00000000000, 0.00000000000) 
		just = [ left top ] 
		internal_just = [ left top ] 
		dont_allow_wrap 
		event_handlers = [ 
			{ pad_up menu_vert_blink_arrow params = { id = view_progress_menu_up_arrow rgba = <text_rgba> } } 
			{ pad_down menu_vert_blink_arrow params = { id = view_progress_menu_down_arrow rgba = <text_rgba> } } 
			{ pad_up generic_menu_up_or_down_sound params = { up } } 
			{ pad_down generic_menu_up_or_down_sound params = { down } } 
		] 
	} 
	AssignAlias id = progress_vmenu alias = current_menu 
	SetScreenElementProps { 
		id = current_menu 
		event_handlers = [ { pad_back generic_menu_pad_back params = { callback = game_progress_menu_exit } } ] 
	} 
	GoalManager_GetNumberOfGoalPoints total 
	FormatText TextName = goal_points "%i / %j" i = <goal_points> j = total_num_goals 
	progress_menu_add_item id1 = progress_vmenu left_col_text = " GOALS COMPLETED:" right_col_text = <goal_points> 
	progress_menu_add_item id1 = progress_vmenu seperator 
	GetCompletionStatusText mode = SKATER_UNLOCKED_IRONMAN 
	progress_menu_add_item id1 = progress_vmenu left_col_text = " BEGINNER STORY MODE SECRET:" right_col_text = <completion_status> 
	GetCompletionStatusText mode = SKATER_UNLOCKED_KISSDUDE 
	progress_menu_add_item id1 = progress_vmenu left_col_text = " NORMAL STORY MODE SECRET:" right_col_text = <completion_status> 
	GetCompletionStatusText mode = SKATER_UNLOCKED_CREATURE 
	progress_menu_add_item id1 = progress_vmenu left_col_text = " SICK STORY MODE SECRET:" right_col_text = <completion_status> 
	progress_menu_add_item id1 = progress_vmenu seperator 
	GetArraySize level_select_menu_level_info 
	<index> = 0 
	BEGIN 
		IF NOT ( ( ( level_select_menu_level_info [ <index> ] ) . level ) = load_sk5ed_gameplay ) 
			<level_num> = ( ( level_select_menu_level_info [ <index> ] ) . level_num ) 
			GetLevelNumTapeCollected level = <level_num> 
			IF GetGlobalFlag flag = ( ( level_select_menu_level_info [ <index> ] ) . flag ) 
				FormatText TextName = level_text " %s SECRET TAPE:" s = ( ( level_select_menu_level_info [ <index> ] ) . text ) 
			ELSE 
				IF ( all_levels_unlocked = 1 ) 
					FormatText TextName = level_text " %s SECRET TAPE:" s = ( ( level_select_menu_level_info [ <index> ] ) . text ) 
				ELSE 
					FormatText TextName = level_text " %s SECRET TAPE:" s = "??????" 
				ENDIF 
			ENDIF 
			progress_menu_add_item id1 = progress_vmenu left_col_text = <level_text> check_box = <collected> 
		ENDIF 
		<index> = ( <index> + 1 ) 
	REPEAT 9 
	progress_menu_add_item id1 = progress_vmenu seperator 
	GetCompletionStatus mode = LEVEL_UNLOCKED_SC2 
	IF ( ( GetGlobalFlag flag = LEVEL_UNLOCKED_NJ ) | ( all_levels_unlocked = 1 ) ) 
		progress_menu_add_item id1 = progress_vmenu left_col_text = " NEW JERSEY OLD SKOOL LEVEL:" check_box = <completion_status> 
	ELSE 
		progress_menu_add_item id1 = progress_vmenu left_col_text = " ?????? SKOOL LEVEL:" check_box = <completion_status> 
	ENDIF 
	GetCompletionStatus mode = LEVEL_UNLOCKED_VN 
	IF ( ( GetGlobalFlag flag = LEVEL_UNLOCKED_HI ) | ( all_levels_unlocked = 1 ) ) 
		progress_menu_add_item id1 = progress_vmenu left_col_text = " HAWAII OLD SKOOL LEVEL:" check_box = <completion_status> 
	ELSE 
		progress_menu_add_item id1 = progress_vmenu left_col_text = " ?????? OLD SKOOL LEVEL:" check_box = <completion_status> 
	ENDIF 
	GetCompletionStatus mode = LEVEL_UNLOCKED_HN 
	IF ( ( GetGlobalFlag flag = LEVEL_UNLOCKED_RU ) | ( all_levels_unlocked = 1 ) ) 
		progress_menu_add_item id1 = progress_vmenu left_col_text = " MOSCOW OLD SKOOL LEVEL:" check_box = <completion_status> 
	ELSE 
		progress_menu_add_item id1 = progress_vmenu left_col_text = " ?????? OLD SKOOL LEVEL:" check_box = <completion_status> 
	ENDIF 
	progress_menu_add_item id1 = progress_vmenu seperator 
	GetArraySize level_select_menu_level_info 
	<index> = 0 
	BEGIN 
		IF NOT ( ( ( level_select_menu_level_info [ <index> ] ) . level ) = load_sk5ed_gameplay ) 
			IF NOT ( ( ( level_select_menu_level_info [ <index> ] ) . level ) = load_TestLevel ) 
				IF NOT ( ( ( level_select_menu_level_info [ <index> ] ) . level ) = load_Default ) 
					IF NOT StructureContains structure = ( ( level_select_menu_level_info [ <index> ] ) ) DEVKIT_ONLY 
						<level_num> = ( ( level_select_menu_level_info [ <index> ] ) . level_num ) 
						GetLevelGapTotals level = <level_num> 
						IF ( <num_gaps> = 0 ) 
							<gaps_text> = "0 / ??" 
						ELSE 
							FormatText TextName = gaps_text "%i / %j" i = <num_collected_gaps> j = <num_gaps> 
						ENDIF 
						IF GetGlobalFlag flag = ( ( level_select_menu_level_info [ <index> ] ) . flag ) 
							FormatText TextName = level_text " %s GAPS:" s = ( ( level_select_menu_level_info [ <index> ] ) . text ) 
						ELSE 
							IF ( all_levels_unlocked = 1 ) 
								FormatText TextName = level_text " %s GAPS:" s = ( ( level_select_menu_level_info [ <index> ] ) . text ) 
							ELSE 
								FormatText TextName = level_text " %s GAPS:" s = "??????" 
							ENDIF 
						ENDIF 
						progress_menu_add_item id1 = progress_vmenu left_col_text = <level_text> right_col_text = <gaps_text> 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
		<index> = ( <index> + 1 ) 
	REPEAT ( <array_size> ) 
	IF LevelIs load_skateshop 
		DoScreenElementMorph id = current_menu_anchor pos = PAIR(320.00000000000, 218.00000000000) time = 0.20000000298 
	ELSE 
		DoScreenElementMorph id = current_menu_anchor pos = PAIR(320.00000000000, 240.00000000000) time = 0.20000000298 
	ENDIF 
	DoScreenElementMorph id = progress_vmenu time = 0.20000000298 pos = PAIR(0.00000000000, -200.00000000000) 
	FireEvent type = focus target = current_menu 
ENDSCRIPT

SCRIPT GetCompletionStatus 
	IF ( GetGlobalFlag flag = <mode> ) 
		<completion_status> = 1 
	ELSE 
		<completion_status> = 0 
	ENDIF 
	RETURN completion_status = <completion_status> 
ENDSCRIPT

SCRIPT GetCompletionStatusText 
	IF ( GetGlobalFlag flag = <mode> ) 
		SWITCH <mode> 
			CASE SKATER_UNLOCKED_IRONMAN 
				<completion_status> = "DONE: IRON MAN" 
			CASE SKATER_UNLOCKED_KISSDUDE 
				<completion_status> = "DONE: GENE" 
			CASE SKATER_UNLOCKED_CREATURE 
				<completion_status> = "DONE: T.H.U.D." 
		ENDSWITCH 
	ELSE 
		<completion_status> = "NOT FINISHED" 
	ENDIF 
	RETURN completion_status = <completion_status> 
ENDSCRIPT

SCRIPT progress_menu_add_item choose_script = nullscript left_col_text = "" right_col_text = "" 
	FormatText ChecksumName = off_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = on_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	<anchor_id1> = <id1> 
	IF GotParam seperator 
		CreateScreenElement { 
			type = ContainerElement 
			parent = <id1> 
			pos = PAIR(65.00000000000, 10.00000000000) 
			dims = PAIR(200.00000000000, 20.00000000000) 
			not_focusable 
		} 
		<anchor_id1> = <id> 
		CreateScreenElement { 
			type = SpriteElement 
			parent = <anchor_id1> 
			texture = black 
			scale = PAIR(132.00000000000, 3.29999995232) 
			pos = PAIR(4.00000000000, 0.00000000000) 
			just = [ left top ] 
			rgba = [ 0 0 0 90 ] 
			not_focusable 
		} 
	ELSE 
		IF GotParam check_box 
			FormatText ChecksumName = check_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
			FormatText ChecksumName = checkmark_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
			CreateScreenElement { 
				type = ContainerElement 
				parent = <id1> 
				pos = PAIR(65.00000000000, 10.00000000000) 
				dims = PAIR(200.00000000000, 25.00000000000) 
				event_handlers = [ 
					{ focus progress_menu_focus params = { checkbox_item = checkbox_item } } 
					{ unfocus progress_menu_unfocus params = { checkbox_item = checkbox_item } } 
				] 
			} 
			<anchor_id1> = <id> 
			CreateScreenElement { 
				type = TextElement 
				parent = <anchor_id1> 
				font = small 
				text = <left_col_text> 
				pos = PAIR(10.00000000000, 0.00000000000) 
				just = [ left top ] 
				rgba = <off_rgba> 
				scale = 1.00000000000 
			} 
			CreateScreenElement { 
				type = SpriteElement 
				parent = <anchor_id1> 
				texture = checkbox 
				pos = ( PAIR(420.00000000000, 0.00000000000) + PAIR(0.00000000000, 5.00000000000) ) 
				just = [ center top ] 
				scale = 0.55000001192 
				rgba = <check_rgba> 
				z_priority = 5 
			} 
			IF ( <check_box> = 1 ) 
				CreateScreenElement { 
					type = SpriteElement 
					parent = <id> 
					texture = checkmark 
					pos = PAIR(25.00000000000, -7.00000000000) 
					just = [ center top ] 
					rgba = <checkmark_rgba> 
					z_priority = 6 
					scale = 1.39999997616 
				} 
			ELSE 
				CreateScreenElement { 
					type = SpriteElement 
					parent = <id> 
					texture = checkmark 
					pos = PAIR(25.00000000000, -7.00000000000) 
					just = [ center top ] 
					rgba = [ 0 0 0 0 ] 
					z_priority = 6 
					scale = 1.39999997616 
				} 
			ENDIF 
			highlight_angle = RANDOM_NO_REPEAT(1, 1, 1, 1, 1, 1, 1, 1, 1, 1) RANDOMCASE 2 RANDOMCASE -2 RANDOMCASE 3 RANDOMCASE -3 RANDOMCASE 3.50000000000 RANDOMCASE -3 RANDOMCASE 5 RANDOMCASE -4 RANDOMCASE 2.50000000000 RANDOMCASE -4.50000000000 RANDOMEND 
			CreateScreenElement { 
				type = SpriteElement 
				parent = <anchor_id1> 
				texture = de_highlight_bar 
				pos = PAIR(262.00000000000, 10.00000000000) 
				just = [ center center ] 
				rgba = [ 0 0 0 0 ] 
				z_priority = 3 
				scale = PAIR(4.09999990463, 0.69999998808) 
				rot_angle = ( <highlight_angle> / 4 ) 
			} 
		ELSE 
			CreateScreenElement { 
				type = ContainerElement 
				parent = <id1> 
				pos = PAIR(65.00000000000, 10.00000000000) 
				dims = PAIR(200.00000000000, 25.00000000000) 
				event_handlers = [ 
					{ focus progress_menu_focus } 
					{ unfocus progress_menu_unfocus } 
				] 
			} 
			<anchor_id1> = <id> 
			CreateScreenElement { 
				type = TextElement 
				parent = <anchor_id1> 
				font = small 
				text = <left_col_text> 
				pos = PAIR(10.00000000000, 0.00000000000) 
				just = [ left top ] 
				rgba = <off_rgba> 
				scale = 1.00000000000 
			} 
			CreateScreenElement { 
				type = TextElement 
				parent = <anchor_id1> 
				font = small 
				text = <right_col_text> 
				pos = PAIR(420.00000000000, 0.00000000000) 
				just = [ center top ] 
				rgba = <off_rgba> 
				scale = 1.00000000000 
			} 
			highlight_angle = RANDOM_NO_REPEAT(1, 1, 1, 1, 1, 1, 1, 1, 1, 1) RANDOMCASE 2 RANDOMCASE -2 RANDOMCASE 3 RANDOMCASE -3 RANDOMCASE 3.50000000000 RANDOMCASE -3 RANDOMCASE 5 RANDOMCASE -4 RANDOMCASE 2.50000000000 RANDOMCASE -4.50000000000 RANDOMEND 
			CreateScreenElement { 
				type = SpriteElement 
				parent = <anchor_id1> 
				texture = de_highlight_bar 
				pos = PAIR(262.00000000000, 10.00000000000) 
				just = [ center center ] 
				rgba = [ 0 0 0 0 ] 
				z_priority = 3 
				scale = PAIR(4.09999990463, 0.69999998808) 
				rot_angle = ( <highlight_angle> / 4 ) 
			} 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT progress_menu_focus 
	GetTags 
	FormatText ChecksumName = text_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	RunScriptOnScreenElement id = { <id> child = 0 } text_twitch_effect2 
	DoScreenElementMorph { 
		id = { <id> child = 0 } 
		rgba = <text_rgba> 
	} 
	IF GotParam checkbox_item 
		FormatText ChecksumName = bar_rgba "%i_HIGHLIGHT_BAR_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
		SetScreenElementProps { 
			id = { <id> child = 2 } 
			rgba = <bar_rgba> 
		} 
	ELSE 
		RunScriptOnScreenElement id = { <id> child = 1 } text_twitch_effect2 
		DoScreenElementMorph { 
			id = { <id> child = 1 } 
			rgba = <text_rgba> 
		} 
		FormatText ChecksumName = bar_rgba "%i_HIGHLIGHT_BAR_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
		SetScreenElementProps { 
			id = { <id> child = 2 } 
			rgba = <bar_rgba> 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT progress_menu_unfocus 
	GetTags 
	FormatText ChecksumName = text_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	KillSpawnedScript name = text_twitch_effect2 
	DoScreenElementMorph { 
		id = { <id> child = 0 } 
		rgba = <text_rgba> 
	} 
	IF GotParam checkbox_item 
		SetScreenElementProps { 
			id = { <id> child = 2 } 
			rgba = [ 0 0 0 0 ] 
		} 
	ELSE 
		DoScreenElementMorph { 
			id = { <id> child = 1 } 
			rgba = <text_rgba> 
		} 
		SetScreenElementProps { 
			id = { <id> child = 2 } 
			rgba = [ 0 0 0 0 ] 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT game_progress_menu_exit 
	IF ObjectExists id = progress_anchor 
		DestroyScreenElement id = progress_anchor 
		wait 1 gameframe 
	ENDIF 
	IF ObjectExists id = box_icon 
		DestroyScreenElement id = box_icon 
		wait 1 gameframe 
	ENDIF 
	IF ObjectExists id = box_icon_2 
		DestroyScreenElement id = box_icon_2 
		wait 1 gameframe 
	ENDIF 
	IF ObjectExists id = grunge_anchor 
		DestroyScreenElement id = grunge_anchor 
		wait 1 gameframe 
	ENDIF 
	IF LevelIs load_skateshop 
		create_setup_options_menu 
	ELSE 
		create_options_menu 
	ENDIF 
ENDSCRIPT


