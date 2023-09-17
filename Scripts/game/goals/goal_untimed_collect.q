
Goal_UntimedCollect_GenericParams = { 
	goal_text = "Find X things!" 
	view_goals_text = "Generic find things text" 
	init = goal_untimed_collect_init 
	uninit = goal_uninit 
	activate = goal_untimed_collect_activate 
	deactivate = goal_untimed_collect_deactivate 
	expire = goal_untimed_collect_expire 
	fail = goal_untimed_collect_fail 
	success = goal_untimed_collect_success 
	restart_node = TRG_G_UNTIMEDCOLLECT_RestartNode 
	trigger_obj_id = TRG_G_UNTIMEDCOLLECT_Pro 
	record_type = none 
	unlimited_time = 1 
	no_restart 
	UntimedCollect 
} 
SCRIPT goal_untimed_collect_init 
	IF GotParam goal_collect_objects 
		GetArraySize <goal_collect_objects> 
		<index> = 0 
		GoalManager_EditGoal name = <goal_id> params = { num_to_collect = <array_size> } 
		BEGIN 
			goal_untimed_collect_init_object { 
				goal_id = <goal_id> 
				( <goal_collect_objects> [ <index> ] ) 
				inner_radius = <collect_object_radius> 
			} 
			<index> = ( <index> + 1 ) 
		REPEAT <array_size> 
	ELSE 
		script_assert "No goal_collect_objects array defined for %s." s = <goal_id> 
	ENDIF 
	goal_init goal_id = <goal_id> 
ENDSCRIPT

SCRIPT goal_untimed_collect_init_object 
	IF NOT GotParam inner_radius 
		<inner_radius> = 5 
	ENDIF 
	create name = <id> 
	<id> : Obj_SetInnerRadius <inner_radius> 
	<id> : Obj_SetException ex = SkaterInRadius scr = goal_untimed_collect_got_object params = { goal_id = <goal_id> } 
ENDSCRIPT

SCRIPT goal_untimed_collect_activate 
	IF NOT GotParam num_objects_collected 
		<num_objects_collected> = 0 
	ENDIF 
	IF ( <num_objects_collected> > ( <num_to_collect> - 1 ) ) 
		<trigger_obj_id> : Obj_ClearExceptions 
		speech_box_exit anchor_id = goal_start_dialog 
		SpawnScript goal_untimed_collect_wait_and_win params = { goal_id = <goal_id> } 
	ELSE 
		SpawnScript goal_untimed_collect_wait_and_deactivate params = { goal_id = <goal_id> } 
		goal_start goal_id = <goal_id> 
	ENDIF 
ENDSCRIPT

SCRIPT goal_untimed_collect_wait_and_deactivate 
	WaitForEvent type = goal_cam_anim_post_start_done 
	GoalManager_DeactivateGoal name = <goal_id> 
ENDSCRIPT

SCRIPT goal_untimed_collect_deactivate 
	GoalManager_ResetGoalTrigger name = <goal_id> 
	goal_deactivate goal_id = <goal_id> 
ENDSCRIPT

SCRIPT goal_untimed_collect_expire 
	goal_expire goal_id = <goal_id> 
ENDSCRIPT

SCRIPT goal_untimed_collect_fail 
	goal_fail goal_id = <goal_id> 
ENDSCRIPT

SCRIPT goal_untimed_collect_success 
	goal_success goal_id = <goal_id> 
ENDSCRIPT

SCRIPT goal_untimed_collect_wait_and_win 
	wait 1 frame 
	GoalManager_WinGoal name = <goal_id> 
ENDSCRIPT

SCRIPT goal_untimed_collect_got_object 
	Obj_ClearExceptions 
	GoalManager_GetGoalParams name = <goal_id> 
	IF NOT GotParam num_objects_collected 
		<num_objects_collected> = 1 
	ELSE 
		<num_objects_collected> = ( <num_objects_collected> + 1 ) 
		IF ( <num_objects_collected> > ( <num_to_collect> - 1 ) ) 
			create_panel_message text = "You\'ve collected everything!" 
		ENDIF 
	ENDIF 
	GoalManager_EditGoal name = <goal_id> params = { num_objects_collected = <num_objects_collected> } 
	Die 
ENDSCRIPT


