
PressureTricks2 = [ 
	{ Trigger = { AirTrickLogic , Square , Up , 300 } Trick_BS360PressureFlip } 
	{ Trigger = { AirTrickLogic , Square , Down , 300 } Trick_FS360PressureFlip } 
	{ Trigger = { AirTrickLogic , Square , Right , 300 } Trick_BS180PressureFlip } 
	{ Trigger = { AirTrickLogic , Square , Left , 300 } Trick_BSToeFlip } 
] 
Trick_PressureFlip = { Scr = FlipTrick Params = { Name = #"\\c2Pressure Flip\\c0" Ollie Speed = 1.50000000000 Score = 100 Anim = _360Flip } } 
Trick_PressureFlip2 = { Scr = FlipTrick Params = { Name = #"\\c2Pressure Flip\\c0" Speed = 1.50000000000 Score = 100 Anim = _360Flip } } 
Trick_BS180PressureFlip = { Scr = FlipTrick Params = { Name = #"BS 180 Flip" Score = 100 Anim = BS180PressureFlip BoardRotate FlipAfter } } 
Trick_BSToeFlip = { Scr = FlipTrick Params = { Name = #"BS Toe Flip " Score = 100 Anim = BSToeFlip BoardRotate } } 
Trick_BS360PressureFlip = { Scr = FlipTrick Params = { Name = #"BS 360 Flip" Score = 200 Anim = BS360PressureFlip } } 
Trick_FS360PressureFlip = { Scr = FlipTrick Params = { Name = #"FS 360 Flip" Score = 200 Anim = FS360PressureFlip } } 

