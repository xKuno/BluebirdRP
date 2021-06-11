local HasAlreadyEnteredMarker, LastZone = false, nil
local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local CurrentlyTowedVehicle, Blips, NPCOnJob, NPCTargetTowable, NPCTargetTowableZone = nil, {}, false, nil, nil
local NPCHasSpawnedTowable, NPCLastCancel, NPCHasBeenNextToTowable, NPCTargetDeleterZone = false, GetGameTimer() - 5 * 60000, false, false
local isDead, isBusy = false, false

ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
end)

function SelectRandomTowable()
	local index = GetRandomIntInRange(1,  #Config.Towables)

	for k,v in pairs(Config.Zones) do
		if v.Pos.x == Config.Towables[index].x and v.Pos.y == Config.Towables[index].y and v.Pos.z == Config.Towables[index].z then
			return k
		end
	end
end

function StartNPCJob()
	NPCOnJob = true

	NPCTargetTowableZone = SelectRandomTowable()
	local zone       = Config.Zones[NPCTargetTowableZone]

	Blips['NPCTargetTowableZone'] = AddBlipForCoord(zone.Pos.x,  zone.Pos.y,  zone.Pos.z)
	SetBlipRoute(Blips['NPCTargetTowableZone'], true)

	ESX.ShowNotification(_U('drive_to_indicated'))
end

function StopNPCJob(cancel)
	if Blips['NPCTargetTowableZone'] then
		RemoveBlip(Blips['NPCTargetTowableZone'])
		Blips['NPCTargetTowableZone'] = nil
	end

	if Blips['NPCDelivery'] then
		RemoveBlip(Blips['NPCDelivery'])
		Blips['NPCDelivery'] = nil
	end

	Config.Zones.VehicleDelivery.Type = -1

	NPCOnJob                = false
	NPCTargetTowable        = nil
	NPCTargetTowableZone    = nil
	NPCHasSpawnedTowable    = false
	NPCHasBeenNextToTowable = false

	if cancel then
		ESX.ShowNotification(_U('mission_canceled'))
	else
		--TriggerServerEvent('esx_wolfconstruction:onNPCJobCompleted')
	end
end

function OpenwolfcActions2Menu()
	local elements = {

	}

	if Config.EnablePlayerManagement and ESX.PlayerData.job and ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'wolfc_actions', {
		title    = _U('wolfc2'),
		align    = 'right',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'vehicle_list' then
			if Config.EnableSocietyOwnedVehicles then

				local elements = {}

				ESX.TriggerServerCallback('8def0e18-67f6-4500-a5e2-6e16aee4eb00', function(vehicles)
					for i=1, #vehicles, 1 do
						table.insert(elements, {
							label = GetDisplayNameFromVehicleModel(vehicles[i].model) .. ' [' .. vehicles[i].plate .. ']',
							value = vehicles[i]
						})
					end

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner', {
						title    = _U('service_vehicle'),
						align    = 'right',
						elements = elements
					}, function(data, menu)
						menu.close()
						local vehicleProps = data.current.value

						ESX.Game.SpawnVehicle(vehicleProps.model, Config.Zones.VehicleSpawnPoint.Pos, 270.0, function(vehicle)
							ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
							local playerPed = PlayerPedId()
							TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
						end)

						TriggerServerEvent('293760c8-b5e2-4800-bc04-944c4b572970', 'wolfc', vehicleProps)
					end, function(data, menu)
						menu.close()
					end)
				end, 'wolfc')

			else

				local elements = {
				
				}

				if  ESX.PlayerData.job and (ESX.PlayerData.job.grade_name == 'recrue') then
					table.insert(elements, {label = '⚠️ ONLY USE CERTIFIED VEHICLES ⚠️', value = ''})
					table.insert(elements, {label = '⚠️ REMEMBER TO GET AUTHORISATION ⚠️', value = ''})
end
				if  ESX.PlayerData.job and (ESX.PlayerData.job.grade_name == 'novice') then
					table.insert(elements, {label = '⚠️ ONLY USE CERTIFIED VEHICLES ⚠️', value = ''})
					table.insert(elements, {label = '⚠️ REMEMBER TO GET AUTHORISATION ⚠️', value = ''})
end
				if  ESX.PlayerData.job and (ESX.PlayerData.job.grade_name == 'experimente') then
					table.insert(elements, {label = '⚠️ ONLY USE CERTIFIED VEHICLES ⚠️', value = ''})
					table.insert(elements, {label = '⚠️ REMEMBER TO GET AUTHORISATION ⚠️', value = ''})
end
				if  ESX.PlayerData.job and (ESX.PlayerData.job.grade_name == 'chief') then
					table.insert(elements, {label = '⚠️ ONLY USE CERTIFIED VEHICLES ⚠️', value = ''})
					table.insert(elements, {label = '⚠️ REMEMBER TO GET AUTHORISATION ⚠️', value = ''})

				end

				if Config.EnablePlayerManagement and ESX.PlayerData.job and (ESX.PlayerData.job.grade_name == 'boss') then
					table.insert(elements, {label = '⚠️ ONLY USE CERTIFIED VEHICLES ⚠️', value = ''})
					table.insert(elements, {label = '⚠️ REMEMBER TO GET AUTHORISATION ⚠️', value = ''})

				end

				ESX.UI.Menu.CloseAll()

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_vehicle', {
					title    = _U('service_vehicle'),
					align    = 'right',
					elements = elements
				}, function(data, menu)
					if Config.MaxInService == -1 then
						ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 176.77, function(vehicle)
							local playerPed = PlayerPedId()
							TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
						end)
					else
						ESX.TriggerServerCallback('5ec18406-b92f-414f-8d90-64a53778ed0d', function(canTakeService, maxInService, inServiceCount)
							if canTakeService then
								ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 176.77, function(vehicle)
									local playerPed = PlayerPedId()
									TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
								end)
							else
								ESX.ShowNotification(_U('service_full') .. inServiceCount .. '/' .. maxInService)
							end
						end, 'wolfc')
					end

					menu.close()
				end, function(data, menu)
					menu.close()
					OpenwolfcActions2Menu()
				end)

			end
		elseif data.current.value == 'cloakroom' then
			menu.close()
			ESX.TriggerServerCallback('4568d939-3661-4833-ae6a-378432ac6ff1', function(skin, jobSkin)
				if skin.sex == 0 then
					TriggerEvent('1d09cf94-2c53-4220-a089-0339ce8bb123', skin, jobSkin.skin_male)
				else
					TriggerEvent('1d09cf94-2c53-4220-a089-0339ce8bb123', skin, jobSkin.skin_female)
				end
			end)
		elseif data.current.value == 'cloakroom2' then
			menu.close()
			ESX.TriggerServerCallback('4568d939-3661-4833-ae6a-378432ac6ff1', function(skin, jobSkin)
				TriggerEvent('56a2ee13-8a49-4ad3-a298-1854493c98ee', skin)
			end)
		elseif data.current.value == 'put_stock' then
			OpenPutStocksMenu()
		elseif data.current.value == 'get_stock' then
			OpenGetStocksMenu()
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('9878e951-0ff0-4996-be7e-f0eb7c427247', 'wolfc', function(data, menu)
				menu.close()
			end)
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'wolfc_actions_menu2'
		CurrentActionMsg  = _U('open_actions')
		CurrentActionData = {}
	end)
end

function OpenwolfcActionsMenu()


	local elements = {
		{label = _U('vehicle_list'),   value = 'vehicle_list'},
	}



	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'wolfc_actions', {
		title    = _U('wolfc'),
		align    = 'right',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'vehicle_list' then
			if Config.EnableSocietyOwnedVehicles then

				local elements = {}

				ESX.TriggerServerCallback('8def0e18-67f6-4500-a5e2-6e16aee4eb00', function(vehicles)
					for i=1, #vehicles, 1 do
						table.insert(elements, {
							label = GetDisplayNameFromVehicleModel(vehicles[i].model) .. ' [' .. vehicles[i].plate .. ']',
							value = vehicles[i]
						})
					end

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_spawner', {
						title    = _U('service_vehicle'),
						align    = 'right',
						elements = elements
					}, function(data, menu)
						menu.close()
						local vehicleProps = data.current.value

						ESX.Game.SpawnVehicle(vehicleProps.model, Config.Zones.VehicleSpawnPoint.Pos, 270.0, function(vehicle)
							ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
							local playerPed = PlayerPedId()
							TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
						end)

						TriggerServerEvent('293760c8-b5e2-4800-bc04-944c4b572970', 'wolfc', vehicleProps)
					end, function(data, menu)
						menu.close()
					end)
				end, 'wolfc')

			else

				local elements = {
				
				}

				if  ESX.PlayerData.job and (ESX.PlayerData.job.grade_name == 'recrue') then
					table.insert(elements, {label = '⚠️ ONLY USE CERTIFIED VEHICLES ⚠️', value = ''})
					table.insert(elements, {label = '⚠️ REMEMBER TO GET AUTHORISATION ⚠️', value = ''})

					table.insert(elements, {label = '', value = ''})

					table.insert(elements, {label = 'F650 tipper', value = 'razerdump'})
					table.insert(elements, {label = 'Tradie Ute', value = 'utillitruck3'})
					table.insert(elements, {label = 'Cat 660 Dump', value = 'ct660dump'})

				end
				if  ESX.PlayerData.job and (ESX.PlayerData.job.grade_name == 'novice') then
					table.insert(elements, {label = '⚠️ ONLY USE CERTIFIED VEHICLES ⚠️', value = ''})
					table.insert(elements, {label = '⚠️ REMEMBER TO GET AUTHORISATION ⚠️', value = ''})

					table.insert(elements, {label = 'MAN Prime Mover', value = 'man'})
					table.insert(elements, {label = '40 ft box trailer (use wolf livery)', value = 'trailerswb2'})
					table.insert(elements, {label = '20 ft box trailer (use wolf livery)', value = 'trailerswb'})
					table.insert(elements, {label = '40 ft General Freight trailer', value = 'boxlongtr'})
					table.insert(elements, {label = 'Shipping Container Carrier', value = 'docktrailer2'})
					table.insert(elements, {label = 'Dry Bulk', value = 'drybulktr'})
					table.insert(elements, {label = 'Semi Tipper', value = 'dumptr'})
					table.insert(elements, {label = 'Liquid Gas trailer', value = 'gastr'})
					table.insert(elements, {label = 'flatbed trailer with frieght', value = 'trflat2'})				
					
					table.insert(elements, {label = 'Cat 660', value = 'ct660'})
                                        table.insert(elements, {label = 'Cat 660 Dump', value = 'ct660dump'})
					table.insert(elements, {label = 'F650 tipper', value = 'razerdump'})
					table.insert(elements, {label = 'Forklift', value = 'forklift'})
					table.insert(elements, {label = 'Tradie Ute', value = 'utillitruck3'})
					table.insert(elements, {label = 'Tradie Van', value = 'boxville'})
					table.insert(elements, {label = 'Cat 660 Dump', value = 'ct660dump'})

				end
				if  ESX.PlayerData.job and (ESX.PlayerData.job.grade_name == 'experimente') then
					table.insert(elements, {label = '⚠️ ONLY USE CERTIFIED VEHICLES ⚠️', value = ''})
					table.insert(elements, {label = '⚠️ REMEMBER TO GET AUTHORISATION ⚠️', value = ''})
					
					table.insert(elements, {label = 'MAN Prime Mover', value = 'man'})
					table.insert(elements, {label = '40 ft box trailer (use wolf livery)', value = 'trailerswb2'})
					table.insert(elements, {label = '20 ft box trailer (use wolf livery)', value = 'trailerswb'})
					table.insert(elements, {label = '40 ft General Freight trailer', value = 'boxlongtr'})
					table.insert(elements, {label = 'Shipping Container Carrier', value = 'docktrailer2'})
					table.insert(elements, {label = 'Dry Bulk', value = 'drybulktr'})
					table.insert(elements, {label = 'Semi Tipper', value = 'dumptr'})
					table.insert(elements, {label = 'Liquid Gas trailer', value = 'gastr'})
					table.insert(elements, {label = 'flatbed trailer with frieght', value = 'trflat2'})	
										table.insert(elements, {label = 'Water Truck', value = 'bcfd5'})
					table.insert(elements, {label = 'Large Flatbed Trailer', value = 'armytrailer'})
					table.insert(elements, {label = 'Excavator', value = 'excavator'})
					table.insert(elements, {label = 'Bobcat', value = 'cat259'})
					table.insert(elements, {label = 'Cat 660', value = 'ct660'})
                                        table.insert(elements, {label = 'Cat 660 Dump', value = 'ct660dump'})
					table.insert(elements, {label = 'D7 Dozer', value = 'd7r'})
					table.insert(elements, {label = 'Cat Grader', value = 'motorgrader'})
					table.insert(elements, {label = 'F650 tipper', value = 'razerdump'})
					table.insert(elements, {label = 'Tracked Loader', value = 'bulldozer'})
					table.insert(elements, {label = 'Forklift', value = 'forklift'})
					table.insert(elements, {label = 'Tradie Ute', value = 'utillitruck3'})
					table.insert(elements, {label = 'Flatbed Trailer', value = 'trflat'})
					table.insert(elements, {label = 'Kenworth w900', value = 'w900'})
                                        table.insert(elements, {label = 'Lowboy Trailer', value = 'lowboy'})
                                        table.insert(elements, {label = 'Lowboy Trailer dolley', value = 'lowboyjeep'})
					table.insert(elements, {label = 'Tradie Van', value = 'boxville'})
					table.insert(elements, {label = '16 Ton Roller', value = 'worktruck'})



				end
				if  ESX.PlayerData.job and (ESX.PlayerData.job.grade_name == 'chief') then
					table.insert(elements, {label = '⚠️ ONLY USE CERTIFIED VEHICLES ⚠️', value = ''})
					table.insert(elements, {label = '⚠️ REMEMBER TO GET AUTHORISATION ⚠️', value = ''})

					table.insert(elements, {label = '', value = ''})


				end

				if Config.EnablePlayerManagement and ESX.PlayerData.job and (ESX.PlayerData.job.grade_name == 'boss') then
					table.insert(elements, {label = '⚠️ ONLY USE CERTIFIED VEHICLES ⚠️', value = ''})
					table.insert(elements, {label = '⚠️ REMEMBER TO GET AUTHORISATION ⚠️', value = ''})

					table.insert(elements, {label = '', value = ''})
					table.insert(elements, {label = 'Noahs ute', value = 'tundra'})
					table.insert(elements, {label = 'Work/Manager Ute', value = 'wcp002'})
					table.insert(elements, {label = 'Large Flatbed Trailer', value = 'armytrailer'})
					table.insert(elements, {label = 'Excavator', value = 'excavator'})
					table.insert(elements, {label = 'Bobcat', value = 'cat259'})
					table.insert(elements, {label = 'Cat 660', value = 'ct660'})
                                        table.insert(elements, {label = 'Cat 660 Dump', value = 'ct660dump'})
					table.insert(elements, {label = 'D7 Dozer', value = 'd7r'})
					table.insert(elements, {label = 'Cat Grader', value = 'motorgrader'})
					table.insert(elements, {label = 'F650 tipper', value = 'razerdump'})
					table.insert(elements, {label = 'Tracked Loader', value = 'bulldozer'})
					table.insert(elements, {label = 'Forklift', value = 'forklift'})
					table.insert(elements, {label = 'Tradie Ute', value = 'utillitruck3'})
					table.insert(elements, {label = 'Flatbed Trailer', value = 'trflat'})
					table.insert(elements, {label = 'Kenworth w900', value = 'w900'})
                                        table.insert(elements, {label = 'Lowboy Trailer', value = 'lowboy'})
                                        table.insert(elements, {label = 'Lowboy Trailer dolley', value = 'lowboyjeep'})
					table.insert(elements, {label = 'Tradie Van', value = 'boxville'})
					table.insert(elements, {label = '16 Ton Roller', value = 'worktruck'})
										table.insert(elements, {label = 'MAN Prime Mover', value = 'man'})
					table.insert(elements, {label = '40 ft box trailer (use wolf livery)', value = 'trailerswb2'})
					table.insert(elements, {label = '20 ft box trailer (use wolf livery)', value = 'trailerswb'})
					table.insert(elements, {label = '40 ft General Freight trailer', value = 'boxlongtr'})
					table.insert(elements, {label = 'Shipping Container Carrier', value = 'docktrailer2'})
					table.insert(elements, {label = 'Dry Bulk', value = 'drybulktr'})
					table.insert(elements, {label = 'Semi Tipper', value = 'dumptr'})
					table.insert(elements, {label = 'Liquid Gas trailer', value = 'gastr'})
					table.insert(elements, {label = 'flatbed trailer with frieght', value = 'trflat2'})	
										table.insert(elements, {label = 'Water Truck', value = 'bcfd5'})






				end

				ESX.UI.Menu.CloseAll()

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_vehicle', {
					title    = _U('service_vehicle'),
					align    = 'right',
					elements = elements
				}, function(data, menu)
					if Config.MaxInService == -1 then
						ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 176.77, function(vehicle)
							local playerPed = PlayerPedId()
							TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
						end)
					else
						ESX.TriggerServerCallback('5ec18406-b92f-414f-8d90-64a53778ed0d', function(canTakeService, maxInService, inServiceCount)
							if canTakeService then
								ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 176.77, function(vehicle)
									local playerPed = PlayerPedId()
									TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
								end)
							else
								ESX.ShowNotification(_U('service_full') .. inServiceCount .. '/' .. maxInService)
							end
						end, 'wolfc')
					end

					menu.close()
				end, function(data, menu)
					menu.close()
					OpenwolfcActionsMenu()
				end)

			end
		elseif data.current.value == 'cloakroom' then
			menu.close()
			ESX.TriggerServerCallback('4568d939-3661-4833-ae6a-378432ac6ff1', function(skin, jobSkin)
				if skin.sex == 0 then
					TriggerEvent('1d09cf94-2c53-4220-a089-0339ce8bb123', skin, jobSkin.skin_male)
				else
					TriggerEvent('1d09cf94-2c53-4220-a089-0339ce8bb123', skin, jobSkin.skin_female)
				end
			end)
		elseif data.current.value == 'cloakroom2' then
			menu.close()
			ESX.TriggerServerCallback('4568d939-3661-4833-ae6a-378432ac6ff1', function(skin, jobSkin)
				TriggerEvent('56a2ee13-8a49-4ad3-a298-1854493c98ee', skin)
			end)
		elseif data.current.value == 'put_stock' then
			OpenPutStocksMenu()
		elseif data.current.value == 'get_stock' then
			OpenGetStocksMenu()
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('9878e951-0ff0-4996-be7e-f0eb7c427247', 'wolfc', function(data, menu)
				menu.close()
			end)
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'wolfc_actions_menu'
		CurrentActionMsg  = _U('open_actions')
		CurrentActionData = {}
	end)
end

function OpenwolfcHarvestMenu()
	if Config.EnablePlayerManagement and ESX.PlayerData.job and ESX.PlayerData.job.grade_name ~= 'recrue' then
		local elements = {
			{label = _U('repair_tools'), value = 'fix_tool'},
			{label = _U('body_work_tools'), value = 'caro_tool'}
		}

		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'wolfc_harvest', {
			title    = _U('harvest'),
			align    = 'right',
			elements = elements
		}, function(data, menu)
			menu.close()

			if data.current.value == 'gaz_bottle' then
				TriggerServerEvent('2a058639-64ec-444c-b4f0-b777824ad823')
			elseif data.current.value == 'fix_tool' then
				TriggerServerEvent('141e3d2d-d920-4588-bb42-718ee66fda43')
			elseif data.current.value == 'caro_tool' then
				TriggerServerEvent('51195e8e-21ea-49be-8243-35591b74e217')
			end
		end, function(data, menu)
			menu.close()
			CurrentAction     = 'wolfc_harvest_menu'
			CurrentActionMsg  = _U('harvest_menu')
			CurrentActionData = {}
		end)
	else
		ESX.ShowNotification(_U('not_experienced_enough'))
	end
end

function OpenwolfcCraftMenu()
	if Config.EnablePlayerManagement and ESX.PlayerData.job and ESX.PlayerData.job.grade_name ~= 'recrue' then
		local elements = {
			{label = _U('repair_kit'), value = 'fix_kit'},
			{label = _U('body_kit'),   value = 'caro_kit'}
		}

		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'wolfc_craft', {
			title    = _U('craft'),
			align    = 'right',
			elements = elements
		}, function(data, menu)
			menu.close()

			if data.current.value == 'blow_pipe' then
				TriggerServerEvent('57300b7f-e267-4081-b6be-f9bbd6a9c619')
			elseif data.current.value == 'fix_kit' then
				TriggerServerEvent('5032443c-c9f6-48f1-b355-bd4717ce6f39')
			elseif data.current.value == 'caro_kit' then
				TriggerServerEvent('ee798fa3-a5bf-44b9-ac0e-01631486c292')
			end
		end, function(data, menu)
			menu.close()

			CurrentAction     = 'wolfc_craft_menu'
			CurrentActionMsg  = _U('craft_menu')
			CurrentActionData = {}
		end)
	else
		ESX.ShowNotification(_U('not_experienced_enough'))
	end
end

function OpenMobilewolfcActionsMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_wolfc_actions', {
		title    = _U('wolfc'),
		align    = 'right',
		elements = {
			{label = _U('billing'),       value = 'billing'},
			{label = _U('clean'),         value = 'clean_vehicle'},
			{label = _U('repair'),        value = 'fix_vehicle'},
			{label = _U('place_objects'), value = 'object_spawner'},
	}}, function(data, menu)
		if isBusy then return end

		if data.current.value == 'billing' then
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'billing', {
				title = _U('invoice_amount')
			}, function(data, menu)
				local amount = tonumber(data.value)

				if amount == nil or amount < 0 then
					ESX.ShowNotification(_U('amount_invalid'))
				else
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					if closestPlayer == -1 or closestDistance > 3.0 then
						ESX.ShowNotification(_U('no_players_nearby'))
					else
						menu.close()
						TriggerServerEvent('c9ac0436-8b83-467d-abe5-4978cdf78f9b', GetPlayerServerId(closestPlayer), 'society_wolfc', _U('wolfc'), amount)
					end
				end
			end, function(data, menu)
				menu.close()
			end)
		elseif data.current.value == 'hijack_vehicle' then
			local playerPed = PlayerPedId()
			local vehicle   = ESX.Game.GetVehicleInDirection()
			local coords    = GetEntityCoords(playerPed)

			if IsPedSittingInAnyVehicle(playerPed) then
				ESX.ShowNotification(_U('inside_vehicle'))
				return
			end

			if DoesEntityExist(vehicle) then
				isBusy = true
				TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
				Citizen.CreateThread(function()
					Citizen.Wait(10000)

					SetVehicleDoorsLocked(vehicle, 1)
					SetVehicleDoorsLockedForAllPlayers(vehicle, false)
					ClearPedTasksImmediately(playerPed)

					ESX.ShowNotification(_U('vehicle_unlocked'))
					isBusy = false
				end)
			else
				ESX.ShowNotification(_U('no_vehicle_nearby'))
			end
		elseif data.current.value == 'fix_vehicle' then
			local playerPed = PlayerPedId()
			local vehicle   = ESX.Game.GetVehicleInDirection()
			local coords    = GetEntityCoords(playerPed)

			if IsPedSittingInAnyVehicle(playerPed) then
				ESX.ShowNotification(_U('inside_vehicle'))
				return
			end

			if DoesEntityExist(vehicle) then
				isBusy = true
				TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
				Citizen.CreateThread(function()
					Citizen.Wait(20000)

					SetVehicleFixed(vehicle)
					SetVehicleDeformationFixed(vehicle)
					SetVehicleUndriveable(vehicle, false)
					SetVehicleEngineOn(vehicle, true, true)
					ClearPedTasksImmediately(playerPed)

					ESX.ShowNotification(_U('vehicle_repaired'))
					isBusy = false
				end)
			else
				ESX.ShowNotification(_U('no_vehicle_nearby'))
			end
		elseif data.current.value == 'clean_vehicle' then
			local playerPed = PlayerPedId()
			local vehicle   = ESX.Game.GetVehicleInDirection()
			local coords    = GetEntityCoords(playerPed)

			if IsPedSittingInAnyVehicle(playerPed) then
				ESX.ShowNotification(_U('inside_vehicle'))
				return
			end

			if DoesEntityExist(vehicle) then
				isBusy = true
				TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_MAID_CLEAN', 0, true)
				Citizen.CreateThread(function()
					Citizen.Wait(10000)

					SetVehicleDirtLevel(vehicle, 0)
					ClearPedTasksImmediately(playerPed)

					ESX.ShowNotification(_U('vehicle_cleaned'))
					isBusy = false
				end)
			else
				ESX.ShowNotification(_U('no_vehicle_nearby'))
			end
		elseif data.current.value == 'del_vehicle' then
			local playerPed = PlayerPedId()

			if IsPedSittingInAnyVehicle(playerPed) then
				local vehicle = GetVehiclePedIsIn(playerPed, false)

				if GetPedInVehicleSeat(vehicle, -1) == playerPed then
					ESX.ShowNotification(_U('vehicle_impounded'))
					ESX.Game.DeleteVehicle(vehicle)
				else
					ESX.ShowNotification(_U('must_seat_driver'))
				end
			else
				local vehicle = ESX.Game.GetVehicleInDirection()

				if DoesEntityExist(vehicle) then
					ESX.ShowNotification(_U('vehicle_impounded'))
					ESX.Game.DeleteVehicle(vehicle)
				else
					ESX.ShowNotification(_U('must_near'))
				end
			end
		elseif data.current.value == 'dep_vehicle' then
			local playerPed = PlayerPedId()
			local vehicle = GetVehiclePedIsIn(playerPed, true)

			local towmodel = GetHashKey('flatbed')
			local isVehicleTow = IsVehicleModel(vehicle, towmodel)

			if isVehicleTow then
				local targetVehicle = ESX.Game.GetVehicleInDirection()

				if CurrentlyTowedVehicle == nil then
					if targetVehicle ~= 0 then
						if not IsPedInAnyVehicle(playerPed, true) then
							if vehicle ~= targetVehicle then
								AttachEntityToEntity(targetVehicle, vehicle, 20, -0.5, -5.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
								CurrentlyTowedVehicle = targetVehicle
								ESX.ShowNotification(_U('vehicle_success_attached'))

								if NPCOnJob then
									if NPCTargetTowable == targetVehicle then
										ESX.ShowNotification(_U('please_drop_off'))
										Config.Zones.VehicleDelivery.Type = 1

										if Blips['NPCTargetTowableZone'] then
											RemoveBlip(Blips['NPCTargetTowableZone'])
											Blips['NPCTargetTowableZone'] = nil
										end

										Blips['NPCDelivery'] = AddBlipForCoord(Config.Zones.VehicleDelivery.Pos.x, Config.Zones.VehicleDelivery.Pos.y, Config.Zones.VehicleDelivery.Pos.z)
										SetBlipRoute(Blips['NPCDelivery'], true)
									end
								end
							else
								ESX.ShowNotification(_U('cant_attach_own_tt'))
							end
						end
					else
						ESX.ShowNotification(_U('no_veh_att'))
					end
				else
					AttachEntityToEntity(CurrentlyTowedVehicle, vehicle, 20, -0.5, -12.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
					DetachEntity(CurrentlyTowedVehicle, true, true)

					if NPCOnJob then
						if NPCTargetDeleterZone then

							if CurrentlyTowedVehicle == NPCTargetTowable then
								ESX.Game.DeleteVehicle(NPCTargetTowable)
								TriggerServerEvent('d4a14322-837b-4a43-a92d-188f945cae52')
								StopNPCJob()
								NPCTargetDeleterZone = false
							else
								ESX.ShowNotification(_U('not_right_veh'))
							end

						else
							ESX.ShowNotification(_U('not_right_place'))
						end
					end

					CurrentlyTowedVehicle = nil
					ESX.ShowNotification(_U('veh_det_succ'))
				end
			else
				ESX.ShowNotification(_U('imp_flatbed'))
			end
		elseif data.current.value == 'object_spawner' then
			local playerPed = PlayerPedId()

			if IsPedSittingInAnyVehicle(playerPed) then
				ESX.ShowNotification(_U('inside_vehicle'))
				return
			end

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_wolfc_actions_spawn', {
				title    = _U('objects'),
				align    = 'right',
				elements = {
					{label = '-- CONES --', value = ''},

					{label = 'roadcone', value = 'prop_roadcone02a'},
					{label = 'Post Cone', value = 'prop_mp_cone_04'},
					{label = 'Tall Cone', value = 'prop_roadcone01b'},
					{label = 'Circle Barrier', value = 'prop_barrier_wat_03b'},
					{label = '', value = ''},

					{label = '-- OTHER --', value = ''},

					{label = 'Ramp', value = 'prop_mp_ramp_02'},
					{label = 'toolbox',  value = 'prop_toolchest_01'},
					{label = 'CEMENT BARRIER',  value = 'prop_mp_barrier_01b'},
					{label = 'Right Arrow',  value = 'prop_mp_arrow_barrier_01'},
					{label = 'Temp Fence',  value = 'prop_fncsec_03b'},
					{label = 'Road Work Ahead',  value = 'prop_mp_barrier_02'},
					{label = 'Workmen sign',  value = 'prop_consign_01a'},
					 
					





			}}, function(data2, menu2)
				local model   = data2.current.value
				local coords  = GetEntityCoords(playerPed)
				local forward = GetEntityForwardVector(playerPed)
				local x, y, z = table.unpack(coords + forward * 1.0)

				if model == 'prop_roadcone02a' then
					z = z - 1.0
				elseif model == 'prop_mp_cone_04' then
					z = z - 2.0
				elseif model == 'prop_roadcone01b' then
					z = z - 2.0
				elseif model == 'prop_barrier_wat_03b' then
					z = z - 2.0
				elseif model == 'prop_mp_ramp_02' then
					z = z - 2.0
				elseif model == 'prop_toolchest_01' then
					z = z - 2.0
				elseif model == 'prop_mp_barrier_01b' then
					z = z - 2.0
				elseif model == 'prop_mp_arrow_barrier_01' then
					z = z - 2.0
				elseif model == 'prop_fncsec_03b' then
					z = z - 2.0
				elseif model == 'prop_mp_barrier_02' then
					z = z - 2.0
				elseif model == 'prop_consign_01a' then
					z = z - -2.0

				end

				ESX.Game.SpawnObject(model, {x = x, y = y, z = z }, function(obj)
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

function OpenGetStocksMenu()
	ESX.TriggerServerCallback('49770128-b12d-47fc-b444-9e7b2dfa2c84', function(items)
		local elements = {}

		for i=1, #items, 1 do
			table.insert(elements, {
				label = 'x' .. items[i].count .. ' ' .. items[i].label,
				value = items[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = _U('wolfc_stock'),
			align    = 'right',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('invalid_quantity'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('b8f90785-a39b-4b98-b8de-82ee4aaeccb2', itemName, count)

					Citizen.Wait(1000)
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
	ESX.TriggerServerCallback('32672ec9-9987-453d-a3d8-eeb42f49702d', function(inventory)
		local elements = {}

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

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = _U('inventory'),
			align    = 'right',
			elements = elements
		}, function(data, menu)
			local itemName = data.current.value

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count', {
				title = _U('quantity')
			}, function(data2, menu2)
				local count = tonumber(data2.value)

				if count == nil then
					ESX.ShowNotification(_U('invalid_quantity'))
				else
					menu2.close()
					menu.close()
					TriggerServerEvent('6204c7bd-2ab0-439c-989e-e4dcde671eee', itemName, count)

					Citizen.Wait(1000)
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

RegisterNetEvent('6d16d643-89b2-4f77-9bf7-67cdb26b0ded')
AddEventHandler('6d16d643-89b2-4f77-9bf7-67cdb26b0ded', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		local chance = math.random(100)
		local alarm  = math.random(100)

		if DoesEntityExist(vehicle) then
			if alarm <= 33 then
				SetVehicleAlarm(vehicle, true)
				StartVehicleAlarm(vehicle)
			end

			TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)

			Citizen.CreateThread(function()
				Citizen.Wait(10000)
				if chance <= 66 then
					SetVehicleDoorsLocked(vehicle, 1)
					SetVehicleDoorsLockedForAllPlayers(vehicle, false)
					ClearPedTasksImmediately(playerPed)
					ESX.ShowNotification(_U('veh_unlocked'))
				else
					ESX.ShowNotification(_U('hijack_failed'))
					ClearPedTasksImmediately(playerPed)
				end
			end)
		end
	end
end)

RegisterNetEvent('1d04691c-ebd6-48c1-a5bf-fc1addeb9702')
AddEventHandler('1d04691c-ebd6-48c1-a5bf-fc1addeb9702', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) then
			TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_HAMMERING', 0, true)
			Citizen.CreateThread(function()
				Citizen.Wait(10000)
				SetVehicleFixed(vehicle)
				SetVehicleDeformationFixed(vehicle)
				ClearPedTasksImmediately(playerPed)
				ESX.ShowNotification(_U('body_repaired'))
			end)
		end
	end
end)

RegisterNetEvent('4c13c1a2-0016-4aaf-a97b-d23577e10a3f')
AddEventHandler('4c13c1a2-0016-4aaf-a97b-d23577e10a3f', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end

		if DoesEntityExist(vehicle) then
			TaskStartScenarioInPlace(playerPed, 'PROP_HUMAN_BUM_BIN', 0, true)
			Citizen.CreateThread(function()
				Citizen.Wait(20000)
				SetVehicleFixed(vehicle)
				SetVehicleDeformationFixed(vehicle)
				SetVehicleUndriveable(vehicle, false)
				ClearPedTasksImmediately(playerPed)
				ESX.ShowNotification(_U('veh_repaired'))
			end)
		end
	end
end)

RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(xPlayer)
	ESX.PlayerData = xPlayer
end)

RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function(job)
	ESX.PlayerData.job = job
end)

AddEventHandler('1d974843-cae6-4edb-8d9b-604c30084436', function(zone)
	if zone == 'NPCJobTargetTowable' then

	elseif zone =='VehicleDelivery' then
		NPCTargetDeleterZone = true
	elseif zone == 'wolfcActions' then
		CurrentAction     = 'wolfc_actions_menu'
		CurrentActionMsg  = _U('open_actions')
		CurrentActionData = {}
	elseif zone == 'wolfcActions2' then
		CurrentAction     = 'wolfc_actions_menu2'
		CurrentActionMsg  = _U('open_actions')
		CurrentActionData = {}
	elseif zone == 'Garage' then
		CurrentAction     = 'wolfc_harvest_menu'
		CurrentActionMsg  = _U('harvest_menu')
		CurrentActionData = {}
	elseif zone == 'Craft' then
		CurrentAction     = 'wolfc_craft_menu'
		CurrentActionMsg  = _U('craft_menu')
		CurrentActionData = {}
	elseif zone == 'VehicleDeleter' then
		local playerPed = PlayerPedId()

		if IsPedInAnyVehicle(playerPed, false) then
			local vehicle = GetVehiclePedIsIn(playerPed,  false)

			CurrentAction     = 'delete_vehicle'
			CurrentActionMsg  = _U('veh_stored')
			CurrentActionData = {vehicle = vehicle}
		end
	end
end)

AddEventHandler('fc5b5a36-924f-40b4-b635-7d57e76cc002', function(zone)
	if zone =='VehicleDelivery' then
		NPCTargetDeleterZone = false
	elseif zone == 'Craft' then
		TriggerServerEvent('4aebe592-c60c-434e-8983-615dd688ed51')
		TriggerServerEvent('d852b43e-ca1b-4387-8078-9bfe97ef8749')
		TriggerServerEvent('d2f983e8-e17f-4099-b9e7-6e59bbb7bfa4')
	elseif zone == 'Garage' then
		TriggerServerEvent('887e9e4b-8a4c-4bea-9fa8-f849047bb3de')
		TriggerServerEvent('cfe915e7-37e0-4c8b-b142-1d21de6bbf41')
		TriggerServerEvent('0516b380-4a70-4dda-b681-43443f819858')
	end

	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

AddEventHandler('2f271704-07dc-467c-9c25-490f94a5b1a9', function(entity)
	local playerPed = PlayerPedId()

	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'wolfc' and not IsPedInAnyVehicle(playerPed, false) then
		CurrentAction     = 'remove_entity'
		CurrentActionMsg  = _U('press_remove_obj')
		CurrentActionData = {entity = entity}
	end
end)

AddEventHandler('f4bc1e61-3aa9-4d87-9cf9-e04e83da882b', function(entity)
	if CurrentAction == 'remove_entity' then
		CurrentAction = nil
	end
end)

RegisterNetEvent('59809f17-d8ce-49dd-ae30-d5e90a7761a7')
AddEventHandler('59809f17-d8ce-49dd-ae30-d5e90a7761a7', function(phoneNumber, contacts)
	local specialContact = {
		name       = _U('wolfconstruction'),
		number     = 'wolfconstruction',
		base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEwAACxMBAJqcGAAAA4BJREFUWIXtll9oU3cUx7/nJA02aSSlFouWMnXVB0ejU3wcRteHjv1puoc9rA978cUi2IqgRYWIZkMwrahUGfgkFMEZUdg6C+u21z1o3fbgqigVi7NzUtNcmsac40Npltz7S3rvUHzxQODec87vfD+/e0/O/QFv7Q0beV3QeXqmgV74/7H7fZJvuLwv8q/Xeux1gUrNBpN/nmtavdaqDqBK8VT2RDyV2VHmF1lvLERSBtCVynzYmcp+A9WqT9kcVKX4gHUehF0CEVY+1jYTTIwvt7YSIQnCTvsSUYz6gX5uDt7MP7KOKuQAgxmqQ+neUA+I1B1AiXi5X6ZAvKrabirmVYFwAMRT2RMg7F9SyKspvk73hfrtbkMPyIhA5FVqi0iBiEZMMQdAui/8E4GPv0oAJkpc6Q3+6goAAGpWBxNQmTLFmgL3jSJNgQdGv4pMts2EKm7ICJB/aG0xNdz74VEk13UYCx1/twPR8JjDT8wttyLZtkoAxSb8ZDCz0gdfKxWkFURf2v9qTYH7SK7rQIDn0P3nA0ehixvfwZwE0X9vBE/mW8piohhl1WH18UQBhYnre8N/L8b8xQvlx4ACbB4NnzaeRYDnKm0EALCMLXy84hwuTCXL/ExoB1E7qcK/8NCLIq5HcTT0i6u8TYbXUM1cAyyveVq8Xls7XhYrvY/4n3gC8C+dsmAzL1YUiyfWxvHzsy/w/dNd+KjhW2yvv/RfXr7x9QDcmo1he2RBiCCI1Q8jVj9szPNixVfgz+UiIGyDSrcoRu2J16d3I6e1VYvNSQjXpnucAcEPUOkGYZs/l4uUhowt/3kqu1UIv9n90fAY9jT3YBlbRvFTD4fw++wHjhiTRL/bG75t0jI2ITcHb5om4Xgmhv57xpGOg3d/NIqryOR7z+r+MC6qBJB/ZB2t9Om1D5lFm843G/3E3HI7Yh1xDRAfzLQr5EClBf/HBHK462TG2J0OABXeyWDPZ8VqxmBWYscpyghwtTd4EKpDTjCZdCNmzFM9k+4LHXIFACJN94Z6FiFEpKDQw9HndWsEuhnADVMhAUaYJBp9XrcGQKJ4qFE9k+6r2+MG3k5N8VQ22TVglbX2ZwOzX2VvNKr91zmY6S7N6zqZicVT2WNLyVSehESaBhxnOALfMeYX+K/S2yv7wmMAlvwyuR7FxQUyf0fgc/jztfkJr7XeGgC8BJJgWNV8ImT+AAAAAElFTkSuQmCC'
	}

	TriggerEvent('e25977c9-9f2b-4d5d-a807-a8c7a0c964d5', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

-- Pop NPC mission vehicle when inside area
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'wolfc' then
			if NPCTargetTowableZone and not NPCHasSpawnedTowable then
				local coords = GetEntityCoords(PlayerPedId())
				local zone   = Config.Zones[NPCTargetTowableZone]

				if GetDistanceBetweenCoords(coords, zone.Pos.x, zone.Pos.y, zone.Pos.z, true) < Config.NPCSpawnDistance then
					local model = Config.Vehicles[GetRandomIntInRange(1,  #Config.Vehicles)]

					ESX.Game.SpawnVehicle(model, zone.Pos, 0, function(vehicle)
						NPCTargetTowable = vehicle
					end)

					NPCHasSpawnedTowable = true
				end
			end

			if NPCTargetTowableZone and NPCHasSpawnedTowable and not NPCHasBeenNextToTowable then
				local coords = GetEntityCoords(PlayerPedId())
				local zone   = Config.Zones[NPCTargetTowableZone]

				if GetDistanceBetweenCoords(coords, zone.Pos.x, zone.Pos.y, zone.Pos.z, true) < Config.NPCNextToDistance then
					ESX.ShowNotification(_U('please_tow'))
					NPCHasBeenNextToTowable = true
				end
			end
		else
			Wait(5000)
		end
	end
end)

-- Create Blips
Citizen.CreateThread(function()

	local blip = AddBlipForCoord(Config.Zones.Blip.Pos.x, Config.Zones.Blip.Pos.y, Config.Zones.Blip.Pos.z)
  
	SetBlipSprite (blip, 463)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.5)
	SetBlipColour (blip, 1)
	SetBlipAsShortRange(blip, true)
  
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Wolf Constructions")
	EndTextCommandSetBlipName(blip)
  
  end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'wolfc' then
			local coords, letSleep = GetEntityCoords(PlayerPedId()), true

			for k,v in pairs(Config.Zones) do
				if v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end
			end

			if letSleep then
				Citizen.Wait(500)
			end
		else
			Citizen.Wait(1000)
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'wolfc' then

			local coords      = GetEntityCoords(PlayerPedId())
			local isInMarker  = false
			local currentZone = nil

			for k,v in pairs(Config.Zones) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker  = true
					currentZone = k
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone                = currentZone
				TriggerEvent('1d974843-cae6-4edb-8d9b-604c30084436', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('fc5b5a36-924f-40b4-b635-7d57e76cc002', LastZone)
			end
		else
			Wait(5000)
		end
	end
end)


-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'wolfc' then
			if CurrentAction then
				ESX.ShowHelpNotification(CurrentActionMsg)
				
				if IsControlJustReleased(0, 38) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'wolfc' then

					if CurrentAction == 'wolfc_actions_menu' then
						OpenwolfcActionsMenu()
					elseif CurrentAction == 'wolfc_actions_menu2' then
							OpenwolfcActions2Menu()
					elseif CurrentAction == 'wolfc_harvest_menu' then
						OpenwolfcHarvestMenu()
					elseif CurrentAction == 'wolfc_craft_menu' then
						OpenwolfcCraftMenu()
					elseif CurrentAction == 'delete_vehicle' then

						if Config.EnableSocietyOwnedVehicles then

							local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
							TriggerServerEvent('ee25e8b0-b555-4cd2-b500-24c1cbd32f88', 'wolfc', vehicleProps)

						else

							if
								GetEntityModel(vehicle) == GetHashKey('flatbed')   or
								GetEntityModel(vehicle) == GetHashKey('towtruck2') or
								GetEntityModel(vehicle) == GetHashKey('slamvan3')
							then
								TriggerServerEvent('a91f16e6-8b39-4118-b7d3-68f32f337985', 'wolfc')
							end

						end

						ESX.Game.DeleteVehicle(CurrentActionData.vehicle)

					elseif CurrentAction == 'remove_entity' then
						DeleteEntity(CurrentActionData.entity)
					end

					CurrentAction = nil
				end
			end

			if IsControlJustReleased(0, 167) and not isDead and ESX.PlayerData.job and ESX.PlayerData.job.name == 'wolfc' and ESX.PlayerData.job.grade > 2 then
				OpenMobilewolfcActionsMenu()
			end

			if IsControlJustReleased(0, 178) and not isDead and ESX.PlayerData.job and ESX.PlayerData.job.name == 'wolfc' then
				if NPCOnJob then
					if GetGameTimer() - NPCLastCancel > 5 * 60000 then
						StopNPCJob(true)
						NPCLastCancel = GetGameTimer()
					else
						ESX.ShowNotification(_U('wait_five'))
					end
				else
					local playerPed = PlayerPedId()

					if IsPedInAnyVehicle(playerPed, false) and IsVehicleModel(GetVehiclePedIsIn(playerPed, false), GetHashKey('flatbed')) then
						StartNPCJob()
					else
						ESX.ShowNotification(_U('must_in_flatbed'))
					end
				end
			end
		else
			Wait(5000)
		end
	end
end)

AddEventHandler('2df4c490-68a8-4c7e-896a-9fc552e16210', function(data)
	isDead = true
end)

AddEventHandler('880c0a93-b305-46b3-b84c-a120fee9e841', function(spawn)
	isDead = false
end)
