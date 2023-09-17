
PreviousSfxLevel = 0 
SCRIPT CutsceneFadeIn time = 0.00000000000 
	printf "testing cutscene fade in..." 
	KillSpawnedScript name = FadeInCutscene 
	spawnscript FadeInCutscene params = { fadein_time = <time> } 
ENDSCRIPT

SCRIPT CutsceneFadeOut time = 0.00000000000 
	printf "testing cutscene fade out..." 
	FadeOutCutscene fadeout_time = <time> 
ENDSCRIPT

SCRIPT FadeInCutscene 
	IF NOT GotParam fadein_time 
		script_assert "no fadein time" 
	ENDIF 
	IF NOT ( <fadein_time> = 0 ) 
		fadetoblack on time = 0.00000000000 alpha = 1.00000000000 
		fadetoblack off time = <fadein_time> 
	ELSE 
		fadetoblack off time = 0.00000000000 
	ENDIF 
ENDSCRIPT

SCRIPT FadeOutCutscene 
	KillSpawnedScript name = FadeInCutscene 
	IF NOT GotParam fadeout_time 
		script_assert "no fadeout time" 
	ENDIF 
	fadetoblack on time = <fadeout_time> alpha = 1.00000000000 
ENDSCRIPT

last_screen_mode = standard_screen_mode 
SCRIPT CutsceneHideUI 
	ResetScore 
	pause_trick_text 
	pause_Balance_Meter 
	pause_run_timer 
	console_destroy 
	IF ScreenElementExists id = stat_completed_message 
		DestroyScreenElement id = stat_completed_message 
	ENDIF 
	speech_box_exit { anchor_id = goal_start_dialog no_pad_start } 
	kill_panel_message_if_it_exists id = death_message 
	kill_panel_message_if_it_exists id = first_time_goal_info 
	kill_panel_message_if_it_exists id = goal_complete 
	kill_panel_message_if_it_exists id = goalfail 
	kill_panel_message_if_it_exists id = current_goal 
	kill_panel_message_if_it_exists id = goal_complete 
	kill_panel_message_if_it_exists id = goal_complete_sprite 
	kill_panel_message_if_it_exists id = goal_complete_line2 
	kill_panel_message_if_it_exists id = goal_current_reward 
	kill_panel_message_if_it_exists id = perfect 
	kill_panel_message_if_it_exists id = perfect2 
	kill_blur 
ENDSCRIPT

SCRIPT CutsceneUnhideUI 
	unpause_trick_text 
	unpause_Balance_Meter 
	unpause_run_timer 
ENDSCRIPT

SCRIPT cutscene_hide_objects 
	GoalManager_HideAllGoalPeds 1 
ENDSCRIPT

SCRIPT cutscene_unhide_objects 
	GoalManager_HideAllGoalPeds 0 
ENDSCRIPT

SCRIPT UnhideLoResHeads 
	Skater : SwitchOnAtomic skater_m_head 
	Skater : SwitchOnAtomic skater_f_head 
ENDSCRIPT

SCRIPT PreCutscene 
	UnPauseMusicAndStreams 
	SetSfxReverb 0 mode = REV_MODE_CAVE 
	KillSpawnedScript name = wait_and_check_for_unplugged_controllers 
	change check_for_unplugged_controllers = 0 
	GetValueFromVolume sfxvol 
	change PreviousSfxLevel = <value> 
	change PreviousSfxLevel = ( PreviousSfxLevel * 10 ) 
	StopMusic 
	SetMusicStreamVolume PreviousSfxLevel 
	printf "***Changing Rain Sounds\' volumes if playing!!!" 
	IF IsSoundPlaying TestLight01 
		printf "****Light Rain sound 01 - setting sound params to zero" 
		SetSoundParams TestLight01 vol = 0 
	ENDIF 
	IF IsSoundPlaying TestLight02 
		printf "****Light Rain sound 02 - setting sound params to zero" 
		SetSoundParams TestLight02 vol = 0 
	ENDIF 
	IF IsSoundPlaying TestMedium02 
		printf "****Medium Rain sound 02 - setting sound params to zero" 
		SetSoundParams TestMedium02 vol = 0 
	ENDIF 
	printf "***Pausing Rain Sounds with pause_rain!!!!" 
	pause_rain 
	printf "***Stopping all streams with StopStream!" 
	StopStream 
	Skater : SkaterLoopingSound_TurnOff 
	printf "***Turned skater\'s looping sound off" 
	RunScriptOnComponentType component = SkaterLoopingSound target = SkaterLoopingSound_TurnOff 
	printf "***Running scr on all SkaterLoopingSound components - SkaterLoopingSound_TurnOff!!!" 
	SetSfxVolume 0 
	printf "***Set SFX Volume to Zero" 
	Skater : VibrateOff 
	Skater : Obj_KillSpawnedScript name = BloodSmall 
	Skater : Obj_KillSpawnedScript name = BloodSplat 
	Skater : Obj_KillSpawnedScript name = SkaterBloodOn 
	Skater : ResetSkaterParticleSystems 
	CutsceneHideUI 
	IF ScreenElementExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	GoalManager_HidePoints 
	GoalManager_HideGoalPoints 
	Skater : StatsManager_DeactivateGoals 
	GoalManager_SetCanStartGoal 0 
	IF ( <unload_goals> = 1 ) 
		GoalManager_UninitializeAllGoals 
	ENDIF 
	PauseObjects 
	PauseSpawnedScripts 
	IF NOT GotParam use_lo_res_skater_head 
		Skater : SwitchOffAtomic skater_m_head 
		Skater : SwitchOffAtomic skater_f_head 
	ENDIF 
	Skater : SwitchOnBoard 
	Skater : Hide 
	KillSpawnedScript name = FadeInCutscene 
	IF ( <unload_anims> = 1 ) 
		IF InPreFile "skaterparts.pre" 
			UnloadPreFile "skaterparts.pre" 
			cutscene_skaterparts_unloaded = 1 
		ENDIF 
		do_unload_unloadable 
	ENDIF 
	IF isNGC 
		unload_current_theme 
	ENDIF 
	SetSfxReverb 0 mode = REV_MODE_CAVE 
ENDSCRIPT

SCRIPT CutsceneStartVideo 
	CutsceneHideUI 
	CutsceneFadeOut time = 0 
	SWITCH ( current_screen_mode ) 
		CASE standard_screen_mode 
			screen_setup_letterbox 
			change last_screen_mode = standard_screen_mode 
		CASE widescreen_screen_mode 
			change last_screen_mode = widescreen_screen_mode 
		CASE letterbox_screen_mode 
			change last_screen_mode = letterbox_screen_mode 
		DEFAULT 
			printf "current screen mode = %d" d = current_screen_mode 
			script_assert "Unrecognized screen mode" 
	ENDSWITCH 
ENDSCRIPT

cutscene_skaterparts_unloaded = 0 
SCRIPT CutsceneKillObjects 
	IF IsArray CutsceneParticleTextures 
		GetArraySize CutsceneParticleTextures 
		IF ( <array_size> = 0 ) 
			printf "CutsceneParticleTextures array is empty!" 
		ELSE 
			<index> = 0 
			BEGIN 
				<nameString> = ( CutsceneParticleTextures [ <index> ] ) 
				UnloadParticleTexture <nameString> 
				<index> = ( <index> + 1 ) 
			REPEAT <array_size> 
		ENDIF 
	ENDIF 
	IF IsArray CutsceneObjectNames 
		GetArraySize CutsceneObjectNames 
		IF ( <array_size> = 0 ) 
			printf "CutsceneObjectNames array is empty!" 
		ELSE 
			<index> = 0 
			BEGIN 
				<name> = ( CutsceneObjectNames [ <index> ] ) 
				IF CompositeObjectExists name = <name> 
					<name> : Die 
				ELSE 
				ENDIF 
				<index> = ( <index> + 1 ) 
			REPEAT <array_size> 
		ENDIF 
	ENDIF 
	FlushDeadObjects 
ENDSCRIPT

SCRIPT PostCutscene 
	spawnscript wait_and_check_for_unplugged_controllers 
	SetSfxVolume PreviousSfxLevel 
	SetSfxReverb 0 mode = REV_MODE_CAVE 
	printf "*** turning skater looping sound ON!!!" 
	Skater : SkaterLoopingSound_TurnOn 
	printf "***Running scr on all SkaterLoopingSound components - SkaterLoopingSound_TurnOn!!!" 
	RunScriptOnComponentType component = SkaterLoopingSound target = SkaterLoopingSound_TurnOn 
	IF isNGC 
		reload_current_theme 
	ENDIF 
	IF ( <reload_anims> = 1 ) 
		IF ( cutscene_skaterparts_unloaded = 1 ) 
			LoadPreFile "skaterparts.pre" 
			change cutscene_skaterparts_unloaded = 0 
		ENDIF 
		do_load_unloadable 
	ENDIF 
	fadetoblack off time = 0.00000000000 
	kill_cutscene_camera_hud 
	Skater : Unhide 
	Skater : SwitchOnAtomic skater_m_head 
	Skater : SwitchOnAtomic skater_f_head 
	IF GotParam RestartNode 
		ResetSkaters node_name = <RestartNode> 
	ENDIF 
	IF NOT GotParam dont_send_skater_to_hand_brake 
		MakeSkaterGoto HandBrake 
	ENDIF 
	UnpauseObjects 
	UnpauseSpawnedScripts 
	CutsceneUnhideUI 
	GoalManager_ShowPoints 
	GoalManager_ShowGoalPoints 
	GoalManager_SetCanStartGoal 1 
	Skater : StatsManager_ActivateGoals 
	IF ( <reload_goals> = 1 ) 
		GoalManager_InitializeAllGoals 
	ELSE 
		DisplayLoadingScreen Blank 
	ENDIF 
	SWITCH ( last_screen_mode ) 
		CASE standard_screen_mode 
			screen_setup_standard 
		CASE widescreen_screen_mode 
		CASE letterbox_screen_mode 
		DEFAULT 
			printf "last screen mode = %d" d = <last_screen_mode> 
			script_assert "Unrecognized screen mode" 
	ENDSWITCH 
	SetSfxReverb 0 mode = REV_MODE_CAVE 
	printf "***UNpausing rain sounds!!!" 
	unpause_rain <...> 
ENDSCRIPT

SCRIPT cutsceneobj_add_components 
	IF GotParam skeletonName 
		CreateComponentFromStructure component = skeleton <...> skeleton = <skeletonName> 
	ENDIF 
	CreateComponentFromStructure component = model <...> UseModelLights 
ENDSCRIPT

SCRIPT draw_cutscene_panel 
	IF ObjectExists id = vo_line1 
		SetScreenElementProps { id = vo_line1 text = <line1> } 
	ELSE 
		create_panel_message id = vo_line1 text = <line1> style = panel_message_viewobj_line params = { xy = PAIR(40.00000000000, 380.00000000000) } 
	ENDIF 
ENDSCRIPT

SCRIPT kill_cutscene_panel 
	IF ObjectExists id = vo_line1 
		RunScriptOnScreenElement id = vo_line1 kill_panel_message 
	ENDIF 
ENDSCRIPT

SCRIPT spawn_next_cutscene 
	PauseObjects 
	spawnscript start_next_cutscene params = { <...> } 
ENDSCRIPT

SCRIPT start_next_cutscene 
	IF GotParam Tod_Action 
		DisplayLoadingScreen freeze 
		script_change_tod Tod_Action = <Tod_Action> 
	ENDIF 
	UnpauseObjects 
	PlayCutscene name = <name> unload_anims = <unload_anims> reload_anims = <reload_anims> exitScript = <exitScript> 
ENDSCRIPT

camera_hud_is_hidden = 0 
SCRIPT show_cutscene_camera_hud mins = 2 secs = 16 frames = 3 
	IF ScreenElementExists id = cutscene_camera_hud_anchor 
		DestroyScreenElement id = cutscene_camera_hud_anchor 
	ENDIF 
	IF GotParam for_goal 
		mins = 0 secs = 0 frames = 0 
		rec_alpha = 0 
		rec_pos = PAIR(500.00000000000, 90.00000000000) 
	ELSE 
		IF GotParam play 
			rec_alpha = 0 
		ELSE 
			rec_alpha = 1 
		ENDIF 
		rec_pos = PAIR(500.00000000000, 50.00000000000) 
	ENDIF 
	SetScreenElementLock off id = root_window 
	CreateScreenElement { 
		type = ContainerElement 
		id = cutscene_camera_hud_anchor 
		parent = root_window 
		pos = PAIR(320.00000000000, 240.00000000000) 
		dims = PAIR(640.00000000000, 480.00000000000) 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = cutscene_camera_hud_anchor 
		id = video_screen 
		texture = videoscreen 
		pos = PAIR(320.00000000000, 240.00000000000) 
		just = [ center center ] 
		scale = PAIR(5.00000000000, 10.00000000000) 
		alpha = 0.30000001192 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		id = camera_hud_line 
		parent = cutscene_camera_hud_anchor 
		texture = white2 
		pos = PAIR(0.00000000000, 0.00000000000) 
		just = [ left center ] 
		scale = PAIR(100.00000000000, 0.10000000149) 
		alpha = 0.50000000000 
	} 
	IF GotParam play 
		CreateScreenElement { 
			type = TextElement 
			parent = cutscene_camera_hud_anchor 
			id = play 
			pos = <rec_pos> 
			text = "PLAY" 
			font = small 
			just = [ left top ] 
			scale = 1.50000000000 
			rgba = [ 100 100 100 128 ] 
			alpha = 0.80000001192 
		} 
	ENDIF 
	CreateScreenElement { 
		type = ContainerElement 
		id = rec_anchor 
		parent = cutscene_camera_hud_anchor 
		pos = PAIR(320.00000000000, 240.00000000000) 
		dims = PAIR(640.00000000000, 480.00000000000) 
		alpha = <rec_alpha> 
	} 
	CreateScreenElement { 
		type = TextElement 
		parent = rec_anchor 
		id = rec 
		pos = <rec_pos> 
		text = "REC" 
		font = small 
		just = [ left top ] 
		scale = 1.50000000000 
		rgba = [ 100 0 0 128 ] 
		alpha = 0.80000001192 
	} 
	GetStackedScreenElementPos X id = rec offset = PAIR(10.00000000000, 16.00000000000) 
	CreateScreenElement { 
		type = SpriteElement 
		id = rec_dot 
		parent = rec_anchor 
		texture = recdot 
		pos = <pos> 
		just = [ left center ] 
		scale = 1.50000000000 
		alpha = 0.80000001192 
	} 
	scale = 1.50000000000 
	alpha = 0.60000002384 
	font = dialog 
	CreateScreenElement { 
		type = TextElement 
		parent = cutscene_camera_hud_anchor 
		id = mins2 
		pos = PAIR(450.00000000000, 380.00000000000) 
		text = "0" 
		font = <font> 
		just = [ right top ] 
		scale = <scale> 
		alpha = <alpha> 
		rgba = <rgba> 
	} 
	GetStackedScreenElementPos X id = <id> offset = PAIR(23.00000000000, 0.00000000000) 
	CreateScreenElement { 
		type = TextElement 
		parent = cutscene_camera_hud_anchor 
		id = mins 
		pos = <pos> 
		text = "0" 
		font = <font> 
		just = [ right top ] 
		scale = <scale> 
		alpha = <alpha> 
		rgba = <rgba> 
	} 
	GetStackedScreenElementPos X id = <id> offset = PAIR(5.00000000000, -2.00000000000) 
	CreateScreenElement { 
		type = TextElement 
		parent = cutscene_camera_hud_anchor 
		pos = <pos> 
		text = ":" 
		font = <font> 
		just = [ left top ] 
		scale = <scale> 
		alpha = <alpha> 
		rgba = <rgba> 
	} 
	GetStackedScreenElementPos X id = <id> offset = PAIR(23.00000000000, 2.00000000000) 
	CreateScreenElement { 
		type = TextElement 
		parent = cutscene_camera_hud_anchor 
		id = secs2 
		pos = <pos> 
		text = "0" 
		font = <font> 
		just = [ right top ] 
		scale = <scale> 
		alpha = <alpha> 
		rgba = <rgba> 
	} 
	GetStackedScreenElementPos X id = <id> offset = PAIR(23.00000000000, 0.00000000000) 
	CreateScreenElement { 
		type = TextElement 
		parent = cutscene_camera_hud_anchor 
		id = secs 
		pos = <pos> 
		text = "0" 
		font = <font> 
		just = [ right top ] 
		scale = <scale> 
		alpha = <alpha> 
		rgba = <rgba> 
	} 
	GetStackedScreenElementPos X id = <id> offset = PAIR(5.00000000000, -2.00000000000) 
	CreateScreenElement { 
		type = TextElement 
		parent = cutscene_camera_hud_anchor 
		pos = <pos> 
		text = ":" 
		font = <font> 
		just = [ left top ] 
		scale = <scale> 
		alpha = <alpha> 
		rgba = <rgba> 
	} 
	GetStackedScreenElementPos X id = <id> offset = PAIR(23.00000000000, 2.00000000000) 
	CreateScreenElement { 
		type = TextElement 
		parent = cutscene_camera_hud_anchor 
		id = frames2 
		pos = <pos> 
		text = "0" 
		font = <font> 
		just = [ right top ] 
		scale = <scale> 
		alpha = <alpha> 
		rgba = <rgba> 
	} 
	GetStackedScreenElementPos X id = <id> offset = PAIR(23.00000000000, 0.00000000000) 
	CreateScreenElement { 
		type = TextElement 
		parent = cutscene_camera_hud_anchor 
		id = frames 
		pos = <pos> 
		text = "0" 
		font = <font> 
		just = [ right top ] 
		scale = <scale> 
		alpha = <alpha> 
		rgba = <rgba> 
	} 
	mins2 = ( <mins> / 10 ) 
	mins1 = ( <mins> - ( <mins2> * 10 ) ) 
	secs2 = ( <secs> / 10 ) 
	secs1 = ( <secs> - ( <secs2> * 10 ) ) 
	frames2 = ( <frames> / 10 ) 
	frames1 = ( <frames> - ( <frames2> * 10 ) ) 
	FormatText textname = min_text "%m" m = <mins1> 
	SetScreenElementProps id = mins text = <min_text> 
	FormatText textname = min_text "%m" m = <mins2> 
	SetScreenElementProps id = mins2 text = <min_text> 
	FormatText textname = sec_text "%s" s = <secs1> 
	SetScreenElementProps id = secs text = <sec_text> 
	FormatText textname = sec_text "%s" s = <secs2> 
	SetScreenElementProps id = secs2 text = <sec_text> 
	FormatText textname = frame_text "%f" f = <frames1> 
	SetScreenElementProps id = frames text = <frame_text> 
	FormatText textname = frame_text "%f" f = <frames2> 
	SetScreenElementProps id = frames2 text = <frame_text> 
	mins : SetTags frames = <frames> secs = <secs> mins = <mins> 
	IF GotParam fade 
		RunScriptOnScreenElement id = rec_dot cutscene_camera_hud_fade_in 
	ENDIF 
	RunScriptOnScreenElement id = video_screen flicker_video_screen 
	RunScriptOnScreenElement id = camera_hud_line morph_camera_hud_line 
	RunScriptOnScreenElement id = rec_dot blink_rec_dot 
	IF NOT GotParam for_goal 
		RunScriptOnScreenElement id = secs camera_hud_count 
	ENDIF 
ENDSCRIPT

SCRIPT kill_cutscene_camera_hud 
	IF GotParam fade 
		RunScriptOnScreenElement id = rec_dot fadetoblack params = { on time = 0.50000000000 alpha = 1.00000000000 z_priority = 5 } 
		RunScriptOnScreenElement id = rec_dot really_kill_cutscene_camera_hud 
	ELSE 
		IF ScreenElementExists id = cutscene_camera_hud_anchor 
			DestroyScreenElement id = cutscene_camera_hud_anchor 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT cutscene_camera_hud_fade_in 
	fadetoblack on time = 0 alpha = 1.00000000000 z_priority = 5 
	wait 0.20000000298 seconds 
	fadetoblack off time = 0.50000000000 
ENDSCRIPT

SCRIPT really_kill_cutscene_camera_hud 
	wait 0.69999998808 seconds 
	fadetoblack off time = 0 
	IF ScreenElementExists id = cutscene_camera_hud_anchor 
		DestroyScreenElement id = cutscene_camera_hud_anchor 
	ENDIF 
ENDSCRIPT

SCRIPT hide_cutscene_camera_hud 
	IF ScreenElementExists id = cutscene_camera_hud_anchor 
		DoScreenElementMorph id = cutscene_camera_hud_anchor alpha = 0 
	ENDIF 
ENDSCRIPT

SCRIPT unhide_cutscene_camera_hud 
	IF ScreenElementExists id = cutscene_camera_hud_anchor 
		DoScreenElementMorph id = cutscene_camera_hud_anchor alpha = 1 
	ENDIF 
ENDSCRIPT

SCRIPT blink_rec_dot 
	BEGIN 
		DoScreenElementMorph id = rec_dot alpha = 0.80000001192 
		wait 0.50000000000 seconds 
		DoScreenElementMorph id = rec_dot alpha = 0 
		wait 0.50000000000 seconds 
	REPEAT 
ENDSCRIPT

SCRIPT flicker_video_screen time = 0.05000000075 
	BEGIN 
		DoScreenElementMorph id = video_screen alpha = 0.30000001192 time = <time> 
		wait <time> seconds 
		DoScreenElementMorph id = video_screen alpha = 0.22499999404 time = <time> 
		wait <time> seconds 
	REPEAT 
ENDSCRIPT

SCRIPT morph_camera_hud_line time = 1.50000000000 
	BEGIN 
		DoScreenElementMorph id = camera_hud_line pos = PAIR(0.00000000000, 480.00000000000) time = <time> 
		wait <time> seconds 
		DoScreenElementMorph id = camera_hud_line pos = PAIR(0.00000000000, 0.00000000000) 
	REPEAT 
ENDSCRIPT

SCRIPT camera_hud_count 
	BEGIN 
		wait 2 gameframes 
		camera_hud_count_one 
	REPEAT 
ENDSCRIPT

SCRIPT camera_hud_count_one 
	mins : GetTags 
	frames = ( <frames> + 1 ) 
	IF ( <frames> > 29 ) 
		frames = 0 
		secs = ( <secs> + 1 ) 
		IF ( <secs> > 59 ) 
			secs = 0 
			mins = ( <mins> + 1 ) 
			mins2 = ( <mins> / 10 ) 
			mins1 = ( <mins> - ( <mins2> * 10 ) ) 
			FormatText textname = min_text "%m" m = <mins1> 
			SetScreenElementProps id = mins text = <min_text> 
			FormatText textname = min_text "%m" m = <mins2> 
			SetScreenElementProps id = mins2 text = <min_text> 
		ENDIF 
		secs2 = ( <secs> / 10 ) 
		secs1 = ( <secs> - ( <secs2> * 10 ) ) 
		FormatText textname = sec_text "%s" s = <secs1> 
		SetScreenElementProps id = secs text = <sec_text> 
		FormatText textname = sec_text "%s" s = <secs2> 
		SetScreenElementProps id = secs2 text = <sec_text> 
	ENDIF 
	frames2 = ( <frames> / 10 ) 
	frames1 = ( <frames> - ( <frames2> * 10 ) ) 
	FormatText textname = frame_text "%f" f = <frames1> 
	SetScreenElementProps id = frames text = <frame_text> 
	FormatText textname = frame_text "%f" f = <frames2> 
	SetScreenElementProps id = frames2 text = <frame_text> 
	mins : SetTags frames = <frames> secs = <secs> mins = <mins> 
ENDSCRIPT

SCRIPT camera_hud_breakup_frames 
	IF NOT ScreenElementExists id = mins 
		RETURN 
	ENDIF 
	IF ( <millisecs> > 60000 ) 
		mins = ( <millisecs> / 6000 ) 
		millisecs = ( <millisecs> - ( <mins> * 6000 ) ) 
	ELSE 
		mins = 0 
	ENDIF 
	IF ( <millisecs> > 1000 ) 
		secs = ( <millisecs> / 1000 ) 
		millisecs = ( <millisecs> - ( <secs> * 1000 ) ) 
	ELSE 
		secs = 0 
	ENDIF 
	frames = ( <millisecs> / 17 ) 
	mins2 = ( <mins> / 10 ) 
	mins1 = ( <mins> - ( <mins2> * 10 ) ) 
	FormatText textname = min_text "%m" m = <mins1> 
	SetScreenElementProps id = mins text = <min_text> 
	FormatText textname = min_text "%m" m = <mins2> 
	SetScreenElementProps id = mins2 text = <min_text> 
	secs2 = ( <secs> / 10 ) 
	secs1 = ( <secs> - ( <secs2> * 10 ) ) 
	FormatText textname = sec_text "%s" s = <secs1> 
	SetScreenElementProps id = secs text = <sec_text> 
	FormatText textname = sec_text "%s" s = <secs2> 
	SetScreenElementProps id = secs2 text = <sec_text> 
	frames2 = ( <frames> / 10 ) 
	frames1 = ( <frames> - ( <frames2> * 10 ) ) 
	FormatText textname = frame_text "%f" f = <frames1> 
	SetScreenElementProps id = frames text = <frame_text> 
	FormatText textname = frame_text "%f" f = <frames2> 
	SetScreenElementProps id = frames2 text = <frame_text> 
ENDSCRIPT

SCRIPT show_cutscene_hangover_hud 
	IF ScreenElementExists id = cutscene_hangover_hud_anchor 
		DestroyScreenElement id = cutscene_hangover_hud_anchor 
	ENDIF 
	SetScreenElementLock off id = root_window 
	CreateScreenElement { 
		type = ContainerElement 
		id = cutscene_hangover_hud_anchor 
		parent = root_window 
		pos = PAIR(320.00000000000, 240.00000000000) 
		dims = PAIR(640.00000000000, 480.00000000000) 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = cutscene_hangover_hud_anchor 
		id = hangover_screen 
		texture = hangoverscreen 
		pos = PAIR(320.00000000000, 240.00000000000) 
		just = [ center center ] 
		scale = PAIR(5.00000000000, 10.00000000000) 
		alpha = 0.15000000596 
	} 
ENDSCRIPT

SCRIPT kill_cutscene_hangover_hud 
	DestroyScreenElement id = cutscene_hangover_hud_anchor 
ENDSCRIPT

SCRIPT cutscene_hangover_hud_fade_in 
	setscreenBlur 200 
	fadetoblack on time = 0 alpha = 1.00000000000 z_priority = 5 
	show_cutscene_hangover_hud 
	wait 0.20000000298 seconds 
	fadetoblack off time = 0.50000000000 
ENDSCRIPT

SCRIPT really_kill_cutscene_hangover_hud 
	setscreenBlur 0 
	wait 0.69999998808 seconds 
	fadetoblack off time = 0 
	IF ScreenElementExists id = cutscene_hangover_hud_anchor 
		DestroyScreenElement id = cutscene_hangover_hud_anchor 
	ENDIF 
ENDSCRIPT

SCRIPT hide_cutscene_hangover_hud 
	setscreenBlur 0 
	IF ScreenElementExists id = cutscene_hangover_hud_anchor 
		DoScreenElementMorph id = cutscene_hangover_hud_anchor alpha = 0 
	ENDIF 
ENDSCRIPT

SCRIPT unhide_cutscene_hangover_hud 
	setscreenBlur 200 
	IF ScreenElementExists id = cutscene_hangover_hud_anchor 
		DoScreenElementMorph id = cutscene_hangover_hud_anchor alpha = 1 
	ENDIF 
ENDSCRIPT

SCRIPT make_custom_video_intro 
	PlayStream Team_Movie_Intro 
	show_universal_hud 
	wait 3.50000000000 seconds 
	videointro_hud_fade_in 
	show_videointro_hud 
	wait 100 gameframe 
	really_kill_videointro_hud 
	kill_black2 
	videointro_hud_fade_in2 
	show_videointro_hud2 
	wait 130 gameframe 
	really_kill_videointro_hud2 
	show_underground_hud 
	kill_black 
	wait 380 gameframe 
	IF ScreenElementExists id = underground_hud_anchor 
		DestroyScreenElement id = underground_hud_anchor 
	ENDIF 
ENDSCRIPT

SCRIPT show_videointro_hud 
	IF ScreenElementExists id = videointro_hud_anchor 
		DestroyScreenElement id = videointro_hud_anchor 
	ENDIF 
	SetScreenElementLock off id = root_window 
	CreateScreenElement { 
		type = ContainerElement 
		id = videointro_hud_anchor 
		parent = root_window 
		pos = PAIR(320.00000000000, 240.00000000000) 
		dims = PAIR(640.00000000000, 480.00000000000) 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = videointro_hud_anchor 
		id = videointro_black 
		texture = black 
		pos = PAIR(320.00000000000, 240.00000000000) 
		just = [ center center ] 
		scale = PAIR(200.00000000000, 200.00000000000) 
		rgba = [ 0 0 0 128 ] 
		z_priority = -5 
		alpha = 1 
		z_priority = 50000 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = videointro_hud_anchor 
		id = videointro_screen 
		texture = videoscreen 
		pos = PAIR(320.00000000000, 240.00000000000) 
		just = [ center center ] 
		scale = PAIR(5.00000000000, 10.00000000000) 
		alpha = 0.10000000149 
		z_priority = 1395 
		z_priority = 50001 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = videointro_hud_anchor 
		id = videowhite 
		texture = videowhite 
		pos = PAIR(320.00000000000, 240.00000000000) 
		just = [ center center ] 
		scale = PAIR(7.59999990463, 8.00000000000) 
		rgba = [ 125 125 95 40 ] 
		alpha = 0.40000000596 
		z_priority = 1396 
		z_priority = 500012 
		rot_angle = 9 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = videointro_hud_anchor 
		id = bg_icon 
		texture = go_fail 
		pos = PAIR(320.00000000000, 250.00000000000) 
		just = [ center center ] 
		scale = PAIR(1.20000004768, 1.20000004768) 
		rgba = [ 128 128 128 10 ] 
		z_priority = 500013 
		rot_angle = 5 
	} 
	CreateScreenElement { 
		type = TextElement 
		parent = videointro_hud_anchor 
		id = peralta_name 
		pos = PAIR(150.00000000000, 190.00000000000) 
		text = "Peralta Productions Presents" 
		font = dialog 
		just = [ left , top ] 
		scale = 1.10000002384 
		rgba = [ 128 128 128 100 ] 
		z_priority = 1397 
		z_priority = 50004 
	} 
	RunScriptOnScreenElement id = videointro_screen flicker_videointro 
	RunScriptOnScreenElement id = peralta_name flicker_textintro 
	RunScriptOnScreenElement id = bg_icon flicker_skullintro 
ENDSCRIPT

SCRIPT videointro_hud_fade_in 
	setscreenBlur 70 
	fadetoblack on time = 0 alpha = 1.00000000000 z_priority = 10000 
	make_black_in2 
	wait 1.39999997616 seconds 
	show_videointro_hud 
	make_black_out2 
	wait 0.20000000298 seconds 
	fadetoblack off time = 0.50000000000 
ENDSCRIPT

SCRIPT really_kill_videointro_hud 
	setscreenBlur 1 
	make_black_out2 
	fadetoblack off time = 0.30000001192 
	IF ScreenElementExists id = videointro_hud_anchor 
		DestroyScreenElement id = videointro_hud_anchor 
	ENDIF 
ENDSCRIPT

SCRIPT flicker_textintro time = 0.05000000075 
	BEGIN 
		DoScreenElementMorph id = peralta_name alpha = 1 time = <time> pos = PAIR(150.00000000000, 189.00000000000) 
		wait <time> seconds 
		DoScreenElementMorph id = peralta_name alpha = 0.69999998808 time = <time> pos = PAIR(150.00000000000, 190.00000000000) 
		wait <time> seconds 
	REPEAT 
ENDSCRIPT

SCRIPT flicker_skullintro time = 0.05000000075 
	BEGIN 
		DoScreenElementMorph id = bg_icon alpha = 1 time = <time> 
		wait <time> seconds 
		DoScreenElementMorph id = bg_icon alpha = 0.69999998808 time = <time> 
		wait <time> seconds 
	REPEAT 
ENDSCRIPT

SCRIPT flicker_videointro time = 0.05000000075 
	BEGIN 
		DoScreenElementMorph id = videointro_screen alpha = 0.07000000030 time = <time> scale = PAIR(8.01000022888, 7.00000000000) 
		wait <time> seconds 
		DoScreenElementMorph id = videointro_screen alpha = 0.21999999881 time = <time> scale = PAIR(8.00000000000, 7.00000000000) 
		wait <time> seconds 
	REPEAT 
ENDSCRIPT

SCRIPT show_videointro_hud2 
	IF ScreenElementExists id = videointro_hud_anchor2 
		DestroyScreenElement id = videointro_hud_anchor2 
	ENDIF 
	SetScreenElementLock off id = root_window 
	CreateScreenElement { 
		type = ContainerElement 
		id = videointro_hud_anchor2 
		parent = root_window 
		pos = PAIR(320.00000000000, 240.00000000000) 
		dims = PAIR(640.00000000000, 480.00000000000) 
		z_priority = 50 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = videointro_hud_anchor2 
		id = videointro_black2 
		texture = black 
		pos = PAIR(320.00000000000, 240.00000000000) 
		just = [ center center ] 
		scale = PAIR(200.00000000000, 200.00000000000) 
		rgba = [ 0 0 0 128 ] 
		z_priority = -5 
		alpha = 1 
		z_priority = 50000 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = videointro_hud_anchor2 
		id = videointro_screen2 
		texture = videoscreen 
		pos = PAIR(320.00000000000, 240.00000000000) 
		just = [ center center ] 
		scale = PAIR(5.00000000000, 10.00000000000) 
		alpha = 0.10000000149 
		z_priority = 50001 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = videointro_hud_anchor2 
		id = videowhite2 
		texture = videowhite 
		pos = PAIR(320.00000000000, 240.00000000000) 
		just = [ center center ] 
		scale = PAIR(9.00000000000, 7.50000000000) 
		rgba = [ 12 42 68 70 ] 
		alpha = 0.60000002384 
		z_priority = 50007 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = videointro_hud_anchor2 
		id = star1 
		texture = PA_goals 
		pos = PAIR(100.00000000000, 110.00000000000) 
		just = [ center center ] 
		scale = PAIR(2.00000000000, 2.00000000000) 
		rgba = [ 0 0 0 128 ] 
		alpha = 0.80000001192 
		rot_angle = -3 
		z_priority = 50003 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = videointro_hud_anchor2 
		id = star2 
		texture = PA_goals 
		pos = PAIR(480.00000000000, 310.00000000000) 
		just = [ center center ] 
		scale = PAIR(2.00000000000, 2.00000000000) 
		rgba = [ 0 0 0 128 ] 
		alpha = 0.89999997616 
		rot_angle = -7 
		z_priority = 50004 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = videointro_hud_anchor2 
		id = star3 
		texture = PA_goals 
		pos = PAIR(430.00000000000, 120.00000000000) 
		just = [ center center ] 
		scale = PAIR(1.29999995232, 1.29999995232) 
		rgba = [ 0 0 0 128 ] 
		alpha = 0.80000001192 
		rot_angle = 18 
		z_priority = 50004 
	} 
	GoalManager_GetTeam 
	CreateScreenElement { 
		type = TextElement 
		parent = videointro_hud_anchor2 
		id = team name 
		pos = PAIR(310.00000000000, 190.00000000000) 
		text = ( <team> . team_name ) 
		font = small 
		just = [ center top ] 
		scale = 2.20000004768 
		rgba = [ 128 77 0 100 ] 
		z_priority = 50008 
	} 
	CreateScreenElement { 
		type = TextElement 
		parent = videointro_hud_anchor2 
		id = a 
		pos = PAIR(110.00000000000, 120.00000000000) 
		text = "A" 
		font = dialog 
		just = [ left , top ] 
		scale = 1.50000000000 
		rgba = [ 128 73 0 88 ] 
		z_priority = 50009 
	} 
	CreateScreenElement { 
		type = TextElement 
		parent = videointro_hud_anchor2 
		id = videoname 
		pos = PAIR(420.00000000000, 245.00000000000) 
		text = "VIDEO" 
		font = dialog 
		just = [ left , top ] 
		scale = 2.50000000000 
		rgba = [ 128 73 0 78 ] 
		z_priority = 50009 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = videointro_hud_anchor2 
		id = videoborder2 
		texture = videoborder 
		pos = PAIR(320.00000000000, 210.00000000000) 
		just = [ center center ] 
		rgba = [ 128 73 0 128 ] 
		scale = PAIR(5.00000000000, 1.50000000000) 
		rot_angle = -3 
		alpha = 0.69999998808 
		z_priority = 50007 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = videointro_hud_anchor2 
		id = videoborder3 
		texture = videoborder 
		pos = PAIR(320.00000000000, 220.00000000000) 
		just = [ center center ] 
		rgba = [ 0 0 0 128 ] 
		scale = PAIR(6.00000000000, 2.00000000000) 
		rot_angle = 4 
		alpha = 0.80000001192 
		z_priority = -8 
		z_priority = 50005 
	} 
	RunScriptOnScreenElement id = videointro_screen2 flicker_videointro2 
ENDSCRIPT

SCRIPT videointro_hud_fade_in2 
	setscreenBlur 20 
	fadetoblack on time = 0 alpha = 1.00000000000 z_priority = 100000 
	make_black_in 
	wait 0.02500000037 seconds 
	show_videointro_hud2 
	make_black_out 
	wait 0.20000000298 seconds 
	fadetoblack off time = 0.20000000298 
ENDSCRIPT

SCRIPT flicker_videointro2 time = 0.09499999881 
	BEGIN 
		DoScreenElementMorph id = videointro_screen2 alpha = 0.10000000149 time = <time> rot_angle = 0 
		wait <time> seconds 
		DoScreenElementMorph id = videointro_screen2 alpha = 0.17499999702 time = <time> rot_angle = 360 
		wait <time> seconds 
	REPEAT 
ENDSCRIPT

SCRIPT really_kill_videointro_hud2 
	setscreenBlur 4 
	IF ScreenElementExists id = videointro_hud_anchor2 
		DestroyScreenElement id = videointro_hud_anchor2 
	ENDIF 
ENDSCRIPT

SCRIPT make_black_in 
	CreateScreenElement { 
		type = SpriteElement 
		parent = root_window 
		id = videointro_black3 
		texture = black 
		pos = PAIR(320.00000000000, 240.00000000000) 
		just = [ center center ] 
		scale = PAIR(200.00000000000, 200.00000000000) 
		rgba = [ 0 0 0 128 ] 
		z_priority = -5 
		alpha = 0 
		z_priority = 4560040 
	} 
	DoScreenElementMorph id = videointro_black3 alpha = 1 time = 0 
ENDSCRIPT

SCRIPT kill_black 
	DestroyScreenElement id = videointro_black3 
ENDSCRIPT

SCRIPT make_black_out 
	DoScreenElementMorph id = videointro_black3 alpha = 0 time = 0.50000000000 
ENDSCRIPT

SCRIPT make_black_in2 
	CreateScreenElement { 
		type = SpriteElement 
		parent = root_window 
		id = videointro_black4 
		texture = black 
		pos = PAIR(320.00000000000, 240.00000000000) 
		just = [ center center ] 
		scale = PAIR(200.00000000000, 200.00000000000) 
		rgba = [ 0 0 0 128 ] 
		z_priority = -5 
		alpha = 0 
		z_priority = 160080 
	} 
	DoScreenElementMorph id = videointro_black4 alpha = 1 time = 0 
ENDSCRIPT

SCRIPT make_black_out2 
	DoScreenElementMorph id = videointro_black4 alpha = 0 time = 0 
ENDSCRIPT

SCRIPT kill_black2 
	DestroyScreenElement id = videointro_black4 
ENDSCRIPT

SCRIPT show_universal_hud 
	IF ScreenElementExists id = universal_hud_anchor 
		DestroyScreenElement id = universal_hud_anchor 
	ENDIF 
	SetScreenElementLock off id = root_window 
	CreateScreenElement { 
		type = ContainerElement 
		id = universal_hud_anchor 
		parent = root_window 
		pos = PAIR(320.00000000000, 240.00000000000) 
		dims = PAIR(640.00000000000, 480.00000000000) 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = universal_hud_anchor 
		id = universal_black 
		texture = white2 
		pos = PAIR(0.00000000000, 0.00000000000) 
		just = [ top left ] 
		scale = PAIR(100.00000000000, 100.00000000000) 
		rgba = [ 20 20 20 128 ] 
		z_priority = -5 
		alpha = 1 
		z_priority = 50000 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = universal_hud_anchor 
		id = universalleft_screen 
		texture = white2 
		pos = PAIR(0.00000000000, 0.00000000000) 
		just = [ top left ] 
		rgba = [ 110 110 110 128 ] 
		scale = PAIR(40.00000000000, 100.00000000000) 
		alpha = 1 
		z_priority = 1395 
		z_priority = 50001 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = universal_hud_anchor 
		id = horizontal_black 
		texture = white 
		pos = PAIR(0.00000000000, 224.00000000000) 
		just = [ top left ] 
		scale = PAIR(200.00000000000, 1.00000000000) 
		rgba = [ 10 10 10 128 ] 
		z_priority = -5 
		alpha = 1 
		z_priority = 50002 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = universal_hud_anchor 
		id = horizontal_black2 
		texture = white 
		pos = PAIR(320.00000000000, 0.00000000000) 
		just = [ top left ] 
		scale = PAIR(1.00000000000, 200.00000000000) 
		rgba = [ 10 10 10 128 ] 
		z_priority = -5 
		alpha = 1 
		z_priority = 50002 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = universal_hud_anchor 
		id = universal_cirle2 
		texture = hoop 
		pos = PAIR(226.00000000000, 130.00000000000) 
		just = [ top left ] 
		scale = PAIR(3.00000000000, 3.00000000000) 
		rgba = [ 128 128 128 188 ] 
		z_priority = -5 
		alpha = 0.60000002384 
		z_priority = 50003 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = universal_hud_anchor 
		id = universal_cirle 
		texture = hoop 
		pos = PAIR(161.00000000000, 70.00000000000) 
		just = [ top left ] 
		scale = PAIR(5.00000000000, 5.00000000000) 
		rgba = [ 10 10 10 58 ] 
		z_priority = -5 
		alpha = 0.60000002384 
		z_priority = 60003 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = universal_hud_anchor 
		id = videointro_screen_universal 
		texture = videoscreen 
		pos = PAIR(320.00000000000, 240.00000000000) 
		just = [ center center ] 
		scale = PAIR(10.00000000000, 11.00000000000) 
		rgba = [ 40 40 40 128 ] 
		alpha = 0.60000002384 
		z_priority = 1395 
		z_priority = 60001 
		rot_angle = 90 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = universal_hud_anchor 
		id = universalwhite 
		texture = videowhite 
		pos = PAIR(320.00000000000, 240.00000000000) 
		just = [ center center ] 
		scale = PAIR(7.59999990463, 8.00000000000) 
		rgba = [ 40 40 40 38 ] 
		alpha = 0.80000001192 
		z_priority = 1396 
		z_priority = 50002 
		rot_angle = 9 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = universal_hud_anchor 
		id = universal_grunge 
		texture = hangoverscreen 
		pos = PAIR(320.00000000000, 240.00000000000) 
		rgba = [ 30 30 30 90 ] 
		just = [ center center ] 
		scale = PAIR(5.00000000000, 10.00000000000) 
		alpha = 0.15000000596 
		z_priority = 500015 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = universal_hud_anchor 
		id = videointro_screen_piepiece 
		texture = piepiece 
		pos = PAIR(320.00000000000, 220.00000000000) 
		just = [ center center ] 
		scale = PAIR(6.00000000000, 6.00000000000) 
		alpha = 0.30000001192 
		z_priority = 1395 
		z_priority = 500010 
	} 
	CreateScreenElement { 
		type = TextElement 
		parent = universal_hud_anchor 
		id = number_3 
		pos = PAIR(292.00000000000, 170.00000000000) 
		text = "4" 
		font = small 
		just = [ left , top ] 
		scale = PAIR(4.09999990463, 5.19999980927) 
		rgba = [ 60 60 60 98 ] 
		alpha = 0 
		z_priority = 500011 
	} 
	CreateScreenElement { 
		type = TextElement 
		parent = universal_hud_anchor 
		id = number_2 
		pos = PAIR(295.00000000000, 170.00000000000) 
		text = "3" 
		font = small 
		just = [ left , top ] 
		scale = PAIR(4.09999990463, 5.19999980927) 
		rgba = [ 60 60 60 98 ] 
		alpha = 0 
		z_priority = 500012 
	} 
	CreateScreenElement { 
		type = TextElement 
		parent = universal_hud_anchor 
		id = number_1 
		pos = PAIR(297.00000000000, 170.00000000000) 
		text = "2" 
		font = small 
		just = [ left , top ] 
		scale = PAIR(4.09999990463, 5.19999980927) 
		rgba = [ 60 60 60 98 ] 
		alpha = 0 
		z_priority = 500013 
	} 
	RunScriptOnScreenElement id = videointro_screen_universal flicker_videointro3 
	RunScriptOnScreenElement id = videointro_screen_piepiece spin_piepiece_1 
	RunScriptOnScreenElement id = number_3 show_number_3 
ENDSCRIPT

SCRIPT flicker_videointro3 time = 0.05000000075 
	BEGIN 
		wait 0.40000000596 second 
		DoScreenElementMorph id = videointro_screen_universal time = <time> scale = PAIR(11.00000000000, 12.00000000000) pos = PAIR(320.00000000000, 240.00000000000) 
		wait <time> seconds 
		DoScreenElementMorph id = videointro_screen_universal time = <time> scale = PAIR(30.00000000000, 12.00000000000) pos = PAIR(330.00000000000, 240.00000000000) 
		wait <time> seconds 
	REPEAT 
ENDSCRIPT

SCRIPT spin_piepiece_1 time = 3.50000000000 
	DoScreenElementMorph id = videointro_screen_piepiece time = <time> rot_angle = 0 
	DoScreenElementMorph id = videointro_screen_piepiece time = <time> rot_angle = 1080 
	wait <time> seconds 
	kill_universal_leader 
	wait 2 second 
ENDSCRIPT

SCRIPT show_number_3 
	DoScreenElementMorph id = number_3 alpha = 0 time = 0 
	DoScreenElementMorph id = number_3 alpha = 1 time = 0.02999999933 scale = PAIR(4.09999990463, 5.19999980927) 
	wait 1.10000002384 seconds 
	DoScreenElementMorph id = number_3 alpha = 0 time = 0 
	RunScriptOnScreenElement id = number_2 show_number_2 
ENDSCRIPT

SCRIPT show_number_2 
	DoScreenElementMorph id = number_2 alpha = 0 time = 0 
	DoScreenElementMorph id = number_2 alpha = 1 time = 0.02999999933 scale = PAIR(4.09999990463, 5.19999980927) 
	wait 1.10000002384 seconds 
	DoScreenElementMorph id = number_2 alpha = 0 time = 0 
	RunScriptOnScreenElement id = number_1 show_number_1 
ENDSCRIPT

SCRIPT show_number_1 
	DoScreenElementMorph id = number_1 alpha = 0 time = 0 
	DoScreenElementMorph id = number_1 alpha = 1 time = 0.02999999933 scale = PAIR(4.09999990463, 5.19999980927) 
	wait 1.50000000000 seconds 
	DoScreenElementMorph id = number_1 alpha = 0 time = 0 
ENDSCRIPT

SCRIPT kill_universal_leader 
	setscreenBlur 1 
	fadetoblack off time = 0.30000001192 
	IF ScreenElementExists id = universal_hud_anchor 
		DestroyScreenElement id = universal_hud_anchor 
		wait 2 second 
	ENDIF 
ENDSCRIPT

SCRIPT show_underground_hud 
	IF ScreenElementExists id = underground_hud_anchor 
		DestroyScreenElement id = underground_hud_anchor 
	ENDIF 
	SetScreenElementLock off id = root_window 
	CreateScreenElement { 
		type = ContainerElement 
		id = underground_hud_anchor 
		parent = root_window 
		pos = PAIR(320.00000000000, 240.00000000000) 
		dims = PAIR(640.00000000000, 480.00000000000) 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = underground_hud_anchor 
		id = underground_black 
		texture = white2 
		pos = PAIR(-30.00000000000, 63.00000000000) 
		just = [ top left ] 
		scale = PAIR(100.00000000000, 38.20000076294) 
		rgba = [ 2 8 12 128 ] 
		z_priority = -5 
		alpha = 1 
		z_priority = 1000000 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = underground_hud_anchor 
		id = underground_black2 
		texture = white2 
		pos = PAIR(240.00000000000, 63.00000000000) 
		just = [ center center ] 
		scale = PAIR(100.00000000000, 200.00000000000) 
		rgba = [ 0 0 0 128 ] 
		z_priority = -5 
		alpha = 1 
		z_priority = 100000000 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = underground_hud_anchor 
		id = borderbg 
		texture = videoborder 
		pos = PAIR(0.00000000000, 43.00000000000) 
		just = [ top left ] 
		scale = PAIR(10.00000000000, 3.00000000000) 
		rgba = [ 0 0 0 128 ] 
		z_priority = -5 
		alpha = 0.60000002384 
		z_priority = 1000001 
	} 
	CreateScreenElement { 
		type = TextElement 
		parent = underground_hud_anchor 
		id = under_1 
		pos = PAIR(52.00000000000, 190.00000000000) 
		text = "UNDERGROUND" 
		font = testtitle 
		just = [ left , top ] 
		scale = ( 2 ) 
		rgba = [ 114 23 13 128 ] 
		alpha = 0 
		z_priority = 10000003 
	} 
	CreateScreenElement { 
		type = TextElement 
		parent = underground_hud_anchor 
		id = under_2 
		pos = PAIR(52.00000000000, 190.00000000000) 
		text = "UNDERGROUND" 
		font = testtitle 
		just = [ left , top ] 
		scale = ( 3 ) 
		rgba = [ 60 60 60 98 ] 
		alpha = 0 
		z_priority = 10000003 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = underground_hud_anchor 
		id = understar_1 
		texture = PA_goals 
		pos = PAIR(730.00000000000, 210.00000000000) 
		just = [ center center ] 
		scale = PAIR(1.29999995232, 1.29999995232) 
		rgba = [ 128 0 0 128 ] 
		alpha = 1 
		rot_angle = 18 
		z_priority = 10000001 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = underground_hud_anchor 
		id = understar_2 
		texture = PA_goals 
		pos = PAIR(-250.00000000000, 210.00000000000) 
		just = [ center center ] 
		scale = PAIR(1.29999995232, 1.29999995232) 
		rgba = [ 128 0 0 128 ] 
		alpha = 1 
		rot_angle = 18 
		z_priority = 10000001 
	} 
	GetTeamNames 
	CreateScreenElement { 
		type = TextElement 
		parent = underground_hud_anchor 
		id = skater_name_1 
		pos = PAIR(52.00000000000, 70.00000000000) 
		text = <team_name1> 
		font = small 
		just = [ left , top ] 
		scale = PAIR(1.29999995232, 2.00000000000) 
		rgba = [ 80 80 80 98 ] 
		z_priority = 10000001 
	} 
	CreateScreenElement { 
		type = TextElement 
		parent = underground_hud_anchor 
		id = skater_name_2 
		pos = PAIR(-200.00000000000, 270.00000000000) 
		text = <team_name2> 
		font = small 
		just = [ left , top ] 
		scale = PAIR(1.60000002384, 2.20000004768) 
		rgba = [ 80 80 80 98 ] 
		z_priority = 10000001 
	} 
	CreateScreenElement { 
		type = TextElement 
		parent = underground_hud_anchor 
		id = skater_name_3 
		pos = PAIR(300.00000000000, 600.00000000000) 
		text = <team_name3> 
		font = small 
		just = [ left , top ] 
		scale = PAIR(2.29999995232, 3.00000000000) 
		rgba = [ 80 80 80 98 ] 
		z_priority = 10000001 
	} 
	CreateScreenElement { 
		type = TextElement 
		parent = underground_hud_anchor 
		id = skater_name_4 
		pos = PAIR(100.00000000000, -600.00000000000) 
		text = <team_name4> 
		font = small 
		just = [ left , top ] 
		scale = PAIR(1.29999995232, 2.00000000000) 
		rgba = [ 80 80 80 98 ] 
		z_priority = 10000001 
	} 
	CreateScreenElement { 
		type = TextElement 
		parent = underground_hud_anchor 
		id = skater_name_5 
		pos = PAIR(320.00000000000, 170.00000000000) 
		text = <team_name5> 
		font = small 
		just = [ center , center ] 
		scale = PAIR(1.29999995232, 2.00000000000) 
		rgba = [ 80 80 80 98 ] 
		alpha = 0 
		z_priority = 10000001 
	} 
	RunScriptOnScreenElement id = underground_black2 fadeinout 
	build_top_and_bottom_blocks parent = underground_hud_anchor top_z = 100000 bot_z = 100000 
	RunScriptOnScreenElement id = under_1 underground_fly_in 
	RunScriptOnScreenElement id = under_2 underground_fly_in2 
	RunScriptOnScreenElement id = skater_name_1 skater_name_fly_1 
	RunScriptOnScreenElement id = skater_name_2 skater_name_fly_2 
	RunScriptOnScreenElement id = skater_name_3 skater_name_fly_3 
	RunScriptOnScreenElement id = skater_name_4 skater_name_fly_4 
	RunScriptOnScreenElement id = skater_name_5 skater_name_fly_5 
	RunScriptOnScreenElement id = understar_1 star_fly_1 
	RunScriptOnScreenElement id = understar_2 star_fly_2 
ENDSCRIPT

SCRIPT underground_fly_in 
	wait 1 second 
	DoScreenElementMorph id = under_1 alpha = 0 time = 0 scale = 8 
	DoScreenElementMorph id = under_1 alpha = 0.89999997616 time = 0.30000001192 scale = 3 
	wait 4.50000000000 second 
	DoScreenElementMorph id = under_1 alpha = 0 scale = PAIR(20.00000000000, 3.00000000000) time = 0.20000000298 
ENDSCRIPT

SCRIPT underground_fly_in2 
	wait 1 second 
	DoScreenElementMorph id = under_2 alpha = 0 time = 0 pos = PAIR(700.00000000000, 190.00000000000) 
	DoScreenElementMorph id = under_2 alpha = 0.89999997616 time = 0.40000000596 pos = PAIR(52.00000000000, 190.00000000000) 
	wait 3.00000000000 second 
	DoScreenElementMorph id = under_2 alpha = 0 time = 0.20000000298 
ENDSCRIPT

SCRIPT skater_name_fly_1 
	DoScreenElementMorph id = skater_name_1 alpha = 0 time = 0 pos = PAIR(700.00000000000, 70.00000000000) 
	DoScreenElementMorph id = skater_name_1 alpha = 0.60000002384 time = 6.19999980927 scale = PAIR(5.00000000000, 5.00000000000) pos = PAIR(-650.00000000000, 70.00000000000) 
ENDSCRIPT

SCRIPT skater_name_fly_2 
	DoScreenElementMorph id = skater_name_2 alpha = 0 time = 0 pos = PAIR(-200.00000000000, 270.00000000000) 
	DoScreenElementMorph id = skater_name_2 alpha = 0.50000000000 time = 5.80000019073 pos = PAIR(1000.00000000000, 270.00000000000) 
ENDSCRIPT

SCRIPT skater_name_fly_3 
	DoScreenElementMorph id = skater_name_3 alpha = 0 time = 0 pos = PAIR(300.00000000000, 600.00000000000) 
	DoScreenElementMorph id = skater_name_3 alpha = 0.55000001192 time = 6.40000009537 pos = PAIR(300.00000000000, -600.00000000000) 
ENDSCRIPT

SCRIPT skater_name_fly_4 
	DoScreenElementMorph id = skater_name_4 alpha = 0 time = 0 pos = PAIR(100.00000000000, -600.00000000000) 
	DoScreenElementMorph id = skater_name_4 alpha = 0.40000000596 time = 6.19999980927 scale = PAIR(4.80000019073, 4.80000019073) pos = PAIR(100.00000000000, 600.00000000000) 
ENDSCRIPT

SCRIPT skater_name_fly_5 
	wait 2 second 
	DoScreenElementMorph id = skater_name_5 alpha = 0.69999998808 time = 0 scale = 9 pos = PAIR(320.00000000000, 170.00000000000) 
	DoScreenElementMorph id = skater_name_5 alpha = 0 time = 3.50000000000 scale = 0 pos = PAIR(320.00000000000, 170.00000000000) 
ENDSCRIPT

SCRIPT star_fly_1 
	wait 1 second 
	DoScreenElementMorph id = understar_1 alpha = 0.50000000000 time = 0 pos = PAIR(730.00000000000, 210.00000000000) rot_angle = 0 
	DoScreenElementMorph id = understar_1 alpha = 0.94999998808 time = 2.79999995232 scale = PAIR(2.29999995232, 2.29999995232) pos = PAIR(-250.00000000000, 210.00000000000) rot_angle = 720 
ENDSCRIPT

SCRIPT star_fly_2 
	wait 1.50000000000 second 
	DoScreenElementMorph id = understar_2 alpha = 0.50000000000 time = 0 pos = PAIR(-250.00000000000, 210.00000000000) rot_angle = 0 
	DoScreenElementMorph id = understar_2 alpha = 0.80000001192 time = 1.79999995232 scale = PAIR(2.29999995232, 2.29999995232) pos = PAIR(720.00000000000, 210.00000000000) rot_angle = -720 
ENDSCRIPT

SCRIPT fadeinout 
	wait 0.60000002384 second 
	DoScreenElementMorph id = underground_black2 alpha = 0 time = 0 
	DoScreenElementMorph id = underground_black2 alpha = 1 time = 0.20000000298 
	DoScreenElementMorph id = underground_black2 alpha = 0 time = 0.10000000149 
ENDSCRIPT

SCRIPT GetTeamNames 
	GoalManager_GetTeam 
	GetArraySize master_skater_list 
	index = 0 
	index2 = 0 
	BEGIN 
		name = ( master_skater_list [ <index> ] . name ) 
		IF StructureContains structure = <team> <name> 
			SWITCH <index2> 
				CASE 0 
					team_name1 = ( master_skater_list [ <index> ] . display_name ) 
				CASE 1 
					team_name2 = ( master_skater_list [ <index> ] . display_name ) 
				CASE 2 
					team_name3 = ( master_skater_list [ <index> ] . display_name ) 
				CASE 3 
					team_name4 = ( master_skater_list [ <index> ] . display_name ) 
				CASE 4 
					team_name5 = ( master_skater_list [ <index> ] . display_name ) 
				DEFAULT 
					RETURN 
			ENDSWITCH 
			index2 = ( <index2> + 1 ) 
		ENDIF 
		index = ( <index> + 1 ) 
	REPEAT <array_size> 
	RemoveParameter name 
	RemoveParameter team 
	RemoveParameter num_team_members 
	RemoveParameter index 
	RemoveParameter index2 
	RemoveParameter array_size 
	RETURN <...> 
ENDSCRIPT

nightvision_hud_is_hidden = 0 
SCRIPT nightvision_hud 
	IF ScreenElementExists id = nightvision_hud_anchor 
		DestroyScreenElement id = nightvision_hud_anchor 
	ENDIF 
	SetScreenElementLock off id = root_window 
	CreateScreenElement { 
		type = ContainerElement 
		id = nightvision_hud_anchor 
		parent = root_window 
		pos = PAIR(320.00000000000, 240.00000000000) 
		dims = PAIR(640.00000000000, 480.00000000000) 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = nightvision_hud_anchor 
		id = nightvision_video_screen 
		texture = videoscreen 
		pos = PAIR(320.00000000000, 240.00000000000) 
		just = [ center center ] 
		scale = PAIR(5.00000000000, 10.00000000000) 
		alpha = 0.30000001192 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		id = nightvision_hud_line 
		parent = nightvision_hud_anchor 
		texture = white2 
		pos = PAIR(0.00000000000, 0.00000000000) 
		just = [ left center ] 
		scale = PAIR(100.00000000000, 0.10000000149) 
		alpha = 0.50000000000 
	} 
	RunScriptOnScreenElement id = nightvision_video_screen flicker_nightvision_video_screen 
	RunScriptOnScreenElement id = nightvision_hud_line morph_nightvision_hud_line 
ENDSCRIPT

SCRIPT kill_nightvision_hud 
	IF ScreenElementExists id = nightvision_hud_anchor 
		DestroyScreenElement id = nightvision_hud_anchor 
	ENDIF 
ENDSCRIPT

SCRIPT nightvision_hud_fade_in 
	fadetoblack on time = 0 alpha = 1.00000000000 z_priority = 5 
	wait 0.20000000298 seconds 
	fadetoblack off time = 0.50000000000 
ENDSCRIPT

SCRIPT really_kill_flicker_nightvision_hud 
	wait 0.69999998808 seconds 
	fadetoblack off time = 0 
	IF ScreenElementExists id = nightvision_hud_anchor 
		DestroyScreenElement id = nightvision_hud_anchor 
	ENDIF 
ENDSCRIPT

SCRIPT flicker_nightvision_video_screen time = 0.05000000075 
	BEGIN 
		DoScreenElementMorph id = nightvision_video_screen alpha = 0.30000001192 time = <time> 
		wait <time> seconds 
		DoScreenElementMorph id = nightvision_video_screen alpha = 0.22499999404 time = <time> 
		wait <time> seconds 
	REPEAT 
ENDSCRIPT

SCRIPT morph_nightvision_hud_line time = 1.50000000000 
	BEGIN 
		DoScreenElementMorph id = nightvision_hud_line pos = PAIR(0.00000000000, 480.00000000000) time = <time> 
		wait <time> seconds 
		DoScreenElementMorph id = nightvision_hud_line pos = PAIR(0.00000000000, 0.00000000000) 
	REPEAT 
ENDSCRIPT

SCRIPT dont_use_level_lights 
	IF NOT GotParam model 
		script_assert "no model name specified" 
	ENDIF 
	<model> : Obj_SetLightAmbientColor r = 128 g = 128 b = 128 
	<model> : Obj_SetLightDiffuseColor index = 0 r = 0 g = 0 b = 0 
	<model> : Obj_SetLightDiffuseColor index = 1 r = 0 g = 0 b = 0 
ENDSCRIPT


