
(goal_CAT_GenericParams) = { 
	(init) = (goal_cat_init) 
	(uninit) = (goal_cat_uninit) 
	(activate) = (goal_cat_activate) 
	(active) = (goal_cat_active) 
	(deactivate) = (goal_cat_deactivate) 
	(fail) = (goal_cat_fail) 
	(success) = (goal_cat_success) 
	(expire) = (goal_cat_expire) 
	(create_a_trick) 
	(goal_text) = "Generic CAT goal text" 
	(view_goals_text) = "Do a CAT" 
	(time) = 20 
	(trigger_obj_id) = (TRG_G_CAT_Pro) 
	(start_pad_id) = (G_CAT_StartPad) 
	(restart_node) = (TRG_G_CAT_RestartNode) 
	(should_remove_trick) = 0 
	(trick_type) = (cat) 
} 
SCRIPT (goal_cat_init) 
	(goal_init) (goal_id) = <goal_id> 
ENDSCRIPT

SCRIPT (goal_cat_uninit) 
	(goal_uninit) (goal_id) = <goal_id> 
ENDSCRIPT

SCRIPT (goal_cat_activate) 
	(GoalManager_AddTempSpecialTrick) (name) = <goal_id> 
	(goal_start) (goal_id) = <goal_id> 
	(GoalManager_EditGoal) (name) = <goal_id> (params) = { (should_create_cat_menu) = 0 } 
ENDSCRIPT

SCRIPT (goal_cat_active) 
ENDSCRIPT

SCRIPT (goal_cat_deactivate) 
	(goal_deactivate) (goal_id) = <goal_id> 
	(GoalManager_RemoveTempSpecialTrick) (name) = <goal_id> 
ENDSCRIPT

SCRIPT (goal_cat_success) 
	(goal_success) (goal_id) = <goal_id> 
	IF NOT (GoalManager_HasWonGoal) (name) = <goal_id> 
		(GoalManager_EditGoal) (name) = <goal_id> (params) = { (should_create_cat_menu) = 1 } 
	ENDIF 
ENDSCRIPT

SCRIPT (goal_cat_fail) 
	(goal_fail) (goal_id) = <goal_id> 
ENDSCRIPT

SCRIPT (goal_cat_expire) 
	(goal_expire) (goal_id) = <goal_id> 
ENDSCRIPT

SCRIPT (goal_cat_create_menu) 
	(kill_start_key_binding) 
	(wait) 1 (frame) 
	(restore_start_key_binding) 
	(GoalManager_GetGoalParams) (name) = <goal_id> 
	IF ( <should_create_cat_menu> = 1 ) 
		(change) (viewer_buttons_enabled) = 0 
		IF NOT (InNetGame) 
			(printf) "-------------------- PAUSING GAME ----------------------" 
			(PauseGame) 
			(wait) 1 (gameframe) 
			(pause_trick_text) 
			(pause_balance_meter) 
			(pause_run_timer) 
			(kill_blur) 
			(hide_console_window) 
			IF (ObjectExists) (id) = (speech_box_anchor) 
				(DoScreenElementMorph) (id) = (speech_box_anchor) (scale) = 0 
			ENDIF 
			IF (ScreenElementExists) (id) = (goal_start_dialog) 
				(DestroyScreenElement) (id) = (goal_start_dialog) 
			ENDIF 
			IF (ScreenElementExists) (id) = (ped_speech_dialog) 
				(DestroyScreenElement) (id) = (ped_speech_dialog) 
			ENDIF 
			IF (ScreenElementExists) (id) = (goal_retry_anchor) 
				(DestroyScreenElement) (id) = (goal_retry_anchor) 
			ENDIF 
			IF (ScreenElementExists) (id) = (goal_complete) 
				(DestroyScreenElement) (id) = (goal_complete) 
			ENDIF 
			IF (ScreenElementExists) (id) = (goal_complete_sprite) 
				(DestroyScreenElement) (id) = (goal_complete_sprite) 
			ENDIF 
			IF (ScreenElementExists) (id) = (goal_complete_line2) 
				(DestroyScreenElement) (id) = (goal_complete_line2) 
			ENDIF 
			IF (ScreenElementExists) (id) = (goal_current_reward) 
				(DestroyScreenElement) (id) = (goal_current_reward) 
			ENDIF 
			(hide_goal_panel_messages) 
		ENDIF 
		(load_premade_cat) (index) = <premade_cat_index> (dont_focus_timeline) = 1 
		(SetScreenElementLock) (id) = (root_window) (off) 
		(CreateScreenElement) { 
			(type) = (SpriteElement) 
			(parent) = (root_window) 
			(id) = (darken_screen) 
			(scale) = PAIR(320, 240) 
			(texture) = (white2) 
			(rgba) = [ 0 0 0 60 ] 
			(z_priority) = 100 
		} 
		(SetScreenElementLock) (id) = (root_window) (on) 
		(create_dialog_box) { 
			(title) = "Create-A-Trick" 
			(text) = "Welcome! In THUG you can create your own tricks. The Trick timeline shows the components of the trick you just landed. Tweak it, or make a whole new trick and map it to your skater. You can return to Create-A-Trick at any time from the Pause menu." 
			(pos) = PAIR(320, 260) 
			(just) = [ (center) (center) ] 
			(text_scale) = 0.89999997616 
			(text_dims) = PAIR(300.00000000000, 0.00000000000) 
			(z_priority) = 101 
			(buttons) = [ 
				{ (font) = (small) (text) = "Modify My Trick Now" (pad_choose_script) = (goal_cat_focus_cat_menu) } 
				{ (font) = (small) (text) = "Return to Game" (pad_choose_script) = (goal_cat_refuse_cat_menu) } 
			] 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT (goal_cat_focus_cat_menu) 
	(dialog_box_exit) 
	IF (ObjectExists) (id) = (darken_screen) 
		(DestroyScreenElement) (id) = (darken_screen) 
	ENDIF 
	IF (ScreenElementExists) (id) = (timeline_vmenu) 
		(FireEvent) (type) = (focus) (target) = (timeline_vmenu) 
		(SpawnScript) (spawn_cat_demo_loop) 
	ENDIF 
	(kill_start_key_binding) 
ENDSCRIPT

SCRIPT (goal_cat_refuse_cat_menu) 
	IF (ObjectExists) (id) = (darken_screen) 
		(DestroyScreenElement) (id) = (darken_screen) 
	ENDIF 
	IF (ScreenElementExists) (id) = (current_menu_anchor) 
		(DestroyScreenElement) (id) = (current_menu_anchor) 
	ENDIF 
	IF (ScreenElementExists) (id) = (cat_menu_anchor) 
		(DestroyScreenElement) (id) = (cat_menu_anchor) 
	ENDIF 
	(GoalManager_InitializeAllGoals) 
	IF (ObjectExists) (id) = (CAT_Skater) 
		(CAT_Skater) : (TurnOffSpecialItem) 
		(CAT_Skater) : (Die) 
	ENDIF 
	(restore_skater_camera) 
	(KillSpawnedScript) (name) = (cat_perform_trick_loop) 
	(change) (running_cat_demo) = 0 
	(change) (in_cat_preview_mode) = 0 
	(restore_start_key_binding) 
	(dialog_box_exit) 
	(exit_pause_menu) 
ENDSCRIPT


