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
RegisterNetEvent('b1d2d6ee-aea7-4e83-9582-95ccae4e5d3f')
AddEventHandler('b1d2d6ee-aea7-4e83-9582-95ccae4e5d3f', function()
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

        SetEnablerope(ped, true)
        TaskPlayAnim(ped, dict, anim, 8.0, -8, -1, flags, 0, 0, 0, 0)

    cuffed = not cuffed
    changed = true
end)

-- Ta av handklovar
RegisterNetEvent('3c7dd9de-3c96-4395-97c1-103f694eaf72')
AddEventHandler('3c7dd9de-3c96-4395-97c1-103f694eaf72', function()
    ped = GetPlayerPed(-1)
    RequestAnimDict(dict)

    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end

        ClearPedTasks(ped)
        SetEnablerope(ped, false)
        UncuffPed(ped)

        if GetEntityModel(ped) == femaleHash then -- mp female
            SetPedComponentVariation(ped, 7, prevFemaleVariation, 0, 0)
        elseif GetEntityModel(ped) == maleHash then -- mp male
            SetPedComponentVariation(ped, 7, prevMaleVariation, 0, 0)
        end

    cuffed = not cuffed

    changed = true
end)

RegisterNetEvent('3c602e0a-06e3-4cf6-8354-3d2a3c57d3b5')
AddEventHandler('3c602e0a-06e3-4cf6-8354-3d2a3c57d3b5', function()
  local player, distance = ESX.Game.GetClosestPlayer()
  if distance ~= -1 and distance <= 3.0 then
  				  RequestAnimDict("amb@prop_human_bum_bin@idle_b")
				  TaskPlayAnim(ped,"amb@prop_human_bum_bin@idle_b","idle_d",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0, 130)
								ESX.ShowNotification('~g~You have used your rope')
				Wait(8000)
		TriggerServerEvent('esx_policejob:rope', GetPlayerServerId(player))
				ESX.ShowNotification('~r~Person dragged/UnDragged')
  else
    ESX.ShowNotification('No players nearby')
	end
end)

RegisterNetEvent('ed633e76-18c5-415c-84d1-7df76dacdc84')
AddEventHandler('ed633e76-18c5-415c-84d1-7df76dacdc84', function()
  local player, distance = ESX.Game.GetClosestPlayer()
  if distance ~= -1 and distance <= 3.0 then
  				  RequestAnimDict("amb@prop_human_bum_bin@idle_b")
				  TaskPlayAnim(ped,"amb@prop_human_bum_bin@idle_b","idle_d",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0, 130)
								ESX.ShowNotification('~g~You have used your rope')
				Wait(8000)
		TriggerServerEvent('c6ed0c14-da30-4e7a-8bac-ebbf1d9961bd', GetPlayerServerId(player))
				ESX.ShowNotification('~r~Person Cuffed/UnCuffed')
  else
    ESX.ShowNotification('No players nearby')
	end
end)

RegisterNetEvent('5968c7f6-200f-48da-9563-bf87e3e280c4')
AddEventHandler('5968c7f6-200f-48da-9563-bf87e3e280c4', function()
	local player, distance = ESX.Game.GetClosestPlayer()
  if distance ~= -1 and distance <= 3.0 then
      TriggerServerEvent('8f1de68f-729a-4edf-b2be-85e0afd43092', GetPlayerServerId(player))
  else
    ESX.ShowNotification('No players nearby')
	end
end)

RegisterNetEvent('4e4a3633-dd4c-4a67-9d93-de672f46f8c4')
AddEventHandler('4e4a3633-dd4c-4a67-9d93-de672f46f8c4', function()
  local player, distance = ESX.Game.GetClosestPlayer()
	local ped = GetPlayerPed(-1)

	if IsLockpicking == false then
		ESX.UI.Menu.CloseAll()
		FreezeEntityPosition(player,  true)
		FreezeEntityPosition(ped,  true)

		TaskStartScenarioInPlace(ped, "WORLD_HUMAN_WELDING", 0, true)

		IsLockpicking = true

		Wait(30000)

		IsLockpicking = false

		FreezeEntityPosition(player,  false)
		FreezeEntityPosition(ped,  false)

		ClearPedTasksImmediately(ped)

		TriggerServerEvent('esx_policejob:rope', GetPlayerServerId(player))
		ESX.ShowNotification('rope unlocked')
	else
		ESX.ShowNotification('Your are already lockpicking rope')
	end
end)

-- ??
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if cuffed == true then
            ped = PlayerPedId()
            local IsCuffed = IsPedCuffed(ped)
            if IsCuffed == true and not IsEntityPlayingAnim(PlayerPedId(), dict, anim, 3) then
                Citizen.Wait(0)
                TaskPlayAnim(ped, dict, anim, 8.0, -8, -1, flags, 0, 0, 0, 0)
            end
        else
            changed = false
        end
    end
end)


