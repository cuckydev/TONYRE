
Goal_FindGaps_GenericParams = { 
	goal_text = "Find X gaps!" 
	view_goals_text = "Generic find gaps text" 
	time = 120 
	init = goal_find_gaps_init 
	uninit = goal_uninit 
	active = goal_find_gaps_active 
	activate = goal_find_gaps_activate 
	deactivate = goal_find_gaps_deactivate 
	expire = goal_find_gaps_expire 
	fail = goal_find_gaps_fail 
	success = goal_find_gaps_success 
	restart_node = TRG_G_FINDGAPS_RestartNode 
	trigger_obj_id = TRG_G_FINDGAPS_Pro 
	record_type = time 
	findGaps 
} 
SCRIPT goal_find_gaps_init 
	goal_init <...> 
ENDSCRIPT

SCRIPT goal_find_gaps_activate 
	GoalManager_EditGoal name = <goal_id> params = <...> 
	goal_start <...> 
ENDSCRIPT

SCRIPT goal_find_gaps_active 
	IF ( <num_gaps_found> > ( <num_gaps_to_find> - 1 ) ) 
		GoalManager_WinGoal name = <goal_id> 
	ENDIF 
ENDSCRIPT

SCRIPT goal_find_gaps_deactivate 
	goal_deactivate <...> 
ENDSCRIPT

SCRIPT goal_find_gaps_expire 
	goal_expire <...> 
	GoalManager_LoseGoal name = <goal_id> 
ENDSCRIPT

SCRIPT goal_find_gaps_fail 
	goal_fail <...> 
ENDSCRIPT

SCRIPT goal_find_gaps_success 
	goal_success <...> 
ENDSCRIPT

SCRIPT goal_find_gaps_found_gap 
	goal_update_counter goal_id = <goal_id> 
ENDSCRIPT


