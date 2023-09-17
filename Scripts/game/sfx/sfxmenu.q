SCRIPT SkipTrack 
	SkipMusicTrack 
ENDSCRIPT

SCRIPT SetCDToMusic 
	SetMusicMode 1 
ENDSCRIPT

SCRIPT SetCDToAmbience 
	SetMusicMode 0 
ENDSCRIPT

SCRIPT PlaySongsRandomly 
	SetRandomMode 1 
ENDSCRIPT

SCRIPT PlaySongsInOrder 
	SetRandomMode 0 
ENDSCRIPT

SCRIPT set_sound_level_slider 
	VerifyParam param = id func = set_sound_level_slider <...> 
	SetVolumeFromValue id = <id> <whichParam> 
ENDSCRIPT

SCRIPT play_sound_on_sfx_volume_adjustment 
	PlaySound HUD_specialtrickAA 
ENDSCRIPT

