
(Minigame_TimedCombo_GenericParams) = { 
	(init) = (minigame_TimedCombo_init) 
	(activate) = (minigame_TimedCombo_activate) 
	(active) = (minigame_TimedCombo_active) 
	(deactivate) = (minigame_TimedCombo_deactivate) 
	(minigame) 
	(no_restart) 
	(in_combo) = 0 
} 
SCRIPT (minigame_TimedCombo_init) 
	(create) (name) = <trigger_obj_id> 
ENDSCRIPT

SCRIPT (minigame_TimedCombo_activate) 
	IF (ObjectExists) (id) = (minigame_combo_timer) 
		(DestroyScreenElement) (id) = (minigame_combo_timer) 
	ENDIF 
	IF (ScreenElementExists) (id) = (minigame_message) 
		(DestroyScreenElement) (id) = (minigame_message) 
	ENDIF 
	IF (ScreenElementExists) (id) = (MiniGame2) 
		(DestroyScreenElement) (id) = (MiniGame2) 
	ENDIF 
	IF (ScreenElementExists) (id) = (MiniGame3) 
		(DestroyScreenElement) (id) = (MiniGame3) 
	ENDIF 
	(SetScreenElementLock) (id) = (root_window) (off) 
	(CreateScreenElement) { 
		(type) = (TextBlockElement) 
		(parent) = (root_window) 
		(id) = (minigame_combo_timer) 
		(text) = " " 
		(font) = (small) 
		(pos) = PAIR(20, 190) 
		(scale) = 0.69999998808 
		(rgba) = [ 128 128 128 128 ] 
		(dims) = PAIR(200.00000000000, 100.00000000000) 
		(just) = [ (left) (center) ] 
		(internal_just) = [ (center) (center) ] 
	} 
ENDSCRIPT

SCRIPT (minigame_TimedCombo_active) 
	IF NOT (ScreenElementExists) (id) = (minigame_combo_timer) 
		(printf) "no minigame_combo_timer!  Tell brad" 
		RETURN 
	ENDIF 
	IF ( <in_combo> = 1 ) 
		(GoalManager_UpdateComboTimer) (name) = <goal_id> 
		(GoalManager_GetGoalParams) (name) = <goal_id> 
		IF NOT (GotParam) (minigame_text) 
			<minigame_text> = "River Combo" 
		ENDIF 
		IF (GoalManager_CheckMinigameRecord) (name) = <goal_id> <current_time> 
			(FormatText) (TextName) = (minigame_time) "New Record!\\n%s.%f\\nsecond\\n%t" (s) = <current_time_seconds> (f) = <current_time_fraction> (t) = <minigame_text> 
			(SetScreenElementProps) { 
				(rgba) = [ 128 128 32 128 ] 
				(id) = (minigame_combo_timer) 
				(text) = <minigame_time> 
				(scale) = 0.69999998808 
			} 
		ELSE 
			(FormatText) (TextName) = (minigame_time) "%s.%f\\nsecond\\n%t" (s) = <current_time_seconds> (f) = <current_time_fraction> (t) = <minigame_text> 
			(SetScreenElementProps) { 
				(id) = (minigame_combo_timer) 
				(text) = <minigame_time> 
				(rgba) = [ 115 26 26 95 ] 
				(scale) = 0.69999998808 
			} 
		ENDIF 
	ELSE 
		IF (GotParam) (cancelSkitch) 
			IF (Skater) : (Skitching) 
				RETURN 
			ENDIF 
			IF (Skater) : (AnimEquals) (SkitchInit) 
				RETURN 
			ENDIF 
		ENDIF 
		IF (SkaterCurrentScorePotGreaterThan) 0 
			(GoalManager_EditGoal) (name) = <goal_id> (params) = { (in_combo) = 1 } 
			(GoalManager_SetStartTime) (name) = <goal_id> 
			(RunScriptOnObject) (id) = <trigger_obj_id> (minigame_TimedCombo_set_exceptions) (params) = { (goal_id) = <goal_id> } 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT (minigame_TimedCombo_deactivate) 
	<trigger_obj_id> : (Obj_ClearExceptions) 
	(GoalManager_EditGoal) (name) = <goal_id> (params) = { (in_combo) = 0 } 
	IF (ObjectExists) (id) = (minigame_combo_timer) 
		(RunScriptOnScreenElement) (id) = (minigame_combo_timer) (panel_message_wait_and_die) (params) = { (time) = 2000 } 
	ENDIF 
ENDSCRIPT

SCRIPT (minigame_TimedCombo_set_exceptions) 
	(Obj_SetException) (ex) = (SkaterLanded) (scr) = (minigame_TimedCombo_ResetTimer) (params) = { (goal_id) = <goal_id> } 
	(Obj_SetException) (ex) = (SkaterBailed) (scr) = (minigame_TimedCombo_ResetTimer) (params) = { (goal_id) = <goal_id> } 
ENDSCRIPT

SCRIPT (minigame_TimedCombo_ResetTimer) 
	(Obj_ClearExceptions) 
	(GoalManager_EditGoal) (name) = <goal_id> (params) = { (in_combo) = 0 } 
	(SetScreenElementProps) { 
		(id) = (minigame_combo_timer) 
		(text) = " " 
	} 
ENDSCRIPT

SCRIPT (minigame_TimedCombo_blinkTime) 
	(DoMorph) (time) = 0.10000000149 (alpha) = 1 
	(DoMorph) (time) = 0.10999999940 (alpha) = 0 
	(DoMorph) (time) = 0.20000000298 (alpha) = 0 
	(DoMorph) (time) = 0.20999999344 (alpha) = 1 
	(wait) 100 
	(Die) 
ENDSCRIPT


