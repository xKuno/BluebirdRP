--[[
    SERVER & CLIENT TRANSACTIONS
]]
nswloggedInCops = false
nswloggedInCallSign = ""
testingHandleID = ""

--Keyboardmenu variable for k menu
pentingkeyboardinput = false


--MENU management for clicks
ztimer = 0
threshold = 5
clicklimit = 4
current_clicks = 0
penalties = 0
maxpenalties = 8
penaltyapplied = false

Citizen.CreateThread(function()
    while true do
        Wait(1000)
        ztimer = ztimer + 1
    end
end)

Citizen.CreateThread(function()
    while true do
        Wait(1500)
        if ztimer > threshold then
			ztimer = 0
			current_clicks = 0
			penaltyapplied = false
		elseif current_clicks >= clicklimit then
			if penaltyapplied == false then
				penalties = penalties + 1
				penaltyapplied = true
			end
		end
		
		if penalties > maxpenalties then
			TriggerServerEvent("dispatchsystem:endclient",getHandle())
		end
		
		if moderatedaccesslevelds == 1 then
			maxpenalties = 8
		end
		if moderatedaccesslevelds == 3 then
			maxpenalties = 15
		end
    end
end)




--Legacy

moderatedaccesslevelds = 0

function moda()
	return moderatedaccesslevelds
end

function returncallsign()
	return string.upper(nswloggedInCallSign)
end

function amiloggedin()
	return nswloggedInCops
end

 ---KNOWN USED
function toggleFullCar()
    TriggerServerEvent('6b0c19e5-9da5-4780-887e-cb0ed8461db2', getHandle(),1)
end

function toggleCurrent()
	print('dsmain toggleCurrent')
    TriggerServerEvent('26e64654-6ebf-49b2-9d82-8a274137e2ff', getHandle(),1)
end

function toggleHeavyCombination()
    TriggerServerEvent('6b0c19e5-9da5-4780-887e-cb0ed8461db2', getHandle(),5)
end

function toggleMB()
    TriggerServerEvent('392454ac-75a0-4d70-a165-c3e6efe43375', getHandle())
end

function toggleLearn()
    TriggerServerEvent('6b0c19e5-9da5-4780-887e-cb0ed8461db2', getHandle(),4)
end

---KNOWN USED
function toggleFlag(flag)
    TriggerServerEvent("dispatchsystem:toggleFlag", getHandle(),flag)
end

function toggleNoLicence()
    TriggerServerEvent('26e64654-6ebf-49b2-9d82-8a274137e2ff', getHandle(),0)
end
function toggleExpired()
    TriggerServerEvent('26e64654-6ebf-49b2-9d82-8a274137e2ff', getHandle(),3)
end
function toggleCancelled()
    TriggerServerEvent('26e64654-6ebf-49b2-9d82-8a274137e2ff', getHandle(),4)
end
function toggleSuspended()
    TriggerServerEvent('26e64654-6ebf-49b2-9d82-8a274137e2ff', getHandle(),2)
end


function toggleP1()
    TriggerServerEvent('6b0c19e5-9da5-4780-887e-cb0ed8461db2', getHandle(),3)
end

function toggleP2()
    TriggerServerEvent('6b0c19e5-9da5-4780-887e-cb0ed8461db2', getHandle(),2)
end




local randomaddress = {
"Strawberry, Los Santos",
"Grapeseed, Blaine County",
"Paleto Bay, Blaine County",
"Sandy Shores, Blaine County",
"Harmony, Blaine County",
"Vinewood Hills, Los Santos",
"Pillbox Hill, Los Santos",
"Rockford Hills, Los Santos",
"Vespucci Beach, Los Santos",
"Little Seoul, Los Santos",
"Rancho, Los Santos",
"Davis, Los Santos",
"South Los Santos",
"Elysian Island, Los Santos",
"El Burro Heights, Los Santos",
"Cypress Flats, Los Santos",
"Vinewood, Los Santos",
"Little Seoul, Los Santos",
"West Vinewood, Los Santos",
"Morningwood, Los Santos",
"Burton, Los Santos",
"Hawick, Los Santos",
"La Mesa, Los Santos",
"Vespucci, Los Santos",
"Downtown Vinewood, Los Santos",
"Alta, Los Santos",
"Del Perro Beach, Los Santos",
"Vespucci Canals, Los Santos",
"Textile City, Los Santos",
"Grand Senora Desert, Blaine County",
"Mount Chiliad, Blaine County",
"Mount Chiliad Wilderness, Blaine County",
"Banham Canyon, Blaine County",
}


-- Civ Transactions
function displayCivilian()
    enqueueEvent("req_civ", {getHandle()}, {getHandle(), 'civ_display'})
end
function displayVeh()
    enqueueEvent("req_veh", {getHandle()}, {getHandle(), 'veh_display'})
end
function createCivilian()
    exitAllMenus()
	SendNUIMessage({endexit = true})
	pentingkeyboardinput = true
    local nameNotSplit = KeyboardInput("Name", "", 30)
	pentingkeyboardinput = false
    if nameNotSplit == nil then
        turnOnCivMenu()
		
        return
    end
	pentingkeyboardinput = true
    local name = stringsplit(nameNotSplit, ' ')
	pentingkeyboardinput = false
    if tablelength(name) < 2 then
        drawNotification("You must have a first name and a last name")
        turnOnCivMenu()
        return
    end
	pentingkeyboardinput = true
	local sex = KeyboardInput("SEX? M or F or U", "", 1)
	pentingkeyboardinput = false
    if sex == nil then
		drawNotification("You must have a sex")
        turnOnCivMenu()
        return
    end
	
	if sex == "M" or sex == "m" or sex == "f" or sex == "F" or sex == "u" or sex == "U"  then

	else
		sex = "M"
    end
	pentingkeyboardinput = true
	local age = tonumber(KeyboardInput("Age? (Leave blank for random)", "", 2))
	pentingkeyboardinput = false
	local dob = "2018-01-01"
   if age then

		if tonumber(age) > 15 then
			local day = math.random(1,28)
			local month = math.random (1,12)
			local year = tonumber(2018) - tonumber(age)
			dob = year .. "-" .. month .. "-" .. day
		else
			local day = math.random(1,28)
			local month = math.random (1,12)
			local year = tonumber(2018) - tonumber(age)
			dob = year .. "-" .. month .. "-" .. day	
		end
	else
        age = math.random(17,55)
		local day = math.random(1,28)
		local month = math.random (1,12)
		local year = 2018 - age
		dob = year .. "-" .. month .. "-" .. day
		
    end
   
   
	pentingkeyboardinput = true
	local suburb = KeyboardInput("Address? (Leave blank for random)", "", 40)
	pentingkeyboardinput = false
    if suburb == nil or trim12(suburb) == '' then
        local rd = math.random(0,33)
		Citizen.Trace('rd num ' .. tostring(rd))
		suburb = randomaddress[rd]
    end
	
	Citizen.Trace('sex ' .. sex)
	Citizen.Trace('address ' .. suburb)
	Citizen.Trace('dob ' .. dob)
	
    TriggerServerEvent('ca53d25e-b0d7-4ce5-b7ad-a52054c01b73', name[1], name[2], sex, suburb, dob)
	resetMenu()
    turnOnCivMenu()
end

function rollwindows()

   local playerPed = GetPlayerPed(-1)
   local playerVeh = GetVehiclePedIsIn(playerPed, false)
   if ( IsPedSittingInAnyVehicle( playerPed ) ) then
	   if IsVehicleWindowIntact(playerVeh,0) then
			RollDownWindow(playerVeh, 0)
			RollDownWindow(playerVeh, 1)
	   else
			RollUpWindow(playerVeh, 0)
			RollUpWindow(playerVeh, 1)
	   end
   end
end


function duressBtn()
    SendNUIMessage({endexit = true})
	local lastStreetA = 0
    local lastStreetB = 0
    local lastStreetName = {}
	
		local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }

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
		
    TriggerServerEvent('ba4b56ea-4a0d-4ae6-8b3c-335268470d67', getHandle(),zones[GetNameOfZone(playerPos.x, playerPos.y, playerPos.z)],table.concat( street, " & " ))
	
	local phoneNumber = 'police'
	local playerPed   = GetPlayerPed(-1)
	local coords      = GetEntityCoords(playerPed)

	  if tonumber(phoneNumber) ~= nil then
		phoneNumber = tonumber(phoneNumber)
	  end

	  TriggerServerEvent('476baedb-3990-4c66-ac36-81a27a3d3e9a', phoneNumber, 'Duress Button Pressed', false, {
		x = coords.x,
		y = coords.y,
		z = coords.z
	  })
	
end


function changeStatus(type)
	SendNUIMessage({endexit = true})
	local lastStreetA = 0
    local lastStreetB = 0
    local lastStreetName = {}
	
		local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }

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

	print('settings 3')
    if type == "onduty" then
        TriggerServerEvent('ffcba091-dc70-4e8e-a8b8-86c5e9d1e7da', getHandle(),zones[GetNameOfZone(playerPos.x, playerPos.y, playerPos.z)],table.concat( street, " & " ))
	elseif type == "responding" then
        TriggerServerEvent('f5da16f6-e0b9-4163-9c3b-255714b5a154', getHandle(),zones[GetNameOfZone(playerPos.x, playerPos.y, playerPos.z)],table.concat( street, " & " ))
	elseif type == "onscene" then
        TriggerServerEvent('7ec4ba43-ae70-47ee-991f-8377e14341cd', getHandle(),zones[GetNameOfZone(playerPos.x, playerPos.y, playerPos.z)],table.concat( street, " & " ))
    elseif type == "offduty" then
        TriggerServerEvent('9e346cb7-9583-4f50-9d3f-85440b313883', getHandle(),zones[GetNameOfZone(playerPos.x, playerPos.y, playerPos.z)],table.concat( street, " & " ))
    elseif type == "busy" then
        TriggerServerEvent('0ef52747-ebb6-46ff-89ed-5a4909d747b0', getHandle(),zones[GetNameOfZone(playerPos.x, playerPos.y, playerPos.z)],table.concat( street, " & " ))
		
	elseif type == "traffics" then
        TriggerServerEvent('1da52dd3-d387-4e82-92a1-c1a12ec328c6', getHandle(),zones[GetNameOfZone(playerPos.x, playerPos.y, playerPos.z)],table.concat( street, " & " ))
		
    end
	SendNUIMessage({endexit = true})
	exitAllMenus()
	SetNuiFocus(false)
end

--used

function toggleWarrant()
    enqueueEvent("civ_toggle_warrant", {getHandle()})
end
function civCitations()
    exitAllMenus()
    local amount = tonumber(KeyboardInput("Citation Count", "", 3))
    if amount == nil then
        turnOnLastMenu()
        drawNotification("You must have a valid number")
        return
    end
    enqueueEvent("civ_set_citations", {getHandle(), amount})
    turnOnLastMenu()
end
function init911() 
    enqueueEvent("civ_911_init", {getHandle()})
end
function msg911()
    exitAllMenus()
    local msg = KeyboardInput("Text", "", 100)
    if msg == nil then
        turnOnLastMenu()
        drawNotification("Invalid message")
        return
    end
    enqueueEvent("civ_911_msg", {getHandle(), msg})
    turnOnLastMenu()
end
function end911()
    enqueueEvent("civ_911_end", {getHandle()})
end
function createCivVehicle()
    exitAllMenus()
    local plate = KeyboardInput("Plate", "", 8)
    if plate == nil then
        turnOnLastMenu()
        return
    end
    enqueueEvent("veh_create", {getHandle(), plate})
    turnOnLastMenu()
end
function toggleVehStolen()
    enqueueEvent("veh_toggle_stolen", {getHandle()})
end
function toggleVehRegi()
    enqueueEvent("veh_toggle_regi", {getHandle()})
end
function toggleVehInsured()
    enqueueEvent("veh_toggle_insurance", {getHandle()})
end


-- Leo Transactions
function createOfficer()

    exitAllMenus()
	pentingkeyboardinput = true

    local callsign = KeyboardInput("Officer Callsign", "", 9)

	pentingkeyboardinput = false
    if callsign == nil then
        turnOnLastMenu()
        return 
    end
    TriggerServerEvent('eaef9884-fa58-4ebd-a26d-3118de0840c0', callsign)
	
	--enqueueEvent("leo_create", {getHandle(), callsign})
    turnOnLastMenu()
end

function createOfficer1()

    exitAllMenus()
	pentingkeyboardinput = true
    vhtype = KeyboardInput("Please input s or v in box below (sedan or van)", "", 9)
	pentingkeyboardinput = false
    if vhtype == nil then
        turnOnLastMenu()
        return 
    end
	
	pentingkeyboardinput = true
    prefix = KeyboardInput("Call Sign Prefix: eg MEL or MTT", "", 9)
	pentingkeyboardinput = false
    if prefix == nil then
        turnOnLastMenu()
        return 
    end

    TriggerServerEvent('eaef9884-fa58-4ebd-a26d-3118de0840c0', " ", vhtype,prefix.." ")
	
	--enqueueEvent("leo_create", {getHandle(), callsign})
    turnOnLastMenu()
end
function displayStatus()
    enqueueEvent("leo_display_status", {getHandle()})
end

function isKeyboardOpen()
	return pentingkeyboardinput
end
exports("isKeyboardOpen", isKeyboardOpen)

function leoNcic()
    exitAllMenus()
    local nameNotSplit = KeyboardInput("Name", "", 50)
    if nameNotSplit == nil then
        turnOnLastMenu()
        drawNotification("Invalid name")
        return
    end
    local name = stringsplit(nameNotSplit, " ")
    enqueueEvent("req_civ_by_name", {name[1], name[2]}, {getHandle(), 'leo_get_civ'})
    turnOnLastMenu()
end
function leoNcicNotes()
    exitAllMenus()
    local nameNotSplit = KeyboardInput("Name", "", 50)
    if nameNotSplit == nil then
        turnOnLastMenu()
        drawNotification("Invalid name")
        return
    end
    local name = stringsplit(nameNotSplit, " ")
    enqueueEvent("req_civ_by_name", {name[1], name[2]}, {getHandle(), 'leo_display_civ_notes'})
    turnOnLastMenu()
end
function leoNcicTickets()
    exitAllMenus()
    local nameNotSplit = KeyboardInput("Name", "", 50)
    if nameNotSplit == nil then
        turnOnLastMenu()
        drawNotification("Invalid name")
        return
    end
    local name = stringsplit(nameNotSplit, " ")
    enqueueEvent("req_civ_by_name", {name[1], name[2]}, {getHandle(), 'leo_display_civ_tickets'})
    turnOnLastMenu()
end
function leoPlate()
    exitAllMenus()
    local plate = KeyboardInput("Plate", "", 8)
    if plate == nil then
        turnOnLastMenu()
        return 
    end
    enqueueEvent("req_veh_by_plate", {plate}, {getHandle(), 'leo_get_civ_veh'})
    turnOnLastMenu()
end
function leoAddNote()
    exitAllMenus()
    local nameNotSplit = KeyboardInput("Name", "", 50)
    if nameNotSplit == nil then
        turnOnLastMenu()
        drawNotification("Invalid name")
        return
    end
    local name = stringsplit(nameNotSplit, " ")
    local note = KeyboardInput("Note Text", "", 150)
    if note == nil then
        turnOnLastMenu()
        return
    end
    enqueueEvent("leo_add_civ_note", {getHandle(), name[1], name[2], note})
    turnOnLastMenu()
end
function leoAddTicket()
    exitAllMenus()
    local nameNotSplit = KeyboardInput("Name", "", 50)
    if nameNotSplit == nil then
        turnOnLastMenu()
        drawNotification("Invalid name")
        return
    end
    local name = stringsplit(nameNotSplit, " ")
    local amount = tonumber(KeyboardInput("Amount", "", 7))
    if amount == nil then
        turnOnLastMenu()
        drawNotification("You must have a valid number")
        return
    end
    if amount > 9999.99 then
        turnOnLastMenu()
        drawNotification("Your amount must be below 9999.99")
        return
    end
    local reason = KeyboardInput("Reason", "", 150)
    if reason == nil then
        turnOnLastMenu()
        return
    end
    enqueueEvent("leo_add_civ_ticket", {getHandle(), name[1], name[2], reason, amount})
    turnOnLastMenu()
end
function leoAddBolo()
    exitAllMenus()
    local reason = KeyboardInput("BOLO Reason", "", 250)
    if reason == nil then
        turnOnLastMenu()
        return
    end
    enqueueEvent("leo_bolo_add", {getHandle(), reason})
    turnOnLastMenu()
end
function leoViewBolos()
    enqueueEvent("req_bolos", {}, {getHandle(), 'leo_bolo_view'})
end

function givekeystopass()

	print("at start")
	  local playerVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
	  local myped = GetPlayerPed(-1)
	  if playerVeh == nil then
		
		drawNotification("You must be in the car to give the keys!")
		return
	  elseif playerVeh == 0 then
		drawNotification("You must be in the car to give the keys!")
		return
	  end
	  print("ped detected")
	  local pedindrive = GetPedInVehicleSeat(playerVeh, -1)
	  local pedinseat = GetPedInVehicleSeat(playerVeh, 0)
	  local pedinseat1 = GetPedInVehicleSeat(playerVeh, 1)
	  local pedinseat2 = GetPedInVehicleSeat(playerVeh, 2)
	  
	   print (tostring(pedinseat))
	   print (tostring(pedinseat1))
	   print (tostring(pedinseat2))
	   
	   local pedv = pedinseat --passenger
	   local pedd = pedindrive --driver
	   local playerid = -1
	   local playerid2 = -1
	   local players = GetPlayers()
			for index,value in ipairs(players) do
				local target = GetPlayerPed(value)
				if(target == pedv) then
					playerid = value
				end
				if(target == pedd) then
					playerid2 = value
				end
			end
			--Im in driver, give to passenger
		if myped == pedindrive then
		   if pedinseat ~= nil and pedinseat ~= -1 then
				
				local pid =  GetPlayerServerId(playerid)
				print("Got Player ID: " .. tostring(pid))
				print(GetVehicleNumberPlateText(playerVeh,false))
				TriggerServerEvent('ea4821e2-6f84-4f3e-833d-b59b20a9548b',pid, GetVehicleNumberPlateText(playerVeh,false))
		   else
				drawNotification("No one in passenger seat to give keys to!")
		   end
		else
			if pedindrive ~= nil and pedindrive ~= -1 then
				
				local pid =  GetPlayerServerId(playerid2)
				print("Got Player ID: " .. tostring(pid))
				print(GetVehicleNumberPlateText(playerVeh,false))
				TriggerServerEvent('ea4821e2-6f84-4f3e-833d-b59b20a9548b',pid, GetVehicleNumberPlateText(playerVeh,false))
		   else
				drawNotification("No one in driver seat to give keys to!")
		   end
		end
	end

--[[                                 END OF TRANSACTIONS                                 ]]




RegisterNetEvent('959a1cac-7921-405c-af27-b39d88d24e60')
AddEventHandler('959a1cac-7921-405c-af27-b39d88d24e60', function(strdata)
	--moderatedaccesslevelds = Status
	--TriggerEvent('07da2d3f-8b0d-405f-b039-8e894adda985','~w~' .. strdata)
	--sendMessage("!!!! I just received data, {255,255,0},"") 
	Citizen.Trace('RECEIVED refreshcad')
	SendNUIMessage({cadthistory = true, data = {strdata}})
end)

RegisterNetEvent('67b5713d-1586-4a17-8c2f-3b9197b48232')
AddEventHandler('67b5713d-1586-4a17-8c2f-3b9197b48232', function(strdata)
	--moderatedaccesslevelds = Status
	--TriggerEvent('07da2d3f-8b0d-405f-b039-8e894adda985','~w~' .. strdata)
	--sendMessage("!!!! I just received data, {255,255,0},"") 
	SendNUIMessage({namecheck = true, data = {strdata}})
end)


RegisterNetEvent('ff68caeb-bd0d-43d5-8ff7-b90f970bd614')
AddEventHandler('ff68caeb-bd0d-43d5-8ff7-b90f970bd614', function(strdata)
	--moderatedaccesslevelds = Status
	--TriggerEvent('07da2d3f-8b0d-405f-b039-8e894adda985','~w~' .. strdata)
	--sendMessage("!!!! I just received data, {255,255,0},"") 
	SendNUIMessage({carcheck = true, data = {strdata}})
end)

RegisterNetEvent('9e66919b-d340-4f9f-b42f-1560be377de1')
AddEventHandler('9e66919b-d340-4f9f-b42f-1560be377de1', function(strdata)
	--moderatedaccesslevelds = Status
	--TriggerEvent('07da2d3f-8b0d-405f-b039-8e894adda985','~w~' .. strdata)
	--sendMessage("!!!! I just received data, {255,255,0},"") 
	SendNUIMessage({pinhistory = true, data = {strdata}})
end)

RegisterNetEvent('ba4fa8a7-5127-4c7d-a391-12fcc0335713')
AddEventHandler('ba4fa8a7-5127-4c7d-a391-12fcc0335713', function(strdata)
	--moderatedaccesslevelds = Status
	--TriggerEvent('07da2d3f-8b0d-405f-b039-8e894adda985','~w~' .. strdata)
	--sendMessage("!!!! I just received data, {255,255,0},"") 
	SendNUIMessage({crimhistory = true, data = {strdata}})
end)

RegisterNetEvent('0cb6af5c-c93d-4e83-b51a-2b1c9bc42708')
AddEventHandler('0cb6af5c-c93d-4e83-b51a-2b1c9bc42708', function(strdata)
	--moderatedaccesslevelds = Status
	--TriggerEvent('07da2d3f-8b0d-405f-b039-8e894adda985','~w~' .. strdata)
	--sendMessage("!!!! I just received data, {255,255,0},"") 
	SendNUIMessage({supers = true, data = {strdata}})
end)


RegisterNetEvent('73fa29b9-1323-4e30-84b8-7e1b0b8a4008')
AddEventHandler('73fa29b9-1323-4e30-84b8-7e1b0b8a4008', function(strdata)
	--moderatedaccesslevelds = Status
	--TriggerEvent('07da2d3f-8b0d-405f-b039-8e894adda985','~w~' .. strdata)
	--sendMessage("!!!! I just received data, {255,255,0},"") 
	SendNUIMessage({sheriffsob = true, data = {strdata}})
end)



RegisterNetEvent('ead8a0e2-3d56-4219-9e09-d2dca39371f9')
AddEventHandler('ead8a0e2-3d56-4219-9e09-d2dca39371f9', function(strdata)
	print('logged in here')
	nswloggedInCallSign = strdata
	nswloggedInCops = true
	TriggerServerEvent('es:setJobDuty',tostring(GetPlayerServerId(PlayerId())), true)
	TriggerEvent('33b38819-e3bb-42aa-91d2-1a1f89b865c1')
	
	GiveWeaponComponentToPed(GetPlayerPed(-1), GetHashKey("weapon_combatpistol"), GetHashKey("component_at_pi_flsh"))
	SetEntityHealth(GetPlayerPed(-1),GetPedMaxHealth(GetPlayerPed(-1)))
	SetPlayerMaxArmour(PlayerId(), 200)
	SetPedArmour(GetPlayerPed(-1),100)
	SetPedArmour(GetPlayerPed(-1),200)
	SetPedAsCop(GetPlayerPed(-1),true)
	
end)

RegisterNetEvent('b2eefb99-82f1-4d56-bece-8760679886c4')
AddEventHandler('b2eefb99-82f1-4d56-bece-8760679886c4', function()
	print('logged out here')
	nswloggedInCallSign = ""
	nswloggedInCops = false
	TriggerServerEvent('es:setJobDuty',tostring(GetPlayerServerId(PlayerId())), false)
	TriggerEvent('33b38819-e3bb-42aa-91d2-1a1f89b865c1')
	SetPedAsCop(GetPlayerPed(-1),false)
end)




RegisterNetEvent('a0a02758-2634-443c-b87b-c6397308516c')
AddEventHandler('a0a02758-2634-443c-b87b-c6397308516c', function(grade)
 --turnOnCivMenu()
--displayNotification('Button Press Detected POLICE ID
	if grade > 49 and grade < 52 then
		SendNUIMessage({showsheriffid = true})
		TriggerEvent('07da2d3f-8b0d-405f-b039-8e894adda985','~b~Sheriff ID\n~w~You have just been shown ~b~Sheriff Officer ~w~identification.')
		Citizen.CreateThread( function()
			Wait(3500)
			SendNUIMessage({hidesheriffid = true})
		end)
	elseif grade > 14 and grade < 19 then
		SendNUIMessage({showfpoliceid = true})
		TriggerEvent('07da2d3f-8b0d-405f-b039-8e894adda985','~b~Police ID\n~w~You have just been shown ~b~Police ~w~identification.')
		Citizen.CreateThread( function()
			Wait(3500)
			SendNUIMessage({hidefpoliceid = true})
		end)
	elseif grade < -1 then
		SendNUIMessage({showpsopoliceid = true})
		TriggerEvent('07da2d3f-8b0d-405f-b039-8e894adda985','~b~Police PSO ID\n~w~You have just been shown ~b~Protective Services Officer ~w~identification.')
		Citizen.CreateThread( function()
			Wait(3500)
			SendNUIMessage({hidepsopoliceid = true})
		end)
	elseif grade < 15 then
		SendNUIMessage({showpoliceid = true})
		TriggerEvent('07da2d3f-8b0d-405f-b039-8e894adda985','~b~Police ID\n~w~You have just been shown ~b~Police ~w~identification.')
		Citizen.CreateThread( function()
			Wait(3500)
			SendNUIMessage({hidepoliceid = true})
		end)
	end
	

end)


--TriggerServerEvent('9800ab3e-c062-4bf5-9033-8baeeb8cd0aa',source, 'drunk')

--end)

function toggleAlcoholRefuse()
    TriggerServerEvent("dispatchsystem:toggleAlcoholREFUSE", getHandle())
end

function performNewProxBreathTest(player)
	print('reached newproxy breath')
	local closePlayer
	local closeDistance
	closePlayer, closeDistance = GetClosestPlayer()
	if player ~= nil then
		closePlayer = player
		closeDistance = 1
	end
	print('server id prox')
	print(GetPlayerServerId(closePlayer))

	SendNUIMessage({endexit = true})
    TriggerServerEvent('db0ecf65-a24f-44c4-8be7-78b672d63764', getHandle(), tostring(GetPlayerServerId(closePlayer)), closeDistance)
end


function performNewBreathTest(player)
	local closePlayer
	local closeDistance
	closePlayer, closeDistance = GetClosestPlayer()
	if player ~= nil then
		closePlayer = player
		closeDistance = 1
	end


    TriggerServerEvent('70d152c4-ba2d-4d55-b22e-335b4c5700d9', getHandle(), GetPlayerServerId(closePlayer), closeDistance)
end

function performNewDrugTest(player)
	local closePlayer
	local closeDistance
	closePlayer, closeDistance = GetClosestPlayer()
	if player ~= nil then
		closePlayer = player
		closeDistance = 1
	end
	print(closePlayer)

	exitAllMenus()
	
    TriggerServerEvent('2a142335-fa95-4309-bbc5-ec31cf235022', getHandle(), GetPlayerServerId(closePlayer), closeDistance)
end

function drugTest(provideSample,canibas,methamp)
	exitAllMenus()
	SendNUIMessage({endexit = true})
	TriggerServerEvent('e12f7938-bf04-4767-a875-1c0f057e33d2', getHandle(), testingHandleID, canibas, methamp, provideSample)
end



function countToFive(provideSample)
	if provideSample == true then
	
		exitAllMenus()
		local reason = KeyboardInput("ALOCHOL ON BREATH? Y OR N", "", 1)
		if reason == nil then
			drawNotification("You must provide a Y or N.")
			turnOnLastMenu()
			return
		end
		if reason == "y" or reason == "n" or reason == "Y" or reason == "N" then
			SendNUIMessage({endexit = true})
			TriggerServerEvent('55f3b313-03e6-4143-ab03-63f8990c0dde', getHandle(), testingHandleID, reason)
			
		else
			drawNotification("You must provide a Y or N.")
			turnOnLastMenu()
			return
		end
	else
			SendNUIMessage({endexit = true})
			TriggerServerEvent('55f3b313-03e6-4143-ab03-63f8990c0dde', getHandle(), testingHandleID, "refuse")
	end
end

function breathTestStraw(provideSample)
	if provideSample == true then
	
		exitAllMenus()
		drawNotification("You ~y~must~w~ enter a reading for what you blow roadside")
		Wait(200)
		drawNotification("~g~Enter ~w~your reading in the box displayed")
		Wait(300)
		local amount = tonumber(KeyboardInput("Alcohol Reading Format: 0.000", "", 5))
		if amount == nil then
			turnOnLastMenu()
			drawNotification("You must have a valid number")
			return
		end
		if amount > 0.5 then
			turnOnLastMenu()
			drawNotification("Realistic please, largest number can be 0.500")
			return
		end
		SendNUIMessage({endexit = true})
		TriggerServerEvent('954d4e0b-d1be-4b66-a05a-b73cbc1f0f0b', getHandle(), testingHandleID, amount,false)
		
	else
		SendNUIMessage({endexit = true})
		TriggerServerEvent('954d4e0b-d1be-4b66-a05a-b73cbc1f0f0b', getHandle(), testingHandleID, 0,true)
	end
end

