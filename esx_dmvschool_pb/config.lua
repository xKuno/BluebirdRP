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
    Pos   = {x = -144.53, y = 6306.01 , z = 31.55},
    Size  = {x = 1.5, y = 1.5, z = 1.0},
    Color = {r = 204, g = 204, b = 0},
    Type  = 21
  },

  VehicleSpawnPoint = {
    Pos   = {x = -162.03  , y = 6299.55, z = 30.29},
    Size  = {x = 1.5, y = 1.5, z = 1.0},
    Color = {r = 204, g = 204, b = 0},
    Type  = -1
  },

}

Config.CheckPoints = {

  {
    Pos = vector3(-148.15425109863,6312.1381835938,30.901460647583 ),
    Action = function(playerPed, vehicle, setCurrentZoneType)
	  setCurrentZoneType('town')
      DrawMissionText(_U('next_point_speed') .. Config.SpeedLimits['town'] .. 'km/h', 5000)
    end
  },

  {
    Pos = vector3(-109.85544586182,6290.0766601563,30.731430053711 ),
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText(_U('go_next_point'), 5000)
	  PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
    end
  },

    {
    Pos = vector3(-223.13548278809,6163.3168945313,30.734718322754 ),
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText(_U('go_next_point'), 5000)
	  PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
    end
  },
  
   {
    Pos = vector3(-286.78433227539,6218.140625,30.954870223999 ),
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText(_U('go_next_point'), 5000)
	  PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
    end
  },
  
     {
    Pos = vector3(-356.25817871094,6298.06640625,29.322147369385 ),
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText(_U('go_next_point'), 5000)
	  PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
    end
  },
    {
    Pos = vector3(-181.82344055176,6463.0517578125,30.146827697754 ),
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText(_U('go_next_point'), 5000)
	  PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
    end
  },
  
    {
    Pos = vector3(57.303756713867,6619.412109375,31.046615600586 ),
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText(_U('go_next_point'), 5000)
	  PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
    end
  },
     
    {
    Pos = vector3(-103.23481750488,6433.5786132813,30.839387893677 ),
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText(_U('go_next_point'), 5000)
	  PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
    end
  },

 {
    Pos = vector3(-167.28756713867,6371.2250976563,30.940351486206 ),
    Action = function(playerPed, vehicle, setCurrentZoneType)
      DrawMissionText(_U('go_next_point'), 5000)
	  PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', 0, 0, 1)
    end
  },


  {
    Pos = vector3(-143.35821533203,6315.6162109375,31.050651550293 ),
    Action = function(playerPed, vehicle, setCurrentZoneType)
      ESX.Game.DeleteVehicle(vehicle)
    end
  },

}
