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

ESX						= nil
local CurrentAction		= nil
local PlayerData		= {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(xPlayer)
	PlayerData = xPlayer
end)

RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function(job)
  PlayerData.job = job
end)

RegisterNetEvent('830cf073-7999-4dab-bae7-2ee8b9295054')
AddEventHandler('830cf073-7999-4dab-bae7-2ee8b9295054', function(dutycheck)
	local playerPed		= GetPlayerPed(-1)
	local coords		= GetEntityCoords(playerPed)
	local stoponesync   = false
	
	


	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle = nil

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end
		

		
		if GetConvar("ose", "false") == "true" then
			if GetVehiclePedIsIn(playerPed, false) == false then
				stoponesync = true
			end
		end
			
		if DoesEntityExist(vehicle) and IsVehicleSeatFree(vehicle, -1) then
		
		
			if Config.IgnoreAbort then
				TriggerServerEvent('d511d756-054c-4d5f-a721-569da1ba38c7')
			end
			TriggerEvent( 'wk:fixVehicle')
			TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)

			Citizen.CreateThread(function()
				ThreadID = GetIdOfThisThread()
				CurrentAction = 'repair'
				SetNetworkIdCanMigrate(vehicle, true)
				NetworkRequestControlOfEntity(vehicle)
				while not NetworkHasControlOfEntity(vehicle) do
					NetworkRequestControlOfEntity(vehicle)
					Citizen.Wait(0)
				end

				Citizen.Wait(Config.RepairTime * 1000)

				if CurrentAction ~= nil then

					
					Citizen.CreateThread(function()
						SetNetworkIdCanMigrate(vehicle, true)
						NetworkRequestControlOfEntity(vehicle)
						while not NetworkHasControlOfEntity(vehicle) do
							NetworkRequestControlOfEntity(vehicle)
							Citizen.Wait(0)
						end
					
						Wait(500)
						SetVehicleUndriveable(vehicle,false)
						SetVehicleBodyHealth(vehicle,1000)
						SetVehicleEngineHealth(vehicle,1000)
					    SetVehicleDeformationFixed(vehicle)
						SetVehicleFixed(vehicle)
						ClearPedTasksImmediately(playerPed)
						ESX.TriggerServerCallback('77956617-7ad0-408c-8c18-5b0db734c4de', function(hasmk)
							SetVehicleOilLevel(vehicle,hasmk.oil)
						end, GetVehicleNumberPlateText(vehicle),VehToNet(vehicle))
					end)
					
					
					ESX.ShowNotification(_U('finished_repair'))
				end

				if not Config.IgnoreAbort then
					TriggerServerEvent('d511d756-054c-4d5f-a721-569da1ba38c7')
				end

				CurrentAction = nil
				TerminateThisThread()
			end)
		end

		Citizen.CreateThread(function()
			Citizen.Wait(0)

			if CurrentAction ~= nil then
				SetTextComponentFormat('STRING')
				AddTextComponentString(_U('abort_hint'))
				DisplayHelpTextFromStringLabel(0, 0, 1, -1)

				if IsControlJustReleased(0, Keys["X"]) then
					TerminateThread(ThreadID)
					ESX.ShowNotification(_U('aborted_repair'))
					CurrentAction = nil
				end
			end

		end)
	else
		ESX.ShowNotification(_U('no_vehicle_nearby'))
	end
end)


RegisterNetEvent('7c6e346e-b72d-4812-b308-73a229d73233')
AddEventHandler('7c6e346e-b72d-4812-b308-73a229d73233', function(dutycheck)


		local playerPed		= GetPlayerPed(-1)
		local coords		= GetEntityCoords(playerPed)
		local stoponesync   = false
		


		if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
			local vehicle = nil

			if IsPedInAnyVehicle(playerPed, false) then
				vehicle = GetVehiclePedIsIn(playerPed, false)
			else
				vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
			end
			
			ESX.TriggerServerCallback('56329a0a-1406-483e-9ff8-02045a2e8eee', function(owned)
			if owned == true then
				TriggerServerEvent('7fcbafb2-e15d-4e94-9a71-c348def151ae',"esx_mecanojob", "FAILED REPAIR OWNED VEHICLE: "  .. GetVehicleNumberPlateText(ESX.Game.GetVehicleInDirection()))
				ESX.ShowNotification("~b~True~w~ Blue ~b~Towing~n~~r~Company policy prohibits repairing a vehicle you own.")

				return
			end

			
			if GetConvar("ose", "false") == "true" then
				if GetVehiclePedIsIn(playerPed, false) == false then
					stoponesync = true
				end
			end
				
			if DoesEntityExist(vehicle) and IsVehicleSeatFree(vehicle, -1) then
			
			
				if Config.IgnoreAbort then
					TriggerServerEvent('d511d756-054c-4d5f-a721-569da1ba38c7')
				end
				TriggerEvent( 'wk:fixVehicle')
				TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)

				Citizen.CreateThread(function()
					ThreadID = GetIdOfThisThread()
					CurrentAction = 'repair'
					SetNetworkIdCanMigrate(vehicle, true)
					NetworkRequestControlOfEntity(vehicle)
					while not NetworkHasControlOfEntity(vehicle) do
						NetworkRequestControlOfEntity(vehicle)
						Citizen.Wait(0)
					end

					Citizen.Wait(Config.RepairTime * 1000)

					if CurrentAction ~= nil then

						
						Citizen.CreateThread(function()
							SetNetworkIdCanMigrate(vehicle, true)
							NetworkRequestControlOfEntity(vehicle)
							while not NetworkHasControlOfEntity(vehicle) do
								NetworkRequestControlOfEntity(vehicle)
								Citizen.Wait(0)
							end
						
							Wait(500)
							SetVehicleUndriveable(vehicle,false)
							SetVehicleBodyHealth(vehicle,1000)
							SetVehicleEngineHealth(vehicle,1000)
							SetVehicleDeformationFixed(vehicle)
							SetVehicleFixed(vehicle)
							ClearPedTasksImmediately(playerPed)
							ESX.TriggerServerCallback('77956617-7ad0-408c-8c18-5b0db734c4de', function(hasmk)
								SetVehicleOilLevel(vehicle,hasmk.oil)
							end, GetVehicleNumberPlateText(vehicle),VehToNet(vehicle))
						end)
						
						
						ESX.ShowNotification(_U('finished_repair'))
					end

					if not Config.IgnoreAbort then
						TriggerServerEvent('d511d756-054c-4d5f-a721-569da1ba38c7')
					end

					CurrentAction = nil
					TerminateThisThread()
				end)
			end

			Citizen.CreateThread(function()
				Citizen.Wait(0)

				if CurrentAction ~= nil then
					SetTextComponentFormat('STRING')
					AddTextComponentString(_U('abort_hint'))
					DisplayHelpTextFromStringLabel(0, 0, 1, -1)

					if IsControlJustReleased(0, Keys["X"]) then
						TerminateThread(ThreadID)
						ESX.ShowNotification(_U('aborted_repair'))
						CurrentAction = nil
					end
				end

			end)
			end, GetVehicleNumberPlateText(vehicle), GetVehicleNumberPlateText(vehicle))
		else
			ESX.ShowNotification(_U('no_vehicle_nearby'))
		end


end)

RegisterNetEvent('8ac954a0-4623-4402-9884-7793e6a36aa3')
AddEventHandler('8ac954a0-4623-4402-9884-7793e6a36aa3', function(onesync)
	local playerPed		= GetPlayerPed(-1)
	local coords		= GetEntityCoords(playerPed)
	local stoponesync   = false

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle = nil

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end
		

		
		if GetConvar("ose", "false") == "true" then
			if GetVehiclePedIsIn(playerPed, false) == false then
				stoponesync = true
			end
		end
			
		if DoesEntityExist(vehicle) and IsVehicleSeatFree(vehicle, -1) then
			if Config.IgnoreAbort then
				TriggerServerEvent('336209e4-f4ac-4b21-9021-906c5f909829')
			end
			TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
			
			Citizen.CreateThread(function()
				ThreadID = GetIdOfThisThread()
				CurrentAction = 'repair'
				SetNetworkIdCanMigrate(vehicle, true)
				NetworkRequestControlOfEntity(vehicle)
				while not NetworkHasControlOfEntity(vehicle) do
					NetworkRequestControlOfEntity(vehicle)
					Citizen.Wait(0)
				end

				Citizen.Wait(Config.RepairTime * 1000)

				if CurrentAction ~= nil then

					
					Citizen.CreateThread(function()
						SetNetworkIdCanMigrate(vehicle, true)
						NetworkRequestControlOfEntity(vehicle)
						while not NetworkHasControlOfEntity(vehicle) do
							NetworkRequestControlOfEntity(vehicle)
							Citizen.Wait(0)
						end
					
						Wait(500)
						
						ClearPedTasksImmediately(playerPed)
					end)
					
					ESX.TriggerServerCallback('77956617-7ad0-408c-8c18-5b0db734c4de', function(hasmk)
						local newoil = tonumber(hasmk.oil) + 2.50
						SetVehicleOilLevel(vehicle,newoil)
						TriggerServerEvent('832b5f5d-a5a9-4e73-96e2-ed7fd49923e7',GetVehicleNumberPlateText(vehicle),hasmk.km,newoil)
					end, GetVehicleNumberPlateText(vehicle),VehToNet(vehicle))
					ESX.ShowNotification('~g~You finished filling the car with a little bit of oil')
				end


				CurrentAction = nil
				TerminateThisThread()
			end)
		end

		Citizen.CreateThread(function()
			Citizen.Wait(0)

			if CurrentAction ~= nil then
				SetTextComponentFormat('STRING')
				AddTextComponentString(_U('abort_hint'))
				DisplayHelpTextFromStringLabel(0, 0, 1, -1)

				if IsControlJustReleased(0, Keys["X"]) then
					TerminateThread(ThreadID)
					ESX.ShowNotification(_U('aborted_repair'))
					CurrentAction = nil
				end
			end

		end)
	else
		ESX.ShowNotification(_U('no_vehicle_nearby'))
	end
end)



RegisterNetEvent('354c8e08-87fd-46cf-bfff-3d12e8410a66')
AddEventHandler('354c8e08-87fd-46cf-bfff-3d12e8410a66', function(onesync)
	local playerPed		= GetPlayerPed(-1)
	local coords		= GetEntityCoords(playerPed)
	local stoponesync   = false

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle = nil

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end
		

		
		if GetConvar("ose", "false") == "true" then
			if GetVehiclePedIsIn(playerPed, false) == false then
				stoponesync = true
			end
		end
			
		if DoesEntityExist(vehicle) and IsVehicleSeatFree(vehicle, -1) then

			TriggerEvent( 'wk:fixVehicle')
			TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)

			Citizen.CreateThread(function()
				ThreadID = GetIdOfThisThread()
				CurrentAction = 'repair'
				SetNetworkIdCanMigrate(vehicle, true)
				NetworkRequestControlOfEntity(vehicle)
				while not NetworkHasControlOfEntity(vehicle) do
					NetworkRequestControlOfEntity(vehicle)
					Citizen.Wait(0)
				end
				local phrases = {
				"Ok you can do this!",
				"Sugar, I should paid more attention in school",
				"The boys do it this cant be that hard",
				"Not paying for bloody roadside as well, wholey cow!",
				"Next time I'll take a bloody train",
				"See I'm not useless I can do this.",
				"This would be fun they say, what a great idea",
				"What can go wrong next?",
				"Am I supposed to put on my hazard lights?",
				"Who the hell thought this would be a good idea",
				"This shit heap will be the death of me",
				"Look everyone! Stop! I'm doin stuff!",
				"Are we there yet already sheesh"}
				ESX.ShowNotification("Staring the repair my friends!")
				Citizen.Wait(Config.RepairTime * 1000)
				ESX.ShowNotification(phrases[math.random(1,#phrases)])
				Citizen.Wait(18 * 1000)
				ESX.ShowNotification(phrases[math.random(1,#phrases)])
				Citizen.Wait(18 * 1000)
				if Config.IgnoreAbort then
					TriggerServerEvent('d511d756-054c-4d5f-a721-569da1ba38c7')
				end
				if CurrentAction ~= nil then

					
					Citizen.CreateThread(function()
						SetNetworkIdCanMigrate(vehicle, true)
						NetworkRequestControlOfEntity(vehicle)
						while not NetworkHasControlOfEntity(vehicle) do
							NetworkRequestControlOfEntity(vehicle)
							Citizen.Wait(0)
						end
					
						Wait(500)
						SetVehicleUndriveable(vehicle,false)
						SetVehicleBodyHealth(vehicle,1000)
						SetVehicleEngineHealth(vehicle,1000)
					    SetVehicleDeformationFixed(vehicle)
						SetVehicleFixed(vehicle)

						ClearPedTasksImmediately(playerPed)
					end)
					
					ESX.TriggerServerCallback('77956617-7ad0-408c-8c18-5b0db734c4de', function(hasmk)
						SetVehicleOilLevel(vehicle,hasmk.oil)
					end, GetVehicleNumberPlateText(vehicle),VehToNet(vehicle))
					ESX.ShowNotification(_U('finished_repair'))
				end

				if not Config.IgnoreAbort then
					TriggerServerEvent('d511d756-054c-4d5f-a721-569da1ba38c7')
				end

				CurrentAction = nil
				TerminateThisThread()
			end)
		end

		Citizen.CreateThread(function()
			Citizen.Wait(0)

			if CurrentAction ~= nil then
				SetTextComponentFormat('STRING')
				AddTextComponentString(_U('abort_hint'))
				DisplayHelpTextFromStringLabel(0, 0, 1, -1)

				if IsControlJustReleased(0, Keys["X"]) then
					TerminateThread(ThreadID)
					ESX.ShowNotification(_U('aborted_repair'))
					CurrentAction = nil
				end
			end

		end)
	else
		ESX.ShowNotification(_U('no_vehicle_nearby'))
	end
end)




RegisterNetEvent('3dee97c9-f076-41a0-9226-61fb61297454')
AddEventHandler('3dee97c9-f076-41a0-9226-61fb61297454', function()
	local playerPed		= GetPlayerPed(-1)
	local coords		= GetEntityCoords(playerPed)
	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end
		
		if DoesEntityExist(vehicle) then
			TriggerServerEvent('8014f3ee-d4cf-4b18-995c-72e9e0a35cb0',VehToNet(vehicle),GetVehicleNumberPlateText(vehicle))
		end
		
	
	end

end)

RegisterNetEvent('d4b8c2a1-f5dd-411a-9998-7ff4a43ce077')
AddEventHandler('d4b8c2a1-f5dd-411a-9998-7ff4a43ce077', function(plate)
	local playerPed		= GetPlayerPed(-1)
	local coords		= GetEntityCoords(playerPed)
	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle = nil

		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end
		
		if DoesEntityExist(vehicle) then
		
			Citizen.CreateThread(function()
	

				SetNetworkIdCanMigrate(vehicle, true)
				NetworkRequestControlOfEntity(vehicle)
				while not NetworkHasControlOfEntity(vehicle) do
					NetworkRequestControlOfEntity(vehicle)
					Citizen.Wait(0)
				end
			
				SetVehicleNumberPlateText(vehicle,plate)

				ClearPedTasksImmediately(playerPed)
			end)
		
		end
		
	end
		
end)

RegisterNetEvent('8472525d-cb39-497a-9e4d-b89316d4466c')
AddEventHandler('8472525d-cb39-497a-9e4d-b89316d4466c', function(onesync)
	local playerPed		= GetPlayerPed(-1)
	local coords		= GetEntityCoords(playerPed)
	local stoponesync   = false

	if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then
		local vehicle = nil
		
		if IsPedInAnyVehicle(playerPed, false) then
			vehicle = GetVehiclePedIsIn(playerPed, false)
		else
			vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
		end
		

		
		if GetConvar("ose", "false") == "true" then
			if GetVehiclePedIsIn(playerPed, false) == false then
				stoponesync = true
			end
		end
			
		if DoesEntityExist(vehicle) then
		
			
			if GetVehicleDoorLockStatus(vehicle) ~= 1 then
				ESX.ShowNotification("You try and keep trying but its not working")
				return
			end
			if Config.IgnoreAbort then
				TriggerServerEvent('01fa622c-a8a4-4a0d-8f4e-310660e0e631')
			end

			TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)

			Citizen.CreateThread(function()
				ThreadID = GetIdOfThisThread()
				CurrentAction = 'repair'

				Citizen.Wait(Config.RepairTime * 1000)

				if CurrentAction ~= nil then
					
					TriggerServerEvent('f2817b28-8648-49cf-a76c-db234c95b05a',VehToNet(vehicle),GetVehicleNumberPlateText(vehicle))
					Citizen.CreateThread(function()
					
						Wait(500)

						SetVehicleNumberPlateText(vehicle,' ')

	
						ClearPedTasksImmediately(playerPed)
					end)
					
					
					ESX.ShowNotification('Finished removing the number plate')
				end

				if not Config.IgnoreAbort then
					TriggerServerEvent('d511d756-054c-4d5f-a721-569da1ba38c7')
				end

				CurrentAction = nil
				TerminateThisThread()
			end)
		end

		Citizen.CreateThread(function()
			Citizen.Wait(0)

			if CurrentAction ~= nil then
				SetTextComponentFormat('STRING')
				AddTextComponentString(_U('abort_hint'))
				DisplayHelpTextFromStringLabel(0, 0, 1, -1)

				if IsControlJustReleased(0, Keys["X"]) then
					TerminateThread(ThreadID)
					ESX.ShowNotification('Modification aborted')
					CurrentAction = nil
				end
			end

		end)
	else
		ESX.ShowNotification(_U('no_vehicle_nearby'))
	end
end)