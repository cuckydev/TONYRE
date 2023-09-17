
display_event_arrows = 0 
SCRIPT SetExceptionHandler Group = Default 
	IF GotParam Params 
		SetEventHandler Ex = <Ex> Scr = <Scr> Group = <Group> Params = <Params> Exception 
	ELSE 
		SetEventHandler Ex = <Ex> Scr = <Scr> Group = <Group> Exception 
	ENDIF 
ENDSCRIPT

SCRIPT ClearExceptionGroup 
	ClearEventHandlerGroup <...> 
	ClearOnExceptionRun 
ENDSCRIPT

SCRIPT BroadcastEvent 
	LaunchEvent <...> Broadcast 
ENDSCRIPT

SCRIPT SetException Group = Default 
	SetExceptionHandler <...> 
ENDSCRIPT

SCRIPT ClearExceptions 
	ClearEventHandlerGroup Default 
	ClearOnExceptionRun 
ENDSCRIPT

SCRIPT ClearException 
	ClearEventHandler <...> 
	ClearOnExceptionRun 
ENDSCRIPT

SCRIPT ClearAllExceptionGroups 
	ClearEventHandlerGroup all_groups 
	ClearOnExceptionRun 
ENDSCRIPT

SCRIPT ClearOnExceptionRun 
	OnExceptionRun 
ENDSCRIPT

SCRIPT ClearOnExitRun 
	OnExitRun 
ENDSCRIPT

SCRIPT Obj_SetException 
	SetException <...> 
ENDSCRIPT

SCRIPT Obj_ClearException 
	ClearException <...> 
ENDSCRIPT

SCRIPT Obj_ClearExceptions 
	ClearExceptions <...> 
ENDSCRIPT

StateToEntryEventMapping = { 
	Skater_InAir = SkaterEnterAir 
	Skater_InBail = SkaterEnterBail 
	Skater_OnRail = SkaterEnterRail 
	Skater_Skitching = SkaterEnterSkitch 
	Skater_InManual = SkaterEnterManual 
	Skater_InRevert = SkaterEnterRevert 
	Skater_OnGround = SkaterEnterGround 
	Skater_OnWall = SkaterEnterWall 
	Skater_InWallplant = SkaterEnterWallplant 
	Skater_InRevert = SkaterEnterRevert 
	Skater_OnLip = SkaterEnterLip 
	Skater_EndOfRun = SkaterEnterEndOfRun 
	Skater_OnLadder = SkaterEnterLadder 
	Skater_InHang = SkaterEnterHang 
} 
StateToExitEventMapping = { 
	Skater_InAir = SkaterExitAir 
	Skater_InBail = SkaterExitBail 
	Skater_OnRail = SkaterExitRail 
	Skater_Skitching = SkaterExitSkitch 
	Skater_InManual = SkaterExitManual 
	Skater_InRevert = SkaterExitRevert 
	Skater_OnGround = SkaterExitGround 
	Skater_OnWall = SkaterExitWall 
	Skater_InWallplant = SkaterExitWallplant 
	Skater_InRevert = SkaterExitRevert 
	Skater_OnLip = SkaterExitLip 
	Skater_EndOfRun = SkaterExitEndOfRun 
	Skater_OnLadder = SkaterExitLadder 
	Skater_InHang = SkaterExitHang 
} 
SubStateToEntryEventMapping = { 
	Flip = SkaterEnterFlip 
	Grab = SkaterEnterGrab 
	Transfer = SkaterEnterTransfer 
	AcidDrop = SkaterEnterAcidDrop 
} 
SubStateToExitEventMapping = { 
	Flip = SkaterExitFlip 
	Grab = SkaterExitGrab 
	Transfer = SkaterExitTransfer 
	AcidDrop = SkaterExitAcidDrop 
} 
StateToSubStateExitEventMask = { 
	Skater_None = [ ] 
	Skater_InAir = [ SkaterExitTransfer SkaterExitAcidDrop ] 
	Skater_InBail = [ ] 
	Skater_OnRail = [ ] 
	Skater_Skitching = [ ] 
	Skater_InManual = [ ] 
	Skater_InRevert = [ ] 
	Skater_OnGround = [ ] 
	Skater_OnWall = [ ] 
	Skater_InWallplant = [ ] 
	Skater_InRevert = [ ] 
	Skater_OnLip = [ ] 
	Skater_EndOfRun = [ ] 
	Skater_OnLadder = [ ] 
	Skater_InHang = [ ] 
} 
SCRIPT LaunchStateChangeEvent 
	NewState = <State> 
	GetTags 
	LaunchAllSubStateExitEvents NewState = <NewState> 
	IF ( <NewState> = <State> ) 
		RETURN 
	ENDIF 
	IF GotParam StateExitEvent 
		LaunchEvent Broadcast Type = <StateExitEvent> 
	ENDIF 
	LaunchEvent Broadcast Type = ( StateToEntryEventMapping . <NewState> ) 
	SetTags StateExitEvent = ( StateToExitEventMapping . <NewState> ) State = <NewState> 
ENDSCRIPT

SCRIPT LaunchSubStateEntryEvent 
	LaunchEvent Broadcast Type = ( SubStateToEntryEventMapping . <SubState> ) 
	GetTags 
	NewExitEvent = ( SubStateToExitEventMapping . <SubState> ) 
	SubStateExitEventList = ( <SubStateExitEventList> + { <NewExitEvent> } ) 
	SetTags SubStateExitEventList = <SubStateExitEventList> 
ENDSCRIPT

SCRIPT LaunchSubStateExitEvent 
	LaunchEvent Broadcast Type = ( SubStateToExitEventMapping . <SubState> ) 
	GetTags 
	SubStateExitEventList = ( <SubStateExitEventList> - ( SubStateToExitEventMapping . <SubState> ) ) 
	SetTags SubStateExitEventList = <SubStateExitEventList> 
ENDSCRIPT

SCRIPT InitializeStateChangeEvent 
	GetTags 
	IF GotParam StateExitEvent 
		LaunchAllSubStateExitEvents NewState = Skater_None 
		LaunchEvent Broadcast Type = <StateExitEvent> 
	ENDIF 
	SetProps Remove_Tags = [ StateExitEvent ] 
	SetTags State = Skater_None SubStateExitEventList = { } 
ENDSCRIPT

SCRIPT LaunchAllSubStateExitEvents 
	GetTags 
	IF NOT GotParam SubStateExitEventList 
		RETURN 
	ENDIF 
	MaskedSubStateExitEventList = ( <SubStateExitEventList> - ( StateToSubStateExitEventMask . <NewState> ) ) 
	LaunchEvent Broadcast Type = <MaskedSubStateExitEventList> 
	SubStateExitEventList = ( <SubStateExitEventList> - <MaskedSubStateExitEventList> ) 
	SetTags SubStateExitEventList = <SubStateExitEventList> 
ENDSCRIPT

SCRIPT SkaterEventDebug 
	KillSpawnedScript Name = TestEventListener 
	SpawnScript TestEventListener 
ENDSCRIPT

SCRIPT TestEventListener 
	SetEventHandler Ex = SkaterEnterAir Scr = ReportEvent Params = { EventName = SkaterEnterAir } 
	SetEventHandler Ex = SkaterExitAir Scr = ReportEvent Params = { EventName = SkaterExitAir } 
	SetEventHandler Ex = SkaterEnterGround Scr = ReportEvent Params = { EventName = SkaterEnterGround } 
	SetEventHandler Ex = SkaterExitGround Scr = ReportEvent Params = { EventName = SkaterExitGround } 
	SetEventHandler Ex = SkaterEnterBail Scr = ReportEvent Params = { EventName = SkaterEnterBail } 
	SetEventHandler Ex = SkaterExitBail Scr = ReportEvent Params = { EventName = SkaterExitBail } 
	SetEventHandler Ex = SkaterEnterRail Scr = ReportEvent Params = { EventName = SkaterEnterRail } 
	SetEventHandler Ex = SkaterExitRail Scr = ReportEvent Params = { EventName = SkaterExitRail } 
	SetEventHandler Ex = SkaterEnterSkitch Scr = ReportEvent Params = { EventName = SkaterEnterSkitch } 
	SetEventHandler Ex = SkaterExitSkitch Scr = ReportEvent Params = { EventName = SkaterExitSkitch } 
	SetEventHandler Ex = SkaterEnterManual Scr = ReportEvent Params = { EventName = SkaterEnterManual } 
	SetEventHandler Ex = SkaterExitManual Scr = ReportEvent Params = { EventName = SkaterExitManual } 
	SetEventHandler Ex = SkaterEnterWall Scr = ReportEvent Params = { EventName = SkaterEnterWall } 
	SetEventHandler Ex = SkaterExitWall Scr = ReportEvent Params = { EventName = SkaterExitWall } 
	SetEventHandler Ex = SkaterEnterWallplant Scr = ReportEvent Params = { EventName = SkaterEnterWallplant } 
	SetEventHandler Ex = SkaterExitWallplant Scr = ReportEvent Params = { EventName = SkaterExitWallplant } 
	SetEventHandler Ex = SkaterEnterRevert Scr = ReportEvent Params = { EventName = SkaterEnterRevert } 
	SetEventHandler Ex = SkaterExitRevert Scr = ReportEvent Params = { EventName = SkaterExitRevert } 
	SetEventHandler Ex = SkaterEnterLip Scr = ReportEvent Params = { EventName = SkaterEnterLip } 
	SetEventHandler Ex = SkaterExitLip Scr = ReportEvent Params = { EventName = SkaterExitLip } 
	SetEventHandler Ex = SkaterEnterLadder Scr = ReportEvent Params = { EventName = SkaterEnterLadder } 
	SetEventHandler Ex = SkaterExitLadder Scr = ReportEvent Params = { EventName = SkaterExitLadder } 
	SetEventHandler Ex = SkaterEnterHang Scr = ReportEvent Params = { EventName = SkaterEnterHang } 
	SetEventHandler Ex = SkaterExitHang Scr = ReportEvent Params = { EventName = SkaterExitHang } 
	SetEventHandler Ex = SkaterEnterEndOfRun Scr = ReportEvent Params = { EventName = SkaterEnterEndOfRun } 
	SetEventHandler Ex = SkaterExitEndOfRun Scr = ReportEvent Params = { EventName = SkaterExitEndOfRun } 
	SetEventHandler Ex = SkaterEnterFlip Scr = ReportEvent Params = { EventName = SkaterEnterFlip } 
	SetEventHandler Ex = SkaterExitFlip Scr = ReportEvent Params = { EventName = SkaterExitFlip } 
	SetEventHandler Ex = SkaterEnterGrab Scr = ReportEvent Params = { EventName = SkaterEnterGrab } 
	SetEventHandler Ex = SkaterExitGrab Scr = ReportEvent Params = { EventName = SkaterExitGrab } 
	SetEventHandler Ex = SkaterEnterTransfer Scr = ReportEvent Params = { EventName = SkaterEnterTransfer } 
	SetEventHandler Ex = SkaterExitTransfer Scr = ReportEvent Params = { EventName = SkaterExitTransfer } 
	SetEventHandler Ex = SkaterEnterAcidDrop Scr = ReportEvent Params = { EventName = SkaterEnterAcidDrop } 
	SetEventHandler Ex = SkaterExitAcidDrop Scr = ReportEvent Params = { EventName = SkaterExitAcidDrop } 
	SetEventHandler Ex = SkaterLanded Scr = ReportEvent Params = { EventName = SkaterLanded } 
	SetEventHandler Ex = SkaterBailed Scr = ReportEvent Params = { EventName = SkaterBailed } 
	SetEventHandler Ex = SkaterTrickDisplayed Scr = ReportEvent Params = { EventName = SkaterTrickDisplayed } 
	SetEventHandler Ex = SkaterSpinDisplayed Scr = ReportEvent Params = { EventName = SkaterSpinDisplayed } 
	SetEventHandler Ex = SkaterEnterCombo Scr = ReportEvent Params = { EventName = SkaterEnterCombo } 
	SetEventHandler Ex = SkaterExitCombo Scr = ReportEvent Params = { EventName = SkaterExitCombo } 
	SetEventHandler Ex = SkaterJump Scr = ReportEvent Params = { EventName = SkaterJump } 
	SetEventHandler Ex = SkaterOffEdge Scr = ReportEvent Params = { EventName = SkaterOffEdge } 
	SetEventHandler Ex = SkaterWallplant Scr = ReportEvent Params = { EventName = SkaterWallplant } 
	SetEventHandler Ex = SkaterWallpush Scr = ReportEvent Params = { EventName = SkaterWallpush } 
	SetEventHandler Ex = SkaterPointRail Scr = ReportEvent Params = { EventName = SkaterPointRail } 
	SetEventHandler Ex = SkaterEnterSkating Scr = ReportEvent Params = { EventName = SkaterEnterSkating } 
	SetEventHandler Ex = SkaterExitSkating Scr = ReportEvent Params = { EventName = SkaterExitSkating } 
	SetEventHandler Ex = SkaterEnterWalking Scr = ReportEvent Params = { EventName = SkaterEnterWalking } 
	SetEventHandler Ex = SkaterExitWalking Scr = ReportEvent Params = { EventName = SkaterExitWalking } 
	SetEventHandler Ex = SkaterEnterNollie Scr = ReportEvent Params = { EventName = SkaterEnterNollie } 
	SetEventHandler Ex = SkaterExitNollie Scr = ReportEvent Params = { EventName = SkaterExitNollie } 
	SetEventHandler Ex = SkaterEnterPressure Scr = ReportEvent Params = { EventName = SkaterEnterPressure } 
	SetEventHandler Ex = SkaterExitPressure Scr = ReportEvent Params = { EventName = SkaterExitPressure } 
	SetEventHandler Ex = SkaterEnterVertAir Scr = ReportEvent Params = { EventName = SkaterEnterVertAir } 
	SetEventHandler Ex = SkaterExitVertAir Scr = ReportEvent Params = { EventName = SkaterExitVertAir } 
	SetEventHandler Ex = SkaterEnterSpecial Scr = ReportEvent Params = { EventName = SkaterEnterSpecial } 
	SetEventHandler Ex = SkaterExitSpecial Scr = ReportEvent Params = { EventName = SkaterExitSpecial } 
	Block 
ENDSCRIPT

SCRIPT ReportEvent 
	printf "=++ Event: %a" a = <EventName> 
ENDSCRIPT


