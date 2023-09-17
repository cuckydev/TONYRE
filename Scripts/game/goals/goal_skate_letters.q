
Goal_SkateLetters_genericParams = { 
	goal_text = "Collect S-K-A-T-E" 
	view_goals_text = "Collect S-K-A-T-E" 
	goal_flags = [ 
		got_S 
		got_K 
		got_A 
		got_T 
		got_E 
	] 
	init = SkateLetters_Init 
	uninit = goal_uninit 
	active = SkateLetters_Active 
	activate = SkateLetters_Activate 
	deactivate = SkateLetters_Deactivate 
	fail = SkateLetters_Fail 
	success = SkateLetters_Win 
	expire = SkateLetters_Expire 
	trigger_obj_id = TRG_G_SKATE_Pro 
	S_obj_id = TRG_Goal_Letter_S 
	K_obj_id = TRG_Goal_Letter_K 
	A_obj_id = TRG_Goal_Letter_A 
	T_obj_id = TRG_Goal_Letter_T 
	E_obj_id = TRG_Goal_Letter_E 
	time = 120 
	restart_node = TRG_G_SKATE_RestartNode 
	start_pad_id = G_SKATE_StartPad 
	record_type = score 
} 
SCRIPT SkateLetters_Init 
	goal_init goal_id = <goal_id> 
ENDSCRIPT

SCRIPT SkateLetters_Activate 
	goal_start goal_id = <goal_id> 
	Create_skate <...> 
	RunScriptOnObject id = <S_obj_id> SkateLetter_InitLetter params = { goal_id = <goal_id> flag = got_S id = <S_obj_id> } 
	RunScriptOnObject id = <K_obj_id> SkateLetter_InitLetter params = { goal_id = <goal_id> flag = got_K id = <K_obj_id> } 
	RunScriptOnObject id = <A_obj_id> SkateLetter_InitLetter params = { goal_id = <goal_id> flag = got_A id = <A_obj_id> } 
	RunScriptOnObject id = <T_obj_id> SkateLetter_InitLetter params = { goal_id = <goal_id> flag = got_T id = <T_obj_id> } 
	RunScriptOnObject id = <E_obj_id> SkateLetter_InitLetter params = { goal_id = <goal_id> flag = got_E id = <E_obj_id> } 
ENDSCRIPT

SCRIPT SkateLetter_InitLetter 
	Obj_ClearExceptions 
	Obj_RotY speed = 200 
	Obj_SetInnerRadius 8 
	Obj_SetException ex = SkaterInRadius scr = SkateLetter_GotLetter params = { id = <id> goal_id = <goal_id> flag = <flag> } 
ENDSCRIPT

SCRIPT SkateLetter_GotLetter 
	SpawnSkaterScript SkateLetter_GotLetter2 params = { goal_id = <goal_id> flag = <flag> id = <id> } 
ENDSCRIPT

SCRIPT SkateLetter_GotLetter2 
	IF NOT IsInBail 
		<id> : Obj_ClearExceptions 
		PlaySound goaldone vol = 150 
		KillLocal name = <id> 
		GoalManager_SetGoalFlag name = <goal_id> <flag> 1 
		SkateLetter_HUDLetter flag = <flag> 
	ENDIF 
ENDSCRIPT

SCRIPT SkateLetters_Active 
	IF GoalManager_AllFlagsSet name = <goal_id> 
		GoalManager_WinGoal name = <goal_id> 
	ENDIF 
ENDSCRIPT

SCRIPT SkateLetters_Fail 
	kill_skate_messages 
	goal_fail goal_id = <goal_id> 
ENDSCRIPT

SCRIPT SkateLetters_Deactivate 
	GoalManager_ResetGoalTrigger name = <goal_id> 
	goal_deactivate goal_id = <goal_id> 
	goal_skate_kill_letters <...> 
	kill_skate_messages 
ENDSCRIPT

SCRIPT SkateLetters_Expire 
	goal_expire goal_id = <goal_id> 
	GoalManager_LoseGoal name = <goal_id> 
ENDSCRIPT

SCRIPT SkateLetters_Win 
	goal_success goal_id = <goal_id> 
	kill_skate_messages 
ENDSCRIPT

SCRIPT SkateLetter_HUDLetter 
	IF ChecksumEquals a = <flag> b = got_S 
		create_panel_message id = skate_letter_s text = "S" style = panel_message_letterS 
	ELSE 
		IF ChecksumEquals a = <flag> b = got_K 
			create_panel_message id = skate_letter_k text = "K" style = panel_message_letterK 
		ELSE 
			IF ChecksumEquals a = <flag> b = got_A 
				create_panel_message id = skate_letter_a text = "A" style = panel_message_letterA 
			ELSE 
				IF ChecksumEquals a = <flag> b = got_T 
					create_panel_message id = skate_letter_t text = "T" style = panel_message_letterT 
				ELSE 
					IF ChecksumEquals a = <flag> b = got_E 
						create_panel_message id = skate_letter_e text = "E" style = panel_message_letterE 
					ENDIF 
				ENDIF 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT goal_skate_hide_letters 
	IF ObjectExists id = skate_letter_s 
		DoScreenElementMorph id = skate_letter_s time = 0 alpha = 0 
	ENDIF 
	IF ObjectExists id = skate_letter_k 
		DoScreenElementMorph id = skate_letter_k time = 0 alpha = 0 
	ENDIF 
	IF ObjectExists id = skate_letter_a 
		DoScreenElementMorph id = skate_letter_a time = 0 alpha = 0 
	ENDIF 
	IF ObjectExists id = skate_letter_t 
		DoScreenElementMorph id = skate_letter_t time = 0 alpha = 0 
	ENDIF 
	IF ObjectExists id = skate_letter_e 
		DoScreenElementMorph id = skate_letter_e time = 0 alpha = 0 
	ENDIF 
ENDSCRIPT

SCRIPT goal_skate_unhide_letters 
	IF ObjectExists id = skate_letter_s 
		DoScreenElementMorph id = skate_letter_s time = 0 alpha = 1 
	ENDIF 
	IF ObjectExists id = skate_letter_k 
		DoScreenElementMorph id = skate_letter_k time = 0 alpha = 1 
	ENDIF 
	IF ObjectExists id = skate_letter_a 
		DoScreenElementMorph id = skate_letter_a time = 0 alpha = 1 
	ENDIF 
	IF ObjectExists id = skate_letter_t 
		DoScreenElementMorph id = skate_letter_t time = 0 alpha = 1 
	ENDIF 
	IF ObjectExists id = skate_letter_e 
		DoScreenElementMorph id = skate_letter_e time = 0 alpha = 1 
	ENDIF 
ENDSCRIPT

SCRIPT Create_skate 
	CreateLocal name = <S_obj_id> 
	CreateLocal name = <K_obj_id> 
	CreateLocal name = <A_obj_id> 
	CreateLocal name = <T_obj_id> 
	CreateLocal name = <E_obj_id> 
	RunScriptOnObject id = <S_obj_id> bounce_skate_letter 
	RunScriptOnObject id = <K_obj_id> bounce_skate_letter 
	RunScriptOnObject id = <A_obj_id> bounce_skate_letter 
	RunScriptOnObject id = <T_obj_id> bounce_skate_letter 
	RunScriptOnObject id = <E_obj_id> bounce_skate_letter 
ENDSCRIPT

SCRIPT goal_skate_kill_letters 
	KillLocal name = <S_obj_id> 
	KillLocal name = <K_obj_id> 
	KillLocal name = <A_obj_id> 
	KillLocal name = <T_obj_id> 
	KillLocal name = <E_obj_id> 
ENDSCRIPT

SCRIPT kill_skate_messages 
	IF ObjectExists id = skate_letter_s 
		RunScriptOnScreenElement id = skate_letter_s kill_panel_message 
	ENDIF 
	IF ObjectExists id = skate_letter_k 
		RunScriptOnScreenElement id = skate_letter_k kill_panel_message 
	ENDIF 
	IF ObjectExists id = skate_letter_a 
		RunScriptOnScreenElement id = skate_letter_a kill_panel_message 
	ENDIF 
	IF ObjectExists id = skate_letter_t 
		RunScriptOnScreenElement id = skate_letter_t kill_panel_message 
	ENDIF 
	IF ObjectExists id = skate_letter_e 
		RunScriptOnScreenElement id = skate_letter_e kill_panel_message 
	ENDIF 
ENDSCRIPT

SCRIPT bounce_skate_letter 
	Obj_Hover Amp = 6 Freq = 2 
ENDSCRIPT

SCRIPT panel_message_letterS 
	SetProps font = small just = [ center center ] rgba = [ 127 102 0 95 ] 
	DoMorph time = 0.07999999821 scale = 0.30000001192 pos = PAIR(695.00000000000, 150.00000000000) 
	DoMorph time = 0.11999999732 scale = 3.50000000000 pos = PAIR(610.00000000000, 150.00000000000) 
	DoMorph time = 0.14000000060 scale = 0.60000002384 
	DoMorph time = 0.15999999642 scale = 1.79999995232 
	DoMorph time = 0.18000000715 scale = 0.80000001192 
	DoMorph time = 0.20000000298 scale = 1.20000004768 
ENDSCRIPT

SCRIPT panel_message_letterK 
	SetProps font = small just = [ center center ] rgba = [ 127 102 0 95 ] 
	DoMorph time = 0.07999999821 scale = 0.30000001192 pos = PAIR(695.00000000000, 180.00000000000) 
	DoMorph time = 0.11999999732 scale = 3.50000000000 pos = PAIR(610.00000000000, 180.00000000000) 
	DoMorph time = 0.14000000060 scale = 0.60000002384 
	DoMorph time = 0.15999999642 scale = 1.79999995232 
	DoMorph time = 0.18000000715 scale = 0.80000001192 
	DoMorph time = 0.20000000298 scale = 1.20000004768 
ENDSCRIPT

SCRIPT panel_message_letterA 
	SetProps font = small just = [ center center ] rgba = [ 127 102 0 95 ] 
	DoMorph time = 0.07999999821 scale = 0.30000001192 pos = PAIR(695.00000000000, 210.00000000000) 
	DoMorph time = 0.11999999732 scale = 3.50000000000 pos = PAIR(610.00000000000, 210.00000000000) 
	DoMorph time = 0.14000000060 scale = 0.60000002384 
	DoMorph time = 0.15999999642 scale = 1.79999995232 
	DoMorph time = 0.18000000715 scale = 0.80000001192 
	DoMorph time = 0.20000000298 scale = 1.20000004768 
ENDSCRIPT

SCRIPT panel_message_letterT 
	SetProps font = small just = [ center center ] rgba = [ 127 102 0 95 ] 
	DoMorph time = 0.07999999821 scale = 0.30000001192 pos = PAIR(695.00000000000, 240.00000000000) 
	DoMorph time = 0.11999999732 scale = 3.50000000000 pos = PAIR(610.00000000000, 240.00000000000) 
	DoMorph time = 0.14000000060 scale = 0.60000002384 
	DoMorph time = 0.15999999642 scale = 1.79999995232 
	DoMorph time = 0.18000000715 scale = 0.80000001192 
	DoMorph time = 0.20000000298 scale = 1.20000004768 
ENDSCRIPT

SCRIPT panel_message_letterE 
	SetProps font = small just = [ center center ] rgba = [ 127 102 0 95 ] 
	DoMorph time = 0.07999999821 scale = 0.30000001192 pos = PAIR(695.00000000000, 270.00000000000) 
	DoMorph time = 0.11999999732 scale = 3.50000000000 pos = PAIR(610.00000000000, 270.00000000000) 
	DoMorph time = 0.14000000060 scale = 0.60000002384 
	DoMorph time = 0.15999999642 scale = 1.79999995232 
	DoMorph time = 0.18000000715 scale = 0.80000001192 
	DoMorph time = 0.20000000298 scale = 1.20000004768 
ENDSCRIPT

SCRIPT Goal_Skate_Letter_S 
ENDSCRIPT

SCRIPT Goal_Skate_Letter_K 
ENDSCRIPT

SCRIPT Goal_Skate_Letter_A 
ENDSCRIPT

SCRIPT Goal_Skate_Letter_T 
ENDSCRIPT

SCRIPT Goal_Skate_Letter_E 
ENDSCRIPT


