Config              = {}
Config.DrawDistance = 100.0
Config.MaxDelivery	= 10
Config.TruckPrice	= 30
Config.Locale       = 'en'

Config.Trucks = {
	"phantom",
	"hauler",
	"packer",
	
}

Config.Cloakroom = {
	CloakRoom = {
			Pos   = {x = 557.93, y = -2327.90, z = 4.82},
			Size  = {x = 3.0, y = 3.0, z = 1.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1
		},
}

Config.Zones = {
	VehicleSpawner = {
			Pos   = {x = 554.59, y = -2314.43, z = 4.86},
			Size  = {x = 3.0, y = 3.0, z = 1.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1
		},

	VehicleSpawnPoint = {
			Pos   = {x = 493.59, y = -2228.43, z = 5.86},
			Size  = {x = 3.0, y = 3.0, z = 1.0},
			Type  = -1
		},
}

Config.Livraison = {
-------------------------------------------Los Santos
	-- alta st
	Delivery1LS = {
			Pos   = {x = -315.25280181885, y = -1484.3127441406, z = 29.795083999634},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = math.random(650, 980)
		},
	-- Capital Blvd
	Delivery2LS = {
			Pos   = {x = 1198.8481648445129, y = -1405.5338867188, z = 34.809197998047},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = math.random(650, 980)
		},
	-- Olympic Fwy
	Delivery3LS = {
			Pos   = {x = 268.8858588933945, y = -1242.5538330078, z = 28.800233840942},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = math.random(650, 950)
		},
	-- Innocence Blvd
	Delivery4LS = {
			Pos   = {x = -520.76307983398, y = -1203.5711425781, z = 17.879553222656},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = math.random(550, 850)
		},
	-- Popular St
	Delivery5LS = {
			Pos   = {x = 816.04696044922, y = -1034.723876953, z = 25.966590881348},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = math.random(550, 950)
		},
	-- Ginger St
	Delivery6LS = {
			Pos   = {x = -728.16560058594, y = -925.4297119141, z = 18.64475440979},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = math.random(550, 980)
		},
	-- Grove St
	Delivery7LS = {
			Pos   = {x = -74.40010375977, y = -1759.52482910156, z = 29.196590423584},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = math.random(690, 900)
		},
	-- West Eclipse Blvd
	Delivery8LS = {
			Pos   = {x = -2108.88079528809, y = -319.91204833984, z = 12.618426895142},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = math.random(550, 800)
		},
	--South Rockford Dr
	Delivery9LS = {
			Pos   = {x = -1436.78308105469, y = -274.4720458984, z = 45.694206237793},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = math.random(600, 900)
		},
	--Mirror Park Blvd
	Delivery10LS = {
			Pos   = {x = 1179.67517089844, y = -325.51434326172, z = 68.959424972534},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = math.random(500, 800)
		},
------------------------------------------- 2nd Patrol 
	-- Fenwell Pl
	Delivery1BC = {
			Pos   = {x = 631.39698730469, y = 258.95416259766, z = 102.678547286987},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = math.random(500, 900)
		},
	-- Palomino FWY
	Delivery2BC = {
			Pos   = {x = 2577.42503662109, y = 362.20517578125, z = 108.00943069458},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = math.random(500, 900)
		},
	-- Banham Canyon Dr
	Delivery3BC = {
			Pos   = {x = -1804.46038208008, y = 800.75577392578, z = 138.082489776611},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = math.random(500, 900)
		},
	-- Route 68
	Delivery4BC = {
			Pos   = {x = -2556.56984863281, y = 2337.93978271484, z = 32.494501113892},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = math.random(500, 1800)
		},
	-- Senora Rd
	Delivery5BC = {
			Pos   = {x = 1703.528998565674, y = 6420.07525024414, z = 32.028874969482},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = math.random(650, 1700)
		},
	-- Senora FWY
	Delivery6BC = {
			Pos   = {x = 2683.143946838379, y = 3262.52261657715, z = 55.061594390869},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = math.random(980, 1500)
		},
	-- Route 68 Cafe
	Delivery7BC = {
			Pos   = {x = 1037.548055267334, y = 2677.737454223633, z = 39.049073028564},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = math.random(650, 1400)
		},
	-- Grapeseed
	Delivery8BC = {
			Pos   = {x = 1690.60873413086, y = 4918.71878662109, z = 41.860565948486},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye =  math.random(800, 1700)
		},
	-- Sandy shores
	Delivery9BC = {
			Pos   = {x = 2005.96835327148, y = 3771.185572814941, z = 31.854975891113},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = math.random(900, 1550)
		},
	-- Paleto bay Ron
	Delivery10BC = {
			Pos   = {x = 176.09678955078, y = 6603.07653198242, z = 31.087702941895},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = math.random(850, 1650)
		},
		
	RetourCamion = {
			Pos   = {x = 522.16095581055, y = -2114.4614013672, z = 5.865467834473},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 0
		},
	
	AnnulerMission = {
			Pos   = {x = 464.22796020508, y = -2155.5662841797, z = 5.477434921265},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1,
			Paye = 0
		},
}
