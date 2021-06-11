--[[
    NUI
]]

--[[ADDING CIV CALLBACKS]]
RegisterNUICallback("civ", function(data, cb)
    if data[1] == nil then
        return
    elseif data[1] == "newname" then
        createCivilian()
		
	elseif data[1] == "windows" then
		rollwindows()
		exitAllMenus()
		SendNUIMessage({endexit = true})
		
	elseif data[1] == "keys" then
		givekeystopass()
		exitAllMenus()
		SendNUIMessage({endexit = true})
    elseif data[1] == "warrant" then
        toggleWarrant()
    elseif data[1] == "citations" then
        civCitations()
    elseif data[1] == "911init" then
        init911()
    elseif data[1] == "911msg" then
        msg911()
    elseif data[1] == "911end" then
        end911()
    elseif data[1] == "newveh" then
        createCivVehicle()
    elseif data[1] == "vehstolen" then
        toggleVehStolen()
    elseif data[1] == "vehregi" then
        toggleVehRegi()
    elseif data[1] == "vehinsurance" then
        toggleVehInsured()
    elseif data[1] == "civdisplay" then
        displayCivilian()
    elseif data[1] == "vehdisplay" then
        displayVeh()
	elseif data[1] == "topolice" then
		GiveLicenceToPolice()
	elseif data[1] == "swapjob" then
		TriggerServerEvent('4d34baf8-b411-46ca-9683-acf96e2bc6fb', getHandle(),getHandle())
    end

	if cb then cb("OK") end
end)

RegisterNetEvent('ba899eb5-167a-47a8-bbe3-d9817b3d9b37')
AddEventHandler('ba899eb5-167a-47a8-bbe3-d9817b3d9b37', function(sidebar,sound,flags)
	TriggerEvent('07da2d3f-8b0d-405f-b039-8e894adda985',sidebar)
	TriggerEvent('07da2d3f-8b0d-405f-b039-8e894adda985',flags)
end)

--[[ADDING LEO CALLBACKS]]
RegisterNUICallback("leo", function(data, cb)

print('settings hit here 2')
    if data[1] == nil then
        return
		
	elseif data[1] == "copsd" then
		
		turnOnCadEntryLookUp()
    elseif data[1] == "create" then
        createOfficer()
	elseif data[1] == "create1" then
		createOfficer1()
    elseif data[1] == "displayduty" then
        displayStatus()
	elseif data[1] == "db" then
		duressBtn()  --used
    elseif data[1] == "onduty" or data[1] == "offduty" or data[1] == "busy" or data[1] == "traffics" or data[1] == "onscene" or data[1] == "responding" then
		print('settings hit here')
        changeStatus(data[1])
		
    elseif data[1] == "ncic" then
        leoNcic()
    elseif data[1] == "note" then
        if data[2] == "add" then
            leoAddNote()
        elseif data[2] == "view" then
            leoNcicNotes()
        end
    elseif data[1] == "ticket" then
        if data[2] == "add" then
            leoAddTicket()
        elseif data[2] == "view" then
            leoNcicTickets()
        end
    elseif data[1] == "plate" then
        leoPlate()
	elseif data[1] == "robbs" then

		TriggerServerEvent('f9c1bd71-b65a-4e38-a375-3e84be686491',getHandle())
    elseif data[1] == "bolo" then
        if data[2] == "add" then
            leoAddBolo()
        elseif data[2] == "view" then
            leoViewBolos()
        end
    end

    if cb then cb("OK") end
end)
--[[ADDING COMMON CALLBACKS]]
RegisterNUICallback("common", function(data, cb)
    if data[1] == nil then
        return
    elseif data[1] == "exit" then
        safeExit()
    elseif data[1] == "dsreset" then
		nswloggedInCops = false
        TriggerServerEvent('6934e291-24cb-440b-80d0-06414496b58b', getHandle())
		TriggerServerEvent('es:setJobDuty',tostring(GetPlayerServerId(PlayerId())), false)
		TriggerEvent('33b38819-e3bb-42aa-91d2-1a1f89b865c1')
    end

	--sendMessage("@@@@ I just made a request for information" , {255,255,0},"") 
    TriggerServerEvent('a2d04cfc-c68c-4726-a28d-586c34a52dcf', getHandle())

    if cb then cb("OK") end
end)


RegisterNUICallback('refreshcad', function(data, cb)
	current_clicks = current_clicks + 1

	--for _, fieldname in ipairs(crimes) do
	--	crimelist = crimelist .. fieldname .. ","
	--end
	Citizen.Trace('Send refreshcad')
	TriggerServerEvent('28bc09f9-fbf5-4c83-957d-173108f8c0b2',getHandle())
	return

end)



RegisterNUICallback('refreshpolice', function(data, cb)
	current_clicks = current_clicks + 1

	--for _, fieldname in ipairs(crimes) do
	--	crimelist = crimelist .. fieldname .. ","
	--end
	Citizen.Trace('Send refreshcad')
	TriggerServerEvent('6bf5ea06-21a7-4db8-b9a1-1d921e4b209b',getHandle())
	return

end)

RegisterNUICallback('refreshphone', function(data, cb)
	current_clicks = current_clicks + 1

	--for _, fieldname in ipairs(crimes) do
	--	crimelist = crimelist .. fieldname .. ","
	--end
	Citizen.Trace('Send refreshcad')
	TriggerServerEvent('2f003ed1-8b4a-4c10-a6e1-64425d4a385a',getHandle())
	return

end)


RegisterNUICallback('setflag', function(data, cb)
	current_clicks = current_clicks + 1

	--for _, fieldname in ipairs(crimes) do
	--	crimelist = crimelist .. fieldname .. ","
	--end
	if data.flag == "addwarrant" then
		TriggerServerEvent('5b93ac59-9a81-4fd1-be48-fb036216c244', getHandle(), data.flag, data.name, data.reason, data.type)
	else
		TriggerServerEvent('5b93ac59-9a81-4fd1-be48-fb036216c244', getHandle(), data.flag, data.name)
	end
	return
	--TriggerEvent('07da2d3f-8b0d-405f-b039-8e894adda985','~w~' .. crimelist)
	--TriggerEvent('07da2d3f-8b0d-405f-b039-8e894adda985','~r~' .. data.datetime)
	
	--TriggerServerEvent('6bd4c33a-bc1b-48e6-b2ca-384a40907b5c', data.type, data.user, data.param)
end)



RegisterNUICallback('setv', function(data, cb)
	print('setv received')
	current_clicks = current_clicks + 1
	local crimelist = ""
	local crimes = data.crimes

		TriggerServerEvent('ca2fd01b-a7e1-4360-886a-62079a27746b', data.name)
	return

end)


RegisterNUICallback('setvc', function(data, cb)

	print('setvc click')
	current_clicks = current_clicks + 1
	local crimelist = ""
	local crimes = data.crimes
	--for _, fieldname in ipairs(crimes) do
	--	crimelist = crimelist .. fieldname .. ","
	--end
	print('send to server')
	TriggerServerEvent('5916a1f3-b802-4674-a9a4-dfc3e02e27fd', data.name)
	return

end)

RegisterNUICallback("btproxm", function(data, cb)

	if data[1] == nil then
        return
	elseif data[1] == "prxcount" then
        countToFive(true)
	elseif data[1] == "prxrefuse" then
		countToFive(false)
	elseif data[1] == "pblow" then
		breathTestStraw(true)
	elseif data[1] == "pblowrefuse" then
		breathTestStraw(false)
	elseif data[1] == "dtresult" then
		if data[2] == "true,false" then
			drugTest(true,true,false)
		elseif data[2] == "true,true" then
			drugTest(true,true,true)
		elseif data[2] == "false,false" then
			drugTest(true,false,false)
		elseif data[2] == "false,true" then
			drugTest(true,false,true)
		elseif data[2] == "refuse" then
			drugTest(false,false,false)
		end
	end
end)

RegisterNUICallback('refreshpolice', function(data, cb)
	current_clicks = current_clicks + 1

	--for _, fieldname in ipairs(crimes) do
	--	crimelist = crimelist .. fieldname .. ","
	--end
	TriggerServerEvent("dispatchsystem:supers",getHandle())
	return

end)


RegisterNUICallback('escape', function()
  	print('escape')
	exitAllMenus()
	SendNUIMessage({endexit = true})
		
end)

RegisterNUICallback('setstolen', function(data, cb)
	current_clicks = current_clicks + 1

	--for _, fieldname in ipairs(crimes) do
	--	crimelist = crimelist .. fieldname .. ","
	--end

		TriggerServerEvent('5b93ac59-9a81-4fd1-be48-fb036216c244', getHandle(), data.flag, data.name)

	return
	--TriggerEvent('07da2d3f-8b0d-405f-b039-8e894adda985','~w~' .. crimelist)
	--TriggerEvent('07da2d3f-8b0d-405f-b039-8e894adda985','~r~' .. data.datetime)
	
	--TriggerServerEvent('6bd4c33a-bc1b-48e6-b2ca-384a40907b5c', data.type, data.user, data.param)
end)
--[[                                 END OF NUI                                 ]]


function turnOnCadEntryLookUp()
	--TriggerServerEvent('a2d04cfc-c68c-4726-a28d-586c34a52dcf', getHandle())

	SetNuiFocus(true, true)
	SendNUIMessage({showcadlookup = true})
end


RegisterCommand("id", function(source, args, raw)
   GiveLicenceToPolice()
end)
RegisterCommand("windowsdown", function(source, args, raw)
   rollwindows()
end)



function GiveLicenceToPolice()
	SendNUIMessage({endexit = true})
	Wait(150)
	TriggerServerEvent('418ac8f2-5890-4247-8ece-e1606b042721',ListofPlayersandDistancesSL())
end


function GiveLicenceToClosestPlayer()
	
	Wait(800)
	SendNUIMessage({endexit = true})
	
	local closestPlayer, closestDistance = GetClosestPlayer()--exports['es_extended']:ESXGameGetClosestPlayer()

	if closestPlayer ~= nil and closestDistance < 2.5 then

		TriggerServerEvent('1ae17a8d-88ee-4dd1-a3c1-f2d909aaee16',GetPlayerServerId(closestPlayer))
	end
end

RegisterCommand("glic", function(source, args, raw)
   GiveLicenceToClosestPlayer()
   GiveLicenceToPolice()
end)

function GivePoliceIdentification(grade)
	if grade == nil then
		grade = 0
	end
	SendNUIMessage({endexit = true})
	Wait(150)
	TriggerServerEvent('e2d4c29b-664b-45c2-a794-cbbdaefa036e', getHandle(),ListofPlayersandDistancesSL(),grade)
end



RegisterNetEvent('1d501847-5210-42f3-8283-55f4796d40aa')
RegisterNetEvent('2bd17ebe-ff42-4357-aa6c-36c4eca7998d')
RegisterNetEvent('4f62edd6-b073-4ad0-b20f-77911c24fbea')
RegisterNetEvent('783911e5-8df1-473e-a260-0f2c625ca72a')
RegisterNetEvent('102afe84-7f81-40be-8d1b-68ebc62fa0d1')


AddEventHandler('783911e5-8df1-473e-a260-0f2c625ca72a', function(status, reading,reading2)
    SendNUIMessage({displayChange = true, data = {status,reading,reading2}})


end)

AddEventHandler('102afe84-7f81-40be-8d1b-68ebc62fa0d1', function(canibas, methamp)
    SendNUIMessage({displayChangeDT = true, data = {canibas, methamp}})

end)

local currentblips = {}

RegisterNetEvent('affc20fe-0255-4167-93a5-6b3b6aa8b77c')
AddEventHandler('affc20fe-0255-4167-93a5-6b3b6aa8b77c', function(blist)

	for i = 1,#currentblips do
		RemoveBlip(currentblips[i])
	end
	for k,v in pairs(blist) do
		--local loc = vector3(v.coords.x,v.coords.y,v.loc.z)
		local blip
		
		
		if NetworkDoesEntityExistWithNetworkId(tonumber(k)) then
			local vehid = NetworkGetEntityFromNetworkId(tonumber(k))
			blip = AddBlipForEntity(vehid)
			--blip = AddBlipForCoord(v.coords)
		else
			--blip = AddBlipForEntity(vehid)
			blip = AddBlipForCoord(v.coords)
		end
		SetBlipScale  (blip, 0.6)
		if v.model == 1 then
			SetBlipSprite (blip, 64)
			SetBlipColour (blip, 48)
			SetBlipScale  (blip, 1.1)
		elseif v.model == 99 then
			SetBlipSprite (blip, 477)
			SetBlipColour (blip, 67)
			SetBlipScale  (blip, 1.3)	
		elseif v.sirenon == 1 then
			
			SetBlipSprite (blip, 42)
			
		else
			
			SetBlipSprite (blip, 3)
			--SetBlipColour (blip, 38)
		end
		--SetBlipColour (blip, 38)
		SetBlipDisplay(blip, 2)
		
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('!'..v.callsign)
		EndTextCommandSetBlipName(blip)
		table.insert(currentblips, blip)
	end
end)



function getLocationReturn()

	local lastStreetA = 0
    local lastStreetB = 0
    local lastStreetName = {}
	
		local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }

        local playerPos = GetEntityCoords( GetPlayerPed( -1 ), true )
        local streetA, streetB = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, playerPos.x, playerPos.y, playerPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
        local street = {}
				
       
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

		local myloc = table.concat( street, " & " ) .. ', ' .. zones[GetNameOfZone(playerPos.x, playerPos.y, playerPos.z)]
		return myloc
end



AddEventHandler('1d501847-5210-42f3-8283-55f4796d40aa', function(officerhandle, copmenu)
	testingHandleID = officerhandle
	print(testingHandleID)
	exitAllMenus()
	if menu == nil then
		turnOnBTProxM(copmenu)
	else
		exitAllMenus()
	end
end)

AddEventHandler('2bd17ebe-ff42-4357-aa6c-36c4eca7998d', function(officerhandle, copmenu)
	testingHandleID = officerhandle
	exitAllMenus()
	if menu == nil then
		turnOnBTM(copmenu)
	else
		exitAllMenus()
	end
end)

AddEventHandler('4f62edd6-b073-4ad0-b20f-77911c24fbea', function(officerhandle, copmenu)

	testingHandleID = officerhandle
	exitAllMenus()
	if menu == nil then
		turnOnDTM(copmenu)
	else
		exitAllMenus()
	end
end)

RegisterNetEvent('eae9d9a7-8104-462e-b609-a4a6b7c6e755')
AddEventHandler('eae9d9a7-8104-462e-b609-a4a6b7c6e755', function()

	SendNUIMessage({endexit = true})
	exitAllMenus()

	--SetNuiFocus(false)
	
end)