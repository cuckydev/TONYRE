
ped_skater_min_square_distance_to_waypoint = 3 
ped_skater_min_square_distance_to_skater = 144 
ped_skater_min_square_distance_to_crouch_for_jump = 14400 
ped_skater_fade_target_bias_max_distance_square = 7056 
ped_skater_stick_dist_below = 24.00000000000 
ped_skater_stick_dist_above = 18.00000000000 
ped_skater_jump_col_dist_above = 12 
ped_skater_jump_col_dist_below = 12 
ped_skater_vert_jump_speed_slop = 1 
ped_skater_bail_deceleration = 9 
ped_skater_stop_deceleration = 10 
ped_skater_min_180_spin_time = 0.30000001192 
ped_skater_vert_rotation_time_slop = 1.10000002384 
ped_skater_spine_rotation_slop = 60 
ped_skater_jump_to_next_node_height_slop = 12 
ped_skater_jump_speed = 280 
ped_skater_jump_gravity = -700 
ped_skater_grind_anims = [ 
	{ InitAnim = Init_BSBoardslide Anim = BSBoardslide_range OutAnim = BSBoardslide_Out BailAnim = NutterFallForward GetUpAnim = GetUpForwards } 
	{ InitAnim = Init_FiftyFifty Anim = FiftyFifty_range BailAnim = FiftyFiftyFallForward GetUpAnim = GetUpFacing } 
	{ InitAnim = Init_FSCrooked Anim = FSCrooked_range BailAnim = FiftyFiftyFallForward GetUpAnim = GetUpFacing } 
	{ InitAnim = Init_FSOvercrook Anim = FSOvercrook_range BailAnim = FiftyFiftyFallForward GetUpAnim = GetUpFacing } 
	{ InitAnim = Init_FSSmith Anim = FSSmith_range BailAnim = NutterFallForward GetUpAnim = GetUpForwards } 
	{ InitAnim = Init_BSSmith Anim = BSSmith_range BailAnim = NutterFallForward GetUpAnim = GetUpForwards } 
	{ InitAnim = Init_FSFeeble Anim = FSFeeble_range BailAnim = NutterFallForward GetUpAnim = GetUpForwards } 
	{ InitAnim = Init_Nosegrind Anim = Nosegrind_range BailAnim = FiftyFiftyFallForward GetUpAnim = GetUpFacing } 
	{ InitAnim = Init_Tailgrind Anim = Tailgrind_range BailAnim = FiftyFiftyFallForward GetUpAnim = GetUpFacing } 
] 
ped_skater_brake_idle_anims = [ 
	NewBrakeIdle 
	NewBrakeIdle 
	NewBrakeIdle 
	NewBrakeIdle 
	NewBrakeIdle 
	NewBrakeIdle 
	NewBrakeIdle 
	NewBrakeIdle2 
	NewBrakeIdle3 
	NewBrakeIdle4 
	NewBrakeIdle5 
	NewBrakeIdle6 
	NewBrakeIdle7 
	NewBrakeIdle8 
] 
ped_skater_action_scripts = [ 
	ped_skater_idle 
	ped_skater_grind 
	ped_skater_grind_off 
	ped_skater_grab_trick 
	ped_skater_lip_trick 
	ped_skater_land 
	ped_skater_manual 
	ped_skater_manual_down 
	ped_skater_jump 
	ped_skater_vert_jump 
	ped_skater_roll_off 
	ped_skater_crouch_for_jump 
	ped_skater_flip_trick 
	ped_skater_wait_and_stop_grab_anim 
	ped_skater_stop 
] 
SCRIPT ped_skater_crouch_for_jump 
	Obj_PlayAnim Anim = Crouch 
	Obj_WaitAnimFinished Anim = CrouchIdle cycle 
ENDSCRIPT

SCRIPT ped_skater_jump 
	Obj_ShadowOff 
	IF NOT GotParam jumpSpeed 
		<jumpSpeed> = ped_skater_jump_speed 
	ENDIF 
	Ped_PlayJumpSound 
	IF GotParam land_height 
		Obj_Jump { speed = <jumpSpeed> 
			gravity = ped_skater_jump_gravity 
			heading = <heading> 
			land_height = <land_height> 
		} 
	ELSE 
		Obj_Jump speed = <jumpSpeed> gravity = ped_skater_jump_gravity 
	ENDIF 
	Obj_SpawnScript ped_skater_play_midair_anim params = { Anim = Ollie } 
	Obj_WaitJumpFinished 
	Obj_GetID 
	TerminateObjectsScripts id = <objId> script_name = ped_skater_play_midair_anim use_proper_version 
	Ped_PlayLandSound 
	IF GotParam land_height 
		IF GotParam should_land 
			ped_skater_land 
		ENDIF 
		Ped_StartMoving 
		Ped_HitWaypoint 
	ELSE 
		ped_skater_land 
	ENDIF 
ENDSCRIPT

SCRIPT ped_skater_vert_jump 
	Obj_ShadowOff 
	Ped_StopMoving 
	IF NOT GotParam jumpSpeed 
		<jumpSpeed> = ped_skater_jump_speed 
	ENDIF 
	Obj_PlayAnim Anim = Ollie 
	Ped_PlayJumpSound 
	Obj_Jump heading = <heading> speed = ( <jumpSpeed> * ped_skater_vert_jump_speed_slop ) gravity = ped_skater_jump_gravity 
	Obj_WaitAnimFinished 
	Obj_PlayAnim Anim = AirIdle cycle 
	Obj_WaitJumpFinished 
	Ped_PlayLandSound 
	IF GotParam should_flip 
		Obj_Flip 
	ENDIF 
	Ped_StartMoving 
	ped_skater_land Anim = CrouchedLandTurn 
ENDSCRIPT

SCRIPT ped_skater_roll_off 
	Obj_ShadowOff 
	Ped_GetCurrentVelocity 
	Ped_StopMoving 
	Obj_Jump use_current_heading speed = <velocity> gravity = ped_skater_jump_gravity 
	Obj_WaitJumpFinished 
	Ped_PlayLandSound 
	Ped_StartMoving 
	ped_skater_land small 
ENDSCRIPT

SCRIPT ped_skater_grind 
	Obj_ShadowOff 
	IF NOT GotParam range_anim 
		GetRandomArrayElement ped_skater_grind_anims 
		<range_anim> = ( <element> . Anim ) 
		<init_anim> = ( <element> . InitAnim ) 
		<bail_anim> = ( <element> . BailAnim ) 
		<get_up_anim> = ( <element> . GetUpAnim ) 
		IF StructureContains structure = <element> OutAnim 
			<out_anim> = ( <element> . OutAnim ) 
		ENDIF 
	ENDIF 
	SetTags { 
		grind_init_anim = <init_anim> 
		grind_range_anim = <range_anim> 
		grind_out_anim = <out_anim> 
		grind_bail_anim = <bail_anim> 
		grind_get_up_anim = <get_up_anim> 
	} 
	Obj_PlayAnim Anim = <init_anim> 
	Obj_WaitAnimFinished 
	<wobble_to> = RANDOM(1, 1) RANDOMCASE Start RANDOMCASE End RANDOMEND 
	Obj_PlayAnim Anim = <range_anim> PingPong From = Current To = <wobble_to> speed = 0.89999997616 BlendPeriod = 0.10000000149 
ENDSCRIPT

SCRIPT ped_skater_grind_off 
	GetTags 
	Obj_EnableAnimBlending enabled = 1 
	IF GotParam grind_out_anim 
		Obj_PlayAnim Anim = <grind_out_anim> 
	ELSE 
		Obj_PlayAnim Anim = <grind_init_anim> backwards 
	ENDIF 
	ped_skater_roll_off <...> 
ENDSCRIPT

SCRIPT ped_skater_grab_trick 
	Obj_ShadowOff 
	IF NOT GotParam jumpSpeed 
		<jumpSpeed> = ped_skater_jump_speed 
	ENDIF 
	IF GotParam is_vert 
		Ped_StopMoving 
	ENDIF 
	IF NOT GotParam Anim 
		GetConfigurableTricksFromType type = GrabTrick 
		GetRandomArrayElement <ConfigurableTricks> 
		<trick_params> = ( <element> . params ) 
		<Anim> = ( <trick_params> . Anim ) 
		<idle_anim> = ( <trick_params> . Idle ) 
		IF StructureContains structure = <trick_params> OutAnim 
			<out_anim> = ( <trick_params> . OutAnim ) 
		ENDIF 
	ENDIF 
	Ped_PlayJumpSound 
	IF GotParam is_vert 
		Obj_Jump heading = <heading> speed = <jumpSpeed> gravity = ped_skater_jump_gravity 
	ELSE 
		IF ( <is_jumping> = 0 ) 
			Obj_Jump speed = <jumpSpeed> gravity = ped_skater_jump_gravity 
		ENDIF 
	ENDIF 
	Obj_PlayAnim Anim = <Anim> 
	Obj_SpawnScript ped_skater_wait_and_stop_grab_anim params = <...> 
	Obj_WaitJumpFinished 
	Ped_PlayLandSound 
	Obj_GetID 
	TerminateObjectsScripts use_proper_version id = <objId> script_name = ped_skater_wait_and_stop_grab_anim 
	IF GotParam is_vert 
		IF GotParam should_flip 
			Obj_Flip 
		ENDIF 
		Ped_StartMoving 
		<land_anim> = CrouchedLandTurn 
	ELSE 
		<land_anim> = Land 
	ENDIF 
	ped_skater_land Anim = <land_anim> 
ENDSCRIPT

SCRIPT ped_skater_wait_and_stop_grab_anim 
	IF GotParam jumpTime 
		wait ( <jumpTime> * 0.50000000000 ) seconds 
		IF GotParam out_anim 
			Obj_PlayAnim Anim = <out_anim> 
			Obj_WaitAnimFinished 
		ELSE 
			Obj_PlayAnim Anim = <Anim> backwards 
			Obj_WaitAnimFinished 
		ENDIF 
		Obj_PlayAnim Anim = AirIdle cycle 
	ENDIF 
ENDSCRIPT

SCRIPT ped_skater_stop 
	Ped_StoreMaxVelocity 
	IF NOT GotParam deceleration 
		<deceleration> = ped_skater_stop_deceleration 
	ENDIF 
	Obj_SetPathDeceleration <deceleration> 
	Obj_SetPathVelocity 0 
	BEGIN 
		Ped_GetCurrentVelocity 
		IF ( <velocity> = 0 ) 
			Ped_StopMoving 
			BREAK 
		ENDIF 
		wait 1 frame 
	REPEAT 
	Obj_PlayAnim Anim = NewBrake 
	Obj_WaitAnimFinished 
	IF GotParam RandomStopTime 
		<StopTime> = RANDOM_RANGE PAIR(1.00000000000, 30.00000000000) 
	ENDIF 
	IF GotParam StopTime 
		IF ( <StopTime> > 0 ) 
			Obj_SpawnScript ped_skater_wait_and_start_moving params = { StopTime = <StopTime> } 
		ENDIF 
	ENDIF 
	GetTags 
	BEGIN 
		GetRandomArrayElement <brake_idle_anims> 
		Obj_PlayAnim Anim = <element> 
		Obj_WaitAnimFinished 
	REPEAT 
ENDSCRIPT

SCRIPT ped_skater_wait_and_start_moving 
	wait <StopTime> seconds 
	Obj_GetID 
	TerminateObjectsScripts use_proper_version id = <objId> script_name = ped_skater_stop 
	Obj_WaitAnimFinished 
	Ped_StartMoving 
ENDSCRIPT

SCRIPT ped_skater_start_moving 
	Ped_GetOriginalMaxVelocity 
	GetTags 
	IF GotParam ped_skater_acceleration 
		Obj_SetPathAcceleration <ped_skater_acceleration> 
	ENDIF 
	Obj_SetPathVelocity <original_max_velocity> ips 
	Obj_PlayAnim Anim = NewBrakeIdleToIdle 
	Obj_WaitAnimFinished 
	ped_skater_idle 
ENDSCRIPT

SCRIPT ped_skater_manual 
	Obj_ShadowOn 
	SWITCH <ManualType> 
		CASE Manual 
			SetTags manual_out_anim = PutDownManual 
			init_anim = Manual 
			range_anim = Manual_range 
		CASE Handstand 
			SetTags manual_out_anim = RustySlide_Out 
			init_anim = RustySlide_Init 
			range_anim = Primo_Range 
		DEFAULT 
			SetTags manual_out_anim = PutDownManual 
			init_anim = Manual 
			range_anim = Manual_range 
	ENDSWITCH 
	Obj_PlayAnim Anim = <init_anim> 
	Obj_WaitAnimFinished 
	Obj_PlayAnim Anim = <range_anim> PingPong From = Start To = End speed = 1.10000002384 BlendPeriod = 0.10000000149 
ENDSCRIPT

SCRIPT ped_skater_manual_down 
	Obj_ShadowOn 
	GetTags 
	IF NOT GotParam manual_out_anim 
		<Anim> = PutDownManual 
	ENDIF 
	Obj_PlayAnim Anim = <manual_out_anim> 
	Obj_WaitAnimFinished 
	ped_skater_idle 
ENDSCRIPT

SCRIPT ped_skater_manual_bail 
ENDSCRIPT

SCRIPT ped_skater_lip_trick 
	Obj_ShadowOff 
	Ped_SetLogicState lip_trick 
	Ped_StopMoving 
	Obj_EnableAnimBlending enabled = 1 
	IF NOT GotParam Anim 
		GetConfigurableTricksFromType type = LipMacro2 
		GetRandomArrayElement <ConfigurableTricks> 
		<trick_params> = ( <element> . params ) 
		<init_anim> = ( <trick_params> . InitAnim ) 
		<Anim> = ( <trick_params> . Anim ) 
		<out_anim> = ( <trick_params> . OutAnim ) 
	ENDIF 
	Obj_PlayAnim Anim = <init_anim> 
	Obj_WaitAnimFinished 
	IF NOT GotParam HoldLipTime 
		<HoldLipTime> = RANDOM_RANGE PAIR(1.00000000000, 3.00000000000) 
	ENDIF 
	Obj_PlayAnim Anim = <Anim> PingPong From = Current To = Start speed = 0.89999997616 
	wait <HoldLipTime> seconds 
	Obj_PlayAnim Anim = <out_anim> 
	IF NOT StructureContains structure = <trick_params> FlipAfter 
		Obj_Flip 
	ENDIF 
	Obj_WaitAnimFinished 
	Obj_EnableAnimBlending enabled = 0 
	Ped_StartMoving 
	Ped_SetLogicState generic_skater 
	ped_skater_land 
ENDSCRIPT

SCRIPT ped_skater_flip_trick 
	Obj_ShadowOff 
	IF GotParam is_vert 
		Ped_StopMoving 
	ENDIF 
	IF ( <is_jumping> = 0 ) 
		Obj_PlayAnim Anim = Ollie 
		IF GotParam is_vert 
			<jumpSpeed> = ( <jumpSpeed> * ped_skater_vert_jump_speed_slop ) 
		ENDIF 
		Ped_PlayJumpSound 
		IF GotParam land_height 
			Obj_Jump { speed = <jumpSpeed> 
				gravity = ped_skater_jump_gravity 
				heading = <heading> 
				land_height = <land_height> 
			} 
		ELSE 
			Obj_Jump { 
				speed = <jumpSpeed> 
				heading = <heading> 
				gravity = ped_skater_jump_gravity 
			} 
		ENDIF 
		wait 8 frame 
	ENDIF 
	IF NOT GotParam Anim 
		GetConfigurableTricksFromType type = FlipTrick 
		GetRandomArrayElement <ConfigurableTricks> 
		<trick_params> = ( <element> . params ) 
		<Anim> = ( <trick_params> . Anim ) 
	ENDIF 
	Obj_GetID 
	Obj_SpawnScript ped_skater_play_midair_anim params = { Anim = <Anim> } 
	Obj_WaitJumpFinished 
	TerminateObjectsScripts id = <objId> script_name = ped_skater_play_midair_anim use_proper_version 
	Ped_PlayLandSound 
	IF GotParam is_vert 
		Ped_StartMoving 
		<land_anim> = CrouchedLandTurn 
	ELSE 
		<land_anim> = Land 
	ENDIF 
	IF GotParam land_height 
		Ped_StartMoving 
		Obj_SpawnScript ped_skater_land Anim = <land_anim> 
		Ped_HitWaypoint 
	ELSE 
		ped_skater_land Anim = <land_anim> 
	ENDIF 
ENDSCRIPT

SCRIPT ped_skater_play_midair_anim 
	Obj_PlayAnim Anim = <Anim> 
	Obj_WaitAnimFinished 
	Obj_PlayAnim Anim = AirIdle cycle 
ENDSCRIPT

SCRIPT ped_skater_land 
	Obj_ShadowOn 
	IF NOT GotParam Anim 
		<Anim> = Land 
	ENDIF 
	Obj_PlayAnim Anim = <Anim> BlendPeriod = 0.30000001192 
	Obj_WaitAnimFinished 
	ped_skater_idle 
ENDSCRIPT

SCRIPT ped_skater_idle 
	BEGIN 
		IF Ped_NearVertNode 
			<anim_struct> = RANDOM(10, 1) RANDOMCASE { Anim = Idle } RANDOMCASE { init_anim = Crouch Anim = CrouchIdle out_anim = CrouchIdleToIdle cycle = 10 } RANDOMEND 
		ELSE 
			<anim_struct> = RANDOM(5, 10, 1) RANDOMCASE { Anim = Idle } RANDOMCASE { Anim = PushIdle } RANDOMCASE { init_anim = Crouch Anim = CrouchIdle out_anim = CrouchIdleToIdle cycle = 10 } RANDOMEND 
		ENDIF 
		RemoveParameter init_anim 
		RemoveParameter Anim 
		RemoveParameter cycle 
		RemoveParameter out_anim 
		IF StructureContains structure = <anim_struct> init_anim 
			<init_anim> = ( <anim_struct> . init_anim ) 
		ENDIF 
		<Anim> = ( <anim_struct> . Anim ) 
		IF StructureContains structure = <anim_struct> cycle 
			<cycle> = ( <anim_struct> . cycle ) 
		ELSE 
			<cycle> = 1 
		ENDIF 
		IF StructureContains structure = <anim_struct> out_anim 
			<out_anim> = ( <anim_struct> . out_anim ) 
		ENDIF 
		IF ( GotParam init_anim ) 
			Obj_PlayAnim Anim = <init_anim> 
			Obj_WaitAnimFinished 
		ENDIF 
		BEGIN 
			Obj_PlayAnim Anim = <Anim> 
			Obj_WaitAnimFinished 
		REPEAT <cycle> 
		IF GotParam out_anim 
			Obj_PlayAnim Anim = <out_anim> 
			Obj_WaitAnimFinished 
		ENDIF 
	REPEAT 
ENDSCRIPT

SCRIPT ped_skater_generic_bail 
	GetTags 
	IF NOT GotParam grind_bail_anim 
		<grind_bail_anim> = FaceFall 
		<grind_get_up_anim> = GetUpFaceSmash 
	ENDIF 
	Ped_SetIsBailing 1 
	Ped_StoreMaxVelocity 
	Obj_SetPathDeceleration ped_skater_bail_deceleration 
	Obj_SetPathVelocity 0 
	Obj_PlayAnim Anim = <grind_bail_anim> NoRestart BlendPeriod = 0.30000001192 
	Obj_WaitAnimFinished 
	Obj_PlayAnim Anim = <grind_get_up_anim> BlendPeriod = 0.10000000149 
	Obj_WaitAnimFinished 
	Ped_GetOriginalMaxVelocity 
	Obj_SetPathVelocity <original_max_velocity> ips 
	Ped_SetIsBailing 0 
	Obj_SpawnScript ped_skater_idle 
ENDSCRIPT

SCRIPT ped_skater_grind_bail 
	GetTags 
	IF NOT GotParam grind_bail_anim 
		<grind_bail_anim> = FiftyFiftyFallForward 
		<grind_get_up_anim> = GetUpFacing 
	ENDIF 
	Ped_SetIsBailing grind 1 
	IF GoalManager_GetActiveGoalId 
		GoalManager_GetGoalParams name = <goal_id> 
		IF GotParam film 
			Obj_GetID 
			printstruct <...> 
			IF ( <film_target> = <objId> ) 
				SpawnScript goal_film_bailed_skater params = { goal_id = <goal_id> } 
			ENDIF 
		ENDIF 
	ENDIF 
	SpawnSound Ped_Skater_Grind_Bail_Sound 
	ped_skater_generic_bail <...> 
	Ped_SetIsBailing grind 0 
ENDSCRIPT

SCRIPT ped_skater_stop_actions 
	Obj_GetID 
	GetArraySize ped_skater_action_scripts 
	<index> = 0 
	BEGIN 
		TerminateObjectsScripts use_proper_version id = <objId> script_name = ( ped_skater_action_scripts [ <index> ] ) 
		<index> = ( <index> + 1 ) 
	REPEAT <array_size> 
ENDSCRIPT


