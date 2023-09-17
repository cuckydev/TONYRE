
Skater_Default_Stats = 5.00000000000 
STATS_AIR = 0 
STATS_RUN = 1 
STATS_OLLIE = 2 
STATS_SPEED = 3 
STATS_SPIN = 4 
STATS_FLIPSPEED = 5 
STATS_SWITCH = 6 
STATS_RAILBALANCE = 7 
STATS_LIPBALANCE = 8 
STATS_MANUAL = 9 
standard_switch = PAIR(0.89999997616, 1.00000000000) 
no_switch = PAIR(1.00000000000, 1.00000000000) 
LEAN_GRAVITY_DIFF = PAIR(0.00100000005, 1.00000000000) 
LEAN_ACC_DIFF = PAIR(0.75000000000, 1.00000000000) 
skater_physics = { 
	Physics_RunTimer_Duration = { PAIR(3.00000000000, 4.00000000000) STATS_RUN switch = no_switch } 
	Skater_autoturn_speed = 3.00000000000 
	skater_autoturn_cancel_time = 300 
	skater_autoturn_vert_angle = 5 
	Physics_Standing_Air_Friction = 0.00001000000 
	Physics_Crouched_Air_Friction = 0.00000200000 
	Physics_Rolling_Friction = 0.00001000000 
	Skater_Max_Standing_Kick_Speed_Stat = { PAIR(394.00000000000, 496.00000000000) limit = 900 STATS_SPEED switch = PAIR(0.80000001192, 1.00000000000) } 
	Skater_Max_Crouched_Kick_Speed_Stat = { PAIR(532.00000000000, 675.00000000000) limit = 900 STATS_SPEED switch = PAIR(0.80000001192, 1.00000000000) } 
	Physics_Standing_Acceleration_Stat = { PAIR(629.00000000000, 700.00000000000) STATS_SPEED switch = standard_switch } 
	Physics_Crouching_Acceleration_stat = { PAIR(1057.00000000000, 1200.00000000000) STATS_SPEED switch = standard_switch } 
	Skater_Max_Speed_Stat = { PAIR(757.00000000000, 900.00000000000) STATS_SPEED switch = no_switch } 
	Skater_Max_Max_Speed_Stat = { PAIR(957.00000000000, 1100.00000000000) STATS_SPEED switch = no_switch } 
	Skater_default_head_height = 77 
	Physics_Ground_Snap_Up = 13 
	Physics_Air_Snap_Up = 15 
	Physics_Ground_Snap_Down = 8.19999980927 
	Skater_First_Forward_Collision_Height = 8.10000038147 
	Skater_First_Forward_Collision_Length = 10 
	Skater_Min_Distance_To_Wall = 8.00000000000 
	Physics_Ground_Rotation = 1.79999995232 
	Physics_Ground_Sharp_Rotation = 3.59999990463 
	Physics_Air_No_Rotate_Time = 100 
	Physics_Air_Ramp_Rotate_Time = 50 
	spin_count_slop = 60 
	Physics_Air_Gravity = -1350 
	Physics_Ground_Gravity = -1000 
	Physics_Rail_Gravity = -2000 
	Wall_Ride_Gravity = -969 
	Ground_stick_angle = 30 
	Ground_stick_angle_forward = 60 
	Physics_Brake_Acceleration = 900.00000000000 
	Physics_Air_Lean_stat = { PAIR(1.00000000000, 1.00000000000) STATS_SPIN switch = standard_switch } 
	Physics_Air_Rotation_stat = { PAIR(6.84999990463, 7.75000000000) STATS_SPIN switch = standard_switch } 
	Physics_air_tap_turn_speed_stat = { PAIR(6.84999990463, 7.75000000000) STATS_SPIN switch = standard_switch } 
	Physics_Acid_Drop_Pop_Speed = 200 
	Physics_Transfer_Speed_Limit_Override_Drop_Rate = 0.50000000000 
	Physics_Transfer_Speed_Limit_Override_Max = 1.75000000000 
} 
Skater_Flip_Speed_Stat = { PAIR(1.15999996662, 1.29999995232) STATS_FLIPSPEED switch = standard_switch } 
Physics_Jump_Speed_Stat = { PAIR(414.00000000000, 450.00000000000) STATS_OLLIE switch = standard_switch } 
Physics_Jump_Speed_min_Stat = { PAIR(350.00000000000, 350.00000000000) STATS_OLLIE switch = standard_switch } 
Physics_Boneless_Jump_Speed_Stat = { PAIR(489.00000000000, 525.00000000000) STATS_OLLIE switch = standard_switch } 
Physics_Boneless_Jump_Speed_min_Stat = { PAIR(400.00000000000, 400.00000000000) STATS_OLLIE switch = standard_switch } 
Physics_Air_Jump_Speed_Stat = { PAIR(275.00000000000, 275.00000000000) STATS_AIR switch = standard_switch } 
Physics_Air_Jump_Speed_min_Stat = { PAIR(100.00000000000, 100.00000000000) STATS_AIR switch = standard_switch } 
Physics_Boneless_Air_Jump_Speed_Stat = { PAIR(264.00000000000, 325.00000000000) STATS_AIR switch = standard_switch } 
Physics_Boneless_Air_Jump_Speed_min_Stat = { PAIR(200.00000000000, 200.00000000000) STATS_AIR switch = standard_switch } 
Physics_Air_No_Lean_Time = 200 
Physics_Air_Ramp_Lean_Time = 200 
Spine_Max_Width = 800 
Physics_recover_rate_stat = { PAIR(2.00000000000, 2.00000000000) STATS_SPIN switch = standard_switch } 
Physics_Air_hang_Stat = 1.00000000000 
Physics_Vert_hang_Stat = 1.10000002384 
Physics_Acid_Drop_Min_Air_Time = 0.25000000000 
Physics_Acid_Drop_Walking_On_Ground_Search_Distance = 100 
Physics_Acid_Drop_Min_Land_Speed = 500 
Physics_Wallplant_Min_Approach_Angle = 20 
Physics_Disallow_Rewallplant_Duration = 1000 
Physics_Wallplant_Speed_Loss = 225 
Physics_Wallplant_Min_Exit_Speed = 200 
Physics_Wallplant_Vertical_Exit_Speed = 500 
Physics_Wallplant_Disallow_Grind_Duration = 200 
Physics_Ignore_Ceilings_After_Wallplant_Duration = 200 
Physics_Min_Wallplant_Height = 24 
Physics_Wallplant_Distance_From_Wall = 27.60000038147 
Physics_Wallplant_Duration = ( 0.15999999642 * 1000 ) 
Physics_Disallow_Rewallpush_Duration = 800 
Physics_Wallpush_Speed_Loss = 200 
Physics_Wallpush_Min_Exit_Speed = 100 
Physics_Wallpush_Vertical_Exit_Speed = 400 
Physics_Point_Rail_Kick_Upward_Angle = 25 
Physics_Time_Before_Free_Revert = 20 
Lip_side_hop_speed = 10 
Lip_side_jump_speed = 200 
Lip_along_jump_speed = 100 
Lip_held_jump_out_time = 300 
Lip_held_jump_along_time = 300 
skater_upright_sideways_speed = -60.00000000000 
physics_break_air_speed_scale = 0.75000000000 
physics_break_air_up_scale = 0.75000000000 
Skater_Break_Vert_forward_tilt = 45 
Skater_Vert_Allow_break_Time = 200 
Skater_vert_push_time = 130 
Skater_vert_active_up_time = 250 
Rail_Speed_Boost = 150 
Point_Rail_Speed_Boost = 100 
Skater_Drift_Upright_Speed = 0.30000001192 
Physics_Vert_Push_Out = 3 
Physics_Heavy_Air_Friction = 0.00010000000 
Skater_Flip_Speed = 1.00000000000 
Skater_Late_Jump_Slop = 333 
Skater_max_tense_time = 200 
Skater_Cam_Horiz_FOV = 72.00000000000 
Skater_Cam_Behind = 14 
Skater_Cam_Above = 4.00000000000 
Skater_Cam_Tilt = 0.18000000715 
Skater_Cam_Slerp = 0.07999999821 
Skater_Cam_Vert_Air_Slerp = 0.02500000037 
Hang_Run_Timer_Speed_Adjustment = 0.40000000596 
Skater_Camera_Undefined = { horiz_fov = 0.00000000000 , behind = 0.00000000000 , above = 0.00000000000 , tilt = 0.00000000000 , slerp = 0.00000000000 , vert_air_slerp = 0.00000000000 , vert_air_landed_slerp = 0.00000000000 , zoom_lerp = 0.06250000000 , big_air_trick_zoom = 0.00000000000 , grind_zoom = 0.00000000000 , origin_offset = 0.00000000000 , name = "undefined" } 
Skater_Camera_Standard_Medium = { horiz_fov = 72.00000000000 , behind = 12.00000000000 , above = 4.30000019073 , tilt = 0.18000000715 , slerp = 0.03999999911 , vert_air_slerp = 0.03999999911 , vert_air_landed_slerp = 0.37500000000 , lerp_xz = 0.25000000000 , lerp_y = 0.75000000000 , vert_air_lerp_xz = 1.00000000000 , vert_air_lerp_y = 1.00000000000 , zoom_lerp = 0.06250000000 , big_air_trick_zoom = 0.69999998808 , lip_trick_zoom = 1.00000000000 , lip_trick_tilt = -0.80000001192 , lip_trick_above = 0.40000000596 , grind_zoom = 1.00000000000 , origin_offset = 0.20000000298 , name = "standard" } 
Skater_Camera_Standard_Far = { horiz_fov = 72.00000000000 , behind = 14.00000000000 , above = 6.00000000000 , tilt = 0.30000001192 , slerp = 0.07999999821 , vert_air_slerp = 0.02500000037 , vert_air_landed_slerp = 0.37500000000 , lerp_xz = 0.25000000000 , lerp_y = 0.75000000000 , vert_air_lerp_xz = 1.00000000000 , vert_air_lerp_y = 1.00000000000 , zoom_lerp = 0.06250000000 , big_air_trick_zoom = 0.60000002384 , lip_trick_zoom = 1.00000000000 , lip_trick_tilt = -0.80000001192 , lip_trick_above = 0.40000000596 , grind_zoom = 1.00000000000 , origin_offset = 0.20000000298 , name = "far" } 
Skater_Camera_Standard_Near = { horiz_fov = 72.00000000000 , behind = 7.00000000000 , above = 2.00000000000 , tilt = 0.18000000715 , slerp = 0.07999999821 , vert_air_slerp = 0.02500000037 , vert_air_landed_slerp = 0.37500000000 , lerp_xz = 0.25000000000 , lerp_y = 0.75000000000 , vert_air_lerp_xz = 1.00000000000 , vert_air_lerp_y = 1.00000000000 , zoom_lerp = 0.06250000000 , big_air_trick_zoom = 0.89999997616 , lip_trick_zoom = 1.60000002384 , lip_trick_tilt = -0.80000001192 , lip_trick_above = 0.40000000596 , grind_zoom = 1.00000000000 , origin_offset = 0.20000000298 , name = "near" } 
Skater_Camera_Standard_Medium_LTG = { horiz_fov = 72.00000000000 , behind = 14.00000000000 , above = 2.00000000000 , tilt = 0.15000000596 , slerp = 0.07999999821 , vert_air_slerp = 0.02500000037 , vert_air_landed_slerp = 0.37500000000 , lerp_xz = 0.25000000000 , lerp_y = 0.75000000000 , vert_air_lerp_xz = 1.00000000000 , vert_air_lerp_y = 1.00000000000 , zoom_lerp = 0.06250000000 , big_air_trick_zoom = 0.60000002384 , lip_trick_zoom = 1.00000000000 , lip_trick_tilt = -0.80000001192 , lip_trick_above = 0.40000000596 , grind_zoom = 1.00000000000 , origin_offset = 0.20000000298 , name = "standard ltg" } 
Skater_Camera_2P_Vert_Medium = { horiz_fov = 72.00000000000 , behind = 14.00000000000 , above = 4.30000019073 , tilt = 0.18000000715 , slerp = 0.03999999911 , vert_air_slerp = 0.03999999911 , vert_air_landed_slerp = 0.37500000000 , lerp_xz = 0.25000000000 , lerp_y = 0.75000000000 , vert_air_lerp_xz = 1.00000000000 , vert_air_lerp_y = 1.00000000000 , zoom_lerp = 0.06250000000 , big_air_trick_zoom = 0.69999998808 , lip_trick_zoom = 1.00000000000 , lip_trick_tilt = -0.80000001192 , lip_trick_above = 0.40000000596 , grind_zoom = 1.00000000000 , origin_offset = 0.20000000298 , name = "standard" } 
Skater_Camera_2P_Vert_Far = { horiz_fov = 72.00000000000 , behind = 22.00000000000 , above = 6.00000000000 , tilt = 0.30000001192 , slerp = 0.07999999821 , vert_air_slerp = 0.02500000037 , vert_air_landed_slerp = 0.37500000000 , lerp_xz = 0.25000000000 , lerp_y = 0.75000000000 , vert_air_lerp_xz = 1.00000000000 , vert_air_lerp_y = 1.00000000000 , zoom_lerp = 0.06250000000 , big_air_trick_zoom = 0.60000002384 , lip_trick_zoom = 1.00000000000 , lip_trick_tilt = -0.80000001192 , lip_trick_above = 0.40000000596 , grind_zoom = 1.00000000000 , origin_offset = 0.20000000298 , name = "far" } 
Skater_Camera_2P_Vert_Near = { horiz_fov = 72.00000000000 , behind = 6 , above = 2.00000000000 , tilt = 0.18000000715 , slerp = 0.07999999821 , vert_air_slerp = 0.02500000037 , vert_air_landed_slerp = 0.37500000000 , lerp_xz = 0.25000000000 , lerp_y = 0.75000000000 , vert_air_lerp_xz = 1.00000000000 , vert_air_lerp_y = 1.00000000000 , zoom_lerp = 0.06250000000 , big_air_trick_zoom = 0.89999997616 , lip_trick_zoom = 1.60000002384 , lip_trick_tilt = -0.80000001192 , lip_trick_above = 0.40000000596 , grind_zoom = 1.00000000000 , origin_offset = 0.20000000298 , name = "near" } 
Skater_Camera_2P_Vert_Medium_LTG = { horiz_fov = 72.00000000000 , behind = 14.00000000000 , above = 3.00000000000 , tilt = 0.15000000596 , slerp = 0.07999999821 , vert_air_slerp = 0.02500000037 , vert_air_landed_slerp = 0.37500000000 , lerp_xz = 0.25000000000 , lerp_y = 0.75000000000 , vert_air_lerp_xz = 1.00000000000 , vert_air_lerp_y = 1.00000000000 , zoom_lerp = 0.06250000000 , big_air_trick_zoom = 0.60000002384 , lip_trick_zoom = 1.00000000000 , lip_trick_tilt = -0.80000001192 , lip_trick_above = 0.40000000596 , grind_zoom = 1.00000000000 , origin_offset = 0.20000000298 , name = "standard ltg" } 
Skater_Camera_2P_Horiz_Medium = { horiz_fov = 72.00000000000 , behind = 15.00000000000 , above = 3.50000000000 , tilt = 0.20000000298 , slerp = 0.07999999821 , vert_air_slerp = 0.02500000037 , vert_air_landed_slerp = 0.37500000000 , lerp_xz = 0.25000000000 , lerp_y = 0.75000000000 , vert_air_lerp_xz = 1.00000000000 , vert_air_lerp_y = 1.00000000000 , zoom_lerp = 0.06250000000 , big_air_trick_zoom = 0.60000002384 , lip_trick_zoom = 1.00000000000 , lip_trick_tilt = -0.80000001192 , lip_trick_above = 0.40000000596 , grind_zoom = 1.00000000000 , origin_offset = 0.20000000298 , name = "far" } 
Skater_Camera_2P_Horiz_Far = { horiz_fov = 72.00000000000 , behind = 25.00000000000 , above = 3.50000000000 , tilt = 0.30000001192 , slerp = 0.03999999911 , vert_air_slerp = 0.03999999911 , vert_air_landed_slerp = 0.37500000000 , lerp_xz = 0.25000000000 , lerp_y = 0.75000000000 , vert_air_lerp_xz = 1.00000000000 , vert_air_lerp_y = 1.00000000000 , zoom_lerp = 0.06250000000 , big_air_trick_zoom = 0.69999998808 , lip_trick_zoom = 1.00000000000 , lip_trick_tilt = -0.80000001192 , lip_trick_above = 0.40000000596 , grind_zoom = 1.00000000000 , origin_offset = 0.20000000298 , name = "standard" } 
Skater_Camera_2P_Horiz_Medium_LTG = { horiz_fov = 72.00000000000 , behind = 15.00000000000 , above = 3.00000000000 , tilt = 0.15000000596 , slerp = 0.07999999821 , vert_air_slerp = 0.02500000037 , vert_air_landed_slerp = 0.37500000000 , lerp_xz = 0.25000000000 , lerp_y = 0.75000000000 , vert_air_lerp_xz = 1.00000000000 , vert_air_lerp_y = 1.00000000000 , zoom_lerp = 0.06250000000 , big_air_trick_zoom = 0.60000002384 , lip_trick_zoom = 1.00000000000 , lip_trick_tilt = -0.80000001192 , lip_trick_above = 0.40000000596 , grind_zoom = 1.00000000000 , origin_offset = 0.20000000298 , name = "standard ltg" } 
Skater_Camera_2P_Horiz_Near = { horiz_fov = 72.00000000000 , behind = 8.00000000000 , above = 3.20000004768 , tilt = 0.18000000715 , slerp = 0.07999999821 , vert_air_slerp = 0.02500000037 , vert_air_landed_slerp = 0.37500000000 , lerp_xz = 0.25000000000 , lerp_y = 0.75000000000 , vert_air_lerp_xz = 1.00000000000 , vert_air_lerp_y = 1.00000000000 , zoom_lerp = 0.06250000000 , big_air_trick_zoom = 1.00000000000 , lip_trick_zoom = 1.60000002384 , lip_trick_tilt = -0.80000001192 , lip_trick_above = 0.40000000596 , grind_zoom = 1.00000000000 , origin_offset = 0.20000000298 , name = "near" } 
Skater_Camera_Array = [ Skater_Camera_Undefined , 
	Skater_Camera_Standard_Near , 
	Skater_Camera_Standard_Medium , 
	Skater_Camera_Standard_Far , 
	Skater_Camera_Standard_Medium_LTG , 
] 
Skater_Camera_2P_Vert_Array = [ Skater_Camera_Undefined , 
	Skater_Camera_2P_Vert_Near , 
	Skater_Camera_2P_Vert_Medium , 
	Skater_Camera_2P_Vert_Far , 
	Skater_Camera_2P_Vert_Medium_LTG , 
] 
Skater_Camera_2P_Horiz_Array = [ Skater_Camera_Undefined , 
	Skater_Camera_2P_Horiz_Near , 
	Skater_Camera_2P_Horiz_Medium , 
	Skater_Camera_2P_Horiz_Far , 
	Skater_Camera_2P_Horiz_Medium_LTG , 
] 
Skater_side_collide_height = 16 
Skater_side_collide_length = 15 
Skater_air_extra_side_col = 12 
Normal_Lerp_Speed = 0.10000000149 
Normal_Lerp_Velocity_Scale = 250.00000000000 
Rail_Max_Snap = 40.00000000000 
Climb_Max_Snap = 90.00000000000 
Drop_To_Climb_Max_Snap = 36.00000000000 
Rail_jump_rerail_time = 300 
Rail_minimum_rerail_time = 500 
Rail_walk_rerail_time = 1000 
Rail_Corner_Leave_Angle = 50 
Rail_Jump_Angle = 15 
Rail_Tolerance = 0.69999998808 
Rail_Bad_Ledge_Side_Dist = 5 
Rail_Bad_Ledge_Drop_Down_Dist = 3 
Wall_Bounce_Angle_Multiplier = 1.10000002384 
Wall_Bounce_Dont_Slow_Angle = 30 
Wall_Bounce_Dont_Flail_Speed = 100 
Wall_Non_Skatable_Angle = 25 
Wall_Ride_Min_Speed = 75 
Wall_Ride_Max_Incident_Angle = 60 
Wall_Ride_Max_Tilt = 68.50000000000 
Wall_Ride_Upside_Down_Angle = 53 
Wall_Ride_Triangle_Window = 0.33300000429 
Wall_Ride_Delay = 0.66600000858 
Wall_Ride_Down_Collision_Check_Length = -10 
Wall_Ride_Turn_Speed = 0.00400000019 
Wall_Ride_Jump_Out_Speed = 40 
Wall_Ride_Jump_Up_Speed = 80 
Skater_max_sloped_turn_speed = 300.00000000000 
Skater_max_sloped_turn_cosine = 0.50000000000 
Skater_Slow_Turn_on_slopes = 3.00000000000 
BalanceIgnoreButtonPeriod = 0 
BalanceSafeButtonPeriod = 1000 
ManualParams = 
{ 
	Cheese = { PAIR(700.00000000000, 700.00000000000) STATS_MANUAL switch = standard_switch } 
	CheeseFrames = { PAIR(100.00000000000, 100.00000000000) STATS_MANUAL switch = standard_switch } 
	Lean_Gravity_Stat = { PAIR(0.01999999955, 0.01999999955) diff = LEAN_GRAVITY_DIFF STATS_MANUAL switch = standard_switch } 
	Instable_Rate = { PAIR(0.09899999946, 0.07000000030) STATS_MANUAL switch = standard_switch diff = PAIR(0.50000000000, 2.00000000000) } 
	Instable_Base = { PAIR(1.00000000000, 1.00000000000) STATS_MANUAL switch = standard_switch } 
	Lean_Min_Speed = { PAIR(5.00000000000, 5.00000000000) STATS_MANUAL switch = standard_switch } 
	Lean_Rnd_Speed = { PAIR(20.00000000000, 20.00000000000) STATS_MANUAL switch = standard_switch } 
	Repeat_Min = { PAIR(1.00000000000, 1.00000000000) STATS_MANUAL switch = standard_switch } 
	Repeat_Multiplier = { PAIR(0.25000000000, 0.25000000000) STATS_MANUAL switch = standard_switch } 
	Lean_Repeat_Multiplier = { PAIR(0.80000001192, 0.80000001192) STATS_MANUAL switch = standard_switch } 
	Lean_Acc = { PAIR(10.00000000000, 10.00000000000) diff = LEAN_ACC_DIFF STATS_MANUAL switch = standard_switch } 
	Lean_Bail_Angle = { PAIR(4000.00000000000, 4000.00000000000) STATS_MANUAL switch = standard_switch } 
} 
SkitchParams = 
{ 
	Cheese = { PAIR(700.00000000000, 700.00000000000) } 
	CheeseFrames = { PAIR(1.00000000000, 1.00000000000) } 
	Lean_Gravity_Stat = { PAIR(0.00999999978, 0.00999999978) } 
	Instable_Rate = { PAIR(0.03999999911, 0.03999999911) } 
	Instable_Base = { PAIR(0.50000000000, 0.50000000000) } 
	Lean_Min_Speed = { PAIR(5.00000000000, 5.00000000000) } 
	Lean_Rnd_Speed = { PAIR(10.00000000000, 10.00000000000) } 
	Repeat_Min = { PAIR(1.00000000000, 1.00000000000) } 
	Repeat_Multiplier = { PAIR(0.25000000000, 0.25000000000) } 
	Lean_Repeat_Multiplier = { PAIR(0.80000001192, 0.80000001192) } 
	Lean_Acc = { PAIR(8.00000000000, 8.00000000000) } 
	Lean_Bail_Angle = { PAIR(4000.00000000000, 4000.00000000000) } 
} 
GrindParams = 
{ 
	Cheese = { PAIR(2500.00000000000, 2500.00000000000) STATS_RAILBALANCE switch = standard_switch } 
	CheeseFrames = { PAIR(30.00000000000, 30.00000000000) STATS_RAILBALANCE switch = standard_switch } 
	Lean_Gravity_Stat = { PAIR(0.01999999955, 0.01999999955) diff = LEAN_GRAVITY_DIFF STATS_RAILBALANCE switch = standard_switch } 
	Instable_Rate = { PAIR(0.10400000215, 0.09000000358) STATS_RAILBALANCE switch = standard_switch } 
	Instable_Base = { PAIR(1.00000000000, 1.00000000000) STATS_RAILBALANCE switch = standard_switch } 
	Lean_Min_Speed = { PAIR(5.00000000000, 5.00000000000) STATS_RAILBALANCE switch = standard_switch } 
	Lean_Rnd_Speed = { PAIR(7.07000017166, 6.00000000000) limit = 6 STATS_RAILBALANCE switch = standard_switch } 
	Repeat_Min = { PAIR(1.00000000000, 1.00000000000) STATS_RAILBALANCE switch = standard_switch } 
	Repeat_Multiplier = { PAIR(0.31000000238, 0.10000000149) STATS_RAILBALANCE switch = standard_switch } 
	Lean_Repeat_Multiplier = { PAIR(0.60699999332, 0.50000000000) STATS_RAILBALANCE switch = standard_switch } 
	Lean_Acc = { PAIR(10.00000000000, 10.00000000000) diff = LEAN_ACC_DIFF STATS_RAILBALANCE switch = standard_switch } 
	Lean_Bail_Angle = { PAIR(4000.00000000000, 4000.00000000000) STATS_RAILBALANCE switch = standard_switch } 
	Same_Grind_Add_Time = { PAIR(2.00000000000, 2.00000000000) STATS_RAILBALANCE switch = standard_switch } 
	New_Grind_Sub_Time = { PAIR(-0.28600001335, 0.00000000000) STATS_RAILBALANCE switch = standard_switch } 
} 
LipParams = 
{ 
	Cheese = { PAIR(3000.00000000000, 1000.00000000000) STATS_LIPBALANCE switch = standard_switch } 
	CheeseFrames = { PAIR(180.00000000000, 180.00000000000) STATS_LIPBALANCE switch = standard_switch } 
	Lean_Gravity_Stat = { PAIR(0.01999999955, 0.01999999955) diff = LEAN_GRAVITY_DIFF STATS_LIPBALANCE switch = standard_switch } 
	Instable_Rate = { PAIR(0.50000000000, 0.20000000298) STATS_LIPBALANCE switch = standard_switch } 
	Instable_Base = { PAIR(1.00000000000, 1.00000000000) STATS_LIPBALANCE switch = standard_switch } 
	Lean_Min_Speed = { PAIR(10.00000000000, 10.00000000000) STATS_LIPBALANCE switch = standard_switch } 
	Lean_Rnd_Speed = { PAIR(20.00000000000, 20.00000000000) STATS_LIPBALANCE switch = standard_switch } 
	Repeat_Min = { PAIR(1.00000000000, 1.00000000000) STATS_LIPBALANCE switch = standard_switch } 
	Repeat_Multiplier = { PAIR(1.00000000000, 1.00000000000) STATS_LIPBALANCE switch = standard_switch } 
	Lean_Repeat_Multiplier = { PAIR(1.00000000000, 1.00000000000) STATS_LIPBALANCE switch = standard_switch } 
	Lean_Acc = { PAIR(10.00000000000, 10.00000000000) diff = LEAN_ACC_DIFF STATS_LIPBALANCE switch = standard_switch } 
	Lean_Bail_Angle = { PAIR(4000.00000000000, 4000.00000000000) STATS_LIPBALANCE switch = standard_switch } 
} 
DefaultWobbleParams = 
{ 
	WobbleAmpA = { PAIR(0.05000000075, 0.05000000075) STATS_MANUAL } 
	WobbleAmpB = { PAIR(0.03999999911, 0.03999999911) STATS_MANUAL } 
	WobbleK1 = { PAIR(0.00219999999, 0.00219999999) STATS_MANUAL } 
	WobbleK2 = { PAIR(0.00170000002, 0.00170000002) STATS_MANUAL } 
	SpazFactor = { PAIR(1.00000000000, 1.00000000000) STATS_MANUAL } 
} 
BashPeriod = 400 
BashSpeedupFactor = 0.20000000298 
BashMaxPercentSpeedup = 100 
SkateInAble_HorizOffset = 30 
SkateInAble_DownOffset = 7 
SkateInAble_LipHorizOffset = 24 
SkateInAble_LipDownOffset = 7 
SkateInAble_LipExtraCheckHorizOffset = 13 
SkateInAble_LipExtraCheckDownOffset = 2400 
LipAllowAngle = 15 
LipAllowAngle_Override = 60 
LipPlayerHorizontalAngle = 47 
LipRampVertAngle = 68.50000000000 
CarPlant_Forward_boost = 400 
CarPlant_Upward_boost = 100 
min_car_height_diff = 60 
min_car_height_downwards = 30 
NewSpecial = 1 
Skate_min_wall_lean_push_speed = 1000 
Skate_wall_lean_push_time = 0.40000000596 
Skate_wall_lean_push_length = 35 
Skate_wall_lean_push_height = 30 
Skitch_Max_Distance = 120 
Skitch_Offset = 27 
skitch_suck_speed = 200 
skitch_speed_match = 1.00000000000 
skitch_hold_time = 200 
SnowBoard_Friction = 0.30000001192 
Snowboard_turn_multiplier = 2.00000000000 
cess_turn_min_speed = 40 
cess_turn_cap_speed = 500 
cess_turn_multiplier = 1.50000000000 
cess_Friction = 0.05999999866 
Skater_cess_Flip_Speed = 10000.00000000000 
slomo_speed = 0.50000000000 
Matrix_speed = 0.15000000596 
Sim_speed = 1.25000000000 
Moon_gravity = 0.50000000000 
rubber_acc = 0.00100000005 
rubber_friction = 0.03999999911 
rubber_limit = 1000 
InternetClientCollCoefficient = 180.00000000000 
InternetServerCollCoefficient = 120.00000000000 
InternetClientCollRadius = 120.00000000000 
InternetServerCollRadius = 94.00000000000 
LanClientCollCoefficient = 100.00000000000 
LanServerCollCoefficient = 55.00000000000 
LanClientCollRadius = 70.00000000000 
LanServerCollRadius = 70.00000000000 
ClientCollCoefficient = 20.00000000000 
ServerCollCoefficient = 20.00000000000 
ClientCollRadius = 70.00000000000 
ServerCollRadius = 70.00000000000 
DrivingRadiusBoostFactor = 0.10000000149 
DrivingCoefficientBoostFactor = 0.10000000149 
ped_push_dist = 24 
ped_push_skater_speed = 400 
walk_camera_parameters = { 
	matrix_slerp_rate = 0.01999999955 
	lookaround_slerp_rate = 0.03999999911 
	run_slerp_factor = 1.75000000000 
	min_slerp_speed = 130 
	full_slerp_speed = 450 
	dpad_min_slerp_speed = 50 
	dpad_full_slerp_speed = 150 
	flush_slerp_factor = 12 
	lock_angle = 135 
	facing_control = 1.70000004768 
	control_slerp_factor = 1.29999995232 
} 
walk_parameters = { 
	walk_speed = 150 
	run_speed = 450 
	combo_run_speed = 575 
	run_adjust_rate = 1 
	decel_factor = 4.50000000000 
	low_speed_decel_factor = 13.50000000000 
	run_accel_rate = 1500 
	walk_accel_rate = 350 
	walk_point = 0.85000002384 
	stop_skidding_speed = 50 
	pegged_duration_for_skid = 0.20000000298 
	rotate_upright_duration = 0.30000001192 
	initial_vert_vel_boost = 80 
	lerp_upright_rate = 6 
	dpad_control_damping_factor = 1.29999995232 
	jump_velocity = 600 
	min_jump_factor = 0.89999997616 
	gravity = 1750 
	hold_time_for_max_jump = 300 
	hang_jump_factor = 0.85000002384 
	jump_horiz_speed = 250 
	jump_obstruction_check_height = 102 
	jump_obstruction_check_back = 24 
	jump_obstruction_extra_control_suppression_delay = 0 
	sticky_land_threshold_speed = 200 
	rotate_in_place_rate = 1200 
	max_rotate_in_place_speed = 125 
	max_rotate_in_place_angle = 20 
	walk_rotate_factor = 0.50000000000 
	max_pop_speed = 100 
	worse_turn_factor = 10 
	worse_worse_turn_factor = 1 
	dpad_worse_turn_factor = 5 
	dpad_worse_worse_turn_factor = 1 
	best_turn_factor = 25 
	jump_adjust_speed = 200 
	jump_accel_factor = 12 
	snap_up_height = 24 
	snap_down_height = 24 
	max_unnoticed_ground_snap = 4 
	feeler_length = 18 
	feeler_height = 23 
	push_feeler_length = 15 
	push_strength = 30 
	curb_float_lerp_up_rate = 54 
	curb_float_lerp_down_rate = 18 
	curb_float_feeler_length = 24 
	min_curb_height_adjust_vel = 50 
	walker_height = 70 
	min_skid_speed = 175 
	skid_accel = 1400 
	max_reverse_angle = 45 
	wall_turn_factor = 5 
	wall_turn_speed_threshold = 20 
	max_wall_turn_speed_threshold = 400 
	forward_tolerance = 15 
	stand_pos_search_depth = 18 
	hang_move_speed = 110 
	hang_move_lerp_rate = 6 
	hang_move_cutoff = 20 
	hang_vert_control_tolerance = 45 
	hang_control_debounce_time = 0.50000000000 
	hang_hop_max_rail_angle = 45 
	hang_max_rail_ascent = 30 
	ledge_top_feeler_up = 6 
	ledge_top_feeler_down = 6 
	ledge_front_feeler_forward = 12 
	ledge_front_feeler_back = 12 
	hang_obstruction_feeler_side = 6 
	hang_obstruction_feeler_up = 6 
	pull_up_obstruction_height = 12 
	rehang_delay = ( 0.30000001192 * 1000 ) 
	hang_init_anim_feeler_height = 36 
	hang_init_anim_feeler_length = 20 
	hang_move_collision_up = 48 
	hang_move_collision_back = 8 
	hang_move_collision_side_length = 18 
	hang_move_collision_side_height = 48 
	hang_critical_point_vert_offset = 6 
	hang_critical_point_horiz_offset = -14 
	drop_to_hang_speed_factor = 0.80000001192 
	hop_obstruction_feeler_up = 24 
	barrier_jump_highest_barrier = 72 
	barrier_jump_delay = ( 0 * 1000 ) 
	barrier_jump_min_clearance = 3 
	barrier_jump_max_angle = 30 
	max_horiz_snap_distance = 24 
	button_horiz_snap_distance = 48 
	max_vert_snap_distance = 24 
	max_onto_ladder_angle = 60 
	ladder_move_speed = 125 
	ladder_control_tolerance = 45 
	ladder_climb_offset = 4 
	acid_drop_jump_velocity = 400 
	vert_wall_jump_speed = 600 
	horiz_wall_jump_speed = 0 
	max_slow_walk_speed = 120 
	max_fast_walk_speed = 250 
	max_slow_run_speed = 500 
	min_anim_run_speed = 50 
	hang_vert_origin_offset = 91 
	hang_horiz_origin_offset = 1.50000000000 
	pull_up_offset_forward = 10.83500003815 
	pull_up_offset_up = 91 
	drop_to_hang_rotate_factor = 0.50000000000 
	hang_anim_wait_speed = 1.60000002384 
	ladder_top_offset_forward = 6.00362014771 
	ladder_top_offset_up = 59.59719848633 
	ladder_bottom_offset_forward = 23.98740005493 
	ladder_bottom_offset_up = 13.03870010376 
	ladder_anim_wait_speed = 1.50000000000 
	hang_move_animation_speed = 46.20000076294 
	display_offset_restore_rate = 10 
	max_cas_scaling = 0.20000000298 
} 
robot_rail_nudge = 400.00000000000 
robot_rail_add_time = 1.00000000000 
robot_kick_in_count = 10 

