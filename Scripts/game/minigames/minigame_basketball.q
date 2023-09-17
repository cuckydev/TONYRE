
SCRIPT Basketball Shotcounter = 10 ShotsMade = 0 
	Skiptrack 
	IF Flipped 
		Flip 
	ENDIF 
	ClearExceptions 
	DisablePlayerInput 
	SetRollingFriction 1000 
	PlayAnim Anim = Ped_BP_DribbleInPlace Cycle 
	Create_Speech_box { text = [ "Basketballer:\\n \'sup dog. I bet you fitty bucks you can\'t make 8 shots in 10 tries. " 
			"Hold \\b3 to shoot, release \\b3 at the very top of your jump to bust a 3 pointer. \\n" 
			"Press \\b1 at any time to wuss out, punk." 
		] 
		pos = PAIR(320, 240) 
	} 
	BEGIN 
		IF Held X 
			GotoPreserveParams Basketball_OnGround 
		ENDIF 
		IF Held Square 
			speech_box_exit 
			Goto SkaterInit 
		ENDIF 
		WaitOneGameFrame 
	REPEAT 
ENDSCRIPT

SCRIPT Basketball_OnGround 
	ClearTrickQueue 
	ClearEventBuffer 
	SetRollingFriction 1000 
	IF NOT GotParam Shotcounter 
		Shotcounter = 10 
	ENDIF 
	IF ( <Shotcounter> < 1 ) 
		IF ( <ShotsMade> < 9 ) 
			Goto Basketball_PlayAgain 
		ELSE 
			Goto Basketball_YouWin 
		ENDIF 
	ENDIF 
	BEGIN 
		PlayAnim Anim = Ped_BP_DribbleInPlace Cycle NoRestart 
		IF Held X 
			GotoPreserveParams Basketball_InAir 
		ENDIF 
		IF Held Square 
			Goto OnGroundAi 
		ENDIF 
		WaitOneGameFrame 
	REPEAT 
ENDSCRIPT

SCRIPT Basketball_InAir 
	ClearExceptions 
	PlayAnim Anim = Ped_BP_ShootBall To = 80 
	BEGIN 
		IF released X 
			<Shotcounter> = ( <Shotcounter> - 1 ) 
			Update_ShotCounter <...> 
			Trick_MissShot 
			WaitAnimFinished 
			GotoPreserveParams Basketball_OnGround 
		ENDIF 
		Wait 1 Frame 
	REPEAT 20 
	BEGIN 
		IF released X 
			Trick_MakeShot 
			<ShotsMade> = ( <ShotsMade> + 1 ) 
			<Shotcounter> = ( <Shotcounter> - 1 ) 
			Update_ShotCounter <...> 
			WaitAnimFinished 
			GotoPreserveParams Basketball_OnGround 
		ENDIF 
		Wait 1 Frame 
	REPEAT 3 
	BEGIN 
		IF released X 
			<Shotcounter> = ( <Shotcounter> - 1 ) 
			Update_ShotCounter <...> 
			Trick_MissShot 
			WaitAnimFinished 
			GotoPreserveParams Basketball_OnGround 
		ENDIF 
		Wait 1 Frame 
	REPEAT 20 
	WaitAnimFinished 
	<Shotcounter> = ( <Shotcounter> - 1 ) 
	Update_ShotCounter <...> 
	Trick_DidNotShoot 
	BEGIN 
		IF released X 
			GotoPreserveParams Basketball_OnGround 
		ELSE 
			PlayAnim Anim = Ped_BP_DribbleInPlace Cycle NoRestart 
		ENDIF 
		WaitOneGameFrame 
	REPEAT 
ENDSCRIPT

SCRIPT Update_ShotCounter 
	<TotalShots> = ( 10 - <Shotcounter> ) 
	FormatText TextName = Baskets_scored "%m for %s" s = <TotalShots> m = <ShotsMade> 
	Create_panel_message id = Shotcounter pos = PAIR(80, 240) text = <Baskets_scored> 
ENDSCRIPT

SCRIPT Trick_MakeShot 
	Create_panel_message text = " " id = bball time = 1 
	Wait 1 Frame 
	Create_panel_message rgba = [ 32 144 32 100 ] pos = PAIR(320, 80) id = bball RANDOM(1, 1, 1, 1, 1) RANDOMCASE text = "Nice!" RANDOMCASE text = "He shoots he scores!" RANDOMCASE text = "Bucket!" RANDOMCASE text = "Nice!" RANDOMCASE text = "Swish!" RANDOMEND 
ENDSCRIPT

SCRIPT Trick_MissShot 
	Create_panel_message text = " " id = bball time = 1 
	Wait 1 Frame 
	Create_panel_message id = bball pos = PAIR(320, 80) RANDOM(1, 1, 1, 1) RANDOMCASE text = "Airball!" RANDOMCASE text = "CLANG!" RANDOMCASE text = "Weak..." RANDOMCASE text = "Brick!" RANDOMEND 
ENDSCRIPT

SCRIPT Trick_DidNotShoot 
	Create_panel_message text = " " id = bball time = 1 
	Wait 1 Frame 
	Create_panel_message id = bball pos = PAIR(320, 80) text = "Release X to shoot, moron!" 
ENDSCRIPT

SCRIPT Basketball_PlayAgain 
	<Shotcounter> = 10 
	<ShotsMade> = 0 
	PlayAnim Anim = Ped_M_Disgust 
	WaitAnimFinished 
	PlayAnim Anim = Ped_BP_DribbleInPlace Cycle 
	Create_Speech_box { text = [ "Basketballer:\\n Man, get your sorry ass out of here." 
			" If you still got game, press \\b3 to go again, or else press " 
		"\\b1 to get lost." ] 
	pos = PAIR(320, 240) } 
	Debounce X 
	BEGIN 
		IF Held X 
			GotoPreserveParams Basketball_OnGround 
		ENDIF 
		IF Held Square 
			speech_box_exit 
			Goto OnGroundAi 
		ENDIF 
		WaitOneGameFrame 
	REPEAT 
ENDSCRIPT

SCRIPT Basketball_YouWin 
	<Shotcounter> = 10 
	<ShotsMade> = 0 
	PlayAnim Anim = Ped_M_Cheering 
	WaitAnimFinished 
	PlayAnim Anim = Ped_BP_DribbleInPlace Cycle 
	Create_Speech_box { text = [ "Basketballer:\\n Daaaaaamn. You was raisin\' up sumthin\' righteous. Here\'s fitty - " 
		"press \\b3 to go again or \\b1 to bolt." ] 
	pos = PAIR(320, 240) } 
	GoalMAnager_AddCash 50 
	PlaySound cash Vol = 130 
	Debounce X 
	BEGIN 
		IF Held X 
			GotoPreserveParams Basketball_OnGround 
		ENDIF 
		IF Held Square 
			speech_box_exit 
			Goto OnGroundAi 
		ENDIF 
		WaitOneGameFrame 
	REPEAT 
ENDSCRIPT

SCRIPT Kill_Speech_Box 
	IF ObjectExists id = speech_box_anchor 
		DestroyScreenElement id = speech_box_anchor 
	ENDIF 
ENDSCRIPT

SCRIPT WaitOnGroundWhilstChecking 
	BEGIN 
		DoNextTrick 
		IF OnGround 
			BREAK 
		ENDIF 
		WaitOneGameFrame 
	REPEAT 
ENDSCRIPT

SCRIPT WaitFramesWhilstChecking Frames = 60 
	BEGIN 
		DoNextTrick 
		Wait 1 Frame 
	REPEAT <Frames> 
ENDSCRIPT

SCRIPT Basketball2 
	PlaySkaterCamAnim name = MG_BBallTop play_hold 
	SwitchOffBoard 
	Obj_VarSet var = 0 value = 4 
	printf "blah blah blah" 
	kill prefix = "TRG_Ped_BB_" 
	create name = TRG_PedBB_MG_D 
	create name = MG_BB_Box 
	Skiptrack 
	IF Flipped 
		Flip 
	ENDIF 
	Obj_SetFlag OBJFLAG_BBALL_IDLE 
	ClearExceptions 
	SpawnSkaterScript MG_BB_Anims 
	DisablePlayerInput 
	SetRollingFriction 1000 
	IF NOT IsAlive name = TRG_MG_BB_AnimControl 
		create name = TRG_MG_BB_AnimControl 
	ENDIF 
	SendFlag name = TRG_MG_BB_AnimControl OBJFLAG_BBALL_IDLE 
	Create_Speech_box { text = [ "Basketballer:\\n So the little skateboarder thinks he can hold his own?! " 
			"Hold \\b3 to shoot, release \\b3 when it looks like the shot is on. \\n" 
		"Press \\b1 at any time to wuss out, punk." ] 
	pos = PAIR(320, 240) } 
	BEGIN 
		PlayAnim Anim = Ped_BP_DribbleInPlace Cycle 
		Wait 30 Frames 
		BEGIN 
			IF Held X 
				IF IsAlive name = TRG_MG_BBall_GameBall 
				ELSE 
					ClearFlag name = TRG_MG_BB_AnimControl OBJFLAG_BBALL_IDLE 
					ClearFlag name = TRG_MG_BB_AnimControl OBJFLAG_BBALL_RUN 
					SendFlag name = TRG_MG_BB_AnimControl OBJFLAG_BBALL_SHOOTING 
					Rotate duration = 10 Frame node = TRG_MG_BBall_GameBall 
					Obj_PlayAnim Anim = Ped_BP_ShootBall 
					create name = TRG_MG_BBall_GameBall 
					PlaySound sch_tennis_11 
					SpawnSkaterScript MG_BBall_TakeShot 
					BEGIN 
						IF QueryFlag OBJFLAG_BBALL_SHOOTING name = TRG_MG_BB_AnimControl 
							BREAK 
						ENDIF 
						Wait 1 Frame 
					REPEAT 
				ENDIF 
			ENDIF 
			IF Held Left 
				IF Obj_VarEq var = 0 value = 1 
					MG_BB_RunToLeft node = TRG_MG_BB_MoveTo01 
				ENDIF 
				IF Obj_VarEq var = 0 value = 2 
					MG_BB_RunToLeft node = TRG_MG_BB_MoveTo02 
				ENDIF 
				IF Obj_VarEq var = 0 value = 3 
					MG_BB_RunToLeft node = TRG_MG_BB_MoveTo03 
				ENDIF 
				IF Obj_VarEq var = 0 value = 4 
					MG_BB_RunToLeft node = TRG_MG_BB_MoveTo04 
				ENDIF 
				IF Obj_VarEq var = 0 value = 5 
					MG_BB_RunToLeft node = TRG_MG_BB_MoveTo05 
				ENDIF 
				IF Obj_VarEq var = 0 value = 6 
					MG_BB_RunToLeft node = TRG_MG_BB_MoveTo06 
				ENDIF 
				IF Obj_VarEq var = 0 value = 7 
					MG_BB_RunToLeft node = TRG_MG_BB_MoveTo07 
				ENDIF 
				IF Obj_VarEq var = 0 value = 8 
					MG_BB_RunToLeft node = TRG_MG_BB_MoveTo07 
				ENDIF 
			ENDIF 
			IF Held Right 
				IF Obj_VarEq var = 0 value = 1 
					MG_BB_RunToRight node = TRG_MG_BB_MoveTo02 
				ENDIF 
				IF Obj_VarEq var = 0 value = 2 
					MG_BB_RunToRight node = TRG_MG_BB_MoveTo03 
				ENDIF 
				IF Obj_VarEq var = 0 value = 3 
					MG_BB_RunToRight node = TRG_MG_BB_MoveTo04 
				ENDIF 
				IF Obj_VarEq var = 0 value = 4 
					MG_BB_RunToRight node = TRG_MG_BB_MoveTo05 
				ENDIF 
				IF Obj_VarEq var = 0 value = 5 
					MG_BB_RunToRight node = TRG_MG_BB_MoveTo06 
				ENDIF 
				IF Obj_VarEq var = 0 value = 6 
					MG_BB_RunToRight node = TRG_MG_BB_MoveTo07 
				ENDIF 
				IF Obj_VarEq var = 0 value = 7 
					MG_BB_RunToRight node = TRG_MG_BB_MoveTo08 
				ENDIF 
				IF Obj_VarEq var = 0 value = 8 
					MG_BB_RunToRight node = TRG_MG_BB_MoveTo08 
				ENDIF 
			ENDIF 
			IF Held Square 
				kill prefix = "TRG_MG_BB_AnimControl" 
				kill prefix = "TRG_PedBB_MG_D" 
				kill prefix = "MG_BB_Box" 
				PlaySkaterCamAnim skater = 0 stop 
				SetRollingFriction 1 
				Enableplayerinput 
				create prefix = "TRG_Ped_BB_" 
				MakeSkaterGoto SkaterInit 
				speech_box_exit 
				BREAK 
			ENDIF 
			Wait 1 Frame 
		REPEAT 
		Obj_WaitAnimFinished 
	REPEAT 
ENDSCRIPT

SCRIPT Sch_MG_BBallShootCheck 
	Obj_ClearFlag OBJFLAG_BBALL_TOOKSHOT 
	BEGIN 
		Obj_MoveToRelPos VECTOR(0, 5, 0) 
		Wait 1 Frame 
		Create_panel_message id = bball_shot text = "early" 
		IF Obj_FlagSet OBJFLAG_BBALL_TOOKSHOT 
			Obj_ClearFlag OBJFLAG_BBALL_TOOKSHOT 
			Goto Sch_MG_BBallShotEarly 
		ENDIF 
	REPEAT 22 
	BEGIN 
		Obj_MoveToRelPos VECTOR(0, 5, 0) 
		Wait 1 Frame 
		Create_panel_message id = bball_shot text = "!!!!NOW!!!!!" 
		IF Obj_FlagSet OBJFLAG_BBALL_TOOKSHOT 
			Obj_ClearFlag OBJFLAG_BBALL_TOOKSHOT 
			Goto Sch_MG_BBallShotOn 
		ENDIF 
	REPEAT 5 
	BEGIN 
		Obj_MoveToRelPos VECTOR(0, 5, 0) 
		Wait 1 Frame 
		Create_panel_message id = bball_shot text = "late" 
		IF Obj_FlagSet OBJFLAG_BBALL_TOOKSHOT 
			Obj_ClearFlag OBJFLAG_BBALL_TOOKSHOT 
			Goto Sch_MG_BBallShotLate 
		ENDIF 
	REPEAT 7 
	Create_panel_message id = bball_shot text = " " 
	Goto Sch_MG_BBallShotLate 
	SendFlag name = TRG_MG_BB_AnimControl OBJFLAG_BBALL_IDLE 
	ClearFlag name = TRG_MG_BB_AnimControl OBJFLAG_BBALL_SHOOTING 
	Die 
ENDSCRIPT

SCRIPT Sch_MG_BBallShotEarly 
	Create_panel_message id = bball_shot text = "EARLY" 
	SendFlag name = TRG_MG_BB_AnimControl OBJFLAG_BBALL_IDLE 
	ClearFlag name = TRG_MG_BB_AnimControl OBJFLAG_BBALL_SHOOTING 
	Die 
ENDSCRIPT

SCRIPT Sch_MG_BBallShotOn 
	Create_panel_message id = bball_shot text = "RIGHT ON!" 
	SpawnSkaterScript Sch_BB_Sound_BallMake id = MG_BBallSound 
	SendFlag name = TRG_MG_BB_AnimControl OBJFLAG_BBALL_IDLE 
	ClearFlag name = TRG_MG_BB_AnimControl OBJFLAG_BBALL_SHOOTING 
	Die 
ENDSCRIPT

SCRIPT Sch_MG_BBallShotLate 
	Create_panel_message id = bball_shot text = "LATE" 
	SendFlag name = TRG_MG_BB_AnimControl OBJFLAG_BBALL_IDLE 
	ClearFlag name = TRG_MG_BB_AnimControl OBJFLAG_BBALL_SHOOTING 
	Die 
ENDSCRIPT

SCRIPT MG_BBall_TakeShot 
	BEGIN 
		IF released X 
			IF IsAlive name = TRG_MG_BBall_GameBall 
				SendFlag name = TRG_MG_BBall_GameBall OBJFLAG_BBALL_TOOKSHOT 
				BREAK 
			ENDIF 
		ENDIF 
		Wait 1 Frame 
	REPEAT 50 
ENDSCRIPT

SCRIPT MG_BB_RunToLeft node = TRG_MG_BB_MoveTo01 
	Rotate duration = 3 Frame node = <node> 
	Move z = 5 
	SendFlag name = TRG_MG_BB_AnimControl OBJFLAG_BBALL_MOVING 
	Obj_GetDistToNode <node> 
	IF ( <dist> < 50 ) 
		printf "Obj_VarDec" 
		Obj_VarDec var = 0 
		MG_BB_CehckVarSendFlag 
	ENDIF 
ENDSCRIPT

SCRIPT MG_BB_RunToRight node = TRG_MG_BB_MoveTo08 
	Rotate duration = 2 Frame node = <node> 
	Move z = 5 
	SendFlag name = TRG_MG_BB_AnimControl OBJFLAG_BBALL_MOVING 
	Obj_GetDistToNode <node> 
	IF ( <dist> < 50 ) 
		printf "Obj_VarInc" 
		Obj_VarInc var = 0 
		MG_BB_CehckVarSendFlag 
	ENDIF 
ENDSCRIPT

SCRIPT MG_BB_ClearFlags 
	ClearFlag name = TRG_PedBB_MG_D OBJFLAG_BBALL_MOVETONAV1 
	ClearFlag name = TRG_PedBB_MG_D OBJFLAG_BBALL_MOVETONAV2 
	ClearFlag name = TRG_PedBB_MG_D OBJFLAG_BBALL_MOVETONAV3 
	ClearFlag name = TRG_PedBB_MG_D OBJFLAG_BBALL_MOVETONAV4 
	ClearFlag name = TRG_PedBB_MG_D OBJFLAG_BBALL_MOVETONAV5 
	ClearFlag name = TRG_PedBB_MG_D OBJFLAG_BBALL_MOVETONAV6 
	ClearFlag name = TRG_PedBB_MG_D OBJFLAG_BBALL_MOVETONAV7 
	ClearFlag name = TRG_PedBB_MG_D OBJFLAG_BBALL_MOVETONAV8 
ENDSCRIPT

SCRIPT MG_BB_CehckVarSendFlag 
	IF Obj_VarEq var = 0 value = 0 
		Obj_VarSet var = 0 value = 1 
		MG_BB_ClearFlags 
		SendFlag name = TRG_PedBB_MG_D OBJFLAG_BBALL_MOVETONAV1 
	ENDIF 
	IF Obj_VarEq var = 0 value = 1 
		MG_BB_ClearFlags 
		SendFlag name = TRG_PedBB_MG_D OBJFLAG_BBALL_MOVETONAV1 
	ENDIF 
	IF Obj_VarEq var = 0 value = 2 
		MG_BB_ClearFlags 
		SendFlag name = TRG_PedBB_MG_D OBJFLAG_BBALL_MOVETONAV2 
	ENDIF 
	IF Obj_VarEq var = 0 value = 3 
		MG_BB_ClearFlags 
		SendFlag name = TRG_PedBB_MG_D OBJFLAG_BBALL_MOVETONAV3 
	ENDIF 
	IF Obj_VarEq var = 0 value = 4 
		MG_BB_ClearFlags 
		SendFlag name = TRG_PedBB_MG_D OBJFLAG_BBALL_MOVETONAV4 
	ENDIF 
	IF Obj_VarEq var = 0 value = 5 
		MG_BB_ClearFlags 
		SendFlag name = TRG_PedBB_MG_D OBJFLAG_BBALL_MOVETONAV5 
	ENDIF 
	IF Obj_VarEq var = 0 value = 6 
		MG_BB_ClearFlags 
		SendFlag name = TRG_PedBB_MG_D OBJFLAG_BBALL_MOVETONAV6 
	ENDIF 
	IF Obj_VarEq var = 0 value = 7 
		MG_BB_ClearFlags 
		SendFlag name = TRG_PedBB_MG_D OBJFLAG_BBALL_MOVETONAV7 
	ENDIF 
	IF Obj_VarEq var = 0 value = 8 
		MG_BB_ClearFlags 
		SendFlag name = TRG_PedBB_MG_D OBJFLAG_BBALL_MOVETONAV8 
	ENDIF 
	IF Obj_VarEq var = 0 value = 9 
		MG_BB_ClearFlags 
		Obj_VarSet var = 0 value = 8 
		SendFlag name = TRG_PedBB_MG_D OBJFLAG_BBALL_MOVETONAV8 
	ENDIF 
ENDSCRIPT

SCRIPT Sch_MG_BB_GotToNav01 
	printf "got to nave 01" 
ENDSCRIPT

SCRIPT MG_BB_AnimControl 
	BEGIN 
		printf "MG BB anim controller" 
		Wait 1 second 
	REPEAT 
ENDSCRIPT

SCRIPT MG_BB_AnimsEnd 
	IF IsAlive name = TRG_MG_BB_AnimControl 
		ClearFlag name = TRG_MG_BB_AnimControl OBJFLAG_BBALL_MOVING 
	ENDIF 
	Wait 1 Frame 
	Goto MG_BB_Anims 
ENDSCRIPT

SCRIPT MG_BB_SetIdle 
	IF IsAlive name = TRG_MG_BB_AnimControl 
		ClearFlag name = TRG_MG_BB_AnimControl OBJFLAG_BBALL_RUN 
		SendFlag name = TRG_MG_BB_AnimControl OBJFLAG_BBALL_IDLE 
	ENDIF 
ENDSCRIPT

SCRIPT MG_BB_SetRun 
	IF IsAlive name = TRG_MG_BB_AnimControl 
		SendFlag name = TRG_MG_BB_AnimControl OBJFLAG_BBALL_RUN 
		ClearFlag name = TRG_MG_BB_AnimControl OBJFLAG_BBALL_IDLE 
	ENDIF 
ENDSCRIPT

SCRIPT MG_BB_Anims 
	Wait 1 Frame 
	BEGIN 
		IF IsAlive name = TRG_MG_BB_AnimControl 
			IF QueryFlag OBJFLAG_BBALL_SHOOTING name = TRG_MG_BB_AnimControl 
			ELSE 
				IF QueryFlag OBJFLAG_BBALL_IDLE name = TRG_MG_BB_AnimControl 
					IF QueryFlag OBJFLAG_BBALL_MOVING name = TRG_MG_BB_AnimControl 
						PlayAnim Anim = Ped_BP_DribbleRunFromIdle Speed = 5 NoRestart Blendperiod = 0.30000001192 
						WaitAnimFinished 
						MG_BB_SetRun 
						Goto MG_BB_AnimsEnd 
					ELSE 
						Rotate duration = 10 Frame node = TRG_MG_BBall_GameBall 
						PlayAnim Anim = Ped_BP_DribbleInPlace Cycle NoRestart 
						MG_BB_SetIdle 
						Goto MG_BB_AnimsEnd 
					ENDIF 
				ENDIF 
				IF QueryFlag OBJFLAG_BBALL_RUN name = TRG_MG_BB_AnimControl 
					IF QueryFlag OBJFLAG_BBALL_MOVING name = TRG_MG_BB_AnimControl 
						PlayAnim Anim = Ped_BP_DribbleRun Cycle NoRestart 
						MG_BB_SetRun 
						Goto MG_BB_AnimsEnd 
					ELSE 
						Rotate duration = 10 Frame node = TRG_MG_BBall_GameBall 
						PlayAnim Anim = Ped_BP_DribbleRunToIdle Speed = 5 NoRestart Blendperiod = 0.30000001192 
						WaitAnimFinished 
						MG_BB_SetIdle 
						Goto MG_BB_AnimsEnd 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
		Wait 1 Frame 
	REPEAT 
ENDSCRIPT

SCRIPT MG_BB_Defense_Goal 
	Obj_StickToGround distAbove = 3 distBelow = 6 
	Obj_SetPathTurnDist 2.50000000000 feet 
	Obj_StickToGround off 
	Obj_SetConstantHeight 
	Obj_PathHeading On 
	Obj_SetPathVelocity 30 fps 
	Obj_SetPathAcceleration 45 fpsps 
	Obj_SetPathDeceleration 45 fpsps 
	BEGIN 
		Obj_PlayAnim Anim = Ped_BP_GuardPlayer Cycle 
		BEGIN 
			IF Obj_FlagSet OBJFLAG_BBALL_MOVETONAV1 
				Obj_ClearFlag OBJFLAG_BBALL_MOVETONAV1 
				Wait RANDOM(1, 1, 1) RANDOMCASE 10 Frames RANDOMCASE 20 Frames RANDOMCASE 30 Frames RANDOMEND 
				Sch_BB_RunToNav Sch_BBall_Nav = TRG_Ped_BB_Blocker01 
				Obj_LookAtNode name = TRG_MG_BB_MoveTo01 
				BREAK 
			ENDIF 
			IF Obj_FlagSet OBJFLAG_BBALL_MOVETONAV2 
				Obj_ClearFlag OBJFLAG_BBALL_MOVETONAV2 
				Wait RANDOM(1, 1, 1) RANDOMCASE 10 Frames RANDOMCASE 20 Frames RANDOMCASE 30 Frames RANDOMEND 
				Sch_BB_RunToNav Sch_BBall_Nav = TRG_Ped_BB_Blocker02 
				Obj_LookAtNode name = TRG_MG_BB_MoveTo02 
				BREAK 
			ENDIF 
			IF Obj_FlagSet OBJFLAG_BBALL_MOVETONAV3 
				Obj_ClearFlag OBJFLAG_BBALL_MOVETONAV3 
				Wait RANDOM(1, 1, 1) RANDOMCASE 10 Frames RANDOMCASE 20 Frames RANDOMCASE 30 Frames RANDOMEND 
				Sch_BB_RunToNav Sch_BBall_Nav = TRG_Ped_BB_Blocker03 
				Obj_LookAtNode name = TRG_MG_BB_MoveTo03 
				BREAK 
			ENDIF 
			IF Obj_FlagSet OBJFLAG_BBALL_MOVETONAV4 
				Obj_ClearFlag OBJFLAG_BBALL_MOVETONAV4 
				Wait RANDOM(1, 1, 1) RANDOMCASE 10 Frames RANDOMCASE 20 Frames RANDOMCASE 30 Frames RANDOMEND 
				Sch_BB_RunToNav Sch_BBall_Nav = TRG_Ped_BB_Blocker04 
				Obj_LookAtNode name = TRG_MG_BB_MoveTo04 
				BREAK 
			ENDIF 
			IF Obj_FlagSet OBJFLAG_BBALL_MOVETONAV5 
				Obj_ClearFlag OBJFLAG_BBALL_MOVETONAV5 
				Wait RANDOM(1, 1, 1) RANDOMCASE 10 Frames RANDOMCASE 20 Frames RANDOMCASE 30 Frames RANDOMEND 
				Sch_BB_RunToNav Sch_BBall_Nav = TRG_Ped_BB_Blocker05 
				Obj_LookAtNode name = TRG_MG_BB_MoveTo05 
				BREAK 
			ENDIF 
			IF Obj_FlagSet OBJFLAG_BBALL_MOVETONAV6 
				Obj_ClearFlag OBJFLAG_BBALL_MOVETONAV6 
				Wait RANDOM(1, 1, 1) RANDOMCASE 10 Frames RANDOMCASE 20 Frames RANDOMCASE 30 Frames RANDOMEND 
				Sch_BB_RunToNav Sch_BBall_Nav = TRG_Ped_BB_Blocker06 
				Obj_LookAtNode name = TRG_MG_BB_MoveTo06 
				BREAK 
			ENDIF 
			IF Obj_FlagSet OBJFLAG_BBALL_MOVETONAV7 
				Obj_ClearFlag OBJFLAG_BBALL_MOVETONAV7 
				Wait RANDOM(1, 1, 1) RANDOMCASE 10 Frames RANDOMCASE 20 Frames RANDOMCASE 30 Frames RANDOMEND 
				Sch_BB_RunToNav Sch_BBall_Nav = TRG_Ped_BB_Blocker07 
				Obj_LookAtNode name = TRG_MG_BB_MoveTo07 
				BREAK 
			ENDIF 
			IF Obj_FlagSet OBJFLAG_BBALL_MOVETONAV8 
				Obj_ClearFlag OBJFLAG_BBALL_MOVETONAV8 
				Wait RANDOM(1, 1, 1) RANDOMCASE 10 Frames RANDOMCASE 20 Frames RANDOMCASE 30 Frames RANDOMEND 
				Sch_BB_RunToNav Sch_BBall_Nav = TRG_Ped_BB_Blocker08 
				Obj_LookAtNode name = TRG_MG_BB_MoveTo08 
				BREAK 
			ENDIF 
			Wait 1 Frame 
		REPEAT 
	REPEAT 
ENDSCRIPT

OBJFLAG_BBALL_TOOKSHOT = 0 
OBJFLAG_BBALL_MOVETONAV1 = 1 
OBJFLAG_BBALL_MOVETONAV2 = 2 
OBJFLAG_BBALL_MOVETONAV3 = 3 
OBJFLAG_BBALL_MOVETONAV4 = 4 
OBJFLAG_BBALL_MOVETONAV5 = 5 
OBJFLAG_BBALL_MOVETONAV6 = 6 
OBJFLAG_BBALL_MOVETONAV7 = 7 
OBJFLAG_BBALL_MOVETONAV8 = 8 
OBJFLAG_BBALL_MOVING = 9 
OBJFLAG_BBALL_IDLE = 10 
OBJFLAG_BBALL_RUN = 12 
OBJFLAG_BBALL_SHOOTING = 13 

