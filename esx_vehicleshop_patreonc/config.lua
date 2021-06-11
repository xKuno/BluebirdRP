Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerColor                = { r = 120, g = 120, b = 240 }
Config.EnablePlayerManagement     = false -- enables the actual car dealer job. You'll need esx_addonaccount, esx_billing and esx_society
Config.EnablePvCommand            = false
Config.EnableOwnedVehicles        = true
Config.EnableSocietyOwnedVehicles = true -- use with EnablePlayerManagement disabled, or else it wont have any effects
Config.ResellPercentage           = 75
Config.Locale                     = 'en'

-- looks like this: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlateLetters  = 3
Config.PlateNumbers  = 2
Config.PlateUseSpace = true

Config.Zones = {

  ---AIRPORT
   ShopEntering = {
    Pos   = { x = 152.73, y = -3077.64, z = 5.9 },
    Size  = { x = 2.5, y = 2.5, z = 2.0 },
    Type  = 5,
  },
  
    ShopOutside = {
    Pos     = { x = 126.83, y = -3089.02, z = 4.95 },
    Size    = { x = 1.5, y = 1.5, z = 1.0 },
    Heading = 88.26,
    Type    = -1,
  },
  ShopInside = {
    Pos     = { x = 139.12, y = -3089.4, z = 4.95 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Heading = 88.26,
    Type    = -1,
  },
    ResellVehicle = {
    Pos   = { x = 166.13, y = -3109.79, z = 4.89 },
    Size  = { x = 3.0, y = 3.0, z = 1.0 },
    Type  = 1,
  },
  
  BossActions = {
    Pos   = { x = -1697.65, y = -3155.277, z = 24.422 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Type  = -1,
  },

  GiveBackVehicle = {
    Pos   = { x = -1637.27, y = -3165.84, z = 13.675 },
    Size  = { x = 3.0, y = 3.0, z = 1.0 },
    Type  = (Config.EnablePlayerManagement and 1 or -1),
  },
  
}


