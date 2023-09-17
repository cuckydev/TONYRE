
SCRIPT GetAnimEventTableName 
	animEventTableName = PedAnimEventTable 
	SWITCH <animName> 
		CASE animload_anl_dog 
			<animEventTableName> = DogAnimEventTable 
	ENDSWITCH 
	RETURN animEventTableName = <animEventTableName> 
ENDSCRIPT

SkaterAnimEventTable = { 
	runfromidle = [ 
		{ time = 0.01999999955 event = FootstepScuffSoundEffect } 
	] 
	run = [ 
		{ time = 0.01999999955 event = FootstepRunSoundEffect } 
		{ time = 0.34999999404 event = FootstepRunSoundEffect } 
	] 
	runtoidle = [ 
		{ time = 0.05000000075 event = FootstepScuffSoundEffect } 
		{ time = 0.25000000000 event = FootstepWalkSoundEffect } 
	] 
	run1 = [ 
		{ time = 0.01999999955 event = FootstepRunSoundEffect } 
		{ time = 0.34999999404 event = FootstepRunSoundEffect } 
	] 
	runjumpidle = [ 
		{ time = 0.01999999955 event = FootstepRunSoundEffect } 
		{ time = 0.34999999404 event = FootstepRunSoundEffect } 
		{ time = 0.66000002623 event = FootstepRunSoundEffect } 
	] 
	runjumpland = [ 
		{ time = 0.01999999955 event = FootstepRunSoundEffect } 
		{ time = 0.34999999404 event = FootstepRunSoundEffect } 
		{ time = 0.66000002623 event = FootstepRunSoundEffect } 
	] 
	bigjumplandtostand = [ 
		{ time = 0.05999999866 event = FootstepLandSoundEffect } 
		{ time = 1.39999997616 event = FootstepScuffSoundEffect } 
	] 
	bigjumplandtorun = [ 
		{ time = 0.05999999866 event = FootstepLandSoundEffect } 
		{ time = 0.30000001192 event = FootstepScuffSoundEffect } 
		{ time = 0.69999998808 event = FootstepRunSoundEffect } 
	] 
	hangontothetop = [ 
		{ time = 1.10000002384 event = FootstepWalkSoundEffect } 
		{ time = 1.70000004768 event = FootstepWalkSoundEffect } 
		{ time = 2.09999990463 event = FootstepScuffSoundEffect } 
	] 
	jumplandtorun = [ 
		{ time = 0.11999999732 event = FootstepLandSoundEffect } 
	] 
	jumplandtostand = [ 
		{ time = 0.01999999955 event = FootstepLandSoundEffect } 
		{ time = 0.50000000000 event = FootstepScuffSoundEffect } 
	] 
	ladderclimb = [ 
		{ time = 0.17000000179 event = FootstepWalkSoundEffect } 
		{ time = 0.69999998808 event = FootstepWalkSoundEffect } 
	] 
	ladderclimbfromstandidle = [ 
		{ time = 0.01999999955 event = FootstepScuffSoundEffect } 
		{ time = 0.50000000000 event = FootstepWalkSoundEffect } 
	] 
	ladderontothetop = [ 
		{ time = 0.30000001192 event = FootstepWalkSoundEffect } 
		{ time = 0.80000001192 event = FootstepWalkSoundEffect } 
		{ time = 1.39999997616 event = FootstepScuffSoundEffect } 
	] 
	runtojump = [ 
		{ time = 0.01999999955 event = FootstepJumpSoundEffect } 
	] 
	standtohang = [ 
		{ time = 0.30000001192 event = FootstepScuffSoundEffect } 
	] 
	standtojump = [ 
		{ time = 0.02999999933 event = FootstepJumpSoundEffect } 
	] 
	standturnleft = [ 
		{ time = 0.01999999955 event = FootstepScuffSoundEffect } 
	] 
	standturnright = [ 
		{ time = 0.05000000075 event = FootstepScuffSoundEffect } 
	] 
	newbraketurnleft = [ 
		{ time = 0.00999999978 event = FootstepScuffSoundEffect } 
	] 
	newbraketurnright = [ 
		{ time = 0.00999999978 event = FootstepScuffSoundEffect } 
	] 
	_180runskid = [ 
		{ time = 0.01999999955 event = FootstepRunSoundEffect } 
		{ time = 0.34999999404 event = FootstepScuffSoundEffect } 
		{ time = 0.85000002384 event = FootstepWalkSoundEffect } 
	] 
	skatetostand = [ 
		{ time = 0.01999999955 event = SoundEffect params = { name = FlipTransitionUp01 } } 
		{ time = 0.41999998689 event = FootstepRunSoundEffect } 
		{ time = 0.75000000000 event = FootstepRunSoundEffect } 
		{ time = 1.29999995232 event = FootstepWalkSoundEffect } 
		{ time = 1.50000000000 event = FootstepScuffSoundEffect } 
	] 
	skatetowalk = [ 
		{ time = 0.01999999955 event = SoundEffect params = { name = FlipTransitionUp01 } } 
		{ time = 0.41999998689 event = FootstepRunSoundEffect } 
		{ time = 0.75000000000 event = FootstepWalkSoundEffect } 
	] 
	braketostand = [ 
		{ time = 0.44999998808 event = SoundEffect params = { name = FlipTransitionUp01 } } 
	] 
	slowskatetostand = [ 
		{ time = 0.01999999955 event = SoundEffect params = { name = FlipTransitionUp01 } } 
		{ time = 0.30000001192 event = FootstepRunSoundEffect } 
		{ time = 0.69999998808 event = FootstepWalkSoundEffect } 
		{ time = 1.39999997616 event = FootstepScuffSoundEffect } 
	] 
	walkslow = [ 
		{ time = 0.01999999955 event = FootstepWalkSoundEffect } 
		{ time = 0.51999998093 event = FootstepWalkSoundEffect } 
	] 
	grindnbarf_init = [ 
		{ time = 1.00000000000 event = GenericParticles params = { specialtrick_particles = barf_particles bone = Bone_Jaw dont_orient_toskater = 1 StopEmitAt = 0.20000000298 } } 
	] 
	primohandstand_init = [ 
		{ time = 0.50000000000 event = GenericParticles params = { specialtrick_particles = fire_particles bone = Bone_Board_Root } } 
	] 
	flames_init = [ 
		{ time = 0.10000000149 event = GenericParticles params = { specialtrick_particles = firebreath_particles bone = Bone_Jaw StopEmitAt = 0.40000000596 } } 
		{ time = 0.60000002384 event = GenericParticles params = { specialtrick_particles = fire_particles bone = Bone_Board_Root } } 
	] 
	BlastGrind_Init = [ 
		{ time = 0.80000001192 event = IronParticles } 
	] 
	bootburst_init = [ 
		{ time = 0.50000000000 event = GenericParticles params = { specialtrick_particles = fire_particles bone = Bone_Ankle_R dont_orient_toskater = 1 } } 
	] 
	walkfast = [ 
		{ time = 0.01999999955 event = FootstepWalkSoundEffect } 
		{ time = 0.40000000596 event = FootstepWalkSoundEffect } 
	] 
	fastrun = [ 
		{ time = 0.01999999955 event = FootstepRunSoundEffect } 
		{ time = 0.33000001311 event = FootstepRunSoundEffect } 
	] 
	wrun = [ 
		{ time = 0.01999999955 event = FootstepRunSoundEffect } 
		{ time = 0.34999999404 event = FootstepRunSoundEffect } 
	] 
	wruntoskate = [ 
		{ time = 0.01999999955 event = FootstepRunSoundEffect } 
		{ time = 0.34999999404 event = FootstepRunSoundEffect } 
		{ time = 0.51999998093 event = TurnOnSkaterLoopingSound } 
		{ time = 0.51999998093 event = SoundEffect params = { name = FlipTransitionDown01 } } 
	] 
	wskatetorun = [ 
		{ time = 0.01999999955 event = SoundEffect params = { name = FlipTransitionUp01 } } 
		{ time = 0.41999998689 event = FootstepRunSoundEffect } 
		{ time = 0.75000000000 event = FootstepRunSoundEffect } 
	] 
	wstandtorun = [ 
		{ time = 0.01999999955 event = FootstepScuffSoundEffect } 
	] 
	wstandtowalk = [ 
		{ time = 0.01999999955 event = FootstepScuffSoundEffect } 
	] 
	wwalk = [ 
		{ time = 0.01999999955 event = FootstepWalkSoundEffect } 
		{ time = 0.51999998093 event = FootstepWalkSoundEffect } 
	] 
	wwalktostand = [ 
		{ time = 0.05000000075 event = FootstepWalkSoundEffect } 
		{ time = 0.44999998808 event = FootstepScuffSoundEffect } 
	] 
	wallplant_ollie = [ 
		{ time = 0.01999999955 event = FootstepWalkSoundEffect } 
	] 
	wallplant_ollie2 = [ 
		{ time = 0.01999999955 event = FootstepLandSoundEffect } 
	] 
	wallplant_ollie3 = [ 
		{ time = 0.01999999955 event = FootstepWalkSoundEffect } 
	] 
	wallplant_ollie3_flip = [ 
		{ time = 0.01999999955 event = FootstepLandSoundEffect } 
	] 
	wallplant_out = [ 
		{ time = 0.01999999955 event = FootstepLandSoundEffect } 
	] 
	jumpairto5050 = [ 
		{ time = 0.21999999881 event = SoundEffect params = { name = FlipTransitionDown01 } } 
		{ time = 0.34999999404 event = TerrainLandSound } 
		{ time = 0.37999999523 event = TurnOnSkaterLoopingSound } 
	] 
	jumpairtomanual = [ 
		{ time = 0.30000001192 event = SoundEffect params = { name = FlipTransitionDown01 } } 
		{ time = 0.55000001192 event = TurnOnSkaterLoopingSound } 
	] 
	facesmash_resume = [ 
		{ time = 0.89999997616 event = FootstepScuffSoundEffect } 
		{ time = 0.93999999762 event = FootstepScuffSoundEffect } 
		{ time = 1.39999997616 event = FootstepWalkSoundEffect } 
		{ time = 1.50000000000 event = FootstepWalkSoundEffect } 
	] 
	fallback = [ 
		{ time = 0.00999999978 event = BailBoardSoundEffect } 
		{ time = 0.50000000000 event = BailBodyFallSoundEffect } 
		{ time = 0.36000001431 event = BailBodyPunchSoundEffect } 
		{ time = 0.40000000596 event = BailSlapSoundEffect } 
	] 
	fallback_resume = [ 
		{ time = 0.37999999523 event = FootstepScuffSoundEffect } 
		{ time = 0.44999998808 event = FootstepScuffSoundEffect } 
		{ time = 0.92000001669 event = FootstepWalkSoundEffect } 
		{ time = 1.16999995708 event = FootstepWalkSoundEffect } 
	] 
	slipbackwards = [ 
		{ time = 0.00999999978 event = BailBoardSoundEffect } 
		{ time = 0.40000000596 event = BailBodyFallSoundEffect } 
		{ time = 0.37999999523 event = BailBodyPunchSoundEffect } 
	] 
	kneeslide = [ 
		{ time = 0.00999999978 event = BailBoardSoundEffect } 
		{ time = 0.46999999881 event = BailScrapeSoundEffect } 
		{ time = 0.43000000715 event = BailBodyPunchSoundEffect } 
	] 
	nutterfallbackward = [ 
		{ time = 0.00999999978 event = BailBoardSoundEffect } 
		{ time = 0.34000000358 event = BailCrackSoundEffect } 
		{ time = 0.56000000238 event = BailBodyPunchSoundEffect } 
		{ time = 0.60000002384 event = BailBodyFallSoundEffect } 
	] 
	kneeslide_resume = [ 
		{ time = 0.76999998093 event = FootstepWalkSoundEffect } 
		{ time = 1.16999995708 event = FootstepWalkSoundEffect } 
	] 
	slipforwards = [ 
		{ time = 0.00999999978 event = BailBoardSoundEffect } 
		{ time = 0.34999999404 event = BailBodyFallSoundEffect } 
		{ time = 0.57999998331 event = BailBodyPunchSoundEffect } 
		{ time = 0.60000002384 event = BailSlapSoundEffect } 
	] 
	fiftyfiftyfallbackward = [ 
		{ time = 0.00999999978 event = BailBoardSoundEffect } 
		{ time = 0.40000000596 event = BailBodyFallSoundEffect } 
		{ time = 0.37999999523 event = BailBodyPunchSoundEffect } 
		{ time = 1.00000000000 event = BailSlapSoundEffect } 
	] 
	fiftyfiftyfallforward = [ 
		{ time = 0.00999999978 event = BailBoardSoundEffect } 
		{ time = 0.37999999523 event = BailBodyPunchSoundEffect } 
		{ time = 0.36000001431 event = BailScrapeSoundEffect } 
		{ time = 1.14999997616 event = FootstepLandSoundEffect } 
		{ time = 1.14999997616 event = BailBodyFallSoundEffect } 
	] 
	nutterfallforward = [ 
		{ time = 0.00999999978 event = BailBoardSoundEffect } 
		{ time = 0.30000001192 event = BailCrackSoundEffect } 
		{ time = 0.56000000238 event = BailBodyPunchSoundEffect } 
		{ time = 0.60000002384 event = BailBodyFallSoundEffect } 
	] 
	backwardstest = [ 
		{ time = 0.00999999978 event = BailBoardSoundEffect } 
		{ time = 0.30000001192 event = FootstepRunSoundEffect } 
		{ time = 0.30000001192 event = FootstepScuffSoundEffect } 
		{ time = 0.69999998808 event = FootstepRunSoundEffect } 
		{ time = 0.69999998808 event = FootstepScuffSoundEffect } 
		{ time = 1.25000000000 event = BailBodyPunchSoundEffect } 
		{ time = 1.25000000000 event = BailBodyFallSoundEffect } 
		{ time = 1.33000004292 event = BailSlapSoundEffect } 
	] 
	facefall = [ 
		{ time = 0.00999999978 event = BailBoardSoundEffect } 
	] 
	facefallsmallhit = [ 
		{ time = 0.01999999955 event = BailBodyPunchSoundEffect } 
		{ time = 0.05999999866 event = BailSlapSoundEffect } 
	] 
	facefallbighit = [ 
		{ time = 0.01999999955 event = BailBodyPunchSoundEffect } 
		{ time = 0.05999999866 event = BailSlapSoundEffect } 
		{ time = 0.01999999955 event = BailBodyFallSoundEffect } 
	] 
	facefallresume = [ 
		{ time = 1.00000000000 event = FootstepWalkSoundEffect } 
	] 
	backwardfaceslam = [ 
		{ time = 0.00999999978 event = BailBoardSoundEffect } 
		{ time = 0.37999999523 event = BailBodyPunchSoundEffect } 
		{ time = 0.43000000715 event = BailSlapSoundEffect } 
	] 
	getupbackwards = [ 
		{ time = 0.30000001192 event = FootstepScuffSoundEffect } 
		{ time = 0.37000000477 event = FootstepScuffSoundEffect } 
		{ time = 0.87000000477 event = FootstepRunSoundEffect } 
		{ time = 0.87999999523 event = FootstepScuffSoundEffect } 
		{ time = 0.93999999762 event = FootstepRunSoundEffect } 
		{ time = 1.39999997616 event = FootstepWalkSoundEffect } 
		{ time = 1.79999995232 event = FootstepWalkSoundEffect } 
	] 
	getupforwards = [ 
		{ time = 0.15000000596 event = FootstepScuffSoundEffect } 
		{ time = 0.50000000000 event = FootstepRunSoundEffect } 
		{ time = 1.10000002384 event = FootstepWalkSoundEffect } 
		{ time = 1.50000000000 event = FootstepWalkSoundEffect } 
	] 
	getupfacing = [ 
		{ time = 0.69999998808 event = FootstepScuffSoundEffect } 
		{ time = 1.20000004768 event = FootstepWalkSoundEffect } 
		{ time = 1.50000000000 event = FootstepWalkSoundEffect } 
	] 
	getupfacesmash = [ 
		{ time = 0.94999998808 event = FootstepRunSoundEffect } 
		{ time = 0.97000002861 event = FootstepScuffSoundEffect } 
		{ time = 1.00000000000 event = FootstepRunSoundEffect } 
		{ time = 1.39999997616 event = FootstepWalkSoundEffect } 
		{ time = 1.60000002384 event = FootstepWalkSoundEffect } 
	] 
	smackwall = [ 
		{ time = 0.01999999955 event = BailBodyPunchSoundEffect } 
		{ time = 0.03999999911 event = BailSlapSoundEffect } 
	] 
	smackwallfeet = [ 
		{ time = 0.07000000030 event = BailBodyPunchSoundEffect } 
		{ time = 0.00999999978 event = FootstepRunSoundEffect } 
		{ time = 0.03999999911 event = FootstepRunSoundEffect } 
	] 
	smackwallupright = [ 
		{ time = 0.01999999955 event = BailBodyPunchSoundEffect } 
		{ time = 0.03999999911 event = BailSlapSoundEffect } 
		{ time = 0.50000000000 event = BailBodyFallSoundEffect } 
	] 
	runout = [ 
		{ time = 0.00999999978 event = BailBoardSoundEffect } 
		{ time = 0.30000001192 event = BailBoardSoundEffect } 
		{ time = 0.18000000715 event = FootstepRunSoundEffect } 
		{ time = 0.60000002384 event = FootstepRunSoundEffect } 
		{ time = 0.97000002861 event = FootstepScuffSoundEffect } 
		{ time = 1.50000000000 event = FootstepWalkSoundEffect } 
		{ time = 2.09999990463 event = FootstepWalkSoundEffect } 
		{ time = 2.48000001907 event = FootstepWalkSoundEffect } 
	] 
	runoutquick = [ 
		{ time = 0.00999999978 event = BailBoardSoundEffect } 
		{ time = 0.34999999404 event = FootstepRunSoundEffect } 
		{ time = 0.44999998808 event = FootstepRunSoundEffect } 
		{ time = 0.44999998808 event = FootstepScuffSoundEffect } 
		{ time = 1.14999997616 event = FootstepWalkSoundEffect } 
		{ time = 1.60000002384 event = FootstepWalkSoundEffect } 
		{ time = 2.00000000000 event = FootstepWalkSoundEffect } 
	] 
	landpartiallyonboard = [ 
		{ time = 0.00999999978 event = BailBoardSoundEffect } 
		{ time = 0.30000001192 event = BailBodyPunchSoundEffect } 
		{ time = 0.37999999523 event = BailSlapSoundEffect } 
		{ time = 0.41999998689 event = BailCrackSoundEffect } 
		{ time = 1.10000002384 event = BailBodyFallSoundEffect } 
		{ time = 1.10000002384 event = BailKneeStream } 
	] 
	runoutdrop = [ 
		{ time = 0.05000000075 event = FootstepRunSoundEffect } 
		{ time = 0.11999999732 event = FootstepRunSoundEffect } 
		{ time = 0.11999999732 event = FootstepScuffSoundEffect } 
		{ time = 1.50000000000 event = FootstepWalkSoundEffect } 
		{ time = 1.89999997616 event = FootstepWalkSoundEffect } 
	] 
	headfirstsplat = [ 
		{ time = 0.01999999955 event = BailBodyPunchSoundEffect } 
		{ time = 0.09000000358 event = BailSlapSoundEffect } 
		{ time = 0.50000000000 event = BailBodyFallSoundEffect } 
	] 
	feetfirstsplat = [ 
		{ time = 0.40999999642 event = BailBodyPunchSoundEffect } 
		{ time = 0.47999998927 event = BailSlapSoundEffect } 
		{ time = 0.01999999955 event = BailBodyFallSoundEffect } 
	] 
	bigdrop = [ 
		{ time = 0.10000000149 event = FootstepLandSoundEffect } 
		{ time = 0.20000000298 event = BailBodyPunchSoundEffect } 
		{ time = 0.28999999166 event = FootstepScuffSoundEffect } 
		{ time = 0.80000001192 event = BailBodyFallSoundEffect } 
	] 
	neckbreaker = [ 
		{ time = 0.01999999955 event = BailBodyPunchSoundEffect } 
		{ time = 0.07000000030 event = BailSlapSoundEffect } 
		{ time = 0.09000000358 event = BailCrackSoundEffect } 
		{ time = 0.69999998808 event = BailBodyFallSoundEffect } 
	] 
	getupdarthmaul = [ 
		{ time = 1.00000000000 event = FootstepLandSoundEffect } 
		{ time = 1.14999997616 event = FootstepScuffSoundEffect } 
		{ time = 1.54999995232 event = FootstepWalkSoundEffect } 
		{ time = 1.70000004768 event = FootstepWalkSoundEffect } 
	] 
	shoulders = [ 
		{ time = 0.00999999978 event = BailBoardSoundEffect } 
		{ time = 0.40999999642 event = BailBodyPunchSoundEffect } 
		{ time = 0.50000000000 event = BailBodyFallSoundEffect } 
	] 
	hips = [ 
		{ time = 0.00999999978 event = BailBoardSoundEffect } 
		{ time = 0.37999999523 event = BailBodyPunchSoundEffect } 
		{ time = 0.44999998808 event = BailBodyFallSoundEffect } 
	] 
	rolling = [ 
		{ time = 0.00999999978 event = BailBoardSoundEffect } 
		{ time = 0.34999999404 event = BailBodyPunchSoundEffect } 
		{ time = 0.40000000596 event = BailSlapSoundEffect } 
		{ time = 0.60000002384 event = BailBodyFallSoundEffect } 
		{ time = 2.29999995232 event = FootstepWalkSoundEffect } 
		{ time = 2.68000006676 event = FootstepWalkSoundEffect } 
	] 
	getuphips = [ 
		{ time = 0.44999998808 event = FootstepScuffSoundEffect } 
		{ time = 1.00000000000 event = FootstepWalkSoundEffect } 
		{ time = 1.50000000000 event = FootstepWalkSoundEffect } 
	] 
	spasmodic = [ 
		{ time = 0.00999999978 event = BailBoardSoundEffect } 
		{ time = 0.30000001192 event = FootstepRunSoundEffect } 
		{ time = 0.30000001192 event = FootstepScuffSoundEffect } 
		{ time = 0.56999999285 event = FootstepRunSoundEffect } 
		{ time = 0.56999999285 event = FootstepScuffSoundEffect } 
		{ time = 0.85000002384 event = BailBodyPunchSoundEffect } 
		{ time = 0.85000002384 event = BailBodyFallSoundEffect } 
		{ time = 0.93999999762 event = BailSlapSoundEffect } 
	] 
	getupspasmodic = [ 
		{ time = 0.44999998808 event = FootstepScuffSoundEffect } 
		{ time = 1.00000000000 event = FootstepWalkSoundEffect } 
		{ time = 1.48000001907 event = FootstepWalkSoundEffect } 
	] 
	tailslideout = [ 
		{ time = 0.00999999978 event = BailBoardSoundEffect } 
		{ time = 0.11999999732 event = BailBodyPunchSoundEffect } 
		{ time = 0.17000000179 event = BailSlapSoundEffect } 
		{ time = 0.18999999762 event = BailCrackSoundEffect } 
		{ time = 0.69999998808 event = BailBodyFallSoundEffect } 
	] 
	getuptailslideout = [ 
		{ time = 1.14999997616 event = FootstepScuffSoundEffect } 
		{ time = 1.25000000000 event = FootstepScuffSoundEffect } 
		{ time = 1.50000000000 event = FootstepWalkSoundEffect } 
		{ time = 1.70000004768 event = FootstepWalkSoundEffect } 
	] 
	splits = [ 
		{ time = 0.07999999821 event = BailBodyPunchSoundEffect } 
		{ time = 0.12999999523 event = BailSlapSoundEffect } 
		{ time = 0.15000000596 event = BailCrackSoundEffect } 
		{ time = 0.89999997616 event = FootstepScuffSoundEffect } 
		{ time = 1.29999995232 event = FootstepWalkSoundEffect } 
	] 
	anklebust1 = [ 
		{ time = 0.00999999978 event = BailBoardSoundEffect } 
		{ time = 0.34999999404 event = BailBodyPunchSoundEffect } 
		{ time = 0.41999998689 event = BailSlapSoundEffect } 
		{ time = 0.47999998927 event = BailCrackSoundEffect } 
		{ time = 1.04999995232 event = BailBodyFallSoundEffect } 
		{ time = 1.20000004768 event = BailAnkleStream } 
	] 
	anklebust2 = [ 
		{ time = 0.00999999978 event = BailBoardSoundEffect } 
		{ time = 0.30000001192 event = BailBodyPunchSoundEffect } 
		{ time = 0.37000000477 event = BailSlapSoundEffect } 
		{ time = 0.43000000715 event = BailCrackSoundEffect } 
		{ time = 0.94999998808 event = BailBodyFallSoundEffect } 
		{ time = 1.10000002384 event = BailAnkleStream } 
	] 
	faceplant = [ 
		{ time = 0.00999999978 event = BailBoardSoundEffect } 
		{ time = 0.37000000477 event = BailBodyPunchSoundEffect } 
		{ time = 0.43999999762 event = BailSlapSoundEffect } 
		{ time = 2.00000000000 event = FootstepScuffSoundEffect } 
		{ time = 2.59999990463 event = FootstepWalkSoundEffect } 
	] 
	nsmissbackfoot = [ 
		{ time = 0.00999999978 event = BailBoardSoundEffect } 
		{ time = 0.30000001192 event = BailBodyPunchSoundEffect } 
		{ time = 0.37000000477 event = BailSlapSoundEffect } 
		{ time = 0.41999998689 event = BailCrackSoundEffect } 
		{ time = 0.69999998808 event = BailBodyFallSoundEffect } 
	] 
	nsmissbackfoot_resume = [ 
		{ time = 0.60000002384 event = FootstepScuffSoundEffect } 
		{ time = 0.80000001192 event = FootstepScuffSoundEffect } 
		{ time = 1.29999995232 event = FootstepWalkSoundEffect } 
		{ time = 1.70000004768 event = FootstepWalkSoundEffect } 
	] 
	anklebust3 = [ 
		{ time = 0.00999999978 event = BailBoardSoundEffect } 
		{ time = 0.30000001192 event = BailBodyPunchSoundEffect } 
		{ time = 0.37000000477 event = BailSlapSoundEffect } 
		{ time = 0.43000000715 event = BailCrackSoundEffect } 
		{ time = 0.69999998808 event = BailScrapeSoundEffect } 
		{ time = 1.60000002384 event = BailBodyFallSoundEffect } 
		{ time = 1.10000002384 event = BailAnkleStream } 
	] 
	getupanklebust = [ 
		{ time = 1.50000000000 event = FootstepScuffSoundEffect } 
		{ time = 2.20000004768 event = FootstepScuffSoundEffect } 
		{ time = 3.20000004768 event = FootstepWalkSoundEffect } 
		{ time = 3.79999995232 event = FootstepWalkSoundEffect } 
	] 
	boardsplit = [ 
		{ time = 0.50000000000 event = BailBodyPunchSoundEffect } 
		{ time = 0.10000000149 event = BailSlapSoundEffect } 
		{ time = 0.15000000596 event = SoundEffect params = { name = BailCrack01 } } 
		{ time = 0.60000002384 event = BailBodyFallSoundEffect } 
		{ time = 1.79999995232 event = BailKickStream } 
		{ time = 2.01999998093 event = FootstepScuffSoundEffect } 
		{ time = 2.15000009537 event = FootstepScuffSoundEffect } 
		{ time = 2.59999990463 event = SoundEffect params = { name = BailScrape01 } } 
		{ time = 2.59999990463 event = SoundEffect params = { name = BailBodyPunch04_11 } } 
		{ time = 3.20000004768 event = FootstepWalkSoundEffect } 
		{ time = 3.79999995232 event = FootstepWalkSoundEffect } 
		{ time = 4.30000019073 event = FootstepWalkSoundEffect } 
		{ time = 4.69999980927 event = FootstepWalkSoundEffect } 
	] 
	flailbail = [ 
		{ time = 0.00999999978 event = BailBoardSoundEffect } 
		{ time = 0.47999998927 event = BailBodyPunchSoundEffect } 
		{ time = 0.54000002146 event = BailSlapSoundEffect } 
		{ time = 0.80000001192 event = BailBodyFallSoundEffect } 
	] 
	flailgetup = [ 
		{ time = 1.50000000000 event = FootstepScuffSoundEffect } 
		{ time = 2.00000000000 event = FootstepScuffSoundEffect } 
		{ time = 2.34999990463 event = FootstepWalkSoundEffect } 
		{ time = 2.70000004768 event = FootstepWalkSoundEffect } 
	] 
	headsmack = [ 
		{ time = 0.00999999978 event = BailBoardSoundEffect } 
		{ time = 0.25000000000 event = FootstepScuffSoundEffect } 
		{ time = 0.34999999404 event = FootstepScuffSoundEffect } 
		{ time = 0.63999998569 event = BailBodyPunchSoundEffect } 
		{ time = 0.69999998808 event = BailSlapSoundEffect } 
		{ time = 0.55000001192 event = BailBodyFallSoundEffect } 
	] 
	headgetup = [ 
		{ time = 0.69999998808 event = FootstepScuffSoundEffect } 
		{ time = 1.50000000000 event = FootstepScuffSoundEffect } 
		{ time = 2.09999990463 event = FootstepWalkSoundEffect } 
		{ time = 2.70000004768 event = FootstepWalkSoundEffect } 
	] 
	manualback = [ 
		{ time = 0.01999999955 event = BailBoardSoundEffect } 
		{ time = 0.51999998093 event = BailBodyPunchSoundEffect } 
		{ time = 0.61000001431 event = BailSlapSoundEffect } 
		{ time = 1.58000004292 event = SoundEffect params = { name = BailBodyPunch02_11 } } 
	] 
	manualgetup = [ 
		{ time = 1.10000002384 event = FootstepWalkSoundEffect } 
		{ time = 1.60000002384 event = FootstepWalkSoundEffect } 
		{ time = 2.18000006676 event = FootstepScuffSoundEffect } 
		{ time = 2.27999997139 event = FootstepScuffSoundEffect } 
		{ time = 2.22000002861 event = FootstepRunSoundEffect } 
		{ time = 2.31999993324 event = FootstepRunSoundEffect } 
	] 
	manualforwards = [ 
		{ time = 0.00999999978 event = BailBoardSoundEffect } 
		{ time = 0.37999999523 event = BailBodyPunchSoundEffect } 
		{ time = 0.44999998808 event = BailSlapSoundEffect } 
	] 
	manual_fgetup = [ 
		{ time = 0.69999998808 event = FootstepWalkSoundEffect } 
		{ time = 1.50000000000 event = FootstepRunSoundEffect } 
		{ time = 1.50000000000 event = FootstepScuffSoundEffect } 
		{ time = 1.95000004768 event = FootstepRunSoundEffect } 
		{ time = 2.31999993324 event = FootstepWalkSoundEffect } 
	] 
	newanklebust = [ 
		{ time = 0.00999999978 event = BailBoardSoundEffect } 
		{ time = 0.30000001192 event = BailBodyPunchSoundEffect } 
		{ time = 0.37000000477 event = BailSlapSoundEffect } 
		{ time = 0.43000000715 event = BailCrackSoundEffect } 
		{ time = 1.29999995232 event = BailBodyFallSoundEffect } 
		{ time = 1.20000004768 event = BailAnkleStream } 
	] 
	nutsac = [ 
		{ time = 0.20000000298 event = BailBodyPunchSoundEffect } 
		{ time = 0.27000001073 event = BailSlapSoundEffect } 
		{ time = 0.33000001311 event = BailCrackSoundEffect } 
		{ time = 1.00000000000 event = BailBodyFallSoundEffect } 
	] 
	nutsacgetup = [ 
		{ time = 0.50000000000 event = FootstepWalkSoundEffect } 
		{ time = 1.29999995232 event = FootstepRunSoundEffect } 
		{ time = 1.60000002384 event = FootstepScuffSoundEffect } 
		{ time = 1.79999995232 event = FootstepWalkSoundEffect } 
		{ time = 3.09999990463 event = FootstepWalkSoundEffect } 
		{ time = 3.50000000000 event = FootstepWalkSoundEffect } 
	] 
	nutsacgetupquick = [ 
		{ time = 1.10000002384 event = FootstepWalkSoundEffect } 
		{ time = 1.50000000000 event = FootstepScuffSoundEffect } 
		{ time = 2.40000009537 event = FootstepRunSoundEffect } 
		{ time = 2.50000000000 event = FootstepRunSoundEffect } 
	] 
	onefootbail = [ 
		{ time = 0.00999999978 event = BailBoardSoundEffect } 
		{ time = 0.20000000298 event = BailBodyPunchSoundEffect } 
		{ time = 0.27000001073 event = BailSlapSoundEffect } 
		{ time = 0.33000001311 event = BailCrackSoundEffect } 
		{ time = 1.00000000000 event = BailBodyFallSoundEffect } 
		{ time = 1.95000004768 event = BailBodyFallSoundEffect } 
		{ time = 1.10000002384 event = BailKneeStream } 
	] 
	onefootgetup = [ 
		{ time = 0.60000002384 event = FootstepScuffSoundEffect } 
		{ time = 1.00000000000 event = FootstepWalkSoundEffect } 
		{ time = 1.79999995232 event = FootstepWalkSoundEffect } 
		{ time = 2.18000006676 event = FootstepWalkSoundEffect } 
		{ time = 2.18000006676 event = FootstepScuffSoundEffect } 
	] 
	railbail = [ 
		{ time = 0.00999999978 event = BailBoardSoundEffect } 
		{ time = 0.40000000596 event = BailBodyPunchSoundEffect } 
		{ time = 0.47999998927 event = BailSlapSoundEffect } 
		{ time = 0.60000002384 event = BailBodyFallSoundEffect } 
	] 
	railbailgetup = [ 
		{ time = 0.33000001311 event = FootstepScuffSoundEffect } 
		{ time = 1.00000000000 event = FootstepWalkSoundEffect } 
		{ time = 2.04999995232 event = FootstepWalkSoundEffect } 
		{ time = 2.50000000000 event = FootstepWalkSoundEffect } 
	] 
	railbailhitground = [ 
		{ time = 0.01999999955 event = BailBodyPunchSoundEffect } 
		{ time = 0.10000000149 event = BailSlapSoundEffect } 
	] 
	rollingbail = [ 
		{ time = 0.00999999978 event = BailBoardSoundEffect } 
		{ time = 0.44999998808 event = BailBodyPunchSoundEffect } 
		{ time = 0.52999997139 event = BailSlapSoundEffect } 
		{ time = 0.95999997854 event = BailScrapeSoundEffect } 
		{ time = 0.60000002384 event = BailBodyFallSoundEffect } 
	] 
	rollinggetup = [ 
		{ time = 0.80000001192 event = FootstepScuffSoundEffect } 
		{ time = 1.70000004768 event = FootstepScuffSoundEffect } 
		{ time = 2.20000004768 event = FootstepRunSoundEffect } 
		{ time = 2.32999992371 event = FootstepRunSoundEffect } 
	] 
	walkingslap = [ 
		{ time = 0.28000000119 event = BailSlapSoundEffect } 
		{ time = 0.56999999285 event = FootstepRunSoundEffect } 
		{ time = 0.89999997616 event = FootstepWalkSoundEffect } 
	] 
	walkingbail = [ 
		{ time = 0.00999999978 event = BailSlapSoundEffect } 
		{ time = 0.44999998808 event = BailBoardSoundEffect } 
		{ time = 0.60000002384 event = BailBodyFallSoundEffect } 
	] 
	walkingbailgetup = [ 
		{ time = 0.69999998808 event = FootstepScuffSoundEffect } 
		{ time = 1.20000004768 event = FootstepScuffSoundEffect } 
		{ time = 1.60000002384 event = FootstepWalkSoundEffect } 
		{ time = 1.89999997616 event = FootstepWalkSoundEffect } 
	] 
} 
PedAnimEventTable = { 
	Ped_Tombstone_Chisel1 = [ 
		{ time = 0.01999999955 event = Print params = { string = "Chisel1" } } 
		{ time = 0.30000001192 event = TombstoneChiselSound } 
		{ time = 0.60000002384 event = TombstoneChiselSound } 
		{ time = 0.89999997616 event = TombstoneChiselSound } 
	] 
	Ped_Tombstone_Inspect = [ 
		{ time = 0.01999999955 event = Print params = { string = "Inspect" } } 
		{ time = 0.01999999955 event = PedObjPlayStream params = { name = "TombstoneManInspect" } } 
	] 
	Ped_Tombstone_WipeBrow = [ 
		{ time = 0.01999999955 event = Print params = { string = "Wipebrow" } } 
		{ time = 0.01999999955 event = PedObjPlayStream params = { name = "TombstoneManWipeBrow" } } 
	] 
	Ped_Tombstone_Chisel2 = [ 
		{ time = 0.01999999955 event = Print params = { string = "Chisel2" } } 
		{ time = 0.50000000000 event = TombstoneChiselSound } 
	] 
	Ped_Tombstone_Chisel3 = [ 
		{ time = 0.01999999955 event = Print params = { string = "Chisel3" } } 
		{ time = 0.64999997616 event = TombstoneChiselSound } 
		{ time = 0.86000001431 event = TombstoneChiselSound } 
		{ time = 1.10000002384 event = TombstoneChiselSound } 
		{ time = 1.35000002384 event = TombstoneChiselSound } 
	] 
	Ped_Tombstone_StandToKneel = [ 
		{ time = 0.01999999955 event = Print params = { string = "StandToKneel" } } 
		{ time = 0.01999999955 event = PedObjPlayStream params = { name = "TombstoneManStandToKneel" } } 
	] 
	Ped_Tombstone_KneelChisel = [ 
		{ time = 0.01999999955 event = Print params = { string = "KneelChisel" } } 
		{ time = 0.50000000000 event = TombstoneChiselSound } 
		{ time = 1.00000000000 event = TombstoneChiselSound } 
		{ time = 1.49000000954 event = TombstoneChiselSound } 
	] 
	Ped_Tombstone_KneelBadBack = [ 
		{ time = 0.01999999955 event = Print params = { string = "KneelBadBack" } } 
		{ time = 0.01999999955 event = PedObjPlayStream params = { name = "TombstoneManKneelBadBack" } } 
	] 
	Ped_Tombstone_StandFromKneel = [ 
		{ time = 0.01999999955 event = Print params = { string = "StandFromKneel" } } 
		{ time = 0.01999999955 event = PedObjPlayStream params = { name = "TombstoneManStandFromKneel" } } 
	] 
	Ped_Tombstone_StandToChisel = [ 
		{ time = 0.01999999955 event = Print params = { string = "StandToChisel" } } 
		{ time = 0.01999999955 event = PedObjPlayStream params = { name = "TombstoneManStandToChisel" } } 
	] 
	Ped_Tombstone_StandFromChisel = [ 
		{ time = 0.01999999955 event = Print params = { string = "StandFromChisel" } } 
		{ time = 0.01999999955 event = PedObjPlayStream params = { name = "StandFromChisel" } } 
	] 
	Ped_Tombstone_StandIdle = [ 
		{ time = 0.01999999955 event = Print params = { string = "StandIdle" } } 
	] 
	BarkIdle = [ 
		{ time = 0.01999999955 event = DogBarkStream } 
	] 
	Ped_M_jumpback = [ 
		{ time = 0.57999998331 event = FootstepScuffSoundEffect } 
		{ time = 0.85000002384 event = FootstepRunSoundEffect } 
		{ time = 1.00000000000 event = FootstepRunSoundEffect } 
	] 
	Ped_f_jumpback = [ 
		{ time = 0.10000000149 event = FootstepScuffSoundEffect } 
		{ time = 0.50000000000 event = FootstepRunSoundEffect } 
		{ time = 0.64999997616 event = FootstepRunSoundEffect } 
	] 
	Ped_M_jumpforward = [ 
		{ time = 0.60000002384 event = FootstepScuffSoundEffect } 
		{ time = 0.60000002384 event = FootstepRunSoundEffect } 
		{ time = 1.10000002384 event = FootstepWalkSoundEffect } 
	] 
	Ped_f_jumpforward = [ 
		{ time = 0.40000000596 event = FootstepScuffSoundEffect } 
		{ time = 0.40000000596 event = FootstepRunSoundEffect } 
		{ time = 0.56000000238 event = FootstepRunSoundEffect } 
		{ time = 1.70000004768 event = FootstepWalkSoundEffect } 
	] 
	Ped_M_jumpleft = [ 
		{ time = 0.44999998808 event = FootstepScuffSoundEffect } 
		{ time = 0.44999998808 event = FootstepRunSoundEffect } 
		{ time = 0.80000001192 event = FootstepRunSoundEffect } 
		{ time = 1.29999995232 event = FootstepWalkSoundEffect } 
	] 
	Ped_f_jumpright = [ 
		{ time = 0.44999998808 event = FootstepScuffSoundEffect } 
		{ time = 0.44999998808 event = FootstepRunSoundEffect } 
		{ time = 0.60000002384 event = FootstepRunSoundEffect } 
		{ time = 1.29999995232 event = FootstepWalkSoundEffect } 
	] 
	Ped_M_falldownA = [ 
		{ time = 0.44999998808 event = BailBodyFallSoundEffect } 
		{ time = 0.69999998808 event = BailBodyFallSoundEffect } 
	] 
	Ped_M_falldownB = [ 
		{ time = 0.41999998689 event = BailBodyFallSoundEffect } 
		{ time = 0.64999997616 event = BailBodyFallSoundEffect } 
	] 
	Ped_M_falldownC = [ 
		{ time = 0.30000001192 event = BailBodyFallSoundEffect } 
	] 
	Ped_M_falldownD = [ 
		{ time = 0.20000000298 event = FootstepScuffSoundEffect } 
		{ time = 0.40000000596 event = BailBodyFallSoundEffect } 
	] 
	Ped_M_falldownE = [ 
		{ time = 0.20000000298 event = FootstepScuffSoundEffect } 
		{ time = 0.34999999404 event = BailBodyFallSoundEffect } 
		{ time = 0.55000001192 event = BailBodyFallSoundEffect } 
	] 
	Ped_M_Run = [ 
		{ time = 0.11999999732 event = FootstepRunSoundEffect } 
		{ time = 0.46000000834 event = FootstepRunSoundEffect } 
	] 
	Ped_f_Run = [ 
		{ time = 0.18000000715 event = FootstepRunSoundEffect } 
		{ time = 0.60000002384 event = FootstepRunSoundEffect } 
	] 
	Ped_M_runtoidle = [ 
		{ time = 0.11999999732 event = FootstepRunSoundEffect } 
		{ time = 0.46000000834 event = FootstepRunSoundEffect } 
		{ time = 0.75000000000 event = FootstepScuffSoundEffect } 
	] 
	Ped_f_runtoidle1 = [ 
		{ time = 0.11999999732 event = FootstepRunSoundEffect } 
		{ time = 0.46000000834 event = FootstepRunSoundEffect } 
		{ time = 0.11999999732 event = FootstepScuffSoundEffect } 
	] 
	Ped_f_runtoidle2 = [ 
		{ time = 0.20000000298 event = FootstepRunSoundEffect } 
		{ time = 0.46000000834 event = FootstepRunSoundEffect } 
	] 
	Ped_M_Run1 = [ 
		{ time = 0.11999999732 event = FootstepRunSoundEffect } 
		{ time = 0.46000000834 event = FootstepRunSoundEffect } 
	] 
	Ped_M_Run2 = [ 
		{ time = 0.05000000075 event = FootstepRunSoundEffect } 
		{ time = 0.37999999523 event = FootstepRunSoundEffect } 
	] 
	Ped_M_Walk1 = [ 
		{ time = 0.00999999978 event = FootstepWalkSoundEffect } 
		{ time = 0.52999997139 event = FootstepWalkSoundEffect } 
	] 
	Ped_f_Walk = [ 
		{ time = 0.00999999978 event = FootstepWalkSoundEffect } 
		{ time = 0.62000000477 event = FootstepWalkSoundEffect } 
	] 
	Ped_f_Walk2 = [ 
		{ time = 0.00999999978 event = FootstepWalkSoundEffect } 
		{ time = 0.62000000477 event = FootstepWalkSoundEffect } 
	] 
	Ped_f_Walk2toidle1 = [ 
		{ time = 0.00999999978 event = FootstepWalkSoundEffect } 
	] 
	Ped_f_Walk3 = [ 
		{ time = 0.00999999978 event = FootstepWalkSoundEffect } 
		{ time = 0.69999998808 event = FootstepWalkSoundEffect } 
	] 
	Ped_f_Walk3toidle1 = [ 
		{ time = 0.00999999978 event = FootstepWalkSoundEffect } 
	] 
	Ped_f_Walk4 = [ 
		{ time = 0.00999999978 event = FootstepWalkSoundEffect } 
		{ time = 0.43000000715 event = FootstepWalkSoundEffect } 
	] 
	Ped_f_Walk4toidle1 = [ 
		{ time = 0.00999999978 event = FootstepWalkSoundEffect } 
	] 
	Ped_f_Walkingwave = [ 
		{ time = 0.00999999978 event = FootstepWalkSoundEffect } 
		{ time = 0.62000000477 event = FootstepWalkSoundEffect } 
	] 
	Ped_M_Walk3 = [ 
		{ time = 0.07999999821 event = FootstepWalkSoundEffect } 
		{ time = 0.55000001192 event = FootstepWalkSoundEffect } 
	] 
	Ped_M_Walk4 = [ 
		{ time = 0.05000000075 event = FootstepWalkSoundEffect } 
		{ time = 0.40000000596 event = FootstepWalkSoundEffect } 
	] 
	Ped_M_Walkcool = [ 
		{ time = 0.00999999978 event = FootstepWalkSoundEffect } 
		{ time = 0.80000001192 event = FootstepWalkSoundEffect } 
	] 
	Ped_M_Walktired = [ 
		{ time = 0.00999999978 event = FootstepWalkSoundEffect } 
		{ time = 0.80000001192 event = FootstepWalkSoundEffect } 
	] 
	Ped_M_Walk1toIdle = [ 
		{ time = 0.40000000596 event = FootstepScuffSoundEffect } 
	] 
	Ped_f_WalktoIdle1 = [ 
		{ time = 0.00999999978 event = FootstepWalkSoundEffect } 
		{ time = 0.60000002384 event = FootstepScuffSoundEffect } 
	] 
	Ped_f_WalktoIdle2 = [ 
		{ time = 0.00999999978 event = FootstepWalkSoundEffect } 
	] 
	Ped_M_Walk2 = [ 
		{ time = 0.00999999978 event = FootstepWalkSoundEffect } 
		{ time = 0.52999997139 event = FootstepWalkSoundEffect } 
	] 
	Ped_M_Walk2toIdle = [ 
		{ time = 0.40000000596 event = FootstepScuffSoundEffect } 
	] 
	Ped_M_Run1toIdle = [ 
		{ time = 0.30000001192 event = FootstepScuffSoundEffect } 
	] 
} 
DogAnimEventTable = { 
	run = [ 
		{ time = 0.01999999955 event = Print params = { string = "Dog Run" } } 
	] 
	BarkIdle = [ 
		{ time = 0.01999999955 event = DogBarkStream } 
	] 
	LiftLeg = [ 
		{ time = 0.01999999955 event = Print params = { string = "Dog Lift Leg" } } 
	] 
} 
SCRIPT set_actual_skater_anim_handlers 
	SetEventHandler ex = SoundEffect scr = HandleSoundEffectEvent group = anim 
	SetEventHandler ex = FootstepWalkSoundEffect scr = HandleFootstepWalkSoundEffectEvent group = anim 
	SetEventHandler ex = FootstepRunSoundEffect scr = HandleFootstepRunSoundEffectEvent group = anim 
	SetEventHandler ex = FootstepScuffSoundEffect scr = HandleFootstepScuffSoundEffect group = anim 
	SetEventHandler ex = FootstepJumpSoundEffect scr = HandleFootstepJumpSoundEffect group = anim 
	SetEventHandler ex = FootstepLandSoundEffect scr = HandleFootstepLandSoundEffect group = anim 
	SetEventHandler ex = BailBodyFallSoundEffect scr = HandleBailBodyFallSoundEffect group = anim 
	SetEventHandler ex = BailBodyPunchSoundEffect scr = HandleBailBodyPunchSoundEffect group = anim 
	SetEventHandler ex = BailCrackSoundEffect scr = HandleBailCrackSoundEffect group = anim 
	SetEventHandler ex = BailSlapSoundEffect scr = HandleBailSlapSoundEffect group = anim 
	SetEventHandler ex = BailScrapeSoundEffect scr = HandleBailScrapeSoundEffect group = anim 
	SetEventHandler ex = BailBoardSoundEffect scr = HandleBailBoardSoundEffect group = anim 
	SetEventHandler ex = BailHitGroundSoundEffect scr = HandleHitGroundSoundEffect group = anim 
	SetEventHandler ex = TerrainLandSound scr = HandleTerrainLandSound group = anim 
	SetEventHandler ex = TerrainBonkSound scr = HandleTerrainBonkSound group = anim 
	SetEventHandler ex = TurnOnSkaterLoopingSound scr = HandleTurnOnSkaterLoopingSound group = anim 
	SetEventHandler ex = BailKneeStream scr = HandleBailKneeStream group = anim 
	SetEventHandler ex = BailAnkleStream scr = HandleBailAnkleStream group = anim 
	SetEventHandler ex = BailKickStream scr = HandleBailKickStream group = anim 
	SetEventHandler ex = GenericParticles scr = Emit_SpecialTrickParticles group = anim 
	SetEventHandler ex = IronParticles scr = IronParticles_emitfromHand group = anim 
ENDSCRIPT

SCRIPT set_actual_ped_anim_handlers 
	SetEventHandler ex = Print scr = HandlePrintEvent group = anim 
	SetEventHandler ex = TombstoneChiselSound scr = HandleTombstoneChiselSound group = anim 
	SetEventHandler ex = TombstoneInspectStream scr = HandleTombstoneInspectStream group = anim 
	SetEventHandler ex = PedObjPlayStream scr = HandlePedObjPlayStream group = anim 
	SetEventHandler ex = DogBarkStream scr = HandleDogBarkStream group = anim 
	SetEventHandler ex = FootstepWalkSoundEffect scr = HandlePedFootstepWalkSoundEffectEvent group = anim 
	SetEventHandler ex = FootstepRunSoundEffect scr = HandlePedFootstepRunSoundEffectEvent group = anim 
	SetEventHandler ex = FootstepScuffSoundEffect scr = HandlePedFootstepScuffSoundEffect group = anim 
	SetEventHandler ex = FootstepJumpSoundEffect scr = HandlePedFootstepJumpSoundEffect group = anim 
	SetEventHandler ex = FootstepLandSoundEffect scr = HandlePedFootstepLandSoundEffect group = anim 
	SetEventHandler ex = BailBodyFallSoundEffect scr = HandlePedBailBodyFallSoundEffect group = anim 
	SetEventHandler ex = BailBodyPunchSoundEffect scr = HandlePedBailBodyPunchSoundEffect group = anim 
	SetEventHandler ex = BailCrackSoundEffect scr = HandlePedBailCrackSoundEffect group = anim 
	SetEventHandler ex = BailSlapSoundEffect scr = HandlePedBailSlapSoundEffect group = anim 
	SetEventHandler ex = BailScrapeSoundEffect scr = HandlePedBailScrapeSoundEffect group = anim 
	SetEventHandler ex = BailBoardSoundEffect scr = HandlePedBailBoardSoundEffect group = anim 
ENDSCRIPT

SCRIPT IronParticles_emitfromHand specialtrick_particles = iron_particles 
	IF Flipped 
		Emit_SpecialTrickParticles specialtrick_particles = <specialtrick_particles> bone = Bone_Wrist_L StopEmitAt = 0.11999999732 
	ELSE 
		Emit_SpecialTrickParticles specialtrick_particles = <specialtrick_particles> bone = Bone_Wrist_R StopEmitAt = 0.11999999732 
	ENDIF 
	Obj_PlaySound FlamingFireball01 vol = 450 
ENDSCRIPT

SCRIPT set_skater_anim_handlers 
	ClearExceptionGroup anim 
	set_actual_skater_anim_handlers 
ENDSCRIPT

SCRIPT set_ped_anim_handlers 
	ClearExceptionGroup anim 
	set_actual_ped_anim_handlers 
ENDSCRIPT

SCRIPT set_viewerobj_anim_handlers 
	ClearExceptionGroup anim 
	set_actual_skater_anim_handlers 
	set_actual_ped_anim_handlers 
ENDSCRIPT

SCRIPT HandlePrintEvent 
	printf "Handling %s event" s = <string> 
ENDSCRIPT

SCRIPT HandlePedObjPlayStream 
	printf <name> 
ENDSCRIPT

SCRIPT HandleTombstoneChiselSound 
	Obj_PlaySound NJ_TombstoneAnvilHit01 vol = RANDOM_RANGE PAIR(40.00000000000, 75.00000000000) pitch = RANDOM_RANGE PAIR(95.00000000000, 102.00000000000) 
ENDSCRIPT

SCRIPT HandleTombstoneInspectStream 
ENDSCRIPT

SCRIPT HandleDogBarkStream 
	IF Obj_Visible 
		RANDOM_NO_REPEAT(1, 1) 
			RANDOMCASE Obj_PlayStream NJ_DogBark03 vol = 130 dropoff = 100 
			RANDOMCASE Obj_PlayStream NJ_DogBark04 vol = 130 dropoff = 100 
		RANDOMEND 
		wait 1 seconds 
		RANDOM_NO_REPEAT(1, 1, 1, 1) 
			RANDOMCASE Obj_PlayStream NJ_DogBark01 vol = 130 dropoff = 100 
			RANDOMCASE Obj_PlayStream NJ_DogBark02 vol = 130 dropoff = 100 
			RANDOMCASE Obj_PlayStream NJ_DogBark05 vol = 130 dropoff = 100 
			RANDOMCASE Obj_PlayStream NJ_DogBark06 vol = 130 dropoff = 100 
		RANDOMEND 
	ENDIF 
ENDSCRIPT

SCRIPT HandleBailKneeStream 
	IF ProfileEquals is_custom 
		IF ProfileEquals is_male 
			RANDOM_NO_REPEAT(1, 1, 1, 1, 1, 1) 
				RANDOMCASE PlayStream customm_knee01 vol = 200 
				RANDOMCASE PlayStream customm_knee02 vol = 200 
				RANDOMCASE PlayStream customm_knee03 vol = 200 
				RANDOMCASE PlayStream customm_knee04 vol = 200 
				RANDOMCASE PlayStream customm_knee05 vol = 200 
				RANDOMCASE PlayStream customm_knee06 vol = 200 
			RANDOMEND 
		ELSE 
			RANDOM_NO_REPEAT(1, 1, 1, 1, 1, 1) 
				RANDOMCASE PlayStream customf_knee01 vol = 200 
				RANDOMCASE PlayStream customf_knee02 vol = 200 
				RANDOMCASE PlayStream customf_knee03 vol = 200 
				RANDOMCASE PlayStream customf_knee04 vol = 200 
				RANDOMCASE PlayStream customf_knee05 vol = 200 
				RANDOMCASE PlayStream customf_knee06 vol = 200 
			RANDOMEND 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT HandleBailAnkleStream 
	IF ProfileEquals is_custom 
		IF ProfileEquals is_male 
			RANDOM_NO_REPEAT(1, 1, 1, 1, 1) 
				RANDOMCASE PlayStream customm_ankle01 vol = 200 
				RANDOMCASE PlayStream customm_ankle02 vol = 200 
				RANDOMCASE PlayStream customm_ankle03 vol = 200 
				RANDOMCASE PlayStream customm_ankle04 vol = 200 
				RANDOMCASE PlayStream customm_ankle05 vol = 200 
			RANDOMEND 
		ELSE 
			RANDOM_NO_REPEAT(1, 1, 1, 1) 
				RANDOMCASE PlayStream customf_ankle01 vol = 200 
				RANDOMCASE PlayStream customf_ankle03 vol = 200 
				RANDOMCASE PlayStream customf_ankle04 vol = 200 
				RANDOMCASE PlayStream customf_ankle05 vol = 200 
			RANDOMEND 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT HandleBailKickStream 
	IF ProfileEquals is_custom 
		IF ProfileEquals is_male 
			RANDOM_NO_REPEAT(1, 1, 1, 1) 
				RANDOMCASE PlayStream customm_kick01 vol = 200 
				RANDOMCASE PlayStream customm_kick02 vol = 200 
				RANDOMCASE PlayStream customm_kick03 vol = 200 
				RANDOMCASE PlayStream customm_kick04 vol = 200 
			RANDOMEND 
		ELSE 
			RANDOM_NO_REPEAT(1, 1, 1, 1) 
				RANDOMCASE PlayStream customf_kick01 vol = 200 
				RANDOMCASE PlayStream customf_kick02 vol = 200 
				RANDOMCASE PlayStream customf_kick03 vol = 200 
				RANDOMCASE PlayStream customf_kick04 vol = 200 
			RANDOMEND 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT HandleTurnOnSkaterLoopingSound 
	SkaterLoopingSound_TurnOn 
ENDSCRIPT

SCRIPT HandleTerrainLandSound 
	PlayLandSound 
ENDSCRIPT

SCRIPT HandleTerrainBonkSound 
	PlayBonkSound 
ENDSCRIPT

SCRIPT HandleSoundEffectEvent 
	Obj_PlaySound <name> 
ENDSCRIPT

SCRIPT HandleHitGroundSoundEffect 
ENDSCRIPT

SCRIPT HandleFootstepWalkSoundEffectEvent 
	RANDOM_NO_REPEAT(1, 1, 1) 
		RANDOMCASE Obj_PlaySound WalkStepConc01_11 pitch = RANDOM_RANGE PAIR(97.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(105.00000000000, 120.00000000000) 
		RANDOMCASE Obj_PlaySound WalkStepConc03_11 pitch = RANDOM_RANGE PAIR(97.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(105.00000000000, 120.00000000000) 
		RANDOMCASE Obj_PlaySound WalkStepConc05_11 pitch = RANDOM_RANGE PAIR(97.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(105.00000000000, 120.00000000000) 
	RANDOMEND 
ENDSCRIPT

SCRIPT HandlePedFootstepWalkSoundEffectEvent 
	RANDOM_NO_REPEAT(1, 1, 1) 
		RANDOMCASE Obj_PlaySound WalkStepConc01_11 pitch = RANDOM_RANGE PAIR(97.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(30.00000000000, 40.00000000000) 
		RANDOMCASE Obj_PlaySound WalkStepConc03_11 pitch = RANDOM_RANGE PAIR(97.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(30.00000000000, 40.00000000000) 
		RANDOMCASE Obj_PlaySound WalkStepConc05_11 pitch = RANDOM_RANGE PAIR(97.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(30.00000000000, 40.00000000000) 
	RANDOMEND 
ENDSCRIPT

SCRIPT HandleFootstepRunSoundEffectEvent 
	RANDOM_NO_REPEAT(1, 1, 1, 1, 1) 
		RANDOMCASE Obj_PlaySound RunStepConc01 pitch = RANDOM_RANGE PAIR(97.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(105.00000000000, 120.00000000000) 
		RANDOMCASE Obj_PlaySound RunStepConc02 pitch = RANDOM_RANGE PAIR(97.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(105.00000000000, 120.00000000000) 
		RANDOMCASE Obj_PlaySound RunStepConc03 pitch = RANDOM_RANGE PAIR(97.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(105.00000000000, 120.00000000000) 
		RANDOMCASE Obj_PlaySound RunStepConc04 pitch = RANDOM_RANGE PAIR(97.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(105.00000000000, 120.00000000000) 
		RANDOMCASE Obj_PlaySound RunStepConc05 pitch = RANDOM_RANGE PAIR(97.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(105.00000000000, 120.00000000000) 
	RANDOMEND 
ENDSCRIPT

SCRIPT HandlePedFootstepRunSoundEffectEvent 
	RANDOM_NO_REPEAT(1, 1, 1, 1, 1) 
		RANDOMCASE Obj_PlaySound RunStepConc01 pitch = RANDOM_RANGE PAIR(97.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(30.00000000000, 40.00000000000) 
		RANDOMCASE Obj_PlaySound RunStepConc02 pitch = RANDOM_RANGE PAIR(97.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(30.00000000000, 40.00000000000) 
		RANDOMCASE Obj_PlaySound RunStepConc03 pitch = RANDOM_RANGE PAIR(97.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(30.00000000000, 40.00000000000) 
		RANDOMCASE Obj_PlaySound RunStepConc04 pitch = RANDOM_RANGE PAIR(97.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(30.00000000000, 40.00000000000) 
		RANDOMCASE Obj_PlaySound RunStepConc05 pitch = RANDOM_RANGE PAIR(97.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(30.00000000000, 40.00000000000) 
	RANDOMEND 
ENDSCRIPT

SCRIPT HandleFootstepScuffSoundEffect 
	RANDOM_NO_REPEAT(1, 1) 
		RANDOMCASE Obj_PlaySound ScuffStepConc01 pitch = RANDOM_RANGE PAIR(85.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(105.00000000000, 120.00000000000) 
		RANDOMCASE Obj_PlaySound ScuffStepConc02 pitch = RANDOM_RANGE PAIR(85.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(105.00000000000, 120.00000000000) 
	RANDOMEND 
ENDSCRIPT

SCRIPT HandlePedFootstepScuffSoundEffect 
	RANDOM_NO_REPEAT(1, 1) 
		RANDOMCASE Obj_PlaySound ScuffStepConc01 pitch = RANDOM_RANGE PAIR(85.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(30.00000000000, 40.00000000000) 
		RANDOMCASE Obj_PlaySound ScuffStepConc02 pitch = RANDOM_RANGE PAIR(85.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(30.00000000000, 40.00000000000) 
	RANDOMEND 
ENDSCRIPT

SCRIPT HandleFootstepJumpSoundEffect 
	Obj_PlaySound JumpStepConc01 pitch = RANDOM_RANGE PAIR(97.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(105.00000000000, 120.00000000000) 
ENDSCRIPT

SCRIPT HandlePedFootstepJumpSoundEffect 
	Obj_PlaySound JumpStepConc01 pitch = RANDOM_RANGE PAIR(97.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(30.00000000000, 40.00000000000) 
ENDSCRIPT

SCRIPT HandleFootstepLandSoundEffect 
	Obj_PlaySound LandStepConc02 pitch = RANDOM_RANGE PAIR(97.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(105.00000000000, 120.00000000000) 
ENDSCRIPT

SCRIPT HandlePedFootstepLandSoundEffect 
	Obj_PlaySound LandStepConc02 pitch = RANDOM_RANGE PAIR(97.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(30.00000000000, 40.00000000000) 
ENDSCRIPT

SCRIPT HandleBailBodyFallSoundEffect 
	RANDOM_NO_REPEAT(1, 1, 1, 1, 1) 
		RANDOMCASE Obj_PlaySound BailBodyFall01 pitch = RANDOM_RANGE PAIR(95.00000000000, 105.00000000000) vol = RANDOM_RANGE PAIR(90.00000000000, 100.00000000000) 
		RANDOMCASE Obj_PlaySound BailBodyFall02 pitch = RANDOM_RANGE PAIR(95.00000000000, 105.00000000000) vol = RANDOM_RANGE PAIR(90.00000000000, 100.00000000000) 
		RANDOMCASE Obj_PlaySound BailBodyFall03 pitch = RANDOM_RANGE PAIR(95.00000000000, 105.00000000000) vol = RANDOM_RANGE PAIR(90.00000000000, 100.00000000000) 
		RANDOMCASE Obj_PlaySound BailBodyFall04 pitch = RANDOM_RANGE PAIR(95.00000000000, 105.00000000000) vol = RANDOM_RANGE PAIR(90.00000000000, 100.00000000000) 
		RANDOMCASE Obj_PlaySound BailBodyFall05 pitch = RANDOM_RANGE PAIR(95.00000000000, 105.00000000000) vol = RANDOM_RANGE PAIR(90.00000000000, 100.00000000000) 
	RANDOMEND 
ENDSCRIPT

SCRIPT HandlePedBailBodyFallSoundEffect 
	RANDOM_NO_REPEAT(1, 1, 1, 1, 1) 
		RANDOMCASE Obj_PlaySound BailBodyFall01 pitch = RANDOM_RANGE PAIR(95.00000000000, 105.00000000000) vol = RANDOM_RANGE PAIR(40.00000000000, 50.00000000000) 
		RANDOMCASE Obj_PlaySound BailBodyFall02 pitch = RANDOM_RANGE PAIR(95.00000000000, 105.00000000000) vol = RANDOM_RANGE PAIR(40.00000000000, 50.00000000000) 
		RANDOMCASE Obj_PlaySound BailBodyFall03 pitch = RANDOM_RANGE PAIR(95.00000000000, 105.00000000000) vol = RANDOM_RANGE PAIR(40.00000000000, 50.00000000000) 
		RANDOMCASE Obj_PlaySound BailBodyFall04 pitch = RANDOM_RANGE PAIR(95.00000000000, 105.00000000000) vol = RANDOM_RANGE PAIR(40.00000000000, 50.00000000000) 
		RANDOMCASE Obj_PlaySound BailBodyFall05 pitch = RANDOM_RANGE PAIR(95.00000000000, 105.00000000000) vol = RANDOM_RANGE PAIR(40.00000000000, 50.00000000000) 
	RANDOMEND 
ENDSCRIPT

SCRIPT HandleBailBodyPunchSoundEffect 
	RANDOM_NO_REPEAT(1, 1, 1, 1, 1) 
		RANDOMCASE Obj_PlaySound BailBodyPunch01_11 pitch = RANDOM_RANGE PAIR(80.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(140.00000000000, 150.00000000000) 
		RANDOMCASE Obj_PlaySound BailBodyPunch02_11 pitch = RANDOM_RANGE PAIR(80.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(140.00000000000, 150.00000000000) 
		RANDOMCASE Obj_PlaySound BailBodyPunch03_11 pitch = RANDOM_RANGE PAIR(80.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(140.00000000000, 150.00000000000) 
		RANDOMCASE Obj_PlaySound BailBodyPunch04_11 pitch = RANDOM_RANGE PAIR(80.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(140.00000000000, 150.00000000000) 
		RANDOMCASE Obj_PlaySound BailBodyPunch05_11 pitch = RANDOM_RANGE PAIR(80.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(140.00000000000, 150.00000000000) 
	RANDOMEND 
ENDSCRIPT

SCRIPT HandlePedBailBodyPunchSoundEffect 
	RANDOM_NO_REPEAT(1, 1, 1, 1, 1) 
		RANDOMCASE Obj_PlaySound BailBodyPunch01_11 pitch = RANDOM_RANGE PAIR(80.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(40.00000000000, 50.00000000000) 
		RANDOMCASE Obj_PlaySound BailBodyPunch02_11 pitch = RANDOM_RANGE PAIR(80.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(40.00000000000, 50.00000000000) 
		RANDOMCASE Obj_PlaySound BailBodyPunch03_11 pitch = RANDOM_RANGE PAIR(80.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(40.00000000000, 50.00000000000) 
		RANDOMCASE Obj_PlaySound BailBodyPunch04_11 pitch = RANDOM_RANGE PAIR(80.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(40.00000000000, 50.00000000000) 
		RANDOMCASE Obj_PlaySound BailBodyPunch05_11 pitch = RANDOM_RANGE PAIR(80.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(40.00000000000, 50.00000000000) 
	RANDOMEND 
ENDSCRIPT

SCRIPT HandleBailCrackSoundEffect 
	Obj_PlaySound BailCrack01 pitch = RANDOM_RANGE PAIR(100.00000000000, 110.00000000000) vol = RANDOM_RANGE PAIR(120.00000000000, 130.00000000000) 
ENDSCRIPT

SCRIPT HandlePedBailCrackSoundEffect 
	Obj_PlaySound BailCrack01 pitch = RANDOM_RANGE PAIR(100.00000000000, 110.00000000000) vol = RANDOM_RANGE PAIR(40.00000000000, 50.00000000000) 
ENDSCRIPT

SCRIPT HandleBailSlapSoundEffect 
	printf "******playing bail slap sfx" 
	RANDOM_NO_REPEAT(1, 1, 1) 
		RANDOMCASE Obj_PlaySound BailSlap01 pitch = RANDOM_RANGE PAIR(95.00000000000, 115.00000000000) vol = RANDOM_RANGE PAIR(140.00000000000, 150.00000000000) 
		RANDOMCASE Obj_PlaySound BailSlap02 pitch = RANDOM_RANGE PAIR(95.00000000000, 115.00000000000) vol = RANDOM_RANGE PAIR(140.00000000000, 150.00000000000) 
		RANDOMCASE Obj_PlaySound BailSlap03 pitch = RANDOM_RANGE PAIR(95.00000000000, 115.00000000000) vol = RANDOM_RANGE PAIR(140.00000000000, 150.00000000000) 
	RANDOMEND 
ENDSCRIPT

SCRIPT HandlePedBailSlapSoundEffect 
	RANDOM_NO_REPEAT(1, 1, 1) 
		RANDOMCASE Obj_PlaySound BailSlap01 pitch = RANDOM_RANGE PAIR(95.00000000000, 115.00000000000) vol = RANDOM_RANGE PAIR(40.00000000000, 50.00000000000) 
		RANDOMCASE Obj_PlaySound BailSlap02 pitch = RANDOM_RANGE PAIR(95.00000000000, 115.00000000000) vol = RANDOM_RANGE PAIR(40.00000000000, 50.00000000000) 
		RANDOMCASE Obj_PlaySound BailSlap03 pitch = RANDOM_RANGE PAIR(95.00000000000, 115.00000000000) vol = RANDOM_RANGE PAIR(40.00000000000, 50.00000000000) 
	RANDOMEND 
ENDSCRIPT

SCRIPT HandleBailScrapeSoundEffect 
	RANDOM_NO_REPEAT(1, 1, 1) 
		RANDOMCASE Obj_PlaySound BailScrape01 pitch = RANDOM_RANGE PAIR(95.00000000000, 115.00000000000) vol = RANDOM_RANGE PAIR(120.00000000000, 130.00000000000) 
		RANDOMCASE Obj_PlaySound BailScrape02 pitch = RANDOM_RANGE PAIR(95.00000000000, 115.00000000000) vol = RANDOM_RANGE PAIR(120.00000000000, 130.00000000000) 
		RANDOMCASE Obj_PlaySound BailScrape03 pitch = RANDOM_RANGE PAIR(95.00000000000, 115.00000000000) vol = RANDOM_RANGE PAIR(120.00000000000, 130.00000000000) 
	RANDOMEND 
ENDSCRIPT

SCRIPT HandlePedBailScrapeSoundEffect 
	RANDOM_NO_REPEAT(1, 1, 1) 
		RANDOMCASE Obj_PlaySound BailScrape01 pitch = RANDOM_RANGE PAIR(95.00000000000, 115.00000000000) vol = RANDOM_RANGE PAIR(40.00000000000, 50.00000000000) 
		RANDOMCASE Obj_PlaySound BailScrape02 pitch = RANDOM_RANGE PAIR(95.00000000000, 115.00000000000) vol = RANDOM_RANGE PAIR(40.00000000000, 50.00000000000) 
		RANDOMCASE Obj_PlaySound BailScrape03 pitch = RANDOM_RANGE PAIR(95.00000000000, 115.00000000000) vol = RANDOM_RANGE PAIR(40.00000000000, 50.00000000000) 
	RANDOMEND 
ENDSCRIPT

SCRIPT HandleBailBoardSoundEffect 
	RANDOM_NO_REPEAT(1, 1, 1, 1, 1) 
		RANDOMCASE Obj_PlaySound BailBoard01 pitch = RANDOM_RANGE PAIR(100.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(115.00000000000, 125.00000000000) 
		RANDOMCASE Obj_PlaySound BailBoard02 pitch = RANDOM_RANGE PAIR(100.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(115.00000000000, 125.00000000000) 
		RANDOMCASE Obj_PlaySound BailBoard03 pitch = RANDOM_RANGE PAIR(100.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(115.00000000000, 125.00000000000) 
		RANDOMCASE Obj_PlaySound BailBoard04 pitch = RANDOM_RANGE PAIR(100.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(115.00000000000, 125.00000000000) 
		RANDOMCASE Obj_PlaySound BailBoard05 pitch = RANDOM_RANGE PAIR(100.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(115.00000000000, 125.00000000000) 
	RANDOMEND 
ENDSCRIPT

SCRIPT HandlePedBailBoardSoundEffect 
	RANDOM_NO_REPEAT(1, 1, 1, 1, 1) 
		RANDOMCASE Obj_PlaySound BailBoard01 pitch = RANDOM_RANGE PAIR(100.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(40.00000000000, 50.00000000000) 
		RANDOMCASE Obj_PlaySound BailBoard02 pitch = RANDOM_RANGE PAIR(100.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(40.00000000000, 50.00000000000) 
		RANDOMCASE Obj_PlaySound BailBoard03 pitch = RANDOM_RANGE PAIR(100.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(40.00000000000, 50.00000000000) 
		RANDOMCASE Obj_PlaySound BailBoard04 pitch = RANDOM_RANGE PAIR(100.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(40.00000000000, 50.00000000000) 
		RANDOMCASE Obj_PlaySound BailBoard05 pitch = RANDOM_RANGE PAIR(100.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(40.00000000000, 50.00000000000) 
	RANDOMEND 
ENDSCRIPT


