
(Goal_Film_GenericParams) = { 
	(goal_text) = "Find X things!" 
	(view_goals_text) = "Generic find things text" 
	(init) = (goal_film_init) 
	(uninit) = (goal_uninit) 
	(active) = (goal_film_active) 
	(activate) = (goal_film_activate) 
	(deactivate) = (goal_film_deactivate) 
	(expire) = (goal_film_expire) 
	(fail) = (goal_film_fail) 
	(success) = (goal_film_success) 
	(restart_node) = (TRG_G_FILM_RestartNode) 
	(trigger_obj_id) = (TRG_G_FILM_Pro) 
	(record_type) = (none) 
	(time) = 120 
	(max_distance_to_target) = 120 
	(time_on_camera) = 0 
	(Film) 
} 
SCRIPT (goal_film_init) 
	(goal_init) (goal_id) = <goal_id> 
ENDSCRIPT

SCRIPT (goal_film_activate) 
	(goal_start) (goal_id) = <goal_id> 
	IF (GotParam) (virtual_cam_params) 
		(GetSkaterId) 
		(PlaySkaterCamAnim) { 
			(name) = (goal_film_virtual_cam) 
			(skaterId) = <objId> 
			(targetID) = <objId> 
			(targetOffset) = ( <virtual_cam_params> . (targetOffset) ) 
			(positionOffset) = ( <virtual_cam_params> . (positionOffset) ) 
			(play_hold) 
			(frames) = 1 
			(skippable) = 0 
			(virtual_cam) 
			(allow_pause) = 1 
		} 
	ENDIF 
	IF (GotParam) (total_time_required) 
		IF (GotParam) (quick_start) 
			(GoalManager_StartFilming) (name) = <goal_id> 
			(goal_film_add_arrow_and_timer) (goal_id) = <goal_id> 
		ELSE 
			(SpawnScript) (goal_film_wait_and_start_filming) (params) = { (goal_id) = <goal_id> } 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT (goal_film_wait_and_start_filming) 
	(WaitForEvent) (type) = (goal_cam_anim_post_start_done) 
	IF NOT (GoalManager_GoalIsActive) (name) = <goal_id> 
		RETURN 
	ENDIF 
	(GoalManager_StartFilming) (name) = <goal_id> 
	(goal_film_add_arrow_and_timer) (goal_id) = <goal_id> 
ENDSCRIPT

SCRIPT (goal_film_add_arrow_and_timer) 
	IF (ScreenElementExists) (id) = (DesignerCreated_3DArrowPointer) 
		(DestroyScreenElement) (id) = (DesignerCreated_3DArrowPointer) 
	ENDIF 
	(GoalManager_GetGoalParams) (name) = <goal_id> 
	(show_cutscene_camera_hud) (for_goal) 
	(Create3dArrowPointer) { 
		(id) = (DesignerCreated_3DArrowPointer) 
		(model) = "HUD_arrow" 
		(pos) = PAIR(320, 70) 
		(scale) = 0.02500000037 
		(Tilt) = 7 
		(name) = <film_target> 
	} 
	IF (ScreenElementExists) (id) = (goal_film_update_message) 
		(DestroyScreenElement) (id) = (goal_film_update_message) 
	ENDIF 
	(SetScreenElementLock) (id) = (root_window) (off) 
	(CreateScreenElement) { 
		(parent) = (root_window) 
		(type) = (TextElement) 
		(font) = (small) 
		(text) = "Time: 0" 
		(id) = (goal_film_update_message) 
		(pos) = PAIR(320.00000000000, 240.00000000000) 
		(just) = [ (center) (center) ] 
		(z_priority) = -1000 
		(alpha) = 0 
	} 
ENDSCRIPT

SCRIPT (goal_film_active) 
	(FormatText) (TextName) = (text) "Time: %i" (i) = <time_on_camera> 
	IF (ScreenElementExists) (id) = (goal_film_update_message) 
		(SetScreenElementProps) { 
			(id) = (goal_film_update_message) 
			(text) = <text> 
		} 
	ELSE 
	ENDIF 
	IF ( <time_on_camera> > <last_time_on_camera> ) 
		(camera_hud_breakup_frames) (millisecs) = <time_on_camera> 
		IF (ScreenElementExists) (id) = (rec_anchor) 
			(DoScreenElementMorph) (id) = (rec_anchor) (alpha) = 1 
		ENDIF 
	ELSE 
		IF (ScreenElementExists) (id) = (rec_anchor) 
			(DoScreenElementMorph) (id) = (rec_anchor) (alpha) = 0 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT (goal_film_deactivate) 
	IF (GotParam) (virtual_cam_params) 
		(KillSkaterCamAnim) (name) = (goal_film_virtual_cam) 
	ENDIF 
	IF (ScreenElementExists) (id) = (goal_film_update_message) 
		(DestroyScreenElement) (id) = (goal_film_update_message) 
	ENDIF 
	IF (ScreenElementExists) (id) = (DesignerCreated_3DArrowPointer) 
		(DestroyScreenElement) (id) = (DesignerCreated_3DArrowPointer) 
	ENDIF 
	(kill_cutscene_camera_hud) 
	(GoalManager_ResetGoalTrigger) (name) = <goal_id> 
	(goal_deactivate) (goal_id) = <goal_id> 
ENDSCRIPT

SCRIPT (goal_film_expire) 
	(goal_expire) (goal_id) = <goal_id> 
ENDSCRIPT

SCRIPT (goal_film_fail) 
	(goal_fail) (goal_id) = <goal_id> 
ENDSCRIPT

SCRIPT (goal_film_bailed_skater) 
	(GoalManager_LoseGoal) (name) = <goal_id> 
ENDSCRIPT

SCRIPT (goal_film_success) 
	(goal_success) (goal_id) = <goal_id> 
ENDSCRIPT


