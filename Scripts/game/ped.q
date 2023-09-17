
SCRIPT gameobj_add_components 
	IF GotParam animName 
		CreateComponentFromStructure component = animation <...> 
	ENDIF 
	IF GotParam skeletonName 
		CreateComponentFromStructure component = skeleton <...> skeleton = <skeletonName> 
	ENDIF 
	<is_level_obj> = 0 
	IF GotParam class 
		IF ChecksumEquals a = <class> b = LevelObject 
			<is_level_obj> = 1 
		ENDIF 
	ENDIF 
	IF ( <is_level_obj> = 1 ) 
		CreateComponentFromStructure component = model <...> 
	ELSE 
		IF GotParam model 
			IF NOT StringEquals a = <model> b = "none" 
				CreateComponentFromStructure component = model <...> 
			ENDIF 
		ENDIF 
	ENDIF 
	CreateComponentFromStructure component = collision <...> 
ENDSCRIPT

SCRIPT ped_add_components 
	CreateComponentFromStructure component = avoid 
	IF NOT GotParam NoPedLogic 
		CreateComponentFromStructure component = pedlogic <...> 
	ENDIF 
	CreateComponentFromStructure component = SkaterLoopingSound <...> volume_mult = 0.20000000298 
	CreateComponentFromStructure component = SkaterSound <...> volume_mult = 0.20000000298 
	IF ( ( InNetGame ) | ( LevelIs load_sk5ed ) | ( LevelIs load_sk5ed_gameplay ) ) 
		GetAnimEventTableName animName = thps5_human 
		CreateComponentFromStructure { 
			component = animation 
			<...> 
			animName = animload_thps5_human 
			animEventTableName = <animEventTableName> 
		} 
		CreateComponentFromStructure component = skeleton <...> skeletonName = thps5_human 
	ELSE 
		IF GotParam animName 
			IF NOT GotParam animEventTableName 
				GetAnimEventTableName animName = <animName> 
			ENDIF 
			IF NOT GotParam defaultAnimName 
				IF ChecksumEquals a = <skeletonName> b = thps5_human 
					<defaultAnimName> = WStandIdle1 
				ENDIF 
				IF NOT ( have_loaded_net ) 
					IF ChecksumEquals a = <skeletonName> b = Ped_Female 
						<defaultAnimName> = Ped_F_Idle1 
					ENDIF 
				ENDIF 
			ENDIF 
			CreateComponentFromStructure component = animation animEventTableName = <animEventTableName> <...> 
		ENDIF 
		IF GotParam skeletonName 
			CreateComponentFromStructure component = skeleton <...> skeleton = <skeletonName> 
		ENDIF 
	ENDIF 
	CreateComponentFromStructure component = model 
	IF NOT GotParam ShadowOff 
		CreateComponentFromStructure component = shadow <...> ShadowType = simple 
	ENDIF 
ENDSCRIPT

SCRIPT ped_init_model 
	IF InNetGame 
		Obj_InitModel model = "Peds/Ped_Judge/Ped_Judge.skin" use_asset_manager = 1 
		RETURN 
	ENDIF 
	IF ( ( LevelIs load_sk5ed ) | ( LevelIs load_sk5ed_gameplay ) ) 
		ChooseRandomCreatedGoalPedModel 
		RETURN 
	ENDIF 
	IF GotParam profile 
		Obj_InitModelFromProfile struct = <profile> use_asset_manager = 1 buildscript = create_ped_model_from_appearance 
	ELSE 
		IF NOT GotParam model 
			script_assert "no model name!" 
		ENDIF 
		Obj_InitModel model = <model> use_asset_manager = 1 
	ENDIF 
	Obj_GetID 
	RunScriptOnObject id = <objID> set_ped_anim_handlers 
ENDSCRIPT

SCRIPT ped_disable_bones 
	Obj_SetBoneActive bone = Cloth_Cuff_L active = 0 
	Obj_SetBoneActive bone = Cloth_Cuff_R active = 0 
	Obj_SetBoneActive bone = Cloth_Hat active = 0 
	Obj_SetBoneActive bone = Cloth_Shirt_L active = 0 
	Obj_SetBoneActive bone = Cloth_Shirt_C active = 0 
	Obj_SetBoneActive bone = Cloth_Shirt_R active = 0 
	Obj_SetBoneActive bone = Cloth_Trouser_L active = 0 
	Obj_SetBoneActive bone = Cloth_Trouser_R active = 0 
ENDSCRIPT

SCRIPT Ped_Printf 
	IF IsTrue ped_debug 
		printf <...> 
	ENDIF 
ENDSCRIPT

SCRIPT Ped_PrintStruct 
	IF IsTrue ped_debug 
		PrintStruct <...> 
	ENDIF 
ENDSCRIPT

SCRIPT Ped_Assert 
	IF IsTrue ped_debug 
		printf "SCRIPT ASSERT!" 
		printf <...> 
		BEGIN 
		REPEAT 
	ENDIF 
ENDSCRIPT

SCRIPT Ped_PrintTags 
	IF IsTrue ped_debug 
		GetTags 
		PrintStruct <...> 
	ENDIF 
ENDSCRIPT


