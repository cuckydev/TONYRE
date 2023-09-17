
SCRIPT ped_initialize_collision_exceptions 
	GetTags 
	SWITCH <collision_mode> 
		CASE fall 
			Obj_SetInnerAvoidRadius 4 
			Obj_SetException { 
				ex = SkaterInAvoidRadius 
				scr = Ped_FallDownState 
			} 
		CASE knock 
			Obj_SetInnerAvoidRadius 2 
			Obj_SetException { 
				ex = SkaterInAvoidRadius 
				scr = Ped_KnockDownState 
			} 
		CASE avoid 
			Obj_SetInnerAvoidRadius 8 
			Obj_SetException { 
				ex = SkaterInAvoidRadius 
				scr = AVOIDSTATE_STOP 
			} 
		CASE bump 
			Obj_SetInnerAvoidRadius 2 
			Obj_SetException { 
				ex = SkaterInAvoidRadius 
				scr = goal_pro_bounce_skater 
			} 
		CASE ignore 
			Obj_ClearException SkaterInAvoidRadius 
		CASE shot 
			Obj_SetInnerAvoidRadius 8 
			Obj_SetException { 
				ex = SkaterInAvoidRadius 
				scr = Ped_ShotState 
			} 
	ENDSWITCH 
ENDSCRIPT

SCRIPT ped_return_to_precollision_state 
	GetTags 
	SetTags pissed = 0 
	ped_initialize_collision_exceptions 
	goto <collision_exception_return_state> 
ENDSCRIPT

SCRIPT AVOIDSTATE_STOP 
	Ped_SetLogicState avoid 
	Obj_ClearException SkaterInAvoidRadius 
	Obj_SetInnerAvoidRadius 4 
	Obj_SetException { 
		ex = SkaterInAvoidRadius 
		scr = AVOIDSTATE_INIT 
	} 
	wait 1 gameframe 
	ped_stop_movement 
	BEGIN 
		ped_rotate_to_skater_from_idle 
		RANDOM(1, 1, 1, 1) 
			RANDOMCASE ped_play_idle_anim 
			RANDOMCASE ped_play_idle_anim 
			RANDOMCASE ped_play_idle_anim 
			RANDOMCASE ped_play_wave_anim 
		RANDOMEND 
		Obj_GetDistanceToObject Skater 
		IF ( <objectDistance> > 12.00000000000 ) 
			ped_initialize_movement 
			goto ped_return_to_precollision_state 
		ENDIF 
	REPEAT 
ENDSCRIPT

SCRIPT AVOIDSTATE_INIT 
	Obj_ClearException SkaterInAvoidRadius 
	SetTags pissed = 0 
	Ped_RememberNextWaypoint 
	Ped_RememberCurrentPosition 
	Obj_StorePos 
	Ped_RememberStickToGround 
	goto AVOIDSTATE_JUMP 
ENDSCRIPT

SCRIPT AVOIDSTATE_JUMP 
	Obj_ClearException SkaterInAvoidRadius 
	GetTags 
	SetTags pissed = ( <pissed> + 1 ) 
	IF NOT Ped_SelectAvoidPoint <AvoidAnims> 
		IF NOT GotParam stand 
			goto AVOIDSTATE_KNOCKDOWN 
		ENDIF 
	ENDIF 
	BEGIN 
		Ped_MoveTowardsAvoidPoint 
		Obj_StickToGround 
		IF Ped_AvoidPointReached 
			BREAK 
		ENDIF 
		wait 1 gameframe 
	REPEAT 
	goto AVOIDSTATE_LAND 
ENDSCRIPT

SCRIPT AVOIDSTATE_LAND 
	GetTags 
	<maxPissedCount> = RANDOM_RANGE PAIR(2.00000000000, 4.00000000000) 
	IF ( <pissed> > <maxPissedCount> ) 
		Obj_SetInnerAvoidRadius 4 
		Obj_SetException { 
			ex = SkaterInAvoidRadius 
			scr = AVOIDSTATE_KNOCKDOWN 
		} 
	ELSE 
		Obj_SetInnerAvoidRadius 4 
		Obj_SetException { 
			ex = SkaterInAvoidRadius 
			scr = AVOIDSTATE_JUMP 
		} 
	ENDIF 
	IF SkaterSpeedLessThan 1 
		<stopped> = 1 
	ELSE 
		<stopped> = 0 
	ENDIF 
	BEGIN 
		Obj_GetDistanceToObject Skater 
		IF ( <objectDistance> > 6.00000000000 ) 
			<stopped> = 0 
		ENDIF 
		IF ( <stopped> = 1 ) 
			ped_rotate_to_skater_from_idle 
			RANDOM(1, 1, 1) 
				RANDOMCASE ped_play_disgust_anim 
				RANDOMCASE ped_play_idle_anim 
				RANDOMCASE ped_play_idle_anim 
			RANDOMEND 
		ELSE 
			IF ( <is_moving_ped> = 1 ) 
				ped_rotate_to_node_from_idle 
			ENDIF 
			BREAK 
		ENDIF 
	REPEAT 
	BEGIN 
		Obj_GetDistanceToObject Skater 
		IF ( <objectDistance> > 20.00000000000 ) 
			printf "returning to idle" 
			BREAK 
		ENDIF 
		wait 1 gameframe 
	REPEAT 
	ped_initialize_movement 
	Ped_RestoreStickToGround 
	goto ped_return_to_precollision_state 
ENDSCRIPT

SCRIPT AVOIDSTATE_KNOCKDOWN 
	Obj_ClearException SkaterInAvoidRadius 
	ped_rotate_to_skater_from_idle 
	ped_play_attack_anim no_block 
	wait 10 gameframes 
	Obj_GetOrientationToObject Skater 
	IF ( <dotProd> < 0.50000000000 ) 
		IF ( <dotProd> > -0.50000000000 ) 
			Obj_GetDistanceToObject Skater 
			IF ( <objectDistance> < 6.00000000000 ) 
				Obj_GetId 
				Skater : Obj_GetOrientationToObject <objId> 
				Skater : Rotate y = ( 180.00000000000 - <orientation> ) 
				MakeSkaterGoto PedKnockDown 
				Obj_WaitAnimFinished 
			ENDIF 
		ENDIF 
	ENDIF 
	GetTags 
	IF NOT GotParam stand 
		ped_initialize_movement 
	ENDIF 
	Ped_RestoreStickToGround 
	goto ped_return_to_precollision_state 
ENDSCRIPT

SCRIPT Ped_FallDownState 
	Obj_GetId 
	TerminateObjectsScripts id = <objId> script_name = ped_walker_hit_dead_end use_proper_version 
	TerminateObjectsScripts id = <objId> script_name = ped_adjust_speed_to_match_anim use_proper_version 
	TerminateObjectsScripts id = <objId> script_name = ped_standing_look_at_skater use_proper_version 
	TerminateObjectsScripts id = <objId> script_name = ped_skater_start_moving use_proper_version 
	Ped_SetLogicState fall 
	TerminateObjectsScripts id = <objId> script_name = ped_standing_idle use_proper_version 
	GetTags 
	Obj_ClearException SkaterInAvoidRadius 
	IF SkaterSpeedLessThan 1 
		goto Ped_DisgustState 
	ENDIF 
	<pissed> = ( <pissed> + 1 ) 
	IF ( <pissed> > 3 ) 
		SetTags pissed = <pissed> 
		goto Ped_KnockDownState 
	ENDIF 
	Temp_Ped_Fall_Sound 
	ped_play_falldown_anim 
	Obj_SetOuterAvoidRadius 10 
	Obj_SetException { 
		ex = SkaterOutOfAvoidRadius 
		scr = Ped_GetUpState 
	} 
	BEGIN 
		wait RANDOM(1, 1, 1) RANDOMCASE 10 RANDOMCASE 60 RANDOMCASE 90 RANDOMEND frames 
		ped_play_layidle_anim 
	REPEAT 
	goto Ped_GetUpState 
ENDSCRIPT

SCRIPT Ped_ShotState 
	Ped_SetLogicState shot 
	Obj_GetId 
	TerminateObjectsScripts id = <objId> script_name = ped_standing_idle use_proper_version 
	GetTags 
	Obj_ClearException SkaterInAvoidRadius 
	ped_play_falldown_anim 
	Obj_SetOuterAvoidRadius 10 
	Obj_SetException { 
		ex = SkaterOutOfAvoidRadius 
		scr = Ped_GetUpState 
	} 
	BEGIN 
		wait RANDOM(1, 1, 1) RANDOMCASE 10 RANDOMCASE 60 RANDOMCASE 90 RANDOMEND frames 
		ped_play_layidle_anim 
	REPEAT 
	goto Ped_GetUpState 
ENDSCRIPT

SCRIPT Ped_GetUpState 
	GetTags 
	Obj_ClearException SkaterOutOfAvoidRadius 
	ped_initialize_collision_exceptions 
	ped_play_getup_anim 
	goto Ped_DisgustState 
ENDSCRIPT

SCRIPT Ped_DisgustState 
	GetTags 
	IF NOT ( <should_look_at_skater> = 0 ) 
		ped_rotate_to_skater_from_idle 
	ENDIF 
	ped_play_disgust_anim 
	IF NOT GotParam stand 
		ped_initialize_movement 
	ENDIF 
	goto ped_return_to_precollision_state 
ENDSCRIPT

SCRIPT Ped_KnockDownState 
	Ped_StopMoving 
	GetTags 
	Obj_ClearException SkaterInAvoidRadius 
	Obj_LookAtObject type = Skater time = 0.05000000075 
	ped_play_attack_anim no_block 
	wait 10 gameframes 
	IF GoalManager_CanStartGoal 
		MakeSkaterGoto PedKnockDown 
	ENDIF 
	Obj_WaitAnimFinished 
	ped_rotate_to_skater_from_idle 
	goto Ped_DisgustState 
ENDSCRIPT

SCRIPT Ped_AvoidState 
	GetTags 
	Obj_ClearException SkaterInAvoidRadius 
	IF SkaterSpeedLessThan 1 
		goto Ped_DisgustState 
	ENDIF 
	IF SkaterSpeedGreaterThan 700 
		goto Ped_FallDownState 
	ENDIF 
	<pissed> = ( <pissed> + 1 ) 
	IF ( <pissed> > 3 ) 
		goto Ped_KnockDownState 
	ENDIF 
	Obj_StorePos 
	Obj_StoreNode 
	Ped_SelectAvoidPoint <AvoidAnims> 
	BEGIN 
		Ped_MoveTowardsAvoidPoint 
		IF Ped_AvoidPointReached 
			BREAK 
		ENDIF 
		wait 1 gameframe 
	REPEAT 
	Obj_PlayAnim anim = <idle> cycle 
	ped_rotate_to_skater_from_idle 
	ped_play_disgust_anim 
	ped_initialize_movement 
	goto ped_return_to_precollision_state 
ENDSCRIPT

SCRIPT Ped_BumpSkaterState 
	GetTags 
	Obj_ClearException SkaterInAvoidRadius 
	Obj_GetId 
	<index> = 0 
	BEGIN 
		printf "Ped_BumpSkaterState %d %e" d = <objId> e = <index> 
		<index> = ( <index> + 1 ) 
	REPEAT 10 
	goto ped_return_to_precollision_state 
	GetSkaterState 
	IF NOT ( <state> = skater_OnGround ) 
		RETURN 
	ENDIF 
	IF IsHidden 
		RETURN 
	ENDIF 
	root_window : GetTags 
	IF GotParam giving_rewards 
		IF ( <giving_rewards> = 1 ) 
			RETURN 
		ENDIF 
	ENDIF 
	Obj_ClearException SkaterInAvoidRadius 
	Obj_SpawnScript goal_pro_wait_and_reset_avoid_exception params = { goal_id = <goal_id> avoid_radius = <avoid_radius> } 
	IF Skater : SpeedGreaterThan 200 
		IF GotParam goal_id 
			GoalManager_PlayGoalStream name = <goal_id> type = "avoid" play_random 
		ENDIF 
		RETURN 
	ENDIF 
	Skater : GetTags 
	IF NOT ( <racemode> = none ) 
		RETURN 
	ENDIF 
	GetTags 
	Skater : Obj_GetOrientationToObject <id> 
	IF ( <dotProd> < 0.00000000000 ) 
		IF ( <dotProd> > -0.10000000149 ) 
			<speed> = 500 
			<heading> = 180 
		ELSE 
			<heading> = 90.00000000000 
		ENDIF 
	ELSE 
		IF ( <dotProd> < 0.10000000149 ) 
			<speed> = 500 
			<heading> = 180 
		ELSE 
			<heading> = -90 
		ENDIF 
	ENDIF 
	SkaterAvoidGoalPed heading = <heading> speed = <speed> 
ENDSCRIPT


