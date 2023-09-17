
skater_select_light0_heading = 60 
skater_select_light1_heading = -190 
SCRIPT PlayThrowBoardSound 
	IF NOT GotParam NoSFX 
		Wait 1.22000002861 second 
		PlaySound BoardThrowDown vol = 300 
	ENDIF 
ENDSCRIPT

SCRIPT TurnOnSSGuitar 
	DestroyAllSpecialItems 
	TurnOnSpecialItem specialitem_details = guitar_skateshop_details 
ENDSCRIPT

SCRIPT Play_HawkIdleSet 
	PlayAnim Anim = Idle_HawkFromStandIdle 
	WaitAnimFinished 
	PlayAnim Anim = Idle_Hawk 
	WaitAnimFinished 
	PlayAnim Anim = Idle_HawkDropBoard 
	WaitAnimFinished 
	PlayAnim Anim = Idle_HawkGetBoard 
	WaitAnimFinished 
	PlayAnim Anim = Idle_Hawk 
	WaitAnimFinished 
	PlayAnim Anim = Idle_Hawk 
	WaitAnimFinished 
	PlayAnim Anim = Idle_HawkToStandIdle 
	WaitAnimFinished 
	PlayAnim Anim = StandIdleA 
ENDSCRIPT

skater_rot_angle = 0 
SCRIPT skateshop_rotate_skater_left 
	IF InSplitScreenGame 
		GetCurrentSkaterProfileIndex 
		<skater> = <currentSkaterProfileIndex> 
	ELSE 
		<skater> = 0 
	ENDIF 
	KillSpawnedScript name = skateshop_rotate_skater 
	SpawnScript skateshop_rotate_skater params = { dif = -3 button = L1 } 
ENDSCRIPT

SCRIPT skateshop_rotate_skater_right 
	IF InSplitScreenGame 
		GetCurrentSkaterProfileIndex 
		<skater> = <currentSkaterProfileIndex> 
	ELSE 
		<skater> = 0 
	ENDIF 
	KillSpawnedScript name = skateshop_rotate_skater 
	SpawnScript skateshop_rotate_skater params = { dif = 3 button = R1 } 
ENDSCRIPT

SCRIPT skateshop_rotate_skater 
	BEGIN 
		IF ControllerPressed <button> 
			skater : CancelRotateDisplay 
			change skater_rot_angle = ( skater_rot_angle + <dif> ) 
			skater : RotateDisplay { Y 
				Duration = 0 seconds 
				EndAngle = skater_rot_angle 
				HoldOnLastAngle 
			} 
		ELSE 
			BREAK 
		ENDIF 
		Wait 1 frame 
	REPEAT 
ENDSCRIPT

SCRIPT wait_and_pause_skater time = 10 
	BEGIN 
		IF ObjectExists id = skater 
			Wait <time> gameframes 
			pauseskaters 
			PauseMusic 1 
			BREAK 
		ENDIF 
		Wait 1 gameframe 
	REPEAT 
	SetActiveCamera id = SkaterCam0 
	skater : Obj_GetID 
	MakeSkaterGoto ShadowSkaterFreestyleAI params = <...> 
	targetOffset = VECTOR(-65000.00000000000, 35.00000000000, 0.00000000000) 
	positionOffset = VECTOR(180.00000000000, 0.00000000000, 180.00000000000) 
	KillSkaterCamAnim all 
	PlaySkaterCamAnim { name = mainmenu_camera02 
		skater = 0 
		targetID = <objId> 
		targetOffset = <targetOffset> 
		positionOffset = <positionOffset> 
		play_hold 
		frames = 1 
	} 
ENDSCRIPT

SCRIPT SkateshopAI stopskateshopstreams = 1 
	IF levelis load_cas 
		no_board = no_board 
	ENDIF 
	SkaterInit NoEndRun ReturnControl NoAnims no_board = <no_board> 
	stream_repetition = 4 
	TurnOffSpecialItem 
	IF ( ( levelis load_boardshop ) | ( levelis load_cas ) ) 
		UnpausePhysics 
	ELSE 
		PausePhysics 
	ENDIF 
	ClearExceptions 
	SetQueueTricks NoTricks 
	DisablePlayerInput 
	SetRollingFriction 10000 
	GetCurrentSkaterProfileIndex 
	GetSkaterProfileInfo player = <currentSkaterProfileIndex> 
	SWITCH <name> 
		CASE creature 
		CASE Iron_Man 
		CASE Gene 
		DEFAULT 
			skater : unhide 
			TurnOffSpecialItem 
	ENDSWITCH 
	IF GotParam BlendOK 
		WaitAnimFinished 
	ELSE 
		BlendperiodOut 0 
	ENDIF 
	IF GotParam CAS_Screen 
		IF ( <is_male> = 1 ) 
			<name> = editskater_male 
			TurnOffSpecialItem 
		ELSE 
			SWITCH <name> 
				CASE steamer 
					printf "THIS IS ELISSA" 
					<name> = editskater_male 
				CASE jenna 
					<name> = jenna 
				DEFAULT 
					<name> = editskater_female 
					printf "THIS IS A CHICK" 
			ENDSWITCH 
		ENDIF 
	ELSE 
	ENDIF 
	IF GotParam Credits 
		<name> = neversoft 
	ENDIF 
	IF ( <name> = custom ) 
		IF ( <is_male> = 0 ) 
			<name> = editskater_female 
		ENDIF 
	ENDIF 
	printf "------------- THIS SKATER IS: %n" n = <name> 
	stream_freq = 0 
	stream_freq = RANDOM_RANGE PAIR(0.00000000000, 7.00000000000) 
	IF NOT ( <stream_repetition> > 3 ) 
		<stream_repetition> = ( <stream_repetition> + 1 ) 
	ENDIF 
	IF NOT levelis load_skateshop 
		RANDOM(1) 
		RANDOMCASE RANDOMEND PlayAnim Anim = Ped_M_Idle1 
		
	ELSE 
		IF ObjectExists id = ss_play_level 
			WaitAnimFinished 
			RANDOM(1) 
			RANDOMCASE RANDOMEND PlayAnim Anim = Ped_M_Idle1 
			
		ELSE 
			KillSpawnedScript name = wait_start_kill_ironman_dust 
			kill name = manhole_cover_smoke 
			kill name = Gene_Simmons_pyro 
			kill name = Gene_Simmons_pyro01 
			kill name = Iron_Man_Dust_1 
			SWITCH <name> 
				CASE creature 
					IF NOT ObjectExists id = manhole_cover_smoke 
						create name = manhole_cover_smoke 
					ENDIF 
					PlayAnim Anim = FrontEnd_Creature 
				CASE Iron_Man 
					KillSpawnedScript name = wait_start_kill_ironman_dust 
					SpawnScript wait_start_kill_ironman_dust 
					PlayAnim Anim = FrontEnd_IronMan 
				CASE Gene 
					IF NOT ObjectExists id = Gene_Simmons_pyro 
						create name = Gene_Simmons_pyro 
						create name = Gene_Simmons_pyro01 
					ENDIF 
					PlayAnim Anim = FrontEnd_Gene 
				DEFAULT 
					RANDOM(1, 1, 1, 1, 1) 
						RANDOMCASE PlayAnim Anim = Ped_M_Idle1 
						RANDOMCASE PlayAnim Anim = FrontEnd_1 
						RANDOMCASE PlayAnim Anim = FrontEnd_2 
						RANDOMCASE PlayAnim Anim = FrontEnd_3 
						RANDOMCASE PlayAnim Anim = FrontEnd_4 
					RANDOMEND 
			ENDSWITCH 
		ENDIF 
	ENDIF 
	GetTags 
	IF ( <stopskateshopstreams> = 0 ) 
		IF ( <stream_freq> = 1 ) 
			IF ( <stream_repetition> > 2 ) 
				StopStream 
				PlaySkaterStream Type = "SSIntro" 
				stream_repetition = 0 
			ENDIF 
		ENDIF 
	ELSE 
	ENDIF 
	WaitAnimFinished 
	BEGIN 
		Wait 1 frame 
		PlayAnim Anim = Ped_M_Idle1 
		WaitAnimFinished 
	REPEAT 
ENDSCRIPT

SCRIPT wait_start_kill_ironman_dust 
	Wait 1.45000004768 seconds 
	kill name = Iron_Man_Dust_1 
	create name = Iron_Man_Dust_1 
	Iron_Man_Dust_1 : SetLifetime 2.00000000000 
	Iron_Man_Dust_1 : SetEmitRate 100.00000000000 
	Wait 0.20000000298 seconds 
	kill name = Iron_Man_Dust_1 
	Wait 1 frame 
	create name = Iron_Man_Dust_1 
	Iron_Man_Dust_1 : SetEmitRate 90.00000000000 
	Wait 0.20000000298 seconds 
	kill name = Iron_Man_Dust_1 
	Wait 1 frame 
	create name = Iron_Man_Dust_1 
	Iron_Man_Dust_1 : SetEmitRate 80.00000000000 
	Wait 0.20000000298 seconds 
	kill name = Iron_Man_Dust_1 
	Wait 1 frame 
	create name = Iron_Man_Dust_1 
	Iron_Man_Dust_1 : SetEmitRate 60.00000000000 
	Iron_Man_Dust_1 : SetLifetime 1.00000000000 
	Wait 0.20000000298 seconds 
	kill name = Iron_Man_Dust_1 
	Wait 1 frame 
	create name = Iron_Man_Dust_1 
	Iron_Man_Dust_1 : SetEmitRate 40.00000000000 
	Iron_Man_Dust_1 : SetLifetime 1.00000000000 
	Wait 0.20000000298 seconds 
	kill name = Iron_Man_Dust_1 
	Wait 1 frame 
	create name = Iron_Man_Dust_1 
	Iron_Man_Dust_1 : SetEmitRate 20.00000000000 
	Iron_Man_Dust_1 : SetLifetime 1.00000000000 
	Wait 0.20000000298 seconds 
	kill name = Iron_Man_Dust_1 
	Wait 1 frame 
	create name = Iron_Man_Dust_1 
	Iron_Man_Dust_1 : SetEmitRate 10.00000000000 
	Iron_Man_Dust_1 : SetLifetime 1.00000000000 
	Wait 0.20000000298 seconds 
	kill name = Iron_Man_Dust_1 
	Wait 1 frame 
	create name = Iron_Man_Dust_1 
	Iron_Man_Dust_1 : SetEmitRate 5.00000000000 
	Iron_Man_Dust_1 : SetLifetime 0.40000000596 
	Wait 0.20000000298 seconds 
	kill name = Iron_Man_Dust_1 
	Wait 1 frame 
	create name = Iron_Man_Dust_1 
	Iron_Man_Dust_1 : SetEmitRate 2.00000000000 
	Iron_Man_Dust_1 : SetLifetime 0.20000000298 
	Wait 0.20000000298 seconds 
	kill name = Iron_Man_Dust_1 
ENDSCRIPT

SCRIPT skateshop_not_yet 
	launch_main_menu 
ENDSCRIPT

SCRIPT start_internet_game 
	memcard_menus_cleanup 
	InitPrefsBeenox 
	SetNetworkMode LAN_MODE 
	KillSkaterCamAnim all 
	PlaySkaterCamAnim name = SS_MenuCam play_hold 
	MakeSkaterGoto SkateshopAI params = { NoSFX } 
	SetMemThreadSafe off 
	KillSpawnedScript name = Skateshop_Slideshow 
	SpawnScript attract_mode_timer 
	SpawnSecondControllerCheck 
	Wait 5 gameframe 
	kill_start_key_binding 
	select_xbox_multiplayer { change_gamemode = change_gamemode_net } 
ENDSCRIPT

SCRIPT make_new_skateshop_menu 
	SetScreenElementProps { id = root_window 
		replace_handlers 
		event_handlers = [ 
			{ pad_start main_menu_start_pressed } 
		] 
	} 
	make_new_menu <...> 
ENDSCRIPT

SCRIPT main_menu_start_pressed 
ENDSCRIPT

SCRIPT skateshop_transition menu_anim = animate_out 
	RunScriptOnScreenElement id = current_menu_anchor <menu_anim> callback = skateshop_transition2 callback_params = <...> 
ENDSCRIPT

SCRIPT skateshop_transition2 
	IF GotParam cam_anim 
		printf "got a cam_anim" 
		PlaySkaterCamAnim skater = 0 name = <cam_anim> 
	ENDIF 
	IF GotParam came_from_main_menu 
		<new_menu_script> came_from_main_menu 
	ELSE 
		<new_menu_script> 
	ENDIF 
ENDSCRIPT

SCRIPT main_menu_add_item { parent = current_menu 
		font = small 
		highlight_bar_scale = PAIR(2.00000000000, 0.69999998808) 
		highlight_bar_pos = PAIR(97.00000000000, -7.00000000000) 
		text_just = [ center center ] 
		focus_script = main_menu_focus 
		unfocus_script = main_menu_unfocus 
		text_pos = PAIR(95.00000000000, -5.00000000000) 
		dims = PAIR(200.00000000000, 20.00000000000) 
		pad_choose_script = nullscript 
	} 
	IF GotParam not_focusable 
		CreateScreenElement { 
			Type = ContainerElement 
			parent = <parent> 
			id = <id> 
			dims = <dims> 
			event_handlers = [ { focus <focus_script> params = <focus_params> } 
				{ unfocus <unfocus_script> params = <unfocus_params> } 
				{ pad_choose <pad_choose_script> params = <pad_choose_params> } 
				{ pad_start <pad_choose_script> params = <pad_choose_params> } 
			] 
			replace_handlers 
			not_focusable 
		} 
	ELSE 
		CreateScreenElement { 
			Type = ContainerElement 
			parent = <parent> 
			id = <id> 
			dims = <dims> 
			event_handlers = [ { focus <focus_script> params = <focus_params> } 
				{ unfocus <unfocus_script> params = <unfocus_params> } 
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
	IF GotParam not_focusable 
		text_rgba = [ 60 60 60 75 ] 
		CreateScreenElement { 
			Type = TextElement 
			parent = <anchor_id> 
			font = <font> 
			text = <text> 
			scale = <scale> 
			pos = <text_pos> 
			just = <text_just> 
			rgba = <text_rgba> 
			not_focusable 
		} 
	ELSE 
		FormatText ChecksumName = text_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
		CreateScreenElement { 
			Type = TextElement 
			parent = <anchor_id> 
			id = <text_id> 
			font = <font> 
			text = <text> 
			scale = <scale> 
			pos = <text_pos> 
			just = <text_just> 
			rgba = <text_rgba> 
		} 
	ENDIF 
	IF GotParam max_width 
		truncate_string id = <id> max_width = <max_width> 
	ENDIF 
	FormatText ChecksumName = bar_rgba "%i_HIGHLIGHT_BAR_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	CreateScreenElement { 
		Type = SpriteElement 
		parent = <anchor_id> 
		texture = de_highlight_bar 
		pos = <highlight_bar_pos> 
		scale = <highlight_bar_scale> 
		just = [ center center ] 
		rgba = <bar_rgba> 
		alpha = 0 
		z_priority = 3 
	} 
ENDSCRIPT

SCRIPT make_main_menu_item { 
		focus_script = main_menu_item_focus 
		dims = PAIR(300.00000000000, 18.00000000000) 
	} 
	make_theme_menu_item <...> no_highlight_bar 
ENDSCRIPT

SCRIPT main_menu_item_focus 
	GetTags 
	IF GotParam attract_timer 
		reset_attract_mode_timer 
	ENDIF 
	theme_item_focus <...> 
ENDSCRIPT

SCRIPT main_menu_focus 
	GetTags 
	FormatText ChecksumName = text_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	DoScreenElementMorph id = { <id> child = 0 } rgba = <text_rgba> 
	RunScriptOnScreenElement id = <id> text_twitch_effect 
	IF ObjectExists id = park_menu_up_arrow 
		generic_menu_update_arrows { 
			up_arrow_id = park_menu_up_arrow 
			down_arrow_id = park_menu_down_arrow 
		} 
	ENDIF 
	IF GotParam attract_timer 
		reset_attract_mode_timer 
	ENDIF 
	DoScreenElementMorph { 
		id = { <id> child = 1 } 
		alpha = 1 
	} 
ENDSCRIPT

SCRIPT main_menu_unfocus 
	GetTags 
	FormatText ChecksumName = text_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	DoScreenElementMorph id = { <id> child = 0 } rgba = <text_rgba> 
	KillSpawnedScript name = text_twitch_effect 
	DoScreenElementMorph { 
		id = { <id> child = 1 } 
		alpha = 0 
	} 
ENDSCRIPT

launch_to_createatrick = 0 
SCRIPT system_link_main_menu_exit 
	IF SystemLinkEnabled 
		main_menu_exit <...> 
	ENDIF 
ENDSCRIPT

SCRIPT main_menu_exit 
	IF NOT GotParam hold_camera 
		skater : reset_model_lights 
		skater : PausePhysics 
		skater : CancelRotateDisplay 
		play_no_skater_cam 
	ENDIF 
	KillSpawnedScript name = attract_mode_timer 
	StopSecondControllerCheck 
	IF GotParam kill_clouds 
		IF ObjectExists id = cloud_anchor 
			DestroyScreenElement id = cloud_anchor 
		ENDIF 
	ENDIF 
	IF GotParam set_cat_mode_flag 
		change launch_to_createatrick = 1 
	ELSE 
		change launch_to_createatrick = 0 
	ENDIF 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	IF GotParam new_menu_script 
		<new_menu_script> <...> 
	ENDIF 
ENDSCRIPT

SCRIPT play_no_skater_cam 
	KillSkaterCamAnim all 
	PlaySkaterCamAnim skater = 0 name = mainmenu_camera03 play_hold 
ENDSCRIPT

SCRIPT hide_the_skater 
	BEGIN 
		IF LocalSkaterExists 
			Wait 0.12500000000 second 
			play_no_skater_cam 
			BREAK 
		ENDIF 
		Wait 1 frame 
	REPEAT 
ENDSCRIPT

SCRIPT make_mainmenu_3d_plane id = bg_plane parent = current_menu_anchor z_priority = -500 model = "UI_bg\\UI_bg.mdl" scale = PAIR(2.09999990463, 2.20000004768) pos = PAIR(320.00000000000, 225.00000000000) 
	IF ScreenElementExists id = <id> 
		DestroyScreenElement id = <id> 
	ENDIF 
	IF GetGlobalFlag flag = SCREEN_MODE_WIDE 
		scale = ( <scale> . PAIR(1.00000000000, 0.00000000000) * PAIR(1.33299994469, 0.00000000000) + <scale> . PAIR(0.00000000000, 1.00000000000) * PAIR(0.00000000000, 1.00000000000) ) 
	ENDIF 
	IF ScreenElementExists id = <parent> 
		SetScreenElementLock off id = <parent> 
		CreateScreenElement { 
			parent = <parent> 
			Type = Element3d 
			id = <id> 
			model = <model> 
			TexDictOffset = 20 
			pos = <pos> 
			CameraZ = <z_priority> 
			scale = <scale> 
			Tilt = 0 
		} 
	ELSE 
		printf "make_mainmenu_3d_plane: parent %p doesn\'t exist" p = <parent> 
	ENDIF 
ENDSCRIPT

current_attract_movie = 0 
SCRIPT attract_mode_timer 
	max_time = 30 
	BEGIN 
		Wait <max_time> seconds 
	REPEAT 
ENDSCRIPT

SCRIPT reset_attract_mode_timer 
	KillSpawnedScript name = attract_mode_timer 
	SpawnScript attract_mode_timer 
ENDSCRIPT

in_options_menu = 0 
SCRIPT check_cheat_from_keyboard 
	GetTextElementString id = keyboard_current_string 
	IF NOT GotParam cancel 
		TryCheatString string = <string> 
	ENDIF 
	destroy_onscreen_keyboard 
	create_setup_options_menu 
ENDSCRIPT

SCRIPT launch_career_options_menu 
	RunScriptOnScreenElement id = current_menu_anchor menu_offscreen callback = create_career_options_menu 
ENDSCRIPT

SCRIPT create_career_options_menu 
	dialog_box_exit 
	pulse_blur speed = 2 start = 255 
	IF GotParam change_gamemode 
		<change_gamemode> 
	ENDIF 
	make_new_menu { 
		pos = PAIR(120.00000000000, 100.00000000000) 
		internal_just = [ center center ] 
		menu_id = career_options_menu 
		vmenu_id = career_options_vmenu 
		menu_title = "" 
		helper_text = generic_helper_text 
	} 
	FormatText ChecksumName = title_icon "%i_career_ops" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	build_theme_sub_title title_icon = <title_icon> title = "STORY OPTIONS" 
	build_top_and_bottom_blocks 
	make_mainmenu_3d_plane model = "mainmenu_bg\\mainmenu_bg.mdl" scale = PAIR(1.25000000000, 1.25000000000) pos = PAIR(360.00000000000, 217.00000000000) 
	CreateScreenElement { 
		Type = SpriteElement 
		parent = current_menu_anchor 
		id = mm_building 
		texture = mm_building 
		just = [ left top ] 
		pos = PAIR(0.00000000000, 62.00000000000) 
		scale = PAIR(1.20000004768, 1.25000000000) 
		z_priority = -3 
		alpha = 1 
	} 
	make_mainmenu_clouds 
	kill_start_key_binding 
	SetScreenElementProps { id = career_options_vmenu event_handlers = [ 
			{ pad_back generic_menu_pad_back params = { callback = career_options_menu_exit new_menu_script = create_main_menu } } 
		] 
	} 
	FormatText ChecksumName = bracket_texture "%i_sub_frame" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	IF NOT cd 
		make_main_menu_item { text = #"Level Select" 
			id = ss_play_level 
			pad_choose_script = career_options_menu_exit 
			pad_choose_params = { new_menu_script = launch_level_select_menu kill_all } 
		} 
	ENDIF 
	IF GetGlobalFlag flag = CAREER_STARTED 
		GoalManager_GetCurrentChapterAndStage 
		IF NOT ( ( <currentChapter> = 9 ) | ( <currentChapter> = 24 ) | ( <currentChapter> = 25 ) ) 
			level = ( ( CHAPTER_LEVELS [ <currentChapter> ] ) . checksum ) 
		ELSE 
			level = load_nj 
		ENDIF 
		make_main_menu_item { text = #"Continue Story" 
			pad_choose_script = career_options_menu_exit 
			pad_choose_params = { new_menu_script = story_options_change_level level = <level> kill_all continue_story } 
		} 
		make_main_menu_item { text = #"Start New Story" 
			pad_choose_script = career_overwrite_warning 
			pad_choose_params = { title = #"Create New" } 
		} 
		make_main_menu_item { text = #"Load Story" 
			pad_choose_script = career_overwrite_warning 
			pad_choose_params = { title = #"Load Story" pad_choose_script = launch_career_menu_load_game_sequence } 
		} 
	ELSE 
		make_main_menu_item { text = #"Continue Story" 
			pad_choose_script = null_script 
			not_focusable = not_focusable 
		} 
		make_main_menu_item { text = #"Start New Story" 
			pad_choose_script = career_options_menu_exit 
			pad_choose_params = { new_menu_script = create_career_difficulty_menu level = load_cas kill_all } 
		} 
		make_main_menu_item { text = #"Load Story" 
			pad_choose_script = career_options_menu_exit 
			pad_choose_params = { new_menu_script = launch_career_menu_load_game_sequence from_career } 
		} 
	ENDIF 
	IF cd 
		GetStackedScreenElementPos Y id = <id> offset = PAIR(180.00000000000, 0.00000000000) 
	ELSE 
		GetStackedScreenElementPos Y id = <id> offset = PAIR(180.00000000000, 20.00000000000) 
	ENDIF 
	FireEvent Type = focus target = current_menu_anchor 
	IF GotParam from_skater_select 
		SpawnScript shadow_skater_script2 params = { make_it_safe } 
	ENDIF 
ENDSCRIPT

SCRIPT career_options_menu_exit 
	dialog_box_exit 
	IF NOT GotParam from_ss_menu 
		IF GotParam kill_all 
			IF ScreenElementExists id = cloud_anchor 
				DestroyScreenElement id = cloud_anchor 
			ENDIF 
			skater : reset_model_lights 
		ENDIF 
		IF ObjectExists id = current_menu_anchor 
			DestroyScreenElement id = current_menu_anchor 
		ENDIF 
		<new_menu_script> <...> continue_shadow_skater_ai 
	ELSE 
		<new_menu_script> <...> 
	ENDIF 
ENDSCRIPT

SCRIPT new_career_launch_select_skater_menu 
	GoalManager_ResetCareer 
	launch_select_skater_menu 
ENDSCRIPT

SCRIPT career_overwrite_warning title = #"Overwrite" pad_choose_script = pre_cas_menu_exit 
	FireEvent Type = unfocus target = current_menu_anchor 
	DoScreenElementMorph id = career_options_vmenu alpha = 0 time = 0.10000000149 
	create_snazzy_dialog_box { 
		title = <title> 
		text = #"Warning !\\nAny unsaved changes to your current STORY/SKATER will be lost.\\n\\nNote: items unlocked from beating the game will not be lost\\nContinue ?" text_dims = PAIR(400.00000000000, 0.00000000000) 
		no_bg 
		pad_back_script = cancel_new_career 
		buttons = [ { font = small text = #"No" pad_choose_script = cancel_new_career } 
			{ font = small text = #"Yes" 
				pad_choose_script = <pad_choose_script> 
				pad_choose_params = 
				{ 
					new_menu_script = reset_career 
				} 
			} 
		] 
	} 
ENDSCRIPT

SCRIPT cancel_new_career 
	dialog_box_exit 
	DoScreenElementMorph id = career_options_vmenu alpha = 1 time = 0.10000000149 
	FireEvent Type = focus target = current_menu_anchor 
	SetScreenElementLock id = current_menu_anchor off 
	create_helper_text generic_helper_text 
ENDSCRIPT

SCRIPT reset_career 
	IF GetGlobalFlag flag = CAREER_STARTED 
		ResetToDefaultProfile name = custom 
		load_pro_skater name = custom 
	ENDIF 
	CareerReset 
	GoalManager_ResetCareer 
	<status_array> = CHAPTER_STATUS 
	SetArrayElement ArrayName = status_array Index = 0 NewValue = 1 
	GetArraySize <status_array> 
	<array_size> = ( <array_size> - 1 ) 
	<Index> = 1 
	BEGIN 
		SetArrayElement ArrayName = status_array Index = <Index> NewValue = 0 
		<Index> = ( <Index> + 1 ) 
	REPEAT <array_size> 
	GoalManager_KillTeamMembers 
	IF GetGlobalFlag flag = SCREEN_MODE_WIDE 
		stay_wide = 1 
	ENDIF 
	UnSetGlobalFlag flag = GOT_ALL_GOALS 
	Index = 0 
	BEGIN 
		IF ArrayContains array = CLEAR_GLOBAL_FLAGS contains = <Index> 
			IF NOT GetGlobalFlag flag = GAME_COMPLETED_TOO_EASY 
				IF NOT GetGlobalFlag flag = GAME_COMPLETED_BEGINNER 
					IF NOT GetGlobalFlag flag = GAME_COMPLETED_NORMAL 
						IF NOT GetGlobalFlag flag = GAME_COMPLETED_SICK 
							UnSetGlobalFlag flag = <Index> 
						ENDIF 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
		<Index> = ( <Index> + 1 ) 
	REPEAT 512 
	IF GotParam stay_wide 
		SetGlobalFlag flag = SCREEN_MODE_WIDE 
	ENDIF 
	<level_flag> = 128 
	BEGIN 
		<level> = 1 
		BEGIN 
			UnSetFlag flag = <level_flag> level = <level> 
			<level> = ( <level> + 1 ) 
		REPEAT 9 
		<level_flag> = ( <level_flag> + 1 ) 
	REPEAT 8 
	SetGlobalFlag flag = LEVEL_UNLOCKED_SCH 
	reset_secret_skaters 
	unlock_initial_boards 
	UnSetGlobalFlag flag = CAREER_STARTED 
	create_career_difficulty_menu 
ENDSCRIPT

SCRIPT reset_secret_skaters 
	SetSkaterProfileInfoByName name = eddie params = { is_hidden = 1 } 
	SetSkaterProfileInfoByName name = jango params = { is_hidden = 1 } 
	SetSkaterProfileInfoByName name = vallely params = { is_hidden = 1 } 
	SetSkaterProfileInfoByName name = jenna params = { is_hidden = 1 } 
ENDSCRIPT

SCRIPT create_career_difficulty_menu 
	dialog_box_exit 
	IF NOT GotParam from_ss_menu 
		load_pro_skater name = custom 
		unpauseskaters 
		KillSpawnedScript Type = shadow_skater_script2 
		SpawnScript shadow_skater_script2 params = { make_it_safe launched = <launched> } 
	ENDIF 
	make_new_menu { 
		pos = PAIR(120.00000000000, 100.00000000000) 
		internal_just = [ center center ] 
		menu_id = career_dif_menu 
		vmenu_id = career_dif_vmenu 
		menu_title = "" 
		helper_text = generic_helper_text 
	} 
	FormatText ChecksumName = title_icon "%i_career_ops" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	IF NOT GotParam from_ss_menu 
		build_theme_sub_title title_icon = <title_icon> title = "DIFFICULTY" 
	ELSE 
		build_theme_sub_title title_icon = <title_icon> title = "DIFFICULTY" pos = PAIR(-255.00000000000, 73.00000000000) static 
	ENDIF 
	build_top_and_bottom_blocks 
	IF NOT GotParam from_ss_menu 
		make_mainmenu_3d_plane model = "mainmenu_bg\\mainmenu_bg.mdl" pos = PAIR(360.00000000000, 217.00000000000) scale = PAIR(1.25000000000, 1.25000000000) 
		CreateScreenElement { 
			Type = SpriteElement 
			parent = current_menu_anchor 
			id = mm_building 
			texture = mm_building 
			just = [ left top ] 
			pos = PAIR(0.00000000000, 62.00000000000) 
			scale = PAIR(1.20000004768, 1.25000000000) 
			z_priority = -3 
			alpha = 1 
		} 
		make_mainmenu_clouds 
	ELSE 
		CreateScreenElement { 
			Type = SpriteElement 
			parent = current_menu_anchor 
			id = mm_building 
			texture = ss_sidewall 
			just = [ center center ] 
			pos = PAIR(-40.00000000000, 195.00000000000) 
			scale = PAIR(2.00000000000, 1.79999995232) 
			z_priority = -3 
			alpha = 1 
		} 
	ENDIF 
	kill_start_key_binding 
	IF NOT GotParam from_ss_menu 
		SetScreenElementProps { id = career_dif_vmenu event_handlers = [ 
				{ pad_back generic_menu_pad_back params = { callback = career_options_menu_exit new_menu_script = create_career_options_menu } } 
			] 
		} 
	ELSE 
		SetScreenElementProps { id = career_dif_vmenu event_handlers = [ 
				{ pad_back generic_menu_pad_back params = { callback = launch_ss_menu no_animate } } 
			] 
		} 
	ENDIF 
	FormatText ChecksumName = bracket_texture "%i_sub_frame" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	make_main_menu_item { text = #"Too Easy" 
		pad_choose_script = career_options_menu_exit 
		pad_choose_params = { new_menu_script = set_career_difficulty dif = -1 from_ss_menu = <from_ss_menu> } 
	} 
	SetScreenElementProps { 
		id = { current_menu child = 1 } 
		event_handlers = [ 
			{ focus difficulty_menu_item_focus params = { description = "Easy physics and fewer bails for first time Tony Hawk players" } } 
			{ unfocus difficulty_menu_item_unfocus } 
		] 
		replace_handlers 
	} 
	make_main_menu_item { text = #"Beginner" 
		pad_choose_script = career_options_menu_exit 
		pad_choose_params = { new_menu_script = set_career_difficulty dif = 0 from_ss_menu = <from_ss_menu> } 
	} 
	SetScreenElementProps { 
		id = { current_menu child = 2 } 
		event_handlers = [ 
			{ focus difficulty_menu_item_focus params = { description = "Less difficult goals for those fairly new to the Tony Hawk series" } } 
			{ unfocus difficulty_menu_item_unfocus } 
		] 
		replace_handlers 
	} 
	make_main_menu_item { text = #"Normal" 
		pad_choose_script = career_options_menu_exit 
		pad_choose_params = { new_menu_script = set_career_difficulty dif = 1 from_ss_menu = <from_ss_menu> } 
	} 
	SetScreenElementProps { 
		id = { current_menu child = 3 } 
		event_handlers = [ 
			{ focus difficulty_menu_item_focus params = { description = "Challenging goals for the average to good Tony Hawk player" } } 
			{ unfocus difficulty_menu_item_unfocus } 
		] 
		replace_handlers 
	} 
	IF NOT GotParam from_ss_menu 
		make_main_menu_item { text = #"Sick" 
			pad_choose_script = career_options_menu_exit 
			pad_choose_params = { new_menu_script = set_career_difficulty dif = 2 from_ss_menu = <from_ss_menu> } 
		} 
		SetScreenElementProps { 
			id = { current_menu child = 4 } 
			event_handlers = [ 
				{ focus difficulty_menu_item_focus params = { description = "For hardcore veterans who have mastered the Tony Hawk games" } } 
				{ unfocus difficulty_menu_item_unfocus } 
			] 
			replace_handlers 
		} 
	ENDIF 
	FormatText ChecksumName = bar_color "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = text_color "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	CreateScreenElement { 
		Type = ContainerElement 
		parent = current_menu_anchor 
		id = diff_desc_box 
		internal_just = [ center top ] 
		just = [ center center ] 
		pos = PAIR(320.00000000000, 320.00000000000) 
		just = [ center top ] 
	} 
	CreateScreenElement { 
		Type = SpriteElement 
		parent = diff_desc_box 
		texture = black 
		scale = PAIR(70.00000000000, 15.00000000000) 
		just = [ center top ] 
		rgba = [ 0 0 0 90 ] 
	} 
	CreateScreenElement { 
		Type = textBlockElement 
		parent = diff_desc_box 
		id = diff_desc_bg_text 
		text = "" 
		font = small 
		pos = PAIR(0.00000000000, 6.00000000000) 
		dims = PAIR(250.00000000000, 0.00000000000) 
		line_spacing = 0.60000002384 
		just = [ center center ] 
		rgba = [ 80 80 80 50 ] 
		not_focusable 
		allow_expansion 
	} 
	CreateScreenElement { 
		Type = SpriteElement 
		parent = diff_desc_box 
		texture = white 
		scale = PAIR(70.00000000000, 1.00000000000) 
		z_priority = 10 
		just = [ center top ] 
		rgba = <bar_color> 
	} 
	FireEvent Type = focus target = current_menu_anchor 
	change disable_menu_sounds = 1 
	IF GotParam from_ss_menu 
		GoalManager_GetDifficultyLevel 
		FireEvent Type = pad_down target = current_menu 
		IF NOT GetGlobalFlag flag = DIFFICULTY_MODE_TOO_EASY 
			FireEvent Type = pad_down target = current_menu 
			IF ( <difficulty_level> > 0 ) 
				FireEvent Type = pad_down target = current_menu 
			ENDIF 
		ENDIF 
		DoScreenElementMorph id = submenu_title_anchor time = 0.00000000000 pos = PAIR(-255.00000000000, 53.00000000000) 
		DoScreenElementMorph id = submenu_title_anchor time = 0.20000000298 pos = PAIR(55.00000000000, 53.00000000000) 
		DoScreenElementMorph id = current_menu time = 0.00000000000 pos = PAIR(120.00000000000, 412.00000000000) 
		DoScreenElementMorph id = current_menu time = 0.20000000298 pos = PAIR(120.00000000000, 100.00000000000) 
	ELSE 
		FireEvent Type = pad_down target = current_menu 
		FireEvent Type = pad_down target = current_menu 
		FireEvent Type = pad_down target = current_menu 
	ENDIF 
	change disable_menu_sounds = 0 
	DoScreenElementMorph id = diff_desc_box time = 0 pos = PAIR(315.00000000000, 520.00000000000) 
	DoScreenElementMorph id = diff_desc_box time = 0.20000000298 pos = PAIR(315.00000000000, 310.00000000000) 
	IF NOT GotParam from_ss_menu 
		ShadowSkaterOptionsTricks 
		MakeSkaterGoto ShadowSkaterAI 
	ENDIF 
ENDSCRIPT

SCRIPT difficulty_menu_item_focus 
	GetTags 
	SetScreenElementProps id = diff_desc_bg_text text = <description> 
	theme_item_focus 
ENDSCRIPT

SCRIPT difficulty_menu_item_unfocus 
	GetTags 
	IF ScreenElementExists id = { <id> child = 1 } 
		DestroyScreenElement id = { <id> child = 1 } 
	ENDIF 
	IF ScreenElementExists id = { <id> child = 2 } 
		DestroyScreenElement id = { <id> child = 2 } 
	ENDIF 
	theme_item_unfocus 
ENDSCRIPT

SCRIPT set_career_difficulty 
	IF ( <dif> = -1 ) 
		SetGlobalFlag flag = DIFFICULTY_MODE_TOO_EASY 
		GetGameMode 
		SWITCH <GameMode> 
			CASE career 
				SetGlobalFlag flag = DIFFICULTY_MODE_TOO_EASY_STORY 
			CASE freeskate 
				IF InSplitScreenGame 
					SetGlobalFlag flag = DIFFICULTY_MODE_TOO_EASY_2P 
				ENDIF 
			CASE creategoals 
				SetGlobalFlag flag = DIFFICULTY_MODE_TOO_EASY_CAG 
			CASE singlesession 
				SetGlobalFlag flag = DIFFICULTY_MODE_TOO_EASY_FREESKATE 
		ENDSWITCH 
		<dif> = 0 
	ELSE 
		UnSetGlobalFlag flag = DIFFICULTY_MODE_TOO_EASY 
		GetGameMode 
		SWITCH <GameMode> 
			CASE career 
				UnSetGlobalFlag flag = DIFFICULTY_MODE_TOO_EASY_STORY 
			CASE freeskate 
				IF InSplitScreenGame 
					UnSetGlobalFlag flag = DIFFICULTY_MODE_TOO_EASY_2P 
				ENDIF 
			CASE creategoals 
				UnSetGlobalFlag flag = DIFFICULTY_MODE_TOO_EASY_CAG 
			CASE singlesession 
				UnSetGlobalFlag flag = DIFFICULTY_MODE_TOO_EASY_FREESKATE 
		ENDSWITCH 
	ENDIF 
	GoalManager_SetDifficultyLevel <dif> 
	IF GotParam set_flag 
		SetGlobalFlag flag = <flag> 
	ENDIF 
	IF NOT GotParam from_ss_menu 
		skater : StatsManager_ReInit 
		ResetAllToDefaultStats 
		ResetDeck 
		skater : remove_skater_from_world 
		maybe_reset_theme 
		change check_for_unplugged_controllers = 0 
		career_options_menu_exit { new_menu_script = story_options_change_level level = load_cas kill_all } 
	ELSE 
		launch_ss_menu no_animate 
	ENDIF 
ENDSCRIPT

SCRIPT ResetDeck 
	GetCurrentSkaterProfileIndex 
	EditPlayerAppearance { 
		profile = <currentSkaterProfileIndex> 
		target = SetPart 
		targetParams = { part = deck_layer1 desc_id = None } 
	} 
	EditPlayerAppearance { 
		profile = <currentSkaterProfileIndex> 
		target = SetPart 
		targetParams = { part = deck_layer2 desc_id = None } 
	} 
	EditPlayerAppearance { 
		profile = <currentSkaterProfileIndex> 
		target = SetPart 
		targetParams = { part = deck_layer3 desc_id = None } 
	} 
	EditPlayerAppearance { 
		profile = <currentSkaterProfileIndex> 
		target = SetPart 
		targetParams = { part = deck_layer4 desc_id = None } 
	} 
	EditPlayerAppearance { 
		profile = <currentSkaterProfileIndex> 
		target = SetPart 
		targetParams = { part = deck_layer5 desc_id = None } 
	} 
	EditPlayerAppearance { 
		profile = <currentSkaterProfileIndex> 
		target = SetPart 
		targetParams = { part = cad_graphic desc_id = None } 
	} 
	GetPlayerAppearancePart { 
		profile = <currentSkaterProfileIndex> 
		player = 0 
		part = board 
	} 
	SetPlayerAppearanceColor player = <currentSkaterProfileIndex> part = board h = 0 s = 0 v = 0 use_default_hsv = 1 
	EditPlayerAppearance { 
		profile = <currentSkaterProfileIndex> 
		target = SetPart 
		targetParams = { part = board desc_id = Default } 
	} 
	RefreshSkaterModel skater = 0 profile = <currentSkaterProfileIndex> 
ENDSCRIPT

SCRIPT story_options_change_level 
	dialog_box_exit 
	IF GotParam continue_story 
		load_pro_skater name = custom 
	ENDIF 
	GetGameMode 
	SWITCH <GameMode> 
		CASE career 
			IF GetGlobalFlag flag = DIFFICULTY_MODE_TOO_EASY_STORY 
				SetGlobalFlag flag = DIFFICULTY_MODE_TOO_EASY 
			ELSE 
				UnSetGlobalFlag flag = DIFFICULTY_MODE_TOO_EASY 
			ENDIF 
		CASE freeskate 
			IF InSplitScreenGame 
				IF GetGlobalFlag flag = DIFFICULTY_MODE_TOO_EASY_2P 
					SetGlobalFlag flag = DIFFICULTY_MODE_TOO_EASY 
				ELSE 
					UnSetGlobalFlag flag = DIFFICULTY_MODE_TOO_EASY 
				ENDIF 
			ENDIF 
		CASE creategoals 
			IF GetGlobalFlag flag = DIFFICULTY_MODE_TOO_EASY_CAG 
				SetGlobalFlag flag = DIFFICULTY_MODE_TOO_EASY 
			ELSE 
				UnSetGlobalFlag flag = DIFFICULTY_MODE_TOO_EASY 
			ENDIF 
		CASE singlesession 
			IF GetGlobalFlag flag = DIFFICULTY_MODE_TOO_EASY_FREESKATE 
				SetGlobalFlag flag = DIFFICULTY_MODE_TOO_EASY 
			ELSE 
				UnSetGlobalFlag flag = DIFFICULTY_MODE_TOO_EASY_FREESKATE 
			ENDIF 
	ENDSWITCH 
	load_mainmenu_textures_to_main_memory unload 
	printstruct <...> 
	IF ( ( <level> = load_cas ) | ( GotParam continue_story ) ) 
		select_skater_get_current_skater_name 
		IF NOT ( <current_skater> = custom ) 
			load_pro_skater { profile = 0 skater = 0 name = custom } 
		ENDIF 
		IF ( <level> = load_cas ) 
			change in_cinematic_sequence = 1 
			SetGameType freeskate 
			SetCurrentGameType 
		ENDIF 
	ENDIF 
	restore_start_key_binding 
	change_level level = <level> 
ENDSCRIPT

SCRIPT create_select_goals_menu 
	memcard_menus_cleanup 
	ResetAbortAndDoneScripts 
	skater : unhide 
	IF GotParam change_gamemode 
		<change_gamemode> 
	ENDIF 
	make_new_menu { 
		pos = PAIR(120.00000000000, 100.00000000000) 
		internal_just = [ center center ] 
		menu_id = select_goals_menu 
		vmenu_id = select_goals_vmenu 
		menu_title = "" 
		helper_text = generic_helper_text 
	} 
	FormatText ChecksumName = title_icon "%i_sound" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	build_theme_sub_title title_icon = <title_icon> title = "SELECT GOALS" 
	build_top_and_bottom_blocks 
	make_mainmenu_3d_plane model = "mainmenu_bg\\mainmenu_bg.mdl" scale = PAIR(1.25000000000, 1.25000000000) pos = PAIR(360.00000000000, 217.00000000000) 
	CreateScreenElement { 
		Type = SpriteElement 
		parent = current_menu_anchor 
		id = mm_building 
		texture = mm_building 
		just = [ left top ] 
		pos = PAIR(0.00000000000, 62.00000000000) 
		scale = PAIR(1.20000004768, 1.25000000000) 
		z_priority = -3 
		alpha = 1 
	} 
	make_mainmenu_clouds 
	kill_start_key_binding 
	SetScreenElementProps { id = select_goals_vmenu event_handlers = [ 
			{ pad_back generic_menu_pad_back params = { callback = select_goals_menu_exit new_menu_script = create_main_menu } } 
		] 
	} 
	GoalEditor : GetNumEditedGoals 
	IF ( <NumGoals> = 0 ) 
		text = #"Create New Goals" 
	ELSE 
		text = #"Play Current Goals" 
	ENDIF 
	make_main_menu_item { text = <text> 
		pad_choose_script = select_goals_menu_exit 
		pad_choose_params = { new_menu_script = launch_select_skater_menu } 
	} 
	make_main_menu_item { text = #"Load Goals" 
		pad_choose_script = select_goals_menu_exit 
		pad_choose_params = { new_menu_script = prompt_launch_cag_menu_load } 
	} 
	IF ( <NumGoals> > 0 ) 
		make_main_menu_item { text = #"Nuke All Goals" 
			pad_choose_script = select_goals_menu_exit 
			pad_choose_params = { new_menu_script = prompt_nuke_goals } 
		} 
	ENDIF 
	FireEvent Type = focus target = current_menu_anchor 
	IF GotParam from_skater_select 
		SpawnScript shadow_skater_script2 params = { make_it_safe } 
	ENDIF 
ENDSCRIPT

SCRIPT prompt_launch_cag_menu_load 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	skater : hide 
	create_dialog_box { title = "Load Goals" 
		text = #"Warning !\\nAny unsaved changes to your current CREATED GOALS will be lost.\\nContinue ?" 
		pos = PAIR(320.00000000000, 240.00000000000) 
		text_dims = PAIR(400.00000000000, 0.00000000000) 
		just = [ center center ] 
		text_rgba = [ 88 105 112 128 ] 
		text_scale = 1 
		buttons = [ { font = small text = "Yes" pad_choose_script = launch_load_created_goals_from_select_goals_menu } 
			{ font = small text = "No" pad_choose_script = no_launch_cag_menu_load } 
		] 
	} 
ENDSCRIPT

SCRIPT no_launch_cag_menu_load 
	dialog_box_exit 
	skater : unhide 
	create_select_goals_menu 
ENDSCRIPT

SCRIPT prompt_nuke_goals 
	skater : hide 
	menu_confirm_quit back_script = nuke_goals_deny no_script = nuke_goals_deny yes_script = nuke_goals_confirm title = "CLEAR GOALS?" 
ENDSCRIPT

SCRIPT nuke_goals_confirm 
	dialog_box_exit 
	select_goals_menu_exit new_menu_script = nuke_all_goals 
ENDSCRIPT

SCRIPT nuke_goals_deny 
	dialog_box_exit 
	create_select_goals_menu 
ENDSCRIPT

SCRIPT select_goals_menu_exit 
	dialog_box_exit 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
		Wait 1 frame 
	ENDIF 
	<new_menu_script> <...> continue_shadow_skater_ai 
ENDSCRIPT

SCRIPT nuke_all_goals 
	GoalEditor : NukeAllGoals 
	create_select_goals_menu 
ENDSCRIPT

SCRIPT launch_ss_menu 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
		Wait 1 frame 
	ENDIF 
	create_ss_menu <...> 
ENDSCRIPT

SCRIPT create_ss_menu 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	skater : add_skater_to_world 
	skater : BlendperiodOut 0.00000000000 
	IF GotParam change_gamemode 
		<change_gamemode> 
	ENDIF 
	GetGameMode 
	SWITCH <GameMode> 
		CASE career 
			IF GetGlobalFlag flag = DIFFICULTY_MODE_TOO_EASY_STORY 
				SetGlobalFlag flag = DIFFICULTY_MODE_TOO_EASY 
			ELSE 
				UnSetGlobalFlag flag = DIFFICULTY_MODE_TOO_EASY 
			ENDIF 
		CASE freeskate 
			IF InSplitScreenGame 
				IF GetGlobalFlag flag = DIFFICULTY_MODE_TOO_EASY_2P 
					SetGlobalFlag flag = DIFFICULTY_MODE_TOO_EASY 
				ELSE 
					UnSetGlobalFlag flag = DIFFICULTY_MODE_TOO_EASY 
				ENDIF 
			ENDIF 
		CASE creategoals 
			IF GetGlobalFlag flag = DIFFICULTY_MODE_TOO_EASY_CAG 
				SetGlobalFlag flag = DIFFICULTY_MODE_TOO_EASY 
			ELSE 
				UnSetGlobalFlag flag = DIFFICULTY_MODE_TOO_EASY 
			ENDIF 
		CASE singlesession 
			IF GetGlobalFlag flag = DIFFICULTY_MODE_TOO_EASY_FREESKATE 
				SetGlobalFlag flag = DIFFICULTY_MODE_TOO_EASY 
			ELSE 
				UnSetGlobalFlag flag = DIFFICULTY_MODE_TOO_EASY_FREESKATE 
			ENDIF 
	ENDSWITCH 
	FormatText ChecksumName = title_icon "%i_career_ops" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	GetCurrentSkaterProfileIndex 
	GetGameMode 
	SWITCH <GameMode> 
		CASE career 
			<menu_title> = #"CAREER" 
		CASE freeskate 
			IF InSplitScreenGame 
				FormatText ChecksumName = title_icon "%i_2_player" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
				MakeSkaterGoto SkateshopAI params = { BlendOK } 
				IF ( <currentSkaterProfileIndex> = 1 ) 
					<menu_title> = #"PLAYER TWO" 
				ELSE 
					<menu_title> = #"PLAYER ONE" 
				ENDIF 
			ELSE 
				<menu_title> = #"FREE SKATE" 
			ENDIF 
		CASE net 
			FormatText ChecksumName = title_icon "%i_online" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
			IF isxbox 
				IF ( network_connection_type = internet ) 
					<menu_title> = #"THUG ONLINE" 
				ELSE 
					<menu_title> = #"NETWORK PLAY" 
				ENDIF 
			ELSE 
				<menu_title> = #"THUG ONLINE" 
			ENDIF 
		CASE singlesession 
			<menu_title> = #"SINGLE SESSION" 
		CASE creategoals 
			FormatText ChecksumName = title_icon "%i_sound" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
			<menu_title> = #"CREATE GOALS" 
		DEFAULT 
			<menu_title> = #"SKATESHOP" 
	ENDSWITCH 
	IF GameModeEquals is_net 
		IF isxbox 
			IF ( network_connection_type = internet ) 
				<menu_title> = #"THUG ONLINE" 
			ELSE 
				<menu_title> = #"NETWORK PLAY" 
			ENDIF 
		ELSE 
			<menu_title> = #"THUG ONLINE" 
		ENDIF 
	ENDIF 
	IF ( launch_to_createatrick = 1 ) 
		<menu_title> = #"CREATE TRICKS" 
	ENDIF 
	make_new_menu { 
		pos = PAIR(120.00000000000, 100.00000000000) 
		internal_just = [ center center ] 
		menu_id = ss_menu 
		vmenu_id = ss_vmenu 
		menu_title = "" 
		helper_text = generic_helper_text 
	} 
	build_theme_sub_title title_icon = <title_icon> title = <menu_title> pos = PAIR(-255.00000000000, 73.00000000000) static 
	build_top_and_bottom_blocks 
	make_mainmenu_3d_plane model = "mainmenu_bg\\mainmenu_bg.mdl" scale = PAIR(1.25000000000, 1.25000000000) pos = PAIR(360.00000000000, 217.00000000000) 
	CreateScreenElement { 
		Type = SpriteElement 
		parent = current_menu_anchor 
		id = mm_building 
		texture = ss_sidewall 
		just = [ center center ] 
		pos = PAIR(158.00000000000, 218.00000000000) 
		scale = PAIR(1.20000004768, 1.25000000000) 
		z_priority = -3 
		alpha = 1 
	} 
	make_mainmenu_clouds 
	create_helper_text = generic_helper_text 
	kill_start_key_binding 
	SetScreenElementProps { 
		id = ss_vmenu 
		event_handlers = [ { pad_back generic_menu_pad_back params = { callback = ss_menu_exit new_menu_script = launch_select_skater_menu } animate_in = 1 } ] 
		replace_handlers 
	} 
	GetCurrentSkaterProfileIndex 
	IF InSplitScreenGame 
		IF ( <currentSkaterProfileIndex> = 1 ) 
			make_main_menu_item { text = #"Ready" 
				id = ss_play_level 
				pad_choose_script = ss_menu_exit 
				pad_choose_params = { new_menu_script = launch_level_select_menu player_two } 
			} 
		ELSE 
			make_main_menu_item { text = #"Ready" 
				id = ss_play_level 
				pad_choose_script = ss_menu_exit 
				pad_choose_params = { new_menu_script = player_1_ready } 
			} 
		ENDIF 
	ELSE 
		IF GameModeEquals is_net 
			IF IsInternetGameHost 
				make_main_menu_item { text = #"Ready" 
					id = ss_play_level 
					pad_choose_script = ss_menu_exit 
					pad_choose_params = { new_menu_script = create_network_select_games_menu play_cam } 
				} 
			ELSE 
				IF ( network_connection_type = internet ) 
					make_main_menu_item { text = #"Ready" 
						id = ss_play_level 
						pad_choose_script = ss_menu_exit 
						pad_choose_params = { new_menu_script = chose_internet } 
					} 
				ELSE 
					make_main_menu_item { text = #"Ready" 
						id = ss_play_level 
						pad_choose_script = ss_menu_exit 
						pad_choose_params = { new_menu_script = launch_network_select_lan_games_menu } 
					} 
				ENDIF 
			ENDIF 
		ELSE 
			RemoveParameter callback 
			make_main_menu_item { text = #"Play Level" 
				id = ss_play_level 
				pad_choose_script = ss_menu_exit 
				pad_choose_params = { new_menu_script = launch_level_select_menu <...> } 
			} 
		ENDIF 
	ENDIF 
	make_main_menu_item { text = #"Edit Tricks" 
		pad_choose_script = ss_menu_exit 
		pad_choose_params = { new_menu_script = create_edit_tricks_menu from_ss_menu hide_bg = 1 } 
	} 
	IF ( ( GameModeEquals is_creategoals ) | ( GameModeEquals is_singlesession ) ) 
		make_main_menu_item { text = #"Difficulty" 
			pad_choose_script = ss_menu_exit 
			pad_choose_params = { new_menu_script = create_career_difficulty_menu from_ss_menu = 1 } 
		} 
	ENDIF 
	IF InSplitScreenGame 
		IF ( <currentSkaterProfileIndex> = 0 ) 
			make_main_menu_item { text = #"Difficulty" 
				pad_choose_script = ss_menu_exit 
				pad_choose_params = { new_menu_script = create_career_difficulty_menu from_ss_menu = 1 } 
			} 
		ENDIF 
	ENDIF 
	IF GameModeEquals is_net 
		IF isps2 
			GetPreferenceChecksum pref_type = network device_type 
			SWITCH <checksum> 
				CASE device_none 
				CASE device_sony_modem 
				CASE device_usb_modem 
					can_lan = 0 
					SetNetworkMode INTERNET_MODE 
					change network_connection_type = internet 
				DEFAULT 
					can_lan = 1 
			ENDSWITCH 
			IF ( <can_lan> = 1 ) 
				IF ( network_connection_type = internet ) 
					ui_string = "internet" 
				ELSE 
					ui_string = "lan" 
				ENDIF 
				make_main_menu_item { text = "Connection:" 
					id = menu_connection 
					pad_choose_script = toggle_net_connection_type 
					pad_choose_params = { new_menu_script = <new_menu_script> } 
				} 
				CreateScreenElement { 
					Type = ContainerElement 
					parent = menu_connection 
				} 
				CreateScreenElement { 
					Type = TextElement 
					parent = menu_connection 
					id = connection_type_string 
					text = <ui_string> 
					font = small 
					rgba = [ 60 60 60 100 ] 
					scale = 1 
					pos = PAIR(200.00000000000, -3.00000000000) 
					just = [ left top ] 
					z_priority = 5 
				} 
			ENDIF 
			IF IsOnline 
				GetPreferenceChecksum pref_type = network device_type 
				SWITCH <checksum> 
					CASE device_sony_modem 
					CASE device_usb_modem 
						make_main_menu_item { 
							text = "Hang Up Modem" 
							id = menu_network_select_hang_up 
							pad_choose_script = disconnect_from_internet 
						} 
				ENDSWITCH 
			ENDIF 
		ENDIF 
		GetPreferenceString pref_type = network network_id 
		make_main_menu_item { text = #"Player Name:" 
			id = menu_player_name 
			pad_choose_script = ss_menu_exit 
			pad_choose_params = { new_menu_script = launch_onscreen_keyboard_from_ss_menu 
				field = "network_id" 
				text = <ui_string> 
				title = "PLAYER NAME" 
				min_length = 1 
				max_length = 15 
				highlight_bar_scale = PAIR(1.39999997616, 1.29999995232) 
			} 
		} 
		CreateScreenElement { 
			Type = ContainerElement 
			parent = menu_player_name 
		} 
		CreateScreenElement { 
			Type = TextElement 
			parent = menu_player_name 
			id = network_option_player_name_string 
			text = <ui_string> 
			font = small 
			rgba = [ 60 60 60 100 ] 
			scale = 1 
			pos = PAIR(200.00000000000, -3.00000000000) 
			just = [ left top ] 
			z_priority = 5 
		} 
	ENDIF 
	MakeSkaterGoto SkaterSelectAI 
	MakeSkaterGoto SkateshopAI 
	DoScreenElementMorph id = mm_building time = 0.04699999839 scale = PAIR(2.00000000000, 1.79999995232) pos = PAIR(-40.00000000000, 195.00000000000) 
	IF NOT GotParam no_animate 
		KillSkaterCamAnim all 
		PlaySkaterCamAnim skater = 0 name = skater_select_cam play_hold 
	ELSE 
		KillSkaterCamAnim all 
		PlaySkaterCamAnim skater = 0 name = stationary_skater_cam play_hold 
	ENDIF 
	FireEvent Type = focus target = current_menu_anchor 
	DoScreenElementMorph id = submenu_title_anchor time = 0.00000000000 pos = PAIR(-255.00000000000, 53.00000000000) 
	DoScreenElementMorph id = submenu_title_anchor time = 0.20000000298 pos = PAIR(55.00000000000, 53.00000000000) 
	IF GameModeEquals is_net 
		DoScreenElementMorph id = current_menu time = 0.00000000000 pos = PAIR(-20.00000000000, 412.00000000000) 
		DoScreenElementMorph id = current_menu time = 0.20000000298 pos = PAIR(-20.00000000000, 100.00000000000) 
	ELSE 
		DoScreenElementMorph id = current_menu time = 0.00000000000 pos = PAIR(120.00000000000, 412.00000000000) 
		DoScreenElementMorph id = current_menu time = 0.20000000298 pos = PAIR(120.00000000000, 100.00000000000) 
	ENDIF 
ENDSCRIPT

network_connection_type = internet 
SCRIPT toggle_net_connection_type 
	GetCurrentSkaterProfileIndex 
	GetGameMode 
	SWITCH network_connection_type 
		CASE lan 
			SetNetworkMode INTERNET_MODE 
			change network_connection_type = internet 
			SetScreenElementProps id = connection_type_string text = "internet" 
		CASE internet 
			SetNetworkMode LAN_MODE 
			change network_connection_type = lan 
			SetScreenElementProps id = connection_type_string text = "lan" 
	ENDSWITCH 
	IF InSplitScreenGame 
		IF ( <currentSkaterProfileIndex> = 1 ) 
			SetScreenElementProps { 
				id = ss_play_level 
				event_handlers = [ { pad_choose ss_menu_exit params = { new_menu_script = launch_level_select_menu player_two } } ] 
				replace_handlers 
			} 
		ELSE 
			SetScreenElementProps { 
				id = ss_play_level 
				event_handlers = [ { pad_choose ss_menu_exit params = { new_menu_script = player_1_ready } } ] 
				replace_handlers 
			} 
		ENDIF 
	ELSE 
		IF GameModeEquals is_net 
			IF isxbox 
				SetScreenElementProps { 
					id = ss_play_level 
					event_handlers = [ { pad_choose ss_menu_exit params = { new_menu_script = create_network_select_games_menu play_cam } } ] 
					replace_handlers 
				} 
			ELSE 
				IF ( network_connection_type = internet ) 
					SetScreenElementProps { 
						id = ss_play_level 
						event_handlers = [ { pad_choose ss_menu_exit params = { new_menu_script = chose_internet } } ] 
						replace_handlers 
					} 
				ELSE 
					SetScreenElementProps { 
						id = ss_play_level 
						event_handlers = [ { pad_choose ss_menu_exit params = { new_menu_script = launch_network_select_lan_games_menu } } ] 
						replace_handlers 
					} 
				ENDIF 
			ENDIF 
		ELSE 
			SetScreenElementProps { 
				id = ss_play_level 
				event_handlers = [ { pad_choose ss_menu_exit params = { new_menu_script = launch_level_select_menu <...> } } ] 
				replace_handlers 
			} 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT player_1_ready 
	load_second_skater_profile 
	MakeSkaterGoto SkateshopAI params = { } 
	launch_select_skater_menu 
ENDSCRIPT

SCRIPT ss_menu_exit 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	IF GotParam hide_bg 
		play_no_skater_cam 
	ENDIF 
	IF GotParam new_menu_script 
		<new_menu_script> <...> animate_in = 1 
	ENDIF 
	IF OnXbox 
		IF GameModeEquals is_net 
			IF ( <new_menu_script> = launch_select_skater_menu ) 
				SetNetworkMode 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT launch_select_skater_menu 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	IF levelis load_skateshop 
		IF ( goto_secret_shop = 2 ) 
			Wait 1 gameframe 
			change goto_secret_shop = 0 
		ENDIF 
		IF NOT GotParam From2p 
		ELSE 
			printf "GOTPARAM FROM 2p" 
		ENDIF 
	ENDIF 
	GetCurrentSkaterProfileIndex 
	IF ( <currentSkaterProfileIndex> = 1 ) 
		SetMenuPadMappings [ active 
			use_as_first 
		] 
	ELSE 
		printf "Resetting skater profile number" 
		SetCurrentSkaterProfile 0 
		RefreshSkaterModel profile = 0 skater = 0 
		IF levelis load_skateshop 
		ENDIF 
		SetMenuPadMappings [ active 
			use_as_first 
		] 
	ENDIF 
	GoalManager_HidePoints 
	GoalManager_HideGoalPoints 
	create_select_skater_menu <...> 
ENDSCRIPT

SCRIPT create_select_skater_menu 
	kill_blur 
	MakeSkaterGoto SkaterSelectAI 
	MakeSkaterGoto SkateshopAI params = { BlendOK } 
	KillSkaterCamAnim all 
	PlaySkaterCamAnim skater = 0 name = skater_select_cam01 play_hold 
	ResetComboRecords 
	IF GotParam change_gamemode 
		<change_gamemode> 
	ENDIF 
	SetScreenElementLock id = root_window off 
	CreateScreenElement { 
		Type = ContainerElement 
		parent = root_window 
		id = select_skater_anchor 
		pos = PAIR(320.00000000000, 240.00000000000) 
		dims = PAIR(640.00000000000, 480.00000000000) 
	} 
	AssignAlias id = select_skater_anchor alias = current_menu_anchor 
	build_top_and_bottom_blocks 
	FormatText ChecksumName = main_icon "%i_mainicon" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	CreateScreenElement { 
		Type = SpriteElement 
		parent = current_menu_anchor 
		id = mm_icon 
		texture = <main_icon> 
		just = [ center center ] 
		pos = PAIR(62.00000000000, 80.00000000000) 
		scale = PAIR(2.00000000000, 2.00000000000) 
		rot_angle = -10 
		z_priority = 2 
		alpha = 0.69999998808 
	} 
	CreateScreenElement { 
		Type = SpriteElement 
		parent = current_menu_anchor 
		id = mm_building 
		texture = ss_sidewall 
		just = [ left top ] 
		pos = PAIR(0.00000000000, 52.00000000000) 
		scale = PAIR(1.20000004768, 1.25000000000) 
		z_priority = -3 
		alpha = 1 
	} 
	create_helper_text { helper_text_elements = [ { text = "\\b6/\\b5=Select" } 
			{ text = "\\bm=Accept" } 
			{ text = "\\bn=Back" } 
			{ text = "\\bo=Load Skater" } 
		] 
	} 
	root_pos = PAIR(22.00000000000, 60.00000000000) 
	pos = <root_pos> 
	select_skater_create_top_bar root_pos = <root_pos> create_dots <...> 
	kill_start_key_binding 
	IF ObjectExists id = stats_block_anchor_parent 
		DestroyScreenElement id = stats_block_anchor_parent 
	ENDIF 
	CreateScreenElement { 
		Type = ContainerElement 
		parent = select_skater_anchor 
		id = stats_block_anchor_parent 
		pos = PAIR(-40.00000000000, 445.00000000000) 
		just = [ left top ] 
		dims = PAIR(640.00000000000, 480.00000000000) 
		scale = 1.00000000000 
	} 
	stats_menu_create_stats_block parent = stats_block_anchor_parent not_focusable on = on pos = PAIR(0.00000000000, 0.00000000000) scale = 0.85000002384 
	DoScreenElementMorph id = stats_block_anchor_parent time = 0.50000000000 pos = PAIR(-40.00000000000, 20.00000000000) 
	AssignAlias id = select_skater_hmenu alias = current_menu 
	Wait 2 gameframes 
	SetScreenElementProps id = select_skater_scrolling_hmenu reset_window 
	select_skater_get_current_skater_name 
	AssignAlias id = select_skater_hmenu alias = current_menu 
	FireEvent Type = focus target = select_skater_hmenu data = { child_id = <current_skater> } 
	skater : SetTags stopskateshopstreams = 0 
	IF GotParam animate_in 
		KillSkaterCamAnim all 
		PlaySkaterCamAnim skater = 0 name = skater_select_cam02 play_hold 
		DoScreenElementMorph id = mm_building time = 0.00000000000 scale = PAIR(2.00000000000, 1.79999995232) pos = PAIR(-40.00000000000, 195.00000000000) 
		DoScreenElementMorph id = mm_building time = 0.03999999911 scale = PAIR(1.20000004768, 1.25000000000) pos = PAIR(0.00000000000, 54.00000000000) 
	ELSE 
	ENDIF 
ENDSCRIPT

SCRIPT SkaterSelectAI stopskateshopstreams = 1 
	SkaterInit NoEndRun ReturnControl NoAnims 
	Obj_SetLightAmbientColor r = 53 g = 50 b = 60 
	Obj_SetLightDiffuseColor Index = 0 r = 100 g = 115 b = 145 
	Obj_SetLightDiffuseColor Index = 1 r = 5 g = 3 b = 5 
	Obj_SetLightDirection Index = 0 heading = skater_select_light0_heading pitch = 350 
	Obj_SetLightDirection Index = 1 heading = skater_select_light1_heading pitch = 270 
	SetLightDirection Index = 0 heading = skater_select_light0_heading pitch = 350 
	SetLightDirection Index = 1 heading = skater_select_light1_heading pitch = 270 
	stream_repetition = 4 
	TurnOffSpecialItem 
	SwitchOffBoard 
	ClearExceptions 
	SetQueueTricks NoTricks 
	DisablePlayerInput 
	SetRollingFriction 10000 
	Obj_MoveToNode name = SS_player_restart Orient NoReset 
	PausePhysics 
ENDSCRIPT

SCRIPT reset_model_lights 
	IF Obj_HasModelLights 
		Obj_DisableAmbientLight 
		Obj_DisableDiffuseLight Index = 0 
		Obj_DisableDiffuseLight Index = 1 
	ELSE 
		printf "No model lights to reset" 
	ENDIF 
ENDSCRIPT

SCRIPT select_skater_menu_fire_focus 
	printf "select_skater_menu_fire_focus" 
	Wait 1 frame 
	select_skater_get_current_skater_name 
	FireEvent Type = focus target = select_skater_hmenu data = { child_id = <current_skater> } 
	printf "select_skater_menu_fire_focus done" 
ENDSCRIPT

SCRIPT select_skater_create_top_bar scale = PAIR(1.13999998569, 1.00000000000) text = "" parent = select_skater_anchor 
	CreateScreenElement { 
		Type = ContainerElement 
		parent = <parent> 
		id = select_skater_top_anchor 
		pos = PAIR(320.00000000000, 242.00000000000) 
		dims = PAIR(640.00000000000, 480.00000000000) 
	} 
	CreateScreenElement { 
		Type = TextElement 
		parent = select_skater_top_anchor 
		id = select_skater_name 
		text = <text> 
		font = testtitle 
		pos = PAIR(-330.00000000000, 90.00000000000) 
		scale = 1.62999999523 
		just = [ center top ] 
	} 
	CreateScreenElement { 
		Type = TextElement 
		parent = select_skater_top_anchor 
		id = select_skater_name_2 
		text = <text> 
		font = testtitle 
		pos = PAIR(-330.00000000000, 92.00000000000) 
		scale = 1.67999994755 
		rgba = [ 6 25 32 60 ] 
		just = [ center top ] 
	} 
	IF GotParam create_dots 
		CreateScreenElement { 
			Type = HScrollingMenu 
			parent = select_skater_top_anchor 
			id = select_skater_scrolling_hmenu 
			pos = PAIR(320.00000000000, -260.00000000000) 
			dims = PAIR(534.00000000000, 74.00000000000) 
		} 
		CreateScreenElement { 
			Type = HMenu 
			parent = select_skater_scrolling_hmenu 
			id = select_skater_hmenu 
			pos = PAIR(0.00000000000, 10.00000000000) 
			just = [ center top ] 
			internal_just = [ center top ] 
			padding_scale = 0.85000002384 
		} 
		AssignAlias id = select_skater_hmenu alias = current_menu 
		ForEachSkaterProfile do = select_skater_menu_add_hmenu_items params = { root_pos = <root_pos> <...> } 
		GetCurrentSkaterProfileIndex 
		IF levelis load_skateshop 
			IF ( <currentSkaterProfileIndex> = 1 ) 
				SetScreenElementProps { 
					id = select_skater_hmenu 
					event_handlers = [ 
						{ pad_back generic_menu_pad_back_sound } 
						{ pad_back select_skater_menu_back params = { callback = back_from_player_two_select } } 
						{ pad_option ss_overwrite_warning params = { } } 
						{ pad_option generic_menu_pad_choose_sound } 
					] 
					replace_handlers 
				} 
				SetScreenElementProps { 
					id = select_skater_hmenu 
					event_handlers = [ { pad_left generic_menu_scroll_sideways_sound } 
						{ pad_right generic_menu_scroll_sideways_sound } 
						{ pad_left menu_horiz_blink_arrow params = { arrow_id = select_skater_left_arrow } } 
						{ pad_right menu_horiz_blink_arrow params = { arrow_id = select_skater_right_arrow } } 
					] 
				} 
			ELSE 
				SetScreenElementProps { 
					id = select_skater_hmenu 
					event_handlers = [ { pad_back generic_menu_pad_back_sound } 
						{ pad_back select_skater_menu_back params = { callback = create_main_menu } } 
						{ pad_option ss_overwrite_warning params = { } } 
						{ pad_option generic_menu_pad_choose_sound } 
					] 
					replace_handlers 
				} 
				IF GameModeEquals is_career 
					IF NOT GameModeEquals is_net 
						SetScreenElementProps { 
							id = select_skater_hmenu 
							event_handlers = [ { pad_back generic_menu_pad_back_sound } 
								{ pad_back select_skater_menu_back params = { callback = create_career_options_menu } } 
								{ pad_option ss_overwrite_warning params = { } } 
								{ pad_option generic_menu_pad_choose_sound } 
							] 
							replace_handlers 
						} 
					ENDIF 
				ENDIF 
				SetScreenElementProps { 
					id = select_skater_hmenu 
					event_handlers = [ { pad_left generic_menu_scroll_sideways_sound } 
						{ pad_right generic_menu_scroll_sideways_sound } 
						{ pad_left menu_horiz_blink_arrow params = { arrow_id = select_skater_left_arrow } } 
						{ pad_right menu_horiz_blink_arrow params = { arrow_id = select_skater_right_arrow } } 
					] 
				} 
			ENDIF 
		ELSE 
			SetScreenElementProps { 
				id = select_skater_hmenu 
				event_handlers = [ { pad_back select_skater_menu_back params = { callback = create_options_menu } } ] 
				replace_handlers 
			} 
		ENDIF 
	ENDIF 
	CreateScreenElement { 
		Type = SpriteElement 
		parent = select_skater_top_anchor 
		id = select_skater_left_arrow 
		texture = left_arrow 
		pos = PAIR(40.00000000000, 30.00000000000) 
		just = [ right top ] 
		z_priority = 6 
	} 
	CreateScreenElement { 
		Type = SpriteElement 
		parent = select_skater_top_anchor 
		id = select_skater_right_arrow 
		texture = right_arrow 
		pos = PAIR(600.00000000000, 30.00000000000) 
		just = [ left top ] 
		z_priority = 6 
	} 
	CreateScreenElement { 
		Type = ContainerElement 
		id = piece_slider_container 
		parent = select_skater_top_anchor 
		just = [ left top ] 
		pos = PAIR(40.00000000000, -340.00000000000) 
	} 
	FormatText ChecksumName = on_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	CreateScreenElement { 
		Type = SpriteElement 
		id = piece_slider_orange 
		parent = piece_slider_container 
		dims = PAIR(4.00000000000, 4.00000000000) 
		scale = PAIR(27.00000000000, 1.39999997616) 
		rgba = <on_rgba> 
		alpha = 1.00000000000 
		just = [ left top ] 
		z_priority = 5 
	} 
	CreateScreenElement { 
		Type = SpriteElement 
		id = piece_slider_gray 
		parent = piece_slider_container 
		dims = PAIR(4.00000000000, 4.00000000000) 
		scale = PAIR(140.00000000000, 2.29999995232) 
		rgba = [ 60 60 60 58 ] 
		alpha = 1.00000000000 
		just = [ left top ] 
		z_priority = 4 
	} 
	DoScreenElementMorph id = select_skater_name_2 time = 0.30000001192 pos = PAIR(230.00000000000, 92.00000000000) 
	DoScreenElementMorph id = select_skater_name time = 0.30000001192 pos = PAIR(230.00000000000, 102.00000000000) 
	DoScreenElementMorph id = select_skater_scrolling_hmenu time = 0.50000000000 pos = PAIR(320.00000000000, 50.00000000000) 
	DoScreenElementMorph id = piece_slider_container time = 0.50000000000 pos = PAIR(40.00000000000, 15.00000000000) 
ENDSCRIPT

SCRIPT ss_overwrite_warning title = #"Load Skater" callback = cas_reset_skater_and_goto_menu 
	FireEvent Type = unfocus target = select_skater_hmenu 
	create_snazzy_dialog_box { 
		title = <title> 
		text = #"Warning !\\nAny unsaved changes to your current STORY/SKATER will be lost.\\nContinue ?" 
		text_dims = PAIR(400.00000000000, 0.00000000000) 
		pad_back_script = generic_menu_pad_back 
		pad_back_params = { callback = ss_cancel_load_skater } 
		buttons = [ 
			{ font = small text = #"No" pad_choose_script = ss_cancel_load_skater } 
			{ 
				font = small text = #"Yes" 
				pad_choose_script = launch_load_cas_from_select_sequence 
				pad_choose_params = 
				{ 
				} 
			} 
		] 
	} 
ENDSCRIPT

SCRIPT ss_cancel_load_skater 
	dialog_box_exit 
	build_top_and_bottom_blocks 
	create_helper_text { helper_text_elements = [ { text = "\\b6/\\b5=Select" } 
			{ text = "\\bm=Accept" } 
			{ text = "\\bn=Back" } 
			{ text = "\\bo=Load Skater" } 
		] 
	} 
	FireEvent Type = focus target = select_skater_hmenu 
ENDSCRIPT

SCRIPT menu_horiz_blink_arrow 
	TerminateObjectsScripts id = <arrow_id> 
	RunScriptOnScreenElement id = <arrow_id> menu_blink_arrow 
ENDSCRIPT

SCRIPT back_from_player_two_select 
	SetCurrentSkaterProfile 0 
	RefreshSkaterModel profile = 0 skater = 0 
	launch_select_skater_menu From2p 
ENDSCRIPT

SCRIPT select_skater_menu_add_hmenu_items 
	rgba = [ 50 50 50 108 ] 
	IF ( <is_pro> = 1 ) 
		IF GotParam is_secret 
			IF NOT GetGlobalFlag flag = ( <unlock_flag> + 0 ) 
				RETURN 
			ELSE 
				FormatText ChecksumName = headshot "SS_%n" n = <first_name> 
				CreateScreenElement { 
					Type = SpriteElement 
					parent = select_skater_hmenu 
					id = <name> 
					texture = <headshot> 
					scale = 0.85000002384 
					rgba = <rgba> 
					event_handlers = [ { focus select_skater_hmenu_focus params = <...> } 
						{ unfocus select_skater_hmenu_unfocus } 
						{ pad_choose select_skater_hmenu_choose params = <...> } 
						{ pad_start select_skater_hmenu_choose params = <...> } 
						{ pad_choose generic_menu_pad_choose_sound } 
						{ pad_start generic_menu_pad_choose_sound } 
					] 
				} 
			ENDIF 
		ELSE 
			FormatText ChecksumName = headshot "SS_%n" n = <first_name> 
			CreateScreenElement { 
				Type = SpriteElement 
				parent = select_skater_hmenu 
				id = <name> 
				texture = <headshot> 
				scale = 0.85000002384 
				rgba = <rgba> 
				event_handlers = [ { focus select_skater_hmenu_focus params = <...> } 
					{ unfocus select_skater_hmenu_unfocus } 
					{ pad_choose select_skater_hmenu_choose params = <...> } 
					{ pad_start select_skater_hmenu_choose params = <...> } 
					{ pad_choose generic_menu_pad_choose_sound } 
					{ pad_start generic_menu_pad_choose_sound } 
				] 
			} 
		ENDIF 
	ELSE 
		IF ( <name> = custom ) 
			CreateScreenElement { 
				Type = SpriteElement 
				parent = select_skater_hmenu 
				id = <name> 
				texture = ss_cas 
				scale = 0.85000002384 
				rgba = <rgba> 
				event_handlers = [ { focus select_skater_hmenu_focus params = <...> } 
					{ unfocus select_skater_hmenu_unfocus } 
					{ pad_choose select_skater_hmenu_choose params = <...> } 
					{ pad_start select_skater_hmenu_choose params = <...> } 
					{ pad_choose generic_menu_pad_choose_sound } 
					{ pad_start generic_menu_pad_choose_sound } 
				] 
			} 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT get_current_skater_display_name 
	GetCurrentSkaterProfileIndex 
	GetSkaterProfileInfo player = <currentSkaterProfileIndex> 
	RETURN display_name = <display_name> 
ENDSCRIPT

SCRIPT select_skater_hmenu_focus 
	GetTags 
	IF levelis load_skateshop 
		select_skater_get_current_skater_name 
		GetCurrentSkaterProfileIndex 
		load_pro_skater { profile = <currentSkaterProfileIndex> skater = 0 <...> } 
		GetSkaterProfileInfo player = <currentSkaterProfileIndex> 
		IF ( <name> = ped ) 
			skater : Obj_SetLightAmbientColor r = 0 g = 0 b = 0 
			skater : Obj_SetLightDiffuseColor Index = 0 r = 0 g = 0 b = 0 
			skater : Obj_SetLightDiffuseColor Index = 1 r = 0 g = 0 b = 0 
			skater : Obj_SetLightAmbientColor r = 0 g = 0 b = 0 
			skater : Obj_SetLightDiffuseColor Index = 0 r = 0 g = 0 b = 0 
			skater : Obj_SetLightDiffuseColor Index = 1 r = 0 g = 0 b = 0 
			IF ObjectExists id = TRG_LightController 
				kill name = TRG_LightController 
			ENDIF 
			FakeLights percent = 0 prefix = TRG_LevelLightSS 
		ELSE 
			skater : Obj_SetLightAmbientColor r = 73 g = 70 b = 80 
			skater : Obj_SetLightDiffuseColor Index = 0 r = 110 g = 125 b = 155 
			skater : Obj_SetLightDiffuseColor Index = 1 r = 10 g = 3 b = 5 
			skater : Obj_SetLightAmbientColor r = 73 g = 70 b = 80 
			skater : Obj_SetLightDiffuseColor Index = 0 r = 110 g = 125 b = 155 
			skater : Obj_SetLightDiffuseColor Index = 1 r = 10 g = 3 b = 5 
			skater : Obj_SetLightDirection Index = 0 heading = skater_select_light0_heading pitch = 350 
			skater : Obj_SetLightDirection Index = 1 heading = skater_select_light1_heading pitch = 270 
			SetLightDirection Index = 0 heading = skater_select_light0_heading pitch = 350 
			SetLightDirection Index = 1 heading = skater_select_light1_heading pitch = 270 
			IF NOT ObjectExists id = TRG_LightController 
				create name = TRG_LightController 
			ENDIF 
		ENDIF 
		StopStream 
		MakeSkaterGoto SkateshopAI params = { } 
		skater : SwitchOffBoard 
		get_current_skater_display_name 
		GetUpperCaseString <display_name> 
		SetScreenElementProps { 
			id = select_skater_name 
			text = <UpperCaseString> 
			pos = PAIR(-350.00000000000, 102.00000000000) 
		} 
		GetUpperCaseString <display_name> 
		SetScreenElementProps { 
			id = select_skater_name_2 
			text = <UpperCaseString> 
			pos = PAIR(-350.00000000000, 102.00000000000) 
		} 
	ENDIF 
	IF ObjectExists id = select_skater_name 
		DoScreenElementMorph id = select_skater_name_2 time = 0 alpha = 0.00000000000 
		DoScreenElementMorph id = select_skater_name time = 0 alpha = 0.00000000000 
		DoScreenElementMorph id = select_skater_name_2 time = 0.30000001192 pos = PAIR(230.00000000000, 102.00000000000) alpha = 0.69999998808 
		DoScreenElementMorph id = select_skater_name time = 0.30000001192 pos = PAIR(230.00000000000, 102.00000000000) alpha = 1.00000000000 
	ENDIF 
	GetArraySize master_skater_list 
	num_profiles = ( ( <array_size> -1 ) * 1.00000000000 ) 
	DoScreenElementMorph id = piece_slider_orange time = 0 pos = ( PAIR(0.00000000000, 0.00000000000) + ( ( <skater_index> ) / <num_profiles> ) * PAIR(450.00000000000, 0.00000000000) ) 
	DoScreenElementMorph id = <id> rgba = [ 100 100 100 128 ] scale = 1.00000000000 
	SetScreenElementProps id = <id> z_priority = 9 
	SetScreenElementLock id = <id> off 
	FormatText ChecksumName = on_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	CreateScreenElement { 
		Type = SpriteElement 
		parent = <id> 
		id = select_skater_highlight_box 
		texture = ss_highlightbox 
		rgba = <on_rgba> 
		just = [ center center ] 
		pos = PAIR(24.00000000000, 31.00000000000) 
		z_priority = 10 
	} 
	KillSpawnedScript name = highlight_box_pulse 
	RunScriptOnScreenElement id = select_skater_highlight_box highlight_box_pulse params = { id = select_skater_highlight_box } 
	IF ObjectExists id = stats_block_anchor 
		DestroyScreenElement id = stats_block_anchor 
	ENDIF 
	GetCurrentSkaterProfileIndex 
	GetSkaterProfileInfo player = <currentSkaterProfileIndex> 
	stats_menu_create_stats_block { 
		parent = stats_block_anchor_parent 
		id = stats_block_anchor 
		not_focusable 
		on = on 
		scale = 0.85000002384 
		pos = PAIR(0.00000000000, 145.00000000000) 
	} 
	AssignAlias id = select_skater_hmenu alias = current_menu 
	IF isxbox 
		SpawnScript TemporarilyDisableInput params = { time = 100 } 
	ENDIF 
ENDSCRIPT

SCRIPT highlight_box_pulse 
	BEGIN 
		DoScreenElementMorph id = <id> time = 0.02999999933 scale = PAIR(1.07000005245, 1.04999995232) 
		Wait 0.20000000298 second 
		DoScreenElementMorph id = <id> time = 0.02999999933 scale = PAIR(1.10000002384, 1.07000005245) 
		Wait 0.20000000298 second 
	REPEAT 
ENDSCRIPT

SCRIPT select_skater_get_current_skater_name 
	GetCurrentSkaterProfileIndex 
	GetSkaterProfileInfo player = <currentSkaterProfileIndex> 
	RETURN current_skater = <name> 
ENDSCRIPT

SCRIPT select_skater_hmenu_unfocus 
	GetTags 
	generic_menu_pad_up_down_sound 
	DoScreenElementMorph id = <id> rgba = [ 50 50 50 128 ] scale = 0.85000002384 
	SetScreenElementProps id = <id> z_priority = 7 
	IF ScreenElementExists id = { <id> child = 0 } 
		DestroyScreenElement id = { <id> child = 0 } 
	ENDIF 
	skater : reset_model_lights 
ENDSCRIPT

SCRIPT select_skater_hmenu_choose 
	GetCurrentSkaterProfileIndex 
	IF ControllerBoundToDifferentSkater controller = <device_num> skater = <currentSkaterProfileIndex> 
		RETURN 
	ENDIF 
	IF levelis load_skateshop 
		IF ( <name> = ped ) 
			IF NOT GotParam choose_ped 
				goto MakeSelectPedMenu params = { ped_info = <...> } 
			ENDIF 
		ENDIF 
	ENDIF 
	FireEvent Type = unfocus target = select_skater_hmenu 
	KillSpawnedScript name = highlight_box_pulse 
	GetSkaterId 
	IF ObjectExists id = select_skater_name 
		DoScreenElementMorph id = select_skater_name_2 time = 0.30000001192 pos = PAIR(-230.00000000000, 92.00000000000) 
		DoScreenElementMorph id = select_skater_name time = 0.30000001192 pos = PAIR(-230.00000000000, 102.00000000000) 
	ENDIF 
	DoScreenElementMorph id = select_skater_scrolling_hmenu time = 0.50000000000 pos = PAIR(320.00000000000, -250.00000000000) 
	DoScreenElementMorph id = piece_slider_container time = 0.50000000000 pos = PAIR(40.00000000000, -215.00000000000) 
	DoScreenElementMorph id = stats_block_anchor_parent time = 0.50000000000 pos = PAIR(-40.00000000000, 620.00000000000) 
	Wait 0.30000001192 seconds 
	IF ObjectExists id = select_skater_anchor 
		DestroyScreenElement id = select_skater_anchor 
		restore_start_key_binding 
	ENDIF 
	IF levelis load_skateshop 
		GetSkaterId 
		SWITCH <name> 
			CASE Iron_Man 
				IF NOT ( current_theme_prefix = 12 ) 
					set_current_theme theme_num = 12 dont_keep_it story_swap 
				ENDIF 
			CASE Gene 
				IF NOT ( current_theme_prefix = 11 ) 
					set_current_theme theme_num = 11 dont_keep_it story_swap 
				ENDIF 
			CASE creature 
				IF NOT ( current_theme_prefix = 13 ) 
					set_current_theme theme_num = 13 dont_keep_it story_swap 
				ENDIF 
		ENDSWITCH 
		maybe_revert_theme 
		IF GotParam device_num 
			<controller_index> = <device_num> 
		ELSE 
			<controller_index> = <controller> 
		ENDIF 
		BindControllerToSkater skater_heap_index = <currentSkaterProfileIndex> controller = <controller_index> 
		BindFrontEndToController front_end_pad = <currentSkaterProfileIndex> controller = <controller_index> 
		StopStream 
		skater : Obj_MoveToNode name = trg_playerrestart Orient NoReset 
		skater : CancelRotateDisplay 
		skater : reset_model_lights 
		GetCurrentSkaterProfileIndex 
		skater : Obj_SpawnScript SkateshopGO 
		IF InSplitScreenGame 
			launch_ss_menu <...> 
		ELSE 
			launch_ss_menu 
		ENDIF 
	ELSE 
		IF NOT GoalManager_HasActiveGoals 
			GoalManager_ShowGoalPoints 
		ENDIF 
		select_skater_get_current_skater_name 
		IF NOT ( <current_skater> = <name> ) 
			GetCurrentSkaterProfileIndex 
			load_pro_skater { profile = <currentSkaterProfileIndex> skater = 0 <...> } 
		ENDIF 
		GoalManager_ShowPoints 
		GoalManager_ReplaceTrickText all 
		exit_pause_menu 
	ENDIF 
	skater : SetTags stopskateshopstreams = 1 
ENDSCRIPT

SCRIPT MakeSelectPedMenu dims = PAIR(300.00000000000, 150.00000000000) pos = PAIR(220.00000000000, -10.00000000000) menu_id = sub_menu vmenu_id = sub_vmenu 
	FireEvent Type = unfocus target = select_skater_hmenu 
	SetScreenElementLock id = root_window off 
	change widest_menu_item_width = 0 
	CreateScreenElement { 
		Type = ContainerElement 
		parent = root_window 
		id = ped_menu_parts_anchor 
		dims = PAIR(640.00000000000, 150.00000000000) 
		pos = PAIR(320.00000000000, 240.00000000000) 
	} 
	skater : Obj_SetLightAmbientColor r = 73 g = 70 b = 80 
	skater : Obj_SetLightDiffuseColor Index = 0 r = 110 g = 125 b = 155 
	skater : Obj_SetLightDiffuseColor Index = 1 r = 10 g = 3 b = 5 
	skater : Obj_SetLightAmbientColor r = 73 g = 70 b = 80 
	skater : Obj_SetLightDiffuseColor Index = 0 r = 110 g = 125 b = 155 
	skater : Obj_SetLightDiffuseColor Index = 1 r = 10 g = 3 b = 5 
	skater : Obj_SetLightDirection Index = 0 heading = skater_select_light0_heading pitch = 350 
	skater : Obj_SetLightDirection Index = 1 heading = skater_select_light1_heading pitch = 270 
	SetLightDirection Index = 0 heading = skater_select_light0_heading pitch = 350 
	SetLightDirection Index = 1 heading = skater_select_light1_heading pitch = 270 
	IF NOT ObjectExists id = TRG_LightController 
		create name = TRG_LightController 
	ENDIF 
	Type = VScrollingMenu 
	scrolling_menu_id = sub_scrolling_menu 
	make_new_menu { 
		pos = <pos> 
		parent = ped_menu_parts_anchor 
		internal_just = [ left center ] 
		menu_id = <menu_id> 
		vmenu_id = <vmenu_id> 
		scrolling_menu_id = <scrolling_menu_id> 
		Type = <Type> 
		dims = <dims> 
		dont_allow_wrap = <dont_allow_wrap> 
		<no_menu_title> 
	} 
	DoScreenElementMorph id = <menu_id> time = 0 pos = PAIR(310.00000000000, 620.00000000000) 
	AssignAlias id = ped_menu_parts_anchor alias = current_menu_anchor 
	SetScreenElementProps { 
		id = current_menu 
		event_handlers = [ 
			{ pad_back BackFromPedMenu } 
			{ pad_up set_which_arrow params = { arrow = scrolling_menu_up_arrow } } 
			{ pad_down set_which_arrow params = { arrow = scrolling_menu_down_arrow } } 
			{ pad_up generic_menu_up_or_down_sound params = { up } } 
			{ pad_down generic_menu_up_or_down_sound params = { down } } 
		] 
	} 
	GetArraySize ped_profile_list 
	<Index> = 0 
	BEGIN 
		IF GetGlobalFlag flag = ( ( ped_profile_list [ <Index> ] ) . ped_group_flag ) 
			theme_menu_add_item { text = ( ( ped_profile_list [ <Index> ] ) . display_name ) 
				focus_script = PedFocus 
				focus_params = { appearance = ( ( ped_profile_list [ <Index> ] ) . ped_appearance_structure ) } 
				pad_choose_script = PedChoose 
				pad_choose_params = { info = <ped_info> } 
				centered 
				highlight_bar_scale = PAIR(1.70000004768, 0.69999998808) 
				no_bg 
			} 
		ELSE 
			IF GetGlobalFlag flag = GOT_ALL_GAPS 
				theme_menu_add_item { text = ( ( ped_profile_list [ <Index> ] ) . display_name ) 
					focus_script = PedFocus 
					focus_params = { appearance = ( ( ped_profile_list [ <Index> ] ) . ped_appearance_structure ) } 
					pad_choose_script = PedChoose 
					pad_choose_params = { info = <ped_info> } 
					centered 
					highlight_bar_scale = PAIR(1.70000004768, 0.69999998808) 
					no_bg 
				} 
			ENDIF 
		ENDIF 
		<Index> = ( <Index> + 1 ) 
	REPEAT <array_size> 
	theme_menu_add_item { text = "Done" 
		pad_choose_script = BackFromPedMenu 
		centered 
		highlight_bar_scale = PAIR(1.70000004768, 0.69999998808) 
		no_bg 
	} 
	finish_themed_scrolling_menu pos = PAIR(310.00000000000, 0.00000000000) bg_width = 1.39999997616 
	DoScreenElementMorph id = bg_box_vmenu pos = PAIR(310.00000000000, -10.00000000000) 
	FormatText ChecksumName = on_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	DoScreenElementMorph id = scrolling_menu_up_arrow time = 0 rgba = <on_rgba> 
	DoScreenElementMorph id = scrolling_menu_down_arrow time = 0 rgba = <on_rgba> 
	SetScreenElementLock id = ped_menu_parts_anchor off 
	create_helper_text generic_helper_text parent = ped_menu_parts_anchor helper_pos = PAIR(320.00000000000, 261.00000000000) 
	SetScreenElementLock id = ped_menu_parts_anchor on 
ENDSCRIPT

SCRIPT PedChoose 
	GetCurrentSkaterProfileIndex 
	IF ControllerBoundToDifferentSkater controller = <device_num> skater = <currentSkaterProfileIndex> 
		RETURN 
	ENDIF 
	IF ObjectExists id = ped_menu_parts_anchor 
		DestroyScreenElement id = ped_menu_parts_anchor 
	ENDIF 
	select_skater_hmenu_choose <info> choose_ped 
ENDSCRIPT

SCRIPT PedFocus 
	main_theme_focus 
	GetCurrentSkaterProfileIndex 
	SetPlayerAppearance player = <currentSkaterProfileIndex> appearance_structure = <appearance> 
	SetSkaterProfileProperty player = <currentSkaterProfileIndex> is_male 1 
	EditPlayerAppearance profile = <currentSkaterProfileIndex> target = SetPart targetParams = { part = board desc_id = Default } 
	EditPlayerAppearance profile = <currentSkaterProfileIndex> target = ClearPart targetParams = { part = ped_board } 
	RefreshSkaterModel profile = <currentSkaterProfileIndex> skater = <controller> no_board = no_board 
	current_menu : GetTags 
	IF GotParam arrow_id 
		FormatText ChecksumName = on_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
		menu_vert_blink_arrow id = <arrow_id> rgba = <on_rgba> 
	ENDIF 
ENDSCRIPT

SCRIPT BackFromPedMenu 
	IF ObjectExists id = ped_menu_parts_anchor 
		DestroyScreenElement id = ped_menu_parts_anchor 
	ENDIF 
	SetScreenElementLock id = select_skater_anchor off 
	create_helper_text { helper_text_elements = [ { text = "\\b6/\\b5=Select" } 
			{ text = "\\bm=Accept" } 
			{ text = "\\bn=Back" } 
			{ text = "\\bo=Load Skater" } 
		] 
		parent = select_skater_anchor 
	} 
	SetScreenElementLock id = select_skater_anchor on 
	Debounce X time = 0.50000000000 
	FireEvent Type = focus target = select_skater_hmenu data = { child_id = 19 } 
	AssignAlias id = select_skater_anchor alias = current_menu_anchor 
ENDSCRIPT

SCRIPT SkateshopGO 
	Wait 0.18000000715 seconds 
	PlaySkaterStream Type = "SSGo" 
ENDSCRIPT

SCRIPT load_second_skater_profile 
	printf "REFRESHING SKATER MODEL" 
	SetCurrentSkaterProfile 1 
	RefreshSkaterModel profile = 1 skater = 0 
	SyncPlayer2Profile 
ENDSCRIPT

SCRIPT select_skater_menu_back 
	IF IsInternetGameHost 
		QuitGame 
		RETURN 
	ENDIF 
	IF IsJoiningInternetGame 
		QuitGame 
		RETURN 
	ENDIF 
	KillSpawnedScript name = highlight_box_pulse 
	IF ObjectExists id = select_skater_anchor 
		DestroyScreenElement id = select_skater_anchor 
		restore_start_key_binding 
	ENDIF 
	skater : Obj_MoveToNode name = trg_playerrestart Orient NoReset 
	skater : CancelRotateDisplay 
	skater : SetTags stopskateshopstreams = 1 
	<callback> from_skater_select 
ENDSCRIPT

SCRIPT select_skater_menu_animate_top 
	PlaySound DE_MenuFlyUp 
	DoMorph pos = { PAIR(0.00000000000, -120.00000000000) relative } alpha = 0 
	DoMorph time = 0.20000000298 pos = { PAIR(0.00000000000, 120.00000000000) relative } alpha = 1 
ENDSCRIPT

SCRIPT select_skater_menu_animate_stats 
	FireEvent Type = select_skater_menu_animate_stats_done 
ENDSCRIPT

SCRIPT select_skater_menu_animate_bottom 
	DoMorph pos = { PAIR(0.00000000000, 140.00000000000) relative } alpha = 0 
	DoMorph time = 0.40000000596 
	DoMorph time = 0.20000000298 pos = { PAIR(0.00000000000, -138.00000000000) relative } alpha = 1 
ENDSCRIPT

SCRIPT menu_blink_arrow 
	DoMorph alpha = 0 
	Wait 100 
	DoMorph time = 0.30000001192 alpha = 1 
ENDSCRIPT

SCRIPT blink_arrow 
	DoScreenElementMorph id = <id> alpha = 0 
	Wait 100 
	DoScreenElementMorph id = <id> time = 0.30000001192 alpha = 1 
ENDSCRIPT

SCRIPT set_which_arrow 
	SetTags arrow_id = <arrow> 
ENDSCRIPT

SCRIPT menu_vert_blink_arrow menu_id = current_menu rgba = [ 128 128 128 128 ] 
	IF NOT ObjectExists id = <id> 
		printf "bad arrow id" 
		RETURN 
	ENDIF 
	TerminateObjectsScripts id = <id> 
	DoScreenElementMorph { 
		id = <id> 
		alpha = 1 
	} 
	Wait 1 gameframe 
	IF NOT ( ( MenuSelectedIndexIs id = <menu_id> first ) | ( MenuSelectedIndexIs id = <menu_id> last ) ) 
		SetScreenElementProps { id = <id> rgba = <rgba> } 
		RunScriptOnScreenElement id = <id> menu_blink_arrow 
	ENDIF 
ENDSCRIPT

SCRIPT draw_menu_box delta_pos = PAIR(100.00000000000, 30.00000000000) middle_repeat = 7 scale = PAIR(1.00000000000, 1.00000000000) box_right_scale = PAIR(0.80000001192, 0.62500000000) box_bottom_scale = PAIR(0.95999997854, 1.00000000000) box_right_offset = PAIR(-20.00000000000, 0.00000000000) current_menu_anchor = current_menu_anchor 
	GetStackedScreenElementPos X id = <current_menu_anchor> 
	CreateScreenElement { 
		Type = SpriteElement 
		parent = <current_menu_anchor> 
		id = menu_box_top 
		texture = level_top_piece 
		pos = ( PAIR(230.00000000000, 100.00000000000) + <delta_pos> ) 
		rgba = [ 128 128 128 80 ] 
		scale = <scale> 
		just = [ center top ] 
		z_priority = 0 
	} 
	BEGIN 
		GetStackedScreenElementPos Y id = <id> 
		CreateScreenElement { 
			Type = SpriteElement 
			parent = <current_menu_anchor> 
			texture = level_repeat_mid 
			pos = <pos> 
			scale = <scale> 
			rgba = [ 128 128 128 80 ] 
			just = [ left top ] 
			z_priority = 0 
		} 
	REPEAT <middle_repeat> 
	GetStackedScreenElementPos Y id = <id> 
	CreateScreenElement { 
		Type = SpriteElement 
		parent = <current_menu_anchor> 
		texture = level_bottom_piece 
		pos = <pos> 
		rgba = [ 128 128 128 80 ] 
		scale = <box_bottom_scale> 
		just = [ left top ] 
		z_priority = 0 
	} 
	GetStackedScreenElementPos X id = menu_box_top offset = <box_right_offset> 
	CreateScreenElement { 
		Type = SpriteElement 
		parent = <current_menu_anchor> 
		texture = goal_right 
		scale = <box_right_scale> 
		rgba = [ 128 128 128 80 ] 
		pos = <pos> 
		just = [ left top ] 
		z_priority = 0 
	} 
ENDSCRIPT

SCRIPT launch_park_editor 
	SetGameType creategoals 
	SetCurrentGameType 
	SetParkName "" 
	BindParkEditorToController <device_num> 
	GetCurrentSkaterProfileIndex 
	BindControllerToSkater skater_heap_index = <currentSkaterProfileIndex> controller = <device_num> 
	BindFrontEndToController front_end_pad = <currentSkaterProfileIndex> controller = <device_num> 
	main_menu_play_level level = load_Sk5Ed 
ENDSCRIPT

SCRIPT main_menu_play_level 
	main_menu_exit new_menu_script = main_menu_play_level2 kill_clouds <...> 
ENDSCRIPT

SCRIPT main_menu_play_level2 
	load_mainmenu_textures_to_main_memory unload 
	restore_start_key_binding 
	skater : reset_model_lights 
	change_level level = <level> 
ENDSCRIPT

SCRIPT leave_front_end 
	restore_start_key_binding 
	load_mainmenu_textures_to_main_memory unload 
ENDSCRIPT

SCRIPT spawn_two_player 
	Cleanup preserve_skaters 
	LeaveServer 
	FlushDeadObjects 
	InitSkaterHeaps 
	SetServerMode 
	StartServer 
	SetJoinMode JOIN_MODE_PLAY 
	JoinServer 
	BEGIN 
		IF JoinServerComplete 
			BREAK 
		ELSE 
			Wait 1 
		ENDIF 
	REPEAT 
	ScreenElementSystemCleanup 
ENDSCRIPT

SCRIPT launch_two_player 
	SetCurrentSkaterProfile 0 
	RefreshSkaterModel profile = 0 skater = 0 
	SetMenuPadMappings [ active 
		use_as_first 
	] 
	SpawnScript spawn_two_player NotSessionSpecific = 1 
ENDSCRIPT

SCRIPT enable_two_player_option 
	IF ObjectExists id = main_menu_2_player_option 
		main_menu_2_player_option : GetTags 
		IF GotParam tag_not_focusable 
			main_vmenu : GetTags 
			IF GotParam tag_selected_id 
				IF ( <tag_selected_id> = main_menu_2_player_option ) 
					SetScreenElementProps { 
						id = { main_menu_2_player_option child = 0 } 
						rgba = [ 127 123 0 100 ] 
						z_priority = 4 
						focusable 
					} 
				ELSE 
					FormatText ChecksumName = rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
					SetScreenElementProps { 
						id = { main_menu_2_player_option child = 0 } 
						rgba = <rgba> 
						focusable 
					} 
				ENDIF 
				SetScreenElementProps { 
					id = main_menu_2_player_option 
					focusable 
				} 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT disable_two_player_option 
	IF ObjectExists id = main_menu_2_player_option 
		main_menu_2_player_option : GetTags 
		IF NOT GotParam tag_not_focusable 
			main_vmenu : GetTags 
			IF GotParam tag_selected_id 
				IF ( <tag_selected_id> = main_menu_2_player_option ) 
					FireEvent Type = pad_up target = current_menu 
				ENDIF 
			ENDIF 
			SetScreenElementProps { 
				id = { main_menu_2_player_option child = 0 } 
				rgba = [ 60 60 60 75 ] 
				not_focusable 
			} 
			SetScreenElementProps { 
				id = main_menu_2_player_option 
				not_focusable 
			} 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT enable_system_link_option 
	IF ObjectExists id = mm_multi_play 
		mm_multi_play : GetTags 
		IF GotParam tag_not_focusable 
			main_vmenu : GetTags 
			IF GotParam tag_selected_id 
				IF ( <tag_selected_id> = mm_multi_play ) 
					SetScreenElementProps { 
						id = { mm_multi_play child = 0 } 
						rgba = [ 127 123 0 100 ] 
						z_priority = 4 
						focusable 
					} 
				ELSE 
					FormatText ChecksumName = text_color "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
					text_rgba = <text_color> 
					SetScreenElementProps { 
						id = { mm_multi_play child = 0 } 
						rgba = <text_rgba> 
						focusable 
					} 
				ENDIF 
				SetScreenElementProps { 
					id = mm_multi_play 
					focusable 
				} 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT disable_system_link_option 
	IF ObjectExists id = mm_multi_play 
		mm_multi_play : GetTags 
		IF NOT GotParam tag_not_focusable 
			main_vmenu : GetTags 
			IF GotParam tag_selected_id 
				IF ( <tag_selected_id> = mm_multi_play ) 
					FireEvent Type = pad_up target = current_menu 
				ENDIF 
			ENDIF 
			SetScreenElementProps { 
				id = { mm_multi_play child = 0 } 
				rgba = [ 60 60 60 75 ] 
				not_focusable 
			} 
			SetScreenElementProps { 
				id = mm_multi_play 
				not_focusable 
			} 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT make_mainmenu_clouds 
	IF NOT ScreenElementExists id = cloud_anchor 
		CreateScreenElement { 
			Type = ContainerElement 
			parent = root_window 
			id = cloud_anchor 
			dims = PAIR(640.00000000000, 480.00000000000) 
			pos = PAIR(320.00000000000, 240.00000000000) 
		} 
		CreateScreenElement { 
			Type = SpriteElement 
			parent = cloud_anchor 
			id = clouds1 
			texture = mm_clouds 
			just = [ left top ] 
			pos = PAIR(200.00000000000, 70.00000000000) 
			scale = PAIR(4.00000000000, 0.64999997616) 
			z_priority = -4 
			alpha = 0.10000000149 
		} 
		GetStackedScreenElementPos X id = clouds1 
		CreateScreenElement { 
			Type = SpriteElement 
			parent = cloud_anchor 
			id = clouds2 
			texture = mm_clouds 
			just = [ left top ] 
			pos = <pos> 
			scale = PAIR(4.00000000000, 0.64999997616) 
			z_priority = -4 
			alpha = 0.05000000075 
		} 
		GetStackedScreenElementPos X id = clouds2 
		CreateScreenElement { 
			Type = SpriteElement 
			parent = cloud_anchor 
			id = clouds3 
			texture = mm_clouds 
			just = [ left top ] 
			pos = <pos> 
			scale = PAIR(4.00000000000, 0.64999997616) 
			z_priority = -4 
			alpha = 0.05000000075 
		} 
		RunScriptOnScreenElement id = clouds1 check_for_building 
		RunScriptOnScreenElement id = clouds1 move_mainmenu_clouds params = { id = clouds1 } 
		RunScriptOnScreenElement id = clouds2 move_mainmenu_clouds params = { id = clouds2 } 
		RunScriptOnScreenElement id = clouds3 move_mainmenu_clouds params = { id = clouds3 } 
	ENDIF 
ENDSCRIPT

SCRIPT move_mainmenu_clouds time = 35 start_x = 718 end_x = -50 
	GetScreenElementPosition id = <id> 
	initial_x = ( <ScreenElementPos> . PAIR(1.00000000000, 0.00000000000) ) 
	initial_y = ( <ScreenElementPos> . PAIR(0.00000000000, 1.00000000000) ) 
	start_pos = ( ( <start_x> * PAIR(1.00000000000, 0.00000000000) ) + ( PAIR(0.00000000000, 1.00000000000) * <initial_y> ) ) 
	end_pos = ( ( <end_x> * PAIR(1.00000000000, 0.00000000000) ) + ( PAIR(0.00000000000, 1.00000000000) * <initial_y> ) ) 
	initial_time = ( ( <initial_x> - <end_x> ) / ( ( <start_x> - <end_x> ) / <time> ) ) 
	DoScreenElementMorph id = <id> pos = <end_pos> time = <initial_time> 
	Wait <initial_time> seconds 
	BEGIN 
		DoScreenElementMorph id = <id> pos = <start_pos> 
		DoScreenElementMorph id = <id> pos = <end_pos> time = <time> 
		Wait <time> seconds 
	REPEAT 
ENDSCRIPT

SCRIPT check_for_building 
	BEGIN 
		IF NOT ScreenElementExists id = mm_building 
			DestroyScreenElement id = cloud_anchor 
			BREAK 
		ELSE 
			Wait 1 gameframe 
		ENDIF 
	REPEAT 
ENDSCRIPT

attract_mode_movies = [ 
	"movies\\demo_1" 
	"movies\\demo_2" 
	"movies\\demo_3" 
] 
