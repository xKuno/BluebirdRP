RegisterNetEvent('8b72161e-eca1-4d5f-a989-11b6516295b6')
RegisterNetEvent('01e5c475-3513-4c10-a35f-e58dbec3e91d')

	trunkOpened = false
	hoodOpened = false
	

AddEventHandler('8b72161e-eca1-4d5f-a989-11b6516295b6', function()

	
		local vehicle = GetPlayersLastVehicle()
	
		if (trunkOpened == true) then
			SetVehicleDoorShut(vehicle, 5, false)
			trunkOpened = false
		elseif (trunkOpened == false) then
			SetVehicleDoorOpen(vehicle, 5, false, false)
			trunkOpened = true
		end
end)


AddEventHandler('01e5c475-3513-4c10-a35f-e58dbec3e91d', function()

	
		local vehicle = GetPlayersLastVehicle()
	
		if (hoodOpened == true) then
			SetVehicleDoorShut(vehicle, 4, false)
			hoodOpened = false
		elseif (hoodOpened == false) then
			SetVehicleDoorOpen(vehicle, 4, false, false)
			hoodOpened = true
		end
end)