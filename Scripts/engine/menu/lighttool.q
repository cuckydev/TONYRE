
(got_intial_lighting) = 0 
(current_lighting) = 0 
(step_multiplier) = 10 
(lock_color_values) = 0 
(toggle_dir0) = 1 
(toggle_dir1) = 1 
(amb_mod) = 0 
(dir0_head) = 0 
(dir0_pitch) = 0 
(dir0_mod) = 0 
(dir1_head) = 0 
(dir1_pitch) = 0 
(dir1_mod) = 0 
(lev_red) = 128 
(lev_green) = 128 
(lev_blue) = 128 
(lev_vct) = 128 
(lev_vcp) = 0 
(fog_red) = 128 
(fog_green) = 128 
(fog_blue) = 128 
(fog_alpha) = 0 
(fog_dist) = 0 
(fog_state) = 0 
(sky_red) = 128 
(sky_green) = 128 
(sky_blue) = 128 
(last_dir0_red) = 0 
(last_dir0_green) = 0 
(last_dir0_blue) = 0 
(last_dir1_red) = 0 
(last_dir1_green) = 0 
(last_dir1_blue) = 0 
(rain_or_snow) = 0 
(rain_rate) = 0 
(rain_height) = 2000 
(rain_frames) = 40 
(rain_length) = 100 
(rain_blend) = 6 
(rain_fixed) = 64 
(rain_red) = 0 
(rain_green) = 0 
(rain_blue) = 0 
(rain_alpha) = 0 
(rain_red2) = 0 
(rain_green2) = 0 
(rain_blue2) = 0 
(rain_alpha2) = 0 
(splash_red) = 255 
(splash_green) = 255 
(splash_blue) = 255 
(splash_alpha) = 255 
(splash_rate) = 0 
(splash_life) = 8 
(splash_size) = 16 
(splash_blend) = 6 
(splash_fixed) = 64 
(snow_rate) = 0 
(snow_height) = 500 
(snow_frames) = 254 
(snow_size) = 4 
(snow_blend) = 6 
(snow_fixed) = 64 
(snow_red) = 128 
(snow_green) = 128 
(snow_blue) = 128 
(snow_alpha) = 128 
SCRIPT (launch_lighting_tool) 
	(UnpauseGame) 
	(makeskatergoto) (freezeskater) 
	(SetAnalogStickActiveForMenus) 0 
	IF ( (got_intial_lighting) = 0 ) 
		(get_level_light_values) 
		(change) (got_intial_lighting) = 1 
	ELSE 
		<color> = ( (lev_red) + ( (lev_green) * 256 ) + ( (lev_blue) * 65536 ) ) 
		<sky> = ( (sky_red) + ( (sky_green) * 256 ) + ( (sky_blue) * 65536 ) ) 
		(lighting) (color) = <color> (sky) = <sky> 
	ENDIF 
	(removeparameter) (device_num) 
	(removeparameter) (controller_num) 
	(removeparameter) (type) 
	(create_lighting_tool) <...> 
ENDSCRIPT

SCRIPT (create_lighting_tool) 
	IF (ObjectExists) (id) = (current_menu_anchor) 
		(DestroyScreenElement) (id) = (current_menu_anchor) 
	ENDIF 
	(GetCurrentLightingValues) 
	SWITCH (current_lighting) 
		CASE 0 
			(menu_title) = "AMBIENT" 
		CASE 1 
			(menu_title) = "ONE" 
		CASE 2 
			(menu_title) = "TWO" 
		CASE 3 
			(menu_title) = "LEVEL" 
		CASE 4 
			(menu_title) = "FOG" 
		CASE 5 
			(menu_title) = "SKY" 
		CASE 6 
			(menu_title) = "TIME" 
		CASE 7 
			(menu_title) = "RAIN" 
		CASE 8 
			(menu_title) = "RAIN COLOR" 
		CASE 9 
			(menu_title) = "SPLASH COLOR" 
		CASE 10 
			(menu_title) = "SPLASH" 
		CASE 11 
			(menu_title) = "SNOW" 
		CASE 12 
			(menu_title) = "SNOW COLOR" 
		DEFAULT 
			(change) (current_lighting) = 0 
			(create_lighting_tool) 
	ENDSWITCH 
	(make_new_menu) { 
		(menu_id) = (light_menu) 
		(vmenu_id) = (light_vmenu) 
		(menu_title) = <menu_title> 
		(type) = (VMenu) 
		(dims) = PAIR(200, 200) 
		(padding_scale) = 0.94999998808 
		(pos) = PAIR(50.00000000000, 180.00000000000) 
	} 
	(create_helper_text) (helper_pos) = PAIR(320.00000000000, 410.00000000000) (helper_text_elements) = [ 
		{ (text) = "\\b7/\\b4 = Select" } 
		{ (text) = "\\b6/\\b5 = Adjust" } 
		{ (text) = "\\m1 = Back/Print Values" } 
	] 
	(create_helper_text) (anchor_id) = (helper_text_anchor2) (helper_text_elements) = [ 
		{ (text) = "\\m0 = toggle speed 1 or 10" } 
		{ (text) = "\\m3 = link / unlink color values" } 
	] 
	(removeparameter) (left) 
	(SetScreenElementProps) { 
		(id) = (light_vmenu) 
		(event_handlers) = [ { (pad_back) (print_light_values) (params) = <...> } 
			{ (pad_choose) (toggle_step_multiplier) (params) = { } } 
			{ (pad_square) (toggle_color_lock) (params) = { } } 
			{ (pad_l1) (next_light) (params) = { (left) <...> } } 
			{ (pad_r1) (next_light) (params) = { <...> } } 
			{ (pad_r2) (toggle_light_menu_focus) (params) = { (off) } } 
		] 
	} 
	IF ( (toggle_dir0) = 1 ) 
		(dir0_on_text) = "on" 
	ELSE 
		(dir0_on_text) = "off" 
	ENDIF 
	IF ( (toggle_dir1) = 1 ) 
		(dir1_on_text) = "on" 
	ELSE 
		(dir1_on_text) = "off" 
	ENDIF 
	IF ( (fog_state) = 1 ) 
		(fog_text) = "on" 
	ELSE 
		(fog_text) = "off" 
	ENDIF 
	SWITCH (current_lighting) 
		CASE 0 
			(make_light_tool_item) (text) = "red" (id) = (menu_red) (value) = <ambient_red> (pad_choose_script) = (incr_color_val) 
			(make_light_tool_item) (text) = "green" (id) = (menu_green) (value) = <ambient_green> (pad_choose_script) = (incr_color_val) 
			(make_light_tool_item) (text) = "blue" (id) = (menu_blue) (value) = <ambient_blue> (pad_choose_script) = (incr_color_val) 
			(make_light_tool_item) (text) = "mod" (id) = (menu_mod) (value) = (amb_mod) (pad_choose_script) = (incr_mod_val) 
		CASE 1 
			(make_light_tool_item) (text) = "heading" (id) = (menu_heading) (value) = (dir0_head) (pad_choose_script) = (incr_heading_val) 
			(make_light_tool_item) (text) = "pitch" (id) = (menu_pitch) (value) = (dir0_pitch) (pad_choose_script) = (incr_pitch_val) 
			(make_light_tool_item) (text) = "red" (id) = (menu_red) (value) = <red_0> (pad_choose_script) = (incr_color_val) 
			(make_light_tool_item) (text) = "green" (id) = (menu_green) (value) = <green_0> (pad_choose_script) = (incr_color_val) 
			(make_light_tool_item) (text) = "blue" (id) = (menu_blue) (value) = <blue_0> (pad_choose_script) = (incr_color_val) 
			(make_light_tool_item) (text) = "mod" (id) = (menu_mod) (value) = (dir0_mod) (pad_choose_script) = (incr_mod_val) 
			(make_light_tool_item) (text) = "light" (id) = (menu_onoff) (value_text) = <dir0_on_text> (pad_choose_script) = (toggle_dir_light_on_off) (params) = { (index) = 0 } 
		CASE 2 
			(make_light_tool_item) (text) = "heading" (id) = (menu_heading) (value) = (dir1_head) (pad_choose_script) = (incr_heading_val) 
			(make_light_tool_item) (text) = "pitch" (id) = (menu_pitch) (value) = (dir1_pitch) (pad_choose_script) = (incr_pitch_val) 
			(make_light_tool_item) (text) = "red" (id) = (menu_red) (value) = <red_1> (pad_choose_script) = (incr_color_val) 
			(make_light_tool_item) (text) = "green" (id) = (menu_green) (value) = <green_1> (pad_choose_script) = (incr_color_val) 
			(make_light_tool_item) (text) = "blue" (id) = (menu_blue) (value) = <blue_1> (pad_choose_script) = (incr_color_val) 
			(make_light_tool_item) (text) = "mod" (id) = (menu_mod) (value) = (dir1_mod) (pad_choose_script) = (incr_mod_val) 
			(make_light_tool_item) (text) = "light" (id) = (menu_onoff) (value_text) = <dir1_on_text> (pad_choose_script) = (toggle_dir_light_on_off) (params) = { (index) = 1 } 
		CASE 3 
			(make_light_tool_item) (text) = "red" (id) = (menu_red) (value) = (lev_red) (pad_choose_script) = (incr_color_val) 
			(make_light_tool_item) (text) = "green" (id) = (menu_green) (value) = (lev_green) (pad_choose_script) = (incr_color_val) 
			(make_light_tool_item) (text) = "blue" (id) = (menu_blue) (value) = (lev_blue) (pad_choose_script) = (incr_color_val) 
		CASE 4 
			(make_light_tool_item) (text) = "red" (id) = (menu_red) (value) = (fog_red) (pad_choose_script) = (incr_color_val) 
			(make_light_tool_item) (text) = "green" (id) = (menu_green) (value) = (fog_green) (pad_choose_script) = (incr_color_val) 
			(make_light_tool_item) (text) = "blue" (id) = (menu_blue) (value) = (fog_blue) (pad_choose_script) = (incr_color_val) 
			(make_light_tool_item) (text) = "alpha" (id) = (menu_alpha) (value) = (fog_alpha) (pad_choose_script) = (incr_color_val) 
			(make_light_tool_item) (text) = "distance" (id) = (menu_exp) (value) = (fog_dist) (pad_choose_script) = (incr_color_val) 
			(make_light_tool_item) (text) = "fog" (id) = (menu_fog) (value) = <fog_text> (pad_choose_script) = (incr_color_val) 
		CASE 5 
			(make_light_tool_item) (text) = "red" (id) = (menu_red) (value) = (sky_red) (pad_choose_script) = (incr_color_val) 
			(make_light_tool_item) (text) = "green" (id) = (menu_green) (value) = (sky_green) (pad_choose_script) = (incr_color_val) 
			(make_light_tool_item) (text) = "blue" (id) = (menu_blue) (value) = (sky_blue) (pad_choose_script) = (incr_color_val) 
		CASE 6 
			(SetScreenElementProps) { 
				(id) = (light_vmenu) 
				(event_handlers) = [ { (pad_choose) (null_script) (params) = { } } ] (replace_handlers) 
			} 
			(make_text_sub_menu_item) (text) = "Day" (id) = (menu_day) (pad_choose_script) = (reset_light_values) 
			(make_text_sub_menu_item) (text) = "Morning" (id) = (menu_morn) (pad_choose_script) = (set_to_tod_values) (pad_choose_params) = { (tod) = (tod_morning_params) } 
			(make_text_sub_menu_item) (text) = "Evening" (id) = (menu_even) (pad_choose_script) = (set_to_tod_values) (pad_choose_params) = { (tod) = (tod_evening_params) } 
			(make_text_sub_menu_item) (text) = "Night" (id) = (menu_night) (pad_choose_script) = (set_to_tod_values) (pad_choose_params) = { (tod) = (tod_night_params) } 
		CASE 7 
			IF ( (rain_or_snow) = 0 ) 
				(rain_text) = "rain" 
			ELSE 
				(rain_text) = "snow" 
			ENDIF 
			(make_light_tool_item) (text) = "Rain/Snow" (id) = (menu_rain) (value) = <rain_text> (pad_choose_script) = (toggle_rain_snow) 
			(make_light_tool_item) (text) = "rate" (id) = (menu_rate) (value) = (rain_rate) (pad_choose_script) = (incr_rain_val) 
			(make_light_tool_item) (text) = "frames" (id) = (menu_frames) (value) = (rain_frames) (pad_choose_script) = (incr_rain_val) 
			(make_light_tool_item) (text) = "height" (id) = (menu_height) (value) = (rain_height) (pad_choose_script) = (incr_rain_val) 
			(make_light_tool_item) (text) = "length" (id) = (menu_length) (value) = (rain_length) (pad_choose_script) = (incr_rain_val) 
			(get_rain_mode_string) 
			(make_light_tool_item) (text) = "blendmode" (id) = (menu_blend) (value_text) = <value_text> (pad_choose_script) = (incr_rain_val) 
			(make_light_tool_item) (text) = "fixalpha" (id) = (menu_fixed) (value) = (rain_fixed) (pad_choose_script) = (incr_rain_val) 
		CASE 8 
			(make_light_tool_item) (text) = "red" (id) = (menu_red) (value) = (rain_red) (pad_choose_script) = (incr_rain_color) (params) = { (rain) } 
			(make_light_tool_item) (text) = "green" (id) = (menu_green) (value) = (rain_green) (pad_choose_script) = (incr_rain_color) (params) = { (rain) } 
			(make_light_tool_item) (text) = "blue" (id) = (menu_blue) (value) = (rain_blue) (pad_choose_script) = (incr_rain_color) (params) = { (rain) } 
			(make_light_tool_item) (text) = "alpha" (id) = (menu_alpha) (value) = (rain_alpha) (pad_choose_script) = (incr_rain_color) (params) = { (rain) } 
			(make_light_tool_item) (text) = "red2" (id) = (menu_red2) (value) = (rain_red2) (pad_choose_script) = (incr_rain_color) (params) = { (rain) } 
			(make_light_tool_item) (text) = "green2" (id) = (menu_green2) (value) = (rain_green2) (pad_choose_script) = (incr_rain_color) (params) = { (rain) } 
			(make_light_tool_item) (text) = "blue2" (id) = (menu_blue2) (value) = (rain_blue2) (pad_choose_script) = (incr_rain_color) (params) = { (rain) } 
			(make_light_tool_item) (text) = "alpha2" (id) = (menu_alpha2) (value) = (rain_alpha2) (pad_choose_script) = (incr_rain_color) (params) = { (rain) } 
		CASE 9 
			(make_light_tool_item) (text) = "rate" (id) = (menu_rate) (value) = (splash_rate) (pad_choose_script) = (incr_splash_val) 
			(make_light_tool_item) (text) = "life" (id) = (menu_life) (value) = (splash_life) (pad_choose_script) = (incr_splash_val) 
			(make_light_tool_item) (text) = "size" (id) = (menu_size) (value) = (splash_size) (pad_choose_script) = (incr_splash_val) 
			(get_rain_mode_string) (splash) 
			(make_light_tool_item) (text) = "blendmode" (id) = (menu_blend) (value_text) = <value_text> (pad_choose_script) = (incr_splash_val) 
			(make_light_tool_item) (text) = "fixalpha" (id) = (menu_fixed) (value) = (splash_fixed) (pad_choose_script) = (incr_splash_val) 
		CASE 10 
			(make_light_tool_item) (text) = "red" (id) = (menu_red) (value) = (splash_red) (pad_choose_script) = (incr_rain_color) (params) = { (splash) } 
			(make_light_tool_item) (text) = "green" (id) = (menu_green) (value) = (splash_green) (pad_choose_script) = (incr_rain_color) (params) = { (splash) } 
			(make_light_tool_item) (text) = "blue" (id) = (menu_blue) (value) = (splash_blue) (pad_choose_script) = (incr_rain_color) (params) = { (splash) } 
			(make_light_tool_item) (text) = "alpha" (id) = (menu_alpha) (value) = (splash_alpha) (pad_choose_script) = (incr_rain_color) (params) = { (splash) } 
		CASE 11 
			IF ( (rain_or_snow) = 0 ) 
				(rain_text) = "rain" 
			ELSE 
				(rain_text) = "snow" 
			ENDIF 
			(make_light_tool_item) (text) = "Rain/Snow" (id) = (menu_rain) (value) = <rain_text> (pad_choose_script) = (toggle_rain_snow) 
			(make_light_tool_item) (text) = "rate" (id) = (menu_rate) (value) = (snow_rate) (pad_choose_script) = (incr_snow_val) 
			(make_light_tool_item) (text) = "frames" (id) = (menu_frames) (value) = (snow_frames) (pad_choose_script) = (incr_snow_val) 
			(make_light_tool_item) (text) = "height" (id) = (menu_height) (value) = (snow_height) (pad_choose_script) = (incr_snow_val) 
			(make_light_tool_item) (text) = "size" (id) = (menu_size) (value) = (snow_size) (pad_choose_script) = (incr_snow_val) 
			(get_rain_mode_string) (snow) 
			(make_light_tool_item) (text) = "blendmode" (id) = (menu_blend) (value_text) = <value_text> (pad_choose_script) = (incr_snow_val) 
			(make_light_tool_item) (text) = "fixalpha" (id) = (menu_fixed) (value) = (snow_fixed) (pad_choose_script) = (incr_snow_val) 
		CASE 12 
			(make_light_tool_item) (text) = "red" (id) = (menu_red) (value) = (snow_red) (pad_choose_script) = (incr_rain_color) (params) = { (snow) } 
			(make_light_tool_item) (text) = "green" (id) = (menu_green) (value) = (snow_green) (pad_choose_script) = (incr_rain_color) (params) = { (snow) } 
			(make_light_tool_item) (text) = "blue" (id) = (menu_blue) (value) = (snow_blue) (pad_choose_script) = (incr_rain_color) (params) = { (snow) } 
			(make_light_tool_item) (text) = "alpha" (id) = (menu_alpha) (value) = (snow_alpha) (pad_choose_script) = (incr_rain_color) (params) = { (snow) } 
		DEFAULT 
			(change) (current_lighting) = 0 
			(create_lighting_tool) 
	ENDSWITCH 
	(spawnscript) (update_directional_light_pos) 
	(FireEvent) (type) = (focus) (target) = (light_menu) 
ENDSCRIPT

SCRIPT (toggle_light_menu_focus) 
	IF (GotParam) (off) 
		(FireEvent) (type) = (unfocus) (target) = (light_menu) 
		(SetScreenElementProps) { 
			(id) = (root_window) 
			(event_handlers) = [ { (pad_r2) (toggle_light_menu_focus) (params) = { (on) } } ] 
		} 
	ELSE 
		IF (GotParam) (on) 
			(FireEvent) (type) = (focus) (target) = (light_menu) 
			(SetScreenElementProps) { 
				(id) = (root_window) 
				(event_handlers) = [ { (pad_r2) (null_script) (params) = { } } ] 
				(replace_handlers) 
			} 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT (get_level_light_values) 
	IF (LevelIs) (load_skateshop) 
		(this_level) = (level_skateshop) 
		(no_fog) = 1 
	ENDIF 
	IF (LevelIs) (load_sch) 
		(this_level) = (level_sch) 
		(no_fog) = 1 
	ENDIF 
	IF (LevelIs) (load_sf2) 
		(this_level) = (level_sf2) 
		(no_fog) = 1 
	ENDIF 
	IF (LevelIs) (load_alc) 
		(this_level) = (level_alc) 
		(no_fog) = 1 
	ENDIF 
	IF (LevelIs) (load_kon) 
		(this_level) = (level_kon) 
		(no_fog) = 1 
	ENDIF 
	IF (LevelIs) (load_jnk) 
		(this_level) = (level_jnk) 
		(no_fog) = 1 
	ENDIF 
	IF (LevelIs) (load_lon) 
		(this_level) = (level_lon) 
		(no_fog) = 1 
	ENDIF 
	IF (LevelIs) (load_zoo) 
		(this_level) = (level_zoo) 
		(no_fog) = 1 
	ENDIF 
	IF (LevelIs) (load_cnv) 
		(this_level) = (level_cnv) 
		(no_fog) = 1 
	ENDIF 
	IF (LevelIs) (load_hof) 
		(this_level) = (level_hof) 
		(no_fog) = 1 
	ENDIF 
	IF (LevelIs) (load_AU) 
		(this_level) = (level_AU) 
	ENDIF 
	IF (LevelIs) (load_RU) 
		(this_level) = (level_RU) 
	ENDIF 
	IF (LevelIs) (load_SP) 
		(this_level) = (level_SP) 
	ENDIF 
	IF (LevelIs) (load_VC) 
		(this_level) = (level_VC) 
	ENDIF 
	IF (LevelIs) (load_HI) 
		(this_level) = (level_HI) 
	ENDIF 
	IF (LevelIs) (load_SD) 
		(this_level) = (level_SD) 
	ENDIF 
	IF (LevelIs) (load_FL) 
		(this_level) = (level_FL) 
	ENDIF 
	IF (LevelIs) (load_NY) 
		(this_level) = (level_NY) 
	ENDIF 
	IF (LevelIs) (load_NJ) 
		(this_level) = (level_NJ) 
	ENDIF 
	IF (LevelIs) (load_SC) 
		(this_level) = (level_SC) 
	ENDIF 
	IF (LevelIs) (load_Default) 
		(this_level) = (level_default) 
		(no_fog) = 1 
	ENDIF 
	IF (LevelIs) (load_TestLevel) 
		(this_level) = (level_testlevel) 
		(no_fog) = 1 
	ENDIF 
	(set_to_tod_values) (tod) = <this_level> (level) (no_fog) = <no_fog> 
ENDSCRIPT

SCRIPT (reset_light_values) 
	(printf) "Reset skater lighting to level defaults" 
	<setcolor> = 0 
	(change) (lev_red) = 128 
	(change) (lev_green) = 128 
	(change) (lev_blue) = 128 
	(change) (lev_vct) = 128 
	(change) (lev_vcp) = 0 
	(change) (fog_red) = 128 
	(change) (fog_green) = 128 
	(change) (fog_blue) = 128 
	(change) (fog_alpha) = 50 
	(change) (fog_dist) = 15 
	(change) (sky_red) = 128 
	(change) (sky_green) = 128 
	(change) (sky_blue) = 128 
	(get_level_light_values) 
	(launch_lighting_tool) 
ENDSCRIPT

SCRIPT (next_light) (max) = 12 
	IF (GotParam) (left) 
		(change) (current_lighting) = ( (current_lighting) - 1 ) 
	ELSE 
		(change) (current_lighting) = ( (current_lighting) + 1 ) 
	ENDIF 
	IF ( (current_lighting) > <max> ) 
		(change) (current_lighting) = 0 
	ELSE 
		IF ( 0 > (current_lighting) ) 
			(change) (current_lighting) = <max> 
		ENDIF 
	ENDIF 
	(create_lighting_tool) <...> 
ENDSCRIPT

SCRIPT (make_light_tool_item) { (focus_script) = (do_scale_up) 
		(unfocus_script) = (do_scale_down) 
		(pad_choose_script) = (nullscript) 
		(font_face) = (small) 
		(parent_menu_id) = (current_menu) 
		(scale) = 1 
		(rgba) = [ 88 105 112 128 ] 
		(value) = 100 
	} 
	SWITCH <id> 
		CASE (menu_red) 
			(rgba) = [ 80 20 20 128 ] 
		CASE (menu_green) 
			(rgba) = [ 20 80 20 128 ] 
		CASE (menu_blue) 
			(rgba) = [ 20 20 80 128 ] 
	ENDSWITCH 
	(unfocus_params) = { (rgba) = <rgba> } 
	(CreateScreenElement) { 
		(type) = (textelement) 
		(parent) = <parent_menu_id> 
		(id) = <id> 
		(text) = <text> 
		(font) = <font_face> 
		(rgba) = <rgba> 
		(scale) = <scale> 
		(event_handlers) = [ 
			{ (focus) <focus_script> (params) = <focus_params> } 
			{ (unfocus) <unfocus_script> (params) = <unfocus_params> } 
			{ (pad_left) <pad_choose_script> (params) = { (reverse) <params> } } 
			{ (pad_right) <pad_choose_script> (params) = { <params> } } 
		] 
	} 
	IF NOT (GotParam) (value_text) 
		(FormatText) (TextName) = (value_text) "%i" (i) = <value> 
	ENDIF 
	(CreateScreenElement) { 
		(type) = (textelement) 
		(parent) = <id> 
		(pos) = PAIR(150.00000000000, 10.00000000000) 
		(text) = <value_text> 
		(font) = <font_face> 
		(rgba) = <rgba> 
		(scale) = <scale> 
	} 
ENDSCRIPT

SCRIPT (incr_color_val) (step) = 1 (max) = 128 (min) = 0 
	(GetTags) 
	(GetCurrentLightingValues) 
	(removeparameter) (random_effect_done) 
	IF (GotParam) (reverse) 
		(step) = ( -1 * <step> ) 
	ENDIF 
	(step) = ( <step> * (step_multiplier) ) 
	IF ( (lock_color_values) = 1 ) 
		(id) = (menu_all) 
	ENDIF 
	SWITCH (current_lighting) 
		CASE 0 
			SWITCH <id> 
				CASE (menu_red) 
					(ambient_red) = ( <ambient_red> + <step> ) 
					IF ( <ambient_red> > 255 ) 
						(ambient_red) = 255 
					ELSE 
						IF ( 0 > <ambient_red> ) 
							(ambient_red) = 0 
						ENDIF 
					ENDIF 
					(FormatText) (TextName) = (value_text) "%i" (i) = <ambient_red> 
				CASE (menu_green) 
					(ambient_green) = ( <ambient_green> + <step> ) 
					IF ( <ambient_green> > 255 ) 
						(ambient_green) = 255 
					ELSE 
						IF ( 0 > <ambient_green> ) 
							(ambient_green) = 0 
						ENDIF 
					ENDIF 
					(FormatText) (TextName) = (value_text) "%i" (i) = <ambient_green> 
				CASE (menu_blue) 
					(ambient_blue) = ( <ambient_blue> + <step> ) 
					IF ( <ambient_blue> > 255 ) 
						(ambient_blue) = 255 
					ELSE 
						IF ( 0 > <ambient_blue> ) 
							(ambient_blue) = 0 
						ENDIF 
					ENDIF 
					(FormatText) (TextName) = (value_text) "%i" (i) = <ambient_blue> 
				CASE (menu_all) 
					(ambient_red) = ( <ambient_red> + <step> ) 
					IF ( <ambient_red> > 255 ) 
						(ambient_red) = 255 
					ELSE 
						IF ( 0 > <ambient_red> ) 
							(ambient_red) = 0 
						ENDIF 
					ENDIF 
					(ambient_green) = <ambient_red> 
					(ambient_blue) = <ambient_red> 
					(FormatText) (TextName) = (value_text) "%i" (i) = <ambient_red> 
			ENDSWITCH 
		CASE 1 
			SWITCH <id> 
				CASE (menu_red) 
					(red_0) = ( <red_0> + <step> ) 
					IF ( <red_0> > 255 ) 
						(red_0) = 255 
					ELSE 
						IF ( 0 > <red_0> ) 
							(red_0) = 0 
						ENDIF 
					ENDIF 
					(FormatText) (TextName) = (value_text) "%i" (i) = <red_0> 
				CASE (menu_green) 
					(green_0) = ( <green_0> + <step> ) 
					IF ( <green_0> > 255 ) 
						(green_0) = 255 
					ELSE 
						IF ( 0 > <green_0> ) 
							(green_0) = 0 
						ENDIF 
					ENDIF 
					(FormatText) (TextName) = (value_text) "%i" (i) = <green_0> 
				CASE (menu_blue) 
					(blue_0) = ( <blue_0> + <step> ) 
					IF ( <blue_0> > 255 ) 
						(blue_0) = 255 
					ELSE 
						IF ( 0 > <blue_0> ) 
							(blue_0) = 0 
						ENDIF 
					ENDIF 
					(FormatText) (TextName) = (value_text) "%i" (i) = <blue_0> 
				CASE (menu_all) 
					(red_0) = ( <red_0> + <step> ) 
					IF ( <red_0> > 255 ) 
						(red_0) = 255 
					ELSE 
						IF ( 0 > <red_0> ) 
							(red_0) = 0 
						ENDIF 
					ENDIF 
					(green_0) = <red_0> 
					(blue_0) = <red_0> 
					(FormatText) (TextName) = (value_text) "%i" (i) = <red_0> 
			ENDSWITCH 
		CASE 2 
			SWITCH <id> 
				CASE (menu_red) 
					(red_1) = ( <red_1> + <step> ) 
					IF ( <red_1> > 255 ) 
						(red_1) = 255 
					ELSE 
						IF ( 0 > <red_1> ) 
							(red_1) = 0 
						ENDIF 
					ENDIF 
					(FormatText) (TextName) = (value_text) "%i" (i) = <red_1> 
				CASE (menu_green) 
					(green_1) = ( <green_1> + <step> ) 
					IF ( <green_1> > 255 ) 
						(green_1) = 255 
					ELSE 
						IF ( 0 > <green_1> ) 
							(green_1) = 0 
						ENDIF 
					ENDIF 
					(FormatText) (TextName) = (value_text) "%i" (i) = <green_1> 
				CASE (menu_blue) 
					(blue_1) = ( <blue_1> + <step> ) 
					IF ( <blue_1> > 255 ) 
						(blue_1) = 255 
					ELSE 
						IF ( 0 > <blue_1> ) 
							(blue_1) = 0 
						ENDIF 
					ENDIF 
					(FormatText) (TextName) = (value_text) "%i" (i) = <blue_1> 
				CASE (menu_all) 
					(red_1) = ( <red_1> + <step> ) 
					IF ( <red_1> > 255 ) 
						(red_1) = 255 
					ELSE 
						IF ( 0 > <red_1> ) 
							(red_1) = 0 
						ENDIF 
					ENDIF 
					(green_1) = <red_1> 
					(blue_1) = <red_1> 
					(FormatText) (TextName) = (value_text) "%i" (i) = <red_1> 
			ENDSWITCH 
		CASE 3 
			SWITCH <id> 
				CASE (menu_red) 
					(change) (lev_red) = ( (lev_red) + <step> ) 
					IF ( (lev_red) > 255 ) 
						(change) (lev_red) = 255 
					ELSE 
						IF ( 0 > (lev_red) ) 
							(change) (lev_red) = 0 
						ENDIF 
					ENDIF 
					(FormatText) (TextName) = (value_text) "%i" (i) = (lev_red) 
				CASE (menu_green) 
					(change) (lev_green) = ( (lev_green) + <step> ) 
					IF ( (lev_green) > 255 ) 
						(change) (lev_green) = 255 
					ELSE 
						IF ( 0 > (lev_green) ) 
							(change) (lev_green) = 0 
						ENDIF 
					ENDIF 
					(FormatText) (TextName) = (value_text) "%i" (i) = (lev_green) 
				CASE (menu_blue) 
					(change) (lev_blue) = ( (lev_blue) + <step> ) 
					IF ( (lev_blue) > 255 ) 
						(change) (lev_blue) = 255 
					ELSE 
						IF ( 0 > (lev_blue) ) 
							(change) (lev_blue) = 0 
						ENDIF 
					ENDIF 
					(FormatText) (TextName) = (value_text) "%i" (i) = (lev_blue) 
				CASE (menu_target) 
					(change) (lev_vct) = ( (lev_vct) + <step> ) 
					IF ( (lev_vct) > 255 ) 
						(change) (lev_vct) = 255 
					ELSE 
						IF ( 0 > (lev_vct) ) 
							(change) (lev_vct) = 0 
						ENDIF 
					ENDIF 
					(FormatText) (TextName) = (value_text) "%i" (i) = (lev_vct) 
				CASE (menu_percent) 
					(change) (lev_vcp) = ( (lev_vcp) + <step> ) 
					IF ( (lev_vcp) > 100 ) 
						(change) (lev_vcp) = 100 
					ELSE 
						IF ( 0 > (lev_vcp) ) 
							(change) (lev_vcp) = 0 
						ENDIF 
					ENDIF 
					(FormatText) (TextName) = (value_text) "%i" (i) = (lev_vcp) 
				CASE (menu_all) 
					(change) (lev_red) = ( (lev_red) + <step> ) 
					IF ( (lev_red) > 255 ) 
						(change) (lev_red) = 255 
					ELSE 
						IF ( 0 > (lev_red) ) 
							(change) (lev_red) = 0 
						ENDIF 
					ENDIF 
					(change) (lev_green) = (lev_red) 
					(change) (lev_blue) = (lev_red) 
					(FormatText) (TextName) = (value_text) "%i" (i) = (lev_red) 
			ENDSWITCH 
		CASE 4 
			SWITCH <id> 
				CASE (menu_red) 
					(change) (fog_red) = ( (fog_red) + <step> ) 
					IF ( (fog_red) > 255 ) 
						(change) (fog_red) = 255 
					ELSE 
						IF ( 0 > (fog_red) ) 
							(change) (fog_red) = 0 
						ENDIF 
					ENDIF 
					(FormatText) (TextName) = (value_text) "%i" (i) = (fog_red) 
				CASE (menu_green) 
					(change) (fog_green) = ( (fog_green) + <step> ) 
					IF ( (fog_green) > 255 ) 
						(change) (fog_green) = 255 
					ELSE 
						IF ( 0 > (fog_green) ) 
							(change) (fog_green) = 0 
						ENDIF 
					ENDIF 
					(FormatText) (TextName) = (value_text) "%i" (i) = (fog_green) 
				CASE (menu_blue) 
					(change) (fog_blue) = ( (fog_blue) + <step> ) 
					IF ( (fog_blue) > 255 ) 
						(change) (fog_blue) = 255 
					ELSE 
						IF ( 0 > (fog_blue) ) 
							(change) (fog_blue) = 0 
						ENDIF 
					ENDIF 
					(FormatText) (TextName) = (value_text) "%i" (i) = (fog_blue) 
				CASE (menu_alpha) 
					(change) (fog_alpha) = ( (fog_alpha) + <step> ) 
					IF ( (fog_alpha) > 128 ) 
						(change) (fog_alpha) = 128 
					ELSE 
						IF ( 0 > (fog_alpha) ) 
							(change) (fog_alpha) = 0 
						ENDIF 
					ENDIF 
					(FormatText) (TextName) = (value_text) "%i" (i) = (fog_alpha) 
				CASE (menu_exp) 
					(change) (fog_dist) = ( (fog_dist) + ( 0.50000000000 * <step> ) ) 
					IF ( (fog_dist) > 1000 ) 
						(change) (fog_dist) = 1000 
					ELSE 
						IF ( 0 > (fog_dist) ) 
							(change) (fog_dist) = 0 
						ENDIF 
					ENDIF 
					(FormatText) (TextName) = (value_text) "%i" (i) = (fog_dist) 
				CASE (menu_fog) 
					IF ( (fog_state) = 0 ) 
						(change) (fog_state) = 1 
						(enablefog) 
						(value_text) = "on" 
					ELSE 
						(change) (fog_state) = 0 
						(disablefog) 
						(value_text) = "off" 
					ENDIF 
				CASE (menu_all) 
					(change) (fog_red) = ( (fog_red) + <step> ) 
					IF ( (fog_red) > 255 ) 
						(change) (fog_red) = 255 
					ELSE 
						IF ( 0 > (fog_red) ) 
							(change) (fog_red) = 0 
						ENDIF 
					ENDIF 
					(change) (fog_green) = (fog_red) 
					(change) (fog_blue) = (fog_red) 
					(FormatText) (TextName) = (value_text) "%i" (i) = (fog_red) 
			ENDSWITCH 
		CASE 5 
			SWITCH <id> 
				CASE (menu_red) 
					(change) (sky_red) = ( (sky_red) + <step> ) 
					IF ( (sky_red) > 255 ) 
						(change) (sky_red) = 255 
					ELSE 
						IF ( 0 > (sky_red) ) 
							(change) (sky_red) = 0 
						ENDIF 
					ENDIF 
					(FormatText) (TextName) = (value_text) "%i" (i) = (sky_red) 
				CASE (menu_green) 
					(change) (sky_green) = ( (sky_green) + <step> ) 
					IF ( (sky_green) > 255 ) 
						(change) (sky_green) = 255 
					ELSE 
						IF ( 0 > (sky_green) ) 
							(change) (sky_green) = 0 
						ENDIF 
					ENDIF 
					(FormatText) (TextName) = (value_text) "%i" (i) = (sky_green) 
				CASE (menu_blue) 
					(change) (sky_blue) = ( (sky_blue) + <step> ) 
					IF ( (sky_blue) > 255 ) 
						(change) (sky_blue) = 255 
					ELSE 
						IF ( 0 > (sky_blue) ) 
							(change) (sky_blue) = 0 
						ENDIF 
					ENDIF 
					(FormatText) (TextName) = (value_text) "%i" (i) = (sky_blue) 
				CASE (menu_all) 
					(change) (sky_red) = ( (sky_red) + <step> ) 
					IF ( (sky_red) > 255 ) 
						(change) (sky_red) = 255 
					ELSE 
						IF ( 0 > (sky_red) ) 
							(change) (sky_red) = 0 
						ENDIF 
					ENDIF 
					(change) (sky_green) = (sky_red) 
					(change) (sky_blue) = (sky_red) 
					(FormatText) (TextName) = (value_text) "%i" (i) = (sky_red) 
			ENDSWITCH 
	ENDSWITCH 
	IF ( (lock_color_values) = 1 ) 
		(SetScreenElementProps) (id) = { (menu_red) (child) = 0 } (text) = <value_text> 
		(SetScreenElementProps) (id) = { (menu_green) (child) = 0 } (text) = <value_text> 
		(SetScreenElementProps) (id) = { (menu_blue) (child) = 0 } (text) = <value_text> 
	ELSE 
		(SetScreenElementProps) (id) = { <id> (child) = 0 } (text) = <value_text> 
	ENDIF 
	<color> = 0 
	SWITCH (current_lighting) 
		CASE 0 
			(SetLightAmbientColor) (r) = <ambient_red> (g) = <ambient_green> (b) = <ambient_blue> 
		CASE 1 
			(SetLightDiffuseColor) (index) = 0 (r) = <red_0> (g) = <green_0> (b) = <blue_0> 
		CASE 2 
			(SetLightDiffuseColor) (index) = 1 (r) = <red_1> (g) = <green_1> (b) = <blue_1> 
		CASE 3 
			<color> = ( (lev_red) + ( (lev_green) * 256 ) + ( (lev_blue) * 65536 ) ) 
			<sky> = ( (sky_red) + ( (sky_green) * 256 ) + ( (sky_blue) * 65536 ) ) 
			(lighting) (color) = <color> (sky) = <sky> 
		CASE 4 
			(SetFogColor) (r) = (fog_red) (b) = (fog_blue) (g) = (fog_green) (a) = (fog_alpha) 
			(SetFogDistance) (distance) = (fog_dist) 
		CASE 5 
			<color> = ( (lev_red) + ( (lev_green) * 256 ) + ( (lev_blue) * 65536 ) ) 
			<sky> = ( (sky_red) + ( (sky_green) * 256 ) + ( (sky_blue) * 65536 ) ) 
			(lighting) (color) = <color> (sky) = <sky> 
	ENDSWITCH 
ENDSCRIPT

SCRIPT (incr_mod_val) (step) = 0.00999999978 (max) = 2 (min) = 0 
	(GetTags) 
	(removeparameter) (random_effect_done) 
	IF (GotParam) (reverse) 
		(step) = ( -1 * <step> ) 
	ENDIF 
	(step) = ( <step> * (step_multiplier) ) 
	SWITCH (current_lighting) 
		CASE 0 
			(change) (amb_mod) = ( (amb_mod) + <step> ) 
			IF ( (amb_mod) > <max> ) 
				(change) (amb_mod) = <max> 
			ENDIF 
			IF ( <min> > (amb_mod) ) 
				(change) (amb_mod) = <min> 
			ENDIF 
			(FormatText) (TextName) = (value_text) "%i" (i) = (amb_mod) 
		CASE 1 
			(change) (dir0_mod) = ( (dir0_mod) + <step> ) 
			IF ( (dir0_mod) > <max> ) 
				(change) (dir0_mod) = <max> 
			ENDIF 
			IF ( <min> > (dir0_mod) ) 
				(change) (dir0_mod) = <min> 
			ENDIF 
			(FormatText) (TextName) = (value_text) "%i" (i) = (dir0_mod) 
		CASE 2 
			(change) (dir1_mod) = ( (dir1_mod) + <step> ) 
			IF ( (dir1_mod) > <max> ) 
				(change) (dir1_mod) = <max> 
			ENDIF 
			IF ( <min> > (dir1_mod) ) 
				(change) (dir1_mod) = <min> 
			ENDIF 
			(FormatText) (TextName) = (value_text) "%i" (i) = (dir1_mod) 
	ENDSWITCH 
	(SetScreenElementProps) (id) = { <id> (child) = 0 } (text) = <value_text> 
	(SetDynamicLightModulationFactor) (ambient) (value) = (amb_mod) 
	(SetDynamicLightModulationFactor) (directional) = 0 (value) = (dir0_mod) 
	(SetDynamicLightModulationFactor) (directional) = 1 (value) = (dir1_mod) 
ENDSCRIPT

SCRIPT (incr_heading_val) (step) = 1 (max) = 360 (min) = 0 
	(GetTags) 
	IF (GotParam) (reverse) 
		(step) = ( -1 * <step> ) 
	ENDIF 
	(step) = ( <step> * (step_multiplier) ) 
	SWITCH (current_lighting) 
		CASE 0 
			RETURN 
		CASE 1 
			(change) (dir0_head) = ( (dir0_head) + <step> ) 
			IF ( (dir0_head) > <max> ) 
				(change) (dir0_head) = <min> 
			ENDIF 
			IF ( <min> > (dir0_head) ) 
				(change) (dir0_head) = <max> 
			ENDIF 
			(FormatText) (TextName) = (value_text) "%i" (i) = (dir0_head) 
		CASE 2 
			(change) (dir1_head) = ( (dir1_head) + <step> ) 
			IF ( (dir1_head) > <max> ) 
				(change) (dir1_head) = <min> 
			ENDIF 
			IF ( <min> > (dir1_head) ) 
				(change) (dir1_head) = <max> 
			ENDIF 
			(FormatText) (TextName) = (value_text) "%i" (i) = (dir1_head) 
	ENDSWITCH 
	(SetScreenElementProps) (id) = { <id> (child) = 0 } (text) = <value_text> 
	(SetLightDirection) (index) = 0 (heading) = (dir0_head) (pitch) = (dir0_pitch) 
	(SetLightDirection) (index) = 1 (heading) = (dir1_head) (pitch) = (dir1_pitch) 
ENDSCRIPT

SCRIPT (incr_pitch_val) (step) = 1 (max) = 360 (min) = 0 
	(GetTags) 
	IF (GotParam) (reverse) 
		(step) = ( -1 * <step> ) 
	ENDIF 
	(step) = ( <step> * (step_multiplier) ) 
	SWITCH (current_lighting) 
		CASE 0 
			RETURN 
		CASE 1 
			(change) (dir0_pitch) = ( (dir0_pitch) + <step> ) 
			IF ( (dir0_pitch) > <max> ) 
				(change) (dir0_pitch) = <min> 
			ENDIF 
			IF ( <min> > (dir0_pitch) ) 
				(change) (dir0_pitch) = <max> 
			ENDIF 
			(FormatText) (TextName) = (value_text) "%i" (i) = (dir0_pitch) 
		CASE 2 
			(change) (dir1_pitch) = ( (dir1_pitch) + <step> ) 
			IF ( (dir1_pitch) > <max> ) 
				(change) (dir1_pitch) = <min> 
			ENDIF 
			IF ( <min> > (dir1_pitch) ) 
				(change) (dir1_pitch) = <max> 
			ENDIF 
			(FormatText) (TextName) = (value_text) "%i" (i) = (dir1_pitch) 
	ENDSWITCH 
	(SetScreenElementProps) (id) = { <id> (child) = 0 } (text) = <value_text> 
	(SetLightDirection) (index) = 0 (heading) = (dir0_head) (pitch) = (dir0_pitch) 
	(SetLightDirection) (index) = 1 (heading) = (dir1_head) (pitch) = (dir1_pitch) 
ENDSCRIPT

SCRIPT (GetCurrentLightingValues) 
	(GetLightCurrentColor) 
	RETURN <...> 
ENDSCRIPT

SCRIPT (toggle_step_multiplier) 
	IF ( (step_multiplier) = 1 ) 
		(change) (step_multiplier) = 10 
	ELSE 
		(change) (step_multiplier) = 1 
	ENDIF 
	(printf) "step_multiplier = %s" (s) = (step_multiplier) 
ENDSCRIPT

SCRIPT (toggle_color_lock) 
	IF ( (lock_color_values) = 1 ) 
		(change) (lock_color_values) = 0 
		(printf) "RGB values UNlocked" 
	ELSE 
		(change) (lock_color_values) = 1 
		(printf) "RGB values locked" 
	ENDIF 
ENDSCRIPT

SCRIPT (toggle_dir_light_on_off) 
	IF ( <index> = 0 ) 
		IF ( (toggle_dir0) = 1 ) 
			(GetCurrentLightingValues) 
			(change) (last_dir0_red) = <red_0> 
			(change) (last_dir0_green) = <green_0> 
			(change) (last_dir0_blue) = <blue_0> 
			(SetLightDiffuseColor) (index) = 0 (r) = 0 (g) = 0 (b) = 0 
			(change) (toggle_dir0) = 0 
			(SetScreenElementProps) (id) = { (menu_onoff) (child) = 0 } (text) = "off" 
		ELSE 
			(SetLightDiffuseColor) (index) = 0 (r) = (last_dir0_red) (g) = (last_dir0_green) (b) = (last_dir0_blue) 
			(change) (toggle_dir0) = 1 
			(SetScreenElementProps) (id) = { (menu_onoff) (child) = 0 } (text) = "on" 
		ENDIF 
	ELSE 
		IF ( <index> = 1 ) 
			IF ( (toggle_dir1) = 1 ) 
				(GetCurrentLightingValues) 
				(change) (last_dir1_red) = <red_1> 
				(change) (last_dir1_green) = <green_1> 
				(change) (last_dir1_blue) = <blue_1> 
				(SetLightDiffuseColor) (index) = 1 (r) = 0 (g) = 0 (b) = 0 
				(change) (toggle_dir1) = 0 
				(SetScreenElementProps) (id) = { (menu_onoff) (child) = 0 } (text) = "off" 
			ELSE 
				(SetLightDiffuseColor) (index) = 1 (r) = (last_dir1_red) (g) = (last_dir1_green) (b) = (last_dir1_blue) 
				(change) (toggle_dir1) = 1 
				(SetScreenElementProps) (id) = { (menu_onoff) (child) = 0 } (text) = "on" 
			ENDIF 
		ELSE 
			(printf) "toggle_dir_light_on_off: bad index value" 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT (update_directional_light_pos) 
	BEGIN 
		IF ( (toggle_dir0) = 1 ) 
			(DrawDirectionalLightLines) (heading) = (dir0_head) (pitch) = (dir0_pitch) (r) = 255 (g) = 0 (b) = 0 
			(wait) 1 (gameframe) 
		ENDIF 
		IF ( (toggle_dir1) = 1 ) 
			(DrawDirectionalLightLines) (heading) = (dir1_head) (pitch) = (dir1_pitch) (r) = 0 (g) = 0 (b) = 255 
		ENDIF 
		(wait) 1 (gameframe) 
	REPEAT 
ENDSCRIPT

SCRIPT (set_to_tod_values) 
	(printstruct) <...> 
	IF NOT (GotParam) (tod) 
		RETURN 
	ENDIF 
	(change) (amb_mod) = ( <tod> . (ambient_mod_factor) ) 
	(change) (dir0_head) = ( <tod> . (heading_0) ) 
	(change) (dir0_pitch) = ( <tod> . (pitch_0) ) 
	(change) (dir0_mod) = ( <tod> . (mod_factor_0) ) 
	(change) (dir1_head) = ( <tod> . (heading_1) ) 
	(change) (dir1_pitch) = ( <tod> . (pitch_1) ) 
	(change) (dir1_mod) = ( <tod> . (mod_factor_1) ) 
	IF NOT (GotParam) (level) 
		(change) (lev_red) = ( <tod> . (lev_red) ) 
		(change) (lev_green) = ( <tod> . (lev_green) ) 
		(change) (lev_blue) = ( <tod> . (lev_blue) ) 
	ELSE 
	ENDIF 
	IF NOT (GotParam) (no_fog) 
		IF (StructureContains) (structure) = (tod) (fog_red) 
			(change) (fog_red) = ( <tod> . (fog_red) ) 
			(change) (fog_green) = ( <tod> . (fog_green) ) 
			(change) (fog_blue) = ( <tod> . (fog_blue) ) 
			(change) (fog_alpha) = ( <tod> . (fog_alpha) ) 
			(change) (fog_dist) = ( <tod> . (fog_dist) ) 
		ELSE 
			(change) (fog_red) = 0 
			(change) (fog_green) = 0 
			(change) (fog_blue) = 0 
			(change) (fog_alpha) = 0 
			(change) (fog_dist) = 0 
		ENDIF 
	ELSE 
		(change) (fog_red) = 0 
		(change) (fog_green) = 0 
		(change) (fog_blue) = 0 
		(change) (fog_alpha) = 0 
		(change) (fog_dist) = 0 
	ENDIF 
	(change) (sky_red) = 128 
	(change) (sky_green) = 128 
	(change) (sky_blue) = 128 
	(ambient_red) = ( <tod> . (ambient_red) ) 
	(ambient_green) = ( <tod> . (ambient_green) ) 
	(ambient_blue) = ( <tod> . (ambient_blue) ) 
	(red_0) = ( <tod> . (red_0) ) 
	(green_0) = ( <tod> . (green_0) ) 
	(blue_0) = ( <tod> . (blue_0) ) 
	(red_1) = ( <tod> . (red_1) ) 
	(green_1) = ( <tod> . (green_1) ) 
	(blue_1) = ( <tod> . (blue_1) ) 
	(set_all_light_values) <...> 
ENDSCRIPT

SCRIPT (set_all_light_values) 
	<color> = ( (lev_red) + ( (lev_green) * 256 ) + ( (lev_blue) * 65536 ) ) 
	<sky> = ( (sky_red) + ( (sky_green) * 256 ) + ( (sky_blue) * 65536 ) ) 
	(lighting) (color) = <color> (sky) = <sky> 
	IF NOT (GotParam) (level_only) 
		(SetLightAmbientColor) (r) = <ambient_red> (g) = <ambient_green> (b) = <ambient_blue> 
		(SetLightDiffuseColor) (index) = 0 (r) = <red_0> (g) = <green_0> (b) = <blue_0> 
		(SetLightDiffuseColor) (index) = 1 (r) = <red_1> (g) = <green_1> (b) = <blue_1> 
	ENDIF 
	(SetFogColor) (r) = (fog_red) (b) = (fog_blue) (g) = (fog_green) (a) = (fog_alpha) 
	(SetFogDistance) (distance) = (fog_dist) 
ENDSCRIPT

SCRIPT (print_light_values) 
	(printf) " " 
	(printf) "<---------------------------------------------->" 
	(printf) "Selected lighting values:" 
	(printf) "ambient_red = %i" (i) = <ambient_red> 
	(printf) "ambient_green = %i" (i) = <ambient_green> 
	(printf) "ambient_blue = %i" (i) = <ambient_blue> 
	(printf) "ambient_mod_factor = %i" (i) = (amb_mod) 
	(printf) " " 
	IF ( (toggle_dir0) = 1 ) 
		(printf) "heading_0 = %i" (i) = (dir0_head) 
		(printf) "pitch_0 = %i" (i) = (dir0_pitch) 
		(printf) "red_0 = %i" (i) = <red_0> 
		(printf) "green_0 = %i" (i) = <green_0> 
		(printf) "blue_0 = %i" (i) = <blue_0> 
		(printf) "mod_factor_0 = %i" (i) = (dir0_mod) 
		(printf) " " 
	ENDIF 
	IF ( (toggle_dir1) = 1 ) 
		(printf) "heading_1 = %i" (i) = (dir1_head) 
		(printf) "pitch_1 = %i" (i) = (dir1_pitch) 
		(printf) "red_1 = %i" (i) = <red_1> 
		(printf) "green_1 = %i" (i) = <green_1> 
		(printf) "blue_1 = %i" (i) = <blue_1> 
		(printf) "mod_factor_1 = %i" (i) = (dir1_mod) 
		(printf) "dir light 2 on/off = %i" (i) = (toggle_dir1) 
		(printf) " " 
	ENDIF 
	(printf) "change lev_red = %i" (i) = (lev_red) 
	(printf) "change lev_green = %i" (i) = (lev_green) 
	(printf) "change lev_blue  = %i" (i) = (lev_blue) 
	(printf) " " 
	(printf) "change sky_red  = %i" (i) = (sky_red) 
	(printf) "change sky_green  = %i" (i) = (sky_green) 
	(printf) "change sky_blue  = %i" (i) = (sky_blue) 
	(printf) " " 
	(printf) "fog_on  = %i" (i) = (fog_state) 
	(printf) "fog_red  = %i" (i) = (fog_red) 
	(printf) "fog_green  = %i" (i) = (fog_green) 
	(printf) "fog_blue  = %i" (i) = (fog_blue) 
	(printf) "fog_alpha  = %i" (i) = (fog_alpha) 
	(printf) "fog_dist  = %i" (i) = (fog_dist) 
	(printf) " " 
	(printf) "change rain_rate  = %i" (i) = (rain_rate) 
	(printf) "change rain_frames  = %i" (i) = (rain_frames) 
	(printf) "change rain_height  = %i" (i) = (rain_height) 
	(printf) "change rain_length  = %i" (i) = (rain_length) 
	(printf) " " 
	(get_rain_mode_string) 
	(printf) ( "change rain_blend = %i /" + "/%j" ) (i) = (rain_blend) (j) = <checksum> 
	(printf) "change rain_fixed = %i" (i) = (rain_fixed) 
	(printf) " " 
	(printf) "change rain_red  = %i" (i) = (rain_red) 
	(printf) "change rain_green  = %i" (i) = (rain_green) 
	(printf) "change rain_blue  = %i" (i) = (rain_blue) 
	(printf) "change rain_alpha  = %i" (i) = (rain_alpha) 
	(printf) " " 
	(printf) "change rain_red2  = %i" (i) = (rain_red2) 
	(printf) "change rain_green2  = %i" (i) = (rain_green2) 
	(printf) "change rain_blue2  = %i" (i) = (rain_blue2) 
	(printf) "change rain_alpha2  = %i" (i) = (rain_alpha2) 
	(printf) " " 
	(printf) "change splash_rate = %i" (i) = (splash_rate) 
	(printf) "change splash_life = %i" (i) = (splash_life) 
	(printf) "change splash_size = %i" (i) = (splash_size) 
	(get_rain_mode_string) (splash) 
	(printf) ( "change splash_blend = %i /" + "/%j" ) (i) = (splash_blend) (j) = <checksum> 
	(printf) "change splash_fixed = %i" (i) = (splash_fixed) 
	(printf) " " 
	(printf) "change splash_red  = %i" (i) = (splash_red) 
	(printf) "change splash_green  = %i" (i) = (splash_green) 
	(printf) "change splash_blue  = %i" (i) = (splash_blue) 
	(printf) "change splash_alpha  = %i" (i) = (splash_alpha) 
	(printf) " " 
	(printf) "change snow_rate  = %i" (i) = (snow_rate) 
	(printf) "change snow_frames  = %i" (i) = (snow_frames) 
	(printf) "change snow_height  = %i" (i) = (snow_height) 
	(printf) "change snow_size  = %i" (i) = (snow_size) 
	(printf) " " 
	(get_rain_mode_string) (snow) 
	(printf) ( "change snow_blend = %i /" + "/%j" ) (i) = (snow_blend) (j) = <checksum> 
	(printf) "change snow_fixed = %i" (i) = (snow_fixed) 
	(printf) " " 
	(printf) "change snow_red  = %i" (i) = (snow_red) 
	(printf) "change snow_green  = %i" (i) = (snow_green) 
	(printf) "change snow_blue  = %i" (i) = (snow_blue) 
	(printf) "change snow_alpha  = %i" (i) = (snow_alpha) 
	(printf) "<---------------------------------------------->" 
	(printf) " " 
	(killspawnedscript) (name) = (update_directional_light_pos) 
	(makeskatergoto) (ongroundai) 
	(pauseGame) 
	(SetAnalogStickActiveForMenus) 1 
	(create_pause_menu) 
ENDSCRIPT

SCRIPT (toggle_rain_snow) 
	IF ( (rain_or_snow) = 0 ) 
		(change) (rain_or_snow) = 1 
		(WeatherSetSnowActive) 
		(rain_text) = "snow" 
	ELSE 
		(change) (rain_or_snow) = 0 
		(WeatherSetRainActive) 
		(rain_text) = "rain" 
	ENDIF 
	(SetScreenElementProps) (id) = { (menu_rain) (child) = 0 } (text) = <rain_text> 
ENDSCRIPT

SCRIPT (incr_rain_val) (step) = 1 (max) = 128 (min) = 0 
	(GetTags) 
	IF (GotParam) (reverse) 
		(step) = ( -1 * <step> ) 
	ENDIF 
	(step) = ( <step> * (step_multiplier) ) 
	SWITCH <id> 
		CASE (menu_rate) 
			(change) (rain_rate) = ( (rain_rate) + <step> ) 
			IF ( (rain_rate) > ( 1024 / (rain_frames) ) ) 
				(change) (rain_rate) = ( 1024 / (rain_frames) ) 
			ELSE 
				IF ( 0 > (rain_rate) ) 
					(change) (rain_rate) = 0 
				ENDIF 
			ENDIF 
			(FormatText) (TextName) = (value_text) "%i" (i) = (rain_rate) 
			(WeatherSetRainRate) (rain_rate) 
		CASE (menu_frames) 
			(change) (rain_frames) = ( (rain_frames) + <step> ) 
			IF ( (rain_frames) > 255 ) 
				(change) (rain_frames) = 255 
			ELSE 
				IF ( 1 > (rain_frames) ) 
					(change) (rain_frames) = 1 
				ENDIF 
			ENDIF 
			(FormatText) (TextName) = (value_text) "%i" (i) = (rain_frames) 
			(WeatherSetRainFrames) (rain_frames) 
		CASE (menu_height) 
			(change) (rain_height) = ( (rain_height) + <step> ) 
			IF ( (rain_height) > 3000 ) 
				(change) (rain_height) = 3000 
			ELSE 
				IF ( 0 > (rain_height) ) 
					(change) (rain_height) = 0 
				ENDIF 
			ENDIF 
			(FormatText) (TextName) = (value_text) "%i" (i) = (rain_height) 
			(WeatherSetRainHeight) (rain_height) 
		CASE (menu_length) 
			(change) (rain_length) = ( (rain_length) + <step> ) 
			IF ( (rain_length) > 200 ) 
				(change) (rain_length) = 200 
			ELSE 
				IF ( 0 > (rain_length) ) 
					(change) (rain_length) = 0 
				ENDIF 
			ENDIF 
			(FormatText) (TextName) = (value_text) "%i" (i) = (rain_length) 
			(WeatherSetRainLength) (rain_length) 
		CASE (menu_blend) 
			IF NOT (GotParam) (reverse) 
				(change) (rain_blend) = ( (rain_blend) + 1 ) 
			ELSE 
				(change) (rain_blend) = ( (rain_blend) - 1 ) 
			ENDIF 
			IF ( (rain_blend) > 10 ) 
				(change) (rain_blend) = 0 
			ELSE 
				IF ( 0 > (rain_blend) ) 
					(change) (rain_blend) = 10 
				ENDIF 
			ENDIF 
			(get_rain_mode_string) 
			(WeatherSetRainBlendMode) <checksum> ( (rain_fixed) + 0 ) 
		CASE (menu_fixed) 
			(change) (rain_fixed) = ( (rain_fixed) + <step> ) 
			IF ( (rain_fixed) > 128 ) 
				(change) (rain_fixed) = 128 
			ELSE 
				IF ( 0 > (rain_fixed) ) 
					(change) (rain_fixed) = 0 
				ENDIF 
			ENDIF 
			(get_rain_mode_string) 
			(WeatherSetRainBlendMode) <checksum> ( (rain_fixed) + 0 ) 
			(FormatText) (TextName) = (value_text) "%i" (i) = (rain_fixed) 
	ENDSWITCH 
	(SetScreenElementProps) (id) = { <id> (child) = 0 } (text) = <value_text> 
ENDSCRIPT

SCRIPT (get_rain_mode_string) 
	IF (GotParam) (splash) 
		(value) = (splash_blend) 
	ELSE 
		IF (GotParam) (snow) 
			(value) = (snow_blend) 
		ELSE 
			(value) = (rain_blend) 
		ENDIF 
	ENDIF 
	SWITCH <value> 
		CASE 0 
			(value_text) = "blend" 
		CASE 1 
			(value_text) = "add" 
		CASE 2 
			(value_text) = "sub" 
		CASE 3 
			(value_text) = "modulate" 
		CASE 4 
			(value_text) = "brighten" 
		CASE 5 
			(value_text) = "fixblend" 
		CASE 6 
			(value_text) = "fixadd" 
		CASE 7 
			(value_text) = "fixsub" 
		CASE 8 
			(value_text) = "fixmodulate" 
		CASE 9 
			(value_text) = "fixbrighten" 
		CASE 10 
			(value_text) = "diffuse" 
	ENDSWITCH 
	(FormatText) (checksumname) = (checksum) "%i" (i) = <value_text> 
	RETURN { (value_text) = <value_text> (checksum) = <checksum> } 
ENDSCRIPT

SCRIPT (incr_rain_color) (step) = 1 (max) = 128 (min) = 0 
	(GetTags) 
	IF (GotParam) (reverse) 
		(step) = ( -1 * <step> ) 
	ENDIF 
	(step) = ( <step> * (step_multiplier) ) 
	IF (GotParam) (splash) 
		(value_red) = ( (splash_red) ) 
		(value_green) = ( (splash_green) ) 
		(value_blue) = ( (splash_blue) ) 
		(value_alpha) = ( (splash_alpha) ) 
	ENDIF 
	IF (GotParam) (snow) 
		(value_red) = ( (snow_red) ) 
		(value_green) = ( (snow_green) ) 
		(value_blue) = ( (snow_blue) ) 
		(value_alpha) = ( (snow_alpha) ) 
	ENDIF 
	IF (GotParam) (rain) 
		(value_red) = ( (rain_red) ) 
		(value_green) = ( (rain_green) ) 
		(value_blue) = ( (rain_blue) ) 
		(value_alpha) = ( (rain_alpha) ) 
	ENDIF 
	SWITCH <id> 
		CASE (menu_red) 
			(value_red) = ( <value_red> + <step> ) 
			IF ( <value_red> > 255 ) 
				(value_red) = 255 
			ELSE 
				IF ( 0 > <value_red> ) 
					(value_red) = 0 
				ENDIF 
			ENDIF 
			(FormatText) (TextName) = (value_text) "%i" (i) = <value_red> 
		CASE (menu_blue) 
			(value_blue) = ( <value_blue> + <step> ) 
			IF ( <value_blue> > 255 ) 
				(value_blue) = 255 
			ELSE 
				IF ( 0 > <value_blue> ) 
					(value_blue) = 0 
				ENDIF 
			ENDIF 
			(FormatText) (TextName) = (value_text) "%i" (i) = <value_blue> 
		CASE (menu_green) 
			(value_green) = ( <value_green> + <step> ) 
			IF ( <value_green> > 255 ) 
				(value_green) = 255 
			ELSE 
				IF ( 0 > <value_green> ) 
					(value_green) = 0 
				ENDIF 
			ENDIF 
			(FormatText) (TextName) = (value_text) "%i" (i) = <value_green> 
		CASE (menu_alpha) 
			(value_alpha) = ( <value_alpha> + <step> ) 
			IF ( <value_alpha> > 255 ) 
				(value_alpha) = 255 
			ELSE 
				IF ( 0 > <value_alpha> ) 
					(value_alpha) = 0 
				ENDIF 
			ENDIF 
			(FormatText) (TextName) = (value_text) "%i" (i) = <value_alpha> 
		CASE (menu_red2) 
			(change) (rain_red2) = ( (rain_red2) + <step> ) 
			IF ( (rain_red2) > 255 ) 
				(change) (rain_red2) = 255 
			ELSE 
				IF ( 0 > (rain_red2) ) 
					(change) (rain_red2) = 0 
				ENDIF 
			ENDIF 
			(FormatText) (TextName) = (value_text) "%i" (i) = (rain_red2) 
		CASE (menu_blue2) 
			(change) (rain_blue2) = ( (rain_blue2) + <step> ) 
			IF ( (rain_blue2) > 255 ) 
				(change) (rain_blue2) = 255 
			ELSE 
				IF ( 0 > (rain_blue2) ) 
					(change) (rain_blue2) = 0 
				ENDIF 
			ENDIF 
			(FormatText) (TextName) = (value_text) "%i" (i) = (rain_blue2) 
		CASE (menu_green2) 
			(change) (rain_green2) = ( (rain_green2) + <step> ) 
			IF ( (rain_green2) > 255 ) 
				(change) (rain_green2) = 255 
			ELSE 
				IF ( 0 > (rain_green2) ) 
					(change) (rain_green2) = 0 
				ENDIF 
			ENDIF 
			(FormatText) (TextName) = (value_text) "%i" (i) = (rain_green2) 
		CASE (menu_alpha2) 
			(change) (rain_alpha2) = ( (rain_alpha2) + <step> ) 
			IF ( (rain_alpha2) > 255 ) 
				(change) (rain_alpha2) = 255 
			ELSE 
				IF ( 0 > (rain_alpha2) ) 
					(change) (rain_alpha2) = 0 
				ENDIF 
			ENDIF 
			(FormatText) (TextName) = (value_text) "%i" (i) = (rain_alpha2) 
	ENDSWITCH 
	(SetScreenElementProps) (id) = { <id> (child) = 0 } (text) = <value_text> 
	<color> = ( <value_red> + ( <value_green> * 256 ) + ( <value_blue> * 65536 ) + ( <value_alpha> * 16777216 ) ) 
	IF (GotParam) (splash) 
		(change) (splash_red) = <value_red> 
		(change) (splash_green) = <value_green> 
		(change) (splash_blue) = <value_blue> 
		(change) (splash_alpha) = <value_alpha> 
		(WeatherSetSplashColor) <color> 
	ENDIF 
	IF (GotParam) (snow) 
		(change) (snow_red) = <value_red> 
		(change) (snow_green) = <value_green> 
		(change) (snow_blue) = <value_blue> 
		(change) (snow_alpha) = <value_alpha> 
		(WeatherSetSnowColor) <color> 
	ENDIF 
	IF (GotParam) (rain) 
		(change) (rain_red) = <value_red> 
		(change) (rain_green) = <value_green> 
		(change) (rain_blue) = <value_blue> 
		(change) (rain_alpha) = <value_alpha> 
		<color2> = ( (rain_red2) + ( (rain_green2) * 256 ) + ( (rain_blue2) * 65536 ) + ( (rain_alpha2) * 16777216 ) ) 
		(WeatherSetRainColor) (top) = <color> (bottom) = <color2> 
	ENDIF 
ENDSCRIPT

SCRIPT (incr_splash_val) (step) = 1 (max) = 128 (min) = 0 
	(GetTags) 
	IF (GotParam) (reverse) 
		(step) = ( -1 * <step> ) 
	ENDIF 
	(step) = ( <step> * (step_multiplier) ) 
	SWITCH <id> 
		CASE (menu_rate) 
			(change) (splash_rate) = ( (splash_rate) + ( <step> / 20.00000000000 ) ) 
			IF ( (splash_rate) > 1 ) 
				(change) (splash_rate) = 1.00000000000 
			ELSE 
				IF ( 0 > (splash_rate) ) 
					(change) (splash_rate) = 0.00000000000 
				ENDIF 
			ENDIF 
			(FormatText) (TextName) = (value_text) "%i" (i) = (splash_rate) 
			(WeatherSetSplashRate) (splash_rate) 
		CASE (menu_life) 
			(change) (splash_life) = ( (splash_life) + <step> ) 
			IF ( (splash_life) > 100 ) 
				(change) (splash_life) = 100 
			ELSE 
				IF ( 1 > (splash_life) ) 
					(change) (splash_life) = 1 
				ENDIF 
			ENDIF 
			(FormatText) (TextName) = (value_text) "%i" (i) = (splash_life) 
			(WeatherSetSplashLife) (splash_life) 
		CASE (menu_size) 
			(change) (splash_size) = ( (splash_size) + <step> ) 
			IF ( (splash_size) > 100 ) 
				(change) (splash_size) = 100 
			ELSE 
				IF ( 0 > (splash_size) ) 
					(change) (splash_size) = 0 
				ENDIF 
			ENDIF 
			(FormatText) (TextName) = (value_text) "%i" (i) = (splash_size) 
			(WeatherSetSplashSize) (splash_size) 
		CASE (menu_blend) 
			IF NOT (GotParam) (reverse) 
				(change) (splash_blend) = ( (splash_blend) + 1 ) 
			ELSE 
				(change) (splash_blend) = ( (splash_blend) - 1 ) 
			ENDIF 
			IF ( (splash_blend) > 10 ) 
				(change) (splash_blend) = 0 
			ELSE 
				IF ( 0 > (splash_blend) ) 
					(change) (splash_blend) = 10 
				ENDIF 
			ENDIF 
			(get_rain_mode_string) (splash) 
			(WeatherSetSplashBlendMode) <checksum> ( (splash_fixed) + 0 ) 
		CASE (menu_fixed) 
			(change) (splash_fixed) = ( (splash_fixed) + <step> ) 
			IF ( (splash_fixed) > 128 ) 
				(change) (splash_fixed) = 128 
			ELSE 
				IF ( 0 > (splash_fixed) ) 
					(change) (splash_fixed) = 0 
				ENDIF 
			ENDIF 
			(get_rain_mode_string) (splash) 
			(WeatherSetSplashBlendMode) <checksum> ( (splash_fixed) + 0 ) 
			(FormatText) (TextName) = (value_text) "%i" (i) = (splash_fixed) 
	ENDSWITCH 
	(SetScreenElementProps) (id) = { <id> (child) = 0 } (text) = <value_text> 
ENDSCRIPT

SCRIPT (incr_snow_val) (step) = 1 (max) = 128 (min) = 0 
	(GetTags) 
	IF (GotParam) (reverse) 
		(step) = ( -1 * <step> ) 
	ENDIF 
	(step) = ( <step> * (step_multiplier) ) 
	SWITCH <id> 
		CASE (menu_rate) 
			(change) (snow_rate) = ( (snow_rate) + <step> ) 
			IF ( (snow_rate) > ( 1024 / (snow_frames) ) ) 
				(change) (snow_rate) = ( 1024 / (snow_frames) ) 
			ELSE 
				IF ( 0 > (snow_rate) ) 
					(change) (snow_rate) = 0 
				ENDIF 
			ENDIF 
			(FormatText) (TextName) = (value_text) "%i" (i) = (snow_rate) 
			(WeatherSetSnowRate) (snow_rate) 
		CASE (menu_frames) 
			(change) (snow_frames) = ( (snow_frames) + <step> ) 
			IF ( (snow_frames) > 254 ) 
				(change) (snow_frames) = 254 
			ELSE 
				IF ( 1 > (snow_frames) ) 
					(change) (snow_frames) = 1 
				ENDIF 
			ENDIF 
			(FormatText) (TextName) = (value_text) "%i" (i) = (snow_frames) 
			(WeatherSetSnowFrames) (snow_frames) 
		CASE (menu_height) 
			(change) (snow_height) = ( (snow_height) + <step> ) 
			IF ( (snow_height) > 3000 ) 
				(change) (snow_height) = 3000 
			ELSE 
				IF ( 0 > (snow_height) ) 
					(change) (snow_height) = 0 
				ENDIF 
			ENDIF 
			(FormatText) (TextName) = (value_text) "%i" (i) = (snow_height) 
			(WeatherSetSnowHeight) (snow_height) 
		CASE (menu_size) 
			(change) (snow_size) = ( (snow_size) + <step> ) 
			IF ( (snow_size) > 200 ) 
				(change) (snow_size) = 200 
			ELSE 
				IF ( 0 > (snow_size) ) 
					(change) (snow_size) = 0 
				ENDIF 
			ENDIF 
			(FormatText) (TextName) = (value_text) "%i" (i) = (snow_size) 
			(WeatherSetSnowSize) (snow_size) 
		CASE (menu_blend) 
			IF NOT (GotParam) (reverse) 
				(change) (snow_blend) = ( (snow_blend) + 1 ) 
			ELSE 
				(change) (snow_blend) = ( (snow_blend) - 1 ) 
			ENDIF 
			IF ( (snow_blend) > 10 ) 
				(change) (snow_blend) = 0 
			ELSE 
				IF ( 0 > (snow_blend) ) 
					(change) (snow_blend) = 10 
				ENDIF 
			ENDIF 
			(get_rain_mode_string) (snow) 
			(WeatherSetSnowBlendMode) <checksum> ( (snow_fixed) + 0 ) 
		CASE (menu_fixed) 
			(change) (snow_fixed) = ( (snow_fixed) + <step> ) 
			IF ( (snow_fixed) > 128 ) 
				(change) (snow_fixed) = 128 
			ELSE 
				IF ( 0 > (snow_fixed) ) 
					(change) (snow_fixed) = 0 
				ENDIF 
			ENDIF 
			(get_rain_mode_string) (snow) 
			(WeatherSetSnowBlendMode) <checksum> ( (snow_fixed) + 0 ) 
			(FormatText) (TextName) = (value_text) "%i" (i) = (snow_fixed) 
	ENDSWITCH 
	(SetScreenElementProps) (id) = { <id> (child) = 0 } (text) = <value_text> 
ENDSCRIPT

(poly_count_on) = 0 
SCRIPT (show_poly_count) 
	IF ( (poly_count_on) = 0 ) 
		(change) (poly_count_on) = 1 
		(GetCurrentLevel) 
		IF ( <level> = (Load_sk5ed) ) 
			(killspawnedscript) (name) = (refresh_poly_count_repeatedly) 
			(spawnscript) (refresh_poly_count_repeatedly) 
		ELSE 
			(refresh_poly_count) 
		ENDIF 
	ELSE 
		(change) (poly_count_on) = 0 
		(killspawnedscript) (name) = (refresh_poly_count_repeatedly) 
		(DestroyScreenElement) (id) = (poly_count_anchor) 
		(DestroyScreenElement) (id) = (tex_count_anchor) 
		IF (ScreenElementExists) (id) = (texture_list) 
			(DestroyScreenElement) (id) = (texture_list) 
		ENDIF 
		(DoScreenElementMorph) { 
			(id) = (the_score_sprite) 
			(scale) = 1 
		} 
		(DoScreenElementMorph) { 
			(id) = (the_score) 
			(scale) = 1 
		} 
		(DoScreenElementMorph) { 
			(id) = (cash_goal_sprite) 
			(scale) = 1 
		} 
		(DoScreenElementMorph) { 
			(id) = (goal_points_text) 
			(scale) = 1 
		} 
		(DoScreenElementMorph) { 
			(id) = (cash_text) 
			(scale) = 1 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT (refresh_poly_count) 
	IF ( (poly_count_on) = 1 ) 
		IF (ScreenElementExists) (id) = (poly_count_anchor) 
			(DestroyScreenElement) (id) = (poly_count_anchor) 
		ENDIF 
		IF (ScreenElementExists) (id) = (tex_count_anchor) 
			(DestroyScreenElement) (id) = (tex_count_anchor) 
		ENDIF 
		IF (ScreenElementExists) (id) = (texture_list) 
			(DestroyScreenElement) (id) = (texture_list) 
		ENDIF 
		(DoScreenElementMorph) { 
			(id) = (the_score_sprite) 
			(scale) = 0 
		} 
		(DoScreenElementMorph) { 
			(id) = (the_score) 
			(scale) = 0 
		} 
		(DoScreenElementMorph) { 
			(id) = (cash_goal_sprite) 
			(scale) = 0 
		} 
		(DoScreenElementMorph) { 
			(id) = (goal_points_text) 
			(scale) = 0 
		} 
		(DoScreenElementMorph) { 
			(id) = (cash_text) 
			(scale) = 0 
		} 
		(GetMetrics) 
		(FormatText) (TextName) = (main_base) "First = %m" (m) = ( ( <metrics> . (mainscene) ) . (BasePolys) ) (UseCommas) 
		(FormatText) (TextName) = (main_other) "Other = %m" (m) = ( ( ( <metrics> . (mainscene) ) . (Polys) ) - ( ( <metrics> . (mainscene) ) . (BasePolys) ) ) (UseCommas) 
		(FormatText) (TextName) = (main_total) "Total = %m" (m) = ( ( <metrics> . (mainscene) ) . (Polys) ) (UseCommas) 
		IF (StructureContains) (structure) = <metrics> (skyscene) 
			(FormatText) (TextName) = (sky_base) "Sky = %m" (m) = ( ( <metrics> . (skyscene) ) . (BasePolys) ) 
		ELSE 
			(sky_base) = "Sky = N/A" 
		ENDIF 
		IF ( ( <metrics> . (scene) ) . (NULLEngineScene) ) 
			(rendered_objects) = "Obj   = N/A" 
			(rendered_meshes) = "Mesh = N/A" 
			(verts_per_poly) = "V/P  = N/A" 
			(polys_per_object) = "P/O  = N/A" 
			(polys_per_mesh) = "P/M  = N/A" 
		ELSE 
			(FormatText) (TextName) = (rendered_objects) "Obj   = %m" (m) = ( ( <metrics> . (scene) ) . (objects) ) 
			(FormatText) (TextName) = (rendered_meshes) "Mesh = %m" (m) = ( ( <metrics> . (scene) ) . (leaf) ) 
			(FormatText) (TextName) = (verts_per_poly) "V/P  = %m" (m) = ( ( <metrics> . (scene) ) . (verts_per_poly) ) 
			(FormatText) (TextName) = (polys_per_object) "P/O  = %m" (m) = ( ( <metrics> . (scene) ) . (polys_per_object) ) 
			(FormatText) (TextName) = (polys_per_mesh) "P/M  = %m" (m) = ( ( <metrics> . (scene) ) . (polys_per_mesh) ) 
		ENDIF 
		(lev_num) = ( ( ( <metrics> . (mainscene) ) . (TextureMemory) ) / 1024 ) 
		(CastToInteger) (lev_num) 
		(FormatText) (TextName) = (lev_tex) "Lev = %m K" (m) = <lev_num> 
		IF (StructureContains) (structure) = <metrics> (skyscene) 
			(sky_num) = ( ( ( <metrics> . (skyscene) ) . (TextureMemory) ) / 1024 ) 
			(CastToInteger) (sky_num) 
			(FormatText) (TextName) = (sky_tex) "Sky = %m K" (m) = <sky_num> 
		ELSE 
			(sky_tex) = "Sky = N/A" 
		ENDIF 
		(SetScreenElementLock) (id) = (root_window) (off) 
		(CreateScreenElement) { 
			(type) = (ContainerElement) 
			(parent) = (root_window) 
			(id) = (poly_count_anchor) 
			(pos) = PAIR(30.00000000000, 40.00000000000) 
			(just) = [ (center) (center) ] 
			(internal_just) = [ (left) (center) ] 
		} 
		(CreateScreenElement) { 
			(type) = (ContainerElement) 
			(parent) = (root_window) 
			(id) = (tex_count_anchor) 
			(pos) = PAIR(460.00000000000, 40.00000000000) 
			(just) = [ (center) (center) ] 
			(internal_just) = [ (left) (center) ] 
		} 
		(CreateScreenElement) { 
			(type) = (textelement) 
			(parent) = (poly_count_anchor) 
			(pos) = PAIR(0.00000000000, -15.00000000000) 
			(text) = "Poly Count" 
			(font) = (dialog) 
			(rgba) = [ 60 60 100 100 ] 
			(just) = [ (left) (center) ] 
			(scale) = 0.80000001192 
		} 
		(CreateScreenElement) { 
			(type) = (textelement) 
			(parent) = (poly_count_anchor) 
			(pos) = PAIR(0.00000000000, 0.00000000000) 
			(text) = <main_base> 
			(font) = (dialog) 
			(rgba) = [ 58 108 58 100 ] 
			(just) = [ (left) (center) ] 
			(scale) = 0.80000001192 
		} 
		(CreateScreenElement) { 
			(type) = (textelement) 
			(parent) = (poly_count_anchor) 
			(pos) = PAIR(0.00000000000, 15.00000000000) 
			(text) = <main_other> 
			(font) = (dialog) 
			(rgba) = [ 58 108 58 100 ] 
			(just) = [ (left) (center) ] 
			(scale) = 0.80000001192 
		} 
		(CreateScreenElement) { 
			(type) = (textelement) 
			(parent) = (poly_count_anchor) 
			(pos) = PAIR(0.00000000000, 30.00000000000) 
			(text) = <main_total> 
			(font) = (dialog) 
			(rgba) = [ 58 108 58 100 ] 
			(just) = [ (left) (center) ] 
			(scale) = 0.80000001192 
		} 
		(CreateScreenElement) { 
			(type) = (textelement) 
			(parent) = (poly_count_anchor) 
			(pos) = PAIR(0.00000000000, 45.00000000000) 
			(text) = <sky_base> 
			(font) = (dialog) 
			(rgba) = [ 58 108 58 100 ] 
			(just) = [ (left) (center) ] 
			(scale) = 0.80000001192 
		} 
		(CreateScreenElement) { 
			(type) = (textelement) 
			(parent) = (poly_count_anchor) 
			(pos) = PAIR(0.00000000000, 60.00000000000) 
			(text) = <rendered_objects> 
			(font) = (dialog) 
			(rgba) = [ 58 108 58 100 ] 
			(just) = [ (left) (center) ] 
			(scale) = 0.80000001192 
		} 
		(CreateScreenElement) { 
			(type) = (textelement) 
			(parent) = (poly_count_anchor) 
			(pos) = PAIR(0.00000000000, 75.00000000000) 
			(text) = <rendered_meshes> 
			(font) = (dialog) 
			(rgba) = [ 58 108 58 100 ] 
			(just) = [ (left) (center) ] 
			(scale) = 0.80000001192 
		} 
		(CreateScreenElement) { 
			(type) = (textelement) 
			(parent) = (poly_count_anchor) 
			(pos) = PAIR(0.00000000000, 90.00000000000) 
			(text) = <verts_per_poly> 
			(font) = (dialog) 
			(rgba) = [ 58 108 58 100 ] 
			(just) = [ (left) (center) ] 
			(scale) = 0.80000001192 
		} 
		(CreateScreenElement) { 
			(type) = (textelement) 
			(parent) = (poly_count_anchor) 
			(pos) = PAIR(0.00000000000, 105.00000000000) 
			(text) = <polys_per_object> 
			(font) = (dialog) 
			(rgba) = [ 58 108 58 100 ] 
			(just) = [ (left) (center) ] 
			(scale) = 0.80000001192 
		} 
		(CreateScreenElement) { 
			(type) = (textelement) 
			(parent) = (poly_count_anchor) 
			(pos) = PAIR(0.00000000000, 120.00000000000) 
			(text) = <polys_per_mesh> 
			(font) = (dialog) 
			(rgba) = [ 58 108 58 100 ] 
			(just) = [ (left) (center) ] 
			(scale) = 0.80000001192 
		} 
		(CreateScreenElement) { 
			(type) = (textelement) 
			(parent) = (tex_count_anchor) 
			(pos) = PAIR(0.00000000000, -15.00000000000) 
			(text) = "Texture Mem" 
			(font) = (dialog) 
			(rgba) = [ 60 60 100 100 ] 
			(just) = [ (left) (center) ] 
			(scale) = 0.80000001192 
		} 
		(CreateScreenElement) { 
			(type) = (textelement) 
			(parent) = (tex_count_anchor) 
			(pos) = PAIR(0.00000000000, 0.00000000000) 
			(text) = <lev_tex> 
			(font) = (dialog) 
			(rgba) = [ 58 108 58 100 ] 
			(just) = [ (left) (center) ] 
			(scale) = 0.80000001192 
		} 
		(CreateScreenElement) { 
			(type) = (textelement) 
			(parent) = (tex_count_anchor) 
			(pos) = PAIR(0.00000000000, 15.00000000000) 
			(text) = <sky_tex> 
			(font) = (dialog) 
			(rgba) = [ 58 108 58 100 ] 
			(just) = [ (left) (center) ] 
			(scale) = 0.80000001192 
		} 
		(display_current_level_texture_values) 
		(removeparameter) (metrics) 
		(removeparameter) (main_base) 
		(removeparameter) (main_other) 
		(removeparameter) (sky_base) 
		(removeparameter) (lev_tex) 
		(removeparameter) (sky_tex) 
	ENDIF 
ENDSCRIPT

SCRIPT (refresh_poly_count_repeatedly) 
	BEGIN 
		(refresh_poly_count) 
		(wait) 0.50000000000 (seconds) 
	REPEAT 
ENDSCRIPT

SCRIPT (switch_off_poly_count_refresh) 
	(change) (poly_count_on) = 0 
	(killspawnedscript) (name) = (refresh_poly_count_repeatedly) 
ENDSCRIPT


