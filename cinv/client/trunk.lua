
AddEventHandler(
    "onResourceStop",
    function(resource)
        if resource == GetCurrentResourceName() then
            TriggerEvent('217f3d67-5dc5-4196-887e-9835dd323e74', "/openinventory")
        end
    end
)

RegisterNetEvent('85b1b203-c89b-4252-9177-f8d92cbbc51d')
AddEventHandler('85b1b203-c89b-4252-9177-f8d92cbbc51d',function(data, blackMoney, inventory, weapons)
		print('open trunk inventory received -- MAIN')
        setTrunkInventoryData(data, blackMoney, inventory, weapons)
        openTrunkInventory()
end)


function openTrunkInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "trunk"
        }
    )

    SetNuiFocus(true, true)
end


function setTrunkInventoryData(data, blackMoney, inventory, weapons)
	weapons = nil
	print('set trunk inventory triggered')
    trunkData = data
	weapons = nil

    SendNUIMessage(
        {
            action = "setInfoText",
            text = data.text
        }
    )

    items = {}

    if blackMoney > 0 then
        accountData = {
            label = _U("black_money"),
            count = blackMoney,
            type = "item_account",
            name = "black_money",
            usable = false,
            rare = false,
            limit = -1,
            canRemove = false
        }
        table.insert(items, accountData)
    end

    if inventory ~= nil then
        for key, value in pairs(inventory) do
            if inventory[key].count <= 0 then
                inventory[key] = nil
            else
                inventory[key].type = "item_standard"
                inventory[key].usable = false
                inventory[key].rare = false
                inventory[key].limit = -1
                inventory[key].canRemove = false
                table.insert(items, inventory[key])
            end
        end
    end

    if Config.IncludeWeapons and weapons ~= nil then
        for key, value in pairs(weapons) do
            local weaponHash = GetHashKey(weapons[key].name)
            if weapons[key].name ~= "WEAPON_UNARMED" then
                table.insert(
                    items,
                    {
                        label = weapons[key].label,
                        count = weapons[key].ammo,
                        limit = -1,
                        type = "item_weapon",
                        name = weapons[key].name,
                        usable = false,
                        rare = false,
                        canRemove = false
                    }
                )
            end
        end
    end

    SendNUIMessage(
        {
            action = "setSecondInventoryItems",
            itemList = items,
			plate = data.plate
			
        }
    )
	s_waitingOnResults = false
end

function refreshPlayerInventory()
    setPlayerInventoryData()
end

RegisterNUICallback("closetrunk",function(data, cb)
	print( 'close trunk nui || fired from webpage')
	TriggerServerEvent('e4fe04a4-bf78-477e-9b66-d18f8c253cf5',data.plate)
	print(json.encode(data))
	ClearPedTasks(GetPlayerPed(-1))
end)


local reloadingweapons = false

RegisterNetEvent(  'esxf:restoreLoadout')
AddEventHandler(   'esxf:restoreLoadout', function()
	reloadingweapons = true
	
	Wait(20000)
	
	reloadingweapons = false
	
end)

RegisterNUICallback("PutIntoTrunk",function(data, cb)
        if IsPedSittingInAnyVehicle(PlayerPedId()) then
            return
        end
		
		if s_lasttime > GetGameTimer() - 1200 then
			return
		else
			s_lasttime = GetGameTimer()
		end
		
        if type(data.number) == "number" and math.floor(data.number) == data.number then
            local count = tonumber(data.number)
			local weaponComponents = {}
			
			if reloadingweapons == true and  data.item.type == "item_weapon" then
				print('clearing loadout/logging')
				TriggerEvent('aedddfbc-eb50-4837-b120-b7df4ae0d34e')
				return				
            elseif data.item.type == "item_weapon" then
                count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
				local weapongroup = GetWeapontypeGroup(GetHashKey(data.item.name))
				local weaponHash = GetHashKey(data.item.name)
				local components = {}
				
			--	print( "MY ITEM: " .. data.item.name) 
				for i=1, #Config.Weapons, 1 do
				--	print(Config.Weapons[i].name)
					if data.item.name == Config.Weapons[i].name then
						
						components = Config.Weapons[i].components
					end
				
				end
				
				

				for j=1, #components, 1 do
					
					if HasPedGotWeaponComponent(PlayerPedId(), weaponHash, components[j].hash) then
						table.insert(weaponComponents, components[j].name)
					end
				end
				count = count + 1
            end
			
			--print(json.encode(weaponComponents))
			s_requestid = s_requestid + 1
			if s_waitingOnResults == false then
				TriggerServerEvent('54cbb238-4758-4000-9cfd-d4ccaa4d7c97', trunkData.plate, data.item.type, data.item.name, count, trunkData.max, trunkData.myVeh, data.item.label, weaponComponents,s_requestid)
			end
        end

        Wait(250)
        loadPlayerInventory()

        cb("ok")
    end)


RegisterNUICallback("TakeFromTrunk", function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end
		
		if s_lasttime > GetGameTimer() - 1200 then
			return
		else
			s_lasttime = GetGameTimer()
		end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
			s_requestid = s_requestid + 1
			if s_waitingOnResults == false then
				TriggerServerEvent('fc172064-e01e-4139-9c11-afae9165ab33', trunkData.plate, data.item.type, data.item.name, tonumber(data.number), trunkData.max, trunkData.myVeh,s_requestid)
			end
        end

        Wait(250)
        loadPlayerInventory()

        cb("ok")
end)