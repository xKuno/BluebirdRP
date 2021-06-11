local menu = false
local closeby = false

RegisterNetEvent('40f51101-efc1-415f-a23d-a1489fcf1d04')
AddEventHandler('40f51101-efc1-415f-a23d-a1489fcf1d04', function(option, coords, distanceAmount, cb)
	cb(Menu.Option(option, coords, distanceAmount))
end)

RegisterNetEvent('758e62df-6483-47d8-82a3-e0b16834f80b')
AddEventHandler('758e62df-6483-47d8-82a3-e0b16834f80b', function()
	Menu.updateSelection()
end)

function GetVehicleInDirectionSphere(coordFrom, coordTo)
    local rayHandle = StartShapeTestCapsule(coordFrom.x, coordFrom.y, coordFrom.z, coordTo.x, coordTo.y, coordTo.z, 2.0, 10, GetPlayerPed(-1), 7)
    local _, _, _, _, vehicle = GetShapeTestResult(rayHandle)
    return vehicle
end

RegisterNetEvent('4adc9158-8623-459c-9d86-b35d22c3c0b0')
AddEventHandler('4adc9158-8623-459c-9d86-b35d22c3c0b0', function(option)
	if option == true then
		menu = true
	else
		menu = false
	end
end)

RegisterNetEvent('159cbfe8-5504-432a-b194-d570d3d7c09d')
AddEventHandler('159cbfe8-5504-432a-b194-d570d3d7c09d', function()
    Menu.UpdateOption() 
end)

function DisplayHelpText(text)
	BeginTextCommandDisplayHelp("STRING")
	AddTextComponentSubstringPlayerName(text)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

isInZone ="none"

incircle = {}
Citizen.CreateThread(function()
    while true do
		Wait(0)
		
        local coordA = GetEntityCoords(PlayerPedId(), 1)
		local zcloseby = false
		for k,v in pairs(Config.Zones) do
			
			local distance = #(vector3(v.Marker.x,v.Marker.y,v.Marker.z) - coordA)
			
			if Config.showMarker and distance < 10 then
				DrawMarker(1, v.Marker.x, v.Marker.y,v.Marker.z,0, 0,   0,   0,   0,    0,  2.01, 2.01,    0.05, 10, 255,   10,65, 0, 0, 0,0)
			end

			if distance < 2.5 then
				zcloseby = true
				incircle[k] = true
				isInZone = k
			else
				incircle[k] = false
			end
		end
		closeby = zcloseby
		if closeby == false then
			Wait(500)
		end
    end
end)


function teleport(pos)
    local ped = PlayerPedId()
    Citizen.CreateThread(function()
 
        NetworkFadeOutEntity(ped, true, false)
        Citizen.Wait(250)

        SetEntityCoords(ped, pos.x, pos.y, pos.z, 1, 0, 0, 1)
        NetworkFadeInEntity(ped, 0)

    end)
end

Citizen.CreateThread(function()
    while true do
		if closeby == true then
			menu = true
			isInAZone = false
			
			for k,v in pairs (incircle) do 
				if v then isInAZone = true end
			end
			
			if not isInAZone then 
				isInZone = "none" 
			else
				for k,v in pairs(Config.Zones[isInZone].canGoTo) do
					TriggerEvent('40f51101-efc1-415f-a23d-a1489fcf1d04', Locales_lift[Config.Locale][tostring(v)], {Config.Zones[isInZone].Spawn.x, Config.Zones[isInZone].Spawn.y, Config.Zones[isInZone].Spawn.z+0.5}, 1.5, function(cb)
						if(cb) then
							teleport(vector3(Config.Zones[v].Spawn.x,Config.Zones[v].Spawn.y,Config.Zones[v].Spawn.z-0.80))
							TriggerEvent('485600b1-cf38-4738-a436-fa13c9e94b36',150,150,150)
							Wait(250)
							TriggerServerEvent("InteractSound_SVZONAH:PlayWithinDistance", 25, "demo", 0.2)
							-- print("TP to : "..v)
						end
					end)
					
				end
			end
			TriggerEvent('758e62df-6483-47d8-82a3-e0b16834f80b')
			Wait(0)
		else
			Wait(1000)
		end
		
    end
end)

RegisterNetEvent('485600b1-cf38-4738-a436-fa13c9e94b36')
AddEventHandler('485600b1-cf38-4738-a436-fa13c9e94b36', function(timeIn,timeWait,timeOut)
	Citizen.CreateThread(function()
		--DoScreenFadeOut(timeIn+1)
		--while not IsScreenFadedOut() do
		--	Wait(0)
		--end
		Wait(timeWait+1)
		--DoScreenFadeIn(timeOut+1)
	end)
end)