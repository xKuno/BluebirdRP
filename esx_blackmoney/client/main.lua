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

ESX = nil

local sleep = false

GUITime = GetGameTimer()

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

function hintToDisplay(text)
	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

local place = {
   -- {x = 895.39,y = -179.52,z = 74.7},
   vector3(-58.3,-2520.37, 6.85)
	--{x = 895.39,y = -179.52,z = 73.7}
}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(3)
        for k in pairs(place) do
            -- Marker (START)
            local sleepc = false
			-- Marker (END)
			local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
			local dist = #(plyCoords - place[k])
			if dist < 30 then
				sleepc = true
				DrawMarker(27, place[k].x, place[k].y, place[k].z - 0.4, 0, 0, 0, 0, 0, 0, 1.001, 1.0001, 0.5001, 0, 255, 50, 200, 0, 0, 0, 0)
				if dist <= 1.3 then
					--doesnt spam notifcations only shows top corner
					hintToDisplay('Press ~INPUT_CONTEXT~ to wash your ~r~dirty money')
					
					if IsControlJustPressed(0, Keys['E']) then -- "E"
						if (GetGameTimer() - 4000) > GUITime then
							GUITime = GetGameTimer()
							TriggerServerEvent('b36f81cb-9458-40a6-9e44-e0367d13eedc')
							Wait(3500)
						else
							GUITime = GetGameTimer()
							ESX.ShowNotification("~r~Dont~w~ tell me what to fucken do slow your bitch arse down!")
						end
					end			
				end
			else
				sleepc = false
				Wait(5000)
			end
        end
    end
end)


--[[
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(15)

        for k in pairs(place) do

            
            local dist = Vdist2(plyCoords.x, plyCoords.y, plyCoords.z, place[k].x, place[k].y, place[k].z)

            if dist <= 0.5 then
                --doesnt spam notifcations only shows top corner
                hintToDisplay('Press ~INPUT_CONTEXT~ to wash your ~r~dirty money')
				
				if IsControlJustPressed(0, Keys['E']) then -- "E"
					TriggerServerEvent('b36f81cb-9458-40a6-9e44-e0367d13eedc')
				end			
            end
        end
    end 
end) --]]