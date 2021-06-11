Keys = {
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

local FirstSpawn, PlayerLoaded = true, false

local paintball = false
local bleedoutTimer = Config.BleedoutTimer
local permissionToLeave = false
local deathlocation = vector3(0,0,0)

local nextrevive_itemslost = false



weapons = {
    --[[ Small Caliber ]]--
    [`WEAPON_PISTOL`] = {WeaponClasses= 'SMALL_CALIBER', Name='WEAPON_PISTOL'},
    [`WEAPON_COMBATPISTOL`] = {WeaponClasses= 'SMALL_CALIBER', Name='WEAPON_COMBATPISTOL'},
    [`WEAPON_APPISTOL`] = {WeaponClasses= 'SMALL_CALIBER', Name='WEAPON_APPISTOL'},
    [`WEAPON_COMBATPDW`] = {WeaponClasses= 'SMALL_CALIBER', Name='WEAPON_COMBATPDW'},
    [`WEAPON_MACHINEPISTOL`] = {WeaponClasses= 'SMALL_CALIBER', Name='WEAPON_MACHINEPISTOL'},
    [`WEAPON_MICROSMG`] = {WeaponClasses= 'SMALL_CALIBER', Name='WEAPON_MICROSMG'},
    [`WEAPON_MINISMG`] = {WeaponClasses= 'SMALL_CALIBER', Name='WEAPON_MINISMG'},
    [`WEAPON_PISTOL_MK2`] = {WeaponClasses= 'SMALL_CALIBER', Name='WEAPON_PISTOL_MK2'},
    [`WEAPON_SNSPISTOL`] = {WeaponClasses= 'SMALL_CALIBER', Name='WEAPON_SNSPISTOL'},
    [`WEAPON_SNSPISTOL_MK2`] = {WeaponClasses= 'SMALL_CALIBER', Name='WEAPON_SNSPISTOL_MK2'},
    [`WEAPON_VINTAGEPISTOL`] = {WeaponClasses= 'SMALL_CALIBER', Name='WEAPON_VINTAGEPISTOL'},

    --[[ Medium Caliber ]]--
    [`WEAPON_ADVANCEDRIFLE`] = {WeaponClasses= 'MEDIUM_CALIBER', Name='WEAPON_ADVANCEDRIFLE'},
    [`WEAPON_ASSAULTSMG`] = {WeaponClasses= 'MEDIUM_CALIBER', Name='WEAPON_ASSAULTSMG'},
    [`WEAPON_BULLPUPRIFLE`] = {WeaponClasses= 'MEDIUM_CALIBER', Name='WEAPON_BULLPUPRIFLE'},
    [`WEAPON_BULLPUPRIFLE_MK2`] = {WeaponClasses= 'MEDIUM_CALIBER', Name='WEAPON_BULLPUPRIFLE_MK2'},
    [`WEAPON_CARBINERIFLE`] = {WeaponClasses= 'MEDIUM_CALIBER', Name='WEAPON_CARBINERIFLE'},
    [`WEAPON_CARBINERIFLE_MK2`] = {WeaponClasses= 'MEDIUM_CALIBER', Name='WEAPON_CARBINERIFLE_MK2'},
    [`WEAPON_COMPACTRIFLE`] = {WeaponClasses= 'MEDIUM_CALIBER', Name='WEAPON_COMPACTRIFLE'},
    [`WEAPON_DOUBLEACTION`] = {WeaponClasses= 'MEDIUM_CALIBER', Name='WEAPON_DOUBLEACTION'},
    [`WEAPON_GUSENBERG`] = {WeaponClasses= 'MEDIUM_CALIBER', Name='WEAPON_GUSENBERG'},
    [`WEAPON_HEAVYPISTOL`] = {WeaponClasses= 'MEDIUM_CALIBER', Name='WEAPON_HEAVYPISTOL'},
    [`WEAPON_MARKSMANPISTOL`] = {WeaponClasses= 'MEDIUM_CALIBER', Name='WEAPON_MARKSMANPISTOL'},
    [`WEAPON_PISTOL50`] = {WeaponClasses= 'MEDIUM_CALIBER', Name='WEAPON_PISTOL50'},
    [`WEAPON_REVOLVER`] = {WeaponClasses= 'MEDIUM_CALIBER', Name='WEAPON_REVOLVER'},
    [`WEAPON_REVOLVER_MK2`] = {WeaponClasses= 'MEDIUM_CALIBER', Name='WEAPON_REVOLVER_MK2'},
    [`WEAPON_SMG`] = {WeaponClasses= 'MEDIUM_CALIBER', Name='WEAPON_SMG'},
    [`WEAPON_SMG_MK2`] = {WeaponClasses= 'MEDIUM_CALIBER', Name='WEAPON_SMG_MK2'},
    [`WEAPON_SPECIALCARBINE`] = {WeaponClasses= 'MEDIUM_CALIBER', Name='WEAPON_SPECIALCARBINE'},
    [`WEAPON_SPECIALCARBINE_MK2`] = {WeaponClasses= 'MEDIUM_CALIBER', Name='WEAPON_SPECIALCARBINE_MK2'},

    --[[ High Caliber ]]--
    [`WEAPON_ASSAULTRIFLE`] = {WeaponClasses= 'HIGH_CALIBER', Name='WEAPON_ASSAULTRIFLE'},
    [`WEAPON_ASSAULTRIFLE_MK2`] = {WeaponClasses= 'HIGH_CALIBER', Name='WEAPON_ASSAULTRIFLE_MK2'},
    [`WEAPON_COMBATMG`] = {WeaponClasses= 'HIGH_CALIBER', Name='WEAPON_COMBATMG'},
    [`WEAPON_COMBATMG_MK2`] = {WeaponClasses= 'HIGH_CALIBER', Name='WEAPON_COMBATMG_MK2'},
    [`WEAPON_HEAVYSNIPER`] = {WeaponClasses= 'HIGH_CALIBER', Name='WEAPON_HEAVYSNIPER'},
    [`WEAPON_HEAVYSNIPER_MK2`] = {WeaponClasses= 'HIGH_CALIBER', Name='WEAPON_HEAVYSNIPER_MK2'},
    [`WEAPON_MARKSMANRIFLE`] = {WeaponClasses= 'HIGH_CALIBER', Name='WEAPON_MARKSMANRIFLE'},
    [`WEAPON_MARKSMANRIFLE_MK2`] = {WeaponClasses= 'HIGH_CALIBER', Name='WEAPON_MARKSMANRIFLE_MK2'},
    [`WEAPON_MG`] = {WeaponClasses= 'HIGH_CALIBER', Name='WEAPON_MG'},
    [`WEAPON_MINIGUN`] = {WeaponClasses= 'HIGH_CALIBER', Name='WEAPON_MINIGUN'},
    [`WEAPON_MUSKET`] = {WeaponClasses= 'HIGH_CALIBER', Name='WEAPON_MUSKET'},
    [`WEAPON_RAILGUN`] = {WeaponClasses= 'HIGH_CALIBER', Name='WEAPON_RAILGUN'},

    --[[ Shotguns ]]--
    [`WEAPON_ASSAULTSHOTGUN`] = {WeaponClasses= 'SHOTGUN', Name='WEAPON_ASSAULTSHOTGUN'},
    [`WEAPON_BULLUPSHOTGUN`] = {WeaponClasses= 'SHOTGUN', Name='WEAPON_BULLUPSHOTGUN'},
    [`WEAPON_DBSHOTGUN`] = {WeaponClasses= 'SHOTGUN', Name='WEAPON_BULLUPSHOTGUN'},
    [`WEAPON_HEAVYSHOTGUN`] = {WeaponClasses= 'SHOTGUN', Name='WEAPON_BULLUPSHOTGUN'},
    [`WEAPON_PUMPSHOTGUN`] = {WeaponClasses= 'SHOTGUN', Name='WEAPON_BULLUPSHOTGUN'},
    [`WEAPON_PUMPSHOTGUN_MK2`] = {WeaponClasses= 'SHOTGUN', Name='WEAPON_BULLUPSHOTGUN'},
    [`WEAPON_SAWNOFFSHOTGUN`] = {WeaponClasses= 'SHOTGUN', Name='WEAPON_BULLUPSHOTGUN'},
    [`WEAPON_SWEEPERSHOTGUN`] = {WeaponClasses= 'SHOTGUN', Name='WEAPON_BULLUPSHOTGUN'},

    --[[ Animals ]]--
    [`WEAPON_ANIMAL`] = {WeaponClasses= 'SHOTGUN', Name='WEAPON_ANIMAL'}, -- Animal
    [`WEAPON_COUGAR`] = {WeaponClasses= 'SHOTGUN', Name='WEAPON_COUGAR'}, -- Cougar
    [`WEAPON_BARBED_WIRE`] = {WeaponClasses= 'SHOTGUN', Name='WEAPON_BARBED_WIRE'},-- Barbed Wire
    
    --[[ Cutting Weapons ]]--
    [`WEAPON_BATTLEAXE`] = {WeaponClasses= 'CUTTING', Name='WEAPON_BATTLEAXE'},
    [`WEAPON_BOTTLE`] = {WeaponClasses= 'CUTTING', Name='WEAPON_BOTTLE'},
    [`WEAPON_DAGGER`] = {WeaponClasses= 'CUTTING', Name='WEAPON_DAGGER'},
    [`WEAPON_HATCHET`] = {WeaponClasses= 'CUTTING', Name='WEAPON_HATCHET'},
    [`WEAPON_KNIFE`] = {WeaponClasses= 'CUTTING', Name='WEAPON_KNIFE'},
    [`WEAPON_MACHETE`] = {WeaponClasses= 'CUTTING', Name='WEAPON_MACHETE'},
    [`WEAPON_SWITCHBLADE`] = {WeaponClasses= 'CUTTING', Name='WEAPON_SWITCHBLADE'},

    --[[ Light Impact ]]--
    [`WEAPON_GARBAGEBAG`] = {WeaponClasses= 'LIGHT_IMPACT', Name='WEAPON_GARBAGEBAG'}, -- Garbage Bag
    [`WEAPON_BRIEFCASE`] = {WeaponClasses= 'LIGHT_IMPACT', Name='WEAPON_BRIEFCASE'}, -- Briefcase
    [`WEAPON_BRIEFCASE_02`] = {WeaponClasses= 'LIGHT_IMPACT', Name='WEAPON_BRIEFCASE_02'}, -- Briefcase 2
    [`WEAPON_BALL`] = {WeaponClasses= 'LIGHT_IMPACT', Name='WEAPON_BALL'},
    [`WEAPON_FLASHLIGHT`] = {WeaponClasses= 'LIGHT_IMPACT', Name='WEAPON_FLASHLIGHT'},
    [`WEAPON_KNUCKLE`] = {WeaponClasses= 'LIGHT_IMPACT', Name='WEAPON_KNUCKLE'},
    [`WEAPON_NIGHTSTICK`] = {WeaponClasses= 'LIGHT_IMPACT', Name='WEAPON_NIGHTSTICK'},
    [`WEAPON_SNOWBALL`] = {WeaponClasses= 'LIGHT_IMPACT', Name='WEAPON_SNOWBALL'},
    [`WEAPON_UNARMED`] = {WeaponClasses= 'LIGHT_IMPACT', Name='WEAPON_UNARMED'},
    [`WEAPON_PARACHUTE`] = {WeaponClasses= 'LIGHT_IMPACT', Name='WEAPON_PARACHUTE'},
    [`WEAPON_NIGHTVISION`] = {WeaponClasses= 'LIGHT_IMPACT', Name='WEAPON_NIGHTVISION'},
    
    --[[ Heavy Impact ]]--
    [`WEAPON_BAT`] = {WeaponClasses= 'HEAVY_IMPACT', Name='WEAPON_BAT'},
    [`WEAPON_CROWBAR`] = {WeaponClasses= 'HEAVY_IMPACT', Name='WEAPON_CROWBAR'},
    [`WEAPON_FIREEXTINGUISHER`] = {WeaponClasses= 'HEAVY_IMPACT', Name='WEAPON_FIREEXTINGUISHER'},
    [`WEAPON_FIRWORK`] = {WeaponClasses= 'HEAVY_IMPACT', Name='WEAPON_FIRWORK'},
    [`WEAPON_GOLFLCUB`] = {WeaponClasses= 'HEAVY_IMPACT', Name='WEAPON_GOLFLCUB'},
    [`WEAPON_HAMMER`] = {WeaponClasses= 'HEAVY_IMPACT', Name='WEAPON_HAMMER'},
    [`WEAPON_PETROLCAN`] = {WeaponClasses= 'HEAVY_IMPACT', Name='WEAPON_PETROLCAN'},
    [`WEAPON_POOLCUE`] = {WeaponClasses= 'HEAVY_IMPACT', Name='WEAPON_POOLCUE'},
    [`WEAPON_WRENCH`] = {WeaponClasses= 'HEAVY_IMPACT', Name='WEAPON_WRENCH'},
    
    --[[ Explosives ]]--
    [`WEAPON_EXPLOSION`] = {WeaponClasses= 'EXPLOSIVE', Name='WEAPON_EXPLOSION'}, -- Explosion
    [`WEAPON_GRENADE`] = {WeaponClasses= 'EXPLOSIVE', Name='WEAPON_GRENADE'},
    [`WEAPON_COMPACTLAUNCHER`] = {WeaponClasses= 'EXPLOSIVE', Name='WEAPON_COMPACTLAUNCHER'},
    [`WEAPON_HOMINGLAUNCHER`] = {WeaponClasses= 'EXPLOSIVE', Name='WEAPON_HOMINGLAUNCHER'},
    [`WEAPON_PIPEBOMB`] = {WeaponClasses= 'EXPLOSIVE', Name='WEAPON_PIPEBOMB'},
    [`WEAPON_PROXMINE`] = {WeaponClasses= 'EXPLOSIVE', Name='WEAPON_PROXMINE'},
    [`WEAPON_RPG`] = {WeaponClasses= 'EXPLOSIVE', Name='WEAPON_RPG'},
    [`WEAPON_STICKYBOMB`] = {WeaponClasses= 'EXPLOSIVE', Name='WEAPON_STICKYBOMB'},
    
    --[[ Other ]]--
    [`WEAPON_FALL`] = {WeaponClasses= 'OTHER', Name='WEAPON_FALL'}, -- Fall
    [`WEAPON_HIT_BY_WATER_CANNON`] = {WeaponClasses= 'OTHER', Name='WEAPON_HIT_BY_WATER_CANNON'}, -- Water Cannon
    [`WEAPON_RAMMED_BY_CAR`] = {WeaponClasses= 'OTHER', Name='WEAPON_RAMMED_BY_CAR'}, -- Rammed
    [`WEAPON_RUN_OVER_BY_CAR`] = {WeaponClasses= 'OTHER', Name='WEAPON_RUN_OVER_BY_CAR'}, -- Ran Over
    [`WEAPON_HELI_CRASH`] = {WeaponClasses= 'OTHER', Name='WEAPON_HELI_CRASH'}, -- Heli Crash
    [`WEAPON_STUNGUN`] = {WeaponClasses= 'OTHER', Name='WEAPON_STUNGUN'},
    
    --[[ Fire ]]--
    [`WEAPON_ELECTRIC_FENCE`] = {WeaponClasses= 'FIRE', Name='WEAPON_ELECTRIC_FENCE'}, -- Electric Fence 
    [`WEAPON_FIRE`] = {WeaponClasses= 'FIRE', Name='WEAPON_FIRE'}, -- Fire
    [`WEAPON_MOLOTOV`] = {WeaponClasses= 'FIRE', Name='WEAPON_MOLOTOV'},
    [`WEAPON_FLARE`] = {WeaponClasses= 'FIRE', Name='WEAPON_FLARE'},
    [`WEAPON_FLAREGUN`] = {WeaponClasses= 'FIRE', Name='WEAPON_FLAREGUN'},

    --[[ Suffocate ]]--
    [`WEAPON_DROWNING`] = {WeaponClasses= 'SUFFOCATING', Name='WEAPON_DROWNING'}, -- Drowning
    [`WEAPON_DROWNING_IN_VEHICLE`] = {WeaponClasses= 'SUFFOCATING', Name='WEAPON_DROWNING_IN_VEHICLE'}, -- Drowning Veh
    [`WEAPON_EXHAUSTION`] = {WeaponClasses= 'SUFFOCATING', Name='WEAPON_EXHAUSTION'}, -- Exhaust
    [`WEAPON_BZGAS`] = {WeaponClasses= 'SUFFOCATING', Name='WEAPON_BZGAS'},
    [`WEAPON_SMOKEGRENADE`] = {WeaponClasses= 'SUFFOCATING', Name='WEAPON_SMOKEGRENADE'},
}

IsDead = false
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(150)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

	PlayerLoaded = true
	ESX.PlayerData = ESX.GetPlayerData()
end)



AddEventHandler(  'onPlayerKilled', function(playerId, attackerId, reason, position)
    local player = GetPlayerByServerId(playerId)
    local attacker = GetPlayerByServerId(attackerId)

    local reasonString = 'killed'

    if reason == 0 or reason == 56 or reason == 1 or reason == 2 then
        reasonString = 'meleed'
    elseif reason == 3 then
        reasonString = 'knifed'
    elseif reason == 4 or reason == 6 or reason == 18 or reason == 51 then
        reasonString = 'bombed'
    elseif reason == 5 or reason == 19 then
        reasonString = 'burned'
    elseif reason == 7 or reason == 9 then
        reasonString = 'pistoled'
    elseif reason == 10 or reason == 11 then
        reasonString = 'shotgunned'
    elseif reason == 12 or reason == 13 or reason == 52 then
        reasonString = 'SMGd'
    elseif reason == 14 or reason == 15 or reason == 20 then
        reasonString = 'assaulted'
    elseif reason == 16 or reason == 17 then
        reasonString = 'sniped'
    elseif reason == 49 or reason == 50 then
        reasonString = 'ran over'
    end

    echo("obituary-deaths: onPlayerKilled\n")
	
    if player and attacker then
		print('kill event: ' .. attacker .. ' ' .. reasonString .. ' ' .. player )
        --exports.obituary:printObituary('<b>%s</b> %s <b>%s</b>.', attacker.name, reasonString, player.name)
		--print("<b>%s</b> %s <b>%s</b>.", attacker.name, reasonString, player.name)
    end
end)


RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(xPlayer)
	ESX.PlayerData = xPlayer
	PlayerLoaded = true
	
	ESX.TriggerServerCallback('124cb503-aea9-4fcd-b657-d92e7a1dcdbc', function(isDead)
		if isDead == true and Config.AntiCombatLog then
			while not PlayerLoaded do
				Citizen.Wait(2000)
			end
			SetEntityHealth(GetPlayerPed(-1),0)
			ESX.ShowNotification(_U('combatlog_message'))
			
		end
	end)
end)

RegisterNetEvent('8e8eaa1f-4a5e-4b5b-b52b-21c50839c367')
AddEventHandler('8e8eaa1f-4a5e-4b5b-b52b-21c50839c367', function()
	
	Citizen.CreateThread(function()
		if bleedoutTimer > Config.EarlyRespawnTimer then 
			--Get Difference
			local bdt = (Config.BleedoutTimer /1000) - bleedoutTimer
			
			if bdt > Config.RespawnDelayAfterRPDeathNoAmbulance /1000 then
				bleedoutTimer = (Config.RespawnDelayAfterRPDeathNoAmbulance /1000) - bdt
			else
			 bleedoutTimer = 1
			end
		else
			bleedoutTimer = 1
		end
		
		permissionToLeave = true
		Wait(120000)
		permissionToLeave = false
	end)

end)


RegisterNetEvent('fb521f91-1581-4381-b65b-b095cb6b7ee0')
AddEventHandler('fb521f91-1581-4381-b65b-b095cb6b7ee0', function(job)
	
	paintball = true
end)

RegisterNetEvent('3eb4c0e1-bd91-45b0-a92a-87a5194844f0')
AddEventHandler('3eb4c0e1-bd91-45b0-a92a-87a5194844f0', function(job)
	
	paintball = false
end)


RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function(job)
	ESX.PlayerData = ESX.GetPlayerData()
	
end)

AddEventHandler('880c0a93-b305-46b3-b84c-a120fee9e841', function()
	IsDead = false
	if FirstSpawn then
		exports.spawnmanager:setAutoSpawn(false) -- disable respawn
		FirstSpawn = false

		--[[ESX.TriggerServerCallback('124cb503-aea9-4fcd-b657-d92e7a1dcdbc', function(isDead)
			if isDead and Config.AntiCombatLog then
				while not PlayerLoaded do
					Citizen.Wait(1000)
				end

				ESX.ShowNotification(_U('combatlog_message'))
				RemoveItemsAfterRPDeath()
			end
		end)--]]
	end

end)

-- Create blips

--[[
Citizen.CreateThread(function()
	for k,v in pairs(Config.Hospitals) do
		if v.Blip.visible then
		local blip = AddBlipForCoord(v.Blip.coords)

		SetBlipSprite(blip, v.Blip.sprite)
		SetBlipScale(blip, v.Blip.scale)
		SetBlipColour(blip, v.Blip.color)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentSubstringPlayerName(_U('hospital'))
		EndTextCommandSetBlipName(blip)
		end
	end
end)--]]

-- Disable most inputs when dead
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if IsDead then
			DisableAllControlActions(0)
			DisableControlAction(0, Keys['F1'], true)
			EnableControlAction(0, Keys['F3'], true)
			EnableControlAction(0, Keys['T'], true)
			EnableControlAction(0, Keys['E'], true)
			EnableControlAction(0, Keys['N'], true)
			EnableControlAction(0, Keys['F6'], true)
			EnableControlAction(0, 1, true)
			EnableControlAction(0, 2, true)

		else
			Citizen.Wait(500)
		end
	end
end)

local isPlayerDead = false


Citizen.CreateThread(function()
    while true do
        if IsDead then
            if isPlayerDead == false then 
                isPlayerDead = true
                SendNUIMessage({
					setDisplay = true

	})
            end
        else 
            if isPlayerDead == true then
                isPlayerDead = false
                SendNUIMessage({
					setDisplay = false

	})
            end
        end
        Citizen.Wait(500)
    end
end)

function OnPlayerDeath()

	if paintball == false then
	  local second = 1000
			IsDead = true
			deathlocation = vector3(0,0,0)

			
			local player = PlayerId()
			local ped = GetPlayerPed(-1)
			local countr = 50
			while  IsPedFatallyInjured(ped) == false and countr > 0 do
                countr = countr - 1
                Wait(10)
            end
			if countr < 1 then
				SetEntityHealth(ped,0)
				Wait(100)
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
					killervehicleseat = GetPedInVehicleSeat(killer,-1)
				else killerinvehicle = false
				end
			end

			local killerid = NetworkGetPlayerIndexFromPed(killer)

			if killer ~= ped and killerid ~= nil and NetworkIsPlayerActive(killerid) then 
				killerid = GetPlayerServerId(killerid)
			else
				killerid = -1
			end
			

			if killer == ped or killer == -1 then
				TriggerEvent('baseevents:onPlayerDied', killertype, { table.unpack(GetEntityCoords(ped)) })
				TriggerServerEvent('baseevents:onPlayerDied', killertype, { table.unpack(GetEntityCoords(ped)) })
				TriggerServerEvent('7fcbafb2-e15d-4e94-9a71-c348def151ae',"DIED", json.encode({ table.unpack(GetEntityCoords(ped)) }))
			else
				--TriggerEvent('baseevents:onPlayerKilled', killerid, {killertype=killertype, weaponhash = killerweapon, killerinveh=killerinvehicle, killervehseat=killervehicleseat, killervehname=killervehiclename, killerpos={table.unpack(GetEntityCoords(ped))}})
				--TriggerServerEvent('baseevents:onPlayerKilled', killerid, {killertype=killertype, weaponhash = killerweapon, killerinveh=killerinvehicle, killervehseat=killervehicleseat, killervehname=killervehiclename, killerpos={table.unpack(GetEntityCoords(ped))}})
				if killerweapon ~= nil and weapons[tonumber(killerweapon)] ~= nil then
					--weaponhash = weapons[tonumber(killerweapon)].Name
					--ExecuteCommand
					TriggerServerEvent('7a869034-812d-4d8a-8839-f4e3b77dc07d',weapons[killerweapon],killerid)					
					killerweapon = weapons[killerweapon].Name
				end
				
				
				TriggerServerEvent('adc32cb3-e546-412f-ab1d-bf46fa46a555', json.encode({killertype=killertype, weaponhash = killerweapon, killerinveh=killerinvehicle, killervehseat=killervehicleseat, killervehname=killervehiclename, killerpos = GetEntityCoords(killer)}) .. ' COPS: ' .. exports.scoreboard:policeOnline() .. ' ', killerid)
				TriggerServerEvent('841a41b8-d3a5-4d25-9d37-2e0803c1e51a',"DIED", json.encode({killertype=killertype, weaponhash = killerweapon, killerinveh=killerinvehicle, killervehseat=killervehicleseat, killervehname=killervehiclename, killerpos = GetEntityCoords(killer)}) .. ' COPS: ' .. exports.scoreboard:policeOnline() .. ' ', killerid)
				ESX.ShowNotification('~o~Killer ID: ~w~' .. killerid)

			end

			local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
			if IsEntityDead(GetPlayerPed(-1)) then 
		
				SetPlayerInvincible(PlayerId(),true)
				--ragdol = 1
				--DisableControlAction(2, 303, true)
				--DisableControlAction(2, 246, true)
				ClearPedTasks(GetPlayerPed(-1))
				Wait(5000)
					
				NetworkResurrectLocalPlayer(plyPos, true, true, false)
					

				SetPedDiesInWater(GetPlayerPed(-1),false)
				SetEntityInvincible(GetPlayerPed(-1),true)
				
			end
		TriggerServerEvent('b7d7d891-78ef-4238-a282-3ccb40610465', true)

		StartDeathTimer()

		ClearPedTasksImmediately(GetPlayerPed(-1))
		StartScreenEffect('DeathFailOut', 0, false)
		
		if IsEntityDead(GetPlayerPed(-1)) then 
				ClearPedTasks(GetPlayerPed(-1))
				
				--ragdol = 1
				--DisableControlAction(2, 303, true)
				--DisableControlAction(2, 246, true)
				Wait(1000)

		NetworkResurrectLocalPlayer(plyPos, true, true, false)
		SetPlayerInvincible(PlayerId(),true)
		SetPedDiesInWater(GetPlayerPed(-1),false)
		end
		TriggerEvent('e579e46c-fb90-4b8b-aa82-11eab1d8b55d')
	end
end





RegisterNetEvent('2445618f-eeee-44fa-9f60-845c01aacf83')
AddEventHandler('2445618f-eeee-44fa-9f60-845c01aacf83', function(itemName)
	nextrevive_itemslost = false
end)

RegisterNetEvent('5dcd6e9a-34ba-4735-9f95-c5c05b58f77a')
AddEventHandler('5dcd6e9a-34ba-4735-9f95-c5c05b58f77a', function(itemName)
	ESX.UI.Menu.CloseAll()

	if itemName == 'medikit' then
		local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
		local playerPed = PlayerPedId()

		ESX.Streaming.RequestAnimDict(lib, function()
			TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)

			Citizen.Wait(500)
			while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
				Citizen.Wait(0)
				DisableAllControlActions(0)
			end
	
			TriggerEvent('510e2ee7-f0dc-4296-b3c8-e491a81e4f16', 'big', true)
			ESX.ShowNotification(_U('used_medikit'))
		end)

	elseif itemName == 'bandage' then
		local lib, anim = 'anim@heists@narcotics@funding@gang_idle', 'gang_chatting_idle01' -- TODO better animations
		local playerPed = PlayerPedId()

		ESX.Streaming.RequestAnimDict(lib, function()
			TaskPlayAnim(playerPed, lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)

			Citizen.Wait(500)
			while IsEntityPlayingAnim(playerPed, lib, anim, 3) do
				Citizen.Wait(0)
				DisableAllControlActions(0)
			end

			TriggerEvent('510e2ee7-f0dc-4296-b3c8-e491a81e4f16', 'small', true)
			ESX.ShowNotification(_U('used_bandage'))
		end)
	end
end)

function StartDistressSignal()
	Citizen.CreateThread(function()
		
		while IsDead do
		
			Citizen.Wait(2)
			SetTextFont(4)
			SetTextProportional(1)
			SetTextScale(0.45, 0.45)
			SetTextColour(185, 185, 185, 255)
			SetTextDropShadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			BeginTextCommandDisplayText('STRING')
			AddTextComponentSubstringPlayerName(_U('distress_send'))
			EndTextCommandDisplayText(0.175, 0.805)
			
			if IsDisabledControlPressed(0, Keys['G']) then
				SendDistressSignal()
				deathlocation = GetEntityCoords(PlayerPedId())

				Citizen.CreateThread(function()
					Citizen.Wait(1000 * 60 * 5)
					if IsDead then
						--StartDistressSignal()
					end
				end)

				break
			end
		end
	end)
end

function MenuInjuryHelp()
	Citizen.CreateThread(function()
		
		local skelenabled = nil
		pcall(function() skelenabled = exports["skel"]:skelenabled() end)
		while IsDead and skelenabled ~= nil do

			Citizen.Wait(2)
			SetTextFont(4)
			SetTextProportional(1)
			SetTextScale(0.45, 0.45)
			SetTextColour(185, 185, 185, 255)
			SetTextDropShadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			BeginTextCommandDisplayText('STRING')
			AddTextComponentSubstringPlayerName(_U('distress_view'))

			EndTextCommandDisplayText(0.175, 0.855)
			
			if IsDisabledControlPressed(0, Keys['H']) then
				TriggerEvent('9978c21b-2912-449a-a235-151343263123')
			end
		end
	end)
end



function StartNoOtherAmbulances()
	
	Citizen.CreateThread(function()

		while IsDead do
		
			Citizen.Wait(2)

			SetTextFont(4)
			SetTextProportional(1)
			SetTextScale(0.55, 0.55)
			SetTextColour(185, 185, 185, 255)
			SetTextDropShadow(0, 0, 0, 0, 255)
			SetTextEdge(1, 0, 0, 0, 255)
			SetTextDropShadow()
			SetTextOutline()
			BeginTextCommandDisplayText('STRING')
			AddTextComponentSubstringPlayerName('There are no paramedics currently online, death timer has been reduced.')
			EndTextCommandDisplayText(0.175, 0.605)
			

		end
	end)
end
--[[
function SendDistressSignal()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(PlayerPedId())

	ESX.ShowNotification(_U('distress_sent'))
	TriggerServerEvent('476baedb-3990-4c66-ac36-81a27a3d3e9a', 'ambulance', _U('distress_message'), false, {
		x = coords.x,
		y = coords.y,
		z = coords.z
	})
end
--]]

function SendDistressSignal()
	local playerPed = PlayerPedId()
	PedPosition		= GetEntityCoords(playerPed)
	
	local PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z }

	ESX.ShowNotification(_U('distress_sent'))

    TriggerServerEvent('c916860b-b2ca-42eb-9eac-cf20b6341eac', 'ambulance', _U('distress_message'), PlayerCoords, {

		PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z },
	})
	--[[
	TriggerServerEvent('c916860b-b2ca-42eb-9eac-cf20b6341eac', 'police', 'AMBVIC have advised of a possible suspicious assault and request police attendance.', PlayerCoords, {

		PlayerCoords = { x = PedPosition.x, y = PedPosition.y, z = PedPosition.z },
	}) --]]
end



function DrawGenericTextThisFrame()
	SetTextFont(4)
	SetTextProportional(0)
	SetTextScale(0.0, 0.5)
	SetTextColour(255, 255, 255, 255)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)
end

function secondsToClock(seconds)
	local seconds, hours, mins, secs = tonumber(seconds), 0, 0, 0

	if seconds <= 0 then
		return 0, 0
	else
		local hours = string.format("%02.f", math.floor(seconds / 3600))
		local mins = string.format("%02.f", math.floor(seconds / 60 - (hours * 60)))
		local secs = string.format("%02.f", math.floor(seconds - hours * 3600 - mins * 60))

		return mins, secs
	end
end




function StartDeathTimer()
	local canPayFine = false
	local earlySpawnTimer = 1


	Citizen.CreateThread(function()
		-- early respawn timer


		-- bleedout timer
		while bleedoutTimer > 0 and IsDead do
			Citizen.Wait(1000)

			if bleedoutTimer > 0 then
				bleedoutTimer = bleedoutTimer - 1
			end
		end
	end)
	bleedoutTimer = math.floor(Config.BleedoutTimer / 1000)
	Citizen.CreateThread(function()
		local text, timeHeld
	
		local checked = false
		-- bleedout timer
		while IsDead do
			Citizen.Wait(0)
			
			text = _U('respawn_bleedout_in', secondsToClock(bleedoutTimer))
			local pdloc = GetEntityCoords(GetPlayerPed(-1))
			if checked == false then
				checked = true

					emscount = exports['scoreboard']:ambulanceOnline() 
							
					if emscount == 0 or (ESX.PlayerData.job.name == 'ambulance' and emscount == 1) then
						bleedoutTimer = Config.RespawnDelayAfterRPDeathNoAmbulance / 1000
						if ESX.PlayerData.job.name == "police" or ESX.PlayerData.job.name == "ambulance" then
							bleedoutTimer = Config.RespawnDelayAfterRPDeathNoAmbulanceEmergency / 1000
						end
						StartNoOtherAmbulances()
					else
						bleedoutTimer = Config.BleedoutTimer / 1000
						if ESX.PlayerData.job.name == "police" or ESX.PlayerData.job.name == "ambulance" then
							bleedoutTimer = Config.RespawnDelayAfterRPDeathNoAmbulanceEmergency / 1000
						end
						StartDistressSignal()
					end
					MenuInjuryHelp()
	
			end
			SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
			--[[]
			if not Config.EarlyRespawnFine then
				text = text .. _U('respawn_bleedout_prompt')

				if IsControlPressed(0, Keys['E']) and timeHeld > 60 then
					RemoveItemsAfterRPDeath()
					break
				end
			elseif Config.EarlyRespawnFine and canPayFine then
				text = text .. _U('respawn_bleedout_fine', ESX.Math.GroupDigits(Config.EarlyRespawnFineAmount))

				if IsControlPressed(0, Keys['E']) and timeHeld > 60 then
					TriggerServerEvent('1a595247-fe88-4870-988f-26375b36a122')
					RemoveItemsAfterRPDeath()
					break
				end
			end--]]
			if deathlocation ~= vector3(0,0,0) then
				--check if 
				if #(deathlocation - pdloc) > 100 then
					TriggerServerEvent('e17a1314-eff1-414f-932c-738dc12ea834')
					deathlocation = vector3(0,0,0)
				end
			end
			
			if bleedoutTimer == 0 then
				text = _U('respawn_bleedout_prompt')
				if IsControlPressed(0, Keys['E']) and timeHeld > 60 then
					RemoveItemsAfterRPDeath()
					TriggerServerEvent('e17a1314-eff1-414f-932c-738dc12ea834')
					break
				end
			end

			if IsControlPressed(0, Keys['E']) then
				timeHeld = timeHeld + 1
			else
				timeHeld = 0
			end

			DrawGenericTextThisFrame()

			SetTextEntry("STRING")
			AddTextComponentString(text)
			DrawText(0.5, 0.8)
		end
			
		if bleedoutTimer < 1 and IsDead then
			RemoveItemsAfterRPDeath()
		end
	end)
end



function RemoveItemsAfterRPDeath()
	TriggerServerEvent('b7d7d891-78ef-4238-a282-3ccb40610465', false)

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(10)
		end
		
		local closest = {}
		local pedloc = GetEntityCoords(PlayerPedId())
			
		local distanceCity = #(pedloc - Config.RespawnPoint.coords)
		local distanceMtThomas = #(pedloc - Config.RespawnPointSandy.coords)
		local distancePaleto = #(pedloc - Config.RespawnPointPaleto.coords)
		
		if distanceCity < distanceMtThomas and distanceCity < distancePaleto then
			closest = Config.RespawnPoint
		end
		
		if distancePaleto < distanceMtThomas and distancePaleto < distanceCity then
			closest = Config.RespawnPointPaleto
		end
		
		if distanceMtThomas < distanceCity and distanceMtThomas < distancePaleto then
			closest = Config.RespawnPointSandy
		end
		
		
		ESX.TriggerServerCallback('c0691a6b-b360-4370-abaf-a7696a596bad', function()
			local formattedCoords = {
				x = closest.coords.x,
				y = closest.coords.y,
				z = closest.coords.z
			}

			ESX.SetPlayerData('lastPosition', formattedCoords)
			--ESX.SetPlayerData('loadout', {})
			SetPlayerInvincible(PlayerId(),false)
			TriggerServerEvent('f1064a0b-f20d-473c-9450-8dbc5730a7b7', formattedCoords)
			RespawnPed(PlayerPedId(), formattedCoords, Config.RespawnPoint.heading)
			StopScreenEffect('DeathFailOut')
			nextrevive_itemslost = false
			DoScreenFadeIn(800)
		end,nextrevive_itemslost)
	end)
end


function RemainInPlace()
	TriggerServerEvent('b7d7d891-78ef-4238-a282-3ccb40610465', false)

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(10)
		end
		
		local playerPed = GetPlayerPed(-1)
		local coords	= GetEntityCoords(playerPed)

		SetPlayerInvincible(PlayerId(),false)
		StopScreenEffect('DeathFailOut')
		DoScreenFadeIn(800)


	end)
end

RegisterNetEvent('1e3d6ace-ae88-4d80-8e5f-0f52f7d447bf')
AddEventHandler('1e3d6ace-ae88-4d80-8e5f-0f52f7d447bf', function()
	nextrevive_itemslost = true
end)

function RespawnPed(ped, coords, heading)
	SetEntityCoordsNoOffset(ped, coords.x, coords.y, coords.z, false, false, false, true)
	SetPlayerInvincible(ped, false)
	NetworkResurrectLocalPlayer(coords.x, coords.y, coords.z, heading, true, false)
	SetPlayerInvincible(ped, false)
	ESX.UI.Menu.CloseAll()
	
	TriggerServerEvent('esx:onPlayerSpawn')
	TriggerEvent('67d7b049-9a6f-4b10-9c9d-3828857b5ff4')
	TriggerEvent('880c0a93-b305-46b3-b84c-a120fee9e841', coords.x, coords.y, coords.z)
end

RegisterNetEvent('59809f17-d8ce-49dd-ae30-d5e90a7761a7')
AddEventHandler('59809f17-d8ce-49dd-ae30-d5e90a7761a7', function(phoneNumber, contacts)
	local specialContact = {
		name       = 'Amb/Fire',
		number     = 'ambulance',
		base64Icon = 'data:image/png;base64,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'
	}

	TriggerEvent('e25977c9-9f2b-4d5d-a807-a8c7a0c964d5', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

AddEventHandler('2df4c490-68a8-4c7e-896a-9fc552e16210', function(data)
	OnPlayerDeath()
end)

RegisterNetEvent('c97adeb3-14e4-4be0-b519-a93d5ee530f3')
AddEventHandler('c97adeb3-14e4-4be0-b519-a93d5ee530f3', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	TriggerServerEvent('b7d7d891-78ef-4238-a282-3ccb40610465', false)

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(50)
		end
		
		local formattedCoords = {
			x = ESX.Math.Round(coords.x, 1),
			y = ESX.Math.Round(coords.y, 1),
			z = ESX.Math.Round(coords.z, 1)
		}
		
		SetPlayerInvincible(PlayerId(),false)
		Citizen.Wait(200)
		ESX.SetPlayerData('lastPosition', formattedCoords)
		Citizen.Wait(200)
		TriggerServerEvent('f1064a0b-f20d-473c-9450-8dbc5730a7b7', formattedCoords)
		Citizen.Wait(200)
		RespawnPed(playerPed, formattedCoords, 0.0)
		SetPedDiesInWater(GetPlayerPed(-1),true)
		SetEntityInvincible(GetPlayerPed(-1),false)
		
		TriggerServerEvent('9341598e-bf2f-4bc0-a1e2-847c8bbd8112')
		StopScreenEffect('DeathFailOut')
		DoScreenFadeIn(800)
		--TriggerEvent('15ba6364-24b3-438c-8d0c-a54a262fc7da')
		--TriggerEvent('d2985e19-91d6-4cf5-9ebb-536b332c9cde')
		SetPedDiesInWater(GetPlayerPed(-1),true)
		SetEntityInvincible(GetPlayerPed(-1),false)
	end)
end)


RegisterNetEvent('f9a4ef75-8270-4e63-b3f9-9b01fcb45634')
AddEventHandler('f9a4ef75-8270-4e63-b3f9-9b01fcb45634', function()
	if IsDead then
		local playerPed = PlayerPedId()
		local coords = GetEntityCoords(playerPed)
		Wait(math.random(100,2300))
		TriggerServerEvent('b7d7d891-78ef-4238-a282-3ccb40610465', false)

		Citizen.CreateThread(function()
			DoScreenFadeOut(800)

			while not IsScreenFadedOut() do
				Citizen.Wait(50)
			end

			local formattedCoords = {
				x = ESX.Math.Round(coords.x, 1),
				y = ESX.Math.Round(coords.y, 1),
				z = ESX.Math.Round(coords.z, 1)
			}
		
			SetPlayerInvincible(PlayerId(),false)
			Citizen.Wait(200)
			ESX.SetPlayerData('lastPosition', formattedCoords)
			Citizen.Wait(200)
			TriggerServerEvent('f1064a0b-f20d-473c-9450-8dbc5730a7b7', formattedCoords)
			Citizen.Wait(200)
			RespawnPed(playerPed, formattedCoords, 0.0)
			SetPedDiesInWater(GetPlayerPed(-1),true)
			SetEntityInvincible(GetPlayerPed(-1),false)

			playerPed = PlayerPedId()
			SetPedArmour(playerPed, 0)
			ClearPedEnvDirt(playerPed)
			ClearPedBloodDamage(playerPed)
			ResetPedVisibleDamage(playerPed)
			ClearPedLastWeaponDamage(playerPed)
			ResetPedMovementClipset(playerPed, 0)
			SetEntityInvincible(playerPed,false)
			SetPedDiesInWater(playerPed,true)

			StopScreenEffect('DeathFailOut')
			DoScreenFadeIn(800)
			TriggerServerEvent('9341598e-bf2f-4bc0-a1e2-847c8bbd8112')
			TriggerEvent(  'MF_SkeletalSystem:HealBonesN', "all")
			SetPedDiesInWater(GetPlayerPed(-1),true)
			SetEntityInvincible(GetPlayerPed(-1),false)
		end)
	end
end)


-- Load unloaded IPLs
if Config.LoadIpl then
	Citizen.CreateThread(function()
		RequestIpl('Coroner_Int_on') -- Morgue
	end)
end


RegisterNetEvent('1b176e49-f5dd-44b6-b500-d7cdf749623d')
AddEventHandler('1b176e49-f5dd-44b6-b500-d7cdf749623d', function()
	print('increased BO timer')
	bleedoutTimer = bleedoutTimer + 300
end)

function AllowRespawn(timer)
	bleedoutTimer = timer
end



RegisterNetEvent('c96b0ab1-84bf-4067-bd0e-4fdbbca09d9d')
AddEventHandler('c96b0ab1-84bf-4067-bd0e-4fdbbca09d9d', function(zloc,zxx,zyy,zzz)
		print('trigger ambulance call')
		local loc = zloc
		local xx = zxx
		local yy = zyy
		local zz = zzz
		
		Citizen.CreateThread(function()
			--Wait(math.random(5000,30000))
			PlayerCoords = { x = xx, y = yy, z = zz }
			TriggerServerEvent('575a96d1-9d2b-4370-b9d6-4cf0070492da', 'ambulance', 'Possible Fire Reported: ' ..loc, PlayerCoords, {

				PlayerCoords = { x = xx, y = yy, z = zz },
			})
			
			Citizen.Wait(math.random(40000,50000))
			print('trigger police call')
			TriggerServerEvent('575a96d1-9d2b-4370-b9d6-4cf0070492da', 'police', 'Possible Fire Reported: ' ..loc .. ' Police units please provide crowd/traffic control', PlayerCoords, {

				PlayerCoords = { x = xx, y = yy, z = zz },
			})
		end)
end)



