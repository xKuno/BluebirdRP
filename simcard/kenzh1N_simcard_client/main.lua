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

ESX                           = nil
local GUI                     = {}
GUI.Time                      = 0
local isInMarker      = false

RegisterNetEvent('1dc5194f-3d22-476e-8d77-01e5c42a5b7b')
AddEventHandler('1dc5194f-3d22-476e-8d77-01e5c42a5b7b', function()
	OpenPhoneMenu()
end)

function OpenSimMenu()

	ESX.UI.Menu.CloseAll()

	local elements = {}
	local elements2 = {}
  
	  ESX.TriggerServerCallback('9a285c13-a8e8-46ee-9290-1ac0c82bf075', function(sim)
  
		  for _,v in pairs(sim) do
  
			  table.insert(elements, {label = tostring(v.number), value = v})
			  
		  end
		  
  
		  ESX.UI.Menu.Open(
		  'default', GetCurrentResourceName(), 'phone_change',
		  {
			  title    = 'Sim Changer',
			  align    = 'top-right',
			  elements = elements,
		  },
	  function(data, menu)
		
		local elements2 = {
			{label = 'Use', value = 'sim_use'},
			
			--{label = 'Give Sim Card', value = 'sim_give'},
		  	--{label = 'Wipe Sim Card', value = 'sim_delete'}
		  }
		  if #elements > 1 then
			table.insert(elements2,{label = 'Give Sim Card', value = 'sim_give'})
		  end
  
		  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'sim_change', {
			title    = "What you wanna do?",
			align    = 'top-right',
			elements = elements2,
  
		  }, 
		  function(data2, menu2)
  
			if data2.current.value == 'sim_use' then
				ESX.UI.Menu.CloseAll()
				TriggerServerEvent('6e82c56f-dc48-4759-adbb-3f36bc88f832', data.current.value.number)
				ESX.ShowNotification("Your sim card is now activated: ~o~" .. data.current.value.number)
				Wait(1000)
				TriggerServerEvent('60f908f0-db50-4899-8f57-df39f82b60f8')
				Wait(200)
				TriggerServerEvent('80722ed6-7a88-46b5-8487-b51e5269b1c8')
			end
			if data2.current.value == 'sim_give' then
				ESX.UI.Menu.CloseAll()
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				if closestPlayer == -1 or closestDistance > 3.0 then
					ESX.ShowNotification('No one is near you.')
				else
					TriggerServerEvent('3f5502a0-709e-490a-b20e-5770c9605514', data.current.value.number, GetPlayerServerId(closestPlayer))
				end
				Wait(1000)
				TriggerServerEvent('60f908f0-db50-4899-8f57-df39f82b60f8')
				Wait(200)
				TriggerServerEvent('80722ed6-7a88-46b5-8487-b51e5269b1c8')
			end
			if data2.current.value == 'sim_delete' then
				ESX.UI.Menu.CloseAll()
				TriggerServerEvent('d582d42d-edc8-4025-bad9-18570dbff0d9', data.current.value.number)
				ESX.ShowNotification("You destroyed the sim card, this number is gone ~o~" .. data.current.value.number)
				Wait(1000)
				TriggerServerEvent('60f908f0-db50-4899-8f57-df39f82b60f8')
				Wait(200)
				TriggerServerEvent('80722ed6-7a88-46b5-8487-b51e5269b1c8')
			end

			menu2.close()
		  end, function(data2, menu2)
			menu2.close()
		  end)
  
		  end,
		  function(data, menu)
			  menu.close()
		  end
	  )	
	end)
  
end

function OpenPhoneMenu()

	ESX.UI.Menu.CloseAll()

	local elements = {
	  --{label = 'Ouvrir', value = 'open_phone'},
	  {label = 'Sim Card', value = 'sim_phone'}
	}
  
	ESX.UI.Menu.Open(
	  'default', GetCurrentResourceName(), 'phone_actions',
	  {
		title    = 'Mobile',
		align    = 'top-right',
		elements = elements
	  },
	  function(data, menu)
  
		if data.current.value == 'open_phone' then
			ESX.UI.Menu.CloseAll()
			ESX.TriggerServerCallback('40e9dcd2-f9ca-4dfc-84ae-60e466fb54a8', function(sim)
				if sim then
					TriggerEvent('0679f255-a517-49c2-9b12-af335b84703b')
				else
					ESX.ShowNotification("You don't have a sim card!")
				end
			end)

		end

		if data.current.value == 'sim_phone' then
			OpenSimMenu()
		end
  
	  end,
	  function(data, menu)
  
		menu.close()
	  end
	)
  
end

Citizen.CreateThread(function() --ok

	while ESX == nil do
	  TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
	  Citizen.Wait(1)
	end

  end)





RegisterNetEvent('69184778-19f7-4804-913e-c5556e96dbdf')
AddEventHandler('69184778-19f7-4804-913e-c5556e96dbdf', function()
	OpenSimMenu()
end)

---------------------------------
--------- ikNox#6088 ------------
---------------------------------