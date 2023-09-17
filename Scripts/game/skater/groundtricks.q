
TRICK_PRELOAD_TIME = 160 
Jumptricks0 = 
[ { Trigger = { PressAndRelease , Up , X , 300 } Scr = NoComply Params = { Name = #"No Comply" Score = 100 } } ] 
Jumptricks = 
[ { Trigger = { TapTwiceRelease , Up , X , 500 } TrickSlot = JumpSlot } ] 
Trick_Boneless = { Scr = Boneless Params = { Name = #"Boneless" Anim = Boneless Score = 250 } } 
Trick_Fastplant = { Scr = Boneless Params = { Name = #"Fastplant" Anim = Fastplant Score = 250 } } 
Trick_Beanplant = { Scr = Boneless Params = { Name = #"Beanplant" Anim = Beanplant Score = 250 } } 
GroundTricks = 
[ 
	{ Trigger = { TripleInOrder , a = Down , b = Down , R1 , 333 } Scr = ToggleSwitchRegular Params = { PowerSlide } } 
	{ Trigger = { PressAndRelease , Up , X , 300 } Scr = NoComply Params = { Name = #"No Comply" Score = 100 } } 
	{ Trigger = { TripleInOrder , a = L1 , b = L1 , Triangle , 500 } Scr = Props Params = { string_id = props_string } } 
	{ Trigger = { TripleInOrder , a = L1 , b = L1 , Square , 500 } Scr = Taunt Params = { Anim = Taunt1 string_id = your_daddy_string } } 
	{ Trigger = { TripleInOrder , a = L1 , b = L1 , Circle , 500 } Scr = Taunt Params = { Anim = Taunt2 string_id = no_way_string } } 
	{ Trigger = { TripleInOrder , a = L1 , b = L1 , X , 500 } Scr = Taunt Params = { Anim = Taunt3 string_id = get_some_string } } 
	{ Trigger = { Press , R2 , 20 } Scr = ToggleSwitchRegular NGC_Trigger = { Press , R1 , 20 } } 
	{ Trigger = { Press , L2 , 20 } Scr = ToggleNollieRegular NGC_Trigger = { Press , L1 , 20 } } 
] 
WalkToSkateTransition_GroundTricks = 
[ 
	{ Trigger = { Press , L2 , 20 } Scr = WalkToSkateTransition_ToggleStance NGC_Trigger = { Press , L1 , 20 } } 
	{ Trigger = { PressAndRelease , Up , X , 300 } Scr = NoComply Params = { Name = #"No Comply" Score = 100 } } 
] 
NoTricks = 
[ 
] 
Reverts = 
[ 
	{ Trigger = { Press , R2 , 200 } TrickSlot = ExtraSlot1 NGC_Trigger = { Press , R1 , 200 } } 
	{ Trigger = { Press , L2 , 200 } TrickSlot = ExtraSlot2 NGC_Trigger = { Press , L1 , 200 } } 
] 
SCRIPT SetExtraTricks_Reverts duration = 20 
	IF NOT GetGlobalFlag flag = FLAG_EXPERT_MODE_NO_REVERTS 
		IF NOT ( ( inNetGame ) & ( GetGlobalFlag flag = FLAG_G_EXPERT_MODE_NO_REVERTS ) ) 
			SetExtraTricks tricks = Reverts duration = <duration> 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT Revert FSName = #"FS Revert" BSName = #"BS Revert" FSAnim = RevertFS BSAnim = RevertBS 
	OnExitRun ExitRevert 
	ClearLipCombos 
	KillExtraTricks 
	SetTrickScore 100 
	OnGroundExceptions NoEndRun 
	LaunchStateChangeEvent State = Skater_InRevert 
	IF NOT GetGlobalFlag flag = CHEAT_HOVERBOARD 
		Obj_SpawnScript CessTrail Params = { repeat_times = 10 } 
		PlayCessSound 
		Vibrate Actuator = 0 Percent = 80 duration = 0.50000000000 
		Vibrate Actuator = 1 Percent = 80 duration = 0.10000000149 
	ENDIF 
	ClearException Ollied 
	SetSpecialFriction [ 0 , 0 , 5 , 10 , 15 , 25 ] duration = 0.66699999571 
	CanKickOff 
	SetQueueTricks NoTricks 
	SetSkaterAirManualTricks 
	NollieOff 
	PressureOff 
	IF Obj_FlagSet FLAG_SKATER_REVERTFS 
		Obj_ClearFlag FLAG_SKATER_REVERTFS 
		PlayAnim Anim = <FSAnim> 
		SetTrickName <FSName> 
	ELSE 
		IF Obj_FlagSet FLAG_SKATER_REVERTBS 
			Obj_ClearFlag FLAG_SKATER_REVERTBS 
			PlayAnim Anim = <BSAnim> 
			SetTrickName <BSName> 
		ELSE 
			IF LastSpinWas Frontside 
				PlayAnim Anim = <FSAnim> 
				SetTrickName <FSName> 
			ELSE 
				PlayAnim Anim = <BSAnim> 
				SetTrickName <BSName> 
			ENDIF 
		ENDIF 
	ENDIF 
	Display Blockspin 
	FlipAfter 
	BoardRotateAfter 
	BlendPeriodOut 0.00000000000 
	Wait 0.10000000149 seconds 
	SetException Ex = Ollied Scr = Ollie 
	ResetLandedFromVert 
	WaitAnimFinished 
	CanKickOn 
	DoNextManualTrick FromAir 
	OnGroundExceptions 
	LandSkaterTricks 
	ClearEventBuffer 
	PlayAnim Anim = CrouchIdle BlendPeriod = 0.30000001192 
	WaitAnimWhilstChecking AndManuals 
	Goto OnGroundAI 
ENDSCRIPT

SCRIPT ExitRevert 
	CanKickOn 
	SetTrickName #"" 
	SetTrickScore 0 
	Display Blockspin 
ENDSCRIPT

SCRIPT RevertCheeseTimer 
	Obj_SetFlag FLAG_SKATER_REVERTCHEESE 
	Wait 25 seconds 
	SetTags RevertCheese = 0 
	Obj_ClearFlag FLAG_SKATER_REVERTCHEESE 
ENDSCRIPT

SCRIPT RevertCheeseIncrement 
	Gettags 
	<RevertCheese> = ( <RevertCheese> + 1 ) 
	SetTags RevertCheese = <RevertCheese> 
	RETURN RevertCheese = <RevertCheese> 
ENDSCRIPT

SCRIPT ToggleSwitchRegular 
	OnGroundExceptions 
	SetQueueTricks NoTricks 
	ClearTrickQueues 
	IF NOT GoalManager_GoalShouldExpire 
		SetException Ex = Ollied Scr = Ollie Params = { NoDoNextTrick } 
	ENDIF 
	NollieOff 
	IF NOT GetGlobalFlag flag = CHEAT_HOVERBOARD 
		Obj_SpawnScript CessTrail Params = { delay = 3 } 
		Vibrate Actuator = 0 Percent = 80 duration = 0.50000000000 
		Vibrate Actuator = 1 Percent = 80 duration = 0.10000000149 
	ENDIF 
	IF GotParam PowerSlide 
		Rotate y = 180 duration = 0.30000001192 seconds 
		IF LeftPressed 
			IF Flipped 
				PlayAnim Anim = FSPowerslide 
			ELSE 
				PlayAnim Anim = BSPowerslide 
			ENDIF 
		ELSE 
			IF RightPressed 
				IF Flipped 
					PlayAnim Anim = BSPowerslide 
				ELSE 
					PlayAnim Anim = FSPowerslide 
				ENDIF 
			ELSE 
				PlayAnim Anim = FSPowerslide 
			ENDIF 
		ENDIF 
	ELSE 
		IF LeftPressed 
			IF Flipped 
				IF NOT crouched 
					PlayAnim RANDOM(1, 1) RANDOMCASE Anim = CessSlide180_FS RANDOMCASE Anim = CessSlide180_FS2 RANDOMEND 
				ELSE 
					PlayAnim Anim = CrouchCessSlide180_FS 
				ENDIF 
			ELSE 
				IF NOT crouched 
					PlayAnim Anim = CessSlide180_BS 
				ELSE 
					PlayAnim Anim = CrouchCessSlide180_BS 
				ENDIF 
			ENDIF 
		ELSE 
			IF RightPressed 
				IF Flipped 
					IF NOT crouched 
						PlayAnim Anim = CessSlide180_BS 
					ELSE 
						PlayAnim Anim = CrouchCessSlide180_BS 
					ENDIF 
				ELSE 
					IF NOT crouched 
						PlayAnim RANDOM(1, 1) RANDOMCASE Anim = CessSlide180_FS RANDOMCASE Anim = CessSlide180_FS2 RANDOMEND 
					ELSE 
						PlayAnim Anim = CrouchCessSlide180_FS 
					ENDIF 
				ENDIF 
			ELSE 
				IF NOT crouched 
					PlayAnim RANDOM(1, 1) RANDOMCASE Anim = CessSlide180_FS RANDOMCASE Anim = CessSlide180_FS2 RANDOMEND 
				ELSE 
					PlayAnim Anim = CrouchCessSlide180_FS 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
	WaitAnim 30 Percent 
	IF NOT GetGlobalFlag flag = CHEAT_HOVERBOARD 
		PlayCessSound 
	ENDIF 
	WaitAnim 35 Percent 
	SetSkaterGroundTricks 
	FlipAfter 
	BoardRotateAfter 
	BlendPeriodOut 0.00000000000 
	WaitAnimWhilstChecking AndManuals 
	IF NOT GotParam PowerSlide 
		IF CanKick 
			PlayAnim Anim = PushCycle Cycle BlendPeriod = 0.00000000000 
		ELSE 
			IF AnimFinished 
				IF NOT crouched 
					PlayAnim Anim = Idle Cycle BlendPeriod = 0.00000000000 
				ELSE 
					IF NOT AnimEquals [ CrouchCessSlide180_FS CrouchCessSlide180_BS ] 
						PlayAnim Anim = Idle Cycle BlendPeriod = 0.00000000000 
						PlayAnim Anim = CrouchIdle Cycle BlendPeriod = 0.20000000298 
					ELSE 
						PlayAnim Anim = CrouchIdle Cycle BlendPeriod = 0.00000000000 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
	ELSE 
		PlayAnim Anim = CrouchIdle Cycle BlendPeriod = 0.00000000000 
	ENDIF 
	ClearTrickQueue 
	Goto OnGroundAI 
ENDSCRIPT

SCRIPT CessTrail repeat_times = 20 
	IF SpeedGreaterThan 400 
		IF GotParam delay 
			Wait <delay> frames 
		ENDIF 
		BEGIN 
			IF NOT onground 
				BREAK 
			ELSE 
				IF IsXbox 
					TextureSplat size = 6 radius = 0 bone = Bone_Board_Tail Name = "skidtrail" trail lifetime = 15 
					TextureSplat size = 6 radius = 0 bone = Bone_Board_Nose Name = "skidtrail" trail lifetime = 15 
				ELSE 
					TextureSplat size = 6 radius = 0 bone = Bone_Board_Tail Name = "skidtrail_ps2" trail lifetime = 15 
					TextureSplat size = 6 radius = 0 bone = Bone_Board_Nose Name = "skidtrail_ps2" trail lifetime = 15 
				ENDIF 
			ENDIF 
			Wait 1 game frame 
		REPEAT <repeat_times> 
	ENDIF 
ENDSCRIPT

SCRIPT ToggleNollieRegular 
	OnGroundExceptions 
	ClearTrickQueues 
	ApplyStanceToggle 
	IF NOT InNollie 
		IF NOT InPressure 
			IF NOT GoalManager_GoalShouldExpire 
				SetException Ex = Ollied Scr = Ollie 
			ENDIF 
			IF crouched 
				PlayAnim Anim = CrouchToNollie BlendPeriod = 0.10000000149 Backwards 
			ELSE 
				PlayAnim Anim = SkatingToNollie BlendPeriod = 0.10000000149 Backwards 
			ENDIF 
		ELSE 
			IF NOT GoalManager_GoalShouldExpire 
				SetException Ex = Ollied Scr = Ollie 
			ENDIF 
			IF crouched 
				PlayAnim Anim = CrouchToPressure BlendPeriod = 0.10000000149 
			ELSE 
				PlayAnim Anim = SkateToPressure BlendPeriod = 0.10000000149 
			ENDIF 
		ENDIF 
	ELSE 
		IF NOT GoalManager_GoalShouldExpire 
			SetException Ex = Ollied Scr = Nollie 
		ENDIF 
		IF crouched 
			PlayAnim Anim = CrouchToNollie BlendPeriod = 0.10000000149 
		ELSE 
			PlayAnim Anim = SkatingToNollie BlendPeriod = 0.10000000149 
		ENDIF 
	ENDIF 
	WaitAnimWhilstChecking AndManuals 
	IF InNollie 
		Goto OnGroundNollieAI 
	ELSE 
		Goto OnGroundAI 
	ENDIF 
ENDSCRIPT

SCRIPT ApplyStanceToggle 
	IF InNollie 
		PressureOff 
		NollieOff 
	ELSE 
		IF InPressure 
			PressureOff 
			NollieOn 
		ELSE 
			NollieOff 
			PressureOn 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT Nollie 
	IF GotParam NoDoNextTrick 
	ELSE 
		DoNextTrick 
	ENDIF 
	ClearTrickQueue 
	ClearEventBuffer Buttons = Dpad OlderThan = TRICK_PRELOAD_TIME 
	Jump 
	InAirExceptions 
	Vibrate Actuator = 1 Percent = 50 duration = 0.05000000075 
	NollieOn 
	PlayAnim Anim = Nollie BlendPeriod = 0.10000000149 
	IF ProfileEquals stance = regular 
		IF Flipped 
			SetTrickName #"Nollie" 
			SetTrickScore 200 
		ELSE 
			SetTrickName #"Fakie Ollie" 
			SetTrickScore 200 
		ENDIF 
	ELSE 
		IF Flipped 
			SetTrickName #"Fakie Ollie" 
			SetTrickScore 200 
		ELSE 
			SetTrickName #"Nollie" 
			SetTrickScore 200 
		ENDIF 
	ENDIF 
	Display 
	BailOff 
	WaitAnimWhilstChecking 
	Goto Airborne 
ENDSCRIPT

SCRIPT NollieNoDisplay OutSpeed = 1 
	StopBalanceTrick 
	ClearTrickQueue 
	ClearEventBuffer Buttons = Dpad OlderThan = TRICK_PRELOAD_TIME 
	SetTrickName #"Nollie" 
	SetTrickScore 100 
	Display Deferred 
	Jump 
	InAirExceptions 
	Vibrate Actuator = 1 Percent = 80 duration = 0.05000000075 
	NollieOn 
	IF GotParam OutAnim 
		PlayAnim Anim = <OutAnim> BlendPeriod = 0.30000001192 Speed = <OutSpeed> 
	ELSE 
		PlayAnim Anim = Nollie BlendPeriod = 0.10000000149 
	ENDIF 
	IF GotParam BoardRotate 
		BlendPeriodOut 0 
		BoardRotateAfter 
	ENDIF 
	BailOff 
	WaitAnimWhilstChecking 
	Goto Airborne 
ENDSCRIPT

Dpad = [ Up Down Left Right Upright UpLeft DownRight DownLeft ] 
SCRIPT GetPressureState pressure = 0 pressuretimer = 0 
	Gettags 
	RETURN pressure = <pressure> pressuretimer = <pressuretimer> 
ENDSCRIPT

SCRIPT Ollie OutSpeed = 1 
	StopBalanceTrick 
	StopSkitch 
	IF GotParam NoDoNextTrick 
	ELSE 
		DoNextTrick 
	ENDIF 
	ClearTrickQueue 
	ClearEventBuffer Buttons = Dpad OlderThan = TRICK_PRELOAD_TIME 
	ClearEventBuffer Buttons = [ X ] OlderThan = 0 
	IF NOT GotParam JumpSpeed 
		Jump 
	ELSE 
		Jump Speed = <JumpSpeed> 
	ENDIF 
	InAirExceptions 
	IF InPressure 
		SetTrickName #"Pressure" 
		SetTrickScore 200 
		Display 
	ENDIF 
	IF InNollie 
		IF ProfileEquals stance = regular 
			IF Flipped 
				SetTrickName #"Nollie" 
				SetTrickScore 200 
			ELSE 
				SetTrickName #"Fakie Ollie" 
				SetTrickScore 200 
			ENDIF 
		ELSE 
			IF Flipped 
				SetTrickName #"Fakie Ollie" 
				SetTrickScore 200 
			ELSE 
				SetTrickName #"Nollie" 
				SetTrickScore 200 
			ENDIF 
		ENDIF 
		Display 
	ELSE 
		SetTrickName #"Ollie" 
		SetTrickScore 75 
		Display Deferred 
	ENDIF 
	Vibrate Actuator = 1 Percent = 50 duration = 0.05000000075 
	IF GotParam FromLip 
		printf "came from lip==================" 
		PlayAnim Anim = <OutAnim> BlendPeriod = 0.00000000000 
		BlendPeriodOut 0 
	ELSE 
		IF GotParam OutAnim 
			IF GotParam SyncOutAnimToPreviousAnim 
				PlayAnim Anim = <OutAnim> BlendPeriod = 0.30000001192 Speed = <OutSpeed> SyncToPreviousAnim 
			ELSE 
				IF GotParam NoBlend 
					PlayAnim Anim = <OutAnim> BlendPeriod = 0.00000000000 Speed = <OutSpeed> 
				ELSE 
					PlayAnim Anim = <OutAnim> BlendPeriod = 0.30000001192 Speed = <OutSpeed> 
				ENDIF 
			ENDIF 
		ELSE 
			IF InNollie 
				PlayAnim Anim = Nollie BlendPeriod = 0.10000000149 
			ELSE 
				PlayAnim Anim = Ollie BlendPeriod = 0.00000000000 NoRestart 
			ENDIF 
		ENDIF 
	ENDIF 
	IF GotParam BoardRotate 
		BlendPeriodOut 0 
		BoardRotateAfter 
	ENDIF 
	IF GotParam RotateAfter 
		RotateAfter 
	ENDIF 
	IF GotParam FlipAfter 
		printf "=========flipping the skater in Ollie" 
		FlipAfter 
	ENDIF 
	IF GotParam NoBlend 
		BlendPeriodOut 0 
	ENDIF 
	IF GotParam WaitOnOlliePercent 
		BailOn 
		WaitAnim <WaitOnOlliePercent> Percent 
	ENDIF 
	BailOff 
	WaitAnimWhilstChecking 
	Goto Airborne 
ENDSCRIPT

SCRIPT NoComply 
	ClearTrickQueue 
	ClearEventBuffer Buttons = Dpad OlderThan = TRICK_PRELOAD_TIME 
	Jump 
	NollieOff 
	PressureOff 
	InAirExceptions 
	Vibrate Actuator = 1 Percent = 80 duration = 0.05000000075 
	SetTrickName <Name> 
	SetTrickScore <Score> 
	Display 
	BailOff 
	PlayAnim Anim = NoComply BlendPeriod = 0.20000000298 
	WaitAnimWhilstChecking 
	Goto Airborne 
ENDSCRIPT

SCRIPT Beanplant 
	ClearTrickQueue 
	ClearEventBuffer Buttons = Dpad OlderThan = TRICK_PRELOAD_TIME 
	Jump BonelessHeight 
	InAirExceptions 
	Vibrate Actuator = 1 Percent = 80 duration = 0.10000000149 
	PlaySound boneless09 pitch = 85 
	SetTrickName <Name> 
	SetTrickScore <Score> 
	Display 
	PlayAnim Anim = Beanplant BlendPeriod = 0.20000000298 
	WaitAnimWhilstChecking 
	Goto Airborne 
ENDSCRIPT

SCRIPT Fastplant 
	ClearTrickQueue 
	ClearEventBuffer Buttons = Dpad OlderThan = TRICK_PRELOAD_TIME 
	Jump BonelessHeight 
	InAirExceptions 
	Vibrate Actuator = 1 Percent = 80 duration = 0.10000000149 
	SetTrickName <Name> 
	SetTrickScore <Score> 
	Display 
	PlayAnim Anim = Fastplant BlendPeriod = 0.20000000298 
	BailOff 
	WaitAnimWhilstChecking 
	Goto Airborne 
ENDSCRIPT

SCRIPT Boneless Anim = Boneless Name = #"Boneless" Score = 250 
	ClearTrickQueue 
	ClearEventBuffer Buttons = Dpad OlderThan = TRICK_PRELOAD_TIME 
	Jump BonelessHeight 
	NollieOff 
	PressureOff 
	InAirExceptions 
	Vibrate Actuator = 1 Percent = 80 duration = 0.10000000149 
	PlaySound boneless09 pitch = 85 
	SetTrickName <Name> 
	SetTrickScore <Score> 
	IF NOT SkaterIsNamed vallely 
		PlayAnim Anim = <Anim> BlendPeriod = 0.20000000298 
	ELSE 
		PlayAnim Anim = _540Boneless BlendPeriod = 0.10000000149 Speed = 1.25000000000 from = 10 
		SetTrickScore 300 
		SetTrickName "MikeV Boneless" 
		FlipAfter 
		BlendPeriodOut 0 
	ENDIF 
	Display 
	BailOff 
	WaitAnimWhilstChecking 
	Goto Airborne 
ENDSCRIPT

SCRIPT BonelessWaitAnimWhilstChecking 
	BEGIN 
		DoNextTrick 
		IF GotParam AndManuals 
			DoNextManualTrick 
		ENDIF 
		IF AnimFinished 
			BREAK 
		ENDIF 
		WaitOneGameFrame 
		IF onground 
			Goto Land 
		ENDIF 
	REPEAT 
ENDSCRIPT

SCRIPT SendTauntMessage 
	GetPreferenceString pref_type = Taunt <string_id> 
	SendChatMessage string = <ui_string> 
ENDSCRIPT

SCRIPT Taunt 
	LandSkaterTricks 
	ClearException Ollied 
	PlayAnim Anim = <Anim> BlendPeriod = 0.30000001192 
	GetPreferenceString pref_type = Taunt <string_id> 
	IF inNetGame 
		SendChatMessage string = <ui_string> 
	ENDIF 
	Wait 10 game frame 
	OnGroundExceptions 
	IF SpeedLessThan 1 
		SetRollingFriction 100 
		WaitAnimWhilstChecking AndManuals 
		Goto Handbrake 
	ELSE 
		WaitAnimWhilstChecking AndManuals 
		Goto OnGroundAI 
	ENDIF 
ENDSCRIPT

SCRIPT Props 
	LandSkaterTricks 
	OnGroundExceptions 
	PlayAnim RANDOM(1, 1) RANDOMCASE Anim = Prop RANDOMCASE Anim = Cheer1 RANDOMEND BlendPeriod = 0.30000001192 
	GetPreferenceString pref_type = Taunt <string_id> 
	IF inNetGame 
		SendChatMessage string = <ui_string> 
	ENDIF 
	IF SpeedLessThan 1 
		SetRollingFriction 100 
		WaitAnimWhilstChecking AndManuals 
		Goto Handbrake 
	ELSE 
		WaitAnimWhilstChecking AndManuals 
		Goto OnGroundAI 
	ENDIF 
ENDSCRIPT

SCRIPT BitchSlap 
	OnGroundExceptions 
	PlayAnim Anim = Slapright NoRestart BlendPeriod = 0.30000001192 
	WaitAnimWhilstChecking AndManuals 
	Goto OnGroundAI 
ENDSCRIPT

SCRIPT Skitch 
	StopBalanceTrick 
	ClearExceptions 
	ResetLandedFromVert 
	KillExtraTricks 
	SetEventHandler Ex = MadeOtherSkaterBail Scr = MadeOtherSkaterBail_Called 
	SetException Ex = Ollied Scr = Ollie Params = { <...> } 
	SetException Ex = OffMeterTop Scr = SkitchOut 
	SetException Ex = OffMeterBottom Scr = SkitchOut 
	SetException Ex = CarBail Scr = CarBail 
	SetException Ex = SkaterCollideBail Scr = SkaterCollideBail 
	LaunchStateChangeEvent State = Skater_Skitching 
	ClearTrickQueue 
	SetQueueTricks NoTricks 
	ClearManualTrick 
	SetManualTricks NoTricks 
	StartSkitch 
	StartBalanceTrick 
	PlayAnim Anim = SkitchInit 
	WaitAnimFinished 
	PlaySound Hud_jumpgap 
	SetTrickName "\\c2Skitchin\\C0" 
	SetTrickScore 500 
	Display Blockspin 
	DoBalanceTrick ButtonA = Right ButtonB = Left Type = Skitch Tweak = 5 
	PlayAnim Anim = SkitchRange wobble 
	SetEventHandler Ex = SkitchLeft Scr = SkitchAnimLeft 
	SetEventHandler Ex = SkitchRight Scr = SkitchAnimRight 
	BEGIN 
		overridelimits max = 1750 friction = 0 time = 5 gravity = 0 
		IF AnimFinished 
			PlayAnim Anim = SkitchRange wobble NoRestart 
		ENDIF 
		IF held Down 
			Obj_SpawnScript NoBrake_Timer 
			Goto SkitchOut 
		ENDIF 
		WaitOneGameFrame 
	REPEAT 
ENDSCRIPT

SCRIPT SkitchAnimLeft 
	PlayAnim Anim = SkitchMoveLeft from = 20 NoRestart Speed = 2 BlendPeriod = 0.10000000149 
ENDSCRIPT

SCRIPT SkitchAnimRight 
	PlayAnim Anim = SkitchMoveRight from = 20 NoRestart Speed = 2 BlendPeriod = 0.10000000149 
ENDSCRIPT

SCRIPT SkitchOut 
	StopSkitch 
	StopBalanceTrick 
	PlayAnim Anim = SkitchInit Backwards 
	OnGroundExceptions 
	ClearException Skitched 
	LandSkaterTricks 
	WaitAnimFinished 
	Goto OnGroundAI 
ENDSCRIPT

SCRIPT NoBrake_Timer 
	CanBrakeOff 
	Wait 0.50000000000 seconds 
	CanBrakeOn 
ENDSCRIPT


