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
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local HasPayed                = false

local myPed = GetPlayerPed(-1)
local myCurrentCoords = vector3(0,0,0)

Citizen.CreateThread(function()

	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

end)

Citizen.CreateThread(function()
  while ESX == nil do
    Citizen.Wait(200)
  end
  while true do
	Wait(500)
	myPed = ESX.Game.GetMyPed()
	myCurrentCoords = ESX.Game.GetMyPedLocation()
  end
end)

function OpenShopMenu()

	HasPayed = false

	TriggerEvent('4fba22a5-88ee-4097-9d32-aab6667947be', function(data, menu)

		menu.close()

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'shop_confirm',
			{
				title = _U('valid_purchase'),
				align = 'top-right',
				elements = {
					{label = _U('yes'), value = 'yes'},
					{label = _U('no'), value = 'no'},
				}
			},
			function(data, menu)

				menu.close()

				if data.current.value == 'yes' then

					ESX.TriggerServerCallback('1083c40e-e6c0-4b71-952c-14e50f2716ad', function(hasEnoughMoney)

						if hasEnoughMoney then

							TriggerEvent('d3bdbe20-bf7d-4df2-9ef6-9026a86a6e87', function(skin)
								TriggerServerEvent('ad5940f4-3fe4-4fc5-9070-284adcd9246d', skin)
							end)

							TriggerServerEvent('ad6f296f-c9d0-4254-8393-af62fc0e1f5a')

							HasPayed = true
						else

							TriggerEvent('b48bfbfa-98e4-42b4-959e-13e020bef915', function(skin)
								TriggerEvent('56a2ee13-8a49-4ad3-a298-1854493c98ee', skin)
							end)

							ESX.ShowNotification(_U('not_enough_money'))
						
						end

					end)

				end

				if data.current.value == 'no' then

					TriggerEvent('b48bfbfa-98e4-42b4-959e-13e020bef915', function(skin)
						TriggerEvent('56a2ee13-8a49-4ad3-a298-1854493c98ee', skin)
					end)

				end

				CurrentAction     = 'shop_menu'
				CurrentActionMsg  = _U('press_access')
				CurrentActionData = {}

			end,
			function(data, menu)

				menu.close()

				CurrentAction     = 'shop_menu'
				CurrentActionMsg  = _U('press_access')
				CurrentActionData = {}

			end
		)

	end, function(data, menu)

			menu.close()

			CurrentAction     = 'shop_menu'
			CurrentActionMsg  = _U('press_access')
			CurrentActionData = {}

	end, {
		'beard_1',
		'beard_2',
		'beard_3',
		'beard_4',
		'hair_1',
		'hair_2',
		'hair_color_1',
		'hair_color_2',
		'eyebrows_1',
		'eyebrows_2',
		'eyebrows_3',
		'eyebrows_4',
		'makeup_1',
		'makeup_2',
		'makeup_3',
		'makeup_4',
		'lipstick_1',
		'lipstick_2',
		'lipstick_3',
		'lipstick_4',
		'ears_1',
		'ears_2',
	})

end

AddEventHandler('c0e3c36e-a436-4092-b6f8-eb0713642c0d', function(zone)
	CurrentAction     = 'shop_menu'
	CurrentActionMsg  = _U('press_access')
	CurrentActionData = {}
end)

AddEventHandler('f87d97c1-3596-43d3-b30c-5d8cbf9dabaa', function(zone)
	
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil

	if not HasPayed then

		TriggerEvent('b48bfbfa-98e4-42b4-959e-13e020bef915', function(skin)
			TriggerEvent('56a2ee13-8a49-4ad3-a298-1854493c98ee', skin)
		end)

	end

end)

-- Create Blips
Citizen.CreateThread(function()
	Wait(6000)
	for i=1, #Config.Shops, 1 do
		Wait(250)
		local blip = AddBlipForCoord(Config.Shops[i].x, Config.Shops[i].y, Config.Shops[i].z)

		SetBlipSprite (blip, 71)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 1.0)
		SetBlipColour (blip, 51)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('barber_blip'))
		EndTextCommandSetBlipName(blip)
	end

end)
local dm = false
-- Display markers
Citizen.CreateThread(function()
	while true do
		
		Wait(5)
		
		local coords = myCurrentCoords
		local dmn = false
		for k,v in pairs(Config.Zones) do
			if(v.Type ~= -1 and #(coords - v.Pos) < Config.DrawDistance) then
				dmn = true
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
			end
		end
		
		if dmn then
			dm = true
		
		else 
			Wait(2000)
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		
		Wait(500)
		
		if dm then
			local coords      = GetEntityCoords(GetPlayerPed(-1))
			local isInMarker  = false
			local currentZone = nil

			for k,v in pairs(Config.Zones) do
				if(#(coords - v.Pos) < v.Size.x) then
					isInMarker  = true
					currentZone = k
				end
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone                = currentZone
				TriggerEvent('c0e3c36e-a436-4092-b6f8-eb0713642c0d', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('f87d97c1-3596-43d3-b30c-5d8cbf9dabaa', LastZone)
			end
		else
			
			Wait(2000)
		end

	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(15)

		if CurrentAction ~= nil then

			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)

			if IsControlPressed(0,  Keys['E']) and (GetGameTimer() - GUI.Time) > 300 then
				
				if CurrentAction == 'shop_menu' then
					OpenShopMenu()
				end

				CurrentAction = nil
				GUI.Time      = GetGameTimer()
				
			end
		else
			Wait(500)
		end

	end
end)