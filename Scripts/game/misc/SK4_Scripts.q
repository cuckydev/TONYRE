
SCRIPT ScottKills 
	sk3_killskater deathsound = boneless09 message1 = "poopoo" message2 = "waaaaa" message3 = "yowsers" message4 = "Cheesy Peasey likes ass" r = 0 g = 255 b = 0 
ENDSCRIPT

SCRIPT sk3_killskater 
	IF Obj_FlagNotSet FLAG_SKATER_KILLING 
		Obj_SetFlag FLAG_SKATER_KILLING 
		InBail 
		IF GotParam deathsound 
			PlaySound <deathsound> 
		ELSE 
			PlaySound BailBodyPunch01_11 
			PlaySound BailSlap01 
			PlaySound BailBodyFall01 
		ENDIF 
		IF NOT GotParam NoMessage 
			IF NOT GetGlobalFlag flag = NO_DISPLAY_HUD 
				IF NOT InSplitScreenGame 
					IF GotParam message1 
						Create_Panel_Message style = panel_message_death id = death_message text = RANDOM(1, 1, 1, 1) 
							RANDOMCASE <message1> 
							RANDOMCASE <message2> 
							RANDOMCASE <message3> 
						RANDOMCASE <message4> RANDOMEND 
					ELSE 
						IF Driving 
							Create_Panel_Message style = panel_message_death id = death_message text = RANDOM(1, 1, 2) 
								RANDOMCASE "Don\'t drink and drive!" 
								RANDOMCASE "Learn to drive!" 
							RANDOMCASE "Out of bounds!" RANDOMEND 
						ELSE 
							Create_Panel_Message style = panel_message_death id = death_message text = RANDOM(1, 1, 1, 1, 1, 1, 1, 1, 1, 4) 
								RANDOMCASE "You suck!" 
								RANDOMCASE "Don\'t do drugs!" 
								RANDOMCASE "Stay in school!" 
								RANDOMCASE "This is your brain on drugs!" 
								RANDOMCASE "Nice one!" 
								RANDOMCASE "Good one!" 
								RANDOMCASE "Hmmmmm..." 
								RANDOMCASE "Loser!" 
								RANDOMCASE "Who loaned you that board?" 
							RANDOMCASE "Out of bounds!" RANDOMEND 
						ENDIF 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
		SK3_Killskater_Finish <...> 
	ENDIF 
ENDSCRIPT

SCRIPT SK3_KillSkater_Water 
	IF Obj_FlagNotSet FLAG_SKATER_KILLING 
		Obj_SetFlag FLAG_SKATER_KILLING 
		IF GotParam deathsound 
			PlaySound <deathsound> 
		ELSE 
			PlaySound FallWater 
		ENDIF 
		IF NOT InSplitScreenGame 
			IF NOT GetGlobalFlag flag = NO_DISPLAY_HUD 
				IF GotParam message1 
					Create_Panel_Message style = panel_message_death id = death_message text = RANDOM(1, 1, 1, 1) 
						RANDOMCASE <message1> 
						RANDOMCASE <message2> 
						RANDOMCASE <message3> 
					RANDOMCASE <message4> RANDOMEND 
				ELSE 
					Create_Panel_Message style = panel_message_death id = death_message text = RANDOM(1, 1, 1, 1, 1, 1) 
						RANDOMCASE "All wet" 
						RANDOMCASE "You big drip!" 
						RANDOMCASE "WATER... BAAAD!" 
						RANDOMCASE "No swimming" 
						RANDOMCASE "You\'re drowning!" 
					RANDOMCASE "You\'re hosed!" RANDOMEND 
				ENDIF 
			ENDIF 
		ENDIF 
		SK3_Killskater_Finish water r = 100 g = 100 b = 200 <...> 
	ENDIF 
ENDSCRIPT

SCRIPT SK3_KillSkater_Pungee 
	IF Obj_FlagNotSet FLAG_SKATER_KILLING 
		Obj_SetFlag FLAG_SKATER_KILLING 
		PlaySound FallPungee_11 
		IF NOT InSplitScreenGame 
			IF NOT GetGlobalFlag flag = NO_DISPLAY_HUD 
				IF NOT GotParam Lava 
					Create_Panel_Message style = panel_message_death id = death_message text = RANDOM(1, 1, 1, 1, 1) 
						RANDOMCASE "You got shafted" 
						RANDOMCASE "Who built that?!" 
						RANDOMCASE "Serve, set, spike!" 
						RANDOMCASE "Shish kabob?" 
					RANDOMCASE "Don\'t build this at home!" RANDOMEND 
				ELSE 
					Create_Panel_Message style = panel_message_death id = death_message text = RANDOM(1, 1, 1, 1, 1) 
						RANDOMCASE "Toasted toes!" 
						RANDOMCASE "Burnt to a crisp!" 
						RANDOMCASE "Grilled to perfection!" 
						RANDOMCASE "Ouch!" 
					RANDOMCASE "Death by hot lava!" RANDOMEND 
				ENDIF 
			ENDIF 
		ENDIF 
		SK3_Killskater_Finish r = 150 g = 50 b = 50 <...> 
	ENDIF 
ENDSCRIPT

SCRIPT SK4_Hide_Death_Message 
	IF ObjectExists id = death_message 
		SetScreenElementProps id = death_message rgba = [ 0 0 0 0 ] 
	ENDIF 
ENDSCRIPT

SCRIPT SK3_Killskater_Finish r = 255 g = 255 b = 255 
	IF NOT Driving 
		Obj_GetID 
		LaunchEvent type = KillingSkater target = <objId> 
	ENDIF 
	DisablePlayerInput 
	IF GotParam Bail 
		IF Skating 
			MakeSkaterGoto Killskater_Bail 
		ENDIF 
	ENDIF 
	pulse_blur start = 0 end = 255 speed = 4 
	IF GotParam water 
		SkaterSplashOn 
		PausePhysics 
		Hide 
		IF ObjectExists id = PlayerVehicle 
			PlayerVehicle : Hide 
		ENDIF 
		wait 0.10000000149 seconds 
	ELSE 
		wait 0.25000000000 seconds 
	ENDIF 
	ClearTrickQueues 
	wait 1 gameframe 
	BlendPeriodOut 0 
	ClearEventBuffer 
	BailSkaterTricks 
	IF NOT Driving 
		IF GotParam Nodename 
			KillSkater node = <Nodename> 
		ELSE 
			KillSkater 
		ENDIF 
	ELSE 
		PlayerVehicle : Vehicle_MoveToRestart <Nodename> 
		PlayerVehicleCamera : VehicleCamera_Reset 
		PlayerVehicle : Unhide 
		IF PlayerVehicle : Vehicle_IsSkaterVisible 
			Unhide 
		ENDIF 
	ENDIF 
	IF InNetGame 
		IF GameModeEquals is_goal_attack 
			IF NOT GameIsOver 
				speech_box_exit 
			ENDIF 
		ENDIF 
	ELSE 
		speech_box_exit 
	ENDIF 
	ResetSkaterParticleSystems 
	pulse_blur start = 255 end = 0 speed = 4 
	wait 0.75000000000 seconds 
	NotInBail 
	Obj_ClearFlag FLAG_SKATER_KILLING 
	IF GoalManager_HasActiveGoals 
		IF GoalManager_GetActiveGoalId 
			GoalManager_GetGoalParams name = <goal_id> 
			IF GotParam horse 
				GoalManager_LoseGoal name = <goal_id> 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT panel_message_death 
	Domorph pos = PAIR(320.00000000000, 80.00000000000) alpha = 0 scale = 0 
	Domorph alpha = 1 time = 0.25000000000 scale = 1.29999995232 
	Domorph time = 0.15000000596 scale = 1 
	wait 2 seconds 
	Domorph scale = 1.29999995232 time = 0.15000000596 
	Domorph alpha = 0 time = 0.25000000000 scale = 0 
	Die 
ENDSCRIPT

SCRIPT Killskater_Bail 
	PlayAnim Anim = SlipForwards BlendPeriod = 0.30000001192 
ENDSCRIPT

SCRIPT SK3_TeleportToNode 
	TeleportSkaterToNode <...> 
ENDSCRIPT

SCRIPT TeleportSkaterToNode r = 255 g = 255 b = 255 
	IF GotParam message1 
		LaunchPanelMessage properties = panel_message_death RANDOM(1) 
		RANDOMCASE RANDOMEND <message1> 
	ELSE 
		LaunchPanelMessage properties = panel_message_death "On the Move!" 
	ENDIF 
	IF GotParam Nodename 
		printf "Got the nodename ...................." 
		IF Skating 
			IF OnRail 
				ClearEventBuffer 
				ClearTrickQueue 
				KillExtraTricks 
				ClearExtraGrindTrick 
				StopBalanceTrick 
				MakeSkaterGoto GroundGone 
			ENDIF 
		ENDIF 
		Obj_MoveToNode name = <Nodename> Orient NoReset 
	ELSE 
		LaunchPanelMessage properties = panel_message_death "ERROR! Please pass in nodename=" 
	ENDIF 
	wait 0.25000000000 seconds 
ENDSCRIPT

SCRIPT PrepareSkaterForMove 
	IF Skating 
		SetState AIR 
		CleanUpSpecialItems 
		StopBalanceTrick 
		MakeSkaterGoto GroundGone 
		LandSkaterTricks 
		ClearEventBuffer 
	ENDIF 
ENDSCRIPT

SCRIPT TeleportSkaterUp dist = 2000 
	Skater : SparksOff 
	Skater : Move y = <dist> 
ENDSCRIPT

SCRIPT TeleportSkaterDown dist = -2000 
	Skater : SparksOff 
	Skater : Move y = <dist> 
ENDSCRIPT

SCRIPT MoveSkaterZ dist = 0 
	SparksOff 
	Move y = <dist> 
ENDSCRIPT

FLAG_TRAFFICLIGHT_GREEN = 0 
FLAG_TRAFFICLIGHT_YELLOW = 1 
FLAG_TRAFFICLIGHT_RED = 2 
FLAG_CAR_GENERIC_STOPPED = 3 
FLAG_CAR_GENERIC_NOSOUND = 4 
FLAG_CAR_SOUND_FRANTICSTOP = 5 
FLAG_CAR_SKITCH = 7 
FLAG_CAR_TYPE_BUS = 30 
FLAG_CAR_GENERIC_STOPPED_SKATER = 8 
SCRIPT SK4_TrafficLight01 
	Obj_SetFlag FLAG_TRAFFICLIGHT_GREEN 
	create name = <Green> 
	wait RANDOM_RANGE PAIR(5000.00000000000, 12000.00000000000) 
	BEGIN 
		Obj_SetFlag FLAG_TRAFFICLIGHT_YELLOW 
		Obj_ClearFlag FLAG_TRAFFICLIGHT_GREEN 
		kill name = <Green> 
		create name = <Yellow> 
		wait 3000 
		Obj_SetFlag FLAG_TRAFFICLIGHT_RED 
		Obj_ClearFlag FLAG_TRAFFICLIGHT_YELLOW 
		kill name = <Yellow> 
		create name = <Red> 
		wait RANDOM_RANGE PAIR(9000.00000000000, 15000.00000000000) 
		Obj_SetFlag FLAG_TRAFFICLIGHT_GREEN 
		Obj_ClearFlag FLAG_TRAFFICLIGHT_RED 
		kill name = <Red> 
		create name = <Green> 
		wait RANDOM_RANGE PAIR(7000.00000000000, 12000.00000000000) 
	REPEAT 
ENDSCRIPT

SCRIPT Car_Generic01 TurnDist = 20 DefaultSpeed = 40 ForwardOffset = 5 SkitchSpeed = 60 CarLoopSFX = CarLoop 
	SetTags DefaultSpeed = <DefaultSpeed> Tag_TurnDist = <TurnDist> CarLoopSFX = <CarLoopSFX> 
	GetTags 
	Obj_SetPathTurnDist <Tag_TurnDist> 
	Obj_FollowPathLinked 
	Obj_SetPathAcceleration 10 mphps 
	Obj_SetPathDeceleration 10 mphps 
	Obj_SetPathMinStopVel 5 
	Obj_SetPathVelocity <DefaultSpeed> mph 
	IF NOT GotParam AllowSlow 
		IF ( <DefaultSpeed> < 20 ) 
			printf "### CAR SPEED TOO SLOW! CHANGING TO 20mph ###" 
			printstruct <DefaultSpeed> 
			<DefaultSpeed> = 20 
			printstruct <DefaultSpeed> 
		ENDIF 
	ENDIF 
	IF GotParam Bus 
		Obj_SetFlag FLAG_CAR_TYPE_BUS 
	ENDIF 
	IF GotParam SkaterDebugBox 
		<SkaterDebugBox> = debug 
	ENDIF 
	IF GotParam CarDebugBox 
		<CarDebugBox> = debug 
	ENDIF 
	IF GotParam NoSound 
		Obj_SetFlag FLAG_CAR_GENERIC_NOSOUND 
	ELSE 
		Obj_PlaySound <CarLoopSFX> 
	ENDIF 
	IF GotParam NoSkater 
	ELSE 
		Obj_SpawnScript Car_CheckForSkater01 params = <...> 
	ENDIF 
	Obj_SpawnScript Car_CheckForOtherCar01 params = <...> 
ENDSCRIPT

Car_CheckForSkater_Pause = 1 
SCRIPT Car_CheckForSkater01 
	IF GotParam Bus 
		SkaterCheckOffset = VECTOR(0.00000000000, 0.00000000000, 28.00000000000) 
	ELSE 
		IF GotParam truck 
			SkaterCheckOffset = VECTOR(0.00000000000, 0.00000000000, 16.00000000000) 
		ELSE 
			IF GotParam atv 
				SkaterCheckOffset = VECTOR(0.00000000000, 0.00000000000, 3.00000000000) 
			ELSE 
				SkaterCheckOffset = VECTOR(0.00000000000, 0.00000000000, 5.50000000000) 
			ENDIF 
		ENDIF 
	ENDIF 
	p1 = { dist = ( <DefaultSpeed> * 1.50000000000 ) width = 15 height = 25 type = Skater offset = <SkaterCheckOffset> <SkaterDebugBox> } 
	p2 = { dist = ( <DefaultSpeed> * 1.50000000000 ) width = 15 height = 20 type = Skater offset = <SkaterCheckOffset> <SkaterDebugBox> } 
	Change Car_CheckForSkater_Pause = ( Car_CheckForSkater_Pause + 1 ) 
	IF ( Car_CheckForSkater_Pause > 10 ) 
		Change Car_CheckForSkater_Pause = 1 
	ENDIF 
	wait Car_CheckForSkater_Pause gameframes 
	BEGIN 
		wait 10 gameframes 
		IF LocalSkaterExists 
			IF Obj_FlagNotSet FLAG_CAR_GENERIC_STOPPED 
				IF Obj_ObjectInRect <p1> 
					KillSpawnedScript id = CarAccelSound 
					Obj_AdjustSound <CarLoopSFX> volumePercent = 50 volumeStep = 1.50000000000 pitchPercent = 40 pitchStep = 1.50000000000 
					Car_Sound_FranticStop01 
					Obj_StopAlongPath 8 
					Obj_SetFlag FLAG_CAR_GENERIC_STOPPED_SKATER 
					BEGIN 
						wait 90 gameframes 
						IF Obj_ObjectInRect <p2> 
							KillSpawnedScript id = CarAccelSound 
							wait 60 gameframes 
							Car_Sound_RandomHonk01 
						ELSE 
							SpawnSound Car_Sound_Accel01 id = CarAccelSound 
							Obj_StartAlongPath 
							Obj_ClearFlag FLAG_CAR_GENERIC_STOPPED_SKATER 
							BREAK 
						ENDIF 
					REPEAT 
				ELSE 
					IF Skater : Skitching 
						Obj_GetSpeed 
						IF Obj_FlagNotSet FLAG_CAR_SKITCH 
							Obj_SetFlag FLAG_CAR_SKITCH 
							IF Obj_FlagNotSet FLAG_CAR_GENERIC_NOSOUND 
								Obj_PlaySound LA_Skid_11 
							ENDIF 
							Obj_SetPathVelocity <SkitchSpeed> mph 
						ENDIF 
					ELSE 
						IF Obj_FlagSet FLAG_CAR_SKITCH 
							Obj_ClearFlag FLAG_CAR_SKITCH 
							IF NOT GotParam NoSkitchStop 
								Obj_SetFlag FLAG_CAR_GENERIC_STOPPED 
								Obj_StopAlongPath 15 feet 
								wait 1 second 
								Obj_ClearFlag FLAG_CAR_GENERIC_STOPPED 
								Obj_StartAlongPath 
							ENDIF 
							Obj_SetPathVelocity <DefaultSpeed> mph 
						ENDIF 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
	REPEAT 
ENDSCRIPT

Car_CheckForOtherCar_Pause = 1 
SCRIPT Car_CheckForOtherCar01 
	p1 = { dist = ( <DefaultSpeed> * 1.50000000000 ) width = 20 height = 20 offset = VECTOR(0.00000000000, 0.00000000000, 5.00000000000) <CarDebugBox> } 
	p2 = { dist = <DefaultSpeed> width = 20 height = 20 offset = VECTOR(0.00000000000, 0.00000000000, 5.00000000000) <CarDebugBox> } 
	Change Car_CheckForOtherCar_Pause = ( Car_CheckForOtherCar_Pause + 1 ) 
	IF ( Car_CheckForOtherCar_Pause > 10 ) 
		Change Car_CheckForOtherCar_Pause = 1 
	ENDIF 
	wait Car_CheckForOtherCar_Pause gameframes 
	BEGIN 
		wait 10 gameframes 
		IF Obj_FlagNotSet FLAG_CAR_GENERIC_STOPPED 
			CarGeneric_GetNextObjOnPath_Decel <...> 
			GetTags 
			Obj_GetNextObjOnPath Range = <LookAheadCheckDist_Decel> 
			IF GotParam Ob 
				Obj_SpawnScript Car_DecelForOtherCar01 params = <...> 
				IF IsAlive name = <Ob> 
					CarGeneric_GetNextObjOnPath_Stop <...> 
					GetTags 
					Obj_GetNextObjOnPath Range = <LookAheadCheckDist> 
				ENDIF 
				IF GotParam Ob 
					Car_StopForOtherCar01 <...> 
				ENDIF 
			ENDIF 
		ENDIF 
	REPEAT 
ENDSCRIPT

SCRIPT Car_StopForOtherCar01 
	KillSpawnedScript id = CarAccelSound 
	Obj_SetFlag FLAG_CAR_GENERIC_STOPPED 
	Obj_StopAlongPath 7 
	GetTags 
	IF Obj_FlagSet FLAG_CAR_TYPE_BUS 
		printf "### distance ahead bus looked before stopping = %d" d = <LookAheadCheckDist> 
	ENDIF 
	Car_Sound_Stop01 
	BEGIN 
		Car_Sound_RandomHonk01 
		IF IsAlive name = <Ob> 
			CarGeneric_GetNextObjOnPath_Stop <...> 
			GetTags 
			Obj_GetNextObjOnPath Range = <LookAheadCheckDist> 
		ENDIF 
		IF NOT GotParam Ob 
			IF Obj_FlagNotSet FLAG_CAR_GENERIC_STOPPED_SKATER 
				Car_StartForOtherCar01 <...> 
				BREAK 
			ENDIF 
		ENDIF 
		wait 60 gameframes 
	REPEAT 
ENDSCRIPT

SCRIPT Car_StartForOtherCar01 
	SpawnSound Car_Sound_Accel01 id = CarAccelSound 
	Obj_ClearFlag FLAG_CAR_GENERIC_STOPPED 
	wait 20 gameframes 
	IF Obj_FlagNotSet FLAG_CAR_GENERIC_STOPPED_SKATER 
		Obj_SetPathVelocity 30 mph 
		Obj_StartAlongPath 
	ENDIF 
ENDSCRIPT

SCRIPT CarGeneric_GetNextObjOnPath_Decel 
	LookAheadCheckDist_Decel = 45 
	IF GotParam Bus 
		LookAheadCheckDist_Decel = ( <LookAheadCheckDist_Decel> + 20 ) 
	ELSE 
		IF GotParam truck 
			LookAheadCheckDist_Decel = ( <LookAheadCheckDist_Decel> + 10 ) 
		ENDIF 
	ENDIF 
	SetTags LookAheadCheckDist_Decel = <LookAheadCheckDist_Decel> 
ENDSCRIPT

SCRIPT CarGeneric_GetNextObjOnPath_Stop 
	LookAheadCheckDist = 37 
	IF GotParam Bus 
		LookAheadCheckDist = ( <LookAheadCheckDist> + 20 ) 
	ELSE 
		IF GotParam truck 
			LookAheadCheckDist_Decel = ( <LookAheadCheckDist_Decel> + 10 ) 
		ENDIF 
	ENDIF 
	IF Queryflag name = <Ob> FLAG_CAR_TYPE_BUS 
		LookAheadCheckDist = ( <LookAheadCheckDist> + 10 ) 
	ENDIF 
	SetTags LookAheadCheckDist = <LookAheadCheckDist> 
ENDSCRIPT

SCRIPT Car_Sound_Accel01 
	GetTags 
	IF Obj_FlagNotSet FLAG_CAR_GENERIC_NOSOUND 
		Obj_AdjustSound <CarLoopSFX> volumePercent = 80 volumeStep = 0.75000000000 pitchPercent = RANDOM_RANGE PAIR(83.00000000000, 87.00000000000) pitchStep = RANDOM_RANGE PAIR(0.60000002384, 0.89999997616) 
		wait RANDOM_RANGE PAIR(0.89999997616, 1.50000000000) seconds 
		Obj_AdjustSound <CarLoopSFX> volumePercent = 60 volumeStep = 3 pitchPercent = RANDOM_RANGE PAIR(48.00000000000, 52.00000000000) pitchStep = RANDOM_RANGE PAIR(4.00000000000, 5.50000000000) 
		wait RANDOM_RANGE PAIR(0.15000000596, 0.40000000596) seconds 
		GetTags 
		IF Obj_FlagNotSet FLAG_CAR_GENERIC_STOPPED 
			Obj_AdjustSound <CarLoopSFX> volumePercent = 80 volumeStep = 0.50000000000 pitchPercent = RANDOM_RANGE PAIR(77.00000000000, 81.00000000000) pitchStep = RANDOM_RANGE PAIR(0.40000000596, 0.60000002384) 
			wait RANDOM_RANGE PAIR(1.20000004768, 1.89999997616) seconds 
			Obj_AdjustSound <CarLoopSFX> volumePercent = 55 volumeStep = 4 pitchPercent = RANDOM_RANGE PAIR(42.00000000000, 47.00000000000) pitchStep = RANDOM_RANGE PAIR(0.40000000596, 0.50000000000) 
			wait RANDOM_RANGE PAIR(0.15000000596, 0.40000000596) seconds 
		ENDIF 
		GetTags 
		IF Obj_FlagNotSet FLAG_CAR_GENERIC_STOPPED 
			Obj_AdjustSound <CarLoopSFX> volumePercent = 80 volumeStep = 0.40000000596 pitchPercent = 73 pitchStep = 0.40000000596 
			wait 2.00000000000 seconds 
			Obj_AdjustSound <CarLoopSFX> volumePercent = 50 volumeStep = 5 pitchPercent = 45 pitchStep = 5 
			wait RANDOM_RANGE PAIR(0.15000000596, 0.40000000596) seconds 
		ENDIF 
		GetTags 
		IF Obj_FlagNotSet FLAG_CAR_GENERIC_STOPPED 
			Obj_AdjustSound <CarLoopSFX> volumePercent = 80 volumeStep = 0.30000001192 pitchPercent = 60 pitchStep = 0.30000001192 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT Car_Sound_Decel01 
	KillSpawnedScript id = CarAccelSound 
	GetTags 
	IF Obj_FlagNotSet FLAG_CAR_GENERIC_NOSOUND 
		Obj_AdjustSound <CarLoopSFX> volumePercent = 80 volumeStep = 2 pitchPercent = RANDOM_RANGE PAIR(40.00000000000, 50.00000000000) pitchStep = 1 
		wait 1 second 
		Obj_PlaySound CarBrakeSqueal vol = RANDOM_RANGE PAIR(5.00000000000, 20.00000000000) pitch = RANDOM_RANGE PAIR(80.00000000000, 100.00000000000) 
	ENDIF 
ENDSCRIPT

SCRIPT Car_Sound_Stop01 
	KillSpawnedScript id = CarAccelSound 
	GetTags 
	IF Obj_FlagNotSet FLAG_CAR_GENERIC_NOSOUND 
		Obj_AdjustSound <CarLoopSFX> volumePercent = 50 volumeStep = 1.50000000000 pitchPercent = 30 pitchStep = 1.50000000000 
		Obj_PlaySound CarBrakeSqueal vol = RANDOM_RANGE PAIR(40.00000000000, 50.00000000000) pitch = 80 
	ENDIF 
ENDSCRIPT

SCRIPT Car_Sound_FranticStop01 
	KillSpawnedScript id = CarAccelSound 
	GetTags 
	IF Obj_FlagNotSet FLAG_CAR_GENERIC_NOSOUND 
		IF Obj_FlagNotSet FLAG_CAR_SOUND_FRANTICSTOP 
			Obj_PlaySound LA_Skid_11 vol = RANDOM_RANGE PAIR(30.00000000000, 60.00000000000) 
			RANDOM(1, 1, 1) RANDOMCASE RANDOMCASE RANDOMCASE 
			Obj_PlaySound CarHorn_11 vol = RANDOM_RANGE PAIR(30.00000000000, 70.00000000000) pitch = RANDOM_RANGE PAIR(80.00000000000, 100.00000000000) RANDOMEND 
		ENDIF 
	ENDIF 
	Obj_SpawnScript Car_Counter_FranticStop01 
ENDSCRIPT

SCRIPT Car_Counter_FranticStop01 
	Obj_SetFlag FLAG_CAR_SOUND_FRANTICSTOP 
	KillSpawnedScript id = CarAccelSound 
	wait 120 gameframes 
	Obj_ClearFlag FLAG_CAR_SOUND_FRANTICSTOP 
ENDSCRIPT

SCRIPT Car_Sound_RandomHonk01 
	IF Obj_FlagNotSet FLAG_CAR_GENERIC_NOSOUND 
		RANDOM(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1) RANDOMCASE RANDOMCASE RANDOMCASE RANDOMCASE RANDOMCASE RANDOMCASE RANDOMCASE RANDOMCASE RANDOMCASE RANDOMCASE RANDOMCASE RANDOMCASE RANDOMCASE RANDOMCASE RANDOMCASE RANDOMCASE RANDOMCASE RANDOMCASE RANDOMCASE RANDOMCASE RANDOMCASE RANDOMCASE RANDOMCASE 
		RANDOMCASE Obj_PlaySound CarHorn_11 vol = RANDOM_RANGE PAIR(30.00000000000, 70.00000000000) pitch = RANDOM_RANGE PAIR(80.00000000000, 100.00000000000) RANDOMEND 
	ENDIF 
ENDSCRIPT

SCRIPT Car_PickRandomPath 
	Obj_FollowPath name = RANDOM(1, 1) RANDOMCASE <Path1> RANDOMCASE <Path2> RANDOMEND 
ENDSCRIPT

SCRIPT Car_Accel01 
	IF Obj_FlagSet FLAG_CAR_SKITCH 
	ELSE 
		GetTags 
		GetRandomValue name = AccelSpeed a = ( <DefaultSpeed> * 0.89999997616 ) b = ( <DefaultSpeed> * 1.20000004768 ) 
		Obj_SetPathVelocity <AccelSpeed> mph 
		SpawnSound Car_Sound_Accel01 id = CarAccelSound 
		IF GotParam printstruct 
			printf "##### ACCEL #####" 
			printstruct <...> 
		ENDIF 
	ENDIF 
	IF GotParam StickToGround 
		Obj_StickToGround on DistAbove = 2 DistBelow = 2 
	ELSE 
		IF GotParam NoStickToGround 
			Obj_StickToGround off 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT Car_AccelAfterDecelForCar01 
	IF Obj_FlagSet FLAG_CAR_SKITCH 
	ELSE 
		GetTags 
		GetRandomValue name = AccelSpeed a = ( <DefaultSpeed> * 0.89999997616 ) b = ( <DefaultSpeed> * 1.20000004768 ) 
		Obj_SetPathVelocity <AccelSpeed> mph 
		SpawnSound Car_Sound_Accel01 id = CarAccelSound 
	ENDIF 
ENDSCRIPT

SCRIPT Car_Decel01 
	IF Obj_FlagSet FLAG_CAR_SKITCH 
	ELSE 
		KillSpawnedScript id = CarAccelSound 
		GetTags 
		GetRandomValue name = DecelSpeed a = ( <DefaultSpeed> * 0.60000002384 ) b = ( <DefaultSpeed> * 0.69999998808 ) 
		Obj_SetPathVelocity <DecelSpeed> mph 
		IF GotParam printstruct 
			printf "##### DECEL #####" 
			printstruct <...> 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT Car_DecelForTurn01 
	IF Obj_FlagSet FLAG_CAR_SKITCH 
	ELSE 
		KillSpawnedScript id = CarAccelSound 
		SetTags Tag_TurnDist = <TurnDist> 
		GetTags 
		GetRandomValue name = DecelSpeed a = ( <DefaultSpeed> * 0.60000002384 ) b = ( <DefaultSpeed> * 0.69999998808 ) 
		IF ( <DecelSpeed> < 20 ) 
			<DecelSpeed> = 20 
		ENDIF 
		Obj_SetPathVelocity <DecelSpeed> mph 
		Obj_SetPathTurnDist <Tag_TurnDist> 
		Car_Sound_Decel01 
		IF GotParam printstruct 
			printf "##### DECEL FOR TURN #####" 
			printstruct <...> 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT Car_DecelTrafficLight01 
	IF Obj_ObjectNotInRect dist = 50 type = [ Skater , car ] 
		IF Queryflag name = <LightNode> FLAG_TRAFFICLIGHT_GREEN 
			goto Car_DecelForTurn01 params = <...> 
		ENDIF 
		IF Queryflag name = <LightNode> FLAG_TRAFFICLIGHT_YELLOW 
			RANDOM(1, 1, 1, 1) 
				RANDOMCASE goto Car_BlowYellow01 params = <...> 
				RANDOMCASE goto Car_BlowYellow01 params = <...> 
				RANDOMCASE goto Car_BlowYellow01 params = <...> 
			RANDOMCASE goto Car_Stop01 params = <...> RANDOMEND 
		ENDIF 
		IF Queryflag name = <LightNode> FLAG_TRAFFICLIGHT_RED 
			goto Car_Stop01 params = <...> 
		ENDIF 
	ELSE 
	ENDIF 
ENDSCRIPT

SCRIPT Car_DecelForOtherCar01 
	KillSpawnedScript id = CarAccelSound 
	Car_Decel01 <...> 
	wait 120 gameframes 
	Car_AccelAfterDecelForCar01 <...> 
ENDSCRIPT

SCRIPT Car_Start01 
	wait RANDOM_RANGE PAIR(800.00000000000, 1200.00000000000) 
	Obj_ClearFlag FLAG_CAR_GENERIC_STOPPED 
	Obj_StartAlongPath 
	SpawnSound Car_Sound_Accel01 id = CarAccelSound 
ENDSCRIPT

SCRIPT Car_Stop01 
	KillSpawnedScript id = CarAccelSound 
	Obj_StopAlongPath RANDOM_RANGE PAIR(25.00000000000, 30.00000000000) feet 
	Obj_SetFlag FLAG_CAR_GENERIC_STOPPED 
	Car_Sound_Stop01 
	BEGIN 
		wait 20 gameframes 
		IF Queryflag name = <LightNode> FLAG_TRAFFICLIGHT_GREEN 
			Car_Start01 
			BREAK 
		ENDIF 
	REPEAT 
ENDSCRIPT

SCRIPT Car_BlowYellow01 
	GetTags 
	Obj_SetPathVelocity 50 mph 
	IF Obj_FlagNotSet FLAG_CAR_GENERIC_NOSOUND 
		Obj_AdjustSound <CarLoopSFX> volumePercent = 130 volumeStep = 4 pitchPercent = 130 pitchStep = 4 
		Obj_PlaySound LA_Skid_11 vol = 100 
	ENDIF 
ENDSCRIPT

SCRIPT Car_InchUpAfterStop 
	IF Obj_ObjectNotInRect dist = 35 width = 50 height = 40 type = [ car , Skater ] offset = VECTOR(0.00000000000, 0.00000000000, 0.00000000000) 
		Obj_StartAlongPath 
		wait 1 gameframes 
		Obj_StopAlongPath 20 
		IF Obj_FlagNotSet FLAG_CAR_GENERIC_NOSOUND 
			Obj_PlaySound CarBrakeSqueal vol = 30 pitch = 80 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT Ped_Generic01 
	Obj_FollowPathLinked 
	Obj_RandomPathMode on 
	Obj_SetPathAcceleration 10 
	Obj_SetPathDeceleration 10 
ENDSCRIPT

SCRIPT Ped_StopAtNode01 
	Obj_SetAnimCycleMode off 
	Obj_WaitAnimFinished 
	Obj_PlayAnim Anim = WalkToIdle 
	wait 2 gameframes 
	Obj_StopAlongPath 
	Obj_WaitAnimFinished 
ENDSCRIPT

SCRIPT Ped_BackOnPath01 
	printf "backonpath" 
	Obj_StartAlongPath 
	Obj_FollowPathStored 
ENDSCRIPT

SCRIPT Ped_WalkToNextNode01 
	RANDOM(1, 1) 
		RANDOMCASE Obj_SetPathVelocity 4 
		Obj_StartAlongPath 
		Obj_CycleAnim Anim = IdleToWalk 
		Obj_PlayAnim Anim = Walk1 cycle 
		RANDOMCASE Obj_SetPathVelocity 4 
		Obj_StartAlongPath 
		Obj_CycleAnim Anim = IdleToWalk 
	Obj_PlayAnim Anim = Walk2 cycle RANDOMEND 
ENDSCRIPT

SCRIPT Ped_Crosswalk01 
	Ped_StopAtNode01 
	BEGIN 
		IF Queryflag name = <LightNode> FLAG_TRAFFICLIGHT_YELLOW 
			Obj_PlayAnim Anim = Idle cycle 
			BEGIN 
				IF Queryflag name = <LightNode> FLAG_TRAFFICLIGHT_RED 
					Obj_SetAnimCycleMode off 
					Obj_WaitAnimFinished 
					wait RANDOM_RANGE PAIR(0.00000000000, 300.00000000000) 
					goto Ped_WalkToNextNode01 
				ENDIF 
				wait 30 gameframes 
			REPEAT 
		ELSE 
			Ped_Idle01 
		ENDIF 
	REPEAT 
ENDSCRIPT

SCRIPT Ped_RandomWaitAtNode01 
	Ped_StopAtNode01 
	Obj_CycleAnim Anim = Idle 
	BEGIN 
		RANDOM(1, 1) 
			RANDOMCASE Ped_Idle01 
		RANDOMCASE goto Ped_WalkToNextNode01 RANDOMEND 
	REPEAT 
ENDSCRIPT

SCRIPT Ped_Idle01 
	RANDOM(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1) 
		RANDOMCASE Obj_CycleAnim Anim = ScratchChin 
		RANDOMCASE Obj_CycleAnim Anim = LookAtWatch 
		RANDOMCASE Obj_CycleAnim Anim = LookLeftRight 
		RANDOMCASE Obj_CycleAnim Anim = LookRight 
		RANDOMCASE Obj_CycleAnim Anim = LookLeftDown 
		RANDOMCASE Obj_CycleAnim Anim = Talk 
		RANDOMCASE Obj_CycleAnim Anim = Talk2 
		RANDOMCASE Obj_CycleAnim Anim = Idle 
		RANDOMCASE Obj_CycleAnim Anim = Idle 
		RANDOMCASE Obj_CycleAnim Anim = Idle 
		RANDOMCASE Obj_CycleAnim Anim = Idle 
		RANDOMCASE Obj_CycleAnim Anim = IdleToIdle2 
		Obj_CycleAnim Anim = Idle2 
		Obj_CycleAnim Anim = Idle2ToIdle 
		RANDOMCASE Obj_CycleAnim Anim = IdleToIdle3 
		Obj_CycleAnim Anim = Idle3 
	Obj_CycleAnim Anim = Idle3ToIdle RANDOMEND 
ENDSCRIPT

SCRIPT Team_Flag 
	Obj_SetInnerRadius 10 
	IF GameModeEquals is_lobby 
		Obj_SetException ex = SkaterInRadius scr = Team_Flag_Trigger params = { <...> } 
	ELSE 
		IF GameModeEquals is_ctf 
			IF OnServer 
				Obj_SetException ex = AnySkaterInRadius scr = CTF_Team_Flag_Trigger params = { <...> } 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT Team_Flag_Trigger 
	GetNumTeams 
	IF GotParam blue 
		JoinTeam blue 
		kill name = TRG_Flag_Red 
		kill name = TRG_Flag_Green 
		kill name = TRG_Flag_Yellow 
		create name = TRG_Flag_Red 
		SWITCH <num_teams> 
			CASE 3 
				create name = TRG_Flag_Green 
			CASE 4 
				create name = TRG_Flag_Green 
				create name = TRG_Flag_Yellow 
		ENDSWITCH 
		Die 
	ENDIF 
	IF GotParam Red 
		JoinTeam Red 
		kill name = TRG_Flag_Blue 
		kill name = TRG_Flag_Green 
		kill name = TRG_Flag_Yellow 
		create name = TRG_Flag_Blue 
		SWITCH <num_teams> 
			CASE 3 
				create name = TRG_Flag_Green 
			CASE 4 
				create name = TRG_Flag_Green 
				create name = TRG_Flag_Yellow 
		ENDSWITCH 
		Die 
	ENDIF 
	IF GotParam Green 
		JoinTeam Green 
		kill name = TRG_Flag_Blue 
		kill name = TRG_Flag_Red 
		kill name = TRG_Flag_Yellow 
		create name = TRG_Flag_Blue 
		create name = TRG_Flag_Red 
		SWITCH <num_teams> 
			CASE 4 
				create name = TRG_Flag_Yellow 
		ENDSWITCH 
		Die 
	ENDIF 
	IF GotParam Yellow 
		JoinTeam Yellow 
		kill name = TRG_Flag_Blue 
		kill name = TRG_Flag_Red 
		kill name = TRG_Flag_Green 
		create name = TRG_Flag_Blue 
		create name = TRG_Flag_Red 
		create name = TRG_Flag_Green 
		Die 
	ENDIF 
ENDSCRIPT

SCRIPT CTF_Team_Base_Trigger 
	IF GotParam Red 
		GetCollidingPlayerAndTeam exclude_team = 0 radius = 10 
		IF ( <player> = -1 ) 
		ELSE 
			IF ( <team> = 0 ) 
				IF PlayerHasFlag <...> 
					IF TeamFlagTaken <...> 
						DisplayFlagBaseWarning 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
	IF GotParam blue 
		GetCollidingPlayerAndTeam exclude_team = 1 radius = 10 
		IF ( <player> = -1 ) 
		ELSE 
			IF ( <team> = 1 ) 
				IF PlayerHasFlag <...> 
					IF TeamFlagTaken <...> 
						DisplayFlagBaseWarning 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
	IF GotParam Green 
		GetCollidingPlayerAndTeam exclude_team = 2 radius = 10 
		IF ( <player> = -1 ) 
		ELSE 
			IF ( <team> = 2 ) 
				IF PlayerHasFlag <...> 
					IF TeamFlagTaken <...> 
						DisplayFlagBaseWarning 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
	IF GotParam Yellow 
		GetCollidingPlayerAndTeam exclude_team = 3 radius = 10 
		IF ( <player> = -1 ) 
		ELSE 
			IF ( <team> = 3 ) 
				IF PlayerHasFlag <...> 
					IF TeamFlagTaken <...> 
						DisplayFlagBaseWarning 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT display_flag_base_warning 
	create_net_panel_message msg_time = 2000 text = net_message_flag_base_warning 
ENDSCRIPT

SCRIPT CTF_Team_Flag_Trigger 
	IF JustStartedNetGame 
		RETURN 
	ENDIF 
	IF GotParam Red 
		GetCollidingPlayerAndTeam exclude_team = 0 radius = 10 
		IF ( <player> = -1 ) 
		ELSE 
			IF ( <team> = 0 ) 
				PlayerCapturedFlag flag_team = 0 <...> 
			ELSE 
				PlayerTookFlag flag_team = 0 <...> 
				Obj_ClearExceptions 
			ENDIF 
		ENDIF 
	ENDIF 
	IF GotParam blue 
		GetCollidingPlayerAndTeam exclude_team = 1 radius = 10 
		IF ( <player> = -1 ) 
		ELSE 
			IF ( <team> = 1 ) 
				PlayerCapturedFlag flag_team = 1 <...> 
			ELSE 
				PlayerTookFlag flag_team = 1 <...> 
				Obj_ClearExceptions 
			ENDIF 
		ENDIF 
	ENDIF 
	IF GotParam Green 
		GetCollidingPlayerAndTeam exclude_team = 2 radius = 10 
		IF ( <player> = -1 ) 
		ELSE 
			IF ( <team> = 2 ) 
				PlayerCapturedFlag flag_team = 2 <...> 
			ELSE 
				PlayerTookFlag flag_team = 2 <...> 
				Obj_ClearExceptions 
			ENDIF 
		ENDIF 
	ENDIF 
	IF GotParam Yellow 
		GetCollidingPlayerAndTeam exclude_team = 3 radius = 10 
		IF ( <player> = -1 ) 
		ELSE 
			IF ( <team> = 3 ) 
				PlayerCapturedFlag flag_team = 3 <...> 
			ELSE 
				PlayerTookFlag flag_team = 3 <...> 
				Obj_ClearExceptions 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT Kill_Team_Flags 
	IF NodeExists TRG_Flag_Red 
		kill name = TRG_Flag_Red 
	ENDIF 
	IF NodeExists TRG_Flag_Blue 
		kill name = TRG_Flag_Blue 
	ENDIF 
	IF NodeExists TRG_Flag_Green 
		kill name = TRG_Flag_Green 
	ENDIF 
	IF NodeExists TRG_Flag_Yellow 
		kill name = TRG_Flag_Yellow 
	ENDIF 
	IF NodeExists TRG_Flag_Red_Base 
		kill name = TRG_Flag_Red_Base 
	ENDIF 
	IF NodeExists TRG_Flag_Blue_Base 
		kill name = TRG_Flag_Blue_Base 
	ENDIF 
	IF NodeExists TRG_Flag_Green_Base 
		kill name = TRG_Flag_Green_Base 
	ENDIF 
	IF NodeExists TRG_Flag_Yellow_Base 
		kill name = TRG_Flag_Yellow_Base 
	ENDIF 
	IF NodeExists TRG_CTF_Red 
		kill name = TRG_CTF_Red 
	ENDIF 
	IF NodeExists TRG_CTF_Red_Base 
		kill name = TRG_CTF_Red_Base 
	ENDIF 
	IF NodeExists TRG_CTF_Blue 
		kill name = TRG_CTF_Blue 
	ENDIF 
	IF NodeExists TRG_CTF_Blue_Base 
		kill name = TRG_CTF_Blue_Base 
	ENDIF 
	IF NodeExists TRG_CTF_Green 
		kill name = TRG_CTF_Green 
	ENDIF 
	IF NodeExists TRG_CTF_Green_Base 
		kill name = TRG_CTF_Green_Base 
	ENDIF 
	IF NodeExists TRG_CTF_Yellow 
		kill name = TRG_CTF_Yellow 
	ENDIF 
	IF NodeExists TRG_CTF_Yellow_Base 
		kill name = TRG_CTF_Yellow_Base 
	ENDIF 
ENDSCRIPT

SCRIPT Create_Team_Flags 
	IF GameModeEquals is_lobby 
		SWITCH <num_teams> 
			CASE 1 
				IF NodeExists TRG_Flag_Red 
					create name = TRG_Flag_Red 
				ENDIF 
				IF NodeExists TRG_Flag_Red_Base 
					create name = TRG_Flag_Red_Base 
				ENDIF 
			CASE 2 
				IF NodeExists TRG_Flag_Red 
					create name = TRG_Flag_Red 
				ENDIF 
				IF NodeExists TRG_Flag_Blue 
					create name = TRG_Flag_Blue 
				ENDIF 
				IF NodeExists TRG_Flag_Red_Base 
					create name = TRG_Flag_Red_Base 
				ENDIF 
				IF NodeExists TRG_Flag_Blue_Base 
					create name = TRG_Flag_Blue_Base 
				ENDIF 
			CASE 3 
				IF NodeExists TRG_Flag_Red 
					create name = TRG_Flag_Red 
				ENDIF 
				IF NodeExists TRG_Flag_Blue 
					create name = TRG_Flag_Blue 
				ENDIF 
				IF NodeExists TRG_Flag_Green 
					create name = TRG_Flag_Green 
				ENDIF 
				IF NodeExists TRG_Flag_Red_Base 
					create name = TRG_Flag_Red_Base 
				ENDIF 
				IF NodeExists TRG_Flag_Blue_Base 
					create name = TRG_Flag_Blue_Base 
				ENDIF 
				IF NodeExists TRG_Flag_Green_Base 
					create name = TRG_Flag_Green_Base 
				ENDIF 
			CASE 4 
				IF NodeExists TRG_Flag_Red 
					create name = TRG_Flag_Red 
				ENDIF 
				IF NodeExists TRG_Flag_Blue 
					create name = TRG_Flag_Blue 
				ENDIF 
				IF NodeExists TRG_Flag_Green 
					create name = TRG_Flag_Green 
				ENDIF 
				IF NodeExists TRG_Flag_Yellow 
					create name = TRG_Flag_Yellow 
				ENDIF 
				IF NodeExists TRG_Flag_Red_Base 
					create name = TRG_Flag_Red_Base 
				ENDIF 
				IF NodeExists TRG_Flag_Blue_Base 
					create name = TRG_Flag_Blue_Base 
				ENDIF 
				IF NodeExists TRG_Flag_Green_Base 
					create name = TRG_Flag_Green_Base 
				ENDIF 
				IF NodeExists TRG_Flag_Yellow_Base 
					create name = TRG_Flag_Yellow_Base 
				ENDIF 
		ENDSWITCH 
	ELSE 
		GetNumPlayersOnTeam team = 0 
		IF ( <num_members> = 0 ) 
		ELSE 
			IF NodeExists TRG_CTF_Red 
				create name = TRG_CTF_Red 
			ENDIF 
			IF NodeExists TRG_CTF_Red_Base 
				create name = TRG_CTF_Red_Base 
			ENDIF 
		ENDIF 
		GetNumPlayersOnTeam team = 1 
		IF ( <num_members> = 0 ) 
		ELSE 
			IF NodeExists TRG_CTF_Blue 
				create name = TRG_CTF_Blue 
			ENDIF 
			IF NodeExists TRG_CTF_Blue_Base 
				create name = TRG_CTF_Blue_Base 
			ENDIF 
		ENDIF 
		GetNumPlayersOnTeam team = 2 
		IF ( <num_members> = 0 ) 
		ELSE 
			IF NodeExists TRG_CTF_Green 
				create name = TRG_CTF_Green 
			ENDIF 
			IF NodeExists TRG_CTF_Green_Base 
				create name = TRG_CTF_Green_Base 
			ENDIF 
		ENDIF 
		GetNumPlayersOnTeam team = 3 
		IF ( <num_members> = 0 ) 
		ELSE 
			IF NodeExists TRG_CTF_Yellow 
				create name = TRG_CTF_Yellow 
			ENDIF 
			IF NodeExists TRG_CTF_Yellow_Base 
				create name = TRG_CTF_Yellow_Base 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT Team_Flag_Base 
	Obj_SetInnerRadius 10 
	Obj_SetException ex = SkaterInRadius scr = CTF_Team_Base_Trigger params = { <...> } 
ENDSCRIPT

SCRIPT BouncyShadow_Kill 
	FormatText TextName = ShadowName "%o_shadow" o = <ObjectName> 
	printf <ShadowName> 
	kill prefix = <ShadowName> 
ENDSCRIPT

SCRIPT Pigeon_Generic 
	Obj_ShadowOff 
	IF GotParam perched 
		Pigeon_Generic_Idle_Perched 
	ELSE 
		Pigeon_Generic_Idle 
	ENDIF 
ENDSCRIPT

SCRIPT Pigeon_Generic_Idle_Perched 
	Obj_ClearExceptions 
	Obj_SetInnerRadius 15 
	Obj_SetException ex = SkaterInRadius scr = Pigeon_Generic_SkaterNear_Perched 
	SpawnSound NY_SFX_PigeonIdle 
	BEGIN 
		Obj_CycleAnim Anim = Idle NumCycles = RANDOM_RANGE PAIR(1.00000000000, 3.00000000000) 
		Obj_CycleAnim Anim = preen 
	REPEAT 
ENDSCRIPT

SCRIPT Pigeon_Generic_SkaterNear_Perched 
	Obj_ClearExceptions 
	SpawnSound NY_SFX_PigeonFlyUp 
	Obj_CycleAnim Anim = FlyHop 
	goto Pigeon_Generic_Idle_Perched 
ENDSCRIPT

SCRIPT Pigeon_Generic_Idle 
	Obj_ClearExceptions 
	Obj_SetInnerRadius 15 
	Obj_SetException ex = SkaterInRadius scr = Pigeon_Generic_SkaterNear 
	SpawnSound NY_SFX_PigeonIdle 
	BEGIN 
		Obj_CycleAnim Anim = Idle NumCycles = RANDOM_RANGE PAIR(1.00000000000, 3.00000000000) 
		Obj_CycleAnim Anim = peckfromidle 
		BEGIN 
			Obj_RotY speed = 25 
			Obj_CycleAnim Anim = peck 
			Obj_StopRotating 
		REPEAT NumCycles RANDOM_RANGE PAIR(1.00000000000, 5.00000000000) 
		Obj_CycleAnim Anim = pecktoidle 
		Obj_CycleAnim Anim = Idle 
		Obj_CycleAnim Anim = preen 
	REPEAT 
ENDSCRIPT

SCRIPT Pigeon_Generic_SkaterNear 
	Obj_ClearExceptions 
	Obj_GetRandomLink 
	Obj_MoveToLink speed = 8 LinkNum = <link> 
	Obj_LookAtNodeLinked time = 0.20000000298 LinkNum = <link> 
	Obj_SetInnerRadius 5 
	Obj_SetException ex = SkaterInRadius scr = Pigeon_Generic_SkaterReallyNear 
	Obj_PlayAnim Anim = run cycle 
	Obj_WaitMove 
	Obj_SetAnimCycleMode off 
	Obj_WaitAnimFinished 
	Obj_CycleAnim Anim = runtoidle 
	Obj_SetInnerRadius 15 
	Obj_SetException ex = SkaterInRadius scr = Pigeon_Generic_SkaterNear 
	goto Pigeon_Generic_Idle 
ENDSCRIPT

SCRIPT Pigeon_Generic_SkaterReallyNear 
	Obj_ClearExceptions 
	SpawnSound NY_SFX_PigeonFlyUp 
	Obj_CycleAnim Anim = FlyHop 
	Obj_WaitMove 
	Obj_SetInnerRadius 15 
	Obj_SetException ex = SkaterInRadius scr = Pigeon_Generic_SkaterNear 
	goto Pigeon_Generic_Idle 
ENDSCRIPT

SCRIPT COMBO_Letter 
ENDSCRIPT

SCRIPT SKATE_Letter 
ENDSCRIPT

SCRIPT Gap_Gen_Rail2Rail 
	Gap_Gen_RailHop <...> 
ENDSCRIPT

SCRIPT Gap_Gen_Ledge2Ledge 
	Gap_Gen_LedgeHop <...> 
ENDSCRIPT

SCRIPT Gap_Gen_Wire2Wire 
	Gap_Gen_WireHop <...> 
ENDSCRIPT

SCRIPT Gap_Gen_Bench2Bench 
	Gap_Gen_BenchHop <...> 
ENDSCRIPT

SCRIPT Gap_Gen_Rail2Ledge 
	IF GotParam start 
		Gap_Gen_Rail <...> 
	ELSE 
		Gap_Gen_End GapID = <GapID> text = "Rail 2 Ledge" score = 50 <...> 
	ENDIF 
ENDSCRIPT

SCRIPT Gap_Gen_Rail2Wire 
	IF GotParam start 
		Gap_Gen_Rail <...> 
	ELSE 
		Gap_Gen_End GapID = <GapID> text = "Rail 2 Wire" score = 50 <...> 
	ENDIF 
ENDSCRIPT

SCRIPT Gap_Gen_Rail2Bench 
	IF GotParam start 
		Gap_Gen_Rail <...> 
	ELSE 
		Gap_Gen_End GapID = <GapID> text = "Rail 2 Bench" score = 50 <...> 
	ENDIF 
ENDSCRIPT

SCRIPT Gap_Gen_Ledge2Rail 
	IF GotParam start 
		Gap_Gen_Rail <...> 
	ELSE 
		Gap_Gen_End GapID = <GapID> text = "Ledge 2 Rail" score = 50 <...> 
	ENDIF 
ENDSCRIPT

SCRIPT Gap_Gen_Ledge2Wire 
	IF GotParam start 
		Gap_Gen_Rail <...> 
	ELSE 
		Gap_Gen_End GapID = <GapID> text = "Ledge 2 Wire" score = 50 <...> 
	ENDIF 
ENDSCRIPT

SCRIPT Gap_Gen_Ledge2Bench 
	IF GotParam start 
		Gap_Gen_Rail <...> 
	ELSE 
		Gap_Gen_End GapID = <GapID> text = "Ledge 2 Bench" score = 50 <...> 
	ENDIF 
ENDSCRIPT

SCRIPT Gap_Gen_Wire2Rail 
	IF GotParam start 
		Gap_Gen_Rail <...> 
	ELSE 
		Gap_Gen_End GapID = <GapID> text = "Wire 2 Rail" score = 50 <...> 
	ENDIF 
ENDSCRIPT

SCRIPT Gap_Gen_Wire2Ledge 
	IF GotParam start 
		Gap_Gen_Rail <...> 
	ELSE 
		Gap_Gen_End GapID = <GapID> text = "Wire 2 Ledge" score = 50 <...> 
	ENDIF 
ENDSCRIPT

SCRIPT Gap_Gen_Bench2Rail 
	IF GotParam start 
		Gap_Gen_Rail <...> 
	ELSE 
		Gap_Gen_End GapID = <GapID> text = "Bench 2 Rail" score = 50 <...> 
	ENDIF 
ENDSCRIPT

SCRIPT Gap_Gen_Bench2Ledge 
	IF GotParam start 
		Gap_Gen_Rail <...> 
	ELSE 
		Gap_Gen_End GapID = <GapID> text = "Bench 2 Ledge" score = 50 <...> 
	ENDIF 
ENDSCRIPT

SCRIPT Gap_Gen_WireHop 
	IF GotParam start 
		Gap_Gen_Rail <...> 
	ELSE 
		Gap_Gen_End GapID = <GapID> text = "Wire hop" score = 25 <...> 
	ENDIF 
ENDSCRIPT

SCRIPT Gap_Gen_BenchHop 
	IF GotParam start 
		Gap_Gen_Rail <...> 
	ELSE 
		Gap_Gen_End GapID = <GapID> text = "Bench hop" score = 25 <...> 
	ENDIF 
ENDSCRIPT

SCRIPT Gap_Gen_RailHop 
	IF GotParam start 
		Gap_Gen_Rail <...> 
	ELSE 
		Gap_Gen_End GapID = <GapID> text = "Rail hop" score = 25 <...> 
	ENDIF 
ENDSCRIPT

SCRIPT Gap_Gen_LedgeHop 
	IF GotParam start 
		Gap_Gen_Rail <...> 
	ELSE 
		Gap_Gen_End GapID = <GapID> text = "Ledge hop" score = 25 <...> 
	ENDIF 
ENDSCRIPT

SCRIPT Gap_Gen_AcrossTheStreet 
	IF GotParam start 
		Gap_Gen_Rail <...> 
	ELSE 
		Gap_Gen_End GapID = <GapID> text = "Across the street" score = 50 <...> 
	ENDIF 
ENDSCRIPT

SCRIPT Gap_Gen_HighLip 
	IF GotParam start 
		StartGap { 
			GapID = <GapID> 
			flags = [ REQUIRE_LIP CANCEL_GROUND CANCEL_WALL CANCEL_MANUAL CANCEL_RAIL CANCEL_WALLPLANT CANCEL_HANG CANCEL_LADDER ] 
		<...> } 
	ELSE 
		wait 1 frame 
		Gap_Gen_End GapID = <GapID> text = "High lip" score = 100 <...> 
	ENDIF 
ENDSCRIPT

SCRIPT Gap_Gen_RampTransfer 
	IF GotParam start 
		StartGap { 
			GapID = <GapID> 
			flags = PURE_AIR 
		<...> } 
	ELSE 
		Gap_Gen_End GapID = <GapID> text = "Ramp Transfer" score = 100 <...> 
	ENDIF 
ENDSCRIPT

SCRIPT Gap_Gen_Rail 
	IF GotParam start 
		StartGap { 
			GapID = <GapID> 
			flags = [ CANCEL_GROUND CANCEL_MANUAL CANCEL_WALL CANCEL_RAIL CANCEL_LIP CANCEL_WALLPLANT CANCEL_HANG CANCEL_LADDER ] 
		<...> } 
	ELSE 
		IF GotParam end 
			Gap_Gen_End GapID = <GapID> text = <text> score = <score> <...> 
		ELSE 
			printf "### NO GAP TYPE SET FOR ID %g.  MUST BE START OR END ###" g = <GapID> 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT Gap_Gen_Lip 
	IF GotParam start 
		StartGap { 
			GapID = <GapID> 
			flags = [ REQUIRE_LIP CANCEL_GROUND CANCEL_WALL CANCEL_MANUAL CANCEL_RAIL CANCEL_WALLPLANT CANCEL_HANG CANCEL_LADDER ] 
		<...> } 
	ELSE 
		IF GotParam end 
			wait 1 frame 
			EndGap { 
				GapID = <GapID> 
				text = <text> 
			score = <score> } 
		ELSE 
			printf "### NO GAP TYPE SET FOR ID %g.  MUST BE START OR END ###" g = <GapID> 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT Gap_Gen_Transfer 
	IF GotParam start 
		StartGap { 
			GapID = <GapID> 
			flags = PURE_AIR 
		<...> } 
	ELSE 
		IF GotParam end 
			Gap_Gen_End GapID = <GapID> text = <text> score = <score> <...> 
		ELSE 
			printf "### NO GAP TYPE SET FOR ID %g.  MUST BE START OR END ###" g = <GapID> 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT Gap_Gen_PureAir 
	IF GotParam start 
		StartGap { 
			GapID = <GapID> 
			flags = PURE_AIR 
		<...> } 
	ELSE 
		IF GotParam end 
			Gap_Gen_End GapID = <GapID> text = <text> score = <score> <...> 
		ELSE 
			printf "### NO GAP TYPE SET FOR ID %g.  MUST BE START OR END ###" g = <GapID> 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT Gap_Gen_Manual 
	IF GotParam start 
		StartGap { 
			GapID = <GapID> 
			flags = PURE_MANUAL 
		<...> } 
	ELSE 
		IF GotParam end 
			Gap_Gen_End GapID = <GapID> text = <text> score = <score> <...> 
		ELSE 
			printf "### NO GAP TYPE SET FOR ID %g.  MUST BE START OR END ###" g = <GapID> 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT Gap_Gen_End 
	IF GotParam end 
		EndGap { 
			GapID = <GapID> 
			text = <text> 
			score = <score> 
		<...> } 
	ELSE 
		printf "### NO GAP TYPE SET FOR ID %g.  MUST BE START OR END ###" g = <GapID> 
	ENDIF 
ENDSCRIPT

SCRIPT Gap_Gen_Print 
	printf "fuck = %g" g = <GapID> 
ENDSCRIPT

SCRIPT Collect_Hover 
	Obj_RotY speed = 150 
	Obj_Hover Amp = 10 Freq = 1 
ENDSCRIPT

SCRIPT SK5_WinCurrentGoal 
	SpawnScript SK5_WinCurrentGoal_Spawned 
ENDSCRIPT

SCRIPT SK5_WinCurrentGoal_Spawned 
	IF GoalManager_GetActiveGoalId 
		GoalManager_WinGoal name = <goal_id> 
	ENDIF 
ENDSCRIPT

SCRIPT SK5_LoseCurrentGoal 
	SpawnScript SK5_LoseCurrentGoal_Spawned 
ENDSCRIPT

SCRIPT SK5_LoseCurrentGoal_Spawned 
	IF GoalManager_GetActiveGoalId 
		GoalManager_LoseGoal name = <goal_id> 
	ENDIF 
ENDSCRIPT

SCRIPT SK5_AdvanceStage 
	GoalManager_DeactivateAllGoals 
	GoalManager_GetCurrentChapterAndStage 
	GoalManager_AdvanceStage force 
	<stage_struct> = ( ( CHAPTER_COMPLETION_SCRIPTS [ <currentChapter> ] ) [ <currentStage> ] ) 
	IF StructureContains structure = <stage_struct> script_name 
		<stage_script> = ( <stage_struct> . script_name ) 
	ENDIF 
	IF StructureContains structure = <stage_struct> params 
		<stage_script_params> = ( <stage_struct> . params ) 
	ENDIF 
	<stage_script> <stage_script_params> just_won_goal 
ENDSCRIPT

SCRIPT SK5_AdvanceStage_Debug 
	GoalManager_DeactivateAllGoals 
	GoalManager_GetCurrentChapterAndStage 
	GoalManager_AdvanceStage force 
	<stage_struct> = ( ( CHAPTER_COMPLETION_SCRIPTS [ <currentChapter> ] ) [ <currentStage> ] ) 
	IF StructureContains structure = <stage_struct> script_name 
		<stage_script> = ( <stage_struct> . script_name ) 
	ENDIF 
	IF StructureContains structure = <stage_struct> params 
		<stage_script_params> = ( <stage_struct> . params ) 
	ENDIF 
	<stage_script> <stage_script_params> 
ENDSCRIPT

SCRIPT ShatterAndDie area = 1000 variance = 4.59999990463 vel_x = RANDOM(1, 1, 1) RANDOMCASE 0.00000000000 RANDOMCASE 30 RANDOMCASE -30 RANDOMEND vel_y = RANDOM(1, 1, 1) RANDOMCASE 10 RANDOMCASE 30 RANDOMCASE 50 RANDOMEND vel_z = RANDOM(1, 1, 1) RANDOMCASE 0 RANDOMCASE 30 RANDOMCASE -30 RANDOMEND spread = 1.00000000000 
	kill name = <name> 
	Shatter name = <name> area = <area> variance = <variance> vel_x = <vel_x> vel_y = <vel_y> vel_z = <vel_z> spread = <spread> 
ENDSCRIPT

SCRIPT Generic_LeavingGameAreaMessage 
	IF NOT InSplitScreenGame 
		Create_Panel_Message id = leaving_message text = "Leaving Game Area" 
	ENDIF 
ENDSCRIPT

SCRIPT WAT_Grid u = 0 framerate = 8 grid_size = 4 
	grid_size = ( <grid_size> + 0.00000000000 ) 
	offset = ( 1.00000000000 / <grid_size> ) 
	max_offset = ( 1 - <offset> ) 
	v = <max_offset> 
	IF GotParam RandomOffset 
		range_cap = ( <grid_size> - 1 ) 
		CastToInteger range_cap 
		GetRandomValue name = random_offset a = 0 b = <range_cap> integer 
		u = ( <offset> * <random_offset> ) 
		GetRandomValue name = random_offset a = 0 b = <range_cap> integer 
		v = ( <offset> * <random_offset> ) 
	ENDIF 
	BEGIN 
		SetUVWibbleOffsets sector = <object> u_off = <u> , v_off = <v> 
		IF NOT ( <v> = 0 ) 
			v = ( <v> - <offset> ) 
		ELSE 
			v = <max_offset> 
			u = ( <u> + <offset> ) 
			IF ( <u> = 1 ) 
				u = 0 
			ENDIF 
		ENDIF 
		wait <framerate> frames 
	REPEAT 
ENDSCRIPT

SCRIPT SetupProTeam 
	GoalManager_SetTeamMember pro = lasek 
	GoalManager_SetTeamMember pro = hawk 
	GoalManager_SetTeamMember pro = mullen 
	GoalManager_SetTeamMember pro = margera 
	GoalManager_SetTeamMember pro = reynolds 
ENDSCRIPT

SCRIPT CarTOD_TurnOffHeadlights 
	printf "### turning off headlights" 
	RunScriptOnComponentType component = model target = Obj_ReplaceTexture params = { 
		src = "JKU_LightCircle_Transparent.png" dest = "textures/cars/JKU_LightCircle_Transparent" 
	} 
	RunScriptOnComponentType component = model target = Obj_ReplaceTexture params = { 
		src = "JKU_HeadlightGlow_Transparent.png" dest = "textures/cars/JKU_HeadlightGlow_Transparent" 
	} 
ENDSCRIPT

SCRIPT CarTOD_TurnOnHeadlights 
	printf "### turning on headlights" 
	RunScriptOnComponentType component = model target = Obj_ReplaceTexture params = { 
		src = "JKU_LightCircle_Transparent.png" dest = "textures/cars/JKU_LightCircle" 
	} 
	RunScriptOnComponentType component = model target = Obj_ReplaceTexture params = { 
		src = "JKU_HeadlightGlow_Transparent.png" dest = "textures/cars/JKU_HeadlightGlow" 
	} 
ENDSCRIPT

SCRIPT PlayKISS_Movie 
	SetGlobalFlag flag = MOVIE_UNLOCKED_KISS 
	wait 100 frames 
	PauseSkaters 
	PlaySkaterCamAnim Skater = 0 { virtual_cam 
		targetid = world 
		targetOffset = VECTOR(9207.79980468750, 252.10000610352, 192.30000305176) 
		positionOffset = VECTOR(-789.70001220703, 450.29998779297, 92.90000152588) 
		frames = 1200 
		skippable = 0 
		play_hold 
	} 
	create_dialog_box { title = "CONGRATULATIONS!" 
		title_font = testtitle 
		text = "   KISS movie Unlocked!  Collect K-I-S-S again and they\'ll put on a show for you!" 
		pos = PAIR(320.00000000000, 240.00000000000) 
		just = [ center center ] 
		text_rgba = [ 88 105 112 128 ] 
		text_dims = PAIR(330.00000000000, 0.00000000000) 
		line_spacing = 0.85000002384 
		buttons = [ { font = small text = "OK" pad_choose_script = KissMovie_unlock_accept } ] 
		delay_input 
		pad_focus_script = text_twitch_effect 
		style = special_dialog_style 
	} 
	WaitForEvent type = KissMovie_unlock_accept_done 
	ingame_play_movie "movies\\kiss" level = load_se 
ENDSCRIPT


