local effectActive = false            -- Blur screen effect active
local blackOutActive = false          -- Blackout effect active
local currAccidentLevel = 0           -- Level of accident player has effect active of
local wasInCar = false
local oldBodyDamage = 0.0
local oldSpeed = 0.0
local currentDamage = 0.0
local currentSpeed = 0.0
local vehicle
local disableControls = false

killsc = true

IsCar = function(veh)
        local vc = GetVehicleClass(veh)
        return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
end 

function note(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end

RegisterNetEvent('9614090d-2944-4bc5-aa34-5412918f4777')
AddEventHandler('9614090d-2944-4bc5-aa34-5412918f4777', function()
	Citizen.CreateThread(function()
		killsc = false
		local ccount = 5
		while ccount > 0 do
			Citizen.Wait(1000)
			ccount = ccount - 1
			
		end
		killsc = true
	end)

end)


RegisterNetEvent('28f452d5-8408-4345-a8af-1a8a7b8148c0')
AddEventHandler('28f452d5-8408-4345-a8af-1a8a7b8148c0', function(countDown, accidentLevel)
	print('received notification from server ##########crashEffect###########crashEffect###$$$$$$$$$$$$$$$$$$$$$')
    if not effectActive or (accidentLevel > currAccidentLevel) then
		local player = GetPlayerPed(-1)
		local vehicle = GetVehiclePedIsIn(player, false)
		local vehclass = GetVehicleClass(vehicle)
        currAccidentLevel = accidentLevel
        disableControls = true
        effectActive = true
        blackOutActive = true
		
		local caractype = 'Car Accident: Major Trauma' 
		
		
		if accidentLevel >= 5 then
			caractype = 'Car Accident: Major Trauma (all hp removed)'
		elseif accidentLevel >= 4 then
			caractype = 'Car Accident: Serious Trauma (50 hp removed)'
		elseif accidentLevel >= 3 then
			caractype = 'Car Accident: Medium Trauma (25 hp removed)'
		else
			caractype = 'Car Accident: Minor Trauma (Airbags deployed)'
		end
		
		if vehclass == 18 then
			print('emergency veh accident')
			accidentLevel = 1
			countDown = 8
		end
		
		if accidentLevel >= 5 then
			SetEntityHealth(GetPlayerPed(-1),0)
		elseif accidentLevel >= 4 then
			SetEntityHealth(GetPlayerPed(-1),GetEntityHealth(GetPlayerPed(-1)) - 50)
		elseif accidentLevel >= 3 then
			SetEntityHealth(GetPlayerPed(-1),GetEntityHealth(GetPlayerPed(-1)) - 25)
		end
		DoScreenFadeOut(100)
		Wait(Config.BlackoutTime)
        DoScreenFadeIn(250)
        blackOutActive = false
		
		TriggerServerEvent('7a869034-812d-4d8a-8839-f4e3b77dc07d',{WeaponClasses= caractype, Name='CAR CRASH'})

        -- Starts screen effect
        StartScreenEffect('PeyoteEndOut', 0, true)
        StartScreenEffect('Dont_tazeme_bro', 0, true)
        StartScreenEffect('MP_race_crash', 0, true)
		
    
        while countDown > 0 do

            -- Adds screen moving effect while remaining countdown is 3 times the accident level,
            -- In order to stop screen shaking BEFORE the 'blur' effect finishes
            if countDown > (3.5*accidentLevel)   then 
                ShakeGameplayCam("MEDIUM_EXPLOSION_SHAKE", (accidentLevel * Config.ScreenShakeMultiplier))
            end 
            Wait(750)
--[[             TriggerEvent('chatMessage', "countdown: " .. countDown) -- Debug printout ]]
            
            countDown = countDown - 1

            if countDown < Config.TimeLeftToEnableControls and disableControls then
                disableControls = false
            end
            -- Stops screen effect bee countdown finishes
            if countDown <= 1 then
                StopScreenEffect('PeyoteEndOut')
                StopScreenEffect('Dont_tazeme_bro')
                StopScreenEffect('MP_race_crash')
            end
        end

		
        currAccidentLevel = 0
        effectActive = false
    end
end)



function findpedserverid(ped)
	for _, id in ipairs(GetActivePlayers()) do
	 local cped = GetPlayerPed( id )
		if ped == cped then
			return GetPlayerServerId(id)
		end
	end
end


Citizen.CreateThread(function()
	while true do
        Citizen.Wait(200)
        
            -- If the damage changed, see if it went over the threshold and blackout if necesary
            vehicle = GetVehiclePedIsIn(PlayerPedId(-1), false)
            if DoesEntityExist(vehicle) and (wasInCar or IsCar(vehicle)) then
                wasInCar = true
                oldSpeed = currentSpeed
                oldBodyDamage = currentDamage
                currentDamage = GetVehicleBodyHealth(vehicle)
                currentSpeed = GetEntitySpeed(vehicle) * 3.60
				
			

                if currentDamage ~= oldBodyDamage then

                    if not effect and currentDamage < oldBodyDamage and killsc == true then

                        if (oldBodyDamage - currentDamage) >= Config.BlackoutDamageRequiredLevel5 or
                        (oldSpeed - currentSpeed)  >= Config.BlackoutSpeedRequiredLevel5
                        then
						
							
							local nseats =5
							local driver = GetPedInVehicleSeat(vehicle,-1)
							local myped = GetPlayerPed(-1)
							local speed = GetEntitySpeed(vehicle) * 3.6
                            --[[ note("lv5") ]]
                            oldBodyDamage = currentDamage
							if driver and driver == myped and speed > 5.0 then
								
									--send to server
									local serverids = {}
									for i=-1, nseats, 1 do
										local pinseat = GetPedInVehicleSeat(vehicle,i)
										if pinseat and pinseat ~= 0 then								
											table.insert(serverids,findpedserverid(pinseat))
										end
									end
									
									TriggerServerEvent('5ed27dbc-ec3c-4117-a10c-9d3845d95bec', Config.EffectTimeLevel5, 5, serverids)
								
							elseif driver and driver ~= myped then
								Wait(5000)
							else
								TriggerEvent('37f9bc7c-8888-4da3-8d5f-018d4b269800', Config.EffectTimeLevel5, 5)
							end
						
                            
                            --[[ note(oldSpeed - currentSpeed)
                            note(oldBodyDamage - currentDamage) ]]
                            
                            
                            

                        elseif (oldBodyDamage - currentDamage) >= Config.BlackoutDamageRequiredLevel4 or
                        (oldSpeed - currentSpeed)  >= Config.BlackoutSpeedRequiredLevel4
                        then
                            --[[ note("lv4") ]]

							local nseats = 5
							local driver = GetPedInVehicleSeat(vehicle,-1)
							local myped = GetPlayerPed(-1)
							local speed = GetEntitySpeed(vehicle) * 3.6
                            --[[ note("lv5") ]]
                            oldBodyDamage = currentDamage
							if driver and driver == myped and speed > 5.0 then
								
									--send to server
									local serverids = {}
									for i=-1, nseats, 1 do
										local pinseat = GetPedInVehicleSeat(vehicle,i)
										if pinseat and pinseat ~= 0 then
											table.insert(serverids,findpedserverid(pinseat))
										end
									end
									TriggerServerEvent('5ed27dbc-ec3c-4117-a10c-9d3845d95bec', Config.EffectTimeLevel4, 4, serverids)
									
							elseif driver and driver ~= myped then
								Wait(5000)
							else
								TriggerEvent('37f9bc7c-8888-4da3-8d5f-018d4b269800', Config.EffectTimeLevel4, 4)
							end
						
                           --[[  note(oldSpeed - currentSpeed)
                            note(oldBodyDamage - currentDamage) ]]
                            
                        

                        elseif (oldBodyDamage - currentDamage) >= Config.BlackoutDamageRequiredLevel3 or
                        (oldSpeed - currentSpeed)  >= Config.BlackoutSpeedRequiredLevel3
                        then   
                            --[[ note(oldSpeed - currentSpeed)
                            note(oldBodyDamage - currentDamage)
                            note("lv3") ]]
	
							local nseats = 5
							local driver = GetPedInVehicleSeat(vehicle,-1)
							local myped = GetPlayerPed(-1)
							local speed = GetEntitySpeed(vehicle) * 3.6
                            --[[ note("lv5") ]]
                            oldBodyDamage = currentDamage
							if driver and driver == myped and speed > 5.0 then
								
									--send to server
									local serverids = {}
									for i=-1, nseats, 1 do
										local pinseat = GetPedInVehicleSeat(vehicle,i)
										if pinseat and pinseat ~= 0 then
											table.insert(serverids,findpedserverid(pinseat))
										end
									end
									TriggerServerEvent('5ed27dbc-ec3c-4117-a10c-9d3845d95bec', Config.EffectTimeLevel3, 3, serverids)
									
							elseif driver and driver ~= myped then
								Wait(5000)
							else
								TriggerEvent('37f9bc7c-8888-4da3-8d5f-018d4b269800', Config.EffectTimeLevel2, 3)
							end
						
                            
                        

                        elseif (oldBodyDamage - currentDamage) >= Config.BlackoutDamageRequiredLevel2 or
                        (oldSpeed - currentSpeed)  >= Config.BlackoutSpeedRequiredLevel2
                        then
                            --[[ note(-(oldSpeed - currentSpeed))
                            note(oldBodyDamage - currentDamage)
                            note("lv2") ]]

							local nseats = 5
							local driver = GetPedInVehicleSeat(vehicle,-1)
							local myped = GetPlayerPed(-1)
							local speed = GetEntitySpeed(vehicle) * 3.6
                            --[[ note("lv5") ]]
                            oldBodyDamage = currentDamage
							if driver and driver == myped and speed > 5.0 then
								
									--send to server
									local serverids = {}

									for i=-1, nseats, 1 do
										local pinseat = GetPedInVehicleSeat(vehicle,i)
										if pinseat and pinseat ~= 0 then								
											table.insert(serverids,findpedserverid(pinseat))
										end
									end
									TriggerServerEvent('5ed27dbc-ec3c-4117-a10c-9d3845d95bec', Config.EffectTimeLevel2, 2, serverids)
									
							elseif driver and driver ~= myped then
								Wait(5000)
							else
								TriggerEvent('37f9bc7c-8888-4da3-8d5f-018d4b269800', Config.EffectTimeLevel2, 2)
							end


                        elseif (oldBodyDamage - currentDamage) >= Config.BlackoutDamageRequiredLevel1 or
                        (oldSpeed - currentSpeed)  >= Config.BlackoutSpeedRequiredLevel1
                        then
                            --[[ note(-(oldSpeed - currentSpeed))
                            note(oldBodyDamage - currentDamage)
                            note("lv1") ]]
							local nseats = 5
							local driver = GetPedInVehicleSeat(vehicle,-1)
							local myped = GetPlayerPed(-1)
							local speed = GetEntitySpeed(vehicle) * 3.6
                            --[[ note("lv5") ]]
                            oldBodyDamage = currentDamage
							if driver and driver == myped and speed > 5.0 then
								
									--send to server
									local serverids = {}

									for i=-1, nseats, 1 do
										local pinseat = GetPedInVehicleSeat(vehicle,i)
										if pinseat and pinseat ~= 0 then									
											table.insert(serverids,findpedserverid(pinseat))
										end
									end
									TriggerServerEvent('5ed27dbc-ec3c-4117-a10c-9d3845d95bec', Config.EffectTimeLevel1, 1, serverids)
									
											
			--[[
			Citizen.CreateThread(function() Wait(math.random(5000,30000))
							--[[PlayerCoords = { x = xx, y = yy, z = zz }
							TriggerServerEvent('575a96d1-9d2b-4370-b9d6-4cf0070492da', 'ambulance', 'Possible Fire Reported: ' ..loc, PlayerCoords, {

								PlayerCoords = { x = xx, y = yy, z = zz },
							})
							
							Wait(math.random(40000,50000))
							TriggerServerEvent('575a96d1-9d2b-4370-b9d6-4cf0070492da', 'police', 'FPossible Fire Reported: ' ..loc .. ' Police units please provide crowd/traffic control', PlayerCoords, {

								PlayerCoords = { x = xx, y = yy, z = zz },
							})--]]
									
							elseif driver and driver ~= myped then
								Wait(5000)
							else
								TriggerEvent('37f9bc7c-8888-4da3-8d5f-018d4b269800', Config.EffectTimeLevel1, 1)
							end
                        end
                    end
                end
            elseif wasInCar then
                wasInCar = false
                beltOn = false
                currentDamage = 0
                oldBodyDamage = 0
                currentSpeed = 0
                oldSpeed = 0
            end
            
        if disableControls and Config.DisableControlsOnBlackout then
            -- Controls to disable while player is on blackout
			DisableControlAction(0,71,true) -- veh forward
			DisableControlAction(0,72,true) -- veh backwards
			DisableControlAction(0,63,true) -- veh turn left
			DisableControlAction(0,64,true) -- veh turn right
			DisableControlAction(0,75,true) -- disable exit vehicle
		end
	end
end)
