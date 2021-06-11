Config                            = {}
Config.DrawDistance               = 100.0

Config.EnablePlayerManagement     = true
Config.EnableSocietyOwnedVehicles = true
Config.EnableVaultManagement      = true
Config.EnableHelicopters          = false
Config.EnableMoneyWash            = false
Config.MaxInService               = -1
Config.Locale                     = 'en'

Config.MissCraft                  = 10 -- %


Config.AuthorizedVehicles = {
    { name = 'tourbus',  label = 'Galaxy Nightclub Bus' },
}

Config.Blips = {

    Blip = {
      Pos     = { x = 355.09 , y = 301.61, z = 103.76 },
      Sprite  = 541,
      Display = 4,
      Scale   = 1.0,
      Colour  = 27,
    },

}

Config.Zones = {

    Cloakrooms = {
        Pos   = { x = 353.91, y = 277.61, z = 93.19 },
        Size  = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 148, g = 0, b = 211 },
        Type  = 27,
    },

	
    Vaults = {
        Pos   = { x = 357.65, y = 280.73, z = 93.19 },
        Size  = { x = 1.3, y = 1.3, z = 1.0 },
        Color = { r = 148, g = 0, b = 211 },
        Type  = 23,
    },

    Fridge = {
        Pos   = { x = 351.91, y =  287.2, z = 90.19 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 148, g = 0, b = 211 },
        Type  = 23,
    },

    Vehicles = {
        Pos          = { x = 351.86, y = 278.2, z = 102.26 },
        SpawnPoint   = {  x = 363.21, y = 280.83, z = 102.31 },
        Size         = { x = 1.8, y = 1.8, z = 1.0 },
        Color        = { r = 148, g = 0, b = 211 },
        Type         = 23,
        Heading      = 275.43,
    },

    VehicleDeleters = {
        Pos   = { x = 355.95, y = 273.23, z = 102.1 },
		Size = { x = 1.8, y = 1.8, z = 1.0 },
        Color = { r = 148, g = 0, b = 211 },
        Type  = 1,
    },

--[[
    Helicopters = {
        Pos          = { x = 137.177, y = -1278.757, z = 28.371 },
        SpawnPoint   = { x = 138.436, y = -1263.095, z = 28.626 },
        Size         = { x = 1.8, y = 1.8, z = 1.0 },
        Color        = { r = 255, g = 255, b = 0 },
        Type         = 23,
        Heading      = 207.43,
    },

    HelicopterDeleters = {
        Pos   = { x = 133.203, y = -1265.573, z = 28.396 },
        Size  = { x = 3.0, y = 3.0, z = 0.2 },
        Color = { r = 255, g = 255, b = 0 },
        Type  = 1,
    },
]]--

    BossActions = {
        Pos   = { x = 398.24, y = 275.15, z = 93.99 },
        Size  = { x = 1.5, y = 1.5, z = 1.0 },
        Color = { r = 148, g = 0, b = 211 },
        Type  = 1,
    },

-----------------------
-------- SHOPS --------

    Flacons = {
        Pos   = { x = 401.57, y = 252.65, z = 91.05 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 148, g = 0, b = 211 },
        Type  = 23,
        Items = {
            { name = 'jager',      		  label = _U('jager'),   			  price = 3 },
            { name = 'vodka',      		  label = _U('vodka'),   			  price = 4 },
            { name = 'rhum',       		  label = _U('rhum'),    			  price = 2 },
            { name = 'whisky',     		  label = _U('whisky'),  			  price = 7 },
            { name = 'tequila',    		  label = _U('tequila'), 			  price = 2 },
            { name = 'martini',    		  label = _U('martini'), 			  price = 5 },
			{ name = 'beer',	   		  label = 'Beer', 	  			  price = 3 },
			{ name = 'drink_fruitylexia', label = 'Fruity Lexia', 	  price = 4 },
			{ name = 'beer_vicbitter', 	  label = 'Victorian Bitter', 	  price = 3 },
			{ name = 'shot_gin', 	  	  label = 'Shot of Gin', 	  	  	  price = 3 }
        },
    },

    NoAlcool = {
        Pos   = { x = 405.31, y = 256.73, z = 91.05 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 148, g = 0, b = 211 },
        Type  = 23,
        Items = {
            { name = 'soda',        label = _U('soda'),     price = 4 },
            { name = 'jusfruit',    label = _U('jusfruit'), price = 3 },
            { name = 'icetea',      label = _U('icetea'),   price = 4 },
            { name = 'energy',      label = _U('energy'),   price = 7 },
            { name = 'drpepper',    label = _U('drpepper'), price = 2 },
			{ name = 'redbull',    	label = 'Redbull', 	price = 2 },
            { name = 'limonade',    label = _U('limonade'), price = 1 }
        },
    },

    Apero = {
        Pos   = { x = 404.31, y = 256.73, z = 91.05 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 148, g = 0, b = 211 },
        Type  = 23,
        Items = {
            { name = 'bolcacahuetes',   label = _U('bolcacahuetes'),    price = 7 },
            { name = 'bolnoixcajou',    label = _U('bolnoixcajou'),     price = 10 },
            { name = 'bolpistache',     label = _U('bolpistache'),      price = 15 },
            { name = 'bolchips',        label = _U('bolchips'),         price = 5 },
            { name = 'saucisson',       label = _U('saucisson'),        price = 25 },
            { name = 'grapperaisin',    label = _U('grapperaisin'),     price = 15 }
        },
    },

    Ice = {
        Pos   = { x = 406.29, y = 254.47, z = 91.05 },
        Size  = { x = 1.6, y = 1.6, z = 1.0 },
        Color = { r = 148, g = 0, b = 211 },
        Type  = 23,
        Items = {
            { name = 'snack_hsp',     			label = 'HSP',      	  	 price = 3 },
            { name = 'snack_spicywings',  		label = 'Spicey Wings',   	 price = 3 },
			{ name = 'snack_chickenstrips',  	label = 'Chicken Strips',   price = 3 },
			{ name = 'snack_chippacket',  		label = 'Packet of Chips',   	 price = 2 },
			{ name = 'snack_fries',  			label = 'Fries',   	  	 price = 2 },
			{ name = 'snack_slider',  			label = 'Slider',   	 	 price = 3 },
			{ name = 'food_meatpie',  			label = 'Meatpie',   	 	 price = 3 },
			{ name = 'food_parmy',  			label = 'Chicken Parmy',   	 	 price = 3 }
        },
    },

}


-----------------------
----- TELEPORTERS -----

Config.TeleportZones = {
  EnterBuilding = {
    Pos       = { x = 344.36, y = 286.49, z = 94.79 },
    Size      = { x = 1.2, y = 1.2, z = 0.1 },
    Color     = { r = 148, g = 0, b = 211 },
    Marker    = 1,
    Hint      = _U('e_to_enter_1'),
    Teleport  = { x = 346.78, y = 285.8, z = 94.79 },
  },

  ExitBuilding = {
    Pos       = { x = 346.78, y = 285.8, z = 94.79 },
    Size      = { x = 1.2, y = 1.2, z = 0.1 },
    Color     = { r = 148, g = 0, b = 211 },
    Marker    = 1,
    Hint      = _U('e_to_exit_1'),
    Teleport  = { x = 344.36, y = 286.49, z = 94.79 },
  },

--[[
  EnterHeliport = {
    Pos       = { x = 126.843, y = -729.012, z = 241.201 },
    Size      = { x = 2.0, y = 2.0, z = 0.2 },
    Color     = { r = 204, g = 204, b = 0 },
    Marker    = 1,
    Hint      = _U('e_to_enter_2),
    Teleport  = { x = -65.944, y = -818.589, z =  320.801 }
  },

  ExitHeliport = {
    Pos       = { x = -67.236, y = -821.702, z = 320.401 },
    Size      = { x = 2.0, y = 2.0, z = 0.2 },
    Color     = { r = 204, g = 204, b = 0 },
    Marker    = 1,
    Hint      = _U('e_to_exit_2'),
    Teleport  = { x = 124.164, y = -728.231, z = 241.801 },
  },
]]--
}


-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
  barman_outfit = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 40,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 40,
        ['pants_1'] = 28,   ['pants_2'] = 2,
        ['shoes_1'] = 38,   ['shoes_2'] = 4,
        ['chain_1'] = 118,  ['chain_2'] = 0
    },
    female = {
        ['tshirt_1'] = 3,   ['tshirt_2'] = 0,
        ['torso_1'] = 8,    ['torso_2'] = 2,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 5,
        ['pants_1'] = 44,   ['pants_2'] = 4,
        ['shoes_1'] = 0,    ['shoes_2'] = 0,
        ['chain_1'] = 0,    ['chain_2'] = 2
    }
  },
  dancer_outfit_1 = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 15,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 40,
        ['pants_1'] = 61,   ['pants_2'] = 9,
        ['shoes_1'] = 16,   ['shoes_2'] = 9,
        ['chain_1'] = 118,  ['chain_2'] = 0
    },
    female = {
        ['tshirt_1'] = 3,   ['tshirt_2'] = 0,
        ['torso_1'] = 22,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 4,
        ['pants_1'] = 22,   ['pants_2'] = 0,
        ['shoes_1'] = 18,   ['shoes_2'] = 0,
        ['chain_1'] = 61,   ['chain_2'] = 1
    }
  },
  dancer_outfit_2 = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 62,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 14,
        ['pants_1'] = 4,    ['pants_2'] = 0,
        ['shoes_1'] = 34,   ['shoes_2'] = 0,
        ['chain_1'] = 118,  ['chain_2'] = 0
    },
    female = {
        ['tshirt_1'] = 3,   ['tshirt_2'] = 0,
        ['torso_1'] = 22,   ['torso_2'] = 2,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 4,
        ['pants_1'] = 20,   ['pants_2'] = 2,
        ['shoes_1'] = 18,   ['shoes_2'] = 2,
        ['chain_1'] = 0,    ['chain_2'] = 0
    }
  },
  dancer_outfit_3 = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 15,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 4,    ['pants_2'] = 0,
        ['shoes_1'] = 34,   ['shoes_2'] = 0,
        ['chain_1'] = 118,  ['chain_2'] = 0
    },
    female = {
        ['tshirt_1'] = 3,   ['tshirt_2'] = 0,
        ['torso_1'] = 22,   ['torso_2'] = 1,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 19,   ['pants_2'] = 1,
        ['shoes_1'] = 19,   ['shoes_2'] = 3,
        ['chain_1'] = 0,    ['chain_2'] = 0
    }
  },
  dancer_outfit_4 = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 15,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 61,   ['pants_2'] = 5,
        ['shoes_1'] = 34,   ['shoes_2'] = 0,
        ['chain_1'] = 118,  ['chain_2'] = 0
    },
    female = {
        ['tshirt_1'] = 3,   ['tshirt_2'] = 0,
        ['torso_1'] = 82,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 63,   ['pants_2'] = 11,
        ['shoes_1'] = 41,   ['shoes_2'] = 11,
        ['chain_1'] = 0,    ['chain_2'] = 0
    }
  },
  dancer_outfit_5 = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 15,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 21,   ['pants_2'] = 0,
        ['shoes_1'] = 34,   ['shoes_2'] = 0,
        ['chain_1'] = 118,  ['chain_2'] = 0
    },
    female = {
        ['tshirt_1'] = 3,   ['tshirt_2'] = 0,
        ['torso_1'] = 15,   ['torso_2'] = 5,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 63,   ['pants_2'] = 2,
        ['shoes_1'] = 41,   ['shoes_2'] = 2,
        ['chain_1'] = 0,    ['chain_2'] = 0
    }
  },
  dancer_outfit_6 = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 15,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 81,   ['pants_2'] = 0,
        ['shoes_1'] = 34,   ['shoes_2'] = 0,
        ['chain_1'] = 118,  ['chain_2'] = 0
    },
    female = {
        ['tshirt_1'] = 3,   ['tshirt_2'] = 0,
        ['torso_1'] = 18,   ['torso_2'] = 3,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 63,   ['pants_2'] = 10,
        ['shoes_1'] = 41,   ['shoes_2'] = 10,
        ['chain_1'] = 0,    ['chain_2'] = 0
    }
  },
  dancer_outfit_7 = {
    male = {
        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
        ['torso_1'] = 15,   ['torso_2'] = 0,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 40,
        ['pants_1'] = 61,   ['pants_2'] = 9,
        ['shoes_1'] = 16,   ['shoes_2'] = 9,
        ['chain_1'] = 118,  ['chain_2'] = 0
    },
    female = {
        ['tshirt_1'] = 3,   ['tshirt_2'] = 0,
        ['torso_1'] = 111,  ['torso_2'] = 6,
        ['decals_1'] = 0,   ['decals_2'] = 0,
        ['arms'] = 15,
        ['pants_1'] = 63,   ['pants_2'] = 6,
        ['shoes_1'] = 41,   ['shoes_2'] = 6,
        ['chain_1'] = 0,    ['chain_2'] = 0
    }
  }
}