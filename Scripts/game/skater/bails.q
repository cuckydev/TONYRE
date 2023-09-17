
SCRIPT (DoingTrickBail) 
	IF (backwards) 
		(GotoRandomScript) [ (BackwardFaceSlam) (Shoulders) ] 
	ELSE 
		IF (SpeedLessThan) 550 
			IF (AirTimeLessThan) 1 (second) 
				(Goto) (Runout) 
			ENDIF 
		ENDIF 
		IF (LandedFromVert) 
			(GotoRandomScript) [ (OneFootBail) (Boardsplit) (NutSac) (FlailBail) (RollingBail) (Kneeslide) (Faceplant) (LandPartiallyOnBoard) (Facesmash) (NoseManualBail) (ManualBail) (Hipper) (Spasmodic) (TailslideOut) ] 
		ELSE 
			(GotoRandomScript) [ (Faceplant) (LandPartiallyOnBoard) (Facesmash) (NoseManualBail) (ManualBail) (Hipper) (Spasmodic) (TailslideOut) ] 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT (YawBail) 
	IF (YawingLeft) 
		IF (Flipped) 
			(GotoRandomScript) [ (Boardsplit) (NutSac) (FlailBail) (RollingBail) (Splits) (Rolling) (AnkleBust1) (AnkleBust2) (AnkleBust3) (Facesmash) (NoseManualBail) (Hipper) (Spasmodic) (Faceplant) ] 
		ELSE 
			(GotoRandomScript) [ (headsmack) (fallback) (Shoulders) ] 
		ENDIF 
	ELSE 
		IF (Flipped) 
			(GotoRandomScript) [ (headsmack) (fallback) (Shoulders) ] 
		ELSE 
			(GotoRandomScript) [ (OneFootBail) (Boardsplit) (NutSac) (FlailBail) (RollingBail) (Splits) (Rolling) (AnkleBust1) (AnkleBust2) (AnkleBust3) (Facesmash) (NoseManualBail) (Hipper) (Spasmodic) (Faceplant) (TailslideOut) ] 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT (PitchBail) 
	IF NOT (InSplitscreenGame) 
		IF (GetGlobalFlag) (Flag) = (TAP_BUTTONS_EXPLAINED) 
			IF NOT (GetGlobalFlag) (Flag) = (RECOVERY_BUTTONS_EXPLAINED) 
				(Create_Panel_Message) { (text) = "Tip: press \\ml in the air to level out" 
				(id) = (skater_hint) (style) = (skater_hint_style) (pos) = PAIR(320, 150) (rgba) = [ 32 75 102 100 ] } 
				(SetGlobalFlag) (Flag) = (RECOVERY_BUTTONS_EXPLAINED) 
			ENDIF 
		ENDIF 
	ENDIF 
	(GotoRandomScript) [ (HeadFirstSplat) (Neckbreaker) ] 
ENDSCRIPT

SCRIPT (FiftyFiftyFall) 
	(Goto) (leghook) 
	(GotoRandomScript) [ (Rolling) (FiftyFiftyFallForward) (FiftyFiftyFallBackward) (Hipper) (Spasmodic) (TailslideOut) (MissBackFoot) ] 
ENDSCRIPT

SCRIPT (Nutter) 
	IF (Ledge) 
		(Goto) (FiftyFiftyFall) 
	ELSE 
		(GotoRandomScript) [ (NutterForward) (NutterBackward) (MissBackFoot) (leghook) ] 
	ENDIF 
ENDSCRIPT

SCRIPT (BackwardsGrindBails) 
	(GotoRandomScript) [ (Shoulders) ] 
ENDSCRIPT

SCRIPT (MakeSkaterBail) 
	IF NOT (Skater) : (Driving) 
		IF NOT (Skater) : (Walking) 
			(MakeSkaterGoto) (Spasmodic) 
		ELSE 
			(MakeSkaterGoto) (WalkBailState) 
		ENDIF 
	ENDIF 
ENDSCRIPT

(BAILSCRIPT) = (Kneeslide) 
SCRIPT (headsmack) 
	(GeneralBail) { (Anim1) = (headsmack) (NoBlending) (Anim2) = (HeadGetup) (IntoAirFrame) = 1 (Friction) = 13 (SmackAnim) = (Smackwallupright) 
		(BoardOffFrame) = 10 (BoardVel) = VECTOR(0, 0, 0) (BoardRotVel) = VECTOR(0, 0, 0) (BoardSkaterVel) = 0 
		(Sound) = (bail_knee1) (FoleySound) 
	(GroundGoneBail) = (GroundGoneBail) (AnimFall1) = (HeadFirstFall) (AnimFall2) = (HeadFirstSplat) (AnimFall3) = (GetUpBackwards) } 
ENDSCRIPT

SCRIPT (OneFootBail) 
	(GeneralBail) { (Anim1) = (OneFootBail) (BoardOffFrame) = 150 (NoBailBoard) (Anim2) = (OneFootGetup) (IntoAirFrame) = 1 (Friction) = 14 (SmackAnim) = (SmackWallFeet) 
		(Sound) = (bail_knee1) (FoleySound) 
	(GroundGoneBail) = (GroundGoneBail) (AnimFall1) = (HeadFirstFall) (AnimFall2) = (HeadFirstSplat) (AnimFall3) = (GetUpBackwards) } 
ENDSCRIPT

SCRIPT (Kneeslide) 
	(GeneralBail) { (Anim1) = (Kneeslide) (Anim2) = (Kneeslide_resume) (IntoAirFrame) = 1 (Friction) = 24 (SmackAnim) = (SmackWallFeet) 
		(BoardOffFrame) = 0 (BoardVel) = VECTOR(-100, 0, 50) (BoardRotVel) = VECTOR(0, 2, 1) (BoardSkaterVel) = 1 
		(Sound) = (bail_knee1) (FoleySound) 
	(GroundGoneBail) = (GroundGoneBail) (AnimFall1) = (HeadFirstFall) (AnimFall2) = (HeadFirstSplat) (AnimFall3) = (GetUpBackwards) } 
ENDSCRIPT

SCRIPT (RollingBail) 
	(GeneralBail) { (Anim1) = (RollingBail) (Anim2) = (RollingGetup) (IntoAirFrame) = 1 (Friction) = 13 (SmackAnim) = (SmackWallFeet) 
		(BoardOffFrame) = 0 (BoardVel) = VECTOR(200, 100, -50) (BoardRotVel) = VECTOR(5, 2, 10) (BoardSkaterVel) = 1 
		(Sound) = (bail_knee1) (FoleySound) 
	(GroundGoneBail) = (GroundGoneBail) (AnimFall1) = (HeadFirstFall) (AnimFall2) = (HeadFirstSplat) (AnimFall3) = (GetUpBackwards) } 
ENDSCRIPT

SCRIPT (FlailBail) 
	(GeneralBail) { (Anim1) = (FlailBail) (Anim2) = (FlailGetup) (IntoAirFrame) = 1 (Friction) = 0 (SmackAnim) = (SmackWallFeet) 
		(BoardOffFrame) = 0 (BoardVel) = VECTOR(20, 50, -200) (BoardRotVel) = VECTOR(2, 6, 8) (BoardSkaterVel) = 1 
		(Sound) = (bail_knee1) (FoleySound) 
	(GroundGoneBail) = (GroundGoneBail) (AnimFall1) = (HeadFirstFall) (AnimFall2) = (HeadFirstSplat) (AnimFall3) = (GetUpBackwards) } 
ENDSCRIPT

SCRIPT (NutSac) 
	(GeneralBail) { (Anim1) = (NutSac) (Anim2) = RANDOM(1, 1) RANDOMCASE (NutsacGetup) RANDOMCASE (NutsacGetupQUick) RANDOMEND (IntoAirFrame) = 1 (Friction) = 25 (SmackAnim) = (SmackWallFeet) 
		(BoardOffFrame) = 50 (BoardVel) = VECTOR(0, 50, 0) (BoardRotVel) = VECTOR(0, 0, 0) (BoardSkaterVel) = 1 
		(Sound) = (bail_knee1) (FoleySound) 
	(GroundGoneBail) = (GroundGoneBail) (AnimFall1) = (HeadFirstFall) (AnimFall2) = (HeadFirstSplat) (AnimFall3) = (GetUpBackwards) } 
ENDSCRIPT

SCRIPT (Boardsplit) 
	(GeneralBail) { (Anim1) = (Boardsplit) (IntoAirFrame) = 1 (Friction) = 15 (SmackAnim) = (SmackWallFeet) 
		(BoardAlwaysOn) 
		(UnrotateBoardFirst) 
		(Sound) = (bail_knee1) (FoleySound) 
	(GroundGoneBail) = (GroundGoneBail) (AnimFall1) = (HeadFirstFall) (AnimFall2) = (HeadFirstSplat) (AnimFall3) = (GetUpBackwards) } 
ENDSCRIPT

SCRIPT (Faceplant) 
	(GeneralBail) { (Anim1) = (Faceplant) (Anim2) = (Kneeslide_resume) (IntoAirFrame) = 1 (Bloodframe) = 14 (SmackAnim) = (SmackWallFeet) 
		(BoardOffFrame) = 0 (BoardVel) = VECTOR(0, 100, -300) (BoardRotVel) = VECTOR(0, 5, 0) (BoardSkaterVel) = 1 
		(Sound) = (bail_knee1) (FoleySound) 
	(GroundGoneBail) = (GroundGoneBail) (AnimFall1) = (HeadFirstFall) (AnimFall2) = (HeadFirstSplat) (AnimFall3) = (GetUpBackwards) } 
ENDSCRIPT

SCRIPT (MissBackFoot) 
	(GeneralBail) { (Anim1) = (NSMissBackFoot) (Anim2) = (NSMissBackFoot_Resume) (IntoAirFrame) = 1 (SmackAnim) = (SmackWallFeet) 
		(BoardOffFrame) = 24 (BoardVel) = VECTOR(0, 0, -100) (BoardRotVel) = VECTOR(3, 2, 1) (BoardSkaterVel) = 1 
		(Sound) = (bail_knee1) (FoleySound) 
	(GroundGoneBail) = (GroundGoneBail) (AnimFall1) = (HeadFirstFall) (AnimFall2) = (HeadFirstSplat) (AnimFall3) = (GetUpBackwards) } 
ENDSCRIPT

SCRIPT (AnkleBust1) 
	(GeneralBail) { (Anim1) = (NewAnkleBust) (Anim2) = (RailBailGetup) (IntoAirFrame) = 1 (Friction) = 15 (SmackAnim) = (SmackWallFeet) 
		(BoardOffFrame) = 1 (BoardVel) = VECTOR(-100, 50, -100) (BoardRotVel) = VECTOR(5, 5, 10) (BoardSkaterVel) = 1 
		(Sound) = (bail_knee1) (FoleySound) 
	(GroundGoneBail) = (GroundGoneBail) (AnimFall1) = (HeadFirstFall) (AnimFall2) = (HeadFirstSplat) (AnimFall3) = (GetUpBackwards) } 
ENDSCRIPT

SCRIPT (AnkleBust2) 
	(GeneralBail) { (Anim1) = (AnkleBust2) (Anim2) = (GetUpTailslideOut) (IntoAirFrame) = 1 (Friction) = 17 (SmackAnim) = (SmackWallFeet) 
		(BoardOffFrame) = 1 (BoardVel) = VECTOR(300, 200, -100) (BoardRotVel) = VECTOR(5, 5, 9) (BoardSkaterVel) = 1 
		(Sound) = (bail_knee1) (FoleySound) 
	(GroundGoneBail) = (GroundGoneBail) (AnimFall1) = (HeadFirstFall) (AnimFall2) = (HeadFirstSplat) (AnimFall3) = (GetUpBackwards) } 
ENDSCRIPT

SCRIPT (AnkleBust3) 
	(GeneralBail) { (Anim1) = (AnkleBust3) (Anim2) = (GetUpAnkleBust) (IntoAirFrame) = 1 (Friction) = 17 (SmackAnim) = (SmackWallFeet) 
		(BoardOffFrame) = 40 (BoardVel) = VECTOR(0, 60, 0) (BoardRotVel) = VECTOR(0, 0, 0) (BoardSkaterVel) = 1 
		(Sound) = (bail_knee1) (FoleySound) 
	(GroundGoneBail) = (GroundGoneBail) (AnimFall1) = (HeadFirstFall) (AnimFall2) = (HeadFirstSplat) (AnimFall3) = (GetUpBackwards) } 
ENDSCRIPT

SCRIPT (Splits) 
	(GeneralBail) { (Anim1) = (Splits) (Anim2) = (Kneeslide_resume) (IntoAirFrame) = 1 (Friction) = 24 (SmackAnim) = (SmackWallFeet) 
		(BoardOffFrame) = 1 (BoardVel) = VECTOR(-30, 20, 50) (BoardRotVel) = VECTOR(3, -1, 0) (BoardSkaterVel) = 1 
		(Sound) = (bail_knee1) (FoleySound) 
	(GroundGoneBail) = (GroundGoneBail) (AnimFall1) = (HeadFirstFall) (AnimFall2) = (HeadFirstSplat) (AnimFall3) = (GetUpBackwards) } 
ENDSCRIPT

SCRIPT (Rolling) 
	(GeneralBail) { (Anim1) = (Rolling) (IntoAirFrame) = 1 (Friction) = 15 (SmackAnim) = (SmackWallFeet) 
		(BoardOffFrame) = 1 (BoardVel) = VECTOR(-300, 150, -100) (BoardRotVel) = VECTOR(10, 2, -2) (BoardSkaterVel) = 1 
		(Sound) = (bail_knee1) (FoleySound) (NoBlending) (BoardEarlyOn) 
	(GroundGoneBail) = (GroundGoneBail) (AnimFall1) = (HeadFirstFall) (AnimFall2) = (HeadFirstSplat) (AnimFall3) = (GetUpBackwards) } 
ENDSCRIPT

SCRIPT (Shoulders) 
	(GeneralBail) { (Anim1) = (Shoulders) (NoBlending) (Anim2) = (GetUpForwards) (IntoAirFrame) = 20 (Friction) = 15 (SmackAnim) = (Smackwallupright) 
		(BoardOffFrame) = 1 (BoardVel) = VECTOR(-100, 50, -250) (BoardRotVel) = VECTOR(10, 2, -2) (BoardSkaterVel) = 1 
		(Sound) = (BoardBail01) (FoleySound) (Bloodframe) = 20 
	(GroundGoneBail) = (GroundGoneBail) (AnimFall1) = (HeadFirstFall) (AnimFall2) = (HeadFirstSplat) (AnimFall3) = (GetUpBackwards) } 
ENDSCRIPT

SCRIPT (Hipper) 
	(GeneralBail) { (Anim1) = (Hips) (Anim2) = (GetUpHips) (Friction) = 11 (SmackAnim) = (SmackWallFeet) 
		(IntoAirFrame) = 20 
		(BoardOffFrame) = 1 (BoardVel) = VECTOR(300, 250, -150) (BoardRotVel) = VECTOR(10, -3, 3) (BoardSkaterVel) = 1 
		(Sound) = (Bail04) (NoBlending) (FoleySound) (NoBlending) (Friction2) = 17 
	(GroundGoneBail) = (GroundGoneBail) (AnimFall1) = (HeadFirstFall) (AnimFall2) = (HeadFirstSplat) (AnimFall3) = (GetUpBackwards) } 
ENDSCRIPT

SCRIPT (Spasmodic) 
	(GeneralBail) { (Anim1) = (Spasmodic) (Anim2) = (GetUpSpasmodic) (IntoAirFrame) = 20 (Friction) = 14 (SmackAnim) = (SmackWallFeet) 
		(BoardOffFrame) = 1 (BoardVel) = VECTOR(20, 70, -200) (BoardRotVel) = VECTOR(2, 5, 1) (BoardSkaterVel) = 0 
		(Sound) = (Bail04) (FoleySound) (NoBlending) (Friction2) = 14 (Bloodframe) = 48 
	(GroundGoneBail) = (GroundGoneBail) (AnimFall1) = (HeadFirstFall) (AnimFall2) = (HeadFirstSplat) (AnimFall3) = (GetUpBackwards) } 
ENDSCRIPT

SCRIPT (TailslideOut) 
	(GeneralBail) { (Anim1) = (TailslideOut) (Anim2) = (GetUpTailslideOut) (Bloodframe) = 40 (SmackAnim) = (SmackWall) (Sound) = (Bail04) 
		(IntoAirFrame) = 30 
		(BoardOffFrame) = 1 (BoardVel) = VECTOR(-120, 150, 200) (BoardRotVel) = VECTOR(5, 0, 5) (BoardSkaterVel) = 0 
		(FoleySound) (BonkSound) 
	(GroundGoneBail) = (GroundGoneBail) (AnimFall1) = (HeadFirstFall) (AnimFall2) = (HeadFirstSplat) (AnimFall3) = (GetUpBackwards) } 
ENDSCRIPT

SCRIPT (HeadFirstSplat) 
	(GeneralBail) { (Anim1) = (HeadFirstSplat) (BoardOffFrame) = 60 (Anim2) = (GetUpBackwards) (IntoAirFrame) = 1 (Friction) = 15 (SmackAnim) = (SmackWallFeet) 
		(Sound) = (Bail04) (FoleySound) (NoBlending) 
		(BoardOffFrame) = 1 (BoardVel) = VECTOR(25, 50, 0) (BoardRotVel) = VECTOR(0.5, 3, 2) (BoardSkaterVel) = 0 
	(GroundGoneBail) = (GroundGoneBail) (AnimFall1) = (HeadFirstFall) (AnimFall2) = (HeadFirstSplat) (AnimFall3) = (GetUpBackwards) } 
ENDSCRIPT

SCRIPT (Neckbreaker) 
	(GeneralBail) { (Anim1) = (Neckbreaker) (Anim2) = (GetUpFacing) (IntoAirFrame) = 1 (Friction) = 15 (SmackAnim) = (SmackWallFeet) 
		(Sound) = (Bail04) (FoleySound) (NoBlending) 
		(BoardOffFrame) = 1 (BoardVel) = VECTOR(25, 150, 0) (BoardRotVel) = VECTOR(0.5, 3, 2) (BoardSkaterVel) = 0 
	(GroundGoneBail) = (GroundGoneBail) (AnimFall1) = (HeadFirstFall) (AnimFall2) = (HeadFirstSplat) (AnimFall3) = (GetUpBackwards) } 
ENDSCRIPT

SCRIPT (NoseManualBail2) 
	(GeneralBail) { (Anim1) = (SlipForwards) (Anim2) = (GetUpForwards) (IntoAirFrame) = 20 (Friction) = 15 (SmackAnim) = (Smackwallupright) 
		(BoardOffFrame) = 1 (BoardVel) = VECTOR(-60, 150, 100) (BoardRotVel) = VECTOR(10, 1, -2) (BoardSkaterVel) = 0 
		(Sound) = (BoardBail01) (FoleySound) (Bloodframe) = 20 
	(GroundGoneBail) = (GroundGoneBail) (AnimFall1) = (HeadFirstFall) (AnimFall2) = (HeadFirstSplat) (AnimFall3) = (GetUpBackwards) } 
ENDSCRIPT

SCRIPT (LandPartiallyOnBoard) 
	(GeneralBail) { (Anim1) = (LandPartiallyOnBoard) (Anim2) = (GetUpForwards) (IntoAirFrame) = 1 (Friction) = 15 (SmackAnim) = (SmackWallFeet) 
		(BoardOffFrame) = 1 (BoardVel) = VECTOR(-50, 50, 150) (BoardRotVel) = VECTOR(-10, 0, 0) (BoardSkaterVel) = 1 
		(Sound) = (bail_knee1) (FoleySound) 
	(GroundGoneBail) = (GroundGoneBail) (AnimFall1) = (HeadFirstFall) (AnimFall2) = (HeadFirstSplat) (AnimFall3) = (GetUpBackwards) } 
ENDSCRIPT

SCRIPT (Runout) 
	IF (SpeedLessThan) 400 
		(GeneralBail) { (Anim1) = (RunOutQuick) (IntoAirFrame) = 1 (Friction) = 11 (BoardAlwaysOn) (BashOff) (NoBlood) 
			(BoardAlwaysOn) 
			(Sound) = (Bailrunoutflip) (NoScuff) 
		(GroundGoneBail) = (GroundGoneBail) (AnimFall1) = (RunOutDropIdle) (AnimFall2) = (RunOutDrop) } 
	ELSE 
		(GeneralBail) { (Anim1) = (Runout) (IntoAirFrame) = 1 (SmackAnim) = (Smackwallupright) (Friction) = 13 (BoardAlwaysOn) (BashOff) (NoBlood) 
			(BoardAlwaysOn) 
			(Sound) = (Bailrunoutflip) (NoScuff) 
		(GroundGoneBail) = (GroundGoneBail) (AnimFall1) = (RunOutDropIdle) (AnimFall2) = (RunOutDrop) } 
	ENDIF 
ENDSCRIPT

SCRIPT (BackwardFaceSlam) 
	(Flip) 
	(GeneralBail) { (Anim1) = (BackwardFaceSlam) (Anim2) = (GetUpFacing) (IntoAirFrame) = 50 (Bloodframe) = 25 (SmackAnim) = (SmackWallFeet) 
		(BoardOffFrame) = 1 (BoardVel) = VECTOR(0, 150, 0) (BoardRotVel) = VECTOR(0, 0, 1) (BoardSkaterVel) = 1 
		(Sound) = (bail_backward1) (FoleySound) 
	(GroundGoneBail) = (GroundGoneBail) (AnimFall1) = (FeetFirstFallFront) (AnimFall2) = (HeadFirstSplat) (AnimFall3) = (GetUpBackwards) } 
ENDSCRIPT

SCRIPT (BackwardsFall) 
	(GeneralBail) { (Anim1) = (BackwardsTest) (Anim2) = (GetUpBackwards) (IntoAirFrame) = 62 (Bloodframe) = 50 (SmackAnim) = (SmackWallFeet) 
		(BoardOffFrame) = 1 (BoardVel) = VECTOR(0, 150, 0) (BoardRotVel) = VECTOR(0, 3, 1) (BoardSkaterVel) = 0.50000000000 
		(Sound) = (boardbail02) (HitBody) (FoleySound) 
	(GroundGoneBail) = (GroundGoneBail) (AnimFall1) = (FeetFirstFallFront) (AnimFall2) = (HeadFirstSplat) (AnimFall3) = (GetUpBackwards) } 
ENDSCRIPT

SCRIPT (fallback) 
	(GeneralBail) { (Anim1) = (fallback) (NoBlending) (Anim2) = (Fallback_resume) (IntoAirFrame) = 20 (Bloodframe) = 35 
		(BoardOffFrame) = 1 (BoardVel) = VECTOR(0.00000000000, 250.00000000000, 0.00000000000) (BoardRotVel) = VECTOR(0.00000000000, 2.00000000000, 5.00000000000) (BoardSkaterVel) = 0 
		(Sound) = (Bail04) (FoleySound) 
	(GroundGoneBail) = (GroundGoneBail) (AnimFall1) = (fallback) (AnimFall2) = (BigDrop) (AnimFall3) = (GetUpFacing) } 
ENDSCRIPT

SCRIPT (leghook) 
	(GeneralBail) { (Anim1) = (Railbail) (Anim2) = (GetUpFacing) (IntoAirFrame) = 27 (ForceFall) (Friction) = 0 (Bloodframe) = 50 (SmackAnim) = (SmackWall) (Sound) = (Bail04) 
		(BoardOffFrame) = 1 (BoardVel) = VECTOR(-50.00000000000, 20.00000000000, 0.00000000000) (BoardRotVel) = VECTOR(0.00000000000, 1.00000000000, -1.00000000000) (BoardSkaterVel) = 1 
		(FoleySound) (FallBlendPeriod) = 0 (SplatFriction) = 20 
	(GroundGoneBail) = (GroundGoneBail) (AnimFall1) = (RailBailFall) (AnimFall2) = (RailBailHitGround) (Friction) = 0 (AnimFall3) = (RailBailGetup) } 
ENDSCRIPT

SCRIPT (FiftyFiftyFallForward) 
	(GeneralBail) { (Anim1) = (FiftyFiftyFallForward) (Anim2) = (GetUpFacing) (IntoAirFrame) = 40 (Bloodframe) = 50 (SmackAnim) = (SmackWall) (Sound) = (Bail04) 
		(BoardOffFrame) = 1 (BoardVel) = VECTOR(0.00000000000, 0.00000000000, 0.00000000000) (BoardRotVel) = VECTOR(0.00000000000, 1.00000000000, -1.00000000000) (BoardSkaterVel) = 1 
		(FoleySound) 
	(GroundGoneBail) = (GroundGoneBail) (AnimFall1) = (HeadFirstFall) (AnimFall2) = (HeadFirstSplat) (AnimFall3) = (GetUpBackwards) } 
ENDSCRIPT

SCRIPT (FiftyFiftyFallBackward) 
	(GeneralBail) { (Anim1) = (FiftyFiftyFallBackward) (Anim2) = (GetUpForwards) (IntoAirFrame) = 50 (Bloodframe) = 50 (SmackAnim) = (SmackWallFeet) (Sound) = (Bail04) 
		(BoardOffFrame) = 1 (BoardVel) = VECTOR(0.00000000000, 0.00000000000, 0.00000000000) (BoardRotVel) = VECTOR(0.00000000000, -1.00000000000, 1.00000000000) (BoardSkaterVel) = 1 
		(FoleySound) 
	(GroundGoneBail) = (GroundGoneBail) (AnimFall1) = (FeetFirstFallFront) (AnimFall2) = (HeadFirstSplat) (AnimFall3) = (GetUpBackwards) } 
ENDSCRIPT

SCRIPT (NutterForward) 
	(GeneralBail) { (Anim1) = (NutterFallForward) (Anim2) = (GetUpForwards) (IntoAirFrame) = 30 (Bloodframe) = 50 (SmackAnim) = (SmackWall) (Sound) = (Bail04) 
		(BoardOffFrame) = 1 (BoardVel) = VECTOR(20.00000000000, 0.00000000000, 0.00000000000) (BoardRotVel) = VECTOR(0.00000000000, 1.00000000000, 1.00000000000) (BoardSkaterVel) = 1 
		(FoleySound) (BonkSound) 
	(GroundGoneBail) = (GroundGoneBail) (AnimFall1) = (HeadFirstFall) (AnimFall2) = (HeadFirstSplat) (AnimFall3) = (GetUpBackwards) } 
ENDSCRIPT

SCRIPT (NutterBackward) 
	(GeneralBail) { (Anim1) = (NutterFallBackward) (Anim2) = (FaceSmash_resume) (IntoAirFrame) = 30 (SmackAnim) = (SmackWallFeet) (Sound) = (Bail04) 
		(BoardOffFrame) = 1 (BoardVel) = VECTOR(-20.00000000000, 0.00000000000, 0.00000000000) (BoardRotVel) = VECTOR(1.00000000000, 3.00000000000, 1.00000000000) (BoardSkaterVel) = 0 
		(FoleySound) (BonkSound) 
	(GroundGoneBail) = (GroundGoneBail) (AnimFall1) = (HeadFirstFall) (AnimFall2) = (HeadFirstSplat) (AnimFall3) = (GetUpBackwards) } 
ENDSCRIPT

SCRIPT (ManualBail) 
	(GeneralBail) { (Anim1) = (ManualBack) (Anim2) = (ManualGetup) (IntoAirFrame) = 30 (Friction) = 15 (SmackAnim) = (SmackWallFeet) (Sound) = (Bail04) 
		(BoardOffFrame) = 10 (BoardVel) = VECTOR(0.00000000000, 50.00000000000, 400.00000000000) (BoardRotVel) = VECTOR(0.00000000000, 0.00000000000, 0.00000000000) (BoardSkaterVel) = 1 
	(GroundGoneBail) = (GroundGoneBail) (AnimFall1) = (HeadFirstFallBack) (AnimFall2) = (BigDrop) (AnimFall3) = (GetUpFacing) } 
ENDSCRIPT

SCRIPT (NoseManualBail) 
	(GeneralBail) { (Anim1) = (manualforwards) (Anim2) = (Manual_FGetup) (IntoAirFrame) = 30 (Friction) = 10 (SmackAnim) = (Smackwallupright) (Sound) = (BoardBail01) 
		(BoardOffFrame) = 10 (BoardVel) = VECTOR(0.00000000000, 50.00000000000, -400.00000000000) (BoardRotVel) = VECTOR(0.00000000000, 0.00000000000, 0.00000000000) (BoardSkaterVel) = 0 
	(GroundGoneBail) = (GroundGoneBail) (AnimFall1) = (HeadFirstFall) (AnimFall2) = (HeadFirstSplat) (AnimFall3) = (GetUpBackwards) } 
ENDSCRIPT

SCRIPT (Facesmash) 
	(GeneralBail) { (Anim1) = (FaceFall) (Anim2) = (GetUpFacesmash) (SpeedBasedAnim1) = (FaceFallSmallHit) (SpeedBasedAnim2) = (FaceFallBigHit) (Speed) = 300 (IntoAirFrame) = 30 (Friction) = 5 (Friction2) = 5 (SmackAnim) = (Smackwallupright) (Sound) = (bodysmackA) 
		(BoardOffFrame) = 1 (BoardVel) = VECTOR(0.00000000000, 0.00000000000, 0.00000000000) (BoardRotVel) = VECTOR(0.00000000000, 0.00000000000, 0.00000000000) (BoardSkaterVel) = 1 
	(GroundGoneBail) = (GroundGoneBail) (AnimFall1) = (HeadFirstFall) (AnimFall2) = (HeadFirstSplat) (AnimFall3) = (GetUpBackwards) } 
ENDSCRIPT

SCRIPT (GeneralBail) (Friction) = 18 (Friction2) = 20 (HeavyFriction) = 100 
	(Obj_SetBoundingSphere) 100 
	IF (GotParam) (UnrotateBoardFirst) 
		IF (BoardIsRotated) 
			(BoardRotate) 
		ENDIF 
	ENDIF 
	IF (GotParam) (NoBailBoard) 
		(NoBailBoard) = 1 
	ENDIF 
	(NollieOff) 
	(PressureOff) 
	(KillSpecial) 
	(created_trick_cleanup) 
	(SpawnClothingLandScript) 
	IF NOT (GotParam) (NoScuff) 
		(PlaySkaterStream) (type) = "bail" 
	ENDIF 
	(SetSkaterCamLerpReductionTimer) (time) = 0 
	(InBail) 
	(LaunchStateChangeEvent) (State) = (Skater_InBail) 
	(SetExtraPush) (radius) = 48 (Speed) = 100 (rotate) = 6 
	(TurnToFaceVelocity) 
	IF NOT (GotParam) (BoardAlwaysOn) 
		(Obj_Spawnscript) (BailBoardControl) (Params) = { (BoardOffFrame) = <BoardOffFrame> (BoardVel) = <BoardVel> (BoardRotVel) = <BoardRotVel> (BoardSkaterVel) = <BoardSkaterVel> (NoBailBoard) = <NoBailBoard> } 
	ENDIF 
	(SparksOff) 
	(VibrateOff) 
	(ClearExceptions) 
	(DisablePlayerInput) (AllowCameraControl) 
	(BailSkaterTricks) 
	(StopBalanceTrick) 
	(SetException) (Ex) = (CarBail) (Scr) = (CarBail) 
	IF (GotParam) (GroundGoneBail) 
		(SetException) (Ex) = (GroundGone) (Scr) = <GroundGoneBail> (Params) = { <...> } 
	ENDIF 
	IF (GotParam) (SmackAnim) 
		(SetException) (Ex) = (FlailHitWall) (Scr) = (BailSmack) (Params) = { (SmackAnim) = <SmackAnim> } 
		(SetException) (Ex) = (FlailLeft) (Scr) = (BailSmack) (Params) = { (SmackAnim) = <SmackAnim> } 
		(SetException) (Ex) = (FlailRight) (Scr) = (BailSmack) (Params) = { (SmackAnim) = <SmackAnim> } 
	ENDIF 
	IF (InSlapGame) 
		(SetException) (Ex) = (SkaterCollideBail) (Scr) = (SkaterCollideBail) 
	ELSE 
		IF (GameModeEquals) (is_firefight) 
			(SetEventHandler) (Ex) = (SkaterCollideBail) (Scr) = (Bail_FireFight_SkaterCollideBail) 
		ENDIF 
	ENDIF 
	IF (GotParam) (Sound) 
	ELSE 
		(PlayBonkSound) 
	ENDIF 
	IF (GotParam) (NoBlending) 
		(PlayAnim) (Anim) = <Anim1> (NoRestart) (Blendperiod) = 0.00000000000 
	ELSE 
		(PlayAnim) (Anim) = <Anim1> (NoRestart) (Blendperiod) = 0.30000001192 
	ENDIF 
	IF (GotParam) (BashOff) 
	ELSE 
		(BashOn) 
	ENDIF 
	IF NOT (InSplitscreenGame) 
		IF NOT (GetGlobalFlag) (Flag) = (TAP_BUTTONS_EXPLAINED) 
			(Create_Panel_Message) { (text) = "Tip: tap buttons to get up faster" 
			(id) = (skater_hint) (style) = (skater_hint_style) (pos) = PAIR(320.00000000000, 150.00000000000) (rgba) = [ 32 75 102 100 ] } 
			(SetGlobalFlag) (Flag) = (TAP_BUTTONS_EXPLAINED) 
		ENDIF 
	ENDIF 
	IF (OnRail) 
		(WaitAnim) (frame) <IntoAirFrame> 
		(SetState) (Air) 
		(move) (y) = 2.00000000000 
		(Obj_Spawnscript) (FallOffRail) (Params) = { (xmove) = <xmove> (moveframes) = <moveframes> } 
		(Vibrate) (Actuator) = 1 (Percent) = 100 (Duration) = 0.20000000298 
		(rotate) (y) = RANDOM_RANGE PAIR(1.00000000000, 20.00000000000) 
		IF (GotParam) (BonkSound) 
			(PlayBonkSound) 
		ENDIF 
		IF (GotParam) (ForceFall) 
			(Goto) (GroundGoneBail) (Params) = { <...> } 
		ENDIF 
	ENDIF 
	(WaitOnGround) 
	IF NOT (GotParam) (NoScuff) 
		IF NOT (GetGlobalFlag) (Flag) = (BLOOD_OFF) 
			(Scuff_skater) 
		ENDIF 
	ENDIF 
	IF NOT (GetGlobalFlag) (Flag) = (BLOOD_OFF) 
		IF (GotParam) (Bloodframe) 
			(WaitAnim) (frame) <Bloodframe> 
			(Obj_Spawnscript) (BloodSmall) 
			(Playsound) RANDOM(1, 1, 1) RANDOMCASE (hitblood01) RANDOMCASE (hitblood02) RANDOMCASE (hitblood03) RANDOMEND 
		ENDIF 
	ENDIF 
	(Vibrate) (Actuator) = 1 (Percent) = 100 (Duration) = 0.20000000298 
	(SetRollingFriction) <HeavyFriction> 
	IF (GotParam) (HitBody) 
		(Spawnscript) (HitBody) (Params) = { <...> } 
	ENDIF 
	(Wait) 3 (frames) 
	(SetRollingFriction) <Friction> 
	(WaitAnim) 30 (Percent) 
	(SpeedCheckStop) 
	(SetRollingFriction) <Friction2> 
	(WaitAnim) 50 (Percent) 
	(SpeedCheckStop) 
	(BashOn) 
	IF (GotParam) (BoardEarlyOn) 
		(BoardRotate) (normal) 
		(SwitchOnBoard) 
	ENDIF 
	(WaitAnim) 75 (Percent) 
	(SpeedCheckStop) 
	IF (GotParam) (FoleySound) 
	ENDIF 
	(WaitAnimFinished) 
	IF (GotParam) (SpeedBasedAnim1) 
		IF (SpeedGreaterThan) <Speed> 
			(PlayAnim) (Anim) = <SpeedBasedAnim2> 
		ELSE 
			(PlayAnim) (Anim) = <SpeedBasedAnim1> 
		ENDIF 
		(Vibrate) (Actuator) = 1 (Percent) = 100 (Duration) = 0.20000000298 
		(Obj_Spawnscript) (BloodSmall) 
		(SetRollingFriction) 20 
		(WaitAnimFinished) 
	ENDIF 
	(SpeedCheckStop) 
	IF (GotParam) (Anim2) 
		(PlayAnim) (Anim) = <Anim2> (Blendperiod) = 0.00000000000 
	ENDIF 
	(SetRollingFriction) 20 
	(SpeedCheckStop) 
	(VibrateOff) 
	(WaitAnim) 20 (frames) (fromend) 
	(SwitchOnBoard) 
	IF (GotParam) (BoardAlwaysOn) 
	ELSE 
		(BoardRotate) (normal) 
	ENDIF 
	(WaitAnimFinished) 
	(Goto) (Baildone) 
ENDSCRIPT

SCRIPT (FallOffRail) (xmove) = 5 (moveframes) = 0 
	(movetime) = ( <moveframes> * 1.00000000000 ) 
	IF ( <moveframes> > 0 ) 
		(slicedmove) = ( <xmove> / <movetime> ) 
		IF NOT (Flipped) 
			(slicedmove) = ( <slicedmove> * -1.00000000000 ) 
		ENDIF 
		BEGIN 
			(move) (x) = <slicedmove> 
			(Wait) 1 (frame) 
		REPEAT <moveframes> 
	ELSE 
		(move) (x) = <xmove> 
	ENDIF 
ENDSCRIPT

SCRIPT (Scuff_skater) 
	<scuffspot> = RANDOM_RANGE PAIR(0.00000000000, 4.00000000000) 
	IF ( <scuffspot> > 3 ) 
	ELSE 
		IF ( <scuffspot> = 3 ) 
			(Scuff_DoReplacement) (src) = "CS_NH_scar_armR.png" (scuffspot) = <scuffspot> 
		ELSE 
			IF ( <scuffspot> = 2 ) 
				(Scuff_DoReplacement) (src) = "CS_NH_scar_armL.png" (scuffspot) = <scuffspot> 
			ELSE 
				IF ( <scuffspot> = 1 ) 
					(Scuff_DoReplacement) (src) = "CS_NH_scar_legR.png" (src2) = "CS_NH_scuff_legR.png" (scuffspot) = <scuffspot> 
				ELSE 
					(Scuff_DoReplacement) (src) = "CS_NH_scar_legL.png" (src2) = "CS_NH_scuff_legL.png" (scuffspot) = <scuffspot> 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT (Scuff_DoReplacement) (leftknee) = 0 (rightknee) = 0 (rightelbow) = 0 (leftelbow) = 0 
	(GetTags) 
	SWITCH <scuffspot> 
		CASE 0 
			(leftknee) = ( <leftknee> + 1 ) 
			(bailcount) = <leftknee> 
		CASE 1 
			(rightknee) = ( <rightknee> + 1 ) 
			(bailcount) = <rightknee> 
		CASE 2 
			(leftelbow) = ( <leftelbow> + 1 ) 
			(bailcount) = <leftelbow> 
		CASE 3 
			(rightelbow) = ( <rightelbow> + 1 ) 
			(bailcount) = <rightelbow> 
	ENDSWITCH 
	(SetTags) (leftknee) = <leftknee> (rightknee) = <rightknee> (leftelbow) = <leftelbow> (rightelbow) = <rightelbow> 
	IF (GetGlobalFlag) (Flag) = (CHEAT_SUPER_BLOOD) 
		(bailcount) = ( <bailcount> + 5 ) 
	ENDIF 
	IF (GotParam) (src2) 
		IF ( <bailcount> > 9 ) 
			(Obj_ReplaceTexture) (src) = <src> (dest) = "textures/scuffs/CS_NH_scar_06" 
		ELSE 
			IF ( <bailcount> > 7 ) 
				(Obj_ReplaceTexture) (src) = <src> (dest) = "textures/scuffs/CS_NH_scar_05" 
			ELSE 
				IF ( <bailcount> > 6 ) 
					(Obj_ReplaceTexture) (src) = <src> (dest) = "textures/scuffs/CS_NH_scar_04" 
					(Obj_ReplaceTexture) (src) = <src2> (dest) = "textures/scuffs/CS_NH_scuff_05" 
				ELSE 
					IF ( <bailcount> > 5 ) 
						(Obj_ReplaceTexture) (src) = <src> (dest) = "textures/scuffs/CS_NH_scar_03" 
					ELSE 
						IF ( <bailcount> > 4 ) 
							(Obj_ReplaceTexture) (src) = <src2> (dest) = "textures/scuffs/CS_NH_scar_02" 
						ELSE 
							IF ( <bailcount> > 3 ) 
								(Obj_ReplaceTexture) (src) = <src2> (dest) = "textures/scuffs/CS_NH_scuff_04" 
								(Obj_ReplaceTexture) (src) = <src> (dest) = "textures/scuffs/CS_NH_scar_01" 
							ELSE 
								IF ( <bailcount> > 2 ) 
									(Obj_ReplaceTexture) (src) = <src2> (dest) = "textures/scuffs/CS_NH_scuff_03" 
								ELSE 
									IF ( <bailcount> > 1 ) 
										(Obj_ReplaceTexture) (src) = <src2> (dest) = "textures/scuffs/CS_NH_scuff_02" 
									ELSE 
										(Obj_ReplaceTexture) (src) = <src2> (dest) = "textures/scuffs/CS_NH_scuff_01" 
									ENDIF 
								ENDIF 
							ENDIF 
						ENDIF 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
	ELSE 
		IF ( <bailcount> > 9 ) 
			(Obj_ReplaceTexture) (src) = <src> (dest) = "textures/scuffs/CS_NH_scar_06" 
		ELSE 
			IF ( <bailcount> > 7 ) 
				(Obj_ReplaceTexture) (src) = <src> (dest) = "textures/scuffs/CS_NH_scar_05" 
			ELSE 
				IF ( <bailcount> > 5 ) 
					(Obj_ReplaceTexture) (src) = <src> (dest) = "textures/scuffs/CS_NH_scar_04" 
				ELSE 
					IF ( <bailcount> > 3 ) 
						(Obj_ReplaceTexture) (src) = <src> (dest) = "textures/scuffs/CS_NH_scar_03" 
					ELSE 
						IF ( <bailcount> > 1 ) 
							(Obj_ReplaceTexture) (src) = <src> (dest) = "textures/scuffs/CS_NH_scar_02" 
						ELSE 
							(Obj_ReplaceTexture) (src) = <src> (dest) = "textures/scuffs/CS_NH_scar_01" 
						ENDIF 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT (CleanUp_Scuffs) 
	(Obj_ReplaceTexture) (src) = "CS_NH_scar_armR.png" (dest) = "textures/scuffs/CS_NH_scar_armR" 
	(Obj_ReplaceTexture) (src) = "CS_NH_scar_armL.png" (dest) = "textures/scuffs/CS_NH_scar_armL" 
	(Obj_ReplaceTexture) (src) = "CS_NH_scar_legR.png" (dest) = "textures/scuffs/CS_NH_scar_legR" 
	(Obj_ReplaceTexture) (src) = "CS_NH_scar_legL.png" (dest) = "textures/scuffs/CS_NH_scar_legL" 
	(Obj_ReplaceTexture) (src) = "CS_NH_scuff_legR.png" (dest) = "textures/scuffs/CS_NH_scuff_legR" 
	(Obj_ReplaceTexture) (src) = "CS_NH_scuff_legL.png" (dest) = "textures/scuffs/CS_NH_scuff_legL" 
	(Obj_ReplaceTexture) (src) = "CS_NN_board_trans01.png" (dest) = "textures/scuffs/CS_NN_board_trans01" 
	(SetTags) (leftknee) = 0 (rightknee) = 0 (rightelbow) = 0 (leftelbow) = 0 
ENDSCRIPT

SCRIPT (CleanUp_Deck) 
	(Obj_ReplaceTexture) (src) = "CS_NN_board_trans01.png" (dest) = "textures/scuffs/CS_NN_board_trans01" 
	(SetTags) (Boardscuff) = 0 
ENDSCRIPT

SCRIPT (DoBoardScuff) 
	SWITCH <Boardscuff> 
		CASE 10 
			(Obj_ReplaceTexture) (src) = "CS_NN_board_trans01.png" (dest) = "textures/scuffs/CS_NN_boardscuff_01" 
		CASE 20 
			(Obj_ReplaceTexture) (src) = "CS_NN_board_trans01.png" (dest) = "textures/scuffs/CS_NN_boardscuff_02" 
		CASE 30 
			(Obj_ReplaceTexture) (src) = "CS_NN_board_trans01.png" (dest) = "textures/scuffs/CS_NN_boardscuff_03" 
		CASE 40 
			(Obj_ReplaceTexture) (src) = "CS_NN_board_trans01.png" (dest) = "textures/scuffs/CS_NN_boardscuff_04" 
		DEFAULT 
	ENDSWITCH 
ENDSCRIPT

SCRIPT (BailBoardControl) (BoardOffFrame) = 5 
	(Wait) <BoardOffFrame> (frames) 
	(SwitchOffBoard) 
	IF NOT (GotParam) (NoBailBoard) 
		(CreateBailBoard) (vel) = <BoardVel> (rotvel) = <BoardRotVel> (object_vel_factor) = <BoardSkaterVel> 
	ENDIF 
ENDSCRIPT

SCRIPT (SpeedCheckStop) 
	IF (SpeedLessThan) 300 
		(SetRollingFriction) 100 
	ENDIF 
ENDSCRIPT

SCRIPT (HitBody) (hitbodyframe) = 15 
	(Wait) <hitbodyframe> (frames) 
ENDSCRIPT

SCRIPT (BailSmack) (SmackAnim) = (SmackWall) 
	IF (InSlapGame) 
		(SetException) (Ex) = (SkaterCollideBail) (Scr) = (SkaterCollideBail) 
	ELSE 
		IF (GameModeEquals) (is_firefight) 
			(SetEventHandler) (Ex) = (SkaterCollideBail) (Scr) = (Bail_FireFight_SkaterCollideBail) 
		ENDIF 
	ENDIF 
	(TurnToFaceVelocity) 
	(SwitchOffBoard) 
	(SetRollingFriction) 15 
	(PlayAnim) (Anim) = <SmackAnim> (Blendperiod) = 0.10000000149 
	(Obj_Spawnscript) (BloodTiny) 
	(Vibrate) (Actuator) = 1 (Percent) = 100 (Duration) = 0.20000000298 
	(WaitAnimFinished) 
	IF (AnimEquals) (SmackWall) 
		(PlayAnim) (Anim) = (GetUpFacesmash) (Blendperiod) = 0.10000000149 
	ELSE 
		IF (AnimEquals) (Smackwallupright) 
			(PlayAnim) (Anim) = (GetUpBackwards) (Blendperiod) = 0.10000000149 
		ELSE 
			(PlayAnim) (Anim) = (GetUpFacing) (Blendperiod) = 0.10000000149 
		ENDIF 
	ENDIF 
	(SetRollingFriction) 15 
	(WaitAnim) 80 (Percent) 
	(SwitchOnBoard) 
	(BoardRotate) (normal) 
	(WaitAnimFinished) 
	(Goto) (Baildone) 
ENDSCRIPT

SCRIPT (GroundGoneBail) (AnimFall1) = (HeadFirstFall) (AnimFall2) = (HeadFirstSplat) (SplatFriction) = 100 (FallBlendPeriod) = 0.30000001192 
	(InBail) 
	(ClearExceptions) 
	IF (InSlapGame) 
		(SetException) (Ex) = (SkaterCollideBail) (Scr) = (SkaterCollideBail) 
	ELSE 
		IF (GameModeEquals) (is_firefight) 
			(SetEventHandler) (Ex) = (SkaterCollideBail) (Scr) = (Bail_FireFight_SkaterCollideBail) 
		ENDIF 
	ENDIF 
	(DisablePlayerInput) (AllowCameraControl) 
	(SetExtraPush) (radius) = 48 (Speed) = 100 (rotate) = 6 
	(SwitchOffBoard) 
	(PlayAnim) (Anim) = <AnimFall1> (NoRestart) (Blendperiod) = <FallBlendPeriod> 
	BEGIN 
		IF (AnimFinished) 
			(PlayAnim) (Anim) = <AnimFall1> (PingPong) (From) = (End) (To) = 20 (Speed) = 0.50000000000 (Blendperiod) = 0.10000000149 
		ENDIF 
		IF (OnGround) 
			BREAK 
		ENDIF 
		(WaitOneGameFrame) 
	REPEAT 
	(Vibrate) (Actuator) = 1 (Percent) = 100 (Duration) = 0.20000000298 
	IF (GotParam) (NoBlood) 
	ELSE 
		(Obj_Spawnscript) (BloodTiny) 
	ENDIF 
	(SetRollingFriction) <SplatFriction> 
	(PlayAnim) (Anim) = <AnimFall2> (NoRestart) (Blendperiod) = 0.10000000149 
	(BashOn) 
	IF (GotParam) (AnimFall3) 
		(WaitAnimFinished) 
		(PlayAnim) (Anim) = <AnimFall3> (NoRestart) (Blendperiod) = 0.10000000149 
	ENDIF 
	(WaitAnim) 20 (frames) (fromend) 
	(BoardRotate) (normal) 
	(SwitchOnBoard) 
	(WaitAnimFinished) 
	(Goto) (Baildone) 
ENDSCRIPT

SCRIPT (Baildone) 
	(Obj_RestoreBoundingSphere) 
	(ClearLipCombos) 
	(NotifyBailDone) 
	(SetExtraPush) (radius) = 0 
	(SetRollingFriction) (default) 
	(ClearTrickQueue) 
	(ClearEventBuffer) 
	(ClearManualTrick) 
	(BashOff) 
	(EnablePlayerInput) 
	(NotInBail) 
	(ClearGapTricks) 
	(KillExtraTricks) 
	(SetSkaterCamLerpReductionTimer) (time) = 0 
	(ClearSkaterFlags) 
	(LockVelocityDirection) (Off) 
	(RestoreAutoKick) 
	(CanBrakeOn) 
	IF NOT (Walking) 
		(Goto) (OnGroundAI) 
	ENDIF 
ENDSCRIPT

SCRIPT (BloodOn) (size) = 1 (radius) = 1 (name) = "blood_01" 
	(TextureSplat) (radius) = RANDOM_RANGE PAIR(1.00000000000, 40.00000000000) (size) = <size> (bone) = (bone_head) (name) = <name> (lifetime) = 20 
ENDSCRIPT

SCRIPT (BloodOn_Down) (size) = 1 (radius) = 1 (name) = "blood_01" 
	(TextureSplat) (radius) = RANDOM_RANGE PAIR(10.00000000000, 300.00000000000) (size) = <size> (bone) = (bone_head) (name) = <name> (dropdown_length) = 100 (dropdown_vertical) (lifetime) = 20 
ENDSCRIPT

SCRIPT (BloodBig) 
	(BloodOn) <...> (size) = 10.00000000000 (freq) = 2.00000000000 (rnd_radius) = 12 
	(Wait) 2 (frames) 
	(BloodOff) <...> 
	(BloodOn) <...> (size) = 7.00000000000 (freq) = 2.00000000000 (rnd_radius) = 12 
	(Wait) 4 (frames) 
	(BloodOff) <...> 
	(BloodOn) <...> (size) = 3.00000000000 (freq) = 0.80000001192 (rnd_radius) = 12 
	(Wait) 3 (frames) 
	(BloodOff) <...> 
ENDSCRIPT

SCRIPT (BloodCar) 
	(Wait) 30 (frames) 
	(TextureSplat) (radius) = 2 (size) = 20 (bone) = (bone_head) (name) = "blood_01" (lifetime) = 20 
ENDSCRIPT

SCRIPT (BloodJackAss) 
	IF NOT (GetGlobalFlag) (Flag) = (BLOOD_OFF) 
		(Wait) 30 (frames) 
		(printf) "MAKING SOME BIG BLOOD..............." 
		(BloodOn_Down) (size) = RANDOM_RANGE PAIR(8.00000000000, 15.00000000000) 
		(BloodOn_Down) (size) = RANDOM_RANGE PAIR(8.00000000000, 15.00000000000) 
		(Wait) RANDOM_RANGE PAIR(1.00000000000, 8.00000000000) (frames) 
		(BloodOn_Down) <...> (size) = RANDOM_RANGE PAIR(6.00000000000, 12.00000000000) 
		(BloodOn_Down) <...> (size) = RANDOM_RANGE PAIR(6.00000000000, 12.00000000000) 
		(Wait) RANDOM_RANGE PAIR(1.00000000000, 8.00000000000) (frames) 
		(BloodOn_Down) <...> (size) = RANDOM_RANGE PAIR(4.00000000000, 8.00000000000) 
		(BloodOn_Down) <...> (size) = RANDOM_RANGE PAIR(4.00000000000, 8.00000000000) 
		(Wait) RANDOM_RANGE PAIR(1.00000000000, 8.00000000000) (frames) 
		(BloodOn_Down) (size) = RANDOM_RANGE PAIR(2.00000000000, 6.00000000000) 
	ENDIF 
ENDSCRIPT

SCRIPT (BloodSmall) 
	IF NOT (GetGlobalFlag) (Flag) = (BLOOD_OFF) 
		IF NOT (GetGlobalFlag) (Flag) = (CHEAT_SUPER_BLOOD) 
			IF (OnGround) 
				(Obj_Spawnscript) (BloodSplat) 
			ENDIF 
			(Wait) 14 (frames) 
			(BloodOn) <...> (size) = RANDOM_RANGE PAIR(8.00000000000, 12.00000000000) (freq) = 2.00000000000 (rnd_radius) = 36 
			(Wait) RANDOM_RANGE PAIR(1.00000000000, 3.00000000000) (frames) 
			(BloodOn) <...> (size) = RANDOM_RANGE PAIR(6.00000000000, 10.00000000000) (freq) = 2.00000000000 (rnd_radius) = 36 
			(Wait) RANDOM_RANGE PAIR(1.00000000000, 3.00000000000) (frames) 
			(BloodOn) <...> (size) = RANDOM_RANGE PAIR(4.00000000000, 8.00000000000) (freq) = 0.80000001192 (rnd_radius) = 36 
			(Wait) RANDOM_RANGE PAIR(1.00000000000, 3.00000000000) (frames) 
			(BloodOn) (size) = RANDOM_RANGE PAIR(2.00000000000, 6.00000000000) 
		ELSE 
			(Obj_Spawnscript) (BloodSplat) 
			(Wait) 14 (frames) 
			(Obj_Spawnscript) (BloodSplat) 
			(TextureSplat) (radius) = RANDOM_RANGE PAIR(20.00000000000, 40.00000000000) (size) = RANDOM_RANGE PAIR(30.00000000000, 40.00000000000) (bone) = (bone_head) (name) = "blood_01" (lifetime) = 20 
			(Wait) 5 (frame) 
			(BloodOn) <...> (size) = RANDOM_RANGE PAIR(15.00000000000, 20.00000000000) 
			(Wait) 4 (frame) 
			(BloodOn) <...> (size) = RANDOM_RANGE PAIR(10.00000000000, 15.00000000000) 
			(Wait) 4 (frame) 
			(BloodOn) <...> (size) = RANDOM_RANGE PAIR(10.00000000000, 15.00000000000) 
			(Wait) 3 (frames) 
			(BloodOn) (size) = RANDOM_RANGE PAIR(6.00000000000, 10.00000000000) 
			(Wait) 2 (frame) 
			(BloodOn) (size) = RANDOM_RANGE PAIR(6.00000000000, 10.00000000000) 
			(Wait) 1 (frame) 
			(BloodOn) (size) = RANDOM_RANGE PAIR(6.00000000000, 10.00000000000) 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT (BloodTiny) 
	IF NOT (GetGlobalFlag) (Flag) = (BLOOD_OFF) 
		(Obj_Spawnscript) (BloodSplat) 
		(BloodOn) <...> (size) = 5.00000000000 (freq) = 2.00000000000 (rnd_radius) = 12 
		(Wait) 4 (frames) 
		(BloodOff) <...> 
		(BloodOn) <...> (size) = 2.00000000000 (freq) = 0.80000001192 (rnd_radius) = 12 
		(Wait) 3 (frames) 
		(BloodOff) <...> 
	ENDIF 
ENDSCRIPT

SCRIPT (BloodSuperTiny) 
	(Obj_Spawnscript) (BloodSplat) 
	(BloodOn) <...> (size) = 1.00000000000 (freq) = 2.00000000000 (rnd_radius) = 12 
	(Wait) 4 (frames) 
	(BloodOff) <...> 
	(BloodOn) <...> (size) = 0.50000000000 (freq) = 0.80000001192 (rnd_radius) = 12 
	(Wait) 3 (frames) 
	(BloodOff) <...> 
ENDSCRIPT

SCRIPT (BloodSplat) 
	IF NOT (GetGlobalFlag) (Flag) = (BLOOD_OFF) 
		(BloodParticlesOn) (name) = "blood_1.png" (start_col) = -16777046 (end_col) = 570425514 (num) = 10 (emit_w) = 2.00000000000 (emit_h) = 2.00000000000 (angle) = 10 (size) = 2.00000000000 (bone) = (bone_head) (growth) = 1.50000000000 (time) = 0.30000001192 (Speed) = 250 (grav) = -900 (life) = 0.30000001192 
	ENDIF 
ENDSCRIPT

SCRIPT (SwitchOnBoard) 
	IF NOT (IsLocalSkater) 
		RETURN 
	ENDIF 
	IF NOT (IsBoardMissing) 
		(SwitchOnAtomic) (Board) 
	ELSE 
		(SwitchOffBoard) 
	ENDIF 
	(Obj_GetId) 
	(MangleChecksums) (a) = (BailBoard) (b) = <objId> 
	IF (ObjectExists) (id) = <mangled_id> 
		<mangled_id> : (die) 
	ENDIF 
ENDSCRIPT

(BailBoardComponents) = [ 
	{ 
		(component) = (suspend) 
	} 
	{ 
		(component) = (rigidbody) 
		(coeff_friction) = 0.69999998808 
		(coeff_restitution) = 0.15000000596 
		(const_acc) = -500 
		(mass_over_moment) = 0.00700000022 
		(center_of_mass) = VECTOR(0.00000000000, 3.00000000000, 0.00000000000) 
		(spring_const) = 10 
		(linear_velocity_sleep_point) = 3 
		(angular_velocity_sleep_point) = 0.10000000149 
		(skater_collision_radius) = 28 
		(skater_collision_application_radius) = 8 
		(skater_collision_impulse_factor) = 1.00000000000 
		(contacts) = [ 
			VECTOR(6.00000000000, 7.00000000000, 18.00000000000) 
			VECTOR(6.00000000000, 7.00000000000, -18.00000000000) 
			VECTOR(-6.00000000000, 7.00000000000, 18.00000000000) 
			VECTOR(-6.00000000000, 7.00000000000, -18.00000000000) 
			VECTOR(6.00000000000, 0.00000000000, 13.00000000000) 
			VECTOR(6.00000000000, 0.00000000000, -13.00000000000) 
			VECTOR(-6.00000000000, 0.00000000000, 13.00000000000) 
			VECTOR(-6.00000000000, 0.00000000000, -13.00000000000) 
		] 
		(directed_friction) = [ 
			{ (none) } 
			{ (none) } 
			{ (none) } 
			{ (none) } 
			{ VECTOR(1.00000000000, 0.00000000000, 0.00000000000) } 
			{ VECTOR(1.00000000000, 0.00000000000, 0.00000000000) } 
			{ VECTOR(1.00000000000, 0.00000000000, 0.00000000000) } 
			{ VECTOR(1.00000000000, 0.00000000000, 0.00000000000) } 
		] 
		(SoundType) = (SkaterBoardWhenBail) 
	} 
	{ 
		(component) = (skeleton) 
		(skeletonName) = (thps5_human) 
	} 
	{ 
		(component) = (model) 
		(UseModelLights) 
		(model) = "board_default/board_default.mdl" 
	} 
	{ 
		(component) = (modellightupdate) 
	} 
	{ 
		(component) = (Sound) 
	} 
] 
SCRIPT (CreateBailBoard) (vel) = VECTOR(0.00000000000, 0.00000000000, 0.00000000000) (rotvel) = VECTOR(0.00000000000, 0.00000000000, 0.00000000000) (object_vel_factor) = 1 
	(Obj_GetId) 
	(MangleChecksums) (a) = (BailBoard) (b) = <objId> 
	IF (ObjectExists) (id) = <mangled_id> 
		<mangled_id> : (die) 
	ENDIF 
	(Skeleton_SpawnCompositeObject) <...> (offset) = VECTOR(0.00000000000, -3.00000000000, 2.00000000000) (bone) = (Bone_Board_Root) (components) = (BailBoardComponents) (Params) = { (name) = <mangled_id> (cloneFrom) = <objId> (geoms) = [ (Board) ] } 
	<mangled_id> : (RigidBody_IgnoreSkater) 15 (frames) 
	<mangled_id> : (RigidBody_Wake) 
ENDSCRIPT

SCRIPT (SwitchOffBoard) 
	(SwitchOffAtomic) (Board) 
ENDSCRIPT

SCRIPT (CleanUpSpecialItems) 
	(SwitchOffAtomic) (special_item) 
	(SwitchOnAtomic) (special_item_2) 
ENDSCRIPT

SCRIPT (SkaterCollideBall) 
	IF (InAir) 
		(InAirExceptions) 
		(Obj_Spawnscript) (CarSparks) 
		(PlayAnim) (Anim) = (Boneless) (Blendperiod) = 0.30000001192 
		(SetTrickName) "Scratchin the Ball!" 
		(SetTrickScore) 400 
		(Display) 
		(WaitAnimWhilstChecking) (AndManuals) 
		(Goto) (Airborne) 
	ELSE 
		(InBail) 
		(Obj_Spawnscript) (BloodCar) 
		(Goto) (NoseManualBail) 
		(LaunchPanelMessage) "Ball Busted!" 
	ENDIF 
ENDSCRIPT

SCRIPT (skater_play_bail_stream) 
	(Obj_PlayStream) <stream_checksum> (vol) = 500 
ENDSCRIPT

SCRIPT (skater_hint_style) 
	(DoMorph) (time) = 0 (scale) = PAIR(0.00000000000, 0.00000000000) 
	(DoMorph) (time) = 0.10000000149 (scale) = PAIR(2.50000000000, 2.50000000000) 
	(DoMorph) (time) = 0.10000000149 (scale) = PAIR(0.75000000000, 0.75000000000) 
	(DoMorph) (time) = 0.10000000149 (scale) = PAIR(1.29999995232, 1.29999995232) 
	(DoMorph) (time) = 0.10000000149 (scale) = PAIR(1.10000002384, 1.10000002384) 
	(DoMorph) (time) = 0.05000000075 (alpha) = 0.60000002384 
	(DoMorph) (time) = 0.05000000075 (alpha) = 1 
	(DoMorph) (time) = 0.05000000075 (alpha) = 0.60000002384 
	(DoMorph) (time) = 0.05000000075 (alpha) = 1 
	(DoMorph) (time) = 0.05000000075 (alpha) = 0.60000002384 
	(DoMorph) (time) = 0.05000000075 (alpha) = 1 
	(DoMorph) (time) = 0.05000000075 (alpha) = 0.60000002384 
	(DoMorph) (time) = 0.05000000075 (alpha) = 1 
	(DoMorph) (time) = 0.05000000075 (alpha) = 0.60000002384 
	(DoMorph) (time) = 0.05000000075 (alpha) = 1 
	(DoMorph) (time) = 0.05000000075 (alpha) = 0.60000002384 
	(DoMorph) (time) = 0.05000000075 (alpha) = 1 
	(DoMorph) (time) = 0.05000000075 (alpha) = 0.60000002384 
	(DoMorph) (time) = 0.05000000075 (alpha) = 1 
	(DoMorph) (time) = 0.05000000075 (alpha) = 0.60000002384 
	(DoMorph) (time) = 0.05000000075 (alpha) = 1 
	(DoMorph) (time) = 0.05000000075 (alpha) = 0.60000002384 
	(DoMorph) (time) = 0.05000000075 (alpha) = 1 
	(DoMorph) (time) = 0.05000000075 (alpha) = 0.60000002384 
	(DoMorph) (time) = 0.05000000075 (alpha) = 1 
	(DoMorph) (time) = 0.05000000075 (alpha) = 0.60000002384 
	(DoMorph) (time) = 0.05000000075 (alpha) = 1 
	(DoMorph) (time) = 0.05000000075 (alpha) = 0.60000002384 
	(DoMorph) (time) = 0.05000000075 (alpha) = 1 
	(DoMorph) (time) = 0.05000000075 (alpha) = 0.60000002384 
	(DoMorph) (time) = 0.05000000075 (alpha) = 1 
	(DoMorph) (time) = 0.05000000075 (alpha) = 0.60000002384 
	(DoMorph) (time) = 0.05000000075 (alpha) = 1 
	(DoMorph) (time) = 0.05000000075 (alpha) = 0.60000002384 
	(DoMorph) (time) = 0.05000000075 (alpha) = 1 
	(DoMorph) (time) = 0.05000000075 (alpha) = 0.60000002384 
	(DoMorph) (time) = 0.05000000075 (alpha) = 1 
	(DoMorph) (time) = 0.05000000075 (alpha) = 0.60000002384 
	(DoMorph) (time) = 0.05000000075 (alpha) = 1 
	(DoMorph) (time) = 0.05000000075 (alpha) = 0.60000002384 
	(DoMorph) (time) = 0.05000000075 (alpha) = 1 
	(DoMorph) (time) = 0.05000000075 (alpha) = 0.60000002384 
	(DoMorph) (time) = 0.05000000075 (alpha) = 1 
	(DoMorph) (time) = 0.05000000075 (alpha) = 0.60000002384 
	(DoMorph) (time) = 0.05000000075 (alpha) = 1 
	(DoMorph) (time) = 0.05000000075 (alpha) = 0.60000002384 
	(DoMorph) (time) = 0.05000000075 (alpha) = 1 
	(DoMorph) (time) = 0.05000000075 (alpha) = 0.60000002384 
	(DoMorph) (time) = 0.05000000075 (alpha) = 1 
	(DoMorph) (time) = 0.05000000075 (alpha) = 0.60000002384 
	(DoMorph) (time) = 0.05000000075 (alpha) = 1 
	(DoMorph) (time) = 0.05000000075 (alpha) = 0.60000002384 
	(DoMorph) (time) = 0.05000000075 (alpha) = 1 
	(DoMorph) (time) = 0.05000000075 (alpha) = 0.60000002384 
	(DoMorph) (time) = 0.05000000075 (alpha) = 1 
	(DoMorph) (time) = 0.10000000149 (scale) = PAIR(2.50000000000, 2.50000000000) 
	(DoMorph) (time) = 0.20000000298 (scale) = PAIR(12.00000000000, 0.00000000000) (alpha) = 0 
	(die) 
ENDSCRIPT


