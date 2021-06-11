local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX                           = nil
local OwnedProperties         = {}
local Blips                   = {}
local CurrentProperty         = nil
local CurrentPropertyOwner    = nil
local LastProperty            = nil
local LastPart                = nil
local HasAlreadyEnteredMarker = false
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local FirstSpawn              = true
local HasChest                = false

local CProperty				  =nil


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	Citizen.Wait(math.random(22000,30000))
	ESX.TriggerServerCallback('04462313-4c20-4b1a-b7c6-29cd1a41a54a', function(properties)
		Config.Properties = properties
		CreateBlips()
	end)
	Citizen.Wait(math.random(10000,15000))
	ESX.TriggerServerCallback('16dc6d1e-1c32-4d7b-95b3-2a66e7e5266f', function(ownedProperties)
		for i=1, #ownedProperties, 1 do
			SetPropertyOwned(ownedProperties[i], true)
		end
	end)

end)

Citizen.CreateThread(function()
	Wait(10000)
	local loc = vector3(-1099.1080322266,-1226.9364013672,-139.90643310547)
	local home = CreateObjectNoOffset(`shell_lester`, loc, false, false, false)
	FreezeEntityPosition(home, true)
	SetEntityDynamic(home, false)	
	
	local loc = vector3(-478.32272338867,218.34344482422,21.206924438477)
	local home = CreateObjectNoOffset(`shell_v16low`, loc, false, false, false)
	FreezeEntityPosition(home, true)
	SetEntityDynamic(home, false)
end)
--

RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(xPlayer)
	ESX.TriggerServerCallback('04462313-4c20-4b1a-b7c6-29cd1a41a54a', function(properties)
		Config.Properties = properties
		CreateBlips()
	end)

	ESX.TriggerServerCallback('16dc6d1e-1c32-4d7b-95b3-2a66e7e5266f', function(ownedProperties)
		for i=1, #ownedProperties, 1 do
			SetPropertyOwned(ownedProperties[i], true)
		end
	end)
end)

-- only used when script is restarting mid-session
RegisterNetEvent('4cb6becb-6e51-4358-b086-78195f090704')
AddEventHandler('4cb6becb-6e51-4358-b086-78195f090704', function(properties)
	Config.Properties = properties
	CreateBlips()

	ESX.TriggerServerCallback('16dc6d1e-1c32-4d7b-95b3-2a66e7e5266f', function(ownedProperties)
		for i=1, #ownedProperties, 1 do
			SetPropertyOwned(ownedProperties[i], true)
		end
	end)
end)

function DrawSub(text, time)
	ClearPrints()
	SetTextEntry_2('STRING')
	AddTextComponentString(text)
	DrawSubtitleTimed(time, 1)
end

function CreateBlips()
	for i=1, #Config.Properties, 1 do
		local property = Config.Properties[i]

		if property.entering ~= nil then
			Blips[property.name] = AddBlipForCoord(property.entering.x, property.entering.y, property.entering.z)

			SetBlipSprite (Blips[property.name], 369)
			SetBlipDisplay(Blips[property.name], 4)
			SetBlipScale  (Blips[property.name], 1.0)
			SetBlipAsShortRange(Blips[property.name], true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U('free_prop'))
			EndTextCommandSetBlipName(Blips[property.name])
		end
	end
end

function GetProperties()
	return Config.Properties
end

function GetProperty(name)
	for i=1, #Config.Properties, 1 do
		if Config.Properties[i].name == name then
			return Config.Properties[i]
		end
	end
end

function GetGateway(property)
	for i=1, #Config.Properties, 1 do
		local property2 = Config.Properties[i]

		if property2.isGateway and property2.name == property.gateway then
			return property2
		end
	end
end

function GetGatewayProperties(property)
	local properties = {}

	for i=1, #Config.Properties, 1 do
		if Config.Properties[i].gateway == property.name then
			table.insert(properties, Config.Properties[i])
		end
	end

	return properties
end

function EnterProperty(name, owner)
	local property       = GetProperty(name)
	local playerPed      = PlayerPedId()
	CurrentProperty      = property
	CurrentPropertyOwner = owner

	for i=1, #Config.Properties, 1 do
		if Config.Properties[i].name ~= name then
			Config.Properties[i].disabled = true
		end
	end

	TriggerServerEvent('a5dddd9d-b9d9-4a38-aa6e-a67e8917011e', name)

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(0)
		end

		for i=1, #property.ipls, 1 do
			RequestIpl(property.ipls[i])

			while not IsIplActive(property.ipls[i]) do
				Citizen.Wait(0)
			end
		end
		FreezeEntityPosition(GetPlayerPed(-1), true)
		SetEntityCoords(playerPed, property.inside.x, property.inside.y, property.inside.z)
		Wait(1000)
		FreezeEntityPosition(GetPlayerPed(-1), false)
		
		DoScreenFadeIn(800)
		DrawSub(property.label, 5000)
	end)

end

function ExitProperty(name)
	local property  = GetProperty(name)
	local playerPed = PlayerPedId()
	local outside   = nil
	CurrentProperty = nil

	if property.isSingle then
		outside = property.outside
	else
		outside = GetGateway(property).outside
	end

	TriggerServerEvent('98bc4a8b-6dad-4218-b35a-62837d2ce404')

	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(0)
		end

		SetEntityCoords(playerPed, outside.x, outside.y, outside.z)

		for i=1, #property.ipls, 1 do
			RemoveIpl(property.ipls[i])
		end

		for i=1, #Config.Properties, 1 do
			Config.Properties[i].disabled = false
		end

		DoScreenFadeIn(800)
	end)
end

function SetPropertyOwned(name, owned)
	local property     = GetProperty(name)
	local entering     = nil
	local enteringName = nil

	if property.isSingle then
		entering     = property.entering
		enteringName = property.name
	else
		local gateway = GetGateway(property)
		entering      = gateway.entering
		enteringName  = gateway.name
	end

	if owned then

		OwnedProperties[name] = true
		RemoveBlip(Blips[enteringName])

		Blips[enteringName] = AddBlipForCoord(entering.x, entering.y, entering.z)
		SetBlipSprite(Blips[enteringName], 357)
		SetBlipDisplay(Blips[enteringName], 4)
		SetBlipColour(Blips[enteringName],50)
		SetBlipAsShortRange(Blips[enteringName], true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('property'))
		EndTextCommandSetBlipName(Blips[enteringName])

	else

		OwnedProperties[name] = nil
		local found = false

		for k,v in pairs(OwnedProperties) do
			local _property = GetProperty(k)
			local _gateway  = GetGateway(_property)

			if _gateway ~= nil then
				if _gateway.name == enteringName then
					found = true
					break
				end
			end
		end

		if not found then
			RemoveBlip(Blips[enteringName])

			Blips[enteringName] = AddBlipForCoord(entering.x, entering.y, entering.z)
			SetBlipSprite(Blips[enteringName], 369)
			SetBlipDisplay(Blips[enteringName],4)
			SetBlipColour(Blips[enteringName],4)
			SetBlipAsShortRange(Blips[enteringName], true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U('free_prop'))
			EndTextCommandSetBlipName(Blips[enteringName])
		end

	end

end

function PropertyIsOwned(property)
	return OwnedProperties[property.name] == true
end

function OpenPropertyMenu(property)
	local elements = {}
	local pp = property

	if PropertyIsOwned(property) then
		table.insert(elements, {label = _U('enter'), value = 'enter'})

		if not Config.EnablePlayerManagement then
			table.insert(elements, {label = _U('leave'), value = 'leave'})
		end
	else
		if not Config.EnablePlayerManagement then
			if property ~= nil and property.price ~= nil then
				table.insert(elements, {label = _U('buy') .. ' $' .. property.price , value = 'buy'})
			else
				table.insert(elements, {label = _U('buy'), value = 'buy'})
			end
			--table.insert(elements, {label = _U('rent'), value = 'rent'})
		end

		table.insert(elements, {label = _U('visit'), value = 'visit'})
	end
	local PlayerData = ESX.GetPlayerData()
	
	if PlayerData ~= nil and PlayerData.job ~= nil and PlayerData.job.name == 'police' then
		table.insert(elements, {label = 'Break into Property (You must have a warrant)', value = 'police_entry'})
	end
	

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'property',
	{
		title    = property.label,
		align    = 'top-right',
		elements = elements
	}, function(data, menu)
		menu.close()
		
		local propertyn =  property.name
		if propertyn == nil then
			propertyn = CurrentActionData.property
		end
		print(property.name)

		if data.current.value == 'enter' then
		
			print(property.name)
			print(ESX.GetPlayerData().identifier)
			TriggerEvent('938957cb-f3e7-4cc1-b236-81a6544d274d', 'property', {property = property.name, owner = ESX.GetPlayerData().identifier})
		elseif data.current.value == 'leave' then
			TriggerServerEvent('9d5ecec1-3118-4123-a624-5e1969e4ab5b', property.name)
		elseif data.current.value == 'buy' then
			TriggerServerEvent('dfe07bd7-9d03-48a4-9cd7-0d91be3f158c', property.name)
		elseif data.current.value == 'rent' then
			TriggerServerEvent('72915926-7006-45af-915c-55f43642dcf8', property.name)
		elseif data.current.value == 'visit' then
			TriggerEvent('938957cb-f3e7-4cc1-b236-81a6544d274d', 'property', {property = property.name, owner = ESX.GetPlayerData().identifier})
			
		elseif data.current.value == 'police_entry' then
			if IsAuthorized() then
				--print('high prop')
				--print(currentProperty)
				--print(lastProperty)
				--print(property.name)
				--print(CProperty)
				TriggerEvent('da18b000-de77-4539-ac4b-b6d2c6ca3bbd', owner,CProperty,propertyn)
			else
				ESX.ShowNotification('~r~Error\n~w~You do not have a search warrant to break in')
			end
			
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'property_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {property = property}
	end)
end


function IsAuthorized()
	local Inventory = ESX.GetPlayerData()["inventory"]

	for invId = 1, #Inventory do
		if Inventory[invId]["count"] > 0 then
			if "search_warrant" == Inventory[invId]["name"] then
				return true
			end
		end
	end


	return false
end

function OpenGatewayMenu(property)
	if Config.EnablePlayerManagement then
		OpenGatewayOwnedPropertiesMenu(gatewayProperties)
	else

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gateway',
		{
			title    = property.name,
			align    = 'top-right',
			elements = {
				{label = _U('owned_properties'),    value = 'owned_properties'},
				{label = _U('available_properties'), value = 'available_properties'}
			}
		}, function(data, menu)
			if data.current.value == 'owned_properties' then
				OpenGatewayOwnedPropertiesMenu(property)
			elseif data.current.value == 'available_properties' then
				OpenGatewayAvailablePropertiesMenu(property)
			end
		end, function(data, menu)
			menu.close()

			CurrentAction     = 'gateway_menu'
			CurrentActionMsg  = _U('press_to_menu')
			CurrentActionData = {property = property}
		end)

	end
end

function OpenGatewayOwnedPropertiesMenu(property)
	local gatewayProperties = GetGatewayProperties(property)
	local elements          = {}

	for i=1, #gatewayProperties, 1 do
		if PropertyIsOwned(gatewayProperties[i]) then
			table.insert(elements, {
				label = gatewayProperties[i].label,
				value = gatewayProperties[i].name
			})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gateway_owned_properties',
	{
		title    = property.name .. ' - ' .. _U('owned_properties'),
		align    = 'top-right',
		elements = elements
	}, function(data, menu)
		menu.close()

		local elements = {
			{label = _U('enter'), value = 'enter'}
		}

		if not Config.EnablePlayerManagement then
			table.insert(elements, {label = _U('leave'), value = 'leave'})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gateway_owned_properties_actions',
		{
			title    = data.current.label,
			align    = 'top-right',
			elements = elements
		}, function(data2, menu2)
			menu2.close()

			if data2.current.value == 'enter' then
				TriggerEvent('938957cb-f3e7-4cc1-b236-81a6544d274d', 'property', {property = data.current.value, owner = ESX.GetPlayerData().identifier})
				ESX.UI.Menu.CloseAll()
			elseif data2.current.value == 'leave' then
				TriggerServerEvent('9d5ecec1-3118-4123-a624-5e1969e4ab5b', data.current.value)
			end
		end, function(data2, menu2)
			menu2.close()
		end)

	end, function(data, menu)
		menu.close()
	end)
end

function OpenGatewayAvailablePropertiesMenu(property)
	local gatewayProperties = GetGatewayProperties(property)
	local elements          = {}

	for i=1, #gatewayProperties, 1 do
		if not PropertyIsOwned(gatewayProperties[i]) then
			table.insert(elements, {
				label = gatewayProperties[i].label .. ' $' .. math.floor(gatewayProperties[i].price),
				value = gatewayProperties[i].name,
				price = gatewayProperties[i].price
			})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gateway_available_properties',
	{
		title    = property.name .. ' - ' .. _U('available_properties'),
		align    = 'top-right',
		elements = elements
	}, function(data, menu)

		menu.close()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gateway_available_properties_actions',
		{
			title    = property.label .. ' - ' .. _U('available_properties'),
			align    = 'top-right',
			elements = {
				{label = _U('buy'), value = 'buy'},
				{label = _U('rent'), value = 'rent'},
				{label = _U('visit'), value = 'visit'}
			}
		}, function(data2, menu2)
			menu2.close()

			if data2.current.value == 'buy' then
				TriggerServerEvent('dfe07bd7-9d03-48a4-9cd7-0d91be3f158c', data.current.value)
			elseif data2.current.value == 'rent' then
				TriggerServerEvent('72915926-7006-45af-915c-55f43642dcf8', data.current.value)
			elseif data2.current.value == 'visit' then
				TriggerEvent('938957cb-f3e7-4cc1-b236-81a6544d274d', 'property', {property = data.current.value, owner = ESX.GetPlayerData().identifier})
			end
		end, function(data2, menu2)
			menu2.close()
		end)

	end, function(data, menu)
		menu.close()
	end)
end

function OpenRoomMenu(property, owner)
	local entering = nil
	local elements = {}

	if property.isSingle then
		entering = property.entering
	else
		entering = GetGateway(property).entering
	end

	table.insert(elements, {label = _U('invite_player'),  value = 'invite_player'})

	if CurrentPropertyOwner == owner then
		table.insert(elements, {label = _U('player_clothes'), value = 'player_dressing'})
		table.insert(elements, {label = _U('remove_cloth'), value = 'remove_cloth'})
	end

	table.insert(elements, {label = "Property inventory", value = "property_inventory"})

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room',
	{
		title    = property.label,
		align    = 'top-right',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'invite_player' then

			local playersInArea = ESX.Game.GetPlayersInArea(entering, 10.0)
			local elements      = {}

			for i=1, #playersInArea, 1 do
				if playersInArea[i] ~= PlayerId() then
					table.insert(elements, {label = GetPlayerName(playersInArea[i]), value = playersInArea[i]})
				end
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room_invite',
			{
				title    = property.label .. ' - ' .. _U('invite'),
				align    = 'top-right',
				elements = elements,
			}, function(data2, menu2)
				TriggerEvent('d2ea6153-b91f-4d0f-af1a-3d638a340db9', 'property', GetPlayerServerId(data2.current.value), {property = property.name, owner = owner})
				ESX.ShowNotification(_U('you_invited', GetPlayerName(data2.current.value)))
			end, function(data2, menu2)
				menu2.close()
			end)

		elseif data.current.value == 'player_dressing' then

			ESX.TriggerServerCallback('0b0864e8-514d-4516-ae80-78a3d89de590', function(dressing)
				local elements = {}

				for i=1, #dressing, 1 do
					table.insert(elements, {
						label = dressing[i],
						value = i
					})
				end

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_dressing',
				{
					title    = property.label .. ' - ' .. _U('player_clothes'),
					align    = 'top-right',
					elements = elements
				}, function(data2, menu2)

					TriggerEvent('d3bdbe20-bf7d-4df2-9ef6-9026a86a6e87', function(skin)
						ESX.TriggerServerCallback('29c30a74-1b0a-4001-8865-fe439f486255', function(clothes)
							TriggerEvent('1d09cf94-2c53-4220-a089-0339ce8bb123', skin, clothes)
							TriggerEvent('2b9879b9-88c4-4a82-afd1-2308ebf69ffe', skin)

							TriggerEvent('d3bdbe20-bf7d-4df2-9ef6-9026a86a6e87', function(skin)
								TriggerServerEvent('ad5940f4-3fe4-4fc5-9070-284adcd9246d', skin)
							end)
						end, data2.current.value)
					end)

				end, function(data2, menu2)
					menu2.close()
				end)
			end)

		elseif data.current.value == 'remove_cloth' then

			ESX.TriggerServerCallback('0b0864e8-514d-4516-ae80-78a3d89de590', function(dressing)
				local elements = {}

				for i=1, #dressing, 1 do
					table.insert(elements, {
						label = dressing[i],
						value = i
					})
				end

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'remove_cloth', {
					title    = property.label .. ' - ' .. _U('remove_cloth'),
					align    = 'top-right',
					elements = elements
				}, function(data2, menu2)
					menu2.close()
					TriggerServerEvent('ceb362e4-7086-47ef-896c-e15a62104388', data2.current.value)
					ESX.ShowNotification(_U('removed_cloth'))
				end, function(data2, menu2)
					menu2.close()
				end)
			end)

		elseif data.current.value == "property_inventory" then
			menu.close()
			OpenPropertyInventoryMenu(property, owner)
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'room_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {property = property, owner = owner}
	end)
end



function OpenPropertyInventoryMenu(property, owner)
		TriggerEvent('939224e0-dc6c-432f-9ac7-bcce6b95eaf7',property,owner)
end



function OpenRoomInventoryMenu(property, owner)

	ESX.TriggerServerCallback('115e9fae-1906-4017-90d3-11f8947b38f9', function(inventory)

		local elements = {}

		if inventory.blackMoney > 0 then
			table.insert(elements, {
				label = _U('dirty_money', math.floor(inventory.blackMoney)),
				type = 'item_account',
				value = 'black_money'
			})
		end

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type = 'item_standard',
					value = item.name
				})
			end
		end

		for i=1, #inventory.weapons, 1 do
			local weapon = inventory.weapons[i]

			table.insert(elements, {
				label = ESX.GetWeaponLabel(weapon.name) .. ' [' .. weapon.ammo .. ']',
				type  = 'item_weapon',
				value = weapon.name,
				ammo  = weapon.ammo
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'room_inventory',
		{
			title    = property.label .. ' - ' .. _U('inventory'),
			align    = 'top-right',
			elements = elements
		}, function(data, menu)

			if data.current.type == 'item_weapon' then

				menu.close()

				TriggerServerEvent('2abd2282-51c2-4792-b85b-4340bd25f8be', owner, data.current.type, data.current.value, data.current.ammo)
				ESX.SetTimeout(300, function()
					OpenRoomInventoryMenu(property, owner)
				end)

			else

				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'get_item_count', {
					title = _U('amount')
				}, function(data2, menu)

					local quantity = tonumber(data2.value)
					if quantity == nil then
						ESX.ShowNotification(_U('amount_invalid'))
					else
						menu.close()

						TriggerServerEvent('2abd2282-51c2-4792-b85b-4340bd25f8be', owner, data.current.type, data.current.value, quantity)
						ESX.SetTimeout(300, function()
							OpenRoomInventoryMenu(property, owner)
						end)
					end

				end, function(data2,menu)
					menu.close()
				end)

			end

		end, function(data, menu)
			menu.close()
		end)

	end, owner)

end

function OpenPlayerInventoryMenu(property, owner)

	ESX.TriggerServerCallback('6ecc32bc-c2f8-4fb2-8dc5-871994e2693b', function(inventory)

		local elements = {}

		if inventory.blackMoney > 0 then
			table.insert(elements, {
				label = _U('dirty_money', math.floor(inventory.blackMoney)),
				type  = 'item_account',
				value = 'black_money'
			})
		end

		for i=1, #inventory.items, 1 do
			local item = inventory.items[i]

			if item.count > 0 then
				table.insert(elements, {
					label = item.label .. ' x' .. item.count,
					type  = 'item_standard',
					value = item.name
				})
			end
		end

		for i=1, #inventory.weapons, 1 do
			local weapon = inventory.weapons[i]

			table.insert(elements, {
				label = weapon.label .. ' [' .. weapon.ammo .. ']',
				type  = 'item_weapon',
				value = weapon.name,
				ammo  = weapon.ammo
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'player_inventory',
		{
			title    = property.label .. ' - ' .. _U('inventory'),
			align    = 'top-right',
			elements = elements
		}, function(data, menu)

			if data.current.type == 'item_weapon' then

				menu.close()

				TriggerServerEvent('43ebc23d-688a-4599-8683-a46c412caa48', owner, data.current.type, data.current.value, data.current.ammo)

				ESX.SetTimeout(300, function()
					OpenPlayerInventoryMenu(property, owner)
				end)

			else

				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'put_item_count', {
					title = _U('amount'),
				}, function(data2, menu2)

					local quantity = tonumber(data2.value)

					if quantity == nil then
						ESX.ShowNotification(_U('amount_invalid'))
					else

						menu2.close()

						TriggerServerEvent('43ebc23d-688a-4599-8683-a46c412caa48', owner, data.current.type, data.current.value, tonumber(data2.value))
						ESX.SetTimeout(300, function()
							OpenPlayerInventoryMenu(property, owner)
						end)
					end

				end, function(data2, menu2)
					menu2.close()
				end)

			end

		end, function(data, menu)
			menu.close()
		end)

	end)

end

AddEventHandler('71416c08-0e16-4e8d-89d0-3e4c3ad884f9', function()
	TriggerEvent('6f22e07f-350a-4dfe-81fd-eda5b736d047', 'property', function(instance)
		EnterProperty(instance.data.property, instance.data.owner)
	end, function(instance)
		ExitProperty(instance.data.property)
	end)
end)

AddEventHandler('880c0a93-b305-46b3-b84c-a120fee9e841', function()
	if FirstSpawn then

		Citizen.CreateThread(function()

			while not ESX.IsPlayerLoaded() do
				Citizen.Wait(0)
			end

			ESX.TriggerServerCallback('d4540782-c214-433d-bfb2-ddba1d0b245b', function(propertyName)
				if propertyName ~= nil then
					if propertyName ~= '' then
						TriggerEvent('938957cb-f3e7-4cc1-b236-81a6544d274d', 'property', {property = propertyName, owner = ESX.GetPlayerData().identifier})
					end
				end
			end)
		end)

		FirstSpawn = false
	end
end)

AddEventHandler('6a92fa12-8546-490d-843b-9ed3e635c878', function(cb)
	cb(GetProperties())
end)

AddEventHandler('1e74cba9-a271-4c7a-9685-76e067d9f1b4', function(name, cb)
	cb(GetProperty(name))
end)

AddEventHandler('d86ab6ae-38bb-4646-8922-d1f1e61f97c4', function(property, cb)
	cb(GetGateway(property))
end)

RegisterNetEvent('3114e656-314e-417e-8a25-0e82f07cdf9d')
AddEventHandler('3114e656-314e-417e-8a25-0e82f07cdf9d', function(name, owned)
	SetPropertyOwned(name, owned)
end)

RegisterNetEvent('328202da-e4de-4ee1-bddf-63ae1f0cffe9')
AddEventHandler('328202da-e4de-4ee1-bddf-63ae1f0cffe9', function(instance)
	if instance.type == 'property' then
		TriggerEvent('51fc5891-b4b6-487b-b241-944c24796f10', instance)
	end
end)

RegisterNetEvent('bc5d0c94-3d48-467a-854a-84634ac40e73')
AddEventHandler('bc5d0c94-3d48-467a-854a-84634ac40e73', function(instance)
	if instance.type == 'property' then
		local property = GetProperty(instance.data.property)
		local isHost   = GetPlayerFromServerId(instance.host) == PlayerId()
		local isOwned  = false

		if PropertyIsOwned(property) == true then
			isOwned = true
		end

		if isOwned or not isHost then
			HasChest = true
		else
			HasChest = false
		end
	end
end)

RegisterNetEvent('12ebf9f8-7ed6-4609-8c3a-4d0841a70300')
AddEventHandler('12ebf9f8-7ed6-4609-8c3a-4d0841a70300', function(instance, player)
	if player == instance.host then
		TriggerEvent('910afdde-9300-4092-9c9f-a0beb6fa1127')
	end
end)

AddEventHandler('404561bd-6133-4637-bc32-fdce65a3b1e2', function(name, part)
	local property = GetProperty(name)
		print ('FFFFF ' .. name .. ' part: ' .. part)
	if name ~= nil then
		CProperty = name
	end
	if part == 'entering' then
		if property.isSingle then
			print ('FFFFF ' .. name)
			CurrentAction     = 'property_menu'
			CurrentActionMsg  = _U('press_to_menu')
			CurrentActionData = {property = property}

		else
			CurrentAction     = 'gateway_menu'
			CurrentActionMsg  = _U('press_to_menu')
			CurrentActionData = {property = property}

		end
	elseif part == 'exit' then
		CurrentAction     = 'room_exit'
		CurrentActionMsg  = _U('press_to_exit')
		CurrentActionData = {propertyName = name}
	elseif part == 'roomMenu' then
		CurrentAction     = 'room_menu'
		CurrentActionMsg  = _U('press_to_menu')
		CurrentActionData = {property = property, owner = CurrentPropertyOwner}
	end
end)

AddEventHandler('41ec31e2-1251-4801-b864-eccd08bba0d6', function(name, part)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)

-- Display markers

local closeto = false
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(1)

		local coords = GetEntityCoords(PlayerPedId())
		local closeto = false
		for i=1, #Config.Properties, 1 do
			local property = Config.Properties[i]
			local isHost   = false
			
			if(property.entering ~= nil and not property.disabled and #(coords - vector3(property.entering.x, property.entering.y, property.entering.z)) < Config.DrawDistance) then
				DrawMarker(Config.MarkerType, property.entering.x, property.entering.y, property.entering.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
				closeto = true
			end

			if(property.exit ~= nil and not property.disabled and #(coords - vector3(property.exit.x, property.exit.y, property.exit.z)) < Config.DrawDistance) then
				DrawMarker(Config.MarkerType, property.exit.x, property.exit.y, property.exit.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
				closeto = true
			end

			if(property.roomMenu ~= nil and HasChest and not property.disabled and #(coords - vector3(property.roomMenu.x, property.roomMenu.y, property.roomMenu.z)) < Config.DrawDistance) then
				DrawMarker(Config.MarkerType, property.roomMenu.x, property.roomMenu.y, property.roomMenu.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.RoomMenuMarkerColor.r, Config.RoomMenuMarkerColor.g, Config.RoomMenuMarkerColor.b, 100, false, true, 2, false, false, false, false)
				closeto = true
			end
		end
		if closeto == false then
			Citizen.Wait(1000)
		end

	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(500)

		local coords          = GetEntityCoords(PlayerPedId())
		local isInMarker      = false
		local currentProperty = nil
		local currentPart     = nil

		for i=1, #Config.Properties, 1 do
			local property = Config.Properties[i]


			if(property.inside ~= nil and not property.disabled and #(coords - vector3(property.inside.x, property.inside.y, property.inside.z)) < Config.MarkerSize.x) then
				isInMarker      = true
				currentProperty = property.name
				currentPart     = 'inside'
			end

			if(property.outside ~= nil and not property.disabled and #(coords - vector3(property.outside.x, property.outside.y, property.outside.z)) < Config.MarkerSize.x) then
				isInMarker      = true
				currentProperty = property.name
				currentPart     = 'outside'
			end

			if(property.roomMenu ~= nil and HasChest and not property.disabled and #(coords - vector3(property.roomMenu.x, property.roomMenu.y, property.roomMenu.z)) < Config.MarkerSize.x) then
				isInMarker      = true
				currentProperty = property.name
				currentPart     = 'roomMenu'
			end
			
			if(property.entering ~= nil and not property.disabled and #(coords - vector3(property.entering.x, property.entering.y, property.entering.z)) < Config.MarkerSize.x) then
				isInMarker      = true
				currentProperty = property.name
				currentPart     = 'entering'
			end

			if(property.exit ~= nil and not property.disabled and #(coords - vector3(property.exit.x, property.exit.y, property.exit.z)) < Config.MarkerSize.x) then
				isInMarker      = true
				currentProperty = property.name
				currentPart     = 'exit'
			end
			
			

		end

		if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastProperty ~= currentProperty or LastPart ~= currentPart) ) then
			
			HasAlreadyEnteredMarker = true
			LastProperty            = currentProperty
			LastPart                = currentPart
			
			TriggerEvent('404561bd-6133-4637-bc32-fdce65a3b1e2', currentProperty, currentPart)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('41ec31e2-1251-4801-b864-eccd08bba0d6', LastProperty, LastPart)
		end
		
		if closeto == false then
			Citizen.Wait(1000)
		end

	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(10)

		if CurrentAction ~= nil then

			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, Keys['E']) then

				if CurrentAction == 'property_menu' then
					OpenPropertyMenu(CurrentActionData.property)
				elseif CurrentAction == 'gateway_menu' then
					if Config.EnablePlayerManagement then
						OpenGatewayOwnedPropertiesMenu(CurrentActionData.property)
					else
						OpenGatewayMenu(CurrentActionData.property)
					end
				elseif CurrentAction == 'room_menu' then
					OpenRoomMenu(CurrentActionData.property, CurrentActionData.owner)
				elseif CurrentAction == 'room_exit' then
					TriggerEvent('910afdde-9300-4092-9c9f-a0beb6fa1127')
				end

				CurrentAction = nil
			end

		else -- no current action, sleep mode
			Citizen.Wait(1000)
		end
	end
end)
