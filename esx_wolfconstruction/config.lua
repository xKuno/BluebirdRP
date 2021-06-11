Config                            = {}
Config.Locale = 'en'

Config.DrawDistance               = 100.0
Config.MaxInService               = -1
Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = false

Config.NPCSpawnDistance           = 500.0
Config.NPCNextToDistance          = 25.0
Config.NPCJobEarnings             = { min = 15, max = 40 }

Config.Vehicles = {
	'adder',
	'asea',
	'asterope',
	'banshee',
	'buffalo'
}

Config.Zones = {



	Blip = {
		Pos   = {x = 1019.64, y = -2330.82, z = 48.0},
		Size  = {x = 0.0, y = 0.0, z = 0.0},
		Color = {r = 0, g = 0, b = 0},
		Type  = 1
	},


	wolfcActions2 = {
		Pos   = {x = 1017.47, y = -2281.54, z = 29.40	 },
		Size  = {x = 1.3, y = 1.3, z = 1.1},
		Color = {r = 120, g = 200, b = 255},
		Type  = 1
	},


	wolfcActions = {
		Pos   = {x = 1010.65, y = -2289.38, z = 29.40},
		Size  = {x = 1.3, y = 1.4, z = 1.1},
		Color = {r = 225, g = 0, b = 0},
		Type  = 1
	},

	Garage = {
		Pos   = { x = 0.0, y = 0.0, z = 0.0 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 1
	},

	Craft = {
		Pos   = { x = 0.0, y = 0.0, z = 0.0 },
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = 1
	},

	VehicleSpawnPoint = {
		Pos   = {x = 1004.85, y = -2310.9, z = 29.42},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Type  = -1
	},
	
	

	VehicleDeleter = {
		Pos   = {x = 1005.54, y = -2367.06, z = 29.40},
		Size  = {x = 5.0, y = 5.0, z = 2.0},
		Color = {r = 255, g = 0, b = 0},
		Type  = 1
	},

	VehicleDelivery = {
		Pos   = { x = 0.0, y = 0.0, z = 0.0 },
		Size  = { x = 20.0, y = 20.0, z = 3.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = -1
	}
}


Config.Towables = {
	vector3(-2480.9, -212.0, 17.4),

}

for k,v in ipairs(Config.Towables) do
	Config.Zones['Towable' .. k] = {
		Pos   = v,
		Size  = { x = 1.5, y = 1.5, z = 1.0 },
		Color = { r = 204, g = 204, b = 0 },
		Type  = -1
	}
end


