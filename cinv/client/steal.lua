local targetPlayerlocal
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



RegisterNetEvent('1408b1d3-d8ae-42e7-b515-9bd5c1e40d71')
AddEventHandler('1408b1d3-d8ae-42e7-b515-9bd5c1e40d71',function(target)
	
	print('fired without being called problem')
 end)
 
function steal_items(target,localtarget)
	targetPlayer = target
	targetPlayerlocal = localtarget
	setStealPlayerInventory()
	openPlayerInventorySteal()
	TriggerServerEvent('07102c9a-17d4-423f-b86d-3d0f3a1ed115',targetPlayer)
end

function refreshStealPlayerInventory()
   setStealPlayerInventory()
end


RegisterNetEvent('3b26a04a-a70e-4a21-a0a0-633bf99c53cb')
AddEventHandler('3b26a04a-a70e-4a21-a0a0-633bf99c53cb', function()
	print('print targted')
    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	--[[
	steal_items(4, PlayerPedId()) -- Delete this
	
	return --uncomment and remove this to continue--]]
   if closestPlayer ~= -1 and closestDistance <= 3.0 then
        local searchPlayerPed = GetPlayerPed(closestPlayer)
        if IsEntityPlayingAnim(searchPlayerPed, 'random@mugging3', 'handsup_standing_base', 3) or IsEntityDead(searchPlayerPed) or IsEntityPlayingAnim(searchPlayerPed, "mp_arresting", "idle", 3) or IsEntityPlayingAnim(searchPlayerPed, "mp_arrest_paired", "crook_p2_back_right", 3) or  IsEntityPlayingAnim(searchPlayerPed, "random@arrests@busted", "idle_c", 3) then
		if IsPedRagdoll(searchPlayerPed) == true then
			exports['mythic_notify']:SendAlert('error', 'Closest Player is not compliant, cannot rob a downed player.')
			return
		end

            exports['mythic_progbar']:Progress({
                name = "robbing",
                duration = 3000,
                label = "Robbing a person..",
                useWhileDead = false,
                canCancel = true,
                controlDisables = {},
                animation = {animDict="random@countryside_gang_fight", anim="biker_02_stickup_loop" ,flags =51},
                prop = {},
              }, function(status)
					if not status then
						TaskPlayAnim(GetPlayerPed(-1), "random@countryside_gang_fight", "biker_02_stickup_loop", 2.0, 2.0, 5.0, 51, 0, false, false, false)
						Wait(2600)
						TaskPlayAnim(GetPlayerPed(-1), "random@countryside_gang_fight", "biker_02_stickup_loop", 2.0, 2.0, 5.0, 51, 0, false, false, false)
						steal_items(GetPlayerServerId(closestPlayer),closestPlayer)
						
			   --         TriggerServerEvent('051bed4d-4beb-4f04-8421-0a6cb7687a2b', "[STEALINVENTORY] | TARGET = ["..searchPlayerPed.."]",  GetPlayerServerId(PlayerId()), GetCurrentResourceName())
					end
            end)
			
			--steal_items(GetPlayerServerId(closestPlayer),closestPlayer)    
		else
			
		
			exports['mythic_notify']:SendAlert('error', 'Closest Player is not compliant')
        end
    else
        exports['mythic_notify']:SendAlert('error', 'No players around')
    end
end)

function setStealPlayerInventory()
    ESX.TriggerServerCallback('5fc9b3ba-227c-4502-8141-c684b8ac3c9c',function(data)
            SendNUIMessage(
                {
                    action = "setInfoText",
                    text = "Steal Inventory"
                }
            )

            items = {}
            inventory = data.inventory
            accounts = data.accounts
            money = data.money
            weapons = data.weapons
		
			
			
			local exclusion = {}
			for j=1, #data.notstealable, 1 do
				--print('exclusion ' .. tostring(data.notstealable[j].name))
				exclusion[tostring(data.notstealable[j].name)] = true
			end
			
            if false == true and Config.IncludeCash and money ~= nil and money > 0 then
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
						
						if exclusion[tostring(inventory[key].name)] == nil then
							table.insert(items, inventory[key])
						end
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
						
            SendNUIMessage(
                {
                    action = "setSecondInventoryItems",
                    itemList = items,
                }
            )
        end,targetPlayer,false,true) --forsteal
end

function openPlayerInventorySteal()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "steal"
        }
    )
	
    SetNuiFocus(true, true)
end



RegisterNUICallback("PutIntoPlayerSteal",function(data, cb)

        if IsPedSittingInAnyVehicle(playerPed) then
            return
		
        end
		

		if DoesEntityExist(GetPlayerPed(targetPlayerlocal)) == false then
			closeInventory()
			return
		end
		
		
		if IsPedRagdoll(GetPlayerPed(targetPlayerlocal))then
			closeInventory()
			return
		end
		
		if #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(GetPlayerPed(targetPlayerlocal))) > 4.5 then
			closeInventory()
			return
		end
		
		if not IsEntityPlayingAnim(GetPlayerPed(targetPlayerlocal), 'random@mugging3', 'handsup_standing_base', 3) and  not IsEntityPlayingAnim(GetPlayerPed(targetPlayerlocal), "mp_arresting", "idle", 3) and not IsEntityPlayingAnim(GetPlayerPed(targetPlayerlocal), "mp_arrest_paired", "crook_p2_back_right", 3) then
		 	closeInventory()
			return
		end
		
        if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)

            if data.item.type == "item_weapon" then
                count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
            end
			
			if data.item.type == "item_standard" then
				count = 1
			end

            TriggerServerEvent('cdd99c92-191e-4465-badb-b0229a507645',true, GetPlayerServerId(PlayerId()), targetPlayer, data.item.type, data.item.name, count,true)
        end

        Wait(250)
        refreshStealPlayerInventory()
        loadPlayerInventory()

        cb("ok")
    end
)

local ammo = {}
ammo["pistol_ammo"] = true
ammo["smg_ammo"] = true
ammo["rifle_ammo"] = true

RegisterNUICallback("TakeFromPlayerSteal",function(data, cb)

        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end
				if DoesEntityExist(GetPlayerPed(targetPlayerlocal)) == false then
			closeInventory()
			return
		end
		
		
		if IsPedRagdoll(GetPlayerPed(targetPlayerlocal)) then
			closeInventory()
			return
		end
		
		if #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(GetPlayerPed(targetPlayerlocal))) > 4.5 then
			closeInventory()
			return
		end
		
		if not IsEntityPlayingAnim(GetPlayerPed(targetPlayerlocal), 'random@mugging3', 'handsup_standing_base', 3) and  not IsEntityPlayingAnim(GetPlayerPed(targetPlayerlocal), "mp_arresting", "idle", 3) and not IsEntityPlayingAnim(GetPlayerPed(targetPlayerlocal), "mp_arrest_paired", "crook_p2_back_right", 3) then
		 	closeInventory()
			return
		end
		
        if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)
			local isammo = false
			
			if not ammo[data.item.name] == nil then
				isammo = true
			end
			
            if data.item.type == "item_weapon" then
                count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
            end
			if data.item.type == "item_standard" and isammo == false then
				count = 1
			elseif data.item.type == "item_account" then
				if count > 500 then
					count = 500
				end
			end
		
            TriggerServerEvent('cdd99c92-191e-4465-badb-b0229a507645',false, targetPlayer, GetPlayerServerId(PlayerId()), data.item.type, data.item.name, count, true)
        end

        Wait(250)
        refreshStealPlayerInventory()
        loadPlayerInventory()

        cb("ok")
    end
)
