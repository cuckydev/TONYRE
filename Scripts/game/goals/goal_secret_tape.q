
SCRIPT (initialize_secret_tapes) 
	(GetCurrentLevel) 
	SWITCH <level> 
		CASE (load_skateshop) 
			<level_num> = 0 
		CASE (load_nj) 
			<level_num> = 1 
			(FormatText) (ChecksumName) = (tape_icon) "TRG_NJ_SECRET_TAPE01" 
			<gFlag> = (GOT_SECRET_TAPE_NJ) 
		CASE (load_ny) 
			<level_num> = 2 
			(FormatText) (ChecksumName) = (tape_icon) "TRG_NY_SECRET_TAPE01" 
			<gFlag> = (GOT_SECRET_TAPE_NY) 
		CASE (load_fl) 
			<level_num> = 3 
			(FormatText) (ChecksumName) = (tape_icon) "TRG_FL_SECRET_TAPE01" 
			<gFlag> = (GOT_SECRET_TAPE_FL) 
		CASE (load_sd) 
			<level_num> = 4 
			(FormatText) (ChecksumName) = (tape_icon) "TRG_SD_SECRET_TAPE01" 
			<gFlag> = (GOT_SECRET_TAPE_SD) 
		CASE (load_hi) 
			<level_num> = 5 
			(FormatText) (ChecksumName) = (tape_icon) "TRG_HI_SECRET_TAPE01" 
			<gFlag> = (GOT_SECRET_TAPE_HI) 
		CASE (load_vc) 
			<level_num> = 6 
			(FormatText) (ChecksumName) = (tape_icon) "TRG_VC_SECRET_TAPE01" 
			<gFlag> = (GOT_SECRET_TAPE_VC) 
		CASE (load_sj) 
			<level_num> = 7 
			(FormatText) (ChecksumName) = (tape_icon) "TRG_SJ_SECRET_TAPE01" 
			<gFlag> = (GOT_SECRET_TAPE_SJ) 
		CASE (load_ru) 
			<level_num> = 8 
			(FormatText) (ChecksumName) = (tape_icon) "TRG_RU_SECRET_TAPE01" 
			<gFlag> = (GOT_SECRET_TAPE_RU) 
		CASE (load_se) 
			<level_num> = 9 
			(FormatText) (ChecksumName) = (tape_icon) "TRG_SE_SECRET_TAPE01" 
			<gFlag> = (GOT_SECRET_TAPE_SE) 
		DEFAULT 
			RETURN 
	ENDSWITCH 
	IF (NodeExists) <tape_icon> 
		IF (IsAlive) (name) = <tape_icon> 
			IF (GameModeEquals) (is_career) 
				IF (GetGLobalFlag) (flag) = <gFlag> 
					(kill) (name) = <tape_icon> 
				ENDIF 
			ELSE 
				(kill) (name) = <tape_icon> 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT (Secret_Tape) 
	(Obj_SetException) (ex) = (SkaterInRadius) (scr) = (Secret_Tape_Got) 
	(Obj_SetInnerRadius) 10 
	(Obj_RotY) (speed) = 250 
	(Obj_Hover) (Amp) = 10 (Freq) = 1 
ENDSCRIPT

SCRIPT (Secret_Tape_Got) 
	(Obj_ClearExceptions) 
	(PlayStream) (UnlockOldTHPSLevel) (priority) = (StreamPriorityHighest) 
	(create_panel_block) (id) = (goal_complete) (text) = "Secret Tape Found!" (style) = (panel_message_found_secret) 
	(GetCurrentLevel) 
	SWITCH <level> 
		CASE (load_nj) 
			(SetGlobalFlag) (flag) = (GOT_SECRET_TAPE_NJ) 
		CASE (load_ny) 
			(SetGlobalFlag) (flag) = (GOT_SECRET_TAPE_NY) 
		CASE (load_fl) 
			(SetGlobalFlag) (flag) = (GOT_SECRET_TAPE_FL) 
		CASE (load_sd) 
			(SetGlobalFlag) (flag) = (GOT_SECRET_TAPE_SD) 
		CASE (load_hi) 
			(SetGlobalFlag) (flag) = (GOT_SECRET_TAPE_HI) 
		CASE (load_vc) 
			(SetGlobalFlag) (flag) = (GOT_SECRET_TAPE_VC) 
		CASE (load_sj) 
			(SetGlobalFlag) (flag) = (GOT_SECRET_TAPE_SJ) 
		CASE (load_ru) 
			(SetGlobalFlag) (flag) = (GOT_SECRET_TAPE_RU) 
		CASE (load_se) 
			(SetGlobalFlag) (flag) = (GOT_SECRET_TAPE_SE) 
	ENDSWITCH 
	(GetTotalTapesCollected) 
	SWITCH <secret_tape_total> 
		CASE 3 
			(SetGlobalFlag) (flag) = (MOVIE_UNLOCKED_CAS) 
			(SpawnScript) (secret_tape_play_movie) (params) = { (movie_file) = "movies\\probail1" (name) = "Bails 1" } 
		CASE 6 
			(SetGlobalFlag) (flag) = (MOVIE_UNLOCKED_BAILS2) 
			(SpawnScript) (secret_tape_play_movie) (params) = { (movie_file) = "movies\\probail2" (name) = "Bails 2" } 
		CASE 9 
			(SetGlobalFlag) (flag) = (MOVIE_UNLOCKED_HOMIES1) 
			(SpawnScript) (secret_tape_play_movie) (params) = { (movie_file) = "movies\\homiesp1" (name) = "Always Hard" } 
	ENDSWITCH 
	(Die) 
ENDSCRIPT

SCRIPT (GetTotalTapesCollected) 
	<secret_tape_total> = 0 
	IF (GetGLobalFlag) (flag) = (GOT_SECRET_TAPE_NJ) 
		<secret_tape_total> = ( <secret_tape_total> + 1 ) 
	ENDIF 
	IF (GetGLobalFlag) (flag) = (GOT_SECRET_TAPE_NY) 
		<secret_tape_total> = ( <secret_tape_total> + 1 ) 
	ENDIF 
	IF (GetGLobalFlag) (flag) = (GOT_SECRET_TAPE_FL) 
		<secret_tape_total> = ( <secret_tape_total> + 1 ) 
	ENDIF 
	IF (GetGLobalFlag) (flag) = (GOT_SECRET_TAPE_SD) 
		<secret_tape_total> = ( <secret_tape_total> + 1 ) 
	ENDIF 
	IF (GetGLobalFlag) (flag) = (GOT_SECRET_TAPE_HI) 
		<secret_tape_total> = ( <secret_tape_total> + 1 ) 
	ENDIF 
	IF (GetGLobalFlag) (flag) = (GOT_SECRET_TAPE_VC) 
		<secret_tape_total> = ( <secret_tape_total> + 1 ) 
	ENDIF 
	IF (GetGLobalFlag) (flag) = (GOT_SECRET_TAPE_SJ) 
		<secret_tape_total> = ( <secret_tape_total> + 1 ) 
	ENDIF 
	IF (GetGLobalFlag) (flag) = (GOT_SECRET_TAPE_RU) 
		<secret_tape_total> = ( <secret_tape_total> + 1 ) 
	ENDIF 
	IF (GetGLobalFlag) (flag) = (GOT_SECRET_TAPE_SE) 
		<secret_tape_total> = ( <secret_tape_total> + 1 ) 
	ENDIF 
	RETURN (secret_tape_total) = <secret_tape_total> 
ENDSCRIPT

SCRIPT (secret_tape_play_movie) 
	(printf) "secret_tape_play_movie" 
	IF NOT (GotParam) (movie_file) 
		(printf) "secret_tape_play_movie MISSING PARAM movie_file!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!" 
	ENDIF 
	(wait) 2 (seconds) 
	(PauseGame) 
	(pause_rain) 
	(FormatText) (TextName) = (text) "You\'ve unlocked the %s video.\\nWatch it now?" (s) = <name> 
	(create_dialog_box) { (title) = "Movie Unlocked" 
		(text) = <text> 
		(pos) = PAIR(310, 240) 
		(just) = [ (center) (center) ] 
		(text_rgba) = [ 88 105 112 128 ] 
		(text_dims) = PAIR(330, 0) 
		(pad_back_script) = <back_script> 
		(buttons) = [ 
			{ (font) = (small) (text) = "Yes" (pad_choose_script) = (really_watch_secret_tape_movie) (pad_choose_params) = { <...> } } 
		{ (font) = (small) (text) = "No" (pad_choose_script) = (back_to_game_from_secret_tape) } ] 
		(delay_input) 
	} 
ENDSCRIPT

SCRIPT (really_watch_secret_tape_movie) 
	(dialog_box_exit) 
	IF (ScreenElementExists) (id) = (current_menu_anchor) 
		(DestroyScreenElement) (id) = (current_menu_anchor) 
	ENDIF 
	(do_unload_unloadable) 
	(goalmanager_levelunload) 
	(cleanup) (preserve_skaters) 
	(KillMessages) 
	(mempushcontext) 0 
	(playmovie) <movie_file> 
	(mempopcontext) 
	(do_load_unloadable) 
	(mempushcontext) 0 
	(DisplayLoadingScreen) "loadscrn_generic" 
	(mempopcontext) 
	(GetCurrentLevel) 
	IF (ObjectExists) (id) = (current_menu_anchor) 
		(DestroyScreenElement) (id) = (current_menu_anchor) 
	ENDIF 
	(change_level) (level) = <level> 
	(restore_start_key_binding) 
ENDSCRIPT

SCRIPT (back_to_game_from_secret_tape) 
	(dialog_box_exit) 
	(UnPauseGame) 
	(unpause_rain) 
ENDSCRIPT

SCRIPT (GetLevelNumTapeCollected) 
	SWITCH <level> 
		CASE 1 
			<flag> = (GOT_SECRET_TAPE_NJ) 
		CASE 2 
			<flag> = (GOT_SECRET_TAPE_NY) 
		CASE 3 
			<flag> = (GOT_SECRET_TAPE_FL) 
		CASE 4 
			<flag> = (GOT_SECRET_TAPE_SD) 
		CASE 5 
			<flag> = (GOT_SECRET_TAPE_HI) 
		CASE 6 
			<flag> = (GOT_SECRET_TAPE_VC) 
		CASE 7 
			<flag> = (GOT_SECRET_TAPE_SJ) 
		CASE 8 
			<flag> = (GOT_SECRET_TAPE_RU) 
		CASE 10 
			<flag> = (GOT_SECRET_TAPE_SE) 
	ENDSWITCH 
	<collected> = 0 
	IF ( (GetGLobalFlag) (flag) = <flag> ) 
		<collected> = 1 
	ENDIF 
	RETURN (collected) = <collected> 
ENDSCRIPT


