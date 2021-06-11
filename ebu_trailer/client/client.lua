-----COPYRIGHT/OWNER INFO-----
-- Author: Theebu#9267
-- Copyright- This work is protected by:
-- "http://creativecommons.org/licenses/by-nc-nd/4.0/"
-- Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License
-- You must:    Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made.
--              You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
--              NonCommercial — You may not use the material for commercial purposes. IE you may not sell this

local checkCar = {}
local trailerData = {}
local vehicle, vehicleClass, vehicleCoords,vehicleHeading, trailer, limitL, limitR, limitF, limitB, trailerPos
local playerPed = PlayerPedId()

if Config.UseESX then
	ESX = nil

	Citizen.CreateThread(function()
		while ESX == nil do
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
			Citizen.Wait(0)
		end

	end)
end

local entityEnumerator = {
    __gc = function(enum)
      if enum.destructor and enum.handle then
        enum.destructor(enum.handle)
      end
      enum.destructor = nil
      enum.handle = nil
    end
  }
  
local function EnumerateEntities(initFunc, moveFunc, disposeFunc)
    return coroutine.wrap(function()
        local iter, id = initFunc()
        if not id or id == 0 then
        disposeFunc(iter)
        return
        end
        
        local enum = {handle = iter, destructor = disposeFunc}
        setmetatable(enum, entityEnumerator)
        
        local next = true
        repeat
        coroutine.yield(id)
        next, id = moveFunc(iter)
        until not next
        
        enum.destructor, enum.handle = nil, nil
        disposeFunc(iter)
    end)
end

function EnumerateVehicles()
    return EnumerateEntities(FindFirstVehicle, FindNextVehicle, EndFindVehicle)
end

local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(3000)
		checkCar = {}
		playerPed = PlayerPedId()
		if Config.UseESX then
			checkCar = ESX.Game.GetVehiclesInArea(vehicleCoords, 10)
		else
			for car in EnumerateVehicles() do
				local cvehicleCoords =  GetEntityCoords(car)
				if #(vehicleCoords - cvehicleCoords) < 10 then
					table.insert(checkCar, car)
				end
			end
		end
		for i=1, #checkCar, 1 do
			for j = 1, #Config.Trailers, 1 do
				if Config.Trailers[j].model == GetEntityModel (checkCar[i])  then
					trailerData = Config.Trailers[j]
					trailer = checkCar[i]
					 limitL = GetOffsetFromEntityInWorldCoords(trailer, -1*trailerData.width/2,trailerData.loffset,0.0)
					 limitR = GetOffsetFromEntityInWorldCoords(trailer, trailerData.width/2,trailerData.loffset,0.0)
					 limitF = GetOffsetFromEntityInWorldCoords(trailer, 0.0,(trailerData.length/2)+trailerData.loffset,0.0)
					 limitB = GetOffsetFromEntityInWorldCoords(trailer, 0.0,(-1*trailerData.length/2)+trailerData.loffset,0.0)

				end
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		pcall(function()
		 vehicle = GetVehiclePedIsIn(playerPed,false)
		 vehicleClass = GetVehicleClass(vehicle)
		 vehicleCoords =  GetEntityCoords(playerPed)
		if trailer then
			trailerPos = GetEntityCoords(trailer)
		end
		end)
		Citizen.Wait(3000)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		pcall(function()
			if trailer then
				if #(vehicleCoords - trailerPos) < 8 then
					if not IsPedInAnyVehicle(playerPed, false) then
						for k = 1, #trailerData.unloadPos, 1 do
							local unloadPos = GetOffsetFromEntityInWorldCoords(trailer, trailerData.unloadPos[k])
							local dist = #(vehicleCoords - unloadPos)
							if Config.ShowMarkers and dist < 6 then
								DrawMarker(Config.MarkerType, unloadPos, 0.0, 0.0, 0.0, 0.0, 0.0, 0, Config.BikeMarkerSize.x, Config.BikeMarkerSize.y, Config.BikeMarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 80, false, false, 2, nil, nil, false)
							end
							if dist < 1.5 then
								if Config.UseESX then
									
									ESX.ShowHelpNotification("Press ~INPUT_VEH_HORN~ to release vehicle")
									if IsDisabledControlJustPressed(0,86) then

										local elements = {}
										for attachedVeh in EnumerateVehicles() do
											local cvehicleCoords =  GetEntityCoords(attachedVeh)
											if #(vehicleCoords - cvehicleCoords) < 8 then
												if IsEntityAttached(attachedVeh) and attachedVeh ~= trailer then
													table.insert(elements, {label = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(attachedVeh))), value = attachedVeh})
												end
											end
										end
										ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'attached_vehs', {
											title    = 'Attached Cars',
											align    = 'right',
											elements = elements
										}, function (data, menu)
											TaskWarpPedIntoVehicle(GetPlayerPed(-1), data.current.value, -1)
											menu.close()
										end, function (data, menu)
											menu.close()
										end)
									end
									
								else
									for i=1, #checkCar, 1 do
										local avehicleCoords =  GetEntityCoords(checkCar[i])
										if #(vehicleCoords - avehicleCoords) < 14 then
											if IsEntityAttached(checkCar[i]) and checkCar[i] ~= trailer then
												BeginTextCommandDisplayHelp("VEH_E_DETATCH")
												EndTextCommandDisplayHelp(0, 0, 1, -1)
												if IsDisabledControlJustPressed(0,86) then
													TaskWarpPedIntoVehicle(playerPed, checkCar[i], -1)
												end
											end
										end
									end
								end
							end
						end
						if trailerData.hasRamp then
							for k = 1, #trailerData.rampPos, 1 do
								local rampPos = GetOffsetFromEntityInWorldCoords(trailer, trailerData.rampPos[k])
								local dist = #(vehicleCoords - rampPos)
								if Config.ShowMarkers and dist < 6 then
									DrawMarker(Config.MarkerType, rampPos, 0.0, 0.0, 0.0, 0.0, 0.0, 0, Config.BikeMarkerSize.x, Config.BikeMarkerSize.y, Config.BikeMarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 80, false, false, 2, nil, nil, false)
								end
								if dist < 1.5 then
									BeginTextCommandDisplayHelp("VEH_I_RAMP")
									EndTextCommandDisplayHelp(0, 0, 1, -1)
									
									if IsDisabledControlJustPressed(0,86) then
										local dooropen = 0.0
									
										if trailerData.doorwithRamp then
											for n = 1, #trailerData.doorwithRampNums, 1 do
												dooropen = GetVehicleDoorAngleRatio(trailer, trailerData.doorwithRampNums[n])
											end
										end
										if trailerData.isRampExtra then
											if IsVehicleExtraTurnedOn(trailer, trailerData.rampextraNum) then
												TriggerServerEvent('eb7de843-e560-47ff-bb94-bab5d1ea5b34', 'extra', trailerData.rampextraNum, trailer, 'closed')
											else
												TriggerServerEvent('eb7de843-e560-47ff-bb94-bab5d1ea5b34', 'extra', trailerData.rampextraNum, trailer, 'open')
											end
										else

											local trunkopen = GetVehicleDoorAngleRatio(trailer, trailerData.rampDoorNum)
											if trunkopen > 0.0 or dooropen > 0.0 then
												TriggerServerEvent('eb7de843-e560-47ff-bb94-bab5d1ea5b34', 'door', trailerData.rampDoorNum, trailer, 'closed')

												if trailerData.doorwithRamp then
													for l = 1, #trailerData.doorwithRampNums, 1 do
														TriggerServerEvent('eb7de843-e560-47ff-bb94-bab5d1ea5b34', 'door', trailerData.doorwithRampNums[l], trailer, 'closed')
														TriggerServerEvent('eb7de843-e560-47ff-bb94-bab5d1ea5b34', 'extra', trailerData.rampextraNum, trailer, 'closed')
													end
												end
												dooropen = false

											else
												TriggerServerEvent('eb7de843-e560-47ff-bb94-bab5d1ea5b34', 'door', trailerData.rampDoorNum, trailer, 'open')
												if trailerData.doorwithRamp then
													TriggerServerEvent('eb7de843-e560-47ff-bb94-bab5d1ea5b34', 'extra', trailerData.rampextraNum, trailer, 'open')

													for l = 1, #trailerData.doorwithRampNums, 1 do
														TriggerServerEvent('eb7de843-e560-47ff-bb94-bab5d1ea5b34', 'door', trailerData.doorwithRampNums[l], trailer, 'open')
													end
												end
											end
										end
									end
								end
							end
						end
					elseif vehicle and has_value(Config.bikes, vehicleClass) or has_value(Config.cars, vehicleClass) and not IsVehicleAttachedToTrailer(vehicle) and vehicle ~= trailer then

						if Config.ShowMarkers then

							DrawMarker(0, limitL, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0.1, 0.1, 0.1, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 80, false, false, 2, nil, nil, false)
							DrawMarker(0, limitR, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0.1, 0.1, 0.1, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 80, false, false, 2, nil, nil, false)
							DrawMarker(0, limitF, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0.1, 0.1, 0.1, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 80, false, false, 2, nil, nil, false)
							DrawMarker(0, limitB, 0.0, 0.0, 0.0, 0.0, 0.0, 0, 0.1, 0.1, 0.1, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 80, false, false, 2, nil, nil, false)
						end

						local vehOff = GetOffsetFromEntityGivenWorldCoords(trailer, vehicleCoords)
						if math.abs(vehOff.x) < (trailerData.width)/2 and math.abs(vehOff.y)+trailerData.loffset < (trailerData.length/2)+trailerData.loffset then
							BeginTextCommandDisplayHelp("VEH_I_AORD")
							EndTextCommandDisplayHelp(0, 0, 1, -1)

							if IsDisabledControlJustPressed(0,86) then
								
								local vehrot = GetEntityRotation(vehicle, 5)
								local trot = GetEntityRotation(trailer, 5)
								local trailerHeading = GetEntityHeading(trailer)
								vehicleHeading = GetEntityHeading(vehicle)
								local trailerheight = trailerPos.z
								local carheight = vehicleCoords.z
								local difference = carheight - trailerheight

								if math.abs(vehOff.x) < (trailerData.width)/2 and math.abs(vehOff.y)+trailerData.loffset < (trailerData.length/2)+trailerData.loffset then
									if IsEntityAttached(vehicle) then
										FreezeEntityPosition(vehicle, true)
										SetEntityCoords(vehicle, vehicleCoords.x, vehicleCoords.y, (vehicleCoords.z + difference + 1.7), 1, 1, 1, 0)
										FreezeEntityPosition(vehicle, false)
										DetachEntity(vehicle, 1, 1)
										Citizen.Wait(1000)
										SetEntityCanBeDamaged(vehicle, true)
									else

										if (vehicleHeading > (trailerHeading + 45) or vehicleHeading < (trailerHeading - 45) ) then
											AttachEntityToEntity(
												vehicle,
												trailer,
												GetEntityBoneIndexByName(trailer, "chassis"),
												vector3(vehOff.x, vehOff.y, vehOff.z),
												vector3((vehrot.y + trot.x)/2, 0.0, vehicleHeading - trailerHeading),
												1, 0, 1, 0, 0, 1
											)
											SetEntityCanBeDamaged(vehicle, false)
										else
											AttachEntityToEntity(
												vehicle,
												trailer,
												GetEntityBoneIndexByName(trailer, "chassis"),
												vector3(vehOff.x, vehOff.y, vehOff.z),
												vector3((vehrot.y + trot.x)/2,0.0, vehicleHeading - trailerHeading),
												1, 0, 1, 0, 0, 1
											)
											SetEntityCanBeDamaged(vehicle, false)
										end
										
									end
								end

							end
						end
					end
				end
			else
				Wait(3000)
			end
		end)
	end
end)

RegisterNetEvent('f4afa337-a1e7-43f8-9633-42bd974bf908')
AddEventHandler('f4afa337-a1e7-43f8-9633-42bd974bf908', function(type, num, vehicle, status)
	if type == 'extra' then
		if status == 'open' then
			SetVehicleExtra(vehicle, num, false)
		elseif status == 'closed' then
			SetVehicleExtra(vehicle, num, true)
		end
		SetVehicleFixed(vehicle)
		SetVehicleDeformationFixed(vehicle)
	elseif type == 'door' then
		if status == 'open' then
			SetVehicleDoorOpen(vehicle, num, false, false)
		elseif status == 'closed' then
			SetVehicleDoorShut(vehicle, num, false)
		end
	end
end)