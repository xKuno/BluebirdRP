Config              = {}
Config.DrawDistance = 100.0
Config.MaxDelivery	= 6
Config.TruckPrice	= 200
Config.Locale       = 'en'

Config.Trucks = {
	"faggio",
	"foodcar4"
	--"packer"	
}

Config.Cloakroom = {
	CloakRoom = {
			Pos   = {x = 217.59413146973, y = -28.255523681641, z = 69.213890075684},
			Size  = {x = 3.0, y = 3.0, z = 1.0},
			Color = {r = 0, g = 120, b = 172},
			Type  = 1
		},
}

Config.Zones = {
	VehicleSpawner = {
			Pos   = {x = 224.60891723633, y = -32.909862518311, z = 69.219039916992},
			Size  = {x = 3.0, y = 3.0, z = 1.0},
			Color = {r = 0, g = 120, b = 172},
			Type  = 1
		},

	VehicleSpawnPoint = {
			Pos   = {x = 231.92344665527, y = -36.398815155029, z = 69.210906982422},
			Size  = {x = 3.0, y = 3.0, z = 1.0},
			Type  = -1
		},
}

Config.Livraison = {
-------------------------------------------Los Santos
	-- Strawberry avenue et Davis avenue
	Delivery1LS = {
			Pos   = {x = 121.0655, y = -1488.4984, z = 28.0},
			Color = {r = 0, g = 120, b = 172},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 0, g = 120, b = 172},
			Type  = 1,
			Paye = math.random(550,900)
		},
	-- a cot� des flic
	Delivery2LS = {
			Pos   = {x = 451.4836, y = -899.0954, z = 27.5},
			Color = {r = 0, g = 120, b = 172},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 0, g = 120, b = 172},
			Type  = 1,
			Paye = math.random(450,1200)
		},
	-- vers la plage
	Delivery3LS = {
			Pos   = {x = -1129.4438, y = -1607.2420, z = 3.9},
			Color = {r = 0, g = 120, b = 172},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 0, g = 120, b = 172},
			Type  = 1,
			Paye = math.random(450,750)
		},
	-- studio 1
	Delivery4LS = {
			Pos   = {x = -1064.7435, y = -553.4235, z = 32.5},
			Color = {r = 0, g = 120, b = 172},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 0, g = 120, b = 172},
			Type  = 1,
			Paye = math.random(400,750)
		},
	-- popular street et el rancho boulevard
	Delivery5LS = {
			Pos   = {x = 809.5350, y = -2024.2238, z = 28.0},
			Color = {r = 0, g = 120, b = 172},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 0, g = 120, b = 172},
			Type  = 1,
			Paye = math.random(550,1500)
		},
	--Alta street et las lagunas boulevard
	Delivery6LS = {
			Pos   = {x = 63.2668, y = -227.9965, z = 50.0},
			Color = {r = 0, g = 120, b = 172},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 0, g = 120, b = 172},
			Type  = 1,
			Paye = math.random(650,700)
		},
	--Rockford Drive Noth et boulevard del perro
	Delivery7LS = {
			Pos   = {x = -1338.6923, y = -402.4188, z = 34.9},
			Color = {r = 0, g = 120, b = 172},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 0, g = 120, b = 172},
			Type  = 1,
			Paye = math.random(650,700)
		},
	--Rockford Drive Noth et boulevard del perro
	Delivery8LS = {
			Pos   = {x = 548.6097, y = -206.3496, z = 52.5},
			Color = {r = 0, g = 120, b = 172},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 0, g = 120, b = 172},
			Type  = 1,
			Paye = math.random(650,900)
		},
	--New empire way (airport)
	Delivery9LS = {
			Pos   = {x = -1141.9106, y = -2699.9340, z = 13.0},
			Color = {r = 0, g = 120, b = 172},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 0, g = 120, b = 172},
			Type  = 1,
			Paye = math.random(750,990)
		},
	--Rockford drive south
	Delivery10LS = {
			Pos   = {x = -640.0313, y = -1224.9519, z = 10.5},
			Color = {r = 0, g = 120, b = 172},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 0, g = 120, b = 172},
			Type  = 1,
			Paye = math.random(750,900)
		},
	Delivery11LS = {
			Pos   = vector3(930.98431396484,-5.377206325531,78.092292785645),
			Color = {r = 0, g = 120, b = 172},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 0, g = 120, b = 172},
			Type  = 1,
			Paye = math.random(750,950)
		},
	Delivery12LS = {
			Pos   = vector3(1387.7655029297,-576.62066650391,73.66625213623),
			Color = {r = 0, g = 120, b = 172},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 0, g = 120, b = 172},
			Type  = 1,
			Paye = math.random(650,850)
		},		
		
	Delivery13LS = {
			Pos   = vector3(1148.0217285156,-1006.1607666016,44.267032623291),
			Color = {r = 0, g = 120, b = 172},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 0, g = 120, b = 172},
			Type  = 1,
			Paye = math.random(750,850)
		},		
	Delivery14LS = {
			Pos   = vector3(1152.8979492188,-1525.0192871094,34.170307159424),
			Color = {r = 0, g = 120, b = 172},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 0, g = 120, b = 172},
			Type  = 1,
			Paye = math.random(550,850)
		},	

	Delivery15LS = {
			Pos   = vector3(456.57315063477,-594.3427734375,27.829940795898),
			Color = {r = 0, g = 120, b = 172},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 0, g = 120, b = 172},
			Type  = 1,
			Paye = math.random(550,850)
		},			
					
	Delivery16LS = {
			Pos   = vector3(-17.81640625,-968.49029541016,28.72696685791),
			Color = {r = 0, g = 120, b = 172},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 0, g = 120, b = 172},
			Type  = 1,
			Paye = math.random(550,850)
		},		
	Delivery17LS = {
			Pos   = vector3(-306.2317199707,-1174.3118896484,22.748664855957),
			Color = {r = 0, g = 120, b = 172},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 0, g = 120, b = 172},
			Type  = 1,
			Paye = math.random(550,850)
		},		
	Delivery18LS = {
			Pos   = vector3(-138.51103210449,-1562.1697998047,33.671051025391),
			Color = {r = 0, g = 120, b = 172},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 0, g = 120, b = 172},
			Type  = 1,
			Paye = math.random(550,850)
		},			
	
		
------------------------------------------- Blaine County
	-- panorama drive
	Delivery1BC = {
			Pos   = {x = 1999.5457, y = 3055.0686, z = 45.5},
			Color = {r = 0, g = 120, b = 172},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 0, g = 120, b = 172},
			Type  = 1,
			Paye = math.random(750,1600)
		},
	-- route 68
	Delivery2BC = {
			Pos   = {x = 555.4768, y = 2733.9533, z = 41.0},
			Color = {r = 0, g = 120, b = 172},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 0, g = 120, b = 172},
			Type  = 1,
			Paye = math.random(750,1200)
		},
	-- Algonquin boulevard et cholla springs avenue
	Delivery3BC = {
			Pos   = {x =1685.1549, y = 3752.0849, z = 33.0},
			Color = {r = 0, g = 120, b = 172},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 0, g = 120, b = 172},
			Type  = 1,
			Paye = math.random(750,1200)
		},
	-- Joshua road
	Delivery4BC = {
			Pos   = {x = 182.7030, y = 2793.9829, z = 44.5},
			Color = {r = 0, g = 120, b = 172},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 0, g = 120, b = 172},
			Type  = 1,
			Paye = math.random(750,1300)
		},
	-- East joshua road
	Delivery5BC = {
			Pos   = {x = 2710.6799, y = 4335.3168, z = 44.8},
			Color = {r = 0, g = 120, b = 172},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 0, g = 120, b = 172},
			Type  = 1,
			Paye = math.random(650,1500)
		},
	-- Seaview road
	Delivery6BC = {
			Pos   = {x = 1930.6518, y = 4637.5878, z = 39.3},
			Color = {r = 0, g = 120, b = 172},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 0, g = 120, b = 172},
			Type  = 1,
			Paye = math.random(550,1200)
		},
	-- Paleto boulevard
	Delivery7BC = {
			Pos   = {x = -448.2438, y = 5993.8686, z = 30.3},
			Color = {r = 0, g = 120, b = 172},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 0, g = 120, b = 172},
			Type  = 1,
			Paye = math.random(650,1200)
		},
	-- Paleto boulevard et Procopio drive
	Delivery8BC = {
			Pos   = {x = 107.9181, y = 6605.9750, z = 30.8},
			Color = {r = 0, g = 120, b = 172},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 0, g = 120, b = 172},
			Type  = 1,
			Paye = math.random(600,1200)
		},
	-- Marina drive et joshua road
	Delivery9BC = {
			Pos   = {x = 916.6915, y = 3568.7783, z = 32.7},
			Color = {r = 0, g = 120, b = 172},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 0, g = 120, b = 172},
			Type  = 1,
			Paye = math.random(680,1200)
		},
	-- Pyrite Avenue
	Delivery10BC = {
			Pos   = {x = -128.6733, y = 6344.5493, z = 31.0},
			Color = {r = 0, g = 120, b = 172},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 0, g = 120, b = 172},
			Type  = 1,
			Paye = math.random(770,1200)
		},
	Delivery11BC = { --Prison
			Pos   = vector3(1855.6469726562,2588.6291503906,44.999225616455),
			Color = {r = 0, g = 120, b = 172},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 0, g = 120, b = 172},
			Type  = 1,
			Paye = math.random(670,1100)
		},
	
	Delivery12BC = { --Sandy
			Pos   = vector3(2174.6120605469,3352.1027832031,44.707656860352),
			Color = {r = 0, g = 120, b = 172},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 0, g = 120, b = 172},
			Type  = 1,
			Paye = math.random(670,1000)
		},
	
	Delivery13BC = { --GMG
			Pos   = vector3(786.61505126953,3555.6298828125,34.350070953369),
			Color = {r = 0, g = 120, b = 172},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 0, g = 120, b = 172},
			Type  = 1,
			Paye = math.random(670,990)
		},
	
	
	
	
	
	RetourCamion = {
			Pos   = {x = 235.91499328613, y = -40.914516448975, z = 68.621870422363},
			Color = {r = 0, g = 120, b = 172},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 0, g = 120, b = 172},
			Type  = 1,
			Paye = 0
		},
	
	AnnulerMission = {
			Pos   = {x = 231.03507995605, y = -41.948207855225, z = 68.35306854248},
			Color = {r = 0, g = 120, b = 172},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 0, g = 120, b = 172},
			Type  = 1,
			Paye = 0
		},
}
