
SCRIPT launch_display_options_menu 
	IF GotParam from_options 
		create_display_options_menu from_options 
	ELSE 
		create_display_options_menu 
	ENDIF 
ENDSCRIPT

SCRIPT create_display_options_menu 
	FormatText ChecksumName = title_icon "%i_special" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	make_new_themed_sub_menu title = "DISPLAY OPTIONS" title_icon = <title_icon> 
	create_helper_text { helper_text_elements = [ { text = "\\b7/\\b4 = Select" } 
			{ text = "\\bn = Back" } 
			{ text = "\\bm = Accept" } 
		] 
	} 
	SetScreenElementProps { id = sub_menu 
		event_handlers = [ 
			{ pad_back generic_menu_pad_back params = { callback = display_options_exit } } 
		] 
	} 
	IF GetGlobalFlag flag = NO_DISPLAY_HUD 
		hud_text = "Off" 
	ELSE 
		hud_text = "On" 
	ENDIF 
	theme_menu_add_item { text = "Score/Special Meter:" 
		extra_text = <hud_text> 
		id = menu_display_hud 
		pad_choose_script = toggle_display_hud 
	} 
	IF GetGlobalFlag flag = NO_DISPLAY_TRICKSTRING 
		hud_text = "Off" 
	ELSE 
		hud_text = "On" 
	ENDIF 
	theme_menu_add_item { text = "Trick String:" 
		extra_text = <hud_text> 
		id = menu_display_trickstring 
		pad_choose_script = toggle_display_trickstring 
	} 
	IF GetGlobalFlag flag = NO_DISPLAY_BASESCORE 
		hud_text = "Off" 
	ELSE 
		hud_text = "On" 
	ENDIF 
	theme_menu_add_item { text = "Base Score:" 
		extra_text = <hud_text> 
		id = menu_display_basescore 
		pad_choose_script = toggle_display_basescore 
	} 
	IF GetGlobalFlag flag = NO_DISPLAY_CHATWINDOW 
		hud_text = "Off" 
	ELSE 
		hud_text = "On" 
	ENDIF 
	IF InNetGame 
		theme_menu_add_item { text = "Chat Window:" 
			extra_text = <hud_text> 
			id = menu_display_chatwindow 
			pad_choose_script = toggle_display_chatwindow 
		} 
	ELSE 
		theme_menu_add_item { text = "Console Window:" 
			extra_text = <hud_text> 
			id = menu_display_chatwindow 
			pad_choose_script = toggle_display_chatwindow 
		} 
	ENDIF 
	IF GetGlobalFlag flag = NO_DISPLAY_BALANCE 
		hud_text = "Off" 
	ELSE 
		hud_text = "On" 
	ENDIF 
	IF InNetGame 
		IF GetGlobalFlag flag = NO_G_DISPLAY_BALANCE 
			theme_menu_add_item { text = "Balance Meters:" 
				extra_text = <hud_text> 
				id = menu_display_balance 
				pad_choose_script = toggle_display_balance 
				not_focusable = not_focusable 
			} 
		ELSE 
			theme_menu_add_item { text = "Balance Meters:" 
				extra_text = <hud_text> 
				id = menu_display_balance 
				pad_choose_script = toggle_display_balance 
			} 
		ENDIF 
	ELSE 
		theme_menu_add_item { text = "Balance Meters:" 
			extra_text = <hud_text> 
			id = menu_display_balance 
			pad_choose_script = toggle_display_balance 
		} 
	ENDIF 
	IF InNetGame 
		IF GetGlobalFlag flag = NO_DISPLAY_NET_SCORES 
			hud_text = "Off" 
		ELSE 
			hud_text = "On" 
		ENDIF 
		theme_menu_add_item { text = "Names and Scores:" 
			extra_text = <hud_text> 
			id = menu_display_net_scores 
			pad_choose_script = toggle_display_net_scores 
		} 
	ENDIF 
	IF GotParam from_options 
		theme_menu_add_item text = "Done" id = menu_done pad_choose_script = display_options_exit pad_choose_params = { from_options } last_menu_item = 1 
	ELSE 
		theme_menu_add_item text = "Done" id = menu_done pad_choose_script = display_options_exit last_menu_item = 1 
	ENDIF 
	finish_themed_sub_menu 
ENDSCRIPT

SCRIPT toggle_display_hud 
	IF NOT GetGlobalFlag flag = NO_DISPLAY_HUD 
		SetScreenElementProps id = { menu_display_hud child = 3 } text = "Off" 
		SetGlobalFlag flag = NO_DISPLAY_HUD 
	ELSE 
		SetScreenElementProps id = { menu_display_hud child = 3 } text = "On" 
		UnsetGlobalFlag flag = NO_DISPLAY_HUD 
	ENDIF 
ENDSCRIPT

SCRIPT toggle_display_trickstring 
	IF NOT GetGlobalFlag flag = NO_DISPLAY_TRICKSTRING 
		SetScreenElementProps id = { menu_display_trickstring child = 3 } text = "Off" 
		SetGlobalFlag flag = NO_DISPLAY_TRICKSTRING 
	ELSE 
		SetScreenElementProps id = { menu_display_trickstring child = 3 } text = "On" 
		UnsetGlobalFlag flag = NO_DISPLAY_TRICKSTRING 
	ENDIF 
ENDSCRIPT

SCRIPT toggle_display_basescore 
	IF NOT GetGlobalFlag flag = NO_DISPLAY_BASESCORE 
		SetScreenElementProps id = { menu_display_basescore child = 3 } text = "Off" 
		SetGlobalFlag flag = NO_DISPLAY_BASESCORE 
	ELSE 
		SetScreenElementProps id = { menu_display_basescore child = 3 } text = "On" 
		UnsetGlobalFlag flag = NO_DISPLAY_BASESCORE 
	ENDIF 
ENDSCRIPT

SCRIPT toggle_display_chatwindow 
	IF NOT GetGlobalFlag flag = NO_DISPLAY_CHATWINDOW 
		SetScreenElementProps id = { menu_display_chatwindow child = 3 } text = "Off" 
		SetGlobalFlag flag = NO_DISPLAY_CHATWINDOW 
	ELSE 
		SetScreenElementProps id = { menu_display_chatwindow child = 3 } text = "On" 
		UnsetGlobalFlag flag = NO_DISPLAY_CHATWINDOW 
	ENDIF 
ENDSCRIPT

SCRIPT toggle_display_balance 
	IF NOT GetGlobalFlag flag = NO_DISPLAY_BALANCE 
		SetScreenElementProps id = { menu_display_balance child = 3 } text = "Off" 
		SetGlobalFlag flag = NO_DISPLAY_BALANCE 
	ELSE 
		SetScreenElementProps id = { menu_display_balance child = 3 } text = "On" 
		UnsetGlobalFlag flag = NO_DISPLAY_BALANCE 
	ENDIF 
ENDSCRIPT

SCRIPT toggle_display_net_names 
	GetPreferenceString pref_type = network show_names 
	IF ( <ui_string> = "Off" ) 
		SetScreenElementProps id = { menu_display_net_names child = 3 } text = "On" 
		set_preferences_from_ui prefs = network field = "show_names" checksum = boolean_true string = "On" 
	ELSE 
		SetScreenElementProps id = { menu_display_net_names child = 3 } text = "Off" 
		set_preferences_from_ui prefs = network field = "show_names" checksum = boolean_false string = "Off" 
	ENDIF 
ENDSCRIPT

SCRIPT toggle_display_net_scores 
	IF NOT GetGlobalFlag flag = NO_DISPLAY_NET_SCORES 
		SetScreenElementProps id = { menu_display_net_scores child = 3 } text = "Off" 
		SetGlobalFlag flag = NO_DISPLAY_NET_SCORES 
	ELSE 
		SetScreenElementProps id = { menu_display_net_scores child = 3 } text = "On" 
		UnsetGlobalFlag flag = NO_DISPLAY_NET_SCORES 
	ENDIF 
ENDSCRIPT

SCRIPT display_options_exit 
	IF ScreenElementExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	IF NOT LevelIs load_skateshop 
		create_options_menu 
	ELSE 
		create_setup_options_menu 
	ENDIF 
ENDSCRIPT


