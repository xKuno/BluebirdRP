Config              = {}
Config.DrawDistance = 100.0
Config.MaxDelivery	= 10
Config.TruckPrice	= 30     -- old config from orginal script not used in this version.
Config.Locale       = 'en'
Config.BagPay       = 40     -- Pay per bag pulled from bin.
Config.MulitplyBags = true   -- Multiplies BagPay by number of workers - 4 max.

Config.Trucks = {
	"trash",
	"trash2",
	--"biff",  --took this vehilce out for aesthetics reasons.  Trying to find animation that works throwing the garbage up into the truck.
	--"scrap"
}

Config.Cloakroom = {
	CloakRoom = {
			Pos   = {x = -321.70, y = -1545.94, z = 30.02},
			Size  = {x = 3.0, y = 3.0, z = 1.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1
		},
}

Config.Zones = {
	VehicleSpawner = {
			Pos   = {x = -316.16, y = -1536.08, z = 26.65},
			Size  = {x = 3.0, y = 3.0, z = 1.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 1
		},

	VehicleSpawnPoint = {
			Pos   = {x = -328.50, y = -1520.99, z = 27.53},
			Size  = {x = 3.0, y = 3.0, z = 1.0},
			Type  = -1
		},
}
Config.DumpstersAvaialbe = {
    "prop_dumpster_01a",
    "prop_dumpster_02a",
	"prop_dumpster_02b",
	"prop_dumpster_3a",
	"prop_dumpster_4a",
	"prop_dumpster_4b",
	"prop_skip_01a",
	"prop_skip_02a",
	"prop_skip_06a",
	"prop_skip_05a",
	"prop_skip_03",
	"prop_skip_10a"
}


Config.Livraison = {
-------------------------------------------Los Santos
	-- fleeca
	Delivery1LS = {
			Pos   = {x = 114.83280181885, y = -1462.3127441406, z = 29.295083999634},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 4,
			Paye = math.random(520,790)
		},
	-- fleeca2
	Delivery2LS = {
			Pos   = {x = -6.0481648445129, y = -1566.2338867188, z = 29.209197998047},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 4,
			Paye = math.random(550,790)
		},
	-- blainecounty
	Delivery3LS = {
			Pos   = {x = -1.8858588933945, y = -1729.5538330078, z = 29.300233840942},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 4,
			Paye = math.random(550,790)
		},
	-- PrincipalBank
	Delivery4LS = {
			Pos   = {x = 196.06307983398, y = -1810.1711425781, z = 28.479553222656},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 4,
			Paye = math.random(470,790)
		},
	-- route68e
	Delivery5LS = {
			Pos   = {x = 358.94696044922, y = -1805.0723876953, z = 28.966590881348},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 4,
			Paye = math.random(450,795)
		},
	--littleseoul
	Delivery6LS = {
			Pos   = {x = 481.36560058594, y = -1274.8297119141, z = 29.64475440979},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 4,
			Paye = math.random(490,790)
		},
	--legionsquare garage
	Delivery7LS = {
			Pos   = {x = 49.44,  y = -832.84, z = 30.99},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 4,
			Paye = math.random(590,790)
		},
	--fleecacarpark
	Delivery8LS = {
			Pos   = {x = 449.89, y = -577.18, z = 28.2},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 4,
			Paye = math.random(545,790)
		},
	--Mt Haan Dr Radio Tower
	Delivery9LS = {
			Pos   = {x = 342.78308105469, y = -1036.4720458984, z = 29.194206237793},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 4,
			Paye = math.random(550,890)
		},
	--Senora Way Fuel Depot
	Delivery10LS = {
			Pos   = {x = 462.17517089844, y = -949.51434326172, z = 27.959424972534},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 4,
			Paye = math.random(480,750)
		},
	--Davis
	Delivery11LS = {
			Pos   = {x = -206.99, y = -1720.0, z =  32.66},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 4,
			Paye = math.random(550,790)
		},
			
	 --Davis cafe
	Delivery11LS = {
			Pos   = {x = 409.46, y = -1898.08, z =  25.59},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 4,
			Paye = math.random(480,790)
		},		
		
			
	 --Davis units
	Delivery12LS = {
			Pos   = {x = 263.04, y = -2056.96, z =  17.42},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 4,
			Paye = math.random(480,750)
		},		
		
	Delivery13LS = {  --Construction Site Alta St
			Pos   = {x = 22.65, y = -370.58, z = 39.31},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 4,
			Paye = math.random(550,650)
		},		
		
	Delivery14LS = {  --LSCustoms
			Pos   = {x = -364.33, y = -143.68, z = 38.52},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 4,
			Paye = math.random(450,850)
		},		
		
	Delivery15LS = {  --Little Seoul
			Pos   = {x = -758.44 , y = -906.49, z =  19.7},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 4,
			Paye = math.random(550,850)
		},		
				
		
		
		 
				   
		
------------------------------------------- 2nd Patrol 
	-- Blaine Cty Bank
	Delivery1BC = {
			Pos   = {x = -136.36501, y = 6468.2254, z = 31.146},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 4,
			Paye =  math.random(550,750)
		},
	-- Paleto Garage rear
	Delivery2BC = {
			Pos   = {x = 121.245, y = 6653.045, z = 31.3558},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 4,
			Paye =  math.random(450,850)
		},
	-- Bellfarms Lot
	Delivery3BC = {
			Pos   = {x = 173.2861, y = 6441.421, z = 31.03},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 4,
			Paye =  math.random(550,680)
		},
	-- Car Wash Left
	Delivery4BC = {
			Pos   = {x = -40.122, y = 6438.1511, z = 31.182},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 4,
			Paye = math.random(480,690)
		},
	-- Bay View
	Delivery5BC = {
			Pos   = {x = -684.45001, y = 5782.4117, z = 17.0501},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 4,
			Paye = math.random(450,750)
		},
	-- Lumber Mill	
	Delivery6BC = {
			Pos   = {x = -584.331, y = 5234.3511, z = 71.47},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 4,
			Paye = math.random(590,690)
		},
	-- Paleto Riders Rear
	Delivery7BC = {
			Pos   = {x = -381.1512, y = 6068.361, z = 31.46},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 4,
			Paye = math.random(590,680)
		},
	-- Helmuts Car center
	Delivery8BC = {
			Pos   = {x = -204.001, y = 6249.638, z = 31.236},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 4,
			Paye = math.random(490,780)
		},
	-- Liquor shop	
	Delivery9BC = {
			Pos   = {x = -185.445, y = 6323.62814941, z = 31.14975891113},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 4,
			Paye = math.random(490,880)
		},
	-- UP Atom Diner
	Delivery10BC = {
			Pos   = {x = 1571.678955078, y = 6456.53198242, z = 24.422895},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 4,
			Paye = math.random(490,790)
		},
		
	RetourCamion = {
			Pos   = {x = -335.26095581055, y = -1529.5614013672, z = 27.565467834473},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 4,
			Paye = 0
		},
	
	AnnulerMission = {
			Pos   = {x = -314.62796020508, y = -1514.5662841797, z = 27.677434921265},
			Color = {r = 204, g = 204, b = 0},
			Size  = {x = 5.0, y = 5.0, z = 3.0},
			Color = {r = 204, g = 204, b = 0},
			Type  = 4,
			Paye = 0
		},
}
