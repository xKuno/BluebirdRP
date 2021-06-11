--inital setting of weed props for cache

ESX        = nil
cachedPlant = {}
closestPlant = {
    GetHashKey('Prop_weed_01'),
    GetHashKey('bkr_prop_weed_lrg_01a'),
    GetHashKey('bkr_prop_weed_lrg_01b'),
    GetHashKey('bkr_prop_weed_med_01a'),
    GetHashKey('bkr_prop_weed_med_01b'),
    GetHashKey('bkr_prop_weed_01_small_01a'),
    GetHashKey('bkr_prop_weed_01_small_01b'),
    GetHashKey('bkr_prop_weed_01_small_01c')


}

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(60000)
        cachedPlant = {}
    end
end)

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(5)

		TriggerEvent('esx:getSharedObject', function(library)
			ESX = library
		end)
    end

    if ESX.IsPlayerLoaded() then
		ESX.PlayerData = ESX.GetPlayerData()
	end
end)

RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(response)
	ESX.PlayerData = response
end)

--user interaction and ShowNotification

Citizen.CreateThread(function()
    while true do
        
        local sleep = 2000
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        
        for i = 1, #closestPlant do
            local x = GetClosestObjectOfType(playerCoords, 2.0, closestPlant[i], false, false, false)
            local entity = nil
            if DoesEntityExist(x) then
                entity = x
                Plant    = GetEntityCoords(entity)
                sleep  = 5
                DrawText3D(Plant.x, Plant.y, Plant.z + 1.5, 'Press [~g~E~s~] to harvest the ~b~weed~s~')  
                if IsControlJustReleased(0, 38) then
                    if not cachedPlant[entity] then
                        OpenPlant(entity)
                    else
                        ESX.ShowNotification('~r~This plant has already been harvested.~s~')
                    end
                end
                break
            else
                sleep = 2000
            end
        end
        Citizen.Wait(sleep)
    end
end)