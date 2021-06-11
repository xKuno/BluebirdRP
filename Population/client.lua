local ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) 
			ESX = obj 
		end)

		Citizen.Wait(150)
	end
end)

local dispatchSystemSharedUsersOnline = 0
local totalcount = 0

local totalinearshot = 0
overridescript = false

RegisterNetEvent('2c8ece30-424e-437a-ba08-8edf92cc1857')
AddEventHandler('2c8ece30-424e-437a-ba08-8edf92cc1857', function()
	overridescript  = true
	print('traffic turned off')
end)

RegisterNetEvent('52da76d0-8356-4730-b10b-94ae346ff15b')
AddEventHandler('52da76d0-8356-4730-b10b-94ae346ff15b', function()
	overridescript = false
	print('traffic turned on')
end)

RegisterNetEvent('4192936d-441a-494a-9553-de7fbeef165f')
AddEventHandler('4192936d-441a-494a-9553-de7fbeef165f', function(state)

--sendMessage("|||", {255,0,0}, "RECEIVED REQUEST " .. state) 
	if overridescript == false then
		--overridescript = true
		--sendMessage("|||", {255,0,0}, "RECEIVED REQUEST BOOMB OOMB" ) 
	else
		overridescript = false
	end
end)

function sendMessage(title, rgb, text)
	TriggerEvent('chatMessage', title, rgb, text)
end

local trafficDensity = 0.40
local pedDensity = 1.0


	
	
	
	--[[
Citizen.CreateThread(function()
    while true 
    	do
		--ClearAreaOfPeds(-1101.89 , 4919.07, 216.25,300.0,1) --MOuntain top killers camp
		ClearAreaOfPeds(972.27,-120.71, 74.35,80.0,1) --Bikers compound city
		ClearAreaOfPeds(1856.10,3679.10,33.7, 58.0, 0) -- Sandy Police Station
		
		
		RemoveVehiclesFromGeneratorsInArea(3323.39-500.0, -2973.8-500.0, 49.39-20.0,3323.39+500.0, -2973.8+500.0, 49.39+20.0)  --Nuruemburg track
		
		RemoveVehiclesFromGeneratorsInArea(438.11 - 100.0, -1026.67 - 100.0, 28.8 - 100.0, 438.11 + 100.0, -1026.67 + 100.0, 28.67 + 100.0)
		RemoveVehiclesFromGeneratorsInArea(306.75 - 100.0, -1460.33 - 100.0, 46.51 - 100.0, 306.75 + 100.0, -1460.33 + 100.0, 46.51 + 100.0)
		RemoveVehiclesFromGeneratorsInArea(363.34 - 100.0, -1597.55 - 100.0, 36.95 - 100.0, 363.34 + 100.0, -1597.55 + 100.0, 36.95 + 100.0)
		RemoveVehiclesFromGeneratorsInArea(1856.96 - 100.0, 3678.39  - 100.0, 33.75 - 50.0, 1856.96 + 100.0, 3678.39  + 100.0, 33.75 + 50.0) --Sandy Police
		RemoveVehiclesFromGeneratorsInArea( -2172.48 - 700.0, 3097.77  - 700.0, 32.81 - 100.0,  -2172.48 + 700.0, 3097.77  + 700.0, 32.81 + 100.0)   --Armybase
		RemoveVehiclesFromGeneratorsInArea(-1279.28 - 150.0, -2831.22  - 150.0, 13.95 - 150.0,  -1279.28 + 150.0, -2831.22  + 150.0, 13.95 + 150.0)--Airport -1297.3    -2786.02      13.94
		
		
		ClearAreaOfVehicles(131.23, -1068.07, 29.10,20, false, false, false, false, false)
		RemoveVehiclesFromGeneratorsInArea(-436.23 - 150.0, 6041.41  - 150.0, 30.96 - 50.0,  -436.23 + 150.0, 6041.41  + 150.0, 30.96 + 50.0)--Paleto Police/ Firestation
		RemoveVehiclesFromGeneratorsInArea(844.64 - 150.0, 1298.09  - 150.0, 26.3 - 50.0,  844.64 + 150.0, 1298.09  + 150.0, 26.3 + 50.0)--Impound Police
		RemoveVehiclesFromGeneratorsInArea(-1622.31 - 50.0,  -1013.56  - 50.0, 13.3 - 50.0,  -1622.31 + 50.0,  -1013.56  + 50.0, 13.3 + 50.0)--Pier Police
		RemoveVehiclesFromGeneratorsInArea(-1098.01 - 100.0,  -850.86  - 100.0, 6.3 - 80.0,  -1098.01 + 100.0,  -850.86  + 100.0, 6.3 + 80.0)--Security Police
		RemoveVehiclesFromGeneratorsInArea(581.31 - 50.0,  8.8 - 50.0, 93.3 - 50.0,  581.31 + 50.0,  8.8  + 50.0, 93.3 + 50.0)--Vinewood Police
		
		Wait(20)
		
	end
end) --]]


local tiempo = 10000 -- 1000 ms = 1s
local isTaz = false

--CreateIncident(7,-2869.65, 52.78, 14.23, 30, 100.0)
---Police Weapon Deleter

--[[
function RemoveWeaponDrops()
    local pickupList = {`PICKUP_AMMO_BULLET_MP`,`PICKUP_AMMO_GRENADELAUNCHER`,`PICKUP_AMMO_GRENADELAUNCHER_MP`,`PICKUP_AMMO_HOMINGLAUNCHER`,`PICKUP_AMMO_MG`,`PICKUP_AMMO_MINIGUN`,`PICKUP_AMMO_MISSILE_MP`,`PICKUP_AMMO_PISTOL`,`PICKUP_AMMO_RIFLE`,`PICKUP_AMMO_RPG`,`PICKUP_AMMO_SHOTGUN`,`PICKUP_AMMO_SMG`,`PICKUP_AMMO_SNIPER`,`PICKUP_VEHICLE_WEAPON_APPISTOL`,`PICKUP_VEHICLE_WEAPON_ASSAULTSMG`,`PICKUP_VEHICLE_WEAPON_COMBATPISTOL`,`PICKUP_VEHICLE_WEAPON_GRENADE`,`PICKUP_VEHICLE_WEAPON_MICROSMG`,`PICKUP_VEHICLE_WEAPON_MOLOTOV`,`PICKUP_VEHICLE_WEAPON_PISTOL`,`PICKUP_VEHICLE_WEAPON_PISTOL50`,`PICKUP_VEHICLE_WEAPON_SAWNOFF`,`PICKUP_VEHICLE_WEAPON_SMG`,`PICKUP_VEHICLE_WEAPON_SMOKEGRENADE`}
    local pedPos = GetEntityCoords(GetPlayerPed(PlayerId()), false)
    for a = 1, #pickupList do
       -- if IsPickupWithinRadius(GetHashKey(pickupList[a]), pedPos.x, pedPos.y, pedPos.z, 50.0) then
            RemoveAllPickupsOfType(pickupList[a])
      --  end
    end
end
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(3)      
        RemoveWeaponDrops()
		id = PlayerId()
		DisablePlayerVehicleRewards(id)
		RemoveAllPickupsOfType(0xDF711959) -- carbine rifle
		RemoveAllPickupsOfType(0xF9AFB48F) -- pistol
		RemoveAllPickupsOfType(0xA9355DCD) -- pumpshotgun
    end
end)--]]
local PlayerPed = PlayerPedId()
local locked_driveby = false
local vh = 0
local vh_drive = 0
local vh_drive_net = 0
local lastset = 0


Citizen.CreateThread(function()
	while true do
		PlayerPed = PlayerPedId()
		Wait(5000)
		for i = 1, 15 do
			Citizen.InvokeNative(0xDC0F817884CDD856, i, false)
			Wait(100)
		end
		local vh = GetVehiclePedIsIn(PlayerPed)
		
		if vh ~= 0 then
			if vh_drive == GetPedInVehicleSeat(vh,0) then
				vh_drive = vh
				lastset = GetGameTimer()
				vh_drive_net = NetworkGetNetworkIdFromEntity(vh)
			end
			SetVehicleDirtLevel(vh, 0.0)
			local vm = GetEntityModel(vh)
			if vm == `lykan` or vm == `Vespa` or vm == `zentorno` or vm == `huracan` or vm == `huracan` or vm == `bullet` then
				locked_driveby = true
				SetPlayerCanDoDriveBy(PlayerId(),false)
			else
				locked_driveby = false
				SetPlayerCanDoDriveBy(PlayerId(),true)
			end
		elseif locked_driveby == true then
			locked_driveby = false
			SetPlayerCanDoDriveBy(PlayerId(),true)
		end
		SetCreateRandomCops(false) -- disable random cops walking/driving around.
		SetCreateRandomCopsNotOnScenarios(false) -- stop random cops (not in a scenario) from spawning.
		SetCreateRandomCopsOnScenarios(false) 
		--SetPedSuffersCriticalHits(GetPlayerPed(-1),false)
		--SetPlayerWantedLevel(PlayerId(), 0, false)
		--SetPlayerWantedLevelNow(PlayerId(), false)
		--SetPlayerWantedLevelNoDrop(PlayerId(), 0, false)
	end

end)

RegisterCommand("sct", function(source, args, rawCommand)


end,false)

RegisterCommand("sc", function(source, args, rawCommand)
	local mycoords = GetEntityCoords(PlayerPedId())
	local vehcoords = GetEntityCoords(vh_drive)
	local badvector = vector3(0,0,0)
	local differenceintime = GetGameTimer() - lastset
	print(differenceintime)
	print((1000 * 60 * 3))
	
	if GetVehiclePedIsIn(PlayerPedId()) > 0 then
		ESX.ShowNotification('You cannot do this from inside a vehicle')
		return
	end
	if differenceintime < (1000 * 60 * 3) then
	
		if vh_drive_net ~= 0 and (vehcoords == badvector or #(mycoords - vehcoords) > 150) then
		
			ESX.TriggerServerCallback('d3f70bfb-a8c8-42f1-a067-075f31bad6b1', function(_netid)
				if _netid == 0 then
					print('didnt work 0 returned by server')
					return
				end
			local vehicle  = 0
			local netid = _netid
			local counter = 0
			while vehicle == 0 do
				vehicle = NetToVeh(netid)
				counter = counter + 1
				Wait(1)
				
				if counter > 20000 then
					ESX.ShowNotification("~r~There maybe an error spawning your car and applying mods")
					Wait(100)
					ESX.ShowNotification("~o~If it has not appeared yet, it could still be downloading.")
				end
				
				if counter > 60000 then
					ESX.ShowNotification("~r~Error spawning vehicle and applying modifications.")
					Wait(100)
					ESX.ShowNotification("~o~If it has not appeared yet, it could still be downloading.")
					ESX.ShowNotification("~o~If this continues you may need to relog.")
				end
			end
			if netid then
				
				Wait(5)
				local id  = netid

				SetNetworkIdCanMigrate(id, true)
				NetworkRequestControlOfEntity(vehicle)
				
				while not NetworkHasControlOfEntity(vehicle) do
					NetworkRequestControlOfEntity(vehicle)
					Citizen.Wait(0)
				end
				Wait(5)
				SetVehicleOnGroundProperly(vehicle)
				SetEntityAsMissionEntity(vehicle, true, false)
				SetVehicleHasBeenOwnedByPlayer(vehicle, true)
				SetVehicleNeedsToBeHotwired(vehicle, false)
				SetModelAsNoLongerNeeded(model)
				SetEntityHeading(vehicle,GetEntityHeading(PlayerPedId()))

				RequestCollisionAtCoord(coords.x, coords.y, coords.z)

				while not HasCollisionLoadedAroundEntity(vehicle) do
					RequestCollisionAtCoord(coords.x, coords.y, coords.z)
					Citizen.Wait(0)
				end

				SetVehRadioStation(vehicle, 'OFF')

				if cb ~= nil then
					cb(vehicle)
				end
			else
				ESX.ShowNotification('Error no vehicle returned')	
			end
			end,mycoords,vh_drive_net)
		else
			ESX.ShowNotification("Command unable to be used, due to distance or proximity of vehicle.")
		end
	else
		ESX.ShowNotification("Command unable to be used, due to time last in the vehicle.")
	end

 
end)



Citizen.CreateThread(function()
    while true 
    	do
		
			
		local playerPed = PlayerPed


	   	SetParkedVehicleDensityMultiplierThisFrame(0.00)
		--SetPedDensityMultiplierThisFrame(1.00)
	    --SetScenarioPedDensityMultiplierThisFrame(1.00, 1.00)

		
		SetRandomVehicleDensityMultiplierThisFrame((0.60))
		SetVehicleDensityMultiplierThisFrame(0.60)
			
	    local ppid = playerPed
		pid = PlayerId()
		N_0x4757f00bc6323cfe(`WEAPON_UNARMED`, 0.280)
		N_0x4757f00bc6323cfe(`WEAPON_NIGHTSTICK`, 0.4)
		N_0x4757f00bc6323cfe(`WEAPON_SNOWBALL`, 0.0)
		N_0x4757f00bc6323cfe(`WEAPON_KNIFE`, 0.2)
		N_0x4757f00bc6323cfe(`WEAPON_DAGGER`, 0.3)
		
		local weapon = GetSelectedPedWeapon(ppid)
		if weapon ~= 0 then
			
			if weapon == `WEAPON_REVOLVER` then
				SetPlayerWeaponDamageModifier(pid, 0.12)	
			elseif weapon == `WEAPON_COMBATPISTOL` then
				SetPlayerWeaponDamageModifier(pid, 0.70)
				SetPlayerMeleeWeaponDamageModifier(pid,0.30)
			elseif weapon == `WEAPON_MP5` then
				SetPlayerWeaponDamageModifier(pid, 0.70)
				SetPlayerMeleeWeaponDamageModifier(pid,0.30)
		
			else

				SetPlayerWeaponDamageModifier(pid, 0.70)
				SetPlayerMeleeWeaponDamageModifier(pid,0.30)

			end
			if vh then
				if IsPedShooting(ppid) then
					local speed = exports.hud:vehiclespeed()
					if speed > 10.0 then
						ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.20)
					elseif speed > 8.0 then
						ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', 0.15)
					end
				end
			end

		end
		N_0x4757f00bc6323cfe(-1553120962, 0.0)
		
		
		local pedstung = IsPedBeingStunned(playerPed)
		if pedstung then
        	SetPedMinGroundTimeForStungun(playerPed, 10000)
        end
		
		if pedstung then
			
			SetPedToRagdoll(playerPed, 9000, 9000, 0, 0, 0, 0)
			
		end
		
		if pedstung and not isTaz then
			
			isTaz = true
			SetTimecycleModifier("REDMIST_blend")
			ShakeGameplayCam("FAMILY5_DRUG_TRIP_SHAKE", 1.0)
			
		elseif not pedstung and isTaz then
			isTaz = false
			Wait(9000)
			
			SetTimecycleModifier("hud_def_desat_Trevor")
			
			Wait(15000)
			
			SetTimecycleModifier("")
			SetTransitionTimecycleModifier("")
			StopGameplayCamShaking()
		end
		

		Citizen.Wait(0)
	end

end)

function inearshot()
	return totalinearshot
end