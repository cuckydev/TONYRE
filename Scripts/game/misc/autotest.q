LevelTestScripts = 
[ 
	{ TestScript = Sch_TestLevel Name = "School" } 
	{ TestScript = Sf2_TestLevel Name = "San Francisco 2" } 
	{ TestScript = Alc_TestLevel Name = "Alcatraz" } 
	{ TestScript = Cnv_TestLevel Name = "Carnival" } 
	{ TestScript = Jnk_TestLevel Name = "Junkyard" } 
	{ TestScript = Kona_TestLevel Name = "Kona" } 
	{ TestScript = Lon_TestLevel Name = "London" } 
	{ TestScript = Zoo_TestLevel Name = "Zoo" } 
	{ TestScript = Hoffman_TestLevel Name = "Hoffman" } 
] 
SCRIPT Sch_TestLevel 
	changelevel level = load_sch 
	wait 5 gameframes 
	IF GotParam TestCommonGoals 
		TestCommonGoals 
	ENDIF 
ENDSCRIPT

SCRIPT Sf2_TestLevel 
	changelevel level = load_sf2 
	wait 5 gameframes 
	IF GotParam TestCommonGoals 
		TestCommonGoals 
	ENDIF 
ENDSCRIPT

SCRIPT Alc_TestLevel 
	changelevel level = load_alc 
	wait 5 gameframes 
	IF GotParam TestCommonGoals 
		TestCommonGoals 
	ENDIF 
ENDSCRIPT

SCRIPT Cnv_TestLevel 
	changelevel level = load_cnv 
	wait 5 gameframes 
	IF GotParam TestCommonGoals 
		TestCommonGoals 
	ENDIF 
ENDSCRIPT

SCRIPT Jnk_TestLevel 
	changelevel level = load_jnk 
	wait 5 gameframes 
	IF GotParam TestCommonGoals 
		TestCommonGoals 
	ENDIF 
ENDSCRIPT

SCRIPT Lon_TestLevel 
	changelevel level = load_lon 
	wait 5 gameframes 
	IF GotParam TestCommonGoals 
		TestCommonGoals 
	ENDIF 
ENDSCRIPT

SCRIPT Zoo_TestLevel 
	changelevel level = load_zoo 
	wait 5 gameframes 
	IF GotParam TestCommonGoals 
		TestCommonGoals 
	ENDIF 
ENDSCRIPT

SCRIPT Kona_TestLevel 
	changelevel level = load_kon 
	wait 5 gameframes 
	IF GotParam TestCommonGoals 
		TestCommonGoals 
	ENDIF 
ENDSCRIPT

SCRIPT Hoffman_TestLevel 
	changelevel level = load_hof 
	wait 5 gameframes 
	IF GotParam TestCommonGoals 
		TestCommonGoals 
	ENDIF 
ENDSCRIPT

SCRIPT CleanupAnyMenus 
	wait 10 seconds 
	IF ObjectExists id = stats_menu 
		goal_stats_menu_exit 
	ENDIF 
	IF ObjectExists id = pro_challenge_anchor 
		goal_pro_challenges_unlocked_reject 
	ENDIF 
	IF ObjectExists id = dialog_box_anchor 
		goal_new_level_reject 
	ENDIF 
ENDSCRIPT

SCRIPT TestCommonGoals 
	GoalManager_UnlockAllGoals 
	TestScoreGoal Type = "HighScore" 
	CleanupAnyMenus 
	TestScoreGoal Type = "ProScore" 
	CleanupAnyMenus 
	TestScoreGoal Type = "SickScore" 
	CleanupAnyMenus 
	TestSkateLettersGoal 
	CleanupAnyMenus 
	TestRaceGoal 
	CleanupAnyMenus 
	TestCollectGoal 
	CleanupAnyMenus 
	TestComboGoal Type = "AmateurComboLine" 
	CleanupAnyMenus 
	TestComboGoal Type = "ProCombo" 
	CleanupAnyMenus 
	GoalManager_UnbeatAllGoals 
	wait 1 second 
ENDSCRIPT

SCRIPT TestLevels 
	DestroyAndRecreateMessageContainer 
	BEGIN 
		GetNextArrayElement LevelTestScripts 
		IF GotParam Element 
			AddParams <Element> 
			<TestScript> 
		ELSE 
			BREAK 
		ENDIF 
		wait 1 gameframe 
	REPEAT 
	BEGIN 
		GetNextArrayElement LevelTestScripts 
		IF GotParam Element 
			AddParams <Element> 
			FormatText TextName = MessageText "About to test %s ..." s = <Name> 
			DisplayTestMessage Text = <MessageText> 
			<TestScript> TestCommonGoals 
		ENDIF 
		wait 1 gameframe 
	REPEAT 
	BEGIN 
		GetRandomArrayElement LevelTestScripts 
		IF GotParam Element 
			AddParams <Element> 
			<TestScript> 
		ENDIF 
		wait 1 gameframe 
	REPEAT 
ENDSCRIPT

KenStylePos = PAIR(320, 405) 
SCRIPT KenStyle 
	SetProps Scale = 2 Pos = KenStylePos Just = [ CENTER CENTER ] rgba = [ 0 , 128 , 0 , 128 ] 
	DoMorph Time = 0 Pos = KenStylePos Scale = 0 
	DoMorph Time = 0.20000000298 Pos = KenStylePos Scale = 1.20000004768 
	wait 2 seconds 
	FireEvent Type = KenStyleMessageDied 
	Die 
ENDSCRIPT

SCRIPT DestroyAndRecreateMessageContainer 
	IF ObjectExists id = TestLevelMessagesContainer 
		DestroyScreenElement id = TestLevelMessagesContainer 
	ENDIF 
	SetScreenElementLock id = root_window Off 
	CreateScreenElement { 
		id = TestLevelMessagesContainer 
		Parent = root_window 
		Type = ContainerElement 
		Pos = PAIR(320.00000000000, 240.00000000000) 
		Dims = PAIR(640.00000000000, 480.00000000000) 
	} 
ENDSCRIPT

SCRIPT DisplayTestMessage 
	SetScreenElementLock id = TestLevelMessagesContainer Off 
	CreateScreenElement { 
		Parent = TestLevelMessagesContainer 
		Type = TextElement 
		Font = Small 
		Text = <Text> 
	} 
	RunScriptOnScreenElement id = <id> KenStyle 
	WaitForEvent Type = KenStyleMessageDied 
ENDSCRIPT

SCRIPT WaitForCameraAnimToFinish 
	BEGIN 
		IF SkaterCamAnimFinished 
			BREAK 
		ENDIF 
		wait 1 gameframe 
	REPEAT 
ENDSCRIPT

SCRIPT TestSkateLettersGoal 
	DisplayTestMessage Text = "About to test letters goal ..." 
	GoalManager_CreateGoalName Goal_Type = "Skate" 
	IF GoalManager_ActivateGoal Name = <Goal_Id> DontAssert 
		GoalManager_GetGoalParams Name = <Goal_Id> 
		wait 1 gameframe 
		wait 2 seconds 
		PlaySkaterCamAnim skater = 0 stop 
		wait 1 gameframe 
		JumpSkaterToNode NodeName = <s_obj_id> 
		wait 1 gameframe 
		JumpSkaterToNode NodeName = <k_obj_id> 
		wait 1 gameframe 
		JumpSkaterToNode NodeName = <a_obj_id> 
		wait 1 gameframe 
		JumpSkaterToNode NodeName = <t_obj_id> 
		wait 1 gameframe 
		JumpSkaterToNode NodeName = <e_obj_id> 
		wait 1 gameframe 
		wait 2 seconds 
		PlaySkaterCamAnim skater = 0 stop 
	ELSE 
		wait 1 seconds 
		DisplayTestMessage Text = "No SKATE letters goal to test ..." 
	ENDIF 
ENDSCRIPT

SCRIPT TestRaceGoal 
	DisplayTestMessage Text = "About to test race goal ..." 
	GoalManager_CreateGoalName Goal_Type = "Race" 
	IF GoalManager_ActivateGoal Name = <Goal_Id> DontAssert 
		GoalManager_GetGoalParams Name = <Goal_Id> 
		wait 1 gameframe 
		wait 2 seconds 
		PlaySkaterCamAnim skater = 0 stop 
		wait 1 gameframe 
		BEGIN 
			GetNextArrayElement <race_waypoints> 
			IF NOT GotParam Element 
				BREAK 
			ENDIF 
			AddParams <Element> 
			JumpSkaterToNode NodeName = <id> 
			wait 1 gameframe 
		REPEAT 
		wait 2 seconds 
		PlaySkaterCamAnim skater = 0 stop 
	ELSE 
		wait 1 seconds 
		DisplayTestMessage Text = "No Race goal to test ..." 
	ENDIF 
ENDSCRIPT

SCRIPT TestCollectGoal 
	DisplayTestMessage Text = "About to test collect goal ..." 
	GoalManager_CreateGoalName Goal_Type = "Collect" 
	IF GoalManager_ActivateGoal Name = <Goal_Id> DontAssert 
		GoalManager_GetGoalParams Name = <Goal_Id> 
		wait 1 gameframe 
		wait 2 seconds 
		PlaySkaterCamAnim skater = 0 stop 
		wait 1 gameframe 
		PermuteArray Array = <goal_collect_objects> NewArrayName = PermutedArray 
		BEGIN 
			GetNextArrayElement <PermutedArray> 
			IF NOT GotParam Element 
				BREAK 
			ENDIF 
			AddParams <Element> 
			JumpSkaterToNode NodeName = <id> 
			wait 2 seconds 
			PlaySkaterCamAnim skater = 0 stop 
		REPEAT 
		wait 2 seconds 
		PlaySkaterCamAnim skater = 0 stop 
	ELSE 
		wait 1 seconds 
		DisplayTestMessage Text = "No Collect goal to test ..." 
	ENDIF 
ENDSCRIPT

SCRIPT TestComboGoal 
	FormatText TextName = MessageText "About to test %s ..." s = <Type> 
	DisplayTestMessage Text = <MessageText> 
	GoalManager_CreateGoalName Goal_Type = <Type> 
	IF GoalManager_ActivateGoal Name = <Goal_Id> DontAssert 
		GoalManager_GetGoalParams Name = <Goal_Id> 
		wait 1 gameframe 
		wait 2 seconds 
		PlaySkaterCamAnim skater = 0 stop 
		wait 1 gameframe 
		JumpSkaterToNode NodeName = <c_obj_id> MoveUpABit 
		wait 1 gameframe 
		JumpSkaterToNode NodeName = <o_obj_id> MoveUpABit 
		wait 1 gameframe 
		JumpSkaterToNode NodeName = <m_obj_id> MoveUpABit 
		wait 1 gameframe 
		JumpSkaterToNode NodeName = <b_obj_id> MoveUpABit 
		wait 1 gameframe 
		JumpSkaterToNode NodeName = <o2_obj_id> MoveUpABit 
		wait 1 gameframe 
		wait 2 seconds 
		PlaySkaterCamAnim skater = 0 stop 
	ELSE 
		wait 1 seconds 
		FormatText TextName = MessageText "No %s to test ..." s = <Type> 
		DisplayTestMessage Text = <MessageText> 
	ENDIF 
ENDSCRIPT

SCRIPT TestScoreGoal 
	FormatText TextName = MessageText "About to test %s ..." s = <Type> 
	DisplayTestMessage Text = <MessageText> 
	GoalManager_CreateGoalName Goal_Type = <Type> 
	IF GoalManager_ActivateGoal Name = <Goal_Id> DontAssert 
		GoalManager_GetGoalParams Name = <Goal_Id> 
		wait 1 gameframe 
		wait 2 seconds 
		PlaySkaterCamAnim skater = 0 stop 
		MakeSkaterGoto MakeSkaterGetScore Params = { Score = <Score> } 
		wait 2 seconds 
		PlaySkaterCamAnim skater = 0 stop 
	ELSE 
		wait 1 seconds 
		FormatText TextName = MessageText "No %s to test ..." s = <Type> 
		DisplayTestMessage Text = <MessageText> 
	ENDIF 
ENDSCRIPT

SCRIPT MakeSkaterGetScore 
	SetTrickName #"Cheat Score" 
	SetTrickScore <Score> 
	Display 
	SetTrickName #"Cheat Score" 
	SetTrickScore <Score> 
	Display 
	ClearPanel_Landed 
	goto OnGroundAI 
ENDSCRIPT


