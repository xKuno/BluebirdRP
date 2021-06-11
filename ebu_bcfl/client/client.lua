local unloadR, unloadL
local checkCar = {}
local vehicle, vehicleClass, vehicleCoords,vehicleHeading, trailer, limitL, limitR, limitF, limitB, trailerPos
local playerPed = PlayerPedId()

local trailerData = {
	isMulti = true,
	hasRamp = true,
	rampPos = {vector3(-2.0, -8.0, 0.0), vector3(2.0, -8.0, 0.0)},
	unloadPos ={vector3(0.0, -1.0, 0.2)},
	elevatorPos = {vector3(0.0, -5.5, 0.8),vector3(0.0, -5.5, 2.5)},
	deploy = {vector3(2.0, 7.0, 0.0)},
	door = {vector3(2.0, 4.0, 0.0)},
	rampDoorNum = 5,
	multiRampDoorNum = 4,
	UppercarPositions = {vector3( 0.0, -5.2,  0.9)},
	width = 2.7,
	length = 12.0,
	loffset = -2.0,
}
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
		Citizen.Wait(5000)
		checkCar = {}
		playerPed = PlayerPedId()
		if Config.UseESX then
			checkCar = ESX.Game.GetVehiclesInArea(vehicleCoords, 14)
		else
			for car in EnumerateVehicles() do
				local cvehicleCoords =  GetEntityCoords(car)
				if #(vehicleCoords - cvehicleCoords) < 14 then
					table.insert(checkCar, car)
				end
			end
		end
		for i=1, #checkCar, 1 do
			
			if `bcfl` == GetEntityModel(checkCar[i])  then
				trailer = checkCar[i]
				limitL = GetOffsetFromEntityInWorldCoords(trailer, -1*trailerData.width/2,trailerData.loffset,0.0)
				limitR = GetOffsetFromEntityInWorldCoords(trailer, trailerData.width/2,trailerData.loffset,0.0)
				limitF = GetOffsetFromEntityInWorldCoords(trailer, 0.0,(trailerData.length/2)+trailerData.loffset,0.0)
				limitB = GetOffsetFromEntityInWorldCoords(trailer, 0.0,(-1*trailerData.length/2)+trailerData.loffset,0.0)

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
		Citizen.Wait(5000)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		pcall(function()
			if trailer then
				if #(vehicleCoords - trailerPos) < 14 then
					if not IsPedInAnyVehicle(PlayerPedId(),false) then
						for k = 1, #trailerData.unloadPos, 1 do
							local unloadPos = GetOffsetFromEntityInWorldCoords(trailer, trailerData.unloadPos[k])
							local dist = #(vehicleCoords - unloadPos)
							if Config.ShowMarkers and dist < 4 then
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

						for k = 1, #trailerData.rampPos, 1 do
							local rampPos = GetOffsetFromEntityInWorldCoords(trailer, trailerData.rampPos[k])
							local dist = #(vehicleCoords - rampPos)
							if Config.ShowMarkers and dist < 4 then
								DrawMarker(Config.MarkerType, rampPos, 0.0, 0.0, 0.0, 0.0, 0.0, 0, Config.BikeMarkerSize.x, Config.BikeMarkerSize.y, Config.BikeMarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 80, false, false, 2, nil, nil, false)
							end
							if dist < 1.5 then
								BeginTextCommandDisplayHelp("VEH_E_ELE")
								EndTextCommandDisplayHelp(0, 0, 1, -1)
								if IsDisabledControlJustPressed(0,86) then

									local trunkopen = GetVehicleDoorAngleRatio(trailer, trailerData.rampDoorNum)
									if trunkopen > 0.0 then
										TriggerServerEvent('d004e428-d8b6-4bcd-86d5-1fb10e25c074', 'door', trailerData.rampDoorNum, trailer, 'closed')
										dooropen = false

									else
										TriggerServerEvent('d004e428-d8b6-4bcd-86d5-1fb10e25c074', 'door', trailerData.rampDoorNum, trailer, 'open')
									end
									
								end
								if IsDisabledControlJustPressed(0,47) then
									local trunkopen = GetVehicleDoorAngleRatio(trailer, trailerData.multiRampDoorNum)
									if trunkopen > 0.0 then
										TriggerServerEvent('d004e428-d8b6-4bcd-86d5-1fb10e25c074', 'door', trailerData.multiRampDoorNum, trailer, 'closed')

										dooropen = false

									else
										TriggerServerEvent('d004e428-d8b6-4bcd-86d5-1fb10e25c074', 'door', trailerData.multiRampDoorNum, trailer, 'open')
									end
									
								end
							end
							
						end
						
						for k = 1, #trailerData.deploy, 1 do
							local deployPos = GetOffsetFromEntityInWorldCoords(trailer, trailerData.deploy[k])
							local dist = #(vehicleCoords - deployPos)
							if Config.ShowMarkers and dist < 4 then
								DrawMarker(Config.MarkerType, deployPos, 0.0, 0.0, 0.0, 0.0, 0.0, 0, Config.BikeMarkerSize.x, Config.BikeMarkerSize.y, Config.BikeMarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 80, false, false, 2, nil, nil, false)
							end
							if dist < 1.5 then
								BeginTextCommandDisplayHelp("VEH_E_PACK")
								EndTextCommandDisplayHelp(0, 0, 1, -1)
								local extras = {1,2,3,4,5,6,7,8,9,11}
								if IsDisabledControlJustPressed(0,86) then
									for i =1, #extras, 1 do
										TriggerServerEvent('d004e428-d8b6-4bcd-86d5-1fb10e25c074', 'extra', extras[i], trailer, 'open')
									end						
								elseif IsDisabledControlJustPressed(0,47) then
									for i =1, #extras, 1 do
										TriggerServerEvent('d004e428-d8b6-4bcd-86d5-1fb10e25c074', 'extra', extras[i], trailer, 'closed')
									end
								end
							end
						end

						for k = 1, #trailerData.door, 1 do
							local doorPos = GetOffsetFromEntityInWorldCoords(trailer, trailerData.door[k])
							local dist = #(vehicleCoords - doorPos)
							if Config.ShowMarkers and dist < 4 then
								DrawMarker(Config.MarkerType, doorPos, 0.0, 0.0, 0.0, 0.0, 0.0, 0, Config.BikeMarkerSize.x, Config.BikeMarkerSize.y, Config.BikeMarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 80, false, false, 2, nil, nil, false)
							end
							if dist < 1.5 then
								BeginTextCommandDisplayHelp("VEH_E_DOOR")
								EndTextCommandDisplayHelp(0, 0, 1, -1)
								if IsDisabledControlJustPressed(0,86) then
									local trunkopen = GetVehicleDoorAngleRatio(trailer, 2)
									if trunkopen > 0.0 then
										TriggerServerEvent('d004e428-d8b6-4bcd-86d5-1fb10e25c074', 'door', 2, trailer, 'closed')
										dooropen = false
									else
										TriggerServerEvent('d004e428-d8b6-4bcd-86d5-1fb10e25c074', 'door', 2, trailer, 'open')
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
						if IsDisabledControlJustPressed(0,47) then
							local trunkopen = GetVehicleDoorAngleRatio(trailer, trailerData.multiRampDoorNum)
							if trunkopen > 0.0 then
								TriggerServerEvent('d004e428-d8b6-4bcd-86d5-1fb10e25c074', 'door', trailerData.multiRampDoorNum, trailer, 'closed')
								dooropen = false
							else
								TriggerServerEvent('d004e428-d8b6-4bcd-86d5-1fb10e25c074', 'door', trailerData.multiRampDoorNum, trailer, 'open')
							end
						end
						local vehOff = GetOffsetFromEntityGivenWorldCoords(trailer, vehicleCoords)

						if math.abs(vehOff.x) < (trailerData.width)/2 and math.abs(vehOff.y)+trailerData.loffset < (trailerData.length/2)+trailerData.loffset then
							BeginTextCommandDisplayHelp("VEH_I_AORDBC")
							EndTextCommandDisplayHelp(0, 0, 1, -1)

							if IsDisabledControlJustPressed(0,86) then
								if not IsVehicleAttachedToTrailer(vehicle) and vehicle ~= trailer then
									local trailerHeading = GetEntityHeading(trailer)
									local trailerheight = trailerPos.z
									local carheight = vehicleCoords.z
									local difference = carheight - trailerheight
									local vehicleHeading = GetEntityHeading(vehicle)
									local vehrot = GetEntityRotation(vehicle, 5)

									if math.abs(vehOff.x) < (trailerData.width)/2 and math.abs(vehOff.y)+trailerData.loffset < (trailerData.length/2)+trailerData.loffset then
										if IsEntityAttached(vehicle) then
											FreezeEntityPosition(vehicle, true)
											SetEntityCoords(vehicle, vehicleCoords.x, vehicleCoords.y, (vehicleCoords.z + difference + 1.7), 1, 1, 1, 0)
											FreezeEntityPosition(vehicle, false)
											DetachEntity(vehicle, 1, 1)
											Citizen.Wait(1000)
											SetEntityCanBeDamaged(vehicle, true)
										else
											if vehOff.z < 2.0 then
												local trunkopen = GetVehicleDoorAngleRatio(trailer, trailerData.multiRampDoorNum)
												if trunkopen > 0.1 then
													
													AttachEntityToEntity(
													vehicle,
													trailer,
													GetEntityBoneIndexByName(trailer, "chassis"),
													vector3(vehOff.x, vehOff.y, vehOff.z),
													vector3(vehrot.y,0.0, vehicleHeading - trailerHeading),
													1, 0, 1, 0, 0, 1
													)
													SetEntityCanBeDamaged(vehicle, false)

												else
													AttachEntityToEntity(
													vehicle,
													trailer,
													GetEntityBoneIndexByName(trailer, "bonnet"),
													vector3(trailerData.UppercarPositions[1].x, trailerData.UppercarPositions[1].z - difference, 0),
													vector3(90.0, 0.0, 0.0),
													1, 0, 1, 0, 0, 1
													)

												end
											else
												AttachEntityToEntity(
													vehicle,
													trailer,
													GetEntityBoneIndexByName(trailer, "chassis"),
													vector3(vehOff.x, vehOff.y, vehOff.z),
													vector3(vehrot.y,0.0, vehicleHeading - trailerHeading),
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
				end
			else
				Wait(5000)
			end
		end)
	end
end)

RegisterNetEvent('7ca7eb54-850a-40cd-b01b-a6dd92c1aea9')
AddEventHandler('7ca7eb54-850a-40cd-b01b-a6dd92c1aea9', function(type, num, vehicle, status)
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