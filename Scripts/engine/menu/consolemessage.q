(number_of_console_lines) = 6 
SCRIPT (create_console) 
	IF NOT (ObjectExists) (id) = (console_message_vmenu) 
		(SetScreenElementLock) (id) = (root_window) (off) 
		IF (LevelIs) (load_skateshop) 
			(pos) = PAIR(50, 240) 
		ELSE 
			(pos) = PAIR(20, 265) 
		ENDIF 
		(CreateScreenElement) { 
			(type) = (VMenu) 
			(parent) = (root_window) 
			(id) = (console_message_vmenu) 
			(padding_scale) = 0.64999997616 
			(font) = (dialog) 
			(just) = [ (left) (top) ] 
			(internal_just) = [ (left) (center) ] 
			(pos) = <pos> 
			(z_priority) = 0 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT (create_console_message) (text) = "Default console message" (rgba) = [ 113 121 127 80 ] 
	IF NOT (GetGlobalFlag) (flag) = (NO_DISPLAY_CHATWINDOW) 
		IF NOT (ObjectExists) (id) = (console_message_vmenu) 
			(create_console) 
		ENDIF 
		(SetScreenElementLock) (id) = (console_message_vmenu) (off) 
		IF (ScreenElementExists) (id) = { (console_message_vmenu) (child) = ( (number_of_console_lines) - 1 ) } 
			(DestroyScreenElement) (id) = { (console_message_vmenu) (child) = 0 } 
		ENDIF 
		IF (LevelIs) (load_skateshop) 
			(dims) = PAIR(750.00000000000, 10.00000000000) 
			(pos) = PAIR(50.00000000000, 240.00000000000) 
			(change) (number_of_console_lines) = 7 
			(max_chat_height) = 150 
		ELSE 
			(dims) = PAIR(750.00000000000, 10.00000000000) 
			(pos) = PAIR(20.00000000000, 265.00000000000) 
			(change) (number_of_console_lines) = 6 
			(max_chat_height) = 96 
		ENDIF 
		IF (GotParam) (join) 
			(rgba) = [ 0 80 0 80 ] 
		ELSE 
			IF (GotParam) (left) 
				(rgba) = [ 80 0 0 80 ] 
			ENDIF 
		ENDIF 
		(SetScreenElementProps) (id) = (console_message_vmenu) (pos) = <pos> 
		(CreateScreenElement) { 
			(type) = (TextBlockElement) 
			(parent) = (console_message_vmenu) 
			(font) = (dialog) 
			(text) = <text> 
			(internal_just) = [ (left) (top) ] 
			(rgba) = <rgba> 
			(scale) = 0.80000001192 
			(not_focusable) 
			(dims) = <dims> 
			(allow_expansion) 
			(z_priority) = 5 
		} 
		BEGIN 
			(total_height) = 0 
			(index) = (number_of_console_lines) 
			BEGIN 
				IF (ScreenElementExists) (id) = { (console_message_vmenu) (child) = ( (number_of_console_lines) - <index> ) } 
					(GetScreenElementDims) (id) = { (console_message_vmenu) (child) = ( (number_of_console_lines) - <index> ) } 
					<total_height> = ( <total_height> + <height> ) 
					<index> = ( <index> - 1 ) 
				ELSE 
					BREAK 
				ENDIF 
			REPEAT 
			IF ( <total_height> > <max_chat_height> ) 
				(DestroyScreenElement) (id) = { (console_message_vmenu) (child) = 0 } 
			ELSE 
				BREAK 
			ENDIF 
		REPEAT 
		IF (GotParam) (wait_and_die) 
			(RunScriptOnScreenElement) (id) = <id> (console_message_wait_and_die) (params) = { (time) = <time> } 
			RETURN 
		ENDIF 
		IF NOT (LevelIs) (load_skateshop) 
			IF NOT (GotParam) (dont_die) 
				(RunScriptOnScreenElement) (id) = <id> (console_message_wait_and_die) 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT (hide_console_window) 
	IF (ObjectExists) (id) = (console_message_vmenu) 
		(DoScreenElementMorph) (id) = (console_message_vmenu) (time) = 0 (scale) = 0 
	ENDIF 
ENDSCRIPT

SCRIPT (unhide_console_window) 
	IF (ObjectExists) (id) = (console_message_vmenu) 
		(DoScreenElementMorph) (id) = (console_message_vmenu) (time) = 0 (scale) = 1 
	ENDIF 
ENDSCRIPT

SCRIPT (console_left_justify) 
	IF (ObjectExists) (id) = (console_message_vmenu) 
		(SetScreenElementLock) (id) = (console_message_vmenu) (off) 
		(SetScreenElementProps) { 
			(id) = (console_message_vmenu) 
			(just) = [ (left) (top) ] 
			(internal_just) = [ (left) (center) ] 
		} 
		(SetScreenElementProps) { 
			(id) = (console_message_vmenu) 
			(pos) = PAIR(20.00000000000, 265.00000000000) 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT (console_right_justify) 
	IF (ObjectExists) (id) = (console_message_vmenu) 
		(SetScreenElementLock) (id) = (console_message_vmenu) (off) 
		(SetScreenElementProps) { 
			(id) = (console_message_vmenu) 
			(just) = [ (right) (top) ] 
			(internal_just) = [ (right) (center) ] 
		} 
		(SetScreenElementProps) { 
			(id) = (console_message_vmenu) 
			(pos) = PAIR(620.00000000000, 265.00000000000) 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT (console_hide) 
	IF (ObjectExists) (id) = (console_message_vmenu) 
		(RunScriptOnScreenElement) (id) = (console_message_vmenu) (console_hide2) 
	ENDIF 
ENDSCRIPT

SCRIPT (console_hide2) 
	(DoMorph) (scale) = 0 
ENDSCRIPT

SCRIPT (console_unhide) 
	IF (ObjectExists) (id) = (console_message_vmenu) 
		(RunScriptOnScreenElement) (id) = (console_message_vmenu) (console_unhide2) 
	ENDIF 
ENDSCRIPT

SCRIPT (console_unhide2) 
	(DoMorph) (scale) = 1 
ENDSCRIPT

SCRIPT (console_clear) 
	IF (ScreenElementExists) (id) = (console_message_vmenu) 
		(DestroyScreenElement) (id) = (console_message_vmenu) (preserve_parent) 
	ENDIF 
ENDSCRIPT

SCRIPT (console_destroy) 
	IF (ObjectExists) (id) = (console_message_vmenu) 
		(DestroyScreenElement) (id) = (console_message_vmenu) 
	ENDIF 
ENDSCRIPT

SCRIPT (console_message_wait_and_die) (time) = 30 
	(wait) <time> (seconds) 
	(DoMorph) (time) = 0.50000000000 (alpha) = 0 
	(Die) 
ENDSCRIPT


