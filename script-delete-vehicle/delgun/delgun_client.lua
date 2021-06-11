-- Credits to @Havoc , @Flatracer , @Briglair , and @WolfKnight	on forum.fivem.net for helping me create this
-- Thanks to Ethan Rubinacci and Mark Curry
-- Lots of thanks to @Wolfknight for help with the admin feature
-- Special thanks to @Flatracer

-- Created by Murtaza. If you need help, msg me. The comments are there for people to learn.

-- CLIENTSIDED
-- Register a network event
RegisterNetEvent('264c7103-4aae-4b7b-ace9-2bffae563be2') -- Registers the event on the net so that it can be called on a server_script
RegisterNetEvent('7cea649c-da82-47ef-bdcd-1f3f265321d3') -- Registers the event on the net so that it can be called on a server_script
RegisterNetEvent('1737453f-132e-4cbc-a37a-da071ecc4925') -- Registers the event on the net so that it can be called on a server_script
local toggle = false

AddEventHandler('264c7103-4aae-4b7b-ace9-2bffae563be2', function() -- adds an event handler so it can be registered
	if toggle == false then -- checks if toggle is false
		drawNotification("~g~Object Delete Gun Enabled!") -- activates function drawNotification() with message in parentheses
		toggle = true -- sets toggle to true
		
		Citizen.CreateThread(function()
			Wait(20000)
			toggle = false
			drawNotification('~y~Object Delete Gun is already disabled!')
		end)
	else -- if not
		drawNotification('~y~Object Delete Gun is already enabled!') -- activates function drawNotification() with message in parentheses
	end
end)

AddEventHandler('7cea649c-da82-47ef-bdcd-1f3f265321d3', function() -- adds an event handler so it can be registered
	if toggle == true then -- checks if toggle is true
		drawNotification('~b~Object Delete Gun Disabled!') -- activates function drawNotification() with message in parentheses
		toggle = false -- sets toggle to false
	else -- if not
		drawNotification('~y~Object Delete Gun is already disabled!') -- activates function drawNotification() with message in parentheses
	end
end)

AddEventHandler('1737453f-132e-4cbc-a37a-da071ecc4925', function() -- adds an event handler so it can be registered
	drawNotification("~r~You have insufficient permissions to activate the Object Delete Gun.") -- activates function drawNotification() with message in parentheses
	drawNotification("~o~This command has been recently whitelisted. Only whitelisted roles can activate.")
end)

RegisterNetEvent('07d08114-48d3-41eb-a7dc-7c4b989974bf')
AddEventHandler('07d08114-48d3-41eb-a7dc-7c4b989974bf', function(networkid) -- adds an event handler so it can be registered
	local entity =  NetworkGetEntityFromNetworkId(networkid)
	if entity ~= getEntity(PlayerPedId())  then
		SetNetworkIdCanMigrate(entity, true)
		SetVehicleHasBeenOwnedByPlayer(entity,false)
		SetEntityAsMissionEntity(entity, false, false)
		DeleteEntity(entity)
		DeleteObject(entity)
		SetEntityAsMissionEntity(entity, false, false)
		DeleteEntity(entity)
		DeleteObject(entity)
	end
end)


Citizen.CreateThread(function() -- Creates thread
	while true do -- infinite loop
		Citizen.Wait(100) -- wait so it doesnt crash
		if toggle then -- checks toggle if its true (infinitely
			if IsPlayerFreeAiming(PlayerId()) then -- checks if player is aiming around
				local entity = getEntity(PlayerId()) -- gets the entity
				
				if IsPedAPlayer(entity) == false then
					if entity ~= 0 then
						coords = GetEntityCoords(entity,true)
						
						local txtfile = "{\n objName = " .. GetEntityModel(entity) ..",\n" ..
						'objCoords  = {x = ' ..coords.x ..', y = '..coords.y ..', z = '..coords.z ..' },\n' ..
						'textCoords  = {x = ' ..coords.x ..', y = '..coords.y ..', z = '..coords.z ..' },\n' ..
						"fixedpos = " .. GetEntityRotation(entity) .. ",\n" ..
						"authorizedJobs = { 'keycard_police','keycard_afp' },\n" ..
						"locked = true,\n" ..
						"distance = 6,\n" .. 
						"size = 2\n" ..
						"}\n"
						
						Citizen.Trace(txtfile)
						
						local s, e = pcall(function() exports["csaver"]:textoclip(txtfile) end)						

						
						
						Citizen.Trace('{x = ' ..coords.x ..', y = '..coords.y ..', z = '..coords.z ..' }')


						Citizen.Trace(GetEntityModel(entity) .. ' |||||||||||||||||||||| ROTATION: ' .. GetEntityRotation(entity) .. ' \n ')
						print('Entity Owner : ' .. GetPlayerServerId(NetworkGetEntityOwner(entity)))
						SetVehicleHasBeenOwnedByPlayer(vehicle,false)
						SetEntityAsMissionEntity(entity, false, false) -- sets the entity as mission entity so it can be despawned
						DeleteEntity(entity) -- deletes the entity
						if entity == getEntity(PlayerId()) then
							--didnt deletes
							local networkid = NetworkGetNetworkIdFromEntity(entity)
							print('THIS HAS A NETWORK ID: ' .. networkid)
							TriggerServerEvent('b895d2f8-43cb-48e6-ab1c-be49f69d8866', networkid)
							Wait(200)
						end
					end
				end

			end
		else
			Wait(2000)
		end
	end
end)

function getEntity(player) --Function To Get Entity Player Is Aiming At
	local result, entity = GetEntityPlayerIsFreeAimingAt(player)
	return entity
end

function drawNotification(text) --Just Don't Edit!
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end