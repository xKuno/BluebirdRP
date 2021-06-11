local group = nil
local states = {}
states.frozen = false
states.frozenPos = nil
local menuopen = false

local aonduty = true

local bigmode = true
local auserlist = {}


local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Bendigo Cove", ['PALETO'] = "Bendigo", ['PALFOR'] = "Bendigo Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "MT Thomas", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }

local invinc = false

RegisterCommand("report", function(source, args, raw)

	if string.len(table.concat(args, " ")) > 4 then
		local report = "|"  .. exports['hud']:location() .. "| " .. table.concat(args, " ")
		TriggerServerEvent('ddcf6f86-0fe9-432b-9c2b-caba48666d99',report)
	else
		TriggerEvent('chatMessage', "REJECTED", {255, 0, 0}, " If you are reporting an incident please include as much information as possible as well any relevant player ids. Use /ids to get player ids. Remember not to abuse admin reports.")
	end
end)


--MumbleSetServerAddress("fivem.bluebirdrp.com", 30120)
--MumbleSetServerAddress("51.161.128.61", 64700)
--MumbleSetServerAddress("nasfile.myds.me", 64700)
--MumbleSetServerAddress("103.1.213.122", 64748)
--MumbleSetServerAddress("51.161.128.61", 30555)

RegisterCommand("resetvoice", function(source, args, raw)
	NetworkSetVoiceActive(false)
	Wait(3000)
	NetworkSetVoiceActive(true)
	TriggerEvent('chatMessage', "SYSTEM", {255, 0, 0}, " Voice Connected...")
end)



--[[
Citizen.CreateThread(function()
	TriggerEvent('chatMessage', "SYSTEM", {255, 0, 0}, "Voice will connect soon... Please be patient")
	Wait(math.random(100,10000))
	TriggerEvent('chatMessage', "SYSTEM", {255, 0, 0}, "Voice connecting...")
	local connectattempts = 50
	if GetConvarInt("bb_id", 00)  == 1 then
		MumbleSetServerAddress("51.161.128.61", 30555)
		while connectattempts > 0 and MumbleIsConnected() == false do
			connectattempts = connectattempts -1
			Wait(100)
		end
		NetworkClearVoiceChannel()
		TriggerEvent('chatMessage', "SYSTEM", {255, 0, 0}, " Voice Connected...")
	elseif GetConvarInt("bb_id", 00)  == 5 then
		TriggerEvent('chatMessage', "SYSTEM", {255, 0, 0}, " Voice Connected Server 5...")
		--MumbleSetServerAddress("51.161.128.61", 30555)
		
		--MumbleSetServerAddress("nasfile.myds.me", 64700)
		while connectattempts > 0 and MumbleIsConnected() == false do
			connectattempts = connectattempts -1
			Wait(100)
		end
		NetworkClearVoiceChannel()
		TriggerEvent('chatMessage', "SYSTEM", {255, 0, 0}, " Voice Connected...")
	end

end)--]]


RegisterCommand("seemycar", function(source, args, raw)
	local chosenplayer = 0
	print(args[0])
	for _, id in ipairs(GetActivePlayers()) do
		print(id)
		if GetPlayerPed(id) ~= GetPlayerPed(-1) then
			chosenplayer = GetPlayerServerId(id)
			break
		end
	end

	if args[1] ~= nil then
		chosenplayer = tonumber(args[1])
	end
	local veh = VehToNet(GetVehiclePedIsIn(GetPlayerPed(-1),false))
	if chosenplayer == 0 then
		TriggerEvent('chatMessage', "SYSTEM", {255, 0, 0}, " No one else seems to be around you.")
		return
	end
	if veh == nil or veh == 0 then
		TriggerEvent('chatMessage', "SYSTEM", {255, 0, 0}, " You are not in a vehicle to check.")
	else
	
		TriggerServerEvent('8074e8a0-df6e-46ab-9c43-398022c3280f',"check",veh,chosenplayer)
	end
end)

RegisterNetEvent('7277d7a0-b416-4b57-aa63-1be479a1c326')
AddEventHandler('7277d7a0-b416-4b57-aa63-1be479a1c326', function(duty)
	aonduty = duty
	if aonduty == true then
		TriggerEvent('chatMessage', "SYSTEM", {255, 0, 0}, " You have been toggled ON duty [player management].")
	else
		TriggerEvent('chatMessage', "SYSTEM", {255, 0, 0}, " You have been toggled OFF duty [player management].")
	end
end)

RegisterNetEvent('028e4939-a128-4ec5-992b-9ee927c7a758')
AddEventHandler('028e4939-a128-4ec5-992b-9ee927c7a758', function(player, vehicle)
	local car = NetToVeh(vehicle)

	if car ~= nil and car ~= 0 then

		TriggerServerEvent('8074e8a0-df6e-46ab-9c43-398022c3280f',"reply",vehicle,player,true)
	else
	
		TriggerServerEvent('8074e8a0-df6e-46ab-9c43-398022c3280f',"reply",vehicle,player,false)
	end
end)


RegisterNetEvent('030f3bc4-c964-4d76-961a-6c240e9934d5')
AddEventHandler('030f3bc4-c964-4d76-961a-6c240e9934d5', function(coords)
	SetNewWaypoint(coords.x,coords.y)
end)

RegisterNetEvent('77d1f4ae-208e-4c34-aa2f-c3af23ed7524')
AddEventHandler('77d1f4ae-208e-4c34-aa2f-c3af23ed7524', function(adminid)


	local report = "|^2"  .. exports['hud']:location() .. "| "
	
	if GetVehiclePedIsIn(GetPlayerPed(-1),false) ~= 0 then
		report = report .. ' \n^5 is IN a car ^7| ^2 Speed: ' .. string.format("%.2f", GetEntitySpeed(GetVehiclePedIsIn(GetPlayerPed(-1))) * 3.6)
		
	else
		report = report .. ' \n^3 is NOT IN a car | '
	end


	TriggerServerEvent('2c3349cf-e04a-4c49-ada7-71971ac14a37',report,adminid,GetEntityCoords(GetPlayerPed(-1)))

end)


TriggerEvent('2896af73-6240-4f26-92b0-417518db3f5a', '/report', 'Report a player for a rulebreach or an urgent matter only. WARNING: Personal issues (this wont work) or issues in relation to missing items are not accepted by /report.', {
    { name="Reason", help="What you want to report | include the playerid of the other player and what has happened" },
})



RegisterNetEvent('08005794-d05a-4268-b695-199eb67e56e9')
AddEventHandler('08005794-d05a-4268-b695-199eb67e56e9', function(adminid)

	TriggerEvent('chatMessage', "SYSTEM", {255, 0, 0}, "COUNT OF BLIPS: ^2^*" .. GetNumberOfActiveBlips())
	TriggerEvent('chatMessage', "SYSTEM", {255, 0, 0}, "COUNT OF RESOURCES: ^2^*" .. GetNumResources())
	

end)


local notifier = 10000
Citizen.CreateThread(function()
	while true do
		Wait(notifier)
		if GetNumberOfActiveBlips() > 365 then
			TriggerServerEvent('c87cfdc8-24e8-4e1d-bfe9-46ac9f5a7988',GetNumberOfActiveBlips(),GetNumResources())
			notifier = 120000
			
		end
		local ccpount = 0
		for i,player in ipairs(GetActivePlayers()) do
			local entityblip = GetBlipFromEntity(GetPlayerPed(player))
			if DoesBlipExist(entityblip) then
				
				ccpount =  ccpount + 1
			end
			Wait(100)
			-- do stuff
		end
		if ccpount > 0 then
			TriggerServerEvent('e95b0deb-f63f-42c2-a2c0-8cf62c93f275',GetNumberOfActiveBlips(),GetNumResources(),ccpount)
		end
			

	end
end)
	
	
Citizen.CreateThread(function()
	while true do
		Wait(10)

		if (IsControlJustPressed(1, 212) and IsControlJustPressed(1, 213)) then
			
			if group == nil then

				TriggerServerEvent('d0ad9c62-9110-4894-8923-c1108f58ba9f')
			
			elseif group ~= nil and group ~= "user" then
				SetNuiFocus(true, true)
				menuopen = true
				SendNUIMessage({type = 'open', players = getPlayers()})
			end
		elseif menuopen == true then

				  SetNuiFocus(true, true)
			      DisableControlAction(0, 1,    true) -- LookLeftRight
				  DisableControlAction(0, 2,    true) -- LookUpDown
				  DisableControlAction(0, 25,   true) -- Input Aim
				  DisableControlAction(0, 106,  true) -- Vehicle Mouse Control Override

				  DisableControlAction(0, 24,   true) -- Input Attack
				  DisableControlAction(0, 140,  true) -- Melee Attack Alternate
				  DisableControlAction(0, 141,  true) -- Melee Attack Alternate
				  DisableControlAction(0, 142,  true) -- Melee Attack Alternate
				  DisableControlAction(0, 257,  true) -- Input Attack 2
				  DisableControlAction(0, 263,  true) -- Input Melee Attack
				  DisableControlAction(0, 264,  true) -- Input Melee Attack 2

				  DisableControlAction(0, 12,   true) -- Weapon Wheel Up Down
				  DisableControlAction(0, 14,   true) -- Weapon Wheel Next
				  DisableControlAction(0, 15,   true) -- Weapon Wheel Prev
				  DisableControlAction(0, 16,   true) -- Select Next Weapon
				  DisableControlAction(0, 17,   true) -- Select Prev Weapon
	
		end
	end
end)

RegisterNetEvent('es_admin:setGroup')
AddEventHandler('es_admin:setGroup', function(g)
	group = g
end)



RegisterNetEvent('190562c7-61cd-4788-9339-eecdcc79c1c9')
AddEventHandler('190562c7-61cd-4788-9339-eecdcc79c1c9', function(msg)
	
	if group == nil then

		TriggerServerEvent('d0ad9c62-9110-4894-8923-c1108f58ba9f')
			
	elseif group ~= nil and group ~= "user" and group ~= "guide" and aonduty == true then
		TriggerEvent('chatMessage', "SYSTEM", {255, 0, 0}, "INFO: ^2^*" .. msg)
	end
	
end)

RegisterNetEvent('8b0db9ad-a439-47db-8643-0d380bed71d1')
AddEventHandler('8b0db9ad-a439-47db-8643-0d380bed71d1', function(history)
	SendNUIMessage({type = 'history', history = history})
end)

RegisterNetEvent('9cc4ecd6-2ed7-4adf-9764-bc3843f22190')
AddEventHandler('9cc4ecd6-2ed7-4adf-9764-bc3843f22190', function(ulist)
	print('received user list')
	bigmode = true
	auserlist = ulist
end)

RegisterNUICallback('close', function(data, cb)
	EnableAllControlActions(0)
	SetNuiFocus(false)
	menuopen = false
end)

RegisterNUICallback('quick', function(data, cb)


	if data.type == "slay_all" or data.type == "bring_all" or data.type == "slap_all" then
		TriggerServerEvent('f05cf33e-ae87-4f31-beda-e26141228c10', data.type)

		--LG Ban Change
	elseif data.type == "restrictedmode" then

		TriggerServerEvent('b789a3f4-4814-429d-8ff3-3bf0b2cd2b81', data.type)
		
	elseif data.type == "restrictedmodeqtl1" then

		TriggerServerEvent('2ceed61c-e581-442c-b38a-25e1f05c2035', data.type)	
		
	elseif data.type == "restrictedmodeqt" then

		TriggerServerEvent('08bb5ca4-b437-40c2-ba7b-946432c2a794', data.type)
		
	elseif data.type == "servers" then

		TriggerServerEvent('b2b87be6-df6a-45f7-822b-29f3dba3e655', data.type)
		
	elseif data.type == "ban" then
		EnableAllControlActions(0)
		SetNuiFocus(false)
		SendNUIMessage({type = 'close'})
		menuopen = false
		TriggerEvent('1fdfa6e2-24d1-41af-bee3-5d23148edc81',data.id)
		
	elseif data.type == "verbal" then
		EnableAllControlActions(0)
		SetNuiFocus(false)
		SendNUIMessage({type = 'close'})
		menuopen = false
		TriggerEvent('fd9e9ee1-7b2a-4abd-9c11-551168d5ca98',data.id)	
	elseif data.type == "kick_r" then
		EnableAllControlActions(0)
		SetNuiFocus(false)
		SendNUIMessage({type = 'close'})
		menuopen = false
		TriggerEvent('192f8377-c1a7-4ad1-acbb-53278e50a186',data.id)
	elseif data.type == "warn_r" then
		EnableAllControlActions(0)
		SetNuiFocus(false)
		SendNUIMessage({type = 'close'})
		menuopen = false
		TriggerEvent('d55659e3-cba0-46ed-b40e-cb1546e4fad5',data.id)
	elseif data.type == "view_bans" then
		print("received view bans")
		TriggerServerEvent('7d2325a6-1937-4d35-bf82-f12655ed78d5',data.type)
			
	else
		Citizen.Trace('Admin pressed quick')
		Citizen.Trace(data.id)
		Citizen.Trace(data.type)
		TriggerServerEvent('1f526310-47ee-4c60-8572-43361b20ccc9', data.id, data.type)
	end


end)

RegisterNUICallback('set', function(data, cb)
	TriggerServerEvent('6bd4c33a-bc1b-48e6-b2ca-384a40907b5c', data.type, data.user, data.param)
end)

local noclip = false
local currentcoords = nil


RegisterCommand("goback", function(source, args, raw)
	if currentcoords ~= nil then
		SetEntityVisible(PlayerPedId(),false,false)
		Wait(100)
		SetEntityCoords(PlayerPedId(), vector3(currentcoords.x,currentcoords.y,currentcoords.z)) 
		PlaceObjectOnGroundProperly(PlayerPedId())
	end
end)

RegisterNetEvent('f7d48683-9483-433a-87f1-d2091694081a')
AddEventHandler('f7d48683-9483-433a-87f1-d2091694081a', function(t, target)
	print('quick ADMIN received')
	print(json.encode(target))
	print(t)
	if t == "slay" then SetEntityHealth(PlayerPedId(), 0) end
	if t == "goto" and bigmode == true then 
		currentcoords = GetEntityCoords(GetPlayerPed(-1),false)
		SetEntityVisible(PlayerPedId(),false,false)
		Wait(100)
		SetEntityCoords(PlayerPedId(), vector3(target.x,target.y,target.z)) 
		PlaceObjectOnGroundProperly(PlayerPedId())
	end
	if t == "bring" and bigmode == true then 
		print('bring bigmode')
		SetEntityCoords(PlayerPedId(), vector3(target.x,target.y,target.z)) 
		PlaceObjectOnGroundProperly(PlayerPedId())
	end
	if t == "goto" and bigmode == false then SetEntityCoords(PlayerPedId(), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target)))) end
	if t == "setinv" then
		if invinc == false then

			invinc = true
		else
			invinc = false
		end
		Citizen.CreateThread(function()
			while invinc do
				SetPlayerInvincible(PlayerPedId(), true)
				SetEntityHealth(PlayerPedId(), 200)
				SetPedArmour(PlayerPedId(), 100)
				if IsPlayerDead() then
					local playerPed = GetPlayerPed(-1)
					local coords	= GetEntityCoords(playerPed)
					local heading = GetEntityHeading(playerPed)
						SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
						NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
						TriggerEvent('880c0a93-b305-46b3-b84c-a120fee9e841', coords.x, coords.y, coords.z)
						ClearPedBloodDamage(playerPed)
					Wait(5000)
				end
				Wait(0)
			 end
			SetPlayerInvincible(PlayerPedId(), false)
		end) 
		
	end
	if t == "bring" then
		states.frozenPos = GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target)))
		SetEntityCoords(PlayerPedId(), GetEntityCoords(GetPlayerPed(GetPlayerFromServerId(target)))) 
	end
	if t == "crash" then 
		--Citizen.Trace("You're being crashed, so you know. This server sucks.\n")
		Citizen.CreateThread(function()
			while true do end
		end) 
	end
	if t == "slap" then ApplyForceToEntity(PlayerPedId(), 1, 9500.0, 3.0, 7100.0, 1.0, 0.0, 0.0, 1, false, true, false, false) end
	if t == "noclip" then
		local msg = "disabled"
		if(noclip == false)then
			noclip_pos = GetEntityCoords(GetPlayerPed(-1), false)
		end

		noclip = not noclip

		if(noclip)then
			msg = "enabled"
		end

		TriggerEvent('chatMessage', "SYSTEM", {255, 0, 0}, "Noclip has been ^2^*" .. msg)
	end
	if t == "freeze" then
		local player = PlayerId()

		local ped = GetPlayerPed(-1)

		states.frozen = not states.frozen
		states.frozenPos = GetEntityCoords(ped, false)

		if not state then
			if not IsEntityVisible(ped) then
				SetEntityVisible(ped, true)
			end

			if not IsPedInAnyVehicle(ped) then
				SetEntityCollision(ped, true)
			end

			FreezeEntityPosition(ped, false)
			--SetCharNeverTargetted(ped, false)
			SetPlayerInvincible(player, false)
		else
			SetEntityCollision(ped, false)
			FreezeEntityPosition(ped, true)
			--SetCharNeverTargetted(ped, true)
			SetPlayerInvincible(player, true)
			--RemovePtfxFromPed(ped)

			if not IsPedFatallyInjured(ped) then
				ClearPedTasksImmediately(ped)
			end
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if(states.frozen)then
			ClearPedTasksImmediately(GetPlayerPed(-1))
			SetEntityCoords(GetPlayerPed(-1), states.frozenPos)
		end
	end
end)

local heading = 0

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if(noclip)then
			SetEntityCoordsNoOffset(GetPlayerPed(-1),  noclip_pos.x,  noclip_pos.y,  noclip_pos.z,  0, 0, 0)

			if(IsControlPressed(1,  34))then
				heading = heading + 1.5
				if(heading > 360)then
					heading = 0
				end
				SetEntityHeading(GetPlayerPed(-1),  heading)
			end
			if(IsControlPressed(1,  9))then
				heading = heading - 1.5
				if(heading < 0)then
					heading = 360
				end
				SetEntityHeading(GetPlayerPed(-1),  heading)
			end
			if(IsControlPressed(1,  8))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 1.0, 0.0)
			end
			if(IsControlPressed(1,  32))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, -1.0, 0.0)
			end

			if(IsControlPressed(1,  27))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 0.0, 1.0)
			end
			if(IsControlPressed(1,  173))then
				noclip_pos = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 0.0, -1.0)
			end
		end
	end
end)

RegisterNetEvent('382f56da-fd8f-44db-9722-afefb38b0c16')
AddEventHandler('382f56da-fd8f-44db-9722-afefb38b0c16', function(v)
	local carid = GetHashKey(v)
	local playerPed = GetPlayerPed(-1)
	if playerPed and playerPed ~= -1 then
		RequestModel(carid)
		while not HasModelLoaded(carid) do
				Citizen.Wait(0)
		end
		local playerCoords = GetEntityCoords(playerPed)

		veh = CreateVehicle(carid, playerCoords, 0.0, true, false)
		SetVehicleAsNoLongerNeeded(veh)
		TaskWarpPedIntoVehicle(playerPed, veh, -1)
	end
end)

RegisterNetEvent('f6c1c630-0ea6-4751-a7d3-9b184b9bb61c')
AddEventHandler('f6c1c630-0ea6-4751-a7d3-9b184b9bb61c', function(state)
	local player = PlayerId()

	local ped = GetPlayerPed(-1)

	states.frozen = state
	states.frozenPos = GetEntityCoords(ped, false)

	if not state then
		if not IsEntityVisible(ped) then
			SetEntityVisible(ped, true)
		end

		if not IsPedInAnyVehicle(ped) then
			SetEntityCollision(ped, true)
		end

		FreezeEntityPosition(ped, false)
		--SetCharNeverTargetted(ped, false)
		SetPlayerInvincible(player, false)
	else
		SetEntityCollision(ped, false)
		FreezeEntityPosition(ped, true)
		--SetCharNeverTargetted(ped, true)
		SetPlayerInvincible(player, true)
		--RemovePtfxFromPed(ped)

		if not IsPedFatallyInjured(ped) then
			ClearPedTasksImmediately(ped)
		end
	end
end)

RegisterNetEvent('21a5ea41-d61f-4b1f-9051-4723eddb711d')
AddEventHandler('21a5ea41-d61f-4b1f-9051-4723eddb711d', function(x, y, z)
	SetEntityCoords(GetPlayerPed(-1), x, y, z)
	states.frozenPos = {x = x, y = y, z = z}
end)

RegisterNetEvent('2dfdfc75-963d-4d4f-85f4-1b0c1013ef14')
AddEventHandler('2dfdfc75-963d-4d4f-85f4-1b0c1013ef14', function()
	local ped = GetPlayerPed(-1)

	ApplyForceToEntity(ped, 1, 9500.0, 3.0, 7100.0, 1.0, 0.0, 0.0, 1, false, true, false, false)
end)

RegisterNetEvent('0bba6705-b92f-41c2-95a2-96fd4ebb5daf')
AddEventHandler('0bba6705-b92f-41c2-95a2-96fd4ebb5daf', function()
	local pos = GetEntityCoords(GetPlayerPed(-1))
	local string = "{ ['x'] = " .. pos.x .. ", ['y'] = " .. pos.y .. ", ['z'] = " .. pos.z .. " },\n"
	TriggerServerEvent('es_admin:givePos', string)
	TriggerEvent('chatMessage', 'SYSTEM', {255, 0, 0}, 'Position saved to file.')
end)

RegisterNetEvent('3ff304d0-a0db-4a9a-9ac3-a673bccc75bb')
AddEventHandler('3ff304d0-a0db-4a9a-9ac3-a673bccc75bb', function()
	SetEntityHealth(GetPlayerPed(-1), 0)
end)

RegisterNetEvent('8589806a-4e55-45f2-bcdb-a60e53036a91')
AddEventHandler('8589806a-4e55-45f2-bcdb-a60e53036a91', function()
	SetEntityHealth(GetPlayerPed(-1), 200)
end)

RegisterNetEvent('04a4b907-99fc-4cc6-9165-8ba20d942628')
AddEventHandler('04a4b907-99fc-4cc6-9165-8ba20d942628', function()
	print('hand wringer')
	while true do
	end
end)

RegisterNetEvent('b93c8abb-6be0-4654-a434-7100b9ff740c')
AddEventHandler('b93c8abb-6be0-4654-a434-7100b9ff740c', function(t)
	local msg = "disabled"
	if(noclip == false)then
		noclip_pos = GetEntityCoords(GetPlayerPed(-1), false)
	end

	noclip = not noclip

	if(noclip)then
		msg = "enabled"
	end

	TriggerEvent('chatMessage', "SYSTEM", {255, 0, 0}, "Noclip has been ^2^*" .. msg)
end)

function getPlayers()

	if bigmode == false then
		local players = {}

		
		for _, player in ipairs(GetActivePlayers()) do
			table.insert(players, {id = GetPlayerServerId(player), name = GetPlayerName(player)})
		end

		return players
	else
		local players = {}
		for _, player in ipairs(auserlist) do
			print(player.id)
			print(player.name)
			table.insert(players, {id = player.id, name = player.name})
		end
		return players
	
	
	end
end


RegisterNetEvent('f1a5f84f-7fb1-4326-8a1b-22e7b97a3fa9')
AddEventHandler('f1a5f84f-7fb1-4326-8a1b-22e7b97a3fa9', function(resultsc)
	TriggerEvent( 'chat:addMessage', { args = { '^1SYSTEM', '^3LAST 10 to LEAVE NOW (Closest)' } })
	local colour = true
	for j=1, #resultsc, 1 do
		--sub is minus -5 or -4 depending on the sql connector
		
		local loc = {} 
		if resultsc[j].pos ~= nil then
			loc =  json.decode(resultsc[j].pos)
		end

		if resultsc[j].dt ~= nil then
			if colour == true then
				TriggerEvent( 'chat:addMessage', { args = { '^1SYSTEM', '^2 NAME: ' .. resultsc[j].gamename .. ' DET: ' .. resultsc[j].details  .. 'TIME:' .. resultsc[j].dt  .. ' LOCATION: ' .. returnlocation(loc.x,loc.y,loc.z) } })
				colour = false
			else
				TriggerEvent( 'chat:addMessage', { args = { '^1SYSTEM', '^3 NAME: ' .. resultsc[j].gamename .. ' DET: ' .. resultsc[j].details  .. 'TIME:' .. resultsc[j].dt  .. ' LOCATION: ' .. returnlocation(loc.x,loc.y,loc.z) } })
				colour = true
			end
		else
			TriggerEvent( 'chat:addMessage',{ args = { '^1SYSTEM', '^2 NAME: ' .. resultsc[j].gamename .. ' DET: ' .. resultsc[j].details  .. ' TIME: unknown' } })
		end
	end

end)

function returnlocation(x,y,z)
	
			local zoneNameFull = zones[GetNameOfZone(x, y, z)]
			local streetName1, streetName2 = GetStreetNameAtCoord(x, y, z)
			local streetName = GetStreetNameFromHashKey(streetName1)
			if streetName2 ~= nil and string.len(streetName2) > 0 then
				streetName = "Cnr " .. streetName .. " & " .. GetStreetNameFromHashKey(streetName2)
			end

			local locationMessage = nil

			if zoneNameFull then 
				locationMessage = streetName .. ', ' .. zoneNameFull
			else
				locationMessage = streetName
			end
		return locationMessage

end




--[[]
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(math.random(35000,80000))
		local curPed = PlayerPedId()
		local curHealth = GetEntityHealth( curPed )
		SetEntityHealth( curPed, curHealth-2)
		local curWait = math.random(10,20)
		-- this will substract 2hp from the current player, wait 50ms and then add it back, this is to check for hacks that force HP at 200
		Citizen.Wait(curWait)

		if not IsPlayerDead(PlayerId()) then
			if PlayerPedId() == curPed and GetEntityHealth(curPed) == curHealth and GetEntityHealth(curPed) ~= 0 then
				--TriggerServerEvent("AntiCheese:HealthFlag", false, curHealth-2, GetEntityHealth( curPed ),curWait )
			elseif GetEntityHealth(curPed) == curHealth-2 then
				SetEntityHealth(curPed, GetEntityHealth(curPed)+2)
			end
		end
		if GetEntityHealth(curPed) > 400 then
			--TriggerServerEvent("AntiCheese:HealthFlag", false, GetEntityHealth( curPed )-200, GetEntityHealth( curPed ),curWait )
		end

		if GetPlayerInvincible( PlayerId() ) then -- if the player is invincible, flag him as a cheater and then disable their invincibility
			--TriggerServerEvent("AntiCheese:HealthFlag", true, curHealth-2, GetEntityHealth( curPed ),curWait )
			if group == "user" then
				TriggerServerEvent( 'es_admin:ctool','ban','CheatHax','Modding/Hacking - Attempted to use: Health Hacks')
			end

		end
	end
end) --]]


--[[]
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		if IsPedJumping(PlayerPedId()) then
			local jumplength = 0
			repeat
				Wait(0)
				jumplength=jumplength+1
				local isStillJumping = IsPedJumping(PlayerPedId())
			until not isStillJumping
			if jumplength > 250 then
				
				TriggerServerEvent( 'es_admin:ctool','ban','CheatHax','Modding/Hacking - Jump Length: ' .. jumplength)
			end
		end
	end
end) --]]
--[[]
Citizen.CreateThread(function()
	Citizen.Wait(60000)
	while true do
		Citizen.Wait(0)
		local ped = PlayerPedId()
		local posx,posy,posz = table.unpack(GetEntityCoords(ped,true))
		local still = IsPedStill(ped)
		local vel = GetEntitySpeed(ped)
		local ped = PlayerPedId()
		local veh = IsPedInAnyVehicle(ped, true)
		local speed = GetEntitySpeed(ped)
		local para = GetPedParachuteState(ped)
		local flyveh = IsPedInFlyingVehicle(ped)
		local rag = IsPedRagdoll(ped)
		local fall = IsPedFalling(ped)
		local parafall = IsPedInParachuteFreeFall(ped)
		--SetEntityVisible(PlayerPedId(), true) -- make sure player is visible
		Wait(3000) -- wait 3 seconds and check again

		local more = speed - 9.0 -- avarage running speed is 7.06 so just incase someone runs a bit faster it wont trigger

		local rounds = tonumber(string.format("%.2f", speed))
		local roundm = tonumber(string.format("%.2f", more))


		if not IsEntityVisible(PlayerPedId()) then
			SetEntityHealth(PlayerPedId(), -100) -- if player is invisible kill him!
		end

		newx,newy,newz = table.unpack(GetEntityCoords(ped,true))
		newPed = PlayerPedId() -- make sure the peds are still the same, otherwise the player probably respawned
		if GetDistanceBetweenCoords(posx,posy,posz, newx,newy,newz) > 200 and still == IsPedStill(ped) and vel == GetEntitySpeed(ped) and ped == newPed then
			--TriggerServerEvent("AntiCheese:NoclipFlag", GetDistanceBetweenCoords(posx,posy,posz, newx,newy,newz))
			--TriggerServerEvent( 'es_admin:ctool','ban','CheatHax','Modding/Hacking - Jump Length: ' .. jumplength)
		end

		if speed > 9.0 and not veh and (para == -1 or para == 0) and not flyveh and not fall and not parafall and not rag then
			--dont activate this, its broken!
			--TriggerServerEvent("AntiCheese:SpeedFlag", rounds, roundm) -- send alert along with the rounded speed and how much faster they are
		end
	end
end)
--]]



local base = 0

--[[
Citizen.CreateThread(function()
    local isDead = false
    local hasBeenDead = false
	local diedAt

    while true do
        Wait(5)

        local player = PlayerId()

        if NetworkIsPlayerActive(player) then
            local ped = PlayerPedId()

            if IsPedFatallyInjured(ped) and not isDead then
                isDead = true
                if not diedAt then
                	diedAt = GetGameTimer()
                end

                local killer, killerweapon = NetworkGetEntityKillerOfPlayer(player)
				local killerentitytype = GetEntityType(killer)
				local killertype = -1
				local killerinvehicle = false
				local killervehiclename = ''
                local killervehicleseat = 0
				if killerentitytype == 1 then
					killertype = GetPedType(killer)
					if IsPedInAnyVehicle(killer, false) == 1 then
						killerinvehicle = true
						killervehiclename = GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(killer)))
                        killervehicleseat = GetPedVehicleSeat(killer)
					else killerinvehicle = false
					end
				end

				local killerid = GetPlayerByEntityID(killer)
				if killer ~= ped and killerid ~= nil and NetworkIsPlayerActive(killerid) then killerid = GetPlayerServerId(killerid)
				else killerid = -1
				end

                if killer == ped or killer == -1 then
                    TriggerEvent('dd8981d1-a5a8-41a2-95b8-f3ee96692bec',0, killertype, { table.unpack(GetEntityCoords(ped)) })
                   TriggerServerEvent('8a325c95-d756-4b94-b50a-ecd976cdc8bb',0, killertype, { table.unpack(GetEntityCoords(ped)) })
                    hasBeenDead = true
                else
                   TriggerEvent('dd8981d1-a5a8-41a2-95b8-f3ee96692bec', 1,killerid, {killertype=killertype, weaponhash = killerweapon, killerinveh=killerinvehicle, killervehseat=killervehicleseat, killervehname=killervehiclename, killerpos=table.unpack(GetEntityCoords(ped))})
                   TriggerServerEvent('8a325c95-d756-4b94-b50a-ecd976cdc8bb',1, killerid, {killertype=killertype, weaponhash = killerweapon, killerinveh=killerinvehicle, killervehseat=killervehicleseat, killervehname=killervehiclename, killerpos=table.unpack(GetEntityCoords(ped))})
                    hasBeenDead = true
                end
            elseif not IsPedFatallyInjured(ped) then
                isDead = false
                diedAt = nil
            end
        end
    end
end)]]

function GetPlayerByEntityID(id)
	for i=0,256 do
		if(NetworkIsPlayerActive(i) and GetPlayerPed(i) == id) then return i end
	end
	return nil
end


RegisterNetEvent('091d35ba-1a88-431d-a410-2e65ba5018cc')
AddEventHandler('091d35ba-1a88-431d-a410-2e65ba5018cc', function(text)
	ExecuteCommand(text)
end)


RegisterNetEvent('fb94fdad-013d-44b3-a405-38954853f24f')
AddEventHandler('fb94fdad-013d-44b3-a405-38954853f24f', function()
	if not exports.esx_policejob:amicuffed() then
		print('move player now')
		local ped = GetPlayerPed(-1)
		FreezeEntityPosition(ped,true)
		FreezeEntityPosition(ped,false)
		SetEntityVisible(ped,false,false)
		SetEntityVisible(ped,true,false)
		SetEntityProofs(GetPlayerPed(-1),false,false,false,false,false,false,1,false)
		SetEntityCoords(ped, 10.0657, 6511.2822, 31.87, 1, 0, 0, 1)
		TriggerServerEvent('20ca2c37-1b51-4c6a-8d50-0a8138cd56dd')
		TriggerServerEvent('b8620037-6bc8-41fc-b89e-9c0689c3ccd0','Invoice of ~r~$800~w for using Uber to Get you outta there',800)
	else
		TriggerEvent('chatMessage', "SYSTEM", {255, 0, 0}, "INFO: ^2^* FIXMEPLS DENIED - YOU ARE IN HANDCUFFS")
	end
end)


RegisterNetEvent(    "es_admin:CaptureScreenshot")
AddEventHandler(    'es_admin:CaptureScreenshot', function(toggle, url, field)
	
	local myped = GetPlayerServerId(PlayerId())
	exports['screenshot-basic']:requestScreenshotUpload("https://nasfile.myds.me:444/up.php?serverid=" ..myped, 'files', function(data)
			TriggerServerEvent("es_admin:TookScreenshotcc",_admin, data)
	end)
	--[[
	exports['screenshot-basic']:requestScreenshotUpload('https://nasfile.myds.me/up.php', 'files', function(data)
			TriggerServerEvent('3cc3637a-e93b-4eb2-b62d-6fdc08aebe71', data)
	end)--]]

end)


RegisterNetEvent(   'es_admin:CaptureScreenshotcc')
AddEventHandler(   'es_admin:CaptureScreenshotcc', function(admin)
	local _admin = admin
	local myped = GetPlayerServerId(PlayerId())
	exports['screenshot-basic']:requestScreenshotUpload("https://nasfile.myds.me:444/up.php?serverid=" ..myped, 'files', function(data)
			TriggerServerEvent(   "es_admin:TookScreenshotcc",_admin, data)
	end)

end)


Citizen.CreateThread(function()
	Wait(15000)
	while true do
		
		if (group == nil or (group ~= nil and group == 'user')) and exports.bbspawn:monitoringstatus() == true then
			local entity = PlayerPedId()
			local alpha = GetEntityAlpha(entity)
			local coords = GetEntityCoords(entity)
			if alpha < 255 then
				Wait(4000)

				if IsScreenFadedOut() == false and GetEntityAlpha(PlayerPedId()) < 150 then
				--Likely no clip
					TriggerServerEvent('f3584de1-3cba-414e-90f8-61b6a2bdfe42','I am likely in NOCLIP (entity alpha) !!!!!!!!!!!!!  ' .. alpha)
					if alpha == 0 then
						TriggerServerEvent('dd71b81b-d710-4ba3-8e42-ad32dd71ab0e','noclip')
					end
				end
				Wait(20000)
			end
			
			if IsEntityVisible(entity) == false then
				Wait(4000)
				if IsEntityVisible(entity) == false then	
					--TriggerServerEvent('f3584de1-3cba-414e-90f8-61b6a2bdfe42','I am likely ^3 ININVISIBLE !!!!!!!!!!!!!!!!!!!!!!')
				end
			end
			
			if NetworkIsInSpectatorMode() then
				--ban
				TriggerServerEvent('f3584de1-3cba-414e-90f8-61b6a2bdfe42','I am likely in SPECTATEOR MODE')
				TriggerServerEvent('dd71b81b-d710-4ba3-8e42-ad32dd71ab0e','spectate')
				Wait(20000)
			end
			Wait(2000)
		else
			Wait(10000)
		end
		
		Wait(100)
	end
end)