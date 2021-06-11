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

local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local IsInShopMenu            = false
local Categories              = {}
local Vehicles                = {}
local LastVehicles            = {}
local CurrentVehicleData      = nil

ESX                           = nil

Citizen.CreateThread(function ()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(10000)

	ESX.TriggerServerCallback('be970f52-273b-418a-990d-922b4bde7d53', function (categories)
		Categories = categories
	end)

	ESX.TriggerServerCallback('b3357328-85bc-4d3f-ac21-1b74fa73ae89', function (vehicles)
		Vehicles = vehicles
	end)

	if Config.EnablePlayerManagement then
		if ESX.PlayerData.job.name == 'luxurydealer' then
			Config.Zones.ShopEntering.Type = 1

			if ESX.PlayerData.job.grade_name == 'boss' then
				Config.Zones.BossActions.Type = 1
			end

		else
			Config.Zones.ShopEntering.Type = -1
			Config.Zones.BossActions.Type  = -1
		end
	end
end)

RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(xPlayer)
	ESX.PlayerData = xPlayer

	if Config.EnablePlayerManagement then
		if ESX.PlayerData.job.name == 'luxurydealer' then
			Config.Zones.ShopEntering.Type = 1

			if ESX.PlayerData.job.grade_name == 'boss' then
				Config.Zones.BossActions.Type = 1
			end

		else
			Config.Zones.ShopEntering.Type = -1
			Config.Zones.BossActions.Type  = -1
		end
	end
end)

RegisterNetEvent('68f8d400-df4d-400a-9c35-f54b87ff4d31')
AddEventHandler('68f8d400-df4d-400a-9c35-f54b87ff4d31', function (categories)
	Categories = categories
end)

RegisterNetEvent('4ec17853-b864-4405-a3e1-c2b70d9423ae')
AddEventHandler('4ec17853-b864-4405-a3e1-c2b70d9423ae', function (vehicles)
	Vehicles = vehicles
end)

function DeleteShopInsideVehicles()
	while #LastVehicles > 0 do
		local vehicle = LastVehicles[1]

		ESX.Game.DeleteVehicle(vehicle)
		table.remove(LastVehicles, 1)
	end
end

function ReturnVehicleProvider()
	ESX.TriggerServerCallback('1ce715a8-e87f-463b-a3e4-b457cdce1316', function (vehicles)
		local elements = {}
		local returnPrice
		for i=1, #vehicles, 1 do
			returnPrice = ESX.Math.Round(vehicles[i].price * 0.75)

			table.insert(elements, {
				label = ('%s [<span style="color:orange;">%s</span>]'):format(vehicles[i].name, _U('generic_shopitem', ESX.Math.GroupDigits(returnPrice))),
				value = vehicles[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_provider_menu', {
			css      = 'concesionnaire',
			title    = _U('return_provider_menu'),
			align    = 'top-right',
			elements = elements
		}, function (data, menu)
			TriggerServerEvent('0c26f689-4b2f-494d-a08e-a7a2c29e25d1', data.current.value)

			Citizen.Wait(300)
			menu.close()
			ReturnVehicleProvider()
		end, function (data, menu)
			menu.close()
		end)
	end)
end

function StartShopRestriction()
	Citizen.CreateThread(function()
		while IsInShopMenu do
			Citizen.Wait(1)

			DisableControlAction(0, 75,  true) -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		end
	end)
end

function OpenShopMenu()
	IsInShopMenu = true

	StartShopRestriction()
	ESX.UI.Menu.CloseAll()

	local playerPed = PlayerPedId()

	FreezeEntityPosition(playerPed, true)
	SetEntityVisible(playerPed, false)
	SetEntityCoords(playerPed, Config.Zones.ShopInside.Pos.x, Config.Zones.ShopInside.Pos.y, Config.Zones.ShopInside.Pos.z)

	local vehiclesByCategory = {}
	local elements           = {}
	local firstVehicleData   = nil

	for i=1, #Categories, 1 do
		vehiclesByCategory[Categories[i].name] = {}
	end

	for i=1, #Vehicles, 1 do
		if IsModelInCdimage(GetHashKey(Vehicles[i].model)) then
			table.insert(vehiclesByCategory[Vehicles[i].category], Vehicles[i])
		else
			print(('blue_vehicleshop: vehicle "%s" does not exist'):format(Vehicles[i].model))
		end
	end

	for i=1, #Categories, 1 do
		local category         = Categories[i]
		local categoryVehicles = vehiclesByCategory[category.name]
		local options          = {}

		for j=1, #categoryVehicles, 1 do
			local vehicle = categoryVehicles[j]

			if i == 1 and j == 1 then
				firstVehicleData = vehicle
			end

			table.insert(options, ('%s <span style="color:green;">%s</span>'):format(vehicle.name, _U('generic_shopitem', ESX.Math.GroupDigits(vehicle.price))))
		end

		table.insert(elements, {
			name    = category.name,
			label   = category.label,
			value   = 0,
			type    = 'slider',
			max     = #Categories[i],
			options = options
		})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_shop', {
		css      = 'concesionnaire',
		title    = _U('car_dealer'),
		align    = 'top-right',
		elements = elements
	}, function (data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm', {
			css      = 'concesionnaire',
			title = _U('buy_vehicle_shop', vehicleData.name, ESX.Math.GroupDigits(vehicleData.price)),
			align = 'top-right',
			elements = {
				{label = _U('no'),  value = 'no'},
				{label = _U('yes'), value = 'yes'}
			}
		}, function(data2, menu2)
			if data2.current.value == 'yes' then
				if Config.EnablePlayerManagement then
					ESX.TriggerServerCallback('cdcb3098-eae0-4b2f-9b92-a0977a11b48b', function(hasEnoughMoney)
						if hasEnoughMoney then
							IsInShopMenu = false

							DeleteShopInsideVehicles()

							local playerPed = PlayerPedId()

							CurrentAction     = 'shop_menu'
							CurrentActionMsg  = _U('shop_menu')
							CurrentActionData = {}

							FreezeEntityPosition(playerPed, false)
							SetEntityVisible(playerPed, true)
							SetEntityCoords(playerPed, Config.Zones.ShopEntering.Pos.x, Config.Zones.ShopEntering.Pos.y, Config.Zones.ShopEntering.Pos.z)

							menu2.close()
							menu.close()

							ESX.ShowNotification(_U('vehicle_purchased'))
						else
							ESX.ShowNotification(_U('broke_company'))
						end
					end, 'luxurydealer', vehicleData.model)
				else
					local playerData = ESX.GetPlayerData()

					if Config.EnableSocietyOwnedVehicles and playerData.job.grade_name == 'boss' then
						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_confirm_buy_type', {
							css      = 'concesionnaire',
							title = _U('purchase_type'),
							align = 'top-right',
							elements = {
								{label = _U('staff_type'),   value = 'personnal'},
								{label = _U('society_type'), value = 'society'}
						}}, function (data3, menu3)

							if data3.current.value == 'personnal' then

								ESX.TriggerServerCallback('2042bdf0-38cb-4b2d-b15e-57058905b6bd', function(hasEnoughMoney)
									if hasEnoughMoney then
										IsInShopMenu = false

										menu3.close()
										menu2.close()
										menu.close()
										DeleteShopInsideVehicles()

										ESX.Game.SpawnVehicleClient(vehicleData.model, Config.Zones.ShopOutside.Pos, Config.Zones.ShopOutside.Heading, function (vehicle)
											TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

											local newPlate     = GeneratePlate()
											local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
											vehicleProps.plate = newPlate
											SetVehicleNumberPlateText(vehicle, newPlate)

											if Config.EnableOwnedVehicles then
												TriggerServerEvent('a4264eb6-1a2b-404d-b000-70e0c2a213d1', vehicleProps)
											end

											ESX.ShowNotification(_U('vehicle_purchased'))
										end)

										FreezeEntityPosition(playerPed, false)
										SetEntityVisible(playerPed, true)
									else
										ESX.ShowNotification(_U('not_enough_money'))
									end
								end, vehicleData.model)

							elseif data3.current.value == 'society' then

								ESX.TriggerServerCallback('cdcb3098-eae0-4b2f-9b92-a0977a11b48b', function (hasEnoughMoney)
									if hasEnoughMoney then
										IsInShopMenu = false

										menu3.close()
										menu2.close()
										menu.close()

										DeleteShopInsideVehicles()

										ESX.Game.SpawnVehicleClient(vehicleData.model, Config.Zones.ShopOutside.Pos, Config.Zones.ShopOutside.Heading, function (vehicle)
											TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

											local newPlate     = GeneratePlate()
											local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
											vehicleProps.plate = newPlate
											SetVehicleNumberPlateText(vehicle, newPlate)
											TriggerServerEvent('f610f612-9019-484e-84fd-d921f82a11fd', playerData.job.name, vehicleProps)
											ESX.ShowNotification(_U('vehicle_purchased'))
										end)

										FreezeEntityPosition(playerPed, false)
										SetEntityVisible(playerPed, true)
									else
										ESX.ShowNotification(_U('broke_company'))
									end
								end, playerData.job.name, vehicleData.model)

							end
						end, function (data3, menu3)
							menu3.close()
						end)
					else
						ESX.TriggerServerCallback('2042bdf0-38cb-4b2d-b15e-57058905b6bd', function (hasEnoughMoney)
							if hasEnoughMoney then
								IsInShopMenu = false
								menu2.close()
								menu.close()
								DeleteShopInsideVehicles()

								ESX.Game.SpawnVehicleClient(vehicleData.model, Config.Zones.ShopOutside.Pos, Config.Zones.ShopOutside.Heading, function (vehicle)
									TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

									local newPlate     = GeneratePlate()
									local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
									vehicleProps.plate = newPlate
									SetVehicleNumberPlateText(vehicle, newPlate)

									if Config.EnableOwnedVehicles then
										TriggerServerEvent('a4264eb6-1a2b-404d-b000-70e0c2a213d1', vehicleProps)
									end

									ESX.ShowNotification(_U('vehicle_purchased'))
								end)

								FreezeEntityPosition(playerPed, false)
								SetEntityVisible(playerPed, true)
							else
								ESX.ShowNotification(_U('not_enough_money'))
							end
						end, vehicleData.model)
					end
				end
			end
		end, function (data2, menu2)
			menu2.close()
		end)
	end, function (data, menu)
		menu.close()
		DeleteShopInsideVehicles()
		local playerPed = PlayerPedId()

		CurrentAction     = 'shop_menu'
		CurrentActionMsg  = _U('shop_menu')
		CurrentActionData = {}

		FreezeEntityPosition(playerPed, false)
		SetEntityVisible(playerPed, true)
		SetEntityCoords(playerPed, Config.Zones.ShopEntering.Pos.x, Config.Zones.ShopEntering.Pos.y, Config.Zones.ShopEntering.Pos.z)

		IsInShopMenu = false
	end, function (data, menu)
		local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]
		local playerPed   = PlayerPedId()

		DeleteShopInsideVehicles()
		WaitForVehicleToLoad(vehicleData.model)

		ESX.Game.SpawnLocalVehicle(vehicleData.model, Config.Zones.ShopInside.Pos, Config.Zones.ShopInside.Heading, function (vehicle)
			table.insert(LastVehicles, vehicle)
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			FreezeEntityPosition(vehicle, true)
			SetModelAsNoLongerNeeded(vehicleData.model)
		end)
	end)

	DeleteShopInsideVehicles()
	WaitForVehicleToLoad(firstVehicleData.model)

	ESX.Game.SpawnLocalVehicle(firstVehicleData.model, Config.Zones.ShopInside.Pos, Config.Zones.ShopInside.Heading, function (vehicle)
		table.insert(LastVehicles, vehicle)
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		FreezeEntityPosition(vehicle, true)
		SetModelAsNoLongerNeeded(firstVehicleData.model)
	end)

end

function WaitForVehicleToLoad(modelHash)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)

		BeginTextCommandBusyString('STRING')
		AddTextComponentSubstringPlayerName(_U('shop_awaiting_model'))
		EndTextCommandBusyString(4)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(1)
			DisableAllControlActions(0)
		end

		RemoveLoadingPrompt()
	end
end

function OpenResellerMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'reseller', {
		css      = 'concesionnaire',
		title    = _U('car_dealer'),
		align    = 'top-right',
		elements = {
			{label = _U('buy_vehicle'),                    value = 'buy_vehicle'},
			{label = _U('pop_vehicle'),                    value = 'pop_vehicle'},
			{label = _U('depop_vehicle'),                  value = 'depop_vehicle'},
			{label = _U('return_provider'),                value = 'return_provider'},
			{label = _U('create_bill'),                    value = 'create_bill'},
			{label = '📣 Open Ad',                    value = 'concess_ouvert'},
			{label = '📢 Closed Ad',                    value = 'concess_ferme'},
			{label = _U('get_rented_vehicles'),            value = 'get_rented_vehicles'},
			{label = _U('set_vehicle_owner_sell'),         value = 'set_vehicle_owner_sell'},
			{label = _U('set_vehicle_owner_rent'),         value = 'set_vehicle_owner_rent'},
			{label = _U('set_vehicle_owner_sell_society'), value = 'set_vehicle_owner_sell_society'},
			{label = _U('deposit_stock'),                  value = 'put_stock'},
			{label = _U('take_stock'),                     value = 'get_stock'}
		}
	}, function (data, menu)
		local action = data.current.value

		if action == 'buy_vehicle' then
			OpenShopMenu()
		elseif action == 'put_stock' then
			OpenPutStocksMenu()
		elseif action == 'get_stock' then
			OpenGetStocksMenu()
		elseif action == 'pop_vehicle' then
			OpenPopVehicleMenu()
		elseif action == 'depop_vehicle' then
			DeleteShopInsideVehicles()
		elseif action == 'return_provider' then
			ReturnVehicleProvider()
		elseif action == 'create_bill' then

			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
			if closestPlayer == -1 or closestDistance > 3.0 then
				ESX.ShowNotification(_U('no_players'))
				return
			end

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'set_vehicle_owner_sell_amount', {
				css      = 'concesionnaire',
				title = _U('invoice_amount')
			}, function (data2, menu2)
				local amount = tonumber(data2.value)

				if amount == nil then
					ESX.ShowNotification(_U('invalid_amount'))
				else
					menu2.close()
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

					if closestPlayer == -1 or closestDistance > 3.0 then
						ESX.ShowNotification(_U('no_players'))
					else
						TriggerServerEvent('c9ac0436-8b83-467d-abe5-4978cdf78f9b', GetPlayerServerId(closestPlayer), 'society_luxurydealer', _U('car_dealer'), tonumber(data2.value))
					end
				end
			end, function (data2, menu2)
				menu2.close()
			end)

		elseif action == 'get_rented_vehicles' then
			OpenRentedVehiclesMenu()
		elseif action == 'concess_ouvert' then
			TriggerServerEvent('caeb838d-2b26-4c5c-9d3c-380c62d222f8')
			ESX.UI.Menu.CloseAll()
		elseif action == 'concess_ferme' then
			TriggerServerEvent('1110f040-7dfc-44bb-b638-47922f7214a2')
			ESX.UI.Menu.CloseAll()
		elseif action == 'set_vehicle_owner_sell' then

			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

			if closestPlayer == -1 or closestDistance > 3.0 then
				ESX.ShowNotification(_U('no_players'))
			else
				local newPlate     = GeneratePlate()
				local vehicleProps = ESX.Game.GetVehicleProperties(LastVehicles[#LastVehicles])
				local model        = CurrentVehicleData.model
				if tonumber(vehicleProps.model) ~= 0 then
					vehicleProps.plate = newPlate
					SetVehicleNumberPlateText(LastVehicles[#LastVehicles], newPlate)

					TriggerServerEvent('da468a85-124e-498a-940c-1a58c7ee25e7', model)
					TriggerServerEvent('57987d43-7388-4ab1-99bb-ecfab6639c54', GetPlayerServerId(closestPlayer), model, newPlate)

					if Config.EnableOwnedVehicles then
						TriggerServerEvent('af5dbbb7-80fa-46ab-8c39-8cfc0cbf6cda', GetPlayerServerId(closestPlayer), vehicleProps)
						ESX.ShowNotification(_U('vehicle_set_owned', vehicleProps.plate, GetPlayerName(closestPlayer)))
					else
						ESX.ShowNotification(_U('vehicle_sold_to', vehicleProps.plate, GetPlayerName(closestPlayer)))
					end
					ESX.UI.Menu.CloseAll()
				else
					ESX.ShowNotification('~o~Vehicle did not assign correctly, model returned 0. ~w~Please try repositioning and re-attempt.')
				end
			end

		elseif action == 'set_vehicle_owner_sell_society' then

			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

			if closestPlayer == -1 or closestDistance > 3.0 then
				ESX.ShowNotification(_U('no_players'))
			else
				ESX.TriggerServerCallback('51d8bbd2-80ed-4c38-9e84-321449b2847c', function (xPlayer)

					local newPlate     = GeneratePlate()
					local vehicleProps = ESX.Game.GetVehicleProperties(LastVehicles[#LastVehicles])
					local model        = CurrentVehicleData.model
					vehicleProps.plate = newPlate
					SetVehicleNumberPlateText(LastVehicles[#LastVehicles], newPlate)
					TriggerServerEvent('da468a85-124e-498a-940c-1a58c7ee25e7', model)
					TriggerServerEvent('57987d43-7388-4ab1-99bb-ecfab6639c54', GetPlayerServerId(closestPlayer), model, newPlate)

					if Config.EnableSocietyOwnedVehicles then
						TriggerServerEvent('f610f612-9019-484e-84fd-d921f82a11fd', xPlayer.job.name, vehicleProps)
						ESX.ShowNotification(_U('vehicle_set_owned', vehicleProps.plate, GetPlayerName(closestPlayer)))
					else
						ESX.ShowNotification(_U('vehicle_sold_to', vehicleProps.plate, GetPlayerName(closestPlayer)))
					end
					menu2.close()

				end, GetPlayerServerId(closestPlayer))
			end

		elseif action == 'set_vehicle_owner_rent' then

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'set_vehicle_owner_rent_amount', {
				css      = 'concesionnaire',
				title = _U('rental_amount')
			}, function (data2, menu2)
				local amount = tonumber(data2.value)

				if amount == nil then
					ESX.ShowNotification(_U('invalid_amount'))
				else
					menu2.close()

					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

					if closestPlayer == -1 or closestDistance > 5.0 then
						ESX.ShowNotification(_U('no_players'))
					else
						local newPlate     = 'RENT' .. string.upper(ESX.GetRandomString(4))
						local vehicleProps = ESX.Game.GetVehicleProperties(LastVehicles[#LastVehicles])
						local model        = CurrentVehicleData.model
						vehicleProps.plate = newPlate
						SetVehicleNumberPlateText(LastVehicles[#LastVehicles], newPlate)
						TriggerServerEvent('91592613-bc82-452d-9ef6-fd4c55d07e09', model, vehicleProps.plate, GetPlayerName(closestPlayer), CurrentVehicleData.price, amount, GetPlayerServerId(closestPlayer))

						if Config.EnableOwnedVehicles then
							TriggerServerEvent('af5dbbb7-80fa-46ab-8c39-8cfc0cbf6cda', GetPlayerServerId(closestPlayer), vehicleProps)
						end

						ESX.ShowNotification(_U('vehicle_set_rented', vehicleProps.plate, GetPlayerName(closestPlayer)))
						TriggerServerEvent('blue_vehicleshop:setVehicleForAllPlayers', vehicleProps, Config.Zones.ShopInside.Pos.x, Config.Zones.ShopInside.Pos.y, Config.Zones.ShopInside.Pos.z, 5.0)
					end
				end
			end, function (data2, menu2)
				menu2.close()
			end)
		end
	end, function (data, menu)
		menu.close()

		CurrentAction     = 'reseller_menu'
		CurrentActionMsg  = _U('shop_menu')
		CurrentActionData = {}
	end)
end

function OpenPopVehicleMenu()
	ESX.TriggerServerCallback('1ce715a8-e87f-463b-a3e4-b457cdce1316', function (vehicles)
		local elements = {}

		for i=1, #vehicles, 1 do
			table.insert(elements, {
				label = ('%s [MSRP <span style="color:green;">%s</span>]'):format(vehicles[i].name, _U('generic_shopitem', ESX.Math.GroupDigits(vehicles[i].price))),
				value = vehicles[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'commercial_vehicles', {
			css      = 'concesionnaire',
			title    = _U('vehicle_dealer'),
			align    = 'top-right',
			elements = elements
		}, function (data, menu)
			local model = data.current.value

			DeleteShopInsideVehicles()

			ESX.Game.SpawnVehicleClient(model, Config.Zones.ShopInside.Pos, Config.Zones.ShopInside.Heading, function (vehicle)
				table.insert(LastVehicles, vehicle)

				for i=1, #Vehicles, 1 do
					if model == Vehicles[i].model then
						CurrentVehicleData = Vehicles[i]
						break
					end
				end
			end)
		end, function (data, menu)
			menu.close()
		end)
	end)
end

function OpenRentedVehiclesMenu()
	ESX.TriggerServerCallback('727470e0-2e16-4afa-90fe-fd1fdd2bde9a', function (vehicles)
		local elements = {}

		for i=1, #vehicles, 1 do
			table.insert(elements, {
				label = ('%s: %s - <span style="color:orange;">%s</span>'):format(vehicles[i].playerName, vehicles[i].name, vehicles[i].plate),
				value = vehicles[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'rented_vehicles', {
			css      = 'concesionnaire',
			title    = _U('rent_vehicle'),
			align    = 'top-right',
			elements = elements
		}, nil, function (data, menu)
			menu.close()
		end)
	end)
end

function OpenBossActionsMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'reseller',{
		css      = 'concesionnaire',
		title    = _U('dealer_boss'),
		align    = 'top-right',
		elements = {
			{label = _U('boss_actions'), value = 'boss_actions'},
			{label = _U('boss_sold'), value = 'sold_vehicles'}
	}}, function (data, menu)
		if data.current.value == 'boss_actions' then
			TriggerEvent('9878e951-0ff0-4996-be7e-f0eb7c427247', 'luxurydealer', function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'sold_vehicles' then

			ESX.TriggerServerCallback('0dd316db-6895-4775-9559-9a0c54bb2827', function(customers)
				local elements = {
					head = { _U('customer_client'), _U('customer_model'), _U('customer_plate'), _U('customer_soldby'), _U('customer_date') },
					rows = {}
				}


				for i=1, #customers, 1 do
					table.insert(elements.rows, {
						data = customers[i],
						cols = {
							customers[i].cname,
							customers[i].model,
							customers[i].plate,
							customers[i].sname,
							customers[i].date
						}
					})
				end

				ESX.UI.Menu.Open('list', GetCurrentResourceName(), 'sold_vehicles', elements, function(data2, menu2)

				end, function(data2, menu2)
					menu2.close()
				end)
			end)
		end

	end, function (data, menu)
		menu.close()

		CurrentAction     = 'boss_actions_menu'
		CurrentActionMsg  = _U('shop_menu')
		CurrentActionData = {}
	end)
end

function OpenGetStocksMenu()
	ESX.TriggerServerCallback('a700c56e-4647-4508-a881-446f9e50be39', function (items)
		local elements = {}

		for i=1, #items, 1 do
			table.insert(elements, {
				label = 'x' .. items[i].count .. ' ' .. items[i].label,
				value = items[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			css      = 'concesionnaire',
			title    = _U('dealership_stock'),
			align    = 'top-right',
			elements = elements
		}, function (data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
				css      = 'concesionnaire',
				title = _U('amount')
			}, function (data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('quantity_invalid'))
				else
					TriggerServerEvent('a6ceca85-9852-4e8e-8e0e-3cbb44bf7e5d', itemName, count)
					menu2.close()
					menu.close()
					OpenGetStocksMenu()
				end
			end, function (data2, menu2)
				menu2.close()
			end)

		end, function (data, menu)
			menu.close()
		end)
	end)
end

function OpenPutStocksMenu()
	ESX.TriggerServerCallback('f755b777-aba7-4e92-ba07-e30092013fc4', function (inventory)
		local elements = {}

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

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			css      = 'concesionnaire',
			title    = _U('inventory'),
			align    = 'top-right',
			elements = elements
		}, function (data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
				css      = 'concesionnaire',
				title = _U('amount')
			}, function (data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('quantity_invalid'))
				else
					TriggerServerEvent('43d2221b-d932-47f7-9347-a563df344c01', itemName, count)
					menu2.close()
					menu.close()
					OpenPutStocksMenu()
				end
			end, function (data2, menu2)
				menu2.close()
			end)
		end, function (data, menu)
			menu.close()
		end)
	end)
end

RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function (job)
	ESX.PlayerData.job = job

	if Config.EnablePlayerManagement then
		if ESX.PlayerData.job.name == 'luxurydealer' then
			Config.Zones.ShopEntering.Type = 1

			if ESX.PlayerData.job.grade_name == 'boss' then
				Config.Zones.BossActions.Type = 1
			end
		else
			Config.Zones.ShopEntering.Type = -1
			Config.Zones.BossActions.Type  = -1
		end
	end
end)

AddEventHandler('18a7174c-e761-4d0b-af2b-dcce5abad458', function (zone)
	if zone == 'ShopEntering' then

		if Config.EnablePlayerManagement then
			if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'luxurydealer' then
				CurrentAction     = 'reseller_menu'
				CurrentActionMsg  = _U('shop_menu')
				CurrentActionData = {}
			end
		else
			CurrentAction     = 'shop_menu'
			CurrentActionMsg  = _U('shop_menu')
			CurrentActionData = {}
		end

	elseif zone == 'GiveBackVehicle' and Config.EnablePlayerManagement then

		local playerPed = PlayerPedId()

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed, false)

			CurrentAction     = 'give_back_vehicle'
			CurrentActionMsg  = _U('vehicle_menu')
			CurrentActionData = {vehicle = vehicle}
		end

	elseif zone == 'ResellVehicle' then

		local playerPed = PlayerPedId()

		if IsPedSittingInAnyVehicle(playerPed) then

			local vehicle     = GetVehiclePedIsIn(playerPed, false)
			local vehicleData, model, resellPrice, plate

			if GetPedInVehicleSeat(vehicle, -1) == playerPed then
				for i=1, #Vehicles, 1 do
					if GetHashKey(Vehicles[i].model) == GetEntityModel(vehicle) then
						vehicleData = Vehicles[i]
						break
					end
				end

				resellPrice = ESX.Math.Round(vehicleData.price / 100 * Config.ResellPercentage)
				model = GetEntityModel(vehicle)
				plate = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle))

				CurrentAction     = 'resell_vehicle'
				CurrentActionMsg  = _U('sell_menu', vehicleData.name, ESX.Math.GroupDigits(resellPrice))

				CurrentActionData = {
					vehicle = vehicle,
					label = vehicleData.name,
					price = resellPrice,
					model = model,
					plate = plate
				}
			end

		end

	elseif zone == 'BossActions' and Config.EnablePlayerManagement and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'luxurydealer' and ESX.PlayerData.job.grade_name == 'boss' then

		CurrentAction     = 'boss_actions_menu'
		CurrentActionMsg  = _U('shop_menu')
		CurrentActionData = {}

	end
end)

AddEventHandler('18a7174c-e761-4d0b-af2b-dcce5abad458', function (zone)
  if zone == 'ShopEntering' then
    if Config.EnablePlayerManagement then
      if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'luxurydealer' then
        CurrentAction     = 'reseller_menu'
        CurrentActionMsg  = _U('shop_menu')
        CurrentActionData = {}
      end
	  
	  
    else
      CurrentAction     = 'shop_menu'
      CurrentActionMsg  = _U('shop_menu')
      CurrentActionData = {}
    end
  end
  
  
    if zone == 'ShopBrowsing' then
      CurrentAction     = 'shop_browsing'
      CurrentActionMsg  = 'Browse the Car Catalogue'
      CurrentActionData = {}
	end

  if zone == 'GiveBackVehicle' and Config.EnablePlayerManagement then
    local playerPed = PlayerPedId()

    if IsPedInAnyVehicle(playerPed, false) then
      local vehicle = GetVehiclePedIsIn(playerPed, false)

      CurrentAction     = 'give_back_vehicle'
      CurrentActionMsg  = _U('vehicle_menu')

      CurrentActionData = {
        vehicle = vehicle
      }
    end
  end

  if zone == 'ResellVehicle' then
    local playerPed = PlayerPedId()

    if IsPedInAnyVehicle(playerPed, false) then
      local vehicle     = GetVehiclePedIsIn(playerPed, false)
      local vehicleData = nil

      for i=1, #Vehicles, 1 do
        if GetHashKey(Vehicles[i].model) == GetEntityModel(vehicle) then
          vehicleData = Vehicles[i]
          break
        end
      end

      local resellPrice = math.floor(vehicleData.price / 100 * Config.ResellPercentage)

      CurrentAction     = 'resell_vehicle'
      CurrentActionMsg  = _U('sell_menu', vehicleData.name, resellPrice)

      CurrentActionData = {
        vehicle = vehicle,
        price   = resellPrice
      }
    end
  end

  if zone == 'BossActions' and Config.EnablePlayerManagement and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'luxurydealer' and ESX.PlayerData.job.grade_name == 'boss' then
    CurrentAction     = 'boss_actions_menu'
    CurrentActionMsg  = _U('shop_menu')
    CurrentActionData = {}
  end
end)

AddEventHandler('2e1b8618-768e-495b-b5e0-7f234ecfcca4', function (zone)
	if not IsInShopMenu then
		ESX.UI.Menu.CloseAll()
	end

	CurrentAction = nil
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if IsInShopMenu then
			ESX.UI.Menu.CloseAll()

			DeleteShopInsideVehicles()
			local playerPed = PlayerPedId()

			FreezeEntityPosition(playerPed, false)
			SetEntityVisible(playerPed, true)
			SetEntityCoords(playerPed, Config.Zones.ShopEntering.Pos.x, Config.Zones.ShopEntering.Pos.y, Config.Zones.ShopEntering.Pos.z)
		end
	end
end)

if Config.EnablePlayerManagement then
	RegisterNetEvent('59809f17-d8ce-49dd-ae30-d5e90a7761a7')
	AddEventHandler('59809f17-d8ce-49dd-ae30-d5e90a7761a7', function (phoneNumber, contacts)
		local specialContact = {
			name       = _U('dealership'),
			number     = 'luxurydealer',
			base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAQAAAAEACAMAAABrrFhUAAAAAXNSR0IArs4c6QAAAARnQU1BAACxjwv8YQUAAAMAUExURQAAADMzMzszM0M0M0w0M1Q1M101M2U2M242M3Y3M383Moc4MpA4Mpg5MqE5Mqk6MrI6Mro7Mrw8Mr89M71DML5EO8I+NMU/NcBMLshANctBNs5CN8RULMddKsheKs9YLtBCONZEOdlFOtxGO99HPNhMNsplKM1nKM1uJtRhLddiLt5kMNJwJ9B2JNR/IeNIPeVJPehKPuRQOuhSO+lZOOlhNuloM+p3Lep/KupwMMFORsVYUcplXc1waNJ7delUSepgVexrYe12bdeHH9iIH9qQHd2YG+udH+OEJeuGJ+uOJeuVIuChGeSpF+aqGOykHOysGeeyFeuzFuyzFuq6E+27FO+Cee3CEdaGgdqTjvCNhfKYkvOkngAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAJezdycAAAEAdFJOU////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////wBT9wclAAAACXBIWXMAAA7DAAAOwwHHb6hkAAAAGHRFWHRTb2Z0d2FyZQBwYWludC5uZXQgNC4xLjb9TgnoAAAQGElEQVR4Xt2d+WMUtxXHbS6bEGMPMcQQ04aEUnqYo9xJWvC6kAKmQLM2rdn//9+g0uir2Tl0PElPszP7+cnH7Fj6rPTeG2lmvfKld2azk8lk/36L/cnkZDbDIT3Sp4DZ8QS9dTI57tNDTwJOOu+4j/0TvDQz+QXMSG+7mUn+sZBZQELnNROcKhMZBXx+gS4k8+IzTpmBXAJOnqPxTDzPFRKyCODuvSKPgwwC2EZ+lxf4E4xwCzhBU7PBPQx4BWR88+fwDgNGAbMsM9/Ec8bygE3A5966L3nOlhiZBGSf+l2YggGLgBna1DMsE4FBQH9zvw1HLEgX0Evkt5GeEVIFMFztpJF6rZQm4DNasVDSEkKSgIVN/ibP0ZwoEgQsfPTPSZgH8QIG8vYr4gdBrIABvf2K2EEQKWBQb78ichBECRhE8O8SlQ5iBAQvcffFPhoYQoSAAQ5/TcQ0CBYw0OGvCZ4GoQIGF/3bhGaDQAELvfKhERgIwgQMePrPCQsEQQLwFwYPmksiQMCC1n1iCFgooQtYwLJfPPQFQ7KAUfU/wABVwMj6TzdAFDDY6tcOMR3SBIyw/1QDJAGj7D/RAEXA6Oa/hhIHCAJG23+SAb+AEfefYsArYET1nwlvTegVgBONFnTDik8ATjNi0BEbHgGjuP5147k6dgsYaQHQxF0OOAUMfv2LhnOVzCVg4OufdFwrpS4BePkSgA6ZcAhYggCocQRCu4ClCIAaeyC0CliaAKCwhgGrALxwaUC3OtgELFEAUNjCgEXAklQAdSzVgEUAXrRUoGstzAKWbgJIzJPAKGAJJ4DEOAmMAvCCpQPda2ASsJQTQGKa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',
		}

		TriggerEvent('e25977c9-9f2b-4d5d-a807-a8c7a0c964d5', specialContact.name, specialContact.number, specialContact.base64Icon)
	end)
end

-- Create Blips
Citizen.CreateThread(function()
	Wait(4500)
	local blip = AddBlipForCoord(Config.Zones.ShopEntering.Pos.x, Config.Zones.ShopEntering.Pos.y, Config.Zones.ShopEntering.Pos.z)

	SetBlipSprite (blip, 326)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.0)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(_U('car_dealer'))
	EndTextCommandSetBlipName(blip)
end)

-- Display markers
Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
		local closerc = false
		local coords = GetEntityCoords(PlayerPedId())

		for k,v in pairs(Config.Zones) do
			if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
				closerc = true
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			end
		end
		if closerc == false then
			closer = false
			Wait(2000)
		else
		
			closer = true
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)

		if closer then
			local coords      = GetEntityCoords(PlayerPedId())
			local isInMarker  = false
			local currentZone = nil
			
			
			
			for k,v in pairs(Config.Zones) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker  = true
					currentZone = k
				end
				Wait(100)
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone                = currentZone
				TriggerEvent('18a7174c-e761-4d0b-af2b-dcce5abad458', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('2e1b8618-768e-495b-b5e0-7f234ecfcca4', LastZone)
			end
		
		else
			Wait(2500)
		end
	end
end)

-- Key controls
Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(10)

		if closer then
			if CurrentAction == nil then
				Citizen.Wait(200)
			else

				ESX.ShowHelpNotification(CurrentActionMsg)

				if IsControlJustReleased(0, Keys['E']) then
					if CurrentAction == 'shop_menu' then
						OpenShopMenu()
					elseif CurrentAction == 'reseller_menu' then
						OpenResellerMenu()
					elseif CurrentAction == "shop_browsing" then
						OpenBrowseMenu()
					elseif CurrentAction == 'give_back_vehicle' then
						ESX.TriggerServerCallback('9080da77-b50c-45b6-b902-50a9266fe5f0', function (isRentedVehicle)
							if isRentedVehicle then
								ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
								ESX.ShowNotification(_U('delivered'))
							else
								ESX.ShowNotification(_U('not_rental'))
							end
						end, GetVehicleNumberPlateText(CurrentActionData.vehicle))
					elseif CurrentAction == 'resell_vehicle' then
							print('entity model')
							print(GetEntityModel(CurrentActionData.vehicle))
						ESX.TriggerServerCallback('910f28c7-10bd-4a0d-b068-0d940f60e20d', function (isOwnedVehicle)
							if isOwnedVehicle then
								soldcount = soldcount + 1
								ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
								ESX.ShowNotification(_U('vehicle_sold'))
							else
								ESX.ShowNotification(_U('not_yours'))
							end
							print('entity model')
							print(GetEntityModel(CurrentActionData.vehicle))
						end, GetVehicleNumberPlateText(CurrentActionData.vehicle), CurrentActionData.price, GetEntityModel(CurrentActionData.vehicle))
					elseif CurrentAction == 'boss_actions_menu' then
						OpenBossActionsMenu()
					end

					CurrentAction = nil
				end
			end
		else
			Wait(2500)
		end
	end
end)

Citizen.CreateThread(function()
	RequestIpl('shr_int') -- Load walls and floor

	local interiorID = 7170
	LoadInterior(interiorID)
	EnableInteriorProp(interiorID, 'csr_beforeMission') -- Load large window
	RefreshInterior(interiorID)
end)

function cGetVehicleColours(cvehicle)
	if GetIsVehiclePrimaryColourCustom(cvehicle) then  
		return "Custom","Custom"
	elseif GetIsVehicleSecondaryColourCustom(cvehicle) then
		local primary, secondary = cGetVehicleColours(cvehicle)
		primary = colorNames[tostring(primary)]
		--Citizen.Trace('Primary Color Reg: ' .. primary)
		return primary, "Custom"
		
	else
	
		local primary, secondary = GetVehicleColours(cvehicle)
		if primary == nil then
			primary = "unknown"
			secondary = "unknown"
		elseif secondary == nil then
			primary = colorNames[tostring(primary)]
			secondary = nil
		else
			primary = colorNames[tostring(primary)]
			secondary = colorNames[tostring(secondary)]
		end
		--Citizen.Trace('Primary Color Reg: ' .. primary)
		return primary, secondary
	end

end


function OpenBrowseMenu()
  IsInShopMenu = true

  ESX.UI.Menu.CloseAll()

  local playerPed = PlayerPedId()

  FreezeEntityPosition(playerPed, true)
  SetEntityVisible(playerPed, false)
  SetEntityCoords(playerPed, Config.Zones.ShopBrowsingInside.Pos.x, Config.Zones.ShopBrowsingInside.Pos.y, Config.Zones.ShopBrowsingInside.Pos.z)

  local vehiclesByCategory = {}
  local elements           = {}
  local firstVehicleData   = nil

  for i=1, #Categories, 1 do
    vehiclesByCategory[Categories[i].name] = {}
  end

  for i=1, #Vehicles, 1 do
    table.insert(vehiclesByCategory[Vehicles[i].category], Vehicles[i])
  end

  for i=1, #Categories, 1 do
    local category         = Categories[i]
    local categoryVehicles = vehiclesByCategory[category.name]
    local options          = {}

    for j=1, #categoryVehicles, 1 do
      local vehicle = categoryVehicles[j]

      if i == 1 and j == 1 then
        firstVehicleData = vehicle
      end
	  
	  local vehprice =  vehicle.price
	  if readonly then
		vehprice = ''
	  end
	  

      table.insert(options, vehicle.name .. ' <span style="color: green;"> SALE ON NOW! </span>')
    end
	
	print('running')

    table.insert(elements, {
      name    = category.name,
      label   = category.label,
      value   = 0,
      type    = 'slider',
      max     = #Categories[i],
      options = options
    })
  end

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'vehicle_shop',
    {
      title    = _U('car_dealer'),
      align    = 'top-right',
      elements = elements
    },
    function (data, menu)
      local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]

    

    end,
    function (data, menu)

      menu.close()

      DeleteShopInsideVehicles()

      local playerPed = PlayerPedId()

      CurrentAction     = 'shop_browsing'
      CurrentActionMsg  = _U('shop_menu')
      CurrentActionData = {}

      FreezeEntityPosition(playerPed, false)
      SetEntityVisible(playerPed, true)
      SetEntityCoords(playerPed, Config.Zones.ShopBrowsingInside.Pos.x, Config.Zones.ShopBrowsingInside.Pos.y, Config.Zones.ShopBrowsingInside.Pos.z)

      IsInShopMenu = false

    end,
    function (data, menu)
      local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]
      local playerPed   = PlayerPedId()
	Citizen.Trace('Bull1')
      DeleteShopInsideVehicles()

      ESX.Game.SpawnLocalVehicle(vehicleData.model, Config.Zones.ShopBrowsingInside.Pos, Config.Zones.ShopBrowsingInside.Heading, function (vehicle)
        table.insert(LastVehicles, vehicle)
		SetVehicleNumberPlateText(vehicle,"CARDEALR")
        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
        FreezeEntityPosition(vehicle, true)
      end)
    end
  )

  DeleteShopInsideVehicles()
	Citizen.Trace('Bull2')
  ESX.Game.SpawnLocalVehicle(firstVehicleData.model, Config.Zones.ShopBrowsingInside.Pos, Config.Zones.ShopBrowsingInside.Heading, function (vehicle)
    table.insert(LastVehicles, vehicle)
	SetVehicleNumberPlateText(vehicle,"CARDEALR")
    TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
    FreezeEntityPosition(vehicle, true)
  end)

end