Config = {}

-- Ammo given by default to crafted weapons
Config.WeaponAmmo = 1

Config.Recipes = {
	-- Can be a normal ESX item
	
	
	["pistol_ammo"] = {
		title = 'Pistol Ammo',
		timer = 60000,
		amount = 50,
		hidden = true,
		optional = 'blueprint_pistolammo',
		blackmoney = 3000,
		items = {
	
			{item = "plastic", quantity = 1 }, 
			{item = "steel", quantity = 1 },
			{item = "gold", quantity = 5 }, 

		}
	},
	
	["smg_ammo"] = {
		title = 'SMG Ammo',
		timer = 60000,
		amount = 80,
		hidden = true,
		blackmoney = 4000,
		optional = 'blueprint_smgammo',
		items = {
	
			{item = "plastic", quantity = 1 }, 
			{item = "steel", quantity = 1 },
			{item = "gold", quantity = 8 }, 
	

		}
	},

	["rifle_ammo"] = {
		title = 'Rifle Ammo',
		timer = 60000,
		amount = 80,
		hidden = true,
		blackmoney = 5000,
		required = 'blueprint_rifleammo',
		items = {
	
			{item = "plastic", quantity = 1 }, 
			{item = "steel", quantity = 1 },
			{item = "gold", quantity = 3 }, 

		}
	},


	["mg_ammo"] = {
		title = 'SMG Ammo',
		timer = 60000,
		amount = 90,
		hidden = true,
		blackmoney = 3000,
		required = 'blueprint_machinegunammo',
		items = {
	
			{item = "plastic", quantity = 2 }, 
			{item = "steel", quantity = 1 },
			{item = "gold", quantity = 4 }, 

		}
	},

	["shotgun_ammo"] = {
		title = 'Shot Gun Ammo',
		timer = 60000,
		amount = 30,
		hidden = true,
		blackmoney = 3000,
		required = 'blueprint_shotgunammo',
		items = {
	
			{item = "plastic", quantity = 1 }, 
			{item = "steel", quantity = 1 },
			{item = "gold", quantity = 5 }, 

		}
	},
	
	["sniper_ammo"] = {
		title = 'Sniper Ammo',
		timer = 60000,
		amount = 4,
		hidden = true,
		blackmoney = 5000,
		required = 'blueprint_sniperammo',
		items = {
	
			{item = "plastic", quantity = 1 }, 
			{item = "steel", quantity = 2 },
			{item = "gold", quantity = 10 }, 

		}
	},
	

	["screwdriver"] = {
		title = 'Screw Driver',
		timer = 60000,
		blackmoney = 3000,
		items = {
	
			{item = "plastic", quantity = 1 }, 
			{item = "steel", quantity = 1 },
			{item = "gold", quantity = 5 }, 

		}
	},
	["handcuffs"] = {
		title = 'Handcuffs',
		timer = 25000,
		items = {
	
			{item = "stone", quantity = 3 }, 
			{item = "steel", quantity = 3 },
		}
	},
	["key"] = {
		title = 'Handcuff Key',
		timer = 25000,
		items = {
	
			{item = "stone", quantity = 1 }, 
			{item = "steel", quantity = 5 },
		}
	},
	["vehicle_oil"] = {
		title = 'Emergency Vehicle Oil',
		timer = 15000,
		items = {

			{item = "petrol", quantity = 3 }, 

		}
	},
	
	
	["c4_bank"] = {
		title = 'C4 - Bank Robbery',
		timer = 25000,
		items = {
	
			{item = "stone", quantity = 1 }, 
			{item = "steel", quantity = 1 },
			{item = "acetone", quantity = 5 },
		}
	},
	["nitro"] = {
		title = 'Nitro',
		timer = 25000,
		hidden=true,
		items = {
	
			{item = "stone", quantity = 2 }, 
			{item = "gold", quantity = 1 }, 
			{item = "acetone", quantity = 2 },
		}
	},
	["nitro_plus"] = {
		title = 'Nitro Plus',
		timer = 25000,
		hidden=true,
		items = {
	
			{item = "stone", quantity = 3 }, 
			{item = "gold", quantity = 2 }, 
			{item = "acetone", quantity = 3 },
		}
	},
	
	["elights"] = {
		title = 'Emergency Light Set',
		blackmoney = 5000,
		timer = 60000,
		items = {
			{item = "plastic", quantity = 5 }, 
			{item = "steel", quantity = 1 },
			{item = "mobile_phone", quantity = 1 }, 
			{item = "copper", quantity = 1 },
		}
	},
	["repairkit"] = {
		title = 'Personal Repair Kit',
		timer = 30000,
		blackmoney = 3000,
		items = {
			{item = "plastic", quantity = 1 }, 
			{item = "steel", quantity = 1 },

		}
	},
	["methlab"] = { 
		title = 'Methlab',
		items = {
			{item = "stone", quantity = 1 }, 
			{item = "steel", quantity = 1 },
			{item = "copper", quantity = 5 },
			{item = "mobile_phone", quantity = 1 },
		}
		
	},	
	["bpvestl"] = { 
		title = 'Bullet Proof Vest - Light',
		items = {
			{item = "stone", quantity = 1 }, 
			{item = "steel", quantity = 5 },
			{item = "copper", quantity = 10 },
		}
		
	},	
	
	['weapon_pistol'] = { 
		title = 'Pistol',
		timer = 60000,
		hidden = true,
		items = {
			{item = "steel", quantity = 3 }, 
			{item = "gunpowder", quantity = 2},
			{item = "acetone", quantity = 2},
			{item = "plastic", quantity = 3}
		}
	},

	['weapon_knife'] = { 
		title = 'Knife',
		timer = 10000,
		hidden = true,
		items = {
			{item = "steel", quantity = 2 }, 
			{item = "plastic", quantity = 2},
			
		}
	},
	['weapon_molotov'] = { 
		title = 'Molotov Cocktail',
		timer = 60000,
		hidden = true,
		items = {
			{item = "bandage", quantity = 6 }, 
			{item = "beer", quantity = 1 }, 
			{item = "acetone", quantity = 3 }, 
		}
	},
	['weapon_snspistol'] = {
		title = 'SNS Pistol',
		timer = 120000,
		hidden = true,
		items = {
			{item = "steel", quantity = 3 }, 
			{item = "gunpowder", quantity = 3},
			{item = "acetone", quantity = 3},
			{item = "plastic", quantity = 3}
		}
	},
	
	['weapon_appistol'] = {
		title = 'AP Pistol',
		timer = 120000,
		hidden = true,
		required = 'blueprint_appistol',
		items = {
			{item = "steel", quantity = 5 }, 
			{item = "gunpowder", quantity = 11},
			{item = "acetone", quantity = 2},
			{item = "plastic", quantity = 5}
		}
	},
	
	
	['weapon_carbinerifle'] = { 
		title = 'CARBINE RIFLE',
		timer = 120000,
		hidden = true,
		required = 'blueprint_carbinerifle',
		items = {
			{item = "steel", quantity = 10 }, 
			{item = "gunpowder", quantity = 20},
			{item = "acetone", quantity = 2},
			{item = "plastic", quantity = 15}
		}
	},

	['weapon_assaultrifle'] = { 
		title = 'AK 47',
		timer = 120000,
		hidden = true,
		required = 'blueprint_ak47',
		items = {
			{item = "steel", quantity = 10}, 
			{item = "gunpowder", quantity = 12},
			{item = "acetone", quantity = 2},
			{item = "plastic", quantity = 8}
		}
	},
	
	['weapon_compactrifle'] = { 
		title = 'Compact Rifle',
		timer = 120000,
		hidden = true,
		required = 'blueprint_compactrifle',
		items = {
			{item = "steel", quantity = 10 }, 
			{item = "gunpowder", quantity = 11},
			{item = "acetone", quantity = 3},
			{item = "plastic", quantity = 13}
		}
	},
	
	['weapon_sawnoffshotgun'] = { 
		title = 'Sawnoff Shot Gun',
		timer = 120000,
		hidden = true,
		required = 'blueprint_sawnoffshotgun',
		items = {
			{item = "steel", quantity = 9 }, 
			{item = "gunpowder", quantity = 11},
			{item = "acetone", quantity = 4},
			{item = "plastic", quantity = 9}
		}
	},
	['weapon_pumpshotgun_mk2'] = { 
		title = 'Pumpaction Shot Gun',
		timer = 120000,
		hidden = true,
		required = 'blueprint_pumpshotgun_mk2',
		items = {
			{item = "steel", quantity = 10 }, 
			{item = "gunpowder", quantity = 11},
			{item = "acetone", quantity = 3},
			{item = "plastic", quantity = 10}
		}
	},
	["suppressor"] = {
		title = 'Silencer',
		timer = 60000,
		hidden = true,
		required = 'blueprint_suppressor',
		items = {
	
			{item = "plastic", quantity = 10 }, 
			{item = "steel", quantity = 10 },
			{item = "gold", quantity = 22 }, 
			{item = "diamond", quantity = 1 },
			{item = "black_diamond", quantity = 40 },

		}
	},
	
	["grip"] = {
		title = 'Grip',
		timer = 60000,
		hidden = true,
		optional = 'blueprint_grip',
		items = {
	
			{item = "plastic", quantity = 4 }, 
			{item = "steel", quantity = 3 },
			{item = "gold", quantity = 8 }, 

		}
	},
	["scope"] = {
		title = 'Scope',
		timer = 60000,
		hidden = true,
		optional = 'blueprint_scope',
		items = {
	
			{item = "plastic", quantity = 3 }, 
			{item = "steel", quantity = 4 },
			{item = "gold", quantity = 8 }, 
			{item = "black_diamond", quantity = 50 },

		}
	},
	["clip_extended"] = {
		title = 'Extended Clip',
		timer = 60000,
		hidden = true,
		required = 'blueprint_clip_extended',
		items = {
	
			{item = "plastic", quantity = 4 }, 
			{item = "steel", quantity = 3 },
			{item = "gold", quantity = 9 }, 
			
		}
	},
	["clip_drum"] = {
		title = 'Extended Drum Clip',
		timer = 60000,
		hidden = true,
		required = 'blueprint_clip_drum',
		items = {
	
			{item = "plastic", quantity = 4 }, 
			{item = "steel", quantity = 3 },
			{item = "gold", quantity = 8 },
			{item = "diamond", quantity = 1 },
			{item = "black_diamond", quantity = 30 },

		}
	},
	["flashlight"] = {
		title = 'flashlight',
		timer = 60000,
		hidden = true,
		optional = 'blueprint_flashlight',
		items = {
	
			{item = "plastic", quantity = 3 }, 
			{item = "steel", quantity = 2 },
			{item = "gold", quantity = 8 }, 
		}
	},
}




Config.Coords = {
	--vector3(-2174.16, 5195.66, 15.9), --Zancudo Island
	--vector3(962.5,-1585.5,29.6 ), --City Industrial  PC 169
	--vector3(-421.81, -2790.28, 5.39) -- Docks 41
	vector3(747.39, -1911.94, 28.46) --Cypher building 165 powerstation
}

local coords = math.random(1,#Config.Coords)




-- Enable a shop to access the crafting menu
Config.Shop = {
	useShop = true,
	shopCoordinates = Config.Coords[coords],
	shopName = "Crafting Station",
	shopBlipID = 446,
	zoneSize = { x = 2.5, y = 2.5, z = 1.5 },
	zoneColor = { r = 255, g = 0, b = 0, a = 100 }
}

-- Enable crafting menu through a keyboard shortcut
Config.Keyboard = {
	useKeyboard = false,
	keyCode = 303
}