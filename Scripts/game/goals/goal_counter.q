
(goal_counter_genericParams) = { 
	(goal_text) = "Counter the spot generic text" 
	(view_goals_text) = "Counter goal" 
	(time) = 120 
	(init) = (goal_counter_init) 
	(uninit) = (goal_uninit) 
	(activate) = (goal_counter_activate) 
	(active) = (goal_counter_active) 
	(success) = (goal_counter_success) 
	(fail) = (goal_counter_fail) 
	(deactivate) = (goal_counter_deactivate) 
	(expire) = (goal_counter_expire) 
	(trigger_obj_id) = (TRG_G_COUNTER_Pro) 
	(start_pad_id) = (G_COUNTER_StartPad) 
	(restart_node) = (TRG_G_COUNTER_RestartNode) 
	(number) = 10 
	(number_collected) = 0 
	(counter_objects) = [ { (id) = (Sch_CounterSpot01) } 
		{ (id) = (Sch_CounterSpot02) } 
	] 
	(goal_counter_object_init_script) = (goal_counter_init_object) 
	(goal_counter_got_object_script) = (goal_counter_got_object) 
	(record_type) = (time) 
} 
(goal_counter2_genericParams) = { 
	(goal_text) = "Counter2 the spot generic text" 
	(view_goals_text) = "Counter2 goal" 
	(time) = 120 
	(init) = (goal_counter_init) 
	(uninit) = (goal_uninit) 
	(activate) = (goal_counter_activate) 
	(active) = (goal_counter_active) 
	(success) = (goal_counter_success) 
	(fail) = (goal_counter_fail) 
	(deactivate) = (goal_counter_deactivate) 
	(expire) = (goal_counter_expire) 
	(trigger_obj_id) = (TRG_G_COUNTER2_Pro) 
	(start_pad_id) = (G_COUNTER2_StartPad) 
	(restart_node) = (TRG_G_COUNTER2_RestartNode) 
	(number) = 10 
	(number_collected) = 0 
	(counter_objects) = [ { (id) = (Sch_Counter2Spot01) } 
		{ (id) = (Sch_Counter2Spot02) } 
	] 
	(goal_counter_object_init_script) = (goal_counter_init_object) 
	(goal_counter_got_object_script) = (goal_counter_got_object) 
	(record_type) = (time) 
} 
(goal_counter3_genericParams) = { 
	(goal_text) = "Counter3 the spot generic text" 
	(view_goals_text) = "Counter3 goal" 
	(time) = 120 
	(init) = (goal_counter_init) 
	(uninit) = (goal_uninit) 
	(activate) = (goal_counter_activate) 
	(active) = (goal_counter_active) 
	(success) = (goal_counter_success) 
	(fail) = (goal_counter_fail) 
	(deactivate) = (goal_counter_deactivate) 
	(expire) = (goal_counter_expire) 
	(trigger_obj_id) = (TRG_G_COUNTER3_Pro) 
	(start_pad_id) = (G_COUNTER3_StartPad) 
	(restart_node) = (TRG_G_COUNTER3_RestartNode) 
	(number) = 10 
	(number_collected) = 0 
	(counter_objects) = [ { (id) = (Sch_Counter3Spot01) } 
		{ (id) = (Sch_Counter3Spot02) } 
	] 
	(goal_counter_object_init_script) = (goal_counter_init_object) 
	(goal_counter_got_object_script) = (goal_counter_got_object) 
	(record_type) = (time) 
} 
(goal_counter4_genericParams) = { 
	(goal_text) = "Counter4 the spot generic text" 
	(view_goals_text) = "Counter4 goal" 
	(time) = 120 
	(init) = (goal_counter_init) 
	(uninit) = (goal_uninit) 
	(activate) = (goal_counter_activate) 
	(active) = (goal_counter_active) 
	(success) = (goal_counter_success) 
	(fail) = (goal_counter_fail) 
	(deactivate) = (goal_counter_deactivate) 
	(expire) = (goal_counter_expire) 
	(trigger_obj_id) = (TRG_G_COUNTER4_Pro) 
	(start_pad_id) = (G_COUNTER4_StartPad) 
	(restart_node) = (TRG_G_COUNTER4_RestartNode) 
	(number) = 10 
	(number_collected) = 0 
	(counter_objects) = [ { (id) = (Sch_Counter4Spot01) } 
		{ (id) = (Sch_Counter4Spot02) } 
	] 
	(goal_counter_object_init_script) = (goal_counter_init_object) 
	(goal_counter_got_object_script) = (goal_counter_got_object) 
	(record_type) = (time) 
} 
SCRIPT (goal_counter_init) 
	(goal_init) (goal_id) = <goal_id> 
ENDSCRIPT

SCRIPT (goal_counter_activate) 
	(goal_start) (goal_id) = <goal_id> 
	(ForEachIn) <counter_objects> (do) = <goal_counter_object_init_script> (params) = <...> 
ENDSCRIPT

SCRIPT (goal_counter_init_object) 
	(GoalManager_GetGoalParams) (name) = <goal_id> 
	(RunScriptOnObject) (id) = <id> (goal_counter_init_object2) (params) = <...> 
ENDSCRIPT

SCRIPT (goal_counter_init_object2) 
	(Obj_ClearExceptions) 
	(Obj_SetInnerRadius) 5 
	(Obj_SetException) (ex) = (SkaterInRadius) (scr) = <goal_counter_got_object_script> (params) = { (goal_id) = <goal_id> (id) = <id> } 
ENDSCRIPT

SCRIPT (goal_counter_got_object) 
	(Obj_ClearExceptions) 
	(GoalManager_GetGoalParams) (name) = <goal_id> 
	(GoalManager_GotCounterObject) (name) = <goal_id> 
	(FormatText) (TextName) = (goal_counter_update) "You\'ve collected %i" (i) = <number_collected> 
	(create_panel_message) (id) = (goal_counter_update) (text) = <goal_counter_update> (style) = (goal_counter_update) 
	(Obj_SetOuterRadius) 10 
	(Obj_SetException) (ex) = (SkaterOutOfRadius) (scr) = (goal_counter_init_object) (params) = { (goal_id) = <goal_id> (id) = <id> } 
ENDSCRIPT

SCRIPT (goal_counter_active) 
	IF ( <number_collected> > ( <number> - 1 ) ) 
		(GoalManager_WinGoal) (name) = <goal_id> 
	ENDIF 
ENDSCRIPT

SCRIPT (goal_counter_success) 
	(goal_success) (goal_id) = <goal_id> 
ENDSCRIPT

SCRIPT (goal_counter_deactivate) 
	(GoalManager_EditGoal) (name) = <goal_id> (params) = { (number_collected) = 0 } 
	(GoalManager_ResetGoalTrigger) (name) = <goal_id> 
	(goal_deactivate) (goal_id) = <goal_id> 
ENDSCRIPT

SCRIPT (goal_counter_expire) 
	(goal_expire) (goal_id) = <goal_id> 
	(GoalManager_LoseGoal) (name) = <goal_id> 
ENDSCRIPT

SCRIPT (goal_counter_update) 
	(DoMorph) (time) = 0 (pos) = PAIR(320, 50) (scale) = 1 (rgba) = [ 128 128 128 128 ] 
	(wait) 1 (second) 
	(Die) 
ENDSCRIPT

SCRIPT (goal_counter_fail) 
	(goal_fail) (goal_id) = <goal_id> 
ENDSCRIPT


