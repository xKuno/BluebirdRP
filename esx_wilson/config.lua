Config                            = {}

Config.DrawDistance               = 100.0
Config.MarkerType                 = 1
Config.MarkerSize                 = { x = 1.5, y = 1.5, z = 0.5 }
Config.MarkerColor                = { r = 50, g = 50, b = 204 }

Config.EnablePlayerManagement     = true
Config.EnableArmoryManagement     = true
Config.EnableESXIdentity          = false-- enable if you're using esx_identity
Config.EnableNonFreemodePeds      = false -- turn this on if you want custom peds
Config.EnableLicenses             = false -- enable if you're using esx_license

Config.EnableHandcuffTimer        = true -- enable handcuff timer? will unrestrain player after the time ends
Config.HandcuffTimer              = 10 * 60000 -- 10 mins

Config.EnableJobBlip              = false -- enable blips for colleagues, requires esx_society

Config.MaxInService               = -1
Config.Locale                     = 'en'

Config.PoliceStations = {

	LSPD = {

		Blip = {
			Coords  = vector3(-108.61, -609.25, 36.27),
			Sprite  = 58,
			Display = 4,
			Scale   = 1.2,
			Colour  = 2
		},

		Cloakrooms = {
			vector3(-132.2, -632.6, 168.82)
		},

		Armories = {
			vector3(-148.18, -641.76, 168.82 )
		},

		Vehicles = {
			{
				Spawner = vector3(-114.73, -613.88, 36.28),
				InsideShop = vector3(446.7, -1355.6, 43.5),
				SpawnPoints = {
					{ coords = vector3(-111.25, -624.93, 36.06 ), heading = 175.92, radius = 6.0 },

				}
			},

		},

		Helicopters = {
			{
				Spawner = vector3( -120.41, -617.77, 36.28),
				InsideShop = vector3(477.0, -1106.4, 43.0),
				SpawnPoints = {
					{ coords = vector3(-144.68, -593.22, 212.99), heading = 90.14, radius = 10.0 }
				}
			}
		},

		BossActions = {
			vector3(-125.25, -639.67, 168.84)
		}

	}

}

Config.AuthorizedWeapons = {


	
	recruit = {
		--{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 1000, 4000, nil }, price = 10000 },
		--{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		--{ weapon = 'WEAPON_STUNGUN', price = 30000 },
		--{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	officer = {
		--{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 1000, 4000, nil }, price = 10000 },
		--{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		--{ weapon = 'WEAPON_STUNGUN', price = 30000 },
		--{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	sergeant = {
		--{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 1000, 4000, nil }, price = 10000 },
		--{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil }, price = 70000 },
	--	{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
	--	{ weapon = 'WEAPON_STUNGUN', price = 30000 },
	--	{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	intendent = {
		--{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 1000, 4000, nil }, price = 10000 },
		--{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil }, price = 70000 },
	--	{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
	--	{ weapon = 'WEAPON_STUNGUN', price = 30000 },
	--	{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	lieutenant = {
		--{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 1000, 4000, nil }, price = 10000 },
		--{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil }, price = 70000 },
	--	{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
	--	{ weapon = 'WEAPON_STUNGUN', price = 30000 },
	--	{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	chef = {
		--{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 1000, 4000, nil }, price = 10000 },
		--{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil }, price = 70000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 35000 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	},

	boss = {
		--{ weapon = 'WEAPON_PISTOL', components = { 0, 0, 1000, 4000, nil }, price = 10000 },
		--{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 2000, 6000, nil }, price = 70000 },
		{ weapon = 'WEAPON_NIGHTSTICK', price = 0 },
		{ weapon = 'WEAPON_STUNGUN', price = 35000 },
		{ weapon = 'WEAPON_FLASHLIGHT', price = 0 }
	}
}

Config.AuthorizedVehicles = {
	Shared = {
		{ model = 'wstockade', label = 'Wilson Armoured Truck', price = 1 },
		{ model = 'honorsec1', label = 'Honr Sec Primary', price = 1 },
		{ model = 'wsec1', label = 'Toyota Camry', price = 1 },
		{ model = 'dilettante2', label = 'Prius', price = 1 },
		{ model = 'wevoke', label = 'Holden Evoke', price = 1 },
		{ model = '17rap', label = 'Ford Raptor', price = 1 },
		{ model = 'wbrickade', label = 'Brickade', price = 1 },

		--{ model = 'cognoscenti', label = 'Cognoscenti', price = 20000 },

	},

	private = {

	},

	headprivate = {
	
	},

	groupleader = {

	},

	snrgroupldr = {

	},

	hco = {

	},
	
	recruit = {

	},

	officer = {

	},

	sergeant = {

	},

	intendent = {

	},

	lieutenant = {

	},

	chef = {

	},

	boss = {

	}
}

Config.AuthorizedHelicopters = {
	private = {},

	headprivate = {},

	groupleader = {},

	snrgroupldr = {},

	hco = {
		{ model = 'frogger', label = 'Frogger', livery = 0, price = 99900000 },
		{ model = 'swift', label = 'Swift', livery = 0, price = 99900000 }
	},
	
		recruit = {

	},

	officer = {
	
	},

	sergeant = {

	},

	intendent = {

	},

	lieutenant = {

	},

	chef = {
		{ model = 'frogger', label = 'Frogger', livery = 0, price = 200000 },
		{ model = 'swift', label = 'Swift', livery = 0, price = 100000 }
	},

	boss = {
		{ model = 'frogger', label = 'Frogger', livery = 0, price = 200000 },
		{ model = 'swift', label = 'Swift', livery = 0, price = 100000 }
	}
}

-- CHECK SKINCHANGER CLIENT MAIN.LUA for matching elements

Config.Uniforms = {
	recruit_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,		--Shirt Accessory
			['torso_1'] = 13,   ['torso_2'] = 0,		---Shirt Overlay /Jackets
			['decals_1'] = -1,   ['decals_2'] = -1,			
			['arms'] = 37,								--Arms 42
			['pants_1'] = 49,   ['pants_2'] = 0,	--legs pants
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['bproof_1'] = 19, 	['bproof_2'] = 0,
			['chain_1'] = 2, 	['chain_2'] = 0,
		},
		female = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,		--Shirt Accessory
			['torso_1'] = 13,   ['torso_2'] = 0,		---Shirt Overlay /Jackets
			['decals_1'] = -1,   ['decals_2'] = -1,			
			['arms'] = 37,								--Arms 42
			['pants_1'] = 49,   ['pants_2'] = 0,	--legs pants
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['bproof_1'] = 19, 	['bproof_2'] = 0,
			['chain_1'] = 2, 	['chain_2'] = 0,
		}
	},
	officer_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,		--Shirt Accessory
			['torso_1'] = 13,   ['torso_2'] = 0,		---Shirt Overlay /Jackets
			['decals_1'] = -1,   ['decals_2'] = -1,			
			['arms'] = 37,								--Arms 42
			['pants_1'] = 49,   ['pants_2'] = 0,	--legs pants
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['bproof_1'] = 19, 	['bproof_2'] = 0,
			['chain_1'] = 2, 	['chain_2'] = 0,
		},
		female = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,		--Shirt Accessory
			['torso_1'] = 13,   ['torso_2'] = 0,		---Shirt Overlay /Jackets
			['decals_1'] = -1,   ['decals_2'] = -1,			
			['arms'] = 37,								--Arms 42
			['pants_1'] = 49,   ['pants_2'] = 0,	--legs pants
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['bproof_1'] = 19, 	['bproof_2'] = 0,
			['chain_1'] = 2, 	['chain_2'] = 0,
		}
	},
	sergeant_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,		--Shirt Accessory
			['torso_1'] = 13,   ['torso_2'] = 0,		---Shirt Overlay /Jackets
			['decals_1'] = -1,   ['decals_2'] = -1,			
			['arms'] = 37,								--Arms 42
			['pants_1'] = 49,   ['pants_2'] = 0,	--legs pants
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['bproof_1'] = 19, 	['bproof_2'] = 0,
			['chain_1'] = 2, 	['chain_2'] = 0,
		},
		female = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,		--Shirt Accessory
			['torso_1'] = 13,   ['torso_2'] = 0,		---Shirt Overlay /Jackets
			['decals_1'] = -1,   ['decals_2'] = -1,			
			['arms'] = 37,								--Arms 42
			['pants_1'] = 49,   ['pants_2'] = 0,	--legs pants
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['bproof_1'] = 19, 	['bproof_2'] = 0,
			['chain_1'] = 2, 	['chain_2'] = 0,
		}
	},
	intendent_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,		--Shirt Accessory
			['torso_1'] = 13,   ['torso_2'] = 0,		---Shirt Overlay /Jackets
			['decals_1'] = -1,   ['decals_2'] = -1,			
			['arms'] = 37,								--Arms 42
			['pants_1'] = 49,   ['pants_2'] = 0,	--legs pants
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['bproof_1'] = 19, 	['bproof_2'] = 0,
			['chain_1'] = 2, 	['chain_2'] = 0,
		},
		female = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,		--Shirt Accessory
			['torso_1'] = 13,   ['torso_2'] = 0,		---Shirt Overlay /Jackets
			['decals_1'] = -1,   ['decals_2'] = -1,			
			['arms'] = 37,								--Arms 42
			['pants_1'] = 49,   ['pants_2'] = 0,	--legs pants
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['bproof_1'] = 19, 	['bproof_2'] = 0,
			['chain_1'] = 2, 	['chain_2'] = 0,
		}
	},
	lieutenant_wear = { -- currently the same as intendent_wear
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,		--Shirt Accessory
			['torso_1'] = 13,   ['torso_2'] = 0,		---Shirt Overlay /Jackets
			['decals_1'] = -1,   ['decals_2'] = -1,			
			['arms'] = 37,								--Arms 42
			['pants_1'] = 49,   ['pants_2'] = 0,	--legs pants
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['bproof_1'] = 19, 	['bproof_2'] = 0,
			['chain_1'] = 2, 	['chain_2'] = 0,
		},
		female = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,		--Shirt Accessory
			['torso_1'] = 13,   ['torso_2'] = 0,		---Shirt Overlay /Jackets
			['decals_1'] = -1,   ['decals_2'] = -1,			
			['arms'] = 37,								--Arms 42
			['pants_1'] = 49,   ['pants_2'] = 0,	--legs pants
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['bproof_1'] = 19, 	['bproof_2'] = 0,
			['chain_1'] = 2, 	['chain_2'] = 0,
		}
	},
	chef_wear = {
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,		--Shirt Accessory
			['torso_1'] = 13,   ['torso_2'] = 0,		---Shirt Overlay /Jackets
			['decals_1'] = -1,   ['decals_2'] = -1,			
			['arms'] = 37,								--Arms 42
			['pants_1'] = 49,   ['pants_2'] = 0,	--legs pants
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['bproof_1'] = 19, 	['bproof_2'] = 0,
			['chain_1'] = 2, 	['chain_2'] = 0,
		},
		female = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,		--Shirt Accessory
			['torso_1'] = 13,   ['torso_2'] = 0,		---Shirt Overlay /Jackets
			['decals_1'] = -1,   ['decals_2'] = -1,			
			['arms'] = 37,								--Arms 42
			['pants_1'] = 49,   ['pants_2'] = 0,	--legs pants
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['bproof_1'] = 19, 	['bproof_2'] = 0,
			['chain_1'] = 2, 	['chain_2'] = 0,
		}
	},
	boss_wear = { -- currently the same as chef_wear
		male = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,		--Shirt Accessory
			['torso_1'] = 13,   ['torso_2'] = 2,		---Shirt Overlay /Jackets
			['decals_1'] = 7,   ['decals_2'] = 0,			
			['arms'] = 37,								--Arms 42
			['pants_1'] = 49,   ['pants_2'] = 0,	--legs pants
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['bproof_1'] = 19, 	['bproof_2'] = 0,
			['chain_1'] = 2, 	['chain_2'] = 0,
		},
		female = {
			['tshirt_1'] = 58,  ['tshirt_2'] = 0,		--Shirt Accessory
			['torso_1'] = 13,   ['torso_2'] = 3,		---Shirt Overlay /Jackets
			['decals_1'] = 7,   ['decals_2'] = 0,			
			['arms'] = 37,								--Arms 42
			['pants_1'] = 49,   ['pants_2'] = 0,	--legs pants
			['shoes_1'] = 25,   ['shoes_2'] = 0,
			['helmet_1'] = -1,  ['helmet_2'] = 0,
			['chain_1'] = 0,    ['chain_2'] = 0,
			['ears_1'] = 2,     ['ears_2'] = 0,
			['bproof_1'] = 19, 	['bproof_2'] = 0,
			['chain_1'] = 2, 	['chain_2'] = 0,
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
			['bproof_1'] = 18,  ['bproof_2'] = 5
		},
		female = {
			['bproof_1'] = 18,  ['bproof_2'] = 5
		}
	}

}