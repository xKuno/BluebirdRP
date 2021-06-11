-- Main Job:
local SelectedID                        = nil
local JobVehicle                        = nil
local Goons                             = {}
local blip                              = nil
local isCarLockpicked                   = false
local nr                                = 0
local Deliver1                          = nil
local Deliver2                          = nil
local carIsDelivered                    = false
local endBlip                           = nil
local endBlipCreated                    = false
local DeliveryInProgress                = false
local JobInProgress                     = false

-- NPC Mission spawn event:
local JobPED = nil
RegisterNetEvent('e5ffc95b-7acf-4f0b-896d-d3ace632dc68')
AddEventHandler('e5ffc95b-7acf-4f0b-896d-d3ace632dc68',function(NPC)
    local JobPedPos = NPC.Pos
    local JobPedHeading = NPC.Heading
    RequestModel(GetHashKey(NPC.Ped))
    while not HasModelLoaded(GetHashKey(NPC.Ped)) do
        Citizen.Wait(100)
    end
    JobPED = CreatePed(7,GetHashKey(NPC.Ped),JobPedPos[1],JobPedPos[2],JobPedPos[3],JobPedHeading,0,true,true)
    FreezeEntityPosition(JobPED,true)
    SetBlockingOfNonTemporaryEvents(JobPED, true)
    TaskStartScenarioInPlace(JobPED, "WORLD_HUMAN_AA_SMOKE", 0, false)
    SetEntityInvincible(JobPED,true)
end)

local interacting
-- Job NPC Thread Function:
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(3)
        local pedCoords = GetEntityCoords(JobPED)
        local plyCoords = GetEntityCoords(GetPlayerPed(-1))
        local distance = Vdist2(pedCoords[1], pedCoords[2], pedCoords[3], plyCoords.x, plyCoords.y, plyCoords.z)
        if distance <= 1.5 and not interacting then
            DrawText3Ds(pedCoords[1], pedCoords[2], pedCoords[3], _U('press_to_talk'))
            if IsControlJustPressed(0, Config.KeyToTalk) then
                GetJobFromNPC()
                Citizen.Wait(250)
            end
		else
			Wait(1000)
        end
    end
end)

-- Requests the mission from NPC function:
function GetJobFromNPC()
    interacting = true
    local player = PlayerPedId()
    local anim_lib = "missheistdockssetup1ig_5@base"
    local anim_dict = "workers_talking_base_dockworker1"

    RequestAnimDict(anim_lib)
    while not HasAnimDictLoaded(anim_lib) do
        Citizen.Wait(0)
    end

    ESX.TriggerServerCallback('2e39a284-547e-4913-9de7-39fab83a174a', function(cooldown)

            if not cooldown then

                FreezeEntityPosition(player,true)
                TaskPlayAnim(player,anim_lib,anim_dict,1.0,0.5,-1,31,1.0,0,0)
                exports['progressBars']:startUI((4 * 1000), _U('progbar_talking'))
                Citizen.Wait((4 * 1000))
                ClearPedTasks(player)
                ClearPedSecondaryTask(player)

                ChooseRiskGrade()
            else
                interacting = false
            end
    end)
    Citizen.Wait(500)
end

-- Function for choosing Risk Grade:
function ChooseRiskGrade()
    local player = PlayerPedId()
    local elements = {}

    for k,v in pairs(Config.RiskGrades) do
        if v.Enabled == true then
            table.insert(elements,{label = v.Label .. " | "..('<span style="color:green;">%s</span>'):format("$"..v.BuyPrice..""), value = v.Grade, Enabled = v.Enabled, BuyPrice = v.BuyPrice, MinCops = v.MinCops, Cars = v.Cars})
        end
    end
    table.insert(elements,{label = _U('cancel'), value = "cancel_interaction_with_npc"})

    ESX.UI.Menu.Open('default', GetCurrentResourceName(), "choose_risk_grade_menu",
        {
            title    = _U('choose_risk_grade'),
            align    = "center",
            elements = elements
        },
        function(data, menu)

            if data.current.value == "cancel_interaction_with_npc" then
                ShowNotifyESX(_U('cancel_notify'))
                menu.close()
                ClearPedTasks(player)
                FreezeEntityPosition(player,false)
                interacting = false
            else
                TriggerServerEvent('519484ff-b437-4f92-a801-8b56cc7a8376',data.current.value, data.current.BuyPrice, data.current.MinCops, data.current.Cars )
                Citizen.Wait(100)
                menu.close()
                ClearPedTasks(player)
                FreezeEntityPosition(player,false)
                interacting = false
            end

        end, function(data, menu)
            menu.close()
            ShowNotifyESX(_U('cancel_notify'))
            ClearPedTasks(player)
            FreezeEntityPosition(player,false)
            interacting = false
        end, function(data, menu)
        end)
end

-- Event to browse through available locations:
RegisterNetEvent('6cd63c6a-f5d4-4bdd-af25-565d23f3e585')
AddEventHandler('6cd63c6a-f5d4-4bdd-af25-565d23f3e585',function(spot,grade,car)
    local id = math.random(1,#Config.CarJobs)
    local currentID = spot
    while Config.CarJobs[id].InProgress and currentID < 100 do
        currentID = currentID+1
        id = math.random(1,#Config.CarJobs)
    end
    if currentID == 100 then
        ShowNotifyESX(_U('no_jobs_available'))
    else
        SelectedID = id
        TriggerEvent('43ca3562-f7c7-4342-8626-6ee6f6e35276',id,grade,car)
    end
end)

-- Event to browse through available locations:
RegisterNetEvent('43ca3562-f7c7-4342-8626-6ee6f6e35276')
AddEventHandler('43ca3562-f7c7-4342-8626-6ee6f6e35276',function(id,grade,car)
    local VehName = car.Name
    local VehHash = car.Hash
    local VehPrice = math.random(car.MinReward,car.MaxReward)

    if Config.UsePhoneMSG then
        JobNotifyMSG(_U('steal_the_car', VehName))
    else
        ShowNotifyESX(_U('steal_the_car', VehName))
    end

    local Goons = {}
    local CurrentJob = Config.CarJobs[id]
    CurrentJob.InProgress = true
    TriggerServerEvent('be19c719-07fb-4517-a1c5-d399ffd5b885',Config.CarJobs)
    Citizen.Wait(500)
    local playerPed = GetPlayerPed(-1)
    local JobCompleted = false
    local blip = CreateMissionBlip(CurrentJob)

    while not JobCompleted do
        Citizen.Wait(0)

        if Config.CarJobs[id].InProgress == true then

            local coords = GetEntityCoords(playerPed)

            if (GetDistanceBetweenCoords(coords, CurrentJob.Spot[1], CurrentJob.Spot[2], CurrentJob.Spot[3], true) < 150) and not CurrentJob.CarSpawned then

                ClearAreaOfVehicles(CurrentJob.Spot[1], CurrentJob.Spot[2], CurrentJob.Spot[3], 15.0, false, false, false, false, false)
                local VehCoords = { x= CurrentJob.Spot[1], y = CurrentJob.Spot[2], z = CurrentJob.Spot[3]}
                while ESX == nil do
                    Citizen.Wait(1)
                end

                ESX.Game.SpawnVehicle(VehHash, VehCoords, CurrentJob.Heading,8000, function(vehicle)

                    SetEntityCoordsNoOffset(vehicle, CurrentJob.Spot[1], CurrentJob.Spot[2], CurrentJob.Spot[3])
                    SetEntityHeading(vehicle,CurrentJob.Heading)
                    FreezeEntityPosition(vehicle, true)
                    SetVehicleOnGroundProperly(vehicle)
                    FreezeEntityPosition(vehicle, false)
                    JobVehicle = vehicle
                    SetEntityAsMissionEntity(JobVehicle, true, true)
                    SetVehicleDoorsLockedForAllPlayers(JobVehicle, true)
					
                end)
                CurrentJob.CarSpawned = true
                TriggerServerEvent('be19c719-07fb-4517-a1c5-d399ffd5b885',Config.CarJobs)
            end

            if grade == 2 or grade == 3 then
                if (GetDistanceBetweenCoords(coords, CurrentJob.Spot[1], CurrentJob.Spot[2], CurrentJob.Spot[3], true) < 150) and CurrentJob.CarSpawned and not CurrentJob.GoonsSpawned then
                    ClearAreaOfPeds(CurrentJob.Spot[1], CurrentJob.Spot[2], CurrentJob.Spot[3], 50, 1)
                    CurrentJob.GoonsSpawned = true
                    TriggerServerEvent('be19c719-07fb-4517-a1c5-d399ffd5b885',Config.CarJobs)
                    SetPedRelationshipGroupHash(playerPed, GetHashKey("PLAYER"))
                    AddRelationshipGroup('JobNPCs')
                    local i = 0
                    for k,v in pairs(CurrentJob.Goons) do
                        RequestModel(GetHashKey(v.ped))
                        while not HasModelLoaded(GetHashKey(v.ped)) do
                            Wait(1)
                        end
                        Goons[i] = CreatePed(4, GetHashKey(v.ped), v.Pos[1], v.Pos[2], v.Pos[3], v.h, false, true)
                        NetworkRegisterEntityAsNetworked(Goons[i])
                        SetNetworkIdCanMigrate(NetworkGetNetworkIdFromEntity(Goons[i]), true)
                        SetNetworkIdExistsOnAllMachines(NetworkGetNetworkIdFromEntity(Goons[i]), true)
                        SetPedCanSwitchWeapon(Goons[i], true)
                        SetPedArmour(Goons[i], v.armour)
                        SetPedAccuracy(Goons[i], v.accuracy)
                        SetEntityInvincible(Goons[i], false)
                        SetEntityVisible(Goons[i], true)
                        SetEntityAsMissionEntity(Goons[i])
                        RequestAnimDict(v.animDict)
                        while not HasAnimDictLoaded(v.animDict) do
                            Citizen.Wait(0)
                        end
                        TaskPlayAnim(Goons[i], v.animDict, v.animLib, 8.0, -8, -1, 49, 0, 0, 0, 0)
                        if grade == 2 then
                            GiveWeaponToPed(Goons[i], GetHashKey(v.weapon2), 1, false, false)
                        elseif grade == 3 then
                            GiveWeaponToPed(Goons[i], GetHashKey(v.weapon3), 255, false, false)
                        end
                        SetPedDropsWeaponsWhenDead(Goons[i], false)
                        SetPedCombatAttributes(Goons[i], false)
                        if Config.EnableHeadshotKills == false then
                            SetPedSuffersCriticalHits(Goons[i], false)
                        end
                        SetPedFleeAttributes(Goons[i], 0, false)
                        SetPedCombatAttributes(Goons[i], 16, true)
                        SetPedCombatAttributes(Goons[i], 46, true)
                        SetPedCombatAttributes(Goons[i], 26, true)
                        SetPedSeeingRange(Goons[i], 75.0)
                        SetPedHearingRange(Goons[i], 50.0)
                        SetPedEnableWeaponBlocking(Goons[i], true)
                        SetPedRelationshipGroupHash(Goons[i], GetHashKey("JobNPCs"))
                        TaskGuardCurrentPosition(Goons[i], 15.0, 15.0, 1)
                        i = i +1
                    end
                end
            end

            if (GetDistanceBetweenCoords(coords, CurrentJob.Spot[1], CurrentJob.Spot[2], CurrentJob.Spot[3], true) < 60) and not CurrentJob.JobPlayer then
                CurrentJob.JobPlayer = true
                TriggerServerEvent('be19c719-07fb-4517-a1c5-d399ffd5b885',Config.CarJobs)
                Citizen.Wait(500)
                SetPedRelationshipGroupHash(playerPed, GetHashKey("PLAYER"))
                AddRelationshipGroup('JobNPCs')
                local i = 0
                for k,v in pairs(CurrentJob.Goons) do
                    ClearPedTasksImmediately(Goons[i])
                    TaskCombatPed(Goons[i],playerPed, 0, 16)
                    SetPedCombatAttributes(Goons[i], false)
                    if Config.EnableHeadshotKills == false then
                        SetPedSuffersCriticalHits(Goons[i], false)
                    end
                    SetPedFleeAttributes(Goons[i], 0, false)
                    SetPedCombatAttributes(Goons[i], 16, true)
                    SetPedCombatAttributes(Goons[i], 46, true)
                    SetPedCombatAttributes(Goons[i], 26, true)
                    SetPedSeeingRange(Goons[i], 75.0)
                    SetPedHearingRange(Goons[i], 50.0)
                    SetPedEnableWeaponBlocking(Goons[i], true)
                    i = i +1
                end
                SetRelationshipBetweenGroups(0, GetHashKey("JobNPCs"), GetHashKey("JobNPCs"))
                SetRelationshipBetweenGroups(5, GetHashKey("JobNPCs"), GetHashKey("PLAYER"))
                SetRelationshipBetweenGroups(5, GetHashKey("PLAYER"), GetHashKey("JobNPCs"))
            end

            local CarPosition = GetEntityCoords(JobVehicle)

            if (GetDistanceBetweenCoords(coords, CarPosition[1], CarPosition[2], CarPosition[3], true) <= 2) and isCarLockpicked == false then
                DrawText3Ds(CarPosition[1], CarPosition[2], CarPosition[3], _U('press_to_lockpick'))
                if IsControlJustPressed(1, Config.KeyToLockpick) then
                    LockpickCar(CurrentJob)
                    DrawVehHealth(JobVehicle)
                    Citizen.Wait(500)
                end
            end

            if IsPedInAnyVehicle(playerPed, true) and isCarLockpicked == true then
                if GetDistanceBetweenCoords(coords, CurrentJob.Spot[1], CurrentJob.Spot[2], CurrentJob.Spot[3], true) < 5 then
                    local lockpickedVehicle = GetVehiclePedIsIn(playerPed, false)
                    if GetEntityModel(lockpickedVehicle) == VehHash then
                        RemoveBlip(blip)
                        if endBlipCreated == false then
                            nr = math.random(1,#Config.DeliverySpot)
                            Deliver1 = Config.DeliverySpot[nr]
                            -- new MSG for player:
                            if Config.UsePhoneMSG then
                                JobNotifyMSG(_U('deliver_the_car'))
                            else
                                ShowNotifyESX(_U('deliver_the_car'))
                            end
                            endBlipCreated = true
                            endBlip = AddBlipForCoord(Deliver1.Pos[1], Deliver1.Pos[2], Deliver1.Pos[3])
                            SetBlipSprite(endBlip, Deliver1.BlipSprite)
                            SetBlipColour(endBlip,Deliver1.BlipColor)
                            BeginTextCommandSetBlipName("STRING")
                            AddTextComponentString(Deliver1.BlipName)
                            EndTextCommandSetBlipName(endBlip)
                            SetBlipScale(endBlip,Deliver1.BlipScale)
                            if Deliver1.EnableBlipRoute then
                                SetBlipRoute(endBlip, true)
                                SetBlipRouteColour(endBlip, Deliver1.BlipColor)
                            end
                        end
                        DeliveryInProgress = true
                    end
                end
            end

            if DeliveryInProgress and not carIsDelivered then

                local lockpickedVehicle = GetVehiclePedIsIn(playerPed, false)
                Deliver2 = Config.DeliverySpot[nr]
                if GetEntityModel(lockpickedVehicle) == VehHash then
                    if(GetDistanceBetweenCoords(coords, Deliver2.Pos[1], Deliver2.Pos[2], Deliver2.Pos[3], true) < Deliver2.DrawDist) then
                        DrawMarker(Deliver2.MarkerType, Deliver2.Pos[1], Deliver2.Pos[2], Deliver2.Pos[3]-0.97, 0.0, 0.0, 0.0, 180.0, 0.0, 0.0, Deliver2.MarkerScale.x, Deliver2.MarkerScale.y, Deliver2.MarkerScale.z, Deliver2.MarkerColor.r, Deliver2.MarkerColor.g, Deliver2.MarkerColor.b, Deliver2.MarkerColor.a, false, true, 2, false, false, false, false)
                    end
                    if (GetDistanceBetweenCoords(coords, Deliver2.Pos[1], Deliver2.Pos[2], Deliver2.Pos[3], true) < 2.0) and not carIsDelivered then
                        DrawText3Ds(Deliver2.Pos[1], Deliver2.Pos[2], Deliver2.Pos[3], _U('press_to_deliver'))
                        if IsControlJustPressed(0, Config.KeyToDeliver) then
                            local JobCarHealth = (GetEntityHealth(lockpickedVehicle)/10)
                            local RoundHealth = round(JobCarHealth, 0)
                            RemoveBlip(endBlip)
                            carIsDelivered = true
                            SetVehicleForwardSpeed(JobVehicle, 0)
                            SetVehicleEngineOn(JobVehicle, false, false, true)
                            if IsPedInAnyVehicle(playerPed, true) then
                                TaskLeaveVehicle(playerPed, JobVehicle, 4160)
                                SetVehicleDoorsLockedForAllPlayers(JobVehicle, true)
                            end
                            Citizen.Wait(500)
                            FreezeEntityPosition(JobVehicle, true)
                            TriggerServerEvent('54129304-e322-4c1d-921f-8a00b1c82204',VehPrice,RoundHealth)

                            if Config.UsePhoneMSG then
                                JobNotifyMSG(_U('job_complete'))
                            else
                                ShowNotifyESX(_U('job_complete'))
                            end

                            StopTheJob = true
                        end
                    end
                end
            end

            if JobVehicle ~= nil then
                if CurrentJob.CarSpawned == true then
                    if not DoesEntityExist(JobVehicle) then
                        StopTheJob = true
                        if Config.UsePhoneMSG then
                            JobNotifyMSG(_U('car_is_taken'))
                        else
                            ShowNotifyESX(_U('car_is_taken'))
                        end
                    end
                end
                if isCarLockpicked then
                    local VehPos = GetEntityCoords(JobVehicle)
                    if DoesEntityExist(JobVehicle) then
                        if (GetDistanceBetweenCoords(coords, VehPos[1], VehPos[2], VehPos[3], true) >= 50.0) then
                            StopTheJob = true
                            if Config.UsePhoneMSG then
                                JobNotifyMSG(_U('too_far_from_veh'))
                            else
                                ShowNotifyESX(_U('too_far_from_veh'))
                            end
                        end
                    end
                end
            end

            if StopTheJob == true then

                Config.CarJobs[id].InProgress = false
                Config.CarJobs[id].CarSpawned = false
                Config.CarJobs[id].GoonsSpawned = false
                Config.CarJobs[id].JobPlayer = false
                TriggerServerEvent('be19c719-07fb-4517-a1c5-d399ffd5b885',Config.CarJobs)
                Citizen.Wait(2000)
                DeleteVehicle(JobVehicle)

                if DeliveryInProgress == true then
                    RemoveBlip(endBlip)
                else
                    RemoveBlip(blip)
                end

                local i = 0
                for k,v in pairs(CurrentJob.Goons) do
                    if DoesEntityExist(Goons[i]) then
                        DeleteEntity(Goons[i])
                    end
                    i = i +1
                end

                JobCompleted            = true
                StopTheJob                      = false
                SelectedID                      = nil
                JobVehicle                      = nil
                Goons                           = {}
                blip                            = nil
                isCarLockpicked         = false
                carIsDelivered          = false
                endBlip                         = nil
                endBlipCreated          = false
                DeliveryInProgress      = false
                Deliver1                        = nil
                Deliver2                        = nil
                nr                                      = 0
                JobInProgress           = false

                break

            end
        end
    end
end)

-- Function for lockpicking the van door:
function LockpickCar(CurrentJob)

    local playerPed = GetPlayerPed(-1)
    local animDict = "anim@amb@clubhouse@tutorial@bkr_tut_ig3@"
    local animName = "machinic_loop_mechandplayer"

    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(50)
    end

    if Config.PoliceAlerts then
        AlertPoliceFunction()
    end

    SetCurrentPedWeapon(playerPed, GetHashKey("WEAPON_UNARMED"),true)
    Citizen.Wait(500)
    FreezeEntityPosition(playerPed, true)
    TaskPlayAnim(playerPed, animDict, animName, 3.0, 1.0, -1, 31, 0, 0, 0)
    -- Car Alarm:
    if Config.EnableThiefAlarm then
        SetVehicleAlarm(JobVehicle, true)
        SetVehicleAlarmTimeLeft(JobVehicle, (Config.CarAlarmTime * 1000))
        StartVehicleAlarm(JobVehicle)
    end
    -- Progbar:
    exports['progressBars']:startUI((Config.LockpickTime * 1000), _U('progbar_lockpicking'))
    Citizen.Wait(Config.LockpickTime * 1000)
    -- Hot Wire:
    SetVehicleNeedsToBeHotwired(JobVehicle, true)
    IsVehicleNeedsToBeHotwired(JobVehicle)
    -- End:
    ClearPedTasks(playerPed)
    FreezeEntityPosition(playerPed, false)
    isCarLockpicked = true
    SetVehicleDoorsLockedForAllPlayers(JobVehicle, false)
end

function DrawVehHealth(JobVehicle)
    Citizen.CreateThread(function()
        JobInProgress = true
        while JobInProgress do
            Citizen.Wait(0)
            local vehTest = JobVehicle
            local vehHealth = (GetEntityHealth(vehTest)/10)
            DrawVehHealthUtils(vehHealth)
        end
    end)
end

-- Blip on Map for NPC:
Citizen.CreateThread(function()
    for k,v in pairs(Config.JobNPC) do
        if v.EnableBlip then
            local blip = AddBlipForCoord(v.Pos[1], v.Pos[2], v.Pos[3])
            SetBlipSprite (blip, v.blipSprite)
            SetBlipDisplay(blip, 4)
            SetBlipScale  (blip, v.blipScale)
            SetBlipColour (blip, v.blipColor)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(v.blipName)
            EndTextCommandSetBlipName(blip)
        end
    end
end)

-- Function for job blip in progress:
function CreateMissionBlip(Job)
    local blip = AddBlipForCoord(Job.Spot[1],Job.Spot[2],Job.Spot[3])
    SetBlipSprite(blip, Job.BlipSprite)
    SetBlipColour(blip, Job.BlipColor)
    AddTextEntry('MYBLIP', Job.BlipName)
    BeginTextCommandSetBlipName('MYBLIP')
    AddTextComponentSubstringPlayerName(name)
    EndTextCommandSetBlipName(blip)
    SetBlipScale(blip, Job.BlipScale)
    SetBlipAsShortRange(blip, true)
    if Job.EnableBlipRoute then
        SetBlipRoute(blip, true)
        SetBlipRouteColour(blip, Job.BlipColor)
    end
    return blip
end

AddEventHandler('2df4c490-68a8-4c7e-896a-9fc552e16210', function(data)
    StopTheJob = true
    TriggerServerEvent('be19c719-07fb-4517-a1c5-d399ffd5b885',Config.CarJobs)
    Citizen.Wait(5000)
    StopTheJob = false
end)

AddEventHandler('880c0a93-b305-46b3-b84c-a120fee9e841', function(spawn)
    isDead = false
end)

RegisterNetEvent('e922eb9c-9ef1-46c7-a7fc-ea58d0d8680d')
AddEventHandler('e922eb9c-9ef1-46c7-a7fc-ea58d0d8680d',function(data)
    Config.CarJobs = data
end)




