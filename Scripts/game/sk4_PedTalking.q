
SCRIPT Ped_IdleState 
	GetTags 
	ped_start_movement 
	Ped_SetLogicState generic 
ENDSCRIPT

SCRIPT Ped_ReactionState 
	Ped_SetLogicState none 
	GetTags 
	SWITCH <talking_mode> 
		CASE friendly 
			<should_wave> = 1 
			<should_stop> = 0 
		DEFAULT 
			<should_wave> = 0 
			<should_stop> = 1 
	ENDSWITCH 
	IF ( <should_stop> = 1 ) 
		ped_stop_movement 
	ENDIF 
	BEGIN 
		IF ( <is_moving_ped> = 1 ) 
			IF ( <should_wave> = 1 ) 
				ped_walking_wave 
			ELSE 
				ped_wave 
			ENDIF 
		ELSE 
			ped_wave 
		ENDIF 
		Obj_GetDistanceToObject Skater 
		IF ( <objectDistance> > <talking_radius> ) 
			goto Ped_IdleState 
		ENDIF 
		wait 1 gameframe 
	REPEAT 
ENDSCRIPT

SCRIPT ped_walking_wave 
	GetTags 
	ped_in_front_of_skater 
	IF ( <in_front> ) 
		RANDOM(1, 1, 1, 1, 1) 
			RANDOMCASE Obj_PlayAnim Anim = <WalkingWave> 
			RANDOMCASE Obj_PlayAnim Anim = <Walk> 
			RANDOMCASE Obj_PlayAnim Anim = <Walk> 
			RANDOMCASE Obj_PlayAnim Anim = <Walk> 
			RANDOMCASE Obj_PlayAnim Anim = <Walk> 
		RANDOMEND 
	ELSE 
		Obj_PlayAnim Anim = <Walk> 
	ENDIF 
	Obj_WaitAnimFinished 
ENDSCRIPT

SCRIPT ped_wave 
	GetTags 
	ped_rotate_to_skater_from_idle 
	SWITCH <talking_mode> 
		CASE friendly 
			Obj_PlayAnim Anim = <Wave> 
			Obj_WaitAnimFinished 
		CASE mean 
			ped_play_disgust_anim 
	ENDSWITCH 
ENDSCRIPT


