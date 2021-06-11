-- C O N F I G --
local companyName = "RACV"

local towOffset = -5.0

local deleteLastTruck = true --Deletes the last spawned truck.
local spawnDistance = 500 	--	Default 500
							---								---
local drivingStyle = 786603  	--	**786603  - "Normal" - Default**
								--	**1074528293 - "Rushed"**
								--	**2883621 - "Ignore Lights"**
								--	**5 - "Sometimes Overtake Traffic"**
								--	**Customize Driving Style: https://vespura.com/drivingstyle/

local towDriverQuoteOfTheDay = {"Howdy partner! I'll get it towed.","Do you even lift bro? Because i do.","You called the right guy, because i got puns from head to tow.","Tow'nt worry about it, i'll get it towed!","I wont charge you a arm and a leg! I only want your tows.","You want too hook up some time?","I hate my job.","Sorry i took so long!","We have some of the best hookers in town!","Sorry i took so long.","There ya go!","Take care.","That will look good in the impound!","Fuck you.", "I got it!", ("Thanks for using " .. companyName .. "!"), "It will be at the compound."}
	
								
-- Register a network event 
RegisterNetEvent('33fb6311-6c68-4782-a349-724e28167bd8')
RegisterNetEvent('152d3985-25a7-4c37-a9a1-a9ecacae53d9')

-- Gets a vehicle in a certain direction
-- Credit to Konijima
function GetVehicleInDirection( coordFrom, coordTo )
    local rayHandle = CastRayPointToPoint( coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 10, GetPlayerPed( -1 ), 0 )
    local _, _, _, _, vehicle = GetRaycastResult( rayHandle )
    return vehicle
end

-- The distance to check in front of the player for a vehicle
-- Distance is in GTA units, which are quite big  
local distanceToCheck = 5.0

enroute = false
onscene = false
cleartask = false
AddEventHandler('33fb6311-6c68-4782-a349-724e28167bd8', function()
	local spawnDistance = math.random(spawnDistance * -1, spawnDistance)
	local player = GetPlayerPed(-1)
	local playerPos = GetEntityCoords(player)
	local pmodels = {"mp_m_waremech_01"}
	local vehicles = {"flatbed"}
	local driver = GetHashKey(pmodels[math.random(#pmodels)])
	local vehiclehash = GetHashKey(vehicles[math.random(#vehicles)])
    local inFrontOfPlayer = GetOffsetFromEntityInWorldCoords(player, 0.0, distanceToCheck, 0.0)
	RequestModel(vehiclehash)
	RequestModel(driver)
	
	while not HasModelLoaded(vehiclehash) and RequestModel(driver) do
		RequestModel(vehiclehash)
		RequestModel(driver)
		Citizen.Wait(0)
	end
	
	if IsPedSittingInAnyVehicle(player) then 
        targetVeh = GetVehiclePedIsIn(player, false)
	else
		targetVeh = GetVehicleInDirection(playerPos, inFrontOfPlayer)
	end
	
	if DoesEntityExist(vehicle) and deleteLastTruck == true then
		SetEntityAsMissionEntity(driver)
		SetEntityAsMissionEntity(vehicle)
		SetEntityAsMissionEntity(towedVeh)
		
		DeleteEntity(driver)
		DeleteEntity(vehicle)
		DeleteEntity(towedVeh)
		
		while DoesEntityExist(driver) do
			Wait(0)
			DeleteEntity(driver)
		end
	end
	
	if DoesEntityExist(targetVeh) then
	TriggerEvent('92f28b0a-6473-4fdd-bd0f-74031dc312c8')
	
		Wait(math.random(2000, 6000))
		
		local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
		local heading, vector = GetNthClosestVehicleNode(x, y, z, spawnDistance, 0, 0, 0)
		local sX, sY, sZ = table.unpack(vector)	
		vehicle = CreateVehicle(vehiclehash, sX, sY, sZ, heading, true, true)
		
		local vehiclehash = GetHashKey(vehicle)
		
		driver = CreatePedInsideVehicle(vehicle, 26, driver, -1, true, false)
		local vehpos = GetEntityCoords(targetVeh)
		TaskVehicleDriveToCoord(driver, vehicle, vehpos.x, vehpos.y, vehpos.z, 17.0, 0, vehiclehash, drivingStyle, 1.0, true)
		SetVehicleFixed(vehicle)
		SetVehicleOnGroundProperly(vehicle)
		if DoesEntityExist(driver) and DoesEntityExist(vehicle) then
		SetEntityAsMissionEntity(driver, true, true)
		towblip = AddBlipForEntity(vehicle)
		SetBlipColour(towblip, 29)
		SetBlipFlashes(towblip, true)
		
		local distanceToTow = GetDistanceBetweenCoords(GetEntityCoords(vehicle), GetEntityCoords(targetVeh))
		
		if distanceToTow < 100 then
			eta = '~g~1 Mike'
		elseif distanceToTow < 300 then
			eta = '~g~2 Mikes'
		elseif distanceToTow < 500 then
			eta = '~o~3 Mikes'
		elseif distanceToTow > 500 then
			eta = '~r~5 Mikes'
		end
		
		ShowNotification("A tow truck has been dispatched to your location. Thanks for using ~y~" .. companyName .. "~w~\nETA: " .. eta)
		enroute = true
		while (enroute) do
			Citizen.Wait(300)
			local distanceToVeh = GetDistanceBetweenCoords(GetEntityCoords(vehicle), GetEntityCoords(targetVeh), 1)
			SetEntityInvincible(vehicle, true)
			SetEntityInvincible(driver, true)
				if distanceToVeh <= 15 then
					SetVehicleIndicatorLights(vehicle, 1, true)
					SetVehicleIndicatorLights(vehicle, 2, true)
					TaskVehicleTempAction(driver, vehicle, 27, 5000)
					Wait(5000)
					AttachEntityToEntity(targetVeh, vehicle, 20, -0.5, towOffset, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
					targetVeh = towedVeh
					SetDriveTaskDrivingStyle(vehicle, 786603)
					TaskVehicleDriveWander(driver, vehicle, 17.0, drivingStyle)
					SetVehicleSiren(vehicle, true)
					ShowNotification("~o~Tow Driver:~w~ " .. towDriverQuoteOfTheDay[math.random(#towDriverQuoteOfTheDay)])
					SetEntityAsNoLongerNeeded(vehicle)
					enroute = false
					towblip = RemoveBlip(towblip)
					SetVehicleIndicatorLights(vehicle, 1, false)
					SetVehicleIndicatorLights(vehicle, 2, false)
					SetEntityInvincible(vehicle, false)
					SetEntityInvincible(driver, false)
					SetEntityAsNoLongerNeeded(vehicle)
					SetEntityAsNoLongerNeeded(driver)
					SetEntityAsNoLongerNeeded(targetVeh)
				end
			end
		end
	else
	ShowNotification("No vehicle found!")
	end
end)

AddEventHandler('152d3985-25a7-4c37-a9a1-a9ecacae53d9', function()
	if enroute == true then
		ShowNotification("Tow Truck request has been canceled. Thank you for using ~y~" .. companyName)
		
		SetEntityAsMissionEntity(vehicle)
		SetEntityAsMissionEntity(driver)
		
		DeleteEntity(vehicle)
		DeleteEntity(driver)
		enroute = false
	end
end)

RegisterNetEvent('92f28b0a-6473-4fdd-bd0f-74031dc312c8')
AddEventHandler('92f28b0a-6473-4fdd-bd0f-74031dc312c8', function()
    Citizen.CreateThread(function()
        TaskPlayAnim(player, "random@arrests", "generic_radio_enter", 1.5, 2.0, -1, 50, 2.0, 0, 0, 0 )
		Citizen.Wait(6000)
		ClearPedTasks(player)
    end)
end)

function loadAnimDict( dict )
	while ( not HasAnimDictLoaded( dict ) ) do
		RequestAnimDict( dict )
		Citizen.Wait( 0 )
	end
end

-- Shows a notification on the player's screen 
function ShowNotification( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end