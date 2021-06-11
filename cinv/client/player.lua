local targetPlayer

Citizen.CreateThread(
    function()
        TriggerEvent('2896af73-6240-4f26-92b0-417518db3f5a',"/openinventory",_U("openinv_help"),
            {
                {name = _U("openinv_id"), help = _U("openinv_help")}
            }
        )
    end
)

AddEventHandler('onResourceStop',
    function(resource)
        if resource == GetCurrentResourceName() then
            TriggerEvent('217f3d67-5dc5-4196-887e-9835dd323e74', "/openinventory")
        end
    end
)



RegisterNetEvent('f07587f2-5965-4851-92da-ad98474fdd1b')
AddEventHandler('f07587f2-5965-4851-92da-ad98474fdd1b',function(target)
        targetPlayer = target
        setPlayerInventoryData()
        openPlayerInventory()

        TriggerServerEvent('07102c9a-17d4-423f-b86d-3d0f3a1ed115',targetPlayer)
    end)

RegisterNetEvent('97b13391-299c-4597-9a79-a96e82aee412')
AddEventHandler('97b13391-299c-4597-9a79-a96e82aee412',function(target,admin)
        targetPlayer = target
        setPlayerInventoryData(admin)
        openPlayerInventory()
        TriggerServerEvent('07102c9a-17d4-423f-b86d-3d0f3a1ed115',targetPlayer)
end)

function refreshPlayerInventory()
    setPlayerInventoryData()
end

function setPlayerInventoryData(admin)
    ESX.TriggerServerCallback('5fc9b3ba-227c-4502-8141-c684b8ac3c9c',function(data)
            
			if data.admin then
				SendNUIMessage(
					{
						action = "setInfoText",
						text = "Player Inventory | Name: " .. data.identity.name  .. " | [ ID: " .. data.identity.id .. "]"
					}
				)
			else
				SendNUIMessage(
					{
						action = "setInfoText",
						text = "Player Inventory"
					}
				)
			end


            items = {}
            inventory = data.inventory
            accounts = data.accounts
            money = data.money
            weapons = data.weapons

            if Config.IncludeCash and money ~= nil and money > 0 then
                for key, value in pairs(accounts) do
                    moneyData = {
                        label = _U("cash"),
                        name = "cash",
                        type = "item_money",
                        count = money,
                        usable = false,
                        rare = false,
                        weight = 0,
                        canRemove = false
                    }

                    table.insert(items, moneyData)
                end
            end

            if Config.IncludeAccounts and accounts ~= nil then
                for key, value in pairs(accounts) do
                    if not shouldSkipAccount(accounts[key].name) then
                        local canDrop = accounts[key].name ~= "bank"

                        if accounts[key].money > 0 then
                            accountData = {
                                label = accounts[key].label,
                                count = accounts[key].money,
                                type = "item_account",
                                name = accounts[key].name,
                                usable = false,
                                rare = false,
                                weight = 0,
                                canRemove = canDrop
                            }
                            table.insert(items, accountData)
                        end
                    end
                end
            end

            if inventory ~= nil then
                for key, value in pairs(inventory) do
                    if inventory[key].count <= 0 then
                        inventory[key] = nil
                    else
                        inventory[key].type = "item_standard"
                        table.insert(items, inventory[key])
                    end
                end
            end

            if Config.IncludeWeapons and weapons ~= nil then
                for key, value in pairs(weapons) do
                    local weaponHash = GetHashKey(weapons[key].name)
                    local playerPed = PlayerPedId()
                    if weapons[key].name ~= "WEAPON_UNARMED" then
                        local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
                        table.insert(
                            items,
                            {
                                label = weapons[key].label,
                                count = ammo,
                                weight = 0,
                                type = "item_weapon",
                                name = weapons[key].name,
                                usable = false,
                                rare = false,
                                canRemove = true
                            }
                        )
                   end
                end
            end

			print(json.encode(items))
            SendNUIMessage(
                {
                    action = "setSecondInventoryItems",
                    itemList = items
                }
            )
        end,targetPlayer,admin)
end

function openPlayerInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "player"
        }
    )

    SetNuiFocus(true, true)
end

RegisterNUICallback("PutIntoPlayer",function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)

            if data.item.type == "item_weapon" then
                count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
            end

            TriggerServerEvent('cdd99c92-191e-4465-badb-b0229a507645',true, GetPlayerServerId(PlayerId()), targetPlayer, data.item.type, data.item.name, count)
        end

        Wait(250)
        refreshPlayerInventory()
        loadPlayerInventory()

        cb("ok")
    end
)

RegisterNUICallback("TakeFromPlayer",function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)

            if data.item.type == "item_weapon" then
                count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
            end

            TriggerServerEvent('cdd99c92-191e-4465-badb-b0229a507645',false, targetPlayer, GetPlayerServerId(PlayerId()), data.item.type, data.item.name, count)
        end

        Wait(250)
        refreshPlayerInventory()
        loadPlayerInventory()

        cb("ok")
    end
)
