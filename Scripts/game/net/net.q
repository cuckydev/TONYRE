InNetOptionsFromNetPlay = 0 
InNetOptionsFromFaceDownload = 0 
has_accepted_dnas = 0 
SCRIPT launch_viewer 
	printf "launch_viewer is no longer needed ... you can remove it from your startup script" 
ENDSCRIPT

SCRIPT auto_launch_viewer 
	LoadFromMemoryCard Name = "Network settings" Type = NetworkSettings 
	UseNetworkPreferences 
	LaunchViewer 
ENDSCRIPT

NO_NET_MODE = 0 
LAN_MODE = 1 
INTERNET_MODE = 2 
HOST_MODE_SERVE = 0 
HOST_MODE_AUTO_SERVE = 1 
HOST_MODE_FCFS = 2 
JOIN_MODE_PLAY = 0 
JOIN_MODE_OBSERVE = 1 
e3_level_info = [ 
	{ Name = "College" checksum = load_sch } 
	{ Name = "Zoo" checksum = load_zoo } 
] 
level_info = [ 
	{ Name = "College" checksum = load_sch } 
	{ Name = "San Francisco" checksum = load_sf2 } 
	{ Name = "Alcatraz" checksum = load_alc } 
	{ Name = "Shipyard" checksum = load_jnk } 
	{ Name = "London" checksum = load_lon } 
	{ Name = "Kona" checksum = load_kon } 
	{ Name = "Zoo" checksum = load_zoo } 
	{ Name = "Carnival" checksum = load_cnv } 
	{ Name = "Chicago" checksum = load_hof } 
	{ Name = "Created Park" checksum = load_sk5ed_gameplay } 
] 
num_players_info = [ 
	{ Name = "2 Players" checksum = num_2 num = 2 } 
	{ Name = "3 Players" checksum = num_3 num = 3 } 
	{ Name = "4 Players" checksum = num_4 num = 4 broadband_only } 
	{ Name = "5 Players" checksum = num_5 num = 5 broadband_only } 
	{ Name = "6 Players" checksum = num_6 num = 6 broadband_only } 
	{ Name = "7 Players" checksum = num_7 num = 7 broadband_only } 
	{ Name = "8 Players" checksum = num_8 num = 8 broadband_only } 
] 
net_game_type_info = [ 
	{ Name = "Trick Attack" description = "Player with the highest score at the end of the time limit wins" checksum = nettrickattack goal_script = StartGoal_TrickAttack icon = "2p_attack" } 
	{ Name = "Score Challenge" description = "The first player to reach the\\nset score wins" checksum = netscorechallenge goal_script = StartGoal_ScoreChallenge icon = "2p_score" } 
	{ Name = "Combo Mambo" description = "The player who busts the biggest combo during the time limit, wins" checksum = netcombomambo goal_script = StartGoal_ComboMambo icon = "2p_mambo" } 
	{ Name = "Slap!" description = "The player who slaps their opponents the most times, wins" checksum = netslap goal_script = StartGoal_Slap icon = "2p_slap" } 
	{ Name = "King of the Hill" description = "The player who holds the crown\\nfor the set time wins" checksum = netking goal_script = StartGoal_King icon = "2p_koth" } 
	{ Name = "Graffiti" description = "The player who tags the most objects wins" checksum = netgraffiti goal_script = StartGoal_Graffiti icon = "2p_graffiti" } 
	{ Name = "Goal Attack" description = "First one to finish all the \\nselected goals wins" checksum = netgoalattack goal_script = StartGoal_GoalAttack icon = "2p_goal" } 
	{ Name = "Capture the Flag" description = "Capture another team\'s flag and return it to your base" checksum = netctf goal_script = StartGoal_CTF icon = "2p_flag" } 
	{ Name = "FireFight" description = "Launch fireballs with\\n either \\b1\\b7 or \\b1\\b4.\\nLast man standing wins." checksum = netfirefight goal_script = StartGoal_FireFight icon = "2p_fire" } 
] 
net_game_type_info_demo = [ 
	{ Name = "Trick Attack" description = "Player with the highest score at the end of the time limit wins" checksum = nettrickattack goal_script = StartGoal_TrickAttack icon = "2p_attack" } 
	{ Name = "Slap!" description = "Player who slaps their opponent the most times within the time limit wins" checksum = netslap goal_script = StartGoal_Slap icon = "2p_slap" } 
	{ Name = "King of the Hill" description = "Player who holds the crown for the set time wins" checksum = netking goal_script = StartGoal_King icon = "2p_koth" } 
	{ Name = "Graffiti" description = "Player who tags the most objects wins" checksum = netgraffiti goal_script = StartGoal_Graffiti icon = "2p_graffiti" } 
] 
mp_game_type_info = [ 
	{ Name = "Trick Attack" description = "Player with the highest score at the end of the time limit wins" checksum = trickattack goal_script = StartGoal_TrickAttack icon = "2p_attack" } 
	{ Name = "Score Challenge" description = "First one to reach set score wins" checksum = scorechallenge goal_script = StartGoal_ScoreChallenge icon = "2p_score" } 
	{ Name = "Combo Mambo" description = "The player who busts the biggest combo during the time limit, wins!" checksum = combomambo goal_script = StartGoal_ComboMambo icon = "2p_mambo" } 
	{ Name = "Slap!" description = "Player who slaps their opponent the most times within the time limit wins" checksum = slap goal_script = StartGoal_Slap icon = "2p_slap" } 
	{ Name = "King of the Hill" description = "Player who holds the crown for the set time wins" checksum = king goal_script = StartGoal_King icon = "2p_koth" } 
	{ Name = "Graffiti" description = "Player who tags the most objects wins" checksum = graffiti goal_script = StartGoal_Graffiti icon = "2p_graffiti" } 
	{ Name = "Horse" description = "Pull off combos until someone spells horse" checksum = horse goal_script = do_nothing icon = "2p_horse" } 
	{ Name = "Free Skate" description = "Skate the level freely" checksum = freeskate2p goal_script = StartFreeSkate icon = "2p_free" } 
	{ Name = "FireFight" description = "Launch fireballs with\\n either \\b1\\b7 or \\b1\\b4.\\nLast man standing wins." checksum = firefight goal_script = StartGoal_FireFight icon = "2p_fire" } 
] 
num_observers_info = [ 
	{ Name = "No Observers" checksum = num_0 } 
	{ Name = "1 Observer" checksum = num_1 broadband_only } 
] 
net_goal_info = [ 
	{ Name = "Story Mode" checksum = goals_story } 
	{ Name = "Created" checksum = goals_created } 
] 
skill_level_info = [ 
	{ Name = "1: Baby Steps" checksum = num_1 } 
	{ Name = "2: I Can Crawl!" checksum = num_2 } 
	{ Name = "3: Hold My Own" checksum = num_3 } 
	{ Name = "4: Let\'s Do This" checksum = num_4 } 
	{ Name = "5: Bring It On!" checksum = num_5 } 
] 
fireball_level_info = [ 
	{ Name = "1 (easy)" checksum = num_1 fireball_level = 1 } 
	{ Name = "2" checksum = num_2 fireball_level = 2 } 
	{ Name = "3" checksum = num_3 fireball_level = 3 } 
	{ Name = "4" checksum = num_4 fireball_level = 4 } 
	{ Name = "5 (hard)" checksum = num_5 fireball_level = 5 } 
] 
SCRIPT sign_out 
	SignOut 
	create_pause_menu 
ENDSCRIPT

SCRIPT go_to_xbox_dashboard 
	GotoXboxDashboard 
ENDSCRIPT

SCRIPT create_big_black_hiding_box 
	unlock_root_window 
	IF ScreenElementExists id = big_black_box 
		DestroyScreenElement id = big_black_box 
	ENDIF 
	CreateScreenElement { 
		Type = SpriteElement 
		parent = root_window 
		id = big_black_box 
		texture = black 
		pos = PAIR(320, 240) 
		rgba = [ 0 0 0 128 ] 
		scale = PAIR(190, 190) 
		just = [ center center ] 
		z_priority = 5001 
	} 
ENDSCRIPT

SCRIPT quit_network_game 
	IF OnXbox 
		DisplayLoadingScreen "loadscrn_generic" 17 
	ELSE 
		create_big_black_hiding_box 
	ENDIF 
	console_destroy 
	SetScreenElementProps { 
		id = root_window 
		event_handlers = [ 
			{ pad_start handle_start_pressed } 
		] 
		replace_handlers 
	} 
	IF InInternetMode 
		IF OnServer 
			ReportStats final 
		ENDIF 
		IF ProfileLoggedIn 
			SetLobbyStatus 
		ENDIF 
		CancelNatNegotiation 
	ENDIF 
	IF ObjectExists id = skater 
		IF NOT IsObserving 
			skater : NetEnablePlayerInput 
			skater : DestroyAllSpecialItems 
		ENDIF 
	ENDIF 
	IF NOT IsObserving 
		ExitSurveyorMode 
	ENDIF 
	ProximCleanup 
	chosen_leave_server 
	dialog_box_exit anchor_id = quit_dialog_anchor 
	dialog_box_exit 
	IF IsInternetGameHost 
		QuitGame 
		RETURN 
	ENDIF 
	IF IsJoiningInternetGame 
		QuitGame 
		RETURN 
	ENDIF 
	SetGameType career 
	SetCurrentGameType 
	SetStatOverride 
	setservermode on 
	StartServer 
	SetJoinMode JOIN_MODE_PLAY 
	SetNetworkMode LAN_MODE 
	JoinServer 
	BEGIN 
		IF JoinServerComplete 
			BREAK 
		ELSE 
			Wait 1 
		ENDIF 
	REPEAT 
	IF InInternetMode 
		SetQuietMode OFF 
	ENDIF 
	SetGameType NetLobby 
	SetCurrentGameType 
	level_select_change_level level = Load_skateshop no_levelUnload 
	SetNetworkMode 
ENDSCRIPT

SCRIPT spawned_chosen_host_game 
	IF IsXbox 
		DisplayLoadingScreen "loadscrn_system_link_x" 
	ENDIF 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
		Wait 1 frame 
	ENDIF 
	IF IsXbox 
		DisplayLoadingScreen "loadscrn_system_link_x" 
	ENDIF 
	leave_front_end 
	Cleanup preserve_skaters 
	IF NOT IsXbox 
		DisplayLoadingScreen "loadscrn_Online" 
	ENDIF 
	FreeServerList 
	LeaveServer 
	SetGameType NetLobby 
	SetCurrentGameType 
	InitSkaterHeaps 
	setservermode 
	StartServer 
	SetJoinMode JOIN_MODE_PLAY 
	JoinServer 
	BEGIN 
		IF JoinServerComplete 
			BREAK 
		ELSE 
			Wait 1 
		ENDIF 
	REPEAT 
	ChangeLevel level = use_preferences 
	exit_pause_menu 
ENDSCRIPT

SCRIPT chosen_host_game 
	change in_server_options = 0 
	IF InNetGame 
		network_start_selected 
	ELSE 
		IF InSplitScreenGame 
			ApplySplitScreenOptions 
			chosen_start_game 
		ELSE 
			change check_for_unplugged_controllers = 0 
			change is_changing_levels = 1 
			SpawnScript spawned_chosen_host_game NotSessionSpecific = 1 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT select_network_play 
	change network_connection_type = internet 
	PauseMusicAndStreams 
	change_gamemode_net 
	GoalManager_SetDifficultyLevel 1 
	do_network_setup error_script = back_from_startup_error_dialog success_script = net_setup_from_net_play_successful need_setup_script = create_net_startup_need_setup_dialog 
ENDSCRIPT

SCRIPT net_setup_from_net_play_successful 
	dialog_box_exit 
	PauseMusicAndStreams 
	launch_select_skater_menu change_gamemode = change_gamemode_net 
ENDSCRIPT

SCRIPT do_network_setup 
	SetMemThreadSafe 
	UseNetworkPreferences 
	SpawnScript test_network_setup params = <...> 
ENDSCRIPT

SCRIPT spoof_usb_adaptor_setup 
	set_preferences_from_ui prefs = network field = "device_type" string = "USB Ethernet Adaptor" checksum = device_broadband_usb 
ENDSCRIPT

SCRIPT spoof_pcmcia_adaptor_setup 
	set_preferences_from_ui prefs = network field = "device_type" string = "Ethernet (Network Adaptor for PS2)" checksum = device_broadband_pc 
ENDSCRIPT

SCRIPT test_network_setup 
	IF levelIs Load_skateshop 
		skater : hide 
	ENDIF 
	PauseMusicAndStreams 
	IF NOT OnXbox 
		GetPreferenceChecksum pref_type = network device_type 
		SWITCH <checksum> 
			CASE device_none 
				<need_setup_script> text = net_status_need_to_setup <...> 
				RETURN 
			CASE device_sony_modem 
			CASE device_usb_modem 
				GetPreferenceString pref_type = network dialup_number 
				IF ( <ui_string> = "" ) 
					<need_setup_script> text = net_status_need_to_setup_dialup <...> 
					RETURN 
				ENDIF 
			DEFAULT 
		ENDSWITCH 
	ENDIF 
	IF NeedToTestNetSetup 
		PauseMusicAndStreams 
		create_testing_network_settings_dialog 
		Wait 1 Seconds 
		TestNetSetup <...> 
		PauseMusicAndStreams 
	ELSE 
		<success_script> <...> 
	ENDIF 
ENDSCRIPT

SCRIPT launch_network_host_options_sub_menu 
	PrintStruct <...> 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	<sub_menu_script> <...> 
ENDSCRIPT

SCRIPT back_from_account_list_menu 
	CancelLogon 
	SetNetworkMode 
	create_pause_menu 
ENDSCRIPT

SCRIPT back_from_create_account_dialog 
	dialog_box_exit 
	back_from_account_list_menu 
ENDSCRIPT

SCRIPT back_from_wrong_pin_dialog 
	dialog_box_exit 
	ConnectToInternet 
ENDSCRIPT

SCRIPT launch_no_accounts_dialog 
	create_dialog_box { title = "NO ACCOUNTS FOUND" 
		text = "No accounts were found on your system. Would you like to create an account now?" 
		buttons = [ { text = "Yes" pad_choose_script = go_to_xbox_dashboard } 
			{ text = "No" pad_choose_script = back_from_create_account_dialog } 
		] 
	} 
ENDSCRIPT

SCRIPT launch_auto_server_notification 
	destroy_onscreen_keyboard 
	create_error_box { title = "Auto-Server" 
		text = "This server is in auto-server mode.  When at least two players are present, games will launch one-after-another." 
		buttons = [ { text = "ok" pad_choose_script = dialog_box_exit } 
		] 
		no_animate 
		delay_input 
	} 
ENDSCRIPT

SCRIPT launch_auto_server_explanation 
	destroy_onscreen_keyboard 
	create_error_box { title = "Auto-Serve" 
		text = "You are in auto-server mode.  When at least two players have joined, a new game will start and new games will follow thereafter." 
		buttons = [ { text = "ok" pad_choose_script = dialog_box_exit } 
		] 
		no_animate 
		delay_input 
	} 
ENDSCRIPT

SCRIPT launch_fcfs_notification 
	IF ( <checksum> = boolean_true ) 
		set_preferences_from_ui prefs = network field = "player_collision" string = "On" <...> 
	ELSE 
		set_preferences_from_ui prefs = network field = "player_collision" string = "Off" <...> 
	ENDIF 
	destroy_onscreen_keyboard 
	force_close_rankings 
	exit_pause_menu 
	create_error_box { title = "Host Notification" 
		text = "This server is in First Come First Serve mode.  You are the designated host.  You may change options and start games." 
		buttons = [ { text = "ok" pad_choose_script = exit_async_dialog } 
		] 
		no_animate 
		delay_input 
	} 
ENDSCRIPT

SCRIPT fcfs_confirm 
	DestroyScreenElement id = current_menu_anchor 
	create_dialog_box { title = "First Come First Serve" 
		text = "This option will make you a permanent observer and will allow the first joining player to choose game modes and change levels.  Are you sure?" 
		text_dims = PAIR(350, 0) 
		buttons = [ { text = "Yes" pad_choose_script = fcfs_selected } 
			{ text = "No" pad_choose_script = create_sit_out_menu } 
		] 
		no_animate 
	} 
ENDSCRIPT

SCRIPT auto_serve_confirm 
	DestroyScreenElement id = current_menu_anchor 
	create_dialog_box { title = "Auto Serve" 
		text = "This option will make you a permanent observer. When at least two players have joined, a new game of the current game mode will start and new games will follow thereafter. Are you sure?" 
		buttons = [ { text = "Yes" pad_choose_script = auto_serve_selected } 
			{ text = "No" pad_choose_script = create_sit_out_menu } 
		] 
		no_animate 
	} 
ENDSCRIPT

SCRIPT create_kick_ban_menu 
	DestroyScreenElement id = current_menu_anchor 
	create_dialog_box { title = <Name> 
		text = "Remove Player?" 
		buttons = [ { text = "cancel" pad_choose_script = cancel_remove_player } 
			{ text = "kick" pad_choose_script = kick_player_confirm pad_choose_params = <...> } 
			{ text = "ban" pad_choose_script = ban_player_confirm pad_choose_params = <...> } 
		] 
		no_animate 
	} 
ENDSCRIPT

SCRIPT create_player_options_dialog 
	IF GotParam allow_remove_homie 
		DestroyScreenElement id = current_menu_anchor 
		IF OnServer 
			create_dialog_box { title = "Player Options" 
				text = <Name> 
				pad_back_script = cancel_remove_player 
				buttons = [ { text = "cancel" pad_choose_script = cancel_remove_player } 
					{ text = "kick" pad_choose_script = kick_player_confirm pad_choose_params = <...> } 
					{ text = "ban" pad_choose_script = ban_player_confirm pad_choose_params = <...> } 
					{ text = "remove homie" pad_choose_script = remove_buddy pad_choose_params = <...> } 
				] 
				no_animate 
			} 
		ELSE 
			create_dialog_box { title = "Player Options" 
				text = <Name> 
				pad_back_script = cancel_remove_player 
				buttons = [ { text = "cancel" pad_choose_script = cancel_remove_player } 
					{ text = "remove homie" pad_choose_script = remove_buddy pad_choose_params = <...> } 
				] 
				no_animate 
			} 
		ENDIF 
	ELSE 
		IF GotParam allow_add_homie 
			DestroyScreenElement id = current_menu_anchor 
			IF OnServer 
				create_dialog_box { title = "Player Options" 
					text = <Name> 
					pad_back_script = cancel_remove_player 
					buttons = [ { text = "cancel" pad_choose_script = cancel_remove_player } 
						{ text = "kick" pad_choose_script = kick_player_confirm pad_choose_params = <...> } 
						{ text = "ban" pad_choose_script = ban_player_confirm pad_choose_params = <...> } 
						{ text = "add homie" pad_choose_script = add_buddy pad_choose_params = <...> } 
					] 
					no_animate 
				} 
			ELSE 
				create_dialog_box { title = "Player Options" 
					text = <Name> 
					pad_back_script = cancel_remove_player 
					buttons = [ { text = "cancel" pad_choose_script = cancel_remove_player } 
						{ text = "add homie" pad_choose_script = add_buddy pad_choose_params = <...> } 
					] 
					no_animate 
				} 
			ENDIF 
		ELSE 
			IF OnServer 
				DestroyScreenElement id = current_menu_anchor 
				create_dialog_box { title = "Player Options" 
					text = <Name> 
					pad_back_script = cancel_remove_player 
					buttons = [ { text = "cancel" pad_choose_script = cancel_remove_player } 
						{ text = "kick" pad_choose_script = kick_player_confirm pad_choose_params = <...> } 
						{ text = "ban" pad_choose_script = ban_player_confirm pad_choose_params = <...> } 
					] 
					no_animate 
				} 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT launch_add_buddy 
	DestroyScreenElement id = current_menu_anchor 
	make_new_menu menu_id = add_buddy_menu vmenu_id = homie_vmenu menu_title = "ADD HOMIE" 
	SetScreenElementProps { id = add_buddy_menu event_handlers = [ 
			{ pad_back generic_menu_pad_back params = { callback = create_pause_menu } } 
		] 
	} 
	FillProspectiveBuddyList 
	RunScriptOnScreenElement id = current_menu_anchor menu_onscreen 
ENDSCRIPT

SCRIPT cancel_add_buddy 
	dialog_box_exit 
	printf "cancel_add_buddy" 
	actions_menu_anchor : DoMorph scale = 1 
	game_list_menu_anchor : DoMorph scale = 1 
	DoScreenElementMorph id = player_list_anchor time = 0 scale = 1 
	DoScreenElementMorph id = chat_box_anchor time = 0 scale = 1 
	IF ObjectExists id = console_message_vmenu 
		DoScreenElementMorph id = console_message_vmenu time = 0 scale = 1 
	ENDIF 
	FireEvent Type = focus target = lobby_player_list_menu 
	change current_lobby_focus = 2 
	change check_for_unplugged_controllers = 1 
	AssignAlias id = lobby_player_list_menu alias = current_menu 
	SetScreenElementLock id = current_menu_anchor OFF 
	create_helper_text generic_helper_text 
	SetScreenElementLock id = current_menu_anchor on 
ENDSCRIPT

SCRIPT cant_add_buddy_prompt_1 
	FireEvent Type = unfocus target = lobby_player_list_menu 
	change check_for_unplugged_controllers = 0 
	actions_menu_anchor : DoMorph scale = 0 
	game_list_menu_anchor : DoMorph scale = 0 
	DoScreenElementMorph id = player_list_anchor time = 0 scale = 0 
	DoScreenElementMorph id = chat_box_anchor time = 0 scale = 0 
	IF ObjectExists id = console_message_vmenu 
		DoScreenElementMorph id = console_message_vmenu time = 0 scale = 0 
	ENDIF 
	FormatText TextName = msg_text "This user does not have a Gamespy profile and therefore can not be tracked and added to your homie list." 
	create_dialog_box { title = "PLAYER NOT LOGGED IN" 
		text = <msg_text> 
		no_bg = no_bg 
		text_dims = PAIR(300, 0) 
		buttons = [ { text = "ok" pad_choose_script = cancel_add_buddy } 
		] 
	} 
ENDSCRIPT

SCRIPT cant_add_buddy_prompt_3 
	FireEvent Type = unfocus target = lobby_player_list_menu 
	change check_for_unplugged_controllers = 0 
	actions_menu_anchor : DoMorph scale = 0 
	game_list_menu_anchor : DoMorph scale = 0 
	DoScreenElementMorph id = player_list_anchor time = 0 scale = 0 
	DoScreenElementMorph id = chat_box_anchor time = 0 scale = 0 
	IF ObjectExists id = console_message_vmenu 
		DoScreenElementMorph id = console_message_vmenu time = 0 scale = 0 
	ENDIF 
	FormatText TextName = msg_text "Your homie list is full. You must remove some homies before adding new ones." 
	create_dialog_box { title = "HOMIE LIST FULL" 
		text = <msg_text> 
		no_bg = no_bg 
		buttons = [ { text = "ok" pad_choose_script = cancel_add_buddy } 
		] 
	} 
ENDSCRIPT

SCRIPT cant_add_buddy_prompt_2 
	FireEvent Type = unfocus target = lobby_player_list_menu 
	change check_for_unplugged_controllers = 0 
	actions_menu_anchor : DoMorph scale = 0 
	game_list_menu_anchor : DoMorph scale = 0 
	DoScreenElementMorph id = player_list_anchor time = 0 scale = 0 
	DoScreenElementMorph id = chat_box_anchor time = 0 scale = 0 
	IF ObjectExists id = console_message_vmenu 
		DoScreenElementMorph id = console_message_vmenu time = 0 scale = 0 
	ENDIF 
	FormatText TextName = msg_text "You must create a Gamespy profile before you can track users by adding them to your homie list." 
	create_dialog_box { title = "NO GAMESPY PROFILE" 
		text = <msg_text> 
		no_bg = no_bg 
		buttons = [ { text = "ok" pad_choose_script = cancel_add_buddy } 
		] 
	} 
ENDSCRIPT

SCRIPT cant_add_self_to_buddy_prompt 
	FireEvent Type = unfocus target = lobby_player_list_menu 
	change check_for_unplugged_controllers = 0 
	actions_menu_anchor : DoMorph scale = 0 
	game_list_menu_anchor : DoMorph scale = 0 
	DoScreenElementMorph id = player_list_anchor time = 0 scale = 0 
	DoScreenElementMorph id = chat_box_anchor time = 0 scale = 0 
	IF ObjectExists id = console_message_vmenu 
		DoScreenElementMorph id = console_message_vmenu time = 0 scale = 0 
	ENDIF 
	FormatText TextName = msg_text "You may not add yourself to your own homie list." 
	create_dialog_box { title = "MY OWN HOMIE" 
		text = <msg_text> 
		no_bg = no_bg 
		buttons = [ { text = "ok" pad_choose_script = cancel_add_buddy } 
		] 
	} 
ENDSCRIPT

SCRIPT already_buddy_prompt 
	FireEvent Type = unfocus target = lobby_player_list_menu 
	change check_for_unplugged_controllers = 0 
	actions_menu_anchor : DoMorph scale = 0 
	game_list_menu_anchor : DoMorph scale = 0 
	DoScreenElementMorph id = player_list_anchor time = 0 scale = 0 
	DoScreenElementMorph id = chat_box_anchor time = 0 scale = 0 
	IF ObjectExists id = console_message_vmenu 
		DoScreenElementMorph id = console_message_vmenu time = 0 scale = 0 
	ENDIF 
	FormatText TextName = msg_text "This user is already on your homie list." 
	create_dialog_box { title = "ALREADY YOUR HOMIE" 
		text = <msg_text> 
		no_bg = no_bg 
		buttons = [ { text = "ok" pad_choose_script = cancel_add_buddy } 
		] 
	} 
ENDSCRIPT

SCRIPT add_buddy_prompt 
	FireEvent Type = unfocus target = lobby_player_list_menu 
	change check_for_unplugged_controllers = 0 
	actions_menu_anchor : DoMorph scale = 0 
	game_list_menu_anchor : DoMorph scale = 0 
	DoScreenElementMorph id = player_list_anchor time = 0 scale = 0 
	DoScreenElementMorph id = chat_box_anchor time = 0 scale = 0 
	IF ObjectExists id = console_message_vmenu 
		DoScreenElementMorph id = console_message_vmenu time = 0 scale = 0 
	ENDIF 
	FormatText TextName = msg_text "Add %s to your homie list?" s = <net_name> 
	create_dialog_box { title = "ADD HOMIE" 
		text = <msg_text> 
		no_bg = no_bg 
		buttons = [ { text = "Yes" pad_choose_script = lobby_add_buddy pad_choose_params = <...> } 
			{ text = "No" pad_choose_script = cancel_add_buddy } 
		] 
	} 
ENDSCRIPT

SCRIPT add_buddy 
	IF BuddyListFull 
		dialog_box_exit 
		create_buddy_list_full_dialog 
	ELSE 
		AddBuddy <...> 
		dialog_box_exit 
		create_adding_buddy_dialog 
	ENDIF 
ENDSCRIPT

SCRIPT remove_buddy 
	RemoveBuddy <...> 
	dialog_box_exit 
	create_removed_buddy_dialog 
ENDSCRIPT

SCRIPT lobby_add_buddy 
	dialog_box_exit 
	AddBuddy profile = <profile> nick = <net_name> 
	IF InNetGame 
		create_dialog_box { title = net_status_msg 
			text = "Added homie" 
			buttons = [ { text = "close" pad_choose_script = cancel_add_buddy } 
			] 
		} 
	ELSE 
		FormatText TextName = msg_text "Adding %s to homie list..." s = <net_name> 
		SendMessage text = <msg_text> system_message 
		cancel_add_buddy 
		IF ScreenElementExists id = actions_menu 
			FillPlayerList 
			IF ( current_lobby_focus = 2 ) 
				refocus_actions_menu 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT create_adding_buddy_dialog 
	IF InNetGame 
		dialog_box_exit 
		exit_pause_menu 
		create_console_message text = "<system>: Adding homie.." 
	ELSE 
		create_dialog_box { title = net_status_msg 
			text = "Adding homie..." 
			buttons = [ { text = "close" pad_choose_script = close_add_buddy } 
			] 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT create_buddy_list_full_dialog 
	IF InNetGame 
		dialog_box_exit 
		exit_pause_menu 
		create_console_message text = "<system>: Your homie list is full." 
	ELSE 
		create_dialog_box { title = net_error_msg 
			text = "Your homie list is full. You must remove some homies before adding new ones." 
			buttons = [ { text = "close" pad_choose_script = close_add_buddy } 
			] 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT failed_add_buddy_already_buddy 
	IF InNetGame 
		create_failed_add_buddy_dialog 
	ELSE 
		SendMessage text = "User already on homie list." system_message 
	ENDIF 
ENDSCRIPT

SCRIPT added_buddy 
	IF levelIs Load_skateshop 
		FormatText TextName = msg_text "Added %s to homie list." s = <net_name> 
		SendMessage text = <msg_text> system_message 
	ELSE 
		create_added_buddy_dialog 
	ENDIF 
ENDSCRIPT

SCRIPT removed_buddy 
	IF ObjectExists id = <id> 
		DestroyScreenElement id = <id> 
	ENDIF 
ENDSCRIPT

SCRIPT create_added_buddy_dialog 
	IF InNetGame 
		dialog_box_exit 
		exit_pause_menu 
		create_console_message text = "<system>: Added homie." 
	ELSE 
		IF NOT ObjectExists id = dialog_box_anchor 
			create_dialog_box { title = net_status_msg 
				text = "Added homie." 
				buttons = [ { text = "ok" pad_choose_script = accept_buddy_ok } 
				] 
			} 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT create_removed_buddy_dialog 
	IF InNetGame 
		dialog_box_exit 
		exit_pause_menu 
		create_console_message text = "<system>: Removed homie." 
	ELSE 
		dialog_box_exit 
		create_dialog_box { title = net_status_msg 
			text = "Removed homie." 
			buttons = [ { text = "ok" pad_choose_script = accept_buddy_ok } 
			] 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT create_failed_add_buddy_dialog 
	destroy_onscreen_keyboard 
	dialog_box_exit 
	create_error_box { title = net_status_msg 
		text = "User was already your homie." 
		buttons = [ { text = "ok" pad_choose_script = accept_buddy_ok } 
		] 
	} 
ENDSCRIPT

SCRIPT close_add_buddy 
	dialog_box_exit 
	create_pause_menu 
ENDSCRIPT

SCRIPT accept_buddy_ok 
	dialog_box_exit 
	create_pause_menu 
ENDSCRIPT

SCRIPT launch_quit_game_dialog 
	dialog_box_exit 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	create_quit_game_dialog 
ENDSCRIPT

SCRIPT create_quit_game_dialog 
	create_error_box { title = "Quit Game" 
		text = "Are you sure?" 
		anchor_id = quit_dialog_anchor 
		buttons = [ { text = "Yes" pad_choose_script = quit_network_game } 
			{ text = "No" pad_choose_script = quit_game_dialog_box_exit } 
		] 
		no_animate 
	} 
ENDSCRIPT

SCRIPT quit_game_dialog_box_exit 
	generic_menu_pad_back_sound 
	exit_pause_menu 
	dialog_box_exit anchor_id = quit_dialog_anchor 
ENDSCRIPT

SCRIPT launch_wrong_pin_dialog_box 
	DestroyScreenElement id = current_menu_anchor 
	create_dialog_box { title = "WRONG PIN" 
		text = "The PIN you have entered is incorrect." 
		buttons = [ { text = "ok" pad_choose_script = back_from_wrong_pin_dialog } 
		] 
	} 
ENDSCRIPT

SCRIPT select_xbox_multiplayer 
	change network_connection_type = lan 
	change_gamemode_net 
	launch_select_skater_menu 
ENDSCRIPT

SCRIPT launch_network_select_games_menu 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	create_network_select_games_menu play_cam 
ENDSCRIPT

SCRIPT launch_remove_players_menu 
	hide_current_goal 
	DestroyScreenElement id = current_menu_anchor 
	create_remove_players_menu 
ENDSCRIPT

SCRIPT launch_xbox_online_menu 
	DestroyScreenElement id = current_menu_anchor 
	create_xbox_online_menu 
ENDSCRIPT

SCRIPT chose_xbox_online 
	IF AlreadySignedIn 
		create_xbox_online_menu 
	ELSE 
		chose_internet 
	ENDIF 
ENDSCRIPT

SCRIPT connected_to_internet 
	PauseMusicAndStreams 
	IF NOT AlreadyGotMotd 
		DownloadMotd 
	ELSE 
		IF ObjectExists id = current_menu_anchor 
			DestroyScreenElement id = current_menu_anchor 
		ENDIF 
		IF NOT ProfileLogIn 
			create_internet_options 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT failed_internet_connection 
	printf "script failed_internet_connection" 
	create_ss_menu no_animate 
ENDSCRIPT

SCRIPT chose_internet 
	SetNetworkMode INTERNET_MODE 
	IF NOT OnXbox 
		ConnectToInternet 
	ELSE 
		IF ConnectToInternet success = authenticate_client failure = failed_internet_connection 
			printf "connected to internet" 
		ELSE 
			IF ObjectExists id = current_menu_anchor 
				DestroyScreenElement id = current_menu_anchor 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT confirm_observe 
	generic_menu_pad_back_sound 
	exit_pause_menu 
	dialog_box_exit 
	EnterObserverMode 
ENDSCRIPT

SCRIPT chose_observe 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	create_dialog_box { title = "Observer Mode" 
		text = "Are you sure you would like to observe this game? You will not be able to jump back in." 
		buttons = [ { text = "Yes" pad_choose_script = confirm_observe } 
			{ text = "No" pad_choose_script = back_from_dialog } 
		] 
		no_animate 
	} 
ENDSCRIPT

SCRIPT launch_motd_wait_dialog 
	dialog_box_exit 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	create_motd_wait_dialog 
ENDSCRIPT

SCRIPT launch_network_select_lan_games_menu 
	KillSkaterCamAnim all 
	skater : reset_model_lights 
	skater : remove_skater_from_world 
	KillSkaterCamAnim all 
	PlaySkaterCamAnim skater = 0 Name = mainmenu_camera03 play_hold 
	SetNetworkMode LAN_MODE 
	launch_network_select_games_menu 
ENDSCRIPT

SCRIPT launch_network_host_options_menu 
	dialog_box_exit 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	create_network_host_options_menu 
ENDSCRIPT

in_server_options = 0 
SCRIPT back_from_internet_host_options 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
		Wait 1 frame 
	ENDIF 
	change in_server_options = 0 
	IF InNetGame 
		create_pause_menu 
	ELSE 
		launch_network_select_games_menu 
	ENDIF 
ENDSCRIPT

in_net_lobby = 0 
SCRIPT back_from_auth_error 
	printf "script back_from_auth_error" 
	dialog_box_exit 
	create_ss_menu no_animate 
ENDSCRIPT

SCRIPT display_auth_error 
	PauseMusicAndStreams 
	dialog_box_exit 
	FormatText TextName = message "DNAS Error (%s)\\n%e\\n\\n%f" s = <sub_code> e = <desc> f = <footer> 
	create_dialog_box { title = net_error_msg 
		text = <message> 
		text_dims = PAIR(500, 0) 
		buttons = [ { text = "OK" pad_choose_script = back_from_auth_error } 
		] 
	} 
ENDSCRIPT

SCRIPT spawn_dnas_authentication 
	Wait 30 frames 
	AuthenticateClient 
ENDSCRIPT

SCRIPT authenticate_client 
	KillSkaterCamAnim all 
	skater : reset_model_lights 
	skater : remove_skater_from_world 
	KillSkaterCamAnim all 
	PlaySkaterCamAnim skater = 0 Name = mainmenu_camera03 play_hold 
	PauseMusicAndStreams 1 
	IF NOT OnXbox 
		IF CD 
			skater : remove_skater_from_world 
			create_dialog_box { title = net_status_msg 
				text = net_auth_msg 
				logo = dnas 
				no_icon = no_icon 
				no_animate 
			} 
			SpawnScript spawn_dnas_authentication 
		ELSE 
			connected_to_internet 
		ENDIF 
	ELSE 
		connected_to_internet 
	ENDIF 
ENDSCRIPT

current_lobby_focus = 0 
SCRIPT host_chosen 
	console_hide 
	GSDisableNet 
	StopServerList 
	FreeServerList 
	launch_network_host_options_menu 
ENDSCRIPT

SCRIPT host_net_chosen 
	console_hide 
	StopServerList 
	FreeServerList 
	launch_network_host_options_menu 
	GSEnableNet 
ENDSCRIPT

SCRIPT check_ip_from_keyboard_failure_exit 
	dialog_box_exit 
	create_network_select_games_menu 
ENDSCRIPT

SCRIPT check_ip_from_keyboard_failure 
	TryJoinServerIPCancel 
	create_snazzy_dialog_box { 
		title = #"Unable to connect" 
		text = #"Unable to connect to server." 
		pad_back_script = create_network_select_games_menu 
		buttons = [ 
			{ font = small text = #"OK" pad_choose_script = check_ip_from_keyboard_failure_exit } 
		] 
	} 
	ResetTimer 
	BEGIN 
		IF TimeGreaterThan 5 
			BREAK 
		ENDIF 
		Wait 1 gameframe 
	REPEAT 
	IF ScreenElementExists id = dialog_box_anchor 
		dialog_box_exit 
		create_network_select_games_menu play_cam 
	ENDIF 
ENDSCRIPT

SCRIPT check_ip_from_keyboard_cancel 
	dialog_box_exit 
	TryJoinServerIPCancel 
	create_network_select_games_menu play_cam 
ENDSCRIPT

SCRIPT check_ip_from_keyboard 
	GetTextElementString id = keyboard_current_string 
	destroy_onscreen_keyboard 
	IF NOT GotParam cancel 
		TryJoinServerIP string = <string> 
		ResetTimer 
		create_snazzy_dialog_box { title = #"Checking..." 
			text = #"Checking for server..." 
			pad_back_script = check_ip_from_keyboard_cancel 
			buttons = [ 
				{ font = small text = #"Cancel" pad_choose_script = check_ip_from_keyboard_cancel } 
			] 
		} 
		BEGIN 
			IF TimeGreaterThan 5 
				BREAK 
			ENDIF 
			IF TryJoinServerIPSuccess 
				BREAK 
			ENDIF 
			Wait 1 gameframe 
		REPEAT 
	ENDIF 
	IF GotParam cancel 
		create_network_select_games_menu 
	ELSE 
		IF NOT TryJoinServerIPSuccess 
			IF ScreenElementExists id = dialog_box_anchor 
				dialog_box_exit 
				check_ip_from_keyboard_failure 
			ENDIF 
		ELSE 
			dialog_box_exit 
			create_network_select_games_menu play_cam 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT check_join_internet_ip 
	console_hide 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	TryJoinInternetGame 
	create_snazzy_dialog_box { title = #"Checking..." 
		text = #"Checking for server..." 
		pad_back_script = check_ip_from_keyboard_cancel 
		buttons = [ 
			{ font = small text = #"Cancel" pad_choose_script = check_ip_from_keyboard_cancel } 
		] 
	} 
	BEGIN 
		IF NOT TryingToJoinGame 
			BREAK 
		ENDIF 
		TryJoinInternetGame 
		ResetTimer 
		BEGIN 
			IF TimeGreaterThan 3 
				BREAK 
			ENDIF 
			IF TryJoinServerIPSuccess 
				BREAK 
			ENDIF 
			Wait 1 gameframe 
		REPEAT 
		IF TryJoinServerIPSuccess 
			BREAK 
		ENDIF 
	REPEAT 10 
	IF NOT TryJoinServerIPSuccess 
		TryJoinServerIPCancel 
		IF ScreenElementExists id = dialog_box_anchor 
			dialog_box_exit 
			check_ip_from_keyboard_failure 
		ENDIF 
	ELSE 
		dialog_box_exit 
		create_network_select_games_menu play_cam 
	ENDIF 
ENDSCRIPT

SCRIPT fcfs_selected 
	dialog_box_exit 
	SetHostMode HOST_MODE_FCFS 
	exit_pause_menu 
ENDSCRIPT

SCRIPT auto_serve_selected 
	dialog_box_exit 
	GetPreferenceChecksum pref_type = network game_type 
	SWITCH <checksum> 
		CASE netgoalattack 
			IF NOT GoalManager_GoalsAreSelected 
				exit_pause_menu 
				create_dialog_box { title = "No Goals Selected" 
					text = "You must select goals before starting the Goal Attack auto-server." 
					buttons = [ { text = "ok" pad_choose_script = back_from_dialog } 
					] 
				} 
				RETURN 
			ENDIF 
	ENDSWITCH 
	SetHostMode HOST_MODE_AUTO_SERVE 
	exit_pause_menu 
ENDSCRIPT

SCRIPT create_sit_out_menu 
	dialog_box_exit 
	FormatText ChecksumName = title_icon "%i_end" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	make_new_themed_sub_menu title = "SIT OUT" title_icon = <title_icon> 
	SetScreenElementProps { id = sub_menu event_handlers = [ 
			{ pad_back generic_menu_pad_back params = { callback = create_pause_menu } } 
		] 
	} 
	create_helper_text generic_helper_text 
	theme_menu_add_item text = "First Come, First Serve" id = menu_network_fcfs_select pad_choose_script = fcfs_confirm highlight_bar_scale = PAIR(1.15, 1.3) highlight_bar_pos = PAIR(97, -7) centered = 1 
	theme_menu_add_item text = "Auto-Serve" id = menu_network_auto_serve_select pad_choose_script = auto_serve_confirm highlight_bar_scale = PAIR(1.15, 1.3) highlight_bar_pos = PAIR(97, -7) centered = 1 last_menu_item = 1 
	finish_themed_sub_menu 
ENDSCRIPT

SCRIPT launch_network_sit_out_menu 
	hide_current_goal 
	DestroyScreenElement id = current_menu_anchor 
	create_sit_out_menu 
ENDSCRIPT

SCRIPT do_nothing 
ENDSCRIPT

SCRIPT create_motd_menu 
	dialog_box_exit 
	IF IsPal 
		create_dialog_box { title = "MESSAGE" 
			text = <message> 
			text_dims = PAIR(600, 0) 
			buttons = [ { text = "ok" pad_choose_script = profile_connect } 
			] 
		} 
	ELSE 
		create_dialog_box { title = "MESSAGE" 
			text = <message> 
			sub_logo = esrb 
			text_dims = PAIR(600, 0) 
			buttons = [ { text = "ok" pad_choose_script = profile_connect } 
			] 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT create_motd_wait_dialog 
	dialog_box_exit 
	create_dialog_box { title = net_status_msg 
		text = net_status_checking_motd 
		no_animate 
	} 
ENDSCRIPT

SCRIPT CreateMotdRetryDialog 
	dialog_box_exit 
	create_dialog_box { title = net_status_msg 
		text = <message> 
		no_animate 
	} 
ENDSCRIPT

SCRIPT CreateMotdFailedDialog 
	dialog_box_exit 
	create_dialog_box { title = net_status_msg 
		text = net_status_motd_failed 
		buttons = [ { text = "ok" pad_choose_script = back_from_startup_error_dialog } 
		] 
	} 
ENDSCRIPT

SCRIPT StatsLoginFailedDialog 
	dialog_box_exit 
	create_dialog_box { title = net_error_msg 
		text = net_status_stats_login_failed 
		buttons = [ { text = "ok" pad_choose_script = back_from_profile_error } 
		] 
	} 
ENDSCRIPT

SCRIPT StatsRetrievalFailedDialog 
	dialog_box_exit 
	create_dialog_box { title = net_error_msg 
		text = net_status_stats_retrieval_failed 
		buttons = [ { text = "ok" pad_choose_script = back_from_profile_error } 
		] 
	} 
ENDSCRIPT

SCRIPT back_from_failed_buddy_login 
	dialog_box_exit 
	create_internet_options 
ENDSCRIPT

SCRIPT CreateBuddyLoginFailedDialog 
	dialog_box_exit 
	create_dialog_box { title = net_error_msg 
		text = net_status_buddy_login_failed 
		buttons = [ { text = "ok" pad_choose_script = back_from_failed_buddy_login } 
		] 
	} 
ENDSCRIPT

SCRIPT back_from_removed_dialog 
	dialog_box_exit 
	IF EnteringNetGame 
		cancel_join_server 
	ELSE 
		quit_network_game 
	ENDIF 
ENDSCRIPT

SCRIPT CreateServerRemovedYouDialog 
	HideLoadingScreen 
	GoalManager_DeactivateAllGoals force_all 
	GoalManager_UninitializeAllGoals 
	GoalManager_SetCanStartGoal 0 
	kill_net_panel_messages 
	force_close_rankings dont_retry 
	destroy_onscreen_keyboard 
	dialog_box_exit 
	exit_pause_menu 
	IF NOT IsObserving 
		skater : Vibrate OFF 
	ENDIF 
	change check_for_unplugged_controllers = 0 
	create_error_box { title = net_notice_msg 
		text = net_message_server_removed_you 
		buttons = [ { text = "ok" pad_choose_script = back_from_removed_dialog } 
		] 
		delay_input 
	} 
ENDSCRIPT

SCRIPT CreateServerMovedOnDialog 
	HideLoadingScreen 
	force_close_rankings dont_retry 
	destroy_onscreen_keyboard 
	dialog_box_exit 
	exit_pause_menu 
	IF NOT IsObserving 
		skater : Vibrate OFF 
	ENDIF 
	change check_for_unplugged_controllers = 0 
	create_error_box { title = net_notice_msg 
		text = net_message_server_moved_on 
		buttons = [ { text = "ok" pad_choose_script = back_from_removed_dialog } 
		] 
		delay_input 
	} 
ENDSCRIPT

SCRIPT destroy_server_menu_children 
	IF ObjectExists id = server_list_menu 
		SetScreenElementLock id = server_list_menu OFF 
		DestroyScreenElement id = server_list_menu recurse preserve_parent 
		IF GotParam refocus 
			refocus_actions_menu 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT destroy_server_desc_children 
	SetScreenElementLock id = server_desc_menu OFF 
	DestroyScreenElement id = server_desc_menu recurse preserve_parent 
	DestroyScreenElement id = server_player_menu recurse preserve_parent 
	refocus_gamelist_menu 
ENDSCRIPT

SCRIPT destroy_lobby_user_list_children 
	IF ObjectExists id = lobby_player_list_menu 
		prepare_lobby_user_list_for_new_children 
		DestroyScreenElement id = lobby_player_list_menu recurse preserve_parent 
	ENDIF 
ENDSCRIPT

SCRIPT destroy_lobby_user 
	IF ObjectExists id = <user_id> 
		DestroyScreenElement id = <user_id> 
	ENDIF 
ENDSCRIPT

SCRIPT destroy_lobby_server 
	IF ObjectExists id = <server_id> 
		DestroyScreenElement id = <server_id> 
	ENDIF 
ENDSCRIPT

SCRIPT destroy_lobby_buddy_list_children 
	IF ObjectExists id = homie_vmenu 
		prepare_lobby_buddy_list_for_new_children 
		DestroyScreenElement id = homie_vmenu recurse preserve_parent 
	ENDIF 
ENDSCRIPT

SCRIPT add_no_servers_found_message 
	IF ObjectExists id = server_list_menu 
		SetScreenElementLock id = server_list_menu OFF 
		IF OnXbox 
			main_menu_add_item text = "No Games Found" parent = server_list_menu id = menu_network_no_servers 
		ELSE 
			main_menu_add_item text = "No Servers Found" parent = server_list_menu id = menu_network_no_servers 
		ENDIF 
		IF GotParam refocus 
			refocus_actions_menu 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT prepare_server_menu_for_new_children 
	IF ObjectExists id = server_list_menu 
		SetScreenElementLock id = server_list_menu OFF 
	ENDIF 
ENDSCRIPT

SCRIPT prepare_lobby_user_list_for_new_children 
	IF ObjectExists id = lobby_player_list_menu 
		SetScreenElementLock id = lobby_player_list_menu OFF 
	ENDIF 
ENDSCRIPT

SCRIPT prepare_lobby_buddy_list_for_new_children 
	IF ObjectExists id = homie_vmenu 
		SetScreenElementLock id = homie_vmenu OFF 
	ENDIF 
ENDSCRIPT

SCRIPT rejoin_lobby 
	RejoinLobby 
	create_joining_lobby_dialog 
ENDSCRIPT

SCRIPT choose_selected_lobby 
	printf "---------------------- chose lobby ----------------------" 
	ChooseLobby <...> 
	DestroyScreenElement id = lobby_list_anchor 
	DestroyScreenElement id = menu_parts_anchor 
	create_joining_lobby_dialog 
ENDSCRIPT

SCRIPT choose_selected_server 
	console_hide 
	ChooseServer <...> 
	DestroyScreenElement id = current_menu_anchor 
ENDSCRIPT

SCRIPT describe_selected_server 
	DescribeServer <...> 
ENDSCRIPT

SCRIPT choose_selected_player 
	IF NOT OnXbox 
		RemovePlayer <...> 
	ELSE 
		CreatePlayerOptions <...> 
	ENDIF 
ENDSCRIPT

SCRIPT choose_selected_account 
	ChooseAccount <...> 
ENDSCRIPT

SCRIPT cancel_remove_player 
	CancelRemovePlayer 
	dialog_box_exit 
	create_pause_menu 
ENDSCRIPT

SCRIPT kick_player_confirm 
	create_dialog_box { title = <Name> 
		text = "Kick player?" 
		buttons = [ { text = "yes" pad_choose_script = kick_player } 
			{ text = "no" pad_choose_script = cancel_remove_player } 
		] 
	} 
ENDSCRIPT

SCRIPT kick_player 
	KickPlayer 
	dialog_box_exit 
	create_pause_menu 
ENDSCRIPT

SCRIPT back_from_dialog 
	dialog_box_exit 
	create_pause_menu 
ENDSCRIPT

SCRIPT ban_player_confirm 
	create_dialog_box { title = <Name> 
		text = "Ban player?" 
		buttons = [ { text = "yes" pad_choose_script = ban_player } 
			{ text = "no" pad_choose_script = cancel_remove_player } 
		] 
	} 
ENDSCRIPT

SCRIPT ban_player 
	BanPlayer 
	dialog_box_exit 
	create_pause_menu 
ENDSCRIPT

SCRIPT launch_pin_entry_menu 
	DestroyScreenElement id = current_menu_anchor 
	create_pin_entry_menu 
ENDSCRIPT

SCRIPT launch_buddy_list 
	DestroyScreenElement id = current_menu_anchor 
	create_buddy_list_menu 
ENDSCRIPT

SCRIPT launch_homie_list parent = root_window 
	pulse_blur 
	dialog_box_exit 
	IF ObjectExists id = console_message_vmenu 
		DoScreenElementMorph id = console_message_vmenu time = 0 scale = 0 
	ENDIF 
	IF InNetGame 
		GoalManager_HidePoints 
	ENDIF 
	IF ( <parent> = root_window ) 
		IF ObjectExists id = current_menu_anchor 
			DestroyScreenElement id = current_menu_anchor 
		ENDIF 
	ENDIF 
	SetScreenElementLock id = <parent> OFF 
	FormatText ChecksumName = on_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = off_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	CreateScreenElement { 
		Type = ContainerElement 
		parent = <parent> 
		id = homie_bg_anchor 
		dims = PAIR(640, 480) 
		pos = PAIR(320, 240) 
	} 
	AssignAlias id = homie_bg_anchor alias = current_menu_anchor 
	create_helper_text generic_helper_text 
	FormatText ChecksumName = title_icon "%i_homie" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	build_theme_sub_title title = "HOMIE LIST" title_icon = <title_icon> 
	IF levelIs Load_skateshop 
		build_top_and_bottom_blocks bot_z = 15 
		make_mainmenu_3d_plane 
	ELSE 
		FormatText ChecksumName = paused_icon "%i_paused_icon" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
		build_theme_box_icons icon_texture = <paused_icon> 
		build_top_bar pos = PAIR(-400, 62) 
		build_grunge_piece 
	ENDIF 
	CreateScreenElement { 
		Type = ContainerElement 
		parent = homie_bg_anchor 
		id = homie_menu_anchor 
		dims = PAIR(640, 480) 
		pos = PAIR(320, 840) 
	} 
	AssignAlias id = homie_menu_anchor alias = current_menu_anchor 
	theme_background width = 7 pos = PAIR(320, 63) num_parts = 10 static = static dark_menu = dark_menu 
	CreateScreenElement { 
		Type = SpriteElement 
		parent = current_menu_anchor 
		texture = white2 
		scale = PAIR(71.3, 4) 
		pos = PAIR(35, 63) 
		just = [ left top ] 
		rgba = [ 0 0 0 128 ] 
		alpha = 0.80000001192 
		z_priority = 2 
	} 
	IF levelIs Load_skateshop 
		CreateScreenElement { 
			Type = SpriteElement 
			parent = homie_bg_anchor 
			texture = homie 
			scale = PAIR(1.79999995232, 1.29999995232) 
			pos = PAIR(380.00000000000, 67.00000000000) 
			just = [ left bottom ] 
			alpha = 0.50000000000 
			z_priority = 5 
		} 
		CreateScreenElement { 
			Type = SpriteElement 
			parent = homie_bg_anchor 
			id = globe 
			texture = globe 
			scale = 1.29999995232 
			pos = PAIR(320.00000000000, 560.00000000000) 
			just = [ center center ] 
			alpha = 0.30000001192 
			z_priority = -1 
		} 
	ENDIF 
	CreateScreenElement { 
		Type = textElement 
		parent = current_menu_anchor 
		text = "Name" 
		scale = 1 
		font = dialog 
		rgba = <on_rgba> 
		pos = PAIR(90.00000000000, 83.00000000000) 
		just = [ left center ] 
	} 
	CreateScreenElement { 
		Type = SpriteElement 
		parent = current_menu_anchor 
		id = up_arrow 
		texture = up_arrow 
		scale = 1 
		pos = PAIR(260.00000000000, 83.00000000000) 
		just = [ center center ] 
		alpha = 0.50000000000 
		z_priority = 3 
	} 
	CreateScreenElement { 
		Type = SpriteElement 
		parent = current_menu_anchor 
		id = down_arrow 
		texture = down_arrow 
		scale = 1 
		pos = PAIR(260.00000000000, 345.00000000000) 
		just = [ center center ] 
		alpha = 0.50000000000 
		z_priority = 3 
	} 
	CreateScreenElement { 
		Type = SpriteElement 
		parent = current_menu_anchor 
		texture = white2 
		scale = PAIR(0.80000001192, 32.29999923706) 
		pos = PAIR(275.00000000000, 95.00000000000) 
		just = [ left top ] 
		rgba = [ 0 0 0 128 ] 
		alpha = 0.80000001192 
		z_priority = 2 
	} 
	CreateScreenElement { 
		Type = textElement 
		parent = current_menu_anchor 
		text = "Status" 
		scale = 1 
		font = dialog 
		rgba = <on_rgba> 
		pos = PAIR(285.00000000000, 83.00000000000) 
		just = [ left center ] 
	} 
	CreateScreenElement { 
		Type = SpriteElement 
		parent = current_menu_anchor 
		texture = white2 
		scale = PAIR(0.80000001192, 32.29999923706) 
		pos = PAIR(380.00000000000, 95.00000000000) 
		just = [ left top ] 
		rgba = [ 0 0 0 128 ] 
		alpha = 0.80000001192 
		z_priority = 2 
	} 
	CreateScreenElement { 
		Type = textElement 
		parent = current_menu_anchor 
		text = "Location" 
		scale = 1 
		font = dialog 
		rgba = <on_rgba> 
		pos = PAIR(390.00000000000, 83.00000000000) 
		just = [ left center ] 
	} 
	IF InNetGame 
		pad_back_script = back_to_pause_menu_from_buddy_list 
	ELSE 
		pad_back_script = back_to_server_list_from_buddy_list 
	ENDIF 
	CreateScreenElement { 
		Type = vscrollingmenu 
		parent = current_menu_anchor 
		id = homie_scrolling_menu 
		just = [ left top ] 
		dims = PAIR(600.00000000000, 240.00000000000) 
		pos = PAIR(100.00000000000, 103.00000000000) 
	} 
	CreateScreenElement { 
		Type = vmenu 
		parent = homie_scrolling_menu 
		id = homie_vmenu 
		pos = PAIR(0.00000000000, 0.00000000000) 
		just = [ left top ] 
		event_handlers = [ { pad_up generic_menu_up_or_down_sound params = { up } } 
			{ pad_down generic_menu_up_or_down_sound params = { down } } 
			{ pad_back generic_menu_pad_back params = { callback = <pad_back_script> } } 
		] 
		dont_allow_wrap 
	} 
	IF HasBuddies 
		IF InGroupRoom 
			FillBuddyList allow_remove allow_join 
		ELSE 
			FillBuddyList allow_remove 
		ENDIF 
		Wait 2 gameframes 
		SetScreenElementProps id = homie_scrolling_menu 
	ENDIF 
	AssignAlias id = homie_bg_anchor alias = current_menu_anchor 
	IF ScreenElementExists id = globe 
		RunScriptOnScreenElement id = globe rotate_internet_options_globe 
	ENDIF 
	IF NOT GotParam dont_animate_in 
		RunScriptOnScreenElement id = homie_menu_anchor online_stats_animate_in params = { id = homie_menu_anchor } 
		FireEvent Type = focus target = homie_vmenu 
	ENDIF 
ENDSCRIPT

SCRIPT homie_list_add_item Name = "" status = "" location = "" 
	printf "homie_list_add_item" 
	FormatText ChecksumName = off_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = bar_rgba "%i_HIGHLIGHT_BAR_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	IF ScreenElementExists id = homie_vmenu 
		printf "homie_list_add_itemhomie_list_add_item" 
		SetScreenElementLock id = homie_vmenu OFF 
		CreateScreenElement { 
			Type = ContainerElement 
			parent = homie_vmenu 
			id = <id> 
			dims = PAIR(500.00000000000, 15.00000000000) 
			pos = PAIR(0.00000000000, 0.00000000000) 
			event_handlers = [ 
				{ focus online_stats_generic_focus } 
				{ unfocus online_stats_generic_unfocus } 
				{ pad_choose present_buddy_options params = { <pad_choose_params> } } 
				{ pad_start present_buddy_options params = { <pad_choose_params> } } 
				{ pad_choose generic_menu_pad_choose_sound } 
			] 
		} 
		anchor_id = <id> 
		CreateScreenElement { 
			Type = SpriteElement 
			parent = <anchor_id> 
			texture = DE_highlight_bar 
			scale = PAIR(4.44999980927, 0.44999998808) 
			pos = PAIR(-65.00000000000, 0.00000000000) 
			just = [ left center ] 
			rgba = <bar_rgba> 
			alpha = 0 
			z_priority = 2 
		} 
		FormatText ChecksumName = rank_icon "rank_%i" i = <rank> 
		CreateScreenElement { 
			Type = SpriteElement 
			parent = <anchor_id> 
			texture = <rank_icon> 
			scale = 0.69999998808 
			pos = PAIR(-60.00000000000, 0.00000000000) 
			just = [ left center ] 
		} 
		CreateScreenElement { 
			Type = textElement 
			parent = <anchor_id> 
			text = <Name> 
			font = dialog 
			scale = 0.80000001192 
			pos = PAIR(-10.00000000000, 0.00000000000) 
			just = [ left center ] 
			rgba = <off_rgba> 
		} 
		CreateScreenElement { 
			Type = textElement 
			parent = <anchor_id> 
			text = <status> 
			font = dialog 
			scale = 0.80000001192 
			pos = PAIR(185.00000000000, 0.00000000000) 
			just = [ left center ] 
			rgba = <off_rgba> 
		} 
		CreateScreenElement { 
			Type = textElement 
			parent = <anchor_id> 
			text = <location> 
			font = dialog 
			scale = 0.80000001192 
			pos = PAIR(290.00000000000, 0.00000000000) 
			just = [ left center ] 
			rgba = <off_rgba> 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT back_to_pause_menu_from_buddy_list 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	GoalManager_ShowPoints 
	create_pause_menu 
ENDSCRIPT

SCRIPT show_nat_start_dialog 
	PauseMusicAndStreams 
	create_dialog_box { title = net_status_msg 
		text = net_status_locating 
		buttons = [ 
			{ text = "cancel" pad_choose_script = cancel_join_server pad_choose_params = { cancel_nn } } 
		] 
	} 
ENDSCRIPT

SCRIPT show_nat_timeout 
	dialog_box_exit 
	create_dialog_box { title = net_error_msg 
		text = net_status_nat_neg_failed 
		buttons = [ { text = "ok" pad_choose_script = cancel_join_server pad_choose_params = { cancel_nn } } 
		] 
	} 
ENDSCRIPT

SCRIPT present_buddy_options back_script = launch_homie_list remove_script = lobby_remove_buddy 
	IF GotParam in_lobby 
		IF ObjectExists id = current_menu_anchor 
			DestroyScreenElement id = current_menu_anchor 
		ENDIF 
		pad_back_params = { from_lobby } 
	ELSE 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	back_script = launch_homie_list 
	nick = <Name> 
	IF GotParam allow_join 
		IF GotParam allow_remove 
			FormatText TextName = msg_text "%s : %t" s = <status> t = <location> 
			create_dialog_box { title = <nick> 
				text = <msg_text> 
				buttons = [ { text = "back" pad_choose_script = <back_script> pad_choose_params = <pad_back_params> } 
					{ text = "join" pad_choose_script = join_buddy pad_choose_params = <...> } 
					{ text = "observe" pad_choose_script = observe_buddy pad_choose_params = <...> } 
					{ text = "remove" pad_choose_script = <remove_script> pad_choose_params = <...> } 
				] 
			} 
		ELSE 
			FormatText TextName = msg_text "%s : %t" s = <status> t = <location> 
			create_dialog_box { title = <nick> 
				text = <msg_text> 
				buttons = [ { text = "back" pad_choose_script = <back_script> pad_choose_params = <pad_back_params> } 
					{ text = "join" pad_choose_script = join_buddy pad_choose_params = <...> } 
					{ text = "observe" pad_choose_script = observe_buddy pad_choose_params = <...> } 
				] 
			} 
		ENDIF 
	ELSE 
		IF GotParam allow_remove 
			FormatText TextName = msg_text "%s : %t" s = <status> t = <location> 
			create_dialog_box { title = <nick> 
				text = <msg_text> 
				buttons = [ { text = "back" pad_choose_script = <back_script> pad_choose_params = <pad_back_params> } 
					{ text = "remove" pad_choose_script = <remove_script> pad_choose_params = <...> } 
				] 
			} 
		ELSE 
			FormatText TextName = msg_text "%s : %t" s = <status> t = <location> 
			create_dialog_box { title = <nick> 
				text = <msg_text> 
				buttons = [ { text = "back" pad_choose_script = <back_script> pad_choose_params = <pad_back_params> } 
				] 
			} 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT join_buddy 
	JoinBuddy <...> 
ENDSCRIPT

SCRIPT observe_buddy 
	JoinBuddy <...> observe 
ENDSCRIPT

SCRIPT shell_remove_buddy 
	RemoveBuddy <...> 
	back_from_shell_buddy_options 
ENDSCRIPT

SCRIPT back_from_shell_buddy_options 
	dialog_box_exit 
	launch_homie_list 
ENDSCRIPT

SCRIPT net_chosen_join_server 
	printf "******* In net_chosen_join_server *******" 
	LeaveServer 
	setservermode OFF 
	IF GotParam cookie 
		IF ObjectExists id = current_menu_anchor 
			DestroyScreenElement id = current_menu_anchor 
		ENDIF 
		show_nat_start_dialog 
		IF NOT StartNatNegotiation <...> 
			create_join_failed_dialog 
		ENDIF 
	ELSE 
		JoinServer <...> 
	ENDIF 
	PlaySkaterCamAnim Name = SS_MenuCam play_hold 
	kill_start_key_binding 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	change check_for_unplugged_controllers = 0 
ENDSCRIPT

SCRIPT create_lobby_list_menu 
	FormatText ChecksumName = rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	build_top_and_bottom_blocks 
	make_mainmenu_3d_plane 
	CreateScreenElement { 
		Type = ContainerElement 
		parent = root_window 
		id = lobby_list_anchor 
		pos = PAIR(-5.00000000000, 800.00000000000) 
	} 
	make_new_menu { menu_id = lobby_list_menu 
		parent = lobby_list_anchor 
		Type = vscrollingmenu 
		dims = PAIR(200.00000000000, 252.00000000000) 
		pos = PAIR(80.00000000000, 132.00000000000) 
		vmenu_id = lobby_list_vmenu 
		menu_title = "" 
		dont_allow_wrap = dont_allow_wrap 
	} 
	CreateScreenElement { 
		Type = textElement 
		parent = lobby_list_anchor 
		font = testtitle 
		text = "REGIONS" 
		scale = 1.50000000000 
		pos = PAIR(92.00000000000, 86.00000000000) 
		just = [ left top ] 
		rgba = [ 128 128 128 98 ] 
		not_focusable 
	} 
	CreateScreenElement { 
		Type = SpriteElement 
		parent = lobby_list_anchor 
		texture = regions 
		scale = 1 
		pos = PAIR(39.00000000000, 82.00000000000) 
		just = [ left top ] 
		rgba = <rgba> 
		scale = PAIR(1.02499997616, 1.00000000000) 
		alpha = 0.60000002384 
		not_focusable 
	} 
	CreateScreenElement { 
		Type = SpriteElement 
		parent = lobby_list_anchor 
		id = regions_up_arrow 
		texture = up_arrow 
		scale = 1 
		pos = PAIR(150.00000000000, 121.00000000000) 
		just = [ left top ] 
		rgba = [ 128 128 128 98 ] 
		not_focusable 
	} 
	CreateScreenElement { 
		Type = SpriteElement 
		parent = lobby_list_anchor 
		id = regions_down_arrow 
		texture = down_arrow 
		scale = 1 
		pos = PAIR(150.00000000000, 336.00000000000) 
		just = [ left top ] 
		rgba = [ 128 128 128 98 ] 
		not_focusable 
	} 
	theme_background parent = lobby_list_anchor width = 2.25000000000 pos = PAIR(170.00000000000, 78.00000000000) num_parts = 10 
	SetScreenElementLock id = root_window OFF 
	SetScreenElementProps { id = lobby_list_menu event_handlers = [ { pad_back generic_menu_pad_back params = { callback = back_from_regions_menu } } ] } 
	SetScreenElementProps { id = lobby_list_vmenu event_handlers = [ 
			{ pad_up set_which_arrow params = { arrow = regions_up_arrow } } 
			{ pad_down set_which_arrow params = { arrow = regions_down_arrow } } 
		] 
	} 
	RunScriptOnScreenElement lobby_list_animate_in id = lobby_list_anchor 
	FireEvent Type = focus target = lobby_list_menu 
ENDSCRIPT

SCRIPT lobby_list_animate_in id = lobby_list_anchor 
	DoScreenElementMorph id = <id> pos = PAIR(-5.00000000000, 0.00000000000) time = 0.30000001192 
ENDSCRIPT

SCRIPT regions_menu_add_item 
	FormatText ChecksumName = id "%i" i = <text> 
	theme_menu_add_item { parent = lobby_list_vmenu centered <...> menu = 2 no_bg = no_bg } 
ENDSCRIPT

SCRIPT regions_menu_set_focus 
	generic_menu_update_arrows { 
		up_arrow_id = regions_up_arrow 
		down_arrow_id = regions_down_arrow 
	} 
	lobby_list_vmenu : GetTags 
	IF GotParam arrow_id 
		menu_vert_blink_arrow { id = <arrow_id> } 
	ENDIF 
	main_theme_focus <...> 
ENDSCRIPT

SCRIPT create_pin_entry_menu 
	make_new_menu menu_id = pin_entry_menu vmenu_id = pin_entry_vmenu menu_title = "ENTER PIN" 
	SetScreenElementLock id = root_window OFF 
	SetScreenElementProps { id = pin_entry_menu event_handlers = [ 
			{ pad_back generic_menu_pad_back params = { callback = do_nothing } } 
		] 
	} 
	RunScriptOnScreenElement id = main_menu_anchor menu_onscreen 
ENDSCRIPT

SCRIPT create_buddy_list_menu 
	make_new_menu menu_title = "Friend List" 
	SetScreenElementLock id = root_window OFF 
	SetScreenElementProps { id = main_menu event_handlers = [ 
			{ pad_back generic_menu_pad_back params = { callback = launch_xbox_online_menu } } 
		] 
	} 
	RunScriptOnScreenElement id = current_menu_anchor menu_onscreen 
ENDSCRIPT

SCRIPT back_from_regions_menu 
	StopServerList 
	FreeServerList 
	LobbyDisconnect 
	CancelNatNegotiation 
	FireEvent Type = unfocus target = lobby_list_menu 
	FireEvent Type = focus target = sub_menu 
	AssignAlias id = menu_parts_anchor alias = current_menu_anchor 
	DoScreenElementMorph id = lobby_list_anchor pos = PAIR(-5.00000000000, 800.00000000000) time = 0.30000001192 
	Wait 0.30000001192 Seconds 
	DestroyScreenElement id = lobby_list_anchor 
ENDSCRIPT

SCRIPT back_from_network_menu 
	StopServerList 
	FreeServerList 
	DestroyScreenElement id = current_menu_anchor 
	create_ss_menu no_animate 
ENDSCRIPT

SCRIPT back_from_multiplayer_menu 
	StopServerList 
	FreeServerList 
	back_from_network_select_menu <...> 
ENDSCRIPT

SCRIPT select_host_option 
	set_preferences_from_ui <...> 
	select_host_option2 
ENDSCRIPT

SCRIPT select_host_option2 
	launch_network_host_options_menu 
ENDSCRIPT

SCRIPT select_game_option 
	IF ( <checksum> = netctf ) 
		IF NOT InTeamGame 
			set_preferences_from_ui prefs = network field = "team_mode" checksum = teams_two string = "2" 
			SetNumTeams 2 
		ENDIF 
	ENDIF 
	set_preferences_from_ui <...> 
	SWITCH <checksum> 
		CASE netscorechallenge 
		CASE scorechallenge 
			set_preferences_from_ui prefs = <prefs> field = "target_score" checksum = score_1000000 score = 1000000 string = "1,000,000 points" 
		CASE netking 
		CASE king 
			set_preferences_from_ui prefs = <prefs> field = "target_score" checksum = time_120 time = 120 string = "2 minutes" 
		CASE netctf 
			set_preferences_from_ui prefs = <prefs> field = "target_score" checksum = score_5 score = 5 string = "5 captures" 
	ENDSWITCH 
	create_network_game_options_menu <...> 
ENDSCRIPT

SCRIPT select_team_mode_option 
	printf "in select_team_mode_option" 
	set_preferences_from_ui <...> 
	IF GameModeEquals is_lobby 
		printf "in select_team_mode_option 2" 
		GetPreferenceChecksum pref_type = network team_mode 
		SWITCH <checksum> 
			CASE teams_none 
				printf "SetNumTeams 0" 
				SetNumTeams 0 
			CASE teams_two 
				printf "SetNumTeams 2" 
				SetNumTeams 2 
			CASE teams_three 
				printf "SetNumTeams 3" 
				SetNumTeams 3 
			CASE teams_four 
				printf "SetNumTeams 4" 
				SetNumTeams 4 
			DEFAULT 
		ENDSWITCH 
	ENDIF 
	launch_network_host_options_menu 
ENDSCRIPT

SCRIPT create_host_options_goals_sub_menu pad_choose = select_host_option 
	dialog_box_exit 
	FormatText ChecksumName = title_icon "%i_online" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	make_new_themed_sub_menu title = "GOALS" title_icon = <title_icon> 
	IF levelIs Load_skateshop 
		CreateScreenElement { 
			Type = SpriteElement 
			parent = menu_parts_anchor 
			id = globe 
			texture = globe 
			scale = 1 
			pos = PAIR(550.00000000000, 240.00000000000) 
			just = [ center center ] 
			alpha = 0.20000000298 
			z_priority = -1 
		} 
		RunScriptOnScreenElement id = globe rotate_internet_options_globe 
	ENDIF 
	SetScreenElementProps { id = sub_menu 
		event_handlers = [ { pad_back generic_menu_pad_back params = { callback = launch_network_host_options_menu } } ] 
	} 
	theme_menu_add_item { 
		text = "STORY MODE GOALS" 
		pad_choose_script = <pad_choose> 
		pad_choose_params = { prefs = network field = "goals" string = "STORY MODE" checksum = goals_story } 
		centered = centered 
	} 
	GetPreferenceChecksum pref_type = network level 
	GoalEditor : GetNumEditedGoals level = <checksum> 
	IF ( <NumGoals> = 0 ) 
		<not_focusable> = not_focusable 
	ENDIF 
	theme_menu_add_item { 
		text = "USER CREATED GOALS" 
		pad_choose_script = <pad_choose> 
		pad_choose_params = { prefs = network field = "goals" string = "CREATED" checksum = goals_created } 
		centered = centered 
		<not_focusable> 
	} 
	theme_menu_add_item { 
		text = "LOAD CREATED GOALS" 
		pad_choose_script = host_options_goals_sub_menu_exit 
		pad_choose_params = { new_menu_script = launch_load_created_goals_from_host_goals_menu } 
		centered = centered 
		last_menu_item = last_menu_item 
	} 
	finish_themed_sub_menu 
ENDSCRIPT

SCRIPT game_options_goals_sub_menu_return 
	set_preferences_from_ui prefs = network field = "goals" string = "CREATED" checksum = goals_created 
	IF NOT levelIs Load_skateshop 
		dialog_box_exit 
		kill_start_key_binding 
		create_dialog_box { title = net_warning_msg 
			text = net_message_goals_next_level 
			buttons = [ 
				{ text = "ok" pad_choose_script = create_network_game_options_menu } 
			] 
		} 
	ELSE 
		create_network_game_options_menu 
	ENDIF 
ENDSCRIPT

SCRIPT host_options_goals_sub_menu_return 
	set_preferences_from_ui prefs = network field = "goals" string = "CREATED" checksum = goals_created 
	IF NOT levelIs Load_skateshop 
		dialog_box_exit 
		kill_start_key_binding 
		create_dialog_box { title = net_warning_msg 
			text = net_message_goals_next_level 
			buttons = [ 
				{ text = "ok" pad_choose_script = launch_network_host_options_menu } 
			] 
		} 
	ELSE 
		launch_network_host_options_menu 
	ENDIF 
ENDSCRIPT

SCRIPT host_options_goals_sub_menu_exit 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	<new_menu_script> <...> 
ENDSCRIPT

SCRIPT create_host_options_sub_menu pad_choose = select_host_option 
	FormatText ChecksumName = title_icon "%i_online" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	make_new_themed_sub_menu title = <menu_title> title_icon = <title_icon> 
	IF levelIs Load_skateshop 
		CreateScreenElement { 
			Type = SpriteElement 
			parent = menu_parts_anchor 
			id = globe 
			texture = globe 
			scale = 1 
			pos = PAIR(550.00000000000, 240.00000000000) 
			just = [ center center ] 
			alpha = 0.20000000298 
			z_priority = -1 
		} 
		RunScriptOnScreenElement id = globe rotate_internet_options_globe 
	ENDIF 
	SetScreenElementProps { id = sub_menu 
		event_handlers = [ { pad_back generic_menu_pad_back params = { callback = launch_network_host_options_menu } } ] 
	} 
	RemoveParameter id 
	IF GotParam array 
		GetArraySize <array> 
		IF GotParam max_index 
			<array_size> = ( <max_index> + 1 ) 
		ENDIF 
		<index> = 0 
		BEGIN 
			Name = ( ( <array> [ <index> ] ) . Name ) 
			IF StructureContains structure = ( <array> [ <index> ] ) checksum 
				checksum = ( ( <array> [ <index> ] ) . checksum ) 
			ENDIF 
			IF StructureContains structure = ( <array> [ <index> ] ) time 
				time = ( ( <array> [ <index> ] ) . time ) 
			ENDIF 
			IF StructureContains structure = ( <array> [ <index> ] ) broadband_only 
				orig_checksum = <checksum> 
				GetPreferenceChecksum pref_type = network device_type 
				SWITCH <checksum> 
					CASE device_sony_modem 
					CASE device_usb_modem 
						BREAK 
				ENDSWITCH 
				checksum = <orig_checksum> 
			ENDIF 
			pad_choose_params = { prefs = <pref_type> field = <pref_field> string = <Name> checksum = <checksum> time = <time> } 
			IF ( <pref_field> = "skill_level" ) 
				<just> = [ left center ] 
				RemoveParameter centered 
				text_pos = PAIR(20.00000000000, -5.00000000000) 
			ELSE 
				<just> = [ center center ] 
			ENDIF 
			IF ( <index> = 0 ) 
				theme_menu_add_item { 
					<...> 
					text = <Name> 
					pad_choose_script = <pad_choose> 
					pad_choose_params = <pad_choose_params> 
					text_just = <just> 
				} 
			ELSE 
				IF ( <index> = ( <array_size> - 1 ) ) 
					theme_menu_add_item { 
						last_menu_item = last_menu_item 
						<...> 
						text = <Name> 
						pad_choose_script = <pad_choose> 
						pad_choose_params = <pad_choose_params> 
						text_just = <just> 
					} 
				ELSE 
					theme_menu_add_item { 
						<...> 
						text = <Name> 
						pad_choose_script = <pad_choose> 
						pad_choose_params = <pad_choose_params> 
						text_just = <just> 
					} 
				ENDIF 
			ENDIF 
			<index> = ( <index> + 1 ) 
		REPEAT <array_size> 
	ENDIF 
	finish_themed_sub_menu 
ENDSCRIPT

SCRIPT create_game_options_sub_menu 
	IF InSplitScreenGame 
		prefs = splitscreen 
	ELSE 
		prefs = network 
	ENDIF 
	FormatText ChecksumName = title_icon "%i_2_player" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	PrintStruct <...> 
	IF ( <pref_field> = "game_type" ) 
		make_new_menu menu_id = options_sub_menu vmenu_id = options_sub_vmenu pos = PAIR(230.00000000000, 620.00000000000) 
		SetScreenElementProps { id = options_sub_menu event_handlers = [ 
				{ pad_back generic_menu_pad_back params = { callback = create_network_game_options_menu <...> } } 
			] 
		} 
		generic_array_menu_desc_setup <...> 
	ELSE 
		make_new_menu menu_id = options_sub_menu vmenu_id = options_sub_vmenu pos = PAIR(230.00000000000, 620.00000000000) 
		SetScreenElementProps { id = options_sub_menu event_handlers = [ 
				{ pad_back generic_menu_pad_back params = { callback = create_network_game_options_menu <...> } } 
			] 
		} 
		generic_array_menu_setup <...> 
	ENDIF 
	build_theme_sub_title title = <menu_title> title_icon = <title_icon> right_bracket_z = -1 right_bracket_alpha = 0.00000000000 
	FormatText ChecksumName = paused_icon "%i_paused_icon" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	build_theme_box_icons icon_texture = <paused_icon> 
	build_grunge_piece 
	build_top_bar pos = PAIR(-400.00000000000, 62.00000000000) 
	create_helper_text generic_helper_text 
	GoalManager_HideGoalPoints 
	GoalManager_HidePoints 
	DoScreenElementMorph id = options_sub_vmenu time = 0.20000000298 pos = PAIR(230.00000000000, 85.00000000000) 
	IF ( <pref_field> = "game_type" ) 
		DoScreenElementMorph id = bg_box_vmenu time = 0.20000000298 pos = PAIR(320.00000000000, 85.00000000000) 
		DoScreenElementMorph id = item_bg_box time = 0.20000000298 pos = PAIR(320.00000000000, 304.00000000000) 
		DoScreenElementMorph id = item_description_text time = 0.20000000298 pos = PAIR(320.00000000000, 294.00000000000) 
		DoScreenElementMorph id = item_description_bar time = 0.20000000298 pos = PAIR(320.00000000000, 299.00000000000) 
	ENDIF 
	IF ScreenElementExists id = top_bar_anchor 
		DoScreenElementMorph id = top_bar_anchor time = 0.20000000298 pos = PAIR(0.00000000000, 62.00000000000) 
	ENDIF 
	FireEvent Type = focus target = options_sub_menu 
ENDSCRIPT

SCRIPT set_host_option_preference 
	GetTextElementString id = keyboard_current_string 
	set_preferences_from_ui prefs = network <...> 
	destroy_onscreen_keyboard 
	create_network_host_options_menu 
ENDSCRIPT

SCRIPT host_options_back_from_keyboard 
	destroy_onscreen_keyboard 
	create_network_host_options_menu 
ENDSCRIPT

SCRIPT set_horse_option_preference 
	GetTextElementString id = keyboard_current_string 
	set_preferences_from_ui prefs = splitscreen <...> 
	horse_word_back_from_keyboard 
ENDSCRIPT

SCRIPT horse_word_back_from_keyboard 
	destroy_onscreen_keyboard 
	create_network_game_options_menu end_run 
ENDSCRIPT

SCRIPT create_network_host_options_server_name_menu 
	GetPreferenceString pref_type = network server_name 
	DestroyScreenElement id = current_menu_anchor 
	create_onscreen_keyboard allow_cancel keyboard_cancel_script = host_options_back_from_keyboard keyboard_done_script = set_host_option_preference keyboard_title = "NAME" field = "server_name" text = <ui_string> min_length = 1 max_length = 15 
ENDSCRIPT

SCRIPT create_network_host_options_password_menu 
	GetPreferenceString pref_type = network password 
	DestroyScreenElement id = current_menu_anchor 
	create_onscreen_keyboard password allow_cancel keyboard_cancel_script = host_options_back_from_keyboard keyboard_done_script = set_host_option_preference keyboard_title = "PASSWORD" field = "password" text = <ui_string> min_length = 0 max_length = 9 
ENDSCRIPT

SCRIPT create_network_host_options_levels_menu 
	IF IsTrue bootstrap_build 
		create_host_options_sub_menu menu_title = "LEVEL" pref_type = network pref_field = "level" array = e3_level_info call_script = select_host_option pos = PAIR(227.00000000000, 112.00000000000) 
	ELSE 
		create_host_options_sub_menu menu_title = "LEVEL" pref_type = network pref_field = "level" array = level_info call_script = select_host_option pos = PAIR(227.00000000000, 112.00000000000) helper_text = generic_helper_text 
	ENDIF 
ENDSCRIPT

SCRIPT create_network_host_options_goals_menu 
	create_host_options_sub_menu menu_title = "GOALS" pref_type = network pref_field = "goals" array = net_goal_info pad_choose_script = select_host_option pos = PAIR(227.00000000000, 112.00000000000) helper_text = generic_helper_text <...> centered 
ENDSCRIPT

SCRIPT create_network_host_options_max_players_menu 
	create_host_options_sub_menu menu_title = "PLAYERS" pref_type = network pref_field = "num_players" array = num_players_info pad_choose_script = select_host_option pos = PAIR(227.00000000000, 112.00000000000) helper_text = generic_helper_text <...> centered 
ENDSCRIPT

SCRIPT create_network_host_options_max_observers_menu 
	create_host_options_sub_menu menu_title = "OBSERVERS" pref_type = network pref_field = "num_observers" array = num_observers_info pad_choose_script = select_host_option pos = PAIR(227.00000000000, 112.00000000000) helper_text = generic_helper_text centered 
ENDSCRIPT

SCRIPT create_network_host_options_player_collision_menu 
	create_host_options_sub_menu menu_title = "PLAYER COLLISION" pref_type = network pref_field = "player_collision" array = on_off_types pad_choose_script = select_host_option helper_text = generic_helper_text centered 
ENDSCRIPT

SCRIPT create_network_host_options_team_menu 
	printf "in create_network_host_options_team_menu" 
	create_host_options_sub_menu menu_title = "TEAMS" pref_type = network pref_field = "team_mode" array = team_types pad_choose = select_team_mode_option pos = PAIR(227.00000000000, 112.00000000000) helper_text = generic_helper_text centered 
ENDSCRIPT

SCRIPT create_network_host_options_skill_level_menu 
	create_host_options_sub_menu menu_title = "SKILL LEVEL" pref_type = network pref_field = "skill_level" array = skill_level_info pad_choose_script = select_host_option pos = PAIR(227.00000000000, 112.00000000000) helper_text = generic_helper_text centered 
ENDSCRIPT

SCRIPT create_mp_game_options_game_type_menu 
	create_game_options_sub_menu menu_title = "GAME TYPE" pref_type = splitscreen pref_field = "game_type" array = mp_game_type_info call_script = select_game_option helper_text = generic_helper_text <...> 
ENDSCRIPT

SCRIPT create_network_game_options_game_type_menu 
	IF IsTrue DEMO_BUILD 
		create_game_options_sub_menu menu_title = "GAME TYPE" pref_type = network pref_field = "game_type" array = net_game_type_info_demo call_script = select_game_option helper_text = generic_helper_text <...> 
	ELSE 
		create_game_options_sub_menu menu_title = "GAME TYPE" pref_type = network pref_field = "game_type" array = net_game_type_info call_script = select_game_option helper_text = generic_helper_text <...> 
	ENDIF 
ENDSCRIPT

SCRIPT create_network_game_options_ctf_mode_menu 
	create_game_options_sub_menu menu_title = "MODE" pref_type = <prefs> pref_field = "ctf_game_type" array = ctf_type call_script = select_game_option helper_text = generic_helper_text <...> 
ENDSCRIPT

SCRIPT create_network_game_options_score_menu 
	create_game_options_sub_menu menu_title = "TARGET SCORE" pref_type = <prefs> pref_field = "target_score" array = target_score_options call_script = select_game_option helper_text = generic_helper_text <...> 
ENDSCRIPT

SCRIPT create_network_game_options_captures_menu 
	create_game_options_sub_menu menu_title = "CAPTURES" pref_type = <prefs> pref_field = "target_score" array = capture_options call_script = select_game_option helper_text = generic_helper_text <...> 
ENDSCRIPT

SCRIPT create_network_game_options_target_time_menu 
	create_game_options_sub_menu menu_title = "TIME LIMIT" pref_type = <prefs> pref_field = "target_score" array = time_limit_options call_script = select_game_option helper_text = generic_helper_text <...> 
ENDSCRIPT

SCRIPT create_network_game_options_time_menu 
	create_game_options_sub_menu menu_title = "TIME LIMIT" pref_type = network pref_field = "time_limit" array = time_limit_options call_script = select_game_option helper_text = generic_helper_text <...> 
ENDSCRIPT

SCRIPT create_network_game_options_friendly_fire_menu 
	create_game_options_sub_menu menu_title = "FRIENDLY FIRE" pref_type = network pref_field = "friendly_fire" array = on_off_types call_script = select_game_option helper_text = generic_helper_text <...> 
ENDSCRIPT

SCRIPT create_network_game_options_fireball_difficulty_menu 
	create_game_options_sub_menu menu_title = "FIREBALL DIFFICULTY" pref_type = network pref_field = "fireball_difficulty" array = fireball_level_info call_script = select_game_option helper_text = generic_helper_text <...> 
ENDSCRIPT

SCRIPT create_mp_game_options_stop_at_zero_menu 
	create_game_options_sub_menu menu_title = "STOP AT ZERO" pref_type = network pref_field = "stop_at_zero" array = boolean_types call_script = select_game_option helper_text = generic_helper_text <...> 
ENDSCRIPT

SCRIPT create_mp_game_options_time_menu 
	create_game_options_sub_menu menu_title = "TIME LIMIT" pref_type = splitscreen pref_field = "time_limit" array = time_limit_options call_script = select_game_option helper_text = generic_helper_text <...> 
ENDSCRIPT

SCRIPT create_mp_game_options_horse_time_menu 
	create_game_options_sub_menu menu_title = "TIME LIMIT" pref_type = splitscreen pref_field = "horse_time_limit" array = horse_time_limit_options call_script = select_game_option helper_text = generic_helper_text prefs = splitscreen <...> 
ENDSCRIPT

horse_allowed_characters = [ "1" "2" "3" "4" "5" "6" "7" "8" "9" "0" 
	"a" "b" "c" "d" "e" "f" "g" "h" "i" "j" 
	"k" "l" "m" "n" "o" "p" "q" "r" "s" "t" 
	"u" "v" "w" "x" "y" "z" 
	"A" "B" "C" "D" "E" "F" "G" "H" "I" "J" 
	"K" "L" "M" "N" "O" "P" "Q" "R" "S" "T" 
	"U" "V" "W" "X" "Y" "Z" 
	"." "," "!" "?" "-" "\xA6" "\'" "+" "^" 
	"#" "$" "*" "@" "`" "&" ":" "<" ">" 
	"_" "-" "=" "(" ")" "/" 
	"\xDF" "\xC4" "\xDC" "\xD6" "\xE0" "\xE2" "\xEA" "\xE8" "\xE9" "\xEB" 
	"\xEC" "\xEE" "\xEF" "\xF4" "\xF2" "\xD6" "\xF9" "\xFB" "\xDC" "\xE7" 
	"\x9C" "\xFC" "\xE4" "\xF6" "\xBC" "\xBD" "\xBE" "\xA2" "\xBA" "\xAE" 
"\xA1" "\xBF" "\xA3" "\xA5" "\xA7" "\xA9" ] 
SCRIPT create_mp_game_options_horse_word_menu 
	GetPreferenceString pref_type = splitscreen horse_word 
	create_onscreen_keyboard allowed_characters = horse_allowed_characters allow_cancel keyboard_cancel_script = horse_word_back_from_keyboard keyboard_done_script = set_horse_option_preference keyboard_title = "HORSE WORD" field = "horse_word" text = <ui_string> min_length = 1 max_length = 15 
ENDSCRIPT

SCRIPT create_account_list_menu 
	make_new_menu menu_id = account_list_menu vmenu_id = account_list_vmenu menu_title = "CHOOSE AN ACCOUNT" 
	SetScreenElementLock id = root_window OFF 
	SetScreenElementProps { id = account_list_menu event_handlers = [ 
			{ pad_back generic_menu_pad_back params = { callback = back_from_account_list_menu } } 
		] 
	} 
	RunScriptOnScreenElement id = current_menu_anchor menu_onscreen 
ENDSCRIPT

SCRIPT create_network_game_options_menu 
	dialog_box_exit 
	pause_menu_gradient on 
	hide_current_goal 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	IF InSplitScreenGame 
		prefs = splitscreen 
	ELSE 
		prefs = network 
	ENDIF 
	hide_net_player_names on 
	FormatText ChecksumName = title_icon "%i_2_player" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	make_new_themed_sub_menu title = "GAME OPTIONS" title_icon = <title_icon> right_bracket_alpha = 0.00000000000 
	IF GotParam end_run 
		SetScreenElementProps { id = sub_menu event_handlers = [ 
				{ pad_back generic_menu_pad_back params = { callback = create_end_run_menu } } 
			] 
		} 
	ELSE 
		SetScreenElementProps { id = sub_menu event_handlers = [ 
				{ pad_back generic_menu_pad_back params = { callback = create_pause_menu } } 
			] 
		} 
	ENDIF 
	GetPreferenceString pref_type = <prefs> game_type 
	IF InNetGame 
		theme_menu_add_item text = "Game Type:" extra_text = <ui_string> id = menu_network_host_options_game_type pad_choose_script = launch_network_host_options_sub_menu pad_choose_params = { sub_menu_script = create_network_game_options_game_type_menu } 
	ELSE 
		IF GotParam end_run 
			theme_menu_add_item text = "Game Type:" extra_text = <ui_string> id = menu_network_host_options_game_type pad_choose_script = launch_network_host_options_sub_menu pad_choose_params = { end_run sub_menu_script = create_mp_game_options_game_type_menu } 
		ELSE 
			theme_menu_add_item text = "Game Type:" extra_text = <ui_string> id = menu_network_host_options_game_type pad_choose_script = launch_network_host_options_sub_menu pad_choose_params = { sub_menu_script = create_mp_game_options_game_type_menu } 
		ENDIF 
	ENDIF 
	GetPreferenceChecksum pref_type = <prefs> game_type 
	SWITCH <checksum> 
		CASE netgoalattack 
			theme_menu_add_item text = "Choose Goals" centered = centered id = menu_network_host_options_choose_goals pad_choose_script = create_choose_goals_menu 
			IF OnServer 
				theme_menu_add_item text = "Load Created Goals" centered = centered pad_choose_script = host_options_goals_sub_menu_exit pad_choose_params = { new_menu_script = launch_load_created_goals_from_game_options_menu from_game_options = from_game_options } 
			ENDIF 
			IF GoalManager_GoalsAreSelected 
				theme_menu_add_item text = "Ready" id = menu_network_host_options_ready pad_choose_script = chosen_host_game last_menu_item = 1 
			ELSE 
				theme_menu_add_item text = "Ready" id = menu_network_host_options_ready pad_choose_script = chosen_host_game not_focusable rgba = [ 80 80 80 128 ] last_menu_item = 1 
			ENDIF 
		CASE freeskate2p 
			theme_menu_add_item text = "Ready" id = menu_network_host_options_ready pad_choose_script = chosen_host_game last_menu_item = 1 
		CASE horse 
		CASE nethorse 
			GetPreferenceString pref_type = <prefs> horse_time_limit 
			theme_menu_add_item text = "Time Limit:" extra_text = <ui_string> id = menu_network_host_options_time_limit pad_choose_script = launch_network_host_options_sub_menu pad_choose_params = { end_run sub_menu_script = create_mp_game_options_horse_time_menu } 
			GetPreferenceString pref_type = <prefs> horse_word 
			theme_menu_add_item text = "Horse Word:" extra_text = <ui_string> id = menu_network_host_options_horse_word pad_choose_script = launch_network_host_options_sub_menu pad_choose_params = { end_run sub_menu_script = create_mp_game_options_horse_word_menu } 
			theme_menu_add_item text = "Ready" id = menu_network_host_options_ready pad_choose_script = chosen_host_game last_menu_item = 1 
		CASE scorechallenge 
		CASE netscorechallenge 
			GetPreferenceString pref_type = <prefs> target_score 
			IF GotParam end_run 
				theme_menu_add_item text = "Target Score:" extra_text = <ui_string> id = menu_network_host_options_target_score pad_choose_script = launch_network_host_options_sub_menu pad_choose_params = { end_run sub_menu_script = create_network_game_options_score_menu prefs = <prefs> } 
			ELSE 
				theme_menu_add_item text = "Target Score:" extra_text = <ui_string> id = menu_network_host_options_target_score pad_choose_script = launch_network_host_options_sub_menu pad_choose_params = { sub_menu_script = create_network_game_options_score_menu prefs = <prefs> } 
			ENDIF 
			theme_menu_add_item text = "Ready" id = menu_network_host_options_ready pad_choose_script = chosen_host_game last_menu_item = 1 
		CASE netctf 
			GetPreferenceString pref_type = <prefs> ctf_game_type 
			theme_menu_add_item text = "Mode:" extra_text = <ui_string> id = menu_network_host_options_ctf_mode pad_choose_script = launch_network_host_options_sub_menu pad_choose_params = { sub_menu_script = create_network_game_options_ctf_mode_menu prefs = <prefs> } 
			GetPreferenceChecksum pref_type = <prefs> ctf_game_type 
			SWITCH <checksum> 
				CASE timed_ctf 
					GetPreferenceString pref_type = <prefs> time_limit 
					theme_menu_add_item text = "Time Limit:" extra_text = <ui_string> id = menu_network_host_options_time_limit pad_choose_script = launch_network_host_options_sub_menu pad_choose_params = { sub_menu_script = create_network_game_options_time_menu } 
				CASE score_ctf 
					GetPreferenceString pref_type = <prefs> target_score 
					theme_menu_add_item text = "Captures:" extra_text = <ui_string> id = menu_network_host_options_target_score pad_choose_script = launch_network_host_options_sub_menu pad_choose_params = { sub_menu_script = create_network_game_options_captures_menu prefs = <prefs> } 
			ENDSWITCH 
			GetPreferenceChecksum pref_type = <prefs> ctf_game_type 
			SWITCH <checksum> 
				CASE timed_ctf 
					GetPreferenceString pref_type = <prefs> stop_at_zero 
					theme_menu_add_item text = "Stop at Zero:" extra_text = <ui_string> id = menu_network_host_options_stop_at_zero pad_choose_script = launch_network_host_options_sub_menu pad_choose_params = { sub_menu_script = create_mp_game_options_stop_at_zero_menu } 
			ENDSWITCH 
			theme_menu_add_item text = "Ready" id = menu_network_host_options_ready pad_choose_script = chosen_host_game last_menu_item = 1 
		CASE king 
		CASE netking 
			GetPreferenceString pref_type = <prefs> target_score 
			IF GotParam end_run 
				theme_menu_add_item text = "Time Limit:" extra_text = <ui_string> id = menu_network_host_options_target_score pad_choose_script = launch_network_host_options_sub_menu pad_choose_params = { end_run sub_menu_script = create_network_game_options_target_time_menu prefs = <prefs> } 
			ELSE 
				theme_menu_add_item text = "Time Limit:" extra_text = <ui_string> id = menu_network_host_options_target_score pad_choose_script = launch_network_host_options_sub_menu pad_choose_params = { sub_menu_script = create_network_game_options_target_time_menu prefs = <prefs> } 
			ENDIF 
			theme_menu_add_item text = "Ready" id = menu_network_host_options_ready pad_choose_script = chosen_host_game last_menu_item = 1 
		CASE firefight 
		CASE netfirefight 
			IF InNetGame 
				GetPreferenceString pref_type = <prefs> friendly_fire 
				theme_menu_add_item text = "Friendly Fire:" extra_text = <ui_string> id = menu_network_host_options_friendly_fire pad_choose_script = launch_network_host_options_sub_menu pad_choose_params = { sub_menu_script = create_network_game_options_friendly_fire_menu prefs = <prefs> } 
				GetPreferenceString pref_type = <prefs> fireball_difficulty 
				theme_menu_add_item text = "Fireball Combo Level:" extra_text = <ui_string> id = menu_network_host_options_fireball_difficulty pad_choose_script = launch_network_host_options_sub_menu pad_choose_params = { sub_menu_script = create_network_game_options_fireball_difficulty_menu prefs = <prefs> } 
			ENDIF 
			theme_menu_add_item text = "Ready" id = menu_network_host_options_ready pad_choose_script = chosen_host_game last_menu_item = 1 
		DEFAULT 
			GetPreferenceString pref_type = <prefs> time_limit 
			IF InNetGame 
				theme_menu_add_item text = "Time Limit:" extra_text = <ui_string> id = menu_network_host_options_time_limit pad_choose_script = launch_network_host_options_sub_menu pad_choose_params = { sub_menu_script = create_network_game_options_time_menu } 
			ELSE 
				IF GotParam end_run 
					theme_menu_add_item text = "Time Limit:" extra_text = <ui_string> id = menu_network_host_options_time_limit pad_choose_script = launch_network_host_options_sub_menu pad_choose_params = { end_run sub_menu_script = create_mp_game_options_time_menu } 
				ELSE 
					theme_menu_add_item text = "Time Limit:" extra_text = <ui_string> id = menu_network_host_options_time_limit pad_choose_script = launch_network_host_options_sub_menu pad_choose_params = { sub_menu_script = create_mp_game_options_time_menu } 
				ENDIF 
			ENDIF 
			IF InNetGame 
				GetPreferenceString pref_type = <prefs> stop_at_zero 
				theme_menu_add_item text = "Stop at Zero:" extra_text = <ui_string> id = menu_network_host_options_stop_at_zero pad_choose_script = launch_network_host_options_sub_menu pad_choose_params = { sub_menu_script = create_mp_game_options_stop_at_zero_menu } 
			ENDIF 
			theme_menu_add_item text = "Ready" id = menu_network_host_options_ready pad_choose_script = chosen_host_game last_menu_item = 1 
	ENDSWITCH 
	GoalManager_HideGoalPoints 
	GoalManager_HidePoints 
	finish_themed_sub_menu 
ENDSCRIPT

SCRIPT set_game_options_ready_focus 
	menu_onscreen <...> 
	FireEvent Type = unfocus target = host_options_vmenu 
	FireEvent Type = focus target = host_options_vmenu data = { child_id = menu_network_host_options_ready } 
ENDSCRIPT

SCRIPT create_network_host_options_menu 
	change in_server_options = 1 
	dialog_box_exit 
	IF OnXbox 
		title_text = "HOST OPTIONS" 
	ELSE 
		title_text = "SERVER OPTIONS" 
	ENDIF 
	IF levelIs Load_skateshop 
		skater : remove_skater_from_world 
		KillSkaterCamAnim all 
		PlaySkaterCamAnim skater = 0 Name = mainmenu_camera03 play_hold 
	ELSE 
		pause_menu_gradient on 
	ENDIF 
	FormatText ChecksumName = title_icon "%i_online" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	make_new_themed_sub_menu title = <title_text> title_icon = <title_icon> menu_id = host_options_menu vmenu_id = host_options_vmenu 
	IF levelIs Load_skateshop 
		CreateScreenElement { 
			Type = SpriteElement 
			parent = menu_parts_anchor 
			id = globe 
			texture = globe 
			scale = 1 
			pos = PAIR(550.00000000000, 240.00000000000) 
			just = [ center center ] 
			alpha = 0.20000000298 
			z_priority = -1 
		} 
	ENDIF 
	IF IsInternetGameHost 
		SetScreenElementProps { 
			id = host_options_menu 
			event_handlers = [ { pad_back quit_game } ] 
		} 
	ELSE 
		SetScreenElementProps { 
			id = host_options_vmenu 
			event_handlers = [ { pad_back generic_menu_pad_back params = { callback = back_from_internet_host_options } } ] 
		} 
	ENDIF 
	IF InNetGame 
		IF OnServer 
			actual_server = 1 
		ELSE 
			actual_server = 0 
		ENDIF 
	ELSE 
		actual_server = 1 
	ENDIF 
	IF ( <actual_server> = 1 ) 
		GetPreferenceString pref_type = network server_name 
		theme_menu_add_item { 
			parent = host_options_vmenu 
			text = "Name:" 
			extra_text = <ui_string> 
			id = menu_network_host_options_server_name 
			pad_choose_script = create_network_host_options_server_name_menu 
			first_item 
		} 
	ENDIF 
	IF NOT InNetGame 
		GetPreferenceString pref_type = network level 
		theme_menu_add_item { 
			parent = host_options_vmenu 
			text = "Level:" 
			extra_text = <ui_string> 
			id = menu_network_host_options_level 
			pad_choose_script = launch_level_select_menu 
			pad_choose_params = { from_server_options } 
		} 
	ENDIF 
	IF isPS2 
		IF InNetGame 
			IF ( <actual_server> = 1 ) 
				IF GameModeEquals is_lobby 
					IF NOT NetworkGamePending 
						IF NOT ChangeLevelPending 
							GetPreferenceString pref_type = network level 
							GetPreferenceChecksum pref_type = network level 
							IF ( <checksum> = load_sk5ed_gameplay ) 
								set_preferences_from_ui prefs = network field = "goals" string = ( ( ( net_goal_info ) [ 1 ] ) . Name ) checksum = ( ( ( net_goal_info ) [ 1 ] ) . checksum ) 
								<not_focusable> = not_focusable 
							ELSE 
								GoalEditor : GetNumEditedGoals level = <checksum> 
								IF ( <NumGoals> = 0 ) 
									set_preferences_from_ui prefs = network field = "goals" string = ( ( ( net_goal_info ) [ 0 ] ) . Name ) checksum = ( ( ( net_goal_info ) [ 0 ] ) . checksum ) 
								ENDIF 
							ENDIF 
							GetPreferenceString pref_type = network goals 
							IF NOT GoalManager_HasActiveGoals 
								theme_menu_add_item { 
									text = "LOAD GOALS" 
									pad_choose_script = host_options_goals_sub_menu_exit 
									pad_choose_params = { new_menu_script = launch_load_created_goals_from_host_goals_menu } 
									centered = centered 
								} 
							ENDIF 
						ENDIF 
					ENDIF 
				ENDIF 
			ENDIF 
		ELSE 
			IF ( <actual_server> = 1 ) 
				GetPreferenceString pref_type = network level 
				GetPreferenceChecksum pref_type = network level 
				IF ( <checksum> = load_sk5ed_gameplay ) 
					set_preferences_from_ui prefs = network field = "goals" string = ( ( ( net_goal_info ) [ 1 ] ) . Name ) checksum = ( ( ( net_goal_info ) [ 1 ] ) . checksum ) 
					<not_focusable> = not_focusable 
				ELSE 
					GoalEditor : GetNumEditedGoals level = <checksum> 
					IF ( <NumGoals> = 0 ) 
						set_preferences_from_ui prefs = network field = "goals" string = ( ( ( net_goal_info ) [ 0 ] ) . Name ) checksum = ( ( ( net_goal_info ) [ 0 ] ) . checksum ) 
					ENDIF 
				ENDIF 
				GetPreferenceString pref_type = network goals 
				IF NOT GoalManager_HasActiveGoals 
					theme_menu_add_item { 
						text = "LOAD GOALS" 
						pad_choose_script = host_options_goals_sub_menu_exit 
						pad_choose_params = { new_menu_script = launch_load_created_goals_from_host_goals_menu } 
						centered = centered 
					} 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
	IF OnServer 
		IF NOT InNetGame 
			<max_index> = 6 
			GetPreferenceString pref_type = network level 
			IF ( <ui_string> = "Created Park" ) 
				GetParkEditorMaxPlayers 
				GetParkEditorMaxPlayers 
				GetParkEditorMaxPlayers 
				GetPreferenceChecksum pref_type = network num_players 
				SWITCH <checksum> 
					CASE num_2 
						<cur_max> = 2 
					CASE num_3 
						<cur_max> = 3 
					CASE num_4 
						<cur_max> = 4 
					CASE num_5 
						<cur_max> = 5 
					CASE num_6 
						<cur_max> = 6 
					CASE num_7 
						<cur_max> = 7 
					CASE num_8 
						<cur_max> = 8 
				ENDSWITCH 
				<max_index> = ( <MaxPlayers> -2 ) 
				IF ( <MaxPlayers> < 2 ) 
					ScriptAssert "Too low max players for net game with created park" 
				ENDIF 
				IF ( ( ( ( num_players_info ) [ <max_index> ] ) . num ) < <cur_max> ) 
					set_preferences_from_ui prefs = network field = "num_players" string = ( ( ( num_players_info ) [ <max_index> ] ) . Name ) checksum = ( ( ( num_players_info ) [ <max_index> ] ) . checksum ) 
				ENDIF 
			ENDIF 
			IF ( <max_index> = 0 ) 
				GetPreferenceString pref_type = network num_players 
				theme_menu_add_item { 
					parent = host_options_vmenu 
					text = "Players:" 
					extra_text = <ui_string> 
					not_focusable = not_focusable 
					id = menu_network_host_options_max_players 
				} 
			ELSE 
				GetPreferenceString pref_type = network num_players 
				theme_menu_add_item { 
					parent = host_options_vmenu 
					text = "Players:" 
					extra_text = <ui_string> 
					id = menu_network_host_options_max_players 
					pad_choose_script = create_network_host_options_max_players_menu 
					pad_choose_params = { max_index = <max_index> } 
				} 
			ENDIF 
		ENDIF 
		IF InInternetMode 
			GetPreferenceChecksum pref_type = network device_type 
			SWITCH <checksum> 
				CASE device_sony_modem 
				CASE device_usb_modem 
					NullScript 
				DEFAULT 
					GetPreferenceString pref_type = network num_observers 
					theme_menu_add_item { 
						parent = host_options_vmenu 
						text = "Observers:" 
						extra_text = <ui_string> 
						id = menu_network_host_options_max_observers 
						pad_choose_script = create_network_host_options_max_observers_menu 
					} 
			ENDSWITCH 
		ENDIF 
	ENDIF 
	IF NOT InNetGame 
		GetPreferenceString pref_type = network team_mode 
		theme_menu_add_item { 
			parent = host_options_vmenu 
			text = "Teams:" 
			extra_text = <ui_string> 
			id = menu_network_host_options_player_team 
			pad_choose_script = create_network_host_options_team_menu 
		} 
	ELSE 
		IF GameModeEquals is_lobby 
			IF IsHost 
				IF OnServer 
					GetPreferenceString pref_type = network team_mode 
					theme_menu_add_item { 
						parent = host_options_vmenu 
						text = "Teams:" 
						extra_text = <ui_string> 
						id = menu_network_host_options_player_team 
						pad_choose_script = create_network_host_options_team_menu 
					} 
				ELSE 
					GetPreferenceString pref_type = network team_mode 
					theme_menu_add_item { 
						parent = host_options_vmenu 
						text = "Teams:" 
						extra_text = <ui_string> 
						id = menu_network_host_options_player_team 
						pad_choose_script = create_network_host_options_team_menu 
						first_item 
					} 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
	IF IsHost 
		IF GameModeEquals is_lobby 
			IF NOT ( <actual_server> = 1 ) 
				<last_menu_item> = last_menu_item 
			ENDIF 
			GetPreferenceString pref_type = network player_collision 
			theme_menu_add_item { 
				parent = host_options_vmenu 
				text = "Collision:" 
				extra_text = <ui_string> 
				last_menu_item = <last_menu_item> 
				id = menu_network_host_options_player_collision 
				pad_choose_script = create_network_host_options_player_collision_menu 
			} 
		ENDIF 
	ENDIF 
	IF ( <actual_server> = 1 ) 
		GetPreferenceString pref_type = network skill_level 
		theme_menu_add_item { 
			parent = host_options_vmenu 
			text = "Skill Level:" 
			extra_text = <ui_string> 
			id = menu_network_host_options_skill_level 
			pad_choose_script = create_network_host_options_skill_level_menu 
		} 
		IF GameModeEquals is_lobby 
			GetPreferencePassword pref_type = network password 
			theme_menu_add_item { 
				parent = host_options_vmenu 
				text = "Password:" 
				extra_text = <password_string> 
				id = menu_network_host_options_password 
				pad_choose_script = create_network_host_options_password_menu 
			} 
			IF InNetGame 
				last_menu_item = last_menu_item 
			ENDIF 
			IF NOT IsHost 
				<not_focusables> = not_focusable 
			ENDIF 
			PrintStruct <not_focusables> 
			theme_menu_add_item { 
				parent = host_options_vmenu 
				text = "Advanced" 
				extra_text = "Options" 
				id = menu_real_cheats 
				pad_choose_script = create_real_cheats_menu 
				pad_choose_params = { back_script = create_network_host_options_menu } 
				last_menu_item = <last_menu_item> 
				not_focusable = <not_focusables> 
			} 
		ELSE 
			GetPreferencePassword pref_type = network password 
			IF InNetGame 
				last_menu_item = last_menu_item 
			ENDIF 
			theme_menu_add_item { 
				parent = host_options_vmenu 
				text = "Password:" 
				extra_text = <password_string> 
				id = menu_network_host_options_password 
				pad_choose_script = create_network_host_options_password_menu 
				last_menu_item = <last_menu_item> 
			} 
		ENDIF 
	ENDIF 
	IF NOT InNetGame 
		focusable = { } 
		GetPreferenceChecksum pref_type = network level 
		IF ( <checksum> = load_sk5ed_gameplay ) 
			GetParkEditorMaxPlayers 
			GetNetworkNumPlayers 
			IF ( <num_players> > <MaxPlayers> ) 
				focusable = { not_focusable } 
			ENDIF 
		ENDIF 
		theme_menu_add_item { 
			parent = host_options_vmenu 
			text = "Ready" 
			id = menu_network_host_options_ready 
			pad_choose_script = chosen_host_game 
			last_menu_item = last_menu_item 
			<focusable> 
		} 
	ENDIF 
	IF levelIs Load_skateshop 
		RunScriptOnScreenElement id = globe rotate_internet_options_globe 
	ENDIF 
	finish_themed_sub_menu menu = host_options_menu 
	IF NOT InNetGame 
		RunScriptOnScreenElement id = current_menu_anchor set_ready_focus 
	ENDIF 
ENDSCRIPT

SCRIPT set_ready_focus 
	FireEvent Type = unfocus target = host_options_vmenu 
	FireEvent Type = focus target = host_options_vmenu data = { child_id = menu_network_host_options_ready } 
ENDSCRIPT

SCRIPT network_host_options_menu_add_item { parent = current_menu 
		pad_choose_script = NullScript 
		focus_script = theme_item_focus 
		text = "Default text" 
		unfocus_script = theme_item_unfocus 
		pad_choose_script = null_script 
		pad_choose_sound = theme_menu_pad_choose_sound 
		scale = 1.00000000000 
		rgba = [ 88 105 112 118 ] 
		dims = PAIR(300.00000000000, 18.00000000000) 
		just = [ right center ] 
	} 
	IF GotParam not_focusable 
		<rgba> = [ 60 60 60 75 ] 
	ELSE 
		FormatText ChecksumName = text_color "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
		<rgba> = <text_color> 
	ENDIF 
	CreateScreenElement { 
		Type = ContainerElement 
		parent = <parent> 
		id = <id> 
		dims = <dims> 
		just = [ center center ] 
		event_handlers = [ 
			{ focus <focus_script> params = { text = <text> } } 
			{ unfocus <unfocus_script> } 
			{ pad_start <pad_choose_sound> } 
			{ pad_choose <pad_choose_sound> } 
			{ pad_choose <pad_choose_script> params = <pad_choose_params> } 
			{ pad_start <pad_choose_script> params = <pad_choose_params> } 
		] 
		<not_focusable> 
	} 
	container_id = <id> 
	CreateScreenElement { 
		Type = textElement 
		parent = <id> 
		font = small 
		text = <text1> 
		rgba = <rgba> 
		scale = <scale> 
		pos = PAIR(190.00000000000, 10.00000000000) 
		just = [ right center ] 
	} 
	IF NOT GotParam no_highlight_bar 
		highlight_angle = RANDOM_NO_REPEAT(1, 1, 1, 1, 1, 1, 1, 1, 1, 1) RANDOMCASE 2 RANDOMCASE -2 RANDOMCASE 3 RANDOMCASE -3 RANDOMCASE 3.50000000000 RANDOMCASE -3 RANDOMCASE 5 RANDOMCASE -4 RANDOMCASE 2.50000000000 RANDOMCASE -4.50000000000 RANDOMEND 
		CreateScreenElement { 
			Type = SpriteElement 
			parent = <container_id> 
			texture = DE_highlight_bar 
			pos = PAIR(120.00000000000, 10.00000000000) 
			rgba = [ 0 0 0 0 ] 
			just = [ center center ] 
			scale = PAIR(6.30000019073, 0.69999998808) 
			z_priority = 1 
			rot_angle = <highlight_angle> 
		} 
	ENDIF 
	CreateScreenElement { 
		Type = textElement 
		parent = <container_id> 
		font = dialog 
		text = <text2> 
		rgba = <rgba> 
		scale = 0.82999998331 
		pos = PAIR(200.00000000000, 10.00000000000) 
		just = [ left center ] 
	} 
ENDSCRIPT

SCRIPT network_host_options_menu_focus 
	GetTags 
	SetScreenElementProps { 
		id = { <id> child = 0 } 
		rgba = [ 128 128 128 128 ] 
	} 
	RunScriptOnScreenElement id = { <id> child = 1 } do_scale_up params = { rgba = [ 128 118 0 128 ] } 
	SetScreenElementProps { 
		id = { <id> child = 2 } 
		rgba = [ 128 128 128 50 ] 
	} 
ENDSCRIPT

SCRIPT network_host_options_menu_unfocus 
	GetTags 
	SetScreenElementProps { 
		id = { <id> child = 0 } 
		rgba = [ 88 105 112 128 ] 
	} 
	RunScriptOnScreenElement id = { <id> child = 1 } do_scale_down params = { rgba = [ 127 102 0 128 ] } 
	SetScreenElementProps { 
		id = { <id> child = 2 } 
		rgba = [ 128 128 128 0 ] 
	} 
ENDSCRIPT

SCRIPT chosen_start_game 
	IF InNetGame 
		GetPreferenceChecksum pref_type = network game_type 
		IF ( <checksum> = netctf ) 
			IF NOT InTeamGame 
				set_preferences_from_ui prefs = network field = "team_mode" checksum = teams_two string = "2" 
				SetNumTeams 2 
			ENDIF 
		ENDIF 
	ELSE 
	ENDIF 
	LoadPendingPlayers 
	StartNetworkGame 
	IF InSplitScreenGame 
		skater : RunStarted 
		Skater2 : RunStarted 
	ENDIF 
	IF ObjectExists id = current_menu_anchor 
		exit_pause_menu 
	ENDIF 
ENDSCRIPT

SCRIPT network_options_selected 
	PauseMusicAndStreams 
	hide_current_goal 
	launch_network_host_options_menu 
ENDSCRIPT

SCRIPT network_game_options_selected 
	create_network_game_options_menu <...> 
ENDSCRIPT

SCRIPT network_start_selected 
	IF OnServer 
		chosen_start_game 
	ELSE 
		FCFSRequestStartGame 
		exit_pause_menu 
	ENDIF 
ENDSCRIPT

SCRIPT fcfc_end_game_selected 
	ReportStats final 
	do_backend_retry 
ENDSCRIPT

SCRIPT network_end_game_selected 
	IF GameIsOver 
		create_pause_menu 
		RETURN 
	ENDIF 
	kill_all_panel_messages 
	IF InSplitScreenGame 
		SetStatOverride 
		GoalManager_DeactivateAllGoals 
		change_gamemode_freeskate_2p 
		ClearTrickAndScoreText 
		pause_trick_text 
		create_end_run_menu 
	ELSE 
		IF InInternetMode 
			IF OnServer 
				ReportStats final 
			ENDIF 
		ENDIF 
		EndNetworkGame 
	ENDIF 
ENDSCRIPT

SCRIPT generic_array_menu_setup time = 60 
	add_item_script = theme_menu_add_centered_item 
	IF NOT ( <pref_field> = "game_type" ) 
		IF NOT ( <pref_field> = "device_type" ) 
		ENDIF 
	ENDIF 
	GetArraySize <array> 
	<array_size> = ( <array_size> -1 ) 
	BEGIN 
		GetNextArrayElement <array> 
		IF GotParam Element 
			AddParams <Element> 
			IF ( <pref_field> = "game_type" ) 
				focus_script = game_options_focus_script 
				focus_params = { description = <description> } 
				add_item_script = make_text_sub_menu_item 
			ENDIF 
			IF GotParam not_in_custom_parks 
				IF CustomParkMode just_using 
					show_option = 0 
				ELSE 
					show_option = 1 
				ENDIF 
			ELSE 
				show_option = 1 
			ENDIF 
			IF GotParam not_pal 
				IF IsPal 
					show_option = 0 
				ENDIF 
			ENDIF 
			IF NOT ( <array_size> = 0 ) 
				IF ( <show_option> = 1 ) 
					IF GotParam not_available 
						theme_menu_add_item text = <Name> id = <checksum> font = small centered = 1 rgba = [ 80 80 80 128 ] pad_choose_script = <call_script> pad_choose_params = { prefs = <pref_type> field = <pref_field> string = <Name> checksum = <checksum> time = <time> } not_focusable highlight_bar_scale = <highlight_bar_scale> scale = <scale> 
					ELSE 
						IF GotParam team_only 
							IF InTeamGame 
								theme_menu_add_item text = <Name> id = <checksum> font = small centered = 1 pad_choose_script = <call_script> pad_choose_params = { prefs = <pref_type> field = <pref_field> string = <Name> checksum = <checksum> time = <time> <...> } focus_script = <focus_script> focus_params = <focus_params> highlight_bar_scale = <highlight_bar_scale> scale = <scale> 
							ELSE 
								theme_menu_add_item text = <Name> id = <checksum> font = small centered = 1 rgba = [ 80 80 80 128 ] pad_choose_script = <call_script> pad_choose_params = { prefs = <pref_type> field = <pref_field> string = <Name> checksum = <checksum> time = <time> } not_focusable highlight_bar_scale = <highlight_bar_scale> scale = <scale> 
							ENDIF 
						ELSE 
							theme_menu_add_item text = <Name> id = <checksum> font = small centered = 1 pad_choose_script = <call_script> pad_choose_params = { prefs = <pref_type> field = <pref_field> string = <Name> checksum = <checksum> time = <time> <...> } focus_script = <focus_script> focus_params = <focus_params> highlight_bar_scale = <highlight_bar_scale> scale = <scale> 
						ENDIF 
					ENDIF 
				ENDIF 
			ELSE 
				IF ( <show_option> = 1 ) 
					IF GotParam not_available 
						theme_menu_add_item text = <Name> id = <checksum> font = small centered = 1 rgba = [ 80 80 80 128 ] pad_choose_script = <call_script> pad_choose_params = { prefs = <pref_type> field = <pref_field> string = <Name> checksum = <checksum> time = <time> } not_focusable highlight_bar_scale = <highlight_bar_scale> scale = <scale> last_menu_item = 1 
					ELSE 
						IF GotParam team_only 
							IF InTeamGame 
								theme_menu_add_item text = <Name> id = <checksum> font = small centered = 1 pad_choose_script = <call_script> pad_choose_params = { prefs = <pref_type> field = <pref_field> string = <Name> checksum = <checksum> time = <time> <...> } focus_script = <focus_script> focus_params = <focus_params> highlight_bar_scale = <highlight_bar_scale> scale = <scale> last_menu_item = 1 
							ELSE 
								theme_menu_add_item text = <Name> id = <checksum> font = small centered = 1 rgba = [ 80 80 80 128 ] pad_choose_script = <call_script> pad_choose_params = { prefs = <pref_type> field = <pref_field> string = <Name> checksum = <checksum> time = <time> } not_focusable highlight_bar_scale = <highlight_bar_scale> scale = <scale> last_menu_item = 1 
							ENDIF 
						ELSE 
							theme_menu_add_item text = <Name> id = <checksum> font = small centered = 1 pad_choose_script = <call_script> pad_choose_params = { prefs = <pref_type> field = <pref_field> string = <Name> checksum = <checksum> time = <time> <...> } focus_script = <focus_script> focus_params = <focus_params> highlight_bar_scale = <highlight_bar_scale> scale = <scale> last_menu_item = 1 
						ENDIF 
					ENDIF 
				ENDIF 
			ENDIF 
			<array_size> = ( <array_size> -1 ) 
			RemoveParameter not_available 
			RemoveParameter not_in_custom_parks 
			RemoveParameter not_pal 
		ELSE 
			BREAK 
		ENDIF 
	REPEAT 
ENDSCRIPT

SCRIPT generic_array_menu_desc_setup time = 60 
	add_item_script = theme_menu_add_centered_item 
	IF NOT ( <pref_field> = "game_type" ) 
		IF NOT ( <pref_field> = "device_type" ) 
		ENDIF 
	ENDIF 
	GetArraySize <array> 
	<array_size> = ( <array_size> -1 ) 
	theme_background parent = current_menu_anchor id = bg_box_vmenu width = 3.50000000000 pos = PAIR(320.00000000000, 625.00000000000) num_parts = 9.50000000000 z_priority = 1 
	BEGIN 
		GetNextArrayElement <array> 
		IF GotParam Element 
			AddParams <Element> 
			IF ( <pref_field> = "game_type" ) 
				focus_script = game_options_focus_script 
				focus_params = { description = <description> } 
				add_item_script = make_text_sub_menu_item 
			ENDIF 
			IF GotParam not_in_custom_parks 
				IF CustomParkMode just_using 
					show_option = 0 
				ELSE 
					show_option = 1 
				ENDIF 
			ELSE 
				show_option = 1 
			ENDIF 
			IF GotParam not_pal 
				IF IsPal 
					show_option = 0 
				ENDIF 
			ENDIF 
			FormatText ChecksumName = icon_2p <icon> 
			IF NOT ( <array_size> = 0 ) 
				IF ( <show_option> = 1 ) 
					IF GotParam not_available 
						theme_menu_add_item text = <Name> id = <checksum> text_pos = PAIR(115.00000000000, -5.00000000000) no_bg font = small rgba = [ 80 80 80 128 ] pad_choose_script = <call_script> pad_choose_params = { prefs = <pref_type> field = <pref_field> string = <Name> checksum = <checksum> time = <time> } not_focusable highlight_bar_scale = PAIR(2.70000004768, 0.80000001192) scale = <scale> 
					ELSE 
						IF GotParam team_only 
							IF InTeamGame 
								theme_menu_add_item text = <Name> id = <checksum> text_pos = PAIR(115.00000000000, -5.00000000000) no_bg font = small pad_choose_script = <call_script> pad_choose_params = { prefs = <pref_type> field = <pref_field> string = <Name> checksum = <checksum> time = <time> <...> } focus_script = <focus_script> focus_params = { <focus_params> id = <checksum> icon = <icon_2p> text = <Name> } unfocus_script = sprite_unfocus highlight_bar_scale = PAIR(2.70000004768, 0.80000001192) scale = <scale> 
							ELSE 
								theme_menu_add_item text = <Name> id = <checksum> text_pos = PAIR(115.00000000000, -5.00000000000) no_bg font = small rgba = [ 80 80 80 128 ] pad_choose_script = <call_script> pad_choose_params = { prefs = <pref_type> field = <pref_field> string = <Name> checksum = <checksum> time = <time> } not_focusable highlight_bar_scale = PAIR(2.70000004768, 0.80000001192) scale = <scale> 
							ENDIF 
						ELSE 
							theme_menu_add_item text = <Name> id = <checksum> text_pos = PAIR(115.00000000000, -5.00000000000) no_bg font = small pad_choose_script = <call_script> pad_choose_params = { prefs = <pref_type> field = <pref_field> string = <Name> checksum = <checksum> time = <time> <...> } focus_script = <focus_script> focus_params = { <focus_params> id = <checksum> icon = <icon_2p> text = <Name> } unfocus_script = sprite_unfocus highlight_bar_scale = PAIR(2.70000004768, 0.80000001192) scale = <scale> 
						ENDIF 
					ENDIF 
				ENDIF 
			ELSE 
				IF ( <show_option> = 1 ) 
					IF GotParam not_available 
						theme_menu_add_item text = <Name> id = <checksum> text_pos = PAIR(115.00000000000, -5.00000000000) no_bg font = small rgba = [ 80 80 80 128 ] pad_choose_script = <call_script> pad_choose_params = { prefs = <pref_type> field = <pref_field> string = <Name> checksum = <checksum> time = <time> } not_focusable static_width = 400 highlight_bar_scale = PAIR(2.70000004768, 0.80000001192) scale = <scale> 
					ELSE 
						IF GotParam team_only 
							IF InTeamGame 
								theme_menu_add_item text = <Name> id = <checksum> text_pos = PAIR(115.00000000000, -5.00000000000) no_bg font = small pad_choose_script = <call_script> pad_choose_params = { prefs = <pref_type> field = <pref_field> string = <Name> checksum = <checksum> time = <time> <...> } focus_script = <focus_script> focus_params = { <focus_params> id = <checksum> icon = <icon_2p> text = <Name> } unfocus_script = sprite_unfocus static_width = 400 highlight_bar_scale = PAIR(2.70000004768, 0.80000001192) scale = <scale> 
							ELSE 
								theme_menu_add_item text = <Name> id = <checksum> text_pos = PAIR(115.00000000000, -5.00000000000) no_bg font = small rgba = [ 80 80 80 128 ] pad_choose_script = <call_script> pad_choose_params = { prefs = <pref_type> field = <pref_field> string = <Name> checksum = <checksum> time = <time> } not_focusable static_width = 400 highlight_bar_scale = PAIR(2.70000004768, 0.80000001192) scale = <scale> 
							ENDIF 
						ELSE 
							theme_menu_add_item text = <Name> id = <checksum> text_pos = PAIR(115.00000000000, -5.00000000000) no_bg font = small pad_choose_script = <call_script> pad_choose_params = { prefs = <pref_type> field = <pref_field> string = <Name> checksum = <checksum> time = <time> <...> } focus_script = <focus_script> focus_params = { <focus_params> id = <checksum> icon = <icon_2p> text = <Name> } unfocus_script = sprite_unfocus static_width = 400 highlight_bar_scale = PAIR(2.70000004768, 0.80000001192) scale = <scale> 
						ENDIF 
					ENDIF 
				ENDIF 
			ENDIF 
			<array_size> = ( <array_size> -1 ) 
			RemoveParameter not_available 
			RemoveParameter not_in_custom_parks 
			RemoveParameter not_pal 
		ELSE 
			BREAK 
		ENDIF 
	REPEAT 
	CreateScreenElement { 
		Type = SpriteElement 
		parent = current_menu_anchor 
		id = item_bg_box 
		padding_scale = 0.50000000000 
		texture = black 
		z_priority = 0 
		scale = PAIR(82.00000000000, 15.00000000000) 
		pos = PAIR(320.00000000000, 840.00000000000) 
		just = [ center top ] 
		rgba = [ 0 0 0 200 ] 
	} 
	FormatText ChecksumName = on_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = off_rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	CreateScreenElement { 
		Type = SpriteElement 
		parent = current_menu_anchor 
		id = item_description_bar 
		texture = white2 
		scale = PAIR(40.00000000000, 0.50000000000) 
		pos = PAIR(320.00000000000, 854.00000000000) 
		just = [ center top ] 
		rgba = <on_rgba> 
	} 
	CreateScreenElement { 
		Type = textBlockElement 
		parent = current_menu_anchor 
		id = item_description_text 
		text = "" 
		font = small 
		dims = PAIR(300.00000000000, 75.00000000000) 
		scale = 1.00000000000 
		line_spacing = 0.60000002384 
		pos = PAIR(320.00000000000, 838.00000000000) 
		just = [ center top ] 
		rgba = [ 80 80 80 50 ] 
	} 
	Wait 1 gameframe 
ENDSCRIPT

SCRIPT game_options_focus_script 
	SetScreenElementProps id = item_description_text text = <description> line_spacing = 0.80000001192 
	main_theme_focus <...> 
	theme_item_focus <...> 
	GetTags 
	FormatText ChecksumName = icon_color "%i_ICON_ON_VALUE" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	IF ( no_focus_sound = 1 ) 
		change no_focus_sound = 0 
	ELSE 
		SpawnScript play_icon_spin_sound 
	ENDIF 
	Wait 3 gameframes 
	IF ObjectExists id = cur_2p_sprite 
		DestroyScreenElement id = cur_2p_sprite 
	ENDIF 
	SetScreenElementLock id = <id> OFF 
	CreateScreenElement { 
		Type = SpriteElement 
		parent = <id> 
		id = cur_2p_sprite 
		texture = <icon> 
		pos = PAIR(140.00000000000, -25.00000000000) 
		just = [ center top ] 
		rgba = <icon_color> 
	} 
	DoScreenElementMorph id = cur_2p_sprite time = 0 scale = PAIR(0.00000000000, 0.00000000000) alpha = 0.00000000000 
	DoScreenElementMorph id = cur_2p_sprite time = 0.20000000298 scale = PAIR(1.29999995232, 1.29999995232) alpha = 1.00000000000 
ENDSCRIPT

SCRIPT game_type_description_box 
	CreateScreenElement { 
		Type = SpriteElement 
		parent = current_menu_anchor 
		id = item_bg_box 
		texture = black 
		z_priority = 0 
		scale = PAIR(85.00000000000, 12.00000000000) 
		pos = PAIR(160.00000000000, 350.00000000000) 
		just = [ left top ] 
		rgba = [ 0 0 0 80 ] 
	} 
	GetStackedScreenElementPos x id = item_bg_box offset = PAIR(1.00000000000, 0.00000000000) 
	CreateScreenElement { 
		Type = SpriteElement 
		parent = current_menu_anchor 
		texture = goal_right 
		z_priority = 0 
		scale = PAIR(0.85000002384, 0.18000000715) 
		pos = <pos> 
		just = [ center top ] 
		rgba = [ 0 0 0 80 ] 
	} 
	GetStackedScreenElementPos x id = item_bg_box offset = PAIR(-170.00000000000, 2.00000000000) 
	CreateScreenElement { 
		Type = textBlockElement 
		parent = current_menu_anchor 
		id = item_description_text 
		dims = PAIR(420.00000000000, 0.00000000000) 
		pos = <pos> 
		rgba = [ 50 50 50 100 ] 
		font = dialog 
		just = [ center top ] 
		internal_just = [ center top ] 
		scale = 0.80000001192 
		text = "" 
		not_focusable 
		allow_expansion 
	} 
	Wait 1 gameframe 
ENDSCRIPT

SCRIPT end_network_game 
	kill_all_panel_messages 
	dialog_box_exit 
	do_backend_retry 
ENDSCRIPT

SCRIPT CreateServerQuitDialog 
	printf "**** in CreateServerQuitDialog ****" 
	HideLoadingScreen 
	IF NOT levelIs Load_skateshop 
		printf "**** Level was not the skateshop ****" 
		GoalManager_DeactivateAllGoals force_all 
		GoalManager_UninitializeAllGoals 
		GoalManager_SetCanStartGoal 0 
		kill_net_panel_messages 
		destroy_onscreen_keyboard 
		force_close_rankings dont_retry 
		exit_pause_menu 
		HideLoadingScreen 
		IF NOT IsObserving 
			IF ObjectExists id = skater 
				skater : Vibrate OFF 
			ENDIF 
			ExitSurveyorMode 
		ENDIF 
		dialog_box_exit anchor_id = quit_dialog_anchor 
		change check_for_unplugged_controllers = 0 
		create_error_box { title = "Notice" 
			text = "The host has quit. Select OK to leave this game." 
			buttons = [ { text = "ok" pad_choose_script = quit_network_game } 
			] 
			delay_input 
			delay_input_time = 3000 
		} 
	ELSE 
		printf "*** Level IS the skateshop ***" 
	ENDIF 
ENDSCRIPT

SCRIPT create_game_ended_dialog 
	IF NOT levelIs Load_skateshop 
		GoalManager_DeactivateAllGoals force_all 
		GoalManager_UninitializeAllGoals 
		GoalManager_SetCanStartGoal 0 
		kill_net_panel_messages 
		destroy_onscreen_keyboard 
		force_close_rankings 
		exit_pause_menu 
		create_error_box { title = "Notice" 
			text = "The host has terminated the current game.  Select OK to go back to freeskate." 
			buttons = [ { text = "ok" pad_choose_script = end_network_game } 
			] 
			delay_input 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT accept_lost_connection 
	dialog_box_exit 
	IF EnteringNetGame 
		cancel_join_server 
	ELSE 
		quit_network_game 
	ENDIF 
ENDSCRIPT

SCRIPT CreateLostConnectionDialog 
	HideLoadingScreen 
	GoalManager_DeactivateAllGoals force_all 
	GoalManager_UninitializeAllGoals 
	GoalManager_SetCanStartGoal 0 
	exit_pause_menu 
	destroy_onscreen_keyboard 
	force_close_rankings dont_retry 
	IF InNetGame 
		IF LocalSkaterExists 
			skater : Vibrate OFF 
		ENDIF 
	ENDIF 
	IF NOT IsObserving 
		ExitSurveyorMode 
	ENDIF 
	dialog_box_exit 
	dialog_box_exit anchor_id = link_lost_dialog_anchor 
	dialog_box_exit anchor_id = quit_dialog_anchor 
	change check_for_unplugged_controllers = 0 
	create_error_box { title = "Notice" 
		text = "You have lost connection to the host. Select OK to leave this game." 
		buttons = [ { text = "ok" pad_choose_script = accept_lost_connection } 
		] 
		delay_input 
	} 
ENDSCRIPT

SCRIPT BackToServerListFromJoinRefusedDialog 
	dialog_box_exit 
	create_network_select_games_menu 
ENDSCRIPT

SCRIPT CreateJoinRefusedDialog 
	IF InNetGame 
		create_dialog_box { title = net_refused_msg 
			text = <reason> 
			buttons = [ { text = "ok" pad_choose_script = dialog_box_exit } 
			] 
		} 
	ELSE 
		IF GotParam just_dialog 
			create_dialog_box { title = net_refused_msg 
				text = <reason> 
				buttons = [ { text = "ok" pad_choose_script = BackToServerListFromJoinRefusedDialog } 
				] 
			} 
		ELSE 
			cancel_join_server show_refused_dialog <...> 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT create_refused_dialog 
	printf "******* in cancel_join_server 12" 
	IF InNetGame 
		create_dialog_box { title = net_refused_msg 
			text = <reason> 
			buttons = [ { text = "ok" pad_choose_script = dialog_box_exit } 
			] 
		} 
	ELSE 
		create_dialog_box { title = net_refused_msg 
			text = <reason> 
			buttons = [ { text = "ok" pad_choose_script = BackToServerListFromJoinRefusedDialog } 
			] 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT reattempt_join_server 
	ReattemptJoinServer 
	PlaySkaterCamAnim Name = SS_MenuCam play_hold 
ENDSCRIPT

SCRIPT cancel_join_server 
	printf "******* in cancel_join_server" 
	IF GotParam cancel_nn 
		CancelNatNegotiation 
	ENDIF 
	destroy_onscreen_keyboard 
	dialog_box_exit 
	printf "******* in cancel_join_server 2" 
	IF InInternetMode 
		printf "******* in cancel_join_server 3" 
		CancelJoinServer 
		restart_local_server 
		SetNetworkMode INTERNET_MODE 
	ELSE 
		printf "******* in cancel_join_server 4" 
		CancelJoinServer 
		printf "******* in cancel_join_server 5" 
		restart_local_server 
		printf "******* in cancel_join_server 6" 
		SetNetworkMode LAN_MODE 
	ENDIF 
	printf "******* in cancel_join_server 7" 
	IF GotParam show_timeout 
		printf "******* in cancel_join_server 8" 
		create_join_timeout_dialog 
	ELSE 
		IF GotParam show_refused_dialog 
			printf "******* in cancel_join_server 9" 
			create_refused_dialog <...> 
		ELSE 
			printf "******* in cancel_join_server 10" 
			create_network_select_games_menu 
		ENDIF 
	ENDIF 
	kill_start_key_binding 
	printf "******* in cancel_join_server 11" 
	BEGIN 
		IF LocalSkaterExists 
			MakeSkaterGoto SkateshopAI params = { NoSFX } 
			KillSkaterCamAnim all 
			skater : reset_model_lights 
			skater : remove_skater_from_world 
			KillSkaterCamAnim all 
			PlaySkaterCamAnim skater = 0 Name = mainmenu_camera03 play_hold 
			PlaySkaterCamAnim Name = SS_MenuCam play_hold 
			BREAK 
		ELSE 
			Wait 1 
		ENDIF 
	REPEAT 
ENDSCRIPT

SCRIPT CreateEnterPasswordControl 
	dialog_box_exit 
	create_onscreen_keyboard password allow_cancel keyboard_cancel_script = cancel_join_server keyboard_done_script = try_password keyboard_title = "ENTER PASSWORD" text = "" min_length = 1 max_length = 9 
ENDSCRIPT

SCRIPT try_password 
	GetTextElementString id = keyboard_current_string 
	destroy_onscreen_keyboard 
	JoinWithPassword <...> 
ENDSCRIPT

SCRIPT CreateGameInProgressDialog 
	dialog_box_exit 
	kill_start_key_binding 
	create_dialog_box { title = net_status_msg 
		text = net_message_game_in_progress 
		buttons = [ 
			{ text = "ok" pad_choose_script = reattempt_join_server } 
			{ text = "cancel" pad_choose_script = cancel_join_server } 
		] 
	} 
ENDSCRIPT

SCRIPT CreateConnectingDialog 
	kill_start_key_binding 
	PauseMusicAndStreams 
	create_dialog_box { title = net_status_msg 
		text = net_status_connecting 
		no_animate 
		buttons = [ 
			{ text = "cancel" pad_choose_script = cancel_join_server } 
		] 
	} 
ENDSCRIPT

SCRIPT CreateJoiningDialog 
	dialog_box_exit 
	kill_start_key_binding 
	create_dialog_box { title = net_status_msg 
		text = net_status_joining 
		no_animate 
		buttons = [ 
			{ text = "cancel" pad_choose_script = cancel_join_server } 
		] 
	} 
ENDSCRIPT

SCRIPT CreateTryingPasswordDialog 
	kill_start_key_binding 
	PauseMusicAndStreams 
	create_dialog_box { title = net_status_msg 
		text = net_status_trying_password 
		no_animate 
		buttons = [ 
			{ text = "cancel" pad_choose_script = cancel_join_server } 
		] 
	} 
ENDSCRIPT

SCRIPT wait_for_players 
	dialog_box_exit 
	create_net_panel_message text = net_message_game_will_start 
ENDSCRIPT

SCRIPT dont_wait_for_players 
	dialog_box_exit 
	DropPendingPlayers 
ENDSCRIPT

SCRIPT CreateWaitForPlayersDialog 
	IF ObjectExists id = pause_menu 
		exit_pause_menu 
	ENDIF 
	destroy_onscreen_keyboard 
	create_error_box { title = net_status_msg 
		text = net_message_waiting_for_players 
		no_animate 
		buttons = [ 
			{ text = "Yes" pad_choose_script = wait_for_players } 
			{ text = " No " pad_choose_script = dont_wait_for_players } 
		] 
		no_animate 
		delay_input 
	} 
ENDSCRIPT

SCRIPT back_from_join_timeout 
	dialog_box_exit 
	create_network_select_games_menu 
ENDSCRIPT

SCRIPT ShowJoinTimeoutNotice 
	cancel_join_server show_timeout 
ENDSCRIPT

SCRIPT create_join_timeout_dialog 
	dialog_box_exit 
	create_dialog_box { title = net_status_msg 
		text = net_status_join_timeout 
		buttons = [ 
			{ text = "ok" pad_choose_script = back_from_join_timeout } 
		] 
	} 
ENDSCRIPT

SCRIPT create_join_failed_dialog 
	create_dialog_box { title = net_status_msg 
		text = net_status_join_failed 
		buttons = [ 
			{ text = "ok" pad_choose_script = cancel_join_server } 
		] 
	} 
ENDSCRIPT

SCRIPT exit_net_menus 
	dialog_box_exit 
	SetGameType career 
	SetCurrentGameType 
	create_main_menu 
ENDSCRIPT

SCRIPT create_link_unplugged_front_end_dialog 
	back_from_multiplayer_menu no_menu 
	create_dialog_box { title = net_status_msg 
		text = net_error_unplugged_front_end 
		buttons = [ 
			{ text = "ok" pad_choose_script = exit_net_menus } 
		] 
	} 
ENDSCRIPT

SCRIPT link_unplugged_ok 
	dialog_box_exit anchor_id = quit_dialog_anchor no_pad_start 
	dialog_box_exit anchor_id = link_lost_dialog_anchor no_pad_start 
	<found_menu> = 0 
	IF ScreenElementExists id = current_menu_anchor 
		<found_menu> = 1 
		DoScreenElementMorph { 
			id = current_menu_anchor 
			scale = 1 
		} 
		FireEvent Type = focus target = current_menu_anchor 
	ENDIF 
	IF ScreenElementExists id = current_menu 
		<found_menu> = 1 
		FireEvent Type = focus target = current_menu 
	ENDIF 
	IF NOT levelIs Load_skateshop 
		IF ( <found_menu> = 0 ) 
			IF SkaterCamAnimFinished 
				create_pause_menu 
			ELSE 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT link_unplugged_quit 
	dialog_box_exit anchor_id = link_lost_dialog_anchor no_pad_start 
	launch_quit_game_dialog 
ENDSCRIPT

SCRIPT create_link_unplugged_dialog 
	IF ScreenElementExists id = dialog_box_anchor 
		RETURN 
	ENDIF 
	IF ScreenElementExists id = quit_dialog_anchor 
		RETURN 
	ENDIF 
	IF ScreenElementExists id = current_menu_anchor 
		DoScreenElementMorph { 
			id = current_menu_anchor 
			scale = 0 
		} 
		FireEvent Type = unfocus target = current_menu_anchor 
	ENDIF 
	IF ScreenElementExists id = current_menu 
		FireEvent Type = unfocus target = current_menu 
	ENDIF 
	destroy_onscreen_keyboard 
	create_error_box { title = net_error_msg 
		anchor_id = link_lost_dialog_anchor 
		text = net_error_unplugged 
		buttons = [ 
			{ text = "ok" pad_choose_script = link_unplugged_ok } 
			{ text = "quit" pad_choose_script = link_unplugged_quit } 
		] 
		no_animate 
	} 
	kill_start_key_binding 
ENDSCRIPT

SCRIPT exit_async_dialog 
	dialog_box_exit 
	IF GameIsOver 
		do_backend_retry 
	ENDIF 
ENDSCRIPT

SCRIPT CreateNotPostedDialog 
	kill_all_panel_messages 
	create_error_box { title = net_error_msg 
		text = net_status_not_posted 
		buttons = [ 
			{ text = "ok" pad_choose_script = exit_async_dialog } 
		] 
		no_animate 
		delay_input 
		z_priority = 50 
	} 
ENDSCRIPT

SCRIPT CreateGettingLobbyListDialog 
	dialog_box_exit 
	create_dialog_box { title = net_status_msg 
		text = net_status_getting_lobbies 
		no_animate 
		pos = PAIR(150.00000000000, 250.00000000000) 
	} 
ENDSCRIPT

SCRIPT CreateFailedLobbyListDialog 
	LobbyDisconnect 
	dialog_box_exit 
	create_dialog_box { title = net_status_msg 
		text = <message> 
		buttons = [ 
			{ text = "ok" pad_choose_script = cancel_gamespy_connection_failure_dialog } 
		] 
		pos = PAIR(150.00000000000, 250.00000000000) 
	} 
ENDSCRIPT

SCRIPT CreateJoinLobbyFailedDialog 
	LobbyDisconnect 
	dialog_box_exit 
	create_dialog_box { title = net_status_msg 
		text = "Failed to join lobby." 
		buttons = [ 
			{ text = "ok" pad_choose_script = create_internet_options } 
		] 
	} 
ENDSCRIPT

SCRIPT CreateConnectingChatDialog 
	create_dialog_box { title = net_status_msg 
		text = net_status_connecting_chat 
	} 
ENDSCRIPT

SCRIPT create_joining_lobby_dialog 
	create_dialog_box { title = net_status_msg 
		text = "Joining lobby..." 
		no_animate 
	} 
ENDSCRIPT

SCRIPT create_net_panel_message msg_time = 2000 
	create_panel_block id = net_panel_msg <...> pos = PAIR(320.00000000000, 150.00000000000) rgba = [ 144 144 144 128 ] dims = PAIR(450.00000000000, 0.00000000000) z_priority = -10 time = <msg_time> 
ENDSCRIPT

SCRIPT kill_net_panel_messages 
	console_clear 
	IF ObjectExists id = net_panel_msg 
		DestroyScreenElement id = net_panel_msg 
	ENDIF 
	IF ObjectExists id = taunt_msg_id 
		DestroyScreenElement id = taunt_msg_id 
	ENDIF 
	IF ScreenElementExists id = perfect 
		DestroyScreenElement id = perfect 
	ENDIF 
	IF ScreenElementExists id = perfect2 
		DestroyScreenElement id = perfect2 
	ENDIF 
	IF ScreenElementExists id = death_message 
		DestroyScreenElement id = death_message 
	ENDIF 
	IF ObjectExists id = speech_box_anchor 
		DoScreenElementMorph id = speech_box_anchor scale = 0 
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
	IF ObjectExists id = first_time_goal_info 
		DestroyScreenElement id = first_time_goal_info 
	ENDIF 
	IF ObjectExists id = skater_hint 
		DestroyScreenElement id = skater_hint 
	ENDIF 
	GetArraySize goal_panel_message_ids 
	<index> = 0 
	BEGIN 
		IF ScreenElementExists id = ( goal_panel_message_ids [ <index> ] ) 
			DestroyScreenElement id = ( goal_panel_message_ids [ <index> ] ) 
		ENDIF 
		<index> = ( <index> + 1 ) 
	REPEAT <array_size> 
ENDSCRIPT

SCRIPT cancel_connect_to_internet 
	printf "script cancel_connect_to_internet" 
	dialog_box_exit 
	CancelConnectToInternet 
ENDSCRIPT

SCRIPT create_modem_state_dialog 
	create_dialog_box { title = net_status_msg 
		text = <text> 
		no_animate 
		buttons = [ 
			{ text = "cancel" pad_choose_script = cancel_connect_to_internet } 
		] 
	} 
ENDSCRIPT

SCRIPT create_modem_status_dialog 
	create_dialog_box { title = net_status_msg 
		text = <text> 
		no_animate 
	} 
ENDSCRIPT

SCRIPT create_modem_final_state_dialog 
	create_dialog_box { title = net_status_msg 
		text = <text> 
		buttons = [ 
			{ text = "ok" pad_choose_script = cancel_connect_to_internet } 
		] 
	} 
ENDSCRIPT

SCRIPT cancel_gamespy_connection_failure_dialog 
	printf "script cancel_gamespy_connection_failure_dialog" 
	dialog_box_exit 
	StatsLogOff 
	ProfileLogOff 
	console_destroy 
	create_ss_menu no_animate 
	SetNetworkMode 
ENDSCRIPT

SCRIPT create_gamespy_connection_failure_dialog 
	LobbyDisconnect 
	create_dialog_box { title = net_error_msg 
		text = net_status_gamespy_no_connect 
		buttons = [ 
			{ text = "ok" pad_choose_script = cancel_gamespy_connection_failure_dialog } 
		] 
	} 
ENDSCRIPT

SCRIPT lost_connection_to_gamespy 
	printf "script lost_connection_to_gamespy" 
	LobbyDisconnect 
	IF StatsLoggedIn 
		StatsLogOff 
	ENDIF 
	IF ProfileLoggedIn 
		ProfileLogOff 
	ENDIF 
	IF levelIs Load_skateshop 
		IF ObjectExists id = console_message_vmenu 
			DoScreenElementMorph id = console_message_vmenu alpha = 0 
		ENDIF 
		cancel_keyboard 
		dialog_box_exit 
		exit_pause_menu 
		GoalManager_HidePoints 
		GoalManager_HideGoalPoints 
		create_dialog_box { title = net_error_msg 
			text = net_status_gamespy_lost_connection 
			buttons = [ 
				{ text = "ok" pad_choose_script = cancel_gamespy_connection_failure_dialog } 
			] 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT cancel_keyboard 
	IF ObjectExists id = keyboard_anchor 
		destroy_onscreen_keyboard 
	ELSE 
		RETURN 
	ENDIF 
	IF ObjectExists id = console_message_vmenu 
		DoScreenElementMorph id = console_message_vmenu alpha = 1 
	ENDIF 
	create_network_select_games_menu <...> 
ENDSCRIPT

SCRIPT enter_kb_chat_message 
	GetTextElementString id = keyboard_current_string 
	cancel_keyboard focus_on_enter_message 
	SendMessage text = <string> 
ENDSCRIPT

SCRIPT check_keyboard_focus 
	KillSpawnedScript Name = maybe_launch_lobby_keyboard 
	SpawnScript maybe_launch_lobby_keyboard 
	main_menu_focus <...> 
ENDSCRIPT

SCRIPT maybe_launch_lobby_keyboard 
	BEGIN 
		Wait 1 gameframe 
		IF NOT ScreenElementExists id = actions_menu 
			BREAK 
		ENDIF 
		LobbyCheckKeyboard 
	REPEAT 
ENDSCRIPT

SCRIPT check_keyboard_unfocus 
	KillSpawnedScript Name = maybe_launch_lobby_keyboard 
	main_menu_unfocus <...> 
ENDSCRIPT

SCRIPT lobby_enter_kb_chat 
	FireEvent Type = unfocus target = actions_menu 
	create_onscreen_keyboard { allow_cancel 
		no_buttons 
		pos = PAIR(320.00000000000, 530.00000000000) 
		keyboard_done_script = lobby_entered_chat_message 
		display_text = "ENTER MESSAGE: " 
		keyboard_title = "" 
		min_length = 1 
		max_length = 500 
		text_block 
		keyboard_cancel_script = lobby_keyboard_cancel 
	} 
ENDSCRIPT

SCRIPT lobby_entered_chat_message 
	GetTextElementString id = keyboard_current_string 
	SendMessage text = <string> 
	destroy_onscreen_keyboard 
	AssignAlias id = server_list_anchor alias = current_menu_anchor 
	AssignAlias id = actions_menu alias = current_menu 
	FireEvent Type = focus target = actions_menu 
ENDSCRIPT

SCRIPT lobby_keyboard_cancel 
	destroy_onscreen_keyboard 
	AssignAlias id = server_list_anchor alias = current_menu_anchor 
	AssignAlias id = actions_menu alias = current_menu 
	FireEvent Type = focus target = actions_menu 
ENDSCRIPT

SCRIPT create_lobby_onscreen_kb 
	IF ObjectExists id = console_message_vmenu 
		DoScreenElementMorph id = console_message_vmenu alpha = 0 
	ENDIF 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	create_onscreen_keyboard { allow_cancel 
		in_net_lobby 
		keyboard_cancel_script = cancel_keyboard 
		keyboard_done_script = enter_kb_chat_message 
		keyboard_title = "ENTER CHAT MESSAGE" 
		text = "" 
		max_length = 127 
		text_block 
		display_text_scale = 0.64999997616 
		display_text_offset = PAIR(0.00000000000, 5.00000000000) 
	} 
ENDSCRIPT

SCRIPT add_multiplayer_mode_goals 
	AddGoal_TrickAttack 
	AddGoal_ComboMambo 
	AddGoal_ScoreChallenge 
	AddGoal_Graffiti 
	AddGoal_Slap 
	AddGoal_King 
	AddGoal_Ctf 
	AddGoal_Horse_Mp 
	AddGoal_GoalAttack 
	AddGoal_FireFight 
ENDSCRIPT

SCRIPT create_score_menu 
	IF NOT ObjectExists id = net_score_menu 
		SetScreenElementLock id = root_window OFF 
		CreateScreenElement { 
			Type = ContainerElement 
			parent = root_window 
			id = net_score_menu 
			pos = PAIR(0.00000000000, 0.00000000000) 
			just = [ left top ] 
			scale = 0 
			dims = PAIR(640.00000000000, 480.00000000000) 
		} 
		CreateScreenElement { 
			Type = vmenu 
			parent = net_score_menu 
			id = net_score_vmenu 
			just = [ left top ] 
			pos = PAIR(45.00000000000, 80.00000000000) 
			scale = 0.89999997616 
			padding_scale = 1 
			internal_scale = 1 
			internal_just = [ left top ] 
		} 
		<index> = 1 
		BEGIN 
			FormatText ChecksumName = current_id "net_score_%i" i = <index> 
			CreateScreenElement { 
				Type = textElement 
				parent = net_score_vmenu 
				id = <current_id> 
				font = dialog 
				text = "" 
				scale = 0.89999997616 
				rgba = [ 128 128 128 98 ] 
				not_focusable 
				z_priority = -5 
			} 
			<index> = ( <index> + 1 ) 
		REPEAT 8 
		RunScriptOnScreenElement id = net_score_menu menu_onscreen params = { preserve_menu_state } 
	ENDIF 
ENDSCRIPT

SCRIPT clear_scores 
	IF ObjectExists id = net_score_menu 
		<index> = 1 
		BEGIN 
			FormatText ChecksumName = current_id "net_score_%i" i = <index> 
			SetScreenElementProps { 
				id = <current_id> 
				text = "" 
			} 
			<index> = ( <index> + 1 ) 
		REPEAT 8 
	ENDIF 
ENDSCRIPT

SCRIPT update_score 
	IF GetGlobalFlag flag = NO_DISPLAY_NET_SCORES 
		hide_net_scores 
	ELSE 
		IF ObjectExists id = current_menu_anchor 
			IF NOT ObjectExists id = kb_no_button_hdr 
				hide_net_scores 
			ELSE 
				unhide_net_scores 
			ENDIF 
		ELSE 
			unhide_net_scores 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT entered_network_game 
	IF InInternetMode 
		LeaveLobby preserve_status 
		SetQuietMode 
	ENDIF 
	kill_net_panel_messages 
	console_unhide 
	restore_start_key_binding 
	IF LocalSkaterExists 
		refresh_skater_model_for_cheats 
	ENDIF 
	IF OnServer 
		ClearOmnigons 
	ELSE 
		IF InInternetMode 
			CancelNatNegotiation 
		ENDIF 
		DisplayLoadingScreen Freeze 
	ENDIF 
	EnteredNetworkGame 
ENDSCRIPT

SCRIPT restart_local_server 
	SetNetworkMode 
	setservermode on 
	SetJoinMode JOIN_MODE_PLAY 
	StartServer 
	JoinServer <...> 
ENDSCRIPT

SCRIPT handle_keyboard_input 
	IF ObjectExists id = keyboard_anchor 
		IF GotParam got_enter 
			IF ScreenElementExists id = keyboard_done_button 
				FireEvent Type = pad_choose target = keyboard_done_button 
			ELSE 
				FireEvent Type = pad_choose target = keyboard_anchor 
			ENDIF 
		ELSE 
			IF GotParam got_backspace 
				keyboard_handle_backspace 
			ELSE 
				keyboard_button_pressed <...> 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT back_from_profile_options 
	FireEvent Type = unfocus target = profile_options_menu 
	DestroyScreenElement id = profile_options_anchor 
	FireEvent Type = focus target = sub_menu 
ENDSCRIPT

SCRIPT back_from_profile_error 
	printf "script back_from_profile_error" 
	dialog_box_exit 
	create_internet_options 
ENDSCRIPT

SCRIPT profile_connect 
	dialog_box_exit 
	IF NOT ProfileLogIn 
		create_internet_options 
	ENDIF 
ENDSCRIPT

SCRIPT launch_profile_menu 
	dialog_box_exit 
	IF NOT ScreenElementExists id = menu_play_online 
		create_internet_options 
	ENDIF 
	create_profile_menu 
ENDSCRIPT

SCRIPT launch_player_list_menu 
	hide_current_goal 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	IF InSplitScreenGame 
		GoalManager_HidePoints 
	ENDIF 
	FormatText ChecksumName = title_icon "%i_career_ops" i = ( THEME_PREFIXES [ current_theme_prefix ] ) 
	make_new_themed_sub_menu title = "PLAYER LIST" title_icon = <title_icon> dims = PAIR(200.00000000000, 237.00000000000) pos = PAIR(229.00000000000, 80.00000000000) right_bracket_z = 1 
	SetScreenElementProps { id = sub_menu event_handlers = [ 
			{ pad_back generic_menu_pad_back params = { callback = create_pause_menu } } 
		] 
	} 
	kill_start_key_binding 
	create_helper_text generic_helper_text 
	FillPlayerListMenu 
	theme_menu_add_item text = " " not_focusable centered 
	theme_menu_add_item text = "Done" pad_choose_script = create_pause_menu centered last_menu_item = last_menu_item 
	finish_themed_sub_menu 
ENDSCRIPT

SCRIPT update_buddy_status 
	IF ObjectExists id = <id> 
		SetScreenElementProps { 
			id = <id> 
			text = <text> 
			status = <status> 
			location = <location> 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT cancel_face_download 
	destroy_onscreen_keyboard 
	create_internet_options 
ENDSCRIPT

SCRIPT face_download_chosen cancel_script = cancel_face_download 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	GetPreferenceString pref_type = network face_dl_key 
	create_onscreen_keyboard { allow_cancel 
		keyboard_cancel_script = <cancel_script> 
		keyboard_done_script = launch_face_download 
		keyboard_title = "ENTER PASSWORD" 
		text = <ui_string> 
		max_length = 50 
	} 
	FormatText ChecksumName = rgba "%i_UNHIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	FormatText ChecksumName = highlight_rgba "%i_HIGHLIGHTED_TEXT_COLOR" i = ( THEME_COLOR_PREFIXES [ current_theme_prefix ] ) 
	IF NOT GotParam no_help_box 
		CreateScreenElement { 
			Type = textBlockElement 
			parent = current_menu_anchor 
			id = directions_text 
			text = "Enter the password that was e-mailed\\nto you after submitting your picture." 
			pos = PAIR(320.00000000000, 668.00000000000) 
			dims = PAIR(640.00000000000, 60.00000000000) 
			font = small 
			scale = 0.89999997616 
			rgba = <rgba> 
			line_spacing = 0.64999997616 
			z_priority = 5 
			just = [ center center ] 
		} 
		CreateScreenElement { 
			Type = SpriteElement 
			parent = current_menu_anchor 
			id = directions_box 
			texture = myf_box_mid 
			pos = PAIR(320.00000000000, 670.00000000000) 
			scale = PAIR(12.00000000000, 1.20000004768) 
			just = [ center center ] 
			rgba = <highlight_rgba> 
			z_priority = 5 
		} 
		DoScreenElementMorph id = directions_text time = 0.20000000298 pos = PAIR(320.00000000000, 368.00000000000) 
		DoScreenElementMorph id = directions_box time = 0.20000000298 pos = PAIR(320.00000000000, 370.00000000000) 
	ENDIF 
ENDSCRIPT

SCRIPT face_dnas_warning 
	dialog_box_exit 
	body = "Before you can download your face, you will need to select THUG Online Play\\n from the Main Menu\\nand authenticate your internet connection." 
	IF ObjectExists id = current_menu 
		FireEvent Type = unfocus target = current_menu 
	ENDIF 
	IF levelIs load_cas 
		create_dialog_box { title = "Warning!" 
			text = <body> 
			text_dims = PAIR(350.00000000000, 0.00000000000) 
			pos = PAIR(320.00000000000, 240.00000000000) 
			just = [ center center ] 
			text_rgba = [ 88 105 112 128 ] 
			no_bg = no_bg 
			buttons = [ { font = small text = "Continue Without Downloading" pad_choose_script = cont_wo_dl_face_dnas } 
				{ font = small text = "Return to Main Menu" pad_choose_script = goto_thug_online_face_dnas } 
			] 
		} 
	ELSE 
		create_dialog_box { title = "Attention!" 
			text = <body> 
			text_dims = PAIR(350.00000000000, 0.00000000000) 
			pos = PAIR(320.00000000000, 240.00000000000) 
			just = [ center center ] 
			text_rgba = [ 88 105 112 128 ] 
			no_bg = no_bg 
			buttons = [ { font = small text = "Ok" pad_choose_script = ok_face_dnas } 
			] 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT goto_thug_online_face_dnas 
	change in_cinematic_sequence = 0 
	change entered_cas_from_main = 0 
	dialog_box_exit 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	load_cas_textures_to_main_memory unload 
	change_level level = Load_skateshop 
ENDSCRIPT

SCRIPT cont_wo_dl_face_dnas 
	dialog_box_exit 
	create_pre_cas_menu 
ENDSCRIPT

SCRIPT ok_face_dnas 
	dialog_box_exit 
	create_main_menu 
ENDSCRIPT

SCRIPT launch_face_download 
	GetTextElementString id = keyboard_current_string 
	IF ObjectExists id = current_menu_anchor 
		DestroyScreenElement id = current_menu_anchor 
	ENDIF 
	select_skater_get_current_skater_name 
	IF NOT ( <current_skater> = custom ) 
		load_pro_skater { profile = 0 skater = 0 Name = custom } 
	ENDIF 
	set_preferences_from_ui prefs = network field = "face_dl_key" <...> 
	printf "Downloading face" 
	create_dialog_box { title = "Downloading Face" text = "Checking for file..." no_animate } 
	DownloadFace <...> 
ENDSCRIPT

SCRIPT LaunchFaceDownloadCompleteDialog 
	dialog_box_exit 
	net_vault_menu_exit 
	create_dialog_box { title = "Download Complete" 
		text = "Press OK to go map your face." 
		buttons = [ { text = "OK" pad_choose_script = back_from_face_transfer_succeeded_dialog } 
		] 
	} 
ENDSCRIPT

SCRIPT download_content 
	printf "retrieving directory listing" 
	DestroyScreenElement id = current_menu_anchor 
	create_dialog_box { title = net_status_msg 
		text = "Retrieving directory listing..." 
		no_animate 
	} 
	DownloadDirectoryList <Type> 
ENDSCRIPT

SCRIPT download_selected_file 
	printf "Downloading content" 
	GetTags 
	GetTextElementString id = { <id> child = 0 } 
	SetScriptString string = <string> 
	DestroyScreenElement id = current_menu_anchor 
	create_dialog_box { title = "Downloading File" 
		text = "" 
		no_animate 
	} 
	DownloadFile <...> 
ENDSCRIPT

SCRIPT update_transfer_progress 
	IF ObjectExists id = dialog_box_text 
		SetScreenElementProps { 
			id = dialog_box_text 
			text = <text> 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT back_from_transfer_dialog 
	IF GameModeEquals is_net 
		dialog_box_exit 
		create_internet_options 
	ELSE 
		face_back_from_net_setup 
	ENDIF 
ENDSCRIPT

SCRIPT back_from_transfer_succeeded_dialog 
	dialog_box_exit 
	memcard_menus_cleanup 
	create_internet_options 
	change savevaultdata = 0 
ENDSCRIPT

SCRIPT LaunchFileNotFoundDialog 
	net_vault_menu_exit 
	dialog_box_exit 
	create_dialog_box { title = "File Not Found" 
		text = "Please verify that you have entered your key correctly and make sure that you have successfully emailed your face to: faces@thugonline.com." 
		buttons = [ { text = "ok" pad_choose_script = back_from_transfer_dialog } 
		] 
	} 
ENDSCRIPT

SCRIPT LaunchGeneralFileNotFoundDialog 
	net_vault_menu_exit 
	dialog_box_exit 
	create_dialog_box { title = "Server Error" 
		text = "Could not download the selected file. The server may be down. Please try again later." 
		buttons = [ { text = "ok" pad_choose_script = back_from_transfer_dialog } 
		] 
	} 
ENDSCRIPT

SCRIPT LaunchTransferFailedDialog 
	net_vault_menu_exit 
	dialog_box_exit 
	create_dialog_box { title = "Transfer Failed" 
		text = "Please check your network cables." 
		buttons = [ { text = "ok" pad_choose_script = back_from_transfer_dialog } 
		] 
	} 
ENDSCRIPT

SCRIPT LaunchDownloadCompleteDialog 
	printf "script LaunchDownloadCompleteDialog" 
	net_vault_menu_exit 
	dialog_box_exit 
	PrintStruct <...> 
	IF GotParam Type 
		SWITCH <Type> 
			CASE parks 
				text = "Save downloaded park?" 
				file_type = park 
			CASE goals 
				text = "Save downloaded goals?" 
				file_type = createdgoals 
			CASE skaters 
				text = "Save downloaded skater?" 
				file_type = optionsandpros 
			CASE tricks 
				text = "Save downloaded trick?" 
				file_type = cat 
			DEFAULT 
				printf "save download: invalid type" 
				RETURN 
		ENDSWITCH 
	ELSE 
		printf "save download: missing type" 
		RETURN 
	ENDIF 
	create_dialog_box { title = "Download Complete" 
		text = <text> 
		buttons = [ { text = "Yes" pad_choose_script = launch_download_save_sequence pad_choose_params = { file_type = <file_type> } } 
			{ text = "No" pad_choose_script = back_from_transfer_succeeded_dialog } 
		] 
	} 
ENDSCRIPT

SCRIPT back_from_face_transfer_succeeded_dialog 
	dialog_box_exit 
	IF GameModeEquals is_net 
		SpawnSecondControllerCheck 
		StatsLogOff 
		ProfileLogOff 
		Wait 1 gameframe 
		IF ScreenElementExists id = current_menu_anchor 
			DestroyScreenElement id = current_menu_anchor 
		ENDIF 
		launch_cas { face2 downloaded_face = downloaded_face } 
	ELSE 
		face_back_from_net_setup 
	ENDIF 
ENDSCRIPT

SCRIPT StartFreeSkate 
	MakeSkaterGosub add_skater_to_world skater = 0 
	MakeSkaterGosub add_skater_to_world skater = 1 
	SetGameType freeskate2p 
	SetCurrentGameType 
	SetScreenModeFromGameMode 
ENDSCRIPT

SCRIPT kill_all_panel_messages 
	exit_pause_menu 
	dialog_box_exit anchor_id = quit_dialog_anchor 
	dialog_box_exit 
	speech_box_exit 
	force_close_rankings 
	close_goals_menu 
	kill_net_panel_messages 
	destroy_onscreen_keyboard 
	IF ObjectExists id = perfect 
		DestroyScreenElement id = perfect 
	ENDIF 
	IF ObjectExists id = perfect2 
		DestroyScreenElement id = perfect2 
	ENDIF 
	IF ObjectExists id = death_message 
		DestroyScreenElement id = death_message 
	ENDIF 
	IF ObjectExists id = leaving_message 
		DestroyScreenElement id = leaving_message 
	ENDIF 
	IF ObjectExists id = goal_message 
		DestroyScreenElement id = goal_message 
	ENDIF 
ENDSCRIPT

SCRIPT StartingNewNetGame 
	sound_options_exit just_remove 
	edit_tricks_menu_exit just_remove 
	kill_all_panel_messages 
	IF NOT IsObserving 
		skater : RunStarted 
	ENDIF 
	ClearPowerups 
	IF NOT IsObserving 
		ExitSurveyorMode 
	ENDIF 
ENDSCRIPT

SCRIPT unlock_root_window 
	SetScreenElementLock id = root_window OFF 
ENDSCRIPT

SCRIPT create_object_label 
	SetScreenElementLock id = root_window OFF 
	CreateScreenElement { 
		id = <id> 
		Type = textElement 
		parent = root_window 
		font = small 
		text = "" 
		scale = 1.00000000000 
		pos3D = VECTOR(0.00000000000, 0.00000000000, 0.00000000000) 
		rgba = [ 128 128 0 128 ] 
	} 
ENDSCRIPT

SCRIPT update_object_label 
	IF NOT ObjectExists id = <id> 
		create_object_label <...> 
	ENDIF 
	SetScreenElementProps { 
		id = <id> 
		text = <text> 
		pos3D = <pos3D> 
	} 
ENDSCRIPT

SCRIPT destroy_object_label 
	IF ObjectExists id = <id> 
		DestroyScreenElement id = <id> 
	ENDIF 
ENDSCRIPT

SCRIPT destroy_all_player_names 
	IF ObjectExists id = skater_name_0 
		DestroyScreenElement id = skater_name_0 
	ENDIF 
	IF ObjectExists id = skater_name_1 
		DestroyScreenElement id = skater_name_1 
	ENDIF 
	IF ObjectExists id = skater_name_2 
		DestroyScreenElement id = skater_name_2 
	ENDIF 
	IF ObjectExists id = skater_name_3 
		DestroyScreenElement id = skater_name_3 
	ENDIF 
	IF ObjectExists id = skater_name_4 
		DestroyScreenElement id = skater_name_4 
	ENDIF 
	IF ObjectExists id = skater_name_5 
		DestroyScreenElement id = skater_name_5 
	ENDIF 
	IF ObjectExists id = skater_name_6 
		DestroyScreenElement id = skater_name_6 
	ENDIF 
	IF ObjectExists id = skater_name_7 
		DestroyScreenElement id = skater_name_7 
	ENDIF 
ENDSCRIPT

SCRIPT hide_all_player_names 
	IF ObjectExists id = skater_name_0 
		DoScreenElementMorph id = skater_name_0 scale = 0 
	ENDIF 
	IF ObjectExists id = skater_name_1 
		DoScreenElementMorph id = skater_name_1 scale = 0 
	ENDIF 
	IF ObjectExists id = skater_name_2 
		DoScreenElementMorph id = skater_name_2 scale = 0 
	ENDIF 
	IF ObjectExists id = skater_name_3 
		DoScreenElementMorph id = skater_name_3 scale = 0 
	ENDIF 
	IF ObjectExists id = skater_name_4 
		DoScreenElementMorph id = skater_name_4 scale = 0 
	ENDIF 
	IF ObjectExists id = skater_name_5 
		DoScreenElementMorph id = skater_name_5 scale = 0 
	ENDIF 
	IF ObjectExists id = skater_name_6 
		DoScreenElementMorph id = skater_name_6 scale = 0 
	ENDIF 
	IF ObjectExists id = skater_name_7 
		DoScreenElementMorph id = skater_name_7 scale = 0 
	ENDIF 
ENDSCRIPT

SCRIPT unhide_all_player_names 
	IF ObjectExists id = skater_name_0 
		DoScreenElementMorph id = skater_name_0 scale = 1 
	ENDIF 
	IF ObjectExists id = skater_name_1 
		DoScreenElementMorph id = skater_name_1 scale = 1 
	ENDIF 
	IF ObjectExists id = skater_name_2 
		DoScreenElementMorph id = skater_name_2 scale = 1 
	ENDIF 
	IF ObjectExists id = skater_name_3 
		DoScreenElementMorph id = skater_name_3 scale = 1 
	ENDIF 
	IF ObjectExists id = skater_name_4 
		DoScreenElementMorph id = skater_name_4 scale = 1 
	ENDIF 
	IF ObjectExists id = skater_name_5 
		DoScreenElementMorph id = skater_name_5 scale = 1 
	ENDIF 
	IF ObjectExists id = skater_name_6 
		DoScreenElementMorph id = skater_name_6 scale = 1 
	ENDIF 
	IF ObjectExists id = skater_name_7 
		DoScreenElementMorph id = skater_name_7 scale = 1 
	ENDIF 
ENDSCRIPT

SCRIPT create_net_metrics 
	SetScreenElementLock id = root_window OFF 
	CreateScreenElement { 
		id = net_metrics 
		Type = textElement 
		parent = root_window 
		font = small 
		text = "" 
		scale = 1.00000000000 
		pos = PAIR(150.00000000000, 400.00000000000) 
		rgba = [ 128 128 0 128 ] 
	} 
ENDSCRIPT

SCRIPT update_net_metrics 
	IF NOT ObjectExists id = net_metrics 
		create_net_metrics 
	ENDIF 
	SetScreenElementProps { 
		id = net_metrics 
		text = <text> 
	} 
ENDSCRIPT

SCRIPT notify_cheating 
	create_net_panel_message msg_time = 6000 text = net_message_server_cheating 
ENDSCRIPT

SCRIPT notify_client_cheating 
	FormatText TextName = msg_text "Player %s is cheating!" s = <String0> 
	create_net_panel_message msg_time = 6000 text = "At least one player is cheating!" style = net_team_panel_message 
ENDSCRIPT

SCRIPT warn_all_same_team 
	create_panel_message id = goal_message text = "Warning: All players are on the same team" style = panel_message_generic_loss time = 5000 
ENDSCRIPT

SCRIPT test_particle_script 
	printf "In Test Particle Script" 
ENDSCRIPT

judge_full_name = "Judge" 
