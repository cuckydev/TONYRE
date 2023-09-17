
(controller_unplugged_frame_count) = 45 
SCRIPT (controller_unplugged) 
	(GetSkaterId) 
	IF NOT (LevelIs) (load_skateshop) 
		IF NOT (LevelIs) (load_boardshop) 
			IF NOT (LevelIs) (load_cas) 
				IF NOT (SkaterCamAnimFinished) (skater) = <objId> 
					RETURN 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
	IF (GotParam) (leaving_net_game) 
		(PauseGame) 
		(PauseMusicAndStreams) 
	ENDIF 
	(KillSpawnedScript) (name) = (wait_and_check_for_unplugged_controllers) 
	(change) (check_for_unplugged_controllers) = 0 
	(SpawnScript) (create_controller_unplugged_dialog) (params) = <...> 
ENDSCRIPT

SCRIPT (create_controller_unplugged_dialog) 
	(SetScreenElementProps) { 
		(id) = (root_window) 
		(block_events) 
		(hide) 
	} 
	<showing_comp_results> = 0 
	(root_window) : (GetTags) 
	<front_end_paused> = 0 
	IF (GameIsPaused) 
		<front_end_paused> = 1 
	ENDIF 
	IF NOT (GotParam) (leaving_net_game) 
		IF ( ( (LevelIs) (load_skateshop) ) | ( (LevelIs) (load_boardshop) ) | ( (LevelIs) (load_cas) ) ) 
			(GoalManager_DeactivateAllGoals) 
			(GoalManager_UninitializeAllGoals) 
			(PauseGame) 
			(PauseMusicAndStreams) 1 
		ELSE 
			IF ( <showing_comp_results> = 0 ) 
				(GoalManager_PauseAllGoals) 
				(PauseGame) 
				(PauseMusicAndStreams) 1 
			ELSE 
				(PauseGame) 
				(PauseMusicAndStreams) 1 
				(SetButtonEventMappings) (unblock_menu_input) 
			ENDIF 
		ENDIF 
	ENDIF 
	(wait) 1 (frame) 
	(CreateScreenElement) { 
		(type) = (WindowElement) 
		(id) = (unplugged_root_window) 
	} 
	(unplugged_root_window) : (SetTags) (front_end_paused) = <front_end_paused> 
	(unplugged_root_window) : (SetTags) (menu_state) = <menu_state> 
	(unplugged_root_window) : (SetTags) (showing_comp_results) = <showing_comp_results> 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (unplugged_root_window) 
		(texture) = (white2) 
		(pos) = PAIR(0, 0) 
		(just) = [ (left) (top) ] 
		(rgba) = [ 0 0 0 128 ] 
		(scale) = PAIR(80, 60) 
		(z_priority) = 999 
	} 
	(CreateScreenElement) { 
		(type) = (ContainerElement) 
		(parent) = (unplugged_root_window) 
		(id) = (controller_unplugged_dialog_anchor) 
		(pos) = PAIR(320, 240) 
		(dims) = PAIR(640, 480) 
		(z_priority) = 1000 
	} 
	<anchor_id> = <id> 
	(pad_choose_script) = (controller_refresh) 
	IF (GotParam) (leaving_net_game) 
		(FormatText) (TextName) = (text) "Controller disconnected. Please reconnect the controller to port %i and press \\b8 to return to the main menu." (i) = ( <device_num> + 1 ) 
		(unplugged_root_window) : (SetTags) (leaving_net_game) 
	ELSE 
		IF (IsNGC) 
			(FormatText) (TextName) = (text) "Please reconnect the controller to Controller Socket %i and press \\b8 to continue." (i) = ( <device_num> + 1 ) 
		ELSE 
			IF (IsPs2) 
				(FormatText) (TextName) = (text) "Please insert a controller into controller port %i and press \\b8 to continue." (i) = ( <device_num> + 1 ) 
			ELSE 
				(FormatText) (TextName) = (text) "Please reconnect the controller to port %i and press \\b8 to continue." (i) = ( <device_num> + 1 ) 
			ENDIF 
		ENDIF 
	ENDIF 
	<text_block_pos> = PAIR(320, 200) 
	(CreateScreenElement) { 
		(type) = (TextBlockElement) 
		(parent) = <anchor_id> 
		(pos) = <text_block_pos> 
		(dims) = PAIR(300, 0) 
		(allow_expansion) 
		(just) = [ (center) (center) ] 
		(font) = (small) 
		(text) = <text> 
		(z_priority) = 1000 
	} 
	(GetScreenElementDims) (id) = <id> 
	<button_pos> = ( <text_block_pos> + ( <height> * PAIR(0, 1) ) ) 
	(CreateScreenElement) { 
		(parent) = <anchor_id> 
		(type) = (TextElement) 
		(font) = (small) 
		(text) = "OK" 
		(pos) = <button_pos> 
		(just) = [ (center) (top) ] 
		(rgba) = [ 128 128 128 128 ] 
		(z_priority) = 1000 
		(event_handlers) = [ 
			{ (focus) (do_scale_up) } 
			{ (unfocus) (do_scale_down) } 
			{ (pad_choose) <pad_choose_script> (params) = { (original_device_num) = <device_num> } } 
			{ (pad_start) <pad_choose_script> (params) = { (original_device_num) = <device_num> } } 
		] 
	} 
	(FireEvent) (type) = (focus) (target) = <id> 
	(SetRootScreenElement) (id) = (unplugged_root_window) 
ENDSCRIPT

SCRIPT (controller_refresh) 
	IF ( <original_device_num> = <device_num> ) 
		(controller_reconnected) (device_num) = <device_num> 
		IF (CustomParkMode) (editing) 
			IF NOT (istrue) (in_create_a_goal) 
				IF NOT (ScreenElementExists) (id) = (dialog_box_anchor) 
					IF NOT (ScreenElementExists) (id) = (files_menu) 
						IF NOT (ScreenElementExists) (id) = (keyboard_anchor) 
							IF NOT (ObjectExists) (id) = (park_resize_cam) 
								(parked_continue_editing) 
								(ResetAbortAndDoneScripts) 
							ENDIF 
						ENDIF 
					ENDIF 
				ENDIF 
			ENDIF 
		ELSE 
			IF NOT ( (AbortScript) = (DefaultAbortScript) ) 
				(goto) (reload_anims_then_run_abort_script) 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT (controller_reconnected) 
	IF NOT (GotParam) (leaving_net_game) 
		IF NOT (LevelIs) (load_skateshop) 
			IF NOT (LevelIs) (load_boardshop) 
				IF NOT (LevelIs) (load_cas) 
					IF NOT (istrue) (in_create_a_goal) 
						IF NOT (CustomParkMode) (editing) 
							IF NOT (ScreenElementExists) (id) = (timeline_vmenu) 
								(Restore_skater_camera) 
							ENDIF 
						ENDIF 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
	(SetRootScreenElement) (id) = (root_window) 
	(SetScreenElementProps) { 
		(id) = (root_window) 
		(unblock_events) 
		(unhide) 
	} 
	IF NOT (GotParam) (leaving_net_game) 
		IF (ScreenElementExists) (id) = (pre_cat_menu_is_up) 
			(UnpauseGame) 
			IF (LevelIs) (load_nj) 
				(skater) : (Obj_MoveToNode) (name) = (TRG_G_CAT_RestartNode) (Orient) (NoReset) 
			ENDIF 
			(PauseGame) 
			(create_pre_cat_menu) 
		ELSE 
			IF (istrue) (in_create_a_goal) 
				IF (istrue) (goal_editor_placement_mode) 
					(Debounce) (X) (time) = 0.20000000298 (clear) = 1 
					(GoalEditor) : (UnPause) 
					IF (ObjectExists) (id) = (GoalEditorCursor) 
						(GoalEditorCursor) : (UnPause) 
					ENDIF 
				ENDIF 
			ELSE 
				(unplugged_root_window) : (GetTags) 
				IF ( <front_end_paused> = 0 ) 
					(UnpauseGame) 
					(UnPauseMusicAndStreams) 
				ENDIF 
				IF NOT ( ( (LevelIs) (load_skateshop) ) | ( (LevelIs) (load_boardshop) ) | ( (LevelIs) (load_cas) ) ) 
					IF ( <showing_comp_results> = 1 ) 
					ELSE 
						IF NOT (CustomParkMode) (editing) 
							IF ( <menu_state> = (off) ) 
								(FireEvent) { 
									(type) = (pad_start) 
									(target) = (root_window) 
									(data) = { (device_num) = <device_num> } 
								} 
							ENDIF 
						ENDIF 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
	IF (ScreenElementExists) (id) = (unplugged_root_window) 
		(DestroyScreenElement) { 
			(id) = (unplugged_root_window) 
		} 
	ENDIF 
	IF (ScreenElementExists) (id) = (high_scores_records_menu) 
		(FireEvent) (type) = (focus) (target) = (high_scores_records_menu) 
	ENDIF 
	IF (GotParam) (leaving_net_game) 
		(printf) "quitting network game!!!!!!!!!!!!!!!!!!!" 
		(UnpauseGame) 
		(quit_network_game) 
	ELSE 
		(SpawnScript) (wait_and_check_for_unplugged_controllers) 
	ENDIF 
ENDSCRIPT

SCRIPT (controller_pulled_disconnect_message) 
	(GoalManager_DeactivateAllGoals) (force_all) 
	(GoalManager_UninitializeAllGoals) 
	(GoalManager_SetCanStartGoal) 0 
	(exit_pause_menu) 
	(destroy_onscreen_keyboard) 
	(force_close_rankings) (dont_retry) 
	IF (InNetGame) 
		IF (LocalSkaterExists) 
			(skater) : (Vibrate) (off) 
		ENDIF 
	ENDIF 
	IF NOT (IsObserving) 
		(ExitSurveyorMode) 
	ENDIF 
	(dialog_box_exit) 
	(dialog_box_exit) (anchor_id) = (link_lost_dialog_anchor) 
	(create_error_box) { 
		(title) = "Notice" 
		(text) = "Controller disconnected. Select OK to leave this game." 
		(buttons) = [ { (text) = "ok" (pad_choose_script) = (accept_lost_connection) } ] 
		(delay_input) 
	} 
ENDSCRIPT

SCRIPT (wait_and_check_for_unplugged_controllers) (time) = 50 
	(wait) <time> 
	(change) (check_for_unplugged_controllers) = 1 
ENDSCRIPT


