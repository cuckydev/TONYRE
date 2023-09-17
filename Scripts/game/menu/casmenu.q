
SCRIPT (cas_add_item) 
	(printf) "Adding CAS item here" 
	IF (GotParam) (play_deck_sound) 
		(PlaySound) (DE_MenuSelect) (vol) = 100 
	ENDIF 
	(change_current_part_highlight) { (id) = <id> (unfocus_script) = <unfocus_script> (unfocus_params) = <unfocus_params> } 
	(cas_handle_disqualifications) <...> 
	IF (ChecksumEquals) (a) = <part> (b) = (skater_m_head) 
		(clear_face_texture_from_profile) 
	ENDIF 
	IF (ChecksumEquals) (a) = <part> (b) = (skater_f_head) 
		(clear_face_texture_from_profile) 
	ENDIF 
	(GetCurrentSkaterProfileIndex) 
	IF (LevelIs) (Load_cas) 
		(player) = 0 
	ELSE 
		(player) = <currentSkaterProfileIndex> 
	ENDIF 
	IF (StructureContains) (structure) = ( <part> [ 0 ] ) (cad_graphic) 
		(EditPlayerAppearance) (profile) = <currentSkaterProfileIndex> (target) = (SetPart) (targetParams) = { (part) = (deck_graphic) (desc_id) = (None) } 
	ELSE 
		IF (StructureContains) (structure) = ( <part> [ 0 ] ) (deck_graphic) 
			(EditPlayerAppearance) (profile) = <currentSkaterProfileIndex> (target) = (SetPart) (targetParams) = { (part) = (cad_graphic) (desc_id) = (None) } 
			(EditPlayerAppearance) (profile) = <currentSkaterProfileIndex> (target) = (SetPart) (targetParams) = { (part) = (deck_layer1) (desc_id) = (None) } 
			(EditPlayerAppearance) (profile) = <currentSkaterProfileIndex> (target) = (SetPart) (targetParams) = { (part) = (deck_layer2) (desc_id) = (None) } 
			(EditPlayerAppearance) (profile) = <currentSkaterProfileIndex> (target) = (SetPart) (targetParams) = { (part) = (deck_layer3) (desc_id) = (None) } 
			(EditPlayerAppearance) (profile) = <currentSkaterProfileIndex> (target) = (SetPart) (targetParams) = { (part) = (deck_layer4) (desc_id) = (None) } 
			(EditPlayerAppearance) (profile) = <currentSkaterProfileIndex> (target) = (SetPart) (targetParams) = { (part) = (deck_layer5) (desc_id) = (None) } 
		ENDIF 
	ENDIF 
	(EditPlayerAppearance) (profile) = <currentSkaterProfileIndex> (target) = (SetPart) (targetParams) = { <...> } 
	IF (LevelIs) (Load_cas) 
		IF NOT ( (in_deck_design) = 1 ) 
			(no_board) = (no_board) 
		ENDIF 
	ENDIF 
	(RefreshSkaterModel) (skater) = <player> (profile) = <currentSkaterProfileIndex> (no_board) = <no_board> 
	IF (IsTrue) (cas_debug) 
		(DumpHeaps) 
	ENDIF 
ENDSCRIPT

SCRIPT (cas_remove_item) 
	(printf) "Removing CAS item here" 
	(PrintStruct) <...> 
	(GetCurrentSkaterProfileIndex) 
	IF (LevelIs) (Load_Skateshop) 
		(EditPlayerAppearance) (profile) = <currentSkaterProfileIndex> (target) = (ClearPart) (targetParams) = { <...> } 
		(RefreshSkaterModel) (skater) = 0 (profile) = <currentSkaterProfileIndex> 
	ELSE 
		(EditPlayerAppearance) (profile) = <currentSkaterProfileIndex> (target) = (ClearPart) (targetParams) = { <...> } 
		(RefreshSkaterModel) (skater) = <currentSkaterProfileIndex> (profile) = <currentSkaterProfileIndex> 
	ENDIF 
ENDSCRIPT

SCRIPT (launch_bodyshape_menu) 
	(RunScriptOnScreenElement) (id) = (current_menu_anchor) (animate_out) (callback) = (create_bodyshape_menu) (callback_params) = { <...> } 
ENDSCRIPT

SCRIPT (create_bodyshape_menu) 
	IF (ObjectExists) (id) = (current_menu_anchor) 
		(DestroyScreenElement) (id) = (current_menu_anchor) 
	ENDIF 
	(make_new_menu) (menu_id) = (cas_submenu) (vmenu_id) = (cas_subvmenu) (menu_title) = "BUILDS" (type) = (vscrollingmenu) (dims) = PAIR(320, 200) 
	(SetScreenElementProps) { 
		(id) = (cas_submenu) 
		(event_handlers) = [ { (pad_back) (create_cas_menu) } ] 
		(replace_handlers) 
	} 
	(add_bodyshapes_to_menu) <...> 
	(RunScriptOnScreenElement) (id) = (current_menu_anchor) (animate_in) 
ENDSCRIPT

SCRIPT (add_bodyshapes_to_menu) 
	(GetArraySize) (master_bodyshape_list) 
	<index> = 0 
	BEGIN 
		(make_text_sub_menu_item) { 
			(text) = ( ( (master_bodyshape_list) [ <index> ] ) . (text) ) 
			(pad_choose_script) = (cas_apply_bodyshape) 
			(pad_choose_params) = { (field) = (body_shape) (value) = ( ( (master_bodyshape_list) [ <index> ] ) . (scaling_table) ) } 
		} 
		<index> = ( <index> + 1 ) 
	REPEAT <array_size> 
ENDSCRIPT

(master_bodyshape_list) = [ 
	{ (text) = "Normal" (scaling_table) = (normal_scale_info) } 
	{ (text) = "Large" (scaling_table) = (fat_scale_info) } 
	{ (text) = "Athletic" (scaling_table) = (athletic_scale_info) } 
	{ (text) = "Kid" (scaling_table) = (kid_scale_info) } 
] 
SCRIPT (cas_apply_bodyshape) 
	(printf) "Applying body shape here" 
	(GetCurrentSkaterProfileIndex) 
	IF (LevelIs) (Load_Skateshop) 
		(EditPlayerAppearance) (profile) = <currentSkaterProfileIndex> (target) = (SetChecksum) (targetParams) = { <...> } 
		(RefreshSkaterModel) (skater) = 0 (profile) = <currentSkaterProfileIndex> 
	ELSE 
		(EditPlayerAppearance) (profile) = <currentSkaterProfileIndex> (target) = (SetPart) (targetParams) = { <...> } 
		(RefreshSkaterModel) (skater) = <currentSkaterProfileIndex> (profile) = <currentSkaterProfileIndex> 
	ENDIF 
ENDSCRIPT

SCRIPT (cas_apply_sex) (apply_male) = 1 
	(GetCurrentSkaterProfileIndex) 
	(GetSkaterProfileInfo) (player) = <currentSkaterProfileIndex> 
	IF ( <is_male> = 1 ) 
		<success> = 1 
	ELSE 
		<success> = 0 
	ENDIF 
	IF ( <success> = <apply_male> ) 
		(printf) "Same sex" 
	ELSE 
		IF ( <apply_male> = 1 ) 
			(SetPlayerAppearance) (player) = <currentSkaterProfileIndex> (appearance_structure) = (appearance_custom_skater_male) 
			(SetSkaterProfileProperty) (player) = <currentSkaterProfileIndex> (is_male) 1 
		ELSE 
			(SetPlayerAppearance) (player) = <currentSkaterProfileIndex> (appearance_structure) = (appearance_custom_skater_female) 
			(SetSkaterProfileProperty) (player) = <currentSkaterProfileIndex> (is_male) 0 
		ENDIF 
		(RefreshSkaterModel) (skater) = 0 (profile) = <currentSkaterProfileIndex> 
	ENDIF 
ENDSCRIPT

SCRIPT (refresh_skater_model) 
	(GetCurrentSkaterProfileIndex) 
	IF (LevelIs) (Load_Skateshop) 
		<skaterIndex> = 0 
	ELSE 
		<skaterIndex> = <currentSkaterProfileIndex> 
	ENDIF 
	(RefreshSkaterModel) (profile) = <currentSkaterProfileIndex> (skater) = <skaterIndex> 
	(RefreshSkaterScale) (profile) = <currentSkaterProfileIndex> (skater) = <skaterIndex> 
	(RefreshSkaterVisibility) (profile) = <currentSkaterProfileIndex> (skater) = <skaterIndex> 
ENDSCRIPT

SCRIPT (refresh_skater_model_for_cheats) 
	<refresh_both_skaters> = 0 
	IF (InSplitScreenGame) 
		<refresh_both_skaters> = 1 
		IF (LevelIs) (Load_Skateshop) 
			<refresh_both_skaters> = 0 
		ENDIF 
	ENDIF 
	IF ( <refresh_both_skaters> = 1 ) 
		(RefreshSkaterScale) (profile) = 0 (skater) = 0 
		(RefreshSkaterVisibility) (profile) = 0 (skater) = 0 
		(RefreshSkaterScale) (profile) = 1 (skater) = 1 
		(RefreshSkaterVisibility) (profile) = 1 (skater) = 1 
	ELSE 
		(GetCurrentSkaterProfileIndex) 
		IF (LevelIs) (Load_Skateshop) 
			<skaterIndex> = 0 
		ELSE 
			<skaterIndex> = <currentSkaterProfileIndex> 
		ENDIF 
		(RefreshSkaterScale) (profile) = <currentSkaterProfileIndex> (skater) = <skaterIndex> 
		(RefreshSkaterVisibility) (profile) = <currentSkaterProfileIndex> (skater) = <skaterIndex> 
	ENDIF 
ENDSCRIPT

SCRIPT (load_pro_skater) 
	(SelectCurrentSkater) (name) = <name> 
	IF (LevelIs) (Load_cas) 
		(skater) : (SwitchOffBoard) 
		(no_board) = (no_board) 
	ENDIF 
	(GetCurrentSkaterProfileIndex) 
	(RefreshSkaterModel) (profile) = <currentSkaterProfileIndex> (skater) = 0 (no_board) = <no_board> 
	IF NOT (ObjectExists) (id) = (select_skater_top_anchor) 
		(maybe_revert_theme) 
	ENDIF 
ENDSCRIPT


