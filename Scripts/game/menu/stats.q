
stat_names = [ { name = air string = "Air" description = "Your jump height out of \\na half pipe" } 
	{ name = lip_balance string = "Lip" description = "How well you balance during lip trick stalls" } 
	{ name = run string = "Run" description = "How long your run timer will last" } 
	{ name = flip_speed string = "Flip Speed" short_string = "Flip" description = "How fast your flip \\ntricks will turn" } 
	{ name = rail_balance string = "Rail" description = "How well you balance \\non rails" } 
	{ name = spin string = "Spin" description = "How fast you spin \\nin the air" } 
	{ name = ollie string = "Ollie" description = "How high you jump on \\nflat ground" } 
	{ name = speed string = "Speed" description = "Your top speed on \\nthe ground" } 
	{ name = switch string = "Switch" description = "When maxed, skate equally well switch and regular" } 
	{ name = manual_balance string = "Manual" description = "How well you balance \\nduring manuals" } 
] 
manual_increase_text = "Manual +1" 
rail_increase_text = "Rail +1" 
lip_increase_text = "Lip +1" 
speed_increase_text = "Speed +1" 
ollie_increase_text = "Ollie +1" 
air_increase_text = "Air +1" 
flip_increase_text = "Flip +1" 
switch_increase_text = "Switch +1" 
spin_increase_text = "Spin +1" 
run_increase_text = "Run +1" 
stats_goals = [ 
	{ stattype = manual_balance goaltype = manualtime value = [ 2 , 4 , 6 ] complete = 0 text = "Manual for %i seconds" } 
	{ stattype = manual_balance goaltype = manualtime value = [ 4 , 6 , 10 ] complete = 0 text = "Manual for %i seconds" } 
	{ stattype = manual_balance goaltype = manualtime value = [ 6 , 8 , 14 ] complete = 0 text = "Manual for %i seconds" } 
	{ stattype = manual_balance goaltype = manualtime value = [ 8 , 10 , 17 ] complete = 2 text = "Manual for %i seconds" } 
	{ stattype = manual_balance goaltype = trickcount value = [ 1 , 3 , 5 ] complete = 2 text = "%s %i times in one combo" value_trick = [ Manual , Manual , Pogo ] value_string = [ "Manual" , "Manual" , "Pogo" ] value_taps = [ 1 , 1 , 1 ] } 
	{ stattype = manual_balance goaltype = trickcount value = [ 2 , 5 , 6 ] complete = 3 text = "%s %i times in one combo" value_trick = [ Manual , Manual , Casper ] value_string = [ "Manual" , "Manual" , "Casper" ] value_taps = [ 1 , 1 , 1 ] } 
	{ stattype = manual_balance goaltype = trickcount value = [ 3 , 2 , 6 ] complete = 3 text = "%s %i times in one combo" value_trick = [ Manual , Pogo , %"Half Cab Impossible" ] value_string = [ "Manual" , "Pogo" , "Half Cab Impossible" ] value_taps = [ 1 , 1 , 1 ] } 
	{ stattype = rail_balance goaltype = grindtime value = [ 4 , 5 , 10 ] complete = 0 text = "Grind for %i seconds" } 
	{ stattype = rail_balance goaltype = grindtime value = [ 6 , 10 , 15 ] complete = 0 text = "Grind for %i seconds" } 
	{ stattype = rail_balance goaltype = grindtime value = [ 8 , 15 , 20 ] complete = 0 text = "Grind for %i seconds" } 
	{ stattype = rail_balance goaltype = grindtime value = [ 10 , 20 , 25 ] complete = 2 text = "Grind for %i seconds" } 
	{ stattype = rail_balance goaltype = stringcount value = [ 2 , 3 , 5 ] complete = 2 text = "%s %i times in one combo" value_string = [ "50-50" , "50-50" , "Crooked" ] } 
	{ stattype = rail_balance goaltype = stringcount value = [ 3 , 3 , 5 ] complete = 3 text = "%s %i times in one combo" value_string = [ "50-50" , "Nosegrind" , "Lipslide" ] } 
	{ stattype = rail_balance goaltype = stringcount value = [ 4 , 3 , 5 ] complete = 3 text = "%s %i times in one combo" value_string = [ "50-50" , "Crooked" , "Darkslide" ] } 
	{ stattype = lip_balance goaltype = liptime value = [ 1 , 2 , 3 ] complete = 0 text = "Hold a liptrick for %i seconds" } 
	{ stattype = lip_balance goaltype = liptime value = [ 2 , 3 , 5 ] complete = 0 text = "Hold a liptrick for %i seconds" } 
	{ stattype = lip_balance goaltype = liptime value = [ 3 , 4 , 7 ] complete = 0 text = "Hold a liptrick for %i seconds" } 
	{ stattype = lip_balance goaltype = liptime value = [ 4 , 5 , 9 ] complete = 2 text = "Hold a liptrick for %i seconds" } 
	{ stattype = lip_balance goaltype = liptime value = [ 5 , 6 , 11 ] complete = 2 text = "Hold a liptrick for %i seconds" } 
	{ stattype = lip_balance goaltype = liptime value = [ 6 , 7 , 13 ] complete = 3 text = "Hold a liptrick for %i seconds" } 
	{ stattype = lip_balance goaltype = liptime value = [ 7 , 8 , 15 ] complete = 3 text = "Hold a liptrick for %i seconds" } 
	{ stattype = speed goaltype = combo value = [ 1000 , 10000 , 100000 ] complete = 0 text = "Land a %i point combo" } 
	{ stattype = speed goaltype = combo value = [ 5000 , 20000 , 200000 ] complete = 0 text = "Land a %i point combo" } 
	{ stattype = speed goaltype = combo value = [ 7500 , 30000 , 400000 ] complete = 0 text = "Land a %i point combo" } 
	{ stattype = speed goaltype = combo value = [ 10000 , 50000 , 600000 ] complete = 2 text = "Land a %i point combo" } 
	{ stattype = speed goaltype = combo value = [ 15000 , 75000 , 800000 ] complete = 2 text = "Land a %i point combo" } 
	{ stattype = speed goaltype = combo value = [ 20000 , 100000 , 1000000 ] complete = 3 text = "Land a %i point combo" } 
	{ stattype = speed goaltype = combo value = [ 30000 , 250000 , 2000000 ] complete = 3 text = "Land a %i point combo" } 
	{ stattype = air goaltype = vertdist value = [ 10 , 20 , 30 ] complete = 0 text = "Air transfer %i feet" } 
	{ stattype = air goaltype = vertdist value = [ 15 , 30 , 40 ] complete = 0 text = "Air transfer %i feet" } 
	{ stattype = air goaltype = vertdist value = [ 20 , 40 , 60 ] complete = 0 text = "Air transfer %i feet" } 
	{ stattype = air goaltype = vertdist value = [ 25 , 50 , 70 ] complete = 2 text = "Air transfer %i feet" } 
	{ stattype = air goaltype = vertscore value = [ 500 , 5000 , 10000 ] complete = 2 text = "Land a %i point air" } 
	{ stattype = air goaltype = vertscore value = [ 1000 , 10000 , 20000 ] complete = 3 text = "Land a %i point air" } 
	{ stattype = air goaltype = vertscore value = [ 2000 , 15000 , 40000 ] complete = 3 text = "Land a %i point air" } 
	{ stattype = run goaltype = stringcount value = [ 1 , 2 , 3 ] complete = 0 text = "%s %i times in one combo" value_string = [ "Caveman" , "Caveman" , "Caveman" ] } 
	{ stattype = run goaltype = stringcount value = [ 2 , 3 , 5 ] complete = 0 text = "%s %i times in one combo" value_string = [ "Caveman" , "Caveman" , "Caveman" ] } 
	{ stattype = run goaltype = stringcount value = [ 3 , 4 , 7 ] complete = 0 text = "%s %i times in one combo" value_string = [ "Caveman" , "Caveman" , "Caveman" ] } 
	{ stattype = run goaltype = trickcount value = [ 1 , 2 , 5 ] complete = 2 text = "%s %i times in one combo" value_trick = [ Wallplant , Wallplant , Wallplant ] value_string = [ "Wallplant" , "Wallplant" , "Wallplant" ] value_taps = [ 1 , 1 , 1 ] } 
	{ stattype = run goaltype = vertheight value = [ 10 , 20 , 30 ] complete = 2 text = "Air %i feet high" } 
	{ stattype = run goaltype = vertheight value = [ 20 , 40 , 60 ] complete = 3 text = "Air %i feet high" } 
	{ stattype = run goaltype = vertheight value = [ 30 , 60 , 90 ] complete = 3 text = "Air %i feet high" } 
	{ stattype = switch goaltype = multiplier value = [ 3 , 4 , 10 ] complete = 0 text = "Land a %i trick combo" } 
	{ stattype = switch goaltype = multiplier value = [ 4 , 5 , 20 ] complete = 0 text = "Land a %i trick combo" } 
	{ stattype = switch goaltype = multiplier value = [ 5 , 6 , 30 ] complete = 0 text = "Land a %i trick combo" } 
	{ stattype = switch goaltype = multiplier value = [ 6 , 7 , 40 ] complete = 2 text = "Land a %i trick combo" } 
	{ stattype = switch goaltype = multiplier value = [ 7 , 10 , 50 ] complete = 2 text = "Land a %i trick combo" } 
	{ stattype = switch goaltype = multiplier value = [ 8 , 15 , 60 ] complete = 3 text = "Land a %i trick combo" } 
	{ stattype = switch goaltype = multiplier value = [ 9 , 20 , 70 ] complete = 3 text = "Land a %i trick combo" } 
	{ stattype = spin goaltype = vertspin value = [ 360 , 540 , 720 ] complete = 0 text = "Land a %i grab or fliptrick in a halfpipe" no_commas } 
	{ stattype = spin goaltype = vertspin value = [ 540 , 720 , 900 ] complete = 0 text = "Land a %i grab or fliptrick in a halfpipe" no_commas } 
	{ stattype = spin goaltype = vertspin value = [ 720 , 900 , 1080 ] complete = 0 text = "Land a %i grab or fliptrick in a halfpipe" no_commas } 
	{ stattype = spin goaltype = numgrabs value = [ 2 , 3 , 5 ] complete = 2 text = "Do %i grabs in one combo" } 
	{ stattype = spin goaltype = numgrabs value = [ 3 , 4 , 10 ] complete = 2 text = "Do %i grabs in one combo" } 
	{ stattype = spin goaltype = numgrabs value = [ 4 , 6 , 15 ] complete = 3 text = "Do %i grabs in one combo" } 
	{ stattype = spin goaltype = numgrabs value = [ 5 , 8 , 20 ] complete = 3 text = "Do %i grabs in one combo" } 
	{ stattype = ollie goaltype = olliedist value = [ 15 , 25 , 40 ] complete = 0 text = "Ollie %s feet" value_string = [ "5" , "10" , "20" ] } 
	{ stattype = ollie goaltype = olliedist value = [ 25 , 35 , 50 ] complete = 0 text = "Ollie %s feet" value_string = [ "10" , "15" , "25" ] } 
	{ stattype = ollie goaltype = olliedist value = [ 30 , 45 , 60 ] complete = 0 text = "Ollie %s feet" value_string = [ "15" , "20" , "30" ] } 
	{ stattype = ollie goaltype = highollie value = [ 5 , 10 , 20 ] complete = 2 text = "Ollie up %i feet" } 
	{ stattype = ollie goaltype = highollie value = [ 10 , 20 , 25 ] complete = 2 text = "Ollie up %i feet" } 
	{ stattype = ollie goaltype = olliedrop value = [ 10 , 15 , 25 ] complete = 3 text = "Ollie down %i feet" } 
	{ stattype = ollie goaltype = olliedrop value = [ 15 , 20 , 35 ] complete = 3 text = "Ollie down %i feet" } 
	{ stattype = flip_speed goaltype = numfliptricks value = [ 2 , 3 , 5 ] complete = 0 text = "Do %i fliptricks in one combo" } 
	{ stattype = flip_speed goaltype = numfliptricks value = [ 3 , 4 , 10 ] complete = 0 text = "Do %i fliptricks in one combo" } 
	{ stattype = flip_speed goaltype = trickcount value = [ 1 , 2 , 4 ] complete = 0 text = "%s %i times in one combo" value_trick = [ Trick_Kickflip , Trick_Kickflip , Trick_Heelflip ] value_string = [ "Double Kickflip" , "Double Kickflip" , "Double Heelflip" ] value_taps = [ 2 , 2 , 2 ] } 
	{ stattype = flip_speed goaltype = trickcount value = [ 2 , 2 , 3 ] complete = 2 text = "%s %i times in one combo" value_trick = [ Trick_Kickflip , Trick_Kickflip , Trick_Kickflip ] value_string = [ "Double Kickflip" , "Triple Kickflip" , "Triple Kickflip" ] value_taps = [ 2 , 3 , 3 ] } 
	{ stattype = flip_speed goaltype = numfliptricks value = [ 4 , 5 , 20 ] complete = 2 text = "Do %i fliptricks in one combo" } 
	{ stattype = flip_speed goaltype = numfliptricks value = [ 5 , 8 , 30 ] complete = 3 text = "Do %i fliptricks in one combo" } 
	{ stattype = flip_speed goaltype = numfliptricks value = [ 6 , 10 , 40 ] complete = 3 text = "Do %i fliptricks in one combo" } 
] 
SCRIPT show_stats_message 
	SpawnScript show_stats_message2 params = { <...> } 
ENDSCRIPT

SCRIPT show_stats_message2 
	IF GotParam got_it 
		rgba = [ 0 90 0 128 ] 
		wait_and_die = wait_and_die 
	ELSE 
		rgba = [ 100 100 100 128 ] 
		dont_die = dont_die 
	ENDIF 
	IF GotParam value 
		IF NOT StructureContains structure = ( stats_goals [ <index> ] ) no_commas 
			FormatText textname = text <string> i = <value> s = <vstring> UseCommas 
		ELSE 
			FormatText textname = text <string> i = <value> s = <vstring> 
		ENDIF 
	ENDIF 
	create_console_message text = <text> rgba = <rgba> wait_and_die = <wait_and_die> dont_die = <dont_die> time = 3 
ENDSCRIPT

SCRIPT stats_message_bail 
	IF NOT InNetGame 
		console_clear 
	ENDIF 
ENDSCRIPT

SCRIPT stats_message_land 
	SpawnScript stats_message_land2 params = { <...> } 
ENDSCRIPT

SCRIPT stats_message_land2 
	index = 0 
	BEGIN 
		id = { console_message_vmenu child = <index> } 
		IF ScreenElementExists id = <id> 
			RunScriptOnScreenElement id = <id> console_message_wait_and_die params = { time = 2 } 
		ELSE 
			BREAK 
		ENDIF 
		index = ( <index> + 1 ) 
	REPEAT 
ENDSCRIPT

bump_stats = 0 
SCRIPT update_stats_goal_complete_status 
	SpawnScript update_stats_goal_complete_status2 params = { <...> } 
ENDSCRIPT

SCRIPT update_stats_goal_complete_status2 
	IF NOT GotParam index 
		printf "update_stats_goal_complete_status requires index param" 
		RETURN 
	ENDIF 
	stattype = ( ( stats_goals [ <index> ] ) . stattype ) 
	goaltype = ( ( stats_goals [ <index> ] ) . goaltype ) 
	value = ( ( stats_goals [ <index> ] ) . value ) 
	text = ( ( stats_goals [ <index> ] ) . text ) 
	IF StructureContains structure = ( stats_goals [ <index> ] ) value_string 
		value_string = ( ( stats_goals [ <index> ] ) . value_string ) 
	ENDIF 
	stats_goals_dummy = stats_goals 
	SetArrayElement ArrayName = stats_goals_dummy index = <index> newvalue = { complete = 1 
		stattype = <stattype> 
		goaltype = <goaltype> 
		value = <value> 
		text = <text> 
		value_string = <value_string> 
	} 
ENDSCRIPT

SCRIPT beat_first_stat_goal 
	printf "beat_first_stat_goal-----------------------------" 
	IF ( bump_stats = 0 ) 
		RETURN 
	ENDIF 
	PauseGame 
	wait 1 gameframe 
	PauseMusicAndStreams 1 
	pause_trick_text 
	pause_balance_meter 
	pause_run_timer 
	kill_blur 
	IF ObjectExists id = speech_box_anchor 
		RunScriptOnScreenElement id = speech_box_anchor hide_screen_element 
	ENDIF 
	IF ScreenElementExists id = goal_start_dialog 
		DestroyScreenElement id = goal_start_dialog 
	ENDIF 
	IF ObjectExists id = ped_speech_dialog 
		DestroyScreenElement id = ped_speech_dialog 
	ENDIF 
	IF ObjectExists id = goal_retry_anchor 
		DestroyScreenElement id = goal_retry_anchor 
	ENDIF 
	hide_goal_panel_messages 
	GoalManager_PauseAllGoals 
	create_dialog_box { 
		title = "Stat Increased!" 
		text = "Beating Stat Challenges will increase your skating abilities. Pause the game and go to the View Stats menu to see a list of challenges." 
		buttons = [ { font = small text = "Ok" pad_choose_script = kill_stat_goal_dialog } ] 
	} 
	SpawnScript stats_message_kill_vibration 
ENDSCRIPT

SCRIPT stats_message_kill_vibration 
	wait 3 gameframes 
	Skater : Vibrate off 
ENDSCRIPT

SCRIPT kill_stat_goal_dialog 
	dialog_box_exit 
	KillSpawnedScript name = stats_message_kill_vibration 
	unpause_trick_text 
	unpause_balance_meter 
	unpause_run_timer 
	show_goal_panel_messages 
	GoalManager_UnpauseAllGoals 
	UnpauseGame 
	wait 1 gameframe 
	UnpauseMusicAndStreams 
ENDSCRIPT

SCRIPT show_vert_combo_message 
	FormatText textname = text "%i Point Air Combo" i = <score> 
	create_console_message text = <text> rgba = [ 50 50 90 128 ] wait_and_die = wait_and_die time = 3 
ENDSCRIPT

SCRIPT stat_play_win_sound 
	stat_message_popup 
	spawnsound stat_goal_success 
ENDSCRIPT

SCRIPT showed_stat_message_sound 
	spawnsound stat_goal_appear 
ENDSCRIPT

SCRIPT stat_message_popup 
	FormatText textname = message "Stats Increased!" 
	create_panel_message { 
		id = stat_completed_message 
		text = <message> 
		style = goal_message_stat_up 
	} 
ENDSCRIPT

SCRIPT hide_stat_message 
	IF ObjectExists id = stat_completed_message 
		DoScreenElementMorph id = stat_completed_message time = 0 alpha = 0 
	ENDIF 
ENDSCRIPT

SCRIPT unhide_stat_message 
	IF ObjectExists id = stat_completed_message 
		DoScreenElementMorph id = stat_completed_message time = 0 restore_alpha 
	ENDIF 
ENDSCRIPT


