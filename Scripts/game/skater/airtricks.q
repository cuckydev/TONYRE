
SpecialTricks = 
[ 
	{ Trigger = { TripleInOrder , Up , Right , Square , 400 } TrickSlot = SpAir_U_R_Square } 
	{ Trigger = { TripleInOrder , Up , Down , Square , 400 } TrickSlot = SpAir_U_D_Square } 
	{ Trigger = { TripleInOrder , Up , Left , Square , 400 } TrickSlot = SpAir_U_L_Square } 
	{ Trigger = { TripleInOrder , Right , Up , Square , 400 } TrickSlot = SpAir_R_U_Square } 
	{ Trigger = { TripleInOrder , Right , Down , Square , 400 } TrickSlot = SpAir_R_D_Square } 
	{ Trigger = { TripleInOrder , Right , Left , Square , 400 } TrickSlot = SpAir_R_L_Square } 
	{ Trigger = { TripleInOrder , Down , Up , Square , 400 } TrickSlot = SpAir_D_U_Square } 
	{ Trigger = { TripleInOrder , Down , Right , Square , 400 } TrickSlot = SpAir_D_R_Square } 
	{ Trigger = { TripleInOrder , Down , Left , Square , 400 } TrickSlot = SpAir_D_L_Square } 
	{ Trigger = { TripleInOrder , Left , Up , Square , 400 } TrickSlot = SpAir_L_U_Square } 
	{ Trigger = { TripleInOrder , Left , Right , Square , 400 } TrickSlot = SpAir_L_R_Square } 
	{ Trigger = { TripleInOrder , Left , Down , Square , 400 } TrickSlot = SpAir_L_D_Square } 
	{ Trigger = { TripleInOrder , Up , Right , Circle , 400 } TrickSlot = SpAir_U_R_Circle } 
	{ Trigger = { TripleInOrder , Up , Down , Circle , 400 } TrickSlot = SpAir_U_D_Circle } 
	{ Trigger = { TripleInOrder , Up , Left , Circle , 400 } TrickSlot = SpAir_U_L_Circle } 
	{ Trigger = { TripleInOrder , Right , Up , Circle , 400 } TrickSlot = SpAir_R_U_Circle } 
	{ Trigger = { TripleInOrder , Right , Down , Circle , 400 } TrickSlot = SpAir_R_D_Circle } 
	{ Trigger = { TripleInOrder , Right , Left , Circle , 400 } TrickSlot = SpAir_R_L_Circle } 
	{ Trigger = { TripleInOrder , Down , Up , Circle , 400 } TrickSlot = SpAir_D_U_Circle } 
	{ Trigger = { TripleInOrder , Down , Right , Circle , 400 } TrickSlot = SpAir_D_R_Circle } 
	{ Trigger = { TripleInOrder , Down , Left , Circle , 400 } TrickSlot = SpAir_D_L_Circle } 
	{ Trigger = { TripleInOrder , Left , Up , Circle , 400 } TrickSlot = SpAir_L_U_Circle } 
	{ Trigger = { TripleInOrder , Left , Right , Circle , 400 } TrickSlot = SpAir_L_R_Circle } 
	{ Trigger = { TripleInOrder , Left , Down , Circle , 400 } TrickSlot = SpAir_L_D_Circle } 
] 
GRABTWEAK_SMALL = 15 
GRABTWEAK_MEDIUM = 20 
GRABTWEAK_LARGE = 25 
GRABTWEAK_EXTRALARGE = 40 
GRABTWEAK_SPECIAL = 30 
Trick_BamBendAir = { Scr = GrabTrick Params = { Name = #"Bam Bend Air" Speed = 1.29999995232 Score = 1300 Anim = BamBendAir_Init Idle = BamBendAir_Idle trickslack = 100 IsSpecial } } 
Trick_FlyingSquirrel = { Scr = GrabTrick Params = { Name = #"Flying Squirrel" Speed = 1.29999995232 Score = 1500 Anim = FlyingSquirrel_Init Idle = FlyingSquirrel_Idle IsSpecial } } 
Trick_Shifty360ShovitBSShifty = { Scr = GrabTrick Params = { Name = #"Shifty Shifty" Speed = 2.00000000000 Score = 2000 Anim = Shifty360ShovitBSShifty_Init ForceInit Idle = Shifty360ShovitBSShifty_Idle Idle OutAnim = Shifty360ShovitBSShifty_Out trickslack = 100 IsSpecial boardrotate } } 
Trick_flipflip = { Scr = FlipTrick Params = { Name = #"Rodeo Wrap" Score = 1600 Anim = flipflip ForceInit IsSpecial boardrotate trickslack = 20 RotateAfter NoSpin Speed = 1.20000004768 maxspeed = 1.29999995232 } } 
Trick_540varielheelfliplien = { Scr = FlipTrick Params = { Name = #"360 Varial Heelflip Lien" Score = 1500 Anim = _540varielheelfliplien Speed = 1.29999995232 IsSpecial boardrotate trickslack = 20 Speed = 1.20000004768 maxspeed = 1.29999995232 } } 
Trick_LickItUp = { Scr = GrabTrick Params = { Name = #"Lick It Up" Speed = 1.29999995232 Score = 1500 Anim = LickItUp_Init Idle = LickItUp_Idle Idle OutAnim = LickItUp_Out trickslack = 100 SpecialItem_details = tongue_details Skater = Gene IsSpecial } } 
Trick_3DSwimAir = { Scr = GrabTrick Params = { Name = #"Swimmer" Skater = Creature Speed = 1.29999995232 Score = 1500 Anim = _3DSwimAir_Init Idle = _3DSwimAir_Idle Idle OutAnim = _3DSwimAir_Out trickslack = 100 IsSpecial } } 
Trick_BootBurst = { Scr = GrabTrick Params = { Name = #"Boot Burst" Skater = Iron_Man Score = 2000 Speed = 1.29999995232 Anim = bootburst_Init Idle = bootburst_Idle Idle OutAnim = bootburst_Out trickslack = 100 IsSpecial } } 
Trick_FSFlipOneFootTailGrab = { Scr = GrabTrick Params = { Name = #"360 Flip Tail Grab" Score = 1600 Anim = FSFlipOneFootTailGrab_Init ForceInit InitSpeed = 1.50000000000 Idle = FSFlipOneFootTailGrab_Idle Idle OutAnim = FSFlipOneFootTailGrab_Out IsSpecial trickslack = 10 } } 
Trick_Flamingo = { Scr = GrabTrick Params = { Name = #"Flamingo" Score = 1500 Anim = Flamingo_Init Idle = Flamingo_Idle OutAnim = Flamingo_Out Speed = 1.20000004768 IsSpecial } } 
Trick_SambaFlip = { Scr = GrabTrick Params = { Name = #"Samba Flip" Score = 1600 Anim = SambaFlip Idle = Indy_Idle BackwardsAnim = Indy trickslack = 10 ForceInit IsSpecial Speed = 1.39999997616 } } 
Trick_360VarialMcTwist = { Scr = FlipTrick Params = { Name = #"360 Varial McTwist" Score = 5750 Anim = _360VarialMcTwist boardrotate IsSpecial RevertBS NoSpin trickslack = 10 RotateAfter Speed = 1.29999995232 maxspeed = 1.10000002384 Spinslack = 20 } } 
Trick_BarrelRoll = { Scr = FlipTrick Params = { Name = #"Barrel Roll" Score = 5000 Anim = BarrelRoll IsSpecial NoSpin trickslack = 10 boardrotate Speed = 1.00000000000 maxspeed = 1.10000002384 Spinslack = 10 } } 
Trick_Indy900 = { Scr = FlipTrick Params = { Name = #"Indy 900" Score = 11000 Anim = Indy900 IsSpecial boardrotate trickslack = 20 RotateAfter NoSpin Speed = 1.29999995232 maxspeed = 1.39999997616 } } 
Trick_SitDownAir = { Scr = GrabTrick Params = { Name = #"Sit Down Air" Score = 1200 Anim = SitDownAir_Init Idle = SitDownAir_Idle IsSpecial WaitPercent = 80 } } 
Trick_ChompOnThis = { Scr = GrabTrick Params = { Name = #"Chomp On This" Score = 1000 Anim = ChompOnThis_Init Idle = ChompOnThis_Idle OutAnim = ChompOnThis_Out IsSpecial maxspeed = 0.89999997616 ForceInit Stream = ChompOnThis SpecialItem_details = PizzaBox_details Speed = 0.89999997616 } } 
Trick_GhettoBird = { Scr = FlipTrick Params = { Name = #"360 Ghetto Bird" Score = 3500 Anim = GhettoBird2 IsSpecial boardrotate trickslack = 20 NoSpin Speed = 1.00000000000 } } 
Trick_BreakIn = { Scr = FlipTrick Params = { Name = #"Back Spin Air" Score = 3000 Anim = BreakIn_Init boardrotate trickslack = 20 RotateAfter Speed = 1.79999995232 IsSpecial } } 
Trick_BigSpinShifty = { Scr = GrabTrick Params = { Name = #"BigSpin Shifty" Score = 1650 Speed = 1.20000004768 Anim = FSBigSpinShifty_Init Idle = FSBigSpinShifty_Idle OutAnim = FSBigSpinShifty_Out IsSpecial ForceInit FlipAfter } } 
Trick_The900 = { Scr = FlipTrick Params = { Name = #"The 900" Score = 9000 Anim = The900 IsSpecial boardrotate trickslack = 20 RotateAfter NoSpin Speed = 1.29999995232 maxspeed = 1.39999997616 } } 
Trick_KFBackflip = { Scr = FlipTrick Params = { Name = #"Kickflip Backflip" Score = 3000 Anim = KickFlipBodyBackFlip IsSpecial Speed = 1.00000000000 NoSpin trickslack = 15 Spinslack = 25 } } 
Trick_FS540 = { Scr = FlipTrick Params = { Name = #"FS 540" Score = 5500 Anim = FS540 boardrotate IsSpecial trickslack = 10 RevertBS RotateAfter NoSpin Speed = 0.89999997616 Spinslack = 40 } } 
Trick_McTwist = { Scr = FlipTrick Params = { Name = #"McTwist" Score = 5000 Anim = McTwist boardrotate IsSpecial RevertBS NoSpin trickslack = 10 RotateAfter Speed = 1.00000000000 maxspeed = 1.10000002384 Spinslack = 20 } } 
Trick_2KickMadonnaFlip = { Scr = GrabTrick Params = { Name = #"Double Kickflip Madonna" Score = 2250 Anim = _2KickMadonnaFlip_Init Idle = Madonna_Idle OutAnim = _2KickMadonnaFlip_Out IsSpecial ForceInit trickslack = 15 Speed = 1.14999997616 } } 
Trick_AssumePosition = { Scr = GrabTrick Params = { Name = #"Assume The Position II" Score = 1000 Anim = AssumePosition_Init Idle = AssumePosition_Idle IsSpecial Speed = 0.80000001192 ForceInit trickslack = 10 } } 
Trick_AirCasperFlip = { Scr = GrabTrick Params = { Name = #"Casper Flip 360 Flip" Score = 2500 Anim = AirCasperFlip_Init Idle = AirCasperFlip_Idle OutAnim = AirCasperFlip_Out IsSpecial Speed = 1.10000002384 ForceInit trickslack = 20 } } 
Trick_540TailWhip = { Scr = FlipTrick Params = { Name = #"540 TailWhip" Score = 2500 Anim = _540TailWhip IsSpecial boardrotate Speed = 1.10000002384 maxspeed = 1.20000004768 trickslack = 15 } } 
Trick_Gazelle = { Scr = FlipTrick Params = { Name = #"Gazelle Underflip" Score = 3500 Anim = GazelleUnderflip IsSpecial boardrotate trickslack = 20 NoSpin } } 
HIGHSPEED = 1.00000000000 
Trick_SemiFlip = { Scr = FlipTrick Params = { Name = #"Semi Flip" Score = 1150 Anim = SemiFlip boardrotate IsSpecial Speed = 1.10000002384 trickslack = 20 } } 
Trick_FingerFlipAirWalk = { Scr = FlipTrick Params = { Name = #"Fingerflip Airwalk" Score = 1500 Anim = FingerFlipAirWalk IsSpecial boardrotate Speed = 1.00000000000 trickslack = 30 HoldFrame = 40 } } 
Trick_Jackass = { Scr = FlipTrick Params = { Name = #"The Jackass" Score = 1600 Anim = Jackass IsSpecial Speed = 1 maxspeed = 1.20000004768 trickslack = 20 BloodFrame = 1 } } 
Trick_1234 = { Scr = FlipTrick Params = { Name = #"1-2-3-4" Score = 1600 Anim = _1234 IsSpecial Speed = 0.80000001192 trickslack = 20 } } 
Trick_DoubleKFindy = { Scr = FlipTrick Params = { Name = #"Double Kickflip Varial Indy" Score = 1200 Anim = DoubleKFVarialIndy maxspeed = 1.20000004768 trickslack = 20 IsSpecial boardrotate HoldFrame = 15 } } 
Trick_540Flip = { Scr = FlipTrick Params = { Name = #"540 Flip" Score = 1450 Anim = _540flip boardrotate IsSpecial Speed = 1.10000002384 maxspeed = 1.20000004768 trickslack = 20 } } 
Trick_NollieFlipUnderflip = { Scr = FlipTrick Params = { Name = #"Nollie Flip Underflip" Score = 1150 Anim = NollieFlipUnderFlip IsSpecial trickslack = 10 Speed = 1.00000000000 maxspeed = 1.29999995232 } } 
Trick_HardFlipBackFootFlip = { Scr = FlipTrick Params = { Name = #"Hardflip Late Flip" Score = 1500 Anim = HardFlipBackFootFlip IsSpecial trickslack = 15 Speed = 1.00000000000 boardrotate } } 
Trick_KickFlipUnderFlip = { Scr = FlipTrick Params = { Name = #"Kickflip Underflip" Score = 1000 Anim = KickFlipUnderFlip IsSpecial trickslack = 10 maxspeed = 1.29999995232 Speed = 1.10000002384 } } 
Trick_QuadrupleHeelFlip = { Scr = FlipTrick Params = { Name = #"Quad Heelflip" Score = 1400 Anim = QuadrupleHeelFlip IsSpecial trickslack = 10 Speed = 1.00000000000 } } 
Trick_OldSkoolKickflip = { Scr = FlipTrick Params = { Name = #"Old Sk00l Kickflip" Score = 300 Speed = 1.20000004768 Anim = KickFlipOldSkool FlipAfter Nollie = NollieKickflip ExtraTricks = DoubleKickflip } } 
Trick_BigSpinFlip = { Scr = FlipTrick Params = { Name = #"Bigspin Flip" Score = 500 Anim = BigSpinFlip boardrotate FlipAfter Speed = 1.50000000000 maxspeed = 1.50000000000 ExtraTricks = Extra_VarialKickflip } } 
Trick_FSFlip = { Scr = FlipTrick Params = { Name = #"FS Flip" Score = 500 Anim = FSFlip boardrotate FlipAfter maxspeed = 1.50000000000 ExtraTricks = Extra_VarialKickflip } } 
Trick_BSFlip = { Scr = FlipTrick Params = { Name = #"BS Flip" Score = 500 Anim = BSFlip boardrotate FlipAfter maxspeed = 1.50000000000 ExtraTricks = Extra_VarialKickflip } } 
Trick_FSBigSpin = { Scr = FlipTrick Params = { Name = #"BS Bigspin" Score = 500 Anim = FSBigSpin Speed = 1.20000004768 FlipAfter maxspeed = 2 ExtraTricks = Extra540ShoveIt } } 
Trick_BSBigSpin = { Scr = FlipTrick Params = { Name = #"FS Bigspin" Score = 500 Anim = BSBigSpin Speed = 1.39999997616 FlipAfter maxspeed = 2 ExtraTricks = ExtraFS540ShoveIt } } 
Trick_BackfootShoveIt = { Scr = FlipTrick Params = { Name = #"Back Foot Shove-It" Score = 150 Anim = NollieBSShoveIt Nollie = PopShoveIt ExtraTricks = Extra_360BackfootShoveIt boardrotate } } 
Extra_360BackfootShoveIt = [ { Trigger = { Press , Square , 300 } Scr = FlipTrick Params = { Name = #"360 Back Foot Shove-It" Score = 500 Anim = NollieBS360ShoveIt IsExtra UseCurrent } } ] 
Trick_VarialKickflip = { Scr = FlipTrick Params = { Name = #"Varial Kickflip" Score = 300 Anim = VarialKickflip boardrotate Nollie = NollieVarialKickflip ExtraTricks = Extra_VarialKickflip } } 
Extra_VarialKickflip = [ { Trigger = { Press , Square , 300 } Scr = FlipTrick Params = { Name = #"360 Flip" Score = 550 Speed = 0.89999997616 Anim = _360Flip Nollie = Nollie360Flip IsExtra UseCurrent } } ] 
Trick_VarialHeelflip = { Scr = FlipTrick Params = { Name = #"Varial Heelflip" Score = 300 Anim = VarialHeelflip boardrotate Nollie = NollieVarialHeelflip ExtraTricks = Extra_VarialHeelflip } } 
Extra_VarialHeelflip = [ { Trigger = { Press , Square , 300 } Scr = FlipTrick Params = { Name = #"360 Heelflip" Score = 500 Anim = laserflip Speed = 1.29999995232 trickslack = 20 IsExtra UseCurrent } } ] 
Trick_Hardflip = { Scr = FlipTrick Params = { Name = #"Hardflip" Score = 300 Anim = Hardflip boardrotate Nollie = NollieHardflip ExtraTricks = Extra_360Hardflip } } 
Extra_360Hardflip = [ { Trigger_Extra_Flip Params = { Name = #"360 Hardflip" Score = 500 Anim = _360Hardflip IsExtra trickslack = 20 Speed = 1.10000002384 UseCurrent } } ] 
Trick_InwardHeelflip = { Scr = FlipTrick Params = { Name = #"Inward Heelflip" Score = 350 Anim = InwardHeelflip boardrotate Nollie = NollieInwardFlip trickslack = 15 ExtraTricks = Extra_360InwardHeelflip } } 
Extra_360InwardHeelflip = [ { Trigger_Extra_Flip Params = { Name = #"360 Inward Heelflip" Score = 500 Anim = _360InwardHeelFlip IsExtra trickslack = 15 Speed = 1.00000000000 UseCurrent } } ] 
Trick_Impossible = { Scr = FlipTrick Params = { Name = #"Impossible" Score = 100 Anim = Impossible Nollie = NollieImpossible ExtraTricks = DoubleImpossible } } 
DoubleImpossible = [ { Trigger = { Press , Square , 300 } Scr = FlipTrick Params = { Name = #"Double Impossible" Score = 500 Anim = DoubleImpossible ExtraTricks = TripleImpossible trickslack = 15 Speed = 1.20000004768 IsExtra UseCurrent } } ] 
TripleImpossible = [ { Trigger = { Press , Square , 300 } Scr = FlipTrick Params = { Name = #"Triple Impossible" Score = 1000 Anim = TripleImpossible IsExtra UseCurrent Speed = 1.20000004768 trickslack = 15 } } ] 
Trick_PopShoveIt = { Scr = FlipTrick Params = { Name = #"Pop Shove-It" Score = 100 Anim = PopShoveItBS boardrotate Nollie = NollieBSShoveIt ExtraTricks = Extra360ShoveIt } } 
Extra360ShoveIt = [ { Trigger = { Press , Square , 300 } Scr = FlipTrick Params = { Name = #"360 Shove-It" Score = 500 Anim = _360ShoveIt Nollie = NollieBS360ShoveIt ExtraTricks = Extra540ShoveIt IsExtra UseCurrent } } ] 
Extra540ShoveIt = [ { Trigger = { Press , Square , 300 } Scr = FlipTrick Params = { Name = #"540 Shove-It" Score = 1000 Anim = _540ShoveIt IsExtra boardrotate UseCurrent } } ] 
Trick_FSShoveIt = { Scr = FlipTrick Params = { Name = #"FS Shove-It" Score = 100 Anim = PopShoveIt Nollie = NollieFSShoveIt boardrotate ExtraTricks = ExtraFS360ShoveIt } } 
ExtraFS360ShoveIt = [ { Trigger = { Press , Square , 300 } Scr = FlipTrick Params = { Name = #"360 FS Shove-It" Score = 500 Anim = FS360ShoveIt Nollie = Nollie360ShoveIt ExtraTricks = ExtraFS540ShoveIt IsExtra UseCurrent } } ] 
ExtraFS540ShoveIt = [ { Trigger = { Press , Square , 300 } Scr = FlipTrick Params = { Name = #"540 FS Shove-It" Score = 1000 Anim = FS540ShoveIt IsExtra boardrotate UseCurrent } } ] 
Trick_BackfootKickflip = { Scr = FlipTrick Params = { Name = #"Back Foot Kickflip" Score = 150 Speed = 0.94999998808 Anim = NollieKickflip Nollie = Kickflip ExtraTricks = Extra_DBackfootKickflip } } 
Extra_DBackfootKickflip = [ { Trigger = { Press , Square , 300 } Scr = FlipTrick Params = { Name = #"Double Back Foot Flip" Score = 550 Speed = 0.89999997616 trickslack = 15 Anim = DoubleNollieKickflip IsExtra UseCurrent } } ] 
Trick_BackfootHeelflip = { Scr = FlipTrick Params = { Name = #"Back Foot Heelflip" Score = 150 Speed = 0.94999998808 Anim = NollieHeelflip Nollie = Heelflip ExtraTricks = Extra_DBackfootHeelflip } } 
Extra_DBackfootHeelflip = [ { Trigger = { Press , Square , 300 } Scr = FlipTrick Params = { Name = #"Double Back Foot Heelflip" Score = 550 Speed = 0.89999997616 trickslack = 15 Anim = DoubleNollieHeelflip IsExtra UseCurrent } } ] 
Trick_Kickflip = { Scr = FlipTrick Params = { Name = #"Kickflip" Score = 100 Anim = Kickflip Nollie = NollieKickflip ExtraTricks = DoubleKickflip } } 
DoubleKickflip = [ { Trigger = { Press , Square , 300 } Scr = FlipTrick Params = { Name = #"Double Kickflip" Score = 500 Anim = DoubleKickflip Nollie = DoubleNollieKickflip ExtraTricks = TripleKickflip IsExtra trickslack = 15 UseCurrent } } ] 
TripleKickflip = [ { Trigger = { Press , Square , 300 } Scr = FlipTrick Params = { Name = #"Triple Kickflip" Score = 1000 Anim = TripleKickflip IsExtra Speed = 1 UseCurrent } } ] 
Trick_Heelflip = { Scr = FlipTrick Params = { Name = #"Heelflip" Score = 100 Anim = Heelflip Nollie = NollieHeelflip ExtraTricks = DoubleHeelflip } } 
DoubleHeelflip = [ { Trigger = { Press , Square , 300 } Scr = FlipTrick Params = { Name = #"Double Heelflip" Score = 500 Anim = DoubleHeelflip Nollie = DoubleNollieHeelflip ExtraTricks = TripleHeelflip trickslack = 15 IsExtra UseCurrent } } ] 
TripleHeelflip = [ { Trigger = { Press , Square , 300 } Scr = FlipTrick Params = { Name = #"Triple Heelflip" Score = 1000 Anim = TripleHeelflip IsExtra UseCurrent } } ] 
Trick_OllieAirwalk = { Scr = FlipTrick Params = { Name = #"Ollie Airwalk" Score = 500 Speed = 1.00000000000 Anim = OllieAirwalk ExtraTricks = Extra_OllieAirwalk } } 
Extra_OllieAirwalk = [ { Trigger_Extra_Flip Params = { Name = #"Ollie Airwalk Late Shove-it" Score = 1050 Anim = OllieAirWalkShoveIt boardrotate Speed = 1.00000000000 IsExtra UseCurrent } } ] 
Trick_OllieNorth = { Scr = FlipTrick Params = { Name = #"Ollie North" Score = 169 Anim = OllieNorth Speed = 1.00000000000 trickslack = 15 ExtraTricks = Extra_OllieNorth HoldFrame = 15 } } 
Extra_OllieNorth = [ { Trigger_Extra_Flip Params = { Name = #"Ollie North Back Foot Flip" Score = 1050 Anim = OllieNorthBackFootFlip Speed = 1.00000000000 IsExtra UseCurrent } } ] 
Trick_FFImpossible = { Scr = FlipTrick Params = { Name = #"Front Foot Impossible" Score = 525 Anim = FrontFootImposs trickslack = 25 Speed = 1 ExtraTricks = Extra_FFImpossible } } 
Extra_FFImpossible = [ { Trigger_Extra_Flip Params = { Name = #"Dbl. FF Impossible" Score = 1075 Anim = doublefrontfootimposs UseCurrent Speed = 0.89999997616 trickslack = 25 IsExtra } } ] 
Trick_HFVarialLien = { Scr = FlipTrick Params = { Name = #"Heelflip Varial Lien" Score = 800 Anim = HeelflipVarialLien boardrotate trickslack = 15 } } 
Trick_Fingerflip = { Scr = FlipTrick Params = { Name = #"Fingerflip" Score = 700 Anim = FingerFlipVert trickslack = 25 Speed = 1.10000002384 ExtraTricks = Extra_DoubleFingerflip } } 
Extra_DoubleFingerflip = [ { Trigger_Extra_Flip Params = { Name = #"Double Fingerflip" Score = 1000 Anim = DoubleFingerFlipVert Speed = 1.10000002384 trickslack = 25 IsExtra UseCurrent } } ] 
Trick_SalFlip = { Scr = FlipTrick Params = { Name = #"Sal Flip" Score = 900 Anim = SalFlip trickslack = 25 ExtraTricks = Extra_DoubleSalFlip Speed = 1.25000000000 } } 
Extra_DoubleSalFlip = [ { Trigger_Extra_Flip Params = { Name = #"360 Sal Flip" Score = 1150 Anim = DoubleSalFlip boardrotate trickslack = 25 Speed = 1.25000000000 UseCurrent } } ] 
Trick_180Varial = { Scr = FlipTrick Params = { Name = #"180 Varial" Score = 700 Anim = _180Varial boardrotate Speed = 1.14999997616 trickslack = 25 ExtraTricks = Trick_360Varial } } 
Trick_360Varial = [ { Trigger_Extra_Flip Params = { Name = #"360 Varial" Score = 900 Anim = _360Varial Speed = 0.89999997616 trickslack = 25 boardrotate IsExtra UseCurrent } } ] 
Trick_Japan = { Scr = GrabTrick Params = { Name = #"Japan" Score = 350 Anim = JapanAir Idle = JapanAir_Idle ExtraTricks = Trick_OneFootJapan } } 
Trick_OneFootJapan = [ { Trigger_Extra_Grab Params = { Name = #"One Foot Japan" Score = 800 TweakTrick = GRABTWEAK_LARGE Anim = OneFootJapan Speed = 1.29999995232 Idle = OneFootJapan_Idle WaitPercent = 70 IsExtra } } ] 
Trick_Crail = { Scr = GrabTrick Params = { Name = #"Crail Grab" Score = 350 Anim = Crail Idle = Crail_Idle ExtraTricks = Extra_TuckKnee } } 
Extra_TuckKnee = [ { Trigger_Extra_Grab Params = { Name = #"TuckKnee" Score = 400 Anim = TuckKnee IsExtra Idle = TuckKnee_Idle } } ] 
Trick_SaranWrap = { Scr = GrabTrick Params = { Name = #"Wrap Around" Score = 450 TweakTrick = GRABTWEAK_LARGE Anim = SaranWrap Idle = SaranWrap_Idle OutAnim = SaranWrap_Out ExtraTricks = Trick_BetweenTheLegs } } 
Trick_BetweenTheLegs = [ { Trigger_Extra_Grab Params = { Name = #"Body Wrap" Score = 600 TweakTrick = GRABTWEAK_LARGE Anim = BetweenTheLegs_In Idle = BetweenTheLegs_Idle OutAnim = BetweenTheLegs_Out Speed = 1.20000004768 IsExtra } } ] 
Trick_Cannonball = { Scr = GrabTrick Params = { Name = #"Cannonball" Score = 250 TweakTrick = GRABTWEAK_SMALL Anim = Cannonball Idle = Cannonball_Idle Speed = 0.75000000000 ExtraTricks = Extra_CannonballFingerflip } } 
Extra_CannonballFingerflip = [ { Trigger_Extra_Grab Params = { Name = #"Fingerflip Cannonball" Score = 500 TweakTrick = GRABTWEAK_SMALL Anim = Cannonballfingerflip BackwardsAnim = Cannonball Idle = Cannonball_Idle Speed = 1.39999997616 IsExtra } } ] 
Trick_Stalefish = { Scr = GrabTrick Params = { Name = #"Stalefish" Score = 350 Anim = Stalefish Idle = Stalefish_Idle ExtraTricks = Trick_Stalefish_Layback } } 
Trick_Stalefish_Layback = [ { Trigger_Extra_Grab Params = { Name = #"Stalefish Tweak" Score = 400 Anim = Stalefish_Layback Idle = Stalefish_Layback_Idle IsExtra } } ] 
Trick_Benihana = { Scr = GrabTrick Params = { Name = #"Benihana" Score = 300 Anim = Benihana Idle = Benihana_Idle OutAnim = Benihana_Out ExtraTricks = BenihanaFingerflip ForceInit ExtraTricks = Trick_Sacktap } } 
Trick_Sacktap = [ { Trigger_Extra_Grab Params = { Name = #"Sacktap" Score = 1500 Anim = Sacktap_Init Idle = Sacktap_Range OutAnim = Sacktap_out Speed = 1.50000000000 ForceInit trickslack = 20 IsExtra } } ] 
Trick_Crossbone = { Scr = GrabTrick Params = { Name = #"Crossbone" Score = 425 Anim = Crossbone Idle = Crossbone_Idle ExtraTricks = Trick_CrookedCop } } 
Trick_CrookedCop = [ { Trigger_Extra_Grab Params = { Name = #"CrookedCop" Score = 550 Anim = CrookedCop Idle = CrookedCop_Idle IsExtra } } ] 
Trick_Airwalk = { Scr = GrabTrick Params = { Name = #"Airwalk" Score = 450 Anim = Airwalk Idle = Airwalk_Idle2 ExtraTricks = Trick_ChristAir } } 
Trick_ChristAir = [ { Trigger_Extra_Grab Params = { Name = #"Christ Air" Score = 550 Anim = ChristAir_Init Idle = ChristAir_Idle OutAnim = ChristAir_Out ForceInit IsExtra } } ] 
Trick_IndyNosebone = { Scr = GrabTrick Params = { Name = #"Indy Nosebone" Score = 350 Anim = Nosebone Idle = Nosebone_Idle ExtraTricks = Trick_DelMarIndy } } 
Trick_DelMarIndy = [ { Trigger_Extra_Grab Params = { Name = #"Del Mar Indy" Score = 400 Anim = IndyDelMar Idle = IndyDelMar_Idle IsExtra } } ] 
Trick_Tailgrab = { Scr = GrabTrick Params = { Name = #"Tailgrab" Score = 300 Anim = Tailgrab Idle = Tailgrab_Idle ExtraTricks = Trick_OneFootTailgrab } } 
Trick_OneFootTailgrab = [ { Trigger_Extra_Grab Params = { Name = #"One Foot Tailgrab" Score = 500 Anim = OneFootTailgrab Idle = OneFootTailgrab_Idle IsExtra } } ] 
Trick_Madonna = { Scr = GrabTrick Params = { Name = #"Madonna" Score = 750 TweakTrick = GRABTWEAK_EXTRALARGE Anim = Madonna Idle = Madonna_Idle WaitPercent = 70 ExtraTricks = Trick_Judo } } 
Trick_Judo = [ { Trigger_Extra_Grab Params = { Name = #"Judo" Score = 1150 TweakTrick = 50 Anim = JudoGrab Idle = JudoGrab_Idle Speed = 1.00000000000 IsExtra } } ] 
Trick_FSShifty = { Scr = GrabTrick Params = { Name = #"FS Shifty" Score = 500 Anim = Shifty Idle = Shifty_Idle ExtraTricks = Extra_BSShifty } } 
Extra_BSShifty = [ { Trigger_Extra_Grab Params = { Name = #"BS Shifty" Score = 800 Anim = BSShifty Idle = BSShifty_Idle IsExtra } } ] 
Trick_Melon = { Scr = GrabTrick Params = { Name = #"Melon" Score = 300 Anim = MelonGrab Idle = MelonGrab_Idle ExtraTricks = Trick_Method } } 
Trick_Method = [ { Trigger_Extra_Grab Params = { Name = #"Method" Score = 400 Anim = Method Idle = Method_Idle Speed = 1.20000004768 IsExtra } } ] 
Trick_Nosegrab = { Scr = GrabTrick Params = { Name = #"Nosegrab" Score = 300 Anim = Nosegrab Idle = Nosegrab_Idle ExtraTricks = Trick_Rocket } } 
Trick_Rocket = [ { Trigger_Extra_Grab Params = { Name = #"Rocket Air" Score = 400 Anim = RocketAir Idle = RocketAir_Idle IsExtra } } ] 
Trick_Mute = { Scr = GrabTrick Params = { Name = #"Mute" Score = 350 Anim = MuteGrab Idle = MuteGrab_Idle ExtraTricks = Trick_Seatbelt } } 
Trick_Seatbelt = [ { Trigger_Extra_Grab Params = { Name = #"Seatbelt Air" Score = 500 Anim = Seatbelt Idle = SeatBelt_Idle Speed = 0.60000002384 IsExtra } } ] 
Trick_Indy = { Scr = GrabTrick Params = { Name = #"Indy" Score = 300 Anim = Indy Idle = Indy_Idle ExtraTricks = Trick_Stiffy } } 
Trick_Stiffy = [ { Trigger_Extra_Grab Params = { Name = #"Stiffy" Score = 500 Anim = Stiffy Idle = Stiffy_Idle Speed = 1.25000000000 ForceInit IsExtra } } ] 
FireballF = { Scr = FlipTrick Params = { Name = #"\\c4Fire!\\c0" Score = 100 Anim = Heelflip Skew_Angle = 0.00000000000 Fireball ExtraTricks = DoubleFireballF } } 
DoubleFireballF = [ { Trigger = { Press , Square , 300 } Scr = FlipTrick Params = { Name = #"\\c4Double Fire!\\c0" Score = 500 Anim = DoubleHeelflip Skew_Angle = -5.00000000000 Fireball ExtraTricks = TripleFireballF IsExtra trickslack = 15 UseCurrent } } ] 
TripleFireballF = [ { Trigger = { Press , Square , 300 } Scr = FlipTrick Params = { Name = #"\\c4Triple Fire!\\c0" Score = 1000 Anim = TripleHeelflip Skew_Angle = 5.00000000000 Fireball ExtraTricks = QuadFireballF IsExtra UseCurrent } } ] 
QuadFireballF = [ { Trigger = { Press , Square , 300 } Scr = FlipTrick Params = { Name = #"\\c4Quad Fire!\\c0" Score = 2000 Anim = QuadrupleHeelFlip Skew_Angle = 10.00000000000 Fireball IsExtra Speed = 1 UseCurrent } } ] 
FireballB = { Scr = FlipTrick Params = { Name = #"\\c4Reverse Fire!\\c0" Score = 100 Anim = Heelflip Skew_Angle = 180.00000000000 vel_scale = 0.50000000000 Fireball ExtraTricks = DoubleFireballB } } 
DoubleFireballB = [ { Trigger = { Press , Square , 300 } Scr = FlipTrick Params = { Name = #"\\c4Double Reverse Fire!\\c0" Score = 500 Skew_Angle = 185.00000000000 vel_scale = 0.50000000000 Fireball Anim = DoubleHeelflip ExtraTricks = TripleFireballB IsExtra UseCurrent } } ] 
TripleFireballB = [ { Trigger = { Press , Square , 300 } Scr = FlipTrick Params = { Name = #"\\c4Triple Reverse Fire!\\c0" Score = 1000 Skew_Angle = 175.00000000000 vel_scale = 0.50000000000 Fireball Anim = TripleHeelflip ExtraTricks = QuadFireballB IsExtra UseCurrent } } ] 
QuadFireballB = [ { Trigger = { Press , Square , 300 } Scr = FlipTrick Params = { Name = #"\\c4Quad Reverse Fire!\\c0" Score = 2000 Skew_Angle = 190.00000000000 vel_scale = 0.50000000000 Fireball Anim = QuadrupleHeelFlip IsExtra UseCurrent } } ] 
Trick_Revert = { Scr = Revert } 
AirTricks = 
[ 
	{ Trigger = { TripleInOrder , a = Left , b = Left , Square , 300 } TrickSlot = Air_L_L_Square } 
	{ Trigger = { TripleInOrder , a = Right , b = Right , Square , 300 } TrickSlot = Air_R_R_Square } 
	{ Trigger = { TripleInOrder , a = Up , b = Up , Square , 300 } TrickSlot = Air_U_U_Square } 
	{ Trigger = { TripleInOrder , a = Down , b = Down , Square , 300 } TrickSlot = Air_D_D_Square } 
	{ Trigger = { AirTrickLogic , Square , UpLeft , 500 } TrickSlot = Air_SquareUL } 
	{ Trigger = { AirTrickLogic , Square , UpRight , 500 } TrickSlot = Air_SquareUR } 
	{ Trigger = { AirTrickLogic , Square , DownLeft , 500 } TrickSlot = Air_SquareDL } 
	{ Trigger = { AirTrickLogic , Square , DownRight , 500 } TrickSlot = Air_SquareDR } 
	{ Trigger = { AirTrickLogic , Square , Up , 500 } TrickSlot = Air_SquareU } 
	{ Trigger = { AirTrickLogic , Square , Down , 500 } TrickSlot = Air_SquareD } 
	{ Trigger = { AirTrickLogic , Square , Left , 500 } TrickSlot = Air_SquareL } 
	{ Trigger = { AirTrickLogic , Square , Right , 500 } TrickSlot = Air_SquareR } 
	{ Trigger = { TripleInOrder , a = Left , b = Left , Circle , 300 } TrickSlot = Air_L_L_Circle } 
	{ Trigger = { TripleInOrder , a = Right , b = Right , Circle , 300 } TrickSlot = Air_R_R_Circle } 
	{ Trigger = { TripleInOrder , a = Up , b = Up , Circle , 300 } TrickSlot = Air_U_U_Circle } 
	{ Trigger = { TripleInOrder , a = Down , b = Down , Circle , 300 } TrickSlot = Air_D_D_Circle } 
	{ Trigger = { AirTrickLogic , Circle , UpLeft , 500 } TrickSlot = Air_CircleUL } 
	{ Trigger = { AirTrickLogic , Circle , UpRight , 500 } TrickSlot = Air_CircleUR } 
	{ Trigger = { AirTrickLogic , Circle , DownLeft , 500 } TrickSlot = Air_CircleDL } 
	{ Trigger = { AirTrickLogic , Circle , DownRight , 500 } TrickSlot = Air_CircleDR } 
	{ Trigger = { AirTrickLogic , Circle , Up , 500 } TrickSlot = Air_CircleU } 
	{ Trigger = { AirTrickLogic , Circle , Down , 500 } TrickSlot = Air_CircleD } 
	{ Trigger = { AirTrickLogic , Circle , Right , 500 } TrickSlot = Air_CircleR } 
	{ Trigger = { AirTrickLogic , Circle , Left , 500 } TrickSlot = Air_CircleL } 
] 
SCRIPT ToTail 
	IF NOT InVertAir 
		RestoreEvents UsedBy = Regular Duration = 200 
		Goto AirBorne 
	ENDIF 
	OnExitRun ToTail_Cleanup 
	NoRailTricks 
	PlayAnim Anim = ToTail_In Speed = 1.25000000000 
	BEGIN 
		IF Released Triangle 
			IF AnimEquals ToTail_Idle 
				PlayAnim Anim = ToTail_Out 
			ELSE 
				PlayAnim Anim = ToTail_In From = Current To = Start 
			ENDIF 
			BREAK 
		ELSE 
			IF AnimEquals ToTail_In 
				IF AnimFinished 
					PlayAnim Anim = ToTail_Idle Cycle 
				ENDIF 
			ENDIF 
		ENDIF 
		IF Held R1 
			Rotate x = 5 Duration = 0.10000000149 
		ENDIF 
		DoNextTrick 
		Wait 1 game frame 
	REPEAT 
	WaitAnimWhilstChecking 
	Goto AirBorne 
ENDSCRIPT

SCRIPT ToTail_Cleanup 
	printf "Cleanup" 
	AllowRailTricks 
	CanSpin 
ENDSCRIPT

SkateToWalkTricks = [ 
	{ SwitchControl_Trigger Scr = CheckforSwitchVehicles } 
] 
Trigger_Extra_Grab_Tweak = { Trigger = { ExtraGrabTrickLogic , Circle , 300 } Scr = GrabTrick } 
Trigger_Extra_Grab = { Trigger = { Press , Circle , 300 } Scr = GrabTrick } 
Trigger_Extra_Flip = { Trigger = { Press , Square , 300 } Scr = FlipTrick } 
KickflipExtras = 
[ { Trigger = { Press , Square , 300 } Scr = FlipTrick Params = { Name = #"Double Kickflip" Score = 500 Anim = DoubleKickflip ExtraTricks = TripleKickflip Speed = 1 IsExtra UseCurrent } } 
	{ Trigger = { Press , Circle , 300 } Scr = FlipGrabBlend Params = { Name = #"Kickflip to Indy" Score = 400 Anim1 = KickFlipBlendFS Anim2 = Indy IsExtra } } 
	{ Trigger = { AirTrickLogic , Circle , Up , 300 } Scr = FlipGrabBlend Params = { Name = #"Kickflip to Crail" Score = 400 Anim1 = KickFlipBlendFS Anim2 = Crail IsExtra GrabStart = 5 Speed = 1 } } 
] 
BenihanaFingerflip = 
[ { Trigger = { AirTrickLogic , Square , Up , 500 } Scr = FlipTrick Params = { Name = #"Beni Fingerflip" Score = 1000 Anim = BenihanaFingerflip IsExtra } } ] 
COOL_SPECIAL_TRICKS = 0 
SCRIPT FlipTrick Speed = 1.00000000000 trickslack = 10 grindslack = 25 flip_stat_mod = 1.00000000000 
	IF GotParam Fireball 
		IF GameModeEquals is_firefight 
			IF HasPowerup Fireball 
				LaunchFireball Skew_Angle = <Skew_Angle> vel_scale = <vel_scale> 
			ENDIF 
		ENDIF 
	ENDIF 
	LaunchStateChangeEvent State = Skater_InAir 
	LaunchSubStateEntryEvent SubState = Flip 
	OnExitRun ExitFlipTrick 
	IF GotParam FullScreenEffect 
		<FullScreenEffect> 
		OnExitRun ExitFliptrick_FullScreenEffect 
	ENDIF 
	GetScriptedStat Skater_Flip_Speed_Stat 
	Speed = ( <Speed> * <stat_value> ) 
	IF GotParam maxspeed 
		IF ( <Speed> > <maxspeed> ) 
			<Speed> = <maxspeed> 
		ENDIF 
	ELSE 
		IF ( <Speed> > 1.29999995232 ) 
			Speed = 1.29999995232 
		ENDIF 
	ENDIF 
	ClearTricksFrom Jumptricks Jumptricks0 Jumptricks 
	IF GotParam FromGroundGone 
		SetEventHandler Ex = Ollied Scr = TrickOllie 
	ELSE 
		ClearException Ollied 
	ENDIF 
	KillExtraTricks 
	BailOn 
	IF InPressure 
		PressureOff 
		SetSkaterAirTricks 
	ENDIF 
	IF GotParam NoSpin 
		NoSpin 
	ENDIF 
	IF GotParam RevertFS 
		Obj_SetFlag FLAG_SKATER_REVERTFS 
	ENDIF 
	IF GotParam RevertBS 
		Obj_SetFlag FLAG_SKATER_REVERTBS 
	ENDIF 
	IF InNollie 
		IF GotParam Nollie 
			IF GotParam IsExtra 
				PlayAnim Anim = <Nollie> From = Current BlendPeriod = 0.20000000298 Speed = <Speed> 
			ELSE 
				PlayAnim Anim = <Nollie> BlendPeriod = 0.20000000298 Speed = <Speed> 
			ENDIF 
		ELSE 
			IF GotParam IsExtra 
				PlayAnim Anim = <Anim> From = Current BlendPeriod = 0.20000000298 Speed = <Speed> 
			ELSE 
				PlayAnim Anim = <Anim> BlendPeriod = 0.20000000298 Speed = <Speed> 
			ENDIF 
		ENDIF 
	ELSE 
		IF GotParam UseCurrent 
			printf "USING THE CURRENT FRAME" 
			PlayAnim Anim = <Anim> From = Current BlendPeriod = 0.20000000298 Speed = <Speed> 
		ELSE 
			PlayAnim Anim = <Anim> BlendPeriod = 0.20000000298 Speed = <Speed> 
		ENDIF 
	ENDIF 
	IF NOT GotParam HoldFrame 
		IF GotParam boardrotate 
			BlendperiodOut 0 
			BoardRotateAfter 
		ENDIF 
		IF GotParam RotateAfter 
			BlendperiodOut 0 
			RotateAfter 
		ENDIF 
		IF GotParam FlipAfter 
			BlendperiodOut 0 
			FlipAfter 
		ENDIF 
	ENDIF 
	IF GotParam ExtraTricks 
		SetExtraTricks tricks = <ExtraTricks> Duration = 14 
	ENDIF 
	IF GotParam FromGroundGone 
		WaitFramesLateOllie Frames = 15 
		ClearException Ollied 
		IF NOT ( <Frames> = 0 ) 
			Wait <Frames> Frames 
		ENDIF 
	ELSE 
		Wait 15 Frames 
	ENDIF 
	NollieOff 
	SetTrickName <Name> 
	SetTrickScore <Score> 
	Display 
	IF GotParam IsExtra 
		LaunchExtraMessage 
	ENDIF 
	IF GotParam IsSpecial 
		LaunchSpecialMessage Cool 
	ENDIF 
	IF GotParam BloodFrame 
		Wait <BloodFrame> Frames 
		IF GotParam GutsSound 
			Playsound RANDOM(1, 1, 1) RANDOMCASE hitblood01 RANDOMCASE hitblood02 RANDOMCASE hitblood03 RANDOMEND 
		ELSE 
			Obj_PlaySound RANDOM(1, 1, 1) RANDOMCASE BailSlap01 RANDOMCASE BailSlap02 RANDOMCASE BailSlap03 RANDOMEND 
		ENDIF 
		Bloodsplat 
		Obj_SpawnScript BloodJackAss 
		Wait 1 frame 
		Playsound BailSlap02 
	ENDIF 
	IF GotParam Spinslack 
		WaitAnim <Spinslack> Frames fromend 
		CanSpin 
	ENDIF 
	IF GotParam HoldFrame 
		HoldAbleFlipTrick <...> 
	ENDIF 
	IF GotParam grindslack 
		WaitAnim <grindslack> Frames fromend 
	ENDIF 
	Bailoff 
	WaitAnim <trickslack> Frames fromend 
	IF GotParam IsSpecial 
		EndSpecial 
	ENDIF 
	CanSpin 
	DoNextTrick 
	WaitAnimWhilstChecking 
	Goto AirBorne 
ENDSCRIPT

SCRIPT HoldAbleFlipTrick 
	WaitAnim <HoldFrame> Frames fromend 
	BEGIN 
		IF Released Circle 
			IF Released Square 
				BREAK 
			ENDIF 
		ENDIF 
		PlayAnim Anim = <Anim> From = Current To = Current BlendPeriod = 0.00000000000 
		WaitOneGameFrame 
		TweakTrick GRABTWEAK_MEDIUM 
	REPEAT 
	PlayAnim Anim = <Anim> From = Current 
	IF GotParam boardrotate 
		BlendperiodOut 0 
		BoardRotateAfter 
	ENDIF 
	IF GotParam RotateAfter 
		BlendperiodOut 0 
		RotateAfter 
	ENDIF 
	IF GotParam FlipAfter 
		BlendperiodOut 0 
		FlipAfter 
	ENDIF 
ENDSCRIPT

SCRIPT Shifty_Check 
	Wait 10 Frames 
	IF Held Triangle 
		Rotate y = -75 Duration = 0.20000000298 seconds 
		Wait 0.20000000298 seconds 
		BEGIN 
			Wait 1 frame 
			TweakTrick 10 
			IF Released Square 
				BREAK 
			ENDIF 
		REPEAT 
		Rotate y = 75 Duration = 0.20000000298 seconds 
		DoNextTrick 
	ENDIF 
ENDSCRIPT

SCRIPT ExitFlipTrick 
	LaunchSubStateExitEvent SubState = Flip 
	CleanUp_SpecialTrickParticles 
ENDSCRIPT

SCRIPT ExitFliptrick_FullScreenEffect 
	Exit_FullscreenEffect 
	ExitFlipTrick 
ENDSCRIPT

SCRIPT GrabTrick Speed = 1.00000000000 x = -180 Duration = 1.00000000000 GrabTweak = GRABTWEAK_MEDIUM WaitPercent = 60 button = Circle 
	ClearTricksFrom Jumptricks Jumptricks0 Jumptricks 
	KillExtraTricks 
	ClearExtraGrindTrick 
	IF GotParam FromGroundGone 
		SetEventHandler Ex = Ollied Scr = TrickOllie 
	ELSE 
		ClearException Ollied 
	ENDIF 
	BailOn 
	LaunchStateChangeEvent State = Skater_InAir 
	LaunchSubStateEntryEvent SubState = Grab 
	OnExitRun ExitGrabTrick 
	IF GotParam FullScreenEffect 
		<FullScreenEffect> 
		OnExitRun ExitGrab_FullScreenEffect 
	ENDIF 
	IF GotParam SpecialSounds 
		Obj_SpawnScript <SpecialSounds> 
	ENDIF 
	IF GotParam ExtraTricks 
		SetExtraTricks tricks = <ExtraTricks> Duration = 15 
	ENDIF 
	IF GotParam SpecialItem_details 
		TurnOnSpecialItem SpecialItem_details = <SpecialItem_details> 
	ENDIF 
	IF GotParam IsExtra 
		PlayAnim Anim = <Anim> BlendPeriod = 0.30000001192 From = Current To = end Speed = <Speed> 
	ELSE 
		PlayAnim Anim = <Anim> BlendPeriod = 0.30000001192 Speed = <Speed> 
	ENDIF 
	IF GotParam JumpJets 
		Obj_KillSpawnedScript Name = JumpJets 
		Obj_SpawnScript JumpJets 
	ENDIF 
	IF GotParam Stream 
		Obj_PlayStream <Stream> 
	ENDIF 
	IF GotParam BloodFrame 
		Wait <BloodFrame> Frames 
		IF GotParam GutsSound 
			Playsound RANDOM(1, 1, 1) RANDOMCASE hitblood01 RANDOMCASE hitblood02 RANDOMCASE hitblood03 RANDOMEND 
		ELSE 
			Obj_PlaySound RANDOM(1, 1, 1) RANDOMCASE BailSlap01 RANDOMCASE BailSlap02 RANDOMCASE BailSlap03 RANDOMEND 
		ENDIF 
		Bloodsplat 
		Obj_SpawnScript BloodJackAss 
		Wait 1 frame 
		Playsound BailSlap02 
	ENDIF 
	IF GotParam FromGroundGone 
		WaitFramesLateOllie Frames = 15 
		ClearException Ollied 
	ENDIF 
	WaitAnim 50 percent 
	SetTrickName <Name> 
	SetTrickScore <Score> 
	Display 
	IF GotParam IsSpecial 
		LaunchSpecialMessage Cool 
	ENDIF 
	IF GotParam IsExtra 
		LaunchExtraMessage 
	ENDIF 
	IF GotParam ForceInit 
		WaitAnimFinished 
	ELSE 
		WaitAnim <WaitPercent> percent 
	ENDIF 
	IF NOT Held Circle 
		IF Held Square 
			button = Square 
		ENDIF 
	ENDIF 
	BEGIN 
		IF Released <button> 
			BREAK 
		ENDIF 
		IF AnimFinished 
			PlayAnim Anim = <Idle> Cycle Speed = <Speed> 
			BREAK 
		ENDIF 
		WaitOneGameFrame 
	REPEAT 
	BEGIN 
		IF Released <button> 
			IfReleased_SquareOrCircle <...> 
			BREAK 
		ENDIF 
		WaitOneGameFrame 
		IF GotParam IsSpecial 
			TweakTrick GRABTWEAK_SPECIAL 
		ELSE 
			TweakTrick <GrabTweak> 
		ENDIF 
	REPEAT 
	IF GotParam boardrotate 
		BlendperiodOut 0 
		BoardRotateAfter 
	ENDIF 
	IF GotParam trickslack 
		WaitAnim <trickslack> Frames fromend 
	ENDIF 
	Bailoff 
	IF GotParam IsSpecial 
		EndSpecial 
	ENDIF 
	IF GotParam FlipAfter 
		FlipAfter 
		BlendperiodOut 0 
	ENDIF 
	IF GotParam RotateAfter 
		BlendperiodOut 0 
		RotateAfter 
	ENDIF 
	WaitAnimWhilstChecking 
	Goto AirBorne 
ENDSCRIPT

SCRIPT ExitGrabTrick 
	LaunchSubStateExitEvent SubState = Grab 
	CleanUp_SpecialTrickParticles 
ENDSCRIPT

SCRIPT ExitGrab_FullScreenEffect 
	Exit_FullscreenEffect 
	ExitGrabTrick 
ENDSCRIPT

SCRIPT IfReleased_SquareOrCircle 
	IF GotParam OutAnim 
		Obj_PlayAnim Anim = <OutAnim> BlendPeriod = 0.20000000298 Speed = <Speed> 
	ELSE 
		IF GotParam BackwardsAnim 
			Obj_PlayAnim Anim = <BackwardsAnim> Backwards BlendPeriod = 0.20000000298 Speed = <Speed> 
		ELSE 
			IF AnimEquals Airwalk 
				Obj_PlayAnim Anim = <Anim> From = Current To = 0 BlendPeriod = 0.20000000298 Speed = <Speed> 
			ELSE 
				Obj_PlayAnim Anim = <Anim> Backwards BlendPeriod = 0.20000000298 Speed = <Speed> 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT JumpJets 
	ReplayRecordSimpleScriptCall scriptname = _ReplayJumpJets skaterscript 
	Obj_GetID 
	MangleChecksums a = skatersplash b = <objId> 
	IF NOT Obj_FlagSet FLAG_SKATER_JUMPJETSON 
		IF NOT InNetGame 
			IF NOT GameModeEquals Is_SingleSession 
				BEGIN 
					Skater : Jump 
					Wait 1 game frame 
				REPEAT 2 
				Obj_SpawnScript JumpJetTracker Params = { <...> } 
			ENDIF 
		ENDIF 
	ENDIF 
	EmptyParticleSystem Name = <mangled_id> 
	SetScript Name = <mangled_id> emitscript = emit_jumpjets 
	ParticlesOn Name = <mangled_id> 
	Wait 0.50000000000 second 
	ParticlesOff Name = <mangled_id> 
	Wait 0.50000000000 seconds 
	SetScript Name = <mangled_id> emitscript = emit_skatersplash 
ENDSCRIPT

SCRIPT JumpJetTracker 
	Obj_SetFlag FLAG_SKATER_JUMPJETSON 
	Wait 2 seconds 
	Obj_ClearFlag FLAG_SKATER_JUMPJETSON 
ENDSCRIPT

SCRIPT _ReplayJumpJets 
	SpawnSkaterScript ReplayJumpJets 
ENDSCRIPT

SCRIPT ReplayJumpJets 
	Obj_GetID 
	MangleChecksums a = skatersplash b = <objId> 
	EmptyParticleSystem Name = <mangled_id> 
	SetScript Name = <mangled_id> emitscript = emit_jumpjets 
	ParticlesOn Name = <mangled_id> 
	Wait 0.50000000000 second 
	ParticlesOff Name = <mangled_id> 
	Wait 0.50000000000 seconds 
	SetScript Name = <mangled_id> emitscript = emit_skatersplash 
ENDSCRIPT


