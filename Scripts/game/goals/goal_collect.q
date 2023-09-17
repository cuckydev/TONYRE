
(Goal_Collect_GenericParams) = { 
	(goal_text) = "Collect x things!" 
	(view_goals_text) = "Generic collect text" 
	(goal_description) = "Generic collect goal description" 
	(time) = 120 
	(init) = (goal_collect_init) 
	(uninit) = (goal_uninit) 
	(active) = (goal_collect_active) 
	(activate) = (goal_collect_activate) 
	(deactivate) = (goal_collect_deactivate) 
	(expire) = (goal_collect_expire) 
	(fail) = (goal_collect_fail) 
	(success) = (goal_collect_success) 
	(restart_node) = (TRG_G_COLLECT_RestartNode) 
	(trigger_obj_id) = (TRG_G_COLLECT_Pro) 
	(goal_collect_object_init_script) = (set_goal_collect_exception) 
	(goal_flags) = [ 
		(got_1) 
		(got_2) 
		(got_3) 
		(got_4) 
		(got_5) 
	] 
	(goal_collect_objects) = [ 
		{ (id) = (TRG_G_COLLECT_FratBoy01) (scr) = (goal_collect_got_object) (flag) = (got_1) } 
		{ (id) = (TRG_G_COLLECT_FratBoy02) (scr) = (goal_collect_got_object) (flag) = (got_2) } 
		{ (id) = (TRG_G_COLLECT_FratBoy03) (scr) = (goal_collect_got_object) (flag) = (got_3) } 
		{ (id) = (TRG_G_COLLECT_FratBoy04) (scr) = (goal_collect_got_object) (flag) = (got_4) } 
		{ (id) = (TRG_G_COLLECT_FratBoy05) (scr) = (goal_collect_got_object) (flag) = (got_5) } 
	] 
	(start_pad_id) = (G_COLLECT_StartPad) 
	(wait_and_win_started) = 0 
	(record_type) = (time) 
} 
(Goal_Collect2_GenericParams) = { 
	(goal_text) = "Collect2 x things!" 
	(view_goals_text) = "Generic collect2 text" 
	(time) = 120 
	(init) = (goal_collect_init) 
	(uninit) = (goal_uninit) 
	(active) = (goal_collect_active) 
	(activate) = (goal_collect_activate) 
	(deactivate) = (goal_collect_deactivate) 
	(expire) = (goal_collect_expire) 
	(fail) = (goal_collect_fail) 
	(success) = (goal_collect_success) 
	(restart_node) = (TRG_G_COLLECT2_RestartNode) 
	(trigger_obj_id) = (TRG_G_COLLECT2_Pro) 
	(goal_collect_object_init_script) = (set_goal_collect_exception) 
	(goal_flags) = [ 
		(got_1) 
		(got_2) 
		(got_3) 
		(got_4) 
		(got_5) 
	] 
	(goal_collect_objects) = [ 
		{ (id) = (TRG_G_COLLECT2_FratBoy01) (scr) = (goal_collect_got_object) (flag) = (got_1) } 
		{ (id) = (TRG_G_COLLECT2_FratBoy02) (scr) = (goal_collect_got_object) (flag) = (got_2) } 
		{ (id) = (TRG_G_COLLECT2_FratBoy03) (scr) = (goal_collect_got_object) (flag) = (got_3) } 
		{ (id) = (TRG_G_COLLECT2_FratBoy04) (scr) = (goal_collect_got_object) (flag) = (got_4) } 
		{ (id) = (TRG_G_COLLECT2_FratBoy05) (scr) = (goal_collect_got_object) (flag) = (got_5) } 
	] 
	(start_pad_id) = (G_COLLECT2_StartPad) 
	(wait_and_win_started) = 0 
	(record_type) = (time) 
} 
(Goal_Collect3_GenericParams) = { 
	(goal_text) = "Collect3 x things!" 
	(view_goals_text) = "Generic Collect3 text" 
	(time) = 120 
	(init) = (goal_collect_init) 
	(uninit) = (goal_uninit) 
	(active) = (goal_collect_active) 
	(activate) = (goal_collect_activate) 
	(deactivate) = (goal_collect_deactivate) 
	(expire) = (goal_collect_expire) 
	(fail) = (goal_collect_fail) 
	(success) = (goal_collect_success) 
	(restart_node) = (TRG_G_Collect3_RestartNode) 
	(trigger_obj_id) = (TRG_G_Collect3_Pro) 
	(goal_collect_object_init_script) = (set_goal_collect_exception) 
	(goal_flags) = [ 
		(got_1) 
		(got_2) 
		(got_3) 
		(got_4) 
		(got_5) 
	] 
	(goal_collect_objects) = [ 
		{ (id) = (TRG_G_Collect3_FratBoy01) (scr) = (goal_collect_got_object) (flag) = (got_1) } 
		{ (id) = (TRG_G_Collect3_FratBoy02) (scr) = (goal_collect_got_object) (flag) = (got_2) } 
		{ (id) = (TRG_G_Collect3_FratBoy03) (scr) = (goal_collect_got_object) (flag) = (got_3) } 
		{ (id) = (TRG_G_Collect3_FratBoy04) (scr) = (goal_collect_got_object) (flag) = (got_4) } 
		{ (id) = (TRG_G_Collect3_FratBoy05) (scr) = (goal_collect_got_object) (flag) = (got_5) } 
	] 
	(start_pad_id) = (G_Collect3_StartPad) 
	(wait_and_win_started) = 0 
	(record_type) = (time) 
} 
(Goal_Collect4_GenericParams) = { 
	(goal_text) = "Collect4 x things!" 
	(view_goals_text) = "Generic Collect4 text" 
	(time) = 120 
	(init) = (goal_collect_init) 
	(uninit) = (goal_uninit) 
	(active) = (goal_collect_active) 
	(activate) = (goal_collect_activate) 
	(deactivate) = (goal_collect_deactivate) 
	(expire) = (goal_collect_expire) 
	(fail) = (goal_collect_fail) 
	(success) = (goal_collect_success) 
	(restart_node) = (TRG_G_Collect4_RestartNode) 
	(trigger_obj_id) = (TRG_G_Collect4_Pro) 
	(goal_collect_object_init_script) = (set_goal_collect_exception) 
	(goal_flags) = [ 
		(got_1) 
		(got_2) 
		(got_3) 
		(got_4) 
		(got_5) 
	] 
	(goal_collect_objects) = [ 
		{ (id) = (TRG_G_Collect4_FratBoy01) (scr) = (goal_collect_got_object) (flag) = (got_1) } 
		{ (id) = (TRG_G_Collect4_FratBoy02) (scr) = (goal_collect_got_object) (flag) = (got_2) } 
		{ (id) = (TRG_G_Collect4_FratBoy03) (scr) = (goal_collect_got_object) (flag) = (got_3) } 
		{ (id) = (TRG_G_Collect4_FratBoy04) (scr) = (goal_collect_got_object) (flag) = (got_4) } 
		{ (id) = (TRG_G_Collect4_FratBoy05) (scr) = (goal_collect_got_object) (flag) = (got_5) } 
	] 
	(start_pad_id) = (G_Collect4_StartPad) 
	(wait_and_win_started) = 0 
	(record_type) = (time) 
} 
(Goal_Collect5_GenericParams) = { 
	(goal_text) = "Collect5 x things!" 
	(view_goals_text) = "Generic Collect5 text" 
	(time) = 120 
	(init) = (goal_collect_init) 
	(uninit) = (goal_uninit) 
	(active) = (goal_collect_active) 
	(activate) = (goal_collect_activate) 
	(deactivate) = (goal_collect_deactivate) 
	(expire) = (goal_collect_expire) 
	(fail) = (goal_collect_fail) 
	(success) = (goal_collect_success) 
	(restart_node) = (TRG_G_Collect5_RestartNode) 
	(trigger_obj_id) = (TRG_G_Collect5_Pro) 
	(goal_collect_object_init_script) = (set_goal_collect_exception) 
	(goal_flags) = [ 
		(got_1) 
		(got_2) 
		(got_3) 
		(got_4) 
		(got_5) 
	] 
	(goal_collect_objects) = [ 
		{ (id) = (TRG_G_Collect5_FratBoy01) (scr) = (goal_collect_got_object) (flag) = (got_1) } 
		{ (id) = (TRG_G_Collect5_FratBoy02) (scr) = (goal_collect_got_object) (flag) = (got_2) } 
		{ (id) = (TRG_G_Collect5_FratBoy03) (scr) = (goal_collect_got_object) (flag) = (got_3) } 
		{ (id) = (TRG_G_Collect5_FratBoy04) (scr) = (goal_collect_got_object) (flag) = (got_4) } 
		{ (id) = (TRG_G_Collect5_FratBoy05) (scr) = (goal_collect_got_object) (flag) = (got_5) } 
	] 
	(start_pad_id) = (G_Collect5_StartPad) 
	(wait_and_win_started) = 0 
	(record_type) = (time) 
} 
(Goal_Collect6_GenericParams) = { 
	(goal_text) = "Collect6 x things!" 
	(view_goals_text) = "Generic Collect6 text" 
	(time) = 120 
	(init) = (goal_collect_init) 
	(uninit) = (goal_uninit) 
	(active) = (goal_collect_active) 
	(activate) = (goal_collect_activate) 
	(deactivate) = (goal_collect_deactivate) 
	(expire) = (goal_collect_expire) 
	(fail) = (goal_collect_fail) 
	(success) = (goal_collect_success) 
	(restart_node) = (TRG_G_Collect6_RestartNode) 
	(trigger_obj_id) = (TRG_G_Collect6_Pro) 
	(goal_collect_object_init_script) = (set_goal_collect_exception) 
	(goal_flags) = [ 
		(got_1) 
		(got_2) 
		(got_3) 
		(got_4) 
		(got_5) 
	] 
	(goal_collect_objects) = [ 
		{ (id) = (TRG_G_Collect4_FratBoy01) (scr) = (goal_collect_got_object) (flag) = (got_1) } 
		{ (id) = (TRG_G_Collect4_FratBoy02) (scr) = (goal_collect_got_object) (flag) = (got_2) } 
		{ (id) = (TRG_G_Collect4_FratBoy03) (scr) = (goal_collect_got_object) (flag) = (got_3) } 
		{ (id) = (TRG_G_Collect4_FratBoy04) (scr) = (goal_collect_got_object) (flag) = (got_4) } 
		{ (id) = (TRG_G_Collect4_FratBoy05) (scr) = (goal_collect_got_object) (flag) = (got_5) } 
	] 
	(start_pad_id) = (G_Collect4_StartPad) 
	(wait_and_win_started) = 0 
	(record_type) = (time) 
} 
SCRIPT (goal_collect_init) 
	(goal_init) (goal_id) = <goal_id> 
ENDSCRIPT

SCRIPT (goal_collect_create_object) 
ENDSCRIPT

SCRIPT (init_goal_collect_object) 
	IF (GotParam) (id) 
		IF (ChecksumEquals) (a) = <trigger_obj_id> (b) = <id> 
			(GoalManager_SetGoalFlag) (name) = <goal_id> <flag> 1 
		ELSE 
			<id> : (Obj_Visible) 
			(RunScriptOnObject) (id) = <id> <goal_collect_object_init_script> (params) = <...> 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT (set_goal_collect_exception) (goal_collect_object_inner_radius) = 6 
	(Obj_ClearExceptions) 
	(Obj_SetInnerRadius) <goal_collect_object_inner_radius> 
	(Obj_SetException) (ex) = (SkaterInRadius) (scr) = <scr> (params) = { (goal_id) = <goal_id> (flag) = <flag> } 
ENDSCRIPT

SCRIPT (goal_collect_got_object) 
	(Obj_ClearExceptions) 
	(PlaySound) (GapSound) (vol) = 100 
	(GoalManager_SetGoalFlag) (name) = <goal_id> <flag> 1 
	(GoalManager_GetGoalParams) (name) = <goal_id> 
	IF NOT (GoalManager_AllFlagsSet) (name) = <goal_id> 
		(FormatText) (TextName) = (collect_text) "%c of %n %t" (c) = <num_flags_set> (t) = <collect_type> (n) = <num_flags> 
		(create_panel_message) (text) = <collect_text> (style) = (goal_collect_text) 
	ENDIF 
ENDSCRIPT

SCRIPT (goal_collect_text) 
	(SetProps) (rgba) = [ 128 128 128 128 ] (pos) = PAIR(320, 140) 
	(wait) 1000 
	(Die) 
ENDSCRIPT

SCRIPT (goal_collect_activate) 
	(goal_start) (goal_id) = <goal_id> 
	(SpawnScript) (goal_collect_wait_and_initialize_objects) (params) = <...> 
ENDSCRIPT

SCRIPT (goal_collect_wait_and_initialize_objects) 
	IF NOT (GotParam) (quick_start) 
		(WaitForEvent) (type) = (goal_cam_anim_post_start_done) 
		IF NOT (GoalManager_GoalIsActive) (name) = <goal_id> 
			RETURN 
		ENDIF 
	ENDIF 
	(GetArraySize) <goal_collect_objects> 
	<index> = 0 
	BEGIN 
		(init_goal_collect_object) { 
			( <goal_collect_objects> [ <index> ] ) 
			(goal_id) = <goal_id> 
			(trigger_obj_id) = <trigger_obj_id> 
			(goal_collect_object_init_script) = <goal_collect_object_init_script> 
		} 
		IF (GotParam) (create_collect_arrows) 
			(goal_collect_add_arrow) { 
				( <goal_collect_objects> [ <index> ] ) 
				(goal_name) = <goal_name> 
				(index) = <index> 
			} 
		ENDIF 
		IF (GotParam) (create_evil_collect_arrows) 
			(goal_collect_add_arrow) { 
				( <goal_collect_objects> [ <index> ] ) 
				(goal_name) = <goal_name> 
				(index) = <index> 
				(arrow_model) = "evilarrow" 
			} 
		ENDIF 
		<index> = ( <index> + 1 ) 
	REPEAT <array_size> 
	BEGIN 
		IF (GetNextArrayElement) <goal_collect_objects> 
			(goal_collect_run_init_script) <element> 
		ELSE 
			BREAK 
		ENDIF 
	REPEAT 
ENDSCRIPT

SCRIPT (goal_collect_run_init_script) 
	IF (GotParam) (init_script) 
		<init_script> <...> 
	ENDIF 
ENDSCRIPT

SCRIPT (goal_collect_active) 
	IF (GoalManager_AllFlagsSet) (name) = <goal_id> 
		(GoalManager_WinGoal) (name) = <goal_id> 
	ENDIF 
ENDSCRIPT

SCRIPT (goal_collect_Wait_and_win) 
	(wait) <win_wait_time> 
	(GoalManager_WinGoal) (name) = <goal_id> 
ENDSCRIPT

SCRIPT (goal_collect_success) 
	(goal_success) (goal_id) = <goal_id> 
ENDSCRIPT

SCRIPT (goal_collect_deactivate) 
	(KillSpawnedScript) (name) = (goal_collect_wait_and_initialize_objects) 
	(GoalManager_EditGoal) (name) = <goal_id> (params) = { (wait_and_win_started) = 0 } 
	IF (GotParam) (trigger_obj_id) 
		(GoalManager_ResetGoalTrigger) (name) = <goal_id> 
	ENDIF 
	(goal_deactivate) (goal_id) = <goal_id> 
ENDSCRIPT

SCRIPT (goal_collect_clear_exceptions) 
	IF (GotParam) (id) 
		<id> : (Obj_ClearExceptions) 
	ENDIF 
ENDSCRIPT

SCRIPT (goal_collect_expire) 
	(goal_expire) (goal_id) = <goal_id> 
	(GoalManager_LoseGoal) (name) = <goal_id> 
ENDSCRIPT

SCRIPT (goal_collect_fail) 
	(goal_fail) (goal_id) = <goal_id> 
ENDSCRIPT

SCRIPT (goal_collect_reset_objects) 
	(GoalManager_ResetGoalFlags) (name) = <goal_id> 
	(GoalManager_GetGoalParams) (name) = <goal_id> 
	(GetArraySize) <goal_collect_objects> 
	<index> = 0 
	BEGIN 
		(init_goal_collect_object) ( <goal_collect_objects> [ <index> ] ) <...> 
		<index> = ( <index> + 1 ) 
	REPEAT <array_size> 
	IF (GotParam) (use_hud_counter) 
		(goal_update_counter) <...> 
	ENDIF 
ENDSCRIPT

SCRIPT (goal_collect_add_arrow) 
	IF NOT (IsAlive) (name) = <id> 
		RETURN 
	ENDIF 
	IF NOT (GotParam) (arrow_height) 
		<arrow_height> = 100 
	ENDIF 
	<arrow_pos> = ( VECTOR(0, 1, 0) * <arrow_height> ) 
	IF NOT (GotParam) (arrow_model) 
		<arrow_model> = "goalarrow" 
	ENDIF 
	(FormatText) (ChecksumName) = (arrow_id) "%g_%i_arrow" (g) = <goal_name> (i) = <index> 
	IF (ScreenElementExists) (id) = <arrow_id> 
		(DestroyScreenElement) (id) = <arrow_id> 
	ENDIF 
	(SetScreenElementLock) (id) = (root_window) (off) 
	(CreateScreenElement) { 
		(parent) = (root_window) 
		(type) = (Element3D) 
		(id) = <arrow_id> 
		(model) = <arrow_model> 
		(HoverParams) = { (Amp) = 9.50000000000 (Freq) = 2.50000000000 } 
		(AngVelY) = 0.15999999642 
		(ParentParams) = { (name) = <id> <arrow_pos> (IgnoreParentsYRotation) } 
	} 
ENDSCRIPT


