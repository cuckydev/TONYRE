
skater_f_head = [ 
	{ 
		desc_id = Steamer 
		frontend_desc = #"Elissa Steamer" 
		mesh = "models/skater_female/head_steamer.skin" 
		is_pro_head 
		is_steamer_head 
		hidden 
	} 
	{ 
		desc_id = %"Light Skin 1" 
		frontend_desc = #"Light Skin 1" 
		mesh = "models/skater_female/head_Female_01.skin" 
		mesh_if_facemapped = "models/skater_female/Facemap_female_01.skin" 
		SCRIPT disqualify_script 
			SetPart part = body desc_id = FemaleBody 
		ENDSCRIPT

		skintone = light 
	} 
	{ 
		desc_id = %"Light Skin 2" 
		frontend_desc = #"Light Skin 2" 
		mesh = "models/skater_female/head_Female_01.skin" 
		replace = "CS_NSN_F_wht_Head01" 
		with = "textures/skater_male/CS_CRS_F_Wht_Head02" 
		mesh_if_facemapped = "models/skater_female/Facemap_female_01.skin" 
		SCRIPT disqualify_script 
			SetPart part = body desc_id = FemaleBody 
		ENDSCRIPT

		skintone = light 
	} 
	{ 
		desc_id = %"Light Skin 3" 
		frontend_desc = #"Light Skin 3" 
		mesh = "models/skater_female/head_Female_01.skin" 
		replace = "CS_NSN_F_wht_Head01" 
		with = "textures/skater_male/CS_CRS_F_Wht_Head03" 
		mesh_if_facemapped = "models/skater_female/Facemap_female_01.skin" 
		SCRIPT disqualify_script 
			SetPart part = body desc_id = FemaleBody 
		ENDSCRIPT

		skintone = light 
	} 
	{ 
		desc_id = %"Dark Skin 1" 
		frontend_desc = #"Dark Skin 1" 
		mesh = "models/skater_female/head_Female_01.skin" 
		replace = "CS_NSN_F_wht_Head01" 
		with = "textures/skater_male/CS_CRS_F_blk_Head02" 
		mesh_if_facemapped = "models/skater_female/Facemap_female_01.skin" 
		SCRIPT disqualify_script 
			SetPart part = body desc_id = FemaleBody2 
		ENDSCRIPT

		skintone = dark 
	} 
	{ 
		desc_id = %"Dark Skin 2" 
		frontend_desc = #"Dark Skin 2" 
		mesh = "models/skater_female/head_Female_01.skin" 
		replace = "CS_NSN_F_wht_Head01" 
		with = "textures/skater_male/CS_CRS_F_blk_Head03" 
		mesh_if_facemapped = "models/skater_female/Facemap_female_01.skin" 
		SCRIPT disqualify_script 
			SetPart part = body desc_id = FemaleBody2 
		ENDSCRIPT

		skintone = dark 
	} 
	{ 
		desc_id = %"Dark Skin 3" 
		frontend_desc = #"Dark Skin 3" 
		mesh = "models/skater_female/head_Female_01.skin" 
		replace = "CS_NSN_F_wht_Head01" 
		with = "textures/skater_male/CS_CRS_F_blk_Head05" 
		mesh_if_facemapped = "models/skater_female/Facemap_female_01.skin" 
		SCRIPT disqualify_script 
			SetPart part = body desc_id = FemaleBody2 
		ENDSCRIPT

		skintone = dark 
	} 
	{ 
		desc_id = %"Tan Skin 1" 
		frontend_desc = #"Tan Skin 1" 
		mesh = "models/skater_female/head_Female_01.skin" 
		replace = "CS_NSN_F_wht_Head01" 
		with = "textures/skater_male/CS_CRS_F_Bwn_Head02" 
		mesh_if_facemapped = "models/skater_female/Facemap_female_01.skin" 
		SCRIPT disqualify_script 
			SetPart part = body desc_id = FemaleBody3 
		ENDSCRIPT

		skintone = tan 
	} 
	{ 
		desc_id = %"Tan Skin 2" 
		frontend_desc = #"Tan Skin 2" 
		mesh = "models/skater_female/head_Female_01.skin" 
		replace = "CS_NSN_F_wht_Head01" 
		with = "textures/skater_male/CS_CRS_F_Bwn_Head04" 
		mesh_if_facemapped = "models/skater_female/Facemap_female_01.skin" 
		SCRIPT disqualify_script 
			SetPart part = body desc_id = FemaleBody3 
		ENDSCRIPT

		skintone = tan 
	} 
	{ 
		desc_id = %"Tan Skin 3" 
		frontend_desc = #"Tan Skin 3" 
		mesh = "models/skater_female/head_Female_01.skin" 
		replace = "CS_NSN_F_wht_Head01" 
		with = "textures/skater_male/CS_CRS_F_Bwn_Head05" 
		mesh_if_facemapped = "models/skater_female/Facemap_female_01.skin" 
		SCRIPT disqualify_script 
			SetPart part = body desc_id = FemaleBody3 
		ENDSCRIPT

		skintone = tan 
	} 
	{ 
		desc_id = %"Grey Skin 1" 
		frontend_desc = #"Grey Skin 1" 
		mesh = "models/skater_female/head_Female_01.skin" 
		replace = "CS_NSN_F_wht_Head01" 
		with = "textures/skater_male/CS_NSN_F_Gry_Head01.png" 
		mesh_if_facemapped = "models/skater_female/Facemap_female_01.skin" 
		SCRIPT disqualify_script 
			SetPart part = body desc_id = FemaleBody4 
		ENDSCRIPT

		skintone = Grey 
	} 
	{ 
		desc_id = Skull 
		frontend_desc = #"Skull" 
		mesh = "models/skater_male/Head_Skull01.skin" 
		mesh_if_facemapped = "models/skater_female/Facemap_female_01.skin" 
		no_color 
		NoCutsceneHead 
		skintone = light 
	} 
	{ 
		desc_id = Eyes 
		frontend_desc = #"Eyes" 
		mesh = "models/skater_male/Skin_Extra_eyes.skin" 
		mesh_if_facemapped = "models/skater_female/Facemap_female_01.skin" 
		SCRIPT disqualify_script 
			ClearPart part = skater_f_hair 
		ENDSCRIPT

		no_color 
		NoCutsceneHead 
		skintone = light 
	} 
	{ 
		desc_id = None 
		frontend_desc = #"None" 
		hidden 
	} 
] 
skater_f_hair = [ 
	{ 
		desc_id = Medium 
		frontend_desc = #"Medium 1" 
		mesh = "models/skater_female/hair_medium.skin" 
		hair_type = Medium 
		replace = "CS_NSN_F_Hairline.png" 
		with = "textures/skater_male/CS_NSN_F_Hairline01.png" 
		in = all 
		default_h = 45 
		default_s = 38 
		default_v = 32 
	} 
	{ 
		desc_id = Medium2 
		frontend_desc = #"Medium 2" 
		mesh = "models/skater_male/Hair_M_Medium2.skin" 
		hair_type = Medium 
		default_h = 20 
		default_s = 32 
		default_v = 38 
	} 
	{ 
		desc_id = Medium3 
		frontend_desc = #"Medium 3" 
		mesh = "models/skater_male/Hair_M_Medium3.skin" 
		hair_type = Medium 
		default_h = 20 
		default_s = 32 
		default_v = 38 
	} 
	{ 
		desc_id = Short 
		frontend_desc = #"Short" 
		mesh = "models/skater_female/hair_F_short.skin" 
		hair_type = Medium 
		default_h = 45 
		default_s = 38 
		default_v = 32 
	} 
	{ 
		desc_id = Cropped 
		frontend_desc = #"Cropped" 
		mesh = "models/skater_female/hair_cropped.skin" 
		hair_type = Medium 
		default_h = 50 
		default_s = 41 
		default_v = 42 
	} 
	{ 
		desc_id = Bushy 
		frontend_desc = #"Bushy" 
		mesh = "models/skater_female/hair_bushy.skin" 
		hair_type = Medium 
		replace = "CS_NSN_F_Hairline.png" 
		with = "textures/skater_male/CS_NSN_F_Hairline01.png" 
		in = all 
		default_h = 290 
		default_s = 86 
		default_v = 56 
	} 
	{ 
		desc_id = Long 
		frontend_desc = #"Long 1" 
		mesh = "models/skater_female/hair_long.skin" 
		hair_type = Long 
		replace = "CS_NSN_F_Hairline.png" 
		with = "textures/skater_male/CS_NSN_F_Hairline01.png" 
		in = all 
	} 
	{ 
		desc_id = Long2 
		frontend_desc = #"Long 2" 
		mesh = "models/skater_female/hair_F_Long2.skin" 
		hair_type = Long 
		default_h = 45 
		default_s = 38 
		default_v = 32 
	} 
	{ 
		desc_id = Long1 
		frontend_desc = #"Long 3" 
		mesh = "models/skater_male/Hair_M_W_Longhair_A.skin" 
		hair_type = Long 
		default_h = 20 
		default_s = 32 
		default_v = 38 
	} 
	{ 
		desc_id = Braids 
		frontend_desc = #"Braids" 
		mesh = "models/skater_female/hair_Braids.skin" 
		hair_type = Medium 
		default_h = 45 
		default_s = 38 
		default_v = 32 
	} 
	{ 
		desc_id = Pigtails 
		frontend_desc = #"Pigtails" 
		mesh = "models/skater_female/hair_pigtails.skin" 
		hair_type = Medium 
		default_h = 45 
		default_s = 41 
		default_v = 50 
	} 
	{ 
		desc_id = Ponytail 
		frontend_desc = #"Ponytail 1" 
		mesh = "models/skater_female/hair_ponytail.skin" 
		hair_type = Ponytail 
		default_h = 35 
		default_s = 38 
		default_v = 22 
	} 
	{ 
		desc_id = Ponytail1 
		frontend_desc = #"Ponytail 2" 
		mesh = "models/skater_male/Hair_M_Ponytail1.skin" 
		hair_type = Ponytail 
		default_h = 20 
		default_s = 32 
		default_v = 38 
	} 
	{ 
		desc_id = Ponytail2 
		frontend_desc = #"Ponytail 3" 
		mesh = "models/skater_male/Hair_M_Ponytail2.skin" 
		hair_type = Ponytail 
		default_h = 20 
		default_s = 32 
		default_v = 38 
	} 
	{ 
		desc_id = Mohawk 
		frontend_desc = #"Mohawk 1" 
		mesh = "models/skater_male/Hair_M_W_Mohawk.skin" 
		replace = "CS_JB_Hair_MohawkD1.png" 
		with = "textures/skater_male/CS_JB_Hair_MohawkL1" 
		hair_type = Mohawk 
	} 
	{ 
		desc_id = %"Mohawk 2" 
		frontend_desc = #"Mohawk 2" 
		mesh = "models/skater_female/Hair_F_Mohawk2.skin" 
		hair_type = Mohawk 
		default_h = 345 
		default_s = 65 
		default_v = 56 
	} 
	{ 
		desc_id = %"Mohawk 3" 
		frontend_desc = #"Mohawk 3" 
		mesh = "models/skater_female/Hair_F_Mohawk.skin" 
		hair_type = Mohawk 
		default_h = 100 
		default_s = 50 
		default_v = 50 
	} 
	{ 
		desc_id = %"Liberty Spikes" 
		frontend_desc = #"Liberty Spikes" 
		mesh = "models/skater_male/Hair_M_LibertySpikes.skin" 
		hair_type = Mohawk 
		default_h = 285 
		default_s = 80 
		default_v = 52 
	} 
	{ 
		desc_id = Bald 
		frontend_desc = #"Bald" 
		no_color 
	} 
	{ 
		desc_id = Hair_MediumHAT 
		frontend_desc = #"Hair MediumHAT" 
		mesh = "models/skater_female/Hair_F_MediumHAT.skin" 
		hidden 
	} 
	{ 
		desc_id = Hair_PonytailHAT 
		frontend_desc = #"Hair_PonytailHAT" 
		mesh = "models/skater_male/Hair_M_PonytailHAT.skin" 
		hidden 
	} 
	{ 
		desc_id = Hair_LongHAT 
		frontend_desc = #"Hair_LongHAT" 
		mesh = "models/skater_female/Hair_F_LongHAT.skin" 
		hidden 
	} 
] 
skater_f_torso = [ 
	{ 
		desc_id = None 
		frontend_desc = #"None" 
		only_with = [ jenna ] 
		no_color 
	} 
	{ 
		desc_id = %"T-shirt" 
		frontend_desc = #"T-Shirt" 
		mesh = "models/skater_female/shirt_tshirt.skin" 
		replace = "CS_NSN_F_TShirt01.png" 
		with = "textures/skater_male/CS_NSN_Tshirt0" 
		replace1 = "CS_NSN_F_TSleeve01.png" 
		with1 = "textures/skater_male/CS_NSN_TSleeve0" 
		supports_logo 
		multicolor = 1 
		force_big_elbowpads 
	} 
	{ 
		desc_id = %"Shirt line" 
		frontend_desc = #"Shirt Line" 
		mesh = "models/skater_female/shirt_tshirt.skin" 
		supports_logo 
		multicolor = 1 
		force_big_elbowpads 
	} 
	{ 
		desc_id = %"Camo T-shirt" 
		frontend_desc = #"Camo T-Shirt" 
		mesh = "models/skater_female/shirt_tshirt.skin" 
		replace = "CS_NSN_F_TShirt01.png" 
		with = "textures/skater_male/CS_NSN_shirt_camo01" 
		replace1 = "CS_NSN_F_TSleeve01.png" 
		with1 = "textures/skater_male/CS_NSN_shirtslv_camo_short01" 
		supports_logo 
		multicolor = 1 
		force_big_elbowpads 
	} 
	{ 
		desc_id = Striped 
		frontend_desc = #"Striped" 
		mesh = "models/skater_female/shirt_tshirt.skin" 
		replace = "CS_NSN_F_TShirt01.png" 
		with = "textures/skater_male/CS_NSN_shirt_stripe01" 
		replace1 = "CS_NSN_F_TSleeve01.png" 
		with1 = "textures/skater_male/CS_NSN_Sleeve_stripe01" 
		supports_logo 
		multicolor = 1 
		force_big_elbowpads 
	} 
	{ 
		desc_id = %"Tie-Dye" 
		frontend_desc = #"Tie-Dye" 
		mesh = "models/skater_female/shirt_tshirt.skin" 
		replace = "CS_NSN_F_TShirt01.png" 
		with = "textures/skater_male/CS_JB_shirt_tiedye" 
		replace1 = "CS_NSN_F_TSleeve01.png" 
		with1 = "textures/skater_male/CS_JB_sleeve_short_tiedye" 
		supports_logo 
		multicolor = 1 
		force_big_elbowpads 
	} 
	{ 
		desc_id = %"Button Open SS" 
		frontend_desc = #"Button Open SS" 
		mesh = "models/skater_female/shirt_button_open_ss.skin" 
		force_big_elbowpads 
	} 
	{ 
		desc_id = %"Button Open LS" 
		frontend_desc = #"Button Open LS" 
		mesh = "models/skater_female/Shirt_button_open_ls.skin" 
		multicolor = 1 
		force_big_elbowpads 
		SCRIPT disqualify_script 
			cas_temp_disq_remove_accessories 
		ENDSCRIPT

	} 
	{ desc_id = %"Halter Top" 
		frontend_desc = #"Halter Top" 
		mesh = "models/skater_female/Shirt_haltertop.skin" 
	} 
	{ 
		desc_id = %"Baseball-T" 
		frontend_desc = #"Baseball-T" 
		mesh = "models/skater_female/Shirt_baseball-t.skin" 
		supports_logo 
		force_big_elbowpads 
		multicolor = 1 
		default_h = 25 
		default_s = 59 
		default_v = 50 
	} 
	{ 
		desc_id = Sleeveless 
		frontend_desc = #"Sleeveless" 
		mesh = "models/skater_female/shirt_sleeveless.skin" 
		supports_logo 
		no_back_logo 
	} 
	{ 
		desc_id = %"Button SS" 
		frontend_desc = #"Button SS" 
		mesh = "models/skater_female/shirt_button_ss.skin" 
	} 
	{ 
		desc_id = Collar 
		frontend_desc = #"Collar" 
		mesh = "models/skater_female/shirt_collar.skin" 
		default_h = 345 
		default_s = 29 
		default_v = 56 
	} 
	{ 
		desc_id = Longsleeve 
		frontend_desc = #"Longsleeve" 
		mesh = "models/skater_female/Shirt_Longsleeve.skin" 
		supports_logo 
		force_big_elbowpads 
		SCRIPT disqualify_script 
			cas_temp_disq_remove_accessories 
		ENDSCRIPT

		multicolor = 1 
	} 
	{ 
		desc_id = %"T-shirt Long Sleeve" 
		frontend_desc = #"T-shirt Long Sleeve" 
		mesh = "models/skater_female/shirt_T_longsleeve.skin" 
		supports_logo 
		force_big_elbowpads 
		SCRIPT disqualify_script 
			cas_temp_disq_remove_accessories 
		ENDSCRIPT

		multicolor = 1 
		default_h = 220 
		default_s = 50 
		default_v = 52 
	} 
	{ 
		desc_id = %"Button LS" 
		frontend_desc = #"Button LS" 
		mesh = "models/skater_female/shirt_button_ls.skin" 
		force_big_elbowpads 
		SCRIPT disqualify_script 
			cas_temp_disq_remove_accessories 
		ENDSCRIPT

		default_h = 100 
		default_s = 42 
		default_v = 44 
	} 
	{ 
		desc_id = %"V-Neck" 
		frontend_desc = #"V-Neck" 
		mesh = "models/skater_female/shirt_SSVneck.skin" 
		multicolor = 1 
	} 
	{ 
		desc_id = Jersey 
		frontend_desc = #"Jersey" 
		mesh = "models/skater_female/shirt_jersey.skin" 
		shows_panties 
		not_with_backpack 
	} 
	{ 
		desc_id = %"Tanktop short" 
		frontend_desc = #"Tanktop Short" 
		mesh = "models/skater_female/shirt_tanktop_2.skin" 
		supports_logo 
		no_back_logo 
	} 
	{ 
		desc_id = Tanktop 
		frontend_desc = #"Tanktop" 
		mesh = "models/skater_female/shirt_tanktop.skin" 
		supports_logo 
		no_back_logo 
	} 
	{ 
		desc_id = %"Tie-Dye Tank" 
		frontend_desc = #"Tie-Dye Tank" 
		mesh = "models/skater_female/shirt_tanktop.skin" 
		replace = "CS_Nsn_female_tanktop.png" 
		with = "textures/skater_male/CS_NSN_f_tanktop_dye" 
		supports_logo 
		no_back_logo 
	} 
	{ 
		desc_id = %"Floral Tank" 
		frontend_desc = #"Floral Tank" 
		mesh = "models/skater_female/shirt_tanktop.skin" 
		replace = "CS_Nsn_female_tanktop.png" 
		with = "textures/skater_male/CS_NSN_f_tanktop_floral" 
		supports_logo 
		no_back_logo 
	} 
	{ 
		desc_id = %"Denim Jacket" 
		frontend_desc = #"Denim Jacket" 
		mesh = "models/skater_female/shirt_denimjacket.skin" 
		shows_panties 
		not_with_backpack 
		force_big_elbowpads 
		not_with_weird_hat 
		SCRIPT disqualify_script 
			cas_temp_disq_remove_accessories 
		ENDSCRIPT

	} 
	{ 
		desc_id = %"Baggy Vest" 
		frontend_desc = #"Baggy Vest" 
		mesh = "models/skater_female/shirt_baggyvest.skin" 
		shows_panties 
		not_with_backpack 
	} 
	{ 
		desc_id = %"Leather Vest" 
		frontend_desc = #"Leather Vest" 
		mesh = "models/skater_female/shirt_baggyvest.skin" 
		replace = "CS_NH_baggyvest.png" 
		with = "textures/skater_male/CS_NH_leathervest" 
		shows_panties 
		not_with_backpack 
	} 
	{ 
		desc_id = %"Hoody Up" 
		frontend_desc = #"Hoody Up" 
		mesh = "models/skater_female/shirt_F_Hoodyup.skin" 
		supports_logo 
		SCRIPT disqualify_script 
			ClearPart part = skater_f_hair 
			ClearPart part = hat 
			ClearPart part = helmet 
			cas_temp_disq_remove_accessories 
		ENDSCRIPT

		force_big_elbowpads 
		not_with_weird_hat 
		default_h = 15 
		default_s = 5 
		default_v = 26 
	} 
	{ 
		desc_id = %"Hoody Down" 
		frontend_desc = #"Hoody Down" 
		mesh = "models/skater_female/shirt_F_Hoodydown.skin" 
		supports_logo 
		no_back_logo 
		SCRIPT disqualify_script 
			cas_temp_disq_remove_accessories 
		ENDSCRIPT

		force_big_elbowpads 
		not_with_weird_hat 
		default_h = 20 
		default_s = 20 
		default_v = 34 
	} 
	{ 
		desc_id = %"Tube Top" 
		frontend_desc = #"Tube Top" 
		mesh = "models/skater_female/shirt_tube.skin" 
	} 
	{ 
		desc_id = %"Coconut Bra" 
		frontend_desc = #"Coconut Bra" 
		mesh = "models/skater_female/shirt_coconutbra.skin" 
		not_with_backpack 
	} 
	{ 
		desc_id = %"Russian coat" 
		frontend_desc = #"Russian coat" 
		mesh = "models/skater_male/shirt_jacket_bomber.skin" 
		not_with_backpack 
		SCRIPT disqualify_script 
			cas_temp_disq_remove_accessories 
		ENDSCRIPT

		not_with_elbowpads 
		not_with_weird_hat 
		multicolor = 1 
	} 
	{ 
		desc_id = %"Jogger Jacket" 
		frontend_desc = #"Jogger Jacket" 
		mesh = "models/skater_female/shirt_jogger.skin" 
		not_with_elbowpads 
		SCRIPT disqualify_script 
			cas_temp_disq_remove_accessories 
		ENDSCRIPT

		default_h = 325 
		default_s = 50 
		default_v = 50 
	} 
] 
skater_f_legs = [ 
	{ 
		desc_id = None 
		frontend_desc = #"None" 
		only_with = [ jenna ] 
		no_color 
	} 
	{ 
		desc_id = Shorts 
		frontend_desc = #"Shorts" 
		mesh = "models/skater_female/pant_shorts.skin" 
		shows_panties 
	} 
	{ 
		desc_id = %"Shorts Denim" 
		frontend_desc = #"Shorts Denim" 
		mesh = "models/skater_female/pant_shorts.skin" 
		replace = "CAS_CRS_Shorts_Cargo.png" 
		with = "textures/skater_male/CAS_CRS_Shorts_Denim02" 
		shows_panties 
	} 
	{ 
		desc_id = %"Short Shorts Denim" 
		frontend_desc = #"Short Shorts Denim" 
		mesh = "models/skater_female/pant_shortshorts.skin" 
		shows_panties 
	} 
	{ 
		desc_id = %"Short Flowers" 
		frontend_desc = #"Short Flowers" 
		mesh = "models/skater_female/pant_shortshorts.skin" 
		replace = "CAS_CRS_Shorts_Denim.png" 
		with = "textures/skater_male/CAS_CRS_Shorts_Pattern" 
		shows_panties 
	} 
	{ 
		desc_id = %"Shorts Daisy" 
		frontend_desc = #"Shorts Daisy" 
		mesh = "models/skater_female/pant_daisy.skin" 
	} 
	{ 
		desc_id = %"Mini Skirt" 
		frontend_desc = #"Mini Skirt" 
		mesh = "models/skater_female/pant_miniskirt.skin" 
		default_h = 200 
		default_s = 53 
		default_v = 36 
	} 
	{ 
		desc_id = Regular 
		frontend_desc = #"Regular" 
		mesh = "models/skater_female/pant_regular.skin" 
		force_big_kneepads 
		covers_socks 
	} 
	{ 
		desc_id = Tight 
		frontend_desc = #"Tight" 
		mesh = "models/skater_female/pant_tight.skin" 
		force_big_kneepads 
		covers_socks 
	} 
	{ 
		desc_id = Baggy 
		frontend_desc = #"Baggy" 
		mesh = "models/skater_female/pant_baggy.skin" 
		default_h = 55 
		default_s = 35 
		default_v = 34 
		not_with_kneepads 
		covers_socks 
	} 
	{ 
		desc_id = Steamer 
		frontend_desc = #"Steamer" 
		mesh = "models/skater_female/pant_baggy.skin" 
		replace = "CS_NSN_pants_feamle.png" 
		with = "textures/skater_male/CS_NSN_steamer_pants" 
		hidden 
		force_big_kneepads 
		covers_socks 
	} 
	{ 
		desc_id = %"Snow Pants" 
		frontend_desc = #"Snow Pants" 
		mesh = "models/skater_male/pants_baggy.skin" 
		replace = "CS_NSN_pants_denim01.png" 
		with = "textures/skater_male/CS_NSN_pants_snow02" 
		not_with_kneepads 
		covers_socks 
	} 
	{ 
		desc_id = %"Camo Pants" 
		frontend_desc = #"Camo Pants" 
		mesh = "models/skater_female/pant_baggy.skin" 
		replace = "CS_NSN_pants_feamle.png" 
		with = "textures/skater_male/CS_NSN_cargoshorts_camo" 
		force_big_kneepads 
		covers_socks 
	} 
	{ 
		desc_id = %"Stripe Pants" 
		frontend_desc = #"Stripe Pants" 
		mesh = "models/skater_female/pant_regular.skin" 
		replace = "CS_NSN_pants_feamle.png" 
		with = "textures/skater_male/CS_NSN_baggypants_stripe" 
		force_big_kneepads 
		covers_socks 
	} 
	{ 
		desc_id = Bellbottoms 
		frontend_desc = #"Bellbottoms" 
		mesh = "models/skater_female/pant_bellbottoms.skin" 
		default_h = 225 
		default_s = 18 
		default_v = 42 
		force_big_kneepads 
		covers_socks 
	} 
	{ 
		desc_id = %"Ankle Pants" 
		frontend_desc = #"Ankle Pants" 
		mesh = "models/skater_female/pant_ankle.skin" 
		shows_panties 
		force_big_kneepads 
	} 
	{ 
		desc_id = Jogger 
		frontend_desc = #"Jogger" 
		mesh = "models/skater_male/pants_jogger.skin" 
		default_h = 325 
		default_s = 50 
		default_v = 50 
		force_big_kneepads 
	} 
] 
skater_f_socks = [ 
	{ 
		desc_id = None 
		frontend_desc = #"None" 
		no_color 
	} 
	{ 
		desc_id = High 
		frontend_desc = #"High" 
		mesh = "models/skater_male/extra_socks.skin" 
		replace = "CS_NN_socks.png" 
		with = "textures/skater_male/CS_NH_sock02" 
		SCRIPT disqualify_script 
			cas_temp_disq_check_for_covered_socks 
		ENDSCRIPT

	} 
	{ 
		desc_id = Medium 
		frontend_desc = #"Medium" 
		mesh = "models/skater_male/extra_socks.skin" 
		SCRIPT disqualify_script 
			cas_temp_disq_check_for_covered_socks 
		ENDSCRIPT

	} 
	{ 
		desc_id = Ankle 
		frontend_desc = #"Ankle" 
		mesh = "models/skater_male/extra_socks.skin" 
		replace = "CS_NN_socks.png" 
		with = "textures/skater_male/CS_NH_sock03" 
		SCRIPT disqualify_script 
			cas_temp_disq_check_for_covered_socks 
		ENDSCRIPT

	} 
	{ 
		desc_id = Sport 
		frontend_desc = #"Sport" 
		mesh = "models/skater_male/extra_socks.skin" 
		replace = "CS_NN_socks.png" 
		with = "textures/skater_male/CAS_MLS_sportsocks" 
		SCRIPT disqualify_script 
			cas_temp_disq_check_for_covered_socks 
		ENDSCRIPT

	} 
	{ 
		desc_id = English 
		frontend_desc = #"English" 
		mesh = "models/skater_male/extra_socks.skin" 
		replace = "CS_NN_socks.png" 
		with = "textures/skater_male/CAS_MLS_english" 
		SCRIPT disqualify_script 
			cas_temp_disq_check_for_covered_socks 
		ENDSCRIPT

	} 
] 
skater_f_backpack = [ 
	{ 
		desc_id = None 
		frontend_desc = #"None" 
		no_color 
	} 
	{ 
		desc_id = Backpack1 
		frontend_desc = #"Backpack 1" 
		mesh = "models/skater_male/extra_backpack.skin" 
		is_backpack 
	} 
	{ 
		desc_id = %"Backpack 2" 
		frontend_desc = #"Backpack 2" 
		mesh = "models/skater_male/extra_backpack.skin" 
		replace = "CAS_TZ_Backpack02.png" 
		with = "textures/skater_male/CAS_TZ_Backpack02a.png" 
		is_backpack 
	} 
	{ 
		desc_id = %"Backpack 3" 
		frontend_desc = #"Backpack 3" 
		mesh = "models/skater_male/extra_backpack02.skin" 
		is_backpack 
	} 
	{ 
		desc_id = %"Backpack 4" 
		frontend_desc = #"Backpack 4" 
		mesh = "models/skater_male/extra_backpack02.skin" 
		replace = "CAS_TZ_Backpack03.png" 
		with = "textures/skater_male/CAS_TZ_Backpack03a.png" 
		is_backpack 
	} 
] 

