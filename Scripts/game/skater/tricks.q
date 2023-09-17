
ExcludeFromSkaterDebug = 
[ 
	waitonegameframe 
	waitanimfinished 
	waitanimwhilstchecking 
	WaitWhilstChecking 
	just_coasting 
	DoCrouch_slope 
	SetClothesInactive 
	SetClothesActive 
	ShutDownWindyBone 
	PlayLeftRightTennisAnim 
	PlayBrakeAnim 
	CessBrake 
	CheckforSwitchVehicles 
	cheese_jump 
	PlayTurnAnimOrTurnIdle 
	SetException 
	SetEventHandler 
	ClearException 
	ClearOnExceptionRun 
	ClearExceptionGroup 
	WaitWalking 
	WaitAnimWalking 
	WaitWalkingFrame 
	WaitAnimWalkingFrame 
	PlaySpeedChosenAnim 
	RunSpeedChosenAnim 
	CycleSpeedChosenAnim 
	hide_run_timer_piece 
	SetExceptionHandler 
	PlayWalkAnim 
	CheckForNetBrake 
] 
CrouchIdles = [ CrouchIdle CrouchIdle CrouchIdle2 CrouchIdle2 CrouchIdle4 CrouchIdle4 CrouchLookDown CrouchLookLeft CrouchLookRight CrouchShiftFoot CrouchIdleAdjustFeet ] 
CrouchTurnRightIdles = [ CrouchTurnRightIdle CrouchTurnRightIdle2 ] 
CrouchTurnLeftIdles = [ CrouchTurnLeftIdle CrouchTurnLeftIdle2 ] 
CrouchTurnRightAnims = [ CrouchTurnRight CrouchTurnRight2 ] 
CrouchTurnLeftAnims = [ CrouchTurnLeft CrouchTurnLeft2 ] 
TurnRightIdles = [ TurnRightIdle ] 
TurnLeftIdles = [ TurnLeftIdle ] 
TurnRightAnims = [ TurnRight ] 
TurnLeftAnims = [ TurnLeft ] 
EXPERT_MODE_NO_REVERTS = 0 
EXPERT_MODE_NO_WALKING = 0 
EXPERT_MODE_NO_MANUALS = 0 
perfect_landing_slop = 5 
SCRIPT DumpSkaterEventHandlerTable 
	PrintEventHandlerTable 
ENDSCRIPT

SCRIPT KillingSkater 
	ClearExceptions 
	ClearExceptionGroup Group = RunTimerEvents 
	ClearExceptionGroup Group = WalkingEndRunEvents 
ENDSCRIPT

SCRIPT SkaterInit 
	ClearAllExceptionGroups 
	IF NOT GotParam no_board 
		SwitchOnBoard 
	ELSE 
		SwitchOffBoard 
	ENDIF 
	Obj_StopStream 
	Unhide 
	UnpausePhysics 
	NotInBail 
	BashOff 
	NollieOff 
	PressureOff 
	NotifyBailDone 
	Obj_KillSpawnedScript name = BailBoardControl 
	SetSkaterCamLerpReductionTimer time = 0 
	ClearLipCombos 
	AllowRailTricks 
	Obj_KillSpawnedScript name = SetUpLipCombo 
	ClearTrickQueues 
	StatsManager_Reset 
	ResetLandedFromVert 
	BlendperiodOut 0 
	PressureOff 
	IF Driving 
		IF ( driving_parked_car = 1 ) 
			IF NOT GotParam InCleanup 
				car_end_driving_run 
			ENDIF 
		ENDIF 
		ToggleUserControlledVehicleMode 
	ENDIF 
	InitializeStateChangeEvent 
	SetTags racemode = none 
	IF NOT GotParam NoEndRun 
		SetException Ex = RunHasEnded Scr = EndOfRun 
		SetException Ex = GoalHasEnded Scr = Goal_EndOfRun 
	ENDIF 
	StopBalanceTrick 
	IF Skitching 
		StopSkitch 
		setstate ground 
	ENDIF 
	SetEventHandler Ex = KillingSkater Scr = KillingSkater Group = KillingSkaterGroup 
	SetEventHandler Ex = DumpSkaterEventHandlerTable Scr = DumpSkaterEventHandlerTable Group = DebugSkaterGroup 
	VibrateOff 
	ClearSkaterFlags 
	SetBoneTransActive bone = breast_cloth_zz 0 
	IF NOT GotParam NoAnims 
		IF NOT ( in_cinematic_sequence = 1 ) 
			PlayAnim Anim = Idle 
		ENDIF 
	ENDIF 
	Obj_KillSpawnedScript name = BloodSmall 
	Obj_KillSpawnedScript name = BloodSplat 
	Obj_KillSpawnedScript name = SkaterBloodOn 
	RunTimerController_Reset 
	ResetSkaterParticleSystems 
	LockVelocityDirection Off 
	CanBrakeOn 
	RestoreAutoKick 
	OverrideLimits End 
	CleanUpExtraProps 
	SetSlomo 1 
	kill_blur 
	KillExtraTricks 
	created_trick_cleanup 
	ClearSkaterCamOverride 
	LandSkaterTricks 
	set_skater_anim_handlers 
	IF GotParam ReturnControl 
		RETURN 
	ENDIF 
	IF IsBoardMissing 
		Walk = 1 
	ENDIF 
	IF NOT GotParam Walk 
		Goto Switch_OnGroundAi Params = { NewScript = OnGroundAi Restart } 
	ELSE 
		Goto Switch_OnGroundAi Params = { NewScript = Walking_OnGroundAi Restart } 
	ENDIF 
ENDSCRIPT

SCRIPT CleanUpExtraProps 
	IF GameModeEquals is_career 
		IF levelis load_alc 
			kill prefix = "ago_ShoppingCart" 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT ClientSkaterInit 
	SwitchOffAtomic special_item 
ENDSCRIPT

SCRIPT OnGroundExceptions 
	ClearExceptions 
	SetException Ex = GroundGone Scr = GroundGone 
	SetException Ex = Ollied Scr = Ollie 
	SetException Ex = FlailHitWall Scr = FlailHitWall 
	SetException Ex = FlailLeft Scr = FlailLeft 
	SetException Ex = FlailRight Scr = FlailRight 
	SetException Ex = Carplant Scr = Carplant 
	SetException Ex = CarBail Scr = CarBail 
	SetException Ex = SkaterCollideBail Scr = SkaterCollideBail 
	SetException Ex = Skitched Scr = Skitch 
	SetException Ex = MadeOtherSkaterBail Scr = MadeOtherSkaterBail 
	SetException Ex = WallPush Scr = Ground_WallPush 
	IF NOT GotParam NoEndRun 
		SetException Ex = RunHasEnded Scr = EndOfRun 
		SetException Ex = GoalHasEnded Scr = Goal_EndOfRun 
		IF GoalManager_GoalShouldExpire 
			ClearException Ollied 
			ClearException GroundGone 
			ClearException WallPush 
		ENDIF 
	ENDIF 
	SetSkaterGroundTricks 
	LaunchStateChangeEvent State = Skater_OnGround 
	VibrateOff 
	SwitchOnBoard 
	EnablePlayerInput 
	BailOff 
	BashOff 
	SetRollingFriction default 
	CanSpin 
	AllowRailTricks 
	SetSkaterCamLerpReductionTimer time = 0 
	Obj_ClearFlag FLAG_SKATER_MANUALCHEESE 
	BloodParticlesOff 
	IF NOT GotParam NoEndRun 
		ResetLandedFromVert 
	ENDIF 
ENDSCRIPT

SCRIPT SetSkaterGroundTricks 
	IF inNetGame 
		IF NOT GetGlobalFlag flag = FLAG_G_EXPERT_MODE_NO_WALKING 
			IF NOT GetGlobalFlag flag = FLAG_EXPERT_MODE_NO_WALKING 
				SetQueueTricks Jumptricks GroundTricks SkateToWalkTricks 
			ELSE 
				SetQueueTricks Jumptricks GroundTricks 
			ENDIF 
		ELSE 
			SetQueueTricks Jumptricks GroundTricks 
		ENDIF 
	ELSE 
		IF NOT GetGlobalFlag flag = FLAG_EXPERT_MODE_NO_WALKING 
			SetQueueTricks Jumptricks GroundTricks SkateToWalkTricks 
		ELSE 
			SetQueueTricks Jumptricks GroundTricks 
		ENDIF 
	ENDIF 
	SetExtraGrindTricks special = SpecialGrindTricks GrindTricks 
	IF NOT GetGlobalFlag flag = FLAG_EXPERT_MODE_NO_MANUALS 
		IF NOT ( ( inNetGame ) & ( GetGlobalFlag flag = FLAG_G_EXPERT_MODE_NO_MANUALS ) ) 
			SetManualTricks special = SpecialManualTricks GroundManualTricks 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT InAirExceptions 
	ClearExceptions 
	SetException Ex = Landed Scr = Land 
	SetException Ex = WallRideLeft Scr = WallRide Params = { Left } 
	SetException Ex = WallRideRight Scr = WallRide Params = { Right } 
	SetException Ex = WallPlant Scr = Air_WallPlant 
	SetException Ex = PointRail Scr = PointRail 
	SetEventHandler Ex = Carplant Scr = Carplant 
	SetException Ex = CarBail Scr = CarBail 
	SetException Ex = SkaterCollideBail Scr = SkaterCollideBail 
	SetEventHandler Ex = MadeOtherSkaterBail Scr = MadeOtherSkaterBailAir 
	SetSkaterAirTricks 
	LaunchStateChangeEvent State = Skater_InAir 
	IF NOT GotParam AllowVibration 
		VibrateOff 
	ENDIF 
	EnablePlayerInput 
	BailOff 
	BashOff 
	SetRollingFriction default 
	setstate Air 
	CanSpin 
	OverrideCancelGround Off 
ENDSCRIPT

SCRIPT SetSkaterAirManualTricks 
	IF NOT GetGlobalFlag flag = FLAG_EXPERT_MODE_NO_MANUALS 
		IF NOT ( ( inNetGame ) & ( GetGlobalFlag flag = FLAG_G_EXPERT_MODE_NO_MANUALS ) ) 
			SetManualTricks special = SpecialManualTricks Manualtricks 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT SetSkaterAirTricks 
	IF InPressure 
		IF NOT GotParam NoSkateToWalkTricks 
			IF ( ( GetGlobalFlag flag = FLAG_EXPERT_MODE_NO_WALKING ) | ( ( inNetGame ) & ( GetGlobalFlag flag = FLAG_G_EXPERT_MODE_NO_WALKING ) ) ) 
				IF NOT GotParam AllowWallplantOllie 
					SetQueueTricks special = SpecialTricks PressureTricks2 AirTricks 
				ELSE 
					SetQueueTricks special = SpecialTricks PressureTricks2 AirTricks WallplantOllie 
				ENDIF 
			ELSE 
				IF NOT GotParam AllowWallplantOllie 
					SetQueueTricks special = SpecialTricks PressureTricks2 AirTricks SkateToWalkTricks 
				ELSE 
					SetQueueTricks special = SpecialTricks PressureTricks2 AirTricks SkateToWalkTricks WallplantOllie 
				ENDIF 
			ENDIF 
		ELSE 
			IF NOT GotParam AllowWallplantOllie 
				SetQueueTricks special = SpecialTricks PressureTricks2 AirTricks 
			ELSE 
				SetQueueTricks special = SpecialTricks PressureTricks2 AirTricks WallplantOllie 
			ENDIF 
		ENDIF 
	ELSE 
		IF NOT GotParam NoSkateToWalkTricks 
			IF ( ( GetGlobalFlag flag = FLAG_EXPERT_MODE_NO_WALKING ) | ( ( inNetGame ) & ( GetGlobalFlag flag = FLAG_G_EXPERT_MODE_NO_WALKING ) ) ) 
				IF NOT GotParam AllowWallplantOllie 
					SetQueueTricks special = SpecialTricks AirTricks 
				ELSE 
					SetQueueTricks special = SpecialTricks AirTricks WallplantOllie 
				ENDIF 
			ELSE 
				IF NOT GotParam AllowWallplantOllie 
					SetQueueTricks special = SpecialTricks AirTricks SkateToWalkTricks 
				ELSE 
					SetQueueTricks special = SpecialTricks AirTricks SkateToWalkTricks WallplantOllie 
				ENDIF 
			ENDIF 
		ELSE 
			IF NOT GotParam AllowWallplantOllie 
				SetQueueTricks special = SpecialTricks AirTricks 
			ELSE 
				SetQueueTricks special = SpecialTricks AirTricks WallplantOllie 
			ENDIF 
		ENDIF 
	ENDIF 
	SetExtraGrindTricks special = SpecialGrindTricks GrindTricks 
	SetSkaterAirManualTricks 
ENDSCRIPT

SCRIPT ClearTrickQueues 
	ClearTrickQueue 
	ClearManualTrick 
	ClearExtraGrindTrick 
ENDSCRIPT

SCRIPT OnGroundAi Coasting = 0 Pushes = 0 PressureTimer = 0 
	IF NOT OnGround 
		setstate ground 
	ENDIF 
	OnGroundExceptions 
	NollieOff 
	BEGIN 
		GetSlope 
		IF LeftPressed 
			IF Crouched 
				IF Flipped 
					PlayTurnAnimOrTurnIdle TurnIdles = CrouchTurnRightIdles TurnAnims = CrouchTurnRightAnims 
				ELSE 
					PlayTurnAnimOrTurnIdle TurnIdles = CrouchTurnLeftIdles TurnAnims = CrouchTurnLeftAnims 
				ENDIF 
			ELSE 
				IF Flipped 
					PlayTurnAnimOrTurnIdle TurnIdles = TurnRightIdles TurnAnims = TurnRightAnims 
				ELSE 
					PlayTurnAnimOrTurnIdle TurnIdles = TurnLeftIdles TurnAnims = TurnLeftAnims 
				ENDIF 
			ENDIF 
		ELSE 
			IF RightPressed 
				IF Crouched 
					IF Flipped 
						PlayTurnAnimOrTurnIdle TurnIdles = CrouchTurnLeftIdles TurnAnims = CrouchTurnLeftAnims 
					ELSE 
						PlayTurnAnimOrTurnIdle TurnIdles = CrouchTurnRightIdles TurnAnims = CrouchTurnRightAnims 
					ENDIF 
				ELSE 
					IF Flipped 
						PlayTurnAnimOrTurnIdle TurnIdles = TurnLeftIdles TurnAnims = TurnLeftAnims 
					ELSE 
						PlayTurnAnimOrTurnIdle TurnIdles = TurnRightIdles TurnAnims = TurnRightAnims 
					ENDIF 
				ENDIF 
			ELSE 
				IF Crouched 
					DoCrouch_slope Slope = <Slope> ChangeInSlope = <ChangeInSlope> 
				ELSE 
					IF Braking 
						IF SpeedLessThan 1 
							PlayBrakeAnim 
							IF HeldLongerThan Button = down 2 second 
								Goto HandBrake 
							ENDIF 
						ELSE 
							IF HeldLongerThan Button = down 0.20000000298 second 
								CessBrake 
							ELSE 
								PlayBrakeAnim 
							ENDIF 
						ENDIF 
					ELSE 
						IF ( <Slope> > PUSH_IF_SLOPE ) 
							IF AutoKickIsOff 
								OnGround_AutoKickOff_UpHill 
							ELSE 
								IF ShouldMongo 
									IF AnimEquals MongoPushCycle 
										PlayAnim Anim = MongoPushCycle Cycle NoRestart 
									ELSE 
										PlayAnim Anim = MongoPush NoRestart 
										waitanimfinished 
										PlayAnim Anim = MongoPushCycle Cycle NoRestart 
									ENDIF 
								ELSE 
									just_coasting 
								ENDIF 
							ENDIF 
						ELSE 
							IF AutoKickIsOff 
								OnGround_AutoKickOff_Flat 
							ELSE 
								just_coasting 
							ENDIF 
						ENDIF 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
		DoNextTrick 
		DoNextManualTrick 
		waitonegameframe 
		IF inNetGame 
			CheckForNetBrake 
		ENDIF 
	REPEAT 
ENDSCRIPT

crouch_wobble_params = { 
	WobbleAmpA = { PAIR(10.10000038147, 10.10000038147) STATS_RAILBALANCE } 
	WobbleAmpB = { PAIR(10.10000038147, 10.10000038147) STATS_RAILBALANCE } 
	WobbleK1 = { PAIR(20.00000000000, 20.00000000000) STATS_RAILBALANCE } 
	WobbleK2 = { PAIR(10.00000000000, 10.00000000000) STATS_RAILBALANCE } 
	SpazFactor = { PAIR(1.00000000000, 1.00000000000) STATS_RAILBALANCE } 
} 
SCRIPT PlayTurnAnimOrTurnIdle 
	IF NOT AnimEquals <TurnIdles> 
		IF NOT AnimEquals <TurnAnims> 
			GetRandomArrayElement <TurnAnims> 
			PlayAnim Anim = <Element> NoRestart 
			SetTags TurnAnimIndex = <index> 
		ENDIF 
		IF AnimFinished 
			GetTags 
			index = <TurnAnimIndex> 
			PlayAnim Anim = ( <TurnIdles> [ <index> ] ) Cycle NoRestart 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT DoCrouch_slope 
	IF ( ( <ChangeInSlope> > 5 ) | ( <ChangeInSlope> < -5 ) ) 
		IF AnimEquals [ CrouchBumpUp CrouchBumpDown ] 
			IF AnimFinished 
				IF ( <ChangeInSlope> > 5 ) 
					PlayAnim Anim = CrouchBumpUp Blendperiod = 0.30000001192 
				ELSE 
					PlayAnim Anim = CrouchBumpDown Blendperiod = 0.30000001192 
				ENDIF 
			ENDIF 
		ELSE 
			IF ( <ChangeInSlope> > 5 ) 
				PlayAnim Anim = CrouchBumpUp Blendperiod = 0.30000001192 
			ELSE 
				PlayAnim Anim = CrouchBumpDown Blendperiod = 0.30000001192 
			ENDIF 
		ENDIF 
	ELSE 
		IF SpeedLessThan 100 
			IF Released down 
				IF NOT AutoKickIsOff 
					PlayAnim Anim = CrouchPush1 NoRestart 
				ENDIF 
			ENDIF 
		ENDIF 
		IF AutoKickIsOff 
			IF SpeedLessThan 600 
				IF Held Square 
					PlayAnim Anim = CrouchPush1 NoRestart 
				ENDIF 
			ENDIF 
		ENDIF 
		IF NOT AnimEquals CrouchIdles CrouchPush1 CrouchBumpUp CrouchBumpDown 
			GetRandomArrayElement CrouchIdles 
			PlayAnim Anim = <Element> NoRestart 
		ELSE 
			IF AnimFinished 
				GetRandomArrayElement CrouchIdles 
				PlayAnim Anim = <Element> NoRestart 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SLOPE_CUTOFF = 40 
PUSH_IF_SLOPE = 2 
SCRIPT just_coasting 
	GetSlope 
	IF ( <Slope> > PUSH_IF_SLOPE ) 
		IF AnimEquals [ MongoPushCycle PushCycle PushCycleArms1 PushCycleArms2 PushCycleArms3 PushCycleArms4 PushCycleArms5 ] 
			IF AnimFinished 
				DoAPush 
			ENDIF 
		ELSE 
			PlayAnim Anim = Idle NoRestart 
		ENDIF 
	ELSE 
		IF AnimEquals [ MongoPushCycle PushCycle PushCycleArms1 PushCycleArms2 PushCycleArms3 PushCycleArms4 PushCycleArms5 ] 
			IF AnimFinished 
				RandomPush = RANDOM_RANGE PAIR(1.00000000000, 2.00000000000) 
				IF ( <RandomPush> < 2 ) 
					DoAPush 
				ELSE 
					PlayAnim Anim = Idle NoRestart 
				ENDIF 
			ENDIF 
		ELSE 
			IF AnimEquals Idle 
				IF AnimFinished 
					RandomPush = RANDOM_RANGE PAIR(1.00000000000, 3.00000000000) 
					IF ( <RandomPush> < 2 ) 
						DoAPush 
					ELSE 
						PlayAnim Anim = Idle 
					ENDIF 
				ENDIF 
			ELSE 
				PlayAnim Anim = Idle NoRestart 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT DoAPush 
	IF ShouldMongo 
		PlayAnim RANDOM(1, 1) RANDOMCASE Anim = MongoPushCycle RANDOMCASE Anim = Idle RANDOMEND NoRestart 
	ELSE 
		IF AnimEquals [ PushCycle PushCycleArms1 PushCycleArms2 PushCycleArms3 PushCycleArms4 PushCycleArms5 ] 
			IF AnimFinished 
				PlayAnim RANDOM(1, 1, 1, 1, 1, 1) RANDOMCASE Anim = PushCycle RANDOMCASE Anim = PushCycleArms1 RANDOMCASE Anim = PushCycleArms2 RANDOMCASE Anim = PushCycleArms3 RANDOMCASE Anim = PushCycleArms4 RANDOMCASE Anim = PushCycleArms5 RANDOMEND NoRestart 
			ENDIF 
		ELSE 
			PlayAnim RANDOM(1, 1, 1, 1, 1, 1) RANDOMCASE Anim = PushCycle RANDOMCASE Anim = PushCycleArms1 RANDOMCASE Anim = PushCycleArms2 RANDOMCASE Anim = PushCycleArms3 RANDOMCASE Anim = PushCycleArms4 RANDOMCASE Anim = PushCycleArms5 RANDOMEND NoRestart 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT CheckForNetBrake 
	IF inNetGame 
		GetPreferenceChecksum pref_type = network auto_brake 
		IF ( <checksum> = boolean_true ) 
			IF ScreenElementExists id = current_menu_anchor 
				Goto NetBrake 
			ENDIF 
			IF ScreenElementExists id = dialog_box_anchor 
				Goto NetBrake 
			ENDIF 
			IF ScreenElementExists id = quit_dialog_anchor 
				Goto NetBrake 
			ENDIF 
			IF ScreenElementExists id = controller_unplugged_dialog_anchor 
				Goto NetBrake 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT PlayBrakeAnim 
	IF ShouldMongo 
		PlayAnim Anim = SlowDownBrake_Mongo NoRestart 
	ELSE 
		PlayAnim Anim = SlowDownBrake NoRestart 
	ENDIF 
ENDSCRIPT

SCRIPT CessBrake 
	ClearEventBuffer 
	IF SpeedGreaterThan 300 
		PlayAnim Anim = CessSlide180_FS From = Start To = 28 Speed = 1.20000004768 
		WaitAnim Frame 5 
		PlayCessSound 
		WaitAnim Frame 25 
		PlayAnim Anim = CessSlide180_FS From = 27 To = Start Speed = 1.20000004768 
		waitanimfinished 
	ENDIF 
	PlayBrakeAnim 
ENDSCRIPT

SCRIPT SlalomBrake 
	BigBrake 
ENDSCRIPT

SCRIPT BigBrake 
	ClearExceptions 
	DisablePlayerInput 
	WaitOnGround 
	SetRollingFriction 20 
	StopSkitch 
	StopBalanceTrick 
	CessBrake 
	wait 1 second 
	Goto SkaterInit 
ENDSCRIPT

SCRIPT OnGround_AutoKickOff_UpHill 
	IF ShouldMongo 
		IF Held Square 
			PlayAnim Anim = MongoPush NoRestart 
			waitanimfinished 
			PlayAnim Anim = MongoPushCycle NoRestart 
			waitanimfinished 
		ENDIF 
		PlayAnim Anim = Idle Cycle NoRestart 
	ELSE 
		IF Held Square 
			PlayAnim RANDOM(1, 1, 1, 1, 1, 1) RANDOMCASE Anim = PushCycle RANDOMCASE Anim = PushCycleArms1 RANDOMCASE Anim = PushCycleArms2 RANDOMCASE Anim = PushCycleArms3 RANDOMCASE Anim = PushCycleArms4 RANDOMCASE Anim = PushCycleArms5 RANDOMEND NoRestart 
			waitanimfinished 
		ENDIF 
		PlayAnim Anim = Idle Cycle NoRestart 
	ENDIF 
ENDSCRIPT

SCRIPT OnGround_AutoKickOff_Flat 
	IF Held Square 
		IF ShouldMongo 
			PlayAnim Anim = MongoPushCycle Cycle NoRestart 
		ELSE 
			PlayAnim RANDOM(1, 1, 1, 1, 1, 1) RANDOMCASE Anim = PushCycle RANDOMCASE Anim = PushCycleArms1 RANDOMCASE Anim = PushCycleArms2 RANDOMCASE Anim = PushCycleArms3 RANDOMCASE Anim = PushCycleArms4 RANDOMCASE Anim = PushCycleArms5 RANDOMEND NoRestart 
			waitanimfinished 
			PlayAnim Anim = Idle Cycle NoRestart 
		ENDIF 
	ELSE 
		IF AnimEquals [ PushCycle MongoPushCycle MongoPush ] 
		ELSE 
			PlayAnim Anim = Idle Cycle NoRestart 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT NetBrake 
	SetRollingFriction 20 
	OnExceptionRun NetBrake_out 
	CessBrake 
	BEGIN 
		IF SpeedLessThan 5 
			HandBrake 
			IF ShouldMongo 
				PlayAnim Anim = MongoBrakeIdle Cycle NoRestart 
			ELSE 
				PlayAnim Anim = BrakeIdle Cycle NoRestart 
			ENDIF 
		ENDIF 
		IF ObjectExists id = current_menu_anchor 
			waitonegameframe 
		ELSE 
			IF ObjectExists id = dialog_box_anchor 
				waitonegameframe 
			ELSE 
				IF ObjectExists id = controller_unplugged_dialog_anchor 
					waitonegameframe 
				ELSE 
					BREAK 
				ENDIF 
			ENDIF 
		ENDIF 
	REPEAT 
	SetRollingFriction default 
	IF SpeedLessThan 5 
		Goto HandBrake 
	ELSE 
		IF InNollie 
			Goto OnGroundNollieAI 
		ELSE 
			Goto OnGroundAi 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT NetBrake_out 
	SetRollingFriction default 
ENDSCRIPT

SCRIPT HandBrake 
	ClearEventBuffer 
	OnExceptionRun BrakeDone 
	SetRollingFriction 100 
	IF ShouldMongo 
		PlayAnim Anim = NewBrake_Mongo 
	ELSE 
		PlayAnim Anim = NewBrake 
	ENDIF 
	BEGIN 
		DoNextTrick 
		IF AnimFinished 
			BREAK 
		ENDIF 
		IF Crouched 
			BREAK 
		ENDIF 
		wait 1 game Frame 
	REPEAT 
	IF ShouldMongo 
		flip 
		BlendperiodOut 0.20000000298 
	ENDIF 
	BEGIN 
		IF AutoKickIsOff 
			IF Held Square 
				waitonegameframe 
				BREAK 
			ENDIF 
		ELSE 
			IF Held up 
				BREAK 
			ENDIF 
			IF Crouched 
				BREAK 
			ENDIF 
		ENDIF 
		IF RightPressed 
			IF Flipped 
				PlayAnim Anim = NewBrakeTurnLeft Cycle NoRestart 
			ELSE 
				PlayAnim Anim = NewBrakeTurnRight Cycle NoRestart 
			ENDIF 
		ELSE 
			IF LeftPressed 
				IF Flipped 
					PlayAnim Anim = NewBrakeTurnRight Cycle NoRestart 
				ELSE 
					PlayAnim Anim = NewBrakeTurnLeft Cycle NoRestart 
				ENDIF 
			ELSE 
				IF AnimEquals [ NewBrakeIdle NewBrakeIdle3 NewBrakeIdle5 NewBrakeIdle6 NewBrakeIdle7 NewBrakeIdle8 ] 
					IF AnimFinished 
						PlayBrakeIdle 
					ENDIF 
				ELSE 
					PlayBrakeIdle 
				ENDIF 
			ENDIF 
		ENDIF 
		waitonegameframe 
		DoNextTrick 
		DoNextManualTrick 
	REPEAT 
	PlayAnim Anim = NewBrakeIdleToIdle 
	wait 0.25000000000 seconds 
	SetRollingFriction default 
	waitanimwhilstchecking 
	IF InNollie 
		Goto OnGroundNollieAI 
	ELSE 
		Goto OnGroundAi 
	ENDIF 
ENDSCRIPT

SCRIPT PlayBrakeIdle 
	PlayAnim RANDOM_NO_REPEAT(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1) RANDOMCASE Anim = NewBrakeIdle 
		RANDOMCASE Anim = NewBrakeIdle 
		RANDOMCASE Anim = NewBrakeIdle 
		RANDOMCASE Anim = NewBrakeIdle 
		RANDOMCASE Anim = NewBrakeIdle2 
		RANDOMCASE Anim = NewBrakeIdle 
		RANDOMCASE Anim = NewBrakeIdle3 
		RANDOMCASE Anim = NewBrakeIdle 
		RANDOMCASE Anim = NewBrakeIdle4 
		RANDOMCASE Anim = NewBrakeIdle5 
		RANDOMCASE Anim = NewBrakeIdle 
		RANDOMCASE Anim = NewBrakeIdle 
		RANDOMCASE Anim = NewBrakeIdle 
		RANDOMCASE Anim = NewBrakeIdle 
		RANDOMCASE Anim = NewBrakeIdle 
		RANDOMCASE Anim = NewBrakeIdle6 
		RANDOMCASE Anim = NewBrakeIdle7 
		RANDOMCASE Anim = NewBrakeIdle8 
		RANDOMCASE Anim = NewBrakeIdle 
	RANDOMCASE Anim = NewBrakeIdle RANDOMEND 
ENDSCRIPT

SCRIPT BrakeDone 
	SetRollingFriction default 
ENDSCRIPT

SCRIPT OnGroundNollieAI 
	setstate ground 
	OnGroundExceptions 
	IF NOT GoalManager_GoalShouldExpire 
		SetException Ex = Ollied Scr = Nollie 
	ENDIF 
	NollieOn 
	BEGIN 
		IF LeftPressed 
			IF Crouched 
				IF Flipped 
					PlayAnim Anim = NollieCrouchTurnRight NoRestart 
				ELSE 
					PlayAnim Anim = NollieCrouchTurnLeft NoRestart 
				ENDIF 
			ELSE 
				IF Flipped 
					PlayAnim Anim = NollieSkatingTurnRight NoRestart 
				ELSE 
					PlayAnim Anim = NollieSkatingTurnLeft NoRestart 
				ENDIF 
			ENDIF 
		ELSE 
			IF RightPressed 
				IF Crouched 
					IF Flipped 
						PlayAnim Anim = NollieCrouchTurnLeft NoRestart 
					ELSE 
						PlayAnim Anim = NollieCrouchTurnRight NoRestart 
					ENDIF 
				ELSE 
					IF Flipped 
						PlayAnim Anim = NollieSkatingTurnLeft NoRestart 
					ELSE 
						PlayAnim Anim = NollieSkatingTurnRight NoRestart 
					ENDIF 
				ENDIF 
			ELSE 
				IF Crouched 
					PlayAnim Anim = NollieCrouchIdle Cycle NoRestart 
				ELSE 
					IF Braking 
						IF SpeedLessThan 1 
							PlayAnim Anim = NollieSkatingIdle NoRestart 
							IF HeldLongerThan Button = down 2 second 
								Goto HandBrake 
							ENDIF 
						ELSE 
							IF HeldLongerThan Button = down 0.20000000298 second 
								CessBrake 
							ELSE 
								PlayBrakeAnim 
							ENDIF 
						ENDIF 
					ELSE 
						IF CanKick 
							IF AutoKickIsOff 
								IF ShouldMongo 
									IF AnimEquals MongoPushCycle 
										PlayAnim Anim = MongoPushCycle NoRestart 
									ELSE 
										PlayAnim Anim = MongoPush NoRestart 
										waitanimfinished 
										PlayAnim Anim = MongoPushCycle NoRestart 
									ENDIF 
								ELSE 
									PlayAnim Anim = PushCycle NoRestart 
								ENDIF 
							ELSE 
								IF ShouldMongo 
									IF AnimEquals MongoPushCycle 
										PlayAnim Anim = MongoPushCycle Cycle NoRestart 
									ELSE 
										PlayAnim Anim = MongoPush NoRestart 
										waitanimfinished 
										PlayAnim Anim = MongoPushCycle Cycle NoRestart 
									ENDIF 
								ELSE 
									PlayAnim Anim = PushCycle Cycle NoRestart 
								ENDIF 
							ENDIF 
						ELSE 
							IF AnimFinished 
								PlayAnim Anim = NollieSkatingIdle Cycle NoRestart 
							ENDIF 
						ENDIF 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
		DoNextTrick 
		DoNextManualTrick 
		CheckForNetBrake 
		waitonegameframe 
	REPEAT 
ENDSCRIPT

SCRIPT FlailExceptions 
	SetException Ex = CarBail Scr = CarBail 
	SetException Ex = SkaterCollideBail Scr = SkaterCollideBail 
	SetException Ex = RunHasEnded Scr = EndOfRun 
	SetException Ex = GoalHasEnded Scr = Goal_EndOfRun 
	IF GoalManager_GoalShouldExpire 
		ClearException Ollied 
		ClearException GroundGone 
		ClearException WallPush 
	ENDIF 
	ClearTrickQueue 
	ClearManualTrick 
	ClearEventBuffer 
	LandSkaterTricks 
	SpawnClothingLandScript 
ENDSCRIPT

SCRIPT FlailHitWall 
	Goto FlailLeft 
ENDSCRIPT

SCRIPT FlailLeft 
	StopBalanceTrick 
	FlailExceptions 
	FlailVibrate 
	IF Crouched 
		IF SpeedGreaterThan 400 
			PlayAnim RANDOM(1, 1) RANDOMCASE Anim = FlailLeftCrouched_small RANDOMCASE Anim = FlailLeftCrouched2 RANDOMEND Blendperiod = 0.02999999933 
		ELSE 
			PlayAnim RANDOM(1, 1) RANDOMCASE Anim = FlailLeftCrouched2 RANDOMCASE Anim = FlailLeftCrouched3 RANDOMEND Blendperiod = 0.02999999933 
		ENDIF 
	ELSE 
		PlayAnim RANDOM(1, 1) RANDOMCASE Anim = FlailLeft RANDOMCASE Anim = FlailLeft2 RANDOMEND Blendperiod = 0.02999999933 
	ENDIF 
	waitanimwhilstchecking 
	IF InNollie 
		Goto OnGroundNollieAI 
	ELSE 
		Goto OnGroundAi 
	ENDIF 
ENDSCRIPT

SCRIPT FlailRight 
	StopBalanceTrick 
	FlailExceptions 
	FlailVibrate 
	IF Crouched 
		IF SpeedGreaterThan 400 
			PlayAnim RANDOM(1, 1) RANDOMCASE Anim = FlailRightCrouched_small RANDOMCASE Anim = FlailRightCrouched2 RANDOMEND Blendperiod = 0.02999999933 
		ELSE 
			PlayAnim RANDOM(1, 1) RANDOMCASE Anim = FlailRightCrouched2 RANDOMCASE Anim = FlailRightCrouched3 RANDOMEND Blendperiod = 0.02999999933 
		ENDIF 
	ELSE 
		PlayAnim RANDOM(1, 1) RANDOMCASE Anim = FlailRight RANDOMCASE Anim = FlailRight2 RANDOMEND Blendperiod = 0.02999999933 
	ENDIF 
	waitanimwhilstchecking 
	IF InNollie 
		Goto OnGroundNollieAI 
	ELSE 
		Goto OnGroundAi 
	ENDIF 
ENDSCRIPT

SCRIPT FlailVibrate 
	IF SpeedGreaterThan 600 
		Vibrate Actuator = 1 Percent = 80 Duration = 0.25000000000 
	ELSE 
		Vibrate Actuator = 1 Percent = 50 Duration = 0.15000000596 
	ENDIF 
ENDSCRIPT

SCRIPT GroundGone 
	InAirExceptions 
	StopBalanceTrick 
	SetException Ex = Ollied Scr = Ollie 
	ClearTricksFrom GroundTricks 
	IF GotParam NoBoneless 
		SetSkaterAirTricks 
	ELSE 
		IF ( ( GetGlobalFlag flag = FLAG_EXPERT_MODE_NO_WALKING ) | ( ( inNetGame ) & ( GetGlobalFlag flag = FLAG_G_EXPERT_MODE_NO_WALKING ) ) ) 
			SetQueueTricks special = SpecialTricks AirTricks Jumptricks JumpTricks0 
		ELSE 
			SetQueueTricks special = SpecialTricks AirTricks Jumptricks JumpTricks0 SkateToWalkTricks 
		ENDIF 
	ENDIF 
	IF Crouched 
		PlayAnim Anim = Crouch2InAir 
	ELSE 
		PlayAnim Anim = Idle2InAir 
	ENDIF 
	WaitAnimWhilstCheckingLateOllie 
	SetSkaterAirTricks 
	ClearException Ollied 
	Goto Airborne 
ENDSCRIPT

SCRIPT WaitAnimWhilstCheckingLateOllie 
	BEGIN 
		IF AirTimeGreaterThan Skater_Late_Jump_Slop 
			RETURN 
		ENDIF 
		DoNextTrick TrickParams = { FromGroundGone } 
		IF AnimFinished 
			RETURN 
		ENDIF 
		wait 1 GameFrame 
	REPEAT 
ENDSCRIPT

SCRIPT WaitFramesLateOllie 
	BEGIN 
		IF ( <Frames> = 0 ) 
			RETURN Frames = 0 
		ENDIF 
		IF AirTimeGreaterThan Skater_Late_Jump_Slop 
			RETURN Frames = <Frames> 
		ENDIF 
		Frames = ( <Frames> - 1 ) 
		wait 1 GameFrame 
	REPEAT 
ENDSCRIPT

SCRIPT TrickOllie 
	Jump 
ENDSCRIPT

AirAnimParams = { Hold Blendperiod = 0.30000001192 NoRestart } 
SCRIPT Airborne Blendperiod = 0.30000001192 
	IF Obj_FlagSet FLAG_SKATER_INLOOP 
		Goto LoopGapStart 
	ENDIF 
	InAirExceptions <...> 
	BEGIN 
		DoNextTrick 
		GetAirTimeLeft 
		IF ( <AirTimeLeft> < 0.40000000596 ) 
			PlayAnim Anim = StretchLegsInit Blendperiod = <Blendperiod> NoRestart 
			BREAK 
		ELSE 
			IF LeftPressed 
				IF Flipped 
					PlayAnim Anim = AirTurnRight AirAnimParams 
				ELSE 
					PlayAnim Anim = AirTurnLeft AirAnimParams 
				ENDIF 
			ELSE 
				IF RightPressed 
					IF Flipped 
						PlayAnim Anim = AirTurnLeft AirAnimParams 
					ELSE 
						PlayAnim Anim = AirTurnRight AirAnimParams 
					ENDIF 
				ELSE 
					IF Held R2 
						PlayAnim Anim = SpineTransfer Blendperiod = 0.30000001192 NoRestart 
					ELSE 
						IF Held L2 
							PlayAnim Anim = SpineTransfer Blendperiod = 0.30000001192 NoRestart 
						ELSE 
							PlayAnim Anim = AirIdle Cycle Blendperiod = <Blendperiod> NoRestart 
						ENDIF 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
		waitonegameframe 
	REPEAT 
	waitanimwhilstchecking 
	BEGIN 
		DoNextTrick 
		waitonegameframe 
	REPEAT 
ENDSCRIPT

SCRIPT Land 
	SetSkaterCamLerpReductionTimer time = 0 
	easy_no_bail = 0 
	IF GetGlobalFlag flag = DIFFICULTY_MODE_TOO_EASY 
		IF NOT inNetGame 
			<easy_no_bail> = 1 
		ENDIF 
	ENDIF 
	IF ( <easy_no_bail> = 1 ) 
		ClearTrickQueue 
		KillExtraTricks 
	ELSE 
		GoalManager_GetDifficultyLevel 
		IF ( <difficulty_level> = 0 ) 
			IF SpeedGreaterThan 500 
				IF YawBetween PAIR(80.00000000000, 100.00000000000) 
					Goto YawBail 
				ENDIF 
			ENDIF 
		ELSE 
			IF SpeedGreaterThan 500 
				IF YawBetween PAIR(60.00000000000, 120.00000000000) 
					Goto YawBail 
				ENDIF 
			ENDIF 
		ENDIF 
		IF AbsolutePitchGreaterThan 60 
			IF PitchGreaterThan 60 
				Goto PitchBail 
			ENDIF 
		ENDIF 
		IF LandedFromSpine 
			GetMatrixNormal 
			IF ( <y> > 0.94999998808 ) 
				Printf "Bailing due to landing from spine onto flat ground" 
				Goto PitchBail 
			ENDIF 
		ENDIF 
		IF RollGreaterThan 50 
			Goto DoingTrickBail 
		ENDIF 
		IF DoingTrick 
			Printf "DOING A TRICK" 
			Goto DoingTrickBail 
		ENDIF 
	ENDIF 
	IF GotParam NoBlend 
		BlendperiodOut 0 
	ENDIF 
	IF GotParam ReturnBacktoLipLand 
	ELSE 
		IF GotParam IgnoreAirTime 
			Goto Land2 Params = { IgnoreAirTime } 
		ELSE 
			IF AirTimeLessThan 0.20000000298 seconds 
				Goto Land2 Params = { LittleAir } 
			ELSE 
				GotoPreserveParams Land2 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT Land2 RevertTime = 5 
	DoPerfectCheck 
	AllowRailTricks 
	NollieOff 
	PressureOff 
	ClearLipCombos 
	IF LandedFromVert 
		OverrideCancelGround 
		Obj_ClearFlag FLAG_SKATER_MANUALCHEESE 
		GetSpeed 
		IF ( <Speed> > 250 ) 
			SetExtraTricks_Reverts Duration = <RevertTime> 
		ENDIF 
		IF AnimEquals [ ToTail_In ToTail_Idle ToTail_Out ] 
			SetTrickName "To Tail" 
			SetTrickScore 500 
			Display 
			CopingHit Terrain = 3 
		ENDIF 
	ELSE 
		DoNextManualTrick FromAir 
	ENDIF 
	Vibrate Actuator = 1 Percent = 80 Duration = 0.10000000149 
	GetAirtime 
	SpawnClothingLandScript 
	IF Crouched 
		IF GotParam LittleAir 
			PlayAnim Anim = CrouchBumpDown 
		ELSE 
			IF Backwards 
				FlipAndRotate 
				PlayAnim RANDOM_NO_REPEAT(1, 1, 1, 1, 1) RANDOMCASE Anim = CrouchedLandTurn RANDOMCASE Anim = CrouchedLandTurn1 RANDOMCASE Anim = CrouchedLandTurn2 RANDOMCASE Anim = CrouchedLandTurn3 RANDOMCASE Anim = StretchLegsLand RANDOMEND Blendperiod = 0.00000000000 
				BoardRotate 
			ELSE 
				IF YawBetween PAIR(45.00000000000, 60.00000000000) 
					IF AirTimeGreaterThan 0.75000000000 second 
						PlayAnim RANDOM(1, 1) RANDOMCASE Anim = SketchyCrouchLand RANDOMCASE Anim = SketchyLand1 RANDOMEND Blendperiod = 0.10000000149 
						IF InSplitScreenGame 
						ELSE 
							LaunchPanelMessage "&C1Sketchy" properties = panelcombo 
						ENDIF 
					ELSE 
						PlayLandAnim <...> 
					ENDIF 
				ELSE 
					PlayLandAnim <...> 
				ENDIF 
			ENDIF 
		ENDIF 
	ELSE 
		IF GotParam LittleAir 
			PlayAnim Anim = IdleBump 
		ELSE 
			IF Backwards 
				FlipAndRotate 
				PlayAnim RANDOM(1, 1, 1, 1) RANDOMCASE Anim = CrouchedLandTurn RANDOMCASE Anim = CrouchedLandTurn1 RANDOMCASE Anim = CrouchedLandTurn2 RANDOMCASE Anim = CrouchedLandTurn3 RANDOMEND Blendperiod = 0 
				BoardRotate 
			ELSE 
				IF YawBetween PAIR(45.00000000000, 60.00000000000) 
					IF AirTimeGreaterThan 0.50000000000 second 
						PlayAnim RANDOM(1, 1) RANDOMCASE Anim = SketchyLand RANDOMCASE Anim = SketchyLand1 RANDOMEND Blendperiod = 0.10000000149 
						IF InSplitScreenGame 
						ELSE 
							LaunchPanelMessage "&C1Sketchy" properties = panelcombo 
						ENDIF 
					ELSE 
						PlayLandAnim <...> 
					ENDIF 
				ELSE 
					PlayLandAnim <...> 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
	ClearTrickQueue 
	ClearEventBuffer buttons = [ X ] 
	SetSkaterAirManualTricks 
	OnGroundExceptions NoEndRun 
	OnExceptionRun LandSkaterTricks 
	IF GoalManager_GoalShouldExpire 
		ClearException Ollied 
		ClearException GroundGone 
		ClearException WallPush 
	ENDIF 
	IF GotParam NoReverts 
	ELSE 
		IF LandedFromVert 
			ResetLandedFromVert 
			BEGIN 
				wait 1 
			REPEAT <RevertTime> 
		ELSE 
			BEGIN 
				DoNextManualTrick FromAir 
				wait 1 
			REPEAT 10 
		ENDIF 
	ENDIF 
	LandSkaterTricks 
	OnGroundExceptions 
	CheckForNetBrake 
	waitanimwhilstchecking AndManuals 
	Goto OnGroundAi 
ENDSCRIPT

SCRIPT PlayLandAnim 
	IF GotParam IgnoreAirTime 
		PlayAnim RANDOM_NO_REPEAT(1, 1, 1, 1, 1) RANDOMCASE Anim = CrouchedLand RANDOMCASE Anim = CrouchedLand1 RANDOMCASE Anim = CrouchedLand2 RANDOMCASE Anim = CrouchedLand3 RANDOMCASE Anim = StretchLegsLand RANDOMEND Blendperiod = 0.10000000149 
	ELSE 
		IF AirTimeLessThan 0.50000000000 seconds 
			PlayAnim Anim = CrouchBumpDown 
		ELSE 
			IF AirTimeLessThan 0.75000000000 seconds 
				PlayAnim RANDOM_NO_REPEAT(1, 1, 1) RANDOMCASE Anim = CrouchedLand1_small RANDOMCASE Anim = CrouchedLand2_small RANDOMCASE Anim = CrouchedLand3_small RANDOMEND Blendperiod = 0.10000000149 
			ELSE 
				PlayAnim RANDOM_NO_REPEAT(1, 1, 1, 1, 1) RANDOMCASE Anim = CrouchedLand RANDOMCASE Anim = CrouchedLand1 RANDOMCASE Anim = CrouchedLand2 RANDOMCASE Anim = CrouchedLand3 RANDOMCASE Anim = StretchLegsLand RANDOMEND Blendperiod = 0.10000000149 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT LandSkaterTricks 
	IF currentscorepotgreaterthan 1500 
		SpawnScript LandPointsSound 
	ENDIF 
	CheckGapTricks 
	ClearGapTricks NotInSameFrame 
	ClearPanel_Landed 
	ClearManualTrick 
	OverrideCancelGround Off 
	ResetSpin 
	Obj_ClearFlag FLAG_SKATER_REVERTCHEESE 
ENDSCRIPT

SCRIPT BailSkaterTricks 
	ClearGapTricks 
	ClearPanel_Bailed 
ENDSCRIPT

SCRIPT DoPerfectCheck 
	IF currentscorepotgreaterthan 1 
		IF YawBetween PAIR(0.00000000000, 5.00000000000) 
			AwardPerfect 
		ENDIF 
		IF YawBetween PAIR(175.00000000000, 180.00000000000) 
			AwardPerfect 
		ENDIF 
		IF YawBetween PAIR(45.00000000000, 60.00000000000) 
			AwardSloppy 
		ENDIF 
		IF YawBetween PAIR(120.00000000000, 135.00000000000) 
			AwardSloppy 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT AwardPerfect 
	GetSpin 
	IF ( <spin> > 359.00000000000 ) 
		IF NOT InSplitScreenGame 
			Create_Panel_Message text = "Perfect Landing!" id = perfect rgba = [ 50 150 50 128 ] pos = PAIR(110.00000000000, 340.00000000000) style = perfect_style 
			Create_Panel_Message text = "+1000 Points" id = perfect2 rgba = [ 40 140 40 100 ] pos = PAIR(110.00000000000, 360.00000000000) style = perfect_style 
		ELSE 
			PerfectSloppy_2p text = "Perfect!" rgb = [ 50 150 50 128 ] 
		ENDIF 
		SetTrickName #"" 
		SetTrickScore 1000 
		Display Blockspin NoDegrade 
		Obj_SpawnScript PlayPerfectSound Params = { sound = PerfectLanding wait = 0.20000000298 pitch = 80 } 
	ENDIF 
ENDSCRIPT

SCRIPT AwardSloppy 
	IF currentscorepotgreaterthan 750 
		GetSpin 
		IF ( <spin> > 359.00000000000 ) 
			IF NOT InSplitScreenGame 
				Create_Panel_Message text = "Sloppy Landing" id = perfect rgba = [ 200 50 50 128 ] pos = PAIR(110.00000000000, 340.00000000000) style = sloppy_style 
				Create_Panel_Message text = "-500 Points" id = perfect2 rgba = [ 107 51 27 100 ] pos = PAIR(110.00000000000, 360.00000000000) style = sloppy_style 
			ELSE 
				PerfectSloppy_2p text = "Sloppy!" rgb = [ 200 50 50 128 ] 
			ENDIF 
			SetTrickName #"" 
			SetTrickScore -500 
			Display Blockspin NoDegrade 
			Obj_SpawnScript PlayPerfectSound Params = { sound = HUDtrickslopC pitch = 150 wait = 0.11999999732 } 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT PlayPerfectSound 
	wait <wait> seconds 
	Playsound <sound> pitch = <pitch> 
ENDSCRIPT

SCRIPT PerfectSloppy_2p 
	ScriptGetScreenMode 
	GetSkaterNumber 
	SWITCH <screen_mode> 
		CASE split_vertical 
			SWITCH <skaternumber> 
				CASE 0 
					Create_Panel_Message text = <text> id = perfect rgba = <rgb> pos = PAIR(70.00000000000, 340.00000000000) style = perfect_style 
				CASE 1 
					Create_Panel_Message text = <text> id = perfect_p2 rgba = <rgb> pos = PAIR(370.00000000000, 340.00000000000) style = perfect_style 
			ENDSWITCH 
		CASE split_horizontal 
			SWITCH <skaternumber> 
				CASE 0 
					Create_Panel_Message text = <text> id = perfect rgba = <rgb> pos = PAIR(70.00000000000, 154.00000000000) style = perfect_style 
				CASE 1 
					Create_Panel_Message text = <text> id = perfect_p2 rgba = <rgb> pos = PAIR(70.00000000000, 375.00000000000) style = perfect_style 
			ENDSWITCH 
	ENDSWITCH 
ENDSCRIPT

SCRIPT perfect_style 
	DoMorph time = 0 scale = PAIR(0.00000000000, 0.00000000000) 
	DoMorph time = 0.10000000149 scale = PAIR(0.94999998808, 0.94999998808) 
	DoMorph time = 0.10000000149 scale = PAIR(0.75000000000, 0.75000000000) 
	DoMorph time = 0.10000000149 scale = PAIR(0.80000001192, 0.80000001192) 
	DoMorph time = 0.05000000075 alpha = 0 
	DoMorph time = 0.05000000075 alpha = 1 
	DoMorph time = 0.05000000075 alpha = 0 
	DoMorph time = 0.05000000075 alpha = 1 
	DoMorph time = 0.05000000075 alpha = 0 
	DoMorph time = 0.05000000075 alpha = 1 
	DoMorph time = 1.20000004768 alpha = 0 
	die 
ENDSCRIPT

SCRIPT sloppy_style 
	DoMorph time = 0 scale = PAIR(0.00000000000, 0.00000000000) 
	DoMorph time = 0.10000000149 scale = PAIR(0.80000001192, 0.80000001192) 
	DoMorph time = 0.01999999955 alpha = 0 
	DoMorph time = 0.05000000075 alpha = 1 
	DoMorph time = 0.05000000075 alpha = 0 
	DoMorph time = 0.02999999933 alpha = 1 
	DoMorph time = 0.05000000075 alpha = 0 
	DoMorph time = 0.05000000075 alpha = 1 
	DoMorph time = 0.03999999911 alpha = 0 
	DoMorph time = 0.05000000075 alpha = 1 
	DoMorph time = 0.05000000075 alpha = 0 
	DoMorph time = 0.01999999955 alpha = 1 
	DoMorph time = 1 alpha = 0 
	die 
ENDSCRIPT

SCRIPT WaitOnGround 
	BEGIN 
		IF OnGround 
			BREAK 
		ENDIF 
		waitonegameframe 
	REPEAT 
ENDSCRIPT

SCRIPT VibrateOff 
	Vibrate Off 
ENDSCRIPT

SCRIPT EndOfRun_WalkingEvent 
	IF currentscorepotgreaterthan 0 
		RETURN 
	ENDIF 
	MakeSkaterGoto EndOfRun 
ENDSCRIPT

SCRIPT Goal_EndOfRun_WalkingEvent 
	IF currentscorepotgreaterthan 0 
		RETURN 
	ENDIF 
	Goal_EndOfRun 
ENDSCRIPT

SCRIPT SlowSkaterToStop 
	MakeSkaterGoto EndOfRun 
	WaitForEvent Type = EndofRunDone 
ENDSCRIPT

SCRIPT EndOfRun 
	ClearExceptions 
	IF Walking 
		ClearAllWalkingExceptions 
	ENDIF 
	EndOfRunStarted 
	CleanUpSpecialItems 
	StopBalanceTrick 
	LandSkaterTricks 
	ClearEventBuffer 
	LaunchStateChangeEvent State = Skater_EndOfRun 
	SetException Ex = LostGame Scr = LostGame 
	DisablePlayerInput AllowCameraControl 
	IF Skating 
		setstate ground 
		IF NOT GotParam NoBrake 
			SetException Ex = SkaterCollideBail Scr = EndBail 
			WaitOnGround 
			SetRollingFriction 19 
			wait 10 Frames 
			WaitOnGround 
			IF SpeedGreaterThan 250 
				PlayCessSound 
				PlayAnim Anim = CessSlide180_FS 
				WaitAnim 50 Percent 
				PlayAnim Anim = CessSlide180_FS From = Current To = 0 
				Obj_WaitAnimFinished 
			ELSE 
				PlayAnim Anim = brake Blendperiod = 0.30000001192 
				Obj_WaitAnimFinished 
			ENDIF 
			PlayAnim Anim = BrakeIdle Blendperiod = 0.30000001192 Cycle 
			BEGIN 
				SetRollingFriction 19 
				IF SpeedLessThan 40 
					IF OnGround 
						BREAK 
					ENDIF 
				ENDIF 
				waitonegameframe 
			REPEAT 
		ENDIF 
	ELSE 
		IF Walking 
			IF NOT GotParam NoBrake 
				IF Walk_Ground 
					Walk_ScaleAnimSpeed Off 
					IF SpeedGreaterThan ( walk_parameters . max_slow_walk_speed ) 
						PlayAnim Anim = _180RunSkid NoRestart Blendperiod = 0.00000000000 
						Obj_WaitAnimFinished 
					ENDIF 
					PlayAnim Anim = WStand NoRestart Cycle Blendperiod = 0.30000001192 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
	IF inNetGame 
		SetException Ex = WonGame Scr = WonGame 
		SetException Ex = LostGame Scr = LostGame 
	ENDIF 
	wait 1 seconds 
	FireEvent Type = EndofRunDone 
	IF NOT GotParam FromTaxiGuy 
		EndofRunDone 
	ENDIF 
	IF inNetGame 
		IF NOT GameIsOver 
			IF NOT GameModeEquals is_king 
				IF NOT GameModeEquals is_score_challenge 
					IF NOT GotParam FromTaxiGuy 
						IF NOT GameModeEquals is_goal_attack 
							wait 1 seconds 
							IF GameModeEquals is_firefight 
								IF NOT IsObserving 
									Skater : remove_skater_from_world 
								ENDIF 
								Create_Panel_Message id = goal_message text = "You\'ve been eliminated!" style = panel_message_generic_loss time = 5000 
							ELSE 
								Create_Panel_Message id = goal_message text = "Waiting for others to finish. Press \\m0 to observe" style = panel_message_generic_loss time = 2000 
							ENDIF 
							IF NOT IsObserving 
								EnterSurveyorMode 
							ENDIF 
						ENDIF 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT Goal_EndOfRun 
	ClearExceptions 
	ClearExceptionGroup WalkingEndRunEvents 
	Goal_EndOfRunStarted 
	CleanUpSpecialItems 
	StopBalanceTrick 
	LandSkaterTricks 
	ClearEventBuffer 
	FireEvent Type = EndofRunDone 
	IF NOT GotParam FromTaxiGuy 
		Goal_EndOfRunDone 
	ENDIF 
	IF inNetGame 
		IF GameIsOver 
		ELSE 
			IF GameModeEquals is_king 
			ELSE 
				IF NOT GotParam FromTaxiGuy 
					IF NOT GameModeEquals is_goal_attack 
						Create_Panel_Message id = goal_message text = "Waiting for other players to finish their runs..." style = panel_message_generic_loss 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT ForceEndOfRun 
	VibrateOff 
	MakeSkaterGoto EndOfRun 
ENDSCRIPT

SCRIPT WonGame 
	IF Skating 
		PlayAnim RANDOM(1, 1) RANDOMCASE Anim = Prop RANDOMCASE Anim = Cheer1 RANDOMEND Blendperiod = 0.30000001192 
		EndofRunDone 
		waitanimfinished 
		IF ShouldMongo 
			PlayAnim Anim = MongoBrakeIdle Cycle 
		ELSE 
			PlayAnim Anim = BrakeIdle Cycle 
		ENDIF 
	ELSE 
		EndofRunDone 
	ENDIF 
ENDSCRIPT

SCRIPT LostGame 
	IF Skating 
		PlayAnim Anim = BrakeDefeat 
		waitanimfinished 
		EndofRunDone 
		IF ShouldMongo 
			PlayAnim Anim = MongoBrakeIdle Cycle 
		ELSE 
			PlayAnim Anim = BrakeIdle Cycle 
		ENDIF 
		waitanimfinished 
	ELSE 
		EndofRunDone 
	ENDIF 
ENDSCRIPT

SCRIPT EndBail 
	EndofRunDone 
	ClearExceptions 
	InBail 
	TurnToFaceVelocity 
	VibrateOff 
	PlayAnim Anim = SlipForwards NoRestart Blendperiod = 0.30000001192 
	wait 10 Frames 
	SwitchOffBoard 
	wait 10 Frame 
	wait 10 Frames 
	SetRollingFriction 18 
	Vibrate Actuator = 1 Percent = 100 Duration = 0.20000000298 
	IF NOT GetGlobalFlag flag = BLOOD_OFF 
		Obj_SpawnScript BloodSmall 
	ENDIF 
	WaitAnim 25 Percent fromend 
	waitanimfinished 
	PlayAnim Anim = GetUpForwards Blendperiod = 0.10000000149 
	SetRollingFriction 20 
	wait 50 Frames 
	SwitchOnBoard 
	BoardRotate normal 
	waitanimfinished 
	NotifyBailDone 
	NotInBail 
	Goto EndOfRun 
ENDSCRIPT

SCRIPT Carplant 
	StopBalanceTrick 
	ClearExceptions 
	InAirExceptions 
	ClearException Carplant 
	Playsound GrindMetalOn RANDOM(1, 1, 1) RANDOMCASE pitch = 80 RANDOMCASE pitch = 90 RANDOMCASE pitch = 85 RANDOMEND 
	Obj_SpawnScript CarSparks 
	DoCarPlantBoost 
	SetTrickName "Car Plant" 
	SetTrickScore 400 
	Display 
	IF DoingTrick 
	ELSE 
		PlayAnim Anim = Beanplant Blendperiod = 0.30000001192 
		waitanimwhilstchecking 
		Goto Airborne 
	ENDIF 
ENDSCRIPT

SCRIPT CarSparks 
	SetSparksTruckFromNollie 
	SparksOn 
	wait 0.33300000429 seconds 
	SetException Ex = Carplant Scr = Carplant 
	wait 3 seconds 
	SparksOff 
ENDSCRIPT

SCRIPT FreezeSkater 
	SwitchOnBoard 
	ClearExceptions 
	SetQueueTricks NoTricks 
	DisablePlayerInput 
	SetRollingFriction 10000 
	PlayAnim Anim = StandIdle Cycle 
ENDSCRIPT

SCRIPT CarBail 
	StopBalanceTrick 
	InBail 
	Obj_SpawnScript BloodCar 
	Playsound BonkMetal_11 
	Playsound RANDOM(1, 1, 1) RANDOMCASE hitblood01 RANDOMCASE hitblood02 RANDOMCASE hitblood03 RANDOMEND 
	Goto NoseManualBail 
ENDSCRIPT

SCRIPT FlailingFall 
	InBail 
	ClearExceptions 
	SetQueueTricks NoTricks 
	DisablePlayerInput AllowCameraControl 
	PlayAnim Anim = StretchtoFlailingFall Blendperiod = 0.30000001192 
	BailSkaterTricks 
	WaitAnim 90 Percent 
	SwitchOffBoard 
	waitanimfinished 
	PlayAnim Anim = FlailingFall Cycle 
ENDSCRIPT

SCRIPT DropIn DropInAnim = DropIn 
	Printf "DropIn" 
	IF GameModeEquals is_horse 
		Printf "**** IN DROPIN ****" 
		GetCurrentSkaterID 
		KenTest1 
		printstruct <...> 
		IF NOT IsCurrentHorseSkater <objId> 
			Printf "**** WASN\'T CURRENT HORSE PLAYER ****" 
			RETURN 
		ENDIF 
	ENDIF 
	ResetSkaterParticleSystems 
	PausePhysics 
	RestartSkaterExceptions 
	SetSkaterCamOverride heading = 0 tilt = -0.75000000000 time = 0.00000100000 zoom = 5 
	OnExitRun DropIn_Cleanup 
	SetRollingFriction 10000 
	DisablePlayerInput 
	PlayAnim Anim = <DropInAnim> Blendperiod = 0.00000000000 
	WaitAnim 60 Percent 
	ClearSkaterCamOverride 
	WaitAnim 85 Percent 
	UnpausePhysics 
	setstate ground 
	SetRollingFriction 0 
	waitanimfinished 
	EnablePlayerInput 
	OnGroundExceptions 
	waitonegameframe 
	SetLandedFromVert 
	Goto Land 
ENDSCRIPT

SCRIPT DropIn_Cleanup 
	ClearSkaterCamOverride 
	EnablePlayerInput 
	SetRollingFriction default 
ENDSCRIPT

SCRIPT ZoomIn 
	Skater : SetSkaterCamOverride heading = 0 time = 0.00001000000 zoom = 1.03999996185 
ENDSCRIPT

SCRIPT ZoomOut 
	Skater : ClearSkaterCamOverride 
ENDSCRIPT

SCRIPT StartSkating1 
	RestartSkaterExceptions 
	SetRollingFriction default 
	DisablePlayerInput AllowCameraControl 
	IF ProfileEquals is_named = mullen 
		SetRollingFriction 10000 
		PlayAnim Anim = MullenStart Blendperiod = 0.00000000000 
		WaitAnim 40 Percent 
		Playsound boneless09 pitch = 110 
		PlayBonkSound 
		BlendperiodOut 0 
		WaitAnim 60 Percent 
		SetRollingFriction default 
	ELSE 
		IF NOT Flipped 
			flip 
		ENDIF 
		IF AutoKickIsOff 
			IF ShouldMongo 
				PlayAnim Anim = MongoBrakeIdle 
			ELSE 
				PlayAnim Anim = BrakeIdle 
			ENDIF 
		ELSE 
			PlayAnim Anim = StartSkating1 Blendperiod = 0.00000000000 
			WaitAnim 75 Percent 
		ENDIF 
	ENDIF 
	ClearSkaterCamOverride 
	EnablePlayerInput 
	OnGroundExceptions 
	waitanimfinished 
	Goto OnGroundAi 
ENDSCRIPT

SCRIPT PedProps name = "Ped Props" score = 500 
	IF InSplitScreenGame 
	ELSE 
		LaunchPanelMessage "Spectator Bonus" properties = Panelcombo2 
	ENDIF 
	IF NOT GetGlobalFlag flag = SOUNDS_SPECIALSOUNDS_OFF 
		Playsound ExtraTrick Vol = 100 
	ENDIF 
	SetTrickName <name> 
	SetTrickScore <score> 
	Display Blockspin 
	waitonegameframe 
	IF OnGround 
		IF DoingTrick 
		ELSE 
			LandSkaterTricks 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT RestartSkaterExceptions 
	AllowRailTricks 
	BoardRotate normal 
	ClearExceptions 
	ClearTrickQueue 
	SetQueueTricks NoTricks 
	ClearManualTrick 
	ClearEventBuffer 
	SwitchOnBoard 
ENDSCRIPT

SCRIPT LaunchSpecialMessage text = "Special Trick" Vol = 100 pitch = 100 
	IF InMultiplayergame 
		IF NOT GetGlobalFlag flag = SOUNDS_SPECIALSOUNDS_OFF 
			Playsound HUD_specialtrickAA Vol = <Vol> pitch = <pitch> 
		ENDIF 
	ELSE 
		IF ( GetGlobalFlag flag = CHEAT_COOL_SPECIAL_TRICKS ) 
			IF GotParam Cool 
				SetSlomo 0.60000002384 
				pulse_blur Start = 0 End = 150 Speed = 10 
				IF NOT GetGlobalFlag flag = SOUNDS_SPECIALSOUNDS_OFF 
					Playsound HUD_specialtrickAA Vol = 200 pitch = 75 
				ENDIF 
				OnExceptionRun KillSpecial 
			ELSE 
				IF NOT GetGlobalFlag flag = SOUNDS_SPECIALSOUNDS_OFF 
					Playsound HUD_specialtrickAA Vol = <Vol> pitch = <pitch> 
				ENDIF 
			ENDIF 
		ELSE 
			IF NOT GetGlobalFlag flag = SOUNDS_SPECIALSOUNDS_OFF 
				Playsound HUD_specialtrickAA Vol = <Vol> pitch = <pitch> 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT EndSpecial 
	IF ( GetGlobalFlag flag = CHEAT_COOL_SPECIAL_TRICKS ) 
		pulse_blur Start = 150 End = 0 time = 10 
		SetSlomo 1 
	ENDIF 
ENDSCRIPT

SCRIPT KillSpecial 
	kill_blur 
	SetSlomo 1 
ENDSCRIPT

SCRIPT LaunchExtraMessage text = "Hidden Combo!" 
	IF NOT GetGlobalFlag flag = SOUNDS_SPECIALSOUNDS_OFF 
		Playsound ExtraTrick Vol = 80 
	ENDIF 
ENDSCRIPT

SCRIPT PedKnockDown 
	IF ObjectExists id = speech_box_anchor 
		DestroyScreenElement id = speech_box_anchor 
	ENDIF 
	IF ObjectExists id = goal_start_dialog 
		DestroyScreenElement id = goal_start_dialog 
	ENDIF 
	Obj_SpawnScript BloodSmall 
	IF Skating 
		SetRollingFriction 0 
		StopBalanceTrick 
		IF OnLip 
			StopBalanceTrick 
			setstate Air 
			Move z = 1 
			Move y = 1 
		ENDIF 
		IF GotParam Jump 
			SetSpeed -150 
			wait 1 game Frame 
			Jump 
			FlipAndRotate 
			GotoRandomScript [ Faceplant Facesmash NoseManualBail ManualBail Hipper TailslideOut ] 
		ENDIF 
		IF Backwards 
			GotoRandomScript [ BackwardFaceSlam Shoulders ] 
		ELSE 
			IF Onrail 
				Goto FiftyFiftyFall 
			ELSE 
				GotoRandomScript [ Faceplant LandPartiallyOnBoard Facesmash NoseManualBail ManualBail Hipper Spasmodic TailslideOut ] 
			ENDIF 
		ENDIF 
	ELSE 
		Goto WalkBailState 
	ENDIF 
ENDSCRIPT

SCRIPT SkaterAvoidGoalPed 
	IF GotParam heading 
		Skater : Rotate y = <heading> 
	ENDIF 
	IF NOT Skater : SpeedGreaterThan 100 
		Skater : SetSpeed <Speed> 
	ENDIF 
	SetException Ex = CarBail Scr = CarBail 
	SetException Ex = SkaterCollideBail Scr = SkaterCollideBail 
	Skater : FlailVibrate 
	Skater : NollieOff 
	Skater : StopBalanceTrick 
	Skater : Obj_PlaySound RANDOM(1) RANDOMCASE RANDOMEND BailSlap03 
	IF NOT Skater : Walking 
		MakeSkaterGoto FlailHitWall 
	ENDIF 
ENDSCRIPT

SCRIPT SkaterBreakGlass 
	SetException Ex = CarBail Scr = CarBail 
	SetException Ex = SkaterCollideBail Scr = SkaterCollideBail 
	FlailVibrate 
	NollieOff 
	PressureOff 
	StopBalanceTrick 
	IF AnimEquals [ CrouchIdle SkateIdle Land MongoPushCycle PushCycle ] 
		Goto FlailHitWall 
	ENDIF 
	IF AnimEquals [ runout runoutquick Smackwallupright ] 
		Goto Bailsmack Params = { SmackAnim = Smackwallupright } 
	ENDIF 
	IF InAir 
		Goto Airborne 
	ELSE 
		IF IsInBail 
			IF AnimEquals [ Smackwallfeet NutterFallBackward FiftyFiftyFallBackward BackwardsTest BackwardFaceSlam Smackwallfeet SlipBackwards ] 
				Goto Bailsmack Params = { SmackAnim = Smackwallfeet } 
			ELSE 
				Goto Bailsmack Params = { <...> } 
			ENDIF 
		ENDIF 
		Goto OnGroundAi 
	ENDIF 
ENDSCRIPT

TRANSFER_POINTS = 250 
ACID_DROP_POINTS = 250 
ACID_BOMB_POINTS = 350 
SCRIPT SkaterAwardTransfer name = "Spine Transfer" 
	SetTrickName <name> 
	SetTrickScore TRANSFER_POINTS 
	Display NoDegrade 
	LaunchSubStateEntryEvent SubState = Transfer 
	IF NOT DoingTrick 
		GetTags 
		IF ( <racemode> = none ) 
			setstate Air 
			InAirExceptions 
			PlayAnim Anim = SpineTransfer 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT SkaterAwardHipTransfer 
	SkaterAwardTransfer name = "Hip Transfer" 
ENDSCRIPT

SCRIPT SkaterAcidDropTriggered 
	LaunchSubStateEntryEvent SubState = AcidDrop 
	SetTrickName #"Acid Drop" 
	IF ( <DropHeight> < 350 ) 
		SetTrickScore ACID_DROP_POINTS 
	ELSE 
		SetTrickScore ACID_BOMB_POINTS 
	ENDIF 
	Display NoDegrade 
ENDSCRIPT

SCRIPT PlayAnim_InLoop 
	IF AnimEquals <Anim> 
		IF NOT AnimFinished <Anim> 
			PlayAnim Anim = <Anim> NoRestart 
		ELSE 
			PlayAnim Anim = <Cycle> Cycle NoRestart 
		ENDIF 
	ELSE 
		PlayAnim Anim = <Cycle> Cycle NoRestart 
	ENDIF 
ENDSCRIPT

SCRIPT MakeSkaterFly 
	MakeSkaterGoto FlyAi 
ENDSCRIPT

SCRIPT FlyAi Move = 8 
	ClearExceptions 
	SetQueueTricks NoTricks 
	SetSpeed 0 
	setstate Air 
	SetRollingFriction 1000 
	NoRailTricks 
	BEGIN 
		IF Held R2 
			Jump 
			wait 8 Frames 
		ENDIF 
		IF Held L1 
			BREAK 
		ENDIF 
		IF Held L2 
			IF Held Square 
				Move X = 18 
			ENDIF 
			IF Held Circle 
				Move X = -18 
			ENDIF 
			IF Held Triangle 
				Move z = 18 
			ENDIF 
			IF Held X 
				Move z = -18 
			ENDIF 
		ELSE 
			IF Held Square 
				Move X = 6 
			ENDIF 
			IF Held Circle 
				Move X = -6 
			ENDIF 
			IF Held Triangle 
				Move z = 8 
			ENDIF 
			IF Held X 
				Move z = -8 
			ENDIF 
		ENDIF 
		waitonegameframe 
	REPEAT 
	AllowRailTricks 
	MakeSkaterGoto OnGroundAi 
ENDSCRIPT


