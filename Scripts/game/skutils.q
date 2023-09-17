
check_for_unplugged_controllers = 0 
TimeOfDayDebug = 0 
SCRIPT PrintState 
	IF InAir 
		printf "In air" 
	ENDIF 
	IF OnGround 
		printf "On ground" 
	ENDIF 
	IF OnWall 
		printf "On wall" 
	ENDIF 
	IF OnLip 
		printf "On lip" 
	ENDIF 
	IF OnRail 
		printf "OnRail" 
	ENDIF 
ENDSCRIPT

SCRIPT DefaultGapScript 
	PlaySound HUD_jumpgap 
	IF Skating 
		IF OnGround 
			LandGapsImmediately = 1 
		ENDIF 
	ELSE 
		IF Walking 
			LandGapsImmediately = 1 
		ELSE 
			IF Driving 
				LandGapsImmediately = 1 
			ENDIF 
		ENDIF 
	ENDIF 
	IF GotParam LandGapsImmediately 
		GetNumberOfNonGapTricks 
		IF ( <NumberOfNonGapTricks> = 0 ) 
			LandSkaterTricks 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT SetAllStats value = 3 
	printf "Overriding Stats to %d" d = <value> 
	SetStatOverride <value> 
ENDSCRIPT

SCRIPT ToggleMinMetrics 
	ToggleMetricItem item = METRIC_TIME 
	ToggleMetricItem item = METRIC_TOTALPOLYS 
	ToggleMetricItem item = METRIC_VERTS 
	ToggleMetricItem item = METRIC_RESOURCEALLOCS 
	ToggleMetricItem item = METRIC_TEXTUREUPLOADS 
	ToggleMetricItem item = METRIC_VU1 
	ToggleMetricItem item = METRIC_DMA1 
	ToggleMetricItem item = METRIC_DMA2 
	ToggleMetricItem item = METRIC_IHANDLERTIME 
	ToggleMetricItem item = METRIC_SKYCACHE 
	ToggleMetricItem item = METRIC_VIDEOMODE 
	ToggleMetricItem item = METRIC_MEMFREE 
	ToggleMetricItem item = METRIC_REGIONINFO 
ENDSCRIPT

SCRIPT MaybePause Button = r1 
	IF held <Button> 
		BEGIN 
		REPEAT 800000 
	ENDIF 
ENDSCRIPT

SCRIPT WaitOneGameFrame 
	Wait 1 gameframes 
ENDSCRIPT

SCRIPT WaitAnimFinished 
	Obj_WaitAnimFinished 
ENDSCRIPT

SCRIPT WaitAnimWhilstChecking 
	BEGIN 
		DoNextTrick 
		IF GotParam AndManuals 
			DoNextManualTrick 
		ENDIF 
		IF AnimFinished 
			BREAK 
		ENDIF 
		Wait 1 GameFrame 
	REPEAT 
ENDSCRIPT

SCRIPT WaitWhilstChecking 
	GetStartTime 
	BEGIN 
		DoNextTrick 
		IF GotParam AndManuals 
			DoNextManualTrick 
		ENDIF 
		Wait 1 GameFrame 
		GetElapsedTime StartTime = <StartTime> 
		IF ( <ElapsedTime> > <Duration> ) 
			BREAK 
		ENDIF 
	REPEAT 
ENDSCRIPT

SCRIPT Reverse 
	PlayAnim Anim = Current From = Current To = 0 
ENDSCRIPT

SCRIPT Obj_WaitForFlag 
	BEGIN 
		IF Obj_FlagSet <...> 
			BREAK 
		ENDIF 
		WaitOneGameFrame 
	REPEAT 
ENDSCRIPT

SCRIPT PollUntilFinished 
	IF GotParam Func 
		BEGIN 
			IF <Func> <...> 
				BREAK 
			ENDIF 
			Wait 1 GameFrame 
		REPEAT 
	ELSE 
		BEGIN 
			printf "AAAAAAAARGH !!!!  PollUntilFinished needs a Func parameter !" 
			Wait 1 GameFrame 
		REPEAT 
	ENDIF 
ENDSCRIPT

SCRIPT autolaunch 
	IF GotParam game 
		SetGameType <game> 
	ELSE 
		SetGameType career 
	ENDIF 
	SetCurrentGameType 
	request_level level = <level> 
	cleanup_before_loading_level 
	load_requested_level 
ENDSCRIPT

SCRIPT change_level 
	change is_changing_levels = 1 
	IF LevelIs load_sk5ed 
		SwitchOffRailEditor 
	ENDIF 
	ResetScore 
	SetMusicLooping 0 
	IF NOT IsObserving 
		Skater : reset_model_lights 
	ENDIF 
	IF ObjectExists id = Skater2 
		Skater2 : reset_model_lights 
	ENDIF 
	change check_for_unplugged_controllers = 0 
	IF GotParam next_level_script 
		change next_level_script = <next_level_script> 
	ENDIF 
	IF NOT IsObserving 
		Skater : ClearPanel_Landed 
	ENDIF 
	IF NOT GotParam no_levelUnload 
		printf "performing LevelUnload" 
		GoalManager_LevelUnload 
	ENDIF 
	ResetScore 
	ResetScorePot 
	hide_console_window 
	GoalManager_LevelUnload 
	GoalManager_DeactivateAllGoals 
	IF NOT IsObserving 
		Skater : StatsManager_DeactivateGoals 
	ENDIF 
	ScreenElementSystemCleanup 
	IF NOT inNetGame 
		hide_everything 
	ENDIF 
	kill_blur 
	IF InSplitScreenGame 
		launch_two_player 
	ENDIF 
	IF IsXbox 
		DisplayLoadingScreen freeze 
	ENDIF 
	ChangeLevel <...> 
ENDSCRIPT

SCRIPT QuickScript 
	printf "Running quickscript...." 
	ReloadNodeArray 
	IF ScriptExists LoadAllParticleTextures 
		LoadAllParticleTextures 
	ENDIF 
	Retry 
ENDSCRIPT

SCRIPT ReloadScene 
	Skater : SetCustomRestart Set 
	IF GotParam scene 
		IF UnloadScene <...> 
			Cleanup 
			IF NOT inNetGame 
				AllocatePathManMemory 
			ENDIF 
			FormatText ChecksumName = struct_name "level_%s" s = <scene> 
			AddParams <struct_name> 
			IF GotParam sky 
				LoadScene scene = <sky> 
			ENDIF 
			LoadScene <...> 
			IF GotParam level_name 
				SetLevelName <level_name> 
			ELSE 
				SetLevelName <level> 
			ENDIF 
			IF GotParam qb 
				LoadNodeArray <qb> 
			ENDIF 
			IF GotParam level_qb 
				LoadQB <level_qb> LevelSpecific 
			ENDIF 
			IF GotParam level_sfx_qb 
				LoadQB <level_sfx_qb> LevelSpecific 
			ENDIF 
			LoadTerrain 
			IF GotParam temp_script 
				<temp_script> 
			ENDIF 
			IF NOT inNetGame 
				PushMemProfile "Level Specific Anims" 
				load_level_anims 
				PopMemProfile 
			ENDIF 
			PushMemProfile "Level Cameras" 
			LoadCameras 
			PopMemProfile 
			IF ScriptExists LoadObjectAnims 
				PushMemProfile "Object Anims" 
				LoadObjectAnims 
				PopMemProfile 
			ENDIF 
			IF ScriptExists LoadAllParticleTextures 
				LoadAllParticleTextures 
			ENDIF 
			IF GotParam startup_script 
				<startup_script> 
			ENDIF 
			LoadCollision <...> 
			ParseNodeArray 
			IF GotParam setup_script 
				<setup_script> 
			ENDIF 
			refresh_poly_count 
			IF ( SHOWPOLYS_ONQUICKVIEW ) 
				IF ( poly_count_on = 0 ) 
					show_poly_count 
				ENDIF 
			ENDIF 
		ELSE 
			autolaunch level = <scene> 
		ENDIF 
	ELSE 
		script_assert "No scene param specified for autolaunching" 
	ENDIF 
	Skater : SkipToCustomRestart 
	IF IsTrue TimeOfDayDebug 
		set_all_light_values level_only 
	ENDIF 
ENDSCRIPT

SCRIPT AddToScene 
	IF GotParam add 
	ELSE 
		add "update" 
	ENDIF 
	IF GotParam scene 
		AddScene scene = <scene> add = <add> 
		AddCollision scene = <scene> add = <add> 
	ELSE 
		script_assert "No scene param specified for autolaunching" 
	ENDIF 
ENDSCRIPT

SCRIPT LoadLevelGeometry 
	IF GotParam sky 
		LoadScene scene = <sky> 
	ENDIF 
	IF GotParam level 
		LoadScene scene = <level> 
		LoadCollision scene = <level> 
	ENDIF 
ENDSCRIPT

SCRIPT QuickStart scene = "default" sky = "ru_sky" 
	LoadScene scene = <sky> 
	LoadScene scene = <scene> 
	gameflow StandardGameFlowToggleView 
ENDSCRIPT

SCRIPT VerifyParam 
	IF GotParam <param> 
	ELSE 
		printf "Required param not found in script function:" 
		printf <param> 
		printf <Func> 
		script_assert "Terminating..." 
	ENDIF 
ENDSCRIPT

TRIGGER_THROUGH = 0 
TRIGGER_SKATE_OFF_EDGE = 1 
TRIGGER_JUMP_OFF = 2 
TRIGGER_LAND_ON = 3 
TRIGGER_SKATE_OFF = 4 
TRIGGER_SKATE_ONTO = 5 
TRIGGER_BONK = 6 
TRIGGER_LIP_ON = 7 
TRIGGER_LIP_OFF = 8 
TRIGGER_LIP_JUMP = 9 
CANCEL_GROUND = 1 
CANCEL_AIR = 2 
CANCEL_RAIL = 4 
CANCEL_WALL = 8 
CANCEL_LIP = 16 
CANCEL_WALLPLANT = 32 
CANCEL_MANUAL = 64 
CANCEL_HANG = 128 
CANCEL_LADDER = 256 
PURE_GROUND = 510 
PURE_AIR = 509 
PURE_RAIL = 507 
PURE_WALL = 503 
PURE_LIP = 495 
PURE_WALLPLANT = 479 
PURE_MANUAL = 447 
PURE_HANG = 383 
PURE_LADDER = 255 
REQUIRE_GROUND = 65536 
REQUIRE_AIR = 131072 
REQUIRE_RAIL = 262144 
REQUIRE_WALL = 524288 
REQUIRE_LIP = 1048576 
REQUIRE_WALLPLANT = 2097152 
REQUIRE_MANUAL = 4194304 
REQUIRE_HANG = 8388608 
REQUIRE_LADDER = 16777216 
CANCEL_SKATE = 512 
CANCEL_WALK = 1024 
CANCEL_DRIVE = 2048 
REQUIRE_SKATE = 33554432 
REQUIRE_WALK = 67108864 
REQUIRE_DRIVE = 134217728 
SCRIPT CareerRestartLevel 
	CareerStartLevel level = -1 
ENDSCRIPT

SCRIPT DefaultHiScoreScript 
ENDSCRIPT

SCRIPT DefaultProScoreScript 
ENDSCRIPT

SCRIPT DisablePause 
	AllowPause off 
ENDSCRIPT

SCRIPT EnablePause 
	AllowPause 
ENDSCRIPT

SCRIPT LaunchLocalMessage 
	LaunchLocalPanelMessage message_prop_default <...> 
ENDSCRIPT

mFD_SKATABLE = 1 
mFD_NOT_SKATABLE = 2 
mFD_WALL_RIDABLE = 4 
mFD_VERT = 8 
mFD_NON_COLLIDABLE = 16 
mFD_DECAL = 32 
mFD_TRIGGER = 64 
mFD_CAMERA_COLLIDABLE = 128 
mFD_NO_SKATER_SHADOW = 256 
mFD_SKATER_SHADOW = 512 
mFD_NO_SKATER_SHADOW_WALL = 1024 
mFD_UNDER_OK = 2048 
mFD_INVISIBLE = 4096 
mFD_CASFACEFLAGSEXIST = 8192 
mFD_PASS_1_DISABLED = 16384 
mFD_PASS_2_ENABLED = 32768 
mFD_PASS_3_ENABLED = 65536 
mFD_PASS_4_ENABLED = 131072 
mFD_RENDER_SEPARATE = 262144 
mFD_LIGHTMAPPED = 524288 
mFD_NON_WALL_RIDABLE = 1048576 
mFD_NON_CAMERA_COLLIDABLE = 2097152 
mFD_EXPORT_COLLISION = 4194304 
SCRIPT show_all 
	DebugRenderIgnore 
ENDSCRIPT

SCRIPT show_vert 
	DebugRenderIgnore ignore_0 = mFD_VERT 
ENDSCRIPT

SCRIPT show_wallride 
	DebugRenderIgnore ignore_0 = mFD_WALL_RIDABLE 
ENDSCRIPT

SCRIPT show_wall_ridable 
	DebugRenderIgnore ignore_0 = mFD_WALL_RIDABLE 
ENDSCRIPT

SCRIPT show_trigger 
	DebugRenderIgnore ignore_0 = mFD_TRIGGER 
ENDSCRIPT

SCRIPT show_invisible 
	DebugRenderIgnore ignore_0 = mFD_INVISIBLE 
ENDSCRIPT

SCRIPT show_triggers 
	show_trigger 
ENDSCRIPT

SCRIPT show_CAMERA 
	DebugRenderIgnore ignore_0 = mFD_NON_CAMERA_COLLIDABLE 
ENDSCRIPT

SCRIPT show_CAMERA_COLLIDE 
	DebugRenderIgnore ignore_0 = mFD_CAMERA_COLLIDABLE 
ENDSCRIPT

SCRIPT show_skatable 
	DebugRenderIgnore ignore_0 = mFD_SKATABLE 
ENDSCRIPT

SCRIPT show_not_skatable 
	DebugRenderIgnore ignore_0 = mFD_NOT_SKATABLE 
ENDSCRIPT

SCRIPT show_no_skater_shadow 
	DebugRenderIgnore ignore_0 = mFD_NO_SKATER_SHADOW 
ENDSCRIPT

SCRIPT show_skater_shadow 
	DebugRenderIgnore ignore_0 = mFD_SKATER_SHADOW 
ENDSCRIPT

SCRIPT show_no_skater_shadow_wall 
	DebugRenderIgnore ignore_0 = mFD_NO_SKATER_SHADOW_WALL 
ENDSCRIPT

SCRIPT show_non_collidable 
	DebugRenderIgnore ignore_0 = mFD_NON_COLLIDABLE 
ENDSCRIPT

SCRIPT show_collidable 
	DebugRenderIgnore ignore_1 = mFD_NON_COLLIDABLE 
ENDSCRIPT

SCRIPT frame_advance 
	spawnscript s_frame_advance 
	toggleviewmode 
	unpausegame 
	unpauseskaters 
ENDSCRIPT

SCRIPT s_frame_advance 
	toggleviewmode 
	toggleviewmode 
	pausegame 
	pauseskaters 
ENDSCRIPT

SCRIPT JumpSkaterToNode 
	GoalManager_DeactivateAllMinigames 
	MakeSkaterGoto JumpToNode Params = { NodeName = <NodeName> <...> } 
ENDSCRIPT

SCRIPT JumpToNode 
	IF NodeExists <NodeName> 
		StopBalanceTrick 
		SetSpeed 0 
		IF GotParam MoveUpABit 
			Move y = 10 
		ENDIF 
		Obj_MoveToNode name = <NodeName> Orient NoReset 
		Goto GroundGone 
	ENDIF 
ENDSCRIPT

SCRIPT ScreenElementSystemCleanup 
	printf "************ CLEANING UP SYSTEM ***************" 
	IF ObjectExists id = root_window 
		DestroyScreenElement id = root_window 
		ScreenElementSystemInit 
		SetScreenElementProps { 
			id = root_window 
			event_handlers = [ 
				{ pad_start handle_start_pressed } 
			] 
			replace_handlers 
			tags = { menu_state = off } 
		} 
		FireEvent type = focus target = root_window 
		create_panel_stuff 
	ENDIF 
ENDSCRIPT

SCRIPT CreateLocal 
	create <...> 
ENDSCRIPT

SCRIPT KillLocal 
	kill <...> 
ENDSCRIPT

SCRIPT KillElement3d 
	Wait 1 GameFrame 
	Die 
ENDSCRIPT

SCRIPT attach_arrow_to_object model = "Arrow" 
	SetScreenElementLock id = root_window off 
	CreateScreenElement { 
		parent = root_window 
		type = Element3D 
		id = <arrow_id> 
		model = <model> 
		HoverParams = { Amp = 10 Freq = 2 } 
		AngVelY = 0.15999999642 
		ParentParams = { name = <object_id> VECTOR(0.00000000000, 100.00000000000, 0.00000000000) IgnoreParentsYRotation } 
	} 
ENDSCRIPT

SCRIPT attach_arrow_to_node model = "GoalArrow" offset = VECTOR(0.00000000000, 100.00000000000, 0.00000000000) 
	SetScreenElementLock id = root_window off 
	printstruct <...> 
	CreateScreenElement { 
		parent = root_window 
		type = Element3D 
		id = <arrow_id> 
		model = <model> 
		HoverParams = { Amp = 10 Freq = 2 } 
		AngVelY = 0.15999999642 
		ParentParams = { node = <node> <offset> IgnoreParentsYRotation } 
	} 
ENDSCRIPT

SCRIPT setup_ped_speech { 
		inner_radius = 8 
		outer_radius = 24 
		speed = 20 
		pad_choose_script = ped_speech_exit 
	} 
	<ped_id> : Obj_ClearException SkaterInRadius 
	<ped_id> : Obj_ClearException SkaterOutOfRadius 
	<ped_id> : Obj_SetInnerRadius <inner_radius> 
	<ped_id> : Obj_SetException ex = SkaterInRadius scr = ped_speech_got_trigger Params = <...> 
ENDSCRIPT

SCRIPT ped_speech_got_trigger 
	IF ObjectExists id = ped_speech_dialog 
		<should_destroy> = 0 
		IF Skater : IsInBail 
			<should_destroy> = 1 
		ENDIF 
		IF NOT GoalManager_CanStartGoal 
			<should_destroy> = 1 
		ENDIF 
		IF GoalManager_IsInCompetition 
			<should_destroy> = 1 
		ENDIF 
		IF ( <should_destroy> = 1 ) 
			DestroyScreenElement id = ped_speech_dialog 
		ENDIF 
	ELSE 
		IF ObjectExists id = root_window 
			root_window : GetTags 
			IF GotParam menu_state 
				IF ( <menu_state> = on ) 
					RETURN 
				ENDIF 
			ENDIF 
		ENDIF 
		IF NOT GoalManager_CanStartGoal 
			RETURN 
		ENDIF 
		IF GoalManager_IsInCompetition 
			RETURN 
		ENDIF 
		IF Skater : OnGround 
			IF NOT Skater : IsInBail 
				Obj_SetOuterRadius <outer_radius> 
				Obj_SetException ex = SkaterOutOfRadius scr = ped_speech_refuse Params = <...> 
				IF NOT GotParam display_name 
					<display_name> = "Ped" 
				ENDIF 
				FormatText TextName = accept_text "%s: \\m5 to talk." s = <display_name> 
				IF ObjectExists id = ped_speech_dialog 
					DestroyScreenElement id = ped_speech_dialog 
				ENDIF 
				create_speech_box { 
					anchor_id = ped_speech_dialog 
					text = <accept_text> 
					no_pad_choose 
					no_pad_start 
					pad_circle_script = ped_speech_accept 
					pad_circle_params = <...> 
					bg_rgba = [ 100 100 100 128 ] 
					text_rgba = [ 128 128 128 128 ] 
					pos = PAIR(320.00000000000, 400.00000000000) 
					font = small 
					z_priority = 5 
				} 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT ped_speech_accept 
	speech_box_exit 
	IF NOT ObjectExists <ped_id> 
		RETURN 
	ENDIF 
	DeBounce X time = 0.50000000000 
	IF Skater : OnGround 
		IF NOT SkaterCurrentScorePotGreaterThan 0 
			Wait 5 frame 
			IF Skater : OnGround 
				ped_speech_accept2 <...> 
			ELSE 
				IF NOT Skater : RightPressed 
					IF NOT Skater : LeftPressed 
						IF NOT Skater : UpPressed 
							IF NOT Skater : DownPressed 
								ped_speech_accept2 <...> 
							ENDIF 
						ENDIF 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
	ELSE 
		IF NOT Skater : RightPressed 
			IF NOT Skater : LeftPressed 
				IF NOT Skater : UpPressed 
					IF NOT Skater : DownPressed 
						ped_speech_accept2 <...> 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT ped_speech_accept2 
	IF NOT GameModeEquals is_singlesession 
		GoalManager_DeactivateAllGoals 
	ENDIF 
	pauseskaters 
	<ped_id> : Obj_ClearException SkaterInRadius 
	IF ObjectExists id = ped_speech_dialog 
		DestroyScreenElement id = ped_speech_dialog 
	ENDIF 
	IF GotParam activation_script 
		Skater : Obj_SpawnScript <activation_script> Params = <activation_script_params> 
	ENDIF 
	IF GotParam cam_anim 
		PlaySkaterCamAnim name = <cam_anim> 
	ENDIF 
	create_speech_box <...> 
ENDSCRIPT

SCRIPT ped_speech_refuse 
	Obj_ClearException SkaterOutOfRadius 
	speech_box_exit anchor_id = ped_speech_dialog 
	ped_speech_reset <...> 
ENDSCRIPT

SCRIPT ped_speech_set_outer_trigger_radius 
	Obj_ClearException SkaterInRadius 
	Obj_SetOuterRadius <outer_radius> 
	Obj_SetException ex = SkaterOutOfRadius scr = ped_speech_reset Params = <...> 
ENDSCRIPT

SCRIPT ped_speech_reset 
	IF GotParam outer_radius_script 
		<outer_radius_script> <outer_radius_params> 
	ENDIF 
	IF NOT GotParam no_repeat 
		setup_ped_speech <...> 
	ENDIF 
ENDSCRIPT

SCRIPT ped_speech_exit 
	unpauseskaters 
	speech_box_exit 
ENDSCRIPT

SCRIPT GetStackedScreenElementPos 
	IF GotParam XY 
		GetStackedScreenElementPosOnXY <...> 
	ELSE 
		IF GotParam X 
			IF GotParam y 
				GetStackedScreenElementPosOnXY <...> 
			ELSE 
				GetStackedScreenElementPosOnX <...> 
			ENDIF 
		ELSE 
			IF GotParam y 
				GetStackedScreenElementPosOnY <...> 
			ELSE 
				script_assert "GetStackedScreenElementPos called without an axis" 
			ENDIF 
		ENDIF 
	ENDIF 
	RETURN pos = <pos> 
ENDSCRIPT

SCRIPT GetStackedScreenElementPosOnX 
	GetScreenElementPosition id = <id> 
	GetScreenElementDims id = <id> 
	<unit_pair> = PAIR(1.00000000000, 0.00000000000) 
	IF GotParam negative 
		<unit_pair> = PAIR(-1.00000000000, 0.00000000000) 
	ENDIF 
	IF GotParam offset 
		RETURN pos = ( <ScreenElementPos> + ( <unit_pair> * <width> + <offset> ) ) 
	ELSE 
		RETURN pos = ( <ScreenElementPos> + ( <unit_pair> * <width> ) ) 
	ENDIF 
ENDSCRIPT

SCRIPT GetStackedScreenElementPosOnY 
	GetScreenElementPosition id = <id> 
	GetScreenElementDims id = <id> 
	<unit_pair> = PAIR(0.00000000000, 1.00000000000) 
	IF GotParam negative 
		<unit_pair> = PAIR(0.00000000000, -1.00000000000) 
	ENDIF 
	IF GotParam offset 
		RETURN pos = ( <ScreenElementPos> + ( <unit_pair> * <height> + <offset> ) ) 
	ELSE 
		RETURN pos = ( <ScreenElementPos> + ( <unit_pair> * <height> ) ) 
	ENDIF 
ENDSCRIPT

SCRIPT GetStackedScreenElementPosOnXY 
	GetScreenElementPosition id = <id> 
	GetScreenElementDims id = <id> 
	<x_unit_pair> = PAIR(1.00000000000, 0.00000000000) 
	<y_unit_pair> = PAIR(0.00000000000, 1.00000000000) 
	IF GotParam negative 
		<x_unit_pair> = PAIR(-1.00000000000, 0.00000000000) 
		<y_unit_pair> = PAIR(0.00000000000, -1.00000000000) 
	ENDIF 
	IF GotParam offset 
		RETURN pos = ( <ScreenElementPos> + ( <y_unit_pair> * <height> + <x_unit_pair> * <width> + <offset> ) ) 
	ELSE 
		RETURN pos = ( <ScreenElementPos> + ( <y_unit_pair> * <height> + <x_unit_pair> * <width> ) ) 
	ENDIF 
ENDSCRIPT

SCRIPT kill_blur 
	IF NOT InSplitScreenGame 
		KillSpawnedScript name = pulse_blur_script_down 
		KillSpawnedScript name = pulse_blur_script_up 
		SetScreenBlur <start> 
	ENDIF 
ENDSCRIPT

SCRIPT pulse_blur start = 200 end = 0 speed = 4 
	KillSpawnedScript name = pulse_blur_script_down 
	KillSpawnedScript name = pulse_blur_script_up 
	IF ( <start> > <end> ) 
		spawnscript pulse_blur_script_down Params = <...> 
	ELSE 
		spawnscript pulse_blur_script_up Params = <...> 
	ENDIF 
ENDSCRIPT

SCRIPT pulse_blur_script_down 
	IF GotParam force_pulse 
		BEGIN 
			IF ( <start> < <end> ) 
				SetScreenBlur <end> 
				BREAK 
			ENDIF 
			SetScreenBlur <start> 
			<start> = ( <start> - <speed> ) 
			Wait 1 GameFrame 
		REPEAT 
		RETURN 
	ENDIF 
	IF NOT InSplitScreenGame 
		BEGIN 
			IF ( <start> < <end> ) 
				SetScreenBlur <end> 
				BREAK 
			ENDIF 
			SetScreenBlur <start> 
			<start> = ( <start> - <speed> ) 
			Wait 1 GameFrame 
		REPEAT 
	ENDIF 
ENDSCRIPT

SCRIPT pulse_blur_script_up 
	IF GotParam force_pulse 
		BEGIN 
			IF ( <start> > <end> ) 
				SetScreenBlur <end> 
				BREAK 
			ENDIF 
			SetScreenBlur <start> 
			<start> = ( <start> + <speed> ) 
			Wait 1 GameFrame 
		REPEAT 
		RETURN 
	ENDIF 
	IF NOT InSplitScreenGame 
		BEGIN 
			IF ( <start> > <end> ) 
				SetScreenBlur <end> 
				BREAK 
			ENDIF 
			SetScreenBlur <start> 
			<start> = ( <start> + <speed> ) 
			Wait 1 GameFrame 
		REPEAT 
	ENDIF 
ENDSCRIPT

SCRIPT NullScript 
ENDSCRIPT

SCRIPT BloodOff 
ENDSCRIPT

SCRIPT mark_first_input_received 
	printf "mark_first_input_received" 
	GetCurrentSkaterProfileIndex 
	GetSkaterId 
	IF GotParam device_num 
		<controller_index> = <device_num> 
	ELSE 
		<controller_index> = <controller> 
	ENDIF 
	BindControllerToSkater skater_heap_index = <currentSkaterProfileIndex> controller = <controller_index> 
	FirstInputReceived 
	change check_for_unplugged_controllers = 1 
ENDSCRIPT

SCRIPT lighting target = 8421504 percent = 0 
	IF GotParam lights 
		IF GotParam id 
			FakeLights percent = <lights> id = <id> prefix = <prefix> 
		ELSE 
			IF GotParam prefix 
				FakeLights percent = <lights> prefix = <prefix> 
			ELSE 
				FakeLights percent = <lights> prefix = TRG_LevelLight 
			ENDIF 
		ENDIF 
	ENDIF 
	IF GotParam color 
		IF NOT GotParam sky 
			<sky> = <color> 
		ENDIF 
		SetSceneColor color = <color> sky = <sky> lightgroup = <lightgroup> 
	ENDIF 
ENDSCRIPT

SCRIPT DumpMetrics 
	GetMetrics 
	printf 
	printf "Dumping Metrics Structure" 
	printstruct <...> 
ENDSCRIPT

SCRIPT recreate 
	IF ObjectExists id = <id> 
		<id> : Die 
	ENDIF 
	create name = <id> 
ENDSCRIPT

dummy_metrics_struct = { 
	mainscene = 0 
	skyscene = 0 
	metrics = 0 
	Sectors = 0 
	ColSectors = 0 
	Verts = 0 
	BasePolys = 0 
	TextureMemory = 0 
} 
test_letter_a = { 
	model = "gameobjects\\skate\\letter_a\\letter_a.mdl" 
} 
proximobj_composite_structure = [ 
	{ component = sound } 
	{ component = stream } 
] 
gameobj_composite_structure = [ 
	{ component = suspend } 
	{ component = motion } 
	{ component = skaterproximity } 
	{ component = sound } 
] 
bouncy_composite_structure = [ 
	{ component = suspend } 
	{ component = rigidbody } 
	{ component = model } 
	{ component = sound } 
] 
particle_composite_structure = [ 
	{ component = suspend } 
	{ component = particle } 
] 
moving_particle_composite_structure = [ 
	{ component = suspend } 
	{ component = motion } 
	{ component = particle } 
] 
skatercam_composite_structure = [ 
	{ component = cameralookaround } 
	{ component = skatercamera } 
	{ component = walkcamera } 
	{ component = camera } 
	{ component = input } 
] 
viewercam_composite_structure = [ 
	{ component = camera } 
] 
parkedcam_composite_structure = [ 
	{ component = camera } 
] 
menucam_composite_structure = 
[ 
	{ component = camera } 
] 
explosion_composite_structure = 
[ 
	{ component = suspend } 
	{ component = particle } 
] 
fireball_composite_structure = 
[ 
	{ component = velocity } 
	{ component = suspend } 
	{ component = collideanddie } 
	{ component = particle } 
] 
server_fireball_composite_structure = 
[ 
	{ component = velocity } 
	{ component = suspend } 
	{ component = projectilecollision } 
	{ component = collideanddie } 
	{ component = particle } 
] 
SCRIPT Restore_skater_camera 
	IF IsObserving 
		SetActiveCamera id = SkaterCam0 
	ELSE 
		IF NOT LocalSkaterExists 
			SetActiveCamera id = SkaterCam0 
		ELSE 
			IF NOT Skater : Driving 
				SetActiveCamera id = SkaterCam0 
			ELSE 
				SetActiveCamera id = PlayerVehicleCamera 
			ENDIF 
		ENDIF 
	ENDIF 
	IF NOT LevelIs load_skateshop 
		IF NOT LevelIs load_cas 
			IF NOT LevelIs load_boardshop 
				IF NOT IsObserving 
					IF LocalSkaterExists 
						Skater : Obj_EnableScaling 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT disable_skater_scaling 
	IF NOT LevelIs load_skateshop 
		IF NOT LevelIs load_cas 
			IF NOT LevelIs load_boardshop 
				IF NOT IsObserving 
					IF NOT GetGlobalFlag flag = CHEAT_KID 
						Skater : Obj_DisableScaling 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT create_menu_camera 
	IF NOT ObjectExists id = menu_cam 
		MemPushContext FrontEndHeap 
		printf "Creating camera on front end heap" 
		CreateCompositeObject { 
			Components = menucam_composite_structure 
			Params = { name = menu_cam } 
		} 
		MemPopContext 
	ENDIF 
ENDSCRIPT

SCRIPT SetSkaterCamOverride 
	SkaterCam0 : SC_SetSkaterCamOverride <...> 
ENDSCRIPT

SCRIPT ClearSkaterCamOverride 
	SkaterCam0 : SC_ClearSkaterCamOverride <...> 
ENDSCRIPT

SCRIPT ShakeCamera 
	SkaterCam0 : SC_ShakeCamera <...> 
ENDSCRIPT

SCRIPT empty_script 
ENDSCRIPT

SCRIPT HideSkaterAndMiscSkaterEffects 
	KillAllTextureSplats 
	Skater : SparksOff 
	Skater : SwitchOnBoard 
	Skater : RemoveSkaterFromWorld 
ENDSCRIPT

SCRIPT SwitchToMenu 
	printf "SwitchToMenu" 
ENDSCRIPT

SCRIPT ResetLookAround 
	printf "ResetLookAround is not currently working....." 
ENDSCRIPT

SCRIPT toggle_framerate 
	SWITCH lock_framerate 
		CASE 0 
			change lock_framerate = 2 
		CASE 1 
			change lock_framerate = 2 
		CASE 2 
			change lock_framerate = 1 
	ENDSWITCH 
ENDSCRIPT

SCRIPT CalcPosRelative ob = Skater dx = 0 dy = 0 dz = 0 
	<ob> : Obj_GetPosition 
	<ob> : Obj_GetOrientation 
	unit_z = ( VECTOR(1.00000000000, 0.00000000000, 0.00000000000) * <X> + VECTOR(0.00000000000, 1.00000000000, 0.00000000000) * <y> + VECTOR(0.00000000000, 0.00000000000, 1.00000000000) * <z> ) 
	unit_x = ( VECTOR(0.00000000000, 1.00000000000, 0.00000000000) * <unit_z> ) 
	unit_y = ( <unit_z> * <unit_x> ) 
	pos = ( <pos> + <dx> * <unit_x> + <dy> * <unit_y> + <dz> * <unit_z> ) 
	RETURN X = ( <pos> . VECTOR(1.00000000000, 0.00000000000, 0.00000000000) ) y = ( <pos> . VECTOR(0.00000000000, 1.00000000000, 0.00000000000) ) z = ( <pos> . VECTOR(0.00000000000, 0.00000000000, 1.00000000000) ) pos = <pos> 
ENDSCRIPT

SCRIPT Forced_Create 
	IF GotParam prefix 
		kill prefix = <prefix> 
		create prefix = <prefix> 
	ELSE 
		IF GotParam name 
			IF NodeExists <name> 
				kill name = <name> 
				create name = <name> 
			ELSE 
				printf "### Forced_Create: %n does not exist" n = <name> 
			ENDIF 
		ELSE 
			printf "### Forced_Create: Must specifiy a name or prefix" 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT loadspecial 
ENDSCRIPT

skater_special_index = 0 
SCRIPT find_special_name 
ENDSCRIPT

have_loaded_permanent = 0 
have_loaded_unloadable = 0 
have_loaded_net = 0 
SCRIPT do_load_permanent 
	IF ( have_loaded_permanent ) 
	ELSE 
		IF IsNGC 
			LoadPreFile "anims.pre" 
			PushMemProfile "Permanent Anims" 
			MemPushContext TopDownHeap 
			load_permanent_anims 
			MemPopContext 
			PopMemProfile 
			UnloadPreFile "anims.pre" 
		ELSE 
			do_unload_unloadable 
			PushMemProfile "Permanent Anims" 
			MemPushContext TopDownHeap 
			SetDefaultPermanent 1 
			LoadPipPre "anims.pre" 
			load_permanent_anims use_pip 
			SetDefaultPermanent 0 
			MemPopContext 
			PopMemProfile 
		ENDIF 
		change have_loaded_permanent = 1 
	ENDIF 
ENDSCRIPT

SCRIPT do_unload_permanent 
	IF NOT IsNGC 
		IF ( have_loaded_permanent ) 
			load_permanent_anims LoadFunction = UnloadAnim 
			printf " ------------------ UnloadPipPre anims.pre" 
			IF NOT UnloadPipPre "anims.pre" 
				script_assert "couldn\'t unload pip pre" 
			ENDIF 
			change have_loaded_permanent = 0 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT do_load_unloadable load_peds = 1 
	printf "**************************** do_load_unloadable" 
	IF inNetGame 
		load_peds = 0 
	ENDIF 
	IF ( <load_peds> = 1 ) 
		IF ( have_loaded_unloadable ) 
		ELSE 
			IF ( have_loaded_net ) 
				do_unload_unloadable 
			ENDIF 
			do_load_permanent 
			IF IsNGC 
				LoadPreFile "unloadableanims.pre" 
				PushMemProfile "Unloadable Anims" 
				MemPushContext TopDownHeap 
				load_unloadable_anims 
				MemPopContext 
				PopMemProfile 
				UnloadPreFile "unloadableanims.pre" 
			ELSE 
				PushMemProfile "Unloadable Anims" 
				MemPushContext TopDownHeap 
				LoadPipPre "unloadableanims.pre" 
				SetDefaultPermanent 1 
				load_unloadable_anims use_pip 
				SetDefaultPermanent 0 
				MemPopContext 
				PopMemProfile 
			ENDIF 
			RunScriptOnComponentType component = animation target = InvalidateCache Params = { } 
			change have_loaded_unloadable = 1 
		ENDIF 
	ELSE 
		IF NOT IsNGC 
			IF ( have_loaded_net ) 
			ELSE 
				IF ( have_loaded_unloadable ) 
					do_unload_unloadable 
				ENDIF 
				do_unload_permanent 
				PushMemProfile "Net Anims" 
				MemPushContext TopDownHeap 
				LoadPipPre "Netanims.pre" 
				SetDefaultPermanent 1 
				load_net_anims use_pip 
				SetDefaultPermanent 0 
				RunScriptOnComponentType component = animation target = InvalidateCache Params = { } 
				MemPopContext 
				PopMemProfile 
				change have_loaded_net = 1 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT do_unload_unloadable 
	IF NOT IsNGC 
		IF ( have_loaded_unloadable ) 
			load_unloadable_anims LoadFunction = UnloadAnim 
			IF NOT UnloadPipPre "unloadableanims.pre" 
				script_assert "couldn\'t unload pip pre" 
			ENDIF 
			change have_loaded_unloadable = 0 
		ENDIF 
		IF ( have_loaded_net ) 
			load_net_anims LoadFunction = UnloadAnim 
			IF NOT UnloadPipPre "netanims.pre" 
				script_assert "couldn\'t unload pip pre" 
			ENDIF 
			change have_loaded_net = 0 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT what_is_loaded 
	IF ( have_loaded_permanent ) 
		printf "PERMANENT" 
	ENDIF 
	IF ( have_loaded_unloadable ) 
		printf "UNLOADABLE" 
	ENDIF 
	IF ( have_loaded_net ) 
		printf "NET" 
	ENDIF 
ENDSCRIPT

SCRIPT fireball_death 
	CreateCompositeObject { 
		Components = explosion_composite_structure 
		Params = { 
			pos = <pos> 
			vel = <vel> 
			orient_to_vel 
			scale = <scale> 
			LocalSpace 
			UseStartPosition 
			NoName 
			SystemLifetime = 400 
			NeverSuspend 
			StartPosition = VECTOR(0.00000000000, 0.00000000000, -50.00000000000) 
			BoxDimsStart = VECTOR(20.22046279907, 20.22046279907, 20.22046279907) 
			MidPosition = VECTOR(0.65409302711, -0.76770800352, 0.41774299741) 
			BoxDimsMid = VECTOR(74.37434387207, 74.37434387207, 74.37434387207) 
			EndPosition = VECTOR(-0.94729298353, -0.83414101601, -0.78278702497) 
			BoxDimsEnd = VECTOR(227.08786010742, 227.08786010742, 227.08786010742) 
			Texture = dt_nj_flame02 
			CreatedAtStart 
			AbsentInNetGames 
			UseMidPoint 
			UseColorMidTime 
			type = NEWFLAT 
			BlendMode = add 
			FixedAlpha = 128 
			AlphaCutoff = 0 
			MaxStreams = 2 
			SuspendDistance = 0 
			lod_dist1 = 400 
			lod_dist2 = 401 
			EmitRate = 30.00000000000 
			Lifetime = 0.30000001192 
			MidPointPCT = 50 
			StartRadius = 20.00000000000 
			MidRadius = 100.00000000000 
			EndRadius = 6.00000000000 
			StartRadiusSpread = 0.00000000000 
			MidRadiusSpread = 0.00000000000 
			EndRadiusSpread = 10.00000000000 
			StartRGB = [ 255 , 111 , 54 ] 
			StartAlpha = 129 
			ColorMidTime = 50 
			MidRGB = [ 135 , 35 , 0 ] 
			MidAlpha = 133 
			EndRGB = [ 0 , 0 , 0 ] 
		EndAlpha = 51 } 
	} 
ENDSCRIPT

SCRIPT ClientLaunchFireball 
	IF NOT GameModeEquals is_firefight 
		RETURN 
	ENDIF 
	TheParams = { owner_id = <owner_id> 
		pos = ( <X> * VECTOR(1.00000000000, 0.00000000000, 0.00000000000) + <y> * VECTOR(0.00000000000, 1.00000000000, 0.00000000000) + <z> * VECTOR(0.00000000000, 0.00000000000, 1.00000000000) ) 
		vel = ( <scaled_x> * VECTOR(1.00000000000, 0.00000000000, 0.00000000000) + <scaled_y> * VECTOR(0.00000000000, 1.00000000000, 0.00000000000) + <scaled_z> * VECTOR(0.00000000000, 0.00000000000, 1.00000000000) ) 
		orient_to_vel 
		scale = <scale> 
		radius = <radius> 
		LocalSpace 
		UseStartPosition 
		NoName 
		SystemLifetime = 10000 
		NeverSuspend 
		death_script = fireball_death 
		StartPosition = VECTOR(0.00000000000, 0.00000000000, 0.00000000000) 
		BoxDimsStart = VECTOR(3.33959388733, 3.33959388733, 3.33959388733) 
		MidPosition = VECTOR(-0.10193400085, 2.32613801956, -75.07246398926) 
		BoxDimsMid = VECTOR(10.16847038269, 10.16847038269, 10.16847038269) 
		EndPosition = VECTOR(-1.16847097874, 1.35173904896, -301.16650390625) 
		BoxDimsEnd = VECTOR(2.50771403313, 2.50771403313, 2.50771403313) 
		Texture = dt_nj_flame02 
		CreatedAtStart 
		AbsentInNetGames 
		UseMidPoint 
		UseColorMidTime 
		type = NEWFLAT 
		BlendMode = add 
		FixedAlpha = 128 
		AlphaCutoff = 0 
		MaxStreams = 2 
		SuspendDistance = 0 
		lod_dist1 = 400 
		lod_dist2 = 401 
		EmitRate = 30.00000000000 
		Lifetime = 0.75000000000 
		MidPointPCT = 50 
		StartRadius = 20.00000000000 
		MidRadius = 20.00000000000 
		EndRadius = 5.00000000000 
		StartRadiusSpread = 0.00000000000 
		MidRadiusSpread = 0.00000000000 
		EndRadiusSpread = 10.00000000000 
		StartRGB = [ 54 , 97 , 255 ] 
		StartAlpha = 129 
		ColorMidTime = 50 
		MidRGB = [ 135 , 35 , 0 ] 
		MidAlpha = 27 
		EndRGB = [ 0 , 0 , 0 ] 
		EndAlpha = 0 
	} 
	IF OnServer 
		CreateCompositeObject { 
			Components = server_fireball_composite_structure 
			Params = <TheParams> 
		} 
	ELSE 
		CreateCompositeObject { 
			Components = fireball_composite_structure 
			Params = <TheParams> 
		} 
	ENDIF 
	Obj_PlaySound FlamingFireBall01 vol = ( 130 + <scale> * 15 ) pitch = ( 190 - <scale> * 7 ) dropoff = 140 
ENDSCRIPT

SCRIPT LaunchFireball vel_scale = 1.00000000000 
	IF NOT GameModeEquals is_firefight 
		RETURN 
	ENDIF 
	GetFireballLevel 
	point_scale = 3 
	SWITCH <level> 
		CASE 1 
			point_scale = 1 
		CASE 2 
			point_scale = 5 
		CASE 3 
			point_scale = 25 
		CASE 4 
			point_scale = 100 
		CASE 5 
			point_scale = 250 
	ENDSWITCH 
	GetSkaterPosition 
	scaled_vel = ( <vel_scale> * 5000.00000000000 ) 
	GetSkaterVelocity scale = <scaled_vel> <...> 
	IF CurrentScorePotGreaterThan ( 20000 * <point_scale> ) 
		radius = 400 
		scale = 10.00000000000 
	ELSE 
		IF CurrentScorePotGreaterThan ( 10000 * <point_scale> ) 
			radius = 200 
			scale = 5.00000000000 
		ELSE 
			IF CurrentScorePotGreaterThan ( 5000 * <point_scale> ) 
				radius = 100 
				scale = 3.50000000000 
			ELSE 
				IF CurrentScorePotGreaterThan ( 2500 * <point_scale> ) 
					radius = 75 
					scale = 2.50000000000 
				ELSE 
					IF CurrentScorePotGreaterThan ( 750 * <point_scale> ) 
						radius = 60 
						scale = 2.00000000000 
					ELSE 
						IF CurrentScorePotGreaterThan ( 250 * <point_scale> ) 
							radius = 45 
							scale = 1.50000000000 
						ELSE 
							radius = 24 
							scale = 1.00000000000 
						ENDIF 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
	new_y = ( <y> ) 
	<y> = <new_y> 
	GetCurrentSkaterId 
	IF inNetGame 
		BroadcastProjectile objID = <objID> type = fireball scale = <scale> radius = <radius> pos = ( <X> * VECTOR(1.00000000000, 0.00000000000, 0.00000000000) + <new_y> * VECTOR(0.00000000000, 1.00000000000, 0.00000000000) + <z> * VECTOR(0.00000000000, 0.00000000000, 1.00000000000) ) vel = ( <scaled_x> * VECTOR(1.00000000000, 0.00000000000, 0.00000000000) + <scaled_y> * VECTOR(0.00000000000, 1.00000000000, 0.00000000000) + <scaled_z> * VECTOR(0.00000000000, 0.00000000000, 1.00000000000) ) 
	ENDIF 
	GetCurrentSkaterId 
	ClientLaunchFireball owner_id = <objID> <...> 
ENDSCRIPT

SCRIPT SetObjectColor_CurrentTOD 
	SWITCH current_tod 
		CASE morning 
			set_tod_morning 
		CASE day 
			set_tod_day 
		CASE evening 
			set_tod_evening 
		CASE night 
			set_tod_night 
		DEFAULT 
			printf "NO TOD SET TO SWITCH BACK TO" 
	ENDSWITCH 
	SetObjectColor <...> color = ( lev_red + ( lev_green * 256 ) + ( lev_blue * 65536 ) ) 
ENDSCRIPT

SCRIPT KillCreateSponsorGeo 
	GoalManager_GetSponsor 
	IF GotParam sponsor_kill_prefix 
		kill prefix = <sponsor_kill_prefix> 
	ELSE 
		printf " >>>>>>>> WARNING: NO GEO PREFIX SENT TO KillCreateSponsorGeo >>>>>>>>>>> " 
		RETURN 
	ENDIF 
	IF GotParam nosponsor_prefix 
		kill prefix = <nosponsor_prefix> 
	ENDIF 
	SWITCH <sponsor> 
		CASE sponsor_birdhouse 
			printf "I\'m on Birdhouse!" 
			create prefix = <sponsor_birdhouse_prefix> 
		CASE sponsor_element 
			printf "I\'m on Element!" 
			create prefix = <sponsor_element_prefix> 
		CASE sponsor_flip 
			printf "I\'m on Flip!" 
			create prefix = <sponsor_flip_prefix> 
		CASE sponsor_girl 
			printf "I\'m on Girl!" 
			create prefix = <sponsor_girl_prefix> 
		CASE sponsor_zero 
			printf "I\'m on Zero!" 
			create prefix = <sponsor_zero_prefix> 
		DEFAULT 
			IF GotParam nosponsor_prefix 
				create prefix = <nosponsor_prefix> 
			ENDIF 
	ENDSWITCH 
ENDSCRIPT

SCRIPT GetNetworkNumPlayers 
	GetPreferenceChecksum pref_type = network num_players 
	SWITCH <checksum> 
		CASE num_2 
			RETURN num_players = 2 
		CASE num_3 
			RETURN num_players = 3 
		CASE num_4 
			RETURN num_players = 4 
		CASE num_5 
			RETURN num_players = 5 
		CASE num_6 
			RETURN num_players = 6 
		CASE num_7 
			RETURN num_players = 7 
		CASE num_8 
			RETURN num_players = 8 
		DEFAULT 
			RETURN num_players = 1 
	ENDSWITCH 
ENDSCRIPT


