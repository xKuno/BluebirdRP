--[[-----------------------------------
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
Ac Loaf Scripts 2020 All Rights Reserved
!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--]]-----------------------------------

--[[------------------------
!!!!!!!!!!!!!!!!!!!!!!!!!!!!
SHARING THIS FILE IS ILLEGAL
!!!!!!!!!!!!!!!!!!!!!!!!!!!!
--]]------------------------

local data = {}

GenerateId = function(length, usecapital, usenumbers)
    local result = ''

    for i = 1, length do
        local randomised = string.char(math.random(97, 122))
        if usecapital then
            if math.random(1, 2) == 1 then
                randomised = randomised:upper()
            end
        end
        if usenumbers then
            if math.random(1, 2) == 1 then
                randomised = tostring(math.random(0, 9))
            end
        end
        result = result .. randomised
    end

    return result
end

VolumeCheck = function(id)
    if data[id]['DUI'] then
        if data[id]['ActualVolume'] ~= data[id]['Volume'] then
            local duiLong = data[id]['DUI']['Long']

            SendDuiMouseMove(duiLong, 75, 700)
            Wait(250)
            SendDuiMouseMove(duiLong, 95 + math.ceil(data[id]['Volume'] * 5), 702)
            Wait(5)
            SendDuiMouseDown(duiLong, 'left')
            Wait(7)
            SendDuiMouseUp(duiLong, 'left')

            SendDuiMouseMove(duiLong, 75, 500)

            data[id]['ActualVolume'] = data[id]['Volume']
        end
    end
end

CreateVideo = function(id, url, object, coords, scale, offset, time, volume)
    if data[id] then
        if data[id]['DUI'] then
            DestroyDui(data[id]['DUI']['Long'])
        end
        data[id] = nil
        Wait(1000)
    end

    local distance = 10.0

    for k, v in pairs(Config['Objects']) do
        if v['Object'] == object then
            Distance = v['Distance']
            break
        end
    end

    data[id] = {
        ['URL'] = url,
        ['Time'] = time,
        ['Started'] = math.ceil(GetGameTimer() / 1000) + 1,
        ['Object'] = object,
        ['Coords'] = coords,
        ['Offset'] = offset,
        ['Scale'] = scale,
        ['Volume'] = volume,
        ['ActualVolume'] = 0,
        ['Distance'] = Distance
    }
end

RegisterNetEvent('ae928c49-8e96-4b55-80dc-bdb18049b7ba')
AddEventHandler('ae928c49-8e96-4b55-80dc-bdb18049b7ba', function(players)
    for k, v in pairs(players) do
        if v ~= nil then
            CreateVideo(k, v['URL'], v['Object'], v['Coords'], v['Scale'], v['Offset'], v['Time'], v['Volume'])

            if v['Duration'] then
                data[k]['Duration'] = v['Duration']
            end
        end
    end
end)

CreateThread(function()
    while not NetworkIsSessionStarted() do Wait(200) end

    local SFHandle = RequestScaleformMovie('generic_texture_renderer')
    while not HasScaleformMovieLoaded(SFHandle) do Wait(1000) end

    TriggerServerEvent('11c69671-3b3b-40eb-9ec3-5ad229374cc6')

    CreateThread(function()
        while true do
            Wait(500)
			playerCoords = GetEntityCoords(PlayerPedId())
			local coords = playerCoords

            for k, v in pairs(data) do
                Wait(100)
                local obj = GetClosestObjectOfType(coords, v['Distance'], (v['Object']))

                if v ~= nil then
                    local obj = GetClosestObjectOfType(v['Coords'], v['Distance'], (v['Object']))
                    if DoesEntityExist(obj) then
                        Wait(2500)
                        while #(coords - v['Coords']) <= v['Distance'] and data[k] ~= nil and DoesEntityExist(obj) do
                            VolumeCheck(k)
                            Wait(500)
                        end
                    end
                end
            end
        end
    end)

    CreateThread(function()
        while true do
            Wait(1500)
			local coords = playerCoords

            for k, v in pairs(Config['Objects']) do
                Wait(300)
                local obj = GetClosestObjectOfType(coords, 2.0, (v['Object']))
                if DoesEntityExist(obj) then
                    local playing = false
                    local CheckPlaying = GetGameTimer()
                    while #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(obj)) <= 2.0 do
                        if CheckPlaying <= GetGameTimer() then
                            CheckPlaying = GetGameTimer() + 750
                            playing = false
                            for k, v in pairs(data) do
                                if v['Coords'] == GetEntityCoords(obj) then
                                    playing = true
                                end
                            end
                        end

                        if playing then
                            AddTextEntry(GetCurrentResourceName(), Strings['VolumeHelp'])

                            if IsControlJustReleased(0, 51) then
                                for k, v in pairs(data) do
                                    if v['Coords'] == GetEntityCoords(obj) then
                                        CreateThread(function()
                                            if v['DUI'] then
                                                SetDuiUrl(v['DUI']['Long'], Config['URL']:format(v['URL'], (math.floor(GetGameTimer() / 1000) + v['Time']) - v['Started']))
                                            end
                                        end)
                                    end
                                end
                            end
                        else
                            AddTextEntry(GetCurrentResourceName(), Strings['VideoHelp'])
                        end

                        DisplayHelpTextThisFrame(GetCurrentResourceName(), false)
                        Wait(0)
                    end
                end
            end
        end
    end)

    while true do
        Wait(500)

        for k, v in pairs(data) do
            Wait(0)
            if v ~= nil then
                local obj = GetClosestObjectOfType(v['Coords'], v['Distance'], (v['Object']))
                if DoesEntityExist(obj) then
                    if #(GetEntityCoords(PlayerPedId()) - v['Coords']) <= v['Distance'] then
                        if SFHandle ~= nil then
                            local duiLong = CreateDui(Config['URL']:format(v['URL'], (math.floor(GetGameTimer() / 1000) + v['Time']) - v['Started']), 1280, 720)
                            local dui = GetDuiHandle(duiLong)

                            local txd, txn = GenerateId(25, true, false), GenerateId(25, true, false)
                            CreateRuntimeTextureFromDuiHandle(CreateRuntimeTxd(txd), txn, dui)

                            v['DUI'] = {
                                ['Long'] = duiLong,
                                ['Obj'] = dui,
                            }

                            v['Texture'] = {
                                ['txd'] = txd,
                                ['txn'] = txn,
                            }

                            PushScaleformMovieFunction(SFHandle, 'SET_TEXTURE')
                            PushScaleformMovieMethodParameterString(v['Texture']['txd'])
                            PushScaleformMovieMethodParameterString(v['Texture']['txn'])

                            PushScaleformMovieFunctionParameterInt(0)
                            PushScaleformMovieFunctionParameterInt(0)
                            PushScaleformMovieFunctionParameterInt(1920)
                            PushScaleformMovieFunctionParameterInt(1080)

                            PopScaleformMovieFunctionVoid()

                            while #(GetEntityCoords(PlayerPedId()) - v['Coords']) <= v['Distance'] and DoesEntityExist(obj) and data[k] ~= nil do
                                Wait(0)

                                if v['Duration'] then
                                    if (math.ceil(GetGameTimer() / 1000) - v['Started']) > v['Duration'] then
                                        DestroyDui(v['DUI']['Long'])
                                        data[k] = nil
                                        break
                                    end
                                end
                                DrawScaleformMovie_3dNonAdditive(SFHandle, GetOffsetFromEntityInWorldCoords(obj, v['Offset']), 0.0, GetEntityHeading(obj) * -1, 0.0, 2, 2, 2, v['Scale'] * 1, v['Scale'] * (9 / 16), 1, 2)
                            end

                            if data[k] then
                                -- destroy browser (we are no longer close to the tv)
                                DestroyDui(v['DUI']['Long'])

                                v['DUI'] = {}
                                v['Texture'] = {}
                            end
                        end
                    end
                end
            end
        end

    end
end)

RegisterCommand('tv', function(source, args)
    if args[1] then
        for k, v in pairs(Config['Objects']) do
            local obj = GetClosestObjectOfType(playerCoords, 5.0, (v['Object']))
            if DoesEntityExist(obj) then
                TriggerServerEvent('485e5301-ed73-4ed0-b267-ccff6970a32f', args[1], v['Object'], GetEntityCoords(obj), v['Scale'], v['Offset'])
                break
            end
        end
    end
end)



RegisterCommand('volume', function(src, args)
    if args[1] then
        local volume = tonumber(args[1])
        if volume then
            if volume >= 0 then

                for k, v in pairs(data) do
                    if #(playerCoords - v['Coords']) <= 5.0 then
                        if volume == 1 then volume = 1.5 end
                        if volume > 10 then volume = 10 end
                        TriggerServerEvent('7bba47d7-d6ca-40b1-9142-171b32b2c4b3', k, volume)
                        break
                    end
                end

            end
        end
    end
end)

RegisterCommand('destroy', function(src, args)
    for k, v in pairs(data) do
        if #(GetEntityCoords(PlayerPedId()) - v['Coords']) <= 5.0 then
            TriggerServerEvent('05081a0d-5b14-44dc-a22d-3294fe3776e3', k)
            break
        end
    end
end)

RegisterNetEvent('c7fc089f-f31b-4f8d-a6b7-375d87979bcf')
AddEventHandler('c7fc089f-f31b-4f8d-a6b7-375d87979bcf', function(id)
    if data[id] then
        if data[id]['DUI'] then
            DestroyDui(data[id]['DUI']['Long'])
        end
        data[id] = nil
    end
end)

RegisterNetEvent('830de8b2-d74c-4069-bc6a-78b61fd3dc15')
AddEventHandler('830de8b2-d74c-4069-bc6a-78b61fd3dc15', function(id, volume)
    if data[id] then
        data[id]['Volume'] = volume
    end
end)
         