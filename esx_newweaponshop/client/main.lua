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
local HasAlreadyEnteredMarker = false
local LastZone = nil
local CurrentAction = nil
local CurrentActionMsg = ''
local CurrentActionData = {}
local ShopOpen = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	print(json.encode(ESX.GetPlayerData()))
end)




function OpenBuyLicenseMenu(zone)
	ESX.UI.Menu.CloseAll()
	ESX.TriggerServerCallback('49ac55fc-2a6b-421b-aaf2-e25249fd46c2', function(hasp)
		--ShowMPMessage("~r~PROHIBITION ORDER", "You are hereby prohibited from purchasing weapon", 13000)
		
		if hasp then
			ShowMPMessage("~r~PROHIBITION ORDER", "~b~POLICE~w~ have issued a ~r~prohibition order~w~ preventing you from ~o~acquiring~w~ weapons. We can't serve you here.\n\nYou can take the matter to court to have the order removed.", 13000)
		else
		
		ShowMPMessage("~g~CHECKING YOUR INFORMATION...", "Checking your licence information with ~b~POLICE. ~w~Please wait..", 3000)
			ESX.TriggerServerCallback('49ac55fc-2a6b-421b-aaf2-e25249fd46c2', function(hashg)
				ESX.TriggerServerCallback('49ac55fc-2a6b-421b-aaf2-e25249fd46c2', function(hasla)
					ESX.TriggerServerCallback('49ac55fc-2a6b-421b-aaf2-e25249fd46c2', function(hascc)
				
							local elementsa = {}
							if hashg then
								table.insert(elementsa, {label = ('Handgun Licence <span style="color: green;">%s</span>'):format("Owned"), value = 'already_hg' })	
							else
								table.insert(elementsa, { label = ('Handgun Licence <span style="color: green;">%s</span>'):format((_U('shop_menu_item', ESX.Math.GroupDigits(Config.HandgunPrice)))), value = 'weapon_hg' })
							end
							
							if  hasla then
								table.insert(elementsa, {label = ('Longarm Licence <span style="color: green;">%s</span>'):format("Owned"), value = 'already_la' })	
							else
								table.insert(elementsa, { label = ('Longarm Licence <span style="color: green;">%s</span>'):format((_U('shop_menu_item', ESX.Math.GroupDigits(Config.LongarmPrice)))), value = 'weapon_la' })
							end
							
							if hascc then
								table.insert(elementsa, {label = ('Concealed Carry Permit <span style="color: green;">%s</span>'):format("Owned"), value = 'already_cc' })	
							else
								table.insert(elementsa, { label = ('Concealed Carry Permit <span style="color: green;">%s</span>'):format((_U('shop_menu_item', ESX.Math.GroupDigits(Config.Concealed)))), value = 'weapon_cc' })
							end
							
							
							table.insert(elementsa, { label = 'Cancel', value = 'no' })
				
									
							ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'shop_license', {
							title = _U('buy_license'),
							align = 'top-right',
							elements = elementsa
							
						}, function(data, menu)
							
							if data.current.value == "already_hg" then
								PlaySoundFrontend(-1, 'ERROR', 'HUD_AMMO_SHOP_SOUNDSET', false)
								ShowMPMessage("~o~The Law", "You cannot carry this weapon on you legally without a conceal carry permit alternatively without a lawful excuse.\n\nHand guns carried overtly in a public place without lawful excuse is an offence.\n\nDischarging a firearm in a public place is an offence. A legal weapon can be secured lawfully in a vehicle boot/trunk.\n\n A lawful excuse example is: you are working and job requires it, your at the shooting range.", 20000)
							elseif data.current.value == "already_la" then
								PlaySoundFrontend(-1, 'ERROR', 'HUD_AMMO_SHOP_SOUNDSET', false)
								ShowMPMessage("~o~The Law", "You cannot carry this weapon on you in a public place without a lawful excuse.\n\nLong arms carried overtly in a public place without lawful excuse is an offence.\n\nDischarging a firearm in a public place is an offence. A legal weapon can be secured lawfully in a vehicle boot/trunk.\n\n A lawful excuse example is: you are working and job requires it, your at the shooting range.", 20000)
							elseif data.current.value == "already_cc" then
								PlaySoundFrontend(-1, 'ERROR', 'HUD_AMMO_SHOP_SOUNDSET', false)
								ShowMPMessage("~o~The Law", "A concealed carry permit allows you to carry legal handgun weapons (purchasable in the legal gun store) covertly without commiting an offence.\n\nYou must inform police at first interaction that you are armed and you have a permit. ", 20000)
							
							elseif data.current.value == "no" then
								menu.close()
							else
								ESX.TriggerServerCallback('923a4439-db6a-473b-a9b2-d17d4c9fb176', function(bought)
									if bought then
										Citizen.CreateThread(function()
											ShowMPMessage("~g~PURCHASED LICENCE", "Congratulations, you've successfully obtained your weapon licence!\n", 2000)
											Wait(2500)
											if data.current.value == "weapon_hg" then
												ShowMPMessage("~o~The Law", "You cannot carry this weapon on you legally without a conceal carry permit alternatively without a lawful excuse.\n\nHandguns carried overtly in a public place without lawful excuse is an offence.\n\nDischarging a firearm in a public place is an offence.\n\n A lawful excuse example is: you are working and job requires it, your at the shooting range.", 20000)
											elseif data.current.value == "weapon_la" then
												ShowMPMessage("~o~The Law", "You cannot carry this weapon on you in a public place without a lawful excuse.\n\nLongarms carried overtly in a public place without lawful excuse is an offence.\n\nDischarging a firearm in a public place is an offence.\n\n A lawful excuse example is: you are working and job requires it, your at the shooting range.", 20000)
											elseif data.current.value == "weapon_cc" then
												ShowMPMessage("~o~The Law", "A concealed carry permit allows you to carry legal handgun weapons (purchasable in the legal gun store) covertly without commiting an offence. You must inform police at first interaction that you are armed and you have a permit. ", 20000)
											end
										
										end)
										menu.close()
									else
										PlaySoundFrontend(-1, 'ERROR', 'HUD_AMMO_SHOP_SOUNDSET', false)
									end
								end,data.current.value)
							end
						end, function(data, menu)
							menu.close()
						end)
					end, GetPlayerServerId(PlayerId()), 'weapon_cc')
				end, GetPlayerServerId(PlayerId()), 'weapon_la')
			end, GetPlayerServerId(PlayerId()), 'weapon_hg')
		end
	end, GetPlayerServerId(PlayerId()), 'weapon_p')


	
end

RegisterNetEvent('0c8dd51d-8352-4b36-8c9f-a04e7db8000d')
AddEventHandler('0c8dd51d-8352-4b36-8c9f-a04e7db8000d', function(message, subtitle,ms)
	ShowMPMessage(message,subtitle, ms)
end)


function ShowMPMessage(message, subtitle, ms)
	-- do this in another thread
	Citizen.CreateThread(function()
		local scaleform = RequestScaleformMovie("mp_big_message_freemode")
		while not HasScaleformMovieLoaded(scaleform) do
			Citizen.Wait(0)
		end
		
		BeginScaleformMovieMethod(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
		PushScaleformMovieMethodParameterString(message)
		PushScaleformMovieMethodParameterString(subtitle)
		PushScaleformMovieMethodParameterInt(0)
		EndScaleformMovieMethod()

		local time = GetGameTimer() + ms
        
        while(GetGameTimer() < time) do
			Citizen.Wait(0)
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
		end
	end)
end

function OpenShopMenu(zone, hashg,haslg)
	local elements = {}
	local buyAmmo = {}
	ShopOpen = true
	local playerPed = PlayerPedId()
	PlayerData = ESX.GetPlayerData()
						----------------------MENU
	for k,v in ipairs(Config.Zones[zone].Items) do
	
		local allow = false
		if v.wl ~= nil then

			if v.wl == "la" then
				if haslg == true then

					allow = true
				end
			elseif v.wl == "hg" then
				if hashg == true then
					allow = true
				end
			end
		else
			allow = true
		end
		
		if allow == true then
			local weaponNum, weapon = ESX.GetWeapon(v.weapon)
			local components, label = {}
			local inventory = ESX.GetPlayerData().inventory
			
			local hasWeapon = false --HasPedGotWeapon(playerPed, GetHashKey(v.weapon), false)

			for x,y in pairs(inventory) do
				print(y.name)
				if y.name == string.lower(v.weapon) and y.count > 0 then
					print('has weapon log')
					hasWeapon = true
					break
				end
			end
			--[[
			if v.components then
				for i=1, #v.components do
					if v.components[i] then

						local component = weapon.components[i]
						local hasComponent = HasPedGotWeaponComponent(playerPed, GetHashKey(v.weapon), component.hash)

						if hasComponent then
							label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('gunshop_owned'))
						else
							if v.components[i] > 0 then
								label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('gunshop_item', ESX.Math.GroupDigits(v.components[i])))
							else
								label = ('%s: <span style="color:green;">%s</span>'):format(component.label, _U('gunshop_free'))
							end
						end

						table.insert(components, {
							label = label,
							componentLabel = component.label,
							hash = component.hash,
							name = component.name,
							price = v.components[i],
							hasComponent = hasComponent,
							componentNum = i
						})
					end
				end
				table.insert(components, {
					label = _U('buy_ammo')..'<span style="color:green;">'..ESX.Math.GroupDigits(v.ammoPrice)..' $ </span>',
					type = 'ammo',
					price = v.ammoPrice,
					weapon = weapon.name,
					ammoNumber = v.AmmoToGive
				})
			end--]]

			if hasWeapon and v.components then
				label = ('%s: <span style="color:green;">></span>'):format(weapon.label)
			elseif hasWeapon and not v.components and v.ammoPrice ~= nil then
				label = ('%s: <span style="color:green;">></span>'):format(weapon.label)
			elseif hasWeapon and not v.components and v.ammoPrice  == nil then
				label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('gunshop_owned'))
			else
				if v.price > 0 then
					label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('gunshop_item', ESX.Math.GroupDigits(v.price)))
				else
					label = ('%s: <span style="color:green;">%s</span>'):format(weapon.label, _U('gunshop_free'))
				end
			end
			
			table.insert(elements, {
				label = label,
				weaponLabel = weapon.label,
				name = weapon.name,
				components = components,
				price = v.price,
				ammoPrice = v.ammoPrice,
				ammoNumber = v.AmmoToGive,
				hasWeapon = hasWeapon,
				ar = v.ar
			})
		end
	end
	PlaySoundFrontend(-1, 'BACK', 'HUD_AMMO_SHOP_SOUNDSET', false)

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gunshop_buy_weapons', {
		title    = _U('gunshop_weapontitle'),
		align    = 'top-right',
		elements = elements
	}, function(data, menu)

		if data.current.hasWeapon then
			if #data.current.components > 0 then
				OpenWeaponComponentShopMenu(data.current.components, data.current.name, menu, zone, hashg,haslg)
			elseif data.current.ammoPrice ~= nil then
				buyAmmo = {}
				table.insert(buyAmmo, {
					label = _U('buy_ammo')..'<span style="color:green;">'..ESX.Math.GroupDigits(data.current.ammoPrice)..' $ </span>',
					price = data.current.ammoPrice,
					weapon = data.current.name,
					ammoToBuy = data.current.ammoNumber
				})
				--print(ESX.DumpTable(buyAmmo))

				OpenAmmoShopMenu(buyAmmo,data.current.name,menu,zone)
			end
			
		else
			
			ESX.TriggerServerCallback('49149174-339e-4d7c-80c5-f28537c4cb05', function(bought)
				if bought then
					if data.current.price > 0 then
						DisplayBoughtScaleform('weapon',data.current.name, ESX.Math.GroupDigits(data.current.price))
					end
					PlaySoundFrontend(-1, 'NAV', 'HUD_AMMO_SHOP_SOUNDSET', false)
					menu.close()
					OpenShopMenu(zone,hashg,haslg)
					ShopOpen = false
				else
					PlaySoundFrontend(-1, 'ERROR', 'HUD_AMMO_SHOP_SOUNDSET', false)
				end
			end, data.current.name, 1, nil, zone, nil,data.current.ar)
		end

	end, function(data, menu)
		PlaySoundFrontend(-1, 'BACK', 'HUD_AMMO_SHOP_SOUNDSET', false)
		ShopOpen = false
		menu.close()
	end)
						
						----------------------MENU
			


	

end

function OpenWeaponComponentShopMenu(components, weaponName, parentShop,zone, hashg,haslg)
	ShopOpen = true

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gunshop_buy_weapons_components', {
		title    = _U('gunshop_componenttitle'),
		align    = 'top-right',
		elements = components
	}, function(data, menu)


		if data.current.hasComponent and data.current.type ~= 'ammo'then
			ESX.ShowNotification(_U('gunshop_hascomponent'))
		elseif data.current.type ~= 'ammo' then

			ESX.TriggerServerCallback('49149174-339e-4d7c-80c5-f28537c4cb05', function(bought)
				if bought then
					if data.current.price > 0 then
						DisplayBoughtScaleform('component',data.current.componentLabel, ESX.Math.GroupDigits(data.current.price))
					end
					ShopOpen = false
					menu.close()
					PlaySoundFrontend(-1, 'NAV', 'HUD_AMMO_SHOP_SOUNDSET', false)
					OpenShopMenu(zone,hashg,haslg)
				else
					PlaySoundFrontend(-1, 'ERROR', 'HUD_AMMO_SHOP_SOUNDSET', false)
				end
			end, weaponName, 2, data.current.componentNum, zone)
		elseif data.current.type == 'ammo' then

			local ReachedMax = ReachedMaxAmmo(weaponName)
			ESX.TriggerServerCallback('49149174-339e-4d7c-80c5-f28537c4cb05', function(bought)

				if bought then

					if data.current.price > 0 then
						ESX.ShowNotification(_U('gunshop_bought',_U('ammo'),ESX.Math.GroupDigits(data.current.price)))
						--AddAmmoToPed(PlayerPedId(), weaponName, data.current.ammoNumber)
					end
					
				else

					if ReachedMax then
						ESX.ShowNotification(_U('gunshop_maxammo'))
					end
					PlaySoundFrontend(-1, 'ERROR', 'HUD_AMMO_SHOP_SOUNDSET', false)
				end
			end, weaponName, 3, nil, zone, ReachedMax)
		end

	end, function(data, menu)
		PlaySoundFrontend(-1, 'BACK', 'HUD_AMMO_SHOP_SOUNDSET', false)
		ShopOpen = false
		menu.close()
	end)
end

function OpenAmmoShopMenu(buyAmmo,weaponName, parentShop,zone)
	ShopOpen = true

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'gunshop_buy_weapons_components', {
		title    = _U('gunshop_componenttitle'),
		align    = 'top-right',
		elements = buyAmmo
	}, function(data, menu)
	
		local ReachedMax = ReachedMaxAmmo(weaponName)
		ESX.TriggerServerCallback('49149174-339e-4d7c-80c5-f28537c4cb05', function(bought)

			if bought then
				if data.current.price > 0 then
					ESX.ShowNotification(_U('gunshop_bought',_U('ammo'),ESX.Math.GroupDigits(data.current.price)))
					AddAmmoToPed(PlayerPedId(), weaponName, data.current.ammoToBuy)
				end
				
			else
				if ReachedMax then
					ESX.ShowNotification(_U('gunshop_maxammo'))
				end
				PlaySoundFrontend(-1, 'ERROR', 'HUD_AMMO_SHOP_SOUNDSET', false)
			end
		end, weaponName, 3, nil, zone, ReachedMax)

	end, function(data, menu)
		menu.close()
	end)
end

function DisplayBoughtScaleform(type, item, price)
	local scaleform = ESX.Scaleform.Utils.RequestScaleformMovie('MP_BIG_MESSAGE_FREEMODE')
	local sec = 4

	if type == 'component' then
		text = _U('gunshop_bought', item, ESX.Math.GroupDigits(price))
		text2 = nil
		text3 = nil
	elseif type == 'weapon' then
		text2 = ESX.GetWeaponLabel(item)
		text = _U('gunshop_bought', text2, ESX.Math.GroupDigits(price))
		text3 = GetHashKey(item)
	end


	BeginScaleformMovieMethod(scaleform, 'SHOW_WEAPON_PURCHASED')

	PushScaleformMovieMethodParameterString(text)
	if text2 then
		PushScaleformMovieMethodParameterString(text2)
	end
	if text3 then
		PushScaleformMovieMethodParameterInt(text3)
	end
	PushScaleformMovieMethodParameterString('')
	PushScaleformMovieMethodParameterInt(100)

	EndScaleformMovieMethod()

	PlaySoundFrontend(-1, 'WEAPON_PURCHASE', 'HUD_AMMO_SHOP_SOUNDSET', false)

	Citizen.CreateThread(function()
		while sec > 0 do
			Citizen.Wait(0)
			sec = sec - 0.01
	
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
		end
	end)
end

AddEventHandler('f861d122-d988-4a81-bc1b-2848968d2eac', function(zone)
	if  zone == 'BlackWeashop' then
		local hour = GetClockHours()
		if ((hour >= 0 and hour < 3)) then
			CurrentAction     = 'shop_menu'
			CurrentActionMsg  = _U('shop_menu_black')
			CurrentActionData = { zone = zone }
		else

		
		end

	elseif zone == 'GunShop' then
			CurrentAction     = 'shop_menu'
			CurrentActionMsg  = _U('shop_menu_prompt')
			CurrentActionData = { zone = zone }
	end
end)

AddEventHandler('b3b0a1a6-509c-4662-a2bb-f0b8f85e99f3', function(zone)
	CurrentAction = nil
	ESX.UI.Menu.CloseAll()
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		if ShopOpen then
			ESX.UI.Menu.CloseAll()
		end
	end
end)

-- Create Blips
Citizen.CreateThread(function()
	for k,v in pairs(Config.Zones) do
		if v.Legal then
			for i = 1, #v.Locations, 1 do
				
				local blip = AddBlipForCoord(v.Locations[i])

				SetBlipSprite (blip, 110)
				SetBlipDisplay(blip, 4)
				SetBlipScale  (blip, 1.0)
				SetBlipColour (blip, 81)
				SetBlipAsShortRange(blip, true)

				BeginTextCommandSetBlipName("STRING")
				AddTextComponentSubstringPlayerName(_U('map_blip'))
				EndTextCommandSetBlipName(blip)
			end
		end
	end
end)

-- Display markers
local nearlocation = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		local coords = GetEntityCoords(PlayerPedId())
		local lnearlocation = false
		for k,v in pairs(Config.Zones) do
			for i = 1, #v.Locations, 1 do
				if (Config.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Locations[i], true) < Config.DrawDistance) then
					lnearlocation = true
					nearlocation = true
					DrawMarker(Config.Type, v.Locations[i], 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Size.x, Config.Size.y, Config.Size.z + 0.58, Config.Color.r, Config.Color.g, Config.Color.b, 100, false, true, 2, false, false, false, false)
				end
			end
		end
		
		if lnearlocation == false then
			Wait(3000)
		else
			nearlocation = true
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		
		if nearlocation == true then
			
		
			local coords = GetEntityCoords(PlayerPedId())
			local isInMarker, currentZone = false, nil

			for k,v in pairs(Config.Zones) do
				for i=1, #v.Locations, 1 do
					if GetDistanceBetweenCoords(coords, v.Locations[i], true) < Config.Size.x then
						isInMarker, ShopItems, currentZone, LastZone = true, v.Items, k, k
						--print('in in marker' .. currentZone)
					end
				end
			end
			if isInMarker and not HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = true
				TriggerEvent('f861d122-d988-4a81-bc1b-2848968d2eac', currentZone)
			end
			
			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('b3b0a1a6-509c-4662-a2bb-f0b8f85e99f3', LastZone)
			end
			
		else
			Wait(3000)
		end
	end
end)

-- Key Controls
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if nearlocation then
			if CurrentAction ~= nil then
				ESX.ShowHelpNotification(CurrentActionMsg)

				if IsControlJustReleased(0, Keys['E']) then

					if CurrentAction == 'shop_menu' then
					
					
					
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'weapon_shop', {
					title = 'Gun Dealer',
					align = 'top-right',
					elements = {
						{ label = 'Weapons Licences', value = 'wl'},
						{ label = 'Open Shop', value = 'shop'}
					 }
					}, function(data, menu)
						if data.current.value == 'shop' then
							ESX.TriggerServerCallback('49ac55fc-2a6b-421b-aaf2-e25249fd46c2', function(hasp)
						
								if hasp then
									ShowMPMessage("~r~PROHIBITION ORDER", "~b~POLICE~w~ have issued a ~r~prohibition order~w~ preventing you from ~o~acquiring~w~ weapons. We can't serve you here. \n\n You can take the matter to court to have the order removed.", 13000)
								else
								
									ShowMPMessage("~g~CHECKING YOUR INFORMATION...", "Checking your licence information with ~b~POLICE. ~w~Please wait..", 2500)
									ESX.TriggerServerCallback('49ac55fc-2a6b-421b-aaf2-e25249fd46c2', function(hashg)
										ESX.TriggerServerCallback('49ac55fc-2a6b-421b-aaf2-e25249fd46c2', function(hasla)
											OpenShopMenu(CurrentActionData.zone,hashg, hasla)
										end, GetPlayerServerId(PlayerId()), 'weapon_la')
									end, GetPlayerServerId(PlayerId()), 'weapon_hg')
								end
				
							end, GetPlayerServerId(PlayerId()), 'weapon_p')
						else
							OpenBuyLicenseMenu(CurrentActionData.zone)
						end
						
					end, function(data, menu)
						menu.close()
					end)
							
					
					
					--[[
					
						ESX.TriggerServerCallback('923a4439-db6a-473b-a9b2-d17d4c9fb176', function(bought)
							if bought then
								menu.close()
								OpenShopMenu(zone)
							end
						end)--]]
					
					
					--[[
						if Config.LicenseEnable and Config.Zones[CurrentActionData.zone].Legal then
							ESX.TriggerServerCallback('49ac55fc-2a6b-421b-aaf2-e25249fd46c2', function(hasWeaponLicense)
								if hasWeaponLicense then
									OpenShopMenu(CurrentActionData.zone)
										
								else
									OpenBuyLicenseMenu(CurrentActionData.zone)
								end
							end, GetPlayerServerId(PlayerId()), 'weapon')
						else

							OpenShopMenu(CurrentActionData.zone)
						end --]]
					end

					CurrentAction = nil
				end
			end
		else
			Wait(3000)
		end
	end
end)

RegisterNetEvent('b26cb934-6d67-49a9-b259-7afc4bc388b6')
AddEventHandler('b26cb934-6d67-49a9-b259-7afc4bc388b6', function()
ShowMPMessage("~r~PROHIBITION ORDER", "~b~POLICE~w~ have issued a ~r~prohibition order~w~ preventing you from ~o~acquiring and possessing~w~ weapons.\n\nYOU COMMIT AN OFFENCE TO USE OR POSSESS A WEAPON UNTIL THE ORDER IS LIFTED.\n\nTHIS ORDER DOES NOT EXPIRE. You must make an application to have the matter heard in court to remove the order.", 25000)
end)



function ReachedMaxAmmo(weaponName)

	local ammo = GetAmmoInPedWeapon(PlayerPedId(), weaponName)
	local _,maxAmmo = GetMaxAmmo(PlayerPedId(), weaponName)

	if ammo ~= maxAmmo then
		return false
	else
		return true
	end

end
RegisterNetEvent('d7fd1833-ee69-4a14-b6fd-a29b222669a0')
AddEventHandler('d7fd1833-ee69-4a14-b6fd-a29b222669a0', function()
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
	if closestDistance <= 3.0 then
		TriggerServerEvent('esx:outlawgsror',GetPlayerServerId(closestPlayer))
	else
		ESX.ShowNotification('No Player(s) close by to test.')
	end
end)



RegisterNetEvent('3dda7fbc-3427-4d84-b240-210df17515de')
AddEventHandler('3dda7fbc-3427-4d84-b240-210df17515de', function(amount)
	AddArmourToPed(GetPlayerPed(-1),amount)
end)


RegisterNetEvent('91cb59f1-badd-49b3-a05f-631d967ffd2b')
AddEventHandler('91cb59f1-badd-49b3-a05f-631d967ffd2b', function(amount)
	AddArmourToPed(GetPlayerPed(-1),amount)
end)


