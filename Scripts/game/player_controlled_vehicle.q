
SCRIPT DrivingAi 
	ClearAllWalkingExceptions 
	ClearExceptions 
	SetEventhandler Ex = Vehicle_BodyCollision Scr = Vehicle_BodyCollision 
	SetEventhandler Ex = SkaterCollideBail Scr = DrivingCollisionLost 
	SetEventhandler Ex = MadeOtherSkaterBail Scr = MadeOtherSkaterBailCar 
	SetException Ex = RunHasEnded Scr = EndOfRun 
	SetException Ex = GoalHasEnded Scr = Goal_EndOfRun 
	Block 
ENDSCRIPT

SCRIPT ToggleUserControlledVehicleMode 
	IF NOT Skater : Driving 
		IF InNetGame 
			Obj_GetId 
			BroadcastEnterVehicle SkaterId = <ObjId> control_type = ( <VehicleSetup> . control_type ) 
		ENDIF 
		Skater : BashOff 
		Skater : NollieOff 
		Skater : PressureOff 
		Skater : LandSkaterTricks 
		Skater : ResetSwitched 
		Skater : ClearTrickQueues 
		Skater : DestroyAllSpecialItems 
		Skater : SparksOff 
		Skater : VibrateOff 
		Skater : StopBalanceTrick 
		Skater : KillExtraTricks 
		Skater : SetExtraTricks NoTricks 
		createPlayerVehicle <...> 
		Skater : PausePhysics 
		Skater : SkaterLoopingSound_TurnOff 
		Skater : TakeBoardFromSkater 
		Skater : Obj_ShadowOff 
		GoalManager_HideAllGoalPeds 1 
		Skater : SetDriving 
		Debounce X 
		Debounce Square 
		MakeSkaterGoto DrivingAi 
	ELSE 
		Skater : GetCameraId 
		IF NOT GameIsPaused 
			<CameraId> : UnPause 
		ENDIF 
		SetActiveCamera Id = <CameraId> 
		PlayerVehicle : Die 
		PlayerVehicleCamera : Die 
		Skater : UnsetDriving 
		Skater : ReturnBoardToSkater 
		Skater : Obj_ShadowOn ShadowType = Detailed 
		Skater : ResetRigidBodyCollisionRadiusBoost 
		GoalManager_HideAllGoalPeds 0 
		Change driving_parked_car = 0 
	ENDIF 
ENDSCRIPT

SCRIPT createPlayerVehicle VehicleSetup = defaultCarSetup 
	IF GotParam Exitable 
		VehicleSetup = ( <VehicleSetup> + { Exitable } ) 
	ENDIF 
	IF GotParam edited_goal 
		VehicleSetup = ( <VehicleSetup> + { edited_goal } ) 
	ENDIF 
	IF NOT ObjectExists Id = PlayerVehicle 
		CreateCompositeObject { 
			components = [ 
				{ 
					component = skeleton 
					skeletonName = car 
				} 
				{ 
					component = vehicle 
				} 
				{ 
					component = vehiclesound 
				} 
				{ 
					component = sound 
				} 
				{ 
					component = input 
					player = 0 
				} 
				{ 
					component = model 
					UseModelLights 
				} 
			] 
			params = { 
				name = PlayerVehicle 
				<VehicleSetup> 
			} 
		} 
		CreateCompositeObject { 
			components = [ 
				{ 
					component = cameralookaround 
				} 
				{ 
					component = vehiclecamera 
					subject = PlayerVehicle 
					vehicleCameraSetup 
				} 
				{ 
					component = camera 
				} 
				{ 
					component = input 
					player = 0 
				} 
			] 
			params = { name = PlayerVehicleCamera } 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT NonLocalClientInVehicle 
	MangleChecksums A = <SkaterId> B = NonLocalPlayerVehicle 
	NonLocalPlayerVehicle = <mangled_id> 
	IF ObjectExists Id = <NonLocalPlayerVehicle> 
		<NonLocalPlayerVehicle> : GetTags 
		IF NOT ( <control_type> = <current_control_type> ) 
			remove_car_from_non_local_skater SkaterId = <SkaterId> 
		ENDIF 
	ENDIF 
	IF NOT ObjectExists Id = <NonLocalPlayerVehicle> 
		lock_car_to_non_local_skater SkaterId = <SkaterId> control_type = <control_type> 
	ENDIF 
	GetVehicleSetup control_type = <control_type> 
	IF NOT StructureContains Structure = <VehicleSetup> make_skater_visible 
		<SkaterId> : Hide 
	ELSE 
		<SkaterId> : Obj_ShadowOff 
		<SkaterId> : SwitchOffAtomic Board 
	ENDIF 
ENDSCRIPT

SCRIPT NonLocalClientExitVehicle 
	remove_car_from_non_local_skater SkaterId = <SkaterId> 
	<SkaterId> : UnHide 
	<SkaterId> : Obj_ShadowOn ShadowType = Simple 
	<SkaterId> : SwitchOnAtomic Board 
ENDSCRIPT

SCRIPT lock_car_to_non_local_skater 
	MangleChecksums A = <SkaterId> B = NonLocalPlayerVehicle 
	NonLocalPlayerVehicle = <mangled_id> 
	GetVehicleSetup control_type = <control_type> 
	GetCurrentLevel 
	VehicleSetupLevel = ( <VehicleSetup> . level ) 
	VehicleSetupAlternateLevel = ( <VehicleSetup> . alternate_level ) 
	IF NOT ( ( <level> = <VehicleSetupLevel> ) | ( <level> = <VehicleSetupAlternateLevel> ) ) 
		RETURN 
	ENDIF 
	CreateCompositeObject { 
		components = [ 
			{ 
				component = staticvehicle 
			} 
			{ 
				component = skeleton 
				skeletonName = car 
			} 
			{ 
				component = lockobj 
			} 
			{ 
				component = setdisplaymatrix 
			} 
			{ 
				component = model 
				model = ( <VehicleSetup> . model ) 
				UseModelLights 
			} 
			{ 
				component = modellightupdate 
			} 
		] 
		params = { name = <NonLocalPlayerVehicle> } 
	} 
	<NonLocalPlayerVehicle> : Obj_LockToObject Id = <SkaterId> ( VECTOR(0, 0, 0) - ( <VehicleSetup> . skater_pos ) ) 
	<NonLocalPlayerVehicle> : SetTags current_control_type = <control_type> 
ENDSCRIPT

SCRIPT remove_car_from_non_local_skater 
	MangleChecksums A = <SkaterId> B = NonLocalPlayerVehicle 
	NonLocalPlayerVehicle = <mangled_id> 
	IF ObjectExists Id = <NonLocalPlayerVehicle> 
		<NonLocalPlayerVehicle> : Die 
	ENDIF 
ENDSCRIPT

SCRIPT DrivingCollisionLost 
	PlayerVehicle : Vehicle_LostCollision <...> 
ENDSCRIPT

SCRIPT GetVehicleSetup 
	SWITCH <control_type> 
		CASE JunkerCar 
			RETURN VehicleSetup = TransCarSetup 
		CASE RallyCar 
			RETURN VehicleSetup = CustomCarSetup 
		CASE ImpalaCar 
			RETURN VehicleSetup = ImpalaCarSetup 
		CASE TaxiCar 
			RETURN VehicleSetup = TaxiCarSetup 
		CASE PoliceCar 
			RETURN VehicleSetup = PoliceCarSetup 
		CASE SecurityCart 
			RETURN VehicleSetup = SecurityCartSetup 
		CASE GardnersCart 
			RETURN VehicleSetup = GardnersCartSetup 
		CASE ElCaminoCar 
			RETURN VehicleSetup = ElCaminoCarSetup 
		CASE Blimp 
			RETURN VehicleSetup = BlimpSetup 
		CASE LadaCar 
			RETURN VehicleSetup = LadaCarSetup 
		CASE MiniBajaCar 
			RETURN VehicleSetup = MiniBajaCarSetup 
		CASE LimoCar 
			RETURN VehicleSetup = LimoCarSetup 
		CASE LeafBlower 
			RETURN VehicleSetup = LeafBlowerSetup 
	ENDSWITCH 
ENDSCRIPT

vehicleCameraSetup = { 
	alignment_rate = 3.50000000000 
	offset_height = 55 
	offset_distance = 240 
	angle = 0 
} 
SCRIPT Vehicle_BodyCollision 
	Vibrate Actuator = 1 Percent = ( 50 + 50 * <Strength> ) Duration = ( 0.10000000149 + 0.10000000149 * <Strength> ) 
ENDSCRIPT

artificial_collision_duration = 3.00000000000 
coll_forward_imp = 150 
coll_sideways_imp = 100 
coll_upwards_imp = 300 
coll_spin_rot = 2 
coll_flip_rot = 3 
vehicle_physics_artificial_collision_duration = 3 
vehicle_physics_netcoll_forward_impulse = 250 
vehicle_physics_netcoll_sideways_impulse = 100 
vehicle_physics_netcoll_upwards_impulse = 300 
vehicle_physics_netcoll_spin_impulse = 2 
vehicle_physics_netcoll_flip_impulse = 3 
TransCarSetup = { 
	control_type = JunkerCar 
	model = "veh\\veh_transam\\veh_transam.mdl" 
	level = Load_Sk5Ed_gameplay 
	alternate_level = 0 
	sounds = NJ_nasalracer 
	skater_pos = VECTOR(0.00000000000, 0.00000000000, 0.00000000000) 
	suspension_center_of_mass = -22 
	mass = 2943 
	moment_of_inertia = VECTOR(6000000.00000000000, 5000000.00000000000, 6000000.00000000000) 
	body_restitution = 0.30000001192 
	body_friction = 0.20000000298 
	body_wipeout_friction = 0.40000000596 
	body_spring = 1200 
	collision_control = 0.25000000000 
	max_steering_angle = 30 
	constant_rotational_damping = 2000000 
	quadratic_rotational_damping = 0.00010000000 
	in_air_slerp_strength = 5 
	in_air_slerp_time_delay = 1 
	in_air_slerp_velocity_cutoff = 350 
	colliders = [ 
		[ 
			VECTOR(36.00000000000, 28.00000000000, 140.00000000000) 
			VECTOR(-36.00000000000, 28.00000000000, 140.00000000000) 
			VECTOR(36.00000000000, 28.00000000000, -44.00000000000) 
		] 
		[ 
			VECTOR(26.00000000000, 48.00000000000, 58.00000000000) 
			VECTOR(-26.00000000000, 48.00000000000, 58.00000000000) 
			VECTOR(26.00000000000, 48.00000000000, 4.00000000000) 
		] 
	] 
	engine = { 
		drive_torque = 400 
		drag_torque = 800 
		upshift_rpm = 5000 
		differential_ratio = 5 
		reverse_torque_ratio = 1 
		gear_ratios = [ 
			4 
			3 
			1.50000000000 
			0.64999997616 
			0 
		] 
	} 
	all_wheels = { 
		radius = 13 
		moment = 3570 
		spring_rate = 200 
		damping_rate = 28 
		static_friction = 4.00000000000 
		min_static_grip_velocity = 8 
		max_static_grip_velocity = 12 
		min_dynamic_grip_velocity = 30 
		handbrake_torque = 3000 
		brake_torque = 2000 
	} 
	wheels = [ 
		{ 
			max_draw_y_offset = -25.50000000000 
			steering = left 
			drive = yes 
			dynamic_friction = 2.79999995232 
			handbrake_throttle_friction = 3.50000000000 
			handbrake_locked_friction = 4.00000000000 
		} 
		{ 
			max_draw_y_offset = -25.50000000000 
			steering = right 
			drive = yes 
			dynamic_friction = 2.79999995232 
			handbrake_throttle_friction = 3.50000000000 
			handbrake_locked_friction = 4.00000000000 
		} 
		{ 
			max_draw_y_offset = -21 
			steering = fixed 
			drive = yes 
			dynamic_friction = 3.50000000000 
			handbrake_throttle_friction = 3.00000000000 
			handbrake_locked_friction = 1.00000000000 
		} 
		{ 
			max_draw_y_offset = -21 
			steering = fixed 
			drive = yes 
			dynamic_friction = 3.50000000000 
			handbrake_throttle_friction = 3.00000000000 
			handbrake_locked_friction = 1.00000000000 
		} 
	] 
} 
CustomCarSetup = { 
	control_type = RallyCar 
	model = "veh\\veh_custom\\veh_custom.mdl" 
	level = Load_NJ 
	alternate_level = 0 
	sounds = NJ_nasalracer 
	skater_pos = VECTOR(0.00000000000, 0.00000000000, 0.00000000000) 
	suspension_center_of_mass = -22 
	mass = 2943 
	moment_of_inertia = VECTOR(6000000.00000000000, 5000000.00000000000, 6000000.00000000000) 
	body_restitution = 0.30000001192 
	body_friction = 0.20000000298 
	body_wipeout_friction = 0.40000000596 
	body_spring = 1200 
	collision_control = 0.25000000000 
	max_steering_angle = 30 
	constant_rotational_damping = 2000000 
	quadratic_rotational_damping = 0.00010000000 
	in_air_slerp_strength = 5 
	in_air_slerp_time_delay = 1 
	in_air_slerp_velocity_cutoff = 350 
	colliders = [ 
		[ 
			VECTOR(42.00000000000, 24.00000000000, 134.00000000000) 
			VECTOR(-42.00000000000, 24.00000000000, 134.00000000000) 
			VECTOR(42.00000000000, 24.00000000000, -30.00000000000) 
		] 
		[ 
			VECTOR(22.00000000000, 55.00000000000, 54.00000000000) 
			VECTOR(-22.00000000000, 55.00000000000, 54.00000000000) 
			VECTOR(22.00000000000, 63.00000000000, -26.00000000000) 
		] 
	] 
	engine = { 
		drive_torque = 400 
		drag_torque = 800 
		upshift_rpm = 5000 
		differential_ratio = 5 
		reverse_torque_ratio = 1 
		gear_ratios = [ 
			4 
			3 
			1.50000000000 
			0.64999997616 
			0 
		] 
	} 
	all_wheels = { 
		radius = 13 
		moment = 3570 
		spring_rate = 200 
		damping_rate = 28 
		static_friction = 4.00000000000 
		min_static_grip_velocity = 8 
		max_static_grip_velocity = 12 
		min_dynamic_grip_velocity = 30 
		handbrake_torque = 3000 
		brake_torque = 2000 
	} 
	wheels = [ 
		{ 
			max_draw_y_offset = -25.70000076294 
			steering = left 
			drive = yes 
			dynamic_friction = 2.79999995232 
			handbrake_throttle_friction = 3.50000000000 
			handbrake_locked_friction = 4.00000000000 
		} 
		{ 
			max_draw_y_offset = -25.70000076294 
			steering = right 
			drive = yes 
			dynamic_friction = 2.79999995232 
			handbrake_throttle_friction = 3.50000000000 
			handbrake_locked_friction = 4.00000000000 
		} 
		{ 
			max_draw_y_offset = -25.70000076294 
			steering = fixed 
			drive = yes 
			dynamic_friction = 3.50000000000 
			handbrake_throttle_friction = 3.00000000000 
			handbrake_locked_friction = 1.00000000000 
		} 
		{ 
			max_draw_y_offset = -25.70000076294 
			steering = fixed 
			drive = yes 
			dynamic_friction = 3.50000000000 
			handbrake_throttle_friction = 3.00000000000 
			handbrake_locked_friction = 1.00000000000 
		} 
	] 
} 
BlimpSetup = { 
	control_type = Blimp 
	model = "veh\\Veh_Blimp\\Veh_Blimp.mdl" 
	level = Load_SE 
	alternate_level = 0 
	sounds = SJ_Blimp 
	skater_pos = VECTOR(0.00000000000, 0.00000000000, 0.00000000000) 
	suspension_center_of_mass = -40 
	mass = 800 
	moment_of_inertia = VECTOR(4000000.00000000000, 8000000.00000000000, 4000000.00000000000) 
	body_restitution = 0.20000000298 
	body_friction = 0.10000000149 
	body_wipeout_friction = 0.40000000596 
	body_spring = 270 
	collision_control = 0.20000000298 
	max_steering_angle = 45 
	constant_rotational_damping = 0 
	quadratic_rotational_damping = 0.00001000000 
	in_air_slerp_strength = 5 
	in_air_slerp_time_delay = 1 
	in_air_slerp_velocity_cutoff = 350 
	colliders = [ 
		[ 
			VECTOR(28.00000000000, 30.00000000000, 60.00000000000) 
			VECTOR(-28.00000000000, 30.00000000000, 60.00000000000) 
			VECTOR(28.00000000000, 30.00000000000, -66.00000000000) 
		] 
		[ 
			VECTOR(18.00000000000, 45.00000000000, 30.00000000000) 
			VECTOR(-18.00000000000, 45.00000000000, 30.00000000000) 
			VECTOR(18.00000000000, 45.00000000000, -30.00000000000) 
		] 
	] 
	engine = { 
		drive_torque = 50 
		drag_torque = 5 
		upshift_rpm = 7500 
		differential_ratio = 5 
		reverse_torque_ratio = 1.50000000000 
		gear_ratios = [ 
			2.50000000000 
			0 
		] 
	} 
	no_handbrake 
	all_wheels = { 
		radius = 9 
		moment = 1000 
		spring_rate = 100 
		damping_rate = 35 
		static_friction = 1.00000000000 
		min_static_grip_velocity = 10 
		max_static_grip_velocity = 11 
		min_dynamic_grip_velocity = 12 
		handbrake_torque = 3000 
	} 
	wheels = [ 
		{ 
			max_draw_y_offset = 0 
			steering = left 
			drive = yes 
			brake_torque = 0 
			dynamic_friction = 0.80000001192 
			handbrake_throttle_friction = 0 
			handbrake_locked_friction = 0 
		} 
		{ 
			max_draw_y_offset = 0 
			steering = right 
			drive = yes 
			brake_torque = 0 
			dynamic_friction = 0.80000001192 
			handbrake_throttle_friction = 0 
			handbrake_locked_friction = 0 
		} 
		{ 
			max_draw_y_offset = 0 
			steering = fixed 
			drive = yes 
			brake_torque = 500 
			dynamic_friction = 0.80000001192 
			handbrake_throttle_friction = 0 
			handbrake_locked_friction = 0 
		} 
		{ 
			max_draw_y_offset = 0 
			steering = fixed 
			drive = yes 
			brake_torque = 500 
			dynamic_friction = 0.80000001192 
			handbrake_throttle_friction = 0 
			handbrake_locked_friction = 0 
		} 
	] 
} 
GardnersCartSetup = { 
	control_type = GardnersCart 
	model = "veh\\Veh_SDKart_Gardens\\Veh_SDKart_Gardens.mdl" 
	level = Load_SD 
	alternate_level = 0 
	sounds = SD_Cart 
	make_skater_visible 
	skater_pos = VECTOR(-10.72999954224, 1.00000000000, 26.18000030518) 
	skater_anim = Ped_Driver_Turn_Range 
	suspension_center_of_mass = -24 
	mass = 2943 
	moment_of_inertia = VECTOR(6000000.00000000000, 5000000.00000000000, 6000000.00000000000) 
	body_restitution = 0.30000001192 
	body_friction = 0.20000000298 
	body_wipeout_friction = 0.69999998808 
	body_spring = 1200 
	collision_control = 0.25000000000 
	max_steering_angle = 18 
	constant_rotational_damping = 2000000 
	quadratic_rotational_damping = 0.00010000000 
	in_air_slerp_strength = 5 
	in_air_slerp_time_delay = 0.50000000000 
	in_air_slerp_velocity_cutoff = 350 
	vert_correction 
	colliders = [ 
		[ 
			VECTOR(25.00000000000, 25.00000000000, 58.00000000000) 
			VECTOR(-25.00000000000, 25.00000000000, 58.00000000000) 
			VECTOR(25.00000000000, 25.00000000000, -60.00000000000) 
		] 
		[ 
			VECTOR(25.00000000000, 48.00000000000, 56.00000000000) 
			VECTOR(-25.00000000000, 48.00000000000, 56.00000000000) 
			VECTOR(25.00000000000, 48.00000000000, 10.00000000000) 
		] 
	] 
	engine = { 
		drive_torque = 350 
		drag_torque = 300 
		upshift_rpm = 5000 
		differential_ratio = 5 
		reverse_torque_ratio = 1 
		gear_ratios = [ 
			9 
			6 
			2.50000000000 
			0.75000000000 
			0 
		] 
	} 
	all_wheels = { 
		radius = 9 
		moment = 3570 
		spring_rate = 200 
		damping_rate = 40 
		static_friction = 4.00000000000 
		min_static_grip_velocity = 8 
		max_static_grip_velocity = 20 
		min_dynamic_grip_velocity = 30 
		handbrake_torque = 3000 
	} 
	wheels = [ 
		{ 
			max_draw_y_offset = -12 
			steering = left 
			drive = yes 
			brake_torque = 2000 
			dynamic_friction = 2.79999995232 
			handbrake_throttle_friction = 3 
			handbrake_locked_friction = 3 
		} 
		{ 
			max_draw_y_offset = -12 
			steering = right 
			drive = yes 
			brake_torque = 2000 
			dynamic_friction = 2.79999995232 
			handbrake_throttle_friction = 3 
			handbrake_locked_friction = 3 
		} 
		{ 
			max_draw_y_offset = -12 
			steering = fixed 
			drive = yes 
			brake_torque = 1000 
			dynamic_friction = 3.50000000000 
			handbrake_throttle_friction = 2.00000000000 
			handbrake_locked_friction = 2.00000000000 
		} 
		{ 
			max_draw_y_offset = -12 
			steering = fixed 
			drive = yes 
			brake_torque = 1000 
			dynamic_friction = 3.50000000000 
			handbrake_throttle_friction = 2.00000000000 
			handbrake_locked_friction = 2.00000000000 
		} 
	] 
} 
SecurityCartSetup = { 
	control_type = SecurityCart 
	model = "veh\\Veh_SDKart_Security\\Veh_SDKart_Security.mdl" 
	level = Load_SD 
	alternate_level = 0 
	sounds = SD_Cart 
	make_skater_visible 
	skater_pos = VECTOR(-10.81000041962, 1.00000000000, 26.18000030518) 
	skater_anim = Ped_Driver_Turn_Range 
	suspension_center_of_mass = -24 
	mass = 2943 
	moment_of_inertia = VECTOR(6000000.00000000000, 5000000.00000000000, 6000000.00000000000) 
	body_restitution = 0.30000001192 
	body_friction = 0.20000000298 
	body_wipeout_friction = 0.69999998808 
	body_spring = 1200 
	collision_control = 0.25000000000 
	max_steering_angle = 18 
	constant_rotational_damping = 2000000 
	quadratic_rotational_damping = 0.00010000000 
	in_air_slerp_strength = 5 
	in_air_slerp_time_delay = 0.50000000000 
	in_air_slerp_velocity_cutoff = 350 
	vert_correction 
	colliders = [ 
		[ 
			VECTOR(25.00000000000, 25.00000000000, 58.00000000000) 
			VECTOR(-25.00000000000, 25.00000000000, 58.00000000000) 
			VECTOR(25.00000000000, 25.00000000000, -60.00000000000) 
		] 
		[ 
			VECTOR(25.00000000000, 48.00000000000, 56.00000000000) 
			VECTOR(-25.00000000000, 48.00000000000, 56.00000000000) 
			VECTOR(25.00000000000, 48.00000000000, 10.00000000000) 
		] 
	] 
	engine = { 
		drive_torque = 350 
		drag_torque = 300 
		upshift_rpm = 5000 
		differential_ratio = 5 
		reverse_torque_ratio = 1 
		gear_ratios = [ 
			9 
			6 
			2.50000000000 
			0.75000000000 
			0 
		] 
	} 
	all_wheels = { 
		radius = 9 
		moment = 3570 
		spring_rate = 200 
		damping_rate = 40 
		static_friction = 4.00000000000 
		min_static_grip_velocity = 8 
		max_static_grip_velocity = 20 
		min_dynamic_grip_velocity = 30 
		handbrake_torque = 3000 
	} 
	wheels = [ 
		{ 
			max_draw_y_offset = -12 
			steering = left 
			drive = yes 
			brake_torque = 2000 
			dynamic_friction = 2.79999995232 
			handbrake_throttle_friction = 3 
			handbrake_locked_friction = 3 
		} 
		{ 
			max_draw_y_offset = -12 
			steering = right 
			drive = yes 
			brake_torque = 2000 
			dynamic_friction = 2.79999995232 
			handbrake_throttle_friction = 3 
			handbrake_locked_friction = 3 
		} 
		{ 
			max_draw_y_offset = -12 
			steering = fixed 
			drive = yes 
			brake_torque = 1000 
			dynamic_friction = 3.50000000000 
			handbrake_throttle_friction = 2.00000000000 
			handbrake_locked_friction = 2.00000000000 
		} 
		{ 
			max_draw_y_offset = -12 
			steering = fixed 
			drive = yes 
			brake_torque = 1000 
			dynamic_friction = 3.50000000000 
			handbrake_throttle_friction = 2.00000000000 
			handbrake_locked_friction = 2.00000000000 
		} 
	] 
} 
LeafBlowerSetup = { 
	control_type = LeafBlower 
	model = "veh\\Veh_LeafBlower\\Veh_LeafBlower.mdl" 
	level = Load_VC 
	alternate_level = 0 
	sounds = VC_LeafBlower 
	make_skater_visible 
	skater_pos = VECTOR(-0.14000000060, 18.00000000000, 6.98000001907) 
	skater_anim = Ped_Driver_Turn_Range 
	suspension_center_of_mass = -30 
	mass = 800 
	moment_of_inertia = VECTOR(4000000.00000000000, 3000000.00000000000, 4000000.00000000000) 
	body_restitution = 0.20000000298 
	body_friction = 0.10000000149 
	body_wipeout_friction = 0.40000000596 
	body_spring = 270 
	collision_control = 0.20000000298 
	max_steering_angle = 30 
	constant_rotational_damping = 500000 
	quadratic_rotational_damping = 0.00010000000 
	in_air_slerp_strength = 5 
	in_air_slerp_time_delay = 1 
	in_air_slerp_velocity_cutoff = 350 
	colliders = [ 
		[ 
			VECTOR(28.00000000000, 70.00000000000, 40.00000000000) 
			VECTOR(-28.00000000000, 70.00000000000, 40.00000000000) 
			VECTOR(28.00000000000, 70.00000000000, -50.00000000000) 
		] 
		[ 
			VECTOR(28.00000000000, 30.00000000000, 50.00000000000) 
			VECTOR(-28.00000000000, 30.00000000000, 50.00000000000) 
			VECTOR(28.00000000000, 30.00000000000, -55.00000000000) 
		] 
	] 
	engine = { 
		drive_torque = 50 
		drag_torque = 50 
		upshift_rpm = 7500 
		differential_ratio = 5 
		reverse_torque_ratio = 1.50000000000 
		gear_ratios = [ 
			2.50000000000 
			0 
		] 
	} 
	no_handbrake 
	all_wheels = { 
		moment = 1000 
		spring_rate = 300 
		damping_rate = 35 
		static_friction = 4.00000000000 
		min_static_grip_velocity = 2 
		max_static_grip_velocity = 8 
		min_dynamic_grip_velocity = 18 
		handbrake_torque = 3000 
	} 
	wheels = [ 
		{ 
			radius = 15 
			max_draw_y_offset = -25 
			steering = left 
			drive = yes 
			brake_torque = 500 
			dynamic_friction = 4.00000000000 
			handbrake_throttle_friction = 2.50000000000 
			handbrake_locked_friction = 2.50000000000 
		} 
		{ 
			radius = 15 
			max_draw_y_offset = -25 
			steering = right 
			drive = yes 
			brake_torque = 500 
			dynamic_friction = 4.00000000000 
			handbrake_throttle_friction = 2.50000000000 
			handbrake_locked_friction = 2.50000000000 
		} 
		{ 
			radius = 11 
			max_draw_y_offset = -5 
			steering = fixed 
			drive = yes 
			brake_torque = 500 
			dynamic_friction = 4.00000000000 
			handbrake_throttle_friction = 1.50000000000 
			handbrake_locked_friction = 1.50000000000 
		} 
		{ 
			radius = 11 
			max_draw_y_offset = -5 
			steering = fixed 
			drive = yes 
			brake_torque = 500 
			dynamic_friction = 4.00000000000 
			handbrake_throttle_friction = 1.50000000000 
			handbrake_locked_friction = 1.50000000000 
		} 
	] 
} 
ImpalaCarSetup = { 
	control_type = ImpalaCar 
	model = "veh\\veh_chevy_impala\\veh_chevy_impala.mdl" 
	level = Load_NY 
	alternate_level = 0 
	sounds = NY_JunkCar 
	skater_pos = VECTOR(0.00000000000, 0.00000000000, 0.00000000000) 
	suspension_center_of_mass = -20 
	mass = 2943 
	moment_of_inertia = VECTOR(6000000.00000000000, 5000000.00000000000, 6000000.00000000000) 
	body_restitution = 0.30000001192 
	body_friction = 0.20000000298 
	body_wipeout_friction = 0.40000000596 
	body_spring = 1200 
	collision_control = 0.25000000000 
	max_steering_angle = 30 
	constant_rotational_damping = 2000000 
	quadratic_rotational_damping = 0.00010000000 
	in_air_slerp_strength = 5 
	in_air_slerp_time_delay = 1 
	in_air_slerp_velocity_cutoff = 350 
	colliders = [ 
		[ 
			VECTOR(39.50000000000, 26.00000000000, 126.00000000000) 
			VECTOR(-40.50000000000, 26.00000000000, 126.00000000000) 
			VECTOR(39.50000000000, 26.00000000000, -60.00000000000) 
		] 
		[ 
			VECTOR(31.00000000000, 46.00000000000, 52.00000000000) 
			VECTOR(-31.00000000000, 46.00000000000, 52.00000000000) 
			VECTOR(31.00000000000, 42.00000000000, -8.00000000000) 
		] 
	] 
	engine = { 
		drive_torque = 400 
		drag_torque = 800 
		upshift_rpm = 5000 
		differential_ratio = 5 
		reverse_torque_ratio = 1 
		gear_ratios = [ 
			4 
			3 
			1.50000000000 
			0.64999997616 
			0 
		] 
	} 
	all_wheels = { 
		radius = 13 
		moment = 3570 
		spring_rate = 200 
		damping_rate = 28 
		static_friction = 3.00000000000 
		min_static_grip_velocity = 8 
		max_static_grip_velocity = 12 
		min_dynamic_grip_velocity = 30 
		handbrake_torque = 3000 
		brake_torque = 2000 
	} 
	wheels = [ 
		{ 
			max_draw_y_offset = -22.50000000000 
			steering = left 
			drive = yes 
			dynamic_friction = 2.79999995232 
			handbrake_throttle_friction = 3.50000000000 
			handbrake_locked_friction = 4.00000000000 
		} 
		{ 
			max_draw_y_offset = -22.50000000000 
			steering = right 
			drive = yes 
			dynamic_friction = 2.79999995232 
			handbrake_throttle_friction = 3.50000000000 
			handbrake_locked_friction = 4.00000000000 
		} 
		{ 
			max_draw_y_offset = -19.50000000000 
			steering = fixed 
			drive = yes 
			dynamic_friction = 3.50000000000 
			handbrake_throttle_friction = 3.00000000000 
			handbrake_locked_friction = 1.00000000000 
		} 
		{ 
			max_draw_y_offset = -19.50000000000 
			steering = fixed 
			drive = yes 
			dynamic_friction = 3.50000000000 
			handbrake_throttle_friction = 3.00000000000 
			handbrake_locked_friction = 1.00000000000 
		} 
	] 
} 
PoliceCarSetup = { 
	control_type = PoliceCar 
	model = "veh\\fl\\veh_policecar_fl\\veh_policecar_fl.mdl" 
	level = Load_FL 
	alternate_level = 0 
	sounds = FL_PoliceCar 
	skater_pos = VECTOR(0.00000000000, 0.00000000000, 0.00000000000) 
	suspension_center_of_mass = -24 
	mass = 2943 
	moment_of_inertia = VECTOR(6000000.00000000000, 5000000.00000000000, 6000000.00000000000) 
	body_restitution = 0.30000001192 
	body_friction = 0.20000000298 
	body_wipeout_friction = 0.40000000596 
	body_spring = 1200 
	collision_control = 0.25000000000 
	max_steering_angle = 30 
	constant_rotational_damping = 2000000 
	quadratic_rotational_damping = 0.00010000000 
	in_air_slerp_strength = 5 
	in_air_slerp_time_delay = 1 
	in_air_slerp_velocity_cutoff = 350 
	colliders = [ 
		[ 
			VECTOR(33.00000000000, 25.00000000000, 150.00000000000) 
			VECTOR(-33.00000000000, 25.00000000000, 150.00000000000) 
			VECTOR(33.00000000000, 25.00000000000, -65.00000000000) 
		] 
		[ 
			VECTOR(28.00000000000, 55.00000000000, 62.00000000000) 
			VECTOR(-28.00000000000, 55.00000000000, 62.00000000000) 
			VECTOR(28.00000000000, 55.00000000000, -2.00000000000) 
		] 
	] 
	engine = { 
		drive_torque = 400 
		drag_torque = 800 
		upshift_rpm = 5000 
		differential_ratio = 5 
		reverse_torque_ratio = 1 
		gear_ratios = [ 
			4 
			3 
			1.50000000000 
			0.64999997616 
			0 
		] 
	} 
	all_wheels = { 
		radius = 13 
		moment = 3570 
		spring_rate = 200 
		damping_rate = 28 
		static_friction = 4.00000000000 
		min_static_grip_velocity = 8 
		max_static_grip_velocity = 12 
		min_dynamic_grip_velocity = 30 
		handbrake_torque = 3000 
		brake_torque = 2000 
	} 
	wheels = [ 
		{ 
			max_draw_y_offset = -25.50000000000 
			steering = left 
			drive = yes 
			dynamic_friction = 2.79999995232 
			handbrake_throttle_friction = 3.50000000000 
			handbrake_locked_friction = 4.00000000000 
		} 
		{ 
			max_draw_y_offset = -25.50000000000 
			steering = right 
			drive = yes 
			dynamic_friction = 2.79999995232 
			handbrake_throttle_friction = 3.50000000000 
			handbrake_locked_friction = 4.00000000000 
		} 
		{ 
			max_draw_y_offset = -20 
			steering = fixed 
			drive = yes 
			dynamic_friction = 3.50000000000 
			handbrake_throttle_friction = 3.00000000000 
			handbrake_locked_friction = 1.00000000000 
		} 
		{ 
			max_draw_y_offset = -20 
			steering = fixed 
			drive = yes 
			dynamic_friction = 3.50000000000 
			handbrake_throttle_friction = 3.00000000000 
			handbrake_locked_friction = 1.00000000000 
		} 
	] 
} 
ElCaminoCarSetup = { 
	control_type = ElCaminoCar 
	model = "veh\\veh_camino\\veh_camino.mdl" 
	level = Load_HI 
	alternate_level = 0 
	sounds = HI_Car 
	skater_pos = VECTOR(0.00000000000, 0.00000000000, 0.00000000000) 
	suspension_center_of_mass = -22 
	mass = 2943 
	moment_of_inertia = VECTOR(6000000.00000000000, 6000000.00000000000, 6000000.00000000000) 
	body_restitution = 0.30000001192 
	body_friction = 0.20000000298 
	body_wipeout_friction = 0.40000000596 
	body_spring = 1200 
	collision_control = 0.25000000000 
	max_steering_angle = 30 
	constant_rotational_damping = 2000000 
	quadratic_rotational_damping = 0.00010000000 
	in_air_slerp_strength = 5 
	in_air_slerp_time_delay = 1 
	in_air_slerp_velocity_cutoff = 350 
	colliders = [ 
		[ 
			VECTOR(36.00000000000, 27.00000000000, 151.00000000000) 
			VECTOR(-36.00000000000, 27.00000000000, 151.00000000000) 
			VECTOR(36.00000000000, 33.00000000000, -58.00000000000) 
		] 
		[ 
			VECTOR(24.00000000000, 53.00000000000, 68.00000000000) 
			VECTOR(-24.00000000000, 53.00000000000, 68.00000000000) 
			VECTOR(24.00000000000, 53.00000000000, 38.00000000000) 
		] 
	] 
	engine = { 
		drive_torque = 400 
		drag_torque = 800 
		upshift_rpm = 5000 
		differential_ratio = 5 
		reverse_torque_ratio = 1 
		gear_ratios = [ 
			4 
			3 
			1.50000000000 
			0.64999997616 
			0 
		] 
	} 
	all_wheels = { 
		radius = 13 
		moment = 3570 
		spring_rate = 200 
		damping_rate = 28 
		static_friction = 4.00000000000 
		min_static_grip_velocity = 8 
		max_static_grip_velocity = 12 
		min_dynamic_grip_velocity = 30 
		handbrake_torque = 3000 
		brake_torque = 2000 
	} 
	wheels = [ 
		{ 
			max_draw_y_offset = -24.50000000000 
			steering = left 
			drive = yes 
			dynamic_friction = 2.79999995232 
			handbrake_throttle_friction = 3.50000000000 
			handbrake_locked_friction = 4.00000000000 
		} 
		{ 
			max_draw_y_offset = -24.50000000000 
			steering = right 
			drive = yes 
			dynamic_friction = 2.79999995232 
			handbrake_throttle_friction = 3.50000000000 
			handbrake_locked_friction = 4.00000000000 
		} 
		{ 
			max_draw_y_offset = -17 
			steering = fixed 
			drive = yes 
			dynamic_friction = 3.50000000000 
			handbrake_throttle_friction = 3.00000000000 
			handbrake_locked_friction = 1.00000000000 
		} 
		{ 
			max_draw_y_offset = -17 
			steering = fixed 
			drive = yes 
			dynamic_friction = 3.50000000000 
			handbrake_throttle_friction = 3.00000000000 
			handbrake_locked_friction = 1.00000000000 
		} 
	] 
} 
LimoCarSetup = { 
	control_type = LimoCar 
	model = "veh\\veh_limo\\veh_limo.mdl" 
	level = Load_VC 
	alternate_level = 0 
	sounds = VC_Limo 
	skater_pos = VECTOR(0.00000000000, 0.00000000000, 0.00000000000) 
	suspension_center_of_mass = -15 
	mass = 2943 
	moment_of_inertia = VECTOR(6000000.00000000000, 20000000.00000000000, 6000000.00000000000) 
	body_restitution = 0.30000001192 
	body_friction = 0.20000000298 
	body_wipeout_friction = 0.40000000596 
	body_spring = 1200 
	collision_control = 0.25000000000 
	max_steering_angle = 30 
	constant_rotational_damping = 2000000 
	quadratic_rotational_damping = 0.00010000000 
	in_air_slerp_strength = 5 
	in_air_slerp_time_delay = 1 
	in_air_slerp_velocity_cutoff = 350 
	colliders = [ 
		[ 
			VECTOR(39.50000000000, 25.00000000000, 212.00000000000) 
			VECTOR(-39.50000000000, 25.00000000000, 212.00000000000) 
			VECTOR(39.50000000000, 25.00000000000, -85.00000000000) 
		] 
		[ 
			VECTOR(27.00000000000, 64.00000000000, 115.00000000000) 
			VECTOR(-27.00000000000, 64.00000000000, 115.00000000000) 
			VECTOR(27.00000000000, 64.00000000000, -28.00000000000) 
		] 
	] 
	engine = { 
		drive_torque = 400 
		drag_torque = 800 
		upshift_rpm = 5000 
		differential_ratio = 5 
		reverse_torque_ratio = 1 
		gear_ratios = [ 
			4 
			3 
			1.50000000000 
			0.64999997616 
			0 
		] 
	} 
	all_wheels = { 
		radius = 13 
		moment = 3570 
		spring_rate = 200 
		damping_rate = 28 
		static_friction = 2.00000000000 
		min_static_grip_velocity = 8 
		max_static_grip_velocity = 12 
		min_dynamic_grip_velocity = 30 
		handbrake_torque = 3000 
		brake_torque = 2000 
	} 
	wheels = [ 
		{ 
			max_draw_y_offset = -25.70000076294 
			steering = left 
			drive = yes 
			dynamic_friction = 2.79999995232 
			handbrake_throttle_friction = 3.50000000000 
			handbrake_locked_friction = 4.00000000000 
		} 
		{ 
			max_draw_y_offset = -25.70000076294 
			steering = right 
			drive = yes 
			dynamic_friction = 2.79999995232 
			handbrake_throttle_friction = 3.50000000000 
			handbrake_locked_friction = 4.00000000000 
		} 
		{ 
			max_draw_y_offset = -26 
			steering = fixed 
			drive = yes 
			dynamic_friction = 3.50000000000 
			handbrake_throttle_friction = 3.00000000000 
			handbrake_locked_friction = 1.00000000000 
		} 
		{ 
			max_draw_y_offset = -26 
			steering = fixed 
			drive = yes 
			dynamic_friction = 3.50000000000 
			handbrake_throttle_friction = 3.00000000000 
			handbrake_locked_friction = 1.00000000000 
		} 
	] 
} 
MiniBajaCarSetup = { 
	control_type = MiniBajaCar 
	model = "veh\\veh_minibaja\\veh_minibaja.mdl" 
	level = Load_SE 
	alternate_level = Load_Sk5Ed_gameplay 
	sounds = SE_ATV 
	make_skater_visible 
	skater_pos = VECTOR(-0.64999997616, -2.00000000000, 4.07000017166) 
	skater_anim = Ped_Baha_Drive 
	suspension_center_of_mass = -21 
	mass = 2943 
	moment_of_inertia = VECTOR(6000000.00000000000, 5000000.00000000000, 6000000.00000000000) 
	body_restitution = 0.60000002384 
	body_friction = 0.20000000298 
	body_wipeout_friction = 0.69999998808 
	body_spring = 1200 
	collision_control = 0.25000000000 
	max_steering_angle = 25 
	constant_rotational_damping = 2000000 
	quadratic_rotational_damping = 0.00010000000 
	in_air_slerp_strength = 5 
	in_air_slerp_time_delay = 0.50000000000 
	in_air_slerp_velocity_cutoff = 350 
	vert_correction 
	colliders = [ 
		[ 
			VECTOR(37.00000000000, 30.00000000000, 41.00000000000) 
			VECTOR(-37.00000000000, 30.00000000000, 41.00000000000) 
			VECTOR(37.00000000000, 30.00000000000, -36.00000000000) 
		] 
		[ 
			VECTOR(12.00000000000, 64.00000000000, 16.00000000000) 
			VECTOR(-12.00000000000, 64.00000000000, 16.00000000000) 
			VECTOR(12.00000000000, 64.00000000000, -28.00000000000) 
		] 
	] 
	engine = { 
		drive_torque = 550 
		drag_torque = 450 
		upshift_rpm = 5000 
		differential_ratio = 5 
		reverse_torque_ratio = 1 
		gear_ratios = [ 
			9 
			6 
			2.50000000000 
			0.75000000000 
			0 
		] 
	} 
	all_wheels = { 
		radius = 14 
		moment = 3570 
		spring_rate = 200 
		damping_rate = 16 
		static_friction = 4.00000000000 
		min_static_grip_velocity = 8 
		max_static_grip_velocity = 20 
		min_dynamic_grip_velocity = 30 
		handbrake_torque = 3000 
	} 
	wheels = [ 
		{ 
			max_draw_y_offset = -20 
			steering = left 
			drive = yes 
			brake_torque = 2000 
			dynamic_friction = 2.79999995232 
			handbrake_throttle_friction = 3 
			handbrake_locked_friction = 3 
		} 
		{ 
			max_draw_y_offset = -20 
			steering = right 
			drive = yes 
			brake_torque = 2000 
			dynamic_friction = 2.79999995232 
			handbrake_throttle_friction = 3 
			handbrake_locked_friction = 3 
		} 
		{ 
			max_draw_y_offset = -20 
			steering = fixed 
			drive = yes 
			brake_torque = 1000 
			dynamic_friction = 3.50000000000 
			handbrake_throttle_friction = 1.00000000000 
			handbrake_locked_friction = 1.00000000000 
		} 
		{ 
			max_draw_y_offset = -20 
			steering = fixed 
			drive = yes 
			brake_torque = 1000 
			dynamic_friction = 3.50000000000 
			handbrake_throttle_friction = 1.00000000000 
			handbrake_locked_friction = 1.00000000000 
		} 
	] 
} 
LadaCarSetup = { 
	control_type = LadaCar 
	model = "veh\\veh_lada\\veh_lada.mdl" 
	level = Load_RU 
	alternate_level = 0 
	sounds = RU_ForeignCar 
	skater_pos = VECTOR(0.00000000000, 0.00000000000, 0.00000000000) 
	suspension_center_of_mass = -22 
	mass = 2943 
	moment_of_inertia = VECTOR(6000000.00000000000, 5000000.00000000000, 6000000.00000000000) 
	body_restitution = 0.30000001192 
	body_friction = 0.20000000298 
	body_wipeout_friction = 0.40000000596 
	body_spring = 1200 
	collision_control = 0.25000000000 
	max_steering_angle = 30 
	constant_rotational_damping = 2000000 
	quadratic_rotational_damping = 0.00010000000 
	in_air_slerp_strength = 5 
	in_air_slerp_time_delay = 1 
	in_air_slerp_velocity_cutoff = 350 
	colliders = [ 
		[ 
			VECTOR(29.00000000000, 30.00000000000, 118.00000000000) 
			VECTOR(-29.00000000000, 30.00000000000, 118.00000000000) 
			VECTOR(29.00000000000, 30.00000000000, -44.00000000000) 
		] 
		[ 
			VECTOR(24.00000000000, 56.00000000000, 65.00000000000) 
			VECTOR(-24.00000000000, 56.00000000000, 65.00000000000) 
			VECTOR(24.00000000000, 56.00000000000, 0.00000000000) 
		] 
	] 
	engine = { 
		drive_torque = 400 
		drag_torque = 800 
		upshift_rpm = 5000 
		differential_ratio = 5 
		reverse_torque_ratio = 1 
		gear_ratios = [ 
			4 
			3 
			1.50000000000 
			0.64999997616 
			0 
		] 
	} 
	all_wheels = { 
		radius = 11 
		moment = 3570 
		spring_rate = 200 
		damping_rate = 28 
		static_friction = 4.00000000000 
		min_static_grip_velocity = 8 
		max_static_grip_velocity = 12 
		min_dynamic_grip_velocity = 30 
		handbrake_torque = 3000 
		brake_torque = 2000 
	} 
	wheels = [ 
		{ 
			max_draw_y_offset = -21 
			steering = left 
			drive = yes 
			dynamic_friction = 2.79999995232 
			handbrake_throttle_friction = 3.50000000000 
			handbrake_locked_friction = 4.00000000000 
		} 
		{ 
			max_draw_y_offset = -21 
			steering = right 
			drive = yes 
			dynamic_friction = 2.79999995232 
			handbrake_throttle_friction = 3.50000000000 
			handbrake_locked_friction = 4.00000000000 
		} 
		{ 
			max_draw_y_offset = -16 
			steering = fixed 
			drive = yes 
			dynamic_friction = 3.50000000000 
			handbrake_throttle_friction = 3.00000000000 
			handbrake_locked_friction = 1.00000000000 
		} 
		{ 
			max_draw_y_offset = -16 
			steering = fixed 
			drive = yes 
			dynamic_friction = 3.50000000000 
			handbrake_throttle_friction = 3.00000000000 
			handbrake_locked_friction = 1.00000000000 
		} 
	] 
} 
defaultCarSetup = CustomCarSetup 

