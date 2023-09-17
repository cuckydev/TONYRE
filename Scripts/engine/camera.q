
camera_fov = 72.00000000000 
widescreen_camera_fov = 88.18000030518 
compact_camera_fov = 80.00000000000 
current_screen_mode = standard_screen_mode 
SCRIPT screen_setup_standard 
	SetScreen Aspect = 1.33333325386 Angle = camera_fov letterbox = 0 
	UnSetGlobalFlag flag = SCREEN_MODE_WIDE 
	SetGlobalFlag flag = SCREEN_MODE_STANDARD 
	change current_screen_mode = standard_screen_mode 
	printf "change to standard" 
	IF GotParam mm_bg 
		IF LevelIs load_skateshop 
			make_mainmenu_3d_plane 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT screen_setup_widescreen 
	SetScreen Aspect = 1.77777767181 Angle = widescreen_camera_fov letterbox = 0 
	UnSetGlobalFlag flag = SCREEN_MODE_STANDARD 
	SetGlobalFlag flag = SCREEN_MODE_WIDE 
	change current_screen_mode = widescreen_screen_mode 
	printf "change to widescreen" 
	IF GotParam mm_bg 
		IF LevelIs load_skateshop 
			make_mainmenu_3d_plane 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT screen_setup_letterbox 
	SetScreen Aspect = 1.77777767181 Angle = widescreen_camera_fov letterbox = 1 
	SetGlobalFlag flag = SCREEN_MODE_STANDARD 
	SetGlobalFlag flag = SCREEN_MODE_WIDE 
	change current_screen_mode = letterbox_screen_mode 
	printf "change to letterbox" 
	IF GotParam mm_bg 
		IF LevelIs load_skateshop 
			make_mainmenu_3d_plane 
		ENDIF 
	ENDIF 
ENDSCRIPT


