
goal_kill_genericParams = { 
	goal_text = "Kill the spot generic text" 
	view_goals_text = "Kill the spot" 
	time = 120 
	init = goal_kill_init 
	uninit = goal_uninit 
	activate = goal_kill_activate 
	active = goal_kill_active 
	success = goal_kill_success 
	fail = goal_kill_fail 
	deactivate = goal_kill_deactivate 
	expire = goal_kill_expire 
	trigger_obj_id = TRG_G_KILL_Pro 
	start_pad_id = G_KILL_StartPad 
	restart_node = TRG_G_KILL_RestartNode 
	goal_flags = [ got_1 
		got_2 
	] 
	kill_clusters = [ { id = Sch_KillSpot01 flag = got_1 score = 1000 } 
		{ id = Sch_KillSpot02 flag = got_2 score = 1000 } 
	] 
	record_type = score 
	graffiti 
} 
SCRIPT goal_kill_init 
	goal_init goal_id = <goal_id> 
ENDSCRIPT

SCRIPT goal_kill_activate 
	GoalManager_SetGraffitiMode 1 
	goal_start goal_id = <goal_id> 
ENDSCRIPT

SCRIPT goal_kill_active 
	IF GoalManager_AllFlagsSet name = <goal_id> 
		GoalManager_WinGoal name = <goal_id> 
	ENDIF 
ENDSCRIPT

SCRIPT goal_kill_success 
	goal_success goal_id = <goal_id> 
ENDSCRIPT

SCRIPT goal_kill_deactivate 
	GoalManager_SetGraffitiMode 0 
	GoalManager_ColorTrickObjects name = <goal_id> clear 
	GoalManager_ResetGoalTrigger name = <goal_id> 
	goal_deactivate goal_id = <goal_id> 
ENDSCRIPT

SCRIPT goal_kill_expire 
	goal_expire goal_id = <goal_id> 
	GoalManager_LoseGoal name = <goal_id> 
ENDSCRIPT

SCRIPT goal_kill_fail 
	goal_fail goal_id = <goal_id> 
ENDSCRIPT


