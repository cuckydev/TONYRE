
(current_soundtrack) = () 
SCRIPT (launch_sound_options_menu) 
	IF (GotParam) (from_options) 
		(create_sound_options_menu) (from_options) 
	ELSE 
		(create_sound_options_menu) 
	ENDIF 
ENDSCRIPT

SCRIPT (create_sound_options_menu) 
	(FormatText) (ChecksumName) = (title_icon) "%i_sound" (i) = ( (THEME_PREFIXES) [ (current_theme_prefix) ] ) 
	(make_new_themed_sub_menu) (title) = "SOUND OPTIONS" (title_icon) = <title_icon> 
	IF (LevelIs) (load_skateshop) 
		(sound_options_graphic) 
	ENDIF 
	(create_helper_text) { (helper_text_elements) = [ { (text) = "\\b7/\\b4 = Select" } 
			{ (text) = "\\b6/\\b5 = Adjust Levels" } 
			{ (text) = "\\bn = Back" } 
			{ (text) = "\\bm = Accept" } 
		] 
	} 
	(SetScreenElementProps) { (id) = (sub_menu) 
		(event_handlers) = [ 
			{ (pad_back) (generic_menu_pad_back) (params) = { (callback) = (sound_options_exit) } } 
		] 
	} 
	IF (GetGlobalFlag) (flag) = (SOUNDS_SONGORDER_RANDOM) 
		(song_text) = "Random" 
	ELSE 
		(song_text) = "In Order" 
	ENDIF 
	(theme_menu_add_item) { (text) = "Songs:" 
		(extra_text) = <song_text> 
		(id) = (menu_song_order) 
		(pad_choose_script) = (toggle_song_order) 
	} 
	(theme_menu_add_item) { (text) = "Skip Track" 
		(id) = (menu_skip_track) 
		(focus_script) = (skip_track_focus) 
		(unfocus_script) = (skip_track_unfocus) 
		(pad_choose_script) = (skip_track) 
		(pad_choose_params) = { } 
	} 
	IF NOT (isxbox) 
		IF NOT ( (DEMO_BUILD) ) 
			(theme_menu_add_item) { (text) = "Soundtrack" 
				(id) = (menu_soundtrack) 
				(pad_choose_script) = (create_soundtrack_menu) 
				(pad_choose_params) = { } 
			} 
		ENDIF 
	ENDIF 
	IF NOT (inNetGame) 
		IF ( (current_soundtrack) = () ) 
			(theme_menu_add_item) { (text) = "Playlist" 
				(id) = (menu_playlist) 
				(pad_choose_script) = (create_playlist_menu) 
				(pad_choose_params) = { } 
			} 
		ELSE 
			(theme_menu_add_item) { (text) = "Playlist" 
				(id) = (menu_playlist) 
				(pad_choose_script) = (nullscript) 
				(not_focusable) = (not_focusable) 
			} 
		ENDIF 
	ENDIF 
	(theme_menu_add_item) { (text) = "Music Level:" 
		(id) = (menu_music_level) 
		(focus_script) = (menu_music_level_focus) 
		(focus_params) = { (music_level) = (music_level) } 
		(unfocus_script) = (menu_music_level_unfocus) 
		(no_sound) 
	} 
	(theme_menu_add_item) { (text) = "Sound Level:" 
		(id) = (menu_sound_level) 
		(focus_script) = (menu_music_level_focus) 
		(unfocus_script) = (menu_music_level_unfocus) 
		(no_sound) 
	} 
	(theme_menu_add_item) { (text) = "Special Sounds:" 
		(id) = (menu_sound_special) 
		(extra_text) = "" 
		(focus_script) = (menu_music_special_focus) 
		(unfocus_script) = (menu_music_special_unfocus) 
		(pad_choose_script) = (toggle_special_sounds) 
		(no_sound) 
	} 
	(FormatText) (ChecksumName) = (checkmark_rgba) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(FormatText) (ChecksumName) = (checkbox_rgba) "%i_UNHIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (menu_sound_special) 
		(texture) = (checkbox) 
		(pos) = PAIR(130, -13) 
		(just) = [ (center) (top) ] 
		(scale) = 0.55000001192 
		(rgba) = <checkbox_rgba> 
		(z_priority) = 5 
	} 
	IF NOT (GetGlobalFlag) (flag) = (SOUNDS_SPECIALSOUNDS_OFF) 
		(CreateScreenElement) { 
			(type) = (SpriteElement) 
			(parent) = <id> 
			(id) = (menu_sound_special_chk) 
			(texture) = (checkmark) 
			(pos) = PAIR(25.00000000000, -9.00000000000) 
			(just) = [ (center) (top) ] 
			(rgba) = <checkmark_rgba> 
			(z_priority) = 6 
			(scale) = 1.39999997616 
		} 
	ELSE 
		(CreateScreenElement) { 
			(type) = (SpriteElement) 
			(parent) = <id> 
			(id) = (menu_sound_special_chk) 
			(texture) = (checkmark) 
			(pos) = PAIR(25.00000000000, -7.00000000000) 
			(just) = [ (center) (top) ] 
			(rgba) = [ 0 0 0 0 ] 
			(z_priority) = 6 
			(scale) = 1.39999997616 
		} 
	ENDIF 
	IF (GotParam) (from_options) 
		(theme_menu_add_item) (text) = "Done" (id) = (menu_done) (pad_choose_script) = (sound_options_exit) (pad_choose_params) = { (from_options) } (last_menu_item) = 1 
	ELSE 
		(theme_menu_add_item) (text) = "Done" (id) = (menu_done) (pad_choose_script) = (sound_options_exit) (last_menu_item) = 1 
	ENDIF 
	(sound_options_show_levels) 
	(add_music_track_text) 
	(finish_themed_sub_menu) 
	(PauseMusic) 
ENDSCRIPT

SCRIPT (sound_options_graphic) 
	(CreateScreenElement) { 
		(type) = (containerElement) 
		(parent) = (current_menu_anchor) 
		(id) = (boombox_anchor) 
		(dims) = PAIR(320.00000000000, 240.00000000000) 
		(pos) = PAIR(340.00000000000, 0.00000000000) 
		(just) = [ (left) (top) ] 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (boombox_anchor) 
		(id) = (boombox1) 
		(texture) = (so_icon_1) 
		(pos) = PAIR(170.00000000000, 140.00000000000) 
		(just) = [ (center) (center) ] 
		(alpha) = 0.30000001192 
		(rot_angle) = 11 
		(z_priority) = -2 
		(scale) = PAIR(0.80000001192, 0.80000001192) 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (boombox_anchor) 
		(id) = (boombox2) 
		(texture) = (so_icon_2) 
		(pos) = PAIR(160.00000000000, 150.00000000000) 
		(just) = [ (center) (center) ] 
		(alpha) = 0.03500000015 
		(rot_angle) = 10 
		(z_priority) = -2 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (boombox_anchor) 
		(id) = (speaker1) 
		(texture) = (so_icon_3) 
		(pos) = PAIR(101.00000000000, 128.00000000000) 
		(just) = [ (center) (center) ] 
		(alpha) = 0.25000000000 
		(rot_angle) = 10 
		(z_priority) = 1 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (boombox_anchor) 
		(id) = (speaker2) 
		(texture) = (so_icon_3) 
		(pos) = PAIR(208.00000000000, 180.00000000000) 
		(just) = [ (center) (center) ] 
		(alpha) = 0.50000000000 
		(rot_angle) = 10 
		(z_priority) = 1 
		(scale) = 1.14999997616 
	} 
	(FormatText) (ChecksumName) = (highlight_rgba) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (boombox_anchor) 
		(id) = (volume_bar) 
		(texture) = (white2) 
		(rgba) = <highlight_rgba> 
		(pos) = PAIR(146.00000000000, 84.00000000000) 
		(just) = [ (left) (center) ] 
		(rot_angle) = 22 
		(z_priority) = 1 
		(scale) = PAIR(7.50000000000, 0.50000000000) 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (current_menu_anchor) 
		(id) = (bg_star) 
		(texture) = (so_star) 
		(pos) = PAIR(0.00000000000, 315.00000000000) 
		(just) = [ (left) (center) ] 
		(alpha) = 0.69999998808 
		(z_priority) = -2 
		(scale) = PAIR(1.29999995232, 2.00000000000) 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (current_menu_anchor) 
		(id) = (so_rotating_bg) 
		(texture) = (bg_vector_1) 
		(rgba) = [ 23 58 75 15 ] 
		(just) = [ (center) , (center) ] 
		(pos) = PAIR(210.00000000000, 180.00000000000) 
		(z_priority) = -4 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (current_menu_anchor) 
		(id) = (so_rotating_bg2) 
		(texture) = (bg_vector_1) 
		(rgba) = [ 100 25 3 15 ] 
		(just) = [ (center) , (center) ] 
		(pos) = PAIR(210.00000000000, 180.00000000000) 
		(z_priority) = -3 
	} 
	(spawnscript) (boombox_speaker_pulse) 
	(spawnscript) (update_volume_bar) 
	(spawnscript) (chap_new_rotating_bg) (params) = { (id) = (so_rotating_bg) (scale) = 1.39999997616 } 
	(spawnscript) (chap_new_rotating_bg_2) (params) = { (id) = (so_rotating_bg2) (scale) = 1.10000002384 } 
ENDSCRIPT

SCRIPT (GetTracksEnabled) 
	<num_enabled> = 0 
	(GetArraySize) (playlist_tracks) 
	(index) = 0 
	BEGIN 
		IF (TrackEnabled) <index> 
			<num_enabled> = ( <num_enabled> + 1 ) 
			BREAK 
		ENDIF 
		(index) = ( <index> + 1 ) 
	REPEAT <array_size> 
	RETURN (num_enabled) = <num_enabled> 
ENDSCRIPT

SCRIPT (add_music_track_text) (parent) = (current_menu_anchor) (pos) = PAIR(575.00000000000, 320.00000000000) 
	IF NOT ( (current_soundtrack) = () ) 
		RETURN 
	ENDIF 
	(GetTracksEnabled) 
	IF ( <num_enabled> = 0 ) 
		RETURN 
	ENDIF 
	IF (LevelIs) (load_skateshop) 
		(pos) = PAIR(575.00000000000, 320.00000000000) 
	ENDIF 
	(GetCurrentTrack) 
	IF ( <current_track> = 999 ) 
		RETURN 
	ENDIF 
	IF NOT (TrackEnabled) <current_track> 
		RETURN 
	ENDIF 
	(CreateScreenElement) { 
		(type) = (containerElement) 
		(parent) = <parent> 
		(id) = (music_track_anchor) 
		(pos) = <pos> 
		(dims) = PAIR(0.00000000000, 0.00000000000) 
	} 
	(current_band_text) = ( ( (playlist_tracks) [ <current_track> ] ) . (band) ) 
	(GetUpperCaseString) <current_band_text> 
	(FormatText) (textName) = (current_track_text) "\'\'%t\'\'" (t) = ( ( (playlist_tracks) [ <current_track> ] ) . (track_title) ) 
	(FormatText) (ChecksumName) = (on_rgba) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(FormatText) (ChecksumName) = (off_rgba) "%i_UNHIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(CreateScreenElement) { 
		(type) = (textElement) 
		(parent) = (music_track_anchor) 
		(id) = (music_band_text) 
		(text) = <uppercasestring> 
		(font) = (testtitle) 
		(just) = [ (right) (top) ] 
		(scale) = 1 
		(pos) = PAIR(4.00000000000, 10.00000000000) 
		(rgba) = <on_rgba> 
		(alpha) = 0.80000001192 
	} 
	(GetScreenElementDims) (id) = (music_band_text) 
	IF ( <width> > 260 ) 
		<scale> = ( 260.00000000000 / <width> ) 
		(DoScreenElementMorph) (id) = (music_band_text) (time) = 0 (scale) = <scale> 
	ENDIF 
	(CreateScreenElement) { 
		(type) = (textElement) 
		(parent) = (music_track_anchor) 
		(id) = (music_track_text) 
		(text) = <current_track_text> 
		(font) = (dialog) 
		(just) = [ (right) (top) ] 
		(scale) = 0.80000001192 
		(pos) = PAIR(4.00000000000, 23.00000000000) 
		(rgba) = <off_rgba> 
		(alpha) = 0.80000001192 
	} 
	(GetScreenElementDims) (id) = (music_track_text) 
	IF ( <width> > 250 ) 
		<scale> = ( 0.80000001192 * 250.00000000000 / <width> ) 
		(DoScreenElementMorph) (id) = (music_track_text) (time) = 0 (scale) = <scale> 
	ENDIF 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (music_track_anchor) 
		(texture) = (kyron) 
		(just) = [ (center) (center) ] 
		(scale) = 1 
		(pos) = PAIR(14.00000000000, 15.00000000000) 
		(rgba) = <on_rgba> 
		(alpha) = 0.69999998808 
	} 
ENDSCRIPT

SCRIPT (spawn_update_music_track_text) 
	IF (ScreenElementExists) (id) = (music_track_anchor) 
		(RunScriptOnScreenElement) (id) = (music_track_anchor) (update_music_track_text) (params) = { <...> } 
	ENDIF 
ENDSCRIPT

SCRIPT (update_music_track_text) 
	IF (ScreenElementExists) (id) = (music_track_anchor) 
		IF (LevelIs) (load_skateshop) 
			(pos) = PAIR(900.00000000000, 320.00000000000) 
		ELSE 
			(pos) = PAIR(900.00000000000, 320.00000000000) 
		ENDIF 
		(DoScreenElementMorph) (id) = (music_track_anchor) (pos) = <pos> (time) = 0.30000001192 
		(wait) 0.30000001192 (seconds) 
	ELSE 
		RETURN 
	ENDIF 
	IF NOT (GotParam) (current_track) 
		(wait) 2.50000000000 (seconds) 
		(GetCurrentTrack) 
	ENDIF 
	(current_band_text) = ( ( (playlist_tracks) [ <current_track> ] ) . (band) ) 
	(GetUpperCaseString) <current_band_text> 
	(FormatText) (textName) = (current_track_text) "\'\'%t\'\'" (t) = ( ( (playlist_tracks) [ <current_track> ] ) . (track_title) ) 
	IF (ScreenElementExists) (id) = (music_band_text) 
		(SetScreenElementProps) (id) = (music_band_text) (text) = <uppercasestring> 
		(SetScreenElementProps) (id) = (music_track_text) (text) = <current_track_text> 
	ENDIF 
	(DoScreenElementMorph) (id) = (music_band_text) (time) = 0 (scale) = 1.00000000000 
	(GetScreenElementDims) (id) = (music_band_text) 
	IF ( <width> > 245 ) 
		<scale> = ( 245.00000000000 / <width> ) 
		(DoScreenElementMorph) (id) = (music_band_text) (time) = 0 (scale) = <scale> 
	ENDIF 
	(GetScreenElementDims) (id) = (music_band_text) 
	(DoScreenElementMorph) (id) = (music_band_text) (time) = 0 (scale) = 1.00000000000 
	IF ( <width> > 250 ) 
		<scale> = ( 250.00000000000 / <width> ) 
		(DoScreenElementMorph) (id) = (music_track_text) (time) = 0 (scale) = <scale> 
	ENDIF 
	IF (ScreenElementExists) (id) = (music_track_anchor) 
		IF (LevelIs) (load_skateshop) 
			(pos) = PAIR(575.00000000000, 320.00000000000) 
		ELSE 
			(pos) = PAIR(575.00000000000, 320.00000000000) 
		ENDIF 
		(DoScreenElementMorph) (id) = (music_track_anchor) (pos) = <pos> (time) = 0.30000001192 
	ENDIF 
ENDSCRIPT

SCRIPT (update_volume_bar) 
	(shaking) = 0 
	BEGIN 
		IF (ScreenElementExists) (id) = (volume_bar) 
			(GetValueFromVolume) (sfxvol) 
			(new_scale) = ( ( 0.75000000000 * <value> ) * PAIR(1.00000000000, 0.00000000000) + PAIR(0.00000000000, 0.50000000000) ) 
			(DoScreenElementMorph) (id) = (volume_bar) (scale) = <new_scale> (time) = 0.10000000149 
			(wait) 0.10000000149 (seconds) 
			IF ( <value> = 10 ) 
				(GetValueFromVolume) (cdvol) 
				IF ( <value> = 10 ) 
					IF ( <shaking> = 0 ) 
						(spawnscript) (shake_projector) (params) = { (id) = (boombox_anchor) (amplitude) = 5 (time) = 0.05000000075 } 
						(shaking) = 1 
					ENDIF 
				ELSE 
					(KillSpawnedScript) (name) = (shake_projector) 
					(shaking) = 0 
				ENDIF 
			ELSE 
				(KillSpawnedScript) (name) = (shake_projector) 
				(shaking) = 0 
			ENDIF 
		ELSE 
			BREAK 
		ENDIF 
	REPEAT 
ENDSCRIPT

SCRIPT (boombox_speaker_pulse) 
	BEGIN 
		(GetValueFromVolume) (cdvol) 
		(new_scale) = ( ( <value> / 10.00000000000 ) + 1.00000000000 ) 
		IF (ScreenElementExists) (id) = (speaker1) 
			IF ( <value> = 0 ) 
				(DoScreenElementMorph) (id) = (speaker1) (scale) = <new_scale> (relative_scale) (time) = 0.10000000149 
				(DoScreenElementMorph) (id) = (speaker2) (scale) = <new_scale> (relative_scale) (time) = 0.10000000149 
			ELSE 
				(DoScreenElementMorph) (id) = (speaker1) (scale) = <new_scale> (relative_scale) (time) = 0.10000000149 (alpha) = 0.60000002384 
				(DoScreenElementMorph) (id) = (speaker2) (scale) = <new_scale> (relative_scale) (time) = 0.10000000149 (alpha) = 0.60000002384 
			ENDIF 
		ELSE 
			BREAK 
		ENDIF 
		(wait) 0.10000000149 (seconds) 
		IF (ScreenElementExists) (id) = (speaker1) 
			(DoScreenElementMorph) (id) = (speaker1) (scale) = 1 (relative_scale) (time) = 0.10000000149 (alpha) = 0.10000000149 
			(DoScreenElementMorph) (id) = (speaker2) (scale) = 1 (relative_scale) (time) = 0.10000000149 (alpha) = 0.10000000149 
		ELSE 
			BREAK 
		ENDIF 
		(wait) 0.20000000298 (seconds) 
	REPEAT 
ENDSCRIPT

SCRIPT (sound_options_exit) 
	(KillSpawnedScript) (name) = (boombox_speaker_pulse) 
	(KillSpawnedScript) (name) = (update_volume_bar) 
	(KillSpawnedScript) (name) = (shake_projector) 
	(KillSpawnedScript) (name) = (chap_new_rotating_bg) 
	(KillSpawnedScript) (name) = (chap_new_rotating_bg_2) 
	IF (ScreenElementExists) (id) = (current_menu_anchor) 
		(DestroyScreenElement) (id) = (current_menu_anchor) 
	ENDIF 
	IF (GotParam) (just_remove) 
		RETURN 
	ENDIF 
	IF NOT (LevelIs) (load_skateshop) 
		(PauseMusic) 1 
		(create_options_menu) 
	ELSE 
		(PauseMusic) 0 
		(create_setup_options_menu) 
	ENDIF 
ENDSCRIPT

SCRIPT (sound_options_show_levels) 
	(FormatText) (ChecksumName) = (text_color) "%i_unhighlighted_text_color" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(GetValueFromVolume) (cdvol) 
	(FormatText) (textName) = (cdvol) "%v" (v) = <value> 
	(CreateScreenElement) { 
		(type) = (textElement) 
		(parent) = (menu_music_level) 
		(font) = (small) 
		(just) = [ (center) (top) ] 
		(pos) = PAIR(128.00000000000, -17.00000000000) 
		(text) = <cdvol> 
		(rgba) = <text_color> 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (menu_music_level) 
		(texture) = (left_arrow) 
		(rgba) = [ 128 128 128 0 ] 
		(pos) = PAIR(115.00000000000, -17.00000000000) 
		(just) = [ (right) (top) ] 
		(scale) = 0.75000000000 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (menu_music_level) 
		(texture) = (right_arrow) 
		(rgba) = [ 128 128 128 0 ] 
		(pos) = PAIR(143.00000000000, -17.00000000000) 
		(just) = [ (left) (top) ] 
		(scale) = 0.75000000000 
	} 
	(GetValueFromVolume) (sfxvol) 
	(FormatText) (textName) = (sfxvol) "%v" (v) = <value> 
	(CreateScreenElement) { 
		(type) = (textElement) 
		(parent) = (menu_sound_level) 
		(font) = (small) 
		(just) = [ (center) (top) ] 
		(pos) = PAIR(128.00000000000, -17.00000000000) 
		(text) = <sfxvol> 
		(rgba) = <text_color> 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (menu_sound_level) 
		(texture) = (left_arrow) 
		(rgba) = [ 128 128 128 0 ] 
		(pos) = PAIR(115.00000000000, -17.00000000000) 
		(just) = [ (right) (top) ] 
		(scale) = 0.75000000000 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (menu_sound_level) 
		(texture) = (right_arrow) 
		(rgba) = [ 128 128 128 0 ] 
		(pos) = PAIR(143.00000000000, -17.00000000000) 
		(just) = [ (left) (top) ] 
		(scale) = 0.75000000000 
	} 
	(SetScreenElementProps) { 
		(id) = (menu_music_level) 
		(event_handlers) = [ { (pad_left) (menu_turn_music_down) } 
			{ (pad_right) (menu_turn_music_up) } 
		] 
		(replace_handlers) 
	} 
	(SetScreenElementProps) { 
		(id) = (menu_sound_level) 
		(event_handlers) = [ { (pad_left) (menu_turn_sound_down) } 
			{ (pad_right) (menu_turn_sound_up) } 
		] 
		(replace_handlers) 
	} 
ENDSCRIPT

SCRIPT (toggle_song_order) 
	IF NOT (GetGlobalFlag) (flag) = (SOUNDS_SONGORDER_RANDOM) 
		(SetScreenElementProps) (id) = { (menu_song_order) (child) = 3 } (text) = "Random" 
		(PlaySongsRandomly) 
		(SetGlobalFlag) (flag) = (SOUNDS_SONGORDER_RANDOM) 
	ELSE 
		(SetScreenElementProps) (id) = { (menu_song_order) (child) = 3 } (text) = "In Order" 
		(PlaySongsInOrder) 
		(UnsetGlobalFlag) (flag) = (SOUNDS_SONGORDER_RANDOM) 
	ENDIF 
ENDSCRIPT

SCRIPT (toggle_special_sounds) 
	(FormatText) (ChecksumName) = (check_rgba) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	IF NOT (GetGlobalFlag) (flag) = (SOUNDS_SPECIALSOUNDS_OFF) 
		(SetScreenElementProps) (id) = (menu_sound_special_chk) (rgba) = [ 0 0 0 0 ] 
		(SetGlobalFlag) (flag) = (SOUNDS_SPECIALSOUNDS_OFF) 
	ELSE 
		(SetScreenElementProps) (id) = (menu_sound_special_chk) (rgba) = <check_rgba> 
		(UnsetGlobalFlag) (flag) = (SOUNDS_SPECIALSOUNDS_OFF) 
		(PlaySound) (HUD_specialtrickAA) (vol) = 200 (pitch) = 75 
	ENDIF 
ENDSCRIPT

SCRIPT (menu_music_level_focus) 
	(PauseMusic) 0 
	(menu_sound_level_focus) { (music_level) = <music_level> <...> } 
ENDSCRIPT

SCRIPT (menu_music_level_unfocus) 
	(menu_sound_level_unfocus) <...> 
	(PauseMusic) 1 
ENDSCRIPT

SCRIPT (menu_music_special_focus) 
	(PauseMusic) 0 
	(main_theme_focus) 
ENDSCRIPT

SCRIPT (menu_music_special_unfocus) 
	(main_theme_unfocus) 
	(PauseMusic) 1 
ENDSCRIPT

SCRIPT (skip_track_focus) 
	(PauseMusic) 0 
	(main_theme_focus) <...> 
ENDSCRIPT

SCRIPT (skip_track_unfocus) 
	(main_theme_unfocus) <...> 
	(PauseMusic) 1 
ENDSCRIPT

SCRIPT (menu_sound_level_focus) 
	(GetTags) 
	(FormatText) (ChecksumName) = (arrow_color) "%i_unhighlighted_text_color" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(main_theme_focus) 
	IF (GotParam) (music_level) 
		(GetValueFromVolume) (cdvol) 
	ELSE 
		(GetValueFromVolume) (sfxvol) 
	ENDIF 
	(printf) <value> 
	IF ( <value> = 0 ) 
		(SetScreenElementProps) { (id) = { <id> (child) = 5 } (rgba) = [ 128 128 128 0 ] } 
	ELSE 
		(SetScreenElementProps) { (id) = { <id> (child) = 5 } (rgba) = <arrow_color> } 
	ENDIF 
	IF ( <value> = 10 ) 
		(SetScreenElementProps) { (id) = { <id> (child) = 6 } (rgba) = [ 128 128 128 0 ] } 
	ELSE 
		(SetScreenElementProps) { (id) = { <id> (child) = 6 } (rgba) = <arrow_color> } 
	ENDIF 
ENDSCRIPT

SCRIPT (menu_sound_level_unfocus) 
	(GetTags) 
	(main_theme_unfocus) 
	(SetScreenElementProps) { (id) = { <id> (child) = 5 } (rgba) = [ 128 128 128 0 ] } 
	(SetScreenElementProps) { (id) = { <id> (child) = 6 } (rgba) = [ 128 128 128 0 ] } 
ENDSCRIPT

SCRIPT (menu_turn_music_down) 
	(GetTags) 
	(GetValueFromVolume) (cdvol) 
	IF ( <value> > 0 ) 
		(SetScreenElementProps) (id) = { <id> (child) = 6 } (rgba) = [ 128 128 128 128 ] 
		<value> = ( <value> - 1 ) 
		(sound_options_set_level) (level) = <value> (id) = (menu_music_level) (type) = (cdvol) 
		(menu_horiz_blink_arrow) (arrow_id) = { <id> (child) = 5 } 
	ENDIF 
	IF ( <value> = 0 ) 
		(SetScreenElementProps) (id) = { <id> (child) = 5 } (rgba) = [ 128 128 128 0 ] 
	ENDIF 
ENDSCRIPT

SCRIPT (menu_turn_music_up) 
	(GetTags) 
	(GetValueFromVolume) (cdvol) 
	IF ( <value> < 10 ) 
		(SetScreenElementProps) (id) = { <id> (child) = 5 } (rgba) = [ 128 128 128 128 ] 
		<value> = ( <value> + 1 ) 
		(sound_options_set_level) (level) = <value> (id) = (menu_music_level) (type) = (cdvol) 
		(menu_horiz_blink_arrow) (arrow_id) = { <id> (child) = 6 } 
	ENDIF 
	IF ( <value> = 10 ) 
		(SetScreenElementProps) (id) = { <id> (child) = 6 } (rgba) = [ 128 128 128 0 ] 
	ENDIF 
	IF ( <value> = 1 ) 
		(SetCDToMusic) 
		(printf) "SetCDToMusic" 
	ENDIF 
ENDSCRIPT

SCRIPT (menu_turn_sound_down) 
	(GetTags) 
	(GetValueFromVolume) (sfxvol) 
	IF ( <value> > 0 ) 
		(SetScreenElementProps) (id) = { <id> (child) = 6 } (rgba) = [ 128 128 128 128 ] 
		<value> = ( <value> - 1 ) 
		(sound_options_set_level) (level) = <value> (id) = (menu_sound_level) (type) = (sfxvol) 
		(menu_horiz_blink_arrow) (arrow_id) = { <id> (child) = 5 } 
		(PlaySound) (ollieconc) (vol) = 70 
	ENDIF 
	IF ( <value> = 0 ) 
		(SetScreenElementProps) (id) = { <id> (child) = 5 } (rgba) = [ 128 128 128 0 ] 
	ENDIF 
ENDSCRIPT

SCRIPT (menu_turn_sound_up) 
	(GetTags) 
	(GetValueFromVolume) (sfxvol) 
	IF ( <value> < 10 ) 
		(SetScreenElementProps) (id) = { <id> (child) = 5 } (rgba) = [ 128 128 128 128 ] 
		<value> = ( <value> + 1 ) 
		(sound_options_set_level) (level) = <value> (id) = (menu_sound_level) (type) = (sfxvol) 
		(menu_horiz_blink_arrow) (arrow_id) = { <id> (child) = 6 } 
		(PlaySound) (ollieconc) (vol) = 70 
	ENDIF 
	IF ( <value> = 10 ) 
		(SetScreenElementProps) (id) = { <id> (child) = 6 } (rgba) = [ 128 128 128 0 ] 
	ENDIF 
ENDSCRIPT

SCRIPT (sound_options_set_level) 
	(FormatText) (textName) = (vol) "%v" (v) = <level> 
	(SetScreenElementProps) { 
		(id) = { <id> (child) = 4 } 
		(text) = <vol> 
	} 
	<level> = ( <level> * 10 ) 
	SWITCH <type> 
		CASE (cdvol) 
			(SetMusicVolume) <level> 
		CASE (sfxvol) 
			(SetSfxVolume) <level> 
	ENDSWITCH 
ENDSCRIPT

SCRIPT (focus_skip_track) 
	(do_scale_up) 
	(PauseMusic) 0 
ENDSCRIPT

SCRIPT (unfocus_skip_track) 
	(do_scale_down) 
	(PauseMusic) 1 
ENDSCRIPT

SCRIPT (skip_track) 
	(skiptrack) 
ENDSCRIPT

SCRIPT (pulse_item) 
	(DoMorph) (time) = 0.05000000075 (scale) = 0.89999997616 
	(DoMorph) (time) = 0.05000000075 (scale) = 1.00000000000 
ENDSCRIPT

SCRIPT (change_music_mode) 
	(DoMorph) (time) = 0.10000000149 (scale) = 0.89999997616 
	(DoMorph) (time) = 0.10000000149 (scale) = 1.20000004768 
	(DoMorph) (time) = 0.10000000149 (scale) = 1 
	IF (IsTrue) (ALWAYSPLAYMUSIC) 
		(change) (ALWAYSPLAYMUSIC) = 0 
		(SetScreenElementProps) (text) = "Music Mode: Goals Only" (id) = (menu_change_musicmode) 
	ELSE 
		(change) (ALWAYSPLAYMUSIC) = 1 
		(SetScreenElementProps) (text) = "Music Mode: Always On" (id) = (menu_change_musicmode) 
	ENDIF 
ENDSCRIPT

SCRIPT (create_playlist_menu) 
	(FormatText) (ChecksumName) = (on_rgba) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	IF NOT (cd) 
		IF NOT ( (testmusicfromhost) = 1 ) 
			RETURN 
		ENDIF 
	ENDIF 
	IF (ObjectExists) (id) = (current_menu_anchor) 
		(DestroyScreenElement) (id) = (current_menu_anchor) 
	ENDIF 
	(SetScreenElementLock) (id) = (root_window) (off) 
	(CreateScreenElement) { 
		(type) = (containerElement) 
		(parent) = (root_window) 
		(id) = (playlist_bg_anchor) 
		(dims) = PAIR(640.00000000000, 480.00000000000) 
		(pos) = PAIR(320.00000000000, 240.00000000000) 
	} 
	(AssignAlias) (id) = (playlist_bg_anchor) (alias) = (current_menu_anchor) 
	(create_helper_text) { (helper_text_elements) = [ { (text) = "\\b7/\\b4 = Select" } 
			{ (text) = "\\bn = Back" } 
			{ (text) = "\\bm = Toggle" } 
			{ (text) = "\\bo = Preview Track" } 
		] 
	} 
	(kill_start_key_binding) 
	IF (LevelIs) (load_skateshop) 
		(build_top_and_bottom_blocks) 
		(make_mainmenu_3d_plane) 
	ENDIF 
	(FormatText) (ChecksumName) = (title_icon) "%i_sound" (i) = ( (THEME_PREFIXES) [ (current_theme_prefix) ] ) 
	(build_theme_sub_title) (title) = "PLAYLIST" (title_icon) = <title_icon> 
	IF NOT (LevelIs) (load_skateshop) 
		(FormatText) (ChecksumName) = (paused_icon) "%i_paused_icon" (i) = ( (THEME_PREFIXES) [ (current_theme_prefix) ] ) 
		(build_theme_box_icons) (icon_texture) = <paused_icon> 
		(build_grunge_piece) 
	ENDIF 
	(build_top_bar) (pos) = PAIR(-400.00000000000, 62.00000000000) 
	(CreateScreenElement) { 
		(type) = (containerElement) 
		(parent) = (playlist_bg_anchor) 
		(id) = (playlist_menu) 
		(dims) = PAIR(640.00000000000, 480.00000000000) 
		(pos) = PAIR(320.00000000000, 620.00000000000) 
	} 
	(theme_background) (width) = 7.00000000000 (pos) = PAIR(320.00000000000, 85.00000000000) (num_parts) = 10.50000000000 (parent) = (playlist_menu) 
	(CreateScreenElement) { 
		(type) = (containerElement) 
		(parent) = (playlist_menu) 
		(id) = (playlist_top_anchor) 
		(dims) = PAIR(640.00000000000, 480.00000000000) 
		(pos) = PAIR(320.00000000000, 240.00000000000) 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (playlist_menu) 
		(texture) = (white2) 
		(scale) = PAIR(71.00000000000, 6.00000000000) 
		(pos) = PAIR(36.00000000000, 90.00000000000) 
		(rgba) = [ 0 0 0 128 ] 
		(alpha) = 0.80000001192 
		(just) = [ (left) (top) ] 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (playlist_top_anchor) 
		(id) = (left_arrow) 
		(texture) = (left_arrow) 
		(pos) = PAIR(55.00000000000, 113.00000000000) 
		(just) = [ (right) (center) ] 
		(z_priority) = 50 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (playlist_top_anchor) 
		(id) = (right_arrow) 
		(texture) = (right_arrow) 
		(pos) = PAIR(580.00000000000, 113.00000000000) 
		(just) = [ (left) (center) ] 
		(z_priority) = 5 
	} 
	(CreateScreenElement) { 
		(type) = (hmenu) 
		(parent) = (playlist_top_anchor) 
		(id) = (playlist_hmenu) 
		(pos) = PAIR(320.00000000000, 140.00000000000) 
		(event_handlers) = [ { (pad_down) (focus_playlist_vmenu) } 
			{ (pad_back) (generic_menu_pad_back) (params) = { (callback) = (exit_playlist_menu) } } 
			{ (pad_left) (generic_menu_scroll_sideways_sound) (params) = { } } 
			{ (pad_right) (generic_menu_scroll_sideways_sound) (params) = { } } 
			{ (pad_left) (set_which_arrow) (params) = { (arrow) = (left_arrow) } } 
			{ (pad_right) (set_which_arrow) (params) = { (arrow) = (right_arrow) } } 
		] 
	} 
	(playlist_hmenu_add_item) { (text) = "Punk" (genre) = 0 } 
	(playlist_hmenu_add_item) { (text) = "Hip Hop" (genre) = 1 } 
	(playlist_hmenu_add_item) { (text) = "Rock/Other" (genre) = 2 } 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (playlist_menu) 
		(texture) = (white2) 
		(scale) = PAIR(71.00000000000, 0.10000000149) 
		(pos) = PAIR(36.00000000000, 138.00000000000) 
		(rgba) = <on_rgba> 
		(just) = [ (left) (top) ] 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (playlist_menu) 
		(texture) = (white2) 
		(scale) = PAIR(71.00000000000, 3.00000000000) 
		(pos) = PAIR(36.00000000000, 138.00000000000) 
		(rgba) = [ 0 0 0 128 ] 
		(alpha) = 0.80000001192 
		(just) = [ (left) (top) ] 
		(z_priority) = 2 
	} 
	(CreateScreenElement) { 
		(type) = (containerElement) 
		(parent) = (playlist_menu) 
		(id) = (playlist_bottom_anchor) 
		(dims) = PAIR(640.00000000000, 480.00000000000) 
		(pos) = PAIR(320.00000000000, 240.00000000000) 
		(alpha) = 0.50000000000 
	} 
	(CreateScreenElement) { 
		(type) = (textElement) 
		(parent) = (playlist_bottom_anchor) 
		(text) = "Band" 
		(font) = (dialog) 
		(scale) = 1 
		(rgba) = <on_rgba> 
		(pos) = PAIR(75.00000000000, 150.00000000000) 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (playlist_menu) 
		(texture) = (white2) 
		(scale) = PAIR(0.80000001192, 28.50000000000) 
		(pos) = PAIR(210.00000000000, 160.00000000000) 
		(rgba) = [ 0 0 0 128 ] 
		(alpha) = 0.80000001192 
		(just) = [ (left) (top) ] 
		(z_priority) = 2 
	} 
	(CreateScreenElement) { 
		(type) = (textElement) 
		(parent) = (playlist_bottom_anchor) 
		(text) = "Song" 
		(font) = (dialog) 
		(scale) = 1 
		(rgba) = <on_rgba> 
		(pos) = PAIR(245.00000000000, 150.00000000000) 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (playlist_menu) 
		(texture) = (white2) 
		(scale) = PAIR(0.80000001192, 28.50000000000) 
		(pos) = PAIR(460.00000000000, 160.00000000000) 
		(rgba) = [ 0 0 0 128 ] 
		(alpha) = 0.80000001192 
		(just) = [ (left) (top) ] 
		(z_priority) = 2 
	} 
	(CreateScreenElement) { 
		(type) = (textElement) 
		(parent) = (playlist_bottom_anchor) 
		(text) = "Genre" 
		(font) = (dialog) 
		(scale) = 1 
		(rgba) = <on_rgba> 
		(pos) = PAIR(505.00000000000, 150.00000000000) 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (playlist_menu) 
		(texture) = (white2) 
		(scale) = PAIR(0.80000001192, 28.50000000000) 
		(pos) = PAIR(555.00000000000, 160.00000000000) 
		(rgba) = [ 0 0 0 128 ] 
		(alpha) = 0.80000001192 
		(just) = [ (left) (top) ] 
		(z_priority) = 2 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (playlist_bottom_anchor) 
		(id) = (view_gaps_menu_up_arrow) 
		(texture) = (up_arrow) 
		(pos) = PAIR(320.00000000000, 142.00000000000) 
		(just) = [ (left) (top) ] 
		(z_priority) = 5 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = (playlist_bottom_anchor) 
		(id) = (view_gaps_menu_down_arrow) 
		(texture) = (down_arrow) 
		(pos) = PAIR(320.00000000000, 370.00000000000) 
		(just) = [ (left) (top) ] 
		(z_priority) = 3 
	} 
	(CreateScreenElement) { 
		(type) = (VScrollingMenu) 
		(parent) = (playlist_bottom_anchor) 
		(id) = (playlist_scrolling_menu) 
		(dims) = PAIR(640.00000000000, 200.00000000000) 
		(pos) = PAIR(320.00000000000, 180.00000000000) 
		(just) = [ (center) (top) ] 
		(internal_just) = [ (center) (top) ] 
	} 
	(CreateScreenElement) { 
		(type) = (VMenu) 
		(parent) = (playlist_scrolling_menu) 
		(id) = (playlist_vmenu) 
		(pos) = PAIR(0.00000000000, 0.00000000000) 
		(just) = [ (left) (top) ] 
		(internal_just) = [ (left) (top) ] 
		(dont_allow_wrap) 
		(event_handlers) = [ 
			{ (pad_up) (focus_playlist_hmenu) } 
			{ (pad_up) (set_which_arrow) (params) = { (arrow) = (view_gaps_menu_up_arrow) } } 
			{ (pad_down) (set_which_arrow) (params) = { (arrow) = (view_gaps_menu_down_arrow) } } 
			{ (pad_back) (generic_menu_pad_back) (params) = { (callback) = (exit_playlist_menu) } } 
			{ (pad_up) (generic_menu_up_or_down_sound) (params) = { (up) } } 
			{ (pad_down) (generic_menu_up_or_down_sound) (params) = { (down) } } 
		] 
	} 
	(AssignAlias) (id) = (playlist_vmenu) (alias) = (current_menu) 
	(kill_start_key_binding) 
	(add_tracks_to_menu) 
	(wait) 2 (gameframes) 
	(SetScreenElementProps) (id) = (playlist_scrolling_menu) (reset_window_top) 
	IF (LevelIs) (load_skateshop) 
		(end_pos) = PAIR(320.00000000000, 215.00000000000) 
	ENDIF 
	(finish_themed_sub_menu) (menu) = (playlist_menu) (end_pos) = <end_pos> 
	(FireEvent) (type) = (focus) (target) = (playlist_hmenu) 
ENDSCRIPT

SCRIPT (exit_playlist_menu) 
	IF (ObjectExists) (id) = (current_menu_anchor) 
		(DestroyScreenElement) (id) = (current_menu_anchor) 
	ENDIF 
	IF (GotParam) (from_options) 
		(create_sound_options_menu) (from_options) 
	ELSE 
		(create_sound_options_menu) 
	ENDIF 
ENDSCRIPT

SCRIPT (add_tracks_to_menu) 
	(GetArraySize) (playlist_tracks) 
	(index) = 0 
	BEGIN 
		IF ( ( <index> = (locked_track1) ) | ( <index> = (locked_track2) ) ) 
			IF (GetGlobalFlag) (flag) = (KISS_SONGS_UNLOCKED) 
				(playlist_menu_add_item) { (index) = <index> } 
			ELSE 
				(CreateScreenElement) { 
					(type) = (containerElement) 
					(parent) = (current_menu) 
					(dims) = PAIR(0.00000000000, 0.00000000000) 
					(heap) = (topdown) 
					(not_focusable) 
				} 
			ENDIF 
		ELSE 
			(playlist_menu_add_item) { (index) = <index> } 
		ENDIF 
		<index> = ( <index> + 1 ) 
	REPEAT <array_size> 
ENDSCRIPT

SCRIPT (change_track_state) 
	(GetTags) 
	IF (TrackEnabled) <index> 
		(ChangeTrackState) <index> (off) 
		(PauseMusic) 1 
		IF (ScreenElementExists) (id) = { <id> (child) = 4 } 
			(DoScreenElementMorph) (id) = { <id> (child) = 4 } (alpha) = 0 
		ENDIF 
	ELSE 
		(ChangeTrackState) <index> (on) 
		IF (ScreenElementExists) (id) = { <id> (child) = 4 } 
			(DoScreenElementMorph) (id) = { <id> (child) = 4 } (alpha) = 1 
		ENDIF 
	ENDIF 
	(update_genre_checks) 
ENDSCRIPT

SCRIPT (is_genre_on) 
	(printf) "is_genre_on" 
	(on) = 1 
	(GetArraySize) (playlist_tracks) 
	(index) = 0 
	BEGIN 
		IF ( ( ( (playlist_tracks) [ <index> ] ) . (genre) ) = <genre> ) 
			IF ( ( <index> = (locked_track1) ) | ( <index> = (locked_track2) ) ) 
				IF (GetGlobalFlag) (flag) = (KISS_SONGS_UNLOCKED) 
					IF NOT (TrackEnabled) <index> 
						(on) = 0 
						BREAK 
					ENDIF 
				ELSE 
				ENDIF 
			ELSE 
				IF NOT (TrackEnabled) <index> 
					(on) = 0 
					BREAK 
				ENDIF 
			ENDIF 
		ENDIF 
		(index) = ( <index> + 1 ) 
	REPEAT <array_size> 
	RETURN (on) = <on> 
ENDSCRIPT

SCRIPT (toggle_playlist_genre) (genre) = 0 
	(found_first) = 0 
	(GetArraySize) (playlist_tracks) 
	(index) = 0 
	BEGIN 
		IF ( ( ( (playlist_tracks) [ <index> ] ) . (genre) ) = <genre> ) 
			IF ( <found_first> = 0 ) 
				(found_first) = 1 
				IF (TrackEnabled) <index> 
					(toggle) = 0 
				ELSE 
					(toggle) = 1 
				ENDIF 
			ENDIF 
			IF ( <toggle> = 1 ) 
				IF (ScreenElementExists) (id) = { (playlist_vmenu) (child) = { <index> (child) = 4 } } 
					(ChangeTrackState) <index> (on) 
					(DoScreenElementMorph) (id) = { (playlist_vmenu) (child) = { <index> (child) = 4 } } (alpha) = 1 
				ENDIF 
			ELSE 
				IF (ScreenElementExists) (id) = { (playlist_vmenu) (child) = { <index> (child) = 4 } } 
					(ChangeTrackState) <index> (off) 
					(DoScreenElementMorph) (id) = { (playlist_vmenu) (child) = { <index> (child) = 4 } } (alpha) = 0 
				ENDIF 
			ENDIF 
		ENDIF 
		(index) = ( <index> + 1 ) 
	REPEAT <array_size> 
	IF NOT (GetGlobalFlag) (flag) = (KISS_SONGS_UNLOCKED) 
		(ChangeTrackState) (locked_track1) (off) 
		(ChangeTrackState) (locked_track2) (off) 
	ENDIF 
	(PlaySound) (DE_MenuSelect) (vol) = 100 
	(update_genre_checks) 
ENDSCRIPT

SCRIPT (preview_music_track) 
	(GetTags) 
	IF NOT (TrackEnabled) <index> 
		(ChangeTrackState) <index> (on) 
		IF (ScreenElementExists) (id) = { <id> (child) = 4 } 
			(DoScreenElementMorph) (id) = { <id> (child) = 4 } (alpha) = 1 
		ENDIF 
	ENDIF 
	IF (MusicIsPaused) 
		(PauseMusic) 0 
		(PlayTrack) <index> 
	ELSE 
		(PauseMusic) 1 
	ENDIF 
	(update_genre_checks) 
ENDSCRIPT

SCRIPT (playlist_hmenu_add_item) 
	(FormatText) (ChecksumName) = (off_rgba) "%i_UNHIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	SWITCH <genre> 
		CASE 0 
			(dims) = PAIR(130.00000000000, 50.00000000000) 
		CASE 1 
			(dims) = PAIR(165.00000000000, 50.00000000000) 
		CASE 2 
			(dims) = PAIR(220.00000000000, 50.00000000000) 
		DEFAULT 
			RETURN 
	ENDSWITCH 
	(CreateScreenElement) { 
		(type) = (containerElement) 
		(parent) = (playlist_hmenu) 
		(dims) = <dims> 
		(event_handlers) = [ { (pad_choose) (toggle_playlist_genre) (params) = { (genre) = <genre> } } 
			{ (focus) (playlist_hmenu_focus) } 
			{ (unfocus) (playlist_hmenu_unfocus) } 
		] 
	} 
	(anchor_id) = <id> 
	(CreateScreenElement) { 
		(type) = (textElement) 
		(parent) = <anchor_id> 
		(z_priority) = 50 
		(font) = (small) 
		(text) = <text> 
		(rgba) = <off_rgba> 
		(scale) = 1.50000000000 
		(just) = [ (left) (center) ] 
	} 
	(GetStackedScreenElementPos) (X) (id) = <id> (offset) = PAIR(4.00000000000, 13.00000000000) 
	(is_genre_on) (genre) = <genre> 
	IF ( <on> = 1 ) 
		(alpha) = 1 
	ELSE 
		(alpha) = 0 
	ENDIF 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = <anchor_id> 
		(texture) = (checkmark) 
		(pos) = <pos> 
		(alpha) = <alpha> 
		(just) = [ (left) (center) ] 
		(rgba) = <off_rgba> 
		(z_priority) = 5 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = <anchor_id> 
		(texture) = (checkbox) 
		(pos) = ( <pos> + PAIR(0.00000000000, 5.00000000000) ) 
		(just) = [ (left) (center) ] 
		(scale) = 0.50000000000 
		(rgba) = <off_rgba> 
		(z_priority) = 5 
	} 
ENDSCRIPT

SCRIPT (update_genre_checks) 
	(genre) = 0 
	BEGIN 
		(is_genre_on) (genre) = <genre> 
		IF ( <on> = 1 ) 
			(alpha) = 1 
		ELSE 
			(alpha) = 0 
		ENDIF 
		(DoScreenElementMorph) (id) = { (playlist_hmenu) (child) = { <genre> (child) = 1 } } (alpha) = <alpha> 
		(genre) = ( <genre> + 1 ) 
	REPEAT 3 
ENDSCRIPT

SCRIPT (playlist_hmenu_focus) 
	(GetTags) 
	(FormatText) (ChecksumName) = (on_rgba) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(DoScreenElementMorph) { (id) = { <id> (child) = 0 } (rgba) = <on_rgba> } 
	(DoScreenElementMorph) { (id) = { <id> (child) = 1 } (rgba) = <on_rgba> } 
	(playlist_hmenu) : (GetTags) 
	IF (GotParam) (arrow_id) 
		(blink_arrow) { (id) = <arrow_id> } 
	ENDIF 
ENDSCRIPT

SCRIPT (playlist_hmenu_unfocus) 
	(GetTags) 
	(FormatText) (ChecksumName) = (off_rgba) "%i_UNHIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(DoScreenElementMorph) { (id) = { <id> (child) = 0 } (rgba) = <off_rgba> } 
	(DoScreenElementMorph) { (id) = { <id> (child) = 1 } (rgba) = <off_rgba> } 
	(playlist_hmenu) : (GetTags) 
	IF (GotParam) (arrow_id) 
		(blink_arrow) { (id) = <arrow_id> } 
	ENDIF 
ENDSCRIPT

SCRIPT (focus_playlist_hmenu) 
	(GetTags) 
	IF ( <tag_selected_id> = (top_item) ) 
		(FireEvent) (type) = (unfocus) (target) = (playlist_vmenu) 
		(DoScreenElementMorph) (id) = (playlist_bottom_anchor) (alpha) = 0.50000000000 
		(FireEvent) (type) = (focus) (target) = (playlist_hmenu) 
		(DoScreenElementMorph) (id) = (playlist_top_anchor) (alpha) = 1.00000000000 
	ENDIF 
ENDSCRIPT

SCRIPT (focus_playlist_vmenu) 
	(FireEvent) (type) = (unfocus) (target) = (playlist_hmenu) 
	(DoScreenElementMorph) (id) = (playlist_top_anchor) (alpha) = 0.50000000000 
	(FireEvent) (type) = (focus) (target) = (playlist_vmenu) 
	(DoScreenElementMorph) (id) = (playlist_bottom_anchor) (alpha) = 1.00000000000 
ENDSCRIPT

SCRIPT (playlist_menu_add_item) (highlight_bar_scale) = PAIR(4.34999990463, 0.50000000000) (highlight_bar_pos) = PAIR(321.00000000000, 0.00000000000) 
	(FormatText) (ChecksumName) = (off_rgba) "%i_UNHIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(FormatText) (ChecksumName) = (bar_rgba) "%i_HIGHLIGHT_BAR_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	IF ( <index> = 0 ) 
		(id) = (top_item) 
	ENDIF 
	(CreateScreenElement) { 
		(type) = (containerElement) 
		(parent) = (current_menu) 
		(id) = <id> 
		(dims) = PAIR(500.00000000000, 20.00000000000) 
		(event_handlers) = [ { (focus) (playlist_menu_focus) (params) = <focus_params> } 
			{ (unfocus) (playlist_menu_unfocus) } 
			{ (pad_choose) (change_track_state) (params) = { (index) = <index> } } 
			{ (pad_choose) (generic_menu_pad_choose_sound) } 
			{ (pad_start) (change_track_state) (params) = { (index) = <index> } } 
			{ (pad_start) (generic_menu_pad_choose_sound) } 
			{ (pad_option) (preview_music_track) (params) = { (index) = <index> } } 
		] 
		(heap) = (topdown) 
	} 
	<anchor_id> = <id> 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = <anchor_id> 
		(texture) = (de_highlight_bar) 
		(pos) = <highlight_bar_pos> 
		(scale) = <highlight_bar_scale> 
		(just) = [ (center) (center) ] 
		(rgba) = <bar_rgba> 
		(alpha) = 0 
		(z_priority) = 3 
		(heap) = (topdown) 
	} 
	(band) = ( ( (playlist_tracks) [ <index> ] ) . (band) ) 
	(track_title) = ( ( (playlist_tracks) [ <index> ] ) . (track_title) ) 
	(genre) = ( ( (playlist_tracks) [ <index> ] ) . (genre) ) 
	(CreateScreenElement) { 
		(type) = (textElement) 
		(parent) = <anchor_id> 
		(font) = (dialog) 
		(text) = <band> 
		(pos) = PAIR(55.00000000000, 0.00000000000) 
		(just) = [ (left) (center) ] 
		(rgba) = <off_rgba> 
		(scale) = 0.69999998808 
		(heap) = (topdown) 
	} 
	(CreateScreenElement) { 
		(type) = (textElement) 
		(parent) = <anchor_id> 
		(font) = (dialog) 
		(text) = <track_title> 
		(pos) = PAIR(220.00000000000, 0.00000000000) 
		(just) = [ (left) (center) ] 
		(rgba) = <off_rgba> 
		(scale) = 0.69999998808 
		(heap) = (topdown) 
	} 
	SWITCH <genre> 
		CASE 0 
			(genre_text) = "Punk" 
		CASE 1 
			(genre_text) = "Hip Hop" 
		CASE 2 
			(genre_text) = "Rock/Other" 
		DEFAULT 
			(genre_text) = "" 
	ENDSWITCH 
	(CreateScreenElement) { 
		(type) = (textElement) 
		(parent) = <anchor_id> 
		(font) = (dialog) 
		(text) = <genre_text> 
		(pos) = PAIR(510.00000000000, 0.00000000000) 
		(just) = [ (center) (center) ] 
		(rgba) = <off_rgba> 
		(scale) = 0.69999998808 
		(heap) = (topdown) 
	} 
	IF (TrackEnabled) <index> 
		(alpha) = 1 
	ELSE 
		(alpha) = 0 
	ENDIF 
	(checkboxpos) = PAIR(568.00000000000, -4.00000000000) 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = <anchor_id> 
		(texture) = (checkmark) 
		(pos) = <checkboxpos> 
		(alpha) = <alpha> 
		(just) = [ (left) (center) ] 
		(rgba) = <off_rgba> 
		(z_priority) = 5 
		(heap) = (topdown) 
	} 
	(CreateScreenElement) { 
		(type) = (SpriteElement) 
		(parent) = <anchor_id> 
		(texture) = (checkbox) 
		(pos) = ( <checkboxpos> + PAIR(0.00000000000, 5.00000000000) ) 
		(just) = [ (left) (center) ] 
		(scale) = 0.50000000000 
		(rgba) = <off_rgba> 
		(z_priority) = 5 
		(heap) = (topdown) 
	} 
ENDSCRIPT

SCRIPT (playlist_menu_focus) 
	(GetTags) 
	(FormatText) (ChecksumName) = (on_rgba) "%i_HIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(DoScreenElementMorph) (id) = { <id> (child) = 0 } (alpha) = 1 
	(index) = 1 
	BEGIN 
		IF (ScreenElementExists) (id) = { <id> (child) = <index> } 
			(DoScreenElementMorph) { (id) = { <id> (child) = <index> } (rgba) = <on_rgba> } 
		ELSE 
			BREAK 
		ENDIF 
		(index) = ( <index> + 1 ) 
	REPEAT 4 
	(playlist_vmenu) : (GetTags) 
	IF (GotParam) (arrow_id) 
		(menu_vert_blink_arrow) { (id) = <arrow_id> } 
	ENDIF 
	(generic_menu_update_arrows) (menu_id) = (playlist_vmenu) (up_arrow_id) = (view_gaps_menu_up_arrow) (down_arrow_id) = (view_gaps_menu_down_arrow) 
ENDSCRIPT

SCRIPT (playlist_menu_unfocus) 
	(GetTags) 
	(FormatText) (ChecksumName) = (off_rgba) "%i_UNHIGHLIGHTED_TEXT_COLOR" (i) = ( (THEME_COLOR_PREFIXES) [ (current_theme_prefix) ] ) 
	(DoScreenElementMorph) (id) = { <id> (child) = 0 } (alpha) = 0 
	(index) = 1 
	BEGIN 
		IF (ScreenElementExists) (id) = { <id> (child) = <index> } 
			(DoScreenElementMorph) { (id) = { <id> (child) = <index> } (rgba) = <off_rgba> } 
		ELSE 
			BREAK 
		ENDIF 
		(index) = ( <index> + 1 ) 
	REPEAT 
	(PauseMusic) 1 
ENDSCRIPT

SCRIPT (create_soundtrack_menu) 
	(FormatText) (ChecksumName) = (title_icon) "%i_sound" (i) = ( (THEME_PREFIXES) [ (current_theme_prefix) ] ) 
	(make_new_themed_scrolling_menu) (title) = "SOUNDTRACKS" (title_icon) = <title_icon> 
	(SetScreenElementProps) { (id) = (sub_menu) 
		(event_handlers) = [ 
			{ (pad_back) (generic_menu_pad_back) (params) = { (callback) = (create_sound_options_menu) } } 
		] 
	} 
	(theme_menu_add_item) { (text) = "THUG Playlist" 
		(pad_choose_script) = (SetSoundtrack) 
		(pad_choose_params) = { (track) = "" } 
		(centered) 
		(no_bg) 
		(first_item) 
	} 
	IF (isxbox) 
		(GetNumSoundtracks) 
	ELSE 
		(numsoundtracks) = 0 
	ENDIF 
	IF ( <numsoundtracks> > 0 ) 
		(index) = 0 
		BEGIN 
			(GetSoundtrackName) <index> 
			(theme_menu_add_item) { (text) = <soundtrackname> 
				(pad_choose_script) = (SetSoundtrack) 
				(pad_choose_params) = { (track) = <soundtrackname> } 
				(centered) 
				(no_bg) 
				(max_width) = 380 
			} 
			<index> = ( <index> + 1 ) 
		REPEAT <numsoundtracks> 
	ENDIF 
	(theme_menu_add_item) { (text) = "Done" 
		(id) = (menu_done) 
		(pad_choose_script) = (create_sound_options_menu) 
		(centered) 
		(no_bg) 
		(last_item) 
	} 
	(finish_themed_scrolling_menu) 
ENDSCRIPT

SCRIPT (GetSoundtracks) 
	(GetNumSoundtracks) 
	(index) = 0 
	BEGIN 
		(GetSoundtrackName) <index> 
		(soundtracks) [ <index> ] = <soundtrackname> 
	REPEAT <numsoundtracks> 
	RETURN (soundtracks) 
ENDSCRIPT

SCRIPT (SetSoundtrack) 
	IF (isps2) 
		RETURN 
	ENDIF 
	(FormatText) (ChecksumName) = (trackchecksum) "%t" (t) = <track> 
	(printf) "soundtrack = %i" (i) = <trackchecksum> 
	(generic_menu_pad_choose) 
	(SoundtrackExists) (trackname) = <track> 
	(printf) "soundtrack index = %i" (i) = <index> 
	IF NOT ( (current_soundtrack) = <trackchecksum> ) 
		(StopMusic) 
	ENDIF 
	IF ( <index> = -1 ) 
		(printf) "use playlist" 
		(UseStandardSoundtrack) 
	ELSE 
		(printf) "use soundtrack" 
		(UseUserSoundtrack) <index> 
	ENDIF 
	(change) (current_soundtrack) = <trackchecksum> 
	IF (LevelIs) (load_skateshop) 
		(create_sound_options_menu) 
	ELSE 
		(create_sound_options_menu) (from_options) 
	ENDIF 
ENDSCRIPT

SCRIPT (SoundtrackExists) (trackname) = "" 
	(printf) "trackname = %t" (t) = <trackname> 
	(FormatText) (ChecksumName) = (tracknamesum) "%t" (t) = <trackname> 
	(GetNumSoundtracks) 
	IF NOT ( <numsoundtracks> = 0 ) 
		(index) = 0 
		BEGIN 
			(GetSoundtrackName) <index> 
			(printf) "soundtrackname = %t" (t) = <soundtrackname> 
			(FormatText) (ChecksumName) = (soundtracksum) "%s" (s) = <soundtrackname> 
			IF ( <tracknamesum> = <soundtracksum> ) 
				RETURN { (index) = <index> } 
			ENDIF 
			(index) = ( <index> + 1 ) 
		REPEAT <numsoundtracks> 
	ENDIF 
	RETURN { (index) = -1 } 
ENDSCRIPT

SCRIPT (set_loaded_soundtrack) 
	(printf) "set_loaded_soundtrack" 
	IF NOT (isxbox) 
		RETURN 
	ENDIF 
	(current_soundtrack_exists) 
	IF NOT ( (current_soundtrack) = () ) 
		(StopMusic) 
	ENDIF 
	IF ( <index> = -1 ) 
		(printf) "use playlist" 
		(UseStandardSoundtrack) 
	ELSE 
		(printf) "use soundtrack %i" (i) = <index> 
		(UseUserSoundtrack) <index> 
	ENDIF 
	(change) (current_soundtrack) = <trackchecksum> 
ENDSCRIPT

SCRIPT (current_soundtrack_exists) 
	(GetNumSoundtracks) 
	IF NOT ( <numsoundtracks> = 0 ) 
		(index) = 0 
		BEGIN 
			(GetSoundtrackName) <index> 
			(FormatText) (ChecksumName) = (soundtracksum) "%s" (s) = <soundtrackname> 
			IF ( (current_soundtrack) = <soundtracksum> ) 
				RETURN { (index) = <index> } 
			ENDIF 
			(index) = ( <index> + 1 ) 
		REPEAT <numsoundtracks> 
	ENDIF 
	RETURN { (index) = -1 } 
ENDSCRIPT


