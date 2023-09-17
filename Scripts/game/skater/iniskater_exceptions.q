
SCRIPT cas_handle_disqualifications 
	cas_disq_remove_logo <...> 
	cas_disq_remove_hat <...> 
	cas_disq_remove_helmet <...> 
	cas_disq_remove_bulky_shirt <...> 
	cas_disq_remove_backpack <...> 
	cas_disq_remove_footwear <...> 
	cas_disq_handle_weird_items <...> 
	cas_disq_add_sleeves <...> 
ENDSCRIPT

SCRIPT cas_disq_add_sleeves 
	<just_changed_torso> = 0 
	IF ( ChecksumEquals a = <part> b = skater_m_torso ) 
		<just_changed_torso> = 1 
	ENDIF 
	IF ( ChecksumEquals a = <part> b = skater_f_torso ) 
		<just_changed_torso> = 1 
	ENDIF 
	IF ( <just_changed_torso> = 1 ) 
		GetActualCASOptionStruct part = <part> desc_id = <desc_id> 
		EditPlayerAppearance { 
			profile = <currentSkaterProfileIndex> 
			target = SetPart 
			targetParams = { part = sleeves desc_id = None } 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT cas_disq_handle_weird_items 
	GetActualCASOptionStruct part = <part> desc_id = <desc_id> 
	IF GotParam is_weird_head 
		IF GetPlayerAppearancePart player = <currentSkaterProfileIndex> part = skater_m_torso 
			GetActualCASOptionStruct part = skater_m_torso desc_id = <desc_id> 
			IF GotParam not_with_weird_head 
				EditPlayerAppearance { 
					profile = <currentSkaterProfileIndex> 
					target = SetPart 
					targetParams = { part = skater_m_torso desc_id = %"T-shirt" } 
				} 
				EditPlayerAppearance { 
					profile = <currentSkaterProfileIndex> 
					target = SetPart 
					targetParams = { part = sleeves desc_id = None } 
				} 
			ENDIF 
		ENDIF 
		EditPlayerAppearance { 
			profile = <currentSkaterProfileIndex> 
			target = ClearPart 
			targetParams = { part = hat } 
		} 
		EditPlayerAppearance { 
			profile = <currentSkaterProfileIndex> 
			target = ClearPart 
			targetParams = { part = helmet } 
		} 
	ENDIF 
	IF GotParam is_weird_hat 
		IF GetPlayerAppearancePart player = <currentSkaterProfileIndex> part = skater_m_torso 
			GetActualCASOptionStruct part = skater_m_torso desc_id = <desc_id> 
			IF GotParam not_with_weird_hat 
				EditPlayerAppearance { 
					profile = <currentSkaterProfileIndex> 
					target = SetPart 
					targetParams = { part = skater_m_torso desc_id = %"T-shirt" } 
				} 
				EditPlayerAppearance { 
					profile = <currentSkaterProfileIndex> 
					target = SetPart 
					targetParams = { part = sleeves desc_id = None } 
				} 
			ENDIF 
		ENDIF 
		EditPlayerAppearance { 
			profile = <currentSkaterProfileIndex> 
			target = ClearPart 
			targetParams = { part = helmet } 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT cas_disq_remove_footwear 
	GetActualCASOptionStruct part = <part> desc_id = <desc_id> 
	GetCurrentSkaterProfileIndex 
	IF GotParam bare_feet 
		EditPlayerAppearance { 
			profile = <currentSkaterProfileIndex> 
			target = ClearPart 
			targetParams = { part = skater_m_socks } 
		} 
		EditPlayerAppearance { 
			profile = <currentSkaterProfileIndex> 
			target = ClearPart 
			targetParams = { part = skater_f_socks } 
		} 
		EditPlayerAppearance { 
			profile = <currentSkaterProfileIndex> 
			target = ClearPart 
			targetParams = { part = shoes } 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT cas_disq_remove_backpack 
	GetActualCASOptionStruct part = <part> desc_id = <desc_id> 
	GetCurrentSkaterProfileIndex 
	IF GotParam not_with_backpack 
		IF GetPlayerAppearancePart player = <currentSkaterProfileIndex> part = skater_m_backpack 
			GetActualCASOptionStruct part = skater_m_backpack desc_id = <desc_id> 
			IF GotParam is_backpack 
				EditPlayerAppearance { 
					profile = <currentSkaterProfileIndex> 
					target = ClearPart 
					targetParams = { part = skater_m_backpack } 
				} 
			ENDIF 
		ENDIF 
		IF GetPlayerAppearancePart player = <currentSkaterProfileIndex> part = skater_f_backpack 
			GetActualCASOptionStruct part = skater_f_backpack desc_id = <desc_id> 
			IF GotParam is_backpack 
				EditPlayerAppearance { 
					profile = <currentSkaterProfileIndex> 
					target = ClearPart 
					targetParams = { part = skater_f_backpack } 
				} 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT cas_disq_remove_bulky_shirt 
	GetActualCASOptionStruct part = <part> desc_id = <desc_id> 
	GetCurrentSkaterProfileIndex 
	IF GotParam is_backpack 
		IF GetPlayerAppearancePart player = <currentSkaterProfileIndex> part = skater_m_torso 
			GetActualCASOptionStruct part = skater_m_torso desc_id = <desc_id> 
			IF GotParam not_with_backpack 
				EditPlayerAppearance { 
					profile = <currentSkaterProfileIndex> 
					target = SetPart 
					targetParams = { part = skater_m_torso desc_id = %"T-shirt" } 
				} 
				EditPlayerAppearance { 
					profile = <currentSkaterProfileIndex> 
					target = SetPart 
					targetParams = { part = sleeves desc_id = None } 
				} 
			ENDIF 
		ENDIF 
		IF GetPlayerAppearancePart player = <currentSkaterProfileIndex> part = skater_f_torso 
			GetActualCASOptionStruct part = skater_f_torso desc_id = <desc_id> 
			IF GotParam not_with_backpack 
				EditPlayerAppearance { 
					profile = <currentSkaterProfileIndex> 
					target = SetPart 
					targetParams = { part = skater_f_torso desc_id = %"T-shirt" } 
				} 
				EditPlayerAppearance { 
					profile = <currentSkaterProfileIndex> 
					target = SetPart 
					targetParams = { part = sleeves desc_id = None } 
				} 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT cas_disq_remove_hat 
	GetActualCASOptionStruct part = <part> desc_id = <desc_id> 
	GetCurrentSkaterProfileIndex 
	IF ( ChecksumEquals a = <part> b = helmet ) 
		IF NOT GotParam null_item 
			GetCurrentSkaterProfileIndex 
			EditPlayerAppearance { 
				profile = <currentSkaterProfileIndex> 
				target = ClearPart 
				targetParams = { part = hat } 
			} 
			EditPlayerAppearance { 
				profile = <currentSkaterProfileIndex> 
				target = ClearPart 
				targetParams = { part = hat_logo } 
			} 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT cas_disq_remove_helmet 
	GetActualCASOptionStruct part = <part> desc_id = <desc_id> 
	GetCurrentSkaterProfileIndex 
	IF ( ChecksumEquals a = <part> b = hat ) 
		IF NOT GotParam null_item 
			GetCurrentSkaterProfileIndex 
			EditPlayerAppearance { 
				profile = <currentSkaterProfileIndex> 
				target = ClearPart 
				targetParams = { part = helmet } 
			} 
			EditPlayerAppearance { 
				profile = <currentSkaterProfileIndex> 
				target = ClearPart 
				targetParams = { part = helmet_logo } 
			} 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT cas_disq_remove_logo 
	GetActualCASOptionStruct part = <part> desc_id = <desc_id> 
	GetCurrentSkaterProfileIndex 
	IF ( ( ChecksumEquals a = <part> b = skater_m_torso ) | ( ChecksumEquals a = <part> b = skater_f_torso ) ) 
		IF NOT GotParam supports_logo 
			GetCurrentSkaterProfileIndex 
			EditPlayerAppearance { 
				profile = <currentSkaterProfileIndex> 
				target = ClearPart 
				targetParams = { part = front_logo } 
			} 
			EditPlayerAppearance { 
				profile = <currentSkaterProfileIndex> 
				target = ClearPart 
				targetParams = { part = back_logo } 
			} 
		ELSE 
			IF GotParam no_back_logo 
				EditPlayerAppearance { 
					profile = <currentSkaterProfileIndex> 
					target = ClearPart 
					targetParams = { part = back_logo } 
				} 
			ENDIF 
		ENDIF 
	ENDIF 
	IF ( ChecksumEquals a = <part> b = hat ) 
		IF NOT GotParam supports_logo 
			EditPlayerAppearance { 
				profile = <currentSkaterProfileIndex> 
				target = ClearPart 
				targetParams = { part = hat_logo } 
			} 
		ENDIF 
	ENDIF 
	IF ( ChecksumEquals a = <part> b = helmet ) 
		IF NOT GotParam supports_logo 
			EditPlayerAppearance { 
				profile = <currentSkaterProfileIndex> 
				target = ClearPart 
				targetParams = { part = helmet_logo } 
			} 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT cas_temp_disq_remove_head 
	<should_remove_head> = 0 
	IF GotPart part = skater_m_head 
		<head_part> = skater_m_head 
		<should_remove_head> = 1 
	ENDIF 
	IF GotPart part = skater_f_head 
		<head_part> = skater_f_head 
		<should_remove_head> = 1 
	ENDIF 
	IF ( <should_remove_head> ) 
		GetPart part = <head_part> 
		GetActualCASOptionStruct part = <head_part> desc_id = <desc_id> 
		<use_default_hsv> = 1 
		GetPart part = <head_part> 
		IF ( <use_default_hsv> = 1 ) 
			IF GotParam default_h 
				<use_default_hsv> = 0 
				<h> = <default_h> 
				<s> = <default_s> 
				<v> = <default_v> 
				IF NOT GotParam default_s 
					script_assert "missing default_s parameter" 
				ENDIF 
				IF NOT GotParam default_v 
					script_assert "missing default_v parameter" 
				ENDIF 
			ENDIF 
		ENDIF 
		SetPart part = <head_part> desc_id = None use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
	ENDIF 
ENDSCRIPT

SCRIPT cas_temp_disq_remove_socks 
	ClearPart part = skater_m_socks 
	ClearPart part = skater_f_socks 
ENDSCRIPT

SCRIPT cas_temp_disq_check_for_covered_socks 
	<should_remove_socks> = 0 
	IF GotPart part = skater_m_socks 
		<leg_part> = skater_m_legs 
		<sock_part> = skater_m_socks 
		<should_remove_socks> = 1 
	ENDIF 
	IF GotPart part = skater_f_socks 
		<leg_part> = skater_f_legs 
		<sock_part> = skater_f_socks 
		<should_remove_socks> = 1 
	ENDIF 
	IF ( <should_remove_socks> ) 
		IF GotPart part = <leg_part> 
			GetPart part = <leg_part> 
			GetActualCASOptionStruct part = <leg_part> desc_id = <desc_id> 
			IF GotParam covers_socks 
				GetPart part = shoes 
				GetActualCASOptionStruct part = shoes desc_id = <desc_id> 
				IF NOT GotParam bare_feet 
					ClearPart part = <sock_part> 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT cas_temp_disq_remove_accessories 
	ClearPart part = accessories 
ENDSCRIPT

SCRIPT cas_temp_disq_force_big_kneepads 
	<should_force_big_kneepads> = 0 
	IF GotPart part = skater_m_legs 
		IF PartGotFlag part = skater_m_legs flag = force_big_kneepads 
			<should_force_big_kneepads> = 1 
		ENDIF 
	ENDIF 
	IF GotPart part = skater_f_legs 
		IF PartGotFlag part = skater_f_legs flag = force_big_kneepads 
			<should_force_big_kneepads> = 1 
		ENDIF 
	ENDIF 
	IF ( <should_force_big_kneepads> ) 
		GetPart part = kneepads 
		GetActualCASOptionStruct part = kneepads desc_id = <desc_id> 
		<use_default_hsv> = 1 
		GetPart part = kneepads 
		IF ( <use_default_hsv> = 1 ) 
			IF GotParam default_h 
				<use_default_hsv> = 0 
				<h> = <default_h> 
				<s> = <default_s> 
				<v> = <default_v> 
				IF NOT GotParam default_s 
					script_assert "missing default_s parameter" 
				ENDIF 
				IF NOT GotParam default_v 
					script_assert "missing default_v parameter" 
				ENDIF 
			ENDIF 
		ENDIF 
		SetPart part = kneepads desc_id = %"Knee Pads Big" use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
	ENDIF 
ENDSCRIPT

SCRIPT cas_temp_disq_force_big_elbowpads 
	<should_replace_elbowpads> = 0 
	IF GotPart part = skater_m_torso 
		IF PartGotFlag part = skater_m_torso flag = force_big_elbowpads 
			<should_replace_elbowpads> = 1 
		ENDIF 
	ENDIF 
	IF GotPart part = skater_f_torso 
		IF PartGotFlag part = skater_f_torso flag = force_big_elbowpads 
			<should_replace_elbowpads> = 1 
		ENDIF 
	ENDIF 
	IF GotPart part = accessories 
		IF PartGotFlag part = accessories flag = force_big_elbowpads 
			<should_replace_elbowpads> = 1 
		ENDIF 
	ENDIF 
	IF ( <should_replace_elbowpads> ) 
		GetPart part = elbowpads 
		IF NOT GotParam desc_id 
			script_assert "GetPart didn\'t return an appropriate value" 
		ENDIF 
		AppendSuffixToChecksum Base = <desc_id> SuffixString = " Big" 
		GetActualCASOptionStruct part = elbowpads desc_id = <desc_id> 
		<use_default_hsv> = 1 
		GetPart part = elbowpads 
		IF ( <use_default_hsv> = 1 ) 
			IF GotParam default_h 
				<use_default_hsv> = 0 
				<h> = <default_h> 
				<s> = <default_s> 
				<v> = <default_v> 
				IF NOT GotParam default_s 
					script_assert "missing default_s parameter" 
				ENDIF 
				IF NOT GotParam default_v 
					script_assert "missing default_v parameter" 
				ENDIF 
			ENDIF 
		ENDIF 
		SetPart part = elbowpads desc_id = <appended_id> use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
	ENDIF 
ENDSCRIPT

SCRIPT cas_temp_disq_remove_elbowpads 
	<should_remove_elbowpads> = 0 
	IF GotPart part = skater_m_torso 
		IF PartGotFlag part = skater_m_torso flag = not_with_elbowpads 
			<should_remove_elbowpads> = 1 
		ENDIF 
	ENDIF 
	IF GotPart part = skater_f_torso 
		IF PartGotFlag part = skater_f_torso flag = not_with_elbowpads 
			<should_remove_elbowpads> = 1 
		ENDIF 
	ENDIF 
	IF GotPart part = accessories 
		IF PartGotFlag part = accessories flag = not_with_elbowpads 
			<should_remove_elbowpads> = 1 
		ENDIF 
	ENDIF 
	IF ( <should_remove_elbowpads> ) 
		ClearPart part = elbowpads 
	ENDIF 
ENDSCRIPT

SCRIPT cas_temp_disq_remove_kneepads 
	<should_remove_kneepads> = 0 
	IF GotPart part = skater_m_legs 
		IF PartGotFlag part = skater_m_legs flag = not_with_kneepads 
			<should_remove_kneepads> = 1 
		ENDIF 
	ENDIF 
	IF GotPart part = skater_f_legs 
		IF PartGotFlag part = skater_f_legs flag = not_with_kneepads 
			<should_remove_kneepads> = 1 
		ENDIF 
	ENDIF 
	IF ( <should_remove_kneepads> ) 
		ClearPart part = kneepads 
	ENDIF 
ENDSCRIPT

SCRIPT cas_temp_disq_replace_long_hair 
	<should_replace_hair> = 0 
	IF GotPart part = skater_m_hair 
		<hair_part> = skater_m_hair 
		<should_replace_hair> = 1 
	ENDIF 
	IF GotPart part = skater_f_hair 
		<hair_part> = skater_f_hair 
		<should_replace_hair> = 1 
	ENDIF 
	IF ( <should_replace_hair> ) 
		GetPart part = <hair_part> 
		GetActualCASOptionStruct part = <hair_part> desc_id = <desc_id> 
		<use_default_hsv> = 1 
		GetPart part = <hair_part> 
		IF ( <use_default_hsv> = 1 ) 
			IF GotParam default_h 
				<use_default_hsv> = 0 
				<h> = <default_h> 
				<s> = <default_s> 
				<v> = <default_v> 
				IF NOT GotParam default_s 
					script_assert "missing default_s parameter" 
				ENDIF 
				IF NOT GotParam default_v 
					script_assert "missing default_v parameter" 
				ENDIF 
			ENDIF 
		ENDIF 
		IF ChecksumEquals a = <hair_part> b = skater_m_hair 
			IF GotParam hair_type 
				SWITCH <male_hair_combo_type> 
					CASE bald_hair_combo 
						SetPart part = <hair_part> desc_id = Bald use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
					CASE buzzed_hair_combo 
						SWITCH <hair_type> 
							CASE Bald 
								SetPart part = <hair_part> desc_id = Bald use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
							CASE buzzed 
								SetPart part = <hair_part> desc_id = buzzed use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
							CASE medium 
								SetPart part = <hair_part> desc_id = buzzed use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
							CASE long 
								SetPart part = <hair_part> desc_id = buzzed use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
							CASE ponytail 
								SetPart part = <hair_part> desc_id = buzzed use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
							CASE tall 
								SetPart part = <hair_part> desc_id = buzzed use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
							DEFAULT 
								script_assert "Unrecognized hair type %s" hair_type = <hair_type> 
						ENDSWITCH 
					CASE basic_hair_combo 
						SWITCH <hair_type> 
							CASE Bald 
								SetPart part = <hair_part> desc_id = Bald use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
							CASE buzzed 
								SetPart part = <hair_part> desc_id = Hair_BuzzHAT use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
							CASE medium 
								SetPart part = <hair_part> desc_id = Hair_MediumHAT use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
							CASE long 
								SetPart part = <hair_part> desc_id = Hair_LongHAT use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
							CASE ponytail 
								SetPart part = <hair_part> desc_id = Hair_PonytailHAT use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
							CASE tall 
								SetPart part = <hair_part> desc_id = Hair_BuzzHAT use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
							DEFAULT 
								script_assert "Unrecognized hair type %s" hair_type = <hair_type> 
						ENDSWITCH 
					CASE medium_hair_combo 
						SWITCH <hair_type> 
							CASE Bald 
								SetPart part = <hair_part> desc_id = Bald use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
							CASE buzzed 
								SetPart part = <hair_part> desc_id = Hair_BuzzHAT use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
							CASE medium 
								SetPart part = <hair_part> desc_id = Hair_MediumHAT use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
							CASE long 
								SetPart part = <hair_part> desc_id = Hair_MediumHAT use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
							CASE ponytail 
								SetPart part = <hair_part> desc_id = Hair_BuzzHAT use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
							CASE tall 
								SetPart part = <hair_part> desc_id = Hair_BuzzHAT use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
							DEFAULT 
								script_assert "Unrecognized hair type %s" hair_type = <hair_type> 
						ENDSWITCH 
					CASE leavealone_hair_combo 
						SWITCH <hair_type> 
							CASE Bald 
								SetPart part = <hair_part> desc_id = Bald use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
							CASE buzzed 
								nullscript 
							CASE medium 
								nullscript 
							CASE long 
								SetPart part = <hair_part> desc_id = buzzed use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
							CASE ponytail 
								nullscript 
							CASE tall 
								SetPart part = <hair_part> desc_id = buzzed use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
							DEFAULT 
								script_assert "Unrecognized hair type %s" hair_type = <hair_type> 
						ENDSWITCH 
				ENDSWITCH 
			ENDIF 
		ENDIF 
		IF ChecksumEquals a = <hair_part> b = skater_f_hair 
			IF GotParam hair_type 
				SWITCH <female_hair_combo_type> 
					CASE bald_hair_combo 
						SetPart part = <hair_part> desc_id = Bald use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
					CASE leavealone_hair_combo 
						SWITCH <hair_type> 
							CASE medium 
								nullscript 
							CASE long 
								nullscript 
							CASE ponytail 
								nullscript 
							CASE mohawk 
								SetPart part = <hair_part> desc_id = Bald use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
							DEFAULT 
								script_assert "Unrecognized hair type %s" hair_type = <hair_type> 
						ENDSWITCH 
					CASE medium_hair_combo 
						SWITCH <hair_type> 
							CASE medium 
								SetPart part = <hair_part> desc_id = Hair_MediumHAT use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
							CASE long 
								SetPart part = <hair_part> desc_id = Hair_MediumHAT use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
							CASE ponytail 
								SetPart part = <hair_part> desc_id = Hair_MediumHAT use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
							CASE mohawk 
								SetPart part = <hair_part> desc_id = Bald use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
							DEFAULT 
								script_assert "Unrecognized hair type %s" hair_type = <hair_type> 
						ENDSWITCH 
					CASE basic_hair_combo 
						SWITCH <hair_type> 
							CASE medium 
								SetPart part = <hair_part> desc_id = Hair_MediumHAT use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
							CASE long 
								SetPart part = <hair_part> desc_id = Hair_LongHAT use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
							CASE ponytail 
								SetPart part = <hair_part> desc_id = Hair_PonytailHAT use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
							CASE mohawk 
								SetPart part = <hair_part> desc_id = Bald use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
							DEFAULT 
								script_assert "Unrecognized hair type %s" hair_type = <hair_type> 
						ENDSWITCH 
					CASE ponytail_hair_combo 
						SWITCH <hair_type> 
							CASE medium 
								SetPart part = <hair_part> desc_id = Hair_MediumHAT use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
							CASE long 
								SetPart part = <hair_part> desc_id = Hair_MediumHAT use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
							CASE ponytail 
								SetPart part = <hair_part> desc_id = Hair_PonytailHAT use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
							CASE mohawk 
								SetPart part = <hair_part> desc_id = Bald use_default_hsv = <use_default_hsv> h = <h> s = <s> v = <v> 
							DEFAULT 
								script_assert "Unrecognized hair type %s" hair_type = <hair_type> 
						ENDSWITCH 
				ENDSWITCH 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT


