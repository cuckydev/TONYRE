SCRIPT (Play_BMX_Anim) 
	RANDOM(1, 1, 1, 1, 1) 
		RANDOMCASE 
		(TRG_BMX_Rider) : (Obj_PlayAnim) (anim) = (BS_Stall) 
		(TRG_BMX_Bike) : (Obj_PlayAnim) (anim) = (BMX_BS_Stall) 
		RANDOMCASE 
		(TRG_BMX_Rider) : (Obj_PlayAnim) (anim) = (Backflip) 
		(TRG_BMX_Bike) : (Obj_PlayAnim) (anim) = (BMX_Backflip) 
		RANDOMCASE 
		(TRG_BMX_Rider) : (Obj_PlayAnim) (anim) = (_180LateTurn) 
		(TRG_BMX_Bike) : (Obj_PlayAnim) (anim) = (BMX_180LateTurn) 
		RANDOMCASE 
		(TRG_BMX_Rider) : (Obj_PlayAnim) (anim) = (OneFooter) 
		(TRG_BMX_Bike) : (Obj_PlayAnim) (anim) = (BMX_OneFooter) 
		RANDOMCASE 
		(TRG_BMX_Rider) : (Obj_PlayAnim) (anim) = (_540) 
		(TRG_BMX_Bike) : (Obj_PlayAnim) (anim) = (BMX_540) 
	RANDOMEND 
ENDSCRIPT

SCRIPT (AI_BMX_Rider) 
	BEGIN 
		(Play_BMX_Anim) 
		(Obj_WaitAnimFinished) 
		(TRG_BMX_Rider) : (Obj_Rotate) (absolute) = VECTOR(0, -90, 0) 
		(TRG_BMX_Bike) : (Obj_Rotate) (absolute) = VECTOR(0, -90, 0) 
		(Play_BMX_Anim) 
		(Obj_WaitAnimFinished) 
		(TRG_BMX_Rider) : (Obj_Rotate) (absolute) = VECTOR(0, 90, 0) 
		(TRG_BMX_Bike) : (Obj_Rotate) (absolute) = VECTOR(0, 90, 0) 
	REPEAT 
ENDSCRIPT

SCRIPT (AI_BMX_Bike) 
ENDSCRIPT

SCRIPT (Skateshop_PedProInitialSetup) 
	(GetNodeName) 
	(Obj_SetPathVelocity) 55 (fps) 
	(Obj_SetPathAcceleration) 55 (fpsps) 
	(Obj_PathHeading) (Off) 
	(Obj_SpawnScript) (Skateshop_PedProDistanceCheck) 
	(Obj_MoveToNode) (name) = <nodename> (orient) 
ENDSCRIPT

SCRIPT (Skateshop_PedProStartRun) 
	IF NOT (LevelIs) (load_skateshop) 
		(Obj_PlayAnim) (anim) = (StandIdleFromPedIdle) 
		(Obj_WaitAnimFinished) 
		(Obj_MoveToNode) (name) = <Path> (time) = 0.81000000238 (second) 
		(Obj_PlayAnim) (anim) = (DropIn_Ped) 
		(Obj_SetPathAcceleration) 43 (fpsps) 
		(Obj_FollowPath) (name) = <dropin> 
		(Skateshop_PedProPlayLandSound) 
		(Obj_Rotate) (relative) = VECTOR(90.00000000000, 0.00000000000, 0.00000000000) 
	ELSE 
		(Obj_PlayAnim) (anim) = (StandIdleFromPedIdle) 
		(Obj_WaitAnimFinished) 
		(Obj_PlayAnim) (anim) = (DropInApproach) 
		(Obj_WaitAnimFinished) 
		(Skateshop_PedProPlayLandSound) 
		(Obj_PlayAnim) (anim) = <DropInAnim> 
		(Obj_WaitAnimFinished) 
		(Obj_SetPathAcceleration) 43000 (fpsps) 
		(Obj_MoveToNode) (name) = <start> 
		(Obj_Flip) 
		(Obj_FollowPath) (name) = <start> 
	ENDIF 
	(Obj_SpawnScript) (Skateshop_PedProIncreaseAcceleration) 
	(Obj_WaitAnimFinished) 
	(wait) 1 (frame) 
	(Obj_PlayAnim) (anim) = (Crouchidle) (Cycle) 
	(Obj_WaitMove) 
ENDSCRIPT

SCRIPT (Skateshop_PedProIncreaseAcceleration) 
	(wait) 1 (second) 
	(Obj_SetPathAcceleration) 555 (fpsps) 
ENDSCRIPT

SCRIPT (Skateshop_PedProCrossBottom) 
	(Skateshop_PedProNormalBottom) (Path) = <Path> 
ENDSCRIPT

SCRIPT (Skateshop_PedProNormalBottom) 
	(Obj_PlayAnim) (anim) = RANDOM(1, 1) RANDOMCASE (CrouchedLand) RANDOMCASE (SketchyCrouchLand) (speed) = 1.39999997616 RANDOMEND 
	(Obj_FollowPath) (name) = <Path> 
	(Obj_WaitAnimFinished) 
	(Obj_PlayAnim) (anim) = (Crouchidle) (Cycle) 
	(Obj_WaitMove) 
ENDSCRIPT

SCRIPT (Skateshop_PedProManualBottom) 
	(Obj_PlayAnim) (anim) = (RevertFS) (speed) = 1.39999997616 
	(Obj_FollowPath) (name) = <Path> 
	(Obj_Playsound) (RevertWood) (pitch) = RANDOM(1, 1, 1) RANDOMCASE 90 RANDOMCASE 100 RANDOMCASE 110 RANDOMEND 
	(Obj_WaitAnimFinished) 
	(Obj_PlayAnim) (anim) = (Manual) 
	(Obj_WaitAnimFinished) 
	(Obj_PlayAnim) (anim) = (Manual_Range) (from) = 40 (to) = 1 
	(Obj_WaitMove) 
ENDSCRIPT

SCRIPT (Skateshop_PedProTransfer) 
	(Obj_MoveToNode) (name) = <Path4> (speed) = 10 
	(Skateshop_PedProDoJumpTrick) 
	(Skateshop_PedProNormalBottom) (Path) = <Path4> 
	(Skateshop_PedProDoJumpTrick) 
	(Skateshop_PedProNormalBottom) (Path) = <Path3> 
	(Obj_MoveToNode) (name) = <Path2> (speed) = 10 
	(Skateshop_PedProDoJumpTrick) 
ENDSCRIPT

SCRIPT (Skateshop_PedProGrind) 
	(Obj_Playsound) (GrindMetalOn) 
	(Obj_MoveToNode) (name) = <Path4> (speed) = 10 
	(Obj_PlayAnim) (anim) = (Init_FiftyFifty) (from) = 20 (to) = (end) 
	(Skateshop_PedProRotateDown) 
	(Obj_WaitRotate) 
	(Obj_RotY) (angle) = 90 (speed) = 800 
	(Obj_WaitMove) 
	(Obj_StopSound) 
	(Obj_Playsound) (GrindMetalOff) 
	(Obj_RotY) (angle) = 90 (speed) = 800 
	(Skateshop_PedProRotateDown) 
	(Skateshop_PedProManualBottom) (Path) = <Path4> 
	(Skateshop_PedProDoJumpTrick) 
	(Skateshop_PedProManualBottom) (Path) = <Path3> 
	(Obj_Playsound) (GrindMetalOn) 
	(Obj_MoveToNode) (name) = <Path2> (speed) = 10 
	(Obj_PlayAnim) (anim) = (Init_FiftyFifty) (from) = 20 (to) = (end) 
	(Skateshop_PedProRotateDown) 
	(Obj_WaitRotate) 
	(Obj_RotY) (angle) = -90 (speed) = 800 
	(Obj_WaitMove) 
	(Obj_StopSound) 
	(Obj_Playsound) (GrindMetalOff) 
	(Obj_RotY) (angle) = -90 (speed) = 800 
	(Skateshop_PedProRotateDown) 
ENDSCRIPT

SCRIPT (Skateshop_PedProDoTrick) 
	(Obj_ShadowOff) 
	RANDOM(1, 1, 1, 1, 1, 1) RANDOMCASE RANDOMCASE RANDOMCASE RANDOMCASE RANDOMCASE RANDOMCASE (Skateshop_PedPlayProCongrats) RANDOMEND 
	RANDOM(1, 1, 1, 1) 
		RANDOMCASE (Skateshop_PedProDoJumpTrick) 
		RANDOMCASE (Skateshop_PedProDoJumpTrick) 
		RANDOMCASE (Skateshop_PedProDoJumpTrick) 
		RANDOMCASE (Skateshop_PedProDoLipTrick) (Path) = <Path> 
	RANDOMEND 
	(Skateshop_PedProPlayLandSound) 
	(Obj_ShadowOn) 
ENDSCRIPT

SCRIPT (Skateshop_PedProPlayLandSound) 
	IF (LevelIs) (load_skateshop) 
		IF NOT (ScreenElementExists) (id) = (kill_skating_sounds_anchor) 
			(Obj_Playsound) RANDOM(1, 1, 1) RANDOMCASE (landWood) RANDOMCASE (landWood2) RANDOMCASE (landWood3) RANDOMEND (pitch) = RANDOM(1, 1, 1) RANDOMCASE 90 RANDOMCASE 100 RANDOMCASE 110 RANDOMEND 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT (Skateshop_PedProDoLipTrick) 
	RANDOM(1, 1, 1, 1, 1) 
		RANDOMCASE 
		(Obj_PlayAnim) (anim) = (MuteInvert_Init) 
		(Obj_WaitAnimFinished) 
		(Obj_PlayAnim) (anim) = (MuteInvert_Range) (from) = 20 (to) = (end) 
		(Obj_WaitAnimFinished) 
		(Obj_PlayAnim) (anim) = (MuteInvert_Out) 
		RANDOMCASE 
		(Obj_PlayAnim) (anim) = (OneFootInvert_Init) 
		(Obj_WaitAnimFinished) 
		(Obj_PlayAnim) (anim) = (OneFootInvert_Range) (from) = 20 (to) = (end) 
		(Obj_WaitAnimFinished) 
		(Obj_PlayAnim) (anim) = (OneFootInvert_Out) 
		RANDOMCASE 
		(Obj_PlayAnim) (anim) = (BSFootplant_Init) 
		(Obj_WaitAnimFinished) 
		(Obj_PlayAnim) (anim) = (BSFootplant_Range) (from) = 20 (to) = (end) 
		(Obj_WaitAnimFinished) 
		(Obj_PlayAnim) (anim) = (BSFootplant_Out) 
		RANDOMCASE 
		(Obj_PlayAnim) (anim) = (NoseTailStall_Init) 
		IF NOT (ScreenElementExists) (id) = (kill_skating_sounds_anchor) 
			(Obj_Playsound) (copinghit3_11) (pitch) = RANDOM(1, 1, 1) RANDOMCASE 90 RANDOMCASE 100 RANDOMCASE 110 RANDOMEND 
		ENDIF 
		(Obj_WaitAnimFinished) 
		(Obj_PlayAnim) (anim) = (NoseTailStall_Range) (from) = 20 (to) = (end) 
		(Obj_WaitAnimFinished) 
		(Obj_PlayAnim) (anim) = (NoseTailStall_Out) 
		RANDOMCASE 
		(Obj_PlayAnim) (anim) = (FS180Noseblunt_Init) 
		(Obj_WaitAnimFinished) 
		IF NOT (ScreenElementExists) (id) = (kill_skating_sounds_anchor) 
			(Obj_Playsound) (copinghit3_11) (pitch) = RANDOM(1, 1, 1) RANDOMCASE 90 RANDOMCASE 100 RANDOMCASE 110 RANDOMEND 
		ENDIF 
		(Obj_PlayAnim) (anim) = (FS180Noseblunt_Range) (from) = 20 (to) = (end) 
		(Obj_WaitAnimFinished) 
		(Obj_PlayAnim) (anim) = (FS180Noseblunt_Out) 
	RANDOMEND 
	(wait) 25 (frames) 
	(Obj_SetPathAcceleration) 55 (fpsps) 
	(Obj_FollowPath) (name) = <Path> 
	(Obj_WaitAnimFinished) 
	(Obj_SetPathAcceleration) 555 (fpsps) 
	(Obj_Flip) 
	(Obj_Rotate) (relative) = VECTOR(0.00000000000, 180.00000000000, 0.00000000000) 
ENDSCRIPT

SCRIPT (Skateshop_PedProDoJumpTrick) 
	RANDOM(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1) 
		RANDOMCASE (Obj_RotY) (angle) = 180 (speed) = 180 
		RANDOMCASE (Obj_RotY) (angle) = 180 (speed) = 180 
		RANDOMCASE (Obj_RotY) (angle) = 180 (speed) = 180 
		RANDOMCASE (Obj_RotY) (angle) = 180 (speed) = 180 
		RANDOMCASE (Obj_RotY) (angle) = 180 (speed) = 180 
		RANDOMCASE (Obj_RotY) (angle) = 180 (speed) = 180 
		RANDOMCASE (Obj_RotY) (angle) = 540 (speed) = 400 
		RANDOMCASE (Obj_RotY) (angle) = 900 (speed) = 700 
		RANDOMCASE (Obj_RotY) (angle) = -180 (speed) = 180 
		RANDOMCASE (Obj_RotY) (angle) = -180 (speed) = 180 
		RANDOMCASE (Obj_RotY) (angle) = -180 (speed) = 180 
		RANDOMCASE (Obj_RotY) (angle) = -180 (speed) = 180 
		RANDOMCASE (Obj_RotY) (angle) = -180 (speed) = 180 
		RANDOMCASE (Obj_RotY) (angle) = -180 (speed) = 180 
		RANDOMCASE (Obj_RotY) (angle) = -540 (speed) = 400 
		RANDOMCASE (Obj_RotY) (angle) = -900 (speed) = 700 
	RANDOMEND 
	IF (LevelIs) (load_skateshop) 
		IF NOT (ScreenElementExists) (id) = (kill_skating_sounds_anchor) 
			(Obj_Playsound) RANDOM(1, 1, 1) RANDOMCASE (OllieWood) RANDOMCASE (OllieWood2) RANDOMCASE (OllieWood3) RANDOMEND (pitch) = RANDOM(1, 1, 1) RANDOMCASE 90 RANDOMCASE 100 RANDOMCASE 110 RANDOMEND 
		ENDIF 
	ENDIF 
	(Obj_PlayAnim) (anim) = RANDOM(1, 1, 1) RANDOMCASE (FastPlant) RANDOMCASE (NoComply) RANDOMCASE (BeanPlant) RANDOMEND (speed) = 1.50000000000 
	(Obj_Jump) (gravity) = -400 (speed) = 350 
	(Obj_WaitAnimFinished) 
	RANDOM(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1) 
		RANDOMCASE 
		BEGIN 
			(Obj_PlayAnim) (anim) = RANDOM(1, 1, 1, 1, 1, 1) RANDOMCASE (Impossible) RANDOMCASE (HeelFlip) RANDOMCASE (KickFlip) RANDOMCASE (HardFlip) RANDOMCASE (VarialKickFlip) RANDOMCASE (VarialHeelFlip) RANDOMEND (speed) = 1.50000000000 
			(Obj_WaitAnimFinished) 
		REPEAT 3 
		RANDOMCASE 
		(Obj_PlayAnim) (anim) = (NoseGrab) 
		(Obj_WaitAnimFinished) 
		(Obj_PlayAnim) (anim) = (NoseGrab) (backwards) 
		RANDOMCASE 
		(Obj_PlayAnim) (anim) = (Method) 
		(Obj_WaitAnimFinished) 
		(Obj_PlayAnim) (anim) = (Method) (backwards) 
		RANDOMCASE 
		(Obj_PlayAnim) (anim) = (Benihana) 
		(Obj_WaitAnimFinished) 
		(Obj_PlayAnim) (anim) = (Benihana) (backwards) 
		RANDOMCASE 
		(Obj_PlayAnim) (anim) = (RocketAir) 
		(Obj_WaitAnimFinished) 
		(Obj_PlayAnim) (anim) = (RocketAir) (backwards) 
		RANDOMCASE 
		(Obj_PlayAnim) (anim) = (JapanAir) 
		(Obj_WaitAnimFinished) 
		(Obj_PlayAnim) (anim) = (JapanAir) (backwards) 
		RANDOMCASE 
		(Obj_PlayAnim) (anim) = (Stiffy) 
		(Obj_WaitAnimFinished) 
		(Obj_PlayAnim) (anim) = (Stiffy) (backwards) 
		RANDOMCASE 
		(Obj_PlayAnim) (anim) = (CrossBone) 
		(Obj_WaitAnimFinished) 
		(Obj_PlayAnim) (anim) = (CrossBone) (backwards) 
		RANDOMCASE 
		(Obj_PlayAnim) (anim) = (IndyDelMar) 
		(Obj_WaitAnimFinished) 
		(Obj_PlayAnim) (anim) = (IndyDelMar) (backwards) 
		RANDOMCASE 
		(Obj_PlayAnim) (anim) = (CannonBall) 
		(Obj_WaitAnimFinished) 
		(Obj_PlayAnim) (anim) = (CannonBall) (backwards) 
		RANDOMCASE 
		(Obj_PlayAnim) (anim) = (CrookedCop) 
		(Obj_WaitAnimFinished) 
		(Obj_PlayAnim) (anim) = (CrookedCop) (backwards) 
		RANDOMCASE 
		(Obj_PlayAnim) (anim) = (OneFootJapan) 
		(Obj_WaitAnimFinished) 
		(Obj_PlayAnim) (anim) = (OneFootJapan) (backwards) 
	RANDOMEND 
	(Obj_WaitJumpFinished) 
ENDSCRIPT

SCRIPT (Skateshop_PedProEndRun) 
	(GetNodeName) 
	(Obj_PlayAnim) (anim) = (ExitHalfPipe) 
	(Obj_Rotate) (relative) = VECTOR(90.00000000000, 0.00000000000, 0.00000000000) 
	(wait) 15 (frames) 
	(Obj_MoveToNode) (name) = <nodename> (speed) = 10 
	(Obj_WaitAnimFinished) 
	(Obj_Flip) 
	(Obj_LookAtNode) (name) = <Node> (time) = 1 
	(Obj_PlayAnim) (anim) = (StandIdleRotate) (Cycle) 
	(wait) 1 (seconds) 
	(Obj_MoveToNode) (name) = <nodename> (orient) 
	(Obj_PlayAnim) (anim) = (StandIdleToPedIdle) 
	(Obj_WaitAnimFinished) 
	(Obj_SetPathAcceleration) 55 (fpsps) 
ENDSCRIPT

SCRIPT (Skateshop_PedProRotateUp) (speed) = 400 
	(Obj_WaitRotate) 
	(Obj_RotX) (angle) = -90 (speed) = 400 
ENDSCRIPT

SCRIPT (Skateshop_PedProRotateDown) 
	(Obj_WaitRotate) 
	(Obj_RotX) (angle) = 90 (speed) = 400 
ENDSCRIPT

SCRIPT (Skateshop_PedPlayProCongrats) 
	IF NOT (ScreenElementExists) (id) = (select_skater_anchor) 
		IF (LevelIs) (load_skateshop) 
			(Obj_Playstream) RANDOM_NO_REPEAT(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1) 
				RANDOMCASE (andrew_success08) 
				RANDOMCASE (andrew_success10) 
				RANDOMCASE (chad_success01) 
				RANDOMCASE (chad_success05) 
				RANDOMCASE (chad_success12) 
				RANDOMCASE (chad_success45) 
				RANDOMCASE (elissa_success08) 
				RANDOMCASE (elissa_success09) 
				RANDOMCASE (elissa_success13) 
				RANDOMCASE (elissa_success27) 
				RANDOMCASE (eric_success02) 
				RANDOMCASE (eric_success21) 
				RANDOMCASE (eric_success28) 
				RANDOMCASE (geoff_success09) 
				RANDOMCASE (geoff_success20) 
				RANDOMCASE (geoff_success22) 
				RANDOMCASE (jamie_success18) 
				RANDOMCASE (jamie_success22) 
				RANDOMCASE (jamie_success28) 
				RANDOMCASE (jamie_success29) 
				RANDOMCASE (steve_success04) 
				RANDOMCASE (tony_success03) 
				RANDOMCASE (tony_success04) 
				RANDOMCASE (tony_success12) 
				RANDOMCASE (tony_success19) 
			RANDOMEND 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT (Skateshop_PedProDistanceCheck) 
	BEGIN 
		(wait) 1 (frame) 
		IF (Obj_ObjectInRadius) (radius) = 3 (feet) (type) = (skater) 
			IF (LevelIs) (load_skateshop) 
				IF NOT (ScreenElementExists) (id) = (select_skater_anchor) 
					(PlayStream) RANDOM_NO_REPEAT(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1) 
						RANDOMCASE (Bucky_Avoid01) 
						RANDOMCASE (Bucky_Avoid02) 
						RANDOMCASE (Bucky_Avoid03) 
						RANDOMCASE (Bucky_Avoid04) 
						RANDOMCASE (Bucky_Avoid05) 
						RANDOMCASE (Bucky_Avoid06) 
						RANDOMCASE (Bucky_Avoid07) 
						RANDOMCASE (Bucky_Avoid08) 
						RANDOMCASE (Bucky_Avoid09) 
						RANDOMCASE (Rodney_Avoid01) 
						RANDOMCASE (Rodney_Avoid02) 
						RANDOMCASE (Rodney_Avoid03) 
						RANDOMCASE (Rodney_Avoid04) 
						RANDOMCASE (Steve_Avoid01) 
						RANDOMCASE (Steve_Avoid02) 
						RANDOMCASE (Steve_Avoid03) 
						RANDOMCASE (Steve_Avoid04) 
						RANDOMCASE (Steve_Avoid05) 
						RANDOMCASE (Steve_Avoid06) 
						RANDOMCASE (Steve_Avoid07) 
						RANDOMCASE (Steve_Avoid08) 
						RANDOMCASE (Steve_Avoid09) 
						RANDOMCASE (Steve_Avoid010) 
						RANDOMCASE (Steve_Avoid011) 
						RANDOMCASE (Steve_Avoid012) 
						RANDOMCASE (Steve_Avoid013) 
						RANDOMCASE (Steve_Avoid014) 
						RANDOMCASE (Steve_Avoid015) 
						RANDOMCASE (Tony_Avoid01) 
						RANDOMCASE (Tony_Avoid02) 
						RANDOMCASE (Tony_Avoid03) 
						RANDOMCASE (Tony_Avoid04) 
						RANDOMCASE (Tony_Avoid05) 
						RANDOMCASE (Tony_Avoid06) 
						RANDOMCASE (Tony_Avoid07) 
						RANDOMCASE (Tony_Avoid08) 
						RANDOMCASE (Tony_Avoid09) 
						RANDOMCASE (Tony_Avoid010) 
					RANDOMEND (volume) = RANDOM(1, 1, 1) RANDOMCASE 30 RANDOMCASE 50 RANDOMCASE 90 RANDOMEND (dropoff) = 500 
					(wait) 5 (seconds) 
				ENDIF 
			ENDIF 
		ENDIF 
	REPEAT 
ENDSCRIPT

SCRIPT (Ped_AI_Skater) (Path) = (TRG_Ped_AI_SkaterNav01) 
	(GetNodeName) 
	(Obj_SetPathVelocity) 35 (fps) 
	(Obj_SetPathAcceleration) 55 (fpsps) 
	(Obj_PathHeading) (On) 
	(Obj_StickToGround) (distAbove) = 3 (distBelow) = 16 
	(Obj_SetPathTurnDist) 10 (feet) 
	(Obj_MoveToNode) (name) = <nodename> (orient) 
	(Obj_SetPathAcceleration) 43 (fpsps) 
	(Obj_FollowPathLinked) 
	(Obj_PlayAnim) (anim) = (Crouchidle) (Cycle) 
ENDSCRIPT

SCRIPT (ai_printf) 
	IF (IsTrue) (ai_debug) 
		(printf) <...> 
	ENDIF 
ENDSCRIPT

SCRIPT (Ped_AI_Skater_GroundTrick) 
	(ai_printf) "AI skater doing ground trick" 
	(Ped_AI_Skater_FlipTrick) 
	(Ped_AI_Skater_Land) 
	(Obj_PlayAnim) (anim) = (Crouchidle) (Cycle) 
ENDSCRIPT

SCRIPT (Ped_AI_Skater_JumpTo) 
	(ai_printf) "AI skater jumping up" 
	(Obj_StickToGround) (Off) 
	(Obj_Playsound) (OllieConc) (pitch) = RANDOM(1, 1, 1) RANDOMCASE 90 RANDOMCASE 100 RANDOMCASE 110 RANDOMEND 
	(Obj_PlayAnim) (anim) = RANDOM(1, 1, 1, 1) RANDOMCASE (Ollie) RANDOMCASE (FastPlant) RANDOMCASE (NoComply) RANDOMCASE (BeanPlant) RANDOMEND (speed) = 1.50000000000 
	(Obj_WaitAnimFinished) 
	(Obj_PlayAnim) (anim) = (AirIdle) (Cycle) 
ENDSCRIPT

SCRIPT (Ped_AI_Skater_StartGrind) 
	(ai_printf) "AI skater starting grind" 
	(Obj_SetPathVelocity) 45 (fps) 
	(Obj_Playsound) (GrindMetalOn) (pitch) = RANDOM(1, 1, 1) RANDOMCASE 90 RANDOMCASE 100 RANDOMCASE 110 RANDOMEND 
	RANDOM(1, 1) 
		RANDOMCASE (Ped_AI_Skater_Grind) (init) = (Init_FiftyFifty) (range) = (FiftyFifty_Range) 
		RANDOMCASE (Ped_AI_Skater_Grind) (init) = (Init_TailSlide) (range) = (TailSlide_Range) 
	RANDOMEND 
ENDSCRIPT

SCRIPT (Ped_AI_Skater_Grind) 
	(Obj_PlayAnim) (anim) = <init> 
	(Obj_WaitAnimFinished) 
	(Obj_PlayAnim) (anim) = <range> (from) = 40 (to) = 20 
	(Obj_WaitAnimFinished) 
	BEGIN 
		(ai_printf) "AI skater grinding" 
		(Obj_PlayAnim) (anim) = <range> (from) = 20 (to) = 60 
		(Obj_WaitAnimFinished) 
		(Obj_PlayAnim) (anim) = <range> (from) = 60 (to) = 20 
		(Obj_WaitAnimFinished) 
	REPEAT 
ENDSCRIPT

SCRIPT (Ped_AI_Skater_StartManual) 
	(ai_printf) "AI skater starting manual" 
	(Obj_SetPathVelocity) 25 (fps) 
	(Obj_StickToGround) (On) 
	RANDOM(1, 1) 
		RANDOMCASE (Ped_AI_Skater_Manual) (init) = (Manual) (range) = (Manual_Range) 
		RANDOMCASE (Ped_AI_Skater_Manual) (init) = (NoseManual) (range) = (NoseManual_Range) 
	RANDOMEND 
ENDSCRIPT

SCRIPT (Ped_AI_Skater_Manual) 
	(Obj_PlayAnim) (anim) = <init> 
	(Obj_WaitAnimFinished) 
	(Obj_PlayAnim) (anim) = <range> (from) = 40 (to) = 20 
	(Obj_WaitAnimFinished) 
	BEGIN 
		(ai_printf) "AI skater Manualing" 
		(Obj_PlayAnim) (anim) = <range> (from) = 20 (to) = 60 
		(Obj_WaitAnimFinished) 
		(Obj_PlayAnim) (anim) = <range> (from) = 60 (to) = 20 
		(Obj_WaitAnimFinished) 
	REPEAT 
ENDSCRIPT

SCRIPT (Ped_AI_Skater_FlipTrick) 
	(ai_printf) "AI skater doing grind hop trick" 
	(Obj_PathHeading) (Off) 
	(Obj_Playsound) (OllieConc) (pitch) = RANDOM(1, 1, 1) RANDOMCASE 90 RANDOMCASE 100 RANDOMCASE 110 RANDOMEND 
	RANDOM(1, 1, 1) 
		RANDOMCASE 
		RANDOMCASE (Obj_RotY) (angle) = 360 (speed) = 360 
		RANDOMCASE (Obj_RotY) (angle) = -360 (speed) = 360 
	RANDOMEND 
	(Obj_PlayAnim) (anim) = RANDOM(1, 1, 1, 1) RANDOMCASE (Ollie) RANDOMCASE (FastPlant) RANDOMCASE (NoComply) RANDOMCASE (BeanPlant) RANDOMEND (speed) = 1.50000000000 
	(Obj_Jump) (gravity) = -420 (speed) = 200 
	(Obj_WaitAnimFinished) 
	(ai_printf) "AI skater doing grind hop trick2" 
	(Obj_PlayAnim) (anim) = RANDOM(1, 1, 1, 1, 1, 1) RANDOMCASE (Impossible) RANDOMCASE (HeelFlip) RANDOMCASE (KickFlip) RANDOMCASE (HardFlip) RANDOMCASE (VarialKickFlip) RANDOMCASE (VarialHeelFlip) RANDOMEND (speed) = 1.50000000000 
	(Obj_WaitAnimFinished) 
	(Obj_WaitJumpFinished) 
	(Obj_PathHeading) (On) 
ENDSCRIPT

SCRIPT (Ped_AI_Skater_Land) 
	(ai_printf) "AI skater landing" 
	(Obj_Playsound) (LandConc) (pitch) = RANDOM(1, 1, 1) RANDOMCASE 90 RANDOMCASE 100 RANDOMCASE 110 RANDOMEND 
	(Obj_SetPathVelocity) 35 (fps) 
	(Obj_StickToGround) (On) 
	(Obj_PathHeading) (On) 
	(Obj_PlayAnim) (anim) = RANDOM(1, 1) RANDOMCASE (CrouchedLand) RANDOMCASE (SketchyCrouchLand) (speed) = 1.39999997616 RANDOMEND 
	(Obj_WaitJumpFinished) 
	(Obj_PlayAnim) (anim) = (Crouchidle) (Cycle) 
ENDSCRIPT

SCRIPT (Ped_AI_Skater_GrindHopTrickGrind) 
	(Obj_Playsound) (GrindMetalOff) (pitch) = RANDOM(1, 1, 1) RANDOMCASE 90 RANDOMCASE 100 RANDOMCASE 110 RANDOMEND 
	(Ped_AI_Skater_FlipTrick) 
	(Ped_AI_Skater_StartGrind) 
ENDSCRIPT

SCRIPT (Ped_AI_Skater_GrindHopTrickManual) 
	(Obj_Playsound) (GrindMetalOff) 
	(Ped_AI_Skater_FlipTrick) 
	(Ped_AI_Skater_Land) 
	(Ped_AI_Skater_StartManual) 
ENDSCRIPT

SCRIPT (Ped_AI_Skater_ManualHopTrickManual) 
	(Ped_AI_Skater_FlipTrick) 
	(Ped_AI_Skater_Land) 
	(Ped_AI_Skater_StartManual) 
ENDSCRIPT


