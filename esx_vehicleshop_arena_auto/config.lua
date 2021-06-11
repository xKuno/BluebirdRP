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

   ShopEntering = { --entry blip
    Pos   = vector3(2821.56, -3908.12, 140),
    Size  = { x = 1.5, y = 1.5, z = 1.5 },
    Type  = 5,
  },
  
    ShopOutside = { --car spawn
    Pos   = vector3(2825.05, -3897.53, 140),
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Heading = 0,
    Type    = -1,
  },
  ShopInside = { --preview menu
    Pos     = vector3(2825.03, -3912.48, 140),
    Size    = { x = 1.5, y = 1.5, z = 1.0 },
    Heading = 90,
    Type    = -1,
  },
    ResellVehicle = { --sell car back
    Pos   = vector3(2814.95, -3912.34, 139),
    Size  = { x = 3.0, y = 3.0, z = 1.0 },
    Type  = 1,
  },
  
  BossActions = { --useless
    Pos   = { x = -1697.65, y = -3155.277, z = 24.422 },
    Size  = { x = 1.5, y = 1.5, z = 1.0 },
    Type  = -1,
  },

  GiveBackVehicle = { --useless
    Pos   = { x = -1637.27, y = -3165.84, z = 13.675 },
    Size  = { x = 3.0, y = 3.0, z = 1.0 },
    Type  = (Config.EnablePlayerManagement and 1 or -1),
  },
  
}
