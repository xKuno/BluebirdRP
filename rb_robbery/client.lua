ESX                           = nil
local ESXLoaded = false
local robbing = false

Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

    ESXLoaded = true
end)

RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(xPlayer)
  ESX.PlayerData = xPlayer
end)

RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function(job)
    ESX.PlayerData.job = job
end)

local peds = {}
local objects = {}

RegisterNetEvent('befe2504-b060-4c69-b39f-be504d274e0e')
AddEventHandler('befe2504-b060-4c69-b39f-be504d274e0e', function(store)
	Config.Shops[store].dead = true
    if DoesEntityExist(peds[store]) then
		SetEntityHealth(peds[store], 0)
    end
end)

function isclosetostore()
	local checkforrob = false
	local me = GetPlayerPed(-1)
	for i = 1, #peds do
		if #(GetEntityCoords(me) - GetEntityCoords(peds[i])) <= 15.0 then
			checkforrob = true
		end
	end
	return checkforrob
end

RegisterNetEvent('163571d0-012f-4863-ad19-ba9537c72fdc')
AddEventHandler('163571d0-012f-4863-ad19-ba9537c72fdc', function(store, robber)
    local mugshot, mugshotStr = ESX.Game.GetPedMugshot(GetPlayerPed(GetPlayerFromServerId(robber)))
	ESX.ShowAdvancedNotification(Config.Shops[store].name, Translation[Config.Locale]['robbery'], Translation[Config.Locale]['cop_msg'], mugshotStr, 4)
    UnregisterPedheadshot(mugshot)
    while true do
        local name = GetCurrentResourceName() .. math.random(999)
        AddTextEntry(name, '~INPUT_CONTEXT~ ' .. Translation[Config.Locale]['set_waypoint'] .. '\n~INPUT_FRONTEND_RRIGHT~ ' .. Translation[Config.Locale]['hide_box'])
        DisplayHelpTextThisFrame(name, false)
        if IsControlPressed(0, 38) then
            SetNewWaypoint(Config.Shops[store].coords.x, Config.Shops[store].coords.y)
            return
        elseif IsControlPressed(0, 194) then
            return
        end
        Wait(0)
    end
end)

RegisterNetEvent('1b9184e1-1252-4d26-99e5-1be99a2024f0')
AddEventHandler('1b9184e1-1252-4d26-99e5-1be99a2024f0', function(bank)
    for i = 1, #objects do 
        if objects[i].bank == bank and DoesEntityExist(objects[i].object) then 
            DeleteObject(objects[i].object) 
        end 
    end
end)

RegisterNetEvent('65abc588-ca8a-46d7-bb19-b35667b2b860')
AddEventHandler('65abc588-ca8a-46d7-bb19-b35667b2b860', function()
    robbing = false
end)

RegisterNetEvent('c9ae1e47-7829-49e6-a725-b4561bf0ed54')
AddEventHandler('c9ae1e47-7829-49e6-a725-b4561bf0ed54', function(store, text, time)
    robbing = false
    local endTime = GetGameTimer() + 1000 * time
    while endTime >= GetGameTimer() do
        local x = GetEntityCoords(peds[store])
        DrawText3D(vector3(x.x, x.y, x.z + 1.0), text)
        Wait(0)
    end
end)

RegisterCommand('animation', function(source, args)
    if args[1] and args[2] then
        loadDict(args[1])
        TaskPlayAnim(PlayerPedId(), args[1], args[2], 8.0, -8.0, -1, 2, 0, false, false, false)
    end
end)

RegisterNetEvent('6aa67fbf-489a-48e6-97f0-0c50c51ea2c8')
AddEventHandler('6aa67fbf-489a-48e6-97f0-0c50c51ea2c8', function(i)
    if not IsPedDeadOrDying(peds[i]) then
        SetEntityCoords(peds[i], Config.Shops[i].coords)
        loadDict('mp_am_hold_up')
        TaskPlayAnim(peds[i], "mp_am_hold_up", "holdup_victim_20s", 8.0, -8.0, -1, 2, 0, false, false, false)
        while not IsEntityPlayingAnim(peds[i], "mp_am_hold_up", "holdup_victim_20s", 3) do Wait(0) end
        local timer = GetGameTimer() + 10800
        while timer >= GetGameTimer() do
            if IsPedDeadOrDying(peds[i]) then
                break
            end
            Wait(0)
        end

        if not IsPedDeadOrDying(peds[i]) then
            local cashRegister = GetClosestObjectOfType(GetEntityCoords(peds[i]), 5.0, `prop_till_01`)
            if DoesEntityExist(cashRegister) then
                CreateModelSwap(GetEntityCoords(cashRegister), 0.5, `prop_till_01`, `prop_till_01_dam`, false)
            end

            timer = GetGameTimer() + 200 
            while timer >= GetGameTimer() do
                if IsPedDeadOrDying(peds[i]) then
                    break
                end
                Wait(0)
            end

            local model = `prop_poly_bag_01`
            RequestModel(model)
            while not HasModelLoaded(model) do Wait(0) end
            local bag = CreateObject(model, GetEntityCoords(peds[i]), false, false)
                        
            AttachEntityToEntity(bag, peds[i], GetPedBoneIndex(peds[i], 60309), 0.1, -0.11, 0.08, 0.0, -75.0, -75.0, 1, 1, 0, 0, 2, 1)
            timer = GetGameTimer() + 10000
            while timer >= GetGameTimer() do
                if IsPedDeadOrDying(peds[i]) then
                    break
                end
                Wait(0)
            end
            if not IsPedDeadOrDying(peds[i]) then
                DetachEntity(bag, true, false)
                timer = GetGameTimer() + 75
                while timer >= GetGameTimer() do
                    if IsPedDeadOrDying(peds[i]) then
                        break
                    end
                    Wait(0)
                end
                SetEntityHeading(bag, Config.Shops[i].heading)
                ApplyForceToEntity(bag, 3, vector3(0.0, 50.0, 0.0), 0.0, 0.0, 0.0, 0, true, true, false, false, true)
                table.insert(objects, {bank = i, object = bag})
                Citizen.CreateThread(function()
                    while true do
                        Wait(5)
                        if DoesEntityExist(bag) then
                            if GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(bag), true) <= 1.5 then
                                PlaySoundFrontend(-1, 'ROBBERY_MONEY_TOTAL', 'HUD_FRONTEND_CUSTOM_SOUNDSET', true)
                                TriggerServerEvent('3c52ba67-2f57-40b8-ba4e-3ae714a37dfa', i)
                                break
                            end
                        else
                            break
                        end
                    end
                end)
            else
                DeleteObject(bag)
            end
        end
        loadDict('mp_am_hold_up')
        TaskPlayAnim(peds[i], "mp_am_hold_up", "cower_intro", 8.0, -8.0, -1, 0, 0, false, false, false)
        timer = GetGameTimer() + 2500
        while timer >= GetGameTimer() do Wait(0) end
        TaskPlayAnim(peds[i], "mp_am_hold_up", "cower_loop", 8.0, -8.0, -1, 1, 0, false, false, false)
        local stop = GetGameTimer() + 120000
        while stop >= GetGameTimer() do
            Wait(50)
        end
        if IsEntityPlayingAnim(peds[i], "mp_am_hold_up", "cower_loop", 3) then
            ClearPedTasks(peds[i])
        end
    end
end)

RegisterNetEvent('a5765479-8ffd-4307-906d-b5ed6929603a')
AddEventHandler('a5765479-8ffd-4307-906d-b5ed6929603a', function(i)
    while not ESXLoaded do Wait(0) end
	Config.Shops[i].dead = false
    if DoesEntityExist(peds[i]) then
        DeletePed(peds[i])
    end
    Wait(250)
	local distance = #(GetEntityCoords(PlayerId()) - Config.Shops[i].coords)
	if distance < 30 then
		local shopkeeper = nil
		if Config.Shops[i].shopkeeper then
			shopkeeper = Config.Shops[i].shopkeeper
		elseif Config.Shops[i].type == 'b' then
			shopkeeper = Config.Bank[math.random(1,#Config.Bank)]
		else
			shopkeeper = Config.ShopKeepers[math.random(1,#Config.ShopKeepers)]
		end
		RequestModel(shopkeeper)
		while not HasModelLoaded(shopkeeper) do Wait(0) end
		peds[i] = _CreatePed(shopkeeper, Config.Shops[i].coords, Config.Shops[i].heading)
		
		--[[
		local brokenCashRegister = GetClosestObjectOfType(GetEntityCoords(peds[i]), 5.0, `prop_till_01_dam`)
		if DoesEntityExist(brokenCashRegister) then
			CreateModelSwap(GetEntityCoords(brokenCashRegister), 0.5, `prop_till_01_dam`, `prop_till_01`, false)
		end--]]
	end
end)

function _CreatePed(hash, coords, heading)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(5)
    end

    local ped = CreatePed(4, hash, coords, false, false)
    SetEntityHeading(ped, heading)
    SetEntityAsMissionEntity(ped, true, true)
    SetPedHearingRange(ped, 0.0)
    SetPedSeeingRange(ped, 0.0)
    SetPedAlertness(ped, 0.0)
    SetPedFleeAttributes(ped, 0, 0)
    SetBlockingOfNonTemporaryEvents(ped, true)
    SetPedCombatAttributes(ped, 46, true)
    SetPedFleeAttributes(ped, 0, 0)
    return ped
end

Citizen.CreateThread(function()
	math.randomseed(GetGameTimer())
    while not ESXLoaded do Wait(0) end


    for i = 1, #Config.Shops do 
		peds[i] = 0
	--[[
		local shopkeeper = nil
		if Config.Shops[i].shopkeeper then
			shopkeeper = Config.Shops[i].shopkeeper
		elseif Config.Shops[i].type == 'b' then
			shopkeeper = Config.Bank[math.random(1,#Config.Bank)]
		else
			shopkeeper = Config.ShopKeepers[math.random(1,#Config.ShopKeepers)]
		end

		RequestModel(shopkeeper)
		while not HasModelLoaded(shopkeeper) do Wait(0) end
	
        peds[i] = _CreatePed(shopkeeper, Config.Shops[i].coords, Config.Shops[i].heading)
-]]
        if Config.Shops[i].blip then
            local blip = AddBlipForCoord(Config.Shops[i].coords)
            SetBlipSprite(blip, 156)
            SetBlipColour(blip, 40)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(Config.Shops[i].name)
            EndTextCommandSetBlipName(blip)
        end
		--[[
        local brokenCashRegister = GetClosestObjectOfType(GetEntityCoords(peds[i]), 5.0, `prop_till_01_dam`)
        if DoesEntityExist(brokenCashRegister) then
            CreateModelSwap(GetEntityCoords(brokenCashRegister), 0.5, `prop_till_01_dam`, `prop_till_01`, false)
        end-]]
    end

    Citizen.CreateThread(function()
        while true do
            for i = 1, #peds do
				if DoesEntityExist(peds[i]) then
					if IsPedDeadOrDying(peds[i]) then
						TriggerServerEvent('dbad073e-ee1b-4a04-b471-4cb80c35469f', i)
					end
				end
            end
            Wait(5000)
        end
    end)
	
	
	
	Citizen.CreateThread(function()
        while true do
			local me = PlayerPedId()
			for i = 1, #Config.Shops do 
				local distance = #(GetEntityCoords(me) - Config.Shops[i].coords)
			
				if distance < 40 then
					if DoesEntityExist(peds[i]) == false then
						local shopkeeper = nil
						if Config.Shops[i].shopkeeper then
							shopkeeper = Config.Shops[i].shopkeeper
						elseif Config.Shops[i].type == 'b' then
							shopkeeper = Config.Bank[math.random(1,#Config.Bank)]
						else
							shopkeeper = Config.ShopKeepers[math.random(1,#Config.ShopKeepers)]
						end

						RequestModel(shopkeeper)
						while not HasModelLoaded(shopkeeper) do Wait(0) end
					
						peds[i] = _CreatePed(shopkeeper, Config.Shops[i].coords, Config.Shops[i].heading)
						if Config.Shops[i].dead == true then
							SetEntityHealth(peds[i], 0)
						end
					end
				elseif distance >= 50 then
					if DoesEntityExist(peds[i]) then
						DeletePed(peds[i])
					end					
				end
				Wait(20)
			end
            Wait(2000)
        end
		
	end)

    while true do
        Wait(800)
        local me = PlayerPedId()
        if IsPedArmed(me, 7) then
            if IsPlayerFreeAiming(PlayerId()) then
				local a, b = GetEntityPlayerIsFreeAimingAt(PlayerId())
				
                for i = 1, #peds do
						local lod = HasEntityClearLosToEntityInFront(me, peds[i], 19) 
						local dist = #(GetEntityCoords(me) - GetEntityCoords(peds[i]))
						
                    if  not IsPedDeadOrDying(peds[i]) and ((lod and dist <= 5.5) or (dist < 3.0)) then
						
						
                        if not robbing and DoesEntityExist(b) and IsEntityAPed(b) and ESX.GetPlayerData().job.name ~= 'police' then
							
                            local canRob = nil
                            ESX.TriggerServerCallback('7882f9cc-7916-4469-8692-216554c2193f', function(cb)
                                canRob = cb
                            end, i)
                            while canRob == nil do
                                Wait(0)
                            end
                            if canRob == true then
                                robbing = true
                                Citizen.CreateThread(function()
                                    while robbing do Wait(0) if IsPedDeadOrDying(peds[i]) then robbing = false end end
                                end)
                                loadDict('missheist_agency2ahands_up')
                                TaskPlayAnim(peds[i], "missheist_agency2ahands_up", "handsup_anxious", 8.0, -8.0, -1, 1, 0, false, false, false)

                                local scared = 0
                                while scared < 100 and not IsPedDeadOrDying(peds[i]) and GetDistanceBetweenCoords(GetEntityCoords(me), GetEntityCoords(peds[i]), true) <= 7.5 do
                                    local sleep = 600
                                    SetEntityAnimSpeed(peds[i], "missheist_agency2ahands_up", "handsup_anxious", 1.0)
                                    if IsPlayerFreeAiming(PlayerId()) then
                                        sleep = 250
                                        SetEntityAnimSpeed(peds[i], "missheist_agency2ahands_up", "handsup_anxious", 1.3)
                                    end
                                    if IsPedArmed(me, 4) and GetAmmoInClip(me, GetSelectedPedWeapon(me)) > 0 and IsControlPressed(0, 24) then
                                        sleep = 50
                                        SetEntityAnimSpeed(peds[i], "missheist_agency2ahands_up", "handsup_anxious", 1.7)
                                    end
                                    sleep = GetGameTimer() + sleep
                                    while sleep >= GetGameTimer() and not IsPedDeadOrDying(peds[i]) do
                                        Wait(0)
                                        DrawRect(0.5, 0.5, 0.2, 0.03, 75, 75, 75, 200)
                                        local draw = scared/500
                                        DrawRect(0.5, 0.5, draw, 0.03, 0, 221, 255, 200)
                                    end
                                    scared = scared + 1
                                end
                                if GetDistanceBetweenCoords(GetEntityCoords(me), GetEntityCoords(peds[i]), true) <= 7.5 then
                                    if not IsPedDeadOrDying(peds[i]) then
                                        TriggerServerEvent('a83b7200-f8de-455e-80c2-0b3006f164f6', i)
                                        while robbing do Wait(0) if IsPedDeadOrDying(peds[i]) then robbing = false end end
										
                                    end
                                else
                                    ClearPedTasks(peds[i])
                                    local wait = GetGameTimer()+5000
                                    while wait >= GetGameTimer() do
                                        Wait(0)
                                        DrawText3D(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.5, 0.5), Translation[Config.Locale]['walked_too_far'])
                                    end
                                    robbing = false
									
                                end
                            elseif canRob == 'no_cops' then
								
								
                                local wait = GetGameTimer()+5000
                                while wait >= GetGameTimer() do
                                    Wait(0)
                                    DrawText3D(GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 1.5, 0.5), Translation[Config.Locale]['no_cops'])
                                end
                            else
							
                                TriggerEvent('c9ae1e47-7829-49e6-a725-b4561bf0ed54', i, '~g~*' .. Translation[Config.Locale]['shopkeeper'] .. '* ~w~' .. Translation[Config.Locale]['robbed'], 5)
                                Wait(2500)
								
                            end
                        end
                    end
                end
            end
        end
    end
end)

loadDict = function(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end

function DrawText3D(coords, text)
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
