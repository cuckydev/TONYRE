
select_shift = 1 
memcard_screenshots = 0 
skater_cam_0_mode = 2 
skater_cam_1_mode = 2 
SCRIPT UserSelectSelect 
	IF NOT isngc 
		IF ObjectExists id = skatercam0 
			SWITCH skater_cam_0_mode 
				CASE 1 
					change skater_cam_0_mode = 2 
				CASE 2 
					change skater_cam_0_mode = 3 
				CASE 3 
					change skater_cam_0_mode = 4 
				CASE 4 
					change skater_cam_0_mode = 1 
			ENDSWITCH 
			skatercam0 : sc_setmode mode = skater_cam_0_mode 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT UserSelectSelect2 
	IF NOT isngc 
		IF ObjectExists id = skatercam1 
			SWITCH skater_cam_1_mode 
				CASE 1 
					change skater_cam_1_mode = 2 
				CASE 2 
					change skater_cam_1_mode = 3 
				CASE 3 
					change skater_cam_1_mode = 4 
				CASE 4 
					change skater_cam_1_mode = 1 
			ENDSWITCH 
			skatercam1 : sc_setmode mode = skater_cam_1_mode 
		ENDIF 
	ENDIF 
ENDSCRIPT

view_mode = 0 
render_mode = 0 
wireframe_mode = 0 
drop_in_car = 0 
drop_in_car_setup = MiniBajaCarSetup 
SCRIPT UserSelectTriangle 
	IF NotCD 
		SWITCH render_mode 
			CASE 0 
				change render_mode = 1 
				show_wireframe_mode 
			CASE 1 
				change render_mode = 2 
				show_wireframe_mode 
			CASE 2 
				change render_mode = 0 
		ENDSWITCH 
		setRenderMode mode = render_mode 
	ENDIF 
ENDSCRIPT

SCRIPT UserSelectSquare 
	IF NotCD 
		ScreenShot 
	ENDIF 
ENDSCRIPT

SCRIPT UserSelectCircle 
	IF NotCD 
		IF ( render_mode ) 
			SWITCH wireframe_mode 
				CASE 0 
					change wireframe_mode = 1 
				CASE 1 
					change wireframe_mode = 2 
				CASE 2 
					change wireframe_mode = 3 
				CASE 3 
					change wireframe_mode = 4 
				CASE 4 
					change wireframe_mode = 5 
				CASE 5 
					change wireframe_mode = 6 
				CASE 6 
					change wireframe_mode = 0 
			ENDSWITCH 
			setwireframemode mode = wireframe_mode 
			show_wireframe_mode 
		ELSE 
			IF Skater : Driving 
				ToggleUserControlledVehicleMode 
			ENDIF 
			UnpauseSkaters 0 
			IF ( drop_in_car = 0 ) 
				Skater : PlaceBeforeCamera 
				Restore_skater_camera 
				change view_mode = 0 
				ToggleViewMode 
				ToggleViewMode 
				ToggleViewMode 
			ELSE 
				MakeSkaterGoto Switch_OnGroundAI Params = { NewScript = TransAm VehicleSetup = drop_in_car_setup edited_goal } 
				SetActiveCamera id = viewer_cam 
				PlayerVehicle : Vehicle_PlaceBeforeCamera 
				change view_mode = 0 
				ToggleViewMode 
				ToggleViewMode 
				ToggleViewMode 
				SetActiveCamera id = PlayerVehicleCamera 
				Skater : PausePhysics 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT UserSelectStart 
	IF NotCD 
		change render_mode = 0 
		setRenderMode mode = render_mode 
		TogglePass pass = 0 
	ENDIF 
ENDSCRIPT

SCRIPT ToggleViewMode 
	SWITCH view_mode 
		CASE 0 
			change view_mode = 1 
		CASE 1 
			change view_mode = 2 
		CASE 2 
			change view_mode = 0 
	ENDSWITCH 
	SetViewMode view_mode 
ENDSCRIPT

SCRIPT UserSelectX 
	change viewer_rotation_angle = 0 
	ToggleViewMode 
ENDSCRIPT

viewer_rotation_angle = 0 
SCRIPT UserViewerX 
	IF ( viewer_rotation_angle = 0 ) 
		change viewer_rotation_angle = 1 
		CenterCamera scale = 0.50000000000 y = -45 
	ELSE 
		IF ( viewer_rotation_angle = 1 ) 
			CenterCamera scale = 0.50000000000 y = -135 
			change viewer_rotation_angle = 2 
		ELSE 
			IF ( viewer_rotation_angle = 2 ) 
				change viewer_rotation_angle = 3 
				CenterCamera scale = 0.50000000000 y = -225 
			ELSE 
				IF ( viewer_rotation_angle = 3 ) 
					change viewer_rotation_angle = 0 
					CenterCamera scale = 0.50000000000 y = -315 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT UserViewerSquare 
	IF ( viewer_rotation_angle = 0 ) 
		change viewer_rotation_angle = 1 
		CenterCamera x = -10 y = -90 scale = 0.69999998808 
	ELSE 
		IF ( viewer_rotation_angle = 1 ) 
			CenterCamera x = -10 y = -180 scale = 0.69999998808 
			change viewer_rotation_angle = 2 
		ELSE 
			IF ( viewer_rotation_angle = 2 ) 
				change viewer_rotation_angle = 3 
				CenterCamera x = -10 y = -270 scale = 0.69999998808 
			ELSE 
				IF ( viewer_rotation_angle = 3 ) 
					change viewer_rotation_angle = 0 
					CenterCamera x = -10 y = 0 scale = 0.69999998808 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

Viewer_move_mode = 0 
SCRIPT UserViewerCircle 
	change viewer_rotation_angle = 0 
	SWITCH Viewer_move_mode 
		CASE 0 
			change Viewer_move_mode = 1 
			SetMovementVelocity 400 
			SetRotateVelocity 120 
			create_panel_message id = viewermovemode text = "Med cam" pos = PAIR(320.00000000000, 50.00000000000) 
		CASE 1 
			change Viewer_move_mode = 2 
			SetMovementVelocity 6000 
			SetRotateVelocity 300 
			create_panel_message id = viewermovemode text = "Fast cam" pos = PAIR(320.00000000000, 50.00000000000) 
		CASE 2 
			change Viewer_move_mode = 0 
			SetMovementVelocity 100 
			SetRotateVelocity 50 
			create_panel_message id = viewermovemode text = "Super Slow cam" pos = PAIR(320.00000000000, 50.00000000000) 
	ENDSWITCH 
ENDSCRIPT

SCRIPT UserViewerTriangle 
	change viewer_rotation_angle = 0 
	CenterCamera x = -90 y = 0 scale = 0.69999998808 
ENDSCRIPT

SCRIPT show_wireframe_mode 
	SWITCH wireframe_mode 
		CASE 0 
			wireframe_message text = "Wireframe : Face Flags" 
		CASE 1 
			wireframe_message text = "Wireframe : Poly Density" 
		CASE 2 
			wireframe_message text = "Wireframe : Low Poly Highlight" 
		CASE 3 
			wireframe_message text = "Wireframe : Unique object colors" 
		CASE 4 
			wireframe_message text = "Wireframe : Renderable Unique MESH colors" 
		CASE 5 
			wireframe_message text = "Wireframe : Renderable MESH vertex density" 
		CASE 6 
			wireframe_message text = "Wireframe : Occlusion Map" 
	ENDSWITCH 
ENDSCRIPT

SCRIPT wireframe_message text = "wireframe" 
	create_panel_message text = <text> id = wireframe_mess rgba = [ 200 128 128 128 ] pos = PAIR(20.00000000000, 340.00000000000) just = [ left center ] scale = 5 style = wireframe_style 
ENDSCRIPT

SCRIPT wireframe_style 
	DoMorph time = 0 scale = PAIR(1.00000000000, 1.00000000000) 
	DoMorph time = 3 scale = PAIR(1.00000000000, 1.00000000000) 
	DoMorph time = 1 alpha = 0 
	die 
ENDSCRIPT


