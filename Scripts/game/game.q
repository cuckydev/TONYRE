
SCRIPT (PauseMusicAndStreams) 
	(PauseMusic) 1 
	(PauseStream) 1 
ENDSCRIPT

SCRIPT (UnPauseMusicAndStreams) 
	(PauseMusic) 0 
	(PauseStream) 0 
ENDSCRIPT

SCRIPT (do_backend_retry) 
	(GoalManager_UninitializeAllGoals) 
	IF (InNetGame) 
		IF NOT (IsObserving) 
			(ExitSurveyorMode) 
			(Skater) : (add_skater_to_world) 
		ENDIF 
		(ResetProSetFlags) 
		IF NOT (IsObserving) 
			(Skater) : (RunStarted) 
		ENDIF 
		(ClearPowerups) 
	ENDIF 
	(SpawnScript) (do_screen_freeze) 
ENDSCRIPT

SCRIPT (do_screen_freeze) 
	(kill_net_panel_messages) 
	(PauseGame) 
	IF (InNetGame) 
		(exit_pause_menu) (menu_id) = (pause_menu) 
		(force_close_rankings) 
		(destroy_onscreen_keyboard) 
		(StartNetworkLobby) 
	ELSE 
		(exit_pause_menu) (menu_id) = (pause_menu) 
		(force_close_rankings) 
		(SetGameType) (freeskate2p) 
		(SetCurrentGameType) 
	ENDIF 
	(Wait) 2 (gameframe) 
	(unpausegame) 
	(retry) 
ENDSCRIPT

SCRIPT (entered_chat_message) 
	(GetTextElementString) (id) = (keyboard_current_string) 
	(SendChatMessage) (string) = <string> 
	(destroy_onscreen_keyboard) 
ENDSCRIPT

SCRIPT (menu_entered_chat_message) 
	(entered_chat_message) 
	(create_pause_menu) 
ENDSCRIPT

SCRIPT (cancel_chat_menu) 
	(destroy_onscreen_keyboard) 
	(create_pause_menu) 
ENDSCRIPT

SCRIPT (launch_chat_keyboard) 
	(hide_current_goal) 
	(DestroyScreenElement) (id) = (current_menu_anchor) 
	(create_onscreen_keyboard) (allow_cancel) (icon) = <icon> (keyboard_cancel_script) = (cancel_chat_menu) (keyboard_done_script) = (menu_entered_chat_message) (keyboard_title) = "ENTER MESSAGE" (min_length) = 0 (max_length) = 127 (text) = "" (text_block) 
ENDSCRIPT

SCRIPT (enter_kb_chat) 
	(create_onscreen_keyboard) (allow_cancel) (no_buttons) (pos) = PAIR(320, 260) (keyboard_done_script) = (entered_chat_message) (display_text) = "ENTER MESSAGE: " (keyboard_title) = "ENTER MESSAGE" (min_length) = 1 (max_length) = 127 (text_block) 
ENDSCRIPT

SCRIPT (send_chat_message) 
	(printf) "Sending chat message..." 
	(SendChatMessage) <...> 
ENDSCRIPT

SCRIPT (PreRunQueuedScripts) 
	(SetSlomo) 100.00000000000 
ENDSCRIPT

SCRIPT (PostRunQueuedScripts) 
	(SetSlomo) 1 
ENDSCRIPT


