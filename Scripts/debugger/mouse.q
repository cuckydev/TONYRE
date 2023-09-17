
SCRIPT UpdateDebuggerMousePosition 
	IF NOT ScreenElementExists id = mouse_cursor 
		SetScreenElementLock id = root_window off 
		CreateScreenElement { 
			type = SpriteElement 
			parent = root_window 
			id = mouse_cursor 
			texture = mouse_cursor 
			rgba = [ 128 128 128 85 ] 
			just = [ left top ] 
			z_priority = 3000001 
		} 
	ENDIF 
	SetScreenElementProps id = mouse_cursor pos = ( PAIR(1, 0) * <x> + PAIR(0, 1) * <y> ) 
ENDSCRIPT

SCRIPT DestroyMouseCursor 
	IF ScreenElementExists id = mouse_cursor 
		DestroyScreenElement id = mouse_cursor 
	ENDIF 
	DestroyMouseText 
ENDSCRIPT

SCRIPT DestroyMouseText 
	IF ScreenElementExists id = mouse_text 
		DestroyScreenElement id = mouse_text 
	ENDIF 
ENDSCRIPT

SCRIPT SetMouseText 
	IF NOT ScreenElementExists id = mouse_text 
		SetScreenElementLock id = root_window off 
		CreateScreenElement { 
			id = mouse_text 
			parent = root_window 
			type = TextElement 
			just = [ center bottom ] 
			pos = PAIR(0, 0) 
			font = small 
			scale = 1 
			text = "" 
		} 
	ENDIF 
	SetScreenElementProps id = mouse_text text = <text> pos = ( PAIR(1, 0) * <x> + PAIR(0, 1) * <y> - PAIR(0, 4) ) 
ENDSCRIPT

SCRIPT MouseClickEffect 
	DoMorph id = mouse_text scale = 1.10000002384 time = 0 
	wait 2 gameframes 
	DoMorph id = mouse_text scale = 1 time = 0 
ENDSCRIPT

SCRIPT DoMouseClickEffect 
	IF ScreenElementExists id = mouse_text 
		RunScriptOnScreenElement id = mouse_text MouseClickEffect 
	ENDIF 
ENDSCRIPT


