local frozen = false
local client_date = {}
local NEWsecondOfDay = 0
local secondOfDay = 5000 -- this ensure's we are desynced
off = false

AddEventHandler( "onClientMapStart", function()
    TriggerServerEvent( "addTimeChatSuggests" )
end)

RegisterNetEvent("updateFromServerTime")
AddEventHandler("updateFromServerTime", function(serverSecondOfDay,serverDate,isTimeFrozen)
	--print('time update from server: ' .. serverSecondOfDay)
    frozen = isTimeFrozen
    NEWsecondOfDay = serverSecondOfDay
    client_date = serverDate
end)


RegisterNetEvent("vMenu:IgnoreTime")
AddEventHandler("vMenu:IgnoreTime", function(offon)
	off = offon
	if off == false then
		
		if missedacycle == false then
			pcall(function()
				changeWeather(missedNewWeather,missedblackout,missedstartup)
			end)
			missedacycle = false
			missedNewWeather = nil
			missedblackout = nil
			missedstartup = nil
		end
	else

	end
end)




Citizen.CreateThread( function()
    local timeBuffer = 0.0
    local h = 0
    local m = 0
    local s = 0
    while true do
		Wait(0)
		pcall(function()
			--if NEWsecondOfDay < ( secondOfDay - 200 ) or NEWsecondOfDay > ( secondOfDay + 200) then -- The Actual Sync check
			 --   Citizen.Trace("Time is out of sync... variance (Seconds of Game Day):"..tostring(secondOfDay - NEWsecondOfDay)) 
				secondOfDay = NEWsecondOfDay
			--end 
			Citizen.Wait(33) -- (int)(GetMillisecondsPerGameMinute() / 60)
			if not frozen then
				local gameSecond = 33.33 / ss_night_time_speed_mult
				if secondOfDay >= 19800 and secondOfDay <= 75600 then
					gameSecond = 33.333 / ss_day_time_speed_mult
				end
				timeBuffer = timeBuffer + round( 33.0 / gameSecond, 4 )
				if timeBuffer >= 1.0 then
					local skipSeconds = math.floor( timeBuffer )
					timeBuffer = timeBuffer - skipSeconds
					secondOfDay = secondOfDay + skipSeconds
					if secondOfDay >= 86400 then
						secondOfDay = secondOfDay % 86400
					end
				end
			end
			h = math.floor( secondOfDay / 3600 )
			m = math.floor( (secondOfDay - (h * 3600)) / 60 )
			s = secondOfDay - (h * 3600) - (m * 60)
			secondOfDay = (h * 3600) + (m * 60) + s
			if off == false then
				NetworkOverrideClockTime( math.floor( secondOfDay / 3600 ), math.floor( (secondOfDay - (h * 3600)) / 60 ), secondOfDay - (math.floor( secondOfDay / 3600 ) * 3600) - (math.floor( (secondOfDay - (h * 3600)) / 60 ) * 60) )
			end
		end)
	end
end)

RegisterNetEvent("addTimeChatSuggests")
AddEventHandler("addTimeChatSuggests", function()
    TriggerEvent('chat:addSuggestion', '/time', 'Change the time.', {
        { name="hour"  , help="Hour of day in 24 hour format."},
        { name="minute", help="Minute of the hour."}
    })
end)