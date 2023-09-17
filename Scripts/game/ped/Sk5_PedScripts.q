
ped_walker_idle_states = [ "BHP" , "RHP" , "BAX" , "LGH" ] 
ped_walker_deceleration = 1 
ped_walker_min_square_distance_to_dead_end = 1000 
ped_max_y_distance_to_ignore = 36 
SCRIPT ped_walker_stop 
	Obj_SetPathMinStopVel 1 
	Obj_SetPathDeceleration ped_walker_deceleration 
	Obj_StopAlongPath 
	Obj_WaitStop 
	Ped_StopMoving 
ENDSCRIPT

SCRIPT ped_walker_switch_idle_state 
	GetTags 
	GetRandomArrayElement ped_walker_idle_states 
	<new_state> = <element> 
	IF GotParam obj_idle_state 
		IF NOT ( <new_state> = <obj_idle_state> ) 
			FormatText ChecksumName = transition_anim "%f_2_%t" f = <obj_idle_state> t = <new_state> 
			PlayAnimWithPartialAnimIfExists anim = <transition_anim> 
			Obj_WaitAnimFinished 
		ENDIF 
	ENDIF 
	SetTags obj_idle_state = <new_state> 
	SWITCH <new_state> 
		CASE "BHP" 
			ped_walker_bhp 
		CASE "RHP" 
			ped_walker_rhp 
		CASE "BAX" 
			ped_walker_bax 
		CASE "LGH" 
			ped_walker_lgh 
		DEFAULT 
			script_assert "Found unknown ped walker state" 
	ENDSWITCH 
ENDSCRIPT

SCRIPT ped_walker_get_up 
	Ped_SetLogicState generic 
	GetTags 
	PlayAnimWithPartialAnimIfExists anim = <Walk> Cycle UseAnimTags 
	IF GotParam animTags 
		ped_adjust_speed_to_match_anim <animTags> 
	ENDIF 
	Ped_StartMoving 
ENDSCRIPT

SCRIPT ped_walker_hit_dead_end 
	Ped_StopMoving 
	PlayAnimWithPartialAnimIfExists anim = Ped_M_LookAtWatch 
	Obj_WaitAnimFinished 
	Ped_GetCurrentNodeNames 
	ped_standing_look_at_skater node_name = <node_to> 
	GetTags 
	PlayAnimWithPartialAnimIfExists anim = <Walk> Cycle UseAnimTags 
	GetTags 
	IF GotParam animTags 
		ped_adjust_speed_to_match_anim <animTags> 
	ENDIF 
	Ped_StartMoving 
ENDSCRIPT

SCRIPT ped_walker_bhp 
	RANDOM(1, 1, 1, 1, 1) RANDOMCASE Obj_CycleAnim anim = BHP_Breathe 
		RANDOMCASE Obj_CycleAnim anim = BHP_Breathe NumCycles = RANDOM(1, 1) RANDOMCASE 1 RANDOMCASE 2 RANDOMEND 
		RANDOMCASE Obj_CycleAnim anim = BHP_Scratch 
		RANDOMCASE Obj_CycleAnim anim = BHP_Point 
		RANDOMCASE Obj_CycleAnim anim = BHP_LookBack 
	RANDOMEND 
ENDSCRIPT

SCRIPT ped_walker_rhp 
	RANDOM(1, 1, 1, 1) RANDOMCASE Obj_CycleAnim anim = RHP_Breathe NumCycles = RANDOM(1, 1) RANDOMCASE 1 RANDOMCASE 2 RANDOMEND 
		RANDOMCASE OBJ_Playstream KenHelp1 
		Obj_CycleAnim anim = RHP_TalkTest 
		RANDOMCASE Obj_CycleAnim anim = RHP_FootTap NumCycles = RANDOM(1, 1, 1) RANDOMCASE 1 RANDOMCASE 2 RANDOMCASE 3 RANDOMEND 
		RANDOMCASE Obj_CycleAnim anim = RHP_Handsmack 
	RANDOMEND 
ENDSCRIPT

SCRIPT ped_walker_bax 
	RANDOM(1, 1) RANDOMCASE Obj_CycleAnim anim = BAX_Breathe NumCycles = RANDOM(1, 1) RANDOMCASE 1 RANDOMCASE 2 RANDOMEND 
		RANDOMCASE Obj_CycleAnim anim = BAX_Nod NumCycles = RANDOM(1, 1) RANDOMCASE 1 RANDOMCASE 2 RANDOMEND 
	RANDOMEND 
ENDSCRIPT

SCRIPT ped_walker_lgh 
	RANDOM(1, 1, 1, 1, 1, 1) RANDOMCASE Obj_CycleAnim anim = LGH_GutBuster NumCycles = RANDOM(1, 1) RANDOMCASE 1 RANDOMCASE 2 RANDOMEND 
		RANDOMCASE Obj_CycleAnim anim = LGH_KneeSlapper speed = 0.75000000000 
		Obj_CycleAnim anim = LGH_GutBuster 
		RANDOMCASE Obj_CycleAnim anim = LGH_Pointing 
		Obj_CycleAnim anim = LGH_GutBuster 
		RANDOMCASE Obj_CycleAnim anim = LGH_Giggle 
		Obj_CycleAnim anim = LGH_GutBuster 
		RANDOMCASE Obj_CycleAnim anim = LGH_Wave 
		Obj_CycleAnim anim = LGH_GutBuster 
		RANDOMCASE Obj_CycleAnim anim = LGH_Wave 
		Obj_CycleAnim anim = LGH_GutBuster 
	RANDOMEND 
ENDSCRIPT

SCRIPT ped_standing_idle 
	GetTags 
	BEGIN 
		IF GotParam standing_anims 
			GetArraySize <standing_anims> 
			CreateIndexArray <array_size> 
			PermuteArray NewArrayName = random_index_array Array = <index_array> 
			BEGIN 
				IF GetNextArrayElement <random_index_array> index = <index> 
					IF NOT ( <should_look_at_skater> = 0 ) 
						ped_standing_look_at_skater 
					ENDIF 
					ped_standing_play_anim_set ( <standing_anims> [ <element> ] ) 
				ELSE 
					RemoveParameter index 
					BREAK 
				ENDIF 
				wait 1 frame 
			REPEAT 
			wait 30 frame 
		ENDIF 
	REPEAT 
ENDSCRIPT

SCRIPT ped_standing_look_at_node 
	<time_to_rotate> = 1 
	GetTags 
	Obj_StopRotating 
	IF GotParam turning_anims 
		IF StructureContains structure = <turning_anims> pre_rotate 
			<pre_rotate> = ( <turning_anims> . pre_rotate ) 
		ENDIF 
		IF StructureContains structure = <turning_anims> rotate_anim 
			<rotate_anim> = ( <turning_anims> . rotate_anim ) 
		ENDIF 
		IF StructureContains structure = <turning_anims> post_rotate 
			<post_rotate> = ( <turning_anims> . post_rotate ) 
		ENDIF 
	ENDIF 
	IF NOT GotParam rotate_anim 
		IF GotParam chick 
			<rotate_anim> = Ped_F_RotateLFromIdle1 
		ELSE 
			<rotate_anim> = Ped_M_Idle1TurnL 
		ENDIF 
	ENDIF 
	IF GotParam pre_rotate 
		PlayAnimWithPartialAnimIfExists anim = <pre_rotate> 
		Obj_WaitAnimFinished 
	ENDIF 
	Obj_LookAtNode name = <node_name> time = <time_to_rotate> 
	PlayAnimWithPartialAnimIfExists anim = <rotate_anim> 
	wait <time_to_rotate> seconds 
	IF GotParam post_rotate 
		PlayAnimWithPartialAnimIfExists anim = <post_rotate> 
		Obj_WaitAnimFinished 
	ENDIF 
ENDSCRIPT

SCRIPT ped_standing_look_at_skater 
	<time_to_rotate> = 1 
	GetTags 
	Obj_StopRotating 
	IF Obj_AngleToNearestSkaterGreaterThan 15 
		IF GotParam turning_anims 
			IF StructureContains structure = <turning_anims> pre_rotate 
				<pre_rotate> = ( <turning_anims> . pre_rotate ) 
			ENDIF 
			IF StructureContains structure = <turning_anims> rotate_anim 
				<rotate_anim> = ( <turning_anims> . rotate_anim ) 
			ENDIF 
			IF StructureContains structure = <turning_anims> post_rotate 
				<post_rotate> = ( <turning_anims> . post_rotate ) 
			ENDIF 
		ENDIF 
		IF NOT GotParam rotate_anim 
			IF GotParam chick 
				<rotate_anim> = Ped_F_RotateLFromIdle1 
			ELSE 
				<rotate_anim> = Ped_M_Idle1TurnL 
			ENDIF 
		ENDIF 
		IF GotParam pre_rotate 
			PlayAnimWithPartialAnimIfExists anim = <pre_rotate> 
			Obj_WaitAnimFinished 
		ENDIF 
		Obj_LookAtObject type = skater time = <time_to_rotate> 
		PlayAnimWithPartialAnimIfExists anim = <rotate_anim> 
		wait <time_to_rotate> seconds 
		IF GotParam post_rotate 
			PlayAnimWithPartialAnimIfExists anim = <post_rotate> 
			Obj_WaitAnimFinished 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT ped_standing_play_anim_set 
	BEGIN 
		IF GetNextArrayElement <anims> index = <index> 
			IF StructureContains structure = <element> ped_speed 
				Obj_SetPathVelocity ( <element> . ped_speed ) fps 
			ENDIF 
			IF StructureContains structure = <element> speed 
				<speed> = ( <element> . speed ) 
			ELSE 
				IF StructureContains structure = <element> random_speed_high 
					IF StructureContains structure = <element> random_speed_low 
						GetRandomValue { 
							name = speed 
							resolution = 0.10000000149 
							a = ( <element> . random_speed_low ) 
							b = ( <element> . random_speed_high ) 
						} 
					ENDIF 
				ENDIF 
			ENDIF 
			IF StructureContains structure = <element> flip 
				Obj_flip 
			ENDIF 
			IF StructureContains structure = <element> anim 
				PlayAnimWithPartialAnimIfExists <element> speed = <speed> UseAnimTags 
				GetTags 
				IF GotParam animTags 
					ped_adjust_speed_to_match_anim <animTags> 
				ENDIF 
				IF StructureContains structure = <element> script_name 
					ped_run_script <element> 
				ENDIF 
			ELSE 
				IF StructureContains structure = <element> script_name 
					ped_run_script <element> 
				ELSE 
					PlayAnimWithPartialAnimIfExists anim = <element> speed = <speed> UseAnimTags 
					GetTags 
					IF GotParam animTags 
						ped_adjust_speed_to_match_anim <animTags> 
					ENDIF 
				ENDIF 
			ENDIF 
			Obj_WaitAnimFinished 
		ELSE 
			RETURN 
		ENDIF 
		wait 1 frame 
	REPEAT 
ENDSCRIPT

SCRIPT ped_run_script 
	<script_name> <script_params> 
ENDSCRIPT

SCRIPT ped_adjust_speed_to_match_anim 
	IF GotParam movementSpeed 
		Obj_SetPathVelocity <movementSpeed> ips 
	ENDIF 
ENDSCRIPT

SCRIPT invalidate_anim_cache 
	RunScriptOnComponentType component = animation target = InvalidateCache params = { } 
ENDSCRIPT


