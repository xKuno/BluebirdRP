
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	Wait(500)
	PlayerData = ESX.GetPlayerData()
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	
end)

RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function(job)
    PlayerData.job = job
end)

local currentWeapon
local currentWeaponSlot
local currentWepAttachs = {}
canFire = true

RegisterNetEvent('6fd2c965-cb55-430c-a2cd-eb9dfbb98bd9')
AddEventHandler('6fd2c965-cb55-430c-a2cd-eb9dfbb98bd9', function(weapon)

	if exports.zone:isPlayerInSafeZone() == false then
		print('has landed ' .. weapon)
		if currentWeapon == weapon then
			RemoveWeapon(currentWeapon)
			currentWeapon = nil
			currentWeaponSlot = nil
			return
		elseif currentWeapon ~= nil then
			RemoveWeapon(currentWeapon)
			currentWeapon = nil
			currentWeaponSlot = nil
		end
		currentWeapon = weapon
		GiveWeapon(currentWeapon)
		TriggerEvent('0f7594f9-29a3-4b1f-8967-1dc8f5f1ddc3', weapon,"You withdrew ", 1, false)
	end

end)

RegisterNetEvent('4ea73981-7d32-4255-b9b8-a87aef97c8d8')
AddEventHandler('4ea73981-7d32-4255-b9b8-a87aef97c8d8', function()
    if currentWeapon ~= nil then
        RemoveWeapon(currentWeapon)
        currentWeapon = nil
        currentWeaponSlot = nil
    end
end)

-- This is just an example for the carbine rifle, do the same for the following...

local weapons = {
	[tostring(GetHashKey('WEAPON_CARBINERIFLE'))] = { -- Didn't test this, if it leads to problems replace with hardcoded hash AS A STRING
		['scope'] = GetHashKey('COMPONENT_AT_SCOPE_MEDIUM'),
		['suppressor'] = GetHashKey('COMPONENT_AT_AR_SUPP'),
		['grip'] = GetHashKey('COMPONENT_AT_AR_AFGRIP'),
		['extendedmag'] = GetHashKey('COMPONENT_CARBINERIFLE_CLIP_02'),
		['flashlight'] = GetHashKey('COMPONENT_AT_AR_FLSH')
	}
}

RegisterNetEvent('81d80eae-8b34-41ce-a03b-d53d4836d865')
AddEventHandler('81d80eae-8b34-41ce-a03b-d53d4836d865', function(attach)
    local playerPed = PlayerPedId()
    local hasAttach = false
    if currentWeapon ~= nil then
        local hash = GetHashKey(currentWeapon)
        for i = 1, #currentWepAttachs do
            if currentWepAttachs[i] == attach then
                hasAttach = true
            end
		end
		if weapons[tostring( hash )] ~= nil and weapons[tostring( hash )][attach] ~= nil and not hasAttach then
			ESX.TriggerServerCallback('47db4b6c-ae24-4c41-9048-1693f5aab1a7', function(cb) end, attach)
			table.insert(currentWepAttachs, attach)
            GiveWeaponComponentToPed( playerPed, hash, weapons[tostring( hash )][attach] )
        else
            exports['b1g_notify']:Notify('error', 'This attachment is not compatible or is already equipped.')
        end
    else
        exports['b1g_notify']:Notify('error', 'No weapon selected.')
    end
end)

RegisterCommand("desequipar", function(source, args, rawCommand)
    if currentWeapon ~= nil then
        local playerPed = PlayerPedId()
        local hash = GetHashKey(currentWeapon)
        if args[1] then
			local attach = args[1]
            for i = 1, #currentWepAttachs do
                if currentWepAttachs[i] == attach then
                    ESX.TriggerServerCallback('775f7c81-d1cf-45e2-a2b5-5f8afa039c90', function(cb)
                        if cb then
                            table.remove(currentWepAttachs, i)
                            RemoveWeaponComponentFromPed(playerPed, hash, weapons[tostring( hash )][attach])
                        else
                            exports['b1g_notify']:Notify('error', 'Insufficient space.')
                        end          
                    end, currentWepAttachs[i], 1)
                    return
                end
            end
            exports['b1g_notify']:Notify('error', 'This weapon does not have this attachment.')
		else
			for i = 1, #currentWepAttachs do
				if currentWepAttachs[i] ~= nil then
					ESX.TriggerServerCallback('775f7c81-d1cf-45e2-a2b5-5f8afa039c90', function(cb)
                        if cb then
                            RemoveWeaponComponentFromPed(playerPed, hash, weapons[tostring( hash )][currentWepAttachs[i]])
							table.remove(currentWepAttachs, i)
                        else
                            exports['b1g_notify']:Notify('error', 'Insufficient space.')
                        end          
                    end, currentWepAttachs[i], 1)
				end
			end
		end
    else
        exports['b1g_notify']:Notify('error', 'You don\'t have a gun in your hand.')
    end
end)

function RemoveWeapon(weapon)
    local checkh = Config.Throwables
    local playerPed = PlayerPedId()
    local hash = GetHashKey(weapon)
    local wepInfo = { 
        count = GetAmmoInPedWeapon(playerPed, hash),
        attach = currentWepAttachs
    }
    canFire = false
    disable()
    if checkh[weapon] == hash then
        if GetSelectedPedWeapon(playerPed) == hash then
            ESX.TriggerServerCallback('775f7c81-d1cf-45e2-a2b5-5f8afa039c90', function(cb)
            end, weapon, 1)
        end
    end
	--[[
	if weapon ~= 'weapon_switchblade' then
		if PlayerData.job ~= nil and PlayerData.job.name == 'police' then --and GetWeapontypeGroup(hash) == 416676503 then
			if not HasAnimDictLoaded("reaction@intimidation@cop@unarmed") then
				loadAnimDict( "reaction@intimidation@cop@unarmed" )
			end
			TaskPlayAnim(playerPed, "reaction@intimidation@cop@unarmed", "outro", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
			Citizen.Wait(100)
		else
			if not HasAnimDictLoaded("reaction@intimidation@1h") then
				loadAnimDict( "reaction@intimidation@1h" )
			end
			TaskPlayAnimAdvanced(playerPed, "reaction@intimidation@1h", "outro", GetEntityCoords(playerPed, true), 0, 0, GetEntityHeading(playerPed), 8.0, 3.0, -1, 50, 0, 0, 0)
			Citizen.Wait(1600)
		end
	end --]]
    --RemoveWeaponFromPed(playerPed, hash)
	SetCurrentPedWeapon(playerPed,`WEAPON_UNARMED`,false)
	ClearPedTasks(playerPed)
    canFire = true
    TriggerEvent('0f7594f9-29a3-4b1f-8967-1dc8f5f1ddc3', weapon,"You put away", 1, false)
end

function GiveWeapon(weapon)
    local checkh = Config.Throwables
    local playerPed = PlayerPedId()
    local hash = GetHashKey(weapon)
    if not HasAnimDictLoaded("reaction@intimidation@1h") then
        loadAnimDict( "reaction@intimidation@1h" )
    end
    if weapon == 'WEAPON_PETROLCAN' then
        local coords = GetEntityCoords(playerPed)
        if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 2.0) then
            TriggerEvent('4ea73981-7d32-4255-b9b8-a87aef97c8d8')
            TriggerEvent('0cf5e8ad-f0c7-4fb5-b8ae-51f44de6f6d5')
        else
            canFire = false
            disable()
            TaskPlayAnimAdvanced(playerPed, "reaction@intimidation@1h", "intro", GetEntityCoords(playerPed, true), 0, 0, GetEntityHeading(playerPed), 8.0, 3.0, -1, 50, 0, 0, 0)
            Citizen.Wait(1600)
			SetCurrentPedWeapon(playerPed,hash,true)
            GiveWeaponToPed(playerPed, hash, 1, false, true)
            SetPedAmmo(playerPed, hash, 1000)
            ClearPedTasks(playerPed)
            canFire = true
        end
    else
	    canFire = false
        disable()
		--[[if PlayerData.job ~= nil and PlayerData.job.name == 'police' then --and GetWeapontypeGroup(hash) == 416676503 then
            if not HasAnimDictLoaded("rcmjosh4") then
                loadAnimDict( "rcmjosh4" )
            end
            TaskPlayAnim(playerPed, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
            Citizen.Wait(500)
        else
            TaskPlayAnimAdvanced(playerPed, "reaction@intimidation@1h", "intro", GetEntityCoords(playerPed, true), 0, 0, GetEntityHeading(playerPed), 8.0, 3.0, -1, 50, 0, 0, 0)          
            Citizen.Wait(1600)
        end--]]
		Wait(200)
		if weapon ~= 'weapon_switchblade' then
			SetCurrentPedWeapon(playerPed,hash,true)
			ClearPedTasks(playerPed)
		else
			SetCurrentPedWeapon(playerPed,hash,false)
		end
        canFire = true
    end
end

--[[Citizen.CreateThread(function()
    local sleep = 1500
    while true do
        local player = PlayerPedId()
        if IsPedShooting(player) then
            sleep = 10
            for k, v in pairs(Config.Throwables) do
                if k == currentWeapon then
                    ESX.TriggerServerCallback('35ecc9ef-f9b4-4314-bd28-17e91ffd1352', function(removed)
                        if removed then
                            TriggerEvent('4ea73981-7d32-4255-b9b8-a87aef97c8d8')
                        end
                    end, currentWeapon, 1)
                end
            end
        else
            sleep = 1500
        end
        Citizen.Wait(sleep)
    end
end)]]

function disable()
	Citizen.CreateThread(function ()
		while not canFire do
			Citizen.Wait(10)
			DisableControlAction(0, 25, true)
			DisablePlayerFiring(player, true)
		end
	end)
end

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(10)
	end
end
