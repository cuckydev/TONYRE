
(goal_trickattack_genericParams) = { 
	(goal_text) = "You must score the most points to win!" 
	(time) = 10 
	(net) 
	(init) = (goal_trickattack_init) 
	(activate) = (goal_trickattack_activate) 
	(deactivate) = (goal_trickattack_deactivate) 
	(expire) = (goal_trickattack_expire) 
	(goal_description) = "TrickAttack!" 
} 
SCRIPT (goal_trickattack_init) 
ENDSCRIPT

SCRIPT (goal_trickattack_activate) 
	(ResetComboRecords) 
	IF (InTeamGame) 
		(FormatText) (TextName) = (msg_text) "\\c2Trick Attack:\\c0\\nMost points wins" 
	ELSE 
		(FormatText) (TextName) = (msg_text) "\\c2Trick Attack:\\c0\\nMost points wins" 
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
	IF (GameModeEquals) (is_singlesession) 
		(skater) : (RunStarted) 
		(SetScoreAccumulation) 1 
		(SetScoreDegradation) 1 
	ENDIF 
	(RunScriptOnScreenElement) (id) = (the_time) (clock_morph) 
	(ResetScore) 
ENDSCRIPT

SCRIPT (goal_trickattack_deactivate) 
	IF (ObjectExists) (id) = (mp_goal_text) 
		(DestroyScreenElement) (id) = (mp_goal_text) 
	ENDIF 
	IF (GameModeEquals) (is_singlesession) 
		(SetScoreAccumulation) 0 
		(SetScoreDegradation) 0 
		IF NOT (ObjectExists) (id) = (dialog_bg_anchor) 
			IF NOT (GotParam) (quick_start) 
				(PauseGame) 
				(root_window) : (SetTags) (menu_state) = (on) 
				(SpawnScript) (goal_trick_attack_high_score_menu) (params) = { (restart_node) = <restart_node> } 
			ELSE 
				(ResetSkaters) (node) = <restart_node> 
			ENDIF 
		ELSE 
			(ResetSkaters) (node) = <restart_node> 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT (goal_trick_attack_high_score_menu) 
	(Change) (EndOfReplayShouldJumpToPauseMenu) = 1 
	(kill_start_key_binding) 
	(PauseGame) 
	(pause_trick_text) 
	IF (ScreenElementExists) (id) = (goal_start_dialog) 
		(DestroyScreenElement) (id) = (goal_start_dialog) 
	ENDIF 
	(UpdateRecords) 
	IF (NewRecord) 
		(high_scores_menu_enter_initials) (restart_node) = <restart_node> 
		(FireEvent) (type) = (focus) (target) = (keyboard_vmenu) 
	ELSE 
		(high_scores_menu_create) (restart_node) = <restart_node> 
	ENDIF 
	(ResetComboRecords) 
ENDSCRIPT

SCRIPT (goal_trickattack_expire) 
	IF (ObjectExists) (id) = (mp_goal_text) 
		(DestroyScreenElement) (id) = (mp_goal_text) 
	ENDIF 
	IF NOT (GameModeEquals) (is_singlesession) 
		IF (InSplitScreenGame) 
			(create_rankings) 
		ELSE 
			IF (OnServer) 
				(SpawnScript) (wait_then_create_rankings) 
			ELSE 
				(create_rankings) 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT (AddGoal_TrickAttack) 
	(GoalManager_AddGoal) (name) = (trickattack) { 
		(params) = { (goal_trickattack_genericParams) 
		} 
	} 
ENDSCRIPT

SCRIPT (StartGoal_TrickAttack) 
	IF (InSplitScreenGame) 
		(SetScreenModeFromGameMode) 
	ENDIF 
	(GoalManager_EditGoal) (name) = (trickattack) (params) = <...> 
	(GoalManager_ActivateGoal) (name) = (trickattack) 
ENDSCRIPT

SCRIPT (TrickAttack_MenuStartRun) 
	(GoalManager_ActivateGoal) (name) = (trickattack) 
	(exit_pause_menu) 
ENDSCRIPT

SCRIPT (end_high_score_run) 
	(Change) (check_for_unplugged_controllers) = 0 
	(exit_pause_menu) 
	(GoalManager_DeactivateGoal) (name) = (trickattack) 
	(Change) (check_for_unplugged_controllers) = 1 
ENDSCRIPT


