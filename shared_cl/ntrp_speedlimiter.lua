ESX = nil
local menuOpen = nil
local lastchosen = 0
local lastclickcd = GetGameTimer()



Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

		Citizen.Wait(0)
 end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
       
       local ped = PlayerPedId()      
       local TruckId       =  GetVehiclePedIsIn(ped, false)
	   if TruckId > 0 then
			local playerCoords  =  GetEntityCoords(ped)
			local driverPed     = GetPedInVehicleSeat(TruckId, -1)
			if  menuOpen == nil and GetLastInputMethod(1) and IsControlPressed(1, 132) and IsControlJustPressed(0, 191) and GetPedInVehicleSeat(TruckId, -1) == ped and lastclickcd < GetGameTimer() - 1000 then 
			   lastclickcd = GetGameTimer()
			   Speedlimiter()
			end
		else
			Wait(1000)
		end
    end
end)


function Speedlimiter() 
   menuOpen = true
   local ped           =  PlayerPedId()  
   local TruckId       =  GetVehiclePedIsIn(ped, false)
   local speeddivider = 3.6

 if not IsPedInAnyBoat(ped) and not IsPedInAnyPlane(ped) and not IsPedInAnyHeli(ped) then

   ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'startmenu',
		{
			title    = '🚦Speedlimiter',
			align    = 'top-right',
			elements = {
        {label = 'Reset Speed', value = '999.9'},
		{label = 'Set at 20 km/h', value = '20.0'},
		{label = 'Set at 40 km/h', value = '40.0'},
		{label = 'Set at 60 km/h', value = '60.0'},
		{label = 'Set at 80 km/h', value = '80.0'},
		{label = 'Set at 100 km/h', value = '100.0'},
		{label = 'Set at 110 km/h', value = '110.0'},
		{label = 'Set at 120 km/h', value = '120.0'},
		{label = 'Set at 150 km/h', value = '150.0'},
		{label = 'Set at 180 km/h', value = '180.0'},
		{label = 'Increase by 5', value = '5.0'},
		{label = 'Decrease by 5', value = '-5.0'},
        {label = 'Close', value = 'closemenu'}
			}
		},
		function(data, menu)
			if  lastclickcd < GetGameTimer() - 600 then
				lastclickcd = GetGameTimer()
				PlaySoundFrontend(-1, 'NAV', 'HUD_AMMO_SHOP_SOUNDSET', false)

				 if lastchosen == 0 then
					lastchosen = GetEntitySpeed(TruckId)*speeddivider
					print('new speed applied ' .. lastchosen)
				 end
				 if tonumber(data.current.value) == 5.0 then
					if tonumber(lastchosen)  < 160 then
						print('before ' .. lastchosen)
						lastchosen = tonumber(lastchosen) + 5.0
						print('new speed applied AFTER' .. lastchosen)
						SetEntityMaxSpeed(TruckId, (tonumber(lastchosen) +5)/speeddivider)
						ESX.ShowNotification('~b~Maximum~w~ speed has been increased by ~b~5 km/h')
					end
				 elseif tonumber(data.current.value) == -5.0 then
					if lastchosen  < 160 then
						lastchosen = tonumber(lastchosen) - 5.0
						SetEntityMaxSpeed(TruckId, (tonumber(lastchosen)-5)/speeddivider)
						ESX.ShowNotification('~b~Maximum~w~ speed has been decreased by ~y~5 km/h')
					end
				 elseif data.current.value ~= 'closemenu' then
					lastchosen = tonumber(data.current.value)
					SetEntityMaxSpeed(TruckId,tonumber(data.current.value)/speeddivider)
					 if tonumber(data.current.value)  > 500 then
						ESX.ShowNotification('~b~Maximum~w~ speed has been ~g~reset')
					 else
						ESX.ShowNotification('~b~Maximum~w~ speed set to ~y~'..data.current.value..' ~w~km/h')
					 end
					 menuOpen = nil
					 menu.close()
				 end

				if data.current.value == 'closemenu' then
					ESX.UI.Menu.CloseAll()
					 menuOpen = nil
					 menu.close()
				end

			end
		end,
    function(data, menu)
      menuOpen = nil
			menu.close()
    end)
end
end

Citizen.CreateThread(function() -- Driver Ped no Drive By
 while true do 
  Citizen.Wait(1)
    local ped        = GetPlayerPed(-1)
    local driverPed         = GetPedInVehicleSeat(TruckId , -1)
    local TruckId   	    =  GetVehiclePedIsIn(ped, false)

  if TruckId and GetPedInVehicleSeat(TruckId, -1) ==  ped then

    if VehCamOff then
      DisableControlAction(0, 80, true) -- no cin cam
      SetFollowPedCamViewMode(1)
    end
    if menuOpen then
      DisableControlAction(0, 42, true) 
      DisableControlAction(0, 43, true) 
   end               
  end
 end
end)

TriggerEvent('2896af73-6240-4f26-92b0-417518db3f5a', '/cam.off', 'Turn off or Lock Cinematic Cam', {
    { name="Vehicle Cam", help="/cam.off " }
})

TriggerEvent('2896af73-6240-4f26-92b0-417518db3f5a', '/cam.on', 'Turn On or Unlock Cinematic Cam', {
    { name="Vehicle Cam", help="/cam.on" }
})

RegisterCommand("cam.off", function()
 
  local ped        = GetPlayerPed(-1)
  local TruckId   	    =  GetVehiclePedIsIn(ped, false)

N_0x5db8010ee71fdef2(TruckId)
SetFollowPedCamViewMode(1)
ESX.ShowNotification('~b~Vehicle Cam :~y~ OFF') 
 Citizen.Wait(30)
VehCamOff = true
end)

RegisterCommand("cam.on", function()
ESX.ShowNotification('~b~Vehicle Cam :~y~ ON') 
VehCamOff = nil
 Citizen.Wait(30)
end)

menuOpen = nil
