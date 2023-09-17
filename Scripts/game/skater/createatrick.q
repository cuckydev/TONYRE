
MAX_CREATED_TRICKS = 11 
CAT_BLEND = 0.15000000596 
cat_done = 1 
demo_flipped_cat_skater = 0 
Default_CAT_other_info = { name = "" full = 0 can_spin = 1 } 
Default_CAT_rotation_info = [ 
	{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
	{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
	{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
	{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
	{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
	{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
] 
Default_CAT_animation_info = [ 
	{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 1 hold = 0 backwards = 0 } 
	{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 2 hold = 0 backwards = 0 } 
	{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 3 hold = 0 backwards = 0 } 
	{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 4 hold = 0 backwards = 0 } 
	{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 5 hold = 0 backwards = 0 } 
	{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 6 hold = 0 backwards = 0 } 
] 
SCRIPT get_new_cat_values 
	printf "script get_new_cat_values" 
	name = "" 
	full = 1 
	can_spin = 1 
	rotation_info = ( Default_CAT_rotation_info ) 
	animation_info = ( Default_CAT_animation_info ) 
	RETURN <...> 
ENDSCRIPT

SCRIPT CreateATrick 
	printf "CreateATrick" 
	GetCurrentSkaterProfileIndex 
	change cat_done = 0 
	CAT_SetHoldTime 0.00000000000 skater = <currentSkaterProfileIndex> 
	CAT_SetAnimsDone 1 skater = <currentSkaterProfileIndex> 
	CAT_SetRotsDone 1 skater = <currentSkaterProfileIndex> 
	OnExitRun created_trick_cleanup 
	get_CAT_param_values skater = 0 trick_index = <trick_index> 
	IF GotParam demo_loop 
		CAT_Skater : Obj_EnableAnimBlending enabled = 1 
		CAT_Skater : Obj_SetOrientation y = 0 
	ELSE 
		ClearTricksFrom Jumptricks Jumptricks0 Jumptricks 
		KillExtraTricks 
		Bailon 
		IF GotParam FromGroundGone 
			SetEventHandler Ex = Ollied Scr = TrickOllie 
		ELSE 
			ClearException Ollied 
		ENDIF 
	ENDIF 
	no_rotations = 1 
	bailtime = 0 
	animtime = 0 
	GetArraySize <rotation_info> 
	index = 0 
	BEGIN 
		IF ( ( ( <rotation_info> [ <index> ] ) . on ) = 1 ) 
			no_rotations = 0 
			CAT_SetRotsDone 0 skater = <currentSkaterProfileIndex> 
			BREAK 
		ENDIF 
		index = ( <index> + 1 ) 
	REPEAT <array_size> 
	IF ( <can_spin> = 0 ) 
		IF NOT GotParam demo_loop 
			NoSpin 
		ENDIF 
	ENDIF 
	index = 0 
	IF ( <no_rotations> = 0 ) 
		BEGIN 
			IF ( ( ( <rotation_info> [ <index> ] ) . on ) = 1 ) 
				Dur = ( ( <rotation_info> [ <index> ] ) . Dur ) 
				start = ( ( <rotation_info> [ <index> ] ) . start ) 
				IF ( ( <Dur> + <start> ) > <bailtime> ) 
					bailtime = ( <Dur> + <start> ) 
					last_rot = <index> 
				ENDIF 
			ENDIF 
			index = ( <index> + 1 ) 
		REPEAT <array_size> 
		index = 0 
		BEGIN 
			IF ( ( ( <rotation_info> [ <index> ] ) . on ) = 1 ) 
				Dur = ( ( <rotation_info> [ <index> ] ) . Dur ) 
				start = ( ( <rotation_info> [ <index> ] ) . start ) 
				IF ( <index> = <last_rot> ) 
					last = 1 
				ENDIF 
				spawn_rotation_script { Axis = ( ( <rotation_info> [ <index> ] ) . Axis ) 
					Deg = ( ( <rotation_info> [ <index> ] ) . Deg ) 
					Dur = ( ( <rotation_info> [ <index> ] ) . Dur ) 
					start = ( ( <rotation_info> [ <index> ] ) . start ) 
					off_x = ( ( <rotation_info> [ <index> ] ) . off_x ) 
					off_y = ( ( <rotation_info> [ <index> ] ) . off_y ) 
					off_z = ( ( <rotation_info> [ <index> ] ) . off_z ) 
					deg_dir = ( ( <rotation_info> [ <index> ] ) . deg_dir ) 
					last = <last> 
					demo_loop = <demo_loop> 
				} 
			ENDIF 
			RemoveParameter last 
			index = ( <index> + 1 ) 
		REPEAT <array_size> 
	ENDIF 
	GetArraySize <animation_info> 
	index = 0 
	CAT_SetNumAnims 0 skater = <currentSkaterProfileIndex> 
	BEGIN 
		IF ( ( ( <animation_info> [ <index> ] ) . on ) = 1 ) 
			GetCurrentSkaterProfileIndex 
			CAT_GetNumAnims skater = <currentSkaterProfileIndex> 
			CAT_SetNumAnims ( <num_animations_on> + 1 ) skater = <currentSkaterProfileIndex> 
		ENDIF 
		index = ( <index> + 1 ) 
	REPEAT <array_size> 
	count = 1 
	anim_order = [ 0 , 0 , 0 , 0 , 0 , 0 ] 
	BEGIN 
		index = 0 
		BEGIN 
			IF ( ( ( <animation_info> [ <index> ] ) . order ) = <count> ) 
				SetArrayElement ArrayName = anim_order index = ( <count> -1 ) newvalue = <index> 
				BREAK 
			ENDIF 
			index = ( <index> + 1 ) 
		REPEAT <array_size> 
		count = ( <count> + 1 ) 
	REPEAT <array_size> 
	GetCurrentSkaterProfileIndex 
	CAT_GetNumAnims skater = <currentSkaterProfileIndex> 
	IF ( <num_animations_on> > 0 ) 
		CAT_SetAnimsDone 0 skater = <currentSkaterProfileIndex> 
		Obj_Spawnscript spawned_trick_anim Params = { animation_info = <animation_info> 
			array_size = <array_size> 
			anim_order = <anim_order> 
			demo_loop = <demo_loop> 
		} 
	ENDIF 
	index = 0 
	BEGIN 
		IF ( ( ( <animation_info> [ <index> ] ) . on ) = 1 ) 
			IF NOT ( ( ( <animation_info> [ <index> ] ) . trickType ) = 4 ) 
				trick_got_idle trick = ( ( <animation_info> [ <index> ] ) . trick ) 
				IF ( <got_idle> = 1 ) 
					animtime = ( <animtime> + ( ( <animation_info> [ <index> ] ) . Dur ) + ( ( <animation_info> [ <index> ] ) . idletime ) + ( ( <animation_info> [ <index> ] ) . start ) ) 
				ELSE 
					animtime = ( <animtime> + ( ( <animation_info> [ <index> ] ) . Dur ) + ( ( <animation_info> [ <index> ] ) . start ) ) 
				ENDIF 
			ENDIF 
		ENDIF 
		index = ( <index> + 1 ) 
	REPEAT <array_size> 
	IF ( <animtime> > <bailtime> ) 
		bailtime = <animtime> 
	ENDIF 
	CAT_SetBailDone 0 skater = <currentSkaterProfileIndex> 
	Obj_Spawnscript waitforbailoff Params = { time = <bailtime> } 
	IF NOT GotParam demo_loop 
		Obj_Spawnscript cat_update_trick_string Params = { name = <name> bailtime = <bailtime> can_spin = <can_spin> } 
	ENDIF 
	BEGIN 
		IF GotParam FromGroundGone 
			IF AirTimeGreaterThan Skater_Late_Jump_Slop 
				ClearException Ollied 
				RemoveParameter FromGroundGone 
			ENDIF 
		ENDIF 
		CAT_GetBailDone skater = <currentSkaterProfileIndex> 
		IF ( <bailtimescriptdone> = 1 ) 
			BREAK 
		ENDIF 
		wait 1 gameframe 
	REPEAT 
	IF GotParam FromGroundGone 
		ClearException Ollied 
	ENDIF 
	IF NOT GotParam demo_loop 
		Bailoff 
		CanSpin 
		DoNextTrick 
	ENDIF 
	BEGIN 
		CAT_GetAnimsDone skater = <currentSkaterProfileIndex> 
		IF ( <cat_animations_done> = 1 ) 
			BREAK 
		ENDIF 
		wait 1 gameframe 
	REPEAT 
	BEGIN 
		CAT_GetRotsDone skater = <currentSkaterProfileIndex> 
		IF ( <cat_rotations_done> = 1 ) 
			BREAK 
		ENDIF 
		wait 1 gameframe 
	REPEAT 
	printf "FINISHED CREATEATRICK" 
	change cat_done = 1 
	IF GotParam demo_loop 
		IF ( demo_flipped_cat_skater = 1 ) 
			Obj_Flip 
			change demo_flipped_cat_skater = 0 
		ENDIF 
		RETURN 
	ENDIF 
	goto Airborne 
ENDSCRIPT

SCRIPT spawn_rotation_script Axis = x 
	GetCurrentSkaterProfileIndex 
	CAT_SetTotalY 0 skater = <currentSkaterProfileIndex> 
	CAT_SetTotalX 0 skater = <currentSkaterProfileIndex> 
	CAT_SetTotalZ 0 skater = <currentSkaterProfileIndex> 
	IF ( <Axis> = x ) 
		Obj_Spawnscript RotateOnAxis PauseWithObject Params = { Axis = <Axis> 
			Dur = <Dur> 
			start_val = <start> 
			StartAngle = 0 
			EndAngle = <Deg> 
			off_x = <off_x> 
			off_y = <off_y> 
			off_z = <off_z> 
			last = <last> 
			deg_dir = <deg_dir> 
			demo_loop = <demo_loop> 
		} 
	ELSE 
		StartAngle = 0 
		EndAngle = <Deg> 
		IF NOT GotParam demo_loop 
			IF flipped 
				EndAngle = ( -1 * <Deg> ) 
			ENDIF 
		ENDIF 
		Obj_Spawnscript RotateOnAxis PauseWithObject Params = { Axis = <Axis> 
			Dur = <Dur> 
			start_val = <start> 
			StartAngle = <StartAngle> 
			EndAngle = <EndAngle> 
			off_x = <off_x> 
			off_y = <off_y> 
			off_z = <off_z> 
			last = <last> 
			deg_dir = <deg_dir> 
			demo_loop = <demo_loop> 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT RotateOnAxis { off_x = 0 off_y = 30 off_z = 0 Axis = x } 
	GetCurrentSkaterProfileIndex 
	IF GotParam start_val 
		wait <start_val> seconds 
	ENDIF 
	RotationOffset = ( ( VECTOR(1.00000000000, 0.00000000000, 0.00000000000) * <off_x> ) + ( VECTOR(0.00000000000, 1.00000000000, 0.00000000000) * <off_y> ) + ( VECTOR(0.00000000000, 0.00000000000, 1.00000000000) * <off_z> ) ) 
	IF ( <deg_dir> = 1 ) 
		EndAngle = ( <EndAngle> * -1 ) 
	ENDIF 
	RotateDisplay { <Axis> 
		Duration = <Dur> seconds 
		EndAngle = <EndAngle> 
		SinePower = 1 
		RotationOffset = <RotationOffset> 
		HoldOnLastAngle 
	} 
	CAT_GetTotalX skater = <currentSkaterProfileIndex> 
	CAT_GetTotalY skater = <currentSkaterProfileIndex> 
	CAT_GetTotalZ skater = <currentSkaterProfileIndex> 
	SWITCH <Axis> 
		CASE x 
			total_X_angle = ( <total_X_angle> + <EndAngle> ) 
			CAT_SetTotalX <total_X_angle> skater = <currentSkaterProfileIndex> 
		CASE y 
			total_Y_angle = ( <total_Y_angle> + <EndAngle> ) 
			CAT_SetTotalY <total_Y_angle> skater = <currentSkaterProfileIndex> 
		CASE z 
			total_Z_angle = ( <total_Z_angle> + <EndAngle> ) 
			CAT_SetTotalZ <total_Z_angle> skater = <currentSkaterProfileIndex> 
		DEFAULT 
			printf "CAT: Bad Axis value" 
			RETURN 
	ENDSWITCH 
	mod_x = ( <total_X_angle> - ( <total_X_angle> / 360 ) * 360 ) 
	mod_y = ( <total_Y_angle> - ( <total_Y_angle> / 360 ) * 360 ) 
	mod_z = ( <total_Z_angle> - ( <total_Z_angle> / 360 ) * 360 ) 
	IF NOT ( <mod_y> = 0 ) 
		flip_skater = 1 
	ELSE 
		flip_skater = 0 
	ENDIF 
	IF NOT ( <mod_x> = 0 ) 
		IF NOT ( <mod_z> = 0 ) 
			IF ( <flip_skater> = 1 ) 
				flip_skater = 0 
			ELSE 
				flip_skater = 1 
			ENDIF 
		ENDIF 
	ENDIF 
	IF ( <flip_skater> = 1 ) 
		CAT_SetFlipSkater 1 skater = <currentSkaterProfileIndex> 
	ELSE 
		CAT_SetFlipSkater 0 skater = <currentSkaterProfileIndex> 
	ENDIF 
	IF GotParam last 
		wait <Dur> seconds 
		IF NOT GotParam demo_loop 
			IF ( <flip_skater> = 1 ) 
				CAT_SetFlipSkater 0 skater = <currentSkaterProfileIndex> 
				rotate y = 180 
			ENDIF 
			CancelRotateDisplay 
		ENDIF 
		CAT_SetRotsDone 1 skater = <currentSkaterProfileIndex> 
	ENDIF 
ENDSCRIPT

SCRIPT spawned_trick_anim 
	index = 0 
	tweak_grab = 99 
	anims_played_this_trick = 0 
	have_played_real_anim = 0 
	GetCurrentSkaterProfileIndex 
	BEGIN 
		IF ( ( ( <animation_info> [ <index> ] ) . on ) = 1 ) 
			IF ( ( ( <animation_info> [ <index> ] ) . hold ) = 1 ) 
				tweak_grab = <index> 
			ENDIF 
		ENDIF 
		index = ( <index> + 1 ) 
	REPEAT <array_size> 
	index = 0 
	count = 0 
	BEGIN 
		index = ( <anim_order> [ <count> ] ) 
		IF ( ( ( <animation_info> [ <index> ] ) . on ) = 1 ) 
			blend = ( ( <animation_info> [ <index> ] ) . blend ) 
			from = ( ( <animation_info> [ <index> ] ) . from ) 
			Dur = ( ( <animation_info> [ <index> ] ) . Dur ) 
			start = ( ( <animation_info> [ <index> ] ) . start ) 
			trickType = ( ( <animation_info> [ <index> ] ) . trickType ) 
			trick = ( ( <animation_info> [ <index> ] ) . trick ) 
			idletime = ( ( <animation_info> [ <index> ] ) . idletime ) 
			<backwards> = ( ( <animation_info> [ <index> ] ) . backwards ) 
			trick_got_idle trick = <trick> 
			IF NOT IsArray <trick> 
				SpecialItem_details = ( <trick> . Params . SpecialItem_details ) 
				SpecialSounds = ( <trick> . Params . SpecialSounds ) 
				Stream = ( <trick> . Params . Stream ) 
			ELSE 
				SpecialItem_details = ( ( <trick> [ 0 ] ) . Params . SpecialItem_details ) 
				SpecialSounds = ( ( <trick> [ 0 ] ) . Params . SpecialSounds ) 
				Stream = ( ( <trick> [ 0 ] ) . Params . Stream ) 
			ENDIF 
			TurnOffSpecialItem 
			IF ( <trickType> = 4 ) 
				IF NOT GotParam demo_loop 
					Obj_Spawnscript spawned_cat_sound_script Params = { start = <start> Stream = <Stream> } 
				ENDIF 
				anims_played_this_trick = ( <anims_played_this_trick> + 1 ) 
				GetCurrentSkaterProfileIndex 
				CAT_GetNumAnims skater = <currentSkaterProfileIndex> 
				printf "\tplayed %p / %o anims" p = <anims_played_this_trick> o = <num_animations_on> 
				IF ( <anims_played_this_trick> = <num_animations_on> ) 
					Obj_Spawnscript are_cat_anims_done Params = { no_wait flip_skater = <flip_skater> demo_loop = <demo_loop> } 
					RETURN 
				ENDIF 
			ELSE 
				IF ( <got_idle> = 1 ) 
					IF NOT IsArray <trick> 
						anim = ( <trick> . Params . anim ) 
						idle = ( <trick> . Params . idle ) 
						IF StructureContains structure = ( <trick> . Params ) outanim 
							outanim = ( <trick> . Params . outanim ) 
						ENDIF 
					ELSE 
						anim = ( ( <trick> [ 0 ] ) . Params . anim ) 
						idle = ( ( <trick> [ 0 ] ) . Params . idle ) 
						IF StructureContains structure = ( ( <trick> [ 0 ] ) . Params ) outanim 
							outanim = ( ( <trick> [ 0 ] ) . Params . outanim ) 
						ENDIF 
					ENDIF 
					IF GotParam outanim 
						GetAnimLength anim = <outanim> 
						out_length = <length> 
					ENDIF 
					GetAnimLength anim = <anim> 
					IF NOT GotParam out_length 
						out_length = <length> 
					ENDIF 
					total_length = ( <length> + <out_length> ) 
					percent = ( ( <animation_info> [ <index> ] ) . percent ) 
					IF ( <percent> > 1 ) 
						percent = 1 
					ENDIF 
					from_seconds = ( <from> * ( <total_length> / 2.00000000000 ) * 60 ) 
					to_seconds = ( <percent> * ( <total_length> / 2.00000000000 ) * 60 ) 
					in_ratio = ( <length> / <total_length> ) 
					out_ratio = ( 1.00000000000 - <in_ratio> ) 
					IF ( ( <in_ratio> = 0 ) | ( <out_ratio> = 0 ) ) 
						printf "CAT: bad ratio" 
						RETURN 
					ENDIF 
					speed = ( ( <length> * ( 1.00000000000 - <from> ) ) / ( <in_ratio> * <Dur> ) ) 
					speed2 = ( ( <out_length> * <percent> ) / ( <out_ratio> * <Dur> ) ) 
					IF ( 0 > <to_seconds> ) 
						to_seconds = 0 
					ENDIF 
					blend_seconds = ( <blend> * <speed> ) 
					IF NOT ( <start> = 0 ) 
						wait <start> seconds 
					ENDIF 
					IF GotParam SpecialItem_details 
						printf "I have a special item" 
						TurnOnSpecialItem SpecialItem_details = <SpecialItem_details> 
					ENDIF 
					IF NOT GotParam demo_loop 
						IF GotParam SpecialSounds 
							Obj_Spawnscript <SpecialSounds> 
						ENDIF 
						IF GotParam Stream 
							Obj_PlayStream <Stream> vol = 250 
						ENDIF 
					ENDIF 
					IF NOT ( <speed> = 0 ) 
						IF NOT ( <have_played_real_anim> = 0 ) 
							Obj_PlayAnim { anim = <anim> speed = <speed> from = <from_seconds> } 
						ELSE 
							Obj_PlayAnim { anim = <anim> speed = <speed> from = <from_seconds> blendperiodpercent = 0 } 
						ENDIF 
					ENDIF 
					IF NOT IsArray <trick> 
						Out_Params = ( <trick> . Params ) 
					ELSE 
						Out_Params = ( ( <trick> [ 0 ] ) . Params ) 
					ENDIF 
					IF NOT ( <speed> = 0 ) 
						WaitAnimFinished 
					ENDIF 
					IF NOT ( <idletime> = 0 ) 
						Obj_PlayAnim anim = <idle> cycle xblendperiodpercent = 0 
						wait <idletime> seconds 
						IF ( <index> = <tweak_grab> ) 
							IF NOT GotParam demo_loop 
								BEGIN 
									IF Released Circle 
										IF Released Square 
											BREAK 
										ENDIF 
									ENDIF 
									CAT_GetHoldTime skater = <currentSkaterProfileIndex> 
									CAT_SetHoldTime ( <cat_hold_time> + ( 1.00000000000 / 60.00000000000 ) ) skater = <currentSkaterProfileIndex> 
									WaitOneGameFrame 
									TweakTrick GRABTWEAK_MEDIUM 
								REPEAT 
								CAT_GetHoldTime skater = <currentSkaterProfileIndex> 
								printf "\tcat_hold_time = %c" c = <cat_hold_time> 
							ENDIF 
						ENDIF 
					ENDIF 
					CATReleased_SquareOrCircle <Out_Params> speed = <speed2> To = <to_seconds> blend = ( 100 * <blend> ) 
				ELSE 
					IF NOT IsArray <trick> 
						anim = ( <trick> . Params . anim ) 
					ELSE 
						anim = ( ( <trick> [ 0 ] ) . Params . anim ) 
					ENDIF 
					IF NOT GotParam anim 
						IF StructureContains structure = ( <trick> . Params ) initanim 
							anim = ( <trick> . Params . initanim ) 
						ELSE 
							printf "back trick... no anim" 
							RETURN 
						ENDIF 
					ENDIF 
					percent = ( ( <animation_info> [ <index> ] ) . percent ) 
					IF ( <percent> > 1 ) 
						percent = 1 
					ENDIF 
					GetAnimLength anim = <anim> 
					from_seconds = ( <from> * <length> * 60 ) 
					to_seconds = ( <percent> * <length> * 60 ) 
					total_percent = ( <percent> - <from> ) 
					IF NOT ( <Dur> = 0 ) 
						speed = ( ( ( <length> * <total_percent> ) ) / <Dur> ) 
					ELSE 
						speed = 1 
					ENDIF 
					IF ( 0 > <speed> ) 
						speed = ( <speed> * -1 ) 
					ENDIF 
					IF ( <backwards> = 1 ) 
						temp = <to_seconds> 
						to_seconds = <from_seconds> 
						from_seconds = <temp> 
					ENDIF 
					IF NOT ( <start> = 0 ) 
						wait <start> seconds 
					ENDIF 
					IF GotParam SpecialItem_details 
						printf "I have a special item" 
						TurnOnSpecialItem SpecialItem_details = <SpecialItem_details> 
					ENDIF 
					IF NOT GotParam demo_loop 
						IF GotParam SpecialSounds 
							Obj_Spawnscript <SpecialSounds> 
						ENDIF 
						IF GotParam Stream 
							Obj_PlayStream <Stream> vol = 250 
						ENDIF 
					ENDIF 
					IF ( <have_played_real_anim> = 0 ) 
						blendperiodpercent = 0 
					ELSE 
						blendperiodpercent = ( <blend> * 100 ) 
					ENDIF 
					IF NOT ( <speed> = 0 ) 
						Obj_PlayAnim { anim = <anim> speed = <speed> blendperiodpercent = <blendperiodpercent> from = <from_seconds> To = <to_seconds> } 
					ENDIF 
				ENDIF 
				IF IsArray <trick> 
					trick_params = ( ( <trick> [ 0 ] ) . Params ) 
				ELSE 
					trick_params = ( <trick> . Params ) 
				ENDIF 
				IF StructureContains BoardRotate structure = <trick_params> 
					BlendperiodOut 0 
					IF NOT GotParam demo_loop 
						BoardRotateAfter 
					ENDIF 
				ENDIF 
				IF StructureContains RotateAfter structure = <trick_params> 
					printf "skater should flip" 
					BlendperiodOut 0 
					flip_skater = 1 
				ENDIF 
				IF StructureContains FlipAfter structure = <trick_params> 
					BlendperiodOut 0 
					IF NOT GotParam demo_loop 
						Flip 
					ELSE 
						Obj_Flip 
						IF ( demo_flipped_cat_skater = 0 ) 
							change demo_flipped_cat_skater = 1 
						ELSE 
							change demo_flipped_cat_skater = 0 
						ENDIF 
					ENDIF 
				ENDIF 
				anims_played_this_trick = ( <anims_played_this_trick> + 1 ) 
				have_played_real_anim = 1 
				GetCurrentSkaterProfileIndex 
				CAT_GetNumAnims skater = <currentSkaterProfileIndex> 
				printf "\tplayed %p / %o anims" p = <anims_played_this_trick> o = <num_animations_on> 
				IF NOT ( <anims_played_this_trick> = <num_animations_on> ) 
					IF NOT GotParam speed2 
						IF NOT ( <speed> = 0 ) 
							WaitAnimFinished 
						ENDIF 
					ELSE 
						IF NOT ( <speed2> = 0 ) 
							WaitAnimFinished 
						ENDIF 
					ENDIF 
					IF GotParam flip_skater 
						IF NOT GotParam demo_loop 
							rotate y = 180 
						ELSE 
							Obj_SetOrientation y = 180 
						ENDIF 
						RemoveParameter flip_skater 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
		RemoveParameter anim 
		RemoveParameter outanim 
		RemoveParameter out_length 
		RemoveParameter in_ratio 
		RemoveParameter out_ratio 
		RemoveParameter percent 
		RemoveParameter speed2 
		RemoveParameter SpecialItem_details 
		RemoveParameter SpecialSounds 
		RemoveParameter Stream 
		count = ( <count> + 1 ) 
	REPEAT <array_size> 
	Obj_Spawnscript are_cat_anims_done Params = { flip_skater = <flip_skater> demo_loop = <demo_loop> } 
	printf "\tfinished CAT anim" 
ENDSCRIPT

SCRIPT are_cat_anims_done 
	IF NOT GotParam no_wait 
		WaitAnimFinished 
	ENDIF 
	TurnOffSpecialItem 
	IF GotParam flip_skater 
		IF NOT GotParam demo_loop 
			rotate y = 180 
		ELSE 
		ENDIF 
	ENDIF 
	GetCurrentSkaterProfileIndex 
	CAT_SetAnimsDone 1 skater = <currentSkaterProfileIndex> 
ENDSCRIPT

SCRIPT trick_got_idle 
	IF IsArray <trick> 
		IF StructureContains structure = ( ( <trick> [ 0 ] ) . Params ) idle 
			got_idle = 1 
		ELSE 
			got_idle = 0 
		ENDIF 
	ELSE 
		IF StructureContains structure = ( <trick> . Params ) idle 
			got_idle = 1 
		ELSE 
			got_idle = 0 
		ENDIF 
	ENDIF 
	RETURN got_idle = <got_idle> 
ENDSCRIPT

SCRIPT CATReleased_SquareOrCircle from = 0 
	printf "\t\tscript CATReleased_SquareOrCircle" 
	IF ( <speed> = 0 ) 
		RETURN 
	ENDIF 
	IF GotParam outanim 
		printf "\t\t\tOutAnim" 
		Obj_PlayAnim anim = <outanim> blendperiodpercent = <blend> speed = <speed> from = <from> To = <To> 
	ELSE 
		IF GotParam BackwardsAnim 
			printf "\t\t\tBackwardsAnim" 
			Obj_PlayAnim anim = <BackwardsAnim> backwards blendperiodpercent = <blend> speed = <speed> from = <from> To = <To> 
		ELSE 
			IF AnimEquals Airwalk 
				printf "\t\t\tAirwalk" 
				Obj_PlayAnim anim = <anim> from = Current To = 0 blendperiodpercent = <blend> speed = <speed> 
			ELSE 
				printf "\t\t\tOther" 
				Obj_PlayAnim anim = <anim> backwards speed = <speed> from = <from> To = <To> blendperiodpercent = <blend> 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT spawned_cat_sound_script 
	IF NOT ( <start> = 0 ) 
		wait <start> seconds 
	ENDIF 
	IF GotParam Stream 
		Obj_PlayStream <Stream> vol = 250 
	ENDIF 
ENDSCRIPT

SCRIPT waitforbailoff 
	time_passed = 0.00000000000 
	bail_point = ( <time> * 0.20000000298 ) 
	time = ( <time> - <bail_point> ) 
	GetCurrentSkaterProfileIndex 
	CAT_GetHoldTime skater = <currentSkaterProfileIndex> 
	printf "\tcat_hold_time=%c time=%t bail_point=%b" c = <cat_hold_time> t = <time> b = <bail_point> 
	BEGIN 
		IF ( ( <time_passed> > ( <time> + <cat_hold_time> ) ) | ( <time_passed> = ( <time> + <cat_hold_time> ) ) ) 
			BREAK 
		ENDIF 
		WaitOneGameFrame 
		time_passed = ( <time_passed> + ( 1.00000000000 / 60.00000000000 ) ) 
		CAT_GetHoldTime skater = <currentSkaterProfileIndex> 
	REPEAT 
	printf "\ttime_passed = %t" t = <time_passed> 
	CAT_SetBailDone 1 skater = <currentSkaterProfileIndex> 
ENDSCRIPT

SCRIPT cat_update_trick_string 
	wait 15 gameframes 
	IF ( <name> = "" ) 
		name = "Created Trick" 
	ENDIF 
	SetTrickName <name> 
	cat_get_score_from_bailtime bailtime = <bailtime> can_spin = <can_spin> 
	SetTrickScore <Score> 
	Display cat 
	LaunchSpecialMessage 
ENDSCRIPT

SCRIPT created_trick_cleanup 
	KillSpawnedScript name = CreateATrick 
	change cat_done = 1 
	KillSpawnedScript name = RotateOnAxis 
	KillSpawnedScript name = spawned_trick_anim 
	KillSpawnedScript name = spawned_cat_sound_script 
	KillSpawnedScript name = waitforbailoff 
	KillSpawnedScript name = cat_update_trick_string 
	CancelRotateDisplay 
	CAT_GetFlipSkater skater = <currentSkaterProfileIndex> 
	IF ( <cat_flip_skater_180> = 1 ) 
		CAT_SetFlipSkater 0 skater = <currentSkaterProfileIndex> 
		rotate y = 180 
	ENDIF 
	TurnOffSpecialItem 
	CanSpin 
	IF ScreenElementExists id = timeline_anchor 
		DestroyScreenElement id = timeline_anchor 
	ENDIF 
ENDSCRIPT

SCRIPT checkbailon 
	IF BailIsOn 
		printf "BAIL IS ON" 
	ELSE 
		printf "BAIL IS OFF" 
	ENDIF 
ENDSCRIPT

SCRIPT set_new_rot_values trick_index = 0 
	printf "script set_new_rot_values" 
	GetCreateATrickRotations skater = 0 trick_index = <trick_index> 
	SetArrayElement ArrayName = rotation_info index = <rot_index> newvalue = { on = <on> Deg = <Deg> Axis = <Axis> Dur = <Dur> start = <start> deg_dir = <deg_dir> } 
	SetCreateATrickRotations { trick_index = <trick_index> 
		rotation_info = <rotation_info> 
	} 
ENDSCRIPT

SCRIPT quick_set_anim_values 
	set_new_anim_values { anim_index = <anim_index> on = <on> trick = <trick> anim = <anim> Dur = <Dur> percent = <percent> blend = <blend> from = <from> trickType = <trickType> idletime = <idletime> start = <start> order = <order> hold = <hold> backwards = <backwards> } 
ENDSCRIPT

SCRIPT set_new_anim_values trick_index = 0 
	printf "script set_new_anim_values" 
	GetCreateATrickAnimations trick_index = <trick_index> 
	SetArrayElement ArrayName = animation_info index = <anim_index> newvalue = { on = <on> trick = <trick> Dur = <Dur> percent = <percent> blend = <blend> from = <from> trickType = <trickType> idletime = <idletime> start = <start> order = <order> hold = <hold> backwards = <backwards> } 
	SetCreateATrickAnimations { 
		trick_index = <trick_index> 
		animation_info = <animation_info> 
	} 
ENDSCRIPT

SCRIPT set_new_CAT_param_values 
	printf "script set_new_CAT_param_values" 
	other_params = { name = <name> can_spin = <can_spin> full = <full> } 
	SetCreateATrickOtherParams { trick_index = <trick_index> 
		other_params = <other_params> 
	} 
ENDSCRIPT

SCRIPT get_CAT_param_values trick_index = 0 
	printf "script get_CAT_param_values" 
	IF GetCreateATrickParams { trick_index = <trick_index> } 
		name = ( <other_params> . name ) 
		can_spin = ( <other_params> . can_spin ) 
		full = ( <other_params> . full ) 
		RETURN <...> 
	ENDIF 
ENDSCRIPT

SCRIPT get_CAT_rot_values trick_index = 0 rot_index = 0 
	printf "script get_CAT_rot_values" 
	IF GetCreateATrickRotations { trick_index = <trick_index> } 
		RETURN ( <rotation_info> [ <rot_index> ] ) 
	ENDIF 
ENDSCRIPT

SCRIPT get_CAT_anim_values trick_index = 0 anim_index = 0 
	printf "script get_CAT_anim_values" 
	IF GetCreateATrickAnimations { trick_index = <trick_index> } 
		RETURN ( <animation_info> [ <anim_index> ] ) 
	ENDIF 
ENDSCRIPT

SCRIPT get_CAT_other_param_values 
	printf "script get_CAT_other_param_values" 
	IF GetCreateATrickOtherParams { trick_index = <trick_index> } 
		name = ( <other_params> . name ) 
		can_spin = ( <other_params> . can_spin ) 
		full = ( <other_params> . full ) 
		RETURN <...> 
	ENDIF 
ENDSCRIPT

SCRIPT print_out_cat index = 0 
	get_CAT_param_values trick_index = <index> 
	printstruct <...> 
ENDSCRIPT

SCRIPT print_out_cat2 index = 1 
	get_CAT_other_param_values trick_index = <index> 
	printstruct <...> 
ENDSCRIPT

Premade_CATS = [ 
	{ name = "Bender Flip" 
		can_spin = 1 
		full = 1 
		rotation_info = [ 
			{ on = 1 Axis = z Deg = 360 Dur = 1.10000002384 start = CAT_BLEND deg_dir = 0 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
		] 
		animation_info = [ 
			{ on = 1 trick = Trick_FlyingSquirrel Dur = 1.60000002384 blend = CAT_BLEND from = 0 percent = 1 trickType = 2 idletime = 0 start = 0 order = 1 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 2 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 3 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 4 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 5 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 6 hold = 0 backwards = 0 } 
		] 
	} 
	{ name = "Nut Buster" 
		can_spin = 1 
		full = 1 
		rotation_info = [ 
			{ on = 1 Deg = 360 Axis = z Dur = 1.00000000000 start = 0.00000000000 deg_dir = 0 } 
			{ on = 1 Deg = 180 Axis = y Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
			{ on = 2 Deg = 360 Axis = y Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
			{ on = 2 Deg = 360 Axis = y Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
			{ on = 2 Deg = 360 Axis = y Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
			{ on = 2 Deg = 360 Axis = y Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
		] 
		animation_info = [ 
			{ on = 1 trick = Trick_SackTap Dur = 0.89999902248 percent = 1.00000000000 blend = CAT_BLEND from = 0.50000000000 trickType = 1 idletime = 0.10000000149 start = 0 order = 1 hold = 1 backwards = 0 } 
			{ on = 2 trick = Trick_SackTap Dur = 0.50000000000 percent = 1.00000000000 blend = CAT_BLEND from = 0.50000000000 trickType = 1 idletime = 0 start = 0 order = 2 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 3 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 4 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 5 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 6 hold = 0 backwards = 0 } 
		] 
	} 
	{ name = "Soul Skating" 
		can_spin = 0 
		full = 1 
		rotation_info = [ 
			{ on = 1 Axis = y Deg = 720 Dur = 1.29999995232 start = 0.00000000000 deg_dir = 0 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
		] 
		animation_info = [ 
			{ on = 1 trick = Trick_Seatbelt Dur = 0.30000001192 blend = CAT_BLEND from = 0 percent = 0.50000000000 trickType = 1 idletime = 0.40000000596 start = 0 order = 2 hold = 0 backwards = 0 } 
			{ on = 1 trick = Extra360ShoveIt Dur = 0.60000002384 blend = CAT_BLEND from = 0.25999999046 percent = 1 trickType = 0 idletime = 0 start = 0 order = 3 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 1 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 4 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 5 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 6 hold = 0 backwards = 0 } 
		] 
	} 
	{ name = "Heelflip Barrel" 
		can_spin = 0 
		full = 1 
		rotation_info = [ 
			{ on = 1 Axis = z Deg = 180 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 0 } 
			{ on = 1 Axis = z Deg = 180 Dur = 0.50000000000 start = 0.80000001192 deg_dir = 0 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
		] 
		animation_info = [ 
			{ on = 1 trick = trick_QuadrupleHeelFlip Dur = 0.80000001192 blend = CAT_BLEND from = 0 percent = 1 trickType = 2 idletime = 0 start = 0 order = 1 hold = 0 backwards = 0 } 
			{ on = 1 trick = Trick_Heelflip Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 0 idletime = 0 start = 0 order = 2 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 3 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 4 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 5 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 6 hold = 0 backwards = 0 } 
		] 
	} 
	{ name = "Layback Casper" 
		can_spin = 1 
		full = 1 
		rotation_info = [ 
			{ on = 1 Axis = x Deg = 180 Dur = 1.50000000000 start = 0.00000000000 deg_dir = 1 } 
			{ on = 1 Axis = x Deg = 180 Dur = 0.50000000000 start = 1.00000000000 deg_dir = 0 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
		] 
		animation_info = [ 
			{ on = 1 trick = Trick_AirCasperFlip Dur = 1.10000002384 blend = CAT_BLEND from = 0 percent = 1 trickType = 2 idletime = 0.40000000596 start = 0 order = 1 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 2 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 3 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 4 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 5 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 6 hold = 0 backwards = 0 } 
		] 
	} 
	{ name = "360 BodyVarial Kickflip" 
		can_spin = 0 
		full = 1 
		rotation_info = [ 
			{ on = 1 Axis = y Deg = 360 Dur = 0.60000002384 start = 0.00000000000 deg_dir = 1 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
		] 
		animation_info = [ 
			{ on = 1 trick = Extra_VarialKickflip Dur = 0.60000002384 blend = CAT_BLEND from = 0 percent = 1 trickType = 0 idletime = 0 start = 0 order = 1 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 2 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 3 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 4 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 5 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 6 hold = 0 backwards = 0 } 
		] 
	} 
	{ name = "Double Barrel" 
		can_spin = 1 
		full = 1 
		rotation_info = [ 
			{ on = 1 Axis = z Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
		] 
		animation_info = [ 
			{ on = 1 trick = Trick_BarrelRoll Dur = 1.10000002384 blend = CAT_BLEND from = 0 percent = 1 trickType = 2 idletime = 0 start = 0 order = 1 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 2 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 3 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 4 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 5 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 6 hold = 0 backwards = 0 } 
		] 
	} 
	{ name = "Kickflip Method" 
		can_spin = 1 
		full = 1 
		rotation_info = [ 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
		] 
		animation_info = [ 
			{ on = 1 trick = CATTrick_KickflipBS Dur = 0.30000001192 blend = CAT_BLEND from = 0 percent = 1 trickType = 0 idletime = 0 start = 0 order = 1 hold = 0 backwards = 0 } 
			{ on = 1 trick = Trick_Method Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0.10000000149 start = 0 order = 2 hold = 1 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 3 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 4 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 5 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 6 hold = 0 backwards = 0 } 
		] 
	} 
	{ name = "Flamingo Twist" 
		can_spin = 0 
		full = 1 
		rotation_info = [ 
			{ on = 1 Axis = y Deg = 360 Dur = 0.69999998808 start = 0.20000000298 deg_dir = 0 } 
			{ on = 1 Axis = y Deg = 360 Dur = 0.60000002384 start = 0.89999997616 deg_dir = 1 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
		] 
		animation_info = [ 
			{ on = 1 trick = Trick_Flamingo Dur = 1.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 2 idletime = 0 start = 0 order = 1 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 2 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 3 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 4 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 5 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 6 hold = 0 backwards = 0 } 
		] 
	} 
	{ name = "Misty In Back Out" 
		can_spin = 0 
		full = 1 
		rotation_info = [ 
			{ on = 1 Axis = z Deg = 360 Dur = 0.80000001192 start = 0.00000000000 deg_dir = 1 } 
			{ on = 1 Axis = y Deg = 180 Dur = 0.80000001192 start = 0.00000000000 deg_dir = 1 } 
			{ on = 1 Axis = z Deg = 360 Dur = 0.60000002384 start = 0.60000002384 deg_dir = 1 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
			{ on = 2 Axis = y Deg = 360 Dur = 1.00000000000 start = 0.00000000000 deg_dir = 1 } 
		] 
		animation_info = [ 
			{ on = 1 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0.69999998808 start = 0 order = 1 hold = 1 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 2 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 3 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 4 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 5 hold = 0 backwards = 0 } 
			{ on = 2 trick = trick_indy Dur = 0.50000000000 blend = CAT_BLEND from = 0 percent = 1 trickType = 1 idletime = 0 start = 0 order = 6 hold = 0 backwards = 0 } 
		] 
	} 
] 
