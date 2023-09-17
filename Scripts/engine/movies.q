
SCRIPT playmovie_script_temp 
ENDSCRIPT

SCRIPT PlayAllMovies 
	playmovie_script "movies\\THPS3" 
	IF GetGlobalFlag flag = MOVIE_UNLOCKED_PRO_BAILS1 
		playmovie_script "movies\\bails01" 
	ENDIF 
	IF GetGlobalFlag flag = MOVIE_UNLOCKED_HAWK 
		playmovie_script "movies\\tony" 
	ENDIF 
	IF GetGlobalFlag flag = MOVIE_UNLOCKED_CABALLERO 
		playmovie_script "movies\\cab" 
	ENDIF 
	IF GetGlobalFlag flag = MOVIE_UNLOCKED_CAMPBELL 
		playmovie_script "movies\\kareem" 
	ENDIF 
	IF GetGlobalFlag flag = MOVIE_UNLOCKED_GLIFBERG 
		playmovie_script "movies\\rune" 
	ENDIF 
	IF GetGlobalFlag flag = MOVIE_UNLOCKED_KOSTON 
		playmovie_script "movies\\koston" 
	ENDIF 
	IF GetGlobalFlag flag = MOVIE_UNLOCKED_LASEK 
		playmovie_script "movies\\bucky" 
	ENDIF 
	IF GetGlobalFlag flag = MOVIE_UNLOCKED_MARGERA 
		playmovie_script "movies\\bam" 
	ENDIF 
	IF GetGlobalFlag flag = MOVIE_UNLOCKED_MULLEN 
		playmovie_script "movies\\mullen" 
	ENDIF 
	IF GetGlobalFlag flag = MOVIE_UNLOCKED_MUSKA 
		playmovie_script "movies\\muska" 
	ENDIF 
	IF GetGlobalFlag flag = MOVIE_UNLOCKED_REYNOLDS 
		playmovie_script "movies\\andrew" 
	ENDIF 
	IF GetGlobalFlag flag = MOVIE_UNLOCKED_ROWLEY 
		playmovie_script "movies\\rowley" 
	ENDIF 
	IF GetGlobalFlag flag = MOVIE_UNLOCKED_STEAMER 
		playmovie_script "movies\\elissa" 
	ENDIF 
	IF GetGlobalFlag flag = MOVIE_UNLOCKED_THOMAS 
		playmovie_script "movies\\thomas" 
	ENDIF 
	IF GetGlobalFlag flag = MOVIE_UNLOCKED_CAS 
		playmovie_script "movies\\bails02" 
	ENDIF 
	IF GetGlobalFlag flag = MOVIE_UNLOCKED_JEDIKNIGHT 
		playmovie_script "movies\\NSbails" 
	ENDIF 
	IF GetGlobalFlag flag = MOVIE_UNLOCKED_WOLVERINE 
		playmovie_script "movies\\NSmakes" 
	ENDIF 
	IF GetGlobalFlag flag = MOVIE_UNLOCKED_DICK 
		playmovie_script "movies\\proret" 
	ENDIF 
	IF GetGlobalFlag flag = MOVIE_UNLOCKED_CARRERA 
		playmovie_script "movies\\kflip" 
	ENDIF 
	IF GetGlobalFlag flag = MOVIE_UNLOCKED_BUM 
		playmovie_script "movies\\friends" 
	ENDIF 
	IF GetGlobalFlag flag = MOVIE_UNLOCKED_SLATER 
		playmovie_script "movies\\slater" 
	ENDIF 
	IF GetGlobalFlag flag = MOVIE_UNLOCKED_DEMONESS 
		playmovie_script "movies\\nsret" 
	ENDIF 
	IF GetGlobalFlag flag = MOVIE_UNLOCKED_Eyeball 
		playmovie_script "movies\\day" 
	ENDIF 
ENDSCRIPT

SCRIPT playmovie_script 
	<anims_unloaded> = 0 
	<pre_unloaded> = 0 
	IF LevelIs load_skateshop 
		PauseObjects 
		<anims_unloaded> = 1 
		printf "Unloading anims here" 
		do_unload_permanent 
		do_unload_unloadable 
		IF InPreFile "skaterparts.pre" 
			UnloadPreFile "skaterparts.pre" 
			<pre_unloaded> = 1 
		ENDIF 
	ENDIF 
	mempushcontext 0 
	playmovie <...> 
	IF isXbox 
		<time> = 6.00000000000 
	ELSE 
		<time> = 4.50000000000 
	ENDIF 
	IF LevelIs load_skateshop 
		DisplayLoadingScreen "loadscrn_generic" <time> 
	ENDIF 
	mempopcontext 
	IF ( <anims_unloaded> = 1 ) 
		printf "Reloading anims here" 
		do_load_unloadable 
		UnpauseObjects 
	ENDIF 
	IF ( <pre_unloaded> = 1 ) 
		IF NOT LevelIs load_skateshop 
			script_assert "Can only unload skaterparts/play movies from skateshop (mainmenu) level" 
		ENDIF 
		LoadPreFile "skaterparts.pre" 
	ENDIF 
	IF LevelIs load_skateshop 
		HideLoadingScreen 
	ENDIF 
ENDSCRIPT

SCRIPT cleanup_play_movie 
	goalmanager_levelunload 
	cleanup preserve_skaters 
	KillMessages 
	DisablePause 
	mempushcontext 0 
	playmovie <...> 
	mempopcontext 
ENDSCRIPT

SCRIPT ingame_play_movie 
	cleanup_play_movie <...> 
	mempushcontext 0 
	DisplayLoadingScreen "loadscrn_generic" 
	mempopcontext 
	IF NOT GotParam level 
		GetCurrentLevel 
	ENDIF 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	change_level level = <level> 
	restore_start_key_binding 
ENDSCRIPT


