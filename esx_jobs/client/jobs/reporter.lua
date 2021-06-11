Config.Jobs.reporter = {

	BlipInfos = {
		Sprite = 184,
		Color = 1
	},

	Vehicles = {

		Truck = {
			Spawner = 1,
			Hash = "rumpo",
			Trailer = "none",
			HasCaution = true
		},
		
		Truck2 = {
			Spawner = 2,
			Hash = "newsmav",
			Trailer = "none",
			HasCaution = true
		},
		Truck3 = {
			Spawner = 3,
			Hash = "rumpo",
			Trailer = "none",
			HasCaution = true
		},
		

	},

	Zones = {

		VehicleSpawner = {
			Pos = {x = -141.41, y = -620.80, z = 167.82},
			Size = {x = 2.0, y = 2.0, z = 0.2},
			Color = {r = 204, g = 204, b = 0},
			Marker = 1,
			Blip = true,
			Name = _U("reporter_name"),
			Type = "vehspawner",
			Spawner = 1,
			Hint = _U("reporter_garage"),
			Caution = 0
		},

		VehicleSpawnPoint = {
			Pos = {x = -149.32, y = -592.17, z = 31.42},
			Size = {x = 3.0, y = 3.0, z = 1.0},
			Marker = -1,
			Blip = false,
			Name = _U("service_vh"),
			Type = "vehspawnpt",
			Spawner = 1,
			Heading = 200.1
		},

		VehicleDeletePoint = {
			Pos = {x = -144.22, y = -577.02, z = 31.42},
			Size = {x = 5.0, y = 5.0, z = 0.2},
			Color = {r = 255, g = 0, b = 0},
			Marker = 1,
			Blip = false,
			Name = _U("return_vh"),
			Type = "vehdelete",
			Hint = _U("return_vh_button"),
			Spawner = 1,
			Caution = 0,
			GPS = 0,
			Teleport = {x = -139.09, y = -620.74, z = 167.82}
		},
		
		
		VehicleSpawnerH = {
		  Pos   = { x = -583.5,  y = -929.48, z = 35.83 },
		  Size  = {x = 2.0, y = 2.0, z = 0.2},
		  Color = {r = 204, g = 204, b = 0},
		  Marker= 1,
		  Blip  = true,
		  Name  = _U('reporter_name'),
		  Type  = "vehspawner",
		  Spawner = 2,
		  Hint  = _U('reporter_heli'),
		  Caution = 0
		},
		
		
		VehicleSpawnPointH = {
			Pos = { x = -583.5,  y = -929.48, z = 35.83 },
			Size = {x = 3.0, y = 3.0, z = 1.0},
			Marker = -1,
			Blip = false,
			Name = _U("service_vh"),
			Type = "vehspawnpt",
			Spawner = 2,
			Heading = 352.1
		},

		
		VehicleDeletePointH = {
		  Pos   = { x = -574.95,  y = -933.75, z = 35.83 },
		  Size  = {x = 5.0, y = 5.0, z = 0.2},
		  Color = {r = 255, g = 0, b = 0},
		  Marker= 1,
		  Blip  = false,
		  Name  = _U('return_vh'),
		  Type  = "vehdelete",
		  Hint  = _U('return_vh_button'),
		  Spawner = 2,
		  Caution = 0,
		  GPS = 0,
		  Teleport = { x = -574.95,  y = -933.75, z = 35.83 }
		}
		,
		
		VehicleSpawnerN = {
		  Pos   = { x = -551.344,  y = -935.3488, z = 22.8329},
		  Size  = {x = 2.0, y = 2.0, z = 0.2},
		  Color = {r = 204, g = 204, b = 0},
		  Marker= 1,
		  Blip  = false,
		  Name  = _U('reporter_name'),
		  Type  = "vehspawner",
		  Spawner = 3,
		  Hint  = _U('reporter_garage'),
		  Caution = 0
		},

		
		VehicleSpawnPointN = {
			
			Pos = { x = -551.3443,  y = -935.3488, z = 22.8329},
			Size = {x = 3.0, y = 3.0, z = 1.0},
			Marker = -1,
			Blip = false,
			Name = _U("service_vh"),
			Type = "vehspawnpt",
			Spawner = 3,
			Heading = 352.1
		},
		
		

		VehicleDeletePointN = {
		  Pos   = {x = -560.4,  y = -904.64, z = 22.93},
		  Size  = {x = 5.0, y = 5.0, z = 0.2},
		  Color = {r = 255, g = 0, b = 0},
		  Marker= 1,
		  Blip  = false,
		  Name  = _U('return_vh'),
		  Type  = "vehdelete",
		  Hint  = _U('return_vh_button'),
		  Spawner = 3,
		  Caution = 0,
		  GPS = 0,
		  Teleport = {x = -560.4,  y = -904.64, z = 22.93},
		}

	}
}
