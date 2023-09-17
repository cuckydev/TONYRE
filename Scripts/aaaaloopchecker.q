
DoNotAssertForInfiniteLoopsInTheseScripts = 
[ 
	Ped_Assert 
	AVOIDSTATE_STOP 
	Ped_RandomWaitAtNode01 
] 
BlockingFunctions = 
[ 
	wait 
	Obj_WaitAnimFinished 
	Obj_WaitMove 
	Obj_WaitRotate 
	WaitAnimWalking 
	WaitOneGameFrame 
	WaitAnimFinished 
	Obj_cycleAnim 
	DoMorph 
	GoalInit_PlayAnim 
	fadein_fadeout 
	WaitForEvent 
	WaitWalkingFrame 
	WaitAnimWalkingFrame 
] 

