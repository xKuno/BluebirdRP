Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerColor                = { r = 120, g = 120, b = 240 }
Config.EnablePlayerManagement     = false -- enables the actual car dealer job. You'll need esx_addonaccount, esx_billing and esx_society
Config.EnablePvCommand            = false
Config.EnableOwnedVehicles        = true
Config.EnableSocietyOwnedVehicles = true -- use with EnablePlayerManagement disabled, or else it wont have any effects
Config.ResellPercentage           = 80
Config.Locale                     = 'en'

-- looks like this: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlateLetters  = 1
Config.PlateNumbers  = 7
Config.PlateUseSpace = false

Config.Zones = {

  ---AIRPORT
   ShopEntering = {
    Pos   = vector3(1197.62, -3105.59, 6.32),
    Size  = { x = 2.5, y = 2.5, z = 2.0 },
    Type  = 5,
  },
  
    ShopOutside = {
    Pos   = vector3(1204.42, -3101.7, 5.09),
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Heading = 328.7,
    Type    = -1,
  },
  ShopInside = {
    Pos     = vector3(1204.91, -3116.23, 5.54),
    Size    = { x = 1.5, y = 1.5, z = 1.0 },
    Heading = 328.7,
    Type    = -1,
  },
    ResellVehicle = {
    Pos   = vector3(1189.75, -3106.68, 5.61),
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
