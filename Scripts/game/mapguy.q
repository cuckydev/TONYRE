
MapGuy_GenericParams = { 
	trigger_obj_id = TRG_MapGuy 
} 
SCRIPT AddMapGuy 
	MapGuy_InitTrigger MapGuy_GenericParams <...> 
ENDSCRIPT

SCRIPT MapGuy_InitTrigger 
	IF NOT ObjectExists id = <trigger_obj_id> 
		create name = <trigger_obj_id> 
	ENDIF 
	IF GotParam trigger_wait_script 
		RunScriptOnObject id = <trigger_obj_id> <trigger_wait_script> 
	ELSE 
		RunScriptOnObject id = <trigger_obj_id> GenericProWaiting 
	ENDIF 
	attach_arrow_to_object object_id = <trigger_obj_id> 
	RunScriptOnObject id = <trigger_obj_id> mapguy_set_exceptions params = <...> 
ENDSCRIPT

SCRIPT mapguy_set_exceptions trigger_radius = 8 
	Obj_ClearExceptions 
	Obj_SetInnerRadius <trigger_radius> 
	Obj_SetException ex = SkaterInRadius scr = mapguy_got_trigger params = <...> 
ENDSCRIPT

SCRIPT mapguy_got_trigger 
	IF SkaterSpeedLessThan 20 
		IF SkaterIsBraking 
			PauseSkaters 
			Obj_ClearExceptions 
			Obj_SetOuterRadius 20 
			Obj_SetException ex = SkaterOutOfRadius scr = mapguy_set_exceptions params = <...> 
			IF ObjectExists id = current_menu_anchor 
				DestroyScreenElement id = current_menu_anchor 
			ENDIF 
			create_level_select_menu 
			SetScreenElementProps { id = level_select_menu 
				event_handlers = [ 
					{ pad_back mapguy_exit params = <...> } 
				] 
				replace_handlers 
			} 
			SetScreenElementProps { id = root_window 
				event_handlers = [ 
					{ pad_start mapguy_exit params = <...> } 
				] 
				replace_handlers 
			} 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT mapguy_exit 
	KillSkaterCamAnim all 
	SetScreenElementProps { id = root_window 
		replace_handlers 
		event_handlers = [ 
			{ pad_start handle_start_pressed } 
		] 
	} 
	UnPauseSkaters 
	exit_pause_menu 
ENDSCRIPT

SCRIPT mapguy_start 
	SetScreenElementProps { id = root_window 
		replace_handlers 
		event_handlers = [ 
			{ pad_start handle_start_pressed } 
		] 
	} 
	UnPauseSkaters 
	<trigger_obj_id> : Obj_ClearExceptions 
	<trigger_obj_id> : Obj_SetOuterRadius 20 
	<trigger_obj_id> : Obj_SetException ex = SkaterOutOfRadius scr = mapguy_set_exceptions params = <...> 
	exit_pause_menu 
ENDSCRIPT


