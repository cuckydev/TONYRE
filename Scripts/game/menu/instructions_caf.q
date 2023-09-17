
(facemapping_instructions_steps) = [ 
	{ (step) = 1 (text) = [ "Take a digital photo of your face.\\n" 
		"Make sure it\'s front-on, with flat lighting." ] 
		(pos) = PAIR(390, 320) 
		(enter_script) = (show_pic_example) 
	(exit_script) = (hide_pic_example) } 
	{ (step) = 2 (text) = [ "Email it to faces@thugonline.com\\n " 
		"You\'ll get an e-mail reply with your password." ] 
	(pos) = PAIR(390, 295) } 
	{ (step) = 3 (text) = [ "From the menu here,\\n " 
		"Start with \'Download Face\'." ] 
		(pos) = PAIR(390, 270) 
	(last_instruction) = (last_instruction) } 
] 
(facemapping_instructions_steps_phone) = [ 
	{ (step) = 1 (text) = [ "Make sure your phone has a camera feature,\\n" 
		"and the ability to send and receive e-mail or multimedia messages." ] 
		(pos) = PAIR(390, 320) 
		(enter_script) = (show_pic_phone) 
	(exit_script) = (hide_pic_phone) } 
	{ (step) = 2 (text) = [ "Take a digital photo of yourself using a phone.\\n" 
		"Make sure it\'s front-on, with flat lighting." ] 
		(pos) = PAIR(390, 320) 
		(enter_script) = (show_pic_example) 
	(exit_script) = (hide_pic_example) } 
	{ (step) = 3 (text) = [ "Email it to faces@thugonline.com\\n " 
		"You\'ll get an e-mail reply with your password." ] 
	(pos) = PAIR(390, 295) } 
	{ (step) = 4 (text) = [ "From the menu here,\\n " 
		"Start with \'Download Face\'." ] 
		(pos) = PAIR(390, 270) 
	(last_instruction) = (last_instruction) } 
] 
SCRIPT (PlayInstructionSet) (end_target) = (sub_menu) (start_index) = 0 
	(GetArraySize) <instruction_set> 
	(FireEvent) (type) = (unfocus) (target) = <end_target> 
	(create_helper_text) { (helper_text_elements) = [ { (text) = "\\bn=Back" } 
	{ (text) = "\\bm=Continue" } ] } 
	IF NOT ( <start_index> = -1 ) 
		<index> = <start_index> 
		(CreateInstructionBlock) { 
			(instruction_set) = <instruction_set> 
			(instruction) = ( ( <instruction_set> [ <index> ] ) ) 
		} 
		(WaitForEvent) (type) = (instructions_done) 
	ENDIF 
	(wait) 0.20000000298 (seconds) 
	(FireEvent) (type) = (focus) (target) = <end_target> 
	(create_helper_text) (generic_helper_text) 
	IF (GotParam) (exit_script) 
		<exit_script> <exit_params> 
	ENDIF 
ENDSCRIPT

SCRIPT (exit_caf_instructions) 
	IF (GotParam) (from_phone) 
		<times> = 1 
	ELSE 
		<times> = 2 
	ENDIF 
	(change) (disable_menu_sounds) = 1 
	BEGIN 
		(FireEvent) (type) = (pad_down) (target) = (sub_vmenu) 
		(create_helper_text) (generic_helper_text_cas) 
	REPEAT <times> 
	(change) (disable_menu_sounds) = 0 
ENDSCRIPT

SCRIPT (CreateInstructionBlock) 
	(step_num_map) = [ "A" "A" "B" "C" "D" "E" "F" "G" ] 
	(FormatText) (textName) = (title_text) "Step %c:" (c) = ( ( <step_num_map> [ ( ( <instruction> ) . (step) ) ] ) ) 
	(create_instruction_box) { 
		(no_pad_start) 
		(title_text) = <title_text> 
		(text) = ( ( <instruction> ) . (text) ) 
		(style) = (speech_box_style) 
		(pos) = ( ( <instruction> ) . (pos) ) 
		(z_priority) = 20 
		(instruction_set) = <instruction_set> 
		(instruction_step) = ( ( <instruction> ) . (step) ) 
		(last_instruction) = ( ( <instruction> ) . (last_instruction) ) 
		(enter_script) = ( ( <instruction> ) . (enter_script) ) 
		(exit_script) = ( ( <instruction> ) . (exit_script) ) 
	} 
ENDSCRIPT

SCRIPT (exit_instruction_block) 
	(speech_box_exit) (anchor_id) = <anchor_id> 
ENDSCRIPT

SCRIPT (InstructionBlockForward) 
	IF (GotParam) (exit_script) 
		IF NOT ( <exit_script> = (None) ) 
			<exit_script> 
		ENDIF 
	ENDIF 
	(exit_instruction_block) (anchor_id) = <anchor_id> 
	<index> = <current_step> 
	<end> = ( ( <instruction_set> [ ( <index> -1 ) ] ) . (last_instruction) ) 
	IF NOT (GotParam) (end) 
		<current_step> = ( <current_step> + 1 ) 
		(CreateInstructionBlock) { 
			(instruction_set) = <instruction_set> 
			(instruction) = ( ( <instruction_set> [ <index> ] ) ) 
		} 
	ELSE 
		(FireEvent) (type) = (instructions_done) 
	ENDIF 
ENDSCRIPT

SCRIPT (InstructionBlockBack) 
	IF (GotParam) (exit_script) 
		IF NOT ( <exit_script> = (None) ) 
			<exit_script> 
		ENDIF 
	ENDIF 
	(exit_instruction_block) (anchor_id) = <anchor_id> 
	IF ( <current_step> > 1 ) 
		<current_step> = ( <current_step> - 1 ) 
		<index> = ( <current_step> -1 ) 
		(CreateInstructionBlock) { 
			(instruction_set) = <instruction_set> 
			(instruction) = ( ( <instruction_set> [ <index> ] ) ) 
		} 
	ELSE 
		(FireEvent) (type) = (instructions_done) 
	ENDIF 
ENDSCRIPT

SCRIPT (create_instruction_box) { (pos) = PAIR(320.00000000000, 340.00000000000) 
		(text_rgba) = [ 128 128 128 128 ] 
		(anchor_id) = (speech_box_anchor) 
		(scale) = 1 
		(pad_choose_script) = (InstructionBlockForward) 
		(pad_choose_params) = { (anchor_id) = <anchor_id> } 
		(pad_back_script) = (InstructionBlockBack) 
		(pad_back_params) = { (anchor_id) = <anchor_id> } 
		(parent) = (root_window) 
		(font) = (dialog) 
		(bg_x_scale) = 1 
		(pause_input_time) = 1000 
	} 
	(FormatText) (ChecksumName) = (bg_rgba) "%i_SPEECH_BOX_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(FormatText) (ChecksumName) = (on_rgba) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(FormatText) (ChecksumName) = (off_rgba) "%i_UNHIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	IF (ObjectExists) (id) = <anchor_id> 
		(DestroyScreenElement) (id) = <anchor_id> 
	ENDIF 
	(SetScreenElementLock) (id) = (root_window) (off) 
	(CreateScreenElement) { 
		(type) = (ContainerElement) 
		(parent) = <parent> 
		(id) = <anchor_id> 
		(pos) = <pos> 
		(dims) = PAIR(640.00000000000, 480.00000000000) 
		(scale) = <scale> 
		(z_priority) = <z_priority> 
	} 
	IF NOT (GotParam) (no_pad_choose) 
		(SetScreenElementProps) { 
			(id) = <anchor_id> 
			(event_handlers) = [ { (pad_choose) <pad_choose_script> (params) = { (current_step) = <instruction_step> (instruction_set) = <instruction_set> (exit_script) = <exit_script> (instruction_last) = <instruction_last> <pad_choose_params> } } ] 
			(replace_handlers) 
		} 
	ENDIF 
	IF (GotParam) (pad_back_script) 
		(SetScreenElementProps) { 
			(id) = <anchor_id> 
			(event_handlers) = [ { (pad_back) (generic_menu_pad_back) (params) = { (callback) = <pad_back_script> (current_step) = <instruction_step> (instruction_set) = <instruction_set> (anchor_id) = <anchor_id> (exit_script) = <exit_script> <pad_back_params> } } ] 
			(replace_handlers) 
		} 
	ENDIF 
	IF NOT (GotParam) (no_pad_start) 
		(SetScreenElementProps) { 
			(id) = (root_window) 
			(event_handlers) = [ { (pad_start) <pad_choose_script> (params) = { (current_step) = <instruction_step> (instruction_set) = <instruction_set> (exit_script) = <exit_script> (instruction_last) = <instruction_last> <pad_choose_params> } } ] 
			(replace_handlers) 
		} 
	ENDIF 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = <anchor_id> 
		(pos) = <pos> 
		(just) = [ (center) (bottom) ] 
		(texture) = (dialog_frame_b) 
		(scale) = ( PAIR(1.00000000000, 0.00000000000) * <bg_x_scale> + PAIR(0.00000000000, 1.00000000000) ) 
		(rgba) = <bg_rgba> 
	} 
	(CreateScreenElement) { 
		(type) = (TextElement) 
		(parent) = <anchor_id> 
		(font) = (dialog) 
		(pos) = PAIR(320.00000000000, 240.00000000000) 
		(just) = [ (center) (top) ] 
		(text) = <title_text> 
		(internal_scale) = 0.85000002384 
		(internal_just) = [ (center) (bottom) ] 
		(rgba) = <off_rgba> 
		(scale) = 1.50000000000 
		(allow_expansion) 
	} 
	<title_textblock> = <id> 
	(GetScreenElementDims) (id) = <title_textblock> 
	<title_height> = <height> 
	(CreateScreenElement) { 
		(type) = (TextBlockElement) 
		(parent) = <anchor_id> 
		(shadow) 
		(shadow_offs) = PAIR(1.00000000000, 1.00000000000) 
		(shadow_rgba) = [ 10 10 10 100 ] 
		(font) = <font> 
		(dims) = ( PAIR(249.00000000000, 0.00000000000) * <bg_x_scale> ) 
		(pos) = PAIR(0.00000000000, 0.00000000000) 
		(just) = [ (center) (top) ] 
		(text) = <text> 
		(internal_scale) = 0.85000002384 
		(internal_just) = [ (center) (bottom) ] 
		(rgba) = <text_rgba> 
		(scale) = 1 
		(allow_expansion) 
	} 
	<speech_text> = <id> 
	(GetScreenElementDims) (id) = <speech_text> 
	(SetScreenElementProps) { 
		(id) = <speech_text> 
		(pos) = ( <pos> - PAIR(0.00000000000, 16.00000000000) - ( PAIR(0.00000000000, 1.00000000000) * <height> ) ) 
	} 
	(GetScreenElementPosition) (id) = <speech_text> 
	(SetScreenElementProps) { 
		(id) = <title_textblock> 
		(pos) = ( <pos> - PAIR(0.00000000000, 1.00000000000) * ( <height> + <title_height> ) - PAIR(0.00000000000, 16.00000000000) ) 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = <anchor_id> 
		(texture) = (dialog_middle) 
		(pos) = ( <pos> - PAIR(0.00000000000, 16.00000000000) ) 
		(scale) = ( ( PAIR(1.00000000000, 0.00000000000) * <bg_x_scale> ) + PAIR(0.00000000000, 1.00000000000) * ( <height> + <title_height> ) / 16 ) 
		(just) = [ (center) (bottom) ] 
		(rgba) = <bg_rgba> 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = <anchor_id> 
		(pos) = ( <pos> - PAIR(0.00000000000, 16.00000000000) - PAIR(0.00000000000, 1.00000000000) * ( <height> + <title_height> ) ) 
		(just) = [ (center) (bottom) ] 
		(texture) = (dialog_frame) 
		(scale) = ( PAIR(1.00000000000, 0.00000000000) * <bg_x_scale> + PAIR(0.00000000000, 1.00000000000) ) 
		(rgba) = <bg_rgba> 
	} 
	IF (GotParam) (style) 
		(RunScriptOnScreenElement) (id) = <anchor_id> <style> (params) = <...> 
	ENDIF 
	IF (GotParam) (enter_script) 
		<enter_script> (parent) = <anchor_id> <...> 
	ENDIF 
	(FireEvent) (type) = (focus) (target) = <anchor_id> 
	IF (GotParam) (pause_input) 
		(SpawnScript) (TemporarilyDisableInput) (params) = { (time) = <pause_input_time> } 
	ENDIF 
ENDSCRIPT

SCRIPT (DrawInstructionLine) 
	IF (ScreenElementExists) (id) = (instruction_line) 
		(KillSpawnedScript) (name) = (DrawInstructionLine) 
		(DestroyScreenElement) (id) = (instruction_line) 
	ENDIF 
	(FormatText) (ChecksumName) = (on_rgba) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(SetScreenElementLock) (off) (id) = <parent> 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = <parent> 
		(id) = (instruction_line) 
		(texture) = (streak_2) 
		(rgba) = <on_rgba> 
		(just) = [ (left) (center) ] 
		(pos) = PAIR(0.00000000000, 0.00000000000) 
		(scale) = 1 
		(z_priority) = 30 
		(rot_angle) = 0 
		(alpha) = 0 
	} 
	(wait) 1 (gameframe) 
	BEGIN 
		(relative_pos) = ( <to> - <from> ) 
		(rel_x) = ( <relative_pos> . PAIR(1.00000000000, 0.00000000000) ) 
		(rel_y) = ( <relative_pos> . PAIR(0.00000000000, 1.00000000000) ) 
		IF NOT ( <rel_x> = 0 ) 
			(atan) ( <rel_y> / <rel_x> ) 
			(line_angle) = ( ( <atan> * 1 ) ) 
			(sin) ( <atan> ) 
			(line_length) = ( <rel_y> / <sin> ) 
			(line_scale) = ( ( <line_length> / 64 ) * PAIR(1.00000000000, 0.00000000000) + PAIR(0.00000000000, 1.00000000000) ) 
			(DoScreenElementMorph) { 
				(id) = (instruction_line) 
				(pos) = <to> 
				(scale) = <line_scale> 
				(rot_angle) = <line_angle> 
				(alpha) = 0.60000002384 
			} 
		ENDIF 
		(wait) 1 (gameframe) 
	REPEAT 
ENDSCRIPT

SCRIPT (show_pic_example) (parent) = (speech_box_anchor) 
	(FormatText) (ChecksumName) = (on_rgba) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(FormatText) (ChecksumName) = (off_rgba) "%i_UNHIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(CreateScreenElement) { 
		(type) = (ContainerElement) 
		(parent) = <parent> 
		(id) = (pic_anchor) 
		(pos) = ( <pos> + PAIR(180.00000000000, 260.00000000000) ) 
		(dims) = PAIR(640.00000000000, 480.00000000000) 
		(z_priority) = 20 
	} 
	(get_default_face_texture_name) 
	<head_test> = <textureName> 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (pic_anchor) 
		(pos) = PAIR(0.00000000000, 0.00000000000) 
		(texture) = (white2) 
		(scale) = 12.50000000000 
		(rgba) = <on_rgba> 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (pic_anchor) 
		(pos) = PAIR(0.00000000000, 0.00000000000) 
		(texture) = (cas_texture_from_profile) 
		(scale) = 0.75000000000 
		(z_priority) = 30 
	} 
	(GetScreenElementPosition) (id) = (pic_anchor) 
ENDSCRIPT

SCRIPT (hide_pic_example) 
	IF (ObjectExists) (id) = (pic_anchor) 
		(DestroyScreenElement) (id) = (pic_anchor) 
	ENDIF 
ENDSCRIPT

SCRIPT (show_pic_phone) (parent) = (speech_box_anchor) 
	(FormatText) (ChecksumName) = (on_rgba) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(FormatText) (ChecksumName) = (off_rgba) "%i_UNHIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(CreateScreenElement) { 
		(type) = (ContainerElement) 
		(parent) = <parent> 
		(id) = (pic_anchor) 
		(pos) = ( <pos> + PAIR(242.00000000000, 240.00000000000) ) 
		(dims) = PAIR(640.00000000000, 480.00000000000) 
		(z_priority) = 20 
	} 
	(FormatText) (ChecksumName) = (phone) "nokia_phone" 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (pic_anchor) 
		(pos) = PAIR(0.00000000000, 0.00000000000) 
		(texture) = <phone> 
		(scale) = 1.10000002384 
		(z_priority) = 29 
		(rot_angle) = -15 
		(rgba) = <on_rgba> 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (pic_anchor) 
		(pos) = PAIR(0.00000000000, 0.00000000000) 
		(texture) = <phone> 
		(scale) = 1.00000000000 
		(z_priority) = 30 
		(rot_angle) = -15 
	} 
	(GetScreenElementPosition) (id) = (pic_anchor) 
ENDSCRIPT

SCRIPT (hide_pic_phone) 
	IF (ObjectExists) (id) = (pic_anchor) 
		(DestroyScreenElement) (id) = (pic_anchor) 
	ENDIF 
ENDSCRIPT


