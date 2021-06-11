local instance, instancedPlayers, registeredInstanceTypes, playersToHide = {}, {}, {}, {}
local instanceInvite, insideInstance
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function GetInstance()
	return instance
end

function CreateInstance(type, data)
	TriggerServerEvent('29f11c5d-c3e7-4eed-ba79-1f8d3004d5cf', type, data)
end

function CloseInstance()
	instance = {}
	TriggerServerEvent('20ca2c37-1b51-4c6a-8d50-0a8138cd56dd')
	insideInstance = false
end

function EnterInstance(instance)
	insideInstance = true
	TriggerServerEvent('5aa51e0a-2947-4f7b-9546-f2f21a85de65', instance.host)

	if registeredInstanceTypes[instance.type].enter then
		registeredInstanceTypes[instance.type].enter(instance)
	end
end

function LeaveInstance()
	if instance.host then
		if #instance.players > 1 then
			ESX.ShowNotification(_U('left_instance'))
		end

		if registeredInstanceTypes[instance.type].exit then
			registeredInstanceTypes[instance.type].exit(instance)
		end

		TriggerServerEvent('776e6c55-2138-42de-a67d-cc01398e765c', instance.host)
	end

	insideInstance = false
end

function InviteToInstance(type, player, data)
	TriggerServerEvent('79c58355-759c-41b1-b9e4-41fdc26285f8', instance.host, type, player, data)
end

function RegisterInstanceType(type, enter, exit)
	registeredInstanceTypes[type] = {
		enter = enter,
		exit  = exit
	}
end

AddEventHandler('b4f68f2c-6d0e-4de8-916b-b4b3857f3707', function(cb)
	cb(GetInstance())
end)

AddEventHandler('938957cb-f3e7-4cc1-b236-81a6544d274d', function(type, data)
	CreateInstance(type, data)
end)

AddEventHandler('158aa687-b03c-45f8-882d-764b3d4b7de7', function()
	CloseInstance()
end)

AddEventHandler('51fc5891-b4b6-487b-b241-944c24796f10', function(_instance)
	EnterInstance(_instance)
end)

AddEventHandler('910afdde-9300-4092-9c9f-a0beb6fa1127', function()
	LeaveInstance()
end)

AddEventHandler('d2ea6153-b91f-4d0f-af1a-3d638a340db9', function(type, player, data)
	InviteToInstance(type, player, data)
end)

AddEventHandler('6f22e07f-350a-4dfe-81fd-eda5b736d047', function(name, enter, exit)
	RegisterInstanceType(name, enter, exit)
end)

RegisterNetEvent('a9b0f7c5-8d73-4527-8c8b-14fe9dd15e84')
AddEventHandler('a9b0f7c5-8d73-4527-8c8b-14fe9dd15e84', function(_instancedPlayers)
	instancedPlayers = _instancedPlayers
end)

RegisterNetEvent('328202da-e4de-4ee1-bddf-63ae1f0cffe9')
AddEventHandler('328202da-e4de-4ee1-bddf-63ae1f0cffe9', function(_instance)
	instance = {}
end)

RegisterNetEvent('bc5d0c94-3d48-467a-854a-84634ac40e73')
AddEventHandler('bc5d0c94-3d48-467a-854a-84634ac40e73', function(_instance)
	instance = _instance
end)

RegisterNetEvent('3ea3ea6f-99ad-40d5-b77b-e327e0e54281')
AddEventHandler('3ea3ea6f-99ad-40d5-b77b-e327e0e54281', function(_instance)
	instance = {}
end)

RegisterNetEvent('89854248-8705-4c04-9b20-a8adfef76686')
AddEventHandler('89854248-8705-4c04-9b20-a8adfef76686', function(_instance)
	instance = {}
end)

RegisterNetEvent('362c7471-1500-48b0-b24e-af4e7975feb0')
AddEventHandler('362c7471-1500-48b0-b24e-af4e7975feb0', function(_instance, player)
	instance = _instance
	local playerName = GetPlayerName(GetPlayerFromServerId(player))

	ESX.ShowNotification(_('entered_into', playerName))
end)

RegisterNetEvent('12ebf9f8-7ed6-4609-8c3a-4d0841a70300')
AddEventHandler('12ebf9f8-7ed6-4609-8c3a-4d0841a70300', function(_instance, player)
	instance = _instance
	local playerName = GetPlayerName(GetPlayerFromServerId(player))

	ESX.ShowNotification(_('left_out', playerName))
end)

RegisterNetEvent('a380f720-dcb2-44d6-a14f-e391107bb9bf')
AddEventHandler('a380f720-dcb2-44d6-a14f-e391107bb9bf', function(_instance, type, data)
	instanceInvite = {
		type = type,
		host = _instance,
		data = data
	}

	Citizen.CreateThread(function()
		Citizen.Wait(12000)

		if instanceInvite then
			ESX.ShowNotification(_U('invite_expired'))
			instanceInvite = nil
		end
	end)
end)

RegisterInstanceType('default')

-- Controls for invite
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if instanceInvite then
			ESX.ShowHelpNotification(_U('press_to_enter'))

			if IsControlJustReleased(0, 38) then
				EnterInstance(instanceInvite)
				ESX.ShowNotification(_U('entered_instance'))
				instanceInvite = nil
			end
		else
			Citizen.Wait(1000)
		end
	end
end)

-- Instance players
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if insideInstance == true then
			playersToHide = {}
			if instance.host then
				-- Get players and sets them as pairs
				for k,v in ipairs(GetActivePlayers()) do
					playersToHide[GetPlayerServerId(v)] = true
				end

				-- Dont set our instanced players invisible
				for _,player in ipairs(instance.players) do
					playersToHide[player] = nil
				end
			else
				for player,_ in pairs(instancedPlayers) do
					playersToHide[player] = true
				end
			end
		else
			Wait(1500)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if insideInstance == true then
			local playerPed = PlayerPedId()
			
			-- Hide all these players
			for serverId,_ in pairs(playersToHide) do
				local player = GetPlayerFromServerId(serverId)

				if NetworkIsPlayerActive(player) then
					local otherPlayerPed = GetPlayerPed(player)
					SetEntityVisible(otherPlayerPed, false, false)
					SetEntityNoCollisionEntity(playerPed, otherPlayerPed, false)
				end
			end
		else
			Wait(1500)
		end
	end
end)

Citizen.CreateThread(function()
	TriggerEvent('71416c08-0e16-4e8d-89d0-3e4c3ad884f9')
end)

-- Fix vehicles randomly spawning nearby the player inside an instance
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0) -- must be run every frame

		if insideInstance then
			SetVehicleDensityMultiplierThisFrame(0.0)
			SetParkedVehicleDensityMultiplierThisFrame(0.0)

			local pos = GetEntityCoords(PlayerPedId())
			RemoveVehiclesFromGeneratorsInArea(pos.x - 900.0, pos.y - 900.0, pos.z - 900.0, pos.x + 900.0, pos.y + 900.0, pos.z + 900.0)
		else
			Citizen.Wait(1500)
		end
	end
end)