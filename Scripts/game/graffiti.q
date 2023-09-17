
(goal_graffiti_genericParams) = { 
	(goal_text) = "You must tag more objects to win!" 
	(time) = 10 
	(net) 
	(init) = (goal_graffiti_init) 
	(activate) = (goal_graffiti_activate) 
	(deactivate) = (goal_graffiti_deactivate) 
	(expire) = (goal_graffiti_expire) 
	(goal_description) = "Graffiti!" 
} 
SCRIPT (goal_graffiti_init) 
ENDSCRIPT

SCRIPT (goal_graffiti_activate) 
	IF (InTeamGame) 
		(FormatText) (TextName) = (msg_text) "\\c4Graffiti:\\n\\c0The team with the most tags wins." 
	ELSE 
		(FormatText) (TextName) = (msg_text) "\\c4Graffiti:\\n\\c0The player with the most tags wins." 
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

SCRIPT (goal_graffiti_deactivate) 
	IF (ObjectExists) (id) = (mp_goal_text) 
		(DestroyScreenElement) (id) = (mp_goal_text) 
	ENDIF 
ENDSCRIPT

SCRIPT (graffiti_done) 
	(dialog_box_exit) 
	(do_backend_retry) 
ENDSCRIPT

SCRIPT (goal_graffiti_expire) 
	IF (ObjectExists) (id) = (mp_goal_text) 
		(DestroyScreenElement) (id) = (mp_goal_text) 
	ENDIF 
	IF (ObjectExists) (id) = (goal_message) 
		(DestroyScreenElement) (id) = (goal_message) 
	ENDIF 
	(printf) "goal_graffiti_expire" 
	IF (OnServer) 
		(SpawnScript) (wait_then_create_rankings) (params) = { (score_title_text) = "TAGS" } 
	ELSE 
		(create_rankings) (score_title_text) = "TAGS" 
	ENDIF 
ENDSCRIPT

SCRIPT (AddGoal_Graffiti) 
	(GoalManager_AddGoal) (name) = (graffiti) { 
		(params) = { (goal_graffiti_genericParams) 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT (StartGoal_Graffiti) 
	IF (InSplitScreenGame) 
		(SetScreenModeFromGameMode) 
	ENDIF 
	(GoalManager_EditGoal) (name) = (graffiti) (params) = <...> 
	(GoalManager_ActivateGoal) (name) = (graffiti) 
ENDSCRIPT


