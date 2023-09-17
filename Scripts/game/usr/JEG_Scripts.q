
SCRIPT TestPedScript 
	setTags obj_idle_state = "BHP" 
	BEGIN 
		getTags 
		RANDOM(1, 1, 1, 1) 
			RANDOMCASE 
			SWITCH <obj_idle_state> 
				CASE "RHP" 
					Obj_CycleAnim anim = RHP_2_BHP 
				CASE "BAX" 
					Obj_CycleAnim anim = BAX_2_BHP 
				CASE "LGH" 
					Obj_CycleAnim anim = LGH_2_BHP speed = 0.50000000000 
			ENDSWITCH 
			RANDOM(1, 1, 1, 1, 1, 1) 
				RANDOMCASE Obj_CycleAnim anim = BHP_Breathe 
				RANDOMCASE Obj_CycleAnim anim = BHP_Breathe NumCycles = RANDOM(1, 1) RANDOMCASE 1 RANDOMCASE 2 RANDOMEND 
				RANDOMCASE Obj_CycleAnim anim = BHP_Scratch 
				RANDOMCASE Obj_CycleAnim anim = BHP_Point 
				RANDOMCASE Obj_CycleAnim anim = BHP_LookBack 
				RANDOMCASE 
			RANDOMEND 
			setTags obj_idle_state = "BHP" 
			RANDOMCASE 
			SWITCH <obj_idle_state> 
				CASE "BHP" 
					RANDOM(1, 1) 
						RANDOMCASE Obj_CycleAnim anim = BHP_2_RHP 
						RANDOMCASE Obj_CycleAnim anim = BHP_2_RHP_Chin 
					RANDOMEND 
				CASE "BAX" 
					Obj_CycleAnim anim = RHP_2_BAX Backwards 
				CASE "LGH" 
					Obj_CycleAnim anim = RHP_2_LGH Backwards speed = 0.50000000000 
			ENDSWITCH 
			RANDOM(1, 1, 1, 1) 
				RANDOMCASE Obj_CycleAnim anim = RHP_Breathe NumCycles = RANDOM(1, 1) RANDOMCASE 1 RANDOMCASE 2 RANDOMEND 
				RANDOMCASE OBJ_Playstream KenHelp1 
				Obj_CycleAnim anim = RHP_TalkTest 
				RANDOMCASE Obj_CycleAnim anim = RHP_FootTap NumCycles = RANDOM(1, 1, 1) RANDOMCASE 1 RANDOMCASE 2 RANDOMCASE 3 RANDOMEND 
				RANDOMCASE Obj_CycleAnim anim = RHP_Handsmack 
			RANDOMEND 
			setTags obj_idle_state = "RHP" 
			RANDOMCASE 
			SWITCH <obj_idle_state> 
				CASE "BHP" 
					Obj_CycleAnim anim = BAX_2_BHP from = end to = start 
				CASE "RHP" 
					Obj_CycleAnim anim = RHP_2_BAX 
				CASE "LGH" 
					Obj_CycleAnim anim = BAX_2_LGH Backwards speed = 0.69999998808 
			ENDSWITCH 
			RANDOM(1, 1) 
				RANDOMCASE Obj_CycleAnim anim = BAX_Breathe NumCycles = RANDOM(1, 1) RANDOMCASE 1 RANDOMCASE 2 RANDOMEND 
				RANDOMCASE Obj_CycleAnim anim = BAX_Nod NumCycles = RANDOM(1, 1) RANDOMCASE 1 RANDOMCASE 2 RANDOMEND 
			RANDOMEND 
			setTags obj_idle_state = "BAX" 
			RANDOMCASE 
			SWITCH <obj_idle_state> 
				CASE "BHP" 
					Obj_CycleAnim anim = LGH_2_BHP Backwards 
				CASE "RHP" 
					Obj_CycleAnim anim = RHP_2_LGH 
				CASE "BAX" 
					Obj_CycleAnim anim = BAX_2_LGH 
			ENDSWITCH 
			RANDOM(1, 1, 1, 1, 1, 1) 
				RANDOMCASE Obj_CycleAnim anim = LGH_GutBuster NumCycles = RANDOM(1, 1) RANDOMCASE 1 RANDOMCASE 2 RANDOMEND 
				RANDOMCASE Obj_CycleAnim anim = LGH_KneeSlapper speed = 0.75000000000 
				Obj_CycleAnim anim = LGH_GutBuster 
				RANDOMCASE Obj_CycleAnim anim = LGH_Pointing 
				Obj_CycleAnim anim = LGH_GutBuster 
				RANDOMCASE Obj_CycleAnim anim = LGH_Giggle 
				Obj_CycleAnim anim = LGH_GutBuster 
				RANDOMCASE Obj_CycleAnim anim = LGH_Wave 
				Obj_CycleAnim anim = LGH_GutBuster 
				RANDOMCASE Obj_CycleAnim anim = LGH_Wave 
				Obj_CycleAnim anim = LGH_GutBuster 
			RANDOMEND 
			setTags obj_idle_state = "LGH" 
		RANDOMEND 
	REPEAT 
ENDSCRIPT

SCRIPT PED_Sitting 
	setTags obj_idle_state = "STND" 
	BEGIN 
		getTags 
		RANDOM(4, 4, 4, 1) 
			RANDOMCASE 
			SWITCH <obj_idle_state> 
				CASE "STND" 
					Obj_CycleAnim anim = PED_STND2SIT 
				CASE "SITB" 
					Obj_CycleAnim anim = PED_SIT2SITB Backwards 
				CASE "SITBL" 
					Obj_CycleAnim anim = PED_SITBL2SIT 
			ENDSWITCH 
			RANDOM(1, 1, 1, 1) 
				RANDOMCASE Obj_CycleAnim anim = PED_SIT_Idle NumCycles = RANDOM(1, 1, 1, 1) RANDOMCASE 2 RANDOMCASE 3 RANDOMCASE 4 RANDOMCASE 5 RANDOMEND 
				RANDOMCASE Obj_CycleAnim anim = PED_SIT_LookL 
				RANDOMCASE Obj_CycleAnim anim = PED_SIT_LookR 
				RANDOMCASE Obj_CycleAnim anim = PED_SIT_Tap NumCycles = RANDOM(1, 1, 1) RANDOMCASE 1 RANDOMCASE 2 RANDOMCASE 3 RANDOMEND 
			RANDOMEND 
			setTags obj_idle_state = "SIT" 
			RANDOMCASE 
			SWITCH <obj_idle_state> 
				CASE "STND" 
					Obj_CycleAnim anim = PED_STND2SIT 
					Obj_CycleAnim anim = PED_SIT2SITB 
				CASE "SIT" 
					Obj_CycleAnim anim = PED_SIT2SITB 
				CASE "SITBL" 
					Obj_CycleAnim anim = PED_SITB2SITBL Backwards 
			ENDSWITCH 
			RANDOM(1, 1, 1) 
				RANDOMCASE Obj_CycleAnim anim = PED_SITB_Idle NumCycles = RANDOM(1, 1, 1, 1) RANDOMCASE 2 RANDOMCASE 3 RANDOMCASE 4 RANDOMCASE 5 RANDOMEND 
				RANDOMCASE Obj_CycleAnim anim = PED_SITB_LookL 
				RANDOMCASE Obj_CycleAnim anim = PED_SITB_LookR 
			RANDOMEND 
			setTags obj_idle_state = "SITB" 
			RANDOMCASE 
			SWITCH <obj_idle_state> 
				CASE "STND" 
					Obj_CycleAnim anim = PED_STND2SIT 
					Obj_CycleAnim anim = PED_SITBL2SIT Backwards 
				CASE "SIT" 
					Obj_CycleAnim anim = PED_SITBL2SIT Backwards 
				CASE "SITB" 
					Obj_CycleAnim anim = PED_SITB2SITBL 
			ENDSWITCH 
			RANDOM(1, 1, 1, 1) 
				RANDOMCASE Obj_CycleAnim anim = PED_SITBL_Idle NumCycles = RANDOM(1, 1, 1, 1) RANDOMCASE 2 RANDOMCASE 3 RANDOMCASE 4 RANDOMCASE 5 RANDOMEND 
				RANDOMCASE Obj_CycleAnim anim = PED_SITBL_LookL 
				RANDOMCASE Obj_CycleAnim anim = PED_SITBL_Tap 
				RANDOMCASE Obj_CycleAnim anim = PED_SITBL_Shake 
			RANDOMEND 
			setTags obj_idle_state = "SITBL" 
			RANDOMCASE 
			SWITCH <obj_idle_state> 
				CASE "SIT" 
					Obj_CycleAnim anim = PED_SIT2STND 
				CASE "SITB" 
					Obj_CycleAnim anim = PED_SIT2SITB Backwards 
					Obj_CycleAnim anim = PED_SIT2STND 
				CASE "SITBL" 
					Obj_CycleAnim anim = PED_SITBL2SIT 
					Obj_CycleAnim anim = PED_SIT2STND 
			ENDSWITCH 
			setTags obj_idle_state = "STND" 
		RANDOMEND 
	REPEAT 
ENDSCRIPT


