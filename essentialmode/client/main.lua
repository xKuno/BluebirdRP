--       Licensed under: AGPLv3        --
--  GNU AFFERO GENERAL PUBLIC LICENSE  --
--     Version 3, 19 November 2007     --



local oldPos = vector3(0,0,0)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(math.random(40000,120000))
		local pos = GetEntityCoords(PlayerPedId())
		if #(oldPos - pos) > 50 then

			if(oldPos ~= pos)then
				TriggerServerEvent('157a0b53-eb40-47a4-a444-8ac52dc99aed', pos.x, pos.y, pos.z)
				oldPos = pos
			end
		end
	end
end)

local allowedtokill = true
local kthread = nil

--Anti RDM
Citizen.CreateThread(function()
	while true do
		local myped = GetPlayerPed(-1)
		local myid = PlayerId()
		if IsPedInAnyVehicle(myped) then
			local speed = GetEntitySpeed(GetVehiclePedIsIn(myped))
			if speed > 10 then
				local mycoords = GetEntityCoords(myped)
				mycoords = GetEntityCoords(GetVehiclePedIsIn(myped),true)
				for _, i in ipairs(GetActivePlayers()) do
					local ped = GetPlayerPed(i)

					local othrped = GetEntityCoords(ped)

					
					if myid == i then

					elseif #(othrped - mycoords) >= 4.5 and #(othrped - mycoords) <= 10.0 and IsPedInAnyVehicle(ped,true) == false and speed > 80 then
						TriggerEvent('07da2d3f-8b0d-405f-b039-8e894adda985', '~o~ANTI VDM\n~w~Activated')	
						SetEntityNoCollisionEntity(GetVehiclePedIsIn(myped),ped, false)
						SetEntityCollision(GetVehiclePedIsIn(myped),false,false)
						SetVehicleForwardSpeed(GetVehiclePedIsIn(myped), 0.0)
						FreezeEntityPosition(GetVehiclePedIsIn(myped), true)
						local count = 80
						while count > 0 do
							SetEntityNoCollisionEntity(GetVehiclePedIsIn(myped),ped, false)
							SetVehicleForwardSpeed(GetVehiclePedIsIn(myped), 3.0)
							count = count - 1
							Wait(0)
						end
						SetEntityCollision(GetVehiclePedIsIn(myped),true,true)
						SetVehicleOnGroundProperly(GetVehiclePedIsIn(myped))
						FreezeEntityPosition(GetVehiclePedIsIn(myped), false)
					elseif #(othrped - mycoords) <= 4.5 and IsPedInAnyVehicle(ped,true) == false then
						TriggerEvent('07da2d3f-8b0d-405f-b039-8e894adda985', '~o~ANTI VDM\n~w~Activated')	
						SetEntityNoCollisionEntity(GetVehiclePedIsIn(myped),ped, false)
						SetEntityCollision(GetVehiclePedIsIn(myped),false,false)
						SetEntityCollision(GetVehiclePedIsIn(myped),false,false)
						SetVehicleForwardSpeed(GetVehiclePedIsIn(myped), 0.0)
						FreezeEntityPosition(GetVehiclePedIsIn(myped), true)
						local count = 80
						while count > 0 do
							SetEntityNoCollisionEntity(GetVehiclePedIsIn(myped),ped, false)
							SetVehicleForwardSpeed(GetVehiclePedIsIn(myped), 3.0)
							count = count - 1
							Wait(0)
						end
						SetEntityCollision(GetVehiclePedIsIn(myped),true,true)
						SetVehicleOnGroundProperly(GetVehiclePedIsIn(myped))
						FreezeEntityPosition(GetVehiclePedIsIn(myped), false)
					end
				end
			end
		else
			Wait(1500)
		end
		if allowedtokill == true then
			return
		end
		Wait(0)
	end
end)

RegisterNetEvent('6324cb02-fed7-422b-9579-00fb5935feb7')
AddEventHandler('6324cb02-fed7-422b-9579-00fb5935feb7', function(value)
	allowedtokill = value
	
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5000)
		NetworkSetFriendlyFireOption(allowedtokill)
		for _, i in ipairs(GetActivePlayers()) do
			if NetworkIsPlayerActive(i) then
				SetCanAttackFriendly(GetPlayerPed(i), allowedtokill, allowedtokill)
				
			end
			Citizen.Wait(10)
		end
		
	end
end)

local myDecorators = {}

RegisterNetEvent('67c04d0e-1327-435b-a49a-c40ab21016c6')
AddEventHandler('67c04d0e-1327-435b-a49a-c40ab21016c6', function(key, value, doNow)
	myDecorators[key] = value
	DecorRegister(key, 3)

	if(doNow)then
		DecorSetInt(PlayerPedId(), key, value)
	end
end)

AddEventHandler('880c0a93-b305-46b3-b84c-a120fee9e841', function()
	for k,v in pairs(myDecorators)do
		DecorSetInt(PlayerPedId(), k, v)
	end

	TriggerServerEvent('6ceb3611-40fd-49c6-9a01-f702a7b9e5a1')
end)

