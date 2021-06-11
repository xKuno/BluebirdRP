ESX          = nil
local IsDead = false
local IsAnimated = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

AddEventHandler('c6e87694-49b4-4ca5-bb88-c50428b41343', function()
	TriggerEvent('bae0cb2f-301a-47ca-8ab4-355c43902da8', 'hunger', 500000)
	TriggerEvent('bae0cb2f-301a-47ca-8ab4-355c43902da8', 'thirst', 500000)
end)

RegisterNetEvent('9f2a9354-fd34-4282-a78f-4154fc7e71ea')
AddEventHandler('9f2a9354-fd34-4282-a78f-4154fc7e71ea', function()
	-- restore hunger & thirst
	TriggerEvent('bae0cb2f-301a-47ca-8ab4-355c43902da8', 'hunger', 1000000)
	TriggerEvent('bae0cb2f-301a-47ca-8ab4-355c43902da8', 'thirst', 1000000)

	-- restore hp
	local sourcePed = GetPlayerPed(-1)
	SetEntityHealth(sourcePed, 200)
end)

AddEventHandler('2df4c490-68a8-4c7e-896a-9fc552e16210', function()
	IsDead = true
end)

AddEventHandler('880c0a93-b305-46b3-b84c-a120fee9e841', function(spawn)
	if IsDead then
		TriggerEvent('c6e87694-49b4-4ca5-bb88-c50428b41343')
	end

	IsDead = false
end)

AddEventHandler('8775fded-dc97-4658-a3f2-1a1e4787535d', function(status)

	TriggerEvent('b9b1be21-5482-41d7-bd83-71d4f8e32d8f', 'hunger', 1000000, '#CFAD0F',
		function(status)
			return false
		end, function(status)
			status.remove(100)
		end
	)

	TriggerEvent('b9b1be21-5482-41d7-bd83-71d4f8e32d8f', 'thirst', 1000000, '#0C98F1',
		function(status)
			return false
		end, function(status)
			status.remove(75)
		end
	)

	Citizen.CreateThread(function()

		while true do
			Citizen.Wait(2000)

			local playerPed  = GetPlayerPed(-1)
			local prevHealth = GetEntityHealth(playerPed)
			local health     = prevHealth

			TriggerEvent('96cc2e86-0b6a-4092-b5c5-9d8057130449', 'hunger', function(status)
				if status.val == 0 then

					if prevHealth <= 150 then
						health = health - 10
					else
						health = health - 2
					end
				end
			end)

			TriggerEvent('96cc2e86-0b6a-4092-b5c5-9d8057130449', 'thirst', function(status)
				if status.val == 0 then

					if prevHealth <= 150 then
						health = health - 10
					else
						health = health - 2
					end
				end
			end)

			if health ~= prevHealth then
				SetEntityHealth(playerPed,  health)
			end
		end
	end)
end)

AddEventHandler('208acf57-5a0b-43a2-a59a-461d2e737f70', function(cb)
	cb(IsAnimated)
end)

RegisterNetEvent('e4412b28-973b-4968-9b75-48754ac59265')
AddEventHandler('e4412b28-973b-4968-9b75-48754ac59265', function(prop_name)
	if not IsAnimated then
		local prop_name = prop_name or 'prop_cs_burger_01'
		IsAnimated = true
		local playerPed = GetPlayerPed(-1)
		Citizen.CreateThread(function()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2,  true, true, true)
			AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
			RequestAnimDict('mp_player_inteat@burger')
			while not HasAnimDictLoaded('mp_player_inteat@burger') do
				Citizen.Wait(10)
			end
			TaskPlayAnim(playerPed, 'mp_player_inteat@burger', 'mp_player_int_eat_burger_fp', 8.0, -8, -1, 49, 0, 0, 0, 0)
			Citizen.Wait(3000)
			IsAnimated = false
			ClearPedSecondaryTask(playerPed)
			DeleteObject(prop)
		end)
	end
end)

RegisterNetEvent('6332b8f8-f4c5-43e0-98ce-89bed0fcc3c7')
AddEventHandler('6332b8f8-f4c5-43e0-98ce-89bed0fcc3c7', function(prop_name)
	if not IsAnimated then
		local prop_name = prop_name or 'prop_ld_flow_bottle'
		IsAnimated = true
		local playerPed = GetPlayerPed(-1)
		Citizen.CreateThread(function()
			local x,y,z = table.unpack(GetEntityCoords(playerPed))
			prop = CreateObject(GetHashKey(prop_name), x, y, z+0.2, true, true, true)
			AttachEntityToEntity(prop, playerPed, GetPedBoneIndex(playerPed, 18905), 0.12, 0.028, 0.001, 10.0, 175.0, 0.0, true, true, false, true, 1, true)
			RequestAnimDict('mp_player_intdrink')  
			while not HasAnimDictLoaded('mp_player_intdrink') do
				Citizen.Wait(10)
			end
			TaskPlayAnim(playerPed, 'mp_player_intdrink', 'loop_bottle', 1.0, -1.0, 2000, 0, 1, true, true, true)
			Citizen.Wait(3000)
			IsAnimated = false
			ClearPedSecondaryTask(playerPed)
			DeleteObject(prop)
		end)
	end
end)