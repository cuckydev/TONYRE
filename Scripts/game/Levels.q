
UsePreFilesForLevelLoading = 0 
fake_net = 0 
AssertOnMissingScripts = 0 
AssertOnMissingAssets = 0 
AlwaysDump = 0 
next_level_script = nullscript 
SCRIPT cleanup_before_loading_level 
	printf "*********************** cleanup_before_loading_level" 
	Cleanup 
	StopMusic 
	PauseMusic 
	ClearMusicTrackList 
ENDSCRIPT

SCRIPT PreLevelLoad 
ENDSCRIPT

SCRIPT PostLevelLoad 
ENDSCRIPT

SCRIPT script_assert <...> 
	printf "ASSERT MESSAGE:" 
	ScriptAssert <...> 
ENDSCRIPT

SCRIPT request_level 
	IF gotparam level 
		RequestLevel <level> 
	ELSE 
		script_assert "request_level needs a level param" 
	ENDIF 
ENDSCRIPT

SCRIPT LoadLevel 
	MemPushContext 0 
	PreLevelLoad 
	ScreenElementSystemCleanup 
	LaunchLevel <...> 
	PostLevelLoad 
	MemPopContext 
ENDSCRIPT

LevelNum_NJ = 1 
LevelNum_NY = 2 
LevelNum_FL = 3 
LevelNum_SD = 4 
LevelNum_HI = 5 
LevelNum_VC = 6 
LevelNum_SJ = 7 
LevelNum_RU = 8 
LevelNum_AU = 9 
LevelNum_SE = 10 
LevelNum_Default = 11 
LevelNum_SC = 12 
LevelNum_DJ = 13 
LevelNum_PH = 14 
LevelNum_VN = 16 
LevelNum_HN = 17 
LevelNum_SC2 = 15 
LevelNum_WWW = 18 
LevelNum_CAS = 19 
LevelNum_Boardshop = 20 
LevelNum_TestLevel = 21 
LevelNum_Skateshop = 0 
LevelNum_Sch = 1 
LevelNum_SF2 = 2 
LevelNum_Alc = 3 
LevelNum_Kon = 4 
LevelNum_Jnk = 5 
LevelNum_Lon = 6 
LevelNum_Zoo = 7 
LevelNum_Cnv = 8 
LevelNum_Hof = 9 
LevelNum_Sk5ed = 11 
LevelNum_Airport = 1 
LevelNum_Canada = 2 
LevelNum_Rio = 3 
LevelNum_Suburbia = 4 
LevelNum_Foundry = 5 
LevelNum_SkaterIsland = 6 
LevelNum_LA = 7 
LevelNum_Tokyo = 8 
LevelNum_Ship = 9 
LevelNum_Oil = 10 
LevelNum_Tutorials = 11 
LevelNum_Warehouse = 12 
LevelNum_Burnside = 13 
LevelNum_Roswell = 14 
LevelNum_Rooftops = 15 
levels_with_gaps = [ 
	LevelNum_NJ 
	LevelNum_NY 
	LevelNum_FL 
	LevelNum_SD 
	LevelNum_HI 
	LevelNum_VC 
	LevelNum_SJ 
	LevelNum_RU 
	LevelNum_SE 
	LevelNum_SC2 
	LevelNum_VN 
	LevelNum_HN 
] 
SCRIPT LoadLevelPreFile 
	IF istrue UsePreFilesForLevelLoading 
		LoadPreFile <...> 
	ENDIF 
ENDSCRIPT

SCRIPT set_level_lights fog_red = 0 fog_blue = 0 fog_green = 0 fog_alpha = 0 fog_dist = 0 
	printf "heading=%h" h = <heading_0> 
	SetLightAmbientColor r = <ambient_red> g = <ambient_green> b = <ambient_blue> 
	SetLightDirection index = 0 heading = <heading_0> pitch = <pitch_0> 
	SetLightDiffuseColor index = 0 r = <red_0> g = <green_0> b = <blue_0> 
	SetLightDirection index = 1 heading = <heading_1> pitch = <pitch_1> 
	SetLightDiffuseColor index = 1 r = <red_1> g = <green_1> b = <blue_1> 
	SetDynamicLightModulationFactor ambient value = <ambient_mod_factor> 
	SetDynamicLightModulationFactor directional = 0 value = <mod_factor_0> 
	SetDynamicLightModulationFactor directional = 1 value = <mod_factor_1> 
	IF gotparam load_script 
		IF NOT ( <load_script> = Load_Default ) 
			IF NOT ( <fog_dist> = 0 ) 
				EnableFog 
				SetFogColor r = <fog_red> b = <fog_blue> g = <fog_green> a = <fog_alpha> 
				SetFogDistance distance = <fog_dist> 
			ELSE 
				DisableFog 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

ANY_LEVEL_LOADED_YET = 0 
SCRIPT load_level level_number = 0 
	IF InNetGame 
		IF NOT IsObserving 
			ExitSurveyorMode 
		ENDIF 
	ENDIF 
	change freemem_script_lowest = 999999999 
	change freemem_main_lowest = 999999999 
	do_unload_unloadable 
	IF NOT InNetGame 
		IF NOT gotparam park_editor 
			do_load_permanent 
		ENDIF 
	ENDIF 
	RememberLevelStructureNameForReplays level_structure_name = <structure_name> 
	GoalManager_RememberLevelStructureName level_structure_name = <structure_name> 
	IF ( ( cd ) | ( istrue TestMusicFromHost ) ) 
		IF gotparam ambient_track 
			AddMusicTrack <ambient_track> 
		ENDIF 
	ENDIF 
	kill_start_key_binding 
	printf "replace_handlers to take away start key in load_level" 
	set_level_lights <...> 
	SetScoreAccumulation 0 
	SetScoreDegradation 0 
	IF InSplitScreenGame 
		UnSetGlobalFlag flag = CHEAT_DISCO 
	ENDIF 
	IF isXbox 
		IF gotparam loading_time_xbox 
			<loading_time> = <loading_time_xbox> 
		ELSE 
			<loading_time> = ( <loading_time> * 0.60000002384 ) 
		ENDIF 
	ELSE 
		IF ( ANY_LEVEL_LOADED_YET = 0 ) 
			<loading_time> = ( <loading_time> + 0 ) 
			change ANY_LEVEL_LOADED_YET = 1 
		ENDIF 
	ENDIF 
	printf "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@" 
	printf "@@@ LOADLEVEL" 
	IF istrue Bootstrap_build 
		DisplayLoadingScreen "loadscrn_demo_controls" 27 
	ELSE 
		IF gotparam loading_screen 
			IF EnteringNetGame 
				IF OnServer 
					IF isXbox 
						DisplayLoadingScreen "loadscrn_system_link_x" <loading_time> 
					ELSE 
						DisplayLoadingScreen "loadscrn_Online" <loading_time> 
						printf "@@@ AS SERVER" 
					ENDIF 
				ELSE 
					printf "@@@ AS CLIENT" 
					IF isXbox 
						DisplayLoadingScreen "loadscrn_system_x" <loading_time> 
					ELSE 
						DisplayLoadingScreen "loadscrn_Online2" <loading_time> 
					ENDIF 
				ENDIF 
			ELSE 
				printf "@@@ NON NET GAME" 
				IF InSplitScreenGame 
					DisplayLoadingScreen "loadscrn_2player" <loading_time> 
				ELSE 
					IF ( Display_Story_Peralta_LoadingScreen ) 
						change Display_Story_Peralta_LoadingScreen = 0 
						<loading_screen> = "loadscrn_peralta" 
					ENDIF 
					IF ( Display_Story_Final_LoadingScreen ) 
						change Display_Story_Final_LoadingScreen = 0 
						<loading_screen> = "loadscrn_final" 
					ENDIF 
					IF ( Display_Story_Premiere_LoadingScreen ) 
						change Display_Story_Premiere_LoadingScreen = 0 
						<loading_screen> = "loadscrn_premiere" 
					ENDIF 
					IF ( launch_to_createatrick = 1 ) 
						IF isXbox 
							<loading_screen> = "loadscrn_trick_x" 
						ELSE 
							IF isNGC 
								<loading_screen> = "loadscrn_trick_ngc" 
							ELSE 
								<loading_screen> = "loadscrn_trick" 
							ENDIF 
						ENDIF 
					ENDIF 
					DisplayLoadingScreen <loading_screen> <loading_time> 
				ENDIF 
			ENDIF 
		ELSE 
			DisplayLoadingScreen "loadscrn_generic" 
		ENDIF 
	ENDIF 
	exit_pause_menu 
	CareerStartLevel level = <level_number> 
	IF NOT InNetGame 
		AllocatePathManMemory 
	ENDIF 
	ResetLevelFlags 
	IF ( <level_number> = LevelNum_Skateshop ) 
	ENDIF 
	IF gotparam scnpre 
		IF NOT InNetGame 
			LoadLevelPreFile <scnpre> 
		ELSE 
			IF gotparam park_editor 
				LoadLevelPreFile <scnpre> 
			ELSE 
				LoadLevelPreFile ( <level> + "scn_net.pre" ) 
			ENDIF 
		ENDIF 
	ENDIF 
	IF gotparam sky 
		LoadScene scene = <sky> 
	ENDIF 
	IF gotparam park_editor 
		LoadScene scene = <level> is_dictionary 
		IF gotparam outer_shell 
			LoadScene scene = <outer_shell> no_supersectors 
		ENDIF 
	ELSE 
		IF gotparam level 
			IF InNetGame 
				LoadScene scene = <level> is_net 
			ELSE 
				LoadScene scene = <level> 
			ENDIF 
		ENDIF 
	ENDIF 
	IF gotparam level_name 
		SetLevelName <level_name> 
	ELSE 
		SetLevelName <level> 
	ENDIF 
	IF gotparam scnpre 
		IF NOT InNetGame 
			UnloadPreFile <scnpre> dont_assert 
		ELSE 
			IF gotparam park_editor 
				UnloadPreFile <scnpre> dont_assert 
			ELSE 
				UnloadPreFile ( <level> + "scn_net.pre" ) dont_assert 
			ENDIF 
		ENDIF 
	ENDIF 
	IF isNGC 
		IF NOT InMultiPlayerGame 
			IF gotparam pedpre 
				LoadPreFile <pedpre> dont_assert 
			ENDIF 
		ENDIF 
	ENDIF 
	IF NOT IsPS2 
		IF gotparam pre 
			LoadLevelPreFile <pre> 
		ENDIF 
	ENDIF 
	IF isNGC 
		IF german 
			LoadPreFile ( <pre> + "d" ) dont_assert 
		ELSE 
			IF french 
				LoadPreFile ( <pre> + "f" ) dont_assert 
			ENDIF 
		ENDIF 
	ENDIF 
	IF gotparam qb 
		IF isNGC 
			IF german 
				<qb> = ( <qb> + "d" ) 
			ELSE 
				IF french 
					<qb> = ( <qb> + "f" ) 
				ENDIF 
			ENDIF 
		ENDIF 
		IF gotparam park_editor 
			LoadNodeArray <qb> park_editor 
		ELSE 
			LoadNodeArray <qb> 
		ENDIF 
	ENDIF 
	IF IsPS2 
		IF gotparam pre 
			LoadLevelPreFile <pre> 
		ENDIF 
	ENDIF 
	IF gotparam park_editor 
	ELSE 
		IF gotparam qb 
			PreloadModels 
		ENDIF 
	ENDIF 
	IF gotparam level_qb 
		IF isNGC 
			IF german 
				<level_qb> = ( <level_qb> + "d" ) 
			ELSE 
				IF french 
					<level_qb> = ( <level_qb> + "f" ) 
				ENDIF 
			ENDIF 
		ENDIF 
		UnloadQB <level_qb> 
		LoadQB <level_qb> LevelSpecific 
	ENDIF 
	IF gotparam level_sfx_qb 
		IF isNGC 
			IF german 
				<level_sfx_qb> = ( <level_sfx_qb> + "d" ) 
			ELSE 
				IF french 
					<level_sfx_qb> = ( <level_sfx_qb> + "f" ) 
				ENDIF 
			ENDIF 
		ENDIF 
		LoadQB <level_sfx_qb> LevelSpecific 
	ENDIF 
	IF isNGC 
		IF german 
			UnloadPreFile ( <pre> + "d" ) dont_assert 
		ELSE 
			IF french 
				UnloadPreFile ( <pre> + "f" ) dont_assert 
			ENDIF 
		ENDIF 
	ENDIF 
	IF gotparam qb 
		preselect_random_parts <...> 
	ENDIF 
	IF gotparam park_editor 
		LoadTerrain 
	ELSE 
		SetTerrainDefault 
		IF gotparam qb 
			LoadTerrain 
		ENDIF 
	ENDIF 
	IF istrue UseLevelOverrideStats 
		IF gotparam default_stats 
			IF ( bump_stats = 0 ) 
				SetAllStats value = <default_stats> 
			ENDIF 
		ENDIF 
	ENDIF 
	IF NOT InNetGame 
		IF ScriptExists load_level_anims 
			PushMemProfile "Level Specific Anims" 
			load_level_anims 
			PopMemProfile 
		ENDIF 
	ENDIF 
	IF NOT InNetGame 
		IF ScriptExists LoadCameras 
			PushMemProfile "Level Cameras" 
			LoadCameras 
			PopMemProfile 
		ENDIF 
	ENDIF 
	IF ScriptExists LoadObjectAnims 
		PushMemProfile "Object Anims" 
		LoadObjectAnims 
		PopMemProfile 
	ENDIF 
	IF ScriptExists LoadAllParticleTextures 
		PushMemProfile "Particle Textures" 
		LoadAllParticleTextures 
		PopMemProfile 
	ENDIF 
	IF gotparam extranetanimsscript 
		IF InNetGame 
			printf "                    WE\'RE IN A NET GAME!!!!!!!!!!!!!" 
			PushMemProfile "Level Specific Anims" 
			<extranetanimsscript> 
			PopMemProfile 
		ENDIF 
	ENDIF 
	IF gotparam park_editor 
	ELSE 
		IF isNGC 
			IF ( <level_number> = LevelNum_CAS ) 
			ELSE 
				IF ( <level_number> = LevelNum_Skateshop ) 
				ELSE 
					IF ( <level_number> = LevelNum_Boardshop ) 
					ELSE 
						IF gotparam startup_script 
							<startup_script> 
						ENDIF 
					ENDIF 
				ENDIF 
			ENDIF 
		ELSE 
			IF gotparam startup_script 
				<startup_script> 
			ENDIF 
		ENDIF 
	ENDIF 
	IF NOT isNGC 
		IF gotparam pre 
			UnloadPreFile <pre> dont_assert 
		ENDIF 
	ENDIF 
	IF NOT isNGC 
		IF NOT InMultiPlayerGame 
			IF gotparam pedpre 
				LoadPreFile <pedpre> dont_assert 
			ENDIF 
		ENDIF 
	ENDIF 
	IF NOT InMultiPlayerGame 
		IF gotparam qb 
			IF NOT gotparam frontend_level 
				IF gotparam park_editor 
					PreloadPedestrians no_random 
				ELSE 
					PreloadPedestrians 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
	IF NOT InNetGame 
		IF InMultiPlayerGame 
			PreloadModel name = "crown" 
		ENDIF 
	ENDIF 
	IF NOT isNGC 
		IF NOT InMultiPlayerGame 
			IF gotparam pedpre 
				UnloadPreFile <pedpre> dont_assert 
			ENDIF 
		ENDIF 
	ENDIF 
	IF ( <level_number> = LevelNum_Skateshop ) 
		load_mainmenu_textures_to_main_memory 
	ENDIF 
	IF gotparam park_editor 
	ELSE 
		IF isNGC 
			IF gotparam startup_script 
				IF ( <level_number> = LevelNum_CAS ) 
					<startup_script> 
				ENDIF 
				IF ( <level_number> = LevelNum_Skateshop ) 
					<startup_script> 
				ENDIF 
				IF ( <level_number> = LevelNum_Boardshop ) 
					<startup_script> 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
	PushMemProfile "Level Collision decompressed PIP + Supersectors" 
	IF istrue UsePreFilesForLevelLoading 
		IF gotparam colpre 
			IF NOT InNetGame 
				LoadPipPre <colpre> heap = bottomup 
			ELSE 
				IF gotparam park_editor 
					LoadPipPre <colpre> heap = bottomup 
				ELSE 
					LoadPipPre ( <level> + "col_net.pre" ) heap = bottomup 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
	IF InNetGame 
		IF gotparam park_editor 
			LoadCollision scene = <level> 
		ELSE 
			LoadCollision scene = <level> is_net 
		ENDIF 
	ELSE 
		LoadCollision scene = <level> 
	ENDIF 
	IF gotparam park_editor 
		IF gotparam outer_shell 
			IF istrue UsePreFilesForLevelLoading 
				<extension> = "col.pre" 
				LoadPipPre ( <outer_shell> + <extension> ) heap = bottomupheap 
			ENDIF 
			LoadCollision scene = <outer_shell> 
		ENDIF 
	ENDIF 
	PopMemProfile 
	IF gotparam park_editor 
		IF gotparam startup_script 
			<startup_script> 
		ENDIF 
	ELSE 
		IF gotparam qb 
			ParseNodeArray 
		ENDIF 
	ENDIF 
	IF ( auto_change_chapter_and_stage = 1 ) 
		GetCurrentLevel 
		IF StructureContains structure = LEVEL_CHAPTER_MAP <level> 
			GoalManager_SetCurrentChapterAndStage chapter = ( LEVEL_CHAPTER_MAP . <level> ) stage = 0 
		ENDIF 
	ENDIF 
	IF gotparam goals_script 
		<goals_script> 
	ENDIF 
	IF GameModeEquals is_creategoals 
		InitialiseCreatedGoals 
	ELSE 
		IF InNetGame 
			InitialiseCreatedGoals DoNotCreateGoalPeds 
		ENDIF 
	ENDIF 
	IF GameModeEquals is_singlesession 
		AddGoal_TrickAttack 
	ENDIF 
	IF GameModeEquals is_career 
		IF NOT ( <level_number> = 0 ) 
			SetGlobalFlag flag = CAREER_STARTED 
			printf "CAREER_STARTED" 
		ENDIF 
	ENDIF 
	init_goal_manager 
	IF gotparam setup_script 
		<setup_script> 
	ENDIF 
	IF gotparam frontend_level 
		script_reset_tod 
	ELSE 
		script_change_tod tod_action = set_tod_startup 
	ENDIF 
	IF NOT gotparam park_editor 
		do_load_unloadable 
	ENDIF 
	IF gotparam frontend_level 
		IF ( <frontend_level> = 1 ) 
			IF isNGC 
				LoadPreFile "skaterparts.pre" use_bottom_up_heap 
			ELSE 
				IF NOT istrue cas_artist 
					IF ( <level_number> = LevelNum_Skateshop ) 
						LoadPreFile "skaterparts.pre" 
					ELSE 
						LoadPreFile "skaterparts.pre" use_bottom_up_heap 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
	IF InSplitScreenGame 
		AllocateSplitScreenDMA 
	ENDIF 
	UnPauseGame 
	IF gotparam viewer_mode 
		gameflow StandardGameFlowToggleView 
		change AssertOnMissingScripts = 0 
		change AssertOnMissingAssets = 0 
	ELSE 
		change AssertOnMissingScripts = 1 
		change AssertOnMissingAssets = 1 
		gameflow StandardGameFlow 
	ENDIF 
	IF isNGC 
		IF gotparam pre 
			UnloadPreFile <pre> dont_assert 
		ENDIF 
		IF NOT InMultiPlayerGame 
			IF gotparam pedpre 
				UnloadPreFile <pedpre> dont_assert 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT LoadTerrain_parked 
	SetTerrainDefault 
	SetTerrainConcSmooth 
	SetTerrainConcRough 
	SetTerrainMetalSmooth 
	SetTerrainMetalRough 
	SetTerrainMetalGrating 
	SetTerrainWood 
	SetTerrainWoodMasonite 
	SetTerrainWoodPlywood 
	SetTerrainWoodPier 
	SetTerrainBrick 
	SetTerrainTile 
	SetTerrainAsphalt 
	SetTerrainRock 
	SetTerrainGravel 
	SetTerrainSidewalk 
	SetTerrainGrass 
	SetTerrainDirt 
	SetTerrainWater 
	SetTerrainPlexiglass 
	SetTerrainChainlink 
	SetTerrainGrindwire 
	SetTerrainGrindConc 
	SetTerrainGrindMetal 
	SetTerrainGrindWood 
ENDSCRIPT

SCRIPT init_goal_manager 
	GoalManager_LevelLoad 
	IF InNetGame 
		GoalManager_InitializeAllMinigames 
		UnSetFlag flag = FLAG_PROSET1_GEO_ON 
		UnSetFlag flag = FLAG_PROSET2_GEO_ON 
		UnSetFlag flag = FLAG_PROSET3_GEO_ON 
		UnSetFlag flag = FLAG_PROSET4_GEO_ON 
		UnSetFlag flag = FLAG_PROSET5_GEO_ON 
		UnSetFlag flag = FLAG_PROSET6_GEO_ON 
		UnSetFlag flag = FLAG_PROSET7_GEO_ON 
	ELSE 
		GoalManager_SetGoalChaptersAndStages 
	ENDIF 
	GoalManager_UpdateFamilyTrees 
	GoalManager_InitializeAllGoals 
	GoalManager_GetCurrentChapterAndStage 
	IF GameModeEquals is_career 
		GetCurrentLevel 
		IF ( ( ( CHAPTER_LEVELS [ <currentChapter> ] ) . checksum ) = <level> ) 
			GoalManager_RunLastStageScript 
		ENDIF 
	ENDIF 
	GoalManager_SetCanStartGoal 1 
	IF CareerLevelIs LevelNum_Skateshop 
		GoalManager_HideGoalPoints 
		GoalManager_HidePoints 
	ELSE 
		IF NOT InMultiPlayerGame 
			GoalManager_ShowGoalPoints 
		ENDIF 
		IF NOT ( in_cinematic_sequence ) 
			GoalManager_ShowPoints 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT Load_Default 
	load_level Level_Default 
ENDSCRIPT

SCRIPT Load_EmptyDefault 
	load_level Level_EmptyDefault 
ENDSCRIPT

SCRIPT Load_NJ 
	load_level Level_NJ 
ENDSCRIPT

SCRIPT Load_NY 
	load_level Level_NY 
ENDSCRIPT

SCRIPT Load_FL 
	load_level Level_FL 
ENDSCRIPT

SCRIPT Load_SD 
	load_level Level_SD 
ENDSCRIPT

SCRIPT Load_HI 
	load_level Level_HI 
ENDSCRIPT

SCRIPT Load_VC 
	load_level Level_VC 
ENDSCRIPT

SCRIPT Load_SJ 
	load_level Level_SJ 
ENDSCRIPT

SCRIPT Load_RU 
	load_level Level_RU 
ENDSCRIPT

SCRIPT Load_AU 
	load_level Level_AU 
ENDSCRIPT

SCRIPT Load_SE 
	load_level Level_SE 
ENDSCRIPT

SCRIPT Load_TestLevel 
	load_level Level_TestLevel 
ENDSCRIPT

SCRIPT Load_SC 
	load_level Level_SC 
ENDSCRIPT

SCRIPT Load_DJ 
	load_level Level_DJ 
ENDSCRIPT

SCRIPT Load_PH 
	load_level Level_PH 
ENDSCRIPT

SCRIPT Load_VN 
	load_level Level_VN 
ENDSCRIPT

SCRIPT Load_hn 
	load_level Level_HN 
ENDSCRIPT

SCRIPT Load_sc2 
	load_level Level_SC2 
ENDSCRIPT

SCRIPT Load_WWW 
	load_level Level_WWW 
ENDSCRIPT

SCRIPT Load_Test 
	load_level Level_Test 
ENDSCRIPT

Level_Default = { 
	structure_name = Level_Default 
	load_script = Load_Default 
	name = "Default" 
	loading_screen = "loadscrn_generic" 
	loading_time = 9.50000000000 
	level = "Default" 
	sky = "Default_Sky" 
	qb = "levels\\Default\\Default.qb" 
	level_qb = "levels\\Default\\Default_scripts.qb" 
	startup_script = Default_Startup 
	goals_script = Default_goals 
	setup_script = Default_setup 
	default_stats = 5 
	level_number = LevelNum_Default 
	viewer_mode = 1 
	ambient_red = 69 
	ambient_green = 72 
	ambient_blue = 79 
	ambient_mod_factor = 0.30000001192 
	heading_0 = 50 
	pitch_0 = 330 
	red_0 = 130 
	green_0 = 120 
	blue_0 = 97 
	mod_factor_0 = 1.39999997616 
	heading_1 = 240 
	pitch_1 = 330 
	red_1 = 58 
	green_1 = 62 
	blue_1 = 66 
	mod_factor_1 = 0.40000000596 
	num_m_heads = 4 
	num_m_torsos = 4 
	num_m_legs = 4 
} 
Level_EmptyDefault = { 
	structure_name = Level_EmptyDefault 
	load_script = Load_EmptyDefault 
	name = "Default" 
	loading_screen = "loadscrn_generic" 
	loading_time = 9.50000000000 
	level = "Default" 
	sky = "NJ_Sky" 
	default_stats = 5 
	level_number = LevelNum_Default 
	viewer_mode = 1 
	ambient_red = 69 
	ambient_green = 72 
	ambient_blue = 79 
	ambient_mod_factor = 0.30000001192 
	heading_0 = 120.00000000000 
	pitch_0 = -127.00000000000 
	red_0 = 130 
	green_0 = 120 
	blue_0 = 97 
	mod_factor_0 = 1.39999997616 
	heading_1 = -45.00000000000 
	pitch_1 = -110.00000000000 
	red_1 = 58 
	green_1 = 62 
	blue_1 = 66 
	mod_factor_1 = 0.10000000149 
	num_m_heads = 4 
	num_m_torsos = 4 
	num_m_legs = 4 
} 
Level_NJ = { 
	structure_name = Level_NJ 
	load_script = Load_NJ 
	name = "New Jersey" 
	loading_screen = "loadscrn_jersey" 
	loading_time = 15.50000000000 
	pre = "NJ.pre" 
	scnpre = "NJscn.pre" 
	level = "NJ" 
	sky = "NJ_Sky" 
	qb = "levels\\NJ\\NJ.qb" 
	colpre = "NJcol.pre" 
	pedpre = "NJped.pre" 
	level_qb = "levels\\NJ\\NJ_scripts.qb" 
	level_sfx_qb = "levels\\NJ\\NJ_sfx.qb" 
	startup_script = NJ_Startup 
	goals_script = NJ_goals 
	setup_script = NJ_setup 
	default_stats = 5 
	level_number = LevelNum_NJ 
	ambient_red = 69 
	ambient_green = 72 
	ambient_blue = 79 
	ambient_mod_factor = 0.30000001192 
	heading_0 = 50 
	pitch_0 = 330 
	red_0 = 130 
	green_0 = 120 
	blue_0 = 97 
	mod_factor_0 = 1.39999997616 
	heading_1 = 240 
	pitch_1 = 330 
	red_1 = 58 
	green_1 = 62 
	blue_1 = 66 
	mod_factor_1 = 0.40000000596 
	fog_red = 0 
	fog_blue = 0 
	fog_green = 0 
	fog_alpha = 0 
	fog_dist = 0 
	num_m_heads = 8 
	num_m_torsos = 8 
	num_m_legs = 6 
} 
Level_NY = { 
	structure_name = Level_NY 
	load_script = Load_NY 
	name = "Manhattan" 
	loading_screen = "loadscrn_manhattan" 
	loading_time = 22 
	pre = "NY.pre" 
	scnpre = "NYscn.pre" 
	level = "NY" 
	sky = "NY_Sky" 
	qb = "levels\\NY\\NY.qb" 
	colpre = "NYcol.pre" 
	pedpre = "NYped.pre" 
	level_qb = "levels\\NY\\NY_scripts.qb" 
	level_sfx_qb = "levels\\NY\\NY_sfx.qb" 
	startup_script = NY_Startup 
	goals_script = NY_goals 
	setup_script = NY_setup 
	default_stats = 6 
	level_number = LevelNum_NY 
	ambient_red = 69 
	ambient_green = 72 
	ambient_blue = 79 
	ambient_mod_factor = 0.30000001192 
	heading_0 = 330.00000000000 
	pitch_0 = 330.00000000000 
	red_0 = 130 
	green_0 = 120 
	blue_0 = 97 
	mod_factor_0 = 1.39999997616 
	heading_1 = 150.00000000000 
	pitch_1 = 330.00000000000 
	red_1 = 58 
	green_1 = 62 
	blue_1 = 66 
	mod_factor_1 = 0.10000000149 
	fog_red = 126 
	fog_blue = 227 
	fog_green = 169 
	fog_alpha = 45 
	fog_dist = 1000 
	num_m_heads = 8 
	num_m_torsos = 8 
	num_m_legs = 6 
} 
Level_FL = { 
	structure_name = Level_FL 
	load_script = Load_FL 
	name = "Florida" 
	loading_screen = "loadscrn_florida" 
	loading_time = 18 
	pre = "FL.pre" 
	scnpre = "FLscn.pre" 
	level = "FL" 
	sky = "FL_Sky" 
	qb = "levels\\FL\\FL.qb" 
	colpre = "FLcol.pre" 
	pedpre = "FLped.pre" 
	level_qb = "levels\\FL\\FL_scripts.qb" 
	level_sfx_qb = "levels\\FL\\FL_sfx.qb" 
	startup_script = FL_Startup 
	goals_script = FL_goals 
	setup_script = FL_setup 
	default_stats = 6 
	level_number = LevelNum_FL 
	ambient_red = 69 
	ambient_green = 72 
	ambient_blue = 79 
	ambient_mod_factor = 0.30000001192 
	heading_0 = 50.00000000000 
	pitch_0 = 330.00000000000 
	red_0 = 130 
	green_0 = 120 
	blue_0 = 97 
	mod_factor_0 = 1.39999997616 
	heading_1 = 240.00000000000 
	pitch_1 = 330.00000000000 
	red_1 = 58 
	green_1 = 62 
	blue_1 = 66 
	mod_factor_1 = 0.10000000149 
	fog_red = 150 
	fog_blue = 255 
	fog_green = 150 
	fog_alpha = 20 
	fog_dist = 900 
	num_m_heads = 8 
	num_m_torsos = 8 
	num_m_legs = 6 
} 
Level_SD = { 
	structure_name = Level_SD 
	load_script = Load_SD 
	name = "San Diego" 
	loading_screen = "loadscrn_diego" 
	loading_time = 18 
	pre = "SD.pre" 
	scnpre = "SDscn.pre" 
	level = "SD" 
	sky = "SD_Sky" 
	qb = "levels\\SD\\SD.qb" 
	colpre = "SDcol.pre" 
	pedpre = "SDped.pre" 
	level_qb = "levels\\SD\\SD_scripts.qb" 
	level_sfx_qb = "levels\\SD\\SD_sfx.qb" 
	startup_script = SD_Startup 
	goals_script = SD_goals 
	setup_script = SD_setup 
	default_stats = 7 
	level_number = LevelNum_SD 
	extranetanimsscript = animload_Ped_Driver 
	ambient_red = 69 
	ambient_green = 72 
	ambient_blue = 79 
	ambient_mod_factor = 0.30000001192 
	heading_0 = 80.00000000000 
	pitch_0 = 330.00000000000 
	red_0 = 130 
	green_0 = 120 
	blue_0 = 97 
	mod_factor_0 = 1.39999997616 
	heading_1 = 280.00000000000 
	pitch_1 = 330.00000000000 
	red_1 = 58 
	green_1 = 62 
	blue_1 = 66 
	mod_factor_1 = 0.10000000149 
	fog_red = 0 
	fog_blue = 0 
	fog_green = 0 
	fog_alpha = 0 
	fog_dist = 0 
	num_m_heads = 8 
	num_m_torsos = 8 
	num_m_legs = 6 
	num_f_legs = 3 
} 
Level_HI = { 
	structure_name = Level_HI 
	load_script = Load_HI 
	name = "Hawaii" 
	loading_screen = "loadscrn_hawaii" 
	loading_time = 20 
	pre = "HI.pre" 
	scnpre = "HIscn.pre" 
	level = "HI" 
	sky = "HI_Sky" 
	qb = "levels\\HI\\HI.qb" 
	colpre = "HIcol.pre" 
	pedpre = "HIped.pre" 
	level_qb = "levels\\HI\\HI_scripts.qb" 
	level_sfx_qb = "levels\\HI\\HI_sfx.qb" 
	startup_script = HI_Startup 
	goals_script = HI_goals 
	setup_script = HI_setup 
	default_stats = 7 
	level_number = LevelNum_HI 
	ambient_red = 69 
	ambient_green = 72 
	ambient_blue = 79 
	ambient_mod_factor = 0.30000001192 
	heading_0 = 320.00000000000 
	pitch_0 = 330.00000000000 
	red_0 = 130 
	green_0 = 120 
	blue_0 = 97 
	mod_factor_0 = 1.39999997616 
	heading_1 = 160.00000000000 
	pitch_1 = 330.00000000000 
	red_1 = 58 
	green_1 = 62 
	blue_1 = 66 
	mod_factor_1 = 0.10000000149 
	fog_red = 150 
	fog_blue = 235 
	fog_green = 170 
	fog_alpha = 38 
	fog_dist = 700 
	num_m_heads = 8 
	num_m_torsos = 8 
	num_m_legs = 6 
	num_f_legs = 3 
} 
Level_VC = { 
	structure_name = Level_VC 
	load_script = Load_VC 
	name = "Vancouver" 
	loading_screen = "loadscrn_vancouver" 
	loading_time = 19 
	pre = "VC.pre" 
	scnpre = "VCscn.pre" 
	level = "VC" 
	sky = "VC_Sky" 
	qb = "levels\\VC\\VC.qb" 
	colpre = "VCcol.pre" 
	pedpre = "VCped.pre" 
	level_qb = "levels\\VC\\VC_scripts.qb" 
	level_sfx_qb = "levels\\VC\\VC_sfx.qb" 
	startup_script = VC_Startup 
	goals_script = VC_goals 
	setup_script = VC_setup 
	default_stats = 8 
	level_number = LevelNum_VC 
	extranetanimsscript = animload_Ped_Driver 
	ambient_red = 69 
	ambient_green = 72 
	ambient_blue = 79 
	ambient_mod_factor = 0.30000001192 
	heading_0 = 200.00000000000 
	pitch_0 = 330.00000000000 
	red_0 = 130 
	green_0 = 120 
	blue_0 = 97 
	mod_factor_0 = 1.39999997616 
	heading_1 = 40.00000000000 
	pitch_1 = 330.00000000000 
	red_1 = 58 
	green_1 = 62 
	blue_1 = 66 
	mod_factor_1 = 0.10000000149 
	fog_red = 80 
	fog_green = 90 
	fog_blue = 120 
	fog_alpha = 30 
	fog_dist = 300.00000000000 
	num_m_heads = 8 
	num_m_torsos = 8 
	num_m_legs = 6 
} 
Level_SJ = { 
	structure_name = Level_SJ 
	load_script = Load_SJ 
	name = "Slam City Jam" 
	loading_screen = "loadscrn_slam" 
	loading_time = 12 
	pre = "SJ.pre" 
	scnpre = "SJscn.pre" 
	level = "SJ" 
	qb = "levels\\SJ\\SJ.qb" 
	colpre = "SJcol.pre" 
	pedpre = "SJped.pre" 
	level_qb = "levels\\SJ\\SJ_scripts.qb" 
	level_sfx_qb = "levels\\SJ\\SJ_sfx.qb" 
	startup_script = SJ_Startup 
	goals_script = SJ_goals 
	setup_script = SJ_setup 
	default_stats = 8 
	level_number = LevelNum_SJ 
	ambient_red = 58 
	ambient_green = 57 
	ambient_blue = 59 
	ambient_mod_factor = 0.75000000000 
	heading_0 = 351 
	pitch_0 = 303 
	red_0 = 80 
	green_0 = 63 
	blue_0 = 59 
	mod_factor_0 = 1.25999999046 
	heading_1 = 314 
	pitch_1 = 272 
	red_1 = 47 
	green_1 = 50 
	blue_1 = 52 
	mod_factor_1 = 0.46000000834 
	fog_red = 27 
	fog_blue = 23 
	fog_green = 19 
	fog_alpha = 70 
	fog_dist = 705 
	num_m_heads = 8 
	num_m_torsos = 8 
	num_m_legs = 6 
} 
Level_RU = { 
	structure_name = Level_RU 
	load_script = Load_RU 
	name = "Moscow" 
	loading_screen = "loadscrn_moscow" 
	loading_time = 14 
	pre = "RU.pre" 
	scnpre = "RUscn.pre" 
	level = "RU" 
	sky = "RU_Sky" 
	qb = "levels\\RU\\RU.qb" 
	colpre = "RUcol.pre" 
	pedpre = "RUped.pre" 
	level_qb = "levels\\RU\\RU_scripts.qb" 
	level_sfx_qb = "levels\\RU\\RU_sfx.qb" 
	startup_script = RU_Startup 
	goals_script = RU_goals 
	setup_script = RU_setup 
	default_stats = 9 
	level_number = LevelNum_RU 
	ambient_red = 69 
	ambient_green = 72 
	ambient_blue = 79 
	ambient_mod_factor = 0.30000001192 
	heading_0 = 135.00000000000 
	pitch_0 = 330.00000000000 
	red_0 = 130 
	green_0 = 120 
	blue_0 = 97 
	mod_factor_0 = 1.39999997616 
	heading_1 = 300.00000000000 
	pitch_1 = 330.00000000000 
	red_1 = 58 
	green_1 = 62 
	blue_1 = 66 
	mod_factor_1 = 0.10000000149 
	fog_red = 140 
	fog_blue = 135 
	fog_green = 135 
	fog_alpha = 50 
	fog_dist = 500 
	num_m_heads = 8 
	num_m_torsos = 8 
	num_m_legs = 6 
	num_f_legs = 3 
} 
Level_AU = { 
	structure_name = Level_AU 
	load_script = Load_AU 
	name = "Australia" 
	loading_screen = "loadscrn_generic" 
	loading_time = 9.50000000000 
	pre = "AU.pre" 
	scnpre = "AUscn.pre" 
	level = "AU" 
	sky = "AU_Sky" 
	qb = "levels\\AU\\AU.qb" 
	colpre = "AUcol.pre" 
	pedpre = "AUped.pre" 
	level_qb = "levels\\AU\\AU_scripts.qb" 
	level_sfx_qb = "levels\\AU\\AU_sfx.qb" 
	startup_script = AU_Startup 
	goals_script = AU_goals 
	setup_script = AU_setup 
	default_stats = 9 
	level_number = LevelNum_AU 
	ambient_red = 69 
	ambient_green = 72 
	ambient_blue = 79 
	ambient_mod_factor = 0.30000001192 
	heading_0 = 120.00000000000 
	pitch_0 = -127.00000000000 
	red_0 = 130 
	green_0 = 120 
	blue_0 = 97 
	mod_factor_0 = 1.39999997616 
	heading_1 = -45.00000000000 
	pitch_1 = -110.00000000000 
	red_1 = 58 
	green_1 = 62 
	blue_1 = 66 
	mod_factor_1 = 0.10000000149 
	fog_red = 0 
	fog_blue = 0 
	fog_green = 0 
	fog_alpha = 0 
	fog_dist = 0 
	num_m_heads = 8 
	num_m_torsos = 8 
	num_m_legs = 6 
} 
Level_SE = { 
	structure_name = Level_SE 
	load_script = Load_SE 
	name = "Hotter Than Hell" 
	loading_screen = "loadscrn_secret" 
	loading_time = 18 
	pre = "SE.pre" 
	scnpre = "SEscn.pre" 
	level = "SE" 
	sky = "SE_Sky" 
	qb = "levels\\SE\\SE.qb" 
	colpre = "SEcol.pre" 
	pedpre = "SEped.pre" 
	level_qb = "levels\\SE\\SE_scripts.qb" 
	level_sfx_qb = "levels\\SE\\SE_sfx.qb" 
	startup_script = SE_Startup 
	goals_script = SE_goals 
	setup_script = SE_setup 
	default_stats = 10 
	level_number = LevelNum_SE 
	extranetanimsscript = animload_Ped_Baha 
	ambient_red = 44 
	ambient_green = 37 
	ambient_blue = 29 
	ambient_mod_factor = 0.30000001192 
	heading_0 = 50.00000000000 
	pitch_0 = 360.00000000000 
	red_0 = 130 
	green_0 = 120 
	blue_0 = 97 
	mod_factor_0 = 1.39999997616 
	heading_1 = 270.00000000000 
	pitch_1 = 330.00000000000 
	red_1 = 58 
	green_1 = 62 
	blue_1 = 66 
	mod_factor_1 = 0.10000000149 
	fog_red = 0 
	fog_blue = 0 
	fog_green = 0 
	fog_alpha = 0 
	fog_dist = 0 
	num_m_heads = 8 
	num_m_torsos = 8 
	num_m_legs = 6 
} 
Level_TestLevel = { 
	structure_name = Level_TestLevel 
	load_script = Load_TestLevel 
	name = "TestLevel" 
	loading_screen = "loadscrn_generic" 
	loading_time = 9.50000000000 
	pre = "TestLevel.pre" 
	scnpre = "TestLevelscn.pre" 
	level = "TestLevel" 
	sky = "Green_Sky" 
	qb = "levels\\TestLevel\\TestLevel.qb" 
	colpre = "TestLevelcol.pre" 
	pedpre = "TestLevelped.pre" 
	level_qb = "levels\\TestLevel\\TestLevel_scripts.qb" 
	startup_script = TestLevel_Startup 
	goals_script = TestLevel_goals 
	setup_script = TestLevel_setup 
	default_stats = 10 
	level_number = LevelNum_Default 
	ambient_red = 69 
	ambient_green = 72 
	ambient_blue = 79 
	ambient_mod_factor = 0.30000001192 
	heading_0 = 120.00000000000 
	pitch_0 = -127.00000000000 
	red_0 = 130 
	green_0 = 120 
	blue_0 = 97 
	mod_factor_0 = 1.39999997616 
	heading_1 = -45.00000000000 
	pitch_1 = -110.00000000000 
	red_1 = 58 
	green_1 = 62 
	blue_1 = 66 
	mod_factor_1 = 0.10000000149 
	fog_red = 0 
	fog_blue = 0 
	fog_green = 0 
	fog_alpha = 0 
	fog_dist = 0 
	num_m_heads = 10 
	num_m_torsos = 10 
	num_m_legs = 8 
} 
Level_SC = { 
	structure_name = Level_SC 
	load_script = Load_SC 
	name = "Old School" 
	loading_screen = "loadscrn_generic" 
	loading_time = 9.50000000000 
	loading_time_xbox = 3 
	pre = "SC.pre" 
	scnpre = "SCscn.pre" 
	level = "SC" 
	sky = "SC_Sky" 
	qb = "levels\\SC\\SC.qb" 
	colpre = "SCcol.pre" 
	pedpre = "SCped.pre" 
	level_qb = "levels\\SC\\SC_scripts.qb" 
	startup_script = SC_Startup 
	goals_script = SC_goals 
	setup_script = SC_setup 
	default_stats = 5 
	level_number = LevelNum_SC 
	ambient_red = 89 
	ambient_green = 79 
	ambient_blue = 79 
	ambient_mod_factor = 0.20000000298 
	heading_0 = 240 
	pitch_0 = 190 
	red_0 = 255 
	green_0 = 255 
	blue_0 = 255 
	mod_factor_0 = 1.39999997616 
	heading_1 = 200 
	pitch_1 = 190 
	red_1 = 108 
	green_1 = 78 
	blue_1 = 78 
	mod_factor_1 = 0.10000000149 
	fog_red = 0 
	fog_green = 0 
	fog_blue = 0 
	fog_alpha = 0 
	fog_dist = 0 
	num_m_heads = 4 
	num_m_torsos = 4 
	num_m_legs = 4 
} 
Level_DJ = { 
	structure_name = Level_DJ 
	load_script = Load_DJ 
	name = "Old Downhill Jam" 
	loading_screen = "loadscrn_generic" 
	loading_time = 9.50000000000 
	pre = "DJ.pre" 
	scnpre = "DJscn.pre" 
	level = "DJ" 
	sky = "DJ_Sky" 
	qb = "levels\\DJ\\DJ.qb" 
	colpre = "DJcol.pre" 
	pedpre = "DJped.pre" 
	level_qb = "levels\\DJ\\DJ_scripts.qb" 
	startup_script = DJ_Startup 
	goals_script = DJ_goals 
	setup_script = DJ_setup 
	default_stats = 5 
	level_number = LevelNum_DJ 
	ambient_red = 89 
	ambient_green = 79 
	ambient_blue = 79 
	ambient_mod_factor = 0.20000000298 
	heading_0 = 240 
	pitch_0 = 190 
	red_0 = 255 
	green_0 = 255 
	blue_0 = 255 
	mod_factor_0 = 1.39999997616 
	heading_1 = 200 
	pitch_1 = 190 
	red_1 = 108 
	green_1 = 78 
	blue_1 = 78 
	mod_factor_1 = 0.10000000149 
	fog_red = 0 
	fog_green = 0 
	fog_blue = 0 
	fog_alpha = 0 
	fog_dist = 0 
	num_m_heads = 4 
	num_m_torsos = 4 
	num_m_legs = 4 
} 
Level_PH = { 
	structure_name = Level_PH 
	load_script = Load_PH 
	name = "Old Philly" 
	loading_screen = "loadscrn_generic" 
	loading_time = 9.50000000000 
	pre = "PH.pre" 
	scnpre = "PHscn.pre" 
	level = "PH" 
	sky = "PH_Sky" 
	qb = "levels\\PH\\PH.qb" 
	colpre = "PHcol.pre" 
	pedpre = "PHped.pre" 
	level_qb = "levels\\PH\\PH_scripts.qb" 
	startup_script = PH_Startup 
	goals_script = PH_goals 
	setup_script = PH_setup 
	default_stats = 5 
	level_number = LevelNum_PH 
	ambient_red = 89 
	ambient_green = 79 
	ambient_blue = 79 
	ambient_mod_factor = 0.20000000298 
	heading_0 = 240 
	pitch_0 = 190 
	red_0 = 255 
	green_0 = 255 
	blue_0 = 255 
	mod_factor_0 = 1.39999997616 
	heading_1 = 200 
	pitch_1 = 190 
	red_1 = 108 
	green_1 = 78 
	blue_1 = 78 
	mod_factor_1 = 0.10000000149 
	fog_red = 0 
	fog_green = 0 
	fog_blue = 0 
	fog_alpha = 0 
	fog_dist = 0 
	num_m_heads = 4 
	num_m_torsos = 4 
	num_m_legs = 4 
} 
Level_VN = { 
	structure_name = Level_VN 
	load_script = Load_VN 
	name = "Old Venice" 
	loading_screen = "loadscrn_THPS2_ven" 
	loading_time = 7 
	pre = "VN.pre" 
	scnpre = "VNscn.pre" 
	level = "VN" 
	sky = "vn_Sky" 
	qb = "levels\\VN\\VN.qb" 
	colpre = "VNcol.pre" 
	pedpre = "VNped.pre" 
	level_qb = "levels\\VN\\VN_scripts.qb" 
	startup_script = VN_Startup 
	goals_script = VN_goals 
	setup_script = VN_setup 
	default_stats = 5 
	level_number = LevelNum_VN 
	ambient_red = 89 
	ambient_green = 79 
	ambient_blue = 79 
	ambient_mod_factor = 0.20000000298 
	heading_0 = 240 
	pitch_0 = 190 
	red_0 = 255 
	green_0 = 255 
	blue_0 = 255 
	mod_factor_0 = 1.39999997616 
	heading_1 = 200 
	pitch_1 = 190 
	red_1 = 108 
	green_1 = 78 
	blue_1 = 78 
	mod_factor_1 = 0.10000000149 
	fog_red = 0 
	fog_green = 0 
	fog_blue = 0 
	fog_alpha = 0 
	fog_dist = 0 
	num_m_heads = 4 
	num_m_torsos = 4 
	num_m_legs = 4 
} 
Level_HN = { 
	structure_name = Level_HN 
	load_script = Load_hn 
	name = "Old Hangar" 
	loading_screen = "loadscrn_THPS2_hang" 
	loading_time = 5.50000000000 
	loading_time_xbox = 3.50000000000 
	pre = "HN.pre" 
	scnpre = "HNscn.pre" 
	level = "HN" 
	sky = "HN_Sky" 
	qb = "levels\\HN\\HN.qb" 
	colpre = "HNcol.pre" 
	pedpre = "HNped.pre" 
	level_qb = "levels\\HN\\HN_scripts.qb" 
	startup_script = HN_Startup 
	goals_script = HN_goals 
	setup_script = HN_setup 
	default_stats = 5 
	level_number = LevelNum_HN 
	ambient_red = 89 
	ambient_green = 79 
	ambient_blue = 79 
	ambient_mod_factor = 0.20000000298 
	heading_0 = 240 
	pitch_0 = 190 
	red_0 = 255 
	green_0 = 255 
	blue_0 = 255 
	mod_factor_0 = 1.39999997616 
	heading_1 = 200 
	pitch_1 = 190 
	red_1 = 108 
	green_1 = 78 
	blue_1 = 78 
	mod_factor_1 = 0.10000000149 
	fog_red = 0 
	fog_green = 0 
	fog_blue = 0 
	fog_alpha = 0 
	fog_dist = 0 
	num_m_heads = 4 
	num_m_torsos = 4 
	num_m_legs = 4 
} 
Level_SC2 = { 
	structure_name = Level_SC2 
	load_script = Load_sc2 
	name = "School II" 
	loading_screen = "loadscrn_THPS2_sch" 
	loading_time = 8.50000000000 
	pre = "SC2.pre" 
	scnpre = "SC2scn.pre" 
	level = "SC2" 
	sky = "sc2_Sky" 
	qb = "levels\\SC2\\SC2.qb" 
	colpre = "SC2col.pre" 
	pedpre = "SC2ped.pre" 
	level_qb = "levels\\SC2\\SC2_scripts.qb" 
	startup_script = SC2_Startup 
	goals_script = SC2_goals 
	setup_script = SC2_setup 
	default_stats = 5 
	level_number = LevelNum_SC2 
	ambient_red = 72 
	ambient_green = 72 
	ambient_blue = 72 
	ambient_mod_factor = 0.20000000298 
	heading_0 = -30 
	pitch_0 = -60 
	red_0 = 110 
	green_0 = 110 
	blue_0 = 105 
	mod_factor_0 = 0.89999997616 
	heading_1 = 200 
	pitch_1 = 33 
	red_1 = 23 
	green_1 = 24 
	blue_1 = 30 
	mod_factor_1 = 0.89999997616 
	fog_red = 0 
	fog_green = 0 
	fog_blue = 0 
	fog_alpha = 0 
	fog_dist = 0 
	num_m_heads = 4 
	num_m_torsos = 4 
	num_m_legs = 4 
} 
Level_WWW = { 
	structure_name = Level_WWW 
	load_script = Load_WWW 
	name = "West Side" 
	loading_screen = "loadscrn_generic" 
	loading_time = 9.50000000000 
	pre = "WWW.pre" 
	scnpre = "WWWscn.pre" 
	level = "WWW" 
	sky = "WWW_Sky" 
	qb = "levels\\WWW\\WWW.qb" 
	colpre = "WWWcol.pre" 
	pedpre = "WWWped.pre" 
	level_qb = "levels\\WWW\\WWW_scripts.qb" 
	level_sfx_qb = "levels\\WWW\\WWW_sfx.qb" 
	startup_script = WWW_Startup 
	goals_script = WWW_goals 
	setup_script = WWW_setup 
	default_stats = 5 
	level_number = LevelNum_WWW 
	ambient_red = 89 
	ambient_green = 79 
	ambient_blue = 79 
	ambient_mod_factor = 0.20000000298 
	heading_0 = 240 
	pitch_0 = 190 
	red_0 = 255 
	green_0 = 255 
	blue_0 = 255 
	mod_factor_0 = 1.39999997616 
	heading_1 = 200 
	pitch_1 = 190 
	red_1 = 108 
	green_1 = 78 
	blue_1 = 78 
	mod_factor_1 = 0.10000000149 
	fog_red = 0 
	fog_green = 0 
	fog_blue = 0 
	fog_alpha = 0 
	fog_dist = 0 
	num_m_heads = 4 
	num_m_torsos = 4 
	num_m_legs = 4 
} 
Level_Test = { 
	structure_name = Level_Test 
	load_script = Load_Test 
	name = "Manhattan" 
	loading_screen = "loadscrn_generic" 
	loading_time = 9.50000000000 
	pre = "Test.pre" 
	scnpre = "Testscn.pre" 
	level = "Test" 
	sky = "NY_Sky" 
	qb = "levels\\Test\\Test.qb" 
	colpre = "Testcol.pre" 
	pedpre = "Testped.pre" 
	level_qb = "levels\\NY\\NY_scripts.qb" 
	startup_script = NY_Startup 
	goals_script = NY_goals 
	setup_script = NY_setup 
	default_stats = 6 
	level_number = LevelNum_NY 
	ambient_red = 69 
	ambient_green = 72 
	ambient_blue = 79 
	ambient_mod_factor = 0.30000001192 
	heading_0 = 120.00000000000 
	pitch_0 = -127.00000000000 
	red_0 = 130 
	green_0 = 120 
	blue_0 = 97 
	mod_factor_0 = 1.39999997616 
	heading_1 = -45.00000000000 
	pitch_1 = -110.00000000000 
	red_1 = 58 
	green_1 = 62 
	blue_1 = 66 
	mod_factor_1 = 0.10000000149 
	fog_red = 0 
	fog_blue = 0 
	fog_green = 0 
	fog_alpha = 0 
	fog_dist = 0 
	num_m_heads = 4 
	num_m_torsos = 4 
	num_m_legs = 4 
} 
SCRIPT Load_SkateShop 
	load_level level_Mainmenu 
ENDSCRIPT

level_Mainmenu = { 
	structure_name = level_Mainmenu 
	load_script = Load_SkateShop 
	name = "Skateshop" 
	loading_screen = "loadscrn_generic" 
	loading_time = 7.50000000000 
	loading_time_xbox = 3.50000000000 
	level_name = "skateshop" 
	pre = "mainmenu.pre" 
	scnpre = "mainmenuscn.pre" 
	level = "mainmenu" 
	qb = "levels\\mainmenu\\mainmenu.qb" 
	colpre = "mainmenucol.pre" 
	level_qb = "levels\\mainmenu\\mainmenu_scripts.qb" 
	startup_script = mainmenu_startup 
	default_stats = 8 
	level_number = LevelNum_Skateshop 
	frontend_level = 1 
	ambient_red = 66 
	ambient_green = 67 
	ambient_blue = 68 
	ambient_mod_factor = 0.00000000000 
	heading_0 = -90.00000000000 
	pitch_0 = -10.00000000000 
	red_0 = 0 
	green_0 = 0 
	blue_0 = 0 
	mod_factor_0 = 0.00000000000 
	heading_1 = -120.00000000000 
	pitch_1 = 120.00000000000 
	red_1 = 0 
	green_1 = 0 
	blue_1 = 0 
	mod_factor_1 = 0.00000000000 
} 
SCRIPT Load_CAS 
	load_level level_cas 
ENDSCRIPT

level_cas = { 
	structure_name = level_cas 
	load_script = Load_CAS 
	name = "CAS" 
	loading_screen = "loadscrn_mainmenu" 
	loading_time = 14.50000000000 
	loading_time_xbox = 4.50000000000 
	pre = "cas_bedroom.pre" 
	scnpre = "cas_bedroomscn.pre" 
	level = "cas_bedroom" 
	sky = "CAS_bedroom_Sky" 
	qb = "levels\\cas_bedroom\\cas_bedroom.qb" 
	colpre = "cas_bedroomcol.pre" 
	level_qb = "levels\\cas_bedroom\\cas_bedroom_scripts.qb" 
	startup_script = cas_bedroom_startup 
	default_stats = 8 
	level_number = LevelNum_CAS 
	frontend_level = 1 
	ambient_red = 66 
	ambient_green = 67 
	ambient_blue = 68 
	ambient_mod_factor = 0.00000000000 
	heading_0 = 220.00000000000 
	pitch_0 = 320.00000000000 
	red_0 = 45 
	green_0 = 35 
	blue_0 = 32 
	mod_factor_0 = 0.00000000000 
	heading_1 = 10.00000000000 
	pitch_1 = 320.00000000000 
	red_1 = 32 
	green_1 = 34 
	blue_1 = 26 
	mod_factor_1 = 0.00000000000 
} 
SCRIPT load_boardshop 
	load_level level_boardshop 
ENDSCRIPT

level_boardshop = { 
	structure_name = level_boardshop 
	load_script = load_boardshop 
	name = "Boardshop" 
	loading_screen = "loadscrn_boardshop" 
	loading_time = 7.50000000000 
	loading_time_xbox = 3 
	pre = "nj_skateshop.pre" 
	scnpre = "nj_skateshopscn.pre" 
	level = "nj_skateshop" 
	qb = "levels\\nj_skateshop\\nj_skateshop.qb" 
	colpre = "nj_skateshopcol.pre" 
	level_qb = "levels\\nj_skateshop\\nj_skateshop_scripts.qb" 
	startup_script = boardshop_startup 
	level_number = LevelNum_Boardshop 
	frontend_level = 1 
	ambient_red = 66 
	ambient_green = 67 
	ambient_blue = 68 
	ambient_mod_factor = 0.00000000000 
	heading_0 = -220.00000000000 
	pitch_0 = -40.00000000000 
	red_0 = 100 
	green_0 = 97 
	blue_0 = 92 
	mod_factor_0 = 0.00000000000 
	heading_1 = -180.00000000000 
	pitch_1 = 100.00000000000 
	red_1 = 37 
	green_1 = 34 
	blue_1 = 26 
	mod_factor_1 = 0.00000000000 
} 
SCRIPT GenerateLevelStructureNameFromTheme 
	IF ( <theme> > 0 ) 
		FormatText ChecksumName = structure_name "Level_sk5ed%d" d = ( <theme> + 1 ) 
	ELSE 
		structure_name = Level_Sk5Ed 
	ENDIF 
	RETURN structure_name = <structure_name> 
ENDSCRIPT

SCRIPT Load_Sk5Ed 
	GetEditorTheme 
	load_parked_textures_to_main_memory 
	GenerateLevelStructureNameFromTheme theme = <theme> 
	IF isXbox 
		load_level <structure_name> loading_screen = "loadscrn_editor_x" 
	ENDIF 
	IF isNGC 
		load_level <structure_name> loading_screen = "loadscrn_editor_ngc" 
	ENDIF 
	IF IsPS2 
		load_level <structure_name> loading_screen = "loadscrn_editor" 
	ENDIF 
ENDSCRIPT

SCRIPT Load_Sk5Ed_gameplay 
	GetEditorTheme 
	IF ( <theme> > 0 ) 
		FormatText ChecksumName = structure_name "Level_sk5ed%d" d = ( <theme> + 1 ) 
	ELSE 
		structure_name = Level_Sk5Ed 
	ENDIF 
	load_level <structure_name> startup_script = Sk5Ed_Startup_gameplay loading_screen = "loadscrn_created" 
ENDSCRIPT

Level_sk5ed_defaults = 
{ 
	park_editor 
	load_script = Load_Sk5Ed 
	name = "Created Park" 
	loading_screen = "loadscrn_editor_play" 
	loading_time = 11 
	loading_time_xbox = 4.50000000000 
	startup_script = Sk5Ed_Startup 
	goals_script = Sk5Ed_goals 
	default_stats = 10 
	level_number = LevelNum_Sk5ed 
	pre = "sk5ed.pre" 
	level = "sk5ed" 
	level_name = "sk5ed" 
	colpre = "sk5edcol.pre" 
	pedpre = "sk5edped.pre" 
	level_qb = "levels\\sk5ed\\sk5ed_scripts.qb" 
	qb = "levels\\sk5ed\\sk5ed.qb" 
	extranetanimsscript = animload_Ped_Baha 
	ambient_red = 72 
	ambient_green = 72 
	ambient_blue = 72 
	ambient_mod_factor = 0.50000000000 
	heading_0 = 90.00000000000 
	pitch_0 = -60.00000000000 
	red_0 = 75 
	green_0 = 75 
	blue_0 = 75 
	mod_factor_0 = 0.69999998808 
	heading_1 = 0.00000000000 
	pitch_1 = -90.00000000000 
	red_1 = 0 
	green_1 = 0 
	blue_1 = 0 
	mod_factor_1 = 1.00000000000 
	fog_red = 0 
	fog_green = 0 
	fog_blue = 0 
	fog_alpha = 0 
	fog_dist = 0 
} 
Level_Sk5Ed = { 
	Level_sk5ed_defaults 
	structure_name = Level_Sk5Ed 
	loading_time = 8 
	loading_time_xbox = 4.50000000000 
	scnpre = "sk5edscn.pre" 
	sky = "sk5ed_Sky" 
	outer_shell = "sk5ed_shell" 
	theme_name = "Suburbia" 
} 
Level_Sk5Ed2 = { 
	Level_sk5ed_defaults 
	structure_name = Level_Sk5Ed2 
	loading_time = 8 
	scnpre = "sk5ed2scn.pre" 
	sky = "sk5ed2_Sky" 
	outer_shell = "sk5ed2_shell" 
	theme_name = "City Rooftop" 
} 
Level_Sk5Ed3 = { 
	Level_sk5ed_defaults 
	structure_name = Level_Sk5Ed3 
	loading_time = 8 
	scnpre = "sk5ed3scn.pre" 
	sky = "sk5ed3_Sky" 
	outer_shell = "sk5ed3_shell" 
	theme_name = "Lost Island" 
} 
Level_Sk5Ed4 = { 
	Level_sk5ed_defaults 
	structure_name = Level_Sk5Ed4 
	loading_time = 8 
	scnpre = "sk5ed4scn.pre" 
	sky = "sk5ed4_Sky" 
	outer_shell = "sk5ed4_shell" 
	theme_name = "Warehouse" 
} 
Level_Sk5Ed5 = { 
	Level_sk5ed_defaults 
	structure_name = Level_Sk5Ed5 
	loading_time = 11 
	scnpre = "sk5ed5scn.pre" 
	sky = "sk5ed5_Sky" 
	outer_shell = "sk5ed5_shell" 
	theme_name = "Prison Yard" 
} 

