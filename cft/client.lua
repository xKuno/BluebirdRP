ESX = nil
local display = false

local inv = {}

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

function isWeapon(item)
	local weaponList = ESX.GetWeaponList()
	for i=1, #weaponList, 1 do
		if weaponList[i].label == item then
			return true
		end
	end
	return false
end

local function craftItem(ingredients)
	local ingredientsPrepped = {}
	for name, count in pairs(ingredients) do
		if count > 0 then
			table.insert(ingredientsPrepped, { item = name , quantity = count})
		end
	end
	TriggerServerEvent('2af2a7aa-e912-4540-973f-13723b27809a', ingredientsPrepped)
end

local allowmore_crafting = true
RegisterNetEvent('47e49c1a-b9a5-4cdf-932b-0ee6ae40031a')
AddEventHandler('47e49c1a-b9a5-4cdf-932b-0ee6ae40031a', function(message, timer,item)
	allowmore_crafting = false
	FreezeEntityPosition(GetPlayerPed(-1),true)
	local _item = item
	TriggerServerEvent('7fcbafb2-e15d-4e94-9a71-c348def151ae',"CRAFTING", "START ITEM: " .. _item)
    exports["t0sic_loadingbar"]:StartDelayedFunction(message, timer, function()
			TriggerServerEvent('7fcbafb2-e15d-4e94-9a71-c348def151ae',"CRAFTING", "COMPLETE ITEM: " .. _item)
			FreezeEntityPosition(GetPlayerPed(-1),false)
			allowmore_crafting = true
    end)
end)

RegisterNetEvent('3027f5f0-9690-49ee-86bc-4176eeea081c')
AddEventHandler('3027f5f0-9690-49ee-86bc-4176eeea081c', function(playerInventory)
	SetNuiFocus(true,true)
	local preppedInventory = {}
	inv = playerInventory
	for i=1, #playerInventory, 1 do
		if playerInventory[i].count > 0 and not isWeapon(playerInventory[i].label) then
			table.insert(preppedInventory, playerInventory[i])
		end
	end
	SendNUIMessage({
		inventory = preppedInventory,
		display = true
	})
	display = true
end)

RegisterNUICallback('craftItemNUI', function(data, cb)
	craftItem(data)
end)

RegisterNUICallback('NUIFocusOff', function()
	SetNuiFocus(false, false)
	SendNUIMessage({
		display = false
	})
	display = false
end)

RegisterNUICallback('ViewRecipies', function()
		SetNuiFocus(false, false)
		SendNUIMessage({
			display = false
		})
		display = false
		local elements = {}

		for item,ingredients in pairs(Config.Recipes) do
			if ingredients.hidden == nil then
				table.insert(elements, {label = Config.Recipes[item].title, value = item})
			elseif ingredients.hidden ~= nil and (Config.Recipes[item].required ~= nil and hasitem(Config.Recipes[item].required) or Config.Recipes[item].optional ~= nil and hasitem(Config.Recipes[item].optional)) then
				table.insert(elements, {label = " **BLUE PRINT** " .. Config.Recipes[item].title, value = item})
			end
		end
		
		ESX.UI.Menu.CloseAll()
		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'main_menu',
			{
				title    = 'Recipes',
				align    = 'top-right',
				elements = elements
			}, function(data, menu)
			
			elements = {}
			
			if Config.Recipes[data.current.value].blackmoney ~= nil then
				table.insert(elements, {label = 'Black Money $' .. Config.Recipes[data.current.value].blackmoney , value = 'black_money'})
			end
		
			for item,ingredients in pairs(Config.Recipes[data.current.value].items) do
				if ingredients.hidden == nil then
					table.insert(elements, {label = ingredients.item .. ' x' .. ingredients.quantity , value = ingredients.item})
					
				elseif ingredients.hidden ~= nil and Config.Recipes[item].required ~= nil and hasitem(Config.Recipes[item].required) then
					table.insert(elements, {label = ingredients.item .. ' x' .. ingredients.quantity , value = ingredients.item})
				end
				
			end

			
			menu.close()
			ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'main_menu',
			{
				title    = 'Ingredients',
				align    = 'top-right',
				elements = elements
			}, function(data2, menu2)
			
			local elementcars = {}
			local value = data2.current.value
			

			end,
			  function(data, menu)

				menu.close()
		

			  end)

		  end,
		  function(data, menu)

			menu.close()
	

		  end)
				

end)


function hasitem (item)
	for i=1, #inv, 1 do
		if inv[i].name == item and inv[i].count > 0 then
			print(item)
			
			return true
		end
	end
	
end

--[[
if Config.Keyboard.useKeyboard then
	-- Handle menu input
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(0)
			if IsControlJustReleased(1, Config.Keyboard.keyCode) and GetLastInputMethod(2) then
				TriggerServerEvent('40eba59f-a87b-4fe2-bb54-52fa5db5dff8')
			end
		end
	end)
end--]]

if Config.Shop.useShop then
	local inDrawingRange = false
	local function isPlayerInRange(coords1, coords2, range)	
		return (#(vector3(coords1.x, coords1.y, coords1.z)- vector3( coords2.x, coords2.y, coords2.z)) < range)
	end
	
	Citizen.CreateThread(function()
		--[[local blip = AddBlipForCoord(Config.Shop.shopCoordinates.x, Config.Shop.shopCoordinates.y, Config.Shop.shopCoordinates.z)
		SetBlipSprite (blip, Config.Shop.shopBlipID)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 1.0)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(Config.Shop.shopName)
		EndTextCommandSetBlipName(blip)--]]
		
		while true do
			Citizen.Wait(3000)
			inDrawingRange = isPlayerInRange(GetEntityCoords(PlayerPedId()), Config.Shop.shopCoordinates, 100)
		end
	end)
		
	Citizen.CreateThread(function()		
		while true do
			Citizen.Wait(0)
			if inDrawingRange then
				DrawMarker(1, Config.Shop.shopCoordinates.x, Config.Shop.shopCoordinates.y, Config.Shop.shopCoordinates.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Shop.zoneSize.x, Config.Shop.zoneSize.y, Config.Shop.zoneSize.z, Config.Shop.zoneColor.r, Config.Shop.zoneColor.g, Config.Shop.zoneColor.b, Config.Shop.zoneColor.a, false, true, 2, false, false, false, false)
				if not display and isPlayerInRange(GetEntityCoords(PlayerPedId()), Config.Shop.shopCoordinates, Config.Shop.zoneSize.x) then
					if allowmore_crafting == true then
						SetTextComponentFormat('STRING')
						AddTextComponentString("Press ~INPUT_CONTEXT~ to craft an item")
						DisplayHelpTextFromStringLabel(0, 0, 1, -1)
						if IsControlJustReleased(1, 38) then
							TriggerServerEvent('40eba59f-a87b-4fe2-bb54-52fa5db5dff8')
						end
					else
						SetTextComponentFormat('STRING')
						AddTextComponentString("Cannot craft at the moment as one is in progress")
						DisplayHelpTextFromStringLabel(0, 0, 1, -1)
					end
				end
			else
				Wait(3000)
			end
		end
	end)
end