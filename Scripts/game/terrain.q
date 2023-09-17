
SCRIPT SetTerrainParticleProperties 
	printf "SetTerrainParticleProperties STUBBED OUT" 
ENDSCRIPT

TERRAIN_DEFAULT = 10000 
TERRAIN_CONCSMOOTH = 10001 
TERRAIN_CONCROUGH = 10002 
TERRAIN_METALSMOOTH = 10003 
TERRAIN_MEATALSMOOTH = 10003 
TERRAIN_METALROUGH = 10004 
TERRAIN_METALCORRUGATED = 10005 
TERRAIN_METALGRATING = 10006 
TERRAIN_METALTIN = 10007 
TERRAIN_WOOD = 10008 
TERRAIN_WOODMASONITE = 10009 
TERRAIN_WOODPLYWOOD = 10010 
TERRAIN_WOODFLIMSY = 10011 
TERRAIN_WOODSHINGLE = 10012 
TERRAIN_WOODPIER = 10013 
TERRAIN_BRICK = 10014 
TERRAIN_TILE = 10015 
TERRAIN_ASPHALT = 10016 
TERRAIN_ROCK = 10017 
TERRAIN_GRAVEL = 10018 
TERRAIN_SIDEWALK = 10019 
TERRAIN_GRASS = 10020 
TERRAIN_GRASSDRIED = 10021 
TERRAIN_DIRT = 10022 
TERRAIN_DIRTPACKED = 10023 
TERRAIN_WATER = 10024 
TERRAIN_ICE = 10025 
TERRAIN_SNOW = 10026 
TERRAIN_SAND = 10027 
TERRAIN_PLEXIGLASS = 10028 
TERRAIN_FIBERGLASS = 10029 
TERRAIN_CARPET = 10030 
TERRAIN_CONVEYOR = 10031 
TERRAIN_CHAINLINK = 10032 
TERRAIN_METALFUTURE = 10033 
TERRAIN_GENERIC1 = 10034 
TERRAIN_GENERIC2 = 10035 
TERRAIN_WHEELS = 10036 
TERRAIN_WETCONC = 10037 
TERRAIN_METALFENCE = 10038 
TERRAIN_GRINDTRAIN = 10039 
TERRAIN_GRINDROPE = 10040 
TERRAIN_GRINDWIRE = 10041 
TERRAIN_GRINDCONC = 10042 
TERRAIN_GRINDROUNDMETALPOLE = 10043 
TERRAIN_GRINDCHAINLINK = 10044 
TERRAIN_GRINDMETAL = 10045 
TERRAIN_GRINDWOODRAILING = 10046 
TERRAIN_GRINDWOODLOG = 10047 
TERRAIN_GRINDWOOD = 10048 
TERRAIN_GRINDPLASTIC = 10049 
TERRAIN_GRINDELECTRICWIRE = 10050 
TERRAIN_GRINDCABLE = 10051 
TERRAIN_GRINDCHAIN = 10052 
TERRAIN_GRINDPLASTICBARRIER = 10053 
TERRAIN_GRINDNEONLIGHT = 10054 
TERRAIN_GRINDGLASSMONSTER = 10055 
TERRAIN_GRINDBANYONTREE = 10056 
TERRAIN_GRINDBRASSRAIL = 10057 
TERRAIN_GRINDCATWALK = 10058 
TERRAIN_GRINDTANKTURRET = 10059 
RollConcSmoothValues = { maxPitch = 120 minPitch = 30 } 
RollConcRoughValues = { maxPitch = 120 minPitch = 10 } 
OllieConcValues = { maxPitch = 105 minPitch = 98 maxVol = 175 minVol = 120 } 
SlideConcValues = { maxPitch = 135 minPitch = 100 maxVol = 130 minVol = 80 } 
LandConcValues = { maxVol = 135 minVol = 70 } 
BonkConcValues = { maxVol = 140 minVol = 70 } 
RollMetalSmoothValues = { maxPitch = 120 minPitch = 30 } 
RollMetalRoughValues = { maxPitch = 120 minPitch = 30 maxVol = 100 minVol = 20 } 
RollMetalCorrugatedValues = { maxPitch = 250 minPitch = 150 } 
OllieMetalValues = { maxVol = 140 minVol = 70 } 
LandMetalValues = { maxPitch = 100 minPitch = 100 maxVol = 100 minVol = 40 } 
BonkMetalValues = { maxVol = 100 minVol = 30 } 
RollWoodValues = { maxPitch = 120 minPitch = 30 maxVol = 100 minVol = 20 } 
RollWoodShingleValues = { maxPitch = 80 minPitch = 20 maxVol = 100 minVol = 20 } 
OllieWoodValues = { maxVol = 120 minVol = 60 } 
LandWoodValues = { maxVol = 120 minVol = 60 } 
BonkWoodValues = { maxVol = 90 minVol = 30 } 
SCRIPT SetTerrainDefault 
	LoadTerrainSounds terrain = TERRAIN_DEFAULT 
ENDSCRIPT

SCRIPT SetTerrainConcSmooth 
	LoadTerrainSounds terrain = TERRAIN_CONCSMOOTH 
ENDSCRIPT

SCRIPT SetTerrainConcRough 
	LoadTerrainSounds terrain = TERRAIN_CONCROUGH 
ENDSCRIPT

SCRIPT SetTerrainMetalSmooth 
	LoadTerrainSounds terrain = TERRAIN_METALSMOOTH 
ENDSCRIPT

SCRIPT SetTerrainMetalRough 
	LoadTerrainSounds terrain = TERRAIN_METALROUGH 
ENDSCRIPT

SCRIPT SetTerrainMetalCorrugated 
	LoadTerrainSounds terrain = TERRAIN_METALCORRUGATED 
ENDSCRIPT

SCRIPT SetTerrainMetalGrating 
	LoadTerrainSounds terrain = TERRAIN_METALGRATING 
ENDSCRIPT

SCRIPT SetTerrainMetalTin 
	LoadTerrainSounds terrain = TERRAIN_METALTIN 
ENDSCRIPT

SCRIPT SetTerrainWood 
	LoadTerrainSounds terrain = TERRAIN_WOOD 
ENDSCRIPT

SCRIPT SetTerrainWoodMasonite 
	LoadTerrainSounds terrain = TERRAIN_WOODMASONITE 
ENDSCRIPT

SCRIPT SetTerrainWoodPlywood 
	LoadTerrainSounds terrain = TERRAIN_WOODPLYWOOD 
ENDSCRIPT

SCRIPT SetTerrainWoodFlimsy 
	LoadTerrainSounds terrain = TERRAIN_WOODFLIMSY 
ENDSCRIPT

SCRIPT SetTerrainWoodShingle 
	LoadTerrainSounds terrain = TERRAIN_WOODSHINGLE 
ENDSCRIPT

SCRIPT SetTerrainWoodPier 
	LoadTerrainSounds terrain = TERRAIN_WOODPIER 
ENDSCRIPT

SCRIPT SetTerrainBrick 
	LoadTerrainSounds terrain = TERRAIN_BRICK 
ENDSCRIPT

SCRIPT SetTerrainTile 
	LoadTerrainSounds terrain = TERRAIN_TILE 
ENDSCRIPT

SCRIPT SetTerrainAsphalt 
	LoadTerrainSounds terrain = TERRAIN_ASPHALT 
ENDSCRIPT

SCRIPT SetTerrainRock 
	LoadTerrainSounds terrain = TERRAIN_ROCK 
ENDSCRIPT

SCRIPT SetTerrainGravel 
	LoadTerrainSounds terrain = TERRAIN_GRAVEL 
ENDSCRIPT

SCRIPT SetTerrainSidewalk 
	LoadTerrainSounds terrain = TERRAIN_SIDEWALK 
ENDSCRIPT

SCRIPT SetTerrainGrass 
	LoadTerrainSounds terrain = TERRAIN_GRASS 
	SetTerrainParticleProperties { 
		terrain = TERRAIN_GRASS num = 200 start_col = -15259859 end_col = 931772970 emit_w = 2.00000000000 emit_h = 2.09999990463 
		size = 6 aspect_ratio = 1 growth = 1.00000000000 angle = -50.00000000000 speed = 60.00000000000 speed_range = 60.00000000000 life = 0.89999997616 grav = -0.50000000000 
	name = "Grass_1.png" } 
ENDSCRIPT

SCRIPT SetTerrainGrassDried 
	LoadTerrainSounds terrain = TERRAIN_GRASSDRIED 
	SetTerrainParticleProperties { 
		terrain = TERRAIN_GRASSDRIED num = 200 start_col = -15259859 end_col = 931772970 emit_w = 2.00000000000 emit_h = 2.09999990463 
		size = 6 aspect_ratio = 1 growth = 1.00000000000 angle = -50.00000000000 speed = 60.00000000000 speed_range = 60.00000000000 life = 0.89999997616 grav = -0.50000000000 
	name = "Grass_1.png" } 
ENDSCRIPT

SCRIPT SetTerrainDirt 
	LoadTerrainSounds terrain = TERRAIN_DIRT 
	SetTerrainParticleProperties { 
		terrain = TERRAIN_DIRT num = 20 start_col = 1516740274 end_col = 6793906 emit_w = 1.00000000000 emit_h = 1.00000000000 
		size = 25 aspect_ratio = 1.00000000000 growth = 2.00000000000 angle = 90.00000000000 speed = 30.00000000000 speed_range = 50.00000000000 life = 0.60000002384 grav = 0.50000000000 
	name = "breath.png" } 
ENDSCRIPT

SCRIPT SetTerrainDirtPacked 
	LoadTerrainSounds terrain = TERRAIN_DIRTPACKED 
	SetTerrainParticleProperties { 
		terrain = TERRAIN_DIRTPACKED num = 20 start_col = 1516740274 end_col = 6793906 emit_w = 1.00000000000 emit_h = 1.00000000000 
		size = 25 aspect_ratio = 1.00000000000 growth = 2.00000000000 angle = 90.00000000000 speed = 30.00000000000 speed_range = 50.00000000000 life = 0.60000002384 grav = 0.50000000000 
	name = "breath.png" } 
ENDSCRIPT

SCRIPT SetTerrainWater 
	LoadTerrainSounds terrain = TERRAIN_WATER 
	SetTerrainParticleProperties { 
		terrain = TERRAIN_WATER num = 200 start_col = -1008349527 end_col = 166055593 emit_w = 2.00000000000 emit_h = 5.00000000000 
		size = 3 aspect_ratio = 0.44999998808 growth = 2.00000000000 angle = 45.00000000000 speed = 90.00000000000 speed_range = 60.00000000000 life = 0.60000002384 grav = 0.00000000000 
	name = "breath.png" } 
ENDSCRIPT

SCRIPT SetTerrainIce 
	LoadTerrainSounds terrain = TERRAIN_ICE 
ENDSCRIPT

SCRIPT SetTerrainSnow 
	LoadTerrainSounds terrain = TERRAIN_SNOW 
	SetTerrainParticleProperties { 
		terrain = TERRAIN_SNOW num = 20 start_col = 1526327776 end_col = 217704928 emit_w = 1.00000000000 emit_h = 1.00000000000 
		size = 21 aspect_ratio = 0.69999998808 growth = 2.00000000000 angle = 60.00000000000 speed = 30.00000000000 speed_range = 50.00000000000 life = 0.69999998808 grav = 2 
	name = "breath.png" } 
ENDSCRIPT

SCRIPT SetTerrainSand 
	LoadTerrainSounds terrain = TERRAIN_SAND 
	SetTerrainParticleProperties { 
		terrain = TERRAIN_SAND num = 20 start_col = 1516740274 end_col = 6793906 emit_w = 1.00000000000 emit_h = 1.00000000000 
		size = 25 aspect_ratio = 1.00000000000 growth = 2.00000000000 angle = 90.00000000000 speed = 30.00000000000 speed_range = 50.00000000000 life = 0.60000002384 grav = 0.50000000000 
	name = "breath.png" } 
ENDSCRIPT

SCRIPT SetTerrainPlexiglass 
	LoadTerrainSounds terrain = TERRAIN_PLEXIGLASS 
ENDSCRIPT

SCRIPT SetTerrainFiberglass 
	LoadTerrainSounds terrain = TERRAIN_FIBERGLASS 
ENDSCRIPT

SCRIPT SetTerrainCarpet 
	LoadTerrainSounds terrain = TERRAIN_CARPET 
ENDSCRIPT

SCRIPT SetTerrainConveyor 
	LoadTerrainSounds terrain = TERRAIN_CONVEYOR 
ENDSCRIPT

SCRIPT SetTerrainChainlink 
	LoadTerrainSounds terrain = TERRAIN_CHAINLINK 
ENDSCRIPT

SCRIPT SetTerrainMetalFuture 
	LoadTerrainSounds terrain = TERRAIN_METALFUTURE 
ENDSCRIPT

SCRIPT SetTerrainGeneric1 
	LoadTerrainSounds terrain = TERRAIN_GENERIC1 
ENDSCRIPT

SCRIPT SetTerrainGeneric2 
	LoadTerrainSounds terrain = TERRAIN_GENERIC2 
ENDSCRIPT

SCRIPT SetTerrainWetConc 
	LoadTerrainSounds terrain = TERRAIN_WETCONC 
	SetTerrainParticleProperties { 
		terrain = TERRAIN_WATER num = 200 start_col = -1008349527 end_col = 166055593 emit_w = 2.00000000000 emit_h = 5.00000000000 
		size = 3 aspect_ratio = 0.44999998808 growth = 2.00000000000 angle = 45.00000000000 speed = 90.00000000000 speed_range = 60.00000000000 life = 0.60000002384 grav = 0.00000000000 
	name = "breath.png" } 
ENDSCRIPT

SCRIPT SetTerrainMetalFence 
	LoadTerrainSounds terrain = TERRAIN_METALFENCE 
ENDSCRIPT

SCRIPT SetTerrainConcCrusty 
ENDSCRIPT

SCRIPT SetTerrainFloat 
ENDSCRIPT

SCRIPT SetTerrainGarbage 
ENDSCRIPT

SCRIPT SetTerrainGlass 
ENDSCRIPT

SCRIPT SetTerrainBrickLarge 
ENDSCRIPT

SCRIPT SetTerrainLeaves 
ENDSCRIPT

SCRIPT SetTerrainMud 
ENDSCRIPT

SCRIPT SetTerrainSkylights 
ENDSCRIPT

SCRIPT SetTerrainTinRoof 
ENDSCRIPT

SCRIPT SetTerrainGrindTrain 
	LoadTerrainSounds terrain = TERRAIN_GRINDTRAIN 
ENDSCRIPT

SCRIPT SetTerrainGrindRope 
	LoadTerrainSounds terrain = TERRAIN_GRINDROPE 
ENDSCRIPT

SCRIPT SetTerrainGrindWire 
	LoadTerrainSounds terrain = TERRAIN_GRINDWIRE 
ENDSCRIPT

SCRIPT SetTerrainGrindConc 
	LoadTerrainSounds terrain = TERRAIN_GRINDCONC 
ENDSCRIPT

SCRIPT SetTerrainGrindRoundMetalPole 
	LoadTerrainSounds terrain = TERRAIN_GRINDROUNDMETALPOLE 
ENDSCRIPT

SCRIPT SetTerrainGrindChainLink 
	LoadTerrainSounds terrain = TERRAIN_GRINDCHAINLINK 
ENDSCRIPT

SCRIPT SetTerrainGrindMetal 
	LoadTerrainSounds terrain = TERRAIN_GRINDMETAL 
ENDSCRIPT

SCRIPT SetTerrainGrindWoodRailing 
	LoadTerrainSounds terrain = TERRAIN_GRINDWOODRAILING 
ENDSCRIPT

SCRIPT SetTerrainGrindWoodLog 
	LoadTerrainSounds terrain = TERRAIN_GRINDWOODLOG 
ENDSCRIPT

SCRIPT SetTerrainGrindWood 
	LoadTerrainSounds terrain = TERRAIN_GRINDWOOD 
ENDSCRIPT

SCRIPT SetTerrainGrindPlastic 
	LoadTerrainSounds terrain = TERRAIN_GRINDPLASTIC 
ENDSCRIPT

SCRIPT SetTerrainGrindElectricWire 
	LoadTerrainSounds terrain = TERRAIN_GRINDELECTRICWIRE 
ENDSCRIPT

SCRIPT SetTerrainGrindCable 
	LoadTerrainSounds terrain = TERRAIN_GRINDCABLE 
ENDSCRIPT

SCRIPT SetTerrainGrindChain 
	LoadTerrainSounds terrain = TERRAIN_GRINDCHAIN 
ENDSCRIPT

SCRIPT SetTerrainGrindPlasticBarrier 
	LoadTerrainSounds terrain = TERRAIN_GRINDPLASTICBARRIER 
ENDSCRIPT

SCRIPT SetTerrainGrindNeonLight 
	LoadTerrainSounds terrain = TERRAIN_GRINDNEONLIGHT 
ENDSCRIPT

SCRIPT SetTerrainGrindGlassMonster 
	LoadTerrainSounds terrain = TERRAIN_GRINDGLASSMONSTER 
ENDSCRIPT

SCRIPT SetTerrainGrindBanyonTree 
	LoadTerrainSounds terrain = TERRAIN_GRINDBANYONTREE 
ENDSCRIPT

SCRIPT SetTerrainGrindBrassRail 
	LoadTerrainSounds terrain = TERRAIN_GRINDBRASSRAIL 
ENDSCRIPT

SCRIPT SetTerrainGrindCatwalk 
	LoadTerrainSounds terrain = TERRAIN_GRINDCATWALK 
ENDSCRIPT

SCRIPT SetTerrainGrindTankTurret 
	LoadTerrainSounds terrain = TERRAIN_GRINDTANKTURRET 
ENDSCRIPT

standard_terrain = [ 
	{ 
		terrain = TERRAIN_DEFAULT 
		SoundActions = { 
			TA_ROLL = { sound = "Terrains\\RollConcSmooth02" maxPitch = 120 minPitch = 80 loadVol = 100 } 
			TA_GRIND = { sound = "Terrains\\GrindMetal02" maxPitch = 115 minPitch = 100 maxVol = 120 minVol = 20 } 
			TA_OLLIE = [ 
				{ soundAction = [ 
						{ chance = 1 sound = "Terrains\\OllieConc19" OllieConcValues } 
						{ chance = 8 sound = "Terrains\\OllieConc" OllieConcValues } 
					] 
				} 
			] 
			TA_LAND = { sound = "Terrains\\LandConc" LandConcValues loadVol = 100 } 
			TA_BONK = { sound = "Terrains\\LandConc" LandConcValues loadVol = 100 } 
			TA_GRINDJUMP = { sound = "Terrains\\GrindMetalOff02" maxVol = 90 minVol = 70 } 
			TA_GRINDLAND = [ 
				{ 
					useUpTo = 30 
					soundAction = { sound = "Terrains\\GrindMetalOn08" maxVol = 150 minVol = 100 maxPitch = 120 minPitch = 100 } 
				} 
				{ 
					soundAction = { sound = "Terrains\\GrindMetalOn02" maxVol = 150 minVol = 100 maxPitch = 120 minPitch = 100 } 
				} 
			] 
			TA_SLIDE = { sound = "Terrains\\SlideMetal02" maxPitch = 140 minPitch = 100 maxVol = 100 minVol = 20 } 
			TA_SLIDEJUMP = { sound = "Terrains\\GrindMetalOff02" maxVol = 90 minVol = 70 } 
			TA_SLIDELAND = [ 
				{ 
					useUpTo = 30 
					soundAction = { sound = "Terrains\\GrindMetalOn08" maxVol = 150 minVol = 100 maxPitch = 120 minPitch = 100 } 
				} 
				{ 
					soundAction = { sound = "Terrains\\GrindMetalOn02" maxVol = 150 minVol = 100 maxPitch = 120 minPitch = 100 } 
				} 
			] 
			TA_REVERT = { sound = "Skater\\RevertConc" loadVol = 180 } 
		} 
	} 
	{ 
		terrain = TERRAIN_CONCSMOOTH 
		SoundActions = { 
			TA_ROLL = { sound = "Terrains\\RollConcSmooth02" maxPitch = 120 minPitch = 80 loadVol = 100 } 
			TA_GRIND = { sound = "Terrains\\GrindConc04" maxPitch = 90 minPitch = 60 maxVol = 100 minVol = 20 } 
			TA_LAND = { sound = "Terrains\\LandConc" LandConcValues loadVol = 100 } 
			TA_BONK = { sound = "Terrains\\LandConc" LandConcValues loadVol = 70 } 
			TA_GRINDJUMP = { sound = "Terrains\\OllieConc" OllieConcValues } 
			TA_GRINDLAND = { sound = "Terrains\\LandConc" maxVol = 150 minVol = 100 loadVol = 100 } 
			TA_SLIDE = { sound = "Terrains\\SlideConc14" SlideConcValues } 
			TA_SLIDEJUMP = { sound = "Terrains\\OllieConc" OllieConcValues } 
			TA_SLIDELAND = { sound = "Terrains\\LandConc" maxVol = 120 minVol = 80 loadVol = 100 } 
			TA_REVERT = { sound = "Skater\\RevertConc" loadVol = 180 } 
		} 
	} 
	{ 
		terrain = TERRAIN_CONCROUGH 
		SoundActions = { 
			TA_ROLL = { sound = "Terrains\\RollConcRough" maxPitch = 120 minPitch = 50 loadVol = 70 } 
			TA_GRIND = { sound = "Terrains\\GrindConc04" maxPitch = 90 minPitch = 60 maxVol = 100 minVol = 20 } 
			TA_LAND = { sound = "Terrains\\LandConc" LandConcValues loadVol = 100 } 
			TA_BONK = { sound = "Terrains\\LandConc" LandConcValues loadVol = 70 } 
			TA_GRINDJUMP = { sound = "Terrains\\OllieConc" OllieConcValues } 
			TA_GRINDLAND = { sound = "Terrains\\LandConc" maxVol = 150 minVol = 100 loadVol = 100 } 
			TA_SLIDE = { sound = "Terrains\\SlideConc14" SlideConcValues } 
			TA_SLIDEJUMP = { sound = "Terrains\\OllieConc" OllieConcValues } 
			TA_SLIDELAND = { sound = "Terrains\\LandConc" maxVol = 120 minVol = 80 loadVol = 100 } 
			TA_REVERT = { sound = "Skater\\RevertConc" loadVol = 180 } 
		} 
	} 
	{ 
		terrain = TERRAIN_BRICK 
		SoundActions = { 
			TA_ROLL = { sound = "Terrains\\RollBrick" loadVol = 80 maxPitch = 120 minPitch = 80 maxVol = 100 minVol = 20 } 
			TA_GRIND = { sound = "Terrains\\GrindConc04" maxPitch = 90 minPitch = 60 maxVol = 100 minVol = 20 } 
			TA_LAND = { sound = "Terrains\\LandConc" LandConcValues loadVol = 100 } 
			TA_BONK = { sound = "Terrains\\LandConc" LandConcValues loadVol = 70 } 
			TA_GRINDJUMP = { sound = "Terrains\\OllieConc" OllieConcValues } 
			TA_GRINDLAND = { sound = "Terrains\\LandConc" maxVol = 150 minVol = 100 loadVol = 100 } 
			TA_SLIDE = { sound = "Terrains\\SlideConc14" SlideConcValues } 
			TA_SLIDEJUMP = { sound = "Terrains\\OllieConc" OllieConcValues } 
			TA_SLIDELAND = { sound = "Terrains\\LandConc" maxVol = 120 minVol = 80 loadVol = 100 } 
			TA_REVERT = { sound = "Skater\\RevertConc" loadVol = 180 } 
		} 
	} 
	{ 
		terrain = TERRAIN_ASPHALT 
		SoundActions = { 
			TA_ROLL = { sound = "Terrains\\RollAsphalt" maxPitch = 120 minPitch = 80 } 
			TA_GRIND = { sound = "Terrains\\GrindConc04" maxPitch = 90 minPitch = 60 maxVol = 100 minVol = 20 } 
			TA_LAND = { sound = "Terrains\\LandConc" LandConcValues loadVol = 100 } 
			TA_BONK = { sound = "Terrains\\LandConc" LandConcValues loadVol = 70 } 
			TA_GRINDJUMP = { sound = "Terrains\\OllieConc" OllieConcValues } 
			TA_GRINDLAND = { sound = "Terrains\\LandConc" maxVol = 150 minVol = 100 loadVol = 100 } 
			TA_SLIDE = { sound = "Terrains\\SlideConc14" SlideConcValues } 
			TA_SLIDEJUMP = { sound = "Terrains\\OllieConc" OllieConcValues } 
			TA_SLIDELAND = { sound = "Terrains\\LandConc" maxVol = 120 minVol = 80 loadVol = 100 } 
			TA_REVERT = { sound = "Skater\\RevertConc" loadVol = 180 } 
		} 
	} 
	{ 
		terrain = TERRAIN_SIDEWALK 
		SoundActions = { 
			TA_ROLL = { sound = "Terrains\\RollSidewalk" loadVol = 100 maxPitch = 90 minPitch = 50 maxVol = 100 minVol = 20 } 
			TA_GRIND = { sound = "Terrains\\GrindConc04" maxPitch = 90 minPitch = 60 maxVol = 100 minVol = 20 } 
			TA_LAND = { sound = "Terrains\\LandConc" LandConcValues loadVol = 100 } 
			TA_BONK = { sound = "Terrains\\LandConc" LandConcValues loadVol = 70 } 
			TA_GRINDJUMP = { sound = "Terrains\\OllieConc" OllieConcValues } 
			TA_GRINDLAND = { sound = "Terrains\\LandConc" maxVol = 150 minVol = 100 loadVol = 100 } 
			TA_SLIDE = { sound = "Terrains\\SlideConc14" SlideConcValues } 
			TA_SLIDEJUMP = { sound = "Terrains\\OllieConc" OllieConcValues } 
			TA_SLIDELAND = { sound = "Terrains\\LandConc" maxVol = 120 minVol = 80 loadVol = 100 } 
			TA_REVERT = { sound = "Skater\\RevertConc" loadVol = 180 } 
		} 
	} 
	{ 
		terrain = TERRAIN_WETCONC 
		SoundActions = { 
			TA_ROLL = { sound = "Terrains\\RollWetConc_11" loadVol = 70 maxPitch = 120 minPitch = 50 } 
			TA_GRIND = { sound = "Terrains\\GrindConc04" maxPitch = 90 minPitch = 60 maxVol = 100 minVol = 20 } 
			TA_LAND = { sound = "Terrains\\LandWater" LandConcValues loadVol = 100 } 
			TA_BONK = { sound = "Terrains\\LandConc" LandConcValues loadVol = 70 } 
			TA_GRINDJUMP = { sound = "Terrains\\OllieConc" OllieConcValues } 
			TA_GRINDLAND = { sound = "Terrains\\LandConc" maxVol = 150 minVol = 100 loadVol = 100 } 
			TA_SLIDE = { sound = "Terrains\\SlideConc14" SlideConcValues } 
			TA_SLIDEJUMP = { sound = "Terrains\\OllieConc" OllieConcValues } 
			TA_SLIDELAND = { sound = "Terrains\\LandConc" maxVol = 120 minVol = 80 loadVol = 100 } 
			TA_REVERT = { sound = "Skater\\RevertConc" loadVol = 180 } 
		} 
	} 
	{ 
		terrain = TERRAIN_METALSMOOTH 
		SoundActions = { 
			TA_ROLL = { sound = "Terrains\\RollMetalSmooth_11" maxPitch = 120 minPitch = 50 maxVol = 100 minVol = 20 } 
			TA_OLLIE = { sound = "Terrains\\OllieMetal" loadVol = 120 OllieMetalValues } 
			TA_LAND = { sound = "Terrains\\LandMetal" LandMetalValues } 
			TA_BONK = { sound = "Terrains\\BonkMetal_11" BonkMetalValues } 
			TA_REVERT = { sound = "Skater\\RevertMetal" loadVol = 200 } 
		} 
	} 
	{ 
		terrain = TERRAIN_METALROUGH 
		SoundActions = { 
			TA_ROLL = { sound = "Terrains\\RollMetalRough_11" maxPitch = 120 minPitch = 50 maxVol = 100 minVol = 20 } 
			TA_OLLIE = { sound = "Terrains\\OllieMetal" loadVol = 120 OllieMetalValues } 
			TA_LAND = { sound = "Terrains\\LandMetal" LandMetalValues } 
			TA_BONK = { sound = "Terrains\\BonkMetal_11" BonkMetalValues } 
			TA_REVERT = { sound = "Skater\\RevertMetal" loadVol = 200 } 
		} 
	} 
	{ 
		terrain = TERRAIN_METALCORRUGATED 
		SoundActions = { 
			TA_ROLL = { sound = "Terrains\\RollMetalCorrugated_11" maxPitch = 120 minPitch = 50 maxVol = 100 minVol = 20 } 
			TA_OLLIE = { sound = "Terrains\\OllieMetal" loadVol = 120 OllieMetalValues } 
			TA_LAND = { sound = "Terrains\\LandMetal" LandMetalValues } 
			TA_BONK = { sound = "Terrains\\BonkMetal_11" BonkMetalValues } 
			TA_REVERT = { sound = "Skater\\RevertMetal" loadVol = 200 } 
		} 
	} 
	{ 
		terrain = TERRAIN_METALGRATING 
		SoundActions = { 
			TA_ROLL = { sound = "Terrains\\RollMetalGrating" maxPitch = 120 minPitch = 50 maxVol = 100 minVol = 20 } 
			TA_OLLIE = { sound = "Terrains\\OllieMetal" loadVol = 120 OllieMetalValues } 
			TA_LAND = { sound = "Terrains\\LandMetal" LandMetalValues } 
			TA_BONK = { sound = "Terrains\\BonkMetal_11" BonkMetalValues } 
			TA_REVERT = { sound = "Skater\\RevertMetal" loadVol = 200 } 
		} 
	} 
	{ 
		terrain = TERRAIN_METALTIN 
		SoundActions = { 
			TA_ROLL = { sound = "Terrains\\RollMetalTin" maxPitch = 120 minPitch = 50 maxVol = 100 minVol = 20 } 
			TA_OLLIE = { sound = "Terrains\\OllieMetal" loadVol = 120 OllieMetalValues } 
			TA_LAND = { sound = "Terrains\\LandMetal" LandMetalValues } 
			TA_BONK = { sound = "Terrains\\BonkMetal_11" BonkMetalValues } 
			TA_REVERT = { sound = "Skater\\RevertMetal" loadVol = 200 } 
		} 
	} 
	{ 
		terrain = TERRAIN_WOOD 
		SoundActions = { 
			TA_ROLL = { sound = "Terrains\\RollWood" loadVol = 50 maxPitch = 120 minPitch = 50 maxVol = 100 minVol = 20 } 
			TA_GRIND = { sound = "Terrains\\GrindWood" maxPitch = 100 minPitch = 60 maxVol = 100 minVol = 20 } 
			TA_OLLIE = { sound = "Terrains\\OllieWood" OllieWoodValues } 
			TA_LAND = { sound = "Terrains\\LandWood" LandWoodValues loadVol = 100 } 
			TA_BONK = { sound = "Terrains\\BonkWood" BonkWoodValues loadVol = 100 } 
			TA_GRINDJUMP = { sound = "Terrains\\OllieWood" OllieWoodValues } 
			TA_GRINDLAND = { sound = "Terrains\\LandWood" LandWoodValues loadVol = 100 } 
			TA_SLIDE = { sound = "Terrains\\SlideWood" pitch = 110 loadVol = 100 maxPitch = 100 minPitch = 60 maxVol = 100 minVol = 20 } 
			TA_SLIDEJUMP = { sound = "Terrains\\OllieWood" OllieWoodValues } 
			TA_SLIDELAND = { sound = "Terrains\\LandWood" LandWoodValues loadVol = 100 } 
			TA_REVERT = { sound = "Skater\\RevertWood" loadVol = 150 } 
		} 
	} 
	{ 
		terrain = TERRAIN_WOODMASONITE 
		SoundActions = { 
			TA_ROLL = { sound = "Terrains\\RollWoodMasonite" loadVol = 50 maxPitch = 120 minPitch = 50 maxVol = 100 minVol = 20 } 
			TA_OLLIE = { sound = "Terrains\\OllieWood" OllieWoodValues } 
			TA_LAND = { sound = "Terrains\\LandWood" LandWoodValues loadVol = 100 } 
			TA_BONK = { sound = "Terrains\\BonkWood" BonkWoodValues loadVol = 100 } 
			TA_REVERT = { sound = "Skater\\RevertWood" loadVol = 150 } 
		} 
	} 
	{ 
		terrain = TERRAIN_WOODPLYWOOD 
		SoundActions = { 
			TA_ROLL = { sound = "Terrains\\RollWoodPlywood_11" loadVol = 80 maxPitch = 120 minPitch = 80 maxVol = 100 minVol = 20 } 
			TA_OLLIE = { sound = "Terrains\\OllieWood" OllieWoodValues } 
			TA_LAND = { sound = "Terrains\\LandWood" LandWoodValues loadVol = 100 } 
			TA_BONK = { sound = "Terrains\\BonkWood" BonkWoodValues loadVol = 100 } 
			TA_REVERT = { sound = "Skater\\RevertWood" loadVol = 150 } 
		} 
	} 
	{ 
		terrain = TERRAIN_WOODFLIMSY 
		SoundActions = { 
			TA_ROLL = { sound = "Terrains\\RollWoodFlimsy" loadVol = 80 maxPitch = 120 minPitch = 80 maxVol = 100 minVol = 20 } 
			TA_OLLIE = { sound = "Terrains\\OllieWood" OllieWoodValues } 
			TA_LAND = { sound = "Terrains\\LandWood" LandWoodValues loadVol = 100 } 
			TA_BONK = { sound = "Terrains\\BonkWood" BonkWoodValues loadVol = 100 } 
			TA_REVERT = { sound = "Skater\\RevertWood" loadVol = 150 } 
		} 
	} 
	{ 
		terrain = TERRAIN_WOODSHINGLE 
		SoundActions = { 
			TA_ROLL = { sound = "Terrains\\RollWoodShingle" loadVol = 80 maxPitch = 80 minPitch = 50 maxVol = 100 minVol = 20 } 
			TA_OLLIE = { sound = "Terrains\\OllieWood" OllieWoodValues } 
			TA_LAND = { sound = "Terrains\\LandWood" LandWoodValues loadVol = 100 } 
			TA_BONK = { sound = "Terrains\\BonkWood" BonkWoodValues loadVol = 100 } 
			TA_REVERT = { sound = "Skater\\RevertWood" loadVol = 150 } 
		} 
	} 
	{ 
		terrain = TERRAIN_WOODPIER 
		SoundActions = { 
			TA_ROLL = { sound = "Terrains\\RollWoodPier" loadVol = 80 maxPitch = 120 minPitch = 80 maxVol = 100 minVol = 20 } 
			TA_OLLIE = { sound = "Terrains\\OllieWood" OllieWoodValues } 
			TA_LAND = { sound = "Terrains\\LandWood" LandWoodValues loadVol = 100 } 
			TA_BONK = { sound = "Terrains\\BonkWood" BonkWoodValues loadVol = 100 } 
			TA_REVERT = { sound = "Skater\\RevertWood" loadVol = 150 } 
		} 
	} 
	{ 
		terrain = TERRAIN_ROCK 
		SoundActions = { 
			TA_ROLL = { sound = "Terrains\\RollRock" loadVol = 200 maxPitch = 120 minPitch = 80 } 
			TA_OLLIE = { sound = "Terrains\\OllieConc" maxPitch = 100 minPitch = 100 maxVol = 100 minVol = 20 } 
			TA_LAND = { sound = "Terrains\\LandConc" LandConcValues } 
			TA_REVERT = { sound = "Skater\\RevertConc" loadVol = 180 } 
		} 
	} 
	{ 
		terrain = TERRAIN_GRAVEL 
		SoundActions = { 
			TA_ROLL = { sound = "Terrains\\RollGravel" loadVol = 200 maxPitch = 120 minPitch = 80 } 
			TA_OLLIE = { sound = "Terrains\\OllieConc" OllieConcValues } 
			TA_LAND = { sound = "Terrains\\LandConc" LandConcValues } 
			TA_REVERT = { sound = "Skater\\RevertConc" loadVol = 180 } 
		} 
	} 
	{ 
		terrain = TERRAIN_GRASS 
		SoundActions = { 
			TA_ROLL = { sound = "Terrains\\RollGrass" maxPitch = 90 minPitch = 60 maxVol = 100 minVol = 20 } 
			TA_OLLIE = { sound = "Terrains\\LandDirt" maxPitch = 100 minPitch = 100 maxVol = 100 minVol = 20 } 
			TA_LAND = { sound = "Terrains\\LandDirt" maxPitch = 100 minPitch = 100 maxVol = 100 minVol = 20 } 
			TA_REVERT = { sound = "Skater\\RevertConc" loadVol = 180 } 
		} 
	} 
	{ 
		terrain = TERRAIN_GRASSDRIED 
		SoundActions = { 
			TA_ROLL = { sound = "Terrains\\RollGrassDried" maxPitch = 50 minPitch = 30 maxVol = 100 minVol = 20 } 
			TA_OLLIE = { sound = "Terrains\\LandDirt" maxPitch = 100 minPitch = 100 maxVol = 100 minVol = 20 } 
			TA_LAND = { sound = "Terrains\\LandDirt" maxPitch = 100 minPitch = 100 maxVol = 100 minVol = 20 } 
			TA_REVERT = { sound = "Skater\\RevertConc" loadVol = 180 } 
		} 
	} 
	{ 
		terrain = TERRAIN_DIRT 
		SoundActions = { 
			TA_ROLL = { sound = "Terrains\\RollDirt" maxPitch = 100 minPitch = 60 maxVol = 100 minVol = 20 } 
			TA_OLLIE = { sound = "Terrains\\LandDirt" maxPitch = 100 minPitch = 100 maxVol = 100 minVol = 20 } 
			TA_LAND = { sound = "Terrains\\LandDirt" maxPitch = 100 minPitch = 100 maxVol = 100 minVol = 20 } 
			TA_REVERT = { sound = "Skater\\RevertConc" loadVol = 180 } 
		} 
	} 
	{ 
		terrain = TERRAIN_DIRTPACKED 
		SoundActions = { 
			TA_ROLL = { sound = "Terrains\\RollDirtPacked" loadVol = 75 maxPitch = 100 minPitch = 60 maxVol = 100 minVol = 20 } 
			TA_OLLIE = { sound = "Terrains\\OllieWood" } 
			TA_LAND = { sound = "Terrains\\LandDirt" maxPitch = 100 minPitch = 100 maxVol = 100 minVol = 20 } 
			TA_REVERT = { sound = "Skater\\RevertConc" loadVol = 180 } 
		} 
	} 
	{ 
		terrain = TERRAIN_WATER 
		SoundActions = { 
			TA_ROLL = { sound = "Terrains\\RollWater_11" loadVol = 150 maxPitch = 120 minPitch = 50 } 
			TA_OLLIE = { sound = "Terrains\\OllieWater" OllieConcValues } 
			TA_LAND = { sound = "Terrains\\LandWater" LandConcValues } 
		} 
	} 
	{ 
		terrain = TERRAIN_ICE 
		SoundActions = { 
			TA_ROLL = { sound = "Terrains\\RollIce" loadVol = 70 maxPitch = 100 minPitch = 60 maxVol = 100 minVol = 20 } 
			TA_OLLIE = { sound = "Terrains\\LandDirt" maxPitch = 100 minPitch = 100 maxVol = 100 minVol = 20 } 
			TA_LAND = { sound = "Terrains\\LandDirt" maxPitch = 100 minPitch = 100 maxVol = 100 minVol = 20 } 
			TA_REVERT = { sound = "Skater\\RevertWood" loadVol = 150 } 
		} 
	} 
	{ 
		terrain = TERRAIN_SNOW 
		SoundActions = { 
			TA_ROLL = { sound = "Terrains\\RollSnow" loadVol = 70 maxPitch = 120 minPitch = 80 maxVol = 100 minVol = 20 } 
			TA_OLLIE = { sound = "Terrains\\LandDirt" maxPitch = 100 minPitch = 100 maxVol = 100 minVol = 20 } 
			TA_LAND = { sound = "Terrains\\LandDirt" maxPitch = 100 minPitch = 100 maxVol = 100 minVol = 20 } 
			TA_REVERT = { sound = "Skater\\RevertConc" loadVol = 180 } 
		} 
	} 
	{ 
		terrain = TERRAIN_SAND 
		SoundActions = { 
			TA_ROLL = { sound = "Terrains\\RollSand" loadVol = 80 maxPitch = 120 minPitch = 80 maxVol = 100 minVol = 20 } 
			TA_OLLIE = { sound = "Terrains\\LandDirt" maxPitch = 100 minPitch = 100 maxVol = 100 minVol = 20 } 
			TA_LAND = { sound = "Terrains\\LandDirt" maxPitch = 100 minPitch = 100 maxVol = 100 minVol = 20 } 
			TA_REVERT = { sound = "Skater\\RevertConc" loadVol = 180 } 
		} 
	} 
	{ 
		terrain = TERRAIN_TILE 
		SoundActions = { 
			TA_ROLL = { sound = "Terrains\\RollTile" loadVol = 80 maxPitch = 120 minPitch = 80 maxVol = 100 minVol = 20 } 
			TA_OLLIE = { sound = "Terrains\\OllieConc" OllieConcValues } 
			TA_LAND = { sound = "Terrains\\LandConc" LandConcValues loadVol = 100 } 
			TA_REVERT = { sound = "Skater\\RevertWood" loadVol = 150 } 
		} 
	} 
	{ 
		terrain = TERRAIN_PLEXIGLASS 
		SoundActions = { 
			TA_ROLL = { sound = "Terrains\\RollPlexiglass" loadVol = 50 maxPitch = 120 minPitch = 80 maxVol = 100 minVol = 20 } 
			TA_OLLIE = { sound = "Terrains\\OllieConc" OllieConcValues } 
			TA_LAND = { sound = "Terrains\\LandConc" LandConcValues } 
			TA_REVERT = { sound = "Skater\\RevertGlass" loadVol = 180 } 
		} 
	} 
	{ 
		terrain = TERRAIN_FIBERGLASS 
		SoundActions = { 
			TA_ROLL = { sound = "Terrains\\RollFiberglass" loadVol = 50 maxPitch = 120 minPitch = 80 maxVol = 100 minVol = 20 } 
			TA_OLLIE = { sound = "Terrains\\OllieConc" OllieConcValues } 
			TA_LAND = { sound = "Terrains\\LandConc" LandConcValues } 
			TA_REVERT = { sound = "Skater\\RevertGlass" loadVol = 180 } 
		} 
	} 
	{ 
		terrain = TERRAIN_CARPET 
		SoundActions = { 
			TA_ROLL = { sound = "Terrains\\RollCarpet" loadVol = 100 RollConcSmoothValues } 
			TA_OLLIE = { sound = "Terrains\\OllieConc" OllieConcValues } 
			TA_LAND = { sound = "Terrains\\LandConc" LandConcValues } 
			TA_REVERT = { sound = "Skater\\RevertWood" loadVol = 150 } 
		} 
	} 
	{ 
		terrain = TERRAIN_CONVEYOR 
		SoundActions = { 
			TA_ROLL = { sound = "Terrains\\RollConveyor" loadVol = 70 RollConcSmoothValues } 
			TA_OLLIE = { sound = "Terrains\\OllieConc" OllieConcValues } 
			TA_LAND = { sound = "Terrains\\LandConc" LandConcValues } 
			TA_REVERT = { sound = "Skater\\RevertConc" loadVol = 180 } 
		} 
	} 
	{ 
		terrain = TERRAIN_CHAINLINK 
		SoundActions = { 
			TA_BONK = { sound = "Terrains\\BonkChainlink" loadVol = 100 maxPitch = 100 minPitch = 100 maxVol = 100 minVol = 20 } 
			TA_GRIND = { sound = "Terrains\\GrindMetalPole22" maxPitch = 108 minPitch = 90 maxVol = 120 minVol = 20 } 
			TA_GRINDJUMP = { sound = "Terrains\\GrindMetalPoleOff21" maxVol = 90 minVol = 70 } 
			TA_GRINDLAND = [ 
				{ 
					useUpTo = 30 
					soundAction = { sound = "Terrains\\GrindMetalOn08" maxVol = 150 minVol = 100 maxPitch = 120 minPitch = 100 } 
				} 
				{ 
					soundAction = { sound = "Terrains\\GrindChainLinkOn22" maxVol = 150 minVol = 100 maxPitch = 120 minPitch = 100 } 
				} 
			] 
			TA_SLIDE = { sound = "Terrains\\SlideMetalPole22" maxPitch = 140 minPitch = 100 maxVol = 100 minVol = 20 } 
			TA_SLIDEJUMP = { sound = "Terrains\\GrindMetalPoleOff21" maxVol = 90 minVol = 70 } 
			TA_SLIDELAND = [ 
				{ 
					useUpTo = 30 
					soundAction = { sound = "Terrains\\GrindMetalOn08" maxVol = 150 minVol = 100 maxPitch = 120 minPitch = 100 } 
				} 
				{ 
					soundAction = { sound = "Terrains\\GrindChainLinkOn22" maxVol = 150 minVol = 100 maxPitch = 120 minPitch = 100 } 
				} 
			] 
		} 
	} 
	{ 
		terrain = TERRAIN_METALFUTURE 
		SoundActions = { 
			TA_ROLL = { sound = "Terrains\\RollMetalFuture" loadVol = 700 RollMetalSmoothValues } 
			TA_OLLIE = { sound = "Terrains\\OllieMetalFuture" OllieMetalValues } 
			TA_LAND = { sound = "Terrains\\LandMetalFuture" LandMetalValues } 
			TA_REVERT = { sound = "Skater\\RevertMetal" loadVol = 200 } 
		} 
	} 
	{ 
		terrain = TERRAIN_GENERIC1 
		SoundActions = { 
			TA_BONK = { sound = "Terrains\\BonkMetalOutdoor_11" loadVol = 100 BonkMetalValues } 
		} 
	} 
	{ 
		terrain = TERRAIN_GENERIC2 
		SoundActions = { 
		} 
	} 
	{ 
		terrain = TERRAIN_METALFENCE 
		SoundActions = { 
			TA_BONK = { sound = "Terrains\\BonkMetalFence" loadVol = 400 BonkMetalValues } 
		} 
	} 
	{ 
		terrain = TERRAIN_GRINDCONC 
		SoundActions = { 
			TA_GRIND = { sound = "Terrains\\GrindConc04" maxPitch = 90 minPitch = 60 maxVol = 100 minVol = 20 } 
			TA_GRINDJUMP = { sound = "Terrains\\OllieConc" OllieConcValues } 
			TA_GRINDLAND = { sound = "Terrains\\LandConc" maxVol = 150 minVol = 100 loadVol = 100 } 
			TA_SLIDE = { sound = "Terrains\\SlideConc14" SlideConcValues } 
			TA_SLIDEJUMP = { sound = "Terrains\\OllieConc" OllieConcValues } 
			TA_SLIDELAND = { sound = "Terrains\\LandConc" maxVol = 120 minVol = 80 loadVol = 100 } 
		} 
	} 
	{ 
		terrain = TERRAIN_GRINDROUNDMETALPOLE 
		SoundActions = { 
			TA_GRIND = { sound = "Terrains\\GrindMetalPole22" maxPitch = 105 minPitch = 85 maxVol = 120 minVol = 50 } 
			TA_GRINDJUMP = { sound = "Terrains\\GrindMetalPoleOff21" maxVol = 90 minVol = 70 } 
			TA_GRINDLAND = [ 
				{ 
					useUpTo = 30 
					soundAction = { sound = "Terrains\\GrindMetalOn08" maxVol = 150 minVol = 100 maxPitch = 120 minPitch = 100 } 
				} 
				{ 
					soundAction = { sound = "Terrains\\GrindMetalPoleOn21" maxVol = 150 minVol = 100 maxPitch = 120 minPitch = 100 } 
				} 
			] 
			TA_SLIDE = { sound = "Terrains\\SlideMetalPole22" maxPitch = 115 minPitch = 95 maxVol = 100 minVol = 20 } 
			TA_SLIDEJUMP = { sound = "Terrains\\GrindMetalPoleOff21" maxVol = 90 minVol = 70 } 
			TA_SLIDELAND = [ 
				{ 
					useUpTo = 30 
					soundAction = { sound = "Terrains\\GrindMetalOn08" maxVol = 150 minVol = 100 maxPitch = 120 minPitch = 100 } 
				} 
				{ 
					soundAction = { sound = "Terrains\\GrindMetalPoleOn21" maxVol = 150 minVol = 100 maxPitch = 120 minPitch = 100 } 
				} 
			] 
		} 
	} 
	{ 
		terrain = TERRAIN_GRINDCHAINLINK 
		SoundActions = { 
			TA_GRIND = { sound = "Terrains\\GrindMetalPole22" maxPitch = 105 minPitch = 85 maxVol = 120 minVol = 50 } 
			TA_GRINDJUMP = { sound = "Terrains\\GrindMetalPoleOff21" maxVol = 90 minVol = 70 } 
			TA_GRINDLAND = [ 
				{ 
					useUpTo = 30 
					soundAction = { sound = "Terrains\\GrindMetalOn08" maxVol = 150 minVol = 100 maxPitch = 120 minPitch = 100 } 
				} 
				{ 
					soundAction = { sound = "Terrains\\GrindChainLinkOn22" maxVol = 150 minVol = 100 maxPitch = 120 minPitch = 100 } 
				} 
			] 
			TA_SLIDE = { sound = "Terrains\\SlideMetalPole22" maxPitch = 115 minPitch = 95 maxVol = 100 minVol = 20 } 
			TA_SLIDEJUMP = { sound = "Terrains\\GrindMetalPoleOff21" maxVol = 90 minVol = 70 } 
			TA_SLIDELAND = [ 
				{ 
					useUpTo = 30 
					soundAction = { sound = "Terrains\\GrindMetalOn08" maxVol = 150 minVol = 100 maxPitch = 120 minPitch = 100 } 
				} 
				{ 
					soundAction = { sound = "Terrains\\GrindChainLinkOn22" maxVol = 150 minVol = 100 maxPitch = 120 minPitch = 100 } 
				} 
			] 
		} 
	} 
	{ 
		terrain = TERRAIN_GRINDMETAL 
		SoundActions = { 
			TA_GRIND = { sound = "Terrains\\GrindMetal02" maxPitch = 115 minPitch = 100 maxVol = 120 minVol = 20 } 
			TA_GRINDJUMP = { sound = "Terrains\\GrindMetalOff02" maxVol = 90 minVol = 70 } 
			TA_GRINDLAND = [ 
				{ 
					useUpTo = 30 
					soundAction = { sound = "Terrains\\GrindMetalOn08" maxVol = 150 minVol = 100 maxPitch = 120 minPitch = 100 } 
				} 
				{ 
					soundAction = { sound = "Terrains\\GrindMetalOn02" maxVol = 150 minVol = 100 maxPitch = 120 minPitch = 100 } 
				} 
			] 
			TA_SLIDE = { sound = "Terrains\\SlideMetal02" maxPitch = 140 minPitch = 100 maxVol = 100 minVol = 20 } 
			TA_SLIDEJUMP = { sound = "Terrains\\GrindMetalOff02" maxVol = 90 minVol = 70 } 
			TA_SLIDELAND = [ 
				{ 
					useUpTo = 30 
					soundAction = { sound = "Terrains\\GrindMetalOn08" maxVol = 150 minVol = 100 maxPitch = 120 minPitch = 100 } 
				} 
				{ 
					soundAction = { sound = "Terrains\\GrindMetalOn02" maxVol = 150 minVol = 100 maxPitch = 120 minPitch = 100 } 
				} 
			] 
		} 
	} 
	{ 
		terrain = TERRAIN_GRINDWOODRAILING 
		SoundActions = { 
			TA_GRIND = { sound = "Terrains\\GrindWoodRailing" maxPitch = 150 minPitch = 120 maxVol = 100 minVol = 50 } 
			TA_GRINDJUMP = { sound = "Terrains\\OllieWood" OllieWoodValues maxPitch = 140 minPitch = 130 } 
			TA_GRINDLAND = { sound = "Terrains\\LandWood" LandWoodValues loadVol = 100 maxPitch = 150 minPitch = 149 } 
			TA_SLIDE = { sound = "Terrains\\SlideWood" loadVol = 100 maxPitch = 120 minPitch = 90 maxVol = 100 minVol = 20 } 
			TA_SLIDEJUMP = { sound = "Terrains\\OllieWood" OllieWoodValues maxPitch = 140 minPitch = 130 } 
			TA_SLIDELAND = { sound = "Terrains\\LandWood" LandWoodValues loadVol = 100 maxPitch = 150 minPitch = 149 } 
		} 
	} 
	{ 
		terrain = TERRAIN_GRINDWOODLOG 
		SoundActions = { 
			TA_GRIND = { sound = "Terrains\\GrindWood" maxPitch = 100 minPitch = 60 maxVol = 100 minVol = 20 } 
			TA_GRINDJUMP = { sound = "Terrains\\OllieWood" OllieWoodValues } 
			TA_GRINDLAND = { sound = "Terrains\\LandWood" LandWoodValues loadVol = 100 } 
			TA_SLIDE = { sound = "Terrains\\SlideWoodLog" loadVol = 100 maxPitch = 120 minPitch = 70 maxVol = 100 minVol = 20 } 
			TA_SLIDEJUMP = { sound = "Terrains\\OllieWood" OllieWoodValues } 
			TA_SLIDELAND = { sound = "Terrains\\LandWood" LandWoodValues loadVol = 100 } 
		} 
	} 
	{ 
		terrain = TERRAIN_GRINDWOOD 
		SoundActions = { 
			TA_GRIND = { sound = "Terrains\\GrindWood" maxPitch = 100 minPitch = 60 maxVol = 100 minVol = 20 } 
			TA_GRINDJUMP = { sound = "Terrains\\OllieWood" OllieWoodValues } 
			TA_GRINDLAND = { sound = "Terrains\\LandWood" LandWoodValues loadVol = 100 } 
			TA_SLIDE = { sound = "Terrains\\SlideWood" pitch = 110 loadVol = 100 maxPitch = 100 minPitch = 60 maxVol = 100 minVol = 20 } 
			TA_SLIDEJUMP = { sound = "Terrains\\OllieWood" OllieWoodValues } 
			TA_SLIDELAND = { sound = "Terrains\\LandWood" LandWoodValues loadVol = 100 } 
		} 
	} 
	{ 
		terrain = TERRAIN_GRINDPLASTIC 
		SoundActions = { 
			TA_GRIND = { sound = "Terrains\\GrindPlastic" maxPitch = 120 minPitch = 90 maxVol = 100 minVol = 20 } 
			TA_GRINDJUMP = { sound = "Terrains\\OllieWood" OllieWoodValues maxPitch = 130 minPitch = 120 } 
			TA_GRINDLAND = { sound = "Terrains\\LandWood" LandWoodValues loadVol = 100 maxPitch = 140 minPitch = 139 } 
			TA_SLIDE = { sound = "Terrains\\SlidePlastic" loadVol = 100 maxPitch = 120 minPitch = 70 maxVol = 100 minVol = 20 } 
			TA_SLIDEJUMP = { sound = "Terrains\\OllieWood" OllieWoodValues maxPitch = 130 minPitch = 120 } 
			TA_SLIDELAND = { sound = "Terrains\\LandWood" LandWoodValues loadVol = 100 maxPitch = 140 minPitch = 139 } 
		} 
	} 
	{ 
		terrain = TERRAIN_GRINDCHAIN 
		SoundActions = { 
			TA_GRIND = { sound = "Terrains\\GrindChain" maxPitch = 115 minPitch = 100 maxVol = 120 minVol = 20 } 
			TA_GRINDJUMP = { sound = "Terrains\\GrindMetalOff02" maxVol = 90 minVol = 70 } 
			TA_GRINDLAND = [ 
				{ 
					useUpTo = 30 
					soundAction = { sound = "Terrains\\GrindMetalOn08" maxVol = 150 minVol = 100 maxPitch = 120 minPitch = 100 } 
				} 
				{ 
					soundAction = { sound = "Terrains\\GrindMetalOn02" maxVol = 150 minVol = 100 maxPitch = 120 minPitch = 100 } 
				} 
			] 
			TA_SLIDE = { sound = "Terrains\\SlideMetal02" maxPitch = 140 minPitch = 100 maxVol = 100 minVol = 20 } 
			TA_SLIDEJUMP = { sound = "Terrains\\GrindMetalOff02" maxVol = 90 minVol = 70 } 
			TA_SLIDELAND = [ 
				{ 
					useUpTo = 30 
					soundAction = { sound = "Terrains\\GrindMetalOn08" maxVol = 150 minVol = 100 maxPitch = 120 minPitch = 100 } 
				} 
				{ 
					soundAction = { sound = "Terrains\\GrindMetalOn02" maxVol = 150 minVol = 100 maxPitch = 120 minPitch = 100 } 
				} 
			] 
		} 
	} 
	{ 
		terrain = TERRAIN_GRINDELECTRICWIRE 
		SoundActions = { 
			TA_GRIND = { sound = "Terrains\\GrindWireSpark" maxPitch = 110 minPitch = 75 maxVol = 180 minVol = 80 } 
			TA_GRINDJUMP = { sound = "Terrains\\OllieWireSpark" maxVol = 180 minVol = 60 } 
			TA_GRINDLAND = { sound = "Terrains\\LandWireSpark" maxVol = 200 minVol = 100 } 
			TA_SLIDE = { sound = "Terrains\\GrindWireSpark" maxPitch = 120 minPitch = 80 maxVol = 150 minVol = 80 } 
			TA_SLIDEJUMP = { sound = "Terrains\\OllieWireSpark" maxVol = 180 minVol = 60 } 
			TA_SLIDELAND = { sound = "Terrains\\LandWireSpark" maxVol = 150 minVol = 100 } 
		} 
	} 
	{ 
		terrain = TERRAIN_GRINDCABLE 
		SoundActions = { 
			TA_GRIND = { sound = "Terrains\\GrindCable" maxPitch = 110 minPitch = 75 maxVol = 180 minVol = 80 } 
			TA_GRINDJUMP = { sound = "Terrains\\OllieMetal" maxVol = 180 minVol = 60 } 
			TA_GRINDLAND = { sound = "Terrains\\LandWire" maxVol = 200 minVol = 100 } 
			TA_SLIDE = { sound = "Terrains\\GrindCable" maxPitch = 120 minPitch = 80 maxVol = 150 minVol = 80 } 
			TA_SLIDEJUMP = { sound = "Terrains\\OllieMetal" maxVol = 180 minVol = 60 } 
			TA_SLIDELAND = { sound = "Terrains\\LandWire" maxVol = 150 minVol = 100 } 
		} 
	} 
	{ 
		terrain = TERRAIN_GRINDPLASTICBARRIER 
		SoundActions = { 
			TA_GRIND = { sound = "Terrains\\GrindPlastic" maxPitch = 120 minPitch = 90 maxVol = 100 minVol = 20 } 
			TA_GRINDJUMP = { sound = "Terrains\\OllieWood" OllieWoodValues maxPitch = 130 minPitch = 120 } 
			TA_GRINDLAND = { sound = "Terrains\\LandWood" LandWoodValues loadVol = 100 maxPitch = 140 minPitch = 139 } 
			TA_SLIDE = { sound = "Terrains\\SlidePlastic" loadVol = 100 maxPitch = 120 minPitch = 70 maxVol = 100 minVol = 20 } 
			TA_SLIDEJUMP = { sound = "Terrains\\OllieWood" OllieWoodValues maxPitch = 130 minPitch = 120 } 
			TA_SLIDELAND = { sound = "Terrains\\LandWood" LandWoodValues loadVol = 100 maxPitch = 140 minPitch = 139 } 
		} 
	} 
	{ 
		terrain = TERRAIN_GRINDNEONLIGHT 
		SoundActions = { 
			TA_GRIND = { sound = "Terrains\\GrindWireSpark" maxPitch = 110 minPitch = 75 maxVol = 180 minVol = 80 } 
			TA_GRINDJUMP = { sound = "Terrains\\OllieWireSpark" maxVol = 180 minVol = 60 } 
			TA_GRINDLAND = { sound = "Terrains\\LandWireSpark" maxVol = 200 minVol = 100 } 
			TA_SLIDE = { sound = "Terrains\\GrindWireSpark" maxPitch = 120 minPitch = 80 maxVol = 150 minVol = 80 } 
			TA_SLIDEJUMP = { sound = "Terrains\\OllieWireSpark" maxVol = 180 minVol = 60 } 
			TA_SLIDELAND = { sound = "Terrains\\LandWireSpark" maxVol = 150 minVol = 100 } 
		} 
	} 
	{ 
		terrain = TERRAIN_GRINDGLASSMONSTER 
		SoundActions = { 
			TA_GRIND = { sound = "Terrains\\GrindGlassMonster" maxPitch = 120 minPitch = 90 maxVol = 100 minVol = 20 } 
			TA_GRINDJUMP = { sound = "Terrains\\OllieWood" OllieWoodValues maxPitch = 130 minPitch = 120 } 
			TA_GRINDLAND = { sound = "Terrains\\LandWood" LandWoodValues loadVol = 100 maxPitch = 140 minPitch = 139 } 
			TA_SLIDE = { sound = "Terrains\\GrindGlassMonster" loadVol = 100 maxPitch = 120 minPitch = 70 maxVol = 100 minVol = 20 } 
			TA_SLIDEJUMP = { sound = "Terrains\\OllieWood" OllieWoodValues maxPitch = 130 minPitch = 120 } 
			TA_SLIDELAND = { sound = "Terrains\\LandWood" LandWoodValues loadVol = 100 maxPitch = 140 minPitch = 139 } 
		} 
	} 
	{ 
		terrain = TERRAIN_GRINDBANYONTREE 
		SoundActions = { 
			TA_GRIND = { sound = "Terrains\\GrindBanyonTree" maxPitch = 100 minPitch = 60 maxVol = 100 minVol = 20 } 
			TA_GRINDJUMP = { sound = "Terrains\\OllieWood" OllieWoodValues } 
			TA_GRINDLAND = { sound = "Terrains\\LandWood" LandWoodValues loadVol = 100 } 
			TA_SLIDE = { sound = "Terrains\\GrindBanyonTree" loadVol = 100 maxPitch = 120 minPitch = 70 maxVol = 100 minVol = 20 } 
			TA_SLIDEJUMP = { sound = "Terrains\\OllieWood" OllieWoodValues } 
			TA_SLIDELAND = { sound = "Terrains\\LandWood" LandWoodValues loadVol = 100 } 
		} 
	} 
	{ 
		terrain = TERRAIN_GRINDBRASSRAIL 
		SoundActions = { 
			TA_GRIND = { sound = "Terrains\\GrindMetalPole22" maxPitch = 105 minPitch = 85 maxVol = 120 minVol = 50 } 
			TA_GRINDJUMP = { sound = "Terrains\\GrindMetalPoleOff21" maxVol = 90 minVol = 70 } 
			TA_GRINDLAND = [ 
				{ 
					useUpTo = 30 
					soundAction = { sound = "Terrains\\GrindMetalOn08" maxVol = 150 minVol = 100 maxPitch = 120 minPitch = 100 } 
				} 
				{ 
					soundAction = { sound = "Terrains\\GrindMetalPoleOn21" maxVol = 150 minVol = 100 maxPitch = 120 minPitch = 100 } 
				} 
			] 
			TA_SLIDE = { sound = "Terrains\\SlideMetalPole22" maxPitch = 115 minPitch = 95 maxVol = 100 minVol = 20 } 
			TA_SLIDEJUMP = { sound = "Terrains\\GrindMetalPoleOff21" maxVol = 90 minVol = 70 } 
			TA_SLIDELAND = [ 
				{ 
					useUpTo = 30 
					soundAction = { sound = "Terrains\\GrindMetalOn08" maxVol = 150 minVol = 100 maxPitch = 120 minPitch = 100 } 
				} 
				{ 
					soundAction = { sound = "Terrains\\GrindMetalPoleOn21" maxVol = 150 minVol = 100 maxPitch = 120 minPitch = 100 } 
				} 
			] 
		} 
	} 
	{ 
		terrain = TERRAIN_GRINDCATWALK 
		SoundActions = { 
			TA_GRIND = { sound = "Terrains\\GrindMetal02" maxPitch = 115 minPitch = 100 maxVol = 120 minVol = 20 } 
			TA_GRINDJUMP = { sound = "Terrains\\GrindMetalOff02" maxVol = 90 minVol = 70 } 
			TA_GRINDLAND = [ 
				{ 
					useUpTo = 30 
					soundAction = { sound = "Terrains\\GrindMetalOn08" maxVol = 150 minVol = 100 maxPitch = 120 minPitch = 100 } 
				} 
				{ 
					soundAction = { sound = "Terrains\\GrindMetalOn02" maxVol = 150 minVol = 100 maxPitch = 120 minPitch = 100 } 
				} 
			] 
			TA_SLIDE = { sound = "Terrains\\SlideMetal02" maxPitch = 140 minPitch = 100 maxVol = 100 minVol = 20 } 
			TA_SLIDEJUMP = { sound = "Terrains\\GrindMetalOff02" maxVol = 90 minVol = 70 } 
			TA_SLIDELAND = [ 
				{ 
					useUpTo = 30 
					soundAction = { sound = "Terrains\\GrindMetalOn08" maxVol = 150 minVol = 100 maxPitch = 120 minPitch = 100 } 
				} 
				{ 
					soundAction = { sound = "Terrains\\GrindMetalOn02" maxVol = 150 minVol = 100 maxPitch = 120 minPitch = 100 } 
				} 
			] 
		} 
	} 
	{ 
		terrain = TERRAIN_GRINDTANKTURRET 
		SoundActions = { 
			TA_GRIND = { sound = "Terrains\\GrindTankTurret" maxPitch = 115 minPitch = 100 maxVol = 120 minVol = 20 } 
			TA_GRINDJUMP = { sound = "Terrains\\GrindMetalOff02" maxVol = 90 minVol = 70 } 
			TA_GRINDLAND = { sound = "Terrains\\LandTankTurret" LandWoodValues loadVol = 100 } 
			TA_SLIDE = { sound = "Terrains\\SlideMetal02" maxPitch = 140 minPitch = 100 maxVol = 100 minVol = 20 } 
			TA_SLIDEJUMP = { sound = "Terrains\\GrindMetalOff02" maxVol = 90 minVol = 70 } 
			TA_SLIDELAND = { sound = "Terrains\\LandTankTurret" LandWoodValues loadVol = 100 } 
		} 
	} 
	{ 
		terrain = TERRAIN_GRINDTRAIN 
		SoundActions = { 
			TA_GRIND = { sound = "Terrains\\GrindTrain" loadVol = 100 maxPitch = 100 minPitch = 60 maxVol = 200 minVol = 80 } 
		} 
	} 
	{ 
		terrain = TERRAIN_GRINDROPE 
		SoundActions = { 
			TA_GRIND = { sound = "Terrains\\GrindRope" loadVol = 50 pitch = 70 maxPitch = 100 minPitch = 60 maxVol = 200 minVol = 80 } 
			TA_GRINDJUMP = { sound = "Terrains\\OllieWood" OllieWoodValues } 
			TA_GRINDLAND = { sound = "Terrains\\LandWood" loadVol = 80 maxVol = 100 minVol = 60 } 
			TA_SLIDE = { sound = "Terrains\\GrindRope" loadVol = 50 maxPitch = 100 minPitch = 60 maxVol = 100 minVol = 20 } 
			TA_SLIDEJUMP = { sound = "Terrains\\OllieWood" loadVol = 80 OllieWoodValues } 
			TA_SLIDELAND = { sound = "Terrains\\LandWood" loadVol = 80 maxVol = 120 minVol = 80 } 
		} 
	} 
	{ 
		terrain = TERRAIN_GRINDWIRE 
		SoundActions = { 
			TA_GRIND = { sound = "Terrains\\GrindWireSpark" maxPitch = 110 minPitch = 75 maxVol = 150 minVol = 80 } 
			TA_GRINDJUMP = { sound = "Terrains\\OllieWireSpark" maxVol = 150 minVol = 60 } 
			TA_GRINDLAND = { sound = "Terrains\\LandWireSpark" maxVol = 175 minVol = 100 } 
			TA_SLIDE = { sound = "Terrains\\GrindWireSpark" maxPitch = 120 minPitch = 80 maxVol = 130 minVol = 80 } 
			TA_SLIDEJUMP = { sound = "Terrains\\OllieWireSpark" maxVol = 150 minVol = 60 } 
			TA_SLIDELAND = { sound = "Terrains\\LandWireSpark" maxVol = 130 minVol = 100 } 
		} 
	} 
] 

