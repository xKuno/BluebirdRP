Config                 = {}
Config.DrawDistance    = 70.0
Config.MaxErrors       = 10
Config.SpeedMultiplier = 3.6
Config.Locale          = 'en'

Config.Prices = {
  dmv         = 200,
  drive       = 500,
  drive_bike  = 400,
  drive_truck = 800
}

Config.VehicleModels = {
  drive       = 'blista',
  drive_bike  = 'ruffian',
  drive_truck = 'mule3'
}

Config.SpeedLimits = {
  residence = 60,
  town      = 80,
  freeway   = 120
}

Config.Zones = {

  DMVSchool = {
    Pos   = {x = 1769.3, y = 3321.33, z =41.44},
    Size  = {x = 1.5, y = 1.5, z = 1.0},
    Color = {r = 204, g = 204, b = 0},
    Type  = 21
  },

  VehicleSpawnPoint = {

    Pos   = {x = 1770.16, y = 3331.07, z = 41.44},
    Size  = {x = 1.5, y = 1.5, z = 1.0},
    Color = {r = 204, g = 204, b = 0},
    Type  = -1
  },
  
    VehicleSpawnPointTruck = {

    Pos   = {x = 1767.2, y = 3340.23, z = 41.44},
    Size  = {x = 1.5, y = 1.5, z = 1.0},
    Color = {r = 204, g = 204, b = 0},
    Type  = -1
  },
  
  


}

Config.CheckPoints = {

  {
    Pos = {x = 1816.03, y = 3293.54, z = 42.36},
    Action = function(playerPed, vehicle, setCurrentZoneType)
	  setCurrentZoneType('town')
      DrawMissionText(_U('next_point_speed') .. Config.SpeedLimits['town'] .. 'km/h', 5000)
    end
  },

  {
    Pos = {x = 2180.8, y = 3020.87, z = 44.57},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText(_U('go_next_point'), 5000)
	  PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
    end
  },

    {
    Pos = {x = 2246.74, y = 3232.94, z = 47.33},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText(_U('go_next_point'), 5000)
	  PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
    end
  },
  
   {
    Pos = {x = 2059.66, y = 3370.1, z = 44.63},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText(_U('go_next_point'), 5000)
	  PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
    end
  },
  
     {
    Pos = {x = 2035.01, y = 3447.15, z = 43.44},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText(_U('go_next_point'), 5000)
	  PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
    end
  },
    {
    Pos = {x = 1877.28, y = 3230.76, z = 44.57},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText(_U('go_next_point'), 5000)
	  PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
    end
  },
     
  {
    Pos = {x = 1771.25, y = 3345.9, z = 40.34},
    Action = function(playerPed, vehicle, setCurrentZoneType)
      ESX.Game.DeleteVehicle(vehicle)
    end
  },

}
