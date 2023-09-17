
park_side_to_move = 0 
ThemeIndicesA = [ 1 , 2 , 3 , 4 , 5 , 6 , 7 , 8 , 9 , 10 , 16 , 17 , 19 , 21 , 23 , 24 ] 
ThemeIndicesB = [ 11 , 12 , 13 , 14 , 15 , 18 , 20 , 22 , 25 ] 
SCRIPT DoParkGeneration 
	setgametype creategoals 
	MemPushContext 0 
	PreLevelLoad 
	IF GameModeEquals is_parkeditor 
		IF IsXbox 
			DisplayLoadingScreen "loadscrn_editor_x" 
		ENDIF 
		IF IsNgc 
			DisplayLoadingScreen "loadscrn_editor_ngc" 
		ENDIF 
		IF IsPS2 
			DisplayLoadingScreen "loadscrn_editor" 
		ENDIF 
	ELSE 
		IF IsXbox 
			DisplayLoadingScreen "loadscrn_editor_x" 
		ENDIF 
		IF IsNgc 
			DisplayLoadingScreen "loadscrn_editor_ngc" 
		ENDIF 
		IF IsPS2 
			DisplayLoadingScreen "loadscrn_editor_play" 
		ENDIF 
	ENDIF 
	LaunchLevel Level = custom_park 
	printf "Ryan: finished \'LaunchLevel\' call" 
	PostLevelLoad 
	ResetCamera 
	MemPopContext 
	SetBackgroundColor { r = 0 , g = 0 , b = 0 , alpha = 0 } 
	SetClippingDistances near = 12 far = 22000 
	LaunchConsoleMessage "Stats at 10" 2 
	LoadPreFile "parked_sounds.pre" 
	LoadSound "ParkEd\\GUI_placeblock1" 
	LoadSound "ParkEd\\GUI_removeblock1" 
	LoadSound "ParkEd\\select1" 
	LoadSound "Shared\\Menu\\GUI_buzzer01" 
	UnloadPreFile "parked_sounds.pre" 
ENDSCRIPT

SCRIPT Ed_DropinSkater 
	printf "Ed_DropinSkater" 
	ParkEditorCommand command = SetCustomParkPlay on 
ENDSCRIPT

SCRIPT Ed_RunCommand 
	ParkEditorCommand <...> 
ENDSCRIPT

SCRIPT Ed_ThemeSwitch 
	change_level Level = custom_park game = parkeditor 
ENDSCRIPT

SCRIPT PlayEdPlaceSound 
	PlaySound GUI_placeblock1 vol = 60 
	printf "Play Place Sound" 
ENDSCRIPT

SCRIPT PlayEdEraseSound 
	PlaySound GUI_removeblock1 vol = 60 
ENDSCRIPT

SCRIPT PlayEdChangeSetSound 
	PlaySound select1 vol = 60 
ENDSCRIPT

SCRIPT PlayEdChangePieceSound 
	PlaySound select2b vol = 60 
ENDSCRIPT

SCRIPT PlayEdBuzzSound 
	PlaySound GUI_buzzer01 vol = 60 
ENDSCRIPT

SCRIPT PlayRaiseGroundSound 
	PlaySound MenuUp pitch = 35 
ENDSCRIPT

SCRIPT PlayLowerGroundSound 
	PlaySound MenuUp pitch = 24 
ENDSCRIPT

SCRIPT PlayRotatePieceSound 
	PlaySound menu03 pitch = 55 
ENDSCRIPT


