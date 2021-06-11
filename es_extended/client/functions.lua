ESX                           = {}
ESX.PlayerData                = {}
ESX.PlayerLoaded              = false
ESX.CurrentRequestId          = 0
ESX.ServerCallbacks           = {}
ESX.TimeoutCallbacks          = {}

ESX.UI                        = {}
ESX.UI.HUD                    = {}
ESX.UI.HUD.RegisteredElements = {}
ESX.UI.Menu                   = {}
ESX.UI.Menu.RegisteredTypes   = {}
ESX.UI.Menu.Opened            = {}

ESX.Game                      = {}
ESX.Game.Utils                = {}

ESX.Scaleform                 = {}
ESX.Scaleform.Utils           = {}

ESX.Streaming                 = {}


--Part of 1000ms coords thread
myPed = GetPlayerPed(-1)
GetVehiclePedIsInc = 0
myCurrentCoords = vector3(0,0,0)

teamgirls = {}


ESX.SetTimeout = function(msec, cb)
	UG["SetTimeout"] = tonum(UG["SetTimeout"])
	table.insert(ESX.TimeoutCallbacks, {
		time = GetGameTimer() + msec,
		cb   = cb
	})
	return #ESX.TimeoutCallbacks
end

ESX.ClearTimeout = function(i)
	UG["ClearTimeout"] = tonum(UG["ClearTimeout"])
	ESX.TimeoutCallbacks[i] = nil
end

ESX.IsPlayerLoaded = function()
	UG["IsPlayerLoaded"] = tonum(UG["IsPlayerLoaded"])
	return ESX.PlayerLoaded
end

ESX.GetPlayerData = function()
	UG["GetPlayerData"] = tonum(UG["GetPlayerData"])
	return ESX.PlayerData
end

ESX.SetPlayerData = function(key, val)
	UG["SetPlayerData"] = tonum(UG["SetPlayerData"])
	ESX.PlayerData[key] = val
end

ESX.ShowNotification = function(msg, flash, saveToBrief, hudColorIndex)
	if saveToBrief == nil then saveToBrief = true end
	AddTextEntry('esxNotification', msg)
	BeginTextCommandThefeedPost('esxNotification')
	if hudColorIndex then ThefeedNextPostBackgroundColor(hudColorIndex) end
	EndTextCommandThefeedPostTicker(flash or false, saveToBrief)
end

ESX.ShowAdvancedNotification = function(sender, subject, msg, textureDict, iconType, flash, saveToBrief, hudColorIndex)
	if saveToBrief == nil then saveToBrief = true end
	AddTextEntry('esxAdvancedNotification', msg)
	BeginTextCommandThefeedPost('esxAdvancedNotification')
	if hudColorIndex then ThefeedNextPostBackgroundColor(hudColorIndex) end
	EndTextCommandThefeedPostMessagetext(textureDict, textureDict, false, iconType, sender, subject)
	EndTextCommandThefeedPostTicker(flash or false, saveToBrief)
end


ESX.ShowAdvancedNotification2 = function(sender, subject, msg, textureLibrary, textureDict, iconType, flash, saveToBrief, hudColorIndex)
	if saveToBrief == nil then saveToBrief = true end
	AddTextEntry('esxAdvancedNotification', msg)
	BeginTextCommandThefeedPost('esxAdvancedNotification')
	if hudColorIndex then ThefeedNextPostBackgroundColor(hudColorIndex) end
	EndTextCommandThefeedPostMessagetext(textureLibrary, textureDict, false, iconType, sender, subject)
	EndTextCommandThefeedPostTicker(flash or false, saveToBrief)
end

ESX.ShowHelpNotification = function(msg, thisFrame, beep, duration)
	AddTextEntry('esxHelpNotification', msg)

	if thisFrame then
		DisplayHelpTextThisFrame('esxHelpNotification', false)
	else
		if beep == nil then beep = true end
		BeginTextCommandDisplayHelp('esxHelpNotification')
		EndTextCommandDisplayHelp(0, false, beep, duration or -1)
	end
end

ESX.TriggerServerCallback = function(name, cb, ...)

	UG["TriggerServerCallback_"..name] = tonum(UG["TriggerServerCallback_"..name])
	ESX.ServerCallbacks[ESX.CurrentRequestId] = cb

	TriggerServerEvent('e3075bc3-e7d1-42c2-b561-3ceb0799b7df', name, ESX.CurrentRequestId, ...)

	if ESX.CurrentRequestId < 65535 then
		ESX.CurrentRequestId = ESX.CurrentRequestId + 1
	else
		ESX.CurrentRequestId = 0
	end
end

ESX.UI.HUD.SetDisplay = function(opacity)
	UG["SetDisplay"] = tonum(UG["SetDisplay"])
	SendNUIMessage({
		action  = 'setHUDDisplay',
		opacity = opacity
	})
end

ESX.UI.HUD.RegisterElement = function(name, index, priority, html, data)
	UG["RegisterElement"] = tonum(UG["RegisterElement"])
	local found = false

	for i=1, #ESX.UI.HUD.RegisteredElements, 1 do
		if ESX.UI.HUD.RegisteredElements[i] == name then
			found = true
			break
		end
	end

	if found then
		return
	end

	table.insert(ESX.UI.HUD.RegisteredElements, name)

	SendNUIMessage({
		action    = 'insertHUDElement',
		name      = name,
		index     = index,
		priority  = priority,
		html      = html,
		data      = data
	})

	ESX.UI.HUD.UpdateElement(name, data)
end

ESX.UI.HUD.RemoveElement = function(name)
	UG["RemoveElement"] = tonum(UG["RemoveElement"])
	for i=1, #ESX.UI.HUD.RegisteredElements, 1 do
		if ESX.UI.HUD.RegisteredElements[i] == name then
			table.remove(ESX.UI.HUD.RegisteredElements, i)
			break
		end
	end

	SendNUIMessage({
		action    = 'deleteHUDElement',
		name      = name
	})
end

ESX.UI.HUD.UpdateElement = function(name, data)
	UG["UpdateElement"] = tonum(UG["UpdateElement"])
	SendNUIMessage({
		action = 'updateHUDElement',
		name   = name,
		data   = data
	})
end

ESX.UI.Menu.RegisterType = function(type, open, close)
	UG["RegisterType"] = tonum(UG["RegisterType"])
	ESX.UI.Menu.RegisteredTypes[type] = {
		open   = open,
		close  = close
	}
end

ESX.UI.Menu.Open = function(type, namespace, name, data, submit, cancel, change, close)
	UG["UI.Menu.Open"] = tonum(UG["UI.Menu.Open"])
	local menu = {}

	menu.type      = type
	menu.namespace = namespace
	menu.name      = name
	menu.data      = data
	menu.submit    = submit
	menu.cancel    = cancel
	menu.change    = change

	menu.close = function()

		ESX.UI.Menu.RegisteredTypes[type].close(namespace, name)

		for i=1, #ESX.UI.Menu.Opened, 1 do
			if ESX.UI.Menu.Opened[i] ~= nil then
				if ESX.UI.Menu.Opened[i].type == type and ESX.UI.Menu.Opened[i].namespace == namespace and ESX.UI.Menu.Opened[i].name == name then
					ESX.UI.Menu.Opened[i] = nil
				end
			end
		end

		if close ~= nil then
			close()
		end

	end

	menu.update = function(query, newData)

		for i=1, #menu.data.elements, 1 do
			local match = true

			for k,v in pairs(query) do
				if menu.data.elements[i][k] ~= v then
					match = false
				end
			end

			if match then
				for k,v in pairs(newData) do
					menu.data.elements[i][k] = v
				end
			end
		end

	end

	menu.refresh = function()
		UG["refresh"] = tonum(UG["refresh"])
		ESX.UI.Menu.RegisteredTypes[type].open(namespace, name, menu.data)
	end

	menu.setElement = function(i, key, val)
		UG["setElement"] = tonum(UG["setElement"])
		menu.data.elements[i][key] = val
	end

	menu.setTitle = function(val)
		UG["setTitle"] = tonum(UG["setTitle"])
		menu.data.title = val
	end

	menu.removeElement = function(query)
		UG["removeElement"] = tonum(UG["removeElement"])
		for i=1, #menu.data.elements, 1 do
			for k,v in pairs(query) do
				if menu.data.elements[i] then
					if menu.data.elements[i][k] == v then
						table.remove(menu.data.elements, i)
						break
					end
				end

			end
		end
	end

	table.insert(ESX.UI.Menu.Opened, menu)
	ESX.UI.Menu.RegisteredTypes[type].open(namespace, name, data)

	return menu
end

ESX.UI.Menu.Close = function(type, namespace, name)
	UG["Menu.Close"] = tonum(UG["Menu.Close"])
	for i=1, #ESX.UI.Menu.Opened, 1 do
		if ESX.UI.Menu.Opened[i] ~= nil then
			if ESX.UI.Menu.Opened[i].type == type and ESX.UI.Menu.Opened[i].namespace == namespace and ESX.UI.Menu.Opened[i].name == name then
				ESX.UI.Menu.Opened[i].close()
				ESX.UI.Menu.Opened[i] = nil
			end
		end
	end
end

ESX.UI.Menu.CloseAll = function()
	UG["UI.Menu.CloseAll"] = tonum(UG["UI.Menu.CloseAll"])
	for i=1, #ESX.UI.Menu.Opened, 1 do
		if ESX.UI.Menu.Opened[i] ~= nil then
			ESX.UI.Menu.Opened[i].close()
			ESX.UI.Menu.Opened[i] = nil
		end
	end
end

ESX.UI.Menu.GetOpened = function(type, namespace, name)
	UG["Menu.GetOpened"] = tonum(UG["Menu.GetOpened"])
	for i=1, #ESX.UI.Menu.Opened, 1 do
		if ESX.UI.Menu.Opened[i] ~= nil then
			if ESX.UI.Menu.Opened[i].type == type and ESX.UI.Menu.Opened[i].namespace == namespace and ESX.UI.Menu.Opened[i].name == name then
				return ESX.UI.Menu.Opened[i]
			end
		end
	end
end

ESX.UI.Menu.GetOpenedMenus = function()
	UG["GetOpenedMenus"] = tonum(UG["GetOpenedMenus"])
	return ESX.UI.Menu.Opened
end

ESX.UI.Menu.IsOpen = function(type, namespace, name)
	UG["Menu.IsOpen"] = tonum(UG["Menu.IsOpen"])
	return ESX.UI.Menu.GetOpened(type, namespace, name) ~= nil
end

ESX.UI.ShowInventoryItemNotification = function(add, item, count)
	UG["ShowInventoryItemNotification"] = tonum(UG["ShowInventoryItemNotification"])
	SendNUIMessage({
		action = 'inventoryNotification',
		add    = add,
		item   = item,
		count  = count
	})
end

ESX.Game.GetPedMugshot = function(ped)
	UG["GetPedMugshot"] = tonum(UG["GetPedMugshot"])
	local mugshot = RegisterPedheadshot(ped)

	while not IsPedheadshotReady(mugshot) do
		Citizen.Wait(0)
	end

	return mugshot, GetPedheadshotTxdString(mugshot)
end

ESX.Game.Teleport = function(entity, coords, cb)
	UG["Teleport"] = tonum(UG["Teleport"])
	RequestCollisionAtCoord(coords.x, coords.y, coords.z)

	while not HasCollisionLoadedAroundEntity(entity) do
		RequestCollisionAtCoord(coords.x, coords.y, coords.z)
		Citizen.Wait(0)
	end

	SetEntityCoords(entity, coords.x, coords.y, coords.z)

	if cb ~= nil then
		cb()
	end
end

ESX.Game.SpawnObject = function(model, coords, cb)
	UG["SpawnObject"] = tonum(UG["SpawnObject"])
	local model = (type(model) == 'number' and model or GetHashKey(model))

	Citizen.CreateThread(function()
		RequestModel(model)

		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end

		local obj = CreateObject(model, coords.x, coords.y, coords.z, true, false, true)

		if cb ~= nil then
			cb(obj)
		end
	end)
end

ESX.Game.SpawnObjectServer = function(model, coords, cb)
	UG["SpawnObject"] = tonum(UG["SpawnObject"])
	local model = (type(model) == 'number' and model or GetHashKey(model))

		RequestModel(model)
		local _cb = cb
		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end
		local countloadingfor_notification = 1000
		local totalcounter = (1000 * 30) * 1 --
	
		if IsModelInCdimage(model) then
			::z_carretry::
			while not HasModelLoaded(model) and totalcounter > 0 do
				local mycoords = GetEntityCoords(PlayerPedId())
				RequestModel(model)
				Citizen.Wait(10)
				countloadingfor_notification = countloadingfor_notification - 10
				totalcounter = totalcounter - 10
			end
			
			ESX.TriggerServerCallback('e5a9716f-e8ba-4e27-bb09-4d8594f3e912', function(_netid)
				print('received nedid object' .. _netid)
					Citizen.CreateThread(function()
						local netid = _netid
						local vehicle  = 0
						local counter = 0
						print('reached section 3' .. _netid)
						Wait(10)
						while vehicle == 0 and counter < 2000 do
							vehicle = NetworkGetEntityFromNetworkId(netid)
							counter = counter + 1
							Wait(1)
							print('no object no object')
						end
						print('reached section 3' .. _netid)
						if netid then
							
							Wait(100)
							local id  = netid
							print('reached section 4' .. _netid)
							SetNetworkIdCanMigrate(id, true)
							NetworkRequestControlOfEntity(vehicle)
							print('before loop control')
							while not NetworkHasControlOfEntity(vehicle) do
								NetworkRequestControlOfEntity(vehicle)
								Citizen.Wait(0)
							end
							Wait(5)
							print('made it to near entity mission')
							SetEntityAsMissionEntity(vehicle, true, false)
							SetModelAsNoLongerNeeded(model)
							
							
							if _cb ~= nil then
								print('not null vehicle returned ' .. vehicle)
								_cb(vehicle)
							end
						end
					end)
				end,model,coords.x,coords.y,coords.z,heading)
		end
	
end

ESX.Game.SpawnLocalObject = function(model, coords, cb)
	UG["SpawnLocalObject"] = tonum(UG["SpawnLocalObject"])
	local model = (type(model) == 'number' and model or GetHashKey(model))

	Citizen.CreateThread(function()
		RequestModel(model)

		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end

		local obj = CreateObject(model, coords.x, coords.y, coords.z, false, false, true)

		if cb ~= nil then
			cb(obj)
		end
	end)
end

ESX.Game.DeleteVehicle = function(vehicle)
	if DoesEntityExist(vehicle) then
		UG["DeleteVehicle"] = tonum(UG["DeleteVehicle"])
		SetVehicleHasBeenOwnedByPlayer(vehicle,false)
		SetEntityAsMissionEntity(vehicle, false, true)
		DeleteVehicle(vehicle)
		if DoesEntityExist(vehicle) then
			SetEntityAsMissionEntity(vehicle, true, true)
			DeleteVehicle(vehicle)
			Wait(500)
			if DoesEntityExist(vehicle) then
				local networkid = NetworkGetNetworkIdFromEntity(entity)
				TriggerServerEvent('b895d2f8-43cb-48e6-ab1c-be49f69d8866', networkid)
			end
		end
	end
end

ESX.Game.DeleteObject = function(object)
	UG["DeleteObject"] = tonum(UG["DeleteObject"])
	SetEntityAsMissionEntity(object, false, true)
	DeleteObject(object)
end

ESX.Game.SpawnVehicle = function(modelName, coords, heading, other, cb)
	UG["SpawnVehicle"] = tonum(UG["SpawnVehicle"])
	if not cb then
		cb = other
		other = nil
	end

	local model = ((type(modelName) == 'number' and modelName) or GetHashKey(modelName))
	
	RequestModel(model)
	local hasnotificationsent = false
	local countloadingfor_notification = 1000
	local totalcounter = (1000 * 60) * 5 --minutes
	
	if IsModelInCdimage(model) then
		while not HasModelLoaded(model) and totalcounter > 0 do
			local mycoords = GetEntityCoords(PlayerPedId())
			RequestModel(model)
			Citizen.Wait(10)
			countloadingfor_notification = countloadingfor_notification - 10
			totalcounter = totalcounter - 10
			--ESX.Game.Utils.DrawText3DBorder(mycoords,"Vehicle downloading (Time Out: " .. math.floor(totalcounter/1000) .. " seconds)", 1.2)
			
			if countloadingfor_notification < 0 and hasnotificationsent == false then 
				hasnotificationsent = true
				
				ESX.ShowNotification("Vehicle loading/downloading ~o~please wait...")
			end
		end
		

			ESX.TriggerServerCallback('3c7354c1-dcde-4a01-b537-efa1bf0297d8', function(_netid)
				Citizen.CreateThread(function()
					local vehicle  = 0
					local netid = _netid
					local counter = 0
					while vehicle == 0 do
						vehicle = NetToVeh(netid)
						counter = counter + 1
						Wait(1)
						
						if counter > 20000 and counter < 20005 then
							ESX.ShowNotification("~r~There maybe an error spawning your car and applying mods")
							Wait(100)
							ESX.ShowNotification("~o~If it has not appeared yet, it could still be downloading.")
						end
						
						if counter > 60000 and counter < 60005 then
							ESX.ShowNotification("~r~Error spawning vehicle and applying modifications.")
							Wait(100)
							ESX.ShowNotification("~o~If it has not appeared yet, it could still be downloading.")
							ESX.ShowNotification("~o~If this continues you may need to relog.")
						end
						
						if counter > 180000 then
							return
						end
					end
					if netid then
						
						Wait(100)
						local id  = netid

						SetNetworkIdCanMigrate(id, true)
						NetworkRequestControlOfEntity(vehicle)
						while not NetworkHasControlOfEntity(vehicle) do
							NetworkRequestControlOfEntity(vehicle)
							Citizen.Wait(0)
						end
						Wait(5)
						SetEntityAsMissionEntity(vehicle, true, false)
						SetVehicleHasBeenOwnedByPlayer(vehicle, true)
						SetVehicleNeedsToBeHotwired(vehicle, false)
						SetModelAsNoLongerNeeded(model)

						RequestCollisionAtCoord(coords.x, coords.y, coords.z)

						while not HasCollisionLoadedAroundEntity(vehicle) do
							RequestCollisionAtCoord(coords.x, coords.y, coords.z)
							Citizen.Wait(0)
						end

						SetVehRadioStation(vehicle, 'OFF')

						if cb ~= nil then
							cb(vehicle)
						end
					else
						ESX.ShowNotification('Error no vehicle returned')	
					end
				end)
			end,model,coords.x,coords.y,coords.z,heading, other)
		
	else
		ESX.ShowNotification('~r~Error: ~o~Vehicle model does not exist and was not loaded. Raise support ticket on forums if persists.')	
	end

end

--[[
ESX.Game.SpawnVehicle = function(modelName, coords, heading, cb)
	UG["SpawnVehicle"] = tonum(UG["SpawnVehicle"])
	local model = (type(modelName) == 'number' and modelName or GetHashKey(modelName))

	Citizen.CreateThread(function()
		RequestModel(model)

		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end

		local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, heading, true, false)
		local id      = NetworkGetNetworkIdFromEntity(vehicle)

		SetNetworkIdCanMigrate(id, true)
		SetEntityAsMissionEntity(vehicle, true, false)
		SetVehicleHasBeenOwnedByPlayer(vehicle, true)
		SetVehicleNeedsToBeHotwired(vehicle, false)
		SetModelAsNoLongerNeeded(model)

		RequestCollisionAtCoord(coords.x, coords.y, coords.z)

		while not HasCollisionLoadedAroundEntity(vehicle) do
			RequestCollisionAtCoord(coords.x, coords.y, coords.z)
			Citizen.Wait(0)
		end

		SetVehRadioStation(vehicle, 'OFF')

		if cb ~= nil then
			cb(vehicle)
		end
	end)
end--]]

ESX.Game.SpawnVehicleClient = function(modelName, coords, heading, cb)
	UG["SpawnVehicle"] = tonum(UG["SpawnVehicle"])
	local model = (type(modelName) == 'number' and modelName or GetHashKey(modelName))

	Citizen.CreateThread(function()
		RequestModel(model)

		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end

		local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, heading, true, false)
		local id      = NetworkGetNetworkIdFromEntity(vehicle)

		SetNetworkIdCanMigrate(id, true)
		SetEntityAsMissionEntity(vehicle, true, false)
		SetVehicleHasBeenOwnedByPlayer(vehicle, true)
		SetVehicleNeedsToBeHotwired(vehicle, false)
		SetModelAsNoLongerNeeded(model)

		RequestCollisionAtCoord(coords.x, coords.y, coords.z)

		while not HasCollisionLoadedAroundEntity(vehicle) do
			RequestCollisionAtCoord(coords.x, coords.y, coords.z)
			Citizen.Wait(0)
		end

		SetVehRadioStation(vehicle, 'OFF')

		if cb ~= nil then
			cb(vehicle)
		end
	end)
end

ESX.Game.SpawnLocalVehicle = function(modelName, coords, heading, cb)
	UG["SpawnLocalVehicle"] = tonum(UG["SpawnLocalVehicle"])
	local model = (type(modelName) == 'number' and modelName or GetHashKey(modelName))

	Citizen.CreateThread(function()
		RequestModel(model)

		while not HasModelLoaded(model) do
			Citizen.Wait(0)
		end

		local vehicle = CreateVehicle(model, coords.x, coords.y, coords.z, heading, false, false)

		SetEntityAsMissionEntity(vehicle, true, false)
		SetVehicleHasBeenOwnedByPlayer(vehicle, true)
		SetVehicleNeedsToBeHotwired(vehicle, false)
		SetModelAsNoLongerNeeded(model)

		RequestCollisionAtCoord(coords.x, coords.y, coords.z)

		while not HasCollisionLoadedAroundEntity(vehicle) do
			RequestCollisionAtCoord(coords.x, coords.y, coords.z)
			Citizen.Wait(0)
		end

		SetVehRadioStation(vehicle, 'OFF')

		if cb ~= nil then
			cb(vehicle)
		end
	end)
end

ESX.Game.IsVehicleEmpty = function(vehicle)
	UG["IsVehicleEmpty"] = tonum(UG["IsVehicleEmpty"])
	local passengers = GetVehicleNumberOfPassengers(vehicle)
	local driverSeatFree = IsVehicleSeatFree(vehicle, -1)

	return passengers == 0 and driverSeatFree
end

ESX.Game.GetObjects = function()
	UG["GetObjects"] = tonum(UG["GetObjects"])
	local objects = {}

	for object in EnumerateObjects() do
		table.insert(objects, object)
	end

	return objects
end

ESX.Game.GetClosestObject = function(filter, coords)
	UG["GetClosestObject"] = tonum(UG["GetClosestObject"])
	local objects         = ESX.Game.GetObjects()
	local closestDistance = -1
	local closestObject   = -1
	local filter          = filter
	local coords          = coords

	if type(filter) == 'string' then
		if filter ~= '' then
			filter = {filter}
		end
	end

	if coords == nil then
		local playerPed = PlayerPedId()
		coords          = GetEntityCoords(playerPed)
	end

	for i=1, #objects, 1 do
		local foundObject = false

		if filter == nil or (type(filter) == 'table' and #filter == 0) then
			foundObject = true
		else
			local objectModel = GetEntityModel(objects[i])

			for j=1, #filter, 1 do
				if objectModel == GetHashKey(filter[j]) then
					foundObject = true
				end
			end
		end

		if foundObject then
			local objectCoords = GetEntityCoords(objects[i])
			local distance     = #(objectCoords - vector3(coords.x, coords.y, coords.z))

			if closestDistance == -1 or closestDistance > distance then
				closestObject   = objects[i]
				closestDistance = distance
			end
		end
	end

	return closestObject, closestDistance
end

ESX.Game.GetClosestObjectNH = function(filter, coords)
	UG["GetClosestObject"] = tonum(UG["GetClosestObject"])
	local objects         = ESX.Game.GetObjects()
	local closestDistance = -1
	local closestObject   = -1
	local filter          = filter
	local coords          = coords

	if type(filter) == 'string' then
		if filter ~= '' then
			filter = {filter}
		end
	end

	if coords == nil then
		local playerPed = PlayerPedId()
		coords          = GetEntityCoords(playerPed)
	end

	for i=1, #objects, 1 do
		local foundObject = false

		if filter == nil or (type(filter) == 'table' and #filter == 0) then
			foundObject = true
		else
			local objectModel = GetEntityModel(objects[i])

			for j=1, #filter, 1 do
				if objectModel == filter[j] then
					foundObject = true
				end
			end
		end

		if foundObject then
			local objectCoords = GetEntityCoords(objects[i])
			local distance     = #(objectCoords - vector3(coords.x, coords.y, coords.z))

			if closestDistance == -1 or closestDistance > distance then
				closestObject   = objects[i]
				closestDistance = distance
			end
		end
	end

	return closestObject, closestDistance
end


ESX.ShowFloatingHelpNotification = function(msg, coords)
	AddTextEntry('esxFloatingHelpNotification', msg)
	SetFloatingHelpTextWorldPosition(1, coords)
	SetFloatingHelpTextStyle(1, 1, 2, -1, 3, 0)
	BeginTextCommandDisplayHelp('esxFloatingHelpNotification')
	EndTextCommandDisplayHelp(2, false, false, -1)
end


Citizen.CreateThread(function()
	while true do
		local players    = {}
		
		for i,player in ipairs(GetActivePlayers()) do
			table.insert(players, player)
			Wait(30)
		end

		teamgirls = players
		Wait(3000)
	end	
		
end)



ESX.Game.GetPlayers = function()
	UG["GetPlayers"] = tonum(UG["GetPlayers"])

	return teamgirls
end

ESX.Game.GetClosestPlayer = function(coords)
	UG["GetClosestPlayer"] = tonum(UG["GetClosestPlayer"])
	local players         = ESX.Game.GetPlayers()
	local closestDistance = -1
	local closestPlayer   = -1
	local coords          = coords
	local usePlayerPed    = false
	local playerPed       = PlayerPedId()
	local playerId        = PlayerId()

	if coords == nil then
		usePlayerPed = true
		coords       = GetEntityCoords(playerPed)
	end

	for i=1, #players, 1 do
		local target = GetPlayerPed(players[i])

		if not usePlayerPed or (usePlayerPed and players[i] ~= playerId) then
			local targetCoords = GetEntityCoords(target)
			local distance     = #(targetCoords - vector3(coords.x, coords.y, coords.z))

			if closestDistance == -1 or closestDistance > distance then
				closestPlayer   = players[i]
				closestDistance = distance
			end
		end

	end

	return closestPlayer, closestDistance
end



ESX.Game.GetPlayersInArea = function(coords, area)
	UG["GetPlayersInArea"] = tonum(UG["GetPlayersInArea"])
	local players       = ESX.Game.GetPlayers()
	local playersInArea = {}

	for i=1, #players, 1 do
		local target       = GetPlayerPed(players[i])
		local targetCoords = GetEntityCoords(target)
		local distance     = #(targetCoords - vector3(coords.x, coords.y, coords.z))

		if distance <= area then
			table.insert(playersInArea, players[i])
		end

	end

	return playersInArea
end

ESX.Game.GetVehicles = function()
	UG["GetVehicles"] = tonum(UG["GetVehicles"])
	local vehicles = {}

	for vehicle in EnumerateVehicles() do
		table.insert(vehicles, vehicle)
	end

	return vehicles
end

ESX.Game.GetClosestVehicle = function(coords)
	UG["GetClosestVehicle"] = tonum(UG["GetClosestVehicle"])
	local vehicles        = ESX.Game.GetVehicles()
	local closestDistance = -1
	local closestVehicle  = -1
	local coords          = coords

	if coords == nil then
		local playerPed = PlayerPedId()
		coords          = GetEntityCoords(playerPed)
	end

	for i=1, #vehicles, 1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance      = #(vehicleCoords - vector3(coords.x, coords.y, coords.z))

		if closestDistance == -1 or closestDistance > distance then
			closestVehicle  = vehicles[i]
			closestDistance = distance
		end

	end

	return closestVehicle, closestDistance
end

ESX.Game.GetVehiclesInArea = function(coords, area)
	UG["GetVehiclesInArea"] = tonum(UG["GetVehiclesInArea"])
	local vehicles       = ESX.Game.GetVehicles()
	local vehiclesInArea = {}

	for i=1, #vehicles, 1 do
		local vehicleCoords = GetEntityCoords(vehicles[i])
		local distance      = #(vehicleCoords - vector3(coords.x, coords.y, coords.z))

		if distance <= area then
			table.insert(vehiclesInArea, vehicles[i])
		end

	end

	return vehiclesInArea
end

ESX.Game.GetVehicleInDirection = function()
	UG["GetVehicleInDirection"] = tonum(UG["GetVehicleInDirection"])
	local playerPed    = PlayerPedId()
	local playerCoords = GetEntityCoords(playerPed)
	local inDirection  = GetOffsetFromEntityInWorldCoords(playerPed, 0.0, 5.0, 0.0)
	local rayHandle    = StartShapeTestRay(playerCoords, inDirection, 10, playerPed, 0)
	local numRayHandle, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(rayHandle)

	if hit == 1 and GetEntityType(entityHit) == 2 then
		return entityHit
	end

	return nil
end

ESX.Game.IsSpawnPointClear = function(coords, radius)
	UG["IsSpawnPointClear"] = tonum(UG["IsSpawnPointClear"])
	local vehicles = ESX.Game.GetVehiclesInArea(coords, radius)

	return #vehicles == 0
end

ESX.Game.GetPeds = function(ignoreList)
	UG["GetPeds"] = tonum(UG["GetPeds"])
	local ignoreList = ignoreList or {}
	local peds       = {}

	for ped in EnumeratePeds() do
		local found = false

		for j=1, #ignoreList, 1 do
			if ignoreList[j] == ped then
				found = true
			end
		end

		if not found then
			table.insert(peds, ped)
		end
	end

	return peds
end

ESX.Game.GetClosestPed = function(coords, ignoreList)
	UG["GetClosestPed"] = tonum(UG["GetClosestPed"])
	local ignoreList      = ignoreList or {}
	local peds            = ESX.Game.GetPeds(ignoreList)
	local closestDistance = -1
	local closestPed      = -1

	for i=1, #peds, 1 do
		local pedCoords = GetEntityCoords(peds[i])
		local distance  = #(pedCoords - vector3(coords.x, coords.y, coords.z))

		if closestDistance == -1 or closestDistance > distance then
			closestPed      = peds[i]
			closestDistance = distance
		end
	end

	return closestPed, closestDistance
end



local mycoords = nil
local mycoords_time = 0
ESX.Game.MyCoords = function()

	return myCurrentCoords

end

--[[
Citizen.CreateThread(function()
	while true do
		mycoords = GetEntityCoords(PlayerPedId())
		Wait(50)
	end
end)]]



ESX.Game.GetVehicleProperties = function(vehicle)
	UG["GetVehicleProperties"] = tonum(UG["GetVehicleProperties"])
	local color1, color2 = GetVehicleColours(vehicle)
	local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
	local extras = {}

	for id=0, 12 do
		if DoesExtraExist(vehicle, id) then
			local state = IsVehicleExtraTurnedOn(vehicle, id) == 1
			extras[tostring(id)] = state
		end
	end

	return {

		model             = GetEntityModel(vehicle),

		plate             = ESX.Math.Trim(GetVehicleNumberPlateText(vehicle)),
		plateIndex        = GetVehicleNumberPlateTextIndex(vehicle),

		health            = GetEntityHealth(vehicle),
		enginehealth 	  = GetVehicleEngineHealth(vehicle),
		bodyhealth        = GetVehicleBodyHealth(vehicle),
		dirtLevel         = GetVehicleDirtLevel(vehicle),
		
		fuelLevel         = ESX.Math.Round(GetVehicleFuelLevel(vehicle), 1),
		oilLevel         = GetVehicleOilLevel(vehicle),

		color1            = color1,
		color2            = color2,

		pearlescentColor  = pearlescentColor,
		wheelColor        = wheelColor,

		wheels            = GetVehicleWheelType(vehicle),
		windowTint        = GetVehicleWindowTint(vehicle),
	
		neonEnabled       = {
			IsVehicleNeonLightEnabled(vehicle, 0),
			IsVehicleNeonLightEnabled(vehicle, 1),
			IsVehicleNeonLightEnabled(vehicle, 2),
			IsVehicleNeonLightEnabled(vehicle, 3)
		},

		extras            = extras,

		neonColor         = table.pack(GetVehicleNeonLightsColour(vehicle)),
		tyreSmokeColor    = table.pack(GetVehicleTyreSmokeColor(vehicle)),

		modSpoilers       = GetVehicleMod(vehicle, 0),
		modFrontBumper    = GetVehicleMod(vehicle, 1),
		modRearBumper     = GetVehicleMod(vehicle, 2),
		modSideSkirt      = GetVehicleMod(vehicle, 3),
		modExhaust        = GetVehicleMod(vehicle, 4),
		modFrame          = GetVehicleMod(vehicle, 5),
		modGrille         = GetVehicleMod(vehicle, 6),
		modHood           = GetVehicleMod(vehicle, 7),
		modFender         = GetVehicleMod(vehicle, 8),
		modRightFender    = GetVehicleMod(vehicle, 9),
		modRoof           = GetVehicleMod(vehicle, 10),

		modEngine         = GetVehicleMod(vehicle, 11),
		modBrakes         = GetVehicleMod(vehicle, 12),
		modTransmission   = GetVehicleMod(vehicle, 13),
		modHorns          = GetVehicleMod(vehicle, 14),
		modSuspension     = GetVehicleMod(vehicle, 15),
		modArmor          = GetVehicleMod(vehicle, 16),

		modTurbo          = IsToggleModOn(vehicle, 18),
		modSmokeEnabled   = IsToggleModOn(vehicle, 20),
		modXenon          = IsToggleModOn(vehicle, 22),

		modFrontWheels    = GetVehicleMod(vehicle, 23),
		modBackWheels     = GetVehicleMod(vehicle, 24),

		modPlateHolder    = GetVehicleMod(vehicle, 25),
		modVanityPlate    = GetVehicleMod(vehicle, 26),
		modTrimA          = GetVehicleMod(vehicle, 27),
		modOrnaments      = GetVehicleMod(vehicle, 28),
		modDashboard      = GetVehicleMod(vehicle, 29),
		modDial           = GetVehicleMod(vehicle, 30),
		modDoorSpeaker    = GetVehicleMod(vehicle, 31),
		modSeats          = GetVehicleMod(vehicle, 32),
		modSteeringWheel  = GetVehicleMod(vehicle, 33),
		modShifterLeavers = GetVehicleMod(vehicle, 34),
		modAPlate         = GetVehicleMod(vehicle, 35),
		modSpeakers       = GetVehicleMod(vehicle, 36),
		modTrunk          = GetVehicleMod(vehicle, 37),
		modHydrolic       = GetVehicleMod(vehicle, 38),
		modEngineBlock    = GetVehicleMod(vehicle, 39),
		modAirFilter      = GetVehicleMod(vehicle, 40),
		modStruts         = GetVehicleMod(vehicle, 41),
		modArchCover      = GetVehicleMod(vehicle, 42),
		modAerials        = GetVehicleMod(vehicle, 43),
		modTrimB          = GetVehicleMod(vehicle, 44),
		modTank           = GetVehicleMod(vehicle, 45),
		modWindows        = GetVehicleMod(vehicle, 46),
		modLivery         = GetVehicleLivery(vehicle)
	}
end

ESX.Game.SetVehicleProperties = function(vehicle, props)

	UG["SetVehicleProperties"] = tonum(UG["SetVehicleProperties"])
	
	SetVehicleModKit(vehicle, 0)

	if props.plate ~= nil then
		SetVehicleNumberPlateText(vehicle, props.plate)
	end

	if props.plateIndex ~= nil then
		SetVehicleNumberPlateTextIndex(vehicle, props.plateIndex)
	end

	if props.health ~= nil then
		SetEntityHealth(vehicle, props.health)
	end

	if props.dirtLevel ~= nil then
		SetVehicleDirtLevel(vehicle, props.dirtLevel)
	end

	if props.color1 ~= nil then
		local color1, color2 = GetVehicleColours(vehicle)
		SetVehicleColours(vehicle, props.color1, color2)
	end

	if props.color2 ~= nil then
		local color1, color2 = GetVehicleColours(vehicle)
		SetVehicleColours(vehicle, color1, props.color2)
	end

	if props.pearlescentColor ~= nil then
		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
		SetVehicleExtraColours(vehicle, props.pearlescentColor, wheelColor)
	end

	if props.wheelColor ~= nil then
		local pearlescentColor, wheelColor = GetVehicleExtraColours(vehicle)
		SetVehicleExtraColours(vehicle, pearlescentColor, props.wheelColor)
	end

	if props.wheels ~= nil then
		SetVehicleWheelType(vehicle, props.wheels)
	end

	if props.windowTint ~= nil then
		SetVehicleWindowTint(vehicle, props.windowTint)
	end

	if props.neonEnabled ~= nil then
		SetVehicleNeonLightEnabled(vehicle, 0, props.neonEnabled[1])
		SetVehicleNeonLightEnabled(vehicle, 1, props.neonEnabled[2])
		SetVehicleNeonLightEnabled(vehicle, 2, props.neonEnabled[3])
		SetVehicleNeonLightEnabled(vehicle, 3, props.neonEnabled[4])
	end

	if props.extras ~= nil then
		for id,enabled in pairs(props.extras) do
			if enabled then
				SetVehicleExtra(vehicle, tonumber(id), 0)
			else
				SetVehicleExtra(vehicle, tonumber(id), 1)
			end
		end
	end

	if props.neonColor ~= nil then
		SetVehicleNeonLightsColour(vehicle, props.neonColor[1], props.neonColor[2], props.neonColor[3])
	end

	if props.modSmokeEnabled ~= nil then
		ToggleVehicleMod(vehicle, 20, true)
	end

	if props.tyreSmokeColor ~= nil then
		SetVehicleTyreSmokeColor(vehicle, props.tyreSmokeColor[1], props.tyreSmokeColor[2], props.tyreSmokeColor[3])
	end

	if props.modSpoilers ~= nil then
		SetVehicleMod(vehicle, 0, props.modSpoilers, false)
	end

	if props.modFrontBumper ~= nil then
		SetVehicleMod(vehicle, 1, props.modFrontBumper, false)
	end

	if props.modRearBumper ~= nil then
		SetVehicleMod(vehicle, 2, props.modRearBumper, false)
	end

	if props.modSideSkirt ~= nil then
		SetVehicleMod(vehicle, 3, props.modSideSkirt, false)
	end

	if props.modExhaust ~= nil then
		SetVehicleMod(vehicle, 4, props.modExhaust, false)
	end

	if props.modFrame ~= nil then
		SetVehicleMod(vehicle, 5, props.modFrame, false)
	end

	if props.modGrille ~= nil then
		SetVehicleMod(vehicle, 6, props.modGrille, false)
	end

	if props.modHood ~= nil then
		SetVehicleMod(vehicle, 7, props.modHood, false)
	end

	if props.modFender ~= nil then
		SetVehicleMod(vehicle, 8, props.modFender, false)
	end

	if props.modRightFender ~= nil then
		SetVehicleMod(vehicle, 9, props.modRightFender, false)
	end

	if props.modRoof ~= nil then
		SetVehicleMod(vehicle, 10, props.modRoof, false)
	end

	if props.modEngine ~= nil then
		SetVehicleMod(vehicle, 11, props.modEngine, false)
	end

	if props.modBrakes ~= nil then
		SetVehicleMod(vehicle, 12, props.modBrakes, false)
	end

	if props.modTransmission ~= nil then
		SetVehicleMod(vehicle, 13, props.modTransmission, false)
	end

	if props.modHorns ~= nil then
		SetVehicleMod(vehicle, 14, props.modHorns, false)
	end

	if props.modSuspension ~= nil then
		SetVehicleMod(vehicle, 15, props.modSuspension, false)
	end

	if props.modArmor ~= nil then
		SetVehicleMod(vehicle, 16, props.modArmor, false)
	end

	if props.modTurbo ~= nil then
		ToggleVehicleMod(vehicle,  18, props.modTurbo)
	end

	if props.modXenon ~= nil then
		ToggleVehicleMod(vehicle,  22, props.modXenon)
	end

	if props.modFrontWheels ~= nil then
		SetVehicleMod(vehicle, 23, props.modFrontWheels, false)
	end

	if props.modBackWheels ~= nil then
		SetVehicleMod(vehicle, 24, props.modBackWheels, false)
	end

	if props.modPlateHolder ~= nil then
		SetVehicleMod(vehicle, 25, props.modPlateHolder, false)
	end

	if props.modVanityPlate ~= nil then
		SetVehicleMod(vehicle, 26, props.modVanityPlate, false)
	end

	if props.modTrimA ~= nil then
		SetVehicleMod(vehicle, 27, props.modTrimA, false)
	end

	if props.modOrnaments ~= nil then
		SetVehicleMod(vehicle, 28, props.modOrnaments, false)
	end

	if props.modDashboard ~= nil then
		SetVehicleMod(vehicle, 29, props.modDashboard, false)
	end

	if props.modDial ~= nil then
		SetVehicleMod(vehicle, 30, props.modDial, false)
	end

	if props.modDoorSpeaker ~= nil then
		SetVehicleMod(vehicle, 31, props.modDoorSpeaker, false)
	end

	if props.modSeats ~= nil then
		SetVehicleMod(vehicle, 32, props.modSeats, false)
	end

	if props.modSteeringWheel ~= nil then
		SetVehicleMod(vehicle, 33, props.modSteeringWheel, false)
	end

	if props.modShifterLeavers ~= nil then
		SetVehicleMod(vehicle, 34, props.modShifterLeavers, false)
	end

	if props.modAPlate ~= nil then
		SetVehicleMod(vehicle, 35, props.modAPlate, false)
	end

	if props.modSpeakers ~= nil then
		SetVehicleMod(vehicle, 36, props.modSpeakers, false)
	end

	if props.modTrunk ~= nil then
		SetVehicleMod(vehicle, 37, props.modTrunk, false)
	end

	if props.modHydrolic ~= nil then
		SetVehicleMod(vehicle, 38, props.modHydrolic, false)
	end

	if props.modEngineBlock ~= nil then
		SetVehicleMod(vehicle, 39, props.modEngineBlock, false)
	end

	if props.modAirFilter ~= nil then
		SetVehicleMod(vehicle, 40, props.modAirFilter, false)
	end

	if props.modStruts ~= nil then
		SetVehicleMod(vehicle, 41, props.modStruts, false)
	end

	if props.modArchCover ~= nil then
		SetVehicleMod(vehicle, 42, props.modArchCover, false)
	end

	if props.modAerials ~= nil then
		SetVehicleMod(vehicle, 43, props.modAerials, false)
	end

	if props.modTrimB ~= nil then
		SetVehicleMod(vehicle, 44, props.modTrimB, false)
	end

	if props.modTank ~= nil then
		SetVehicleMod(vehicle, 45, props.modTank, false)
	end

	if props.modWindows ~= nil then
		SetVehicleMod(vehicle, 46, props.modWindows, false)
	end

	if props.modLivery ~= nil then
		SetVehicleMod(vehicle, 48, props.modLivery, false)
		SetVehicleLivery(vehicle, props.modLivery)
	end
	
	if props.enginehealth ~= nil then
		local e1 = tonumber(props.enginehealth) + 0.20
		SetVehicleEngineHealth(vehicle, e1)
	end
	
	if props.fuelLevel ~= nil then
		SetVehicleFuelLevel(vehicle, props.fuelLevel + 0.0)
	end
	
	if props.oilLevel ~= nil then
		SetVehicleOilLevel(vehicle, props.oilLevel)
	else
		SetVehicleOilLevel(vehicle, math.random(10.0,15.0))
	end

	if props.bodyhealth ~= nil then
		local e2 = tonumber(props.bodyhealth) + 0.20
		SetVehicleBodyHealth(vehicle, e2)
	end
end



Citizen.CreateThread(function()
  while true do
    pcall(function()
		myPed = PlayerPedId()
		GetVehiclePedIsInc = GetVehiclePedIsIn(myPed)
		myCurrentCoords = GetEntityCoords(myPed)
	end)
	Wait(500)
  end
end)




ESX.Game.GetVehiclePedIsIn = function()
	return GetVehiclePedIsInc
end

ESX.Game.GetMyPed = function()
	return myPed
end

ESX.Game.GetMyPedLocation = function()
	return myCurrentCoords
end


function DrawText3Ds(x,y,z, text)


    SetTextScale(0.32, 0.32)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 255)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 500
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
end

ESX.Game.Utils.DrawText3DBorder = function(coords, text, size)
	local onScreen, x, y = World3dToScreen2d(coords.x, coords.y, coords.z)
	local camCoords      = GetGameplayCamCoords()
	local dist           = #(camCoords - vector3(coords.x,coords.y,coords.z))
	local size           = size

	if size == nil then
		size = 1
	end

	local scale = (size / dist) * 2
	local fov   = (1 / GetGameplayCamFov()) * 100
	local scale = scale * fov

	if onScreen then
		SetTextScale(0.32, 0.32)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 255)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
		local factor = (string.len(text)) / 500
		DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 0, 0, 0, 80)
	end
end


ESX.Game.Utils.DrawText3D = function(coords, text, size)
	local onScreen, x, y = World3dToScreen2d(coords.x, coords.y, coords.z)
	local camCoords      = GetGameplayCamCoords()
	local dist           = #(camCoords - vector3(coords.x, coords.y, coords.z))
	local size           = size

	if size == nil then
		size = 1
	end

	local scale = (size / dist) * 2
	local fov   = (1 / GetGameplayCamFov()) * 100
	local scale = scale * fov

	if onScreen then
		SetTextScale(0.0 * scale, 0.55 * scale)
		SetTextFont(0)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 255)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(2, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry('STRING')
		SetTextCentre(1)

		AddTextComponentString(text)
		DrawText(x, y)
	end
end

ESX.ShowInventory = function()
	UG["ShowInventory"] = tonum(UG["ShowInventory"])
	local playerPed = PlayerPedId()
	local elements  = {}

	if ESX.PlayerData.money > 0 then
		local formattedMoney = _U('locale_currency', ESX.Math.GroupDigits(ESX.PlayerData.money))

		table.insert(elements, {
			label     = ('%s: <span style="color:green;">%s</span>'):format(_U('cash'), formattedMoney),
			count     = ESX.PlayerData.money,
			type      = 'item_money',
			value     = 'money',
			usable    = false,
			rare      = false,
			canRemove = true
		})
	end

	for i=1, #ESX.PlayerData.accounts, 1 do
		if ESX.PlayerData.accounts[i].money > 0 then
			local formattedMoney = _U('locale_currency', ESX.Math.GroupDigits(ESX.PlayerData.accounts[i].money))
			local canDrop = ESX.PlayerData.accounts[i].name ~= 'bank'

			table.insert(elements, {
				label     = ('%s: <span style="color:green;">%s</span>'):format(ESX.PlayerData.accounts[i].label, formattedMoney),
				count     = ESX.PlayerData.accounts[i].money,
				type      = 'item_account',
				value     = ESX.PlayerData.accounts[i].name,
				usable    = false,
				rare      = false,
				canRemove = canDrop
			})
		end
	end

	for i=1, #ESX.PlayerData.inventory, 1 do
		if ESX.PlayerData.inventory[i].count > 0 then
			table.insert(elements, {
				label     = ESX.PlayerData.inventory[i].label .. ' x' .. ESX.PlayerData.inventory[i].count,
				count     = ESX.PlayerData.inventory[i].count,
				type      = 'item_standard',
				value     = ESX.PlayerData.inventory[i].name,
				usable    = ESX.PlayerData.inventory[i].usable,
				rare      = ESX.PlayerData.inventory[i].rare,
				canRemove = ESX.PlayerData.inventory[i].canRemove
			})
		end
	end

	for i=1, #Config.Weapons, 1 do
		local weaponHash = GetHashKey(Config.Weapons[i].name)

		if HasPedGotWeapon(playerPed, weaponHash, false) and Config.Weapons[i].name ~= 'WEAPON_UNARMED' then
			local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
			if ammo > 8000 then  --LG
				SetPedAmmo(playerPed ,weaponHash, 1000)
				ammo = 1000
			end
			table.insert(elements, {
				label     = Config.Weapons[i].label .. ' [' .. ammo .. ']',
				count     = 1,
				type      = 'item_weapon',
				value     = Config.Weapons[i].name,
				ammo      = ammo,
				usable    = false,
				rare      = false,
				canRemove = true
			})
		end
	end

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'inventory',
	{
		title    = _U('inventory'),
		align    = 'top-right',
		elements = elements,
	}, function(data, menu)
		menu.close()

		local player, distance = ESX.Game.GetClosestPlayer()
		local elements = {}

		if data.current.usable then
			table.insert(elements, {label = _U('use'), action = 'use', type = data.current.type, value = data.current.value})
		end

		if data.current.canRemove then
			if player ~= -1 and distance <= 3.0 then
				table.insert(elements, {label = _U('give'), action = 'give', type = data.current.type, value = data.current.value})
			end

			table.insert(elements, {label = _U('remove'), action = 'remove', type = data.current.type, value = data.current.value})
		end

		if data.current.type == 'item_weapon' and data.current.ammo > 0 and player ~= -1 and distance <= 3.0 then
			--table.insert(elements, {label = _U('giveammo'), action = 'giveammo', type = data.current.type, value = data.current.value})
		end

		table.insert(elements, {label = _U('return'), action = 'return'})

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'inventory_item',
		{
			title    = data.current.label,
			align    = 'top-right',
			elements = elements,
		}, function(data1, menu1)

			local item = data1.current.value
			local type = data1.current.type
			local playerPed = PlayerPedId()

			if data1.current.action == 'give' then

				local players      = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)
				local foundPlayers = false
				local elements     = {}
			
				for i=1, #players, 1 do
					if players[i] ~= PlayerId() then
						foundPlayers = true

						table.insert(elements, {
							label = GetPlayerName(players[i]),
							player = players[i]
						})
					end
				end

				if not foundPlayers then
					ESX.ShowNotification(_U('players_nearby'))
					return
				end

				foundPlayers = false

				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'give_item_to',
				{
					title    = _U('give_to'),
					align    = 'top-right',
					elements = elements
				}, function(data2, menu2)

					local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)

					for i=1, #players, 1 do
						if players[i] ~= PlayerId() then
							
							if players[i] == data2.current.player then
								foundPlayers = true
								nearbyPlayer = players[i]
								break
							end
						end
					end

					if not foundPlayers then
						ESX.ShowNotification(_U('players_nearby'))
						menu2.close()
						return
					end

					if type == 'item_weapon' then

						local closestPed = GetPlayerPed(nearbyPlayer)
						local sourceAmmo = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(item))

						if IsPedSittingInAnyVehicle(closestPed) then
							ESX.ShowNotification(_U('in_vehicle'))
							return
						end

						TriggerServerEvent('adaeebd0-faf0-4285-bd54-895c9427c869', GetPlayerServerId(nearbyPlayer), type, item, sourceAmmo)
						menu2.close()
						menu1.close()

					else

						ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'inventory_item_count_give', {
							title = _U('amount')
						}, function(data3, menu3)
							local quantity = tonumber(data3.value)
							local closestPed = GetPlayerPed(nearbyPlayer)

							if IsPedSittingInAnyVehicle(closestPed) then
								ESX.ShowNotification(_U('in_vehicle'))
								return
							end

							if quantity ~= nil then
								TriggerServerEvent('adaeebd0-faf0-4285-bd54-895c9427c869', GetPlayerServerId(nearbyPlayer), type, item, quantity)

								menu3.close()
								menu2.close()
								menu1.close()
							else
								ESX.ShowNotification(_U('amount_invalid'))
							end

						end, function(data3, menu3)
							menu3.close()
						end)
					end
				end, function(data2, menu2)
					menu2.close()
				end) -- give end

			elseif data1.current.action == 'remove' then

				if IsPedSittingInAnyVehicle(playerPed) then
					return
				end

				if type == 'item_weapon' then

					TriggerServerEvent('f79a9b3c-e921-438e-8a6f-beb2f22242fa', type, item)
					menu1.close()

				else -- type: item_standard

					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'inventory_item_count_remove', {
						title = _U('amount')
					}, function(data2, menu2)
						local quantity = tonumber(data2.value)

						if quantity == nil then
							ESX.ShowNotification(_U('amount_invalid'))
						else
							TriggerServerEvent('f79a9b3c-e921-438e-8a6f-beb2f22242fa', type, item, quantity)
							menu2.close()
							menu1.close()
						end

					end, function(data2, menu2)
						menu2.close()
					end)
				end

			elseif data1.current.action == 'use' then
				TriggerServerEvent('733fadfc-add0-42b7-b234-b0dfc85bc348', item)

			elseif data1.current.action == 'return' then
				ESX.UI.Menu.CloseAll()
				ESX.ShowInventory()
			elseif data1.current.action == 'giveammo' then
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				local closestPed = GetPlayerPed(closestPlayer)
				local pedAmmo = GetAmmoInPedWeapon(playerPed, GetHashKey(item))

				if IsPedSittingInAnyVehicle(closestPed) then
					ESX.ShowNotification(_U('in_vehicle'))
					return
				end

				if closestPlayer ~= -1 and closestDistance < 3.0 then
					if pedAmmo > 0 then

						ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'inventory_item_count_give', {
							title = _U('amountammo')
						}, function(data2, menu2)

							local quantity = tonumber(data2.value)

							if quantity ~= nil then
								if quantity <= pedAmmo and quantity >= 0 then

									local finalAmmoSource = math.floor(pedAmmo - quantity)
									SetPedAmmo(playerPed, item, finalAmmoSource)
									AddAmmoToPed(closestPed, item, quantity)

									ESX.ShowNotification(_U('gave_ammo', quantity, GetPlayerName(closestPlayer)))
									-- todo notify target that he received ammo
									menu2.close()
									menu1.close()
								else
									ESX.ShowNotification(_U('noammo'))
								end
							else
								ESX.ShowNotification(_U('amount_invalid'))
							end

						end, function(data2, menu2)
							menu2.close()
						end)
					else
						ESX.ShowNotification(_U('noammo'))
					end
				else
					ESX.ShowNotification(_U('players_nearby'))
				end
			end

		end, function(data1, menu1)
			ESX.UI.Menu.CloseAll()
			ESX.ShowInventory()
		end)

	end, function(data, menu)
		menu.close()
	end)
end

RegisterNetEvent('7e1000c5-31d4-4ddf-bf31-c0240ae8a8a1')
AddEventHandler('7e1000c5-31d4-4ddf-bf31-c0240ae8a8a1', function(requestId, ...)
	UG["serverCallback"] = tonum(UG["serverCallback"])
	ESX.ServerCallbacks[requestId](...)
	ESX.ServerCallbacks[requestId] = nil
end)

RegisterNetEvent('2c4f07a6-bf05-4b02-ba86-fd4472391cbd')
AddEventHandler('2c4f07a6-bf05-4b02-ba86-fd4472391cbd', function(msg, flash, saveToBrief, hudColorIndex)
	ESX.ShowNotification(msg, flash, saveToBrief, hudColorIndex)
end)

RegisterNetEvent('ea8cfa87-e25d-4e00-8f69-251491f198af')
AddEventHandler('ea8cfa87-e25d-4e00-8f69-251491f198af', function(sender, subject, msg, textureDict, iconType, flash, saveToBrief, hudColorIndex)
	ESX.ShowAdvancedNotification(sender, subject, msg, textureDict, iconType, flash, saveToBrief, hudColorIndex)
end)


RegisterNetEvent('ae7a51c5-190c-4f66-9d3f-28ad9815553d')
AddEventHandler('ae7a51c5-190c-4f66-9d3f-28ad9815553d', function(sender, subject, msg, libraryDict, textureDict, iconType, flash, saveToBrief, hudColorIndex)
	ESX.ShowAdvancedNotification2(sender, subject, msg, libraryDict, textureDict, iconType, flash, saveToBrief, hudColorIndex)
end)

RegisterNetEvent('26f09eaa-4528-41ae-81e5-1c03306f0149')
AddEventHandler('26f09eaa-4528-41ae-81e5-1c03306f0149', function(msg, thisFrame, beep, duration)
	ESX.ShowHelpNotification(msg, thisFrame, beep, duration)
end)





-- SetTimeout
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(3)
		local currTime = GetGameTimer()

		for i=1, #ESX.TimeoutCallbacks, 1 do

			if ESX.TimeoutCallbacks[i] ~= nil then
				if currTime >= ESX.TimeoutCallbacks[i].time then
					ESX.TimeoutCallbacks[i].cb()
					ESX.TimeoutCallbacks[i] = nil
				end
			end

		end

	end
end)

exports("ESXGetPlayerData", ESX.GetPlayerData)
exports("RemovePlayerAccessToFrequencies", ESX.SetPlayerData)
exports("ESXShowNotification", ESX.ShowNotification)
exports("ESXShowAdvancedNotification", ESX.ShowAdvancedNotification)
exports("ESXGameGetPedMugshot", ESX.Game.GetPedMugshot)
exports("ESXGameTeleport", ESX.Game.Teleport)
exports("ESXGameSpawnObject", ESX.Game.SpawnObject)
exports("ESXGameSpawnLocalObject", ESX.Game.SpawnLocalObject)
exports("ESXGameDeleteObject", ESX.Game.DeleteObject)
exports("ESXGameSpawnVehicle", ESX.Game.SpawnVehicle)
exports("ESXGameSpawnLocalVehicle", ESX.Game.SpawnLocalVehicle)
exports("ESXGameIsVehicleEmpty", ESX.Game.IsVehicleEmpty)
exports("ESXGameGetClosestObject", ESX.Game.GetClosestObject)
exports("ESXIsPlayerLoaded", ESX.IsPlayerLoaded)
exports("ESXGameGetPlayersInArea", ESX.Game.GetPlayersInArea)
exports("ESXGameGetClosestPlayer", ESX.Game.GetClosestPlayer)
exports("ESXGameGetVehicles", ESX.Game.GetVehicles)
exports("ESXGameGetClosestVehicle", ESX.Game.GetClosestVehicle)
exports("ESXGameGetVehicleInDirection", ESX.Game.GetVehicleInDirection)
exports("ESXGameGetPeds", ESX.Game.GetPeds)
exports("ESXGameIsSpawnPointClear", ESX.Game.IsSpawnPointClear)
exports("ESXGameGetClosestPed", ESX.Game.GetClosestPed)
exports("ESXGameGetVehicleProperties", ESX.Game.GetVehicleProperties)
exports("ESXGameSetVehicleProperties", ESX.Game.SetVehicleProperties)

	
