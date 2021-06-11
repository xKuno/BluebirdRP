local debug = true
local group
local isAuthorizedToOpenPanel = false
local isInUse = false
local isSpectatingAZone = false
local points = {}
local Zones = {}

Citizen.CreateThread(function()
	-- not being stuck on relaod
	TriggerServerEvent('a4c798c2-9a8b-4804-bbd7-b8a6671ab198')

	if debug then SetNuiFocus(false, false) end
		
	while true do
		Citizen.Wait(15)

		if IsControlJustPressed(0, Config.CONTROL_TO_OPEN_PANEL) then

			if isAuthorizedToOpenPanel then
				SetNuiFocus(true, true)
				SendNUIMessage({openMenu = true, isInUse = isInUse, points = points, zones = Zones})
			end

		elseif IsControlJustPressed(0, Config.CONTROL_TO_ADD_POINT) and isInUse then

			local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
			TriggerEvent('bd36582d-aba4-4ca4-9add-efbda978c3f9', "Point added: ".. "x = "..tostring(math.ceil(x)) .. " y = " .. tostring(math.ceil(y)) .. " z = " .. tostring(math.ceil(z)), true)
			table.insert(points, {x = x, y = y, z = z})
			Wait(1000)

		elseif IsControlJustPressed(0, Config.CONTROL_TO_REMOVE_LAST_POINT) and isInUse then

			TriggerEvent('bd36582d-aba4-4ca4-9add-efbda978c3f9', "Removed the last point", true)
			table.remove(points, #points)
			Wait(1000)

		end

		if #points > 0 then
			for i = 1, #points do
				DrawMarker(0, points[i].x, points[i].y, points[i].z, 0, 0, 0, 0, 0, 0, 0.1, 0.1, 3.0, 46, 89, 227, 230, 0, 0, 0,0)
				draw3DText(points[i].x, points[i].y, points[i].z + 2.01 , "Point ~r~" .. i, 1, 0.5, 0.5)
			end
		end

		if #points > 1 then
			for i = 1, #points do
				if i ~= #points then
					DrawLine(points[i].x, points[i].y, points[i].z, points[i+1].x, points[i+1].y, points[i+1].z, 244, 34, 35, 230)
				else
					DrawLine(points[i].x, points[i].y, points[i].z, points[1].x, points[1].y, points[1].z, 244, 34, 35, 230)
				end
			end
		end

		if isInUse then
			HelpPromt("Add a point : ~INPUT_CELLPHONE_CAMERA_FOCUS_LOCK~ \nRemove last point: ~INPUT_REPLAY_SHOWHOTKEY~")
		end 
	end
end)

RegisterNetEvent('5d091ebb-96ef-43f4-9c0c-e6af54b33015')
AddEventHandler('5d091ebb-96ef-43f4-9c0c-e6af54b33015', function(zones, _isAuthorizedToOpenPanel)
	isAuthorizedToOpenPanel = _isAuthorizedToOpenPanel
	Zones = zones

	if (isAuthorizedToOpenPanel) then
		SendNUIMessage({refreshZones = true, zones = Zones})
	end
end)

RegisterNUICallback('close', function(data, cb)
	SetNuiFocus(false, false)
end)

RegisterNUICallback('stop', function(data, cb)
    SetNuiFocus(false, false)
    isInUse = false
    points = {}
end)

RegisterNUICallback('showZone', function(data, cb)
	if isInUse then
		return TriggerEvent('bd36582d-aba4-4ca4-9add-efbda978c3f9', "Error: you can't see a zone while creating one", 0)
	end

	points = data.points
	isSpectatingAZone = true
	SendNUIMessage({refreshState = true, isSpectatingAZone = isSpectatingAZone, zoneId = data.id})
end)

RegisterNUICallback('unshowZone', function(data, cb)
	points = {}
	isSpectatingAZone = false
	SendNUIMessage({refreshState = true, isSpectatingAZone = isSpectatingAZone})
end)

RegisterNUICallback('error', function(data, cb)
	TriggerEvent('bd36582d-aba4-4ca4-9add-efbda978c3f9', "Error: ".. data.message, 0)
end)

RegisterNUICallback('checkSave', function(data, cb)
    SetNuiFocus(false, false)
    if (data.error) then
        TriggerEvent('bd36582d-aba4-4ca4-9add-efbda978c3f9', "Error: You need to have 3 points or more to save.", 0)
    else
        SendNUIMessage({openPrompt = true, isInUse = isInUse, points = points})
        SetNuiFocus(true, true)
    end
end)

RegisterNUICallback('save', function(data, cb)
    isInUse = false
    TriggerServerEvent('fd532c63-f0d9-40fe-9bbe-27ac9c2bf698', points, data.name, data.cat)
    points = {}
end)

RegisterNUICallback('create', function(data, cb)
    SetNuiFocus(false, false)
    if (isInUse) then
        TriggerEvent('bd36582d-aba4-4ca4-9add-efbda978c3f9', "already in use", 0)
		else
				isSpectatingAZone = false
				isInUse = true
				points = {}
    end
end)

RegisterNUICallback('tp', function(data, cb)
    SetNuiFocus(false, false)
    TeleportPlayerToCoords(data.x, data.y, data.z)
end)

RegisterNUICallback('delete', function(data, cb)
    SetNuiFocus(false, false)
    TriggerServerEvent('2cfc1e49-248c-4b4e-ba4e-e44fda337dd6', data.id)
end)

RegisterNetEvent('bd36582d-aba4-4ca4-9add-efbda978c3f9')
AddEventHandler('bd36582d-aba4-4ca4-9add-efbda978c3f9', function(msg, state)
	if state then
		message = "~g~"..msg
	else
		message = "~r~"..msg
	end
	SetNotificationTextEntry("STRING")
    AddTextComponentString(message)
    DrawNotification(false, false)
end)

function draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

    local scale = (1/dist)*20
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    SetTextScale(scaleX*scale, scaleY*scale)
    SetTextFont(fontId)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 150)
    SetTextDropshadow(0, 0, 0, 0, 255)
    SetTextEdge(2, 0, 0, 0, 150)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(textInput)
    SetDrawOrigin(x,y,z+2, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end

function TeleportPlayerToCoords(x, y, z)
	local myPly = GetPlayerPed(-1)
	SetEntityCoords(myPly, tonumber(x), tonumber(y), tonumber(z), 1, 0, 0, 1)
end

function HelpPromt(text)

	SetTextComponentFormat("STRING")
	AddTextComponentString(text)
	DisplayHelpTextFromStringLabel(0, false, false, -1)

end

-- API
local lastInCoords = nil

AddEventHandler('12243cba-2df3-4163-af28-b56894179300', function(zone)
	TriggerEvent('6385f5f9-05cb-4d17-babc-2ecd2f756b33', zone, function(isIn)
        local found = FindZone(zone)
        if not(found) then return end
		if isIn then
			lastInCoords = GetEntityCoords(GetPlayerPed(-1), true)
		else
            TpPlayer(Zones[found].center)
            lastInCoords = GetEntityCoords(GetPlayerPed(-1), true)
		end
	end)
end)

function TpPlayer(coords)
	SetEntityCoords(GetPlayerPed(-1), coords.x, coords.y, coords.z, 0.0, 0.0, 0.0, 0)
end

AddEventHandler('c0a97c55-2185-4952-b97a-c859dcda64ab', function(zone)
	local found = FindZone(zone)
	if not found or not lastInCoords then
		return
	else
		local plyCoords = GetEntityCoords(GetPlayerPed(-1), true)
		if GetDistanceBetweenCoords(plyCoords, tonumber(Zones[found].center.x), tonumber(Zones[found].center.y), 1.01, false) < tonumber(Zones[found].max_length) then
			local n = windPnPoly(Zones[found].points, plyCoords)
			if n == 0 then
				TpPlayer(lastInCoords)
			else
				lastInCoords = plyCoords -- he's not in and not so far
			end
		else
			TpPlayer(lastInCoords) -- he's not in and prob far
		end
	end
end)

AddEventHandler('6e5c14a8-4746-49b4-9a2b-ba22fcbcb146', function(zone, cb)
	local found = FindZone(zone)
	if not found then
		cb(nil)
	else
		cb(Zones[found].center)
	end
end)

AddEventHandler('6385f5f9-05cb-4d17-babc-2ecd2f756b33', function(zone, cb)
	local found = FindZone(zone)
	if not found then
		cb(nil)
	else
		local plyCoords = GetEntityCoords(GetPlayerPed(-1), true)
		if GetDistanceBetweenCoords(plyCoords, tonumber(Zones[found].center.x), tonumber(Zones[found].center.y), 1.01, false) < tonumber(Zones[found].max_length) then
			local n = windPnPoly(Zones[found].points, plyCoords)
			if n ~= 0 then
				cb(true)
			else
				cb(false)
			end
		else
			cb(false)
		end
	end
end)

AddEventHandler('083f8f84-e90e-4c59-a8e4-5301e8c47f90', function(zone, cat, cb)
	local found = FindZoneInCat(zone, cat)
	if not(found) then
		cb(nil)
	else
		local plyCoords = GetEntityCoords(GetPlayerPed(-1), true)
		if GetDistanceBetweenCoords(plyCoords, tonumber(Zones[found].center.x), tonumber(Zones[found].center.y), 1.01, false) < tonumber(Zones[found].max_length) then
			local n = windPnPoly(Zones[found].points, plyCoords)
			if n ~= 0 then
				cb(true)
			else
				cb(false)
			end
		else
			cb(false)
		end
	end
end)

function isPlayerInCatZone (zone, cat)
	local found = FindZoneInCats(zone, cat)
	if #found == 0 then
		return nil
	else
		local plyCoords = GetEntityCoords(GetPlayerPed(-1), true)
		local result = false
		for i,v in ipairs(found) do
			if GetDistanceBetweenCoords(plyCoords, tonumber(Zones[v].center.x), tonumber(Zones[v].center.y), 1.01, false) < tonumber(Zones[v].max_length) then
				local n = windPnPoly(Zones[v].points, plyCoords)
				if n ~= 0 then
					return true
				end
			end
		end
		return false
	end
end

AddEventHandler('cdd89e3c-255b-4208-9cd5-5b2307e4ea4c', function(cb)
	local plyCoords = GetEntityCoords(GetPlayerPed(-1), true)
	local toReturn = {}
	for i,v in ipairs(Zones) do
		if GetDistanceBetweenCoords(plyCoords, tonumber(v.center.x), tonumber(v.center.y), 1.01, false) < tonumber(v.max_length) then
			local n = windPnPoly(v.points, plyCoords)
			if n ~= 0 then
				table.insert(toReturn, v)
			end
		end
	end
	cb(toReturn)
end)

AddEventHandler('f581c57d-8ac6-483a-a891-19fb4ed7aa71', function(cat, cb)
	local zonesToTest = GetZonesInCat(cat)
	local plyCoords = GetEntityCoords(GetPlayerPed(-1), true)

	for i,v in ipairs(zonesToTest) do
		if GetDistanceBetweenCoords(plyCoords, tonumber(v.center.x), tonumber(v.center.y), 1.01, false) < tonumber(v.max_length) then
			local n = windPnPoly(v.points, plyCoords)
			if n ~= 0 then
				cb(true)
				return
			end
		end
	end
	cb(false)
end)

AddEventHandler('6e31deec-3bf2-40ba-b2d2-4032e4db7551', function(xr, yr, zone, cb)
	local found = FindZone(zone)
	if not found then
		cb(nil)
	else
		local flag = { x = tonumber(xr), y = tonumber(yr)}
		if GetDistanceBetweenCoords(xr, yr, 1.01, tonumber(Zones[found].center.x), tonumber(Zones[found].center.y), 1.01, false) < tonumber(Zones[found].max_length) then
			local n = windPnPoly(Zones[found].points, flag)
			if n ~= 0 then
				cb(true)
			else
				cb(false)
			end
		else
			cb(false)
		end
	end
end)

function windPnPoly(tablePoints, flag)
	if tostring(type(flag)) == table then
		py = flag.y
		px = flag.x
	else
		px, py, pz = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
	end
	wn = 0
	table.insert(tablePoints, tablePoints[1])
	for i=1, #tablePoints do
		if i == #tablePoints then
			break
		end
		if tonumber(tablePoints[i].y) <= py then
			if tonumber(tablePoints[i+1].y) > py then
				if IsLeft(tablePoints[i], tablePoints[i+1], flag) > 0 then
					wn = wn + 1
				end
			end
		else
			if tonumber(tablePoints[i+1].y) <= py then
				if IsLeft(tablePoints[i], tablePoints[i+1], flag) < 0 then
					wn = wn - 1
				end
			end
		end
	end
	return wn
end

function IsLeft(p1s, p2s, flag)
	p1 = p1s
	p2 = p2s
	if tostring(type(flag)) == "table" then
		p = flag
	else
		p = GetEntityCoords(GetPlayerPed(-1), true)
	end
	return ( ((p1.x - p.x) * (p2.y - p.y))
            - ((p2.x -  p.x) * (p1.y - p.y)) )
end

function FindZone(zone)
	for i = 1, #Zones do
		if Zones[i].name == zone then
			return i
		end
	end
	return false
end

function FindZoneInCat(zone, cat)
	for i = 1, #Zones do
		if Zones[i].name == zone and Zones[i].cat == cat then
			return i
		end
	end
	return false
end


function FindZoneInCats(zone, cat)
	local tblist =  {}
	for i = 1, #Zones do
		if Zones[i].name == zone and Zones[i].cat == cat then

			table.insert(tblist,i)
		end
	end
	return tblist
end
function GetZonesInCat(cat)
	local toBeReturned = {}
	for i = 1, #Zones do
		if Zones[i].cat == cat then
			table.insert(toBeReturned, Zones[i])
		end
	end
	return toBeReturned
end