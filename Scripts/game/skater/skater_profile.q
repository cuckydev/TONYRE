
sp_str_unassigned = #"Unassigned" 
sp_str_units = #"ft." 
sp_str_subunits = #"in." 
sp_str_pounds = #"pounds" 
sp_str_unknown_weight = #"---" 
sp_str_none = #"None" 
appearance_init_structure = { 
	sleeves = { desc_id = None } 
} 
SCRIPT init_pro_skaters 
	ForEachIn master_skater_list do = AddSkaterProfile 
ENDSCRIPT

SCRIPT set_default_temporary_profiles 
ENDSCRIPT

SCRIPT add_skater_profile 
	AddSkaterProfile <...> 
ENDSCRIPT

master_skater_list = [ 
	{ 
		display_name = "Custom Skater" 
		first_name = "Custom" 
		file_name = "Unimplemented" 
		skater_index = 0 
		default_appearance = appearance_custom_skater_male 
		name = custom 
		stance = regular 
		pushstyle = never_mongo 
		trickstyle = street 
		is_pro = 0 
		is_male = 1 
		is_head_locked = 0 
		is_locked = 0 
		age = 16 
		hometown = "Los Angeles, CA" 
		points_available = 0 
		air = 3 
		run = 3 
		ollie = 3 
		speed = 3 
		spin = 3 
		switch = 3 
		flip_speed = 3 
		rail_balance = 3 
		lip_balance = 3 
		manual_balance = 3 
		sponsors = [ ] 
		trick_mapping = { } 
		default_trick_mapping = CustomTricks 
		max_specials = 3 
		specials = { 
			[ 
				{ trickslot = SpAir_R_D_Circle trickname = Trick_McTwist } 
				{ trickslot = SpAir_L_R_Square trickname = Trick_KickFlipUnderFlip } 
				{ trickslot = SpGrind_R_D_Triangle trickname = Trick_tailblockslide } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
			] 
		} 
	} 
	{ 
		display_name = "Tony Hawk" 
		first_name = "Tony" 
		skater_index = 1 
		default_appearance = appearance_hawk 
		name = hawk 
		stance = goofy 
		pushstyle = never_mongo 
		trickstyle = vert 
		is_pro = 1 
		is_head_locked = 1 
		is_locked = 1 
		is_male = 1 
		age = 33 
		hometown = "Carlsbad, CA" 
		points_available = 0 
		air = 11 
		run = 6 
		ollie = 7 
		speed = 10 
		spin = 11 
		switch = 8 
		flip_speed = 7 
		rail_balance = 9 
		lip_balance = 9 
		manual_balance = 7 
		sponsors = [ birdhouse hawkshoes quiksilver hawkapp tony ] 
		trick_mapping = { } 
		default_trick_mapping = HawkTricks 
		max_specials = 11 
		specials = { 
			[ 
				{ trickslot = SpAir_R_L_Circle trickname = Trick_360VarialMcTwist } 
				{ trickslot = SpGrind_L_D_Triangle trickname = Trick_360ShovitNoseGrind } 
				{ trickslot = SpAir_R_D_Circle trickname = Trick_Indy900 } 
				{ trickslot = SpAir_L_D_Circle trickname = Trick_540varielheelfliplien } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
			] 
		} 
		lockout_flags = [ 
			is_hawk 
		] 
	} 
	{ 
		display_name = "Bob Burnquist" 
		first_name = "Bob" 
		skater_index = 2 
		default_appearance = appearance_burnquist 
		name = burnquist 
		stance = regular 
		pushstyle = never_mongo 
		trickstyle = vert 
		is_pro = 1 
		is_head_locked = 1 
		is_locked = 1 
		is_male = 1 
		age = 26 
		hometown = "Sao Paulo, Brazil" 
		points_available = 0 
		air = 8 
		run = 7 
		ollie = 7 
		speed = 10 
		spin = 9 
		switch = 11 
		flip_speed = 8 
		rail_balance = 9 
		lip_balance = 9 
		manual_balance = 7 
		sponsors = [ firm hurley burnquist organics oakley ogio ] 
		trick_mapping = { } 
		default_trick_mapping = BurnquistTricks 
		max_specials = 11 
		specials = { 
			[ 
				{ trickslot = SpMan_L_R_Triangle trickname = Trick_HandStandCasper } 
				{ trickslot = SpGrind_L_D_Triangle trickname = Trick_Thinkaboutitgrind } 
				{ trickslot = SpAir_U_D_Circle trickname = Trick_Shifty360ShovitBSShifty } 
				{ trickslot = SpAir_L_R_Circle trickname = Trick_SambaFlip } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
			] 
		} 
		lockout_flags = [ 
			is_burnquist 
		] 
	} 
	{ 
		display_name = "Steve Caballero" 
		first_name = "Steve" 
		skater_index = 3 
		default_appearance = appearance_caballero 
		name = caballero 
		stance = goofy 
		pushstyle = never_mongo 
		trickstyle = street 
		is_pro = 1 
		is_head_locked = 1 
		is_locked = 1 
		is_male = 1 
		age = 36 
		hometown = "Campbell, CA" 
		points_available = 0 
		air = 10 
		run = 8 
		ollie = 8 
		speed = 8 
		spin = 9 
		switch = 8 
		flip_speed = 8 
		rail_balance = 9 
		lip_balance = 9 
		manual_balance = 8 
		sponsors = [ brigade sessions faction vans steve ] 
		trick_mapping = { } 
		default_trick_mapping = CaballeroTricks 
		max_specials = 11 
		specials = { 
			[ 
				{ trickslot = SpLip_R_U_Triangle trickname = Trick_HoHoSadplant } 
				{ trickslot = SpAir_L_D_Circle trickname = Trick_FS540 } 
				{ trickslot = SpGrind_D_U_Triangle trickname = Trick_GuitarSlide } 
				{ trickslot = SpGrind_U_D_Triangle trickname = Trick_DaffyBrokenGrind } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
			] 
		} 
		lockout_flags = [ 
			is_cab 
		] 
		no_edit_groups = [ 
			head_options 
		] 
	} 
	{ 
		display_name = "Kareem Campbell" 
		first_name = "Kareem" 
		skater_index = 4 
		default_appearance = appearance_campbell 
		name = campbell 
		stance = regular 
		pushstyle = never_mongo 
		trickstyle = street 
		is_pro = 1 
		is_head_locked = 1 
		is_locked = 1 
		is_male = 1 
		age = 30 
		hometown = "N.Y. / L.A." 
		points_available = 0 
		air = 7 
		run = 8 
		ollie = 9 
		speed = 8 
		spin = 9 
		switch = 8 
		flip_speed = 9 
		rail_balance = 9 
		lip_balance = 8 
		manual_balance = 10 
		sponsors = [ axion citystars ricta kareem ] 
		trick_mapping = { } 
		default_trick_mapping = CampbellTricks 
		max_specials = 11 
		specials = { 
			[ 
				{ trickslot = SpAir_U_R_Square trickname = Trick_GhettoBird } 
				{ trickslot = SpAir_L_D_Circle trickname = Trick_KFBackflip } 
				{ trickslot = SpAir_R_D_Square trickname = Trick_QuadrupleHeelFlip } 
				{ trickslot = SpAir_D_U_Circle trickname = Trick_SitDownAir } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
			] 
		} 
		lockout_flags = [ 
			is_campbell 
		] 
	} 
	{ 
		display_name = "Rune Glifberg" 
		first_name = "Rune" 
		skater_index = 5 
		default_appearance = appearance_glifberg 
		name = glifberg 
		stance = regular 
		pushstyle = never_mongo 
		trickstyle = vert 
		is_pro = 1 
		is_head_locked = 1 
		is_locked = 1 
		is_male = 1 
		age = 27 
		hometown = "Copenhagen, Denmark" 
		points_available = 0 
		air = 11 
		run = 7 
		ollie = 7 
		speed = 9 
		spin = 9 
		switch = 8 
		flip_speed = 8 
		rail_balance = 9 
		lip_balance = 9 
		manual_balance = 8 
		sponsors = [ flip axion volcom rune ] 
		trick_mapping = { } 
		default_trick_mapping = GlifbergTricks 
		max_specials = 11 
		specials = { 
			[ 
				{ trickslot = SpAir_R_U_Circle trickname = Trick_DoubleKFindy } 
				{ trickslot = SpAir_L_R_Circle trickname = Trick_FingerFlipAirwalk } 
				{ trickslot = SpAir_R_D_Circle trickname = Trick_540TailWhip } 
				{ trickslot = SpAir_L_D_Circle trickname = Trick_2KickMadonnaFlip } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
			] 
		} 
		lockout_flags = [ 
			is_glifberg 
		] 
	} 
	{ 
		display_name = "Eric Koston" 
		first_name = "Eric" 
		skater_index = 6 
		default_appearance = appearance_koston 
		name = koston 
		stance = goofy 
		pushstyle = mongo_when_switch 
		trickstyle = street 
		is_pro = 1 
		is_head_locked = 1 
		is_locked = 1 
		is_male = 1 
		age = 27 
		hometown = "San Bernardino, CA" 
		points_available = 0 
		air = 7 
		run = 8 
		ollie = 9 
		speed = 8 
		spin = 7 
		switch = 11 
		flip_speed = 8 
		rail_balance = 11 
		lip_balance = 6 
		manual_balance = 10 
		sponsors = [ girl es fourstar eric ] 
		trick_mapping = { } 
		default_trick_mapping = KostonTricks 
		max_specials = 11 
		specials = { 
			[ 
				{ trickslot = SpGrind_U_R_Triangle trickname = Trick_Fandangle } 
				{ trickslot = SpMan_R_L_Triangle trickname = Trick_YeahRight } 
				{ trickslot = SpAir_L_R_Circle trickname = Trick_FlyingSquirrel } 
				{ trickslot = SpAir_R_U_Circle trickname = Trick_ChompOnThis } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
			] 
		} 
	} 
	{ 
		display_name = "Bucky Lasek" 
		first_name = "Bucky" 
		skater_index = 7 
		default_appearance = appearance_lasek 
		name = lasek 
		stance = regular 
		pushstyle = never_mongo 
		trickstyle = vert 
		is_pro = 1 
		is_head_locked = 1 
		is_locked = 1 
		is_male = 1 
		age = 28 
		hometown = "Baltimore, MD" 
		points_available = 0 
		air = 10 
		run = 7 
		ollie = 7 
		speed = 9 
		spin = 11 
		switch = 8 
		flip_speed = 8 
		rail_balance = 8 
		lip_balance = 10 
		manual_balance = 7 
		sponsors = [ birdhouse genetic billabong bucky ] 
		trick_mapping = { } 
		default_trick_mapping = LasekTricks 
		max_specials = 11 
		specials = { 
			[ 
				{ trickslot = SpLip_L_D_Triangle trickname = Trick_1990Invert } 
				{ trickslot = SpLip_R_L_Triangle trickname = Trick_HeelflipFSInvert } 
				{ trickslot = SpAir_R_D_Circle trickname = Trick_BreakIn } 
				{ trickslot = SpGrind_U_L_Triangle trickname = Trick_BigHitter } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
			] 
		} 
		lockout_flags = [ 
			is_lasek 
		] 
	} 
	{ 
		display_name = "Bam Margera" 
		first_name = "Bam" 
		skater_index = 8 
		default_appearance = appearance_margera 
		name = margera 
		stance = goofy 
		pushstyle = never_mongo 
		trickstyle = street 
		is_pro = 1 
		is_head_locked = 1 
		is_locked = 1 
		is_male = 1 
		age = 22 
		hometown = "Philadelphia, PA" 
		points_available = 0 
		air = 8 
		run = 10 
		ollie = 8 
		speed = 10 
		spin = 8 
		switch = 8 
		flip_speed = 8 
		rail_balance = 9 
		lip_balance = 8 
		manual_balance = 8 
		sponsors = [ element adio cky bam ] 
		trick_mapping = { } 
		default_trick_mapping = MargeraTricks 
		max_specials = 11 
		specials = { 
			[ 
				{ trickslot = SpAir_U_R_circle trickname = Trick_BamBendAir } 
				{ trickslot = SpAir_D_U_Square trickname = Trick_Jackass } 
				{ trickslot = SpGrind_D_U_Triangle trickname = Trick_Shortbus } 
				{ trickslot = SpGrind_L_R_Triangle trickname = Trick_GrindNBarf } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
			] 
		} 
		lockout_flags = [ 
			is_margera 
		] 
		no_edit_groups = [ 
			head_options 
			helmet_items 
		] 
	} 
	{ 
		display_name = "Rodney Mullen" 
		first_name = "Rodney" 
		skater_index = 9 
		default_appearance = appearance_mullen 
		name = mullen 
		stance = regular 
		pushstyle = never_mongo 
		trickstyle = street 
		is_pro = 1 
		is_head_locked = 1 
		is_locked = 1 
		is_male = 1 
		age = 32 
		hometown = "Gainsville, FL" 
		points_available = 0 
		air = 7 
		run = 7 
		ollie = 8 
		speed = 8 
		spin = 9 
		switch = 8 
		flip_speed = 10 
		rail_balance = 10 
		lip_balance = 7 
		manual_balance = 11 
		sponsors = [ enjoi globe tensor rodney ] 
		trick_mapping = { } 
		default_trick_mapping = MullenTricks 
		max_specials = 11 
		specials = { 
			[ 
				{ trickslot = SpAir_U_D_Square trickname = Trick_Gazelle } 
				{ trickslot = SpGrind_L_R_Triangle trickname = Trick_HCNHDF } 
				{ trickslot = SpGrind_R_L_Triangle trickname = Trick_50Fingerflip } 
				{ trickslot = SpGrind_R_D_Triangle trickname = Trick_RodneyGrind } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
			] 
		} 
		lockout_flags = [ 
			is_mullen 
		] 
		no_edit_groups = [ 
		] 
		no_edit_groups = [ 
			head_options 
		] 
	} 
	{ 
		display_name = "Chad Muska" 
		first_name = "Chad" 
		skater_index = 10 
		default_appearance = appearance_muska 
		name = muska 
		stance = regular 
		pushstyle = never_mongo 
		trickstyle = street 
		is_pro = 1 
		is_head_locked = 1 
		is_locked = 1 
		is_male = 1 
		age = 24 
		hometown = "Loraine, OH" 
		points_available = 0 
		air = 7 
		run = 8 
		ollie = 11 
		speed = 8 
		spin = 8 
		switch = 8 
		flip_speed = 9 
		rail_balance = 10 
		lip_balance = 7 
		manual_balance = 9 
		sponsors = [ shortys circa muskabeatz chad ] 
		trick_mapping = { } 
		default_trick_mapping = MuskaTricks 
		max_specials = 11 
		specials = { 
			[ 
				{ trickslot = SpGrind_R_D_Triangle trickname = Trick_MoonwalkGrind } 
				{ trickslot = SpMan_R_L_Triangle trickname = Trick_MuskaManual } 
				{ trickslot = SpGrind_L_D_Triangle trickname = Trick_SprayPaintGrind } 
				{ trickslot = SpMan_L_R_Triangle trickname = Trick_RustySlide } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
			] 
		} 
		no_edit 
	} 
	{ 
		display_name = "Andrew Reynolds" 
		first_name = "Andrew" 
		skater_index = 11 
		default_appearance = appearance_reynolds 
		name = reynolds 
		stance = regular 
		pushstyle = never_mongo 
		trickstyle = street 
		is_pro = 1 
		is_head_locked = 1 
		is_locked = 1 
		is_male = 1 
		age = 25 
		hometown = "Lakeland, FL" 
		points_available = 0 
		air = 7 
		run = 7 
		ollie = 11 
		speed = 8 
		spin = 8 
		switch = 9 
		flip_speed = 8 
		rail_balance = 10 
		lip_balance = 8 
		manual_balance = 9 
		sponsors = [ baker emerica independent andrew ] 
		trick_mapping = { } 
		default_trick_mapping = ReynoldsTricks 
		max_specials = 11 
		specials = { 
			[ 
				{ trickslot = SpGrind_L_R_Triangle trickname = Trick_FiftyfiftySwitcheroo } 
				{ trickslot = SpAir_L_R_Circle trickname = Trick_BigSpinShifty } 
				{ trickslot = SpAir_R_D_Circle trickname = Trick_KFBackflip } 
				{ trickslot = SpAir_U_D_Circle trickname = Trick_FSFlipOneFootTailGrab } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
			] 
		} 
		lockout_flags = [ 
			is_reynolds 
		] 
		no_edit_groups = [ 
		] 
		no_edit_groups = [ 
			head_options 
			helmet_items 
		] 
	} 
	{ 
		display_name = "Paul Rodriguez" 
		first_name = "Paul" 
		skater_index = 12 
		default_appearance = appearance_rodriguez 
		name = rodriguez 
		stance = goofy 
		pushstyle = never_mongo 
		trickstyle = street 
		is_pro = 1 
		is_head_locked = 0 
		is_locked = 0 
		is_male = 1 
		age = 18 
		hometown = "Northridge, CA" 
		points_available = 0 
		air = 6 
		run = 8 
		ollie = 8 
		speed = 8 
		spin = 8 
		switch = 9 
		flip_speed = 10 
		rail_balance = 10 
		lip_balance = 8 
		manual_balance = 10 
		sponsors = [ es girl paul ] 
		trick_mapping = { } 
		default_trick_mapping = RodriguezTricks 
		max_specials = 11 
		specials = { 
			[ 
				{ trickslot = SpGrind_L_D_Triangle trickname = Trick_FSNollie360FlipCrook } 
				{ trickslot = SpGrind_D_U_Triangle trickname = Trick_YeaRightSlide } 
				{ trickslot = SpAir_R_D_Circle trickname = Trick_NollieFlipUnderflip } 
				{ trickslot = SpLip_U_D_Triangle trickname = Trick_Russian } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
			] 
		} 
	} 
	{ 
		display_name = "Geoff Rowley" 
		first_name = "Geoff" 
		skater_index = 13 
		default_appearance = appearance_rowley 
		name = rowley 
		stance = regular 
		pushstyle = never_mongo 
		trickstyle = street 
		is_pro = 1 
		is_head_locked = 1 
		is_locked = 1 
		is_male = 1 
		age = 25 
		hometown = "Liverpool, England" 
		points_available = 0 
		air = 7 
		run = 8 
		ollie = 9 
		speed = 9 
		spin = 8 
		switch = 8 
		flip_speed = 10 
		rail_balance = 11 
		lip_balance = 7 
		manual_balance = 8 
		sponsors = [ flip volcom vans geoff ] 
		trick_mapping = { } 
		default_trick_mapping = RowleyTricks 
		max_specials = 11 
		specials = { 
			[ 
				{ trickslot = SpAir_U_R_circle trickname = Trick_flipflip } 
				{ trickslot = SpAir_D_R_Square trickname = Trick_AirCasperFlip } 
				{ trickslot = SpGrind_R_L_Triangle trickname = Trick_RowleyDarkSlideHandStand } 
				{ trickslot = SpMan_U_D_Triangle trickname = Trick_Sproing } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
			] 
		} 
		lockout_flags = [ 
			is_rowley 
		] 
	} 
	{ 
		display_name = "Arto Saari" 
		first_name = "Arto" 
		skater_index = 14 
		default_appearance = appearance_saari 
		name = saari 
		stance = regular 
		pushstyle = never_mongo 
		trickstyle = street 
		is_pro = 1 
		is_head_locked = 0 
		is_locked = 0 
		is_male = 1 
		age = -1 
		hometown = "Edison, NJ" 
		points_available = 0 
		air = 8 
		run = 8 
		ollie = 8 
		speed = 10 
		spin = 8 
		switch = 8 
		flip_speed = 9 
		rail_balance = 11 
		lip_balance = 7 
		manual_balance = 8 
		sponsors = [ flip es ] 
		trick_mapping = { } 
		default_trick_mapping = SaariTricks 
		max_specials = 11 
		specials = { 
			[ 
				{ trickslot = SpMan_L_R_Triangle trickname = Trick_HeadStandManual } 
				{ trickslot = SpMan_D_U_Triangle trickname = Trick_MixItUp } 
				{ trickslot = SpGrind_D_R_Triangle trickname = Trick_OneFootDarkSlide } 
				{ trickslot = SpAir_L_R_Square trickname = Trick_HardFlipBackFootFlip } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
			] 
		} 
	} 
	{ 
		display_name = "Elissa Steamer" 
		first_name = "Elissa" 
		skater_index = 15 
		default_appearance = appearance_steamer 
		name = steamer 
		stance = regular 
		pushstyle = never_mongo 
		trickstyle = street 
		is_pro = 1 
		is_head_locked = 1 
		is_locked = 1 
		is_male = 0 
		age = -1 
		hometown = "Fort Myers, FL" 
		points_available = 0 
		air = 9 
		run = 8 
		ollie = 9 
		speed = 8 
		spin = 8 
		switch = 8 
		flip_speed = 9 
		rail_balance = 9 
		lip_balance = 8 
		manual_balance = 9 
		sponsors = [ bootleg etnies tsa elissa ] 
		trick_mapping = { } 
		default_trick_mapping = SteamerTricks 
		max_specials = 11 
		specials = { 
			[ 
				{ trickslot = SpMan_R_D_Triangle trickname = Trick_NoComplyLate360 } 
				{ trickslot = SpMan_R_L_Triangle trickname = Trick_HoHoStreetPlant } 
				{ trickslot = SpGrind_L_R_Triangle trickname = Trick_Coffin } 
				{ trickslot = SpAir_D_U_Circle trickname = Trick_SemiFlip } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
			] 
		} 
		lockout_flags = [ 
			shows_panties 
			not_with_elissa 
		] 
		no_edit_groups = [ 
			head_options 
			backpack_items 
			helmet_items 
			socks_items 
		] 
	} 
	{ 
		display_name = "Jamie Thomas" 
		first_name = "Jamie" 
		skater_index = 16 
		default_appearance = appearance_thomas 
		name = thomas 
		stance = regular 
		pushstyle = never_mongo 
		trickstyle = street 
		is_pro = 1 
		is_head_locked = 1 
		is_locked = 1 
		is_male = 1 
		age = 26 
		hometown = "Dotham, AL" 
		points_available = 0 
		air = 8 
		run = 10 
		ollie = 8 
		speed = 10 
		spin = 8 
		switch = 8 
		flip_speed = 8 
		rail_balance = 11 
		lip_balance = 7 
		manual_balance = 7 
		sponsors = [ zero circa monster jamie ] 
		trick_mapping = { } 
		default_trick_mapping = ThomasTricks 
		max_specials = 11 
		specials = { 
			[ 
				{ trickslot = SpGrind_R_D_Triangle trickname = Trick_CrookedBigSpinFlip } 
				{ trickslot = SpGrind_D_U_Triangle trickname = Trick_PrimoHandStand } 
				{ trickslot = SpGrind_L_D_Triangle trickname = Trick_AmericanHeroGrind } 
				{ trickslot = SpGrind_U_D_Triangle trickname = Trick_CrookedSkull } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
			] 
		} 
		no_edit_groups = [ 
			head_options 
			pad_options 
		] 
	} 
	{ 
		display_name = "Mike Vallely" 
		first_name = "Mike" 
		skater_index = 17 
		default_appearance = appearance_vallely 
		name = vallely 
		stance = regular 
		pushstyle = never_mongo 
		trickstyle = street 
		is_pro = 1 
		is_head_locked = 0 
		is_locked = 0 
		is_male = 1 
		age = -1 
		hometown = "Edison, NJ" 
		points_available = 0 
		air = 8 
		run = 11 
		ollie = 9 
		speed = 10 
		spin = 8 
		switch = 7 
		flip_speed = 8 
		rail_balance = 8 
		lip_balance = 8 
		manual_balance = 8 
		sponsors = [ vallely etnies mike ] 
		trick_mapping = { } 
		default_trick_mapping = VallelyTricks 
		max_specials = 11 
		specials = { 
			[ 
				{ trickslot = SpGrind_L_R_Triangle trickname = Trick_ElbowSmash } 
				{ trickslot = SpMan_D_U_Triangle trickname = Trick_KickflipSwitch } 
				{ trickslot = SpAir_D_R_Circle trickname = Trick_Flamingo } 
				{ trickslot = SpMan_L_R_Triangle trickname = Trick_SlamSpinner } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
			] 
		} 
	} 
	{ 
		display_name = "Gene Simmons" 
		first_name = "Gene" 
		skater_index = 18 
		default_appearance = appearance_gene 
		name = Gene 
		stance = regular 
		pushstyle = never_mongo 
		trickstyle = street 
		is_pro = 1 
		is_head_locked = 1 
		is_locked = 1 
		is_hidden = 1 
		is_secret 
		is_male = 1 
		age = -1 
		hometown = "hell" 
		points_available = 0 
		air = 10 
		run = 10 
		ollie = 10 
		speed = 10 
		spin = 10 
		switch = 10 
		flip_speed = 10 
		rail_balance = 10 
		lip_balance = 11 
		manual_balance = 10 
		sponsors = [ ] 
		trick_mapping = { } 
		default_trick_mapping = WolverineTricks 
		unlock_flag = SKATER_UNLOCKED_KISSDUDE 
		no_edit 
		no_edit_groups = [ 
			secret_options 
		] 
		max_specials = 11 
		specials = { 
			[ 
				{ trickslot = SpAir_D_R_Circle trickname = Trick_LickItUp } 
				{ trickslot = SpGrind_L_R_Triangle trickname = Trick_Flames } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
			] 
		} 
	} 
	{ 
		display_name = "Iron Man" 
		first_name = "Iron" 
		skater_index = 19 
		default_appearance = appearance_Ironman 
		name = Iron_Man 
		stance = regular 
		pushstyle = never_mongo 
		trickstyle = street 
		is_pro = 1 
		is_head_locked = 1 
		is_locked = 1 
		is_hidden = 1 
		is_secret 
		is_male = 1 
		age = -1 
		hometown = "West coast" 
		points_available = 0 
		air = 11 
		run = 11 
		ollie = 11 
		speed = 11 
		spin = 11 
		switch = 11 
		flip_speed = 11 
		rail_balance = 11 
		lip_balance = 11 
		manual_balance = 11 
		sponsors = [ ] 
		trick_mapping = { } 
		default_trick_mapping = WolverineTricks 
		unlock_flag = SKATER_UNLOCKED_IRONMAN 
		no_edit 
		no_edit_groups = [ 
			secret_options 
		] 
		max_specials = 11 
		specials = { 
			[ 
				{ trickslot = SpMan_D_U_Triangle trickname = Trick_Scanning } 
				{ trickslot = SpAir_L_R_Circle trickname = Trick_BootBurst } 
				{ trickslot = SpGrind_R_D_Triangle trickname = Trick_BlastGrind } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
			] 
		} 
	} 
	{ 
		display_name = "T.H.U.D." 
		first_name = "Creature" 
		skater_index = 20 
		default_appearance = appearance_creature 
		name = Creature 
		stance = regular 
		pushstyle = always_mongo 
		trickstyle = street 
		is_pro = 1 
		is_head_locked = 1 
		is_locked = 1 
		is_hidden = 1 
		is_secret 
		is_male = 1 
		age = -1 
		hometown = "the sewer" 
		points_available = 0 
		air = 10 
		run = 10 
		ollie = 10 
		speed = 10 
		spin = 10 
		switch = 10 
		flip_speed = 10 
		rail_balance = 10 
		lip_balance = 10 
		manual_balance = 10 
		sponsors = [ ] 
		trick_mapping = { } 
		default_trick_mapping = WolverineTricks 
		unlock_flag = SKATER_UNLOCKED_CREATURE 
		no_edit 
		no_edit_groups = [ 
			secret_options 
		] 
		max_specials = 11 
		specials = { 
			[ 
				{ trickslot = SpAir_U_R_circle trickname = Trick_3DSwimAir } 
				{ trickslot = SpGrind_D_L_Triangle trickname = Trick_3DScaryGrind } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
			] 
		} 
	} 
	{ 
		display_name = "Pedestrian" 
		first_name = "Ped" 
		skater_index = 21 
		default_appearance = ped_eric 
		name = Ped 
		profile_list = ped_profile_list 
		stance = regular 
		pushstyle = mongo_when_switch 
		trickstyle = street 
		is_pro = 1 
		is_head_locked = 1 
		is_locked = 1 
		is_hidden = 1 
		is_secret 
		is_male = 1 
		age = -1 
		hometown = "hell" 
		points_available = 0 
		air = 10 
		run = 10 
		ollie = 10 
		speed = 10 
		spin = 10 
		switch = 10 
		flip_speed = 10 
		rail_balance = 10 
		lip_balance = 10 
		manual_balance = 10 
		sponsors = [ ] 
		trick_mapping = { } 
		default_trick_mapping = WolverineTricks 
		unlock_flag = SKATER_UNLOCKED_PEDS 
		no_edit 
		no_edit_groups = [ 
			secret_options 
		] 
		max_specials = 11 
		specials = { 
			[ 
				{ trickslot = SpAir_L_D_Circle trickname = Trick_1234 } 
				{ trickslot = SpAir_R_U_Circle trickname = Trick_The900 } 
				{ trickslot = SpGrind_U_D_Triangle trickname = Trick_FlipKickDad } 
				{ trickslot = SpMan_L_R_Triangle trickname = Trick_OneFootOneWheel } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
				{ trickslot = Unassigned trickname = Unassigned } 
			] 
		} 
	} 
] 

