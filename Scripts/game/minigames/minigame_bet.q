minigame_trickspot_genericParams = { 
	init = minigame_trickspot_init 
	number_collected = 1 
	minigame_record = 0 
	trigger_obj_id = TRG_MG_RoundCounter02 
	no_restart 
	minigame 
	betting_game 
	trickspot 
	betting_guy_node = TRG_MG_BettingNav01 
	location = "the stairs" 
	bet_easy = { 
		key_combos = [ 
			Air_SquareU 
			Air_SquareD 
			Air_SquareL 
			Air_SquareR 
		] 
		bet_amount = 100 
		tries = 5 
	} 
	bet_medium = { 
		key_combos = [ 
			Air_SquareUL 
			Air_SquareUR 
			Air_SquareDL 
			Air_SquareDR 
		] 
		bet_amount = 250 
		tries = 3 
	} 
	bet_hard = { 
		key_combos = [ 
			Air_CircleUL 
			Air_CircleUR 
			Air_CircleDL 
			Air_CircleDR 
			Air_CircleU 
			Air_CircleD 
			Air_CircleL 
			Air_CircleR 
		] 
		bet_amount = 1000 
		tries = 2 
	} 
} 
SCRIPT minigame_trickspot_init 
ENDSCRIPT

SCRIPT MG_Bet_InsideArea 
	IF GoalManager_BetIsActive name = sch_goal_minigame_trickspot 
		GoalManager_StartBetAttempt name = sch_goal_minigame_trickspot 
		GoalManager_GetGoalParams name = sch_goal_betting_guy 
		StartGap GapID = StairMinigame flags = [ cancel_ground ] TrickText = <bet_action> trickscript = sch_goal_minigame_trickspot_got 
	ENDIF 
ENDSCRIPT

SCRIPT MG_Bet_OutsideArea 
	EndGap GapID = StairMinigame 
	IF GoalManager_BetIsActive name = sch_goal_minigame_trickspot 
		RunScriptOnObject id = TRG_MG_BettingGuy01 betting_guy_wait_for_land params = { goal_id = sch_goal_minigame_trickspot } 
	ENDIF 
ENDSCRIPT

SCRIPT sch_goal_minigame_trickspot_got 
	printf "you got it" 
	GoalManager_WinGoal name = sch_goal_betting_guy 
ENDSCRIPT

OBJ_FLAG_BETSTART = 0 
OBJ_FLAG_BETEND = 1 
OBJ_FLAG_BETWON = 2 
DefaultBettingParams = { 
	Bet_Clusters = [ { id = Sch_KillSpot01 flag = got_1 } 
		{ id = Sch_KillSpot02 flag = got_2 } 
	] 
	BetAmount = 50 
	TrickName = "kickflip" 
	TOName = "the stairs behind me" 
	NumTries = 3 
} 
SCRIPT MG_Betting_Guy DefaultBettingParams 
	Obj_ClearExceptions 
	Obj_SetException ex = SkaterInRadius scr = MG_Betting_Guy_Skater_Far params = { <...> } 
	Obj_SetInnerRadius 100 
ENDSCRIPT

SCRIPT MG_Betting_Guy_Skater_Far 
	Obj_ClearExceptions 
	Obj_SetException ex = SkaterInRadius scr = MG_Betting_Guy_CheckForBet params = { <...> } 
	Obj_SetInnerRadius 10 
	Obj_SetException ex = SkaterOutOfRadius scr = MG_Betting_Guy_GotoNextLocation params = { <...> } 
	Obj_SetOuterRadius 950 
ENDSCRIPT

SCRIPT MG_Betting_Guy_CheckForBet 
	Obj_ClearExceptions 
	Obj_SetException ex = SkaterOutOfRadius scr = MG_Betting_Guy_Skater_Far params = { <...> } 
	Obj_SetOuterRadius 10 
	Playstream RANDOM_NO_REPEAT(1, 1, 1, 1, 1) RANDOMCASE Andrew_Near01 RANDOMCASE Andrew_Near02 RANDOMCASE Andrew_Near03 RANDOMCASE Andrew_Near04 RANDOMCASE Andrew_NearTony01 RANDOMEND 
	BEGIN 
		IF SkaterSpeedLessThan 1 
			GotoPreserveParams MG_Betting_Guy_BetSkater 
		ENDIF 
		wait 1 frame 
	REPEAT 
ENDSCRIPT

SCRIPT MG_Betting_Guy_GotoNextLocation 
	Die 
ENDSCRIPT

SCRIPT MG_Betting_Guy_BetSkater 
	Obj_ClearFlag OBJ_FLAG_BETSTART 
	Obj_ClearFlag OBJ_FLAG_BETEND 
	Obj_ClearFlag OBJ_FLAG_BETWON 
	Obj_ClearExceptions 
	Obj_SetException ex = SkaterOutOfRadius scr = MG_Betting_Guy_Skater_Far params = { <...> } 
	Obj_SetOuterRadius 15 
	GetNodeName 
	wait 1 frame 
	MakeSkaterGoto MG_Betting_Sakter_AI params = { BettingGuyNode = <nodename> } 
	FormatText TextName = b_d1 "%a dollars says you can\'t %b" a = <BetAmount> b = <TrickName> 
	FormatText TextName = b_d2 "%z %c in %d tries!" c = <TOName> d = <NumTries> z = <b_d1> 
	FormatText TextName = bet_description "%y\\n----------\\n Press Square to Decline\\nor\\nPress Circle to Accept" y = <b_d2> 
	create_speech_box text = <bet_description> style = speech_box_style 
	BEGIN 
		IF Obj_FlagSet OBJ_FLAG_BETSTART 
			Obj_ClearFlag OBJ_FLAG_BETSTART 
			GotoPreserveParams MG_Betting_Guy_CheckingForTrick 
		ENDIF 
		IF Obj_FlagSet OBJ_FLAG_BETEND 
			Obj_ClearFlag OBJ_FLAG_BETEND 
			BREAK 
		ENDIF 
		wait 1 frame 
	REPEAT 
	GotoPreserveParams MG_Betting_Guy_Skater_Far 
ENDSCRIPT

SCRIPT MG_Betting_Guy_CheckingForTrick 
	Playstream RANDOM_NO_REPEAT(1, 1) RANDOMCASE Andrew_Support01 RANDOMCASE Andrew_Support02 RANDOMEND 
	Obj_ClearExceptions 
	create prefix = "TRGP_MG_Bet01" 
	wait 1 frame 
	Obj_ClearFlag OBJ_FLAG_BETSTART 
	BEGIN 
		printf "checking area entrance" 
		BEGIN 
			IF Obj_FlagSet OBJ_FLAG_BETSTART 
				Obj_ClearFlag OBJ_FLAG_BETSTART 
				BREAK 
			ENDIF 
			IF SkaterCurrentScorePotGreaterThan 0 
				BREAK 
			ENDIF 
			wait 1 frame 
		REPEAT 
		printf "checking trickstring" 
		Obj_ClearFlag OBJ_FLAG_BETEND 
		SpawnSkaterScript SkaterStartBetGap params = { TrickToDo = <TrickName> } 
		BEGIN 
			wait 1 frame 
			IF Obj_FlagSet OBJ_FLAG_BETEND 
				Obj_ClearFlag OBJ_FLAG_BETEND 
				BREAK 
			ENDIF 
		REPEAT 
		printf "out of area" 
		SpawnSkaterScript SkaterEndBetGap params = { TrickToDo = <TrickName> } 
		wait 2 frames 
		BEGIN 
			IF NOT SkaterCurrentScorePotGreaterThan 0 
				BREAK 
			ENDIF 
			wait 10 frame 
		REPEAT 
		IF Obj_FlagSet OBJ_FLAG_BETWON 
			GotoPreserveParams MG_Betting_Guy_PaySkater 
		ENDIF 
		RANDOM_NO_REPEAT(1, 1, 1, 1) 
			RANDOMCASE create_speech_box text = "Not Quite..." style = speech_box_style 
			RANDOMCASE create_speech_box text = "Not even!" style = speech_box_style 
			RANDOMCASE create_speech_box text = "Try again..." style = speech_box_style 
			RANDOMCASE create_speech_box text = "Not Even Close!" style = speech_box_style 
		RANDOMEND 
	REPEAT <NumTries> 
	printf "out of tries" 
	Obj_ClearFlag OBJ_FLAG_BETSTART 
	Obj_ClearFlag OBJ_FLAG_BETEND 
	GotoPreserveParams MG_Betting_Guy_Skater_Far 
ENDSCRIPT

SCRIPT MG_Betting_Guy_IgnoreSkater 
	Obj_ClearExceptions 
	Obj_SetException ex = SkaterInRadius scr = MG_Betting_Guy_IgnoreSkaterNear params = { <...> } 
	Obj_SetInnerRadius 10 
	Obj_SetException ex = SkaterOutOfRadius scr = MG_Betting_Guy_GotoNextLocation params = { <...> } 
	Obj_SetOuterRadius 250 
ENDSCRIPT

SCRIPT MG_Betting_Guy_IgnoreSkaterNear 
	Obj_ClearExceptions 
	Obj_SetException ex = SkaterOutOfRadius scr = MG_Betting_Guy_IgnoreSkater params = { <...> } 
	Obj_SetOuterRadius 50 
	RANDOM_NO_REPEAT(1, 1, 1, 1) 
		RANDOMCASE create_speech_box text = "Whatever, Dude..." style = speech_box_style 
		RANDOMCASE create_speech_box text = "Wimp..." style = speech_box_style 
		RANDOMCASE create_speech_box text = "Go fuck yourself..." style = speech_box_style 
		RANDOMCASE create_speech_box text = "Fuck off..." style = speech_box_style 
	RANDOMEND 
ENDSCRIPT

SCRIPT MG_Betting_Guy_PaySkater 
	BEGIN 
		Playsound hud_jumpgap 
		wait 10 frames 
	REPEAT 10 
	Playstream RANDOM_NO_REPEAT(1, 1, 1) RANDOMCASE Andrew_Success03 RANDOMCASE Andrew_Success06 RANDOMCASE Andrew_Success07 RANDOMEND 
	Playsound cash Vol = 130 
	GoalManager_AddCash <BetAmount> 
	GotoPreserveParams MG_Betting_Guy_Skater_Far 
ENDSCRIPT

SCRIPT MG_Betting_Sakter_AI BettingGuyNode = TRG_MB_BettingGuy01 
	ClearTrickQueue 
	ClearEventBuffer 
	SetRollingFriction 1000 
	DisablePlayerInput 
	wait 10 frames 
	BEGIN 
		IF Held Circle 
			SendFlag name = <BettingGuyNode> OBJ_FLAG_BETSTART 
			BREAK 
		ENDIF 
		IF Held Square 
			SendFlag name = <BettingGuyNode> OBJ_FLAG_BETEND 
			BREAK 
		ENDIF 
		wait 1 frame 
	REPEAT 
	wait 10 frames 
	speech_box_exit 
	SetRollingFriction 1 
	Enableplayerinput 
	MakeSkaterGoto OnGroundAi 
ENDSCRIPT

SCRIPT MG_BetGotGap 
	RANDOM_NO_REPEAT(1, 1) 
		RANDOMCASE create_speech_box text = "Way to go..." style = speech_box_style 
		RANDOMCASE create_speech_box text = "You did it!" style = speech_box_style 
	RANDOMEND 
	SendFlag prefix = "TRG_MG_BettingGuy" OBJ_FLAG_BETWON 
ENDSCRIPT

SCRIPT SkaterStartBetGap 
	printf <TrickToDo> 
	StartGap GapID = BetGap flags = [ cancel_ground ] TrickText = <TrickToDo> trickscript = MG_BetGotGap 
ENDSCRIPT

SCRIPT SkaterEndBetGap 
	EndGap GapID = BetGap text = "Bet Gap" score = 50 
ENDSCRIPT


