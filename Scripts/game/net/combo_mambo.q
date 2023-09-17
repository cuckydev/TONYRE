
goal_combomambo_genericParams = { 
	goal_text = "You must score the most points to win!" 
	time = 10 
	net 
	init = goal_combomambo_init 
	activate = goal_combomambo_activate 
	deactivate = goal_combomambo_deactivate 
	expire = goal_combomambo_expire 
	goal_description = "Combo Mambo!" 
} 
SCRIPT goal_combomambo_init 
ENDSCRIPT

SCRIPT goal_combomambo_activate 
	IF InTeamGame 
		FormatText TextName = msg_text "\\c4Combo Mambo:\\n\\c0Highest-scoring combo wins." 
	ELSE 
		FormatText TextName = msg_text "\\c4Combo Mambo:\\n\\c0Highest-scoring combo wins." 
	ENDIF 
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
		create_panel_block id = mp_goal_text text = <msg_text> style = panel_message_goal final_pos = <msg_pos> 
	ENDIF 
	RunScriptOnScreenElement id = the_time clock_morph 
	ResetScore 
ENDSCRIPT

SCRIPT goal_combomambo_deactivate 
	IF ObjectExists id = mp_goal_text 
		DestroyScreenElement id = mp_goal_text 
	ENDIF 
ENDSCRIPT

SCRIPT combomambo_done 
	dialog_box_exit 
	do_backend_retry 
ENDSCRIPT

SCRIPT goal_combomambo_expire 
	IF ObjectExists id = mp_goal_text 
		DestroyScreenElement id = mp_goal_text 
	ENDIF 
	printf "goal_combomambo_expire" 
	IF GameModeEquals is_singlesession 
		UpdateRecords 
		high_scores_menu_create 
		ResetComboRecords 
	ELSE 
		IF OnServer 
			SpawnScript wait_then_create_rankings params = { score_title_text = "BEST COMBO" } 
		ELSE 
			create_rankings score_title_text = "BEST COMBO" 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT AddGoal_combomambo 
	GoalManager_AddGoal name = combomambo { 
		params = { goal_combomambo_genericParams 
		} 
	} 
ENDSCRIPT

SCRIPT StartGoal_combomambo 
	IF InSplitScreenGame 
		SetScreenModeFromGameMode 
	ENDIF 
	GoalManager_EditGoal name = combomambo params = <...> 
	GoalManager_ActivateGoal name = combomambo 
ENDSCRIPT


