
(goal_ctf_genericParams) = { 
	(goal_text) = "Capture the other team\'s flag and return it to your base!" 
	(time) = 30 
	(score) = 1 
	(net) 
	(init) = (goal_ctf_init) 
	(activate) = (goal_ctf_activate) 
	(deactivate) = (goal_ctf_deactivate) 
	(active) = (goal_ctf_active) 
	(goal_description) = "Capture the Flag!" 
} 
SCRIPT (goal_ctf_init) 
ENDSCRIPT

SCRIPT (goal_ctf_activate) 
	(GetNumTeams) 
	(create_team_flags) <...> 
	(PrintStruct) <...> 
	IF ( <unlimited_time> = 1 ) 
		IF ( <score> = 1 ) 
			(FormatText) (TextName) = (msg_text) "\\c3Capture the Flag:\\n\\c0First to %s capture wins" (s) = <score> 
		ELSE 
			(FormatText) (TextName) = (msg_text) "\\c3Capture the Flag:\\n\\c0First to %s captures wins" (s) = <score> 
		ENDIF 
	ELSE 
		(FormatText) (TextName) = (msg_text) "\\c3Capture the Flag:\\n\\c0Most captures wins" 
	ENDIF 
	IF (InNetGame) 
		(create_panel_block) (id) = (mp_goal_text) (text) = <msg_text> (style) = (panel_message_goal) 
	ENDIF 
	(ResetScore) 
	IF ( <unlimited_time> = 0 ) 
		(RunScriptOnScreenElement) (id) = (the_time) (clock_morph) 
	ENDIF 
	(StartCTFGame) 
ENDSCRIPT

SCRIPT (goal_ctf_active) 
	IF ( <unlimited_time> = 1 ) 
		IF (AnySkaterTotalScoreAtLeast) <score> 
			IF (OnServer) 
				IF (CalculateFinalScores) 
					(GoalManager_DeactivateGoal) (name) = <goal_id> 
				ENDIF 
			ELSE 
				(GoalManager_DeactivateGoal) (name) = <goal_id> 
			ENDIF 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT (goal_ctf_deactivate) 
	(printf) "*************** goal_ctf_deactivate" 
	IF (ObjectExists) (id) = (mp_goal_text) 
		(DestroyScreenElement) (id) = (mp_goal_text) 
	ENDIF 
	(destroy_ctf_panel_message) 
	(hide_ctf_arrow) 
	(Kill_Team_Flags) 
	(EndCTFGame) 
	IF (OnServer) 
		IF (InInternetMode) 
			(ReportStats) (final) 
		ENDIF 
	ENDIF 
	(create_rankings) (score_title_text) = "CAPTURES" 
ENDSCRIPT

SCRIPT (ctf_done) 
	(dialog_box_exit) 
	(do_backend_retry) 
ENDSCRIPT

SCRIPT (Addgoal_ctf) 
	(GoalManager_AddGoal) (name) = (ctf) { 
		(params) = { (goal_ctf_genericParams) 
			<...> 
		} 
	} 
ENDSCRIPT

SCRIPT (show_ctf_arrow) 
	IF (IsObserving) 
		RETURN 
	ENDIF 
	IF (GoalManager_GoalIsActive) (name) = (ctf) 
		(printf) "***** SHOWING CTF ARROW" 
		IF (ObjectExists) (id) = (ctf_arrow) 
			(printf) "***** HIDING IT FIRST" 
			(hide_ctf_arrow) 
		ENDIF 
		SWITCH <team> 
			CASE 0 
				(printf) "***** target is red" 
				(target) = (TRG_CTF_Red) 
			CASE 1 
				(printf) "***** target is blue" 
				(target) = (TRG_CTF_Blue) 
			CASE 2 
				(printf) "***** target is green" 
				(target) = (TRG_CTF_Green) 
			CASE 3 
				(printf) "***** target is yellow" 
				(target) = (TRG_CTF_Yellow) 
		ENDSWITCH 
		(printf) "***** creating...." 
		(Create3dArrowPointer) (id) = (ctf_arrow) (name) = <target> (model) = "HUD_Arrow" 
	ENDIF 
ENDSCRIPT

SCRIPT (hide_ctf_arrow) 
	IF (ObjectExists) (id) = (ctf_arrow) 
		(DestroyScreenElement) (id) = (ctf_arrow) 
	ENDIF 
ENDSCRIPT

SCRIPT (Startgoal_ctf) 
	(GoalManager_EditGoal) (name) = (ctf) (params) = <...> 
	(GoalManager_ActivateGoal) (name) = (ctf) 
ENDSCRIPT

SCRIPT (took_flag_other) 
	(printf) "******* took flag other" 
	(FormatText) (TextName) = (msg_text) "%s has taken the %w flag." (s) = <String0> (w) = <String1> 
	(create_net_panel_message) (text) = <msg_text> (style) = (net_team_panel_message) 
ENDSCRIPT

SCRIPT (took_flag_you) 
	(printf) "******* took flag you" 
	(create_ctf_panel_message) (msg_text) = "Return the flag to your base!" 
	(FormatText) (TextName) = (msg_text) "You have taken the %s flag. Return it to your base!" (s) = <String0> 
	(create_net_panel_message) (text) = <msg_text> (style) = (net_team_panel_message) 
ENDSCRIPT

SCRIPT (took_flag_yours) 
	(printf) "******* took flag yours" 
	(FormatText) (TextName) = (msg_text) "%s has taken your flag! Hunt him down!" (s) = <String0> 
	(create_net_panel_message) (text) = <msg_text> (style) = (net_team_panel_message) 
ENDSCRIPT

SCRIPT (stole_flag_other) 
	(printf) "******* stole flag other" 
	(FormatText) (TextName) = (msg_text) "%s has stolen the %w flag." (s) = <String0> (w) = <String1> 
	(create_net_panel_message) (text) = <msg_text> (style) = (net_team_panel_message) 
ENDSCRIPT

SCRIPT (stole_flag_you) 
	(printf) "******* stole flag you" 
	(FormatText) (TextName) = (msg_text) "You have stolen the %s flag. Return it to your base!" (s) = <String0> 
	(create_net_panel_message) (text) = <msg_text> (style) = (net_team_panel_message) 
ENDSCRIPT

SCRIPT (stole_flag_from_you) 
	(printf) "******* stole flag from you" 
	(destroy_ctf_panel_message) 
	(FormatText) (TextName) = (msg_text) "%s has stolen the %w flag from you!" (s) = <String0> (w) = <String1> 
	(create_net_panel_message) (text) = <msg_text> (style) = (net_team_panel_message) 
ENDSCRIPT

SCRIPT (relocate_flag) 
	SWITCH <team> 
		CASE 0 
			(flag_name) = (TRG_CTF_Red) 
		CASE 1 
			(flag_name) = (TRG_CTF_Blue) 
		CASE 2 
			(flag_name) = (TRG_CTF_Green) 
		CASE 3 
			(flag_name) = (TRG_CTF_Yellow) 
	ENDSWITCH 
	IF (NodeExists) <flag_name> 
		IF (IsAlive) (name) = <flag_name> 
			<flag_name> : (Die) 
		ENDIF 
	ENDIF 
	(create) (name) = <flag_name> 
	IF (OnServer) 
		<flag_name> : (Obj_SetException) (ex) = (AnySkaterInRadius) (scr) = (CTF_Team_Flag_Trigger) (params) = { <...> } 
	ENDIF 
ENDSCRIPT

SCRIPT (captured_your_flag) 
	(printf) "******* captured your flag" 
	(FormatText) (TextName) = (msg_text) "%s has captured your flag.!" (s) = <String0> 
	(create_net_panel_message) (text) = <msg_text> (style) = (net_team_panel_message) 
	(relocate_flag) <...> 
ENDSCRIPT

SCRIPT (captured_flag_other) 
	(printf) "******* captured flag other" 
	(FormatText) (TextName) = (msg_text) "%s has captured the %w flag." (s) = <String0> (w) = <String1> 
	(create_net_panel_message) (text) = <msg_text> (style) = (net_team_panel_message) 
	(relocate_flag) <...> 
ENDSCRIPT

SCRIPT (captured_flag_you) 
	(printf) "******* captured flag you" 
	(destroy_ctf_panel_message) 
	(FormatText) (TextName) = (msg_text) "You have captured the %s flag." (s) = <String0> 
	(create_net_panel_message) (text) = <msg_text> (style) = (net_team_panel_message) 
	(relocate_flag) <...> 
ENDSCRIPT

SCRIPT (retrieved_flag_you) 
	(printf) "******* retrieved flag you" 
	(FormatText) (TextName) = (msg_text) "You retrieved the %s flag!" (s) = <String0> 
	(create_net_panel_message) (text) = <msg_text> (style) = (net_team_panel_message) 
	(relocate_flag) <...> 
ENDSCRIPT

SCRIPT (retrieved_flag_other) 
	(printf) "******* retrieved flag other" 
	(FormatText) (TextName) = (msg_text) "%s retrieved the %w flag." (s) = <String0> (w) = <String1> 
	(create_net_panel_message) (text) = <msg_text> (style) = (net_team_panel_message) 
	(relocate_flag) <...> 
ENDSCRIPT

SCRIPT (flag_returned) 
	(printf) "******* flag returned" 
	(FormatText) (TextName) = (msg_text) "The %s has returned to its base." (s) = <String0> 
	(create_net_panel_message) (text) = <msg_text> (style) = (net_team_panel_message) 
	(relocate_flag) <...> 
ENDSCRIPT

SCRIPT (create_ctf_panel_message) 
	(create_panel_block) (id) = (current_ctf_message) (text) = <msg_text> (style) = (panel_message_goal) (final_pos) = PAIR(620, 80) (dont_animate) 
ENDSCRIPT

SCRIPT (destroy_ctf_panel_message) 
	IF (ObjectExists) (id) = (current_ctf_message) 
		(DestroyScreenElement) (id) = (current_ctf_message) 
	ENDIF 
ENDSCRIPT


