local propData = nil

function setPropInventoryDataS(data, cash, blackMoney, inventory, weapons)

	print('set PROP inventory triggered')
    propData = data
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
	
	if cash ~= nil and cash > 0 then
		
		moneyData = {
			label = _U("cash"),
			name = "cash",
			type = "item_money",
			count = cash,
			usable = false,
			rare = false,
			limit = -1,
			canRemove = false
		}

		table.insert(items, moneyData)
		
		print('money cash ' .. cash)

	end

    if  inventory ~= nil then
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
            itemList = items
        }
    )
end

function openPropInventory()
    loadPlayerInventory()
    isInInventory = true

    SendNUIMessage(
        {
            action = "display",
            type = "property"
        }
    )

    SetNuiFocus(true, true)
end


RegisterNetEvent('2f31f430-217d-48f9-b692-e1107a448a5b')
AddEventHandler('2f31f430-217d-48f9-b692-e1107a448a5b',function(data, cash, blackMoney, inventory, weapons)
		print('open trunk inventory received')
		print(json.encode(data))
        setPropInventoryDataS(data, cash, blackMoney, inventory, weapons)
        openPropInventory()
    end
)


RegisterNUICallback("closeproperty",function(data, cb)
	print( 'close trunk nui || fired from webpage')
	TriggerServerEvent('e4fe04a4-bf78-477e-9b66-d18f8c253cf5',propData.plate)
	ClearPedTasks(GetPlayerPed(-1))
end)

RegisterNetEvent('939224e0-dc6c-432f-9ac7-bcce6b95eaf7')
AddEventHandler('939224e0-dc6c-432f-9ac7-bcce6b95eaf7',function(property,owner)
		print('open property inventory received')
		print(property)
		print('owner')
		print(owner)
	ESX.TriggerServerCallback('8135aa91-3bf7-4c82-9fb3-80e95ef59001', function(inventory)
		
			print('received inventory info from server')
			print(inventory.plate)
			print('house plate')
		  text = "House Inventory"
		  data = {plate = inventory.plate, max = '10000', myVeh = 'House Inventory2', text = text}
		  --TriggerEvent('85b1b203-c89b-4252-9177-f8d92cbbc51d', data, inventory.blackMoney, inventory.items, inventory.weapons)

			 
			setPropInventoryDataS(data, inventory.cash, inventory.blackMoney, inventory.items, inventory.weapons)
			openPropInventory()
		  
		  
		end, owner,property)
end)


RegisterNetEvent(  "esx_inventoryhud:openPropertyInventoryPROP")
AddEventHandler(  "esx_inventoryhud:openPropertyInventoryPROP",function(property,owner)
		print('open property inventory received')
		print(property)
		print('owner')
		print(owner)
	ESX.TriggerServerCallback('8135aa91-3bf7-4c82-9fb3-80e95ef59001', function(inventory)
		
			print('received inventory info from server')
			print(inventory.plate)
			print('house plate')
		  text = "House Inventory"
		  data = {plate = inventory.plate, max = '10000', myVeh = 'House Inventory2', text = text}
		  --TriggerEvent('85b1b203-c89b-4252-9177-f8d92cbbc51d', data, inventory.blackMoney, inventory.items, inventory.weapons)

			 
			setPropInventoryDataS(data, inventory.cash, inventory.blackMoney, inventory.items, inventory.weapons)
			openPropInventory()
		  
		  
		end, 'propc-'..property,'propc-'..property)
end)


RegisterNetEvent('da18b000-de77-4539-ac4b-b6d2c6ca3bbd')
AddEventHandler('da18b000-de77-4539-ac4b-b6d2c6ca3bbd',function(owner, _property, _propertylabel)
		
		print(owner)
		local property = _property
		local propertylabel = _propertylabel
		
			TriggerEvent('2c4f07a6-bf05-4b02-ba86-fd4472391cbd', "~b~Police\n~w~Enter the player id of the person you wish to enter.")
			DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 30)
			while (UpdateOnscreenKeyboard() == 0) do
				DisableAllControlActions(0);
				Wait(0);
			end
			if (GetOnscreenKeyboardResult()) then
				local result = GetOnscreenKeyboardResult()
				owner = result
			end
		if owner == nil then
			return
		end
		print('open property inventory received')
		print('owner')
		print(owner)
		print('property')
		print(property)
		print(propertylabel)
			
	ESX.TriggerServerCallback('8135aa91-3bf7-4c82-9fb3-80e95ef59001', function(inventory)
		

			print('received inventory info from server')
		  text = "House Inventory"
		  data = {plate = 'House Inventory', max = '10000', myVeh = 'House Inventory2', text = text}
		  --TriggerEvent('85b1b203-c89b-4252-9177-f8d92cbbc51d', data, inventory.blackMoney, inventory.items, inventory.weapons)
		  print('black')
		  print(inventory.blackMoney)
			 print('black')
			  print(inventory.cash)
			 
			setPropInventoryDataS(data, inventory.cash, inventory.blackMoney, inventory.items, inventory.weapons)
			openPropInventory()
		  
		  
		end, owner,property)
end)





RegisterNetEvent('b0d45ef1-8c5b-4ee1-b501-53622eee7d6d')
AddEventHandler('b0d45ef1-8c5b-4ee1-b501-53622eee7d6d',function(data, blackMoney, inventory, weapons)
    setPropInventoryDataS(data, blackMoney, inventory, weapons)
		

end)


local reloadingweapons = false

RegisterNetEvent(  'esxf:restoreLoadout')
AddEventHandler(   'esxf:restoreLoadout', function()
	reloadingweapons = true
	
	Wait(20000)
	
	reloadingweapons = false
	
end)


RegisterNUICallback("PutIntoProperty",function(data, cb)

	--print('put into property')
	--print(json.encode(data))
	
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
            if reloadingweapons == true and data.item.type == "item_weapon" then
				print('clearing loadout/logging')
				TriggerEvent('aedddfbc-eb50-4837-b120-b7df4ae0d34e')
				return					
			elseif data.item.type == "item_weapon" then
                count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
				local weapongroup = GetWeapontypeGroup(GetHashKey(data.item.name))
				local weaponHash = GetHashKey(data.item.name)
				local components = {}
				
			print( "MY ITEM: " .. data.item.name) 
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
				TriggerServerEvent('f33153de-159d-4d57-919d-750248730de0', propData.plate, data.item.type, data.item.name, count, propData.max, propData.myVeh, data.item.label, weaponComponents, s_requestid)
			end
        end

        Wait(250)
        loadPlayerInventory()

        cb("ok")
    end
)


RegisterNUICallback("TakeFromProperty", function(data, cb)
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
				TriggerServerEvent('8dab96ef-bac6-46a4-92d1-8337f1aaa19b', propData.plate, data.item.type, data.item.name, tonumber(data.number), propData.max, propData.myVeh, s_requestid)
			end
        end

        Wait(250)
        loadPlayerInventory()

        cb("ok")
end)
