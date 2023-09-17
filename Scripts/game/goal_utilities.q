
generic_pro_name = "peds/PedPros/PedPro_Neversoft/PedPro_Neversoft.skin" 
generic_pro_first_name = "Neversoft" 
generic_pro_full_name = "Neversoft Skater" 
goal_want_to_save_volume = 0 
goal_bind_retry_to_select = 0 
max_number_of_special_trickslots = 11 
SCRIPT goal_init 
	GoalManager_GetGoalParams name = <goal_id> 
	GoalManager_InitGoalTrigger name = <goal_id> 
	IF GotParam init_geo_prefix 
		create prefix = <init_geo_prefix> 
	ELSE 
		IF GotParam init_geo_prefixes 
			GetArraySize <init_geo_prefixes> 
			<index> = 0 
			BEGIN 
				create prefix = ( <init_geo_prefixes> [ <index> ] ) 
				<index> = ( <index> + 1 ) 
			REPEAT <array_size> 
		ENDIF 
	ENDIF 
	IF GotParam init_script 
		<init_script> <init_script_params> 
	ENDIF 
ENDSCRIPT

SCRIPT goal_check_chapter_flags 
	GetArraySize CHAPTER_GOALS 
	<chapter_goals_size> = <array_size> 
	GetArraySize CHAPTER_NUM_GOALS_TO_COMPLETE 
	IF NOT ( <chapter_goals_size> = <array_size> ) 
		script_assert "chapter_goals and chapter_num_goals_to_complete are not the same size!" 
	ENDIF 
	<chapter_goals_index> = 0 
	BEGIN 
		<chapter_array> = ( CHAPTER_GOALS [ <chapter_goals_index> ] ) 
		GetArraySize <chapter_array> 
		<chapter_array_size> = <array_size> 
		<chapter_array_index> = 0 
		BEGIN 
			<stage_array> = ( <chapter_array> [ <chapter_array_index> ] ) 
			GetArraySize <stage_array> 
			<stage_array_size> = <array_size> 
			<stage_array_index> = 0 
			<stage_total> = 0 
			<stage_total_target> = ( ( CHAPTER_NUM_GOALS_TO_COMPLETE [ <chapter_goals_index> ] ) [ <chapter_array_index> ] ) 
			BEGIN 
				<temp_struct> = ( <stage_array> [ <stage_array_index> ] ) 
				IF StructureContains structure = <temp_struct> goal_id 
					IF GoalManager_GoalExists name = ( <temp_struct> . goal_id ) 
						IF GoalManager_HasWonGoal name = ( <temp_struct> . goal_id ) 
							goal_check_chapter_flags_goal_beaten goal_id = ( <temp_struct> . goal_id ) 
							<stage_total> = ( <stage_total> + 1 ) 
						ENDIF 
					ENDIF 
				ENDIF 
				<stage_array_index> = ( <stage_array_index> + 1 ) 
			REPEAT <stage_array_size> 
			IF ( <stage_total> > ( <stage_total_target> - 1 ) ) 
				goal_check_chapter_flags_stage_beaten { 
					stage_array = <stage_array> 
					completion_struct = ( ( CHAPTER_COMPLETION_SCRIPTS [ <chapter_goals_index> ] ) [ <chapter_array_index> ] ) 
				} 
			ENDIF 
			<chapter_array_index> = ( <chapter_array_index> + 1 ) 
		REPEAT <chapter_array_size> 
		<chapter_goals_index> = ( <chapter_goals_index> + 1 ) 
	REPEAT <chapter_goals_size> 
ENDSCRIPT

SCRIPT goal_check_chapter_flags_goal_beaten 
	GoalManager_GetGoalParams name = <goal_id> 
	IF GotParam some_shit 
	ENDIF 
ENDSCRIPT

SCRIPT goal_check_chapter_flags_stage_beaten 
	GetArraySize <stage_array> 
	<index> = 0 
	BEGIN 
		<temp_struct> = ( <stage_array> [ <index> ] ) 
		IF StructureContains structure = <temp_struct> goal_id 
			IF GoalManager_GoalExists name = ( <temp_struct> . goal_id ) 
				GoalManager_UninitializeGoal name = ( <temp_struct> . goal_id ) affect_tree 
			ENDIF 
		ENDIF 
		<index> = ( <index> + 1 ) 
	REPEAT <array_size> 
	IF GotParam completion_struct 
		IF StructureContains structure = <completion_struct> script_name 
			<script_name> = ( <completion_struct> . script_name ) 
		ENDIF 
		IF StructureContains structure = <completion_struct> params 
			<script_params> = ( <completion_struct> . params ) 
		ENDIF 
		<script_name> <script_params> 
	ENDIF 
ENDSCRIPT

cur_tod_cur_action = set_tod_day 
SCRIPT goal_start 
	GetCurrentLevel 
	IF ChecksumEquals a = <level> b = Load_Sk5Ed 
		GoalManager_EditGoal name = <goal_id> params = { testing_goal } 
	ENDIF 
	ResetScore 
	Skater : Vibrate Off 
	KillAllTextureSplats 
	destroy_goal_panel_messages 
	KillSpawnedScript name = goal_wait_and_show_key_combo_text 
	KillSpawnedScript name = SK3_Killskater_Finish use_proper_version 
	GoalManager_GetGoalParams name = <goal_id> 
	IF NOT GotParam quick_start 
		kill_start_key_binding 
	ENDIF 
	IF NOT IsAlive name = <trigger_obj_id> 
		GoalManager_EditGoal name = <goal_id> params = { force_create_trigger = 1 } 
		GoalManager_InitializeGoal name = <goal_id> 
		GoalManager_EditGoal name = <goal_id> params = { force_create_trigger = 0 } 
		GoalManager_GetGoalParams name = <goal_id> 
	ENDIF 
	IF InNetGame 
		GoalManager_AnnounceGoalStarted name = <goal_id> 
	ENDIF 
	<trigger_obj_id> : Obj_ClearExceptions 
	IF GotParam custom_score_record 
		GoalManager_EditGoal name = <goal_id> params = { custom_score_record = 0 } 
	ENDIF 
	IF ObjectExists id = goal_start_dialog 
		speech_box_exit anchor_id = goal_start_dialog 
	ENDIF 
	IF ObjectExists id = goal_retry_anchor 
		DestroyScreenElement id = goal_retry_anchor 
	ENDIF 
	FormatText ChecksumName = arrow_id "%s_ped_arrow" s = <goal_name> 
	IF ScreenElementExists id = <arrow_id> 
		DestroyScreenElement id = <arrow_id> 
	ENDIF 
	KillSpawnedScript name = goal_init_after_end_of_run 
	GetSkaterId 
	KillSkaterCamAnim skaterId = <ObjId> all 
	GoalManager_HideGoalPoints 
	GoalManager_GetGoalParams name = <goal_id> 
	IF GameModeEquals is_career 
		goal_get_chapter_stage_from_id id = <goal_id> 
		IF GotParam stage 
			change cur_tod_cur_action = ( ( STAGE_TOD_SETTINGS [ <chapter> ] ) [ <stage> ] ) 
		ENDIF 
	ENDIF 
	IF GotParam geo_prefix 
		goal_create_geo_prefix geo_prefix = <geo_prefix> 
	ELSE 
		IF GotParam geo_prefixes 
			GetArraySize <geo_prefixes> 
			<index> = 0 
			BEGIN 
				goal_create_geo_prefix geo_prefix = ( <geo_prefixes> [ <index> ] ) 
				<index> = ( <index> + 1 ) 
			REPEAT <array_size> 
		ENDIF 
	ENDIF 
	Skater : RunStarted 
	IF GotParam quick_start 
		goal_initialize_skater <...> 
		DeBounce x time = 0.30000001192 
	ELSE 
		IF GotParam intro_node 
			ResetSkaters Node_Name = <intro_node> 
		ELSE 
			ResetSkaters Node_Name = <restart_node> 
		ENDIF 
	ENDIF 
	IF GotParam goal_intro_script 
		<goal_intro_script> <goal_intro_script_params> 
	ENDIF 
	GoalManager_GetGoalParams name = <goal_id> 
	IF NOT InNetGame 
		goal_create_proset_geom <...> 
	ENDIF 
	IF GotParam edited_goal 
		IF GotParam control_type 
			IF NOT ( ( <control_type> = Skate ) | ( <control_type> = Walk ) | ( <control_type> = WalkOnly ) ) 
				GoalManager_GetLevelPrefix 
				FormatText ChecksumName = ReadyLevelScript "%l_KillVehicles" l = <level_prefix> 
				IF ScriptExists <ReadyLevelScript> 
					<ReadyLevelScript> 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
	SetScoreAccumulation 1 
	SetScoreDegradation 1 
	IF ( Inside_Light_Rain = 1 ) 
		IF IsSoundPlaying TestLight01 
			SetSoundParams TestLight01 vol = LightRainVolume 
		ENDIF 
		change Paused_Light_Rain = 0 
		change Inside_Light_Rain = 0 
	ENDIF 
	IF ( Inside_Heavy_Rain = 1 ) 
		IF IsSoundPlaying TestLight02 
			SetSoundParams TestLight02 vol = LightRainVolume 
		ENDIF 
		IF IsSoundPlaying TestMedium02 
			SetSoundParams TestMedium02 vol = MediumRainVolume 
		ENDIF 
		change Paused_Heavy_Rain = 0 
		change Inside_Heavy_Rain = 0 
	ENDIF 
	IF GotParam trigger_prefix 
		create prefix = <trigger_prefix> 
	ENDIF 
	IF GotParam quick_start 
		IF GotParam hide_goal_pro 
			<trigger_obj_id> : Obj_Invisible 
		ENDIF 
		IF GotParam use_hud_counter 
			goal_create_counter goal_id = <goal_id> hud_counter_caption = <hud_counter_caption> 
		ENDIF 
		IF NOT GotParam dont_show_goal_text 
			create_panel_block id = current_goal text = <goal_text> style = panel_message_goal 
			IF GotParam key_combo_text 
				SpawnScript goal_wait_and_show_key_combo_text params = { text = <key_combo_text> } 
			ENDIF 
		ENDIF 
		IF GotParam goal_start_script 
			<goal_start_script> <goal_start_script_params> 
		ENDIF 
		IF NOT GoalManager_HasWonGoal name = <goal_id> 
			SpawnScript goal_show_tips params = { goal_id = <goal_id> } 
		ENDIF 
		goal_pro_stop_anim_scripts <...> 
		IF NOT GotParam trigger_wait_script 
			<trigger_wait_script> = GenericProWaiting 
		ENDIF 
		<trigger_obj_id> : Obj_SpawnScript <trigger_wait_script> params = { type = "midgoal" goal_id = <goal_id> pro = <pro> } 
		FireEvent type = goal_cam_anim_post_start_done 
	ELSE 
		IF GameModeEquals is_career 
			goal_get_chapter_stage_from_id id = <goal_id> 
			IF NOT GotParam always_initialize_goal 
				IF GotParam stage 
					GoalManager_GetCurrentChapterAndStage 
					tod_cur_action = ( ( STAGE_TOD_SETTINGS [ <currentChapter> ] ) [ <currentStage> ] ) 
					tod_req_action = ( ( STAGE_TOD_SETTINGS [ <chapter> ] ) [ <stage> ] ) 
					IF NOT ( <tod_cur_action> = <tod_req_action> ) 
						script_change_tod tod_action = <tod_req_action> 
						change cur_tod_cur_action = <tod_req_action> 
					ENDIF 
				ELSE 
					GoalManager_GetCurrentChapterAndStage 
					tod_cur_action = cur_tod_cur_action 
					tod_req_action = ( ( STAGE_TOD_SETTINGS [ <currentChapter> ] ) [ <currentStage> ] ) 
					IF NOT ( <tod_cur_action> = <tod_req_action> ) 
						script_change_tod tod_action = <tod_cur_action> 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
		goal_pro_stop_anim_scripts <...> 
		IF GotParam goal_start_trigger_script 
			<trigger_obj_id> : Obj_SpawnScript <goal_start_trigger_script> params = { goal_id = <goal_id> type = "talking" pro = <pro> } 
		ELSE 
			<trigger_obj_id> : Obj_SpawnScript GenericProTalking params = { goal_id = <goal_id> type = "talking" pro = <pro> } 
		ENDIF 
		IF NOT GotParam trigger_wait_script 
			<trigger_wait_script> = GenericProWaiting 
		ENDIF 
		IF GotParam goal_start_movie_script 
			<goal_start_movie_script> <goal_start_movie_script_params> 
		ENDIF 
		IF GotParam no_play_hold 
			<no_play_hold> = no_play_hold 
		ENDIF 
		SpawnScript goal_cam_anim_play id = new_goal_cam_anim params = { goal_id = <goal_id> 
			next_trigger_script = <trigger_wait_script> 
			type = "midgoal" 
			<no_play_hold> 
			dont_unpause = <dont_unpause> 
		} 
	ENDIF 
	IF GotParam kill_radius 
		<trigger_obj_id> : Obj_SetOuterRadius <kill_radius> 
		<trigger_obj_id> : Obj_SetException ex = SkaterOutOfRadius scr = goal_crossed_kill_radius params = { goal_id = <goal_id> } 
	ENDIF 
	RunScriptOnScreenElement id = the_time clock_morph 
ENDSCRIPT

SCRIPT goal_get_chapter_stage_from_id 
	chapter = 0 
	GetArraySize CHAPTER_GOALS 
	num_chapters = <array_size> 
	BEGIN 
		GetArraySize CHAPTER_GOALS index1 = <chapter> 
		num_stages = <array_size> 
		stage = 0 
		BEGIN 
			GetArraySize CHAPTER_GOALS index1 = <chapter> index2 = <stage> 
			index = 0 
			BEGIN 
				Get3DArrayData ArrayName = CHAPTER_GOALS index1 = <chapter> index2 = <stage> index3 = <index> 
				goal_id = ( <val> . goal_id ) 
				IF GotParam goal_id 
					IF ( <goal_id> = <id> ) 
						RETURN stage = <stage> chapter = <chapter> 
					ENDIF 
				ENDIF 
				index = ( <index> + 1 ) 
			REPEAT <array_size> 
			stage = ( <stage> + 1 ) 
		REPEAT <num_stages> 
		chapter = ( <chapter> + 1 ) 
	REPEAT <num_chapters> 
ENDSCRIPT

SCRIPT goal_create_geo_prefix 
	create prefix = <geo_prefix> 
	FormatText TextName = geo_trigger_prefix "TRG_%p" p = <geo_prefix> 
	create prefix = <geo_trigger_prefix> 
	GoalManager_GetProsetNotPrefix <geo_prefix> 
	kill prefix = <proset_not_prefix> 
	FormatText TextName = geo_not_trigger_prefix "TRG_%p" p = <proset_not_prefix> 
	kill prefix = <geo_not_trigger_prefix> 
ENDSCRIPT

SCRIPT goal_kill_geo_prefix 
	kill prefix = <geo_prefix> 
	FormatText TextName = geo_trigger_prefix "TRG_%p" p = <geo_prefix> 
	kill prefix = <geo_trigger_prefix> 
	GoalManager_GetProsetNotPrefix <geo_prefix> 
	create prefix = <proset_not_prefix> 
	FormatText TextName = geo_not_trigger_prefix "TRG_%p" p = <proset_not_prefix> 
	create prefix = <geo_not_trigger_prefix> 
ENDSCRIPT

SCRIPT goal_create_proset_geom 
	IF GotParam proset_prefix 
		FormatText ChecksumName = proset_flag "FLAG_%pGEO_ON" p = <proset_prefix> 
		SetFlag flag = <proset_flag> 
		create prefix = <proset_prefix> 
		FormatText TextName = proset_trigger_prefix "TRG_%p" p = <proset_prefix> 
		create prefix = <proset_trigger_prefix> 
		GoalManager_GetProsetNotPrefix <proset_prefix> 
		kill prefix = <proset_not_prefix> 
		FormatText TextName = proset_not_trigger_prefix "TRG_%p" p = <proset_not_prefix> 
		kill prefix = <proset_not_trigger_prefix> 
	ENDIF 
ENDSCRIPT

SCRIPT goal_kill_proset_geom 
	IF GotParam proset_prefix 
		FormatText ChecksumName = proset_flag "FLAG_%pGEO_ON" p = <proset_prefix> 
		UnSetFlag flag = <proset_flag> 
		kill prefix = <proset_prefix> 
		FormatText TextName = proset_trigger_prefix "TRG_%p" p = <proset_prefix> 
		kill prefix = <proset_trigger_prefix> 
		GoalManager_GetProsetNotPrefix <proset_prefix> 
		create prefix = <proset_not_prefix> 
		FormatText TextName = proset_not_trigger_prefix "TRG_%p" p = <proset_not_prefix> 
		create prefix = <proset_not_trigger_prefix> 
	ENDIF 
ENDSCRIPT

SCRIPT goal_crossed_kill_radius 
	create_panel_message id = goal_message text = "You left the goal area!" style = panel_message_generic_loss 
	Obj_ClearException SkaterOutOfRadius 
	GoalManager_LoseGoal name = <goal_id> 
ENDSCRIPT

SCRIPT goal_expire 
	destroy_goal_panel_messages 
	create_panel_message id = goal_message text = "Out of time!" style = panel_message_generic_loss 
	IF GoalManager_EndRunCalled name = <goal_id> 
		IF GoalManager_StartedEndOfRun name = <goal_id> 
			SpawnSkaterScript goal_init_after_end_of_run params = { goal_id = <goal_id> } 
		ELSE 
			GoalManager_ClearEndRun name = <goal_id> 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT goal_success goal_text = "Default goal success text" 
	SwitchToReplayIdleMode 
	IF NOT InNetGame 
		kill_start_key_binding 
	ENDIF 
	destroy_goal_panel_messages 
	goal_destroy_counter 
	GoalManager_GetGoalParams name = <goal_id> 
	IF NOT GotParam testing_goal 
		GoalEditor : FlagGoalAsWon goal_id = <goal_id> 
	ENDIF 
	IF GotParam goal_outro_script 
		<goal_outro_script> <goal_outro_script_params> 
	ENDIF 
	IF ObjectExists id = goal_message 
		RunScriptOnScreenElement id = goal_message kill_panel_message 
	ENDIF 
	goal_pro_stop_anim_scripts <...> 
	IF ObjectExists id = <trigger_obj_id> 
		IF GotParam trigger_success_script 
			<trigger_obj_id> : Obj_SpawnScript <trigger_success_script> params = { goal_id = <goal_id> pro = <pro> type = "Success" } 
		ELSE 
			<trigger_obj_id> : Obj_SpawnScript GenericProSuccess params = { goal_id = <goal_id> pro = <pro> type = "Success" } 
		ENDIF 
	ENDIF 
	IF NOT GotParam trigger_wait_script 
		<trigger_wait_script> = GenericProWaiting 
	ENDIF 
	<already_beat_goal> = 0 
	IF GoalManager_HasWonGoal name = <goal_id> 
		<already_beat_goal> = 1 
	ENDIF 
	IF NOT ( <already_beat_goal> = 1 ) 
		IF GotParam reward_trickslot 
			IF NOT GotParam already_added_trickslot 
				GoalManager_EditGoal name = <goal_id> params = { just_added_trickslot = 1 } 
				GetSkaterProfileInfoByName name = custom 
				IF ( <max_specials> < max_number_of_special_trickslots ) 
					AwardSpecialTrickslot 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
	SpawnScript goal_success_messages params = <...> 
	IF NOT InMultiplayerGame 
		<played_success_movie> = 0 
		IF ( ( GotParam success_cam_anim ) | ( GotParam success_cam_anims ) ) 
			<played_success_movie> = 1 
			change check_for_unplugged_controllers = 0 
			SpawnScript goal_cam_anim_play params = { goal_id = <goal_id> 
				just_won_goal = 1 
				gonna_show_message 
				already_beat_goal = <already_beat_goal> 
			} 
		ENDIF 
		IF ( <played_success_movie> = 0 ) 
			SpawnScript goal_success_no_anims params = <...> 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT goal_success_no_anims 
	goal_cam_anim_post_cleanup <...> 
	goal_cam_anim_post_success dont_kill_messages <...> 
ENDSCRIPT

SCRIPT goal_success_messages 
	SpawnScript Goal_Success_Message_Sound 
	IF GotParam view_goals_text 
		create_panel_block id = goal_complete text = <view_goals_text> style = panel_message_goalcomplete 
	ELSE 
		create_panel_block id = goal_complete text = <goal_text> style = panel_message_goalcomplete 
	ENDIF 
	create_panel_sprite id = goal_complete_sprite texture = GO_done style = panel_sprite_goalcomplete 
	create_panel_message id = goal_complete_line2 text = "Complete!" style = panel_message_goalcompleteline2 
	IF GotParam reward_trickslot 
		IF GotParam just_added_trickslot 
			IF ( <just_added_trickslot> = 1 ) 
				GoalManager_EditGoal name = <goal_id> params = { just_added_trickslot = 0 } 
				goal_got_trickslot 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT already_in_goal 
	create_panel_message id = goal_message text = "Already in goal run" style = panel_message_goal 
ENDSCRIPT

SCRIPT goal_lose_next_frame 
	wait 1 frame 
	IF GoalManager_GoalIsActive name = <goal_id> 
		GoalManager_LoseGoal name = <goal_id> 
	ENDIF 
ENDSCRIPT

SCRIPT goal_fail 
	destroy_goal_panel_messages 
	PlaySound GoalFail vol = 200 
	GoalManager_GetGoalParams name = <goal_id> 
	IF GotParam goal_fail_script 
		<goal_fail_script> <goal_fail_script_params> 
	ENDIF 
	create_panel_sprite id = goalfail_sprite texture = GO_fail style = panel_sprite_goalfail 
	IF GotParam view_goals_text 
		create_panel_block dims = PAIR(640.00000000000, 0.00000000000) id = GoalFail text = <view_goals_text> style = panel_message_goalfail 
	ELSE 
		create_panel_block dims = PAIR(640.00000000000, 0.00000000000) id = GoalFail text = <goal_text> style = panel_message_goalfail 
	ENDIF 
	create_panel_message id = goalfailedline2 text = "Failed!" style = panel_message_goalfailline2 
	IF isxbox 
		retry_text = "Press \\b8 to retry goal" 
	ELSE 
		retry_text = "Press START (\\b8) to retry goal" 
	ENDIF 
	create_speech_box { 
		anchor_id = goal_retry_anchor 
		text = <retry_text> 
		style = goal_fail_retry_box_style 
		no_pad_start 
		no_pad_choose 
		z_priority = 10 
	} 
ENDSCRIPT

SCRIPT goal_fail_retry_box_style 
	wait 4000 
	Die 
ENDSCRIPT

SCRIPT goal_uninit 
	GoalManager_GetGoalParams name = <goal_id> 
	goal_kill_proset_geom <...> 
	IF IsAlive name = <trigger_obj_id> 
		GoalManager_StopLastStream name = <goal_id> 
		GoalManager_UnloadLastFam name = <goal_id> 
		kill name = <trigger_obj_id> 
	ENDIF 
	IF GotParam init_geo_prefix 
		kill prefix = <init_geo_prefix> 
	ELSE 
		IF GotParam init_geo_prefixes 
			GetArraySize <init_geo_prefixes> 
			<index> = 0 
			BEGIN 
				kill prefix = ( <init_geo_prefixes> [ <index> ] ) 
				<index> = ( <index> + 1 ) 
			REPEAT <array_size> 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT goal_deactivate 
	IF GameModeEquals is_goal_attack 
		KillSpawnedScript name = goal_cam_anim_play 
		KillSpawnedScript name = goal_cam_anim_play_single_element 
		KillSpawnedScript name = TemporarilyDisableInput 
		KillSkaterCamAnim all 
		restore_skater_camera 
		speech_box_exit anchor_id = goal_description_anchor no_pad_start 
		Skater : NetEnablePlayerInput 
		SetButtonEventMappings unblock_menu_input 
		restore_start_key_binding 
		IF NOT GoalManager_CanStartGoal 
			MakeSkaterGoto OnGroundAI 
		ENDIF 
		GoalManager_SetCanStartGoal 1 
	ENDIF 
	KillAllTextureSplats 
	KillSpawnedScript name = goal_show_tips 
	KillSpawnedScript name = goal_wait_and_show_key_combo_text 
	goal_destroy_counter 
	IF GoalManager_EndRunCalled name = <goal_id> 
		IF GoalManager_StartedEndOfRun name = <goal_id> 
			SpawnSkaterScript goal_init_after_end_of_run params = { goal_id = <goal_id> } 
		ELSE 
			GoalManager_ClearEndRun name = <goal_id> 
		ENDIF 
	ENDIF 
	GoalManager_StopLastStream name = <goal_id> 
	GoalManager_UnloadLastFam name = <goal_id> 
	SetScoreAccumulation 0 
	SetScoreDegradation 0 
	GoalManager_GetGoalParams name = <goal_id> 
	IF GotParam quick_start 
		GoalManager_EditGoal name = <goal_id> params = { last_start_was_quick_start = 1 } 
	ELSE 
		GoalManager_EditGoal name = <goal_id> params = { last_start_was_quick_start = 0 } 
	ENDIF 
	IF GotParam goal_intro_script 
		KillSpawnedScript name = goal_intro_script 
	ENDIF 
	IF GotParam goal_deactivate_script 
		<goal_deactivate_script> <goal_deactivate_script_params> 
	ENDIF 
	KillSpawnedScript name = goal_description_and_speech 
	KillSpawnedScript name = goal_wait_for_cam_anim 
	IF ScreenElementExists id = current_goal 
		DestroyScreenElement id = current_goal 
	ENDIF 
	IF ScreenElementExists id = current_goal_key_combo_text 
		DestroyScreenElement id = current_goal_key_combo_text 
	ENDIF 
	IF ObjectExists id = current_goal_description 
		DestroyScreenElement id = current_goal_description 
	ENDIF 
	IF NOT GotParam quick_start 
		IF GameModeEquals is_career 
			goal_get_chapter_stage_from_id id = <goal_id> 
			GoalManager_GetCurrentChapterAndStage 
			<level> = ( ( CHAPTER_LEVELS [ <currentChapter> ] ) . checksum ) 
			IF LevelIs <level> 
				IF GotParam stage 
					tod_req_action = ( ( STAGE_TOD_SETTINGS [ <currentChapter> ] ) [ <currentStage> ] ) 
					tod_cur_action = ( ( STAGE_TOD_SETTINGS [ <chapter> ] ) [ <stage> ] ) 
					IF NOT ( <tod_cur_action> = <tod_req_action> ) 
						script_change_tod tod_action = <tod_req_action> 
					ENDIF 
				ELSE 
					tod_req_action = ( ( STAGE_TOD_SETTINGS [ <currentChapter> ] ) [ <currentStage> ] ) 
					tod_cur_action = cur_tod_cur_action 
					IF NOT ( <tod_cur_action> = <tod_req_action> ) 
						script_change_tod tod_action = <tod_req_action> 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
		IF NOT GotParam just_won_goal 
			goal_pro_stop_anim_scripts <...> 
			IF GotParam trigger_wait_script 
				<trigger_obj_id> : Obj_SpawnScript <trigger_wait_script> params = { goal_id = <goal_id> pro = <pro> } 
			ELSE 
				<trigger_obj_id> : Obj_SpawnScript GenericProWaiting params = { goal_id = <goal_id> type = "wait" pro = <pro> } 
			ENDIF 
		ENDIF 
	ENDIF 
	IF GotParam control_type 
		IF NOT ( ( <control_type> = Skate ) | ( <control_type> = Walk ) | ( <control_type> = WalkOnly ) ) 
			IF GotParam exit_node 
				ResetSkaters Node_Name = <exit_node> 
			ELSE 
				ResetSkaters Node_Name = <restart_node> 
			ENDIF 
			MakeSkaterGoto HandBrake 
			IF GameIsPaused 
				Skater : Pause 
			ENDIF 
			IF GotParam edited_goal 
				GoalManager_GetLevelPrefix 
				FormatText ChecksumName = ReadyLevelScript "%l_CreateVehicles" l = <level_prefix> 
				IF ScriptExists <ReadyLevelScript> 
					<ReadyLevelScript> 
				ENDIF 
			ENDIF 
		ENDIF 
		IF ( <control_type> = WalkOnly ) 
			Skater : ReturnBoardToSkater 
		ENDIF 
	ENDIF 
	IF GotParam geo_prefix 
		goal_kill_geo_prefix geo_prefix = <geo_prefix> 
	ELSE 
		IF GotParam geo_prefixes 
			GetArraySize <geo_prefixes> 
			<index> = 0 
			BEGIN 
				goal_kill_geo_prefix geo_prefix = ( <geo_prefixes> [ <index> ] ) 
				<index> = ( <index> + 1 ) 
			REPEAT <array_size> 
		ENDIF 
	ENDIF 
	IF GotParam trigger_prefix 
		kill prefix = <trigger_prefix> 
	ENDIF 
	IF NOT GotParam quick_start 
		<trigger_obj_id> : Obj_Visible 
		GoalManager_ShowGoalPoints 
		IF NOT IsTrue ALWAYSPLAYMUSIC 
			IF NOT GoalManager_HasWonGoal name = <goal_id> 
				PauseMusic 1 
			ENDIF 
		ENDIF 
	ENDIF 
	IF NOT GotParam just_won_goal 
		IF NOT GotParam quick_start 
			IF NOT GoalManager_HasWonGoal name = <goal_id> 
				goal_add_ped_arrow goal_id = <goal_id> 
			ENDIF 
		ENDIF 
	ENDIF 
	IF GoalManager_HasWonGoal name = <goal_id> 
		IF NOT GotParam quick_start 
			IF GotParam just_won_goal 
			ELSE 
				GoalManager_UninitializeGoal name = <goal_id> 
			ENDIF 
		ENDIF 
	ENDIF 
	IF GotParam just_won_goal 
		GoalManager_GetNumberOfGoalPoints total 
		IF ( <goal_points> = total_num_goals ) 
			IF NOT GetGlobalFlag flag = GOT_ALL_GOALS 
				SetGlobalFlag flag = GOT_ALL_GOALS 
				unlock_all_cheat_codes 
				unlock_all_gameplay_cheat_codes 
				SpawnScript GotAllGoalsMessage 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT GotAllGoalsMessage 
	dialog_box_exit 
	PauseGame 
	create_dialog_box { title = "CONGRATULATIONS!" 
		title_font = testtitle 
		text = "Way to go back and clean out the story goals. \\n\\nYou\'ve unlocked \\c3new cheats\\c0 to help you take it further. Access them from the Pause menu under Options. Good luck!" 
		pos = PAIR(320.00000000000, 240.00000000000) 
		just = [ center center ] 
		text_rgba = [ 88 105 112 128 ] 
		text_dims = PAIR(330.00000000000, 0.00000000000) 
		line_spacing = 0.85000002384 
		buttons = [ { font = small text = "OK" pad_choose_script = EndGotAllMessgaes } ] 
		delay_input 
		pad_focus_script = text_twitch_effect 
		style = special_dialog_style 
	} 
ENDSCRIPT

SCRIPT EndGotAllMessgaes 
	dialog_box_exit 
	UnpauseGame 
ENDSCRIPT

SCRIPT SetCurrentGoal 
	Obj_VarSet var = 0 value = <value> 
ENDSCRIPT

SCRIPT goal_retry_select_handler 
	IF ( goal_bind_retry_to_select = 1 ) 
		IF GoalManager_CanStartGoal 
			RetryCurrentGoal 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT RetryCurrentGoal 
	IF GoalManager_CanRetryGoal 
		IF GoalManager_GetLastGoalId 
			IF InNetGame 
				IF GoalManager_HasWonGoal name = <goal_id> 
					RETURN 
				ENDIF 
			ENDIF 
			goal_check_for_required_tricks goal_id = <goal_id> 
			IF ( <found_unmapped_trick> = 1 ) 
				RETURN 
			ENDIF 
		ENDIF 
		GoalManager_RestartLastGoal 
	ELSE 
	ENDIF 
ENDSCRIPT

SCRIPT goal_restart_stage 
	GoalManager_RestartStage 
ENDSCRIPT

SCRIPT end_current_goal_run 
	wait 1 gameframe 
	IF ObjectExists id = goal_message 
		RunScriptOnScreenElement id = goal_message kill_panel_message 
	ENDIF 
	IF GoalManager_HasActiveGoals 
		GoalManager_DeactivateCurrentGoal 
	ENDIF 
ENDSCRIPT

SCRIPT ready_skater_for_early_end_current_goal 
	IF InNetGame 
		IF GotParam Net 
			RETURN 
		ENDIF 
	ENDIF 
	IF InSplitScreenGame 
		RETURN 
	ENDIF 
	IF IsObserving 
		RETURN 
	ENDIF 
	IF NOT ObjectExists id = Skater 
		RETURN 
	ENDIF 
	IF Skater : IsInEndOfRun 
		ResetSkaters Node_Name = <restart_node> 
	ENDIF 
ENDSCRIPT

goal_cam_anim_offsets = [ 
	{ targetOffset = VECTOR(0.00000000000, 46.79999923706, 0.00000000000) positionOffset = VECTOR(9.60000038147, 10.80000019073, 75.59999847412) } 
	{ targetOffset = VECTOR(1.20000004768, 62.40000152588, 0.00000000000) positionOffset = VECTOR(-2.40000009537, 0.00000000000, 26.39999961853) } 
	{ targetOffset = VECTOR(3.59999990463, 57.59999847412, 0.00000000000) positionOffset = VECTOR(-7.19999980927, -31.20000076294, 70.80000305176) } 
	{ targetOffset = VECTOR(8.39999961853, 49.20000076294, 1.20000004768) positionOffset = VECTOR(-8.39999961853, 30.00000000000, 63.59999847412) } 
	{ targetOffset = VECTOR(-24.00000000000, 58.79999923706, 13.19999980927) positionOffset = VECTOR(51.59999847412, -2.40000009537, 91.19999694824) } 
	{ targetOffset = VECTOR(30.00000000000, 58.79999923706, 20.39999961853) positionOffset = VECTOR(-56.40000152588, -2.40000009537, 85.19999694824) } 
	{ targetOffset = VECTOR(30.00000000000, 58.79999923706, 20.39999961853) positionOffset = VECTOR(-56.40000152588, -2.40000009537, 85.19999694824) } 
	{ targetOffset = VECTOR(-20.39999961853, 43.20000076294, 32.40000152588) positionOffset = VECTOR(100.80000305176, 6.00000000000, 63.59999847412) } 
	{ targetOffset = VECTOR(30.00000000000, -14.39999961853, 2.40000009537) positionOffset = VECTOR(-36.00000000000, 148.80000305176, 446.39999389648) } 
	{ targetOffset = VECTOR(12.00000000000, -25.20000076294, -9.60000038147) positionOffset = VECTOR(312.00000000000, 159.60000610352, 366.00000000000) } 
	{ targetOffset = VECTOR(7.19999980927, 4.80000019073, 21.60000038147) positionOffset = VECTOR(-420.00000000000, 128.39999389648, 129.60000610352) } 
] 
SCRIPT goal_cam_anim_play 
	GoalManager_GetGoalParams name = <goal_id> 
	goal_cam_anim_pre_cleanup <...> 
	IF GotParam just_won_goal 
		IF GotParam success_cam_anim 
			<anim> = <success_cam_anim> 
		ELSE 
			IF GotParam success_cam_anims 
				<anims> = <success_cam_anims> 
			ELSE 
				<virtual_cam> = virtual_cam 
			ENDIF 
		ENDIF 
		goal_cam_anim_pre_success <...> 
		just_won_goal = just_won_goal 
	ELSE 
		IF GotParam start_cam_anim 
			<anim> = <start_cam_anim> 
		ELSE 
			IF GotParam start_cam_anims 
				<anims> = <start_cam_anims> 
			ELSE 
				<virtual_cam> = virtual_cam 
			ENDIF 
		ENDIF 
		goal_cam_anim_pre_start <...> 
	ENDIF 
	GetSkaterId 
	<skaterId> = <ObjId> 
	IF NOT GotParam no_cam_anim 
		IF GotParam anims 
			GetArraySize <anims> 
			<index> = 0 
			BEGIN 
				IF ( <index> = ( <array_size> - 1 ) ) 
					<last_anim> = 1 
				ELSE 
					<last_anim> = 0 
				ENDIF 
				goal_cam_anim_play_single_element { ( <anims> [ <index> ] ) 
					goal_id = <goal_id> 
					anim_index = <index> 
					last_anim = <last_anim> 
					<just_won_goal> 
					cam_anim_index = <index> 
				} 
				<index> = ( <index> + 1 ) 
			REPEAT <array_size> 
		ELSE 
			goal_cam_anim_play_single_element <...> last_anim = 1 cam_anim_index = 0 
		ENDIF 
	ENDIF 
	goal_cam_anim_post_cleanup <...> 
	IF GotParam just_won_goal 
		goal_cam_anim_post_success <...> 
	ELSE 
		goal_cam_anim_post_start <...> 
	ENDIF 
ENDSCRIPT

SCRIPT goal_cam_anim_pre_cleanup 
	GoalManager_PauseAllGoals 
	GetValueFromVolume cdvol 
	IF NOT InNetGame 
		IF ( <value> > 0 ) 
			<volume> = <value> 
			SetMusicVolume 20 
		ENDIF 
	ENDIF 
	IF GotParam edited_goal 
		Skater : PausePhysics 
	ENDIF 
	change check_for_unplugged_controllers = 0 
	Skater : StatsManager_DeactivateGoals 
	IF InNetGame 
		Skater : NetDisablePlayerInput 
	ELSE 
		Skater : DisablePlayerInput 
	ENDIF 
	GoalManager_SetCanStartGoal 0 
	IF GotParam trigger_obj_id 
		IF IsAlive name = <trigger_obj_id> 
			TerminateObjectsScripts id = <trigger_obj_id> script_name = GenericPro_LookAtSkater use_proper_version 
			<trigger_obj_id> : Obj_StopRotating 
			<trigger_obj_id> : Obj_LookAtObject type = Skater AngleThreshold = 15 speed = 500 time = 0 
		ENDIF 
	ENDIF 
	pause_trick_text 
	IF ScreenElementExists id = the_time 
		SetScreenElementProps { 
			id = the_time 
			hide 
		} 
	ENDIF 
	SetButtonEventMappings block_menu_input 
	GetSkaterId 
	IF InNetGame 
		<ObjId> : NetDisablePlayerInput 
	ELSE 
		<ObjId> : DisablePlayerInput 
	ENDIF 
	kill_start_key_binding 
	SpawnScript TemporarilyDisableInput 
	RETURN volume = <volume> 
ENDSCRIPT

SCRIPT goal_cam_anim_post_cleanup 
	change check_for_unplugged_controllers = 1 
	restore_start_key_binding 
	IF GotParam edited_goal 
		Skater : UnPausePhysics 
	ENDIF 
	IF InNetGame 
		Skater : NetEnablePlayerInput 
	ELSE 
		Skater : EnablePlayerInput 
	ENDIF 
	IF NOT GotParam dont_unpause 
		GoalManager_UnPauseAllGoals 
	ENDIF 
	GoalManager_SetCanStartGoal 
	Skater : StatsManager_ActivateGoals 
	PauseMusic 0 
	IF GotParam volume 
		SetMusicVolume ( <volume> * 10 ) 
	ENDIF 
	IF ObjectExists id = speech_box_anchor 
		DestroyScreenElement id = speech_box_anchor 
	ENDIF 
	IF NOT Skater : Driving 
		UnPauseSkaters 
	ENDIF 
	unpause_trick_text 
	IF ScreenElementExists id = the_time 
		SetScreenElementProps { 
			id = the_time 
			unhide 
		} 
	ENDIF 
	IF GotParam trigger_obj_id 
		IF IsAlive name = <trigger_obj_id> 
			GoalManager_StopLastStream name = <goal_id> 
			GoalManager_UnloadLastFam name = <goal_id> 
		ENDIF 
	ENDIF 
	IF GotParam next_trigger_script 
		goal_pro_stop_anim_scripts <...> 
		IF ObjectExists id = <trigger_obj_id> 
			<trigger_obj_id> : Obj_SpawnScript <next_trigger_script> params = { type = <type> goal_id = <goal_id> pro = <pro> } 
		ENDIF 
	ENDIF 
	restore_start_key_binding 
	FireEvent type = goal_cam_anim_done 
	IF GotParam show_movie 
		IF ( <show_movie> = 1 ) 
			IF GotParam movie_file 
				ingame_play_movie <movie_file> 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT goal_cam_anim_pre_success 
	IF NOT InMultiplayerGame 
		SetButtonEventMappings block_menu_input 
		GetSkaterId 
		<ObjId> : DisablePlayerInput 
		SetScreenElementProps { 
			id = root_window 
			event_handlers = [ { pad_start nullscript } ] 
			replace_handlers 
		} 
		SpawnScript TemporarilyDisableInput 
		PauseSkaters 
	ENDIF 
	Skater : Obj_SetFlag FLAG_SKATER_INGOALINIT 
	IF GotParam success_node 
		ResetSkaters Node_Name = <success_node> 
	ENDIF 
	PauseSkaters 
	IF NOT GotParam dont_hide_skater 
		Skater : RemoveSkaterFromWorld 
	ENDIF 
	IF GotParam success_movie_wait_frames 
		wait <success_movie_wait_frames> gameframe 
	ENDIF 
	root_window : SetTags giving_rewards = 1 
ENDSCRIPT

SCRIPT goal_cam_anim_mid_success 
	GoalManager_GetGoalParams name = <goal_id> 
	create_speech_box { 
		text = "Press \\m0 to continue" 
		pad_choose_script = goal_description_and_speech_continue 
		pad_choose_params = { no_pad_start anim = <anim> } 
	} 
ENDSCRIPT

SCRIPT goal_cam_anim_post_success 
	Skater : Obj_ClearFlag FLAG_SKATER_INGOALINIT 
	IF NOT GotParam dont_hide_skater 
		Skater : AddSkaterToWorld 
	ENDIF 
	KillSpawnedScript name = TemporarilyDisableInput 
	SetButtonEventMappings unblock_menu_input 
	<ObjId> : EnablePlayerInput 
	root_window : SetTags giving_rewards = 0 
	IF NOT GotParam dont_kill_messages 
		KillSpawnedScript name = goal_success_messages 
		IF ScreenElementExists id = goal_complete_sprite 
			DestroyScreenElement id = goal_complete_sprite 
		ENDIF 
		IF ScreenElementExists id = goal_complete 
			DestroyScreenElement id = goal_complete 
		ENDIF 
		IF ScreenElementExists id = goal_complete_line2 
			DestroyScreenElement id = goal_complete_line2 
		ENDIF 
		IF ScreenElementExists id = goal_new_record 
			DestroyScreenElement id = goal_new_record 
		ENDIF 
		IF ScreenElementExists id = goal_current_reward 
			DestroyScreenElement id = goal_current_reward 
		ENDIF 
	ENDIF 
	goal_uninit goal_id = <goal_id> 
	IF GotParam goal_success_script 
		<goal_success_script> <goal_success_params> 
	ENDIF 
	GoalManager_GetNumberOfGoalPoints total 
	IF ( <goal_points> = 129 ) 
		IF NOT GetGlobalFlag flag = GOT_ALL_GOALS 
		ENDIF 
	ENDIF 
	GoalManager_GetCurrentChapterAndStage 
	IF GoalManager_AdvanceStage 
		kill_start_key_binding 
		IF ControllerBoundToSkater controller = 0 Skater = 0 
			VibrateController port = 0 actuator = 0 percent = 0 
			VibrateController port = 0 actuator = 1 percent = 0 
		ENDIF 
		IF ControllerBoundToSkater controller = 1 Skater = 0 
			VibrateController port = 1 actuator = 0 percent = 0 
			VibrateController port = 1 actuator = 1 percent = 0 
		ENDIF 
		IF ( ( isxbox ) | ( IsNGC ) ) 
			IF ControllerBoundToSkater controller = 2 Skater = 0 
				VibrateController port = 2 actuator = 0 percent = 0 
				VibrateController port = 2 actuator = 1 percent = 0 
			ENDIF 
			IF ControllerBoundToSkater controller = 3 Skater = 0 
				VibrateController port = 3 actuator = 0 percent = 0 
				VibrateController port = 3 actuator = 1 percent = 0 
			ENDIF 
		ENDIF 
		<stage_struct> = ( ( CHAPTER_COMPLETION_SCRIPTS [ <currentChapter> ] ) [ <currentStage> ] ) 
		IF StructureContains structure = <stage_struct> script_name 
			<stage_script> = ( <stage_struct> . script_name ) 
		ENDIF 
		IF StructureContains structure = <stage_struct> params 
			<stage_script_params> = ( <stage_struct> . params ) 
		ENDIF 
		SpawnScript <stage_script> params = { <stage_script_params> just_won_goal } 
		GetArraySize CHAPTER_NUM_GOALS_TO_COMPLETE index1 = <currentChapter> 
		IF ( <currentStage> = ( <array_size> -1 ) ) 
			goal_mark_chapter_complete currentChapter = <currentChapter> 
		ENDIF 
	ELSE 
		goal_get_chapter_stage_from_id id = <goal_id> 
		IF ( ( GotParam chapter ) & ( GotParam stage ) ) 
			IF ( ( <chapter> = 25 ) & ( <stage> = 0 ) ) 
				GoalManager_GetCurrentChapterAndStage 
				IF ( ( <currentChapter> = 25 ) & ( <currentStage> = 0 ) ) 
					DisplayLoadingScreen blank 
					kill_start_key_binding 
					select_sponsor_post_movies_cleanup 
					IF ScreenElementExists id = current_menu_anchor 
						DestroyScreenElement id = current_menu_anchor 
					ENDIF 
					restore_skater_camera 
					launch_chapter_menu 
					HideLoadingScreen 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
	IF GotParam create_a_trick 
		goal_cat_create_menu goal_id = <goal_id> 
	ENDIF 
ENDSCRIPT

SCRIPT goal_mark_chapter_complete 
	<status_array> = CHAPTER_STATUS 
	SetArrayElement ArrayName = status_array index = <currentChapter> NewValue = 2 
	GetArraySize <status_array> 
	IF ( <currentChapter> < ( <array_size> - 1 ) ) 
		SetArrayElement ArrayName = status_array index = ( <currentChapter> + 1 ) NewValue = 1 
	ENDIF 
ENDSCRIPT

SCRIPT goal_stage_script_done 
	restore_start_key_binding 
ENDSCRIPT

SCRIPT show_all_goals_done_dlg 
	wait 2 seconds 
	PauseGame 
	SetGlobalFlag flag = GOT_ALL_GOALS 
	goal_got_all_goals 
	WaitForEvent type = goal_got_all_goals_done 
	UnpauseGame 
	KillSpawnedScript name = show_all_goals_done_dlg 
ENDSCRIPT

SCRIPT goal_cam_anim_pre_start 
	MakeSkaterGoto Skater_GoalInit 
	KillSpawnedScript name = goal_description_and_speech 
	KillSpawnedScript name = goal_description_and_speech2 
ENDSCRIPT

SCRIPT goal_cam_anim_post_start 
	IF NOT GoalManager_GoalIsActive name = <goal_id> 
		FireEvent type = goal_cam_anim_post_start_done 
		RETURN 
	ENDIF 
	IF GotParam use_hud_counter 
		goal_create_counter goal_id = <goal_id> hud_counter_caption = <hud_counter_caption> 
	ENDIF 
	goal_initialize_skater <...> 
	IF GotParam goal_start_script 
		<goal_start_script> <goal_start_script_params> 
	ENDIF 
	IF GotParam hide_goal_pro 
		<trigger_obj_id> : Obj_Invisible 
	ENDIF 
	DeBounce x time = 0.30000001192 
	FireEvent type = goal_cam_anim_post_start_done 
ENDSCRIPT

SCRIPT hide_loading_screen 
	HideLoadingScreen 
ENDSCRIPT

SCRIPT goal_cam_anim_play_single_element 
	GoalManager_GetGoalParams name = <goal_id> 
	GetSkaterId 
	<skaterId> = <ObjId> 
	IF GotParam pre_anim_script 
		<pre_anim_script> <pre_anim_script_params> 
	ENDIF 
	IF GotParam skater_node 
		ResetSkaters Node_Name = <skater_node> 
	ENDIF 
	IF GotParam walk_into_frame 
		IF NOT GotParam walk_into_frame_distance 
			<walk_into_frame_distance> = 120 
		ENDIF 
		MakeSkaterGoto Skater_GoalInit params = { Walk walk_distance = <walk_into_frame_distance> } 
	ENDIF 
	IF GotParam ped_node 
		IF GotParam trigger_obj_id 
			<trigger_obj_id> : Obj_MoveToNode name = <ped_node> orient 
		ENDIF 
	ENDIF 
	IF GotParam trigger_obj_id 
		IF IsAlive name = <trigger_obj_id> 
			<trigger_obj_id> : Obj_StopRotating 
			<trigger_obj_id> : Obj_LookAtObject type = Skater AngleThreshold = 15 speed = 50600 time = 0 
		ENDIF 
	ENDIF 
	IF GotParam ped_script 
		IF GotParam trigger_obj_id 
			goal_pro_stop_anim_scripts <...> 
			<trigger_obj_id> : Obj_SpawnScript <ped_script> params = { goal_id = <goal_id> } 
		ENDIF 
	ENDIF 
	IF NOT GotParam no_play_hold 
		<play_hold> = play_hold 
	ENDIF 
	IF NOT GotParam skippable 
		<skippable> = 1 
	ENDIF 
	IF ( <last_anim> = 1 ) 
		IF NOT GotParam just_won_goal 
			<skippable> = 0 
		ENDIF 
		<play_hold> = play_hold 
	ENDIF 
	IF GotParam virtual_cam 
		<anim> = <goal_id> 
		<virtual_cam> = virtual_cam 
		IF NOT GotParam targetId 
			<trigger_obj_id> : Obj_GetID 
			<targetId> = <ObjId> 
		ENDIF 
		IF NOT ( ( GotParam targetOffset ) & ( GotParam positionOffset ) ) 
			GetRandomArrayElement goal_cam_anim_offsets 
			<targetOffset> = ( <element> . targetOffset ) 
			<positionOffset> = ( <element> . positionOffset ) 
		ENDIF 
		IF NOT GotParam frames 
			<frames> = 120 
		ENDIF 
	ELSE 
		IF NOT GotParam anim 
			printstruct <...> 
			script_assert "No anim specified and no virtual_cam flag present" 
		ENDIF 
	ENDIF 
	DisplayLoadingScreen freeze 
	PlaySkaterCamAnim { name = <anim> 
		skaterId = <skaterId> 
		targetId = <targetId> 
		targetOffset = <targetOffset> 
		positionOffset = <positionOffset> 
		frames = <frames> 
		<play_hold> 
		skippable = <skippable> 
		<virtual_cam> 
	} 
	DeBounce x time = 0.30000001192 
	IF GotParam null_goal 
		IF ( <last_anim> = 1 ) 
			<cam_anim_index> = -2 
		ENDIF 
		<last_anim> = 0 
		<skippable> = 1 
	ENDIF 
	IF ( ( GotParam edited_goal ) & ( GotParam just_won_goal ) ) 
		<last_anim> = 0 
		<skippable> = 1 
	ENDIF 
	<should_use_cam_anim_text> = 1 
	IF ( <last_anim> = 1 ) 
		IF NOT GotParam just_won_goal 
			<should_use_cam_anim_text> = 0 
		ENDIF 
	ENDIF 
	IF ( <should_use_cam_anim_text> = 0 ) 
		SpawnScript goal_description_and_speech params = <...> 
	ELSE 
		IF GotParam cam_anim_text 
			IF ( ( GotParam trigger_obj_id ) | ( GotParam speaker_obj_id ) ) 
				IF GotParam just_won_goal 
					GoalManager_PlayGoalWinStream { 
						name = <goal_id> 
						speaker_obj_id = <speaker_obj_id> 
						speaker_name = <speaker_name> 
						cam_anim_index = ( <cam_anim_index> + 1 ) 
					} 
				ELSE 
					GoalManager_PlayGoalStartStream { 
						name = <goal_id> 
						speaker_obj_id = <speaker_obj_id> 
						speaker_name = <speaker_name> 
						cam_anim_index = ( <cam_anim_index> + 1 ) 
					} 
				ENDIF 
			ENDIF 
		ENDIF 
		IF GotParam cam_anim_text 
			<display_cam_anim_text> = "" 
			IF GotParam cam_anim_speaker_name 
				FormatText TextName = display_cam_anim_text "\\ca%s :\\c0\\n" s = <cam_anim_speaker_name> 
			ELSE 
				IF GotParam full_name 
					FormatText TextName = display_cam_anim_text "\\ca%s :\\c0\\n" s = <full_name> 
				ELSE 
					IF GotParam pro 
						FormatText ChecksumName = pro_checksum "%s" s = <pro> 
						IF StructureContains structure = goal_pro_last_names <pro_checksum> 
							<pro_last_name> = ( goal_pro_last_names . <pro_checksum> ) 
							FormatText TextName = pro_name_text "\\ca%s %l :\\c0\\n" s = <pro> l = <pro_last_name> 
						ENDIF 
					ENDIF 
				ENDIF 
			ENDIF 
			IF IsArray <cam_anim_text> 
				GetArraySize <cam_anim_text> 
				<index> = 0 
				BEGIN 
					FormatText TextName = display_cam_anim_text "%s%n" s = <display_cam_anim_text> n = ( <cam_anim_text> [ <index> ] ) 
					<index> = ( <index> + 1 ) 
				REPEAT <array_size> 
			ELSE 
				FormatText TextName = display_cam_anim_text "%s%n" s = <display_cam_anim_text> n = <cam_anim_text> 
			ENDIF 
			IF NOT ( <skippable> = 0 ) 
				SetSkaterCamAnimSkippable skaterId = <skaterId> name = <anim> skippable = 0 
				FormatText TextName = display_cam_anim_text "%s\\nPress \\m0 to continue." s = <display_cam_anim_text> 
				<pad_choose_script> = goal_description_and_speech_continue 
				<pad_choose_params> = { no_pad_start anim = <anim> skippable = <skippable> } 
			ENDIF 
			IF ScreenElementExists id = speech_box_anchor 
				DestroyScreenElement id = speech_box_anchor 
			ENDIF 
			kill_start_key_binding 
			create_speech_box { 
				anchor_id = goal_description_anchor 
				text = <display_cam_anim_text> 
				pos = <text_anchor_pos> 
				style = speech_box_style 
				bg_x_scale = 1.29999995232 
				pad_choose_script = <pad_choose_script> 
				pad_choose_params = <pad_choose_params> 
			} 
		ELSE 
			<pad_choose_script> = goal_description_and_speech_continue 
			<pad_choose_params> = { no_pad_start anim = <anim> skippable = <skippable> } 
			create_speech_box { 
				anchor_id = goal_description_anchor 
				text = "Press \\m0 to continue." 
				pos = <text_anchor_pos> 
				style = speech_box_style 
				bg_x_scale = 1.29999995232 
				pad_choose_script = <pad_choose_script> 
				pad_choose_params = <pad_choose_params> 
			} 
		ENDIF 
	ENDIF 
	BEGIN 
		IF SkaterCamAnimFinished skaterId = <skaterId> name = <anim> 
			IF ScreenElementExists id = goal_description_anchor 
				DestroyScreenElement id = goal_description_anchor 
			ENDIF 
			GoalManager_StopLastStream name = <goal_id> 
			GoalManager_UnloadLastFam name = <goal_id> 
			DeBounce x time = 0.30000001192 
			BREAK 
		ENDIF 
		wait 1 gameframe 
	REPEAT 
	IF GotParam post_anim_script 
		<post_anim_script> goal_id = <goal_id> <post_anim_script_params> 
	ENDIF 
	DisplayLoadingScreen freeze 
	wait 1 gameframe 
	HideLoadingScreen 
ENDSCRIPT

SCRIPT goal_initialize_skater 
	IF NOT GotParam control_type 
		NonVehicleControlType = 1 
	ELSE 
		IF ( ( <control_type> = Skate ) | ( <control_type> = Walk ) | ( <control_type> = WalkOnly ) ) 
			NonVehicleControlType = 1 
		ENDIF 
	ENDIF 
	IF GotParam NonVehicleControlType 
		SWITCH <control_type> 
			CASE WalkOnly 
				Skater : TakeBoardFromSkater 
				ResetSkaters Node_Name = <restart_node> RestartWalking 
			CASE Walk 
				ResetSkaters Node_Name = <restart_node> RestartWalking 
			CASE Skate 
				ResetSkaters Node_Name = <restart_node> 
				IF GotParam start_skater_standing 
					MakeSkaterGoto HandBrake 
				ENDIF 
			DEFAULT 
				ResetSkaters Node_Name = <restart_node> 
				IF GotParam start_skater_standing 
					MakeSkaterGoto HandBrake 
				ENDIF 
		ENDSWITCH 
	ELSE 
		GetVehicleSetup control_type = <control_type> 
		IF NOT GotParam Exitable 
			IF GotParam edited_goal 
				MakeSkaterGoto Switch_OnGroundAI params = { NewScript = TransAm VehicleSetup = <VehicleSetup> edited_goal } 
			ELSE 
				MakeSkaterGoto Switch_OnGroundAI params = { NewScript = TransAm VehicleSetup = <VehicleSetup> } 
			ENDIF 
		ELSE 
			IF GotParam edited_goal 
				MakeSkaterGoto Switch_OnGroundAI params = { NewScript = TransAm VehicleSetup = <VehicleSetup> Exitable edited_goal } 
			ELSE 
				MakeSkaterGoto Switch_OnGroundAI params = { NewScript = TransAm VehicleSetup = <VehicleSetup> Exitable } 
			ENDIF 
		ENDIF 
		PlayerVehicle : Vehicle_MoveToRestart <restart_node> 
		PlayerVehicleCamera : VehicleCamera_Reset 
		SetActiveCamera id = PlayerVehicleCamera 
		IF GotParam edited_goal 
			PlayerVehicle : Vehicle_Wake 
		ENDIF 
		IF GotParam goal_id 
			GoalManager_SetEndRunType name = <goal_id> None 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT PauseThenStartRecording 
ENDSCRIPT

SCRIPT TemporarilyDisableInput time = 1500 
	SetButtonEventMappings block_menu_input 
	wait <time> 
	SetButtonEventMappings unblock_menu_input 
ENDSCRIPT

SCRIPT goal_wait_and_show_key_combo_text 
	WaitForEvent type = panel_message_goal_done2 
	SetScreenElementLock id = current_goal on 
	SetScreenElementLock id = current_goal Off 
	SetScreenElementLock id = root_window Off 
	GetScreenElementPosition id = current_goal 
	<ScreenElementPos> = ( <ScreenElementPos> + PAIR(120.00000000000, 0.00000000000) ) 
	GetScreenElementDims id = current_goal 
	IF ScreenElementExists id = current_goal_key_combo_text 
		DestroyScreenElement id = current_goal_key_combo_text 
	ENDIF 
	CreateScreenElement { 
		type = TextBlockElement 
		parent = root_window 
		id = current_goal_key_combo_text 
		dims = PAIR(300.00000000000, 0.00000000000) 
		allow_expansion 
		z_priority = -5 
		font = small 
		scale = 1 
		rgba = [ 128 128 128 110 ] 
		text = <text> 
		pos = ( <ScreenElementPos> + ( PAIR(0.00000000000, 1.00000000000) * <height> / 0.77999997139 ) ) 
		just = [ center top ] 
		internal_just = [ center top ] 
		scale = 0.75000000000 
	} 
ENDSCRIPT

SCRIPT hide_key_combo_text 
	IF ObjectExists id = current_goal_key_combo_text 
		DoScreenElementMorph id = current_goal_key_combo_text time = 0 scale = 0 
	ENDIF 
ENDSCRIPT

SCRIPT unhide_key_combo_text 
	IF ObjectExists id = current_goal_key_combo_text 
		DoScreenElementMorph id = current_goal_key_combo_text time = 0 scale = 0.75000000000 
	ENDIF 
ENDSCRIPT

SCRIPT goal_description_and_speech 
	GoalManager_GetGoalParams name = <goal_id> 
	IF ScreenElementExists id = current_goal 
		DestroyScreenElement id = current_goal 
	ENDIF 
	IF ScreenElementExists id = current_goal_key_combo_text 
		DestroyScreenElement id = current_goal_key_combo_text 
	ENDIF 
	IF NOT GotParam null_goal 
		SpawnScript goal_wait_for_cam_anim params = <...> 
	ENDIF 
	<pro_name_text> = "" 
	IF GotParam cam_anim_speaker_name 
		FormatText TextName = pro_name_text "\\ca%s :\\c0\\n" s = <cam_anim_speaker_name> 
	ELSE 
		IF GotParam full_name 
			FormatText TextName = pro_name_text "\\ca%s :\\c0\\n" s = <full_name> 
		ELSE 
			IF GotParam pro 
				FormatText ChecksumName = pro_checksum "%s" s = <pro> 
				IF StructureContains structure = goal_pro_last_names <pro_checksum> 
					<pro_last_name> = ( goal_pro_last_names . <pro_checksum> ) 
					FormatText TextName = pro_name_text "\\ca%s %l :\\c0\\n" s = <pro> l = <pro_last_name> 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
	IF GotParam goal_description 
		IF IsArray <goal_description> 
			GetArraySize <goal_description> 
			<index> = 0 
			BEGIN 
				FormatText TextName = pro_name_text "%s%n" s = <pro_name_text> n = ( <goal_description> [ <index> ] ) 
				<index> = ( <index> + 1 ) 
			REPEAT <array_size> 
		ELSE 
			FormatText TextName = pro_name_text "%s%n" s = <pro_name_text> n = <goal_description> 
		ENDIF 
		FormatText TextName = pro_name_text "%s\\nPress \\m0 to continue." s = <pro_name_text> 
	ENDIF 
	IF NOT GotParam just_won_goal 
		IF GotParam goal_description 
			GetSkaterId 
			IF NOT SkaterCamAnimFinished skaterId = <ObjId> name = <anim> 
				IF ObjectExists id = speech_box_anchor 
					DestroyScreenElement id = speech_box_anchor 
				ENDIF 
				create_speech_box { 
					anchor_id = goal_description_anchor 
					text = <pro_name_text> 
					pos = <text_anchor_pos> 
					style = speech_box_style 
					bg_x_scale = 1.29999995232 
					pad_choose_script = goal_description_and_speech_continue 
					pad_choose_params = { no_pad_start anim = <anim> skippable = 0 } 
				} 
				goal_description_anchor : SetTags anim = <anim> 
				AssignAlias id = goal_description_anchor alias = current_goal_description 
				wait 60 frame 
				IF NOT SkaterCamAnimFinished skaterId = <ObjId> name = <anim> 
					GoalManager_PlayGoalStartStream { 
						name = <goal_id> 
						speaker_obj_id = <speaker_obj_id> 
						speaker_name = <speaker_name> 
						last_anim 
					} 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT goal_description_and_speech_continue 
	DeBounce x time = 0.30000001192 
	<should_kill_anim> = 1 
	IF ( ( GotParam anim ) & ( <should_kill_anim> = 1 ) ) 
		GetSkaterId 
		KillSkaterCamAnim skaterId = <ObjId> name = <anim> 
	ENDIF 
	IF GotParam no_pad_start 
		speech_box_exit anchor_id = goal_description_anchor no_pad_start 
	ELSE 
		speech_box_exit anchor_id = goal_description_anchor 
	ENDIF 
	FireEvent type = goal_description_and_speech_continue 
ENDSCRIPT

SCRIPT goal_wait_for_cam_anim 
	GetSkaterId 
	BEGIN 
		IF SkaterCamAnimFinished skaterId = <ObjId> name = <anim> 
			SpawnScript goal_show_tips params = { goal_id = <goal_id> } 
			IF NOT GotParam dont_show_goal_text 
				create_panel_block id = current_goal text = <goal_text> style = panel_message_goal params = <...> 
				IF GotParam key_combo_text 
					SpawnScript goal_wait_and_show_key_combo_text params = { text = <key_combo_text> } 
				ENDIF 
			ENDIF 
			BREAK 
		ENDIF 
		wait 10 one_per_frame 
	REPEAT 
ENDSCRIPT

SCRIPT goal_description_and_speech2 blink_time = 0.05000000075 
	SetProps just = [ center top ] internal_just = [ center center ] rgba = [ 128 128 128 128 ] 
	DoMorph pos = PAIR(320.00000000000, 114.00000000000) scale = 0 
	DoMorph pos = PAIR(320.00000000000, 114.00000000000) scale = 1.20000004768 time = 0.10000000149 
	DoMorph pos = PAIR(320.00000000000, 114.00000000000) scale = 0.80000001192 time = 0.10000000149 
	DoMorph pos = PAIR(320.00000000000, 114.00000000000) scale = 1 time = 0.10000000149 
	DoMorph pos = PAIR(320.00000000000, 114.00000000000) scale = 0.89999997616 time = 0.05000000075 
	DoMorph pos = PAIR(321.00000000000, 116.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(319.00000000000, 113.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 115.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(318.00000000000, 113.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 115.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(319.00000000000, 113.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 117.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(319.00000000000, 113.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(320.00000000000, 120.00000000000) scale = 1.25000000000 time = 0.10000000149 
	SetProps internal_just = [ center top ] rgba = [ 128 128 128 110 ] just = [ right top ] 
	DoMorph pos = PAIR(625.00000000000, 15.00000000000) scale = 0.77999997139 time = 0.05000000075 
	RunScriptOnScreenElement id = current_goal blink_current_goal params = { blink_time = <blink_time> } 
ENDSCRIPT

SCRIPT blink_current_goal 
	BEGIN 
		DoMorph alpha = 0 
		wait <blink_time> seconds 
		DoMorph alpha = 1 
		wait <blink_time> seconds 
	REPEAT 6 
ENDSCRIPT

SCRIPT GoalManager_InitGoalTrigger 
	GoalManager_GetGoalParams name = <name> 
	IF NOT IsAlive name = <trigger_obj_id> 
		create name = <trigger_obj_id> 
	ENDIF 
	<trigger_obj_id> : SetTags goal_id = <goal_id> 
	IF NOT GotParam quick_start 
		goal_add_ped_arrow goal_id = <goal_id> 
	ENDIF 
	goal_pro_stop_anim_scripts <...> 
	IF GotParam trigger_wait_script 
		<trigger_obj_id> : Obj_SpawnScript <trigger_wait_script> params = { goal_id = <goal_id> pro = <pro> } 
	ELSE 
		<trigger_obj_id> : Obj_SpawnScript GenericProWaiting params = { goal_id = <goal_id> type = "wait" pro = <pro> } 
	ENDIF 
	RunScriptOnObject id = <trigger_obj_id> goal_set_trigger_exceptions params = { goal_id = <goal_id> } 
ENDSCRIPT

SCRIPT goal_add_ped_arrow 
	GoalManager_GetGoalParams name = <goal_id> 
	IF NOT IsAlive name = <trigger_obj_id> 
		RETURN 
	ENDIF 
	IF NOT GotParam goal_ped_arrow_height 
		<goal_ped_arrow_height> = 100 
	ENDIF 
	<goal_arrow_pos> = ( VECTOR(0.00000000000, 1.00000000000, 0.00000000000) * <goal_ped_arrow_height> ) 
	IF GotParam trigger_arrow_model 
		<arrow> = <trigger_arrow_model> 
	ELSE 
		IF GotParam always_initialize_goal 
			<arrow> = "Special_Arrow" 
		ELSE 
			<arrow> = "arrow" 
		ENDIF 
	ENDIF 
	FormatText ChecksumName = arrow_id "%s_ped_arrow" s = <goal_name> 
	IF ScreenElementExists id = <arrow_id> 
		DestroyScreenElement id = <arrow_id> 
	ENDIF 
	SetScreenElementLock id = root_window Off 
	IF NOT IsTrue no_arrows 
		CreateScreenElement { 
			parent = root_window 
			type = Element3D 
			id = <arrow_id> 
			model = <arrow> 
			HoverParams = { Amp = 9.50000000000 Freq = 2.50000000000 } 
			AngVelY = 0.15999999642 
			ParentParams = { name = <trigger_obj_id> <goal_arrow_pos> IgnoreParentsYRotation } 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT goal_ped_kill_arrow 
	GoalManager_GetGoalParams name = <goal_id> 
	FormatText ChecksumName = arrow_id "%s_ped_arrow" s = <goal_name> 
	IF ScreenElementExists id = <arrow_id> 
		DestroyScreenElement id = <arrow_id> 
	ENDIF 
ENDSCRIPT

SCRIPT goal_set_trigger_exceptions trigger_radius = 16 avoid_radius = 3 
	IF ObjectExists id = goal_start_dialog 
		speech_box_exit anchor_id = goal_start_dialog 
	ENDIF 
	Obj_ClearException SkaterOutOfRadius 
	Obj_SetInnerRadius <trigger_radius> 
	Obj_SetException ex = SkaterInRadius scr = goal_got_trigger params = { goal_id = <goal_id> } 
	GoalManager_GetGoalParams name = <goal_id> 
	IF NOT GotParam dont_bounce_skater 
		Obj_SetInnerAvoidRadius <avoid_radius> 
		Obj_SetException ex = SkaterInAvoidRadius scr = goal_pro_bounce_skater params = { avoid_radius = <avoid_radius> goal_id = <goal_id> } 
	ENDIF 
ENDSCRIPT

SCRIPT goal_pro_bounce_skater speed = 88 
	GetSkaterId 
	<skaterId> = <ObjId> 
	IF NOT <skaterId> : IsLocalSkater 
		RETURN 
	ENDIF 
	IF <skaterId> : Driving 
		RETURN 
	ENDIF 
	GetSkaterState 
	Obj_ClearException SkaterInAvoidRadius 
	GetTags 
	SpawnScript goal_pro_wait_and_reset_avoid_exception params = { goal_id = <goal_id> trigger_obj_id = <id> } 
	<should_bounce_skater> = 1 
	IF SkaterCurrentScorePotGreaterThan 0 
		RETURN 
	ENDIF 
	IF NOT ( <state> = Skater_OnGround ) 
		RETURN 
	ENDIF 
	IF IsHidden 
		RETURN 
	ENDIF 
	root_window : GetTags 
	IF GotParam giving_rewards 
		IF ( <giving_rewards> = 1 ) 
			RETURN 
		ENDIF 
	ENDIF 
	IF Skater : SpeedGreaterThan 200 
		IF GotParam goal_id 
			GoalManager_PlayGoalStream name = <goal_id> type = "avoid" play_random 
		ENDIF 
		RETURN 
	ENDIF 
	Skater : GetTags 
	IF NOT ( <racemode> = None ) 
		RETURN 
	ENDIF 
	GetTags 
	Skater : Obj_GetOrientationToObject <id> 
	IF ( <dotProd> < 0.00000000000 ) 
		IF ( <dotProd> > -0.10000000149 ) 
			<speed> = 500 
			<heading> = 180 
		ELSE 
			<heading> = 90.00000000000 
		ENDIF 
	ELSE 
		IF ( <dotProd> < 0.10000000149 ) 
			<speed> = 500 
			<heading> = 180 
		ELSE 
			<heading> = -90 
		ENDIF 
	ENDIF 
	SkaterAvoidGoalPed heading = <heading> speed = <speed> 
	IF GotParam collision_exception_return_state 
		goto <collision_exception_return_state> 
	ENDIF 
ENDSCRIPT

SCRIPT goal_pro_wait_and_reset_avoid_exception 
	wait 20 gameframe 
	RunScriptOnObject { 
		id = <trigger_obj_id> 
		goal_trigger_reset_avoid_radius_exception 
		params = { goal_id = <goal_id> } 
	} 
ENDSCRIPT

SCRIPT goal_trigger_reset_avoid_radius_exception 
	Obj_SetException ex = SkaterInAvoidRadius scr = goal_pro_bounce_skater params = { goal_id = <goal_id> } 
ENDSCRIPT

SCRIPT goal_got_trigger 
	GetSkaterId 
	<skaterId> = <ObjId> 
	IF GoalManager_HasWonGoal name = <goal_id> 
		RETURN 
	ENDIF 
	IF GoalManager_GoalIsActive name = <goal_id> 
		RETURN 
	ENDIF 
	IF CustomParkMode editing 
		RETURN 
	ENDIF 
	IF ObjectExists id = goal_start_dialog 
		<should_destroy> = 0 
		IF <skaterId> : IsInBail 
			<should_destroy> = 1 
		ENDIF 
		IF SkaterCurrentScorePotGreaterThan 0 
			<should_destroy> = 1 
		ENDIF 
		IF <skaterId> : Driving 
			<should_destroy> = 1 
		ENDIF 
		IF NOT GoalManager_CanStartGoal 
			<should_destroy> = 1 
		ENDIF 
		IF ( <should_destroy> = 1 ) 
			DestroyScreenElement id = goal_start_dialog 
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
		IF GoalManager_CanStartGoal name = <goal_id> 
			<skater_ready_for_goal> = 0 
			IF NOT <skaterId> : Driving 
				IF <skaterId> : Skating 
					IF <skaterId> : OnGround 
						<skater_ready_for_goal> = 1 
					ENDIF 
				ELSE 
					IF <skaterId> : Walk_Ground 
						<skater_ready_for_goal> = 1 
					ENDIF 
				ENDIF 
			ENDIF 
			IF ( <skater_ready_for_goal> = 1 ) 
				IF NOT <skaterId> : IsInBail 
					IF NOT SkaterCurrentScorePotGreaterThan 0 
						GoalManager_GetGoalParams name = <goal_id> 
						<trigger_obj_id> : Obj_SetOuterRadius 20 
						<trigger_obj_id> : Obj_SetException ex = SkaterOutOfRadius scr = goal_trigger_refuse params = { goal_id = <goal_id> } 
						IF ( InNetGame ) 
							<quick_start_text> = "\\n\\m7 to quick start." 
							<pad_square_script> = goal_accept_trigger 
							<pad_square_params> = { goal_id = <goal_id> quick_start } 
						ELSE 
							<quick_start_text> = "" 
						ENDIF 
						IF GotParam full_name 
							FormatText TextName = accept_text "%f: \\m5 to talk.%q" f = <full_name> q = <quick_start_text> 
						ELSE 
							IF GotParam pro 
								FormatText ChecksumName = name_checksum "%s" s = <pro> 
								<last_name> = ( goal_pro_last_names . <name_checksum> ) 
								IF GotParam last_name 
									FormatText TextName = accept_text "%s %l: \\m5 to talk.%q" s = <pro> l = <last_name> q = <quick_start_text> 
								ELSE 
									FormatText TextName = accept_text "%s: \\m5 to talk.%q" s = <pro> q = <quick_start_text> 
								ENDIF 
							ELSE 
								FormatText TextName = accept_text "\\m5 to talk.%q" q = <quick_start_text> 
							ENDIF 
						ENDIF 
						create_speech_box { 
							anchor_id = goal_start_dialog 
							text = <accept_text> 
							no_pad_choose 
							no_pad_start 
							pad_circle_script = goal_accept_trigger 
							pad_circle_params = { goal_id = <goal_id> } 
							pad_square_script = <pad_square_script> 
							pad_square_params = <pad_square_params> 
							bg_rgba = [ 100 100 100 128 ] 
							text_rgba = [ 128 128 128 128 ] 
							font = small 
							z_priority = 5 
						} 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT goal_trigger_refuse anchor_id = goal_start_dialog 
	Obj_ClearException SkaterOutOfRadius 
	speech_box_exit anchor_id = <anchor_id> 
	GoalManager_ResetGoalTrigger name = <goal_id> 
ENDSCRIPT

SCRIPT goal_accept_trigger 
	DeBounce x time = 0.50000000000 
	speech_box_exit anchor_id = goal_start_dialog 
	goal_check_for_required_tricks goal_id = <goal_id> 
	IF ( <found_unmapped_trick> = 1 ) 
		GoalManager_GetGoalParams name = <goal_id> 
		IF IsAlive name = <trigger_obj_id> 
			<trigger_obj_id> : Obj_ClearException SkaterInRadius 
		ENDIF 
		RETURN 
	ENDIF 
	IF GotParam force_start 
		IF NOT GoalManager_GoalInitialized name = <goal_id> 
			GoalManager_InitializeGoal name = <goal_id> 
		ENDIF 
		GoalManager_ResetGoalTrigger name = <goal_id> no_new_exceptions 
		IF IsAlive name = <trigger_obj_id> 
			<trigger_obj_id> : Obj_ClearException SkaterInRadius 
		ENDIF 
		GoalManager_DeactivateAllGoals 
		GoalManager_ActivateGoal name = <goal_id> <...> 
		RETURN 
	ENDIF 
	IF NOT SkaterCurrentScorePotGreaterThan 0 
		IF GoalManager_CanStartGoal name = <goal_id> 
			GetSkaterId 
			IF <ObjId> : OnGround 
				IF SkaterCurrentScorePotLessThan 1 
					IF <ObjId> : OnGround 
						GoalManager_GetGoalParams name = <goal_id> 
						GoalManager_ResetGoalTrigger name = <goal_id> no_new_exceptions 
						IF IsAlive name = <trigger_obj_id> 
							<trigger_obj_id> : Obj_ClearException SkaterInRadius 
						ENDIF 
						GoalManager_DeactivateAllGoals 
						IF GotParam quick_start 
							GoalManager_QuickStartGoal name = <goal_id> 
						ELSE 
							GoalManager_ActivateGoal name = <goal_id> <...> 
						ENDIF 
					ELSE 
						IF NOT <ObjId> : RightPressed 
							IF NOT <ObjId> : LeftPressed 
								IF NOT <ObjId> : UpPressed 
									IF NOT <ObjId> : DownPressed 
										GoalManager_GetGoalParams name = <goal_id> 
										GoalManager_ResetGoalTrigger name = <goal_id> no_new_exceptions 
										IF IsAlive name = <trigger_obj_id> 
											<trigger_obj_id> : Obj_ClearException SkaterInRadius 
										ENDIF 
										GoalManager_DeactivateAllGoals 
										IF GotParam quick_start 
											GoalManager_QuickStartGoal name = <goal_id> 
										ELSE 
											GoalManager_ActivateGoal name = <goal_id> <...> 
										ENDIF 
									ENDIF 
								ENDIF 
							ENDIF 
						ENDIF 
					ENDIF 
				ENDIF 
			ELSE 
				IF NOT <ObjId> : RightPressed 
					IF NOT <ObjId> : LeftPressed 
						IF NOT <ObjId> : UpPressed 
							IF NOT <ObjId> : DownPressed 
								GoalManager_GetGoalParams name = <goal_id> 
								GoalManager_ResetGoalTrigger name = <goal_id> no_new_exceptions 
								IF IsAlive name = <trigger_obj_id> 
									<trigger_obj_id> : Obj_ClearException SkaterInRadius 
								ENDIF 
								GoalManager_DeactivateAllGoals 
								IF GotParam quick_start 
									GoalManager_QuickStartGoal name = <goal_id> 
								ELSE 
									GoalManager_ActivateGoal name = <goal_id> <...> 
								ENDIF 
							ENDIF 
						ENDIF 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT GoalManager_ResetGoalTrigger 
	IF GotParam goal_id 
		GoalManager_GetGoalParams name = <goal_id> 
	ELSE 
		GoalManager_GetGoalParams name = <name> 
	ENDIF 
	IF IsAlive name = <trigger_obj_id> 
		<trigger_obj_id> : Obj_ClearException SkaterInRadius 
		IF NOT GotParam no_new_exceptions 
			IF NOT GotParam just_won_goal 
				RunScriptOnObject id = <trigger_obj_id> goal_set_trigger_exceptions params = { goal_id = <goal_id> } 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT goal_check_for_required_tricks 
	<found_unmapped_trick> = 0 
	GoalManager_GetGoalParams name = <goal_id> 
	IF GotParam required_tricks 
		FormatText TextName = warning_string "You do not have all the tricks you will need to complete this goal. You will need to assign:" 
		GetArraySize <required_tricks> 
		<index> = 0 
		BEGIN 
			IF NOT GetKeyComboBoundToTrick trick = ( <required_tricks> [ <index> ] ) 
				IF NOT GetKeyComboBoundToTrick trick = ( <required_tricks> [ <index> ] ) special 
					<trick_name> = ( <required_tricks> [ <index> ] ) 
					<trick_params> = ( <trick_name> . params ) 
					<trick_string> = ( <trick_params> . name ) 
					IF ( <found_unmapped_trick> = 0 ) 
						FormatText TextName = warning_string "%s\\n%t" s = <warning_string> t = <trick_string> 
					ELSE 
						FormatText TextName = warning_string "%s, %t" s = <warning_string> t = <trick_string> 
					ENDIF 
					<found_unmapped_trick> = 1 
				ENDIF 
			ENDIF 
			<index> = ( <index> + 1 ) 
		REPEAT <array_size> 
	ENDIF 
	IF ( <found_unmapped_trick> = 1 ) 
		PauseGame 
		create_error_box { title = "WARNING!" 
			text = <warning_string> 
			text_dims = PAIR(400.00000000000, 0.00000000000) 
			bg_scale = 1.20000004768 
			buttons = [ { text = "Edit Tricks" pad_choose_script = goal_unmapped_tricks_box_accept } 
				{ text = "Skip this challenge" pad_choose_script = goal_unmapped_tricks_box_exit pad_choose_params = { goal_id = <goal_id> } } 
			] 
		} 
	ENDIF 
	RETURN found_unmapped_trick = <found_unmapped_trick> 
ENDSCRIPT

SCRIPT goal_unmapped_tricks_box_accept 
	dialog_box_exit 
	create_edit_tricks_menu 
ENDSCRIPT

SCRIPT goal_unmapped_tricks_box_exit 
	GoalManager_ResetGoalTrigger name = <goal_id> 
	dialog_box_exit 
	UnpauseGame 
ENDSCRIPT

SCRIPT goal_got_trickslot 
	create_panel_message { 
		id = goal_current_reward 
		text = "You got a new special trick slot" 
		style = goal_message_got_trickslot 
	} 
ENDSCRIPT

SCRIPT goal_got_cash 
	FormatText TextName = message "You got $%i!" i = <amount> 
	create_panel_message { 
		id = goal_current_reward 
		text = <message> 
		style = goal_message_got_stat 
		params = { sound = cash } 
	} 
ENDSCRIPT

SCRIPT goal_got_all_goals 
	StopStream 
	PlayStream FoundAllGaps vol = 150 
	unlock_all_cheat_codes 
	unlock_all_gameplay_cheat_codes 
	StopStream 
	PlayStream FoundAllGaps vol = 150 
	<text> = "Way to go back and clean out the story goals. \\n\\nYou\'ve unlocked \\c3new cheats\\c0 to help you take it further. Access them from the Pause menu under Options. Good luck!" 
	create_dialog_box { title = "All Goals" 
		text = <text> 
		pos = PAIR(310.00000000000, 225.00000000000) 
		just = [ center center ] 
		text_rgba = [ 88 105 112 128 ] 
		text_dims = PAIR(400.00000000000, 0.00000000000) 
		buttons = [ { font = small text = "OK" pad_choose_script = goal_got_all_goals_accept } ] 
		delay_input 
	} 
ENDSCRIPT

SCRIPT goal_got_all_goals_accept 
	dialog_box_exit 
	FireEvent type = goal_got_all_goals_done 
ENDSCRIPT

SCRIPT goal_play_stream 
	IF GotParam streamId 
		BEGIN 
			IF PreLoadStreamDone <streamId> 
				BREAK 
			ENDIF 
			wait 1 frame 
		REPEAT 
	ENDIF 
	IF GotParam play_anim 
		AddAnimController { 
			type = partialAnim 
			id = jawRotation 
			animName = <stream_checksum> 
			from = start 
			to = end 
			speed = 1.00000000000 
		} 
	ENDIF 
	IF GotParam streamId 
		StartPreloadedStream { 
			streamId = <streamId> 
			volume = 190 
		} 
	ELSE 
		Obj_PlayStream { 
			<stream_checksum> 
			vol = 120 
			dropoff = 300 
			use_pos_info = <use_pos_info> 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT goal_turn_pro 
	create_panel_block text = "You just turned pro\\n" 
ENDSCRIPT

SCRIPT goal_init_after_end_of_run 
	IF NOT GoalManager_GoalExists name = <goal_id> 
		RETURN 
	ENDIF 
	GoalManager_GetGoalParams name = <goal_id> 
	IF GotParam competition 
		RETURN 
	ENDIF 
	GetSkaterId 
	BEGIN 
		IF GoalManager_GoalExists name = <goal_id> 
			IF GoalManager_FinishedEndOfRun name = <goal_id> 
				GoalManager_ClearEndRun name = <goal_id> 
				IF <ObjId> : Skating 
					MakeSkaterGoto OnGroundAI 
				ENDIF 
				IF InNetGame 
					<ObjId> : NetEnablePlayerInput 
				ELSE 
					<ObjId> : EnablePlayerInput 
				ENDIF 
				BREAK 
			ENDIF 
		ELSE 
			BREAK 
		ENDIF 
		wait 1 frame 
	REPEAT 
ENDSCRIPT

SCRIPT goal_stats_menu_exit 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
		SetScreenElementProps { 
			id = root_window 
			tags = { menu_state = Off } 
		} 
		wait 1 frame 
	ENDIF 
	restore_start_key_binding 
	goalmanager_showpoints 
	GoalManager_ShowGoalPoints 
	FireEvent type = goal_stats_menu_done 
ENDSCRIPT

SCRIPT goal_new_level_unlocked 
	DeBounce x time = 0.30000001192 
	FormatText TextName = dialog_box_text "You have enough goal points to go to a new level." 
	PlayStream UnlockLevel vol = 150 
	create_snazzy_dialog_box { text = <dialog_box_text> 
		title = "Congratulations!" 
		buttons = [ { text = "Change Level" pad_choose_script = goal_new_level_accept } 
			{ text = "Keep Playing" pad_choose_script = goal_new_level_reject } 
		] 
	} 
ENDSCRIPT

SCRIPT goal_new_level_accept 
	dialog_box_exit 
	launch_level_select_menu chose_same_level_script = goal_new_level_reject pad_back_script = goal_new_level_reject no_cam_anim 
ENDSCRIPT

SCRIPT goal_new_level_reject 
	dialog_box_exit 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	SetScreenElementProps { 
		id = root_window 
		tags = { menu_state = Off } 
	} 
	FireEvent type = goal_new_level_unlocked_done 
ENDSCRIPT

SCRIPT goal_want_to_save 
	GetValueFromVolume cdvol 
	root_window : SetTags menu_state = on 
	hide_console_window 
	pause_trick_text 
	destroy_goal_panel_messages 
	GoalManager_SetCanStartGoal 0 
	pause_rain 
	DeBounce x time = 0.30000001192 
	PauseGame 
	kill_start_key_binding 
	FormatText TextName = dialog_box_text "Do you want to save now?" 
	create_snazzy_dialog_box { text = <dialog_box_text> 
		title = "" 
		buttons = [ { text = "Yes" pad_choose_script = goal_save_accept } 
			{ text = "No" pad_choose_script = goal_save_reject } 
		] 
		pad_back_script = goal_save_reject 
	} 
	AssignAlias id = dialog_box_anchor alias = current_menu_anchor 
	create_helper_text generic_helper_text 
ENDSCRIPT

SCRIPT goal_save_accept 
	dialog_box_exit 
	kill_start_key_binding 
	launch_beat_goal_save_game_sequence pad_back_script = goal_save_reject no_cam_anim 
ENDSCRIPT

SCRIPT goal_save_reject 
	UnpauseGame 
	GoalManager_SetCanStartGoal 1 
	restore_start_key_binding 
	dialog_box_exit 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	SetScreenElementProps { 
		id = root_window 
		tags = { menu_state = Off } 
	} 
	root_window : SetTags menu_state = Off 
	unpause_rain 
	unhide_console_window 
	unpause_trick_text 
	FireEvent type = goal_wait_for_save 
ENDSCRIPT

SCRIPT goal_create_counter 
	SetScreenElementLock id = root_window Off 
	goal_destroy_counter 
	CreateScreenElement { 
		type = ContainerElement 
		parent = root_window 
		id = goal_counter_anchor 
		dims = PAIR(640.00000000000, 480.00000000000) 
		pos = PAIR(305.00000000000, 320.00000000000) 
	} 
	<root_pos> = PAIR(550.00000000000, 90.00000000000) 
	FormatText ChecksumName = rgba_off "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = rgba_on "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	CreateScreenElement { 
		type = TextElement 
		parent = goal_counter_anchor 
		id = goal_counter_number_collected 
		font = small 
		text = "0" 
		pos = <root_pos> 
		just = [ center top ] 
		scale = 0.89999997616 
		rgba = <rgba_on> 
	} 
	IF GoalManager_GetNumberOfFlags name = <goal_id> 
		<total_number> = <number_of_flags> 
	ELSE 
		GoalManager_GetGoalParams name = <goal_id> 
		IF GotParam number 
			<total_number> = <number> 
		ELSE 
			IF GotParam num_gaps_to_find 
				<total_number> = <num_gaps_to_find> 
			ELSE 
				script_assert "Couldn\'t find number param.  Are the params for the hud counter setup?" 
			ENDIF 
		ENDIF 
	ENDIF 
	FormatText TextName = total_number "%i" i = <total_number> 
	CreateScreenElement { 
		type = TextElement 
		parent = goal_counter_anchor 
		id = goal_counter_number_total 
		rgba = <rgba_off> 
		font = small 
		text = <total_number> 
		pos = ( <root_pos> + PAIR(47.00000000000, 0.00000000000) ) 
		just = [ center top ] 
		scale = 0.89999997616 
	} 
	FormatText ChecksumName = bg_rgba "%i_SPEECH_BOX_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	CreateScreenElement { 
		type = SpriteElement 
		parent = goal_counter_anchor 
		id = mini_score_hud_box 
		texture = mini_score_hud 
		pos = ( <root_pos> - PAIR(25.00000000000, 6.00000000000) ) 
		just = [ left top ] 
		scale = PAIR(1.47000002861, 1.00000000000) 
		rgba = <bg_rgba> 
	} 
	IF GotParam hud_counter_caption 
		GetStackedScreenElementPos Y id = <id> offset = PAIR(48.00000000000, -12.00000000000) 
		CreateScreenElement { 
			type = TextBlockElement 
			parent = goal_counter_anchor 
			id = goal_counter_caption 
			font = small 
			text = <hud_counter_caption> 
			rgba = [ 128 128 128 108 ] 
			pos = <pos> 
			just = [ center top ] 
			scale = 0.80000001192 
			line_spacing = 0.60000002384 
			dims = PAIR(117.50000000000, 0.00000000000) 
			allow_expansion 
		} 
	ENDIF 
	goal_update_counter <...> 
ENDSCRIPT

SCRIPT goal_update_counter 
	GoalManager_GetNumberCollected name = <goal_id> 
	IF NOT ScreenElementExists id = goal_counter_number_collected 
		RETURN 
	ENDIF 
	FormatText TextName = new_number_collected "%i" i = <number_collected> 
	SetScreenElementProps { 
		id = goal_counter_number_collected 
		text = <new_number_collected> 
	} 
	GoalManager_GetGoalParams name = <goal_id> 
	IF GotParam hud_counter_caption 
		IF ScreenElementExists id = goal_counter_caption 
			SetScreenElementProps { 
				id = goal_counter_caption 
				text = <hud_counter_caption> 
			} 
		ENDIF 
	ENDIF 
	KillSpawnedScript name = mini_hud_anim 
	RunScriptOnScreenElement id = goal_counter_number_collected mini_hud_anim 
ENDSCRIPT

SCRIPT goal_destroy_counter 
	IF ObjectExists id = goal_counter_anchor 
		DestroyScreenElement id = goal_counter_anchor 
	ENDIF 
ENDSCRIPT

SCRIPT mini_hud_anim 
	DoMorph time = 0.07999999821 scale = 0 alpha = 0 
	DoMorph time = 0.11999999732 scale = 1.29999995232 alpha = 1 
	DoMorph time = 0.14000000060 scale = 0.69999998808 
	DoMorph time = 0.15999999642 scale = 0.89999997616 
ENDSCRIPT

SCRIPT goal_got_flag_sound 
	PlaySound GoalMidGood vol = 200 
ENDSCRIPT

goal_panel_message_ids = [ 
	goal_complete 
	goal_complete_line2 
	goal_complete_sprite 
	current_goal 
	goal_message 
	GoalFail 
	goalfail_sprite 
	goalfailedline2 
	goal_tip 
	new_goal_message 
	new_goal_sprite 
	tetris_menu_anchor 
	current_horse_spot 
	goal_counter_anchor 
	goal_instruction1 
	goal_film_update_message 
	skater_hint 
	death_message 
	perfect 
	perfect2 
	goal_current_reward 
	Eric_text 
] 
SCRIPT hide_goal_panel_messages 
	GetArraySize goal_panel_message_ids 
	<index> = 0 
	BEGIN 
		IF NOT ( ( goal_panel_message_ids [ <index> ] ) = current_goal ) 
			hide_panel_message id = ( goal_panel_message_ids [ <index> ] ) 
		ENDIF 
		<index> = ( <index> + 1 ) 
	REPEAT <array_size> 
ENDSCRIPT

SCRIPT show_goal_panel_messages 
	GetArraySize goal_panel_message_ids 
	<index> = 0 
	BEGIN 
		show_panel_message id = ( goal_panel_message_ids [ <index> ] ) 
		<index> = ( <index> + 1 ) 
	REPEAT <array_size> 
ENDSCRIPT

SCRIPT destroy_goal_panel_messages 
	GetArraySize goal_panel_message_ids 
	IF GotParam all 
		<index> = 0 
	ELSE 
		<index> = 3 
		<array_size> = ( <array_size> - 3 ) 
	ENDIF 
	IF ( <index> < <array_size> ) 
		BEGIN 
			destroy_panel_message id = ( goal_panel_message_ids [ <index> ] ) 
			<index> = ( <index> + 1 ) 
		REPEAT <array_size> 
	ENDIF 
ENDSCRIPT

SCRIPT GoalManager_HidePoints 
	DoScreenElementMorph { 
		id = the_score_sprite 
		alpha = 0 
	} 
	DoScreenElementMorph { 
		id = the_score 
		alpha = 0 
	} 
	IF ScreenElementExists id = player2_panel_container 
		DoScreenElementMorph id = player2_panel_container time = 0 scale = 0 
	ENDIF 
ENDSCRIPT

SCRIPT goalmanager_showpoints 
	IF NOT GetGlobalFlag flag = NO_DISPLAY_HUD 
		IF CustomParkMode editing 
		ELSE 
			DoScreenElementMorph { 
				id = the_score_sprite 
				alpha = 1 
			} 
			DoScreenElementMorph { 
				id = the_score 
				alpha = 1 
			} 
			IF ScreenElementExists id = player2_panel_container 
				DoScreenElementMorph id = player2_panel_container time = 0 scale = 1 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT GoalManager_HideGoalPoints 
	DoScreenElementMorph { 
		id = cash_goal_sprite 
		alpha = 0 
	} 
	DoScreenElementMorph { 
		id = cash_text 
		alpha = 0 
	} 
	DoScreenElementMorph { 
		id = goal_points_text 
		alpha = 0 
	} 
ENDSCRIPT

SCRIPT GoalManager_ShowGoalPoints 
	IF CustomParkMode editing 
		RETURN 
	ENDIF 
	IF InMultiplayerGame 
		RETURN 
	ENDIF 
	IF GameModeEquals is_singlesession 
		RETURN 
	ENDIF 
	IF GameModeEquals is_freeskate 
		RETURN 
	ENDIF 
	DoScreenElementMorph { 
		id = cash_goal_sprite 
		alpha = 1 
	} 
	GoalManager_GetCash 
	FormatText TextName = cash "%i" i = <cash> 
	SetScreenElementProps { 
		id = cash_text 
		text = <cash> 
	} 
	DoScreenElementMorph { 
		id = cash_text 
		alpha = 1 
	} 
	GoalManager_GetNumberOfGoalPoints total 
	FormatText TextName = goal_points "%i" i = <goal_points> 
	SetScreenElementProps { 
		id = goal_points_text 
		text = <goal_points> 
	} 
	DoScreenElementMorph { 
		id = goal_points_text 
		alpha = 1 
	} 
ENDSCRIPT

SCRIPT goal_show_tips 
	WaitForEvent type = panel_message_goal_done 
	GoalManager_GetGoalParams name = <goal_id> 
	<tip_pos> = PAIR(320.00000000000, 140.00000000000) 
	IF NOT GotParam goal_tips 
		RETURN 
	ENDIF 
	IF NOT GotParam goal_tip_interval 
		goal_tip_interval = 5 
	ENDIF 
	GoalManager_GetNumberOfTimesGoalStarted name = <goal_id> 
	GetArraySize <goal_tips> 
	IF ( <array_size> = 0 ) 
		RETURN 
	ENDIF 
	tips_index = ( <array_size> - 1 ) 
	current_multiple = ( <goal_tip_interval> * <array_size> ) 
	IF ( <times_started> = 0 ) 
		RETURN 
	ENDIF 
	IF NOT ( ( ( <times_started> / <goal_tip_interval> ) * <goal_tip_interval> ) = <times_started> ) 
		RETURN 
	ENDIF 
	times_started = ( <times_started> - ( <times_started> / <current_multiple> ) * <current_multiple> ) 
	BEGIN 
		IF ( ( ( <times_started> / <current_multiple> ) * <current_multiple> ) = <times_started> ) 
			create_panel_block id = goal_tip text = ( <goal_tips> [ <tips_index> ] ) pos = <tip_pos> style = panel_message_tips just = [ center top ] 
			BREAK 
		ELSE 
			tips_index = ( <tips_index> - 1 ) 
			current_multiple = ( <current_multiple> - <goal_tip_interval> ) 
		ENDIF 
	REPEAT <array_size> 
ENDSCRIPT

SCRIPT goal_no_valid_key_combos 
	create_panel_message text = "You don\'t know enough tricks!  Come back when you\'ve learned something." 
	GoalManager_DeactivateGoal name = <goal_id> 
ENDSCRIPT

SCRIPT AddGoal_Null 
	IF GotParam version 
		FormatText TextName = goal_type "Null%v" v = <version> 
	ELSE 
		<goal_type> = "Null" 
	ENDIF 
	GoalManager_CreateGoalName goal_type = <goal_type> 
	GoalManager_AddGoal name = <goal_id> params = { <...> null_goal unlocked_by_another } 
ENDSCRIPT

SCRIPT AddGoal_Combo 
	IF GotParam version 
		FormatText TextName = goal_type "Combo%v" v = <version> 
		IF NOT GotParam letter_info 
			FormatText ChecksumName = c_obj_id "TRG_Goal_COMBO_C%v" v = <version> 
			FormatText ChecksumName = o_obj_id "TRG_Goal_COMBO_O%v" v = <version> 
			FormatText ChecksumName = m_obj_id "TRG_Goal_COMBO_M%v" v = <version> 
			FormatText ChecksumName = b_obj_id "TRG_Goal_COMBO_B%v" v = <version> 
			FormatText ChecksumName = o2_obj_id "TRG_Goal_COMBO_O2%v" v = <version> 
			letter_info = [ 
				{ obj_id = <c_obj_id> text = "C" } 
				{ obj_id = <o_obj_id> text = "O" } 
				{ obj_id = <m_obj_id> text = "M" } 
				{ obj_id = <b_obj_id> text = "B" } 
				{ obj_id = <o2_obj_id> text = "O" } 
			] 
		ENDIF 
		FormatText ChecksumName = trigger_obj_id "TRG_G_COMBO%v_Pro" v = <version> 
		FormatText ChecksumName = restart_node "TRG_G_COMBO%v_RestartNode" v = <version> 
	ELSE 
		<goal_type> = "Combo" 
	ENDIF 
	GoalManager_CreateGoalName goal_type = <goal_type> 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_amateurCOMBOline_genericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_ProCombo 
	GoalManager_CreateGoalName goal_type = "ProCombo" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_ProComboLine_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_MedCombo 
	GoalManager_CreateGoalName goal_type = "MedCombo" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_MedComboLine_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_Skate 
	IF GotParam version 
		FormatText TextName = goal_type "Skate%v" v = <version> 
		FormatText ChecksumName = trigger_obj_id "TRG_G_SKATE%v_Pro" v = <version> 
		FormatText ChecksumName = s_obj_id "TRG_Goal_Letter_S%v" v = <version> 
		FormatText ChecksumName = k_obj_id "TRG_Goal_Letter_K%v" v = <version> 
		FormatText ChecksumName = a_obj_id "TRG_Goal_Letter_A%v" v = <version> 
		FormatText ChecksumName = t_obj_id "TRG_Goal_Letter_T%v" v = <version> 
		FormatText ChecksumName = e_obj_id "TRG_Goal_Letter_E%v" v = <version> 
		FormatText ChecksumName = restart_node "TRG_G_SKATE%v_RestartNode" v = <version> 
	ELSE 
		<goal_type> = "Skate" 
	ENDIF 
	GoalManager_CreateGoalName goal_type = <goal_type> 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_SkateLetters_genericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_HighScore 
	GoalManager_CreateGoalName goal_type = "HighScore" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_HighScore_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_GenericScore 
	IF GotParam version 
		FormatText TextName = goal_type "GenericScore%v" v = <version> 
		FormatText ChecksumName = trigger_obj_id "TRG_G_GS%v_Pro" v = <version> 
		FormatText ChecksumName = restart_node "TRG_G_GS%v_RestartNode" v = <version> 
	ELSE 
		<goal_type> = "GenericScore" 
	ENDIF 
	GoalManager_CreateGoalName goal_type = <goal_type> 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_GenericScore_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_ProScore 
	GoalManager_CreateGoalName goal_type = "ProScore" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_ProScore_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_SickScore 
	GoalManager_CreateGoalName goal_type = "SickScore" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_SickScore_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_Collect 
	IF GotParam version 
		FormatText TextName = goal_type "Collect%v" v = <version> 
		FormatText ChecksumName = restart_node "TRG_G_Collect%v_RestartNode" v = <version> 
		FormatText ChecksumName = trigger_obj_id "TRG_G_Collect%v_Pro" v = <version> 
	ELSE 
		<goal_type> = "Collect" 
	ENDIF 
	IF GotParam career_only 
		IF InNetGame 
			RETURN 
		ENDIF 
	ENDIF 
	GoalManager_CreateGoalName goal_type = <goal_type> 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_Collect_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_Collect2 
	IF GotParam career_only 
		IF InNetGame 
			RETURN 
		ENDIF 
	ENDIF 
	GoalManager_CreateGoalName goal_type = "Collect2" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_Collect2_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_Collect3 
	IF GotParam career_only 
		IF InNetGame 
			RETURN 
		ENDIF 
	ENDIF 
	GoalManager_CreateGoalName goal_type = "Collect3" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_Collect3_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_Collect4 
	IF GotParam career_only 
		IF InNetGame 
			RETURN 
		ENDIF 
	ENDIF 
	GoalManager_CreateGoalName goal_type = "Collect4" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_Collect4_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_Collect5 
	IF GotParam career_only 
		IF InNetGame 
			RETURN 
		ENDIF 
	ENDIF 
	GoalManager_CreateGoalName goal_type = "Collect5" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_Collect5_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_Collect6 
	IF GotParam career_only 
		IF InNetGame 
			RETURN 
		ENDIF 
	ENDIF 
	GoalManager_CreateGoalName goal_type = "Collect6" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_Collect6_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_UntimedCollect 
	IF GotParam version 
		FormatText TextName = goal_type "UntimedCollect%v" v = <version> 
		FormatText ChecksumName = restart_node "TRG_G_UntimedCollect%v_RestartNode" v = <version> 
		FormatText ChecksumName = trigger_obj_id "TRG_G_UntimedCollect%v_Pro" v = <version> 
	ELSE 
		<goal_type> = "UntimedCollect" 
	ENDIF 
	IF GotParam career_only 
		IF InNetGame 
			RETURN 
		ENDIF 
	ENDIF 
	GoalManager_CreateGoalName goal_type = <goal_type> 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_UntimedCollect_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_Film 
	IF GotParam version 
		FormatText TextName = goal_type "Film%v" v = <version> 
		FormatText ChecksumName = restart_node "TRG_G_Film%v_RestartNode" v = <version> 
		FormatText ChecksumName = trigger_obj_id "TRG_G_Film%v_Pro" v = <version> 
	ELSE 
		<goal_type> = "Film" 
	ENDIF 
	IF GotParam career_only 
		IF InNetGame 
			RETURN 
		ENDIF 
	ENDIF 
	GoalManager_CreateGoalName goal_type = <goal_type> 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_Film_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_Competition 
	IF GotParam version 
		FormatText TextName = goal_type "Comp%v" v = <version> 
		FormatText ChecksumName = trigger_obj_id "TRG_G_JUDGE_COMP%v" v = <version> 
		FormatText TextName = geo_prefix "G_COMP%v" v = <version> 
		FormatText ChecksumName = restart_node "TRG_G_COMP%v_RestartNode" v = <version> 
	ELSE 
		<goal_type> = "Comp" 
	ENDIF 
	IF GotParam career_only 
		IF InNetGame 
			RETURN 
		ENDIF 
	ENDIF 
	GoalManager_CreateGoalName goal_type = <goal_type> 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_Comp_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_Competition2 
	IF GotParam career_only 
		IF InNetGame 
			RETURN 
		ENDIF 
	ENDIF 
	GoalManager_CreateGoalName goal_type = "Comp2" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_Comp2_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_Trickspot 
	IF GotParam version 
		FormatText TextName = goal_type "Trickspot%v" v = <version> 
		FormatText ChecksumName = trigger_obj_id "TRG_G_TS%v_Pro" v = <version> 
		FormatText ChecksumName = restart_node "TRG_G_TS%v_RestartNode" v = <version> 
	ELSE 
		<goal_type> = "Trickspot" 
	ENDIF 
	GoalManager_CreateGoalName goal_type = <goal_type> 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_Trickspot_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_Trickspot2 
	GoalManager_CreateGoalName goal_type = "Trickspot2" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_Trickspot2_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_Trickspot3 
	GoalManager_CreateGoalName goal_type = "Trickspot3" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_Trickspot3_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_Trickspot4 
	GoalManager_CreateGoalName goal_type = "Trickspot4" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_Trickspot4_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_Trickspot5 
	GoalManager_CreateGoalName goal_type = "Trickspot5" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_Trickspot5_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_Gaps 
	IF GotParam version 
		FormatText TextName = goal_type "GAps%v" v = <version> 
		FormatText ChecksumName = trigger_obj_id "TRG_G_GAP%v_Pro" v = <version> 
		FormatText ChecksumName = restart_node "TRG_G_GAP%v_RestartNode" v = <version> 
	ELSE 
		<goal_type> = "GAps" 
	ENDIF 
	GoalManager_CreateGoalName goal_type = <goal_type> 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_Gaps_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_Gaps2 
	GoalManager_CreateGoalName goal_type = "GAps2" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_Gaps2_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_Gaps3 
	GoalManager_CreateGoalName goal_type = "GAps3" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_Gaps3_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_Gaps4 
	GoalManager_CreateGoalName goal_type = "GAps4" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_Gaps4_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_Gaps5 
	GoalManager_CreateGoalName goal_type = "GAps5" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_Gaps5_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_Gaps6 
	GoalManager_CreateGoalName goal_type = "GAps6" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_Gaps6_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_Race 
	IF GotParam version 
		FormatText TextName = goal_type "RAce%v" v = <version> 
		FormatText ChecksumName = trigger_obj_id "TRG_G_RACE%v_Pro" v = <version> 
		FormatText ChecksumName = restart_node "TRG_G_RACE%v_RestartNode" v = <version> 
	ELSE 
		<goal_type> = "RAce" 
	ENDIF 
	GoalManager_CreateGoalName goal_type = <goal_type> 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_Race_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_Race2 
	GoalManager_CreateGoalName goal_type = "RAce2" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_Race2_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_Race3 
	GoalManager_CreateGoalName goal_type = "RAce3" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_Race3_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_Race4 
	GoalManager_CreateGoalName goal_type = "RAce4" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_Race4_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_Race5 
	GoalManager_CreateGoalName goal_type = "RAce5" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_Race5_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_Race6 
	GoalManager_CreateGoalName goal_type = "RAce6" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_Race6_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_Horse 
	IF GotParam version 
		FormatText TextName = goal_type "HOrse%v" v = <version> 
		FormatText ChecksumName = trigger_obj_id "TRG_G_HORSE%v_Pro" v = <version> 
		FormatText ChecksumName = restart_node "TRG_G_HORSE%v_RestartNode" v = <version> 
	ELSE 
		<goal_type> = "HOrse" 
	ENDIF 
	GoalManager_CreateGoalName goal_type = <goal_type> 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_Horse_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_Horse2 
	GoalManager_CreateGoalName goal_type = "HOrse2" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_Horse2_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_HighCombo 
	IF GotParam version 
		FormatText TextName = goal_type "HIghCombo%v" v = <version> 
		FormatText ChecksumName = trigger_obj_id "TRG_G_HIGHCOMBO%v_Pro" v = <version> 
		FormatText ChecksumName = restart_node "TRG_G_HIGHCOMBO%v_RestartNode" v = <version> 
	ELSE 
		<goal_type> = "HIghCombo" 
	ENDIF 
	GoalManager_CreateGoalName goal_type = <goal_type> 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_HighCombo_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_HighCombo2 
	GoalManager_CreateGoalName goal_type = "HIghCombo2" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_HighCombo2_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_Kill 
	IF GotParam version 
		FormatText TextName = goal_type "KIll%v" v = <version> 
		FormatText ChecksumName = trigger_obj_id "TRG_G_KILL%v_Pro" v = <version> 
		FormatText ChecksumName = restart_node "TRG_G_KILL%v_RestartNode" v = <version> 
	ELSE 
		<goal_type> = "KIll" 
	ENDIF 
	GoalManager_CreateGoalName goal_type = <goal_type> 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_Kill_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_Special 
	IF GotParam version 
		FormatText TextName = goal_type "SPecial%v" v = <version> 
		FormatText ChecksumName = trigger_obj_id "TRG_G_SPECIAL%v_Pro" v = <version> 
		FormatText ChecksumName = restart_node "TRG_G_SPECIAL%v_RestartNode" v = <version> 
	ELSE 
		<goal_type> = "SPecial" 
	ENDIF 
	GoalManager_CreateGoalName goal_type = <goal_type> 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_Special_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_Tetris 
	IF GotParam version 
		FormatText TextName = goal_type "TEtris%v" v = <version> 
		FormatText ChecksumName = trigger_obj_id "TRG_G_TETRIS%v_Pro" v = <version> 
		FormatText ChecksumName = restart_node "TRG_G_TETRIS%v_RestartNode" v = <version> 
	ELSE 
		<goal_type> = "TEtris" 
	ENDIF 
	GoalManager_CreateGoalName goal_type = <goal_type> 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_Tetris_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_Tetris2 
	GoalManager_CreateGoalName goal_type = "TEtris2" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_Tetris2_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_Counter 
	IF GotParam version 
		FormatText TextName = goal_type "COunter%v" v = <version> 
		FormatText ChecksumName = trigger_obj_id "TRG_G_COUNTER%v_Pro" v = <version> 
		FormatText ChecksumName = restart_node "TRG_G_COUNTER%v_RestartNode" v = <version> 
	ELSE 
		<goal_type> = "COunter" 
	ENDIF 
	GoalManager_CreateGoalName goal_type = <goal_type> 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_Counter_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_Counter2 
	GoalManager_CreateGoalName goal_type = "COunter2" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_Counter2_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_Counter3 
	GoalManager_CreateGoalName goal_type = "COunter3" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_Counter3_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_Counter4 
	GoalManager_CreateGoalName goal_type = "COunter4" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_Counter4_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_CounterCombo 
	IF GotParam version 
		FormatText TextName = goal_type "COunterCombo%v" v = <version> 
		FormatText ChecksumName = trigger_obj_id "TRG_G_COUNTERCOMBO%v_Pro" v = <version> 
		FormatText ChecksumName = restart_node "TRG_G_COUNTERCOMBO%v_RestartNode" v = <version> 
	ELSE 
		<goal_type> = "COunterCombo" 
	ENDIF 
	GoalManager_CreateGoalName goal_type = <goal_type> 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_CounterCombo_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_CounterCombo2 
	GoalManager_CreateGoalName goal_type = "COunterCombo2" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { Goal_CounterCombo2_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_SkateTheLine 
	GoalManager_CreateGoalName goal_type = "SKateTheLine" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { goal_SkateTheLine_genericparams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_FindGaps 
	IF GotParam version 
		FormatText TextName = goal_type "FindGaps%v" v = <version> 
		FormatText ChecksumName = trigger_obj_id "TRG_G_FINDGAPS%v_Pro" v = <version> 
		FormatText ChecksumName = restart_node "TRG_G_FINDGAPS%v_RestartNode" v = <version> 
	ELSE 
		<goal_type> = "FindGaps" 
	ENDIF 
	GoalManager_CreateGoalName goal_type = <goal_type> 
	GoalManager_AddGoal name = <goal_id> { 
		params = { goal_findGaps_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddGoal_CreateATrick 
	IF GotParam version 
		FormatText TextName = goal_type "CAT%v" v = <version> 
		FormatText ChecksumName = trigger_obj_id "TRG_G_CAT%v_Pro" v = <version> 
		FormatText ChecksumName = restart_node "TRG_G_CAT%v_RestartNode" v = <version> 
	ELSE 
		<goal_type> = "CAT" 
	ENDIF 
	GoalManager_CreateGoalName goal_type = <goal_type> 
	GoalManager_AddGoal name = <goal_id> { 
		params = { goal_CAT_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddMinigame_TimedCombo 
	GoalManager_CreateGoalName goal_type = "minigame_TimedCombo" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { minigame_TimedCombo_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddMinigame_Fountain 
	GoalManager_CreateGoalName goal_type = "minigame_fountain" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { minigame_fountain_genericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddMinigame_Fountain2 
	GoalManager_CreateGoalName goal_type = "minigame_fountain2" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { minigame_fountain2_genericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddMinigame_Height 
	GoalManager_CreateGoalName goal_type = "minigame_height" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { minigame_Height_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddBettingGuy 
	GoalManager_CreateGoalName goal_type = "betting_guy" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { betting_guy_GenericParams 
			career_only 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddMinigame_trickspot 
	GoalManager_CreateGoalName goal_type = "minigame_trickspot" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { minigame_trickspot_genericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddMinigame_Timer 
	GoalManager_CreateGoalName goal_type = "minigame_timer" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { minigame_timer_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddMinigame_Generic 
	GoalManager_CreateGoalName goal_type = "minigame_generic" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { minigame_generic_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddMinigame_Generic2 
	GoalManager_CreateGoalName goal_type = "minigame_generic2" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { minigame_generic2_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddMinigame_Generic3 
	GoalManager_CreateGoalName goal_type = "minigame_generic3" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { minigame_generic3_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT AddMinigame_Generic4 
	GoalManager_CreateGoalName goal_type = "minigame_generic4" 
	GoalManager_AddGoal name = <goal_id> { 
		params = { minigame_generic4_GenericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT panel_message_goalfail 
	SetProps just = [ center bottom ] rgba = [ 128 30 12 108 ] 
	RunScriptOnScreenElement id = <id> panel_message_wait_and_die params = { time = 1800 } 
	DoMorph pos = PAIR(320.00000000000, 149.00000000000) time = 0 scale = 0 alpha = 0 
	DoMorph pos = PAIR(320.00000000000, 149.00000000000) scale = 1.79999995232 time = 0.10000000149 alpha = 1 
	DoMorph pos = PAIR(320.00000000000, 149.00000000000) scale = 0.89999997616 time = 0.15000000596 
	DoMorph pos = PAIR(320.00000000000, 149.00000000000) scale = 1.39999997616 time = 0.17000000179 
	DoMorph pos = PAIR(320.00000000000, 149.00000000000) scale = 1.20000004768 time = 0.18000000715 
	DoMorph alpha = 0.50000000000 time = 0.10000000149 
	DoMorph alpha = 1.00000000000 time = 0.10000000149 
	DoMorph alpha = 0.50000000000 time = 0.10000000149 
	DoMorph alpha = 1.00000000000 time = 0.10000000149 
	DoMorph alpha = 0.50000000000 time = 0.10000000149 
	DoMorph alpha = 1.00000000000 time = 0.10000000149 
	DoMorph alpha = 0.50000000000 time = 0.10000000149 
	DoMorph alpha = 1.00000000000 time = 0.10000000149 
	DoMorph alpha = 0.50000000000 time = 0.10000000149 
	DoMorph alpha = 0 time = 0.05000000075 scale = PAIR(10.00000000000, 0.00000000000) rgba = [ 0 0 0 128 ] 
ENDSCRIPT

SCRIPT panel_sprite_goalfail time = 1500 
	SetProps just = [ center center ] rgba = [ 128 30 12 108 ] 
	RunScriptOnScreenElement id = <id> panel_message_wait_and_die params = { time = <time> } 
	DoMorph time = 0 scale = 0 pos = PAIR(320.00000000000, 114.00000000000) alpha = 0 
	DoMorph time = 0.34999999404 scale = 2.50000000000 alpha = 1 
	DoMorph time = 0.50000000000 scale = 3.50000000000 alpha = 0 
ENDSCRIPT

SCRIPT panel_message_goalfailline2 time = 1500 
	SetProps font = dialog just = [ center center ] rgba = [ 128 30 12 108 ] 
	RunScriptOnScreenElement id = <id> panel_message_wait_and_die params = { time = <time> } 
	DoMorph pos = PAIR(320.00000000000, 157.00000000000) time = 0 alpha = 0 
	DoMorph pos = PAIR(320.00000000000, 157.00000000000) scale = 8 time = 0.10000000149 alpha = 1 
	DoMorph pos = PAIR(320.00000000000, 157.00000000000) scale = 0.89999997616 time = 0.15000000596 
	DoMorph pos = PAIR(320.00000000000, 157.00000000000) scale = 1.79999995232 time = 0.17000000179 
	DoMorph pos = PAIR(320.00000000000, 157.00000000000) scale = 1.20000004768 time = 0.18000000715 
	DoMorph pos = PAIR(320.00000000000, 157.00000000000) scale = 1.50000000000 time = 0.18999999762 
	DoMorph alpha = 0.50000000000 time = 0.10000000149 
	DoMorph alpha = 1.00000000000 time = 0.10000000149 
	DoMorph alpha = 0.50000000000 time = 0.10000000149 
	DoMorph alpha = 1.00000000000 time = 0.10000000149 
	DoMorph alpha = 0.50000000000 time = 0.10000000149 
	DoMorph alpha = 1.00000000000 time = 0.10000000149 
	DoMorph alpha = 0.50000000000 time = 0.10000000149 
	DoMorph alpha = 1.00000000000 time = 0.10000000149 
	DoMorph alpha = 0 time = 0.05000000075 scale = PAIR(10.00000000000, 0.00000000000) rgba = [ 0 0 0 128 ] 
ENDSCRIPT

SCRIPT panel_message_goalcomplete time = 1500 
	GetTags 
	RunScriptOnScreenElement id = <id> panel_message_wait_and_die params = { time = <time> } 
	SetProps just = [ center bottom ] rgba = [ 36 125 24 128 ] 
	DoMorph time = 0 scale = 0 alpha = 0 
	DoMorph time = 0.10000000149 scale = 0 alpha = 0 
	DoMorph pos = PAIR(320.00000000000, 149.00000000000) time = 0 alpha = 0 scale = 6 
	DoMorph pos = PAIR(320.00000000000, 149.00000000000) scale = 6 time = 0.10000000149 alpha = 1 
	DoMorph pos = PAIR(320.00000000000, 149.00000000000) scale = 0.89999997616 time = 0.15000000596 
	DoMorph pos = PAIR(320.00000000000, 149.00000000000) scale = 1.60000002384 time = 0.17000000179 
	DoMorph pos = PAIR(320.00000000000, 149.00000000000) scale = 1.10000002384 time = 0.18000000715 
	DoMorph pos = PAIR(320.00000000000, 149.00000000000) scale = 1.29999995232 time = 0.18999999762 
	DoMorph alpha = 0.50000000000 time = 0.10000000149 
	DoMorph alpha = 1.00000000000 time = 0.10000000149 
	DoMorph alpha = 0.50000000000 time = 0.10000000149 
	DoMorph alpha = 1.00000000000 time = 0.10000000149 
	DoMorph alpha = 0.50000000000 time = 0.10000000149 
	DoMorph alpha = 1.00000000000 time = 0.10000000149 
	DoMorph alpha = 0.50000000000 time = 0.10000000149 
	DoMorph alpha = 1.00000000000 time = 0.10000000149 
	DoMorph alpha = 0 time = 0.05000000075 scale = PAIR(10.00000000000, 0.00000000000) rgba = [ 0 0 0 128 ] 
ENDSCRIPT

SCRIPT panel_sprite_goalcomplete time = 1500 
	SetProps just = [ center center ] rgba = [ 36 125 24 128 ] 
	DoMorph time = 0 scale = 0 pos = PAIR(320.00000000000, 114.00000000000) alpha = 0 
	DoMorph time = 0.10000000149 scale = 0 alpha = 0 
	DoMorph time = 0.34999999404 scale = 2.50000000000 alpha = 1 
	DoMorph time = 0.50000000000 scale = 3.50000000000 alpha = 0 
	FireEvent type = panel_sprite_goalcomplete_done 
ENDSCRIPT

SCRIPT panel_message_goalcompleteline2 time = 1500 
	SetProps font = dialog just = [ center center ] rgba = [ 36 125 24 128 ] 
	DoMorph time = 0 scale = 0 alpha = 0 
	DoMorph time = 0.10000000149 scale = 0 alpha = 0 
	DoMorph pos = PAIR(320.00000000000, 157.00000000000) scale = 6 alpha = 1 time = 0 
	DoMorph pos = PAIR(320.00000000000, 157.00000000000) scale = 0.75000000000 alpha = 1 time = 0.10000000149 
	wait 1 frame 
	DoMorph pos = PAIR(320.00000000000, 157.00000000000) scale = 1.60000002384 alpha = 1 time = 0.10000000149 
	wait 1 frame 
	DoMorph pos = PAIR(320.00000000000, 157.00000000000) scale = 1.29999995232 alpha = 1 time = 0.10000000149 
	wait 1 frame 
	SetProps blur_effect 
	do_blur_effect 
	SetProps no_blur_effect 
	DoMorph time = 0.10000000149 alpha = 0.40000000596 
	DoMorph time = 0.10000000149 alpha = 1 
	DoMorph time = 0.10000000149 alpha = 0.40000000596 
	DoMorph time = 0.10000000149 alpha = 1 
	DoMorph time = 0.10000000149 alpha = 0.40000000596 
	DoMorph time = 0.10000000149 alpha = 1 
	DoMorph time = 0.10000000149 alpha = 0.40000000596 
	DoMorph time = 0.10000000149 alpha = 1 
	DoMorph time = 0.10000000149 alpha = 0.40000000596 
	DoMorph time = 0.10000000149 alpha = 1 
	DoMorph time = 0.10000000149 alpha = 0.40000000596 
	DoMorph time = 0.10000000149 alpha = 1 
	DoMorph alpha = 0 time = 0.05000000075 scale = PAIR(10.00000000000, 0.00000000000) rgba = [ 0 0 0 128 ] 
	Die 
	FireEvent type = panel_message_goalcompleteline2_done 
ENDSCRIPT

SCRIPT panel_message_new_record 
	SetProps font = dialog just = [ center center ] rgba = [ 125 123 7 128 ] 
	DoMorph time = 0 pos = PAIR(320.00000000000, 204.00000000000) scale = 0 alpha = 0 
	DoMorph time = 0.50000000000 alpha = 1 
	IF GotParam sound 
		PlaySound <sound> vol = 150 
	ENDIF 
	DoMorph time = 0.10000000149 scale = 2.50000000000 
	DoMorph time = 0.10000000149 scale = 1.50000000000 
	DoMorph time = 0.10000000149 scale = 2.00000000000 
	DoMorph time = 0.10000000149 scale = 1.39999997616 
	DoMorph pos = PAIR(321.00000000000, 205.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(319.00000000000, 203.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 205.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(319.00000000000, 203.00000000000) time = 0.10000000149 
	DoMorph time = 0.10000000149 scale = 1.79999995232 
	DoMorph time = 0.15000000596 scale = 0 alpha = 0 
	FireEvent type = panel_message_new_record_done 
	Die 
ENDSCRIPT

SCRIPT panel_message_goal blink_time = 0.10000000149 final_pos = PAIR(620.00000000000, 27.00000000000) 
	IF NOT GotParam dont_animate 
		SetProps just = [ center top ] internal_just = [ center center ] rgba = [ 128 128 128 128 ] 
		DoMorph pos = PAIR(320.00000000000, 120.00000000000) scale = 0 alpha = 0 
		DoMorph pos = PAIR(320.00000000000, 120.00000000000) scale = 1.10000002384 time = 0.30000001192 alpha = 0.34999999404 
		wait 0.20000000298 second 
	ENDIF 
	SetProps internal_just = [ center top ] rgba = [ 128 128 128 110 ] just = [ right top ] 
	DoMorph pos = <final_pos> scale = 0.82999998331 time = 0.09000000358 alpha = 1 
	FireEvent type = panel_message_goal_done 
	FireEvent type = panel_message_goal_done2 
ENDSCRIPT

SCRIPT panel_message_found_secret time = 1500 
	SetProps just = [ center center ] rgba = [ 115 116 13 128 ] 
	DoMorph pos = PAIR(320.00000000000, 157.00000000000) scale = 6 alpha = 0 time = 0 
	DoMorph pos = PAIR(320.00000000000, 157.00000000000) scale = 0.75000000000 alpha = 1 time = 0.10000000149 
	wait 1 frame 
	DoMorph pos = PAIR(320.00000000000, 157.00000000000) scale = 1.60000002384 alpha = 1 time = 0.10000000149 
	wait 1 frame 
	DoMorph pos = PAIR(320.00000000000, 157.00000000000) scale = 1.29999995232 alpha = 1 time = 0.10000000149 
	wait 1 frame 
	SetProps blur_effect 
	do_blur_effect 
	SetProps no_blur_effect 
	DoMorph time = 0.10000000149 alpha = 0.40000000596 
	DoMorph time = 0.10000000149 alpha = 1 
	DoMorph time = 0.10000000149 alpha = 0.40000000596 
	DoMorph time = 0.10000000149 alpha = 1 
	DoMorph time = 0.10000000149 alpha = 0.40000000596 
	DoMorph time = 0.10000000149 alpha = 1 
	DoMorph time = 0.10000000149 alpha = 0.40000000596 
	DoMorph time = 0.10000000149 alpha = 1 
	DoMorph time = 0.10000000149 alpha = 0.40000000596 
	DoMorph time = 0.10000000149 alpha = 1 
	DoMorph time = 0.10000000149 alpha = 0.40000000596 
	DoMorph time = 0.10000000149 alpha = 1 
	DoMorph alpha = 0 time = 0.05000000075 scale = PAIR(10.00000000000, 0.00000000000) rgba = [ 0 0 0 128 ] 
	Die 
	FireEvent type = panel_message_found_secret_done 
ENDSCRIPT

SCRIPT panel_message_new_goal 
	SetProps font = dialog just = [ center center ] rgba = [ 128 30 12 108 ] 
	DoMorph pos = PAIR(320.00000000000, 184.00000000000) time = 0 alpha = 0 
	DoMorph pos = PAIR(320.00000000000, 184.00000000000) scale = 8 time = 0.10000000149 
	DoMorph pos = PAIR(320.00000000000, 184.00000000000) scale = 0.89999997616 time = 0.15000000596 alpha = 1 
	DoMorph pos = PAIR(320.00000000000, 184.00000000000) scale = 1.60000002384 time = 0.17000000179 
	DoMorph pos = PAIR(320.00000000000, 184.00000000000) scale = 1.20000004768 time = 0.18000000715 
	DoMorph pos = PAIR(320.00000000000, 184.00000000000) scale = 1.39999997616 time = 0.18999999762 
	DoMorph alpha = 0.50000000000 time = 0.10000000149 
	DoMorph alpha = 1.00000000000 time = 0.10000000149 
	DoMorph alpha = 0.50000000000 time = 0.10000000149 
	DoMorph alpha = 1.00000000000 time = 0.10000000149 
	DoMorph alpha = 0.50000000000 time = 0.10000000149 
	DoMorph alpha = 1.00000000000 time = 0.10000000149 
	DoMorph alpha = 0.50000000000 time = 0.10000000149 
	DoMorph alpha = 1.00000000000 time = 0.10000000149 
	DoMorph alpha = 0.50000000000 time = 0.10000000149 
	DoMorph alpha = 1.00000000000 time = 0.10000000149 
	DoMorph alpha = 0.50000000000 time = 0.10000000149 
	DoMorph alpha = 1.00000000000 time = 0.10000000149 
	DoMorph alpha = 0.50000000000 time = 0.10000000149 
	DoMorph alpha = 1.00000000000 time = 0.10000000149 
	DoMorph alpha = 0 time = 0.15000000596 scale = PAIR(15.00000000000, 0.00000000000) rgba = [ 128 128 128 128 ] 
	Die 
ENDSCRIPT

SCRIPT panel_sprite_new_goal time = 1500 
	SetProps just = [ center center ] rgba = [ 128 128 128 128 ] 
	RunScriptOnScreenElement id = <id> panel_message_wait_and_die params = { time = <time> } 
	DoMorph time = 0 scale = 0 pos = PAIR(320.00000000000, 190.00000000000) alpha = 0 
	DoMorph time = 0.30000001192 scale = 2.50000000000 alpha = 1 
	DoMorph time = 0.40000000596 scale = 3.50000000000 alpha = 0 
	wait 2 second 
	DoMorph alpha = 0 time = 2 
ENDSCRIPT

SCRIPT panel_message_generic_loss 
	SetProps just = [ center center ] rgba = [ 128 128 128 100 ] 
	RunScriptOnScreenElement id = <id> panel_message_wait_and_die params = { time = 1500 } 
	DoMorph pos = PAIR(320.00000000000, 185.00000000000) time = 0 scale = 0 
	DoMorph time = 0.30000001192 scale = 1.29999995232 
	DoMorph time = 0.20000000298 scale = 1.00000000000 
	DoMorph pos = PAIR(319.00000000000, 184.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 186.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(319.00000000000, 184.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(322.00000000000, 186.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(319.00000000000, 184.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 186.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(319.00000000000, 182.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 186.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(319.00000000000, 184.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 186.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(318.00000000000, 184.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 187.00000000000) time = 0.10000000149 
ENDSCRIPT

SCRIPT panel_message_goal_description 
	SetProps rgba = [ 128 128 128 128 ] just = [ center center ] 
	DoMorph time = 0 scale = 1 pos = PAIR(320.00000000000, 120.00000000000) 
ENDSCRIPT

SCRIPT panel_message_tips blink_time = 0.05000000075 
	SetProps just = [ center top ] internal_just = [ center center ] rgba = [ 127 102 0 100 ] 
	DoMorph scale = 0 
	DoMorph scale = 1.20000004768 time = 0.10000000149 
	DoMorph scale = 0.80000001192 time = 0.10000000149 
	DoMorph scale = 1 time = 0.10000000149 
	DoMorph scale = 0.89999997616 time = 0.10000000149 
	DoMorph pos = { PAIR(1.00000000000, 2.00000000000) relative } time = 0.10000000149 
	DoMorph pos = { PAIR(-2.00000000000, -3.00000000000) relative } time = 0.10000000149 
	DoMorph pos = { PAIR(2.00000000000, 2.00000000000) relative } time = 0.10000000149 
	DoMorph pos = { PAIR(-3.00000000000, -2.00000000000) relative } time = 0.10000000149 
	DoMorph pos = { PAIR(3.00000000000, 2.00000000000) relative } time = 0.10000000149 
	DoMorph pos = { PAIR(-2.00000000000, -2.00000000000) relative } time = 0.10000000149 
	DoMorph pos = { PAIR(2.00000000000, 4.00000000000) relative } time = 0.10000000149 
	DoMorph pos = { PAIR(-2.00000000000, -4.00000000000) relative } time = 0.10000000149 
	DoMorph pos = { PAIR(1.00000000000, 7.00000000000) relative } scale = 1.25000000000 time = 0.10000000149 
	SetProps internal_just = [ center top ] rgba = [ 127 102 0 90 ] just = [ right top ] 
	DoMorph pos = { PAIR(155.00000000000, -40.00000000000) relative } scale = 0.77999997139 time = 0.05000000075 
	BEGIN 
		DoMorph alpha = 0 
		wait <blink_time> seconds 
		DoMorph alpha = 1 
		wait <blink_time> seconds 
	REPEAT 6 
ENDSCRIPT

SCRIPT clock_morph 
	DoMorph scale = 0 alpha = 0 time = 0.10000000149 
	DoMorph scale = 1.00000000000 alpha = 1 time = 0.30000001192 
ENDSCRIPT

SCRIPT goal_message_got_trickslot 
	SetProps rgba = [ 43 95 53 128 ] 
	DoMorph time = 0 pos = PAIR(320.00000000000, 214.00000000000) scale = 0 alpha = 0 
	DoMorph time = 0.50000000000 alpha = 1 
	IF GotParam sound 
		PlaySound <sound> vol = 150 
	ENDIF 
	DoMorph time = 0.10000000149 scale = 2.50000000000 
	DoMorph time = 0.10000000149 scale = 1.50000000000 
	DoMorph time = 0.10000000149 scale = 2.00000000000 
	DoMorph time = 0.10000000149 scale = 1.39999997616 
	DoMorph pos = PAIR(321.00000000000, 215.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(319.00000000000, 213.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 215.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(319.00000000000, 213.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 215.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(319.00000000000, 213.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 215.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(319.00000000000, 213.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 215.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(319.00000000000, 213.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 215.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(319.00000000000, 213.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 215.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(319.00000000000, 213.00000000000) time = 0.10000000149 
	DoMorph time = 0.10000000149 scale = 1.39999997616 
	DoMorph time = 0.15000000596 scale = 0 alpha = 0 
	Die 
	FireEvent type = goal_got_reward_done 
ENDSCRIPT

SCRIPT goal_message_got_stat 
	SetProps rgba = [ 43 95 53 128 ] 
	DoMorph time = 0 pos = PAIR(320.00000000000, 214.00000000000) scale = 0 alpha = 0 
	DoMorph time = 0.50000000000 alpha = 1 
	IF GotParam sound 
		PlaySound <sound> vol = 150 
	ENDIF 
	DoMorph time = 0.10000000149 scale = 2.50000000000 
	DoMorph time = 0.10000000149 scale = 1.50000000000 
	DoMorph time = 0.10000000149 scale = 2.00000000000 
	DoMorph time = 0.10000000149 scale = 1.39999997616 
	DoMorph pos = PAIR(321.00000000000, 215.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(319.00000000000, 213.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 215.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(319.00000000000, 213.00000000000) time = 0.10000000149 
	DoMorph time = 0.10000000149 scale = 1.39999997616 
	DoMorph time = 0.15000000596 scale = 0 alpha = 0 
	Die 
	FireEvent type = goal_got_reward_done 
ENDSCRIPT

SCRIPT goal_message_stat_up 
	SetProps rgba = [ 33 112 15 128 ] 
	DoMorph time = 0 pos = PAIR(320.00000000000, 195.00000000000) scale = 0 alpha = 0 
	DoMorph time = 0.20000000298 alpha = 1 
	IF GotParam sound 
		PlaySound <sound> vol = 150 
	ENDIF 
	DoMorph time = 0.10000000149 scale = 2.50000000000 
	DoMorph time = 0.10000000149 scale = 1.50000000000 
	DoMorph time = 0.10000000149 scale = 2.00000000000 
	DoMorph time = 0.10000000149 scale = 1.39999997616 
	DoMorph pos = PAIR(321.00000000000, 196.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(319.00000000000, 194.00000000000) time = 0.10000000149 
	DoMorph time = 0.10000000149 scale = 1.39999997616 
	DoMorph time = 0.15000000596 scale = 0 alpha = 0 
	Die 
ENDSCRIPT

SCRIPT goal_message_got_bigbucks 
	SetProps rgba = [ 43 95 53 128 ] 
	DoMorph time = 0 pos = PAIR(320.00000000000, 214.00000000000) scale = 0 alpha = 0 
	DoMorph time = 0.50000000000 alpha = 1 
	IF GotParam sound 
		PlaySound <sound> vol = 150 
	ENDIF 
	DoMorph time = 0.10000000149 scale = 1.70000004768 
	DoMorph time = 0.10000000149 scale = 0.80000001192 
	DoMorph time = 0.10000000149 scale = 1.20000004768 
	DoMorph time = 0.10000000149 scale = 0.89999997616 
	DoMorph time = 0.10000000149 scale = 1.00000000000 
	DoMorph pos = PAIR(321.00000000000, 215.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(319.00000000000, 213.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 215.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(319.00000000000, 213.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 215.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(319.00000000000, 213.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 215.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(319.00000000000, 213.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 215.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(319.00000000000, 213.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 215.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(319.00000000000, 213.00000000000) time = 0.10000000149 
	DoMorph time = 0.10000000149 scale = 1.39999997616 
	DoMorph time = 0.15000000596 scale = 0 alpha = 0 
	Die 
	FireEvent type = goal_got_reward_done 
ENDSCRIPT

SCRIPT goal_message_got_money 
	SetProps rgba = [ 36 125 24 128 ] 
	DoMorph time = 0 pos = PAIR(320.00000000000, 114.00000000000) scale = 0 alpha = 0 
	DoMorph time = 0.10000000149 alpha = 1 
	DoMorph time = 0.10000000149 scale = 1.70000004768 
	DoMorph time = 0.10000000149 scale = 0.89999997616 
	DoMorph time = 0.10000000149 scale = 1.00000000000 
	DoMorph alpha = 0.40000000596 time = 0.07000000030 
	DoMorph alpha = 1 time = 0.07000000030 
	DoMorph alpha = 0.60000002384 time = 0.07000000030 
	DoMorph alpha = 1 time = 0.07000000030 
	DoMorph alpha = 0.30000001192 time = 0.07000000030 
	DoMorph alpha = 1 time = 0.07000000030 
	DoMorph alpha = 0.60000002384 time = 0.07000000030 
	DoMorph alpha = 1 time = 0.07000000030 
	DoMorph time = 0.10000000149 scale = 1.39999997616 
	DoMorph time = 0.10000000149 scale = 0 alpha = 0 
	Die 
	FireEvent type = goal_got_reward_done 
ENDSCRIPT

SCRIPT goal_message_got_money2 
	SetProps rgba = [ 36 125 24 128 ] 
	DoMorph time = 0 pos = PAIR(320.00000000000, 114.00000000000) scale = 0 alpha = 0 
	DoMorph time = 0.10000000149 alpha = 1 
	DoMorph time = 0.10000000149 scale = 1.70000004768 
	DoMorph time = 0.10000000149 scale = 0.89999997616 
	DoMorph time = 0.10000000149 scale = 1.00000000000 
	DoMorph alpha = 0.40000000596 time = 0.07000000030 
	DoMorph alpha = 1 time = 0.07000000030 
	DoMorph alpha = 0.60000002384 time = 0.07000000030 
	DoMorph alpha = 1 time = 0.07000000030 
	DoMorph alpha = 0.30000001192 time = 0.07000000030 
	DoMorph alpha = 1 time = 0.07000000030 
	DoMorph alpha = 0.60000002384 time = 0.07000000030 
	DoMorph alpha = 1 time = 0.07000000030 
	DoMorph alpha = 0.60000002384 time = 0.07000000030 
	DoMorph alpha = 1 time = 0.07000000030 
	DoMorph alpha = 0.30000001192 time = 0.07000000030 
	DoMorph alpha = 1 time = 0.07000000030 
	DoMorph alpha = 0.60000002384 time = 0.07000000030 
	DoMorph alpha = 1 time = 0.07000000030 
	DoMorph alpha = 0.30000001192 time = 0.07000000030 
	DoMorph alpha = 1 time = 0.07000000030 
	DoMorph alpha = 0.60000002384 time = 0.07000000030 
	DoMorph alpha = 1 time = 0.07000000030 
	DoMorph alpha = 0.60000002384 time = 0.07000000030 
	DoMorph alpha = 1 time = 0.07000000030 
	DoMorph alpha = 0.30000001192 time = 0.07000000030 
	DoMorph alpha = 1 time = 0.07000000030 
	DoMorph alpha = 0.60000002384 time = 0.07000000030 
	DoMorph alpha = 1 time = 0.07000000030 scale = 1.00000000000 
	DoMorph time = 0.10000000149 scale = 1.39999997616 
	DoMorph time = 0.10000000149 scale = 0 alpha = 0 
	Die 
	FireEvent type = goal_got_reward_done 
ENDSCRIPT

SCRIPT goal_got_goal_point 
	SetProps rgba = [ 43 95 53 128 ] 
	DoMorph time = 0 pos = PAIR(320.00000000000, 214.00000000000) scale = 0 alpha = 0 
	DoMorph time = 0.50000000000 alpha = 1 
	DoMorph time = 0.10000000149 scale = 2.50000000000 
	DoMorph time = 0.10000000149 scale = 1.50000000000 
	DoMorph time = 0.10000000149 scale = 2.00000000000 
	DoMorph time = 0.10000000149 scale = 1.39999997616 
	DoMorph pos = PAIR(321.00000000000, 215.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(319.00000000000, 213.00000000000) time = 0.10000000149 
	DoMorph time = 0.50000000000 alpha = 0 pos = PAIR(320.00000000000, 384.00000000000) rgb = [ 50 50 50 ] 
	Die 
	FireEvent type = goal_got_goal_point_done 
ENDSCRIPT

SCRIPT panel_message_current_goal_key_combo 
	SetProps just = [ right top ] rgba = [ 128 128 128 128 ] 
	DoMorph pos = PAIR(445.00000000000, 175.00000000000) 
	DoMorph pos = PAIR(445.00000000000, 175.00000000000) time = 1.20000004768 
	DoMorph pos = PAIR(630.00000000000, 63.00000000000) scale = 1.29999995232 time = 0.10000000149 
	DoMorph pos = PAIR(630.00000000000, 63.00000000000) scale = 0.80000001192 time = 0.10999999940 
	BEGIN 
		DoMorph alpha = 0 
		wait <blink_time> seconds 
		DoMorph alpha = 1 
		wait <blink_time> seconds 
	REPEAT 6 
ENDSCRIPT

SCRIPT goal_message_got_gap 
	SetProps rgba = [ 20 98 114 108 ] 
	DoMorph time = 0 pos = PAIR(320.00000000000, 74.00000000000) scale = 0 alpha = 0 
	DoMorph time = 0.10000000149 alpha = 1 
	DoMorph time = 0.10000000149 scale = 1.89999997616 
	DoMorph time = 0.10000000149 scale = 0.89999997616 
	DoMorph time = 0.10000000149 scale = 1.20000004768 
	DoMorph time = 0.10000000149 scale = 0.94999998808 
	DoMorph time = 0.10000000149 scale = 1.00000000000 
	DoMorph alpha = 0.40000000596 time = 0.07000000030 
	DoMorph alpha = 1 time = 0.07000000030 
	DoMorph alpha = 0.60000002384 time = 0.07000000030 
	DoMorph alpha = 1 time = 0.07000000030 
	DoMorph alpha = 0.30000001192 time = 0.07000000030 
	DoMorph alpha = 0.60000002384 time = 0.07000000030 
	DoMorph alpha = 1 time = 0.07000000030 
	DoMorph alpha = 0.30000001192 time = 0.07000000030 
	DoMorph alpha = 1 time = 0.07000000030 
	DoMorph alpha = 0.30000001192 time = 0.07000000030 
	DoMorph alpha = 0.60000002384 time = 0.07000000030 
	DoMorph alpha = 1 time = 0.07000000030 
	DoMorph alpha = 0.30000001192 time = 0.07000000030 
	DoMorph alpha = 1 time = 0.07000000030 
	DoMorph alpha = 0.30000001192 time = 0.07000000030 
	DoMorph alpha = 0.60000002384 time = 0.07000000030 
	DoMorph alpha = 1 time = 0.07000000030 
	DoMorph alpha = 0.30000001192 time = 0.07000000030 
	DoMorph alpha = 1 time = 0.07000000030 
	DoMorph alpha = 0.60000002384 time = 0.07000000030 
	DoMorph alpha = 1 time = 0.07000000030 scale = 1.00000000000 
	DoMorph time = 0.10000000149 scale = 1.70000004768 
	DoMorph time = 0.10000000149 scale = 0 alpha = 0 
	Die 
ENDSCRIPT

goal_pro_last_names = { 
	tony = "Hawk" 
	bam = "Margera" 
	bucky = "Lasek" 
	chad = "Muska" 
	jamie = "Thomas" 
	rodney = "Mullen" 
	eric = "Koston" 
	rune = "Glifberg" 
	geoff = "Rowley" 
	andrew = "Reynolds" 
	steve = "Caballero" 
	elissa = "Steamer" 
	bob = "Burnquist" 
	kareem = "Campbell" 
	paul = "Rodriguez" 
	Arto = "Saari" 
	Mike = "Vallely" 
	Gene = "Simmons" 
	Iron = "Iron Man" 
	Creature = "Creature" 
	Ped = "Pedestrian" 
} 
goal_pro_last_name_checksums = { 
	tony = Hawk 
	bam = Margera 
	bucky = Lasek 
	chad = Muska 
	jamie = Thomas 
	rodney = Mullen 
	eric = Koston 
	rune = Glifberg 
	geoff = Rowley 
	andrew = Reynolds 
	steve = Caballero 
	elissa = Steamer 
	bob = Burnquist 
	kareem = Campbell 
	custom = custom 
	jenna = jameson 
	jango = fett 
	eddie = eddie 
	Mike = vallely 
} 

