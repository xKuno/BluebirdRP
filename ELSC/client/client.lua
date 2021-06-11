els_Vehicles = {}
debug_me = false
RequestScriptAudioBank("DLC_WMSIRENS\\SIRENPACK_ONE", false)
RequestScriptAudioBank("DLC_WALSHEY\\SIRENPACK_ONE", false)
k = nil
vehName = nil
lightingStage = 0
fps = 0
prevframes = 0
curframes = 0
prevtime = 0
curtime = 0
advisorPatternSelectedIndex = 1
advisorPatternIndex = 1

lightPatternPrim = 0
lightPatternsPrim = 1
lightPatternSec = 1

elsVehs = {}  -- active normalids
elsVehsN_Local = {}
elsVehsL_Net = {}


elsVehsN = {} -- active NetworkIDs
elsVehsNB = {}  -- for removal 
elsVehsNT = {}	-- for removal 
elsVehsNS = {}  --siren table

m_siren_state = {}
m_soundID_veh = {}
dualEnable = {}
d_siren_state = {}
d_soundID_veh = {}
h_horn_state = {}
h_soundID_veh = {}

curCleanupTime = 0

elsstopprocess = false

lastloopmain = 0

lastloopprom = 0

lastloopnet = 0

lastloopnetq = 0

carpattern = nil
mainpattern = nil

RegisterCommand("elsr", function()

	local countr = 0
	local countn = 0
	 for k,v in pairs(elsVehs) do
		countr = countr + 1
		--print(tostring(k))
	 end
	 
	 --print('networked only')
	 
	 for k,v in pairs(elsVehsN) do
		countn = countn + 1
		--print(tostring(k))
	 end
	 --print ("count of cars Network Vehs " .. countn)
	 --print ("count of cars Local Vehs " .. countr)
	 
	 --print("Game Time: " .. GetGameTimer() )
	 --print("lastloopmain: " .. lastloopmain)
	 --print("lastloopprom: " .. lastloopprom)
	 --print("lastloopnet: " .. lastloopnet)
	 --print("lastloopnetq: " .. lastloopnetq)
	 
	 
end, false)

RegisterCommand('+elscruiselights', function()
	if exports.gcphone:isPhoneOpen() == true or exports.webcops.isKeyboardOpen() == true then
		return
	end
	local playerPed = GetPlayerPed(-1)
	local vehCar = GetVehiclePedIsUsing(playerPed)
	if vehCar ~= nil and vehCar ~= 0 and vehInTable(els_Vehicles, checkCarHash(GetVehiclePedIsUsing(playerPed))) then
		if (GetPedInVehicleSeat(vehCar, -1) == playerPed) or
					(GetPedInVehicleSeat(vehCar, 0) == playerPed) then
			local vehm = GetEntityModel(vehCar)
			if playButtonPressSounds then
				PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			end

			local vehNetID = VehToNet(vehCar)
			if elsVehsN[vehNetID] and elsVehsN[vehNetID].cruise then
				TriggerServerEvent('63ee0e3c-aa7d-4a97-825f-2d8159e7e871',vehNetID, vehm,false)
			else
				TriggerServerEvent('63ee0e3c-aa7d-4a97-825f-2d8159e7e871',vehNetID,vehm,true)
			end
		end
	end
end, false)



RegisterCommand('+elstakedownlights', function()
	if exports.gcphone:isPhoneOpen() == true or exports.webcops.isKeyboardOpen() == true then
		return
	end
	local playerPed = GetPlayerPed(-1)
	local vehCar = GetVehiclePedIsUsing(playerPed)
	if vehCar ~= nil and vehCar ~= 0 and not exports.esx_policejob:amicuffed() and vehInTable(els_Vehicles, checkCarHash(GetVehiclePedIsUsing(playerPed))) then
		 if (GetPedInVehicleSeat(vehCar, -1) == playerPed) or
					(GetPedInVehicleSeat(vehCar, 0) == playerPed) then
			local vehm = GetEntityModel(vehCar)
			if playButtonPressSounds then
				PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
			end

			local vehNetID = VehToNet(vehCar)
			if elsVehsN[vehNetID] and elsVehsN[vehNetID].takedown then
				print('asking to turn off ')
				--TriggerServerEvent('a7e901fa-86b4-4707-90dd-e4b9048dabbe',vehNetID, vehm,false)
			else
				print('asking to turn on')
				--TriggerServerEvent('a7e901fa-86b4-4707-90dd-e4b9048dabbe',vehNetID,vehm,true)
			end
		end
	end
end, false)


RegisterCommand('+elslightstage', function()
	if exports.gcphone:isPhoneOpen() == true or exports.webcops.isKeyboardOpen() == true then
		return
	end
		local playerPed = GetPlayerPed(-1)
		local vehCar = GetVehiclePedIsUsing(playerPed)

        if vehCar ~= nil and vehCar ~= 0 and not exports.esx_policejob:amicuffed() and vehInTable(els_Vehicles, checkCarHash(GetVehiclePedIsUsing(playerPed))) then
            if (GetPedInVehicleSeat(vehCar, -1) == playerPed) or
                (GetPedInVehicleSeat(vehCar, 0) == playerPed) then

						
				if getVehicleVCFInfo(vehCar).interface.activationType == "invert" or getVehicleVCFInfo(vehCar).interface.activationType == "euro" then
					downOneStage()
				elseif getVehicleVCFInfo(vehCar).interface.activationType == "auto" then
					startStage3()
				else
					upOneStage()
				end
			end
		end
end, false)


RegisterCommand('+elsprimarylights', function()
	if exports.gcphone:isPhoneOpen() == true or exports.webcops.isKeyboardOpen() == true then
		return
	end

		local playerPed = GetPlayerPed(-1)
		local vehCar = GetVehiclePedIsUsing(playerPed)
		SetVehicleCanBeVisiblyDamaged(vehCar,false)

        if vehCar ~= nil and vehCar ~= 0 and not exports.esx_policejob:amicuffed() and vehInTable(els_Vehicles, checkCarHash(GetVehiclePedIsUsing(playerPed))) then
            if (GetPedInVehicleSeat(vehCar, -1) == playerPed) or
                (GetPedInVehicleSeat(vehCar, 0) == playerPed) then

				if playButtonPressSounds then
					PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
				end
				local vehn = VehToNet(vehCar)
				local vehm = GetEntityModel(vehCar)
				if elsVehs[vehCar] ~= nil then
					if elsVehs[vehCar].primary then
						TriggerServerEvent('363b16b3-76a4-4765-8bec-c96a4f2b10f0',vehn,vehm, "primary", false)
					else
						TriggerServerEvent('363b16b3-76a4-4765-8bec-c96a4f2b10f0',vehn,vehm, "primary", true)
					end
				else
					TriggerServerEvent('363b16b3-76a4-4765-8bec-c96a4f2b10f0',vehn,vehm,"primary", true)
				end
                       
			end
		end
end, false)

RegisterCommand('+elssecondarylights', function()
	if exports.gcphone:isPhoneOpen() == true or exports.webcops.isKeyboardOpen() == true then
		return
	end
		local playerPed = GetPlayerPed(-1)
		local vehCar = GetVehiclePedIsUsing(playerPed)

        if vehCar ~= nil and vehCar ~= 0 and not exports.esx_policejob:amicuffed() and vehInTable(els_Vehicles, checkCarHash(GetVehiclePedIsUsing(playerPed))) then
		
            if (GetPedInVehicleSeat(vehCar, -1) == playerPed) or
                (GetPedInVehicleSeat(vehCar, 0) == playerPed) then

				if playButtonPressSounds then
					PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
				end
				local vehn = VehToNet(vehCar)
				local vehm = GetEntityModel(vehCar)
				if vehn ~= nil and vehn ~= 0 then
					if elsVehs[vehCar] ~= nil then
						if elsVehs[vehCar].secondary then
							TriggerServerEvent('363b16b3-76a4-4765-8bec-c96a4f2b10f0',vehn,vehm, "secondary", false)
						else
							TriggerServerEvent('363b16b3-76a4-4765-8bec-c96a4f2b10f0',vehn,vehm, "secondary", true)
						end
					else
						TriggerServerEvent('363b16b3-76a4-4765-8bec-c96a4f2b10f0',vehn,vehm, "secondary", true)
					end
				end
			end
		end
end, false)


RegisterCommand('+elswarninglights', function()
	if exports.gcphone:isPhoneOpen() == true or exports.webcops.isKeyboardOpen() == true then
		return
	end
		local playerPed = GetPlayerPed(-1)
		local vehCar = GetVehiclePedIsUsing(playerPed)
		
        if vehCar ~= nil and vehCar ~= 0 and not exports.esx_policejob:amicuffed() and vehInTable(els_Vehicles, checkCarHash(GetVehiclePedIsUsing(playerPed))) then
			 if (GetPedInVehicleSeat(vehCar, -1) == playerPed) or
					(GetPedInVehicleSeat(vehCar, 0) == playerPed) then
				if playButtonPressSounds then
					PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
				end
				local vehn = VehToNet(vehCar)
				local vehm = GetEntityModel(vehCar)
				if vehn ~= nil and vehn ~= 0 then
					if elsVehs[vehCar] ~= nil then
						if elsVehs[vehCar].warning then
							TriggerServerEvent('363b16b3-76a4-4765-8bec-c96a4f2b10f0',vehn,vehm, "warning", false)
						else
							TriggerServerEvent('363b16b3-76a4-4765-8bec-c96a4f2b10f0',vehn,vehm, "warning", true)
						end
					else
						TriggerServerEvent('363b16b3-76a4-4765-8bec-c96a4f2b10f0',vehn,vehm, "warning", true)
					end
				end
			end
		end
						
end, false)


RegisterCommand('+elsmainsirenbb1', function()
	if exports.gcphone:isPhoneOpen() == true or exports.webcops.isKeyboardOpen() == true then
		return
	end
	local playerPed = GetPlayerPed(-1)
	local vehCar = GetVehiclePedIsUsing(playerPed)

	if vehCar ~= nil and vehCar ~= 0 and not exports.esx_policejob:amicuffed() and vehInTable(els_Vehicles, checkCarHash(GetVehiclePedIsUsing(playerPed))) then
		 if (GetPedInVehicleSeat(vehCar, -1) == playerPed) or
                (GetPedInVehicleSeat(vehCar, 0) == playerPed) then
			if GetVehicleClass(vehCar) == 18 then
				if (elsVehs[vehCar] ~= nil) then
				   if elsVehs[vehCar].stage == 3 or elsVehs[vehCar].stage ~= 2 then
						--LG
					
						setSirenStateButton(vehCar,1)
				

					end
					
					if elsVehs[vehCar].stage == 2 then

						
						if playButtonPressSounds then
							PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
						end
						TriggerServerEvent('8cb4f054-3dfc-454f-b32f-b6adc5f0ce74',vehCarNet, 1)

					end
				end
			end
		end
	end
end,false)

RegisterCommand('+elssiren1', function()
	if exports.gcphone:isPhoneOpen() == true or exports.webcops.isKeyboardOpen() == true then
		return
	end
	local playerPed = GetPlayerPed(-1)
	local vehCar = GetVehiclePedIsUsing(playerPed)

	if vehCar ~= nil and vehCar ~= 0 and not exports.esx_policejob:amicuffed() and vehInTable(els_Vehicles, checkCarHash(GetVehiclePedIsUsing(playerPed))) then
		 if (GetPedInVehicleSeat(vehCar, -1) == playerPed) or
                (GetPedInVehicleSeat(vehCar, 0) == playerPed) then
			if GetVehicleClass(vehCar) == 18 then
				if (elsVehs[vehCar] ~= nil) then
					if elsVehs[vehCar].stage == 3 or elsVehs[vehCar].stage ~= 2 then
						--LG
						setSirenStateButton(vehCar,1)
					

					end
					
					if elsVehs[vehCar].stage == 2 then

						if playButtonPressSounds then
							PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
						end
						TriggerServerEvent('8cb4f054-3dfc-454f-b32f-b6adc5f0ce74',vehCarNet, 1)

					end
				end
			end
		end
	end
end,false)


RegisterCommand('+elssiren2', function()
	if exports.gcphone:isPhoneOpen() == true or exports.webcops.isKeyboardOpen() == true then
		return
	end
	local playerPed = GetPlayerPed(-1)
	local vehCar = GetVehiclePedIsUsing(playerPed)

	if vehCar ~= nil and vehCar ~= 0 and not exports.esx_policejob:amicuffed() and vehInTable(els_Vehicles, checkCarHash(GetVehiclePedIsUsing(playerPed))) then
		 if (GetPedInVehicleSeat(vehCar, -1) == playerPed) or
                (GetPedInVehicleSeat(vehCar, 0) == playerPed) then
			if GetVehicleClass(vehCar) == 18 then
				if (elsVehs[vehCar] ~= nil) then
				   if elsVehs[vehCar].stage == 3 or elsVehs[vehCar].stage ~= 2 then
						--LG

						setSirenStateButton(vehCar,2)
		

					end
					
					if elsVehs[vehCar].stage == 2 then

						
						if playButtonPressSounds then
							PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
						end
						TriggerServerEvent('8cb4f054-3dfc-454f-b32f-b6adc5f0ce74', vehCarNet , 2)
					

					end
				end
			end
		end
	end
end,false)

RegisterCommand('+elssiren3', function()
	if exports.gcphone:isPhoneOpen() == true or exports.webcops.isKeyboardOpen() == true then
		return
	end
	local playerPed = GetPlayerPed(-1)
	local vehCar = GetVehiclePedIsUsing(playerPed)

	if vehCar ~= nil and vehCar ~= 0 and not exports.esx_policejob:amicuffed() and vehInTable(els_Vehicles, checkCarHash(GetVehiclePedIsUsing(playerPed))) then
		if (GetPedInVehicleSeat(vehCar, -1) == playerPed) or
			(GetPedInVehicleSeat(vehCar, 0) == playerPed) then
			if GetVehicleClass(vehCar) == 18 then
				if (elsVehs[vehCar] ~= nil) then
				   if elsVehs[vehCar].stage == 3 or elsVehs[vehCar].stage ~= 2 then
						--LG

						setSirenStateButton(vehCar,3)


				  end
					
					if elsVehs[vehCar].stage == 2 then
						

						if playButtonPressSounds then
							PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
						end
						TriggerServerEvent('8cb4f054-3dfc-454f-b32f-b6adc5f0ce74',vehCarNet, 3)
				

					end
				end
			end
		end
	end
end,false)

RegisterCommand('+elssiren5', function()
	if exports.gcphone:isPhoneOpen() == true or exports.webcops.isKeyboardOpen() == true then
		return
	end
	local playerPed = GetPlayerPed(-1)
	local vehCar = GetVehiclePedIsUsing(playerPed)

	if vehCar ~= nil and vehCar ~= 0 and not exports.esx_policejob:amicuffed() and vehInTable(els_Vehicles, checkCarHash(GetVehiclePedIsUsing(playerPed))) then
		if (GetPedInVehicleSeat(vehCar, -1) == playerPed) or
             (GetPedInVehicleSeat(vehCar, 0) == playerPed) then
			if GetVehicleClass(vehCar) == 18 then
				if (elsVehs[vehCar] ~= nil) then
				   if elsVehs[vehCar].stage == 3 or elsVehs[vehCar].stage ~= 2 then
						--LG
							setSirenStateButton(vehCar,4)
				  end
					
					if elsVehs[vehCar].stage == 2 then
						
					
						if playButtonPressSounds then
							PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
						end
						TriggerServerEvent('8cb4f054-3dfc-454f-b32f-b6adc5f0ce74',vehCarNet, 4)
					
					end
				end
			end
		end
	end
end,false)

RegisterKeyMapping('+elscruiselights', 'ELS Cruise Lights Toggle', 'keyboard', 'i')
RegisterKeyMapping('+elstakedownlights', 'ELS Takedown Lights', 'keyboard', 'j')
RegisterKeyMapping('+elslightstage', 'ELS Light Stage', 'keyboard', 'q')
RegisterKeyMapping('+elsprimarylights', 'ELS Primary Lights', 'keyboard', 'l')
RegisterKeyMapping('+elssecondarylights', 'ELS Secondary Lights', 'keyboard', 'delete')
RegisterKeyMapping('+elswarninglights', 'ELS Warning Lights', 'keyboard', 'CAPITAL')
RegisterKeyMapping('+elssiren1', 'ELS Siren Tone 1', 'keyboard', '1')
RegisterKeyMapping('+elssiren2', 'ELS Siren Tone 2', 'keyboard', '2')
RegisterKeyMapping('+elssiren3', 'ELS Siren Tone 3', 'keyboard', '3')
RegisterKeyMapping('+elssiren5', 'ELS Siren Tone 4', 'keyboard', '5')
RegisterKeyMapping('+elsmainsirenbb1', 'ELS Main Siren', 'keyboard', 'b')

RegisterKeyMapping('+elsmainsirenbb1', 'ELS Main Siren', 'controller', 'b')


local myPed = GetPlayerPed(-1)
local vehCar = 0
local vehClass = 0
local inDriversSeat = nil
local inPassengerSeat = nil


Citizen.CreateThread(function()

	while true do
		myPed = GetPlayerPed(-1)
		vehCar = GetVehiclePedIsIn(myPed)
		myCurrentLocation = GetEntityCoords(myPed)
		if vehCar > 0 then
			vehClass = GetVehicleClass(vehCar)
			inDriversSeat = GetPedInVehicleSeat(vehCar, -1)
			inPassengerSeat = GetPedInVehicleSeat(vehCar, 0)
		else
			inDriversSeat = nil
			inPassengerSeat = nil
			vehClass = 0
		end
		Wait(500)
	end

end)

Citizen.CreateThread(function()
	
	Wait(math.random(100,4000))
    --TriggerServerEvent("els:requestVehiclesUpdate")
	
    while true do
		local playerPed = myPed


        if vehInTable(els_Vehicles, checkCarHash(vehCar)) then
            if (inDriversSeat and inDriversSeat == playerPed) or (inPassengerSeat and inPassengerSeat == playerPed) then

                if GetVehicleClass(vehCar) == 18 then
                    DisableControlAction(0, shared.horn, true)
                end
                
                --DisableControlAction(0, 84, true) -- INPUT_VEH_PREV_RADIO_TRACK  
                DisableControlAction(0, 83, true) -- INPUT_VEH_NEXT_RADIO_TRACK 
                DisableControlAction(0, 81, true) -- INPUT_VEH_NEXT_RADIO
                DisableControlAction(0, 82, true) -- INPUT_VEH_PREV_RADIO
                DisableControlAction(0, 85, true) -- INPUT_VEH_PREV_RADIO

                SetVehRadioStation(vehCar, "OFF")
                SetVehicleRadioEnabled(vehCar, false)

                if(GetLastInputMethod(0)) then
                    DisableControlAction(0, keyboard.stageChange, true)

					--DisableControlAction(0, keyboard.pattern.guiKey, true)
					DisableControlAction(0, keyboard.pattern.primary, true)
                    DisableControlAction(0, keyboard.pattern.secondary, true)
                    DisableControlAction(0, keyboard.pattern.advisor, true)
                    --DisableControlAction(0, keyboard.modifyKey, true)
					DisableControlAction(0, keyboard.siren.main, true)
                    DisableControlAction(0, keyboard.siren.tone_one, true)
                    DisableControlAction(0, keyboard.siren.tone_two, true)
                    DisableControlAction(0, keyboard.siren.tone_three, true)
					DisableControlAction(0, keyboard.rooflight, true)
	
					
					if IsDisabledControlPressed(0, keyboard.rooflight) then
						if GetConvertibleRoofState(vehCar) == 0 then
							LowerConvertibleRoof(vehCar, true)
						else
							RaiseConvertibleRoof(vehCar, true)
						end
					end

                    if IsControlPressed(0, keyboard.modifyKey) then

                        if IsDisabledControlJustReleased(0, keyboard.primary) then
                            if playButtonPressSounds then
                                PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                            end
                            if panelEnabled then
                                panelEnabled = false
                            else
                                panelEnabled = true
                            end
                        end


                        --[[if IsDisabledControlJustReleased(0, keyboard.takedown) then
                            if playButtonPressSounds then
                                PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                            end
                            TriggerServerEvent('aa7dff5e-60e2-4c30-87d8-e3cff82e70b6')
                        end--]]
                    else
					
					end

                       --[[ if IsDisabledControlJustReleased(0, keyboard.takedown) then
                            if playButtonPressSounds then
                                PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                            end
                            TriggerServerEvent('a7e901fa-86b4-4707-90dd-e4b9048dabbe')
                        end
                        if IsDisabledControlJustReleased(0, keyboard.cruise) then
                            if playButtonPressSounds then
                                PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                            end
                            TriggerServerEvent('63ee0e3c-aa7d-4a97-825f-2d8159e7e871')
                        end
                        if IsDisabledControlJustReleased(0, keyboard.warning) then
                            if playButtonPressSounds then
                                PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                            end
							local vehn = VehToNet(vehCar)
							local vehm = GetEntityModel(vehCar)
							if vehn ~= nil and vehn ~= 0 then
								if elsVehs[vehCar] ~= nil then
									if elsVehs[vehCar].warning then
										TriggerServerEvent('363b16b3-76a4-4765-8bec-c96a4f2b10f0',vehn,vehm, "warning", false)
									else
										TriggerServerEvent('363b16b3-76a4-4765-8bec-c96a4f2b10f0',vehn,vehm, "warning", true)
									end
								else
									TriggerServerEvent('363b16b3-76a4-4765-8bec-c96a4f2b10f0',vehn,vehm, "warning", true)
								end
							end
                        endd
						
                        if IsDisabledControlJustReleased(0, keyboard.secondary) then
                            if playButtonPressSounds then
                                PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                            end
							local vehn = VehToNet(vehCar)
							local vehm = GetEntityModel(vehCar)
							if vehn ~= nil and vehn ~= 0 then
								if elsVehs[vehCar] ~= nil then
									if elsVehs[vehCar].secondary then
										TriggerServerEvent('363b16b3-76a4-4765-8bec-c96a4f2b10f0',vehn,vehm, "secondary", false)
									else
										TriggerServerEvent('363b16b3-76a4-4765-8bec-c96a4f2b10f0',vehn,vehm, "secondary", true)
									end
								else
									TriggerServerEvent('363b16b3-76a4-4765-8bec-c96a4f2b10f0',vehn,vehm, "secondary", true)
								end
							end
                        end
                        if IsDisabledControlJustPressed(0, keyboard.primary) then
                            if playButtonPressSounds then
                                PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                            end
							local vehn = VehToNet(vehCar)
							local vehm = GetEntityModel(vehCar)
                            if elsVehs[vehCar] ~= nil then
                                if elsVehs[vehCar].primary then
                                    TriggerServerEvent('363b16b3-76a4-4765-8bec-c96a4f2b10f0',vehn,vehm, "primary", false)
                                else
                                    TriggerServerEvent('363b16b3-76a4-4765-8bec-c96a4f2b10f0',vehn,vehm, "primary", true)
                                end
                            else
                                TriggerServerEvent('363b16b3-76a4-4765-8bec-c96a4f2b10f0',vehn,vehm,"primary", true)
                            end
                        end
                    end	
					--]]

                    

                else
                    DisableControlAction(0, controller.modifyKey, true)
                    DisableControlAction(0, controller.stageChange, true)
                    DisableControlAction(0, controller.siren.tone_one, true)
					DisableControlAction(0, controller.siren.main, true)
                    DisableControlAction(0, controller.siren.tone_two, true)
                    DisableControlAction(0, controller.siren.tone_three, true)

                    if els_Vehicles[checkCarHash(vehCar)].activateUp then
                        if IsDisabledControlPressed(0, controller.modifyKey) and IsDisabledControlJustReleased(0, controller.stageChange) then
						
					
							startStage3()
                           -- downOneStage()
                        elseif IsDisabledControlJustReleased(0, controller.stageChange) then
						
                            upOneStage()
                        end
                    else
                        if IsDisabledControlJustReleased(0, controller.stageChange) then
                            
							startStage3()
							--downOneStage()
                        elseif IsDisabledControlPressed(0, controller.modifyKey) and IsDisabledControlJustReleased(0, controller.stageChange) then
                            upOneStage()
                        end
                    end
					--[[
                    if IsDisabledControlPressed(0, controller.modifyKey) then
                        DisableControlAction(0, controller.takedown, true)
                        if IsDisabledControlPressed(0, controller.modifyKey) and IsDisabledControlJustReleased(0, controller.takedown) then
                            if playButtonPressSounds then
                                PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                            end
                            TriggerServerEvent('a7e901fa-86b4-4707-90dd-e4b9048dabbe')
                        end
                    end --]]

                   if GetVehicleClass(vehCar) == 18 then
                        if (elsVehs[vehCar] ~= nil) then
                            if elsVehs[vehCar].stage == 3 or elsVehs[vehCar].stage == 0 or elsVehs[vehCar].stage == 0  then
                                if not IsDisabledControlPressed(0, controller.modifyKey) then
                                   --LG
								   if IsDisabledControlJustReleased(0, controller.siren.main) then
                                        setSirenStateButton(vehCar,1)
                                    end                                   

								   if IsDisabledControlJustReleased(0, controller.siren.tone_one) then
                                        setSirenStateButton(vehCar,1)
                                    end
                                    if IsDisabledControlJustReleased(0, controller.siren.tone_two) then
                                        setSirenStateButton(vehCar,2)
                                    end
                                    if IsDisabledControlJustReleased(0, controller.siren.tone_three) then
                                        setSirenStateButton(vehCar,3)
                                    end
									if IsDisabledControlJustReleased(0, controller.siren.tone_four) then
                                        setSirenStateButton(vehCar,4)
                                    end
									
                                end

                            end
                            if elsVehs[vehCar].stage == 2 then
                                if IsDisabledControlJustReleased(0, controller.siren.tone_one) then
                                    if playButtonPressSounds then
                                        PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                                    end
                                    TriggerServerEvent('8cb4f054-3dfc-454f-b32f-b6adc5f0ce74', vehCarNet, 0)
                                end
                                if IsDisabledControlJustPressed(0, controller.siren.tone_one) then
                                    if playButtonPressSounds then
                                        PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                                    end
                                    TriggerServerEvent('8cb4f054-3dfc-454f-b32f-b6adc5f0ce74', vehCarNet, 1)
                                end

                                if IsDisabledControlJustReleased(0, controller.siren.tone_two) then
                                    if playButtonPressSounds then
                                        PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                                    end
                                    TriggerServerEvent('8cb4f054-3dfc-454f-b32f-b6adc5f0ce74', vehCarNet, 0)
                                end
								
								if IsDisabledControlJustPressed(0, controller.siren.main) then
                                    if playButtonPressSounds then
                                        PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                                    end
                                    TriggerServerEvent('8cb4f054-3dfc-454f-b32f-b6adc5f0ce74', vehCarNet, 1)
                                end

                                if IsDisabledControlJustReleased(0, controller.siren.main) then
                                    if playButtonPressSounds then
                                        PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                                    end
                                    TriggerServerEvent('8cb4f054-3dfc-454f-b32f-b6adc5f0ce74', vehCarNet, 0)
                                end
                                if IsDisabledControlJustPressed(0, controller.siren.tone_two) then
                                    if playButtonPressSounds then
                                        PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                                    end
                                    TriggerServerEvent('8cb4f054-3dfc-454f-b32f-b6adc5f0ce74', vehCarNet, 2)
                                end

                                if IsDisabledControlJustReleased(0, controller.siren.tone_three) then
                                    if playButtonPressSounds then
                                        PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                                    end
                                    TriggerServerEvent('8cb4f054-3dfc-454f-b32f-b6adc5f0ce74', vehCarNet, 0)
                                end
								
                                if IsDisabledControlJustPressed(0, controller.siren.tone_three) then
                                    if playButtonPressSounds then
                                        PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                                    end
                                    TriggerServerEvent('8cb4f054-3dfc-454f-b32f-b6adc5f0ce74', vehCarNet, 3)
                                end
								
								
								
                                if IsDisabledControlJustReleased(0, controller.siren.tone_four) then
                                    if playButtonPressSounds then
                                        PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                                    end
                                    TriggerServerEvent('8cb4f054-3dfc-454f-b32f-b6adc5f0ce74',vehCarNet, 0)
                                end
								
                                if IsDisabledControlJustPressed(0, controller.siren.tone_four) then
                                    if playButtonPressSounds then
                                        PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                                    end
                                    TriggerServerEvent('8cb4f054-3dfc-454f-b32f-b6adc5f0ce74', vehCarNet, 4)
                                end
                            end
                        end
                    end
                end
				
                if vehClass == 18 then
                    if not IsDisabledControlPressed(0, controller.modifyKey) then
                        if (IsDisabledControlJustPressed(0, shared.horn)) then
							if exports.gcphone:isPhoneOpen() == true or exports.webcops.isKeyboardOpen() == true then
							else
								TriggerServerEvent('bf8ec549-c05d-4c1d-bd89-c63fb6a3ac31', 1)
							end
                            
                        end

                        if (IsDisabledControlJustReleased(0, shared.horn)) then
							if exports.gcphone:isPhoneOpen() == true or exports.webcops.isKeyboardOpen() == true then
							else
								TriggerServerEvent('bf8ec549-c05d-4c1d-bd89-c63fb6a3ac31', 0)
							end
                        end
                    end
                end
			else
				Wait(500)
            end
		else
			Wait(500)
        end

        Citizen.Wait(5)
    end
end)



Citizen.CreateThread(function()
    while true do
		local playerPed = myPed
        if vehInTable(els_Vehicles, checkCarHash(vehCar)) then
            if (GetPedInVehicleSeat(vehCar, -1) == playerPed) or
                (GetPedInVehicleSeat(vehCar, 0) == playerPed) then

                if IsControlPressed(0, keyboard.modifyKey) then
                    if IsDisabledControlPressed(0, keyboard.pattern.primary) then
                        if playButtonPressSounds then
                            PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                        end
						local vehn = VehToNet(vehCar)
						local vehm = GetEntityModel(vehCar)
						if vehn ~= nil and vehn ~= 0 then
							changePrimaryPatternMath(vehn,-1)
						end
                    end
                    if IsDisabledControlPressed(0, keyboard.pattern.secondary) then
                        if playButtonPressSounds then
                            PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                        end
						local vehn = VehToNet(vehCar)
						local vehm = GetEntityModel(vehCar)
						if vehn ~= nil and vehn ~= 0 then
							changeSecondaryPatternMath(vehn,-1)
						end
                    end
                    if IsDisabledControlPressed(0, keyboard.pattern.advisor) then
                        if playButtonPressSounds then
                            PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                        end
						local vehn = VehToNet(vehCar)
						local vehm = GetEntityModel(vehCar)
						if vehn ~= nil and vehn ~= 0 then
							changeAdvisorPatternMath(vehn,-1)
						end
                    end
                else
                    if IsDisabledControlPressed(0, keyboard.pattern.primary) then
                        if playButtonPressSounds then
                            PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                        end
						local vehn = VehToNet(vehCar)
						local vehm = GetEntityModel(vehCar)
						if vehn ~= nil and vehn ~= 0 then
							changePrimaryPatternMath(vehn,1)
						end
                    end
                    if IsDisabledControlPressed(0, keyboard.pattern.secondary) then
                        if playButtonPressSounds then
                            PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                        end
						local vehn = VehToNet(vehCar)
						local vehm = GetEntityModel(vehCar)
						if vehn ~= nil and vehn ~= 0 then
							changeSecondaryPatternMath(vehn,1)
						end
                    end
                    if IsDisabledControlPressed(0, keyboard.pattern.advisor) then
                        if playButtonPressSounds then
                            PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
                        end
						local vehn = VehToNet(vehCar)
						local vehm = GetEntityModel(vehCar)
						if vehn ~= nil and vehn ~= 0 then
							changeAdvisorPatternMath(vehn,1)
						end
                    end
                end
            end
		else
			Wait(500)
        end
        Wait(30)
    end
end)

panelEnabled = false
--[[
Citizen.CreateThread(function()
    while true do
		if elsstopprocess == false then
			if panelOffsetX ~= nil and panelOffsetY ~= nil then
			local playerPed = GetPlayerPed(-1)
			local vehCar = GetVehiclePedIsUsing(playerPed)
				if panelEnabled and vehInTable(els_Vehicles, checkCarHash(vehCar)) then
					if (GetPedInVehicleSeat(vehCar, -1) == playerPed) or
						(GetPedInVehicleSeat(vehCar, 0) == playerPed) then
						local vehN = GetVehiclePedIsUsing(playerPed)

						if (panelType == "original") then
							_DrawRect(0.85 + panelOffsetX, 0.89 + panelOffsetY, 0.26, 0.16, 16, 16, 16, 225, 0)
						
							_DrawRect(0.85 + panelOffsetX, 0.835 + panelOffsetY, 0.245, 0.035, 0, 0, 0, 225, 0)
							_DrawRect(0.85 + panelOffsetX, 0.835 + panelOffsetY, 0.24, 0.03, getVehicleVCFInfo(vehN).interface.headerColor.r, getVehicleVCFInfo(vehN).interface.headerColor.g, getVehicleVCFInfo(vehN).interface.headerColor.b, 225, 0)
							Draw("MAIN", 0, 0, 0, 255, 0.745 + panelOffsetX, 0.825 + panelOffsetY, 0.25, 0.25, 1, true, 0)
							Draw("MRDAGREE SYSTEMS", 0, 0, 0, 255, 0.92 + panelOffsetX, 0.825 + panelOffsetY, 0.25, 0.25, 1, true, 0)


							_DrawRect(0.78 + panelOffsetX, 0.835 + panelOffsetY, 0.033, 0.025, 0, 0, 0, 225, 0)
							if (getVehicleLightStage(vehN) == 1) then
								_DrawRect(0.78 + panelOffsetX, 0.835 + panelOffsetY, 0.03, 0.02, getVehicleVCFInfo(vehN).interface.buttonColor.r, getVehicleVCFInfo(vehN).interface.buttonColor.g, getVehicleVCFInfo(vehN).interface.buttonColor.b, 225, 0)
								Draw("S-1", 0, 0, 0, 255, 0.78 + panelOffsetX, 0.825 + panelOffsetY, 0.25, 0.25, 1, true, 0)
							else
								_DrawRect(0.78 + panelOffsetX, 0.835 + panelOffsetY, 0.03, 0.02, 186, 186, 186, 225, 0)
								Draw("S-1", 0, 0, 0, 255, 0.78 + panelOffsetX, 0.825 + panelOffsetY, 0.25, 0.25, 1, true, 0)
							end

							_DrawRect(0.815 + panelOffsetX, 0.835 + panelOffsetY, 0.033, 0.025, 0, 0, 0, 225, 0)
							if (getVehicleLightStage(vehN) == 2) then
								_DrawRect(0.815 + panelOffsetX, 0.835 + panelOffsetY, 0.03, 0.02, getVehicleVCFInfo(vehN).interface.buttonColor.r, getVehicleVCFInfo(vehN).interface.buttonColor.g, getVehicleVCFInfo(vehN).interface.buttonColor.b, 225, 0)
								Draw("S-2", 0, 0, 0, 255, 0.815 + panelOffsetX, 0.825 + panelOffsetY, 0.25, 0.25, 1, true, 0)
							else
								_DrawRect(0.815 + panelOffsetX, 0.835 + panelOffsetY, 0.03, 0.02, 186, 186, 186, 225, 0)
								Draw("S-2", 0, 0, 0, 255, 0.815 + panelOffsetX, 0.825 + panelOffsetY, 0.25, 0.25, 1, true, 0)
							end

							_DrawRect(0.850 + panelOffsetX, 0.835 + panelOffsetY, 0.033, 0.025, 0, 0, 0, 225, 0)
							if (getVehicleLightStage(vehN) == 3) then
								_DrawRect(0.850 + panelOffsetX, 0.835 + panelOffsetY, 0.03, 0.02, getVehicleVCFInfo(vehN).interface.buttonColor.r, getVehicleVCFInfo(vehN).interface.buttonColor.g, getVehicleVCFInfo(vehN).interface.buttonColor.b, 225, 0)
								Draw("S-3", 0, 0, 0, 255, 0.850 + panelOffsetX, 0.825 + panelOffsetY, 0.25, 0.25, 1, true, 0)
							else
								_DrawRect(0.850 + panelOffsetX, 0.835 + panelOffsetY, 0.03, 0.02, 186, 186, 186, 225, 0)
								Draw("S-3", 0, 0, 0, 255, 0.850 + panelOffsetX, 0.825 + panelOffsetY, 0.25, 0.25, 1, true, 0)
							end



							_DrawRect(0.742 + panelOffsetX, 0.88 + panelOffsetY, 0.028, 0.045, 0, 0, 0, 225, 0)
							if elsVehs[vehN] ~= nil then
								if elsVehs[GetVehiclePedIsUsing(GetPlayerPed(-1))].warning then
									_DrawRect(0.7421 + panelOffsetX, 0.871 + panelOffsetY, 0.026, 0.02, getVehicleVCFInfo(vehN).interface.buttonColor.r, getVehicleVCFInfo(vehN).interface.buttonColor.g, getVehicleVCFInfo(vehN).interface.buttonColor.b, 225, 0)
									Draw("E-" .. formatPatternNumber(advisorPatternSelectedIndex), getVehicleVCFInfo(vehN).interface.buttonColor.r, getVehicleVCFInfo(vehN).interface.buttonColor.g, getVehicleVCFInfo(vehN).interface.buttonColor.b, 255, 0.7423 + panelOffsetX, 0.88 + panelOffsetY, 0.25, 0.25, 1, true, 0)
								else
									_DrawRect(0.7421 + panelOffsetX, 0.871 + panelOffsetY, 0.026, 0.02, 186, 186, 186, 225, 0)
									Draw("E-" .. formatPatternNumber(advisorPatternSelectedIndex), 255, 255, 255, 255, 0.7423 + panelOffsetX, 0.88 + panelOffsetY, 0.25, 0.25, 1, true, 0)
								end
							else
								_DrawRect(0.7421 + panelOffsetX, 0.871 + panelOffsetY, 0.026, 0.02, 186, 186, 186, 225, 0)
								Draw("E-" .. formatPatternNumber(advisorPatternSelectedIndex), 255, 255, 255, 255, 0.7423 + panelOffsetX, 0.88 + panelOffsetY, 0.25, 0.25, 1, true, 0)
							end
							Draw("WRN", 0, 0, 0, 255, 0.7423 + panelOffsetX, 0.86 + panelOffsetY, 0.25, 0.25, 1, true, 0)

							_DrawRect(0.774 + panelOffsetX, 0.88 + panelOffsetY, 0.028, 0.045, 0, 0, 0, 225, 0)
							if elsVehs[vehN] ~= nil then
								if elsVehs[vehN].secondary then
									_DrawRect(0.774 + panelOffsetX, 0.871 + panelOffsetY, 0.025, 0.02, getVehicleVCFInfo(vehN).interface.buttonColor.r, getVehicleVCFInfo(vehN).interface.buttonColor.g, getVehicleVCFInfo(vehN).interface.buttonColor.b, 225, 0)
									Draw("E-" .. formatPatternNumber(lightPatternSec), getVehicleVCFInfo(vehN).interface.buttonColor.r, getVehicleVCFInfo(vehN).interface.buttonColor.g, getVehicleVCFInfo(vehN).interface.buttonColor.b, 255, 0.774 + panelOffsetX, 0.88 + panelOffsetY, 0.25, 0.25, 1, true, 0)
								else
									_DrawRect(0.774 + panelOffsetX, 0.871 + panelOffsetY, 0.025, 0.02, 186, 186, 186, 225, 0)
									Draw("E-" .. formatPatternNumber(lightPatternSec), 255, 255, 255, 255, 0.774 + panelOffsetX, 0.88 + panelOffsetY, 0.25, 0.25, 1, true, 0)
								end
							else
								_DrawRect(0.774 + panelOffsetX, 0.871 + panelOffsetY, 0.025, 0.02, 186, 186, 186, 225, 0)
								Draw("E-" .. formatPatternNumber(lightPatternSec), 255, 255, 255, 255, 0.774 + panelOffsetX, 0.88 + panelOffsetY, 0.25, 0.25, 1, true, 0)
							end
							Draw("SEC", 0, 0, 0, 255, 0.774 + panelOffsetX, 0.86 + panelOffsetY, 0.25, 0.25, 1, true, 0)

							_DrawRect(0.806 + panelOffsetX, 0.88 + panelOffsetY, 0.028, 0.045, 0, 0, 0, 225, 0)
							if elsVehs[vehN] ~= nil then
								if elsVehs[GetVehiclePedIsUsing(GetPlayerPed(-1))].primary then
									_DrawRect(0.806 + panelOffsetX, 0.871 + panelOffsetY, 0.025, 0.02, getVehicleVCFInfo(vehN).interface.buttonColor.r, getVehicleVCFInfo(vehN).interface.buttonColor.g, getVehicleVCFInfo(vehN).interface.buttonColor.b, 225, 0)
									Draw("E-" .. formatPatternNumber(lightPatternPrim), getVehicleVCFInfo(vehN).interface.buttonColor.r, getVehicleVCFInfo(vehN).interface.buttonColor.g, getVehicleVCFInfo(vehN).interface.buttonColor.b, 255, 0.806 + panelOffsetX, 0.88 + panelOffsetY, 0.25, 0.25, 1, true, 0)
								else
									_DrawRect(0.806 + panelOffsetX, 0.871 + panelOffsetY, 0.025, 0.02, 186, 186, 186, 225, 0)
									Draw("E-" .. formatPatternNumber(lightPatternPrim), 255, 255, 255, 255, 0.806 + panelOffsetX, 0.88 + panelOffsetY, 0.25, 0.25, 1, true, 0)
								end
							else
								_DrawRect(0.806 + panelOffsetX, 0.871 + panelOffsetY, 0.025, 0.02, 186, 186, 186, 225, 0)
								Draw("E-" .. formatPatternNumber(lightPatternPrim), 255, 255, 255, 255, 0.806 + panelOffsetX, 0.88 + panelOffsetY, 0.25, 0.25, 1, true, 0)
							end
							Draw("PRIM", 0, 0, 0, 255, 0.806 + panelOffsetX, 0.86 + panelOffsetY, 0.25, 0.25, 1, true, 0)

							_DrawRect(0.742 + panelOffsetX, 0.93 + panelOffsetY, 0.028, 0.045, 0, 0, 0, 225, 0)
							_DrawRect(0.7421 + panelOffsetX, 0.921 + panelOffsetY, 0.026, 0.02, 186, 186, 186, 225, 0)
							Draw("--", 255, 255, 255, 255, 0.7423 + panelOffsetX, 0.93 + panelOffsetY, 0.25, 0.25, 1, true, 0)
							Draw("HRN", 0, 0, 0, 255, 0.7423 + panelOffsetX, 0.91 + panelOffsetY, 0.25, 0.25, 1, true, 0)


							_DrawRect(0.86 + panelOffsetX, 0.911 + panelOffsetY, 0.06, 0.09, 0, 0, 0, 225, 0)

							if (IsVehicleExtraTurnedOn(GetVehiclePedIsUsing(GetPlayerPed(-1)), 11)) then
								_DrawRect(0.853 + panelOffsetX, 0.895 + panelOffsetY, 0.01, 0.005, 255, 255, 255, 225, 0)
								_DrawRect(0.866 + panelOffsetX, 0.895 + panelOffsetY, 0.01, 0.005, 255, 255, 255, 225, 0)
							else
								_DrawRect(0.853 + panelOffsetX, 0.895 + panelOffsetY, 0.01, 0.005, 54, 54, 54, 225, 0)
								_DrawRect(0.866 + panelOffsetX, 0.895 + panelOffsetY, 0.01, 0.005, 54, 54, 54, 225, 0)
							end

							_DrawRect(0.8365 + panelOffsetX, 0.9 + panelOffsetY, 0.0029, 0.015, 54, 54, 54, 225, 0)

							_DrawRect(0.882 + panelOffsetX, 0.9 + panelOffsetY, 0.0029, 0.015, 54, 54, 54, 225, 0)

							if(IsVehicleExtraTurnedOn(vehN, 7)) then
								_DrawRect(0.848 + panelOffsetX, 0.94 + panelOffsetY, 0.01, 0.015, getVehicleVCFInfo(vehN).extras[7].env_color.r, getVehicleVCFInfo(vehN).extras[7].env_color.g, getVehicleVCFInfo(vehN).extras[7].env_color.b, 225, 0)
							else
								_DrawRect(0.848 + panelOffsetX, 0.94 + panelOffsetY, 0.01, 0.015, 54, 54, 54, 225, 0)
							end

							if getVehicleVCFInfo(vehN).secl.type == "traf" or getVehicleVCFInfo(vehN).secl.type == "chp" then
								if(IsVehicleExtraTurnedOn(vehN, 8)) then
									_DrawRect(0.8598 + panelOffsetX, 0.94 + panelOffsetY, 0.01, 0.015, getVehicleVCFInfo(vehN).extras[8].env_color.r, getVehicleVCFInfo(vehN).extras[8].env_color.g, getVehicleVCFInfo(vehN).extras[8].env_color.b, 225, 0)
								else
									_DrawRect(0.8598 + panelOffsetX, 0.94 + panelOffsetY, 0.01, 0.015, 54, 54, 54, 225, 0)
								end
							end

							if(IsVehicleExtraTurnedOn(vehN, 9)) then
								_DrawRect(0.872 + panelOffsetX, 0.94 + panelOffsetY, 0.01, 0.015, getVehicleVCFInfo(vehN).extras[9].env_color.r, getVehicleVCFInfo(vehN).extras[9].env_color.g, getVehicleVCFInfo(vehN).extras[9].env_color.b, 225, 0)
							else
								_DrawRect(0.872 + panelOffsetX, 0.94 + panelOffsetY, 0.01, 0.015, 54, 54, 54, 225, 0)
							end

							if(IsVehicleExtraTurnedOn(vehN, 1)) then
								_DrawRect(0.84 + panelOffsetX, 0.92 + panelOffsetY, 0.01, 0.015, getVehicleVCFInfo(vehN).extras[1].env_color.r, getVehicleVCFInfo(vehN).extras[1].env_color.g, getVehicleVCFInfo(vehN).extras[1].env_color.b, 225, 0)
							else
								_DrawRect(0.84 + panelOffsetX, 0.92 + panelOffsetY, 0.01, 0.015, 54, 54, 54, 225, 0)
							end

							if(IsVehicleExtraTurnedOn(vehN, 2)) then
								_DrawRect(0.853 + panelOffsetX, 0.92 + panelOffsetY, 0.01, 0.015, getVehicleVCFInfo(vehN).extras[2].env_color.r, getVehicleVCFInfo(vehN).extras[2].env_color.g, getVehicleVCFInfo(vehN).extras[2].env_color.b, 225, 0)
							else
								_DrawRect(0.853 + panelOffsetX, 0.92 + panelOffsetY, 0.01, 0.015, 54, 54, 54, 225, 0)
							end

							if(IsVehicleExtraTurnedOn(vehN)) then
								_DrawRect(0.866 + panelOffsetX, 0.92 + panelOffsetY, 0.01, 0.015, getVehicleVCFInfo(vehN).extras[3].env_color.r, getVehicleVCFInfo(vehN).extras[3].env_color.g, getVehicleVCFInfo(vehN).extras[3].env_color.b, 225, 0)
							else
								_DrawRect(0.866 + panelOffsetX, 0.92 + panelOffsetY, 0.01, 0.015, 54, 54, 54, 225, 0)
							end

							if(IsVehicleExtraTurnedOn(vehN)) then
								_DrawRect(0.879 + panelOffsetX, 0.92 + panelOffsetY, 0.01, 0.015, getVehicleVCFInfo(vehN).extras[4].env_color.r, getVehicleVCFInfo(vehN).extras[4].env_color.g, getVehicleVCFInfo(vehN).extras[4].env_color.b, 225, 0)
							else
								_DrawRect(0.879 + panelOffsetX, 0.92 + panelOffsetY, 0.01, 0.015, 54, 54, 54, 225, 0)
							end

							if(IsVehicleExtraTurnedOn(vehN)) then
								_DrawRect(0.853 + panelOffsetX, 0.88 + panelOffsetY, 0.01, 0.015, getVehicleVCFInfo(vehN).extras[5].env_color.r, getVehicleVCFInfo(vehN).extras[5].env_color.g, getVehicleVCFInfo(vehN).extras[5].env_color.b, 225, 0)
							else
								_DrawRect(0.853 + panelOffsetX, 0.88 + panelOffsetY, 0.01, 0.015, 54, 54, 54, 225, 0)
							end

							if(IsVehicleExtraTurnedOn(vehN)) then
								_DrawRect(0.866 + panelOffsetX, 0.88 + panelOffsetY, 0.01, 0.015, getVehicleVCFInfo(vehN).extras[6].env_color.r, getVehicleVCFInfo(vehN).extras[6].env_color.g, getVehicleVCFInfo(vehN).extras[6].env_color.b, 225, 0)
							else
								_DrawRect(0.866 + panelOffsetX, 0.88 + panelOffsetY, 0.01, 0.015, 54, 54, 54, 225, 0)
							end


							_DrawRect(0.91 + panelOffsetX, 0.94 + panelOffsetY, 0.024, 0.023, 0, 0, 0, 225, 0)
							if elsVehs[vehN] ~= nil then
								if elsVehs[vehN].cruise then
									_DrawRect(0.91 + panelOffsetX, 0.94 + panelOffsetY, 0.022, 0.02, getVehicleVCFInfo(vehN).interface.buttonColor.r, getVehicleVCFInfo(vehN).interface.buttonColor.g, getVehicleVCFInfo(vehN).interface.buttonColor.b, 225, 0)
								else
									_DrawRect(0.91 + panelOffsetX, 0.94 + panelOffsetY, 0.022, 0.02, 186, 186, 186, 225, 0)
								end
							else
								_DrawRect(0.91 + panelOffsetX, 0.94 + panelOffsetY, 0.0215, 0.02, 186, 186, 186, 225, 0)
							end
							Draw("CRS", 0, 0, 0, 255, 0.91 + panelOffsetX, 0.93 + panelOffsetY, 0.25, 0.25, 1, true, 0)

							_DrawRect(0.935 + panelOffsetX, 0.94 + panelOffsetY, 0.024, 0.023, 0, 0, 0, 225, 0)
							if IsVehicleExtraTurnedOn(vehN, 11) then
								_DrawRect(0.935 + panelOffsetX, 0.94 + panelOffsetY, 0.022, 0.02, getVehicleVCFInfo(vehN).interface.buttonColor.r, getVehicleVCFInfo(vehN).interface.buttonColor.g, getVehicleVCFInfo(vehN).interface.buttonColor.b, 225, 0)
							else
								_DrawRect(0.935 + panelOffsetX, 0.94 + panelOffsetY, 0.0215, 0.02, 186, 186, 186, 225, 0)
							end
							Draw("TKD", 0, 0, 0, 255, 0.935 + panelOffsetX, 0.93 + panelOffsetY, 0.25, 0.25, 1, true, 0)

							_DrawRect(0.96 + panelOffsetX, 0.94 + panelOffsetY, 0.024, 0.023, 0, 0, 0, 225, 0)
							if IsVehicleExtraTurnedOn(vehN, 12) then
								_DrawRect(0.96 + panelOffsetX, 0.94 + panelOffsetY, 0.022, 0.02, getVehicleVCFInfo(vehN).interface.buttonColor.r, getVehicleVCFInfo(vehN).interface.buttonColor.g, getVehicleVCFInfo(vehN).interface.buttonColor.b, 225, 0)
							else
								_DrawRect(0.96 + panelOffsetX, 0.94 + panelOffsetY, 0.0215, 0.02, 186, 186, 186, 225, 0)
							end
							Draw("SCL", 0, 0, 0, 255, 0.96 + panelOffsetX, 0.93 + panelOffsetY, 0.25, 0.25, 1, true, 0)
						elseif panelType == "fedsigss" then

						end
					end
				end
			end
		else
			Wait(2000)
		end
		Wait(4)
    end
end) --]]

-- Citizen.CreateThread(function()

--     while true do
--         LghtSoundCleaner()

--         Wait(800)
--     end
-- end)

Citizen.CreateThread(function()
	while true do
		if vehiclesInSyncDistance > 3 then
			lightDelay = lightDelayB + math.floor(vehiclesInSyncDistance * lightIncreaseB)
			lightDelayC = lightDelayB + vehiclesInSyncDistance
		else
			lightDelay = lightDelayB
			lightDelayC = lightDelayB
		end
		--print('vehiclesInSyncDistance : ' .. vehiclesInSyncDistance)
		Wait(1000 * 5)
	end
end)


Citizen.CreateThread(function()
	while true do
		--print('rerouted the ELS variables')
		local tmpN = {}
		
		for k,v in pairs(elsVehsN) do
			if v ~= nil then
				tmpN[k] = v
			end
		end
		elsVehsN = tmpN
		local tmpV = {}
		for k,v in pairs(elsVehs) do
			if v ~= nil then
				tmpV[k] = v
			end
		end
		elsVehs = tmpV
	
	
		Wait(1000 * 60)

	end
end)


Citizen.CreateThread(function()
	while true do
		local GT = GetGameTimer()
		if lastloopnet < GT - 18000  then
			 primaryc()
			 print('loop died starting lastloopnet')
		end
		Wait(100)
		if lastloopprom < GT - 3000 then
			primaryb()
			--print('loop died starting primaryb')
		end
		Wait(100)
		if lastloopmain < GT - 3000 then
			--print('loop died starting primarya')
			primarya()
		end
		Wait(100)
		if lastloopnetq < GT - 120000 then
			--print('loop died starting lastloopnetq')
			primarycc()
		end
		Wait(2000)
	end
end)

local minspacingper = 300
local minwaitspaceper = 3500


RegisterCommand('elsminper', function(source, args, rawCommand)
	if args ~= nil and args[1] ~= nil then
		minspacingper = args[1]
	end
end)

RegisterCommand('elsminwait', function()
	if args ~= nil and args[1] ~= nil then
		minwaitspaceper = args[1]
	end
end)

function primaryc()
	Citizen.CreateThread(function()
		while true do
			lastloopnet = GetGameTimer()

			 for k,v in pairs(elsVehsN) do
				Citizen.CreateThread(function()
				if v ~= nil then
					local kn 
					if elsVehsN_Local[k] == nil then
						--print('look up NET!!!!!!!!!!!!!!!!!!')
						if NetworkDoesNetworkIdExist(k) then
							kn = NetToVeh(k)
						else
							kn = 0
						end
					else
						--print('VARIABLE LOOK UP %%%%%%%%')
						kn = elsVehsN_Local[k]
					end
					if kn ~= 0 then
						---MAP IDS
						elsVehsL_Net[kn] = k
						elsVehsN_Local[k] = kn
						elsVehs[kn] = elsVehsN[k]
						
						if elsVehsNT[k] ~= nil then
							if elsVehsNS[k] ~= nil then
								TriggerEvent('ea2e9891-4d58-413c-9a18-ad028ce02649',k,0,elsVehsNS[k])
							end
						end
						elsVehsNT[k] = nil
						elsVehsNB[k] = nil
	
					else
						if elsVehsNT[k] == nil then
							elsVehsNT[k] = lastloopnet
							elsVehsNB[k] = v
							elsVehsN[k] = v
						end
					end
				 
				 end
				
				end)
				Wait(minspacingper)
			 end


			lastloopnet = GetGameTimer()
			Wait(minwaitspaceper)
		end
		
	end)
end

function primarycc()
	Citizen.CreateThread(function()
		while true do
			lastloopnetq = GetGameTimer()
			 for k,v in pairs(elsVehsNB) do
				if v ~= nil then
					if elsVehsNT[k] ~= nil then
						if elsVehsNT[k] < lastloopnetq - 1080000 then
							print('ELSC removed vehicle ' .. k)
							elsVehsNT[k] = nil
							elsVehsNB[k] = nil
							elsVehsN[k] = nil
						end
					end

				end
				Wait(2500)
			 end
			lastloopnetq = GetGameTimer()
			Wait(60000)
		end
		
	end)
end



function primaryb()
	Citizen.CreateThread(function()
		while true do
			lastloopprom = GetGameTimer()
			local location = GetEntityCoords(GetPlayerPed(-1), true)  --GetEntityCoords(GetPlayerPed(-1), true)
			for j,u in pairs(elsVehs) do
				local k = j
				local v = u
				
				if not DoesEntityExist(k) or IsEntityDead(k) then
                    if elsVehs[k] ~= nil then
                        elsVehs[k] = nil
                    end

				elseif(v ~= nil) then
					if  #(GetEntityCoords(k, true) - location) <= vehicleSyncDistance and v.nonels == nil then
 
						--if elsVehs[k].warning or elsVehs[k].secondary or elsVehs[k].primary then
							--SetVehicleEngineOn(k, true, true, false)
						--end
						
						local vehN = checkCarHash(k)

						for i=11,12 do
							if (not IsEntityDead(k) and DoesEntityExist(k) and k ~= nil and vehN ~= nil) then
								if(els_Vehicles[vehN] ~= nil and els_Vehicles[vehN].extras[i] ~= nil and els_Vehicles[vehN].extras[i].enabled) then
									if(IsVehicleExtraTurnedOn(k, i)) then
										local boneIndex = GetEntityBoneIndexByName(k, "extra_" .. i)
										local coords = GetWorldPositionOfEntityBone(k, boneIndex)
										local rotX, rotY, rotZ = table.unpack(RotAnglesToVec(GetEntityRotation(k, 2)))

										if els_Vehicles[vehN].extras[i].env_light then
											if i == 11 then
												DrawSpotLightWithShadow(coords.x + els_Vehicles[vehN].extras[11].env_pos.x, coords.y + els_Vehicles[vehN].extras[11].env_pos.y, coords.z + els_Vehicles[vehN].extras[11].env_pos.z, rotX, rotY, rotZ, 255, 255, 255, 75.0, 2.0, 10.0, 20.0, 0.0, true)
											end
											if i == 12 then
												DrawLightWithRange(coords.x + els_Vehicles[vehN].extras[12].env_pos.x, coords.y + els_Vehicles[vehN].extras[12].env_pos.y, coords.z + els_Vehicles[vehN].extras[12].env_pos.z, 255, 255, 255, 50.0, envirementLightBrightness)
											end
										else
											if i == 11 then
												DrawSpotLightWithShadow(coords.x, coords.y, coords.z + 0.2, rotX, rotY, rotZ, 255, 255, 255, 75.0, 2.0, 10.0, 20.0, 0.0, true)
											end
											if i == 12 then
												DrawLightWithRange(coords.x, coords.y, coords.z, 255, 255, 255, 50.0, envirementLightBrightness)
											end
										end
									end
								end
							end
							
						end
					end
				end
			end
			Wait(3)
		end
	end)
end


vehiclesInSyncDistance = 0
function primarya()
	Citizen.CreateThread(function()

		while true do
			
			zvehiclesInSyncDistance = 0
			lastloopmain = GetGameTimer()
			local entitycoordsPlayer = GetEntityCoords(GetPlayerPed(-1), true) 

			for k,v in pairs(elsVehs) do

				if v ~= nil then
					
					local vehN = v.m--checkCarHash(k)
					if not DoesEntityExist(k) or IsEntityDead(k) or k == nil or vehN == nil then
						elsVehs[k] = nil
						elsVehsN_Local[elsVehsL_Net[k]] = nil
						elsVehsL_Net[k] = nil
					elseif v.nonels ~= nil then
					elseif (v ~= nil and DoesEntityExist(k) and #(GetEntityCoords(k, true) - entitycoordsPlayer) <= vehicleSyncDistance) then

							if (v.primary) then
								SetVehicleAutoRepairDisabled(k, true)
								zvehiclesInSyncDistance = zvehiclesInSyncDistance + 1
								if vehiclesInSyncDistance < 10 then
									local gv = nil
									if elsVehs[k].gv ~= nil then
										gv = elsVehs[k].gv
									else
										gv = getVehicleVCFInfo(k)
										elsVehs[k].gv = gv
									end
									
									if gv ~= nil and gv.priml ~= nil and gv.priml.type ~= nil and gv.priml.type == string.lower("leds") and v.primPattern <= 140 then
										
										runLedPatternPrimary(k, v.primPattern)
									end
								else
									--Force all extras on
										if not IsVehicleExtraTurnedOn(k,1) then
											setExtraState(k, 1, 0)
										end
										if not IsVehicleExtraTurnedOn(k,2) then
											setExtraState(k, 2, 0)
										end
										if not IsVehicleExtraTurnedOn(k,3) then
											setExtraState(k, 3, 0)
										end
										if not IsVehicleExtraTurnedOn(k,4) then
											setExtraState(k, 4, 0)
										end
										if not IsVehicleExtraTurnedOn(k,5) then
											setExtraState(k, 5, 0)
										end
										if not IsVehicleExtraTurnedOn(k,6) then
											setExtraState(k, 6, 0)
										end
										runEnvirementLight(k,1)
										--runEnvirementLight(k,2)
										runEnvirementLight(k,3)
										Wait(50)
										--runEnvirementLight(k,4)
								end
							elseif not v.cruise then
								setExtraState(k, 1, 1)
								setExtraState(k, 2, 1)
								setExtraState(k, 3, 1)
								setExtraState(k, 4, 1)
							end
							if vehiclesInSyncDistance < 13 then
								if (v.warning) then
									local gv = nil
									if elsVehs[k].gv ~= nil then
										gv = elsVehs[k].gv
									else
										gv = getVehicleVCFInfo(k)
										elsVehs[k].gv = gv
									end
									if  gv ~= nil and gv.wrnl ~= nil and gv.wrnl.type ~= nil and v.advisorPattern ~= nil then
										if gv.wrnl.type == string.lower("leds") and v.advisorPattern <= 53 then
											runLedPatternWarning(k, v.advisorPattern)
										end
									end
								elseif not v.cruise then
									setExtraState(k, 5, 1)
									setExtraState(k, 6, 1)
								end

								if (v.secondary) then
									local gv = nil
									if elsVehs[k].gv ~= nil then
										gv = elsVehs[k].gv
									else
										gv = getVehicleVCFInfo(k)
										elsVehs[k].gv = gv
									end
									if gv ~= nil and gv.secl ~= nil and gv.secl.type ~= nil and gv.secl.type == string.lower("leds") and v.secPattern <= 140 then
										runLedPatternSecondary(k, v.secPattern, function(cb) vehIsReadySecondary[k] = cb end)
									elseif gv ~= nil and gv.secl ~= nil and gv.secl.type ~= nil and getVehicleVCFInfo(k).secl.type == string.lower("traf") and v.secPattern <= 36 then
										runTrafPattern(k, v.secPattern)
									end
								else
									setExtraState(k, 7, 1)
									setExtraState(k, 8, 1)
									setExtraState(k, 9, 1)
								end
						
							
							if (v.cruise) then
								if not IsVehicleExtraTurnedOn(k,1) then
									setExtraState(k, 1, 0)
								end
								if not IsVehicleExtraTurnedOn(k,2) then
									setExtraState(k, 2, 0)
								end
								if not IsVehicleExtraTurnedOn(k,3) then
									setExtraState(k, 3, 0)
								end
								if not IsVehicleExtraTurnedOn(k,4) then
									setExtraState(k, 4, 0)
								end
								if not IsVehicleExtraTurnedOn(k,5) then
									setExtraState(k, 5, 0)
								end
								if not IsVehicleExtraTurnedOn(k,6) then
									setExtraState(k, 6, 0)
								end
								runEnvirementLight(k,1)
								--runEnvirementLight(k,2)
								--runEnvirementLight(k,3)
								runEnvirementLight(k,4)

							end

							if (v.takedown) then

								setExtraState(k, 11, 0)
							else
								setExtraState(k, 11, 1)
							end
						end
					end
					
				end
				Citizen.Wait(lightDelay)
			end
			
			vehiclesInSyncDistance = zvehiclesInSyncDistance
			Citizen.Wait(1)
		end
	end)
end