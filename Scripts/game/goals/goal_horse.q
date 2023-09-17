
goal_horse_genericParams = { 
	goal_text = "generic horse text" 
	view_goals_text = "Horse goal" 
	time = 3 
	init = goal_horse_init 
	uninit = goal_uninit 
	activate = goal_horse_activate 
	active = goal_horse_active 
	success = goal_horse_success 
	fail = goal_horse_fail 
	deactivate = goal_horse_deactivate 
	expire = goal_horse_expire 
	trigger_obj_id = TRG_G_HORSE_Pro 
	restart_node = TRG_G_HORSE_RestartNode 
	start_pad_id = G_HORSE_StartPad 
	goal_flags = [ got_1 
		got_2 
		got_3 
	] 
	horse_spots = [ { id = TRG_G_HORSE_Spot01 scr = sch_horse_spot01 flag = got_1 score = 1000 time = 10 text = "spot 1" } 
		{ id = TRG_G_HORSE_Spot02 scr = sch_horse_spot02 flag = got_2 score = 2000 time = 10 text = "spot 2" } 
		{ id = TRG_G_HORSE_Spot03 scr = sch_horse_spot03 flag = got_3 score = 3000 time = 10 text = "spot 3" } 
	] 
	record_type = time 
	should_check_trick = 0 
	horse 
} 
goal_horse2_genericParams = { 
	goal_text = "generic horse2 text" 
	view_goals_text = "Horse2 goal" 
	time = 3 
	init = goal_horse_init 
	uninit = goal_uninit 
	activate = goal_horse_activate 
	active = goal_horse_active 
	success = goal_horse_success 
	fail = goal_horse_fail 
	deactivate = goal_horse_deactivate 
	expire = goal_horse_expire 
	trigger_obj_id = TRG_G_HORSE2_Pro 
	restart_node = TRG_G_HORSE2_RestartNode 
	start_pad_id = G_HORSE2_StartPad 
	goal_flags = [ got_1 
		got_2 
		got_3 
	] 
	horse_spots = [ { id = TRG_G_HORSE2_Spot01 scr = sch_horse2_spot01 flag = got_1 score = 1000 time = 10 text = "spot 1" } 
		{ id = TRG_G_HORSE2_Spot02 scr = sch_horse2_spot02 flag = got_2 score = 2000 time = 10 text = "spot 2" } 
		{ id = TRG_G_HORSE2_Spot03 scr = sch_horse2_spot03 flag = got_3 score = 3000 time = 10 text = "spot 3" } 
	] 
	should_check_trick = 0 
	record_type = time 
	horse 
} 
SCRIPT goal_horse_init 
	goal_init goal_id = <goal_id> 
ENDSCRIPT

SCRIPT goal_horse_activate 
	goal_start goal_id = <goal_id> dont_unpause = dont_unpause 
	SetScoreAccumulation 0 
	GoalManager_SetEndRunType name = <goal_id> Goal_EndOfRun 
	GoalManager_NextHorseSpot name = <goal_id> 
ENDSCRIPT

SCRIPT goal_horse_next_spot 
	GoalManager_EditGoal name = <goal_id> params = { should_check_trick = 0 } 
	IF NOT GotParam first_spot 
		SlowSkaterToStop 
		pause_trick_text 
		ResetSkaters Node_Name = <id> 
		Wait 1 GameFrame 
		PauseSkaters 
	ENDIF 
	IF GotParam text 
		create_speech_box text = <text> pad_choose_script = goal_horse_continue 
	ENDIF 
	GoalManager_GetGoalParams name = <goal_id> 
	IF GotParam first_spot 
		<cam_anim> = <start_cam_anim> 
		goal_horse_next_spot2 <...> 
	ELSE 
		IF GotParam pro_node 
			printf "moving pro" 
			<trigger_obj_id> : Obj_MoveToNode name = <pro_node> 
		ENDIF 
		<trigger_obj_id> : Obj_LookAtObject type = skater time = 0.05000000075 
		IF GotParam cam_anim 
			GetSkaterId 
			PlaySkaterCamAnim skaterId = <ObjId> name = <cam_anim> skippable = 1 play_hold 
		ENDIF 
		create_speech_box { 
			text = "Press \\m0 to continue" 
			pos = PAIR(320.00000000000, 400.00000000000) 
			pad_choose_script = goal_horse_next_spot2 
			pad_choose_params = <...> 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT goal_horse_next_spot2 
	DeBounce X time = 0.30000001192 
	GoalManager_PauseGoal name = <goal_id> 
	GetSkaterId 
	Wait 1 GameFrame 
	IF GotParam first_spot 
		IF NOT GotParam quick_start 
			WaitForEvent type = goal_cam_anim_post_start_done 
			IF NOT GoalManager_GoalIsActive name = <goal_id> 
				RETURN 
			ENDIF 
		ENDIF 
	ELSE 
		IF GotParam cam_anim 
			BEGIN 
				IF SkaterCamAnimFinished skaterId = <ObjId> name = <cam_anim> 
					BREAK 
				ENDIF 
				Wait 1 GameFrame 
			REPEAT 
		ENDIF 
	ENDIF 
	unpause_trick_text 
	speech_box_exit 
	printf "unpausing" 
	FireEvent type = goal_horse_wait_done 
	GoalManager_UnPauseGoal name = <goal_id> 
	UnPauseSkaters 
	SpawnScript <scr> 
	skater : EnablePlayerInput 
	GoalManager_EditGoal name = <goal_id> params = { current_score = <score> } 
	GoalManager_EditGoal name = <goal_id> params = { current_flag = <flag> } 
	GoalManager_EditGoal name = <goal_id> params = { should_check_trick = 1 } 
	GoalManager_SetShouldDeactivateOnExpire name = <goal_id> 0 
	RunScriptOnObject id = <trigger_obj_id> goal_horse_set_trigger_exceptions params = <...> 
ENDSCRIPT

SCRIPT goal_horse_set_trigger_exceptions 
	Obj_ClearExceptions 
	Obj_SetException ex = SkaterBailed scr = goal_horse_skater_bailed params = { goal_id = <goal_id> } 
ENDSCRIPT

SCRIPT goal_horse_skater_bailed 
	SpawnScript goal_horse_skater_bailed2 params = { goal_id = <goal_id> } 
ENDSCRIPT

SCRIPT goal_horse_skater_bailed2 
	GoalManager_LoseGoal name = <goal_id> 
	GoalManager_EditGoal name = <goal_id> params = { should_check_trick = 0 } 
ENDSCRIPT

SCRIPT goal_horse_active 
	IF GoalManager_AllFlagsSet name = <goal_id> 
		GoalManager_winGoal name = <goal_id> 
	ENDIF 
ENDSCRIPT

SCRIPT goal_horse_success 
	goal_success goal_id = <goal_id> 
ENDSCRIPT

SCRIPT goal_horse_deactivate 
	KillSpawnedScript name = goal_horse_next_spot 
	KillSpawnedScript name = goal_horse_next_spot2 
	KillSpawnedScript name = goal_horse_continue 
	KillSpawnedScript name = goal_horse_next_spot 
	Wait 1 frame 
	IF ObjectExists id = current_horse_spot 
		DestroyScreenElement id = current_horse_spot 
	ENDIF 
	<trigger_obj_id> : Obj_MoveToNode name = <trigger_obj_id> 
	<trigger_obj_id> : Obj_ClearException SkaterLanded 
	<trigger_obj_id> : Obj_ClearException SkaterBailed 
	GoalManager_ResetGoalTrigger name = <goal_id> 
	goal_deactivate goal_id = <goal_id> 
ENDSCRIPT

SCRIPT goal_horse_fail 
	goal_fail goal_id = <goal_id> 
ENDSCRIPT

SCRIPT goal_horse_expire 
	goal_expire goal_id = <goal_id> 
	GoalManager_LoseGoal name = <goal_id> 
ENDSCRIPT

SCRIPT goal_horse_continue 
	UnPauseSkaters 
	speech_box_exit 
ENDSCRIPT

SCRIPT panel_message_new_horse_spot blink_time = 0.05000000075 
	FormatText ChecksumName = text_color "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	SetProps just = [ right top ] rgba = <text_color> 
	DoMorph pos = PAIR(445.00000000000, 175.00000000000) 
	DoMorph pos = PAIR(445.00000000000, 175.00000000000) time = 1.20000004768 
	DoMorph pos = PAIR(630.00000000000, 63.00000000000) scale = 1.29999995232 time = 0.10000000149 
	DoMorph pos = PAIR(630.00000000000, 63.00000000000) scale = 0.80000001192 time = 0.10999999940 
	BEGIN 
		DoMorph alpha = 0 
		Wait <blink_time> seconds 
		DoMorph alpha = 1 
		Wait <blink_time> seconds 
	REPEAT 6 
ENDSCRIPT

goal_horse_mp_genericParams = { 
	goal_text = "Complete the other players\' tricks!" 
	time = 10 
	net 
	init = goal_horse_mp_init 
	activate = goal_horse_mp_activate 
	deactivate = goal_horse_mp_deactivate 
	expire = goal_horse_mp_expire 
	goal_description = "Horse!" 
} 
SCRIPT goal_horse_mp_init 
ENDSCRIPT

SCRIPT goal_horse_mp_activate 
	RunScriptOnScreenElement id = the_time clock_morph 
	ResetScore 
ENDSCRIPT

SCRIPT goal_horse_mp_deactivate 
	IF ObjectExists id = horse_score_menu 
		DestroyScreenElement id = horse_score_menu 
	ENDIF 
	printf "DEACTIVATE HORSE" 
ENDSCRIPT

SCRIPT horse_mp_done 
	dialog_box_exit 
	do_backend_retry 
ENDSCRIPT

SCRIPT goal_horse_mp_expire 
	printf "EXPIRE HORSE" 
	IF ObjectExists id = goal_message 
		DestroyScreenElement id = goal_message 
	ENDIF 
	printf "goal_horse_mp_expire" 
ENDSCRIPT

SCRIPT AddGoal_Horse_Mp 
	GoalManager_AddGoal name = horse_mp { 
		params = { goal_horse_mp_genericParams } 
	} 
ENDSCRIPT

SCRIPT StartGoal_Horse_Mp 
	GoalManager_EditGoal name = horse_mp params = <...> 
	GoalManager_ActivateGoal name = horse_mp 
	create_horse_score_menu 
ENDSCRIPT

SCRIPT EndGoal_Horse_Mp 
	GoalManager_DeactivateGoal name = horse_mp 
ENDSCRIPT

SCRIPT create_horse_score_menu 
	IF NOT ObjectExists id = horse_score_menu 
		SetScreenElementLock id = root_window off 
		CreateScreenElement { 
			type = ContainerElement 
			parent = root_window 
			id = horse_score_menu 
			font = dialog 
			pos = PAIR(0.00000000000, 30.00000000000) 
			just = [ left top ] 
			scale = 0 
			dims = PAIR(640.00000000000, 480.00000000000) 
		} 
		CreateScreenElement { 
			type = VMenu 
			parent = horse_score_menu 
			id = horse_score_vmenu 
			font = dialog 
			just = [ left top ] 
			pos = PAIR(45.00000000000, 60.00000000000) 
			scale = 0.89999997616 
			padding_scale = 0.69999998808 
			internal_scale = 1 
			internal_just = [ left top ] 
		} 
		<index> = 1 
		BEGIN 
			FormatText ChecksumName = current_id "horse_score_%i" i = <index> 
			CreateScreenElement { 
				type = TextElement 
				parent = horse_score_vmenu 
				id = <current_id> 
				font = dialog 
				text = "" 
				scale = 0.89999997616 
				rgba = [ 108 112 120 128 ] 
				not_focusable 
				z_priority = -5 
			} 
			<index> = ( <index> + 1 ) 
		REPEAT 3 
		RunScriptOnScreenElement id = horse_score_menu menu_onscreen params = { preserve_menu_state } 
	ENDIF 
ENDSCRIPT

SCRIPT update_horse_score 
	IF ObjectExists id = horse_score_menu 
		SetScreenElementProps { 
			id = <id> 
			text = <text> 
		} 
	ENDIF 
ENDSCRIPT


