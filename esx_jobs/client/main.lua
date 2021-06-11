local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local PlayerData = {}
local menuIsShowed = false
local hintIsShowed = false
local hasAlreadyEnteredMarker = false
local Blips = {}
local JobBlips = {}
local isInMarker = false
local isInPublicMarker = false

local hintToDisplay = "no hint to display"
local onDuty = false
local spawner = 0
local myPlate = {}

local vehicleObjInCaseofDrop = nil
local vehicleInCaseofDrop = nil

local vehicleMaxHealth = nil

local closer 		= false

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
	refreshBlips()
end)

RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(xPlayer)
	PlayerData = xPlayer
	refreshBlips()
end)

function OpenMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom',
	{
		title    = _U('cloakroom'),
		elements = {
			{label = _U('job_wear'),     value = 'job_wear'},
			{label = _U('citizen_wear'), value = 'citizen_wear'}
		}
	}, function(data, menu)
		if data.current.value == 'citizen_wear' then
			onDuty = false
			ESX.TriggerServerCallback('4568d939-3661-4833-ae6a-378432ac6ff1', function(skin)
				TriggerEvent('56a2ee13-8a49-4ad3-a298-1854493c98ee', skin)
			end)
		elseif data.current.value == 'job_wear' then
			onDuty = true
			ESX.TriggerServerCallback('4568d939-3661-4833-ae6a-378432ac6ff1', function(skin, jobSkin)
				if skin.sex == 0 then
					TriggerEvent('1d09cf94-2c53-4220-a089-0339ce8bb123', skin, jobSkin.skin_male)
				else
					TriggerEvent('1d09cf94-2c53-4220-a089-0339ce8bb123', skin, jobSkin.skin_female)
				end
			end)
		end

		menu.close()
	end, function(data, menu)
		menu.close()
	end)
end

AddEventHandler('4a355f28-2101-4b30-addf-6ef84000c7d6', function(job, zone)
	menuIsShowed = true
	if zone.Type == "cloakroom" then
		OpenMenu()
	elseif zone.Type == "work" then
		hintToDisplay = "no hint to display"
		hintIsShowed = false
		local playerPed = PlayerPedId()

		if IsPedInAnyVehicle(playerPed, false) then
			ESX.ShowNotification(_U('foot_work'))
		else
			TriggerServerEvent('4e0f3562-ea4a-414c-bd21-7895c293cbd8', zone.Item,"a7897342huidsa9hg3")
		end
	elseif zone.Type == "vehspawner" then
		local spawnPoint = nil
		local vehicle = nil

		for k,v in pairs(Config.Jobs) do
			if PlayerData.job.name == k then
				for l,w in pairs(v.Zones) do
					if w.Type == "vehspawnpt" and w.Spawner == zone.Spawner then
						spawnPoint = w
						spawner = w.Spawner
					end
				end

				for m,x in pairs(v.Vehicles) do
					if x.Spawner == zone.Spawner then
						vehicle = x
					end
				end
			end
		end

		if ESX.Game.IsSpawnPointClear(spawnPoint.Pos, 5.0) then
			spawnVehicle(spawnPoint, vehicle, zone.Caution)
		else
			ESX.ShowNotification(_U('spawn_blocked'))
		end

	elseif zone.Type == "vehdelete" then
		local looping = true

		for k,v in pairs(Config.Jobs) do
			if PlayerData.job.name == k then
				for l,w in pairs(v.Zones) do
					if w.Type == "vehdelete" and w.Spawner == zone.Spawner then
						local playerPed = PlayerPedId()

						if IsPedInAnyVehicle(playerPed, false) then

							local vehicle = GetVehiclePedIsIn(playerPed, false)
							local plate = GetVehicleNumberPlateText(vehicle)
							plate = string.gsub(plate, " ", "")
							local driverPed = GetPedInVehicleSeat(vehicle, -1)

							if playerPed == driverPed then

								for i=1, #myPlate, 1 do
									if myPlate[i] == plate then

										local vehicleHealth = GetVehicleEngineHealth(vehicleInCaseofDrop)
										local giveBack = 0

										TriggerServerEvent('6fd8fa52-85ba-44ed-975b-5d951f7f5196', "give_back", 0, 0, 0)
										DeleteVehicle(GetVehiclePedIsIn(playerPed, false))

										if w.Teleport ~= 0 then
											ESX.Game.Teleport(playerPed, w.Teleport)
										end

										table.remove(myPlate, i)

										if vehicleObjInCaseofDrop.HasCaution then
											vehicleInCaseofDrop = nil
											vehicleObjInCaseofDrop = nil
											vehicleMaxHealth = nil
										end

										break
									end
								end

							else
								ESX.ShowNotification(_U('not_your_vehicle'))
							end

						end

						looping = false
						break
					end

					if looping == false then
						break
					end
				end
			end
			if looping == false then
				break
			end
		end
	elseif zone.Type == "delivery" then
		if Blips['delivery'] ~= nil then
			RemoveBlip(Blips['delivery'])
			Blips['delivery'] = nil
		end

		hintToDisplay = "no hint to display"
		hintIsShowed = false
		TriggerServerEvent('4e0f3562-ea4a-414c-bd21-7895c293cbd8', zone.Item,"a7897342huidsa9hg3")
	end
	--nextStep(zone.GPS)
end)

function nextStep(gps)
	if gps ~= 0 then
		if Blips['delivery'] ~= nil then
			RemoveBlip(Blips['delivery'])
			Blips['delivery'] = nil
		end

		Blips['delivery'] = AddBlipForCoord(gps.x, gps.y, gps.z)
		SetBlipRoute(Blips['delivery'], true)
		ESX.ShowNotification(_U('next_point'))
	end
end

AddEventHandler('5159b1c3-dbdd-4f63-87af-e96d9c0dd0fd', function(zone)
	print('stop working')
	TriggerServerEvent('c408a616-f76a-4e0d-a3dd-f9bcee3b9eac')
	hintToDisplay = "no hint to display"
	menuIsShowed = false
	hintIsShowed = false
	isInMarker = false
end)

RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function(job)
	PlayerData.job = job
	onDuty = false
	myPlate = {} -- loosing vehicle caution in case player changes job.
	spawner = 0
	deleteBlips()
	refreshBlips()
end)

function deleteBlips()
	if JobBlips[1] ~= nil then
		for i=1, #JobBlips, 1 do
			RemoveBlip(JobBlips[i])
			JobBlips[i] = nil
		end
	end
end

function refreshBlips()
	local zones = {}
	local blipInfo = {}

	if PlayerData.job ~= nil then
		for jobKey,jobValues in pairs(Config.Jobs) do

			if jobKey == PlayerData.job.name then
				for zoneKey,zoneValues in pairs(jobValues.Zones) do

					if zoneValues.Blip then
						local blip = AddBlipForCoord(zoneValues.Pos.x, zoneValues.Pos.y, zoneValues.Pos.z)
						SetBlipSprite  (blip, jobValues.BlipInfos.Sprite)
						SetBlipDisplay (blip, 4)
						SetBlipScale   (blip, 1.2)
						SetBlipCategory(blip, 3)
						SetBlipColour  (blip, jobValues.BlipInfos.Color)
						SetBlipAsShortRange(blip, true)

						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString(zoneValues.Name)
						EndTextCommandSetBlipName(blip)
						table.insert(JobBlips, blip)
					end
				end
			end
		end
	end
end

function spawnVehicle(spawnPoint, vehicle, vehicleCaution)
	hintToDisplay = 'no hint to display'
	hintIsShowed = false
	TriggerServerEvent('6fd8fa52-85ba-44ed-975b-5d951f7f5196', 'take', vehicleCaution, spawnPoint, vehicle)
end

RegisterNetEvent('7fe5058f-9ec8-43f8-9662-34db70f8447e')
AddEventHandler('7fe5058f-9ec8-43f8-9662-34db70f8447e', function(spawnPoint, vehicle)
	local playerPed = PlayerPedId()

	ESX.Game.SpawnVehicle(vehicle.Hash, spawnPoint.Pos, spawnPoint.Heading, function(spawnedVehicle)

		if vehicle.Trailer ~= "none" then
			local trailerspawn = spawnPoint.Pos
			trailerspawn["z"] = trailerspawn["z"] + 3.5
			ESX.Game.SpawnVehicle(vehicle.Trailer, trailerspawn, spawnPoint.Heading, function(trailer)
				AttachVehicleToTrailer(spawnedVehicle, trailer, 1.1)
			end)
		end

		-- save & set plate
		local plate = 'WORK' .. math.random(1, 9999)
		SetVehicleNumberPlateText(spawnedVehicle, plate)
		table.insert(myPlate, plate)
		plate = string.gsub(plate, " ", "")

		TaskWarpPedIntoVehicle(playerPed, spawnedVehicle, -1)

		if vehicle.HasCaution then
			vehicleInCaseofDrop = spawnedVehicle
			vehicleObjInCaseofDrop = vehicle
			vehicleMaxHealth = GetVehicleEngineHealth(spawnedVehicle)
		end
	end)
end)

-- Show top left hint
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if hintIsShowed and hintToDisplay ~= nil then
			ESX.ShowHelpNotification(hintToDisplay)
		else
			Citizen.Wait(2000)
		end
	end
end)

local zonelisting = {}
local publiclisting = {}

-- Display markers (only if on duty and the player's job ones)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		local zones = {}
		local zcloser = false
		local coords = GetEntityCoords(PlayerPedId())
		local zzonelisting = {}
		local zpubliclisting = {}
		if PlayerData.job ~= nil then
			for k,v in pairs(Config.Jobs) do
				if PlayerData.job.name == k then
					zones = v.Zones
				end
				Wait(10)
			end

			
			for k,v in pairs(zones) do
				if onDuty or v.Type == "cloakroom" or PlayerData.job.name == "reporter" then
					if(v.Marker ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
						
						zcloser = true
						zzonelisting[k] = v
					end
				end
				Wait(50)
			end
			

		end
		for k,v in pairs(Config.PublicZones) do
			if(v.Marker ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then

				zcloser = true
				zpubliclisting[k] = v

			end
			Wait(50)
		end
		zonelisting = zzonelisting
		publiclisting = zpubliclisting
		if zcloser then

			closer = true
		else
			closer = false
			Wait(3000)
		end
		
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if closer then
				
			for k,v in pairs(zonelisting) do
					DrawMarker(v.Marker, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
			end
			for k,v in pairs(publiclisting) do
					DrawMarker(v.Marker, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
			end
		
		else
		
			Wait(2000)
		
		end
	end
end)



-- Activate public marker
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(15)
		
		if closer then
			local coords   = GetEntityCoords(PlayerPedId())
			local position = nil
			local zone     = nil

			for k,v in pairs(Config.PublicZones) do
				if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x/2 then
					isInPublicMarker = true
					position = v.Teleport
					zone = v
					break
				else
					isInPublicMarker = false
				end
			end

			if IsControlJustReleased(0, Keys['E']) and isInPublicMarker then
				ESX.Game.Teleport(PlayerPedId(), position)
				isInPublicMarker = false
			end

			-- hide or show top left zone hints
			if isInPublicMarker then
				hintToDisplay = zone.Hint
				hintIsShowed = true
			else
				if not isInMarker then
					hintToDisplay = "no hint to display"
					hintIsShowed = false
				end
			end
		else
			Wait(2000)
		end
	end
end)

-- Activate menu when player is inside marker
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(10)
		if closer or onDuty then
			if PlayerData.job ~= nil and PlayerData.job.name ~= 'unemployed' then
				local zones = nil
				local job = nil

				for k,v in pairs(Config.Jobs) do
					if PlayerData.job.name == k then
						job = v
						zones = v.Zones
					end
				end

				if zones ~= nil then
					local coords      = GetEntityCoords(PlayerPedId())
					local currentZone = nil
					local zone        = nil
					local lastZone    = nil

					for k,v in pairs(zones) do
						if GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x then
							isInMarker  = true
							currentZone = k
							zone        = v
							break
						else
							isInMarker  = false
						end
					end

					if IsControlJustReleased(0, Keys['E']) and not menuIsShowed and isInMarker then
					
					
						if onDuty or zone.Type == "cloakroom" or PlayerData.job.name == "reporter" then
							TriggerEvent('4a355f28-2101-4b30-addf-6ef84000c7d6', job, zone)
						end
					end

					-- hide or show top left zone hints
					if isInMarker and not menuIsShowed then
						hintIsShowed = true
						if (onDuty or zone.Type == "cloakroom" or PlayerData.job.name == "reporter") and zone.Type ~= "vehdelete" then
							hintToDisplay = zone.Hint
							hintIsShowed = true
						elseif zone.Type == "vehdelete" and (onDuty or PlayerData.job.name == "reporter") then
							local playerPed = PlayerPedId()

							if IsPedInAnyVehicle(playerPed, false) then
								local vehicle = GetVehiclePedIsIn(playerPed, false)
								local driverPed = GetPedInVehicleSeat(vehicle, -1)
								local plate = GetVehicleNumberPlateText(vehicle)
								plate = string.gsub(plate, " ", "")

								if playerPed == driverPed then

									for i=1, #myPlate, 1 do
										if myPlate[i] == plate then
											hintToDisplay = zone.Hint
											break
										end
									end

								else
									hintToDisplay = _U('not_your_vehicle')
								end
							else
								hintToDisplay = _U('in_vehicle')
							end
							hintIsShowed = true
						elseif onDuty and zone.Spawner ~= spawner then
							hintToDisplay = _U('wrong_point')
							hintIsShowed = true
						else
							if not isInPublicMarker then
								hintToDisplay = "no hint to display"
								hintIsShowed = false
							end
						end
					end
				
					if isInMarker and not hasAlreadyEnteredMarker then
						hasAlreadyEnteredMarker = true
					end

					if not isInMarker and hasAlreadyEnteredMarker then
						hasAlreadyEnteredMarker = false
						TriggerEvent('5159b1c3-dbdd-4f63-87af-e96d9c0dd0fd', zone)
						
					end
				end

			end
		else
			Wait(3000)
		end
	end
end)

Citizen.CreateThread(function()
	-- Slaughterer
	RemoveIpl("CS1_02_cf_offmission")
	RequestIpl("CS1_02_cf_onmission1")
	RequestIpl("CS1_02_cf_onmission2")
	RequestIpl("CS1_02_cf_onmission3")
	RequestIpl("CS1_02_cf_onmission4")

	-- Tailor
	RequestIpl("id2_14_during_door")
	RequestIpl("id2_14_during1")
end)
