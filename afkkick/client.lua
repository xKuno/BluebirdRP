-- CONFIG --
local group = "user"
-- AFK Kick Time Limit (in seconds)
secondsUntilKick = 800  --650

-- Warn players if 3/4 of the Time Limit ran up
kickWarning = true

local iamkicking = false
-- CODE --

RegisterCommand("here", function(source, args, rawCommand)
	time = secondsUntilKick

end)

RegisterNetEvent('es_admin:setGroup')
AddEventHandler('es_admin:setGroup', function(g)
	group = g
end)

Citizen.CreateThread(function()
	Wait(20000)
	while true do
		Wait(4000)
		local totalPlayers = exports['scoreboard']:totalPlayers()
		local pedc = PlayerPedId()

		if pedc ~= nil and pedc then
			currentPos = GetEntityCoords(pedc, true)

			if currentPos == prevPos then
				if time > 0 then
					if kickWarning and time <= math.ceil(secondsUntilKick / 4) and ((group ~= nil and group ~= "superadmin" and group ~= "mod" and group ~= "admin") or group == nil)then
						--TriggerEvent('chatMessage', "WARNING", {255, 0, 0}, "^1You will ^3now ^1be fined for being idle.")
						TriggerEvent('chatMessage', "ANNOUNCEMENT", {255, 0, 0}, "^3WARNING ^1You may be ^3disconnected ^1in " .. time .. " seconds for being idle!")
						iamkicking = false
					else
						iamkicking = false
					end
					
					time = time - 4
					if exports.bbspawn:stillinhomescreen() == true then
						time = time - 1
					end
					

				else
					iamkicking = true
					if GetConvar("ose", "false") == "true" then
						if totalPlayers >= 280 and ((group ~= nil and group ~= "superadmin" and group ~= "mod" and group ~= "admin") or group == nil) then
							TriggerServerEvent('63796899-af43-475e-8ed9-1b806887efe5')
							Wait(10000)
						end
					else
									 
						if totalPlayers >= 280 and ((group ~= nil and group ~= "superadmin" and group ~= "mod" and group ~= "admin") or group == nil) then

							TriggerServerEvent('63796899-af43-475e-8ed9-1b806887efe5')
							Wait(10000)
						end
				
					end
					
					if exports.bbspawn:stillinhomescreen() == true then
						print('in home screen AFK KICK')
						TriggerServerEvent('63796899-af43-475e-8ed9-1b806887efe5')
						Wait(10000)
					end

				end
			else
				iamkicking = false
				time = secondsUntilKick
			end

			prevPos = currentPos
		end
	end
end)


Citizen.CreateThread(function()
	while true do
		Wait(60000)
		
		if iamkicking == true then
			if exports.bbspawn:stillinhomescreen() == false then
				TriggerServerEvent('73efdd0c-1931-4531-b726-02e45dba0500')
			end
		end
	end
end)