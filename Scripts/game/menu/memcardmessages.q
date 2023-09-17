
SCRIPT (create_dialog_box_with_wait) 
	IF ( (no_load) = 0 ) 
		(memcard_menus_cleanup) 
	ELSE 
		<no_bg> = (no_bg) 
	ENDIF 
	(create_snazzy_dialog_box) { <...> (no_animate) } 
	(change) (check_for_unplugged_controllers) = 0 
	(DisableReset) 
	(EnableReset) 
	(change) (check_for_unplugged_controllers) = 1 
ENDSCRIPT

SCRIPT (mcmess_CheckingCard) 
	(GetPlatform) 
	SWITCH <Platform> 
		CASE (ps2) 
			(create_dialog_box_with_wait) { 
				(title) = #"Checking ..." 
				(text) = #"Checking memory card (8MB) (for PlayStation\xAE2) in MEMORY CARD slot 1. Do not remove memory card (8MB) (for PlayStation\xAE2), controller, or reset/switch off the console" 
				(add_loading_anim) = (add_loading_anim) 
			} 
		CASE (xbox) 
			(create_dialog_box_with_wait) { 
				(title) = #"Checking ..." 
				(text) = #"Checking hard disk ..." 
				(no_bg) = <no_bg> 
				(add_loading_anim) = (add_loading_anim) 
			} 
		CASE (ngc) 
			(create_dialog_box_with_wait) { 
				(title) = #"Accessing ..." 
				(text) = #"Accessing. Do not touch the Nintendo GameCube Memory Card in Slot A, or the POWER Button." 
				(add_loading_anim) = (add_loading_anim) 
			} 
	ENDSWITCH 
ENDSCRIPT

SCRIPT (mcmess_SavingData) 
	(GetPlatform) 
	SWITCH <Platform> 
		CASE (ps2) 
			(create_dialog_box_with_wait) { 
				(title) = #"Saving ..." 
				(text) = #"Saving data. Do not remove memory card (8MB) (for PlayStation\xAE2) in MEMORY CARD slot 1, controller, or reset/switch off the console." 
				(add_loading_anim) = (add_loading_anim) 
			} 
		CASE (xbox) 
			(GetFileTypeName) (file_type) = <FileType> 
			(FormatText) { 
				(TextName) = (text) 
				#"Saving %f to hard disk ..." 
				(f) = <filetype_name> 
			} 
			(create_dialog_box_with_wait) { 
				(title) = #"Saving ..." 
				(text_dims) = PAIR(350, 0) 
				(text) = <text> 
				(add_loading_anim) = (add_loading_anim) 
			} 
		CASE (ngc) 
			(create_dialog_box_with_wait) { 
				(title) = #"Saving ..." 
				(text_dims) = PAIR(350, 0) 
				(text) = #"Saving data. Do not touch the Nintendo GameCube Memory Card in Slot A, or the POWER Button." 
				(add_loading_anim) = (add_loading_anim) 
			} 
	ENDSWITCH 
ENDSCRIPT

SCRIPT (mcmess_OverwritingData) 
	(GetPlatform) 
	SWITCH <Platform> 
		CASE (ps2) 
			(create_dialog_box_with_wait) { 
				(title) = #"Overwriting ..." 
				(text) = #"Overwriting data. Do not remove memory card (8MB) (for PlayStation\xAE2) in MEMORY CARD slot 1, controller, or reset/switch off console." 
				(add_loading_anim) = (add_loading_anim) 
			} 
		CASE (xbox) 
			(GetFileTypeName) (file_type) = <FileType> 
			(FormatText) { 
				(TextName) = (text) 
				#"Overwriting %f to hard disk ..." 
				(f) = <filetype_name> 
			} 
			(create_dialog_box_with_wait) { 
				(title) = #"Overwriting ..." 
				(text_dims) = PAIR(350, 0) 
				(text) = <text> 
				(add_loading_anim) = (add_loading_anim) 
			} 
		CASE (ngc) 
			(create_dialog_box_with_wait) { 
				(title) = #"Overwriting ..." 
				(text_dims) = PAIR(350, 0) 
				(text) = #"Overwriting data. Do not touch the Nintendo GameCube Memory Card in Slot A, or the POWER Button." 
				(add_loading_anim) = (add_loading_anim) 
			} 
	ENDSWITCH 
ENDSCRIPT

SCRIPT (mcmess_LoadingData) 
	(GetPlatform) 
	SWITCH <Platform> 
		CASE (ps2) 
			(create_dialog_box_with_wait) { 
				(title) = #"Loading ..." 
				(text) = #"Loading data. Do not remove memory card (8MB) (for PlayStation\xAE2), controller, or reset/switch off the console." 
				(add_loading_anim) = (add_loading_anim) 
			} 
			(no_animate) = <no_animate> 
		CASE (xbox) 
			(GetFileTypeName) (file_type) = <FileType> 
			(FormatText) { 
				(TextName) = (text) 
				#"Loading %f from hard disk ..." 
				(f) = <filetype_name> 
			} 
			(create_dialog_box_with_wait) { 
				(title) = #"Loading ..." 
				(text_dims) = PAIR(400, 0) 
				(text) = <text> 
				(add_loading_anim) = (add_loading_anim) 
			} 
			(no_animate) = <no_animate> 
		CASE (ngc) 
			(create_dialog_box_with_wait) { 
				(title) = #"Loading ..." 
				(text_dims) = PAIR(350, 0) 
				(text) = #"Loading data. Do not touch the Nintendo GameCube Memory Card in Slot A, or the POWER Button." 
				(add_loading_anim) = (add_loading_anim) 
			} 
			(no_animate) = <no_animate> 
	ENDSWITCH 
ENDSCRIPT

SCRIPT (mcmess_DeletingFile) 
	(GetPlatform) 
	SWITCH <Platform> 
		CASE (ps2) 
			(create_dialog_box_with_wait) { 
				(title) = #"Deleting ..." 
				(text) = #"Deleting data. Do not remove memory card (8MB) (for PlayStation\xAE2) in MEMORY CARD slot 1, controller, or reset/switch off console." 
				(add_loading_anim) = (add_loading_anim) 
			} 
		CASE (xbox) 
			(GetFileTypeName) (file_type) = <FileType> 
			(FormatText) { 
				(TextName) = (text) 
				#"Deleting %f from hard disk ..." 
				(f) = <filetype_name> 
			} 
			(create_dialog_box_with_wait) { 
				(title) = #"Deleting ..." 
				(text_dims) = PAIR(350, 0) 
				(text) = <text> 
				(add_loading_anim) = (add_loading_anim) 
			} 
		CASE (ngc) 
			(create_dialog_box_with_wait) { 
				(title) = #"Deleting ..." 
				(text_dims) = PAIR(350, 0) 
				(text) = #"Deleting data. Do not touch the Nintendo GameCube Memory Card in Slot A, or the POWER Button." 
				(add_loading_anim) = (add_loading_anim) 
			} 
	ENDSWITCH 
ENDSCRIPT

SCRIPT (mcmess_SaveSuccessful) 
	(create_memcard_success_dialog_box) { 
		(title) = #"Successful" 
		(text) = #"Save Successful" 
	} 
ENDSCRIPT

SCRIPT (mcmess_OverwriteSuccessful) 
	(create_memcard_success_dialog_box) { 
		(title) = #"Successful" 
		(text) = #"Overwrite successful" 
	} 
ENDSCRIPT

SCRIPT (mcmess_LoadSuccessful) 
	(create_memcard_success_dialog_box) { 
		(title) = #"Successful" 
		(text) = #"Load Successful" 
	} 
ENDSCRIPT

SCRIPT (mcmess_FormattingCard) 
	(GetPlatform) 
	SWITCH <Platform> 
		CASE (ps2) 
			(create_dialog_box_with_wait) { 
				(title) = "Formatting..." 
				(text) = "Formatting memory card (8MB) (for PlayStation\xAE2) in MEMORY CARD slot 1. Do not remove memory card (8MB) (for PlayStation\xAE2), controller, or reset/switch off console." 
				(add_loading_anim) = (add_loading_anim) 
			} 
		CASE (ngc) 
			(create_dialog_box_with_wait) { 
				(text_dims) = PAIR(400, 0) 
				(title) = "Formatting..." 
				(text) = "Formatting. Do not touch the Nintendo GameCube Memory Card in Slot A, or the POWER Button." 
				(add_loading_anim) = (add_loading_anim) 
			} 
	ENDSWITCH 
ENDSCRIPT

SCRIPT (mcmess_FormatSuccessful) 
	(memcard_menus_cleanup) 
	(create_snazzy_dialog_box) { 
		(title) = #"Successful" 
		(text) = #"Format Successful" 
		(pad_back_script) = (RetryScript) 
		(buttons) = [ 
			{ (font) = (small) (text) = #"OK" (pad_choose_script) = (RetryScript) } 
		] 
	} 
ENDSCRIPT

SCRIPT (create_memcard_error_dialog_box) 
	(memcard_menus_cleanup) 
	(create_error_box) { 
		<...> 
		(pad_back_script) = (reload_anims_then_run_abort_script) 
		(buttons) = [ 
			{ (font) = (small) (text) = #"Retry" (pad_choose_script) = (RetryScript) } 
			{ (font) = (small) (text) = #"Quit" (pad_choose_script) = (reload_anims_then_run_abort_script) } 
		] 
	} 
ENDSCRIPT

SCRIPT (create_memcard_success_dialog_box) 
	(memcard_menus_cleanup) 
	(create_snazzy_dialog_box) { 
		<...> 
		(pad_back_script) = (DoneScript) 
		(buttons) = [ 
			{ (font) = (small) (text) = #"OK" (pad_choose_script) = (DoneScript) (pad_choose_params) = { (type) = <type> } } 
		] 
	} 
ENDSCRIPT

SCRIPT (mcmess_FormatFailed) 
	(memcard_menus_cleanup) 
	(GetPlatform) 
	SWITCH <Platform> 
		CASE (ps2) 
			(create_error_box) { 
				(title) = #"Warning !" 
				(text) = #"Format failed! Please check memory card (8MB) (for PlayStation\xAE2) in MEMORY CARD slot 1 and try again." 
				(pad_back_script) = (reload_anims_then_run_abort_script) 
				(buttons) = [ 
					{ (font) = (small) (text) = #"Retry" (pad_choose_script) = (RetryScript) } 
					{ (font) = (small) (text) = #"Continue without saving" (pad_choose_script) = (reload_anims_then_run_abort_script) } 
				] 
			} 
		CASE (ngc) 
			(goto) (mcmess_DamagedCard) 
	ENDSWITCH 
ENDSCRIPT

SCRIPT (mcmess_ErrorSaveFailed) 
	(GetPlatform) 
	SWITCH <Platform> 
		CASE (ps2) 
			(create_memcard_error_dialog_box) { 
				(title) = #"Warning !" 
				(text) = [ 
					#"Save failed !\\n" 
					#"Check memory card (8MB) " 
					#"(for PlayStation\xAE2) in MEMORY CARD " 
					#"slot 1 and please try again." 
				] 
			} 
		CASE (xbox) 
			(create_memcard_error_dialog_box) { 
				(title) = #"Warning !" 
				(text) = #"Failed trying to save." 
			} 
		CASE (ngc) 
			(create_memcard_error_dialog_box) { 
				(text_dims) = PAIR(350, 0) 
				(title) = #"Warning !" 
				(text) = #"Save failed !\\nCheck Nintendo GameCube Memory Card in Slot A and please try again !" 
			} 
	ENDSWITCH 
ENDSCRIPT

SCRIPT (mcmess_ErrorOverwriteFailed) 
	(GetPlatform) 
	SWITCH <Platform> 
		CASE (ps2) 
			(create_memcard_error_dialog_box) { 
				(title) = #"Warning !" 
				(text) = [ 
					#"Overwrite failed !\\n" 
					#"Check memory card (8MB) " 
					#"(for PlayStation\xAE2) in memory card " 
					#"slot 1 and please try again!" 
				] 
			} 
		CASE (xbox) 
			(create_memcard_error_dialog_box) { 
				(title) = #"Warning !" 
				(text) = #"Failed trying to overwrite." 
			} 
		CASE (ngc) 
			(create_memcard_error_dialog_box) { 
				(text_dims) = PAIR(350, 0) 
				(title) = #"Warning !" 
				(text) = #"Overwrite failed !\\nCheck Nintendo GameCube Memory Card in Slot A and please try again !" 
			} 
	ENDSWITCH 
ENDSCRIPT

SCRIPT (mcmess_ErrorbadParkMaxPlayers) (back_script) = (reload_anims_then_run_abort_script) (back_params) = { } 
	(FormatText) { 
		(TextName) = (text) 
		#"This park cannot run with %p players.\\nThe maximum number of players for this park is %m" 
		(p) = <num_players> 
		(m) = <MaxPlayers> 
	} 
	(create_error_box) { 
		(title) = #"Warning !" 
		(text) = <text> 
		(text_dims) = PAIR(400, 0) 
		(pad_back_script) = <back_script> 
		(pad_back_params) = <back_params> 
		(buttons) = [ 
			{ (font) = (small) (text) = #"OK" (pad_choose_script) = <back_script> (pad_choose_params) = <back_params> } 
		] 
	} 
ENDSCRIPT

SCRIPT (mcmess_ErrorLoadFailed) 
	(GetPlatform) 
	SWITCH <Platform> 
		CASE (ps2) 
			IF (GotParam) (CorruptedData) 
				(create_memcard_error_dialog_box) { 
					(title) = #"Warning !" 
					(text) = [ 
						#"Load failed !\\n" 
						#"The file data is damaged.\\n" 
						#"Check memory card (8MB) " 
						#"(for PlayStation\xAE2) in MEMORY CARD " 
						#"slot 1 and please try again!" 
					] 
				} 
			ELSE 
				(create_memcard_error_dialog_box) { 
					(title) = #"Warning !" 
					(text) = [ 
						#"Load failed !\\n" 
						#"Check memory card (8MB) " 
						#"(for PlayStation\xAE2) in MEMORY CARD " 
						#"slot 1 and please try again." 
					] 
				} 
			ENDIF 
		CASE (xbox) 
			(GetFileTypeName) (file_type) = <file_type> 
			(FormatText) (TextName) = (text) #"Unable to load %s. Press A to continue." (s) = <filetype_name> 
			(memcard_menus_cleanup) 
			(create_error_box) { 
				(title) = #"" 
				(text) = <text> 
				(pad_back_script) = (reload_anims_then_run_abort_script) 
				(buttons) = [ 
					{ (font) = (small) (text) = #"Continue" (pad_choose_script) = (reload_anims_then_run_abort_script) } 
				] 
			} 
		CASE (ngc) 
			(create_error_box) { 
				(text_dims) = PAIR(350, 0) 
				(title) = #"Warning !" 
				(text) = #"The Memory Card in Slot A contains a corrupted file." 
				(pad_back_script) = (reload_anims_then_run_abort_script) 
				(buttons) = [ 
					{ (font) = (small) (text) = #"Continue without saving" (pad_choose_script) = (reload_anims_then_run_abort_script) } 
					{ (font) = (small) (text) = #"Retry" (pad_choose_script) = (RetryScript) } 
					{ (font) = (small) (text) = #"Delete file" (pad_choose_script) = (delete_bad_file) (pad_choose_params) = <...> } 
				] 
			} 
			(CheckForCardRemoval) (menu_id) = (dialog_box_anchor) 
	ENDSWITCH 
ENDSCRIPT

SCRIPT (mcmess_NGCDeleteCorruptFile) 
	(memcard_menus_cleanup) 
	(create_error_box) { 
		(text_dims) = PAIR(350, 0) 
		(title) = "Warning !" 
		(text) = "The Memory Card in Slot A contains a corrupted file." 
		(pad_back_script) = (reload_anims_then_run_abort_script) 
		(buttons) = [ 
			{ (font) = (small) (text) = "Continue without Saving" (pad_choose_script) = (reload_anims_then_run_abort_script) } 
			{ (font) = (small) (text) = "Retry" (pad_choose_script) = (RetryScript) } 
			{ (font) = (small) (text) = "Delete Corrupted Data" (pad_choose_script) = (NGC_delete_bad_file) (pad_choose_params) = <...> } 
		] 
	} 
	(CheckForCardRemoval) (menu_id) = (dialog_box_anchor) 
ENDSCRIPT

SCRIPT (mcmess_ErrorNoCardInSlot) 
	(memcard_menus_cleanup) 
	IF ( (SavingOrLoading) = (Saving) ) 
		(ContinueText) = #"Continue without saving" 
	ELSE 
		(ContinueText) = #"Continue" 
	ENDIF 
	(GetPlatform) 
	SWITCH <Platform> 
		CASE (ps2) 
			(create_error_box) { 
				(title) = #"Warning !" 
				(text) = [ 
					#"No memory card (8MB) (for PlayStation\xAE2) " 
					#"in MEMORY CARD slot 1.  " 
					#"Please insert a memory card (8MB) (for PlayStation\xAE2)" 
				] 
				(pad_back_script) = (reload_anims_then_run_abort_script) 
				(buttons) = [ 
					{ (font) = (small) (text) = #"Retry" (pad_choose_script) = (RetryScript) } 
					{ (font) = (small) (text) = <ContinueText> (pad_choose_script) = (reload_anims_then_run_abort_script) } 
				] 
			} 
		CASE (ngc) 
			(create_error_box) { 
				(title) = #"Warning !" 
				(text) = #"There is no Nintendo GameCube Memory Card in Slot A." 
				(pad_back_script) = (reload_anims_then_run_abort_script) 
				(buttons) = [ 
					{ (font) = (small) (text) = #"Retry" (pad_choose_script) = (RetryScript) } 
					{ (font) = (small) (text) = <ContinueText> (pad_choose_script) = (reload_anims_then_run_abort_script) } 
				] 
			} 
	ENDSWITCH 
ENDSCRIPT

SCRIPT (mcmess_ErrorNotEnoughRoomNoTHPSFilesExist) (SpaceRequired) = 0 (SpaceAvailable) = 0 
	(memcard_menus_cleanup) 
	(GetFileTypeName) (file_type) = <FileType> 
	(GetPlatform) 
	SWITCH <Platform> 
		CASE (ps2) 
			(FormatText) { 
				(TextName) = (text) 
				#"Insufficient free space on memory card (8MB) (for PlayStation\xAE2) in MEMORY CARD slot 1.\\n%f requires %sKB of free space to save data." 
				(s) = <SpaceRequired> 
				(f) = <filetype_name> 
			} 
			(create_error_box) { 
				(title) = #"Warning !" 
				(text) = <text> 
				(pad_back_script) = (reload_anims_then_run_abort_script) 
				(buttons) = [ 
					{ (font) = (small) (text) = #"Continue without saving" (pad_choose_script) = (reload_anims_then_run_abort_script) } 
					{ (font) = (small) (text) = #"Retry" (pad_choose_script) = (RetryScript) } 
				] 
			} 
		CASE (xbox) 
			(FormatText) { 
				(TextName) = (text) 
				#"Your hard disk does not have enough free space to save.\\nAt least %s KB are needed to save the current %f.\\nPlease free at least %n KB." 
				(s) = <SpaceRequired> 
				(f) = <filetype_name> 
				(n) = ( <SpaceRequired> - <SpaceAvailable> ) 
			} 
			(create_error_box) { 
				(title) = #"Warning !" 
				(text) = <text> 
				(text_dims) = PAIR(400, 0) 
				(pad_back_script) = (reload_anims_then_run_abort_script) 
				(buttons) = [ 
					{ (font) = (small) (text) = #"Continue without saving" (pad_choose_script) = (reload_anims_then_run_abort_script) } 
				] 
			} 
		CASE (ngc) 
			(FormatText) { 
				(TextName) = (text) 
				#"There is not enough space on the Memory Card in Slot A. In order to save the current %t file 1 file and %b blocks are required. To manage the contents of your Memory Card, use the Memory Card Screen." 
				(t) = <filetype_name> 
				(b) = <SpaceRequired> 
			} 
			(create_error_box) { 
				(title) = #"Warning !" 
				(text) = <text> 
				(text_dims) = PAIR(400, 0) 
				(pad_back_script) = (reload_anims_then_run_abort_script) 
				(buttons) = [ 
					{ (font) = (small) (text) = #"Continue without saving" (pad_choose_script) = (reload_anims_then_run_abort_script) } 
					{ (font) = (small) (text) = #"Retry" (pad_choose_script) = (RetryScript) } 
				] 
			} 
	ENDSWITCH 
ENDSCRIPT

SCRIPT (mcmess_ErrorNotEnoughRoomButTHPSFilesExist) (SpaceRequired) = 0 
	(memcard_menus_cleanup) 
	(GetFileTypeName) (file_type) = <FileType> 
	(GetPlatform) 
	SWITCH <Platform> 
		CASE (ps2) 
			(FormatText) { 
				(TextName) = (text) 
				#"Insufficient space on memory card (8MB) (for PlayStation\xAE2) in MEMORY CARD slot 1.\\n%f requires %sKB of free space to save data.\\nWould you like to overwrite previous %f data?" 
				(s) = <SpaceRequired> 
				(f) = <filetype_name> 
			} 
			(create_error_box) { 
				(title) = #"Warning !" 
				(text) = <text> 
				(text_dims) = PAIR(450, 0) 
				(pad_back_script) = (reload_anims_then_run_abort_script) 
				(buttons) = [ 
					{ (font) = (small) (text) = #"Continue" (pad_choose_script) = (launch_files_menu) (pad_choose_params) = { (DoNotShowNotEnoughRoomMessage) (Save) (FileType) = <FileType> } } 
					{ (font) = (small) (text) = #"Quit" (pad_choose_script) = (reload_anims_then_run_abort_script) } 
				] 
			} 
		CASE (xbox) 
			(FormatText) { 
				(TextName) = (text) 
				#"Your hard disk does not have enough free space to save.\\nAt least %s KB are needed to save the current %f.\\nYou will need to either delete or overwrite existing saves." 
				(s) = <SpaceRequired> 
				(f) = <filetype_name> 
			} 
			(create_error_box) { 
				(title) = #"Warning !" 
				(text) = <text> 
				(text_dims) = PAIR(450, 0) 
				(pad_back_script) = (reload_anims_then_run_abort_script) 
				(buttons) = [ 
					{ (font) = (small) (text) = #"Continue" (pad_choose_script) = (launch_files_menu) (pad_choose_params) = { (DoNotShowNotEnoughRoomMessage) (Save) (FileType) = <FileType> } } 
					{ (font) = (small) (text) = #"Quit" (pad_choose_script) = (reload_anims_then_run_abort_script) } 
				] 
			} 
		CASE (ngc) 
			IF (GotParam) (Overwrite) 
				<word> = #"overwrite" 
			ELSE 
				<word> = #"save" 
			ENDIF 
			(FormatText) { 
				(TextName) = (text) 
				#"There is not enough space on the Memory Card in Slot A. In order to %w the current %t file 1 file and %b blocks are required.\\nYou will need to either delete or overwrite existing THUG files. To manage the contents of your Memory Card, use the Memory Card Screen." 
				(w) = <word> 
				(t) = <filetype_name> 
				(b) = <SpaceRequired> 
			} 
			(create_error_box) { 
				(title) = #"Warning !" 
				(text) = <text> 
				(text_dims) = PAIR(450, 0) 
				(pad_back_script) = (reload_anims_then_run_abort_script) 
				(buttons) = [ 
					{ (font) = (small) (text) = #"Continue without saving" (pad_choose_script) = (reload_anims_then_run_abort_script) } 
					{ (font) = (small) (text) = #"Retry" (pad_choose_script) = (RetryScript) } 
					{ (font) = (small) (text) = #"Delete/Overwrite THUG files" (pad_choose_script) = (launch_files_menu) (pad_choose_params) = { (DoNotShowNotEnoughRoomMessage) (Save) (FileType) = <FileType> } } 
				] 
			} 
	ENDSWITCH 
ENDSCRIPT

SCRIPT (mcmess_ErrorDeleteFailed) 
	IF (CardIsDamaged) 
		(goto) (mcmess_DamagedCard) 
	ENDIF 
	(GetPlatform) 
	SWITCH <Platform> 
		CASE (ps2) 
			(create_memcard_error_dialog_box) { 
				(title) = #"Delete failed !" 
				(text) = #"Delete Failed! Please check memory card (8MB) (for PlayStation\xAE2) in MEMORY CARD slot 1 and please try again." 
			} 
		CASE (xbox) 
			(create_memcard_error_dialog_box) { 
				(title) = #"Delete failed !" 
				(text) = #"Unable to delete." 
			} 
		CASE (ngc) 
			(create_memcard_error_dialog_box) { 
				(text_dims) = PAIR(350, 0) 
				(title) = #"Delete failed !" 
				(text) = #"Check Nintendo GameCube Memory Card in Slot A and please try again !" 
			} 
	ENDSWITCH 
ENDSCRIPT

SCRIPT (mcmess_NoFiles) 
	(GetFileTypeName) (file_type) = <MenuFileType> 
	IF (ScreenElementExists) (id) = (current_menu_anchor) 
		(DestroyScreenElement) (id) = (current_menu_anchor) 
	ENDIF 
	(GetPlatform) 
	SWITCH <Platform> 
		CASE (ps2) 
			(FormatText) { 
				(TextName) = (text) 
				#"No THUG %n data present on memory card (8MB) (for PlayStation\xAE2) in MEMORY CARD slot 1." 
				(n) = <filetype_name> 
			} 
			(create_memcard_error_dialog_box) { 
				(title) = "Warning !" 
				(text) = <text> 
			} 
		CASE (xbox) 
			(FormatText) { 
				(TextName) = (text) 
				#"No THUG %n present on hard disk." 
				(n) = <filetype_name> 
			} 
			(memcard_menus_cleanup) 
			(create_error_box) { 
				(title) = "No Saves" 
				(text) = <text> 
				(pad_back_script) = (reload_anims_then_run_abort_script) 
				(buttons) = [ 
					{ (font) = (small) (text) = #"Quit" (pad_choose_script) = (reload_anims_then_run_abort_script) } 
				] 
			} 
		CASE (ngc) 
			(FormatText) { 
				(TextName) = (text) 
				#"No THUG %n data present on Nintendo GameCube Memory Card in Slot A." 
				(n) = <filetype_name> 
			} 
			(create_memcard_error_dialog_box) { 
				(title) = "Warning !" 
				(text) = <text> 
			} 
	ENDSWITCH 
ENDSCRIPT

SCRIPT (mcmess_ErrorNotFormatted) (QuitText) = #"Continue without formatting" (BackScript) = (reload_anims_then_run_abort_script) 
	(memcard_menus_cleanup) 
	(GetPlatform) 
	SWITCH <Platform> 
		CASE (ps2) 
			(create_error_box) { 
				(text_dims) = PAIR(600, 0) 
				(title) = #"Warning !" 
				(text) = #"Memory card (8MB) (for PlayStation\xAE2)\\n in MEMORY CARD slot 1 is unformatted." 
				(pad_back_script) = <BackScript> 
				(font) = (dialog) 
				(buttons) = [ 
					{ (font) = (small) (text) = <QuitText> (pad_choose_script) = (reload_anims_then_run_abort_script) } 
					{ (font) = (small) (text) = #"Retry" (pad_choose_script) = (RetryScript) } 
					{ (font) = (small) (text) = #"Format Memory Card (8MB) (for PlayStation\xAE2)?" (pad_choose_script) = (mcmess_FormatYesNo) (pad_choose_params) = { (BackScript) = <BackScript> } } 
				] 
			} 
		CASE (ngc) 
			IF (CardIsForeign) 
				(create_error_box) { 
					(text_dims) = PAIR(590, 0) 
					(title) = #"Warning !" 
					(text) = #"The Memory Card in Slot A is corrupted and needs to be formatted." 
					(pad_back_script) = <BackScript> 
					(buttons) = [ 
						{ (font) = (small) (text) = #"Continue without saving" (pad_choose_script) = (reload_anims_then_run_abort_script) } 
						{ (font) = (small) (text) = #"Retry" (pad_choose_script) = (RetryScript) } 
						{ (font) = (small) (text) = #"Format Memory Card" (pad_choose_script) = (mcmess_FormatYesNo) (pad_choose_params) = { (BackScript) = <BackScript> } } 
					] 
				} 
			ELSE 
				(create_error_box) { 
					(text_dims) = PAIR(590, 0) 
					(title) = #"Warning !" 
					(text) = #"The Memory Card in Slot A is corrupted and needs to be formatted.\\nDo you want to format?" 
					(pad_back_script) = <BackScript> 
					(buttons) = [ 
						{ (font) = (small) (text) = #"Continue without saving" (pad_choose_script) = (reload_anims_then_run_abort_script) } 
						{ (font) = (small) (text) = #"Retry" (pad_choose_script) = (RetryScript) } 
						{ (font) = (small) (text) = #"Format Memory Card" (pad_choose_script) = (mcmess_FormatYesNo) (pad_choose_params) = { (BackScript) = <BackScript> } } 
					] 
				} 
			ENDIF 
	ENDSWITCH 
	(CheckForCardRemoval) (menu_id) = (dialog_box_anchor) 
ENDSCRIPT

SCRIPT (mcmess_ErrorNotFormattedNoFormatOption) 
	(memcard_menus_cleanup) 
	(GetPlatform) 
	SWITCH <Platform> 
		CASE (ps2) 
			(create_error_box) { 
				(title) = #"Warning !" 
				(text) = #"Memory card (8MB) (for PlayStation\xAE2) in MEMORY CARD slot 1 is unformatted." 
				(pad_back_script) = (reload_anims_then_run_abort_script) 
				(buttons) = [ 
					{ (font) = (small) (text) = #"Continue" (pad_choose_script) = (reload_anims_then_run_abort_script) } 
					{ (font) = (small) (text) = #"Retry" (pad_choose_script) = (RetryScript) } 
				] 
			} 
		CASE (ngc) 
			IF (CardIsForeign) 
				(create_error_box) { 
					(text_dims) = PAIR(350, 0) 
					(title) = #"Warning !" 
					(text) = #"The Memory Card in Slot A is corrupted and needs to be formatted." 
					(pad_back_script) = <BackScript> 
					(buttons) = [ 
						{ (font) = (small) (text) = #"Continue without saving" (pad_choose_script) = (reload_anims_then_run_abort_script) } 
						{ (font) = (small) (text) = #"Retry" (pad_choose_script) = (RetryScript) } 
						{ (font) = (small) (text) = #"Format Memory Card" (pad_choose_script) = (mcmess_FormatYesNo) (pad_choose_params) = { (BackScript) = (reload_anims_then_run_abort_script) } } 
					] 
				} 
			ELSE 
				(create_error_box) { 
					(text_dims) = PAIR(350, 0) 
					(title) = #"Warning !" 
					(text) = #"The Nintendo GameCube Memory Card in Slot A is corrupted and needs to be formatted.\\nDo you want to format?" 
					(pad_back_script) = <BackScript> 
					(buttons) = [ 
						{ (font) = (small) (text) = #"Continue without saving" (pad_choose_script) = (reload_anims_then_run_abort_script) } 
						{ (font) = (small) (text) = #"Retry" (pad_choose_script) = (RetryScript) } 
						{ (font) = (small) (text) = #"Format Memory Card" (pad_choose_script) = (mcmess_FormatYesNo) (pad_choose_params) = { (BackScript) = (reload_anims_then_run_abort_script) } } 
					] 
				} 
			ENDIF 
	ENDSWITCH 
	(CheckForCardRemoval) (menu_id) = (dialog_box_anchor) 
ENDSCRIPT

SCRIPT (mcmess_FormatYesNo) (BackScript) = (reload_anims_then_run_abort_script) 
	(memcard_menus_cleanup) 
	(GetPlatform) 
	SWITCH <Platform> 
		CASE (ps2) 
			(create_snazzy_dialog_box) { 
				(title) = #"Format" 
				(text) = #"Are you sure you wish to format memory card (8MB) (for PlayStation\xAE2) in MEMORY CARD slot 1?" 
				(pad_back_script) = <BackScript> 
				(buttons) = [ 
					{ (font) = (small) (text) = #"No" (pad_choose_script) = (reload_anims_then_run_abort_script) } 
					{ (font) = (small) (text) = #"Yes" (pad_choose_script) = (DoFormatCard) } 
				] 
			} 
		CASE (ngc) 
			(create_snazzy_dialog_box) { 
				(title) = #"Format" 
				(text) = #"All previously saved data on Memory Card in Slot A will be lost. Would you like to continue formatting?" 
				(pad_back_script) = <BackScript> 
				(buttons) = [ 
					{ (font) = (small) (text) = #"No" (pad_choose_script) = (reload_anims_then_run_abort_script) } 
					{ (font) = (small) (text) = #"Yes" (pad_choose_script) = (DoFormatCard) } 
				] 
			} 
	ENDSWITCH 
	(CheckForCardRemoval) (menu_id) = (dialog_box_anchor) 
ENDSCRIPT

SCRIPT (GetSaveSizes) 
	(GetMemCardSpaceRequired) (OptionsAndPros) 
	<SaveSize_OptionsAndPros> = <SpaceRequired> 
	(GetMemCardSpaceRequired) (NetworkSettings) 
	<SaveSize_NetworkSettings> = <SpaceRequired> 
	(GetMemCardSpaceRequired) (Park) 
	<SaveSize_Park> = <SpaceRequired> 
	(GetMemCardSpaceRequired) (Cat) 
	<SaveSize_CreateATrick> = <SpaceRequired> 
	(GetMemCardSpaceRequired) (CreatedGoals) 
	<SaveSize_Goals> = <SpaceRequired> 
	RETURN <...> 
ENDSCRIPT

SCRIPT (mcmess_ErrorNotEnoughSpaceToSaveAllTypes) 
	IF ( (no_load) = 0 ) 
		(memcard_menus_cleanup) 
	ELSE 
		<no_bg> = (no_bg) 
	ENDIF 
	(GetSaveSizes) 
	(GetPlatform) 
	SWITCH <Platform> 
		CASE (ps2) 
			(FormatText) { 
				(TextName) = (text) 
				#"Insufficient free space on the memory card (8MB) (for PlayStation\xAE2) in MEMORY CARD slot 1. At least %c KB of free space is required to save game data. An additional %n KB of free space is also required to play online. A further 94KB of free space is required to play online if you are using the Network Adaptor (Ethernet) (for PlayStation\xAE2).\\n\\nStory/Skater requires %c KB\\nNet settings requires %n KB\\nPark requires %p KB\\nTricks require %t KB\\nGoals require %g KB" 
				(c) = <SaveSize_OptionsAndPros> 
				(n) = <SaveSize_NetworkSettings> 
				(p) = <SaveSize_Park> 
				(t) = <SaveSize_CreateATrick> 
				(g) = <SaveSize_Goals> 
				(z) = "" 
			} 
			(create_error_box) { 
				(title) = #"Warning !" 
				(text) = <text> 
				(text_dims) = PAIR(580, 0) 
				(pos_tweak) = PAIR(0, -33) 
				(no_animate) 
				(pad_back_script) = (reload_anims_then_run_abort_script) 
				(buttons) = [ 
					{ (font) = (small) (text) = #"Continue without saving all types of files" (pad_choose_script) = (reload_anims_then_run_abort_script) } 
					{ (font) = (small) (text) = #"Retry" (pad_choose_script) = (RetryScript) } 
				] 
			} 
		CASE (xbox) 
			(GetMemCardSpaceAvailable) 
			(total_blocks_needed) = ( <SaveSize_OptionsAndPros> + <SaveSize_Park> + <SaveSize_CreateATrick> + <SaveSize_Goals> ) 
			(FormatText) { 
				(TextName) = (text) 
				#"Your hard disk does not have enough free space to save all types of THUG saves.\\nPlease free at least %f KB.\\n\\nStory/Skater requires %c KB\\nPark requires %p KB\\nTricks require %t KB\\nGoals require %g KB" 
				(c) = <SaveSize_OptionsAndPros> 
				(p) = <SaveSize_Park> 
				(t) = <SaveSize_CreateATrick> 
				(g) = <SaveSize_Goals> 
				(f) = ( <total_blocks_needed> - <SpaceAvailable> ) 
			} 
			(create_error_box) { 
				(title) = #"" 
				(text) = <text> 
				(text_dims) = PAIR(560, 0) 
				(pos_tweak) = PAIR(0, -15) 
				(no_animate) 
				(no_bg) = <no_bg> 
				(buttons) = [ 
					{ (font) = (small) (text) = #"Continue without saving all types of game saves" (pad_choose_script) = (reload_anims_then_run_abort_script) } 
				] 
			} 
		CASE (ngc) 
			(FormatText) { 
				(TextName) = (text) 
				#"The Memory Card in Slot A does not have sufficient space to save all types of THUG save files. Saved data may be loaded and overwritten.\\nStory/Skater requires 1 file and %c blocks.\\nPark requires 1 file and %p blocks.\\nTricks require 1 file and %t blocks.\\nGoals require 1 file and %g blocks.\\nTo manage the contents of your Memory Card, use the Memory Card Screen." 
				(c) = <SaveSize_OptionsAndPros> 
				(p) = <SaveSize_Park> 
				(t) = <SaveSize_CreateATrick> 
				(g) = <SaveSize_Goals> 
			} 
			IF (GotParam) (no_manager) 
				(create_error_box) { 
					(title) = #"Warning !" 
					(text) = <text> 
					(text_dims) = PAIR(550, 0) 
					(pos_tweak) = PAIR(15, -17) 
					(no_animate) 
					(pad_back_script) = (reload_anims_then_run_abort_script) 
					(buttons) = [ 
						{ (font) = (small) (text) = #"Continue without saving all types of files" (pad_choose_script) = (reload_anims_then_run_abort_script) } 
						{ (font) = (small) (text) = #"Retry" (pad_choose_script) = (RetryScript) } 
					] 
				} 
			ELSE 
				(create_error_box) { 
					(title) = #"Warning !" 
					(text) = <text> 
					(text_dims) = PAIR(550, 0) 
					(pos_tweak) = PAIR(15, -17) 
					(no_animate) 
					(pad_back_script) = (reload_anims_then_run_abort_script) 
					(buttons) = [ 
						{ (font) = (small) (text) = #"Continue without saving all types of files" (pad_choose_script) = (reload_anims_then_run_abort_script) } 
						{ (font) = (small) (text) = #"Retry" (pad_choose_script) = (RetryScript) } 
						{ (font) = (small) (text) = #"Manage Memory Card" (pad_choose_script) = (QuitToDashboard) } 
					] 
				} 
			ENDIF 
	ENDSWITCH 
ENDSCRIPT

SCRIPT (mcmess_ErrorNoCardOnBootup) 
	(memcard_menus_cleanup) 
	(GetSaveSizes) 
	(GetPlatform) 
	SWITCH <Platform> 
		CASE (ps2) 
			(FormatText) { 
				(TextName) = (text) 
				#"No memory card (8MB) (for PlayStation\xAE2) in MEMORY CARD slot 1.\\nPlease insert a memory card (8MB) (for PlayStation\xAE2) with at least %c KB free space. An additional %n KB of free space is required to play online. A further 94KB of free space is required to play online if you are using the Network Adaptor (Ethernet) (for PlayStation\xAE2).\\n\\nStory/Skater requires %c KB\\nNet settings requires %n KB\\nPark requires %p KB\\nTricks require %t KB\\nGoals require %g KB" 
				(c) = <SaveSize_OptionsAndPros> 
				(n) = <SaveSize_NetworkSettings> 
				(p) = <SaveSize_Park> 
				(t) = <SaveSize_CreateATrick> 
				(g) = <SaveSize_Goals> 
				(z) = "" 
			} 
			(create_error_box) { 
				(title) = #"Warning !" 
				(text) = <text> 
				(text_dims) = PAIR(560, 0) 
				(pos_tweak) = PAIR(0, -33) 
				(no_animate) 
				(pad_back_script) = (generic_menu_pad_back) 
				(pad_back_params) = { (callback) = (reload_anims_then_run_abort_script) } 
				(buttons) = [ 
					{ (font) = (small) (text) = #"Continue without saving all types of game files" (pad_choose_script) = (reload_anims_then_run_abort_script) } 
					{ (font) = (small) (text) = #"Retry" (pad_choose_script) = (RetryScript) } 
				] 
			} 
		CASE (ngc) 
			(FormatText) { 
				(TextName) = (text) 
				#"No Memory Card detected in Slot A.\\n\\nStory/Skater requires 1 file and %c blocks\\nPark requires 1 file and %p blocks\\nTricks require 1 file and %t blocks\\nGoals require 1 file and %g blocks" 
				(c) = <SaveSize_OptionsAndPros> 
				(p) = <SaveSize_Park> 
				(t) = <SaveSize_CreateATrick> 
				(g) = <SaveSize_Goals> 
			} 
			(create_error_box) { 
				(title) = #"Warning !" 
				(text) = <text> 
				(text_dims) = PAIR(500, 0) 
				(pos_tweak) = PAIR(0, 0) 
				(no_animate) 
				(pad_back_script) = (generic_menu_pad_back) 
				(pad_back_params) = { (callback) = (reload_anims_then_run_abort_script) } 
				(buttons) = [ 
					{ (font) = (small) (text) = #"Continue without saving all types of files" (pad_choose_script) = (reload_anims_then_run_abort_script) } 
					{ (font) = (small) (text) = #"Retry" (pad_choose_script) = (RetryScript) } 
				] 
			} 
	ENDSWITCH 
ENDSCRIPT

SCRIPT (mcmess_AutoLoadingCas) (filename) = "" 
	(GetPlatform) 
	SWITCH <Platform> 
		CASE (ps2) 
			(FormatText) { 
				(TextName) = (text) 
				"Loading Create-A-Skater file \'%s\'. Do not remove memory card (8MB) (for PlayStation\xAE2) in MEMORY CARD slot 1, reset, or switch off console." 
				(s) = <filename> 
			} 
			(create_dialog_box_with_wait) { 
				(title) = #"Loading ..." 
				(text) = <text> 
			} 
		CASE (xbox) 
			(FormatText) { 
				(TextName) = (text) 
				"Loading Create-A-Skater \'%s\' from hard disk." 
				(s) = <filename> 
			} 
			(create_dialog_box_with_wait) { 
				(title) = #"Loading ..." 
				(text_dims) = PAIR(350, 0) 
				(text) = <text> 
			} 
		CASE (ngc) 
			(FormatText) { 
				(TextName) = (text) 
				"Loading Create-A-Skater file \'%s\'. Do not touch the Nintendo GameCube Memory Card in Slot A, or the POWER Button." 
				(s) = <filename> 
			} 
			(create_dialog_box_with_wait) { 
				(title) = #"Loading ..." 
				(text_dims) = PAIR(350, 0) 
				(text) = <text> 
			} 
	ENDSWITCH 
ENDSCRIPT

SCRIPT (mcmess_AutoSavingCas) (filename) = "" 
	(GetPlatform) 
	SWITCH <Platform> 
		CASE (ps2) 
			(FormatText) { 
				(TextName) = (text) 
				"Saving Create-A-Skater file \'%s\'. Do not remove memory card (8MB) (for PlayStation\xAE2) in MEMORY CARD slot 1, reset, or switch off console." 
				(s) = <filename> 
			} 
			(create_dialog_box_with_wait) { 
				(title) = #"Saving ..." 
				(text) = <text> 
			} 
		CASE (xbox) 
			(FormatText) { 
				(TextName) = (text) 
				"Saving Create-A-Skater \'%s\' to hard disk." 
				(s) = <filename> 
			} 
			(create_dialog_box_with_wait) { 
				(title) = #"Saving ..." 
				(text_dims) = PAIR(350, 0) 
				(text) = <text> 
			} 
		CASE (ngc) 
			(FormatText) { 
				(TextName) = (text) 
				"Saving Create-A-Skater file \'%s\'. Do not touch the Nintendo GameCube Memory Card in Slot A, or the POWER Button." 
				(s) = <filename> 
			} 
			(create_dialog_box_with_wait) { 
				(title) = #"Saving ..." 
				(text_dims) = PAIR(350, 0) 
				(text) = <text> 
			} 
	ENDSWITCH 
ENDSCRIPT

SCRIPT (mcmess_PleaseEnterCasFilename) 
	IF (isXbox) 
		(create_dialog_box_with_wait) { 
			(title) = #"Warning ..." 
			(text) = "Your Create-A-Skater has not been saved yet.\\nPlease enter a name for your Create-A-Skater.\\n" 
		} 
	ELSE 
		(create_dialog_box_with_wait) { 
			(title) = #"Warning ..." 
			(text) = "Your Create-A-Skater has not been saved yet.\\nPlease enter a file name for your Create-A-Skater.\\n" 
		} 
	ENDIF 
ENDSCRIPT

SCRIPT (mcmess_DamagedCard) 
	(memcard_menus_cleanup) 
	(create_error_box) { 
		(title) = #"Error" 
		(text) = #"The Memory Card in Slot A is damaged and cannot be used." 
		(pad_back_script) = (reload_anims_then_run_abort_script) 
		(buttons) = [ 
			{ (font) = (small) (text) = #"Continue without saving" (pad_choose_script) = (reload_anims_then_run_abort_script) } 
			{ (font) = (small) (text) = #"Retry" (pad_choose_script) = (RetryScript) } 
		] 
	} 
ENDSCRIPT

SCRIPT (mcmess_BadDevice) 
	(memcard_menus_cleanup) 
	(create_error_box) { 
		(title) = #"Error" 
		(text) = #"Wrong device in Slot A. Please insert a Memory Card." 
		(pad_back_script) = (reload_anims_then_run_abort_script) 
		(buttons) = [ 
			{ (font) = (small) (text) = #"Continue without saving" (pad_choose_script) = (reload_anims_then_run_abort_script) } 
			{ (font) = (small) (text) = #"Retry" (pad_choose_script) = (RetryScript) } 
		] 
	} 
ENDSCRIPT

SCRIPT (mcmess_BadSectorSize) 
	(memcard_menus_cleanup) 
	(create_error_box) { 
		(title) = #"Error" 
		(text) = #"The Memory Card in Slot A is not compatible with the THUG save file." 
		(pad_back_script) = (reload_anims_then_run_abort_script) 
		(buttons) = [ 
			{ (font) = (small) (text) = #"Continue without saving" (pad_choose_script) = (reload_anims_then_run_abort_script) } 
			{ (font) = (small) (text) = #"Retry" (pad_choose_script) = (RetryScript) } 
		] 
	} 
ENDSCRIPT


