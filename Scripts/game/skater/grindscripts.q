
SCRIPT SkateInOrBail moveleft = 1 moveright = -1 movey = -5 
	GetTags 
	NoRailTricks 
	StopBalanceTrick 
	KillExtraTricks 
	SetExtraTricks NoTricks 
	OnGroundExceptions NoEndRun 
	ClearException GroundGone 
	OnExceptionRun SkateInOrBail_Out 
	SetQueueTricks NoTricks 
	ClearManualTrick 
	IF GotParam Fallingright 
		Goto SkateIn_Right Params = { <...> } 
	ENDIF 
	IF GotParam FallingLeft 
		Goto SkateIn_Left Params = { <...> } 
	ENDIF 
	IF GotParam GrindRelease 
		IF Held Right 
			Goto SkateIn_Right Params = { <...> } 
		ENDIF 
		IF Held Left 
			Goto SkateIn_Left Params = { <...> } 
		ENDIF 
		IF SkateInAble Left 
			Goto SkateIn_Left Params = { <...> } 
		ELSE 
			Goto SkateIn_Right Params = { <...> } 
		ENDIF 
	ENDIF 
	printf "Missing a FallingLeft or FallingRight ?" 
	IF GotParam GrindBail 
		Goto <GrindBail> 
	ELSE 
		Goto FiftyFiftyFall 
	ENDIF 
ENDSCRIPT

SCRIPT SkateIn_Right 
	IF SkateInAble Right 
		printf "SkateInable RIGHT >>>>>>>>>>>>>>>>>>>>>>>>" 
		SetLandedFromVert 
		SetState ground 
		Move y = -5 
		Move x = -1 
		OrientToNormal 
		Rotate y = -30 Duration = 0.20000000298 seconds 
		OnGroundExceptions NoEndRun 
		ClearException GroundGone 
		OnExceptionRun SkateInOrBail_Out 
		SetQueueTricks NoTricks 
		SetManualTricks NoTricks 
		SetExtraTricks_Reverts 
		IF GotParam OutAnim 
			PlayAnim Anim = <OutAnim> BlendPeriod = 0.30000001192 
		ELSE 
			PlayAnim Anim = <initanim> Backwards BlendPeriod = 0.30000001192 
		ENDIF 
		WaitAnimWhilstChecking 
		Goto SkateInLand 
	ELSE 
		Move y = <movey> 
		Move x = <moveright> 
		SkateIn_Bail <...> 
	ENDIF 
ENDSCRIPT

SCRIPT SkateIn_Left 
	IF SkateInAble Left 
		SetLandedFromVert 
		printf "SkateInable LEFT >>>>>>>>>>>>>>>>>>>>>>>>" 
		SetState ground 
		Move x = 1 
		Move y = -5 
		OrientToNormal 
		Rotate y = 30 Duration = 0.20000000298 seconds 
		SetState ground 
		OnGroundExceptions NoEndRun 
		ClearException GroundGone 
		OnExceptionRun SkateInOrBail_Out 
		SetQueueTricks NoTricks 
		SetManualTricks NoTricks 
		SetExtraTricks_Reverts 
		IF GotParam OutAnim 
			PlayAnim Anim = <OutAnim> BlendPeriod = 0.30000001192 
		ELSE 
			PlayAnim Anim = <initanim> Backwards BlendPeriod = 0.30000001192 
		ENDIF 
		WaitAnimWhilstChecking 
		Goto SkateInLand 
	ELSE 
		printf "Not skateinable left >>>>>>>>>>>>>>>>>>>>>>>>" 
		Move y = <movey> 
		Move x = <moveright> 
		SkateIn_Bail <...> 
	ENDIF 
ENDSCRIPT

SCRIPT SkateIn_Bail 
	IF GetGlobalFlag Flag = DIFFICULTY_MODE_TOO_EASY 
		IF NOT InNetGame 
			OffRail <...> 
			RETURN 
		ENDIF 
	ENDIF 
	IF GotParam GrindBail 
		Goto <GrindBail> 
	ELSE 
		Goto FiftyFiftyFall 
	ENDIF 
ENDSCRIPT

SCRIPT SkateInLand 
	OnExceptionRun SkateInLandOut 
	NollieOff 
	PressureOff 
	Vibrate Actuator = 1 Percent = 80 Duration = 0.10000000149 
	IF Crouched 
		PlayAnim Anim = CrouchedLand BlendPeriod = 0.10000000149 
	ELSE 
		PlayAnim Anim = Land BlendPeriod = 0.10000000149 
	ENDIF 
	OnExceptionRun SkateInLandOut 
	OnGroundExceptions NoEndRun 
	SetManualTricks NoTricks 
	WaitAnim 10 Percent 
	LandSkaterTricks 
	OnGroundExceptions 
	CheckforNetBrake 
	AllowRailtricks 
	WaitAnimWhilstChecking AndManuals 
	Goto OnGroundAI 
ENDSCRIPT

SCRIPT SkateInLandOut 
	AllowRailtricks 
	LandSkaterTricks 
ENDSCRIPT

SCRIPT SkateInOrBail_Out 
	printf " =================================== LAND ==================================" 
	LandSkaterTricks 
ENDSCRIPT

Extra_FS_Grinds = 
[ 
	{ Trigger = { InOrder , a = Triangle , b = Triangle , 300 } Scr = Trick_5050_FS Params = { Name = #"FS 50-50" IsExtra = yes } } 
	{ Trigger = { InOrder , Triangle , Square , 300 } Scr = Trick_NoseSlide_FS Params = { Name = #"FS Noseslide" IsExtra = yes } } 
	{ Trigger = { InOrder , Triangle , Circle , 300 } Scr = Trick_Nosegrind_FS Params = { Name = #"FS Nosegrind" IsExtra = yes } } 
	{ Trigger = { InOrder , a = Circle , b = Circle , 300 } Scr = Trick_Crooked_FS Params = { Name = #"FS Crooked" IsExtra = yes } } 
	{ Trigger = { InOrder , Circle , Square , 300 } Scr = Trick_Bluntslide_FS Params = { Name = #"FS Bluntslide" IsExtra = yes } } 
	{ Trigger = { InOrder , Circle , Triangle , 300 } Scr = Trick_NoseBluntSlide_FS Params = { Name = #"FS Nosebluntslide" IsExtra = yes } } 
	{ Trigger = { InOrder , a = Square , b = Square , 300 } Scr = Trick_Smith_FS Params = { Name = #"FS Smith" IsExtra = yes } } 
	{ Trigger = { InOrder , Square , Circle , 300 } Scr = Trick_5_0_FS Params = { Name = #"FS 5-0" IsExtra = yes } } 
	{ Trigger = { InOrder , Square , Triangle , 300 } Scr = Trick_Tailslide_FS Params = { Name = #"FS Tailslide" IsExtra = yes } } 
] 
Extra_BS_Grinds = 
[ 
	{ Trigger = { InOrder , a = Triangle , b = Triangle , 300 } Scr = Trick_5050_BS Params = { Name = #"BS 50-50" IsExtra = yes } } 
	{ Trigger = { InOrder , Triangle , Square , 300 } Scr = Trick_NoseSlide_BS Params = { Name = #"BS Noseslide" IsExtra = yes } } 
	{ Trigger = { InOrder , Triangle , Circle , 300 } Scr = Trick_Nosegrind_BS Params = { #"BS Nosegrind" IsExtra = yes } } 
	{ Trigger = { InOrder , a = Circle , b = Circle , 300 } Scr = Trick_Crooked_BS Params = { Name = #"BS Crooked" IsExtra = yes } } 
	{ Trigger = { InOrder , Circle , Square , 300 } Scr = Trick_Bluntslide_BS Params = { Name = #"BS Bluntslide" IsExtra = yes } } 
	{ Trigger = { InOrder , Circle , Triangle , 300 } Scr = Trick_NoseBluntSlide_BS Params = { Name = #"BS Nosebluntslide" IsExtra = yes } } 
	{ Trigger = { InOrder , Square , Triangle , 300 } Scr = Trick_Tailslide_BS Params = { Name = #"BS Tailslide" IsExtra = yes } } 
	{ Trigger = { InOrder , a = Square , b = Square , 300 } Scr = Trick_Smith_BS Params = { Name = #"BS Smith" IsExtra = yes } } 
	{ Trigger = { InOrder , Square , Circle , 300 } Scr = Trick_5_0_BS Params = { Name = #"BS 5-0" IsExtra = yes } } 
] 
GrindRelease = 
[ 
	{ Trigger = { Press , R2 , 100 } Scr = SkateInOrBail Params = { GrindRelease GrindBail = Airborne moveright = -5 movey = 5 } } 
] 
GRINDTAP_TIME = 1000 
GRINDTAP_SCORE = 400 
GRINDTAP_TWEAK = 25 
GrindTaps_FS = [ 
	{ Trigger = { TripleInOrderSloppy , UpRight , b = Triangle , c = Triangle , GRINDTAP_TIME } Scr = Trick_CrailSlide_FS Params = { IsExtra = 1 } } 
	{ Trigger = { TripleInOrderSloppy , DownRight , b = Triangle , c = Triangle , GRINDTAP_TIME } Scr = Trick_Darkslide_FS Params = { IsExtra = 1 } } 
	{ Trigger = { TripleInOrderSloppy , DownLeft , b = Triangle , c = Triangle , GRINDTAP_TIME } Scr = Trick_DoubleBluntSlide2 Params = { IsExtra = 1 } } 
	{ Trigger = { TripleInOrderSloppy , UpLeft , b = Triangle , c = Triangle , GRINDTAP_TIME } Scr = Trick_HangTenNoseGrind_FS Params = { IsExtra = 1 } } 
	{ Trigger = { TripleInOrderSloppy , Up , b = Triangle , c = Triangle , GRINDTAP_TIME } Scr = Trick_NosegrindPivot_FS Params = { IsExtra = 1 } } 
	{ Trigger = { TripleInOrderSloppy , Right , b = Triangle , c = Triangle , GRINDTAP_TIME } Scr = Trick_Salad_FS Params = { IsExtra = 1 } } 
	{ Trigger = { TripleInOrderSloppy , Left , b = Triangle , c = Triangle , GRINDTAP_TIME } Scr = Trick_Hurricane_FS Params = { IsExtra = 1 } } 
	{ Trigger = { TripleInOrderSloppy , Down , b = Triangle , c = Triangle , GRINDTAP_TIME } Scr = Trick_GrindOverturn_FS Params = { IsExtra = 1 } } 
] 
GrindTaps_BS = [ 
	{ Trigger = { TripleInOrderSloppy , UpRight , b = Triangle , c = Triangle , GRINDTAP_TIME } Scr = Trick_CrailSlide_BS Params = { IsExtra = 1 } } 
	{ Trigger = { TripleInOrderSloppy , DownRight , b = Triangle , c = Triangle , GRINDTAP_TIME } Scr = Trick_Darkslide_BS Params = { IsExtra = 1 } } 
	{ Trigger = { TripleInOrderSloppy , DownLeft , b = Triangle , c = Triangle , GRINDTAP_TIME } Scr = Trick_DoubleBluntSlide2 Params = { IsExtra = 1 } } 
	{ Trigger = { TripleInOrderSloppy , UpLeft , b = Triangle , c = Triangle , GRINDTAP_TIME } Scr = Trick_HangTenNoseGrind_BS Params = { IsExtra = 1 } } 
	{ Trigger = { TripleInOrderSloppy , Up , b = Triangle , c = Triangle , GRINDTAP_TIME } Scr = Trick_NosegrindPivot_BS Params = { IsExtra = 1 } } 
	{ Trigger = { TripleInOrderSloppy , Right , b = Triangle , c = Triangle , GRINDTAP_TIME } Scr = Trick_Salad_BS Params = { IsExtra = 1 } } 
	{ Trigger = { TripleInOrderSloppy , Down , b = Triangle , c = Triangle , GRINDTAP_TIME } Scr = Trick_GrindOverturn_BS Params = { IsExtra = 1 } } 
	{ Trigger = { TripleInOrderSloppy , Left , b = Triangle , c = Triangle , GRINDTAP_TIME } Scr = Trick_Hurricane_BS Params = { IsExtra = 1 } } 
] 
SCRIPT Grind GrindTweak = 7 boardscuff = 0 InitSpeed = 1.00000000000 
	IF NOT GetGlobalFlag Flag = DIFFICULTY_MODE_TOO_EASY 
		IF BailIsOn 
			SetState Air 
			Goto DoingTrickBail 
		ENDIF 
	ENDIF 
	IF InNetGame 
		IF BailIsOn 
			SetState Air 
			Goto DoingTrickBail 
		ENDIF 
	ENDIF 
	BailOff 
	LaunchStateChangeEvent State = Skater_OnRail 
	KillExtraTricks 
	IF ChecksumEquals a = <Extratricks> b = Extra_BS_Grinds 
		SetExtraTricks GrindTaps_BS 
	ELSE 
		SetExtraTricks GrindTaps_FS 
	ENDIF 
	SetTags OutAnim = <OutAnim> initanim = <initanim> InitSpeed = <InitSpeed> Anim = <Anim> 
	SetTrickName "" 
	SetTrickScore 0 
	Display Blockspin 
	Obj_ClearFlag FLAG_SKATER_MANUALCHEESE 
	Obj_ClearFlag FLAG_SKATER_REVERTCHEESE 
	IF GotParam SpecialItem_details 
		TurnOnSpecialItem SpecialItem_details = <SpecialItem_details> 
	ENDIF 
	IF GotParam SwitchBoardOff 
		SwitchoffBoard 
	ENDIF 
	OnExitRun Exit_Grind 
	IF GotParam SpecialSounds 
		Obj_SpawnScript <SpecialSounds> 
	ENDIF 
	IF GotParam Stream 
		Obj_PlayStream <Stream> 
	ENDIF 
	Vibrate Actuator = 1 Percent = 50 Duration = 0.25000000000 
	Vibrate Actuator = 0 Percent = 50 
	ClearExceptions 
	IF GotParam Nollie 
		SetException Ex = Ollied Scr = NollieNoDisplay 
		NollieOn 
	ELSE 
		IF GotParam OutAnimOnOllie 
			SetException Ex = Ollied Scr = Ollie Params = { <...> } 
		ELSE 
			SetException Ex = Ollied Scr = Ollie 
		ENDIF 
		NollieOff 
	ENDIF 
	PressureOff 
	IF IsGrind <Type> 
		IF GotParam FrontTruckSparks 
			SetFrontTruckSparks 
		ELSE 
			IF GotParam RearTruckSparks 
				SetRearTruckSparks 
			ELSE 
				SetSparksTruckFromNollie 
			ENDIF 
		ENDIF 
		SparksOn 
	ELSE 
		GetBoardScuff 
		<boardscuff> = ( <boardscuff> + 1 ) 
		SetTags boardscuff = <boardscuff> 
		DoBoardScuff boardscuff = <boardscuff> 
		SparksOff 
	ENDIF 
	SetException Ex = OffRail Scr = OffRail Params = { KissedRail initanim = <initanim> InitSpeed = <InitSpeed> OutAnim = <OutAnim> BoardRotate = <BoardRotate> OutAnimBackwards = <OutAnimBackwards> } 
	SetException Ex = Landed Scr = Land 
	SetException Ex = OffMeterTop Scr = SkateInOrBail Params = { <...> FallingLeft } 
	SetException Ex = OffMeterBottom Scr = SkateInOrBail Params = { <...> Fallingright } 
	SetException Ex = SkaterCollideBail Scr = SkaterCollideBail 
	SetEventHandler Ex = MadeOtherSkaterBail Scr = MadeOtherSkaterBail_Called 
	OnExceptionRun Grind_Kissed 
	ClearTrickQueue 
	ClearManualTrick 
	ClearExtraGrindTrick 
	SetQueueTricks NoTricks 
	SetManualTricks NoTricks 
	SetRailSound <Type> 
	IF GotParam IsSpecial 
		SetGrindTweak 36 
	ELSE 
		IF GotParam IsATap 
			SetGrindTweak GRINDTAP_TWEAK 
		ELSE 
			SetGrindTweak <GrindTweak> 
		ENDIF 
	ENDIF 
	IF GotParam IsExtra 
		LaunchExtraMessage 
	ENDIF 
	IF GotParam Profile 
		IF ProfileEquals is_named = <Profile> 
			SwitchOnAtomic special_item 
			SwitchOffAtomic special_item_2 
		ENDIF 
	ENDIF 
	IF GotParam FullScreenEffect 
		<FullScreenEffect> 
		OnExitRun Exit_FullScreenEffect 
	ENDIF 
	IF NOT AnimEquals JumpAirTo5050 
		IF GotParam NoBlend 
			PlayAnim Anim = <initanim> BlendPeriod = 0.00000000000 Speed = <InitSpeed> 
		ELSE 
			PlayAnim Anim = <initanim> BlendPeriod = 0.30000001192 Speed = <InitSpeed> 
		ENDIF 
	ENDIF 
	IF GotParam IsATap 
		DoBalanceTrick ButtonA = Right ButtonB = Left Type = <Type> DoFlipCheck ClearCheese 
	ELSE 
		DoBalanceTrick ButtonA = Right ButtonB = Left Type = <Type> DoFlipCheck 
	ENDIF 
	Wait 15 frames 
	IF IsPs2 
		SetExtraTricks GrindRelease 
	ENDIF 
	Wait 1 frame 
	IF GotParam IsSpecial 
		LaunchSpecialMessage text = "Special Grind" 
	ENDIF 
	SetException Ex = OffRail Scr = OffRail Params = { initanim = <initanim> InitSpeed = <InitSpeed> OutAnim = <OutAnim> BoardRotate = <BoardRotate> OutAnimBackwards = <OutAnimBackwards> } 
	OnExceptionRun Normal_Grind 
	SetTrickName <Name> 
	SetTrickScore <Score> 
	Display Blockspin 
	IF AnimEquals JumpAirTo5050 
		WaitAnimFinished 
		PlayAnim Anim = <initanim> BlendPeriod = 0.30000001192 Speed = <InitSpeed> 
	ENDIF 
	WaitAnimFinished 
	IF GotParam FlipAfterInit 
		Flip 
		PlayBonkSound 
		BoardRotate 
		BlendperiodOut 0 
	ENDIF 
	IF GotParam Idle 
		PlayAnim Anim = <Anim> Cycle NoRestart 
	ELSE 
		IF GotParam Anim3 
			IF GotParam Anim2 
				PlayAnim RANDOM(1, 1, 1) RANDOMCASE Anim = <Anim> RANDOMCASE Anim = <Anim2> RANDOMCASE Anim = <Anim3> RANDOMEND wobble wobbleparams = grindwobble_params 
			ELSE 
				ScriptAssert "Script Assert: Added Anim3 to a grind without a valid anim2...check grindscripts.q Problem Anim = %a" a = <Anim> 
			ENDIF 
		ELSE 
			IF GotParam Anim2 
				PlayAnim RANDOM(1, 1) RANDOMCASE Anim = <Anim> RANDOMCASE Anim = <Anim2> RANDOMEND wobble wobbleparams = grindwobble_params 
			ELSE 
				PlayAnim Anim = <Anim> wobble wobbleparams = grindwobble_params 
			ENDIF 
		ENDIF 
	ENDIF 
	IF GotParam FlipBeforeOutAnim 
		BlendperiodOut 0.00000000000 
		FlipAfter 
	ENDIF 
	IF AnimEquals [ FiftyFifty_Range NoseGrind_Range TailGrind_Range ] 
		Wait 0.25000000000 seconds 
	ENDIF 
	IF GotParam Extratricks 
		IF IsPs2 
			SetExtraTricks <Extratricks> ignore = <Name> GrindRelease 
		ELSE 
			SetExtraTricks <Extratricks> ignore = <Name> 
		ENDIF 
	ELSE 
		IF IsPs2 
			SetExtraTricks GrindRelease 
		ENDIF 
	ENDIF 
	IF GotParam ScreenShake 
		Grind_ScreenShake ScreenShake = <ScreenShake> 
	ENDIF 
	IF GotParam specialtrick_particles 
		printf "Going to emit particles ........................." 
		Emit_SpecialTrickParticles specialitem_particles = <specialitem_particles> 
	ENDIF 
	WaitWhilstChecking_ForPressure <...> 
ENDSCRIPT

SCRIPT Exit_FullScreenEffect 
	<skaterlights_target> = ( tod_skaterlights ) 
	set_level_lights <skaterlights_target> 
	SetFogColor r = fog_red b = fog_blue g = fog_green a = fog_alpha 
	SetFogDistance distance = fog_dist 
	KillManualVibration 
	end_oldtime_effects 
	Exit_Grind 
ENDSCRIPT

SCRIPT Exit_Grind 
	SwitchOnBoard 
	CleanUp_SpecialTrickParticles 
ENDSCRIPT

SCRIPT CreatureScaryGrindEffect 
	start_oldtime_effects 
ENDSCRIPT

SCRIPT JamieThomasEffect2 
	printf "calling JT effect" 
	set_level_lights { 
		ambient_red = 10 
		ambient_green = 10 
		ambient_blue = 10 
		ambient_mod_factor = 0.30000001192 
		heading_0 = 60 
		pitch_0 = 10 
		red_0 = 10 
		green_0 = 10 
		blue_0 = 10 
		mod_factor_0 = 10 
		heading_1 = 245 
		pitch_1 = 330 
		red_1 = 10 
		green_1 = 10 
		blue_1 = 10 
	mod_factor_1 = 0.75000000000 } 
	Obj_UpdateBrightness 
ENDSCRIPT

SCRIPT IronManEffect 
	EnableFog 
	SetFogColor r = 200 b = 0 g = 0 a = 100 
	SetFogDistance distance = 400 
	set_level_lights tod_skaterlights_nightvision 
ENDSCRIPT

SCRIPT GetBoardScuff ManualName = #"none" 
	GetTags 
	RETURN boardscuff = <boardscuff> 
ENDSCRIPT

SCRIPT Grind_ScreenShake ScreenShake = 60 
	IF AnimEquals [ ElbowSmash_Idle FlipKickDad ] 
		BEGIN 
			Wait 1 frame 
			IF FrameIs <ScreenShake> 
				printf " THIS IS THE RIGHT SPOT" 
				BloodSplat 
				PlaySound BailSlap03 
				ShakeCamera { 
					Duration = 0.50000000000 
					vert_amp = 9.00000000000 
					horiz_amp = 3.00000000000 
					vert_vel = 10.27000045776 
					horiz_vel = 5.92000007629 
				} 
			ENDIF 
		REPEAT 
	ENDIF 
ENDSCRIPT

grindwobble_params = { 
	WobbleAmpA = { PAIR(0.10000000149, 0.10000000149) STATS_RAILBALANCE } 
	WobbleAmpB = { PAIR(0.03999999911, 0.03999999911) STATS_RAILBALANCE } 
	WobbleK1 = { PAIR(0.00219999999, 0.00219999999) STATS_RAILBALANCE } 
	WobbleK2 = { PAIR(0.00170000002, 0.00170000002) STATS_RAILBALANCE } 
	SpazFactor = { PAIR(1.50000000000, 1.50000000000) STATS_RAILBALANCE } 
} 
SCRIPT Grind_Kissed 
	IF GotParam MadeOtherSkaterBail 
	ELSE 
		KillExtraTricks 
	ENDIF 
	Obj_KillSpawnedScript Name = CheckForShuffle 
	Obj_SpawnScript CheckForShuffle 
ENDSCRIPT

SCRIPT CheckForShuffle 
	SetException Ex = SkaterEnterRail Scr = Awardshuffle 
	Wait 15 frames 
ENDSCRIPT

SCRIPT Awardshuffle 
	SetTrickName #"" 
	SetTrickScore 100 
	Display Blockspin NoDegrade 
	IF NOT InSplitscreenGame 
		Create_Panel_Message text = "Shuffle Bonus" id = perfect rgba = [ 50 120 200 128 ] pos = PAIR(110.00000000000, 340.00000000000) style = perfect_style 
		Create_Panel_Message text = "+100 Points" id = perfect2 rgba = [ 50 120 200 100 ] pos = PAIR(110.00000000000, 360.00000000000) style = perfect_style 
	ELSE 
		PerfectSloppy_2p text = "Shuffle!" rgb = [ 50 120 50 128 ] 
	ENDIF 
ENDSCRIPT

SCRIPT Normal_Grind 
	IF GotParam MadeOtherSkaterBail 
	ELSE 
		KillExtraTricks 
	ENDIF 
	SwitchOffAtomic special_item 
	SwitchOnAtomic special_item_2 
ENDSCRIPT

SCRIPT OffRail InitSpeed = 1.00000000000 
	IF GotParam KissedRail 
		SetTrickScore 50 
		SetTrickName "Kissed the Rail" 
		Display Blockspin 
	ENDIF 
	StopBalanceTrick 
	KillExtraTricks 
	Vibrate Actuator = 0 Percent = 0 
	SetState Air 
	SetException Ex = Landed Scr = Land 
	SetException Ex = WallRideLeft Scr = WallRide Params = { Left } 
	SetException Ex = WallRideRight Scr = WallRide Params = { Right } 
	DoNextTrick 
	IF GotParam EarlyOut 
		PlayAnim Anim = <EarlyOut> BlendPeriod = 0.10000000149 Backwards 
	ELSE 
		IF GotParam OutAnim 
			IF GotParam OutAnimBackwards 
				printf "Playing OutAnim Backwards" 
				PlayAnim Anim = <OutAnim> Backwards BlendPeriod = 0.10000000149 Speed = <InitSpeed> 
			ELSE 
				PlayAnim Anim = <OutAnim> BlendPeriod = 0.10000000149 Speed = <InitSpeed> 
			ENDIF 
		ELSE 
			PlayAnim Anim = <initanim> BlendPeriod = 0.10000000149 Backwards Speed = <InitSpeed> 
		ENDIF 
	ENDIF 
	IF GotParam BoardRotate 
		printf "Setting blendperiod out.................." 
		BlendperiodOut 0 
		BoardRotateAfter 
	ENDIF 
	IF GotParam FlipAfter 
		printf "flipping.................." 
		FlipAfter 
	ENDIF 
	WaitAnimFinished 
	Goto Airborne 
ENDSCRIPT

SCRIPT Trick_5050_BS Name = #"BS 50-50" 
	Grind { Name = <Name> Score = 100 initanim = Init_FiftyFifty Anim = FiftyFifty2_range Anim2 = FiftyFifty_Range Anim3 = FiftyFifty3_range Type = Grind NoBlend = <NoBlend> 
	GrindBail = FiftyFiftyFall Extratricks = Extra_BS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_5050_FS Name = #"FS 50-50" 
	Grind { Name = <Name> Score = 100 initanim = Init_FiftyFifty Anim = FiftyFifty2_range Anim2 = FiftyFifty_Range Anim3 = FiftyFifty3_range Type = Grind NoBlend = <NoBlend> 
	GrindBail = FiftyFiftyFall Extratricks = Extra_FS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_5050_BS_180 
	FlipAndRotate 
	BoardRotateAfter 
	Goto Trick_5050_BS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_5050_FS_180 
	FlipAndRotate 
	BoardRotateAfter 
	Goto Trick_5050_FS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_Boardslide_FS Name = #"FS Boardslide" 
	Rotate 
	Grind { Name = <Name> Score = 200 GrindTweak = 14 initanim = Init_FSBoardslide Anim = FSBoardslide_range OutAnim = FSBoardslide_Out Type = Slide NoBlend = yes 
	GrindBail = Nutter Extratricks = Extra_FS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_Boardslide_BS Name = #"BS Boardslide" 
	Grind { Name = <Name> Score = 200 GrindTweak = 14 initanim = Init_BSBoardslide Anim = BSBoardslide_range OutAnim = BSBoardslide_Out Type = Slide NoBlend = yes 
	GrindBail = Nutter Extratricks = Extra_BS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_Lipslide_FS Name = #"FS Lipslide" 
	Grind { Name = <Name> Score = 200 GrindTweak = 14 initanim = Init_FSLipslide Anim = BSBoardslide_range OutAnim = BSBoardslide_Out Type = Slide NoBlend = yes 
	GrindBail = Nutter Extratricks = Extra_FS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_Lipslide_BS Name = #"BS Lipslide" 
	Rotate 
	Grind { Name = <Name> Score = 200 GrindTweak = 14 initanim = Init_BSLipslide Anim = FSBoardslide_range OutAnim = FSBoardslide_Out Type = Slide NoBlend = yes 
	GrindBail = Nutter Extratricks = Extra_BS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_Tailslide_FS 
	IF BadLedge 
		Goto Trick_NoseSlide_BS_ok Params = { IsExtra = <IsExtra> NoBlend = <NoBlend> } 
	ELSE 
		Goto Trick_Tailslide_FS_ok Params = { IsExtra = <IsExtra> NoBlend = <NoBlend> } 
	ENDIF 
ENDSCRIPT

SCRIPT Trick_Tailslide_FS_ok Name = #"FS Tailslide" 
	Grind { Name = <Name> Score = 150 GrindTweak = 11 initanim = Init_FSTailslide InitSpeed = 1.50000000000 Anim = FSTailslide_range OutAnim = FSTailslide_Out Type = Slide NoBlend = <NoBlend> 
	GrindBail = FiftyFiftyFall Extratricks = Extra_FS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_Tailslide_BS 
	IF BadLedge 
		Goto Trick_NoseSlide_FS_ok Params = { IsExtra = <IsExtra> NoBlend = <NoBlend> } 
	ELSE 
		Goto Trick_Tailslide_BS_ok Params = { IsExtra = <IsExtra> NoBlend = <NoBlend> } 
	ENDIF 
ENDSCRIPT

SCRIPT Trick_Tailslide_BS_ok Name = #"BS Tailslide" 
	Grind { Name = <Name> Score = 150 GrindTweak = 11 initanim = Init_Tailslide InitSpeed = 1.50000000000 Anim = Tailslide_range OutAnim = BSTailslide_Out Type = Slide NoBlend = <NoBlend> 
	GrindBail = BackwardsGrindBails Extratricks = Extra_BS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_Tailslide_FS_180 
	FlipAndRotate 
	BoardRotateAfter 
	Goto Trick_Tailslide_BS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_Tailslide_BS_180 
	FlipAndRotate 
	BoardRotateAfter 
	Goto Trick_Tailslide_FS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_NoseSlide_FS 
	IF BadLedge 
		Goto Trick_Tailslide_BS_ok Params = { IsExtra = <IsExtra> NoBlend = <NoBlend> } 
	ELSE 
		Goto Trick_NoseSlide_FS_ok Params = { IsExtra = <IsExtra> NoBlend = <NoBlend> } 
	ENDIF 
ENDSCRIPT

SCRIPT Trick_NoseSlide_FS_ok Name = #"FS Noseslide" 
	Grind { Name = <Name> Score = 150 GrindTweak = 11 initanim = Init_FSNoseslide InitSpeed = 1.50000000000 Anim = FSNoseslide_range Type = Slide Nollie = yes OutAnim = FSNoseSlide_Out NoBlend = <NoBlend> 
	GrindBail = BackwardsGrindBails Extratricks = Extra_FS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_NoseSlide_BS 
	IF BadLedge 
		Goto Trick_Tailslide_FS_ok Params = { IsExtra = <IsExtra> NoBlend = <NoBlend> } 
	ELSE 
		Goto Trick_NoseSlide_BS_ok Params = { IsExtra = <IsExtra> NoBlend = <NoBlend> } 
	ENDIF 
ENDSCRIPT

SCRIPT Trick_NoseSlide_BS_ok Name = #"BS Noseslide" 
	Grind { Name = <Name> Score = 150 GrindTweak = 11 initanim = Init_Noseslide InitSpeed = 1.50000000000 Anim = Noseslide_range OutAnim = BSNoseslide_Out Type = Slide Nollie = yes NoBlend = <NoBlend> 
	GrindBail = FiftyFiftyFall Extratricks = Extra_BS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_Noseslide_FS_180 
	FlipAndRotate 
	BoardRotateAfter 
	Goto Trick_NoseSlide_BS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_Noseslide_BS_180 
	FlipAndRotate 
	BoardRotateAfter 
	Goto Trick_NoseSlide_FS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_Nosegrind_FS Name = #"FS Nosegrind" 
	Grind { Name = <Name> Score = 100 initanim = Init_Nosegrind InitSpeed = 1.50000000000 Anim = NoseGrind_Range Type = Grind Nollie = yes NoBlend = <NoBlend> 
	GrindBail = FiftyFiftyFall Extratricks = Extra_FS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_Nosegrind_BS Name = #"BS Nosegrind" 
	Grind { Name = <Name> Score = 100 initanim = Init_Nosegrind InitSpeed = 1.50000000000 Anim = NoseGrind_Range Type = Grind Nollie = yes NoBlend = <NoBlend> 
	GrindBail = FiftyFiftyFall Extratricks = Extra_BS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_NoseGrind_BS_180 
	FlipAndRotate 
	BoardRotateAfter 
	Goto Trick_5_0_FS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_NoseGrind_FS_180 
	FlipAndRotate 
	BoardRotateAfter 
	Goto Trick_5_0_BS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_5_0_FS Name = #"FS 5-0" 
	Grind { Name = <Name> Score = 100 initanim = Init_Tailgrind InitSpeed = 1.50000000000 Anim = TailGrind_Range Type = Grind NoBlend = <NoBlend> 
	GrindBail = FiftyFiftyFall Extratricks = Extra_FS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_5_0_BS Name = #"BS 5-0" 
	Grind { Name = <Name> Score = 100 initanim = Init_Tailgrind InitSpeed = 1.50000000000 Anim = TailGrind_Range Type = Grind NoBlend = <NoBlend> 
	GrindBail = FiftyFiftyFall Extratricks = Extra_BS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_5_0_FS_180 
	FlipAndRotate 
	BoardRotateAfter 
	Goto Trick_Nosegrind_BS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_5_0_BS_180 
	FlipAndRotate 
	BoardRotateAfter 
	Goto Trick_Nosegrind_BS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_Crooked_FS Name = #"FS Crooked" 
	Grind { Name = <Name> Score = 125 GrindTweak = 9 initanim = Init_FSCrooked InitSpeed = 1.50000000000 Anim = FSCrooked_range Type = Grind Nollie = yes NoBlend = <NoBlend> 
	GrindBail = FiftyFiftyFall Extratricks = Extra_FS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_Crooked_FS_rot 
	Rotate 
	Goto Trick_Crooked_FS 
ENDSCRIPT

SCRIPT Trick_Crooked_BS Name = #"BS Crooked" 
	Grind { Name = <Name> Score = 125 GrindTweak = 9 initanim = Init_BSCrooked InitSpeed = 1.50000000000 Anim = BSCrooked_range Type = Grind Nollie = yes NoBlend = <NoBlend> 
	GrindBail = FiftyFiftyFall Extratricks = Extra_BS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_Crooked_FS_180 
	IF Backwards 
		printf "I\'m backwards............" 
	ENDIF 
	FlipAndRotate 
	BoardRotateAfter 
	Goto Trick_Crooked_BS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_Crooked_BS_180 
	FlipAndRotate 
	BoardRotateAfter 
	Goto Trick_Crooked_FS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_NGCRook_FS_rot 
	Rotate 
	printf "fixed it bitches................................" 
	Goto Trick_NGCRook_FS 
ENDSCRIPT

SCRIPT Trick_NGCRook_FS Name = #"FS Overcrook" 
	Grind { Name = <Name> Score = 125 GrindTweak = 9 initanim = Init_FSOvercrook InitSpeed = 1.50000000000 Anim = FSOvercrook_range Type = Grind Nollie = yes NoBlend = <NoBlend> 
	GrindBail = FiftyFiftyFall Extratricks = Extra_FS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_NGCrook_BS Name = #"BS Overcrook" 
	Grind { Name = <Name> Score = 125 GrindTweak = 9 initanim = Init_BSOvercrook InitSpeed = 1.50000000000 Anim = BSOvercrook_range Type = Grind Nollie = yes NoBlend = <NoBlend> 
	GrindBail = FiftyFiftyFall Extratricks = Extra_BS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_NGCRook_FS_180 
	FlipAndRotate 
	Goto Trick_NGCrook_BS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_NGCrook_BS_180 
	FlipAndRotate 
	Goto Trick_NGCRook_FS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_Smith_FS Name = #"FS Smith" 
	Grind { Name = <Name> Score = 125 GrindTweak = 9 initanim = Init_FSSmith InitSpeed = 1.50000000000 Anim = FSSmith_range Type = Grind NoBlend = <NoBlend> 
	GrindBail = Nutter Extratricks = Extra_FS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_Smith_FS_rot 
	Rotate 
	Goto Trick_Smith_FS 
ENDSCRIPT

SCRIPT Trick_Smith_BS Name = #"BS Smith" 
	Grind { Name = <Name> Score = 125 GrindTweak = 9 initanim = Init_BSSmith InitSpeed = 1.50000000000 Anim = BSSmith_range Type = Grind NoBlend = <NoBlend> 
	GrindBail = Nutter Extratricks = Extra_BS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_Smith_FS_180 
	FlipAndRotate 
	Goto Trick_Smith_BS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_Smith_BS_180 
	FlipAndRotate 
	Goto Trick_Smith_FS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_Feeble_FS Name = #"FS Feeble" 
	Grind { Name = <Name> Score = 125 GrindTweak = 9 initanim = Init_FSFeeble InitSpeed = 1.50000000000 Anim = FSFeeble_range Type = Grind NoBlend = <NoBlend> 
	GrindBail = Nutter Extratricks = Extra_FS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_Feeble_FS_rot 
	Rotate 
	Goto Trick_Feeble_FS 
ENDSCRIPT

SCRIPT Trick_Feeble_BS Name = #"BS Feeble" 
	Grind { Name = <Name> Score = 125 GrindTweak = 9 initanim = Init_BSFeeble InitSpeed = 1.50000000000 Anim = BSFeeble_range Type = Grind NoBlend = <NoBlend> 
	GrindBail = Nutter Extratricks = Extra_BS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_Feeble_FS_180 
	FlipAndRotate 
	Goto Trick_Feeble_BS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_Feeble_BS_180 
	FlipAndRotate 
	Goto Trick_Feeble_FS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_Bluntslide_BS Name = #"BS Bluntslide" 
	Grind { Name = <Name> Score = 250 GrindTweak = 18 initanim = Init_BSBluntSlide InitSpeed = 1.50000000000 Anim = BSBluntSlide_range Type = Slide NoBlend = <NoBlend> 
	GrindBail = FiftyFiftyFall Extratricks = Extra_BS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_Bluntslide_FS Name = #"FS Bluntslide" 
	Grind { Name = <Name> Score = 250 GrindTweak = 18 initanim = Init_FSBluntSlide InitSpeed = 1.50000000000 Anim = FSBluntSlide_range Type = Slide NoBlend = <NoBlend> 
	GrindBail = BackwardsGrindBails Extratricks = Extra_FS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_NoseBluntSlide_BS Name = #"BS Nosebluntslide" 
	Grind { Name = <Name> Score = 250 GrindTweak = 18 initanim = Init_BSNoseblunt InitSpeed = 1.50000000000 Anim = BSNoseblunt_range Type = Slide NoBlend = <NoBlend> 
	GrindBail = BackwardsGrindBails Extratricks = Extra_BS_Grinds IsExtra = <IsExtra> Nollie = yes } 
ENDSCRIPT

SCRIPT Trick_NoseBluntSlide_FS Name = #"FS Nosebluntslide" 
	Grind { Name = <Name> Score = 250 GrindTweak = 18 initanim = Init_FSNoseblunt InitSpeed = 1.50000000000 Anim = FSNoseblunt_range Type = Slide NoBlend = <NoBlend> 
	GrindBail = FiftyFiftyFall Nollie = yes IsExtra = <IsExtra> Extratricks = Extra_FS_Grinds } 
ENDSCRIPT

SCRIPT Trick_Bluntslide_BS_180 
	FlipAndRotate 
	BoardRotateAfter 
	Goto Trick_Bluntslide_BS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_Bluntslide_FS_180 
	Rotate 
	BoardRotateAfter 
	Goto Trick_Bluntslide_FS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_Nosebluntslide_BS_180 
	Rotate 
	BoardRotateAfter 
	Goto Trick_NoseBluntSlide_BS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_Nosebluntslide_FS_180 
	Rotate 
	BoardRotateAfter 
	Goto Trick_NoseBluntSlide_FS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_Shortbus2 
	Grind { Name = #"Stupid Grind" Score = 400 initanim = Shortbus_Init Anim = Shortbus_idle Idle OutAnim = Shortbus_Out Type = Grind NoBlend = <NoBlend> 
	GrindBail = BackwardsGrindBails Nollie = yes IsSpecial OutAnimOnOllie Extratricks = Extra_BS_Grinds Extratricks = Extra_BS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_Shortbus2_180 
	Rotate 
	BoardRotateAfter 
	Goto Trick_Shortbus2 Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_RodneyGrind2 
	Grind { Name = #"Rodney Primo" Score = 400 initanim = RodneyGrind_Init Anim = RodneyGrind_range OutAnim = RodneyGrind_Out Type = Grind BoardRotate = yes 
	GrindBail = BackwardsGrindBails Nollie = yes IsSpecial InitSpeed = 0.69999998808 OutAnimOnOllie Extratricks = Extra_BS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_GrindNBarf2 
	Grind { Name = #"Grind N Barf" InitSpeed = 1.50000000000 Score = 400 initanim = GrindNBarf_Init Anim = GrindNBarf_range OutAnim = GrindNBarf_Out Type = Grind BoardRotate = yes 
	GrindBail = BackwardsGrindBails Nollie = yes IsSpecial OutAnimOnOllie Stream = DryHeaveSpecial Extratricks = Extra_BS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_RowleyDarkSlideHandStand2 
	Grind { Name = #"Darkslide Handstand" Score = 800 initanim = RowleyDarkSlideHandStand_Init Anim = RowleyDarkSlideHandStand_range OutAnim = RowleyDarkSlideHandStand_Out Type = Slide NoBlend = yes 
	GrindBail = BackwardsGrindBails IsSpecial OutAnimOnOllie Extratricks = Extra_BS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_RowleyDarkSlideHandStand2_180 
	Rotate 
	BoardRotateAfter 
	Goto Trick_RowleyDarkSlideHandStand2 Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_PrimoHandStand2 
	Grind { Name = #"Primo Handstand" Score = 800 initanim = PrimoHandStand_Init Anim = PrimoHandStand_range OutAnim = PrimoHandStand_Out Type = Slide NoBlend = yes 
	GrindBail = BackwardsGrindBails IsSpecial OutAnimOnOllie Stream = nj_pipeignite Extratricks = Extra_BS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_PrimoHandStand2_180 
	Rotate 
	BoardRotateAfter 
	Goto Trick_PrimoHandStand2 Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_OneFootDarkSlide2 
	Grind { Name = #"One Foot Darkslide" Score = 800 initanim = OneFootDarkSlide_Init Anim = OneFootDarkSlide_range OutAnim = OneFootDarkSlide_Out Type = Slide NoBlend = yes 
	GrindBail = BackwardsGrindBails IsSpecial OutAnimOnOllie Extratricks = Extra_BS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_OneFootDarkslide2_180 
	Rotate 
	BoardRotateAfter 
	Goto Trick_OneFootDarkSlide2 Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_FiftyFiftySwitcheroo2 
	Grind { Name = #"5050 Switcheroo" Score = 400 initanim = FiftyFiftySwitcheroo_Init Anim = FiftyFiftySwitcheroo_Idle Idle Type = Grind 
	GrindBail = BackwardsGrindBails IsSpecial Speed = 3 Extratricks = Extra_BS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_YeaRightSlide2 
	Grind { Name = #"Yeah Right Slide" Score = 400 initanim = YeaRightSlide_Init Anim = YeaRightSlide_range OutAnim = YeaRightSlide_Out Type = Slide 
	GrindBail = BackwardsGrindBails IsSpecial Extratricks = Extra_BS_Grinds OutAnimOnOllie SwitchBoardOff IsExtra = <IsExtra> } 
	spawnscript offboard 
ENDSCRIPT

SCRIPT offboard BoardOffFrame = 5 
	Wait <BoardOffFrame> frames 
	SwitchoffBoard 
ENDSCRIPT

SCRIPT Trick_YeaRightSlide2_180 
	Rotate 
	BoardRotateAfter 
	Goto Trick_YeaRightSlide2 Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_HCNHDF2 
	Grind { Name = #"Crooks DarkSlide" Score = 800 initanim = HCNHDF_Init Anim = HCNHDF_range OutAnim = HCNHDF_Out InitSpeed = 1.50000000000 Type = Slide NoBlend = yes 
	GrindBail = BackwardsGrindBails IsSpecial OutAnimOnOllie Extratricks = Extra_BS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_HCNHDF2_180 
	Rotate 
	BoardRotateAfter 
	Goto Trick_HCNHDF2 Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_FSNollie360FlipCrook2 
	Grind { Name = #"Nollie 360flip Crook" Score = 800 initanim = FSNollie360FlipCrook_Init Anim = FSNollie360FlipCrook_range OutAnim = FSNollie360FlipCrook_Out Type = Grind NoBlend = yes 
	GrindBail = BackwardsGrindBails IsSpecial OutAnimOnOllie Extratricks = Extra_BS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_FSNollie360FlipCrook2_180 
	Rotate 
	BoardRotateAfter 
	Goto Trick_FSNollie360FlipCrook2 Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_MoonwalkGrind2 
	Grind { Name = #"Moonwalk Five-O" Score = 800 initanim = Moonwalkgrind_Init Anim = Moonwalkgrind_idle Idle OutAnim = Moonwalkgrind_Out Type = Grind NoBlend = yes 
	GrindBail = BackwardsGrindBails IsSpecial OutAnimOnOllie Extratricks = Extra_BS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_MoonwalkGrind2_180 
	Rotate 
	BoardRotateAfter 
	Goto Trick_MoonwalkGrind2 Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_Thinkaboutitgrind2 
	Grind { Name = #"Levitate Grind" Score = 800 initanim = Thinkaboutitgrind_Init Anim = Thinkaboutitgrind_idle Idle OutAnim = Thinkaboutitgrind_Out Type = Grind NoBlend = yes 
	GrindBail = BackwardsGrindBails IsSpecial OutAnimOnOllie Extratricks = Extra_BS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_Thinkaboutitgrind2_180 
	Rotate 
	BoardRotateAfter 
	Goto Trick_Thinkaboutitgrind2 Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_360ShovitNoseGrind2 
	Grind { Name = #"360 Shovit NoseGrind" Score = 800 initanim = _360ShovitNoseGrind_Init Anim = _360ShovitNoseGrind_range InitSpeed = 2.00000000000 OutAnim = _360ShovitNoseGrind_Out Type = Grind NoBlend = yes 
	GrindBail = BackwardsGrindBails IsSpecial OutAnimOnOllie Extratricks = Extra_BS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_360ShovitNoseGrind2_180 
	Rotate 
	BoardRotateAfter 
	Goto Trick_360ShovitNoseGrind2 Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_Flames2 
	Grind { Name = #"Fire Fire Fire" Score = 800 initanim = Flames_Init Anim = Flames_Idle Idle OutAnim = Flames_Out Type = Slide NoBlend = yes 
	GrindBail = BackwardsGrindBails IsSpecial OutAnimOnOllie Extratricks = Extra_BS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_Flames2_180 
	Rotate 
	BoardRotateAfter 
	Goto Trick_Flames2 Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_BlastGrind2 
	Grind { Name = #"Fire Blaster" Score = 800 InitSpeed = 1.50000000000 initanim = BlastGrind_Init Anim = BlastGrind_Idle Idle OutAnim = BlastGrind_Out Type = Grind NoBlend = yes 
	GrindBail = BackwardsGrindBails IsSpecial OutAnimOnOllie Extratricks = Extra_BS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_BlastGrind2_180 
	Rotate 
	BoardRotateAfter 
	Goto Trick_BlastGrind2 Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_3DScaryGrind2 
	Grind { Name = #"Scary Grind" Score = 800 initanim = _3DScaryGrind_Init Anim = _3DScaryGrind_Range OutAnim = _3DScaryGrind_Out Stream = ClassicMonster01 Type = Grind NoBlend = yes 
	GrindBail = BackwardsGrindBails IsSpecial OutAnimOnOllie FullScreenEffect = CreatureScaryGrindEffect Extratricks = Extra_BS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_3DScaryGrind2_180 
	Rotate 
	BoardRotateAfter 
	Goto Trick_3DScaryGrind2 Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_CrookedSkull2 
	Grind { Name = #"Skull Grind" Score = 800 initanim = CrookedSkull_Init Anim = CrookedSkull_Idle Idle OutAnim = CrokkedSkull_Out Type = Grind NoBlend = yes 
	GrindBail = BackwardsGrindBails IsSpecial OutAnimOnOllie Nollie = yes Extratricks = Extra_BS_Grinds SpecialItem_details = skull_details IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_CrookedSkull2_180 
	Rotate 
	BoardRotateAfter 
	Goto Trick_CrookedSkull2 Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_Hurricane_BS 
	Grind { Name = #"BS Hurricane" Score = GRINDTAP_SCORE initanim = BSHurricaneGrind_Init InitSpeed = 1.50000000000 Anim = BSHurricaneGrind_Range OutAnim = Init_Tailgrind OutAnimBackwards = 1 Type = Grind RearTruckSparks NoBlend = <NoBlend> 
	GrindBail = BackwardsGrindBails Nollie = yes FlipBeforeOutAnim OutAnimOnOllie Extratricks = Extra_BS_Grinds IsATap IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_Hurricane_FS 
	Grind { Name = #"FS Hurricane" Score = GRINDTAP_SCORE initanim = FSHurricaneGrind_Init InitSpeed = 1.50000000000 Anim = FSHurricaneGrind_Range OutAnim = Nollie Type = Grind NoBlend = NoBlend 
	GrindBail = FiftyFiftyFall FlipBeforeOutAnim OutAnimOnOllie Extratricks = Extra_BS_Grinds IsATap IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_Hurricane_BS_180 
	Rotate 
	BoardRotateAfter 
	Goto Trick_Hurricane_BS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_Hurricane_FS_180 
	Rotate 
	BoardRotateAfter 
	Goto Trick_Hurricane_FS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_Darkslide_BS 
	Grind { Name = #"BS Darkslide" Score = GRINDTAP_SCORE initanim = Darkslide_Init InitSpeed = 1.50000000000 Anim = Darkslide_Range OutAnim = Darkslide_Out Type = Slide NoBlend = <NoBlend> 
	GrindBail = BackwardsGrindBails OutAnimOnOllie BoardRotate = yes Extratricks = Extra_BS_Grinds IsATap IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_Darkslide_FS 
	Grind { Name = #"FS Darkslide" Score = GRINDTAP_SCORE initanim = FSDarkSlide_Init InitSpeed = 1.50000000000 Anim = FSDarkSlide_Range OutAnim = FSDarkSlide_Out Type = Slide NoBlend = <NoBlend> 
	GrindBail = FiftyFiftyFall OutAnimOnOllie BoardRotate = yes Extratricks = Extra_BS_Grinds IsATap IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_Darkslide_BS_180 
	Rotate 
	BoardRotateAfter 
	Goto Trick_Darkslide_BS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_Darkslide_FS_180 
	Rotate 
	BoardRotateAfter 
	Goto Trick_Darkslide_FS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_Coffin_BS 
	Grind { Name = #"BS Coffin" Score = 500 initanim = CoffinGrind_Init Anim = CoffinGrind_Range OutAnim = CoffinGrind_Out Type = Grind NoBlend = <NoBlend> 
	GrindBail = FiftyFiftyFall IsSpecial OutAnimOnOllie Extratricks = Extra_BS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_Coffin_FS 
	Grind { Name = #"FS Coffin" Score = 500 initanim = CoffinGrind_Init Anim = CoffinGrind_Range OutAnim = CoffinGrind_Out Type = Grind NoBlend = <NoBlend> 
	GrindBail = FiftyFiftyFall IsSpecial OutAnimOnOllie Extratricks = Extra_BS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_Coffin_BS_180 
	Rotate 
	BoardRotateAfter 
	Goto Trick_Coffin_BS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_Coffin_FS_180 
	Rotate 
	BoardRotateAfter 
	Goto Trick_Coffin_FS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_fandangle_BS 
	Grind { Name = #"BS Fandangle" Score = 500 initanim = fandangle_Init Anim = fandangle_Range OutAnim = Fandangle_Out Type = Grind NoBlend = <NoBlend> 
	GrindBail = FiftyFiftyFall IsSpecial Extratricks = Extra_BS_Grinds OutAnimOnOllie BoardRotate = yes Extratricks = Extra_FS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_fandangle_FS 
	Grind { Name = #"FS Fandangle" Score = 500 initanim = fandangle_Init Anim = fandangle_Range OutAnim = Fandangle_Out Type = Grind NoBlend = <NoBlend> 
	GrindBail = FiftyFiftyFall IsSpecial Extratricks = Extra_FS_Grinds OutAnimOnOllie BoardRotate = yes Extratricks = Extra_FS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_fandangle_BS_180 
	Rotate 
	BoardRotateAfter 
	Goto Trick_fandangle_BS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_fandangle_FS_180 
	Rotate 
	BoardRotateAfter 
	Goto Trick_fandangle_FS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_CrailSlide_BS 
	Grind { Name = #"BS Crail Slide" Score = GRINDTAP_SCORE initanim = CrailSlide_Init Anim = CrailSlide_Range OutAnim = CrailSlide_Out Type = Grind NoBlend = <NoBlend> 
	GrindBail = FiftyFiftyFall Extratricks = Extra_BS_Grinds OutAnimOnOllie Extratricks = Extra_BS_Grinds IsATap IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_CrailSlide_FS 
	Grind { Name = #"FS Crail Slide" Score = GRINDTAP_SCORE initanim = CrailSlide_Init Anim = CrailSlide_Range OutAnim = CrailSlide_Out Type = Grind NoBlend = <NoBlend> 
	GrindBail = FiftyFiftyFall Extratricks = Extra_FS_Grinds OutAnimOnOllie Extratricks = Extra_BS_Grinds IsATap IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_CrailSlide_BS_180 
	Rotate 
	BoardRotateAfter 
	Goto Trick_CrailSlide_BS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_CrailSlide_FS_180 
	Rotate 
	BoardRotateAfter 
	Goto Trick_CrailSlide_FS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_GrindOverturn_BS 
	Grind { Name = #"BS 5-0 Overturn" Score = GRINDTAP_SCORE initanim = GrindOverturn_Init Anim = GrindOverturn_Range OutAnim = Init_Nosegrind OutAnimBackwards = 1 Type = Grind RearTruckSparks NoBlend = <NoBlend> 
	GrindBail = FiftyFiftyFall FlipBeforeOutAnim Extratricks = Extra_BS_Grinds Nollie = 1 Extratricks = Extra_BS_Grinds IsATap IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_GrindOverturn_FS 
	Grind { Name = #"FS 5-0 Overturn" Score = GRINDTAP_SCORE initanim = GrindOverturn_Init Anim = GrindOverturn_Range OutAnim = Init_Nosegrind OutAnimBackwards = 1 Type = Grind RearTruckSparks NoBlend = <NoBlend> 
	GrindBail = FiftyFiftyFall FlipBeforeOutAnim Extratricks = Extra_FS_Grinds Nollie = 1 Extratricks = Extra_BS_Grinds IsATap IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_GrindOverturn_BS_180 
	Rotate 
	BoardRotateAfter 
	Goto Trick_GrindOverturn_BS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_GrindOverturn_FS_180 
	Rotate 
	BoardRotateAfter 
	Goto Trick_GrindOverturn_FS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_HangTenNoseGrind_BS 
	Grind { Name = #"Hang Ten Nosegrind" Score = GRINDTAP_SCORE initanim = HangTenNoseGrind_Init InitSpeed = 1.50000000000 Anim = HangTenNoseGrind_Range OutAnim = HangTenNoseGrind_Out Type = Grind NoBlend = <NoBlend> 
	GrindBail = FiftyFiftyFall Extratricks = Extra_BS_Grinds Nollie Extratricks = Extra_BS_Grinds IsATap IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_HangTenNoseGrind_FS 
	Grind { Name = #"Hang Ten Nosegrind" Score = GRINDTAP_SCORE initanim = HangTenNoseGrind_Init InitSpeed = 1.50000000000 Anim = HangTenNoseGrind_Range OutAnim = HangTenNoseGrind_Out Type = Grind NoBlend = <NoBlend> 
	GrindBail = FiftyFiftyFall Extratricks = Extra_FS_Grinds Nollie Extratricks = Extra_BS_Grinds IsATap IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_HangTenNoseGrind_BS_180 
	Rotate 
	BoardRotateAfter 
	Goto Trick_HangTenNoseGrind_BS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_HangTenNoseGrind_FS_180 
	Rotate 
	BoardRotateAfter 
	Goto Trick_HangTenNoseGrind_FS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_RowleyDarkSlide_BS 
	Grind { Name = #"Rowley Darkslide" Score = 500 initanim = RowleyDarkSlide_Init Anim = RowleyDarkSlide_Range OutAnim = RowleyDarkSlide_out Type = Slide NoBlend = <NoBlend> 
	GrindBail = Nutter IsSpecial OutAnimOnOllie BoardRotate = yes Extratricks = Extra_BS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_RowleyDarkSlide_FS 
	Goto Trick_RowleyDarkSlide_BS 
ENDSCRIPT

SCRIPT Trick_RowleyDarkSlide_BS_180 
	Rotate 
	BoardRotateAfter 
	Goto Trick_RowleyDarkSlide_BS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_RowleyDarkSlide_FS_180 
	Goto Trick_RowleyDarkSlide_BS_180 
ENDSCRIPT

SCRIPT Trick_BigHitter_BS Extratricks = Extra_BS_Grinds 
	Grind { Name = #"Big Hitter II" Score = 500 initanim = BigHitter_Init Anim = BigHitter_Range OutAnim = BigHitter_out Type = Slide NoBlend = <NoBlend> 
	GrindBail = Nutter IsSpecial Extratricks = <Extratricks> OutAnimOnOllie } 
ENDSCRIPT

SCRIPT Trick_BigHitter_FS 
	Goto Trick_BigHitter_BS Params = { Extratricks = Extra_FS_Grinds } 
ENDSCRIPT

SCRIPT Trick_BigHitter_BS_180 
	Rotate 
	BoardRotateAfter 
	Goto Trick_BigHitter_BS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_BigHitter_FS_180 
	Goto Trick_BigHitter_BS_180 
ENDSCRIPT

SCRIPT Trick_NosegrindPivot_BS 
	Grind { Name = #"Nosegrind to Pivot" Score = GRINDTAP_SCORE initanim = NosegrindPivot_Init InitSpeed = 1.75000000000 Anim = NosegrindPivot_Range OutAnim = Init_Tailgrind OutAnimBackwards = 1 Type = Grind FrontTruckSparks NoBlend = NoBlend 
	GrindBail = FiftyFiftyFall BoardRotate = yes FlipBeforeOutAnim EarlyOut = Init_Tailgrind Extratricks = Extra_BS_Grinds IsATap IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_NosegrindPivot_FS 
	Goto Trick_NosegrindPivot_BS Params = { IsExtra = IsExtra } 
ENDSCRIPT

SCRIPT Trick_NosegrindPivot_BS_180 
	Rotate 
	BoardRotateAfter 
	Goto Trick_NosegrindPivot_BS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_NosegrindPivot_FS_180 
	Goto Trick_NosegrindPivot_BS_180 
ENDSCRIPT

SCRIPT Trick_TailblockSlide_BS 
	Grind { Name = #"Tailblock Slide" Score = 500 initanim = TailblockSlide_Init Anim = TailblockSlide_Range OutAnim = TailblockSlide_Init Type = Slide NoBlend = <NoBlend> 
	GrindBail = Nutter Extratricks = <Extratricks> IsSpecial Extratricks = Extra_BS_Grinds } 
ENDSCRIPT

SCRIPT Trick_TailblockSlide_FS 
	Goto Trick_TailblockSlide_BS Params = { Extratricks = Extra_FS_Grinds } 
ENDSCRIPT

SCRIPT Trick_TailblockSlide_BS_180 
	Rotate 
	BoardRotateAfter 
	Goto Trick_TailblockSlide_BS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_TailblockSlide_FS_180 
	Goto Trick_TailblockSlide_BS_180 
ENDSCRIPT

SCRIPT Trick_DrunkGrind_BS 
	Grind { Name = #"S.U.I Grind" Score = 500 initanim = DrunkGrind_Init Anim = DrunkGrind_Idle Type = Grind NoBlend = <NoBlend> 
	GrindBail = Nutter IsSpecial OutAnimOnOllie Extratricks = Extra_FS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_Salad_FS Name = #"FS Salad" 
	Grind { Name = <Name> Score = 125 GrindTweak = 9 initanim = FSSaladGrind_Init InitSpeed = 1.50000000000 Anim = FSSaladGrind_range Type = Grind NoBlend = <NoBlend> 
	GrindBail = Nutter Extratricks = Extra_FS_Grinds IsATap IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_Salad_BS Name = #"BS Salad" 
	Grind { Name = <Name> Score = 125 GrindTweak = 9 initanim = BSSaladGrind_Init InitSpeed = 1.50000000000 Anim = BSSaladGrind_range Type = Grind NoBlend = <NoBlend> 
	GrindBail = Nutter Extratricks = Extra_BS_Grinds IsATap IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_Salad_FS_180 
	FlipAndRotate 
	Goto Trick_Salad_BS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_Salad_BS_180 
	FlipAndRotate 
	Goto Trick_Salad_FS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_NoseSlideLipSlide_FS 
	IF BadLedge 
		Goto Trick_NoseSlideLipSlide_BS_ok 
	ELSE 
		Goto Trick_NoseSlideLipSlide_FS_ok 
	ENDIF 
ENDSCRIPT

SCRIPT Trick_NoseSlideLipSlide_FS_ok Name = #"FS Noseslide LipSlide" 
	Grind { Name = <Name> Score = GRINDTAP_SCORE initanim = FSNoseSlideLipSlide Anim = BSBoardslide_range Type = Slide Nollie = yes NoBlend = <NoBlend> 
	GrindBail = Nutter Extratricks = Extra_FS_Grinds IsSpecial IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_NoseSlideLipSlide_BS 
	IF BadLedge 
		Goto Trick_NoseSlideLipSlide_FS_ok 
	ELSE 
		Goto Trick_NoseSlideLipSlide_BS_ok 
	ENDIF 
ENDSCRIPT

SCRIPT Trick_NoseSlideLipSlide_BS_ok Name = #"BS NoseSlide LipSlide" 
	Grind { Name = <Name> Score = GRINDTAP_SCORE initanim = BSNoseSlideLipSlide Anim = FSBoardslide_range Type = Slide Nollie = yes NoBlend = <NoBlend> 
	GrindBail = FiftyFiftyFall Extratricks = Extra_BS_Grinds IsSpecial IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_NoseSlideLipSlide_FS_180 
	FlipAndRotate 
	BoardRotateAfter 
	Goto Trick_NoseSlideLipSlide_BS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_NoseSlideLipSlide_BS_180 
	FlipAndRotate 
	BoardRotateAfter 
	Goto Trick_NoseSlideLipSlide_FS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_CrookedBigSpin_BS 
	Grind { Name = #"Crook BigSpinFlip Switch FS Crook" Score = 500 special_item initanim = CrookBigSpinFlipCrook Anim = FSCrooked_range OutAnim = Init_FSCrooked OutAnimBackwards Type = Grind NoBlend = <NoBlend> 
	GrindBail = BackwardsGrindBails IsSpecial FlipAfterInit Extratricks = Extra_FS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_CrookedBigSpin_FS 
	Goto Trick_CrookedBigSpin_BS Params = { NoBlend = yes Name = #"Overcrook BigSpinFlip Overcrook" } 
ENDSCRIPT

SCRIPT Trick_CrookedBigSpin_BS_180 
	Rotate 
	BoardRotateAfter 
	Goto Trick_CrookedBigSpin_BS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_CrookedBigSpin_FS_180 
	Goto Trick_CrookedBigSpin_BS_180 
ENDSCRIPT

SCRIPT Trick_FlipKickDad2 
	Grind { Name = #"Flip Kick Dad" Score = 500 initanim = FlipKickDad_Init Anim = FlipKickDad Stream = FlipKickD Type = Grind NoBlend = <NoBlend> Idle 
	GrindBail = FiftyFiftyFall ScreenShake = 45 IsSpecial Extratricks = Extra_BS_Grinds IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_FlipKickDad2_180 
	Rotate 
	BoardRotateAfter 
	Goto Trick_FlipKickDad2 Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_50Fingerflip2 
	Grind { Name = #"5-0 Fingerflip Nosegrind" Score = 500 initanim = TailGrindFingerFlip Anim = NoseGrind_Range Type = Grind NoBlend = <NoBlend> 
	GrindBail = FiftyFiftyFall IsSpecial Extratricks = Extra_BS_Grinds } 
ENDSCRIPT

SCRIPT Trick_50Fingerflip2_180 
	BackwardsGrind Grind = Trick_50Fingerflip2 
ENDSCRIPT

SCRIPT Trick_SprayPaintGrind2 
	Grind { Name = #"Ghetto Tag Grind" Score = 500 initanim = SprayPaint_Init Anim = SprayPaint_Range OutAnim = SprayPaint_Out Type = Grind NoBlend = <NoBlend> 
	GrindBail = FiftyFiftyFall IsSpecial Extratricks = Extra_FS_Grinds OutAnimOnOllie Stream = GhettoTagGrind SpecialItem_details = SprayCan_Details } 
ENDSCRIPT

SCRIPT Trick_SprayPaintGrind2_180 
	BackwardsGrind Grind = Trick_SprayPaintGrind2 
ENDSCRIPT

SCRIPT Trick_DaffyBrokenGrind2 
	Grind { Name = #"Daffy Grind" Score = 500 initanim = DaffyBroken_Init Anim = DaffyBroken_Range Type = Grind NoBlend = <NoBlend> 
	GrindBail = FiftyFiftyFall IsSpecial Extratricks = Extra_FS_Grinds SpecialItem_details = bustedboard_details } 
ENDSCRIPT

SCRIPT Trick_DaffyBrokenGrind2_180 
	BackwardsGrind Grind = Trick_DaffyBrokenGrind2 
ENDSCRIPT

SCRIPT Trick_GuitarSlide2 
	Grind { Name = #"Faction Guitar Slide" Score = 500 initanim = Guitar_Init Anim = Guitar_Idle Idle Type = Slide NoBlend = <NoBlend> 
	GrindBail = BackwardsGrindBails Extratricks = Extra_FS_Grinds Stream = GuitarSlide SpecialItem_details = Guitar_Details IsSpecial } 
ENDSCRIPT

SCRIPT Trick_GuitarSlide2_180 
	BackwardsGrind Grind = Trick_GuitarSlide2 
ENDSCRIPT

SCRIPT Trick_AmericanHero2 
	Grind { Name = #"American Tribute" Score = 500 initanim = AmericanHeroGrind_Init Anim = AmericanHeroGrind_Idle OutAnim = AmericanHeroGrind_out Idle Type = Grind NoBlend = <NoBlend> 
	GrindBail = BackwardsGrindBails Extratricks = Extra_FS_Grinds IsSpecial SpecialItem_details = flag_Details SpecialSounds = Jamie_HeroSounds } 
ENDSCRIPT

SCRIPT Trick_AmericanHero2_180 
	BackwardsGrind Grind = Trick_AmericanHero2 
ENDSCRIPT

SCRIPT Trick_BballSlide2_180 
	BackwardsGrind Grind = Trick_BballSlide2 
ENDSCRIPT

SCRIPT Trick_DoubleBluntSlide2 
	Grind { Name = #"Double Blunt Slide" Score = GRINDTAP_SCORE initanim = DoubleBlunt_Init InitSpeed = 1.50000000000 Anim = DoubleBlunt_Idle Idle Type = Slide NoBlend = <NoBlend> 
	GrindBail = BackwardsGrindBails Extratricks = Extra_FS_Grinds IsATap IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_DoubleBluntSlide2_180 
	BackwardsGrind Grind = Trick_DoubleBluntSlide2 
ENDSCRIPT

SCRIPT Trick_ElbowSmash2 
	Grind { Name = #"Elbow Smash" Score = 500 initanim = ElbowSmash_Init Anim = ElbowSmash_Idle Idle OutAnim = Elbowsmash_out OutAnimOnOllie Type = Slide NoBlend = <NoBlend> Idle 
	GrindBail = FiftyFiftyFall ScreenShake = 60 IsSpecial } 
ENDSCRIPT

SCRIPT Trick_ElbowSmash2_180 
	Rotate 
	BoardRotateAfter 
	Goto Trick_ElbowSmash2 Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_OneFootSmith_FS Name = #"FS One Foot Smith" 
	Grind { Name = <Name> Score = 500 initanim = SmithFS_Init Anim = SmithFS_Range Type = Slide NoBlend = <NoBlend> 
	GrindBail = Nutter Extratricks = Extra_FS_Grinds IsSpecial IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_OneFootSmith_BS Name = #"BS One Foot Smith" 
	Grind { Name = <Name> Score = 500 initanim = Smith_Init Anim = Smith_Range Type = Grind NoBlend = <NoBlend> 
	GrindBail = Nutter Extratricks = Extra_BS_Grinds IsSpecial IsExtra = <IsExtra> } 
ENDSCRIPT

SCRIPT Trick_OneFootSmith_FS_180 
	FlipAndRotate 
	Goto Trick_OneFootSmith_BS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT Trick_OneFootSmith_BS_180 
	FlipAndRotate 
	Goto Trick_OneFootSmith_FS Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT BackwardsGrind 
	Rotate 
	BoardRotateAfter 
	Goto <Grind> Params = { NoBlend = yes } 
ENDSCRIPT

SCRIPT PointRail 
	Vibrate Actuator = 0 Percent = 50 Duration = 0.10000000149 
	Obj_SpawnScript PointRailSparks 
	BroadcastEvent Type = SkaterPointRail 
	SetTrickName #"Kissed the Rail" 
	SetTrickScore 50 
	Display 
	Goto Airborne Params = { AllowVibration } 
ENDSCRIPT

SCRIPT PointRailSparks 
	SetRearTruckSparks 
	SparksOn RailNotRequired 
	Wait 0.20000000298 seconds 
	SparksOff 
ENDSCRIPT


