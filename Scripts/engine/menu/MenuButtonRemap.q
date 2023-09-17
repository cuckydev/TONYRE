pad_event_types = [ 
	pad_up 
	pad_down 
	pad_right 
	pad_left 
	pad_choose 
	pad_back 
	pad_square 
	pad_circle 
	pad_l1 
	pad_r1 
	pad_l2 
	pad_r2 
	pad_l3 
	pad_r3 
	pad_select 
	pad_start 
	pad_option 
	pad_backspace 
	pad_space 
	pad_alt 
	pad_alt2 
	pad_expand 
] 
SCRIPT setup_main_button_event_mappings 
	SetButtonEventMappings { 
		ps2 = [ 
			[ x pad_choose ] 
			[ triangle pad_back ] 
			[ square pad_square ] 
			[ circle pad_circle ] 
			[ left_trigger1 pad_l1 ] 
			[ right_trigger1 pad_r1 ] 
			[ left_trigger2 pad_l2 ] 
			[ right_trigger2 pad_r2 ] 
			[ select pad_select ] 
			[ left_stick_button pad_l3 ] 
			[ right_stick_button pad_r3 ] 
			[ circle pad_option ] 
			[ triangle pad_triangle2 ] 
			[ square pad_backspace ] 
			[ circle pad_space ] 
			[ right_trigger2 pad_alt ] 
			[ left_trigger2 pad_alt2 ] 
		] 
		xbox = [ 
			[ a pad_choose ] 
			[ back pad_back ] 
			[ x pad_square ] 
			[ left_trigger_half pad_l1 ] 
			[ right_trigger_half pad_r1 ] 
			[ left_trigger_full pad_l2 ] 
			[ b pad_back ] 
			[ b pad_circle ] 
			[ right_trigger_full pad_r2 ] 
			[ left_stick_button pad_l3 ] 
			[ right_stick_button pad_r3 ] 
			[ x pad_option ] 
			[ y pad_triangle2 ] 
			[ x pad_backspace ] 
			[ y pad_space ] 
			[ black pad_alt ] 
			[ white pad_alt2 ] 
			[ y pad_expand ] 
		] 
		gamecube = [ 
			[ a pad_choose ] 
			[ b pad_back ] 
			[ x pad_circle ] 
			[ y pad_square ] 
			[ left_trigger_half pad_l1 ] 
			[ right_trigger_half pad_r1 ] 
			[ left_trigger_full pad_l2 ] 
			[ right_trigger_full pad_r2 ] 
			[ z pad_select ] 
			[ z_plus_left_trigger pad_l3 ] 
			[ z_plus_right_trigger pad_r3 ] 
			[ x pad_option ] 
			[ y pad_triangle2 ] 
			[ y pad_backspace ] 
			[ x pad_space ] 
			[ z pad_alt ] 
			[ right_trigger_half pad_alt2 ] 
		] 
	} 
ENDSCRIPT


