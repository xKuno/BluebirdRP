ESX = nil
local PlayerData = nil
local jobBlip = nil
local isInMarker = false
local currentZone = false
local hasAlreadyEnteredMarker = false
local route = nil
local routeTable = nil
local nextPos = 2
local nextPosBlip = nil
local ready = false
local started = false
local shownStartHelp = false

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Wait(100)
  end
  PlayerData = ESX.GetPlayerData()
  RefreshBlips()
end)

-- Create station blip, only if job is bus
function RefreshBlips()
  if PlayerData ~= nil and PlayerData.job ~= nil and PlayerData.job.name == "bus" then
    local blip = AddBlipForCoord(Config.Blip.coords.x, Config.Blip.coords.y, Config.Blip.coords.z)
    SetBlipSprite(blip, Config.Blip.sprite)
    SetBlipDisplay(blip, 3)
    SetBlipScale(blip, 0.9)
    SetBlipCategory(blip, 3)
    SetBlipColour(blip, Config.Blip.color)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Bus Depot")
    EndTextCommandSetBlipName(blip)
    jobBlip = blip
  else
    if jobBlip ~= nil then
      RemoveBlip(jobBlip)
    end
  end
end

-- Display marker for bus pickup
Citizen.CreateThread(function()
  while true do
    Citizen.Wait(15)
    if PlayerData ~= nil and PlayerData.job ~= nil and PlayerData.job.name == "bus" then
      DrawMarker(21, Config.BusPickup.coords.x, Config.BusPickup.coords.y, Config.BusPickup.coords.z + 1.5, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 0.5, 1.0, 0, 0, 200, 100, true, true, 2, false, false, false, false)
      if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.BusPickup.coords.x, Config.BusPickup.coords.y, Config.BusPickup.coords.z) < 1.0 then
        isInMarker = true
        currentZone = "buspickup"
      else
        isInMarker = false
        hasAlreadyEnteredMarker = false
      end
      if isInMarker then
        if IsControlJustReleased(0, 51) and currentZone == "buspickup" then
          route = math.random(1, #Config.Routes) -- Pick a random route
          routeTable = Config.Routes[route]
          SpawnBus()
        end
      end

      if isInMarker and not hasAlreadyEnteredMarker then
        ESX.ShowHelpNotification("Press ~INPUT_CONTEXT~ to pick up bus")
        hasAlreadyEnteredMarker = true
      end

      if not isInMarker and hasAlreadyEnteredMarker then
        TriggerEvent('a09f27b0-3cb1-421a-8258-393231e9366b', currentZone)
      end

      if started and GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), routeTable[nextPos].x, routeTable[nextPos].y, routeTable[nextPos].z) < 100 then
        DrawMarker(21, routeTable[nextPos].x, routeTable[nextPos].y, routeTable[nextPos].z + 1.5, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 1.0, 1.0, 1.0, 0, 0, 200, 100, true, true, 2, false, false, false, false)
        DrawMarker(1, routeTable[nextPos].x, routeTable[nextPos].y, routeTable[nextPos].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 10.0, 10.0, 1.0, 0, 0, 200, 50, false, true, 2, false, false, false, false)
      end
    end
  end
end)

-- Job Loop
Citizen.CreateThread(function()
  while true do
    if not ready then
      Citizen.Wait(1000)
    else
      Citizen.Wait(1)
      if ready and not started then
        if not shownStartHelp then
          ESX.ShowHelpNotification("Start your route with /bus start. You can finish it with /bus finish")
          shownStartHelp = true
        end
      end
      if IsControlJustReleased(0, 51) and IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), false), GetHashKey(Config.VehicleModel)) then
        if not started then
          nextPos = 2
          started = true
        elseif started then
          if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), routeTable[nextPos].x, routeTable[nextPos].y, routeTable[nextPos].z) < 10 then
            RemoveBlip(nextPosBlip)
            if routeTable[nextPos + 1] == nil then
              nextPos = 1
            else
              nextPos = nextPos + 1
            end
            nextPosBlip = nil
			print('triggered payment')
            TriggerServerEvent('8eee31f7-197d-4ab6-8680-e046555f9e0f', route)
          else
            ESX.ShowHelpNotification("You aren't at the next stop yet.")
          end
        end
        if nextPosBlip == nil then
          nextPosBlip = AddBlipForCoord(routeTable[nextPos].x, routeTable[nextPos].y, routeTable[nextPos].z)
          SetBlipRoute(nextPosBlip, true)
          SetBlipColour(nextPosBlip, 3)
          SetBlipRouteColour(nextPosBlip, 3)
          BeginTextCommandSetBlipName('STRING')
          AddTextComponentString("Next Stop")
          EndTextCommandSetBlipName(nextPosBlip)
          ESX.ShowHelpNotification("Here we go! Follow the GPS coordinates and use 'E' at each stop along the route.")
        end
      end
    end
  end
end)

RegisterCommand("bus", function(source, args, rawCommand)
  if args[1] == "start" then
    if IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), false), Config.VehicleModel) then
      nextPos = 2
      started = true
      nextPosBlip = AddBlipForCoord(routeTable[nextPos].x, routeTable[nextPos].y, routeTable[nextPos].z)
      SetBlipRoute(nextPosBlip, true)
      SetBlipColour(nextPosBlip, 3)
      SetBlipRouteColour(nextPosBlip, 3)
      BeginTextCommandSetBlipName('STRING')
      AddTextComponentString("Next Stop")
      EndTextCommandSetBlipName(nextPosBlip)
      TriggerEvent('31f60a72-5898-496f-9a65-9011faac567b', { args = {"^1[bus]", "Here we go! Follow the GPS coordinates and use 'E' at each stop along the route."}})
    end
  elseif args[1] == "finish" then
    nextPos = nil
    started = false
    ready = false
    RemoveBlip(nextPosBlip)
    TriggerEvent('31f60a72-5898-496f-9a65-9011faac567b', { args = {"^1[bus]", "You have stopped your shift. You will need a new bus to resume."}})
  elseif args[1] == "route" and IsVehicleModel(GetVehiclePedIsIn(GetPlayerPed(-1), false), GetHashKey(Config.VehicleModel)) then
    local i = tonumber(args[2])
    if Config.Routes[i] == nil then
      TriggerEvent('31f60a72-5898-496f-9a65-9011faac567b', { args = {"^1[bus]", "Invalid route provided." }})
      return
    end
    route = args[2]
    routeTable = Config.Routes[i]
    nextPos = 2
    ready = true
    started = false
    TriggerEvent('31f60a72-5898-496f-9a65-9011faac567b', { args = {"^1[bus]", "Route changed to " .. args[2] .. ". When ready, type /bus start."}})
  else
    TriggerEvent('31f60a72-5898-496f-9a65-9011faac567b', { args = {"^1[bus]", "Invalid argument. Accepted: start, finish"}})
  end
end)

-- For DH's identity script, reload all the things
AddEventHandler('8e540348-36ce-4885-ab68-b0a712a90ec5', function()
  -- Reload ESX object to get all character details
  ESX = nil
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Wait(100)
  end
  PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function(job)
  PlayerData.job = job
  RefreshBlips()
end)

function SpawnBus()
  local coords = {}
  -- @TODO Rewrite to pick an open platform
  if route == 1 then
    coords = Config.BusPickup.platform1
  elseif route == 2 then
    coords = Config.BusPickup.platform2
  elseif route == 3 then
    coords = Config.BusPickup.platform3
  elseif route == 4 then
    coords = Config.BusPickup.platform4
  end
  ESX.Game.SpawnVehicle(GetHashKey(Config.VehicleModel), coords, coords.h, function(vehicle)
    SetVehicleNumberPlateText(vehicle, "WORK" .. math.random(100,999))
    TaskWarpPedIntoVehicle(PlayerPedId(), vehicle, -1)
    SetVehicleMaxMods(vehicle)
    TriggerEvent('32ae003c-09a8-485d-af5d-371b18a657cf', vehicle)
    ready = true
  end)
end

function SetVehicleMaxMods(vehicle)
	local props = {
		modEngine = 2,
		modBrakes = 2,
		modTransmission = 2,
		modSuspension = 3,
		modTurbo = false
	}

	ESX.Game.SetVehicleProperties(vehicle, props)
end
