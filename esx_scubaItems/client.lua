

ESX = nil
Citizen.CreateThread(function()
	while true do
		Wait(5)
		if ESX ~= nil then
		
		else
			ESX = nil
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		end
	end
end)

local locations = {
	vector3(-2836.96,-461.94, -34.96)
}


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
local spawned = false
Citizen.CreateThread( function()
Citizen.Wait(10000)
while true do
Citizen.Wait(1000)

	if #(vector3(Config.PickupBlip.x,Config.PickupBlip.y,Config.PickupBlip.z) - GetEntityCoords(GetPlayerPed(-1))) <= 200 then
		if spawned == false then
			TriggerEvent('2a428831-38b2-48b0-b427-76856599da6f')
			TriggerEvent('2a428831-38b2-48b0-b427-76856599da6f')
			TriggerEvent('2a428831-38b2-48b0-b427-76856599da6f')
			TriggerEvent('2a428831-38b2-48b0-b427-76856599da6f')
			TriggerEvent('2a428831-38b2-48b0-b427-76856599da6f')
			TriggerEvent('2a428831-38b2-48b0-b427-76856599da6f')
			TriggerEvent('2a428831-38b2-48b0-b427-76856599da6f')
			TriggerEvent('2a428831-38b2-48b0-b427-76856599da6f')
			TriggerEvent('2a428831-38b2-48b0-b427-76856599da6f')
			TriggerEvent('2a428831-38b2-48b0-b427-76856599da6f')
			TriggerEvent('2a428831-38b2-48b0-b427-76856599da6f')
		end
		spawned = true
	else
		if spawned then
			locations = {}
		end
		spawned = false
		
	end
end
end)


local displayed = false
local menuOpen = false
			


local process = true
local near = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
			
			for k in pairs(locations) do
				local loc = #(vector3(locations[k]) - GetEntityCoords(GetPlayerPed(-1))) 
				if loc < 150 then		
					DrawMarker(3, locations[k].x, locations[k].y, locations[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 97, 164, 223, 110, 0, 1, 0, 0)	
					
					if loc < 1 then
						TriggerServerEvent('400b6d74-28bd-4f70-8fc8-292af3811c05')
						TriggerEvent('5ca81379-7339-4d59-a447-87ee6978e192', k)
					end
					near = true
				end
			end
			if near == false then
				Citizen.Wait(1500)
			end

    end
end)



RegisterNetEvent('2a428831-38b2-48b0-b427-76856599da6f')
AddEventHandler('2a428831-38b2-48b0-b427-76856599da6f', function()
	local set = false
	Citizen.Wait(10)
	
	local rnX = Config.PickupBlip.x + math.random(-35, 35)
	local rnY = Config.PickupBlip.y + math.random(-35, 35)
	
	local u, Z = GetGroundZFor_3dCoord(rnX ,rnY ,300.0,0)
	
	

	
	table.insert(locations,vector3(rnX,rnY,Z + 0.3));

	

end)


RegisterNetEvent('5ca81379-7339-4d59-a447-87ee6978e192')
AddEventHandler('5ca81379-7339-4d59-a447-87ee6978e192', function(id)
	local set = false
	
	
	local rnX = Config.PickupBlip.x + math.random(-35, 35)
	local rnY = Config.PickupBlip.y + math.random(-35, 35)
	
	local u, Z = GetGroundZFor_3dCoord(rnX ,rnY ,300.0,0)
	
	locations[id] = vector3(rnX, rnY, Z + 0.3)

end)

RegisterNetEvent('d9d318fd-3f44-4248-9c86-df4af924c733')
AddEventHandler('d9d318fd-3f44-4248-9c86-df4af924c733', function(message)
	ESX.ShowNotification(message)
end)
			
function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end









