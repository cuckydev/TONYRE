
ped_editable_list = [ 
	{ part = ped_m_head use_pedpre } 
	{ part = ped_m_torso use_pedpre } 
	{ part = ped_m_legs use_pedpre } 
	{ part = ped_f_head use_pedpre } 
	{ part = ped_f_torso use_pedpre } 
	{ part = ped_f_legs use_pedpre } 
	{ part = ped_body use_pedpre } 
	{ part = ped_board use_pedpre } 
] 
master_editable_list = [ 
	{ part = ped_m_head use_pedpre submenu = face_menu } 
	{ part = ped_m_torso use_pedpre submenu = shirt_style_menu } 
	{ part = ped_m_legs use_pedpre submenu = pants_menu } 
	{ part = ped_f_head use_pedpre submenu = face_menu } 
	{ part = ped_f_torso use_pedpre submenu = shirt_style_menu } 
	{ part = ped_f_legs use_pedpre submenu = pants_menu } 
	{ part = ped_body use_pedpre submenu = body_menu } 
	{ part = ped_board use_pedpre submenu = deck_graphic_menu } 
	{ part = body male = 0 female = 0 } 
	{ part = board material = skateboard_wheels pass = 0 male = 1 female = 1 submenu = board_menu colormenu = wheel_color_menu } 
	{ part = skater_m_head material = cashead_head pass = [ 0 1 2 ] male = 1 female = 0 submenu = face_menu colormenu = skin_color_menu } 
	{ part = skater_m_torso 
		materials = [ 
			{ tshirt_shirt 0 } 
			{ tshirt_shirt 1 } 
			{ tshirt_shirt 2 } 
			{ tshirt_sleeve 0 } 
		] 
	male = 1 female = 0 submenu = shirt_style_menu colormenu = shirt_color_menu } 
	{ part = skater_m_legs male = 1 female = 0 submenu = pants_menu colormenu = pants_color_menu } 
	{ part = skater_m_hair male = 1 female = 0 submenu = hair_menu colormenu = hair_color_menu } 
	{ part = skater_m_backpack male = 1 female = 0 submenu = backpack_menu colormenu = pack_color_menu } 
	{ part = skater_m_jaw material = cashead_head pass = 3 male = 1 female = 0 submenu = jaw_menu colormenu = facial_hair_color_menu } 
	{ part = skater_m_socks male = 1 female = 0 submenu = socks_menu colormenu = socks_color_menu } 
	{ part = skater_f_head male = 0 female = 1 submenu = face_menu colormenu = skin_color_menu } 
	{ part = skater_f_torso 
		materials = [ 
			{ tshirt_shirt 0 } 
			{ tshirt_shirt 1 } 
			{ tshirt_shirt 2 } 
			{ tshirt_sleeve 0 } 
		] 
	male = 0 female = 1 submenu = shirt_style_menu colormenu = shirt_color_menu } 
	{ part = skater_f_legs male = 0 female = 1 submenu = pants_menu colormenu = pants_color_menu } 
	{ part = skater_f_hair male = 0 female = 1 submenu = hair_menu colormenu = hair_color_menu } 
	{ part = skater_f_backpack male = 0 female = 1 submenu = backpack_menu colormenu = pack_color_menu } 
	{ part = skater_f_socks male = 0 female = 1 submenu = socks_menu colormenu = socks_color_menu } 
	{ part = sleeves material = tshirt_long pass = 0 male = 1 female = 1 colormenu = sleeve_color_menu } 
	{ part = kneepads male = 1 female = 1 submenu = kneepads_menu colormenu = kneepads_color_menu } 
	{ part = elbowpads male = 1 female = 1 submenu = elbowpads_menu colormenu = elbowpads_color_menu } 
	{ part = shoes male = 1 female = 1 submenu = shoes_menu colormenu = shoe_color_menu } 
	{ part = front_logo male = 1 female = 1 submenu = front_logo_menu posmenu = front_logo_pos_menu } 
	{ part = back_logo male = 1 female = 1 submenu = back_logo_menu posmenu = back_logo_pos_menu } 
	{ part = glasses male = 1 female = 1 submenu = glasses_menu colormenu = glasses_color_menu } 
	{ part = hat male = 1 female = 1 submenu = hats_menu colormenu = hat_color_menu } 
	{ part = helmet male = 1 female = 1 submenu = helmet_menu colormenu = helmet_color_menu } 
	{ part = accessories male = 1 female = 1 submenu = accessories_menu colormenu = accessories_color_menu } 
	{ part = hat_logo male = 1 female = 1 submenu = hat_logo_menu } 
	{ part = helmet_logo male = 1 female = 1 submenu = helmet_logo_menu } 
	{ part = griptape male = 1 female = 1 submenu = grip_tape_style_menu } 
	{ part = deck_graphic male = 1 female = 1 submenu = deck_graphic_menu } 
	{ part = cad_graphic male = 1 female = 1 submenu = cad_graphic_menu colormenu = cad_graphic_color_menu } 
	{ part = deck_layer1 material = skateboard_layers pass = 0 male = 1 female = 1 submenu = deck_layer1_menu colormenu = deck_layer1_color_menu posmenu = deck_layer1_pos_menu } 
	{ part = deck_layer2 material = skateboard_layers pass = 1 male = 1 female = 1 submenu = deck_layer2_menu colormenu = deck_layer2_color_menu posmenu = deck_layer2_pos_menu } 
	{ part = deck_layer3 material = skateboard_layers pass = 2 male = 1 female = 1 submenu = deck_layer3_menu colormenu = deck_layer3_color_menu posmenu = deck_layer3_pos_menu } 
	{ part = deck_layer4 material = skateboard_graphic pass = 1 male = 1 female = 1 submenu = deck_layer4_menu colormenu = deck_layer4_color_menu posmenu = deck_layer4_pos_menu } 
	{ part = deck_layer5 material = skateboard_graphic pass = 2 male = 1 female = 1 submenu = deck_layer5_menu colormenu = deck_layer5_color_menu posmenu = deck_layer5_pos_menu } 
	{ part = head_tattoo male = 1 female = 1 submenu = head_tattoo_menu posmenu = head_tattoo_pos_menu is_tattoo = 1 } 
	{ part = left_bicep_tattoo male = 1 female = 1 submenu = left_bicep_tattoo_menu posmenu = left_bicep_tattoo_pos_menu is_tattoo = 1 } 
	{ part = left_forearm_tattoo male = 1 female = 1 submenu = left_forearm_tattoo_menu posmenu = left_forearm_tattoo_pos_menu is_tattoo = 1 no_rot = 1 no_pos = use_uv_v_only } 
	{ part = right_bicep_tattoo male = 1 female = 1 submenu = right_bicep_tattoo_menu posmenu = right_bicep_tattoo_pos_menu is_tattoo = 1 } 
	{ part = right_forearm_tattoo male = 1 female = 1 submenu = right_forearm_tattoo_menu posmenu = right_forearm_tattoo_pos_menu is_tattoo = 1 no_rot = 1 no_pos = use_uv_v_only } 
	{ part = chest_tattoo male = 1 female = 1 submenu = chest_tattoo_menu posmenu = chest_tattoo_pos_menu is_tattoo = 1 } 
	{ part = back_tattoo male = 1 female = 1 submenu = back_tattoo_menu posmenu = back_tattoo_pos_menu is_tattoo = 1 } 
	{ part = left_leg_tattoo male = 1 female = 1 submenu = left_leg_tattoo_menu posmenu = left_leg_tattoo_pos_menu is_tattoo = 1 no_rot = 1 no_pos = use_uv_v_only } 
	{ part = right_leg_tattoo male = 1 female = 1 submenu = right_leg_tattoo_menu posmenu = right_leg_tattoo_pos_menu is_tattoo = 1 no_rot = 1 no_pos = use_uv_v_only } 
] 
master_scaling_list = [ 
	{ part = headtop_bone_group bone_scaling = 1 } 
	{ part = Jaw_bone_group bone_scaling = 1 } 
	{ part = nose_bone_group bone_scaling = 1 } 
	{ part = head_bone_group bone_scaling = 1 } 
	{ part = torso_bone_group bone_scaling = 1 } 
	{ part = stomach_bone_group bone_scaling = 1 } 
	{ part = upper_arm_bone_group bone_scaling = 1 } 
	{ part = lower_arm_bone_group bone_scaling = 1 } 
	{ part = hands_bone_group bone_scaling = 1 } 
	{ part = upper_leg_bone_group bone_scaling = 1 } 
	{ part = lower_leg_bone_group bone_scaling = 1 } 
	{ part = feet_bone_group bone_scaling = 1 } 
	{ part = board_bone_group bone_scaling = 1 } 
	{ part = object_scaling } 
] 
master_uv_list = [ 
	{ part = deck_layer1 material = skateboard_layers pass = 0 } 
	{ part = deck_layer2 material = skateboard_layers pass = 1 } 
	{ part = deck_layer3 material = skateboard_layers pass = 2 } 
	{ part = deck_layer4 material = skateboard_graphic pass = 1 } 
	{ part = deck_layer5 material = skateboard_graphic pass = 2 } 
	{ part = front_logo material = tshirt_shirt pass = 1 } 
	{ part = back_logo material = tshirt_shirt pass = 2 } 
	{ part = head_tattoo material = head_head pass = 1 } 
	{ part = chest_tattoo material = skater_torso pass = 1 } 
	{ part = back_tattoo material = skater_torso pass = 2 } 
	{ part = left_bicep_tattoo material = skater_ArmL pass = 1 } 
	{ part = right_bicep_tattoo material = skater_ArmR pass = 1 } 
	{ part = left_forearm_tattoo material = skater_ArmL pass = 2 } 
	{ part = right_forearm_tattoo material = skater_ArmR pass = 2 } 
	{ part = left_leg_tattoo material = skater_LegL pass = 1 } 
	{ part = right_leg_tattoo material = skater_LegR pass = 1 } 
] 
SCRIPT cas_reset_all_tattoos 
	process_cas_command cas_command = cas_reset_tattoo editable_list = master_editable_list 
	GetCurrentSkaterProfileIndex 
	RefreshSkaterModel profile = <currentSkaterProfileIndex> skater = 0 no_board = no_board 
	edit_skater_create_main_menu 
ENDSCRIPT

SCRIPT cas_reset_tattoo 
	IF GotParam is_tattoo 
		IF ( <is_tattoo> = 1 ) 
			GetCurrentSkaterProfileIndex 
			EditPlayerAppearance { 
				profile = <currentSkaterProfileIndex> 
				target = ClearPart 
				targetParams = { part = <part> } 
			} 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT cas_reset_all_scaling 
	FireEvent type = unfocus target = current_menu 
	create_dialog_box { 
		title = "Reset All?" 
		text = "Are you sure want to reset all scaling?" 
		pad_back_script = cas_cancel_reset_all_scaling 
		buttons = [ { text = "yes" pad_choose_script = cas_really_reset_all_scaling } 
			{ text = "no" pad_choose_script = cas_cancel_reset_all_scaling } 
		] 
	} 
ENDSCRIPT

SCRIPT cas_cancel_reset_all_scaling 
	dialog_box_exit 
	FireEvent type = focus target = current_menu 
	SetScreenElementLock off id = edit_skater_anchor 
	create_helper_text generic_helper_text_cas parent = edit_skater_anchor 
ENDSCRIPT

SCRIPT cas_really_reset_all_scaling 
	cas_cancel_reset_all_scaling 
	process_cas_command cas_command = cas_reset_scale editable_list = master_scaling_list 
	GetCurrentSkaterProfileIndex 
	RefreshSkaterModel profile = <currentSkaterProfileIndex> skater = 0 no_board = no_board 
ENDSCRIPT

SCRIPT cas_reset_scale 
	GetCurrentSkaterProfileIndex 
	<x> = 100 
	<y> = 100 
	<z> = 100 
	GetCurrentSkaterProfileIndex 
	SetPlayerAppearanceScale player = <currentSkaterProfileIndex> part = <part> x = <x> y = <y> z = <z> use_default_scale = 1 
ENDSCRIPT


