
theme_menu_bg_parts_height = 23 
SCRIPT set_theme_icons 
	FormatText ChecksumName = continue_icon "%i_continue" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = options_icon "%i_options" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = level_icon "%i_level" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = save_icon "%i_save" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = replay_icon "%i_replay" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = end_icon "%i_end" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = gap_icon "%i_gap" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = quit_icon "%i_quit" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = model_icon "%i_model" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = retry_icon "%i_retry" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = view_icon "%i_view" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = stats_icon "%i_stats" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = split_icon "%i_split" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = back_icon "%i_back" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = load_icon "%i_load" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = new_icon "%i_new" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = special_icon "%i_special" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = name_cat_icon "%i_name_cat" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = career_ops_icon "%i_career_ops" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = edit_skater_icon "%i_edit_skater" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = skateshop_icon "%i_skateshop" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = cheats_icon "%i_cheats" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = online_icon "%i_online" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	RETURN <...> 
ENDSCRIPT

SCRIPT build_pause_menu_parts 
	FormatText ChecksumName = paused_piece "%i_paused_piece" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = paused_icon "%i_paused_icon" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	build_grunge_piece pos = PAIR(0, 240) 
	CreateScreenElement { 
		type = SpriteElement 
		parent = current_menu_anchor 
		id = paused_piece 
		texture = <paused_piece> 
		pos = PAIR(-200, 70) 
		rgba = [ 128 128 128 108 ] 
		just = [ center center ] 
		scale = PAIR(1.1, 1.15) 
		alpha = 0 
		z_priority = 2 
		rot_angle = 40 
	} 
	IF ( inside_pause = 0 ) 
		change inside_pause = 1 
		PlaySound DE_MenuFlyUp vol = 100 
		PlaySound DE_PauseFlyIn vol = 100 
		DoScreenElementMorph scale = 1 time = 0 id = pause_menu 
		DoScreenElementMorph id = pause_menu time = 0.20000000298 pos = PAIR(320.00000000000, 255.00000000000) 
		FireEvent type = focus target = pause_menu 
		SetScreenElementProps id = root_window tags = { menu_state = on } 
		IF ScreenElementExists id = grunge_anchor 
			DoScreenElementMorph id = grunge_anchor time = 0.34999999404 pos = PAIR(320.00000000000, 240.00000000000) 
			wait 0.20000000298 seconds 
		ENDIF 
		IF ScreenElementExists id = paused_piece 
			DoScreenElementMorph id = paused_piece time = 0.25000000000 pos = PAIR(172.00000000000, 90.00000000000) rot_angle = -9 alpha = 1 
			IF GotParam show_deck 
				pause_show_deck parent = current_menu_anchor 
			ENDIF 
			IF ScreenElementExists id = music_track_anchor 
				DoScreenElementMorph id = music_track_anchor time = 0.25000000000 pos = PAIR(575.00000000000, 320.00000000000) 
			ENDIF 
			wait 0.30000001192 seconds 
		ENDIF 
	ELSE 
		DoScreenElementMorph id = grunge_anchor time = 0 pos = PAIR(320.00000000000, 240.00000000000) 
		DoScreenElementMorph id = paused_piece time = 0 pos = PAIR(172.00000000000, 90.00000000000) rot_angle = -9 alpha = 1 
		DoScreenElementMorph scale = 1 time = 0 id = pause_menu 
		DoScreenElementMorph id = pause_menu time = 0 pos = PAIR(320.00000000000, 255.00000000000) 
		IF GotParam show_deck 
			pause_show_deck parent = current_menu_anchor no_slide 
		ENDIF 
		IF ScreenElementExists id = music_track_anchor 
			DoScreenElementMorph id = music_track_anchor pos = PAIR(575.00000000000, 320.00000000000) 
		ENDIF 
		IF ScreenElementExists id = box_icon 
			DoScreenElementMorph id = box_icon time = 0.94999998808 alpha = 0.60000002384 
			IF ScreenElementExists id = box_icon_2 
				DoScreenElementMorph id = box_icon_2 time = 0.75000000000 alpha = 0.25000000000 
			ENDIF 
		ENDIF 
		FireEvent type = focus target = pause_menu 
		SetScreenElementProps id = root_window tags = { menu_state = on } 
	ENDIF 
ENDSCRIPT

SCRIPT build_theme_box_icons parent = current_menu_anchor alpha = 0.75000000000 z_priority = 5 pos = PAIR(530.00000000000, -5.00000000000) pos2 = PAIR(530.00000000000, 398.00000000000) scale = PAIR(1.79999995232, 2.09999990463) 
	FormatText ChecksumName = icon_color "%i_BOX_ICON_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <parent> 
		id = box_icon 
		texture = <icon_texture> 
		pos = <pos> 
		rgba = <icon_color> 
		alpha = <alpha> 
		just = [ left top ] 
		scale = <scale> 
		z_priority = <z_priority> 
	} 
	IF NOT GotParam just_top 
		CreateScreenElement { 
			type = SpriteElement 
			parent = <parent> 
			id = box_icon_2 
			texture = <icon_texture> 
			pos = <pos2> 
			rgba = <icon_color> 
			alpha = <alpha> 
			just = [ left top ] 
			scale = <scale> 
			z_priority = 1 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT build_grunge_piece parent = current_menu_anchor pos = PAIR(320.00000000000, 240.00000000000) z_priority = 2 rgba = [ 128 128 128 100 ] 
	CreateScreenElement { 
		type = ContainerElement 
		parent = <parent> 
		id = grunge_anchor 
		dims = PAIR(640.00000000000, 480.00000000000) 
		pos = <pos> 
	} 
	FormatText ChecksumName = grunge_texture "%i_grunge" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	CreateScreenElement { 
		type = SpriteElement 
		parent = grunge_anchor 
		texture = <grunge_texture> 
		pos = PAIR(0.00000000000, 0.00000000000) 
		rgba = <rgba> 
		just = [ left top ] 
		scale = PAIR(1.10000002384, 0.80000001192) 
		z_priority = <z_priority> 
	} 
ENDSCRIPT

SCRIPT build_top_bar parent = current_menu_anchor pos = PAIR(0.00000000000, 62.00000000000) scale = PAIR(2.29999995232, 1.50000000000) z_priority = 1 alpha = 1 
	IF NOT GotParam static 
		IF LevelIs load_skateshop 
			alpha = 0 
		ENDIF 
	ENDIF 
	IF ScreenElementExists id = top_bar_anchor 
		DestroyScreenElement id = top_bar_anchor 
	ENDIF 
	CreateScreenElement { 
		type = ContainerElement 
		parent = <parent> 
		id = top_bar_anchor 
		alpha = <alpha> 
		pos = <pos> 
		just = <just> 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = top_bar_anchor 
		texture = DE_TOP_BAR 
		rgba = [ 128 128 128 100 ] 
		just = [ left top ] 
		pos = PAIR(0.00000000000, 0.00000000000) 
		scale = <scale> 
		z_priority = <z_priority> 
	} 
	GetStackedScreenElementPos X id = <id> 
	CreateScreenElement { 
		type = SpriteElement 
		parent = top_bar_anchor 
		texture = DE_TOP_BAR_2 
		rgba = [ 128 128 128 100 ] 
		just = [ left top ] 
		pos = ( <pos> + PAIR(1.00000000000, 0.00000000000) ) 
		scale = <scale> 
		z_priority = <z_priority> 
	} 
	GetStackedScreenElementPos X id = <id> 
	CreateScreenElement { 
		type = SpriteElement 
		parent = top_bar_anchor 
		texture = DE_TOP_BAR_3 
		rgba = [ 128 128 128 100 ] 
		just = [ left top ] 
		pos = ( <pos> + PAIR(1.00000000000, 0.00000000000) ) 
		scale = <scale> 
		z_priority = <z_priority> 
	} 
	GetStackedScreenElementPos X id = <id> 
	CreateScreenElement { 
		type = SpriteElement 
		parent = top_bar_anchor 
		texture = DE_TOP_BAR_4 
		rgba = [ 128 128 128 100 ] 
		just = [ left top ] 
		pos = ( <pos> + PAIR(1.00000000000, 0.00000000000) ) 
		scale = <scale> 
		z_priority = <z_priority> 
	} 
ENDSCRIPT

SCRIPT build_theme_sub_title parent = current_menu_anchor title_scale = 1.89999997616 pos = PAIR(55.00000000000, 73.00000000000) z_priority = 10 right_bracket_z = 1 right_bracket_alpha = 1.00000000000 
	FormatText ChecksumName = icon_rgba "%i_SUBMENU_TITLE_ICON_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = bracket_texture "%i_sub_frame" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	IF ScreenElementExists id = submenu_title_anchor 
		DestroyScreenElement id = submenu_title_anchor 
	ENDIF 
	IF NOT GotParam static 
		IF LevelIs load_skateshop 
			pos = PAIR(55.00000000000, 50.00000000000) 
			right_bracket_alpha = 0 
		ENDIF 
	ENDIF 
	CreateScreenElement { 
		type = ContainerElement 
		parent = <parent> 
		id = submenu_title_anchor 
		pos = <pos> 
		just = [ left top ] 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = submenu_title_anchor 
		id = left_bracket 
		texture = <bracket_texture> 
		pos = PAIR(0.00000000000, 0.00000000000) 
		rgba = [ 0 0 0 0 ] 
		scale = PAIR(1.00000000000, 1.00000000000) 
		z_priority = <z_priority> 
	} 
	GetStackedScreenElementPos X id = <id> 
	FormatText ChecksumName = title_color "%i_MENU_TITLE_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	CreateScreenElement { 
		type = TextElement 
		parent = submenu_title_anchor 
		id = title_text 
		pos = ( <pos> + PAIR(-35.00000000000, 15.00000000000) ) 
		just = [ left top ] 
		font = testtitle 
		text = <title> 
		scale = <title_scale> 
		z_priority = ( <z_priority> + 1 ) 
		rgba = <title_color> 
	} 
	IF GotParam max_width 
		truncate_string id = title_text max_width = <max_width> 
	ENDIF 
	GetStackedScreenElementPos X id = <id> 
	CreateScreenElement { 
		type = SpriteElement 
		parent = submenu_title_anchor 
		id = right_bracket 
		pos = ( <pos> + PAIR(-10.00000000000, 20.00000000000) ) 
		texture = <bracket_texture> 
		rgba = [ 128 128 128 128 ] 
		scale = PAIR(1.00000000000, 1.00000000000) 
		alpha = <right_bracket_alpha> 
		z_priority = <right_bracket_z> 
		rot_angle = 180 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = left_bracket 
		id = title_icon 
		texture = <title_icon> 
		rgba = <icon_rgba> 
		just = [ center center ] 
		scale = 1.29999995232 
		alpha = 1 
		pos = PAIR(13.00000000000, 32.00000000000) 
		z_priority = <z_priority> 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = left_bracket 
		texture = <title_icon> 
		rgba = <icon_rgba> 
		just = [ center center ] 
		scale = 1.60000002384 
		alpha = 0.69999998808 
		pos = PAIR(13.00000000000, 32.00000000000) 
		z_priority = ( <z_priority> - 1 ) 
	} 
	KillSpawnedScript name = title_icon_twitch_effect 
	RunScriptOnScreenElement id = title_icon title_icon_twitch_effect 
ENDSCRIPT

SCRIPT build_top_and_bottom_blocks { top_pos = PAIR(0.00000000000, -29.00000000000) 
		bot_pos = PAIR(0.00000000000, 370.00000000000) 
		top_z = 1 
		bot_z = 5 
		parent = current_menu_anchor 
		scale = PAIR(1.20000004768, 2.04999995232) 
		rgba = [ 100 100 100 128 ] 
	} 
	IF NOT GotParam static 
		IF LevelIs load_skateshop 
			scale = PAIR(1.20000004768, 1.45000004768) 
		ENDIF 
	ENDIF 
	SetScreenElementLock off id = <parent> 
	IF NOT GotParam double 
		IF ScreenElementExists id = top_block_anchor 
			DestroyScreenElement id = top_block_anchor 
			DestroyScreenElement id = bottom_block_anchor 
		ENDIF 
		top_block_anchor = top_block_anchor 
		bottom_block_anchor = bottom_block_anchor 
	ELSE 
		top_block_anchor = top_block_anchor2 
		bottom_block_anchor = bottom_block_anchor2 
	ENDIF 
	FormatText ChecksumName = highlight_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = alt_rgba "%i_ALT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	CreateScreenElement { 
		type = ContainerElement 
		parent = <parent> 
		id = <top_block_anchor> 
		pos = <top_pos> 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <top_block_anchor> 
		texture = strip_1 
		rgba = <rgba> 
		just = [ left top ] 
		pos = PAIR(0.00000000000, 0.00000000000) 
		scale = <scale> 
		z_priority = <top_z> 
	} 
	top_first_id = <id> 
	GetStackedScreenElementPos X id = <id> 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <top_block_anchor> 
		texture = strip_2 
		rgba = <rgba> 
		just = [ left top ] 
		pos = <pos> 
		scale = <scale> 
		z_priority = <top_z> 
	} 
	GetStackedScreenElementPos X id = <id> 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <top_block_anchor> 
		texture = strip_3 
		rgba = <rgba> 
		just = [ left top ] 
		pos = <pos> 
		scale = <scale> 
		z_priority = <top_z> 
	} 
	GetStackedScreenElementPos X id = <id> 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <top_block_anchor> 
		texture = strip_4 
		rgba = <alt_rgba> 
		just = [ left top ] 
		pos = <pos> 
		scale = <scale> 
		z_priority = <top_z> 
	} 
	GetStackedScreenElementPos X id = <id> 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <top_block_anchor> 
		texture = strip_5 
		rgba = <alt_rgba> 
		just = [ left top ] 
		pos = <pos> 
		scale = <scale> 
		z_priority = <top_z> 
	} 
	GetStackedScreenElementPos X id = <id> 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <top_block_anchor> 
		texture = strip_6 
		rgba = <alt_rgba> 
		just = [ left top ] 
		pos = <pos> 
		scale = <scale> 
		z_priority = <top_z> 
	} 
	GetStackedScreenElementPos X id = <id> 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <top_block_anchor> 
		texture = strip_7 
		rgba = <alt_rgba> 
		just = [ left top ] 
		pos = <pos> 
		scale = <scale> 
		z_priority = <top_z> 
	} 
	GetStackedScreenElementPos X id = <id> 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <top_block_anchor> 
		texture = strip_8 
		rgba = <alt_rgba> 
		just = [ left top ] 
		pos = <pos> 
		scale = <scale> 
		z_priority = <top_z> 
	} 
	GetStackedScreenElementPos X id = <id> 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <top_block_anchor> 
		texture = strip_9 
		rgba = <alt_rgba> 
		just = [ left top ] 
		pos = <pos> 
		scale = <scale> 
		z_priority = <top_z> 
	} 
	GetStackedScreenElementPos X id = <id> 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <top_block_anchor> 
		texture = strip_10 
		rgba = <alt_rgba> 
		just = [ left top ] 
		pos = <pos> 
		scale = <scale> 
		z_priority = <top_z> 
	} 
	CreateScreenElement { 
		type = ContainerElement 
		parent = <parent> 
		id = <bottom_block_anchor> 
		internal_just = [ center center ] 
		pos = <bot_pos> 
	} 
	scale = PAIR(1.20000004768, 1.60000002384) 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <bottom_block_anchor> 
		texture = strip_10 
		rgba = <alt_rgba> 
		just = [ left top ] 
		pos = PAIR(0.00000000000, 0.00000000000) 
		scale = <scale> 
		z_priority = <bot_z> 
		rot_angle 
	} 
	bot_first_id = <id> 
	GetStackedScreenElementPos X id = <id> 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <bottom_block_anchor> 
		texture = strip_9 
		rgba = <alt_rgba> 
		just = [ left top ] 
		pos = <pos> 
		scale = <scale> 
		z_priority = <bot_z> 
	} 
	GetStackedScreenElementPos X id = <id> 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <bottom_block_anchor> 
		texture = strip_8 
		rgba = <alt_rgba> 
		just = [ left top ] 
		pos = <pos> 
		scale = <scale> 
		z_priority = <bot_z> 
	} 
	GetStackedScreenElementPos X id = <id> 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <bottom_block_anchor> 
		texture = strip_7 
		rgba = <alt_rgba> 
		just = [ left top ] 
		pos = <pos> 
		scale = <scale> 
		z_priority = <bot_z> 
	} 
	GetStackedScreenElementPos X id = <id> 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <bottom_block_anchor> 
		texture = strip_6 
		rgba = <alt_rgba> 
		just = [ left top ] 
		pos = <pos> 
		scale = <scale> 
		z_priority = <bot_z> 
	} 
	GetStackedScreenElementPos X id = <id> 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <bottom_block_anchor> 
		texture = strip_5 
		rgba = <alt_rgba> 
		just = [ left top ] 
		pos = <pos> 
		scale = <scale> 
		z_priority = <bot_z> 
	} 
	GetStackedScreenElementPos X id = <id> 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <bottom_block_anchor> 
		texture = strip_4 
		rgba = <alt_rgba> 
		just = [ left top ] 
		pos = <pos> 
		scale = <scale> 
		z_priority = <bot_z> 
	} 
	GetStackedScreenElementPos X id = <id> 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <bottom_block_anchor> 
		texture = strip_3 
		rgba = <rgba> 
		just = [ left top ] 
		pos = <pos> 
		scale = <scale> 
		z_priority = <bot_z> 
	} 
	GetStackedScreenElementPos X id = <id> 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <bottom_block_anchor> 
		texture = strip_2 
		rgba = <rgba> 
		just = [ left top ] 
		pos = <pos> 
		scale = <scale> 
		z_priority = <bot_z> 
	} 
	GetStackedScreenElementPos X id = <id> 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <bottom_block_anchor> 
		texture = strip_1 
		rgba = <rgba> 
		just = [ left top ] 
		pos = <pos> 
		scale = <scale> 
		z_priority = <bot_z> 
	} 
	IF NOT GotParam no_lines 
		GetStackedScreenElementPos Y id = <top_first_id> offset = PAIR(0.00000000000, -3.00000000000) 
		CreateScreenElement { 
			type = SpriteElement 
			parent = <top_block_anchor> 
			texture = streak_2 
			rgba = <highlight_rgba> 
			just = [ left top ] 
			pos = <pos> 
			scale = PAIR(12.00000000000, 0.85000002384) 
			z_priority = ( <top_z> + 1 ) 
			alpha = 0.60000002384 
		} 
		CreateScreenElement { 
			type = SpriteElement 
			parent = <bottom_block_anchor> 
			texture = streak_2 
			rgba = <highlight_rgba> 
			just = [ left top ] 
			pos = PAIR(0.00000000000, -2.00000000000) 
			scale = PAIR(12.00000000000, 0.85000002384) 
			z_priority = ( <bot_z> + 1 ) 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT pause_menu_gradient texture = bg_gradient_1 scale = PAIR(3.70000004768, 150.00000000000) time = 0.20000000298 alpha = 1.00000000000 id = screenfader pos = PAIR(320.00000000000, 240.00000000000) 
	IF LevelIs load_skateshop 
		RETURN 
	ENDIF 
	IF LevelIs load_cas 
		RETURN 
	ENDIF 
	FormatText ChecksumName = value_name "%i_GRADIENT_VALUE" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	IF GotParam on 
		IF NOT ScreenElementExists id = <id> 
			SetScreenElementLock off id = root_window 
			CreateScreenElement { 
				type = SpriteElement 
				parent = root_window 
				id = <id> 
				texture = <texture> 
				pos = <pos> 
				rgba = <value_name> 
				just = [ center center ] 
				scale = <scale> 
				alpha = 0 
				z_priority = 0 
			} 
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

SCRIPT make_new_themed_sub_menu dims = PAIR(300.00000000000, 300.00000000000) pos = PAIR(215.00000000000, 80.00000000000) menu_id = sub_menu vmenu_id = sub_vmenu right_bracket_alpha = <right_bracket_alpha> right_bracket_z = 1 
	IF LevelIs load_skateshop 
		IF NOT GotParam skateshop_pos 
			pos = PAIR(100.00000000000, 55.00000000000) 
		ELSE 
			pos = <skateshop_pos> 
		ENDIF 
	ENDIF 
	IF ObjectExists id = current_menu_anchor 
		pulse_blur speed = 2 start = 225 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	GoalManager_HidePoints 
	GoalManager_HideGoalPoints 
	SetScreenElementLock id = root_window off 
	CreateScreenElement { 
		type = ContainerElement 
		parent = root_window 
		id = menu_parts_anchor 
		dims = PAIR(640.00000000000, 480.00000000000) 
		pos = PAIR(320.00000000000, 240.00000000000) 
	} 
	IF GotParam Scrolling 
		type = VScrollingMenu 
		scrolling_menu_id = sub_scrolling_menu 
	ENDIF 
	make_new_menu { 
		pos = <pos> 
		parent = menu_parts_anchor 
		internal_just = [ left center ] 
		menu_id = <menu_id> 
		vmenu_id = <vmenu_id> 
		scrolling_menu_id = <scrolling_menu_id> 
		type = <type> 
		dims = <dims> 
		dont_allow_wrap = <dont_allow_wrap> 
		<no_menu_title> 
	} 
	DoScreenElementMorph id = <menu_id> time = 0 pos = PAIR(320.00000000000, 620.00000000000) 
	AssignAlias id = menu_parts_anchor alias = current_menu_anchor 
	IF LevelIs load_skateshop 
		build_top_and_bottom_blocks 
		make_mainmenu_3d_plane 
	ENDIF 
	IF NOT GotParam helper_text 
		create_helper_text { helper_text_elements = [ { text = "\\b7/\\b4 = Select" } 
				{ text = "\\bn = Back" } 
				{ text = "\\bm = Accept" } 
			] 
		} 
	ELSE 
		create_helper_text <helper_text> 
	ENDIF 
	kill_start_key_binding 
	build_theme_sub_title title = <title> title_icon = <title_icon> right_bracket_z = <right_bracket_z> right_bracket_alpha = <right_bracket_alpha> title_scale = <title_scale> 
	IF NOT LevelIs load_skateshop 
		FormatText ChecksumName = paused_icon "%i_paused_icon" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
		build_theme_box_icons icon_texture = <paused_icon> 
		build_grunge_piece 
	ENDIF 
	IF NOT GotParam no_bar 
		build_top_bar pos = PAIR(-400.00000000000, 62.00000000000) 
	ENDIF 
ENDSCRIPT

SCRIPT finish_themed_sub_menu menu = sub_menu end_pos = PAIR(320.00000000000, 240.00000000000) time = 0.20000000298 
	change widest_menu_item_width = 0 
	IF NOT GotParam no_sound 
		PlaySound DE_MenuFlyUp vol = 100 
	ENDIF 
	DoScreenElementMorph id = <menu> time = <time> pos = <end_pos> 
	IF ScreenElementExists id = top_bar_anchor 
		DoScreenElementMorph id = top_bar_anchor time = <time> pos = PAIR(0.00000000000, 62.00000000000) 
	ENDIF 
	FireEvent type = focus target = <menu> 
ENDSCRIPT

SCRIPT make_new_themed_option_menu menu_id = options_menu vmenu_id = options_vmenu right_bracket_alpha = <right_bracket_alpha> 
	pulse_blur 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	IF InSplitScreenGame 
		GoalManager_ShowPoints 
		options_pos = PAIR(120.00000000000, 68.00000000000) 
	ELSE 
		options_pos = PAIR(120.00000000000, 60.00000000000) 
	ENDIF 
	make_new_menu { 
		menu_id = <menu_id> 
		vmenu_id = <vmenu_id> 
		menu_title = "" 
		pos = <options_pos> 
	} 
	build_theme_sub_title title = <title> title_icon = <title_icon> right_bracket_alpha = <right_bracket_alpha> 
	FormatText ChecksumName = paused_icon "%i_paused_icon" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	build_theme_box_icons icon_texture = <paused_icon> 
	build_grunge_piece 
	create_helper_text generic_helper_text 
	kill_start_key_binding 
ENDSCRIPT

SCRIPT make_theme_menu_item { focus_script = theme_item_focus 
		text = "Default text" 
		unfocus_script = theme_item_unfocus 
		pad_choose_script = null_script 
		pad_choose_sound = theme_menu_pad_choose_sound 
		scale = 1.00000000000 
		rgba = [ 88 105 112 118 ] 
		dims = PAIR(300.00000000000, 18.00000000000) 
		just = [ right center ] 
		parent = current_menu 
	} 
	IF GotParam not_focusable 
		<rgba> = [ 60 60 60 75 ] 
		CreateScreenElement { 
			type = ContainerElement 
			parent = <parent> 
			id = <id> 
			dims = <dims> 
			just = [ center center ] 
			not_focusable 
		} 
	ELSE 
		FormatText ChecksumName = text_color "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
		<rgba> = <text_color> 
		CreateScreenElement { 
			type = ContainerElement 
			parent = <parent> 
			id = <id> 
			dims = <dims> 
			just = [ center center ] 
			event_handlers = [ 
				{ focus <focus_script> params = { text = <text> } } 
				{ unfocus <unfocus_script> } 
				{ pad_start <pad_choose_sound> } 
				{ pad_choose <pad_choose_sound> } 
				{ pad_choose <pad_choose_script> params = <pad_choose_params> } 
				{ pad_start <pad_choose_script> params = <pad_choose_params> } 
			] 
		} 
	ENDIF 
	container_id = <id> 
	CreateScreenElement { 
		type = TextElement 
		parent = <id> 
		font = small 
		text = <text> 
		rgba = <rgba> 
		scale = <scale> 
		pos = PAIR(190.00000000000, 10.00000000000) 
		just = <just> 
	} 
	IF NOT GotParam no_highlight_bar 
		highlight_angle = RANDOM_NO_REPEAT(1, 1, 1, 1, 1, 1, 1, 1, 1, 1) RANDOMCASE 2 RANDOMCASE -2 RANDOMCASE 3 RANDOMCASE -3 RANDOMCASE 3.50000000000 RANDOMCASE -3 RANDOMCASE 5 RANDOMCASE -4 RANDOMCASE 2.50000000000 RANDOMCASE -4.50000000000 RANDOMEND 
		CreateScreenElement { 
			type = SpriteElement 
			parent = <container_id> 
			texture = DE_highlight_bar 
			pos = PAIR(120.00000000000, 10.00000000000) 
			rgba = [ 0 0 0 0 ] 
			just = [ center center ] 
			scale = PAIR(6.30000019073, 0.69999998808) 
			z_priority = 1 
			rot_angle = <highlight_angle> 
		} 
	ENDIF 
	IF GotParam mark_first_input 
		SetScreenElementProps { 
			id = <container_id> 
			event_handlers = [ { pad_choose mark_first_input_received } 
				{ pad_start mark_first_input_received } 
			] 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT theme_menu_add_item { parent = current_menu 
		font = small 
		highlight_bar_scale = PAIR(2.09999990463, 0.69999998808) 
		highlight_bar_pos = PAIR(90.00000000000, -7.00000000000) 
		text_just = [ right center ] 
		focus_script = main_theme_focus 
		unfocus_script = main_theme_unfocus 
		text_pos = PAIR(95.00000000000, -5.00000000000) 
		dims = PAIR(200.00000000000, 20.00000000000) 
		pad_choose_script = nullscript 
		text_alpha = 1.00000000000 
		scale = 1.00000000000 
		z_priority = 3 
	} 
	IF NOT GotParam text_rgba 
		FormatText ChecksumName = text_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	ENDIF 
	IF NOT GotParam line_rgba 
		FormatText ChecksumName = line_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	ENDIF 
	IF GotParam first_item 
		focus_params = { first_item text_rgba = <text_rgba> text_alpha = <text_alpha> highlighted_text_rgba = <highlighted_text_rgba> <focus_params> } 
	ELSE 
		IF GotParam last_item 
			focus_params = { last_item text_rgba = <text_rgba> text_alpha = <text_alpha> highlighted_text_rgba = <highlighted_text_rgba> <focus_params> } 
		ELSE 
			focus_params = { text_rgba = <text_rgba> text_alpha = <text_alpha> highlighted_text_rgba = <highlighted_text_rgba> <focus_params> } 
		ENDIF 
	ENDIF 
	IF GotParam not_focusable 
		CreateScreenElement { 
			type = ContainerElement 
			parent = <parent> 
			id = <id> 
			dims = <dims> 
			event_handlers = [ { focus <focus_script> params = <focus_params> } 
				{ unfocus <unfocus_script> params = <focus_params> } 
			] 
			replace_handlers 
			not_focusable 
		} 
	ELSE 
		CreateScreenElement { 
			type = ContainerElement 
			parent = <parent> 
			id = <id> 
			dims = <dims> 
			event_handlers = [ { focus <focus_script> params = <focus_params> } 
				{ unfocus <unfocus_script> params = <focus_params> } 
			] 
			replace_handlers 
		} 
	ENDIF 
	<anchor_id> = <id> 
	IF NOT GotParam no_sound 
		SetScreenElementProps id = <anchor_id> event_handlers = [ { pad_choose generic_menu_pad_choose_sound } 
			{ pad_choose <pad_choose_script> params = <pad_choose_params> } 
			{ pad_start generic_menu_pad_choose_sound } 
			{ pad_start <pad_choose_script> params = <pad_choose_params> } 
		] 
	ELSE 
		SetScreenElementProps id = <anchor_id> event_handlers = [ { pad_choose <pad_choose_script> params = <pad_choose_params> } 
			{ pad_start <pad_choose_script> params = <pad_choose_params> } 
		] 
	ENDIF 
	IF GotParam cat_edit_item 
		SetScreenElementProps { id = <anchor_id> 
			event_handlers = [ 
				{ pad_left <pad_right_script> params = { reverse id = <id> value = <value> <params> } } 
				{ pad_right <pad_right_script> params = { id = <id> value = <value> <params> } } 
				{ pad_choose <pad_choose_script> params = <params> } 
				{ pad_start <pad_choose_script> params = <params> } 
			] 
			replace_handlers 
		} 
	ELSE 
		IF GotParam pad_right_script 
			SetScreenElementProps { id = <anchor_id> 
				event_handlers = [ 
					{ pad_left <pad_left_script> params = { <pad_left_params> } } 
					{ pad_right <pad_right_script> params = { <pad_right_params> } } 
				] 
				replace_handlers 
			} 
		ENDIF 
	ENDIF 
	IF GotParam mark_first_input 
		SetScreenElementProps { 
			id = <anchor_id> 
			event_handlers = [ { pad_choose mark_first_input_received } 
				{ pad_choose generic_menu_pad_choose_sound } 
				{ pad_choose <pad_choose_script> params = <pad_choose_params> } 
				{ pad_start mark_first_input_received } 
				{ pad_start generic_menu_pad_choose_sound } 
				{ pad_start <pad_choose_script> params = <pad_choose_params> } 
			] 
			replace_handlers 
		} 
	ENDIF 
	IF GotParam centered 
		text_just = [ center center ] 
		text_pos = PAIR(85.00000000000, -5.00000000000) 
	ENDIF 
	IF GotParam not_focusable 
		<text_rgba> = [ 60 60 60 75 ] 
		CreateScreenElement { 
			type = TextElement 
			parent = <anchor_id> 
			id = <text_id> 
			font = <font> 
			text = <text> 
			scale = <scale> 
			pos = <text_pos> 
			just = <text_just> 
			rgba = <text_rgba> 
			alpha = <text_alpha> 
			not_focusable 
			z_priority = <z_priority> 
		} 
	ELSE 
		CreateScreenElement { 
			type = TextElement 
			parent = <anchor_id> 
			id = <text_id> 
			font = <font> 
			text = <text> 
			scale = <scale> 
			pos = <text_pos> 
			just = <text_just> 
			rgba = <text_rgba> 
			alpha = <text_alpha> 
			z_priority = <z_priority> 
		} 
	ENDIF 
	IF GotParam max_width 
		truncate_string id = <id> max_width = <max_width> 
	ENDIF 
	highlight_angle = RANDOM_NO_REPEAT(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1) RANDOMCASE 2 RANDOMCASE -2 RANDOMCASE 3 RANDOMCASE -3 RANDOMCASE 3.50000000000 RANDOMCASE -3.50000000000 RANDOMCASE 4 RANDOMCASE -4 RANDOMCASE 4.50000000000 RANDOMCASE -4.50000000000 RANDOMCASE 5 RANDOMCASE -5 RANDOMEND 
	IF GotParam menu 
		FormatText ChecksumName = bar_id "highlight_bar%m_%i" m = <menu> i = middle_piece_id_num 
		FormatText ChecksumName = line_id "text_line%m_%i" m = <menu> i = middle_piece_id_num 
		FormatText ChecksumName = box_id "text_box%m_%i" m = <menu> i = middle_piece_id_num 
	ELSE 
		FormatText ChecksumName = bar_id "highlight_bar_%i" i = middle_piece_id_num 
		FormatText ChecksumName = line_id "text_line_%i" i = middle_piece_id_num 
		FormatText ChecksumName = box_id "text_box_%i" i = middle_piece_id_num 
	ENDIF 
	IF NOT GotParam no_highlight_bar 
		CreateScreenElement { 
			type = SpriteElement 
			parent = <anchor_id> 
			id = <bar_id> 
			texture = DE_highlight_bar 
			pos = <highlight_bar_pos> 
			rgba = [ 0 0 0 0 ] 
			just = [ center center ] 
			scale = <highlight_bar_scale> 
			z_priority = ( <z_priority> -1 ) 
			rot_angle = <highlight_angle> 
		} 
	ELSE 
		CreateScreenElement { 
			type = ContainerElement 
			parent = <anchor_id> 
			pos = PAIR(0.00000000000, 0.00000000000) 
		} 
	ENDIF 
	IF NOT GotParam no_bg 
		build_theme_menu_middle { parent = <anchor_id> 
			last_menu_item = <last_menu_item> 
			centered = <centered> 
			static_width = <static_width> 
			middle_scale = <middle_scale> 
			menu = <menu> 
			dark_menu = <dark_menu> 
			height = <item_bg_height> 
		} 
	ELSE 
		IF GotParam first_item 
			change widest_menu_item_width = 0 
		ENDIF 
		CreateScreenElement { 
			type = ContainerElement 
			parent = <anchor_id> 
			pos = PAIR(0.00000000000, 0.00000000000) 
		} 
		change middle_piece_id_num = ( middle_piece_id_num + 1 ) 
		GetScreenElementDims id = <id> 
	ENDIF 
	IF GotParam extra_text 
		CreateScreenElement { 
			type = TextElement 
			parent = <anchor_id> 
			font = <font> 
			text = <extra_text> 
			scale = <scale> 
			pos = ( <text_pos> + PAIR(10.00000000000, 0.00000000000) ) 
			just = [ left center ] 
			rgba = <text_rgba> 
			z_priority = <z_priority> 
		} 
		IF NOT GotParam ignore_width 
			GetScreenElementDims id = { <anchor_id> child = 3 } 
			IF ( <width> > widest_menu_item_width ) 
				change widest_menu_item_width = ( <width> + 15 ) 
			ENDIF 
		ENDIF 
	ELSE 
		CreateScreenElement { 
			type = TextElement 
			parent = <anchor_id> 
			font = small 
			text = "" 
			alpha = 0 
		} 
	ENDIF 
	IF GotParam cross_it_out 
		CreateScreenElement { 
			type = SpriteElement 
			parent = <anchor_id> 
			id = <line_id> 
			texture = streak_2 
			pos = <highlight_bar_pos> 
			rgba = <line_rgba> 
			just = [ center center ] 
			scale = <highlight_bar_scale> 
			z_priority = ( <z_priority> + 1 ) 
			rot_angle = <highlight_angle> 
		} 
	ENDIF 
	IF GotParam box_it_up 
		CreateScreenElement { 
			type = SpriteElement 
			parent = <anchor_id> 
			id = <box_id> 
			texture = black 
			pos = <highlight_bar_pos> 
			rgba = [ 0 0 0 60 ] 
			just = [ center center ] 
			scale = <highlight_bar_scale> 
			z_priority = <z_priority> 
		} 
	ENDIF 
	IF NOT GotParam ignore_width 
		GetScreenElementDims id = { <anchor_id> child = 0 } 
		IF ( <width> > widest_menu_item_width ) 
			change widest_menu_item_width = <width> 
		ENDIF 
	ENDIF 
	IF ( ( GotParam last_menu_item ) | ( GotParam last_item ) ) 
		IF NOT GotParam static_width 
			IF GotParam centered 
				RunScriptOnScreenElement id = <id> set_all_menu_items_width params = { centered menu = <menu> height = <item_bg_height> } 
			ELSE 
				RunScriptOnScreenElement id = <id> set_all_menu_items_width params = { menu = <menu> height = <item_bg_height> } 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT theme_menu_add_centered_item 
	theme_menu_add_item <...> centered = centered 
ENDSCRIPT

SCRIPT theme_menu_add_checkbox_item 
	IF NOT GotParam id 
		printf "checkbox items must have an id" 
		RETURN 
	ENDIF 
	IF NOT GotParam value 
		printf "checkbox items must have a value" 
		RETURN 
	ENDIF 
	anchor_id = <id> 
	theme_menu_add_item focus_script = theme_checkbox_focus unfocus_script = theme_checkbox_unfocus <...> 
	FormatText ChecksumName = check_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	IF ( <value> = 0 ) 
		alpha = 0 
	ELSE 
		alpha = 1 
	ENDIF 
	GetStackedScreenElementPos X id = { <id> child = 0 } offset = PAIR(20.00000000000, 5.00000000000) 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <anchor_id> 
		texture = checkmark 
		pos = <pos> 
		alpha = <alpha> 
		just = [ left center ] 
		rgba = <check_rgba> 
		z_priority = 5 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <anchor_id> 
		texture = checkbox 
		pos = ( <pos> + PAIR(0.00000000000, 5.00000000000) ) 
		just = [ left center ] 
		scale = 0.50000000000 
		rgba = <check_rgba> 
		z_priority = 5 
	} 
ENDSCRIPT

SCRIPT theme_set_checkbox 
	IF NOT GotParam value 
		printf "theme_set_checkbox must have value" 
		RETURN 
	ENDIF 
	GetTags 
	IF ( <value> = 1 ) 
		DoScreenElementMorph id = { <id> child = 4 } alpha = 1 
	ELSE 
		DoScreenElementMorph id = { <id> child = 4 } alpha = 0 
	ENDIF 
ENDSCRIPT

SCRIPT theme_menu_add_number_item min = 0 max = 10 step = 1 
	IF NOT GotParam id 
		printf "number items must have an id" 
		RETURN 
	ENDIF 
	IF NOT GotParam value 
		printf "number items must have a value" 
		RETURN 
	ENDIF 
	anchor_id = <id> 
	IF GotParam trailingtext 
		FormatText textname = value_text "%v%t" v = <value> decimalplaces = <decimalplaces> t = <trailingtext> 
	ELSE 
		IF GotParam percent 
			FormatText textname = value_text "%v\\%" v = <value> decimalplaces = <decimalplaces> 
		ELSE 
			FormatText textname = value_text "%v" v = <value> decimalplaces = <decimalplaces> 
		ENDIF 
	ENDIF 
	theme_menu_add_item <...> extra_text = <value_text> focus_script = theme_number_item_focus unfocus_script = theme_number_item_unfocus 
	IF NOT GotParam cat_edit_item 
		SetScreenElementProps { id = <anchor_id> 
			event_handlers = [ { pad_left theme_menu_toggle_number_item params = { reverse 
						callback = <pad_left_script> 
						pad_left_script = <pad_left_script> 
						pad_right_script = <pad_right_script> 
						value = <value> 
						max = <max> 
						min = <min> 
						step = <step> 
						avoid = <avoid> 
						<pad_left_params> 
					} 
				} 
				{ pad_right theme_menu_toggle_number_item params = { callback = <pad_right_script> 
						pad_left_script = <pad_left_script> 
						pad_right_script = <pad_right_script> 
						value = <value> 
						max = <max> 
						min = <min> 
						step = <step> 
						avoid = <avoid> 
						<pad_right_params> 
					} 
				} 
			] 
			replace_handlers 
		} 
	ENDIF 
	FormatText ChecksumName = arrow_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	IF GotParam far_left 
		GetScreenElementPosition id = { <anchor_id> child = 0 } 
	ELSE 
		GetScreenElementPosition id = { <anchor_id> child = 3 } 
	ENDIF 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <anchor_id> 
		texture = left_arrow 
		pos = ( <ScreenElementPos> + PAIR(0.00000000000, 2.00000000000) ) 
		alpha = 0 
		just = [ right top ] 
		rgba = <arrow_rgba> 
		z_priority = 5 
		scale = 0.64999997616 
	} 
	IF GotParam right_arrow_pos 
		pos = <right_arrow_pos> 
	ELSE 
		GetStackedScreenElementPos X id = { <anchor_id> child = 3 } offset = PAIR(3.00000000000, 2.00000000000) 
	ENDIF 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <anchor_id> 
		texture = right_arrow 
		pos = <pos> 
		alpha = 0 
		just = [ left top ] 
		rgba = <arrow_rgba> 
		z_priority = 5 
		scale = 0.64999997616 
	} 
ENDSCRIPT

SCRIPT theme_menu_toggle_number_item 
	GetTags 
	IF GotParam NoStep 
	ELSE 
		BEGIN 
			IF GotParam reverse 
				IF ( ( ( <value> - <step> ) > <min> ) | ( ( <value> - <step> ) = <min> ) ) 
					value = ( <value> - <step> ) 
				ELSE 
					RETURN 
				ENDIF 
			ELSE 
				IF ( <max> > ( ( <value> + <step> ) ) | ( ( <value> + <step> ) = <max> ) ) 
					value = ( <value> + <step> ) 
				ELSE 
					RETURN 
				ENDIF 
			ENDIF 
			IF GotParam avoid 
				IF ( <value> = <avoid> ) 
				ELSE 
					BREAK 
				ENDIF 
			ELSE 
				BREAK 
			ENDIF 
		REPEAT 2 
	ENDIF 
	FormatText textname = value_text "%v" v = <value> 
	SetScreenElementProps { id = { <id> child = 3 } text = <value_text> } 
	theme_menu_update_number_item_right_arrow 
	SetScreenElementProps { id = <id> 
		event_handlers = [ { pad_left theme_menu_toggle_number_item params = { reverse 
					callback = <pad_left_script> 
					pad_left_script = <pad_left_script> 
					pad_right_script = <pad_right_script> 
					value = <value> 
					max = <max> 
					min = <min> 
					step = <step> 
					avoid = <avoid> 
					<pad_left_params> 
				} 
			} 
			{ pad_right theme_menu_toggle_number_item params = { callback = <pad_right_script> 
					pad_left_script = <pad_left_script> 
					pad_right_script = <pad_right_script> 
					value = <value> 
					max = <max> 
					min = <min> 
					step = <step> 
					avoid = <avoid> 
					<pad_right_params> 
				} 
			} 
		] 
		replace_handlers 
	} 
	IF GotParam callback 
		<callback> <...> 
	ENDIF 
ENDSCRIPT

SCRIPT theme_menu_update_number_item_right_arrow 
	GetTags 
	GetStackedScreenElementPos X id = { <id> child = 3 } offset = PAIR(3.00000000000, 2.00000000000) 
	SetScreenElementProps { id = { <id> child = 5 } pos = <pos> } 
ENDSCRIPT

SCRIPT theme_menu_add_flag_item 
	IF NOT GotParam flag 
		printf "theme_menu_add_flag_item requires a flag param" 
		RETURN 
	ENDIF 
	IF NOT GotParam flag 
		printf "theme_menu_add_flag_item requires an id param" 
		RETURN 
	ENDIF 
	IF GetGlobalFlag flag = <flag> 
		IF GotParam reverse 
			extra_text = "Off" 
			reverse = reverse 
		ELSE 
			extra_text = "On" 
		ENDIF 
	ELSE 
		IF GotParam reverse 
			extra_text = "On" 
			reverse = reverse 
		ELSE 
			extra_text = "Off" 
		ENDIF 
	ENDIF 
	theme_menu_add_item <...> pad_choose_script = theme_toggle_flag pad_choose_params = { flag = <flag> id = <id> reverse = <reverse> } 
ENDSCRIPT

SCRIPT theme_toggle_flag 
	IF GetGlobalFlag flag = <flag> 
		IF GotParam reverse 
			SetScreenElementProps id = { <id> child = 3 } text = "On" 
		ELSE 
			SetScreenElementProps id = { <id> child = 3 } text = "Off" 
		ENDIF 
		UnSetGlobalFlag flag = <flag> 
	ELSE 
		IF GotParam reverse 
			SetScreenElementProps id = { <id> child = 3 } text = "Off" 
		ELSE 
			SetScreenElementProps id = { <id> child = 3 } text = "On" 
		ENDIF 
		SetGlobalFlag flag = <flag> 
	ENDIF 
ENDSCRIPT

widest_menu_item_width = 0 
middle_piece_id_num = 0 
SCRIPT build_theme_menu_top parent = current_menu_anchor pos = PAIR(90.00000000000, -29.00000000000) 
	CreateScreenElement { 
		type = ContainerElement 
		parent = <parent> 
		id = <top_id> 
		pos = <pos> 
	} 
	anchor_id = <id> 
	IF LevelIs load_skateshop 
		m_texture = MM_T_M 
		l_texture = MM_T_L 
		r_texture = MM_T_R 
	ELSE 
		IF GotParam dark_menu 
			m_texture = spec_T_M 
			l_texture = spec_T_L 
			r_texture = spec_T_R 
		ELSE 
			m_texture = DE_T_M 
			l_texture = DE_T_L 
			r_texture = DE_T_R 
		ENDIF 
	ENDIF 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <anchor_id> 
		id = <mid_id> 
		texture = <m_texture> 
		pos = PAIR(0.00000000000, 0.00000000000) 
		just = [ center top ] 
		rgba = <bg_piece_rgba> 
		scale = <middle_scale> 
		z_priority = 1 
	} 
	GetScreenElementDims id = <id> 
	right_pos = ( PAIR(0.50000000000, 0.00000000000) * <width> ) 
	left_pos = ( PAIR(-0.50000000000, 0.00000000000) * <width> ) 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <anchor_id> 
		id = <left_id> 
		texture = <l_texture> 
		pos = <left_pos> 
		just = [ right top ] 
		rgba = <bg_piece_rgba> 
		scale = PAIR(1.00000000000, 1.00000000000) 
		z_priority = 1 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <anchor_id> 
		id = <right_id> 
		texture = <r_texture> 
		pos = <right_pos> 
		just = [ left top ] 
		rgba = <bg_piece_rgba> 
		scale = PAIR(1.00000000000, 1.00000000000) 
		z_priority = 1 
	} 
	change widest_menu_item_width = 0 
ENDSCRIPT

SCRIPT build_theme_menu_middle pos = PAIR(90.00000000000, -20.00000000000) middle_scale = PAIR(2.50000000000, 1.00000000000) height = 1 
	FormatText ChecksumName = bg_piece_rgba "%i_BG_PARTS_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	IF NOT GotParam menu 
		FormatText ChecksumName = mid_id "middle_piece_%i" i = middle_piece_id_num 
		FormatText ChecksumName = left_id "left_piece_%i" i = middle_piece_id_num 
		FormatText ChecksumName = right_id "right_piece_%i" i = middle_piece_id_num 
		top_id = box_top_anchor 
	ELSE 
		FormatText ChecksumName = mid_id "middle_piece%m_%i" i = middle_piece_id_num m = <menu> 
		FormatText ChecksumName = left_id "left_piece%m_%i" i = middle_piece_id_num m = <menu> 
		FormatText ChecksumName = right_id "right_piece%m_%i" i = middle_piece_id_num m = <menu> 
		FormatText ChecksumName = top_id "box_top_anchor%i" i = <menu> 
	ENDIF 
	change middle_piece_id_num = ( middle_piece_id_num + 1 ) 
	IF NOT ScreenElementExists id = <top_id> 
		build_theme_menu_top { parent = <parent> 
			top_id = <top_id> 
			middle_scale = <middle_scale> 
			bg_piece_rgba = <bg_piece_rgba> 
			mid_id = <mid_id> left_id = <left_id> 
			right_id = <right_id> 
			menu = <menu> 
			dark_menu = <dark_menu> 
		} 
		RETURN 
	ENDIF 
	IF GotParam last_menu_item 
		build_theme_menu_bottom { parent = <parent> 
			pos = <pos> 
			middle_scale = <middle_scale> 
			bg_piece_rgba = <bg_piece_rgba> 
			mid_id = <mid_id> 
			left_id = <left_id> 
			right_id = <right_id> 
			static_width = <static_width> 
			centered = <centered> 
			menu = <menu> 
			dark_menu = <dark_menu> 
		} 
		RETURN 
	ENDIF 
	CreateScreenElement { 
		type = ContainerElement 
		parent = <parent> 
		pos = <pos> 
	} 
	anchor_id = <id> 
	modded_middle_scale = ( ( <middle_scale> - PAIR(0.00000000000, 1.00000000000) ) + ( PAIR(0.00000000000, 1.00000000000) * <height> ) ) 
	left_right_scale = ( PAIR(1.00000000000, 0.00000000000) + PAIR(0.00000000000, 1.00000000000) * <height> ) 
	IF LevelIs load_skateshop 
		m_texture = MM_M_M 
		l_texture = MM_M_L 
		r_texture = MM_M_R 
	ELSE 
		IF GotParam dark_menu 
			m_texture = spec_M_M 
			l_texture = spec_M_L 
			r_texture = spec_M_R 
		ELSE 
			m_texture = DE_M_M 
			l_texture = DE_M_L 
			r_texture = DE_M_R 
		ENDIF 
	ENDIF 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <anchor_id> 
		id = <mid_id> 
		texture = <m_texture> 
		pos = PAIR(0.00000000000, 0.00000000000) 
		just = [ center top ] 
		rgba = <bg_piece_rgba> 
		scale = <modded_middle_scale> 
		z_priority = 1 
	} 
	GetScreenElementDims id = <id> 
	right_pos = ( PAIR(0.50000000000, 0.00000000000) * <width> ) 
	left_pos = ( PAIR(-0.50000000000, 0.00000000000) * <width> ) 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <anchor_id> 
		id = <left_id> 
		texture = <l_texture> 
		pos = <left_pos> 
		just = [ right top ] 
		rgba = <bg_piece_rgba> 
		scale = <left_right_scale> 
		z_priority = 1 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <anchor_id> 
		id = <right_id> 
		texture = <r_texture> 
		pos = <right_pos> 
		just = [ left top ] 
		rgba = <bg_piece_rgba> 
		scale = <left_right_scale> 
		z_priority = 1 
	} 
ENDSCRIPT

SCRIPT build_theme_menu_bottom pos = PAIR(0.00000000000, 23.00000000000) 
	IF GotParam menu 
		FormatText textname = con_id "box_bottom_anchor%i" i = <menu> 
	ELSE 
		con_id = box_bottom_anchor 
	ENDIF 
	CreateScreenElement { 
		type = ContainerElement 
		parent = <parent> 
		id = <con_id> 
		pos = <pos> 
	} 
	anchor_id = <id> 
	IF LevelIs load_skateshop 
		m_texture = MM_B_M 
		l_texture = MM_B_L 
		r_texture = MM_B_R 
	ELSE 
		IF GotParam dark_menu 
			m_texture = spec_B_M 
			l_texture = spec_B_L 
			r_texture = spec_B_R 
		ELSE 
			m_texture = DE_B_M 
			l_texture = DE_B_L 
			r_texture = DE_B_R 
		ENDIF 
	ENDIF 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <anchor_id> 
		id = <mid_id> 
		texture = <m_texture> 
		pos = PAIR(0.00000000000, 0.00000000000) 
		just = [ center top ] 
		rgba = <bg_piece_rgba> 
		scale = <middle_scale> 
		z_priority = 1 
	} 
	GetScreenElementDims id = <id> 
	right_pos = ( PAIR(0.50000000000, 0.00000000000) * <width> ) 
	left_pos = ( PAIR(-0.50000000000, 0.00000000000) * <width> ) 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <anchor_id> 
		id = <left_id> 
		texture = <l_texture> 
		pos = <left_pos> 
		just = [ right top ] 
		rgba = <bg_piece_rgba> 
		scale = PAIR(1.00000000000, 1.00000000000) 
		z_priority = 1 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <anchor_id> 
		id = <right_id> 
		texture = <r_texture> 
		pos = <right_pos> 
		just = [ left top ] 
		rgba = <bg_piece_rgba> 
		scale = PAIR(1.00000000000, 1.00000000000) 
		z_priority = 1 
	} 
	change middle_piece_id_num = 0 
ENDSCRIPT

SCRIPT set_all_menu_items_width 
	change middle_piece_id_num = 0 
	IF NOT GotParam centered 
		new_scale = ( widest_menu_item_width * PAIR(0.02500000037, 0.00000000000) + PAIR(0.00000000000, 1.00000000000) ) 
		bar_scale = ( widest_menu_item_width * PAIR(0.01200000010, 0.00000000000) + PAIR(1.00000000000, 0.69999998808) ) 
		line_scale = ( widest_menu_item_width * PAIR(0.03200000152, 0.00000000000) + PAIR(1.00000000000, 0.30000001192) ) 
		box_scale = ( widest_menu_item_width * PAIR(0.63999998569, 0.00000000000) + PAIR(1.00000000000, 6.00000000000) ) 
	ELSE 
		new_scale = ( widest_menu_item_width * PAIR(0.01250000019, 0.00000000000) + PAIR(0.00000000000, 1.00000000000) ) 
		bar_scale = ( widest_menu_item_width * PAIR(0.00600000005, 0.00000000000) + PAIR(1.00000000000, 0.69999998808) ) 
		line_scale = ( widest_menu_item_width * PAIR(0.01600000076, 0.00000000000) + PAIR(1.00000000000, 0.30000001192) ) 
		box_scale = ( ( ( <bar_scale> * 32 ) . PAIR(1.00000000000, 0.00000000000) ) * PAIR(1.00000000000, 0.00000000000) + PAIR(0.00000000000, 6.00000000000) ) 
	ENDIF 
	index = 0 
	BEGIN 
		IF NOT GotParam menu 
			FormatText ChecksumName = mid_id "middle_piece_%i" i = <index> 
			FormatText ChecksumName = left_id "left_piece_%i" i = <index> 
			FormatText ChecksumName = right_id "right_piece_%i" i = <index> 
			FormatText ChecksumName = bar_id "highlight_bar_%i" i = <index> 
			FormatText ChecksumName = line_id "text_line_%i" i = <index> 
			FormatText ChecksumName = box_id "text_box_%i" i = <index> 
		ELSE 
			FormatText ChecksumName = mid_id "middle_piece%m_%i" m = <menu> i = <index> 
			FormatText ChecksumName = left_id "left_piece%m_%i" m = <menu> i = <index> 
			FormatText ChecksumName = right_id "right_piece%m_%i" m = <menu> i = <index> 
			FormatText ChecksumName = bar_id "highlight_bar%m_%i" m = <menu> i = <index> 
			FormatText ChecksumName = line_id "text_line%m_%i" m = <menu> i = <index> 
			FormatText ChecksumName = box_id "text_box%m_%i" m = <menu> i = <index> 
		ENDIF 
		IF ScreenElementExists id = <mid_id> 
			DoScreenElementMorph id = <mid_id> scale = <new_scale> 
			GetScreenElementDims id = <mid_id> 
			right_pos = ( PAIR(0.50000000000, 0.00000000000) * <width> ) 
			left_pos = ( PAIR(-0.50000000000, 0.00000000000) * <width> ) 
			DoScreenElementMorph id = <left_id> pos = <left_pos> 
			DoScreenElementMorph id = <right_id> pos = <right_pos> 
		ENDIF 
		IF ScreenElementExists id = <bar_id> 
			GetScreenElementProps id = <bar_id> 
			IF NOT ( widest_menu_item_width = 0 ) 
				new_angle = ( ( <rot_angle> * 5.00000000000 ) / ( widest_menu_item_width * 0.00100000005 ) ) 
				DoScreenElementMorph id = <bar_id> scale = <bar_scale> rot_angle = <new_angle> 
				IF ScreenElementExists id = <line_id> 
					DoScreenElementMorph id = <line_id> scale = <line_scale> rot_angle = <new_angle> 
				ENDIF 
				IF ScreenElementExists id = <box_id> 
					DoScreenElementMorph id = <box_id> scale = <box_scale> 
				ENDIF 
			ENDIF 
		ELSE 
		ENDIF 
		index = ( <index> + 1 ) 
	REPEAT 100 
ENDSCRIPT

no_focus_sound = 1 
SCRIPT main_theme_focus 
	GetTags 
	IF NOT GotParam highlighted_text_rgba 
		FormatText ChecksumName = highlighted_text_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	ENDIF 
	FormatText ChecksumName = bar_rgba "%i_HIGHLIGHT_BAR_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	DoScreenElementMorph { 
		id = { <id> child = 0 } 
		rgba = <highlighted_text_rgba> 
		scale = 1.10000002384 
		relative_scale 
	} 
	IF ScreenElementExists id = { <id> child = 3 } 
		DoScreenElementMorph { 
			id = { <id> child = 3 } 
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

SCRIPT main_theme_unfocus text_alpha = 1.00000000000 
	GetTags 
	IF NOT GotParam text_rgba 
		FormatText ChecksumName = text_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	ENDIF 
	KillSpawnedScript name = text_twitch_effect 
	DoScreenElementMorph { 
		id = { <id> child = 0 } 
		rgba = <text_rgba> 
		alpha = <text_alpha> 
		scale = 1 
	} 
	IF ScreenElementExists id = { <id> child = 3 } 
		DoScreenElementMorph { 
			id = { <id> child = 3 } 
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

SCRIPT main_theme_focus_noscale 
	GetTags 
	IF NOT GotParam highlighted_text_rgba 
		FormatText ChecksumName = highlighted_text_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	ENDIF 
	FormatText ChecksumName = bar_rgba "%i_HIGHLIGHT_BAR_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	DoScreenElementMorph { 
		id = { <id> child = 0 } 
		rgba = <highlighted_text_rgba> 
		relative_scale 
	} 
	IF ScreenElementExists id = { <id> child = 3 } 
		DoScreenElementMorph { 
			id = { <id> child = 3 } 
			rgba = <highlighted_text_rgba> 
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
ENDSCRIPT

SCRIPT main_theme_unfocus_noscale 
	GetTags 
	IF NOT GotParam text_rgba 
		FormatText ChecksumName = text_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	ENDIF 
	KillSpawnedScript name = text_twitch_effect 
	DoScreenElementMorph { 
		id = { <id> child = 0 } 
		rgba = <text_rgba> 
		alpha = <text_alpha> 
	} 
	IF ScreenElementExists id = { <id> child = 3 } 
		DoScreenElementMorph { 
			id = { <id> child = 3 } 
			rgba = <text_rgba> 
			alpha = <text_alpha> 
		} 
	ENDIF 
	SetScreenElementProps { 
		id = { <id> child = 1 } 
		rgba = [ 128 128 128 0 ] 
	} 
ENDSCRIPT

SCRIPT theme_checkbox_focus 
	main_theme_focus <...> 
	GetTags 
	FormatText ChecksumName = text_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	SetScreenElementProps { 
		id = { <id> child = 4 } 
		rgba = <text_rgba> 
		alpha = <text_alpha> 
		relative_scale 
	} 
ENDSCRIPT

SCRIPT theme_checkbox_unfocus 
	main_theme_unfocus <...> 
	GetTags 
	FormatText ChecksumName = text_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	SetScreenElementProps { 
		id = { <id> child = 4 } 
		rgba = <text_rgba> 
		alpha = <text_alpha> 
		scale = 1 
		relative_scale 
	} 
ENDSCRIPT

SCRIPT theme_number_item_focus 
	main_theme_focus <...> 
	GetTags 
	DoScreenElementMorph { 
		id = { <id> child = 4 } 
		alpha = 1 
	} 
	DoScreenElementMorph { 
		id = { <id> child = 5 } 
		alpha = 1 
	} 
ENDSCRIPT

SCRIPT theme_number_item_unfocus 
	main_theme_unfocus <...> 
	GetTags 
	DoScreenElementMorph { 
		id = { <id> child = 4 } 
		alpha = 0 
	} 
	DoScreenElementMorph { 
		id = { <id> child = 5 } 
		alpha = 0 
	} 
ENDSCRIPT

SCRIPT theme_item_focus 
	GetTags 
	FormatText ChecksumName = text_color "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = hbar_color "%i_HIGHLIGHT_BAR_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	SetScreenElementProps id = { <id> child = 0 } rgba = <text_color> 
	DoScreenElementMorph id = { <id> child = 0 } time = 0.05000000075 scale = 1.10000002384 
	IF ScreenElementExists id = { <id> child = 1 } 
		SetScreenElementProps { 
			id = { <id> child = 1 } 
			rgba = <hbar_color> 
		} 
	ENDIF 
	RunScriptOnScreenElement id = <id> text_twitch_effect params = { text_scale = <text_scale> } 
ENDSCRIPT

SCRIPT sprite_focus 
	theme_item_focus <...> 
	GetTags 
	FormatText ChecksumName = icon_color "%i_ICON_ON_VALUE" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	IF ( no_focus_sound = 1 ) 
		change no_focus_sound = 0 
	ELSE 
		SpawnScript play_icon_spin_sound 
	ENDIF 
	wait 3 gameframes 
	RunScriptOnScreenElement id = { <id> child = 2 } scale_sprite_up 
	RunScriptOnScreenElement id = <id> do_blur_effect 
	SetScreenElementProps { 
		id = { <id> child = 2 } 
		rgba = <icon_color> 
	} 
	RunScriptOnScreenElement id = <id> icon_twitch_effect 
ENDSCRIPT

SCRIPT sprite_desc_focus 
	theme_item_focus <...> 
	GetTags 
	FormatText ChecksumName = icon_color "%i_ICON_ON_VALUE" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	IF ( no_focus_sound = 1 ) 
		change no_focus_sound = 0 
	ELSE 
		SpawnScript play_icon_spin_sound 
	ENDIF 
	wait 3 gameframes 
	RunScriptOnScreenElement id = { <id> child = 2 } scale_sprite_up 
	RunScriptOnScreenElement id = <id> do_blur_effect 
	SetScreenElementProps { 
		id = { <id> child = 2 } 
		rgba = <icon_color> 
	} 
	RunScriptOnScreenElement id = <id> icon_twitch_effect 
ENDSCRIPT

SCRIPT play_icon_spin_sound 
	wait 12 gameframes 
	PlaySound DE_IconTurnZoom vol = 60 
ENDSCRIPT

SCRIPT theme_item_unfocus 
	GetTags 
	generic_menu_pad_up_down_sound 
	KillSpawnedScript name = text_twitch_effect 
	FormatText ChecksumName = text_color "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	SetScreenElementProps id = { <id> child = 0 } rgba = <text_color> 
	SetScreenElementProps id = { <id> child = 0 } no_blur_effect 
	DoScreenElementMorph id = { <id> child = 0 } time = 0.05000000075 restore_alpha scale = 1 
	IF ScreenElementExists id = { <id> child = 1 } 
		DoScreenElementMorph id = { <id> child = 1 } rgba = [ 0 0 0 0 ] 
	ENDIF 
ENDSCRIPT

SCRIPT sprite_unfocus 
	KillSpawnedScript name = play_icon_spin_sound 
	GetTags 
	theme_item_unfocus <...> 
	KillSpawnedScript name = icon_twitch_effect 
	RunScriptOnScreenElement id = { <id> child = 2 } scale_sprite_down 
	SetScreenElementProps { 
		id = { <id> child = 2 } 
		rgba = [ 0 0 0 0 ] 
	} 
	wait 4 gameframes 
	RunScriptOnScreenElement id = { <id> child = 2 } scale_sprite_down 
	SetScreenElementProps { 
		id = { <id> child = 2 } 
		rgba = [ 0 0 0 0 ] 
	} 
ENDSCRIPT

SCRIPT sprite_desc_unfocus 
	KillSpawnedScript name = play_icon_spin_sound 
	GetTags 
	theme_item_unfocus <...> 
	KillSpawnedScript name = icon_twitch_effect 
	RunScriptOnScreenElement id = { <id> child = 2 } scale_sprite_down 
	SetScreenElementProps { 
		id = { <id> child = 2 } 
		rgba = [ 0 0 0 0 ] 
	} 
	wait 4 gameframes 
	RunScriptOnScreenElement id = { <id> child = 2 } scale_sprite_down 
	SetScreenElementProps { 
		id = { <id> child = 2 } 
		rgba = [ 0 0 0 0 ] 
	} 
ENDSCRIPT

SCRIPT icon_twitch_effect 
	GetTags 
	FormatText ChecksumName = twitch_color "%i_ICON_TWITCH_VALUE" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = icon_color "%i_ICON_ON_VALUE" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	BEGIN 
		SetScreenElementProps id = { <id> child = 2 } rot_angle = 10 rgba = <twitch_color> 
		wait 1 gameframe 
		SetScreenElementProps id = { <id> child = 2 } rot_angle = 0 rgba = <icon_color> 
		wait_time = RANDOM(1, 1, 1) RANDOMCASE 0.25000000000 RANDOMCASE 0.50000000000 RANDOMCASE 2.25000000000 RANDOMEND 
		wait <wait_time> seconds 
	REPEAT 
ENDSCRIPT

SCRIPT text_twitch_effect 
	GetTags 
	FormatText ChecksumName = text_color "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = twitch_color "%i_TEXT_TWITCH_VALUE" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	BEGIN 
		GetScreenElementDims id = { <id> child = 0 } 
		ScaleH = ( ( <width> + 5.00000000000 ) / ( <width> ) ) 
		DoScreenElementMorph id = { <id> child = 0 } time = 0.02999999933 scale = <ScaleH> alpha = 1 
		IF NOT GotParam no_extra 
			IF ScreenElementExists id = { <id> child = 3 } 
				GetScreenElementDims id = { <id> child = 3 } 
				IF NOT ( <width> = 0 ) 
					ScaleH = ( ( <width> + 5.00000000000 ) / ( <width> ) ) 
					DoScreenElementMorph id = { <id> child = 3 } time = 0.02999999933 scale = <ScaleH> alpha = 1 
				ENDIF 
			ENDIF 
		ENDIF 
		wait 2 gameframe 
		DoScreenElementMorph id = { <id> child = 0 } time = 0.00999999978 scale = 1 alpha = 0.89999997616 
		IF NOT GotParam no_extra 
			IF ScreenElementExists id = { <id> child = 3 } 
				DoScreenElementMorph id = { <id> child = 3 } time = 0.00999999978 scale = 1 alpha = 0.89999997616 
			ENDIF 
		ENDIF 
		wait 0.23000000417 seconds 
	REPEAT 
ENDSCRIPT

SCRIPT text_twitch_effect2 scale = 1.07500004768 scale2 = 1.00000000000 
	GetTags 
	FormatText ChecksumName = text_color "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = twitch_color "%i_TEXT_TWITCH_VALUE" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	BEGIN 
		DoScreenElementMorph id = <id> time = 0.02999999933 scale = <scale> relative_scale 
		wait 2 frames 
		DoScreenElementMorph id = <id> time = 0.00999999978 scale = <scale2> relative_scale 
		wait 0.23000000417 seconds 
	REPEAT 
ENDSCRIPT

SCRIPT text_twitch_effect3 scale = 1.04999995232 scale2 = 1.07500004768 
	text_twitch_effect2 <...> 
ENDSCRIPT

SCRIPT title_icon_twitch_effect 
	FormatText ChecksumName = twitch_color "%i_ICON_TWITCH_VALUE" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = icon_color "%i_ICON_ON_VALUE" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	BEGIN 
		IF ScreenElementExists id = title_icon 
			SetScreenElementProps id = title_icon rot_angle = 10 rgba = <twitch_color> 
			wait 1 gameframe 
			IF ScreenElementExists id = title_icon 
				SetScreenElementProps id = title_icon rot_angle = 0 rgba = <icon_color> 
			ELSE 
				RETURN 
			ENDIF 
			wait_time = RANDOM(1, 1, 1) RANDOMCASE 0.25000000000 RANDOMCASE 0.50000000000 RANDOMCASE 2.25000000000 RANDOMEND 
			wait <wait_time> seconds 
		ELSE 
			RETURN 
		ENDIF 
	REPEAT 
ENDSCRIPT

SCRIPT test_scrolling_menu 
	FormatText ChecksumName = title_icon "%i_sound" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	make_new_themed_scrolling_menu title = "SCROLLING" title_icon = <title_icon> 
	SetScreenElementProps { 
		id = sub_menu 
		event_handlers = [ { pad_back generic_menu_pad_back params = { callback = create_test_menu } } ] 
		replace_handlers 
	} 
	theme_menu_add_item text = "Standard" pad_choose_script = null_script centered no_bg first_item 
	theme_menu_add_item text = "Stuff" pad_choose_script = null_script centered no_bg 
	theme_menu_add_item text = "Things" pad_choose_script = null_script centered no_bg 
	theme_menu_add_item text = "Other" pad_choose_script = null_script centered no_bg 
	theme_menu_add_item text = "Blah" pad_choose_script = null_script centered no_bg 
	theme_menu_add_item text = "Wow" pad_choose_script = null_script centered no_bg 
	theme_menu_add_item text = "Tony" pad_choose_script = null_script centered no_bg 
	theme_menu_add_item text = "Hawk\'s" pad_choose_script = null_script centered no_bg 
	theme_menu_add_item text = "Pro" pad_choose_script = null_script centered no_bg 
	theme_menu_add_item text = "Skater" pad_choose_script = null_script centered no_bg 
	theme_menu_add_item text = "1 2 3 4 5 6 7 8 9" pad_choose_script = null_script centered no_bg 
	theme_menu_add_item text = "One" pad_choose_script = null_script centered no_bg 
	theme_menu_add_item text = "Two" pad_choose_script = null_script centered no_bg 
	theme_menu_add_item text = "Three" pad_choose_script = null_script centered no_bg 
	theme_menu_add_item text = "Four" pad_choose_script = null_script centered no_bg 
	theme_menu_add_item text = "Five" pad_choose_script = null_script centered no_bg 
	theme_menu_add_item text = "Six" pad_choose_script = null_script centered no_bg 
	theme_menu_add_item text = "Seven" pad_choose_script = null_script centered no_bg 
	theme_menu_add_item text = "Eight" pad_choose_script = null_script centered no_bg 
	theme_menu_add_item text = "Nine" pad_choose_script = null_script centered no_bg 
	theme_menu_add_item text = "Ten" pad_choose_script = null_script centered no_bg last_item 
	finish_themed_scrolling_menu 
ENDSCRIPT

SCRIPT make_new_themed_scrolling_menu title = "SCROLL" dims = PAIR(300.00000000000, 227.00000000000) pos = PAIR(229.00000000000, 80.00000000000) right_bracket_z = 1 
	IF GotParam no_bar 
		make_new_themed_sub_menu title = <title> title_icon = <title_icon> Scrolling no_bar dims = <dims> pos = <pos> right_bracket_z = <right_bracket_z> 
	ELSE 
		make_new_themed_sub_menu title = <title> title_icon = <title_icon> Scrolling dims = <dims> pos = <pos> right_bracket_z = <right_bracket_z> 
	ENDIF 
	FormatText ChecksumName = arrow_rgba "%i_BG_PARTS_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	SetScreenElementProps { 
		id = sub_vmenu 
		event_handlers = [ { pad_up menu_vert_blink_arrow params = { id = scrolling_menu_up_arrow rgba = <arrow_rgba> } } 
			{ pad_down menu_vert_blink_arrow params = { id = scrolling_menu_down_arrow rgba = <arrow_rgba> } } 
		] 
	} 
ENDSCRIPT

SCRIPT finish_themed_scrolling_menu pos = PAIR(320.00000000000, 85.00000000000) time = 0.20000000298 
	GetScreenElementDims id = sub_scrolling_menu 
	parts = ( <height> / theme_menu_bg_parts_height ) 
	IF LevelIs load_skateshop 
		pos = PAIR(188.00000000000, 60.00000000000) 
	ENDIF 
	IF NOT GotParam bg_width 
		IF NOT GotParam wide_menu 
			bg_width = ( widest_menu_item_width * 0.01250000019 ) 
		ELSE 
			bg_width = ( widest_menu_item_width * 0.02500000037 ) 
		ENDIF 
	ENDIF 
	theme_background width = <bg_width> pos = <pos> num_parts = <parts> z_priority = <z_priority> parent = sub_menu 
	IF ScreenElementExists id = bg_box_top 
		CreateScreenElement { 
			type = SpriteElement 
			parent = bg_box_top 
			id = scrolling_menu_up_arrow 
			texture = up_arrow 
			pos = PAIR(0.00000000000, 13.00000000000) 
			just = [ center center ] 
			rgba = <bg_piece_rgba> 
			scale = PAIR(0.80000001192, 1.00000000000) 
			z_priority = 3 
		} 
		GetScreenElementPosition id = sub_scrolling_menu 
		DoScreenElementMorph id = sub_scrolling_menu pos = ( <ScreenElementPos> + PAIR(0.00000000000, 30.00000000000) ) 
	ENDIF 
	IF ScreenElementExists id = bg_box_bottom 
		CreateScreenElement { 
			type = SpriteElement 
			parent = bg_box_bottom 
			id = scrolling_menu_down_arrow 
			texture = down_arrow 
			pos = PAIR(0.00000000000, -5.00000000000) 
			just = [ center center ] 
			rgba = <bg_piece_rgba> 
			scale = PAIR(0.80000001192, 1.00000000000) 
			z_priority = 3 
		} 
	ENDIF 
	wait 2 gameframes 
	SetScreenElementProps id = sub_scrolling_menu reset_window_top 
	finish_themed_sub_menu time = <time> 
ENDSCRIPT

SCRIPT theme_background parent = current_menu_anchor id = bg_box_vmenu width = 5 pos = PAIR(320.00000000000, 85.00000000000) num_parts = 5 z_priority = 1 
	IF NOT GotParam bg_rgba 
		FormatText ChecksumName = bg_rgba "%i_BG_PARTS_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	ENDIF 
	CreateScreenElement { 
		type = VMenu 
		parent = <parent> 
		id = <id> 
		font = small 
		just = [ left top ] 
		pos = <pos> 
		padding_scale = 1 
		internal_scale = 1 
		internal_just = [ center center ] 
	} 
	anchor_id = <id> 
	middle_parts = <num_parts> 
	CasttoInteger middle_parts 
	partial_scale = ( <num_parts> - <middle_parts> ) 
	printf "partial_scale = %p" p = <partial_scale> 
	build_theme_bg_top parent = <anchor_id> width = <width> bg_rgba = <bg_rgba> z_priority = <z_priority> dark_menu = <dark_menu> static = <static> use_mm_parts = <use_mm_parts> 
	BEGIN 
		build_theme_bg_middle parent = <anchor_id> width = <width> bg_rgba = <bg_rgba> z_priority = <z_priority> dark_menu = <dark_menu> static = <static> use_mm_parts = <use_mm_parts> 
	REPEAT <middle_parts> 
	build_theme_bg_middle parent = <anchor_id> width = <width> bg_rgba = <bg_rgba> scale_height = <partial_scale> z_priority = <z_priority> dark_menu = <dark_menu> static = <static> use_mm_parts = <use_mm_parts> 
	build_theme_bg_bottom parent = <anchor_id> width = <width> bg_rgba = <bg_rgba> scale_height = <partial_scale> z_priority = <z_priority> dark_menu = <dark_menu> static = <static> use_mm_parts = <use_mm_parts> 
ENDSCRIPT

SCRIPT build_theme_bg_top 
	IF GotParam dark_menu 
		m_texture = spec_T_M 
		l_texture = spec_T_L 
		r_texture = spec_T_R 
	ELSE 
		IF GotParam use_mm_parts 
			m_texture = MM_T_M 
			l_texture = MM_T_L 
			r_texture = MM_T_R 
		ELSE 
			m_texture = DE_T_M 
			l_texture = DE_T_L 
			r_texture = DE_T_R 
		ENDIF 
	ENDIF 
	IF NOT GotParam static 
		IF LevelIs load_skateshop 
			m_texture = MM_T_M 
			l_texture = MM_T_L 
			r_texture = MM_T_R 
		ENDIF 
	ENDIF 
	IF ( <parent> = bg_box_vmenu ) 
		top_id = bg_box_top 
	ENDIF 
	CreateScreenElement { 
		type = ContainerElement 
		id = <top_id> 
		dims = PAIR(0.00000000000, 32.00000000000) 
		parent = <parent> 
	} 
	anchor_id = <id> 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <anchor_id> 
		texture = <m_texture> 
		pos = PAIR(0.00000000000, 0.00000000000) 
		just = [ center top ] 
		rgba = <bg_rgba> 
		scale = ( PAIR(1.00000000000, 0.00000000000) * <width> + PAIR(0.00000000000, 1.00000000000) ) 
		z_priority = <z_priority> 
	} 
	GetScreenElementDims id = <id> 
	right_pos = ( PAIR(0.50000000000, 0.00000000000) * <width> ) 
	left_pos = ( PAIR(-0.50000000000, 0.00000000000) * <width> ) 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <anchor_id> 
		texture = <l_texture> 
		pos = <left_pos> 
		just = [ right top ] 
		rgba = <bg_rgba> 
		scale = PAIR(1.00000000000, 1.00000000000) 
		z_priority = <z_priority> 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <anchor_id> 
		texture = <r_texture> 
		pos = <right_pos> 
		just = [ left top ] 
		rgba = <bg_rgba> 
		scale = PAIR(1.00000000000, 1.00000000000) 
		z_priority = <z_priority> 
	} 
ENDSCRIPT

SCRIPT build_theme_bg_middle scale_height = 1 
	IF GotParam dark_menu 
		m_texture = spec_M_M 
		l_texture = spec_M_L 
		r_texture = spec_M_R 
	ELSE 
		IF GotParam use_mm_parts 
			m_texture = MM_M_M 
			l_texture = MM_M_L 
			r_texture = MM_M_R 
		ELSE 
			m_texture = DE_M_M 
			l_texture = DE_M_L 
			r_texture = DE_M_R 
		ENDIF 
	ENDIF 
	IF NOT GotParam static 
		IF LevelIs load_skateshop 
			m_texture = MM_M_M 
			l_texture = MM_M_L 
			r_texture = MM_M_R 
		ENDIF 
	ENDIF 
	CreateScreenElement { 
		type = ContainerElement 
		parent = <parent> 
		dims = ( PAIR(0.00000000000, 1.00000000000) * theme_menu_bg_parts_height ) 
	} 
	anchor_id = <id> 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <anchor_id> 
		texture = <m_texture> 
		pos = PAIR(0.00000000000, 0.00000000000) 
		just = [ center top ] 
		rgba = <bg_rgba> 
		scale = ( PAIR(1.00000000000, 0.00000000000) * <width> + <scale_height> * PAIR(0.00000000000, 1.00000000000) ) 
		z_priority = <z_priority> 
	} 
	GetScreenElementDims id = <id> 
	right_pos = ( PAIR(0.50000000000, 0.00000000000) * <width> ) 
	left_pos = ( PAIR(-0.50000000000, 0.00000000000) * <width> ) 
	side_scale = ( PAIR(1.00000000000, 0.00000000000) * 1 + <scale_height> * PAIR(0.00000000000, 1.00000000000) ) 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <anchor_id> 
		texture = <l_texture> 
		pos = <left_pos> 
		just = [ right top ] 
		rgba = <bg_rgba> 
		scale = <side_scale> 
		z_priority = <z_priority> 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <anchor_id> 
		texture = <r_texture> 
		pos = <right_pos> 
		just = [ left top ] 
		rgba = <bg_rgba> 
		scale = <side_scale> 
		z_priority = <z_priority> 
	} 
ENDSCRIPT

SCRIPT build_theme_bg_bottom 
	IF GotParam dark_menu 
		m_texture = spec_B_M 
		l_texture = spec_B_L 
		r_texture = spec_B_R 
	ELSE 
		IF GotParam use_mm_parts 
			m_texture = MM_B_M 
			l_texture = MM_B_L 
			r_texture = MM_B_R 
		ELSE 
			m_texture = DE_B_M 
			l_texture = DE_B_L 
			r_texture = DE_B_R 
		ENDIF 
	ENDIF 
	IF NOT GotParam static 
		IF LevelIs load_skateshop 
			m_texture = MM_B_M 
			l_texture = MM_B_L 
			r_texture = MM_B_R 
		ENDIF 
	ENDIF 
	IF ( <parent> = bg_box_vmenu ) 
		bot_id = bg_box_bottom 
	ENDIF 
	CreateScreenElement { 
		type = ContainerElement 
		parent = <parent> 
		id = <bot_id> 
		dims = PAIR(0.00000000000, 32.00000000000) 
	} 
	anchor_id = <id> 
	pos = ( PAIR(0.00000000000, -1.00000000000) * ( theme_menu_bg_parts_height - ( <scale_height> * theme_menu_bg_parts_height ) ) ) 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <anchor_id> 
		texture = <m_texture> 
		pos = <pos> 
		just = [ center top ] 
		rgba = <bg_rgba> 
		scale = ( PAIR(1.00000000000, 0.00000000000) * <width> + PAIR(0.00000000000, 1.00000000000) ) 
		z_priority = <z_priority> 
	} 
	GetScreenElementDims id = <id> 
	right_pos = ( PAIR(0.50000000000, 0.00000000000) * <width> + <pos> ) 
	left_pos = ( PAIR(-0.50000000000, 0.00000000000) * <width> + <pos> ) 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <anchor_id> 
		texture = <l_texture> 
		pos = <left_pos> 
		just = [ right top ] 
		rgba = <bg_rgba> 
		scale = PAIR(1.00000000000, 1.00000000000) 
		z_priority = <z_priority> 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <anchor_id> 
		texture = <r_texture> 
		pos = <right_pos> 
		just = [ left top ] 
		rgba = <bg_rgba> 
		scale = PAIR(1.00000000000, 1.00000000000) 
		z_priority = <z_priority> 
	} 
ENDSCRIPT


