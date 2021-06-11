local checkCar = {}
local vehicle, vehicleClass, vehicleCoords,vehicleHeading, trailer, limitL, limitR, limitF, limitB, trailerPos
local playerPed = PlayerPedId()

local lowboyData = {
	rampPos = {vector3(2.0, 4.7, -0.5), vector3(-2.0, 4.7, -0.5)},
	unloadPos ={vector3(2.0, -4.7, -0.5),vector3(-2.0, -4.7, -0.5)},
	outPos = {vector3(2.0, 0.0, -0.5),vector3(-2.0, 0.0, -0.5)},
	signPos = {vector3(2.0, -8.7, -0.5),vector3(-2.0, -8.7, -0.5)},
	tailPos = {vector3(0.0, -9.7, -0.5)},
	width = 3.5,
	length = 10.0,
	loffset = -1.0,
}

local jeepData = {
	linkPos = {vector3(-2.0, -1.7, -0.6),vector3(2.0, -1.7, -0.6)}
}
local stingerData = {
	linkPos = {vector3(-2.0, 0.7, -0.6),vector3(2.0, 0.7, -0.6)}
}
if Config.UseESX then
	ESX = nil

	Citizen.CreateThread(function()
		while ESX == nil do
			TriggerEvent(  'esx:getSharedObject', function(obj) ESX = obj end  )
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
		Citizen.Wait(2000)
		pcall(function()
		checkCar = {}
		playerPed = PlayerPedId()
		if Config.UseESX then
			checkCar = ESX.Game.GetVehiclesInArea(vehicleCoords, 4)
		else
			for car in EnumerateVehicles() do
				local cvehicleCoords =  GetEntityCoords(car)
				if #(vehicleCoords - cvehicleCoords) < 4 then
					table.insert(checkCar, car)
				end
			end
		end
		for i=1, #checkCar, 1 do
			if `lowboy` == GetEntityModel(checkCar[i]) then
				trailer = checkCar[i]
				trailerData = lowboyData
				limitL = GetOffsetFromEntityInWorldCoords(trailer, -1*trailerData.width/2,trailerData.loffset,0.0)
				limitR = GetOffsetFromEntityInWorldCoords(trailer, trailerData.width/2,trailerData.loffset,0.0)
				limitF = GetOffsetFromEntityInWorldCoords(trailer, 0.0,(trailerData.length/2)+trailerData.loffset,0.0)
				limitB = GetOffsetFromEntityInWorldCoords(trailer, 0.0,(-1*trailerData.length/2)+trailerData.loffset,0.0)
			elseif `lowboystinger` == GetEntityModel(checkCar[i]) then
				trailer = checkCar[i]
				trailerData = stingerData
			elseif `lowboyjeep` == GetEntityModel(checkCar[i]) then
				trailer = checkCar[i]
				trailerData = jeepData
			end	
		end
		end)
	end
end)

Citizen.CreateThread(function()
	while true do
		vehicle = GetVehiclePedIsIn(playerPed,false)
		vehicleClass = GetVehicleClass(vehicle)
		vehicleCoords =  GetEntityCoords(playerPed)
		if trailer then
			trailerPos = GetEntityCoords(trailer)
		end
		Citizen.Wait(2000)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		pcall(function()
			if trailer then
				if #(vehicleCoords - trailerPos) < 14 then
					if GetEntityModel(trailer) == `lowboyjeep` then
						if not IsPedInAnyVehicle(PlayerPedId(),false) then
							for i = 1, #trailerData.linkPos, 1 do
								local linkPos = GetOffsetFromEntityInWorldCoords(trailer, trailerData.linkPos[i])
								
								DrawMarker(Config.MarkerType, linkPos, 0.0, 0.0, 0.0, 0.0, 0.0, trailerDir, Config.BikeMarkerSize.x, Config.BikeMarkerSize.y, Config.BikeMarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 80, false, false, 2, nil, nil, false)

								if #(vehicleCoords - linkPos) < 1.5  then
									
									BeginTextCommandDisplayHelp("VEH_E_LINK")
									EndTextCommandDisplayHelp(0, 0, 1, -1)
									if IsDisabledControlJustPressed(0,86) then
										local lowboymain
										for ncar in EnumerateVehicles() do
											local cvehicleCoords =  GetEntityCoords(ncar)
											if #(vehicleCoords - cvehicleCoords) < 8 then
												if GetEntityModel(ncar) == `lowboy` then
													lowboymain = ncar
												end
											end
										end
										
										local attached = IsVehicleAttachedToTrailer(trailer)
										if attached then
											DetachVehicleFromTrailer(trailer)
											SetVehicleFixed(lowboymain)
											SetVehicleDeformationFixed(lowboymain)
											SetVehicleUndriveable(lowboymain, false)
											SetVehicleEngineTorqueMultiplier(lowboymain, 1.0)
											SetVehicleEngineOn(lowboymain, true, true)
											SetVehicleForwardSpeed(lowboymain, 10)
											Citizen.Wait(500)
											SetVehicleForwardSpeed(lowboymain, 0)

										else
											TaskWarpPedIntoVehicle(PlayerPedId(), trailer, -1)
											--Citizen.Wait(500)
											AttachVehicleToTrailer(lowboymain, trailer, 15)
											SetVehicleFixed(trailer)
											SetVehicleDeformationFixed(trailer)
											SetVehicleFixed(lowboymain)
											SetVehicleDeformationFixed(lowboymain)

											SetVehicleUndriveable(trailer, false)
											SetVehicleEngineTorqueMultiplier(trailer, 1.0)
											SetVehicleEngineOn(trailer, true, true)
											
											SetVehicleForwardSpeed(trailer, 10)
											Citizen.Wait(500)
											SetVehicleForwardSpeed(trailer, 0)
											Citizen.Wait(500)
											SetEntityCoords(PlayerPedId(), linkPos, 1,0,0,0)
											
										end
									end
								end
							end
						end
					elseif GetEntityModel(trailer) == `lowboystinger` then
						if not IsPedInAnyVehicle(PlayerPedId(),false) then
							for i = 1, #trailerData.linkPos, 1 do
								local linkPos = GetOffsetFromEntityInWorldCoords(trailer, trailerData.linkPos[i])
								
								DrawMarker(Config.MarkerType, linkPos, 0.0, 0.0, 0.0, 0.0, 0.0, trailerDir, Config.BikeMarkerSize.x, Config.BikeMarkerSize.y, Config.BikeMarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 80, false, false, 2, nil, nil, false)

								if #(vehicleCoords - linkPos) < 1.5  then
									
									BeginTextCommandDisplayHelp("VEH_E_LINK")
									EndTextCommandDisplayHelp(0, 0, 1, -1)
									if IsDisabledControlJustPressed(0,86) then
										local lowboymain
										for ncar in EnumerateVehicles() do
											local cvehicleCoords =  GetEntityCoords(ncar)
											if #(vehicleCoords - cvehicleCoords) < 14 then
												if GetEntityModel(ncar) == `lowboy` then
													lowboymain = ncar
												end
											end
										end
										local attached = IsVehicleAttachedToTrailer(lowboymain)
										if attached then
											DetachVehicleFromTrailer(lowboymain)
											SetVehicleFixed(lowboymain)
											SetVehicleDeformationFixed(lowboymain)
											SetVehicleUndriveable(lowboymain, false)
											SetVehicleEngineTorqueMultiplier(lowboymain, 1.0)
											SetVehicleEngineOn(lowboymain, true, true)
											SetVehicleForwardSpeed(lowboymain, 10)
											Citizen.Wait(500)
											SetVehicleForwardSpeed(lowboymain, 0)

										else
											TaskWarpPedIntoVehicle(PlayerPedId(), lowboymain, -1)
											--Citizen.Wait(500)
											AttachVehicleToTrailer(lowboymain, trailer, 15)
											SetVehicleFixed(trailer)
											SetVehicleDeformationFixed(trailer)
											SetVehicleFixed(lowboymain)
											SetVehicleDeformationFixed(lowboymain)

											SetVehicleUndriveable(trailer, false)
											SetVehicleEngineTorqueMultiplier(trailer, 1.0)
											SetVehicleEngineOn(trailer, true, true)
											
											SetVehicleForwardSpeed(trailer, 10)
											Citizen.Wait(500)
											SetVehicleForwardSpeed(trailer, 0)
											Citizen.Wait(500)
											SetEntityCoords(PlayerPedId(), linkPos, 1,0,0,0)
											Citizen.Wait(2000)
										end
									end
								end
							end
						end
						
					elseif GetEntityModel(trailer) == `lowboy` then
						if not IsPedInAnyVehicle(PlayerPedId(),false) then
							for i = 1, #trailerData.unloadPos, 1 do
								local unloadPos = GetOffsetFromEntityInWorldCoords(trailer, trailerData.unloadPos[i])
								local dist = #(vehicleCoords - unloadPos)
								if Config.ShowMarkers and dist < 4 then
									DrawMarker(Config.MarkerType, unloadPos, 0.0, 0.0, 0.0, 0.0, 0.0, trailerDir, Config.BikeMarkerSize.x, Config.BikeMarkerSize.y, Config.BikeMarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 80, false, false, 2, nil, nil, false)
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

							for i = 1, #trailerData.rampPos, 1 do
								local rampPos = GetOffsetFromEntityInWorldCoords(trailer, trailerData.rampPos[i])
								local dist = #(vehicleCoords - rampPos)
								if Config.ShowMarkers and dist < 4 then
									DrawMarker(Config.MarkerType, rampPos, 0.0, 0.0, 0.0, 0.0, 0.0, trailerDir, Config.BikeMarkerSize.x, Config.BikeMarkerSize.y, Config.BikeMarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 80, false, false, 2, nil, nil, false)
								end
								if dist < 1.5 then
									BeginTextCommandDisplayHelp("VEH_E_NECK")
									EndTextCommandDisplayHelp(0, 0, 1, -1)
									if IsDisabledControlJustPressed(0,86) then
										if IsVehicleExtraTurnedOn(trailer, 2) then
											TriggerServerEvent('ebu_lowboy:updateTrailer', 'extra', 2, trailer, 'closed')
										else
											TriggerServerEvent('ebu_lowboy:updateTrailer', 'extra', 2, trailer, 'open')
										end
									end
								end
							end

							for i = 1, #trailerData.outPos, 1 do
								local outPos = GetOffsetFromEntityInWorldCoords(trailer, trailerData.outPos[i])
								local dist = #(vehicleCoords - outPos)
								if Config.ShowMarkers and dist < 4 then
									DrawMarker(Config.MarkerType, outPos, 0.0, 0.0, 0.0, 0.0, 0.0, trailerDir, Config.BikeMarkerSize.x, Config.BikeMarkerSize.y, Config.BikeMarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 80, false, false, 2, nil, nil, false)
								end
								if dist < 1.5 then
									BeginTextCommandDisplayHelp("VEH_E_RIGGERS")
									EndTextCommandDisplayHelp(0, 0, 1, -1)
									if IsDisabledControlJustPressed(0,86) then
										if IsVehicleExtraTurnedOn(trailer, 4) then
											TriggerServerEvent('ebu_lowboy:updateTrailer', 'extra', 4, trailer, 'closed')
										else
											TriggerServerEvent('ebu_lowboy:updateTrailer', 'extra', 4, trailer, 'open')
										end
									end
								end
							end

							for i = 1, #trailerData.signPos, 1 do
								local signPos = GetOffsetFromEntityInWorldCoords(trailer, trailerData.signPos[i])
								local dist = #(vehicleCoords - signPos)
								if Config.ShowMarkers and dist < 4 then
									DrawMarker(Config.MarkerType, signPos, 0.0, 0.0, 0.0, 0.0, 0.0, trailerDir, Config.BikeMarkerSize.x, Config.BikeMarkerSize.y, Config.BikeMarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 80, false, false, 2, nil, nil, false)
								end
								if dist < 1.5 then
									BeginTextCommandDisplayHelp("VEH_E_SIGN")
									EndTextCommandDisplayHelp(0, 0, 1, -1)
									if IsDisabledControlJustPressed(0,86) then
										if IsVehicleExtraTurnedOn(trailer, 1) then
											TriggerServerEvent('ebu_lowboy:updateTrailer', 'extra', 1, trailer, 'closed')
										else
											TriggerServerEvent('ebu_lowboy:updateTrailer', 'extra', 1, trailer, 'open')
										end
									end
								end
							end

							for i = 1, #trailerData.tailPos, 1 do
								local tailPos = GetOffsetFromEntityInWorldCoords(trailer, trailerData.tailPos[i])
								local dist = #(vehicleCoords - tailPos)
								if Config.ShowMarkers and dist < 4 then
									DrawMarker(Config.MarkerType, tailPos, 0.0, 0.0, 0.0, 0.0, 0.0, trailerDir, Config.BikeMarkerSize.x, Config.BikeMarkerSize.y, Config.BikeMarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 80, false, false, 2, nil, nil, false)
								end
								if dist < 1.5 then
									BeginTextCommandDisplayHelp("VEH_E_TAIL")
									EndTextCommandDisplayHelp(0, 0, 1, -1)
									if IsDisabledControlJustPressed(0,86) then
										if IsVehicleExtraTurnedOn(trailer, 3) then
											TriggerServerEvent('ebu_lowboy:updateTrailer', 'extra', 3, trailer, 'closed')
										else
											TriggerServerEvent('ebu_lowboy:updateTrailer', 'extra', 3, trailer, 'open')
										end
									end
								end
							end
						elseif vehicle and vehicle ~= trailer then
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

									if math.abs(vehOff.x) < (trailerData.width)/2 and math.abs(vehOff.y) + trailerData.loffset < (trailerData.length/2) + trailerData.loffset then
										if IsEntityAttached(vehicle) then
											FreezeEntityPosition(vehicle, true)
											SetEntityCoords(vehicle, vehicleCoords.x, vehicleCoords.y, (vehicleCoords.z + difference + 1.7), 1, 1, 1, 0)
											FreezeEntityPosition(vehicle, false)
											DetachEntity(vehicle, 1, 1)
											Citizen.Wait(1000)
											SetEntityCanBeDamaged(vehicle, true)
										else

											AttachEntityToEntity(
												vehicle,
												trailer,
												GetEntityBoneIndexByName(trailer, "chassis"),
												vector3(vehOff.x, vehOff.y, vehOff.z),
												vector3((vehrot.y + trot.x)/2, 0.0, vehicleHeading - trailerHeading),
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
				Wait(2000)
			end
		end)
	end
end)

RegisterNetEvent(   'ebu_lowboy:updateTrailer')
AddEventHandler(   'ebu_lowboy:updateTrailer', function(type, num, vehicle, status)
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