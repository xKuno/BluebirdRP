Config                            = {}

Config.DrawDistance               = 50.0

Config.Marker                     = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }

Config.ReviveReward               = 1200  -- revive reward, set to 0 if you don't want it enabled
Config.AntiCombatLog              = true -- enable anti-combat logging?
Config.LoadIpl                    = false -- disable if you're using fivem-ipl or other IPL loaders

Config.Locale                     = 'en'

local second = 1000
local minute = 60 * second

Config.EarlyRespawnTimer          = 7 * minute  -- Time til respawn is available
Config.BleedoutTimer              = 10 * minute -- Time til the player bleeds out
Config.RespawnDelayAfterRPDeathNoAmbulance = 7 * minute 
Config.RespawnDelayAfterRPDeathNoAmbulanceEmergency = 4 * minute 

Config.EnablePlayerManagement     = true

Config.RemoveWeaponsAfterRPDeath  = false
Config.RemoveCashAfterRPDeath     = false
Config.RemoveItemsAfterRPDeath    = false

-- Let the player pay for respawning early, only if he can afford it.
Config.EarlyRespawnFine           = false
Config.EarlyRespawnFineAmount     = 5000

Config.RespawnPoint = { coords = vector3(-505.7702,-351.517,35.15), heading = 244.5 }

Config.RespawnPointSandy = { coords = vector3(1840.81, 3669.71, 33.69), heading = 202.5 }

Config.RespawnPointPaleto = { coords = vector3(-245.09, 6333.48,32.49), heading = 212.9 }


Config.Hospitals = {

	CentralLosSantos = {

		Blip = {
			coords = vector3(307.7, -1433.4, 28.9),
			sprite = 61,
			scale  = 1.2,
			color  = 2,
			visible = true,
		},

		AmbulanceActions = {
			vector3(322.85974121094,-560.47637939453,27.796863555908)
		},

		Pharmacies = {
			vector3(324.26132202148,-561.10272216797,27.796863555908)
		},

		Vehicles = {
			{
				Spawner = vector3(331.81289672852,-568.71618652344,28.796852111816),
				InsideShop = vector3(446.7, -1355.6, 43.5),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(329.41577148438,-575.25073242188,27.796865463257), heading = 333.6, radius = 4.0 }

				}
			}
		},	

		Helicopters = {
			{
				Spawner = vector3(341.5, -593.5, 74.2),
				InsideShop = vector3(446.7, -1355.6, 43.5),
				Marker = { type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(351.7, -588.7, 74.2), heading = 247.7, radius = 10.0 }
					
				}
			}
		},

		FastTravels = {
			{
				From = vector3(294.7, -1448.1, 29.0),
				To = { coords = vector3(272.8, -1358.8, 23.5), heading = 0.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(275.3, -1361, 23.5),
				To = { coords = vector3(295.8, -1446.5, 28.9), heading = 0.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(340.3, -584.5, 73.1),
				To = { coords = vector3(340.10433959961,-584.44128417969,28.796842575073), heading = 140.6 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(341.46578979492,-580.93377685547,27.796840667725),
				To = { coords = vector3(341.8, -581.6, 74.2), heading = 0.0 },
				Marker = { type = 1, x = 2.0, y = 2.0, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(234.5, -1373.7, 20.9),
				To = { coords = vector3(320.9, -1478.6, 28.8), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},

			{
				From = vector3(317.9, -1476.1, 28.9),
				To = { coords = vector3(238.6, -1368.4, 23.5), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 1.0, r = 102, g = 0, b = 102, a = 100, rotate = false }
			},
			
			{
				From = vector3(468.61, -995.58, 24.74),
				To = { coords = vector3(468.44766235352,-995.52819824219,33.834247589111), heading = 347.0 },
				Marker = { type = 1, x = 1.2, y = 1.2, z = 1.5, r = 0, g = 0, b = 0, a = 30, rotate = false }
			},

			{
				From = vector3(466.73236083984,-994.69183349609,33.215503692627),
				To = { coords = vector3(468.52584838867,-993.13336181641,25.736099243164), heading = 354.0 },
				Marker = { type = 1, x = 1.2, y = 1.2, z = 1.5, r = 0, g = 0, b = 0, a = 30, rotate = false }
			}
		},

		FastTravelsPrompt = {
			{
				From = vector3(237.4, -1373.8, 26.0),
				To = { coords = vector3(251.9, -1363.3, 38.5), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false },
				Prompt = _U('fast_travel')
			},

			{
				From = vector3(256.5, -1357.7, 36.0),
				To = { coords = vector3(235.4, -1372.8, 26.3), heading = 0.0 },
				Marker = { type = 1, x = 1.5, y = 1.5, z = 0.5, r = 102, g = 0, b = 102, a = 100, rotate = false },
				Prompt = _U('fast_travel')
			},

			
			
		}

	},

	
	FireBrigade = {

		Blip = {
			coords = vector3(307.7, -1433.4, 28.9),
			sprite = 61,
			scale  = 1.2,
			color  = 2,
			visible = true,
		},

		AmbulanceActions = {
			vector3(1215.33, -1474.43, 34.07)
		},

		Pharmacies = {
			vector3(1215.70, -1479.11, 34.07)
		},

		Vehicles = {
			{
				Spawner = vector3(1193.83, -1492.87, 34.84),
				InsideShop = vector3(446.7, -1355.6, 43.5),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(1200.99, -1499.74, 34.69), heading = 359.4, radius = 4.0 },

				}
			}
		},

	},
	
	
		RichmanFire = {

		Blip = {
			coords = vector3(-1675.30, 57.49,65.02),
			sprite = 61,
			scale  = 1.2,
			color  = 2,
			visible = true,
		},

		AmbulanceActions = {
			vector3(-1680.43, 68.64, 65.01)
		},

		Pharmacies = {
			vector3(-1676.5, 72.16, 65.01)
		},

		Vehicles = {
			{
				Spawner = vector3(-1673.45, 47.14, 64.98),
				InsideShop = vector3(446.7, -1355.6, 43.5),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(-1667.92, 50.58, 64.85 ), heading = 141.39, radius = 4.0 },

				}
			}
		},

	},
	
	PaletoFire = {

		Blip = {
			coords = vector3(-1671.30, 57.49,65.02),
			sprite = 61,
			scale  = 1.2,
			color  = 2,
			visible = true,
		},

		AmbulanceActions = {
			vector3(-368.30200195312, 6112.0190429688, 31.44822883606)
		},

		Pharmacies = {
			vector3(-372.99938964844, 6107.15234375, 31.449529647827)
		},

		Vehicles = {
			{
				Spawner = vector3(-358.54333496094, 6104.5981445312, 31.49556350708),
				InsideShop = vector3(446.7, -1355.6, 43.5),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(-360.63, 6094.45, 31.44), heading = 315.64, radius = 4.0 },

				}
			}
		},

	},
		SandyFire = {

		Blip = {
			coords = vector3(1305.66, 3659.84, 32.14),
			sprite = 60,
			scale  = 1.2,
			color  = 1,
			visible = true,
		},

		AmbulanceActions = {
			vector3(1300.3, 3672.87, 32.48)
		},

		Pharmacies = {
			vector3(1310.12, 3669.48, 32.48)
		},
		
		Vehicles = {
			{
				Spawner = vector3(1312.41, 3661.74, 33.14),
				InsideShop = vector3(446.7, -1355.6, 43.5),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(1314.07, 3673.3, 33.13), heading = 193.37 , radius = 4.0 },

				}
			}
		},

	},

AirportFire = {

		Blip = {
			coords = vector3(1305.66, 3659.84, 32.14),
			sprite = 60,
			scale  = 1.2,
			color  = 1,
			visible = true,
		},
		
		AmbulanceActions = {
			vector3(-1025.8475341797, -2367.4973144531, 3.94)
		},

		Pharmacies = {
			vector3(-1023.8364257812, -2364.3483886719, 3.94)
		},

		Helicopters = {
			{
				Spawner = vector3(-1031.46, -2378.60, 14.02),
				InsideShop = vector3(446.7, -1355.6, 43.5),
				Marker = { type = 34, x = 1.5, y = 1.5, z = 1.5, r = 100, g = 150, b = 150, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(-1001.08, -2378.24, 13.94), heading = 144.09, radius = 10.0 }
				}	
            }
		},

		Vehicles = {
			{
				Spawner = vector3(-1069.94, -2378.79, 14.09),
				InsideShop = vector3(446.7, -1355.6, 43.5),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(-1071.04, -2388.07, 13.94), heading = 59.40 , radius = 4.0 },

				}
			}
		},

	},
	
	

	MtZonar_Ambo = {
		Blip = {
			coords = vector3(1697.26, 3585.46, 3.5443),
			sprite = 60,
			scale  = 1.2,
			color  = 1,
			visible = false,
		},



		AmbulanceActions = {
			vector3(-444.14633178711,-310.21569824219,33.910564422607)
		},

		Pharmacies = {
			vector3(-454.02792358398,-308.60052490234,33.910758972168)
		},

		Vehicles = {
			{
				Spawner = vector3(-425.17251586914,-341.09149169922,24.229421615601),
				InsideShop = vector3(446.7, -1355.6, 43.5),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(-431.02835083008,-342.20025634766,24.229417800903), heading = 103.12 , radius = 5.0 },

					

				}
			}
		},
	},
	
	PillboxUpper = {
		Blip = {
			coords = vector3(1697.26, 3585.46, 3.5443),
			sprite = 60,
			scale  = 1.2,
			color  = 1,
			visible = false,
		},



		AmbulanceActions = {
			vector3(303.8, -570.32, 42.28)
		},

		Pharmacies = {
			vector3(309.63, -568.17, 42.28)
		},


	},
	
	Sandy = {
		Blip = {
			coords = vector3(1697.26, 3585.46, 3.5443),
			sprite = 60,
			scale  = 1.2,
			color  = 1,
			visible = false,
		},



		AmbulanceActions = {
			vector3(1834.48, 3690.67, 33.27)
		},

		Pharmacies = {
			vector3(1816.12, 3676.38, 33.27)
		},
		
		Vehicles = {
			{
				Spawner = vector3(1839.92, 3693.76, 34.37),
				InsideShop = vector3(446.7, -1355.6, 43.5),
				Marker = { type = 36, x = 1.0, y = 1.0, z = 1.0, r = 100, g = 50, b = 200, a = 100, rotate = true },
				SpawnPoints = {
					{ coords = vector3(1858.63,  3712.6, 33.27), heading = 234.17 , radius = 4.0 },

				}
			}
		},

	},
	
	
	
	
	
	
	

	
}

Config.AuthorizedVehicles = {

	ambulance = {
		{ model = 'ambulance', label = 'Ambulance Van', price = 1},
		{ model = 'ambovito', label = 'Ambulance Vito Van', price = 1},
		{ model = 'cfacar', label = 'Ambulance Car', price = 1},
        { model = 'avkluger', label = 'Ambulance AV/MICA Kluger', price = 1},
		{ model = 'ambobike', label = 'Ambulance BMW Bike', price = 1},
		{ model = 'ambovic', label = 'Ambulance Van - New', price = 1},

		
	},

	doctor = {
		{ model = 'ambulance', label = 'Ambulance Van', price = 1},
		{ model = 'ambovito', label = 'Ambulance Vito Van', price = 1},
		{ model = 'cfacar', label = 'Ambulance Car', price = 1},
		{ model = 'avkluger', label = 'Ambulance AV/MICA Kluger', price = 1},
		{ model = 'ambobike', label = 'Ambulance BMW Bike', price = 1},
		{ model = 'ambovic', label = 'Ambulance Van - New', price = 1},
	},

	chief_doctor = {
		{ model = 'ambulance', label = 'Ambulance Van', price = 1},
		{ model = 'ambovito', label = 'Ambulance Vito Van', price = 1},
		{ model = 'cfacar', label = 'Ambulance Car', price = 1},
		{ model = 'avkluger', label = 'Ambulance AV/MICA Kluger', price = 1},
		{ model = 'ambobike', label = 'Ambulance BMW Bike', price = 1},
		{ model = 'ambovic', label = 'Ambulance Van - New', price = 1},
	},

	boss = {
		{ model = 'ambulance', label = 'Ambulance Van', price = 1},
                { model = 'av78s', label = 'Ambulance Landcruiser', price = 1},
		{ model = 'ambovic', label = 'Ambulance Van - New', price = 1},
		{ model = 'ambovito', label = 'Ambulance Vito Van', price = 1},
		{ model = 'avkluger', label = 'Ambulance AV/MICA Kluger', price = 1},
		{ model = 'ambobike', label = 'Ambulance BMW Bike', price = 1},
		{ model = 'mcv', label = 'Mobile Command Centre', price = 1},
		{ model = 'cfacar', label = 'CFA/Ambo Holden Evoke', price = 1},
                { model = 'coloradofcv', label = 'CFA Holden Colorado FCV', price = 1},
		{ model = 'ultralight', label = 'Ultralight', price = 1},
		{ model = 'firetruk1', label = 'Pumper', price = 1},
		{ model = 'firetruk3', label = 'Tanker', price = 1},
                { model = 'arff1', label = 'ARFF CRASH BOOM 1', price = 1},
                { model = 'arff2', label = 'ARFF CRASH BOOM 2', price = 1},
                { model = 'arff3', label = 'ARFF CRASH TENDER 3', price = 1},
                { model = 'arff4', label = 'ARFF CRASH TENDER 4', price = 1},

	
	},
	
	cfa = {
        { model = 'coloradofcv', label = 'CFA Holden Colorado FCV', price = 1},
		{ model = 'ultralight', label = 'Ultralight', price = 1},
		{ model = 'firetruk1', label = 'Pumper', price = 1},
		{ model = 'firetruk3', label = 'Tanker', price = 1},
		{ model = 'mcv', label = 'Mobile Command Vehicle', price = 1},
	}

}

Config.AuthorizedHelicopters = {

	ambulance = {},

	doctor = {
			{ model = 'aw139', label = 'HEMS AW139', price = 1 },
			{ model = 'swift', label = 'HEMS', price = 1 },
			{ model = 'seasparrow', label = 'Sea Sparrow', price = 1 }
	},

	chief_doctor = {
		{ model = 'aw139', label = 'HEMS AW139', price = 1 },
		{ model = 'swift', label = 'HEMS', price = 1 },
		{ model = 'seasparrow', label = 'Sea Sparrow', price = 1 }
	},

	boss = {
		{ model = 'aw139', label = 'HEMS AW139', price = 1 },
		{ model = 'swift', label = 'HEMS', price = 1 },
                { model = 'firehawk', label = 'CFA FireHawk', price = 1 },
		{ model = 'seasparrow', label = 'Sea Sparrow', price = 1 }
	},
	
	cfa = {

		{ model = 'firehawk', label = 'CFA FireHawk', price = 1 },
		{ model = 'aw139', label = 'HEMS AW139', price = 1 },
		{ model = 'seasparrow', label = 'Sea Sparrow', price = 1 }
	}

}
