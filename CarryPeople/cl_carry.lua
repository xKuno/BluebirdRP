local carryingBackInProgress = false
local piggyBackInProgress = false

RegisterCommand("carry",function(source, args)
	print("carrying")
	if not exports.esx_policejob:amicuffed()then
		if not carryingBackInProgress then
			
			carryingBackInProgress = true
			local player = PlayerPedId()	
			if IsPedRagdoll(player) == false then
				lib = 'missfinale_c2mcs_1'
				anim1 = 'fin_c2_mcs_1_camman'
				lib2 = 'nm'
				anim2 = 'firemans_carry'
				distans = 0.15
				distans2 = 0.27
				height = 0.63
				spin = 0.0		
				length = 100000
				controlFlagMe = 49
				controlFlagTarget = 33
				animFlagTarget = 1
				local closestPlayer = GetClosestPlayer(3)
				target = GetPlayerServerId(closestPlayer)
				if closestPlayer ~= nil and closestPlayer ~= -1 and IsPedInAnyVehicle(target,false) == false then

					TriggerServerEvent('92d67f19-9ed3-4da7-bf24-a692977562d6', closestPlayer, lib,lib2, anim1, anim2, distans, distans2, height,target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget)
				else

				end
			end
		else
			carryingBackInProgress = false
			ClearPedSecondaryTask(GetPlayerPed(-1))
			DetachEntity(GetPlayerPed(-1), true, false)
			local closestPlayer = GetClosestPlayer(3)
			target = GetPlayerServerId(closestPlayer)
			TriggerServerEvent('ea9c8581-f722-4591-9209-16bff7c964cf',target)
		end
	end
end,false)

RegisterCommand("piggyback",function(source, args)
	if not exports.esx_policejob:amicuffed() then
		if not piggyBackInProgress then
			piggyBackInProgress = true
			local player = PlayerPedId()	
			lib = 'anim@arena@celeb@flat@paired@no_props@'
			anim1 = 'piggyback_c_player_a'
			anim2 = 'piggyback_c_player_b'
			distans = -0.07
			distans2 = 0.0
			height = 0.45
			spin = 0.0		
			length = 100000
			controlFlagMe = 49
			controlFlagTarget = 33
			animFlagTarget = 1
			local closestPlayer = GetClosestPlayer(3)
			target = GetPlayerServerId(closestPlayer)
			if closestPlayer ~= nil then
				print("triggering cmg2_animations:sync")
				TriggerServerEvent('92d67f19-9ed3-4da7-bf24-a692977562d6', closestPlayer, lib, anim1, anim2, distans, distans2, height,target,length,spin,controlFlagMe,controlFlagTarget,animFlagTarget)
			else
				print("[CMG Anim] No player nearby")
			end
		else
			piggyBackInProgress = false
			ClearPedSecondaryTask(GetPlayerPed(-1))
			DetachEntity(GetPlayerPed(-1), true, false)
			local closestPlayer = GetClosestPlayer(3)
			target = GetPlayerServerId(closestPlayer)
			TriggerServerEvent('ea9c8581-f722-4591-9209-16bff7c964cf',target)
		end
	end
end,false)

RegisterNetEvent('261819c2-4470-452c-8077-d500150b7030')
AddEventHandler('261819c2-4470-452c-8077-d500150b7030', function(target, animationLib, animation2, distans, distans2, height, length,spin,controlFlag)
	local playerPed = GetPlayerPed(-1)
	local targetPed = GetPlayerPed(GetPlayerFromServerId(target))
	carryingBackInProgress = true
	print("triggered cmg2_animations:syncTarget")
	RequestAnimDict(animationLib)

	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	if spin == nil then spin = 180.0 end
	AttachEntityToEntity(GetPlayerPed(-1), targetPed, 0, distans2, distans, height, 0.5, 0.5, spin, false, false, false, false, 2, false)
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation2, 8.0, -8.0, length, controlFlag, 0, false, false, false)
end)

RegisterNetEvent('407798fd-6f6b-4eca-a04b-5a5d4d5b56a3')
AddEventHandler('407798fd-6f6b-4eca-a04b-5a5d4d5b56a3', function(animationLib, animation,length,controlFlag,animFlag)
	local playerPed = GetPlayerPed(-1)
	print("triggered cmg2_animations:syncMe")
	RequestAnimDict(animationLib)

	while not HasAnimDictLoaded(animationLib) do
		Citizen.Wait(10)
	end
	Wait(500)
	if controlFlag == nil then controlFlag = 0 end
	TaskPlayAnim(playerPed, animationLib, animation, 8.0, -8.0, length, controlFlag, 0, false, false, false)

	Citizen.Wait(length)
end)

RegisterNetEvent('1c84c67a-b2a1-4ac8-9d2d-cc89be6347f6')
AddEventHandler('1c84c67a-b2a1-4ac8-9d2d-cc89be6347f6', function()
	carryingBackInProgress = false
	ClearPedSecondaryTask(GetPlayerPed(-1))
	DetachEntity(GetPlayerPed(-1), true, false)
end)


RegisterNetEvent('7e33f7c3-9458-48ee-83c7-65903ad8daa1')
AddEventHandler('7e33f7c3-9458-48ee-83c7-65903ad8daa1', function()
	carryingBackInProgress = false
	ClearPedSecondaryTask(GetPlayerPed(-1))
	DetachEntity(GetPlayerPed(-1), true, false)
end)

function GetPlayers()
    local players = {}

    for i = 0, 255 do
        if NetworkIsPlayerActive(i) then
            table.insert(players, i)
        end
    end

    return players
end

function GetClosestPlayer(radius)
    local players = GetPlayers()
    local closestDistance = -1
    local closestPlayer = -1
    local ply = GetPlayerPed(-1)
    local plyCoords = GetEntityCoords(ply, 0)

    for index,value in ipairs(players) do
        local target = GetPlayerPed(value)
        if(target ~= ply) then
            local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
            local distance = GetDistanceBetweenCoords(targetCoords['x'], targetCoords['y'], targetCoords['z'], plyCoords['x'], plyCoords['y'], plyCoords['z'], true)
            if(closestDistance == -1 or closestDistance > distance) then
                closestPlayer = value
                closestDistance = distance
            end
        end
    end
	print("closest player is dist: " .. tostring(closestDistance))
	if closestDistance <= radius then
		return closestPlayer
	else
		return nil
	end
end