--[[
	COMMON APPS
]]
function drawNotification(text)
    SetNotificationTextEntry("STRING")
    AddTextComponentString(text)
    DrawNotification(false, false)
end
function KeyboardInput(TextEntry, ExampleText, MaxStringLenght) -- ps thanks @Flatracer
    -- TextEntry		-->	The Text above the typing field in the black square
    -- ExampleText		-->	An Example Text, what it should say in the typing field
    -- MaxStringLenght	-->	Maximum String Lenght
    
    AddTextEntry('FMMC_KEY_TIP1', TextEntry .. ':') --Sets the Text above the typing field in the black square
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght) --Actually calls the Keyboard Input
    blockinput = true --Blocks new input while typing if **blockinput** is used
    
    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do --While typing is not aborted and not finished, this loop waits
        Citizen.Wait(0)
    end
            
    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult() --Gets the result of the typing
        Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
        blockinput = false --This unblocks new Input when typing is done
        return result --Returns the result
    else
        blockinput = false --This unblocks new Input when typing is done
        return nil --Returns nil if the typing got aborted
    end
end
function sendMessage(title, rgb, text)
	TriggerEvent('chatMessage', title, rgb, text)
end
function stringsplit(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t={} ; i=1
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
        t[i] = str
        i = i + 1
    end
    return t
end
function getHandle()
    return tostring(GetPlayerServerId(PlayerId()))
end
function tablelength(T)
    local count = 0
        for _ in pairs(T) do count = count + 1 end
    return count
end
function terminateMenu()
    Citizen.CreateThread(function()
        Citizen.Wait(500)
        turnOnCivMenu = nil
        turnOnLeoMenu = nil
        turnOnLastMenu = nil
        exitAllMenus = nil
        resetMenu = nil
        safeExit = nil
    end)
end

--[[                                 END OF COMMON                                 ]]

--[[
	INIT ITEMS
]]
Citizen.CreateThread(function()
    Citizen.Wait(500)
    local resource = GetCurrentResourceName()
    if (resource ~= string.lower(resource)) then
        terminateMenu()

        while true do
            if DoesEntityExist(PlayerPedId()) then
                drawNotification("DispatchSystem:~n~~r~PLEASE CHANGE RESOURCE NAME TO ALL LOWER")
            end
            Wait(10)
        end
        return
    end
   SendNUIMessage({setname = true, metadata = GetCurrentResourceName()}) -- Telling JS of the resource name
    --sendMessage("DispatchSystem", {0,0,0}, "DispatchSystem.Client by BlockBa5her loaded")    
end)


RegisterNetEvent('07da2d3f-8b0d-405f-b039-8e894adda985')
AddEventHandler('07da2d3f-8b0d-405f-b039-8e894adda985', function(message)
	--sendMessage("Police weapons, vest and appointments have been issued to you.", {30,144,255}, "") 
	
	
	displayNotification(message:match( "^%s*(.-)%s*$" ))
end)

function displayNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(true, false)
end

function drawNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(true, false)
end


function GetPlayers()
    local players = {}

	for i,player in ipairs(GetActivePlayers()) do
		table.insert(players, player)
	end

    return players
end


function ListofPlayersandDistancesSL()
	local players = GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local ply = GetPlayerPed(-1)
	local plyCoords = GetEntityCoords(ply, 0)
	
	local tusers = {}
	
	for index,value in ipairs(players) do
		local target = GetPlayerPed(value)
		
		--if(target ~= ply) then
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = Vdist(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"])
			if distance < 3.5 then
				table.insert(tusers,{serverid = GetPlayerServerId(value), d = distance})
			end

		--end
	end
	
	return tusers
end


function trim11(s)
   local n = s:find"%S"
   return n and s:match(".*%S", n) or ""
end

function trim12(s)
   local n = s:find"%S"
   return n and s:match(".*%S", n) or ""
end

function GetClosestPlayer()
	local players = GetPlayers()
	local closestDistance = 1000
	local closestPlayer = -1
	local ply = GetPlayerPed(-1)
	local plyCoords = GetEntityCoords(ply, 0)

	for index,value in ipairs(players) do
		local target = GetPlayerPed(value)
		if(target ~= ply) then
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = Vdist(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"])
			if(closestDistance ~= -1 and closestDistance > distance) then
				closestPlayer = value
				closestDistance = distance
			end
		end
	end

	return closestPlayer, closestDistance
end




local colorNames1 = {
    ['0'] = "Metallic Black",
    ['1'] = "Metallic Graphite Black",
    ['2'] = "Metallic Black Steal",
    ['3'] = "Metallic Dark Silver",
    ['4'] = "Metallic Silver",
    ['5'] = "Metallic Blue Silver",
    ['6'] = "Metallic Steel Gray",
    ['7'] = "Metallic Shadow Silver",
    ['8'] = "Metallic Stone Silver",
    ['9'] = "Metallic Midnight Silver",
    ['10'] = "Metallic Gun Metal",
    ['11'] = "Metallic Anthracite Grey",
    ['12'] = "Matte Black",
    ['13'] = "Matte Gray",
    ['14'] = "Matte Light Grey",
    ['15'] = "Util Black",
    ['16'] = "Util Black Poly",
    ['17'] = "Util Dark silver",
    ['18'] = "Util Silver",
    ['19'] = "Util Gun Metal",
    ['20'] = "Util Shadow Silver",
    ['21'] = "Worn Black",
    ['22'] = "Worn Graphite",
    ['23'] = "Worn Silver Grey",
    ['24'] = "Worn Silver",
    ['25'] = "Worn Blue Silver",
    ['26'] = "Worn Shadow Silver",
    ['27'] = "Metallic Red",
    ['28'] = "Metallic Torino Red",
    ['29'] = "Metallic Formula Red",
    ['30'] = "Metallic Blaze Red",
    ['31'] = "Metallic Graceful Red",
    ['32'] = "Metallic Garnet Red",
    ['33'] = "Metallic Desert Red",
    ['34'] = "Metallic Cabernet Red",
    ['35'] = "Metallic Candy Red",
    ['36'] = "Metallic Sunrise Orange",
    ['37'] = "Metallic Classic Gold",
    ['38'] = "Metallic Orange",
    ['39'] = "Matte Red",
    ['40'] = "Matte Dark Red",
    ['41'] = "Matte Orange",
    ['42'] = "Matte Yellow",
    ['43'] = "Util Red",
    ['44'] = "Util Bright Red",
    ['45'] = "Util Garnet Red",
    ['46'] = "Worn Red",
    ['47'] = "Worn Golden Red",
    ['48'] = "Worn Dark Red",
    ['49'] = "Metallic Dark Green",
    ['50'] = "Metallic Racing Green",
    ['51'] = "Metallic Sea Green",
    ['52'] = "Metallic Olive Green",
    ['53'] = "Metallic Green",
    ['54'] = "Metallic Gasoline Blue Green",
    ['55'] = "Matte Lime Green",
    ['56'] = "Util Dark Green",
    ['57'] = "Util Green",
    ['58'] = "Worn Dark Green",
    ['59'] = "Worn Green",
    ['60'] = "Worn Sea Wash",
    ['61'] = "Metallic Midnight Blue",
    ['62'] = "Metallic Dark Blue",
    ['63'] = "Metallic Saxony Blue",
    ['64'] = "Metallic Blue",
    ['65'] = "Metallic Mariner Blue",
    ['66'] = "Metallic Harbor Blue",
    ['67'] = "Metallic Diamond Blue",
    ['68'] = "Metallic Surf Blue",
    ['69'] = "Metallic Nautical Blue",
    ['70'] = "Metallic Bright Blue",
    ['71'] = "Metallic Purple Blue",
    ['72'] = "Metallic Spinnaker Blue",
    ['73'] = "Metallic Ultra Blue",
    ['74'] = "Metallic Bright Blue",
    ['75'] = "Util Dark Blue",
    ['76'] = "Util Midnight Blue",
    ['77'] = "Util Blue",
    ['78'] = "Util Sea Foam Blue",
    ['79'] = "Uil Lightning blue",
    ['80'] = "Util Maui Blue Poly",
    ['81'] = "Util Bright Blue",
    ['82'] = "Matte Dark Blue",
    ['83'] = "Matte Blue",
    ['84'] = "Matte Midnight Blue",
    ['85'] = "Worn Dark blue",
    ['86'] = "Worn Blue",
    ['87'] = "Worn Light blue",
    ['88'] = "Metallic Taxi Yellow",
    ['89'] = "Metallic Race Yellow",
    ['90'] = "Metallic Bronze",
    ['91'] = "Metallic Yellow Bird",
    ['92'] = "Metallic Lime",
    ['93'] = "Metallic Champagne",
    ['94'] = "Metallic Pueblo Beige",
    ['95'] = "Metallic Dark Ivory",
    ['96'] = "Metallic Choco Brown",
    ['97'] = "Metallic Golden Brown",
    ['98'] = "Metallic Light Brown",
    ['99'] = "Metallic Straw Beige",
    ['100'] = "Metallic Moss Brown",
    ['101'] = "Metallic Biston Brown",
    ['102'] = "Metallic Beechwood",
    ['103'] = "Metallic Dark Beechwood",
    ['104'] = "Metallic Choco Orange",
    ['105'] = "Metallic Beach Sand",
    ['106'] = "Metallic Sun Bleeched Sand",
    ['107'] = "Metallic Cream",
    ['108'] = "Util Brown",
    ['109'] = "Util Medium Brown",
    ['110'] = "Util Light Brown",
    ['111'] = "Metallic White",
    ['112'] = "Metallic Frost White",
    ['113'] = "Worn Honey Beige",
    ['114'] = "Worn Brown",
    ['115'] = "Worn Dark Brown",
    ['116'] = "Worn straw beige",
    ['117'] = "Brushed Steel",
    ['118'] = "Brushed Black steel",
    ['119'] = "Brushed Aluminium",
    ['120'] = "Chrome",
    ['121'] = "Worn Off White",
    ['122'] = "Util Off White",
    ['123'] = "Worn Orange",
    ['124'] = "Worn Light Orange",
    ['125'] = "Metallic Securicor Green",
    ['126'] = "Worn Taxi Yellow",
    ['127'] = "police car blue",
    ['128'] = "Matte Green",
    ['129'] = "Matte Brown",
    ['130'] = "Worn Orange",
    ['131'] = "Matte White",
    ['132'] = "Worn White",
    ['133'] = "Worn Olive Army Green",
    ['134'] = "Pure White",
    ['135'] = "Hot Pink",
    ['136'] = "Salmon pink",
    ['137'] = "Metallic Vermillion Pink",
    ['138'] = "Orange",
    ['139'] = "Green",
    ['140'] = "Blue",
    ['141'] = "Mettalic Black Blue",
    ['142'] = "Metallic Black Purple",
    ['143'] = "Metallic Black Red",
    ['144'] = "hunter green",
    ['145'] = "Metallic Purple",
    ['146'] = "Metaillic V Dark Blue",
    ['147'] = "MODSHOP BLACK1",
    ['148'] = "Matte Purple",
    ['149'] = "Matte Dark Purple",
    ['150'] = "Metallic Lava Red",
    ['151'] = "Matte Forest Green",
    ['152'] = "Matte Olive Drab",
    ['153'] = "Matte Desert Brown",
    ['154'] = "Matte Desert Tan",
    ['155'] = "Matte Foilage Green",
    ['156'] = "DEFAULT ALLOY COLOR",
    ['157'] = "Epsilon Blue",
}



local colorNames = {
    ['0'] = "Black",
    ['1'] = "Black",
    ['2'] = "Black",
    ['3'] = "Grey",
    ['4'] = "Silver",
    ['5'] = "Silver",
    ['6'] = "Silver",
    ['7'] = "Grey",
    ['8'] = "Silver",
    ['9'] = "Grey",
    ['10'] = "Grey",
    ['11'] = "Grey",
    ['12'] = "Black",
    ['13'] = "Gray",
    ['14'] = "Grey",
    ['15'] = "Black",
    ['16'] = "Black",
    ['17'] = "Grey",
    ['18'] = "Silver",
    ['19'] = "Grey",
    ['20'] = "Grey",
    ['21'] = "Black",
    ['22'] = "Grey",
    ['23'] = "Silver",
    ['24'] = "Silver",
    ['25'] = "Silver",
    ['26'] = "Silver",
    ['27'] = "Red",
    ['28'] = "Red",
    ['29'] = "Red",
    ['30'] = "Red",
    ['31'] = "Red",
    ['32'] = "Red",
    ['33'] = "Red",
    ['34'] = "Red",
    ['35'] = "Red",
    ['36'] = "Orange",
    ['37'] = "Yellow",
    ['38'] = "Orange",
    ['39'] = "Red",
    ['40'] = "Red",
    ['41'] = "Orange",
    ['42'] = "Yellow",
    ['43'] = "Red",
    ['44'] = "Red",
    ['45'] = "Red",
    ['46'] = "Red",
    ['47'] = "Red",
    ['48'] = "Red",
    ['49'] = "Green",
    ['50'] = "Green",
    ['51'] = "Green",
    ['52'] = "Green",
    ['53'] = "Green",
    ['54'] = "Green",
    ['55'] = "Green",
    ['56'] = "Green",
    ['57'] = "Green",
    ['58'] = "Green",
    ['59'] = "Green",
    ['60'] = "Green",
    ['61'] = "Blue",
    ['62'] = "Blue",
    ['63'] = "Blue",
    ['64'] = "Blue",
    ['65'] = "Blue",
    ['66'] = "Blue",
    ['67'] = "Blue",
    ['68'] = "Blue",
    ['69'] = "Blue",
    ['70'] = "Blue",
    ['71'] = "Purple",
    ['72'] = "Purple",
    ['73'] = "Blue",
    ['74'] = "Blue",
    ['75'] = "Blue",
    ['76'] = "Blue",
    ['77'] = "Blue",
    ['78'] = "Blue",
    ['79'] = "Blue",
    ['80'] = "Blue",
    ['81'] = "Blue",
    ['82'] = "Blue",
    ['83'] = "Blue",
    ['84'] = "Blue",
    ['85'] = "Blue",
    ['86'] = "Blue",
    ['87'] = "Blue",
    ['88'] = "Yellow",
    ['89'] = "Yellow",
    ['90'] = "Brown",
    ['91'] = "Yellow",
    ['92'] = "Green",
    ['93'] = "Brown",
    ['94'] = "Brown",
    ['95'] = "Brown",
    ['96'] = "Brown",
    ['97'] = "Brown",
    ['98'] = "Brown",
    ['99'] = "Brown",
    ['100'] = "Brown",
    ['101'] = "Brown",
    ['102'] = "Brown",
    ['103'] = "Brown",
    ['104'] = "Brown",
    ['105'] = "Yellow",
    ['106'] = "Yellow",
    ['107'] = "White",
    ['108'] = "Brown",
    ['109'] = "Brown",
    ['110'] = "Brown",
    ['111'] = "White",
    ['112'] = "White",
    ['113'] = "Yellow",
    ['114'] = "Brown",
    ['115'] = "Brown",
    ['116'] = "Yellow",
    ['117'] = "Silver",
    ['118'] = "Black",
    ['119'] = "Silver",
    ['120'] = "Chrome",
    ['121'] = "White",
    ['122'] = "White",
    ['123'] = "Orange",
    ['124'] = "Orange",
    ['125'] = "Green",
    ['126'] = "Yellow",
    ['127'] = "Blue",
    ['128'] = "Green",
    ['129'] = "Brown",
    ['130'] = "Orange",
    ['131'] = "White",
    ['132'] = "White",
    ['133'] = "Green",
    ['134'] = "White",
    ['135'] = "Pink",
    ['136'] = "Pink",
    ['137'] = "Pink",
    ['138'] = "Orange",
    ['139'] = "Green",
    ['140'] = "Blue",
    ['141'] = "Blue",
    ['142'] = "Purple",
    ['143'] = "Red",
    ['144'] = "Green",
    ['145'] = "Purple",
    ['146'] = "Blue",
    ['147'] = "Black",
    ['148'] = "Purple",
    ['149'] = "Purple",
    ['150'] = "Red",
    ['151'] = "Green",
    ['152'] = "Green",
    ['153'] = "Brown",
    ['154'] = "Brown",
    ['155'] = "Green",
    ['156'] = "Silver",
    ['157'] = "Blue",
}
function cGetVehicleColours(cvehicle)
	if GetIsVehiclePrimaryColourCustom(cvehicle) then  
		return "Custom","Custom"
	elseif GetIsVehicleSecondaryColourCustom(cvehicle) then
		local primary, secondary = cGetVehicleColours(cvehicle)
		primary = colorNames[tostring(primary)]
		--Citizen.Trace('Primary Color Reg: ' .. primary)
		return primary, "Custom"
		
	else
	
		local primary, secondary = GetVehicleColours(cvehicle)
		if primary == nil then
			primary = "unknown"
			secondary = "unknown"
		elseif secondary == nil then
			primary = colorNames[tostring(primary)]
			secondary = nil
		else
			primary = colorNames[tostring(primary)]
			secondary = colorNames[tostring(secondary)]
		end
		--Citizen.Trace('Primary Color Reg: ' .. primary)
		return primary, secondary
	end

end

--[[                                 END OF INIT                                 ]]






RegisterNetEvent('1fdfa6e2-24d1-41af-bee3-5d23148edc81')

AddEventHandler('1fdfa6e2-24d1-41af-bee3-5d23148edc81', function(playerid)


		local localPlayerId = PlayerId()
		local serverId = GetPlayerServerId(localPlayerId)
		Wait(100)
		
		local reason = KeyboardInput('Reason for Ban? (Shown on rejoin only)', '', 100)
		if string.len(reason) < 3 then
			TriggerEvent('07da2d3f-8b0d-405f-b039-8e894adda985',"~r~Ban reason\n~y~You must provide a reason to ban!")
			return
		end
		local timet = KeyboardInput('Days for Ban? eg: 1,7,14,30  (Leave Blank for Perm)', '', 2)
		if timet == nil or tonumber(timet) == 0 then
			TriggerServerEvent('aa4f68f2-a2c7-467e-9092-47cf80c43e8d', playerid, 'warn', serverId,reason, "null")
		else
			TriggerServerEvent('aa4f68f2-a2c7-467e-9092-47cf80c43e8d', playerid, 'warn' ,serverId,reason, tonumber(timet))
		end

end)

AddEventHandler('192f8377-c1a7-4ad1-acbb-53278e50a186', function(playerid)


		local localPlayerId = PlayerId()
		local serverId = GetPlayerServerId(localPlayerId)
		Wait(100)
		
		local reason = KeyboardInput('Reason for Kick', '', 100)
		if string.len(reason) < 3 then
			TriggerEvent('07da2d3f-8b0d-405f-b039-8e894adda985',"~r~Kick Reason\n~y~You must provide a reason to Kick!")
			return
		end
		
		TriggerServerEvent('e4be9628-2429-4dc1-90ed-be96afe8dece', playerid, 'kick', serverId,reason)


end)

AddEventHandler('d55659e3-cba0-46ed-b40e-cb1546e4fad5', function(playerid)

		local localPlayerId = PlayerId()
		local serverId = GetPlayerServerId(localPlayerId)
		Wait(100)
		
		local reason = KeyboardInput('Reason for Warning?', '', 100)
		if string.len(reason) < 3 then
			TriggerEvent('07da2d3f-8b0d-405f-b039-8e894adda985',"~r~Warning Reason\n~y~You must provide a reason to warn!")
			return
		end
		TriggerServerEvent('426aedbf-d936-46c9-9f26-ec9ad5f1512c', playerid, 'warn', serverId,reason)
end)

RegisterNetEvent('fd9e9ee1-7b2a-4abd-9c11-551168d5ca98')

AddEventHandler('fd9e9ee1-7b2a-4abd-9c11-551168d5ca98', function(playerid)

		local localPlayerId = PlayerId()
		local serverId = GetPlayerServerId(localPlayerId)
		Wait(100)
		
		local reason = KeyboardInput('Reason for Verbal?', '', 100)
		if string.len(reason) < 3 then
			TriggerEvent('07da2d3f-8b0d-405f-b039-8e894adda985',"~r~Warning Reason\n~y~You must provide a reason to record verbal discussion!")
			return
		end
		TriggerServerEvent('47c6b724-d3c0-4803-aa37-edf811f6fb8a', playerid, 'verbal', serverId,reason)
end)

---ES ADMIN