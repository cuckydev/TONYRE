
minigame_Height_genericParams = { 
	init = minigame_Height_init 
	activate = minigame_Height_activate 
	active = minigame_Height_active 
	deactivate = minigame_Height_deactivate 
	number_collected = 1 
	minigame_record = 0 
	new_record = 0 
	trigger_obj_id = TRG_MG_Height 
	no_restart 
	minigame 
} 
SCRIPT minigame_Height_init 
	printf "adding height minigame" 
	IF NOT ObjectExists id = minigame_record 
		SetScreenElementLock id = root_window off 
		CreateScreenElement { 
			type = TextBlockElement 
			id = minigame_record 
			parent = root_window 
			text = " " 
			font = small 
			pos = PAIR(35, 105) 
			dims = PAIR(200, 100) 
			just = [ left center ] 
			internal_just = [ left bottom ] 
		} 
	ENDIF 
	IF NOT ObjectExists id = minigame_height 
		CreateScreenElement { 
			type = TextElement 
			id = minigame_height 
			parent = root_window 
			font = small 
			text = " " 
			pos = PAIR(35, 145) 
			just = [ left center ] 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT minigame_Height_activate 
	printf "activating height minigame" 
	RunScriptOnObject id = <trigger_obj_id> minigame_Height_set_exceptions params = { goal_id = <goal_id> } 
	GoalManager_SetStartHeight name = <goal_id> 
ENDSCRIPT

SCRIPT minigame_Height_active 
	IF GoalManager_CheckHeightRecord name = <goal_id> 
		GoalManager_GetGoalParams name = <goal_id> 
		FormatText TextName = height_message "New Record: %f\'%i\'\'\\n" f = <record_feet> i = <record_inches> 
		SetScreenElementProps { 
			rgba = [ 128 128 32 128 ] 
			id = minigame_record 
			text = <height_message> 
		} 
	ENDIF 
	GoalManager_GetGoalParams name = <goal_id> 
	FormatText TextName = height_message "%f\'%i\'\'" f = <current_height_feet> i = <current_height_inches> 
	SetScreenElementProps { 
		id = minigame_height 
		rgba = [ 115 26 26 95 ] 
		text = <height_message> 
	} 
ENDSCRIPT

SCRIPT minigame_Height_deactivate 
	<trigger_obj_id> : Obj_ClearExceptions 
	printf "deactivating height minigame" 
	SetScreenElementProps { 
		id = minigame_height 
		text = " " 
	} 
	SetScreenElementProps { 
		id = minigame_record 
		text = " " 
	} 
ENDSCRIPT

SCRIPT minigame_Height_set_exceptions 
	Obj_SetException ex = SkaterLanded scr = minigame_Height_done params = { goal_id = <goal_id> } 
	Obj_SetException ex = SkaterBailed scr = minigame_Height_done params = { goal_id = <goal_id> } 
ENDSCRIPT

SCRIPT minigame_Height_done 
	printf "height done called" 
	Obj_ClearExceptions 
	GoalManager_DeactivateGoal name = <goal_id> 
ENDSCRIPT


