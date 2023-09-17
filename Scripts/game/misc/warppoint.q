
SCRIPT ChooseTeleportNode 
	PauseGame 
	make_new_menu menu_title = "Choose node" id = teleport_menu pad_choose_script = exit_start_menu 
	SetScreenElementProps { id = main_menu event_handlers = [ 
			{ pad_back handle_start_pressed } 
		] 
		replace_handlers 
	} 
	AddWarpPointsToMenu nodes = <nodes> 
	RunScriptOnScreenElement id = main_menu_anchor animate_in 
ENDSCRIPT

SCRIPT WarpSkater 
	SpawnSkaterScript TeleportSkaterToNode params = { <...> } 
	UnPauseGame 
	Debounce X time = 0.30000001192 
	RunScriptOnScreenElement id = main_menu_anchor menu_offscreen 
ENDSCRIPT

SCRIPT WarpSkaterToNewLevel 
	IF ObjectExists id = main_menu_anchor 
		RunScriptOnScreenElement id = main_menu_anchor menu_offscreen callback = WarpSkaterToNewLevel2 callback_params = { <...> } 
	ELSE 
		WarpSkaterToNewLevel2 <...> 
	ENDIF 
ENDSCRIPT

SCRIPT WarpSkaterToNewLevel2 
	PauseGame 
	make_new_menu menu_title = "Warp to new level" id = warp_menu_anchor 
	SetScreenElementProps { id = main_menu_anchor 
		event_handlers = [ 
			{ pad_back exit_pause_menu } 
		] 
	} 
	make_text_sub_menu_item text = "Cancel" pad_choose_script = exit_pause_menu 
	make_text_sub_menu_item text = <text> pad_choose_script = level_select_change_level pad_choose_params = { level = <level> } 
	RunScriptOnScreenElement id = main_menu_anchor animate_in 
ENDSCRIPT


