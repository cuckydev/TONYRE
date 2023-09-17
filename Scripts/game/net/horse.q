
SCRIPT PlayYouTieScoreSound 
	PlaySound copinghit3_11 
ENDSCRIPT

SCRIPT PlayYouBeatScoreSound 
	PlaySound GotStat04 
ENDSCRIPT

SCRIPT PlayYouGetLetterSound 
	PlaySound HUDtrickslopC 
ENDSCRIPT

SCRIPT PlayYouLoseSound 
	PlaySound GoalFail 
ENDSCRIPT

SCRIPT PlayNoScoreSetSound 
	PlaySound GUI_buzzer01 
ENDSCRIPT

SCRIPT play_appropriate_horse_sound 
	IF HorseEnded 
		PlayYouLoseSound 
	ENDIF 
	IF HorseStatusEquals GotLetter 
		PlayYouGetLetterSound 
	ENDIF 
	IF HorseStatusEquals TieScore 
		PlayYouTieScoreSound 
	ENDIF 
	IF HorseStatusEquals BeatScore 
		PlayYouBeatScoreSound 
	ENDIF 
	IF HorseStatusEquals NoScoreSet 
		PlayNoScoreSetSound 
	ENDIF 
ENDSCRIPT

SCRIPT WaitForPanelDone 
	BEGIN 
		IF ControllerPressed X 
			kill_horse_panel_messages 
			BREAK 
		ENDIF 
		IF ObjectExists id = Top 
			wait 1 gameframe 
		ELSE 
			IF ObjectExists id = Bottom 
				wait 1 gameframe 
			ELSE 
				IF ObjectExists id = TopFinal 
					wait 1 gameframe 
				ELSE 
					IF ObjectExists id = BottomFinal 
						wait 1 gameframe 
					ELSE 
						BREAK 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
	REPEAT 
ENDSCRIPT

SCRIPT launch_panel_message 
	LaunchPanelMessage <...> 
ENDSCRIPT

player1_horsecolor = [ 
	{ VECTOR(128, 32, 32) alpha = 128 } 
] 
player2_horsecolor = [ 
	{ VECTOR(32, 32, 128) alpha = 128 } 
] 
horse_top_key_points = [ 
	{ pos = PAIR(320, 204) alpha = 0 scale = 1.00000000000 time = 0 } 
	{ alpha = 128 time = 2.00000000000 } 
] 
horse_middle_key_points = [ 
	{ pos = PAIR(320.00000000000, 224.00000000000) alpha = 0 scale = 1.00000000000 time = 0 } 
	{ alpha = 128 time = 2.00000000000 } 
] 
horse_bottom_key_points = [ 
	{ pos = PAIR(320.00000000000, 244.00000000000) alpha = 0 scale = 1.00000000000 time = 0 } 
	{ alpha = 128 time = 2.00000000000 } 
] 
horse_bottomfinal_key_points = [ 
	{ pos = PAIR(340.00000000000, 300.00000000000) alpha = 0 scale = 2.00000000000 time = 0 } 
	{ alpha = 128 time = 5.00000000000 } 
] 
horse_topfinal_key_points = [ 
	{ pos = PAIR(320.00000000000, 204.00000000000) alpha = 0 scale = 1.00000000000 time = 0 } 
	{ alpha = 128 time = 5.00000000000 } 
] 
player1_default_horseprop = { 
	font = "title.fnt" 
	just = PAIR(0.00000000000, 0.00000000000) 
	dims = PAIR(320.00000000000, 112.00000000000) 
	colors = player1_horsecolor 
	key_points = horse_middle_key_points 
} 
player2_default_horseprop = { 
	font = "title.fnt" 
	just = PAIR(0.00000000000, 0.00000000000) 
	dims = PAIR(320.00000000000, 112.00000000000) 
	colors = player2_horsecolor 
	key_points = horse_middle_key_points 
} 
player1_top_horseprop = { 
	player1_default_horseprop 
	key_points = horse_top_key_points 
} 
player2_top_horseprop = { 
	player2_default_horseprop 
	key_points = horse_top_key_points 
} 
player1_bottom_horseprop = { 
	player1_default_horseprop 
	key_points = horse_bottom_key_points 
} 
player2_bottom_horseprop = { 
	player2_default_horseprop 
	key_points = horse_bottom_key_points 
} 
player1_topfinal_horseprop = { 
	player1_default_horseprop 
	key_points = horse_topfinal_key_points 
} 
player2_topfinal_horseprop = { 
	player2_default_horseprop 
	key_points = horse_topfinal_key_points 
} 
player1_bottomfinal_horseprop = { 
	player1_default_horseprop 
	key_points = horse_bottomfinal_key_points 
} 
player2_bottomfinal_horseprop = { 
	player2_default_horseprop 
	key_points = horse_bottomfinal_key_points 
} 
horse_final_prop_default = { 
	font = "title.fnt" 
	just = PAIR(0.00000000000, 0.00000000000) 
	dims = PAIR(320.00000000000, 112.00000000000) 
	colors = [ 
		{ VECTOR(128.00000000000, 128.00000000000, 128.00000000000) alpha = 128 } 
		{ VECTOR(255.00000000000, 245.00000000000, 0.00000000000) alpha = 128 } 
		{ VECTOR(195.00000000000, 20.00000000000, 20.00000000000) alpha = 128 } 
	] 
	key_points = [ 
		{ pos = PAIR(320.00000000000, 224.00000000000) alpha = 0 scale = 1.00000000000 time = 0 } 
		{ alpha = 128 time = 5.00000000000 } 
	] 
} 
SCRIPT remove_skater_from_world 
	printf "removing skater to the world" 
	RemoveSkaterFromWorld 
ENDSCRIPT

SCRIPT add_skater_to_world 
	printf "adding skater to the world" 
	AddSkaterToWorld 
	ResetLookAround 
ENDSCRIPT

SCRIPT print_horse_string 
	IF IsCurrentHorseSkater 0 
		IF GotParam Top 
			ApplyToHorsePanelString { 
				whichString = <whichString> 
				callback = LaunchPanelMessage 
				properties = player1_top_horseprop 
				id = Top 
			} 
		ELSE 
			IF GotParam Bottom 
				ApplyToHorsePanelString { 
					whichString = <whichString> 
					callback = LaunchPanelMessage 
					properties = player1_bottom_horseprop 
					id = Bottom 
				} 
			ELSE 
				IF GotParam TopFinal 
					ApplyToHorsePanelString { 
						whichString = <whichString> 
						callback = LaunchPanelMessage 
						properties = player1_topfinal_horseprop 
						id = TopFinal 
					} 
				ELSE 
					IF GotParam BottomFinal 
						ApplyToHorsePanelString { 
							whichString = <whichString> 
							callback = LaunchPanelMessage 
							properties = player1_bottomfinal_horseprop 
							id = BottomFinal 
						} 
					ELSE 
						ApplyToHorsePanelString { 
							whichString = <whichString> 
							callback = LaunchPanelMessage 
							properties = player1_default_horseprop 
							id = Top 
						} 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
	ELSE 
		IF GotParam Top 
			ApplyToHorsePanelString { 
				whichString = <whichString> 
				callback = LaunchPanelMessage 
				properties = player2_top_horseprop 
				id = Top 
			} 
		ELSE 
			IF GotParam Bottom 
				ApplyToHorsePanelString { 
					whichString = <whichString> 
					callback = LaunchPanelMessage 
					properties = player2_bottom_horseprop 
					id = Bottom 
				} 
			ELSE 
				IF GotParam TopFinal 
					ApplyToHorsePanelString { 
						whichString = <whichString> 
						callback = LaunchPanelMessage 
						properties = player2_topfinal_horseprop 
						id = TopFinal 
					} 
				ELSE 
					IF GotParam BottomFinal 
						ApplyToHorsePanelString { 
							whichString = <whichString> 
							callback = LaunchPanelMessage 
							properties = player2_bottomfinal_horseprop 
							id = BottomFinal 
						} 
					ELSE 
						ApplyToHorsePanelString { 
							whichString = <whichString> 
							callback = LaunchPanelMessage 
							properties = player2_default_horseprop 
							id = Top 
						} 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT horse_start_run 
	kill_start_key_binding 
	ClearTrickAndScoreText 
	StartHorseRun 
	ShowClock 
	disable_inactive_horse_player 
	wait 1 gameframe 
	WaitForPanelDone 
	printf "***** PAUSING GAME *****" 
	exit_pause_menu 
	kill_start_key_binding 
	PauseGame 
	print_horse_string { whichString = playerName Top } 
	print_horse_string { whichString = horseprerun Bottom } 
	WaitForPanelDone 
	GetPreferenceChecksum pref_type = splitscreen horse_time_limit 
	SWITCH <checksum> 
		CASE horse_time_10 
			horse_time = 10 
		CASE horse_time_20 
			horse_time = 20 
		CASE horse_time_30 
			horse_time = 30 
	ENDSWITCH 
	StartGoal_Horse_Mp time = <horse_time> 
	printf "***** UNPAUSING GAME *****" 
	IF IsCurrentHorseSkater 0 
		skater : ResetLookAround 
		skater : RunStarted 
	ELSE 
		skater2 : ResetLookAround 
		skater2 : RunStarted 
	ENDIF 
	horse_check_for_controller_unplugged_dialog 
	UnpauseGame 
	restore_start_key_binding 
	GetHorseString whichString = panelString1 
	update_horse_score id = horse_score_1 <...> 
	GetHorseString whichString = panelString2 
	update_horse_score id = horse_score_2 <...> 
	GetHorseString whichString = horseprerun 
	update_horse_score id = horse_score_3 <...> 
	wait 1 gameframe 
ENDSCRIPT

SCRIPT disable_inactive_horse_player 
	IF IsCurrentHorseSkater 0 
		printf "unhiding skater 0" 
		SetScreenMode horse1 
		MakeSkaterGosub add_skater_to_world skater = 0 
		DoScreenElementMorph { id = player1_panel_container alpha = 1 } 
		printf "hiding skater 1" 
		MakeSkaterGosub remove_skater_from_world skater = 1 
		DoScreenElementMorph { id = player2_panel_container alpha = 0 } 
		printf "*** done" 
		printf "************** ABOUT TO DO CONTROLLER ENABLING 1" 
		skater2 : DisablePlayerInput 
		skater2 : PausePhysics 
		skater : EnablePlayerInput 
		skater : UnpausePhysics 
	ELSE 
		IF IsCurrentHorseSkater 1 
			printf "unhiding skater 1" 
			SetScreenMode horse2 
			MakeSkaterGosub add_skater_to_world skater = 1 
			DoScreenElementMorph { id = player2_panel_container alpha = 1 } 
			printf "hiding skater 0" 
			MakeSkaterGosub remove_skater_from_world skater = 0 
			DoScreenElementMorph { id = player1_panel_container alpha = 0 } 
			printf "*** done" 
			printf "************** ABOUT TO DO CONTROLLER ENABLING 2" 
			skater : DisablePlayerInput 
			skater : PausePhysics 
			skater2 : EnablePlayerInput 
			skater2 : UnpausePhysics 
		ENDIF 
	ENDIF 
	SetActivecamera id = skatercam0 viewport = 0 
	SetActivecamera id = skatercam1 viewport = 1 
ENDSCRIPT

SCRIPT horse_end_run 
	kill_start_key_binding 
	printf "entering horse_end_run" 
	EndHorseRun 
	EndGoal_Horse_Mp 
	WaitForPanelDone 
	printf "***** PAUSING GAME *****" 
	exit_pause_menu 
	kill_start_key_binding 
	PauseGame 
	play_appropriate_horse_sound 
	IF HorseEnded 
		printf "HORSE GAME DONE" 
		print_horse_string { whichString = youarea TopFinal } 
		print_horse_string { whichString = finalword BottomFinal } 
		wait 120 gameframes 
		IF ObjectExists id = horse_score_menu 
			DestroyScreenElement id = horse_score_menu 
		ENDIF 
		MakeSkaterGosub add_skater_to_world skater = 0 
		MakeSkaterGosub add_skater_to_world skater = 1 
	ELSE 
		print_horse_string { whichString = playerName Top } 
		print_horse_string { whichString = horsepostrun Bottom } 
	ENDIF 
	WaitForPanelDone 
	SwitchHorsePlayers 
	printf "***** UNPAUSING GAME *****" 
	wait 1 gameframe 
	printf "exiting horse_end_run" 
	IF HorseEnded 
		restore_start_key_binding 
		create_end_run_menu 
	ELSE 
		horse_check_for_controller_unplugged_dialog 
		UnpauseGame 
	ENDIF 
ENDSCRIPT

SCRIPT horse_uninit 
ENDSCRIPT

SCRIPT kill_horse_panel_messages 
	IF ObjectExists id = Top 
		DestroyScreenElement id = Top 
	ENDIF 
	IF ObjectExists id = Bottom 
		DestroyScreenElement id = Bottom 
	ENDIF 
	IF ObjectExists id = TopFinal 
		DestroyScreenElement id = TopFinal 
	ENDIF 
	IF ObjectExists id = BottomFinal 
		DestroyScreenElement id = BottomFinal 
	ENDIF 
ENDSCRIPT

SCRIPT horse_check_for_controller_unplugged_dialog 
	BEGIN 
		IF NOT ScreenElementExists id = controller_unplugged_dialog_anchor 
			root_window : GetTags 
			IF GotParam menu_state 
				IF ( <menu_state> = off ) 
					BREAK 
				ENDIF 
			ELSE 
				BREAK 
			ENDIF 
		ENDIF 
		wait 1 gameframe 
	REPEAT 
ENDSCRIPT

SCRIPT create_horse_panel_message 
	FormatText ChecksumName = text_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	chaos1 = RANDOM(1, 1) RANDOMCASE 1 RANDOMCASE 2 RANDOMEND 
	chaos2 = RANDOM(1, 1) RANDOMCASE 3 RANDOMCASE 4 RANDOMEND 
	SWITCH <id> 
		CASE Top 
			message_pos = PAIR(320.00000000000, 150.00000000000) 
			message_color = <text_rgba> 
			<style> = play_horse_animation 
		CASE Bottom 
			message_pos = PAIR(320.00000000000, 180.00000000000) 
			message_color = [ 108 112 120 128 ] 
			<style> = play_horse_animation2 
		CASE TopFinal 
			message_pos = PAIR(320.00000000000, 150.00000000000) 
			message_color = <text_rgba> 
			<style> = play_horse_animation_final_1 
		CASE BottomFinal 
			message_pos = PAIR(320.00000000000, 180.00000000000) 
			message_color = <text_rgba> 
			<style> = play_horse_animation_final_2 
		DEFAULT 
	ENDSWITCH 
	create_panel_block <...> style = <style> pos = <message_pos> rgba = <message_color> dims = PAIR(450.00000000000, 0.00000000000) z_priority = 10 
ENDSCRIPT

SCRIPT play_horse_animation 
	SWITCH <chaos1> 
		CASE 1 
			DoMorph time = 0 scale = 0 alpha = 0 pos = PAIR(320.00000000000, 0.00000000000) 
			DoMorph time = 0.30000001192 scale = 1.20000004768 alpha = 1 pos = PAIR(320.00000000000, 130.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(321.00000000000, 133.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(319.00000000000, 129.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(322.00000000000, 131.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(318.00000000000, 127.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(321.00000000000, 131.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(317.00000000000, 129.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(323.00000000000, 130.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(319.00000000000, 129.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(319.00000000000, 129.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(322.00000000000, 131.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(318.00000000000, 127.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(321.00000000000, 131.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(317.00000000000, 129.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(323.00000000000, 130.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(319.00000000000, 129.00000000000) 
			DoMorph time = 0.15000000596 scale = 0 alpha = 0 
			Die 
		CASE 2 
			DoMorph time = 0 scale = 0 alpha = 0 pos = PAIR(320.00000000000, 500.00000000000) 
			DoMorph time = 0.20000000298 
			DoMorph time = 0.30000001192 scale = 1.20000004768 alpha = 1 pos = PAIR(320.00000000000, 130.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(321.00000000000, 133.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(319.00000000000, 129.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(322.00000000000, 131.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(318.00000000000, 127.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(321.00000000000, 131.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(317.00000000000, 129.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(323.00000000000, 130.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(319.00000000000, 129.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(319.00000000000, 129.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(322.00000000000, 131.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(318.00000000000, 127.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(321.00000000000, 131.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(317.00000000000, 129.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(323.00000000000, 130.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(319.00000000000, 129.00000000000) 
			DoMorph time = 0.15000000596 scale = 4 alpha = 0 
			Die 
	ENDSWITCH 
ENDSCRIPT

SCRIPT play_horse_animation2 
	SWITCH <chaos2> 
		CASE 3 
			DoMorph time = 0 scale = 0 alpha = 0 pos = PAIR(0.00000000000, 150.00000000000) 
			DoMorph time = 0.30000001192 
			DoMorph time = 0.10000000149 scale = 1 alpha = 1 pos = PAIR(320.00000000000, 150.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(321.00000000000, 153.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(319.00000000000, 149.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(322.00000000000, 151.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(318.00000000000, 147.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(321.00000000000, 151.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(317.00000000000, 149.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(323.00000000000, 150.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(319.00000000000, 149.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(321.00000000000, 153.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(319.00000000000, 149.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(322.00000000000, 151.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(318.00000000000, 147.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(321.00000000000, 151.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(317.00000000000, 149.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(323.00000000000, 150.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(319.00000000000, 149.00000000000) 
			SetProps blur_effect 
			do_blur_effect 
			SetProps no_blur_effect 
			DoMorph time = 0.15000000596 pos = PAIR(640.00000000000, 150.00000000000) alpha = 0 
			Die 
		CASE 4 
			DoMorph time = 0 scale = 0 alpha = 0 pos = PAIR(700.00000000000, 150.00000000000) 
			DoMorph time = 0.30000001192 
			DoMorph time = 0.10000000149 scale = 1 alpha = 1 pos = PAIR(320.00000000000, 150.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(321.00000000000, 153.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(319.00000000000, 149.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(322.00000000000, 151.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(318.00000000000, 147.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(321.00000000000, 151.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(317.00000000000, 149.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(323.00000000000, 150.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(319.00000000000, 149.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(321.00000000000, 153.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(319.00000000000, 149.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(322.00000000000, 151.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(318.00000000000, 147.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(321.00000000000, 151.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(317.00000000000, 149.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(323.00000000000, 150.00000000000) 
			DoMorph time = 0.10000000149 pos = PAIR(319.00000000000, 149.00000000000) 
			SetProps blur_effect 
			do_blur_effect 
			SetProps no_blur_effect 
			DoMorph time = 0.15000000596 scale = 4 alpha = 0 
			Die 
	ENDSWITCH 
ENDSCRIPT

SCRIPT play_horse_animation_final_1 
	DoMorph time = 0 scale = 0 alpha = 0 pos = PAIR(320.00000000000, 130.00000000000) 
	DoMorph time = 0.30000001192 scale = 1.20000004768 alpha = 1 pos = PAIR(320.00000000000, 130.00000000000) 
	DoMorph time = 0.10000000149 pos = PAIR(321.00000000000, 133.00000000000) 
	DoMorph time = 0.10000000149 pos = PAIR(319.00000000000, 129.00000000000) 
	DoMorph time = 0.10000000149 pos = PAIR(322.00000000000, 131.00000000000) 
	DoMorph time = 0.10000000149 pos = PAIR(318.00000000000, 127.00000000000) 
	DoMorph time = 0.10000000149 pos = PAIR(321.00000000000, 131.00000000000) 
	DoMorph time = 0.10000000149 pos = PAIR(317.00000000000, 129.00000000000) 
	DoMorph time = 0.10000000149 pos = PAIR(323.00000000000, 130.00000000000) 
	DoMorph time = 0.10000000149 pos = PAIR(319.00000000000, 129.00000000000) 
	DoMorph time = 0.10000000149 pos = PAIR(322.00000000000, 131.00000000000) 
	DoMorph time = 0.10000000149 pos = PAIR(318.00000000000, 127.00000000000) 
	DoMorph time = 0.10000000149 pos = PAIR(321.00000000000, 131.00000000000) 
	DoMorph time = 0.10000000149 pos = PAIR(317.00000000000, 129.00000000000) 
	DoMorph time = 0.10000000149 pos = PAIR(323.00000000000, 130.00000000000) 
	DoMorph time = 0.10000000149 pos = PAIR(319.00000000000, 129.00000000000) 
	DoMorph time = 0.20000000298 scale = 0 alpha = 0 pos = PAIR(319.00000000000, 500.00000000000) 
	Die 
ENDSCRIPT

SCRIPT play_horse_animation_final_2 
	DoMorph time = 0 scale = 0 alpha = 0 pos = PAIR(320.00000000000, 170.00000000000) 
	DoMorph time = 0.20000000298 scale = 1.89999997616 alpha = 1 pos = PAIR(320.00000000000, 150.00000000000) 
	DoMorph time = 0.21999999881 scale = 1.20000004768 
	DoMorph time = 0.23000000417 scale = 1.50000000000 
	DoMorph time = 0.31999999285 scale = 1.29999995232 
	DoMorph time = 0.10000000149 pos = PAIR(321.00000000000, 153.00000000000) 
	DoMorph time = 0.10000000149 pos = PAIR(319.00000000000, 149.00000000000) 
	DoMorph time = 0.10000000149 pos = PAIR(322.00000000000, 151.00000000000) 
	DoMorph time = 0.10000000149 pos = PAIR(318.00000000000, 147.00000000000) 
	DoMorph time = 0.10000000149 pos = PAIR(321.00000000000, 151.00000000000) 
	DoMorph time = 0.10000000149 pos = PAIR(317.00000000000, 149.00000000000) 
	DoMorph time = 0.10000000149 pos = PAIR(323.00000000000, 150.00000000000) 
	DoMorph time = 0.10000000149 pos = PAIR(319.00000000000, 149.00000000000) 
	DoMorph time = 0.10000000149 pos = PAIR(322.00000000000, 151.00000000000) 
	DoMorph time = 0.10000000149 pos = PAIR(318.00000000000, 147.00000000000) 
	SetProps blur_effect 
	do_blur_effect 
	SetProps no_blur_effect 
	DoMorph time = 0.40000000596 scale = 6 alpha = 0 pos = PAIR(320.00000000000, 150.00000000000) 
	Die 
ENDSCRIPT


