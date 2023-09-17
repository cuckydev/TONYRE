
DefaultMovingObjectSuspendDistance = 80 
X_AXIS = 1 
Y_AXIS = 2 
Z_AXIS = 4 
XY_AXIS = 3 
XZ_AXIS = 5 
YZ_AXIS = 6 
BOUNCEOBJ_REST_TOP_OR_BOTTOM = 1 
BOUNCEOBJ_REST_ANY_SIDE = 2 
BOUNCEOBJ_REST_TRAFFIC_CONE = 3 
GameObjExceptions = 
[ 
	SkaterLanded 
	SkaterBailed 
	SkaterInRadius 
	SkaterOutOfRadius 
	AnySkaterInRadius 
] 
CarExceptions = 
[ 
	SkaterInRadius 
	SkaterOutOfRadius 
] 
BouncyObjExceptions = 
[ 
	SkaterInRadius 
	SkaterOutOfRadius 
	Bounce 
	DoneBouncing 
] 
SCRIPT Obj_WaitPlayerDist interval = 3 
	BEGIN 
		IF Obj_ObjectInRadius radius = <radius> type = skater 
			BREAK 
		ELSE 
			wait <interval> gameframes 
		ENDIF 
	REPEAT 
ENDSCRIPT

SCRIPT Obj_CycleAnim numCycles = 1 
	BEGIN 
		Obj_PlayAnim <...> 
		Obj_WaitAnimFinished 
	REPEAT <numCycles> 
ENDSCRIPT

SCRIPT GetGap 
	StartGap GapID = GetGap_DefaultID Flags = <Flags> TrickText = <TrickText> TrickScript = <TrickScript> 
	EndGap GapID = GetGap_DefaultID Score = <Score> Text = <Text> GapScript = <GapScript> 
ENDSCRIPT

SCRIPT EmptyScript 
ENDSCRIPT

SCRIPT DefaultAvoidSkater 
	AvoidSkater 
ENDSCRIPT


