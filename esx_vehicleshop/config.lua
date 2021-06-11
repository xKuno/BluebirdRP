Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerColor                = { r = 120, g = 120, b = 240 }
Config.EnablePlayerManagement     = false -- enables the actual car dealer job. You'll need esx_addonaccount, esx_billing and esx_society
Config.EnablePvCommand            = true
Config.EnableOwnedVehicles        = true
Config.EnableSocietyOwnedVehicles = false -- use with EnablePlayerManagement disabled, or else it wont have any effects
Config.ResellPercentage           = 50
Config.Locale                     = 'en'

Config.CarDiscount				  =	 0.70

-- looks like this: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlateLetters  = 3
Config.PlateNumbers  = 3
Config.PlateUseSpace = true

Config.Zones = {

  ShopEntering = {
    Pos   = { x = -33.777, y = -1102.021, z = 25.422 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Type  = 1,
  },
   ShopBrowsing2 = {
    Pos   = { x = -40.25, y = -1106.61, z = 26.222 },
    Size  = { x = 0.5, y = 0.5, z = 0.5 },
    Type  = 28,
  },
  
   ShopBrowsing = {
    Pos   = { x = -40.25, y = -1106.61, z = 25.465 },
    Size  = { x = 1.5, y = 1.5, z = 1.5 },
    Type  = 27,
  },
    
   ShopBrowsingInside = {
    Pos   = { x = -42.58, y = -1100.92, z = 25.41 },
    Size  = { x = 1.0, y = 1.0, z = 1.0 },
	Heading = 251.61,
    Type  = -1,
  },
  
  
   ShopBrowsingInside = {
    Pos   = { x = -42.58, y = -1100.92, z = 25.41 },
    Size  = { x = 1.0, y = 1.0, z = 1.0 },
	Heading = 251.61,
    Type  = -1,
  },

  ShopInside = {
    Pos     = { x = -42.58, y = -1100.92, z = 25.41 },
    Size    = { x = 1.5, y = 1.5, z = 1.0 },
    Heading = 251.61,
    Type    = -1,
  },

  ShopOutside = {
    Pos     = { x = -28.67, y = -1081.18, z = 26.54 },
    Size    = { x = 1.5, y = 1.5, z = 1.0 },
    Heading = 69.41,
    Type    = -1,
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

  ResellVehicle = {
    Pos   = { x = -44.630, y = -1080.738, z = 25.683 },
    Size  = { x = 3.0, y = 3.0, z = 1.0 },
    Type  = 1,
  },
  
   GoDownFrom = {
    Pos   = { x = -22.38, y = -1102.04, z = 35.92 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Type  = 27,
  },

  GoUpFrom = {
    Pos   = { x = -28.53, y = -1094.24, z = 26.44 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Type  = 27,
  },

  
}
