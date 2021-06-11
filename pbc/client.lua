ESX = nil
local playingPaintball = false
local queuing = false
local queueText = ''
local matchends = ''
local kills = 0
local deaths = 0


RegisterNetEvent('9da88b4b-16ae-479d-8567-828055dde67c')
AddEventHandler('9da88b4b-16ae-479d-8567-828055dde67c', function(text, other)
    queueText = text
    matchends = other
end)

RegisterNetEvent('61b1c9be-3c7f-4045-9d4c-1f12a1b02cdc')
AddEventHandler('61b1c9be-3c7f-4045-9d4c-1f12a1b02cdc', function(text)
    SetNotificationTextEntry('STRING')
    AddTextComponentSubstringPlayerName(text)
    DrawNotification(false, true)
end)

RegisterNetEvent('fb521f91-1581-4381-b65b-b095cb6b7ee0')
AddEventHandler('fb521f91-1581-4381-b65b-b095cb6b7ee0', function()
    queuing = false 
    playingPaintball = true
    deaths = 0
    kills = 0
	RemoveAllPedWeapons(GetPlayerPed(-1),false)
    if Config.Clothes.ChangeClothes then
        TriggerEvent('56a2ee13-8a49-4ad3-a298-1854493c98ee', Config.Clothes.Outfits[math.random(1, #Config.Clothes.Outfits)])
    end
    SetEntityCoords(PlayerPedId(), Config.SpawnPoints[math.random(1, #Config.SpawnPoints)])
	Citizen.CreateThread(function()
		while playingPaintball == true do
			playerPed = PlayerPedId()
			if #(GetEntityCoords(playerPed) - vector3(52.49, 3715.89, 62.57)) > 130 then
				ESX.Game.Teleport(playerPed, Config.JoinCircle)
			end
			Wait(1000)
		end
	
	end)
	
	Citizen.CreateThread(function()
		while playingPaintball do
			if playingPaintball then

				if type(matchends) == 'number' then
					drawText((Config.Translations['match_ends']):format(matchends-Config.DisplayWinner, kills, deaths), 0.015, 0.015)
				else
					drawText((Config.Translations['match_ends']):format(matchends, kills, deaths), 0.015, 0.015)
				end
				if Config.ForceFirstPerson then
					SetFollowPedCamViewMode(4)
				end
				SetEntityInvincible(PlayerPedId(), true)
				SetPlayerInvincible(PlayerId(), true)
				exports['esx_weaponsync']:setrunning(false)
				
				if not HasPedGotWeapon(PlayerPedId(), Config.Weapon, false) then
					GiveWeaponToPed(PlayerPedId(), Config.Weapon, 0, false, true)
				end
				
				SetPedInfiniteAmmo(PlayerPedId(), true, Config.Weapon)
				DisableControlAction(0, 37, true);

			end
			Wait(0)
		end
		RemoveAllPedWeapons(GetPlayerPed(-1),false)
		Wait(100)
		exports['esx_weaponsync']:setrunning(true)
		ClearTimecycleModifier()
	end)
	
	Citizen.CreateThread(function()
		while playingPaintball do
			local sleep = 2500

				if IsPedShooting(PlayerPedId()) and GetSelectedPedWeapon(PlayerPedId()) == Config.Weapon then
					local coords = GetEntityCoords(PlayerPedId())
					local coords = GetPedBoneCoords(PlayerPedId(), `SKEL_R_Hand`, 0.0, 0.0, 0.0)
					local x, bulletCoord = GetPedLastWeaponImpactCoord(PlayerPedId())
					if x then
						local rayHandle = StartShapeTestRay(coords.x, coords.y, coords.z, bulletCoord.x, bulletCoord.y, bulletCoord.z, 10, PlayerPedId(), 0)
						local _, _, _, _, ped = GetShapeTestResult(rayHandle)
						if GetEntityType(ped) == 1 then
							for k, v in pairs(GetActivePlayers()) do
								if GetPlayerPed(v) == ped then
									TriggerServerEvent('3d22916a-1467-4de4-872f-e29d4868f96f', GetPlayerServerId(v))
									kills = kills + 1
									Wait(500)
									break
								end
							end
						end
					end
				end

			Wait(0)
		end
	end)
end)
	

RegisterNetEvent('5c3375cd-5037-43e0-996d-1fcbe6b95657')
AddEventHandler('5c3375cd-5037-43e0-996d-1fcbe6b95657', function()
    playingPaintball = false
    SetPedInfiniteAmmo(PlayerPedId(), false, Config.Weapon)
    SetEntityInvincible(PlayerPedId(), false)
    SetPlayerInvincible(PlayerId(), false)
	
    if Config.RemoveWeapon then
        RemoveWeaponFromPed(PlayerPedId(), Config.Weapon)
    end
    deaths = 0
    kills = 0
    queuing = false
    if Config.Clothes.ChangeClothes then
        ESX.TriggerServerCallback('4568d939-3661-4833-ae6a-378432ac6ff1', function(skin)
            TriggerEvent('56a2ee13-8a49-4ad3-a298-1854493c98ee', skin)
        end)
    end
end)

RegisterNetEvent('3eb4c0e1-bd91-45b0-a92a-87a5194844f0')
AddEventHandler('3eb4c0e1-bd91-45b0-a92a-87a5194844f0', function(winner, me)

    kills = 0
    deaths = 0
    winner = json.decode(winner)
    me = json.decode(me)
    local timer = GetGameTimer() + (Config.DisplayWinner * 1000)
    if GetPlayerFromServerId(winner.id) == PlayerId() then
        SetEntityCoords(PlayerPedId(), Config.WinnerPosition)
        FreezeEntityPosition(PlayerPedId(), true)

        local cam = CreateCam("DEFAULT_SCRIPTED_Camera", 1)
        SetCamCoord(cam, Config.WinnerCam.x, Config.WinnerCam.y, Config.WinnerCam.z)
        RenderScriptCams(1, 0, 0, 1, 1)
        ClearPedBloodDamage(PlayerPedId())
        while timer >= GetGameTimer() do
            Wait(0)
            SetEntityHeading(PlayerPedId(), Config.WinnerHeading)
            for i = 0, 31 do
                DisableAllControlActions(i)
            end
            PointCamAtEntity(cam, GetPlayerPed(GetPlayerFromServerId(winner.id)), 0.0, 0.0, 0.0, true)
            drawText((Config.Translations['you_won']):format(winner.kills, winner.deaths), 0.015, 0.75)
        end
        RenderScriptCams(false, false, 0, true, false)
        DestroyCam(cam)
        SetEntityCoords(PlayerPedId(), Config.JoinCircle)
    else
        SetEntityCoords(PlayerPedId(), Config.WinnerPosition)
        local cam = CreateCam("DEFAULT_SCRIPTED_Camera", 1)
        SetCamCoord(cam, Config.WinnerCam.x, Config.WinnerCam.y, Config.WinnerCam.z)
        RenderScriptCams(1, 0, 0, 1, 1)
        ClearPedBloodDamage(PlayerPedId())
        while timer >= GetGameTimer() do
            Wait(0)
            for i = 0, 31 do
                DisableAllControlActions(i)
            end
            SetEntityVisible(PlayerPedId(), false, false)
            PointCamAtEntity(cam, GetPlayerPed(GetPlayerFromServerId(winner.id)), 0.0, 0.0, 0.0, true)
            drawText((Config.Translations['won']):format(GetPlayerName(GetPlayerFromServerId(winner.id)), winner.kills, winner.deaths, me.kills, me.deaths), 0.015, 0.75)
        end
        SetEntityVisible(PlayerPedId(), true, false)
        RenderScriptCams(false, false, 0, true, false)
        DestroyCam(cam)
        SetEntityCoords(PlayerPedId(), Config.JoinCircle)
    end
    if Config.Clothes.ChangeClothes then
        ESX.TriggerServerCallback('4568d939-3661-4833-ae6a-378432ac6ff1', function(skin)
            TriggerEvent('56a2ee13-8a49-4ad3-a298-1854493c98ee', skin)
        end)
    end
    FreezeEntityPosition(PlayerPedId(), false)
	playingPaintball = false
    SetPedInfiniteAmmo(PlayerPedId(), false, Config.Weapon)
    SetEntityInvincible(PlayerPedId(), false)
    SetPlayerInvincible(PlayerId(), false)
end)

RegisterNetEvent('7fd6d644-2e68-4fda-9f99-138cf2b629a3')
AddEventHandler('7fd6d644-2e68-4fda-9f99-138cf2b629a3', function(killedBy)
    deaths = deaths + 1
    local timer = GetGameTimer() + 10000
    SetTimecycleModifier("BlackOut")
    SetEntityHasGravity(PlayerPedId(), false)

    local coordsFrom = GetEntityCoords(PlayerPedId())

    local cam = CreateCam("DEFAULT_SCRIPTED_Camera", 1)
    SetCamCoord(cam, coordsFrom.x, coordsFrom.y, coordsFrom.z)
    RenderScriptCams(1, 0, 0, 1, 1)

    SetEntityCoords(PlayerPedId(), GetEntityCoords(PlayerPedId()).x, GetEntityCoords(PlayerPedId()).y, GetEntityCoords(PlayerPedId()).z+5.0)
    Citizen.CreateThread(function()
        while timer >= GetGameTimer() and playingPaintball do
            SetCamFov(cam, GetCamFov(cam) - 0.1)
            Wait(50)
        end
    end)
    while timer >= GetGameTimer() and playingPaintball do
        Wait(0)
        PointCamAtEntity(cam, GetPlayerPed(GetPlayerFromServerId(killedBy)), 0.0, 0.0, 0.0, true)
        SetEntityVisible(PlayerPedId(), false, false)
        for i = 0, 31 do
            DisableAllControlActions(i)
        end
    end
    if playingPaintball then
        RenderScriptCams(false, false, 0, true, false)
        DestroyCam(cam)
        SetEntityCoords(PlayerPedId(), Config.SpawnPoints[math.random(1, #Config.SpawnPoints)])
    end
    SetEntityVisible(PlayerPedId(), true, false)
    SetEntityHasGravity(PlayerPedId(), true)
    ClearTimecycleModifier()
    ClearPedTasks(PlayerPedId())
    ClearPedBloodDamage(PlayerPedId())
	TriggerServerEvent('2f307d37-92c2-4014-89b7-7816765b49a6')
	
	Wait(2000)
	exports['esx_weaponsync']:setrunning(false)

	GiveWeaponToPed(PlayerPedId(), Config.Weapon, 0, false, true)
	SetCurrentPedWeapon(GetPlayerPed(-1),Config.Weapon,true)
	SetPedInfiniteAmmo(PlayerPedId(), true, Config.Weapon)
	SetCurrentPedWeapon(GetPlayerPed(-1),Config.Weapon,true)
end)

Citizen.CreateThread(function()
    while ESX == nil do TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end) Wait(0) end
    while not NetworkIsSessionStarted() or ESX.GetPlayerData().job == nil do Wait(0) end
--[[
    local blip = AddBlipForCoord(Config.JoinCircle)
    SetBlipSprite(blip, 156)
    SetBlipColour(blip, 40)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Paintball')
    EndTextCommandSetBlipName(blip) --]]
    while true do
        if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.JoinCircle, true) <= 25.0 then
            DrawMarker(1, Config.JoinCircle.x, Config.JoinCircle.y, Config.JoinCircle.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 8.5, 8.5, 0.1, 50, 255, 50, 150, false, true, 2, false, false, false, false)
            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.JoinCircle, true) <= 7.5 then
                if queueText ~= Config.Translations['match_progress'] then
                    if not queuing then
                        drawText3D(vector3(Config.JoinCircle.x, Config.JoinCircle.y, Config.JoinCircle.z+1.0), (Config.Translations['join_paintball']):format(Config.Price, queueText))
                    else
                        drawText3D(vector3(Config.JoinCircle.x, Config.JoinCircle.y, Config.JoinCircle.z+1.0), (Config.Translations['leave_paintball']):format(queueText))
                    end
                    if IsControlJustReleased(0, 38) then
                        queuing = not queuing
                        TriggerServerEvent('98eabc1d-5233-4453-9e3b-a1fa22e4f3f7')
                    end
                else
                    drawText3D(vector3(Config.JoinCircle.x, Config.JoinCircle.y, Config.JoinCircle.z+1.0), (Config.Translations['match_in_progress']):format(queueText, matchends))
                end
            else
                if queuing then
                    queuing = false
                    TriggerServerEvent('98eabc1d-5233-4453-9e3b-a1fa22e4f3f7')
                    Citizen.CreateThread(function()
                        notify(Config.Translations['left_paintball'], 3)
                    end)
                end
            end
		else
			Wait(1000)
        end
        Wait(5)
    end
end)

-- GetPedLastWeaponImpactCoord(PlayerPedId())



notify = function(text, length)
    local wait = GetGameTimer()+length*1000
    while wait >= GetGameTimer() do
        Wait(0)
        drawText3D(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.5, 0.4), text)
    end
end

drawText = function(text, x, y)
    SetTextColour(255, 255, 255, 255)
    SetTextFont(4)
    SetTextScale(0.5, 0.5)
    SetTextWrap(0.0, 1.0)
    SetTextCentre(false)
    SetTextOutline()
    SetTextEdge(1, 0, 0, 0, 205)
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x, y)
end

drawText3D = function(coords, text)
    local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
  
    SetTextScale(0.4, 0.4)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 255)
    SetTextOutline()
  
    AddTextComponentString(text)
    DrawText(_x, _y)
end

loadDict = function(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end