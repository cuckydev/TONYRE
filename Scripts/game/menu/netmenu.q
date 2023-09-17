SCRIPT set_join_mode 
	StopServerList 
	SetJoinMode <...> 
ENDSCRIPT

SCRIPT chosen_leave_server 
	ClearOmnigons 
	change check_for_unplugged_controllers = 0 
	printf "****************** DEACTIVATING GOALS!!!! ********************" 
	GoalManager_DeactivateAllGoals force_all 
	GoalManager_UninitializeAllGoals 
	GoalManager_RemoveAllGoals 
	ParkEditorCommand command = DestroyGeneratedPark instant 
	LeaveServer 
	SetNetworkMode 
ENDSCRIPT

SCRIPT server_setup_complete 
	FreeServerList 
	SetGameType NetLobby 
	SetServerMode 
	Request_Level level = use_preferences 
	SetGameState On 
ENDSCRIPT

SCRIPT stop_server_list 
	StopServerList 
ENDSCRIPT

SCRIPT start_server_list 
	StartServerList 
ENDSCRIPT

SCRIPT set_ui_from_preferences 
	printf "show detected" 
	SetUIFromPreferences <...> 
ENDSCRIPT

SCRIPT set_preferences_from_ui 
	printf "contents changed detected" 
	SetPreferencesFromUI <...> 
ENDSCRIPT

SCRIPT join_with_password 
	printf "Attempting join with password" 
	JoinWithPassword <...> 
ENDSCRIPT

SCRIPT choose_level 
	printf <...> 
	set_preferences_from_ui prefs = network field = "level" level_checksum = <level> <...> 
	go_back id = front_net_level_main_menu 
ENDSCRIPT


