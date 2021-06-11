TriggerEvent('chat:addSuggestion', '/'..main.fanCommand, translations.fanSuggestion, {
    { name="setup/remove", help=translations.fanHelp },
})

TriggerEvent('chat:addSuggestion', '/'..main.stabilisersCommand, translations.stabilisersSuggestion, {
    { name="setup/remove", help=translations.stabilisersHelp },
})

TriggerEvent('chat:addSuggestion', '/'..main.spreadersCommand, translations.spreadersSuggestion)

RegisterNetEvent('Client:rtcNotification')
AddEventHandler('Client:rtcNotification', function(message)
    showNotification(message)
end)

function showNotification(message)
    message = message.."."
    SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(0,1)
end

function tableHas(table, key)
    for k, v in pairs(table) do
        if k == key and v ~= nil then
            return true
        end
    end
    return false
end

function raycast()
    local ped = PlayerPedId()
    local location = GetEntityCoords(ped)
    local offSet = GetOffsetFromEntityInWorldCoords(ped, 0.0, 8.0, 0.0)
    local shapeTest = StartShapeTestCapsule(location.x, location.y, location.z, offSet.x, offSet.y, offSet.z, 10.0, 2, ped, 0)
    --local shapeTest = StartShapeTestRay(location.x, location.y, location.z, offSet.x, offSet.y, offSet.z, 2, ped, 0);
    local retval, hit, endCoords, surfaceNormal, entityHit = GetShapeTestResult(shapeTest)
    return entityHit
end

local fanSoundActive = false
local fanId = 0
local fans = {}
Citizen.CreateThread(function()
    while true do
        local ped = PlayerPedId()
        local coords = GetEntityCoords(ped)
        if fanSoundActive then
            if fans[fanId] ~= nil and fans[fanId][2] ~= nil then
                local distance = #(coords - fans[fanId][2])
                if distance > main.fanSoundDistance then
                    fanSoundActive = false
                else
                    SendNUIMessage({
                        submissionType     = 'rtcSounds',
                        submissionFile     = 'fan',
                        submissionVolume   = main.fanSoundVolume
                    })
                    Wait(10000)
                end
            end
        else
            for k, v in pairs(fans) do
                local distance = #(coords - fans[k][2])
                if distance < main.fanSoundDistance then
                    fanSoundActive = true
                    fanId = k
                    SendNUIMessage({
                        submissionType     = 'rtcSounds',
                        submissionFile     = 'fan',
                        submissionVolume   = main.fanSoundVolume
                    })
                    Wait(10000)
                end
            end
        end
        Wait(2000)
    end
end)

AddEventHandler('Client:receiveFanTable', function(table)
    fans = table
end)

AddEventHandler('Client:updateFansTable', function(key, entry, remove)
    if remove then 
        fans[key] = nil
        return 
    end
    fans[key] = entry
end)