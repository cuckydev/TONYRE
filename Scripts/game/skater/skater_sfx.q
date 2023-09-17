
MusicVolume = 60 
MusicStreamVolume = 100 
SCRIPT LoadPermSounds 
	LoadPermSFX 
	LoadPermSongs 
ENDSCRIPT

SCRIPT LoadPermSFX 
	LoadPreFile "skater_sounds.pre" 
	LoadSound "Skater\\foleymove01" FLAG_PERM vol = 50 
	LoadSound "Skater\\hitblood01" FLAG_PERM vol = 50 
	LoadSound "Skater\\hitblood02" FLAG_PERM vol = 50 
	LoadSound "Skater\\hitblood03" FLAG_PERM vol = 50 
	LoadSound "Skater\\Bails\\BailBodyPunch01_11" FLAG_PERM vol = 100 
	LoadSound "Skater\\Bails\\BailBodyPunch02_11" FLAG_PERM vol = 100 
	LoadSound "Skater\\Bails\\BailBodyPunch03_11" FLAG_PERM vol = 100 
	LoadSound "Skater\\Bails\\BailBodyPunch04_11" FLAG_PERM vol = 100 
	LoadSound "Skater\\Bails\\BailBodyPunch05_11" FLAG_PERM vol = 100 
	LoadSound "Skater\\Bails\\BailBodyFall01" FLAG_PERM vol = 100 
	LoadSound "Skater\\Bails\\BailBodyFall02" FLAG_PERM vol = 100 
	LoadSound "Skater\\Bails\\BailBodyFall03" FLAG_PERM vol = 100 
	LoadSound "Skater\\Bails\\BailBodyFall04" FLAG_PERM vol = 100 
	LoadSound "Skater\\Bails\\BailBodyFall05" FLAG_PERM vol = 100 
	LoadSound "Skater\\Bails\\BailCrack01" FLAG_PERM vol = 100 
	LoadSound "Skater\\Bails\\BailSlap01" FLAG_PERM vol = 100 
	LoadSound "Skater\\Bails\\BailSlap02" FLAG_PERM vol = 100 
	LoadSound "Skater\\Bails\\BailSlap03" FLAG_PERM vol = 100 
	LoadSound "Skater\\Bails\\BailScrape01" FLAG_PERM vol = 100 
	LoadSound "Skater\\Bails\\BailScrape02" FLAG_PERM vol = 100 
	LoadSound "Skater\\Bails\\BailScrape03" FLAG_PERM vol = 100 
	LoadSound "Skater\\Bails\\BailBoard01" FLAG_PERM vol = 100 
	LoadSound "Skater\\Bails\\BailBoard02" FLAG_PERM vol = 100 
	LoadSound "Skater\\Bails\\BailBoard03" FLAG_PERM vol = 100 
	LoadSound "Skater\\Bails\\BailBoard04" FLAG_PERM vol = 100 
	LoadSound "Skater\\Bails\\BailBoard05" FLAG_PERM vol = 100 
	LoadSound "Skater\\Walking\\WalkStepConc01_11" FLAG_PERM vol = 100 
	LoadSound "Skater\\Walking\\WalkStepConc03_11" FLAG_PERM vol = 100 
	LoadSound "Skater\\Walking\\WalkStepConc05_11" FLAG_PERM vol = 100 
	LoadSound "Skater\\Walking\\RunStepConc01" FLAG_PERM vol = 100 
	LoadSound "Skater\\Walking\\RunStepConc02" FLAG_PERM vol = 100 
	LoadSound "Skater\\Walking\\RunStepConc03" FLAG_PERM vol = 100 
	LoadSound "Skater\\Walking\\RunStepConc04" FLAG_PERM vol = 100 
	LoadSound "Skater\\Walking\\RunStepConc05" FLAG_PERM vol = 100 
	LoadSound "Skater\\Walking\\ScuffStepConc01" FLAG_PERM vol = 100 
	LoadSound "Skater\\Walking\\ScuffStepConc02" FLAG_PERM vol = 100 
	LoadSound "Skater\\Walking\\JumpStepConc01" FLAG_PERM vol = 100 
	LoadSound "Skater\\Walking\\LandStepConc02" FLAG_PERM vol = 100 
	LoadSound "Shared\\Menu\\menu03" FLAG_PERM NOREVERB 
	LoadSound "Shared\\Menu\\PauseExit" FLAG_PERM vol = 100 NOREVERB 
	LoadSound "Shared\\Menu\\GUI_buzzer01" FLAG_PERM vol = 100 NOREVERB 
	LoadSound "Shared\\Menu\\MenuUp" FLAG_PERM NOREVERB 
	LoadSound "Shared\\Menu\\DE_IconTurnZoom" FLAG_PERM NOREVERB 
	LoadSound "Shared\\Menu\\DE_MenuFlyUp" FLAG_PERM NOREVERB 
	LoadSound "Shared\\Menu\\DE_MenuSelect" FLAG_PERM NOREVERB 
	LoadSound "Shared\\Menu\\DE_PauseFlyIn" FLAG_PERM NOREVERB 
	LoadSound "Shared\\Menu\\DE_MenuBack" FLAG_PERM NOREVERB 
	LoadSound "Skater\\boneless09" FLAG_PERM 
	LoadSound "Skater\\copinghit3_11" FLAG_PERM vol = 100 
	LoadSound "Shared\\Menu\\timeoutA" FLAG_PERM vol = 50 NOREVERB 
	LoadSound "Shared\\Goals\\GapSound" FLAG_PERM vol = 100 dropoff = 0 NOREVERB 
	LoadSound "Shared\\Goals\\GoalDone" FLAG_PERM vol = 100 dropoff = 0 NOREVERB 
	LoadSound "Shared\\Goals\\TetrisAway" FLAG_PERM NOREVERB 
	LoadSound "Shared\\Goals\\GoalGood02" FLAG_PERM NOREVERB 
	LoadSound "Shared\\Goals\\GoalFail" FLAG_PERM NOREVERB 
	LoadSound "Shared\\Goals\\GoalMidGood" FLAG_PERM NOREVERB 
	LoadSound "Shared\\Goals\\ExtraTrick" FLAG_PERM NOREVERB 
	LoadSound "Shared\\Goals\\PerfectLanding" FLAG_PERM NOREVERB 
	LoadSound "Shared\\Goals\\HUDtrickslopC" FLAG_PERM NOREVERB 
	LoadSound "Shared\\Goals\\HUD_jumpgap" FLAG_PERM NOREVERB 
	LoadSound "Shared\\Goals\\HUD_specialtrickAA" FLAG_PERM NOREVERB 
	LoadSound "Shared\\Goals\\LandCombo01" FLAG_PERM NOREVERB 
	LoadSound "Shared\\Goals\\GotStat04" FLAG_PERM NOREVERB 
	LoadSound "Skater\\BoardBounce01" FLAG_PERM 
	LoadSound "Shared\\Misc\\FlipTransitionUp01" FLAG_PERM 
	LoadSound "Shared\\Misc\\FlipTransitionDown01" FLAG_PERM 
	LoadSound "Shared\\Goals\\ClockTickUp" FLAG_PERM NOREVERB 
	LoadSound "Shared\\Goals\\ClockTickDown" FLAG_PERM NOREVERB 
	LoadSound "Shared\\Goals\\FlamingFireBall01" FLAG_PERM 
	UnloadPreFile "skater_sounds.pre" 
ENDSCRIPT

locked_track1 = 33 
locked_track2 = 34 
SCRIPT LoadPermSongs 
	IF ( ( isTrue TestMusicFromHost ) | ( CD ) ) 
		LoadMusicHeader "music\\music" 
		GetArraySize playlist_tracks 
		index = 0 
		BEGIN 
			path = ( ( playlist_tracks [ <index> ] ) . path ) 
			FormatText textname = tracktitle "%b: %t" b = ( ( playlist_tracks [ <index> ] ) . band ) t = ( ( playlist_tracks [ <index> ] ) . track_title ) 
			AddMusicTrack <path> FLAG_PERM tracktitle = <tracktitle> 
			index = ( <index> + 1 ) 
		REPEAT <array_size> 
		IF NOT GetGlobalFlag flag = KISS_SONGS_UNLOCKED 
			ChangeTrackState locked_track1 off 
			ChangeTrackState locked_track2 off 
		ENDIF 
	ENDIF 
ENDSCRIPT

playlist_tracks = [ 
	{ band = "Aceyalone" track_title = "Rapps on Deck" genre = 1 path = "music\\vag\\songs\\Aceyalone" } 
	{ band = "Alkaline Trio" track_title = "Armageddon" genre = 0 path = "music\\vag\\songs\\Alkaline" } 
	{ band = "Anacron" track_title = "A Prototype" genre = 1 path = "music\\vag\\songs\\Anacron" } 
	{ band = "Angry Amputees" track_title = "She Said" genre = 0 path = "music\\vag\\songs\\AngryAmp" } 
	{ band = "Assorted Jelly Beans" track_title = "Rebel Yell" genre = 0 path = "music\\vag\\songs\\Assorted" } 
	{ band = "Authority Zero" track_title = "Everyday" genre = 2 path = "music\\vag\\songs\\AuthorityZ" } 
	{ band = "Bad Religion" track_title = "Big Bang" genre = 0 path = "music\\vag\\songs\\BadReligion" } 
	{ band = "Blind Iris" track_title = "Drive" genre = 2 path = "music\\vag\\songs\\BlindIris" } 
	{ band = "Blue Collar Special" track_title = "Don\'t Wait" genre = 0 path = "music\\vag\\songs\\BlueCollar" } 
	{ band = "Bracket" track_title = "2 Rak 005" genre = 0 path = "music\\vag\\songs\\Bracket" } 
	{ band = "Busdriver" track_title = "Imaginary Places" genre = 1 path = "music\\vag\\songs\\Busdriver" } 
	{ band = "CamaroSmith" track_title = "It\'s Alright" genre = 2 path = "music\\vag\\songs\\CamaroSmith" } 
	{ band = "Cannibal Ox" track_title = "Iron Galaxy" genre = 1 path = "music\\vag\\songs\\Cannibal" } 
	{ band = "Clutch" track_title = "Impetus" genre = 2 path = "music\\vag\\songs\\Clutch" } 
	{ band = "Crash and Burn" track_title = "Crazy and Stupid" genre = 2 path = "music\\vag\\songs\\CrashBurn" } 
	{ band = "Dan the Automator" track_title = "A Better Tomorrow" genre = 1 path = "music\\vag\\songs\\DanAuto" } 
	{ band = "Deltron 3030" track_title = "Positive Contact" genre = 1 path = "music\\vag\\songs\\Deltron" } 
	{ band = "DJ Qbert" track_title = "Cosmic Assassins" genre = 1 path = "music\\vag\\songs\\DJQbert" } 
	{ band = "Dropkick Murphys" track_title = "Time To Go" genre = 0 path = "music\\vag\\songs\\DropkickM" } 
	{ band = "Electric Frankenstein" track_title = "Annies Grave" genre = 2 path = "music\\vag\\songs\\ElectricF" } 
	{ band = "Entombed" track_title = "To Ride, Shoot, Speak..." genre = 2 path = "music\\vag\\songs\\Entombed" } 
	{ band = "Five Horse Johnson" track_title = "Mississippi King" genre = 2 path = "music\\vag\\songs\\FiveHorse" } 
	{ band = "Flamethrower" track_title = "I Want it All" genre = 0 path = "music\\vag\\songs\\FlameThrower" } 
	{ band = "Frog One" track_title = "Blah Blah" genre = 1 path = "music\\vag\\songs\\FrogOne" } 
	{ band = "Fu Manchu" track_title = "California Crossing" genre = 2 path = "music\\vag\\songs\\FuManchu" } 
	{ band = "GBH" track_title = "Crush \'Em" genre = 0 path = "music\\vag\\songs\\GBH" } 
	{ band = "High on Fire" track_title = "Hung, Drawn and Quartered" genre = 2 path = "music\\vag\\songs\\HighFire" } 
	{ band = "Hot Water Music" track_title = "Remedy" genre = 2 path = "music\\vag\\songs\\HotWater" } 
	{ band = "In Flames" track_title = "Embody the Invisible" genre = 2 path = "music\\vag\\songs\\InFlames" } 
	{ band = "J-Live" track_title = "Braggin\' Writes Revisited" genre = 1 path = "music\\vag\\songs\\JLive" } 
	{ band = "Jane\'s Addiction" track_title = "Suffer Some" genre = 2 path = "music\\vag\\songs\\JanesA" } 
	{ band = "Juggaknots" track_title = "The Circle Pt. 1" genre = 1 path = "music\\vag\\songs\\Juggaknots" } 
	{ band = "Jurassic 5" track_title = "A Day at the Races" genre = 1 path = "music\\vag\\songs\\Jurassic" } 
	{ band = "Kiss" track_title = "God of Thunder" genre = 2 path = "music\\vag\\songs\\KissThunder" } 
	{ band = "Kiss" track_title = "Lick It Up" genre = 2 path = "music\\vag\\songs\\KissLick" } 
	{ band = "Kiss" track_title = "Rock-N-Roll All Night" genre = 2 path = "music\\vag\\songs\\KissRockNRoll" } 
	{ band = "Lamont" track_title = "Hotwire" genre = 2 path = "music\\vag\\songs\\Lamont" } 
	{ band = "L A Symphony" track_title = "King Kong" genre = 1 path = "music\\vag\\songs\\LASymph" } 
	{ band = "Living Legends" track_title = "War Games" genre = 1 path = "music\\vag\\songs\\LivingL" } 
	{ band = "Mastodon" track_title = "Crusher Destroyer" genre = 2 path = "music\\vag\\songs\\Mastadon" } 
	{ band = "Mike V and the Rats" track_title = "The Days" genre = 0 path = "music\\vag\\songs\\MikeV" } 
	{ band = "Mr Complex" track_title = "Underground Up" genre = 1 path = "music\\vag\\songs\\MrComplex" } 
	{ band = "Mr Dibbs" track_title = "Skin Therapy" genre = 1 path = "music\\vag\\songs\\MrDibbs" } 
	{ band = "Mr Lif" track_title = "Phantom" genre = 1 path = "music\\vag\\songs\\MrLif" } 
	{ band = "Murs" track_title = "Transitions as a Ridah" genre = 1 path = "music\\vag\\songs\\Murs" } 
	{ band = "NAS" track_title = "The World is Yours" genre = 1 path = "music\\vag\\songs\\NAS" } 
	{ band = "Nine Pound Hammer" track_title = "Run Fat Boy Run" genre = 2 path = "music\\vag\\songs\\NinePound" } 
	{ band = "NOFX" track_title = "Separation of Church and Skate" genre = 0 path = "music\\vag\\songs\\NOFX" } 
	{ band = "Orange Goblin" track_title = "Your World Will Hate This" genre = 2 path = "music\\vag\\songs\\OrangeG" } 
	{ band = "Paint It Black" track_title = "Womb Envy" genre = 0 path = "music\\vag\\songs\\PaintBlack" } 
	{ band = "P.U.T.S." track_title = "The Next Step II" genre = 1 path = "music\\vag\\songs\\PeopleStairs" } 
	{ band = "Q.O.T.S.A." track_title = "Millionaire" genre = 2 path = "music\\vag\\songs\\Queens" } 
	{ band = "Quasimoto" track_title = "Low Class Conspiracy" genre = 1 path = "music\\vag\\songs\\Quasimoto" } 
	{ band = "RA the Ruggedman" track_title = "King of the Underground" genre = 1 path = "music\\vag\\songs\\Ruggedman" } 
	{ band = "Refused" track_title = "New Noise" genre = 0 path = "music\\vag\\songs\\Refused" } 
	{ band = "Rise Against" track_title = "Like the Angels" genre = 0 path = "music\\vag\\songs\\RiseAgainst" } 
	{ band = "Rubber City Rebels" track_title = "(I Wanna) Pierce My Brain" genre = 0 path = "music\\vag\\songs\\RubberCity" } 
	{ band = "SoD" track_title = "Milk" genre = 2 path = "music\\vag\\songs\\StormDeath" } 
	{ band = "Solace" track_title = "Indolence" genre = 2 path = "music\\vag\\songs\\Solace" } 
	{ band = "Smoke Blow" track_title = "Circle of Fear" genre = 2 path = "music\\vag\\songs\\SmokeBlow" } 
	{ band = "Social Distortion" track_title = "Mommy\'s Little Monster" genre = 0 path = "music\\vag\\songs\\SocialD" } 
	{ band = "Stiff Little Fingers" track_title = "Suspect Device" genre = 0 path = "music\\vag\\songs\\Stiff" } 
	{ band = "Strike Anywhere" track_title = "Refusal" genre = 0 path = "music\\vag\\songs\\StrikeA" } 
	{ band = "Sublime" track_title = "Seed" genre = 0 path = "music\\vag\\songs\\Sublime" } 
	{ band = "Superjoint Ritual" track_title = "It Takes No Guts" genre = 2 path = "music\\vag\\songs\\Superjoint" } 
	{ band = "Supernatural" track_title = "Internationally Known" genre = 1 path = "music\\vag\\songs\\Supernatural" } 
	{ band = "The Adicts" track_title = "Viva La Revolution" genre = 0 path = "music\\vag\\songs\\TheAdicts" } 
	{ band = "The Browns" track_title = "American Werewolf in Calgary" genre = 0 path = "music\\vag\\songs\\TheBrowns" } 
	{ band = "The Clash" track_title = "White Riot" genre = 0 path = "music\\vag\\songs\\TheClash" } 
	{ band = "The Explosion" track_title = "No Revolution" genre = 2 path = "music\\vag\\songs\\TheExplosion" } 
	{ band = "The Hellacopters" track_title = "(Gotta Get Some Action) Now!" genre = 2 path = "music\\vag\\songs\\Hellacopters" } 
	{ band = "The Herbaliser" track_title = "It Ain\'t Nuttin\'" genre = 1 path = "music\\vag\\songs\\TheHerb" } 
	{ band = "The Hookers" track_title = "The Legend of Black Thunder" genre = 2 path = "music\\vag\\songs\\TheHookers" } 
	{ band = "The Midnight Evils" track_title = "Loaded and Lonely" genre = 0 path = "music\\vag\\songs\\MidnightE" } 
	{ band = "Transplants" track_title = "California Babylon" genre = 0 path = "music\\vag\\songs\\Transplants" } 
	{ band = "Unida" track_title = "Black Woman" genre = 2 path = "music\\vag\\songs\\Unida" } 
	{ band = "Wildchild" track_title = "Secondary Protocol" genre = 1 path = "music\\vag\\songs\\Wildchild" } 
] 
StreamPriorityLow = 10 
StreamPriorityLowMid = 30 
StreamPriorityMid = 50 
StreamPriorityMidHigh = 70 
StreamPriorityHigh = 90 
StreamPriorityHighest = 100 
SCRIPT stat_goal_appear 
	PlaySound menu03 pitch = 50 volL = 160 volR = 80 
	wait 0.08900000155 seconds 
	PlaySound menu03 pitch = 62.99599838257 volL = 160 volR = 80 
	wait 0.08900000155 seconds 
	PlaySound menu03 pitch = 74.91500091553 volL = 160 volR = 80 
	wait 0.08900000155 seconds 
	PlaySound menu03 pitch = 100 volL = 160 volR = 80 
ENDSCRIPT

SCRIPT stat_goal_success 
	PlaySound GotStat04 vol = 150 
ENDSCRIPT

SCRIPT found_gap_success_sound 
	PlaySound DE_PauseFlyIn pitch = 200 
	wait 1.79999995232 seconds 
	found_gap_away_sound 
ENDSCRIPT

SCRIPT found_gap_away_sound 
	PlaySound DE_PauseFlyIn pitch = 180 vol = 80 
ENDSCRIPT

SCRIPT LandPointsSound 
	PlaySound LandCombo01 vol = 250 
	PlaySound DE_IconTurnZoom vol = 100 
	PlaySound DE_MenuFlyup 
ENDSCRIPT

Paused_Light_Rain = 0 
Paused_Heavy_Rain = 0 
Inside_Light_Rain = 0 
Inside_Heavy_Rain = 0 
LightRainVolume = 100 
MediumRainVolume = 66 
SCRIPT Light_Rain_SFX_On 
	IF NOT IsSoundPlaying TestLight01 
		IF NOT IsSoundPlaying TestLight02 
			printf "*********TURNING LIGHT RAIN SFX ON - DO NOT TURN ON AGAIN BEFORE STOPPING!********" 
			PlaySound Weather_Rain_Light01 vol = LightRainVolume id = TestLight01 
			change Inside_Light_Rain = 0 
		ENDIF 
	ENDIF 
ENDSCRIPT

SCRIPT Light_Rain_SFX_Off 
	printf "*********STOPPING LIGHT RAIN SFX OFF!********" 
	StopSound TestLight01 
	change Paused_Light_Rain = 0 
ENDSCRIPT

SCRIPT Heavy_Rain_SFX_On 
	printf "*********TURNING LIGHT and MEDIUM RAIN SFX ON - DO NOT TURN ON AGAIN BEFORE STOPPING!********" 
	IF NOT IsSoundPlaying TestLight02 
		IF NOT IsSoundPlaying TestLight01 
			printf "*********TURNING LIGHT RAIN SFX ON - DO NOT TURN ON AGAIN BEFORE STOPPING!********" 
			PlaySound Weather_Rain_Light01 vol = LightRainVolume id = TestLight02 
			change Inside_Heavy_Rain = 0 
		ENDIF 
	ENDIF 
	IF NOT IsSoundPlaying TestMedium02 
		printf "*********TURNING MEDIUM RAIN SFX ON - DO NOT TURN ON AGAIN BEFORE STOPPING!********" 
		PlaySound Weather_Rain_Medium01 vol = MediumRainVolume id = TestMedium02 
	ENDIF 
ENDSCRIPT

SCRIPT Heavy_Rain_SFX_Off 
	printf "*********STOPPING HEAVY RAIN SFX OFF!********" 
	StopSound TestLight02 
	StopSound TestMedium02 
	change Paused_Light_Rain = 0 
ENDSCRIPT

SCRIPT wait_and_start_rain 
	SWITCH <type> 
		CASE 1 
			BEGIN 
				wait 1 
				IF NOT IsSoundPlaying TestLight01 
					BREAK 
				ENDIF 
			REPEAT 
			Light_Rain_SFX_On 
			change Paused_Light_Rain = 0 
		CASE 2 
			BEGIN 
				wait 1 
				IF NOT IsSoundPlaying TestLight02 
					BREAK 
				ENDIF 
			REPEAT 
			BEGIN 
				wait 1 
				IF NOT IsSoundPlaying TestMedium02 
					BREAK 
				ENDIF 
			REPEAT 
			Heavy_Rain_SFX_On 
			change Paused_Heavy_Rain = 0 
	ENDSWITCH 
	printf <type> 
	KillSpawnedScript type = wait_and_start_rain 
ENDSCRIPT

SCRIPT Ped_Skater_Grind_Bail_Sound 
	Temp_Ped_Fall_Sound 
	wait 0.50000000000 seconds 
	RANDOM_NO_REPEAT(1, 1, 1, 1, 1) 
		RANDOMCASE Obj_PlaySound BailBoard01 pitch = RANDOM_RANGE PAIR(100.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(40.00000000000, 50.00000000000) 
		RANDOMCASE Obj_PlaySound BailBoard02 pitch = RANDOM_RANGE PAIR(100.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(40.00000000000, 50.00000000000) 
		RANDOMCASE Obj_PlaySound BailBoard03 pitch = RANDOM_RANGE PAIR(100.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(40.00000000000, 50.00000000000) 
		RANDOMCASE Obj_PlaySound BailBoard04 pitch = RANDOM_RANGE PAIR(100.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(40.00000000000, 50.00000000000) 
		RANDOMCASE Obj_PlaySound BailBoard05 pitch = RANDOM_RANGE PAIR(100.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(40.00000000000, 50.00000000000) 
	RANDOMEND 
	RANDOM_NO_REPEAT(1, 1, 1, 1, 1) 
		RANDOMCASE Obj_PlaySound BailBodyFall01 pitch = RANDOM_RANGE PAIR(95.00000000000, 105.00000000000) vol = RANDOM_RANGE PAIR(60.00000000000, 80.00000000000) 
		RANDOMCASE Obj_PlaySound BailBodyFall02 pitch = RANDOM_RANGE PAIR(95.00000000000, 105.00000000000) vol = RANDOM_RANGE PAIR(60.00000000000, 80.00000000000) 
		RANDOMCASE Obj_PlaySound BailBodyFall03 pitch = RANDOM_RANGE PAIR(95.00000000000, 105.00000000000) vol = RANDOM_RANGE PAIR(60.00000000000, 80.00000000000) 
		RANDOMCASE Obj_PlaySound BailBodyFall04 pitch = RANDOM_RANGE PAIR(95.00000000000, 105.00000000000) vol = RANDOM_RANGE PAIR(60.00000000000, 80.00000000000) 
		RANDOMCASE Obj_PlaySound BailBodyFall05 pitch = RANDOM_RANGE PAIR(95.00000000000, 105.00000000000) vol = RANDOM_RANGE PAIR(60.00000000000, 80.00000000000) 
	RANDOMEND 
ENDSCRIPT

SCRIPT Firefight_LaunchFireball_Sound 
ENDSCRIPT

SCRIPT Firefight_DeathFireball_Sound 
	printf "******MIGHT PLAY FIREBALL DEATH STREAM HERE!********" 
ENDSCRIPT

SCRIPT Temp_Ped_Fall_Sound 
	RANDOM_NO_REPEAT(1, 1, 1, 1, 1) 
		RANDOMCASE Obj_PlaySound BailBodyPunch01_11 pitch = RANDOM_RANGE PAIR(80.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(100.00000000000, 120.00000000000) 
		RANDOMCASE Obj_PlaySound BailBodyPunch02_11 pitch = RANDOM_RANGE PAIR(80.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(100.00000000000, 120.00000000000) 
		RANDOMCASE Obj_PlaySound BailBodyPunch03_11 pitch = RANDOM_RANGE PAIR(80.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(100.00000000000, 120.00000000000) 
		RANDOMCASE Obj_PlaySound BailBodyPunch04_11 pitch = RANDOM_RANGE PAIR(80.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(100.00000000000, 120.00000000000) 
		RANDOMCASE Obj_PlaySound BailBodyPunch05_11 pitch = RANDOM_RANGE PAIR(80.00000000000, 102.00000000000) vol = RANDOM_RANGE PAIR(100.00000000000, 120.00000000000) 
	RANDOMEND 
	RANDOM_NO_REPEAT(1, 1, 1) 
		RANDOMCASE Obj_PlaySound BailSlap01 pitch = RANDOM_RANGE PAIR(95.00000000000, 115.00000000000) vol = RANDOM_RANGE PAIR(100.00000000000, 120.00000000000) 
		RANDOMCASE Obj_PlaySound BailSlap02 pitch = RANDOM_RANGE PAIR(95.00000000000, 115.00000000000) vol = RANDOM_RANGE PAIR(100.00000000000, 120.00000000000) 
		RANDOMCASE Obj_PlaySound BailSlap03 pitch = RANDOM_RANGE PAIR(95.00000000000, 115.00000000000) vol = RANDOM_RANGE PAIR(100.00000000000, 120.00000000000) 
	RANDOMEND 
ENDSCRIPT

SCRIPT Goal_Success_Message_Sound 
	PlaySound GoalGood02 vol = 250 
	PlayStream GoalSuccessStream priority = StreamPriorityHighest 
ENDSCRIPT

SCRIPT Jamie_JumpSounds 
	wait 10 frames 
	IF ProfileEquals is_named = thomas 
		IF AnimEquals MightAsWellJump_Init 
			PlayStream RANDOM(1, 1, 1, 1) RANDOMCASE jamie_special01 RANDOMCASE jamie_special02 RANDOMCASE jamie_special03 RANDOMCASE jamie_special04 RANDOMEND vol = 300 
		ENDIF 
	ENDIF 
	wait 20 frames 
	Obj_PlaySound RANDOM(1, 1) RANDOMCASE BailSlap02 RANDOMCASE BailSlap03 RANDOMEND 
ENDSCRIPT

SCRIPT Jamie_HeroSounds 
	printf "got launched" 
	wait 1 frames 
	PlayStream RANDOM(1, 1) RANDOMCASE thomas_special05 RANDOMCASE thomas_special06 RANDOMEND 
ENDSCRIPT


