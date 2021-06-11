local pedIsNearMenuBlip = false
local pedIsNearImpoundBlip = false
local pedIsInVehicleAndNearReturn = false
local impoundedVehicles = {}
local inRange = false
local inclickRange = false
local style = { --WarMenu styling 
    x = 0.650,
    y = 0.025,
    maxOptionCountOnScreen = 16,
	width = 0.26,
    titleBackgroundColor = { 0, 0, 0, 200},
    backgroundColor = { 0, 0, 0, 200},
    subTitleBackgroundColor = {0, 0, 0, 200},

    titleColor = {19, 175, 214, 255},
    subTitleColor = {19, 175, 214, 255},

    focusTextColor = { 0, 0, 0, 255 },
	focusColor = { 19, 175, 214, 255 },
}

local style2 = { --WarMenu styling 
    x = 0.650,
    y = 0.025,
    maxOptionCountOnScreen = 16,
	width = 0.26,

    titleBackgroundColor = { 0, 0, 0, 200},
    backgroundColor = { 0, 0, 0, 200},
    subTitleBackgroundColor = {0, 0, 0, 200},

    titleColor = {250, 186, 37, 255},
    subTitleColor = {250, 186, 37, 255},

    focusTextColor = { 0, 0, 0, 255 },
	focusColor = { 250, 186, 37, 255 },
}

WarMenu.CreateMenu('garageMenu', 'Garage')
WarMenu.CreateMenu('impoundMenu', 'Insurance')

PlayerData = {}
ESX = nil

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(0)
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(PlayerData)
    PlayerData = xPlayer
end)

--Garage blips and data gathering
Citizen.CreateThread(function()
    GarageBlips()
    ImpoundBlips()
    while true do
        Citizen.Wait(1000)
        playerPed = PlayerPedId()
        playerCoords = GetEntityCoords(playerPed)
        isPedInVehicle = IsPedInAnyVehicle(playerPed, false)

        GaragePlayerDistanceCheck()
        ImpoundPlayerDistanceCheck()
    end
end)

--Marker and text drawing
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
		if inRange then
			if pedIsNearMenuBlip and not isPedInVehicle and not inMenu then
				DrawHelpText(currentMarker.x, currentMarker.y, currentMarker.z, '~b~E~w~ - Open Garage')
				DrawMarker(1, currentMarker.x, currentMarker.y, currentMarker.z-1, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 0.5, 19, 175, 214, 155, false, false, 0, 0)
			elseif pedIsInVehicleAndNearReturn then
				DrawHelpText(currentMarker.x, currentMarker.y, currentMarker.z, '~r~E~w~ - Return Vehicle')
				DrawMarker(1, currentMarker.x, currentMarker.y, currentMarker.z-1, 0, 0, 0, 0, 0, 0, 2.5, 2.5, 0.5, 230, 34, 28, 155, false, false, 0, 0)
			elseif pedIsNearImpoundBlip and not inMenu then
				DrawHelpText(currentImpoundMarker.x, currentImpoundMarker.y, currentImpoundMarker.z, '~y~E~w~ - Insurance')
				DrawMarker(1, currentImpoundMarker.x, currentImpoundMarker.y, currentImpoundMarker.z-1, 0, 0, 0, 0, 0, 0, 1.5, 1.5, 0.5, 250, 186, 37, 155, false, false, 0, 0)
			else
				Wait(500)
			end
		else
			Wait(1000)
		end
    end
end)

--Input detection for markers 

local cool_down = 0
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
		if inRange then
			if inRange and inclickRange == true and pedIsNearMenuBlip then
				if IsControlJustReleased(0, 51)  then
					if cool_down < GetGameTimer() - 4000 then
						cool_down = GetGameTimer()
						TriggerEvent('luke_vehiclegarage:GarageMenu')
					else
						ESX.ShowNotification('Cannot access garage menu so quickly!')
					end
				end
			elseif inRange and inclickRange == true and pedIsNearImpoundBlip then
				if IsControlJustReleased(0, 51) then
					if cool_down < GetGameTimer() - 4000 then
						cool_down = GetGameTimer()
						TriggerEvent('luke_vehiclegarage:ImpoundMenu')
					else
						ESX.ShowNotification('Cannot access impound menu so quickly!')
					end
				end

			end
			if inRange and inclickRange == true and pedIsInVehicleAndNearReturn then
				if IsControlJustReleased(0, 51) and cool_down < GetGameTimer() - 3000 then
					cool_down = GetGameTimer()
					local vehicle = GetVehiclePedIsIn(playerPed, false)
					StoreVehicle(vehicle)
				end
			end
		else
			Wait(1000)
		end
    end
end)

--Garage menu 
RegisterNetEvent('luke_vehiclegarage:GarageMenu')
AddEventHandler('luke_vehiclegarage:GarageMenu', function(zone)
    WarMenu.SetMenuStyle('garageMenu', style)
    WarMenu.SetMenuSubTitle('garageMenu', currentName)

    if WarMenu.IsAnyMenuOpened() then
        return
    end

    WarMenu.OpenMenu('garageMenu')
    inMenu = true
    local isStored
    if currentType == 'car' then
        ESX.TriggerServerCallback('luke_vehiclegarage:FetchOwnedCarsSmall', function(ownedCars)
		if data ~= nil and data[1] ~= nil and data[1].pDmvLicenceSuspended ~= nil and data[1].pDmvLicenceSuspended == 1 then

			exports["esx_newweaponshop"]:ShowMPMessage("~o~Licence Suspended", "~b~POLICE~w~ have ~o~suspended~w~ your licence and have taken your car keys. \n\n You will either need to wait out the day suspension period or take the matter to court.\n\n~r~Warning: ~w~It is an offence to drive on a suspended licence. Your licence may have also been disqualified and cancelled.", 20000)
			ESX.ShowNotification("~b~Police Licence Suspension~w~\nPolice have suspended your drivers licence.")
			ESX.ShowNotification("You are ~r~unable~w~ to access your vehicles until your licence is ~o~unsuspended..")
			Wait(3000)
			ESX.ShowNotification("Licences are automatically unsuspended the following day.")
			return
		end
            while true do
                Citizen.Wait(0)
                MenuRangeCheck()
                if WarMenu.Begin('garageMenu') then
                    for k, v in pairs(ownedCars) do
				
						if v.garagezone == currentZone then
							local vehicle = v.vehicle
							
							if v.pimp > 0 then
								stored = '👮🚛  '
								isStored = false
							elseif v.state == true then
								stored = '✅ '
								isStored = true
							else
								stored = '⛔ '
								isStored = false
							end
							local vehicleHash = tonumber(v.modcar)
						
							
							local vehicleName = GetDisplayNameFromVehicleModel(vehicleHash)
							local vehicleLabel = v.model
							if vehicleLabel == "Unknown" then
								vehicleLabel = GetDisplayNameFromVehicleModel(vehicleHash)
							end
							if vehicleLabel == "CARNOTFOUND" then
								vehicleLabel = "Unknown"
							end
							if IsModelInCdimage(vehicleHash) == false then
								vehicleLabel = "CAR_NOT_EXIST " .. v.modcar
							end
							
							local menuButton = WarMenu.Button(stored .. vehicleLabel .. '~o~ [~b~' .. v.plate .. '~o~]')
							if menuButton then
								if isStored then
									ESX.TriggerServerCallback('luke_vehiclegarage:FetchOwnedCarIndividual', function(vehicle)
										VehicleCheckAndSpawn(vehicle[1].vehicle)
									end,v.plate)
									WarMenu.CloseMenu()
								else
									ESX.ShowNotification('Vehicle is not in the garage.')
								end
							end
						end
                    end
                    WarMenu.End()
                else
                    inMenu = false
                    return
                end
            end
        end,currentZone)
    elseif currentType == 'boat' then
        ESX.TriggerServerCallback('luke_vehiclegarage:FetchOwnedBoats', function(ownedBoats)
            while true do
                Citizen.Wait(0)
                MenuRangeCheck()
                if WarMenu.Begin('garageMenu') then
                    for k, v in pairs(ownedBoats) do
                        local vehicle = v.vehicle
                        if v.stored == 1 then
                            stored = ' - ~g~In Garage'
                            isStored = true
                        else
                            stored = ' - ~r~Out'
                            isStored = false
                        end
                        local vehicleHash = v.vehicle.model
                        local vehicleName = GetDisplayNameFromVehicleModel(vehicleHash)
                        local vehicleLabel = GetLabelText(vehicleName)
                        local menuButton = WarMenu.Button(vehicleLabel..stored)
                        if menuButton then
                            if isStored then
                                VehicleCheckAndSpawn(vehicle)
                                WarMenu.CloseMenu()
                            else
                                ESX.ShowNotification('Vehicle is not in the garage.')
                            end
                        end
                    end
                    WarMenu.End()
                else
                    inMenu = false
                    return
                end
            end
        end)
    elseif currentType == 'aircraft' then
        ESX.TriggerServerCallback('luke_vehiclegarage:FetchOwnedAircrafts', function(ownedAircrafts)
            while true do
                Citizen.Wait(0)
                MenuRangeCheck()
                if WarMenu.Begin('garageMenu') then
                    for k, v in pairs(ownedAircrafts) do
                        local vehicle = v.vehicle
                        if v.stored == 1 then
                            stored = ' - ~g~In Garage'
                            isStored = true
                        else
                            stored = ' - ~r~Out'
                            isStored = false
                        end
                        local vehicleHash = v.vehicle.model
                        local vehicleName = GetDisplayNameFromVehicleModel(vehicleHash)
                        local vehicleLabel = GetLabelText(vehicleName)
                        local menuButton = WarMenu.Button(vehicleLabel..stored)
                        if menuButton then
                            if isStored then
                                VehicleCheckAndSpawn(vehicle)
                                WarMenu.CloseMenu()
                            else
                                ESX.ShowNotification('Vehicle is not in the garage.')
                            end
                        end
                    end
                    WarMenu.End()
                else
                    inMenu = false
                    return
                end
            end
        end)
    end
end)

-- Impound menu
RegisterNetEvent('luke_vehiclegarage:ImpoundMenu')
AddEventHandler('luke_vehiclegarage:ImpoundMenu', function()
    WarMenu.SetMenuStyle('impoundMenu', style2)
    WarMenu.SetMenuSubTitle('impoundMenu', currentImpoundName)

    if WarMenu.IsAnyMenuOpened() then
        return
    end
    
    WarMenu.OpenMenu('impoundMenu')
    inMenu = true
    if currentImpoundType == 'car' then
        ImpoundCheck('car')
        while true do
            Citizen.Wait(0)
            MenuRangeCheck()
            if WarMenu.Begin('impoundMenu') then
                if #impoundedVehicles == 0 then
                    WarMenu.Button("You don't have any cars to claim.")
                else
                    for i = 1, #impoundedVehicles do
                        local vehicle = json.decode(impoundedVehicles[i].vehicle)
                        local vehicleHash = vehicle.model
                        local vehicleName = GetDisplayNameFromVehicleModel(vehicleHash)
                        local vehicleLabel = impoundedVehicles[i].model
	
							if vehicleLabel == "Unknown" then
								vehicleLabel = GetDisplayNameFromVehicleModel(vehicleHash)
							end
							if vehicleLabel == "CARNOTFOUND" then
								vehicleLabel = "Unknown"
							end
							if IsModelInCdimage(vehicleHash) == false then
								vehicleLabel = "CAR_NOT_EXIST"
							end

							local menuButton = WarMenu.Button(vehicleLabel..'~o~ [~b~' .. vehicle.plate .. '~o~] '..' - ~r~$'..Config.ImpoundPrice)
                        if menuButton then
                            ESX.TriggerServerCallback('luke_vehiclegarage:ChargePlayer', function(callback)
                                if callback == true then
                                    VehicleCheckAndSpawn(impoundedVehicles[i].vehicle)
                                else
                                    ESX.ShowNotification("You don't have enough money")
                                end
                            end)
                            WarMenu.CloseMenu()
                        end
                    end
                end
                WarMenu.End()
            else
                inMenu = false
                return
            end
        end
    elseif currentImpoundType == 'boat' then
        ImpoundCheck('boat')
        while true do
            Citizen.Wait(0)
            MenuRangeCheck()
            if WarMenu.Begin('impoundMenu') then
                if #impoundedVehicles == 0 then
                    WarMenu.Button("You don't have any boats in insurance.")
                else
                    for i = 1, #impoundedVehicles do
                        local vehicle = impoundedVehicles[i]
                        local vehicleHash = impoundedVehicles[i].model
                        local vehicleName = GetDisplayNameFromVehicleModel(vehicleHash)
                        local vehicleLabel = GetLabelText(vehicleName)
                        local menuButton = WarMenu.Button(vehicleLabel..' - ~r~$'..Config.ImpoundPrice)
                        if menuButton then
                            ESX.TriggerServerCallback('luke_vehiclegarage:ChargePlayer', function(callback)
                                if callback == true then
                                    VehicleCheckAndSpawn(vehicle)
                                else
                                    ESX.ShowNotification("You don't have enough money")
                                end
                            end)
                            WarMenu.CloseMenu()
                        end
                    end
                end
                WarMenu.End()
            else
                inMenu = false
                return
            end
        end
    elseif currentImpoundType == 'aircraft' then
        ImpoundCheck('aircraft')
        while true do
            Citizen.Wait(0)
            MenuRangeCheck()
            if WarMenu.Begin('impoundMenu') then
                if #impoundedVehicles == 0 then
                    WarMenu.Button("You don't have any aircrafts in insurance.")
                else
                    for i = 1, #impoundedVehicles do
                        local vehicle = impoundedVehicles[i]
                        local vehicleHash = impoundedVehicles[i].model
                        local vehicleName = GetDisplayNameFromVehicleModel(vehicleHash)
                        local vehicleLabel = GetLabelText(vehicleName)
                        local menuButton = WarMenu.Button(vehicleLabel..' - ~r~$'..Config.ImpoundPrice)
                        if menuButton then
                            ESX.TriggerServerCallback('luke_vehiclegarage:ChargePlayer', function(callback)
                                if callback == true then
                                    VehicleCheckAndSpawn(vehicle)
                                else
                                    ESX.ShowNotification("You don't have enough money")
                                end
                            end)
                            WarMenu.CloseMenu()
                        end
                    end
                end
                WarMenu.End()
            else
                inMenu = false
                return
            end
        end
    end
end)

 -- Function that checks whether the vehicle is already in the impound
function ImpoundCheck(vehicleType)
    impoundedVehicles = {}
	local continue = false
    if vehicleType == 'car' then
        ESX.TriggerServerCallback('luke_vehiclegarage:FetchOwnedCarsInsurance', function(ownedCars)
            for k, v in pairs(ownedCars) do
                --if v.state == 0 then
                    --if DoesVehicleExist(v.vehicle) ~= true and not ValueExistsInTable(impoundedVehicles, v.vehicle) then
                        table.insert(impoundedVehicles, v)
                   -- end
               -- end
            end
			continue = true
        end)
    elseif vehicleType == 'boat' then
        ESX.TriggerServerCallback('luke_vehiclegarage:FetchOwnedBoats', function(ownedBoats)
            for k, v in pairs(ownedBoats) do
                if v.state == 0 then
                    if DoesVehicleExist(v.vehicle) ~= true and not ValueExistsInTable(impoundedVehicles, v.vehicle) then
                        table.insert(impoundedVehicles, v.vehicle)
                    end
                end
            end
			continue = true
        end)
    elseif vehicleType == 'aircraft' then
        ESX.TriggerServerCallback('luke_vehiclegarage:FetchOwnedAircrafts', function(ownedAircrafts)
            for k, v in pairs(ownedAircrafts) do
                if v.state == 0 then
                    if DoesVehicleExist(v.vehicle) ~= true and not ValueExistsInTable(impoundedVehicles, v.vehicle) then
                        table.insert(impoundedVehicles, v.vehicle)
                    end
                end
            end
			continue = true
        end)
    end
	while continue == false do
		Wait(30)
	end
	print('continue has response')
end

-- Provera da li vozilo postoji u svetu
function DoesVehicleExist(vehicleToCheck)
    local worldVehicles = ESX.Game.GetVehicles() -- Uzima sva trenutna vozila u svetu
    for i = 1, #worldVehicles do
        local vehicle = worldVehicles[i]
        if DoesEntityExist(vehicle) then
            if ESX.Math.Trim(GetVehicleNumberPlateText(vehicle)) == ESX.Math.Trim(vehicleToCheck.plate) then
                return true
            end
        end
    end
end

-- Simple function that checks whether the value is already in a table or not
function ValueExistsInTable(table, val)
    for index, value in ipairs(table) do
        if value == val then
            return true
        end
    end
    return false
end

-- Function that stores and deletes the vehicle player is in
function StoreVehicle(vehicle)
    local vehiclePlate = GetVehicleNumberPlateText(vehicle)
    local vehicleSettings = ESX.Game.GetVehicleProperties(vehicle)
	if DoesEntityExist(vehicle) then
		ESX.Game.DeleteVehicle(vehicle)
		TriggerServerEvent('luke_vehiclegarage:VehicleStatus', vehiclePlate, true, currentZone)
		if Config.SaveDamageOnStore == true then
			TriggerServerEvent('luke_vehiclegarage:SaveVehicleDamage', vehicleSettings)
		end
	end
 
end

-- Checkin if the vehicle spawn is occupied and spawning the vehicle with it's mods
function VehicleCheckAndSpawn(vehicle)

	local vehicle = json.decode(vehicle)
	local found = false
	local forwardorback = 1
	local forwardbackstart = 1
	local forwardscount = #currentSpawn
	local listofspots = {}
	math.randomseed(GetGameTimer())
	for i = 1,  #currentSpawn, 1 do
		table.insert(listofspots,i)
	end
	
	if currentSpawn.lv ~= nil then
		for i = 1, #currentSpawn, 1 do
			if ESX.Game.IsSpawnPointClear(currentSpawn[i].pos, 3.2) then
				isClear = true
				spawnPos = currentSpawn[i]
				break
			else
				isClear = false
			end
		end
	else
		while #listofspots > 0 do
			local spotindex = math.random(1,#listofspots)
			local spot = listofspots[spotindex]
			if ESX.Game.IsSpawnPointClear(currentSpawn[spot].pos, 3.2) then
				isClear = true
				spawnPos = currentSpawn[spot]
				break
			else
				table.remove(listofspots,spotindex)
				isClear = false
			end
			Wait(1)
		end
	end


	clear = true
    if isClear then
        LoadModel(vehicle)
	
        ESX.Game.SpawnVehicle(vehicle.model, vector3(spawnPos.pos.x, spawnPos.pos.y, spawnPos.pos.z), spawnPos.h, function(spawnedVehicle)
            ESX.Game.SetVehicleProperties(spawnedVehicle, vehicle)
            TriggerServerEvent('luke_vehiclegarage:VehicleStatus', vehicle.plate, false, currentZone)
            if Config.SaveDamageOnStore == true then
                ESX.Game.SetVehicleProperties(spawnedVehicle, {
                    bodyHealth = vehicle.bodyHealth,
                    engineHealth = vehicle.engineHealth
                })
					PlaySoundFrontend(-1, "Put_Away", "Phone_SoundSet_Michael", 1)
					HulkSmash(vehicle, spawnedVehicle)
					local platep = vehicle.plate
					
								--[[
										Troubleshooting
										Citizen.CreateThread(function()
											print('org val')
											print(vehicle.modHorns)
											local veh = spawnedVehicle
											while true do 
												
												Wait(500)
												local rt = ESX.Game.GetVehicleProperties(veh)
												print('Horn Value')
												print(rt.modHorns)
											end
										
										end)--]]
					--TriggerEvent(  "ls:newVehicle2",platep)
            end
        end)
    else
        ESX.ShowNotification('No available parking spots.')
    end
end

function LoadModel(vehicle)
    if not HasModelLoaded(vehicle.model) then
        RequestModel(vehicle.model)
        BeginTextCommandBusyspinnerOn('STRING')
		AddTextComponentSubstringPlayerName('Loading Vehicle Model')
		EndTextCommandBusyspinnerOn(4)
    end
    while not HasModelLoaded(vehicle.model) do
        Citizen.Wait(0)
        RequestModel(vehicle.model)
        DisableAllControlActions(0)
    end
    BusyspinnerOff()
end

-- Function that returns the closest impound to the player
function ImpoundPlayerDistanceCheck()
    for k, v in pairs(Config.Impounds) do
        if not isPedInVehicle and #(playerCoords - vector3(v.menuCoords.x, v.menuCoords.y, v.menuCoords.z)) < Config.MarkerDrawDistance then
            pedIsNearImpoundBlip = true
            currentImpoundMarker = v.menuCoords
            currentSpawn = v.spawnCoords
            currentImpoundName = v.impoundName
            currentImpoundType = v.impoundType
			local distance = #(playerCoords -  vector3(v.menuCoords.x, v.menuCoords.y, v.menuCoords.z))
            if distance < Config.InRange then
                inRange = true
				if distance < 2.2 then
					inclickRange = true
				else
					inclickRange = false
				end
            else
				inclickRange = false
                inRange = false
            end
            return
        else
            pedIsNearImpoundBlip = false
        end
    end
end

--Function that returns the closest garage
function GaragePlayerDistanceCheck()
    for k, v in pairs(Config.Garages) do
        if not isPedInVehicle and #(playerCoords - vector3(v.menuCoords.x, v.menuCoords.y, v.menuCoords.z)) < Config.MarkerDrawDistance then
            pedIsNearMenuBlip = true
            currentMarker = v.menuCoords
            currentSpawn = v.spawnCoords
            currentName = v.garageName
            currentType = v.garageType
			currentZone = v.zone
			local distance = #(playerCoords - vector3(v.menuCoords.x, v.menuCoords.y, v.menuCoords.z))
            if distance < Config.InRange then
                inRange = true
				if distance < 2.2 then
					inclickRange = true
				else
					inclickRange = false
				end
            else
                inRange = false
				inclickRange = false
            end
            return
        else
            pedIsNearMenuBlip = false
        end
        if isPedInVehicle and not inMenu and #(playerCoords - vector3(v.returnCoords.x, v.returnCoords.y, v.returnCoords.z)) < Config.MarkerDrawDistance then
            pedIsInVehicleAndNearReturn = true
            currentMarker = v.returnCoords
			currentZone = v.zone
			local distance = #(playerCoords - vector3(v.returnCoords.x, v.returnCoords.y, v.returnCoords.z))
            if distance < Config.InRange then
				
                inRange = true
				if distance < 2.2 then
					inclickRange = true
				else
					inclickRange = false
				end
            else
                inRange = false
				inclickRange = false
            end
            return
        else
            pedIsInVehicleAndNearReturn = false
        end
    end
end

function HulkSmash(vehicle, spawnedVehicle)
    if vehicle.engineHealth ~= nil and vehicle.engineHealth < 200 then
        vehicle.engineHealth = 200
    end

    if vehicle.bodyHealth ~= nil and vehicle.bodyHealth < 150 then
        vehicle.bodyHealh = 150
    end

    if vehicle.bodyHealth ~= nil and vehicle.bodyHealth < 800 then
		pcall(function()
        SmashVehicleWindow(spawnedVehicle, 0)
		SmashVehicleWindow(spawnedVehicle, 1)
		SmashVehicleWindow(spawnedVehicle, 2)
		SmashVehicleWindow(spawnedVehicle, 3)
		SmashVehicleWindow(spawnedVehicle, 4)
		end)
    end

    if vehicle.bodyHealth ~= nil and vehicle.bodyHealth < 750 then
		pcall(function()
        SetVehicleDoorBroken(spawnedVehicle, 0, true)
		SetVehicleDoorBroken(spawnedVehicle, 1, true)
		SetVehicleDoorBroken(spawnedVehicle, 4, true)
		end)
    end

    if vehicle.bodyHealth ~= nil and vehicle.bodyHealth < 1000 then
        vehicle.bodyHealth = 985
    end
end

function MenuRangeCheck()
    if not inRange then
        WarMenu.CloseMenu()
    end
end

function DrawHelpText(x, y, z, message)
    if inRange == true then
        Draw3DText(x, y, z, message)
    end
end

function Draw3DText(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)

    local scale = 0.5

    if onScreen then
        SetTextScale(scale, scale)
        SetTextFont(6)
        SetTextProportional(1)
        SetTextColour(255, 255, 255, 215)
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function ImpoundBlips()
    for k, v in pairs(Config.Impounds) do
        impoundBlip = AddBlipForCoord(v.menuCoords.x, v.menuCoords.y, v.menuCoords.z)

        SetBlipSprite(impoundBlip, 285)
        SetBlipScale(impoundBlip, 0.8)
        SetBlipColour(impoundBlip, 28)
        SetBlipAsShortRange(impoundBlip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString('Car Insurance')
        EndTextCommandSetBlipName(impoundBlip)
    end
end

function GarageBlips()
    for k, v in pairs(Config.Garages) do
        garageBlip = AddBlipForCoord(v.menuCoords.x, v.menuCoords.y, v.menuCoords.z)

        SetBlipSprite(garageBlip, 290)
        SetBlipScale(garageBlip, 1.0)
        SetBlipColour(garageBlip, 3)
        SetBlipAsShortRange(garageBlip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("Garage Cars")
        EndTextCommandSetBlipName(garageBlip)
    end
end