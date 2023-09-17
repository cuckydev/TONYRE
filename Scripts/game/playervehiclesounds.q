
PlayerVehicleSoundGlobalParameters = { 
	idle_engine_effective_speed_factor = 0.50000000000 
	effective_speed_lerp_rate = 3 
	effective_speed_adjust_up_rate = 12 
	effective_speed_adjust_down_rate = 6 
	gear_shift_min_vol_factor = 0.30000001192 
	gear_shift_vol_adjustment_duration = 200 
	engine_rpm_lerp_rate = 12 
	engine_airborne_delay = 0.03999999911 
	tire_slip_lerp_rate = 10 
	collision_cutoff_factor = 0.10000000149 
	collision_mute_delay = 800 
	CAGEngineSound = CarLoop 
	CAGTireSound = Vehicle_Tire_Loop 
	CAGCollideSound = { BonkMetal_11 minVol = 100 maxVel = 300 minPitch = 80 maxPitch = 120 } 
} 
PlayerVehicleSounds = { 
	Default = { 
		EngineSound = CarLoop 
		MinEngineVol = 150 
		MaxEngineVol = 180 
		MinEnginePitch = 60 
		MaxEnginePitch = 120 
		MinEngineRPM = 0 
		MaxEngineRPM = 100 
		Gears = [ 
			{ 
				DownshiftPoint = 0 
				UpshiftPoint = 50 
				BottomRPM = 60 
				TopRPM = 100 
			} 
			{ 
				DownshiftPoint = 10 
				UpshiftPoint = 75 
				BottomRPM = 40 
				TopRPM = 100 
			} 
			{ 
				DownshiftPoint = 50 
				UpshiftPoint = 100 
				BottomRPM = 20 
				TopRPM = 100 
			} 
		] 
		TireSound = Vehicle_Tire_Loop 
		FullTireSlipVelocity = 1500 
		MinTireVol = 0 
		MaxTireVol = 300 
		MinTirePitch = 80 
		MaxTirePitch = 100 
		CollideSound = { BonkMetal_11 minVol = 100 maxVel = 300 minPitch = 80 maxPitch = 120 } 
		FullCollision = 5000 
	} 
	NJ_NasalRacer = { 
		EngineSound = NJ_NasalRacer04 
		MinEngineVol = 150 
		MaxEngineVol = 200 
		MinEnginePitch = 60 
		MaxEnginePitch = 120 
		MinEngineRPM = 0 
		MaxEngineRPM = 100 
		Gears = [ 
			{ 
				DownshiftPoint = 0 
				UpshiftPoint = 40 
				BottomRPM = 10 
				TopRPM = 100 
			} 
			{ 
				DownshiftPoint = 20 
				UpshiftPoint = 60 
				BottomRPM = 35 
				TopRPM = 100 
			} 
			{ 
				DownshiftPoint = 40 
				UpshiftPoint = 80 
				BottomRPM = 40 
				TopRPM = 100 
			} 
		] 
		TireSound = Vehicle_Tire_Loop 
		FullTireSlipVelocity = 1500 
		MinTireVol = 0 
		MaxTireVol = 300 
		MinTirePitch = 80 
		MaxTirePitch = 100 
		CollideSound = { BonkMetal_11 minVol = 100 maxVel = 300 minPitch = 80 maxPitch = 120 } 
		FullCollision = 5000 
	} 
	NY_JunkCar = { 
		EngineSound = CarLoop 
		MinEngineVol = 150 
		MaxEngineVol = 180 
		MinEnginePitch = 60 
		MaxEnginePitch = 120 
		MinEngineRPM = 0 
		MaxEngineRPM = 100 
		Gears = [ 
			{ 
				DownshiftPoint = 0 
				UpshiftPoint = 50 
				BottomRPM = 60 
				TopRPM = 100 
			} 
			{ 
				DownshiftPoint = 10 
				UpshiftPoint = 75 
				BottomRPM = 40 
				TopRPM = 100 
			} 
			{ 
				DownshiftPoint = 50 
				UpshiftPoint = 100 
				BottomRPM = 20 
				TopRPM = 100 
			} 
		] 
		TireSound = Vehicle_Tire_Loop 
		FullTireSlipVelocity = 1500 
		MinTireVol = 0 
		MaxTireVol = 300 
		MinTirePitch = 80 
		MaxTirePitch = 100 
		CollideSound = { BonkMetal_11 minVol = 100 maxVel = 300 minPitch = 80 maxPitch = 120 } 
		FullCollision = 5000 
	} 
	NY_Car02 = { 
		EngineSound = CarLoop 
		MinEngineVol = 150 
		MaxEngineVol = 180 
		MinEnginePitch = 60 
		MaxEnginePitch = 120 
		MinEngineRPM = 0 
		MaxEngineRPM = 100 
		Gears = [ 
			{ 
				DownshiftPoint = 0 
				UpshiftPoint = 50 
				BottomRPM = 60 
				TopRPM = 100 
			} 
			{ 
				DownshiftPoint = 10 
				UpshiftPoint = 75 
				BottomRPM = 40 
				TopRPM = 100 
			} 
			{ 
				DownshiftPoint = 50 
				UpshiftPoint = 100 
				BottomRPM = 20 
				TopRPM = 100 
			} 
		] 
		TireSound = Vehicle_Tire_Loop 
		FullTireSlipVelocity = 1500 
		MinTireVol = 0 
		MaxTireVol = 300 
		MinTirePitch = 80 
		MaxTirePitch = 100 
		CollideSound = { BonkMetal_11 minVol = 100 maxVel = 300 minPitch = 80 maxPitch = 120 } 
		FullCollision = 5000 
	} 
	FL_PoliceCar = { 
		EngineSound = CarLoop 
		MinEngineVol = 150 
		MaxEngineVol = 180 
		MinEnginePitch = 60 
		MaxEnginePitch = 110 
		MinEngineRPM = 0 
		MaxEngineRPM = 100 
		Gears = [ 
			{ 
				DownshiftPoint = 0 
				UpshiftPoint = 40 
				BottomRPM = 30 
				TopRPM = 100 
			} 
			{ 
				DownshiftPoint = 25 
				UpshiftPoint = 60 
				BottomRPM = 40 
				TopRPM = 100 
			} 
			{ 
				DownshiftPoint = 50 
				UpshiftPoint = 85 
				BottomRPM = 30 
				TopRPM = 100 
			} 
		] 
		TireSound = Vehicle_Tire_Loop 
		FullTireSlipVelocity = 1500 
		MinTireVol = 0 
		MaxTireVol = 300 
		MinTirePitch = 80 
		MaxTirePitch = 100 
		CollideSound = { BonkMetal_11 minVol = 100 maxVel = 300 minPitch = 80 maxPitch = 120 } 
		FullCollision = 5000 
	} 
	SD_Cart = { 
		EngineSound = SD_CartLoop 
		MinEngineVol = 25 
		MaxEngineVol = 180 
		MinEnginePitch = 25 
		MaxEnginePitch = 75 
		MinEngineRPM = 0 
		MaxEngineRPM = 100 
		Gears = [ 
			{ 
				DownshiftPoint = 0 
				UpshiftPoint = 35 
				BottomRPM = 0 
				TopRPM = 100 
			} 
		] 
		TireSound = Vehicle_Tire_Loop 
		FullTireSlipVelocity = 600 
		MinTireVol = 0 
		MaxTireVol = 300 
		MinTirePitch = 100 
		MaxTirePitch = 130 
		CollideSound = { BonkMetal_11 minVol = 100 maxVel = 300 minPitch = 80 maxPitch = 180 } 
		FullCollision = 5000 
	} 
	HI_Car = { 
		EngineSound = CarLoop 
		MinEngineVol = 150 
		MaxEngineVol = 180 
		MinEnginePitch = 60 
		MaxEnginePitch = 120 
		MinEngineRPM = 0 
		MaxEngineRPM = 100 
		Gears = [ 
			{ 
				DownshiftPoint = 0 
				UpshiftPoint = 50 
				BottomRPM = 60 
				TopRPM = 100 
			} 
			{ 
				DownshiftPoint = 10 
				UpshiftPoint = 75 
				BottomRPM = 40 
				TopRPM = 100 
			} 
			{ 
				DownshiftPoint = 50 
				UpshiftPoint = 100 
				BottomRPM = 20 
				TopRPM = 100 
			} 
		] 
		TireSound = Vehicle_Tire_Loop 
		FullTireSlipVelocity = 1500 
		MinTireVol = 0 
		MaxTireVol = 300 
		MinTirePitch = 80 
		MaxTirePitch = 100 
		CollideSound = { BonkMetal_11 minVol = 100 maxVel = 300 minPitch = 80 maxPitch = 120 } 
		FullCollision = 5000 
	} 
	VC_Limo = { 
		EngineSound = CarLoop 
		MinEngineVol = 150 
		MaxEngineVol = 180 
		MinEnginePitch = 60 
		MaxEnginePitch = 110 
		MinEngineRPM = 0 
		MaxEngineRPM = 100 
		Gears = [ 
			{ 
				DownshiftPoint = 0 
				UpshiftPoint = 40 
				BottomRPM = 20 
				TopRPM = 100 
			} 
			{ 
				DownshiftPoint = 20 
				UpshiftPoint = 75 
				BottomRPM = 30 
				TopRPM = 100 
			} 
			{ 
				DownshiftPoint = 50 
				UpshiftPoint = 100 
				BottomRPM = 40 
				TopRPM = 100 
			} 
		] 
		TireSound = Vehicle_Tire_Loop 
		FullTireSlipVelocity = 1500 
		MinTireVol = 0 
		MaxTireVol = 300 
		MinTirePitch = 80 
		MaxTirePitch = 100 
		CollideSound = { BonkMetal_11 minVol = 100 maxVel = 300 minPitch = 80 maxPitch = 120 } 
		FullCollision = 5000 
	} 
	VC_LeafBlower = { 
		EngineSound = VC_LeafBlowerEngineLoop 
		MinEngineVol = 150 
		MaxEngineVol = 180 
		MinEnginePitch = 70 
		MaxEnginePitch = 100 
		MinEngineRPM = 0 
		MaxEngineRPM = 100 
		Gears = [ 
			{ 
				DownshiftPoint = 0 
				UpshiftPoint = 35 
				BottomRPM = 0 
				TopRPM = 100 
			} 
		] 
		TireSound = Vehicle_Tire_Loop 
		FullTireSlipVelocity = 1500 
		MinTireVol = 0 
		MaxTireVol = 300 
		MinTirePitch = 80 
		MaxTirePitch = 100 
		CollideSound = { BonkMetal_11 minVol = 100 maxVel = 300 minPitch = 80 maxPitch = 120 } 
		FullCollision = 5000 
	} 
	SJ_Blimp = { 
		EngineSound = SJ_BlimpEngineLoop 
		MinEngineVol = 100 
		MaxEngineVol = 150 
		MinEnginePitch = 80 
		MaxEnginePitch = 120 
		MinEngineRPM = 0 
		MaxEngineRPM = 100 
		Gears = [ 
			{ 
				DownshiftPoint = 0 
				UpshiftPoint = 25 
				BottomRPM = 0 
				TopRPM = 100 
			} 
		] 
		TireSound = Vehicle_Tire_Loop 
		FullTireSlipVelocity = 15000 
		MinTireVol = 0 
		MaxTireVol = 300 
		MinTirePitch = 80 
		MaxTirePitch = 100 
		CollideSound = { BonkMetal_11 minVol = 0 maxVel = 0 minPitch = 80 maxPitch = 120 } 
		FullCollision = 5000 
	} 
	RU_ForeignCar = { 
		EngineSound = CarLoop 
		MinEngineVol = 150 
		MaxEngineVol = 180 
		MinEnginePitch = 60 
		MaxEnginePitch = 120 
		MinEngineRPM = 0 
		MaxEngineRPM = 100 
		Gears = [ 
			{ 
				DownshiftPoint = 0 
				UpshiftPoint = 50 
				BottomRPM = 60 
				TopRPM = 100 
			} 
			{ 
				DownshiftPoint = 10 
				UpshiftPoint = 75 
				BottomRPM = 40 
				TopRPM = 100 
			} 
			{ 
				DownshiftPoint = 50 
				UpshiftPoint = 100 
				BottomRPM = 20 
				TopRPM = 100 
			} 
		] 
		TireSound = Vehicle_Tire_Loop 
		FullTireSlipVelocity = 1500 
		MinTireVol = 0 
		MaxTireVol = 300 
		MinTirePitch = 80 
		MaxTirePitch = 100 
		CollideSound = { BonkMetal_11 minVol = 100 maxVel = 300 minPitch = 80 maxPitch = 120 } 
		FullCollision = 5000 
	} 
	SE_ATV = { 
		EngineSound = CarLoop 
		MinEngineVol = 150 
		MaxEngineVol = 180 
		MinEnginePitch = 60 
		MaxEnginePitch = 120 
		MinEngineRPM = 0 
		MaxEngineRPM = 100 
		Gears = [ 
			{ 
				DownshiftPoint = 0 
				UpshiftPoint = 50 
				BottomRPM = 60 
				TopRPM = 100 
			} 
			{ 
				DownshiftPoint = 10 
				UpshiftPoint = 75 
				BottomRPM = 40 
				TopRPM = 100 
			} 
			{ 
				DownshiftPoint = 50 
				UpshiftPoint = 100 
				BottomRPM = 20 
				TopRPM = 100 
			} 
		] 
		TireSound = Vehicle_Tire_Loop 
		FullTireSlipVelocity = 1500 
		MinTireVol = 0 
		MaxTireVol = 300 
		MinTirePitch = 80 
		MaxTirePitch = 100 
		CollideSound = { BonkMetal_11 minVol = 100 maxVel = 300 minPitch = 80 maxPitch = 120 } 
		FullCollision = 5000 
	} 
	TestThreeGear = { 
		EngineSound = CarLoop 
		MinEngineVol = 150 
		MaxEngineVol = 180 
		MinEnginePitch = 60 
		MaxEnginePitch = 120 
		MinEngineRPM = 0 
		MaxEngineRPM = 100 
		Gears = [ 
			{ 
				DownshiftPoint = 0 
				UpshiftPoint = 50 
				BottomRPM = 60 
				TopRPM = 100 
			} 
			{ 
				DownshiftPoint = 10 
				UpshiftPoint = 75 
				BottomRPM = 40 
				TopRPM = 100 
			} 
			{ 
				DownshiftPoint = 50 
				UpshiftPoint = 100 
				BottomRPM = 20 
				TopRPM = 100 
			} 
		] 
		TireSound = Vehicle_Tire_Loop 
		FullTireSlipVelocity = 1500 
		MinTireVol = 0 
		MaxTireVol = 300 
		MinTirePitch = 80 
		MaxTirePitch = 100 
		CollideSound = { BonkMetal_11 minVol = 100 maxVel = 300 minPitch = 80 maxPitch = 120 } 
		FullCollision = 5000 
	} 
	TestSingleGear = { 
		EngineSound = Moto7000rpm01 
		MinEngineRPM = 0 
		MaxEngineRPM = 100 
		MinEngineVol = 50 
		MaxEngineVol = 100 
		MinEnginePitch = 50 
		MaxEnginePitch = 100 
		Gears = [ 
			{ 
				DownshiftPoint = 0 
				UpshiftPoint = 35 
				BottomRPM = 0 
				TopRPM = 100 
			} 
		] 
		TireSound = Vehicle_Tire_Loop 
		FullTireSlipVelocity = 1500 
		MinTireVol = 0 
		MaxTireVol = 300 
		MinTirePitch = 80 
		MaxTirePitch = 100 
		CollideSound = { BonkMetal_11 minVol = 80 maxVel = 100 } 
		FullCollision = 500 
	} 
} 

