common_griptape_params = 
{ 
	replace = "CS_NSN_griptape_default.png" 
	in = board 
} 
griptape = [ 
	{ 
		desc_id = %"Generic 1" 
		frontend_desc = #"Generic Cut" 
		common_griptape_params 
		with = "textures/boards/GenericG01" 
		is_a_deck = is_a_deck 
	} 
	{ 
		desc_id = %"Generic 2" 
		frontend_desc = #"Solid" 
		common_griptape_params 
		with = "textures/boards/GenericG02" 
	} 
	{ 
		desc_id = %"Generic 3" 
		frontend_desc = #"Razor\'s Edge" 
		common_griptape_params 
		with = "textures/boards/GenericG03" 
	} 
	{ 
		desc_id = %"Generic 4" 
		frontend_desc = #"Equal" 
		common_griptape_params 
		with = "textures/boards/GenericG04" 
	} 
	{ 
		desc_id = %"Generic 5" 
		frontend_desc = #"Slasher" 
		common_griptape_params 
		with = "textures/boards/GenericG05" 
	} 
	{ 
		desc_id = %"Generic 7" 
		frontend_desc = #"Ye Old School" 
		common_griptape_params 
		with = "textures/boards/GenericG07" 
	} 
	{ 
		desc_id = %"Generic 8" 
		frontend_desc = #"Striper" 
		common_griptape_params 
		with = "textures/boards/GenericG08" 
	} 
	{ 
		desc_id = %"Generic 9" 
		frontend_desc = #"Thrashed" 
		common_griptape_params 
		with = "textures/boards/GenericG09" 
	} 
	{ 
		desc_id = %"Generic 14" 
		frontend_desc = #"Crack" 
		common_griptape_params 
		with = "textures/boards/GenericG14" 
	} 
	{ 
		desc_id = %"Generic 15" 
		frontend_desc = #"Eye Don\'t Know" 
		common_griptape_params 
		with = "textures/boards/GenericG15" 
	} 
	{ 
		desc_id = %"Generic 10" 
		frontend_desc = #"Colored Nuts" 
		common_griptape_params 
		with = "textures/boards/GenericG10" 
	} 
	{ 
		desc_id = %"Generic 11" 
		frontend_desc = #"Green Machine" 
		common_griptape_params 
		with = "textures/boards/GenericG11" 
	} 
	{ 
		desc_id = %"Generic 12" 
		frontend_desc = #"Blues" 
		common_griptape_params 
		with = "textures/boards/GenericG12" 
	} 
	{ 
		desc_id = %"Generic 13" 
		frontend_desc = #"Red Light" 
		common_griptape_params 
		with = "textures/boards/GenericG13" 
	} 
	{ 
		desc_id = %"Hawk 1" 
		frontend_desc = #"Hawk" 
		common_griptape_params 
		with = "textures/boards/HawkG01" 
	} 
	{ 
		desc_id = %"Caballero 1" 
		frontend_desc = #"Caballero" 
		common_griptape_params 
		with = "textures/boards/CaballeroG01" 
	} 
	{ 
		desc_id = %"Glifberg 1" 
		frontend_desc = #"Glifberg" 
		common_griptape_params 
		with = "textures/boards/GlifbergG01" 
	} 
	{ 
		desc_id = %"Koston 1" 
		frontend_desc = #"Koston" 
		common_griptape_params 
		with = "textures/boards/KostonG01" 
	} 
	{ 
		desc_id = %"Mullen 1" 
		frontend_desc = #"Mullen" 
		common_griptape_params 
		with = "textures/boards/MullenG01" 
	} 
	{ 
		desc_id = %"Muska 1" 
		frontend_desc = #"Muska" 
		common_griptape_params 
		with = "textures/boards/MuskaG01" 
	} 
	{ 
		desc_id = %"Thomas 1" 
		frontend_desc = #"Thomas" 
		common_griptape_params 
		with = "textures/boards/ThomasG01" 
	} 
] 
common_deck_graphic_params = 
{ 
	replace = "CS_NSN_board_default.png" 
	in = board 
} 
deck_graphic = [ 
	{ 
		desc_id = %"PR Deck 1" 
		frontend_desc = #"Almost - Wrong" 
		common_deck_graphic_params 
		with = "textures/boards/PR_AL_deck01" 
		flag = BOARDSHOP_UNLOCKED 
		is_a_deck = is_a_deck 
		deck_graphic 
	} 
	{ 
		desc_id = %"PR Deck 2" 
		frontend_desc = #"Almost - Mullen" 
		common_deck_graphic_params 
		with = "textures/boards/PR_AL_deck02" 
		flag = BOARDSHOP_UNLOCKED 
	} 
	{ 
		desc_id = %"PR Deck 3" 
		frontend_desc = #"Baker - Regans Logo" 
		common_deck_graphic_params 
		with = "textures/boards/PR_BA_deck03" 
		flag = BOARDSHOP_UNLOCKED 
	} 
	{ 
		desc_id = %"PR Deck 4" 
		frontend_desc = #"Baker - Reynolds" 
		common_deck_graphic_params 
		with = "textures/boards/PR_BA_deck04" 
		flag = BOARDSHOP_UNLOCKED 
	} 
	{ 
		desc_id = %"PR Deck 5" 
		frontend_desc = #"Birdhouse - Strip" 
		common_deck_graphic_params 
		with = "textures/boards/PR_BH_deck05" 
		skater = hawk 
		flag = BOARDSHOP_UNLOCKED 
	} 
	{ 
		desc_id = %"PR Deck 6" 
		frontend_desc = #"Birdhouse - Blood" 
		common_deck_graphic_params 
		with = "textures/boards/PR_BH_deck06" 
		skater = hawk 
		flag = BOARDSHOP_UNLOCKED 
	} 
	{ 
		desc_id = %"PR Deck 7" 
		frontend_desc = #"Bootleg - Doves 3K" 
		common_deck_graphic_params 
		with = "textures/boards/PR_BO_deck07" 
		flag = BOARDSHOP_UNLOCKED 
	} 
	{ 
		desc_id = %"PR Deck 8" 
		frontend_desc = #"Element" 
		common_deck_graphic_params 
		with = "textures/boards/PR_EL_deck08" 
		flag = BOARDSHOP_UNLOCKED 
	} 
	{ 
		desc_id = %"PR Deck 9" 
		frontend_desc = #"Element - Margera" 
		common_deck_graphic_params 
		with = "textures/boards/PR_EL_deck09" 
		flag = BOARDSHOP_UNLOCKED 
	} 
	{ 
		desc_id = %"PR Deck 10" 
		frontend_desc = #"The Firm" 
		common_deck_graphic_params 
		with = "textures/boards/PR_FR_deck10" 
		flag = BOARDSHOP_UNLOCKED 
	} 
	{ 
		desc_id = %"PR Deck 11" 
		frontend_desc = #"The Firm - Burnquist" 
		common_deck_graphic_params 
		with = "textures/boards/PR_FR_deck11" 
		flag = BOARDSHOP_UNLOCKED 
	} 
	{ 
		desc_id = %"PR Deck 12" 
		frontend_desc = #"Flip - Alchemy" 
		common_deck_graphic_params 
		with = "textures/boards/PR_FL_deck12" 
		flag = BOARDSHOP_UNLOCKED 
	} 
	{ 
		desc_id = %"PR Deck 13" 
		frontend_desc = #"Flip - Sorry" 
		common_deck_graphic_params 
		with = "textures/boards/PR_FL_deck13" 
		flag = BOARDSHOP_UNLOCKED 
	} 
	{ 
		desc_id = %"PR Deck 14" 
		frontend_desc = #"Girl - OG 2" 
		common_deck_graphic_params 
		with = "textures/boards/PR_GR_deck14" 
		flag = BOARDSHOP_UNLOCKED 
	} 
	{ 
		desc_id = %"PR Deck 15" 
		frontend_desc = #"Girl - OG 4" 
		common_deck_graphic_params 
		with = "textures/boards/PR_GR_deck15" 
		flag = BOARDSHOP_UNLOCKED 
	} 
	{ 
		desc_id = %"PR Deck 16" 
		frontend_desc = #"Powell - Caballero" 
		common_deck_graphic_params 
		with = "textures/boards/PR_PO_deck16" 
		flag = BOARDSHOP_UNLOCKED 
	} 
	{ 
		desc_id = %"PR Deck 17" 
		frontend_desc = #"Shortys - Mixer" 
		common_deck_graphic_params 
		with = "textures/boards/PR_SH_deck17" 
		flag = BOARDSHOP_UNLOCKED 
	} 
	{ 
		desc_id = %"PR Deck 18" 
		frontend_desc = #"Shortys - Muska" 
		common_deck_graphic_params 
		with = "textures/boards/PR_SH_deck18" 
		flag = BOARDSHOP_UNLOCKED 
	} 
	{ 
		desc_id = %"PR Deck 19" 
		frontend_desc = #"Zero - Blood 3" 
		common_deck_graphic_params 
		with = "textures/boards/PR_ZR_deck19" 
		flag = BOARDSHOP_UNLOCKED 
	} 
	{ 
		desc_id = %"PR Deck 20" 
		frontend_desc = #"Zero - Thomas" 
		common_deck_graphic_params 
		with = "textures/boards/PR_ZR_deck20" 
		flag = BOARDSHOP_UNLOCKED 
	} 
	{ 
		desc_id = %"BH Deck 1" 
		frontend_desc = #"Birdhouse" 
		common_deck_graphic_params 
		with = "textures/boards/BH_deck01" 
		RotateDeckRight 
		unlock_flag = BOARDS_UNLOCKED_BIRDHOUSE 
	} 
	{ 
		desc_id = %"BH Deck 2" 
		frontend_desc = #"Hawk - Bat" 
		common_deck_graphic_params 
		with = "textures/boards/BH_deck02" 
		unlock_flag = BOARDS_UNLOCKED_BIRDHOUSE 
	} 
	{ 
		desc_id = %"BH Deck 3" 
		frontend_desc = #"Hawk - Dragon Skull" 
		common_deck_graphic_params 
		with = "textures/boards/BH_deck03" 
		unlock_flag = BOARDS_UNLOCKED_BIRDHOUSE 
	} 
	{ 
		desc_id = %"BH Deck 4" 
		frontend_desc = #"Hawk - McSqueeb" 
		common_deck_graphic_params 
		with = "textures/boards/BH_deck04" 
		unlock_flag = BOARDS_UNLOCKED_BIRDHOUSE 
	} 
	{ 
		desc_id = %"BH Deck 5" 
		frontend_desc = #"Hawk - Full Skull" 
		common_deck_graphic_params 
		with = "textures/boards/BH_deck05" 
		unlock_flag = BOARDS_UNLOCKED_BIRDHOUSE 
	} 
	{ 
		desc_id = %"BH Deck 6" 
		frontend_desc = #"Hawk - Evil Cat" 
		common_deck_graphic_params 
		with = "textures/boards/BH_deck06" 
		unlock_flag = BOARDS_UNLOCKED_BIRDHOUSE 
	} 
	{ 
		desc_id = %"BH Deck 7" 
		frontend_desc = #"Lasek - Slammers" 
		common_deck_graphic_params 
		with = "textures/boards/BH_deck07" 
		unlock_flag = BOARDS_UNLOCKED_BIRDHOUSE 
	} 
	{ 
		desc_id = %"BH Deck 8" 
		frontend_desc = #"Lasek - Rooster" 
		common_deck_graphic_params 
		with = "textures/boards/BH_deck08" 
		unlock_flag = BOARDS_UNLOCKED_BIRDHOUSE 
	} 
	{ 
		desc_id = %"BH Deck 9" 
		frontend_desc = #"Lasek - Born to Lose" 
		common_deck_graphic_params 
		with = "textures/boards/BH_deck09" 
		unlock_flag = BOARDS_UNLOCKED_BIRDHOUSE 
	} 
	{ 
		desc_id = %"BH Deck 10" 
		frontend_desc = #"Lasek - Racecar" 
		common_deck_graphic_params 
		with = "textures/boards/BH_deck10" 
		unlock_flag = BOARDS_UNLOCKED_BIRDHOUSE 
	} 
	{ 
		desc_id = %"EL Deck 1" 
		frontend_desc = #"Margera 1" 
		common_deck_graphic_params 
		with = "textures/boards/EL_deck01" 
		unlock_flag = BOARDS_UNLOCKED_ELEMENT 
	} 
	{ 
		desc_id = %"EL Deck 2" 
		frontend_desc = #"Element - Greener" 
		common_deck_graphic_params 
		with = "textures/boards/EL_deck02" 
		unlock_flag = BOARDS_UNLOCKED_ELEMENT 
	} 
	{ 
		desc_id = %"EL Deck 3" 
		frontend_desc = #"Margera 2" 
		common_deck_graphic_params 
		with = "textures/boards/EL_deck03" 
		unlock_flag = BOARDS_UNLOCKED_ELEMENT 
	} 
	{ 
		desc_id = %"EL Deck 4" 
		frontend_desc = #"Element - Projects" 
		common_deck_graphic_params 
		with = "textures/boards/EL_deck04" 
		unlock_flag = BOARDS_UNLOCKED_ELEMENT 
	} 
	{ 
		desc_id = %"EL Deck 5" 
		frontend_desc = #"Margera 3" 
		common_deck_graphic_params 
		with = "textures/boards/EL_deck05" 
		unlock_flag = BOARDS_UNLOCKED_ELEMENT 
	} 
	{ 
		desc_id = %"EL Deck 6" 
		frontend_desc = #"Margera 4" 
		common_deck_graphic_params 
		with = "textures/boards/EL_deck06" 
		unlock_flag = BOARDS_UNLOCKED_ELEMENT 
	} 
	{ 
		desc_id = %"EL Deck 7" 
		frontend_desc = #"Element" 
		common_deck_graphic_params 
		with = "textures/boards/EL_deck07" 
		unlock_flag = BOARDS_UNLOCKED_ELEMENT 
	} 
	{ 
		desc_id = %"EL Deck 8" 
		frontend_desc = #"Margera 5" 
		common_deck_graphic_params 
		with = "textures/boards/EL_deck08" 
		unlock_flag = BOARDS_UNLOCKED_ELEMENT 
	} 
	{ 
		desc_id = %"EL Deck 9" 
		frontend_desc = #"Mike V." 
		common_deck_graphic_params 
		with = "textures/boards/EL_deck09" 
		unlock_flag = BOARDS_UNLOCKED_ELEMENT 
	} 
	{ 
		desc_id = %"EL Deck 10" 
		frontend_desc = #"Margera 6" 
		common_deck_graphic_params 
		with = "textures/boards/EL_deck10" 
		unlock_flag = BOARDS_UNLOCKED_ELEMENT 
	} 
	{ 
		desc_id = %"FL Deck 1" 
		frontend_desc = #"Flip - Metalhead" 
		common_deck_graphic_params 
		with = "textures/boards/FL_deck01" 
		unlock_flag = BOARDS_UNLOCKED_FLIP 
	} 
	{ 
		desc_id = %"FL Deck 2" 
		frontend_desc = #"Saari - Braindead" 
		common_deck_graphic_params 
		with = "textures/boards/FL_deck02" 
		unlock_flag = BOARDS_UNLOCKED_FLIP 
	} 
	{ 
		desc_id = %"FL Deck 3" 
		frontend_desc = #"Saari - Serpent" 
		common_deck_graphic_params 
		with = "textures/boards/FL_deck03" 
		unlock_flag = BOARDS_UNLOCKED_FLIP 
	} 
	{ 
		desc_id = %"FL Deck 4" 
		frontend_desc = #"Saari - Reindeer" 
		common_deck_graphic_params 
		with = "textures/boards/FL_deck04" 
		unlock_flag = BOARDS_UNLOCKED_FLIP 
	} 
	{ 
		desc_id = %"FL Deck 5" 
		frontend_desc = #"Saari - Flippo" 
		common_deck_graphic_params 
		with = "textures/boards/FL_deck05" 
		unlock_flag = BOARDS_UNLOCKED_FLIP 
	} 
	{ 
		desc_id = %"FL Deck 6" 
		frontend_desc = #"Rowley - Hellion" 
		common_deck_graphic_params 
		with = "textures/boards/FL_deck06" 
		unlock_flag = BOARDS_UNLOCKED_FLIP 
	} 
	{ 
		desc_id = %"FL Deck 7" 
		frontend_desc = #"Rowley - Motor" 
		common_deck_graphic_params 
		with = "textures/boards/FL_deck07" 
		unlock_flag = BOARDS_UNLOCKED_FLIP 
	} 
	{ 
		desc_id = %"FL Deck 8" 
		frontend_desc = #"Rowley - Alarmed" 
		common_deck_graphic_params 
		with = "textures/boards/FL_deck08" 
		unlock_flag = BOARDS_UNLOCKED_FLIP 
	} 
	{ 
		desc_id = %"FL Deck 9" 
		frontend_desc = #"Rowley - Death" 
		common_deck_graphic_params 
		with = "textures/boards/FL_deck09" 
		unlock_flag = BOARDS_UNLOCKED_FLIP 
	} 
	{ 
		desc_id = %"FL Deck 10" 
		frontend_desc = #"Glifberg - Fire Demon" 
		common_deck_graphic_params 
		with = "textures/boards/FL_deck10" 
		unlock_flag = BOARDS_UNLOCKED_FLIP 
	} 
	{ 
		desc_id = %"GR Deck 1" 
		frontend_desc = #"Girl - OG 1" 
		common_deck_graphic_params 
		with = "textures/boards/GR_deck01" 
		unlock_flag = BOARDS_UNLOCKED_GIRL 
	} 
	{ 
		desc_id = %"GR Deck 2" 
		frontend_desc = #"Girl - OG 3" 
		common_deck_graphic_params 
		with = "textures/boards/GR_deck02" 
		unlock_flag = BOARDS_UNLOCKED_GIRL 
	} 
	{ 
		desc_id = %"GR Deck 3" 
		frontend_desc = #"Koston - Wooden" 
		common_deck_graphic_params 
		with = "textures/boards/GR_deck03" 
		unlock_flag = BOARDS_UNLOCKED_GIRL 
	} 
	{ 
		desc_id = %"GR Deck 4" 
		frontend_desc = #"Koston - NoWave" 
		common_deck_graphic_params 
		with = "textures/boards/GR_deck04" 
		unlock_flag = BOARDS_UNLOCKED_GIRL 
	} 
	{ 
		desc_id = %"GR Deck 5" 
		frontend_desc = #"Koston - Perspective" 
		common_deck_graphic_params 
		with = "textures/boards/GR_deck05" 
		unlock_flag = BOARDS_UNLOCKED_GIRL 
	} 
	{ 
		desc_id = %"GR Deck 6" 
		frontend_desc = #"Koston - Scribble" 
		common_deck_graphic_params 
		with = "textures/boards/GR_deck06" 
		unlock_flag = BOARDS_UNLOCKED_GIRL 
	} 
	{ 
		desc_id = %"GR Deck 7" 
		frontend_desc = #"Rodriguez" 
		common_deck_graphic_params 
		with = "textures/boards/GR_deck07" 
		unlock_flag = BOARDS_UNLOCKED_GIRL 
	} 
	{ 
		desc_id = %"GR Deck 8" 
		frontend_desc = #"Rodriguez - NoWave" 
		common_deck_graphic_params 
		with = "textures/boards/GR_deck08" 
		unlock_flag = BOARDS_UNLOCKED_GIRL 
	} 
	{ 
		desc_id = %"GR Deck 9" 
		frontend_desc = #"Rodriguez - Blanket" 
		common_deck_graphic_params 
		with = "textures/boards/GR_deck09" 
		unlock_flag = BOARDS_UNLOCKED_GIRL 
	} 
	{ 
		desc_id = %"GR Deck 10" 
		frontend_desc = #"Rodriguez - Wooden" 
		common_deck_graphic_params 
		with = "textures/boards/GR_deck10" 
		unlock_flag = BOARDS_UNLOCKED_GIRL 
	} 
	{ 
		desc_id = %"ZR Deck 1" 
		frontend_desc = #"Zero - Black Bold" 
		common_deck_graphic_params 
		with = "textures/boards/ZR_deck01" 
		unlock_flag = BOARDS_UNLOCKED_ZERO 
	} 
	{ 
		desc_id = %"ZR Deck 2" 
		frontend_desc = #"Zero - Bloody Skull" 
		common_deck_graphic_params 
		with = "textures/boards/ZR_deck02" 
		unlock_flag = BOARDS_UNLOCKED_ZERO 
	} 
	{ 
		desc_id = %"ZR Deck 3" 
		frontend_desc = #"Zero - Small Skull" 
		common_deck_graphic_params 
		with = "textures/boards/ZR_deck03" 
		unlock_flag = BOARDS_UNLOCKED_ZERO 
	} 
	{ 
		desc_id = %"ZR Deck 4" 
		frontend_desc = #"Zero - Punk" 
		common_deck_graphic_params 
		with = "textures/boards/ZR_deck04" 
		unlock_flag = BOARDS_UNLOCKED_ZERO 
	} 
	{ 
		desc_id = %"ZR Deck 5" 
		frontend_desc = #"Zero - Blood" 
		common_deck_graphic_params 
		with = "textures/boards/ZR_deck05" 
		unlock_flag = BOARDS_UNLOCKED_ZERO 
	} 
	{ 
		desc_id = %"ZR Deck 6" 
		frontend_desc = #"Thomas - Zero or Die" 
		common_deck_graphic_params 
		with = "textures/boards/ZR_deck06" 
		unlock_flag = BOARDS_UNLOCKED_ZERO 
	} 
	{ 
		desc_id = %"ZR Deck 7" 
		frontend_desc = #"Thomas - Icon" 
		common_deck_graphic_params 
		with = "textures/boards/ZR_deck07" 
		unlock_flag = BOARDS_UNLOCKED_ZERO 
	} 
	{ 
		desc_id = %"ZR Deck 8" 
		frontend_desc = #"Thomas - Eagle" 
		common_deck_graphic_params 
		with = "textures/boards/ZR_deck08" 
		unlock_flag = BOARDS_UNLOCKED_ZERO 
	} 
	{ 
		desc_id = %"ZR Deck 9" 
		frontend_desc = #"Thomas - Animal" 
		common_deck_graphic_params 
		with = "textures/boards/ZR_deck09" 
		unlock_flag = BOARDS_UNLOCKED_ZERO 
	} 
	{ 
		desc_id = %"ZR Deck 10" 
		frontend_desc = #"Thomas - Platinum" 
		common_deck_graphic_params 
		with = "textures/boards/ZR_deck10" 
		unlock_flag = BOARDS_UNLOCKED_ZERO 
	} 
] 
cad_graphic = [ 
	{ 
		is_a_deck = is_a_deck 
		cad_graphic 
		desc_id = %"CAS 1" 
		frontend_desc = #"Mockba Red Star" 
		common_deck_graphic_params 
		with = "textures/boards/casB01" 
		skater = custom 
		flag = BOARDS_UNLOCKED_CAD 
	} 
	{ 
		desc_id = %"CAS 2" 
		frontend_desc = #"Rising Sun" 
		common_deck_graphic_params 
		with = "textures/boards/casB02" 
		skater = custom 
		RotateDeckLeft 
		flag = BOARDS_UNLOCKED_CAD 
	} 
	{ 
		desc_id = %"CAS 3" 
		frontend_desc = #"Digital Contour" 
		common_deck_graphic_params 
		with = "textures/boards/casB03" 
		skater = custom 
		flag = BOARDS_UNLOCKED_CAD 
	} 
	{ 
		desc_id = %"CAS 4" 
		frontend_desc = #"Feel The Beat" 
		common_deck_graphic_params 
		with = "textures/boards/casB04" 
		skater = custom 
		flag = BOARDS_UNLOCKED_CAD 
	} 
	{ 
		desc_id = %"CAS 5" 
		frontend_desc = #"Fire \'n Brimstone" 
		common_deck_graphic_params 
		with = "textures/boards/casB05" 
		skater = custom 
		flag = BOARDS_UNLOCKED_CAD 
	} 
	{ 
		desc_id = %"CAS 6" 
		frontend_desc = #"Infrared" 
		common_deck_graphic_params 
		with = "textures/boards/casB06" 
		skater = custom 
		flag = BOARDS_UNLOCKED_CAD 
	} 
	{ 
		desc_id = %"CAS 7" 
		frontend_desc = #"Alien Hand" 
		common_deck_graphic_params 
		with = "textures/boards/casB07" 
		skater = custom 
		flag = BOARDS_UNLOCKED_CAD 
	} 
	{ 
		desc_id = %"CAS 8" 
		frontend_desc = #"S I K" 
		common_deck_graphic_params 
		with = "textures/boards/casB08" 
		skater = custom 
		RotateDeckLeft 
		flag = BOARDS_UNLOCKED_CAD 
	} 
	{ 
		desc_id = %"CAS 9" 
		frontend_desc = #"Fire Ball" 
		common_deck_graphic_params 
		with = "textures/boards/casB09" 
		skater = custom 
		flag = BOARDS_UNLOCKED_CAD 
	} 
	{ 
		desc_id = %"CAS 10" 
		frontend_desc = #"Graffiti Heaven" 
		common_deck_graphic_params 
		with = "textures/boards/casB10" 
		skater = custom 
		flag = BOARDS_UNLOCKED_CAD 
	} 
	{ 
		desc_id = %"CAS 11" 
		frontend_desc = #"VROOOOOM" 
		common_deck_graphic_params 
		with = "textures/boards/casB23" 
		skater = custom 
		flag = BOARDS_UNLOCKED_CAD 
	} 
	{ 
		desc_id = %"CAS 12" 
		frontend_desc = #"T.H.U.G. Starz" 
		common_deck_graphic_params 
		with = "textures/boards/casB24" 
		skater = custom 
		flag = BOARDS_UNLOCKED_CAD 
	} 
	{ 
		desc_id = %"CAS 13" 
		frontend_desc = #"Unghh" 
		common_deck_graphic_params 
		with = "textures/boards/casB25" 
		skater = custom 
		flag = BOARDS_UNLOCKED_CAD 
	} 
	{ 
		desc_id = %"CAS 14" 
		frontend_desc = #"Tony Graf" 
		common_deck_graphic_params 
		with = "textures/boards/casB26" 
		skater = custom 
		flag = BOARDS_UNLOCKED_CAD 
	} 
	{ 
		desc_id = %"CAS 15" 
		frontend_desc = #"Late Night Thug" 
		common_deck_graphic_params 
		with = "textures/boards/casB27" 
		skater = custom 
		flag = BOARDS_UNLOCKED_CAD 
	} 
	{ 
		desc_id = %"CAS 16" 
		frontend_desc = #"Death Skull" 
		common_deck_graphic_params 
		with = "textures/boards/casB11" 
		skater = custom 
		flag = BOARDS_UNLOCKED_CAD 
	} 
	{ 
		desc_id = %"CAS 17" 
		frontend_desc = #"Tribal" 
		common_deck_graphic_params 
		with = "textures/boards/casB36" 
		skater = custom 
		flag = BOARDS_UNLOCKED_CAD 
	} 
	{ 
		desc_id = %"CAS 18" 
		frontend_desc = #"All Eyes On You" 
		common_deck_graphic_params 
		with = "textures/boards/casB38" 
		skater = custom 
		flag = BOARDS_UNLOCKED_CAD 
	} 
	{ 
		desc_id = %"CAS 19" 
		frontend_desc = #"C.A.M.O." 
		common_deck_graphic_params 
		with = "textures/boards/casB12" 
		skater = custom 
		flag = BOARDS_UNLOCKED_CAD 
	} 
	{ 
		desc_id = %"CAS 20" 
		frontend_desc = #"Cracked" 
		common_deck_graphic_params 
		with = "textures/boards/casB13" 
		skater = custom 
		flag = BOARDS_UNLOCKED_CAD 
	} 
	{ 
		desc_id = %"CAS 21" 
		frontend_desc = #"Molten Hell" 
		common_deck_graphic_params 
		with = "textures/boards/casB14" 
		skater = custom 
		flag = BOARDS_UNLOCKED_CAD 
	} 
	{ 
		desc_id = %"CAS 22" 
		frontend_desc = #"Sharp \'n Pointy" 
		common_deck_graphic_params 
		with = "textures/boards/casB15" 
		skater = custom 
		flag = BOARDS_UNLOCKED_CAD 
	} 
	{ 
		desc_id = %"CAS 23" 
		frontend_desc = #"Bricks" 
		common_deck_graphic_params 
		with = "textures/boards/casB16" 
		skater = custom 
		flag = BOARDS_UNLOCKED_CAD 
	} 
	{ 
		desc_id = %"CAS 24" 
		frontend_desc = #"Back \'n Black" 
		common_deck_graphic_params 
		with = "textures/boards/casB17" 
		skater = custom 
		flag = BOARDS_UNLOCKED_CAD 
	} 
	{ 
		desc_id = %"CAS 25" 
		frontend_desc = #"Sky Is The Limit" 
		common_deck_graphic_params 
		with = "textures/boards/casB18" 
		skater = custom 
		flag = BOARDS_UNLOCKED_CAD 
	} 
	{ 
		desc_id = %"CAS 26" 
		frontend_desc = #"White Wall" 
		common_deck_graphic_params 
		with = "textures/boards/casB19" 
		skater = custom 
		flag = BOARDS_UNLOCKED_CAD 
	} 
	{ 
		desc_id = %"CAS 27" 
		frontend_desc = #"Sportin\' Wood" 
		common_deck_graphic_params 
		with = "textures/boards/casB20" 
		skater = custom 
		flag = BOARDS_UNLOCKED_CAD 
	} 
	{ 
		desc_id = %"CAS 28" 
		frontend_desc = #"Blank Face 1" 
		common_deck_graphic_params 
		with = "textures/boards/casB21" 
		skater = custom 
		flag = BOARDS_UNLOCKED_CAD 
	} 
	{ 
		desc_id = %"CAS 29" 
		frontend_desc = #"Blank Face 2" 
		common_deck_graphic_params 
		with = "textures/boards/casB22" 
		skater = custom 
		flag = BOARDS_UNLOCKED_CAD 
	} 
	{ 
		desc_id = %"CAS 30" 
		frontend_desc = #"Smile!" 
		common_deck_graphic_params 
		with = "textures/boards/casB28" 
		skater = custom 
		flag = BOARDS_UNLOCKED_CAD 
	} 
	{ 
		desc_id = %"CAS 31" 
		frontend_desc = #"Last Call" 
		common_deck_graphic_params 
		with = "textures/boards/casB29" 
		skater = custom 
		flag = BOARDS_UNLOCKED_CAD 
	} 
	{ 
		desc_id = %"CAS 32" 
		frontend_desc = #"Green Gal" 
		common_deck_graphic_params 
		with = "textures/boards/casB30" 
		skater = custom 
		flag = BOARDS_UNLOCKED_CAD 
	} 
	{ 
		desc_id = %"CAS 33" 
		frontend_desc = #"Juggernaut" 
		common_deck_graphic_params 
		with = "textures/boards/casB31" 
		skater = custom 
		flag = BOARDS_UNLOCKED_CAD 
	} 
	{ 
		desc_id = %"CAS 34" 
		frontend_desc = #"Blank Stare" 
		common_deck_graphic_params 
		with = "textures/boards/casB32" 
		skater = custom 
		flag = BOARDS_UNLOCKED_CAD 
	} 
	{ 
		desc_id = %"CAS 35" 
		frontend_desc = #"American Hottie" 
		common_deck_graphic_params 
		with = "textures/boards/casB33" 
		skater = custom 
		flag = BOARDS_UNLOCKED_CAD 
	} 
	{ 
		desc_id = %"CAS 36" 
		frontend_desc = #"Too Late" 
		common_deck_graphic_params 
		with = "textures/boards/casB34" 
		skater = custom 
		flag = BOARDS_UNLOCKED_CAD 
	} 
	{ 
		desc_id = %"CAS 37" 
		frontend_desc = #"El Diablo" 
		common_deck_graphic_params 
		with = "textures/boards/casB35" 
		skater = custom 
		flag = BOARDS_UNLOCKED_CAD 
	} 
] 

