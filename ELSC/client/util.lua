local lightStage = {}
local CHashTable = {}

RegisterNetEvent('a8615719-d31b-43a5-97ae-e10dad044f1b')
AddEventHandler('a8615719-d31b-43a5-97ae-e10dad044f1b', function(vehicles, patterns, ls,primaryls,secondaryls,warningls,sirenstate)
    els_Vehicles = vehicles
    els_patterns = patterns

    lightPatternPrim = 1
    lightPatternSec = 1
    advisorPatternSelectedIndex = 1
	
	Citizen.CreateThread(function()
		--math.randomseed(GetGameTimer())
		--Wait(math.random(1,5000))
		print('received cars -- start hash table create')

		for k,v in pairs(els_Vehicles) do
			local hk = GetHashKey(k)
			CHashTable['zz'.. hk ..'zz'] = k
		--	print(k .. '  '  .. CHashTable['zz'.. hk ..'zz'] .. 'hk: '.. hk)
			Wait(3)
		end
		print('received cars -- finish hash table create')
		
		if ls ~= nil then
			for k,v in pairs(ls) do
				print(json.encode(v))
				TriggerEvent('dc219cae-8e51-431d-8093-2f680e058259',v.vehicle,v.vehiclem,v.sender,v.state,v.advisor,v.prim,v.sec)
			end
		end
		
		if secondaryls ~= nil then		
			for k,v in pairs(primaryls) do
				print(json.encode(v))
				TriggerEvent('8eb9fed3-667a-451a-8e5d-ab21a7e776cd',v.vehicle, v.vehiclem, v.sender, v.part, v.state)
			end
		end
		
		if secondaryls ~= nil then
			for k,v in pairs(secondaryls) do
				print(json.encode(v))
				TriggerEvent('8eb9fed3-667a-451a-8e5d-ab21a7e776cd',v.vehicle, v.vehiclem, v.sender, v.part, v.state)
			end
		end
		if warningls ~= nil then
			for k,v in pairs(warningls) do
				print(json.encode(v))
				TriggerEvent('8eb9fed3-667a-451a-8e5d-ab21a7e776cd',v.vehicle, v.vehiclem, v.sender, v.part, v.state)
			end
		end
		--print(json.encode(sirenstate))
		if sirenstate ~= nil then
			print('not null')
			for k,v in ipairs(warningls) do
				print(k)
				TriggerEvent('ea2e9891-4d58-413c-9a18-ad028ce02649',k , 0, v.siren)
				if v == true then
					print('true')
				else
					print('false')
				end
			end
		end
		

	end)

end)


RegisterNetEvent('d8431b80-c3f1-467d-8159-6c8d89002e62')
AddEventHandler('d8431b80-c3f1-467d-8159-6c8d89002e62', function()
	TriggerEvent('e6c5ff5e-0848-4a16-9dc9-775a65450474')
	Wait(3000)
	elsVehs = {}  -- active normalids
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
end)

RegisterNetEvent('dc219cae-8e51-431d-8093-2f680e058259')
AddEventHandler('dc219cae-8e51-431d-8093-2f680e058259', function(vehiclen,vehiclem,sender, stage, advisor, prim, sec)
    Citizen.CreateThread(function()

	
				local vehNetID = vehiclen
				local veh = 0
				if NetworkDoesNetworkIdExist(vehNetID) then
					veh = NetToVeh(vehNetID)
				end
				print('ELSC sender LSTG' .. sender .. ' stage: ' .. stage  ..  ' vehicle file: ' .. vehiclen  .. ' veh:' .. veh .. ' 0 here indicates no car nearby vehicle m: ' .. vehiclem) 

				--table.insert(lightStage,{sender = sender, stage = stage, advisor = advisor, prim = prim, sec = sec, netid = vehNetID})
                if elsVehsN[vehNetID] ~= nil then
					elsVehsN[vehNetID].sender = sender
                    elsVehsN[vehNetID].stage = stage
					elsVehsN[vehNetID].m = vehiclem
					
					elsVehsN[vehNetID].cruise = nil
                    if (stage == 1) then
                        elsVehsN[vehNetID].warning = false
                        elsVehsN[vehNetID].secondary = true
                        elsVehsN[vehNetID].primary = false
						SetVehicleSiren(veh, false)
                    elseif (stage == 2) then
                        elsVehsN[vehNetID].warning = false
                        elsVehsN[vehNetID].secondary = true
                        elsVehsN[vehNetID].primary = true
						SetVehicleSiren(veh, false)
                    elseif (stage == 3) then
						local cf = getVehicleVCFInfo(vehiclem)
                        elsVehsN[vehNetID].warning = true
						if cf.extras[1].enabled == false and cf.extras[2].enabled == false and cf.extras[3].enabled == false and cf.extras[4].enabled == false then
							elsVehsN[vehNetID].nonels = true
						end
						
							toggleSirenMute(veh, true)
							SetVehicleSiren(veh, true)
					
						
						
						if cf ~= nil and cf.secl ~= nil and cf.secl.disable ~= nil then
							if cf.secl.disable == 'true' then
								elsVehsN[vehNetID].secondary = false
							else
								elsVehsN[vehNetID].secondary = true
							end
						else
							elsVehsN[vehNetID].secondary = false
						end
                        elsVehsN[vehNetID].primary = true
                    else
						SetVehicleSiren(veh, false)
                        elsVehsN[vehNetID].warning = false
                        elsVehsN[vehNetID].secondary = false
                        elsVehsN[vehNetID].primary = false
                    end
                    elsVehsN[vehNetID].primPattern = prim
                    elsVehsN[vehNetID].secPattern = sec
                    elsVehsN[vehNetID].advisorPattern = advisor
			
                else
                    elsVehsN[vehNetID] = {}
                    elsVehsN[vehNetID].stage = stage
					elsVehsN[vehNetID].m = vehiclem
					elsVehsN[vehNetID].sender = sender
                    if (stage == 1) then
                        elsVehsN[vehNetID].warning = false
                        elsVehsN[vehNetID].secondary = true
                        elsVehsN[vehNetID].primary = false
                    elseif (stage == 2) then
                        elsVehsN[vehNetID].warning = false
                        elsVehsN[vehNetID].secondary = true
                        elsVehsN[vehNetID].primary = true
                    elseif (stage == 3) then
                        elsVehsN[vehNetID].warning = true
						
						local cf = getVehicleVCFInfo(vehiclem)
						--print(json.encode(cf))
												
						if cf ~= nil and cf.secl ~= nil and cf.secl.disable ~= nil then
							if getVehicleVCFInfo(vehiclem).secl.disable == 'true' then
							
								elsVehsN[vehNetID].secondary = false
							else
								
								elsVehsN[vehNetID].secondary = true
							end
						else
						
							elsVehsN[vehNetID].secondary = false
						end
                        elsVehsN[vehNetID].primary = true
                    else
                        elsVehsN[vehNetID].warning = false
                        elsVehsN[vehNetID].secondary = false
                        elsVehsN[vehNetID].primary = false
                    end
                    elsVehsN[vehNetID].primPattern = prim
                    elsVehsN[vehNetID].secPattern = sec
                    elsVehsN[vehNetID].advisorPattern = advisor
                end
				if veh ~= nil and veh ~= 0 then
					elsVehs[veh] = elsVehsN[vehNetID]
				end
         
			
  
       
    end)
end)

RegisterNetEvent('8eb9fed3-667a-451a-8e5d-ab21a7e776cd')
AddEventHandler('8eb9fed3-667a-451a-8e5d-ab21a7e776cd', function(vehiclen, vehiclem, sender, part, newstate)
   
	local vehNetID = vehiclen
	local veh = 0
	if NetworkDoesNetworkIdExist(vehNetID) then
		veh = NetToVeh(vehNetID)
	end

	if elsVehsN[vehNetID] == nil then
		elsVehsN[vehNetID] = {}
		elsVehsN[vehNetID].stage = 0
		elsVehsN[vehNetID].primPattern = 1
		elsVehsN[vehNetID].secPattern = 1
		elsVehsN[vehNetID].advisorPattern = 1
	end

	elsVehsN[vehNetID][part] = newstate
    

end)

RegisterNetEvent('a2d03d09-e5e4-42b6-89bf-e7c48cc6d3ff')
AddEventHandler('a2d03d09-e5e4-42b6-89bf-e7c48cc6d3ff', function(vehiclen, sender, pat)


		local vehNetID = vehiclen
		local veh = NetToVeh(vehNetID)

		if elsVehsN[vehNetID] ~= nil then
			elsVehsN[vehNetID].advisorPattern = pat
		else
			elsVehsN[vehNetID] = {}
			elsVehsN[vehNetID].advisorPattern = pat
		end

end)

RegisterNetEvent('0893369e-f0b5-438a-bb85-df042d1151a2')
AddEventHandler('0893369e-f0b5-438a-bb85-df042d1151a2', function(vehiclen, sender, pat)

	local vehNetID = vehiclen
	local veh = 0
	if NetworkDoesNetworkIdExist(vehNetID) then
		veh = NetToVeh(vehNetID)
	end

	if elsVehsN[vehNetID] ~= nil then
		elsVehsN[vehNetID].secPattern = pat
	else
		elsVehsN[vehNetID] = {}
		elsVehsN[vehNetID].secPattern = pat
	end

end)

RegisterNetEvent('04f1025e-e6dc-4dda-b2be-d8be8312d687')
AddEventHandler('04f1025e-e6dc-4dda-b2be-d8be8312d687', function(vehiclen, sender, pat)

		local vehNetID = vehiclen
		local veh = 0
		if NetworkDoesNetworkIdExist(vehNetID) then
			veh = NetToVeh(vehNetID)
		end

		if elsVehsN[vehNetID] ~= nil then
			elsVehsN[vehNetID].primPattern = pat
		else
			elsVehsN[vehNetID] = {}
			elsVehsN[vehNetID].primPattern = pat
		end

end)

RegisterNetEvent('ea2e9891-4d58-413c-9a18-ad028ce02649')
AddEventHandler('ea2e9891-4d58-413c-9a18-ad028ce02649', function(vehiclen, sender, newstate)
	--print('local siren entity')
	--print(vehiclen)
	elsVehsNS[vehiclen] = newstate
	local veh = NetToVeh(vehiclen)
	
	if veh ~= nil and veh ~= 0 then
		setSirenState(veh, newstate)
	end
    
 
end)

RegisterNetEvent('9891d34a-a0eb-48af-b195-2454fa11371d')
AddEventHandler('9891d34a-a0eb-48af-b195-2454fa11371d', function(sender, newstate)
    local player_s = GetPlayerFromServerId(sender)
    local ped_s = GetPlayerPed(player_s)
    if player_s ~= -1 and DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
        if IsPedInAnyVehicle(ped_s, false) then
            local veh = GetVehiclePedIsUsing(ped_s)
            setHornState(veh, newstate)
        end
    end
end)

RegisterNetEvent('4cb52fe7-3ab2-4fd5-a0af-2365505369b6')
AddEventHandler('4cb52fe7-3ab2-4fd5-a0af-2365505369b6', function(sender)
    local player_s = GetPlayerFromServerId(sender)
    local ped_s = GetPlayerPed(player_s)
    if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
        if IsPedInAnyVehicle(ped_s, false) then
			local vehNetIDs = GetVehiclePedIsUsing(ped_s)
			local vehNetID = VehToNet(vehNetIDs)
			local veh = NetToVeh(vehNetID)

            if(elsVehs[veh] == nil) then
                changeLightStage(0, 1, 1, 1)
            end
            if IsVehicleExtraTurnedOn(veh, 12) then
                setExtraState(veh, 12, 1)
            else
                setExtraState(veh, 12, 0)
            end
        end
    end
end)

RegisterNetEvent('8b338db8-9bd3-4e34-acdd-faf458361c13')
AddEventHandler('8b338db8-9bd3-4e34-acdd-faf458361c13', function(vehiclen,vehiclem,newstate,sender)


	local veh = NetToVeh(vehiclen)
	elsVehsN[vehiclen] = {}
	elsVehsN[vehiclen].m = vehiclem
	elsVehsN[vehiclen].cruise = newstate
	
	if elsVehsN[vehiclen].cruise == false then
		elsVehsN[vehiclen].cruise = false
	end
	
	elsVehsN[vehiclen].warning = false
	elsVehsN[vehiclen].secondary = false
	elsVehsN[vehiclen].primary = false

	if veh ~= nil and veh ~= 0 then
		if elsVehs[veh] ~= nil then
			if elsVehs[veh].cruise then
				elsVehs[veh].cruise = false
			else
				elsVehs[veh].primary = false
				elsVehs[veh].secondary = false
				elsVehs[veh].warning = false
				elsVehs[veh].cruise = true
				SetVehicleSiren(veh, false)
			end
		else
		
			elsVehs[veh].primary = false
			elsVehs[veh].secondary = false
			elsVehs[veh].warning = false
			SetVehicleSiren(veh, false)
			elsVehs[veh].cruise = true
		end
	end
    
end)

RegisterNetEvent('00b4abaf-c04d-4ec2-a4fa-fd566642389d')
AddEventHandler('00b4abaf-c04d-4ec2-a4fa-fd566642389d', function(vehiclen,vehiclem,newstate,sender)

	print ('take down lights on client side triggered')
	local veh = NetToVeh(vehiclen)
	print(veh)
	elsVehsN[vehiclen].takedown = newstate
	if newstate == true then
		print('server said to turn on')
	end
	if newstate == false then
		elsVehsN[vehiclen].takedown = false
	end
	
	if veh ~= nil and veh ~= 0 then
		if elsVehs[veh] ~= nil then
			if elsVehs[veh].takedown ~= nil then
				if newstate == true then
					print('landed here 5')	
					elsVehs[veh].takedown = true
				else
					print('landed here 6')	
					elsVehs[veh].takedown = false
				end
							
			end
		else
			print('landed here 2')
			elsVehs[veh].takedown = true
		end
	end

end)

function toggleSirenMute(veh, toggle)
    if DoesEntityExist(veh) and not IsEntityDead(veh) then
        DisableVehicleImpactExplosionActivation(veh, toggle)
    end
end

function setHornState(veh, newstate)
    if DoesEntityExist(veh) and not IsEntityDead(veh) then
        if newstate ~= h_horn_state[veh] then
                
            if h_soundID_veh[veh] ~= nil then
                StopSound(h_soundID_veh[veh])
                ReleaseSoundId(h_soundID_veh[veh])
                h_soundID_veh[veh] = nil
            end
                        
            if newstate == 1 then
                h_soundID_veh[veh] = GetSoundId()
                PlaySoundFromEntity(h_soundID_veh[veh], getVehicleVCFInfo(veh).sounds.mainHorn.audioString, veh, getVehicleVCFInfo(veh).sounds.mainHorn.type, 0, 0)
            end             
                
            h_horn_state[veh] = newstate
        end
    end
end

function setSirenState(veh, newstate)
    if DoesEntityExist(veh) and not IsEntityDead(veh) then
        if newstate ~= m_siren_state[veh] then
                
            if m_soundID_veh[veh] ~= nil then
                StopSound(m_soundID_veh[veh])
                ReleaseSoundId(m_soundID_veh[veh])
                m_soundID_veh[veh] = nil
            end
			
			if d_soundID_veh[veh] ~= nil then
				StopSound(d_soundID_veh[veh])
                ReleaseSoundId(d_soundID_veh[veh])
				d_soundID_veh[veh] = nil
			end

            if newstate == 1 then
				d_soundID_veh[veh] = nil
                m_soundID_veh[veh] = GetSoundId()
                PlaySoundFromEntity(m_soundID_veh[veh], getVehicleVCFInfo(veh).sounds.srnTone1.audioString, veh, getVehicleVCFInfo(veh).sounds.srnTone1.type, 0, 0)
                toggleSirenMute(veh, true)
                
            elseif newstate == 2 then
				d_soundID_veh[veh] = nil
                m_soundID_veh[veh] = GetSoundId() 
                PlaySoundFromEntity(m_soundID_veh[veh], getVehicleVCFInfo(veh).sounds.srnTone2.audioString, veh, getVehicleVCFInfo(veh).sounds.srnTone2.type, 0, 0)
                toggleSirenMute(veh, true)
                
            elseif newstate == 3 then
				d_soundID_veh[veh] = nil
                m_soundID_veh[veh] = GetSoundId()
                PlaySoundFromEntity(m_soundID_veh[veh], getVehicleVCFInfo(veh).sounds.srnTone3.audioString, veh, getVehicleVCFInfo(veh).sounds.srnTone3.type, 0, 0)
                toggleSirenMute(veh, true)
				
			elseif newstate == 4 then
				d_soundID_veh[veh] = GetSoundId()
                m_soundID_veh[veh] = GetSoundId()
                PlaySoundFromEntity(m_soundID_veh[veh], getVehicleVCFInfo(veh).sounds.srnTone1.audioString, veh, getVehicleVCFInfo(veh).sounds.srnTone1.type, 0, 0)
				PlaySoundFromEntity(d_soundID_veh[veh], getVehicleVCFInfo(veh).sounds.srnTone2.audioString, veh, getVehicleVCFInfo(veh).sounds.srnTone2.type, 0, 0)
                toggleSirenMute(veh, true)
                
            else
                toggleSirenMute(veh, true)
            end                 
            m_siren_state[veh] = newstate
        end
    end
end

function RotAnglesToVec(rot) -- input vector3
    local z = math.rad(rot.z)
    local x = math.rad(rot.x)
    local num = math.abs(math.cos(x))
    return vector3(-math.sin(z)*num, math.cos(z)*num, math.sin(x))
end

function changeLightStage(vehn, vehm, state, advisor, PatternPrim, PatternSec)
	print('sender light stage trigger to server')
	if vehn ~= nil and vehn ~= 0 and vehn ~= -1 then
		print (vehm)
		TriggerServerEvent('c15f1ecd-3ae7-4b56-abaf-12939bb94c34', vehn, vehm, state, advisor, PatternPrim, PatternSec)
	end
end

function changeAdvisorPattern(vehn,pat)
	if vehn ~= nil and vehn ~= 0 and vehn ~= -1 then
		TriggerServerEvent('83e72cd5-e8de-4ad5-bcf8-bb4e57da0838',vehn, pat)
	end
	
end

function changePrimaryPattern(vehn,pat)
	if vehn ~= nil and vehn ~= 0 and vehn ~= -1 then
		TriggerServerEvent('b14c35bc-c9a9-4a6c-b4c6-46599a8ebd89',vehn, pat)
	end
end

function changeSecondaryPattern(vehn,pat)
	if vehn ~= nil and vehn ~= 0 and vehn ~= -1 then
		TriggerServerEvent('53b0f3b7-f123-49c6-bdb7-73f65d551973',vehn, pat)
	end
end



local gem = {}
function GetEntityMod(car)
	--print('car ' .. car)
	if gem['a'..car .. 'a'] == nil then
		gem['a'..car .. 'a'] = GetEntityModel(car)
		return gem['a'..car .. 'a'] 
	else
		return gem['a'..car .. 'a']
	end
end


function checkCar(car)
    if car then
        carModel = GetEntityModel(car)
        carName = GetDisplayNameFromVehicleModel(carModel)

        return carName
    end
end





function checkCarHash(car)
    if car then
		 -- if hk
		
		local result = CHashTable['zz'.. car ..'zz']
		--print('car ' .. car)
		--print('a'..hk)
		if result ~= nil then
		--	print('car ' .. car)
		--	print('a'..hk)
			 
			if result ~= nil then
				return result
			else
				return car
			end
		else
			local hk = GetEntityModel(car) 
		--	print(CHashTable['zz'.. hk ..'zz'])
			local result = CHashTable['zz'.. hk ..'zz'] 
			--print('result ' .. result)
			if result ~= nil then
				return result
			else
				return car--print('returned nil: ' .. hk)
			end
		end
		--[[
        for k,v in pairs(els_Vehicles) do
            if GetEntityModel(car) == GetHashKey(k) then
                return k
            end
        end--]]
    end
end

function vehInTable (tab, val)
    for index in pairs(tab) do
        if index == val then
            return true
        end
    end

    return false
end

function setExtraState(veh, extra, state)
    if (not IsEntityDead(veh) and DoesEntityExist(veh)) then
		local cch = els_Vehicles[checkCarHash(veh)]
        if cch ~= nil and cch.extras[extra] ~= nil and cch.extras[extra].enabled ~= nil  then
            if(cch.extras[extra].enabled) then
                if DoesExtraExist(veh, extra) then
                    SetVehicleExtra(veh, extra, state)
                end
            end
        end
    end
end

function isVehicleELS(veh)
    return vehInTable(els_Vehicles, checkCarHash(veh))
end

function getVehicleLightStage(veh)

    if (elsVehs[veh] ~= nil) then
        return elsVehs[veh].stage
    end
end

function Draw(text, r, g, b, alpha, x, y, width, height, ya, center, font)
    SetTextColour(r, g, b, alpha)
    SetTextFont(font)
    SetTextScale(width, height)
    SetTextWrap(0.0, 1.0)
    SetTextCentre(center)
    SetTextDropshadow(0, 0, 0, 0, 0)
    SetTextEdge(1, 0, 0, 0, 205)
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    SetUiLayer(ya)
    EndTextCommandDisplayText(x, y)
end

function hornCleanup()
    Citizen.CreateThread(function()
        for vehicle, state in pairs(h_horn_state) do
            if state >= 0 then
                if not DoesEntityExist(vehicle) or IsEntityDead(vehicle) then
                    if h_soundID_veh[vehicle] ~= nil then
                        StopSound(h_soundID_veh[vehicle])
                        ReleaseSoundId(h_soundID_veh[vehicle])
                        h_soundID_veh[vehicle] = nil
                        h_horn_state[vehicle] = nil
                    end
                end
            end
        end
        return
    end)
end

function sirenCleanup()
    Citizen.CreateThread(function()
        for vehicle, state in pairs(m_siren_state) do
            if m_soundID_veh[vehicle] ~= nil then
                if not DoesEntityExist(vehicle) or IsEntityDead(vehicle) then
                    StopSound(m_soundID_veh[vehicle])
                    ReleaseSoundId(m_soundID_veh[vehicle])
                    m_soundID_veh[vehicle] = nil
                    m_siren_state[vehicle] = nil
					
                end
            end
        end

        for vehicle, state in pairs(d_siren_state) do
            if d_soundID_veh[vehicle] ~= nil then
                if not DoesEntityExist(vehicle) or IsEntityDead(vehicle) then
                    StopSound(d_soundID_veh[vehicle])
                    ReleaseSoundId(d_soundID_veh[vehicle])
                    d_siren_state[vehicle] = nil
                end
            end
        end
        return
    end)
end

function _DrawRect(x, y, width, height, r, g, b, a, ya)
    SetUiLayer(ya)
    DrawRect(x, y, width, height, r, g, b, a)
end

function vehicleLightCleanup()
    Citizen.CreateThread(function()
        for vehicle,_ in pairs(elsVehs) do
            if elsVehs[vehicle] then
                if not DoesEntityExist(vehicle) or IsEntityDead(vehicle) then
                    if elsVehs[vehicle] ~= nil then
                        elsVehs[vehicle] = nil
                    end
                end
            end
        end
        return
    end)
end

function LghtSoundCleaner()
    vehicleLightCleanup()
    hornCleanup()
    sirenCleanup()
	
end

Citizen.CreateThread(function()

     while true do
         Wait(1000 * 60 * 10)
		 print('running light clean timer')
		LghtSoundCleaner()
       
    end
end)

--[[
Citizen.CreateThread(function()
     while true do
    
		Wait(1000 * 60 * 60)
		elsstopprocess = true
		
		Citizen.CreateThread(function()
			Wait(2000)
			LghtSoundCleaner()
			elsVehs = {}
			elsVehsN = {}
			elsVehsNB = {}
			Wait(100)
			elsstopprocess = false
			
		end)
		
	end
end)--]]



RegisterNetEvent('e6c5ff5e-0848-4a16-9dc9-775a65450474')
AddEventHandler('e6c5ff5e-0848-4a16-9dc9-775a65450474', function()
	LghtSoundCleaner()
	elsstopprocess = true
	
	Citizen.CreateThread(function()
		Wait(6000)
		elsVehs = {}
		elsVehsN = {}
		elsVehsNB = {}
		Wait(100)
		elsstopprocess = false
		
	end)
end)

RegisterNetEvent('18dd1ca1-565d-4993-a1db-99713e3a9421')
AddEventHandler('18dd1ca1-565d-4993-a1db-99713e3a9421', function(state)
	print('ELS DEBUG ON')
	
	if state == "on" then
		debug_me = true
		print('ELS DEBUG ON')
	else
		debug_me = false
		print('ELS DEBUG OFF')
	end
end)

function changePrimaryPatternMath(vehiclen,way)
    if playButtonPressSounds then
        PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
    end
    local primMax = getNumberOfPrimaryPatterns(GetVehiclePedIsUsing(GetPlayerPed(-1)))
    local primMin = 1
    local temp = lightPatternPrim

    temp = temp + way

    if(temp < primMin) then
        temp = primMax
    end

    if(temp > primMax) then
        temp = primMin
    end

    lightPatternPrim = temp
	carpattern = checkCarHash(GetVehiclePedIsUsing(GetPlayerPed(-1)))
	mainpattern = temp

    if temp ~= 0 then lightPatternsPrim = temp end
    changePrimaryPattern(vehiclen,lightPatternsPrim)
end

function changeSecondaryPatternMath(vehiclen,way)
    if playButtonPressSounds then
        PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
    end
    local primMax = getNumberOfSecondaryPatterns(GetVehiclePedIsUsing(GetPlayerPed(-1)))
    local primMin = 1
    local temp = lightPatternSec

    temp = temp + way

    if(temp > primMax) then
        temp = primMin
    end

    if(temp < primMin) then
        temp = primMax
    end

    lightPatternSec = temp
    changeSecondaryPattern(vehiclen,lightPatternSec)
end

function changeAdvisorPatternMath(vehiclen,way)
    if playButtonPressSounds then
        PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
    end
    
    local primMax = getNumberOfAdvisorPatterns(GetVehiclePedIsUsing(GetPlayerPed(-1)))

    local primMin = 1
    local temp = advisorPatternSelectedIndex

    temp = temp + way

    if(temp < primMin) then
        temp = primMax
    end

    if(temp > primMax) then
        temp = primMin
    end

    advisorPatternSelectedIndex = temp
    changeAdvisorPattern(vehiclen,advisorPatternSelectedIndex)
end

function setSirenStateButton(vehiclen, state)
    if playButtonPressSounds then
        PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
    end
	local vehCarNet = VehToNet(vehiclen)
	if vehCarNet ~= nil and vehCarNet ~= 0 and vehCarNet ~= -1 then
		if m_siren_state[vehiclen] ~= state then
			TriggerServerEvent('8cb4f054-3dfc-454f-b32f-b6adc5f0ce74',vehCarNet, state)
		elseif m_siren_state[vehiclen] == state then
			TriggerServerEvent('8cb4f054-3dfc-454f-b32f-b6adc5f0ce74',vehCarNet, 0)
		end
	end
end

function upOneStage()
    if playButtonPressSounds then
        PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
    end
	local vehNetIDs = GetVehiclePedIsUsing(GetPlayerPed(-1))
	local vehNetID = VehToNet(vehNetIDs)
	local veh = NetToVeh(vehNetID)
	local vehm = GetEntityModel(veh)
    local newStage = 1
	if vehNetID ~= nil and vehNetID ~= 0 then
		if (elsVehsN[vehNetID] ~= nil and elsVehsN[vehNetID].stage ~= nil) then
			newStage = elsVehsN[vehNetID].stage + 1
		end

		if newStage == 4 then
			newStage = 0
		end
	
		changeLightStage(vehNetID, vehm,newStage, advisorPatternSelectedIndex, lightPatternPrim, lightPatternSec)

		if GetVehicleClass(GetVehiclePedIsUsing(GetPlayerPed(-1))) == 18 then
			if newStage == getVehicleVCFInfo(GetVehiclePedIsUsing(GetPlayerPed(-1))).misc.dfltsirenltsactivateatlstg then
				toggleSirenMute(GetVehiclePedIsUsing(GetPlayerPed(-1)), true)
				SetVehicleSiren(GetVehiclePedIsUsing(GetPlayerPed(-1)), true)
			else
				SetVehicleSiren(GetVehiclePedIsUsing(GetPlayerPed(-1)), false)
			end

			if(newStage == 0) then
				SetVehicleSiren(GetVehiclePedIsUsing(GetPlayerPed(-1)), false)
				TriggerServerEvent('8cb4f054-3dfc-454f-b32f-b6adc5f0ce74', 0)
				TriggerServerEvent('57e459bd-3607-4555-b25c-ac9da401f169', 0)
				TriggerServerEvent('055287f1-3963-4cc1-80df-0a1aa97dbc44', false)
			end
		end
	end
end

function downOneStage()
    if playButtonPressSounds then
        PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
    end
	local vehNetIDs = GetVehiclePedIsUsing(GetPlayerPed(-1))
	local vehNetID = VehToNet(vehNetIDs)
	local veh = NetToVeh(vehNetID)
	local vehm = GetEntityModel(veh)
	if vehNetID ~= nil and vehNetID ~= 0 then
		local newStage = 3

		if(elsVehsN[vehNetID] ~= nil and elsVehsN[vehNetID].stage ~= nil) then
			newStage = elsVehsN[vehNetID].stage - 1
		end

		if newStage == -1 then
			newStage = 3
		end

		changeLightStage(vehNetID, vehm, newStage, advisorPatternSelectedIndex, lightPatternPrim, lightPatternSec)

		if GetVehicleClass(veh) == 18 then
			if newStage == getVehicleVCFInfo(veh).misc.dfltsirenltsactivateatlstg then
				toggleSirenMute(veh, true)
				SetVehicleSiren(veh, true)
			else
				SetVehicleSiren(veh, false)
			end

			if (newStage == 0) then
				SetVehicleSiren(veh, false)
				TriggerServerEvent('8cb4f054-3dfc-454f-b32f-b6adc5f0ce74', 0)
				TriggerServerEvent('57e459bd-3607-4555-b25c-ac9da401f169', 0)
				TriggerServerEvent('055287f1-3963-4cc1-80df-0a1aa97dbc44', false)
			end
		end
	end
end

function startStage3()
    if playButtonPressSounds then
        PlaySoundFrontend(-1, "NAV_UP_DOWN", "HUD_FRONTEND_DEFAULT_SOUNDSET", 1)
    end
	local vehNetIDs = GetVehiclePedIsUsing(GetPlayerPed(-1))
	local vehNetID = VehToNet(vehNetIDs)
	local veh = NetToVeh(vehNetID)
	local vehm = GetEntityModel(veh)
	print('vehm  ' .. vehm)
	if vehNetID ~= nil and vehNetID ~= 0 then
		local newStage = 3

		if(elsVehsN[vehNetID] ~= nil and elsVehsN[vehNetID].stage ~= nil) then
			newStage = elsVehsN[vehNetID].stage - 1
		end

		if newStage == 2  or newStage < 1 then
			newStage = 4
		end
		
		lightPatternPrim = getVehicleVCFInfo(veh).priml.PresetPatterns['lstg3'].pattern 
		
		lightPatternSec = getVehicleVCFInfo(veh).secl.PresetPatterns['lstg3'].pattern
		advisorPatternSelectedIndex = getVehicleVCFInfo(veh).wrnl.PresetPatterns['lstg3'].pattern

		if carpattern ~= nil and carpattern == checkCarHash(GetVehiclePedIsUsing(GetPlayerPed(-1))) then
			lightPatternPrim = mainpattern

		end
		--print(  getVehicleVCFInfo(GetVehiclePedIsUsing(GetPlayerPed(-1))).secl.disable)
		
		
		changeLightStage(vehNetID, vehm,newStage, advisorPatternSelectedIndex, lightPatternPrim, lightPatternSec)

		if GetVehicleClass(veh) == 18 then

			if newStage == getVehicleVCFInfo(veh).misc.dfltsirenltsactivateatlstg  or (newStage == 3 and getVehicleVCFInfo(veh).misc.dfltsirenltsactivateatlstg == 1) then
				--print('set vehicle siren')
				toggleSirenMute(veh, true)
				SetVehicleSiren(veh, true)
			else
				--print('set vehicle off')
				SetVehicleSiren(veh, false)
			end

			if (newStage == 0) then
				--print('set server light stage | off')
				SetVehicleSiren(veh, false)
				TriggerServerEvent('8cb4f054-3dfc-454f-b32f-b6adc5f0ce74', 0)
				TriggerServerEvent('57e459bd-3607-4555-b25c-ac9da401f169', 0)
				TriggerServerEvent('055287f1-3963-4cc1-80df-0a1aa97dbc44', false)
			end
		end
		
		
	end
end

function displayScreenKeyboard(text)
    HideHudAndRadarThisFrame()
    DisplayOnscreenKeyboard(1, text, "", "", "", "", "", 60)
    while UpdateOnscreenKeyboard() == 0 do
        DisableAllControlActions(0)
        Wait(0)
    end
    if (not GetOnscreenKeyboardResult()) then return nil end
    return GetOnscreenKeyboardResult()
end

function formatPatternNumber(num)
	if num == nil then
		num = 0
	end
	num = tonumber(num)
    if num < 10 then
        return "00" .. tostring(num)
    elseif num < 100 and num >= 10 then
        return "0" .. tostring(num)
    else
        return tostring(num)
    end 
end

function getVehicleVCFInfo(veh)
	local gch = checkCarHash(veh)
    return els_Vehicles[gch]
end