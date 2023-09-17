
SCRIPT initialize_oldskool_icons 
	GetCurrentLevel 
	SWITCH <level> 
		CASE load_nj 
			<level_num> = 1 
			FormatText ChecksumName = oldskool_icon "TRG_NJ_OLDSKOOL_ICON01" 
			<gFlag> = LEVEL_UNLOCKED_SC2 
		CASE load_hi 
			<level_num> = 5 
			FormatText ChecksumName = oldskool_icon "TRG_HI_OLDSKOOL_ICON01" 
			<gFlag> = LEVEL_UNLOCKED_VN 
		CASE load_ru 
			<level_num> = 8 
			FormatText ChecksumName = oldskool_icon "TRG_RU_OLDSKOOL_ICON01" 
			<gFlag> = LEVEL_UNLOCKED_HN 
		DEFAULT 
			RETURN 
	ENDSWITCH 
	IF NodeExists <oldskool_icon> 
		IF IsAlive name = <oldskool_icon> 
			IF GameModeEquals is_career 
				IF GetGlobalFlag flag = <gFlag> 
					kill name = <oldskool_icon> 
				ENDIF 
			ELSE 
				kill name = <oldskool_icon> 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT oldskool_icon 
	Obj_SetException ex = SkaterInRadius scr = Oldskool_Icon_Got 
	Obj_SetInnerRadius 10 
	Obj_RotY speed = 250 
	Obj_Hover Amp = 10 Freq = 1 
ENDSCRIPT

SCRIPT Oldskool_Icon_Got 
	Obj_ClearExceptions 
	GetCurrentLevel 
	SWITCH <level> 
		CASE load_nj 
			unlocked_text = "Congratulations!\\nYou\'ve unlocked an old skool level:\\n \\c3School 2 from THPS2.\\c0" 
		CASE load_hi 
			unlocked_text = "Congratulations!\\nYou\'ve unlocked an old skool level:\\n \\c3Venice from THPS2.\\c0" 
		CASE load_ru 
			unlocked_text = "Congratulations!\\nYou\'ve unlocked an old skool level:\\n \\c3The Hangar from THPS2.\\c0" 
	ENDSWITCH 
	PauseGame 
	pause_rain 
	PlayStream UnlockOldTHPSLevel priotity = StreamPriorityHighest 
	create_snazzy_dialog_box { 
		title = "OLD SKOOL ICON!" 
		title_font = testtitle 
		text = <unlocked_text> 
		text_dims = PAIR(350, 0) 
		buttons = [ 
			{ 
				font = small text = #"Ok" 
				pad_choose_script = Oldskool_Icon_Got_Dlg_Exit 
				pad_choose_params = 
				{ 
				} 
			} 
		] 
		style = special_dialog_style 
	} 
	IF LevelIs load_nj 
		SetGlobalFlag flag = LEVEL_UNLOCKED_SC2 
	ENDIF 
	IF LevelIs load_hi 
		SetGlobalFlag flag = LEVEL_UNLOCKED_VN 
	ENDIF 
	IF LevelIs load_ru 
		SetGlobalFlag flag = LEVEL_UNLOCKED_HN 
	ENDIF 
	Die 
ENDSCRIPT

SCRIPT Oldskool_Icon_Got_Dlg_Exit 
	dialog_box_exit 
	UnpauseGame 
	unpause_rain 
ENDSCRIPT


