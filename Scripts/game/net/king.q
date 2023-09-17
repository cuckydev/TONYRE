
goal_king_genericParams = { 
	goal_text = "Capture the crown and keep it away from others!" 
	unlimited_time = 1 
	score = 10000 
	net 
	init = goal_king_init 
	activate = goal_king_activate 
	deactivate = goal_king_deactivate 
	active = goal_king_active 
	goal_description = "King of the Hill!" 
} 
SCRIPT goal_king_init 
ENDSCRIPT

SCRIPT goal_king_activate 
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
			CASE 30000 
				time_string = "30 seconds" 
			CASE 60000 
				time_string = "1 minute" 
			CASE 120000 
				time_string = "2 minutes" 
			CASE 300000 
				time_string = "5 minutes" 
			CASE 600000 
				time_string = "10 minutes" 
		ENDSWITCH 
		IF InTeamGame 
			FormatText TextName = msg_text "\\c3King of the Hill:\\n\\c0Hold the crown for \\n%s to win." s = <time_string> 
		ELSE 
			FormatText TextName = msg_text "\\c3King of the Hill:\\n\\c0Hold the crown for \\n%s to win." s = <time_string> 
		ENDIF 
		create_panel_block id = mp_goal_text text = <msg_text> style = panel_message_goal final_pos = <msg_pos> 
	ENDIF 
	SpawnCrown 
	show_crown_arrow player_1 player_2 force_show 
	ResetScore 
ENDSCRIPT

SCRIPT goal_king_active 
	IF AnySkaterTotalScoreAtLeast <score> 
		IF OnServer 
			IF CalculateFinalScores 
				GoalManager_DeactivateGoal name = <goal_id> 
				goal_king_finished 
			ENDIF 
		ELSE 
			GoalManager_DeactivateGoal name = <goal_id> 
			goal_king_finished 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT goal_king_finished 
	IF ObjectExists id = mp_goal_text 
		DestroyScreenElement id = mp_goal_text 
	ENDIF 
	hide_crown_arrow player_1 player_2 
	printf "goal_king_deactivate" 
	IF OnServer 
		IF InInternetMode 
			ReportStats final 
		ENDIF 
	ENDIF 
	create_rankings score_title_text = "TIME" 
ENDSCRIPT

SCRIPT goal_king_deactivate 
	IF ObjectExists id = mp_goal_text 
		DestroyScreenElement id = mp_goal_text 
	ENDIF 
	hide_crown_arrow player_1 player_2 
ENDSCRIPT

SCRIPT king_done 
	dialog_box_exit 
	do_backend_retry 
ENDSCRIPT

SCRIPT AddGoal_King 
	GoalManager_AddGoal name = king { 
		params = { goal_king_genericParams 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT show_crown_arrow 
	IF NOT GotParam force_show 
		IF NOT GoalManager_GoalIsActive name = king 
			RETURN 
		ENDIF 
	ENDIF 
	IF InSplitScreenGame 
		ScriptGetScreenMode 
		SWITCH <screen_mode> 
			CASE split_vertical 
				IF GotParam player_1 
					IF NOT ObjectExists id = crown_arrow 
						Create3dArrowPointer id = crown_arrow name = crown_object pos = PAIR(395, 50) scale = 0.01999999955 model = "HUD_Arrow" 
					ENDIF 
				ENDIF 
				IF GotParam player_2 
					IF NOT ObjectExists id = crown_arrow_2 
						Create3dArrowPointer id = crown_arrow_2 name = crown_object pos = PAIR(395.00000000000, 50.00000000000) scale = 0.01999999955 active_viewport = 1 model = "HUD_Arrow" 
					ENDIF 
				ENDIF 
			CASE split_horizontal 
				IF GotParam player_1 
					IF NOT ObjectExists id = crown_arrow 
						Create3dArrowPointer id = crown_arrow name = crown_object pos = PAIR(320.00000000000, 140.00000000000) scale = 0.01999999955 model = "HUD_Arrow" 
					ENDIF 
				ENDIF 
				IF GotParam player_2 
					IF NOT ObjectExists id = crown_arrow_2 
						Create3dArrowPointer id = crown_arrow_2 name = crown_object pos = PAIR(320.00000000000, 140.00000000000) scale = 0.01999999955 active_viewport = 1 model = "HUD_Arrow" 
					ENDIF 
				ENDIF 
		ENDSWITCH 
	ELSE 
		IF GotParam player_1 
			IF NOT ObjectExists id = crown_arrow 
				Create3dArrowPointer id = crown_arrow name = crown_object model = "HUD_Arrow" 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT hide_crown_arrow 
	IF GotParam player_1 
		IF ObjectExists id = crown_arrow 
			DestroyScreenElement id = crown_arrow 
		ENDIF 
	ENDIF 
	IF GotParam player_2 
		IF ObjectExists id = crown_arrow_2 
			DestroyScreenElement id = crown_arrow_2 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT StartGoal_King 
	IF InSplitScreenGame 
		SetScreenModeFromGameMode 
	ENDIF 
	GoalManager_EditGoal name = king params = <...> 
	GoalManager_ActivateGoal name = king 
ENDSCRIPT


