
Goal_Comp_GenericParams = { 
	goal_text = "Competition test..." 
	goal_description = "3 Runs\\nYou lose points for bailing\\nBest two runs wins" 
	view_goals_text = "Medal the Competition" 
	time = 30 
	init = goal_comp_init 
	uninit = goal_uninit 
	activate = goal_comp_activate 
	deactivate = goal_comp_deactivate 
	expire = goal_comp_expire 
	success = goal_comp_success 
	trigger_obj_id = TRG_G_JUDGE_COMP 
	geo_prefix = "G_COMP_" 
	restart_node = TRG_G_COMP_RestartNode 
	start_pad_id = G_COMP_StartPad 
	already_ended_run = 0 
	competition 
	record_type = score 
} 
Goal_Comp2_GenericParams = { 
	goal_text = "Competition2 test..." 
	goal_description = "3 Runs\\nYou lose points for bailing\\nBest two runs wins" 
	view_goals_text = "Medal the Competition" 
	time = 30 
	init = goal_comp_init 
	uninit = goal_uninit 
	activate = goal_comp_activate 
	deactivate = goal_comp_deactivate 
	expire = goal_comp_expire 
	success = goal_comp_success 
	trigger_obj_id = TRG_G_JUDGE_COMP2 
	geo_prefix = "G_COMP2_" 
	restart_node = TRG_G_COMP2_RestartNode 
	start_pad_id = G_COMP2_StartPad 
	already_ended_run = 0 
	competition 
	record_type = score 
} 
SCRIPT goal_comp_init 
	goal_init goal_id = <goal_id> 
ENDSCRIPT

SCRIPT goal_comp_activate 
	GoalManager_EditGoal name = <goal_id> params = { already_ended_run = 0 } 
	goal_start goal_id = <goal_id> 
	GoalManager_PauseCompetition name = <goal_id> 
	IF NOT CompetitionEnded 
		EndCompetition 
	ENDIF 
	IF GotParam leader_board_names 
		PermuteArray NewArrayName = leader_board_names Array = <leader_board_names> 
	ENDIF 
	StartCompetition { 
		gold = <gold> 
		silver = <silver> 
		bronze = <bronze> 
		gold_score = <gold_score> 
		silver_score = <silver_score> 
		bronze_score = <bronze_score> 
		bail = <bail> 
		extra_params = { 
			leader_board_names = <leader_board_names> 
			first_place_name = <first_place_name> 
		} 
	} 
	SetScoreAccumulation 1 
	StartCompetitionRun 
	Skater : RunStarted 
	KillSpawnedScript name = KillNixonTimer 
	wait 0.10000000149 seconds 
	IF ObjectExists id = nixon_timer_box 
		DestroyScreenElement id = nixon_timer_box 
		wait 0.10000000149 seconds 
	ENDIF 
	CreateScreenElement { 
		type = ContainerElement 
		id = nixon_timer_box 
		parent = root_window 
		pos = PAIR(311.00000000000, 35.00000000000) 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = nixon_timer_box 
		id = nixon_timer_sprite 
		texture = nixon 
		scale = PAIR(1.70000004768, 1.70000004768) 
		just = [ center center ] 
		z_priority = -2000 
	} 
	DoScreenElementMorph id = nixon_timer_sprite time = 0 scale = PAIR(0.00000000000, 0.00000000000) alpha = 0 
	DoScreenElementMorph id = nixon_timer_sprite time = 0.30000001192 scale = PAIR(0.72500002384, 0.72500002384) alpha = 1 
ENDSCRIPT

SCRIPT goal_comp_expire 
	kill_start_key_binding 
	GoalManager_GetGoalParams name = <goal_id> 
	GoalManager_EditGoal name = <goal_id> params = { already_ended_run = 1 } 
	pause_trick_text 
	GoalManager_PauseCompetition name = <goal_id> 
	IF NOT RoundIs 3 
		GoalManager_SetGoalTimer name = <goal_id> 
	ENDIF 
	SpawnSkaterScript goal_comp_expire2 params = <...> 
ENDSCRIPT

SCRIPT goal_comp_expire2 
	root_window : SetTags giving_rewards = 1 
	root_window : SetTags showing_comp_results = 1 
	IF ObjectExists id = goal_comp_out_of_bounds_warning 
		DestroyScreenElement id = goal_comp_out_of_bounds_warning 
	ENDIF 
	wait 1 frame 
	PauseSkaters 
	IF RoundIs 3 
		EndCompetitionRun 
		WaitForEvent type = comp_continue 
		goal_comp_show_results goal_id = <goal_id> 
		WaitForEvent type = comp_continue 
		GoalManager_UnPauseCompetition name = <goal_id> 
		GoalManager_DeactivateGoal name = <goal_id> 
	ELSE 
		EndCompetitionRun 
		ResetScore 
		WaitForEvent type = comp_continue 
		IF ObjectExists id = goal_comp_out_of_bounds_warning 
			DestroyScreenElement id = goal_comp_out_of_bounds_warning 
		ENDIF 
		IF ObjectExists id = comp_root_anchor 
			DestroyScreenElement id = comp_root_anchor 
		ENDIF 
		ResetSkaters node_name = <restart_node> 
		GoalManager_EditGoal name = <goal_id> params = { already_ended_run = 0 } 
		SetScoreAccumulation 1 
		StartCompetitionRun 
		DeBounce X time = 0.30000001192 clear = 1 
		wait 1 frame 
		GoalManager_UnPauseCompetition name = <goal_id> 
		RunStarted 
	ENDIF 
	root_window : SetTags giving_rewards = 0 
	root_window : SetTags showing_comp_results = 0 
ENDSCRIPT

SCRIPT goal_comp_deactivate 
	KillSkaterCamAnim all 
	KillSpawnedScript name = goal_comp_expire2 
	KillSpawnedScript name = goal_comp_end_current_run 
	EndCompetition 
	GoalManager_ResetGoalTrigger name = <goal_id> 
	goal_deactivate goal_id = <goal_id> 
	IF ObjectExists id = comp_root_anchor 
		DestroyScreenElement id = comp_root_anchor 
	ENDIF 
	IF ObjectExists id = goal_comp_out_of_bounds_warning 
		DestroyScreenElement id = goal_comp_out_of_bounds_warning 
	ENDIF 
	IF ObjectExists id = comp_leader_board_anchor 
		DestroyScreenElement id = comp_leader_board_anchor 
	ENDIF 
	IF ObjectExists id = comp_scores_anchor 
		DestroyScreenElement id = comp_scores_anchor 
	ENDIF 
	unpause_trick_text 
	KillSpawnedScript name = KillNixonTimer 
	wait 0.10000000149 seconds 
	SpawnScript KillNixonTimer 
	ResetSkaters node_name = <restart_node> 
	MakeSkaterGoto HandBrake 
ENDSCRIPT

SCRIPT KillNixonTimer 
	IF ObjectExists nixon_timer_box 
		DoScreenElementMorph id = nixon_timer_sprite time = 0.30000001192 scale = PAIR(0.00000000000, 0.00000000000) alpha = 0 
		RunScriptOnScreenElement id = the_time clock_morph 
		wait 0.50000000000 seconds 
		DestroyScreenElement id = nixon_timer_box 
	ENDIF 
	KillSpawnedScript name = KillNixonTimer 
ENDSCRIPT

SCRIPT goal_comp_leave_area 
	IF GoalManager_GoalIsActive name = <goal_id> 
		create_panel_message id = goal_comp_out_of_bounds_warning text = "You\'re out of the competition area!" style = goal_comp_out_of_bounds_text 
		ResetScorePot UseBailStyle 
		SetScoreAccumulation 0 freeze_score 
	ENDIF 
ENDSCRIPT

SCRIPT goal_comp_enter_area 
	IF GoalManager_GoalIsActive name = <goal_id> 
		IF ObjectExists id = goal_comp_out_of_bounds_warning 
			DestroyScreenElement id = goal_comp_out_of_bounds_warning 
		ENDIF 
		ResetScorePot 
		SetScoreAccumulation 1 
	ENDIF 
ENDSCRIPT

SCRIPT goal_comp_enable_input 
	EnablePlayerInput 
ENDSCRIPT

SCRIPT goal_comp_continue 
	KillSpawnedScript name = goal_comp_show_run_scores 
	KillSpawnedScript name = goal_comp_add_leader_board 
	SetScreenElementProps { 
		id = root_window 
		event_handlers = [ { pad_start handle_start_pressed } ] 
		replace_handlers 
	} 
	IF ObjectExists id = comp_root_anchor 
		DestroyScreenElement id = comp_root_anchor 
	ENDIF 
	unpause_trick_text 
	UnPauseSkaters 
	DeBounce X time = 0.30000001192 clear = 1 
	FireEvent type = comp_continue 
	speech_box_exit 
ENDSCRIPT

SCRIPT goal_comp_success 
	goal_success goal_id = <goal_id> 
ENDSCRIPT

SCRIPT goal_comp_show_run_scores 
	SetScreenElementLock id = root_window off 
	CreateScreenElement { 
		type = ContainerElement 
		parent = root_window 
		id = comp_root_anchor 
		dims = PAIR(640.00000000000, 480.00000000000) 
		pos = PAIR(340.00000000000, 250.00000000000) 
	} 
	PauseSkaters 
	SetScreenElementProps { 
		id = root_window 
		event_handlers = [ { pad_start nullscript } ] 
		replace_handlers 
	} 
	CreateScreenElement { 
		type = ContainerElement 
		parent = comp_root_anchor 
		id = comp_scores_anchor 
		pos = PAIR(330.00000000000, 250.00000000000) 
		dims = PAIR(640.00000000000, 480.00000000000) 
	} 
	CreateScreenElement { 
		type = HMenu 
		parent = comp_scores_anchor 
		id = scores_hmenu 
		pos = PAIR(400.00000000000, 117.00000000000) 
		just = [ right top ] 
		padding_scale = 1.29999995232 
		regular_space_amount = 40 
	} 
	FormatText TextName = score_text "%i" i = ( <total_score> ) 
	CreateScreenElement { 
		type = TextElement 
		id = goal_comp_average_score 
		scale = ( 1.00000000000 ) 
		parent = comp_scores_anchor 
		pos = PAIR(460.00000000000, 117.00000000000) 
		just = [ right top ] 
		font = dialog 
		text = <score_text> 
		rgba = [ 0 0 0 0 ] 
		not_focusable 
		z_priority = 10 
	} 
	CreateScreenElement { 
		type = TextElement 
		parent = comp_scores_anchor 
		id = comp_scores_judges 
		font = small 
		text = "Judges" 
		rgba = [ 128 128 128 108 ] 
		pos = PAIR(128.00000000000, 98.00000000000) 
		just = [ left top ] 
		scale = 0.89999997616 
	} 
	CreateScreenElement { 
		type = TextElement 
		parent = comp_scores_anchor 
		id = comp_scores_judge1 
		font = small 
		text = "1" 
		rgba = [ 88 105 112 128 ] 
		pos = PAIR(215.00000000000, 98.00000000000) 
		just = [ left top ] 
		scale = 0.89999997616 
	} 
	CreateScreenElement { 
		type = TextElement 
		parent = comp_scores_anchor 
		id = comp_scores_judge2 
		font = small 
		text = "2" 
		rgba = [ 88 105 112 128 ] 
		pos = PAIR(253.00000000000, 98.00000000000) 
		just = [ left top ] 
		scale = 0.89999997616 
	} 
	CreateScreenElement { 
		type = TextElement 
		parent = comp_scores_anchor 
		id = comp_scores_judge3 
		font = small 
		text = "3" 
		rgba = [ 88 105 112 128 ] 
		pos = PAIR(293.00000000000, 98.00000000000) 
		just = [ left top ] 
		scale = 0.89999997616 
	} 
	CreateScreenElement { 
		type = TextElement 
		parent = comp_scores_anchor 
		id = comp_scores_judge4 
		font = small 
		text = "4" 
		rgba = [ 88 105 112 128 ] 
		pos = PAIR(333.00000000000, 98.00000000000) 
		just = [ left top ] 
		scale = 0.89999997616 
	} 
	CreateScreenElement { 
		type = TextElement 
		parent = comp_scores_anchor 
		id = comp_scores_judge5 
		font = small 
		text = "5" 
		rgba = [ 88 105 112 128 ] 
		pos = PAIR(374.00000000000, 98.00000000000) 
		just = [ left top ] 
		scale = 0.89999997616 
	} 
	CreateScreenElement { 
		type = TextElement 
		parent = comp_scores_anchor 
		id = comp_scores_average 
		font = small 
		text = "Average" 
		rgba = [ 128 128 128 108 ] 
		pos = PAIR(414.00000000000, 98.00000000000) 
		just = [ left top ] 
		scale = 0.89999997616 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = comp_scores_anchor 
		texture = comp_tall_line 
		pos = PAIR(115.00000000000, 92.00000000000) 
		scale = PAIR(1.20000004768, 0.69999998808) 
		just = [ center top ] 
		rgba = [ 128 128 128 110 ] 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = comp_scores_anchor 
		texture = comp_tall_line 
		pos = PAIR(200.00000000000, 92.00000000000) 
		scale = PAIR(1.20000004768, 0.69999998808) 
		just = [ center top ] 
		rgba = [ 128 128 128 110 ] 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = comp_scores_anchor 
		texture = comp_tall_line 
		pos = PAIR(400.00000000000, 92.00000000000) 
		scale = PAIR(1.20000004768, 0.69999998808) 
		just = [ center top ] 
		rgba = [ 128 128 128 110 ] 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = comp_scores_anchor 
		texture = comp_tall_line 
		pos = PAIR(238.00000000000, 92.00000000000) 
		scale = PAIR(1.20000004768, 0.69999998808) 
		just = [ center top ] 
		rgba = [ 128 128 128 110 ] 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = comp_scores_anchor 
		texture = comp_tall_line 
		pos = PAIR(280.00000000000, 92.00000000000) 
		scale = PAIR(1.20000004768, 0.69999998808) 
		just = [ center top ] 
		rgba = [ 128 128 128 110 ] 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = comp_scores_anchor 
		texture = comp_tall_line 
		pos = PAIR(318.00000000000, 92.00000000000) 
		scale = PAIR(1.20000004768, 0.69999998808) 
		just = [ center top ] 
		rgba = [ 128 128 128 110 ] 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = comp_scores_anchor 
		texture = comp_tall_line 
		pos = PAIR(358.00000000000, 92.00000000000) 
		scale = PAIR(1.20000004768, 0.69999998808) 
		just = [ center top ] 
		rgba = [ 128 128 128 110 ] 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = comp_scores_anchor 
		texture = comp_fill 
		pos = PAIR(288.00000000000, 91.00000000000) 
		scale = PAIR(58.50000000000, 1.00000000000) 
		just = [ center top ] 
		rgba = [ 80 80 80 110 ] 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = comp_scores_anchor 
		texture = comp_end_cap 
		pos = PAIR(484.00000000000, 91.00000000000) 
		scale = PAIR(1.29999995232, 0.98000001907) 
		just = [ center top ] 
		rgba = [ 80 80 80 110 ] 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = comp_scores_anchor 
		texture = options_bg 
		pos = PAIR(309.00000000000, 118.00000000000) 
		scale = PAIR(1.66999995708, 0.69999998808) 
		just = [ center top ] 
		rgba = [ 15 15 15 80 ] 
	} 
	GetArraySize <scores> 
	index = 0 
	BEGIN 
		FormatText ChecksumName = score_id "score%i" i = <index> 
		goal_comp_add_score_to_hmenu ( <scores> [ <index> ] ) id = <score_id> 
		index = ( <index> + 1 ) 
	REPEAT <array_size> 
	RunScriptOnScreenElement id = comp_scores_anchor goal_comp_animate_scores 
	create_speech_box text = "Press \\m0 to continue" pos = PAIR(320.00000000000, 400.00000000000) pad_choose_script = goal_comp_skip_scores pad_choose_params = { scores = <scores> } 
	WaitForEvent type = goal_comp_scores_done 
	SetScreenElementProps { 
		id = goal_comp_average_score 
		rgba = [ 117 14 14 100 ] 
	} 
ENDSCRIPT

SCRIPT goal_comp_animate_scores 
	DoMorph time = 0 scale = 1.00000000000 alpha = 0 pos = PAIR(305.00000000000, 0.00000000000) 
	wait 1 frame 
	DoMorph time = 0.20000000298 scale = 1.00000000000 alpha = 1 pos = PAIR(305.00000000000, 232.00000000000) 
ENDSCRIPT

SCRIPT goal_comp_add_score_to_hmenu 
	FormatText TextName = score_text "%i" i = ( <score> ) 
	CreateScreenElement { 
		type = TextElement 
		parent = scores_hmenu 
		font = dialog 
		text = <score_text> 
		not_focusable 
	} 
	IF NOT GotParam top_judge 
		RunScriptOnScreenElement id = <id> goal_comp_fade_lower_score 
	ENDIF 
ENDSCRIPT

SCRIPT goal_comp_fade_lower_score 
	wait 1 second 
	DoMorph time = 1.20000004768 alpha = 0.30000001192 
	FireEvent type = goal_comp_scores_done 
ENDSCRIPT

SCRIPT goal_comp_skip_scores 
	GetArraySize <scores> 
	index = 0 
	BEGIN 
		FormatText ChecksumName = score_id "score%i" i = <index> 
		IF NOT StructureContains structure = ( <scores> [ <index> ] ) top_judge 
			IF ObjectExists id = <score_id> 
				DoScreenElementMorph id = <score_id> alpha = 0.30000001192 
			ENDIF 
		ENDIF 
		index = ( <index> + 1 ) 
	REPEAT <array_size> 
	SetScreenElementProps { 
		id = goal_comp_average_score 
		rgba = [ 127 102 0 128 ] 
	} 
	IF RoundIs 3 
	ENDIF 
	FireEvent type = goal_comp_scores_done 
ENDSCRIPT

SCRIPT goal_comp_end_current_run 
	IF ObjectExists id = current_menu_anchor 
		exit_pause_menu 
	ENDIF 
	IF GoalManager_IsInCompetition 
		GoalManager_EditGoal name = <goal_id> params = { already_ended_run = 1 } 
		GoalManager_PauseCompetition name = <goal_id> 
		KillSpawnedScript name = SK3_Killskater_Finish 
		GoalManager_GetGoalParams name = <goal_id> 
		ResetSkaters node_name = <restart_node> 
		goal_comp_expire goal_id = <goal_id> 
	ELSE 
		printf "WARNING: you\'re not in a competition!!!" 
	ENDIF 
ENDSCRIPT

SCRIPT goal_comp_add_leader_board 
	WaitForEvent type = goal_comp_scores_done 
	SpawnScript TemporarilyDisableInput params = { time = 1500 } 
	IF ObjectExists id = speech_box_anchor 
		SetScreenElementProps { 
			id = speech_box_anchor 
			event_handlers = [ { pad_choose goal_comp_continue } ] 
			replace_handlers 
		} 
	ENDIF 
	wait 20 frame 
	IF NOT ObjectExists id = comp_root_anchor 
		RETURN 
	ENDIF 
	SetScreenElementProps { 
		id = root_window 
		event_handlers = [ { pad_start goal_comp_continue } ] 
		replace_handlers 
	} 
	SetScreenElementLock id = comp_root_anchor off 
	CreateScreenElement { 
		type = ContainerElement 
		parent = comp_root_anchor 
		id = comp_leader_board_anchor 
		pos = PAIR(300.00000000000, 232.00000000000) 
		dims = PAIR(640.00000000000, 480.00000000000) 
	} 
	CreateScreenElement { 
		type = VMenu 
		parent = comp_leader_board_anchor 
		id = comp_leader_board_vmenu 
		pos = PAIR(208.00000000000, 169.00000000000) 
		internal_just = [ left center ] 
		just = [ center top ] 
		z_priority = 20 
	} 
	CreateScreenElement { 
		type = TextElement 
		parent = comp_leader_board_vmenu 
		id = comp_leader_board_vmenu_title 
		font = testtitle 
		text = "STANDINGS" 
		rgba = [ 128 128 128 75 ] 
		just = [ left top ] 
		scale = 1.37000000477 
		not_focusable 
	} 
	IF RoundIs 1 
		FormatText TextName = round_info "(AFTER 1 ROUND)" 
	ELSE 
		IF RoundIs 2 
			FormatText TextName = round_info "(AFTER 2 ROUNDS)" 
		ELSE 
			FormatText TextName = round_info "(BEST 2 ROUNDS)" 
		ENDIF 
	ENDIF 
	CreateScreenElement { 
		type = TextElement 
		parent = comp_leader_board_vmenu_title 
		font = dialog 
		text = <round_info> 
		rgba = [ 117 14 14 90 ] 
		pos = PAIR(264.00000000000, 0.00000000000) 
		scale = 0.64999997616 
		just = [ right top ] 
		not_focusable 
	} 
	IF LevelIs load_FL 
		CreateScreenElement { 
			type = SpriteElement 
			parent = comp_leader_board_anchor 
			texture = spot_goals 
			pos = PAIR(100.00000000000, 139.00000000000) 
			scale = ( 1.20000004768 ) 
			just = [ center top ] 
			SetProps rgba = [ 128 128 128 110 ] 
			z_priority = 100 
		} 
	ELSE 
		IF LevelIs load_SJ 
			CreateScreenElement { 
				type = SpriteElement 
				parent = comp_leader_board_anchor 
				texture = scj_goals 
				pos = PAIR(105.00000000000, 128.00000000000) 
				scale = ( 1.29999995232 ) 
				just = [ center top ] 
				SetProps rgba = [ 128 128 128 110 ] 
				z_priority = 100 
			} 
		ELSE 
			IF LevelIs load_HI 
				FormatText ChecksumName = hi_goals_icon "5050_goals" 
				CreateScreenElement { 
					type = SpriteElement 
					parent = comp_leader_board_anchor 
					texture = <hi_goals_icon> 
					pos = PAIR(106.00000000000, 132.00000000000) 
					scale = ( 1.20000004768 ) 
					just = [ center top ] 
					SetProps rgba = [ 128 128 128 110 ] 
					z_priority = 100 
				} 
			ELSE 
				CreateScreenElement { 
					type = SpriteElement 
					parent = comp_leader_board_anchor 
					texture = PA_goals 
					pos = PAIR(100.00000000000, 132.00000000000) 
					scale = ( 1.20000004768 ) 
					just = [ center top ] 
					SetProps rgba = [ 128 128 128 110 ] 
					z_priority = 100 
				} 
			ENDIF 
		ENDIF 
	ENDIF 
	CreateScreenElement { 
		type = SpriteElement 
		parent = comp_leader_board_anchor 
		texture = options_bg 
		pos = PAIR(315.00000000000, 160.00000000000) 
		scale = PAIR(1.70000004768, 1.00000000000) 
		just = [ center top ] 
		rgba = [ 80 80 80 128 ] 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = comp_leader_board_anchor 
		texture = comp_hori_lines 
		pos = PAIR(316.00000000000, 186.00000000000) 
		scale = PAIR(55.50000000000, 0.95999997854) 
		just = [ center top ] 
		rgba = [ 128 128 128 90 ] 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = comp_leader_board_anchor 
		texture = comp_tall_line 
		pos = PAIR(120.00000000000, 165.00000000000) 
		scale = PAIR(1.20000004768, 2.25000000000) 
		just = [ center top ] 
		rgba = [ 0 0 0 108 ] 
		z_priority = 30 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = comp_leader_board_anchor 
		texture = comp_tall_line 
		pos = PAIR(512.00000000000, 165.00000000000) 
		scale = PAIR(1.20000004768, 2.25000000000) 
		just = [ center top ] 
		rgba = [ 0 0 0 108 ] 
		z_priority = 30 
	} 
	ForEachIn <leader_board> do = goal_comp_add_leader_board_entry 
	RunScriptOnScreenElement id = comp_leader_board_anchor goal_comp_animate_leaderboard 
ENDSCRIPT

SCRIPT goal_comp_animate_leaderboard 
	DoMorph time = 0 scale = 0.00000000000 alpha = 0 
	wait 20 frame 
	PlaySound BailSlap01 
	DoMorph time = 0.20000000298 scale = 1.00000000000 alpha = 1 
ENDSCRIPT

SCRIPT goal_comp_add_leader_board_entry 
	CreateScreenElement { 
		type = TextElement 
		parent = comp_leader_board_vmenu 
		font = small 
		text = <name> 
		rgba = [ 128 128 128 128 ] 
		not_focusable 
		just = [ left top ] 
	} 
	<leader_board_name_id> = <id> 
	FormatText TextName = score_text "%i" i = ( <score> ) 
	CreateScreenElement { 
		type = TextElement 
		parent = <leader_board_name_id> 
		font = dialog 
		text = <score_text> 
		pos = PAIR(320.00000000000, 0.00000000000) 
		just = [ right top ] 
	} 
	IF GotParam player 
		SetScreenElementProps { 
			id = <leader_board_name_id> 
			rgba = [ 127 102 0 128 ] 
		} 
		SetScreenElementProps { 
			id = <id> 
			rgba = [ 127 102 0 128 ] 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT goal_comp_show_results 
	IF PlaceIs 1 
		create_speech_box text = "You got gold!" no_pad_start pad_choose_script = nullscript style = goal_comp_speech_box_style 
		GoalManager_WinGoal name = <goal_id> 
	ELSE 
		IF PlaceIs 2 
			create_speech_box text = "You got silver!" no_pad_start pad_choose_script = nullscript style = goal_comp_speech_box_style 
			GoalManager_WinGoal name = <goal_id> 
		ELSE 
			IF PlaceIs 3 
				create_speech_box text = "You got bronze!" no_pad_start pad_choose_script = nullscript style = goal_comp_speech_box_style 
				GoalManager_WinGoal name = <goal_id> 
			ELSE 
				create_speech_box text = "You didn\'t get a medal" no_pad_start pad_choose_script = null_script style = goal_comp_speech_box_style 
				GoalManager_LoseGoal name = <goal_id> 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT goal_comp_out_of_bounds_text 
	DoMorph time = 0 pos = PAIR(320.00000000000, 140.00000000000) 
ENDSCRIPT

SCRIPT goal_comp_speech_box_style 
	wait 2000 
	Die 
ENDSCRIPT


