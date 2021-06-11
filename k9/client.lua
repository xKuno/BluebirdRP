--[[ Variables ]]--
    -- DO NOT CHANGE --
    local just_started = true
    local k9_name = "Police K9"
    local spawned_ped = nil
    local following = false
    local attacking = false
    local attacked_player = 0
    local searching = false
    local playing_animation = false


ESX               				= nil
local PlayerData                = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	PlayerData = ESX.GetPlayerData()
end)

    local animations = {
        ['Normal'] = {
            sit = {
                dict = "creatures@rottweiler@amb@world_dog_sitting@idle_a",
                anim = "idle_b"
            },
            laydown = {
                dict = "creatures@rottweiler@amb@sleep_in_kennel@",
                anim = "sleep_in_kennel"
            },
            searchhit = {
                dict = "creatures@rottweiler@indication@",
                anim = "indicate_high"
            }
        }
    }
--]]

--[[ Tables ]]--
local language = {}
--]]

--[[ NUI Messages ]]--

    -- Open Menu --
    function EnableMenu()
        SetNuiFocus(true, true)
        SendNUIMessage({
            type = "open_k9_menu"
        })
    end

--]]

--[[ NUI Callbacks ]]--

    RegisterNUICallback("closemenu", function(data)
        SetNuiFocus(false, false)
    end)

    RegisterNUICallback("updatename", function(data)
        k9_name = data.name
		SetNuiFocus(false, false)
    end)

    RegisterNUICallback("spawnk9", function(data)
        TriggerEvent('3f5ba479-aaf9-4ea2-a113-9de017ec831a', data.model)
    end)

    RegisterNUICallback("vehicletoggle", function(data)
        if spawned_ped ~= nil then
            TriggerServerEvent('41c46153-148b-4429-88e9-f758e3b4cf8e')
        end
    end)

    RegisterNUICallback("vehiclesearch", function(data)
        if spawned_ped ~= nil then
				local vehicle = GetVehicleAheadOfPlayer()
				
				Citizen.Trace(tostring(vehicle))
				Citizen.Trace(tostring(json.encode(items)))
				if vehicle ~= 0 and not searching then
					searching = true
		 
					Notification(tostring(k9_name .. " has began searching..."))
					
					if openDoors then
						SetVehicleDoorOpen(vehicle, 0, 0, 0)
						SetVehicleDoorOpen(vehicle, 1, 0, 0)
						SetVehicleDoorOpen(vehicle, 2, 0, 0)
						SetVehicleDoorOpen(vehicle, 3, 0, 0)
						SetVehicleDoorOpen(vehicle, 4, 0, 0)
						SetVehicleDoorOpen(vehicle, 5, 0, 0)
						SetVehicleDoorOpen(vehicle, 6, 0, 0)
						SetVehicleDoorOpen(vehicle, 7, 0, 0)
					end

					-- Back Right
					local offsetOne = GetOffsetFromEntityInWorldCoords(vehicle, 2.0, -2.0, 0.0)
					TaskGoToCoordAnyMeans(spawned_ped, offsetOne.x, offsetOne.y, offsetOne.z, 5.0, 0, 0, 1, 10.0)

					Citizen.Wait(7000)

					-- Front Right
					local offsetTwo = GetOffsetFromEntityInWorldCoords(vehicle, 2.0, 2.0, 0.0)
					TaskGoToCoordAnyMeans(spawned_ped, offsetTwo.x, offsetTwo.y, offsetTwo.z, 5.0, 0, 0, 1, 10.0)

					Citizen.Wait(7000)

					-- Front Left
					local offsetThree = GetOffsetFromEntityInWorldCoords(vehicle, -2.0, 2.0, 0.0)
					TaskGoToCoordAnyMeans(spawned_ped, offsetThree.x, offsetThree.y, offsetThree.z, 5.0, 0, 0, 1, 10.0)


					Citizen.Wait(7000)

					-- Front Right
					local offsetFour = GetOffsetFromEntityInWorldCoords(vehicle, -2.0, -2.0, 0.0)
					TaskGoToCoordAnyMeans(spawned_ped, offsetFour.x, offsetFour.y, offsetFour.z, 5.0, 0, 0, 1, 10.0)

					Citizen.Wait(7000)

					if openDoors then
						SetVehicleDoorsShut(vehicle, 0)
					end

					TriggerServerEvent('027a86dc-d5f5-4b9b-abd1-5f755fe84f21',GetVehicleNumberPlateText(vehicle))
					searching = false
				end
        end
    end)
	
	
    RegisterNUICallback("personsearch", function(data)
        if spawned_ped ~= nil then
		
			if not attacking and not searching then
				searching = true
			
				local bool, target = GetEntityPlayerIsFreeAimingAt(PlayerId())
				if bool then
					if IsEntityAPed(target) then
						local player = GetPlayerFromServerId(GetPlayerId(target))
						local offsetOne = GetOffsetFromEntityInWorldCoords(target, 0.0, 0.0, 0.0)
						TaskGoToCoordAnyMeans(spawned_ped, offsetOne.x, offsetOne.y, offsetOne.z, 1.0, 0, 0, 1, 5.0)
						Citizen.Wait(3000)
						TriggerServerEvent('2cd96807-e899-4195-91a3-c5d0843389f4',GetPlayerId(target))
					end
				else
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
					
					if closestDistance < 15 then
						TriggerServerEvent('2cd96807-e899-4195-91a3-c5d0843389f4',GetPlayerServerId(closestPlayer))
					end
				end
				searching = false
			end
			
		end
    end)

    RegisterNUICallback("sit", function(data)
        if spawned_ped ~= nil then
            PlayAnimation(animations['Normal'].sit.dict, animations['Normal'].sit.anim)
        end
    end)

    RegisterNUICallback("laydown", function(data)
        if spawned_ped ~= nil then
            PlayAnimation(animations['Normal'].laydown.dict, animations['Normal'].laydown.anim)
        end
    end)

RegisterCommand("pdsearch", function(_source, args, raw)
	if spawned_ped ~= nil then
	
		if not attacking and not searching then
			searching = true
		
			local bool, target = GetEntityPlayerIsFreeAimingAt(PlayerId())
			if bool then
				if IsEntityAPed(target) then
					local player = GetPlayerFromServerId(GetPlayerId(target))
					local offsetOne = GetOffsetFromEntityInWorldCoords(target, 0.0, 0.0, 0.0)
					TaskGoToCoordAnyMeans(spawned_ped, offsetOne.x, offsetOne.y, offsetOne.z, 1.0, 0, 0, 1, 5.0)
					Citizen.Wait(3000)
					TriggerServerEvent('2cd96807-e899-4195-91a3-c5d0843389f4',GetPlayerId(target))
				end
			else
				
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

				if closestDistance < 15 then
					pcall(function()
						local offsetOne = GetOffsetFromEntityInWorldCoords(GetPlayerPed(closestPlayer), 0.0, 0.0, 0.0)
						TaskGoToCoordAnyMeans(spawned_ped, offsetOne.x, offsetOne.y, offsetOne.z, 1.0, 0, 0, 1, 5.0)
					end)
					TriggerServerEvent('2cd96807-e899-4195-91a3-c5d0843389f4',GetPlayerServerId(closestPlayer))
				end
			end
			searching = false
		end
	end
end)

RegisterCommand("pdsit", function(_source, args, raw)
	    if spawned_ped ~= nil then
            PlayAnimation(animations['Normal'].sit.dict, animations['Normal'].sit.anim)
        end
end)

RegisterCommand("pdlaydown", function(_source, args, raw)
        if spawned_ped ~= nil then
            PlayAnimation(animations['Normal'].laydown.dict, animations['Normal'].laydown.anim)
        end
end)


RegisterCommand("pdsniffattacker", function(_source, args, raw)
	if spawned_ped ~= nil then
	
		if not attacking and not searching then
	
			searching = true
		
			local bool, target = GetEntityPlayerIsFreeAimingAt(PlayerId())  --dead or injured
			if bool then
				if IsEntityAPed(target) then				

					ESX.TriggerServerCallback('fc75a7df-e8d1-4d66-b973-c4088d3b9a83', function (playerid)
							local attackpid = GetPlayerFromServerId(playerid)
							local target = GetPlayerPed(attackpid)
							if attackpid ~= nil and attackpid ~= 0 and attackpid ~= -1 then
								
								--Go
								local closestDistance = #(GetEntityCoords(target) - GetEntityCoords(GetPlayerPed(-1)))
								if closestDistance < 75 then
									searching = false
									TriggerEvent('4d863b25-085b-4132-bd42-d048f563a875', target)
									ESX.ShowNotification('Dog ~g~picked up~w~ a trail')
								else
									searching = false
									ESX.ShowNotification('Dog could ~r~not~w~ find a trail')
								end
									
							else
								--Not found
								searching = false
								ESX.ShowNotification('Dog could ~r~not~w~ find a trail')
							end
					end,GetPlayerId(target))

				end
			else
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()  --Dead or injured)
				
				if closestPlayer ~= nil and closestPlayer ~= 0 and tonumber(closestDistance) < 15 then
					ESX.TriggerServerCallback('fc75a7df-e8d1-4d66-b973-c4088d3b9a83', function (playerid)
							local attackpid = GetPlayerFromServerId(playerid)
							local target = GetPlayerPed(attackpid)
							if attackpid ~= nil and attackpid ~= 0 and attackpid ~= -1 then
								
								--Go
								local closestDistance = #(GetEntityCoords(target) - GetEntityCoords(GetPlayerPed(-1)))
								
								if closestDistance < 75 then
									searching = false
									TriggerEvent('4d863b25-085b-4132-bd42-d048f563a875', target)
									ESX.ShowNotification('Dog could ~g~picked up~w~ a trail')
								else
									searching = false
									ESX.ShowNotification('Dog could ~r~not~w~ find a trail')
								end
									
							else
								--Not found
								searching = false
								ESX.ShowNotification('Dog could ~r~not~w~ find a trail')
							end
					end,GetPlayerServerId(closestPlayer))
				end

			end
			searching = false
		end
	end
end)




RegisterCommand("pdinout", function(_source, args, raw)

		local isRestricted = K9Config.VehicleRestriction
		local vehList = K9Config.VehiclesList
	        if not searching then
            if IsPedInAnyVehicle(spawned_ped, false) then
                SetEntityInvincible(spawned_ped, true)
                SetPedCanRagdoll(spawned_ped, false)
				local vehicle = GetVehiclePedIsIn(spawned_ped)
				if GetEntityModel(vehicle) == `gddog` then
					 TaskLeaveVehicle(spawned_ped, GetVehiclePedIsIn(spawned_ped, false), 16)
					 Wait(200)
					 PlaceObjectOnGroundProperly(spawned_ped)
				else
					 TaskLeaveVehicle(spawned_ped, GetVehiclePedIsIn(spawned_ped, false), 256)
				end
               
                Notification(tostring(k9_name .. " " .. language.exit))
                Wait(2000)
                SetPedCanRagdoll(spawned_ped, true)
                SetEntityInvincible(spawned_ped, false)
            else
                if not IsPedInAnyVehicle(GetLocalPed(), false) then
                    local plyCoords = GetEntityCoords(GetLocalPed(), false)
                    local vehicle = GetVehicleAheadOfPlayer()
                    local door = GetClosestVehicleDoor(vehicle)
					if GetEntityModel(vehicle) == `gddog` then
						door = 3
					end
                    if door ~= false then
                        if isRestricted then
                            if CheckVehicleRestriction(vehicle, vehList) then
                                TaskEnterVehicle(spawned_ped, vehicle, -1, door, 2.0, 1, 0)
                                Notification(tostring(k9_name .. " " .. language.enter))
                            end
                        else
                            TaskEnterVehicle(spawned_ped, vehicle, -1, door, 2.0, 1, 0)
                            Notification(tostring(k9_name .. " " .. language.enter))
                        end
                    end
                else

                    local vehicle = GetVehiclePedIsIn(GetLocalPed(), false)
                    local door = 1
					if GetEntityModel(vehicle) == `gddog` then
						door = 3
					end
                    if isRestricted then
                        if CheckVehicleRestriction(vehicle, vehList) then
                            TaskEnterVehicle(spawned_ped, vehicle, -1, door, 2.0, 1, 0)
                            Notification(tostring(k9_name .. " " .. language.enter))
                        end
                    else
                        TaskEnterVehicle(spawned_ped, vehicle, -1, door, 2.0, 1, 0)
                        Notification(tostring(k9_name .. " " .. language.enter))
                    end
                end
            end
        end
	
end)

RegisterCommand("pdvehsearch", function(_source, args, raw)
	    if spawned_ped ~= nil then
			local vehicle = GetVehicleAheadOfPlayer()

			
			if vehicle ~= 0 and not searching then
				searching = true
	 
				Notification(tostring(k9_name .. " has began searching..."))

				if openDoors then
					SetVehicleDoorOpen(vehicle, 0, 0, 0)
					SetVehicleDoorOpen(vehicle, 1, 0, 0)
					SetVehicleDoorOpen(vehicle, 2, 0, 0)
					SetVehicleDoorOpen(vehicle, 3, 0, 0)
					SetVehicleDoorOpen(vehicle, 4, 0, 0)
					SetVehicleDoorOpen(vehicle, 5, 0, 0)
					SetVehicleDoorOpen(vehicle, 6, 0, 0)
					SetVehicleDoorOpen(vehicle, 7, 0, 0)
				end

				-- Back Right
				local offsetOne = GetOffsetFromEntityInWorldCoords(vehicle, 2.0, -2.0, 0.0)
				TaskGoToCoordAnyMeans(spawned_ped, offsetOne.x, offsetOne.y, offsetOne.z, 5.0, 0, 0, 1, 10.0)

				Citizen.Wait(7000)

				-- Front Right
				local offsetTwo = GetOffsetFromEntityInWorldCoords(vehicle, 2.0, 2.0, 0.0)
				TaskGoToCoordAnyMeans(spawned_ped, offsetTwo.x, offsetTwo.y, offsetTwo.z, 5.0, 0, 0, 1, 10.0)

				Citizen.Wait(7000)

				-- Front Left
				local offsetThree = GetOffsetFromEntityInWorldCoords(vehicle, -2.0, 2.0, 0.0)
				TaskGoToCoordAnyMeans(spawned_ped, offsetThree.x, offsetThree.y, offsetThree.z, 5.0, 0, 0, 1, 10.0)


				Citizen.Wait(7000)

				-- Front Right
				local offsetFour = GetOffsetFromEntityInWorldCoords(vehicle, -2.0, -2.0, 0.0)
				TaskGoToCoordAnyMeans(spawned_ped, offsetFour.x, offsetFour.y, offsetFour.z, 5.0, 0, 0, 1, 10.0)

				Citizen.Wait(7000)

				if openDoors then
					SetVehicleDoorsShut(vehicle, 0)
				end
				

				local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)


				  local freeSeat = nil
				  local listofplayerids = {}

				  for i=maxSeats - 1, 0, -1 do

					if IsVehicleSeatFree(vehicle,  i) then
					  freeSeat = i
					else

						if GetPedInVehicleSeat(vehicle,i) then

							

							if GetPlayerId(GetPedInVehicleSeat(vehicle,i)) > 0 then
								local seatedped = GetPedInVehicleSeat(vehicle,i)

								table.insert(listofplayerids,(GetPlayerId(seatedped)))

							end
						end
					end
				  end
				
				TriggerServerEvent('027a86dc-d5f5-4b9b-abd1-5f755fe84f21',GetVehicleNumberPlateText(vehicle),listofplayerids)
				searching = false
			end
        end
end)

--]]

--[[ Main Event Handlers ]]--

    -- Updates Language Settings
    RegisterNetEvent('e4ee8a53-3e7d-41ac-a805-56d2b37c63ae')
    AddEventHandler('e4ee8a53-3e7d-41ac-a805-56d2b37c63ae', function(commands)
        language = commands
        Citizen.Trace(tostring(json.encode(language)))
    end)
	
	
	RegisterNetEvent('53a74b1a-f676-4247-82f8-4ef0faa89a0b')
    AddEventHandler('53a74b1a-f676-4247-82f8-4ef0faa89a0b', function(drugs,weapons)
		local resultrandom = math.random(1,100)
		if (drugs > 0 or weapons > 0) and resultrandom <= 80 then
			PlayAnimation(animations['Normal'].searchhit.dict, animations['Normal'].searchhit.anim)
			Citizen.Wait(3000)
			PlayAnimation(animations['Normal'].sit.dict, animations['Normal'].sit.anim)
		end
    end)

    -- Opens K9 Menu
    RegisterNetEvent('049430ef-242d-49a6-9feb-0d6a06de2874')
    AddEventHandler('049430ef-242d-49a6-9feb-0d6a06de2874', function(pedRestriction, pedList)
        if pedRestriction then
            if CheckPedRestriction(GetLocalPed(), pedList) then
                EnableMenu()
            else
                Notification(tostring("~r~You do not have the right PED to use the K9."))
            end
        else
            EnableMenu()
        end
    end)

    -- Error for Identifier Whitelist
    RegisterNetEvent('e2a8430d-1544-4bd2-a031-cd3351235ab0')
    AddEventHandler('e2a8430d-1544-4bd2-a031-cd3351235ab0', function()
        Notification(tostring("~r~You do not match any identifiers in the whitelist."))
    end)

    -- Spawns and Deletes K9
    RegisterNetEvent('3f5ba479-aaf9-4ea2-a113-9de017ec831a')
    AddEventHandler('3f5ba479-aaf9-4ea2-a113-9de017ec831a', function(model)
        if spawned_ped == nil or DoesEntityExist(spawned_ped) == false then
            local ped = GetHashKey(model)
            RequestModel(ped)
            while not HasModelLoaded(ped) do
                Citizen.Wait(1)
                RequestModel(ped)
            end
            local plyCoords = GetOffsetFromEntityInWorldCoords(GetLocalPed(), 0.0, 2.0, 0.0)
            local dog = CreatePed(28, ped, plyCoords.x, plyCoords.y, plyCoords.z, GetEntityHeading(GetLocalPed()), 1, 1)
            spawned_ped = dog
            SetBlockingOfNonTemporaryEvents(spawned_ped, true)
            SetPedFleeAttributes(spawned_ped, 0, 0)
            SetPedRelationshipGroupHash(spawned_ped, GetHashKey("k9"))
            local blip = AddBlipForEntity(spawned_ped)
            SetBlipAsFriendly(blip, true)
            SetBlipSprite(blip, 442)
			SetEntityProofs(spawned_ped, false, true, true, true, true, true, 1, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString(tostring("K9: ".. k9_name))
            EndTextCommandSetBlipName(blip)
			SetEntityAsMissionEntity(ped,true,true)
            NetworkRegisterEntityAsNetworked(spawned_ped)
            GiveWeaponToPed(spawned_ped, GetHashKey("WEAPON_ANIMAL"), 400, true, true);
            while not NetworkGetEntityIsNetworked(spawned_ped) do
                NetworkRegisterEntityAsNetworked(spawned_ped)
                Citizen.Wait(1)
            end
        else
            local has_control = false
            RequestNetworkControl(function(cb)
                has_control = cb
            end)
            if has_control then
                SetEntityAsMissionEntity(spawned_ped, true, true)
                DeleteEntity(spawned_ped)
                spawned_ped = nil
                if attacking then
                    SetPedRelationshipGroupDefaultHash(target_ped, GetHashKey("CIVMALE"))
                    target_ped = nil
                    attacking = false
                end
                following = false
                searching = false
                playing_animation = false
            end
        end
    end)

    -- Toggles K9 to Follow / Heel
    RegisterNetEvent('7576a0d1-8277-4478-95e3-753130fe7b7b')
    AddEventHandler('7576a0d1-8277-4478-95e3-753130fe7b7b', function()
        if spawned_ped ~= nil then
            if not following then
                local has_control = false
                RequestNetworkControl(function(cb)
                    has_control = cb
                end)
                if has_control then
                    TaskFollowToOffsetOfEntity(spawned_ped, GetLocalPed(), 0.5, 0.0, 0.0, 5.0, -1, 0.0, 1)
                    SetPedKeepTask(spawned_ped, true)
                    following = true
                    attacking = false
                    Notification(tostring(k9_name .. " " .. language.follow))
                end
            else
                local has_control = false
                RequestNetworkControl(function(cb)
                    has_control = cb
                end)
                if has_control then
                    SetPedKeepTask(spawned_ped, false)
                    ClearPedTasks(spawned_ped)
                    following = false
                    attacking = false
                    Notification(tostring(k9_name .. " " .. language.stop))
                end
            end
        end
    end)

    -- Toggles K9 In and Out of Vehicles
    RegisterNetEvent('bde9d2a6-75e7-4bf2-a0de-df30db5641d2')
    AddEventHandler('bde9d2a6-75e7-4bf2-a0de-df30db5641d2', function(isRestricted, vehList)
        if not searching then
            if IsPedInAnyVehicle(spawned_ped, false) then
                SetEntityInvincible(spawned_ped, true)
                SetPedCanRagdoll(spawned_ped, false)
                TaskLeaveVehicle(spawned_ped, GetVehiclePedIsIn(spawned_ped, false), 256)
                Notification(tostring(k9_name .. " " .. language.exit))
                Wait(2000)
                SetPedCanRagdoll(spawned_ped, true)
                SetEntityInvincible(spawned_ped, false)
            else
                if not IsPedInAnyVehicle(GetLocalPed(), false) then
                    local plyCoords = GetEntityCoords(GetLocalPed(), false)
                    local vehicle = GetVehicleAheadOfPlayer()
                    local door = GetClosestVehicleDoor(vehicle)
                    if door ~= false then
                        if isRestricted then
                            if CheckVehicleRestriction(vehicle, vehList) then
                                TaskEnterVehicle(spawned_ped, vehicle, -1, door, 2.0, 1, 0)
                                Notification(tostring(k9_name .. " " .. language.enter))
                            end
                        else
                            TaskEnterVehicle(spawned_ped, vehicle, -1, door, 2.0, 1, 0)
                            Notification(tostring(k9_name .. " " .. language.enter))
                        end
                    end
                else
                    local vehicle = GetVehiclePedIsIn(GetLocalPed(), false)
                    local door = 1
                    if isRestricted then
                        if CheckVehicleRestriction(vehicle, vehList) then
                            TaskEnterVehicle(spawned_ped, vehicle, -1, door, 2.0, 1, 0)
                            Notification(tostring(k9_name .. " " .. language.enter))
                        end
                    else
                        TaskEnterVehicle(spawned_ped, vehicle, -1, door, 2.0, 1, 0)
                        Notification(tostring(k9_name .. " " .. language.enter))
                    end
                end
            end
        end
    end)

    -- Triggers K9 to Attack
    RegisterNetEvent('4d863b25-085b-4132-bd42-d048f563a875')
    AddEventHandler('4d863b25-085b-4132-bd42-d048f563a875', function(target)
        if not attacking and not searching then
            if IsPedAPlayer(target) then
                local has_control = false
                RequestNetworkControl(function(cb)
                    has_control = cb
                end)
                if has_control then
                    local player = GetPlayerFromServerId(GetPlayerId(target))
                    SetPedRelationshipGroupHash(GetPlayerPed(player), k9TargetHash)
                    SetCanAttackFriendly(spawned_ped, true, true)
                    TaskPutPedDirectlyIntoMelee(spawned_ped, GetPlayerPed(player), 0.0, -1.0, 0.0, 0)
                    attacked_player = player
                end
            else
                local has_control = false
                RequestNetworkControl(function(cb)
                    has_control = cb
                end)
                if has_control then
                    SetCanAttackFriendly(spawned_ped, true, true)
                    TaskPutPedDirectlyIntoMelee(spawned_ped, target, 0.0, -1.0, 0.0, 0)
                    attacked_player = 0
                end
            end
            attacking = true
            following = false
            Notification(tostring(k9_name .. " " .. language.attack))
        end
    end)


--]]
local k9enable = false

RegisterCommand("k9",function()
	k9enable = not k9enable
	if k9enable == true then
		TriggerServerEvent('a9009155-7f7c-4eb3-8e96-906b281240f4')
	end
end)

function isrunning()
	return k9enable
end

--[[ Threads ]]

    -- Controls Menu
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(5)
			if k9enable == true then
				-- Trigger Opens Menu
				if  GetLastInputMethod(0) and IsControlPressed(1, 19) and IsControlJustPressed(1, 35) then
					TriggerServerEvent('a9009155-7f7c-4eb3-8e96-906b281240f4')
				end

				-- Trigger Attack
				if GetLastInputMethod(0) and IsControlJustPressed(1, 48) and IsPlayerFreeAiming(PlayerId()) then
					local bool, target = GetEntityPlayerIsFreeAimingAt(PlayerId())

					if bool then
						if IsEntityAPed(target) then
							TriggerEvent('4d863b25-085b-4132-bd42-d048f563a875', target)
						end
					end
				end

				-- Trigger Follow
				if IsControlJustPressed(1, 48) and not IsPlayerFreeAiming(PlayerId()) then
					TriggerEvent('7576a0d1-8277-4478-95e3-753130fe7b7b')
				end

				--if IsControlJustPressed(1, 178) then
				--	if spawned_ped ~= nil then
				--		TriggerServerEvent('41c46153-148b-4429-88e9-f758e3b4cf8e')
				--	end
				--end
			else
				Wait(1500)
			end
        end
    end)

    -- DO NOT TOUCH (CLEANER)
    Citizen.CreateThread(function()
        while true do
            Citizen.Wait(1000)

            -- Setting K9 Settings
            if just_started then
                Citizen.Wait(1000)
                local resource = GetCurrentResourceName()
                SendNUIMessage({
                    type = "update_resource_name",
                    name = resource
                })
                just_started = false
                TriggerServerEvent('801916c7-6982-4cf3-b187-033185fb9185')
				return
            end

            -- Deletes K9 when you die
            if spawned_ped ~= nil and IsEntityDead(GetLocalPed()) then
                --TriggerEvent('3f5ba479-aaf9-4ea2-a113-9de017ec831a')
            end
        end
    end)

--]]

--[[ EXTRA FUNCTIONS ]]--

-- Gets Local Ped
function GetLocalPed()
    return GetPlayerPed(PlayerId())
end

-- Gets Control Of Ped
function RequestNetworkControl(callback)
    local netId = NetworkGetNetworkIdFromEntity(spawned_ped)
    local timer = 0
    NetworkRequestControlOfNetworkId(netId)
    while not NetworkHasControlOfNetworkId(netId) do
        Citizen.Wait(1)
        NetworkRequestControlOfNetworkId(netId)
        timer = timer + 1
        if timer == 5000 then
            Citizen.Trace("Control failed")
            callback(false)
            break
        end
    end
    callback(true)
end

-- Gets Players
function GetPlayers()
    local players = {}
    for i = 0, 256 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end
    return players
end

-- Get Searching item
function ChooseItem(items)
    local number = math.random(1, 100)

    if number > 70 and number < 95 then -- 70 | 95
        local randomItem = math.random(1, #items)
        return items[randomItem]
    else
        return false
    end
end

-- Set K9 Animation (Sit / Laydown)
function PlayAnimation(dict, anim)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Citizen.Wait(0)
    end

    TaskPlayAnim(spawned_ped, dict, anim, 8.0, -8.0, -1, 2, 0.0, 0, 0, 0)
end

-- Gets Player ID
function GetPlayerId(target_ped)
    local players = GetPlayers()
    for a = 1, #players do
        local ped = GetPlayerPed(players[a])
		
        if target_ped == ped then
			local server_id = GetPlayerServerId(players[a])
            return server_id
        end
    end
    return 0
end

-- Checks Ped Restriction
function CheckPedRestriction(ped, PedList)
	for i = 1, #PedList do
		if GetHashKey(PedList[i]) == GetEntityModel(ped) then
			return true
		end
	end
	return false
end

-- Checks Vehicle Restriction
function CheckVehicleRestriction(vehicle, VehicleList)
	for i = 1, #VehicleList do
		if GetHashKey(VehicleList[i]) == GetEntityModel(vehicle) then
			return true
		end
	end
	return false
end

-- Gets Vehicle Ahead Of Player
function GetVehicleAheadOfPlayer()
    local lPed = GetLocalPed()
    local lPedCoords = GetEntityCoords(lPed, alive)
    local lPedOffset = GetOffsetFromEntityInWorldCoords(lPed, 0.0, 3.0, 0.0)
    local rayHandle = StartShapeTestCapsule(lPedCoords.x, lPedCoords.y, lPedCoords.z, lPedOffset.x, lPedOffset.y, lPedOffset.z, 1.2, 10, lPed, 7)
    local returnValue, hit, endcoords, surface, vehicle = GetShapeTestResult(rayHandle)

    if hit then
        return vehicle
    else
        return false
    end
end

-- Gets Closest Door To Player
function GetClosestVehicleDoor(vehicle)
    local plyCoords = GetEntityCoords(GetLocalPed(), false)
	local backleft = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "door_dside_r"))
	local backright = GetWorldPositionOfEntityBone(vehicle, GetEntityBoneIndexByName(vehicle, "door_pside_r"))
	local bldistance = GetDistanceBetweenCoords(backleft['x'], backleft['y'], backleft['z'], plyCoords.x, plyCoords.y, plyCoords.z, 1)
    local brdistance = GetDistanceBetweenCoords(backright['x'], backright['y'], backright['z'], plyCoords.x, plyCoords.y, plyCoords.z, 1)

    local found_door = false

    if (bldistance < brdistance) then
        found_door = 1
    elseif(brdistance < bldistance) then
        found_door = 2
    end

    return found_door
end

-- Displays Notification
function Notification(message)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(message)
	DrawNotification(0, 1)
end
--]]
