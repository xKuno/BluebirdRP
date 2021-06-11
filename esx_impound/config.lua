Config 					= {}
Config.Locale			= 'fr'

Config.Impound 			= {
	Name = "MissionRow",
	RetrieveLocation = vector3( 826.30,-1290.20, 28.60),
	StoreLocation = vector3(1100.62, -789.59, 58.50), 
	OtherSpawnSandy = vector3(1724.1207275391,3318.5803222656,41.828262329102),
	SpawnLocations = {
		{ Pos = vector3(818.21, -1334.90, 26.10) , h = 180.00 },
		{ Pos = vector3(818.21, -1341.20, 26.10) , h = 180.00 },
		{ Pos = vector3(818.21, -1349.00,  26.10) , h = 180.00 },
		{ Pos = vector3(818.21,-1355.00,  26.10) , h = 180.00 },
		{ Pos = vector3(818.21,-1363.00, 26.10) , h = 180.00 },
	},
	AdminTerminalLocations = {
		vector3( 830.30, -1311.09, 28.13),
		vector3(440.18, -976.00, 30.68)
	}
}



Config.Rules = {
	maxWeeks		= 4,
	maxDays			= 6,
	maxHours		= 24,

	minFee			= 0,
	maxFee 			= 5000,

	minReasonLength	= 10,
}

Config.Zones = {
	place = {
		Pos 	= vector3(1100.62, -789.59,  58.50),
		Size 	= {x = 1.5, y = 1.5, z = 1.5},
		Color 	= {r = 249, g = 81, b = 84},
		Color2 	= {r = 81, g = 249, b = 221},
		Type  	= 6,
		Type2 	= 36,
	},	
	placeSandy = {
		Pos 	= vector3(1724.1807861328,3318.2043457031,41.82829284668),
		Size 	= {x = 1.5, y = 1.5, z = 1.5},
		Color 	= {r = 249, g = 81, b = 84},
		Color2 	= {r = 81, g = 249, b = 221},
		Type  	= 6,
		Type2 	= 36,
	},	
	SortieFourriere = {
		Pos 	= vector3(825.21,-1290.10, 28.24),
		Size 	= {x = 1.5, y = 1.5, z = 1.5},
		Color 	= {r = 249, g = 81, b = 84},
		Color2 	= {r = 63, g = 191, b = 127},
		Type  	= 6,
		Type2 	= 29,
	}
}

Config.Blip = {
	Fourriere = {
		Pos     = vector3(872.07,-1350.49, 26.30 ),
		Sprite  = 380,
		Scale   = 1.2,
		Colour  = 38,
		Name    = "Impound"
	},
	Parking1 = {
		Pos     = vector3(818.01,-1334.19,26.10 ),
		Sprite  = 267,
		Scale   = 0.5,
		Colour  = 38,
		Name    = "Impound Parking"
	},
	Parking2 = {
		Pos     = vector3( 818.17,-1341.39, 26.10),
		Sprite  = 267,
		Scale   = 0.5,
		Colour  = 38,
		Name    = "Impound Parking"
	},
	Parking3 = {
		Pos     = vector3(818.19, -1348.67, 26.10),
		Sprite  = 267,
		Scale   = 0.5,
		Colour  = 38,
		Name    = "Impound Parking"
	},
	Parking4 = {
		Pos     = vector3( 818.09,  -1355.83, 26.10 ),
		Sprite  = 267,
		Scale   = 0.5,
		Colour  = 38,
		Name    = "Impound Parking"
	},
	Parking5 = {
		Pos     = vector3( 817.71, -1363.25, 26.10 ),
		Sprite  = 267,
		Scale   = 0.5,
		Colour  = 38,
		Name    = "Impound Parking"
	},
}
--------------------------------------------------------------------------------
----------------------- SERVERS WITHOUT ESX_MIGRATE ----------------------------
---------------- This could work, it also could not work... --------------------
--------------------------------------------------------------------------------
-- Should be true if you still have an owned_vehicles table without plate column.
Config.NoPlateColumn = false
-- Only change when NoPlateColumn is true, menu's will take longer to show but otherwise you might not have any data.
-- Try increments of 250
Config.WaitTime = 250
