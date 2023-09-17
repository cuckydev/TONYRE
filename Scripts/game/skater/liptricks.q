LIPTRICK_DISPLAY_WAIT = 15 
DefaultLipTrick = { Name = #"Nose Stall" Score = 300 CopingHit = 1 InitAnim = NoseTailStall_init Anim = NoseTailStall_range OutAnim = NoseTailStall_out BoardRotate RotateOnOllie FlipOnOllie ReleaseFrame = 20 ComboLip ExtraTricks = LipTrickExtras } 
Trick_Blunt = { Scr = LipMacro2 Params = { Name = #"Blunt to Fakie" CopingHit = 5 Score = 500 InitAnim = BluntToFakie_init Anim = BluntToFakie_range OutAnim = BluntToFakie_out BoardRotate ExtraTricks = LipTrickExtras } } 
Trick_MuteInvert = { Scr = LipMacro2 Params = { Name = #"Invert" Score = 500 InitAnim = MuteInvert_init Anim = MuteInvert_range OutAnim = MuteInvert_out NoOllie BoardRotate ExtraTricks = InvertExtras } } 
Trick_Eggplant = { Scr = LipMacro2 Params = { Name = #"Eggplant" Score = 550 InitAnim = EggPlant_init Anim = EggPlant_range OutAnim = EggPlant_out NoOllie FlipAfter RevertBS ExtraTricks = InvertExtras } } 
Trick_GymnastPlant = { Scr = LipMacro2 Params = { Name = #"Gymnast Plant" Score = 575 InitAnim = GymnastPlant_init Anim = GymnastPlant_range OutAnim = GymnastPlant_out NoOllie FlipAfter RevertBS ExtraTricks = InvertExtras } } 
Trick_RockToFakie = { Scr = LipMacro2 Params = { Name = #"Rock to Fakie" Score = 500 CopingHit = 1 InitAnim = FakieRockAndRoll_init Anim = FakieRockAndRoll_range OutAnim = FakieRockAndRoll_out BoardRotate ExtraTricks = LipTrickExtras } } 
Trick_Disaster = { Scr = LipMacro2 Params = { Name = #"Disaster" Score = 600 CopingHit = 20 InitAnim = Disaster_init Anim = Disaster_range OutAnim = Disaster_out FlipAfter RotateOnOllie ExtraTricks = LipTrickExtras } } 
Trick_Invert = { Scr = LipMacro2 Params = { Name = #"Varial Invert to Fakie" Score = 450 InitAnim = Invert_init Anim = Invert_range OutAnim = Invert_out NoOllie BoardRotate RevertBS ExtraTricks = InvertExtras } } 
Trick_OneFootInvert = { Scr = LipMacro2 Params = { Name = #"One Foot Invert" Score = 500 InitAnim = OneFootInvert_init Anim = OneFootInvert_range OutAnim = OneFootInvert_out NoOllie BoardRotate ReleaseFrame = 30 RevertBS ExtraTricks = InvertExtras } } 
Trick_BSFootplant = { Scr = LipMacro2 Params = { Name = #"BS Boneless" Score = 550 InitAnim = BSFootplant_init Anim = BSFootplant_range OutAnim = BSFootplant_out OllieOutAnim = BSFootplant_OllieOut FlipAfter UseBoneless ReleaseFrame = 20 BailScript = FaceSmash RevertBS ExtraTricks = LipTrickExtras } } 
Trick_AxleStall = { Scr = LipMacro2 Params = { Name = #"Axle Stall" Score = 400 CopingHit = 8 InitAnim = AxleStall_init Anim = AxleStall_range OutAnim = AxleStall_out OllieOutAnim = AxleStall_OllieOut FlipAfter ExtraTricks = LipTrickExtras } } 
Trick_Nosepick = { Scr = LipMacro2 Params = { Name = #"FS Nosepick" Score = 550 CopingHit = 15 InitAnim = FSIndyNosepick_init Anim = FSIndyNosepick_range OutAnim = FSIndyNosepick_out FlipAfter RotateOnOllie ExtraTricks = LipTrickExtras } } 
Trick_Noseblunt = { Scr = LipMacro2 Params = { Name = #"FS Noseblunt" Score = 550 CopingHit = 20 InitAnim = FS180Noseblunt_init Anim = FS180Noseblunt_range OutAnim = FS180Noseblunt_out FlipAfter RotateOnOllie ExtraTricks = LipTrickExtras } } 
Trick_AndrectInvert = { Scr = LipMacro2 Params = { Name = #"Andrecht Invert" Score = 550 InitAnim = AndrectInvert_init Anim = AndrectInvert_range OutAnim = AndrectInvert_out NoOllie FlipAfter BoardRotate ExtraTricks = InvertExtras ReleaseFrame = 20 } } 
Trick_Switcheroo = { Scr = LipMacro2 Params = { Name = #"The Switcheroo" Score = 600 InitAnim = Switcheroo_Init Anim = Switcheroo_range OutAnim = Switcheroo_Out NoOllie BoardRotate FlipAfter ExtraTricks = InvertExtras ReleaseFrame = 30 } } 
Trick_Russian = { Scr = LipMacro2 Params = { Name = #"Russian Boneless" Score = 3000 InitAnim = BSFootplant_init PingPong Anim = Russian_Idle OutAnim = Russian_out OllieOutAnim = Russian_OllieOut FlipAfter UseBoneless ReleaseFrame = 20 BailScript = FaceSmash RevertBS ExtraTricks = LipTrickExtras IsSpecial } } 
Trick_HoHoSadplant = { Scr = LipMacro2 Params = { Name = #"Ho Ho Sad Plant" Score = 3500 InitAnim = HoHoSadPlant_Init PingPong Anim = HoHoSadPlant_Idle OutAnim = HoHoSadPlant_Out IsSpecial NoOllie } } 
Trick_HeelflipFSInvert = { Scr = LipMacro2 Params = { Name = #"Heelflip FS Invert" Score = 3200 InitAnim = HeelflipFSInvert_init Anim = HeelflipFSInvert_range OutAnim = HeelflipFSInvert_out NoOllie IsSpecial FlipAfter RevertBS ExtraTricks = InvertExtras } } 
Trick_1990Invert = { Scr = LipMacro2 Params = { Name = #"1990 Invert" Score = 3500 InitAnim = _1990Invert_init Anim = _1990Invert_idle Idle OutAnim = _1990Invert_out NoOllie BoardRotate RevertBS NoOllie IsSpecial ExtraTricks = InvertExtras } } 
SpecialLipTricks = 
[ 
	{ Trigger = { TripleInOrder , Up , Right , Triangle , 1000 } TrickSlot = SpLip_U_R_Triangle } 
	{ Trigger = { TripleInOrder , Up , Down , Triangle , 1000 } TrickSlot = SpLip_U_D_Triangle } 
	{ Trigger = { TripleInOrder , Up , Left , Triangle , 1000 } TrickSlot = SpLip_U_L_Triangle } 
	{ Trigger = { TripleInOrder , Right , Up , Triangle , 1000 } TrickSlot = SpLip_R_U_Triangle } 
	{ Trigger = { TripleInOrder , Right , Down , Triangle , 1000 } TrickSlot = SpLip_R_D_Triangle } 
	{ Trigger = { TripleInOrder , Right , Left , Triangle , 1000 } TrickSlot = SpLip_R_L_Triangle } 
	{ Trigger = { TripleInOrder , Down , Up , Triangle , 1000 } TrickSlot = SpLip_D_U_Triangle } 
	{ Trigger = { TripleInOrder , Down , Right , Triangle , 1000 } TrickSlot = SpLip_D_R_Triangle } 
	{ Trigger = { TripleInOrder , Down , Left , Triangle , 1000 } TrickSlot = SpLip_D_L_Triangle } 
	{ Trigger = { TripleInOrder , Left , Up , Triangle , 1000 } TrickSlot = SpLip_L_U_Triangle } 
	{ Trigger = { TripleInOrder , Left , Right , Triangle , 1000 } TrickSlot = SpLip_L_R_Triangle } 
	{ Trigger = { TripleInOrder , Left , Down , Triangle , 1000 } TrickSlot = SpLip_L_D_Triangle } 
	{ Trigger = { TripleInOrder , a = Up , b = Up , Triangle , 1000 } TrickSlot = SpLip_U_U_Triangle } 
] 
LipTricks = 
[ 
	{ Trigger = { Press , UpLeft , 500 } TrickSlot = Lip_TriangleUL } 
	{ Trigger = { Press , UpRight , 500 } TrickSlot = Lip_TriangleUR } 
	{ Trigger = { Press , DownLeft , 500 } TrickSlot = Lip_TriangleDL } 
	{ Trigger = { Press , DownRight , 500 } TrickSlot = Lip_TriangleDR } 
	{ Trigger = { Press , Left , 500 } TrickSlot = Lip_TriangleL } 
	{ Trigger = { Press , Right , 500 } TrickSlot = Lip_TriangleR } 
	{ Trigger = { Press , Down , 500 } TrickSlot = Lip_TriangleD } 
	{ Trigger = { Press , Up , 500 } TrickSlot = Lip_TriangleU } 
	{ Trigger = { Press , Triangle , 1000 } Scr = LipMacro2 Params = DefaultLipTrick } 
] 
ComboLipTricks = 
[ 
	{ Trigger = { Press , UpLeft , 500 } TrickSlot = Lip_TriangleUL } 
	{ Trigger = { Press , UpRight , 500 } TrickSlot = Lip_TriangleUR } 
	{ Trigger = { Press , DownLeft , 500 } TrickSlot = Lip_TriangleDL } 
	{ Trigger = { Press , DownRight , 500 } TrickSlot = Lip_TriangleDR } 
	{ Trigger = { Press , Left , 500 } TrickSlot = Lip_TriangleL } 
	{ Trigger = { Press , Right , 500 } TrickSlot = Lip_TriangleR } 
	{ Trigger = { Press , Down , 500 } TrickSlot = Lip_TriangleD } 
	{ Trigger = { Press , Up , 500 } TrickSlot = Lip_TriangleU } 
	{ Trigger = { Press , Triangle , 500 } DefaultLipTrick } 
] 
LipTrickExtras = 
[ 
	{ Trigger = { InOrder , a = Circle , b = Circle , 300 } Trick_AxleStall } 
	{ Trigger = { InOrder , Circle , Square , 300 } Trick_BSFootplant } 
	{ Trigger = { InOrder , a = Square , b = Square , 300 } Trick_Disaster } 
	{ Trigger = { InOrder , Square , Circle , 300 } Trick_RockToFakie } 
	{ Trigger = { InOrder , a = Triangle , b = Triangle , 300 } Trick_Noseblunt } 
	{ Trigger = { InOrder , Triangle , Square , 300 } Trick_Nosepick } 
	{ Trigger = { InOrder , Triangle , Circle , 300 } Trick_Blunt } 
] 
InvertExtras = 
[ 
	{ Trigger = { InOrder , a = Square , b = Square , 300 } Trick_OneFootInvert } 
	{ Trigger = { InOrder , a = Triangle , b = Triangle , 300 } Trick_MuteInvert } 
	{ Trigger = { InOrder , a = Circle , b = Circle , 300 } Trick_GymnastPlant } 
	{ Trigger = { InOrder , Circle , Square , 300 } Trick_Invert } 
	{ Trigger = { InOrder , Square , Circle , 300 } Trick_Eggplant } 
	{ Trigger = { InOrder , Triangle , Circle , 300 } Trick_AndrectInvert } 
] 
AndrectExtras = 
{ Trigger = { InOrder , Triangle , Triangle , 500 } Trick_Switcheroo } 
SCRIPT LipMacro2 
	SetSkaterCamLerpReductionTimer time = 10 
	IF BailIsOn 
		SetState Air 
		Goto LipBail 
	ENDIF 
	KillExtraTricks 
	BailOff 
	SetState Lip 
	ClearExceptions 
	ClearTrickQueue 
	SetQueueTricks NoTricks 
	IF Obj_FlagSet FLAG_SKATER_LIPTRICK_CAM_REVERSED 
		SetException Ex = OffMeterTop Scr = LipOut Params = { <...> } 
		IF SkateInAble Lip 
			SetException Ex = OffMeterBottom Scr = LipOut Params = { spine y = -24 <...> } 
		ELSE 
			SetException Ex = OffMeterBottom Scr = LipBail Params = { <...> } 
		ENDIF 
	ELSE 
		SetException Ex = OffMeterBottom Scr = LipOut Params = { <...> } 
		IF SkateInAble Lip 
			SetException Ex = OffMeterTop Scr = LipOut Params = { spine y = -24 <...> } 
		ELSE 
			SetException Ex = OffMeterTop Scr = LipBail Params = { <...> } 
		ENDIF 
	ENDIF 
	SetException Ex = SkaterCollideBail Scr = SkaterCollideBail 
	SetEventHandler Ex = MadeOtherSkaterBail Scr = MadeOtherSkaterBail_Called 
	LaunchStateChangeEvent State = Skater_OnLip 
	SetQueueTricks NoTricks 
	IF GotParam NoOllie 
		SetException Ex = Ollied Scr = LipOut Params = { <...> } 
	ELSE 
		SetException Ex = Ollied Scr = OllieLipOut Params = { <...> } 
	ENDIF 
	GetTerrain 
	IF GotParam CopingHit 
		Obj_SpawnScript CopingHit Params = { <...> } 
	ENDIF 
	SetTrickName <Name> 
	SetTrickScore <Score> 
	IF GotParam BloodFrame 
		Obj_SpawnScript LipBlood Params = { <...> } 
	ENDIF 
	IF Obj_FlagSet FLAG_SKATER_LIPCOMBO 
		BlendPeriodOut 0.00000000000 
		IF GotParam ComboLip 
			Flip 
			BoardRotate 
		ENDIF 
		DoBalanceTrick ButtonA = Right ButtonB = Left Type = Lip PlayRangeAnimBackwards 
		IF GotParam NoOllie 
			IF GotParam InitAnim 
				IF NOT GotParam Isextra 
					Playanim Anim = <InitAnim> 
					WaitAnimFinished 
				ELSE 
					BlendPeriodOut 0.30000001192 
					Wait LIPTRICK_DISPLAY_WAIT frames 
				ENDIF 
			ELSE 
				Wait LIPTRICK_DISPLAY_WAIT frames 
			ENDIF 
		ELSE 
			IF GotParam InitAnim 
				IF GotParam Isextra 
					BlendPeriodOut 0.20000000298 
				ENDIF 
				Playanim Anim = <InitAnim> 
				WaitAnimFinished 
			ELSE 
				Wait LIPTRICK_DISPLAY_WAIT frames 
			ENDIF 
		ENDIF 
		IF GotParam Isextra 
			LaunchExtraMessage 
		ENDIF 
		PlayLipBalancingAnim <...> 
		Display Blockspin 
	ELSE 
		IF GotParam Isextra 
			LaunchExtraMessage 
			IF GotParam NoOllie 
				PlayLipBalancingAnim <...> 
				Display Blockspin 
				Wait 40 frames 
			ELSE 
				Playanim Anim = <InitAnim> 
				Display Blockspin 
				WaitAnimFinished 
				PlayLipBalancingAnim <...> 
			ENDIF 
		ELSE 
			IF GotParam InitAnim 
				Playanim Anim = <InitAnim> 
				Wait LIPTRICK_DISPLAY_WAIT frames 
				Display Blockspin 
				WaitAnimFinished 
			ENDIF 
			PlayLipBalancingAnim <...> 
		ENDIF 
	ENDIF 
	IF GotParam IsSpecial 
		LaunchSpecialMessage 
	ENDIF 
	IF GotParam RevertFS 
		Obj_SetFlag FLAG_SKATER_REVERTFS 
	ENDIF 
	IF GotParam RevertBS 
		Obj_SetFlag FLAG_SKATER_REVERTBS 
	ENDIF 
	IF GotParam ExtraTricks 
		SetExtraTricks tricks = <ExtraTricks> ignore = <Name> 
	ENDIF 
	IF NOT GotParam NoBalance 
		BEGIN 
			Tweaktrick 10 
			Wait 1 Gameframe 
		REPEAT 
	ELSE 
		Goto LipOut Params = { <...> } 
	ENDIF 
ENDSCRIPT

SCRIPT PlayLipBalancingAnim 
	IF NOT GotParam NoBalance 
		DoBalanceTrick ButtonA = Right ButtonB = Left Type = Lip PlayRangeAnimBackwards 
		IF GotParam PingPong 
			Playanim Anim = <Anim> PingPong 
		ELSE 
			Playanim Anim = <Anim> wobble from = end To = Start 
		ENDIF 
		IF GotParam Idle 
			Playanim Anim = <Anim> cycle 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT CopingHit CopingHit = 1 
	Wait <CopingHit> frames 
	IF ( ( <terrain> = 3 ) | ( <terrain> = 4 ) ) 
		PlaySound copinghit3_11 RANDOM(1, 1, 1) RANDOMCASE pitch = 90 RANDOMCASE pitch = 100 RANDOMCASE pitch = 110 RANDOMEND vol = 80 
	ELSE 
		PlayBonkSound 
	ENDIF 
ENDSCRIPT

SCRIPT LipBlood 
	Wait <BloodFrame> frames 
	Obj_PlaySound RANDOM(1, 1, 1) RANDOMCASE BailSlap01 RANDOMCASE BailSlap02 RANDOMCASE BailSlap03 RANDOMEND 
	BloodParticlesOn Name = "breath.png" start_col = -1 end_col = 587202559 num = 2 emit_w = 2.00000000000 emit_h = 2.00000000000 angle = 50 size = 4.00000000000 bone = head growth = 2 time = 0.50000000000 speed = 250 grav = -1000 life = 0.50000000000 
	Obj_SpawnScript BloodSuperTiny 
	Wait 1 frame 
ENDSCRIPT

SCRIPT LipOut y = 1 
	ClearException Ollied 
	ClearLipCombos 
	StopBalanceTrick 
	KillExtraTricks 
	SetSkaterCamLerpReductionTimer time = 0 
	SetException Ex = Landed Scr = LipLand Params = { <...> } 
	IF GotParam OutAnim 
		Playanim Anim = <OutAnim> Blendperiod = 0.00000000000 
		BlendPeriodOut 0.30000001192 
	ELSE 
		IF GotParam InitAnim 
			Playanim Anim = <InitAnim> backwards 
		ELSE 
		ENDIF 
	ENDIF 
	IF GotParam BoardRotate 
		BoardRotateAfter 
	ENDIF 
	IF NOT GotParam spine 
		IF GotParam ReleaseFrame 
			WaitAnim <ReleaseFrame> frames fromend 
		ELSE 
			WaitAnim 90 frames fromend 
		ENDIF 
	ENDIF 
	SetState Air 
	Move z = 1 
	Move y = <y> 
	IF GotParam spine 
		Rotate z = 180 
		Flip 
		SetTrickName "Spine Transfer" 
		SetTrickScore TRANSFER_POINTS 
		Display 
	ENDIF 
	DoNextTrick 
	NoRailTricks 
	InAirExceptions 
	SetException Ex = Landed Scr = LipLand Params = { <...> } 
	BlendPeriodOut 0 
	WaitAnimFinished 
	SetException Ex = GroundGone Scr = GroundGone 
	IF OnGround 
		LandSkaterTricks 
		DoNextManualTrick 
	ELSE 
		ClearManualTrick 
	ENDIF 
	IF Inair 
		IF GotParam FlipAfter 
		ELSE 
			FlipAfter 
		ENDIF 
		RotateAfter 
		SetLandedFromVert 
		Goto Airborne 
	ELSE 
		LandSkaterTricks 
		Goto OnGroundAi 
	ENDIF 
ENDSCRIPT

SCRIPT ClearLipCombos 
	ClearAllowLipNoGrind 
	Obj_ClearFlag FLAG_SKATER_LIPCOMBO 
ENDSCRIPT

SCRIPT LipLand 
	OverrideCancelGround 
	ClearTrickQueue 
	SetQueueTricks NoTricks 
	Land ReturnBacktoLipLand 
	AllowRailTricks 
	Rotate 
	EnableDisplayFlip 
	IF GotParam FlipAfter 
	ELSE 
		FlipAfter 
	ENDIF 
	SetExtraTricks_Reverts 
	WaitAnimFinished 
	SetLandedFromVert 
	Goto Land 
ENDSCRIPT

SCRIPT LipBail 
	StopBalanceTrick 
	Move z = 1 
	Move y = 6 
	SetState Air 
	IF GotParam FlipOnOllie 
		FlipAfter 
	ENDIF 
	IF GotParam RotateOnOllie 
		RotateAfter 
	ENDIF 
	IF GotParam BailScript 
		Goto <BailScript> 
	ELSE 
		GotoRandomScript [ FaceSmash NoseManualBail ManualBail ] 
	ENDIF 
ENDSCRIPT

SCRIPT OllieLipOut 
	SetSkaterCamLerpReductionTimer time = 1 
	StopBalanceTrick 
	KillExtraTricks 
	NoRailTricks 
	Move z = 1 
	Move y = 6 
	IF GotParam BoardRotate 
		BoardRotateAfter 
	ENDIF 
	IF GotParam FlipOnOllie 
		FlipAfter 
	ENDIF 
	IF GotParam RotateOnOllie 
		RotateAfter 
	ENDIF 
	SetLandedFromVert 
	Rotate x = 90 
	Rotate x = -45 
	IF HandleLipOllieDirection 
		ClearLipCombos 
		AllowRailTricks 
		ResetLandedFromVert 
	ELSE 
		Obj_SpawnScript SetUpLipCombo 
	ENDIF 
	IF GotParam OllieOutAnim 
		Ollie OutAnim = <OllieOutAnim> RotateAfter = yes FromLip 
	ELSE 
		Ollie 
	ENDIF 
ENDSCRIPT

SCRIPT SetUpLipCombo 
	Wait 0.30000001192 seconds 
	Obj_SetFlag FLAG_SKATER_LIPCOMBO 
	AllowRailTricks 
	AllowLipNoGrind 
	Wait 0.30000001192 seconds 
	IF Inair 
		ClearAllowLipNoGrind 
		Obj_ClearFlag FLAG_SKATER_LIPCOMBO 
		NoRailTricks 
	ENDIF 
ENDSCRIPT

SCRIPT LipTrick 
	ClearExceptions 
	SetException Ex = SkaterCollideBail Scr = SkaterCollideBail 
	ClearTrickQueue 
	KillExtraTricks 
	IF Obj_FlagSet FLAG_SKATER_LIPCOMBO 
		SetQueueTricks special = SpecialLipTricks ComboLipTricks 
	ELSE 
		SetQueueTricks special = SpecialLipTricks LipTricks 
	ENDIF 
	UseGrindEvents 
	Wait 2 Gameframe 
	DoNextTrick 
	ClearExceptions 
	SetException Ex = SkaterCollideBail Scr = SkaterCollideBail 
	ClearTrickQueue 
	SetQueueTricks NoTricks 
	Goto LipMacro2 Params = DefaultLipTrick 
ENDSCRIPT


