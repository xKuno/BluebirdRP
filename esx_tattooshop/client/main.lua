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

ESX								= nil
local currentTattoos			= {}
local cam						= -1
local HasAlreadyEnteredMarker	= false
local LastZone					= nil
local CurrentAction				= nil
local CurrentActionMsg			= ''
local CurrentActionData			= {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

AddEventHandler('3c27e7ae-48fa-44b3-842b-300533df6035', function()
	ESX.TriggerServerCallback('dffb09f9-2131-4695-8f5a-b97db9410340', function(tattooList)
		if tattooList then
			for _,k in pairs(tattooList) do
				ApplyPedOverlay(PlayerPedId(), GetHashKey(k.collection), GetHashKey(Config.TattooList[k.collection][k.texture].nameHash))
			end

			currentTattoos = tattooList
		end
	end)
end)

function OpenShopMenu()
	local elements = {}

	for _,k in pairs(Config.TattooCategories) do
		table.insert(elements, {label= k.name, value = k.value})
	end
	table.insert(elements, {label= 'Laser Tattoo Removal 20k', value = '20000'})
	if DoesCamExist(cam) then
		RenderScriptCams(false, false, 0, 1, 0)
		DestroyCam(cam, false)
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'tattoo_shop', {
		title    = _U('tattoos'),
		align    = 'top-right',
		elements = elements
	}, function(data, menu)
		local currentLabel, currentValue = data.current.label, data.current.value

		
		
		
		
		if data.current.value ~= nil then
		
			if data.current.value ~= '20000' then
			
				elements = { {label = _U('go_back_to_menu'), value = nil} }

				for i,k in pairs(Config.TattooList[data.current.value]) do
					table.insert(elements, {
						label = _U('tattoo_item', i, _U('money_amount', math.floor(k.price))),
						value = i,
						price = k.price
					})
				end

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'tattoo_shop_categories', {
					title    = _U('tattoos') .. ' | '..currentLabel,
					align    = 'top-right',
					elements = elements
				}, function(data2, menu2)
					local price = data2.current.price
					if data2.current.value ~= nil then

						ESX.TriggerServerCallback('6a0f8de4-9368-4ab1-8df6-092b61be61f9', function(success)
							if success then
								table.insert(currentTattoos, {collection = currentValue, texture = data2.current.value})
							end
						end, currentTattoos, price, {collection = currentValue, texture = data2.current.value})

					else
						OpenShopMenu()
						RenderScriptCams(false, false, 0, 1, 0)
						DestroyCam(cam, false)
						cleanPlayer()
					end

				end, function(data2, menu2)
					menu2.close()
					RenderScriptCams(false, false, 0, 1, 0)
					DestroyCam(cam, false)
					setPedSkin()
				end, function(data2, menu2) -- when highlighted
					if data2.current.value ~= nil then
						drawTattoo(data2.current.value, currentValue)
					end
				end)
				
			else
			--Laser Removal
						ESX.TriggerServerCallback('0f74630e-5361-417e-81b3-36f539a29539', function(success)
							if success then
							print('success is herein')
								currentTattoos = {}
								cleanPlayer()
								ClearPedDecorations(GetPlayerPed(-1))
							end
						end, currentTattoos, 20000)
			
			end
		
		
			
			
		
		end
	end, function(data, menu)
		menu.close()
		setPedSkin()
	end)
end

Citizen.CreateThread(function()
	for _,k in pairs(Config.Zones) do
		local blip = AddBlipForCoord(k.x, k.y, k.z)
		SetBlipSprite(blip, 75)
		SetBlipColour(blip, 1)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName('STRING')
		AddTextComponentString(_U('tattoo_shop'))
		EndTextCommandSetBlipName(blip)
	end
end)

-- Display markers
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if canSleep then
			Citizen.Wait(3000)
		else
			local coords = GetEntityCoords(PlayerPedId()), true

			for k,v in pairs(Config.Zones) do

				if (Config.Type ~= -1 and GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true) < Config.DrawDistance) then
					DrawMarker(Config.Type, v.x, v.y, v.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
					canSleep = false
				end

			end
		end
	end
  end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local coords      = GetEntityCoords(PlayerPedId())
		local isInMarker  = false
		local currentZone = nil
		local canSleepc   = false

		for k,v in pairs(Config.Zones) do
			local dist = GetDistanceBetweenCoords(coords, v.x, v.y, v.z, true)
			if dist < 30 then
				canSleepc = true
				if dist  < Config.Size.x then
					isInMarker  = true
					currentZone = k
					LastZone    = k
				end
			end
			Wait(100)
		end
		
		if canSleepc then
			canSleep = false
		else
			canSleep = true
			Wait(3000)
		end
		
		if isInMarker and not HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = true
			TriggerEvent('fe74c33d-d319-454a-ad49-17beed99f533', currentZone)
		end

		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('80351b1f-9f47-4199-bf09-753401159b26', LastZone)
		end
	end
end)

AddEventHandler('fe74c33d-d319-454a-ad49-17beed99f533', function(zone)
	CurrentAction     = 'tattoo_shop'
	CurrentActionMsg  = _U('tattoo_shop_nearby')
	CurrentActionData = {zone = zone}
end)

AddEventHandler('80351b1f-9f47-4199-bf09-753401159b26', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if CurrentAction ~= nil then
			ESX.ShowHelpNotification(CurrentActionMsg)

			if IsControlJustReleased(0, Keys['E']) then
				if CurrentAction == 'tattoo_shop' then
					OpenShopMenu()
				end
				CurrentAction = nil
			end
		else
			Citizen.Wait(500)
		end
	end
end)

function setPedSkin()
	ESX.TriggerServerCallback('4568d939-3661-4833-ae6a-378432ac6ff1', function(skin)
		TriggerEvent('56a2ee13-8a49-4ad3-a298-1854493c98ee', skin)
	end)

	Citizen.Wait(1000)

	for _,k in pairs(currentTattoos) do
		ApplyPedOverlay(PlayerPedId(), GetHashKey(k.collection), GetHashKey(Config.TattooList[k.collection][k.texture].nameHash))
	end
end

function drawTattoo(current, collection)
	SetEntityHeading(PlayerPedId(), 297.7296)
	ClearPedDecorations(PlayerPedId())

	for _,k in pairs(currentTattoos) do
		ApplyPedOverlay(PlayerPedId(), GetHashKey(k.collection), GetHashKey(Config.TattooList[k.collection][k.texture].nameHash))
	end

	TriggerEvent('d3bdbe20-bf7d-4df2-9ef6-9026a86a6e87', function(skin)
		if skin.sex == 0 then
			TriggerEvent('56a2ee13-8a49-4ad3-a298-1854493c98ee', {
				sex      = 0,
				tshirt_1 = 15,
				tshirt_2 = 0,
				arms     = 15,
				torso_1  = 91,
				torso_2  = 0,
				pants_1  = 14,
				pants_2  = 0
			})
		else
			TriggerEvent('56a2ee13-8a49-4ad3-a298-1854493c98ee', {
				sex      = 1,
				tshirt_1 = 34,
				tshirt_2 = 0,
				arms     = 15,
				torso_1  = 101,
				torso_2  = 1,
				pants_1  = 16,
				pants_2  = 0
			})
		end
	end)

	ApplyPedOverlay(PlayerPedId(), GetHashKey(collection), GetHashKey(Config.TattooList[collection][current].nameHash))

	if not DoesCamExist(cam) then
		cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)

		SetCamCoord(cam, GetEntityCoords(PlayerPedId()))
		SetCamRot(cam, 0.0, 0.0, 0.0)
		SetCamActive(cam, true)
		RenderScriptCams(true, false, 0, true, true)
		SetCamCoord(cam, GetEntityCoords(PlayerPedId()))
	end

	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))

	SetCamCoord(cam, x + Config.TattooList[collection][current].addedX, y + Config.TattooList[collection][current].addedY, z + Config.TattooList[collection][current].addedZ)
	SetCamRot(cam, 0.0, 0.0, Config.TattooList[collection][current].rotZ)
end

function cleanPlayer()
	ClearPedDecorations(PlayerPedId())

	for _,k in pairs(currentTattoos) do
		ApplyPedOverlay(PlayerPedId(), GetHashKey(k.collection), GetHashKey(Config.TattooList[k.collection][k.texture].nameHash))
	end
end
