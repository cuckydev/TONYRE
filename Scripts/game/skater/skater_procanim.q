
procedural_skater_bones = [ 
	left_top_trouser_cloth_zz 
	left_low_trouser_cloth_zz 
	right_top_trouser_cloth_zz 
	right_low_trouser_cloth_zz 
	left_top_sleeve_cloth_zz 
	left_low_sleeve_cloth_zz 
	right_top_sleeve_cloth_zz 
	right_low_sleeve_cloth_zz 
	mullet_cloth_zz 
	breast_cloth_zz 
	hood_cloth_zz 
	shirt_tail_cloth_zz 
] 
trans_max_x = 0.00000000000 
trans_max_y = 0.00000000000 
trans_max_z = 6.50000000000 
trans_min_x = 0.00000000000 
trans_min_y = 0.00000000000 
trans_min_z = 0.00000000000 
rot_max_x = 0.00000000000 
rot_max_y = 0.00000000000 
rot_max_z = 128.00000000000 
rot_min_x = 0.00000000000 
rot_min_y = 0.00000000000 
rot_min_z = -128.00000000000 
left_low_trouser_params = { 
	bone = left_low_trouser_cloth_zz 
	speed = 10 z_min = 0 z_max = 5.50000000000 
} 
right_low_trouser_params = { 
	bone = right_low_trouser_cloth_zz 
	speed = 10 z_min = 0 z_max = 5.50000000000 
} 
left_top_trouser_params = { 
	bone = left_top_trouser_cloth_zz 
	speed = 10 z_min = -1 z_max = 3 
} 
right_top_trouser_params = { 
	bone = right_low_trouser_cloth_zz 
	speed = 10 z_min = -1 z_max = 3 
} 
left_top_sleeve_params = { 
	bone = left_top_sleeve_cloth_zz 
	speed = 10 x_min = -2 x_max = 1 
} 
right_top_sleeve_params = { 
	bone = right_top_sleeve_cloth_zz 
	speed = 10 x_min = -2 x_max = 1 
} 
left_low_sleeve_params = { 
	bone = left_low_sleeve_cloth_zz 
	speed = 10 x_min = -2 x_max = 0.34999999404 
} 
right_low_sleeve_params = { 
	bone = right_low_sleeve_cloth_zz 
	speed = 10 x_min = -2 x_max = 0.34999999404 
} 
hood_cloth_params = { 
	bone = hood_cloth_zz 
	rot_speed = 415 yrot_min = -25 yrot_max = 25 xrot_min = 0 xrot_max = 55 
} 
mullet_cloth_params = { 
	bone = mullet_cloth_zz 
	speed = 10 z_min = -0.75000000000 z_max = 0.75000000000 
	speed = 10 yrot_min = -25 yrot_max = 25 zrot_min = -10 zrot_max = 10 
} 
SCRIPT SpawnClothingLandScript 
	ReplayRecordSimpleScriptCall scriptname = SpawnClothingLandScript skaterscript 
	Obj_SpawnScript ClothingLand 
ENDSCRIPT

SCRIPT SpawnClothingLandScriptHalfMax 
	ReplayRecordSimpleScriptCall scriptname = SpawnClothingLandScriptHalfMax skaterscript 
	Obj_SpawnScript ClothingLand params = { Boobscale = 0.50000000000 } 
ENDSCRIPT

SCRIPT ClothingLand 
	SetBoneTransActive bone = breast_cloth_zz 1 
	ClothingLandBounce max = 5 breast = 3 Boobscale = <Boobscale> 
	wait 0.26660001278 seconds 
	ClothingLandBounce max = 2.50000000000 breast = 1.50000000000 speed = 171 Boobscale = <Boobscale> 
	wait 0.20000000298 seconds 
	ClothingLandBounce max = 1 breast = 0.75000000000 speed = 256 Boobscale = <Boobscale> 
	wait 0.13330000639 seconds 
	SetBoneTransActive bone = breast_cloth_zz 0 
ENDSCRIPT

SCRIPT ClothingLandBounce speed = 128 max = 10 
	GetAirtime 
	Airtime = ( <Airtime> * 0.50000000000 ) 
	IF ( <Airtime> > 2 ) 
		Airtime = 2 
	ENDIF 
	IF GotParam Boobscale 
		breast = ( <breast> * <Boobscale> ) 
	ELSE 
		breast = ( <breast> * ( <Airtime> + 0.25000000000 ) ) 
	ENDIF 
	IF ( <breast> > 3 ) 
		breast = 3 
	ENDIF 
	SetBoneTransSpeed x = <speed> y = <speed> z = <speed> bone = breast_cloth_zz 
	SetBoneTransMin x = ( -1 * <breast> / 3 ) y = ( -1 * <breast> / 3 ) z = ( -1.50000000000 * <breast> ) bone = breast_cloth_zz 
	SetBoneTransMax x = ( <breast> / 3 ) y = ( 0.50000000000 * <breast> / 3 ) z = <breast> bone = breast_cloth_zz 
ENDSCRIPT

SCRIPT SetBoneActive 
	SetBoneTransActive bone = <bone> 1 
	SetBoneRotActive bone = <bone> 1 
ENDSCRIPT

SCRIPT SetClothesInactive 
	SetBoneTransActive bone = left_low_trouser_cloth_zz 0 
	SetBoneTransActive bone = right_low_trouser_cloth_zz 0 
	SetBoneTransActive bone = right_low_sleeve_cloth_zz 0 
	SetBoneTransActive bone = left_low_sleeve_cloth_zz 0 
	SetBoneTransActive bone = left_top_sleeve_cloth_zz 0 
	SetBoneTransActive bone = right_top_sleeve_cloth_zz 0 
ENDSCRIPT

SCRIPT SetClothesActive 
	SetBoneTransActive bone = left_low_trouser_cloth_zz 1 
	SetBoneTransActive bone = right_low_trouser_cloth_zz 1 
	SetBoneTransActive bone = right_low_sleeve_cloth_zz 1 
	SetBoneTransActive bone = left_low_sleeve_cloth_zz 1 
	SetBoneTransActive bone = left_top_sleeve_cloth_zz 1 
	SetBoneTransActive bone = right_top_sleeve_cloth_zz 1 
ENDSCRIPT

SCRIPT WindyShirt_Old 
	SetClothesActive ShirtOnly 
	SetBoneTransMin x = 0.00000000000 y = 0.00000000000 z = 0.00000000000 bone = shirt_tail_cloth_zz 
	SetBoneTransMax x = 0.00000000000 y = 0.00000000000 z = 20 bone = shirt_tail_cloth_zz 
	WaitOnGround 
	SetClothesInactive 
ENDSCRIPT

SCRIPT WindyPantsOn 
	SetBoneTransActive bone = left_low_trouser_cloth_zz 1 
	SetBoneTransActive bone = right_low_trouser_cloth_zz 1 
	SetBoneTransActive bone = shirt_tail_cloth_zz 1 
	SetBoneTransSpeed x = 32 y = 0 z = 32 bone = left_low_trouser_cloth_zz 
	SetBoneTransMin x = 0.00000000000 y = 0.00000000000 z = 0.00000000000 bone = left_low_trouser_cloth_zz 
	SetBoneTransMax x = 0.00000000000 y = 0.00000000000 z = 5.50000000000 bone = left_low_trouser_cloth_zz 
	SetBoneRotSpeed x = 32 y = 32 z = 32 bone = left_low_trouser_cloth_zz 
	SetBoneRotMin x = 0 y = 0 z = -128 bone = left_low_trouser_cloth_zz 
	SetBoneRotMax x = 0 y = 0 z = 128 bone = left_low_trouser_cloth_zz 
	SetBoneTransSpeed x = 32 y = 32 z = 32 bone = right_low_trouser_cloth_zz 
	SetBoneTransMin x = 0.00000000000 y = 0.00000000000 z = 0.00000000000 bone = right_low_trouser_cloth_zz 
	SetBoneTransMax x = 0.00000000000 y = 0.00000000000 z = 5.50000000000 bone = right_low_trouser_cloth_zz 
	SetBoneRotSpeed x = 32 y = 32 z = 32 bone = right_low_trouser_cloth_zz 
	SetBoneRotMin x = 0 y = 0 z = -128 bone = right_low_trouser_cloth_zz 
	SetBoneRotMax x = 0 y = 0 z = 128 bone = right_low_trouser_cloth_zz 
	SetBoneTransSpeed x = 32 y = 32 z = 32 bone = shirt_tail_cloth_zz 
	SetBoneTransMin x = 0.00000000000 y = 0.00000000000 z = 0.00000000000 bone = shirt_tail_cloth_zz 
	SetBoneTransMax x = 0.00000000000 y = 0.00000000000 z = 5.50000000000 bone = shirt_tail_cloth_zz 
	SetBoneRotSpeed x = 32 y = 32 z = 32 bone = shirt_tail_cloth_zz 
	SetBoneRotMin x = 0 y = 0 z = -128 bone = shirt_tail_cloth_zz 
	SetBoneRotMax x = 0 y = 0 z = 128 bone = shirt_tail_cloth_zz 
ENDSCRIPT


