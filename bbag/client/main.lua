--[[

        RRP_BODYBAG
        By: BTNGaming

        Github: https://github.com/btngaming

        FEEL FREE TO EDIT THE CODE FOR PERSONAL USE
        DO NOT SHARE AS OWN WORK
        DO NOT SELL THIS WORK

        -= PERSONAL USE ONLY =-

]]--

-- COMMAND NAME --

local command_name = "bodybag"


-- CODE --


ESX = nil

local PlayerData = {}

local bodyBag = nil

local attached = false

Citizen.CreateThread(function()
    if Config.use_esx then
        while ESX == nil do
            TriggerEvent('esx:getSharedObject', function(obj)ESX = obj end)
            Citizen.Wait(0)
        end
        
        while ESX.GetPlayerData().job == nil do
            Citizen.Wait(10)
        end
        
        PlayerData = ESX.GetPlayerData()
    end
end)

RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function(job)
    PlayerData.job = job
end)

RegisterCommand(command_name, function(source, args, rawCommand)
    if Config.use_command then

        if Config.use_esx then

            -- ESX CODE --

            PlayerData = ESX.GetPlayerData()
			

            if Config.restrict_job then
				print('restrict job')
				
                if PlayerData.job ~= nil and (PlayerData.job.name == Config.job_1 or PlayerData.job.name == Config.job_2) then
					print('restrict correct job')
                    if args[1] and GetPlayerName(args[1])  ~= nil then
                        local targetPed = GetPlayerPed(args[1])
                        TriggerServerEvent('deed5179-0675-4f22-8e1d-e26f66f88a32', GetPlayerServerId(targetPed))
                    else
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        local targetPed = GetPlayerPed(closestPlayer)
						print('cloest player')
						print(closestPlayer)
                        if closestPlayer ~= -1 and closestDistance <= 3.0 and IsPedRagdoll(targetPed) then
							print('send to server')
							print(GetPlayerServerId(closestPlayer))
                            TriggerServerEvent('deed5179-0675-4f22-8e1d-e26f66f88a32', GetPlayerServerId(closestPlayer))
                        end
                    end
                end

            else

                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                local targetPed = GetPlayerPed(closestPlayer)
				
                if closestPlayer ~= -1 and closestDistance <= 3.0 and IsPedRagdoll(targetPed) then

                    TriggerServerEvent('deed5179-0675-4f22-8e1d-e26f66f88a32', GetPlayerServerId(closestPlayer))
                end
            end

        else

            -- STANDALONE CODE --

            if args[1] and GetPlayerName(args[1])  ~= nil then

                local targetPed = GetPlayerPed(args[1])

                TriggerServerEvent('deed5179-0675-4f22-8e1d-e26f66f88a32', GetPlayerServerId(targetPed))

            else 

                local closestPlayer, closestPlayerDist = GetClosestPlayer()
                local targetPed = GetPlayerPed(closestPlayer)

                if closestPlayer ~= -1 and closestDistance <= 3.0 and IsPedRagdoll(targetPed) then

                    TriggerServerEvent('deed5179-0675-4f22-8e1d-e26f66f88a32', GetPlayerServerId(closestPlayer))
                end
            end
        end

    else
        print("Command Module Disabled")
    end
end, false)


RegisterCommand('pkill', function(source, args, rawCommand)


        if Config.use_esx then

            -- ESX CODE --

            PlayerData = ESX.GetPlayerData()
			

            if Config.restrict_job then
				print('restrict job')
				
                if PlayerData.job ~= nil and (PlayerData.job.name == Config.job_1 or PlayerData.job.name == Config.job_2) then
					print('good here')
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					local targetPed = GetPlayerPed(closestPlayer)
					
					if closestPlayer ~= -1 and closestDistance <= 3.0 and IsPedRagdoll(targetPed) then

						TriggerServerEvent('deed5179-0675-4f22-8e1d-e26f66f88a32', GetPlayerServerId(closestPlayer))
					end
				end
			end
		end
end,false)

--[[
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)

        if Config.use_keybind then

            if IsControlJustReleased(0, Config.keybind) then

                if Config.use_esx then

                    -- ESX CODE --

                    PlayerData = ESX.GetPlayerData()

                    if Config.restrict_job then
                
                        if PlayerData.job ~= nil and (PlayerData.job.name == Config.job_1 or PlayerData.job.name == Config.job_2) then

                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            local targetPed = GetPlayerPed(closestPlayer)

                            if closestPlayer ~= -1 and closestDistance <= 3.0 and IsPedRagdoll(targetPed) then

                                TriggerServerEvent('deed5179-0675-4f22-8e1d-e26f66f88a32', GetPlayerServerId(closestPlayer))
                            end
                        end

                    else

                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        local targetPed = GetPlayerPed(closestPlayer)

                        if closestPlayer ~= -1 and closestDistance <= 3.0 and IsPedRagdoll(targetPed) then

                            TriggerServerEvent('deed5179-0675-4f22-8e1d-e26f66f88a32', GetPlayerServerId(closestPlayer))
                        end
                    end

                else

                    -- STANDALONE CODE --

                    local closestPlayer, closestPlayerDist = GetClosestPlayer()
                    local targetPed = GetPlayerPed(closestPlayer)

                    if closestPlayer ~= -1 and closestDistance <= 3.0 and IsPedRagdoll(targetPed) then

                        TriggerServerEvent('deed5179-0675-4f22-8e1d-e26f66f88a32', GetPlayerServerId(closestPlayer))
                    end
                end
            end

        elseif not Config.use_command and not Config.use_keybind then
            
            PutInBodybag()

            Citizen.Wait(Config.freq_bag_on)
    
        else
            break
        end
    end
end)--]]

function PutInBodybag()

    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    
    deadCheck = (IsPedRagdoll(playerPed) or IsPedRagdoll(IsPedRagdoll(GetPlayerPed(-1))))

    if deadCheck and not attached then
        SetEntityVisible(playerPed, false, false)
        
        RequestModel(Config.bag_model)

        while not HasModelLoaded(Config.bag_model) do
            Citizen.Wait(1)
        end

        bodyBag = CreateObject(Config.bag_hash, playerCoords.x, playerCoords.y, playerCoords.z, true, true, true)

        AttachEntityToEntity(bodyBag, playerPed, 0, -0.2, 0.75, -0.2, 0.0, 0.0, 0.0, false, false, false, false, 20, false)
        attached = true
		exports["esx_ambulancejob"]:AllowRespawn(10)
    end
end

RegisterNetEvent('1e3d6ace-ae88-4d80-8e5f-0f52f7d447bf')
AddEventHandler('1e3d6ace-ae88-4d80-8e5f-0f52f7d447bf', PutInBodybag)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
        local playerPed = PlayerPedId()
        
        deadCheck = (IsPedRagdoll(playerPed) or IsPedRagdoll(GetPlayerPed(-1)))

        if not deadCheck and attached then

            DetachEntity(playerPed, true, false)
            SetEntityVisible(playerPed, true, true)

            SetEntityAsMissionEntity(bodyBag, false, false)
            SetEntityVisible(bodybag, false)
            SetModelAsNoLongerNeeded(bodyBag)
            
            DeleteObject(bodyBag)
            DeleteEntity(bodyBag)

            bodyBag = nil
            attached = false

        end

        Citizen.Wait(Config.freq_bag_off)

    end
	
end)