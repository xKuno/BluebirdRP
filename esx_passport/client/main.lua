print(GetEntityHeading(GetPlayerPed(-1)))

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
local inNY = false
local forcedhere = false


local Vehicles                = {}

local closer				= false

local finalloc = {x = -1889.76, y =3986.27, z = 40.11} 

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	--Citizen.Wait(20000)
	--TriggerServerEvent('60ce12fb-f2f3-466e-82f3-9e7c6a307a70')
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

end


RegisterNetEvent('2d96dc91-ffd2-4f2b-82a6-2b24a3f38c2e')
AddEventHandler('2d96dc91-ffd2-4f2b-82a6-2b24a3f38c2e', function(x,y,z)
local _source = source
	if x == nil then
		x = finalloc.x
		y = finalloc.y
		z = finalloc.z
	end
	NYappear(x,y,z)
	ESX.UI.Menu.CloseAll()
end)




RegisterNetEvent('46dfaa02-a7ec-48c4-9462-afdbe5dda5a5')
AddEventHandler('46dfaa02-a7ec-48c4-9462-afdbe5dda5a5', function()
	NYLeave()
	ESX.UI.Menu.CloseAll()
end)

function StopTheoryTest(success)
	CurrentTest = nil

	SendNUIMessage({
		openQuestion = false
	})

	SetNuiFocus(false)

	if success then
		ESX.ShowNotification('You have ~g~passed the ~b~Blue~w~Bird~b~RP~w~ Citizenship Exam')
		
		TriggerServerEvent('7d1e7f28-5105-4415-bae0-be66023be711')
		SetEntityProofs(GetPlayerPed(-1),false,false,false,false,false,false,1,false)
		Citizen.CreateThread(function()
			Wait(5000)
			exports.ny:NYLeave()
		end)
	else
		ESX.ShowNotification('You have ~r~failed the ~b~Blue~w~Bird~b~RP~w~ Citizenship Exam')
	end
end



function SetCurrentZoneType(type)
CurrentZoneType = type
end

function OpenDMVSchoolMenu()

	ESX.TriggerServerCallback('1242920b-7da6-4edd-8dce-0f17fc5c501f', function (lic)
		Licenses = lic
		local ownedLicenses = {}
		
		local elements = {}
		
		
		table.insert(elements, {label = ' <span style="color: red;">Setup your Look</span>', value = 'setup_character'})
				
	

		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'dmvschool_actions',
		{
			title    = 'Australian Dept of Immigration',
			elements = elements,
			align    = 'top-right',
		}, function(data, menu)
			if data.current.value == 'theory_test' then
				menu.close()
				StartTheoryTest()
			end
			
			if data.current.value == 'setup_character' then
				ExecuteCommand('skin')
			end
			if data.current.value == 'setup_id' then
				TriggerEvent('5ad0c096-c37d-4d48-b3e1-71ec3994aec5')
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

function OpenSetupID()

	ESX.TriggerServerCallback('1242920b-7da6-4edd-8dce-0f17fc5c501f', function (lic)
		Licenses = lic
		local ownedLicenses = {}
		
		local elements = {}
		
		
		if  Licenses[1].fnl == 0 and Licenses[1].lnl == 0 then
			table.insert(elements, {label = ' <span style="color: red;">2. Setup your identity.</span>', value = 'setup_id'})
		else
			table.insert(elements, {label = ' <span style="color: green;">Great, you are already done, move to the next one!</span>', value = ' '})
		end

		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'dmvschool_actions',
		{
			title    = 'Australian Dept of Immigration',
			elements = elements,
			align    = 'top-right',
		}, function(data, menu)

			if data.current.value == 'setup_id' then
				TriggerEvent('5ad0c096-c37d-4d48-b3e1-71ec3994aec5')
			end

			end, function(data, menu)
				menu.close()

				CurrentAction     = 'setupid_menu'
				CurrentActionMsg  = _U('press_open_menu')
				CurrentActionData = {}
			end
		)
	end)
end


function OpenVoiceID()

	local ownedLicenses = {}
		
		local elements = {}
		
		
			table.insert(elements, {label = ' <span style="color: red;">3a. Go to Settings -> Voice Chat.', value = 'setup_id'})
			table.insert(elements, {label = ' <span style="color: blue;">3b. Turn Voice Chat off and back on (resets voice chat).', value = 'setup_id'})
			table.insert(elements, {label = ' <span style="color: green;">3c. Ensure Output Device (speakers) are set correctly and volume level is suitable.', value = 'setup_id'})
			table.insert(elements, {label = ' <span style="color: orange;">3d. Ensure Input Device (microphone) is on, correct input device selected and input volumes high.', value = 'setup_id'})
			table.insert(elements, {label = ' <span style="color: white;">Help: If at any time you\'re unsure Press [F3] and click the voice icon.', value = 'setup_id'})
			table.insert(elements, {label = ' <span style="color: yellow;">Great well done - once you are here move onto 4.</span>', value = ' '})


		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'dmvschool_actions',
		{
			title    = 'Setup your Voice',
			elements = elements,
			align    = 'top-right',
		}, function(data, menu)

			if data.current.value == 'setup_idaa' then
				TriggerEvent('5ad0c096-c37d-4d48-b3e1-71ec3994aec5')
			end

			end, function(data, menu)
				menu.close()

				CurrentAction     = 'setupid_voice'
				CurrentActionMsg  = _U('press_open_menu')
				CurrentActionData = {}
			end
		)

end

function OpenTest()

	ESX.TriggerServerCallback('1242920b-7da6-4edd-8dce-0f17fc5c501f', function (lic)
		Licenses = lic
		local ownedLicenses = {}
		
		local elements = {}
		if  Licenses[1].fnl == 0 and Licenses[1].lnl == 0 then
			table.insert(elements, {label = ' <span style="color: red;">You MUST do the exam last!</span>', value = ' '})
		elseif Licenses[1].passport == 0 and  Licenses[1].fnl > 0 and  Licenses[1].lnl > 0 then
			table.insert(elements, {label = ' <span style="color: orange;">Take your Citizenship Examination</span>', value = 'theory_test'})
		elseif  Licenses[1].passport == 1 then
			table.insert(elements, {label = ' <span style="color: green;">Great, you are already done, click to proceed into Melbourne</span>', value = 'donetest'})
		end
		
	

		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'dmvschool_actions',
		{
			title    = 'Australian Dept of Immigration',
			elements = elements,
			align    = 'top-right',
		}, function(data, menu)
			if data.current.value == 'theory_test' then
				menu.close()
				StartTheoryTest()
				CurrentAction     = nil
				CurrentActionMsg  = nil
				CurrentActionData = {}
			end
			
			if data.current.value == 'setup_character' then
				ExecuteCommand('skin')
			end
			if data.current.value == 'setup_id' then
				TriggerEvent('5ad0c096-c37d-4d48-b3e1-71ec3994aec5')
			end
			
			if data.current.value == "donetest" then
				menu.close()
				SetEntityProofs(GetPlayerPed(-1),false,false,false,false,false,false,1,false)
					TriggerServerEvent('7d1e7f28-5105-4415-bae0-be66023be711')
					Citizen.CreateThread(function()
						Wait(5000)
						exports.ny:NYLeave()
						
					end)
					
				CurrentAction     = nil
				CurrentActionMsg  = nil
				CurrentActionData = {}
			
			end

			end, function(data, menu)
				menu.close()

				CurrentAction     = nil
				CurrentActionMsg  = nil
				CurrentActionData = {}
			end
		)
	end)
end

RegisterNUICallback('question', function(data, cb)
	SendNUIMessage({
		openSection = 'question'
	})

	cb('OK')
end)

RegisterNUICallback('close', function(data, cb)
	TriggerServerEvent('fc8f4918-7c05-40a6-8226-434a8c308907',data.score,true)
	StopTheoryTest(true)
	cb('OK')
end)

RegisterNUICallback('kick', function(data, cb)
	TriggerServerEvent('fc8f4918-7c05-40a6-8226-434a8c308907',data.score,false)
	StopTheoryTest(false)
	cb('OK')
end)

AddEventHandler('392dc454-4ebd-4a00-8010-e16312e77a49', function(zone)
	if zone == 'DMVSchool' then
		CurrentAction     = 'dmvschool_menu'
		CurrentActionMsg  = _U('press_open_menu')
		CurrentActionData = {}
		
	elseif zone == 'Test' then
		CurrentAction     = 'test_menu'
		CurrentActionMsg  = _U('press_open_menu')
		CurrentActionData = {}
	
	elseif zone == 'SetupID' then
		CurrentAction     = 'setupid_menu'
		CurrentActionMsg  = _U('press_open_menu')
		CurrentActionData = {}
		
	elseif zone == "Voice" then
		CurrentAction     = 'setupid_voice'
		CurrentActionMsg  = _U('press_open_menu')
		CurrentActionData = {}
	end
end)

AddEventHandler('0275d7ac-e208-44fe-ad28-660528471bcc', function(zone)
	CurrentAction = nil
	CurrentActionMsg  = nil
	CurrentActionData = {}
	ESX.UI.Menu.CloseAll()
end)

RegisterNetEvent('a387006b-a7ba-43fd-a8c9-2bc9cd2b6f97')
AddEventHandler('a387006b-a7ba-43fd-a8c9-2bc9cd2b6f97', function(licenses)
	Licenses = licenses
end)

-- Create Blips


-- Display markers
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		local coords = GetEntityCoords(GetPlayerPed(-1))
		local zcloser = false
		for k,v in pairs(Config.Zones) do
			if(v.Type ~= -1 and #(coords - vector3(v.Pos.x, v.Pos.y, v.Pos.z)) < Config.DrawDistance) then
				zcloser = true
				if k == 'DMVSchool' then
					ESX.Game.Utils.DrawText3D(vector3(v.Pos.x, v.Pos.y, v.Pos.z + 0.9), "Press [E] to Design your Character's ~g~Look", 0.4)
				elseif k == 'Test' then
					ESX.Game.Utils.DrawText3D(vector3(v.Pos.x, v.Pos.y, v.Pos.z + 0.9), 'Press [E] to sit your ~o~Citizenship Exam', 0.4)
				elseif k == 'SetupID' then
					ESX.Game.Utils.DrawText3D(vector3(v.Pos.x, v.Pos.y, v.Pos.z + 0.9), 'Press [E] to setup your ~g~Identity', 0.4)
				elseif k == "Voice" then
					ESX.Game.Utils.DrawText3D(vector3(v.Pos.x, v.Pos.y, v.Pos.z + 0.9), 'Press [E] to setup your ~b~Voice', 0.4)
				end
				
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

		Citizen.Wait(250)
		if closer then
			local coords      = GetEntityCoords(GetPlayerPed(-1))
			local isInMarker  = false
			local currentZone = nil

			for k,v in pairs(Config.Zones) do
				if(#(coords - vector3(v.Pos.x, v.Pos.y, v.Pos.z)) < 2.0) then
					isInMarker  = true
					currentZone = k
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone                = currentZone
				TriggerEvent('392dc454-4ebd-4a00-8010-e16312e77a49', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('0275d7ac-e208-44fe-ad28-660528471bcc', LastZone)
			end
		else
			Wait(1000)
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
		Citizen.Wait(5)

		if CurrentAction ~= nil then
			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)

			if IsControlJustReleased(0, Keys['E']) then
				if CurrentAction == 'dmvschool_menu' then
					OpenDMVSchoolMenu()
				end
				if CurrentAction == 'setupid_menu' then
					OpenSetupID()
				end
				if CurrentAction == 'test_menu' then
					OpenTest()
				end
				
				if CurrentAction == 'setupid_voice' then
					OpenVoiceID()
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

				local distance = #(coords - vector3(Config.CheckPoints[nextCheckPoint].Pos.x, Config.CheckPoints[nextCheckPoint].Pos.y, Config.CheckPoints[nextCheckPoint].Pos.z))

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
	
		TriggerServerEvent('esx_passport:reregistration',vehicleData.plate)
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
		ESX.ShowNotification('~r~Warning:~w~You may lose the contents of your boot. There are ~r~no refunds.')
		Wait(500)
		local newplate = KeyboardInput('New Plate? EG: C TUBBY (8 Characters MAX)', '', 8)
		local platecheck = string.match(newplate,"%p")
		if platecheck ~= nil and string.len(platecheck) > 0 then
			ESX.ShowNotification('~r~Error~w~\nDon\'t use special characters in plates please.')
			return
		end


		if string.len(rtrim(ltrim(newplate))) < 5 or string.len(rtrim(ltrim(newplate))) > 8 then
			ESX.ShowNotification('~r~Error~w~\nYour plate must be at least 5 characters and no more than 8.')
			return
		end

		
		ESX.TriggerServerCallback('b9de1222-8dbb-4b06-aee7-54ac82478665', function (result)
			if result then
				ESX.ShowNotification('~g~Well done plate changed successfully.')
				ESX.ShowNotification('~r~warning ~o~If you have the vehicle out it may appear to police as stolen or unregistered.')
			else
				ESX.ShowNotification('~o~Error~w~Unsuccessful in changing this vehicle plate.')
			end
			Wait(600)
			OpenRegoChanger(zone)
		
		end,data.current.value.plate,newplate,newplate)
		
		--TriggerServerEvent('esx_passport:reregistration',vehicleData.plate)
	
      end,
      function (data, menu)
       	 menu.close()
		OpenDMVSchoolMenu()
      end
    )
  end, zone)
  
 
end



function NYappear(x,y,z)

	finalloc.x = x
	finalloc.y = y
	finalloc.z = z
	 
	SetEntityCoords(GetPlayerPed(-1), tonumber(514.77), tonumber(4752.67), tonumber(-69) + 0.0, 1, 0, 0, 1)
	SetEntityHeading(GetPlayerPed(-1), 174.76)
	Wait(2400)
	SetEntityCoords(GetPlayerPed(-1), tonumber(-1889.76), tonumber(3986.27), tonumber(40.11) + 0.0, 1, 0, 0, 1)
	SetEntityHeading(GetPlayerPed(-1), 358.94)
	FreezeEntityPosition(GetPlayerPed(-1), true) -- go sure that he does not fall through the map.
	Wait(2000)
	SetDrawMapVisible(true)
	
	FreezeEntityPosition(GetPlayerPed(-1), false) --unfreeze him.
	Citizen.CreateThread(function()
		print('##PENDING CHECKS FOR LOCATION AND DIRECTION')
		Wait(4000)
		local coords = GetEntityCoords(PlayerPedId())
		print('checking for location and direction')
		if coords.z < 20 then
			--Protection
			ESX.ShowNotification("Your ~b~plane ~w~is ~r~crashing~w~ we're trying to save you!")
			Wait(1000)
			ESX.ShowNotification("Use ~b~/fixmepls ~w~in chat if you end up in the somewhere interesting!")
			Wait(1000)
			SetEntityCoords(GetPlayerPed(-1), tonumber(-1889.76), tonumber(3986.27), tonumber(40.11) + 0.0, 1, 0, 0, 1)
			SetEntityHeading(GetPlayerPed(-1), 358.94)
		end
	end)
	inNY = true
	SetEntityInvincible(GetPlayerPed(-1),true)
	SetEntityProofs(GetPlayerPed(-1),true,true,true,false,true,true,1,true)

	forcedhere = true
end


function NYLeave()
	SetEntityInvincible(GetPlayerPed(-1),false)
	SetEntityProofs(GetPlayerPed(-1),false,false,false,false,false,false,1,false)
	DoScreenFadeOut(1000) --first part
	Wait(1000)
	
	SetEntityCoords(GetPlayerPed(-1), tonumber(514.77), tonumber(4752.67), tonumber(-69) + 0.0, 1, 0, 0, 1) --part two
	SetEntityHeading(GetPlayerPed(-1), 174.76)
	FreezeEntityPosition(GetPlayerPed(-1), true)
	SetDrawMapVisible(false)
	Wait(1000)
	
	DoScreenFadeIn(1000) --part three
	FreezeEntityPosition(GetPlayerPed(-1), false)
	anim = true
	Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if anim == true then
			local pid = PlayerPedId()
			RequestAnimDict("amb@world_human_leaning@male@wall@back@mobile@exit")
			while (not HasAnimDictLoaded("amb@world_human_leaning@male@wall@back@mobile@exit")) do Citizen.Wait(0) end
			TaskPlayAnim(pid,"amb@world_human_leaning@male@wall@back@mobile@exit", "mobile_to_text_transition" ,1.0,-1.0, 5000, 0, 1, true, true, true)
		else
			Wait(500)
			return
		end
	end
	end)
	Wait(10000)
	
	DoScreenFadeOut(1000)
	
	Wait(1000)
	anim = false
	SetEntityCoords(GetPlayerPed(-1), tonumber(finalloc.x), tonumber(finalloc.y), tonumber(finalloc.z) + 0.0, 1, 0, 0, 1)
	SetEntityHeading(GetPlayerPed(-1), 327.68)
	FreezeEntityPosition(GetPlayerPed(-1), true) -- go sure that he does not fall through the map.
	Wait(2000)
	FreezeEntityPosition(GetPlayerPed(-1), false) --unfreeze him.
	DoScreenFadeIn(1000)
	inNY = false
	SetEntityInvincible(GetPlayerPed(-1),false)
	SetEntityProofs(GetPlayerPed(-1),false,false,false,false,false,false,1,false)
end

