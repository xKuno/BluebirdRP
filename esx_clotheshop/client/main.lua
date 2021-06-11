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
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local HasPayed                = false

Citizen.CreateThread(function()

	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

end)

function OpenShopMenu()

	HasPayed = false

	TriggerEvent('4fba22a5-88ee-4097-9d32-aab6667947be', function(data, menu)

		menu.close()

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'shop_confirm',
			{
				title = _U('valid_this_purchase'),
				align = 'top-left',
				elements = {
					{label = _U('yes'), value = 'yes'},
					{label = _U('no'), value = 'no'},
				}
			},
			function(data, menu)

				menu.close()

				if data.current.value == 'yes' then

					ESX.TriggerServerCallback('5d233ac2-76bf-4b9d-bd72-4815806a71da', function(hasEnoughMoney)

						if hasEnoughMoney then

							TriggerEvent('d3bdbe20-bf7d-4df2-9ef6-9026a86a6e87', function(skin)
								TriggerServerEvent('ad5940f4-3fe4-4fc5-9070-284adcd9246d', skin)
							end)

							TriggerServerEvent('58e2cc70-e095-49fc-9550-7ebd75af1b50')

							HasPayed = true

							ESX.TriggerServerCallback('479fb991-44e7-447e-a6e0-df6da8813894', function(foundStore)

								if foundStore then

									ESX.UI.Menu.Open(
										'default', GetCurrentResourceName(), 'save_dressing',
										{
											title = _U('save_in_dressing'),
											align = 'top-left',
											elements = {
												{label = _U('yes'), value = 'yes'},
												{label = _U('no'),  value = 'no'},
											}
										},
										function(data2, menu2)

											menu2.close()

											if data2.current.value == 'yes' then

												ESX.UI.Menu.Open(
													'dialog', GetCurrentResourceName(), 'outfit_name',
													{
														title = _U('name_outfit'),
													},
													function(data3, menu3)

														menu3.close()

														TriggerEvent('d3bdbe20-bf7d-4df2-9ef6-9026a86a6e87', function(skin)
															TriggerServerEvent('8aa70d9d-fcca-4f8a-ab72-dfb20aa6b85d', data3.value, skin)
														end)

														ESX.ShowNotification(_U('saved_outfit'))

													end,
													function(data3, menu3)
														menu3.close()
													end
												)

											end

										end
									)

								end

							end)

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
				CurrentActionMsg  = _U('press_menu')
				CurrentActionData = {}

			end,
			function(data, menu)

				menu.close()

				CurrentAction     = 'shop_menu'
				CurrentActionMsg  = _U('press_menu')
				CurrentActionData = {}

			end
		)

	end, function(data, menu)

			menu.close()

			CurrentAction     = 'shop_menu'
			CurrentActionMsg  = _U('press_menu')
			CurrentActionData = {}

	end, {
		'tshirt_1',
		'tshirt_2',
		'torso_1',
		'torso_2',
		'decals_1',
		'decals_2',
		'arms',
		'pants_1',
		'pants_2',
		'shoes_1',
		'shoes_2',
		'chain_1',
		'chain_2',
		'helmet_1',
		'helmet_2',
		'glasses_1',
		'glasses_2',
	})

end

AddEventHandler('e5d1ad52-05ce-4746-8451-c808f16f58bd', function(zone)
	CurrentAction     = 'shop_menu'
	CurrentActionMsg  = _U('press_menu')
	CurrentActionData = {}
end)

AddEventHandler('72164cd2-78bf-48d0-b427-c2c0561e9e2f', function(zone)
	
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

	for i=1, #Config.Shops, 1 do

		local blip = AddBlipForCoord(Config.Shops[i].x, Config.Shops[i].y, Config.Shops[i].z)

		SetBlipSprite (blip, 73)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 1.0)
		SetBlipColour (blip, 47)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('clothes'))
		EndTextCommandSetBlipName(blip)
	end

end)

local nearzones = false
-- Display markers
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(5)

		local coords = GetEntityCoords(GetPlayerPed(-1))
		local znearzones = false

		for k,v in pairs(Config.Zones) do
			if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
				znearzones = true
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
			end
		end
		
		if znearzones == false then
			nearzones = false
			Wait(2000)
		else
			nearzones  = true
		end

	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(10)

		if nearzones then
			local coords      = GetEntityCoords(GetPlayerPed(-1))
			local isInMarker  = false
			local currentZone = nil

			for k,v in pairs(Config.Zones) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker  = true
					currentZone = k
				end
				Wait(30)
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone                = currentZone
				TriggerEvent('e5d1ad52-05ce-4746-8451-c808f16f58bd', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('72164cd2-78bf-48d0-b427-c2c0561e9e2f', LastZone)
			end
			
		else
			Wait(2000)
		end
	end
end)

-- Key controls
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(10)

		if CurrentAction ~= nil then

			SetTextComponentFormat('STRING')
			AddTextComponentString(CurrentActionMsg)
			DisplayHelpTextFromStringLabel(0, 0, 1, -1)

			if IsControlJustReleased(0, Keys['E']) then

				if CurrentAction == 'shop_menu' then
					OpenShopMenu()
				end

				CurrentAction = nil

			end

		else
			Citizen.Wait(2000)
		end

	end
end)
