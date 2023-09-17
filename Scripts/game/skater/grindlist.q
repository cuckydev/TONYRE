
SpecialGrindTricks = 
[ 
	{ Trigger = { TripleInOrder , Up , Right , Triangle , 400 } Duration = 400 TrickSlot = SpGrind_U_R_Triangle } 
	{ Trigger = { TripleInOrder , Up , Down , Triangle , 400 } Duration = 400 TrickSlot = SpGrind_U_D_Triangle } 
	{ Trigger = { TripleInOrder , Up , Left , Triangle , 400 } Duration = 400 TrickSlot = SpGrind_U_L_Triangle } 
	{ Trigger = { TripleInOrder , Right , Up , Triangle , 400 } Duration = 400 TrickSlot = SpGrind_R_U_Triangle } 
	{ Trigger = { TripleInOrder , Right , Down , Triangle , 400 } Duration = 400 TrickSlot = SpGrind_R_D_Triangle } 
	{ Trigger = { TripleInOrder , Right , Left , Triangle , 400 } Duration = 400 TrickSlot = SpGrind_R_L_Triangle } 
	{ Trigger = { TripleInOrder , Down , Up , Triangle , 400 } Duration = 400 TrickSlot = SpGrind_D_U_Triangle } 
	{ Trigger = { TripleInOrder , Down , Right , Triangle , 400 } Duration = 400 TrickSlot = SpGrind_D_R_Triangle } 
	{ Trigger = { TripleInOrder , Down , Left , Triangle , 400 } Duration = 400 TrickSlot = SpGrind_D_L_Triangle } 
	{ Trigger = { TripleInOrder , Left , Up , Triangle , 400 } Duration = 400 TrickSlot = SpGrind_L_U_Triangle } 
	{ Trigger = { TripleInOrder , Left , Right , Triangle , 400 } Duration = 400 TrickSlot = SpGrind_L_R_Triangle } 
	{ Trigger = { TripleInOrder , Left , Down , Triangle , 400 } Duration = 400 TrickSlot = SpGrind_L_D_Triangle } 
] 
Trick_ElbowSmash = { params = { Name = #"Elbow Smash" IsSpecial } Template = Template2 Prefix = "Trick_ElbowSmash2" specialanims = [ ElbowSmash_Init , ElbowSmash_Idle , Elbowsmash_out ] } 
Trick_Shortbus = { params = { Name = #"Stupid Grind" IsSpecial } Template = Template3 Prefix = "Trick_Shortbus2" specialanims = [ Shortbus_Init , Shortbus_idle , Shortbus_out ] } 
Trick_RodneyGrind = { params = { Name = #"Rodney Primo" IsSpecial } Template = Template3 Prefix = "Trick_RodneyGrind2" specialanims = [ RodneyGrind_Init , RodneyGrind_range , RodneyGrind_out ] } 
Trick_GrindNBarf = { params = { Name = #"Grind N Barf" IsSpecial } Template = Template3 Prefix = "Trick_GrindNBarf2" specialanims = [ GrindNBarf_Init , GrindNBarf_range , GrindNBarf_out ] } 
Trick_FiftyFiftySwitcheroo = { params = { Name = #"5050 Switcheroo" IsSpecial } Template = Template3 Prefix = "Trick_FiftyFiftySwitcheroo2" specialanims = [ FiftyFiftySwitcheroo_Init , FiftyFiftySwitcheroo_idle ] } 
Trick_RowleyDarkSlideHandStand = { params = { Name = #"Darkslide Handstand" IsSpecial } Template = Template3 Prefix = "Trick_RowleyDarkSlideHandStand2" specialanims = [ RowleyDarkSlideHandStand_Init , RowleyDarkSlideHandStand_range , RowleyDarkSlideHandStand_out ] } 
Trick_PrimoHandStand = { params = { Name = #"Primo Handstand" IsSpecial } Template = Template3 Prefix = "Trick_PrimoHandStand2" specialanims = [ PrimoHandStand_Init , PrimoHandStand_range , PrimoHandStand_out ] } 
Trick_OneFootDarkSlide = { params = { Name = #"One Foot Darkslide" IsSpecial } Template = Template2 Prefix = "Trick_OneFootDarkslide2" specialanims = [ OneFootDarkSlide_Init , OneFootDarkSlide_range , OneFootDarkSlide_out ] } 
Trick_YeaRightSlide = { params = { Name = #"Yeah Right Slide" IsSpecial } Template = Template2 Prefix = "Trick_YeaRightSlide2" specialanims = [ YeaRightSlide_Init , YeaRightSlide_range , YeaRightSlide_out ] } 
Trick_HCNHDF = { params = { Name = #"Crooks DarkSlide" IsSpecial } Template = Template2 Prefix = "Trick_HCNHDF2" specialanims = [ HCNHDF_Init , HCNHDF_range , HCNHDF_out ] } 
Trick_FSNollie360FlipCrook = { params = { Name = #"Nollie 360Flip Crook" IsSpecial } Template = Template2 Prefix = "Trick_FSNollie360FlipCrook2" specialanims = [ FSNollie360FlipCrook_Init , FSNollie360FlipCrook_range , FSNollie360FlipCrook_out ] } 
Trick_MoonwalkGrind = { params = { Name = #"Moonwalk Five-O" IsSpecial } Template = Template3 Prefix = "Trick_MoonwalkGrind2" specialanims = [ Moonwalkgrind_Init , MoonwalkGrind_idle , MoonwalkGrind_out ] } 
Trick_Thinkaboutitgrind = { params = { Name = #"Levitate Grind" IsSpecial } Template = Template3 Prefix = "Trick_Thinkaboutitgrind2" specialanims = [ Thinkaboutitgrind_Init , Thinkaboutitgrind_idle , Thinkaboutitgrind_out ] } 
Trick_360ShovitNoseGrind = { params = { Name = #"360 Shovit NoseGrind" IsSpecial } Template = Template2 Prefix = "Trick_360ShovitNoseGrind2" specialanims = [ _360ShovitNoseGrind_Init , _360ShovitNoseGrind_range _360ShovitNoseGrind_out ] } 
Trick_Flames = { params = { Name = #"Fire Fire Fire" Skater = Gene IsSpecial } Template = Template3 Prefix = "Trick_Flames2" specialanims = [ Flames_Init , Flames_Idle Flames_out ] } 
Trick_BlastGrind = { params = { Name = #"Fire Blaster" Skater = Iron_Man IsSpecial } Template = Template2 Prefix = "Trick_BlastGrind2" specialanims = [ BlastGrind_Init , BlastGrind_Idle Idle BlastGrind_out ] } 
Trick_3DScaryGrind = { params = { Name = #"Scary Grind" Skater = Creature IsSpecial } Template = Template2 Prefix = "Trick_3DScaryGrind2" specialanims = [ _3DScaryGrind_Init , _3DScaryGrind_Range _3DScaryGrind_out ] } 
Trick_CrookedSkull = { params = { Name = #"Skull Grind" IsSpecial } Template = Template2 Prefix = "Trick_CrookedSkull2" specialanims = [ CrookedSkull_Init , CrookedSkull_Idle CrookedSkull_out ] } 
Trick_OneFootSmith = { params = { Name = #"One Foot Smith" IsSpecial } Template = Template1 Prefix = "Trick_OneFootSmith" specialanims = [ SmithFS_Init , SmithFS_Range , Smith_Init , Smith_Range ] } 
Trick_FlipKickDad = { params = { Name = #"Flip Kick Dad" IsSpecial } Template = Template2 Prefix = "Trick_FlipKickDad2" specialanims = [ FlipKickDad_Init , FlipKickDad ] } 
Trick_50FingerFlip = { params = { Name = #"5-0 Fingerflip Nosegrind" IsSpecial } Template = Template2 Prefix = "Trick_50Fingerflip2" specialanims = [ TailGrindFingerFlip ] } 
Trick_SprayPaintGrind = { params = { Name = #"Ghetto Tag Grind" IsSpecial } Template = Template2 Prefix = "Trick_SprayPaintGrind2" specialanims = [ SprayPaint_Init , SprayPaint_Range , SprayPaint_Out ] } 
Trick_DaffyBrokenGrind = { params = { Name = #"Daffy Grind" IsSpecial } Template = Template2 Prefix = "Trick_DaffyBrokenGrind2" specialanims = [ DaffyBroken_Init , DaffyBroken_Range ] } 
Trick_GuitarSlide = { params = { Name = #"Faction Guitar Slide" IsSpecial } Template = Template2 Prefix = "Trick_Guitarslide2" specialanims = [ Guitar_Init , Guitar_Idle ] } 
Trick_AmericanHeroGrind = { params = { Name = #"American Tribute" IsSpecial } Template = Template2 Prefix = "Trick_AmericanHero2" specialanims = [ AmericanHeroGrind_Init , AmericanHeroGrind_Idle , AmericanHeroGrind_out ] } 
Trick_CrookedBigSpinFlip = { params = { Name = #"Crook BigSpinFlip Crook" IsSpecial } Template = Template1 Prefix = "Trick_CrookedBigSpin" specialanims = [ CrookBigSpinFlipCrook , FSCrooked_range , Init_FSCrooked ] } 
Trick_DoubleBluntSlide = { params = { Name = #"Double Blunt Slide" } Template = Template2 Prefix = "Trick_DoubleBluntSlide2" specialanims = [ DoubleBlunt_Init , DoubleBlunt_Idle ] } 
Trick_Fandangle = { params = { Name = #"Fandangle" IsSpecial } Template = Template1 Prefix = "Trick_fandangle" specialanims = [ fandangle_Init , fandangle_Range , Fandangle_Out ] } 
Trick_Coffin = { params = { Name = #"Coffin" IsSpecial } Template = Template1 Prefix = "Trick_Coffin" specialanims = [ CoffinGrind_Init , CoffinGrind_Range , CoffinGrind_Out ] } 
Trick_RowleyDarkSlide = { params = { Name = #"Rowley Darkslide" IsSpecial } Template = Template1 Prefix = "Trick_RowleyDarkSlide" specialanims = [ RowleyDarkSlide_InitRowleyDarkSlide_RangeRowleyDarkSlide_out ] } 
Trick_BigHitter = { params = { Name = #"Big Hitter II" IsSpecial } Template = Template1 Prefix = "Trick_BigHitter" specialanims = [ BigHitter_Init , BigHitter_Range , BigHitter_out ] } 
Trick_TailblockSlide = { params = { Name = #"Tailblock Slide" IsSpecial } Template = Template1 Prefix = "Trick_TailblockSlide" specialanims = [ TailblockSlide_Init , TailblockSlide_Range , TailblockSlide_Init ] } 
GrindTricks = 
[ 
	{ Trigger = { TripleInOrder , a = Up , b = Up , Triangle , 400 } Duration = 1000 Template = Template1 Prefix = "Trick_Nosebluntslide" } 
	{ Trigger = { TripleInOrder , a = Down , b = Down , Triangle , 400 } Duration = 1000 Template = Template1 Prefix = "Trick_Bluntslide" } 
] 
Template1 = 
[ 
	"_BS" 
	"_FS" 
	"_BS" 
	"_FS" 
	"_BS_180" 
	"_FS_180" 
	"_BS_180" 
	"_FS_180" 
	"_FS" 
	"_BS" 
	"_FS" 
	"_BS" 
	"_FS_180" 
	"_BS_180" 
	"_FS_180" 
	"_BS_180" 
] 
Template2 = 
[ 
	"" 
	"" 
	"" 
	"" 
	"_180" 
	"_180" 
	"_180" 
	"_180" 
	"" 
	"" 
	"" 
	"" 
	"_180" 
	"_180" 
	"_180" 
	"_180" 
] 
Template3 = 
[ 
	"" 
	"" 
	"" 
	"" 
	"" 
	"" 
	"" 
	"" 
	"" 
	"" 
	"" 
	"" 
	"" 
	"" 
	"" 
	"" 
] 
SCRIPT Bingo 
	Playsound GoalDone 
	Create_panel_message text = "Bingo!" 
	Goto Airborne 
ENDSCRIPT

GrindTrickList = 
[ 
	[ 
		Trick_BoardSlide_BS 
		Trick_LipSlide_FS 
		Trick_5050_BS 
		Trick_5050_FS 
		Trick_LipSlide_BS 
		Trick_BoardSlide_FS 
		Trick_5050_FS_180 
		Trick_5050_BS_180 
		Trick_LipSlide_FS 
		Trick_BoardSlide_BS 
		Trick_5050_FS 
		Trick_5050_BS 
		Trick_BoardSlide_FS 
		Trick_LipSlide_BS 
		Trick_5050_FS_180 
		Trick_5050_BS_180 
	] 
	[ 
		Trick_NoseGrind_BS 
		Trick_NoseGrind_FS 
		Trick_NoseGrind_BS 
		Trick_NoseGrind_FS 
		Trick_NoseGrind_BS_180 
		Trick_NoseGrind_FS_180 
		Trick_NoseGrind_BS_180 
		Trick_NoseGrind_FS_180 
		Trick_NoseGrind_FS 
		Trick_NoseGrind_BS 
		Trick_NoseGrind_FS 
		Trick_NoseGrind_BS 
		Trick_NoseGrind_FS_180 
		Trick_NoseGrind_BS_180 
		Trick_NoseGrind_FS_180 
		Trick_NoseGrind_BS_180 
	] 
	[ 
		Trick_5_0_BS 
		Trick_5_0_FS 
		Trick_5_0_BS 
		Trick_5_0_FS 
		Trick_5_0_BS_180 
		Trick_5_0_FS_180 
		Trick_5_0_BS_180 
		Trick_5_0_FS_180 
		Trick_5_0_FS 
		Trick_5_0_BS 
		Trick_5_0_FS 
		Trick_5_0_BS 
		Trick_5_0_FS_180 
		Trick_5_0_BS_180 
		Trick_5_0_FS_180 
		Trick_5_0_BS_180 
	] 
	[ 
		Trick_BoardSlide_BS 
		Trick_LipSlide_FS 
		Trick_Tailslide_BS 
		Trick_Noseslide_FS 
		Trick_LipSlide_BS 
		Trick_BoardSlide_FS 
		Trick_Tailslide_BS_180 
		Trick_Noseslide_FS_180 
		Trick_LipSlide_FS 
		Trick_BoardSlide_BS 
		Trick_Tailslide_FS 
		Trick_Noseslide_BS 
		Trick_BoardSlide_FS 
		Trick_LipSlide_BS 
		Trick_TailSlide_FS_180 
		Trick_Noseslide_BS_180 
	] 
	[ 
		Trick_BoardSlide_BS 
		Trick_LipSlide_FS 
		Trick_Noseslide_BS 
		Trick_Tailslide_FS 
		Trick_LipSlide_BS 
		Trick_BoardSlide_FS 
		Trick_Noseslide_BS_180 
		Trick_TailSlide_FS_180 
		Trick_LipSlide_FS 
		Trick_BoardSlide_BS 
		Trick_Noseslide_FS 
		Trick_Tailslide_BS 
		Trick_BoardSlide_FS 
		Trick_LipSlide_BS 
		Trick_Noseslide_FS_180 
		Trick_Tailslide_BS_180 
	] 
	[ 
		Trick_NGCrook_BS 
		Trick_Crooked_FS 
		Trick_NGCrook_BS 
		Trick_Crooked_FS 
		Trick_NGCrook_BS_180 
		Trick_Crooked_FS_rot 
		Trick_NGCrook_BS_180 
		Trick_Crooked_FS_180 
		Trick_NGCrook_FS 
		Trick_Crooked_BS 
		Trick_NGCrook_FS 
		Trick_Crooked_BS 
		Trick_NGCrook_FS_rot 
		Trick_Crooked_BS_180 
		Trick_NGCrook_FS_180 
		Trick_Crooked_BS_180 
	] 
	[ 
		Trick_Crooked_BS 
		Trick_NGCrook_FS 
		Trick_Crooked_BS 
		Trick_NGCrook_FS 
		Trick_Crooked_BS_180 
		Trick_NGCrook_FS_rot 
		Trick_Crooked_BS_180 
		Trick_NGCrook_FS_180 
		Trick_Crooked_FS 
		Trick_NGCrook_BS 
		Trick_Crooked_FS 
		Trick_NGCrook_BS 
		Trick_Crooked_FS_rot 
		Trick_NGCrook_BS_180 
		Trick_Crooked_FS_180 
		Trick_NGCrook_BS_180 
	] 
	[ 
		Trick_Smith_BS 
		Trick_Feeble_FS 
		Trick_Smith_BS 
		Trick_Feeble_FS 
		Trick_Smith_BS_180 
		Trick_Feeble_FS_rot 
		Trick_Smith_BS_180 
		Trick_Feeble_FS_180 
		Trick_Smith_FS 
		Trick_Feeble_BS 
		Trick_Smith_FS 
		Trick_Feeble_BS 
		Trick_Smith_FS_rot 
		Trick_Feeble_BS_180 
		Trick_Smith_FS_180 
		Trick_Feeble_BS_180 
	] 
	[ 
		Trick_Feeble_BS 
		Trick_Smith_FS 
		Trick_Feeble_BS 
		Trick_Smith_FS 
		Trick_Feeble_BS_180 
		Trick_Smith_FS_rot 
		Trick_Feeble_BS_180 
		Trick_Smith_FS_180 
		Trick_Feeble_FS 
		Trick_Smith_BS 
		Trick_Feeble_FS 
		Trick_Smith_BS 
		Trick_Feeble_FS_rot 
		Trick_Smith_BS_180 
		Trick_Feeble_FS_180 
		Trick_Smith_BS_180 
	] 
] 

