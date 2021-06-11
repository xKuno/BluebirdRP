local wasmenuopen = false

Citizen.CreateThread(function()
	while true do
			Wait(1300)
			if IsPauseMenuActive() and not wasmenuopen then
				local ped = PlayerPedId()
				if IsEntityVisible(ped) and GetEntityAlpha(ped) > 80 then
					SetCurrentPedWeapon(GetPlayerPed(-1), 0xA2719263, true) -- set unarmed
					TriggerEvent( "Map:ToggleMap")
					--TaskStartScenarioInPlace(GetPlayerPed(-1), "WORLD_HUMAN_TOURIST_MAP", 0, false) -- Start the scenario
					wasmenuopen = true
				end
			end
			
			if not IsPauseMenuActive() and wasmenuopen then
					Wait(2000)
					TriggerEvent(  "Map:ToggleMap")
					wasmenuopen = false
			end
	end
end)

local holdingMap = false
local mapModel = `prop_tourist_map_01`
local animDict = "amb@world_human_tourist_map@male@base"
local animName = "base"
local map_net = nil
mapspawned = nil

-- Toggle Map --

RegisterNetEvent(  "Map:ToggleMap")
AddEventHandler(  "Map:ToggleMap", function()
    if not holdingMap then
        RequestModel(mapModel)
        while not HasModelLoaded(mapModel) do
            Citizen.Wait(100)
        end

        RequestAnimDict(animDict)
        while not HasAnimDictLoaded(animDict) do
            Citizen.Wait(100)
        end
		

        local plyCoords = GetOffsetFromEntityInWorldCoords(GetPlayerPed(PlayerId()), 0.0, 0.0, -5.0)
		if mapspawned == nil then
			mapspawned = CreateObject(mapModel, plyCoords.x, plyCoords.y, plyCoords.z, 1, 1, 1)
		end
        Citizen.Wait(1000)
		pcall(function()
        local netid = ObjToNet(mapspawned)
        SetNetworkIdExistsOnAllMachines(netid, true)
        NetworkSetNetworkIdDynamic(netid, true)
        SetNetworkIdCanMigrate(netid, false)
		end)
		pcall(function()
			AttachEntityToEntity(mapspawned, GetPlayerPed(PlayerId()), GetPedBoneIndex(GetPlayerPed(PlayerId()), 28422), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)
		end)
        TaskPlayAnim(GetPlayerPed(PlayerId()), 1.0, -1, -1, 50, 0, 0, 0, 0) -- 50 = 32 + 16 + 2
        TaskPlayAnim(GetPlayerPed(PlayerId()), animDict, animName, 1.0, -1, -1, 50, 0, 0, 0, 0)
        map_net = netid
        holdingMap = true
    else
        ClearPedSecondaryTask(GetPlayerPed(PlayerId()))
        DetachEntity(NetToObj(map_net), 1, 1)
        DeleteEntity(NetToObj(map_net))
		if DoesEntityExist(mapspawned) then
			DeleteEntity(mapspawned)
		end
		mapspawned = nil
        map_net = nil
        holdingMap = false
    end
end)
