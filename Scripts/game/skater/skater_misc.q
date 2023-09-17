
SCRIPT TurnBackAround movetonode = TRG_TurnAround01 text = "Whooah, easy bub. You don\'t have enough goal points to go to the next level. Beat some more goals, then come see me again." 
	IF InNetGame 
		<text> = "Sorry bub, taxi\'s busted. \\n Don\'t you have a game to play anyway?" 
	ENDIF 
	IF isTrue Bootstrap_Build 
		<text> = "Sorry, the taxi\'s out of service for the demo. Maybe if you buy the real game, I can afford to get it fixed." 
	ENDIF 
	StopSkitch 
	MakeSkaterGoto EndOfRun Params = { FromTaxiGuy } 
	pause_trick_text 
	pause_balance_meter 
	IF NOT InNetGame 
		GoalManager_PauseAllGoals 
	ENDIF 
	create_speech_box { pos = PAIR(320, 300) 
		text = <text> 
		pad_choose_script = TurnBackAround_Finish 
	} 
ENDSCRIPT

SCRIPT TurnBackAround_Finish 
	unpause_trick_text 
	unpause_balance_meter 
	IF NOT InNetGame 
		GoalManager_UnPauseAllGoals 
	ENDIF 
	Skater : SK3_Killskater nodename = TRG_TurnAround01 nomessage 
ENDSCRIPT

SCRIPT GetSkaterState 
	Skater : GetTags 
	RETURN state = <state> 
ENDSCRIPT


