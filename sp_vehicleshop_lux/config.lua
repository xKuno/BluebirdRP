Config                            = {}
Config.DrawDistance               = 100.0
Config.MarkerColor                = { r = 120, g = 120, b = 240 }
Config.EnablePlayerManagement     = true -- enables the actual car dealer job. You'll need esx_addonaccount, esx_billing and esx_society
Config.EnableOwnedVehicles        = true
Config.EnableSocietyOwnedVehicles = false -- use with EnablePlayerManagement disabled, or else it wont have any effects
Config.ResellPercentage           = 50

Config.CarDiscount				  =	 0.70

Config.Locale                     = 'en'

Config.LicenseEnable =true -- require people to own drivers license when buying vehicles? Only applies if EnablePlayerManagement is disabled. Requires esx_license

-- looks like this: 'LLL NNN'
-- The maximum plate length is 8 chars (including spaces & symbols), don't go past it!
Config.PlateLetters  = 3
Config.PlateNumbers  = 3
Config.PlateUseSpace = true

Config.Zones = {

  ShopEntering = {
    Pos   = { x = -54.25, y = 67.27, z = 71.00 },                    
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Type  = 1,
  },
  
  ShopBrowsing = {
    Pos     = { x = -65.91 , y = 75.58, z = 70.65 },
    Size    = { x = 1.5, y = 1.5, z = 1.0 },
    Heading = 179.19,
    Type    = 27,
  },
  
   ShopBrowsing = {
    Pos     = { x = -65.91 , y = 75.58, z = 70.65 },
    Size    = { x = 1.5, y = 1.5, z = 1.0 },
    Heading = 179.19,
    Type    = 27,
  },
    
   ShopBrowsingInside = {
    Pos     = { x = -76.8 , y = 89.73, z = 71.7 },
    Size    = { x = 1.5, y = 1.5, z = 1.0 },
    Heading = 246.89,
    Type    = -1,
  },
  
  
   ShopBrowsingInside = {
    Pos     = { x = -76.8 , y = 89.73, z = 71.7 },
    Size    = { x = 1.5, y = 1.5, z = 1.0 },
    Heading = 246.89,
    Type    = -1,
  },
  
	ShopInside = {
    Pos     = { x = -60.09, y = 78.58, z = 71.50 },
    Size    = { x = 1.5, y = 1.5, z = 1.0 },
    Heading = 64.84,
    Type    = -1,
  },

  ShopOutside = {
    Pos     = { x = -60.09, y = 78.58, z = 71.50 },
    Size    = { x = 1.5, y = 1.5, z = 1.0 },
    Heading = 64.84,
    Type    = -1,
  },

  BossActions = {
    Pos   = { x = -52.62, y = 72.75, z = 71.50 },           
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Type  = -1,
  },

	--GiveBackVehicle = {
	--	Pos   = { x = -18.227, y = -1078.558, z = 25.675 },
	--	Size  = { x = 3.0, y = 3.0, z = 1.0 },
	--	Type  = (Config.EnablePlayerManagement and 1 or -1)
	--},

	ResellVehicle = {
    Pos   = { x = -50.42, y = 84.05, z = 72.7 },         
    Size  = { x = 3.0, y = 3.0, z = 1.0 },
    Type  = 1,
  }

}
