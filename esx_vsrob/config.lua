-- ModFreakz
-- For support, previews and showcases, head to https://discord.gg/ukgQa5K

MF_Vangelico = {}
local MFV  = MF_Vangelico
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)

MFV.Version = '1.0.12'

Citizen.CreateThread(function(...)
  while not ESX do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj; end)
    Citizen.Wait(0)
  end
end)

-- Make sure you change these.
MFV.InteractDist = 2.0 -- dist for drawtext to appear
MFV.RefreshTimer = 360 -- minutes? (maybe, idk)
MFV.MinPoliceOnline = 10 -- if count >= policecount, then canrob = true;
MFV.PoliceJobName = "police" -- change this to your police job label, found in the database table "jobs".

-- Probably don't change these.
MFV.LoadZoneDist = 50.0 
MFV.SeatHash = 1630899471

MFV.SafePos = vector3(-625.55, -223.78, 38.20)
MFV.SafePosition = vector3(-625.243, -223.44, 37.78)

MFV.BobSpawnPos = vector3(-623.65,-250.36,38.53)

-- Rewards for the safe.
MFV.SafeRewards = { 
  CashAmount    = math.random(60000,85000),
  ItemsAmount   = math.random(1,6), -- math.random(0,itemsamount) = reward
  Items = { 'necklace', 'rolex', 'diamond_ring' }, -- ^ for all
}

MFV.LootTable = {
  ["Jewelry"] = {
    ["Small"] = {   
      ["gold"] = math.random(9,15), -- max amount
      ["black_diamond"] = math.random(8,25),

    },
	["Medium"] = {   
      ["gold"] = math.random(18,50), -- max amount
      ["black_diamond"] = math.random(20,50),
      ["necklace"] = 1,
    },
	["Large"] = {   
      ["gold"] = math.random(40,80), -- max amount
      ["black_diamond"] = math.random(45,100),
      ["rolex"] = 1,
    },
  }
}

MFV.VangelicoPosition = vector3(-623.94, -232.37, 38.06)

MFV.MarkerPositions = {
  [1] = { 
    Pos = vector3(-624.080, -230.78, 38.20),
    Loot = "Jewelry",
    Amount = "Medium",
  },
  [2] = { 
    Pos = vector3(-622.72, -232.58, 38.20),
    Loot = "Jewelry",
    Amount = "Small",
  },
  [3] = { 
    Pos = vector3(-620.49, -232.78, 38.20),
    Loot = "Jewelry",
    Amount = "Medium",
  },
  [4] = { 
    Pos = vector3(-619.92, -234.74, 38.20),
    Loot = "Jewelry",
    Amount = "Large",
  },  
  [5] = { 
    Pos = vector3(-618.92, -234.11, 38.20),
    Loot = "Jewelry",
    Amount = "Small",
  },
  [6] = { 
    Pos = vector3(-620.02, -230.87, 38.20),
    Loot = "Jewelry",
    Amount = "Medium",
  },
  [7] = { 
    Pos = vector3(-621.49, -228.98, 38.20),
    Loot = "Jewelry",
    Amount = "Medium",
  },
  [8] = { 
    Pos = vector3(-623.56, -228.49, 38.20),
    Loot = "Jewelry",
    Amount = "Medium",
  },
  [9] = { 
    Pos = vector3(-625.27, -227.43, 38.20),
    Loot = "Jewelry",
    Amount = "Small",
  },
  [10] = { 
    Pos = vector3(-624.22, -226.56, 38.20),
    Loot = "Jewelry",
    Amount = "Small",
  },
  [11] = { 
    Pos = vector3(-619.97, -226.18, 38.20),
    Loot = "Jewelry",
    Amount = "Small",
  },
  [12] = { 
    Pos = vector3(-619.22, -227.28, 38.20),
    Loot = "Jewelry",
    Amount = "Small",
  },
  [13] = { 
    Pos = vector3(-617.83, -229.21, 38.20),
    Loot = "Jewelry",
    Amount = "Small",
  },
  [14] = { 
    Pos = vector3(-617.09, -230.14, 38.20),
    Loot = "Jewelry",
    Amount = "Small",
  },
  [15] = { 
    Pos = vector3(-627.09, -234.97, 38.20),
    Loot = "Jewelry",
    Amount = "Small",
  },
  [16] = { 
    Pos = vector3(-627.64, -234.35, 38.20),
    Loot = "Jewelry",
    Amount = "Small",
  },
  [17] = { 
    Pos = vector3(-626.64, -233.61, 38.20),
    Loot = "Jewelry",
    Amount = "Small",
  },
  [18] = { 
    Pos = vector3(-626.18, -234.09, 38.20),
    Loot = "Jewelry",
    Amount = "Small",
  },
  [19] = { 
    Pos = vector3(-625.31, -238.17, 38.20),
    Loot = "Jewelry",
    Amount = "Small",
  },
  [20] = { 
    Pos = vector3(-626.35, -238.91, 38.20),
    Loot = "Jewelry",
    Amount = "Small",
  },
}

MFV.SmashAnimations = {
  [1] = "smash_case",
  [2] = "smash_case_b",
  [3] = "smash_case_c",
  [4] = "smash_case_d",
  [5] = "smash_case_e",
  [6] = "smash_case_f",
  [7] = "smash_case_tray_a",
}

MFV.MeleeWeapons = {
["WEAPON_BAT"]                           =  `WEAPON_BAT`,
["WEAPON_BALL"]                          =  `WEAPON_BALL`,
["WEAPON_BOTTLE"]                        =  `weapon_bottle`,
["WEAPON_CROWBAR"]                       =  `weapon_crowbar`,
["WEAPON_DAGGER"]                        =  `weapon_dagger`,
["WEAPON_FIREEXTINGUISHER"]              =  `WEAPON_FIREEXTINGUISHER`,
["WEAPON_FLAREGUN"]                      =  `WEAPON_FLAREGUN`, 
["WEAPON_KNIFE"]                         =  `WEAPON_KNIFE`,
["WEAPON_HAMMER"]                        =  `WEAPON_HAMMER`,
["WEAPON_HATCHET"]                       =  `WEAPON_HATCHET`,
["WEAPON_MOLOTOV"]                       =  `WEAPON_MOLOTOV`,
["WEAPON_PETROLCAN"]                     =  `WEAPON_PETROLCAN`, 
["WEAPON_MACHETE"]                       =  `WEAPON_MACHETE`,
["WEAPON_WRENCH"]                        =  `WEAPON_WRENCH`,
["WEAPON_NIGHTSTICK"]                        =  `WEAPON_NIGHTSTICK`,
}