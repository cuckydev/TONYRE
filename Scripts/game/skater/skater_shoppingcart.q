
SCRIPT ShoppingCart_Start startspeed = 600 turn_friction = 4 accelerate_to = 800 acceleration = 10.00000000000 
	SetTags startspeed = <startspeed> turn_friction = <turn_friction> accelerate_to = <accelerate_to> bailspeed = <bailspeed> acceleration = <acceleration> racemode = <racemode> 
	ClearExceptions 
	SetException Ex = GroundGone Scr = Cart_Airborne 
	SetException Ex = FlailHitWall Scr = Cart_Flail 
	SetException Ex = FlailLeft Scr = Cart_Flail 
	SetException Ex = FlailRight Scr = Cart_Flail 
	IF flipped 
		Flip 
	ENDIF 
	SWITCH <racemode> 
		CASE shoppingcart 
			CanBrakeOff 
			ForceAutokickOff 
			printf "LOCKING CART" 
			kill name = ago_ShoppingCart 
			create name = ago_ShoppingCart 
			ago_ShoppingCart : Obj_LockToObject ObjectName = skater VECTOR(2.00000000000, 4.00000000000, 0.00000000000) 
		DEFAULT 
			ClearSkaterCamOverride 
			CanBrakeOn 
			ForceAutoKickOn 
			Obj_SetFlag FLAG_SKATER_CARMODE 
	ENDSWITCH 
	NoRailTricks 
	VibrateOff 
	SwitchOnBoard 
	Obj_KillSpawnedScript name = BailBoardControl 
	ClearEventBuffer 
	EnablePlayerInput 
	BailOff 
	BashOff 
	SetRollingFriction 0 
	SetSpeed <startspeed> 
	Blendperiodout 0 
	PlayShoppingCartStartAnim 
	Goto ShoppingCart_OnGround 
ENDSCRIPT

SCRIPT PlayShoppingCartStartAnim 
	GetTags 
	SWITCH <racemode> 
		CASE shoppingcart 
			SetSkaterCamOverride heading = 2 tilt = -0.20000000298 time = 0.00000100000 
			PlayAnim Anim = Trolley_PushFromStand BlendPeriod = 0 
			WaitAnimFinished 
			ClearSkaterCamOverride 
			PlayAnim Anim = Trolley_Push BlendPeriod = 0 
			WaitAnimFinished 
			PlayAnim Anim = Trolley_JumpIn BlendPeriod = 0 
			WaitAnimFinished 
		CASE luge 
			PlayAnim Anim = Luge_Push 
			WaitAnimFinished 
		CASE slalom 
			PlayAnim Anim = Slalom_Push 
			WaitAnimFinished 
	ENDSWITCH 
ENDSCRIPT

SCRIPT ShoppingCart_OnGround 
	SetException Ex = Ollied Scr = Cart_Ollie 
	overridelimits max = 10000 friction = 0 time = 1000 
	SetSkaterCamLerpReductionTimer time = 0 
	ResetLandedFromVert 
	GetTags 
	SWITCH <racemode> 
		CASE shoppingcart 
			PlayAnim Anim = Trolley_Idle NoRestart Cycle 
			ShoppingCart_OnGround_Loop 
		CASE luge 
			PlayAnim Anim = luge_Idle NoRestart Cycle 
			CarMode_OnGround_Loop 
		CASE slalom 
			PlayAnim Anim = slalom_Idle NoRestart Cycle 
			CarMode_OnGround_Loop 
	ENDSWITCH 
ENDSCRIPT

SCRIPT ShoppingCart_OnGround_Loop 
	Obj_StopSound ShoppingCartLoop 
	Obj_Playsound ShoppingCartLoop 
	BEGIN 
		IF held left 
			PlayAnim Anim = Trolley_IdleToLeanLeft NoRestart 
		ELSE 
			IF held right 
				PlayAnim Anim = Trolley_IdleToLeanRight NoRestart 
			ELSE 
				IF AnimFinished 
					PlayAnim Anim = RANDOM(1, 1, 1, 1, 1, 1, 1, 1, 1) RANDOMCASE Trolley_Idle RANDOMCASE Trolley_Idle RANDOMCASE Trolley_Idle RANDOMCASE Trolley_Idle RANDOMCASE Trolley_Idle RANDOMCASE Trolley_Idle RANDOMCASE Trolley_Idle RANDOMCASE Trolley_LookLeft RANDOMCASE Trolley_LookRight RANDOMEND 
				ENDIF 
			ENDIF 
		ENDIF 
		wait 1 game frame 
	REPEAT 
ENDSCRIPT

SCRIPT CarMode_OnGround_Loop 
	GetTags 
	BEGIN 
		IF held left 
			SetRollingFriction <turn_friction> 
			SWITCH <racemode> 
				CASE luge 
					PlayAnim Anim = Luge_IdleToLeanLeft NoRestart 
				CASE slalom 
					PlayAnim Anim = Slalom_IdleToLeanLeft NoRestart 
			ENDSWITCH 
		ELSE 
			IF held right 
				SetRollingFriction <turn_friction> 
				SWITCH <racemode> 
					CASE luge 
						PlayAnim Anim = Luge_IdleToLeanRight NoRestart 
					CASE slalom 
						PlayAnim Anim = Slalom_IdleToLeanRight NoRestart 
				ENDSWITCH 
			ELSE 
				IF held Down 
					SWITCH <racemode> 
						CASE luge 
							PlayAnim Anim = Luge_Brake NoRestart 
					ENDSWITCH 
				ELSE 
					SWITCH <racemode> 
						CASE luge 
							PlayAnim Anim = luge_Idle Cycle NoRestart 
						CASE slalom 
							PlayAnim Anim = slalom_Idle Cycle NoRestart 
					ENDSWITCH 
					SetRollingFriction 0 
					GetSpeed 
					IF ( <speed> < <accelerate_to> ) 
						speed = ( <speed> + <acceleration> ) 
					ENDIF 
					SetSpeed <speed> 
				ENDIF 
			ENDIF 
		ENDIF 
		wait 1 game frame 
	REPEAT 
ENDSCRIPT

SCRIPT Cart_Bail 
	ClearExceptions 
	GetTags 
	IF NOT LandedFromVert 
		SWITCH <racemode> 
			CASE shoppingcart 
			CASE luge 
				Jump BonelessHeight 
		ENDSWITCH 
	ENDIF 
	CanBrakeOn 
	overridelimits max = 10000 friction = 0 time = 0 
	RestoreAutoKick 
	ClearSkaterCamOverride 
	IF GotParam BigAir 
		Rolling 
	ENDIF 
	SWITCH <racemode> 
		CASE shoppingcart 
			PlaySound ShoppingCartBail 
			kill name = ago_ShoppingCart 
			Trolley_BailB 
		CASE slalom 
			NoseManualBail 
		DEFAULT 
			ManualBail 
	ENDSWITCH 
ENDSCRIPT

SCRIPT Cart_Flail speed = 0 bailspeed = 0 
	GetTags 
	GetSpeed 
	IF ( <speed> > <bailspeed> ) 
		Goto Cart_Bail 
	ELSE 
		SWITCH <racemode> 
			CASE luge 
				PlayAnim Anim = Luge_Flail 
			CASE slalom 
				PlayAnim Anim = Slalom_Flail 
		ENDSWITCH 
		WaitAnimFinished 
		Goto ShoppingCart_OnGround 
	ENDIF 
ENDSCRIPT

SCRIPT Cart_Ollie 
	ClearException Ollied 
	GetTags 
	SWITCH <racemode> 
		CASE shoppingcart 
			PlayAnim Anim = Trolley_Ollie 
			Jump BonelessHeight 
			PlaySound ShoppingCartOllie 
		CASE luge 
			PlayAnim Anim = Luge_Ollie 
			Jump BonelessHeight 
		CASE slalom 
			PlayAnim Anim = Slalom_Ollie 
			Jump 
	ENDSWITCH 
	Goto Cart_Airborne 
ENDSCRIPT

SCRIPT Cart_Airborne 
	SetException Ex = Landed Scr = Cart_Land 
	SetState Air 
	GetTags 
	SWITCH <racemode> 
		CASE shoppingcart 
			Obj_StopSound ShoppingCartLoop 
			IF AnimEquals Trolley_Ollie 
				WaitAnimFinished 
			ENDIF 
			PlayAnim Anim = Trolley_AirIdle 
			SetTrickName #"Cart Air" 
		CASE luge 
			IF AnimEquals Luge_Ollie 
				WaitAnimFinished 
			ENDIF 
			PlayAnim Anim = Luge_AirIdle 
			SetTrickName #"Luge Hop" 
		CASE slalom 
			IF AnimEquals Slalom_Ollie 
				WaitAnimFinished 
			ENDIF 
			PlayAnim Anim = Slalom_AirIdle 
			SetTrickName #"Old School Ollie" 
	ENDSWITCH 
	BEGIN 
		IF AirTimeGreaterThan 0.50000000000 seconds 
			ClearException Ollied 
			BREAK 
		ENDIF 
		wait 1 game frame 
	REPEAT 
	SettrickScore 100 
	Display 
	IF ( <racemode> = slalom ) 
		BEGIN 
			IF AirTimeGreaterThan 1.25000000000 seconds 
				PlayAnim Anim = FlailingFall BlendPeriod = 0.30000001192 Cycle 
				SetException Ex = Landed Scr = Cart_Bail params = { BigAir } 
				BREAK 
			ENDIF 
			wait 1 game frame 
		REPEAT 
	ENDIF 
ENDSCRIPT

SCRIPT Cart_Land 
	GetTags 
	SetState Ground 
	IF AbsolutePitchGreaterThan 60 
		IF PitchGreaterThan 60 
			Goto Cart_Bail 
		ENDIF 
	ENDIF 
	IF YawBetween PAIR(30.00000000000, 150.00000000000) 
		Goto Cart_Bail 
	ENDIF 
	IF RollGreaterThan 50 
		Goto Cart_Bail 
	ENDIF 
	SWITCH <racemode> 
		CASE shoppingcart 
		CASE luge 
			IF LandedFromVert 
				Goto Cart_Bail 
			ENDIF 
	ENDSWITCH 
	IF backwards 
		SWITCH <racemode> 
			CASE shoppingcart 
			CASE luge 
				Goto Cart_Bail 
			CASE slalom 
				Rotate 
				Flip 
		ENDSWITCH 
	ENDIF 
	ClearPanel_Landed 
	SWITCH <racemode> 
		CASE shoppingcart 
			SetException Ex = Ollied Scr = Cart_Ollie 
			PlaySound ShoppingCartLand 
			IF AirTimeGreaterThan 1 seconds 
				PlayAnim Anim = Trolley_Land 
				WaitAnimFinished 
			ELSE 
				IF AirTimeGreaterThan 0.10000000149 seconds 
					PlayAnim Anim = Trolley_SmallLand 
					WaitAnimFinished 
				ENDIF 
			ENDIF 
		CASE luge 
			PlayAnim Anim = Luge_land 
		CASE slalom 
			PlayAnim Anim = Slalom_land 
	ENDSWITCH 
	SetException Ex = Ollied Scr = Cart_Ollie 
	WaitAnimFinished 
	Goto ShoppingCart_OnGround 
ENDSCRIPT

SCRIPT LugeBrake friction = 15 
	ClearExceptions 
	DisablePlayerInput 
	WaitOnGround 
	SetRollingFriction <friction> 
	PlayAnim Anim = Luge_Fullstop BlendPeriod = 0.30000001192 
	WaitAnimFinished 
	SpeedCheckStop 
	wait 30 frames 
	SpeedCheckStop 
ENDSCRIPT


