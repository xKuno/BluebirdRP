local ESX = nil

local unlockneardoor = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) 
			ESX = obj 
		end)

		Citizen.Wait(0)
	end

	if ESX.IsPlayerLoaded() then
		ESX.PlayerData = ESX.GetPlayerData()

		ESX.TriggerServerCallback('e3f6df82-33eb-470a-aa9e-a2968bb91a87', function(doorInfo, count)
			for localID = 1, count do
				if doorInfo[localID] ~= nil then
					Config.DoorList[doorInfo[localID].doorID].locked = doorInfo[localID].state
				end
			end
		end)
	end

	for i = 1, #Config.DoorList do
		local doorID = Config.DoorList[i]

		local closeDoor = GetClosestObjectOfType(doorID.objCoords.x, doorID.objCoords.y, doorID.objCoords.z, 1.0, doorID.objName, false, false, false)

		if DoesEntityExist(closeDoor) then
			Config.DoorList[i]["startRotation"] = GetEntityRotation(closeDoor)
		end
	end
end)

RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(playerData)
	ESX.PlayerData = playerData

	ESX.TriggerServerCallback('e3f6df82-33eb-470a-aa9e-a2968bb91a87', function(doorInfo, count)
		for localID = 1, count do
			if doorInfo[localID] ~= nil then
				Config.DoorList[doorInfo[localID].doorID].locked = doorInfo[localID].state
			end
		end
	end)
end)

RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function(job)
	ESX.PlayerData.job = job
end)

local closeDoorListP = {}
Citizen.CreateThread(function()
	while true do
		
		local playerCoords = GetEntityCoords(PlayerPedId())
		local cdoors = {}
		for i=1, #Config.DoorList do
			local doorID  = Config.DoorList[i]
			local dist = vector3(doorID.objCoords.x, doorID.objCoords.y, doorID.objCoords.z)
			local distance = #(playerCoords - dist)
			if distance < 60 then
				Config.DoorList[i].objCoords = dist
				Config.DoorList[i].id = i
				table.insert(cdoors, Config.DoorList[i])
			end
			Wait(0)
		end
		closeDoorListP = cdoors
		Citizen.Wait(1500)
	end
	
end)

Citizen.CreateThread(function()
	Citizen.Wait(70)

	while true do
		local sleepThread = 100

		local playerCoords = GetEntityCoords(PlayerPedId())
		
		closeDoorList = closeDoorListP
		
		for i=1, #closeDoorList do
			local doorID   = closeDoorList[i]
			local GdoorID   = closeDoorList[i].id
			local distance = #(playerCoords - doorID.objCoords)

			local maxDistance = 1.5
			if doorID.distance then
				maxDistance = doorID.distance
			end

			if distance < maxDistance then
				sleepThread = 5

				ApplyDoorState(doorID)

				local size = 0.5
				if doorID.size then
					size = doorID.size
				end

				local displayText = _U('unlocked')

				if doorID.locked then
					displayText = _U('locked')
					
				end
				ESX.Game.Utils.DrawText3D(doorID.textCoords, displayText, size)
					
					if IsControlJustReleased(0, 38) or unlockneardoor == true then
						local isAuthorized = IsAuthorized(doorID)
						
						if isAuthorized or unlockneardoor == true then
							doorID.locked = not doorID.locked
							
							unlockneardoor = false

							TriggerServerEvent('221c1b4a-2f68-4660-95e9-ae529ef88090', GdoorID, doorID.locked) -- Broadcast new state of the door to everyone
							
							if doorID.autolock then
								
								local length = doorID.autolock
								
								Citizen.CreateThread(function()
									local doorc = doorID.id
									
									Citizen.Wait(length)
									print('commence locking')
									pcall(function()
									for i=1, #closeDoorListP do
										if closeDoorListP[i] ~= nil and closeDoorListP[i].id == doorc then
											if closeDoorListP[i] ~= nil and closeDoorListP[i].locked == false then
												TriggerServerEvent('221c1b4a-2f68-4660-95e9-ae529ef88090', doorc, true)
											end
											break
										end
									end
									end)
								end)
								
							end
						end
					end
				end
			
		end

		Citizen.Wait(sleepThread)
	end
end)

function ApplyDoorState(doorID)
	if tonumber(doorID.objName) == nil then
		doorID.objName = GetHashKey(doorID.objName)
	end

	local closeDoor = GetClosestObjectOfType(doorID.objCoords.x, doorID.objCoords.y, doorID.objCoords.z, 1.0, doorID.objName, false, false, false)
	if doorID.nr then
	else
		if doorID["startRotation"] == nil then
			doorID["startRotation"] = GetEntityRotation(closeDoor)
		end
		if doorID.fixedpos then
			doorID["startRotation"] = doorID.fixedpos
		end
		if doorID.force and doorID.locked == true then
			SetEntityCoords(closeDoor,doorID.objCoords.x, doorID.objCoords.y, doorID.objCoords.z)
		end
		if doorID["locked"] and GetEntityRotation(closeDoor) ~= doorID["startRotation"] then
			SetEntityRotation(closeDoor, doorID["startRotation"]) 
		end
	end

	FreezeEntityPosition(closeDoor, doorID.locked)
end

function IsAuthorized(doorID)
	local Inventory = ESX.GetPlayerData()["inventory"]

	for i = 1, #doorID.authorizedJobs, 1 do
		for invId = 1, #Inventory do
			if Inventory[invId]["count"] > 0 then
				if doorID.authorizedJobs[i] == Inventory[invId]["name"] then
					return true
				end
			end
		end
	end

	return false
end

RegisterNetEvent('48c98d37-c0eb-4468-9777-9f6727a6dd11')
AddEventHandler('48c98d37-c0eb-4468-9777-9f6727a6dd11', function(doorID, state)
	Config.DoorList[doorID].locked = state
	for i=1, #closeDoorListP do
		if closeDoorListP.id == doorID then
			closeDoorListP[i].locked = state
		end
	end
end)




RegisterNetEvent(  'esx_doorlock:opennear')
AddEventHandler(  'esx_doorlock:opennear', function()
	unlockneardoor = true
	Citizen.CreateThread(function()
		Wait(20000)
		unlockneardoor = false
	end)
end)