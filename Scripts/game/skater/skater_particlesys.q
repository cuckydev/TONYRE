SCRIPT InitSkaterParticles 
	Obj_GetId 
	MangleChecksums a = skater_blood_system b = <objId> 
	MangleChecksums a = <mangled_id> b = Bone_Head 
	IF NOT ParticleExists <mangled_id> 
		CreateParticleSystem params = { objId = <objId> bone = Bone_Head name = <mangled_id> } name = <mangled_id> max = 25 emitscript = skater_blood_emit updatescript = skater_blood_update texture = particle_test02 blendmode = blend perm = 1 
	ENDIF 
	Obj_GetId 
	MangleChecksums a = skater_sparks_system b = <objId> 
	MangleChecksums a = <mangled_id> b = Bone_Board_Tail 
	IF NOT ParticleExists <mangled_id> 
		CreateParticleSystem params = { objId = <objId> bone = Bone_Board_Tail name = <mangled_id> } name = <mangled_id> max = 40 emitscript = skater_sparks_emit updatescript = skater_sparks_update blendmode = blend type = GlowRibbontrail history = 2 perm = 1 
	ENDIF 
	Obj_GetId 
	MangleChecksums a = skatersplash b = <objId> 
	IF NOT ParticleExists name = <mangled_id> 
		IF InMultiPlayerGame 
			CreateParticleSystem params = { objId = <objId> bone = Bone_Pelvis name = <mangled_id> } name = <mangled_id> max = 30 emitscript = emit_skatersplash blendmode = blend type = Glow perm = 1 segments = 5 
		ELSE 
			CreateParticleSystem params = { objId = <objId> bone = Bone_Pelvis name = <mangled_id> } name = <mangled_id> max = 80 emitscript = emit_skatersplash blendmode = blend type = Glow perm = 1 segments = 5 
		ENDIF 
		Skatersplashoff 
	ENDIF 
ENDSCRIPT

SCRIPT DestroySkaterParticles 
	Obj_GetId 
	MangleChecksums a = skater_blood_system b = <objId> 
	MangleChecksums a = <mangled_id> b = Bone_Head 
	DestroyParticleSystem name = <mangled_id> 
	Obj_GetId 
	MangleChecksums a = skater_sparks_system b = <objId> 
	MangleChecksums a = <mangled_id> b = Bone_Board_Tail 
	DestroyParticleSystem name = <mangled_id> 
	Obj_GetId 
	MangleChecksums a = skatersplash b = <objId> 
	DestroyParticleSystem name = <mangled_id> 
ENDSCRIPT

SCRIPT ResetSkaterParticleSystems 
	CleanUp_SpecialTrickParticles 
	BloodParticlesOff 
	Skatersplashoff 
	SparksOff 
	Obj_GetId 
	MangleChecksums a = skater_blood_system b = <objId> 
	MangleChecksums a = <mangled_id> b = Bone_Head 
	SetScript name = <mangled_id> emitscript = skater_blood_emit 
	Obj_GetId 
	MangleChecksums a = skater_sparks_system b = <objId> 
	MangleChecksums a = <mangled_id> b = Bone_Board_Tail 
	SetScript name = <mangled_id> emitscript = skater_sparks_emit updatescript = skater_sparks_update 
	Obj_GetId 
	MangleChecksums a = skatersplash b = <objId> 
	SetScript name = <mangled_id> emitscript = emit_skatersplash 
ENDSCRIPT

SCRIPT skater_blood_emit 
	setlife min = 0.25000000000 max = 1 
	setanglespread spread = 0.10000000149 
	setspeedrange min = 4 max = 8 
	setforce force = VECTOR(0.00000000000, -0.50000000000, 0.00000000000) 
	setparticlesize sw = 2 sh = 2 ew = 2 eh = 2 
	setcolor corner = 0 sr = 100 sg = 0 sb = 0 sa = 255 er = 80 eg = 0 eb = 0 ea = 0 
	setcolor corner = 1 sr = 100 sg = 0 sb = 0 sa = 255 er = 80 eg = 0 eb = 0 ea = 0 
	setcolor corner = 2 sr = 100 sg = 0 sb = 0 sa = 255 er = 80 eg = 0 eb = 0 ea = 0 
	setcolor corner = 3 sr = 100 sg = 0 sb = 0 sa = 255 er = 80 eg = 0 eb = 0 ea = 0 
	BEGIN 
		IF ShouldEmitParticles name = <name> 
			emit num = 1 
		ENDIF 
		wait 1 gameframe 
	REPEAT 
ENDSCRIPT

SCRIPT skater_blood_emit_super 
	setlife min = 0.25000000000 max = 1 
	setanglespread spread = 0.30000001192 
	setspeedrange min = 4 max = 10 
	setforce force = VECTOR(0.00000000000, -0.50000000000, 0.00000000000) 
	setparticlesize sw = 2 sh = 2 ew = 6 eh = 6 
	setcolor corner = 0 sr = 50 sg = 0 sb = 0 sa = 255 er = 50 eg = 0 eb = 0 ea = 0 
	setcolor corner = 1 sr = 50 sg = 0 sb = 0 sa = 255 er = 50 eg = 0 eb = 0 ea = 0 
	setcolor corner = 2 sr = 50 sg = 0 sb = 0 sa = 255 er = 50 eg = 0 eb = 0 ea = 0 
	setcolor corner = 3 sr = 50 sg = 0 sb = 0 sa = 255 er = 50 eg = 0 eb = 0 ea = 0 
	BEGIN 
		IF ShouldEmitParticles name = <name> 
			emit num = 1 
		ENDIF 
		wait 1 gameframe 
	REPEAT 
ENDSCRIPT

SCRIPT skater_sparks_emit 
	setlife min = 0.25000000000 max = 0.30000001192 
	setanglespread spread = 0.25000000000 
	setspeedrange min = 4 max = 8 
	setforce force = VECTOR(0.00000000000, -0.30000001192, 0.00000000000) 
	setparticlesize sw = 1.25000000000 sh = 1.25000000000 ew = 0.75000000000 eh = 0.75000000000 
	setcolor corner = 0 sr = 255 sg = 255 sb = 255 sa = 255 ma = 255 er = 255 eg = 255 eb = 255 ea = 0 
	setcolor corner = 1 sr = 255 sg = 255 sb = 64 sa = 128 ma = 128 er = 255 eg = 64 eb = 64 ea = 0 
	setcolor corner = 2 sr = 255 sg = 64 sb = 64 sa = 0 ma = 0 er = 255 eg = 64 eb = 64 ea = 0 
	setcolor corner = 3 sr = 255 sg = 255 sb = 64 sa = 80 ma = 80 er = 255 eg = 128 eb = 64 ea = 0 
	setcolor corner = 4 sr = 255 sg = 255 sb = 64 sa = 64 ma = 64 er = 255 eg = 128 eb = 64 ea = 0 
	setcolor corner = 5 sr = 255 sg = 255 sb = 64 sa = 0 ma = 0 er = 255 eg = 128 eb = 64 ea = 0 
	BEGIN 
		IF ShouldEmitParticles name = <name> 
			emit num = RANDOM_RANGE PAIR(1.00000000000, 2.00000000000) 
		ENDIF 
		wait 1 gameframe 
	REPEAT 
ENDSCRIPT

SCRIPT skater_elec_sparks_emit 
	setlife min = 0.25000000000 max = 0.30000001192 
	setanglespread spread = 0.25000000000 
	setspeedrange min = 4 max = 8 
	setforce force = VECTOR(0.00000000000, -0.30000001192, 0.00000000000) 
	setparticlesize sw = 1.25000000000 sh = 1.25000000000 ew = 0.75000000000 eh = 0.75000000000 
	setcolor corner = 0 sr = 255 sg = 255 sb = 255 sa = 255 ma = 255 er = 255 eg = 255 eb = 255 ea = 0 
	setcolor corner = 1 sr = 124 sg = 255 sb = 255 sa = 128 ma = 128 er = 124 eg = 64 eb = 255 ea = 0 
	setcolor corner = 2 sr = 124 sg = 64 sb = 255 sa = 0 ma = 0 er = 124 eg = 64 eb = 255 ea = 0 
	setcolor corner = 3 sr = 124 sg = 255 sb = 255 sa = 80 ma = 80 er = 124 eg = 128 eb = 255 ea = 0 
	setcolor corner = 4 sr = 124 sg = 255 sb = 255 sa = 64 ma = 64 er = 124 eg = 128 eb = 255 ea = 0 
	setcolor corner = 5 sr = 124 sg = 255 sb = 255 sa = 0 ma = 0 er = 124 eg = 128 eb = 255 ea = 0 
	BEGIN 
		IF ShouldEmitParticles name = <name> 
			emit num = RANDOM_RANGE PAIR(1.00000000000, 2.00000000000) 
		ENDIF 
		wait 1 gameframe 
	REPEAT 
ENDSCRIPT

SCRIPT skater_flames_emit 
	setlife min = 0.25000000000 max = 0.30000001192 
	setanglespread spread = 0.25000000000 
	setspeedrange min = 4 max = 8 
	setforce force = VECTOR(0.00000000000, -0.30000001192, 0.00000000000) 
	setparticlesize sw = 4 sh = 4 ew = 4 eh = 4 
	setcolor corner = 0 sr = 255 sg = 255 sb = 255 sa = 255 ma = 255 er = 255 eg = 255 eb = 255 ea = 0 
	setcolor corner = 1 sr = 255 sg = 255 sb = 64 sa = 128 ma = 128 er = 255 eg = 64 eb = 64 ea = 0 
	setcolor corner = 2 sr = 255 sg = 64 sb = 64 sa = 0 ma = 0 er = 255 eg = 64 eb = 64 ea = 0 
	setcolor corner = 3 sr = 255 sg = 255 sb = 64 sa = 80 ma = 80 er = 255 eg = 128 eb = 64 ea = 0 
	setcolor corner = 4 sr = 255 sg = 255 sb = 64 sa = 64 ma = 64 er = 255 eg = 128 eb = 64 ea = 0 
	setcolor corner = 5 sr = 255 sg = 255 sb = 64 sa = 0 ma = 0 er = 255 eg = 128 eb = 64 ea = 0 
	BEGIN 
		IF ShouldEmitParticles name = <name> 
			emit num = RANDOM_RANGE PAIR(2.00000000000, 4.00000000000) 
		ENDIF 
		wait 1 gameframe 
	REPEAT 
ENDSCRIPT

SCRIPT sparks_on bone = Bone_Board_Tail 
	Obj_GetId 
	MangleChecksums a = skater_sparks_system b = <objId> 
	MangleChecksums a = <mangled_id> b = <bone> 
	IF NOT GetGlobalFlag Flag = CHEAT_FLAME 
		set_spark_script name = <mangled_id> 
	ELSE 
		SetScript name = <mangled_id> emitscript = skater_flames_emit 
	ENDIF 
	ParticlesOn name = <mangled_id> 
ENDSCRIPT

SCRIPT set_spark_script 
	GetTerrain 
	IF ( ( <Terrain> = 41 ) | ( <Terrain> = 50 ) | ( <Terrain> = 54 ) ) 
		SetScript name = <name> emitscript = skater_elec_sparks_emit 
	ELSE 
		SetScript name = <name> emitscript = skater_sparks_emit 
	ENDIF 
ENDSCRIPT

SCRIPT sparks_off bone = Bone_Board_Tail 
	Obj_GetId 
	MangleChecksums a = skater_sparks_system b = <objId> 
	MangleChecksums a = <mangled_id> b = <bone> 
	ParticlesOff name = <mangled_id> 
ENDSCRIPT

SCRIPT TurnOffSkaterSparks 
	sparks_off bone = Bone_Board_Tail 
ENDSCRIPT

SCRIPT SkaterBloodOn num = 10 
	VerifyParam param = name func = SkaterBloodOn <...> 
	IF NOT GetGlobalFlag Flag = CHEAT_SUPER_BLOOD 
		SetScript name = <name> emitscript = skater_blood_emit 
	ELSE 
		SetScript name = <name> emitscript = skater_blood_emit_super 
	ENDIF 
	BEGIN 
		ParticlesOn name = <name> 
		wait 1 gameframe 
	REPEAT <num> 
	ParticlesOff name = <name> 
ENDSCRIPT

SCRIPT SkaterBloodOff 
	VerifyParam param = name func = SkaterBloodOff <...> 
	ParticlesOff name = <name> 
ENDSCRIPT

SCRIPT BloodParticlesOn bone = Bone_Head 
	Obj_GetId 
	MangleChecksums a = skater_blood_system b = <objId> 
	MangleChecksums a = <mangled_id> b = <bone> 
	Obj_SpawnScript SkaterBloodOn params = { name = <mangled_id> num = <num> } 
ENDSCRIPT

SCRIPT BloodParticlesOff bone = Bone_Head 
	Obj_GetId 
	MangleChecksums a = skater_blood_system b = <objId> 
	MangleChecksums a = <mangled_id> b = Bone_Head 
	SkaterBloodOff name = <mangled_id> 
	EmptyParticleSystem name = <mangled_id> 
ENDSCRIPT

SCRIPT skater_blood_update 
	BEGIN 
		<objId> : Obj_GetBonePosition bone = <bone> 
		setpos x = <x> y = <y> z = <z> 
		wait 1 gameframe 
	REPEAT 
ENDSCRIPT

SCRIPT SetSparksTruckFromNollie 
	IF InNollie 
		SetFrontTruckSparks 
	ELSE 
		SetRearTruckSparks 
	ENDIF 
ENDSCRIPT

SCRIPT skater_sparks_update bone_front = Bone_Board_Nose bone_back = Bone_Board_Tail Nosegrind = 0 
	BEGIN 
		IF ShouldEmitParticles name = <name> 
			<objId> : Obj_GetOrientation 
			RotateVector x = <x> y = <y> z = <z> ry = 180 
			SetEmitTarget x = <x> y = 0.50000000000 z = <z> 
			IF <objId> : FrontTruckSparks 
				IF <objId> : BoardIsRotated 
					<objId> : Obj_GetBonePosition bone = <bone_back> 
				ELSE 
					<objId> : Obj_GetBonePosition bone = <bone_front> 
				ENDIF 
			ELSE 
				IF <objId> : BoardIsRotated 
					<objId> : Obj_GetBonePosition bone = <bone_front> 
				ELSE 
					<objId> : Obj_GetBonePosition bone = <bone_back> 
				ENDIF 
			ENDIF 
			<y> = ( <y> -2.00000000000 ) 
			setpos x = <x> y = <y> z = <z> 
		ENDIF 
		wait 1 gameframe 
	REPEAT 
ENDSCRIPT

SCRIPT skatersplash_update bone = Bone_Pelvis 
	BEGIN 
		<objId> : Obj_GetBonePosition bone = <bone> 
		setpos x = <x> y = <y> z = <z> 
		wait 1 gameframe 
	REPEAT 
ENDSCRIPT

SCRIPT Skatersplashoff 
	Obj_GetId 
	MangleChecksums a = skatersplash b = <objId> 
	ParticlesOff name = <mangled_id> 
	EmptyParticleSystem name = <mangled_id> 
ENDSCRIPT

SCRIPT SkaterSplashOn 
	Obj_GetId 
	MangleChecksums a = skatersplash b = <objId> 
	SetScript name = <mangled_id> emitscript = emit_skatersplash 
	ParticlesOn name = <mangled_id> 
ENDSCRIPT

SCRIPT emit_skatersplash 
	setlife min = 0.25000000000 max = 0.25000000000 
	setanglespread spread = 0.40000000596 
	setspeedrange min = 1.00000000000 max = 10.00000000000 
	setemitrange width = 4.00000000000 height = 4.00000000000 
	setforce force = VECTOR(0.00000000000, -0.30000001192, 0.00000000000) 
	SetEmitTarget target = VECTOR(0.00000000000, 1.00000000000, 0.00000000000) 
	setparticlesize sw = 3.00000000000 sh = 6.00000000000 ew = 0.10000000149 eh = 0.20000000298 
	setcolor corner = 0 sr = 255 sg = 255 sb = 255 sa = 64 ma = 64 er = 255 eg = 255 eb = 255 ea = 0 midtime = -1 
	setcolor corner = 1 sr = 255 sg = 255 sb = 255 sa = 32 ma = 32 er = 255 eg = 255 eb = 255 ea = 0 midtime = -1 
	setcolor corner = 2 sr = 255 sg = 255 sb = 255 sa = 0 ma = 0 er = 255 eg = 255 eb = 255 ea = 0 midtime = -1 
	SetCircularEmit circular = 0 
	BEGIN 
		IF ShouldEmitParticles name = <name> 
			<objId> : Obj_GetBonePosition bone = Bone_Bone_Pelvis 
			setpos x = <x> y = <y> z = <z> 
			emit num = 50 
		ENDIF 
		wait 1 game frame 
	REPEAT 
ENDSCRIPT

SCRIPT emit_jumpjets 
	setlife min = 0.30000001192 max = 0.40000000596 
	setanglespread spread = 0.20000000298 
	setspeedrange min = 3.00000000000 max = 10.00000000000 
	setemitrange width = 2.00000000000 height = 2.00000000000 
	setforce force = VECTOR(0.00000000000, -0.30000001192, 0.00000000000) 
	SetEmitTarget target = VECTOR(0.00000000000, -1.00000000000, 0.00000000000) 
	setparticlesize sw = 10.00000000000 sh = 15.00000000000 ew = 1 eh = 1.00000000000 
	setcolor corner = 0 sr = 255 sg = 255 sb = 255 sa = 255 ma = 255 er = 255 eg = 255 eb = 255 ea = 0 
	setcolor corner = 1 sr = 255 sg = 255 sb = 64 sa = 128 ma = 128 er = 255 eg = 64 eb = 64 ea = 0 
	setcolor corner = 2 sr = 255 sg = 64 sb = 64 sa = 0 ma = 0 er = 255 eg = 64 eb = 64 ea = 0 
	SetCircularEmit circular = 0 
	BEGIN 
		IF ShouldEmitParticles name = <name> 
			emit num = 5 
		ENDIF 
		wait 1 game frame 
	REPEAT 
ENDSCRIPT

SCRIPT update_jumpjets 
	BEGIN 
		<objId> : Obj_GetBonePosition bone = Bone_Pelvis 
		setpos x = <x> y = <y> z = <z> 
		wait 1 gameframe 
	REPEAT 
ENDSCRIPT

SCRIPT chad_sparks_emit 
	setlife min = 0.20000000298 max = 0.30000001192 
	setanglespread spread = 0.15000000596 
	setspeedrange min = 4 max = 8 
	setforce force = VECTOR(0.00000000000, -0.30000001192, 0.00000000000) 
	setparticlesize sw = 1 sh = 1 ew = 2 eh = 2 
	setcolor corner = 0 sr = 128 sg = 0 sb = 200 sa = 240 ma = 240 er = 128 eg = 0 eb = 240 ea = 0 
	setcolor corner = 1 sr = 128 sg = 0 sb = 200 sa = 128 ma = 128 er = 128 eg = 0 eb = 200 ea = 0 
	setcolor corner = 2 sr = 128 sg = 0 sb = 200 sa = 0 ma = 0 er = 128 eg = 0 eb = 64 ea = 0 
	setcolor corner = 3 sr = 0 sg = 0 sb = 128 sa = 80 ma = 80 er = 0 eg = 0 eb = 64 ea = 0 
	setcolor corner = 4 sr = 0 sg = 0 sb = 128 sa = 64 ma = 64 er = 0 eg = 0 eb = 64 ea = 0 
	setcolor corner = 5 sr = 0 sg = 0 sb = 128 sa = 0 ma = 0 er = 0 eg = 0 eb = 64 ea = 0 
	BEGIN 
		IF ShouldEmitParticles name = <name> 
			emit num = 5 
		ENDIF 
		wait 1 gameframe 
	REPEAT 
ENDSCRIPT

SCRIPT jango_laser_emit 
	setlife min = 0.50000000000 max = 0.50000000000 
	setanglespread spread = 0 
	setspeedrange min = 8 max = 8 
	setforce force = VECTOR(0.00000000000, 0.00000000000, 0.00000000000) 
	setparticlesize sw = 2 sh = 2 ew = 12 eh = 12 
	setcolor corner = 0 sr = 255 sg = 200 sb = 200 sa = 255 ma = 255 er = 255 eg = 200 eb = 200 ea = 0 
	setcolor corner = 1 sr = 255 sg = 64 sb = 64 sa = 128 ma = 128 er = 255 eg = 64 eb = 64 ea = 0 
	setcolor corner = 2 sr = 255 sg = 64 sb = 64 sa = 0 ma = 0 er = 255 eg = 64 eb = 64 ea = 0 
	emit num = 5 
	BEGIN 
		IF ShouldEmitParticles name = <name> 
			emit num = 5 
		ENDIF 
		wait 76 frames 
	REPEAT 
ENDSCRIPT

SCRIPT laser_update 
	BEGIN 
		<objId> : Obj_GetOrientation 
		RotateVector x = <x> y = <y> z = <z> ry = 180 
		SetEmitTarget x = <x> y = 0.40000000596 z = <z> 
		<objId> : Obj_GetBonePosition bone = Bone_Board_Tail 
		<y> = ( <y> + 10 ) 
		setpos x = <x> y = <y> z = <z> 
		wait 1 gameframe 
	REPEAT 
ENDSCRIPT

skater_particle_composite_structure = 
[ 
	{ component = suspend } 
	{ component = particle } 
	{ component = lockobj } 
] 
SCRIPT CleanUp_SpecialTrickParticles 
	Obj_GetId 
	MangleChecksums a = <objId> b = SpecialTrickParticles 
	particle_id = <mangled_id> 
	IF ObjectExists id = <particle_id> 
		<particle_id> : Die 
	ENDIF 
ENDSCRIPT

SCRIPT Emit_SpecialTrickParticles bone = Bone_Head specialtrick_particles = barf_particles 
	Obj_GetId 
	MangleChecksums a = <objId> b = SpecialTrickParticles 
	particle_id = <mangled_id> 
	IF ObjectExists id = <particle_id> 
		<particle_id> : Die 
	ENDIF 
	wait 1 game frame 
	printf "about to create .........................." 
	IF NOT GotParam dont_orient_toskater 
		GetSkaterVelocity 
		vel = ( <vel_x> * VECTOR(1.00000000000, 0.00000000000, 0.00000000000) + <vel_y> * VECTOR(0.00000000000, 1.00000000000, 0.00000000000) + <vel_z> * VECTOR(0.00000000000, 0.00000000000, 1.00000000000) ) 
		CreateCompositeObject { 
			Components = skater_particle_composite_structure 
			params = { 
				name = <particle_id> 
				LocalSpace 
				vel = <vel> 
				orient_to_vel 
				<specialtrick_particles> 
		} } 
	ELSE 
		printf "Here?" 
		CreateCompositeObject { 
			Components = skater_particle_composite_structure 
			params = { 
				name = <particle_id> 
				LocalSpace 
				<specialtrick_particles> 
		} } 
	ENDIF 
	<particle_id> : Obj_LockToObject bone = <bone> id = <objId> 
	IF GotParam StopEmitAt 
		wait <StopEmitAt> seconds 
		IF ObjectExists id = <particle_id> 
			<particle_id> : SetEmitRate 0 
		ENDIF 
	ENDIF 
ENDSCRIPT

fire_particles = 
{ 
	Class = ParticleObject 
	type = Default 
	BoxDimsStart = VECTOR(20.41944122314, 20.24608993530, 0.35107499361) 
	MidPosition = VECTOR(-0.00213399995, -10.85268878937, -0.05867899954) 
	BoxDimsMid = VECTOR(6.27889776230, 6.27889776230, 6.27889776230) 
	EndPosition = VECTOR(-0.01586800069, -40.33533477783, -0.05868000165) 
	BoxDimsEnd = VECTOR(14.71387481689, 14.71387481689, 14.71387481689) 
	texture = dt_generic_particle01 
	CreatedAtStart 
	AbsentInNetGames 
	UseMidPoint 
	UseColorMidTime 
	type = NEWFLAT 
	blendmode = Add 
	FixedAlpha = 128 
	AlphaCutoff = 1 
	MaxStreams = 2 
	SuspendDistance = 0 
	lod_dist1 = 400 
	lod_dist2 = 401 
	EmitRate = 160.00000000000 
	Lifetime = 0.40000000596 
	MidPointPCT = 50 
	StartRadius = 7.00000000000 
	MidRadius = 5.00000000000 
	EndRadius = 3.50000000000 
	StartRadiusSpread = 1.00000000000 
	MidRadiusSpread = 1.00000000000 
	EndRadiusSpread = 1.00000000000 
	StartRGB = [ 150 , 72 , 25 ] 
	StartAlpha = 85 
	ColorMidTime = 50 
	MidRGB = [ 150 , 67 , 18 ] 
	MidAlpha = 85 
	EndRGB = [ 150 , 67 , 18 ] 
	EndAlpha = 0 
} 
barf_particles = 
{ 
	Class = ParticleObject 
	type = Default 
	BoxDimsStart = VECTOR(1.40137803555, 1.40137803555, 1.40137803555) 
	MidPosition = VECTOR(-0.00908999983, -17.07610130310, -0.03491999954) 
	BoxDimsMid = VECTOR(4.44386386871, 4.44386386871, 4.44386386871) 
	EndPosition = VECTOR(-0.06447999924, -64.39933013916, -0.03492100164) 
	BoxDimsEnd = VECTOR(6.66731977463, 6.66731977463, 6.66731977463) 
	texture = dt_barf02 
	CreatedAtStart 
	AbsentInNetGames 
	UseMidPoint 
	UseColorMidTime 
	type = NEWFLAT 
	blendmode = blend 
	FixedAlpha = 128 
	AlphaCutoff = 1 
	MaxStreams = 2 
	SuspendDistance = 0 
	lod_dist1 = 400 
	lod_dist2 = 401 
	EmitRate = 100.00000000000 
	Lifetime = 0.30000001192 
	MidPointPCT = 50 
	StartRadius = 1.00000000000 
	MidRadius = 2.00000000000 
	EndRadius = 3.00000000000 
	StartRadiusSpread = 1.00000000000 
	MidRadiusSpread = 1.00000000000 
	EndRadiusSpread = 1.00000000000 
	StartRGB = [ 105 , 111 , 96 ] 
	StartAlpha = 122 
	ColorMidTime = 50 
	MidRGB = [ 105 , 111 , 96 ] 
	MidAlpha = 160 
	EndRGB = [ 105 , 111 , 96 ] 
	EndAlpha = 50 
} 
firebreath_particles = 
{ 
	Class = ParticleObject 
	type = Default 
	BoxDimsStart = VECTOR(0.69999998808, 0.69999998808, 0.69999998808) 
	MidPosition = VECTOR(-0.00213799998, 10.16623592377, -0.05867899954) 
	BoxDimsMid = VECTOR(4.54235410690, 4.54235410690, 4.54235410690) 
	EndPosition = VECTOR(-0.01587600075, 38.12525558472, -0.05867600068) 
	BoxDimsEnd = VECTOR(9.06387519836, 9.06387519836, 9.06387519836) 
	texture = dt_generic_particle01 
	CreatedAtStart 
	AbsentInNetGames 
	UseMidPoint 
	UseColorMidTime 
	type = NEWFLAT 
	blendmode = Add 
	FixedAlpha = 128 
	AlphaCutoff = 1 
	MaxStreams = 2 
	SuspendDistance = 0 
	lod_dist1 = 400 
	lod_dist2 = 401 
	EmitRate = 250.00000000000 
	Lifetime = 0.20000000298 
	MidPointPCT = 50 
	StartRadius = 4.00000000000 
	MidRadius = 4.00000000000 
	EndRadius = 6.00000000000 
	StartRadiusSpread = 1.00000000000 
	MidRadiusSpread = 1.00000000000 
	EndRadiusSpread = 1.00000000000 
	StartRGB = [ 150 , 93 , 59 ] 
	StartAlpha = 82 
	ColorMidTime = 50 
	MidRGB = [ 150 , 67 , 18 ] 
	MidAlpha = 109 
	EndRGB = [ 150 , 67 , 18 ] 
	EndAlpha = 0 
} 
iron_particles = 
{ 
	Class = ParticleObject 
	type = Default 
	BoxDimsStart = VECTOR(0.18490299582, 0.18490299582, 0.18490299582) 
	MidPosition = VECTOR(0.00002800000, 0.03514999896, 550.59631347656) 
	BoxDimsMid = VECTOR(0.38812398911, 0.38812398911, 0.38812398911) 
	EndPosition = VECTOR(-0.00400599977, 1.28396201134, 1078.80957031250) 
	BoxDimsEnd = VECTOR(0.38973599672, 0.38973599672, 0.38973599672) 
	texture = dt_ironblast01 
	CreatedAtStart 
	AbsentInNetGames 
	UseMidPoint 
	UseColorMidTime 
	type = NEWFLAT 
	blendmode = Add 
	FixedAlpha = 128 
	AlphaCutoff = 1 
	MaxStreams = 2 
	SuspendDistance = 0 
	lod_dist1 = 400 
	lod_dist2 = 401 
	EmitRate = 1500.00000000000 
	Lifetime = 0.10000000149 
	MidPointPCT = 50 
	StartRadius = 6.00000000000 
	MidRadius = 6.00000000000 
	EndRadius = 6.00000000000 
	StartRadiusSpread = 0.00000000000 
	MidRadiusSpread = 0.00000000000 
	EndRadiusSpread = 0.00000000000 
	StartRGB = [ 150 , 93 , 59 ] 
	StartAlpha = 105 
	ColorMidTime = 50 
	MidRGB = [ 150 , 67 , 18 ] 
	MidAlpha = 122 
	EndRGB = [ 150 , 67 , 18 ] 
	EndAlpha = 0 
} 

