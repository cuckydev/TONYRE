current_chapter = 1 
SCRIPT launch_chapter_menu 
	GoalManager_HidePoints 
	GoalManager_HideGoalPoints 
	create_chapter_menu load_em = 1 no_fade <...> 
ENDSCRIPT

SCRIPT fade_in_chap_menu 
	wait 20 gameframes 
	spawnscript fadetoblack params = { off id = fade_out_anchor } 
ENDSCRIPT

SCRIPT create_chapter_menu 
	change check_for_unplugged_controllers = 0 
	GoalManager_GetCurrentChapterAndStage 
	change current_chapter = ( <currentChapter> + 1 ) 
	hide_current_goal 
	IF NOT GotParam no_fade 
		spawnscript fadetoblack params = { on id = fade_out_anchor create_script = create_chapter_fade_piece alpha = 1 time = 0.40000000596 } 
	ENDIF 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
		load_em = 1 
	ENDIF 
	hide_console_window 
	wait 0.50000000000 seconds 
	IF GotParam load_em 
		load_chapter_textures_to_main_memory 
	ENDIF 
	FormatText ChecksumName = highlight_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = unhighlight_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	SetScreenElementLock id = root_window off 
	CreateScreenElement { 
		type = ContainerElement 
		parent = root_window 
		id = chapter_menu_anchor 
		pos = PAIR(320.00000000000, 240.00000000000) 
		dims = PAIR(640.00000000000, 480.00000000000) 
	} 
	AssignAlias id = chapter_menu_anchor alias = current_menu_anchor 
	build_top_and_bottom_blocks static 
	CreateScreenElement { 
		type = SpriteElement 
		parent = current_menu_anchor 
		id = blue_bg 
		texture = chapter_bg 
		rgba = [ 10 38 52 128 ] 
		just = [ left top ] 
		pos = PAIR(0.00000000000, 100.00000000000) 
		scale = PAIR(5.00000000000, 3.00000000000) 
		z_priority = -3 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = current_menu_anchor 
		id = moving_bg 
		texture = bg_elements 
		rgba = [ 128 128 128 20 ] 
		just = [ left top ] 
		pos = PAIR(0.00000000000, 70.00000000000) 
		scale = PAIR(10.00000000000, 4.00000000000) 
		z_priority = -2 
		alpha = 0 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = current_menu_anchor 
		id = rotating_bg_new 
		texture = bg_vector_2 
		rgba = [ 37 57 64 128 ] 
		just = [ center , center ] 
		pos = PAIR(210.00000000000, 200.00000000000) 
		scale = PAIR(2.50000000000, 2.50000000000) 
		z_priority = -1.50000000000 
		alpha = 0 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = current_menu_anchor 
		id = rotating_bg_new_2 
		texture = bg_vector_2 
		rgba = [ 128 17 2 128 ] 
		just = [ center , center ] 
		pos = PAIR(210.00000000000, 200.00000000000) 
		scale = PAIR(2.50000000000, 2.50000000000) 
		z_priority = -1.00000000000 
		alpha = 0 
	} 
	FormatText TextName = chap_text "CHAPTER %i: %l" i = current_chapter l = ( ( CHAPTER_LEVELS [ ( current_chapter -1 ) ] ) . text ) 
	CreateScreenElement { 
		type = TextElement 
		parent = current_menu_anchor 
		id = chap_number 
		text = <chap_text> 
		font = testtitle 
		rgba = <highlight_rgba> 
		just = [ left top ] 
		pos = PAIR(25.00000000000, 22.00000000000) 
		scale = 1.20000004768 
		z_priority = 3 
		alpha = 0.38999998569 
	} 
	FormatText ChecksumName = bracket_texture "%i_sub_frame" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	CreateScreenElement { 
		type = SpriteElement 
		parent = current_menu_anchor 
		id = chap_border 
		texture = <bracket_texture> 
		rgba = [ 128 128 128 0 ] 
		just = [ left top ] 
		pos = PAIR(12.00000000000, 10.00000000000) 
		scale = PAIR(1.00000000000, 1.35000002384) 
		z_priority = 3 
	} 
	CreateScreenElement { 
		type = TextElement 
		parent = current_menu_anchor 
		id = chap_title 
		text = ( CHAPTER_TITLES [ ( current_chapter - 1 ) ] ) 
		font = testtitle 
		rgba = [ 30 73 100 120 ] 
		just = [ center top ] 
		pos = PAIR(318.00000000000, 34.00000000000) 
		scale = 1.75000000000 
		alpha = 0.30000001192 
		z_priority = 2 
	} 
	CreateScreenElement { 
		type = TextElement 
		parent = current_menu_anchor 
		id = chap_title2 
		text = ( CHAPTER_TITLES [ ( current_chapter - 1 ) ] ) 
		font = testtitle 
		rgba = [ 128 128 128 100 ] 
		just = [ center top ] 
		pos = PAIR(320.00000000000, 34.00000000000) 
		scale = 1.75000000000 
		alpha = 0.15000000596 
		z_priority = 2 
	} 
	CreateScreenElement { 
		type = TextBlockElement 
		parent = current_menu_anchor 
		id = chap_description 
		text = ( CHAPTER_DESCRIPTIONS [ ( current_chapter - 1 ) ] ) 
		font = dialog 
		rgba = [ 128 128 128 60 ] 
		dims = PAIR(570.00000000000, 50.00000000000) 
		allow_expansion 
		just = [ left top ] 
		internal_just = [ left top ] 
		pos = PAIR(45.00000000000, 58.00000000000) 
		internal_scale = 0.80000001192 
		z_priority = 3 
		line_spacing = 0.60000002384 
		alpha = 0.75000000000 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = current_menu_anchor 
		texture = streak_2 
		rgba = <highlight_rgba> 
		just = [ left top ] 
		pos = PAIR(0.00000000000, 50.00000000000) 
		scale = PAIR(10.00000000000, 0.34999999404) 
		alpha = 0.30000001192 
		z_priority = 3 
		rot_angle = -4 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = current_menu_anchor 
		texture = streak_2 
		rgba = <highlight_rgba> 
		just = [ left top ] 
		pos = PAIR(0.00000000000, 54.00000000000) 
		scale = PAIR(100.00000000000, 0.25000000000) 
		z_priority = 2 
		rot_angle = 0 
		alpha = 0.64999997616 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = current_menu_anchor 
		texture = streak_2 
		rgba = <highlight_rgba> 
		just = [ left top ] 
		pos = PAIR(0.00000000000, 268.00000000000) 
		scale = PAIR(10.00000000000, 0.34999999404) 
		alpha = 0.30000001192 
		z_priority = 0.50000000000 
		rot_angle = 6 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = current_menu_anchor 
		texture = streak_2 
		rgba = <highlight_rgba> 
		just = [ left top ] 
		pos = PAIR(0.00000000000, 348.00000000000) 
		scale = PAIR(10.00000000000, 0.34999999404) 
		alpha = 0.50000000000 
		z_priority = 0.50000000000 
		rot_angle = -4 
	} 
	FormatText ChecksumName = chapter_graphic "chap_graphic_%i" i = ( ( CHAPTER_LEVELS [ ( current_chapter -1 ) ] ) . num ) 
	IF LevelIs ( ( CHAPTER_LEVELS [ ( current_chapter -1 ) ] ) . checksum ) 
		alpha = 0 
	ELSE 
		alpha = 1 
	ENDIF 
	CreateScreenElement { 
		type = ContainerElement 
		parent = current_menu_anchor 
		id = graphic_anchor 
		pos = PAIR(320.00000000000, 240.00000000000) 
		dims = PAIR(640.00000000000, 480.00000000000) 
		alpha = <alpha> 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = graphic_anchor 
		texture = white2 
		rgba = [ 0 0 0 128 ] 
		just = [ left top ] 
		pos = PAIR(380.00000000000, 100.00000000000) 
		scale = PAIR(40.00000000000, 40.00000000000) 
		z_priority = -4 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = graphic_anchor 
		id = chapter_graphic1 
		texture = <chapter_graphic> 
		rgba = [ 128 128 128 55 ] 
		just = [ center center ] 
		pos = PAIR(510.00000000000, 225.00000000000) 
		scale = PAIR(2.00000000000, 2.00000000000) 
		z_priority = 3 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = graphic_anchor 
		id = chapter_graphic2 
		texture = <chapter_graphic> 
		rgba = [ 128 128 128 15 ] 
		just = [ center center ] 
		pos = PAIR(505.00000000000, 245.00000000000) 
		scale = PAIR(2.40000009537, 2.40000009537) 
		z_priority = 0 
		alpha = 0.60000002384 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = current_menu_anchor 
		id = chapter_graphic3 
		texture = <chapter_graphic> 
		rgba = [ 50 34 34 0 ] 
		just = [ center center ] 
		pos = PAIR(570.00000000000, 50.00000000000) 
		scale = PAIR(1.20000004768, 0.75000000000) 
		z_priority = 0 
		rot_angle = 0 
	} 
	build_chapter_goal_list_menu <...> 
	IF NOT GotParam no_pad_left_right 
		IF NOT GotParam select_sponsor 
			IF NOT GotParam select_team 
				build_chapter_box_menu 
			ENDIF 
		ENDIF 
	ENDIF 
	killspawnedscript name = text_moving_bg 
	spawnscript chap_moving_bg 
	spawnscript chap_new_rotating_bg 
	spawnscript chap_new_rotating_bg_2 
	spawnscript chap_graphic_crossfade 
	IF NOT GotParam no_fade 
		spawnscript fadetoblack params = { off id = fade_out_anchor } 
	ENDIF 
	pause_menu_gradient off 
	wait 20 gameframes 
	IF ScreenElementExists id = chap_scrolling_menu 
		SetScreenElementProps id = chap_scrolling_menu reset_window_top 
	ENDIF 
	pulse_blur start = 200 speed = 5 
	killspawnedscript name = play_chap_sound 
	spawnscript play_chap_sound 
	IF ScreenElementExists id = chap_menu 
		DoScreenElementMorph id = chap_menu time = 0.20000000298 pos = PAIR(290.00000000000, 232.00000000000) 
		wait 0.20000000298 seconds 
	ENDIF 
	FireEvent type = focus target = chap_menu 
	GoalManager_GetCurrentChapterAndStage 
	change disable_menu_sounds = 1 
	IF NOT ( <currentStage> = 0 ) 
		<index> = 0 
		BEGIN 
			GetArraySize CHAPTER_GOALS index1 = <currentChapter> index2 = <index> 
			BEGIN 
				FireEvent type = pad_down target = chap_vmenu 
			REPEAT <array_size> 
			<index> = ( <index> + 1 ) 
		REPEAT <currentStage> 
	ENDIF 
	<index> = 0 
	GetArraySize CHAPTER_GOALS index1 = <currentChapter> index2 = <currentStage> 
	IF NOT ( <array_size> = 0 ) 
		BEGIN 
			Get3DArrayData ArrayName = CHAPTER_GOALS index1 = <currentChapter> index2 = <currentStage> index3 = <index> 
			IF StructureContains structure = <val> goal_id 
				<goal_id> = ( <val> . goal_id ) 
				IF GoalManager_HasWonGoal name = <goal_id> 
					FireEvent type = pad_down target = chap_vmenu 
				ELSE 
					BREAK 
				ENDIF 
			ENDIF 
			<index> = ( <index> + 1 ) 
		REPEAT <array_size> 
	ENDIF 
	change disable_menu_sounds = 0 
	change check_for_unplugged_controllers = 1 
ENDSCRIPT

SCRIPT chapter_menu_exit 
	wait 0.30000001192 seconds 
	KillSkaterCamAnim current 
	killspawnedscript name = chap_moving_bg 
	killspawnedscript name = spawnscrip chap_new_rotating_bg 
	killspawnedscript name = spawnscrip chap_new_rotating_bg_2 
	killspawnedscript name = chap_graphic_crossfade 
	killspawnedscript name = fadetoblack 
	IF ScreenElementExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	IF ScreenElementExists id = fade_out_anchor 
		DestroyScreenElement id = fade_out_anchor 
	ENDIF 
	load_chapter_textures_to_main_memory unload 
	kill_blur start = 0 
	unhide_key_combo_text 
	IF NOT GotParam exit 
		create_pause_menu 
	ELSE 
		exit_pause_menu 
	ENDIF 
ENDSCRIPT

SCRIPT build_chapter_goal_list_menu pos = PAIR(-40.00000000000, 105.00000000000) 
	printf "build_chapter_goal_list_menu" 
	RemoveParameter id 
	final_on = [ 40 128 40 120 ] 
	final_off = [ 60 120 60 100 ] 
	IF ScreenElementExists id = chap_menu 
		DestroyScreenElement id = chap_menu 
	ENDIF 
	IF GotParam select_team 
		<padding_scale> = 0.89999997616 
	ENDIF 
	make_new_menu { 
		type = <type> 
		pos = <pos> 
		parent = chapter_menu_anchor 
		just = [ center center ] 
		internal_just = [ left center ] 
		menu_id = chap_menu 
		vmenu_id = chap_vmenu 
		scrolling_menu_id = <scrolling_menu_id> 
		type = <type> 
		dims = <dims> 
		dont_allow_wrap = <dont_allow_wrap> 
		padding_scale = <padding_scale> 
	} 
	DoScreenElementMorph id = chap_menu time = 0 pos = PAIR(290.00000000000, 620.00000000000) 
	<set_pad_back_event> = 0 
	IF NOT GotParam no_pad_left_right 
		IF NOT GotParam select_sponsor 
			IF NOT GotParam select_team 
				IF NOT GotParam no_pad_back 
					<set_pad_back_event> = 1 
					SetScreenElementProps { 
						id = chap_menu 
						event_handlers = [ 
							{ pad_back generic_menu_pad_back params = { callback = chapter_menu_exit } } 
						] 
						replace_handlers 
					} 
				ENDIF 
				SetScreenElementProps { 
					id = chap_menu 
					event_handlers = [ 
						{ pad_l1 toggle_current_chapter params = { reverse no_pad_back = <no_pad_back> } } 
						{ pad_r1 toggle_current_chapter params = { no_pad_back = <no_pad_back> } } 
					] 
					replace_handlers 
				} 
				SetScreenElementProps { 
					id = chap_menu 
					event_handlers = [ 
						{ pad_left toggle_current_chapter params = { reverse no_pad_back = <no_pad_back> } } 
						{ pad_right toggle_current_chapter params = { no_pad_back = <no_pad_back> } } 
					] 
					replace_handlers 
				} 
			ENDIF 
		ENDIF 
	ENDIF 
	IF ( <set_pad_back_event> = 0 ) 
		kill_start_key_binding 
		SetScreenElementProps { 
			id = chap_menu 
			event_handlers = [ 
				{ pad_back generic_menu_buzzer_sound } 
			] 
			replace_handlers 
		} 
	ENDIF 
	AssignAlias id = chapter_menu_anchor alias = current_menu_anchor 
	IF ( ( GotParam select_sponsor ) | ( GotParam select_team ) | ( GotParam no_pad_back ) ) 
		create_helper_text { helper_text_elements = [ { text = "\\b7/\\b4 = Select" } 
				{ text = "\\bm = Accept" } 
			] 
			no_bar 
		} 
	ELSE 
		create_helper_text { helper_text_elements = [ { text = "\\b7/\\b4 = Select" } 
				{ text = "\\bn = Back" } 
				{ text = "\\bm = Accept" } 
			] 
			no_bar 
		} 
	ENDIF 
	IF ( GotParam select_sponsor ) 
		IF LevelIs load_boardshop 
		ENDIF 
	ENDIF 
	kill_start_key_binding 
	GetArraySize ( CHAPTER_GOALS [ ( current_chapter -1 ) ] ) 
	num_stages = <array_size> 
	stage = 0 
	BEGIN 
		GetArraySize ( ( CHAPTER_GOALS [ ( current_chapter -1 ) ] ) [ <stage> ] ) 
		index = 0 
		BEGIN 
			<status> = 0 
			chapter_menu_get_status { 
				goal_info = ( ( ( CHAPTER_GOALS [ ( current_chapter - 1 ) ] ) [ <stage> ] ) [ <index> ] ) 
				stage = <stage> 
			} 
			focus_script = goal_focus 
			unfocus_script = goal_unfocus 
			focus_params = { 
				goal_id = ( ( ( ( CHAPTER_GOALS [ ( current_chapter - 1 ) ] ) [ <stage> ] ) [ <index> ] ) . goal_id ) 
				targetOffset = ( ( ( ( CHAPTER_GOALS [ ( current_chapter - 1 ) ] ) [ <stage> ] ) [ <index> ] ) . targetOffset ) 
				positionOffset = ( ( ( ( CHAPTER_GOALS [ ( current_chapter - 1 ) ] ) [ <stage> ] ) [ <index> ] ) . positionOffset ) 
				no_ped_cam = ( ( ( ( CHAPTER_GOALS [ ( current_chapter - 1 ) ] ) [ <stage> ] ) [ <index> ] ) . no_ped_cam ) 
			} 
			SWITCH <status> 
				CASE 0 
					RemoveParameter text_rgba 
					GoalManager_GetCurrentChapterAndStage 
					IF ( <currentChapter> > ( current_chapter - 1 ) ) 
						text_alpha = 0.50000000000 
					ELSE 
						IF ( ( <currentChapter> = ( current_chapter - 1 ) ) & ( <currentStage> > <stage> ) ) 
							text_alpha = 0.50000000000 
						ELSE 
							RemoveParameter text_alpha 
						ENDIF 
					ENDIF 
				CASE 1 
					RemoveParameter text_rgba 
					text_alpha = 0.50000000000 
					cross_it_out = cross_it_out 
				CASE 2 
					text_rgba = [ 50 50 50 100 ] 
					highlighted_text_rgba = [ 0 0 0 0 ] 
					RemoveParameter text_alpha 
					not_focusable = not_focusable 
				CASE 3 
					text_rgba = <final_off> 
					highlighted_text_rgba = <final_on> 
					RemoveParameter text_alpha 
					focus_script = final_goal_focus 
					unfocus_script = final_goal_unfocus 
				CASE 4 
					text_rgba = <final_off> 
					highlighted_text_rgba = <final_on> 
					text_alpha = 0.50000000000 
					cross_it_out = cross_it_out 
				CASE 5 
					text_rgba = [ 50 50 50 100 ] 
					highlighted_text_rgba = [ 0 0 0 0 ] 
					RemoveParameter text_alpha 
					not_focusable = not_focusable 
			ENDSWITCH 
			<should_show_item> = 1 
			IF GotParam select_sponsor 
				<sponsor_struct> = ( ( ( CHAPTER_GOALS [ ( current_chapter - 1 ) ] ) [ <stage> ] ) [ <index> ] ) 
				IF StructureContains structure = <sponsor_struct> replay_videos 
					pad_choose_script = select_sponsor_play_movies 
					pad_choose_params = { select_sponsor = select_sponsor } 
				ELSE 
					pad_choose_script = select_sponsor_choose 
					pad_choose_params = { sponsor = ( <sponsor_struct> . sponsor ) } 
				ENDIF 
			ELSE 
				IF GotParam select_team 
					<pro_struct> = ( ( ( CHAPTER_GOALS [ ( current_chapter - 1 ) ] ) [ <stage> ] ) [ <index> ] ) 
					pad_choose_script = select_team_choose 
					pad_choose_params = { pro = ( <pro_struct> . pro ) } 
					<id> = ( <pro_struct> . pro ) 
					value = 0 
					check = check 
				ELSE 
					IF ( current_chapter = 10 ) 
						not_focusable = not_focusable 
						IF ( ( <index> = ( <array_size> -1 ) ) & ( <stage> = ( <num_stages> -1 ) ) ) 
							RemoveParameter not_focusable 
						ENDIF 
					ENDIF 
					IF ( current_chapter = 25 ) 
						not_focusable = not_focusable 
						GoalManager_GetTeam 
						<pro_struct> = ( ( ( CHAPTER_GOALS [ ( current_chapter - 1 ) ] ) [ <stage> ] ) [ <index> ] ) 
						IF NOT StructureContains structure = <team> ( <pro_struct> . pro ) 
							<should_show_item> = 0 
						ENDIF 
					ENDIF 
					IF ( ( current_chapter = 10 ) & ( ( <index> = ( <array_size> -1 ) ) & ( <stage> = ( <num_stages> -1 ) ) ) ) 
						pad_choose_script = select_sponsor_play_movies 
						pad_choose_params = { select_sponsor = select_sponsor return_to_level } 
					ELSE 
						IF LevelIs ( ( CHAPTER_LEVELS [ ( current_chapter -1 ) ] ) . checksum ) 
							pad_choose_script = chapter_menu_start_goal 
							pad_choose_params = { goal_id = ( ( ( ( CHAPTER_GOALS [ ( current_chapter -1 ) ] ) [ <stage> ] ) [ <index> ] ) . goal_id ) } 
						ELSE 
							pad_choose_script = chapter_menu_change_level_and_start_goal 
							IF StructureContains structure = ( ( ( CHAPTER_GOALS [ ( current_chapter -1 ) ] ) [ <stage> ] ) [ <index> ] ) level 
								IF LevelIs ( ( ( ( CHAPTER_GOALS [ ( current_chapter -1 ) ] ) [ <stage> ] ) [ <index> ] ) . level ) 
									pad_choose_script = chapter_menu_start_goal 
									pad_choose_params = { goal_id = ( ( ( ( CHAPTER_GOALS [ ( current_chapter -1 ) ] ) [ <stage> ] ) [ <index> ] ) . goal_id ) } 
								ELSE 
									pad_choose_params = { 
										goal_id = ( ( ( ( CHAPTER_GOALS [ ( current_chapter -1 ) ] ) [ <stage> ] ) [ <index> ] ) . goal_id ) 
										level = ( ( ( ( CHAPTER_GOALS [ ( current_chapter -1 ) ] ) [ <stage> ] ) [ <index> ] ) . level ) 
									} 
								ENDIF 
							ELSE 
								pad_choose_params = { 
									goal_id = ( ( ( ( CHAPTER_GOALS [ ( current_chapter -1 ) ] ) [ <stage> ] ) [ <index> ] ) . goal_id ) 
									level = ( ( CHAPTER_LEVELS [ ( current_chapter -1 ) ] ) . checksum ) 
								} 
							ENDIF 
						ENDIF 
					ENDIF 
				ENDIF 
			ENDIF 
			IF ( ( <index> = ( <array_size> -1 ) ) & ( <stage> = ( <num_stages> -1 ) ) ) 
				IF ( <should_show_item> = 1 ) 
					chapter_goal_add_item { text = ( ( ( ( CHAPTER_GOALS [ ( current_chapter -1 ) ] ) [ <stage> ] ) [ <index> ] ) . text ) 
						pad_choose_script = <pad_choose_script> 
						pad_choose_params = <pad_choose_params> 
						id = final_goal_item 
						text_rgba = <text_rgba> 
						text_alpha = <text_alpha> 
						line_rgba = <text_rgba> 
						last_menu_item = 1 
						highlighted_text_rgba = <highlighted_text_rgba> 
						cross_it_out = <cross_it_out> 
						focus_script = <focus_script> 
						unfocus_script = <unfocus_script> 
						focus_params = <focus_params> 
						not_focusable = <not_focusable> 
						<check> 
						value = <value> 
					} 
				ENDIF 
				IF ( <status> = 3 ) 
					GetStackedScreenElementPos X id = { final_goal_item child = 0 } offset = PAIR(25.00000000000, 18.00000000000) 
					CreateScreenElement { 
						type = SpriteElement 
						parent = final_goal_item 
						texture = final 
						scale = PAIR(1.00000000000, 1.00000000000) 
						rgba = <text_rgba> 
						alpha = <text_alpha> 
						pos = <pos> 
					} 
					RemoveParameter id 
				ENDIF 
			ELSE 
				IF ( <should_show_item> = 1 ) 
					chapter_goal_add_item { text = ( ( ( ( CHAPTER_GOALS [ ( current_chapter -1 ) ] ) [ <stage> ] ) [ <index> ] ) . text ) 
						pad_choose_script = <pad_choose_script> 
						pad_choose_params = <pad_choose_params> 
						text_rgba = <text_rgba> 
						text_alpha = <text_alpha> 
						cross_it_out = <cross_it_out> 
						focus_script = <focus_script> 
						unfocus_script = <unfocus_script> 
						focus_params = <focus_params> 
						not_focusable = <not_focusable> 
						id = <id> 
						<check> 
						value = <value> 
					} 
				ENDIF 
			ENDIF 
			RemoveParameter not_focusable 
			RemoveParameter cross_it_out 
			RemoveParameter focus_script 
			RemoveParameter unfocus_script 
			index = ( <index> + 1 ) 
		REPEAT <array_size> 
		stage = ( <stage> + 1 ) 
	REPEAT <num_stages> 
	IF ( current_chapter = 25 ) 
		IF GotParam select_team 
			pad_choose_params = { new_team } 
			not_focusable = not_focusable 
			chapter_goal_add_item { 
				text = "Done" 
				pad_choose_script = select_team_done 
				pad_choose_params = <pad_choose_params> 
				text_rgba = <text_rgba> 
				text_alpha = <text_alpha> 
				focus_script = <focus_script> 
				unfocus_script = <unfocus_script> 
				focus_params = <focus_params> 
				not_focusable = <not_focusable> 
				id = select_team_done_item 
			} 
		ENDIF 
	ENDIF 
	FormatText ChecksumName = unhighlight_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	CreateScreenElement { 
		type = ContainerElement 
		parent = chap_menu 
		not_focusable 
	} 
	status_text_pos = PAIR(645.00000000000, 365.00000000000) 
	calculate_chapter_goals_to_continue 
	IF ( <goals_to_continue> > 0 ) 
		IF ( <goals_to_continue> = 1 ) 
			FormatText TextName = continue_text "Complete \\c2%g\\c0 more goal to continue..." g = <goals_to_continue> 
		ELSE 
			FormatText TextName = continue_text "Complete \\c2%g\\c0 more goals to continue..." g = <goals_to_continue> 
		ENDIF 
	ELSE 
		continue_text = "" 
	ENDIF 
	CreateScreenElement { 
		type = TextElement 
		parent = <id> 
		text = <continue_text> 
		pos = <status_text_pos> 
		font = small 
		rgba = <unhighlight_rgba> 
		just = [ right center ] 
		scale = 0.80000001192 
		z_priority = 4 
	} 
ENDSCRIPT

SCRIPT calculate_chapter_goals_to_continue 
	GetArraySize ( CHAPTER_NUM_GOALS_TO_COMPLETE [ ( current_chapter -1 ) ] ) 
	num_stages = <array_size> 
	GoalManager_GetCurrentChapterAndStage 
	goals_needed = 0 
	goals_beaten = 0 
	index = 0 
	IF ( <currentChapter> > ( current_chapter - 1 ) ) 
		RETURN goals_to_continue = 0 
	ENDIF 
	GetArraySize ( CHAPTER_NUM_GOALS_TO_COMPLETE [ ( current_chapter -1 ) ] ) 
	IF ( <currentStage> > ( <array_size> -1 ) ) 
		RETURN goals_to_continue = 0 
	ENDIF 
	printf "current_chapter = %i currentChapter=%j currentStage=%k" i = current_chapter j = <currentChapter> k = <currentStage> 
	goals_needed = ( ( ( CHAPTER_NUM_GOALS_TO_COMPLETE [ ( current_chapter -1 ) ] ) [ <currentStage> ] ) ) 
	GetArraySize ( ( CHAPTER_GOALS [ ( current_chapter - 1 ) ] ) [ <currentStage> ] ) 
	index = 0 
	BEGIN 
		goal_info = ( ( ( CHAPTER_GOALS [ ( current_chapter - 1 ) ] ) [ <currentStage> ] ) [ <index> ] ) 
		goal_id = ( <goal_info> . goal_id ) 
		IF GotParam goal_id 
			IF GoalManager_HasWonGoal name = <goal_id> 
				goals_beaten = ( <goals_beaten> + 1 ) 
			ENDIF 
		ELSE 
			RETURN goals_to_continue = 0 
		ENDIF 
		index = ( <index> + 1 ) 
	REPEAT <array_size> 
	goals_to_continue = ( <goals_needed> - <goals_beaten> ) 
	RETURN goals_to_continue = <goals_to_continue> 
ENDSCRIPT

SCRIPT build_chapter_box_menu pos = PAIR(320.00000000000, 395.00000000000) parent = current_menu_anchor 
	IF ScreenElementExists id = chap_box_menu 
		DestroyScreenElement id = chap_box_menu 
	ENDIF 
	locked_color = [ 53 72 100 80 ] 
	FormatText ChecksumName = unlocked_color "%i_SPEECH_BOX_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = highlight_color "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	CreateScreenElement { 
		type = ContainerElement 
		parent = <parent> 
		id = chap_box_menu 
		just = [ center center ] 
		pos = PAIR(320.00000000000, 229.00000000000) 
		dims = PAIR(640.00000000000, 480.00000000000) 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = chap_box_menu 
		texture = filmstripbar 
		rgba = <unlocked_color> 
		just = [ center center ] 
		pos = <pos> 
		scale = PAIR(20.00000000000, 1.00000000000) 
		z_priority = 6 
		alpha = 0.40000000596 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = chap_box_menu 
		texture = left_arrow 
		rgba = <unlocked_color> 
		just = [ right center ] 
		pos = PAIR(80.00000000000, 395.00000000000) 
		scale = PAIR(1.25000000000, 0.80000001192) 
		alpha = 0.60000002384 
		z_priority = 8 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = chap_box_menu 
		texture = right_arrow 
		rgba = <unlocked_color> 
		just = [ left center ] 
		pos = PAIR(560.00000000000, 395.00000000000) 
		scale = PAIR(1.25000000000, 0.80000001192) 
		alpha = 0.60000002384 
		z_priority = 8 
	} 
	CreateScreenElement { 
		type = TextElement 
		parent = chap_box_menu 
		id = chap_l1 
		text = "\\bs" 
		font = small 
		just = [ right center ] 
		pos = PAIR(55.00000000000, 395.00000000000) 
		scale = 0.94999998808 
		alpha = 0.50000000000 
		z_priority = 7 
	} 
	CreateScreenElement { 
		type = TextElement 
		parent = chap_box_menu 
		id = chap_r1 
		text = "\\bt" 
		font = small 
		just = [ left center ] 
		pos = PAIR(583.00000000000, 395.00000000000) 
		scale = 0.94999998808 
		alpha = 0.50000000000 
		z_priority = 7 
	} 
	CreateScreenElement { 
		type = HMenu 
		id = chap_box_hmenu 
		parent = chap_box_menu 
		pos = <pos> 
		just = [ center center ] 
		spacing_between = -7 
	} 
	GetArraySize CHAPTER_STATUS 
	chapter_index = 0 
	BEGIN 
		status = ( CHAPTER_STATUS [ <chapter_index> ] ) 
		SWITCH <status> 
			CASE 0 
				dot_texture = chap_dot 
				box_color = <locked_color> 
			CASE 1 
				dot_texture = chap_dot 
				box_color = <unlocked_color> 
			CASE 2 
				dot_texture = chap_dot_done 
				box_color = <unlocked_color> 
		ENDSWITCH 
		IF ( <chapter_index> = ( current_chapter - 1 ) ) 
			dot_texture = chap_dot_highlight 
			box_color = <highlight_color> 
		ENDIF 
		CreateScreenElement { 
			type = SpriteElement 
			parent = chap_box_hmenu 
			texture = <dot_texture> 
			rgba = <box_color> 
			just = [ center center ] 
			scale = PAIR(0.60000002384, 1.00000000000) 
			z_priority = 7 
		} 
		IF ( <chapter_index> = ( current_chapter - 1 ) ) 
			current_dot = <id> 
		ENDIF 
		chapter_index = ( <chapter_index> + 1 ) 
	REPEAT <array_size> 
	spawnscript Chapter_menu_pad_Left_or_Right_Sound 
	spawnscript chapter_dot_effect params = { id = <current_dot> } 
ENDSCRIPT

SCRIPT chapter_goal_add_item 
	scale = 0.89999997616 
	dark_menu = dark_menu 
	no_bg = no_bg 
	static_width = static_width 
	highlight_bar_scale = PAIR(9.00000000000, 0.69999998808) 
	highlight_bar_pos = PAIR(190.00000000000, -7.00000000000) 
	z_priority = 5 
	text_just = [ left center ] 
	IF GotParam check 
		theme_menu_add_checkbox_item <...> no_sound 
	ELSE 
		theme_menu_add_item <...> 
	ENDIF 
ENDSCRIPT

SCRIPT goal_focus 
	main_theme_focus <...> 
	IF NOT ( ( current_chapter = 10 ) | ( current_chapter = 25 ) | ( current_chapter = 26 ) ) 
		IF LevelIs ( ( CHAPTER_LEVELS [ ( current_chapter -1 ) ] ) . checksum ) 
			chapter_menu_play_preview_cam <...> 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT goal_unfocus 
	main_theme_unfocus <...> 
	GetTags 
	IF GotParam goal_id 
	ENDIF 
ENDSCRIPT

SCRIPT final_goal_focus 
	goal_focus <...> 
	GetTags 
	DoScreenElementMorph { 
		id = { <id> child = 4 } 
		time = 0.11999999732 
		rgba = <highlighted_text_rgba> 
		scale = 1.25000000000 
		rot_angle = 360 
		relative_scale 
	} 
ENDSCRIPT

SCRIPT final_goal_unfocus 
	goal_unfocus <...> 
	GetTags 
	DoScreenElementMorph { 
		id = { <id> child = 4 } 
		time = 0.20000000298 
		rgba = <text_rgba> 
		alpha = <text_alpha> 
		scale = 1 
		relative_scale 
	} 
	DoScreenElementMorph { 
		id = { <id> child = 4 } 
		time = 0 
		rot_angle = 0 
	} 
ENDSCRIPT

SCRIPT chapter_menu_play_preview_cam 
	KillSkaterCamAnim current 
	menu_cam : unpause 
	GoalManager_GetGoalParams name = <goal_id> 
	IF IsAlive name = <trigger_obj_id> 
		IF GotParam no_ped_cam 
			printf "using special camera" 
			IF GotParam positionOffset 
				menu_cam : Obj_SetPosition Position = <positionOffset> 
			ELSE 
				menu_cam : Obj_SetPosition Position = VECTOR(0.00000000000, 100.00000000000, 0.00000000000) 
			ENDIF 
			menu_cam : Obj_SetOrientation Y = 45 
			SetActiveCamera id = menu_cam 
			SetSkaterCamAnimShouldPause name = <goal_id> should_pause = 0 
			RETURN 
		ELSE 
			printf "using default ped camera" 
			<trigger_obj_id> : Obj_GetPosition 
			menu_cam : Obj_SetPosition Position = ( <pos> + VECTOR(60.00000000000, 40.00000000000, 150.00000000000) ) 
			menu_cam : Obj_SetOrientation Y = 45 
			SetActiveCamera id = menu_cam 
			SetSkaterCamAnimShouldPause name = <goal_id> should_pause = 0 
			RETURN 
		ENDIF 
	ENDIF 
	IF LevelIs load_nj 
		Position = VECTOR(-406.95349121094, 263.01223754883, 3691.41674804688) 
		X = 0.98220402002 Y = 0.17877100408 z = 0.05758799985 
	ENDIF 
	IF LevelIs load_ny 
		Position = VECTOR(116.95349121094, 533.01226806641, 91.41674804688) 
		X = 0.98220402002 Y = 0.17877100408 z = 0.05758799985 
	ENDIF 
	IF LevelIs load_fl 
		Position = VECTOR(216.95349121094, 233.01223754883, 2791.41674804688) 
		X = 0.98220402002 Y = 0.17877100408 z = 0.05758799985 
	ENDIF 
	IF LevelIs load_sd 
		Position = VECTOR(-3016.95336914062, 433.01223754883, -3391.24169921875) 
		X = 0.98220402002 Y = 0.17877100408 z = 0.05758799985 
	ENDIF 
	IF LevelIs load_hi 
		Position = VECTOR(616.95349121094, 353.01223754883, 7791.64160156250) 
		X = 0.98220402002 Y = 0.17877100408 z = 0.05758799985 
	ENDIF 
	IF LevelIs load_vc 
		Position = VECTOR(616.95349121094, 633.01226806641, 2791.74169921875) 
		X = 0.98220402002 Y = 0.17877100408 z = 0.05758799985 
	ENDIF 
	IF LevelIs load_sj 
		Position = VECTOR(116.95349121094, -493.01223754883, 991.41674804688) 
		X = 0.98220402002 Y = 0.17877100408 z = 0.05758799985 
	ENDIF 
	IF LevelIs load_ru 
		Position = VECTOR(616.95349121094, 933.01226806641, 2791.84155273438) 
		X = 0.98220402002 Y = 0.17877100408 z = 0.05758799985 
	ENDIF 
	IF LevelIs load_se 
		Position = VECTOR(616.95349121094, 33.01224136353, 2791.41674804688) 
		X = 0.98220402002 Y = 0.17877100408 z = 0.05758799985 
	ENDIF 
	printf "using level camera" 
	menu_cam : Obj_SetPosition Position = <Position> 
	menu_cam : Obj_SetOrientation X = <X> Y = <Y> z = <z> 
	SetActiveCamera id = menu_cam 
ENDSCRIPT

SCRIPT update_chapter_menu 
	build_chapter_goal_list_menu no_pad_back = <no_pad_back> 
	build_chapter_box_menu 
	FormatText TextName = chap_text "CHAPTER %i: %l" i = current_chapter l = ( ( CHAPTER_LEVELS [ ( current_chapter -1 ) ] ) . text ) 
	SetScreenElementProps id = chap_number text = <chap_text> 
	IF ObjectExists id = chap_title 
		SetScreenElementProps id = chap_title text = ( CHAPTER_TITLES [ ( current_chapter - 1 ) ] ) 
		SetScreenElementProps id = chap_title2 text = ( CHAPTER_TITLES [ ( current_chapter - 1 ) ] ) 
		DoScreenElementMorph id = chap_title alpha = 0 time = 0 
		DoScreenElementMorph id = chap_title2 alpha = 0 time = 0 
		DoScreenElementMorph id = chap_description alpha = 0 
		SetScreenElementProps id = chap_description text = ( CHAPTER_DESCRIPTIONS [ ( current_chapter - 1 ) ] ) 
	ENDIF 
	FormatText ChecksumName = chapter_graphic "chap_graphic_%i" i = ( ( CHAPTER_LEVELS [ ( current_chapter -1 ) ] ) . num ) 
	SetScreenElementProps id = chapter_graphic1 texture = <chapter_graphic> 
	SetScreenElementProps id = chapter_graphic2 texture = <chapter_graphic> 
	SetScreenElementProps id = chapter_graphic3 texture = <chapter_graphic> 
	IF LevelIs ( ( CHAPTER_LEVELS [ ( current_chapter -1 ) ] ) . checksum ) 
		DoScreenElementMorph id = graphic_anchor alpha = 0 
	ELSE 
		DoScreenElementMorph id = graphic_anchor alpha = 1 
	ENDIF 
	IF GotParam left 
		menu_vert_blink_arrow id = chap_l1 
	ELSE 
		IF GotParam right 
			menu_vert_blink_arrow id = chap_r1 
		ENDIF 
	ENDIF 
	FireEvent type = focus target = chap_menu 
	wait 20 gameframes 
	pulse_blur start = 200 speed = 5 
	IF ObjectExists id = chap_title 
		DoScreenElementMorph id = chap_title alpha = 0.30000001192 time = 0.50000000000 
		DoScreenElementMorph id = chap_title2 alpha = 0.15000000596 time = 0.75000000000 
	ENDIF 
	killspawnedscript name = play_chap_sound 
	IF ScreenElementExists id = chap_menu 
		spawnscript play_chap_sound 
		DoScreenElementMorph id = chap_menu time = 0.20000000298 pos = PAIR(290.00000000000, 232.00000000000) 
	ENDIF 
	IF ScreenElementExists id = chap_description 
		TerminateObjectsScripts id = chap_description use_proper_version 
		RunScriptOnScreenElement id = chap_description DoMorph params = { alpha = 1 time = 0.50000000000 } 
	ENDIF 
ENDSCRIPT

SCRIPT toggle_current_chapter 
	IF GotParam reverse 
		IF ( ( current_chapter - 1 ) > 0 ) 
			change current_chapter = ( current_chapter - 1 ) 
			update_chapter_menu left no_pad_back = <no_pad_back> 
		ENDIF 
	ELSE 
		GetArraySize CHAPTER_STATUS 
		IF ( <array_size> > current_chapter ) 
			IF ( CHAPTER_STATUS [ current_chapter ] > 0 ) 
				change current_chapter = ( current_chapter + 1 ) 
				update_chapter_menu right no_pad_back = <no_pad_back> 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT chapter_menu_start_goal 
	FireEvent type = unfocus target = chap_menu 
	IF GotParam goal_id 
		change check_for_unplugged_controllers = 0 
		chapter_menu_exit exit 
		change check_for_unplugged_controllers = 0 
		GoalManager_DeactivateAllGoals 
		SetSfxReverb 0 mode = REV_MODE_CAVE 
		goal_accept_trigger goal_id = <goal_id> force_start init 
	ENDIF 
ENDSCRIPT

SCRIPT chapter_menu_change_level_and_start_goal 
	killspawnedscript name = chap_moving_bg 
	killspawnedscript name = spawnscrip chap_new_rotating_bg 
	killspawnedscript name = spawnscrip chap_new_rotating_bg_2 
	killspawnedscript name = chap_graphic_crossfade 
	killspawnedscript name = fadetoblack 
	IF ScreenElementExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	IF ScreenElementExists id = fade_out_anchor 
		DestroyScreenElement id = fade_out_anchor 
	ENDIF 
	kill_blur start = 0 
	load_chapter_textures_to_main_memory unload 
	IF GotParam goal_id 
		array_name = change_level_goal_id 
		SetArrayElement ArrayName = array_name index = 0 newvalue = <goal_id> 
	ENDIF 
	GoalManager_DeactivateAllGoals 
	change_level level = <level> 
ENDSCRIPT

change_level_goal_id = [ null ] 
SCRIPT play_chap_sound 
	wait 12 gameframes 
	StopSound ChapterMenuFlyUpSound 
	wait 2 gameframes 
	PlaySound DE_PauseFlyIn id = ChapterMenuFlyUpSound pitch = 300 vol = 50 
ENDSCRIPT

SCRIPT chapter_dot_effect 
	FormatText ChecksumName = text_color "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = twitch_color "%i_TEXT_TWITCH_VALUE" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	BEGIN 
		IF NOT ScreenElementExists id = <id> 
			BREAK 
		ENDIF 
		DoScreenElementMorph id = <id> time = 0.02999999933 scale = 1.07500004768 relative_scale rgba = <twitch_color> alpha = 1 
		wait 2 gameframe 
		IF NOT ScreenElementExists id = <id> 
			BREAK 
		ENDIF 
		DoScreenElementMorph id = <id> time = 0.00999999978 scale = 1 relative_scale rgba = <text_color> alpha = 1 
		wait 0.23000000417 seconds 
	REPEAT 
ENDSCRIPT

SCRIPT chap_graphic_crossfade 
	BEGIN 
		DoScreenElementMorph id = chapter_graphic1 alpha = 0.15000000596 time = 3.00000000000 
		DoScreenElementMorph id = chapter_graphic2 alpha = 1.00000000000 time = 3.00000000000 
		wait 3 seconds 
		DoScreenElementMorph id = chapter_graphic1 alpha = 1.00000000000 time = 3.00000000000 
		DoScreenElementMorph id = chapter_graphic2 alpha = 0.40000000596 time = 4.00000000000 
		wait 3 seconds 
	REPEAT 
ENDSCRIPT

SCRIPT chap_moving_bg 
	GetScreenElementDims id = moving_bg 
	end_x = ( <width> - 640 ) 
	fade_in_x = ( <end_x> / 20 ) 
	scroll_x = ( <end_x> - <fade_in_x> ) 
	end_pos = ( <end_x> * PAIR(-1.00000000000, 0.00000000000) + PAIR(0.00000000000, 100.00000000000) ) 
	fade_in_pos = ( <fade_in_x> * PAIR(-1.00000000000, 0.00000000000) + PAIR(0.00000000000, 100.00000000000) ) 
	scroll_pos = ( <scroll_x> * PAIR(-1.00000000000, 0.00000000000) + PAIR(0.00000000000, 100.00000000000) ) 
	BEGIN 
		DoScreenElementMorph id = moving_bg alpha = 1 time = 0.50000000000 pos = <fade_in_pos> 
		wait 0.50000000000 seconds 
		DoScreenElementMorph id = moving_bg time = 9.00000000000 pos = <scroll_pos> 
		wait 8.50000000000 seconds 
		DoScreenElementMorph id = moving_bg alpha = 0 time = 0.50000000000 pos = <end_pos> 
		wait 0.50000000000 seconds 
		DoScreenElementMorph id = moving_bg pos = PAIR(0.00000000000, 100.00000000000) time = 0 
	REPEAT 
ENDSCRIPT

SCRIPT chap_new_rotating_bg id = rotating_bg_new time = 640.00000000000 alpha1 = 0.27500000596 alpha2 = 0.34999999404 scale = 2.00000000000 rot_angle = 5752 
	IF ScreenElementExists id = <id> 
		GetScreenElementDims id = <id> 
		DoScreenElementMorph id = <id> time = 0 rot_angle = 0 scale = <scale> 
		wait 1 gameframe 
		BEGIN 
			IF ScreenElementExists id = <id> 
				DoScreenElementMorph id = <id> alpha = <alpha2> time = ( <time> / 2 ) rot_angle = ( <rot_angle> / 2 ) scale = 1.12500000000 relative_scale 
				wait ( <time> / 2 ) seconds 
			ELSE 
				BREAK 
			ENDIF 
			IF ScreenElementExists id = <id> 
				DoScreenElementMorph id = <id> alpha = <alpha1> time = ( <time> / 2 ) rot_angle = <rot_angle> scale = 1.00000000000 relative_scale 
				wait ( <time> / 2 ) seconds 
			ELSE 
				BREAK 
			ENDIF 
		REPEAT 
	ENDIF 
ENDSCRIPT

SCRIPT chap_new_rotating_bg_2 time = 2000.00000000000 id = rotating_bg_new_2 alpha1 = 0.28000000119 alpha2 = 0.30000001192 scale = 2.20000004768 
	chap_new_rotating_bg <...> 
ENDSCRIPT

SCRIPT create_chapter_fade_piece 
	SetScreenElementLock off id = root_window 
	CreateScreenElement { 
		type = ContainerElement 
		parent = root_window 
		id = fade_out_anchor 
		pos = PAIR(320.00000000000, 240.00000000000) 
		dims = PAIR(640.00000000000, 480.00000000000) 
		alpha = 0 
	} 
	build_top_and_bottom_blocks static double parent = fade_out_anchor top_z = 1001 bot_z = 1001 
	CreateScreenElement { 
		type = SpriteElement 
		parent = fade_out_anchor 
		texture = white2 
		rgba = [ 0 0 0 40 ] 
		just = [ left top ] 
		pos = PAIR(0.00000000000, 0.00000000000) 
		scale = PAIR(84.00000000000, 60.00000000000) 
		z_priority = 1000 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = fade_out_anchor 
		texture = white2 
		rgba = [ 0 0 0 70 ] 
		just = [ left top ] 
		pos = PAIR(0.00000000000, 0.00000000000) 
		scale = PAIR(84.00000000000, 60.00000000000) 
		z_priority = 1010 
	} 
ENDSCRIPT

SCRIPT chapter_menu_get_status 
	status = 0 
	goal_id = ( <goal_info> . goal_id ) 
	GoalManager_GetCurrentChapterAndStage 
	IF ( <currentChapter> > ( current_chapter -1 ) ) 
		locked = 0 
	ELSE 
		IF ( <currentChapter> = ( current_chapter -1 ) ) 
			IF ( ( <currentStage> > <stage> ) | ( <currentStage> = <stage> ) ) 
				locked = 0 
			ELSE 
				locked = 1 
			ENDIF 
		ELSE 
			locked = 1 
		ENDIF 
	ENDIF 
	IF ( dont_lock_goals = 1 ) 
		locked = 0 
	ENDIF 
	IF GotParam goal_id 
		IF StructureContains final structure = <goal_info> 
			IF ( <locked> = 1 ) 
				<status> = 5 
			ELSE 
				IF GoalManager_HasWonGoal name = <goal_id> 
					<status> = 4 
				ELSE 
					<status> = 3 
				ENDIF 
			ENDIF 
		ELSE 
			IF ( <locked> = 1 ) 
				<status> = 2 
			ELSE 
				IF GoalManager_HasWonGoal name = <goal_id> 
					<status> = 1 
				ELSE 
					<status> = 0 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
	RETURN status = <status> 
ENDSCRIPT

SCRIPT create_chapter_intro_title chapter = 18 
	FormatText ChecksumName = rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	SetScreenElementLock off id = root_window 
	CreateScreenElement { 
		type = ContainerElement 
		parent = root_window 
		id = chapter_intro_title 
		pos = PAIR(320.00000000000, 320.00000000000) 
		alpha = 0 
	} 
	anchor_id = <id> 
	FormatText TextName = chapter_text "CHAPTER %i:" i = <chapter> 
	CreateScreenElement { 
		type = TextElement 
		parent = <anchor_id> 
		font = testtitle 
		pos = PAIR(0.00000000000, 0.00000000000) 
		scale = 1.50000000000 
		just = [ center center ] 
		text = <chapter_text> 
		rgba = [ 100 100 100 100 ] 
	} 
	GetScreenElementDims id = <id> 
	widest = <width> 
	CreateScreenElement { 
		type = TextElement 
		parent = <anchor_id> 
		font = testtitle 
		pos = PAIR(0.00000000000, 20.00000000000) 
		scale = 1.50000000000 
		just = [ center center ] 
		text = ( CHAPTER_TITLES [ ( <chapter> -1 ) ] ) 
		rgba = <rgba> 
	} 
	FormatText ChecksumName = bracket_texture "%i_sub_frame" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	GetScreenElementDims id = <id> 
	IF ( <width> > <widest> ) 
		widest = <width> 
	ENDIF 
	pos1 = ( ( <widest> / 2 ) * PAIR(1.00000000000, 0.00000000000) + PAIR(-10.00000000000, 5.00000000000) ) 
	pos2 = ( ( <widest> / 2 ) * PAIR(-1.00000000000, 0.00000000000) + PAIR(14.00000000000, 14.00000000000) ) 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <anchor_id> 
		texture = <bracket_texture> 
		pos = <pos1> 
		scale = PAIR(1.00000000000, 1.00000000000) 
		rot_angle = 180 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <anchor_id> 
		texture = <bracket_texture> 
		pos = <pos2> 
		scale = PAIR(1.00000000000, 1.00000000000) 
	} 
	DoScreenElementMorph id = chapter_intro_title alpha = 0.69999998808 time = 1.00000000000 
ENDSCRIPT

SCRIPT hide_chaper_intro_title 
	IF ObjectExists id = chapter_intro_title 
		DoScreenElementMorph id = chapter_intro_title time = 0 scale = 0 
	ENDIF 
ENDSCRIPT

SCRIPT unhide_chaper_intro_title 
	IF ObjectExists id = chapter_intro_title 
		DoScreenElementMorph id = chapter_intro_title time = 0 scale = 1 
	ENDIF 
ENDSCRIPT

SCRIPT kill_chapter_intro_title time = 1.00000000000 
	IF ScreenElementExists id = chapter_intro_title 
		DoScreenElementMorph id = chapter_intro_title alpha = 0 time = <time> 
		wait <time> seconds 
		DestroyScreenElement id = chapter_intro_title 
	ENDIF 
ENDSCRIPT

SCRIPT Chapter_menu_pad_Left_or_Right_Sound 
	PlaySound MenuUp 
ENDSCRIPT


