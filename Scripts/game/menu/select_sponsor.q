
SCRIPT select_sponsor_play_movies 
	IF ScreenElementExists id = chapter_menu_anchor 
		chapter_menu_exit exit 
	ENDIF 
	GetCurrentLevel 
	<oldLevel> = <level> 
	goalmanager_levelunload 
	cleanup preserve_skaters 
	KillMessages 
	DisablePause 
	mempushcontext 0 
	DisplayLoadingScreen "loadscrn_generic" 
	mempopcontext 
	IF GotParam select_sponsor 
		movies = [ 
			"teasers\\bird" 
			"teasers\\element" 
			"teasers\\flip" 
			"teasers\\girl" 
			"teasers\\zero" 
		] 
	ELSE 
		IF GotParam show_team_movies 
			GoalManager_GetTeam 
			printstruct <team> 
		ENDIF 
	ENDIF 
	<index> = 0 
	IF GotParam select_sponsor 
		GetArraySize <movies> 
	ELSE 
		GetArraySize pro_team_members 
	ENDIF 
	IF NOT ( <array_size> > 0 ) 
		printf "wtf?" 
		RETURN 
	ELSE 
		BEGIN 
			IF GotParam select_sponsor 
				playmovie_script ( <movies> [ <index> ] ) 
			ELSE 
				IF StructureContains structure = <team> ( ( pro_team_members [ <index> ] ) . pro ) 
					<movie_name> = ( "movies\\" + ( ( pro_team_members [ <index> ] ) . movie_text ) ) 
					playmovie_script <movie_name> 
				ENDIF 
			ENDIF 
			<index> = ( <index> + 1 ) 
		REPEAT <array_size> 
	ENDIF 
	mempushcontext 0 
	DisplayLoadingScreen "loadscrn_generic" 
	mempopcontext 
	GetCurrentLevel 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	IF GotParam show_team_movies 
		<next_level_script> = select_team_movies_done 
		level = load_nj 
	ELSE 
		IF GotParam select_sponsor 
			<next_level_script> = select_sponsor_select_after_movies 
			level = load_boardshop 
		ELSE 
			<next_level_script> = select_sponsor_movies_done 
		ENDIF 
	ENDIF 
	IF GotParam return_to_level 
		change_level { 
			level = <oldLevel> 
			next_level_script = select_sponsor_movies_done 
		} 
	ELSE 
		change_level { 
			level = <level> 
			next_level_script = <next_level_script> 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT select_sponsor_choose 
	GoalManager_SetSponsor <sponsor> 
	chapter_menu_exit exit 
	pauseGame 
	GoalManager_HidePoints 
	GoalManager_HideGoalPoints 
	unpausegame 
	SpawnScript set_boardshop_cam 
	GoalManager_GetSponsor 
	SWITCH <sponsor> 
		CASE sponsor_birdhouse 
			theme_num = 6 
			<team_name> = "Birdhouse" 
			Change_Clothes part_id = %"Birdhouse Team" 
		CASE sponsor_element 
			theme_num = 7 
			<team_name> = "Element" 
			Change_Clothes part_id = %"Element Team" 
		CASE sponsor_flip 
			theme_num = 8 
			<team_name> = "Flip" 
			Change_Clothes part_id = %"Flip Team" 
		CASE sponsor_girl 
			theme_num = 9 
			<team_name> = "Girl" 
			Change_Clothes part_id = %"Girl Team" 
		CASE sponsor_zero 
			theme_num = 10 
			<team_name> = "Zero" 
			Change_Clothes part_id = %"Zero Team" 
		DEFAULT 
			printstruct <...> 
			script_assert "wtf?" 
	ENDSWITCH 
	FormatText TextName = DialogBox_Text "Welcome to %t! Gear up, and then you\'ll be flown out to San Diego to meet the rest of your team." t = <team_name> 
	set_current_theme theme_num = <theme_num> new_sponsor 
	change unlock_sponsor_boards = 1 
	create_dialog_box { title = "New Decks Unlocked" 
		text = <DialogBox_Text> 
		just = [ center center ] 
		buttons = [ { font = small text = "Ok" pad_choose_script = select_sponsor_choose2 } 
		] 
		text_dims = PAIR(250, 0) 
	} 
ENDSCRIPT

SCRIPT select_sponsor_choose2 
	GoalManager_GetCurrentChapterAndStage 
	GoalManager_AdvanceStage force 
	goal_mark_chapter_complete currentChapter = <currentChapter> 
	dialog_box_exit 
	launch_boardshop_menu 
ENDSCRIPT

SCRIPT select_sponsor_post_movies_cleanup 
	pauseGame 
	PauseSkaters 
	pause_trick_text 
	pause_balance_meter 
	pause_run_timer 
	kill_blur 
	IF ObjectExists id = speech_box_anchor 
		DoScreenElementMorph id = speech_box_anchor scale = 0 
	ENDIF 
	IF ScreenElementExists id = goal_start_dialog 
		DestroyScreenElement id = goal_start_dialog 
	ENDIF 
	IF ObjectExists id = ped_speech_dialog 
		DestroyScreenElement id = ped_speech_dialog 
	ENDIF 
	IF ObjectExists id = goal_retry_anchor 
		DestroyScreenElement id = goal_retry_anchor 
	ENDIF 
	GoalManager_HidePoints 
	hide_goal_panel_messages 
	GoalManager_PauseAllGoals 
ENDSCRIPT

SCRIPT select_sponsor_select_after_movies 
	select_sponsor_post_movies_cleanup 
	IF ScreenElementExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	load_boardshop_textures_to_main_memory unload 
	restore_skater_camera 
	launch_chapter_menu select_sponsor 
	change dont_restore_start_key_binding = 0 
	HideLoadingScreen 
	change dont_unhide_loading_screen = 0 
ENDSCRIPT

SCRIPT select_sponsor_movies_done 
ENDSCRIPT

SCRIPT Sponsor_StageSwitch_SponsorChosen 
	chapter_menu_exit exit 
	Sponsor_StageSwitch_GoingToSD_LevelChange 
ENDSCRIPT

SCRIPT Sponsor_StageSwitch_GoingToSD_LevelChange 
	instant_tod_change current_tod = day stop_tod = 1 
	change_level level = load_SD next_level_script = SD_IntroCutscene 
ENDSCRIPT

SCRIPT select_team_choose 
	GetTags 
	IF NOT GotParam value 
		<value> = 0 
	ENDIF 
	GoalManager_GetTeam 
	IF ( ( <num_team_members> = 5 ) & ( <value> = 0 ) ) 
		generic_menu_buzzer_sound 
		RETURN 
	ELSE 
		generic_menu_pad_choose_sound 
	ENDIF 
	IF ( <num_team_members> < 5 ) 
		SetScreenElementProps id = select_team_done_item not_focusable rgba = [ 60 60 60 75 ] 
		DoScreenElementMorph id = { select_team_done_item child = 0 } rgba = [ 60 60 60 75 ] 
	ENDIF 
	IF ( <value> = 0 ) 
		DoScreenElementMorph id = { <id> child = 4 } alpha = 1 
		<value> = 1 
		GoalManager_SetTeamMember pro = <pro> 
	ELSE 
		DoScreenElementMorph id = { <id> child = 4 } alpha = 0 
		<value> = 0 
		printf "removing pro %s" s = <pro> 
		GoalManager_SetTeamMember pro = <pro> remove 
	ENDIF 
	SetTags value = <value> 
	GoalManager_GetTeam 
	IF ( <num_team_members> < 5 ) 
		SetScreenElementProps id = select_team_done_item not_focusable 
		DoScreenElementMorph id = { select_team_done_item child = 0 } rgba = [ 60 60 60 75 ] 
	ENDIF 
	IF ( <num_team_members> = 5 ) 
		select_team_chosen_five 
	ENDIF 
ENDSCRIPT

SCRIPT select_team_chosen_five 
	FireEvent type = unfocus target = chap_vmenu 
	SetScreenElementProps id = select_team_done_item focusable 
	FireEvent type = focus target = chap_vmenu data = { child_id = select_team_done_item } 
ENDSCRIPT

SCRIPT select_team_done 
	FireEvent type = unfocus target = chap_menu 
	goal_mark_chapter_complete currentChapter = 24 
	IF GotParam new_team 
		chapter_menu_exit exit 
		pauseGame 
		hide_console_window 
		GoalManager_HidePoints 
		GoalManager_HideGoalPoints 
		create_onscreen_keyboard { 
			keyboard_done_script = team_selected_store_name 
			keyboard_title = "TEAM NAME" 
			text = "" 
			min_length = 1 
			max_length = 15 
			no_back 
		} 
	ELSE 
		chapter_menu_exit 
	ENDIF 
ENDSCRIPT

SCRIPT team_selected_store_name 
	GetTextElementString id = keyboard_current_string 
	GoalManager_SetTeamName <string> 
	destroy_onscreen_keyboard 
	dialog_box_exit 
	set_current_theme theme_num = 5 story_swap 
	team_selected_change_level 
ENDSCRIPT

SCRIPT team_selected_change_level 
	change_level level = load_boardshop next_level_script = select_team_play_cutscene 
ENDSCRIPT

SCRIPT select_team_play_cutscene 
	GoalManager_AdvanceStage force 
	IF ScreenElementExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	load_boardshop_textures_to_main_memory unload 
	PlayCutscene name = "cutscenes\\NJ_07.cut" exitScript = select_team_cutscene_done 
ENDSCRIPT

SCRIPT select_team_cutscene_done 
	SpawnScript select_team_cutscene_done2 
ENDSCRIPT

SCRIPT select_team_cutscene_done2 
	launch_chapter_menu no_pad_back = 1 no_pad_left_right 
ENDSCRIPT

SCRIPT select_team_movies_done 
	unpausegame 
	IF NOT ( GetGlobalFlag flag = LEVEL_UNLOCKED_SE ) 
		SetGlobalFlag flag = VIEWED_CUTSCENE_NJ_09 
		PlayCutscene name = "cutscenes\\NJ_09.cut" exitScript = Movies_StageSwitch_GoingToEricSave_FromMovie 
	ELSE 
		SetGlobalFlag flag = VIEWED_CUTSCENE_NJ_09_ALT 
		PlayCutscene name = "cutscenes\\NJ_09_ALT.cut" exitScript = select_team_movies_done_Alt_ending 
	ENDIF 
ENDSCRIPT

SCRIPT select_team_movies_done_Alt_ending 
	goal_mark_chapter_complete currentChapter = 26 
	SK5_AdvanceStage 
ENDSCRIPT

