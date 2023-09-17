
SCRIPT NewScoreLeaderYou 
	IF InNetGame 
		create_net_panel_message text = "You have taken the lead!" style = net_team_panel_message 
	ENDIF 
ENDSCRIPT

SCRIPT NewScoreLeaderOther 
	IF InNetGame 
		FormatText TextName = msg_text "%s has taken the lead!" s = <String0> 
		create_net_panel_message text = <msg_text> style = net_team_panel_message 
	ENDIF 
ENDSCRIPT

SCRIPT NewKingYou 
	IF InNetGame 
		create_net_panel_message text = net_message_new_king_you style = net_team_panel_message 
	ELSE 
		PlaySound HUD_specialtrickAA Vol = 100 
	ENDIF 
ENDSCRIPT

SCRIPT NewKingOther 
	IF InNetGame 
		FormatText TextName = msg_text "%s is king of the hill!" s = <String0> 
		create_net_panel_message text = <msg_text> style = net_team_panel_message 
	ELSE 
		PlaySound HUD_specialtrickAA Vol = 100 
	ENDIF 
ENDSCRIPT

SCRIPT NewScoreLeaderYourTeam 
	IF InNetGame 
		create_net_panel_message text = "Your team has taken the lead!" style = net_team_panel_message 
	ENDIF 
ENDSCRIPT

SCRIPT NewScoreLeaderOtherTeam 
	IF InNetGame 
		FormatText TextName = msg_text "Team %s has taken the lead!" s = <String0> 
		create_net_panel_message text = <msg_text> style = net_team_panel_message 
	ENDIF 
ENDSCRIPT

SCRIPT timer_runout_beep 
	PlaySound TimeoutA Vol = 75 pitch = 110 
ENDSCRIPT

SCRIPT GraffitiStealYou 
	IF InNetGame 
		FormatText TextName = msg_text "You stole from %s!" s = <String0> 
		create_net_panel_message text = <msg_text> style = net_team_panel_message 
	ENDIF 
ENDSCRIPT

SCRIPT GraffitiStealOther 
	IF InNetGame 
		FormatText TextName = msg_text "%s stole from you!" s = <String0> 
		create_net_panel_message text = <msg_text> style = net_team_panel_message 
	ENDIF 
ENDSCRIPT

SCRIPT SkaterCollideBail 
	SparksOff 
	StopBalanceTrick 
	InBail 
	PlaySound HUDtrickslopC 
	IF InNetGame 
		IF NOT GameModeEquals is_ctf 
			IF NOT GotParam WinnerIsDriving 
				FormatText TextName = msg_text s = <String0> RANDOM(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1) 
					RANDOMCASE "You got smacked by %s" 
					RANDOMCASE "%s just laid the smack down on you" 
					RANDOMCASE "Brought to you by %s" 
					RANDOMCASE "%s gets his revenge" 
					RANDOMCASE "%s shows you to the kiddie park " 
					RANDOMCASE "%s kicked you in the junk" 
					RANDOMCASE "Might want to clean %s\'s shoe prints off your face" 
					RANDOMCASE "Are you gonna let %s get away with that?" 
					RANDOMCASE "%s grinds your face" 
					RANDOMCASE "%s escorts you to the floor" 
					RANDOMCASE "You got worked by %s" 
					RANDOMCASE "Today\'s beat-down, courtesy of %s" 
					RANDOMCASE "%s offers you lovely parting gifts" 
					RANDOMCASE "%s makes an example of you" 
					RANDOMCASE "%s didn\'t really mean to do that" 
					RANDOMCASE "%s let you have it" 
					RANDOMCASE "%s adds insult to injury" 
					RANDOMCASE "%s brought the pain" 
					RANDOMCASE "%s levels you" 
					RANDOMCASE "%s knocks some sense into you" 
					RANDOMCASE "You have been shown the door by %s" 
					RANDOMCASE "%s schooled you" 
					RANDOMCASE "Chalk another one up for %s" 
					RANDOMCASE "%s brutalized you" 
					RANDOMCASE "%s is never soft" 
					RANDOMCASE "%s just kicked your nads" 
					RANDOMCASE "This smack brought to you by %s and the friendly people at Neversoft" 
					RANDOMCASE "You were OWN3D by %s" 
				RANDOMEND 
			ELSE 
				FormatText TextName = msg_text s = <String0> RANDOM(1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1) 
					RANDOMCASE "You got run over by %s" 
					RANDOMCASE "You got squashed by %s" 
					RANDOMCASE "You got flattened by %s" 
					RANDOMCASE "You got smushed by %s" 
					RANDOMCASE "%s turned you into road kill" 
					RANDOMCASE "You\'re making %s\'s tires all sticky" 
					RANDOMCASE "%s squashed you like squirrel" 
					RANDOMCASE "%s peeled out on your forehead" 
					RANDOMCASE "You\'re wearing %s\'s windshield" 
					RANDOMCASE "%s might need some body work, but you need a new body" 
					RANDOMCASE "%s put you over the hood" 
				RANDOMEND 
			ENDIF 
			create_net_panel_message text = <msg_text> style = net_team_panel_message_long 
		ENDIF 
	ENDIF 
	IF InSlapGame 
		BailSkaterTricks 
		MoveToRandomRestart 
	ENDIF 
	IF NOT Walking 
		goto NoseManualBail 
	ELSE 
		goto WalkBailState 
	ENDIF 
ENDSCRIPT

SCRIPT Bail_FireFight_SkaterCollideBail 
	IF GotParam FireBall 
		goto SkaterCollideBail Params = { String0 = <String0> } 
	ENDIF 
ENDSCRIPT

SCRIPT ReportDrivingCollisionLost 
	IF InNetGame 
		IF NOT GameModeEquals is_ctf 
			FormatText TextName = msg_text s = <String0> RANDOM(4, 1, 1, 1, 1) 
				RANDOMCASE "You got rammed by %s" 
				RANDOMCASE "Who gave %s a licence?" 
				RANDOMCASE "%s has some serious road rage issues" 
				RANDOMCASE "%s shouldn\'t drink and drive" 
				RANDOMCASE "%s\'s insurance just went up" 
			RANDOMEND 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT MadeOtherSkaterBail 
	IF InNetGame 
		IF NOT GameModeEquals is_ctf 
			IF GotParam FireBall 
				FormatText TextName = msg_text s = <String0> RANDOM(4, 1) 
					RANDOMCASE "\\c2You just flamed %s" 
					RANDOMCASE "\\c2%s got roasted" 
				RANDOMEND 
			ELSE 
				FormatText TextName = msg_text s = <String0> RANDOM(4, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1) 
					RANDOMCASE "You smacked %s" 
					RANDOMCASE "You punked %s" 
					RANDOMCASE "You shanked %s" 
					RANDOMCASE "You just K.O.\'d %s" 
					RANDOMCASE "You read %s his last rights" 
					RANDOMCASE "You dropped %s like a bad habit" 
					RANDOMCASE "You made %s lick the floor" 
					RANDOMCASE "You are %s\'s daddy" 
					RANDOMCASE "%s got a taste of j00r 1337 $xi11z" 
					RANDOMCASE "%s is a n00b" 
					RANDOMCASE "%s just ran cryin\' to mommy" 
					RANDOMCASE "%s doesn\'t like to play that rough" 
					RANDOMCASE "You just opened %s\'s eyes to a whole new world" 
				RANDOMEND 
			ENDIF 
			create_net_panel_message text = <msg_text> style = net_team_panel_message_long 
		ENDIF 
	ENDIF 
	OnGroundExceptions NoEndRun 
	SetQueueTricks Jumptricks 
	IF NOT GotParam FireBall 
		SetTrickName "Head Smack" 
		SetTrickScore 2000 
		Display Blockspin 
		PlayAnim Anim = SlapRight Blendperiod = 0.30000001192 
		Obj_PlaySound BailSlap03 
		WaitAnimWhilstChecking AndManuals 
		LandSkaterTricks 
	ENDIF 
	goto OnGroundAi 
ENDSCRIPT

SCRIPT MadeOtherSkaterBailAir 
	IF NOT GotParam FireBall 
		SetTrickName "Head Smack" 
		SetTrickScore 2000 
		Display Blockspin 
	ENDIF 
	IF InNetGame 
		IF NOT GameModeEquals is_ctf 
			IF NOT GotParam FireBall 
				FormatText TextName = msg_text "Airborne face smack to %s!" s = <String0> 
			ELSE 
				FormatText TextName = msg_text s = <String0> RANDOM(4, 1) 
					RANDOMCASE "\\c2You just flamed %s" 
					RANDOMCASE "\\c2%s got roasted" 
				RANDOMEND 
			ENDIF 
			create_net_panel_message text = <msg_text> style = net_team_panel_message 
		ENDIF 
	ENDIF 
	IF NOT GotParam FireBall 
		IF doingtrick 
		ELSE 
			InAirExceptions 
			PlayAnim Anim = SlapAir Blendperiod = 0.30000001192 
			PlaySound BailSlap03 
			WaitAnimWhilstChecking 
			goto Airborne 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT MadeOtherSkaterBail_Called 
	IF NOT GotParam FireBall 
		SetTrickName "Head Smack" 
		SetTrickScore 2000 
		Display Blockspin 
	ENDIF 
	IF InNetGame 
		IF NOT GameModeEquals is_ctf 
			IF NOT GotParam FireBall 
				FormatText TextName = msg_text "Face smack to %s!" s = <String0> 
			ELSE 
				FormatText TextName = msg_text s = <String0> RANDOM(4, 1) 
					RANDOMCASE "\\c2You just flamed %s" 
					RANDOMCASE "\\c2%s got roasted" 
				RANDOMEND 
			ENDIF 
			create_net_panel_message text = <msg_text> style = net_team_panel_message 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT MadeOtherSkaterBailWalk 
	IF NOT GotParam FireBall 
		IF Skater : CurrentScorePotLessThan 1 
			LandStraightAway = 1 
		ENDIF 
		SetTrickName "Sucker Punch" 
		SetTrickScore 2000 
		Display Blockspin 
		IF GotParam LandStraightAway 
			LandSkaterTricks 
		ENDIF 
	ENDIF 
	IF InNetGame 
		IF NOT GameModeEquals is_ctf 
			IF NOT GotParam FireBall 
				FormatText TextName = msg_text "You sucker punched %s!" s = <String0> 
			ELSE 
				FormatText TextName = msg_text s = <String0> RANDOM(4, 1) 
					RANDOMCASE "\\c2You just flamed %s" 
					RANDOMCASE "\\c2%s got roasted" 
				RANDOMEND 
			ENDIF 
			create_net_panel_message text = <msg_text> style = net_team_panel_message 
		ENDIF 
	ELSE 
	ENDIF 
	IF NOT GotParam FireBall 
		IF Walk_Ground 
			goto GroundPunchState 
		ELSE 
			IF Walk_Air 
				goto AirPunchState 
			ENDIF 
		ENDIF 
	ELSE 
		goto GroundOrAirWaitState 
	ENDIF 
ENDSCRIPT

SCRIPT MadeOtherSkaterBailCar 
	IF NOT GotParam LoserIsDriving 
		SetTrickName "Road Kill" 
	ELSE 
		SetTrickName "Hit and Run" 
	ENDIF 
	SetTrickScore 2000 
	Display 
	LandSkaterTricks 
	IF InNetGame 
		IF NOT GameModeEquals is_ctf 
			IF NOT GotParam LoserIsDriving 
				FormatText TextName = msg_text s = <String0> RANDOM(2, 2, 1, 1, 1, 1, 1, 1, 1, 1, 1) 
					RANDOMCASE "You ran %s down" 
					RANDOMCASE "You flattened %s" 
					RANDOMCASE "You mauled %s" 
					RANDOMCASE "Mmmmm...  %s pancakes" 
					RANDOMCASE "%s is a victim of vehicular homicide" 
					RANDOMCASE "So sad...  %s is now just a statistic" 
					RANDOMCASE "You just peeled out on %s\'s forehead" 
					RANDOMCASE "%s is wearin\' your windshield" 
					RANDOMCASE "That speed bumb was %s" 
					RANDOMCASE "%s forgot to look both ways" 
					RANDOMCASE "%s forgot you had the car" 
				RANDOMEND 
			ELSE 
				FormatText TextName = msg_text s = <String0> RANDOM(2, 2, 1, 1, 1, 1, 1, 1) 
					RANDOMCASE "You hit %s" 
					RANDOMCASE "You rammed %s" 
					RANDOMCASE "You ran %s down" 
					RANDOMCASE "You smashed %s" 
					RANDOMCASE "You sent %s to the body shop" 
					RANDOMCASE "Hope %s\'s got airbags" 
					RANDOMCASE "%s was just a victim of your road rage" 
					RANDOMCASE "%s just put more points on your license" 
				RANDOMEND 
			ENDIF 
			create_net_panel_message text = <msg_text> style = net_team_panel_message 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT NetIdle 
	IF ShouldMongo 
		Obj_PlayAnim Anim = MongoBrakeIdle Blendperiod = 0.00000000000 Cycle NoRestart 
	ELSE 
		Obj_PlayAnim Anim = NewBrakeIdle Blendperiod = 0.00000000000 Cycle NoRestart 
	ENDIF 
ENDSCRIPT

SCRIPT ChooseTeamMessage 
	create_net_panel_message text = "Teams have been created. Choose a team by grabbing its flag." style = generic_net_panel_message 
ENDSCRIPT

SCRIPT server_enter_free_skate 
	IF InTeamGame 
		create_net_panel_message text = "Choose a team by grabbing a flag. Press \\b8 to Begin Game." style = generic_net_panel_message 
	ELSE 
		create_net_panel_message text = "Entering Free Skate. Press \\b8 to Begin Game." style = generic_net_panel_message 
	ENDIF 
	IF OnServer 
		LoadPendingPlayers 
	ENDIF 
ENDSCRIPT

SCRIPT client_enter_free_skate 
	IF InTeamGame 
		create_net_panel_message text = "Choose a team by grabbing a flag." style = generic_net_panel_message 
	ELSE 
		create_net_panel_message text = "Entering Free Skate." style = generic_net_panel_message 
	ENDIF 
ENDSCRIPT

netmessageprops = { 
	font = "small.fnt" 
	just = PAIR(0.00000000000, 0.00000000000) 
	dims = PAIR(600.00000000000, 112.00000000000) 
	colors = [ 
		{ VECTOR(50.00000000000, 80.00000000000, 128.00000000000) alpha = 128 } 
		{ VECTOR(128.00000000000, 128.00000000000, 128.00000000000) alpha = 75 } 
		{ VECTOR(110.00000000000, 50.00000000000, 50.00000000000) alpha = 75 } 
		{ VECTOR(180.00000000000, 160.00000000000, 0.00000000000) alpha = 75 } 
	] 
	key_points = [ 
		{ pos = PAIR(320.00000000000, 250.00000000000) alpha = 0 scale = 0.20000000298 time = 0 } 
		{ alpha = 128 scale = 1.00999999046 time = 0.09000000358 } 
		{ alpha = 128 scale = 1.00999999046 time = 5 } 
		{ alpha = 0 scale = 0.20000000298 time = 5.09000015259 } 
	] 
} 
netstatusprops = { 
	font = "small.fnt" 
	just = PAIR(0.00000000000, 0.00000000000) 
	dims = PAIR(600.00000000000, 112.00000000000) 
	colors = [ 
		{ VECTOR(128.00000000000, 128.00000000000, 128.00000000000) alpha = 128 } 
		{ VECTOR(50.00000000000, 80.00000000000, 128.00000000000) alpha = 75 } 
		{ VECTOR(110.00000000000, 50.00000000000, 50.00000000000) alpha = 75 } 
		{ VECTOR(180.00000000000, 160.00000000000, 0.00000000000) alpha = 75 } 
	] 
	key_points = [ 
		{ pos = PAIR(320.00000000000, 285.00000000000) alpha = 0 scale = 0.20000000298 time = 0 } 
		{ alpha = 128 scale = 1.00999999046 time = 0.09000000358 } 
		{ alpha = 128 scale = 1.00999999046 time = 5 } 
		{ alpha = 0 scale = 0.20000000298 time = 5.09000015259 } 
	] 
} 
netexceptionprops = { 
	font = "small.fnt" 
	just = PAIR(0.00000000000, 0.00000000000) 
	dims = PAIR(600.00000000000, 112.00000000000) 
	colors = [ 
		{ VECTOR(128.00000000000, 128.00000000000, 128.00000000000) alpha = 128 } 
		{ VECTOR(50.00000000000, 80.00000000000, 128.00000000000) alpha = 75 } 
		{ VECTOR(110.00000000000, 50.00000000000, 50.00000000000) alpha = 75 } 
		{ VECTOR(180.00000000000, 160.00000000000, 0.00000000000) alpha = 75 } 
	] 
	key_points = [ 
		{ pos = PAIR(320.00000000000, 305.00000000000) alpha = 0 scale = 0.20000000298 time = 0 } 
		{ alpha = 128 scale = 1.00999999046 time = 0.09000000358 } 
		{ alpha = 128 scale = 1.00999999046 time = 5 } 
		{ alpha = 0 scale = 0.20000000298 time = 5.09000015259 } 
	] 
} 
chat1props = { 
	font = "small.fnt" 
	just = PAIR(0.00000000000, 0.00000000000) 
	dims = PAIR(600.00000000000, 112.00000000000) 
	colors = [ 
		{ VECTOR(50.00000000000, 80.00000000000, 128.00000000000) alpha = 128 } 
		{ VECTOR(180.00000000000, 160.00000000000, 0.00000000000) alpha = 75 } 
		{ VECTOR(110.00000000000, 50.00000000000, 50.00000000000) alpha = 75 } 
		{ VECTOR(128.00000000000, 128.00000000000, 128.00000000000) alpha = 75 } 
	] 
	key_points = [ 
		{ pos = PAIR(320.00000000000, 150.00000000000) alpha = 0 scale = 0.20000000298 time = 0 } 
		{ alpha = 128 scale = 1.00999999046 time = 0.09000000358 } 
		{ alpha = 128 scale = 1.00999999046 time = 5 } 
		{ alpha = 0 scale = 0.20000000298 time = 5.09000015259 } 
	] 
} 
chat2props = { 
	font = "small.fnt" 
	just = PAIR(0.00000000000, 0.00000000000) 
	dims = PAIR(600.00000000000, 112.00000000000) 
	colors = [ 
		{ VECTOR(50.00000000000, 80.00000000000, 128.00000000000) alpha = 128 } 
		{ VECTOR(180.00000000000, 160.00000000000, 0.00000000000) alpha = 75 } 
		{ VECTOR(110.00000000000, 50.00000000000, 50.00000000000) alpha = 75 } 
		{ VECTOR(128.00000000000, 128.00000000000, 128.00000000000) alpha = 75 } 
	] 
	key_points = [ 
		{ pos = PAIR(320.00000000000, 170.00000000000) alpha = 0 scale = 0.20000000298 time = 0 } 
		{ alpha = 128 scale = 1.00999999046 time = 0.09000000358 } 
		{ alpha = 128 scale = 1.00999999046 time = 5 } 
		{ alpha = 0 scale = 0.20000000298 time = 5.09000015259 } 
	] 
} 
chat3props = { 
	font = "small.fnt" 
	just = PAIR(0.00000000000, 0.00000000000) 
	dims = PAIR(600.00000000000, 112.00000000000) 
	colors = [ 
		{ VECTOR(50.00000000000, 80.00000000000, 128.00000000000) alpha = 128 } 
		{ VECTOR(180.00000000000, 160.00000000000, 0.00000000000) alpha = 75 } 
		{ VECTOR(110.00000000000, 50.00000000000, 50.00000000000) alpha = 75 } 
		{ VECTOR(128.00000000000, 128.00000000000, 128.00000000000) alpha = 75 } 
	] 
	key_points = [ 
		{ pos = PAIR(320.00000000000, 190.00000000000) alpha = 0 scale = 0.20000000298 time = 0 } 
		{ alpha = 128 scale = 1.00999999046 time = 0.09000000358 } 
		{ alpha = 128 scale = 1.00999999046 time = 5 } 
		{ alpha = 0 scale = 0.20000000298 time = 5.09000015259 } 
	] 
} 
chat4props = { 
	font = "small.fnt" 
	just = PAIR(0.00000000000, 0.00000000000) 
	dims = PAIR(600.00000000000, 112.00000000000) 
	colors = [ 
		{ VECTOR(50.00000000000, 80.00000000000, 128.00000000000) alpha = 128 } 
		{ VECTOR(180.00000000000, 160.00000000000, 0.00000000000) alpha = 75 } 
		{ VECTOR(110.00000000000, 50.00000000000, 50.00000000000) alpha = 75 } 
		{ VECTOR(128.00000000000, 128.00000000000, 128.00000000000) alpha = 75 } 
	] 
	key_points = [ 
		{ pos = PAIR(320.00000000000, 210.00000000000) alpha = 0 scale = 0.20000000298 time = 0 } 
		{ alpha = 128 scale = 1.00999999046 time = 0.09000000358 } 
		{ alpha = 128 scale = 1.00999999046 time = 5 } 
		{ alpha = 0 scale = 0.20000000298 time = 5.09000015259 } 
	] 
} 
chat5props = { 
	font = "small.fnt" 
	just = PAIR(0.00000000000, 0.00000000000) 
	dims = PAIR(600.00000000000, 112.00000000000) 
	colors = [ 
		{ VECTOR(50.00000000000, 80.00000000000, 128.00000000000) alpha = 128 } 
		{ VECTOR(180.00000000000, 160.00000000000, 0.00000000000) alpha = 75 } 
		{ VECTOR(110.00000000000, 50.00000000000, 50.00000000000) alpha = 75 } 
		{ VECTOR(128.00000000000, 128.00000000000, 128.00000000000) alpha = 75 } 
	] 
	key_points = [ 
		{ pos = PAIR(320.00000000000, 230.00000000000) alpha = 0 scale = 0.20000000298 time = 0 } 
		{ alpha = 128 scale = 1.00999999046 time = 0.09000000358 } 
		{ alpha = 128 scale = 1.00999999046 time = 5 } 
		{ alpha = 0 scale = 0.20000000298 time = 5.09000015259 } 
	] 
} 
net_error_msg = "Error" 
net_notice_msg = #"Notice" 
net_status_msg = "Status" 
net_refused_msg = "Refused" 
net_warning_msg = "Warning" 
net_error_not_connected = "Your network device is not properly connected to the network. Check your cables or contact your network administrator." 
net_error_not_detected = "Could not detect any compatible network devices. Check your connections. See the THUG manual for troubleshooting." 
net_error_dhcp_error = "Could not automatically detect network settings. Check connections and DHCP server or choose a static IP." 
net_error_changed_device = "You have changed network device settings and must restart your console for this change to take effect." 
net_error_device_error = "Could not detect your network device.  Check or reinstall your network settings." 
net_error_general_error = "Your network device is not configured properly or may not be properly connected. See the THUG manual for troubleshooting." 
net_error_cant_change_device = "You must restart your console before changing this option." 
net_error_cant_load_settings = "You must restart your console before loading different settings." 
net_error_unplugged = #"Your network cable has been disconnected. To continue network play, please reconnect it." 
net_error_unplugged_front_end = #"Your network cable has been disconnected. Select Ok to return to the main menu." 
net_reason_full_observers = "The server will not allow any more observers at this time." 
net_reason_banned = #"You have been banned from this server." 
net_reason_full = #"The game is full." 
net_reason_wrong_password = #"Incorrect password." 
net_reason_version = #"Incompatible version." 
net_reason_general = #"Connection refused." 
net_message_goals_next_level = "These new goals will not be playable until you change level to a new level, or reload this level." 
net_message_game_in_progress = "This game is in progress. Would you like to observe the remainder of this game and join automatically afterwards?" 
net_message_game_in_progress_refused = "This game is in progress.  You must wait until it finishes to join." 
net_message_waiting_for_players = "Waiting for some players to fully load... Would you like to wait for them?" 
net_message_server_removed_you = "The server has chosen to remove you from this game. Press \\bm to return to the main menu." 
net_message_server_moved_on = "The host decided to start the game without you. Press \\bm to return to the main menu." 
net_message_waiting = "Waiting for communication from the host..." 
net_message_no_servers_found = #"No Servers Found" 
net_message_new_king_other = "%s0 is king of the hill!" 
net_message_new_king_you = "You are king of the hill!" 
net_message_new_player = #"%s0 is joining the game" 
net_message_dropped_crown_you = #"You dropped your crown!" 
net_message_dropped_crown_other = #"The king has dropped his crown!" 
net_message_changing_levels = #"Get Ready! Changing levels to %s0...." 
net_message_game_will_start = "The game will start when all players are fully-loaded." 
net_message_join_pending = #"%s0 is waiting to join." 
net_message_observing = #"%s0 is now observing the game." 
net_message_joining = #"%s0 is joining the game." 
net_message_starting_game = #"Get Ready! Starting a %s0 game...." 
net_message_auto_starting_game = #"Get Ready! Auto-Server starting a %s0 game...." 
net_message_server_cheating = #"Warning! The host has enabled cheat codes!" 
net_message_flag_base_warning = #"To score, your team must first retrieve your flag!" 
net_message_player_quit = #"%s0 has left the game." 
net_message_player_timed_out = #"%s0 has timed out." 
net_message_player_now_observing = #"%s0 has chosen to observe." 
net_message_player_kicked = #"Server has removed %s0 from the game." 
net_message_player_banned = #"Server has banned %s0 from the game." 
net_message_player_left_out = #"The host has dropped %s0 from the game." 
net_message_player_dropped = #"%s0 had a bad connection and was dropped." 
net_status_locating = "Connecting to Server. Please wait..." 
net_status_connecting = "Connecting to game...." 
net_status_joining = "Joining game...." 
net_status_trying_password = "Trying password...." 
net_status_lost_connection = #"You have lost connection to the server. Press X to return to main menu." 
net_status_server_quit = #"The server has quit. Press X to return to main menu." 
net_status_join_timeout = "Timed out joining game. Refresh your game list and try again." 
net_status_join_failed = "Failed to join game.  Refresh your game list and try again." 
net_status_not_posted = "Your game was not posted on Gamespy. Check your network cables as well as any Firewall settings you may have." 
net_status_checking_motd = "Connecting to master server...." 
net_status_retry_motd = #"Reattempting to Connect to master server...." 
net_status_getting_lobbies = "Getting lobby list...." 
net_status_connecting_chat = "Connecting to chat server..." 
net_status_gamespy_no_dns = "Failed to connect to Gamespy. Check your Gateway and/or Firewall settings. See the THUG manual for troubleshooting." 
net_status_gamespy_no_connect = "Failed to connect to Gamespy. Check your connection and settings. See the THUG manual for troubleshooting." 
net_status_gamespy_lost_connection = "You have lost connection to Gamespy. Check your network cables or try reconnecting." 
net_status_motd_failed = "Failed to connect to master server." 
net_status_buddy_login_failed = "Failed to connect to server." 
net_status_stats_login_failed = "Failed to connect to stats server." 
net_status_stats_retrieval_failed = "Failed to retrieve stats." 
net_status_testing_settings = "Testing network settings...." 
net_status_need_to_setup = "You have yet to set up your network device and connection. Would you like to do so now?" 
net_status_need_to_setup_dialup = "You have yet to set up your connection settings. Would you like to do so now?" 
net_status_nat_neg_failed = "Failed to connect to server. Refresh your server list and try again." 
net_status_need_to_choose_combo = "You have yet to choose Your Network Configuration. Would you like to do so now?" 
net_modem_state_dialing = "Dialing" 
net_modem_state_connected = "Connected. Logging in...." 
net_modem_state_logged_in = "Connected" 
net_modem_state_disconnecting = "Disconnecting...." 
net_modem_state_hanging_up = "Hanging up...." 
net_modem_state_disconnected = "Disconnected." 
net_modem_state_conencting = "Connecting to ISP" 
net_modem_error_no_modem = "No compatible modems are attached." 
net_modem_error_timeout = "Timed out connecting to service provider. Check your connection settings." 
net_modem_error_busy = "The phone number you dialed is busy." 
net_modem_error_no_connect = "Could not connect to ISP. Please check your ISP phone number." 
net_modem_error_no_dialtone = "No dialtone detected. Make sure your phone line is properly connected." 
net_modem_error_during_connect = "Connected, but could not log in. Check your username and password in your connection settings." 
net_modem_error_during_connect_ync = "Could not authenticate user ID and password. Please check Your Network Configuration file and try again." 
homie_status_online = "Online" 
homie_status_logging_in = "Logging in..." 
homie_status_offline = "Offline" 
homie_status_chatting = "Chatting" 
homie_status_observing = "Observing" 
homie_status_playing = "Playing" 
homie_status_hosting = "Hosting" 
lobby_status_joined = "joined the room" 
lobby_status_left = "left the room" 
score_title_trick_attack = #"Score" 
score_title_graffiti = #"Tags" 
score_title_king = #"Time" 
score_title_slap = #"Slaps" 
net_lobby_full = "FULL" 
sort_title_list = #"Server List" 
sort_title_name = #"Name" 
sort_title_ping = #"Ping" 
sort_title_players = #"Players" 
sort_title_observers = #"Observers" 
sort_title_mode = #"Mode" 
sort_title_level = #"Level" 
sort_title_skill = #"Skill" 
sort_title_ranked = #"Ranked" 
lobby_full_title = #"Full" 
lobby_lan_title = #"LAN Games" 
net_lobby_chat_msg = #"%s0" 
team_1_name = "Red" 
team_2_name = "Blue" 
team_3_name = "Green" 
team_4_name = "Yellow" 
total_str = "Total" 
category_all_levels = "All Levels" 
manual_settings_str = "Manual Settings" 
net_auth_msg = "Authenticating DNAS data..." 
net_auth_error_server_busy = "The network authentication server is busy. Please try again later." 
net_auth_error_before_service = "This software title is not in service." 
net_auth_error_out_of_service = "This software title is not in service." 
net_auth_error_end_of_service = "The network authentication server is not in service." 
net_auth_error_time_out = "Connection to the network authentication server has timed out. Please try again later." 
net_auth_error_invalid_server = "A network authentication system error has occurred." 
net_auth_error_internal = "A network authentication system error has occurred." 
net_auth_error_external = "A network authentication system error has occurred." 
net_auth_error_unique = "A software category error has occurred." 
net_auth_error_download = "A network error has occurred." 
net_auth_error_machine = "A PlayStation\xAE2 hardware information error has occurred." 
net_auth_error_disc = "A PlayStation\xAE2 disc information error has occurred." 
net_auth_error_generic = "An authentication error has occurred." 
net_auth_error_network = "A network error has occurred." 
net_auth_footer_contact = "Please write down the error code number, and contact SCEA at 1-866-466-5333 or via SCEA\'s website, www.us.playstation.com." 
net_auth_footer_network = "Please double check your network connection and/or network configuration." 
net_auth_footer_empty = "" 
net_auth_footer_service_pal = "Please check the start and end dates for this online title at Central Station using the Network Access Disc or refer to PlayStation.com." 
net_auth_footer_central_pal = "Please go to Central Station using the Network Access Disc for more information, or refer to PlayStation.com." 
net_auth_footer_cont_customer_pal = "If you continue to experience the same problem please contact your local PlayStation Customer Care line on the number provided in the software manual." 
net_auth_footer_customer_pal = "Please contact your local PlayStation Customer Care line on the number provided in the software manual for assistance." 
net_auth_footer_clean_pal = "Try cleaning the disc using an approved method as detailed on Central Station (access using Network Access Disc) and PlayStation.com. If the problem continues to occur please contact your local PlayStation Customer Care line on the number provided in the software manual." 
net_auth_footer_network_pal = "Please check your network connection and/or network configuration. Further information is provided on the Network Access Disc." 
SCRIPT joined_team_you 
	printf "join team you" 
	FormatText TextName = msg_text "You have joined the %s team." s = <String0> 
	create_net_panel_message text = <msg_text> style = net_team_panel_message 
ENDSCRIPT

SCRIPT net_team_panel_message 
	PlaySound HUD_specialtrickAA Vol = 100 
	DoMorph pos = PAIR(320.00000000000, 204.00000000000) scale = 0 time = 0 alpha = 0 
	DoMorph pos = PAIR(320.00000000000, 204.00000000000) scale = 1.50000000000 time = 0.10000000149 alpha = 0.89999997616 
	DoMorph pos = PAIR(320.00000000000, 204.00000000000) scale = 0.69999998808 time = 0.10000000149 
	DoMorph pos = PAIR(320.00000000000, 204.00000000000) scale = 1.10000002384 time = 0.10000000149 
	DoMorph pos = PAIR(320.00000000000, 204.00000000000) scale = 0.89999997616 time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 205.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 205.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(319.00000000000, 203.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 205.00000000000) time = 0.10000000149 
	DoMorph alpha = 0 time = 0.30000001192 
	Die 
ENDSCRIPT

SCRIPT net_team_panel_message_long 
	PlaySound HUD_specialtrickAA Vol = 100 
	DoMorph pos = PAIR(320.00000000000, 204.00000000000) scale = 0 time = 0 alpha = 0 
	DoMorph pos = PAIR(320.00000000000, 204.00000000000) scale = 1.50000000000 time = 0.10000000149 alpha = 0.89999997616 
	DoMorph pos = PAIR(320.00000000000, 204.00000000000) scale = 0.69999998808 time = 0.10000000149 
	DoMorph pos = PAIR(320.00000000000, 204.00000000000) scale = 1.10000002384 time = 0.10000000149 
	DoMorph pos = PAIR(320.00000000000, 204.00000000000) scale = 0.89999997616 time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 205.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 205.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(319.00000000000, 203.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 205.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 205.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 205.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(319.00000000000, 203.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 205.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 205.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 205.00000000000) time = 0.10000000149 
	DoMorph alpha = 0 time = 0.30000001192 
	Die 
ENDSCRIPT

SCRIPT generic_net_panel_message 
	DoMorph pos = PAIR(320.00000000000, 204.00000000000) scale = 0 time = 0 alpha = 0 
	DoMorph pos = PAIR(320.00000000000, 204.00000000000) scale = 1.50000000000 time = 0.10000000149 alpha = 0.89999997616 
	DoMorph pos = PAIR(320.00000000000, 204.00000000000) scale = 0.69999998808 time = 0.10000000149 
	DoMorph pos = PAIR(320.00000000000, 204.00000000000) scale = 1.10000002384 time = 0.10000000149 
	DoMorph pos = PAIR(320.00000000000, 204.00000000000) scale = 0.89999997616 time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 205.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 205.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(319.00000000000, 203.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 201.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 205.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 205.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(319.00000000000, 203.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(324.00000000000, 205.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 205.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 205.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(319.00000000000, 203.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 205.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 205.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 207.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(319.00000000000, 203.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 205.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(317.00000000000, 203.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 205.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 205.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 205.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(319.00000000000, 203.00000000000) time = 0.10000000149 
	DoMorph pos = PAIR(321.00000000000, 205.00000000000) time = 0.10000000149 
	DoMorph alpha = 0 time = 0.60000002384 
	Die 
ENDSCRIPT

SCRIPT joined_team_other 
	FormatText TextName = msg_text "%s has joined the %w team." s = <String0> w = <String1> 
	create_net_panel_message text = <msg_text> style = net_team_panel_message 
ENDSCRIPT


