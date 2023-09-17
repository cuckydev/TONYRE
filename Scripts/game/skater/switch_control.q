
SwitchControl_Trigger = { Trigger = { PressTwoAnyOrder , L1 , R1 , 400 } Xbox_Trigger = { Press , Black , 10 } NGC_Trigger = { Press , Z , 10 } Alt_Trigger = { Press , White , 10 } } 
CAVEMAN_SCORE = 750 
COMBO_RUNOUT_SCORE = 50 
CavemanBailDuration = 0.30000001192 
RunOutTrickDelay = 0.75000000000 
SCRIPT RunTimerController_Reset 
	RunTimer_GetRunTimerControllerId 
	Obj_KillSpawnedScript Id = <RunTimerControllerId> 
	Obj_SpawnScript RunTimerController_Start Id = <RunTimerControllerId> PauseWithObject 
	RunTimer_GetRunTimerId 
	Obj_KillSpawnedScript Id = ( <RunTimerId> + 2 ) 
	hide_run_timer Id = <RunTimerId> 
ENDSCRIPT

SCRIPT RunTimerController_Start 
	ClearExceptionGroup RunTimeController 
	SetExceptionHandler Ex = ShowRunTimer Scr = RunTimerController_Displayed Group = RunTimeController 
	Block 
ENDSCRIPT

SCRIPT RunTimerController_Displayed 
	ClearExceptionGroup RunTimeController 
	SetExceptionHandler Ex = HideRunTimer Scr = RunTimerController_Hidden Group = RunTimeController 
	RunTimer_GetRunTimerId 
	FadingSpawned = 0 
	SoundCounter = 0 
	SoundWait = 4 
	SoundType = 0 
	RunTimer_GetFactorComplete 
	RotationAngle = ( 360 * <FactorComplete> ) 
	show_run_timer Id = <RunTimerId> rot_angle = <RotationAngle> 
	BEGIN 
		DoScreenElementMorph Id = { <RunTimerId> child = 0 } rot_angle = ( 180 - <RotationAngle> ) 
		hide_run_timer_piece Id = <RunTimerId> rot_angle = <RotationAngle> 
		IF ( <FadingSpawned> = 0 ) 
			IF ( <RotationAngle> < 140 ) 
				Obj_SpawnScript blink_run_timer Id = ( <RunTimerId> + 2 ) Params = { Id = <RunTimerId> } PauseWithObject 
				FadingSpawned = 1 
			ENDIF 
		ENDIF 
		IF ( <SoundCounter> > <SoundWait> ) 
			IF ( <SoundType> = 0 ) 
				IF NOT GetGlobalFlag flag = SOUNDS_SPECIALSOUNDS_OFF 
					PlaySound ClockTickDown 
				ENDIF 
				SoundType = 1 
			ELSE 
				IF NOT GetGlobalFlag flag = SOUNDS_SPECIALSOUNDS_OFF 
					PlaySound ClockTickUp vol = 150 
				ENDIF 
				SoundType = 0 
			ENDIF 
			SoundCounter = 0 
		ELSE 
			SoundCounter = ( <SoundCounter> + 1 ) 
		ENDIF 
		IF ( <RotationAngle> < 270 ) 
			IF ( <RotationAngle> < 180 ) 
				IF ( <RotationAngle> < 90 ) 
					SoundWait = 1 
				ELSE 
					SoundWait = 2 
				ENDIF 
			ELSE 
				SoundWait = 3 
			ENDIF 
		ENDIF 
		Wait 1 GameFrame 
		RunTimer_GetFactorComplete 
		RotationAngle = ( 360 * <FactorComplete> ) 
	REPEAT 
ENDSCRIPT

SCRIPT RunTimerController_Hidden 
	ClearExceptionGroup RunTimeController 
	SetExceptionHandler Ex = ShowRunTimer Scr = RunTimerController_Displayed Group = RunTimeController 
	RunTimer_GetRunTimerId 
	Obj_KillSpawnedScript Id = ( <RunTimerId> + 2 ) 
	soft_hide_run_timer Id = <RunTimerId> 
	Block 
ENDSCRIPT

SCRIPT CleanUp_WalkingtoSkating 
	AllowRailTricks 
	GetTags 
	IF NOT GotParam AnimTags 
		SkaterLoopingSound_TurnOn 
	ELSE 
		IF NOT StructureContains WalkToSkateTransition Structure = <AnimTags> 
			SkaterLoopingSound_TurnOn 
		ENDIF 
	ENDIF 
	SetException Ex = PointRail Scr = PointRailWalkingToSkating 
	SwitchToSkatingPhysics 
	IF InAir 
		SetQueueTricks NoTricks 
		InAirExceptions NoSkateToWalkTricks 
	ELSE 
		OnGroundExceptions 
	ENDIF 
ENDSCRIPT

SCRIPT PointRailWalkingToSkating 
	SetQueueTricks NoTricks 
	Goto PointRail 
ENDSCRIPT

SCRIPT Switch_OnGroundAI newscript = land 
	UnPausePhysics 
	Unhide 
	ClearExceptions 
	ClearTrickQueues 
	StopBalanceTrick 
	NotInBail 
	IF Driving 
		ToggleUserControlledVehicleMode 
	ENDIF 
	SWITCH <newscript> 
		CASE OnGroundAi 
			SetRollingFriction default 
			DestroyAllSpecialItems 
			SwitchOnBoard 
			CleanUp_WalkingtoSkating 
			IF InAir 
				Goto Airborne 
			ELSE 
				Goto OnGroundAi 
			ENDIF 
		CASE Walking_onGroundAi 
			DestroyAllSpecialItems 
			SwitchOnBoard 
			SwitchToWalkingPhysics 
			AllowRailTricks 
			IF GotParam Restart 
				Goto JustStoppedSkatingState Params = { Restart } 
			ELSE 
				Goto JustStoppedSkatingState 
			ENDIF 
		CASE TransAm 
			Goto ToggleUserControlledVehicleMode Params = { <...> } 
		DEFAULT 
			ScriptAssert "Bad NewScript passed to Switch_OnGroundAi" 
	ENDSWITCH 
ENDSCRIPT

SCRIPT CheckforSwitchVehicles newscript = OnGroundAi 
	IF Walking 
		Goto Switch_OnGroundAI Params = { newscript = OnGroundAi } 
	ELSE 
		Goto Switch_OnGroundAI Params = { newscript = Walking_onGroundAi } 
	ENDIF 
ENDSCRIPT


