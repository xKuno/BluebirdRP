local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118, ["INSERT"] = 121,
}

local Player          = nil
local CruisedSpeed    = 0
local CruisedSpeedKm  = 0
local VehicleVectorY  = 0

local myPed =  GetPlayerPed(-1)
local vehiclein = 0
local myCurrentCoords = GetEntityCoords(myPed)

ESX = nil

Citizen.CreateThread(function ()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Wait(0)
  end
end)

Citizen.CreateThread(function()
	while true do
		pcall(function()
			myPed = ESX.Game.GetMyPed() or GetPlayerPed(-1)
			vehiclein = ESX.Game.GetVehiclePedIsIn() or 0
		end)
		Wait(1000)
	end

end)

AddEventHandler('f97ad559-7b81-49f8-aae8-bda8ec87029f', function(State)
	--print("this triggered  ===========================")
	if State == false then
		CruisedSpeed = 0
		ESX.ShowNotification(_U('deactivated'))
	end
end)

Citizen.CreateThread(function ()
  while true do
    Wait(0)
	
	if IsDriver() then
		if GetLastInputMethod(0) and IsControlPressed(1, 132) and IsControlJustPressed(1, Keys['W'])  then
		  Player = GetPlayerPed(-1)
		  TriggerCruiseControl()
		end
		
		
		 if GetLastInputMethod(0) and IsControlJustPressed(1, Keys['INSERT'])  then
		  Player = GetPlayerPed(-1)
		  IncreaseSpeed()
		end
		
		if GetLastInputMethod(0) and IsControlJustPressed(0, 178) then
		  Player = GetPlayerPed(-1)
			DecreaseSpeed()
		 -- DecreaseSpeed()
		end

	else
		Wait(1000)
	end
  end
end)


function IncreaseSpeed()
	if CruisedSpeed > 0 then
		local maxspeed = GetVehicleHandlingInt(GetVehiclePedIsIn(GetPlayerPed(-1)), 'CHandlingData', 'fInitialDriveMaxFlatVel') * 1.25
		--print(GetEntityModel(GetVehiclePedIsIn(GetPlayerPed(-1),false)))
	--	print('maxspeed')
		--print(maxspeed)
		if CruisedSpeed > maxspeed then
			ESX.ShowNotification('~o~No increase beyond ~r~MAX~o~ speed.')
		
		elseif GetVehiculeSpeed() > 0 and TransformToKm(GetVehiculeSpeed()) < 200 and TransformToKm(GetVehiculeSpeed()) < maxspeed then
		  Citizen.CreateThread(function ()
			Wait(1500)		
			CruisedSpeed = GetVehiculeSpeed() + 0.278
			CruisedSpeedKm = TransformToKm(CruisedSpeed)
		end)
			ESX.ShowNotification('Increase Cruise Speed') -- .. ': ~b~ ' .. CruisedSpeedKm .. ' km/h')
		elseif GetVehiculeSpeed() > 0 then
			ESX.ShowNotification('~o~No increase beyond ~r~200km/h ~o~or ~r~vehicle max speed')
		end
		
		
	else
		TriggerCruiseControl()
	end

end

function DecreaseSpeed()
  if CruisedSpeed > 0 then
    if GetVehiculeSpeed() > 0 then
	    CruisedSpeed = CruisedSpeed - 0.278
		CruisedSpeedKm = TransformToKm(CruisedSpeed)

      ESX.ShowNotification('Decrease Cruise Speed') -- .. ': ~b~ ' .. CruisedSpeedKm .. ' km/h')
	
	end
  end

end

function TriggerCruiseControl()
  if CruisedSpeed == 0 and IsDriving() then
    if GetVehiculeSpeed() > 0 then
	  vehclass = GetVehicleClass(GetVehiclePedIsIn(GetPlayerPed(-1),false))
	  if vehclass == 15 or vehclass == 14 or vehclass == 13 or vehclass == 16 or GetVehicleWheelieState(GetVehicle()) == 129 or IsVehicleOnAllWheels(GetVehicle()) == false  then
			ESX.ShowNotification('Umm squeeze ~g~me~w~? ~o~Oh no you didnt!')
		return
	  end
      CruisedSpeed = GetVehiculeSpeed()
      CruisedSpeedKm = TransformToKm(CruisedSpeed)
	  
	  

      ESX.ShowNotification(_U('activated') .. ': ~b~ ' .. CruisedSpeedKm .. ' km/h')
	  ESX.ShowNotification('Press ~b~[Insert]~w~ to increase or ~b~[Delete]~w~ to decrease speed')
      Citizen.CreateThread(function ()
        while CruisedSpeed > 0 and IsInVehicle() == Player and IsDriving do
          Wait(0)
		
					
          if not IsTurningOrHandBraking() and GetVehiculeSpeed() < (CruisedSpeed - 1.5) then
            CruisedSpeed = 0
            ESX.ShowNotification(_U('deactivated'))
            Wait(2000)
            break
          end

			
          if not IsTurningOrHandBraking() and IsVehicleOnAllWheels(GetVehicle()) and GetVehicleWheelieState(GetVehicle()) ~= 129 and GetVehiculeSpeed() < CruisedSpeed then
            SetVehicleForwardSpeed(GetVehicle(), CruisedSpeed)
          end

          if IsControlPressed(1, 132) and IsControlJustPressed(1, Keys['W']) then
				if vehclass == 15 or vehclass == 14 or vehclass == 13 or vehclass == 16 then
					ESX.ShowNotification('Umm squeeze ~g~me~w~? ~o~Oh no you didnt!')
				else
					CruisedSpeed = GetVehiculeSpeed()
					CruisedSpeedKm = TransformToKm(CruisedSpeed)
					ESX.ShowNotification('New Speed' .. ': ~b~ ' .. CruisedSpeedKm .. ' km/h')
				end
          end

          if IsControlJustPressed(2, 72) then
            CruisedSpeed = 0
            ESX.ShowNotification(_U('deactivated'))
            Wait(2000)
            break
          end
        end
      end)
	  
	  CruiseSpeed = 0
    end
  end
end

function IsTurningOrHandBraking ()
  return IsControlPressed(2, 76) or IsControlPressed(2, 63) or IsControlPressed(2, 64)
end

function IsDriving ()
  return IsPedInAnyVehicle(Player, false)
end

function GetVehicle ()
  return GetVehiclePedIsIn(Player, false)
end

function IsInVehicle ()
  return GetPedInVehicleSeat(vehiclein, -1)
end



function IsDriver ()
  return GetPedInVehicleSeat(vehiclein, -1) == myPed
end

function GetVehiculeSpeed ()
  return GetEntitySpeed(vehiclein)
end

function TransformToKm (speed)
  return math.floor(speed * 3.6 + 0.5)
end
