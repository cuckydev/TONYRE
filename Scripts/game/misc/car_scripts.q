
accelCarRot = -1.00000000000 
decelCarRot = 3.00000000000 
speedCarRot = 0.12500000000 
accelCarRotFactor = 5.00000000000 
driving_parked_car = 0 
SCRIPT SetupDrivableCar 
	IF GameModeEquals is_creategoals 
		RETURN 
	ENDIF 
	RunScriptOnObject car_set_exceptions Id = <Id> Params = { <...> } 
ENDSCRIPT

SCRIPT car_set_exceptions trigger_radius = 16 
	IF ObjectExists Id = goal_start_dialog 
		speech_box_exit anchor_id = goal_start_dialog 
	ENDIF 
	SetTags control_type = <control_type> restart_node = <restart_node> exit_node = <exit_node> destroy_car = <destroy_car> 
	ClearException SkaterOutOfRadius 
	Obj_SetInnerRadius <trigger_radius> 
	SetException ex = SkaterInRadius scr = car_inner_radius_handler 
	Block 
ENDSCRIPT

SCRIPT car_inner_radius_handler 
	GetSkaterId 
	<skaterId> = <objId> 
	Obj_GetId 
	IF CustomParkMode editing 
		RETURN 
	ENDIF 
	IF ObjectExists Id = goal_start_dialog 
		<should_destroy> = 0 
		IF <skaterId> : IsInBail 
			<should_destroy> = 1 
		ENDIF 
		IF SkaterCurrentScorePotGreaterThan 0 
			<should_destroy> = 1 
		ENDIF 
		IF NOT GoalManager_CanStartGoal 
			<should_destroy> = 1 
		ENDIF 
		IF ( in_cat_preview_mode = 1 ) 
			<should_destroy> = 1 
		ENDIF 
		IF ( <should_destroy> = 1 ) 
			DestroyScreenElement Id = goal_start_dialog 
		ENDIF 
	ELSE 
		IF ObjectExists Id = root_window 
			root_window : GetTags 
			IF GotParam menu_state 
				IF ( <menu_state> = on ) 
					RETURN 
				ENDIF 
			ENDIF 
		ENDIF 
		IF ( in_cat_preview_mode = 0 ) 
			IF GoalManager_CanStartGoal 
				<skater_ready_for_goal> = 0 
				IF NOT <skaterId> : Driving 
					IF <skaterId> : OnGround 
						<skater_ready_for_goal> = 1 
					ELSE 
						IF <skaterId> : Walking 
							<skater_ready_for_goal> = 1 
						ENDIF 
					ENDIF 
				ENDIF 
				IF ( <skater_ready_for_goal> = 1 ) 
					IF NOT <skaterId> : IsInBail 
						IF NOT SkaterCurrentScorePotGreaterThan 0 
							<objId> : Obj_SetOuterRadius 20 
							<objId> : SetException ex = SkaterOutOfRadius scr = car_refuse 
							FormatText TextName = accept_text "Press \\m5 to drive." 
							create_speech_box { 
								anchor_id = goal_start_dialog 
								text = <accept_text> 
								no_pad_choose 
								no_pad_start 
								pad_circle_script = car_accept 
								pad_circle_params = { objId = <objId> } 
								pad_square_script = <pad_square_script> 
								pad_square_params = <pad_square_params> 
								bg_rgba = [ 100 100 100 128 ] 
								text_rgba = [ 128 128 128 128 ] 
								font = small 
								z_priority = 5 
							} 
						ENDIF 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT car_refuse anchor_id = goal_start_dialog 
	ClearException SkaterOutOfRadius 
	speech_box_exit anchor_id = <anchor_id> 
ENDSCRIPT

SCRIPT car_accept anchor_id = goal_start_dialog 
	ClearException SkaterInRadius 
	speech_box_exit anchor_id = goal_start_dialog 
	<objId> : car_begin_driving_run 
ENDSCRIPT

SCRIPT car_begin_driving_run 
	IF NOT GameModeEquals is_singlesession 
		GoalManager_DeactivateAllGoals 
	ENDIF 
	Obj_GetId 
	GoalManager_GetLevelPrefix 
	FormatText ChecksumName = ReadyLevelScript "%l_KillVehicles" l = <level_prefix> 
	IF ScriptExists <ReadyLevelScript> 
		<ReadyLevelScript> CalledByParkedCar ParkedCar = <objId> 
	ENDIF 
	GetTags 
	goal_initialize_skater control_type = <control_type> restart_node = <restart_node> Exitable 
	IF GotParam destroy_car 
		kill name = <destroy_car> 
	ENDIF 
	Change driving_parked_car = 1 
	SpawnScript car_wait_for_exit_request 
	PlayerVehicle : SetTags ParkedCarId = <objId> ExitNode = <exit_node> DestroyCar = <destroy_car> 
	IF PlayerVehicle : Vehicle_HandbrakeActive 
		create_panel_block Id = current_goal text = "\\b3 = Accelerate\\n\\b1 = Brake/Reverse\\n\\b0 = Ditch" style = panel_message_goal 
	ELSE 
		create_panel_block Id = current_goal text = "\\b3 = Accelerate\\n\\b1 = Brake/Reverse\\n\\bf = Handbrake\\n\\b0 = Ditch" style = panel_message_goal 
	ENDIF 
	Die 
ENDSCRIPT

SCRIPT car_wait_for_exit_request 
	Wait 0.50000000000 Seconds 
	WaitForEvent Type = ExitVehicleRequest 
	Goto handle_exit_vehicle_request 
ENDSCRIPT

SCRIPT handle_exit_vehicle_request 
	PlayerVehicle : GetTags 
	car_end_driving_run 
	ResetSkaters node_name = <ExitNode> 
	MakeSkaterGoto HandBrake 
ENDSCRIPT

SCRIPT car_end_driving_run 
	KillSpawnedScript name = car_wait_for_exit_request 
	IF ObjectExists Id = current_goal 
		DestroyScreenElement Id = current_goal 
	ENDIF 
	PlayerVehicle : GetTags 
	GoalManager_GetLevelPrefix 
	FormatText ChecksumName = RestoreLevelScript "%l_CreateVehicles" l = <level_prefix> 
	IF ScriptExists <RestoreLevelScript> 
		<RestoreLevelScript> CalledByParkedCar ParkedCar = <ParkedCarId> 
	ENDIF 
	Create name = <ParkedCarId> 
	IF GotParam DestroyCar 
		IF NOT IsAlive name = <DestroyCar> 
			Create name = <DestroyCar> 
		ENDIF 
	ENDIF 
	Change driving_parked_car = 0 
ENDSCRIPT


