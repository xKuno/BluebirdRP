Config               = {}

Config.DrawDistance  = 100
Config.Size          = { x = 1.5, y = 1.5, z = 0.5 }
Config.Color         = { r = 127, g = 0, b = 255 }
Config.Type          = 27
Config.Locale        = 'en'

Config.LicenseEnable = true -- only turn this on if you are using esx_license
Config.LicensePrice  = 80000
Config.LongarmPrice  = 80000
Config.HandgunPrice = 90000
Config.Concealed = 300000

Config.Zones = {

	GunShop = {
		Legal = true,
		Items = {

					
	
--			{ weapon = 'WEAPON_COMBATPISTOL', components = { 0, 600, 100, 400, nil }, price = 50000, ammoPrice = 20, AmmoToGive = 20, ammo = 'pistol_ammo' },
			{ weapon = 'WEAPON_REVOLVER', price = 25000, ammoPrice = 12000, AmmoToGive = 25, wl='hg', ammo = 'pistol_ammo' },
			{ weapon = 'WEAPON_PISTOL', components = { 0, 2000, 2000, nil, nil }, price = 40000, ammoPrice = 10000, AmmoToGive = 45, wl='hg', ammo = 'pistol_ammo' },
			{ weapon = 'WEAPON_SNSPISTOL', components = { 0, 2000, nil }, price = 40000, ammoPrice = 10000, AmmoToGive = 45 , wl='hg', ammo = 'pistol_ammo'  },
			{ weapon = 'WEAPON_MUSKET', price =25000, ammoPrice = 12000, AmmoToGive = 10,  wl='la', ammo = 'shotgun_ammo'},
			
			{ weapon = 'WEAPON_FLASHLIGHT', price = 1500},
			{ weapon = 'WEAPON_BOTTLE', price = 5000},
			{ weapon = 'WEAPON_DAGGER', price = 10000},

			{ weapon = 'WEAPON_CROWBAR', price = 8000},
			{ weapon = 'WEAPON_GOLFCLUB', price = 8000},
			{ weapon = 'WEAPON_HAMMER', price = 8000},
			{ weapon = 'WEAPON_KNIFE', price = 8000},
			{ weapon = 'WEAPON_BAT', price = 8000},
			{ weapon = 'WEAPON_FIREEXTINGUISHER', price = 10, ammoPrice = 100, AmmoToGive =4200},
			{ weapon = 'WEAPON_FLARE', price = 2000 ,ammoPrice = 5000, AmmoToGive = 10,  wl='la'},
			{ weapon = 'WEAPON_BALL', price = 500},
			{ weapon = 'WEAPON_PETROLCAN', price = 100, ammoPrice = 100, AmmoToGive =4200},
			{ weapon = 'WEAPON_WRENCH', price =3000},

			
			

		},
		Locations = {
			vector3(-662.1, -935.3, 20.8),
			vector3(810.2, -2157.3, 28.6),
			vector3(1693.4, 3759.5, 33.7),
			vector3(-330.2, 6083.8, 30.4),
			vector3(252.3, -50.0, 68.9),
			vector3(22.0, -1107.2, 28.8),
			vector3(2567.6, 294.3, 107.7),
			vector3(-1117.5, 2698.6, 17.5),
			vector3(842.4, -1033.4, 27.1),
			vector3(-1306.2, -394.0, 35.6),  --old black
			vector3(-3171.62, 1087.26, 19.94)
		}
	},

	BlackWeashop = {
		Legal = false,
		Items = {
		--	{ weapon = 'WEAPON_APPISTOL', components = { 0, 3500, 1000, 25000, nil }, price = 195000, ammoPrice = 13000, AmmoToGive = 45,  wl='hg', ar='wl', ammo = 'pistol_ammo' }, --10
			--{weapon = 'WEAPON_ADVANCEDRIFLE', components = { 0, 6000, 1000, 4000, 25000, nil }, price = 250000, ammoPrice = 13000, AmmoToGive = 45,  wl='hg', ar='wl', ammo = 'rifle_ammo'  },
	
		--	{ weapon = 'WEAPON_MICROSMG', components = { 0,  3500, 1000, 18000, nil }, price = 180000, ammoPrice = 13000, AmmoToGive = 45 ,  wl='la' , ar='wl', ammo = 'smg_ammo' }, --10
		--	{ weapon = 'WEAPON_SMG', components = { 0, 6000, 20000, 4000, 3000, 25000, nil }, price = 180000, ammoPrice = 13000, AmmoToGive = 45,  wl='la', ar='wl', ammo = 'smg_ammo'  }, --10
		--	{ weapon = 'WEAPON_MINISMG', components = { 0, 25000, nil }, price = 200000, ammoPrice = 13000, AmmoToGive = 60 , wl='la', ar='wl', ammo = 'smg_ammo'  }, --11
			--{ weapon = 'WEAPON_COMBATPDW', components = { 0,  6000, 3000, 4000, 3000, 25000, nil }, price = 250000, ammoPrice = 13000, AmmoToGive = 45,  wl='la', ar='wl', ammo = 'smg_ammo'  },
			--{ weapon = 'WEAPON_PUMPSHOTGUN', components = { 0, 8000, nil }, price = 345000, ammoPrice = 13000, AmmoToGive = 45, wl='la' , ar='wl',ammo = 'shotgun_ammo' },
			{ weapon = 'WEAPON_REVOLVER', price = 20000, ammoPrice = 9000, AmmoToGive = 35, wl='hg', ar='wl', ammo = 'pistol_ammo' },
			--{ weapon = 'WEAPON_SAWNOFFSHOTGUN', price = 100000, ammoPrice = 13000, AmmoToGive = 30, wl='la', ar='wl',ammo = 'shotgun_ammo' },
			
		--	{ weapon = 'WEAPON_ASSAULTSHOTGUN', components = { 0, 3500, 1000, 25000, nil }, price = 220000, ammoPrice = 13000, AmmoToGive = 45,  wl='la', ar='wl',ammo = 'shotgun_ammo'  }, 
		--	{ weapon = 'WEAPON_BULLPUPSHOTGUN', components = { 2000, 25000, 8000, nil }, price = 200000, ammoPrice = 13000, AmmoToGive = 45 ,  wl='la', ar='wl',ammo = 'shotgun_ammo' },
		--	{ weapon = 'WEAPON_HEAVYSHOTGUN', components = { 0, 6000, 15000, 4000, 25000, 15000, nil }, price = 200000, ammoPrice = 13000, AmmoToGive = 45,  wl='la', ar='wl',ammo = 'shotgun_ammo' },
		--	{ weapon = 'WEAPON_ASSAULTRIFLE', components = { 0, 6000, 20000, 4000, 3000, 25000, nil }, price = 250000, ammoPrice = 13000, AmmoToGive = 45,  wl='la', ar='wl', ammo = 'rifle_ammo' },
			--{ weapon = 'WEAPON_CARBINERIFLE', components = { 0, 6000, 20000, 4000, 3000, 25000, nil }, price = 200000, ammoPrice = 13000, AmmoToGive = 45,  wl='la', ar='wl', ammo = 'rifle_ammo'  },
			--{ weapon = 'WEAPON_SPECIALCARBINE', components = { 0, 6000, 20000, 4000, 3000, 25000, nil }, price = 200000, ammoPrice = 13000, AmmoToGive = 45,  wl='la', ammo = 'rifle_ammo' },
		--	{ weapon = 'WEAPON_BULLPUPRIFLE', components = { 0, 6000, 3000, 4000, 25000, 10000, nil }, price = 189000, ammoPrice = 13000, AmmoToGive = 45,  wl='la', ar='wl', ammo = 'rifle_ammo' },
		--	{ weapon = 'WEAPON_COMPACTRIFLE', components = { 0, 6000, 8000, nil }, price = 250000, ammoPrice = 13000, AmmoToGive = 45,  wl='la', ar='wl', ammo = 'rifle_ammo' },
			--{ weapon = 'WEAPON_MG', components = { 0, 15000, 15000, nil }, price = 380000, ammoPrice = 13000, AmmoToGive = 45,  wl='la',ar='wl', ammo = 'mg_ammo'  },
			--{ weapon = 'WEAPON_COMBATMG', components = { 0, 10000, 10000, 20000, nil }, price = 380000, ammoPrice = 13000, AmmoToGive = 45,  wl='la', ar='wl', ammo = 'mg_ammo'   },
		--	{ weapon = 'WEAPON_DBSHOTGUN', price = 185000, ammoPrice = 13000, AmmoToGive = 30,  wl='la' },
			--{ weapon = 'WEAPON_SNIPERRIFLE', components = { 0, 10000, 20000, nil }, price =1000000, ammoPrice = 13000, AmmoToGive = 30,  wl='la' , ar='wl', ammo = 'sniper_ammo' },
		--	{ weapon = 'WEAPON_MARKSMANRIFLE', components = { 0, 20000, 4000, 4000, 50000, 15000, nil }, price = 1800000, ammoPrice = 80000, AmmoToGive = 45 ,  wl='la',ar='wl', ammo = 'sniper_ammo' },
			
			{ weapon = 'WEAPON_BOTTLE', price = 9000},
			{ weapon = 'WEAPON_BATTLEAXE', price = 35000},
			{ weapon = 'WEAPON_POOLCUE', price = 9000},
			{ weapon = 'WEAPON_SWITCHBLADE', price =12000},
			{ weapon = 'WEAPON_HATCHET', price =10000},
			{ weapon = 'WEAPON_KNUCKLE', price =10000},
			{ weapon = 'WEAPON_PISTOL', components = { 0, 5000, 2000, 25000, nil }, price = 35000, ammoPrice = 18000, AmmoToGive = 45 ,  wl='hg', ammo = 'pistol_ammo'  },
			{ weapon = 'WEAPON_SNSPISTOL', components = { 0, 2000, nil }, price = 42000, ammoPrice = 13000, AmmoToGive = 45 , wl='hg', ammo = 'pistol_ammo' },
			--{ weapon = 'WEAPON_PISTOL50', components = { 0, 3500, 1000, 25000, nil }, price = 90000, ammoPrice = 13000, AmmoToGive = 45,  wl='hg', ar='wl', ammo = 'pistol_ammo' },
			--{ weapon = 'WEAPON_HEAVYPISTOL', components = { 0, 3500, 1000, 25000, nil }, price = 90000, ammoPrice = 13000, AmmoToGive = 45,  wl='hg', ar='wl', ammo = 'pistol_ammo' },
			{ weapon = 'WEAPON_FIREWORK', price = 20000 , ammoPrice = 9000, AmmoToGive = 10},
			{ weapon = 'WEAPON_MOLOTOV', price = 6000,  ammoPrice = 6000, AmmoToGive = 10},
			{ weapon = 'WEAPON_MUSKET', price =17000, ammoPrice = 11000, AmmoToGive = 10,  wl='la', ammo = 'shotgun_ammo'},
			--{ weapon = 'WEAPON_STUNGUN', price = 20000,  wl='hg'},
			{ weapon = 'WEAPON_NIGHTSTICK', price = 8000},
			{ weapon = 'WEAPON_MACHETE', price = 10000},
	
		},
		Locations = {
			--vector3(-2166.49,  5197.2,  15.88) - Island
			vector3(750.70,  -1907.50,  28.46) -- 165 Insustrial Area Cypher building
			
		}
	}
}