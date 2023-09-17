
SCRIPT minigame_init 
	GoalManager_GetGoalParams name = <goal_id> 
	IF GotParam init_script 
		SpawnScript <init_script> params = { <init_script_params> goal_id = <goal_id> } 
	ENDIF 
ENDSCRIPT

SCRIPT minigame_activate 
	GoalManager_GetGoalParams name = <goal_id> 
	IF GotParam activate_script 
		SpawnScript <activate_script> params = { <activate_script_params> goal_id = <goal_id> } 
	ENDIF 
ENDSCRIPT

SCRIPT minigame_deactivate 
	GoalManager_GetGoalParams name = <goal_id> 
	minigame_hide_timer 
	IF GotParam deactivate_script 
		SpawnScript <deactivate_script> params = { <deactivate_script_params> goal_id = <goal_id> } 
	ENDIF 
ENDSCRIPT

SCRIPT minigame_hide_timer 
	SetScreenElementProps { 
		id = minigame_timer 
		text = "" 
	} 
ENDSCRIPT

SCRIPT minigame_got_cash 
	FormatText TextName = message "You got $%i!" i = <amount> 
	create_panel_message id = goal_current_reward text = <message> style = goal_message_got_stat params = { sound = cash } 
ENDSCRIPT

SCRIPT minigame_cash_depleted 
	create_panel_message { 
		id = goal_current_reward 
		text = "You\'ve collected all the cash for this minigame" 
		style = goal_message_got_stat 
		params = { sound = cash } 
	} 
ENDSCRIPT


