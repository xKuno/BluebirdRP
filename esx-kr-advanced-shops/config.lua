Config                            = {}
Config.DrawDistance               = 20.0
Config.Locale = 'en'
Config.DeliveryTime = 18000 -- IN SECOUNDS DEFAULT (18000) IS 5 HOURS / 300 MINUTES
Config.DirtyDeliveryTime = 604800 -- IN SECOUNDS DEFAULT (18000) IS 5 HOURS / 300 MINUTES  604800 = 7 days
Config.TimeBetweenRobberies = 43200
Config.CutOnRobbery = 5 -- IN PERCENTAGE FROM THE TARGET SHOP
Config.RequiredPolices = 3 -- For the robbery
Config.SellValue = 2 -- This is the shops value divided by 2
Config.ChangeNamePrice = 8000 -- In $ - how much you can change the shops name for

-- CONFIG ITEMS, DON'T FORGET TO ADD CORRECT NUMBER IN THE BRACKETS
Config.Items = {
    [1] = {label = "Water",       item = "water",  black = false,      price = 20}, 
    [2] = {label = "Bread",      item = "bread", black = false,      price = 20},
	[3] = {label = "Chocolate",      item = "chocolate", black = false,   price = 20},
	[4] = {label = "Sandwich",      item = "sandwich",  black = false,  price = 20},
	[5] = {label = "Hamburger",      item = "hamburger", black = false,   price = 20},
	[6] = {label = "Cupcake",      item = "cupcake", black = false,  price = 20},
	[7] = {label = "Cola",      item = "cola", black = false,  price = 20},
	[8] = {label = "Cocacola",      item = "cocacola", black = false,   price = 20},
	[9] = {label = "Milk",      item = "milk", black = false,   price = 20},	
	[10] = {label = "Redbull",      item = "redbull", black = false,   price = 20},	

	[11] = {label = "Moneywash Pass",      item = "moneywashid", black = false,  price = 180},	
	[12] = {label = "Repair Kit",      item = "repairkit",  black = false,  price = 800},	
	[13] = {label = "Lady Luck Scratchie",      item = "scratchoff", black = false,   price = 30},
	[14] = {label = "Mobile Phone",      item = "mobile_phone", black = false,  price = 1500},
	[15] = {label = "Acetone",      item = "acetone",  black = false,  price = 450},
	[16] = {label = "Methlab *Illegal*",      item = "methlab",  black = false,   price = 4500},
	[17] = {label = "Lithium",      item = "lithium", black = false,  price = 1500},
	[18] = {label = "Lighter",      item = "lighter",  black = false,  price = 40},
	[19] = {label = "Whisky",      item = "whisky",   black = false,  price = 80},
	[20] = {label = "Wine",      item = "wine",  black = false,  price = 70},
	[21] = {label = "Vegetables",      item = "vegetables",  black = false,   price = 80},	
	[22] = {label = "Bullet Proof Vest - Heavy",      item = "bpvesth",  black = true,   price = 12000},	
	[23] = {label = "Bullet Proof Vest - Light",      item = "bpvestl",  black = true,   price = 8000},	
	[24] = {label = "Bullet Proof Vest - Light",      item = "bpvestl",  black = false,   price = 10000},	
	[25] = {label = "Slurpee", maxamt = 350,     item = "slurpee", black = true,   price = 50},
	[26] = {label = "The Shit", maxamt = 1000,     item = "seed_opium",  black = true,   price = 40},
	[27] = {label = "Ice Ice Baby", maxamt = 1000,     item = "lsd_tablet",  black = true,   price = 40},
	[28] = {label = "Fraudulent Credit Cards",  maxamt = 3000,  item = "creditcard_fake",  black = true,   price = 60},
	---
	[30] = {label = "Gun Powder",    maxamt = 60,  item = "gunpowder",  black = true,   price = 11200},
	[31] = {label = "Moneywash Pass", maxamt = 1000, item = "moneywashid", black = true,  price = 200},	
	--[32] = {label = "BluePrint - Weapon Flashlight", maxamt = 1, item = "blueprint_flashlight", black = true,  price = 250000},	
	[33] = {label = "Sim Card", maxamt = 2, item = "sim", black = true,  price = 200000},	
	[34] = {label = "BluePrint - Supressor", maxamt = 1, item = "blueprint_suppressor", black = true,  price = 2500000},
	[35] = {label = "BluePrint - Extended Clip", maxamt = 1, item = "blueprint_clip_extended", black = true,  price = 2800000},
	--[36] = {label = "BluePrint - Scope", maxamt = 1, item = "blueprint_scope", black = true,  price = 1500000},
	[40] = {label = "BluePrint - Rifle Ammo", maxamt = 1, item = "blueprint_rifleammo", black = true,  price = 1500000},
	--[35] = {label = "BluePrint - Grip", maxamt = 1, item = "blueprint_grip", black = true,  price = 1500000},
	--[36] = {label = "BluePrint - Sawn off Shotgun", maxamt = 1, item = "blueprint_sawnoffshotgun", black = true,  price = 2500000},
	[37] = {label = "BluePrint - Pumpaction Shotgun (not bean bag)", maxamt = 1, item = "blueprint_pumpshotgun_mk2", black = true,  price = 2800000},
	--[38] = {label = "BluePrint - Carbine Rifle", maxamt = 1, item = "blueprint_carbinerifle", black = true,  price = 2800000},

	--[50] = {label = "Ware House Token - Allows Warehouse Purchase", maxamt = 1, item = "token_warehouse", black = true,  price = 4500000},
	[51] = {label = "Plastic", maxamt = 12, item = "plastic", black = true,  price = 19500},
	[52] = {label = "Steel", maxamt = 12, item = "steel", black = true,  price = 19500},
	
	
}
--25

Config.Images = {
  [1] = {item = "water",   src = "img/bottle.png"},
  [2] = {item = "bread",   src = "img/burger.png"},
}

Config.Zones = {

  ShopCenter = {
    Pos   = {x = 6.09,   y = -708.89,  z = 44.97, number = 'center', enabled = true},
  },
  
  
  --[[
  Robbery1 = {
    Pos   = {x = 379.19, y = 332.08, z = 102.57, number = 121, red = true , enabled = false},
  },
  Robbery2 = {
    Pos   = {x = 2550.15, y = 385.37, z = 107.62, number = 102, red = true , enabled = false},
  },
  Robbery3 = {
    Pos   = {x = -3047.08, y = 586.37, z = 6.91, number = 103, red = true , enabled = false},
  },
  Robbery4 = {
    Pos   = {x = -1480.09, y = -373.35, z = 38.16, number = 104, red = true , enabled = false},
  },
  Robbery5 = {
    Pos   = {x = 1396.21, y = 3611.28, z = 33.98, number = 105, red = true , enabled = false},
  },
  Robbery6 = {
    Pos   = {x = -2959.15, y = 388.54, z = 13.04, number = 106, red = true, enabled = false},
  },
  Robbery7 = {
    Pos   = {x = 2673.59, y = 3286.2, z = 54.24, number = 107, red = true, enabled = false},
  },
  Robbery8 = {
    Pos   = {x = -43.7, y = -1750.58, z = 28.42, number = 108, red = true, enabled = false},
  },
  Robbery9 = {
    Pos   = {x = 1161.15, y = -315.73, z = 68.21, number = 109, red = true, enabled = false},
  },
  Robbery10 = {
    Pos   = {x = -708.29, y = -905.99, z = 18.22, number = 110, red = true, enabled = false},
  },
  Robbery11 = {
    Pos   = {x = -1827.32, y = 798.78, z = 137.16, number = 111, red = true, enabled = false},
  },
  Robbery12 = {
    Pos   = {x = 1705.41, y = 4920.56, z = 41.06, number = 112, red = true, enabled = false},
  },
  Robbery13 = {
    Pos   = { x = 1959.04, y = 3747.93, z = 31.34, number = 113, red = true, enabled = false},
  },
  Robbery14 = {
    Pos   = {x = 1126.83, y = -982.6, z = 44.42, number = 114, red = true , enabled = false},
  },
  Robbery15 = {
    Pos   = {x = 28.48, y = -1339.94, z = 28.5, number = 115, red = true, enabled = false},
  },
  Robbery16 = {
    Pos   = {x = -1384.41, y = -628.71, z = 29.82, number = 116, red = true, enabled = false},
  },
  Robbery17 = {
    Pos   = {x = 546.86, y = 2663.71, z = 41.16, number = 117, red = true , enabled = false},
  },
  Robbery18= {
    Pos   = {x = -3249.3, y = 1004.54, z = 11.83, number = 118, red = true, enabled = false},
  },
  Robbery19 = {
    Pos   = {x = 1166.89, y = 2718.14, z = 36.16, number = 119, red = true, enabled = false},
  },
  Robbery20= {
    Pos   = {x = 1734.88, y = 6419.83, z = 34.04, number = 120, red = true, enabled = false},
  },--]]
}