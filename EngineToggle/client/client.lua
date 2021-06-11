-- CLIENTSIDED




-- The watermark text --
aservername = "Vehicle is OFF - Press U to start."

-- The x and y offset (starting at the top left corner) --
-- Default: 0.005, 0.001
aoffset = {x = 0.009, y = 0.34}

-- Text RGB Color --
-- Default: 64, 64, 64 (gray)
argb = {r = 255, g = 255, b = 102}

-- Text transparency --
-- Default: 255
aalpha = 200

-- Text scale
-- Default: 0.4
-- NOTE: Number needs to be a float (so instead of 1 do 1.0)
ascale = 0.4

-- Text Font --
-- 0 - 5 possible
-- Default 0
afont = 0

-- Rainbow Text --
-- false: Turn off
-- true: Activate rainbow text (overrides color)
abringontherainbows = true


-- Registers a network event
RegisterNetEvent('e3650cfc-b5cd-4d0a-a9ab-4b76a38a7958')
RegisterNetEvent('f97ad559-7b81-49f8-aae8-bda8ec87029f')

local vehicles = {}; RPWorking = true


RegisterCommand("engine", function(source, args, raw)
   TriggerEvent('e3650cfc-b5cd-4d0a-a9ab-4b76a38a7958')
end)

Citizen.CreateThread(function()
	while true do
		if UseKey and ToggleKey then
			if IsControlJustReleased(1, ToggleKey) then
				TriggerEvent('e3650cfc-b5cd-4d0a-a9ab-4b76a38a7958')
			end
		end
		Wait(5)
	end
end)


Citizen.CreateThread(function()
	local waittimer = 500
	while true do
		Citizen.Wait(waittimer)
		local ped = PlayerPedId()
		if GetSeatPedIsTryingToEnter(ped) == -1 and not table.contains(vehicles, GetVehiclePedIsTryingToEnter(ped)) then
			table.insert(vehicles, {GetVehiclePedIsTryingToEnter(ped), IsVehicleEngineOn(GetVehiclePedIsTryingToEnter(ped))})
		elseif IsPedInAnyVehicle(ped, false) and not table.contains(vehicles, GetVehiclePedIsIn(ped, false)) then
			table.insert(vehicles, {GetVehiclePedIsIn(GetPlayerPed(-1), false), IsVehicleEngineOn(GetVehiclePedIsIn(ped, false))})
		end
		for i, vehicle in ipairs(vehicles) do
			if DoesEntityExist(vehicle[1]) then
				if (GetPedInVehicleSeat(vehicle[1], -1) == ped) or IsVehicleSeatFree(vehicle[1], -1) then
					if RPWorking then
						if vehicle[2] == false then
							waittimer = 10
						else
							waittimer = 500
						end
						SetVehicleEngineOn(vehicle[1], vehicle[2], true, false)
						SetVehicleJetEngineOn(vehicle[1], vehicle[2])
						if not IsPedInAnyVehicle(ped, false) or (IsPedInAnyVehicle(ped, false) and vehicle[1]~= GetVehiclePedIsIn(ped, false)) then
							if IsThisModelAHeli(GetEntityModel(vehicle[1])) or IsThisModelAPlane(GetEntityModel(vehicle[1])) then
								if vehicle[2] then
									SetHeliBladesFullSpeed(vehicle[1])
								end
							end
						end
					end
				end
			else
				table.remove(vehicles, i)
			end
		end
	end
end)

AddEventHandler('e3650cfc-b5cd-4d0a-a9ab-4b76a38a7958', function()
	local veh
	local StateIndex
	local ped = PlayerPedId()
	for i, vehicle in ipairs(vehicles) do
		if vehicle[1] == GetVehiclePedIsIn(ped, false) then
			veh = vehicle[1]
			StateIndex = i
		end
	end
	Citizen.Wait(500)
	if IsPedInAnyVehicle(GetPlayerPed(-1), false) then 
		if (GetPedInVehicleSeat(veh, -1) == ped) then
			vehicles[StateIndex][2] = not GetIsVehicleEngineRunning(veh)
			if vehicles[StateIndex][2] then
				--TriggerEvent('chatMessage', '', {0, 255, 0}, 'Engine turned ON!')
			else
				--TriggerEvent('chatMessage', '', {255, 0, 0}, 'Engine turned OFF!')
			end
		end
    end 
end)

AddEventHandler('f97ad559-7b81-49f8-aae8-bda8ec87029f', function(State)
	RPWorking = State
end)


function table.contains(table, element)
  for _, value in pairs(table) do
    if value[1] == element then
      return true
    end
  end
  return false
end

Citizen.CreateThread(function()
	local waittimer = 1000
	while true do
		Citizen.Wait(waittimer)
		local ped = PlayerPedId()
		local vehicle = GetVehiclePedIsIn(ped, false)
		if RPWorking == false then
			if GetVehicleEngineHealth(vehicle) < 60 then
				SetVehicleEngineOn(vehicle, false, false, true)
			end
			--
			waittimer = 10
		end
		
		if GetIsVehicleEngineRunning(vehicle) == false then
			if GetPedInVehicleSeat(vehicle,-1) == ped then
				SetTextColour(argb.r, argb.g, argb.b, aalpha)
				SetTextFont(afont)
				SetTextScale(ascale, ascale)
				SetTextWrap(0.0, 1.0)
				SetTextCentre(false)
				SetTextDropshadow(2, 2, 0, 0, 0)
				SetTextEdge(1, 0, 0, 0, 205)
				SetTextEntry("STRING")
				AddTextComponentString(aservername)
				DrawText(aoffset.x, aoffset.y)
				waittimer = 0
				
				
			else
				waittimer = 1000
			end
		else
			waittimer = 1000
		end

	end
end)

