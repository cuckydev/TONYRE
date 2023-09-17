
(goal_slap_genericParams) = { 
	(goal_text) = "You must slap the most players to win!" 
	(time) = 10 
	(net) 
	(init) = (goal_slap_init) 
	(activate) = (goal_slap_activate) 
	(deactivate) = (goal_slap_deactivate) 
	(expire) = (goal_slap_expire) 
	(goal_description) = "Slap!" 
} 
SCRIPT (goal_slap_init) 
ENDSCRIPT

SCRIPT (goal_slap_activate) 
	IF (InTeamGame) 
		(FormatText) (TextName) = (msg_text) "\\c2Slap! \\n\\c0The team with the most slaps wins." 
	ELSE 
		(FormatText) (TextName) = (msg_text) "\\c2Slap! \\n\\c0The player with the most slaps wins." 
	ENDIF 
	IF (InSplitScreenGame) 
		(MakeSkaterGosub) (add_skater_to_world) (skater) = 0 
		(MakeSkaterGosub) (add_skater_to_world) (skater) = 1 
		(ScriptGetScreenMode) 
		SWITCH <screen_mode> 
			CASE (split_vertical) 
				(msg_pos) = PAIR(350, 42) 
			CASE (split_horizontal) 
				(msg_pos) = PAIR(620, 27) 
		ENDSWITCH 
	ELSE 
		(msg_pos) = PAIR(620, 27) 
	ENDIF 
	IF (InNetGame) 
		(create_panel_block) (id) = (mp_goal_text) (text) = <msg_text> (style) = (panel_message_goal) (final_pos) = <msg_pos> 
	ENDIF 
	(RunScriptOnScreenElement) (id) = (the_time) (clock_morph) 
	(ResetScore) 
ENDSCRIPT

SCRIPT (goal_slap_deactivate) 
	IF (ObjectExists) (id) = (mp_goal_text) 
		(DestroyScreenElement) (id) = (mp_goal_text) 
	ENDIF 
ENDSCRIPT

SCRIPT (slap_done) 
	(dialog_box_exit) 
	(do_backend_retry) 
ENDSCRIPT

SCRIPT (goal_slap_expire) 
	IF (ObjectExists) (id) = (mp_goal_text) 
		(DestroyScreenElement) (id) = (mp_goal_text) 
	ENDIF 
	(printf) "goal_slap_expire" 
	IF (OnServer) 
		(SpawnScript) (wait_then_create_rankings) (params) = { (score_title_text) = "SLAPS" } 
	ELSE 
		(create_rankings) (score_title_text) = "SLAPS" 
	ENDIF 
ENDSCRIPT

SCRIPT (AddGoal_Slap) 
	(GoalManager_AddGoal) (name) = (slap) { 
		(params) = { (goal_slap_genericParams) 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT (StartGoal_Slap) 
	IF (InSplitScreenGame) 
		(SetScreenModeFromGameMode) 
	ENDIF 
	(GoalManager_EditGoal) (name) = (slap) (params) = <...> 
	(GoalManager_ActivateGoal) (name) = (slap) 
ENDSCRIPT


