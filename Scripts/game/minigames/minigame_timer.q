
minigame_timer_GenericParams = { 
	init = minigame_timer_init 
	activate = minigame_timer_activate 
	active = minigame_timer_active 
	deactivate = minigame_timer_deactivate 
	success = minigame_timer_success 
	fail = minigame_timer_fail 
	expire = minigame_timer_expire 
	cash_limit = 500 
	time = 60 
	minigame 
} 
SCRIPT minigame_timer_init 
ENDSCRIPT

SCRIPT minigame_timer_activate 
	minigame_activate goal_id = <goal_id> 
ENDSCRIPT

SCRIPT minigame_timer_active 
ENDSCRIPT

SCRIPT minigame_timer_deactivate 
	minigame_deactivate goal_id = <goal_id> 
ENDSCRIPT

SCRIPT minigame_timer_success 
ENDSCRIPT

SCRIPT minigame_timer_fail 
ENDSCRIPT

SCRIPT minigame_timer_expire 
	IF GotParam expire_script 
		SpawnScript <expire_script> <expire_script_params> 
	ENDIF 
ENDSCRIPT


