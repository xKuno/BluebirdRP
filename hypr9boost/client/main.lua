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
ESX              = nil
local PlayerData = {}
local nitroActivado = false

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

RegisterNetEvent('b6c3c0a6-301d-4749-8ad2-6e951e8bdac1')
AddEventHandler('b6c3c0a6-301d-4749-8ad2-6e951e8bdac1', function()
        TriggerServerEvent('ebd433ff-bf19-4d14-b1c5-9aaf8218286d','nitro', 1)
        if ESX.UI.Menu.IsOpen('default', 'es_extended', 'inventory') then
            ESX.UI.Menu.Close('default', 'es_extended', 'inventory')
        end

        if ESX.UI.Menu.IsOpen('default', 'es_extended', 'inventory_item') then
            ESX.UI.Menu.Close('default', 'es_extended', 'inventory_item')
        end
        activarNitro()
end)


RegisterNetEvent('3123b750-53b0-4a00-a932-a2775e04a40e')
AddEventHandler('3123b750-53b0-4a00-a932-a2775e04a40e', function()
        TriggerServerEvent('ebd433ff-bf19-4d14-b1c5-9aaf8218286d','nitro_plus', 1)
        if ESX.UI.Menu.IsOpen('default', 'es_extended', 'inventory') then
            ESX.UI.Menu.Close('default', 'es_extended', 'inventory')
        end

        if ESX.UI.Menu.IsOpen('default', 'es_extended', 'inventory_item') then
            ESX.UI.Menu.Close('default', 'es_extended', 'inventory_item')
        end
        activarNitrop()
end)

function activarNitro()
    nitroActivado = true
	
	Citizen.CreateThread(function()
    while nitroActivado == true do
        Citizen.Wait(0)
		local force = 65.0
        local ped = GetPlayerPed(-1)
		local playerVeh = GetVehiclePedIsIn(ped, false)
		
		
		if playerVeh ~= nil then
			if IsControlPressed(1, 38) and nitroActivado then
				Citizen.Wait(3000)
				local sp = GetEntitySpeed(playerVeh)
				if sp > 300 then
					force = 90
				end
				SetVehicleBoostActive(playerVeh, 1, 0)
				SetVehicleForwardSpeed(playerVeh, force)
				StartScreenEffect("RaceTurbo", 0, 0)
				SetVehicleBoostActive(playerVeh, 0, 0)
				nitroActivado = false
			end
		else
			Wait(2000)
		end
    end
end)
end

function activarNitrop()
    nitroActivado = true
	
	Citizen.CreateThread(function()
    while nitroActivado == true do
        Citizen.Wait(0)
		local force = 100.0
        local ped = GetPlayerPed(-1)
		local playerVeh = GetVehiclePedIsIn(ped, false)
		
		
		if playerVeh ~= nil then
			if IsControlPressed(1, 38) and nitroActivado then
				local sp = GetEntitySpeed(playerVeh)
				if sp > 300 then
					force = 100
				end
				SetVehicleBoostActive(playerVeh, 1, 0)
				SetVehicleForwardSpeed(playerVeh, force)
				StartScreenEffect("RaceTurbo", 0, 0)
				SetVehicleBoostActive(playerVeh, 0, 0)
				nitroActivado = false
			end
		else
			Wait(6000)
		end
    end
end)
end

-- Thanks to Flacetracer for the code snippet @ https://forum.fivem.net/t/help-add-speed-for-vehicle/23966
