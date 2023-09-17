SCRIPT Veh_TaxiUS_TOD 
ENDSCRIPT

SCRIPT Veh_IsuzuTruck_TOD 
ENDSCRIPT

SCRIPT Veh_Lada_TOD 
ENDSCRIPT

SCRIPT Veh_SUV_TOD 
ENDSCRIPT

SCRIPT Veh_TransAm_TOD 
ENDSCRIPT

SCRIPT Gap_CarHop 
	StartGap { GapID = <StartGapID> flags = PURE_AIR } 
	EndGap { GapID = <EndGapID> text = "Car hop" score = 100 GapScript = <GapScript> } 
ENDSCRIPT

SCRIPT Veh_Generic_TOD 
	SWITCH <current_tod> 
		CASE morning 
			ReplaceCarTextures { 
				array = [ 
					{ 
						src = "JKU_LightCircle_Transparent.png" dest = "textures/cars/JKU_LightCircle_Transparent" 
					} 
					{ 
						src = "JKU_HeadlightGlow_Transparent.png" dest = "textures/cars/JKU_HeadlightGlow" 
					} 
				] 
			} 
		CASE day 
			ReplaceCarTextures { 
				array = [ 
					{ 
						src = "JKU_LightCircle_Transparent.png" dest = "textures/cars/JKU_LightCircle_Transparent" 
					} 
					{ 
						src = "JKU_HeadlightGlow_Transparent.png" dest = "textures/cars/JKU_HeadlightGlow_Transparent" 
					} 
				] 
			} 
		CASE evening 
			ReplaceCarTextures { 
				array = [ 
					{ 
						src = "JKU_LightCircle_Transparent.png" dest = "textures/cars/JKU_LightCircle_Transparent" 
					} 
					{ 
						src = "JKU_HeadlightGlow_Transparent.png" dest = "textures/cars/JKU_HeadlightGlow" 
					} 
				] 
			} 
		CASE night 
			ReplaceCarTextures { 
				array = [ 
					{ 
						src = "JKU_LightCircle_Transparent.png" dest = "textures/cars/JKU_LightCircle" 
					} 
					{ 
						src = "JKU_HeadlightGlow_Transparent.png" dest = "textures/cars/JKU_HeadlightGlow" 
					} 
				] 
			} 
		DEFAULT 
			printf "### no tod set ###" 
	ENDSWITCH 
ENDSCRIPT

SCRIPT Cone_Contacts 
	contacts = [ 
		VECTOR(6, 6, 17) 
		VECTOR(6, 6, -17) 
		VECTOR(-6, 6, 17) 
		VECTOR(-6, 6, -17) 
		VECTOR(-6, 0, -12) 
	] 
ENDSCRIPT


