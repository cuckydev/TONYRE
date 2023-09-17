
bmx_collision_details = { 
	Position = VECTOR(0, 0, 0) 
	Angles = VECTOR(0, 0, 0) 
	Name = Bmx_Collision 
	Class = GameObject 
	Type = Ghost 
	CollisionMode = None 
	IgnoredLights = [ 0 , 1 ] 
	Model = "none" 
	SuspendDistance = 0 
	lod_dist1 = 400 
	lod_dist2 = 401 
	TriggerScript = Bmx_Collision_Script 
} 
Saw_Ghost_details = { 
	Position = VECTOR(0, 0, 0) 
	Angles = VECTOR(0, 0, 0) 
	Name = Saw_Ghost 
	Class = GameObject 
	Type = Ghost 
	CollisionMode = None 
	IgnoredLights = [ 0 , 1 ] 
	Model = "none" 
	SuspendDistance = 0 
	lod_dist1 = 400 
	lod_dist2 = 401 
} 
Saw_Ghost2_details = { 
	Position = VECTOR(0, 0, 0) 
	Angles = VECTOR(0, 0, 0) 
	Name = Saw_Ghost2 
	Class = GameObject 
	Type = Ghost 
	CollisionMode = None 
	IgnoredLights = [ 0 , 1 ] 
	Model = "none" 
	SuspendDistance = 0 
	lod_dist1 = 400 
	lod_dist2 = 401 
} 
SCRIPT Bmx_Collision_Script 
	Obj_ClearExceptions 
	Obj_SetInnerRadius 2 
	Obj_SetException ex = SkaterInRadius scr = Bmx_Collision_Collide 
	BEGIN 
		Obj_GetSpeed 
		IF ( <speed> = 0 ) 
		ELSE 
			IF ( <speed> < 29.89999961853 ) 
				SendFlag FLAG_TRICK_NOW Name = TRG_BMX_Checker 
			ELSE 
				ClearFlag FLAG_TRICK_NOW Name = TRG_BMX_Checker 
			ENDIF 
		ENDIF 
		wait 3 frames 
	REPEAT 
ENDSCRIPT

SCRIPT Bmx_Collision_Collide 
	Obj_ClearExceptions 
	Obj_SetOuterRadius 5 
	Obj_SetException ex = SkaterOutOfRadius scr = Bmx_Collision_Script 
	printf "Bail now Bitch" 
	Obj_PlayStream RANDOM(1, 1, 1, 1, 1, 1, 1, 1) 
		RANDOMCASE rick_Collide01 
		RANDOMCASE rick_Collide02 
		RANDOMCASE rick_Collide03 
		RANDOMCASE rick_Collide04 
		RANDOMCASE rick_Collide05 
		RANDOMCASE rick_Collide06 
		RANDOMCASE rick_Collide07 
		RANDOMCASE rick_Collide08 
	RANDOMEND 
	MakeSkaterGoto PedKnockDown 
ENDSCRIPT


