
Goal_Special_GenericParams = { 
	goal_text = "Generic Special goal text" 
	view_goals_text = "Do a special trick" 
	time = 20 
	init = goal_special_init 
	uninit = goal_uninit 
	activate = goal_special_activate 
	success = goal_special_success 
	deactivate = goal_special_deactivate 
	fail = goal_special_fail 
	expire = goal_special_expire 
	trigger_obj_id = TRG_G_SPECIAL_Pro 
	start_pad_id = G_SPECIAL_StartPad 
	restart_node = TRG_G_SPECIAL_RestartNode 
	should_remove_trick = 0 
	special 
	record_type = time 
} 
goal_special_tricks_lip = { 
	SpLip_L_R_Triangle 
	SpLip_R_L_Triangle 
	SpLip_D_L_Triangle 
	SpLip_D_R_Triangle 
	SpLip_D_U_Triangle 
	SpLip_L_D_Triangle 
	SpLip_L_U_Triangle 
	SpLip_R_D_Triangle 
	SpLip_R_U_Triangle 
	SpLip_U_D_Triangle 
	SpLip_U_L_Triangle 
	SpLip_U_R_Triangle 
	SpLip_U_U_Triangle 
} 
goal_special_tricks_air = { 
	SpAir_R_D_Circle 
	SpAir_L_R_Circle 
	SpAir_L_D_Circle 
	SpAir_L_D_Square 
	SpAir_R_D_Circle 
	SpAir_R_D_Square 
	SpAir_D_U_Circle 
	SpAir_D_U_Square 
	SpAir_D_L_Circle 
	SpAir_D_L_Square 
	SpAir_L_R_Square 
	SpAir_L_U_Circle 
	SpAir_L_U_Square 
	SpAir_D_R_Square 
	SpAir_R_L_Circle 
	SpAir_R_L_Square 
	SpAir_R_U_Circle 
	SpAir_R_U_Square 
	SpAir_U_D_Circle 
	SpAir_U_D_Square 
	SpAir_U_L_Circle 
	SpAir_U_L_Square 
	SpAir_U_R_Circle 
	SpAir_U_R_Square 
} 
goal_special_tricks_grind = { 
	SpGrind_D_L_Triangle 
	SpGrind_D_R_Triangle 
	SpGrind_D_U_Triangle 
	SpGrind_L_D_Triangle 
	SpGrind_L_R_Triangle 
	SpGrind_L_U_Triangle 
	SpGrind_R_D_Triangle 
	SpGrind_R_L_Triangle 
	SpGrind_R_U_Triangle 
	SpGrind_U_D_Triangle 
	SpGrind_U_L_Triangle 
	SpGrind_U_R_Triangle 
} 
goal_special_tricks_manual = { 
	SpMan_D_L_Triangle 
	SpMan_D_R_Triangle 
	SpMan_D_U_Triangle 
	SpMan_L_D_Triangle 
	SpMan_L_R_Triangle 
	SpMan_L_U_Triangle 
	SpMan_R_D_Triangle 
	SpMan_R_L_Triangle 
	SpMan_R_U_Triangle 
	SpMan_U_D_Triangle 
	SpMan_U_L_Triangle 
	SpMan_U_R_Triangle 
} 
SCRIPT goal_special_init 
	goal_init goal_id = <goal_id> 
ENDSCRIPT

SCRIPT goal_special_activate 
	GoalManager_AddTempSpecialTrick name = <goal_id> 
	GoalManager_GetGoalParams name = <goal_id> 
	goal_start goal_id = <goal_id> 
ENDSCRIPT

SCRIPT goal_special_deactivate 
	GoalManager_ResetGoalTrigger name = <goal_id> 
	goal_deactivate goal_id = <goal_id> 
	GoalManager_RemoveTempSpecialTrick name = <goal_id> 
ENDSCRIPT

SCRIPT goal_special_success 
	goal_success goal_id = <goal_id> 
ENDSCRIPT

SCRIPT goal_special_fail 
	goal_fail goal_id = <goal_id> 
ENDSCRIPT

SCRIPT goal_special_expire 
	goal_expire goal_id = <goal_id> 
	GoalManager_LoseGoal name = <goal_id> 
ENDSCRIPT

SCRIPT possibly_add_temp_special_trick 
	IF GoalManager_GetActiveGoalId 
		GoalManager_GetGoalParams name = <goal_id> 
		IF ( ( GotParam special ) | ( GotParam create_a_trick ) ) 
			GoalManager_AddTempSpecialTrick name = <goal_id> 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT possibly_remove_temp_special_trick 
	IF GoalManager_GetActiveGoalId 
		GoalManager_GetGoalParams name = <goal_id> 
		IF ( ( GotParam special ) | ( GotParam create_a_trick ) ) 
			GoalManager_RemoveTempSpecialTrick name = <goal_id> 
		ENDIF 
	ENDIF 
ENDSCRIPT


