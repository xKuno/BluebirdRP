Citizen.CreateThread(function ()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(200)
  end
  
  	Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()
end)


local mp_pointing = false
local mp_alreadycancelled = true
local keyPressed = false
local vehiclein = 0
local myPed = GetPlayerPed(-1)
local Pedonfoot = true

Citizen.CreateThread(function()
	while true do
		pcall(function()
			myPed = ESX.Game.GetMyPed()
			vehiclein = ESX.Game.GetVehiclePedIsIn()
			Pedonfoot = IsPedOnFoot(myPed)
		end)
		Wait(1000)
	end

end)



local function startPointing()
    local ped = myPed

    RequestAnimDict("anim@mp_point")
    while not HasAnimDictLoaded("anim@mp_point") do
        Wait(0)
    end
    --SetPedCurrentWeaponVisible(ped, 0, 1, 1, 1)
    --SetPedConfigFlag(ped, 36, 1)
    Citizen.InvokeNative(0x2D537BA194896636, ped, "task_mp_pointing", 0.5, 0, "anim@mp_point", 24)
    RemoveAnimDict("anim@mp_point")
end

local function stopPointing()

    local ped = myPed
	RequestTaskMoveNetworkStateTransition(ped,"Stop")
    if not IsPedInjured(ped) then
        ClearPedSecondaryTask(ped)
    end
    if vehiclein ~= 0 then
        --SetPedCurrentWeaponVisible(ped, 1, 1, 1, 1)
	
    end
    --SetPedConfigFlag(ped, 36, 0)
    ClearPedSecondaryTask(ped)
end

local once = true
local oldval = false
local oldvalped = false

Citizen.CreateThread(function()
    while true do
        Wait(10)
		pcall(function()
			if once then
				once = false
			end

			if not keyPressed then
			
				if IsControlPressed(0, 29) and not mp_pointing and Pedonfoot then
					Wait(200)
					if not IsControlPressed(0, 29) then
						keyPressed = true
						
						startPointing()
						mp_pointing = true
						mp_alreadycancelled = false
					else
						keyPressed = true
						while IsControlPressed(0, 29) do
							Wait(50)
						end
					end
				elseif (IsControlPressed(0, 29) and mp_pointing) or (not Pedonfoot and mp_pointing) then
					keyPressed = true
					mp_pointing = false
					stopPointing()
					mp_alreadycancelled = true
				end
			end

			if keyPressed then
				if not IsControlPressed(0, 29) then
					keyPressed = false
				end
			end
			if TaskMoveNetworkByName(myPed) and not mp_pointing and not mp_alreadycancelled then
				stopPointing()
				mp_alreadycancelled = true
			end
			if TaskMoveNetworkByName(myPed) then
				if not Pedonfoot then
					stopPointing()
				else
					local ped = myPed
					local camPitch = GetGameplayCamRelativePitch()
					if camPitch < -70.0 then
						camPitch = -70.0
					elseif camPitch > 42.0 then
						camPitch = 42.0
					end
					camPitch = (camPitch + 70.0) / 112.0

					local camHeading = GetGameplayCamRelativeHeading()
					local cosCamHeading = Cos(camHeading)
					local sinCamHeading = Sin(camHeading)
					if camHeading < -180.0 then
						camHeading = -180.0
					elseif camHeading > 180.0 then
						camHeading = 180.0
					end
					camHeading = (camHeading + 180.0) / 360.0

					local blocked = 0
					local nn = 0

					local coords = GetOffsetFromEntityInWorldCoords(ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
					local ray = Cast_3dRayPointToPoint(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, ped, 7);
					nn,blocked,coords,coords = GetRaycastResult(ray)

					Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Pitch", camPitch)
					Citizen.InvokeNative(0xD5BB4025AE449A4E, ped, "Heading", camHeading * -1.0 + 1.0)
					Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isBlocked", blocked)
					Citizen.InvokeNative(0xB0A6CFD2C69C1088, ped, "isFirstPerson", Citizen.InvokeNative(0xEE778F8C7E1142E2, Citizen.InvokeNative(0x19CAFA3C87F7C2FF)) == 4)
					Wait(30)

				end
			end
		end)
    end
end)
