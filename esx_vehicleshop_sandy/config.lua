Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerColor                = { r = 120, g = 120, b = 240 }
Config.EnablePlayerManagement     = false -- enables the actual car dealer job. You'll need esx_addonaccount, esx_billing and esx_society
Config.EnablePvCommand            = false
Config.EnableOwnedVehicles        = true
Config.EnableSocietyOwnedVehicles = true -- use with EnablePlayerManagement disabled, or else it wont have any effects
Config.ResellPercentage           = 50
Config.Locale                     = 'en'

-- looks like this: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlateLetters  = 3
Config.PlateNumbers  = 3
Config.PlateUseSpace = true

Config.Zones = {

  ---HARMONY
   ShopEntering = {
    Pos   = { x = 1224.45, y = 2724.9, z = 36.7 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Type  = 1,
  },
  
    ShopOutside = {
    Pos   = { x = 1211.35, y = 2717.75, z = 36.7 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Heading = 178.7,
    Type    = -1,
  },
  ShopInside = {
    Pos     = { x = 1213.04, y = 2710.71, z = 36.7 },
    Size    = { x = 1.5, y = 1.5, z = 1.0 },
    Heading = 178.7,
    Type    = -1,
  },
    ResellVehicle = {
    Pos   = { x = 1213.09, y = 2729.09, z = 36.7 },
    Size  = { x = 3.0, y = 3.0, z = 1.0 },
    Type  = 1,
  },
  
  BossActions = {
    Pos   = { x = -32.065, y = -1114.277, z = 25.422 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Type  = -1,
  },

  GiveBackVehicle = {
    Pos   = { x = -18.227, y = -1078.558, z = 25.675 },
    Size  = { x = 3.0, y = 3.0, z = 1.0 },
    Type  = (Config.EnablePlayerManagement and 1 or -1),
  },
  
}
