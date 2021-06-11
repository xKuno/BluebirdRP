ESX                           = nil
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local PlayerData              = {}

local closer				 = false
local ShopListing 			  = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(500)
	end

	Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()
	Wait(5000)
	ESX.TriggerServerCallback('e3dd2d42-b9ee-4513-886c-ad99e7875820', function(ShopItems)
		for k,v in pairs(ShopItems) do
			if Config.Zones[k] ~= nil then
				Config.Zones[k].Items = v
			end
		end
	end)
end)

function OpenShopMenu(zone)
	PlayerData = ESX.GetPlayerData()

	local elements = {}
	for i=1, #Config.Zones[zone].Items, 1 do
		local item = Config.Zones[zone].Items[i]

		if item.limit == -1 then
			item.limit = 100
		end

		table.insert(elements, {
			label      = item.label .. ' - <span style="color: green;">$' .. item.price .. '</span>',
			label_real = item.label,
			item       = item.item,
			price      = item.price,

			-- menu properties
			value      = 1,
			type       = 'slider',
			min        = 1,
			max        = item.limit
		})
	end

	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop', {
		title    = _U('shop'),
		align    = 'top',
		elements = elements
	}, function(data, menu)
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
			title    = _U('shop_confirm', data.current.value, data.current.label_real, data.current.price * data.current.value),
			align    = 'top',
			elements = {
				{label = _U('no'),  value = 'no'},
				{label = _U('yes'), value = 'yes'}
			}
		}, function(data2, menu2)
			if data2.current.value == 'yes' then
				TriggerServerEvent('4b2f2b55-45f5-4e83-9ce1-fa833861ae3d', data.current.item, data.current.value, zone)
			end

			menu2.close()
		end, function(data2, menu2)
			menu2.close()
		end)
	end, function(data, menu)
		menu.close()
		CurrentAction     = 'shop_menu'
		CurrentActionMsg  = _U('press_menu')
		CurrentActionData = {zone = zone}
	end)
end

AddEventHandler('a86f1b24-d385-41b2-9a52-b22875e60660', function(zone)
	CurrentAction     = 'shop_menu'
	CurrentActionMsg  = _U('press_menu')
	CurrentActionData = {zone = zone}
end)

AddEventHandler('f5df3cb7-9def-4266-9fb5-23a6f1872738', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

-- Create Blips
Citizen.CreateThread(function()
	for k,v in pairs(Config.Zones) do
		for i = 1, #v.Pos, 1 do
			if v.Hidden == nil then
				local blip = AddBlipForCoord(v.Pos[i].x, v.Pos[i].y, v.Pos[i].z)
				SetBlipSprite (blip, 52)
				SetBlipDisplay(blip, 4)
				SetBlipScale  (blip, 1.0)
				SetBlipColour (blip, 2)
				SetBlipAsShortRange(blip, true)
				BeginTextCommandSetBlipName("STRING")
				AddTextComponentString(_U('shops'))
				EndTextCommandSetBlipName(blip)
			end
		end
	end
end)

-- Display markers

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2500)
		local coords = GetEntityCoords(GetPlayerPed(-1))
		local zShopListing = {}
		local zcloser = false
		for k,v in pairs(Config.Zones) do
			
			for i = 1, #v.Pos, 1 do

				if(Config.Type ~= -1 and #(coords - v.Pos[i]) < Config.DrawDistance) then
					zShopListing[k] = v
					zcloser = true
				end
			end
			Wait(100)
		end
		ShopListing = zShopListing
		if zcloser then
			closer = true
		else
			closer = false
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		local coords = GetEntityCoords(GetPlayerPed(-1))
		if closer then
			for k,v in pairs(ShopListing) do
				for i = 1, #v.Pos, 1 do
					if(Config.Type ~= -1 and #(coords - v.Pos[i]) < Config.DrawDistance) then
						DrawMarker(Config.Type, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
					end
				end
			end
		else
			Wait(2000)
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)
		if closer then
			local coords      = GetEntityCoords(GetPlayerPed(-1))
			local isInMarker  = false
			local currentZone = nil

			for k,v in pairs(ShopListing) do
				for i = 1, #v.Pos, 1 do
					if(GetDistanceBetweenCoords(coords, v.Pos[i].x, v.Pos[i].y, v.Pos[i].z, true) < Config.Size.x) then
						isInMarker  = true
						ShopItems   = v.Items
						currentZone = k
						LastZone    = k
					end
				end
			end
			if isInMarker and not HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = true
				TriggerEvent('a86f1b24-d385-41b2-9a52-b22875e60660', currentZone)
			end
			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('f5df3cb7-9def-4266-9fb5-23a6f1872738', LastZone)
			end
		else
			Wait(2000)
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if closer then
			if CurrentAction ~= nil then

				SetTextComponentFormat('STRING')
				AddTextComponentString(CurrentActionMsg)
				DisplayHelpTextFromStringLabel(0, 0, 1, -1)

				if IsControlJustReleased(0, 38) then

					if CurrentAction == 'shop_menu' then
						OpenShopMenu(CurrentActionData.zone)
					end

					CurrentAction = nil

				end

			else
				Citizen.Wait(100)
			end
		else
			Wait(2000)
		end
	end
end)