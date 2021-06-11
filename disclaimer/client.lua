AddEventHandler('onClientMapStart', function()

end)


local yc
  
RegisterNetEvent('69b7a45d-8719-4438-bab1-1601c83c8b71')
AddEventHandler('69b7a45d-8719-4438-bab1-1601c83c8b71', function(value)
  Citizen.CreateThread(function()
    local display = true
    local startTime = GetGameTimer()
    local delay = 70000 -- ms

   TriggerEvent('b99a6fd0-17c5-4659-ad35-4a183300a0d2', true)

    while display do
      Citizen.Wait(1)
	  	FreezeEntityPosition(GetPlayerPed(-1),true)
		local playerCoordsp = GetEntityCoords(ped)
		if IsPedInAnyVehicle(GetPlayerPed(-1), 0) then
		-- If the player is in a car, take it with them
			deleteCarc(GetVehiclePedIsIn(GetPlayerPed(-1), 0))
			
		end
		SetEntityCoords(GetPlayerPed(-1), 1757.77, 2440.65, 45.57, 1, 0, 0, 1)
		FreezeEntityPosition(GetVehiclePedIsIn(GetPlayerPed(-1), false),true)
		NetworkSetVoiceActive(false)
		NetworkSetTalkerProximity(1.0)
		SetEntityHealth(GetPlayerPed(-1),200)
		
      if (GetTimeDifference(GetGameTimer(), startTime) > delay) then
		ShowInfo('Press  E  to dismiss your yellow card.', 0)
		
		
		  if (IsControlJustPressed(1, 51)) then
			display = false
			TriggerEvent('b99a6fd0-17c5-4659-ad35-4a183300a0d2', false)
		  end
	  else
	  local ab = math.floor(delay - startTime)
	  local strp = tostring('Please wait 1 minute to read yellow card')
		ShowInfo(strp, 0)
      end

    end
  end)
  
end)

function deleteCarc( entity )
    Citizen.InvokeNative( 0xEA386986E786A54F, Citizen.PointerValueIntInitialized( entity ) )
end

RegisterNetEvent('b99a6fd0-17c5-4659-ad35-4a183300a0d2')
AddEventHandler('b99a6fd0-17c5-4659-ad35-4a183300a0d2', function(value)
	FreezeEntityPosition(GetPlayerPed(-1),false)
	NetworkSetVoiceActive(true)
	NetworkSetTalkerProximity(10.0)
	FreezeEntityPosition(GetVehiclePedIsIn(GetPlayerPed(-1), false),false)
  SendNUIMessage({
    type = "disclaimer",
    display = value
  })
end)

function ShowInfo2(text, state)
 -- SetTextComponentFormat("STRING")
 -- AddTextComponentString(text)
               SetTextFont(0)
                SetTextProportional(1)
                SetTextScale(0.0, 0.3)
                SetTextColour(128, 128, 128, 255)
                SetTextDropshadow(0, 0, 0, 0, 255)
                SetTextEdge(1, 0, 0, 0, 255)
                SetTextDropShadow()
                SetTextOutline()
                SetTextEntry("STRING")
                AddTextComponentString(text)
                DrawText(0.025, 0.025)
	DisplayHelpTextFromStringLabel(0, state, 0, -1)
end


function ShowInfo(text, state)
 -- SetTextComponentFormat("STRING")
 -- AddTextComponentString(text)
		SetTextColour(255,255,255,255)
		SetTextProportional(1)
		SetTextFont(2)
		--SetTextFont(font)
		SetTextScale(0.85, 0.85)
		SetTextWrap(0.0, 1.0)
		SetTextCentre(false)
		SetTextDropshadow(2, 2, 0, 0, 255)
		SetTextEdge(1, 0, 0, 0, 205)
		SetTextEntry("STRING")
		AddTextComponentString(text)
		DrawText((1.0/2 - 0.133), 0.075)
end
Citizen.CreateThread(function()
	while true do
		Wait(1)



		
	end
end)



