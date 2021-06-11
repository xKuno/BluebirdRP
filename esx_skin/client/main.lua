ESX = nil
local lastSkin, playerLoaded, cam, isCameraActive
local firstSpawn, zoomOffset, camOffset, heading, skinLoaded = true, 0.0, 0.0, 90.0, false

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

function OpenMenu(submitCb, cancelCb, restrict)
    local playerPed = PlayerPedId()

    TriggerEvent('d3bdbe20-bf7d-4df2-9ef6-9026a86a6e87', function(skin) lastSkin = skin end)
    TriggerEvent('82d7cc6a-bdf5-4cca-ba51-a6dd7f586e18', function(components, maxVals)
        local elements = {}
        local _components = {}

        -- Restrict menu
        if restrict == nil then
            for i=1, #components, 1 do
                _components[i] = components[i]
            end
        else
            for i=1, #components, 1 do
                local found = false

                for j=1, #restrict, 1 do
                    if components[i].name == restrict[j] then
                        found = true
                    end
                end

                if found then
                    table.insert(_components, components[i])
                end
            end
        end
        -- Insert elements
        for i=1, #_components, 1 do
            local value = _components[i].value
            local componentId = _components[i].componentId

            if componentId == 0 then
                value = GetPedPropIndex(playerPed, _components[i].componentId)
            end

            local data = {
                label = _components[i].label,
                name = _components[i].name,
                value = value,
                min = _components[i].min,
                textureof = _components[i].textureof,
                zoomOffset= _components[i].zoomOffset,
                camOffset = _components[i].camOffset,
                type = 'slider'
            }

            for k,v in pairs(maxVals) do
                if k == _components[i].name then
                    data.max = v
                    break
                end
            end

            table.insert(elements, data)
        end

        CreateSkinCam()
        zoomOffset = _components[1].zoomOffset
        camOffset = _components[1].camOffset

        ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'skin', {
            title = _U('skin_menu'),
            align = 'top-right',
            elements = elements
        }, function(data, menu)
            TriggerEvent('d3bdbe20-bf7d-4df2-9ef6-9026a86a6e87', function(skin) lastSkin = skin end)

            submitCb(data, menu)
            DeleteSkinCam()
        end, function(data, menu)
            menu.close()
            DeleteSkinCam()
            TriggerEvent('56a2ee13-8a49-4ad3-a298-1854493c98ee', lastSkin)

            if cancelCb ~= nil then
                cancelCb(data, menu)
            end
        end, function(data, menu)
            local skin, components, maxVals

            TriggerEvent('d3bdbe20-bf7d-4df2-9ef6-9026a86a6e87', function(getSkin) skin = getSkin end)

            zoomOffset = data.current.zoomOffset
            camOffset = data.current.camOffset

            if skin[data.current.name] ~= data.current.value then
                -- Change skin element
                TriggerEvent('7102d3ea-6538-4a45-9353-2b78883e5b2e', data.current.name, data.current.value)

                -- Update max values
                TriggerEvent('82d7cc6a-bdf5-4cca-ba51-a6dd7f586e18', function(comp, max)
                    components, maxVals = comp, max
                end)

                local newData = {}

                for i=1, #elements, 1 do
                    newData = {}
                    newData.max = maxVals[elements[i].name]

                    if elements[i].textureof ~= nil and data.current.name == elements[i].textureof then
                        newData.value = 0
                    end

                    menu.update({name = elements[i].name}, newData)
                end

                menu.refresh()
            end
        end, function(data, menu)
            DeleteSkinCam()
        end)
    end)
end

function CreateSkinCam()
    if not DoesCamExist(cam) then
        cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
    end

    local playerPed = PlayerPedId()

    SetCamActive(cam, true)
    RenderScriptCams(true, true, 500, true, true)

    isCameraActive = true
    SetCamRot(cam, 0.0, 0.0, 270.0, true)
    SetEntityHeading(playerPed, 0.0)
end

function DeleteSkinCam()
    isCameraActive = false
    SetCamActive(cam, false)
    RenderScriptCams(false, true, 500, true, true)
    cam = nil
end

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)

        if not skinLoaded and isCameraActive then
            DisableControlAction(2, 30, true)
            DisableControlAction(2, 31, true)
            DisableControlAction(2, 32, true)
            DisableControlAction(2, 33, true)
            DisableControlAction(2, 34, true)
            DisableControlAction(2, 35, true)
            DisableControlAction(0, 25, true) -- Input Aim
            DisableControlAction(0, 24, true) -- Input Attack

            local playerPed = PlayerPedId()
            local coords    = GetEntityCoords(playerPed)

            local angle = heading * math.pi / 180.0
            local theta = {
                x = math.cos(angle),
                y = math.sin(angle)
            }

            local pos = {
                x = coords.x + (zoomOffset * theta.x),
                y = coords.y + (zoomOffset * theta.y)
            }

            local angleToLook = heading - 140.0
            if angleToLook > 360 then
                angleToLook = angleToLook - 360
            elseif angleToLook < 0 then
                angleToLook = angleToLook + 360
            end

            angleToLook = angleToLook * math.pi / 180.0
            local thetaToLook = {
                x = math.cos(angleToLook),
                y = math.sin(angleToLook)
            }

            local posToLook = {
                x = coords.x + (zoomOffset * thetaToLook.x),
                y = coords.y + (zoomOffset * thetaToLook.y)
            }

            SetCamCoord(cam, pos.x, pos.y, coords.z + camOffset)
            PointCamAtCoord(cam, posToLook.x, posToLook.y, coords.z + camOffset)

            ESX.ShowHelpNotification(_U('use_rotate_view'))
        else
            Citizen.Wait(500)
        end
    end
end)

Citizen.CreateThread(function()
    local angle = 90

    while true do
        Citizen.Wait(0)

        if isCameraActive then
            if IsControlPressed(0, 108) then
                angle = angle - 1
            elseif IsControlPressed(0, 109) then
                angle = angle + 1
            end

            if angle > 360 then
                angle = angle - 360
            elseif angle < 0 then
                angle = angle + 360
            end

            heading = angle + 0.0
        else
            Citizen.Wait(500)
        end
    end
end)

function OpenSaveableMenu(submitCb, cancelCb, restrict)
    TriggerEvent('d3bdbe20-bf7d-4df2-9ef6-9026a86a6e87', function(skin) lastSkin = skin end)

    OpenMenu(function(data, menu)
        menu.close()
        DeleteSkinCam()

        TriggerEvent('d3bdbe20-bf7d-4df2-9ef6-9026a86a6e87', function(skin)
            TriggerServerEvent('ad5940f4-3fe4-4fc5-9070-284adcd9246d', skin)

            if submitCb ~= nil then
                submitCb(data, menu)
            end
        end)

    end, cancelCb, restrict)
end

AddEventHandler('67d7b049-9a6f-4b10-9c9d-3828857b5ff4', function()
    Citizen.CreateThread(function()
        while not playerLoaded do
            Citizen.Wait(100)
        end

        if firstSpawn then
            ESX.TriggerServerCallback('4568d939-3661-4833-ae6a-378432ac6ff1', function(skin, jobSkin)
                if skin == nil then
                    TriggerEvent('56a2ee13-8a49-4ad3-a298-1854493c98ee', {sex = 0}, OpenSaveableMenu)
                else
                    TriggerEvent('56a2ee13-8a49-4ad3-a298-1854493c98ee', skin)
                end
            end)

            firstSpawn = false
        end
    end)
end)
AddEventHandler('67d7b049-9a6f-4b10-9c9d-3828857b5ff4', function()

end)


AddEventHandler('760d627f-5981-46ae-8e30-495f73fd6f81', function()
    firstSpawn = true
    skinLoaded = false
end)

AddEventHandler('0a7b666b-11ca-4990-927e-ad9ab6de7e8b', function()
    Citizen.CreateThread(function()
        while not playerLoaded do
            Citizen.Wait(100)
        end

        if firstSpawn then
            ESX.TriggerServerCallback('4568d939-3661-4833-ae6a-378432ac6ff1', function(skin, jobSkin)
                if skin == nil then
                    TriggerEvent('56a2ee13-8a49-4ad3-a298-1854493c98ee', {sex = 0}, OpenSaveableMenu)
                    Citizen.Wait(100)
                    skinLoaded = true
                else
                    TriggerEvent('56a2ee13-8a49-4ad3-a298-1854493c98ee', skin)
                    Citizen.Wait(100)
                    skinLoaded = true
                end
            end)

            firstSpawn = false
        end
    end)
end)

RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(xPlayer)
		playerLoaded = true
        Citizen.CreateThread(function()
		
        while not playerLoaded do
            Citizen.Wait(100)
        end

        if firstSpawn then
            ESX.TriggerServerCallback('4568d939-3661-4833-ae6a-378432ac6ff1', function(skin, jobSkin)
				print('loaded skins')
                if skin == nil then
                    TriggerEvent('56a2ee13-8a49-4ad3-a298-1854493c98ee', {sex = 0}, OpenSaveableMenu)
                else
                    TriggerEvent('56a2ee13-8a49-4ad3-a298-1854493c98ee', skin)
                end
            end)

            firstSpawn = false
        end
    end)
end)

AddEventHandler('b48bfbfa-98e4-42b4-959e-13e020bef915', function(cb) cb(lastSkin) end)
AddEventHandler('2b9879b9-88c4-4a82-afd1-2308ebf69ffe', function(skin) lastSkin = skin end)

RegisterNetEvent('0089702d-ba66-45e0-9034-249cee76a31c')
AddEventHandler('0089702d-ba66-45e0-9034-249cee76a31c', function(submitCb, cancelCb)
    OpenMenu(submitCb, cancelCb, nil)
end)

RegisterNetEvent('4fba22a5-88ee-4097-9d32-aab6667947be')
AddEventHandler('4fba22a5-88ee-4097-9d32-aab6667947be', function(submitCb, cancelCb, restrict)
    OpenMenu(submitCb, cancelCb, restrict)
end)

RegisterNetEvent('b0555579-413c-496a-a29e-265ca26568bc')
AddEventHandler('b0555579-413c-496a-a29e-265ca26568bc', function(submitCb, cancelCb)
    OpenSaveableMenu(submitCb, cancelCb, nil)
end)

RegisterNetEvent('b1c761d1-8f7f-47af-b11a-862463e23a19')
AddEventHandler('b1c761d1-8f7f-47af-b11a-862463e23a19', function(submitCb, cancelCb, restrict)
    OpenSaveableMenu(submitCb, cancelCb, restrict)
end)

RegisterNetEvent('c6a5ab70-40a6-4474-b158-476ce652f48f')
AddEventHandler('c6a5ab70-40a6-4474-b158-476ce652f48f', function()
    TriggerEvent('d3bdbe20-bf7d-4df2-9ef6-9026a86a6e87', function(skin)
        TriggerServerEvent('1465c226-a0b3-497e-bd2e-2e78fa0dce7d', skin)
    end)
end)


RegisterNetEvent('0fd31a0c-89c0-4a75-afac-01b9c8ad01e4')
AddEventHandler('0fd31a0c-89c0-4a75-afac-01b9c8ad01e4', function(mask)
	print('mask type : ' .. mask)
	if mask == 1 then
		SetPedComponentVariation	(GetPlayerPed(-1), 10,		32,			0)	
	elseif mask == 2 then
		SetPedComponentVariation	(GetPlayerPed(-1), 10,		33,			0)	
	elseif mask == 3 then
		SetPedComponentVariation	(GetPlayerPed(-1), 10,		34,			0)	
	elseif mask == 4 then
		SetPedComponentVariation	(GetPlayerPed(-1), 10,		35,			0)	
	elseif mask ==5 then
		SetPedComponentVariation	(GetPlayerPed(-1), 10,		35,			0)	
	end
	
end)