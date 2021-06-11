Citizen.CreateThread(function()
    while true do
        
		if IsPedArmed(PlayerPedId(), 6) then
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
		else
			Wait(1000)
		end
		Wait(0)
    end
end)

