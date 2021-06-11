
------
-- InteractionSound by Scott
-- Version: v0.0.1
-- Path: client/main.lua
--
-- Allows sounds to be played on single clients, all clients, or all clients within
-- a specific range from the entity to which the sound has been created.
------

local standardVolumeOutput = 1.0;

local playsound = false


Citizen.CreateThread(function ()
		Wait(60000)
		playsound = true
end)
------
-- RegisterNetEvent InteractSound_CL:PlayOnOne
--
-- @param soundFile    - The name of the soundfile within the client/html/sounds/ folder.
--                     - Can also specify a folder/sound file.
-- @param soundVolume  - The volume at which the soundFile should be played. Nil or don't
--                     - provide it for the default of standardVolumeOutput. Should be between
--                     - 0.1 to 1.0.
--
-- Starts playing a sound locally on a single client.
------
RegisterNetEvent('46d904a0-a5f1-450f-be84-c48b52e3f957')
AddEventHandler('46d904a0-a5f1-450f-be84-c48b52e3f957', function(soundFile, soundVolume)
	print('sound being played: ' .. soundFile)
    SendNUIMessage({
        transactionType     = 'playSound',
        transactionFile     = soundFile,
        transactionVolume   = soundVolume
    })
end)


function PlaySound(soundFile, soundVolume)
    SendNUIMessage({
        transactionType     = 'playSound',
        transactionFile     = soundFile,
        transactionVolume   = soundVolume
    })
end

------
-- RegisterNetEvent LIFE_CL:Sound:PlayOnAll
--
-- @param soundFile    - The name of the soundfile within the client/html/sounds/ folder.
--                     - Can also specify a folder/sound file.
-- @param soundVolume  - The volume at which the soundFile should be played. Nil or don't
--                     - provide it for the default of standardVolumeOutput. Should be between
--                     - 0.1 to 1.0.
--
-- Starts playing a sound on all clients who are online in the server.
------
RegisterNetEvent('6baaf576-3216-4493-bccd-b83455c68de5')
AddEventHandler('6baaf576-3216-4493-bccd-b83455c68de5', function(soundFile, soundVolume)
	print('play on all')
	if playsound == true then
		SendNUIMessage({
			transactionType     = 'playSound',
			transactionFile     = soundFile,
			transactionVolume   = soundVolume
		})
	end
end)

------
-- RegisterNetEvent LIFE_CL:Sound:PlayWithinDistance
--
-- @param playOnEntity    - The entity network id (will be converted from net id to entity on client)
--                        - of the entity for which the max distance is to be drawn from.
-- @param maxDistance     - The maximum float distance (client uses Vdist) to allow the player to
--                        - hear the soundFile being played.
-- @param soundFile       - The name of the soundfile within the client/html/sounds/ folder.
--                        - Can also specify a folder/sound file.
-- @param soundVolume     - The volume at which the soundFile should be played. Nil or don't
--                        - provide it for the default of standardVolumeOutput. Should be between
--                        - 0.1 to 1.0.
--
-- Starts playing a sound on a client if the client is within the specificed maxDistance from the playOnEntity.
-- @TODO Change sound volume based on the distance the player is away from the playOnEntity.
------
RegisterNetEvent('004e4a8a-ede7-43a4-b654-254bd6792462')
AddEventHandler('004e4a8a-ede7-43a4-b654-254bd6792462', function(playerNetId, maxDistance, soundFile, soundVolume)
	if playsound == true then
		if GetPlayerFromServerId(playerNetId) ~= -1 then
		
			local lCoords = GetEntityCoords(GetPlayerPed(-1))
			local eCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(playerNetId)))
			local distIs  = #(vector3(lCoords.x, lCoords.y, lCoords.z) - vector3(eCoords.x, eCoords.y, eCoords.z))
			if(distIs <= maxDistance) then
				SendNUIMessage({
					transactionType     = 'playSound',
					transactionFile     = soundFile,
					transactionVolume   = soundVolume
				})
			end

		end
	end
end)

RegisterNetEvent('d940eb47-74dd-4534-9b1b-eca12d0ba992')
AddEventHandler('d940eb47-74dd-4534-9b1b-eca12d0ba992', function(playerNetId, maxDistance, soundFile, soundVolume)
	if playsound == true then
		if GetPlayerFromServerId(playerNetId) ~= -1 then
		
			local lCoords = GetEntityCoords(GetPlayerPed(-1))
			local eCoords = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(playerNetId)))
			local distIs  = #(vector3(lCoords.x, lCoords.y, lCoords.z) - vector3(eCoords.x, eCoords.y, eCoords.z))
			local soundvol = soundVolume - ((distIs/150)*distIs)
			if soundvol < 0 then
				soundvol = 0
			end
			if(distIs <= maxDistance) then
				SendNUIMessage({
					transactionType     = 'playSound',
					transactionFile     = soundFile,
					transactionVolume   = soundvol
				})
			end

		end
	end
end)
