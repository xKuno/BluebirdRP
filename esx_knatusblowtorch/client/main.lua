ESX               = nil
local blowtorching = false
local clearweld = false
local dooropen = false
local blowtorchingtime = 300
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(xPlayer)
  PlayerData = xPlayer
end)

-----

RegisterNetEvent('a606fb16-ef69-41f5-992f-3d80dc668430')
AddEventHandler('a606fb16-ef69-41f5-992f-3d80dc668430', function(source)
	blowtorchAnimation()
	Citizen.CreateThread(function()
		while true do
			if blowtorching then
				DisableControlAction(0, 73,   true) -- LookLeftRight
			end
			Citizen.Wait(10)
		end
	end)
end)

RegisterNetEvent('eff21ad7-ab3e-404e-8a53-1e0d3bb836a3')
AddEventHandler('eff21ad7-ab3e-404e-8a53-1e0d3bb836a3', function(source)
	clearweld = false
end)


RegisterNetEvent('f7357c66-e1fe-469a-a14e-02eb98b21a23')
AddEventHandler('f7357c66-e1fe-469a-a14e-02eb98b21a23', function(x,y,z)
		--ESX.ShowNotification(' llego')
		clearweld = true
		Citizen.CreateThread(function()
			while clearweld do
				Wait(1000)
				local weld = ESX.Game.GetClosestObject('prop_weld_torch', {x=x,y=y,z=z})
				ESX.Game.DeleteObject(weld)
			end
		end)
end)

RegisterNetEvent('f82866a4-fb67-4b57-9279-0174915e692e')
AddEventHandler('f82866a4-fb67-4b57-9279-0174915e692e', function()
	blowtorching = false
	blowtorchingtime = 0
	ClearPedTasksImmediately(GetPlayerPed(-1))
	ESX.ShowNotification('cancel blowtorch')
end)

--RegisterNetEvent('6524089c-baf7-473d-b71f-cf8fa6c0e75a')
--AddEventHandler('6524089c-baf7-473d-b71f-cf8fa6c0e75a', function(x,y,z)
	--Citizen.CreateThread(function()
	--while dooropen do
		--Wait(5000)
		--ESX.ShowNotification('abrete sesamo')
		--local obs, distance = ESX.Game.GetClosestObject('V_ILEV_GB_VAULDR', {x,y,z})
		--local pos = GetEntityCoords(obs);
		--ESX.ShowNotification(' hola' .. distance)
		--SetEntityHeading(obs, GetEntityHeading(obs) + 70.0)
	--end
	--end)
--end)

function blowtorchAnimation()
	local playerPed = GetPlayerPed(-1)
	blowtorchingtime = 300
	local coords = GetEntityCoords(playerPed)
	TriggerServerEvent('99142bbf-a2ff-4bae-a8ab-224daf696642', {coords.x, coords.y, coords.z})
	Citizen.CreateThread(function()
			blowtorching = true
			Citizen.CreateThread(function()
				while blowtorching do
						Wait(2000)
						--local weld = ESX.Game.GetClosestObject('prop_weld_torch', GetEntityCoords(GetPlayerPed(-1)))
						--ESX.Game.DeleteObject(weld)
						TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
						ESX.ShowNotification('Started Breaking in')
						blowtorchingtime = blowtorchingtime - 1
						if blowtorchingtime <= 0 then
							blowtorching = false
							ClearPedTasksImmediately(PlayerPedId())
							ESX.ShowNotification('Not Breaking in')
						end
				end
			end)
			
			--while blowtorching do
				--TaskPlayAnim(playerPed, "amb@world_human_const_blowtorch@male@blowtorch@base", "base", 2.0, 1.0, 5000, 5000, 1, true, true, true)
				TaskPlayAnim(playerPed, "atimetable@reunited@ig_7", "thanksdad_bag_02", 2.0, 1.0, 5000, 5000, 1, true, true, true)
				--if IsControlJustReleased(1, 51) then
					
				--end
			--end
		--end
	end)
end

--[[function blowtorchAnimation()
	ESX.ShowNotification(' llego')
	local playerPed = GetPlayerPed(-1)
	Citizen.CreateThread(function()
	--while true do	
		--Wait(100)
		
		while true do	
		Wait(100)
		end
	--end
	end)
	--anim@heists@fleeca_bank@blowtorching
	--blowtorch_right_door
	--amb@lo_res_idles@
	--world_human_const_blowtorch_lo_res_base
end

--[[
TASK_PLAY_ANIM(Ped ped, char* animDictionary, char* animationName, float speed, float speedMultiplier, int duration, int flag, float playbackRate, BOOL lockX, BOOL lockY, BOOL lockZ);


]]--