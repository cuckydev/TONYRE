
SCRIPT WallRide 
	ClearExceptions 
	SetException Ex = Landed Scr = Land Params = { NoBlend IgnoreAirTime } 
	SetException Ex = Ollied Scr = Wallie 
	SetException Ex = GroundGone Scr = WallrideEnd 
	SetException Ex = PointRail Scr = PointRail 
	SetException Ex = SkaterCollideBail Scr = SkaterCollideBail 
	LaunchStateChangeEvent State = Skater_OnWall 
	Vibrate Actuator = 1 Percent = 40 
	Obj_ClearFlag FLAG_SKATER_MANUALCHEESE 
	IF GotParam Left 
		move x = 36 
	ELSE 
		move x = -36 
	ENDIF 
	IF BailIsOn 
		SetState Air 
		Goto Shoulders 
	ENDIF 
	BailOff 
	SetQueueTricks WallRideTricks 
	NollieOff 
	PressureOff 
	SetTrickScore 200 
	PlayCessSound 
	IF GotParam Left 
		IF Flipped 
			IF NOT IsFlipAfterSet 
				BS_Wallride = 1 
			ENDIF 
		ELSE 
			IF IsFlipAfterSet 
				BS_Wallride = 1 
			ENDIF 
		ENDIF 
	ELSE 
		IF NOT Flipped 
			IF NOT IsFlipAfterSet 
				BS_Wallride = 1 
			ENDIF 
		ELSE 
			IF IsFlipAfterSet 
				BS_Wallride = 1 
			ENDIF 
		ENDIF 
	ENDIF 
	IF GotParam BS_Wallride 
		SetTrickName #"BS Wallride" 
		PlayAnim Anim = WallRideBackTrans BlendPeriod = 0.00000000000 
		WaitAnimFinished 
		PlayAnim Anim = WallRideBackLoop BlendPeriod = 0.10000000149 Cycle 
	ELSE 
		SetTrickName #"FS Wallride" 
		PlayAnim Anim = WallRideFrontTrans BlendPeriod = 0.00000000000 
		WaitAnimFinished 
		PlayAnim Anim = WallRideFrontLoop BlendPeriod = 0.10000000149 Cycle 
	ENDIF 
	Display 
	BEGIN 
		TweakTrick 25 
		wait 1 frame 
		DoNextTrick 
	REPEAT 
ENDSCRIPT

SCRIPT WallrideEnd 
	BlendPeriodOut 0 
	SetException Ex = Landed Scr = Land 
	ClearExceptions 
	IF Inair 
		Goto Airborne 
	ENDIF 
ENDSCRIPT

SCRIPT Wallie 
	DoNextTrick 
	Vibrate Actuator = 1 Percent = 50 Duration = 0.10000000149 
	PlayAnim Anim = Ollie BlendPeriod = 0.00000000000 
	SetTrickName #"Wallie" 
	SetTrickScore 250 
	InAirExceptions 
	Display 
	Jump 
	WaitAnimWhilstChecking 
	Goto Airborne BlendPeriod = 0 
ENDSCRIPT

WallRideTricks = 
[ { Trigger = { TapTwiceRelease , Up , x , 500 } Scr = Trick_WallPlant } ] 
SCRIPT Trick_WallPlant 
	InAirExceptions 
	Vibrate Actuator = 1 Percent = 50 Duration = 0.10000000149 
	PlayAnim Anim = Boneless BlendPeriod = 0.00000000000 
	SetTrickName #"WalliePlant" 
	SetTrickScore 500 
	Display 
	Jump BonelessHeight 
	WaitAnimWhilstChecking 
	Goto Airborne BlendPeriod = 0 
ENDSCRIPT

WALLPLANT_WINDOW = 450 
Wallplant_Trick = 
[ 
	{ InOrder , x , Down , WALLPLANT_WINDOW } 
	{ InOrder , x , DownLeft , WALLPLANT_WINDOW } 
	{ InOrder , x , DownRight , WALLPLANT_WINDOW } 
	{ InOrder , Down , x , WALLPLANT_WINDOW } 
	{ InOrder , DownLeft , x , WALLPLANT_WINDOW } 
	{ InOrder , DownRight , x , WALLPLANT_WINDOW } 
] 
Post_Wallplant_No_Ollie_Window = 100 
Post_Wallplant_Allow_Ollie_Window = 250 
WallplantOllie = 
[ 
	{ Trigger = { Tap , x , Post_Wallplant_Allow_Ollie_Window } Scr = Ollie Params = { JumpSpeed = 200 } } 
] 
SCRIPT Air_Wallplant 
	IF BailIsOn 
		SetState Air 
		Goto Shoulders 
	ENDIF 
	PressureOff 
	NollieOff 
	InAirExceptions 
	ClearException Ollied 
	LaunchStateChangeEvent State = Skater_InWallplant 
	Vibrate Actuator = 1 Percent = 100 Duration = 0.10000000149 
	SetTrickName "" 
	SetTrickScore 0 
	Display Blockspin 
	PlayAnim Anim = Wallplant_Ollie3 BlendPeriod = 0 
	SetTrickName #"Wallplant" 
	SetTrickScore 750 
	Display 
	GetStartTime 
	BEGIN 
		GetElapsedTime StartTime = <StartTime> 
		IF ( <ElapsedTime> > Post_Wallplant_No_Ollie_Window ) 
			BREAK 
		ENDIF 
		DoNextTrick 
		wait 1 GameFrame 
	REPEAT 
	ClearEventBuffer Buttons = [ x ] OlderThan = 0 
	SetSkaterAirTricks AllowWallplantOllie 
	GetStartTime 
	BEGIN 
		GetElapsedTime StartTime = <StartTime> 
		IF ( <ElapsedTime> > Post_Wallplant_Allow_Ollie_Window ) 
			BREAK 
		ENDIF 
		DoNextTrick 
		wait 1 GameFrame 
	REPEAT 
	SetSkaterAirTricks 
	WaitAnimWhilstChecking 
	Goto Airborne 
ENDSCRIPT

SCRIPT Ground_Wallpush 
	Init_Wallpush 
	IF Crouched 
		PlayAnim Anim = Wallplant_Crouched BlendPeriod = 0 
	ELSE 
		PlayAnim Anim = Wallplant_Standing BlendPeriod = 0 
	ENDIF 
	BlendPeriodOut 0 
	BoardRotateAfter 
	FlipAfter 
	SetTrickName #"Wallpush" 
	SetTrickScore 10 
	Display Blockspin 
	WaitWhilstChecking AndManuals Duration = Physics_Disallow_Rewallpush_Duration 
	LandSkaterTricks 
	WaitAnimWhilstChecking AndManuals 
	IF AnimEquals Wallplant_Standing 
		IF Crouched 
			PlayAnim Anim = Idle 
			DoNextTrick 
			DoNextManualTrick 
			wait 1 GameFrame 
		ENDIF 
	ENDIF 
	Goto OnGroundAi 
ENDSCRIPT

SCRIPT Manual_CancelWallpushEvent 
	CancelWallpush 
ENDSCRIPT

Wallpush_Trick = { Name = #"Wallpush" Score = 10 NoBlend FlipAfter Anim = Wallplant_NoseManual BalanceAnim = Manual_Range BalanceAnim2 = Manual_Range2 BalanceAnim3 = Manual_Range3 OffMeterTop = ManualBail OffMeterBottom = ManualLand ExtraTricks2 = ManualBranches ExtraTricks = FlatlandBranches AllowWallpush } 
NoseWallpush_Trick = { Name = #"Wallpush" Score = 10 NoBlend FlipAfter Anim = Wallplant_Manual BalanceAnim = NoseManual_Range BalanceAnim2 = NoseManual_Range Nollie OffMeterTop = ManualLand OffMeterBottom = NoseManualBail ExtraTricks2 = NoseManualBranches ExtraTricks = FlatlandBranches AllowWallpush } 
SCRIPT Manual_Wallpush 
	Init_Wallpush 
	BlendPeriodOut 0 
	IF GotParam ToNoseManual 
		Goto ManualLink Params = { NoseWallpush_Trick } 
	ELSE 
		Goto ManualLink Params = { Wallpush_Trick } 
	ENDIF 
ENDSCRIPT

SCRIPT Init_Wallpush 
	BroadcastEvent Type = SkaterWallpush 
	Vibrate Actuator = 1 Percent = 50 Duration = 0.15000000596 
ENDSCRIPT


