local ped = GetPlayerPed(-1)
local currentWeaponHash = GetSelectedPedWeapon(ped)

Citizen.CreateThread(function()
	local isSniper = false
	while true do
		Citizen.Wait(500)

    	ped = GetPlayerPed(-1)
		currentWeaponHash = GetSelectedPedWeapon(ped)

	end
end)

Citizen.CreateThread(function()
	local isSniper = false
	while true do
		Citizen.Wait(0)
		if currentWeaponHash ~= -1569615261 then
			if currentWeaponHash == 100416529 then
				isSniper = true
			elseif currentWeaponHash == 205991906 then
				isSniper = true
			elseif currentWeaponHash == -952879014 then
				isSniper = true
			elseif currentWeaponHash == `WEAPON_HEAVYSNIPER_MK2` then
				isSniper = true
			else
				isSniper = false
			end

			if not isSniper then
				HideHudComponentThisFrame(14)
			end
		else
			Wait(500)
		end
	end
end)