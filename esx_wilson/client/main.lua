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

local PlayerData = {}
local HasAlreadyEnteredMarker = false
local LastStation, LastPart, LastPartNum, LastEntity
local CurrentAction = nil
local CurrentActionMsg  = ''
local CurrentActionData = {}
local IsHandcuffed = false
local HandcuffTimer = {}
local DragStatus = {}
DragStatus.IsDragged = false
local hasAlreadyJoined = false
local blipsCops = {}
local isDead = false
local CurrentTask = {}
local playerInService = false
local spawnedVehicles, isInShopMenu = {}, false

ESX                           = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
end)

function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end

function setUniform(job, playerPed)
	TriggerEvent('d3bdbe20-bf7d-4df2-9ef6-9026a86a6e87', function(skin)
		if skin.sex == 0 then
			if Config.Uniforms[job].male ~= nil then
				TriggerEvent('1d09cf94-2c53-4220-a089-0339ce8bb123', skin, Config.Uniforms[job].male)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end

			if job == 'bullet_wear' then
				SetPedArmour(playerPed, 100)
			end
		else
			if Config.Uniforms[job].female ~= nil then
				TriggerEvent('1d09cf94-2c53-4220-a089-0339ce8bb123', skin, Config.Uniforms[job].female)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end

			if job == 'bullet_wear' then
				SetPedArmour(playerPed, 100)
			end
		end
	end)
end

function OpenCloakroomMenu()

	local playerPed = PlayerPedId()
	local grade = PlayerData.job.grade_name

	local elements = {
		{ label = _U('citizen_wear'), value = 'citizen_wear' },
		{ label = _U('bullet_wear'), value = 'bullet_wear' },
		{ label = _U('gilet_wear'), value = 'gilet_wear' }
	}

	if grade == 'recruit' then
		table.insert(elements, {label = _U('police_wear'), value = 'recruit_wear'})
	elseif grade == 'officer' then
		table.insert(elements, {label = _U('police_wear'), value = 'officer_wear'})
	elseif grade == 'sergeant' then
		table.insert(elements, {label = _U('police_wear'), value = 'sergeant_wear'})
	elseif grade == 'intendent' then
		table.insert(elements, {label = _U('police_wear'), value = 'intendent_wear'})
	elseif grade == 'lieutenant' then
		table.insert(elements, {label = _U('police_wear'), value = 'lieutenant_wear'})
	elseif grade == 'chef' then
		table.insert(elements, {label = _U('police_wear'), value = 'chef_wear'})
	elseif grade == 'boss' then
		table.insert(elements, {label = _U('police_wear'), value = 'boss_wear'})
	end

	if Config.EnableNonFreemodePeds then
		table.insert(elements, {label = 'Sheriff wear', value = 'freemode_ped', maleModel = 's_m_y_sheriff_01', femaleModel = 's_f_y_sheriff_01'})
		table.insert(elements, {label = 'Police wear', value = 'freemode_ped', maleModel = 's_m_y_cop_01', femaleModel = 's_f_y_cop_01'})
		table.insert(elements, {label = 'Swat wear', value = 'freemode_ped', maleModel = 's_m_y_swat_01', femaleModel = 's_m_y_swat_01'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom',
	{
		title    = _U('cloakroom'),
		align    = 'top-right',
		elements = elements
	}, function(data, menu)

		cleanPlayer(playerPed)

		if data.current.value == 'citizen_wear' then
			
			if Config.EnableNonFreemodePeds then
				ESX.TriggerServerCallback('4568d939-3661-4833-ae6a-378432ac6ff1', function(skin, jobSkin)
					local isMale = skin.sex == 0

					TriggerEvent('77e258c7-d610-4a49-892b-17aabf7a3aca', isMale, function()
						ESX.TriggerServerCallback('4568d939-3661-4833-ae6a-378432ac6ff1', function(skin)
							TriggerEvent('56a2ee13-8a49-4ad3-a298-1854493c98ee', skin)
							TriggerEvent('76822202-72be-4e7c-84ee-1530c7df06b7')
						end)
					end)

				end)
			else
				ESX.TriggerServerCallback('4568d939-3661-4833-ae6a-378432ac6ff1', function(skin)
					TriggerEvent('56a2ee13-8a49-4ad3-a298-1854493c98ee', skin)
				end)
			end

			if Config.MaxInService ~= -1 then

				ESX.TriggerServerCallback('d5417c6c-8f4f-42f5-bdb7-b94a92cca4bc', function(isInService)
					if isInService then

						playerInService = false

						local notification = {
							title    = _U('service_anonunce'),
							subject  = '',
							msg      = _U('service_out_announce', GetPlayerName(PlayerId())),
							iconType = 1
						}

						TriggerServerEvent('5d7a516a-2d9c-4489-80dc-65368e4a09bf', notification, 'police')

						TriggerServerEvent('a91f16e6-8b39-4118-b7d3-68f32f337985', 'police')
						--TriggerEvent('14b6d3ed-7d85-4cde-abe7-b0936919371f')
						ESX.ShowNotification(_U('service_out'))
					end
				end, 'police')
			end

		end

		if Config.MaxInService ~= -1 and data.current.value ~= 'citizen_wear' then
			local serviceOk = 'waiting'

			ESX.TriggerServerCallback('d5417c6c-8f4f-42f5-bdb7-b94a92cca4bc', function(isInService)
				if not isInService then

					ESX.TriggerServerCallback('5ec18406-b92f-414f-8d90-64a53778ed0d', function(canTakeService, maxInService, inServiceCount)
						if not canTakeService then
							ESX.ShowNotification(_U('service_max', inServiceCount, maxInService))
						else

							serviceOk = true
							playerInService = true

							local notification = {
								title    = _U('service_anonunce'),
								subject  = '',
								msg      = _U('service_in_announce', GetPlayerName(PlayerId())),
								iconType = 1
							}
	
							TriggerServerEvent('5d7a516a-2d9c-4489-80dc-65368e4a09bf', notification, 'police')
							--TriggerEvent('14b6d3ed-7d85-4cde-abe7-b0936919371f')
							ESX.ShowNotification(_U('service_in'))
						end
					end, 'police')

				else
					serviceOk = true
				end
			end, 'police')

			while type(serviceOk) == 'string' do
				Citizen.Wait(5)
			end

			-- if we couldn't enter service don't let the player get changed
			if not serviceOk then
				return
			end
		end

		--LG
		if data.current.value == 'bullet_wear' then
			SetPlayerMaxArmour(GetPlayerPed(-1),100)
			SetPedArmour(GetPlayerPed(-1),100)
		end
		if
			data.current.value == 'recruit_wear' or
			data.current.value == 'officer_wear' or
			data.current.value == 'sergeant_wear' or
			data.current.value == 'intendent_wear' or
			data.current.value == 'lieutenant_wear' or
			data.current.value == 'chef_wear' or
			data.current.value == 'boss_wear' or
			data.current.value == 'bullet_wear' or
			data.current.value == 'gilet_wear'
		then
			setUniform(data.current.value, playerPed)
		end

		if data.current.value == 'freemode_ped' then
			local modelHash = ''

			ESX.TriggerServerCallback('4568d939-3661-4833-ae6a-378432ac6ff1', function(skin, jobSkin)
				if skin.sex == 0 then
					modelHash = GetHashKey(data.current.maleModel)
				else
					modelHash = GetHashKey(data.current.femaleModel)
				end

				ESX.Streaming.RequestModel(modelHash, function()
					SetPlayerModel(PlayerId(), modelHash)
					SetModelAsNoLongerNeeded(modelHash)

					TriggerEvent('76822202-72be-4e7c-84ee-1530c7df06b7')
				end)
			end)

		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = _U('open_cloackroom')
		CurrentActionData = {}
	end)
end

function OpenArmoryMenu(station)
	local elements = {
		{label = _U('buy_weapons'), value = 'buy_weapons'}
	}

	if Config.EnableArmoryManagement then
		table.insert(elements, {label = _U('get_weapon'),     value = 'get_weapon'})
		--table.insert(elements, {label = _U('put_weapon'),     value = 'put_weapon'})
		--table.insert(elements, {label = _U('remove_object'),  value = 'get_stock'})
		table.insert(elements, {label = 'Destroy Items', value = 'put_stock'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory',
	{
		title    = _U('armory'),
		align    = 'top-right',
		elements = elements
	}, function(data, menu)

		if data.current.value == 'get_weapon' then
			OpenGetWeaponMenu()
		elseif data.current.value == 'put_weapon' then
			--OpenPutWeaponMenu()
		elseif data.current.value == 'buy_weapons' then
			OpenBuyWeaponsMenu()
		elseif data.current.value == 'put_stock' then
			OpenPutStocksMenu()
		--elseif data.current.value == 'get_stock' then
			--OpenGetStocksMenu()
		end

	end, function(data, menu)
		menu.close()

		CurrentAction     = 'menu_armory'
		CurrentActionMsg  = _U('open_armory')
		CurrentActionData = {station = station}
	end)
end

function OpenVehicleSpawnerMenu(type, station, part, partNum)
	local playerCoords = GetEntityCoords(PlayerPedId())
	PlayerData = ESX.GetPlayerData()
	local elements = {
		{label = _U('garage_storeditem'), action = 'garage'},
		{label = _U('garage_storeitem'), action = 'store_garage'},
		{label = _U('garage_buyitem'), action = 'buy_vehicle'},
		{label = 'Delete Vehicle', action = 'delete_vehicle'},
	}

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle', {
		title    = _U('garage_title'),
		align    = 'top-right',
		elements = elements
	}, function(data, menu)

		if data.current.action == 'buy_vehicle' then
			local shopElements, shopCoords = {}

			if type == 'car' then
				shopCoords = Config.PoliceStations[station].Vehicles[partNum].InsideShop
				local authorizedVehicles = Config.AuthorizedVehicles[PlayerData.job.grade_name]

				if #Config.AuthorizedVehicles['Shared'] > 0 then
					for k,vehicle in ipairs(Config.AuthorizedVehicles['Shared']) do
						table.insert(shopElements, {
							label = ('%s - <span style="color:green;">%s</span>'):format(vehicle.label, _U('shop_item', (vehicle.price))),
							name  = vehicle.label,
							model = vehicle.model,
							price = vehicle.price,
							type  = 'car'
						})
					end
				end

				if #authorizedVehicles > 0 then
					for k,vehicle in ipairs(authorizedVehicles) do
						table.insert(shopElements, {
							label = ('%s - <span style="color:green;">%s</span>'):format(vehicle.label, _U('shop_item', (vehicle.price))),
							name  = vehicle.label,
							model = vehicle.model,
							price = vehicle.price,
							type  = 'car'
						})
					end
				else
					if #Config.AuthorizedVehicles['Shared'] == 0 then
						return
					end
				end
			elseif type == 'helicopter' then
				shopCoords = Config.PoliceStations[station].Helicopters[partNum].InsideShop
				local authorizedHelicopters = Config.AuthorizedHelicopters[PlayerData.job.grade_name]

				if #authorizedHelicopters > 0 then
					for k,vehicle in ipairs(authorizedHelicopters) do
						table.insert(shopElements, {
							label = ('%s - <span style="color:green;">%s</span>'):format(vehicle.label, _U('shop_item', (vehicle.price))),
							name  = vehicle.label,
							model = vehicle.model,
							price = vehicle.price,
							livery = vehicle.livery or nil,
							type  = 'helicopter'
						})
					end
				else
					ESX.ShowNotification(_U('helicopter_notauthorized'))
					return
				end
			end

			OpenShopMenu(shopElements, playerCoords, shopCoords)
		elseif data.current.action == 'garage' then
			local garage = {}

			ESX.TriggerServerCallback('acc1127b-6e2f-40c4-89f4-1025033aa984', function(jobVehicles)
				if #jobVehicles > 0 then
					for k,v in ipairs(jobVehicles) do
						local props = json.decode(v.vehicle)
						local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(props.model))
						local label = ('%s - <span style="color:darkgoldenrod;">%s</span>: '):format(vehicleName, props.plate)

						if v.stored then
							label = label .. ('<span style="color:green;">%s</span>'):format(_U('garage_stored'))
						else
							label = label .. ('<span style="color:darkred;">%s</span>'):format(_U('garage_notstored'))
						end

						table.insert(garage, {
							label = label,
							stored = v.stored,
							model = props.model,
							vehicleProps = props
						})
					end

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_garage', {
						title    = _U('garage_title'),
						align    = 'top-right',
						elements = garage
					}, function(data2, menu2)
						if data2.current.stored then
							local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint(station, part, partNum)

							if foundSpawn then
								menu2.close()

								ESX.Game.SpawnVehicle(data2.current.model, spawnPoint.coords, spawnPoint.heading, function(vehicle)
									ESX.Game.SetVehicleProperties(vehicle, data2.current.vehicleProps)

									TriggerServerEvent('8bbb81ae-8810-4ba7-8d1d-868534bfde71', data2.current.vehicleProps.plate, false)
									ESX.ShowNotification(_U('garage_released'))
								end)
							end
						else
							ESX.ShowNotification(_U('garage_notavailable'))
						end
					end, function(data2, menu2)
						menu2.close()
					end)

				else
					ESX.ShowNotification(_U('garage_empty'))
				end
			end, type)
		elseif data.current.action == 'delete_vehicle' then
			local garage = {}

			ESX.TriggerServerCallback('acc1127b-6e2f-40c4-89f4-1025033aa984', function(jobVehicles)
				if #jobVehicles > 0 then
					for k,v in ipairs(jobVehicles) do
						local props = json.decode(v.vehicle)
						local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(props.model))
						local label = ('%s - <span style="color:darkgoldenrod;">%s</span>: '):format(vehicleName, props.plate)

						if v.stored then
							label = label .. ('<span style="color:green;">%s</span>'):format(_U('garage_stored'))
						else
							label = label .. ('<span style="color:darkred;">%s</span>'):format(_U('garage_notstored'))
						end

						table.insert(garage, {
							label = label,
							stored = v.stored,
							model = props.model,
							vehicleProps = props
						})
					end

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_garage', {
						title    = _U('garage_title'),
						align    = 'top-right',
						elements = garage
					}, function(data2, menu2)
						menu2.close()
						
						print(data2.current.vehicleProps.plate)
						print(data2.current.model)
						TriggerServerEvent('4f1aec30-47d3-441c-bb6f-edafc6720b55',data2.current.model, data2.current.vehicleProps.plate)

					end, function(data2, menu2)
						menu2.close()
					end)

				else
					ESX.ShowNotification(_U('garage_empty'))
				end
			end, type)

		elseif data.current.action == 'store_garage' then
			StoreNearbyVehicle(playerCoords)
		end

	end, function(data, menu)
		menu.close()
	end)

end

function StoreNearbyVehicle(playerCoords)
	local vehicles, vehiclePlates = ESX.Game.GetVehiclesInArea(playerCoords, 30.0), {}

	if #vehicles > 0 then
		for k,v in ipairs(vehicles) do

			-- Make sure the vehicle we're saving is empty, or else it wont be deleted
			if GetVehicleNumberOfPassengers(v) == 0 and IsVehicleSeatFree(v, -1) then
				table.insert(vehiclePlates, {
					vehicle = v,
					plate = ESX.Math.Trim(GetVehicleNumberPlateText(v))
				})
			end
		end
	else
		ESX.ShowNotification(_U('garage_store_nearby'))
		return
	end

	ESX.TriggerServerCallback('e6739af9-5c1f-4bcc-a9b1-b07531bc0709', function(storeSuccess, foundNum)
		if storeSuccess then
			local vehicleId = vehiclePlates[foundNum]
			local attempts = 0
			ESX.Game.DeleteVehicle(vehicleId.vehicle)
			IsBusy = true

			Citizen.CreateThread(function()
				while IsBusy do
					Citizen.Wait(0)
					drawLoadingText(_U('garage_storing'), 255, 255, 255, 255)
				end
			end)

			-- Workaround for vehicle not deleting when other players are near it.
			while DoesEntityExist(vehicleId.vehicle) do
				Citizen.Wait(500)
				attempts = attempts + 1

				-- Give up
				if attempts > 30 then
					break
				end

				vehicles = ESX.Game.GetVehiclesInArea(playerCoords, 30.0)
				if #vehicles > 0 then
					for k,v in ipairs(vehicles) do
						if ESX.Math.Trim(GetVehicleNumberPlateText(v)) == vehicleId.plate then
							ESX.Game.DeleteVehicle(v)
							break
						end
					end
				end
			end

			IsBusy = false
			ESX.ShowNotification(_U('garage_has_stored'))
		else
			ESX.ShowNotification(_U('garage_has_notstored'))
		end
	end, vehiclePlates)
end

function GetAvailableVehicleSpawnPoint(station, part, partNum)
	local spawnPoints = Config.PoliceStations[station][part][partNum].SpawnPoints
	local found, foundSpawnPoint = false, nil

	for i=1, #spawnPoints, 1 do
		if ESX.Game.IsSpawnPointClear(spawnPoints[i].coords, spawnPoints[i].radius) then
			found, foundSpawnPoint = true, spawnPoints[i]
			break
		end
	end

	if found then
		return true, foundSpawnPoint
	else
		ESX.ShowNotification(_U('vehicle_blocked'))
		return false
	end
end

function OpenShopMenu(elements, restoreCoords, shopCoords)
	local playerPed = PlayerPedId()
	isInShopMenu = true

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_shop', {
		title    = _U('vehicleshop_title'),
		align    = 'top-right',
		elements = elements
	}, function(data, menu)

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_shop_confirm',
		{
			title    = _U('vehicleshop_confirm', data.current.name, data.current.price),
			align    = 'top-right',
			elements = {
				{ label = _U('confirm_no'), value = 'no' },
				{ label = _U('confirm_yes'), value = 'yes' }
			}
		}, function(data2, menu2)

			if data2.current.value == 'yes' then
				local newPlate = exports['esx_vehicleshop']:GeneratePlate()
				local vehicle  = GetVehiclePedIsIn(playerPed, false)
				local props    = ESX.Game.GetVehicleProperties(vehicle)
				props.plate    = newPlate

				ESX.TriggerServerCallback('2ded7536-c588-4c30-a223-9f59b20bf307', function (bought)
					if bought then
						ESX.ShowNotification(_U('vehicleshop_bought', data.current.name, (data.current.price)))

						isInShopMenu = false
						ESX.UI.Menu.CloseAll()
				
						DeleteSpawnedVehicles()
						FreezeEntityPosition(playerPed, false)
						SetEntityVisible(playerPed, true)
				
						ESX.Game.Teleport(playerPed, restoreCoords)
					else
						ESX.ShowNotification(_U('vehicleshop_money'))
						menu2.close()
					end
				end, props, data.current.type)
			else
				menu2.close()
			end

		end, function(data2, menu2)
			menu2.close()
		end)

		end, function(data, menu)
		isInShopMenu = false
		ESX.UI.Menu.CloseAll()

		DeleteSpawnedVehicles()
		FreezeEntityPosition(playerPed, false)
		SetEntityVisible(playerPed, true)

		ESX.Game.Teleport(playerPed, restoreCoords)
	end, function(data, menu)
		DeleteSpawnedVehicles()

		WaitForVehicleToLoad(data.current.model)
		ESX.Game.SpawnLocalVehicle(data.current.model, shopCoords, 0.0, function(vehicle)
			table.insert(spawnedVehicles, vehicle)
			TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			FreezeEntityPosition(vehicle, true)
			if data.current.model == 'honorsec1' then
				SetVehicleExtra(vehicle,1,0)
				SetVehicleExtra(vehicle,2,1)
				SetVehicleExtra(vehicle,3,1)
				SetVehicleExtra(vehicle,4,1)
				SetVehicleExtra(vehicle,5,1)
				SetVehicleExtra(vehicle,6,1)
				SetVehicleExtra(vehicle,7,1)
				SetVehicleExtra(vehicle,8,1)
				SetVehicleExtra(vehicle,9,1)
				SetVehicleExtra(vehicle,10,1)
				SetVehicleExtra(vehicle,11,1)
				SetVehicleExtra(vehicle,12,1)
			end

			if data.current.livery then
				SetVehicleModKit(vehicle, 0)
				SetVehicleLivery(vehicle, data.current.livery)
			end
		end)
	end)

	WaitForVehicleToLoad(elements[1].model)
	ESX.Game.SpawnLocalVehicle(elements[1].model, shopCoords, 0.0, function(vehicle)
		table.insert(spawnedVehicles, vehicle)
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		FreezeEntityPosition(vehicle, true)

		if elements[1].livery then
			SetVehicleModKit(vehicle, 0)
			SetVehicleLivery(vehicle,elements[1].livery)
		end
	end)
end

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if isInShopMenu then
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		else
			Citizen.Wait(500)
		end
	end
end)

function DeleteSpawnedVehicles()
	while #spawnedVehicles > 0 do
		local vehicle = spawnedVehicles[1]
		ESX.Game.DeleteVehicle(vehicle)
		table.remove(spawnedVehicles, 1)
	end
end

function WaitForVehicleToLoad(modelHash)
	modelHash = (type(modelHash) == 'number' and modelHash or GetHashKey(modelHash))

	if not HasModelLoaded(modelHash) then
		RequestModel(modelHash)

		while not HasModelLoaded(modelHash) do
			Citizen.Wait(0)

			DisableControlAction(0, Keys['TOP'], true)
			DisableControlAction(0, Keys['DOWN'], true)
			DisableControlAction(0, Keys['LEFT'], true)
			DisableControlAction(0, Keys['RIGHT'], true)
			DisableControlAction(0, 176, true) -- ENTER key
			DisableControlAction(0, Keys['BACKSPACE'], true)

			drawLoadingText(_U('vehicleshop_awaiting_model'), 255, 255, 255, 255)
		end
	end
end

function drawLoadingText(text, red, green, blue, alpha)
	SetTextFont(4)
	SetTextProportional(0)
	SetTextScale(0.0, 0.5)
	SetTextColour(red, green, blue, alpha)
	SetTextDropShadow(0, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextCentre(true)

	BeginTextCommandDisplayText("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandDisplayText(0.5, 0.5)
end

function OpenWilsonActionsMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'wilson_actions',
	{
		title    = 'Police',
		align    = 'top-right',
		elements = {
			{label = _U('citizen_interaction'),	value = 'citizen_interaction'},
			{label = _U('vehicle_interaction'),	value = 'vehicle_interaction'},
			{label = _U('object_spawner'),		value = 'object_spawner'},
			{label = 'Go on Duty',     value = 'onduty'},
			{label = 'Go off Duty',     value = 'offduty'},
			
		}
	}, function(data, menu)

		 if data.current.value == 'onduty' then
			TriggerServerEvent('es:setJobDuty',tostring(GetPlayerServerId(PlayerId())), true)
							
		end
							
		if data.current.value == 'offduty' then
			TriggerServerEvent('es:setJobDuty',tostring(GetPlayerServerId(PlayerId())), false)
		end

		if data.current.value == 'citizen_interaction' then
			local elements = {
				--{label = _U('id_card'),			value = 'identity_card'},
				{label = _U('search'),			value = 'body_search'},
				{label = _U('handcuff'),		value = 'handcuff'},
				{label = _U('drag'),			value = 'drag'},
				{label = _U('put_in_vehicle'),	value = 'put_in_vehicle'},
				{label = _U('out_the_vehicle'),	value = 'out_the_vehicle'},
				{label = 'Invoice',			value = 'fine'},
				--{label = _U('unpaid_bills'),	value = 'unpaid_bills'}
			}
		
			if Config.EnableLicenses then
				table.insert(elements, { label = _U('license_check'), value = 'license' })
			end
		
			ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'citizen_interaction',
			{
				title    = _U('citizen_interaction'),
				align    = 'top-right',
				elements = elements
			}, function(data2, menu2)
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer ~= -1 and closestDistance <= 3.0 then
					local action = data2.current.value

					if action == 'identity_card' then
						OpenIdentityCardMenu(closestPlayer)
					elseif action == 'body_search' then
						TriggerServerEvent('e5d8a4b0-325b-484d-be1b-b7457a65e367', GetPlayerServerId(closestPlayer), _U('being_searched'))
						TriggerServerEvent('841a41b8-d3a5-4d25-9d37-2e0803c1e51a',"WILSON ACTION", "SEARCH " .. data.current.label .. "PLAYER: ", GetPlayerServerId(closestPlayer))
						OpenBodySearchMenu(closestPlayer)
					elseif action == 'handcuff' then
						TriggerServerEvent('7442ae0f-4671-467b-a7ea-727537fb634b', GetPlayerServerId(closestPlayer))
						TriggerServerEvent('841a41b8-d3a5-4d25-9d37-2e0803c1e51a',"WILSON ACTION", "HANDCUFF TOGGLE " .. data.current.label .. "PLAYER: ", GetPlayerServerId(closestPlayer))
					elseif action == 'drag' then
						TriggerServerEvent('841a41b8-d3a5-4d25-9d37-2e0803c1e51a',"WILSON ACTION", "DRAG " .. data.current.label .. "PLAYER: ", GetPlayerServerId(closestPlayer))
						TriggerServerEvent('c6934646-42fb-4b43-81e4-65418d47d438', GetPlayerServerId(closestPlayer))
					elseif action == 'put_in_vehicle' then
						TriggerServerEvent('841a41b8-d3a5-4d25-9d37-2e0803c1e51a',"WILSON ACTION", "PUT IN VEHICLE " .. data.current.label .. "PLAYER: ", GetPlayerServerId(closestPlayer))
						TriggerServerEvent('3553c4e6-e167-4198-a874-ce60878bbc30', GetPlayerServerId(closestPlayer))
					elseif action == 'out_the_vehicle' then
						TriggerServerEvent('841a41b8-d3a5-4d25-9d37-2e0803c1e51a',"WILSON ACTION", "DRAG OUT OF VEHICLE " .. data.current.label .. "PLAYER: ", GetPlayerServerId(closestPlayer))
						TriggerServerEvent('504f98b7-e0a4-45a7-b217-42ac77e8b462', GetPlayerServerId(closestPlayer))
					elseif action == 'fine' then
				
							ESX.UI.Menu.Open(
							  'dialog', GetCurrentResourceName(), 'billing',
							  {
							  
								title = 'Invoie Amount'
							  },
							  function(data, menu)
								local amount = tonumber(data.value)
								if amount == nil or amount < 0 then
								  ESX.ShowNotification('An invalid amount was entered')
								else
								  
								  local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
								  if closestPlayer == -1 or closestDistance > 3.0 then
									ESX.ShowNotification('No Players nearby to invoice')
								  else
									menu.close()
									TriggerServerEvent('c9ac0436-8b83-467d-abe5-4978cdf78f9b', GetPlayerServerId(closestPlayer), 'society_wilson', 'Wilson Security Services', amount)
								  end
								end
							  end,
							function(data, menu)
							  menu.close()
							end
							)
						
					elseif action == 'license' then
						ShowPlayerLicense(closestPlayer)
					elseif action == 'unpaid_bills' then
						OpenUnpaidBillsMenu(closestPlayer)
					end

				else
					ESX.ShowNotification(_U('no_players_nearby'))
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif data.current.value == 'vehicle_interaction' then
			local elements  = {}
			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			local vehicle   = ESX.Game.GetVehicleInDirection()
			
			if DoesEntityExist(vehicle) then
				table.insert(elements, {label = _U('vehicle_info'),	value = 'vehicle_infos'})
				--table.insert(elements, {label = _U('pick_lock'),	value = 'hijack_vehicle'})
				table.insert(elements, {label = _U('impound'),		value = 'impound'})
			end
			
			table.insert(elements, {label = _U('search_database'), value = 'search_database'})

			ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'vehicle_interaction',
			{
				title    = _U('vehicle_interaction'),
				align    = 'top-right',
				elements = elements
			}, function(data2, menu2)
				coords  = GetEntityCoords(playerPed)
				vehicle = ESX.Game.GetVehicleInDirection()
				action  = data2.current.value
				
				if action == 'search_database' then
					LookupVehicle()
				elseif DoesEntityExist(vehicle) then
					local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
					if action == 'vehicle_infos' then
						OpenVehicleInfosMenu(vehicleData)
						
					elseif action == 'hijack_vehicle' then
						if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
							TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
							Citizen.Wait(20000)
							ClearPedTasksImmediately(playerPed)

							SetVehicleDoorsLocked(vehicle, 1)
							SetVehicleDoorsLockedForAllPlayers(vehicle, false)
							ESX.ShowNotification(_U('vehicle_unlocked'))
						end
					elseif action == 'impound' then
					
						-- is the script busy?
						if CurrentTask.Busy then
							return
						end

						ESX.ShowHelpNotification(_U('impound_prompt'))
						
						TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
						
						CurrentTask.Busy = true
						CurrentTask.Task = ESX.SetTimeout(10000, function()
							ClearPedTasks(playerPed)
							ImpoundVehicle(vehicle)
							Citizen.Wait(100) -- sleep the entire script to let stuff sink back to reality
						end)
						
						-- keep track of that vehicle!
						Citizen.CreateThread(function()
							while CurrentTask.Busy do
								Citizen.Wait(1000)
							
								vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
								if not DoesEntityExist(vehicle) and CurrentTask.Busy then
									ESX.ShowNotification(_U('impound_canceled_moved'))
									ESX.ClearTimeout(CurrentTask.Task)
									ClearPedTasks(playerPed)
									CurrentTask.Busy = false
									break
								end
							end
						end)
					end
				else
					ESX.ShowNotification(_U('no_vehicles_nearby'))
				end

			end, function(data2, menu2)
				menu2.close()
			end)

		elseif data.current.value == 'object_spawner' then
			ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'citizen_interaction',
			{
				title    = _U('traffic_interaction'),
				align    = 'top-right',
				elements = {
					{label = _U('cone'),		value = 'prop_roadcone02a'},
					{label = _U('barrier'),		value = 'prop_barrier_work06a'},
				}
			}, function(data2, menu2)
				local model     = data2.current.value
				local playerPed = PlayerPedId()
				local coords    = GetEntityCoords(playerPed)
				local forward   = GetEntityForwardVector(playerPed)
				local x, y, z   = table.unpack(coords + forward * 1.0)

				if model == 'prop_roadcone02a' then
					z = z - 2.0
				end

				ESX.Game.SpawnObject(model, {
					x = x,
					y = y,
					z = z
				}, function(obj)
					SetEntityHeading(obj, GetEntityHeading(playerPed))
					PlaceObjectOnGroundProperly(obj)
				end)

			end, function(data2, menu2)
				menu2.close()
			end)
		end

	end, function(data, menu)
		menu.close()
	end)
end

function OpenIdentityCardMenu(player)

	ESX.TriggerServerCallback('655dfe19-f706-4558-8fdb-64abc3e2aa18', function(data)

		local elements    = {}
		local nameLabel   = _U('name', data.name)
		local jobLabel    = nil
		local sexLabel    = nil
		local dobLabel    = nil
		local heightLabel = nil
		local idLabel     = nil
	
		if data.job.grade_label ~= nil and  data.job.grade_label ~= '' then
			jobLabel = _U('job', data.job.label .. ' - ' .. data.job.grade_label)
		else
			jobLabel = _U('job', data.job.label)
		end
	
		if Config.EnableESXIdentity then
	
			nameLabel = _U('name', data.firstname .. ' ' .. data.lastname)
	
			if data.sex ~= nil then
				if string.lower(data.sex) == 'm' then
					sexLabel = _U('sex', _U('male'))
				else
					sexLabel = _U('sex', _U('female'))
				end
			else
				sexLabel = _U('sex', _U('unknown'))
			end
	
			if data.dob ~= nil then
				dobLabel = _U('dob', data.dob)
			else
				dobLabel = _U('dob', _U('unknown'))
			end
	
			if data.height ~= nil then
				heightLabel = _U('height', data.height)
			else
				heightLabel = _U('height', _U('unknown'))
			end
	
			if data.name ~= nil then
				idLabel = _U('id', data.name)
			else
				idLabel = _U('id', _U('unknown'))
			end
	
		end
	
		local elements = {
			{label = nameLabel, value = nil},
			{label = jobLabel,  value = nil},
		}
	
		if Config.EnableESXIdentity then
			table.insert(elements, {label = sexLabel, value = nil})
			table.insert(elements, {label = dobLabel, value = nil})
			table.insert(elements, {label = heightLabel, value = nil})
			table.insert(elements, {label = idLabel, value = nil})
		end
	
		if data.drunk ~= nil then
			table.insert(elements, {label = _U('bac', data.drunk), value = nil})
		end
	
		if data.licenses ~= nil then
	
			table.insert(elements, {label = _U('license_label'), value = nil})
	
			for i=1, #data.licenses, 1 do
				table.insert(elements, {label = data.licenses[i].label, value = nil})
			end
	
		end
	
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction',
		{
			title    = _U('citizen_interaction'),
			align    = 'top-right',
			elements = elements,
		}, function(data, menu)
	
		end, function(data, menu)
			menu.close()
		end)
	
	end, GetPlayerServerId(player))

end

function OpenBodySearchMenu(player)

	ESX.TriggerServerCallback('655dfe19-f706-4558-8fdb-64abc3e2aa18', function(data)

		local elements = {}

		for i=1, #data.accounts, 1 do

			if data.accounts[i].name == 'black_money' and data.accounts[i].money > 0 then

				table.insert(elements, {
					label    = _U('confiscate_dirty', ESX.Math.Round(data.accounts[i].money)),
					value    = 'black_money',
					itemType = 'item_account',
					amount   = data.accounts[i].money
				})

				break
			end

		end

		table.insert(elements, {label = _U('guns_label'), value = nil})

		for i=1, #data.weapons, 1 do
			table.insert(elements, {
				label    = _U('confiscate_weapon', ESX.GetWeaponLabel(data.weapons[i].name), data.weapons[i].ammo),
				value    = data.weapons[i].name,
				itemType = 'item_weapon',
				amount   = data.weapons[i].ammo
			})
		end

		table.insert(elements, {label = _U('inventory_label'), value = nil})

		for i=1, #data.inventory, 1 do
			if data.inventory[i].count > 0 then
				table.insert(elements, {
					label    = _U('confiscate_inv', data.inventory[i].count, data.inventory[i].label),
					value    = data.inventory[i].name,
					itemType = 'item_standard',
					amount   = data.inventory[i].count
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'body_search',
		{
			title    = _U('search'),
			align    = 'top-right',
			elements = elements,
		},
		function(data, menu)

			local itemType = data.current.itemType
			local itemName = data.current.value
			local amount   = data.current.amount

			if data.current.value ~= nil then
				--TriggerServerEvent('4cb3f7c0-c0ff-4370-9761-75b4e2921f6a', GetPlayerServerId(player), itemType, itemName, amount)
				OpenBodySearchMenu(player)
			end

		end, function(data, menu)
			menu.close()
		end)

	end, GetPlayerServerId(player))

end

function OpenFineMenu(player)

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine',
	{
		title    = _U('fine'),
		align    = 'top-right',
		elements = {
			{label = _U('traffic_offense'), value = 0},
			{label = _U('minor_offense'),   value = 1},
			{label = _U('average_offense'), value = 2},
			{label = _U('major_offense'),   value = 3}
		}
	}, function(data, menu)
		OpenFineCategoryMenu(player, data.current.value)
	end, function(data, menu)
		menu.close()
	end)

end

function OpenFineCategoryMenu(player, category)

	ESX.TriggerServerCallback('4f85f077-0016-4192-b7ba-c2f667966500', function(fines)

		local elements = {}

		for i=1, #fines, 1 do
			table.insert(elements, {
				label     = fines[i].label .. ' <span style="color: green;">$' .. fines[i].amount .. '</span>',
				value     = fines[i].id,
				amount    = fines[i].amount,
				fineLabel = fines[i].label
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'fine_category',
		{
			title    = _U('fine'),
			align    = 'top-right',
			elements = elements,
		}, function(data, menu)

			local label  = data.current.fineLabel
			local amount = data.current.amount

			menu.close()

			if Config.EnablePlayerManagement then
				TriggerServerEvent('c9ac0436-8b83-467d-abe5-4978cdf78f9b', GetPlayerServerId(player), 'society_police', _U('fine_total', label), amount)
			else
				TriggerServerEvent('c9ac0436-8b83-467d-abe5-4978cdf78f9b', GetPlayerServerId(player), '', _U('fine_total', label), amount)
			end

			ESX.SetTimeout(300, function()
				OpenFineCategoryMenu(player, category)
			end)

		end, function(data, menu)
			menu.close()
		end)

	end, category)

end

function LookupVehicle()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'lookup_vehicle',
	{
		title = _U('search_database_title'),
	}, function(data, menu)
		local length = string.len(data.value)
		if data.value == nil or length < 2 or length > 13 then
			ESX.ShowNotification(_U('search_database_error_invalid'))
		else
			ESX.TriggerServerCallback('6615c29b-6a56-43bc-b86e-b20e70cb0105', function(owner, found)
				if found then
					ESX.ShowNotification(_U('search_database_found', owner))
				else
					ESX.ShowNotification(_U('search_database_error_not_found'))
				end
			end, data.value)
			menu.close()
		end
	end, function(data, menu)
		menu.close()
	end)
end

function ShowPlayerLicense(player)
	local elements = {}
	local targetName
	ESX.TriggerServerCallback('655dfe19-f706-4558-8fdb-64abc3e2aa18', function(data)
		if data.licenses then
			for i=1, #data.licenses, 1 do
				if data.licenses[i].label and data.licenses[i].type then
					table.insert(elements, {
						label = data.licenses[i].label,
						type = data.licenses[i].type
					})
				end
			end
		end
		
		if Config.EnableESXIdentity then
			targetName = data.firstname .. ' ' .. data.lastname
		else
			targetName = data.name
		end
		
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'manage_license',
		{
			title    = _U('license_revoke'),
			align    = 'top-right',
			elements = elements,
		}, function(data, menu)
			ESX.ShowNotification(_U('licence_you_revoked', data.current.label, targetName))
			TriggerServerEvent('e5d8a4b0-325b-484d-be1b-b7457a65e367', GetPlayerServerId(player), _U('license_revoked', data.current.label))
			
			TriggerServerEvent('43d39fcc-6e74-4d37-9689-6dcc3d664435', GetPlayerServerId(player), data.current.type)
			
			ESX.SetTimeout(300, function()
				ShowPlayerLicense(player)
			end)
		end, function(data, menu)
			menu.close()
		end)

	end, GetPlayerServerId(player))
end

function OpenUnpaidBillsMenu(player)
	local elements = {}

	ESX.TriggerServerCallback('9e25ae47-42fc-4509-b43d-0c5e0b273b1a', function(bills)
		for i=1, #bills, 1 do
			table.insert(elements, {
				label = bills[i].label .. ' - <span style="color: red;">$' .. bills[i].amount .. '</span>',
				value = bills[i].id
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billing',
		{
			title    = _U('unpaid_bills'),
			align    = 'top-right',
			elements = elements
		}, function(data, menu)
	
		end, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

function OpenVehicleInfosMenu(vehicleData)

	ESX.TriggerServerCallback('610dae35-fe09-459f-962f-138e4ef76e63', function(retrivedInfo)

		local elements = {}

		table.insert(elements, {label = _U('plate', retrivedInfo.plate), value = nil})

		if retrivedInfo.owner == nil then
			table.insert(elements, {label = _U('owner_unknown'), value = nil})
		else
			table.insert(elements, {label = _U('owner', retrivedInfo.owner), value = nil})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_infos',
		{
			title    = _U('vehicle_info'),
			align    = 'top-right',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)

	end, vehicleData.plate)

end

function OpenGetWeaponMenu()

	ESX.TriggerServerCallback('30e3adce-c0ff-4121-95b6-1f05265dbb26', function(weapons)
		local elements = {}

		for i=1, #weapons, 1 do
			if weapons[i].count > 0 then
				table.insert(elements, {
					label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name),
					value = weapons[i].name
				})
			end
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_get_weapon',
		{
			title    = _U('get_weapon_menu'),
			align    = 'top-right',
			elements = elements
		}, function(data, menu)

			menu.close()

			ESX.TriggerServerCallback('2057f771-b8fc-4439-ab48-0306e82366b1', function()
				OpenGetWeaponMenu()
			end, data.current.value)

		end, function(data, menu)
			menu.close()
		end)
	end)

end

function OpenPutWeaponMenu()
	local elements   = {}
	local playerPed  = PlayerPedId()
	local weaponList = ESX.GetWeaponList()

	for i=1, #weaponList, 1 do
		local weaponHash = GetHashKey(weaponList[i].name)

		if HasPedGotWeapon(playerPed, weaponHash, false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
			table.insert(elements, {
				label = weaponList[i].label,
				value = weaponList[i].name
			})
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_put_weapon',
	{
		title    = _U('put_weapon_menu'),
		align    = 'top-right',
		elements = elements
	}, function(data, menu)

		menu.close()

		ESX.TriggerServerCallback('bb27a47c-6bca-42d6-8dec-468318960e3a', function()
			OpenPutWeaponMenu()
		end, data.current.value, true)

	end, function(data, menu)
		menu.close()
	end)
end

function OpenBuyWeaponsMenu()

	local elements = {}
	local playerPed = PlayerPedId()
	PlayerData = ESX.GetPlayerData()

	for k,v in ipairs(Config.AuthorizedWeapons[PlayerData.job.grade_name]) do
		local weaponNum, weapon = ESX.GetWeapon(v.weapon)
		local components, label = {}

		local hasWeapon = HasPedGotWeapon(playerPed, GetHashKey(v.weapon), false)

		if v.components then
			for i=1, #v.components do
				if v.components[i] then

					local component = weapon.components[i]
					local hasComponent = HasPedGotWeaponComponent(playerPed, GetHashKey(v.weapon), component.hash)

					if hasComponent then
						label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('armory_owned'))
					else
						if v.components[i] > 0 then
							label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('armory_item', (v.components[i])))
						else
							label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('armory_free'))
						end
					end

					table.insert(components, {
						label = label,
						componentLabel = component.label,
						hash = component.hash,
						name = component.name,
						price = v.components[i],
						hasComponent = hasComponent,
						componentNum = i
					})
				end
			end
		end

		if hasWeapon and v.components then
			label = ('%s: <span style="color:green;">></span>'):format(weapon.label)
		elseif hasWeapon and not v.components then
			label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('armory_owned'))
		else
			if v.price > 0 then
				label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('armory_item', (v.price)))
			else
				label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('armory_free'))
			end
		end
		--Removed Components
		table.insert(elements, {
			label = label,
			weaponLabel = weapon.label,
			name = weapon.name,
			components = {},
			price = v.price,
			hasWeapon = hasWeapon
		})
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_buy_weapons', {
		title    = _U('armory_weapontitle'),
		align    = 'top-right',
		elements = elements
	}, function(data, menu)

		if data.current.hasWeapon then
			if #data.current.components > 0 then
				OpenWeaponComponentShop(data.current.components, data.current.name, menu)
			end
		else
			ESX.TriggerServerCallback('2e9e0db3-9fef-4489-9861-e9325d92620e', function(bought)
				if bought then
					if data.current.price > 0 then
						ESX.ShowNotification(_U('armory_bought', data.current.weaponLabel, (data.current.price)))
					end

					menu.close()

					OpenBuyWeaponsMenu()
				else
					ESX.ShowNotification(_U('armory_money'))
				end
			end, data.current.name, 1)
		end

	end, function(data, menu)
		menu.close()
	end)

end

function OpenWeaponComponentShop(components, weaponName, parentShop)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'armory_buy_weapons_components', {
		title    = _U('armory_componenttitle'),
		align    = 'top-right',
		elements = components
	}, function(data, menu)

		if data.current.hasComponent then
			ESX.ShowNotification(_U('armory_hascomponent'))
		else
			ESX.TriggerServerCallback('2e9e0db3-9fef-4489-9861-e9325d92620e', function(bought)
				if bought then
					if data.current.price > 0 then
						ESX.ShowNotification(_U('armory_bought', data.current.componentLabel, (data.current.price)))
					end

					menu.close()
					parentShop.close()

					OpenBuyWeaponsMenu()
				else
					ESX.ShowNotification(_U('armory_money'))
				end
			end, weaponName, 2, data.current.componentNum)
		end

	end, function(data, menu)
		menu.close()
	end)
end

function OpenGetStocksMenu()

	ESX.TriggerServerCallback('c132ee64-de85-4e5d-b5ae-2cf6cdfc275c', function(items)

		local elements = {}

		for i=1, #items, 1 do
			table.insert(elements, {
				label = 'x' .. items[i].count .. ' ' .. items[i].label,
				value = items[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu',
		{
			title    = _U('police_stock'),
			align    = 'top-right',
			elements = elements
		}, function(data, menu)

			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)

				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('quantity_invalid'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('ef8eb4cd-40ca-44da-974a-871fc9a1c1fb', itemName, count)

					Citizen.Wait(300)
					OpenGetStocksMenu()
				end

			end, function(data2, menu2)
				menu2.close()
			end)

		end, function(data, menu)
			menu.close()
		end)

	end)

end

function OpenPutStocksMenu()

	ESX.TriggerServerCallback('eb9ef3ee-4bcb-4c42-9664-9f766d07693a', function(inventory)

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

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu',
		{
			title    = _U('inventory'),
			align    = 'top-right',
			elements = elements
		}, function(data, menu)

			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)

				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('quantity_invalid'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('da0184be-fa7b-417b-8082-98a842eac3b3', itemName, count)

					Citizen.Wait(300)
					OpenPutStocksMenu()
				end

			end, function(data2, menu2)
				menu2.close()
			end)

		end, function(data, menu)
			menu.close()
		end)
	end)

end

RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function(job)
	PlayerData.job = job
	
	Citizen.Wait(5000)
	TriggerServerEvent('448bbefb-7570-4178-aef7-b29822325314')
end)

RegisterNetEvent('59809f17-d8ce-49dd-ae30-d5e90a7761a7')
AddEventHandler('59809f17-d8ce-49dd-ae30-d5e90a7761a7', function(phoneNumber, contacts)
	local specialContact = {
		name       = _U('phone_police'),
		number     = 'Honour Services',
		base64Icon = 'data:image/png;base64,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'
	}

	TriggerEvent('e25977c9-9f2b-4d5d-a807-a8c7a0c964d5', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

-- don't show dispatches if the player isn't in service
AddEventHandler('d741365c-35a8-43b8-8a01-c9ce8e67be5d', function(dispatchNumber)
	if type(PlayerData.job.name) == 'string' and PlayerData.job.name == 'wilson' and PlayerData.job.name == dispatchNumber then
		-- if esx_service is enabled
		if Config.MaxInService ~= -1 and not playerInService then
			CancelEvent()
		end
	end
end)

AddEventHandler('fa4a2b69-4cd3-432b-9a41-e9e16ced0ade', function(station, part, partNum)

	if part == 'Cloakroom' then
		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = _U('open_cloackroom')
		CurrentActionData = {}

	elseif part == 'Armory' then

		CurrentAction     = 'menu_armory'
		CurrentActionMsg  = _U('open_armory')
		CurrentActionData = {station = station}

	elseif part == 'Vehicles' then

		CurrentAction     = 'menu_vehicle_spawner'
		CurrentActionMsg  = _U('garage_prompt')
		CurrentActionData = {station = station, part = part, partNum = partNum}

	elseif part == 'Helicopters' then

		CurrentAction     = 'Helicopters'
		CurrentActionMsg  = _U('helicopter_prompt')
		CurrentActionData = {station = station, part = part, partNum = partNum}

	elseif part == 'BossActions' then

		CurrentAction     = 'menu_boss_actions'
		CurrentActionMsg  = _U('open_bossmenu')
		CurrentActionData = {}

	end

end)

AddEventHandler('aedb8481-8911-438b-8ddc-aefe132d2e3e', function(station, part, partNum)
	if not isInShopMenu then
		ESX.UI.Menu.CloseAll()
	end

	CurrentAction = nil
end)

AddEventHandler('e9743b8c-c39e-47b2-a9bb-77103fff9b58', function(entity)
	local playerPed = PlayerPedId()

	if PlayerData.job ~= nil and PlayerData.job.name == 'wilson' and IsPedOnFoot(playerPed) then
		CurrentAction     = 'remove_entity'
		CurrentActionMsg  = _U('remove_prop')
		CurrentActionData = {entity = entity}
	end

	if GetEntityModel(entity) == GetHashKey('p_ld_stinger_s') then
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed)

			for i=0, 7, 1 do
				SetVehicleTyreBurst(vehicle, i, true, 1000)
			end
		end
	end
end)

AddEventHandler('bb6a8129-8671-4205-a2fc-b349f7d62ef7', function(entity)
	if CurrentAction == 'remove_entity' then
		CurrentAction = nil
	end
end)

RegisterNetEvent('c2a7b8b4-f386-450c-b01c-00a5a7482510')
AddEventHandler('c2a7b8b4-f386-450c-b01c-00a5a7482510', function()
	IsHandcuffed    = not IsHandcuffed
	local playerPed = PlayerPedId()

	Citizen.CreateThread(function()
		if IsHandcuffed then

			RequestAnimDict('mp_arresting')
			while not HasAnimDictLoaded('mp_arresting') do
				Citizen.Wait(100)
			end

			TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)

			SetEnableHandcuffs(playerPed, true)
			DisablePlayerFiring(playerPed, true)
			SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true) -- unarm player
			SetPedCanPlayGestureAnims(playerPed, false)
			
			--FreezeEntityPosition(playerPed, true)
			DisplayRadar(false)

			if Config.EnableHandcuffTimer then

				if HandcuffTimer.Active then
					ESX.ClearTimeout(HandcuffTimer.Task)
				end

				StartHandcuffTimer()
			end

		else

			if Config.EnableHandcuffTimer and HandcuffTimer.Active then
				ESX.ClearTimeout(HandcuffTimer.Task)
			end

			ClearPedSecondaryTask(playerPed)
			SetEnableHandcuffs(playerPed, false)
			DisablePlayerFiring(playerPed, false)
			SetPedCanPlayGestureAnims(playerPed, true)
			--FreezeEntityPosition(playerPed, false)
			DisplayRadar(true)
		end
	end)

end)

RegisterNetEvent('73883592-76fa-49c3-8bdf-89c7d3a0126b')
AddEventHandler('73883592-76fa-49c3-8bdf-89c7d3a0126b', function()
	if IsHandcuffed then
		local playerPed = PlayerPedId()
		IsHandcuffed = false

		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		--FreezeEntityPosition(playerPed, false)
		DisplayRadar(true)

		-- end timer
		if Config.EnableHandcuffTimer and HandcuffTimer.Active then
			ESX.ClearTimeout(HandcuffTimer.Task)
		end
	end
end)

RegisterNetEvent('80687d4b-1afa-4a07-a596-834c74397505')
AddEventHandler('80687d4b-1afa-4a07-a596-834c74397505', function(copID)
	if not IsHandcuffed then
		return
	end

	DragStatus.IsDragged = not DragStatus.IsDragged
	DragStatus.CopId     = tonumber(copID)
end)

Citizen.CreateThread(function()
	local playerPed
	local targetPed

	while true do
		Citizen.Wait(1)

		if IsHandcuffed then
			playerPed = PlayerPedId()

			if DragStatus.IsDragged then
				targetPed = GetPlayerPed(GetPlayerFromServerId(DragStatus.CopId))

				-- undrag if target is in an vehicle
				if not IsPedSittingInAnyVehicle(targetPed) then
					AttachEntityToEntity(playerPed, targetPed, 11816, 0.54, 0.54, 0.0, 0.0, 0.0, 0.0, false, false, false, false, 2, true)
				else
					DragStatus.IsDragged = false
					DetachEntity(playerPed, true, false)
				end

				if IsPedDeadOrDying(targetPed, true) then
					DragStatus.IsDragged = false
					DetachEntity(playerPed, true, false)
				end

			else
				DetachEntity(playerPed, true, false)
			end
		else
			Citizen.Wait(1000)
		end
	end
end)

RegisterNetEvent('5f938da1-b986-45bf-bcfb-a125ab06d262')
AddEventHandler('5f938da1-b986-45bf-bcfb-a125ab06d262', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed)

	if not IsHandcuffed then
		return
	end

	if IsAnyVehicleNearPoint(coords, 5.0) then
		local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

			for i=maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle, i) then
					freeSeat = i
					break
				end
			end

			if freeSeat then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
				DragStatus.IsDragged = false
			end
		end
	end
end)

RegisterNetEvent('baf47d4c-8cb7-407c-a7f2-dc0660ae7a59')
AddEventHandler('baf47d4c-8cb7-407c-a7f2-dc0660ae7a59', function()
	local playerPed = PlayerPedId()

	if not IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	local vehicle = GetVehiclePedIsIn(playerPed, false)
	TaskLeaveVehicle(playerPed, vehicle, 16)
end)

-- Handcuff
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)
		local playerPed = PlayerPedId()

		if IsHandcuffed then
			--DisableControlAction(0, 1, true) -- Disable pan
			--DisableControlAction(0, 2, true) -- Disable tilt
			DisableControlAction(0, 24, true) -- Attack
			DisableControlAction(0, 257, true) -- Attack 2
			DisableControlAction(0, 25, true) -- Aim
			DisableControlAction(0, 263, true) -- Melee Attack 1
			--DisableControlAction(0, Keys['W'], true) -- W
			--DisableControlAction(0, Keys['A'], true) -- A
			--DisableControlAction(0, 31, true) -- S (fault in Keys table!)
			--DisableControlAction(0, 30, true) -- D (fault in Keys table!)

			DisableControlAction(0, Keys['R'], true) -- Reload
			DisableControlAction(0, Keys['SPACE'], true) -- Jump
			DisableControlAction(0, Keys['Q'], true) -- Cover
			DisableControlAction(0, Keys['TAB'], true) -- Select Weapon
			DisableControlAction(0, Keys['F'], true) -- Also 'enter'?
			DisableControlAction(2, Keys['LEFTSHIFT'], true)

			DisableControlAction(0, Keys['F1'], true) -- Disable phone
			DisableControlAction(0, Keys['F2'], true) -- Inventory
			DisableControlAction(0, Keys['F3'], true) -- Animations
			DisableControlAction(0, Keys['F6'], true) -- Job

			DisableControlAction(0, Keys['V'], true) -- Disable changing view
			DisableControlAction(0, Keys['C'], true) -- Disable looking behind
			DisableControlAction(0, Keys['X'], true) -- Disable clearing animation
			DisableControlAction(2, Keys['P'], true) -- Disable pause screen

			DisableControlAction(0, 59, true) -- Disable steering in vehicle
			DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
			DisableControlAction(0, 72, true) -- Disable reversing in vehicle

			DisableControlAction(2, Keys['LEFTCTRL'], true) -- Disable going stealth

			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle

			if IsEntityPlayingAnim(playerPed, 'mp_arresting', 'idle', 3) ~= 1 then
				ESX.Streaming.RequestAnimDict('mp_arresting', function()
					TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0.0, false, false, false)
				end)
			end
		else
			Citizen.Wait(1500)
		end
	end
end)

-- Create blips
Citizen.CreateThread(function()

	for k,v in pairs(Config.PoliceStations) do
		local blip = AddBlipForCoord(v.Blip.Coords)

		SetBlipSprite (blip, v.Blip.Sprite)
		SetBlipDisplay(blip, v.Blip.Display)
		SetBlipScale  (blip, v.Blip.Scale)
		SetBlipColour (blip, v.Blip.Colour)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('map_blip'))
		EndTextCommandSetBlipName(blip)
	end

end)

-- Display markers
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		if PlayerData.job ~= nil and PlayerData.job.name == 'wilson' then

			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			local isInMarker, hasExited, letSleep = false, false, true
			local currentStation, currentPart, currentPartNum

			for k,v in pairs(Config.PoliceStations) do

				for i=1, #v.Cloakrooms, 1 do
					local distance = GetDistanceBetweenCoords(coords, v.Cloakrooms[i], true)

					if distance < Config.DrawDistance then
						DrawMarker(20, v.Cloakrooms[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						letSleep = false
					end

					if distance < Config.MarkerSize.x then
						isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Cloakroom', i
					end
				end

				for i=1, #v.Armories, 1 do
					local distance = GetDistanceBetweenCoords(coords, v.Armories[i], true)

					if distance < Config.DrawDistance then
						DrawMarker(21, v.Armories[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						letSleep = false
					end

					if distance < Config.MarkerSize.x then
						isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Armory', i
					end
				end

				for i=1, #v.Vehicles, 1 do
					local distance = GetDistanceBetweenCoords(coords, v.Vehicles[i].Spawner, true)

					if distance < Config.DrawDistance then
						DrawMarker(36, v.Vehicles[i].Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						letSleep = false
					end

					if distance < Config.MarkerSize.x then
						isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Vehicles', i
					end
				end

				for i=1, #v.Helicopters, 1 do
					local distance =  GetDistanceBetweenCoords(coords, v.Helicopters[i].Spawner, true)

					if distance < Config.DrawDistance then
						DrawMarker(34, v.Helicopters[i].Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
						letSleep = false
					end

					if distance < Config.MarkerSize.x then
						isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Helicopters', i
					end
				end

				if Config.EnablePlayerManagement and PlayerData.job.grade_name == 'boss' then
					for i=1, #v.BossActions, 1 do
						local distance = GetDistanceBetweenCoords(coords, v.BossActions[i], true)

						if distance < Config.DrawDistance then
							DrawMarker(22, v.BossActions[i], 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, true, false, false, false)
							letSleep = false
						end

						if distance < Config.MarkerSize.x then
							isInMarker, currentStation, currentPart, currentPartNum = true, k, 'BossActions', i
						end
					end
				end
			end

			if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then
	
				if
					(LastStation ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
					(LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
				then
					TriggerEvent('aedb8481-8911-438b-8ddc-aefe132d2e3e', LastStation, LastPart, LastPartNum)
					hasExited = true
				end

				HasAlreadyEnteredMarker = true
				LastStation             = currentStation
				LastPart                = currentPart
				LastPartNum             = currentPartNum

				TriggerEvent('fa4a2b69-4cd3-432b-9a41-e9e16ced0ade', currentStation, currentPart, currentPartNum)

			end

			if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('aedb8481-8911-438b-8ddc-aefe132d2e3e', LastStation, LastPart, LastPartNum)
			end

			if letSleep then
				Citizen.Wait(2000)
			end

		else
			Citizen.Wait(2000)
		end

	end
end)

-- Enter / Exit entity zone events
Citizen.CreateThread(function()
	local trackedEntities = {
		'prop_roadcone02a',
		'prop_barrier_work06a',
	}

	while true do
		Citizen.Wait(1000)

		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		local closestDistance = -1
		local closestEntity   = nil

		for i=1, #trackedEntities, 1 do
			local object = GetClosestObjectOfType(coords, 3.0, GetHashKey(trackedEntities[i]), false, false, false)

			if DoesEntityExist(object) then
				local objCoords = GetEntityCoords(object)
				local distance  = GetDistanceBetweenCoords(coords, objCoords, true)

				if closestDistance == -1 or closestDistance > distance then
					closestDistance = distance
					closestEntity   = object
				end
			end
		end

		if closestDistance ~= -1 and closestDistance <= 3.0 then
			if LastEntity ~= closestEntity then
				TriggerEvent('e9743b8c-c39e-47b2-a9bb-77103fff9b58', closestEntity)
				LastEntity = closestEntity
			end
		else
			Citizen.Wait(1000)
			if LastEntity ~= nil then
				TriggerEvent('bb6a8129-8671-4205-a2fc-b349f7d62ef7', LastEntity)
				LastEntity = nil
			end
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)
		if PlayerData.job ~= nil and PlayerData.job.name == 'wilson' then
			if CurrentAction ~= nil then
				ESX.ShowHelpNotification(CurrentActionMsg)

				if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'wilson' then

					if CurrentAction == 'menu_cloakroom' then
						OpenCloakroomMenu()
					elseif CurrentAction == 'menu_armory' then
						if Config.MaxInService == -1 then
							OpenArmoryMenu(CurrentActionData.station)
						elseif playerInService then
							OpenArmoryMenu(CurrentActionData.station)
						else
							ESX.ShowNotification(_U('service_not'))
						end
					elseif CurrentAction == 'menu_vehicle_spawner' then
						if Config.MaxInService == -1 then
							OpenVehicleSpawnerMenu('car', CurrentActionData.station, CurrentActionData.part, CurrentActionData.partNum)
						elseif playerInService then
							OpenVehicleSpawnerMenu('car', CurrentActionData.station, CurrentActionData.part, CurrentActionData.partNum)
						else
							ESX.ShowNotification(_U('service_not'))
						end
					elseif CurrentAction == 'Helicopters' then
						if Config.MaxInService == -1 then
							OpenVehicleSpawnerMenu('helicopter', CurrentActionData.station, CurrentActionData.part, CurrentActionData.partNum)
						elseif playerInService then
							OpenVehicleSpawnerMenu('helicopter', CurrentActionData.station, CurrentActionData.part, CurrentActionData.partNum)
						else
							ESX.ShowNotification(_U('service_not'))
						end
					elseif CurrentAction == 'delete_vehicle' then
						ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
					elseif CurrentAction == 'menu_boss_actions' then
						ESX.UI.Menu.CloseAll()
						print('asked to open boss menu')
						TriggerEvent('9878e951-0ff0-4996-be7e-f0eb7c427247', 'wilson', function(data, menu)
							menu.close()

							CurrentAction     = 'menu_boss_actions'
							CurrentActionMsg  = _U('open_bossmenu')
							CurrentActionData = {}
						end, { wash = false }) -- disable washing money
					elseif CurrentAction == 'remove_entity' then
						DeleteEntity(CurrentActionData.entity)
					end
					
					CurrentAction = nil
				end
			end -- CurrentAction end
			
			if IsControlJustReleased(0, Keys['F6']) and not isDead and PlayerData.job ~= nil and PlayerData.job.name == 'wilson' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'wilson_actions') then
				if Config.MaxInService == -1 then
					OpenWilsonActionsMenu()
				elseif playerInService then
					OpenWilsonActionsMenu()
				else
					ESX.ShowNotification(_U('service_not'))
				end
			end
			
			if IsControlJustReleased(0, Keys['E']) and CurrentTask.Busy then
				ESX.ShowNotification(_U('impound_canceled'))
				ESX.ClearTimeout(CurrentTask.Task)
				ClearPedTasks(PlayerPedId())
				
				CurrentTask.Busy = false
			end
		
		else
			Wait(2000)
		end
	end
end)

-- Create blip for colleagues
function createBlip(id)
	local ped = GetPlayerPed(id)
	local blip = GetBlipFromEntity(ped)

	if not DoesBlipExist(blip) then -- Add blip and create head display on player
		blip = AddBlipForEntity(ped)
		SetBlipSprite(blip, 1)
		ShowHeadingIndicatorOnBlip(blip, true) -- Player Blip indicator
		SetBlipRotation(blip, math.ceil(GetEntityHeading(ped))) -- update rotation
		SetBlipNameToPlayerName(blip, id) -- update blip name
		SetBlipScale(blip, 0.85) -- set scale
		SetBlipAsShortRange(blip, true)
		
		table.insert(blipsCops, blip) -- add blip to array so we can remove it later
	end
end



RegisterNetEvent('14b6d3ed-7d85-4cde-abe7-b0936919371f')
AddEventHandler('14b6d3ed-7d85-4cde-abe7-b0936919371f', function()
	
	-- Refresh all blips
	for k, existingBlip in pairs(blipsCops) do
		RemoveBlip(existingBlip)
	end
	
	-- Clean the blip table
	blipsCops = {}

	-- Enable blip?
	if Config.MaxInService ~= -1 and not playerInService then
		return
	end

	if not Config.EnableJobBlip then
		return
	end
	
	-- Is the player a cop? In that case show all the blips for other cops
	if PlayerData.job ~= nil and PlayerData.job.name == 'wilson' then
		--[[
		ESX.TriggerServerCallback('330c527c-aeb0-4ff0-89f8-6b3afde4233e', function(players)
			for i=1, #players, 1 do
				if players[i].job.name == 'wilson' then
					local id = GetPlayerFromServerId(players[i].source)
					if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
						createBlip(id)
					end
				end
			end
		end)--]]
	end

end)

AddEventHandler('880c0a93-b305-46b3-b84c-a120fee9e841', function(spawn)
	isDead = false
	TriggerEvent('73883592-76fa-49c3-8bdf-89c7d3a0126b')
	
	if not hasAlreadyJoined then
		TriggerServerEvent('f6bf3091-6c7d-4452-9d89-1fefff87a629')
	end
	hasAlreadyJoined = true
end)

AddEventHandler('2df4c490-68a8-4c7e-896a-9fc552e16210', function(data)
	isDead = true
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('73883592-76fa-49c3-8bdf-89c7d3a0126b')
		TriggerEvent('c8302cb8-8e30-43a6-b648-9ad9d3cd8ee9', 'wilson')

		if Config.MaxInService ~= -1 then
			TriggerServerEvent('a91f16e6-8b39-4118-b7d3-68f32f337985', 'wilson')
		end

		if Config.EnableHandcuffTimer and HandcuffTimer.Active then
			ESX.ClearTimeout(HandcuffTimer.Task)
		end
	end
end)

-- handcuff timer, unrestrain the player after an certain amount of time
function StartHandcuffTimer()
	if Config.EnableHandcuffTimer and HandcuffTimer.Active then
		ESX.ClearTimeout(HandcuffTimer.Task)
	end

	HandcuffTimer.Active = true

	HandcuffTimer.Task = ESX.SetTimeout(Config.HandcuffTimer, function()
		ESX.ShowNotification(_U('unrestrained_timer'))
		TriggerEvent('73883592-76fa-49c3-8bdf-89c7d3a0126b')
		HandcuffTimer.Active = false
	end)
end

-- TODO
--   - return to garage if owned
--   - message owner that his vehicle has been impounded
function ImpoundVehicle(vehicle)
	--local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
	ESX.Game.DeleteVehicle(vehicle) 
	ESX.ShowNotification(_U('impound_successful'))
	CurrentTask.Busy = false
end
