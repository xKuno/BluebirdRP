local ESX 			= nil
local busy 			= false
local hasExited 		= false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
	end
end)

RegisterCommand('lu', function(src, args)
	local ped = GetPlayerPed(-1)
	local pedExist = DoesEntityExist(ped)
	local pedinVeh = IsPedInAnyVehicle(ped, false)

	getVehicle(nil, nil)

	if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId(ped))) then
		local vehicle = GetVehiclePedIsTryingToEnter(PlayerPedId(ped))
		local pedd = GetPedInVehicleSeat(vehicle, -1)
		local lastvehicle = GetPlayersLastVehicle()
		if pedd > 0 and Config.lChance <= math.random(100) and vehicle ~= lastvehicle and IsPedAPlayer(pedd) == false and pedd ~= ped then
		
			NetworkRequestControlOfEntity(vehicle)
			local ttajmer = 0
			while not NetworkHasControlOfEntity(vehicle) and ttajmer < 70 do
				Citizen.Wait(1)
				ttajmer = ttajmer + 1
			end
			SetVehicleDoorsLocked(vehicle,2)
			Wait(2500)
		else
			local doorAngle = GetVehicleDoorAngleRatio(vehicle, 0)
			TriggerServerEvent('ea9e1ea5-4fce-4675-beb3-ec0c892d1b51', GetVehicleNumberPlateText(vehicle), doorAngle, GetEntityModel(vehicle), GetVehicleDoorLockStatus(vehicle), GetVehicleClass(vehicle), 'outside')
			Wait(2500)
		end
	end

	if pedExist and not pedinVeh then
		if not hasExited then
			hasExited = true
			local lastvehicle = GetPlayersLastVehicle()
			if lastvehicle then
				local doorAngle = GetVehicleDoorAngleRatio(lastvehicle, 0)
				TriggerServerEvent('ea9e1ea5-4fce-4675-beb3-ec0c892d1b51', GetVehicleNumberPlateText(lastvehicle), doorAngle, GetEntityModel(lastvehicle), GetVehicleDoorLockStatus(lastvehicle), GetVehicleClass(lastvehicle), 'exiting')
				lastvehicle = nil
			end
		end
	elseif pedExist and pedinVeh then
		if hasExited then
			hasExited = false
		end
	end


end)
TriggerEvent('2896af73-6240-4f26-92b0-417518db3f5a', '/lu', 'Lock/Unlock Closest Vehicle', {})

RegisterCommand('lo', function(src, args)
	local ped = GetPlayerPed(-1)
	local pedExist = DoesEntityExist(ped)
	local pedinVeh = IsPedInAnyVehicle(ped, false)

	getVehicle(nil, nil,true)

	if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId(ped))) then
		local vehicle = GetVehiclePedIsTryingToEnter(PlayerPedId(ped))
		local pedd = GetPedInVehicleSeat(vehicle, -1)
		local lastvehicle = GetPlayersLastVehicle()
		if pedd > 0 and Config.lChance <= math.random(100) and vehicle ~= lastvehicle and IsPedAPlayer(pedd) == false and pedd ~= ped then
		
			NetworkRequestControlOfEntity(vehicle)
			local ttajmer = 0
			while not NetworkHasControlOfEntity(vehicle) and ttajmer < 70 do
				Citizen.Wait(1)
				ttajmer = ttajmer + 1
			end
			SetVehicleDoorsLocked(vehicle,2)
			Wait(2500)
		else
			local doorAngle = GetVehicleDoorAngleRatio(vehicle, 0)
			TriggerServerEvent('ea9e1ea5-4fce-4675-beb3-ec0c892d1b51', GetVehicleNumberPlateText(vehicle), doorAngle, GetEntityModel(vehicle), GetVehicleDoorLockStatus(vehicle), GetVehicleClass(vehicle), 'forcelock')
			Wait(2500)
		end
	end

	if pedExist and not pedinVeh then
		if not hasExited then
			hasExited = true
			local lastvehicle = GetPlayersLastVehicle()
			if lastvehicle then
				local doorAngle = GetVehicleDoorAngleRatio(lastvehicle, 0)
				TriggerServerEvent('ea9e1ea5-4fce-4675-beb3-ec0c892d1b51', GetVehicleNumberPlateText(lastvehicle), doorAngle, GetEntityModel(lastvehicle), GetVehicleDoorLockStatus(lastvehicle), GetVehicleClass(lastvehicle), 'forcelock')
				lastvehicle = nil
			end
		end
	elseif pedExist and pedinVeh then
		if hasExited then
			hasExited = false
		end
	end


end)
TriggerEvent('2896af73-6240-4f26-92b0-417518db3f5a', '/lo', 'Lock Closest Vehicle', {})


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

	    local ped = GetPlayerPed(-1)
	    local pedExist = DoesEntityExist(ped)
	    local pedinVeh = IsPedInAnyVehicle(ped, false)

		if IsControlJustReleased(0, Config.lockKey) and IsInputDisabled(0) then
			if busy == false then
				busy = true
				getVehicle(nil, nil)
			end
		end
		

        if DoesEntityExist(GetVehiclePedIsTryingToEnter(PlayerPedId(ped))) then
        	local vehicle = GetVehiclePedIsTryingToEnter(PlayerPedId(ped))
			local pedd = GetPedInVehicleSeat(vehicle, -1)
			local lastvehicle = GetPlayersLastVehicle()
			if pedd > 0 and Config.lChance <= math.random(100) and vehicle ~= lastvehicle and IsPedAPlayer(pedd) == false and pedd ~= ped then
			
				NetworkRequestControlOfEntity(vehicle)
				local ttajmer = 0
				while not NetworkHasControlOfEntity(vehicle) and ttajmer < 70 do
					Citizen.Wait(1)
					ttajmer = ttajmer + 1
				end
				SetVehicleDoorsLocked(vehicle,2)
				Wait(2500)
			else
				local doorAngle = GetVehicleDoorAngleRatio(vehicle, 0)
				TriggerServerEvent('ea9e1ea5-4fce-4675-beb3-ec0c892d1b51', GetVehicleNumberPlateText(vehicle), doorAngle, GetEntityModel(vehicle), GetVehicleDoorLockStatus(vehicle), GetVehicleClass(vehicle), 'outside')
				Wait(2500)
			end
        end

        if pedExist and not pedinVeh then
        	if not hasExited then
        		hasExited = true
	        	local lastvehicle = GetPlayersLastVehicle()
	        	if lastvehicle then
        			local doorAngle = GetVehicleDoorAngleRatio(lastvehicle, 0)
	        		TriggerServerEvent('ea9e1ea5-4fce-4675-beb3-ec0c892d1b51', GetVehicleNumberPlateText(lastvehicle), doorAngle, GetEntityModel(lastvehicle), GetVehicleDoorLockStatus(lastvehicle), GetVehicleClass(lastvehicle), 'exiting')
	        		lastvehicle = nil
	        	end
	        end
	    elseif pedExist and pedinVeh then
	    	if hasExited then
	    		hasExited = false
	    	end
        end

	end
end)

getVehicle = function(ismenu, lockstatus,force)
	local player = PlayerPedId()
	local coords = GetEntityCoords(player)
	local lockStatus
	local vehicle = nil

	if IsPedInAnyVehicle(player, false) then
		vehicle = GetVehiclePedIsIn(player, false)
		if vehicle then
			if isaVehicle(vehicle) then 
				if GetPedInVehicleSeat(vehicle, -1) == player or GetPedInVehicleSeat(vehicle, 0) == player then
					local doorAngle = GetVehicleDoorAngleRatio(vehicle, 0)
					if ismenu then
						lockStatus = lockstatus
					else
						lockStatus =  GetVehicleDoorLockStatus(vehicle)
					end
					TriggerServerEvent('ea9e1ea5-4fce-4675-beb3-ec0c892d1b51', GetVehicleNumberPlateText(vehicle), doorAngle, GetEntityModel(vehicle), lockStatus, GetVehicleClass(vehicle), 'inside', ismenu)
				end
			end
		end
		busy = false
		return
	else
		local entityWorld = GetOffsetFromEntityInWorldCoords(player, 0.0, Config.rDist, 0.0)
		local rayHandle = CastRayPointToPoint(coords["x"], coords["y"], coords["z"], entityWorld.x, entityWorld.y, entityWorld.z, 10, ply, 0)
		local a, b, c, d, targetVehicle = GetRaycastResult(rayHandle)

		if (targetVehicle ~= nil and targetVehicle ~= 0) then
			vehicle = targetVehicle
		else
			vehicle = ESX.Game.GetClosestVehicle(coords)
		end

		if not vehicle then
			busy = false
			return
		elseif not GetVehicleNumberPlateText(vehicle) then
			busy = false
			return
		else
			if isaVehicle(vehicle) then
				local doorAngle = GetVehicleDoorAngleRatio(vehicle, 0)
				if ismenu then
					lockStatus = lockstatus
				else
					lockStatus =  GetVehicleDoorLockStatus(vehicle)
				end					
				if force then
					TriggerServerEvent('ea9e1ea5-4fce-4675-beb3-ec0c892d1b51', GetVehicleNumberPlateText(vehicle), doorAngle, GetEntityModel(vehicle), lockStatus, GetVehicleClass(vehicle), 'forcelock', ismenu)
				else
					TriggerServerEvent('ea9e1ea5-4fce-4675-beb3-ec0c892d1b51', GetVehicleNumberPlateText(vehicle), doorAngle, GetEntityModel(vehicle), lockStatus, GetVehicleClass(vehicle), 'remote', ismenu)
				end
				
			end
		end		
	end
end

isaVehicle = function(vehicle)
	if not DoesEntityExist(vehicle) and not IsEntityAVehicle(vehicle) then
		return false
	end
		return true
end

hornandLights = function(vehicle, times, timer, duration)
	local vehicleHorn = GetVehicleMod(vehicle, 14)
	local count = 0
	local lights = 2

	--SetVehicleMod(vehicle, 14, -1, false)

	Citizen.CreateThread(function()
		while count < times do
			StartVehicleHorn(vehicle, duration, "HELDDOWN", false)
			SetVehicleLights(vehicle, lights)
			if lights == 2 then lights = 0; elseif lights == 0 then lights = 2; end
			count = count + 1
			Wait(timer)
		end
	Wait(20)
	SetVehicleLights(vehicle, 0)
	--SetVehicleMod(vehicle,14, vehicleHorn, false)
	end)
end

RegisterNetEvent('2307389f-da96-4091-be80-b6fc6b6b444f')
AddEventHandler('2307389f-da96-4091-be80-b6fc6b6b444f', function(plate, lockstatus, call, owner)
	
	if call == 'notauth' then
		busy = false
		return
	end
	if ESX == nil then
	
	end
	
	local player = PlayerPedId()
	local coords = GetEntityCoords(player)	
	local vehicles = ESX.Game.GetVehiclesInArea(coords, Config.rDist * 2)
	local message = nil

	if lockstatus == false then	lockstatus = 1; elseif lockstatus == true then lockstatus = 2; end

 	if owner and call ~= 'outside' and call ~= 'exiting' and call ~= 'inside' then

	 	local dict = "anim@mp_player_intmenu@key_fob@"

		RequestAnimDict(dict)

		while not HasAnimDictLoaded(dict) do
			Citizen.Wait(0)
		end	

		--vehicleKeys = CreateObject(`prop_cuff_keys_01`, 0, 0, 0, true, true, true) -- creates object
	 	--AttachEntityToEntity(vehicleKeys, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.11, 0.03, -0.03, 90.0, 0.0, 0.0, true, true, false, true, 1, true) -- object is attached to right hand
		TaskPlayAnim(PlayerPedId(), dict, "fob_click_fp", 8.0, 8.0, -1, 48, 1, false, false, false)

		Wait(500)
	end

	for i=1, #vehicles do
		if GetVehicleNumberPlateText(vehicles[i]) == plate then
			if call ~= 'outside' and call ~= 'exiting' then
				if lockstatus == 1 then
					PlayVehicleDoorOpenSound(vehicles[i], 1)
					if call ~= 'inside' then
						hornandLights(vehicles[i], 3, 200, 10)
						SetVehicleAlarm(vehicles[i], false)
					end
						message = _U('unlocked')
				elseif lockstatus == 2 or lockstatus == 4 then
					PlayVehicleDoorCloseSound(vehicles[i], 0)
					if call ~= 'inside' then
						hornandLights(vehicles[i], 2, 200, 10)
						SetVehicleAlarm(vehicles[i], true)
					end
					if lockstatus == 2 then
						message = _U('locked')
					elseif lockstatus == 4 then
						message = _U('doublelock')
					end
				end

				if owner and Config.notifca then
					Notify("Vehicle Security", 0.35,message)
					--TriggerEvent('31f60a72-5898-496f-9a65-9011faac567b', { args = { _U('title'), message } })
				end

			end
			NetworkRequestControlOfEntity(vehicles[i])
			local ttajmer = 0
			while not NetworkHasControlOfEntity(vehicles[i]) and ttajmer < 70 do
				Citizen.Wait(1)
				ttajmer = ttajmer + 1
			end
			SetVehicleDoorsLocked(vehicles[i], lockstatus)
		end
	end
	--[[
	if DoesEntityExist(vehicleKeys) then
			Wait(800)

			DeleteEntity(vehicleKeys)
			Citizen.CreateThread(function()
				DeleteEntity(vehicleKeys)
			end)
			
	end--]]

	busy = false
end)

RegisterNetEvent('db2f1694-cbc5-476b-9355-0a172dd38f75')
AddEventHandler('db2f1694-cbc5-476b-9355-0a172dd38f75', function(lockStatus)
	local lowerLockStatus = string.lower(tostring(lockStatus))
	
	if lowerLockStatus == 'lock' or lockStatus == 2 then
		lockStatus = true
	elseif lowerLockStatus == 'unlock' or lockStatus == 1 then
		lockStatus = false
	elseif lowerLockStatus == 'doublelock' then
		lockStatus = 4
	end

	if busy == false then
		busy = true
		getVehicle(true, lockStatus)
	end
end)

RegisterNetEvent('53f6fe21-a234-492e-94fe-c742e0b2dc63')
AddEventHandler('53f6fe21-a234-492e-94fe-c742e0b2dc63', function(title,duration,text)
	Notify(title, duration, text)
end)



function Notify(title, duration, text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	Citizen.InvokeNative(0x1E6611149DB3DB6B, "CHAR_LIFEINVADER", "CHAR_LIFEINVADER", true, 1, title,text, duration)
	DrawNotification_4(false, true)
end


RegisterCommand("lockwipe", function(source, args)

	local vehicleplate = string.lower(GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1))))
	TriggerServerEvent('80f28df0-e913-47fa-ba35-4c5b39680bc5',vehicleplate)
	--vehicles[string.lower(vehicleplate)] = nil
	--table.removeKey(vehicles, string.lower(vehicleplate))

end)