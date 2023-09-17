
SCRIPT SwitchToWalkingPhysics 
	BroadcastEvent Type = SkaterExitSkating 
	ClearTrickQueues 
	SkaterPhysicsControl_SwitchSkatingToWalking 
	SkaterLoopingSound_TurnOff 
	EnableInputEvents 
	BroadcastEvent Type = SkaterEnterWalking 
	KillExtraTricks 
	PressureOff 
	NollieOff 
	SetTrickName #"" 
	SetTrickScore 0 
	Display Blockspin 
ENDSCRIPT

SCRIPT SwitchToSkatingPhysics 
	BroadcastEvent Type = SkaterExitWalking 
	ClearAllWalkingExceptions 
	ClearTrickQueue 
	DisableInputEvents 
	Obj_KillSpawnedScript Id = ComboRunOutTrickDisplayDelay 
	Obj_KillSpawnedScript Id = ActivateGroundTricksDelay 
	SetProps remove_tags = [ WalkingGroundTricksInactive ] 
	SetTrickName #"" 
	SetTrickScore 0 
	Display Blockspin 
	RunTimer_Pause 
	SkaterPhysicsControl_SwitchWalkingToSkating 
	BroadcastEvent Type = SkaterEnterSkating 
ENDSCRIPT

WalkGroundTricks = [ 
	{ SwitchControl_Trigger Scr = WalkingRunToSkating } 
] 
WalkAirTricks = [ 
	{ SwitchControl_Trigger Scr = WalkingAirToSkating } 
] 
SCRIPT BeginWalkingGenericTrick 
	CleanUp_WalkingtoSkating 
	IF NOT OnGround 
		PerhapsAwardCaveman 
	ENDIF 
ENDSCRIPT

SCRIPT BeginWalkingManualTrick 
	Walk_ScaleAnimSpeed Off 
	CleanUp_WalkingtoSkating 
	PerhapsAwardCaveman 
ENDSCRIPT

SCRIPT WalkingToRailTrick 
	Walk_ScaleAnimSpeed Off 
	PlayAnim Anim = JumpAirTo5050 From = 0 To = 0.30000001192 Seconds 
	PerhapsAwardCaveman HaveNotSwitchedPhysicsStatesYet 
	CleanUp_WalkingtoSkating 
ENDSCRIPT

SCRIPT WalkingAirToTransitionTrick 
	Walk_ScaleAnimSpeed Off 
	PlayAnim Anim = JumpAirToAirIdle 
	CleanUp_WalkingtoSkating 
	WaitAnimWhilstChecking 
	Goto Airborne Params = { NoSkateToWalkTricks } 
ENDSCRIPT

SCRIPT WalkingRunToSkating 
	SkaterLoopingSound_TurnOff 
	IF ( inNetGame ) 
		IF NOT GetGlobalFlag flag = FLAG_G_EXPERT_MODE_NO_WALKING 
			IF NOT GetGlobalFlag flag = FLAG_EXPERT_MODE_NO_WALKING 
				SetQueueTricks Jumptricks WalkToSkateTransition_GroundTricks SkateToWalkTricks 
			ELSE 
				SetQueueTricks Jumptricks WalkToSkateTransition_GroundTricks 
			ENDIF 
		ELSE 
			SetQueueTricks Jumptricks WalkToSkateTransition_GroundTricks 
		ENDIF 
	ELSE 
		IF NOT GetGlobalFlag flag = FLAG_EXPERT_MODE_NO_WALKING 
			SetQueueTricks Jumptricks WalkToSkateTransition_GroundTricks SkateToWalkTricks 
		ELSE 
			SetQueueTricks Jumptricks WalkToSkateTransition_GroundTricks 
		ENDIF 
	ENDIF 
	IF AnimEquals [ SkateToWalk WSkateToRun SlowSkateToStand BrakeToStand ] 
		PlayAnim Anim = WRunToSkate SyncToReversePreviousAnim EffectivePreviousAnimDuration = 0.50000000000 
	ELSE 
		PlayAnim Anim = WRunToSkate 
	ENDIF 
	SetEventHandler Ex = FlailHitWall Scr = FlailVibrate 
	SetEventHandler Ex = FlailLeft Scr = FlailVibrate 
	SetEventHandler Ex = FlailRight Scr = FlailVibrate 
	ClearException RunHasEnded 
	ClearException GoalHasEnded 
	ClearException Ollied 
	Wait CavemanBailDuration Seconds 
	SetException Ex = Ollied Scr = Ollie Params = { OutAnim = JumpAirToAirIdle SyncOutAnimToPreviousAnim } 
	WaitAnimWhilstChecking AndManuals 
	LandSkaterTricks 
	Goto OnGroundAi 
ENDSCRIPT

SCRIPT WalkToSkateTransition_ToggleStance 
	ApplyStanceToggle 
	WaitAnimWhilstChecking AndManuals 
	LandSkaterTricks 
	Goto OnGroundAi 
ENDSCRIPT

SCRIPT WalkingAirToSkating 
	SkaterLoopingSound_TurnOff 
	Walk_ScaleAnimSpeed Off 
	PlayAnim Anim = JumpAirToAirIdle 
	Wait CavemanBailDuration Seconds 
	WaitAnimWhilstChecking 
	Goto Airborne Params = { NoSkateToWalkTricks } 
ENDSCRIPT

SCRIPT ComboRunOutTrickDisplayDelay 
	Obj_GetId 
	SetEventHandler Ex = SkaterExitCombo Scr = FilterSkaterExitComboEvent Params = { ThisSkaterId = <ObjId> } 
	Wait RunoutTrickDelay Seconds 
	SetTrickName #"Combo Run Out" 
	SetTrickScore COMBO_RUNOUT_SCORE 
	Display Blockspin 
ENDSCRIPT

SCRIPT FilterSkaterExitComboEvent 
	IF ( <SkaterId> = <ThisSkaterId> ) 
		Goto NullScript 
	ENDIF 
ENDSCRIPT

SCRIPT PerhapsAwardCaveman 
	IF NOT GotParam HaveNotSwitchedPhysicsStatesYet 
		GetPreviousPhysicsStateDuration 
		IF ( <PreviousPhysicsStateDuration> > RunoutTrickDelay ) 
			SetTrickName #"Caveman" 
			SetTrickScore CAVEMAN_SCORE 
			Display 
		ENDIF 
	ELSE 
		GetTimeSincePhysicsSwitch 
		IF ( <TimeSincePhysicsSwitch> > RunoutTrickDelay ) 
			SetTrickName #"Caveman" 
			SetTrickScore CAVEMAN_SCORE 
			Display 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT ActivateGroundTricksDelay 
	Wait CavemanBailDuration Seconds 
	SetProps remove_tags = [ WalkingGroundTricksInactive ] 
	IF Walk_Ground 
		SetWalkingGroundTricks 
	ENDIF 
ENDSCRIPT

SCRIPT SetWalkingGroundTricks 
	IF NOT IsBoardMissing 
		GetTags 
		IF NOT GotParam WalkingGroundTricksInactive 
			SetQueueTricks WalkGroundTricks 
		ELSE 
			SetQueueTricks NoTricks 
		ENDIF 
	ELSE 
		SetQueueTricks NoTricks 
	ENDIF 
	SetExtraGrindTricks NoTricks 
	SetManualTricks NoTricks 
ENDSCRIPT

SCRIPT SetWalkingAirTricks 
	IF NOT IsBoardMissing 
		SetQueueTricks special = SpecialTricks AirTricks WalkAirTricks 
		SetExtraGrindTricks special = SpecialGrindTricks GrindTricks 
		IF NOT GetGlobalFlag flag = FLAG_EXPERT_MODE_NO_MANUALS 
			IF NOT ( ( inNetGame ) & ( GetGlobalFlag flag = FLAG_G_EXPERT_MODE_NO_MANUALS ) ) 
				SetManualTricks special = SpecialManualTricks GroundManualTricks 
			ELSE 
				SetManualTricks NoTricks 
			ENDIF 
		ELSE 
			SetManualTricks NoTricks 
		ENDIF 
	ELSE 
		SetQueueTricks NoTricks 
		SetExtraGrindTricks NoTricks 
		SetManualTricks NoTricks 
	ENDIF 
ENDSCRIPT

SCRIPT SetWalkingOffTricks 
	SetQueueTricks NoTricks 
	SetExtraGrindTricks NoTricks 
	SetManualTricks NoTricks 
ENDSCRIPT

SCRIPT SetWalkingTrickState NewWalkingTrickState = GROUND WalkingTricksState = UNSET 
	GetTags 
	IF NOT ( <NewWalkingTrickState> = <WalkingTricksState> ) 
		ClearTrickQueues 
		SWITCH <NewWalkingTrickState> 
			CASE GROUND 
				ClearExceptionGroup WalkingTransitionTrickExceptions 
				SetException Ex = AcidDrop Scr = WalkingAirToTransitionTrick Group = WalkingTransitionTrickExceptions 
				SetException Ex = Rail Scr = WalkingToRailTrick Group = WalkingTransitionTrickExceptions 
				RunTimer_Unpause 
				SetEventHandler Ex = RunTimerUp Scr = Walk_LandSkaterTricks Group = RunTimerEvents 
				SetEventHandler Ex = RunHasEnded Scr = EndOfRun_WalkingEvent Group = WalkingEndRunEvents 
				SetEventHandler Ex = GoalHasEnded Scr = Goal_EndOfRun_WalkingEvent Group = WalkingEndRunEvents 
				ResetLandedFromVert 
				LaunchStateChangeEvent State = Skater_OnGround 
				SetWalkingGroundTricks 
			CASE AIR 
				ClearEventBuffer Buttons = [ UP DOWN ] OlderThan = 0 
				ClearExceptionGroup WalkingTransitionTrickExceptions 
				SetException Ex = AcidDrop Scr = WalkingAirToTransitionTrick Group = WalkingTransitionTrickExceptions 
				SetException Ex = Rail Scr = WalkingToRailTrick Group = WalkingTransitionTrickExceptions 
				ClearExceptionGroup WalkingEndRunEvents 
				ClearExceptionGroup RunTimerEvents 
				LaunchStateChangeEvent State = Skater_InAir 
				SetWalkingAirTricks 
			CASE Off 
				ClearExceptionGroup WalkingTransitionTrickExceptions 
				RunTimer_Unpause 
				SetEventHandler Ex = RunTimerUp Scr = Walk_LandSkaterTricks Group = RunTimerEvents 
				SetEventHandler Ex = RunHasEnded Scr = EndOfRun_WalkingEvent Group = WalkingEndRunEvents 
				SetEventHandler Ex = GoalHasEnded Scr = Goal_EndOfRun_WalkingEvent Group = WalkingEndRunEvents 
				ResetLandedFromVert 
				SetWalkingOffTricks 
		ENDSWITCH 
		SetTags WalkingTricksState = <NewWalkingTrickState> 
	ENDIF 
ENDSCRIPT

SCRIPT Walk_LandSkaterTricks 
	LandSkaterTricks 
	Obj_KillSpawnedScript Id = ComboRunOutTrickDisplayDelay 
ENDSCRIPT

SCRIPT WaitAnimWalking 
	BEGIN 
		DoNextManualTrick ScriptToRunFirst = BeginWalkingManualTrick FromWalk 
		DoNextTrick ScriptToRunFirst = BeginWalkingGenericTrick 
		IF AnimFinished 
			BREAK 
		ENDIF 
		Wait 1 GameFrame 
	REPEAT 
ENDSCRIPT

SCRIPT WaitWalking 
	BEGIN 
		DoNextManualTrick ScriptToRunFirst = BeginWalkingManualTrick FromWalk 
		DoNextTrick ScriptToRunFirst = BeginWalkingGenericTrick 
		Wait 1 GameFrame 
	REPEAT 
ENDSCRIPT

SCRIPT PlayWalkAnim 
	IF NOT IsBoardMissing 
		PlayAnim <...> 
	ELSE 
		AppendSuffixToChecksum Base = <Anim> SuffixString = "_Partial" 
		IF AnimExists <appended_id> 
			PlayAnim <...> PartialAnimOverlay = <appended_id> PartialAnimOverlayId = BoardMissingPartialAnimOverlay 
		ELSE 
			PlayAnim <...> 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT PlayFlippedAnim 
	IF NOT Flipped 
		PlayWalkAnim Anim = ( <Anims> [ 1 ] ) <...> 
	ELSE 
		PlayWalkAnim Anim = ( <Anims> [ 0 ] ) <...> 
	ENDIF 
ENDSCRIPT

SCRIPT PlaySpeedChosenAnim 
	Walk_GetSpeedScale 
	IF NOT GotParam NoSpeedUpdate 
		SWITCH <SpeedScale> 
			CASE WALK_SLOW 
				Walk_ScaleAnimSpeed Run StandardSpeed = ( <Speeds> [ 0 ] ) 
				PlayWalkAnim Anim = ( <Anims> [ 0 ] ) <...> 
			CASE WALK_FAST 
				Walk_ScaleAnimSpeed Run StandardSpeed = ( <Speeds> [ 1 ] ) 
				PlayWalkAnim Anim = ( <Anims> [ 1 ] ) <...> 
			CASE RUN_SLOW 
				Walk_ScaleAnimSpeed Run StandardSpeed = ( <Speeds> [ 2 ] ) 
				PlayWalkAnim Anim = ( <Anims> [ 2 ] ) <...> 
			CASE RUN_FAST 
				Walk_ScaleAnimSpeed Run StandardSpeed = ( <Speeds> [ 3 ] ) 
				PlayWalkAnim Anim = ( <Anims> [ 3 ] ) <...> 
		ENDSWITCH 
	ELSE 
		Walk_ScaleAnimSpeed Off 
		SWITCH <SpeedScale> 
			CASE WALK_SLOW 
				PlayWalkAnim Anim = ( <Anims> [ 0 ] ) Speed = ( <Speeds> [ 0 ] ) <...> 
			CASE WALK_FAST 
				PlayWalkAnim Anim = ( <Anims> [ 1 ] ) Speed = ( <Speeds> [ 1 ] ) <...> 
			CASE RUN_SLOW 
				PlayWalkAnim Anim = ( <Anims> [ 2 ] ) Speed = ( <Speeds> [ 2 ] ) <...> 
			CASE RUN_FAST 
				PlayWalkAnim Anim = ( <Anims> [ 3 ] ) Speed = ( <Speeds> [ 3 ] ) <...> 
		ENDSWITCH 
	ENDIF 
ENDSCRIPT

SCRIPT RunSpeedChosenAnim 
	PlaySpeedChosenAnim NoRestart <...> 
	BEGIN 
		WaitAnimWalkingFrame 
		IF AnimFinished 
			BREAK 
		ENDIF 
		WaitAnimWalkingFrame 
		IF AnimFinished 
			BREAK 
		ENDIF 
		WaitAnimWalkingFrame 
		IF AnimFinished 
			BREAK 
		ENDIF 
		WaitAnimWalkingFrame 
		IF AnimFinished 
			BREAK 
		ENDIF 
		PlaySpeedChosenAnim SyncToPreviousAnim NoRestart <...> 
	REPEAT 
ENDSCRIPT

SCRIPT CycleSpeedChosenAnim 
	PlaySpeedChosenAnim Cycle NoRestart <...> 
	BEGIN 
		WaitWalkingFrame 
		WaitWalkingFrame 
		WaitWalkingFrame 
		WaitWalkingFrame 
		PlaySpeedChosenAnim Cycle SyncToPreviousAnim NoRestart <...> 
	REPEAT 
ENDSCRIPT

SCRIPT WaitWalkingFrame 
	DoNextManualTrick ScriptToRunFirst = BeginWalkingManualTrick FromWalk 
	DoNextTrick ScriptToRunFirst = BeginWalkingGenericTrick 
	Wait 1 GameFrame 
ENDSCRIPT

SCRIPT WaitAnimWalkingFrame 
	DoNextManualTrick ScriptToRunFirst = BeginWalkingManualTrick FromWalk 
	DoNextTrick ScriptToRunFirst = BeginWalkingGenericTrick 
	IF AnimFinished 
		RETURN 
	ENDIF 
	Wait 1 GameFrame 
ENDSCRIPT

SCRIPT ClearAllWalkingExceptions 
	ClearExceptionGroup WalkingStateExceptions 
	ClearExceptionGroup WalkingEvents 
	ClearExceptionGroup WalkingEndRunEvents 
	ClearExceptionGroup WalkingTransitionTrickExceptions 
	ClearExceptionGroup WalkingCollideEvents 
	ClearExceptionGroup RunTimerEvents 
ENDSCRIPT

SCRIPT JustStoppedSkatingState 
	ClearExceptionGroup WalkingStateExceptions 
	IF NOT GotParam Restart 
		SetException Ex = Run Scr = SkateToRunState Group = WalkingStateExceptions 
		SetException Ex = Stand Scr = SkateToStandState Group = WalkingStateExceptions 
		SetException Ex = Skid Scr = SkateToStandState Group = WalkingStateExceptions 
		SetException Ex = LadderOntoBottom Scr = LadderOntoBottomState Group = WalkingStateExceptions 
		SetException Ex = LadderOntoTop Scr = LadderOntoTopState Group = WalkingStateExceptions 
		SetException Ex = Land Scr = LandState Group = WalkingStateExceptions 
		SetException Ex = Hang Scr = AirToHangState Group = WalkingStateExceptions 
		SetException Ex = Ladder Scr = LadderMoveUpState Group = WalkingStateExceptions 
		SetException Ex = AIR Scr = SkateToAirState Group = WalkingStateExceptions 
		SetException Ex = Jump Scr = SkateToAirState Group = WalkingStateExceptions 
		SetException Ex = WalkOffEdge Scr = SkateToAirState Group = WalkingStateExceptions 
		SetException Ex = DropToHang Scr = DropToHangState Group = WalkingStateExceptions 
		SetException Ex = Rail Scr = WalkingToRailTrick Group = WalkingStateExceptions 
		SetException Ex = Wallplant Scr = WallplantState Group = WalkingStateExceptions 
		SetException Ex = AcidDrop Scr = WalkingAirToTransitionTrick Group = WalkingTransitionTrickExceptions 
	ELSE 
		SetException Ex = Run Scr = StandState Group = WalkingStateExceptions 
		SetException Ex = Stand Scr = StandState Group = WalkingStateExceptions 
		SetException Ex = Skid Scr = StandState Group = WalkingStateExceptions 
		SetException Ex = RotateLeft Scr = StandState Group = WalkingStateExceptions 
		SetException Ex = RotateRight Scr = StandState Group = WalkingStateExceptions 
		SetException Ex = Land Scr = StandState Group = WalkingStateExceptions 
		SetException Ex = LadderOntoBottom Scr = LadderOntoBottomState Group = WalkingStateExceptions 
		SetException Ex = LadderOntoTop Scr = LadderOntoTopState Group = WalkingStateExceptions 
		SetException Ex = Hang Scr = HangState Group = WalkingStateExceptions 
		SetException Ex = Ladder Scr = LadderMoveUpState Group = WalkingStateExceptions 
		SetException Ex = AIR Scr = AirState Group = WalkingStateExceptions 
		SetException Ex = Jump Scr = AirState Group = WalkingStateExceptions 
		SetException Ex = WalkOffEdge Scr = AirState Group = WalkingStateExceptions 
		SetException Ex = DropToHang Scr = DropToHangState Group = WalkingStateExceptions 
		SetException Ex = Rail Scr = WalkingToRailTrick Group = WalkingStateExceptions 
		SetException Ex = Wallplant Scr = WallplantState Group = WalkingStateExceptions 
		SetException Ex = AcidDrop Scr = WalkingAirToTransitionTrick Group = WalkingTransitionTrickExceptions 
		PlayWalkAnim Anim = WStand BlendPeriod = 0 
		BlendPeriodOut 0 
		GetCameraId 
		<CameraId> : WalkCamera_Reset 
	ENDIF 
	IF NOT IsNGC 
		SetEventHandler Ex = Trigger_L2 Scr = CameraFlushButton Group = WalkingEvents 
	ELSE 
		SetEventHandler Ex = Trigger_L1 Scr = CameraFlushButton Group = WalkingEvents 
	ENDIF 
	SetEventHandler Ex = Release_X Scr = JumpButton Group = WalkingEvents 
	SetEventHandler Ex = MadeOtherSkaterBail Scr = MadeOtherSkaterBailWalk Group = WalkingCollideEvents 
	SetException Ex = SkaterCollideBail Scr = SkaterCollideBail Group = WalkingCollideEvents 
	SetTags WalkingGroundTricksInactive 
	Obj_SpawnScript ActivateGroundTricksDelay Id = ActivateGroundTricksDelay 
	SetWalkingTrickState NewWalkingTrickState = UNSET 
	IF CurrentScorePotGreaterThan 0 
		Obj_SpawnScript ComboRunOutTrickDisplayDelay Id = ComboRunOutTrickDisplayDelay 
	ENDIF 
	WaitWalking 
ENDSCRIPT

SCRIPT SkateToRunState 
	ClearExceptionGroup WalkingStateExceptions 
	SetException Ex = Stand Scr = SkateToStandState Group = WalkingStateExceptions Params = { SyncToPreviousAnim } 
	SetException Ex = Skid Scr = SkateToStandState Group = WalkingStateExceptions Params = { SyncToPreviousAnim } 
	SetException Ex = RotateLeft Scr = SkateToRotateState Group = WalkingStateExceptions Params = { SyncToPreviousAnim } 
	SetException Ex = RotateRight Scr = SkateToRotateState Group = WalkingStateExceptions Params = { SyncToPreviousAnim } 
	SetException Ex = LadderOntoBottom Scr = LadderOntoBottomState Group = WalkingStateExceptions 
	SetException Ex = LadderOntoTop Scr = LadderOntoTopState Group = WalkingStateExceptions 
	SetException Ex = Jump Scr = RunJumpState Group = WalkingStateExceptions 
	SetException Ex = WalkOffEdge Scr = AirState Group = WalkingStateExceptions 
	SetException Ex = DropToHang Scr = DropToHangState Group = WalkingStateExceptions 
	SetEventHandler Ex = JumpRequested Scr = JumpRequestedEvent Group = WalkingEvents 
	SetWalkingTrickState NewWalkingTrickState = GROUND 
	Walk_ScaleAnimSpeed Off 
	IF AnimEquals WRunToSkate 
		RunSpeedChosenAnim Anims = [ SkateToWalk SkateToWalk WSkateToRun WSkateToRun ] Speeds = [ 1 1 1.29999995232 1.29999995232 ] BlendPeriod = 0.30000001192 SyncToReversePreviousAnim NoSpeedUpdate <...> 
	ELSE 
		RunSpeedChosenAnim Anims = [ SkateToWalk SkateToWalk WSkateToRun WSkateToRun ] Speeds = [ 1 1 1.29999995232 1.29999995232 ] BlendPeriod = 0.10000000149 NoSpeedUpdate <...> 
	ENDIF 
	Goto RunState 
ENDSCRIPT

SCRIPT SkateToStandState 
	ClearExceptionGroup WalkingStateExceptions 
	SetException Ex = Run Scr = SkateToRunState Group = WalkingStateExceptions Params = { SyncToPreviousAnim } 
	SetException Ex = LadderOntoBottom Scr = LadderOntoBottomState Group = WalkingStateExceptions 
	SetException Ex = LadderOntoTop Scr = LadderOntoTopState Group = WalkingStateExceptions 
	SetException Ex = Jump Scr = RunJumpState Group = WalkingStateExceptions 
	SetException Ex = WalkOffEdge Scr = AirState Group = WalkingStateExceptions 
	SetException Ex = DropToHang Scr = DropToHangState Group = WalkingStateExceptions 
	SetEventHandler Ex = JumpRequested Scr = JumpRequestedEvent Group = WalkingEvents 
	SetWalkingTrickState NewWalkingTrickState = GROUND 
	Walk_ScaleAnimSpeed Off 
	IF AnimEquals [ SlowDownBrake NewBrakeIdle NewBrakeIdle3 NewBrakeIdle5 NewBrakeIdle6 NewBrakeIdle7 NewBrakeIdle8 ] 
		PlayAnim Anim = BrakeToStand BlendPeriod = 0.30000001192 
	ELSE 
		IF AnimEquals WRunToSkate 
			PlayAnim Anim = SlowSkateToStand BlendPeriod = 0.30000001192 SyncToReversePreviousAnim EffectivePreviousAnimDuration = 0.50000000000 <...> 
		ELSE 
			PlayAnim Anim = SlowSkateToStand BlendPeriod = 0.10000000149 <...> 
		ENDIF 
	ENDIF 
	WaitAnimWalking 
	Goto StandState 
ENDSCRIPT

SCRIPT SkateToRotateState 
	ClearExceptionGroup WalkingStateExceptions 
	SetException Ex = Run Scr = SkateToRunState Group = WalkingStateExceptions Params = { SyncToPreviousAnim } 
	SetException Ex = Stand Scr = SkateToStandState Group = WalkingStateExceptions Params = { SyncToPreviousAnim } 
	SetException Ex = Skid Scr = SkateToStandState Group = WalkingStateExceptions Params = { SyncToPreviousAnim } 
	SetException Ex = LadderOntoBottom Scr = LadderOntoBottomState Group = WalkingStateExceptions 
	SetException Ex = LadderOntoTop Scr = LadderOntoTopState Group = WalkingStateExceptions 
	SetException Ex = Jump Scr = RunJumpState Group = WalkingStateExceptions 
	SetException Ex = WalkOffEdge Scr = AirState Group = WalkingStateExceptions 
	SetException Ex = DropToHang Scr = DropToHangState Group = WalkingStateExceptions 
	SetEventHandler Ex = JumpRequested Scr = JumpRequestedEvent Group = WalkingEvents 
	SetWalkingTrickState NewWalkingTrickState = GROUND 
	Walk_ScaleAnimSpeed Off 
	IF AnimEquals WRunToSkate 
		PlayAnim Anim = SkateToWalk BlendPeriod = 0.30000001192 SyncToReversePreviousAnim <...> 
	ELSE 
		IF AnimEquals SkateToRun 
			PlayAnim Anim = SkateToRun BlendPeriod = 0.10000000149 <...> 
		ELSE 
			PlayAnim Anim = SkateToWalk BlendPeriod = 0.10000000149 <...> 
		ENDIF 
	ENDIF 
	WaitAnimWalking 
	Goto RunState 
ENDSCRIPT

SCRIPT SkateToAirState 
	ClearExceptionGroup WalkingStateExceptions 
	SetException Ex = Land Scr = LandState Group = WalkingStateExceptions 
	SetException Ex = Hang Scr = AirToHangState Group = WalkingStateExceptions 
	SetException Ex = Ladder Scr = LadderMoveUpState Group = WalkingStateExceptions 
	SetException Ex = Wallplant Scr = WallplantState Group = WalkingStateExceptions 
	SetException Ex = Wallplant Scr = WallplantState Group = WalkingStateExceptions 
	SetWalkingTrickState NewWalkingTrickState = AIR 
	Walk_ScaleAnimSpeed Off 
	PlayAnim Anim = AirIdleToJumpAir BlendPeriod = 0.30000001192 
	WaitAnimWalking 
	Goto AirState 
ENDSCRIPT

SCRIPT RunState 
	ClearExceptionGroup WalkingStateExceptions 
	SetException Ex = Stand Scr = StandState Group = WalkingStateExceptions 
	IF GotParam NoSkid 
		SetException Ex = Skid Scr = StandState Group = WalkingStateExceptions 
	ELSE 
		SetException Ex = Skid Scr = SkidState Group = WalkingStateExceptions 
	ENDIF 
	SetException Ex = RotateLeft Scr = RunToRotateLeftState Group = WalkingStateExceptions Params = { SyncToPreviousAnim } 
	SetException Ex = RotateRight Scr = RunToRotateRightState Group = WalkingStateExceptions Params = { SyncToPreviousAnim } 
	SetException Ex = LadderOntoBottom Scr = LadderOntoBottomState Group = WalkingStateExceptions 
	SetException Ex = LadderOntoTop Scr = LadderOntoTopState Group = WalkingStateExceptions 
	SetException Ex = Jump Scr = RunJumpState Group = WalkingStateExceptions 
	SetException Ex = WalkOffEdge Scr = AirState Group = WalkingStateExceptions 
	SetException Ex = DropToHang Scr = DropToHangState Group = WalkingStateExceptions 
	SetException Ex = Ride Scr = StandToRideState Group = WalkingStateExceptions 
	SetEventHandler Ex = JumpRequested Scr = JumpRequestedEvent Group = WalkingEvents 
	SetWalkingTrickState NewWalkingTrickState = GROUND 
	CycleSpeedChosenAnim Anims = [ WalkSlow WalkFast WRun FastRun ] Speeds = [ 63.88000106812 130.44000244141 350 520 ] BlendPeriod = 0.10000000149 
ENDSCRIPT

SCRIPT StandState 
	ClearExceptionGroup WalkingStateExceptions 
	SetException Ex = Run Scr = StandToRunState Group = WalkingStateExceptions 
	SetException Ex = RotateLeft Scr = StandToRotateLeftState Group = WalkingStateExceptions 
	SetException Ex = RotateRight Scr = StandToRotateRightState Group = WalkingStateExceptions 
	SetException Ex = LadderOntoBottom Scr = LadderOntoBottomState Group = WalkingStateExceptions 
	SetException Ex = LadderOntoTop Scr = LadderOntoTopState Group = WalkingStateExceptions 
	SetException Ex = Jump Scr = StandJumpState Group = WalkingStateExceptions 
	SetException Ex = WalkOffEdge Scr = AirState Group = WalkingStateExceptions 
	SetException Ex = DropToHang Scr = DropToHangState Group = WalkingStateExceptions 
	SetException Ex = Ride Scr = StandToRideState Group = WalkingStateExceptions 
	SetEventHandler Ex = JumpRequested Scr = JumpRequestedEvent Group = WalkingEvents 
	SetWalkingTrickState NewWalkingTrickState = GROUND 
	GetSpeed 
	SetSpeed ( 0.44999998808 * <Speed> ) 
	Walk_ScaleAnimSpeed Off 
	IF AnimEquals [ _180RunSkid SkateToSkid ] 
		PlayWalkAnim Anim = WStand NoRestart BlendPeriod = 0.30000001192 
	ELSE 
		PlayWalkAnim Anim = WStand NoRestart BlendPeriod = 0.10000000149 
	ENDIF 
	WaitAnimWalking 
	BEGIN 
		PlayWalkAnim BlendPeriod = 0.10000000149 Anim = RANDOM(3, 1) 
			RANDOMCASE WStand 
			RANDOMCASE RANDOM_NO_REPEAT(1, 1, 1, 1, 1, 1) 
				RANDOMCASE WStandIdle1 
				RANDOMCASE WStandIdle2 
				RANDOMCASE WStandIdle3 
				RANDOMCASE WStandIdle4 
				RANDOMCASE WStandIdle5 
				RANDOMCASE WStandIdle6 
			RANDOMEND 
		RANDOMEND 
		WaitAnimWalking 
	REPEAT 
ENDSCRIPT

SCRIPT StandToRunState 
	ClearExceptionGroup WalkingStateExceptions 
	SetException Ex = Stand Scr = StandState Group = WalkingStateExceptions 
	SetException Ex = Skid Scr = StandState Group = WalkingStateExceptions 
	SetException Ex = RotateLeft Scr = RunToRotateLeftState Group = WalkingStateExceptions 
	SetException Ex = RotateRight Scr = RunToRotateRightState Group = WalkingStateExceptions 
	SetException Ex = LadderOntoBottom Scr = LadderOntoBottomState Group = WalkingStateExceptions 
	SetException Ex = LadderOntoTop Scr = LadderOntoTopState Group = WalkingStateExceptions 
	SetException Ex = Jump Scr = RunJumpState Group = WalkingStateExceptions 
	SetException Ex = WalkOffEdge Scr = AirState Group = WalkingStateExceptions 
	SetException Ex = DropToHang Scr = DropToHangState Group = WalkingStateExceptions 
	SetException Ex = Ride Scr = StandToRideState Group = WalkingStateExceptions 
	SetEventHandler Ex = JumpRequested Scr = JumpRequestedEvent Group = WalkingEvents 
	SetWalkingTrickState NewWalkingTrickState = GROUND 
	RunSpeedChosenAnim Anims = [ WStandToWalk WStandToWalk WStandToRun WStandToRun ] Speeds = [ 100 100 370 370 ] BlendPeriod = 0.10000000149 
	Goto RunState 
ENDSCRIPT

SCRIPT SkidState 
	ClearExceptionGroup WalkingStateExceptions 
	SetException Ex = Stand Scr = StandState Group = WalkingStateExceptions 
	SetException Ex = Run Scr = RunState Group = WalkingStateExceptions 
	SetException Ex = RotateLeft Scr = RunToRotateLeftState Group = WalkingStateExceptions 
	SetException Ex = RotateRight Scr = RunToRotateRightState Group = WalkingStateExceptions 
	SetException Ex = LadderOntoBottom Scr = LadderOntoBottomState Group = WalkingStateExceptions 
	SetException Ex = LadderOntoTop Scr = LadderOntoTopState Group = WalkingStateExceptions 
	SetException Ex = Jump Scr = RunJumpState Group = WalkingStateExceptions 
	SetException Ex = WalkOffEdge Scr = AirState Group = WalkingStateExceptions 
	SetException Ex = DropToHang Scr = DropToHangState Group = WalkingStateExceptions 
	SetException Ex = Ride Scr = StandToRideState Group = WalkingStateExceptions 
	SetEventHandler Ex = JumpRequested Scr = JumpRequestedEvent Group = WalkingEvents 
	SetWalkingTrickState NewWalkingTrickState = GROUND 
	Walk_ScaleAnimSpeed Off 
	PlayWalkAnim Anim = _180RunSkid NoRestart BlendPeriod = 0.10000000149 
	WaitAnimWalking 
	Goto StandState 
ENDSCRIPT

SCRIPT StandToRotateLeftState 
	ClearExceptionGroup WalkingStateExceptions 
	SetException Ex = Stand Scr = StandState Group = WalkingStateExceptions 
	SetException Ex = Run Scr = StandToRunState Group = WalkingStateExceptions 
	SetException Ex = Skid Scr = SkidState Group = WalkingStateExceptions 
	SetException Ex = RotateRight Scr = RunToRotateRightState Group = WalkingStateExceptions 
	SetException Ex = LadderOntoBottom Scr = LadderOntoBottomState Group = WalkingStateExceptions 
	SetException Ex = LadderOntoTop Scr = LadderOntoTopState Group = WalkingStateExceptions 
	SetException Ex = Jump Scr = StandJumpState Group = WalkingStateExceptions 
	SetException Ex = WalkOffEdge Scr = AirState Group = WalkingStateExceptions 
	SetException Ex = DropToHang Scr = DropToHangState Group = WalkingStateExceptions 
	SetException Ex = Ride Scr = StandToRideState Group = WalkingStateExceptions 
	SetEventHandler Ex = JumpRequested Scr = JumpRequestedEvent Group = WalkingEvents 
	SetWalkingTrickState NewWalkingTrickState = GROUND 
	Walk_ScaleAnimSpeed Off 
	PlayWalkAnim Anim = WStandToWalk BlendPeriod = 0.05000000075 
	WaitAnimWalking 
	SetException Ex = Run Scr = RunState Group = WalkingStateExceptions Params = { SyncToPreviousAnim } 
	PlayWalkAnim Anim = WalkFast Cycle NoRestart BlendPeriod = 0.10000000149 
	WaitWalking 
ENDSCRIPT

SCRIPT RunToRotateLeftState 
	ClearExceptionGroup WalkingStateExceptions 
	SetException Ex = Stand Scr = StandState Group = WalkingStateExceptions 
	SetException Ex = Run Scr = RunState Group = WalkingStateExceptions Params = { SyncToPreviousAnim } 
	SetException Ex = Skid Scr = SkidState Group = WalkingStateExceptions 
	SetException Ex = RotateRight Scr = RunToRotateRightState Group = WalkingStateExceptions 
	SetException Ex = LadderOntoBottom Scr = LadderOntoBottomState Group = WalkingStateExceptions 
	SetException Ex = LadderOntoTop Scr = LadderOntoTopState Group = WalkingStateExceptions 
	SetException Ex = Jump Scr = StandJumpState Group = WalkingStateExceptions 
	SetException Ex = WalkOffEdge Scr = AirState Group = WalkingStateExceptions 
	SetException Ex = DropToHang Scr = DropToHangState Group = WalkingStateExceptions 
	SetException Ex = Ride Scr = StandToRideState Group = WalkingStateExceptions 
	SetEventHandler Ex = JumpRequested Scr = JumpRequestedEvent Group = WalkingEvents 
	SetWalkingTrickState NewWalkingTrickState = GROUND 
	Walk_ScaleAnimSpeed Off 
	IF AnimEquals WalkSlow 
		PlayWalkAnim Anim = WalkSlow Cycle NoRestart BlendPeriod = 0.10000000149 <...> 
	ELSE 
		PlayWalkAnim Anim = WalkFast Cycle NoRestart BlendPeriod = 0.10000000149 <...> 
	ENDIF 
	WaitWalking 
ENDSCRIPT

SCRIPT StandToRotateRightState 
	ClearExceptionGroup WalkingStateExceptions 
	SetException Ex = Stand Scr = StandState Group = WalkingStateExceptions 
	SetException Ex = Run Scr = StandToRunState Group = WalkingStateExceptions 
	SetException Ex = Skid Scr = SkidState Group = WalkingStateExceptions 
	SetException Ex = RotateLeft Scr = RunToRotateLeftState Group = WalkingStateExceptions 
	SetException Ex = LadderOntoBottom Scr = LadderOntoBottomState Group = WalkingStateExceptions 
	SetException Ex = LadderOntoTop Scr = LadderOntoTopState Group = WalkingStateExceptions 
	SetException Ex = Jump Scr = StandJumpState Group = WalkingStateExceptions 
	SetException Ex = WalkOffEdge Scr = AirState Group = WalkingStateExceptions 
	SetException Ex = DropToHang Scr = DropToHangState Group = WalkingStateExceptions 
	SetException Ex = Ride Scr = StandToRideState Group = WalkingStateExceptions 
	SetEventHandler Ex = JumpRequested Scr = JumpRequestedEvent Group = WalkingEvents 
	SetWalkingTrickState NewWalkingTrickState = GROUND 
	Walk_ScaleAnimSpeed Off 
	PlayWalkAnim Anim = WStandToWalk BlendPeriod = 0.05000000075 
	WaitAnimWalking 
	SetException Ex = Run Scr = RunState Group = WalkingStateExceptions Params = { SyncToPreviousAnim } 
	PlayWalkAnim Anim = WalkFast Cycle NoRestart BlendPeriod = 0.10000000149 
	WaitWalking 
ENDSCRIPT

SCRIPT RunToRotateRightState 
	ClearExceptionGroup WalkingStateExceptions 
	SetException Ex = Stand Scr = StandState Group = WalkingStateExceptions 
	SetException Ex = Run Scr = RunState Group = WalkingStateExceptions Params = { SyncToPreviousAnim } 
	SetException Ex = Skid Scr = SkidState Group = WalkingStateExceptions 
	SetException Ex = RotateLeft Scr = RunToRotateLeftState Group = WalkingStateExceptions 
	SetException Ex = LadderOntoBottom Scr = LadderOntoBottomState Group = WalkingStateExceptions 
	SetException Ex = LadderOntoTop Scr = LadderOntoTopState Group = WalkingStateExceptions 
	SetException Ex = Jump Scr = StandJumpState Group = WalkingStateExceptions 
	SetException Ex = WalkOffEdge Scr = AirState Group = WalkingStateExceptions 
	SetException Ex = DropToHang Scr = DropToHangState Group = WalkingStateExceptions 
	SetException Ex = Ride Scr = StandToRideState Group = WalkingStateExceptions 
	SetEventHandler Ex = JumpRequested Scr = JumpRequestedEvent Group = WalkingEvents 
	SetWalkingTrickState NewWalkingTrickState = GROUND 
	Walk_ScaleAnimSpeed Off 
	IF AnimEquals WalkSlow 
		PlayWalkAnim Anim = WalkSlow Cycle NoRestart BlendPeriod = 0.10000000149 <...> 
	ELSE 
		PlayWalkAnim Anim = WalkFast Cycle NoRestart BlendPeriod = 0.10000000149 <...> 
	ENDIF 
	WaitWalking 
ENDSCRIPT

SCRIPT GroundPunchState 
	ClearExceptionGroup WalkingStateExceptions 
	SetException Ex = LadderOntoBottom Scr = LadderOntoBottomState Group = WalkingStateExceptions 
	SetException Ex = LadderOntoTop Scr = LadderOntoTopState Group = WalkingStateExceptions 
	SetException Ex = Jump Scr = RunJumpState Group = WalkingStateExceptions 
	SetException Ex = WalkOffEdge Scr = AirState Group = WalkingStateExceptions 
	SetException Ex = DropToHang Scr = DropToHangState Group = WalkingStateExceptions 
	SetException Ex = Ride Scr = StandToRideState Group = WalkingStateExceptions 
	SetEventHandler Ex = JumpRequested Scr = JumpRequestedEvent Group = WalkingEvents 
	SetWalkingTrickState NewWalkingTrickState = GROUND 
	Walk_ScaleAnimSpeed Off 
	PlayWalkAnim Anim = WalkingSlap BlendPeriod = 0.10000000149 To = 25 
	WaitAnimWalking 
	Goto GroundOrAirWaitState 
ENDSCRIPT

SCRIPT AirPunchState 
	ClearExceptionGroup WalkingStateExceptions 
	SetException Ex = Land Scr = LandState Group = WalkingStateExceptions 
	SetException Ex = Hang Scr = AirToHangState Group = WalkingStateExceptions 
	SetException Ex = Ladder Scr = LadderMoveUpState Group = WalkingStateExceptions 
	SetException Ex = Jump Scr = RunJumpState Group = WalkingStateExceptions 
	SetException Ex = Wallplant Scr = WallplantState Group = WalkingStateExceptions 
	SetWalkingTrickState NewWalkingTrickState = AIR 
	Walk_ScaleAnimSpeed Off 
	PlayWalkAnim Anim = WalkingSlap BlendPeriod = 0.10000000149 To = 25 
	WaitAnimWalking 
	Goto GroundOrAirWaitState 
ENDSCRIPT

SCRIPT RunJumpState 
	ClearExceptionGroup WalkingStateExceptions 
	SetException Ex = Land Scr = LandState Group = WalkingStateExceptions 
	SetException Ex = Hang Scr = AirToHangState Group = WalkingStateExceptions 
	SetException Ex = Ladder Scr = LadderMoveUpState Group = WalkingStateExceptions 
	SetException Ex = Wallplant Scr = WallplantState Group = WalkingStateExceptions 
	SetWalkingTrickState NewWalkingTrickState = AIR 
	Walk_ScaleAnimSpeed Off 
	PlayWalkAnim Anim = RunToJump BlendPeriod = 0.10000000149 
	WaitAnimWalking 
	Goto AirState 
ENDSCRIPT

SCRIPT StandJumpState 
	ClearExceptionGroup WalkingStateExceptions 
	SetException Ex = Land Scr = LandState Group = WalkingStateExceptions 
	SetException Ex = Hang Scr = AirToHangState Group = WalkingStateExceptions 
	SetException Ex = Ladder Scr = LadderMoveUpState Group = WalkingStateExceptions 
	SetException Ex = Wallplant Scr = WallplantState Group = WalkingStateExceptions 
	SetWalkingTrickState NewWalkingTrickState = AIR 
	Walk_ScaleAnimSpeed Off 
	PlayWalkAnim Anim = StandToJump BlendPeriod = 0.10000000149 
	WaitAnimWalking 
	Goto AirState 
ENDSCRIPT

SCRIPT WallplantState 
	ClearExceptionGroup WalkingStateExceptions 
	SetException Ex = Land Scr = LandState Group = WalkingStateExceptions 
	SetException Ex = Hang Scr = AirToHangState Group = WalkingStateExceptions 
	SetException Ex = Ladder Scr = LadderMoveUpState Group = WalkingStateExceptions 
	SetException Ex = Wallplant Scr = WallplantState Group = WalkingStateExceptions 
	SetWalkingTrickState NewWalkingTrickState = AIR 
	BroadcastEvent Type = SkaterWallplant 
	IF CurrentScorePotGreaterThan 0 
		SetTrickName #"Wall Jump" 
		SetTrickScore 100 
		Display 
	ENDIF 
	Walk_ScaleAnimSpeed Off 
	PlayWalkAnim Anim = RunToJump BlendPeriod = 0.10000000149 
	WaitAnimWalking 
	Goto AirState 
ENDSCRIPT

SCRIPT AirState 
	ClearExceptionGroup WalkingStateExceptions 
	SetException Ex = Land Scr = LandState Group = WalkingStateExceptions 
	SetException Ex = Hang Scr = AirToHangState Group = WalkingStateExceptions 
	SetException Ex = Ladder Scr = LadderMoveUpState Group = WalkingStateExceptions 
	SetException Ex = Jump Scr = RunJumpState Group = WalkingStateExceptions 
	SetException Ex = Wallplant Scr = WallplantState Group = WalkingStateExceptions 
	SetWalkingTrickState NewWalkingTrickState = AIR 
	Walk_ScaleAnimSpeed Off 
	PlayWalkAnim Anim = JumpAir Cycle NoRestart BlendPeriod = 0.10000000149 
	WaitWalking 
ENDSCRIPT

SCRIPT LandState 
	ClearExceptionGroup WalkingStateExceptions 
	SetException Ex = Stand Scr = StandLandState Group = WalkingStateExceptions 
	SetException Ex = Run Scr = RunLandState Group = WalkingStateExceptions 
	SetException Ex = Skid Scr = SkidState Group = WalkingStateExceptions 
	SetException Ex = RotateLeft Scr = StandToRotateLeftState Group = WalkingStateExceptions 
	SetException Ex = RotateRight Scr = StandToRotateRightState Group = WalkingStateExceptions 
	SetException Ex = LadderOntoBottom Scr = LadderOntoBottomState Group = WalkingStateExceptions 
	SetException Ex = LadderOntoTop Scr = LadderOntoTopState Group = WalkingStateExceptions 
	SetException Ex = Jump Scr = RunJumpState Group = WalkingStateExceptions 
	SetException Ex = WalkOffEdge Scr = AirState Group = WalkingStateExceptions 
	SetException Ex = DropToHang Scr = DropToHangState Group = WalkingStateExceptions 
	SetWalkingTrickState NewWalkingTrickState = GROUND 
	SetEventHandler Ex = JumpRequested Scr = JumpRequestedEvent Group = WalkingEvents 
	WaitWalking 
ENDSCRIPT

SCRIPT StandLandState 
	ClearExceptionGroup WalkingStateExceptions 
	SetException Ex = Run Scr = RunState Group = WalkingStateExceptions 
	SetException Ex = Skid Scr = SkidState Group = WalkingStateExceptions 
	SetException Ex = RotateLeft Scr = StandToRotateLeftState Group = WalkingStateExceptions 
	SetException Ex = RotateRight Scr = StandToRotateRightState Group = WalkingStateExceptions 
	SetException Ex = LadderOntoBottom Scr = LadderOntoBottomState Group = WalkingStateExceptions 
	SetException Ex = LadderOntoTop Scr = LadderOntoTopState Group = WalkingStateExceptions 
	SetException Ex = Jump Scr = StandJumpState Group = WalkingStateExceptions 
	SetException Ex = WalkOffEdge Scr = AirState Group = WalkingStateExceptions 
	SetException Ex = DropToHang Scr = DropToHangState Group = WalkingStateExceptions 
	SetWalkingTrickState NewWalkingTrickState = GROUND 
	Walk_ScaleAnimSpeed Off 
	PlayWalkAnim Anim = JumpLandToStand BlendPeriod = 0.05000000075 
	WaitAnimWalking 
	Goto StandState 
ENDSCRIPT

SCRIPT RunLandState 
	ClearExceptionGroup WalkingStateExceptions 
	SetException Ex = Stand Scr = StandState Group = WalkingStateExceptions 
	SetException Ex = Skid Scr = SkidState Group = WalkingStateExceptions 
	SetException Ex = RotateLeft Scr = RunToRotateLeftState Group = WalkingStateExceptions 
	SetException Ex = RotateRight Scr = RunToRotateRightState Group = WalkingStateExceptions 
	SetException Ex = LadderOntoBottom Scr = LadderOntoBottomState Group = WalkingStateExceptions 
	SetException Ex = LadderOntoTop Scr = LadderOntoTopState Group = WalkingStateExceptions 
	SetException Ex = Jump Scr = RunJumpState Group = WalkingStateExceptions 
	SetException Ex = WalkOffEdge Scr = AirState Group = WalkingStateExceptions 
	SetException Ex = DropToHang Scr = DropToHangState Group = WalkingStateExceptions 
	SetWalkingTrickState NewWalkingTrickState = GROUND 
	RunSpeedChosenAnim Anims = [ JumpLandToWalk JumpLandToWalk JumpLandToRun JumpLandToRun ] Speeds = [ 1.50000000000 1.50000000000 1.75000000000 1.75000000000 ] BlendPeriod = 0.10000000149 NoSpeedUpdate 
	BlendPeriodOut 0.30000001192 
	WaitAnimWalking 
	Goto RunState 
ENDSCRIPT

SCRIPT HangState 
	ClearExceptionGroup WalkingStateExceptions 
	SetException Ex = HangMoveLeft Scr = HangMoveLeftState Group = WalkingStateExceptions 
	SetException Ex = HangMoveRight Scr = HangMoveRightState Group = WalkingStateExceptions 
	SetException Ex = AIR Scr = HangToAirState Group = WalkingStateExceptions 
	SetException Ex = Jump Scr = HangToAirState Group = WalkingStateExceptions 
	SetException Ex = PullUpFromHang Scr = PullUpFromHangState Group = WalkingStateExceptions 
	SetEventHandler Ex = JumpRequested Scr = JumpRequestedEvent Group = WalkingEvents 
	SetWalkingTrickState NewWalkingTrickState = Off 
	LaunchStateChangeEvent State = Skater_InHang 
	Walk_ScaleAnimSpeed Off 
	IF AnimEquals [ JumpToSwingHang JumpToWallHang ] 
		WaitAnimWalking 
	ENDIF 
	PlayWalkAnim Anim = HangIdle Cycle NoRestart BlendPeriod = 0.30000001192 
	WaitWalking 
ENDSCRIPT

SCRIPT AirToHangState 
	ClearExceptionGroup WalkingStateExceptions 
	SetException Ex = HangMoveLeft Scr = HangMoveLeftState Group = WalkingStateExceptions 
	SetException Ex = HangMoveRight Scr = HangMoveRightState Group = WalkingStateExceptions 
	SetException Ex = AIR Scr = HangToAirState Group = WalkingStateExceptions 
	SetException Ex = Jump Scr = HangToAirState Group = WalkingStateExceptions 
	SetException Ex = PullUpFromHang Scr = PullUpFromHangState Group = WalkingStateExceptions 
	SetEventHandler Ex = JumpRequested Scr = JumpRequestedEvent Group = WalkingEvents 
	SetWalkingTrickState NewWalkingTrickState = Off 
	LaunchStateChangeEvent State = Skater_InHang 
	Walk_ScaleAnimSpeed Off 
	Walk_GetHangInitAnimType 
	SWITCH <HangInitAnimType> 
		CASE SWING 
			PlayWalkAnim Anim = JumpToSwingHang BlendPeriod = 0 
		CASE WALL 
			PlayWalkAnim Anim = JumpToWallHang BlendPeriod = 0 
	ENDSWITCH 
	WaitAnimWalking 
	Goto HangState 
ENDSCRIPT

SCRIPT PlayHangMoveAnimCycle 
	BlendPeriodOut 0.30000001192 
	PreviousPartialAnimOverlay = UndeterminedOverlay 
	BEGIN 
		Walk_GetHangAngle 
		IF GotParam ReverseAngle 
			HangAngle = ( 0 - <HangAngle> ) 
		ENDIF 
		IF ( ( <HangAngle> < 5 ) & ( <HangAngle> > -5 ) ) 
			PartialAnimOverlay = NoOverlay 
		ELSE 
			IF ( <HangAngle> > 0 ) 
				IF ( <HangAngle> < 15 ) 
					AppendSuffixToChecksum Base = <HangAnim> SuffixString = "10_Partial" 
					PartialAnimOverlay = <appended_id> 
				ELSE 
					IF ( <HangAngle> < 25 ) 
						AppendSuffixToChecksum Base = <HangAnim> SuffixString = "20_Partial" 
						PartialAnimOverlay = <appended_id> 
					ELSE 
						IF ( <HangAngle> < 35 ) 
							AppendSuffixToChecksum Base = <HangAnim> SuffixString = "30_Partial" 
							PartialAnimOverlay = <appended_id> 
						ELSE 
							AppendSuffixToChecksum Base = <HangAnim> SuffixString = "40_Partial" 
							PartialAnimOverlay = <appended_id> 
						ENDIF 
					ENDIF 
				ENDIF 
			ELSE 
				IF ( <HangAngle> > -15 ) 
					AppendSuffixToChecksum Base = <HangAnim> SuffixString = "10_PartialUp" 
					PartialAnimOverlay = <appended_id> 
				ELSE 
					IF ( <HangAngle> > -25 ) 
						AppendSuffixToChecksum Base = <HangAnim> SuffixString = "20_PartialUp" 
						PartialAnimOverlay = <appended_id> 
					ELSE 
						IF ( <HangAngle> > -35 ) 
							AppendSuffixToChecksum Base = <HangAnim> SuffixString = "30_PartialUp" 
							PartialAnimOverlay = <appended_id> 
						ELSE 
							AppendSuffixToChecksum Base = <HangAnim> SuffixString = "40_PartialUp" 
							PartialAnimOverlay = <appended_id> 
						ENDIF 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
		IF NOT ( <PreviousPartialAnimOverlay> = <PartialAnimOverlay> ) 
			IF ( <PartialAnimOverlay> = NoOverlay ) 
				PlayAnim Anim = <HangAnim> Cycle <SyncToPreviousAnim> BlendPeriod = 0.10000000149 
			ELSE 
				PlayAnim Anim = <HangAnim> PartialAnimOverlay = <PartialAnimOverlay> Cycle <SyncToPreviousAnim> BlendPeriod = 0.10000000149 
			ENDIF 
		ENDIF 
		PreviousPartialAnimOverlay = <PartialAnimOverlay> 
		SyncToPreviousAnim = SyncToPreviousAnim 
		DoNextManualTrick ScriptToRunFirst = BeginWalkingManualTrick FromWalk 
		DoNextTrick ScriptToRunFirst = BeginWalkingGenericTrick 
		Wait 1 GameFrame 
	REPEAT 
ENDSCRIPT

SCRIPT HangMoveLeftState 
	ClearExceptionGroup WalkingStateExceptions 
	SetException Ex = Hang Scr = HangState Group = WalkingStateExceptions 
	SetException Ex = HangMoveRight Scr = HangMoveRightState Group = WalkingStateExceptions 
	SetException Ex = AIR Scr = HangToAirState Group = WalkingStateExceptions 
	SetException Ex = Jump Scr = HangToAirState Group = WalkingStateExceptions 
	SetException Ex = PullUpFromHang Scr = PullUpFromHangState Group = WalkingStateExceptions 
	SetEventHandler Ex = JumpRequested Scr = JumpRequestedEvent Group = WalkingEvents 
	SetWalkingTrickState NewWalkingTrickState = Off 
	LaunchStateChangeEvent State = Skater_InHang 
	Walk_ScaleAnimSpeed HangMove 
	IF Flipped 
		PlayHangMoveAnimCycle HangAnim = HangLeft ReverseAngle 
	ELSE 
		PlayHangMoveAnimCycle HangAnim = HangRight ReverseAngle 
	ENDIF 
ENDSCRIPT

SCRIPT HangMoveRightState 
	ClearExceptionGroup WalkingStateExceptions 
	SetException Ex = Hang Scr = HangState Group = WalkingStateExceptions 
	SetException Ex = HangMoveLeft Scr = HangMoveLeftState Group = WalkingStateExceptions 
	SetException Ex = AIR Scr = HangToAirState Group = WalkingStateExceptions 
	SetException Ex = Jump Scr = HangToAirState Group = WalkingStateExceptions 
	SetException Ex = PullUpFromHang Scr = PullUpFromHangState Group = WalkingStateExceptions 
	SetEventHandler Ex = JumpRequested Scr = JumpRequestedEvent Group = WalkingEvents 
	SetWalkingTrickState NewWalkingTrickState = Off 
	LaunchStateChangeEvent State = Skater_InHang 
	Walk_ScaleAnimSpeed HangMove 
	IF Flipped 
		PlayHangMoveAnimCycle HangAnim = HangRight 
	ELSE 
		PlayHangMoveAnimCycle HangAnim = HangLeft 
	ENDIF 
ENDSCRIPT

SCRIPT HangToAirState 
	ClearExceptionGroup WalkingStateExceptions 
	SetException Ex = Land Scr = LandState Group = WalkingStateExceptions 
	SetException Ex = Hang Scr = AirToHangState Group = WalkingStateExceptions 
	SetException Ex = Ladder Scr = LadderMoveUpState Group = WalkingStateExceptions 
	SetException Ex = Wallplant Scr = WallplantState Group = WalkingStateExceptions 
	ClearException JumpRequested 
	SetWalkingTrickState NewWalkingTrickState = AIR 
	Walk_ScaleAnimSpeed Off 
	PlayWalkAnim Anim = HangIdleToDrop BlendPeriod = 0.05000000075 
	WaitAnimWalking 
	Goto AirState 
ENDSCRIPT

SCRIPT PullUpFromHangState 
	ClearExceptionGroup WalkingStateExceptions 
	SetException Ex = Jump Scr = AirState Group = WalkingStateExceptions 
	SetWalkingTrickState NewWalkingTrickState = Off 
	LaunchStateChangeEvent State = Skater_InHang 
	Walk_ScaleAnimSpeed Off 
	PlayWalkAnim Anim = HangOnToTheTop BlendPeriod = 0.05000000075 Speed = ( walk_parameters . hang_anim_wait_speed ) 
	WaitAnimWalking 
	Walk_AnimWaitComplete 
	PlayWalkAnim Anim = WStand Cycle BlendPeriod = 0.30000001192 
	Goto GroundOrAirWaitState 
ENDSCRIPT

SCRIPT DropToHangState 
	ClearExceptionGroup WalkingStateExceptions 
	SetException Ex = Jump Scr = AirState Group = WalkingStateExceptions 
	SetWalkingTrickState NewWalkingTrickState = Off 
	LaunchStateChangeEvent State = Skater_InHang 
	Walk_ScaleAnimSpeed Off 
	PlayWalkAnim Anim = StandToHang BlendPeriod = 0.30000001192 Speed = ( walk_parameters . hang_anim_wait_speed ) 
	WaitAnimWalking 
	Walk_AnimWaitComplete 
	Goto HangState 
ENDSCRIPT

SCRIPT LadderOntoBottomState 
	ClearExceptionGroup WalkingStateExceptions 
	SetException Ex = Jump Scr = AirState Group = WalkingStateExceptions 
	SetWalkingTrickState NewWalkingTrickState = Off 
	LaunchStateChangeEvent State = Skater_OnLadder 
	Walk_ScaleAnimSpeed Off 
	PlayWalkAnim Anim = LadderClimbFromStandIdle BlendPeriod = 0.30000001192 Speed = ( walk_parameters . ladder_anim_wait_speed ) 
	WaitAnimWalking 
	Walk_AnimWaitComplete 
	Goto LadderMoveUpState 
ENDSCRIPT

SCRIPT LadderOntoTopState 
	ClearExceptionGroup WalkingStateExceptions 
	SetException Ex = Jump Scr = AirState Group = WalkingStateExceptions 
	SetWalkingTrickState NewWalkingTrickState = Off 
	LaunchStateChangeEvent State = Skater_OnLadder 
	Walk_ScaleAnimSpeed Off 
	PlayWalkAnim Anim = LadderOntoTheTop Backwards BlendPeriod = 0.30000001192 Speed = ( walk_parameters . ladder_anim_wait_speed ) 
	WaitAnimWalking 
	Walk_AnimWaitComplete 
	Goto LadderMoveDownState 
ENDSCRIPT

SCRIPT LadderMoveUpState 
	ClearExceptionGroup WalkingStateExceptions 
	SetException Ex = LadderMoveDown Scr = LadderMoveDownState Group = WalkingStateExceptions Params = { SyncToPreviousAnim } 
	SetException Ex = LadderOffBottom Scr = LadderOffBottomState Group = WalkingStateExceptions 
	SetException Ex = LadderOffTop Scr = LadderOffTopState Group = WalkingStateExceptions 
	SetException Ex = Jump Scr = AirState Group = WalkingStateExceptions 
	SetEventHandler Ex = JumpRequested Scr = JumpRequestedEvent Group = WalkingEvents 
	SetWalkingTrickState NewWalkingTrickState = Off 
	LaunchStateChangeEvent State = Skater_OnLadder 
	Walk_ScaleAnimSpeed LadderMove 
	PlayWalkAnim Anim = LadderFastClimb Cycle BlendPeriod = 0.30000001192 <...> 
	WaitAnimWalking 
ENDSCRIPT

SCRIPT LadderMoveDownState 
	ClearExceptionGroup WalkingStateExceptions 
	SetException Ex = LadderMoveUp Scr = LadderMoveUpState Group = WalkingStateExceptions Params = { SyncToPreviousAnim } 
	SetException Ex = LadderOffBottom Scr = LadderOffBottomState Group = WalkingStateExceptions 
	SetException Ex = LadderOffTop Scr = LadderOffTopState Group = WalkingStateExceptions 
	SetException Ex = Jump Scr = AirState Group = WalkingStateExceptions 
	SetEventHandler Ex = JumpRequested Scr = JumpRequestedEvent Group = WalkingEvents 
	SetWalkingTrickState NewWalkingTrickState = Off 
	LaunchStateChangeEvent State = Skater_OnLadder 
	Walk_ScaleAnimSpeed LadderMove 
	PlayWalkAnim Anim = LadderFastClimb Cycle Backwards BlendPeriod = 0.30000001192 <...> 
	WaitAnimWalking 
ENDSCRIPT

SCRIPT LadderOffBottomState 
	ClearExceptionGroup WalkingStateExceptions 
	SetException Ex = Jump Scr = AirState Group = WalkingStateExceptions 
	SetWalkingTrickState NewWalkingTrickState = Off 
	LaunchStateChangeEvent State = Skater_OnLadder 
	Walk_ScaleAnimSpeed Off 
	PlayWalkAnim Anim = LadderClimbFromStandIdle Backwards BlendPeriod = 0.30000001192 Speed = ( walk_parameters . ladder_anim_wait_speed ) 
	WaitAnimWalking 
	Walk_AnimWaitComplete 
	PlayWalkAnim Anim = WStand Cycle BlendPeriod = 0.30000001192 
	Goto GroundOrAirWaitState 
ENDSCRIPT

SCRIPT LadderOffTopState 
	ClearExceptionGroup WalkingStateExceptions 
	SetException Ex = Jump Scr = AirState Group = WalkingStateExceptions 
	SetWalkingTrickState NewWalkingTrickState = Off 
	LaunchStateChangeEvent State = Skater_OnLadder 
	Walk_ScaleAnimSpeed Off 
	PlayWalkAnim Anim = LadderOntoTheTop BlendPeriod = 0.30000001192 Speed = ( walk_parameters . ladder_anim_wait_speed ) 
	WaitAnimWalking 
	Walk_AnimWaitComplete 
	PlayWalkAnim Anim = WStand Cycle BlendPeriod = 0.30000001192 
	Goto GroundOrAirWaitState 
ENDSCRIPT

SCRIPT WalkBailState 
	ClearExceptionGroup WalkingStateExceptions 
	BailSkaterTricks 
	DisablePlayerInput AllowCameraControl 
	InBail 
	Obj_SpawnScript BailBoardControl Params = { BoardOffFrame = 10 BoardVel = VECTOR(0.00000000000, 0.00000000000, 200.00000000000) BoardRotVel = VECTOR(0.00000000000, 0.00000000000, 0.00000000000) BoardSkaterVel = 1 } 
	Walk_ScaleAnimSpeed Off 
	PlayWalkAnim Anim = WalkingBail 
	WaitAnimWalking 
	PlayWalkAnim Anim = WalkingBail PingPong From = End To = 100 Speed = 0.80000001192 BlendPeriod = 0.10000000149 
	WaitForEvent Type = Stand 
	BashOn 
	PlayWalkAnim Anim = WalkingBailGetUp 
	WaitAnimWalking 
	SwitchOnBoard 
	BailDone 
	Goto StandState 
ENDSCRIPT

SCRIPT GroundOrAirWaitState 
	ClearExceptionGroup WalkingStateExceptions 
	SetException Ex = Run Scr = RunState Group = WalkingStateExceptions 
	SetException Ex = Stand Scr = StandState Group = WalkingStateExceptions 
	SetException Ex = Skid Scr = SkidState Group = WalkingStateExceptions 
	SetException Ex = RotateLeft Scr = StandToRotateLeftState Group = WalkingStateExceptions 
	SetException Ex = RotateRight Scr = StandToRotateRightState Group = WalkingStateExceptions 
	SetException Ex = Hang Scr = AirToHangState Group = WalkingStateExceptions 
	SetException Ex = Ladder Scr = LadderMoveUpState Group = WalkingStateExceptions 
	SetException Ex = LadderOntoBottom Scr = LadderOntoBottomState Group = WalkingStateExceptions 
	SetException Ex = LadderOntoTop Scr = LadderOntoTopState Group = WalkingStateExceptions 
	SetException Ex = Land Scr = LandState Group = WalkingStateExceptions 
	SetException Ex = AIR Scr = AirState Group = WalkingStateExceptions 
	SetException Ex = Jump Scr = StandJumpState Group = WalkingStateExceptions 
	SetException Ex = WalkOffEdge Scr = AirState Group = WalkingStateExceptions 
	SetException Ex = DropToHang Scr = DropToHangState Group = WalkingStateExceptions 
	SetException Ex = Rail Scr = WalkingToRailTrick Group = WalkingStateExceptions 
	SetException Ex = AcidDrop Scr = WalkingAirToTransitionTrick Group = WalkingTransitionTrickExceptions 
	SetException Ex = Wallplant Scr = WallplantState Group = WalkingStateExceptions 
	WaitWalking 
ENDSCRIPT

SCRIPT StandToRideState 
	ClearAllWalkingExceptions 
	Goto RideState 
ENDSCRIPT

SCRIPT RideState 
	ClearExceptionGroup WalkingStateExceptions 
	SetException Ex = Stand Scr = RideToStandState Group = WalkingStateExceptions 
	BEGIN 
		Wait 1 GameFrame 
	REPEAT 
ENDSCRIPT

SCRIPT RideToStandState 
	ClearExceptionGroup WalkingStateExceptions 
	Goto StandState 
ENDSCRIPT

SCRIPT CameraFlushButton 
	GetCameraId 
	<CameraId> : WalkCamera_FlushRequest 
ENDSCRIPT

SCRIPT JumpButton 
	LaunchEvent Type = JumpRequested 
ENDSCRIPT

SCRIPT JumpRequestedEvent 
	ClearEventHandler JumpRequested 
	Walk_GetState 
	SWITCH <State> 
		CASE WALKING_GROUND 
			Walk_Jump 
			LaunchEvent Type = Jump 
		CASE WALKING_AIR 
			Walk_GetStateTime 
			IF ( <StateTime> < Skater_Late_Jump_Slop ) 
				Walk_Jump 
				LaunchEvent Type = Jump 
			ENDIF 
		CASE WALKING_HANG 
			Walk_GetStateDuration 
			IF ( <StateDuration> > 0.50000000000 ) 
				Walk_Jump 
				LaunchEvent Type = Jump 
			ELSE 
				Walk_GetPreviousState 
				IF NOT ( <PreviousState> = WALKING_AIR ) 
					Walk_Jump 
					LaunchEvent Type = Jump 
				ELSE 
					SetEventHandler Ex = JumpRequested Scr = JumpRequestedEvent Group = WalkingEvents 
				ENDIF 
			ENDIF 
		CASE WALKING_LADDER 
			Walk_Jump 
			LaunchEvent Type = Jump 
		CASE WALKING_ANIMWAIT 
			Walk_Jump 
			LaunchEvent Type = Jump 
	ENDSWITCH 
ENDSCRIPT

SCRIPT TakeBoardFromSkater 
	SetBoardMissing 
	SwitchOffBoard 
ENDSCRIPT

SCRIPT ReturnBoardToSkater 
	UnsetBoardMissing 
	IF Walking 
		GetTags 
		SWITCH <WalkingTricksState> 
			CASE GROUND 
				SetWalkingGroundTricks 
			CASE AIR 
				SetWalkingAirTricks 
			CASE Off 
				SetWalkingOffTricks 
		ENDSWITCH 
	ENDIF 
	SwitchOnBoard 
	RemoveAnimController Id = BoardMissingPartialAnimOverlay 
ENDSCRIPT


