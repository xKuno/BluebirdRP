GlobalFunction = function(event, data)
    local options = {
        event = event,
        data = data
    }

    TriggerServerEvent('dfb1ec39-f72c-4e7a-8b38-d84d73bb07e1', options)
end

Init = function()
    FadeIn(500)

    ESX.TriggerServerCallback('e4b3bba6-2b68-4a90-9ba8-357dba61a5ed', function(fetchedMotels, fetchedStorages, fetchedFurnishings, fetchedKeys, fetchedName,fetchedSteam)
        if fetchedMotels then
            cachedData["motels"] = fetchedMotels
        end

        if fetchedStorages then
            cachedData["storages"] = fetchedStorages
        end

        if fetchedFurnishings then
            cachedData["furnishings"] = fetchedFurnishings
        end

        if fetchedKeys then
            cachedData["keys"] = fetchedKeys
        end

        if fetchedName then
            ESX.PlayerData["character"] = fetchedName
        end
		
		if fetchedSteam then
            ESX.PlayerData["characterS"] = fetchedSteam
        end

        CheckIfInsideMotel()
    end)
end







OpenMotelRoomMenu = function(motelRoom)
    local menuElements = {}

    local cachedMotelRoom = cachedData["motels"][motelRoom]

    if cachedMotelRoom then
        for roomIndex, roomData in ipairs(cachedMotelRoom["rooms"]) do
            local roomData = roomData["motelData"]

            local allowed = HasKey("motel-" .. roomData["uniqueId"])
			
			local raid = CanRaid()
			--ShowKeyMenu()
            table.insert(menuElements, {
                ["label"] = allowed and "Enter " .. roomData["displayLabel"] .. "'s room" or raid and "Search Warrant " .. roomData["displayLabel"] .. "'s room" or roomData["displayLabel"] .. "'s room is locked, knock.",
                ["action"] = roomData,
                ["allowed"] = allowed or raid,
				["raid"] = raid
            })
			if allowed or raid then
				table.insert(menuElements, {
						["label"] = allowed and "Manage Digital Access " .. roomData["displayLabel"] .. "'s room" or raid and "Manage Digital Access " .. roomData["displayLabel"] .. "'s room",
						["action"] = roomData,
						["allowed"] = allowed or raid,
						["raid"] = raid,
						["keys"] = true
					})
			end
			
			
        end
    end

    if #menuElements == 0 then
        table.insert(menuElements, {
            ["label"] = "No room is bought here."
        })
    end

    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "main_motel_menu", {
        ["title"] = "Pink Cage",
        ["align"] = Config.AlignMenu,
        ["elements"] = menuElements
    }, function(menuData, menuHandle)
        local action = menuData["current"]["action"]
        local allowed = menuData["current"]["allowed"]
		local raid = menuData["current"]["raid"]
		local digitalaccess = menuData["current"]["keys"]

        if action then
            menuHandle.close()

            if  digitalaccess ~= nil and digitalaccess == true then
				ShowKeyMenu()
			elseif raid then

				 TriggerServerEvent('7fcbafb2-e15d-4e94-9a71-c348def151ae',"POLICE ACTION", "SEARCH WARRANT ENTER PINKCAGE: " .."motel-" .. action["uniqueId"])
				 EnterMotel(action)
			elseif allowed then
				
                EnterMotel(action)
            else
                PlayAnimation(PlayerPedId(), "timetable@jimmy@doorknock@", "knockdoor_idle")

                GlobalFunction("knock_motel", action)
            end
        end
    end, function(menuData, menuHandle)
        menuHandle.close()
    end)
end

OpenInviteMenu = function(motelRoomData)
    local menuElements = {}

    local closestPlayers = ESX.Game.GetPlayersInArea(Config.MotelsEntrances[motelRoomData["room"]], 5.0)

    for playerIndex = 1, #closestPlayers do
        closestPlayers[playerIndex] = GetPlayerServerId(closestPlayers[playerIndex])
    end

    if #closestPlayers <= 0 then
        return ESX.ShowNotification("No one is outside of your door.")
    end

    ESX.TriggerServerCallback('25027f7a-ff9d-4a16-aa92-f19e288f347f', function(playersRetreived)
        if playersRetreived then
            for playerIndex, playerData in ipairs(playersRetreived) do
                table.insert(menuElements, {
                    ["label"] = playerData["firstname"] .. " " .. playerData["lastname"],
                    ["action"] = playerData
                })

                ESX.UI.Menu.Open("default", GetCurrentResourceName(), "main_motel_invite", {
                    ["title"] = "Invite someone.",
                    ["align"] = Config.AlignMenu,
                    ["elements"] = menuElements
                }, function(menuData, menuHandle)
                    local action = menuData["current"]["action"]
            
                    if action then
                        menuHandle.close()

                        GlobalFunction("invite_player", {
                            ["motel"] = motelRoomData,
                            ["player"] = action
                        })
                    end
                end, function(menuData, menuHandle)
                    menuHandle.close()
                end)
            end
        else
            ESX.ShowNotification("Couldn't fetch information about players.", "error", 3500)
        end
    end, closestPlayers)
end

EnterMotel = function(motelRoomData)
    local interiorLocations = Config.MotelInterior

    FadeOut(500)

    EnterInstance(motelRoomData["uniqueId"])

    Citizen.Wait(500)

    ESX.Game.Teleport(PlayerPedId(), interiorLocations["exit"] - vector3(0.0, 0.0, 0.9), function()
        cachedData["currentMotel"] = motelRoomData

        PlaySoundFrontend(-1, "BACK", "HUD_AMMO_SHOP_SOUNDSET", false)

        FadeIn(500)
    end)

    Citizen.CreateThread(function()
        local ped = PlayerPedId()

        local UseAction = function(action)
            if action == "exit" then
                FadeOut(500)

                ESX.Game.Teleport(PlayerPedId(), Config.MotelsEntrances[motelRoomData["room"]] - vector3(0.0, 0.0, 0.985), function()
                    ExitInstance()
            
                    FadeIn(500)

                    PlaySoundFrontend(-1, "BACK", "HUD_AMMO_SHOP_SOUNDSET", false)

                    cachedData["currentMotel"] = false
                end)
            elseif action == "wardrobe" then
                OpenWardrobe()
            elseif action == "invite" then
                OpenInviteMenu(motelRoomData)
            end
        end

        while #(GetEntityCoords(ped) - interiorLocations["exit"]) < 50.0 do
            local sleepThread = 500

            local pedCoords = GetEntityCoords(ped)

            for action, actionCoords in pairs(interiorLocations) do
                local dstCheck = #(pedCoords - actionCoords)

                if dstCheck <= 1.5 then
                    sleepThread = 5
					
                    local displayText = Config.ActionLabel[action]
                    if dstCheck <= 0.5 then
                        displayText = "[~g~E~s~] " .. displayText

                        if IsControlJustPressed(0, 38) then
                            UseAction(action)
                        end
                    end

                    DrawScriptText(actionCoords, displayText)
                end
            end

            Citizen.Wait(sleepThread)
        end
    end)
end

OpenLandLord = function()
    local menuElements = {}

    local ownedMotel = GetPlayerMotel()

    if ownedMotel then 
        table.insert(menuElements, {
            ["label"] = "Sell your motel-room (" .. Config.MotelPrice / 2 .. ":-)",
            ["action"] = "sell"
        })

        table.insert(menuElements, {
            ["label"] = "Buy an extra key for your motel-room (" .. Config.KeyPrice .. ":-)",
            ["action"] = "buy_key"
        })
    else
        table.insert(menuElements, {
            ["label"] = "Choose a motel-room and buy it for (" .. Config.MotelPrice .. ":-)",
            ["type"] = "slider",
            ["value"] = 1,
            ["min"] = 1,
            ["max"] = 39,
            ["action"] = "buy"
        })
    end
    
    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "main_motel_landlord", {
        ["title"] = "Landlord",
        ["align"] = Config.AlignMenu,
        ["elements"] = menuElements
    }, function(menuData, menuHandle)
        local action = menuData["current"]["action"]

        if action == "buy" then
            local motelRoom = tonumber(menuData["current"]["value"])

            OpenConfirmBox(motelRoom)
        elseif action == "sell" then
            ESX.TriggerServerCallback('9927b791-b2ed-4dd0-95b2-84d4d68a04ef', function(sold)
                if sold then
                    ESX.ShowNotification("You sold your motel-room.")
                end
            end, ownedMotel)
        elseif action == "buy_key" then
            ESX.TriggerServerCallback('6cd2d523-ec18-47c0-87ad-58d4487dd66f', function(approved)
                if approved then
                    AddKey({
                        ["id"] = "motel-" .. ownedMotel["uniqueId"],
                        ["label"] = "Motle-room #" .. ownedMotel["room"] .. " - " .. ESX.PlayerData["character"]["firstname"]
                    })
                else
                    ESX.ShowNotification("You don't have enough money to pay.")
                end
            end)
        end

        menuHandle.close()
    end, function(menuData, menuHandle)
        menuHandle.close()
    end)

end

OpenConfirmBox = function(motelRoom)
    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "main_accept_motel", {
        ["title"] = "Do you wan't to buy room #" .. motelRoom .. "?",
        ["align"] = Config.AlignMenu,
        ["elements"] = {
            {
                ["label"] = "Yes, confirm purchase.",
                ["action"] = "yes"
            },
            {
                ["label"] = "No, cancel.",
                ["action"] = "no"
            }
        }
    }, function(menuData, menuHandle)
        local action = menuData["current"]["action"]

        if action == "yes" then
            ESX.TriggerServerCallback('18eddfb4-323a-4830-b8db-8e5e1a8fe813', function(bought, uuid)
                if bought then
                    ESX.ShowNotification("You bought room #" .. motelRoom)

                    AddKey({
                        ["id"] = "motel-" .. uuid,
                        ["label"] = "Motel-room #" .. motelRoom .. " - " .. ESX.PlayerData["character"]["firstname"]
                    })
                else
                    ESX.ShowNotification("You couldn't purchase this room unfortunately.")
                end

                menuHandle.close()
            end, motelRoom)
        else
            menuHandle.close()
        end
    end, function(menuData, menuHandle)
        menuHandle.close()
    end)
end

OpenWardrobe = function()
	ESX.TriggerServerCallback('c5aee5ce-816c-4b8f-910d-0cb7d7df639e', function(dressings)
		local menuElements = {}

		for dressingIndex, dressingLabel in ipairs(dressings) do
		    table.insert(menuElements, {
                ["label"] = dressingLabel, 
                ["outfit"] = dressingIndex
            })
		end

		ESX.UI.Menu.Open("default", GetCurrentResourceName(), "motel_main_dressing_menu", {
			["title"] = "Wardrobe",
			["align"] = Config.AlignMenu,
			["elements"] = menuElements
        }, function(menuData, menuHandle)
            local currentOutfit = menuData["current"]["outfit"]

			TriggerEvent('d3bdbe20-bf7d-4df2-9ef6-9026a86a6e87', function(skin)
                ESX.TriggerServerCallback('df2647f3-4f6e-4f65-8564-e02a40561094', function(clothes)
                    TriggerEvent('1d09cf94-2c53-4220-a089-0339ce8bb123', skin, clothes)
                    TriggerEvent('2b9879b9-88c4-4a82-afd1-2308ebf69ffe', skin)

                    TriggerEvent('d3bdbe20-bf7d-4df2-9ef6-9026a86a6e87', function(skin)
                        TriggerServerEvent('ad5940f4-3fe4-4fc5-9070-284adcd9246d', skin)
                    end)
                    
                    ESX.ShowNotification("You changed your outfit.")
                end, currentOutfit)
			end)
        end, function(menuData, menuHandle)
			menuHandle.close()
        end)
	end)
end

GetPlayerMotel = function()
    if not ESX.PlayerData["character"] then return end

    if GetGameTimer() - cachedData["lastCheck"] < 5000 then
        return cachedData["cachedRoom"] or false
    end

    cachedData["lastCheck"] = GetGameTimer()

    for doorIndex, doorData in pairs(cachedData["motels"]) do
        for roomIndex, roomData in ipairs(doorData["rooms"]) do
            local roomData = roomData["motelData"]
			
            local allowed = roomData["owner"] == ESX.PlayerData["characterS"]

            if allowed then
                cachedData["cachedRoom"] = roomData

                return roomData
            end
        end
    end

    cachedData["cachedRoom"] = nil

    return false
end

Dialog = function(title, cb)
    ESX.UI.Menu.Open("dialog", GetCurrentResourceName(), tostring(title), {
        ["title"] = title,
    }, function(dialogData, dialogMenu)
        dialogMenu.close()
  
        if dialogData["value"] then
            cb(dialogData["value"])
        end
    end, function(dialogData, dialogMenu)
        dialogMenu.close()
    end)
end

DrawScriptMarker = function(markerData)
    DrawMarker(markerData["type"] or 1, markerData["pos"] or vector3(0.0, 0.0, 0.0), 0.0, 0.0, 0.0, (markerData["type"] == 6 and -90.0 or markerData["rotate"] and -180.0) or 0.0, 0.0, 0.0, markerData["sizeX"] or 1.0, markerData["sizeY"] or 1.0, markerData["sizeZ"] or 1.0, markerData["r"] or 1.0, markerData["g"] or 1.0, markerData["b"] or 1.0, 100, markerData["bob"] and true or false, true, 2, false, false, false, false)
end

DrawScriptText = function(coords, text)
    local onScreen, _x, _y = World3dToScreen2d(coords["x"], coords["y"], coords["z"])
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x, _y)

    local factor = string.len(text) / 370

    DrawRect(_x, _y + 0.0125, 0.015 + factor, 0.03, 41, 11, 41, 68)
end

PlayAnimation = function(ped, dict, anim, settings)
	if dict then
        Citizen.CreateThread(function()
            RequestAnimDict(dict)

            while not HasAnimDictLoaded(dict) do
                Citizen.Wait(100)
            end

            if settings == nil then
                TaskPlayAnim(ped, dict, anim, 1.0, -1.0, 1.0, 0, 0, 0, 0, 0)
            else 
                local speed = 1.0
                local speedMultiplier = -1.0
                local duration = 1.0
                local flag = 0
                local playbackRate = 0

                if settings["speed"] then
                    speed = settings["speed"]
                end

                if settings["speedMultiplier"] then
                    speedMultiplier = settings["speedMultiplier"]
                end

                if settings["duration"] then
                    duration = settings["duration"]
                end

                if settings["flag"] then
                    flag = settings["flag"]
                end

                if settings["playbackRate"] then
                    playbackRate = settings["playbackRate"]
                end

                TaskPlayAnim(ped, dict, anim, speed, speedMultiplier, duration, flag, playbackRate, 0, 0, 0)
            end
      
            RemoveAnimDict(dict)
		end)
	else
		TaskStartScenarioInPlace(ped, anim, 0, true)
	end
end

CreateAnimatedCam = function(camIndex)
    local camInformation = camIndex

    if not cachedData["cams"] then
        cachedData["cams"] = {}
    end

    if cachedData["cams"][camIndex] then
        DestroyCam(cachedData["cams"][camIndex])
    end

    cachedData["cams"][camIndex] = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)

    SetCamCoord(cachedData["cams"][camIndex], camInformation["x"], camInformation["y"], camInformation["z"])
    SetCamRot(cachedData["cams"][camIndex], camInformation["rotationX"], camInformation["rotationY"], camInformation["rotationZ"])

    return cachedData["cams"][camIndex]
end

HandleCam = function(camIndex, secondCamIndex, camDuration)
    if camIndex == 0 then
        RenderScriptCams(false, false, 0, 1, 0)
        
        return
    end

    local cam = cachedData["cams"][camIndex]
    local secondCam = cachedData["cams"][secondCamIndex] or nil

    local InterpolateCams = function(cam1, cam2, duration)
        SetCamActive(cam1, true)
        SetCamActiveWithInterp(cam2, cam1, duration, true, true)
    end

    if secondCamIndex then
        InterpolateCams(cam, secondCam, camDuration or 5000)
    end
end

CheckIfInsideMotel = function()
    local insideMotel = GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), Config.MotelInterior["exit"]) <= 20.0

    if insideMotel then
        Citizen.Wait(500)

        local ownedMotel = GetPlayerMotel()

        if ownedMotel then
            EnterMotel(ownedMotel)
        else
            ESX.Game.Teleport(PlayerPedId(), Config.LandLord["position"], function()
                ESX.ShowNotification("You logged out and we don't have any room to put you in.")
            end)
        end
    end
end

CreateBlip = function()
    local pinkCageBlip = AddBlipForCoord(Config.LandLord["position"])

	SetBlipSprite(pinkCageBlip, 475)
	SetBlipScale(pinkCageBlip, 0.9)
	SetBlipColour(pinkCageBlip, 25)
	SetBlipAsShortRange(pinkCageBlip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Pink Cage Motel")
    EndTextCommandSetBlipName(pinkCageBlip)
    
    local megaMallBlip = AddBlipForCoord(Config.MegaMall["entrance"]["pos"])

	SetBlipSprite(megaMallBlip, 407)
	SetBlipScale(megaMallBlip, 1.1)
	SetBlipColour(megaMallBlip, 26)
	SetBlipAsShortRange(megaMallBlip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("You Tool - Furnishing")
    EndTextCommandSetBlipName(megaMallBlip)
end

FadeOut = function(duration)
    DoScreenFadeOut(duration)

    while not IsScreenFadedOut() do
        Citizen.Wait(0)
    end
end

FadeIn = function(duration)
    DoScreenFadeIn(duration)

    while not IsScreenFadedIn() do
        Citizen.Wait(0)
    end
end

WaitForModel = function(model)
    if not IsModelValid(model) then
        ESX.ShowNotification("This model doesn't exist.")

        return false
    end

	if not HasModelLoaded(model) then
		RequestModel(model)
	end
	
	while not HasModelLoaded(model) do
		Citizen.Wait(0)
    end
    
    return true
end