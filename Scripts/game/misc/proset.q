
toggle_comp_geo_params = { 
	flag = FLAG_G_COMP_GEO_ON 
	geo_prefix = "G_COMP_" 
	trg_prefix = "TRG_G_COMP_" 
	geo_not_prefix = "G_COMPNOT_" 
	trg_not_prefix = "TRG_G_COMPNOT_" 
	text_on = "Competition Geo: ON" 
	text_off = "Competition Geo: OFF" 
	text_locked = "Competition Geo: LOCKED" 
	id = toggle_comp_geo 
	node = trg_G_COMP_restartnode 
camera = G_COMP_viewcam } 
toggle_proset1_params = { 
	bit = 0 
	param_id = toggle_proset1_params 
	flag = FLAG_PROSET1_GEO_ON 
	geo_prefix = "Proset1_" 
	trg_prefix = "TRG_Proset1_" 
	geo_not_prefix = "PROSET1NOT_" 
	trg_not_prefix = "TRG_PROSET1NOT_" 
	text_on = "ProSet1: ON" 
	text_off = "ProSet1: OFF" 
	text_locked = "ProSet1: LOCKED" 
	id = toggle_proset1 
	node = trg_Proset1_restartnode 
camera = PROSET1_viewcam } 
toggle_proset2_params = { 
	bit = 1 
	param_id = toggle_proset2_params 
	flag = FLAG_PROSET2_GEO_ON 
	geo_prefix = "Proset2_" 
	trg_prefix = "TRG_Proset2_" 
	geo_not_prefix = "PROSET2NOT_" 
	trg_not_prefix = "TRG_PROSET2NOT_" 
	text_on = "ProSet2: ON" 
	text_off = "ProSet2: OFF" 
	text_locked = "ProSet2: LOCKED" 
	id = toggle_proset2 
	node = trg_Proset2_restartnode 
camera = PROSET2_viewcam } 
toggle_proset3_params = { 
	bit = 2 
	param_id = toggle_proset3_params 
	flag = FLAG_PROSET3_GEO_ON 
	geo_prefix = "Proset3_" 
	trg_prefix = "TRG_Proset3_" 
	geo_not_prefix = "PROSET3NOT_" 
	trg_not_prefix = "TRG_PROSET3NOT_" 
	text_on = "ProSet3: ON" 
	text_off = "ProSet3: OFF" 
	text_locked = "ProSet3: LOCKED" 
	id = toggle_proset3 
	node = trg_Proset3_restartnode 
camera = PROSET3_viewcam } 
toggle_proset4_params = { 
	bit = 3 
	param_id = toggle_proset4_params 
	flag = FLAG_PROSET4_GEO_ON 
	geo_prefix = "Proset4_" 
	trg_prefix = "TRG_Proset4_" 
	geo_not_prefix = "PROSET4NOT_" 
	trg_not_prefix = "TRG_PROSET4NOT_" 
	text_on = "ProSet4: ON" 
	text_off = "ProSet4: OFF" 
	text_locked = "ProSet4: LOCKED" 
	id = toggle_proset4 
	node = trg_Proset4_restartnode 
camera = PROSET4_viewcam } 
toggle_proset5_params = { 
	bit = 4 
	param_id = toggle_proset5_params 
	flag = FLAG_PROSET5_GEO_ON 
	geo_prefix = "Proset5_" 
	trg_prefix = "TRG_Proset5_" 
	geo_not_prefix = "PROSET5NOT_" 
	trg_not_prefix = "TRG_PROSET5NOT_" 
	text_on = "ProSet5: ON" 
	text_off = "ProSet5: OFF" 
	text_locked = "ProSet5: LOCKED" 
	id = toggle_proset5 
	node = trg_Proset5_restartnode 
camera = PROSET5_viewcam } 
toggle_proset6_params = { 
	bit = 5 
	param_id = toggle_proset6_params 
	flag = FLAG_PROSET6_GEO_ON 
	geo_prefix = "Proset6_" 
	trg_prefix = "TRG_Proset6_" 
	geo_not_prefix = "PROSET6NOT_" 
	trg_not_prefix = "TRG_PROSET6NOT_" 
	text_on = "ProSet6: ON" 
	text_off = "ProSet6: OFF" 
	text_locked = "ProSet6: LOCKED" 
	id = toggle_proset6 
	node = trg_Proset6_restartnode 
camera = PROSET6_viewcam } 
toggle_proset7_params = { 
	bit = 6 
	param_id = toggle_proset7_params 
	flag = FLAG_PROSET7_GEO_ON 
	geo_prefix = "Proset7_" 
	trg_prefix = "TRG_Proset7_" 
	geo_not_prefix = "PROSET7NOT_" 
	trg_not_prefix = "TRG_PROSET7NOT_" 
	text_on = "ProSet7: ON" 
	text_off = "ProSet7: OFF" 
	text_locked = "ProSet7: LOCKED" 
	id = toggle_proset7 
	node = trg_Proset7_restartnode 
camera = PROSET7_viewcam } 
SCRIPT create_pro_trick_objects_menu 
	RunScriptOnScreenElement id = current_menu_anchor menu_offscreen callback = create_pro_trick_objects_menu2 
ENDSCRIPT

SCRIPT create_pro_trick_objects_menu2 
	FormatText ChecksumName = title_icon "%i_pro" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	make_new_themed_sub_menu title = "PRO TRICKS" title_icon = <title_icon> 
	SetScreenElementProps { id = sub_menu 
		event_handlers = [ 
			{ pad_back generic_menu_pad_back params = { callback = exit_pro_trick_menu } } 
		] 
	} 
	IF NOT CD 
		IF NOT InNetGame 
			theme_menu_add_item text = "Competition Geo: OFF" id = toggle_comp_geo pad_choose_script = toggle_geo pad_choose_params = toggle_comp_geo_params focus_script = preview_geo focus_params = toggle_comp_geo_params pad_circle_script = goto_geo pad_circle_params = toggle_comp_geo_params 
			check_geo toggle_comp_geo_params 
		ENDIF 
	ENDIF 
	theme_menu_add_item { 
		text = "ProSet1: OFF" 
		id = toggle_proset1 
		pad_choose_script = toggle_geo 
		pad_choose_params = toggle_proset1_params 
		focus_script = preview_geo 
		focus_params = toggle_proset1_params 
		pad_circle_script = goto_geo 
		pad_circle_params = toggle_proset1_params 
	} 
	theme_menu_add_item { 
		text = "ProSet2: OFF" 
		id = toggle_proset2 
		pad_choose_script = toggle_geo 
		pad_choose_params = toggle_proset2_params 
		focus_script = preview_geo 
		focus_params = toggle_proset2_params 
		pad_circle_script = goto_geo 
		pad_circle_params = toggle_proset2_params 
	} 
	theme_menu_add_item { 
		text = "ProSet3: OFF" 
		id = toggle_proset3 
		pad_choose_script = toggle_geo 
		pad_choose_params = toggle_proset3_params 
		focus_script = preview_geo 
		focus_params = toggle_proset3_params 
		pad_circle_script = goto_geo 
		pad_circle_params = toggle_proset3_params 
	} 
	theme_menu_add_item { 
		text = "ProSet4: OFF" 
		id = toggle_proset4 
		pad_choose_script = toggle_geo 
		pad_choose_params = toggle_proset4_params 
		focus_script = preview_geo 
		focus_params = toggle_proset4_params 
		pad_circle_script = goto_geo 
		pad_circle_params = toggle_proset4_params 
	} 
	theme_menu_add_item { 
		text = "ProSet5: OFF" 
		id = toggle_proset5 
		pad_choose_script = toggle_geo 
		pad_choose_params = toggle_proset5_params 
		focus_script = preview_geo 
		focus_params = toggle_proset5_params 
		pad_circle_script = goto_geo 
		pad_circle_params = toggle_proset5_params 
	} 
	theme_menu_add_item { 
		text = "ProSet6: OFF" 
		id = toggle_proset6 
		pad_choose_script = toggle_geo 
		pad_choose_params = toggle_proset6_params 
		focus_script = preview_geo 
		focus_params = toggle_proset6_params 
		pad_circle_script = goto_geo 
		pad_circle_params = toggle_proset6_params 
	} 
	theme_menu_add_item { 
		text = "ProSet7: OFF" 
		id = toggle_proset7 
		pad_choose_script = toggle_geo 
		pad_choose_params = toggle_proset7_params 
		focus_script = preview_geo 
		focus_params = toggle_proset7_params 
		pad_circle_script = goto_geo 
		pad_circle_params = toggle_proset7_params 
	} 
	theme_menu_add_item { 
		text = "Done" 
		id = menu_done 
		pad_choose_script = exit_pro_trick_menu 
		last_menu_item = 1 
	} 
	IF isTrue Bootstrap_Build 
		SetScreenElementProps text = "ProSet1: NOT IN DEMO" id = toggle_proset1 not_focusable rgba = [ 65 65 65 128 ] 
		SetScreenElementProps text = "ProSet2: NOT IN DEMO" id = toggle_proset2 not_focusable rgba = [ 65 65 65 128 ] 
		SetScreenElementProps text = "ProSet3: NOT IN DEMO" id = toggle_proset3 not_focusable rgba = [ 65 65 65 128 ] 
		SetScreenElementProps text = "ProSet5: NOT IN DEMO" id = toggle_proset5 not_focusable rgba = [ 65 65 65 128 ] 
		SetScreenElementProps text = "ProSet7: NOT IN DEMO" id = toggle_proset7 not_focusable rgba = [ 65 65 65 128 ] 
		check_geo toggle_proset4_params 
		check_geo toggle_proset6_params 
	ELSE 
		check_geo toggle_proset1_params 
		check_geo toggle_proset2_params 
		check_geo toggle_proset3_params 
		check_geo toggle_proset4_params 
		check_geo toggle_proset5_params 
		check_geo toggle_proset6_params 
		check_geo toggle_proset7_params 
	ENDIF 
	finish_themed_sub_menu 
ENDSCRIPT

SCRIPT exit_pro_trick_menu 
	kill_proset_cams 
	create_options_menu 
ENDSCRIPT

SCRIPT goto_geo 
	IF NodeExists <node> 
		ResetSkaters node_name = <node> 
	ENDIF 
	kill_proset_cams 
	exit_pause_menu 
ENDSCRIPT

SCRIPT preview_geo 
	main_theme_focus 
	kill_proset_cams 
	PlaySkaterCamAnim skater = 0 name = <camera> skippable = 1 play_hold 
	SetSkaterCamAnimShouldPause name = <camera> 0 
ENDSCRIPT

SCRIPT Pro_Pause_Game 
	PauseGame 
ENDSCRIPT

SCRIPT check_geo 
	IF isTrue ALL_LEVELS_UNLOCKED 
		create_proset_item <...> 
	ELSE 
		IF GoalManager_HasBeatenGoalWithProset <geo_prefix> 
			create_proset_item <...> 
		ELSE 
			IF InNetGame 
				IF ScreenElementExists id = <id> 
					DestroyScreenElement id = <id> 
				ENDIF 
			ELSE 
				SetScreenElementProps text = <text_locked> id = <id> not_focusable rgba = [ 65 65 65 128 ] 
			ENDIF 
		ENDIF 
	ENDIF 
	IF NodeExists <node> 
	ELSE 
		IF ScreenElementExists id = <id> 
			DestroyScreenElement id = <id> 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT create_proset_item 
	IF GetFlag flag = <flag> 
		SetScreenElementProps text = <text_on> id = <id> 
	ELSE 
		SetScreenElementProps text = <text_off> id = <id> 
	ENDIF 
ENDSCRIPT

SCRIPT toggle_geo 
	IF InNetGame 
		IF NOT OnServer 
			FCFSRequestToggleProSet bit = <bit> param_id = <param_id> 
			RETURN 
		ENDIF 
	ENDIF 
	pulse_blur start = 200 speed = 2 
	IF GetFlag flag = <flag> 
		UnSetFlag flag = <flag> 
		SetScreenElementProps text = <text_off> id = <id> 
		IF InNetGame 
			IF OnServer 
				ToggleProSet bit = <bit> param_id = <param_id> 
			ENDIF 
		ENDIF 
		kill prefix = <geo_prefix> 
		kill prefix = <trg_prefix> 
		create prefix = <geo_not_prefix> 
		create prefix = <trg_not_prefix> 
		KillAllTextureSplats 
	ELSE 
		create prefix = <geo_prefix> 
		create prefix = <trg_prefix> 
		kill prefix = <geo_not_prefix> 
		kill prefix = <trg_not_prefix> 
		SetFlag flag = <flag> 
		SetScreenElementProps text = <text_on> id = <id> 
		IF InNetGame 
			IF OnServer 
				ToggleProSet bit = <bit> param_id = <param_id> 
			ENDIF 
		ELSE 
			IF NodeExists <node> 
				ResetSkaters node_name = <node> 
			ENDIF 
		ENDIF 
	ENDIF 
	pulse_item 
ENDSCRIPT

SCRIPT toggle_geo_nomenu 
	kill prefix = <geo_prefix> 
	kill prefix = <trg_prefix> 
	kill prefix = <geo_not_prefix> 
	kill prefix = <trg_not_prefix> 
	create prefix = <geo_not_prefix> 
	create prefix = <trg_not_prefix> 
	IF GetFlag flag = <flag> 
		printf "turning it on" 
		create prefix = <geo_prefix> 
		create prefix = <trg_prefix> 
		kill prefix = <geo_not_prefix> 
		kill prefix = <trg_not_prefix> 
	ENDIF 
ENDSCRIPT

SCRIPT toggle_proset_flag 
	IF GetFlag flag = <flag> 
		UnSetFlag flag = <flag> 
		IF ObjectExists id = <id> 
			SetScreenElementProps text = <text_off> id = <id> 
		ENDIF 
	ELSE 
		SetFlag flag = <flag> 
		IF ObjectExists id = <id> 
			SetScreenElementProps text = <text_on> id = <id> 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT kill_proset_cams 
	KillSkaterCamAnim name = G_COMP_viewcam 
	KillSkaterCamAnim name = PROSET1_viewcam 
	KillSkaterCamAnim name = PROSET2_viewcam 
	KillSkaterCamAnim name = PROSET3_viewcam 
	KillSkaterCamAnim name = PROSET4_viewcam 
	KillSkaterCamAnim name = PROSET5_viewcam 
	KillSkaterCamAnim name = PROSET6_viewcam 
	KillSkaterCamAnim name = PROSET7_viewcam 
ENDSCRIPT


