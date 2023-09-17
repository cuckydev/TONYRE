
SCRIPT create_model_from_appearance 
	LockCurrentSkaterProfileIndex 1 
	ModelClearAllGeoms 
	process_cas_command cas_command = ModelRunScript editable_list = master_editable_list target = disqualify_script 
	process_cas_command cas_command = ModelAddGeom editable_list = master_editable_list 
	process_cas_command cas_command = GeomReplaceTexture editable_list = master_editable_list 
	model_apply_scale 
	process_cas_command cas_command = model_hide_geom editable_list = master_editable_list 
	ModelRemovePolys 
	model_apply_face_texture 
	process_cas_command cas_command = GeomModulateColor editable_list = master_editable_list 
	allocate_uv_matrix_params 
	set_uv_from_appearance 
	ModelFinalize 
	LockCurrentSkaterProfileIndex 0 
ENDSCRIPT

SCRIPT create_ped_model_from_appearance 
	LockCurrentSkaterProfileIndex 1 
	ModelClearAllGeoms 
	process_cas_command cas_command = ModelAddGeom editable_list = ped_editable_list 
	model_apply_scale 
	ModelRemovePolys 
	process_cas_command cas_command = GeomModulateColor editable_list = ped_editable_list 
	ModelFinalize 
	LockCurrentSkaterProfileIndex 0 
ENDSCRIPT

SCRIPT replace_cutscene_skater_from_appearance 
	LockCurrentSkaterProfileIndex 1 
	process_cas_command cas_command = GeomReplaceTexture editable_list = master_editable_list 
	model_apply_face_texture 
	process_cas_command cas_command = GeomModulateColor editable_list = master_editable_list 
	LockCurrentSkaterProfileIndex 0 
ENDSCRIPT

SCRIPT model_apply_face_texture 
	ModelApplyFaceTexture src = "CS_NSN_facemap.png" 
ENDSCRIPT

SCRIPT model_apply_scale 
	<standard_scaling> = 1 
	ModelResetScale 
	IF AppearanceAllowScalingCheat 
		IF GetGlobalFlag flag = CHEAT_KID 
			ModelApplyBodyShape body_shape = kid_scale_info 
			ModelApplyObjectScale body_shape = kid_scale_info 
			<standard_scaling> = 0 
		ENDIF 
		IF GetGlobalFlag flag = CHEAT_BIGHEAD 
			ModelApplyBodyShape body_shape = bighead_scale_info is_bighead_cheat 
			ModelApplyObjectScale body_shape = bighead_scale_info 
			<standard_scaling> = 0 
		ENDIF 
		IF GetGlobalFlag flag = CHEAT_GORILLA 
			ModelApplyBodyShape body_shape = gorilla_scale_info 
			ModelApplyObjectScale body_shape = gorilla_scale_info 
			<standard_scaling> = 0 
		ENDIF 
	ENDIF 
	IF ( <standard_scaling> = 1 ) 
		ModelApplyBodyShape 
		ModelApplyObjectScale 
		process_cas_command cas_command = ModelApplyBoneScale editable_list = master_scaling_list 
	ENDIF 
	IF GetGlobalFlag flag = CHEAT_HOVERBOARD 
		ModelApplyBodyShape body_shape = hoverboard_scale_info 
	ENDIF 
ENDSCRIPT

SCRIPT model_hide_geom 
	<invisible> = 0 
	IF NOT InNetGame 
		IF AppearanceAllowScalingCheat 
			IF GetGlobalFlag flag = CHEAT_INVISIBLE 
				<invisible> = 1 
			ENDIF 
		ENDIF 
	ENDIF 
	IF ChecksumEquals a = <part> b = skater_m_head 
		ModelHideGeom part = <part> <invisible> 
		RETURN 
	ENDIF 
	IF ChecksumEquals a = <part> b = skater_m_hair 
		ModelHideGeom part = <part> <invisible> 
		RETURN 
	ENDIF 
	IF ChecksumEquals a = <part> b = skater_f_head 
		ModelHideGeom part = <part> <invisible> 
		RETURN 
	ENDIF 
	IF ChecksumEquals a = <part> b = skater_f_hair 
		ModelHideGeom part = <part> <invisible> 
		RETURN 
	ENDIF 
	IF ChecksumEquals a = <part> b = body 
		ModelHideGeom part = <part> <invisible> 
		RETURN 
	ENDIF 
ENDSCRIPT

SCRIPT preload_model_from_appearance 
	ModelClearAllGeoms 
	process_cas_command cas_command = ModelAddGeom editable_list = master_editable_list 
ENDSCRIPT

SCRIPT color_model_from_appearance 
	process_cas_command cas_command = GeomModulateColor editable_list = master_editable_list 
ENDSCRIPT

SCRIPT scale_model_from_appearance 
	model_apply_scale 
ENDSCRIPT

SCRIPT hide_model_from_appearance 
	process_cas_command cas_command = model_hide_geom editable_list = master_editable_list 
ENDSCRIPT

SCRIPT allocate_uv_matrix_params 
	GetArraySize master_uv_list 
	<index> = 0 
	BEGIN 
		GeomAllocateUVMatrixParams ( master_uv_list [ <index> ] ) 
		<index> = ( <index> + 1 ) 
	REPEAT <array_size> 
ENDSCRIPT

SCRIPT set_uv_from_appearance 
	GetArraySize master_uv_list 
	<index> = 0 
	BEGIN 
		GeomSetUVOffset ( master_uv_list [ <index> ] ) 
		<index> = ( <index> + 1 ) 
	REPEAT <array_size> 
ENDSCRIPT

SCRIPT process_cas_command editable_list = master_editable_list 
	ForEachIn <editable_list> do = <cas_command> params = <...> 
ENDSCRIPT

SCRIPT preselect_random_parts 
	PreSelectRandomPedMHeads num = <num_m_heads> 
	PreSelectRandomPedMTorsos num = <num_m_torsos> 
	PreSelectRandomPedMLegs num = <num_m_legs> 
	PreSelectRandomPedFHeads num = <num_f_heads> 
	PreSelectRandomPedFTorsos num = <num_f_torsos> 
	PreSelectRandomPedFLegs num = <num_f_legs> 
ENDSCRIPT

SCRIPT PreSelectRandomPedMHeads num = 3 
	PreselectRandomPedestrians part = ped_m_head num = <num> 
ENDSCRIPT

SCRIPT PreSelectRandomPedMTorsos num = 3 
	PreselectRandomPedestrians part = ped_m_torso num = <num> 
ENDSCRIPT

SCRIPT PreSelectRandomPedMLegs num = 3 
	PreselectRandomPedestrians part = ped_m_legs num = <num> 
ENDSCRIPT

SCRIPT PreSelectRandomPedFHeads num = 3 
	PreselectRandomPedestrians part = ped_f_head num = <num> 
ENDSCRIPT

SCRIPT PreSelectRandomPedFTorsos num = 3 
	PreselectRandomPedestrians part = ped_f_torso num = <num> 
ENDSCRIPT

SCRIPT PreSelectRandomPedFLegs num = 2 
	PreselectRandomPedestrians part = ped_f_legs num = <num> 
ENDSCRIPT


