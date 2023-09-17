
goal_scorechallenge_genericParams = { 
	goal_text = "You must score the most points to win!" 
	unlimited_time = 1 
	score = 1000000 
	net 
	init = goal_scorechallenge_init 
	activate = goal_scorechallenge_activate 
	active = goal_scorechallenge_active 
	deactivate = goal_scorechallenge_deactivate 
	goal_description = "Score Challenge!" 
} 
SCRIPT goal_scorechallenge_init 
ENDSCRIPT

SCRIPT goal_scorechallenge_activate 
	IF InSplitScreenGame 
		MakeSkaterGosub add_skater_to_world skater = 0 
		MakeSkaterGosub add_skater_to_world skater = 1 
		ScriptGetScreenMode 
		SWITCH <screen_mode> 
			CASE split_vertical 
				msg_pos = PAIR(350, 42) 
			CASE split_horizontal 
				msg_pos = PAIR(620, 27) 
		ENDSWITCH 
	ELSE 
		msg_pos = PAIR(620, 27) 
	ENDIF 
	IF InNetGame 
		SWITCH <score> 
			CASE 100000 
				score_string = "100,000 pts" 
			CASE 250000 
				score_string = "250,000 pts" 
			CASE 500000 
				score_string = "500,000 pts" 
			CASE 1000000 
				score_string = "1,000,000 pts" 
			CASE 2000000 
				score_string = "2,000,000 pts" 
			CASE 5000000 
				score_string = "5,000,000 pts" 
			CASE 10000000 
				score_string = "10,000,000 pts" 
			CASE 50000000 
				score_string = "50,000,000 pts" 
			CASE 100000000 
				score_string = "100,000,000 pts" 
		ENDSWITCH 
		IF InTeamGame 
			FormatText TextName = msg_text "\\c3Score \\n\\c3Challenge:\\n\\c0%s \\nto win" s = <score_string> 
		ELSE 
			FormatText TextName = msg_text "\\c3Score \\n\\c3Challenge:\\n\\c0%s \\nto win" s = <score_string> 
		ENDIF 
		create_panel_block id = sc_goal_text text = <msg_text> style = panel_message_goal final_pos = <msg_pos> 
	ENDIF 
	printf "************** ACTIVATING SCORECHALLENGE **********************" 
	ResetScore 
ENDSCRIPT

SCRIPT goal_scorechallenge_active 
	IF AnySkaterTotalScoreAtLeast <score> 
		IF OnServer 
			IF CalculateFinalScores 
				GoalManager_DeactivateGoal name = <goal_id> 
				goal_scorechallenge_finished 
			ENDIF 
		ELSE 
			GoalManager_DeactivateGoal name = <goal_id> 
			goal_scorechallenge_finished 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT goal_scorechallenge_deactivate 
	destroy_goal_panel_messages 
	IF ObjectExists id = sc_goal_text 
		DestroyScreenElement id = sc_goal_text 
	ENDIF 
ENDSCRIPT

SCRIPT goal_scorechallenge_finished 
	destroy_goal_panel_messages 
	IF ObjectExists id = sc_goal_text 
		DestroyScreenElement id = sc_goal_text 
	ENDIF 
	printf "goal_scorechallenge_deactivate" 
	ResetScorePot 
	IF OnServer 
		IF InInternetMode 
			ReportStats final 
		ENDIF 
	ENDIF 
	create_rankings 
ENDSCRIPT

SCRIPT scorechallenge_done 
	dialog_box_exit 
	do_backend_retry 
ENDSCRIPT

SCRIPT AddGoal_scorechallenge 
	GoalManager_AddGoal name = scorechallenge { 
		params = { goal_scorechallenge_genericParams 
		} 
	} 
ENDSCRIPT

SCRIPT StartGoal_scorechallenge 
	IF InSplitScreenGame 
		SetScreenModeFromGameMode 
	ENDIF 
	GoalManager_EditGoal name = scorechallenge params = <...> 
	GoalManager_ActivateGoal name = scorechallenge 
ENDSCRIPT


