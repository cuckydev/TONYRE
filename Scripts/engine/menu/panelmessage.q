
SCRIPT kill_panel_message_if_it_exists 
	IF ScreenElementExists id = <id> 
		DestroyScreenElement id = <id> 
	ENDIF 
ENDSCRIPT

SCRIPT create_panel_message { text = "Default panel message" 
		pos = PAIR(320, 70) 
		rgba = [ 144 32 32 100 ] 
		font_face = small 
		time = 1500 
		z_priority = -5 
		just = [ center center ] 
	} 
	IF GotParam id 
		kill_panel_message_if_it_exists id = <id> 
	ENDIF 
	SetScreenElementLock id = root_window off 
	CreateScreenElement { 
		type = textelement 
		parent = root_window 
		id = <id> 
		font = <font_face> 
		text = <text> 
		scale = 1 
		pos = <pos> 
		just = <just> 
		rgba = <rgba> 
		z_priority = <z_priority> 
		not_focusable 
	} 
	RecordPanelMessage <...> 
	IF GotParam style 
		IF GotParam params 
			RunScriptOnScreenElement id = <id> <style> params = <params> 
		ELSE 
			RunScriptOnScreenElement id = <id> <style> params = <...> 
		ENDIF 
	ELSE 
		RunScriptOnScreenElement id = <id> panel_message_wait_and_die params = { time = <time> } 
	ENDIF 
ENDSCRIPT

SCRIPT create_panel_sprite { pos = PAIR(320, 60) 
		rgba = [ 128 128 128 100 ] 
		z_priority = -5 
	} 
	IF GotParam id 
		IF ObjectExists id = <id> 
			RunScriptOnScreenElement id = <id> kill_panel_message 
		ENDIF 
	ENDIF 
	SetScreenElementLock id = root_window off 
	CreateScreenElement { 
		type = spriteelement parent = root_window 
		texture = <texture> 
		id = <id> 
		scale = 1 
		pos = <pos> 
		just = [ center center ] 
		rgba = <rgba> 
		z_priority = <z_priority> 
	} 
	IF GotParam style 
		IF GotParam params 
			RunScriptOnScreenElement id = <id> <style> params = <params> 
		ELSE 
			RunScriptOnScreenElement id = <id> <style> params = <...> 
		ENDIF 
	ELSE 
		IF GotParam time 
			RunScriptOnScreenElement id = <id> panel_message_wait_and_die params = { time = <time> } 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT create_panel_block { text = "Default panel message" 
		pos = PAIR(320, 60) 
		dims = PAIR(250, 0) 
		rgba = [ 144 32 32 100 ] 
		font_face = small 
		time = 2000 
		just = [ center center ] 
		internal_just = [ center center ] 
		z_priority = -5 
	} 
	SetScreenElementLock id = root_window off 
	IF GotParam id 
		IF ObjectExists id = <id> 
			DestroyScreenElement id = <id> 
		ENDIF 
	ENDIF 
	CreateScreenElement { 
		type = TextBlockElement 
		parent = root_window 
		id = <id> 
		font = <font_face> 
		text = <text> 
		dims = <dims> 
		pos = <pos> 
		just = <just> 
		internal_just = <internal_just> 
		line_spacing = <line_spacing> 
		rgba = <rgba> 
		allow_expansion 
		z_priority = <z_priority> 
	} 
	IF GotParam style 
		IF GotParam params 
			RunScriptOnScreenElement id = <id> <style> params = <params> 
		ELSE 
			RunScriptOnScreenElement id = <id> <style> params = <...> 
		ENDIF 
	ELSE 
		RunScriptOnScreenElement id = <id> panel_message_wait_and_die params = { time = <time> } 
	ENDIF 
ENDSCRIPT

SCRIPT panel_message_wait_and_die time = 1500 
	wait <time> 
	Die 
ENDSCRIPT

SCRIPT kill_panel_message 
	Die 
ENDSCRIPT

SCRIPT hide_panel_message 
	IF ObjectExists id = <id> 
		SetScreenElementProps { 
			id = <id> 
			hide 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT show_panel_message 
	IF ObjectExists id = <id> 
		SetScreenElementProps { 
			id = <id> 
			unhide 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT destroy_panel_message 
	IF ObjectExists id = <id> 
		<id> : Die 
	ENDIF 
ENDSCRIPT

SCRIPT panel_message_landing time = 1200 
	SetProps font = newtrickfont just = [ center top ] rgba = [ 144 32 32 75 ] 
	DoMorph time = 0 pos = PAIR(80, 240) scale = 0 
	DoMorph time = 0.50000000000 scale = 0.69999998808 alpha = 1.00000000000 
	wait <time> 
	DoMorph time = 0.25000000000 alpha = 0.00000000000 scale = 0 
	Die 
ENDSCRIPT

SCRIPT panel_message_loading 
	SetProps font = small just = [ center center ] rgba = [ 128 200 128 70 ] 
	DoMorph pos = PAIR(320.00000000000, 224.00000000000) scale = 5 time = 0 
	wait 5 
	Die 
ENDSCRIPT


