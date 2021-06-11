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

ESX                     = nil
local CurrentAction     = nil
local CurrentActionMsg  = nil
local CurrentActionData = nil
local Licenses          = {}
local CurrentTest       = nil
local CurrentTestType   = nil
local CurrentVehicle    = nil
local CurrentCheckPoint = 0
local LastCheckPoint    = -1
local CurrentBlip       = nil
local CurrentZoneType   = nil
local DriveErrors       = 0
local IsAboveSpeedLimit = false
local LastVehicleHealth = nil

local Vehicles                = {}

local closer				= false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	--Citizen.Wait(20000)
	--TriggerServerEvent('73728a48-a43d-4ca7-93b4-62c48c2f192a')
end)

function DrawMissionText(msg, time)
	ClearPrints()
	SetTextEntry_2('STRING')
	AddTextComponentString(msg)
	DrawSubtitleTimed(time, 1)
end

function StartTheoryTest()
	CurrentTest = 'theory'

	SendNUIMessage({
		openQuestion = true
	})

	ESX.SetTimeout(1000, function()
		SetNuiFocus(true, true)
	end)
	SetNuiFocus(true, true)
	TriggerServerEvent('b188e32e-6a9a-416c-bdb2-fb857e7265df', Config.Prices['dmv'])
end

function StopTheoryTest(success)
	CurrentTest = nil

	SendNUIMessage({
		openQuestion = false
	})

	SetNuiFocus(false)

	if success then
		TriggerServerEvent('dfbafdf3-e5ff-4ac3-a838-e8ea5a6d420f', 'dmv')
		exports.webcops:toggleLearn()
		exports.webcops:toggleCurrent()
		ESX.ShowNotification(_U('passed_test'))
	else
		ESX.ShowNotification(_U('failed_test'))
	end
end

function StartDriveTest(type)
		ESX.Game.SpawnVehicle(Config.VehicleModels[type], Config.Zones.VehicleSpawnPoint.Pos, 317.0, function(vehicle)
		CurrentTest       = 'drive'
		CurrentTestType   = type
		CurrentCheckPoint = 0
		LastCheckPoint    = -1
		CurrentZoneType   = 'residence'
		DriveErrors       = 0
		IsAboveSpeedLimit = false
		CurrentVehicle    = vehicle
		LastVehicleHealth = GetEntityHealth(vehicle)

		local playerPed   = GetPlayerPed(-1)
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		SetVehicleNumberPlateText(vehicle, 'VICROADS')
		
		Citizen.CreateThread(function()
		Citizen.Wait(3000)
		TriggerServerEvent('ed07d5fd-9abb-4f0a-a54e-9f5b9d9f50da', 'VICROADS', 99.00)
		SetVehicleFuelLevel(vehicle, 99.0)
		Citizen.Wait(10000)
		TriggerServerEvent('ed07d5fd-9abb-4f0a-a54e-9f5b9d9f50da', 'VICROADS', 99.00)
		SetVehicleFuelLevel(vehicle, 99.0)

		end)

	end)

	TriggerServerEvent('b188e32e-6a9a-416c-bdb2-fb857e7265df', Config.Prices[type])
end

function StopDriveTest(success)
	if success then
		TriggerServerEvent('dfbafdf3-e5ff-4ac3-a838-e8ea5a6d420f', CurrentTestType)
		
		if CurrentTestType == 'drive' then
			exports.webcops:toggleFullCar()
			exports.webcops:toggleCurrent()
		elseif CurrentTestType == 'drive_bike' then
			exports.webcops:toggleMB()
			exports.webcops:toggleCurrent()
		elseif CurrentTestType == 'drive_truck' then
			exports.webcops:toggleHeavyCombination()
			exports.webcops:toggleCurrent()
		end
		ESX.ShowNotification(_U('passed_test'))
	else
		ESX.ShowNotification(_U('failed_test'))
	end

	CurrentTest     = nil
	CurrentTestType = nil
end

function SetCurrentZoneType(type)
CurrentZoneType = type
end

function OpenDMVSchoolMenu()

	ESX.TriggerServerCallback('d4fe06ee-f0da-4b24-806d-b530c8b2dad2', function (lic)
		Licenses = lic
		local ownedLicenses = {}

		for i=1, #Licenses, 1 do
			ownedLicenses[Licenses[i].type] = true
		end

		local elements = {}

		if not ownedLicenses['dmv'] then
			table.insert(elements, {label = _U('theory_test') .. ' <span style="color: green;">$' .. Config.Prices['dmv'] .. '</span>', value = 'theory_test'})
		end

		if ownedLicenses['dmv'] then

			if not ownedLicenses['drive'] then
				table.insert(elements, {label = _U('road_test_car') .. ' <span style="color: green;">$' .. Config.Prices['drive'] .. '</span>', value = 'drive_test', type = 'drive'})
			end

			if not ownedLicenses['drive_bike'] then
				table.insert(elements, {label = _U('road_test_bike') .. ' <span style="color: green;">$' .. Config.Prices['drive_bike'] .. '</span>', value = 'drive_test', type = 'drive_bike'})
			end

			if  ownedLicenses['drive'] then
				if not ownedLicenses['drive_truck'] then
					table.insert(elements, {label = _U('road_test_truck') .. ' <span style="color: green;">$' .. Config.Prices['drive_truck'] .. '</span>', value = 'drive_test', type = 'drive_truck'})
				end
			end
			
			table.insert(elements, {label = 'Change Address' .. ' <span style="color: orange;">~$' .. '1000' .. '</span>', value = 'change_address', type = 'lic'})
			table.insert(elements, {label = 'Change Name' .. ' <span style="color: orange;">~$' .. '3000' .. '</span>', value = 'change_name', type = 'lic'})
			
			if ownedLicenses['drive'] or ownedLicenses['drive_bike'] or ownedLicenses['drive_truck'] then
				table.insert(elements, {label = 'Renew Licence' .. ' <span style="color: green;">~$' .. '850' .. '</span>', value = 'renew', type = 'lic'})
				table.insert(elements, {label = 'Renew Car Registration || Zone City' .. ' <span style="color: green;">$' .. '850' .. '</span>', value = 'regz1', type = 'reg'})
				table.insert(elements, {label = 'Renew Car Registration || Zone Blaine County ' .. ' <span style="color: green;">$' .. '850' .. '</span>', value = 'regz2', type = 'reg'})
				table.insert(elements, {label = 'Custom Registration Plates || Zone City ' .. ' <span style="color: green;">' .. 'whitelisted/supporters' .. '</span>', value = 'regchangez1', type = 'reg'})
				table.insert(elements, {label = 'Custom Registration Plates || Zone Blaine County' .. ' <span style="color: green;">' .. 'whitelisted/supporters' .. '</span>', value = 'regchangez2', type = 'reg'})
			end
			
		else
			table.insert(elements, {label = 'Change Address' .. ' <span style="color: orange;">~$' .. '1000' .. '</span>', value = 'change_address', type = 'lic'})
			table.insert(elements, {label = 'Change Name' .. ' <span style="color: orange;">~$' .. '3000' .. '</span>', value = 'change_name', type = 'lic'})

		end

		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'dmvschool_actions',
		{
			title    = _U('driving_school'),
			elements = elements,
			align    = 'top-right',
		}, function(data, menu)
			if data.current.value == 'theory_test' then
				menu.close()
				StartTheoryTest()
			end
			
			if data.current.value == 'renew' then
				menu.close()
				exports.webcops:toggleCurrent()
			end

			if data.current.value == 'drive_test' then
				menu.close()
				StartDriveTest(data.current.type)
			end
			
			if data.current.value == 'regz1' then
				menu.close()
				OpenRegoMenu(1)
			end
			
			if data.current.value == 'regz2' then
				menu.close()
				OpenRegoMenu(2)
			end
			
			
			if data.current.value == 'regchangez1' then
				menu.close()
				OpenRegoChanger(1)
			end
			
			if data.current.value == 'regchangez2' then
				menu.close()
				OpenRegoChanger(2)
			end
			
			if data.current.value == 'change_name' then
				ChangeName()
			end
			
			if data.current.value == 'change_address' then
				ChangeAddress()
			end

			end, function(data, menu)
				menu.close()

				CurrentAction     = 'dmvschool_menu'
				CurrentActionMsg  = _U('press_open_menu')
				CurrentActionData = {}
			end
		)
	end)
end


function ChangeName()
local chosePrice = nil
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'change_name',
		{
			title = 'VICROADS - CHANGE FULL NAME'
		},
	function(data, menu)
		local name = data.value
		local names = stringsplit(name, " ")
		if names[1] ~= nil and names[2] ~= nil then
			TriggerServerEvent('86768e4b-00dc-44e2-8974-c1e34f4162de',names[1],names[2])
			menu.close()
			OpenDMVSchoolMenu()
		else
			ESX.ShowNotification('~r~Error: ~w~You must provide a first and last name.')
		end
	end, function(data, menu)
		menu.close()
		OpenDMVSchoolMenu()
	end)


end

function ChangeAddress()
local chosePrice = nil
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'change_address',
		{
			title = 'VICROADS - CHANGE ADDRESS'
		},
	function(data, menu)
		local address = data.value
		if string.len(address) > 8 then
			TriggerServerEvent('524e649c-ba86-428a-9eab-cf7e22b70e3b',address)
			menu.close()
		else
			ESX.ShowNotification('~r~Error:~w~ Address is of insufficient length')
		end
		
		
	end, function(data, menu)
		menu.close()
	end)


end

RegisterNUICallback('question', function(data, cb)
	SendNUIMessage({
		openSection = 'question'
	})

	cb('OK')
end)

RegisterNUICallback('close', function(data, cb)
	StopTheoryTest(true)
	cb('OK')
end)

RegisterNUICallback('kick', function(data, cb)
	StopTheoryTest(false)
	cb('OK')
end)

AddEventHandler('3d16ee4b-8f6e-42cd-8088-cd086aa9f569', function(zone)
	if zone == 'DMVSchool' then
		CurrentAction     = 'dmvschool_menu'
		CurrentActionMsg  = _U('press_open_menu')
		CurrentActionData = {}
	end
end)

AddEventHandler('8c1fa7df-8b7c-4f44-a28f-c7b9fa5806cb', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

RegisterNetEvent('af88a31f-52a0-4946-a5b6-22d154409450')
AddEventHandler('af88a31f-52a0-4946-a5b6-22d154409450', function(licenses)
	Licenses = licenses
end)

-- Create Blips
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Zones.DMVSchool.Pos.x, Config.Zones.DMVSchool.Pos.y, Config.Zones.DMVSchool.Pos.z)

	SetBlipSprite (blip, 315)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.1)
	SetBlipAsShortRange(blip, false)
	SetBlipBright(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(_U('driving_school_blip'))
	EndTextCommandSetBlipName(blip)
end)

-- Display markers
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		local coords = GetEntityCoords(GetPlayerPed(-1))
		local zcloser = false
		for k,v in pairs(Config.Zones) do
			if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
				zcloser = true
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
			end
		end
		if zcloser == false then
			closer = false
			Wait(2000)
		else
			closer = true
		end

	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(100)
		if closer then
			local coords      = GetEntityCoords(GetPlayerPed(-1))
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
				TriggerEvent('3d16ee4b-8f6e-42cd-8088-cd086aa9f569', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('8c1fa7df-8b7c-4f44-a28f-c7b9fa5806cb', LastZone)
			end
		else
			Wait(1500)
		end
	end
end)

-- Block UI
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1)

		if CurrentTest == 'theory' then
			local playerPed = GetPlayerPed(-1)

			DisableControlAction(0, 1, true) -- LookLeftRight
			DisableControlAction(0, 2, true) -- LookUpDown
			DisablePlayerFiring(playerPed, true) -- Disable weapon firing
			DisableControlAction(0, 142, true) -- MeleeAttackAlternate
			DisableControlAction(0, 106, true) -- VehicleMouseControlOverride
		else
			Citizen.Wait(3000)
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(15)

		if CurrentAction ~= nil then
			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)

			if IsControlJustReleased(0, Keys['E']) then
				if CurrentAction == 'dmvschool_menu' then
					OpenDMVSchoolMenu()
				end

				CurrentAction = nil
			end
		else
			Wait(1500)
		end
	end
end)

-- Drive test
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(10)

		if CurrentTest == 'drive' then
			local playerPed      = GetPlayerPed(-1)
			local coords         = GetEntityCoords(playerPed)
			local nextCheckPoint = CurrentCheckPoint + 1

			if Config.CheckPoints[nextCheckPoint] == nil then
				if DoesBlipExist(CurrentBlip) then
					RemoveBlip(CurrentBlip)
				end

				CurrentTest = nil

				ESX.ShowNotification(_U('driving_test_complete'))

				if DriveErrors < Config.MaxErrors then
					StopDriveTest(true)
				else
					StopDriveTest(false)
				end
			else

				if CurrentCheckPoint ~= LastCheckPoint then

					if DoesBlipExist(CurrentBlip) then
						RemoveBlip(CurrentBlip)
					end

					CurrentBlip = AddBlipForCoord(Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z)
					SetBlipRoute(CurrentBlip, 1)

					LastCheckPoint = CurrentCheckPoint
				end

				local distance = GetDistanceBetweenCoords(coords, Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z, true)

				if distance <= 100.0 then
					DrawMarker(1, Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
				end

				if distance <= 3.0 then
					Config.CheckPoints[nextCheckPoint].Action(playerPed, CurrentVehicle, SetCurrentZoneType)
					CurrentCheckPoint = CurrentCheckPoint + 1
				end
			end
		
		else
			Wait(2500)
		end
	end
end)

-- Speed / Damage control
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if CurrentTest == 'drive' then

			local playerPed = GetPlayerPed(-1)

			if IsPedInAnyVehicle(playerPed,  false) then

				local vehicle      = GetVehiclePedIsIn(playerPed,  false)
				local speed        = GetEntitySpeed(vehicle) * Config.SpeedMultiplier
				local tooMuchSpeed = false

				for k,v in pairs(Config.SpeedLimits) do
					if CurrentZoneType == k and speed > v then
						tooMuchSpeed = true

						if not IsAboveSpeedLimit then
							DriveErrors       = DriveErrors + 1
							IsAboveSpeedLimit = true

							ESX.ShowNotification(_U('driving_too_fast', v))
							ESX.ShowNotification(_U('errors', DriveErrors, Config.MaxErrors))
						end
					end
				end

				if not tooMuchSpeed then
					IsAboveSpeedLimit = false
				end

				local health = GetEntityHealth(vehicle)

				if health < LastVehicleHealth then

					DriveErrors = DriveErrors + 1

					ESX.ShowNotification(_U('you_damaged_veh'))
					ESX.ShowNotification(_U('errors', DriveErrors, Config.MaxErrors))

					-- avoid stacking faults
					Citizen.Wait(1000)
					LastVehicleHealth = health
				end
			end
			
		else
			Citizen.Wait(5000)
		end
	end
end)


function OpenRegoMenu(zone)

  ESX.UI.Menu.CloseAll()

  ESX.TriggerServerCallback('823f1057-0613-49d2-9711-ae001827ca33', function (vehicles, expiry)
    local elements = {}

	
	for i=1, #expiry, 1 do
		Citizen.Trace(i)
	end

    for i=1, #vehicles, 1 do
	
	
		local model = ' '
		 if GetDisplayNameFromVehicleModel(vehicles[i].model) ~= nil then
			model = GetDisplayNameFromVehicleModel(vehicles[i].model)
			Citizen.Trace(model)
		end
		local plate = ' '
		if vehicles[i].plate ~= nil then
			plate = vehicles[i].plate
			Citizen.Trace(plate)
		end
      table.insert(elements, {label = model .. ' [<span style="color: orange;">' .. plate .. '</span>]' .. ' Expires: ' .. expiry[i] , value = vehicles[i]})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'personnal_vehicle',
      {
        title    = 'Vehicle Rego/Expiration',
        align    = 'top-right',
        elements = elements,
      },
      function (data, menu)
        local playerPed   = PlayerPedId()
        local coords      = GetEntityCoords(playerPed)
        local heading     = GetEntityHeading(playerPed)

        local vehicleData = data.current.value
        menu.close()
	
		TriggerServerEvent('1db290dd-a77a-46f9-bdda-31aa82cd58fd',vehicleData.plate)
		Wait(600)
		OpenRegoMenu(zone)
      end,
      function (data, menu)
       	 menu.close()
		OpenDMVSchoolMenu()
      end
    )
  end,zone)
  
 
end


function GetTextCC()

  local limit = data.limit or 255
  local text = data.text or ''
  
   AddTextEntry('FMMC_KEY_TIP1', TextEntry .. ':') --Sets the Text above the typing field in the black square
   DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
  while (UpdateOnscreenKeyboard() == 0) do
      DisableAllControlActions(0);
      Wait(0);
  end
  if (GetOnscreenKeyboardResult()) then
      text = GetOnscreenKeyboardResult()
  end
  return text
end

function KeyboardInput(TextEntry, ExampleText, MaxStringLenght) -- ps thanks @Flatracer
    -- TextEntry		-->	The Text above the typing field in the black square
    -- ExampleText		-->	An Example Text, what it should say in the typing field
    -- MaxStringLenght	-->	Maximum String Lenght
    
    AddTextEntry('FMMC_KEY_TIP1', TextEntry .. ':') --Sets the Text above the typing field in the black square
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght) --Actually calls the Keyboard Input
    blockinput = true --Blocks new input while typing if **blockinput** is used
    
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do --While typing is not aborted and not finished, this loop waits
        Citizen.Wait(0)
    end
            
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult() --Gets the result of the typing
        Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
        blockinput = false --This unblocks new Input when typing is done
        return result --Returns the result
    else
        blockinput = false --This unblocks new Input when typing is done
        return nil --Returns nil if the typing got aborted
    end
end

function rtrim(s)
  return s:match'^(.*%S)%s*$'
end

function ltrim(s)
  return s:match'^%s*(.*)'
end



function OpenRegoChanger(zone)

  ESX.UI.Menu.CloseAll()

  ESX.TriggerServerCallback('823f1057-0613-49d2-9711-ae001827ca33', function (vehicles, expiry)
    local elements = {}

	
	for i=1, #expiry, 1 do
		Citizen.Trace(i)
	end

    for i=1, #vehicles, 1 do
	
	
		local model = ' '
		 if GetDisplayNameFromVehicleModel(vehicles[i].model) ~= nil then
			model = GetDisplayNameFromVehicleModel(vehicles[i].model)
			Citizen.Trace(model)
		end
		local plate = ' '
		if vehicles[i].plate ~= nil then
			plate = vehicles[i].plate
			Citizen.Trace(plate)
		end
      table.insert(elements, {label = model .. ' [<span style="color: blue;">' .. plate .. '</span>]' , value = vehicles[i]})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'personnal_vehicle',
      {
        title    = 'Change Vehicle Rego Plates',
        align    = 'top-right',
        elements = elements,
      },
      function (data, menu)
        local playerPed   = PlayerPedId()
        local coords      = GetEntityCoords(playerPed)
        local heading     = GetEntityHeading(playerPed)

        local vehicleData = data.current.value
        menu.close()
		ESX.ShowNotification('~r~Warning:~w~Using inappropriate words, will result in a ban and vehicle will be deleted.')
		
		Wait(1000)
		ESX.ShowNotification('~r~Warning:~w~You will lose contents of your boot. There are ~r~no refunds. ~g~Press escape to cancel.')
		Wait(500)
		local newplate = KeyboardInput('New Plate? EG: C TUBBY (8 Characters Max) No special characters!', '', 8)
		
		local platecheck = string.match(newplate,"%p")
		if platecheck ~= nil and string.len(platecheck) > 0 then
			ESX.ShowNotification('~r~Error~w~\nDon\'t use special characters in plates please.')
			return
		end


		if string.len(rtrim(ltrim(newplate))) < 5 or string.len(rtrim(ltrim(newplate))) > 8 then
			ESX.ShowNotification('~r~Error~w~\nYour plate must be at least 5 characters and no more than 8.')
			return
		end

		


		ESX.TriggerServerCallback('2748b967-d37c-420b-8100-32744235fabf', function (result)
			if result then
				ESX.ShowNotification('~g~Well done plate changed successfully.')
				ESX.ShowNotification('~r~Warning\n~o~If you have the vehicle out it will appear to police to be unregistered.')
			else
				ESX.ShowNotification('~o~Error\n~w~Unsuccessful in changing this vehicle plate.')
			end
			Wait(600)
			OpenRegoChanger(zone)
		
		end,data.current.value.plate,newplate,newplate)
		
		--TriggerServerEvent('1db290dd-a77a-46f9-bdda-31aa82cd58fd',vehicleData.plate)
	
      end,
      function (data, menu)
       	 menu.close()
		OpenDMVSchoolMenu()
      end
    )
  end, zone)
  
 
end


function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end