Config                            = {}

Config.DrawDistance               = 30.0
Config.MarkerType                 = 22
Config.MarkerSize                 = { x = 2.5, y = 2.5, z = 2.5 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = true -- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableSocietyOwnedVehicles = false
Config.EnableLicenses             = true -- enable if you're using esx_license

Config.EnableHandcuffTimer        = false -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 25 * 60000 -- 10 mins

Config.EnableJobBlip              = true -- enable blips for colleagues, requires esx_society

Config.MaxInService               = -1
Config.Locale                     = 'en'

Config.PoliceStations = {

	LSPD = {

		Blip = {
			Pos     = { x = 425.130, y = -979.558, z = 30.711 },
			Sprite  = 60,
			Display = 4,
			Scale   = 1.2,
			Colour  = 29,
		},

		-- https://wiki.rage.mp/index.php?title=Weapons
		AuthorizedWeapons = {
		  { name = 'WEAPON_NIGHTSTICK',       price = 250 },
		  { name = 'WEAPON_COMBATPISTOL',     price = 1500 },
		  { name = 'WEAPON_STUNGUN',       price = 1000 },
		  { name = 'WEAPON_FLASHLIGHT',       price = 50 },
		  { name = 'WEAPON_FIREEXTINGUISHER', price = 1 },
		--  { name = 'WEAPON_CARBINERIFLE',       price = 5500 },
		  { name = 'WEAPON_PROXMINE',       price = 1 },
		  { name = 'WEAPON_VINTAGEPISTOL',       price = 1 },

		 -- { name = 'WEAPON_SMOKEGRENADE',       price = 1 },
		 -- { name = 'WEAPON_SMG',       price = 5500 },
		 -- { name = 'WEAPON_PUMPSHOTGUN',       price = 5500 },


		},

		Cloakrooms = {
			vector3(473.5908203125,-993.88696289062,25.734645843506),
			{ x = -442.65, y = 6012.53, z = 30.5}, --Paleto
			{ x = 1840.27, y = 3688.95, z = 33.8 }, --Sandy
			{ x = 618.52, y = 14.54, z = 81.77 }, --Vinewood
			vector3(381.3, -1609.49, 28.29), --Davis
			vector3(-1622.637,-1035.15,12.145 ), --Dellpero
			vector3( -1096.56, -833.47, 13.28 ), -- Vespucci
			vector3(1680.9819335938,4870.9008789063,41.155586242676 ), -- Grapeseed
	  
		},

		Armories = {
			vector3(484.23687744141,-1001.6278076172,24.734670639038),
			{ x = -448.01, y = 6007.99, z = 30.5 }, --Paleto
			{ x = 1841.33, y = 3691.34, z = 33.6 }, --Sandy
			{ x = -53.21, y = -2524.1, z = 235.89 }, --Training
			{ x = 621.18, y =-18.38 , z = 81.78}, --Vinewood
			vector3(370.73, -1598.4, 28.29), -- Davis
			vector3(-1618.399,-1030.010,12.15), --Delpero
			vector3(-1098.77, -826.72,14.28), --Vespucci
			vector3(1683.1735839844,4871.1772460938,41.155586242676 ), --Grapeseed
			

			{ x = 124.01 , y =  -768.14, z = 242.15}, --AFP
			
			

		},



    Vehicles = {
      { --City
		--Spawner    = { x = 433.99, y = -995.47, z = 25.79 },
		
		Spawner    = { x = 430.93942260742, y = -978.88708496094, z = 25.72},
        --Spawner    = { x = 431.47, y = -980.22, z = 25.86 },
        SpawnPoint = { x = 430.23,  y = -985.13, z = 25.39 },
        Heading    = 177.82,
      },
	  { --Paleto1
        Spawner    = vector3(-477.21801757812,6033.0986328125,31.340547561646),
        SpawnPoint = vector3(-472.3323059082,6027.466796875,31.340524673462),
        Heading    = 223.00,
      },
	  { --Paleto2
        Spawner    = vector3(-484.05313110352,6025.9594726562,31.340524673462),
        SpawnPoint = vector3(-478.47021484375,6021.4516601562,31.340524673462),
        Heading    = 223.00,
      },
	  { --Sandy 1
        Spawner    = vector3(1873.7856445312,3697.2551269531,33.443634033203),
        SpawnPoint = { x = 1869.25, y = 3694.23, z = 32.20 },
        Heading    = 219.60,
      },
	  
	  { --TrainArmoury
        Spawner    = { x = -91.29, y = -2548.24, z = 5.31},
        SpawnPoint = { x = -91.29, y = -2548.24, z = 5.31 },
        Heading    = 57.19,
      },
	  
	  { --Vinewood
        Spawner    = vector3(620.69573974609,19.433109283447,88.056045532227),
        SpawnPoint = { x = 642.59, y = 18.11, z = 86.39 },
        Heading    = 248.74,
      },
	  { --Davis
        Spawner    = vector3(391.62866210938,-1604.1229248047,29.292058944702),
        SpawnPoint = { x =  386.89, y = -1617.42, z = 29.29 },
        Heading    = 236.73,
      },
	  
	  { --AFP
        Spawner    = { x = 90.36, y = -723.17, z =  33.13 },
        SpawnPoint = { x =  107.99, y = -723.16, z = 33.13 },
        Heading    = 247.69,
      }, 
	
	  { --Vespucci
        Spawner    = { x = -1037.45, y = -852.15, z = 4.05 },
        SpawnPoint = { x =  -1040.76, y = -854.38, z = 3.88 },
        Heading    = 52.24,
      }, 	
	  
	  	
	  { --Vespucci 2
	  
        Spawner    = { x =  -1109.06, y = -839.8, z = 12.34 },
        SpawnPoint = { x =   -1117.27, y = -830.16, z = 12.94 },
        Heading    = 130.72,
      }, 	
	 { --Delperro
        Spawner    = vector3(-1641.7944335938,-1023.2465209961,13.152136802673) ,
        SpawnPoint = { x = -1644.08, y = -1020.56 , z =  12.1524 },
        Heading    = 316.38,
      }, 
	  { --gRAPESEED
        Spawner    = vector3(1681.3927001953,4889.9926757812,42.029418945312),
        SpawnPoint = { x =  1673.7697851563, y = 4889.81, z =  41.229472351074 },
        Heading    = 92.03263092041,
      }, 
	  
	  
	   
    }, 

		Helicopters = {
			{
				Spawner    = { x = 466.477, y = -982.819, z = 42.691 },
				SpawnPoint = { x = 450.04, y = -981.14, z = 42.691 },
				Heading    = 0.0
			},
			

		},
		Helicopters1 = {
			{
				Spawner    = { x = 466.477, y = -982.819, z = 42.691 },
				SpawnPoint = { x = 481.23, y = -982.94, z = 40.5 },
				Heading    = 0.0
			},
		},

		VehicleDeleters = {
		
			{ x = 462.40, y = -1019.7, z = 27.104 },
			{ x = 437.05, y = -979.1510, z = 25.72 }, -- UnderPD
			{ x = 1863.22, y = 3704.14, z = 32.60 },  --Sandy
			{ x = -464.9, y = 6044.12, z = 30.43 },  --Paleto
			{ x = 633.53, y = 23.1, z = 86.17 },  --Vinewood
			{ x = 380.26, y = -1626.81, z = 28.29},  --Davis
			{ x = -1079.37, y =  -884.33, z = 3.32},  --Vespucci
			{ x = 1686.3349609375, y = 4888.087890625, z = 41.027328491211}, --Grapeseed
			vector3(-1645.1993408203,-1021.125793457,13.152231216431), --Delperro (beach)
			

		},
		
		ExtraChanger = {
		
				{ x = 462.74, y = -1014.4, z = 27.065 },
				{ x = 1871.26, y = 3699.78, z = 32.60 },
				vector3(750.03, 3570.31, 34.17),
				--vector3(1673.8846435547,4890.0078125,42.07332611084), --Grapeseed
				
		},
		

		BossActions = {
			{ x = 474.56680297852, y = -1006.6077270508, z = 29.708797454834}, 
			{ x = 450.09, y = 6010.09, z = 30.5}, --Paleto
			{ x = 1854.11, y =  3699.16, z = 33.8}, --Sandy
			{ x = 631.9, y =  -12.98, z = 81.7}, --Vinewood
			{ x = 388.96, y =  -1601.74, z = 28.29},

		},

	},

}

-- https://wiki.rage.mp/index.php?title=Vehicles
Config.AuthorizedVehicles = {
	Shared = {
      { name = 'police',  label = 'Toyota Camry - GD' },
      { name = 'police2', label = 'Holden Evoke - GD' },
	  { name = 'gdhilux', label = 'Toyota Hilux - Caged' },
	  { name = 'gdiload', label = 'Hyundai iLoad - Caged' },
	  { name = 'gdumiload', label = 'Hyundai iLoad - Caged - UM' },
	  { name = 'gdk', label = 'Kia - Santa Fe - GD' },
      { name = 'umk', label = 'Kia - Santa Fe - UM' },
	  { name = 'gdterry', label = 'Ford Territory - GD' },
	  { name = 'gdproj', label = 'Mitsubishi Pajero - GD' },
	  { name = 'dogcar', label = 'Ford Falcon Ute - Dog Cage' },
	  { name = 'umevoke', label = 'Holden Evoke - Unmarked' },
	  { name = 'gdumevoke', label = 'Holden Evoke SS - Unmarked' },
	  { name = 'hwpvolvo', label = 'HWP - Volvo' },
	  { name = 'hwpss', label = 'HWP - Holden SS' },
	  { name = 'hwpumss', label = 'HWP - Holden SS - UM' },
	  { name = 'hwpumwag', label = 'HWP - Holden SS WAG - UM' },
	  { name = 'hwpfgx', label = 'HWP - Falcon FG6T' },
	  { name = 'hwpumfgx', label = 'HWP - Falcon FG6T - UM' },
	  { name = 'policeb', label = 'HWP - Yamaha FJR' },
		{ name = 'fbi2', label = 'HWP - Merc Sprinter - RBT' },
		{ name = 'RIOT', label = 'Lenco Bearcat - Special' },
	},

	recruit = {

	},

	officer = {
		{
			model = 'police3',
			label = 'Police Interceptor'
		}
	},

	sergeant = {
		{
			model = 'policet',
			label = 'Police Transporter'
		},
		{
			model = 'policeb',
			label = 'Police Bike'
		}
	},

	intendent = {

	},

	lieutenant = {
		{
			model = 'riot',
			label = 'Police Riot'
		},
		{
			model = 'fbi2',
			label = 'FIB SUV'
		}
	},

	chef = {

	},

	boss = {

	}
}


-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {

	A0 = {
		male = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 278,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 49,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 290,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 1,
			['shoes_1'] = 86,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		}
	},
	A1 = {
		male = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 278,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 49,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 290,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 1,
			['shoes_1'] = 86,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		}
	},
	A2 = {
		male = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 278,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 49,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 290,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 1,
			['shoes_1'] = 86,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		}
	},
	A3 = {
		male = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 278,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 49,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 290,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 1,
			['shoes_1'] = 86,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		}
	},
	A4 = {
		male = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 278,   ['torso_2'] = 3,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 49,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 290,   ['torso_2'] = 3,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 1,
			['shoes_1'] = 86,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		}
	},
	A5 = {
		male = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 278,   ['torso_2'] = 4,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 49,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 290,   ['torso_2'] = 4,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 1,
			['shoes_1'] = 86,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		}
	},
	A6 = {
		male = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 278,   ['torso_2'] = 5,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 49,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 290,   ['torso_2'] = 5,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 1,
			['shoes_1'] = 86,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		}
	},
		A7 = {
		male = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 278,   ['torso_2'] = 6,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 49,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 290,   ['torso_2'] = 6,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 1,
			['shoes_1'] = 86,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		}
	},
	C0 = {
		male = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 277,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 49,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 290,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 1,
			['shoes_1'] = 86,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		}
	},
	C1 = {
		male = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 277,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 49,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 290,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 1,
			['shoes_1'] = 86,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		}
	},
	C2 = {
		male = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 277,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 49,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 290,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 1,
			['shoes_1'] = 86,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		}
	},
	C3 = {
		male = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 277,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 49,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 290,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 1,
			['shoes_1'] = 86,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		}
	},
	C4 = {
		male = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 277,   ['torso_2'] = 3,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 49,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 290,   ['torso_2'] = 3,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 1,
			['shoes_1'] = 86,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		}
	},
	C5 = {
		male = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 277,   ['torso_2'] = 4,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 49,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 290,   ['torso_2'] = 4,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 1,
			['shoes_1'] = 86,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		}
	},
	C6 = {
		male = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 277,   ['torso_2'] = 5,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 34,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 290,   ['torso_2'] = 5,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 1,
			['shoes_1'] = 86,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		}
	},
	C7 = {
		male = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 277,   ['torso_2'] = 6,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 0,
			['pants_1'] = 49,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 290,   ['torso_2'] = 6,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 1,
			['shoes_1'] = 86,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		}
	},
	D0 = {
		male = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 212,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 49,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 4,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 86,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		}
	},
	D1 = {
		male = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 212,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 49,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 4,   ['torso_2'] = 1,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 86,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		}
	},
	D2 = {
		male = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 212,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 49,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 4,   ['torso_2'] = 2,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 86,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		}
	},
	D3 = {
		male = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 212,   ['torso_2'] = 3,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 49,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 4,   ['torso_2'] = 3,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 86,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		}
	},
	D4 = {
		male = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 212,   ['torso_2'] = 4,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 49,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 4,   ['torso_2'] = 4,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 86,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		}
	},
	D5 = {
		male = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 212,   ['torso_2'] = 5,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 49,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 4,   ['torso_2'] = 5,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 86,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		}
	},
	D6 = {
		male = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 212,   ['torso_2'] = 6,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 49,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 4,   ['torso_2'] = 6,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 86,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		}
	},
	D7 = {
		male = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 212,   ['torso_2'] = 7,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 1,
			['pants_1'] = 49,   ['pants_2'] = 1,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = -1,  ['tshirt_2'] = 0,
			['torso_1'] = 4,   ['torso_2'] = 7,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 14,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 86,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = -1,     ['ears_2'] = 0
		}
	},
		--0 Const -1 1st, 2 Senior, 3 LSC, 4 Sgt
	BBHV0 = {		
		male = {
			['bproof_1'] = 7, 	['bproof_2'] = 0,
		},
		female = {
			['bproof_1'] = 25, 	['bproof_2'] = 0,
		}
	},
	BBV0 = {
		male = {
			['bproof_1'] = 20, 	['bproof_2'] = 0,
		},
		female = {
			['bproof_1'] = 22, 	['bproof_2'] = 0,
		}
	},

	BBHV1 = {		
		male = {
			['bproof_1'] = 7, 	['bproof_2'] = 1,
		},
		female = {
			['bproof_1'] = 25, 	['bproof_2'] = 1,
		}
	},
	BBV1 = {
		male = {
			['bproof_1'] = 20, 	['bproof_2'] = 1,
		},
		female = {
			['bproof_1'] = 22, 	['bproof_2'] = 1,
		}
	},
	
	BBHV2 = {		
		male = {
			['bproof_1'] = 7, 	['bproof_2'] = 2,
		},
		female = {
			['bproof_1'] = 25, 	['bproof_2'] = 2,
		}
	},
	BBV2 = {
		male = {
			['bproof_1'] = 20, 	['bproof_2'] = 2,
		},
		female = {
			['bproof_1'] = 22, 	['bproof_2'] = 2,
		}
	},
		
	BBHV3 = {		
		male = {
			['bproof_1'] = 7, 	['bproof_2'] = 3,
		},
		female = {
			['bproof_1'] = 25, 	['bproof_2'] = 3,
		}
	},
	BBV3 = {
		male = {
			['bproof_1'] = 20, 	['bproof_2'] = 3,
		},
		female = {
			['bproof_1'] = 22, 	['bproof_2'] = 3,
		}
	},
	BBHV4 = {		
		male = {
			['bproof_1'] = 7, 	['bproof_2'] = 4,
		},
		female = {
			['bproof_1'] = 25, 	['bproof_2'] = 4,
		}
	},
	BBV4 = {
		male = {
			['bproof_1'] = 20, 	['bproof_2'] = 4,
		},
		female = {
			['bproof_1'] = 22, 	['bproof_2'] = 4,
		}
	},
	BBHV5 = {		
		male = {
			['bproof_1'] = 8, 	['bproof_2'] = 0,
		},
		female = {
			['bproof_1'] = 25, 	['bproof_2'] = 5,
		}
	},
	BBV5 = {
		male = {
			['bproof_1'] = 20, 	['bproof_2'] = 5,
		},
		female = {
			['bproof_1'] = 22, 	['bproof_2'] = 5,
		}
	},
	BBHV6 = {		
		male = {
			['bproof_1'] = 8, 	['bproof_2'] = 1,
		},
		female = {
			['bproof_1'] = 25, 	['bproof_2'] = 6,
		}
	},
	BBV6 = {
		male = {
			['bproof_1'] = 20, 	['bproof_2'] = 6,
		},
		female = {
			['bproof_1'] = 22, 	['bproof_2'] = 6,
		}
	},
	BBHV7 = {		
		male = {
			['bproof_1'] = 8, 	['bproof_2'] = 2,
		},
		female = {
			['bproof_1'] = 25, 	['bproof_2'] = 7,
		}
	},
	BBV7 = {
		male = {
			['bproof_1'] = 20, 	['bproof_2'] = 7,
		},
		female = {
			['bproof_1'] = 22, 	['bproof_2'] = 7,
		}
	},	

	BBHV8 = {		
		male = {
			['bproof_1'] = 8, 	['bproof_2'] = 3,
		},
		female = {
			['bproof_1'] = 25, 	['bproof_2'] = 8,
		}
	},
	BBV8 = {
		male = {
			['bproof_1'] = 20, 	['bproof_2'] = 8,
		},
		female = {
			['bproof_1'] = 22, 	['bproof_2'] = 8,
		}
	},			
	BN = {
		male = {
			['bproof_1'] = -1, 	['bproof_2'] = -1,
		},
		female = {
			['bproof_1'] = -1, 	['bproof_2'] = -1,
		},
	},	
	BP = {
		male = {
			['bproof_1'] = 20, 	['bproof_2'] = 3,
		},
		female = {
			['bproof_1'] = 20, 	['bproof_2'] = 3,
		}
	},
	BPH = {
		male = {
			['bproof_1'] = 7, 	['bproof_2'] = 2,
		},
		female = {
			['bproof_1'] = 7, 	['bproof_2'] = 2,
		}
	},
	VT = {
		male = {
			['bproof_1'] = 10, 	['bproof_2'] = 0,
		},
		female = {
			['bproof_1'] = 20, 	['bproof_2'] = 0,
		}
	},
	
	HH = {
		male = {
			['chain_1'] = 9, 	['chain_2'] = 0,
		},
		female = {
			['chain_1'] = 9, 	['chain_2'] = 0,
		}
	},
	
	
	-- 1 thighfull
	-- 2 belt empty
	-- 3 thigh empty
	-- 8 belt full
	-- 38 bat belt
	TH = {
		male = {
			['chain_1'] = 6, 	['chain_2'] = 0,

		},
		female = {
			['chain_1'] = 6, 	['chain_2'] = 0,
			
			
		}
	},
	
	BB = {
		male = {
			['tshirt_1'] = 38, 	['tshirt_2'] = 0,

		},
		female = {
			['tshirt_1'] = 28, 	['tshirt_2'] = 0,
			
			
		}
	},
	rbelt = {
		male = {
			['tshirt_1'] = -1, 	['tshirt_2'] = 0,
			['chain_1'] = -1, 	['chain_2'] = 0,

		},
		female = {
			['tshirt_1'] = -1, 	['tshirt_2'] = 0,
			['chain_1'] = -1, 	['chain_2'] = 0,
			
			
		}
	},
	
	
	
	
	glasses = {
		male = {
			['glasses_1'] = 16, 	['glasses_2'] = 6,
		},
		female = {
			['glasses_1'] = 19, 	['glasses_2'] = 0,
		}
	},
	rglasses = {
		male = {
			['glasses_1'] = -1, 	['glasses_2'] = -1,
		},
		female = {
			['glasses_1'] = -1, 	['glasses_2'] = -1,
		}
	},
	mbhelmet = {
		male = {
			['helmet_1'] = 48, 	['helmet_2'] = 0,
		},
		female = {
			['helmet_1'] = 47, 	['helmet_2'] = 0,
		}
	},
	rmbhelmet = {
		male = {
			['helmet_1'] = -1,  ['helmet_2'] = 0,
		},
		female = {
			['helmet_1'] = -1, 	['helmet_2'] = 0,
		}
	},
	
	pbaseball = {
		male = {
			['helmet_1'] = 134, 	['helmet_2'] = 0,
		},
		female = {
			['helmet_1'] = 133, 	['helmet_2'] = 0,
		}
	},
	recruit_wear = {
		male = {
			['tshirt_1'] = 59,  ['tshirt_2'] = 1,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = 46,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 36,  ['tshirt_2'] = 1,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = 45,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	officer_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 0,   ['decals_2'] = 0,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	sergeant_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 8,   ['decals_2'] = 1,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 1,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	intendent_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 8,   ['decals_2'] = 2,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 2,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	lieutenant_wear = { -- currently the same as intendent_wear
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 8,   ['decals_2'] = 2,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 2,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	chef_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 8,   ['decals_2'] = 3,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	boss_wear = { -- currently the same as chef_wear
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,
			['torso_1'] = 55,   ['torso_2'] = 0,
			['decals_1'] = 8,   ['decals_2'] = 3,
			['arms'] = 41,
			['pants_1'] = 25,   ['pants_2'] = 0,
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		},
		female = {
			['tshirt_1'] = 35,  ['tshirt_2'] = 0,
			['torso_1'] = 48,   ['torso_2'] = 0,
			['decals_1'] = 7,   ['decals_2'] = 3,
			['arms'] = 44,
			['pants_1'] = 34,   ['pants_2'] = 0,
			['shoes_1'] = 27,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0
		}
	},
	bullet_wear = {
		male = {
			['bproof_1'] = 11,  ['bproof_2'] = 1
		},
		female = {
			['bproof_1'] = 13,  ['bproof_2'] = 1
		}
	},
	gilet_wear = {
		male = {
			['tshirt_1'] = 59,  ['tshirt_2'] = 1
		},
		female = {
			['tshirt_1'] = 36,  ['tshirt_2'] = 1
		}
	}

}