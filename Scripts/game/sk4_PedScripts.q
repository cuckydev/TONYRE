
SCRIPT Ped_SetDefaults 
	SetTags collision_mode = ignore 
	SetTags talking_mode = friendly 
	SetTags is_moving_ped = 1 
	SetTags is_goal_ped = 0 
	SetTags talking_radius = 30 
	SetTags collision_exception_return_state = Ped_IdleState 
	SetTags pissed = 0 
	SetTags should_look_at_skater = 1 
	IF GotParam skater 
		pedanim_init default_male_skater_anim_assets <...> 
		IF NOT GotParam brake_idle_anims 
			SetTags brake_idle_anims = ped_skater_brake_idle_anims 
		ENDIF 
	ELSE 
		IF GotParam chick 
			<anim_assets> = default_female_anim_assets 
			<standing_anims> = female_goal_wait 
		ELSE 
			<anim_assets> = default_male_anim_assets 
			<standing_anims> = generic_ped_anims_wait 
		ENDIF 
		IF GotParam stand 
			pedanim_init <anim_assets> standing_anims = <standing_anims> <...> 
			SetTags collision_exception_return_state = ped_standing_idle 
		ELSE 
			pedanim_init <anim_assets> <...> 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT CPF_PedGeneric 
	printf "Please rename all instances of \'CPF_PedGeneric\' to \'Ped_InitAI\'" 
	Ped_InitAI <...> 
ENDSCRIPT

SCRIPT Ped_InitAI 
	SK4_PedScript <...> 
ENDSCRIPT

SCRIPT SK4_PedScript 
	Ped_SetDefaults <...> 
	SetTags <...> 
	IF GotParam Avoid 
		SetTags collision_mode = Avoid 
	ENDIF 
	IF GotParam Fall 
		SetTags collision_mode = Fall 
	ENDIF 
	IF GotParam shot 
		SetTags collision_mode = shot 
	ENDIF 
	IF GotParam Knock 
		SetTags collision_mode = Knock 
	ENDIF 
	IF GotParam bump 
		SetTags collision_mode = bump 
	ENDIF 
	IF GotParam ignore 
		SetTags collision_mode = ignore 
	ENDIF 
	IF GotParam friendly 
		SetTags talking_mode = friendly 
	ENDIF 
	IF GotParam Mean 
		SetTags talking_mode = Mean 
	ENDIF 
	IF GotParam chick 
		pedanim_init default_female_anim_assets 
	ENDIF 
	IF GotParam NoMove 
		SetTags is_moving_ped = 0 
	ENDIF 
	IF GotParam GoalPed 
		SetTags is_goal_ped = 1 
	ENDIF 
	IF GotParam stand 
		SetTags is_standing_ped = 1 
		SetTags is_moving_ped = 0 
	ENDIF 
	ped_initialize_collision_exceptions 
	Obj_StickToGround distAbove = 3 distBelow = 6 
	Obj_StickToGround off 
	ped_initialize_movement <...> 
	IF NOT GotParam stand 
		Ped_InitPath 
		SetTags collision_exception_return_state = ped_walker_get_up 
	ENDIF 
	IF GotParam skater 
		Ped_SetIsSkater 1 
		Ped_SetLogicState generic_skater 
	ELSE 
		IF GotParam stand 
			Ped_SetLogicState generic_standing 
			ped_standing_idle 
		ELSE 
			Ped_SetLogicState generic 
			goto Ped_IdleState 
		ENDIF 
	ENDIF 
ENDSCRIPT


