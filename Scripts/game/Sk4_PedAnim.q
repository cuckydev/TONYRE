
SCRIPT pedanim_init 
	SetTags <...> 
ENDSCRIPT

SCRIPT ped_play_impressed_anim 
	GetTags 
	GetArraySize <impressedAnims> 
	GetRandomValue name = index integer a = 0 b = ( <array_size> - 1 ) 
	Obj_PlayAnim Anim = ( ( <impressedAnims> ) [ <index> ] ) 
	IF NOT gotparam no_block 
		Obj_WaitAnimFinished 
	ENDIF 
ENDSCRIPT

SCRIPT ped_play_bored_anim 
	GetTags 
	GetArraySize <boredAnims> 
	GetRandomValue name = index integer a = 0 b = ( <array_size> - 1 ) 
	Obj_PlayAnim Anim = ( ( <boredAnims> ) [ <index> ] ) 
	IF NOT gotparam no_block 
		Obj_WaitAnimFinished 
	ENDIF 
ENDSCRIPT

SCRIPT ped_play_wave_anim 
	GetTags 
	IF Obj_AnimEquals <Idle> 
		Obj_PlayAnim Anim = <wave> 
		IF NOT gotparam no_block 
			Obj_WaitAnimFinished 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT ped_play_idle_anim 
	GetTags 
	GetArraySize <idleAnims> 
	GetRandomValue name = index integer a = 0 b = ( <array_size> - 1 ) 
	Obj_PlayAnim Anim = ( ( <idleAnims> ) [ <index> ] ) 
	IF NOT gotparam no_block 
		Obj_WaitAnimFinished 
	ENDIF 
ENDSCRIPT

SCRIPT ped_play_disgust_anim 
	GetTags 
	GetArraySize <disgustAnims> 
	GetRandomValue name = index integer a = 0 b = ( <array_size> - 1 ) 
	Obj_PlayAnim Anim = ( ( <disgustAnims> ) [ <index> ] ) 
	IF NOT gotparam no_block 
		Obj_WaitAnimFinished 
	ENDIF 
ENDSCRIPT

SCRIPT ped_play_attack_anim 
	GetTags 
	GetArraySize <attackAnims> 
	GetRandomValue name = index integer a = 0 b = ( <array_size> - 1 ) 
	Obj_PlayAnim Anim = ( ( <attackAnims> ) [ <index> ] ) 
	IF NOT gotparam no_block 
		Obj_WaitAnimFinished 
	ENDIF 
ENDSCRIPT

SCRIPT ped_play_falldown_anim 
	GetTags 
	GetArraySize <fallDownAnims> 
	GetRandomValue name = index integer a = 0 b = ( <array_size> - 1 ) 
	Obj_PlayAnim Anim = ( ( <fallDownAnims> ) [ <index> ] ) 
	SetTags fallDownAnimIndex = <index> 
	IF NOT gotparam no_block 
		Obj_WaitAnimFinished 
	ENDIF 
ENDSCRIPT

SCRIPT ped_play_layidle_anim 
	GetTags 
	IF NOT gotparam fallDownAnimIndex 
		GetArraySize <layIdleAnims> 
		GetRandomValue name = fallDownAnimIndex integer a = 0 b = ( <array_size> - 1 ) 
	ENDIF 
	Obj_PlayAnim Anim = ( ( <layIdleAnims> ) [ <fallDownAnimIndex> ] ) 
	IF NOT gotparam no_block 
		Obj_WaitAnimFinished 
	ENDIF 
ENDSCRIPT

SCRIPT ped_play_getup_anim 
	GetTags 
	IF NOT gotparam fallDownAnimIndex 
		GetArraySize <getupAnims> 
		GetRandomValue name = fallDownAnimIndex integer a = 0 b = ( <array_size> - 1 ) 
	ENDIF 
	Obj_PlayAnim Anim = ( ( <getupAnims> ) [ <fallDownAnimIndex> ] ) 
	IF NOT gotparam no_block 
		Obj_WaitAnimFinished 
	ENDIF 
ENDSCRIPT

SCRIPT ped_play_knockdown_reaction_anim 
	GetTags 
	GetArraySize <knockdownReactionAnims> 
	GetRandomValue name = index integer a = 0 b = ( <array_size> - 1 ) 
	Obj_PlayAnim Anim = ( ( <knockdownReactionAnims> ) [ <index> ] ) 
	IF NOT gotparam no_block 
		Obj_WaitAnimFinished 
	ENDIF 
ENDSCRIPT

SCRIPT ped_initialize_movement 
	GetTags 
	IF ( <is_moving_ped> = 1 ) 
		Obj_SetPathTurnDist 2.50000000000 feet 
		IF gotparam skater 
			IF NOT gotparam speed 
				speed = 25 
			ENDIF 
			Obj_SetPathVelocity <speed> fps 
			Obj_SpawnScript ped_skater_idle 
		ELSE 
			IF NOT gotparam speed 
				speed = RANDOM_RANGE PAIR(5.00000000000, 10.00000000000) 
			ENDIF 
			Obj_SetPathVelocity <speed> fps 
			Obj_PlayAnim Anim = <IdleToWalk> 
			Obj_WaitAnimFinished 
			IF gotparam WalkAnims 
				GetRandomArrayElement <WalkAnims> 
				<walk> = <element> 
				SetTags walk = <walk> 
			ENDIF 
			Obj_PlayAnim Anim = <walk> Cycle UseAnimTags 
			GetTags 
			IF gotparam animTags 
				ped_adjust_speed_to_match_anim <animTags> 
			ENDIF 
		ENDIF 
		IF gotparam PathToFollow 
		ELSE 
		ENDIF 
		IF gotparam PathToFollow 
		ELSE 
		ENDIF 
	ELSE 
		ped_standing_idle 
	ENDIF 
ENDSCRIPT

SCRIPT ped_start_movement 
	GetTags 
	IF ( <is_moving_ped> = 1 ) 
		IF NOT Obj_AnimEquals <walk> 
			Obj_SetAnimCycleMode off 
			Obj_WaitAnimFinished 
			ped_rotate_to_node_from_idle 
			Obj_SetAnimCycleMode off 
			Obj_PlayAnim Anim = <IdleToWalk> 
			Obj_WaitAnimFinished 
		ELSE 
		ENDIF 
		Obj_PlayAnim Anim = <walk> Cycle 
	ELSE 
		Obj_PlayAnim Anim = <Idle> Cycle 
	ENDIF 
ENDSCRIPT

SCRIPT ped_stop_movement 
	GetTags 
	<playing_walk_anim> = 0 
	IF Obj_AnimEquals <walk> 
		<playing_walk_anim> = 1 
	ENDIF 
	IF Obj_AnimEquals <WalkingWave> 
		<playing_walk_anim> = 1 
	ENDIF 
	IF ( <playing_walk_anim> = 1 ) 
		Obj_SetAnimCycleMode off 
		Obj_WaitAnimFinished 
		Obj_PlayAnim Anim = <WalkToIdle> 
		Obj_WaitAnimFinished 
	ENDIF 
ENDSCRIPT

SCRIPT ped_rotate_to_skater_from_idle time = 0.30000001192 
	GetTags 
	IF Obj_AngleToNearestSkaterGreaterThan 15 
		IF Obj_LookAtObject type = skater time = <time> 
			Obj_PlayAnim Anim = <RotateFromIdle1> 
			Obj_WaitRotate 
			Obj_SetAnimCycleMode off 
			Obj_WaitAnimFinished 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT ped_rotate_to_node_from_idle time = 0.30000001192 
	GetTags 
	IF Obj_LookAtNodeLinked time = <time> 
		Obj_PlayAnim Anim = <RotateFromIdle1> 
		Obj_WaitRotate 
		Obj_SetAnimCycleMode off 
		Obj_WaitAnimFinished 
	ENDIF 
ENDSCRIPT

SCRIPT ped_in_front_of_skater 
	<retVal> = 0 
	Obj_GetOrientationToObject skater 
	IF ( <dotProd> < 0.50000000000 ) 
		IF ( <dotProd> > -0.50000000000 ) 
			<retVal> = 1 
		ENDIF 
	ENDIF 
	RETURN in_front = <retVal> 
ENDSCRIPT

SCRIPT ped_pass_ped 
	Obj_StopAlongPath 
	Ped_SetLogicState pass_ped 
ENDSCRIPT

SCRIPT ped_pass_ped_finish 
	Ped_SetLogicState Idle 
	Obj_SetPathVelocity <vel> ips 
	Obj_StartAlongPath 
	Obj_SetPathAcceleration 10000 
	Obj_StoreNode 
	Obj_FollowPathStored 
ENDSCRIPT

SCRIPT ped_wait_to_pass_ped 
	Ped_SetLogicState waiting_to_pass_ped 
	Obj_SetPathDeceleration 100 
	Obj_SetPathVelocity <lead_ped_vel> ips 
ENDSCRIPT


