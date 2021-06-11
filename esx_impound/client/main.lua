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

----------------------------------------------------------------------------------------------------
-- Variables
----------------------------------------------------------------------------------------------------

local ESX 					= nil
local PlayerData			= {}
local OwnPlayerData 		= nil
local DependenciesLoaded 	= false

local Impound 				= Config.Impound

local GuiEnabled 			= false

local VehicleAndOwner 		= nil

local ImpoundedVehicles 	= nil

local closer 				= false

impoundhold 			= false

local lastclick = 0

----------------------------------------------------------------------------------------------------
-- Setup & Initialization
----------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(500)
	end
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	DependenciesLoaded = true
	PlayerData = ESX.GetPlayerData()
end)


RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function(job)
	PlayerData.job = job
end)

local Blips = {
	{ name = _U('impound'), color = 38, id = 380, x = 872.07, y = -1350.49, z = 26.30, scale = 1.5},
	{ name = _U('pound_out'), color = 3, id = 430, x = 826.30, y = -1290.20, z = 28.60, scale = 1.5},
	
	{ name = _U('parking_uninpound'), 	color = 38, id = 267, x = 818.01, y = -1334.19, z = 26.10, scale = 0.5},
	{ name = _U('parking_uninpound'),	color = 38, id = 267, x = 818.17, y = -1341.39, z = 26.10, scale = 0.5},
	{ name = _U('parking_uninpound'), 	color = 38, id = 267, x = 818.19, y = -1348.67, z = 26.10, scale = 0.5},
	{ name = _U('parking_uninpound'), 	color = 38, id = 267, x = 818.09, y = -1355.83, z = 26.10, scale = 0.5},
	{ name = _U('parking_uninpound'), 	color = 38, id = 267, x = 817.71, y = -1363.25, z = 26.10, scale = 0.5},
}

Citizen.CreateThread(function()
	Wait(20000)
	for _, item in pairs(Blips) do
		Wait(100)
		item.blip = AddBlipForCoord(item.x, item.y, item.z)
		SetBlipSprite(item.blip, item.id)
		SetBlipColour (item.blip, item.color)
		SetBlipAsShortRange(item.blip, true)
		SetBlipScale(item.blip, item.scale)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(item.name)
		EndTextCommandSetBlipName(item.blip)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if closer == false then
			Wait(3000)
		else
			for k,v in pairs(Config.Zones) do
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
				DrawMarker(v.Type2, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color2.r, v.Color2.g, v.Color2.b, 100, false, true, 2, false, false, false, false)
			end
		
		end
	end
end)

RegisterCommand("impoundtow",function(source, args, raw)
	local mycoords = GetEntityCoords(PlayerPedId())
	local vehicle = GetClosestVehicle(mycoords, 3.8, 0, 71)
	local amIINCar = IsPedInAnyVehicle(PlayerPedId())
	if amIINCar == true then
		ESX.ShowNotification('Cannot use this from within a car')
		return
	end
	print('rpgress point 1')
	if vehicle ~= nil and vehicle ~= 0 then
		local netid = NetworkGetNetworkIdFromEntity(vehicle)
		local vehiclecoords = GetEntityCoords(vehicle)
		print('progress point 2')
		if ESX.GetPlayerData().job.name == 'police' or ESX.GetPlayerData().job.name == 'ambulance' or ESX.GetPlayerData().job.name == 'wilson' then
			print('rpgress 3')
			print(netid)
			print(GetVehicleNumberPlateText(vehicle))
			PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
			ESX.TriggerServerCallback('b80668cf-fc70-44cc-bac1-2e65735defb1', function(notlogged)
				if notlogged == false then
					lastcallvector = vehiclecoords
					PlayerCoords = GetEntityCoords(vehicle, true)
					x1, y1, z1 = table.unpack( PlayerCoords )
					PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
					Wait(80)
					PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
					TriggerServerEvent('c916860b-b2ca-42eb-9eac-cf20b6341eac', 'mecano', 'Emergency Service Tow Request Plate: ' .. GetVehicleNumberPlateText(vehicle), PlayerCoords, {

						PlayerCoords = { x = x1, y = y1, z = z1 },
					})
				end
			end, netid,GetVehicleNumberPlateText(vehicle),vehiclecoords)
		end
	end
end,false)

----------------------------------------------------------------------------------------------------
-- Helper functions
----------------------------------------------------------------------------------------------------

function ShowHelpNotification(text)
	ClearAllHelpMessages()
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, false, true, 5000)
end

RegisterNetEvent('c96165cd-ffa7-4593-bfa1-58e430c58a12')
AddEventHandler('c96165cd-ffa7-4593-bfa1-58e430c58a12', function (playerData)
	OwnPlayerData = playerData
end)

RegisterNetEvent('f0352f4e-655d-409f-b2c9-d621a1b45c67')
AddEventHandler('f0352f4e-655d-409f-b2c9-d621a1b45c67', function (vehicleAndOwner)
	VehicleAndOwner = vehicleAndOwner
end)

RegisterNetEvent('b6eb8c2d-fdf4-4489-b889-e17e77b5fb75')
AddEventHandler('b6eb8c2d-fdf4-4489-b889-e17e77b5fb75', function (impoundedVehicles)
	print('impound vehicles received')
	ImpoundedVehicles = impoundedVehicles
end)

RegisterNetEvent('e1e88cda-3974-4886-bb70-c571fc40cec7')
AddEventHandler('e1e88cda-3974-4886-bb70-c571fc40cec7', function (data, index)

	if impoundhold == false then
		impoundhold = true
		local spawnLocationIndex = index % 3 + 1
		local localVehicle = json.decode(data.vh)
		-- print(localVehicle.health)
		print('spawn vehicle')
		print(localVehicle.model)
		print(json.encode(Impound.SpawnLocations[spawnLocationIndex]))
		
	ESX.Game.SpawnVehicle(localVehicle.model, {
		x = Impound.SpawnLocations[spawnLocationIndex].Pos.x ,
		y = Impound.SpawnLocations[spawnLocationIndex].Pos.y,
		z = Impound.SpawnLocations[spawnLocationIndex].Pos.z											
		},Impound.SpawnLocations[spawnLocationIndex].h, function(callback_vehicle)
		ESX.Game.SetVehicleProperties(callback_vehicle, localVehicle)
		--TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
		 local platep = localVehicle.plate
		  TriggerEvent('6e50bab1-3501-471a-9782-c68e8214c3e1',platep)
		  Citizen.InvokeNative(0x51BB2D88D31A914B, callback_vehicle, true)
		
		end)
		
		ESX.ShowNotification("~w~Your ~g~vehicle~w~ with the plate: " .. data.plate .. " has been ~g~unimpounded!")
		SetNewWaypoint(Impound.SpawnLocations[spawnLocationIndex].x, Impound.SpawnLocations[spawnLocationIndex].y)
		
		Citizen.CreateThread(function ()
			Wait(15000)
			impoundhold = false
		end)
	end
end)

RegisterNetEvent('59e01cc0-3ef6-4ec2-8e33-e4802530a83f')
AddEventHandler('59e01cc0-3ef6-4ec2-8e33-e4802530a83f', function ()
	ESX.ShowNotification(_U('unimpound_no_cash'))
end)

RegisterNetEvent('5eab9683-d878-4a57-912f-cc45bb45d1c5')
AddEventHandler('5eab9683-d878-4a57-912f-cc45bb45d1c5', function ()
	ShowImpoundMenu("store")
end)

----------------------------------------------------------------------------------------------------
-- NUI bs
----------------------------------------------------------------------------------------------------

function ShowImpoundMenu (action)
	
	local pos = GetEntityCoords(GetPlayerPed(PlayerId()))
	local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 5.0, 0, 71)
	local vehiclen = NetworkGetNetworkIdFromEntity(vehicle)
	
	if (IsPedInAnyVehicle(GetPlayerPed(PlayerId()))) then
		ESX.ShowNotification(_U('leave_vehicle'))
		return
	end
	
	
	if (vehicle ~= nil) then
		local v = ESX.Game.GetVehicleProperties(vehicle)
		local data = {}
		ESX.ShowNotification('Loading ~b~menu~w~ please wait...')
		TriggerServerEvent('d9582498-bc2f-4af5-ba08-11c1dc5b733a', PlayerData.identifier)
		TriggerServerEvent('1cbc9f1d-05e3-449a-8d7a-0e1bdf7564ad', v.plate, vehiclen)
		Citizen.Wait(2500)
		
		if (Config.NoPlateColumn == true) then
			Citizen.Wait(Config.WaitTime)
		end
		
		if(VehicleAndOwner == nil) then
			ESX.ShowNotification(_U('unknow_owner'))
				local localVehId = vehicle
				NetworkRequestControlOfEntity(localVehId)
				local ttajmer = 0
				while not NetworkHasControlOfEntity(localVehId) and ttajmer < 70 do
					Citizen.Wait(1)
					NetworkRequestControlOfEntity(localVehId)
					ttajmer = ttajmer + 1
				end
			ESX.Game.DeleteVehicle(vehicle)
			Wait(1000)
			if DoesEntityExist(vehicle) then
				TriggerServerEvent('b895d2f8-43cb-48e6-ab1c-be49f69d8866',NetworkGetNetworkIdFromEntity(vehicle))
			end
			return
		end
		
		data.action = "open"
		data.form 	= "impound"
		data.rules = Config.Rules
		data.vehicle = {
			plate = VehicleAndOwner.plate,
			owner = VehicleAndOwner.firstname .. ' ' .. VehicleAndOwner.lastname
		}
		
		if (PlayerData.job.name == 'police') then
			data.officer = OwnPlayerData.firstname .. ' ' .. OwnPlayerData.lastname
			GuiEnabled = true
			SetNuiFocus(true, true)
			SendNuiMessage(json.encode(data))
		end
		
		if (PlayerData.job.name == 'mecano') then
			data.mechanic = OwnPlayerData.firstname .. ' ' .. OwnPlayerData.lastname
			GuiEnabled = true
			SetNuiFocus(true, true)
			SendNuiMessage(json.encode(data))
		end
		inZone = true
	
	else
		ESX.ShowNotification(_U('vehicle_nearby'))
	end

end

function ShowAdminTerminal ()
	PlayerData = ESX.GetPlayerData()
	GuiEnabled = true
	ESX.ShowNotification('Loading ~b~menu~w~ please wait...')
	TriggerServerEvent('7c5d141e-db37-4dc8-a136-16c16d0110b5')
	Citizen.Wait(3500)
	
	SetNuiFocus(true, true)
	local data = {
		action = "open",
		form = "admin",
		user = OwnPlayerData,
		job = PlayerData.job,
		vehicles = ImpoundedVehicles
	}
	
	SendNuiMessage(json.encode(data))
end

function DisableImpoundMenu()
	GuiEnabled = false
	SetNuiFocus(false)
	SendNuiMessage("{\"action\": \"close\", \"form\": \"none\"}")
	OwnPlayerData = nil
	VehicleAndOwner = nil
	ImpoundedVehicles = nil
	ImpoundInstructions = nil
end

function ShowRetrievalMenuc ()
	print('menu access to get car')
	PlayerData = ESX.GetPlayerData()
	
	TriggerServerEvent('d9582498-bc2f-4af5-ba08-11c1dc5b733a', PlayerData.identifier)
	TriggerServerEvent('8ff8bbe3-4dc8-4e16-aa99-496f9eb68138', PlayerData.identifier)
	Citizen.Wait(2500)
	ESX.ShowNotification('Retrieving Vehicle Listing...')
	print('running for ground')
	GuiEnabled = true
	SetNuiFocus(true, true)
	local cmoney = 0
	
	if cmoney ~= nil then
		cmoney = PlayerData.money
	end
	print('cmoney')
	print(cmoney)
	local data = {
		action = "open",
		form = "retrieve",
		
		user = OwnPlayerData,
		money = tonumber(cmoney),
		job = PlayerData.job,
		vehicles = ImpoundedVehicles
	}
	
	--SendNuiMessage(json.encode(data))
	CurrentAction = nil
end

RegisterNUICallback('escape', function(data, cb)
	DisableImpoundMenu()
	CurrentAction = nil
	inZone = false
	-- cb('ok')
end)


--[[
RegisterNUICallback('impound', function(data, cb)

	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	local v = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
	-- print(v)

	local veh = ESX.Game.GetVehicleProperties(v)
	-- print(veh)

	
	veh.engineHealth = GetVehicleEngineHealth(v)
	veh.bodyHealth = GetVehicleBodyHealth(v)
	veh.fuelLevel = GetVehicleFuelLevel(v)
	veh.oilLevel = GetVehicleOilLevel(v)
	veh.petrolTankHealth = GetVehiclePetrolTankHealth(v)
	veh.tyresburst = {}
	for i = 1, 7 do
		res = IsVehicleTyreBurst(v, i, false)
		if res ~= nil then
			veh.tyresburst[#veh.tyresburst+1] = res
			if res == false then
				res = IsVehicleTyreBurst(v, i, true)
				veh.tyresburst[#veh.tyresburst] = res
			end
		else
			veh.tyresburst[#veh.tyresburst+1] = false
		end
	end
	
	veh.windows = {}
	for i = 1, 13 do
		res = IsVehicleWindowIntact(v, i)
		if res ~= nil then
			veh.windows[#veh.windows+1] = res
		else
			veh.windows[#veh.windows+1] = true
		end
	end
	
	if (veh.plate:gsub("%s+", "") ~= data.plate:gsub("%s+", "")) then
		ESX.ShowNotification(_U('vehicle_plate_error'))
		return
	end
	
	data.vehicle = veh;
	data.identifier = VehicleAndOwner.identifier;
	CurrentAction = nil
	TriggerServerEvent('6c61e846-a6d5-4701-9a34-af362dfae0d8', data)
	local localVehId = v
	NetworkRequestControlOfEntity(localVehId)
	local ttajmer = 0
	while not NetworkHasControlOfEntity(localVehId) and ttajmer < 70 do
		Citizen.Wait(1)
		ttajmer = ttajmer + 1
	end
	if DoesEntityExist(v) then
		ESX.Game.DeleteVehicle(localVehId)
	end
	DisableImpoundMenu()
	CurrentAction = nil
	inZone = false
	-- cb('ok')
end)--]]


--[[
RegisterNUICallback('unimpound', function(plate, cb)
	Citizen.Trace("Unimpounding:" .. plate)
	TriggerServerEvent('ebfceb9d-7fd1-49df-9886-fb0804c69d4c', plate)
	DisableImpoundMenu()
	CurrentAction = nil
	-- cb('ok')
end)--]]

RegisterNUICallback('unimpoundp', function(plate, cb)
	Citizen.Trace("Unimpounding:" .. plate)
	TriggerServerEvent('a3000425-6280-432c-ae1d-c996e7706de5', plate)
	DisableImpoundMenu()
	CurrentAction = nil
	-- cb('ok')
end)

RegisterNUICallback('unlock', function(plate, cb)
	TriggerServerEvent('8bbbb6c8-5f74-4071-bda0-5decadbb0000', plate)
end)
----------------------------------------------------------------------------------------------------
-- Background tasks
----------------------------------------------------------------------------------------------------

-- Decide what the player is currently doing and showing a help notification.

-- Decide what the player is currently doing and showing a help notification.
Citizen.CreateThread(function ()
	
	while true do
		inZone = false
		Citizen.Wait(500)
	
		if (DependenciesLoaded) then
			local PlayerPed = GetPlayerPed(PlayerId())
			local PlayerPedCoords = GetEntityCoords(PlayerPed)
			
			local coords    = GetEntityCoords(PlayerPed)

			local closestVehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
			
			if (GetDistanceBetweenCoords(Impound.RetrieveLocation.x, Impound.RetrieveLocation.y, Impound.RetrieveLocation.z,
			PlayerPedCoords.x, PlayerPedCoords.y, PlayerPedCoords.z, false) < 3) then
				
				inZone = true
				
				if (CurrentAction ~= nil and CurrentAction ~= "retrieve") then
					
					CurrentAction = "retrieve"
					ESX.ShowHelpNotification(_U('take_out_vehicle'))
					
				end
				
			elseif (GetDistanceBetweenCoords(Impound.StoreLocation.x, Impound.StoreLocation.y, Impound.StoreLocation.z,
			PlayerPedCoords.x, PlayerPedCoords.y, PlayerPedCoords.z, false) < 3) then
				
				inZone = true
				
				if (CurrentAction ~= nil and CurrentAction ~= "store" and (PlayerData.job.name == "police" or PlayerData.job.name == "mecano")) then
					CurrentAction = "store"
					if (IsPedInAnyVehicle(PlayerPed)) then
						ESX.ShowHelpNotification(_U('leave_vehicle_for_impound'))
							
					else
						if IsPedOnFoot(PlayerPed) and closestVehicle ~= 0 then
							ESX.ShowHelpNotification(_U('impound_vehicle'))
							
						end
					end

				end
				
			else
				for i, location in ipairs(Impound.AdminTerminalLocations) do
					if (GetDistanceBetweenCoords(location.x, location.y, location.z,
					PlayerPedCoords.x, PlayerPedCoords.y, PlayerPedCoords.z, false) < 3) then
						
						inZone = true
						
						if (CurrentAction ~= nil and CurrentAction ~= "admin" and (PlayerData.job.name == "police" and PlayerData.job.grade >= 6)) then
							
							CurrentAction = "admin"
							ESX.ShowHelpNotification(_U('impound_terminal'))
						end
						
						
					end
				end
			end
		end
		
		if inZone == false then
			CurrentAction = nil
		end
	end
end)


RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function(job)
	ESX.PlayerData = ESX.GetPlayerData()
	PlayerData = ESX.PlayerData
	
end)

local Blips = {
	{ name = _U('impound'), color = 38, id = 380, x = 872.07, y = -1350.49, z = 26.30, scale = 1.5},
	{ name = _U('pound_out'), color = 3, id = 430, x = 826.30, y = -1290.20, z = 28.60, scale = 1.5},
	
	{ name = _U('parking_uninpound'), 	color = 38, id = 267, x = 818.01, y = -1334.19, z = 26.10, scale = 0.5},
	{ name = _U('parking_uninpound'),	color = 38, id = 267, x = 818.17, y = -1341.39, z = 26.10, scale = 0.5},
	{ name = _U('parking_uninpound'), 	color = 38, id = 267, x = 818.19, y = -1348.67, z = 26.10, scale = 0.5},
	{ name = _U('parking_uninpound'), 	color = 38, id = 267, x = 818.09, y = -1355.83, z = 26.10, scale = 0.5},
	{ name = _U('parking_uninpound'), 	color = 38, id = 267, x = 817.71, y = -1363.25, z = 26.10, scale = 0.5},
}

Citizen.CreateThread(function()
	for _, item in pairs(Blips) do
		item.blip = AddBlipForCoord(item.x, item.y, item.z)
		SetBlipSprite(item.blip, item.id)
		SetBlipColour (item.blip, item.color)
		SetBlipAsShortRange(item.blip, true)
		SetBlipScale(item.blip, item.scale)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(item.name)
		EndTextCommandSetBlipName(item.blip)
	end
end)



----------------------------------------------------------------------------------------------------
-- Helper functions
----------------------------------------------------------------------------------------------------

function ShowHelpNotification(text)
	ClearAllHelpMessages()
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, false, true, 5000)
end

RegisterNetEvent('c96165cd-ffa7-4593-bfa1-58e430c58a12')
AddEventHandler('c96165cd-ffa7-4593-bfa1-58e430c58a12', function (playerData)
	OwnPlayerData = playerData
end)

RegisterNetEvent('f0352f4e-655d-409f-b2c9-d621a1b45c67')
AddEventHandler('f0352f4e-655d-409f-b2c9-d621a1b45c67', function (vehicleAndOwner,otherInstructions)
	VehicleAndOwner = vehicleAndOwner
	ImpoundInstructions = otherInstructions
end)

RegisterNetEvent('b6eb8c2d-fdf4-4489-b889-e17e77b5fb75')
AddEventHandler('b6eb8c2d-fdf4-4489-b889-e17e77b5fb75', function (impoundedVehicles)
	print('impound vehicles received')
	ImpoundedVehicles = impoundedVehicles
end)



RegisterNetEvent('59e01cc0-3ef6-4ec2-8e33-e4802530a83f')
AddEventHandler('59e01cc0-3ef6-4ec2-8e33-e4802530a83f', function ()
	ESX.ShowNotification(_U('unimpound_no_cash'))
end)

RegisterNetEvent('5eab9683-d878-4a57-912f-cc45bb45d1c5')
AddEventHandler('5eab9683-d878-4a57-912f-cc45bb45d1c5', function ()
	ShowImpoundMenu("store")
end)

----------------------------------------------------------------------------------------------------
-- NUI bs
----------------------------------------------------------------------------------------------------

function ShowImpoundMenu (action)
	CurrentAction = nil
	
	if (GetGameTimer() - 2500) > lastclick then
		lastclick = GetGameTimer()
		local pos = GetEntityCoords(GetPlayerPed(PlayerId()))
		local vehicle = GetClosestVehicle(pos.x, pos.y, pos.z, 5.0, 0, 71)
		local vehiclen = NetworkGetNetworkIdFromEntity(vehicle)
		
		if (IsPedInAnyVehicle(GetPlayerPed(PlayerId()))) then
			ESX.ShowNotification(_U('leave_vehicle'))
			return
		end
		
		
		if (vehicle ~= nil) then
			local v = ESX.Game.GetVehicleProperties(vehicle)
			local data = {}
			ESX.ShowNotification('Loading ~b~menu~w~ please wait...')
			TriggerServerEvent('d9582498-bc2f-4af5-ba08-11c1dc5b733a', PlayerData.identifier)
			TriggerServerEvent('1cbc9f1d-05e3-449a-8d7a-0e1bdf7564ad', v.plate,vehiclen)
			Citizen.Wait(2000)
			
			if (Config.NoPlateColumn == true) then
				Citizen.Wait(Config.WaitTime)
			end
				
			if(VehicleAndOwner == nil) then
			
				local localVehId = vehicle
				NetworkRequestControlOfEntity(localVehId)
				local ttajmer = 0
				while not NetworkHasControlOfEntity(localVehId) and ttajmer < 70 do
					Citizen.Wait(1)
					ttajmer = ttajmer + 1
				end
				ESX.ShowNotification(_U('unknow_owner'))
				
				if GetVehicleClass(localVehId) ~= 18 then
					ESX.Game.DeleteVehicle(localVehId)
				end
				return
			end
			
			data.action = "open"
			data.form 	= "impound"
			data.rules = Config.Rules
			data.vehicle = {
				plate = VehicleAndOwner.plate,
				owner = VehicleAndOwner.firstname .. ' ' .. VehicleAndOwner.lastname
			}
			
			if (PlayerData.job.name == 'police') then
				data.officer = OwnPlayerData.firstname .. ' ' .. OwnPlayerData.lastname
				GuiEnabled = true
				SetNuiFocus(true, true)
				SendNuiMessage(json.encode(data))
			end
			
			if (PlayerData.job.name == 'mecano') then
				data.mechanic = OwnPlayerData.firstname .. ' ' .. OwnPlayerData.lastname
				GuiEnabled = true
				SetNuiFocus(true, true)
				SendNuiMessage(json.encode(data))
			end
		else
			ESX.ShowNotification(_U('vehicle_nearby'))
		end
	end
	
end

function ShowAdminTerminal ()
	if (GetGameTimer() - 2500) > lastclick then
		lastclick = GetGameTimer()
		PlayerData = ESX.GetPlayerData()
		GuiEnabled = true
		ESX.ShowNotification('Loading ~b~menu~w~ please wait...')
		TriggerServerEvent('7c5d141e-db37-4dc8-a136-16c16d0110b5')
		Citizen.Wait(4500)
		
		SetNuiFocus(true, true)
		local data = {
			action = "open",
			form = "admin",
			user = OwnPlayerData,
			job = PlayerData.job,
			vehicles = ImpoundedVehicles
		}
		
		SendNuiMessage(json.encode(data))
	end
end

function DisableImpoundMenu ()
	GuiEnabled = false
	SetNuiFocus(false)
	SendNuiMessage("{\"action\": \"close\", \"form\": \"none\"}")
	OwnPlayerData = nil
	VehicleAndOwner = nil
	ImpoundedVehicles = nil
	
end

function ShowRetrievalMenu ()
	
	if (GetGameTimer() - 2500) > lastclick then
		lastclick = GetGameTimer()
		PlayerData = ESX.GetPlayerData()
		
		TriggerServerEvent('d9582498-bc2f-4af5-ba08-11c1dc5b733a', PlayerData.identifier)
		TriggerServerEvent('8ff8bbe3-4dc8-4e16-aa99-496f9eb68138', PlayerData.identifier)
		Citizen.Wait(2500)
		local cmoney = 0
		
		if cmoney ~= nil then
			cmoney = PlayerData.money
		end

		GuiEnabled = true
		SetNuiFocus(true, true)
		local data = {
			action = "open",
			form = "retrieve",
			money = tonumber(cmoney),
			user = OwnPlayerData,
			job = PlayerData.job,
			vehicles = ImpoundedVehicles
		}
		
		SendNuiMessage(json.encode(data))
		CurrentAction = nil
	end
end

RegisterNUICallback('escape', function(data, cb)
	DisableImpoundMenu()
	CurrentAction = nil
	-- cb('ok')
end)




RegisterNUICallback('impound', function(data, cb)
	if (GetGameTimer() - 2500) > lastclick then
		lastclick = GetGameTimer()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	local v = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
	-- print(v)
	local netid = NetworkGetNetworkIdFromEntity(v)
	local vehiclecoords = GetEntityCoords(v)
	local numplate = GetVehicleNumberPlateText(v)
	local veh = ESX.Game.GetVehicleProperties(v)
	
	-- print(veh)

	
	veh.engineHealth = GetVehicleEngineHealth(v)
	veh.bodyHealth = GetVehicleBodyHealth(v)
	veh.fuelLevel = GetVehicleFuelLevel(v)
	veh.oilLevel = GetVehicleOilLevel(v)
	veh.petrolTankHealth = GetVehiclePetrolTankHealth(v)
	veh.tyresburst = {}
	for i = 1, 7 do
		res = IsVehicleTyreBurst(v, i, false)
		if res ~= nil then
			veh.tyresburst[#veh.tyresburst+1] = res
			if res == false then
				res = IsVehicleTyreBurst(v, i, true)
				veh.tyresburst[#veh.tyresburst] = res
			end
		else
			veh.tyresburst[#veh.tyresburst+1] = false
		end
	end
	
	veh.windows = {}
	for i = 1, 13 do
		res = IsVehicleWindowIntact(v, i)
		if res ~= nil then
			veh.windows[#veh.windows+1] = res
		else
			veh.windows[#veh.windows+1] = true
		end
	end
	
	if veh ~= nil and veh.plate ~= nil and data.plate ~= nil then
		if (veh.plate:gsub("%s+", "") ~= data.plate:gsub("%s+", "")) then
			ESX.ShowNotification(_U('vehicle_plate_error'))
			return
		end
	else
		return
	end
	
	data.vehicle = veh;
	data.identifier = VehicleAndOwner.identifier;
	
	TriggerServerEvent('6c61e846-a6d5-4701-9a34-af362dfae0d8', data,numplate, netid)
	
	local localVehId = ESX.Game.GetClosestVehicle()
	NetworkRequestControlOfEntity(localVehId)
	local ttajmer = 0
	while not NetworkHasControlOfEntity(localVehId) and ttajmer < 70 do
		Citizen.Wait(1)
		NetworkRequestControlOfEntity(localVehId)
		ttajmer = ttajmer + 1
	end
	if GetVehicleClass(localVehId) ~= 18 then
		ESX.Game.DeleteVehicle(localVehId)
	end
	Wait(1000)
	if DoesEntityExist(localVehId) then
		TriggerServerEvent('b895d2f8-43cb-48e6-ab1c-be49f69d8866',NetworkGetNetworkIdFromEntity(localVehId))
	end
	
	DisableImpoundMenu()
	CurrentAction = nil
	end
	-- cb('ok')
end)
local unimpound = 0

RegisterNUICallback('unimpound', function(plate, cb)
	print ('impound')
	if unimpound < GetGameTimer() - 5000 then
		unimpound = GetGameTimer()
		Citizen.Trace("Unimpounding:" .. plate)
		TriggerServerEvent('ebfceb9d-7fd1-49df-9886-fb0804c69d4c', plate)
		DisableImpoundMenu()
		CurrentAction = nil
	end
	-- cb('ok')
end)

RegisterNUICallback('unimpoundp', function(plate, cb)
	print ('impound p')
	if unimpound > GetGameTimer() - 5000 then
		unimpound = GetGameTimer()
		Citizen.Trace("Unimpounding:" .. plate)
		TriggerServerEvent('a3000425-6280-432c-ae1d-c996e7706de5', plate)
		DisableImpoundMenu()
		CurrentAction = nil
	end
	-- cb('ok')
end)

RegisterNUICallback('unlock', function(plate, cb)
	if (GetGameTimer() - 2500) > lastclick then
		lastclick = GetGameTimer()
		TriggerServerEvent('8bbbb6c8-5f74-4071-bda0-5decadbb0000', plate)
	end
end)
----------------------------------------------------------------------------------------------------
-- Background tasks
----------------------------------------------------------------------------------------------------

-- Decide what the player is currently doing and showing a help notification.
Citizen.CreateThread(function ()
	
	while true do
		local zinZone = false
		Citizen.Wait(2000)
		if (DependenciesLoaded) then
			local PlayerPed = PlayerPedId()
			local PlayerPedCoords = GetEntityCoords(PlayerPed)
			
			local coords    = GetEntityCoords(PlayerPed)

			local closestVehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
			
			local impoundd = #(vector3(Impound.RetrieveLocation.x, Impound.RetrieveLocation.y, Impound.RetrieveLocation.z) - PlayerPedCoords)
			local stored = #(vector3(Impound.StoreLocation.x, Impound.StoreLocation.y, Impound.StoreLocation.z) - PlayerPedCoords)
			local impound_sandy = #(vector3(1724.1207275391,3318.5803222656,41.828262329102) - PlayerPedCoords)

			if ( impoundd < 3) then
				
				zinZone = true
				
				if (CurrentAction ~= "retrieve") then
					
					CurrentAction = "retrieve"
					ESX.ShowHelpNotification(_U('take_out_vehicle'))
					
				end
				
				
			elseif (stored < 3 or impound_sandy < 3) then
				
				zinZone = true
				
				if (CurrentAction ~= "store" and (PlayerData.job.name == "police" or PlayerData.job.name == "mecano")) then
					CurrentAction = "store"
					if (IsPedInAnyVehicle(PlayerPed)) then
						ESX.ShowHelpNotification(_U('leave_vehicle_for_impound'))
						
					else
						if IsPedOnFoot(PlayerPed) and closestVehicle ~= 0 then
							ESX.ShowHelpNotification(_U('impound_vehicle'))
							
						end
					end

				end
				
			else
				for i, location in ipairs(Impound.AdminTerminalLocations) do
					if (#(location - PlayerPedCoords) < 3) then
						
						zinZone = true
						
						if (CurrentAction ~= "admin" and (PlayerData.job.name == "police" and PlayerData.job.grade >= 6)) then
							
							CurrentAction = "admin"
							ESX.ShowHelpNotification(_U('impound_terminal'))
						end
						
						break
					end
				end
			end
			
			if impoundd < 30 then
				closer = true
				if zinZone == true then
					inZone = true
				else
					inZone = false
				end
			elseif impound_sandy < 30 then
				closer = true
				if zinZone == true then
					inZone = true
				else
					inZone = false
				end
				
			elseif stored < 30 then
				closer = true
				if zinZone == true then
					inZone = true
				else
					inZone = false
				end
			elseif zinZone == true then
				closer = true
				inZone = true
			else
				closer = false
				Wait(1000)
			end
			

		
		end
		

		if not inZone then
			CurrentAction = nil
		end
	end
end)

Citizen.CreateThread(function ()
	
	while true do
		Citizen.Wait(0)
		if closer == true then
			if (IsControlJustReleased(0, 38)) then

				if (CurrentAction == "retrieve") then
					ShowRetrievalMenu()
				elseif (CurrentAction == "store") then
					ShowImpoundMenu("store")
				elseif (CurrentAction == "admin") then
					ShowAdminTerminal("admin")
				end
			end
		else 
			Wait(2000)
		end
	end
end)

-- Disable background actions if the player is currently in a menu
Citizen.CreateThread(function()
	while true do
		if GuiEnabled then
			local ply = PlayerPedId() 
			local active = true
			DisableControlAction(0, 1, active) -- LookLeftRight
			DisableControlAction(0, 2, active) -- LookUpDown
			DisableControlAction(0, 24, active) -- Attack
			DisablePlayerFiring(ply, true) -- Disable weapon firing
			DisableControlAction(0, 142, active) -- MeleeAttackAlternate
			DisableControlAction(0, 106, active) -- VehicleMouseControlOverride
			if IsDisabledControlJustReleased(0, 24) or IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
				SendNUIMessage(
					{
						type = "click"
					}
				)
			end
		else
			Wait(1000)
		end
		Citizen.Wait(0)
	end
end)

function dump(o)
	if type(o) == 'table' then
		local s = '{ '
			for k,v in pairs(o) do
				if type(k) ~= 'number' then k = '"'..k..'"' end
				s = s .. '['..k..'] = ' .. dump(v) .. ','
			end
		return s .. '} '
	else
		return tostring(o)
	end
end