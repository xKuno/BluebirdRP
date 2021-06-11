RegisterNetEvent('ee3ad84a-3183-4fc9-ac10-9c149304c24f')
AddEventHandler('ee3ad84a-3183-4fc9-ac10-9c149304c24f', function()
	menuEnabled = false
	Citizen.Wait(100)
	SetNuiFocus( false )
    DoScreenFadeOut(1000)
  	-- Here is where you set where you want to player to spawn after they complete the tutorial
    SetEntityCoords(GetPlayerPed(-1), tonumber("-257.376"), tonumber("-980.052"), tonumber("31.22"), 1, 0, 0, 1)
    Citizen.Wait(1000)
    DoScreenFadeIn(1000)   
	
Citizen.CreateThread(function()


		 Citizen.Wait(1000)
		 TriggerEvent('fac6da70-a2c5-4757-a5e2-1d4d9e6b56c6')

	end)
	
end)




