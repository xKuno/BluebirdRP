local vehPrice = nil
local modPrice = vehPrice
local lastPress = GetGameTimer()

Citizen.CreateThread(function()
	local blipX = 2505.325
	local blipY = 4217.261
	local blipZ = 39.926
	local loadedBlip = false


	while true do
		Citizen.Wait(15)
		local x,y,z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
		local distance = GetDistanceBetweenCoords(2505.325, 4214.261, 38.5, x, y, z, true)
	
		--load blip
		if not loadedBlip then 
			local blipSellCar = AddBlipForCoord(blipX, blipY, blipZ)
			SetBlipSprite(blipSellCar, 227)
			SetBlipDisplay(blipSellCar, 2)
			SetBlipScale(blipSellCar, 1.0)
			SetBlipColour(blipSellCar, 1)
			SetBlipAlpha(blipSellCar, 255)
			SetBlipAsShortRange(blipSellCar, true)
			BeginTextCommandSetBlipName("String")
			AddTextComponentString("Chop Shop")
			EndTextCommandSetBlipName(blipSellCar)
			loadedBlip = true
		end
		
		--load marker if player is in vehicle
		if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) and distance < 15 then		
	
			DrawMarker(1, 2505.325, 4214.261, 38.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 4.0, 4.0, 2.0, 255, 0, 0, 100, false, true, 1, false, false, false, false)
		else
			Wait(2000)
		end
		
		--vehicle health modifier
		if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) and vehPrice ~= nil then

		end
		
		--ability to sell car if in range of chop shop
		if IsPedSittingInAnyVehicle(GetPlayerPed(-1)) and distance <= 4.0 then
			ShowHelp()
		
			
			
			if IsControlJustPressed(1, 38) then
				sellVehicle()
			end
		else
			vehPrice = nil
		end
	end
end)

RegisterNetEvent('d58df065-2eda-4f31-abc4-4e8d03474900')
AddEventHandler('d58df065-2eda-4f31-abc4-4e8d03474900', function(price)
	vehPrice = price
end)
RegisterNetEvent('84cf929b-9e4a-4896-9787-bf10178eb9df')
AddEventHandler('84cf929b-9e4a-4896-9787-bf10178eb9df', function()
	local vehicle = SetEntityAsMissionEntity(GetVehiclePedIsIn(GetPlayerPed(-1)), true, true)
	DeleteVehicle(vehicle)
end)



function ShowHelp()

	if vehPrice == nil then
		local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
		local class = GetVehicleClass(vehicle)
		TriggerServerEvent('aab69a0c-9d57-49eb-a413-777f7fa6e0f5', class)
	else

		BeginTextCommandDisplayHelp("STRING")
		AddTextComponentSubstringPlayerName("Press ~INPUT_PICKUP~ to sell your vehicle for ~b~" .. vehPrice .. "~s~!")
		EndTextCommandDisplayHelp(0, false, true, -1)
	end
end

function sellVehicle()

	if lastPress < (GetGameTimer()) then
		lastPress = GetGameTimer() + 9000
		if vehPrice == nil then
			--TriggerEvent('chatMessage', "^2You cannot sell this car!")
		else
			local health = GetEntityHealth(GetVehiclePedIsIn(GetPlayerPed(-1)))
			local modifier = (health -((1000-health)*4.5))/1000
			local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1), false)
			local pedv = GetPedInVehicleSeat(vehicle, -1)
			if pedv == GetPlayerPed(-1) then
				local class = GetVehicleClass(vehicle)
				local carplate = GetVehicleNumberPlateText(vehicle)
				TriggerServerEvent('0bdfc1fa-8fb8-4f13-b29f-ceb967bac991', modifier, class, carplate)	
				Wait(100)
			end
			vehPrice = nil
		end
	end
end

function round(num, numDecimalPlaces)
	local mult = 10^(numDecimalPlaces or 0)
	return math.floor(num * mult + 0.5) / mult
end