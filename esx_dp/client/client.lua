local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,["-"] = 84,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}


---1. Cancel no response - reduce death timer and allow them to revive
---2. Resposne with message indicating on way

local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Bendigo Cove", ['PALETO'] = "Bendigo", ['PALFOR'] = "Bendigo Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "MT Thomas", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }


ESX = nil
local PlayerData =				{}
local GUI                        = {}
GUI.Time                         = 0
GUI.PoliceCadIsShowed            = false
GUI.isdriving					 = false

GUI.Time = GetGameTimer()

local myPed =  GetPlayerPed(-1)
local vehiclein = 0
local myCurrentCoords = GetEntityCoords(myPed)





Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
  	ESX.UI.Menu.RegisterType('cadsystem', OpenCadSystem, CloseCadSystem)

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()

	SendNUIMessage({
		job = PlayerData.job.name
	})
	if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'mecano' or PlayerData.job.name == 'mecano2' then
		TriggerServerEvent('92f5583b-26db-47c6-a3d6-56f59ddebc37')
	end
end)
local callsign_other = GetPlayerName(PlayerId())
Citizen.CreateThread(function()
	while true do
		pcall(function()
			myPed = ESX.Game.GetMyPed() or GetPlayerPed(-1)
			vehiclein = ESX.Game.GetVehiclePedIsIn() or 0
			myCurrentCoords = ESX.Game.GetMyPedLocation() or GetEntityCoords(myPed)
		end)
		Wait(500)
	end
	Wait(10000)
	callsign_other = GetPlayerName(PlayerId())
end)

local tow = {}
local police = {}
local ambulance = {}
local unitlist = {}



 

local last_job = -1
local last_call = -1

local last_status = "code1"


RegisterNetEvent('e011b4a7-4bcb-4812-b2e8-a867a358eb52')
AddEventHandler('e011b4a7-4bcb-4812-b2e8-a867a358eb52', function(notification,locationgps)
	local location = ""
	if locationgps ~= nil and location ~= nil then
		location = returnlocation(locationgps.x,locationgps.y,locationgps.z)
		notification.text = notification.text .. " <br/><br/><b>Location:</b> " .. location
	end
	
	if notification ~= nil and notification.urgent ~= nil and notification.urgent == true then

		exports.webcops:PlaySound("urgentjob",0.438)
		Wait(1200)
		exports.webcops:PlaySound("control",0.225)
	else
		exports.webcops:PlaySound("control",0.009)
	end
	
	TriggerEvent('61329ade-cca4-49b0-ae5e-47119f350c2d',notification)
end)


				
RegisterNetEvent('d3ab1c03-fe7e-4efb-ba4b-8ae1b8df5a8b')
AddEventHandler('d3ab1c03-fe7e-4efb-ba4b-8ae1b8df5a8b', function(police_s,ambulance_s,tow_s,unitlist_s)
			
		if police_s then
			for i=1,#police_s do 
				if type(police_s[i].coords) == "vector3" then
					police_s[i].coords = {x = police_s[i].coords.x, y = police_s[i].coords.y, z=police_s[i].coords.z}
				end
				police_s[i].location = returnlocation(police_s[i].coords.x,police_s[i].coords.y,police_s[i].coords.z)
			end
			if PlayerData.job.name == 'police' then
				if police_s[#police_s] ~= nil then
					last_call = police_s[#police_s].id
				end
			end
		end
		
		if ambulance_s then
			for i=1,#ambulance_s do 
				if type(ambulance_s[i].coords) == "vector3" then
					ambulance_s[i].coords = {x = ambulance_s[i].coords.x, y = ambulance_s[i].coords.y, z=ambulance_s[i].coords.z}
				end
				ambulance_s[i].location = returnlocation(ambulance_s[i].coords.x,ambulance_s[i].coords.y,ambulance_s[i].coords.z)
			end
			if PlayerData.job.name == 'ambulance' then
				if ambulance_s[#ambulance_s] ~= nil then
					last_call = ambulance_s[#ambulance_s].id
				end
			end
		end
		if tow_s then
			for i=1,#tow_s do 
				if type(tow_s[i].coords) == "vector3" then
					tow_s[i].coords = {x = tow_s[i].coords.x, y = tow_s[i].coords.y, z=tow_s[i].coords.z}
				end
				tow_s[i].location = returnlocation(tow_s[i].coords.x,tow_s[i].coords.y,tow_s[i].coords.z)
			end
			if PlayerData.job.name == 'ambulance' then
				if tow_s[#tow_s] ~= nil then
					last_call = tow_s[#tow_s].id
				end
			end
		end
		
		if ESX.GetPlayerData().job.name == 'police' then
			SendNUIMessage({
			  callresults = police_s
			})
			SendNUIMessage({
				job = 'police'
			})

		elseif ESX.GetPlayerData().job.name == 'ambulance' then
			SendNUIMessage({
			  callresults = ambulance_s
			})
			SendNUIMessage({
				job = 'ambulance'
			})
		elseif ESX.GetPlayerData().job.name == 'mecano' then
			SendNUIMessage({
			  callresults = tow_s
			})
			SendNUIMessage({
				job = 'tow_s'
			})
				
		elseif ESX.GetPlayerData().job.name == 'mecano2' then
			SendNUIMessage({
			  callresults = tow_s
			})
			SendNUIMessage({
				job = 'tow_s'
			})
					
		end
		local unitlist = unitlist_s
		
		local listofveh = {}
		for k,v in pairs(unitlist_s) do
			table.insert(listofveh,k)
		end
		
		SendNUIMessage({
          unitlist = listofveh
        })
		
		if police_s then
			police = police_s
		end
		if ambulance_s then
			ambulance = ambulance_s
		end
		if tow_s then
			tow = tow_s
		end
		
		
end)


RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function(job)
		PlayerData.job = job

		SendNUIMessage({
			job = job.name
        })
		if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'mecano' or PlayerData.job.name == 'mecano2' then
		
			TriggerServerEvent('92f5583b-26db-47c6-a3d6-56f59ddebc37')
		end
		
end)

RegisterNUICallback('canceljob', function(data, cb)
	if (GetGameTimer() - GUI.Time) < 1000 then
		return
	else
		GUI.Time = GetGameTimer()
	end

	if PlayerData.job.name == 'mecano' and  PlayerData.job.grade == 0 then
		--Additional Checks

			for i=1,#tow do
				if tonumber(tow[i].id) == tonumber(data.id) then
					local assigned = tow[i].assigned
					local isassigned = false
					for j=1,#assigned do
						if callsign_other == assigned[j].id then
							--permit cancel
							isassigned = true
							TriggerServerEvent('355baea7-075b-4282-93c3-21d8d6ef1660',data.id)
						end
					end
					if isassigned == false then
						 exports.pNotify:SendNotification(
								{text = 'You tried to cancel a job that you are not assigned to.',type = "error",queue = "mecano",timeout = 3000, layout= "bottomCenter"}
							 )
					end
				end	
			end
	else
		TriggerServerEvent('355baea7-075b-4282-93c3-21d8d6ef1660',data.id)
	end

end)

RegisterNUICallback('onscene', function(data, cb)
	if (GetGameTimer() - GUI.Time) < 1000 then
		return
	else
		GUI.Time = GetGameTimer()
	end
	local playerPos = GetEntityCoords( GetPlayerPed( -1 ), true )
	local streetA, streetB = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, playerPos.x, playerPos.y, playerPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
	local street = {}
	local zoneName = zones[GetNameOfZone(playerPos.x, playerPos.y, playerPos.z)]
	if not ((streetA == lastStreetA or streetA == lastStreetB) and (streetB == lastStreetA or streetB == lastStreetB)) then
		-- Ignores the switcharoo while doing circles on intersections
		lastStreetA = streetA
		lastStreetB = streetB
	end
   
	if lastStreetA ~= 0 then
		table.insert( street, GetStreetNameFromHashKey( lastStreetA ) )
	end
   
	if lastStreetB ~= 0 then
		table.insert( street, GetStreetNameFromHashKey( lastStreetB ) )
	end
	last_job = data.id
	print('on scene ' .. data.id)
	
	if PlayerData.job and PlayerData.job.name == "ambulance" then
		TriggerServerEvent('31f2be82-0e6e-464b-9086-ff7f281ace00',data.id,callsign_other)
	elseif PlayerData.job and PlayerData.job.name == "police" then
		TriggerServerEvent('31f2be82-0e6e-464b-9086-ff7f281ace00',data.id,exports['webcops']:returncallsign())
		TriggerServerEvent('7ec4ba43-ae70-47ee-991f-8377e14341cd', GetPlayerServerId(PlayerId()),zones[GetNameOfZone(playerPos.x, playerPos.y, playerPos.z)],table.concat( street, " & " ))
	elseif PlayerData.job and (PlayerData.job.name == "mecano" or PlayerData.job.name == "mecano2") then
		
	end

	for i=1,#police do
		if tostring(police[i].id) == tostring(data.id) then
			SetNewWaypoint(police[i].coords.x,police[i].coords.y)
			return
		end
	end
	
	for i=1,#ambulance do 
		if tostring(ambulance[i].id) == tostring(data.id) then
			SetNewWaypoint(ambulance[i].coords.x,ambulance[i].coords.y)
			return
		end
	end
	
	if PlayerData.job.name == 'mecano' and  PlayerData.job.grade == 0 then
			local amialreadyonajob = false
			for i=1,#tow do
				local assigned = tow[i].assigned
				if #assigned > 0 then
					for j=1,#assigned do
						if callsign_other == assigned[j].id then
							amialreadyonajob = true
						end
					end
				end
			end
			
			
			
		--Additional Checks
		if amialreadyonajob == false then
			for i=1,#tow do
				if tonumber(tow[i].id) == tonumber(data.id) then
					local assigned = tow[i].assigned
					local isassigned = false
					
					if #assigned > 0 then
						for j=1,#assigned do
							if callsign_other == assigned[j].id then
								isassigned = true
								SetNewWaypoint(tow[i].coords.x,tow[i].coords.y)
								TriggerServerEvent('31f2be82-0e6e-464b-9086-ff7f281ace00',data.id,callsign_other)

							end
						end
						if isassigned == false then
						 exports.pNotify:SendNotification(
								{text = 'You cannot go to a job that is already assigned.',type = "error",queue = "mecano",timeout = 3000, layout= "bottomCenter"}
							 )
						end
					else
						SetNewWaypoint(tow[i].coords.x,tow[i].coords.y)
						TriggerServerEvent('31f2be82-0e6e-464b-9086-ff7f281ace00',data.id,callsign_other)
					end

				end	
			end
		else
			exports.pNotify:SendNotification(
				{text = 'You cannot mark yourself arrived to more than 1 job at a time.',type = "error",queue = "mecano",timeout = 3000, layout= "bottomCenter"}
			 )
		end
			
	else
		TriggerServerEvent('31f2be82-0e6e-464b-9086-ff7f281ace00',data.id,callsign_other)
				
		for i=1,#tow do 
			if tostring(tow[i].id) == tostring(data.id) then
				SetNewWaypoint(tow[i].coords.x,tow[i].coords.y)
				return
			end
		end	
	end
	
end)

RegisterNUICallback('enroute', function(data, cb)

	if (GetGameTimer() - GUI.Time) < 1000 then
		return
	else
		GUI.Time = GetGameTimer()
	end

	local playerPos = GetEntityCoords( GetPlayerPed( -1 ), true )
	local streetA, streetB = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, playerPos.x, playerPos.y, playerPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
	local street = {}
	local zoneName = zones[GetNameOfZone(playerPos.x, playerPos.y, playerPos.z)]
	if not ((streetA == lastStreetA or streetA == lastStreetB) and (streetB == lastStreetA or streetB == lastStreetB)) then
		-- Ignores the switcharoo while doing circles on intersections
		lastStreetA = streetA
		lastStreetB = streetB
	end
   
	if lastStreetA ~= 0 then
		table.insert( street, GetStreetNameFromHashKey( lastStreetA ) )
	end
   
	if lastStreetB ~= 0 then
		table.insert( street, GetStreetNameFromHashKey( lastStreetB ) )
	end
	print('enroute ' .. data.id .. ' Job ' .. PlayerData.job.name)
	last_job = data.id
	if PlayerData.job and PlayerData.job.name == "ambulance" then
		TriggerServerEvent('e64fc93d-8ef0-4ac0-ab48-6f38185953e0',data.id,callsign_other)
	elseif PlayerData.job and PlayerData.job.name == "police" then
		TriggerServerEvent('e64fc93d-8ef0-4ac0-ab48-6f38185953e0',data.id,exports['webcops']:returncallsign())
		TriggerServerEvent('f5da16f6-e0b9-4163-9c3b-255714b5a154', GetPlayerServerId(PlayerId()),zones[GetNameOfZone(playerPos.x, playerPos.y, playerPos.z)],table.concat( street, " & " ))
		
	elseif PlayerData.job and (PlayerData.job.name == "mecano" or PlayerData.job.name == "mecano2") then
		
	end

	
	for i=1,#police do
		if tostring(police[i].id) == tostring(data.id) then
			SetNewWaypoint(police[i].coords.x,police[i].coords.y)
			return
		end
	end
	
	for i=1,#ambulance do 
		if tostring(ambulance[i].id) == tostring(data.id) then
			SetNewWaypoint(ambulance[i].coords.x,ambulance[i].coords.y)
			return
		end
	end


	if PlayerData.job.name == 'mecano' and  PlayerData.job.grade == 0 then
		--Additional Checks
			local amialreadyonajob = false
			for i=1,#tow do
				local assigned = tow[i].assigned
				if #assigned > 0 then
					for j=1,#assigned do
						if callsign_other == assigned[j].id then
							amialreadyonajob = true
						end
					end
				end
			end
			if amialreadyonajob == false then
				for i=1,#tow do
					if tonumber(tow[i].id) == tonumber(data.id) then
						local assigned = tow[i].assigned
						local isassigned = false
						
						if #assigned > 0 then
							for j=1,#assigned do
								if callsign_other == assigned[j].id then
									isassigned = true
									SetNewWaypoint(tow[i].coords.x,tow[i].coords.y)
									TriggerServerEvent('e64fc93d-8ef0-4ac0-ab48-6f38185953e0',data.id,callsign_other)

								end
							end
							if isassigned == false then
							 exports.pNotify:SendNotification(
									{text = 'You cannot go to a job that is already assigned.',type = "error",queue = "mecano",timeout = 3000, layout= "bottomCenter"}
								 )
							end
						else
							SetNewWaypoint(tow[i].coords.x,tow[i].coords.y)
							TriggerServerEvent('e64fc93d-8ef0-4ac0-ab48-6f38185953e0',data.id,callsign_other)
						end

					end	
				end
			else
				exports.pNotify:SendNotification(
					{text = 'You cannot mark yourself enroute to more than 1 job at a time.',type = "error",queue = "mecano",timeout = 3000, layout= "bottomCenter"}
				 )
			end
	else
		TriggerServerEvent('e64fc93d-8ef0-4ac0-ab48-6f38185953e0',data.id,callsign_other)
		for i=1,#tow do 
			if tostring(tow[i].id) == tostring(data.id) then
				SetNewWaypoint(tow[i].coords.x,tow[i].coords.y)
				return
			end
		end		
	end


end)




RegisterNUICallback('removeme', function(data, cb) 
	print('hit remove me')
	if (GetGameTimer() - GUI.Time) < 1000 then
		return
	else
		GUI.Time = GetGameTimer()
	end

	if PlayerData.job and PlayerData.job.name == "ambulance" then
		TriggerServerEvent('e3dd27cd-5162-461e-8465-209c51a6aff0',data.id,callsign_other)
	elseif PlayerData.job and PlayerData.job.name == "police" then
		TriggerServerEvent('e3dd27cd-5162-461e-8465-209c51a6aff0',data.id,exports['webcops']:returncallsign())
	elseif PlayerData.job and (PlayerData.job.name == "mecano" or PlayerData.job.name == "mecano2") then

		TriggerServerEvent('e3dd27cd-5162-461e-8465-209c51a6aff0',data.id,callsign_other)
	end

end)

RegisterNUICallback('gps', function(data, cb)

	for i=1,#police do

		if tostring(police[i].id) == tostring(data.id) then
			SetNewWaypoint(police[i].coords.x,police[i].coords.y)
			return
		end
	end
	
	for i=1,#ambulance do 
		if tostring(ambulance[i].id) == tostring(data.id) then
			SetNewWaypoint(ambulance[i].coords.x,ambulance[i].coords.y)
			return
		end
	end
	
	if PlayerData.job.name == 'mecano' and  PlayerData.job.grade == 0 then
		--Additional Checks
		for i=1,#tow do
			if tonumber(tow[i].id) == tonumber(data.id) then
				local assigned = tow[i].assigned
				local isassigned = false
				
				if #assigned > 0 then
					for j=1,#assigned do
						if callsign_other == assigned[j].id then
							isassigned = true
							SetNewWaypoint(tow[i].coords.x,tow[i].coords.y)
						end
					end
				end
			
				if isassigned == false then
				 exports.pNotify:SendNotification(
						{text = 'You cannot get the GPS location of a job you are not assigned to.',type = "error",queue = "mecano",timeout = 3000, layout= "bottomCenter"}
				)
				end
			end	
		end
	else
		for i=1,#tow do 
			if tostring(tow[i].id) == tostring(data.id) then
				SetNewWaypoint(tow[i].coords.x,tow[i].coords.y)
				return
			end
		end		
		
		return
	end
end)





RegisterNetEvent('294fe3b7-cea9-42d1-88ef-f6d4716247cc')
AddEventHandler('042536f3-c8f0-49a0-8d44-59e9a2812fcd', function(results)

		
		for i=1,#results do 
			results[i].location = "City Location " .. i
		end
        SendNUIMessage({
          civilianresults = results
        })
end)

RegisterNetEvent('a4645e30-06ea-46aa-8f89-edb23761e7cb')
AddEventHandler('a4645e30-06ea-46aa-8f89-edb23761e7cb', function()
	last_status = "code1"
end)




RegisterNetEvent('54169228-4239-4749-958f-8de48de794e7')
AddEventHandler('54169228-4239-4749-958f-8de48de794e7', function()
	last_status = "code1r"
	TriggerServerEvent('e64fc93d-8ef0-4ac0-ab48-6f38185953e0',last_call,exports['webcops']:returncallsign())

	for i=1,#police do
		if tostring(police[i].id) == tostring(last_call) then
			last_job = last_call
			SetNewWaypoint(police[i].coords.x,police[i].coords.y)
			return
		end
	end
	
	for i=1,#ambulance do 
		if ambulance[i].id == last_call then
			SetNewWaypoint(ambulance[i].coords.x,ambulance[i].coords.y)
			return
		end
	end
	
	for i=1,#tow do 
		if tow[i].id == last_call then
			SetNewWaypoint(tow[i].coords.x,tow[i].coords.y)
			return
		end
	end
end)




RegisterNetEvent('cfa087db-4c68-4486-bea0-6133a7ea6a06')
AddEventHandler('cfa087db-4c68-4486-bea0-6133a7ea6a06', function()
	local playerPos = GetEntityCoords( GetPlayerPed( -1 ), true )

	if last_status == "code1" then
		TriggerServerEvent('8e9e9311-9c90-4189-99d6-cd1bd1f18812',"police",exports['webcops']:returncallsign(),"traffic stop","self traffic stop",{x = playerPos.x, y = playerPos.y, z= playerPos.z})
	end
	last_status = "code4"
	TriggerServerEvent('31f2be82-0e6e-464b-9086-ff7f281ace00',last_job,exports['webcops']:returncallsign())

	for i=1,#police do
		if tostring(police[i].id) == tostring(last_job) then
			SetNewWaypoint(police[i].coords.x,police[i].coords.y)
			return
		end
	end
	
	for i=1,#ambulance do 
		if ambulance[i].id == last_job then
			SetNewWaypoint(ambulance[i].coords.x,ambulance[i].coords.y)
			return
		end
	end

	if PlayerData.job.name == 'mecano' and  PlayerData.job.grade == 0 then
		--Additional Checks
		for i=1,#tow do
			if tonumber(tow[i].id) == tonumber(data.id) then
				local assigned = tow[i].assigned
				local isassigned = false
				
				if #assigned > 0 then
					for j=1,#assigned do
						if callsign_other == assigned[j].id then
							isassigned = true
							SetNewWaypoint(tow[i].coords.x,tow[i].coords.y)
						end
					end
				end
			
				if isassigned == false then
				 exports.pNotify:SendNotification(
						{text = 'You cannot get the GPS location of a job you are not assigned to.',type = "error",queue = "mecano",timeout = 3000, layout= "bottomCenter"}
				)
				end
			end	
		end
	else
		SetNewWaypoint(tow[i].coords.x,tow[i].coords.y)
		return
	end
end)


RegisterNetEvent('51e75582-e3be-4c21-9a6a-3cf982b41b1a')
AddEventHandler('51e75582-e3be-4c21-9a6a-3cf982b41b1a', function()
	local playerPos = GetEntityCoords( GetPlayerPed( -1 ), true )
	
	if last_status == "code1" then
		TriggerServerEvent('8e9e9311-9c90-4189-99d6-cd1bd1f18812',"police",exports['webcops']:returncallsign(),"arrived","self arrived",{x = playerPos.x, y = playerPos.y, z=playerPos.z})
	end

	last_status = "code5"
	TriggerServerEvent('31f2be82-0e6e-464b-9086-ff7f281ace00',last_job,exports['webcops']:returncallsign())
	for i=1,#police do
		if tostring(police[i].id) == tostring(last_job) then
			SetNewWaypoint(police[i].coords.x,police[i].coords.y)
			return
		end
	end
	
	for i=1,#ambulance do 
		if ambulance[i].id == last_job then
			SetNewWaypoint(ambulance[i].coords.x,ambulance[i].coords.y)
			return
		end
	end
	
	for i=1,#tow do 
		if tow[i].id == last_job then
			SetNewWaypoint(tow[i].coords.x,tow[i].coords.y)
			return
		end
	end
end)



function OpenCadSystem()
  local playerPed = myPed
  GUI.PoliceCadIsShowed = true
  SendNUIMessage({
      showCadSystem = true,
    })
  ESX.SetTimeout(250, function()
    SetNuiFocus(true, true)

	if vehiclein > 0 then
		local speed = GetEntitySpeed(vehiclein)
		if speed > 1 then
			 GUI.isdriving = true
			 SetNuiFocusKeepInput(true)
		end
	else
		local speed = GetEntitySpeed(myPed)
		if speed > 0 then
			 GUI.isdriving = true
			 SetNuiFocusKeepInput(true)
		end
	end
  end)
  
end

function CloseCadSystem()
 
  local playerPed = myPed
  SendNUIMessage({
    showCadSystem = false
  })
  SetNuiFocus(false)
  GUI.PoliceCadIsShowed = false
  GUI.isdriving = false
  ClearPedTasks(playerPed)

end

RegisterNUICallback('escape', function()
  ESX.UI.Menu.Close('cadsystem', GetCurrentResourceName(), 'main')
  SetNuiFocusKeepInput(false)
end)

RegisterNUICallback('search-plate', function(data)
  TriggerServerEvent('2e92d976-e608-4d58-bc49-c9c278abe0e5', data.plate)
end)




RegisterNUICallback('requestpolice', function(data)
	print('call back police request' .. data.id)
	for i=1,#ambulance do 
		if tostring(ambulance[i].id) == tostring(data.id) then
			
			SetNewWaypoint(ambulance[i].coords.x,ambulance[i].coords.y)
			
			local plyPos = ambulance[i].coords
			local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
			local street1 = GetStreetNameFromHashKey(s1)
			local street2 = GetStreetNameFromHashKey(s2)
			
			local emergloc = '~o~AMB/FIRE~w~ POLICE ATTENDANCE REQUEST: '
			
			
			if s2 ~= 0 then
				emergloc = emergloc .. 'Cnr ' .. street1 .. ' and ' .. street2
			else
				emergloc = emergloc .. ' ' .. street1 
			end
			
			emergloc = emergloc .. ' POLICE HAVE BEEN REQUESTED TO ATTEND AV CALL :: AV ENROUTE'
			
			
			local loci1 = exports['webcops']:getLocationReturn()
			--local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
			--TriggerServerEvent('67cc61df-e6be-41d8-9bec-023459661970', GetPlayerServerId(PlayerId()), emergloc, loci1 , plyPos.x, plyPos.y, plyPos.z, 'police', '000', false)
			local PlayerCoords = { x = plyPos.x, y = plyPos.y, z = plyPos.z }
			TriggerServerEvent('c916860b-b2ca-42eb-9eac-cf20b6341eac', 'police',  emergloc, PlayerCoords, {

					PlayerCoords = { x = plyPos.x, y = plyPos.y, z = plyPos.z },
			})
			
			TriggerServerEvent('c916860b-b2ca-42eb-9eac-cf20b6341eac', 'ambulance',  emergloc, PlayerCoords, {

					PlayerCoords = { x = plyPos.x, y = plyPos.y, z = plyPos.z },
			})
			
				if PlayerData.job and PlayerData.job.name == "ambulance" then
					TriggerServerEvent('66eb134f-21a7-4c03-9e3c-2af015100aeb',data.id,callsign_other,"Police Att. Req")
				elseif PlayerData.job and PlayerData.job.name == "police" then
					TriggerServerEvent('66eb134f-21a7-4c03-9e3c-2af015100aeb',data.id,exports['webcops']:returncallsign(),"Police Att. Req")
				end
			
			--TriggerServerEvent('67cc61df-e6be-41d8-9bec-023459661970', tostring(GetPlayerServerId(PlayerId())), emergloc , plyPos.x, plyPos.y, plyPos.z , 'police', '000', true)
			ESX.ShowNotification("Police Attendance requested: Police have been notified for job: " .. ambulance[i].id)
			return
		end
	end
	
	
 
end)


RegisterNUICallback('add-cr', function(data)
  officer = ESX.GetPlayerData(-1);
  TriggerServerEvent('334e73e7-be90-437a-98d9-7be00051aab8', data, officer.identifier)
end)

RegisterNUICallback('add-note', function(data)
  officer = ESX.GetPlayerData(-1);
  TriggerServerEvent('16b21cea-07f8-4be2-9455-35572dd36e00', data, officer.identifier)
end)

RegisterNUICallback('add-bolo', function(data)
  TriggerServerEvent('b3809aea-3d71-4836-9360-8f989eb5d5a3', data)
end)

RegisterNUICallback('get-cr', function(playerid)
  TriggerServerEvent('f8c98d70-98ac-4125-923d-01a86666b142', playerid.playerid)
end)

RegisterNUICallback('get-bolos', function()
  TriggerServerEvent('d51f65f6-0f2a-4081-9484-34bc298c5187')
end)

RegisterNUICallback('get-note', function(playerid)
  TriggerServerEvent('61447ab6-d5f5-4829-82d3-7ab06f63cfd1', playerid.playerid)
end)

RegisterNUICallback('delete_note', function(noteId)
  TriggerServerEvent('b5500a63-4e60-45a2-9b89-411c31805a93', noteId)
end)

RegisterNUICallback('delete_cr', function(crId)
  TriggerServerEvent('0bd33c94-8568-41a6-b77b-66a9c28a92a1', crId)
end)

RegisterNUICallback('delete-bolo', function(boloId)
  TriggerServerEvent('0ad7c895-a2b6-447e-8d1b-b3d176fd5dea', boloId)
end)

RegisterNUICallback('get-license', function(playerid)
  TriggerServerEvent('89913036-d5cf-430d-9d75-eea7ac12c5b8', playerid.playerid)
end)

RegisterNUICallback('search-players', function(data)
  TriggerServerEvent('15ed7cd2-06b1-4f66-afae-2c67ce7a978d', data.search)
end)

Citizen.CreateThread(function()
	local drivingwastrue = false
	local countdown = 50
    while true do
    Citizen.Wait(0)
		if GUI.isdriving == true then
			drivingwastrue = true
			countdown = 50
		else
			if drivingwastrue == true and countdown > 0 then
				countdown = countdown - 1
			elseif drivingwastrue == true and countdown <= 0 then
				drivingwastrue = false
				SetPauseMenuActive(true)
			end
		end		
		
		
		if drivingwastrue == true then
			DisableControlAction(2, 1, true) -- Disable pan
			DisableControlAction(2, 2, true) -- Disable tilt
			DisableControlAction(2, 199, true) --Pause
			DisableControlAction(1, 200, true)
			DisableControlAction(0, 200, true) --Pause
			DisableControlAction(2, 200, true) --Pause
			DisableControlAction(1, 199, true)
			DisableControlAction(0, 199, true)
			
			DisableControlAction(1, 140, true)
			DisableControlAction(1, 141, true)
			DisableControlAction(1, 142, true)
			DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
			DisablePlayerFiring(ped, true) -- Disable weapon firing
			SetPauseMenuActive(false)

		end

		if GUI.PhoneIsShowed then -- codes here: https://pastebin.com/guYd0ht4
			  DisableControlAction(0, 1,    true) -- LookLeftRight
			  DisableControlAction(0, 2,    true) -- LookUpDown
			  DisableControlAction(0, 25,   true) -- Input Aim
			  DisableControlAction(0, 106,  true) -- Vehicle Mouse Control Override
			  DisablecontrolAction(0, 289,  true) -- F2
			  DisablecontrolAction(0, 167,  true) -- F6
			  DisablecontrolAction(0, 168,  true) -- F7

			  


			  DisableControlAction(0, 24,   true) -- Input Attack
			  DisableControlAction(0, 140,  true) -- Melee Attack Alternate
			  DisableControlAction(0, 141,  true) -- Melee Attack Alternate
			  DisableControlAction(0, 142,  true) -- Melee Attack Alternate
			  DisableControlAction(0, 257,  true) -- Input Attack 2
			  DisableControlAction(0, 263,  true) -- Input Melee Attack
			  DisableControlAction(0, 264,  true) -- Input Melee Attack 2

			  DisableControlAction(0, 12,   true) -- Weapon Wheel Up Down
			  DisableControlAction(0, 14,   true) -- Weapon Wheel Next
			  DisableControlAction(0, 15,   true) -- Weapon Wheel Prev
			  DisableControlAction(0, 16,   true) -- Select Next Weapon
			  DisableControlAction(0, 17,   true) -- Select Prev Weapon
			  if IsDisabledControlJustReleased(0, 142) then -- MeleeAttackAlternate
			  

				  SendNUIMessage({
					  type = "click"
				  })
			  end
		else
		
			DisableControlAction(0, 83, true)
			if IsDisabledControlJustReleased(0, 83) and not isDead and PlayerData.job ~= nil and (PlayerData.job.name == 'police' or  PlayerData.job.name == 'ambulance' or  PlayerData.job.name == 'mecano' ) then
				TriggerEvent('e287cab5-e7a2-4ad3-a46d-287a08581a23')
			end

		end
  end
end)
	
RegisterNetEvent('e287cab5-e7a2-4ad3-a46d-287a08581a23')
AddEventHandler('e287cab5-e7a2-4ad3-a46d-287a08581a23', function()
	if (GetGameTimer() - GUI.Time) > 150 and PlayerData.job and ( PlayerData.job.name == 'police' or  PlayerData.job.name == 'ambulance' or  PlayerData.job.name == 'mecano' or  PlayerData.job.name == 'mecano2') then
			ESX.UI.Menu.CloseAll()
            if not ESX.UI.Menu.IsOpen('cadsystem', GetCurrentResourceName(), 'main') then
              ESX.UI.Menu.CloseAll()
		
			
              ESX.UI.Menu.Open('cadsystem', GetCurrentResourceName(), 'main')
			  
			 
            end
            GUI.Time = GetGameTimer()
  else
    
  end

end)
	

-- Command register
RegisterCommand("oc", function(source, args, raw)
   if (GetGameTimer() - GUI.Time) > 150 and PlayerData.job and ( PlayerData.job.name == 'police' or  PlayerData.job.name == 'ambulance' or  PlayerData.job.name == 'mecano' or  PlayerData.job.name == 'mecano2') then
   ESX.UI.Menu.CloseAll()
            if not ESX.UI.Menu.IsOpen('cadsystem', GetCurrentResourceName(), 'main') then
              ESX.UI.Menu.CloseAll()
		
			
              ESX.UI.Menu.Open('cadsystem', GetCurrentResourceName(), 'main')
			  
			 
            end
            GUI.Time = GetGameTimer()
  else
    
  end
end)

RegisterCommand("opencad", function(source, args, raw)
   if (GetGameTimer() - GUI.Time) > 150 and PlayerData.job and PlayerData.job.name == 'police' or (GetGameTimer() - GUI.Time) > 150 and PlayerData.job and PlayerData.job.name == 'ambulance' then
   ESX.UI.Menu.CloseAll()
            if not ESX.UI.Menu.IsOpen('cadsystem', GetCurrentResourceName(), 'main') then
              ESX.UI.Menu.CloseAll()
              ESX.UI.Menu.Open('cadsystem', GetCurrentResourceName(), 'main')
            end
            GUI.Time = GetGameTimer()
  else
    
  end
end)


RegisterNetEvent('3b2df7fa-4dca-41a7-bc9b-2607dfb1fa40')
AddEventHandler('3b2df7fa-4dca-41a7-bc9b-2607dfb1fa40', function(plate,model,firstname,lastname)
        SendNUIMessage({
          plate = plate,
          model = model,
          firstname = firstname,
          lastname = lastname
        })
end)



RegisterNetEvent('da5398ec-9231-4f6e-a2f3-b7a27de92d85')
AddEventHandler('da5398ec-9231-4f6e-a2f3-b7a27de92d85', function()
        SendNUIMessage({
          plate = 'Not found',
          model = '',
          firstname = '',
          lastname = ''
        })
end)

RegisterNUICallback('esx_police_cad:search-players', function(data)
  TriggerServerEvent('15ed7cd2-06b1-4f66-afae-2c67ce7a978d', data.search)
end)

RegisterNetEvent('042536f3-c8f0-49a0-8d44-59e9a2812fcd')
AddEventHandler('042536f3-c8f0-49a0-8d44-59e9a2812fcd', function(results)
        SendNUIMessage({
          civilianresults = results
        })
end)

RegisterNetEvent('8b4adf36-e5e7-49d3-af85-b1d67f763430')
AddEventHandler('8b4adf36-e5e7-49d3-af85-b1d67f763430', function(results)
        SendNUIMessage({
          crresults = results
        })
end)

RegisterNetEvent('c55d9818-2a8d-4fa7-87e2-8347a99fa705')
AddEventHandler('c55d9818-2a8d-4fa7-87e2-8347a99fa705', function(results)
        SendNUIMessage({
          noteResults = results
        })
end)

RegisterNetEvent('eb4a1a7a-fa56-4ff9-ae07-cc3c19235b91')
AddEventHandler('eb4a1a7a-fa56-4ff9-ae07-cc3c19235b91', function(results)
        SendNUIMessage({
          licenseResults = results
        })
end)

AddEventHandler('c55d9818-2a8d-4fa7-87e2-8347a99fa705', function(results)
        SendNUIMessage({
          noteResults = results
        })
end)

RegisterNetEvent('bbb9e18e-364d-461a-87cd-123853978598')
AddEventHandler('bbb9e18e-364d-461a-87cd-123853978598', function()
        SendNUIMessage({
          note_deleted = true
        })
end)

RegisterNetEvent('be8ddb74-613d-4f40-97fd-ac1c92d7738a')
AddEventHandler('be8ddb74-613d-4f40-97fd-ac1c92d7738a', function()
        SendNUIMessage({
           note_not_deleted = true
        })
end)

RegisterNetEvent('ddab3729-36cb-40a5-a334-7c05cd4da7fc')
AddEventHandler('ddab3729-36cb-40a5-a334-7c05cd4da7fc', function()
        SendNUIMessage({
            cr_deleted = true
        })
end)

RegisterNetEvent('a2bc4d28-894a-4a66-919b-783f2fa645b3')
AddEventHandler('a2bc4d28-894a-4a66-919b-783f2fa645b3', function()
        SendNUIMessage({
            cr_not_deleted = true
        })
end)

RegisterNetEvent('52ac24c3-1251-476d-8896-23a54b9c63c5')
AddEventHandler('52ac24c3-1251-476d-8896-23a54b9c63c5', function(results)
        SendNUIMessage({
          showBolos = results
        })
end)

RegisterNetEvent('165257cf-7808-456b-8ea6-6d09a55dc09a')
AddEventHandler('165257cf-7808-456b-8ea6-6d09a55dc09a', function()
        SendNUIMessage({
          bolo_deleted = true
        })
end)

RegisterNetEvent('be8ddb74-613d-4f40-97fd-ac1c92d7738a')
AddEventHandler('ec2aaef2-574f-4963-b162-050386cc6d38', function()
        SendNUIMessage({
           bolo_not_deleted = true
        })
end)





function returnlocation(x,y,z)
	
			local zoneNameFull = zones[GetNameOfZone(x, y, z)]
			local streetName1, streetName2 = GetStreetNameAtCoord(x, y, z)
			local streetName = GetStreetNameFromHashKey(streetName1)
			if streetName2 ~= nil and string.len(streetName2) > 2 then
				streetName = "Cnr " .. streetName .. " & " .. GetStreetNameFromHashKey(streetName2)
			end

			local locationMessage = nil

			if zoneNameFull then 
				locationMessage = streetName .. ' ' .. zoneNameFull
			else
				locationMessage = streetName
			end
		return locationMessage

end
