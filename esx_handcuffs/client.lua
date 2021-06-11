-- ESX
ESX               = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(xPlayer)
  PlayerData = xPlayer
end)

-- Locals

local cuffed = false
local dict = "mp_arresting"
local anim = "idle"
local flags = 49
local ped = PlayerPedId()
local changed = false
local prevMaleVariation = 0
local prevFemaleVariation = 0
local femaleHash = GetHashKey("mp_f_freemode_01")
local maleHash = GetHashKey("mp_m_freemode_01")
local IsLockpicking    = false

-- Sätt på handklovar
RegisterNetEvent('4ef12434-3a68-4044-b5a5-2f12975f5e73')
AddEventHandler('4ef12434-3a68-4044-b5a5-2f12975f5e73', function()
    ped = GetPlayerPed(-1)
    RequestAnimDict(dict)

    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end

        if GetEntityModel(ped) == femaleHash then
            prevFemaleVariation = GetPedDrawableVariation(ped, 7)
            SetPedComponentVariation(ped, 7, 25, 0, 0)
        elseif GetEntityModel(ped) == maleHash then
            prevMaleVariation = GetPedDrawableVariation(ped, 7)
            SetPedComponentVariation(ped, 7, 41, 0, 0)
        end

        SetEnableHandcuffs(ped, true)
        TaskPlayAnim(ped, dict, anim, 8.0, -8, -1, flags, 0, 0, 0, 0)

    cuffed = not cuffed
    changed = true
end)
--- Uncufing
RegisterNetEvent('5ec1e605-c0fe-4096-8108-09d4ae2ccd5f')
AddEventHandler('5ec1e605-c0fe-4096-8108-09d4ae2ccd5f', function()
    ped = GetPlayerPed(-1)
    RequestAnimDict(dict)

    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end

        ClearPedTasks(ped)
        SetEnableHandcuffs(ped, false)
        UncuffPed(ped)

        if GetEntityModel(ped) == femaleHash then -- mp female
            SetPedComponentVariation(ped, 7, prevFemaleVariation, 0, 0)
        elseif GetEntityModel(ped) == maleHash then -- mp male
            SetPedComponentVariation(ped, 7, prevMaleVariation, 0, 0)
        end

    cuffed = not cuffed

    changed = true
end)


function amicuffed()
	return cuffed
end


RegisterNetEvent('e430b6bd-3d54-4841-b66d-90862cb13ab7')
AddEventHandler('e430b6bd-3d54-4841-b66d-90862cb13ab7', function()
  local player, distance = ESX.Game.GetClosestPlayer()


  if distance ~= -1 and distance <= 1.5 and IsPedRagdoll(GetPlayerPed(player)) == false and IsPedRagdoll(PlayerPedId()) == false and cuffed == false then
				
		local playerPed = GetPlayerPed(-1)
		Citizen.CreateThread(function()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			if prop == nil then
				prop = CreateObject(`p_cs_cuffs_02_s`, x, y, z+0.2,  true, true, true)
			end
			--AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 18905), 0.18, 0.038, 0.001, 175.0, 300.0, 0.0, true, true, false, true, 1, true)
			AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 18905), 0.18, 0.028, 0.001, 360.0, 100.0, 0.0, true, true, false, true, 1, true)
			--AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 18905), 0.13, 0.013, 0.001, 360.0, 60.0, 0.0, true, true, false, true, 1, true)
			Citizen.Wait(3800)
			IsAnimated = false
			ClearPedSecondaryTask(playerPed)
			DeleteObject(prop)
			prop = nil
		end)
		RequestAnimDict("amb@prop_human_bum_bin@idle_b")
		RequestAnimDict("amb@prop_human_bum_bin@idle_b")
		while not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b") do
			Citizen.Wait(5)
		end
		TaskPlayAnim(GetPlayerPed(-1),"amb@prop_human_bum_bin@idle_b","idle_d",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0, 130)
		Wait(3000)

		local cplayer, cdistance = ESX.Game.GetClosestPlayer()
		
		if cplayer ~= player or cplayer == player and cdistance > 2.3 then
			ESX.ShowNotification('~r~They escaped, handcuffs did not work')
			ClearPedTasksImmediately(PlayerPedId())
			return
		end
		ESX.ShowNotification('~g~You have used your handcuffs')
				
		TriggerServerEvent('206979c3-a736-48eb-ade4-058dc215efe4', GetPlayerServerId(player),"28dhja92hjd1d98lkj1d901jk")
		ESX.ShowNotification('~r~Person Cuffed/UnCuffed')
  else
    ESX.ShowNotification('No players nearby')
  end
end)

RegisterNetEvent('1854ab22-b67d-4b8e-b3a3-a86b53b3b22a')
AddEventHandler('1854ab22-b67d-4b8e-b3a3-a86b53b3b22a', function()
	local player, distance = ESX.Game.GetClosestPlayer()
  if distance ~= -1 and distance <= 3.0 then
      TriggerServerEvent('ad678a1f-fad9-4457-b9ba-7899db70a904', GetPlayerServerId(player))
  else
    ESX.ShowNotification('No players nearby')
	end
end)




RegisterNetEvent('d86685c7-7e29-473b-b0d0-2caa562a8d3c')
AddEventHandler('d86685c7-7e29-473b-b0d0-2caa562a8d3c', function()

  local player, distance = ESX.Game.GetClosestPlayer()
	local ped = GetPlayerPed(-1)

	if IsLockpicking == false then
		ESX.UI.Menu.CloseAll()
		FreezeEntityPosition(player,  true)
		FreezeEntityPosition(ped,  true)
		
		TriggerServerEvent('dc009034-41f3-43c8-af96-005246c48a01', GetPlayerServerId(player))

		TaskStartScenarioInPlace(ped, "WORLD_HUMAN_WELDING", 0, true)

		IsLockpicking = true

		Wait(30000)

		IsLockpicking = false

		FreezeEntityPosition(player,  false)
		FreezeEntityPosition(ped,  false)

		ClearPedTasksImmediately(ped)
		wasPedcuffed = nil
		TriggerServerEvent('206979c3-a736-48eb-ade4-058dc215efe4', GetPlayerServerId(player),"28dhja92hjd1d98lkj1d901jk")
		
		ESX.ShowNotification('Handcuffs unlocked')
	else
		ESX.ShowNotification('Your are already lockpicking handcuffs')
	end
end)

-- ??
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if changed and not cuffed then
            ped = PlayerPedId()
            local IsCuffed = IsPedCuffed(ped)
            if IsCuffed == false and not IsEntityPlayingAnim(PlayerPedId(), dict, anim, 3) then
                Citizen.Wait(0)
                TaskPlayAnim(ped, dict, anim, 8.0, -8, -1, flags, 0, 0, 0, 0)
            end
        else
            changed = false
        end
    end
end)


