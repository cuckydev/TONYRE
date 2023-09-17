
lock_framerate = 0 
display_framerate_box = 1 
show_filenames = 0 
output_tracking_lines = 0 
rail_arrows = 0 
show_all_trick_objects = 0 
viewer_buttons_enabled = 1 
wireframe_skins = 0 
DEMO_BUILD = 0 
auto_change_chapter_and_stage = 0 
SHOWPOLYS_ONQUICKVIEW = 1 
SCRIPT load_permanent_prefiles 
	LoadPreFile "permtex.pre" 
	IF NOT IsNgc 
		LoadPreFile "casfiles.pre" 
	ENDIF 
	IF IsNgc 
		LoadPreFile "gcmemicons.pre" 
	ENDIF 
ENDSCRIPT

SCRIPT load_permanent_assets 
	SetDefaultPermanent 1 
	SetReferenceChecksum 0 
	LoadPreFile "skeletons.pre" 
	LoadPreFile "bits.pre" 
	InitAnimCompressTable "anims\\standardkeyq.bin" q48 
	InitAnimCompressTable "anims\\standardkeyt.bin" t48 
	PushMemProfile "Audio Stream header" 
	LoadStreamHeader "streams\\streams" 
	PopMemProfile 
	PushMemProfile "Permanent Skeletons" 
	skeletonload_all 
	PopMemProfile 
	PushMemProfile "Permanent Models" 
	LoadAsset "models\\arrow\\arrow.mdl" nocollision = 1 
	LoadAsset "models\\HUD_arrow\\HUD_arrow.mdl" nocollision = 1 
	LoadAsset "models\\ped_shadow\\ped_shadow.mdl" nocollision = 1 
	LoadAsset "models\\goalarrow\\goalarrow.mdl" nocollision = 1 
	LoadAsset "models\\cat_bg\\cat_bg.mdl" nocollision = 1 
	LoadAsset "models\\gameobjects\\p1_cursor\\p1_cursor.mdl" nocollision = 1 
	LoadAsset "models\\gameobjects\\skate\\letter_s\\letter_s.mdl" nocollision = 1 
	LoadAsset "models\\gameobjects\\skate\\letter_k\\letter_k.mdl" nocollision = 1 
	LoadAsset "models\\gameobjects\\skate\\letter_a\\letter_a.mdl" nocollision = 1 
	LoadAsset "models\\gameobjects\\skate\\letter_t\\letter_t.mdl" nocollision = 1 
	LoadAsset "models\\gameobjects\\skate\\letter_e\\letter_e.mdl" nocollision = 1 
	LoadAsset "models\\gameobjects\\combo\\goal_combo_c\\goal_combo_c.mdl" nocollision = 1 
	LoadAsset "models\\gameobjects\\combo\\goal_combo_o\\goal_combo_o.mdl" nocollision = 1 
	LoadAsset "models\\gameobjects\\combo\\goal_combo_m\\goal_combo_m.mdl" nocollision = 1 
	LoadAsset "models\\gameobjects\\combo\\goal_combo_b\\goal_combo_b.mdl" nocollision = 1 
	load_special_items 
	PopMemProfile 
	PushMemProfile "Permanent Textures" 
	LoadParticleTexture "particles\\dt_generic_particle01" perm 
	LoadParticleTexture "bits\\particle_test02" perm 
	LoadParticleTexture "bits\\blood_01" perm 
	LoadParticleTexture "bits\\splash" perm 
	LoadParticleTexture "bits\\snow" perm 
	LoadParticleTexture "particles\\dt_nj_flame02" perm 
	LoadParticleTexture "particles\\dt_ironblast01" perm 
	LoadParticleTexture "particles\\dt_barf02" perm 
	IF isXbox 
		LoadParticleTexture "bits\\skidtrail" perm 
	ELSE 
		LoadParticleTexture "bits\\skidtrail_ps2" perm 
	ENDIF 
	PopMemProfile 
	UnloadPreFile "skeletons.pre" 
	UnloadPreFile "bits.pre" 
	do_load_permanent 
	do_load_unloadable 
	SetDefaultPermanent 0 
ENDSCRIPT

SCRIPT load_special_items 
	LoadAsset "models\\specialitems\\Flag\\flag.skin" 
	LoadAsset "models\\specialitems\\bustedboard\\bustedboard.skin" 
	LoadAsset "models\\specialitems\\pizzabox\\pizzabox.skin" 
	LoadAsset "models\\specialitems\\guitar\\guitar.skin" 
	LoadAsset "models\\specialitems\\extraboard\\extraboard.skin" 
	LoadAsset "models\\specialitems\\BloodyGuts\\BloodyGuts.skin" 
	LoadAsset "models\\specialitems\\spraycan\\spraycan.skin" 
	LoadAsset "models\\specialitems\\tongue\\SEC_Gene_Tongue.skin" 
	LoadAsset "models\\specialitems\\boombox\\boombox.skin" 
	LoadAsset "models\\specialitems\\skull\\head_skull.skin" 
ENDSCRIPT

SCRIPT load_permanent_anims LoadFunction = LoadAnim 
	animload_thps5_human <...> 
	load_special_item_anims <...> 
ENDSCRIPT

SCRIPT load_unloadable_anims LoadFunction = LoadAnim 
	animload_THPS5_human_unloadable <...> 
ENDSCRIPT

SCRIPT load_special_anims LoadFunction = LoadAnim 
ENDSCRIPT

SCRIPT load_net_anims LoadFunction = LoadAnim 
	animload_THPS5_human_net <...> 
	load_special_item_anims <...> 
ENDSCRIPT

SCRIPT load_special_item_anims LoadFunction = LoadAnim 
	animload_SI_flag <...> 
	animload_SI_bustedboard <...> 
	animload_SI_Pizza <...> 
	animload_SI_boombox <...> 
	animload_SI_Generic <...> 
	animload_SI_Extraboard <...> 
	animload_SI_Tongue <...> 
	animload_SI_Skull <...> 
ENDSCRIPT

SCRIPT init_loading_bar 
	SetLoadingBarPos x = 258 y = 400 
	SetLoadingBarSize width = 140 height = 8 
	SetLoadingBarStartColor r = 0 g = 76 b = 129 
	SetLoadingBarEndColor r = 176 g = 211 b = 115 
	SetLoadingBarBorder width = 5 height = 5 
	SetLoadingBarBorderColor r = 40 g = 40 b = 40 
ENDSCRIPT

SCRIPT startup_loading_screen 
	IF NOT Bootstrap 
		IF IsPS2 
			IF CD 
				Displayloadingscreen blank 
				PlayMovie "movies\\atvi" 
				PlayMovie "movies\\nslogo" 
				PlayMovie "movies\\intro" 
			ENDIF 
		ENDIF 
	ENDIF 
	IF isXbox 
		IF CD 
			IF NOT IsInternetGameHost 
				IF NOT IsJoiningInternetGame 
					PlayMovie "movies\\atvi" 
					PlayMovie "movies\\nslogo" 
					PlayMovie "movies\\beenox" 
					PlayMovie "movies\\intro" 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
	IF IsNgc 
		IF CD 
			PlayMovie "movies\\atvi" 
			PlayMovie "movies\\nslogo" 
			PlayMovie "movies\\intro" 
		ENDIF 
	ENDIF 
	IF Bootstrap 
		Displayloadingscreen "loadscrn_demo" 
	ELSE 
		IF isXbox 
			Displayloadingscreen "loadscrn_x" 
		ENDIF 
		IF IsNgc 
			Displayloadingscreen "loadscrn_ngc" 
		ENDIF 
		IF IsPS2 
		ENDIF 
	ENDIF 
ENDSCRIPT

All_Levels_Unlocked = 1 
bootstrap_build = 0 
UseLevelOverrideStats = 0 
SCRIPT default_system_startup 
	WriteDNASBinary 
	change select_shift = 0 
	PushMemProfile "script default_system_startup before autolaunch" 
	SetGlobalFlag flag = LEVEL_UNLOCKED_SCH 
	unlock_initial_boards 
	IF CD 
		IF isXbox 
		ENDIF 
	ENDIF 
	SetSfxVolume 100 
	SetMusicVolume 50 
	SetRandomMode 1 
	SetGlobalFlag flag = SOUNDS_SONGORDER_RANDOM 
	IF CD 
		change UsePreFilesForLevelLoading = 1 
		change DEVKIT_LEVELS = 0 
		change All_Levels_Unlocked = 0 
	ENDIF 
	IF IsNgc 
		change UsePreFilesForLevelLoading = 1 
	ENDIF 
	new_screen_element_test 
	SetScreenElementProps id = root_window event_handlers = [ { pad_start nullscript } ] replace_handlers 
	printf "replace_handlers to take away start key in load_level" 
	setservermode on 
	SetJoinMode JOIN_MODE_PLAY 
	StartServer 
	JoinServer <...> 
	CreateGoalEditor 
	CreateRailEditor 
	PopMemProfile 
	IF Bootstrap 
		change bootstrap_build = 1 
		change STARTGAME_FIRST_TIME = 1 
		change BUMP_STATS = 0 
		change All_Levels_Unlocked = 0 
		autolaunch level = load_sch game = career 
	ELSE 
		IF CD 
			change BUMP_STATS = 1 
			IF ( DEMO_BUILD ) 
				autolaunch level = load_skateshop game = career 
			ELSE 
				launchviewer 
				autolaunch level = load_skateshop game = career 
			ENDIF 
		ELSE 
			cheat_select_shift 
			auto_launch_viewer 
			cheat_give_neversoft_skaters 
			LaunchScriptDebugger 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT Call_Personal_StartUp_Script 
	IF Gunslinger 
		IF ScriptExists gun_startup 
			gun_startup 
		ELSE 
			default_gun_startup 
		ENDIF 
	ELSE 
		IF ScriptExists startup 
			startup 
		ELSE 
			printf "WARNING: Missing the startup script" 
			Hideloadingscreen 
			CreateScreenElement { 
				parent = root_window 
				type = textelement 
				id = ns_rules 
				text = "Neversoft and Activision 2002" 
				font = newtrickfont 
				pos = PAIR(320, 420) 
				rgba = [ 140 128 128 55 ] 
				Scale = 0.60000002384 
				just = [ center center ] 
				not_focusable 
			} 
			RunScriptOnScreenElement id = ns_rules missing_startup 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT default_gun_startup 
	GetCurrentSkaterProfileIndex 
	SetPlayerAppearance player = <currentSkaterProfileIndex> appearance_structure = appearance_custom_skater_male_09 
	change show_career_startup_menu = 0 
	autolaunch level = load_www game = career 
ENDSCRIPT

SCRIPT missing_startup 
	BEGIN 
		SetProps text = "Missing Script Startup" 
		DoMorph time = 0 alpha = 0 
		DoMorph time = 0.50000000000 alpha = 1 Scale = 3 
		DoMorph time = 0.50000000000 alpha = 1 Scale = 1 
		wait 5 seconds 
		DoMorph time = 0.50000000000 alpha = 0 Scale = 0.50000000000 
		DoMorph time = 0.50000000000 alpha = 0 
	REPEAT 
ENDSCRIPT

STARTGAME_FIRST_TIME = 0 
SCRIPT create_startup_menu 
	Hideloadingscreen 
	GoalManager_HidePoints 
	GoalManager_HideGoalPoints 
	IF ObjectExists id = current_menu_anchor 
		Destroyscreenelement id = current_menu_anchor 
		wait 1 game frame 
	ENDIF 
	KillSkaterCamAnim all 
	PlaySkaterCamAnim name = SS_MenuCam play_hold 
	SetMemThreadSafe off 
	make_new_skateshop_menu { 
		pos = PAIR(205.00000000000, 109.00000000000) 
		internal_just = [ center center ] 
		menu_id = startup_menu 
		vmenu_id = startup_vmenu 
		menu_title = "" 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = current_menu_anchor 
		texture = THPS4 
		pos = PAIR(320.00000000000, 132.00000000000) 
		Scale = PAIR(1.39999997616, 1.00000000000) 
		z_priority = 2 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = current_menu_anchor 
		texture = options_bg 
		draw_behind_parent 
		pos = PAIR(321.00000000000, 115.00000000000) 
		Scale = PAIR(1.16999995708, 1.10000002384) 
		just = [ center top ] 
		rgba = [ 128 128 128 128 ] 
		z_priority = 0 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = current_menu_anchor 
		id = startup_menu_blue_bar 
		texture = stats_notch 
		pos = PAIR(312.00000000000, 369.00000000000) 
		rgba = [ 42 48 77 50 ] 
		Scale = PAIR(14.00000000000, 0.20000000298) 
		just = [ center top ] 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = current_menu_anchor 
		id = startup_menu_box_top 
		texture = level_top_piece 
		pos = PAIR(321.00000000000, 145.00000000000) 
		rgba = [ 128 128 128 80 ] 
		Scale = <Scale> 
		just = [ center top ] 
	} 
	BEGIN 
		GetStackedScreenElementPos y id = <id> 
		CreateScreenElement { 
			type = SpriteElement 
			parent = current_menu_anchor 
			texture = level_repeat_mid 
			pos = <pos> 
			Scale = <Scale> 
			rgba = [ 128 128 128 80 ] 
			just = [ left top ] 
		} 
	REPEAT 5 
	GetStackedScreenElementPos y id = <id> 
	CreateScreenElement { 
		type = SpriteElement 
		parent = current_menu_anchor 
		texture = level_bottom_piece 
		pos = <pos> 
		rgba = [ 128 128 128 80 ] 
		Scale = PAIR(0.95999997854, 1.00000000000) 
		just = [ left top ] 
	} 
	GetStackedScreenElementPos x id = startup_menu_box_top offset = PAIR(-20.00000000000, 0.00000000000) 
	CreateScreenElement { 
		type = SpriteElement 
		parent = current_menu_anchor 
		texture = goal_right 
		Scale = PAIR(0.80000001192, 0.50000000000) 
		rgba = [ 128 128 128 80 ] 
		pos = <pos> 
		just = [ left top ] 
	} 
	CreateScreenElement { 
		type = textelement 
		parent = current_menu 
		font = small 
		text = "" 
		not_focusable 
	} 
	SetScreenElementProps { 
		id = root_window 
		event_handlers = [ { pad_start continue_career } ] 
		replace_handlers 
	} 
	main_menu_add_item text = "Start Game" pad_choose_script = continue_career 
	main_menu_add_item { 
		text = "Controls" 
		pad_choose_script = bootstrap_displayscreen 
		pad_choose_params = { screen = "loadscrn_demo_controls" } 
	} 
	main_menu_add_item { 
		text = "More Info" 
		pad_choose_script = bootstrap_displayscreen 
		pad_choose_params = { screen = "loadscrn_marketing" } 
	} 
	printf "create_Startup_menu" 
	RunScriptOnScreenElement id = startup_menu menu_onscreen 
	printf "step2" 
	CreateScreenElement { 
		parent = root_window 
		type = textelement 
		id = ns_rules 
		text = "Neversoft and Activision 2002" 
		font = newtrickfont 
		pos = PAIR(320.00000000000, 420.00000000000) 
		rgba = [ 140 128 128 55 ] 
		Scale = 0.60000002384 
		just = [ center center ] 
		not_focusable 
	} 
	startup_camera_playback 
	change STARTGAME_FIRST_TIME = 0 
	printf "step3" 
ENDSCRIPT

SCRIPT bootstrap_displayscreen screen = "loadscrn_demo_controls" 
	IF ObjectExists id = startup_menu 
		Destroyscreenelement id = startup_menu 
	ENDIF 
	IF ObjectExists id = ns_rules 
		Destroyscreenelement id = ns_rules 
	ENDIF 
	make_new_menu menu_id = screen_menu 
	SetScreenElementProps { 
		id = root_window 
		event_handlers = [ { pad_start exit_screen_menu } ] 
		replace_handlers 
	} 
	SetScreenElementProps { 
		id = screen_menu 
		event_handlers = [ { pad_start exit_screen_menu } 
			{ pad_choose exit_screen_menu } 
			{ pad_back exit_screen_menu } 
			{ pad_circle exit_screen_menu } 
			{ pad_square exit_screen_menu } 
		] 
		replace_handlers 
	} 
	FireEvent type = focus target = screen_menu 
	Displayloadingscreen <screen> 
ENDSCRIPT

SCRIPT exit_screen_menu 
	IF ObjectExists id = screen_menu 
		Destroyscreenelement id = screen_menu 
	ENDIF 
	Hideloadingscreen 
	create_startup_menu 
ENDSCRIPT

SCRIPT startup_main_menu 
	SetScreenElementProps { 
		id = root_window 
		event_handlers = [ { pad_start handle_start_pressed } ] 
		replace_handlers 
	} 
	IF ObjectExists id = ns_rules 
		Destroyscreenelement id = ns_rules 
	ENDIF 
	level_select_change_level level = load_skateshop 
ENDSCRIPT

SCRIPT startup_camera_playback 
	KillSkaterCamAnim all 
	UnPauseGame 
	PauseSkaters 
	PlaySkaterCamAnim skater = 0 name = sch_overview_camera loop 
ENDSCRIPT

SCRIPT continue_career 
	SetScreenElementProps { 
		id = root_window 
		event_handlers = [ { pad_start handle_start_pressed } ] 
		replace_handlers 
	} 
	IF ObjectExists id = ns_rules 
		Destroyscreenelement id = ns_rules 
	ENDIF 
	KillSkaterCamAnim all 
	GoalManager_ShowPoints 
	GoalManager_ShowGoalPoints 
	MakeSkaterGoto StartSkating1 
	UnPauseskaters 
	skiptrack 
	IF ObjectExists id = current_menu_anchor 
		Destroyscreenelement id = current_menu_anchor 
	ENDIF 
	SetScreenElementProps { 
		id = root_window 
		tags = { menu_state = off } 
	} 
ENDSCRIPT

SCRIPT morph_ns_rules 
	BEGIN 
		fadein_fadeout text = "Copyright Neversoft 2002" 
	REPEAT 
ENDSCRIPT

SCRIPT fadein_fadeout text = "you forgot the text" 
	SetProps text = <text> 
	DoMorph time = 0 alpha = 0 
	DoMorph time = 2 alpha = 1 
	wait 5 seconds 
	DoMorph time = 2 alpha = 0 
	DoMorph time = 2 alpha = 0 
ENDSCRIPT


