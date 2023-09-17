
colormenu_bar_scale = PAIR(4.4, 2) 
colormenu_bar_focus_rgba = [ 128 128 128 118 ] 
colormenu_bar_unfocus_rgba = [ 40 40 40 118 ] 
colormenu_bar_pos = PAIR(12, 0) 
colormenu_text_pos = PAIR(-102, 0) 
colormenu_spacing_between = 25 
colormenu_arrow_pos_up = PAIR(0, 7) 
colormenu_arrow_pos_down = PAIR(0, -7) 
colormenu_arrow_rgba = [ 128 128 128 128 ] 
colormenu_arrow_scale = 0.69999998808 
colormenu_wrap_arrow_left = -53.00000000000 
colormenu_wrap_arrow_right = 80.00000000000 
colormenu_nowrap_arrow_left = -53.00000000000 
colormenu_nowrap_arrow_right = 80.00000000000 
colormenu_hue_increment = 5 
colormenu_saturation_increment = 3 
colormenu_value_increment = 2 
colormenu_min_saturation = 0.00000000000 
colormenu_max_saturation = 90.00000000000 
colormenu_min_value = 12.00000000000 
colormenu_max_value = 60.00000000000 
SCRIPT colormenu_focus rgba = [ 128 128 128 50 ] 
	GetTags 
	FormatText ChecksumName = highlighted_text_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = bar_rgba "%i_HIGHLIGHT_BAR_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	IF GotParam from_caf 
		DoScreenElementMorph { 
			id = { <id> child = 0 } 
			rgba = <highlighted_text_rgba> 
			scale = 1.10000002384 
			relative_scale 
		} 
		SetScreenElementProps { 
			id = { <id> child = 5 } 
			rgba = <bar_rgba> 
		} 
		RunScriptOnScreenElement id = <id> text_twitch_effect params = { no_extra = no_extra } 
	ELSE 
		RunScriptOnScreenElement id = { <id> child = 0 } do_scale_up params = { rgba = <highlighted_text_rgba> } 
	ENDIF 
	IF GotParam pad_left_handler 
		SetScreenElementProps { 
			id = <id> 
			event_handlers = [ 
				{ pad_left <pad_left_handler> params = <handler_params> } 
			] 
			replace_handlers 
		} 
	ENDIF 
	IF GotParam pad_right_handler 
		SetScreenElementProps { 
			id = <id> 
			event_handlers = [ 
				{ pad_right <pad_right_handler> params = <handler_params> } 
			] 
			replace_handlers 
		} 
	ENDIF 
	SetScreenElementProps { 
		id = <color_bar_id> 
		rgba = colormenu_bar_focus_rgba 
	} 
	DoScreenElementMorph { 
		id = <down_arrow_id> 
		scale = colormenu_arrow_scale 
	} 
	DoScreenElementMorph { 
		id = <up_arrow_id> 
		scale = colormenu_arrow_scale 
	} 
	colormenu_refresh_arrows part = <part> 
	generic_menu_update_arrows { 
		up_arrow_id = edit_skater_menu_up_arrow 
		down_arrow_id = edit_skater_menu_down_arrow 
	} 
	IF ObjectExists id = edit_skater_vmenu 
		edit_skater_vmenu : GetTags 
		IF GotParam arrow_id 
			menu_vert_blink_arrow { id = <arrow_id> } 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT colormenu_unfocus rgba = [ 128 128 128 0 ] 
	GetTags 
	IF GotParam from_caf 
		FormatText ChecksumName = text_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
		KillSpawnedScript name = text_twitch_effect 
		DoScreenElementMorph { 
			id = { <id> child = 0 } 
			rgba = <text_rgba> 
			alpha = <text_alpha> 
			scale = 1 
			relative_scale 
		} 
		SetScreenElementProps { 
			id = { <id> child = 5 } 
			rgba = [ 128 128 128 0 ] 
		} 
	ELSE 
		RunScriptOnScreenElement id = { <id> child = 0 } do_scale_down 
	ENDIF 
	SetScreenElementProps { 
		id = <color_bar_id> 
		rgba = colormenu_bar_unfocus_rgba 
	} 
	DoScreenElementMorph { 
		id = <down_arrow_id> 
		scale = 0.00000000000 
	} 
	DoScreenElementMorph { 
		id = <up_arrow_id> 
		scale = 0.00000000000 
	} 
ENDSCRIPT

SCRIPT colormenu_get_default_color 
	IF NOT GotParam part 
		script_assert "no part parameter" 
	ENDIF 
	IF NOT GotParam desc_id 
		script_assert "no desc_id parameter" 
	ENDIF 
	GetActualCASOptionStruct part = <part> desc_id = <desc_id> 
	IF GotParam default_h 
		<h> = <default_h> 
	ELSE 
		<h> = 0 
	ENDIF 
	IF GotParam default_s 
		<s> = <default_s> 
	ELSE 
		<s> = 50 
	ENDIF 
	IF GotParam default_v 
		<v> = <default_v> 
	ELSE 
		<v> = 50 
	ENDIF 
	RETURN h = <h> s = <s> v = <v> 
ENDSCRIPT

SCRIPT colormenu_get_hsv 
	GetCurrentSkaterProfileIndex 
	GetPlayerAppearancePart player = <currentSkaterProfileIndex> part = <part> 
	IF NOT GotParam use_default_hsv 
		<use_default_hsv> = 1 
	ENDIF 
	IF NOT GotParam h 
		<h> = 0 
	ENDIF 
	IF NOT GotParam s 
		<s> = 0 
	ENDIF 
	IF NOT GotParam v 
		<v> = 0 
	ENDIF 
	IF ( <use_default_hsv> = 1 ) 
		colormenu_get_default_color part = <part> desc_id = <desc_id> 
	ENDIF 
	RETURN h = <h> s = <s> v = <v> use_default_hsv = <use_default_hsv> 
ENDSCRIPT

SCRIPT colormenu_set_hsv use_default_hsv = 0 
	GetCurrentSkaterProfileIndex 
	printf "h=%h s=%s v=%v" h = <h> s = <s> v = <v> 
	SetPlayerAppearanceColor player = <currentSkaterProfileIndex> part = <part> h = <h> s = <s> v = <v> use_default_hsv = <use_default_hsv> 
ENDSCRIPT

SCRIPT colormenu_refresh_arrows 
	colormenu_get_hsv part = <part> 
	sliderbar_rescale_to_bar min = 0.00000000000 max = 360.00000000000 value = <h> left = colormenu_wrap_arrow_left right = colormenu_wrap_arrow_right 
	SetScreenElementProps { 
		id = hue_up_arrow 
		pos = ( PAIR(1.00000000000, 0.00000000000) * <x_val> ) 
	} 
	SetScreenElementProps { 
		id = hue_down_arrow 
		pos = ( PAIR(1.00000000000, 0.00000000000) * <x_val> ) 
	} 
	sliderbar_rescale_to_bar min = colormenu_min_saturation max = colormenu_max_saturation value = <s> left = colormenu_nowrap_arrow_left right = colormenu_nowrap_arrow_right 
	SetScreenElementProps { 
		id = saturation_up_arrow 
		pos = ( PAIR(1.00000000000, 0.00000000000) * <x_val> ) 
	} 
	SetScreenElementProps { 
		id = saturation_down_arrow 
		pos = ( PAIR(1.00000000000, 0.00000000000) * <x_val> ) 
	} 
	sliderbar_rescale_to_bar min = colormenu_min_value max = colormenu_max_value value = <v> left = colormenu_nowrap_arrow_left right = colormenu_nowrap_arrow_right 
	SetScreenElementProps { 
		id = value_up_arrow 
		pos = ( PAIR(1.00000000000, 0.00000000000) * <x_val> ) 
	} 
	SetScreenElementProps { 
		id = value_down_arrow 
		pos = ( PAIR(1.00000000000, 0.00000000000) * <x_val> ) 
	} 
ENDSCRIPT

SCRIPT colormenu_refresh_skaters 
	GetCurrentSkaterProfileIndex 
	RefreshSkaterColors skater = 0 profile = <currentSkaterProfileIndex> 
ENDSCRIPT

SCRIPT colormenu_increment_hue 
	printf "incrementing hue" 
	colormenu_get_hsv part = <part> 
	<h> = ( <h> + colormenu_hue_increment ) 
	IF ( <h> > 359 ) 
		<h> = ( <h> - 360 ) 
	ENDIF 
	colormenu_set_hsv part = <part> h = <h> s = <s> v = <v> 
	colormenu_refresh_arrows part = <part> 
	colormenu_refresh_skaters 
ENDSCRIPT

SCRIPT colormenu_decrement_hue 
	printf "decrementing hue" 
	colormenu_get_hsv part = <part> 
	<h> = ( <h> - colormenu_hue_increment ) 
	IF ( <h> < 0 ) 
		<h> = ( <h> + 360 ) 
	ENDIF 
	colormenu_set_hsv part = <part> h = <h> s = <s> v = <v> 
	colormenu_refresh_arrows part = <part> 
	colormenu_refresh_skaters 
ENDSCRIPT

SCRIPT colormenu_increment_saturation 
	printf "incrementing saturation" 
	colormenu_get_hsv part = <part> 
	<s> = ( <s> + colormenu_saturation_increment ) 
	IF ( <s> > colormenu_max_saturation ) 
		<s> = colormenu_max_saturation 
	ENDIF 
	colormenu_set_hsv part = <part> h = <h> s = <s> v = <v> 
	colormenu_refresh_arrows part = <part> 
	colormenu_refresh_skaters 
ENDSCRIPT

SCRIPT colormenu_decrement_saturation 
	printf "decrementing saturation" 
	colormenu_get_hsv part = <part> 
	<s> = ( <s> - colormenu_saturation_increment ) 
	IF ( <s> < colormenu_min_saturation ) 
		<s> = colormenu_min_saturation 
	ENDIF 
	colormenu_set_hsv part = <part> h = <h> s = <s> v = <v> 
	colormenu_refresh_arrows part = <part> 
	colormenu_refresh_skaters 
ENDSCRIPT

SCRIPT colormenu_increment_value 
	printf "incrementing value" 
	colormenu_get_hsv part = <part> 
	<v> = ( <v> + colormenu_value_increment ) 
	IF ( <v> > colormenu_max_value ) 
		<v> = colormenu_max_value 
	ENDIF 
	colormenu_set_hsv part = <part> h = <h> s = <s> v = <v> 
	colormenu_refresh_arrows part = <part> 
	colormenu_refresh_skaters 
ENDSCRIPT

SCRIPT colormenu_decrement_value 
	printf "decrementing value" 
	colormenu_get_hsv part = <part> 
	<v> = ( <v> - colormenu_value_increment ) 
	IF ( <v> < colormenu_min_value ) 
		<v> = colormenu_min_value 
	ENDIF 
	colormenu_set_hsv part = <part> h = <h> s = <s> v = <v> 
	colormenu_refresh_arrows part = <part> 
	colormenu_refresh_skaters 
ENDSCRIPT

SCRIPT colormenu_reset_to_default 
	GetCurrentSkaterProfileIndex 
	GetPlayerAppearancePart player = <currentSkaterProfileIndex> part = <part> 
	colormenu_get_default_color part = <part> desc_id = <desc_id> 
	GetCurrentSkaterProfileIndex 
	SetPlayerAppearanceColor player = <currentSkaterProfileIndex> part = <part> h = <h> s = <s> v = <v> use_default_hsv = 1 
	colormenu_refresh_arrows part = <part> 
	colormenu_refresh_skaters 
ENDSCRIPT

SCRIPT colormenu_add_options_to_menu 
	IF NOT GotParam from_caf 
		SetScreenElementProps { 
			id = current_menu 
			spacing_between = colormenu_spacing_between 
		} 
	ENDIF 
	IF GotParam from_cas 
		IF ( ( in_deck_design = 1 ) | ( in_boardshop = 1 ) ) 
			create_helper_text generic_helper_text_left_right_up_down 
		ELSE 
			create_helper_text generic_helper_text_color_menu 
		ENDIF 
	ENDIF 
	sliderbar_add_item { 
		text = #"HUE" 
		focus_script = colormenu_focus 
		focus_params = { 
			pad_left_handler = colormenu_decrement_hue 
			pad_right_handler = colormenu_increment_hue 
			handler_params = { part = <part> } 
			up_arrow_id = hue_up_arrow 
			down_arrow_id = hue_down_arrow 
			part = <part> 
			color_bar_id = hue_slider_bar 
			from_caf = <from_caf> 
		} 
		unfocus_script = colormenu_unfocus 
		unfocus_params = { 
			up_arrow_id = hue_up_arrow 
			down_arrow_id = hue_down_arrow 
			color_bar_id = hue_slider_bar 
			from_caf = <from_caf> 
		} 
		pad_choose_script = nullscript 
		child_texture = colorbar 
		icon_id = hue_slider_bar 
		icon_scale = colormenu_bar_scale 
		icon_rgba = colormenu_bar_unfocus_rgba 
		icon_pos = colormenu_bar_pos 
		text_pos = colormenu_text_pos 
		text_just = [ left center ] 
		tab = tab3 
		anchor_id = hue_anchor 
		up_arrow_id = hue_up_arrow 
		down_arrow_id = hue_down_arrow 
		arrow_pos_up = colormenu_arrow_pos_up 
		arrow_pos_down = colormenu_arrow_pos_down 
		arrow_rgba = colormenu_arrow_rgba 
		text_pos = <text_pos> 
		icon_pos = <icon_pos> 
		arrow_pos_up = <arrow_pos_up> 
		arrow_pos_down = <arrow_pos_down> 
		dims = <dims> 
	} 
	sliderbar_add_item { 
		text = #"SAT." 
		focus_script = colormenu_focus 
		focus_params = { 
			pad_left_handler = colormenu_decrement_saturation 
			pad_right_handler = colormenu_increment_saturation 
			handler_params = { part = <part> } 
			up_arrow_id = saturation_up_arrow 
			down_arrow_id = saturation_down_arrow 
			part = <part> 
			color_bar_id = saturation_slider_bar 
			from_caf = <from_caf> 
		} 
		unfocus_script = colormenu_unfocus 
		unfocus_params = { 
			up_arrow_id = saturation_up_arrow 
			down_arrow_id = saturation_down_arrow 
			color_bar_id = saturation_slider_bar 
			from_caf = <from_caf> 
		} 
		pad_choose_script = nullscript 
		child_texture = bw_slider 
		icon_id = saturation_slider_bar 
		icon_scale = colormenu_bar_scale 
		icon_rgba = colormenu_bar_unfocus_rgba 
		icon_pos = colormenu_bar_pos 
		text_pos = colormenu_text_pos 
		text_just = [ left center ] 
		tab = tab3 
		anchor_id = saturation_anchor 
		up_arrow_id = saturation_up_arrow 
		down_arrow_id = saturation_down_arrow 
		arrow_pos_up = colormenu_arrow_pos_up 
		arrow_pos_down = colormenu_arrow_pos_down 
		arrow_rgba = colormenu_arrow_rgba 
		text_pos = <text_pos> 
		icon_pos = <icon_pos> 
		arrow_pos_up = <arrow_pos_up> 
		arrow_pos_down = <arrow_pos_down> 
		dims = <dims> 
	} 
	sliderbar_add_item { 
		text = #"VAL." 
		focus_script = colormenu_focus 
		focus_params = { 
			pad_left_handler = colormenu_decrement_value 
			pad_right_handler = colormenu_increment_value 
			handler_params = { part = <part> } 
			up_arrow_id = value_up_arrow 
			down_arrow_id = value_down_arrow 
			part = <part> 
			color_bar_id = value_slider_bar 
			from_caf = <from_caf> 
		} 
		unfocus_script = colormenu_unfocus 
		unfocus_params = { 
			up_arrow_id = value_up_arrow 
			down_arrow_id = value_down_arrow 
			color_bar_id = value_slider_bar 
			from_caf = <from_caf> 
		} 
		pad_choose_script = nullscript 
		child_texture = bw_slider 
		icon_id = value_slider_bar 
		icon_scale = colormenu_bar_scale 
		icon_rgba = colormenu_bar_unfocus_rgba 
		icon_pos = colormenu_bar_pos 
		text_pos = colormenu_text_pos 
		text_just = [ left center ] 
		tab = tab3 
		anchor_id = value_anchor 
		up_arrow_id = value_up_arrow 
		down_arrow_id = value_down_arrow 
		arrow_pos_up = colormenu_arrow_pos_up 
		arrow_pos_down = colormenu_arrow_pos_down 
		arrow_rgba = colormenu_arrow_rgba 
		text_pos = <text_pos> 
		icon_pos = <icon_pos> 
		arrow_pos_up = <arrow_pos_up> 
		arrow_pos_down = <arrow_pos_down> 
		dims = <dims> 
	} 
	IF NOT GotParam from_caf 
		edit_skater_menu_add_item { 
			text = #"Reset to default" 
			pad_choose_script = colormenu_reset_to_default 
			pad_choose_params = { part = <part> } 
			tab = tab3 
			dims = PAIR(10.00000000000, 30.00000000000) 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT posmenu_add_options_to_menu 
	SetScreenElementProps { 
		id = current_menu 
		spacing_between = colormenu_spacing_between 
		event_handlers = [ 
			{ pad_up null_script } 
			{ pad_down null_script } 
		] 
		replace_handlers 
	} 
	material = ( ( <part> [ 0 ] ) . material ) 
	pass = ( ( <part> [ 0 ] ) . pass ) 
	IF GotParam from_cas 
		create_helper_text generic_helper_text_color_menu 
	ENDIF 
	IF NOT GotParam no_pos 
		<add_pos> = add_pos 
	ELSE 
		<add_pos> = <no_pos> 
	ENDIF 
	IF NOT GotParam no_rot 
		<add_rot> = add_rot 
	ENDIF 
	IF NOT GotParam no_scale 
		<add_scale> = add_scale 
	ENDIF 
	posmenu_add_item { 
		part = <part> 
		material = <material> 
		pass = <pass> 
		add_pos = <add_pos> 
		add_rot = <add_rot> 
		add_scale = <add_scale> 
	} 
ENDSCRIPT

SCRIPT posmenu_add_item { pad_choose_script = null_script 
		tab = tab3 
		font = small 
		icon_scale = 0 
		icon_pos = PAIR(22.00000000000, 9.00000000000) 
		text_just = [ left center ] 
		text_pos = PAIR(0.00000000000, 0.00000000000) 
		dims = PAIR(0.00000000000, 40.00000000000) 
	} 
	IF GotParam is_enabled_script 
		<is_enabled_script> 
		IF ( <success> = 0 ) 
			RETURN 
		ENDIF 
	ENDIF 
	focus_params = { material = <material> pass = <pass> part = <part> } 
	CreateScreenElement { 
		type = ContainerElement 
		parent = current_menu 
		id = pos_parts_anchor 
		dims = <dims> 
		event_handlers = [ { pad_choose <pad_choose_script> params = <pad_choose_params> } 
			{ pad_alt2 posmenu_reset_uv params = { part = <part> } } 
			{ pad_up null_script } 
			{ pad_down null_script } 
		] 
		<not_focusable> 
		z_priority = 10 
	} 
	IF ( in_deck_design = 1 ) 
		IF isNGC 
			create_helper_text generic_helper_text_color_menu_reset_cad_ngc 
		ELSE 
			create_helper_text generic_helper_text_color_menu_reset_cad 
		ENDIF 
	ELSE 
		IF isNGC 
			create_helper_text generic_helper_text_color_menu_reset_ngc 
		ELSE 
			create_helper_text generic_helper_text_color_menu_reset 
		ENDIF 
	ENDIF 
	IF GotParam add_pos 
		posmenu_add_pos_item <...> 
	ENDIF 
	IF GotParam add_rot 
		posmenu_add_rotation_item <...> 
	ENDIF 
	IF GotParam add_scale 
		posmenu_add_scale_item <...> 
	ENDIF 
	wait 1 gameframe 
	posmenu_focus_all_parts <focus_params> 
ENDSCRIPT

SCRIPT posmenu_focus_all_parts 
	edit_skater_posmenu_focus <...> 
	edit_skater_scalemenu_focus <...> 
	edit_skater_rotmenu_focus <...> 
ENDSCRIPT

SCRIPT posmenu_add_pos_item 
	CreateScreenElement { 
		type = ContainerElement 
		parent = pos_parts_anchor 
		id = pos_anchor 
		pos = PAIR(15.00000000000, 15.00000000000) 
		dims = <dims> 
		z_priority = 10 
	} 
	<parent_id> = <id> 
	IF GotParam index 
		SetScreenElementProps { 
			id = <parent_id> 
			tags = { tag_grid_x = <index> } 
		} 
	ENDIF 
	FormatText ChecksumName = rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = arrow_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	CreateScreenElement { 
		type = TextElement 
		parent = <parent_id> 
		font = <font> 
		text = "Pos" 
		scale = 0.89999997616 
		rgba = <rgba> 
		just = <text_just> 
		pos = PAIR(-110.00000000000, 0.00000000000) 
		replace_handlers 
		<not_focusable> 
	} 
	IF isXbox 
		text = "\\b7/\\b4/\\b6/\\b5" 
		scale = 0.67000001669 
	ELSE 
		IF isNGC 
			text = "Control Stick" 
			scale = 0.67000001669 
		ELSE 
			text = "Left Analog Stick" 
			scale = 0.67000001669 
		ENDIF 
	ENDIF 
	CreateScreenElement { 
		type = TextElement 
		parent = <parent_id> 
		font = dialog 
		text = <text> 
		scale = <scale> 
		rgba = <arrow_rgba> 
		just = [ left top ] 
		pos = PAIR(-110.00000000000, -42.00000000000) 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <parent_id> 
		id = pos_up_arrow 
		texture = up_arrow 
		rgba = <rgba> 
		scale = 1.00000000000 
		pos = PAIR(20.00000000000, -30.00000000000) 
		z_priority = 5 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <parent_id> 
		id = pos_down_arrow 
		texture = down_arrow 
		rgba = <rgba> 
		scale = 1.00000000000 
		pos = PAIR(20.00000000000, 30.00000000000) 
		z_priority = 5 
	} 
	IF NOT ( <add_pos> = use_uv_v_only ) 
		CreateScreenElement { 
			type = SpriteElement 
			parent = <parent_id> 
			id = pos_left_arrow 
			texture = left_arrow 
			rgba = <rgba> 
			scale = 1.00000000000 
			pos = PAIR(-20.00000000000, 0.00000000000) 
			z_priority = 5 
		} 
	ENDIF 
	IF NOT ( <add_pos> = use_uv_v_only ) 
		CreateScreenElement { 
			type = SpriteElement 
			parent = <parent_id> 
			id = pos_right_arrow 
			texture = right_arrow 
			rgba = <rgba> 
			scale = 1.00000000000 
			pos = PAIR(60.00000000000, 0.00000000000) 
			z_priority = 5 
		} 
	ENDIF 
	get_part_current_desc_id part = <part> 
	IF GotParam current_desc_id 
		get_logo_texture part = <part> desc_id = <current_desc_id> 
		IF ( in_deck_design = 1 ) 
			scale = 1.00000000000 
		ELSE 
			scale = 0.50000000000 
		ENDIF 
		CreateScreenElement { 
			type = SpriteElement 
			parent = <parent_id> 
			id = pos_logo 
			texture = <texture> 
			scale = <scale> 
			pos = PAIR(20.00000000000, 0.00000000000) 
			z_priority = 5 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT swap_deck_layers part1 = deck_layer3 part2 = deck_layer1 
	GetCurrentSkaterProfileIndex 
	current_desc_id = None 
	get_part_current_desc_id part = <part1> 
	texture1 = <current_desc_id> 
	swap_get_uv part = <part1> 
	structure1 = <structure> 
	colormenu_get_hsv part = <part1> desc_id = <current_desc_id> 
	h1 = <h> s1 = <s> v1 = <v> use_default_hsv1 = <use_default_hsv> 
	current_desc_id = None 
	get_part_current_desc_id part = <part2> 
	texture2 = <current_desc_id> 
	swap_get_uv part = <part2> 
	structure2 = <structure> 
	colormenu_get_hsv part = <part2> desc_id = <current_desc_id> 
	h2 = <h> s2 = <s> v2 = <v> use_default_hsv2 = <use_default_hsv> 
	EditPlayerAppearance profile = <currentSkaterProfileIndex> target = SetPart targetParams = { part = <part1> desc_id = <texture2> } 
	SetPlayerAppearanceUV player = <currentSkaterProfileIndex> part = <part1> <structure2> 
	colormenu_set_hsv part = <part1> h = <h2> s = <s2> v = <v2> use_default_hsv = <use_default_hsv2> 
	EditPlayerAppearance profile = <currentSkaterProfileIndex> target = SetPart targetParams = { part = <part2> desc_id = <texture1> } 
	SetPlayerAppearanceUV player = <currentSkaterProfileIndex> part = <part2> <structure1> 
	colormenu_set_hsv part = <part2> h = <h1> s = <s1> v = <v1> use_default_hsv = <use_default_hsv1> 
	RefreshSkaterModel skater = 0 profile = <currentSkaterProfileIndex> 
	IF GotParam callback 
		<callback> <callback_params> 
	ENDIF 
ENDSCRIPT

SCRIPT posmenu_get_uv 
	GetCurrentSkaterProfileIndex 
	GetPlayerAppearancePart player = <currentSkaterProfileIndex> part = <part> 
	IF NOT GotParam use_default_uv 
		<use_default_uv> = 1 
	ENDIF 
	IF NOT GotParam uv_u 
		<uv_u> = 0 
	ENDIF 
	IF NOT GotParam uv_v 
		<uv_v> = 0 
	ENDIF 
	IF NOT GotParam uv_scale 
		<uv_scale> = 100 
	ENDIF 
	IF NOT GotParam uv_rot 
		<uv_rot> = 0 
	ENDIF 
	IF ( <use_default_uv> = 1 ) 
		<uv_u> = 0 
		<uv_v> = 0 
		<uv_scale> = 100 
		<uv_rot> = 0 
	ENDIF 
	RETURN uv_u = <uv_u> uv_v = <uv_v> uv_scale = <uv_scale> uv_rot = <uv_rot> use_default_uv = <use_default_uv> 
ENDSCRIPT

SCRIPT swap_get_uv 
	posmenu_get_uv <...> 
	RemoveParameter part 
	RETURN structure = { <...> } 
ENDSCRIPT

SCRIPT posmenu_set_uv 
	GetCurrentSkaterProfileIndex 
	SetPlayerAppearanceUV player = <currentSkaterProfileIndex> part = <part> uv_u = <uv_u> uv_v = <uv_v> uv_scale = <uv_scale> uv_rot = <uv_rot> use_default_uv = 0 
ENDSCRIPT

SCRIPT posmenu_maybe_reset_uv 
	FireEvent type = unfocus target = current_menu 
	create_error_box { title = "Reset?" 
		text = "Are you sure you want to reset the adjustments to this item?" 
		pad_back_script = dialog_box_exit 
		buttons = [ { font = small text = "Yes" pad_choose_script = posmenu_reset_uv params = { part = <part> refocus } } 
			{ font = small text = "No" pad_choose_script = dialog_box_exit } 
		] 
	} 
	create_helper_text generic_helper_text 
ENDSCRIPT

SCRIPT posmenu_reset_uv 
	IF isNGC 
		IF NOT ControllerPressed L1 
			RETURN 
		ENDIF 
	ENDIF 
	GetCurrentSkaterProfileIndex 
	SetPlayerAppearanceUV player = <currentSkaterProfileIndex> part = <part> uv_u = 0 uv_v = 0 uv_scale = 100 uv_rot = 0 use_default_uv = 1 
	IF ( in_deck_design = 0 ) 
		no_board = no_board 
	ENDIF 
	RefreshSkaterModel skater = 0 profile = <currentSkaterProfileIndex> no_board = <no_board> 
	IF GotParam refocus 
		FireEvent type = focus target = current_menu 
	ENDIF 
ENDSCRIPT

SCRIPT adjust_cas_texture_pos uv_increment = 10 
	IF NOT GotParam pass 
		RETURN 
	ENDIF 
	IF NOT GotParam material 
		RETURN 
	ENDIF 
	FormatText ChecksumName = on_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = off_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	controller = 0 
	got_controller = 0 
	BEGIN 
		IF ControllerBoundToSkater controller = <controller> skater = 0 
			got_controller = 1 
			BREAK 
		ENDIF 
		controller = ( <controller> + 1 ) 
	REPEAT 4 
	IF ( got_controller = 0 ) 
		RETURN 
	ENDIF 
	BEGIN 
		GetAnalogueInfo controller = <controller> 
		posmenu_get_uv part = <part> 
		<oldU> = <uv_u> 
		<oldV> = <uv_v> 
		IF ObjectExists id = pos_right_arrow 
			IF ( <leftx> > 0 ) 
				DoScreenElementMorph id = pos_right_arrow rgba = <on_rgba> scale = 1.10000002384 
			ELSE 
				DoScreenElementMorph id = pos_right_arrow rgba = <off_rgba> scale = 1 
			ENDIF 
		ENDIF 
		IF ObjectExists id = pos_left_arrow 
			IF ( 0 > <leftx> ) 
				DoScreenElementMorph id = pos_left_arrow rgba = <on_rgba> scale = 1.10000002384 
			ELSE 
				DoScreenElementMorph id = pos_left_arrow rgba = <off_rgba> scale = 1 
			ENDIF 
		ENDIF 
		IF ObjectExists id = pos_down_arrow 
			IF ( <lefty> > 0 ) 
				DoScreenElementMorph id = pos_down_arrow rgba = <on_rgba> scale = 1.10000002384 
			ELSE 
				DoScreenElementMorph id = pos_down_arrow rgba = <off_rgba> scale = 1 
			ENDIF 
		ENDIF 
		IF ObjectExists id = pos_up_arrow 
			IF ( 0 > <lefty> ) 
				DoScreenElementMorph id = pos_up_arrow rgba = <on_rgba> scale = 1.10000002384 
			ELSE 
				DoScreenElementMorph id = pos_up_arrow rgba = <off_rgba> scale = 1 
			ENDIF 
		ENDIF 
		IF NOT ( in_deck_design = 1 ) 
			temp = <lefty> 
			lefty = ( -1 * <leftx> ) 
			leftx = ( 1 * <temp> ) 
		ENDIF 
		IF ObjectExists id = pos_up_arrow 
			IF ( <leftx> > 0 ) 
				<uv_v> = ( <uv_v> + ( <leftx> * <uv_increment> ) ) 
			ENDIF 
		ENDIF 
		IF ObjectExists id = pos_down_arrow 
			IF ( 0 > <leftx> ) 
				<uv_v> = ( <uv_v> + ( <leftx> * <uv_increment> ) ) 
			ENDIF 
		ENDIF 
		IF ObjectExists id = pos_right_arrow 
			IF ( <lefty> > 0 ) 
				<uv_u> = ( <uv_u> + ( <lefty> * <uv_increment> ) ) 
			ENDIF 
		ENDIF 
		IF ObjectExists id = pos_left_arrow 
			IF ( 0 > <lefty> ) 
				<uv_u> = ( <uv_u> + ( <lefty> * <uv_increment> ) ) 
			ENDIF 
		ENDIF 
		IF ( <uv_u> < -200 ) 
			<uv_u> = 200 
		ENDIF 
		IF ( <uv_u> > 200 ) 
			<uv_u> = -200 
		ENDIF 
		IF ( <uv_v> < -200 ) 
			<uv_v> = 200 
		ENDIF 
		IF ( <uv_v> > 200 ) 
			<uv_v> = -200 
		ENDIF 
		IF NOT ( <oldU> = <uv_u> ) 
			posmenu_set_uv part = <part> <...> 
			refresh_skater_uv 
		ELSE 
			IF NOT ( <oldV> = <uv_v> ) 
				posmenu_set_uv part = <part> <...> 
				refresh_skater_uv 
			ENDIF 
		ENDIF 
		IF IsPs2 
			wait 4 gameframe 
		ELSE 
			wait 1 gameframe 
		ENDIF 
	REPEAT 
ENDSCRIPT

SCRIPT refresh_skater_uv 
	IF IsPs2 
		IF ( in_deck_design = 0 ) 
			no_board = no_board 
		ENDIF 
		GetCurrentSkaterProfileIndex 
		RefreshSkaterModel skater = 0 profile = <currentSkaterProfileIndex> no_board = <no_board> 
	ELSE 
		GetCurrentSkaterProfileIndex 
		RefreshSkaterUV skater = 0 profile = <currentSkaterProfileIndex> 
	ENDIF 
ENDSCRIPT

SCRIPT edit_skater_posmenu_focus 
	IF ScreenElementExists id = pos_up_arrow 
		RunScriptOnScreenElement id = pos_up_arrow adjust_cas_texture_pos params = { pass = <pass> material = <material> part = <part> } 
	ENDIF 
ENDSCRIPT

SCRIPT edit_skater_posmenu_unfocus 
	KillSpawnedScript name = adjust_cas_texture_pos 
ENDSCRIPT

SCRIPT posmenu_add_rotation_item { pad_choose_script = null_script 
		tab = tab3 
		font = small 
		icon_scale = 0 
		icon_pos = PAIR(22.00000000000, 9.00000000000) 
		text_just = [ left center ] 
		text_pos = PAIR(0.00000000000, 0.00000000000) 
		dims = PAIR(0.00000000000, 40.00000000000) 
		anchor_id = rot_item_anchor 
	} 
	IF GotParam is_enabled_script 
		<is_enabled_script> 
		IF ( <success> = 0 ) 
			RETURN 
		ENDIF 
	ENDIF 
	CreateScreenElement { 
		type = ContainerElement 
		parent = pos_parts_anchor 
		id = rot_anchor 
		pos = PAIR(0.00000000000, 85.00000000000) 
		dims = <dims> 
		z_priority = 10 
	} 
	<parent_id> = <id> 
	IF GotParam index 
		SetScreenElementProps { 
			id = <parent_id> 
			tags = { tag_grid_x = <index> } 
		} 
	ENDIF 
	FormatText ChecksumName = rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = arrow_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	CreateScreenElement { 
		type = TextElement 
		parent = <parent_id> 
		font = <font> 
		text = "Rot" 
		scale = 0.89999997616 
		rgba = <rgba> 
		just = <text_just> 
		pos = PAIR(-95.00000000000, 0.00000000000) 
		replace_handlers 
		<not_focusable> 
	} 
	IF isXbox 
		text = "\\bk" 
		scale = 0.67000001669 
	ELSE 
		IF isNGC 
			text = "C-Stick" 
			scale = 0.67000001669 
		ELSE 
			text = "Right Analog Stick" 
			scale = 0.67000001669 
		ENDIF 
	ENDIF 
	CreateScreenElement { 
		type = TextElement 
		parent = <parent_id> 
		font = dialog 
		text = <text> 
		scale = <scale> 
		rgba = <arrow_rgba> 
		just = [ left top ] 
		pos = PAIR(-95.00000000000, -30.00000000000) 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <parent_id> 
		id = rot_left_arrow 
		texture = left_arrow 
		rgba = <rgba> 
		scale = 1.00000000000 
		pos = PAIR(-33.00000000000, 0.00000000000) 
		z_priority = 5 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <parent_id> 
		id = rot_right_arrow 
		texture = right_arrow 
		rgba = <rgba> 
		scale = 1.00000000000 
		pos = PAIR(75.00000000000, 0.00000000000) 
		z_priority = 5 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <parent_id> 
		id = rot_logo 
		texture = rot_bar 
		scale = PAIR(1.39999997616, 1.00000000000) 
		pos = PAIR(21.00000000000, 0.00000000000) 
		z_priority = 5 
	} 
ENDSCRIPT

SCRIPT adjust_cas_texture_rot rot_increment = 20 
	IF NOT GotParam pass 
		RETURN 
	ENDIF 
	IF NOT GotParam material 
		RETURN 
	ENDIF 
	FormatText ChecksumName = on_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = off_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	controller = 0 
	got_controller = 0 
	BEGIN 
		IF ControllerBoundToSkater controller = <controller> skater = 0 
			got_controller = 1 
			BREAK 
		ENDIF 
		controller = ( <controller> + 1 ) 
	REPEAT 4 
	IF ( got_controller = 0 ) 
		RETURN 
	ENDIF 
	BEGIN 
		GetAnalogueInfo controller = <controller> 
		posmenu_get_uv part = <part> 
		<oldRot> = <uv_rot> 
		IF ( <rightx> > 0 ) 
			DoScreenElementMorph id = rot_right_arrow rgba = <on_rgba> scale = 1.10000002384 
			<uv_rot> = ( <uv_rot> + ( <rightx> * <rot_increment> ) ) 
		ELSE 
			DoScreenElementMorph id = rot_right_arrow rgba = <off_rgba> scale = 1 
		ENDIF 
		IF ( 0 > <rightx> ) 
			DoScreenElementMorph id = rot_left_arrow rgba = <on_rgba> scale = 1.10000002384 
			<uv_rot> = ( <uv_rot> + ( <rightx> * <rot_increment> ) ) 
		ELSE 
			DoScreenElementMorph id = rot_left_arrow rgba = <off_rgba> scale = 1 
		ENDIF 
		IF ( <uv_rot> < 0 ) 
			<uv_rot> = ( <uv_rot> + 360 ) 
		ENDIF 
		IF ( <uv_rot> > 360 ) 
			<uv_rot> = ( <uv_rot> - 360 ) 
		ENDIF 
		IF NOT ( <oldRot> = <uv_rot> ) 
			posmenu_set_uv part = <part> <...> 
			refresh_skater_uv 
		ENDIF 
		IF IsPs2 
			wait 4 gameframe 
		ELSE 
			wait 1 gameframe 
		ENDIF 
	REPEAT 
ENDSCRIPT

SCRIPT edit_skater_rotmenu_focus 
	IF ScreenElementExists id = rot_left_arrow 
		RunScriptOnScreenElement id = rot_left_arrow adjust_cas_texture_rot params = { pass = <pass> material = <material> part = <part> } 
	ENDIF 
ENDSCRIPT

SCRIPT edit_skater_rotmenu_unfocus 
	KillSpawnedScript name = adjust_cas_texture_rot 
ENDSCRIPT

SCRIPT posmenu_add_scale_item { pad_choose_script = null_script 
		tab = tab3 
		font = small 
		icon_scale = 0 
		icon_pos = PAIR(22.00000000000, 9.00000000000) 
		text_just = [ left center ] 
		text_pos = PAIR(0.00000000000, 0.00000000000) 
		dims = PAIR(0.00000000000, 40.00000000000) 
		anchor_id = scale_item_anchor 
	} 
	IF GotParam is_enabled_script 
		<is_enabled_script> 
		IF ( <success> = 0 ) 
			RETURN 
		ENDIF 
	ENDIF 
	IF NOT GotParam add_rot 
		pos = PAIR(0.00000000000, 90.00000000000) 
	ELSE 
		pos = PAIR(0.00000000000, 115.00000000000) 
	ENDIF 
	CreateScreenElement { 
		type = ContainerElement 
		parent = pos_parts_anchor 
		id = scale_anchor 
		pos = <pos> 
		dims = <dims> 
		z_priority = 10 
	} 
	<parent_id> = <id> 
	IF GotParam index 
		SetScreenElementProps { 
			id = <parent_id> 
			tags = { tag_grid_x = <index> } 
		} 
	ENDIF 
	FormatText ChecksumName = rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = arrow_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	IF NOT GotParam add_rot 
		IF isXbox 
			text = "\\bk" 
			scale = 0.67000001669 
		ELSE 
			IF isNGC 
				text = "C-Stick" 
				scale = 0.67000001669 
			ELSE 
				text = "Right Analog Stick" 
				scale = 0.67000001669 
			ENDIF 
		ENDIF 
		CreateScreenElement { 
			type = TextElement 
			parent = <parent_id> 
			font = dialog 
			text = <text> 
			scale = <scale> 
			rgba = <arrow_rgba> 
			just = [ left top ] 
			pos = PAIR(-95.00000000000, -30.00000000000) 
		} 
	ENDIF 
	CreateScreenElement { 
		type = TextElement 
		parent = <parent_id> 
		font = <font> 
		text = "Scale" 
		scale = 0.89999997616 
		rgba = <rgba> 
		just = <text_just> 
		pos = PAIR(-95.00000000000, 0.00000000000) 
		replace_handlers 
		<not_focusable> 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <parent_id> 
		id = scale_down_arrow 
		texture = down_arrow 
		rgba = <rgba> 
		scale = 1.00000000000 
		pos = PAIR(-30.00000000000, 0.00000000000) 
		z_priority = 5 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <parent_id> 
		id = scale_up_arrow 
		texture = up_arrow 
		rgba = <rgba> 
		scale = 1.00000000000 
		pos = PAIR(80.00000000000, 0.00000000000) 
		z_priority = 5 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <parent_id> 
		id = scale_logo 
		texture = scale_bar 
		scale = PAIR(1.39999997616, 1.00000000000) 
		pos = PAIR(21.00000000000, 0.00000000000) 
		z_priority = 5 
	} 
ENDSCRIPT

SCRIPT adjust_cas_texture_scale scale_increment = 10 
	IF NOT GotParam pass 
		RETURN 
	ENDIF 
	IF NOT GotParam material 
		RETURN 
	ENDIF 
	IF StructureContains structure = ( <part> [ 0 ] ) scale_min 
		scale_min = ( ( <part> [ 0 ] ) . scale_min ) 
	ELSE 
		scale_min = 200 
	ENDIF 
	FormatText ChecksumName = on_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = off_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	controller = 0 
	got_controller = 0 
	BEGIN 
		IF ControllerBoundToSkater controller = <controller> skater = 0 
			got_controller = 1 
			BREAK 
		ENDIF 
		controller = ( <controller> + 1 ) 
	REPEAT 4 
	IF ( got_controller = 0 ) 
		RETURN 
	ENDIF 
	BEGIN 
		GetAnalogueInfo controller = <controller> 
		posmenu_get_uv part = <part> 
		<oldScale> = <uv_scale> 
		IF ( <righty> > 0 ) 
			DoScreenElementMorph id = scale_down_arrow rgba = <on_rgba> scale = 1.10000002384 
			<uv_scale> = ( <uv_scale> + ( <righty> * <scale_increment> ) ) 
		ELSE 
			DoScreenElementMorph id = scale_down_arrow rgba = <off_rgba> scale = 1 
		ENDIF 
		IF ( 0 > <righty> ) 
			DoScreenElementMorph id = scale_up_arrow rgba = <on_rgba> scale = 1.10000002384 
			<uv_scale> = ( <uv_scale> + ( <righty> * <scale_increment> ) ) 
		ELSE 
			DoScreenElementMorph id = scale_up_arrow rgba = <off_rgba> scale = 1 
		ENDIF 
		IF ( <uv_scale> < 50 ) 
			<uv_scale> = 50 
		ENDIF 
		IF ( <uv_scale> > <scale_min> ) 
			<uv_scale> = <scale_min> 
		ENDIF 
		IF NOT ( <oldScale> = <uv_scale> ) 
			posmenu_set_uv part = <part> <...> 
			refresh_skater_uv 
		ENDIF 
		IF IsPs2 
			wait 4 gameframe 
		ELSE 
			wait 1 gameframe 
		ENDIF 
	REPEAT 
ENDSCRIPT

SCRIPT edit_skater_scalemenu_focus 
	IF ScreenElementExists id = scale_up_arrow 
		RunScriptOnScreenElement id = scale_up_arrow adjust_cas_texture_scale params = { pass = <pass> material = <material> part = <part> } 
	ENDIF 
ENDSCRIPT

SCRIPT edit_skater_scalemenu_unfocus 
	KillSpawnedScript name = adjust_cas_texture_scale 
ENDSCRIPT


