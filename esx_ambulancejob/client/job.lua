local CurrentAction, CurrentActionMsg, CurrentActionData = nil, '', {}
local HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum
local IsBusy = false
local spawnedVehicles, isInShopMenu = {}, false

local onduty = false

function OpenAmbulanceActionsMenu()
	local elements = {
		{label = _U('cloakroom'), value = 'cloakroom'}
	}

	if Config.EnablePlayerManagement and ESX.PlayerData.job.grade_name == 'boss' then
		table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ambulance_actions', {
		title    = _U('ambulance'),
		align    = 'top-right',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'cloakroom' then
			OpenCloakroomMenu()
		elseif data.current.value == 'boss_actions' then
			TriggerEvent('9878e951-0ff0-4996-be7e-f0eb7c427247', 'ambulance', function(data, menu)
				menu.close()
			end, {wash = false})
		end
	end, function(data, menu)
		menu.close()
	end)
end

local lastduresspress = GetGameTimer()
local lastbuttonpress = GetGameTimer()

function OpenMobileAmbulanceActionsMenu()

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'mobile_ambulance_actions', {
		title    = _U('ambulance'),
		align    = 'top-right',
		elements = {
			{label = _U('ems_menu'), value = 'citizen_interaction'}
		}
	}, function(data, menu)
		if data.current.value == 'citizen_interaction' then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction', {
				title    = _U('ems_menu_title'),
				align    = 'top-right',
				elements = {
					{label = _U('ems_menu_revive'), value = 'revive'},
					{label = _U('ems_menu_small'), value = 'small'},
					{label = _U('ems_menu_big'), value = 'big'},
					{label = _U('ems_menu_putincar'), value = 'put_in_vehicle'},
					{label = 'Increase Bleedout 5min for patient',     value = 'ibo'},
					{label = 'Go on Duty',     value = 'onduty'},
					{label = 'Go off Duty',     value = 'offduty'},
					{label = 'Traffic Management', value ='tman'},
					{label = 'Request Police Attendance',     value = 'policec'},
					{label = 'Duress (Notifies Police Comms)',     value = 'duress'},
					w_tos

				}
			}, function(data, menu)
			
			if lastbuttonpress < (GetGameTimer()- 1000) then
					lastbuttonpress = GetGameTimer()
					if data.current.value == 'onduty' and onduty == false then
						onduty = true
						TriggerServerEvent('es:setJobDuty',tostring(GetPlayerServerId(PlayerId())), true)
						SetEveryoneIgnorePlayer(GetPlayerPed(-1), true)
						TriggerServerEvent('7fcbafb2-e15d-4e94-9a71-c348def151ae',"AMBULANCE ACTION", "ON DUTY")
					end
					
					if data.current.value == 'offduty' and onduty == true then
						onduty = false
						TriggerServerEvent('es:setJobDuty',tostring(GetPlayerServerId(PlayerId())), false)
						SetEveryoneIgnorePlayer(GetPlayerPed(-1), false)
						
						TriggerServerEvent('7fcbafb2-e15d-4e94-9a71-c348def151ae',"AMBULANCE ACTION", "OFF DUTY")
					end
					
					if data.current.value == 'ibo' then
						local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
						if closestPlayer ~= -1 and closestDistance < 4.5 then
							TriggerServerEvent('ce78d2d3-c9e3-443f-bc86-37489eb19062',tostring(GetPlayerServerId(closestPlayer)), false)
							ESX.ShowNotification('Death Timer increased for playerid: ' .. GetPlayerServerId(closestPlayer))

							TriggerServerEvent('841a41b8-d3a5-4d25-9d37-2e0803c1e51a',"AMBULANCE ACTION", "INCREASE DEATH TIMER " .. GetPlayerName(closestPlayer), tostring(GetPlayerServerId(closestPlayer)))
							return

						end
					end					
					
					if data.current.value == 'tman' then
						menu.close()
						TriggerEvent('15f6df85-d2c6-4efd-a4e3-b041d5489583')
						return
					
					end
							
							
					if data.current.value == 'duress' then
						if lastduresspress < (GetGameTimer() - 10000) then
							lastduresspress = GetGameTimer()
							local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
							local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
							local street1 = GetStreetNameFromHashKey(s1)
							local street2 = GetStreetNameFromHashKey(s2)
							
							local emergloc = '~o~AMB/FIRE~w~: '
							
							
							if s2 ~= 0 then
								emergloc = emergloc .. 'Cnr ' .. street1 .. ' and ' .. street2
							else
								emergloc = emergloc .. ' ' .. street1 
							end
							
							emergloc = emergloc .. ' PANIC BUTTON HAS BEEN PRESSED, Police to respond PRI 1'
							
							
							local loci1 = exports['webcops']:getLocationReturn()

							--TriggerServerEvent('67cc61df-e6be-41d8-9bec-023459661970', GetPlayerServerId(PlayerId()), emergloc, loci1 , plyPos.x, plyPos.y, plyPos.z, 'police', '000', false)
							local PlayerCoords = { x = plyPos.x, y = plyPos.y, z = plyPos.z }
							TriggerServerEvent('c916860b-b2ca-42eb-9eac-cf20b6341eac', 'police', '[PRI-1]***AMBVIC DURESS**** :: ' .. emergloc, PlayerCoords, {

									PlayerCoords = { x = plyPos.x, y = plyPos.y, z = plyPos.z },
							})
							
							TriggerServerEvent('c916860b-b2ca-42eb-9eac-cf20b6341eac', 'ambulance', '***AMBVIC DURESS**** :: ' .. emergloc, PlayerCoords, {

									PlayerCoords = { x = plyPos.x, y = plyPos.y, z = plyPos.z },
							})

							--TriggerServerEvent('67cc61df-e6be-41d8-9bec-023459661970', tostring(GetPlayerServerId(PlayerId())), emergloc , plyPos.x, plyPos.y, plyPos.z , 'police', '000', true)
							ESX.ShowNotification("Duress Button has been pressed. Police have been notified.")
						end
						
					end
					
					
					if data.current.value == 'policec' then
						if lastduresspress < (GetGameTimer() - 10000) then
							lastduresspress = GetGameTimer()
							local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
							local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
							local street1 = GetStreetNameFromHashKey(s1)
							local street2 = GetStreetNameFromHashKey(s2)
							
							local emergloc = '~o~AMB/FIRE~w~ POLICE ATTENDANCE REQUEST: '
							
							
							if s2 ~= 0 then
								emergloc = emergloc .. 'Cnr ' .. street1 .. ' and ' .. street2
							else
								emergloc = emergloc .. ' ' .. street1 
							end
							
							emergloc = emergloc .. ' POLICE HAVE BEEN REQUESTED TO ATTEND AMB/VIC LOCATION'
							
							
							local loci1 = exports['webcops']:getLocationReturn()

							--TriggerServerEvent('67cc61df-e6be-41d8-9bec-023459661970', GetPlayerServerId(PlayerId()), emergloc, loci1 , plyPos.x, plyPos.y, plyPos.z, 'police', '000', false)
							local PlayerCoords = { x = plyPos.x, y = plyPos.y, z = plyPos.z }
							TriggerServerEvent('c916860b-b2ca-42eb-9eac-cf20b6341eac', 'police',  emergloc, PlayerCoords, {

									PlayerCoords = { x = plyPos.x, y = plyPos.y, z = plyPos.z },
							})
							
							TriggerServerEvent('c916860b-b2ca-42eb-9eac-cf20b6341eac', 'ambulance',  emergloc, PlayerCoords, {

									PlayerCoords = { x = plyPos.x, y = plyPos.y, z = plyPos.z },
							})

							--TriggerServerEvent('67cc61df-e6be-41d8-9bec-023459661970', tostring(GetPlayerServerId(PlayerId())), emergloc , plyPos.x, plyPos.y, plyPos.z , 'police', '000', true)
							ESX.ShowNotification("Police Attendance requested: Police have been notified.")
						end
						
					end
			else
					ESX.ShowNotification('Action ignored, too many button presses too quickly.')
			end
			
			
				if IsBusy then return end

				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

				if closestPlayer == -1 or closestDistance > 1.0 then
					ESX.ShowNotification(_U('no_players'))
				else

					if data.current.value == 'revive' then

						IsBusy = true

						ESX.TriggerServerCallback('37a011fa-64a0-40bf-88d8-ddd2b86ac55f', function(quantity)
							if quantity > 0 then
								local closestPlayerPed = GetPlayerPed(closestPlayer)

								if IsPedRagdoll(closestPlayerPed) or IsPedDeadOrDying(closestPlayerPed) then
									local playerPed = PlayerPedId()

									ESX.ShowNotification(_U('revive_inprogress'))

									local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'

									for i=1, 15, 1 do
										Citizen.Wait(900)
								
										ESX.Streaming.RequestAnimDict(lib, function()
											TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
										end)
									end

									TriggerServerEvent('54710dad-e478-41af-a913-6896418b26b2', 'medikit')
									TriggerServerEvent('1982e9c8-01fb-4254-b49d-0df84f982fef', GetPlayerServerId(closestPlayer))

									-- Show revive award?
									if Config.ReviveReward > 0 then
										TriggerServerEvent('841a41b8-d3a5-4d25-9d37-2e0803c1e51a',"AMBULANCE ACTION", "REVIVE REWARD: " .. GetPlayerName(closestPlayer), tostring(GetPlayerServerId(closestPlayer)))
										ESX.ShowNotification(_U('revive_complete_award', GetPlayerName(closestPlayer), Config.ReviveReward))
									else
										TriggerServerEvent('841a41b8-d3a5-4d25-9d37-2e0803c1e51a',"AMBULANCE ACTION", "REVIVE NO REWARD: " .. GetPlayerName(closestPlayer), tostring(GetPlayerServerId(closestPlayer)))
										ESX.ShowNotification(_U('revive_complete', GetPlayerName(closestPlayer)))
									end
								else
									ESX.ShowNotification(_U('player_not_unconscious'))
								end
							else
								ESX.ShowNotification(_U('not_enough_medikit'))
							end

							IsBusy = false

						end, 'medikit')

					elseif data.current.value == 'small' then

						ESX.TriggerServerCallback('37a011fa-64a0-40bf-88d8-ddd2b86ac55f', function(quantity)
							if quantity > 0 then
								local closestPlayerPed = GetPlayerPed(closestPlayer)
								local health = GetEntityHealth(closestPlayerPed)

								if health > 0 then
									local playerPed = PlayerPedId()

									IsBusy = true
									ESX.ShowNotification(_U('heal_inprogress'))
									TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
									Citizen.Wait(10000)
									ClearPedTasks(playerPed)

									TriggerServerEvent('54710dad-e478-41af-a913-6896418b26b2', 'bandage')
									TriggerServerEvent('79825949-4856-484f-8117-5bb7dc91946f', GetPlayerServerId(closestPlayer), 'small')
									ESX.ShowNotification(_U('heal_complete', GetPlayerName(closestPlayer)))
									IsBusy = false
								else
									ESX.ShowNotification(_U('player_not_conscious'))
								end
							else
								ESX.ShowNotification(_U('not_enough_bandage'))
							end
						end, 'bandage')

					elseif data.current.value == 'big' then

						ESX.TriggerServerCallback('37a011fa-64a0-40bf-88d8-ddd2b86ac55f', function(quantity)
							if quantity > 0 then
								local closestPlayerPed = GetPlayerPed(closestPlayer)
								local health = GetEntityHealth(closestPlayerPed)

								if health > 0 then
									local playerPed = PlayerPedId()

									IsBusy = true
									ESX.ShowNotification(_U('heal_inprogress'))
									TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
									Citizen.Wait(10000)
									ClearPedTasks(playerPed)

									TriggerServerEvent('54710dad-e478-41af-a913-6896418b26b2', 'medikit')
									TriggerServerEvent('79825949-4856-484f-8117-5bb7dc91946f', GetPlayerServerId(closestPlayer), 'big')
									ESX.ShowNotification(_U('heal_complete', GetPlayerName(closestPlayer)))
									IsBusy = false
								else
									ESX.ShowNotification(_U('player_not_conscious'))
								end
							else
								ESX.ShowNotification(_U('not_enough_medikit'))
							end
						end, 'medikit')

					elseif data.current.value == 'put_in_vehicle' then
						TriggerServerEvent('841a41b8-d3a5-4d25-9d37-2e0803c1e51a',"AMBULANCE ACTION", "PUT IN VEHICLE " .. data.current.label .. "PLAYER: ", GetPlayerServerId(closestPlayer))
						TriggerServerEvent('ac8eb5bb-1c38-4e7d-b842-a75c3bcf83ed', GetPlayerServerId(closestPlayer))
					end
				end
			end, function(data, menu)
				menu.close()
			end)

		end

	end, function(data, menu)
		menu.close()
	end)
end

function FastTravel(coords, heading)
	local playerPed = PlayerPedId()

	DoScreenFadeOut(800)

	while not IsScreenFadedOut() do
		Citizen.Wait(500)
	end

	ESX.Game.Teleport(playerPed, coords, function()
		DoScreenFadeIn(800)

		if heading then
			SetEntityHeading(playerPed, heading)
		end
	end)
end

-- Draw markers & Marker logic
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local playerCoords = GetEntityCoords(PlayerPedId())
		local letSleep, isInMarker, hasExited = true, false, false
		local currentHospital, currentPart, currentPartNum

		for hospitalNum,hospital in pairs(Config.Hospitals) do

			-- Ambulance Actions
			for k,v in ipairs(hospital.AmbulanceActions) do
				local distance = #(playerCoords - v)

				if distance < Config.DrawDistance then
					DrawMarker(Config.Marker.type, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, Config.Marker.rotate, nil, nil, false)
					letSleep = false
				end

				if distance < Config.Marker.x then
					isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'AmbulanceActions', k
				end
			end

			-- Pharmacies
			
			for k,v in ipairs(hospital.Pharmacies) do
				local distance =  #(playerCoords - v)

				if distance < Config.DrawDistance then
					DrawMarker(Config.Marker.type, v, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, Config.Marker.rotate, nil, nil, false)
					letSleep = false
				end

				if distance < Config.Marker.x then
					isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Pharmacy', k
				end
			end

			-- Vehicle Spawners
			if hospital.Vehicles ~= nil then
				for k,v in ipairs(hospital.Vehicles) do
					local distance =  #(playerCoords - v.Spawner)

					if distance < Config.DrawDistance then
						DrawMarker(v.Marker.type, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
						letSleep = false
					end

					if distance < v.Marker.x then
						isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Vehicles', k
					end
				end
			end

			-- Helicopter Spawners
			if hospital.Helicopters ~= nil then
				for k,v in ipairs(hospital.Helicopters) do
					local distance = #(playerCoords - v.Spawner)

					if distance < Config.DrawDistance then
						DrawMarker(v.Marker.type, v.Spawner, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
						letSleep = false
					end

					if distance < v.Marker.x then
						isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'Helicopters', k
					end
				end
			end

			-- Fast Travels
			if hospital.FastTravels ~= nil then
			for k,v in ipairs(hospital.FastTravels) do
				local distance = #(playerCoords - v.From)

				if distance < Config.DrawDistance then
					DrawMarker(v.Marker.type, v.From, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
					letSleep = false
				end


				if distance < v.Marker.x then
					FastTravel(v.To.coords, v.To.heading)
				end
			end

			-- Fast Travels (Prompt)
			for k,v in ipairs(hospital.FastTravelsPrompt) do
				local distance = #(playerCoords - v.From)

				if distance < Config.DrawDistance then
					DrawMarker(v.Marker.type, v.From, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, v.Marker.x, v.Marker.y, v.Marker.z, v.Marker.r, v.Marker.g, v.Marker.b, v.Marker.a, false, false, 2, v.Marker.rotate, nil, nil, false)
					letSleep = false
				end

				if distance < v.Marker.x then
					isInMarker, currentHospital, currentPart, currentPartNum = true, hospitalNum, 'FastTravelsPrompt', k
				end
			end
			end

		end

		-- Logic for exiting & entering markers
		if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastHospital ~= currentHospital or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then

			if
				(LastHospital ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
				(LastHospital ~= currentHospital or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
			then
				TriggerEvent('253cf62f-e9b4-4a98-8f81-aa5648f99540', LastHospital, LastPart, LastPartNum)
				hasExited = true
			end

			HasAlreadyEnteredMarker, LastHospital, LastPart, LastPartNum = true, currentHospital, currentPart, currentPartNum

			TriggerEvent('04681d9e-f989-4a00-93f9-18756799a7a2', currentHospital, currentPart, currentPartNum)

		end

		if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('253cf62f-e9b4-4a98-8f81-aa5648f99540', LastHospital, LastPart, LastPartNum)
		end

		if letSleep then
			Citizen.Wait(500)
		end
	end
end)

AddEventHandler('04681d9e-f989-4a00-93f9-18756799a7a2', function(hospital, part, partNum)
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'ambulance' then
		if part == 'AmbulanceActions' then
			CurrentAction = part
			CurrentActionMsg = _U('actions_prompt')
			CurrentActionData = {}
		elseif part == 'Pharmacy' then
			CurrentAction = part
			CurrentActionMsg = _U('open_pharmacy')
			CurrentActionData = {}
		elseif part == 'Vehicles' then
			CurrentAction = part
			CurrentActionMsg = _U('garage_prompt')
			CurrentActionData = {hospital = hospital, partNum = partNum}
		elseif part == 'Helicopters' then
			CurrentAction = part
			CurrentActionMsg = _U('helicopter_prompt')
			CurrentActionData = {hospital = hospital, partNum = partNum}
		elseif part == 'FastTravelsPrompt' then
			local travelItem = Config.Hospitals[hospital][part][partNum]

			CurrentAction = part
			CurrentActionMsg = travelItem.Prompt
			CurrentActionData = {to = travelItem.To.coords, heading = travelItem.To.heading}
		end
	end
end)

AddEventHandler('253cf62f-e9b4-4a98-8f81-aa5648f99540', function(hospital, part, partNum)
	if not isInShopMenu then
		ESX.UI.Menu.CloseAll()
	end

	CurrentAction = nil
end)

-- Key Controls
Citizen.CreateThread(function()
	
	while true do
		Citizen.Wait(5)

		if CurrentAction then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, Keys['E']) then

				if CurrentAction == 'AmbulanceActions' then
					OpenAmbulanceActionsMenu()
				elseif CurrentAction == 'Pharmacy' then
					OpenPharmacyMenu()
				elseif CurrentAction == 'Vehicles' then
					OpenVehicleSpawnerMenu(CurrentActionData.hospital, CurrentActionData.partNum)
				elseif CurrentAction == 'Helicopters' then
					OpenHelicopterSpawnerMenu(CurrentActionData.hospital, CurrentActionData.partNum)
				elseif CurrentAction == 'FastTravelsPrompt' then
					FastTravel(CurrentActionData.to, CurrentActionData.heading)
				end

				CurrentAction = nil

			end

		elseif ESX ~= nil and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' and not IsDead then
			if IsControlJustReleased(0, Keys['F6']) then
				OpenMobileAmbulanceActionsMenu()
			end
			
						--Duress Button
			if GetLastInputMethod(0) and IsControlPressed(1, 121) and IsControlPressed(1, 177)  then
				ExecuteCommand("amboduress")
				Wait(1500)
			end
		
		else
			Citizen.Wait(1000)
		end
	end
end)

RegisterNetEvent('7eb0e72c-fc19-441a-9662-5343ecc43d28')
AddEventHandler('7eb0e72c-fc19-441a-9662-5343ecc43d28', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)

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
			end
		end
	end
end)

function OpenCloakroomMenu()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom', {
		title    = _U('cloakroom'),
		align    = 'top-right',
		elements = {
			{label = _U('ems_clothes_civil'), value = 'citizen_wear'},
			{label = 'EUP Ambulance Clothes', value = 'ambulance_wear'},
			{label = 'Ambulance Ped', value = 'ambulance_wear2'},
				{label = 'CFA Clothes 1', value = 'fire_wear1'},
				{label = 'CFA Clothes 2', value = 'fire_wear2'},
				{label = 'CFA Officer', value = 'fire_wear3'},
		}
	}, function(data, menu)
		if data.current.value == 'citizen_wear' then
			ESX.TriggerServerCallback('4568d939-3661-4833-ae6a-378432ac6ff1', function(skin, jobSkin)
				TriggerEvent('56a2ee13-8a49-4ad3-a298-1854493c98ee', skin)
			end)
		elseif data.current.value == 'ambulance_wear' then
			ESX.TriggerServerCallback('4568d939-3661-4833-ae6a-378432ac6ff1', function(skin, jobSkin)

				if skin.sex == 0 then

					TriggerEvent('1d09cf94-2c53-4220-a089-0339ce8bb123', skin, jobSkin.skin_male)
				else
					TriggerEvent('1d09cf94-2c53-4220-a089-0339ce8bb123', skin, jobSkin.skin_female)
				end
			end)
		end
		
		
			if data.current.value == 'ambulance_wear2' then

		
					loadmodeln(-1286380898)
		

			end
			
			if data.current.value == 'fire_wear1' then

			

					loadmodeln(-1229853272)

			

			end

			if data.current.value == 'fire_wear2' then

			
					loadmodeln(1657546978)
				

			end
			
			
			if data.current.value == 'fire_wear3' then


					loadmodeln(-265970301)

			

			end

		menu.close()
	end, function(data, menu)
		menu.close()
	end)
end

function loadmodeln(modelnumber)
	local model = modelnumber

	local ped = GetPlayerPed( -1 )

	if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
		SetSkin( model )
		local paletteId = 0
		local componentId = 0
		local drawableId = 10
		local textureId = 0 
		Wait(1000)
		Citizen.Trace("Setting Settings NOW")

		--SetPedComponentVariation(GetPlayerPed(-1), 11, 0, 0, 2)
		--SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)
		
		if IsPedComponentVariationValid(ped, 9, 1, 0) then
			--SetPedComponentVariation(ped, 9, 1, 0, 0) --Shirt 
		end

	end 
end


function SetSkin( skin )
	local ped = GetPlayerPed( -1 )

	if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
		if ( IsModelValid( skin ) ) then 
			_LoadModel( skin )
			SetPlayerModel( PlayerId(), skin )
			
			SetPedDefaultComponentVariation( PlayerId() )
			SetModelAsNoLongerNeeded( skin )
							
		end 
	end 
end 

function _LoadModel( mdl )
    while ( not HasModelLoaded( mdl ) ) do 
        RequestModel( mdl )
        Citizen.Wait( 5 )
    end 
end 



function OpenVehicleSpawnerMenu(hospital, partNum)
	local playerCoords = GetEntityCoords(PlayerPedId())
	local elements = {
	--	{label = _U('garage_storeditem'), action = 'garage'},
		{label = _U('garage_storeitem'), action = 'store_garage'},
		{label = _U('garage_buyitem'), action = 'buy_vehicle'}
	}

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle', {
		title    = _U('garage_title'),
		align    = 'top-right',
		elements = elements
	}, function(data, menu)

		if data.current.action == 'buy_vehicle' then
			local shopCoords = Config.Hospitals[hospital].Vehicles[partNum].InsideShop
			local shopElements = {}

			local authorizedVehicles = Config.AuthorizedVehicles[ESX.PlayerData.job.grade_name]

			if #authorizedVehicles > 0 then
				for k,vehicle in ipairs(authorizedVehicles) do
					table.insert(shopElements, {
						label = ('%s - <span style="color:green;">%s</span>'):format(vehicle.label, _U('shop_item', ESX.Math.GroupDigits(vehicle.price))),
						name  = vehicle.label,
						model = vehicle.model,
						price = vehicle.price,
						type  = 'car'
					})
				end
			else
				return
			end

			OpenShopMenu(shopElements, playerCoords, shopCoords, hospital, partNum)
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
							local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint(hospital, 'Vehicles', partNum)

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
			end, 'car')

		elseif data.current.action == 'store_garage' then
			StoreNearbyVehicle(playerCoords)
		end

	end, function(data, menu)
		menu.close()
	end)

end

function StoreNearbyVehicle(playerCoords)
	local vehicles, vehiclePlates = ESX.Game.GetVehiclesInArea(playerCoords, 20.0), {}

	if #vehicles > 0 then
		for k,v in ipairs(vehicles) do
			-- Make sure the vehicle we're saving is empty, or else it wont be deleted
			if GetVehicleNumberOfPassengers(v) == 0 and IsVehicleSeatFree(v, -1) and string.sub(ESX.Math.Trim(GetVehicleNumberPlateText(v)), 1, 2) then
				ESX.Game.DeleteVehicle(v)
				break
			end
		end
		ESX.ShowNotification(_U('garage_store_nearby'))
	else
		ESX.ShowNotification(_U('garage_store_nearby'))
		return
	end
end

function GetAvailableVehicleSpawnPoint(hospital, part, partNum)
	local spawnPoints = Config.Hospitals[hospital][part][partNum].SpawnPoints
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
		ESX.ShowNotification(_U('garage_blocked'))
		return false
	end
end

function OpenHelicopterSpawnerMenu(hospital, partNum)
	local playerCoords = GetEntityCoords(PlayerPedId())
	ESX.PlayerData = ESX.GetPlayerData()
	local elements = {
		--{label = _U('helicopter_garage'), action = 'garage'},
		{label = _U('helicopter_store'), action = 'store_garage'},
		{label = _U('helicopter_buy'), action = 'buy_helicopter'}
	}

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'helicopter_spawner', {
		title    = _U('helicopter_title'),
		align    = 'top-right',
		elements = elements
	}, function(data, menu)

		if data.current.action == 'buy_helicopter' then
			local shopCoords = Config.Hospitals[hospital].Helicopters[partNum].InsideShop
			local shopElements = {}

			local authorizedHelicopters = Config.AuthorizedHelicopters[ESX.PlayerData.job.grade_name]

			if #authorizedHelicopters > 0 then
				for k,helicopter in ipairs(authorizedHelicopters) do
					table.insert(shopElements, {
						label = ('%s - <span style="color:green;">%s</span>'):format(helicopter.label, _U('shop_item', ESX.Math.GroupDigits(helicopter.price))),
						name  = helicopter.label,
						model = helicopter.model,
						price = helicopter.price,
						type  = 'helicopter'
					})
				end
			else
				ESX.ShowNotification(_U('helicopter_notauthorized'))
				return
			end

			OpenShopMenu(shopElements, playerCoords, shopCoords, hospital, partNum, 'heli')
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

					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'helicopter_garage', {
						title    = _U('helicopter_garage_title'),
						align    = 'top-right',
						elements = garage
					}, function(data2, menu2)
						if data2.current.stored then
							local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint(hospital, 'Helicopters', partNum)

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
			end, 'helicopter')

		elseif data.current.action == 'store_garage' then
			StoreNearbyVehicle(playerCoords)
		end

	end, function(data, menu)
		menu.close()
	end)

end

function OpenShopMenu(elements, restoreCoords, shopCoords, hospital, partNum, stype)
	local playerPed = PlayerPedId()
	isInShopMenu = true

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_shop', {
		title    = _U('vehicleshop_title'),
		align    = 'top-right',
		elements = elements
	}, function(data, menu)

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_shop_confirm', {
			title    = _U('vehicleshop_confirm', data.current.name, data.current.price),
			align    = 'top-right',
			elements = {
				{ label = _U('confirm_no'), value = 'no' },
				{ label = _U('confirm_yes'), value = 'yes' }
			}
		}, function(data2, menu2)

			if data2.current.value == 'yes' then
				local newPlate = 'MB ' .. math.random(1,999)
				local vehicle  = GetVehiclePedIsIn(playerPed, false)
				local props    = ESX.Game.GetVehicleProperties(vehicle)
				props.plate    = newPlate

				local playerPed = GetPlayerPed(-1)
	
			
				local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint(hospital, 'Vehicles', partNum)
				
				if stype ~= nil then
					 foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint(hospital, 'Helicopters', partNum)
				end
				
				if foundSpawn then
						ESX.Game.Teleport(playerPed, restoreCoords)
						ESX.Game.SpawnVehicle(props.model, spawnPoint.coords, spawnPoint.heading, function(vehicle)
						local playerPed = GetPlayerPed(-1)
						TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
						SetEntityAsMissionEntity(vehicle,true,true)
						local plate = 	'MB ' .. math.random(1,999)
							SetVehicleNumberPlateText(vehicle, plate)
							SetVehicleMaxMods(vehicle)
							SetEntityAsMissionEntity(vehicle,true,true)
							SetVehicleNumberPlateText(vehicle, plate)
							ESX.ShowNotification(_U('garage_released'))
								menu2.close()
								isInShopMenu = false
								ESX.UI.Menu.CloseAll()

								--DeleteSpawnedVehicles()
								FreezeEntityPosition(playerPed, false)
								SetEntityVisible(playerPed, true)

						end)
				end

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
		end)
	end)

	WaitForVehicleToLoad(elements[1].model)
	ESX.Game.SpawnLocalVehicle(elements[1].model, shopCoords, 0.0, function(vehicle)
		table.insert(spawnedVehicles, vehicle)
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		FreezeEntityPosition(vehicle, true)
	end)
end

function SetVehicleMaxMods(vehicle)
	local props = {
		modEngine       = 4,
		modBrakes       = 4,
		modTransmission = 4,
		modSuspension   = 4,
		modTurbo        = false,
	}

	ESX.Game.SetVehicleProperties(vehicle, props)
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

function OpenPharmacyMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'pharmacy', {
		title    = _U('pharmacy_menu_title'),
		align    = 'top-right',
		elements = {
			{label = _U('pharmacy_take', _U('medikit')), value = 'medikit'},
			{label = _U('pharmacy_take', _U('bandage')), value = 'bandage'},
			{label = 'Fire Extinguisher', value = 'weapon_fireextinguisher'},
			{label = 'Hatchet', value = 'weapon_hatchet'},
			{label = 'Torch', value = 'weapon_flashlight'},
		}
	}, function(data, menu)

			TriggerServerEvent('8cbb819f-d824-420c-8c14-8bd01465d4bb', data.current.value)
	
	end, function(data, menu)
		menu.close()
	end)
end

function WarpPedInClosestVehicle(ped)
	local coords = GetEntityCoords(ped)

	local vehicle, distance = ESX.Game.GetClosestVehicle(coords)

	if distance ~= -1 and distance <= 5.0 then
		local maxSeats, freeSeat = GetVehicleMaxNumberOfPassengers(vehicle)

		for i=maxSeats - 1, 0, -1 do
			if IsVehicleSeatFree(vehicle, i) then
				freeSeat = i
				break
			end
		end

		if freeSeat then
			TaskWarpPedIntoVehicle(ped, vehicle, freeSeat)
		end
	else
		ESX.ShowNotification(_U('no_vehicles'))
	end
end

RegisterNetEvent('510e2ee7-f0dc-4296-b3c8-e491a81e4f16')
AddEventHandler('510e2ee7-f0dc-4296-b3c8-e491a81e4f16', function(healType, quiet)
	local playerPed = PlayerPedId()
	local maxHealth = GetEntityMaxHealth(playerPed)

	if healType == 'small' then
		local health = GetEntityHealth(playerPed)
		local newHealth = math.min(maxHealth, math.floor(health + maxHealth / 8))
		SetEntityHealth(playerPed, newHealth)
	elseif healType == 'big' then
		SetEntityHealth(playerPed, maxHealth)
	end

	if not quiet then
		ESX.ShowNotification(_U('healed'))
	end
end)


RegisterCommand("reviveplayer", function(source, args)

	--print(GetVehicleMaxNumberOfPassengers(GetVehiclePedIsUsing(GetPlayerPed(-1))))
	if ESX.PlayerData ~= nil and ESX.PlayerData.job.name == 'ambulance' then
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

		if closestPlayer ~= -1 and closestDistance <= 4.2 then

						IsBusy = true

						ESX.TriggerServerCallback('37a011fa-64a0-40bf-88d8-ddd2b86ac55f', function(quantity)
							if quantity > 0 then
								local closestPlayerPed = GetPlayerPed(closestPlayer)

								if IsPedRagdoll(closestPlayerPed) or IsPedDeadOrDying(closestPlayerPed) then
									local playerPed = PlayerPedId()

									ESX.ShowNotification(_U('revive_inprogress'))

									local lib, anim = 'mini@cpr@char_a@cpr_str', 'cpr_pumpchest'

									for i=1, 15, 1 do
										Citizen.Wait(900)
								
										ESX.Streaming.RequestAnimDict(lib, function()
											TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
										end)
									end

									TriggerServerEvent('54710dad-e478-41af-a913-6896418b26b2', 'medikit')
									TriggerServerEvent('1982e9c8-01fb-4254-b49d-0df84f982fef', GetPlayerServerId(closestPlayer))

									-- Show revive award?
									TriggerServerEvent('841a41b8-d3a5-4d25-9d37-2e0803c1e51a',"AMBULANCE ACTION", "REVIVE " .. GetPlayerName(closestPlayer), GetPlayerServerId(closestPlayer))
									if Config.ReviveReward > 0 then
										ESX.ShowNotification(_U('revive_complete_award', GetPlayerName(closestPlayer), Config.ReviveReward))
									else
										ESX.ShowNotification(_U('revive_complete', GetPlayerName(closestPlayer)))
									end
								else
									ESX.ShowNotification(_U('player_not_unconscious'))
								end
							else
								ESX.ShowNotification(_U('not_enough_medikit'))
							end

							IsBusy = false

						end, 'medikit')
		end
	end
	
end)



RegisterCommand("increasedeathtimer", function(source, args)
	ESX.PlayerData = ESX.GetPlayerData()
	--print(GetVehicleMaxNumberOfPassengers(GetVehiclePedIsUsing(GetPlayerPed(-1))))
	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

		if closestPlayer ~= -1 and closestDistance <= 4.5 then

			TriggerServerEvent('ce78d2d3-c9e3-443f-bc86-37489eb19062',tostring(GetPlayerServerId(closestPlayer)), false)
			TriggerServerEvent('841a41b8-d3a5-4d25-9d37-2e0803c1e51a',"AMBULANCE ACTION", "INCREASE DEATH TIMER " .. GetPlayerName(closestPlayer), GetPlayerServerId(closestPlayer))

		end
	end
	
end)


RegisterCommand("amboduress", function(source, args)
	ESX.PlayerData = ESX.GetPlayerData()
	--print(GetVehicleMaxNumberOfPassengers(GetVehiclePedIsUsing(GetPlayerPed(-1))))
	if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'ambulance' then

			--if lastduresspress < (GetGameTimer() - 10000) then
					lastduresspress = GetGameTimer()
					local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
					local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
					local street1 = GetStreetNameFromHashKey(s1)
					local street2 = GetStreetNameFromHashKey(s2)
					
					local emergloc = '~o~AMB/FIRE~w~ DURESS: '
					
					
					if s2 ~= 0 then
						emergloc = emergloc .. 'Cnr ' .. street1 .. ' and ' .. street2
					else
						emergloc = emergloc .. ' ' .. street1 
					end
					
					emergloc = emergloc .. ' PANIC BUTTON HAS BEEN PRESSED, Police to respond PRI 1'
					
					
					local loci1 = exports['webcops']:getLocationReturn()

					--TriggerServerEvent('67cc61df-e6be-41d8-9bec-023459661970', GetPlayerServerId(PlayerId()), emergloc, loci1 , plyPos.x, plyPos.y, plyPos.z, 'police', '000', false)
					local PlayerCoords = { x = plyPos.x, y = plyPos.y, z = plyPos.z }
					TriggerServerEvent('c916860b-b2ca-42eb-9eac-cf20b6341eac', 'police', '***AMBVIC DURESS**** :: ' .. emergloc, PlayerCoords, {

							PlayerCoords = { x = plyPos.x, y = plyPos.y, z = plyPos.z },
					})
					
					TriggerServerEvent('c916860b-b2ca-42eb-9eac-cf20b6341eac', 'ambulance', '***AMBVIC DURESS**** :: ' .. emergloc, PlayerCoords, {

							PlayerCoords = { x = plyPos.x, y = plyPos.y, z = plyPos.z },
					})

					--TriggerServerEvent('67cc61df-e6be-41d8-9bec-023459661970', tostring(GetPlayerServerId(PlayerId())), emergloc , plyPos.x, plyPos.y, plyPos.z , 'police', '000', true)
					ESX.ShowNotification("Duress Button has been pressed. Police have been notified.")
				
		--	end
		
	end
	
end)

function VehicleInFront()
  local player = PlayerPedId()
    local pos = GetEntityCoords(player)
    local entityWorld = GetOffsetFromEntityInWorldCoords(player, 0.0, 2.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 30, player, 0)
    local _, _, _, _, result = GetRaycastResult(rayHandle)
    return result
end

local open = false
RegisterNetEvent('347e8d19-9924-449f-9be7-5a7147e107e0')
AddEventHandler('347e8d19-9924-449f-9be7-5a7147e107e0', function()
veh = VehicleInFront()
if open == false then
    open = true
    SetVehicleDoorOpen(veh, 2, false, false)
    Citizen.Wait(1000)
    SetVehicleDoorOpen(veh, 3, false, false)
elseif open == true then
    open = false
    SetVehicleDoorShut(veh, 2, false)
    SetVehicleDoorShut(veh, 3, false)
end
end)
