-- Menu state
local showMenu = false
local inveh
local keyPressed = false
local saveTimer = 0

local ispolicedog = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	PlayerData = ESX.GetPlayerData()
	
	while PlayerData == nil  do
		PlayerData = ESX.GetPlayerData()
		Citizen.Wait(100)
	end	
	while PlayerData.job == nil do
		Citizen.Wait(10)
	end	
	while PlayerData.job.name == nil do
		Citizen.Wait(10)
	end	
	pjob = PlayerData.job.name
--pjob = ESX.GetPlayerData().job.name
end)

RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function(job)
	PlayerData.job = job
end)


RegisterCommand('policek9', function()
	if ESX.GetPlayerData().job.name == 'police' then
		if ispolicedog == true then
			ispolicedog = false
		else
			ispolicedog = true
		end
	else
		ispolicedog = false
	end
end)


RegisterCommand('+showmenu', function()

	keyPressed = true
	if IsInputDisabled(0) and exports.esx_policejob:amicuffed() == false and exports.webcops.isKeyboardOpen() == false  then
		showMenu = true
		saveShowMenu = true
		saveTimer = 25
		player = GetPlayerPed(-1)
		inveh = IsPedInAnyVehicle(player, false)
		
		if ispolicedog  then
			SendNUIMessage({
				type = 'show',
				j='policedog',
				c=inveh
			})
		else
			SendNUIMessage({
				type = 'show',
				j=ESX.GetPlayerData().job.name,
				c=inveh
			})
		end
		-- Set cursor position and set focus
	
		SetCursorLocation(0.5, 0.5)
		SetNuiFocus(true, true)
		SetNuiFocusKeepInput(true)
		-- Play sound
		PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)
		-- Prevent menu from showing again until key is released
		
			Citizen.CreateThread(function()
				-- Update every frame
				while saveTimer >= 0 do
					Citizen.Wait(0)
					if saveShowMenu then
						DisableControlAction(2, 24, true) -- Attack
						DisableControlAction(2, 257, true) -- Attack 2 -- Aim
						DisableControlAction(2, 263, true) -- Melee Attack 1
						DisableControlAction(2, 2, true)
						DisableControlAction(2, 1, true)
						DisablePlayerFiring(PlayerId(),true)
						DisablePlayerFiring(GetPlayerPed(-1),true)
						
						if showMenu == false then
							saveTimer = saveTimer - 1
						elseif  showMenu == false and saveTimer <= 0 then
							saveShowMenu = false
							SetNuiFocusKeepInput(false)
							SetNuiFocus(false, false)
							SendNUIMessage({
								type = 'hide'
							})
							
							
						end
					end
				end
			end)

		while showMenu == true do Citizen.Wait(100) end
		Citizen.Wait(100)
		while keybindPressed do Citizen.Wait(100) end
	end
	
end, false)

RegisterCommand('-showmenu', function()
	if exports.esx_policejob:amicuffed() == false then
		if showMenu == true then
			PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)
		end
	end
	keyPressed = false
	showMenu = false
    SetNuiFocusKeepInput(false)
	SetNuiFocus(false, false)
    SendNUIMessage({
        type = 'hide'
	})
	
end, false)

RegisterKeyMapping('+showmenu', 'Wheel Menu', 'keyboard', 'g')
TriggerEvent('217f3d67-5dc5-4196-887e-9835dd323e74', '/+showmenu')
TriggerEvent('217f3d67-5dc5-4196-887e-9835dd323e74', '/-showmenu')

-- Callback function for closing menu
RegisterNUICallback('closemenu', function(data, cb)
    -- Clear focus and destroy UI
    showMenu = false
	SetNuiFocusKeepInput(false)
	SetNuiFocus(false, false)
	EnableControlAction(2, 2, true)
	EnableControlAction(2, 1, true)
    SendNUIMessage({
        type = 'hide'
    })

    -- Play sound
    PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)

    -- Send ACK to callback function
    cb('ok')
end)

RegisterCommand("clearmenu", function(source, args, raw)
    showMenu = false
    SetNuiFocusKeepInput(false)
	SetNuiFocus(false, false)
	
    SendNUIMessage({
        type = 'hide'
    })

    -- Play sound
    PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)
end,false)





-- Callback function for when a slice is clicked, execute command
RegisterNUICallback('sliceclicked', function(data, cb)
	-- Clear focus and destroy UI
    showMenu = false
	SetNuiFocusKeepInput(false)
    SetNuiFocus(false, false)
    SendNUIMessage({
        type = 'hide'
    })

    -- Play sound
    PlaySoundFrontend(-1, "NAV", "HUD_AMMO_SHOP_SOUNDSET", 1)
		if string.find(data.command, "TriggerServerEvent") then
		 local ev = split(data.command,"??")
		  print ("server event found")
		  TriggerServerEvent(ev[2])
		elseif string.find(data.command, "TriggerEvent")  then
		  print('client event found')
			local ev = split(data.command,"??")
			TriggerEvent(ev[2])
		else
		   Wait(100)
		   ExecuteCommand(data.command)
		end
    -- Run command
  

    -- Send ACK to callback function
    cb('ok')
end)

function split(s, delimiter)
    result = {};
    for match in (s..delimiter):gmatch("(.-)"..delimiter) do
        table.insert(result, match);
    end
    return result;
end

local rdoorsopen = false
local fdoorsopen = false

----Car Doors
RegisterCommand("rdoors", function(source, args, raw)

	local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
	
	if rdoorsopen then
		rdoorsopen = false
		SetVehicleDoorShut(vehicle,2,false)
		SetVehicleDoorShut(vehicle,3,false)
	else
		rdoorsopen = true
		SetVehicleDoorOpen(vehicle,2,false,false)
		SetVehicleDoorOpen(vehicle,3,false,false)
	end

end,false)
RegisterCommand("fdoors", function(source, args, raw)

	local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
	
	if fdoorsopen then
		fdoorsopen = false
		SetVehicleDoorShut(vehicle,0,false)
		SetVehicleDoorShut(vehicle,1,false)
	else
		fdoorsopen = true
		SetVehicleDoorOpen(vehicle,0,false,false)
		SetVehicleDoorOpen(vehicle,1,false,false)
	end

end,false)


