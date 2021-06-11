local shieldActive = false
local shieldEntity = nil
local hadPistol = false

-- ANIM
local animDict = "combat@gestures@gang@pistol_1h@beckon"
local animName = "0"

local prop = `prop_ballistic_shield`
local pistol = `WEAPON_COMBATPISTOL`

RegisterCommand("shield", function()
    if shieldActive then
        DisableShield()
    else
        EnableShield()
    end
end, false)

function EnableShield()
	if exports['webcops']:amiloggedin() == true then
		shieldActive = true
		local ped = GetPlayerPed(-1)
		local pedPos = GetEntityCoords(ped, false)
		
		RequestAnimDict(animDict)
		while not HasAnimDictLoaded(animDict) do
			Citizen.Wait(100)
		end

		TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, (2 + 16 + 32), 0.0, 0, 0, 0)

		RequestModel(prop)
		while not HasModelLoaded(prop) do
			Citizen.Wait(100)
		end

		local shield = CreateObject(prop, pedPos.x, pedPos.y, pedPos.z, 1, 1, 1)
		shieldEntity = shield
		AttachEntityToEntity(shieldEntity, ped, GetEntityBoneIndexByName(ped, "IK_L_Hand"), 0.0, -0.05, -0.10, -30.0, 180.0, 40.0, 0, 0, 1, 0, 0, 1)
		SetWeaponAnimationOverride(ped, GetHashKey("Gang1H"))

		if HasPedGotWeapon(ped, pistol, 0) or GetSelectedPedWeapon(ped) == pistol then
			SetCurrentPedWeapon(ped, pistol, 1)
			hadPistol = true
		else
		   -- GiveWeaponToPed(ped, pistol, 300, 0, 1)
		  --  SetCurrentPedWeapon(ped, pistol, 1)
		   -- hadPistol = false
		end
		SetEnableHandcuffs(ped, true)
	end
end

function DisableShield()
    local ped = GetPlayerPed(-1)
    DeleteEntity(shieldEntity)
    ClearPedTasksImmediately(ped)
    SetWeaponAnimationOverride(ped, GetHashKey("Default"))

    if not hadPistol then
        RemoveWeaponFromPed(ped, pistol)
    end
    SetEnableHandcuffs(ped, false)
    hadPistol = false
    shieldActive = false
end

Citizen.CreateThread(function()
    while true do
        if shieldActive then
            local ped = GetPlayerPed(-1)
            if not IsEntityPlayingAnim(ped, animDict, animName, 1) then
                RequestAnimDict(animDict)
                while not HasAnimDictLoaded(animDict) do
                    Citizen.Wait(100)
                end
            
                TaskPlayAnim(ped, animDict, animName, 8.0, -8.0, -1, (2 + 16 + 32), 0.0, 0, 0, 0)
            end
        end
        Citizen.Wait(1000)
    end
end)