SCRIPT sliderbar_rescale_to_bar 
	<target1> = ( ( <value> - <min> ) / ( <max> - <min> ) ) 
	<target2> = ( <right> - <left> ) 
	<target3> = ( <target1> * <target2> ) 
	<rescaled_value> = ( <target3> + <left> ) 
	RETURN x_val = <rescaled_value> 
ENDSCRIPT

SCRIPT sliderbar_add_item { pad_choose_script = edit_skater_create_cas_menu 
		focus_script = edit_skater_menu_focus 
		unfocus_script = edit_skater_menu_unfocus 
		tab = tab1 
		font = small 
		icon_rgba = [ 127 102 0 128 ] 
		icon_scale = 0 
		icon_pos = PAIR(22, 9) 
		text_just = [ center center ] 
		text_pos = PAIR(0, 0) 
		arrow_pos_up = PAIR(0, 8) 
		arrow_pos_down = PAIR(0, -8) 
		arrow_rgba = [ 128 128 128 128 ] 
		up_arrow_texture = up_arrow 
		down_arrow_texture = down_arrow 
		dims = PAIR(0, 20) 
	} 
	IF GotParam is_enabled_script 
		<is_enabled_script> 
		IF ( <success> = 0 ) 
			RETURN 
		ENDIF 
	ENDIF 
	SWITCH <tab> 
		CASE tab1 
			<bar_scale> = PAIR(0.92, 1.2) 
		CASE tab2 
			<bar_scale> = PAIR(0.85, 1.2) 
		CASE tab3 
			<bar_scale> = PAIR(0.78, 1.2) 
			<font> = dialog 
	ENDSWITCH 
	SetScreenElementLock id = current_menu off 
	IF NOT GotParam pad_choose_params 
		<pad_choose_params> = <...> 
	ENDIF 
	IF GotParam index 
		IF GotParam pad_choose_params 
			<pad_choose_params> = ( <pad_choose_params> + { parent_index = <index> } ) 
		ELSE 
			<pad_choose_params> = { parent_index = <index> } 
		ENDIF 
	ENDIF 
	CreateScreenElement { 
		type = ContainerElement 
		parent = current_menu 
		id = <anchor_id> 
		dims = <dims> 
		event_handlers = [ { focus <focus_script> params = <focus_params> } 
			{ unfocus <unfocus_script> params = <unfocus_params> } 
			{ pad_choose <pad_choose_script> params = <pad_choose_params> } 
		] 
		<not_focusable> 
		z_priority = 300 
	} 
	<parent_id> = <id> 
	IF GotParam index 
		SetScreenElementProps { 
			id = <parent_id> 
			tags = { tag_grid_x = <index> } 
		} 
	ENDIF 
	IF GotParam not_focusable 
		<rgba> = [ 60 60 60 85 ] 
	ELSE 
		FormatText ChecksumName = rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	ENDIF 
	CreateScreenElement { 
		type = TextElement 
		parent = <parent_id> 
		font = <font> 
		text = <text> 
		scale = 0.89999997616 
		rgba = <rgba> 
		just = <text_just> 
		pos = <text_pos> 
		replace_handlers 
		<not_focusable> 
	} 
	highlight_angle = RANDOM_NO_REPEAT(1, 1, 1, 1, 1, 1, 1, 1, 1, 1) RANDOMCASE 2 RANDOMCASE -2 RANDOMCASE 3 RANDOMCASE -3 RANDOMCASE 3.50000000000 RANDOMCASE -3 RANDOMCASE 5 RANDOMCASE -4 RANDOMCASE 2.50000000000 RANDOMCASE -4.50000000000 RANDOMEND 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <parent_id> 
		texture = DE_highlight_bar 
		pos = PAIR(-25.00000000000, -7.00000000000) 
		rgba = [ 0 0 0 0 ] 
		just = [ center center ] 
		scale = PAIR(1.89999997616, 0.69999998808) 
		z_priority = ( 3 -1 ) 
		rot_angle = <highlight_angle> 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <parent_id> 
		pos = PAIR(-4.00000000000, 0.00000000000) 
		scale = <bar_scale> 
		texture = highlight_bar 
		rgba = [ 128 128 128 0 ] 
	} 
	CreateScreenElement { 
		type = ContainerElement 
		parent = <anchor_id> 
		just = [ center bottom ] 
		dims = { 200 , 200 } 
		pos = <arrow_pos_down> 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <id> 
		id = <down_arrow_id> 
		texture = <down_arrow_texture> 
		rgba = <arrow_rgba> 
		scale = 0.00000000000 
	} 
	CreateScreenElement { 
		type = ContainerElement 
		parent = <anchor_id> 
		just = [ center top ] 
		dims = { 200 , 200 } 
		pos = <arrow_pos_up> 
	} 
	CreateScreenElement { 
		type = SpriteElement 
		parent = <id> 
		id = <up_arrow_id> 
		texture = <up_arrow_texture> 
		rgba = <arrow_rgba> 
		scale = 0.00000000000 
	} 
	IF GotParam child_texture 
		CreateScreenElement { 
			type = SpriteElement 
			parent = <parent_id> 
			texture = <child_texture> 
			pos = <icon_pos> 
			rgba = <icon_rgba> 
			scale = <icon_scale> 
			id = <icon_id> 
		} 
	ENDIF 
	SetScreenElementLock id = current_menu on 
ENDSCRIPT


