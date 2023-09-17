
pro_team_members = [ 
	{ pro = burnquist movie_text = "Burnquis" text = "Burnquist" } 
	{ pro = hawk movie_text = "Hawk" text = "Hawk" } 
	{ pro = koston movie_text = "Koston" text = "Koston" } 
	{ pro = lasek movie_text = "Lasek" text = "Lasek" } 
	{ pro = margera movie_text = "Margera" text = "Margera" } 
	{ pro = mullen movie_text = "Mullen" text = "Mullen" } 
	{ pro = muska movie_text = "Muska" text = "Muska" } 
	{ pro = reynolds movie_text = "Reynolds" text = "Reynolds" } 
	{ pro = rodriguez movie_text = "Rodrigue" text = "Rodriguez" } 
	{ pro = rowley movie_text = "Rowley" text = "Rowley" } 
	{ pro = saari movie_text = "Saari" text = "Saari" } 
	{ pro = thomas movie_text = "Thomas" text = "Thomas" } 
	{ pro = vallely movie_text = "Vallely" text = "Vallely" } 
] 
SCRIPT goal_team_select_init 
	IF InNetGame 
		RETURN 
	ENDIF 
	GoalManager_GetGoalParams name = <goal_id> 
	IF GotParam team_pro 
		IF ( <team_pro> = none ) 
			RemoveParameter team_pro 
		ENDIF 
	ENDIF 
	IF GotParam last_start_was_quick_start 
		IF ( <last_start_was_quick_start> = 1 ) 
			IF GotParam team_pro 
				RETURN 
			ENDIF 
		ENDIF 
	ENDIF 
	GoalManager_GetCurrentChapterAndStage 
	IF ( <currentChapter> > 25 ) 
		RETURN 
	ENDIF 
	Skater : Hide 
	PauseGame 
	PauseSkaters 
	GoalManager_GetTeam 
	IF GoalManager_HasWonGoal name = <goal_id> 
		IF GotParam team_pro 
			load_pro_skater name = <team_pro> 
			UnPauseGame 
			UnpauseSkaters 
			RETURN 
		ENDIF 
	ENDIF 
	IF ( ( GotParam horse ) | ( GotParam tour ) ) 
	ENDIF 
	GoalManager_PauseGoal name = <goal_id> 
	PauseSkaters 
	Skater : Hide 
	SetScreenElementLock id = root_window off 
	IF ScreenElementExists id = team_menu 
		DestroyScreenElement id = team_menu 
	ENDIF 
	FormatText ChecksumName = title_icon "%i_options" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	make_new_themed_sub_menu title = "SELECT TEAMMATE" title_icon = <title_icon> 
	pause_menu_gradient on 
	GetArraySize pro_team_members 
	<index> = 0 
	<num_so_far> = 0 
	BEGIN 
		<pro_name> = ( ( pro_team_members [ <index> ] ) . pro ) 
		IF StructureContains structure = <team> <pro_name> 
			IF ( <team> . <pro_name> = 1 ) 
				<not_focusable> = not_focusable 
				<rgba> = [ 60 60 60 75 ] 
			ELSE 
				RemoveParameter not_focusable 
				RemoveParameter rgba 
			ENDIF 
			IF ( <num_so_far> = 4 ) 
				last_menu_item = last_menu_item 
			ENDIF 
			theme_menu_add_item { 
				text = ( ( pro_team_members [ <index> ] ) . text ) 
				pad_choose_script = goal_team_select_member_chosen 
				pad_choose_params = { pro = <pro_name> goal_id = <goal_id> restart_node = <restart_node> } 
				not_focusable = <not_focusable> 
				rgba = <rgba> 
				last_menu_item = <last_menu_item> 
				centered 
			} 
			<num_so_far> = ( <num_so_far> + 1 ) 
		ENDIF 
		<index> = ( <index> + 1 ) 
	REPEAT <array_size> 
	finish_themed_sub_menu time = 0.20000000298 
	create_helper_text generic_helper_text_no_back 
	GoalManager_HideGoalPoints 
	GoalManager_HidePoints 
	root_window : SetTags menu_state = on 
	WaitForEvent type = goal_select_team_member_done 
	pause_menu_gradient off 
ENDSCRIPT

SCRIPT goal_team_select_member_chosen 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	DeBounce X time = 0.50000000000 
	IF GotParam goal_id 
		GoalManager_EditGoal name = <goal_id> params = { team_pro = <pro> } 
	ENDIF 
	Skater : StatsManager_DeactivateGoals 
	load_pro_skater name = <pro> 
	UnPauseGame 
	ResetSkaters node_name = <restart_node> 
	GoalManager_UnPauseGoal name = <goal_id> 
	GoalManager_ShowGoalPoints 
	GoalManager_ShowPoints 
	root_window : SetTags menu_state = off 
	restore_start_key_binding 
	FireEvent type = goal_select_team_member_done 
ENDSCRIPT

SCRIPT goal_team_select_deactivate 
	IF InNetGame 
		RETURN 
	ENDIF 
	GoalManager_GetGoalParams name = <goal_id> 
	IF GotParam quick_start 
		RETURN 
	ENDIF 
	Skater : Vibrate off 
	load_pro_skater name = custom 
	Skater : StatsManager_ActivateGoals 
	ResetSkaters node_name = <restart_node> 
	MakeSkaterGoto HandBrake 
	IF NOT GoalManager_HasWonGoal name = <goal_id> 
		IF NOT GotParam just_won_goal 
			GoalManager_EditGoal name = <goal_id> params = { team_pro = none } 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT goal_team_select_success 
	IF GotParam goal_id 
		GoalManager_GetGoalParams name = <goal_id> 
		IF GotParam team_pro 
			GoalManager_SetTeamMember pro = <team_pro> mark_used 
		ENDIF 
	ENDIF 
ENDSCRIPT


