SCRIPT (display_current_level_texture_values) 
	IF (ScreenElementExists) (id) = (texture_list) 
		(DestroyScreenElement) (id) = (texture_list) 
	ENDIF 
	(initials) = [ "cp" "dt" "hj" "as" "jow" "tw" "cw" "mls" "apm" "dm" "nsn" "cs" "ts" "tb" "tz" "jg" ] 
	IF (levelIs) (load_NJ) 
		IF (GotParam) (NJ) 
			(level) = <NJ> 
		ELSE 
			RETURN 
		ENDIF 
	ENDIF 
	IF (levelIs) (load_NY) 
		IF (GotParam) (NY) 
			(level) = <NY> 
		ELSE 
			RETURN 
		ENDIF 
	ENDIF 
	IF (levelIs) (load_FL) 
		IF (GotParam) (FL) 
			(level) = <FL> 
		ELSE 
			RETURN 
		ENDIF 
	ENDIF 
	IF (levelIs) (load_SD) 
		IF (GotParam) (SD) 
			(level) = <SD> 
		ELSE 
			RETURN 
		ENDIF 
	ENDIF 
	IF (levelIs) (load_HI) 
		IF (GotParam) (HI) 
			(level) = <HI> 
		ELSE 
			RETURN 
		ENDIF 
	ENDIF 
	IF (levelIs) (load_VC) 
		IF (GotParam) (VC) 
			(level) = <VC> 
		ELSE 
			RETURN 
		ENDIF 
	ENDIF 
	IF (levelIs) (load_RU) 
		IF (GotParam) (RU) 
			(level) = <RU> 
		ELSE 
			RETURN 
		ENDIF 
	ENDIF 
	IF (levelIs) (load_AU) 
		IF (GotParam) (AU) 
			(level) = <AU> 
		ELSE 
			RETURN 
		ENDIF 
	ENDIF 
	IF (levelIs) (load_default) 
		IF (GotParam) (Def_Lev) 
			(level) = <Def_Lev> 
		ELSE 
			RETURN 
		ENDIF 
	ENDIF 
	IF NOT (GotParam) (level) 
		RETURN 
	ENDIF 
	(SetScreenElementLock) (id) = (root_window) (off) 
	(GetArraySize) <initials> 
	(index) = 0 
	(shift) = 0 
	BEGIN 
		(FormatText) (checksumname) = (checksum) "%i" (i) = ( <initials> [ <index> ] ) 
		IF ( <level> . <checksum> > 0 ) 
			(FormatText) (textname) = (text) "%i = %t KB" (i) = ( <initials> [ <index> ] ) (t) = ( ( <level> . <checksum> ) / 1024 ) 
			(CreateScreenElement) { 
				(type) = (TextElement) 
				(parent) = (tex_count_anchor) 
				(pos) = ( ( PAIR(0, 15) * <shift> ) + PAIR(0, 30) ) 
				(text) = <text> 
				(font) = (dialog) 
				(rgba) = [ 60 60 100 100 ] 
				(just) = [ (left) (center) ] 
				(scale) = 0.80000001192 
			} 
			(shift) = ( <shift> + 1 ) 
		ENDIF 
		(index) = ( <index> + 1 ) 
	REPEAT <array_size> 
ENDSCRIPT


