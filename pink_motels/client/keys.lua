RegisterNetEvent('eb026717-00ce-4036-b7e0-0ec9676ae2fc')
AddEventHandler('eb026717-00ce-4036-b7e0-0ec9676ae2fc', function(keyData)
    table.insert(cachedData["keys"], keyData)

    ESX.ShowNotification("You received a key.", "error", 3500)
end)

AddKey = function(keyData)
    if not keyData["id"] then return end
    if not keyData["label"] then keyData["label"] = "Nyckel - Okänd" end

    keyData["uuid"] = UUID()

    ESX.TriggerServerCallback('91d414ad-3fec-4ae8-9250-daa22d28f66a', function(added)
        if added then
            table.insert(cachedData["keys"], keyData)

            ESX.ShowNotification("Key received.", "warning", 3500)
        end
    end, keyData)
end

RemoveKey = function(keyUUID)
    if not keyUUID then return end

    for keyIndex, keyData in ipairs(cachedData["keys"]) do
        if keyData["uuid"] == keyUUID then
            ESX.TriggerServerCallback('4d32e1da-1899-4435-b7f6-80891403bd8f', function(removed)
                if removed then
                    table.remove(cachedData["keys"], keyIndex)

                    ESX.ShowNotification("Key removed.", "error", 3500)
                end
            end, keyUUID)

            return
        end
    end
end

TransferKey = function(keyData, newPlayer)
    if not keyData["uuid"] then return end

    for keyIndex, currentKeyData in ipairs(cachedData["keys"]) do
        if keyData["uuid"] == currentKeyData["uuid"] then
            ESX.TriggerServerCallback('7383f8f3-3d7b-4f70-86ec-b9a83d2bae98', function(removed)
                if removed then
                    table.remove(cachedData["keys"], keyIndex)

                    ESX.ShowNotification("Key sent.", "error", 3500)
                end
            end, keyData, GetPlayerServerId(newPlayer))

            return
        end
    end
end

HasKey = function(keyId)
    if not keyId then return end

    for keyIndex, keyData in ipairs(cachedData["keys"]) do
        if keyData["id"] == keyId then
            return true
        end
    end

    return false
end


CanRaid = function()
	local hasJob = false
	for k,v in pairs(Config.Raids.Jobs) do
		if ESX.GetPlayerData().job.name == k then
			if ESX.GetPlayerData().job.grade == v then
				hasJob = true
			end
		end
	end
	
	if hasJob == false then
		hasJob = hasSW()
	end

	return hasJob
end


function hasSW()
	local inventory = ESX.GetPlayerData().inventory
	local count = 0
	for i=1, #inventory, 1 do
		if inventory[i].name == 'search_warrant' and inventory[i].count > 0 then
			return true
		end
	end
	return false
end

ShowKeyMenu = function()
    local menuElements = {}

    if #cachedData["keys"] == 0 then return ESX.ShowNotification("You don't have any keys on you.", "error", 3000) end

    for keyIndex, keyData in ipairs(cachedData["keys"]) do
        table.insert(menuElements, {
            ["label"] = keyData["label"],
            ["key"] = keyData
        })
    end

    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "key_main_menu", {
        ["title"] = "Key storage",
        ["align"] = Config.AlignMenu,
        ["elements"] = menuElements
    }, function(menuData, menuHandle)
        local currentKey = menuData["current"]["key"]

        if not currentKey then return end

        menuHandle.close()

        ConfirmGiveKey(currentKey, function(confirmed)
            if confirmed then
                TransferKey(currentKey, confirmed)

                DrawBusySpinner("Handing over key...")

                Citizen.Wait(1000)

                RemoveLoadingPrompt()
            end

            ShowKeyMenu()
        end)
    end, function(menuData, menuHandle)
        menuHandle.close()
    end)
end

ConfirmGiveKey = function(keyData, callback)
    local closestPlayer, closestPlayerDistance = ESX.Game.GetClosestPlayer()

    if closestPlayer ~= -1 and closestPlayerDistance > 3.0 then
        return ESX.ShowNotification("You aren't close to any individual.")
    end

    Citizen.CreateThread(function()
        while ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "main_accept_key") do
            Citizen.Wait(5)

            local cPlayer, cPlayerDst = ESX.Game.GetClosestPlayer()

            if cPlayer ~= closestPlayer then
                closestPlayer = cPlayer
            end

            local cPlayerPed = GetPlayerPed(closestPlayer)

            if DoesEntityExist(cPlayerPed) then
                DrawScriptMarker({
					["type"] = 2,
					["pos"] = GetEntityCoords(cPlayerPed) + vector3(0.0, 0.0, 1.2),
					["r"] = 0,
					["g"] = 0,
					["b"] = 255,
					["sizeX"] = 0.3,
					["sizeY"] = 0.3,
					["sizeZ"] = 0.3,
                    ["rotate"] = true,
                    ["bob"] = true
				})
            end
        end
    end)

    ESX.UI.Menu.Open("default", GetCurrentResourceName(), "main_accept_key", {
        ["title"] = "Do you wan't to hand over the key?",
        ["align"] = Config.AlignMenu,
        ["elements"] = {
            {
                ["label"] = "Yes, hand over.",
                ["action"] = "yes"
            },
            {
                ["label"] = "No, cancel.",
                ["action"] = "no"
            }
        }
    }, function(menuData, menuHandle)
        local action = menuData["current"]["action"]
        
        menuHandle.close()

        if action == "yes" then
            callback(closestPlayer)
        else
            callback(false)
        end
    end, function(menuData, menuHandle)
        menuHandle.close()
    end)
end