
Goal_Gaps_genericParams = { 
	goal_text = "generic gaps text" 
	view_goals_text = "Gaps goal" 
	time = 120 
	init = goal_gaps_init 
	uninit = goal_uninit 
	activate = goal_gaps_activate 
	active = goal_gaps_active 
	deactivate = goal_gaps_deactivate 
	expire = goal_gaps_expire 
	success = goal_gaps_success 
	fail = goal_gaps_fail 
	trigger_obj_id = TRG_G_GAP_Pro 
	restart_node = TRG_G_GAP_RestartNode 
	start_pad_id = G_GAP_StartPad 
	record_type = score 
} 
Goal_Gaps2_genericParams = { 
	goal_text = "generic gaps2 text" 
	view_goals_text = "Gaps2 goal" 
	time = 120 
	init = goal_gaps_init 
	uninit = goal_uninit 
	activate = goal_gaps_activate 
	active = goal_gaps_active 
	deactivate = goal_gaps_deactivate 
	expire = goal_gaps_expire 
	success = goal_gaps_success 
	fail = goal_gaps_fail 
	trigger_obj_id = TRG_G_GAP2_Pro 
	restart_node = TRG_G_GAP2_RestartNode 
	start_pad_id = G_GAP2_StartPad 
	record_type = score 
} 
Goal_Gaps3_genericParams = { 
	goal_text = "generic gaps3 text" 
	view_goals_text = "Gaps3 goal" 
	time = 120 
	init = goal_gaps_init 
	uninit = goal_uninit 
	activate = goal_gaps_activate 
	active = goal_gaps_active 
	deactivate = goal_gaps_deactivate 
	expire = goal_gaps_expire 
	success = goal_gaps_success 
	fail = goal_gaps_fail 
	trigger_obj_id = TRG_G_GAP3_Pro 
	restart_node = TRG_G_GAP3_RestartNode 
	start_pad_id = G_GAP3_StartPad 
	record_type = score 
} 
Goal_Gaps4_genericParams = { 
	goal_text = "generic gaps4 text" 
	view_goals_text = "Gaps4 goal" 
	time = 120 
	init = goal_gaps_init 
	uninit = goal_uninit 
	activate = goal_gaps_activate 
	active = goal_gaps_active 
	deactivate = goal_gaps_deactivate 
	expire = goal_gaps_expire 
	success = goal_gaps_success 
	fail = goal_gaps_fail 
	trigger_obj_id = TRG_G_GAP4_Pro 
	restart_node = TRG_G_GAP4_RestartNode 
	start_pad_id = G_GAP4_StartPad 
	record_type = score 
} 
Goal_Gaps5_genericParams = { 
	goal_text = "generic gaps5 text" 
	view_goals_text = "Gaps5 goal" 
	time = 120 
	init = goal_gaps_init 
	uninit = goal_uninit 
	activate = goal_gaps_activate 
	active = goal_gaps_active 
	deactivate = goal_gaps_deactivate 
	expire = goal_gaps_expire 
	success = goal_gaps_success 
	fail = goal_gaps_fail 
	trigger_obj_id = TRG_G_GAP5_Pro 
	restart_node = TRG_G_GAP5_RestartNode 
	start_pad_id = G_GAP5_StartPad 
	record_type = score 
} 
Goal_Gaps6_genericParams = { 
	goal_text = "generic gaps6 text" 
	view_goals_text = "Gaps6 goal" 
	time = 120 
	init = goal_gaps_init 
	uninit = goal_uninit 
	activate = goal_gaps_activate 
	active = goal_gaps_active 
	deactivate = goal_gaps_deactivate 
	expire = goal_gaps_expire 
	success = goal_gaps_success 
	fail = goal_gaps_fail 
	trigger_obj_id = TRG_G_GAP6_Pro 
	restart_node = TRG_G_GAP6_RestartNode 
	start_pad_id = G_GAP6_StartPad 
	record_type = score 
} 
SCRIPT goal_gaps_init 
	goal_init goal_id = <goal_id> 
ENDSCRIPT

SCRIPT goal_gaps_activate 
	goal_start goal_id = <goal_id> 
ENDSCRIPT

SCRIPT goal_gaps_active 
	IF GoalManager_AllFlagsSet name = <goal_id> 
		GoalManager_WinGoal name = <goal_id> 
	ENDIF 
ENDSCRIPT

SCRIPT goal_gaps_deactivate 
	GoalManager_ResetGoalTrigger name = <goal_id> 
	goal_deactivate goal_id = <goal_id> 
ENDSCRIPT

SCRIPT goal_gaps_success 
	goal_success goal_id = <goal_id> 
ENDSCRIPT

SCRIPT goal_gaps_fail 
	goal_fail goal_id = <goal_id> 
ENDSCRIPT

SCRIPT goal_gaps_expire 
	goal_expire goal_id = <goal_id> 
	GoalManager_LoseGoal name = <goal_id> 
ENDSCRIPT


