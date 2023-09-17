SCRIPT ALF_Placeholder 
ENDSCRIPT

SCRIPT ALF_Ped_Generic 
	Obj_ClearExceptions 
	Obj_SetException ex = SkaterInRadius scr = ALF_Ped_BailWhenSkaterClose 
	Obj_SetInnerRadius 5 
	wait RANDOM(1, 1, 1) RANDOMCASE 5 frames RANDOMCASE 10 frames RANDOMCASE 15 frames RANDOMEND 
	BEGIN 
		Obj_CycleAnim anim = Ped_M_Idle1 numcycles = RANDOM(1, 1, 1, 1) RANDOMCASE 2 RANDOMCASE 4 RANDOMCASE 7 RANDOMCASE 9 RANDOMEND 
		Obj_CycleAnim anim = Ped_M_Idle1toIdle2 
		Obj_CycleAnim anim = Ped_M_Idle2 numcycles = RANDOM(1, 1, 1) RANDOMCASE 1 RANDOMCASE 2 RANDOMCASE 3 RANDOMEND 
		Obj_CycleAnim anim = Ped_M_Idle2toIdle3 
		Obj_CycleAnim anim = Ped_M_Idle3 numcycles = RANDOM(1, 1, 1) RANDOMCASE 1 RANDOMCASE 2 RANDOMCASE 3 RANDOMEND 
		Obj_CycleAnim anim = Ped_M_Idle3toIdle1 
	REPEAT 
ENDSCRIPT

SCRIPT ALF_Ped_BailWhenSkaterClose 
	Obj_ClearExceptions 
	RANDOM(1, 1, 1, 1, 1) 
		RANDOMCASE Obj_CycleAnim anim = Ped_M_FalldownA 
		Obj_PlayAnim anim = Ped_M_LayIdleA cycle 
		SetTags Bail = A 
		RANDOMCASE Obj_CycleAnim anim = Ped_M_FalldownB 
		Obj_PlayAnim anim = Ped_M_LayIdleB cycle 
		SetTags Bail = B 
		RANDOMCASE Obj_CycleAnim anim = Ped_M_FalldownC 
		Obj_PlayAnim anim = Ped_M_LayIdleC cycle 
		SetTags Bail = C 
		RANDOMCASE Obj_CycleAnim anim = Ped_M_FalldownD 
		Obj_PlayAnim anim = Ped_M_LayIdleD cycle 
		SetTags Bail = D 
		RANDOMCASE Obj_CycleAnim anim = Ped_M_FalldownE 
		Obj_PlayAnim anim = Ped_M_LayIdleE cycle 
	SetTags Bail = E RANDOMEND 
	Obj_SetException ex = SkaterOutOfRadius scr = ALF_Ped_GetUpFromBail 
	Obj_SetOuterRadius 10 
ENDSCRIPT

SCRIPT ALF_Ped_GetUpFromBail 
	Obj_ClearExceptions 
	GetTags 
	Obj_SetAnimCycleMode Off 
	Obj_WaitAnimFinished 
	SWITCH <Bail> 
		CASE A 
			Obj_CycleAnim anim = Ped_M_GetUpA 
		CASE B 
			Obj_CycleAnim anim = Ped_M_GetUpB 
		CASE C 
			Obj_CycleAnim anim = Ped_M_GetUpC 
		CASE D 
			Obj_CycleAnim anim = Ped_M_GetUpD 
		CASE E 
			Obj_CycleAnim anim = Ped_M_GetUpE 
		DEFAULT 
	ENDSWITCH 
	goto ALF_Ped_Generic 
ENDSCRIPT


