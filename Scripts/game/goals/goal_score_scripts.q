
(Goal_GenericScore_genericParams) = { 
	(goal_text) = "Get a High Score: 15,000 Points" 
	(view_goals_text) = "High score" 
	(init) = (Score_init) 
	(uninit) = (goal_uninit) 
	(activate) = (Score_activate) 
	(deactivate) = (Score_Deactivate) 
	(expire) = (Score_expire) 
	(fail) = (Score_fail) 
	(success) = (Score_success) 
	(trigger_obj_id) = (TRG_G_GS_Pro) 
	(restart_node) = (TRG_G_GS_RestartNode) 
	(start_pad_id) = (G_GS_StartPad) 
	(score) = 15000 
	(time) = 120 
	(already_displayed_win_message) = 0 
	(win_message_text) = "High Score: Complete!" 
	(record_type) = (time) 
	(score_goal) 
} 
(Goal_HighScore_genericParams) = { 
	(goal_text) = "Get a High Score: 15,000 Points" 
	(view_goals_text) = "High score" 
	(init) = (Score_init) 
	(uninit) = (goal_uninit) 
	(activate) = (Score_activate) 
	(deactivate) = (Score_Deactivate) 
	(expire) = (Score_expire) 
	(fail) = (Score_fail) 
	(success) = (Score_success) 
	(trigger_obj_id) = (TRG_G_HS_Pro) 
	(restart_node) = (TRG_G_HS_RestartNode) 
	(start_pad_id) = (G_HS_StartPad) 
	(score) = 15000 
	(time) = 120 
	(already_displayed_win_message) = 0 
	(win_message_text) = "High Score: Complete!" 
	(record_type) = (time) 
	(score_goal) 
} 
(Goal_ProScore_GenericParams) = { 
	(goal_text) = "Get a Pro Score: 20,000 Points" 
	(view_goals_text) = "Pro score" 
	(init) = (Score_init) 
	(uninit) = (goal_uninit) 
	(activate) = (Score_activate) 
	(deactivate) = (Score_Deactivate) 
	(expire) = (Score_expire) 
	(fail) = (Score_fail) 
	(success) = (Score_success) 
	(trigger_obj_id) = (TRG_G_PS_Pro) 
	(restart_node) = (TRG_G_PS_RestartNode) 
	(start_pad_id) = (G_PS_StartPad) 
	(score) = 20000 
	(time) = 120 
	(already_displayed_win_message) = 0 
	(win_message_text) = "Pro Score: Complete!" 
	(record_type) = (time) 
	(score_goal) 
} 
(Goal_SickScore_GenericParams) = { 
	(goal_text) = "Get a Sick Score: 30,000 Points" 
	(view_goals_text) = "Sick score" 
	(init) = (Score_init) 
	(uninit) = (goal_uninit) 
	(activate) = (Score_activate) 
	(deactivate) = (Score_Deactivate) 
	(expire) = (Score_expire) 
	(fail) = (Score_fail) 
	(success) = (Score_success) 
	(trigger_obj_id) = (TRG_G_SS_Pro) 
	(restart_node) = (TRG_G_SS_RestartNode) 
	(start_pad_id) = (G_SS_StartPad) 
	(score) = 30000 
	(time) = 120 
	(already_displayed_win_message) = 0 
	(win_message_text) = "Sick Score: Complete!" 
	(record_type) = (time) 
	(score_goal) 
} 
SCRIPT (Score_init) 
	(goal_init) (goal_id) = <goal_id> 
ENDSCRIPT

SCRIPT (Score_activate) 
	(goal_start) (goal_id) = <goal_id> 
ENDSCRIPT

SCRIPT (Score_success) 
	(goal_success) (goal_id) = <goal_id> 
	IF (GotParam) (winning_score) 
		(FormatText) (TextName) = (text) "Score: %i" (i) = <winning_score> 
		(create_panel_message) { 
			(id) = (goal_current_reward) 
			(text) = <text> 
			(style) = (goal_message_got_trickslot) 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT (Score_Deactivate) 
	(GoalManager_ResetGoalTrigger) (name) = <goal_id> 
	(goal_deactivate) (goal_id) = <goal_id> 
	(GoalManager_EditGoal) (name) = <goal_id> (params) = { (already_displayed_win_message) = 0 } 
	(SpawnScript) (goal_score_wait_and_reset_score) 
ENDSCRIPT

SCRIPT (goal_score_wait_and_reset_score) 
	(wait) 1 (frame) 
	(ResetScore) 
ENDSCRIPT

SCRIPT (Score_expire) 
	(goal_expire) (goal_id) = <goal_id> 
	(GoalManager_LoseGoal) (name) = <goal_id> 
ENDSCRIPT

SCRIPT (Score_fail) 
	(goal_fail) (goal_id) = <goal_id> 
ENDSCRIPT

SCRIPT (goal_score_win_message) 
	(SetProps) (rgba) = [ 43 95 53 128 ] 
	(DoMorph) (time) = 0 (pos) = PAIR(0, 284) (scale) = 0 (alpha) = 0 
	(DoMorph) (time) = 0.20000000298 (pos) = PAIR(321.00000000000, 285.00000000000) (scale) = 1.89999997616 (alpha) = 1 
	(DoMorph) (time) = 0.20000000298 (scale) = 0.80000001192 
	(DoMorph) (time) = 0.20000000298 (scale) = 1.29999995232 
	(DoMorph) (time) = 0.10000000149 (scale) = 0.89999997616 
	(DoMorph) (time) = 0.10000000149 (scale) = 1.00000000000 
	(DoMorph) (pos) = PAIR(321.00000000000, 285.00000000000) (time) = 0.10000000149 (alpha) = 0.60000002384 
	(DoMorph) (pos) = PAIR(319.00000000000, 283.00000000000) (time) = 0.10000000149 (alpha) = 1 
	(DoMorph) (pos) = PAIR(321.00000000000, 285.00000000000) (time) = 0.10000000149 (alpha) = 0.80000001192 
	(DoMorph) (pos) = PAIR(319.00000000000, 283.00000000000) (time) = 0.10000000149 (alpha) = 1 
	(DoMorph) (pos) = PAIR(321.00000000000, 285.00000000000) (time) = 0.10000000149 (alpha) = 0.50000000000 
	(DoMorph) (pos) = PAIR(319.00000000000, 283.00000000000) (time) = 0.10000000149 (alpha) = 1 
	(DoMorph) (pos) = PAIR(321.00000000000, 285.00000000000) (time) = 0.10000000149 (alpha) = 0.69999998808 
	(DoMorph) (pos) = PAIR(319.00000000000, 283.00000000000) (time) = 0.10000000149 (alpha) = 1 
	(DoMorph) (pos) = PAIR(321.00000000000, 285.00000000000) (time) = 0.10000000149 (alpha) = 0.89999997616 
	(DoMorph) (pos) = PAIR(319.00000000000, 283.00000000000) (time) = 0.10000000149 (alpha) = 1 
	(DoMorph) (pos) = PAIR(321.00000000000, 285.00000000000) (time) = 0.10000000149 (alpha) = 0.40000000596 
	(DoMorph) (pos) = PAIR(319.00000000000, 283.00000000000) (time) = 0.10000000149 (alpha) = 1 
	(DoMorph) (pos) = PAIR(321.00000000000, 285.00000000000) (time) = 0.10000000149 (alpha) = 0.60000002384 
	(DoMorph) (pos) = PAIR(319.00000000000, 283.00000000000) (time) = 0.10000000149 (alpha) = 1 
	(DoMorph) (pos) = PAIR(321.00000000000, 285.00000000000) (time) = 0.10000000149 (alpha) = 0.80000001192 
	(DoMorph) (pos) = PAIR(319.00000000000, 283.00000000000) (time) = 0.10000000149 (alpha) = 1 
	(DoMorph) (pos) = PAIR(321.00000000000, 285.00000000000) (time) = 0.10000000149 (alpha) = 0.69999998808 
	(DoMorph) (pos) = PAIR(319.00000000000, 283.00000000000) (time) = 0.10000000149 (alpha) = 1 
	(DoMorph) (pos) = PAIR(305.00000000000, 285.00000000000) (time) = 0.20000000298 (alpha) = 1 
	(DoMorph) (pos) = PAIR(305.00000000000, 285.00000000000) (time) = 0.40000000596 (alpha) = 1 
	(DoMorph) (time) = 0.20000000298 (alpha) = 0 (pos) = PAIR(600.00000000000, 284.00000000000) (rgb) = [ 50 50 50 ] 
	(wait) 1500 
	(Die) 
ENDSCRIPT


