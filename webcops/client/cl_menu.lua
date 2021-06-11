--[[
    MENU stuff
]]
RegisterNetEvent('cbe437dd-cfce-4491-984b-b475cf1a66b3')
RegisterNetEvent('5ad0c096-c37d-4d48-b3e1-71ec3994aec5')
RegisterNetEvent('059f417e-ea5f-4c02-854c-a4fb7ae679c9')
RegisterNetEvent('405e22f3-adaa-4be5-9028-01fb0c662b0a')
RegisterNetEvent('c045ebfb-7ed1-4c78-bd1d-ba3863995286')




Citizen.CreateThread(function()

local firststart = true
  	while true do
		Citizen.Wait(10)
		if menu ~= nil then
		
			SetNuiFocus(false)
		end
		if firststart == true then
			SetNuiFocus(false)
			firststart = false
		end
		
		if IsControlJustPressed(1, 166) then --Start holding F5
			if menu == nil then
				turnOnCivMenu()
				TriggerServerEvent('a2d04cfc-c68c-4726-a28d-586c34a52dcf',"")
			else
				exitAllMenus()
			end
        end
		
	
		if menu ~= nil then
			
				
			      DisableControlAction(0, 1,    true) -- LookLeftRight
				  DisableControlAction(0, 2,    true) -- LookUpDown
				  DisableControlAction(0, 25,   true) -- Input Aim
				  DisableControlAction(0, 106,  true) -- Vehicle Mouse Control Override

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
				  SetNuiFocus(true, true)
		end
		
    end
end)

local menu = nil
function turnOnCivMenu()
	menu = "civ"
	SetNuiFocus(true, true)
	SendNUIMessage({showcivmenu = true})
end
function turnOnLeoMenu()
	menu = "leo"
	SetNuiFocus(true, true)
	SendNUIMessage({showleomenu = true})
end


function turnOnLastMenu()
    menu = "unknown"
    SetNuiFocus(true, true)
    SendNUIMessage({openlastmenu = true})
end
function exitAllMenus()
	print('exit all menus')
	menu = nil
	SetNuiFocus(false)
	SendNUIMessage({hidemenus = true})
end
function resetMenu()
    if menu == "civ" then
        SendNUIMessage({hidemenus = true})
        SendNUIMessage({showcivmenu = true})
    elseif menu == "leo" then
        SendNUIMessage({hidemenus = true})
        SendNUIMessage({showleomenu = true})
	elseif menu == "lic" then
        SendNUIMessage({hidemenus = true})
        SendNUIMessage({showlicmenu = true})
    end
end
function safeExit()
	print('safe exit')
    SetNuiFocus(false)
    menu = nil
end

-- Adding event handler at the end to use all of the above functions
AddEventHandler('5ad0c096-c37d-4d48-b3e1-71ec3994aec5', function()
	if menu == nil then
		turnOnCivMenu()
	else
		exitAllMenus()
	end
end)
AddEventHandler('cbe437dd-cfce-4491-984b-b475cf1a66b3', function()
	if menu == nil then
		turnOnLeoMenu()
	else
		exitAllMenus()
	end
end)
AddEventHandler('059f417e-ea5f-4c02-854c-a4fb7ae679c9', function()
    exitAllMenus()
end)
AddEventHandler('405e22f3-adaa-4be5-9028-01fb0c662b0a', function(civData, ofcData)

	print(civData[0])
	SendNUIMessage({pushback = true, data = {civData, ofcData}})
end)

AddEventHandler('c045ebfb-7ed1-4c78-bd1d-ba3863995286', function(licinfo)
	print('received displayLIC')
    SendNUIMessage({displayLIC = true, data = {licinfo}})
	SetNuiFocus(true,true)
end)


function turnOnBTProxM(cop)
	--TriggerServerEvent('a2d04cfc-c68c-4726-a28d-586c34a52dcf', getHandle())
	menu = "btproxm"
	SetNuiFocus(true, true)
	SendNUIMessage({showbtproxmenu = true, btcop = cop})
	if cop then
		SetNuiFocus(true, true)
	end
end

function turnOnBTM(cop)
	--TriggerServerEvent('a2d04cfc-c68c-4726-a28d-586c34a52dcf', getHandle())
	menu = "btstrawm"
	SetNuiFocus(true, true)
	SendNUIMessage({showbtmenu = true, btcop = cop})
	if cop then
		SetNuiFocus(true, true)
	end
end

function turnOnDTM(cop)
	--TriggerServerEvent('a2d04cfc-c68c-4726-a28d-586c34a52dcf', getHandle())
	menu = "dtsm"
	SetNuiFocus(true, true)
	SendNUIMessage({showdtmenu = true, btcop = cop})
	if cop then
		SetNuiFocus(true, true)
	end
end




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

RegisterNetEvent('3dbf1cb9-f3f6-49b4-aa74-e54a4496527a')
AddEventHandler('3dbf1cb9-f3f6-49b4-aa74-e54a4496527a', function(strdata)
	--moderatedaccesslevelds = Status
	--TriggerEvent('07da2d3f-8b0d-405f-b039-8e894adda985','~w~' .. strdata)
	--sendMessage("!!!! I just received data, {255,255,0},"") 
	SendNUIMessage({reporthistory = true, data = {strdata}})
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



--[[                                 END OF MENU STUFF                                 ]]
