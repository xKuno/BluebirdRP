local HasAlreadyEnteredMarker, LastZone = false, nil
local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local CurrentlyTowedVehicle, Blips, NPCOnJob, NPCTargetTowable, NPCTargetTowableZone = nil, {}, false, nil, nil
local NPCHasSpawnedTowable, NPCLastCancel, NPCHasBeenNextToTowable, NPCTargetDeleterZone = false, GetGameTimer() - 5 * 60000, false, false
local isDead, isBusy = false, false

ESX = nil

function SetVehicleMaxMods(vehicle)

  local props = {
    modEngine       = 0,
    modBrakes       = 0,
    modTransmission = 0,
    modSuspension   = 0,
    modTurbo        = true,
  }

  ESX.Game.SetVehicleProperties(vehicle, props)

end

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(200)
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
		--TriggerServerEvent('esx_pilot:onNPCJobCompleted')
	end
end

function OpenPilotActionsMenu()
	local elements = {
		{label = _U('vehicle_list'),   value = 'vehicle_list'},
		{label = _U('work_wear'),      value = 'cloakroom'},
		{label = _U('civ_wear'),       value = 'cloakroom2'},
		{label = _U('deposit_stock'),  value = 'put_stock'},
		{label = _U('withdraw_stock'), value = 'get_stock'},
		{label = 'Parachutes', value = 'para'}
	}

	if Config.EnablePlayerManagement and ESX.PlayerData.job and ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pilot_actions', {
		title    = _U('pilot'),
		align    = 'top-right',
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
						align    = 'top-right',
						elements = elements
					}, function(data, menu)
						menu.close()
						local vehicleProps = data.current.value

						ESX.Game.SpawnVehicle(vehicleProps.model, Config.Zones.VehicleSpawnPoint.Pos, 330.14, function(vehicle)
							ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
							local playerPed = PlayerPedId()
						end)

						TriggerServerEvent('293760c8-b5e2-4800-bc04-944c4b572970', 'pilot', vehicleProps)
					end, function(data, menu)
						menu.close()
					end)
				end, 'pilot')

			else

                local elements = { 
                    {label = _U('----------------------GROUND----------------------'),  value = 'nil'},
                    {label = _U('Limo'),  value = 'stretch'},
                    {label = _U('Limo Hummer'),  value = 'patriot2'},
                    {label = _U('Baller'),  value = 'baller4'},
                    {label = _U('Super Diamond'),  value = 'superd'},
                    {label = _U('Airtug'),  value = 'airtug'},
                    {label = _U('Airport Bus'),  value = 'airbus'},
                    {label = _U('Bus'),  value = 'bus'},
                    {label = _U('Shuttle Bus'),  value = 'rentalbus'},
					
                    {label = _U('----------------------OFFROAD----------------------'),  value = 'nil'},
                    {label = _U('Cliffhanger'),  value = 'cliffhanger'},
                    {label = _U('Enduro'),  value = 'enduro'},
                    {label = _U('Sanchez'),  value = 'sanchez'},
                    {label = _U('Blazer'),  value = 'blazer'},
                    {label = _U('Scorcher'),  value = 'scorcher'},
                    {label = _U('----------------------PLANES----------------------'),  value = 'nil'},
                    {label = _U('Luxor'),  value = 'luxor'},
                    {label = _U('Nimbus'),  value = 'nimbus'},
                    {label = _U('Velum'),  value = 'velum2'},
                    {label = _U('Mammatus'),  value = 'mammatus'},
                    {label = _U('Miljet'),  value = 'miljet'},
                    {label = _U('Cuban 800'),  value = 'cuban800'},
                    {label = _U('Dodo'),  value = 'Dodo'},
                    {label = _U('----------------------HELICOPTERS----------------------'),  value = 'nil'},
                    {label = _U('Frogger'),  value = 'frogger'},
                    {label = _U('Swift'),  value = 'swift'},
                    {label = _U('SuperVolito'),  value = 'supervolito2'},
                    {label = _U('Volatus'),  value = 'volatus'},
                    {label = _U('Maverick'),  value = 'maverick'},
                    {label = _U('Buzzard'),  value = 'buzzard2'},
                    {label = _U('Cargobob'),  value = 'cargobob2'},
                    {label = _U('Sea Sparrow'),  value = 'seasparrow'},
					
					
					
				}
				
				if Config.EnablePlayerManagement and ESX.PlayerData.job and (ESX.PlayerData.job.grade_name == 'chief') then
					table.insert(elements, {label = _U('----------------------SPECIAL----------------------'),  value = 'nil'})
                    table.insert(elements, {label = _U('Ultralight'),  value = 'microlight'})
					table.insert(elements, {label = _U('Alpha-Z1'),  value = 'alphaz1'})
					table.insert(elements, {label = _U('Blue Angels'),  value = 'besra'})
					table.insert(elements, {label = _U('Howard NX-25'),  value = 'howard'})
					table.insert(elements, {label = _U('P-45 Nokota'),  value = 'nokota'})
					table.insert(elements, {label = _U('Mallard'),  value = 'stunt'})
				end

				if Config.EnablePlayerManagement and ESX.PlayerData.job and (ESX.PlayerData.job.grade_name == 'boss') then
					table.insert(elements, {label = _U('----------------------SPECIAL----------------------'),  value = 'nil'})
                    table.insert(elements, {label = _U('Ultralight'),  value = 'microlight'})
					table.insert(elements, {label = _U('Alpha-Z1'),  value = 'alphaz1'})
					table.insert(elements, {label = _U('Blue Angels'),  value = 'besra'})
					table.insert(elements, {label = _U('Howard NX-25'),  value = 'howard'})
					table.insert(elements, {label = _U('P-45 Nokota'),  value = 'nokota'})
					table.insert(elements, {label = _U('Mallard'),  value = 'stunt'})
				end

				ESX.UI.Menu.CloseAll()

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_vehicle', {
					title    = _U('service_vehicle'),
					align    = 'top-right',
					elements = elements
				}, function(data, menu)
					if Config.MaxInService == -1 then
						ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 330.14, function(vehicle)
							local playerPed = PlayerPedId()
						end)
					else
						ESX.TriggerServerCallback('5ec18406-b92f-414f-8d90-64a53778ed0d', function(canTakeService, maxInService, inServiceCount)
							if canTakeService then
								ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 330.14, function(vehicle)
									local playerPed = PlayerPedId()
								end)
							else
								ESX.ShowNotification(_U('service_full') .. inServiceCount .. '/' .. maxInService)
							end
						end, 'pilot')
					end

					menu.close()
				end, function(data, menu)
					menu.close()
					OpenPilotActionsMenu()
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
		elseif data.current.value == 'para' then
			TriggerServerEvent('ab9a7bc4-174e-4c73-bf3b-687e848d81a1')
		elseif data.current.value == 'put_stock' then
			OpenPutStocksMenu()
		elseif data.current.value == 'get_stock' then
			OpenGetStocksMenu()
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('9878e951-0ff0-4996-be7e-f0eb7c427247', 'pilot', function(data, menu)
				menu.close()
			end)
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'pilot_actions_menu'
		CurrentActionMsg  = _U('open_actions')
		CurrentActionData = {}
	end)
end


function OpenBoatActionsMenu()
	local elements = {
		{label = _U('vehicle_list'),   value = 'vehicle_list'},
		{label = _U('work_wear'),      value = 'cloakroom'},
		{label = _U('civ_wear'),       value = 'cloakroom2'},
		{label = _U('deposit_stock'),  value = 'put_stock'},
		{label = _U('withdraw_stock'), value = 'get_stock'},
		{label = 'Parachutes', value = 'para'}
	}

	if Config.EnablePlayerManagement and ESX.PlayerData.job and ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'boat_actions', {
		title    = _U('pilot'),
		align    = 'top-right',
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
						align    = 'top-right',
						elements = elements
					}, function(data, menu)
						menu.close()
						local vehicleProps = data.current.value

						ESX.Game.SpawnVehicle(vehicleProps.model, Config.Zones.BoatSpawnPoint.Pos, 330.14, function(vehicle)
							ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
							local playerPed = PlayerPedId()
						end)

						TriggerServerEvent('293760c8-b5e2-4800-bc04-944c4b572970', 'pilot', vehicleProps)
					end, function(data, menu)
						menu.close()
					end)
				end, 'pilot')

			else

                local elements = { 
                    {label = ('----------------------Boats----------------------'),  value = 'nil'},
                    {label = ('Ferry'),  value = 'lcac'},
					{label = ('Passenger Ferry'),  value = 'redjb'},
					
                    
				}
				
	
				ESX.UI.Menu.CloseAll()

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'spawn_vehicle', {
					title    = _U('service_vehicle'),
					align    = 'top-right',
					elements = elements
				}, function(data, menu)
					if Config.MaxInService == -1 then
						ESX.Game.SpawnVehicle(data.current.value, Config.Zones.BoatSpawnPoint.Pos, 134.33, function(vehicle)
							local playerPed = PlayerPedId()
							TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)  -- teleport into vehicle
							
						end)
					else
						ESX.TriggerServerCallback('5ec18406-b92f-414f-8d90-64a53778ed0d', function(canTakeService, maxInService, inServiceCount)
							if canTakeService then
								ESX.Game.SpawnVehicle(data.current.value, Config.Zones.BoatSpawnPoint.Pos, 330.14, function(vehicle)
								
								end)
							else
								ESX.ShowNotification(_U('service_full') .. inServiceCount .. '/' .. maxInService)
							end
						end, 'pilot')
					end

					menu.close()
				end, function(data, menu)
					menu.close()
					OpenBoatActionsMenu()
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
		elseif data.current.value == 'para' then
			TriggerServerEvent('ab9a7bc4-174e-4c73-bf3b-687e848d81a1')
		elseif data.current.value == 'put_stock' then
			OpenPutStocksMenu()
		elseif data.current.value == 'get_stock' then
			OpenGetStocksMenu()
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('9878e951-0ff0-4996-be7e-f0eb7c427247', 'pilot', function(data, menu)
				menu.close()
			end)
		end
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'Boat_actions_menu'
		CurrentActionMsg  = _U('open_actions')
		CurrentActionData = {}
	end)
end

function OpenPilotHarvestMenu()
	if Config.EnablePlayerManagement and ESX.PlayerData.job and ESX.PlayerData.job.grade_name ~= 'recrue' then
		local elements = {
			{label = _U('gas_can'), value = 'gaz_bottle'},
			{label = _U('repair_tools'), value = 'fix_tool'},
			{label = _U('body_work_tools'), value = 'caro_tool'}
		}

		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pilot_harvest', {
			title    = _U('harvest'),
			align    = 'top-right',
			elements = elements
		}, function(data, menu)
			menu.close()

			if data.current.value == 'gaz_bottle' then
				TriggerServerEvent('12e865b1-98a1-4d53-b3d0-3a2c42f22897')
			elseif data.current.value == 'fix_tool' then
				TriggerServerEvent('a412424a-a7cf-4eca-b45a-a6d117bc1325')
			elseif data.current.value == 'caro_tool' then
				TriggerServerEvent('ca09661e-3de0-4def-9f86-5b9d5e104bc0')
			end
		end, function(data, menu)
			menu.close()
			CurrentAction     = 'pilot_harvest_menu'
			CurrentActionMsg  = _U('harvest_menu')
			CurrentActionData = {}
		end)
	else
		ESX.ShowNotification(_U('not_experienced_enough'))
	end
end

function OpenPilotCraftMenu()
	if Config.EnablePlayerManagement and ESX.PlayerData.job and ESX.PlayerData.job.grade_name ~= 'recrue' then
		local elements = {
			{label = _U('blowtorch'),  value = 'blow_pipe'},
			{label = _U('repair_kit'), value = 'fix_kit'},
			{label = _U('body_kit'),   value = 'caro_kit'}
		}

		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pilot_craft', {
			title    = _U('craft'),
			align    = 'top-right',
			elements = elements
		}, function(data, menu)
			menu.close()

			if data.current.value == 'blow_pipe' then
				TriggerServerEvent('bc618063-8d7f-4720-95f1-087c7d2ea828')
			elseif data.current.value == 'fix_kit' then
				TriggerServerEvent('18c3fef7-f36d-4b7b-9b1f-5d8008cd93bd')
			elseif data.current.value == 'caro_kit' then
				TriggerServerEvent('c4cc5395-31f0-4207-b37f-4177497e52a9')
			end
		end, function(data, menu)
			menu.close()

			CurrentAction     = 'pilot_craft_menu'
			CurrentActionMsg  = _U('craft_menu')
			CurrentActionData = {}
		end)
	else
		ESX.ShowNotification(_U('not_experienced_enough'))
	end
end

function OpenMobilePilotActionsMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_pilot_actions', {
		title    = _U('pilot'),
		align    = 'top-right',
		elements = {
			{label = _U('billing'),       value = 'billing'},
			{label = _U('clean'),         value = 'clean_vehicle'},
			{label = _U('flat_bed'),      value = 'dep_vehicle'},
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
						TriggerServerEvent('c9ac0436-8b83-467d-abe5-4978cdf78f9b', GetPlayerServerId(closestPlayer), 'society_pilot', _U('pilot'), amount)
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
								TriggerServerEvent('996a753a-b315-4e79-a069-31f4aae925b4')
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

			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_pilot_actions_spawn', {
				title    = _U('objects'),
				align    = 'top-right',
				elements = {
					{label = _U('roadcone'), value = 'prop_roadcone02a'},
					{label = _U('toolbox'),  value = 'prop_toolchest_01'}
			}}, function(data2, menu2)
				local model   = data2.current.value
				local coords  = GetEntityCoords(playerPed)
				local forward = GetEntityForwardVector(playerPed)
				local x, y, z = table.unpack(coords + forward * 1.0)

				if model == 'prop_roadcone02a' then
					z = z - 2.0
				elseif model == 'prop_toolchest_01' then
					z = z - 2.0
				end

				ESX.Game.SpawnObject(model, {x = x, y = y, z = z}, function(obj)
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
	ESX.TriggerServerCallback('1f8fde67-4d26-4704-9682-63742d5525d5', function(items)
		local elements = {}

		for i=1, #items, 1 do
			table.insert(elements, {
				label = 'x' .. items[i].count .. ' ' .. items[i].label,
				value = items[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'stocks_menu', {
			title    = _U('pilot_stock'),
			align    = 'top-right',
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
					TriggerServerEvent('850e4462-ae95-4b89-89ee-854b335317d2', itemName, count)

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
	ESX.TriggerServerCallback('74f169cd-daf7-4216-82ab-57db58d880a8', function(inventory)
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
			align    = 'top-right',
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
					TriggerServerEvent('ebbcc47c-c354-4e73-9e19-29b5a4faad73', itemName, count)

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

RegisterNetEvent('9b258933-0ffb-4a5d-9941-76e291c3f2fa')
AddEventHandler('9b258933-0ffb-4a5d-9941-76e291c3f2fa', function()
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

RegisterNetEvent('59a43b21-265f-4974-b0e1-f24be6a900fd')
AddEventHandler('59a43b21-265f-4974-b0e1-f24be6a900fd', function()
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

RegisterNetEvent('ab42cb67-82e0-41e4-be2a-c009d2ad6286')
AddEventHandler('ab42cb67-82e0-41e4-be2a-c009d2ad6286', function()
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

AddEventHandler('bc4e0767-5727-4f8a-b9d2-e2c6aed1a636', function(zone)
	if zone == 'NPCJobTargetTowable' then

	elseif zone =='VehicleDelivery' then
		NPCTargetDeleterZone = true
	elseif zone == 'PilotActions' then
		CurrentAction     = 'pilot_actions_menu'
		CurrentActionMsg  = _U('open_actions')
		CurrentActionData = {}
		elseif zone == 'BoatActions' then
		CurrentAction     = 'Boat_actions_menu'
		CurrentActionMsg  = _U('open_actions')
		CurrentActionData = {}
	elseif zone == 'Garage' then
		CurrentAction     = 'pilot_harvest_menu'
		CurrentActionMsg  = _U('harvest_menu')
		CurrentActionData = {}
	elseif zone == 'Craft' then
		CurrentAction     = 'pilot_craft_menu'
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

AddEventHandler('48ac5360-fa5d-4fed-b115-23e76e11599f', function(zone)
	if zone =='VehicleDelivery' then
		NPCTargetDeleterZone = false
	elseif zone == 'Craft' then
		TriggerServerEvent('19634c83-4528-405a-9ee2-325480d0b4f1')
		TriggerServerEvent('65538209-8d0a-451d-b41f-04cf5bb631c6')
		TriggerServerEvent('3af4d7c5-0c75-4b44-ac5f-3b9c944173e8')
	elseif zone == 'Garage' then
		TriggerServerEvent('095a6c35-849b-4679-97f2-2c2ef46fa27f')
		TriggerServerEvent('f7dc7d11-5228-480c-a76b-fbfef3967f12')
		TriggerServerEvent('ee4499fd-5456-4d12-8cbe-c5374b9f7c49')
	end

	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

AddEventHandler('5179152f-bc44-440d-99dc-e49125b9f548', function(entity)
	local playerPed = PlayerPedId()

	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'pilot' and not IsPedInAnyVehicle(playerPed, false) then
		CurrentAction     = 'remove_entity'
		CurrentActionMsg  = _U('press_remove_obj')
		CurrentActionData = {entity = entity}
	end
end)

AddEventHandler('a24a6f0f-15e9-407c-b223-0ec40ae22053', function(entity)
	if CurrentAction == 'remove_entity' then
		CurrentAction = nil
	end
end)

RegisterNetEvent('59809f17-d8ce-49dd-ae30-d5e90a7761a7')
AddEventHandler('59809f17-d8ce-49dd-ae30-d5e90a7761a7', function(phoneNumber, contacts)
	local specialContact = {
		name       = _U('pilot'),
		number     = 'pilot',
		base64Icon = 'data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAACAAAAAgCAYAAABzenr0AAAABHNCSVQICAgIfAhkiAAAAAlwSFlzAAALEwAACxMBAJqcGAAAA4BJREFUWIXtll9oU3cUx7/nJA02aSSlFouWMnXVB0ejU3wcRteHjv1puoc9rA978cUi2IqgRYWIZkMwrahUGfgkFMEZUdg6C+u21z1o3fbgqigVi7NzUtNcmsac40Npltz7S3rvUHzxQODec87vfD+/e0/O/QFv7Q0beV3QeXqmgV74/7H7fZJvuLwv8q/Xeux1gUrNBpN/nmtavdaqDqBK8VT2RDyV2VHmF1lvLERSBtCVynzYmcp+A9WqT9kcVKX4gHUehF0CEVY+1jYTTIwvt7YSIQnCTvsSUYz6gX5uDt7MP7KOKuQAgxmqQ+neUA+I1B1AiXi5X6ZAvKrabirmVYFwAMRT2RMg7F9SyKspvk73hfrtbkMPyIhA5FVqi0iBiEZMMQdAui/8E4GPv0oAJkpc6Q3+6goAAGpWBxNQmTLFmgL3jSJNgQdGv4pMts2EKm7ICJB/aG0xNdz74VEk13UYCx1/twPR8JjDT8wttyLZtkoAxSb8ZDCz0gdfKxWkFURf2v9qTYH7SK7rQIDn0P3nA0ehixvfwZwE0X9vBE/mW8piohhl1WH18UQBhYnre8N/L8b8xQvlx4ACbB4NnzaeRYDnKm0EALCMLXy84hwuTCXL/ExoB1E7qcK/8NCLIq5HcTT0i6u8TYbXUM1cAyyveVq8Xls7XhYrvY/4n3gC8C+dsmAzL1YUiyfWxvHzsy/w/dNd+KjhW2yvv/RfXr7x9QDcmo1he2RBiCCI1Q8jVj9szPNixVfgz+UiIGyDSrcoRu2J16d3I6e1VYvNSQjXpnucAcEPUOkGYZs/l4uUhowt/3kqu1UIv9n90fAY9jT3YBlbRvFTD4fw++wHjhiTRL/bG75t0jI2ITcHb5om4Xgmhv57xpGOg3d/NIqryOR7z+r+MC6qBJB/ZB2t9Om1D5lFm843G/3E3HI7Yh1xDRAfzLQr5EClBf/HBHK462TG2J0OABXeyWDPZ8VqxmBWYscpyghwtTd4EKpDTjCZdCNmzFM9k+4LHXIFACJN94Z6FiFEpKDQw9HndWsEuhnADVMhAUaYJBp9XrcGQKJ4qFE9k+6r2+MG3k5N8VQ22TVglbX2ZwOzX2VvNKr91zmY6S7N6zqZicVT2WNLyVSehESaBhxnOALfMeYX+K/S2yv7wmMAlvwyuR7FxQUyf0fgc/jztfkJr7XeGgC8BJJgWNV8ImT+AAAAAElFTkSuQmCC'
	}

	TriggerEvent('e25977c9-9f2b-4d5d-a807-a8c7a0c964d5', specialContact.name, specialContact.number, specialContact.base64Icon)
end)


-- Create Blips
Citizen.CreateThread(function()
	Wait(8000)
	local blip = AddBlipForCoord(Config.Zones.PilotActions.Pos.x, Config.Zones.PilotActions.Pos.y, Config.Zones.PilotActions.Pos.z)
	
  
	SetBlipSprite (blip, 64)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.0)
	SetBlipColour (blip, 26)
	SetBlipAsShortRange(blip, true)
  
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString("Melbourne Adventures")
	EndTextCommandSetBlipName(blip)
  
  end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'pilot' then
			local coords, letSleep = GetEntityCoords(PlayerPedId()), true

			for k,v in pairs(Config.Zones) do
				if v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, nil, nil, false)
					letSleep = false
				end
			end

			if letSleep then
				Citizen.Wait(1000)
			end
		else
			Citizen.Wait(2300)
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'pilot' then

			local coords      = GetEntityCoords(PlayerPedId())
			local isInMarker  = false
			local currentZone = nil

			for k,v in pairs(Config.Zones) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker  = true
					currentZone = k
				end
				Wait(200)
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone                = currentZone
				TriggerEvent('bc4e0767-5727-4f8a-b9d2-e2c6aed1a636', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('48ac5360-fa5d-4fed-b115-23e76e11599f', LastZone)
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
		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'pilot' then
			if CurrentAction then
				ESX.ShowHelpNotification(CurrentActionMsg)

				if IsControlJustReleased(0, 38) and ESX.PlayerData.job and ESX.PlayerData.job.name == 'pilot' then

					if CurrentAction == 'pilot_actions_menu' then
						OpenPilotActionsMenu()
				    elseif CurrentAction == 'Boat_actions_menu' then
						OpenBoatActionsMenu()
					elseif CurrentAction == 'pilot_harvest_menu' then
						OpenPilotHarvestMenu()
					elseif CurrentAction == 'pilot_craft_menu' then
						OpenPilotCraftMenu()
					elseif CurrentAction == 'delete_vehicle' then

						if Config.EnableSocietyOwnedVehicles then

							local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
							TriggerServerEvent('ee25e8b0-b555-4cd2-b500-24c1cbd32f88', 'pilot', vehicleProps)

						else

							if
								GetEntityModel(vehicle) == GetHashKey('flatbed')   or
								GetEntityModel(vehicle) == GetHashKey('towtruck2') or
								GetEntityModel(vehicle) == GetHashKey('slamvan3')
							then
								TriggerServerEvent('a91f16e6-8b39-4118-b7d3-68f32f337985', 'pilot')
							end

						end

						ESX.Game.DeleteVehicle(CurrentActionData.vehicle)

					elseif CurrentAction == 'remove_entity' then
						DeleteEntity(CurrentActionData.entity)
					end

					CurrentAction = nil
				end
			end

			if IsControlJustReleased(0, 167) and not isDead and ESX.PlayerData.job and ESX.PlayerData.job.name == 'pilot' then
				OpenMobilePilotActionsMenu()
			end
		else
			Wait(2500)
		end
	end
end)

AddEventHandler('2df4c490-68a8-4c7e-896a-9fc552e16210', function(data)
	isDead = true
end)

AddEventHandler('880c0a93-b305-46b3-b84c-a120fee9e841', function(spawn)
	isDead = false
end)
