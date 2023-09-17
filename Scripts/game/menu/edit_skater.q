in_cinematic_sequence = 0 
in_net_setup_flow = 0 
CASCURRENTCOLOR = [ 12 44 67 110 ] 
SCRIPT launch_cas 
	SetGameType freeskate 
	SetCurrentGameType 
	select_skater_get_current_skater_name 
	IF NOT ( <current_skater> = custom ) 
		load_pro_skater { profile = 0 skater = 0 name = custom } 
	ENDIF 
	IF GotParam face 
		change goto_face_menu = 1 
	ENDIF 
	IF GotParam face2 
		change goto_face_menu = 2 
	ENDIF 
	IF LevelIs load_skateshop 
		change entered_cas_from_main = 1 
	ENDIF 
	main_menu_play_level level = load_CAS 
ENDSCRIPT

goto_cad = 0 
entered_cas_from_main = 0 
SCRIPT launch_cad 
	change goto_cad = 1 
	launch_cas 
ENDSCRIPT

SCRIPT change_level_to_cad 
	change goto_cad = 1 
	change_level level = load_CAS 
ENDSCRIPT

SCRIPT launch_pre_cas_menu 
	load_cas_textures_to_main_memory 
	set_cas_cam 
	IF ( goto_cad = 1 ) 
		IF ( in_cad_cutscene_sequence = 1 ) 
			create_cad_intro_message 
		ELSE 
			create_deck_design_menu wait_for_skater = wait_for_skater 
		ENDIF 
	ELSE 
		create_pre_cas_menu wait_for_skater = wait_for_skater 
	ENDIF 
ENDSCRIPT

SCRIPT create_cad_intro_message 
	GetCurrentSkaterProfileIndex 
	GetSkaterProfileInfo player = <currentskaterprofileindex> 
	IF ( <stance> = goofy ) 
		change was_goofy = 1 
		SetSkaterProfileInfo player = <currentskaterprofileindex> params = { stance = regular } 
		RefreshSkaterModel skater = 0 profile = <currentskaterprofileindex> 
	ENDIF 
	skater : SwitchOnBoard 
	skater : PlayAnim Anim = BoardPlacement BlendPeriod = 0 cycle 
	skater : Obj_MoveToNode name = cad_deck_spot orient 
	skater : Obj_ShadowOff 
	Debounce X 0.30000001192 
	create_dialog_box { title = "Create-A-Deck Unlocked" 
		text = "Now that you\'re a Pro, you\'ll need to design your own Pro deck graphic." 
		just = [ center center ] 
		buttons = [ { font = small text = "Ok" pad_choose_script = Cad_intro_message_exit } 
		] 
		text_dims = PAIR(300.00000000000, 0.00000000000) 
		delay_input 
	} 
	RunScriptOnScreenElement cad_camera id = dialog_box_anchor params = { wait_for_skater = wait_for_skater } 
ENDSCRIPT

SCRIPT Cad_intro_message_exit 
	dialog_box_exit 
	create_deck_design_menu wait_for_skater = wait_for_skater 
ENDSCRIPT

SCRIPT pre_cas_menu_exit 
	dialog_box_exit 
	change entered_cas_from_main = 0 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
		wait 1 frame 
	ENDIF 
	<new_menu_script> <...> 
ENDSCRIPT

SCRIPT play_first_cutscene 
	PlayCutscene name = "cutscenes\\Intro_01.cut" exitScript = launch_pre_cas_menu dont_unload_anims 
ENDSCRIPT

SCRIPT show_intro_2 
	killskatercamanim all 
	unpausegame 
	PlayCutscene name = "cutscenes\\Intro_02.cut" exitScript = end_intro_2 dont_unload_anims 
ENDSCRIPT

SCRIPT end_intro_2 
	printf "finished intros... going to NJ" 
	DisplayLoadingScreen Blank 
	load_cas_textures_to_main_memory unload 
	SetGameType career 
	SetCurrentGameType 
	exit_cas level = load_nj 
ENDSCRIPT

SCRIPT debug_the_cas 
	load_cas_textures_to_main_memory unload 
	killskatercamanim all 
	restore_start_key_binding 
	create_pause_menu 
ENDSCRIPT

SCRIPT set_cas_cam 
	IF LevelIs load_CAS 
		IF GotParam wait_for_skater 
			wait 3 gameframe 
		ENDIF 
		GoalManager_HidePoints 
		GoalManager_HideGoalPoints 
		killskatercamanim all 
		PlaySkaterCamAnim play_hold name = CAS_intro_cam 
		skater : Obj_ShadowOn shadowtype = detailed 
		skater : pausePhysics 
		MakeSkaterGoto SkateShopAI params = { NOSFX CAS_Screen } 
		skater : Obj_MoveToNode orient name = cas_player_restart 
		skater : SwitchOffBoard 
	ENDIF 
ENDSCRIPT

SCRIPT exit_cas level = load_skateshop 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
		load_cas_textures_to_main_memory unload 
	ENDIF 
	change entered_cas_from_main = 0 
	IF NOT ( return_to_level [ 0 ] = null ) 
		level = ( return_to_level [ 0 ] ) 
		array = return_to_level 
		SetArrayElement arrayname = array index = 0 newvalue = null 
	ENDIF 
	change_level level = <level> <...> 
ENDSCRIPT

SCRIPT cas_overwrite_warning title = #"Overwrite" callback = cas_reset_skater_and_goto_menu 
	create_snazzy_dialog_box { 
		title = <title> 
		text = #"Warning !\\nAny unsaved changes to your current STORY/SKATER will be lost.\\nContinue ?" 
		text_dims = PAIR(400.00000000000, 0.00000000000) 
		pad_back_script = create_pre_cas_menu 
		buttons = [ 
			{ font = small text = #"No" pad_choose_script = create_pre_cas_menu } 
			{ 
				font = small text = #"Yes" 
				pad_choose_script = pre_cas_menu_exit 
				pad_choose_params = 
				{ 
					new_menu_script = <callback> 
				} 
			} 
		] 
	} 
ENDSCRIPT

SCRIPT cas_reset_skater_and_goto_menu 
	ResetToDefaultProfile name = custom partial = partial 
	set_default_temporary_profiles 
	load_pro_skater name = custom 
	UnsetGlobalFlag flag = CAREER_STARTED 
	skateshop_create_cas_menu came_from_main_menu 
ENDSCRIPT

SCRIPT career_post_load 
	IF NOT IsXBox 
		IF GetGlobalFlag flag = SCREEN_MODE_STANDARD 
			IF GetGlobalFlag flag = SCREEN_MODE_WIDE 
				screen_setup_letterbox 
			ELSE 
				screen_setup_standard 
			ENDIF 
		ELSE 
			IF GetGlobalFlag flag = SCREEN_MODE_WIDE 
				screen_setup_widescreen 
			ENDIF 
		ENDIF 
	ENDIF 
	set_default_temporary_profiles 
ENDSCRIPT

SCRIPT cas_post_load 
	set_default_temporary_profiles 
ENDSCRIPT

SCRIPT jump_to_edit_skater 
	dialog_box_exit 
	skateshop_create_cas_menu came_from_main_menu 
ENDSCRIPT

came_to_cas_menu_from_main_menu = 0 
SCRIPT skateshop_create_cas_menu 
	IF GotParam came_from_main_menu 
		change came_to_cas_menu_from_main_menu = 1 
	ELSE 
		change came_to_cas_menu_from_main_menu = 0 
	ENDIF 
	launch_edit_skater_menu <...> 
	skater : SwitchOffBoard 
	skater : Obj_MoveToNode orient name = cas_player_restart 
ENDSCRIPT

edit_skater_menu_level_1_index = 0 
edit_skater_menu_level_2_index = 0 
SCRIPT launch_edit_skater_menu 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	GoalManager_HidePoints 
	GoalManager_HideGoalPoints 
	MakeSkaterGoto SkateShopAI params = { NOSFX CAS_Screen } 
	change cas_cam_angle = 0 
	set_cas_cam 
	create_edit_skater_menu <...> animate 
ENDSCRIPT

SCRIPT check_if_board_options_enabled 
	<retVal> = 1 
	GetCurrentSkaterProfileIndex 
	GetSkaterProfileInfo player = <currentskaterprofileindex> 
	IF GotParam group 
		IF GotParam no_edit_groups 
			GetArraySize <no_edit_groups> 
			<index> = 0 
			BEGIN 
				IF ( <no_edit_groups> [ <index> ] = <group> ) 
					<retVal> = 0 
					BREAK 
				ENDIF 
				<index> = ( <index> + 1 ) 
			REPEAT <array_size> 
		ENDIF 
	ENDIF 
	RETURN is_enabled = <retVal> 
ENDSCRIPT

SCRIPT check_if_group_editable 
	<retVal> = 1 
	GetCurrentSkaterProfileIndex 
	GetSkaterProfileInfo player = <currentskaterprofileindex> 
	IF GotParam no_edit 
		<retVal> = 0 
	ENDIF 
	IF GotParam group 
		IF GotParam no_edit_groups 
			GetArraySize <no_edit_groups> 
			<index> = 0 
			BEGIN 
				IF ( <no_edit_groups> [ <index> ] = <group> ) 
					<retVal> = 0 
					BREAK 
				ENDIF 
				<index> = ( <index> + 1 ) 
			REPEAT <array_size> 
		ENDIF 
	ENDIF 
	IF GotParam not_with_scaling_cheats 
		IF GetGlobalFlag flag = CHEAT_GORILLA 
			<retVal> = 0 
		ENDIF 
		IF GetGlobalFlag flag = CHEAT_KID 
			<retVal> = 0 
		ENDIF 
		IF GetGlobalFlag flag = CHEAT_BIGHEAD 
			<retVal> = 0 
		ENDIF 
	ENDIF 
	RETURN is_enabled = <retVal> 
ENDSCRIPT

SCRIPT check_if_part_editable 
	<retVal> = 0 
	IF GotParam part 
		GetCurrentSkaterProfileIndex 
		IF GetPlayerAppearancePart player = <currentskaterprofileindex> part = <part> 
			IF ( <desc_id> = None ) 
				<retVal> = 0 
			ELSE 
				<retVal> = 1 
			ENDIF 
		ELSE 
			<is_enabled> = 0 
		ENDIF 
	ENDIF 
	RETURN is_enabled = <retVal> 
ENDSCRIPT

SCRIPT check_if_part_logoable 
	<retVal> = 0 
	IF GotParam parts 
		GetArraySize <parts> 
		<index> = 0 
		BEGIN 
			GetCurrentSkaterProfileIndex 
			IF GetPlayerAppearancePart player = <currentskaterprofileindex> part = ( <parts> [ <index> ] ) 
				GetActualCASOptionStruct part = ( <parts> [ <index> ] ) desc_id = <desc_id> 
				IF GotParam supports_logo 
					<retVal> = 1 
					BREAK 
				ELSE 
					<retVal> = 0 
					BREAK 
				ENDIF 
			ENDIF 
			<index> = ( <index> + 1 ) 
		REPEAT <array_size> 
	ENDIF 
	RETURN is_enabled = <retVal> 
ENDSCRIPT

SCRIPT check_if_part_back_logoable 
	check_if_part_logoable <...> 
	IF ( <is_enabled> = 1 ) 
		IF GotParam parts 
			GetArraySize <parts> 
			<index> = 0 
			BEGIN 
				GetCurrentSkaterProfileIndex 
				IF GetPlayerAppearancePart player = <currentskaterprofileindex> part = ( <parts> [ <index> ] ) 
					GetActualCASOptionStruct part = ( <parts> [ <index> ] ) desc_id = <desc_id> 
					IF GotParam no_back_logo 
						RETURN is_enabled = 0 
					ENDIF 
				ENDIF 
				<index> = ( <index> + 1 ) 
			REPEAT <array_size> 
		ENDIF 
	ENDIF 
	RETURN is_enabled = <is_enabled> 
ENDSCRIPT

SCRIPT check_if_item_accessible 
	<retVal> = 1 
	GetCurrentSkaterProfileIndex 
	GetSkaterProfileInfo player = <currentskaterprofileindex> 
	GetActualCASOptionStruct part = <part> desc_id = <desc_id> 
	IF GotParam lockout_flags 
		GetArraySize <lockout_flags> 
		<index> = 0 
		BEGIN 
			IF GotParam ( <lockout_flags> [ <index> ] ) 
				<retVal> = 0 
				BREAK 
			ENDIF 
			<index> = ( <index> + 1 ) 
		REPEAT <array_size> 
	ENDIF 
	RETURN is_enabled = <retVal> 
ENDSCRIPT

SCRIPT check_if_part_colorable 
	<retVal> = 0 
	IF GotParam extra_script 
		<extra_script> 
		IF ( <is_enabled> = 0 ) 
			RETURN is_enabled = <is_enabled> 
		ENDIF 
	ENDIF 
	IF GotParam parts 
		GetArraySize <parts> 
		<index> = 0 
		BEGIN 
			GetCurrentSkaterProfileIndex 
			IF GetPlayerAppearancePart player = <currentskaterprofileindex> part = ( <parts> [ <index> ] ) 
				GetActualCASOptionStruct part = ( <parts> [ <index> ] ) desc_id = <desc_id> 
				IF GotParam no_color 
					<retVal> = 0 
					BREAK 
				ELSE 
					<retVal> = 1 
					BREAK 
				ENDIF 
			ENDIF 
			<index> = ( <index> + 1 ) 
		REPEAT <array_size> 
	ENDIF 
	RETURN is_enabled = <retVal> 
ENDSCRIPT

SCRIPT check_if_sleeve_colorable 
	check_if_part_colorable <...> 
	IF ( <is_enabled> = 0 ) 
		RETURN is_enabled = <is_enabled> 
	ENDIF 
	IF GotParam parts 
		GetArraySize <parts> 
		<index> = 0 
		BEGIN 
			GetCurrentSkaterProfileIndex 
			IF GetPlayerAppearancePart player = <currentskaterprofileindex> part = ( <parts> [ <index> ] ) 
				GetActualCASOptionStruct part = ( <parts> [ <index> ] ) desc_id = <desc_id> 
				IF GotParam multicolor 
					<retVal> = <multicolor> 
					BREAK 
				ELSE 
					<retVal> = 0 
					BREAK 
				ENDIF 
			ENDIF 
			<index> = ( <index> + 1 ) 
		REPEAT <array_size> 
	ENDIF 
	RETURN is_enabled = <retVal> 
ENDSCRIPT

SCRIPT check_option_is_enabled 
	<ret_val> = 1 
	<is_enabled> = 1 
	IF GotParam is_enabled_script 
		<is_enabled_script> <is_enabled_params> 
		IF ( <is_enabled> = 0 ) 
			<ret_val> = 0 
		ENDIF 
	ENDIF 
	IF IsTrue worst_case_cas_debug 
		RETURN is_enabled = 1 
	ENDIF 
	RETURN is_enabled = <ret_val> 
ENDSCRIPT

SCRIPT check_option_is_visible 
	<ret_val> = 1 
	IF GotParam is_visible_script 
		<is_visible_script> <is_visible_params> 
		IF ( <is_enabled> = 0 ) 
			<ret_val> = 0 
		ENDIF 
	ENDIF 
	IF GotParam is_visible_script2 
		<is_visible_script2> <is_visible_params2> 
		IF ( <is_enabled> = 0 ) 
			<ret_val> = 0 
		ENDIF 
	ENDIF 
	IF IsTrue worst_case_cas_debug 
		RETURN is_visible = 1 
	ENDIF 
	RETURN is_visible = <ret_val> 
ENDSCRIPT

SCRIPT edit_skater_create_options_menu pad_back_script = edit_skater_create_main_menu 
	killspawnedscript name = cas_pull_back_camera 
	change pulled_back = 0 
	IF StructureContains structure = ( <options_array> [ 0 ] ) group_title 
		title = ( ( <options_array> [ 0 ] ) . group_title ) 
	ENDIF 
	IF StructureContains structure = ( <options_array> [ 0 ] ) cad_part 
		cad_part = ( ( <options_array> [ 0 ] ) . cad_part ) 
	ENDIF 
	IF GotParam title 
		IF NOT GotParam title_icon 
			FormatText ChecksumName = title_icon "%i_edit_skater" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
		ENDIF 
		build_theme_sub_title title = <title> title_icon = <title_icon> 
	ENDIF 
	IF GotParam category 
		change current_cas_category = <category> 
	ELSE 
		change current_cas_category = 0 
	ENDIF 
	edit_skater_create_menu_block { 
		tab_texture = tab2 
		middle_texture = repeat_piece2 
		bottom_texture = menu_bottom 
	} 
	IF GotParam cam_anim 
		IF NOT ( <cam_anim> = fullbody ) 
			create_helper_text generic_helper_text_cas_z 
		ELSE 
			create_helper_text generic_helper_text_cas 
		ENDIF 
	ELSE 
		IF ( ( in_deck_design = 1 ) | ( in_boardshop = 1 ) ) 
			create_helper_text generic_helper_text 
		ELSE 
			create_helper_text generic_helper_text_cas 
		ENDIF 
	ENDIF 
	IF GotParam parent_index 
		change edit_skater_menu_level_1_index = <parent_index> 
	ENDIF 
	IF ( in_deck_design = 1 ) 
		pad_back_script = edit_skater_create_main_deck_menu 
	ENDIF 
	IF ( in_boardshop = 1 ) 
		pad_back_script = boardshop_create_main_menu 
	ENDIF 
	edit_skater_create_scrolling_menu { 
		tab = tab2 
		pad_back_script = <pad_back_script> 
		pad_back_params = <pad_back_params> 
	} 
	IF GotParam cad_part 
		get_part_current_desc_id part = <cad_part> 
		IF GotParam current_desc_id 
			get_logo_texture part = <cad_part> desc_id = <current_desc_id> 
			IF ScreenElementExists id = deck_layer_graphic 
				DestroyScreenElement id = deck_layer_graphic 
			ENDIF 
			IF StructureContains structure = ( <options_array> [ 0 ] ) deck_scaling 
				rot_angle = -90 
				scale = PAIR(0.50000000000, 0.89999997616) 
			ELSE 
				rot_angle = 0 
				scale = 1.00000000000 
			ENDIF 
			CreateScreenElement { 
				type = SpriteElement 
				parent = edit_skater_anchor_middle 
				id = deck_layer_graphic 
				texture = <texture> 
				scale = <scale> 
				rot_angle = <rot_angle> 
				pos = PAIR(185.00000000000, 125.00000000000) 
				just = [ center center ] 
				z_priority = 5 
			} 
		ENDIF 
	ENDIF 
	category_menu_set_focus 
	IF GotParam options_array 
		GetArraySize <options_array> 
		<index> = 0 
		BEGIN 
			RemoveParameter not_focusable 
			RemoveParameter is_enabled_script 
			RemoveParameter is_visible_script 
			check_option_is_enabled ( <options_array> [ <index> ] ) 
			IF ( <is_enabled> = 0 ) 
				AddParams not_focusable = not_focusable 
			ENDIF 
			check_option_is_visible ( <options_array> [ <index> ] ) 
			IF NOT ( <is_visible> = 0 ) 
				edit_skater_menu_add_item { 
					( <options_array> [ <index> ] ) 
					tab = tab2 
					index = <index> 
					options_array = <options_array> 
					not_focusable = <not_focusable> 
					cam_anim = <cam_anim> 
					category = <category> 
					should_add_reset_tattoos = <should_add_reset_tattoos> 
					should_add_reset_scaling = <should_add_reset_scaling> 
				} 
			ENDIF 
			<index> = ( <index> + 1 ) 
		REPEAT <array_size> 
	ENDIF 
	IF GotParam should_add_reset_tattoos 
		edit_skater_menu_add_item { 
			text = #"Clear all tattoos" 
			pad_choose_script = cas_reset_all_tattoos 
			tab = tab2 
		} 
	ENDIF 
	IF GotParam should_add_reset_scaling 
		edit_skater_menu_add_item { 
			text = #"Reset all" 
			pad_choose_script = cas_reset_all_scaling 
			tab = tab2 
		} 
	ENDIF 
	edit_skater_menu_add_item { 
		text = #"Done" 
		pad_choose_script = <pad_back_script> 
		tab = tab2 
	} 
	IF GotParam cam_anim 
		killskatercamanim all 
		cas_setup_rotating_camera cam_anim = <cam_anim> 
	ENDIF 
	IF NOT GotParam from_level_1 
		FireEvent type = focus target = current_menu data = { grid_index = edit_skater_menu_level_2_index } 
	ELSE 
		FireEvent type = focus target = current_menu 
	ENDIF 
ENDSCRIPT

SCRIPT edit_skater_create_cas_menu pad_back_script = edit_skater_create_options_menu 
	killspawnedscript name = cas_pull_back_camera 
	change pulled_back = 0 
	IF GotParam text 
		IF NOT GotParam title_icon 
			FormatText ChecksumName = title_icon "%i_edit_skater" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
		ENDIF 
		GetUpperCaseString <text> 
		build_theme_sub_title title = <UpperCaseString> title_icon = <title_icon> 
	ENDIF 
	IF GotParam cam_anim_sub 
		IF NOT ( <cam_anim_sub> = fullbody ) 
			create_helper_text generic_helper_text_cas_z 
		ELSE 
			create_helper_text generic_helper_text_cas 
		ENDIF 
	ELSE 
		IF GotParam cam_anim 
			IF NOT ( <cam_anim> = fullbody ) 
				create_helper_text generic_helper_text_cas_z 
			ENDIF 
		ELSE 
			IF ( ( in_deck_design = 1 ) | ( in_boardshop = 1 ) ) 
				create_helper_text generic_helper_text 
			ELSE 
				create_helper_text generic_helper_text_cas 
			ENDIF 
		ENDIF 
	ENDIF 
	edit_skater_create_menu_block tab_texture = tab3 middle_texture = repeat_piece3 bottom_texture = menu_bottom 
	IF GotParam show_logos 
		edit_skater_create_menu_block { tab_texture = tab1 
			parent = edit_skater_anchor_middle 
			scale = PAIR(0.50000000000, 1.00000000000) 
			pos = PAIR(560.00000000000, 240.00000000000) 
			id = edit_skater_logo_anchor 
			tab_id = edit_skater_logo_tab 
			bottom_id = edit_skater_logo_bottom 
			hide_line = hide_line 
		} 
		show_logos = show_logos 
	ENDIF 
	<pad_back_params> = { options_array = <options_array> cam_anim = <cam_anim> should_add_reset_tattoos = <should_add_reset_tattoos> should_add_reset_scaling = <should_add_reset_scaling> } 
	IF GotParam cam_anim_sub 
		killskatercamanim all 
		cas_setup_rotating_camera cam_anim = <cam_anim_sub> 
	ENDIF 
	IF GotParam cam_angle 
		spawnscript cas_rotate_camera_to_angle params = { angle = <cam_angle> } 
	ENDIF 
	IF GotParam parent_index 
		change edit_skater_menu_level_2_index = <parent_index> 
	ENDIF 
	edit_skater_create_scrolling_menu tab = tab3 pad_back_script = <pad_back_script> pad_back_params = { <pad_back_params> category = <category> } 
	category_menu_set_focus 
	GetCurrentSkaterProfileIndex 
	GetSkaterProfileInfo player = <currentskaterprofileindex> 
	GetArraySize master_editable_list 
	<master_size> = <array_size> 
	<index> = 0 
	<current_submenu> = <submenu> 
	BEGIN 
		RemoveParameter colormenu 
		RemoveParameter posmenu 
		RemoveParameter submenu 
		RemoveParameter no_pos 
		RemoveParameter no_rot 
		RemoveParameter no_scale 
		AddParams ( master_editable_list [ <index> ] ) 
		<shouldDisplayList> = 0 
		IF ( <is_male> = 1 ) 
			IF GotParam male 
				<shouldDisplayList> = ( <male> = 1 ) 
			ENDIF 
		ELSE 
			IF GotParam female 
				<shouldDisplayList> = ( <female> = 1 ) 
			ENDIF 
		ENDIF 
		IF GotParam submenu 
			IF ( <submenu> = <current_submenu> ) 
				IF NOT ( <shouldDisplayList> = 0 ) 
					GetArraySize <part> 
					IF NOT GotParam startlist 
						<part_index> = 0 
					ELSE 
						<part_index> = <startlist> 
					ENDIF 
					BEGIN 
						IF ( <array_size> > <part_index> ) 
							edit_skater_possibly_add_cas_item { 
								( <part> [ <part_index> ] ) 
								part = <part> 
								desc_id = <desc_id> 
								index = <index> 
								show_logos = <show_logos> 
								part_index = <part_index> 
								startlist = <startlist> 
								endlist = <endlist> 
							} 
						ELSE 
							BREAK 
						ENDIF 
						<part_index> = ( <part_index> + 1 ) 
					REPEAT <array_size> 
				ENDIF 
			ENDIF 
		ENDIF 
		IF GotParam colormenu 
			IF ( <colormenu> = <current_submenu> ) 
				IF NOT ( <shouldDisplayList> = 0 ) 
					IF ScreenElementExists id = edit_skater_menu_up_arrow 
						DoScreenElementMorph { 
							id = edit_skater_menu_up_arrow 
							scale = 0 
							relative_scale 
						} 
					ENDIF 
					IF ScreenElementExists id = edit_skater_menu_down_arrow 
						DoScreenElementMorph { 
							id = edit_skater_menu_down_arrow 
							scale = 0 
							relative_scale 
						} 
					ENDIF 
					colormenu_add_options_to_menu part = <part> from_cas 
					IF ( <current_submenu> = skin_color_menu ) 
						cas_setup_rotating_camera name = fullbody play_hold 
						create_helper_text generic_helper_text_color_menu 
					ELSE 
						IF GotParam cam_anim 
							IF NOT ( <cam_anim> = fullbody ) 
								create_helper_text generic_helper_text_color_menu_z scale = 0.89999997616 
							ENDIF 
						ENDIF 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
		IF GotParam posmenu 
			IF ( <posmenu> = <current_submenu> ) 
				IF NOT ( <shouldDisplayList> = 0 ) 
					IF ScreenElementExists id = edit_skater_menu_up_arrow 
						DoScreenElementMorph { 
							id = edit_skater_menu_up_arrow 
							scale = 0 
							relative_scale 
						} 
					ENDIF 
					IF ScreenElementExists id = edit_skater_menu_down_arrow 
						DoScreenElementMorph { 
							id = edit_skater_menu_down_arrow 
							scale = 0 
							relative_scale 
						} 
					ENDIF 
					posmenu_add_options_to_menu part = <part> from_cas no_pos = <no_pos> no_rot = <no_rot> no_scale = <no_scale> 
					IF GotParam cam_anim 
						IF NOT ( <cam_anim> = fullbody ) 
							IF isNGC 
								create_helper_text generic_helper_text_color_menu_reset_ngc 
							ELSE 
								create_helper_text generic_helper_text_color_menu_reset 
							ENDIF 
						ENDIF 
					ENDIF 
					dialog_box_exit 
					FireEvent type = focus target = current_menu 
					RETURN 
				ENDIF 
			ENDIF 
		ENDIF 
		<index> = ( <index> + 1 ) 
	REPEAT <master_size> 
	IF GotParam should_add_scaling_options 
		scalingmenu_add_options_to_menu part = <bone_group> <scaling_params> 
		IF isNGC 
			create_helper_text generic_helper_text_color_menu_reset_ngc 
		ELSE 
			create_helper_text generic_helper_text_color_menu_reset 
		ENDIF 
		IF GotParam cam_anim_sub 
			IF NOT ( <cam_anim_sub> = fullbody ) 
				create_helper_text generic_helper_text_color_menu_z scale = 0.89999997616 
			ENDIF 
		ELSE 
			create_helper_text generic_helper_text_color_menu scale = 0.89999997616 
		ENDIF 
	ENDIF 
	edit_skater_menu_add_item { 
		text = #"Done" 
		tab = tab3 
		text_pos = PAIR(0.00000000000, 0.00000000000) 
		dims = PAIR(10.00000000000, 33.00000000000) 
		pad_choose_script = <pad_back_script> 
		pad_choose_params = { 
			options_array = <options_array> 
			cam_anim = <cam_anim> 
			should_add_reset_tattoos = <should_add_reset_tattoos> 
			should_add_reset_scaling = <should_add_reset_scaling> 
			category = <category> 
		} 
	} 
	IF ( <current_submenu> = wheel_color_menu ) 
		DoScreenElementMorph id = edit_skater_menu_down_arrow pos = PAIR(150.00000000000, 283.00000000000) scale = 1 
		DoScreenElementMorph id = edit_skater_menu_up_arrow pos = PAIR(150.00000000000, 132.00000000000) scale = 1 
	ENDIF 
	dialog_box_exit 
	FireEvent type = focus target = current_menu 
ENDSCRIPT

SCRIPT edit_skater_create_scrolling_menu dims = PAIR(256.00000000000, 216.00000000000) arrow_scale = 1 
	SWITCH <tab> 
		CASE tab2 
			<menu_offset> = PAIR(134.00000000000, 35.00000000000) 
			<up_arrow_offset> = PAIR(119.00000000000, 5.00000000000) 
			<down_arrow_offset> = PAIR(119.00000000000, -12.00000000000) 
		CASE tab3 
			<menu_offset> = PAIR(143.00000000000, 35.00000000000) 
			<up_arrow_offset> = PAIR(127.00000000000, 5.00000000000) 
			<down_arrow_offset> = PAIR(127.00000000000, -12.00000000000) 
			padding_scale = 0.75000000000 
			dims = PAIR(256.00000000000, 222.00000000000) 
		DEFAULT 
			<menu_offset> = PAIR(135.00000000000, 35.00000000000) 
			<up_arrow_offset> = PAIR(120.00000000000, 5.00000000000) 
			<down_arrow_offset> = PAIR(120.00000000000, -12.00000000000) 
	ENDSWITCH 
	IF ( ( in_deck_design = 1 ) | ( in_boardshop = 1 ) ) 
		dims = PAIR(256.00000000000, 125.00000000000) 
		IF NOT ( ( <tab> = tab3 ) | ( ( in_boardshop = 1 ) & <tab> = tab2 ) ) 
			arrow_scale = 0 
		ELSE 
			padding_scale = 0.69999998808 
			arrow_scale = 0.75000000000 
		ENDIF 
	ENDIF 
	IF NOT GotParam no_category_menu 
		build_cas_category_menu 
	ENDIF 
	GetStackedScreenElementPos Y id = edit_skater_menu_tab offset = <up_arrow_offset> 
	CreateScreenElement { 
		type = SpriteElement 
		parent = edit_skater_anchor_middle 
		id = edit_skater_menu_up_arrow 
		texture = up_arrow 
		pos = <pos> 
		just = [ left top ] 
		z_priority = 5 
		scale = <arrow_scale> 
	} 
	GetStackedScreenElementPos Y id = edit_skater_menu_block_bottom offset = <down_arrow_offset> 
	CreateScreenElement { 
		type = SpriteElement 
		parent = edit_skater_anchor_middle 
		id = edit_skater_menu_down_arrow 
		texture = down_arrow 
		pos = <pos> 
		just = [ left bottom ] 
		z_priority = 5 
		scale = <arrow_scale> 
	} 
	GetStackedScreenElementPos Y id = edit_skater_menu_tab offset = <menu_offset> 
	CreateScreenElement { 
		type = VScrollingMenu 
		parent = edit_skater_anchor_middle 
		id = edit_skater_scrollingmenu 
		dims = <dims> 
		pos = <pos> 
		just = [ left top ] 
	} 
	CreateScreenElement { 
		type = VMenu 
		parent = edit_skater_scrollingmenu 
		id = edit_skater_vmenu 
		just = [ left top ] 
		dont_allow_wrap 
		padding_scale = <padding_scale> 
		spacing_between = <spacing_between> 
		event_handlers = [ { pad_up set_which_arrow params = { arrow = edit_skater_menu_up_arrow } } 
			{ pad_down set_which_arrow params = { arrow = edit_skater_menu_down_arrow } } 
			{ pad_up generic_menu_up_or_down_sound params = { up } } 
			{ pad_down generic_menu_up_or_down_sound params = { down } } 
			{ pad_back generic_menu_pad_back_sound } 
			{ pad_back <pad_back_script> params = <pad_back_params> } 
			{ pad_space toggle_cas_options_menu params = { } } 
			{ pad_backspace toggle_cas_options_menu params = { reverse } } 
		] 
	} 
	IF LevelIs load_CAS 
		IF ( in_deck_design = 0 ) 
			SetScreenElementProps { 
				id = edit_skater_vmenu 
				event_handlers = [ { pad_l1 cas_rotate_camera_left } 
					{ pad_r1 cas_rotate_camera_right } 
					{ pad_alt spawn_cas_pull_back_camera } 
				] 
				replace_handlers 
			} 
		ENDIF 
	ENDIF 
	AssignAlias id = edit_skater_vmenu alias = current_menu 
ENDSCRIPT

current_cas_category = 0 
SCRIPT toggle_cas_options_menu 
	IF ( current_cas_category = 0 ) 
		RETURN 
	ENDIF 
	IF NOT GotParam reverse 
		IF NOT ( current_cas_category = 6 ) 
			category = ( current_cas_category + 1 ) 
		ELSE 
			category = 1 
		ENDIF 
	ELSE 
		IF NOT ( current_cas_category = 1 ) 
			category = ( current_cas_category - 1 ) 
		ELSE 
			category = 6 
		ENDIF 
	ENDIF 
	SWITCH <category> 
		CASE 1 
			params = { options_array = edit_skater_head_options cam_anim = head from_level_1 } 
		CASE 2 
			params = { options_array = edit_skater_torso_options cam_anim = torso from_level_1 } 
		CASE 3 
			params = { options_array = edit_skater_leg_options cam_anim = legs from_level_1 } 
		CASE 4 
			params = { options_array = edit_skater_tattoo_options cam_anim = fullbody from_level_1 should_add_reset_tattoos = 1 } 
		CASE 5 
			params = { options_array = edit_skater_scaling_options cam_anim = fullbody from_level_1 should_add_reset_scaling = 1 } 
		CASE 6 
			params = { options_array = edit_skater_pad_options cam_anim = fullbody from_level_1 } 
	ENDSWITCH 
	PlaySound DE_MenuSelect vol = 100 
	IF GotParam params 
		edit_skater_create_options_menu { <params> category = <category> } 
	ENDIF 
ENDSCRIPT

SCRIPT get_current_skater_griptape_menu_enabled 
	<retVal> = 1 
	GetCurrentSkaterProfileIndex 
	IF GetPlayerAppearancePart player = <currentskaterprofileindex> part = board 
		GetActualCASOptionStruct part = board desc_id = <desc_id> 
		IF GotParam no_griptape 
			<retVal> = 0 
		ENDIF 
	ENDIF 
	RETURN griptape_menu_enabled = <retVal> 
ENDSCRIPT

SCRIPT get_current_skater_use_jets 
	<retVal> = 0 
	GetCurrentSkaterProfileIndex 
	IF GetPlayerAppearancePart player = <currentskaterprofileindex> part = board 
		GetActualCASOptionStruct part = board desc_id = <desc_id> 
		IF GotParam use_jets 
			<retVal> = 1 
		ENDIF 
	ENDIF 
	RETURN use_jets = <retVal> 
ENDSCRIPT

SCRIPT get_current_skater_name 
	GetCurrentSkaterProfileIndex 
	GetSkaterProfileInfo player = <currentskaterprofileindex> 
	RETURN name = <name> 
ENDSCRIPT

SCRIPT get_current_skater_sponsors 
	GetCurrentSkaterProfileIndex 
	GetSkaterProfileInfo player = <currentskaterprofileindex> 
	RETURN sponsors = <sponsors> 
ENDSCRIPT

SCRIPT get_skater_unlocked 
	GetSkaterProfileInfoByName name = <name> 
	IF GotParam is_hidden 
		IF ( <is_hidden> = 0 ) 
			RETURN is_unlocked = 1 
		ELSE 
			RETURN is_unlocked = 0 
		ENDIF 
	ELSE 
		RETURN is_unlocked = 1 
	ENDIF 
ENDSCRIPT

SCRIPT get_is_neversoft_skater 
	GetCurrentSkaterProfileIndex 
	GetSkaterProfileInfo player = <currentskaterprofileindex> 
	IF ( <is_pro> = 1 ) 
		RETURN is_neversoft_skater = 0 
	ELSE 
		RETURN is_neversoft_skater = <is_head_locked> 
	ENDIF 
ENDSCRIPT

SCRIPT get_has_weird_hat 
	<retVal> = 0 
	GetCurrentSkaterProfileIndex 
	IF GetPlayerAppearancePart player = <currentskaterprofileindex> part = hat 
		GetActualCASOptionStruct part = hat desc_id = <desc_id> 
		IF GotParam is_weird_hat 
			<retVal> = 1 
		ENDIF 
	ENDIF 
	RETURN has_weird_hat = <retVal> 
ENDSCRIPT

SCRIPT get_has_weird_head 
	<retVal> = 0 
	GetCurrentSkaterProfileIndex 
	IF GetPlayerAppearancePart player = <currentskaterprofileindex> part = skater_m_head 
		GetActualCASOptionStruct part = skater_m_head desc_id = <desc_id> 
		IF GotParam is_weird_head 
			<retVal> = 1 
		ENDIF 
	ENDIF 
	RETURN has_weird_head = <retVal> 
ENDSCRIPT

SCRIPT cas_item_is_visible 
	<is_visible> = 1 
	IF GotParam hidden 
		<is_visible> = 0 
	ENDIF 
	IF GotParam only_with 
		get_current_skater_name 
		GetArraySize <only_with> 
		<index> = 0 
		<is_visible> = 0 
		BEGIN 
			IF ChecksumEquals a = <name> b = ( <only_with> [ <index> ] ) 
				<is_visible> = 1 
			ENDIF 
			<index> = ( <index> + 1 ) 
		REPEAT <array_size> 
	ENDIF 
	IF GotParam unlock_flag 
		<is_visible> = 0 
		IF GetGlobalFlag flag = <unlock_flag> 
			<is_visible> = 1 
			<secret_color> = secret_color 
		ENDIF 
	ENDIF 
	IF GotParam sponsor 
		get_current_skater_sponsors 
		IF GotParam sponsors 
			GetArraySize <sponsors> 
			IF ( <array_size> = 0 ) 
			ELSE 
				<is_visible> = 0 
				<index> = 0 
				BEGIN 
					IF ChecksumEquals a = <sponsor> b = ( <sponsors> [ <index> ] ) 
						<is_visible> = 1 
					ENDIF 
					<index> = ( <index> + 1 ) 
				REPEAT <array_size> 
			ENDIF 
		ENDIF 
	ENDIF 
	IF GotParam only_if_unlocked 
		<is_visible> = 0 
		get_skater_unlocked name = <only_if_unlocked> 
		IF ( <is_unlocked> = 1 ) 
			<is_visible> = 1 
		ENDIF 
	ENDIF 
	IF GotParam only_with_neversoft_skater 
		<is_visible> = 0 
		get_is_neversoft_skater 
		IF ( <is_neversoft_skater> = 1 ) 
			<is_visible> = 1 
		ENDIF 
	ENDIF 
	IF GotParam not_with_weird_head 
		get_has_weird_head 
		IF ( <has_weird_head> = 1 ) 
			<is_visible> = 0 
		ENDIF 
	ENDIF 
	IF GotParam not_with_weird_hat 
		get_has_weird_hat 
		IF ( <has_weird_hat> = 1 ) 
			<is_visible> = 0 
		ENDIF 
	ENDIF 
	IF IsTrue worst_case_cas_debug 
		<is_visible> = 1 
	ENDIF 
	RETURN is_visible = <is_visible> secret_color = <secret_color> 
ENDSCRIPT

SCRIPT edit_skater_possibly_add_cas_item 
	cas_item_is_visible <...> 
	get_part_current_desc_id part = <part> 
	IF GotParam current_desc_id 
		IF ( <desc_id> = <current_desc_id> ) 
			current_part = current_part 
		ENDIF 
	ENDIF 
	IF GotParam secret_color 
		<rgba> = [ 32 32 255 128 ] 
		focus_params = { rgba = [ 32 32 255 255 ] } 
		unfocus_params = { rgba = [ 32 32 255 128 ] } 
	ENDIF 
	IF GotParam startlist 
		IF NOT ( ( <part_index> + 1 ) > <startlist> ) 
			RETURN 
		ENDIF 
	ENDIF 
	IF GotParam endlist 
		IF NOT ( ( <endlist> + 1 ) > <part_index> ) 
			RETURN 
		ENDIF 
	ENDIF 
	IF GotParam show_logos 
		IF GotParam with 
			GetTextureFromPath path = <with> 
			FormatText ChecksumName = texture_name "%t" t = <texture> 
			texture = <texture_name> 
		ENDIF 
	ENDIF 
	IF ( <is_visible> = 1 ) 
		IF NOT GotParam FrontEnd_Desc 
			<FrontEnd_Desc> = #"Unknown" 
		ENDIF 
		edit_skater_menu_add_item { 
			text = <FrontEnd_Desc> 
			tab = tab3 
			pad_choose_script = cas_add_item 
			pad_choose_params = { part = <part> desc_id = <desc_id> } 
			focus_script = <focus_script> 
			focus_params = <focus_params> 
			unfocus_script = <unfocus_script> 
			unfocus_params = <unfocus_params> 
			index = <index> 
			is_visible_script = check_if_item_accessible 
			is_visible_params = { part = <part> desc_id = <desc_id> } 
			rgba = <rgba> 
			text_pos = PAIR(0.00000000000, 0.00000000000) 
			dims = PAIR(10.00000000000, 30.00000000000) 
			show_logos = <show_logos> 
			texture = <texture> 
			current_part = <current_part> 
		} 
		RETURN cas_item_was_added = 1 
	ENDIF 
ENDSCRIPT

SCRIPT get_part_current_desc_id 
	GetPlayerAppearancePart player = 0 part = <part> 
	RETURN current_desc_id = <desc_id> 
ENDSCRIPT

SCRIPT edit_skater_icon_menu_add_item 
	IF GotParam child_texture 
		IF GotParam deck_icon 
			focus_script = edit_skater_menu_focus_with_deck_icon 
		ELSE 
			focus_script = edit_skater_menu_focus_with_icon 
		ENDIF 
		unfocus_script = edit_skater_menu_unfocus_with_icon 
	ENDIF 
	edit_skater_menu_add_item <...> 
ENDSCRIPT

SCRIPT edit_skater_menu_add_item { pad_choose_script = edit_skater_create_cas_menu 
		focus_script = edit_skater_menu_focus 
		unfocus_script = edit_skater_menu_unfocus 
		tab = tab1 
		font = small 
		icon_scale = 0 
		icon_pos = PAIR(-120.00000000000, 0.00000000000) 
		text_just = [ center center ] 
		text_pos = PAIR(0.00000000000, 0.00000000000) 
		dims = PAIR(10.00000000000, 25.00000000000) 
		bar_pos = PAIR(-4.00000000000, 0.00000000000) 
	} 
	printf <text> 
	IF NOT GotParam icon_rgba 
		FormatText ChecksumName = icon_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	ENDIF 
	FormatText ChecksumName = rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	IF GotParam current_part 
		rgba = CASCURRENTCOLOR 
		unfocus_params = { <unfocus_params> text_rgba = <rgba> } 
	ENDIF 
	IF GotParam is_visible_script 
		<is_visible_script> <is_visible_params> 
		IF ( <is_enabled> = 0 ) 
			RETURN 
		ENDIF 
	ENDIF 
	<is_enabled> = 1 
	IF GotParam is_enabled_script 
		<is_enabled_script> <is_enabled_params> 
		IF ( <is_enabled> = 0 ) 
			AddParams not_focusable = not_focusable 
		ENDIF 
	ENDIF 
	highlight_angle = RANDOM_NO_REPEAT(1, 1, 1, 1, 1, 1, 1, 1, 1, 1) RANDOMCASE 2 RANDOMCASE -2 RANDOMCASE 3 RANDOMCASE -3 RANDOMCASE 3.50000000000 RANDOMCASE -3 RANDOMCASE 5 RANDOMCASE -4 RANDOMCASE 2.50000000000 RANDOMCASE -4.50000000000 RANDOMEND 
	SWITCH <tab> 
		CASE tab1 
			<bar_scale> = PAIR(1.84000003338, 0.69999998808) 
		CASE tab2 
			<bar_scale> = PAIR(1.70000004768, 0.69999998808) 
		CASE tab3 
			IF GotParam show_logos 
				<bar_scale> = PAIR(2.54999995232, 0.69999998808) 
				bar_pos = PAIR(60.00000000000, 0.00000000000) 
				highlight_angle = ( <highlight_angle> / 2 ) 
				dims = PAIR(10.00000000000, 50.00000000000) 
				focus_script = edit_skater_menu_logo_focus 
				unfocus_script = edit_skater_menu_logo_unfocus 
			ELSE 
				<bar_scale> = PAIR(1.50000000000, 0.69999998808) 
			ENDIF 
			<font> = dialog 
	ENDSWITCH 
	SetScreenElementLock id = current_menu off 
	FormatText ChecksumName = id "%i" i = <text> 
	IF NOT GotParam pad_choose_params 
		<pad_choose_params> = { <...> id = <id> unfocus_script = <unfocus_script> unfocus_params = <unfocus_params> category = <category> } 
	ELSE 
		<pad_choose_params> = { <pad_choose_params> id = <id> unfocus_script = <unfocus_script> unfocus_params = <unfocus_params> category = <category> } 
	ENDIF 
	IF GotParam index 
		IF GotParam pad_choose_params 
			<pad_choose_params> = ( <pad_choose_params> + { parent_index = <index> cam_anim = <cam_anim> show_logos = <show_logos> } ) 
		ELSE 
			<pad_choose_params> = { parent_index = <index> cam_anim = <cam_anim> show_logos = <show_logos> } 
		ENDIF 
	ELSE 
		<pad_choose_params> = { <pad_choose_params> show_logos = <show_logos> } 
	ENDIF 
	CreateScreenElement { 
		type = ContainerElement 
		parent = current_menu 
		dims = <dims> 
		event_handlers = [ { focus <focus_script> params = <focus_params> } 
			{ unfocus <unfocus_script> params = <unfocus_params> } 
			{ pad_choose generic_menu_pad_choose_sound } 
			{ pad_choose <pad_choose_script> params = <pad_choose_params> } 
			{ pad_start <pad_choose_script> params = <pad_choose_params> } 
		] 
		id = <id> 
		<not_focusable> 
	} 
	<parent_id> = <id> 
	IF GotParam index 
		SetScreenElementProps { 
			id = <parent_id> 
			tags = { tag_grid_x = <index> } 
		} 
	ENDIF 
	IF GotParam not_focusable 
		alpha = 0.60000002384 
	ELSE 
		alpha = 1.00000000000 
	ENDIF 
	CreateScreenElement { 
		type = TextElement 
		parent = <parent_id> 
		font = <font> 
		text = <text> 
		scale = 0.89999997616 
		rgba = <rgba> 
		alpha = <alpha> 
		just = <text_just> 
		pos = <text_pos> 
		z_priority = 9 
		replace_handlers 
		<not_focusable> 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <parent_id> 
		pos = <bar_pos> 
		scale = <bar_scale> 
		texture = de_highlight_bar 
		rgba = [ 128 128 128 0 ] 
		rot_angle = <highlight_angle> 
	} 
	IF GotParam child_texture 
		CreateScreenElement { 
			type = SpriteElement 
			parent = <parent_id> 
			texture = <child_texture> 
			pos = <icon_pos> 
			rgba = <icon_rgba> 
			scale = <icon_scale> 
			id = <icon_id> 
			z_priority = 9 
			just = [ left center ] 
		} 
	ENDIF 
	IF ( <tab> = tab3 ) 
		IF NOT ( <text> = #"None" ) 
			IF GotParam show_logos 
				IF NOT GotParam texture 
					printf "aaaaaaaaaaaaaahhhhhhhhhhhhhhhhhh" 
					get_logo_texture part = ( <pad_choose_params> . part ) desc_id = ( <pad_choose_params> . desc_id ) 
				ENDIF 
				part = ( <pad_choose_params> . part ) 
				isadeck = ( ( <part> [ 0 ] ) . is_a_deck ) 
				scaleitdown = ( ( <part> [ 0 ] ) . scale_it_down ) 
				hatlogo = ( ( <part> [ 0 ] ) . hat_logo ) 
				IF GotParam isadeck 
					scale = PAIR(0.50000000000, 0.92500001192) 
					rot_angle = -90 
				ELSE 
					IF GotParam scaleitdown 
						scale = 0.64999997616 
						rot_angle = 0 
					ELSE 
						IF GotParam hatlogo 
							rot_angle = -90 
						ELSE 
							scale = 1.20000004768 
							rot_angle = 0 
						ENDIF 
					ENDIF 
				ENDIF 
				CreateScreenElement { 
					type = SpriteElement 
					parent = <parent_id> 
					texture = <texture> 
					pos = PAIR(163.00000000000, 0.00000000000) 
					scale = <scale> 
					alpha = 0.30000001192 
					rot_angle = <rot_angle> 
					z_priority = 9 
					just = [ center center ] 
				} 
			ENDIF 
		ENDIF 
	ENDIF 
	SetScreenElementLock id = current_menu on 
ENDSCRIPT

SCRIPT get_logo_texture 
	GetArraySize <part> 
	index = 0 
	BEGIN 
		IF ( ( ( <part> [ <index> ] ) . desc_id ) = <desc_id> ) 
			path = ( ( <part> [ <index> ] ) . with ) 
			IF GotParam path 
				GetTextureFromPath path = <path> 
				FormatText ChecksumName = texture_name "%t" t = <texture> 
				RETURN texture = <texture_name> 
			ELSE 
				RETURN 
			ENDIF 
		ENDIF 
		index = ( <index> + 1 ) 
	REPEAT <array_size> 
ENDSCRIPT

SCRIPT edit_skater_info_add_item { pad_choose_script = nullscript 
		pad_right_script = nullscript 
		pad_left_script = nullscript 
		focus_script = edit_skater_info_focus 
		unfocus_script = edit_skater_info_unfocus 
		tab = tab2 
		text_pos = PAIR(78.00000000000, 8.00000000000) 
		left_arrow_pos = PAIR(90.00000000000, 6.00000000000) 
		right_arrow_pos = PAIR(130.00000000000, 6.00000000000) 
	} 
	SetScreenElementLock id = current_menu off 
	CreateScreenElement { 
		type = ContainerElement 
		parent = current_menu 
		id = <item_id> 
		event_handlers = [ { focus <focus_script> params = <focus_params> } 
			{ unfocus <unfocus_script> params = <unfocus_params> } 
			{ pad_choose <pad_choose_script> params = <pad_choose_params> } 
			{ pad_start <pad_choose_script> params = <pad_choose_params> } 
			{ pad_right <pad_right_script> params = <pad_right_params> } 
			{ pad_left <pad_left_script> params = <pad_left_params> } 
		] 
		dims = PAIR(300.00000000000, 30.00000000000) 
		<not_focusable> 
	} 
	<parent_id> = <id> 
	IF GotParam index 
		SetScreenElementProps { 
			id = <parent_id> 
			tags = { tag_grid_x = <index> } 
		} 
	ENDIF 
	FormatText ChecksumName = rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	IF GotParam top_row 
		SetScreenElementProps { id = <parent_id> 
			event_handlers = [ { pad_choose generic_menu_pad_choose_sound } 
			{ pad_choose <pad_choose_script> params = <pad_choose_params> } ] 
		} replace_handlers 
	ENDIF 
	IF GotParam no_bg 
		SetScreenElementProps { id = <parent_id> 
			event_handlers = [ { pad_choose generic_menu_pad_choose_sound } 
			{ pad_choose <pad_choose_script> params = <pad_choose_params> } ] 
		} replace_handlers 
	ENDIF 
	CreateScreenElement { 
		type = TextElement 
		parent = <parent_id> 
		font = testtitle 
		text = <text> 
		scale = 0.89999997616 
		rgba = <rgba> 
		just = [ right center ] 
		pos = <text_pos> 
		replace_handlers 
		<not_focusable> 
	} 
	IF NOT GotParam no_bg 
		CreateScreenElement { 
			type = SpriteElement 
			parent = <parent_id> 
			pos = PAIR(-50.00000000000, -6.00000000000) 
			scale = PAIR(2.70000004768, 1.00000000000) 
			just = [ left top ] 
			texture = edit_bar 
			rgba = [ 128 128 128 60 ] 
			alpha = 0.50000000000 
			z_priority = 4 
		} 
		CreateScreenElement { 
			type = TextElement 
			parent = <parent_id> 
			font = dialog 
			text = <item_value_text> 
			scale = 0.80000001192 
			rgba = <rgba> 
			just = [ left center ] 
			pos = PAIR(100.00000000000, 6.00000000000) 
			not_focusable = not_focusable 
		} 
		value_id = <id> 
		truncate_string id = <id> max_width = 195 
		IF NOT GotParam top_row 
			CreateScreenElement { 
				type = SpriteElement 
				parent = <parent_id> 
				pos = <left_arrow_pos> 
				scale = PAIR(0.60000002384, 0.60000002384) 
				texture = left_arrow 
				rgba = [ 128 128 128 0 ] 
			} 
			GetStackedScreenElementPos X id = <value_id> offset = PAIR(11.00000000000, 10.00000000000) 
			CreateScreenElement { 
				type = SpriteElement 
				parent = <parent_id> 
				pos = <pos> 
				scale = PAIR(0.60000002384, 0.60000002384) 
				texture = right_arrow 
				rgba = [ 128 128 128 0 ] 
			} 
		ENDIF 
		CreateScreenElement { 
			type = SpriteElement 
			parent = <parent_id> 
			pos = PAIR(-50.00000000000, -6.00000000000) 
			scale = PAIR(86.40000152588, 7.00000000000) 
			just = [ left top ] 
			texture = black 
			rgba = [ 0 0 0 128 ] 
			alpha = 0.00000000000 
			z_priority = 4 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT edit_skater_create_menu_block { tab_texture = tab1 
		parent = edit_skater_anchor 
		middle_texture = repeat_piece 
		bottom_texture = menu_bottom 
		scale = PAIR(0.94999998808, 1.00000000000) 
		parts = 8 
		pos = PAIR(320.00000000000, 230.00000000000) 
		id = edit_skater_anchor_middle 
		bottom_id = edit_skater_menu_block_bottom 
	} 
	IF ObjectExists id = <id> 
		DestroyScreenElement id = <id> 
	ENDIF 
	FormatText ChecksumName = bg_piece_rgba "%i_BG_PARTS_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	CreateScreenElement { 
		type = ContainerElement 
		parent = <parent> 
		id = <id> 
		pos = <pos> 
		dims = PAIR(640.00000000000, 480.00000000000) 
	} 
	anchor_id = <id> 
	IF ( ( in_deck_design = 1 ) | ( in_boardshop = 1 ) ) 
		parts = 5 
	ENDIF 
	edit_skater_menu_create_tab texture = <tab_texture> rgba = <bg_piece_rgba> scale = <scale> tab_id = <tab_id> parent = <anchor_id> hide_line = <hide_line> 
	<piece_id> = edit_skater_menu_tab 
	BEGIN 
		GetStackedScreenElementPos Y id = <piece_id> 
		CreateScreenElement { 
			parent = <anchor_id> 
			type = SpriteElement 
			texture = <middle_texture> 
			rgba = <bg_piece_rgba> 
			scale = <scale> 
			pos = <pos> 
			just = [ left top ] 
		} 
		piece_id = <id> 
		IF GotParam hide_line 
			CreateScreenElement { 
				parent = <piece_id> 
				type = SpriteElement 
				texture = white2 
				scale = PAIR(31.50000000000, 4.00000000000) 
				pos = PAIR(0.00000000000, 0.00000000000) 
				rgba = [ 10 10 10 128 ] 
				just = [ left top ] 
			} 
		ENDIF 
	REPEAT <parts> 
	GetStackedScreenElementPos Y id = <piece_id> 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <anchor_id> 
		id = <bottom_id> 
		texture = <bottom_texture> 
		scale = <scale> 
		rgba = <bg_piece_rgba> 
		pos = <pos> 
		just = [ left top ] 
	} 
ENDSCRIPT

SCRIPT edit_skater_menu_create_tab tab_id = edit_skater_menu_tab parent = edit_skater_anchor_middle 
	CreateScreenElement { 
		parent = <parent> 
		type = SpriteElement 
		id = <tab_id> 
		texture = <texture> 
		scale = <scale> 
		rgba = <rgba> 
		pos = PAIR(50.00000000000, 95.00000000000) 
		just = [ left top ] 
	} 
	IF GotParam hide_line 
		CreateScreenElement { 
			parent = <id> 
			type = SpriteElement 
			texture = white2 
			scale = PAIR(31.50000000000, 4.00000000000) 
			pos = PAIR(0.00000000000, 4.00000000000) 
			rgba = [ 10 10 10 128 ] 
			just = [ left top ] 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT edit_skater_menu_exit 
	change edit_skater_menu_level_1_index = 0 
	change edit_skater_menu_level_2_index = 0 
	IF ( was_goofy = 1 ) 
		GetCurrentSkaterProfileIndex 
		GetSkaterProfileInfo player = <currentskaterprofileindex> 
		change was_goofy = 0 
		SetSkaterProfileInfo player = <currentskaterprofileindex> params = { stance = goofy } 
		RefreshSkaterModel skater = 0 profile = <currentskaterprofileindex> no_board = no_board 
	ENDIF 
	IF ObjectExists id = edit_skater_anchor 
		DestroyScreenElement id = edit_skater_anchor 
		wait 1 frame 
	ENDIF 
	MakeSkaterGoto SkateShopAI params = { } 
	IF GotParam to_secrets 
		create_secrets_menu 
	ELSE 
		IF LevelIs load_CAS 
			create_pre_cas_menu 
		ELSE 
			GoalManager_ShowPoints 
			IF NOT GoalManager_HasActiveGoals 
				GoalManager_ShowGoalPoints 
			ENDIF 
			create_options_menu 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT edit_skater_menu_focus_with_icon rgba = [ 128 128 128 50 ] 
	GetTags 
	FormatText ChecksumName = text_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	SetScreenElementProps { 
		id = { <id> child = 1 } 
		rgba = <rgba> 
	} 
	RunScriptOnScreenElement id = { <id> child = 2 } edit_skater_show_icon 
	SetScreenElementProps { 
		id = { <id> child = 0 } 
		rgba = <text_rgba> 
	} 
ENDSCRIPT

SCRIPT edit_skater_menu_unfocus_with_icon rgba = [ 128 128 128 0 ] 
	GetTags 
	FormatText ChecksumName = text_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	SetScreenElementProps { 
		id = { <id> child = 1 } 
		rgba = <rgba> 
	} 
	RunScriptOnScreenElement id = { <id> child = 2 } edit_skater_hide_icon 
	SetScreenElementProps { 
		id = { <id> child = 0 } 
		rgba = <text_rgba> 
	} 
ENDSCRIPT

SCRIPT edit_skater_menu_focus_with_deck_icon rgba = [ 128 128 128 50 ] 
	GetTags 
	FormatText ChecksumName = text_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	SetScreenElementProps { 
		id = { <id> child = 1 } 
		rgba = <rgba> 
	} 
	RunScriptOnScreenElement id = { <id> child = 2 } edit_skater_show_deck_icon 
	SetScreenElementProps { 
		id = { <id> child = 0 } 
		rgba = <text_rgba> 
	} 
ENDSCRIPT

SCRIPT edit_skater_menu_logo_focus 
	GetTags 
	IF ScreenElementExists id = { <id> child = 2 } 
		DoScreenElementMorph { 
			id = { <id> child = 2 } 
			alpha = 0.80000001192 
		} 
	ENDIF 
	edit_skater_menu_focus <...> 
ENDSCRIPT

SCRIPT edit_skater_menu_logo_unfocus 
	GetTags 
	IF ScreenElementExists id = { <id> child = 2 } 
		DoScreenElementMorph { 
			id = { <id> child = 2 } 
			alpha = 0.30000001192 
		} 
	ENDIF 
	edit_skater_menu_unfocus <...> 
ENDSCRIPT

SCRIPT edit_skater_show_icon 
	wait 3 gameframe 
	DoMorph scale = PAIR(0.00000000000, 1.00000000000) alpha = 0 
	DoMorph scale = PAIR(1.00000000000, 1.00000000000) time = 0.15000000596 alpha = 1.00000000000 
ENDSCRIPT

SCRIPT edit_skater_show_deck_icon 
	GetCurrentSkaterProfileIndex 
	IF GetPlayerAppearancePart profile = <currentskaterprofileindex> player = 0 part = cad_graphic 
		printstruct <...> 
		IF ( <desc_id> = None ) 
			SetProps just = [ left top ] 
			DoMorph scale = PAIR(1.00000000000, 0.00000000000) alpha = 0 rot_angle = -90 pos = PAIR(-120.00000000000, 25.00000000000) 
			wait 3 gameframe 
			DoMorph scale = 1 time = 0.15000000596 alpha = 1.00000000000 
		ELSE 
			SetProps just = [ left top ] 
			DoMorph scale = PAIR(0.30000001192, 0.00000000000) alpha = 0 rot_angle = -90 pos = PAIR(-120.00000000000, 10.00000000000) 
			wait 3 gameframe 
			DoMorph scale = PAIR(0.30000001192, 0.40000000596) time = 0.15000000596 alpha = 1.00000000000 
		ENDIF 
	ELSE 
		SetProps just = [ left top ] 
		DoMorph scale = PAIR(1.00000000000, 0.00000000000) alpha = 0 rot_angle = -90 pos = PAIR(-120.00000000000, 25.00000000000) 
		wait 3 gameframe 
		DoMorph scale = 1 time = 0.15000000596 alpha = 1.00000000000 
	ENDIF 
ENDSCRIPT

SCRIPT edit_skater_hide_icon 
	DoMorph scale = 0 relative_scale 
ENDSCRIPT

SCRIPT edit_skater_menu_focus rgba = [ 128 118 0 128 ] 
	GetTags 
	FormatText ChecksumName = text_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	SetScreenElementProps { 
		id = { <id> child = 1 } 
		rgba = [ 128 128 128 50 ] 
	} 
	SetScreenElementProps { 
		id = { <id> child = 0 } 
		rgba = <text_rgba> 
	} 
	generic_menu_update_arrows { 
		up_arrow_id = edit_skater_menu_up_arrow 
		down_arrow_id = edit_skater_menu_down_arrow 
	} 
	edit_skater_vmenu : GetTags 
	IF GotParam arrow_id 
		menu_vert_blink_arrow { id = <arrow_id> } 
	ENDIF 
ENDSCRIPT

SCRIPT edit_skater_menu_unfocus 
	GetTags 
	IF NOT GotParam text_rgba 
		FormatText ChecksumName = text_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	ENDIF 
	SetScreenElementProps { 
		id = { <id> child = 1 } 
		rgba = [ 128 128 128 0 ] 
	} 
	SetScreenElementProps { 
		id = { <id> child = 0 } 
		rgba = <text_rgba> 
	} 
ENDSCRIPT

SCRIPT edit_skater_info_focus 
	GetTags 
	FormatText ChecksumName = text_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = bg_rgba "%i_BG_PARTS_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	IF NOT GotParam no_bg 
		SetScreenElementProps { id = { <id> child = 1 } rgba = <bg_rgba> } 
		SetScreenElementProps { id = { <id> child = 2 } rgba = <text_rgba> } 
		SetScreenElementProps { id = { <id> child = 0 } rgba = <text_rgba> } 
		IF NOT GotParam top_row 
			SetScreenElementProps { id = { <id> child = 3 } rgba = <text_rgba> } 
			SetScreenElementProps { id = { <id> child = 4 } rgba = <text_rgba> } 
		ENDIF 
		IF ScreenElementExists id = { <id> child = 5 } 
			DoScreenElementMorph { id = { <id> child = 5 } alpha = 0.69999998808 } 
		ELSE 
			DoScreenElementMorph { id = { <id> child = 3 } alpha = 0.69999998808 } 
		ENDIF 
	ELSE 
		SetScreenElementProps { id = { <id> child = 0 } rgba = <text_rgba> } 
	ENDIF 
ENDSCRIPT

SCRIPT edit_skater_info_unfocus bg_rgba = [ 128 128 128 60 ] 
	GetTags 
	FormatText ChecksumName = text_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	IF NOT GotParam no_bg 
		SetScreenElementProps { id = { <id> child = 1 } rgba = <bg_rgba> } 
		SetScreenElementProps { id = { <id> child = 2 } rgba = <text_rgba> } 
		IF NOT GotParam top_row 
			SetScreenElementProps { id = { <id> child = 3 } rgba = [ 0 0 0 0 ] } 
			SetScreenElementProps { id = { <id> child = 4 } rgba = [ 0 0 0 0 ] } 
		ENDIF 
		IF ScreenElementExists id = { <id> child = 5 } 
			DoScreenElementMorph { id = { <id> child = 5 } alpha = 0.00000000000 } 
		ELSE 
			DoScreenElementMorph { id = { <id> child = 3 } alpha = 0.00000000000 } 
		ENDIF 
	ENDIF 
	SetScreenElementProps { id = { <id> child = 0 } rgba = <text_rgba> } 
ENDSCRIPT

SCRIPT change_current_part_highlight 
	FormatText ChecksumName = rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	index = 0 
	BEGIN 
		IF ScreenElementExists id = { current_menu child = { <index> child = 0 } } 
			SetScreenElementProps { id = { current_menu child = { <index> child = 0 } } 
				rgba = <rgba> 
			} 
			SetScreenElementProps { id = { current_menu child = <index> } 
				event_handlers = [ { unfocus <unfocus_script> params = { <unfocus_params> text_rgba = <rgba> } } ] 
				replace_handlers 
			} 
		ELSE 
			BREAK 
		ENDIF 
		index = ( <index> + 1 ) 
	REPEAT 
	SetScreenElementProps { id = { <id> child = 0 } 
		rgba = CASCURRENTCOLOR 
	} 
	SetScreenElementProps { id = <id> 
		event_handlers = [ { unfocus <unfocus_script> params = { <unfocus_params> text_rgba = CASCURRENTCOLOR } } ] 
		replace_handlers 
	} 
ENDSCRIPT

SCRIPT build_cas_category_menu scale = 0.50000000000 
	IF ( in_deck_design = 1 ) 
		RETURN 
	ENDIF 
	IF NOT LevelIs load_CAS 
		RETURN 
	ENDIF 
	FormatText ChecksumName = rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	CreateScreenElement { 
		type = hmenu 
		parent = edit_skater_anchor_middle 
		id = category_anchor 
		pos = PAIR(110.00000000000, 100.00000000000) 
		just = [ left top ] 
		padding_scale = 0.50000000000 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = category_anchor 
		texture = ED_head 
		scale = <scale> 
		just = [ left center ] 
		rgba = <rgba> 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = category_anchor 
		texture = ED_torso 
		scale = <scale> 
		just = [ left center ] 
		rgba = <rgba> 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = category_anchor 
		texture = ED_legs 
		scale = <scale> 
		just = [ left center ] 
		rgba = <rgba> 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = category_anchor 
		texture = ED_tat 
		scale = <scale> 
		just = [ left center ] 
		rgba = <rgba> 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = category_anchor 
		texture = ED_resize 
		scale = <scale> 
		just = [ left center ] 
		rgba = <rgba> 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = category_anchor 
		texture = ED_pads 
		scale = <scale> 
		just = [ left center ] 
		rgba = <rgba> 
	} 
	CreateScreenElement { 
		type = ContainerElement 
		parent = edit_skater_anchor_middle 
		id = category_button_anchor 
		pos = PAIR(110.00000000000, 100.00000000000) 
		dims = PAIR(300.00000000000, 10.00000000000) 
		just = [ left top ] 
		internal_just = [ center top ] 
	} 
	CreateScreenElement { 
		type = TextElement 
		parent = category_button_anchor 
		text = "\\bo" 
		font = dialog 
		just = [ left center ] 
		pos = PAIR(-20.00000000000, 18.00000000000) 
		alpha = 0.80000001192 
		z_priority = 4 
	} 
	CreateScreenElement { 
		type = TextElement 
		parent = category_button_anchor 
		text = "\\bp" 
		font = dialog 
		just = [ left center ] 
		pos = PAIR(158.00000000000, 18.00000000000) 
		alpha = 0.80000001192 
		z_priority = 4 
	} 
ENDSCRIPT

SCRIPT category_menu_set_focus 
	IF ( in_deck_design = 1 ) 
		RETURN 
	ENDIF 
	IF NOT LevelIs load_CAS 
		RETURN 
	ENDIF 
	FormatText ChecksumName = on_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = off_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	index = 0 
	BEGIN 
		DoScreenElementMorph id = { category_anchor child = <index> } rgba = <off_rgba> scale = 0.50000000000 
		index = ( <index> + 1 ) 
	REPEAT 6 
	IF NOT ( current_cas_category = 0 ) 
		child = ( current_cas_category - 1 ) 
		DoScreenElementMorph id = { category_anchor child = <child> } rgba = <on_rgba> scale = 0.69999998808 
	ENDIF 
ENDSCRIPT

cas_cam_angle = 0 
cas_cam_target_x = 0 
cas_cam_target_y = 0 
cas_cam_target_z = 0 
cas_cam_pos_x = 0 
cas_cam_pos_y = 0 
cas_cam_pos_z = 0 
SCRIPT cas_setup_rotating_camera 
	skater : Obj_GetID 
	default_target_vector = VECTOR(-25.00000000000, 35.00000000000, 0.00000000000) default_pos_vector = VECTOR(0.00000000000, 30.00000000000, 85.00000000000) 
	IF GotParam cam_anim 
		SWITCH <cam_anim> 
			CASE head 
				target_vector = VECTOR(-14.00000000000, 65.00000000000, 0.00000000000) pos_vector = VECTOR(0.00000000000, 0.00000000000, 35.00000000000) 
			CASE HeadTop 
				target_vector = VECTOR(-14.00000000000, 65.00000000000, 0.00000000000) pos_vector = VECTOR(0.00000000000, 20.00000000000, 25.00000000000) 
			CASE torso 
				target_vector = VECTOR(-18.00000000000, 50.00000000000, 0.00000000000) pos_vector = VECTOR(0.00000000000, 0.00000000000, 45.00000000000) 
			CASE AdjTorso 
				target_vector = VECTOR(-14.00000000000, 50.00000000000, 0.00000000000) pos_vector = VECTOR(0.00000000000, 0.00000000000, 45.00000000000) 
			CASE legs 
				target_vector = VECTOR(-17.00000000000, 20.00000000000, 0.00000000000) pos_vector = VECTOR(0.00000000000, 25.00000000000, 55.00000000000) 
			CASE LegTattoo 
				target_vector = VECTOR(-20.00000000000, 10.00000000000, 0.00000000000) pos_vector = VECTOR(0.00000000000, 15.00000000000, 45.00000000000) 
			CASE AdjLegTattoo 
				target_vector = VECTOR(-16.00000000000, 10.00000000000, 0.00000000000) pos_vector = VECTOR(0.00000000000, 15.00000000000, 45.00000000000) 
			CASE Feet 
				target_vector = VECTOR(-14.00000000000, 5.00000000000, 0.00000000000) pos_vector = VECTOR(0.00000000000, 10.00000000000, 45.00000000000) 
			CASE fullbody 
				target_vector = <default_target_vector> pos_vector = <default_pos_vector> 
			DEFAULT 
				target_vector = <default_target_vector> pos_vector = <default_pos_vector> 
		ENDSWITCH 
	ELSE 
		target_vector = <default_target_vector> pos_vector = <default_pos_vector> 
	ENDIF 
	change cas_cam_target_x = ( <target_vector> . VECTOR(1.00000000000, 0.00000000000, 0.00000000000) ) 
	change cas_cam_target_y = ( <target_vector> . VECTOR(0.00000000000, 1.00000000000, 0.00000000000) ) 
	change cas_cam_target_z = ( <target_vector> . VECTOR(0.00000000000, 0.00000000000, 1.00000000000) ) 
	change cas_cam_pos_x = ( <pos_vector> . VECTOR(1.00000000000, 0.00000000000, 0.00000000000) ) 
	change cas_cam_pos_y = ( <pos_vector> . VECTOR(0.00000000000, 1.00000000000, 0.00000000000) ) 
	change cas_cam_pos_z = ( <pos_vector> . VECTOR(0.00000000000, 0.00000000000, 1.00000000000) ) 
	get_rotated_vector vector = <target_vector> 
	t_off = <vector> 
	get_rotated_vector vector = <pos_vector> 
	p_off = <vector> 
	killskatercamanim all 
	PlaySkaterCamAnim { skater = 0 
		targetID = <objId> 
		targetOffset = <t_off> 
		positionOffset = <p_off> 
		play_hold 
		frames = 1 
		virtual_cam 
	} 
ENDSCRIPT

SCRIPT cas_rotate_camera_left dif = 3 button = L1 
	skater : Obj_GetID 
	BEGIN 
		IF ControllerPressed <button> 
			change cas_cam_angle = ( cas_cam_angle + <dif> ) 
			IF ( cas_cam_angle > 180 ) 
				change cas_cam_angle = ( cas_cam_angle - 360 ) 
			ELSE 
				IF ( -180 > cas_cam_angle ) 
					change cas_cam_angle = ( cas_cam_angle + 360 ) 
				ENDIF 
			ENDIF 
			target_vector = ( cas_cam_target_x * VECTOR(1.00000000000, 0.00000000000, 0.00000000000) + cas_cam_target_y * VECTOR(0.00000000000, 1.00000000000, 0.00000000000) + cas_cam_target_z * VECTOR(0.00000000000, 0.00000000000, 1.00000000000) ) 
			pos_vector = ( cas_cam_pos_x * VECTOR(1.00000000000, 0.00000000000, 0.00000000000) + cas_cam_pos_y * VECTOR(0.00000000000, 1.00000000000, 0.00000000000) + cas_cam_pos_z * VECTOR(0.00000000000, 0.00000000000, 1.00000000000) ) 
			get_rotated_vector vector = <target_vector> 
			t_off = <vector> 
			get_rotated_vector vector = <pos_vector> 
			p_off = <vector> 
			killskatercamanim all 
			PlaySkaterCamAnim { skater = 0 
				targetID = <objId> 
				targetOffset = <t_off> 
				positionOffset = <p_off> 
				play_hold 
				frames = 1 
				virtual_cam 
			} 
		ELSE 
			BREAK 
		ENDIF 
		wait 1 gameframe 
	REPEAT 
ENDSCRIPT

SCRIPT cas_rotate_camera_right dif = -3 button = R1 
	cas_rotate_camera_left dif = <dif> button = <button> <...> 
ENDSCRIPT

SCRIPT cas_rotate_camera_to_angle dif = 6 angle = 0 
	skater : Obj_GetID 
	BEGIN 
		IF NOT ( cas_cam_angle = <angle> ) 
			IF ( ( <angle> > cas_cam_angle ) & ( ( cas_cam_angle + <dif> ) > <angle> ) ) 
				change cas_cam_angle = <angle> 
			ELSE 
				change cas_cam_angle = ( cas_cam_angle + <dif> ) 
			ENDIF 
			IF ( cas_cam_angle > 180 ) 
				change cas_cam_angle = ( cas_cam_angle - 360 ) 
			ELSE 
				IF ( -180 > cas_cam_angle ) 
					change cas_cam_angle = ( cas_cam_angle + 360 ) 
				ENDIF 
			ENDIF 
			target_vector = ( cas_cam_target_x * VECTOR(1.00000000000, 0.00000000000, 0.00000000000) + cas_cam_target_y * VECTOR(0.00000000000, 1.00000000000, 0.00000000000) + cas_cam_target_z * VECTOR(0.00000000000, 0.00000000000, 1.00000000000) ) 
			pos_vector = ( cas_cam_pos_x * VECTOR(1.00000000000, 0.00000000000, 0.00000000000) + cas_cam_pos_y * VECTOR(0.00000000000, 1.00000000000, 0.00000000000) + cas_cam_pos_z * VECTOR(0.00000000000, 0.00000000000, 1.00000000000) ) 
			get_rotated_vector vector = <target_vector> 
			t_off = <vector> 
			get_rotated_vector vector = <pos_vector> 
			p_off = <vector> 
			killskatercamanim all 
			PlaySkaterCamAnim { skater = 0 
				targetID = <objId> 
				targetOffset = <t_off> 
				positionOffset = <p_off> 
				play_hold 
				frames = 1 
				virtual_cam 
			} 
		ELSE 
			BREAK 
		ENDIF 
		wait 1 gameframe 
	REPEAT 
ENDSCRIPT

SCRIPT get_rotated_vector 
	X = ( <vector> . VECTOR(1.00000000000, 0.00000000000, 0.00000000000) ) 
	Y = ( <vector> . VECTOR(0.00000000000, 1.00000000000, 0.00000000000) ) 
	z = ( <vector> . VECTOR(0.00000000000, 0.00000000000, 1.00000000000) ) 
	cos cas_cam_angle 
	sin cas_cam_angle 
	x2 = ( <X> * <cos> - <z> * <sin> ) 
	y2 = <Y> 
	z2 = ( <X> * <sin> + <z> * <cos> ) 
	vector = ( VECTOR(1.00000000000, 0.00000000000, 0.00000000000) * <x2> + VECTOR(0.00000000000, 1.00000000000, 0.00000000000) * <y2> + VECTOR(0.00000000000, 0.00000000000, 1.00000000000) * <z2> ) 
	RETURN vector = <vector> 
ENDSCRIPT

SCRIPT spawn_cas_pull_back_camera 
	IF ( pulled_back = 0 ) 
		killspawnedscript name = cas_pull_back_camera 
		change pulled_back = 0 
		spawnscript cas_pull_back_camera 
	ENDIF 
ENDSCRIPT

pulled_back = 0 
SCRIPT cas_pull_back_camera 
	printf "script cas_pull_back_camera" 
	change pulled_back = 1 
	skater : Obj_GetID 
	target_vector = VECTOR(-25.00000000000, 35.00000000000, 0.00000000000) pos_vector = VECTOR(0.00000000000, 30.00000000000, 85.00000000000) 
	get_rotated_vector vector = <target_vector> 
	t_off = <vector> 
	get_rotated_vector vector = <pos_vector> 
	p_off = <vector> 
	cas_cam_target_x2 = ( cas_cam_target_x + 0 ) 
	cas_cam_target_y2 = ( cas_cam_target_y + 0 ) 
	cas_cam_target_z2 = ( cas_cam_target_z + 0 ) 
	cas_cam_pos_x2 = ( cas_cam_pos_x + 0 ) 
	cas_cam_pos_y2 = ( cas_cam_pos_y + 0 ) 
	cas_cam_pos_z2 = ( cas_cam_pos_z + 0 ) 
	change cas_cam_target_x = ( <target_vector> . VECTOR(1.00000000000, 0.00000000000, 0.00000000000) ) 
	change cas_cam_target_y = ( <target_vector> . VECTOR(0.00000000000, 1.00000000000, 0.00000000000) ) 
	change cas_cam_target_z = ( <target_vector> . VECTOR(0.00000000000, 0.00000000000, 1.00000000000) ) 
	change cas_cam_pos_x = ( <pos_vector> . VECTOR(1.00000000000, 0.00000000000, 0.00000000000) ) 
	change cas_cam_pos_y = ( <pos_vector> . VECTOR(0.00000000000, 1.00000000000, 0.00000000000) ) 
	change cas_cam_pos_z = ( <pos_vector> . VECTOR(0.00000000000, 0.00000000000, 1.00000000000) ) 
	pulse_blur 
	killskatercamanim all 
	PlaySkaterCamAnim { skater = 0 
		targetID = <objId> 
		targetOffset = <t_off> 
		positionOffset = <p_off> 
		play_hold 
		frames = 1 
		virtual_cam 
	} 
	wait 0.30000001192 seconds 
	BEGIN 
		IF isPS2 
			IF NOT ControllerPressed R2 
				BREAK 
			ENDIF 
		ENDIF 
		IF IsXBox 
			IF NOT ControllerPressed black 
				BREAK 
			ENDIF 
		ENDIF 
		IF isNGC 
			IF NOT ControllerPressed z 
				BREAK 
			ENDIF 
		ENDIF 
		wait 1 gameframe 
	REPEAT 
	change cas_cam_target_x = <cas_cam_target_x2> 
	change cas_cam_target_y = <cas_cam_target_y2> 
	change cas_cam_target_z = <cas_cam_target_z2> 
	change cas_cam_pos_x = <cas_cam_pos_x2> 
	change cas_cam_pos_y = <cas_cam_pos_y2> 
	change cas_cam_pos_z = <cas_cam_pos_z2> 
	target_vector = ( cas_cam_target_x * VECTOR(1.00000000000, 0.00000000000, 0.00000000000) + cas_cam_target_y * VECTOR(0.00000000000, 1.00000000000, 0.00000000000) + cas_cam_target_z * VECTOR(0.00000000000, 0.00000000000, 1.00000000000) ) 
	pos_vector = ( cas_cam_pos_x * VECTOR(1.00000000000, 0.00000000000, 0.00000000000) + cas_cam_pos_y * VECTOR(0.00000000000, 1.00000000000, 0.00000000000) + cas_cam_pos_z * VECTOR(0.00000000000, 0.00000000000, 1.00000000000) ) 
	get_rotated_vector vector = <target_vector> 
	t_off = <vector> 
	get_rotated_vector vector = <pos_vector> 
	p_off = <vector> 
	pulse_blur 
	killskatercamanim all 
	PlaySkaterCamAnim { skater = 0 
		targetID = <objId> 
		targetOffset = <t_off> 
		positionOffset = <p_off> 
		play_hold 
		frames = 1 
		virtual_cam 
	} 
	wait 0.30000001192 seconds 
	change pulled_back = 0 
ENDSCRIPT

goto_face_menu = 0 
face_map_points_saved = 0 
SCRIPT launch_face_menu 
	load_cas_textures_to_main_memory 
	create_face_map_menu downloaded_face = <downloaded_face> goto_face_map = <goto_face_map> 
ENDSCRIPT

original_model_face_points = { 
	left_eye = [ 49 54 ] 
	right_eye = [ 79 54 ] 
	nose = [ 64 75 ] 
	lips = [ 64 89 ] 
	width = 128 
	height = 128 
} 
in_deck_design = 0 
SCRIPT create_deck_design_menu 
	printf "script create_deck_design_menu" 
	pulse_blur 
	change goto_cad = 0 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	SetScreenElementLock id = root_window off 
	CreateScreenElement { 
		type = ContainerElement 
		parent = root_window 
		id = edit_skater_anchor 
		pos = PAIR(320.00000000000, 200.00000000000) 
		dims = PAIR(640.00000000000, 480.00000000000) 
	} 
	AssignAlias id = edit_skater_anchor alias = current_menu_anchor 
	kill_start_key_binding 
	CreateScreenElement { 
		type = ContainerElement 
		parent = edit_skater_anchor 
		id = edit_skater_anchor_top 
		pos = PAIR(320.00000000000, 240.00000000000) 
		dims = PAIR(640.00000000000, 480.00000000000) 
	} 
	edit_skater_create_top_bar scale = PAIR(1.00000000000, 1.00000000000) parent = edit_skater_anchor_top text = "DECK DESIGN" 
	edit_skater_create_main_deck_menu <...> 
	IF GotParam animate 
	ENDIF 
ENDSCRIPT

was_goofy = 0 
SCRIPT cad_camera 
	change in_deck_design = 1 
	wait 4 gameframes 
	GoalManager_HidePoints 
	GoalManager_HideGoalPoints 
	IF GotParam wait_for_skater 
		skater : pausePhysics 
		MakeSkaterGoto SkateShopAI params = { NOSFX CAS_Screen } 
		skater : SwitchOnBoard 
		skater : PlayAnim Anim = BoardPlacement BlendPeriod = 0 cycle 
		skater : Obj_MoveToNode name = cad_deck_spot orient 
		skater : Obj_ShadowOff 
	ENDIF 
	killskatercamanim all 
	PlaySkaterCamAnim play_hold name = map_deck_intro_cam01 
	IF GotParam at_cad_menu 
		FireEvent type = focus target = current_menu data = { grid_index = edit_skater_menu_level_1_index } 
	ENDIF 
ENDSCRIPT

in_cad_cutscene_sequence = 0 

