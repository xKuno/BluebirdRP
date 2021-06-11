local holdingSaw = false
local usingSaw = false
local sawModel = "prop_tool_consaw"
local animDict = "weapons@heavy@minigun"
local animName = "idle_2_aim_right_med"
local particleDict = "des_fib_floor"
local particleName = "ent_ray_fbi5a_ramp_metal_imp"
local actionTime = 10
local saw_net = nil

local particles_started = false
local particled_entity_id = nil

local doors = {
    {bone = "door_pside_f", label = "Front Right Door", index = 1},
    {bone = "door_dside_f", label = "Front Left Door", index = 0},
    {bone = "door_pside_r", label = "Back Right Door", index = 3},
    {bone = "door_dside_r", label = "Back Left Door", index = 2}
}

---------------------------------------------------------------------------
-- Toggling Saw --
---------------------------------------------------------------------------
RegisterNetEvent('1a8c19fe-432e-4b08-ba91-e4d850a8e198')
AddEventHandler('1a8c19fe-432e-4b08-ba91-e4d850a8e198', function()
    if not holdingSaw then
        RequestModel(GetHashKey(sawModel))
        while not HasModelLoaded(GetHashKey(sawModel)) do
            Citizen.Wait(100)
        end

        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Citizen.Wait(100)
        end

        local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
        local sawspawned = CreateObject(GetHashKey(sawModel), plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
        Citizen.Wait(1000)
        local netid = ObjToNet(sawspawned)
        SetNetworkIdExistsOnAllMachines(netid, true)
        NetworkSetNetworkIdDynamic(netid, true)
        SetNetworkIdCanMigrate(netid, false)
        AttachEntityToEntity(sawspawned, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422), 0.095, 0.0, 0.0, 270.0, 170.0, 0.0, 1, 1, 0, 1, 0, 1)
        TaskPlayAnim(GetPlayerPed(PlayerId()), 1.0, -1, -1, 50, 0, 0, 0, 0) -- 50 = 32 + 16 + 2
        TaskPlayAnim(GetPlayerPed(PlayerId()), animDict, animName, 1.0, -1, -1, 50, 0, 0, 0, 0)
        saw_net = netid
        holdingSaw = true
    else
        ClearPedSecondaryTask(GetPlayerPed(PlayerId()))
        DetachEntity(NetToObj(saw_net), 1, 1)
        DeleteEntity(NetToObj(saw_net))
        saw_net = nil
        holdingSaw = false
        usingSaw = false
    end
end)

---------------------------------------------------------------------------
-- Start Particles --
---------------------------------------------------------------------------
RegisterNetEvent('e02af178-ba52-4c90-b1bf-d531d853573f')
AddEventHandler('e02af178-ba52-4c90-b1bf-d531d853573f', function(sawid)
    local entity = NetToObj(sawid)

    RequestNamedPtfxAsset(particleDict)
    while not HasNamedPtfxAssetLoaded(particleDict) do
        Citizen.Wait(100)
    end

    UseParticleFxAssetNextCall(particleDict)
    StartParticleFxNonLoopedOnEntity(particleName, entity, -0.715, 0.005, 0.0, 0.0, 25.0, 25.0, 0.75, 0.0, 0.0, 0.0)
end)

---------------------------------------------------------------------------
-- Stop Particles --
---------------------------------------------------------------------------
RegisterNetEvent('c1eeaeee-e898-407b-b478-fd979b392606')
AddEventHandler('c1eeaeee-e898-407b-b478-fd979b392606', function(sawid)
    local entity = NetToObj(sawid)
    RemoveParticleFxFromEntity(entity)
end)

---------------------------------------------------------------------------
-- Get Vehicle Closest Door --
---------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do
        if holdingSaw then

            local vehicle = GetVehicleInFront()
            if vehicle ~= 0 then
                local boneDistances = {}
            
                for a = 1, #doors do
                    local plyPos = GetEntityCoords(GetPlayerPed(PlayerId()), false)
                    local doorPos = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, doors[a].bone))
                    local distance = Vdist(plyPos.x, plyPos.y, plyPos.z, doorPos.x, doorPos.y, doorPos.z)
            
                    if distance < 1.7 then
                        table.insert(boneDistances, {index = a, distance = distance})
                    end
                end

                local lowest = nil
                local lowestDistanceIndex = nil

                if #boneDistances > 1 then
                    for b = 1, #boneDistances do
                        if lowest == nil then
                            lowest = boneDistances[b].index
                            lowestDistanceIndex = b
                        else
                            if boneDistances[b].distance < boneDistances[lowestDistanceIndex].distance then
                                lowest = boneDistances[b].index
                            end
                        end
                    end

                    if IsVehicleDoorDamaged(vehicle, doors[lowest].index) == false then
                        local drawCoord = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, doors[lowest].bone))
                        Draw3DText(drawCoord.x, drawCoord.y, drawCoord.z, tostring("Press E to cut " .. doors[lowest].label))

                        if IsControlJustPressed(1, 38) and not usingSaw then
                            Timer(vehicle, lowest)
                        end
                    end
                end
            end
        end

        Citizen.Wait(0)
    end
end)

Citizen.CreateThread(function()
    while true do
        if usingSaw then
            TriggerServerEvent('da262a65-61b1-454a-91fb-a0945b8b3e57', saw_net)
        end
        Citizen.Wait(100)
    end
end)

function Timer(vehicle, index)
    Citizen.CreateThread(function()
        Notification("~r~You are cutting off the door. Please wait...")
        usingSaw = true
        local time = actionTime
        while time > 0 do

            if not holdingSaw or GetVehicleInFront() ~= vehicle then
                usingSaw = false
                TriggerServerEvent('3d7862af-404c-400b-a9cb-94e021b16e8e', saw_net)
                Notification("~r~Cutting has been canceled.")
                return
            end
            
            Citizen.Wait(1000)
            time = time - 1
        end

        SetVehicleDoorBroken(vehicle, doors[index].index, false)
        TriggerServerEvent('3d7862af-404c-400b-a9cb-94e021b16e8e', saw_net)
        Notification("~g~The vehicles door has been cut off.")
        usingSaw = false
    end)
end

function GetVehicleInFront()
    local plyCoords = GetEntityCoords(GetPlayerPed(PlayerId()), false)
    local plyOffset = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 1.2, 0.0)
    --local rayHandle = StartShapeTestRay(plyCoords.x, plyCoords.y, plyCoords.z, plyOffset.x, plyOffset.y, plyOffset.z, 2, GetPlayerPed(PlayerId()), 1)
    local rayHandle = StartShapeTestCapsule(plyCoords.x, plyCoords.y, plyCoords.z, plyOffset.x, plyOffset.y, plyOffset.z, 0.3, 10, GetPlayerPed(PlayerId()), 7)
    local _, _, _, _, vehicle = GetShapeTestResult(rayHandle)

    return vehicle
end

function Draw3DText(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*2
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
   
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(0)
        SetTextProportional(1)
        -- SetTextScale(0.0, 0.55)
        SetTextColour(255, 255, 255, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
        DrawText(_x,_y)
    end
end

function Notification(message)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(0, 1)
end