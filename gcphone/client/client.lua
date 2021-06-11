--====================================================================================
-- #Author: Jonathan D @ Gannon
--====================================================================================
 
-- Configuration
local KeyToucheCloseEvent = {
  { code = 172, event = 'ArrowUp' },
  { code = 173, event = 'ArrowDown' },
  { code = 174, event = 'ArrowLeft' },
  { code = 175, event = 'ArrowRight' },
  { code = 176, event = 'Enter' },
  { code = 177, event = 'Backspace' },
}

local menuIsOpen = false
local contacts = {}
local messages = {}
local myPhoneNumber = ''
local isDead = false
local USE_RTC = false
local useMouse = false
local ignoreFocus = false
local takePhoto = false
local hasFocus = false
local TokoVoipID = nil

local PhoneInCall = {}
local currentPlaySound = false
local soundDistanceMax = 13.0

delayPhoneAccess = false


--====================================================================================
--  Check si le joueurs poséde un téléphone
--  Callback true or false
--====================================================================================

--====================================================================================
--  Que faire si le joueurs veut ouvrir sont téléphone n'est qu'il en a pas ?
--====================================================================================
function ShowNoPhoneWarning ()
end

--[[
  Ouverture du téphone lié a un item
  Un solution ESC basé sur la solution donnée par HalCroves
  https://forum.fivem.net/t/tutorial-for-gcphone-with-call-and-job-message-other/177904
]]--

ESX = nil

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
        if ESX == nil then
            TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
            Citizen.Wait(200)
        end
    end
end)
--[[
function hasPhone (cb)
  if (ESX == nil) then return cb(0) end
  ESX.TriggerServerCallback('f9d9e609-2563-495b-808b-b549ec404d6b', function(qtty)
    cb(qtty > 0)
  end, 'phone')
end
function ShowNoPhoneWarning () 
  if (ESX == nil) then return end
  ESX.ShowNotification("Vous n'avez pas de ~r~téléphone~s~")
end --]] 

AddEventHandler('2df4c490-68a8-4c7e-896a-9fc552e16210', function()
  if menuIsOpen then
    menuIsOpen = false
    TriggerEvent('b272f457-261c-49dc-a8d4-671dbbd4cd56', false)
    SendNUIMessage({show = false})
    PhonePlayOut()
    SetBigmapActive(0,0)
  end
end)

AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function()
  TriggerServerEvent('60f908f0-db50-4899-8f57-df39f82b60f8')
end)

function hasPhone (cb)
  if (ESX == nil) then return cb(0) end
	local ph = GetInventoryItem('mobile_phone')
  
	if ph.count > 0 then
		cb(true)
	else
		cb(false)
	end
 
end

function GetInventoryItem(name)
  local inventory = ESX.GetPlayerData().inventory
  for i=1, #inventory, 1 do
    if inventory[i].name == name then
      return inventory[i]
    end
  end
  return nil
end
--====================================================================================
--  
--====================================================================================

function isPhoneCurrentlyOpen()
	return menuIsOpen
end

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
    if not menuIsOpen and isDead then
      DisableControlAction(0, 288, true)
    end
    if takePhoto ~= true then
      if IsControlJustPressed(1, Config.KeyOpenClose) then
		if not exports.esx_policejob:amicuffed() then
			if delayPhoneAccess == false then
				hasPhone(function (hasPhone)
				  if hasPhone == true then
					TooglePhone()
				  else
					ShowNoPhoneWarning()
				  end
				end)
			else
				ESX.ShowNotification("Finish reading ~y~Yellow Pages~w~ advertisements first")
			end
		end
      end
      if menuIsOpen == true then
        for _, value in ipairs(KeyToucheCloseEvent) do
          if IsControlJustPressed(1, value.code) then
            SendNUIMessage({keyUp = value.event})
          end
        end
        if useMouse == true and hasFocus == ignoreFocus then
          local nuiFocus = not hasFocus
          SetNuiFocus(nuiFocus, nuiFocus)
          hasFocus = nuiFocus
        elseif useMouse == false and hasFocus == true then
          SetNuiFocus(false, false)
          hasFocus = false
        end
      else
        if hasFocus == true then
          SetNuiFocus(false, false)
          hasFocus = false
        end
      end
    end
  end
end)




--====================================================================================
--  Active ou Deactive une application (appName => config.json)
--====================================================================================
RegisterNetEvent('d7f0adbd-6be6-425d-b3b5-41448b21e157')
AddEventHandler('d7f0adbd-6be6-425d-b3b5-41448b21e157', function(appName, enable)
  SendNUIMessage({event = 'setEnableApp', appName = appName, enable = enable })
end)

--====================================================================================
--  Gestion des appels fixe
--====================================================================================
function startFixeCall (fixeNumber)
  local number = ''
  DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 10)
  while (UpdateOnscreenKeyboard() == 0) do
    DisableAllControlActions(0);
    Wait(0);
  end
  if (GetOnscreenKeyboardResult()) then
    number =  GetOnscreenKeyboardResult()
  end
  if number ~= '' then
    TriggerEvent('7ec31eff-3d61-44e9-84d8-e9fdd9f4e91e', number, {
      useNumber = fixeNumber
    })
    PhonePlayCall(true)
  end
end

function TakeAppel (infoCall)
  TriggerEvent('d834e6aa-163a-499b-a1c8-6c378b380a0a', infoCall)
end

RegisterNetEvent('f90fb4e1-d87e-4030-9287-de2e68f3a6d1')
AddEventHandler('f90fb4e1-d87e-4030-9287-de2e68f3a6d1', function(_PhoneInCall)
  PhoneInCall = _PhoneInCall
end)

--[[
  Affiche les imformations quant le joueurs est proche d'un fixe
--]]
function showFixePhoneHelper (coords)
  local znearPhone = false
  for number, data in pairs(FixePhone) do
    local dist = #(vector3(data.coords.x, data.coords.y, data.coords.z) - vector3(coords.x, coords.y, coords.z))
    if dist <= 2.5 then
	  znearPhone = true
      SetTextComponentFormat("STRING")
      AddTextComponentString(_U('use_fixed', data.name, number))
      DisplayHelpTextFromStringLabel(0, 0, 0, -1)
      if IsControlJustPressed(1, Config.KeyTakeCall) then
        startFixeCall(number)
      end
      break
    end
  end
  if znearPhone == false then
	Wait(1000)
  end
end

RegisterNetEvent('302182ca-530c-4714-b224-5d08f9ee9ca5')
AddEventHandler('302182ca-530c-4714-b224-5d08f9ee9ca5', function(phone_number, data)
 FixePhone[phone_number] = data
end)

local registeredPhones = {}

--[[
Citizen.CreateThread(function()
  if not Config.AutoFindFixePhones then return end
  while not ESX do Citizen.Wait(0) end
  while true do
    local playerPed = GetPlayerPed(-1)
    local coords = GetEntityCoords(playerPed)
    for _, key in pairs({'p_phonebox_01b_s', 'p_phonebox_02_s', 'prop_phonebox_01a', 'prop_phonebox_01b', 'prop_phonebox_01c', 'prop_phonebox_02', 'prop_phonebox_03', 'prop_phonebox_04'}) do
      local closestPhone = GetClosestObjectOfType(coords.x, coords.y, coords.z, 25.0, key, false)
      if closestPhone ~= 0 and not registeredPhones[closestPhone] then
        local phoneCoords = GetEntityCoords(closestPhone)
        number = ('0%.2s-%.2s%.2s'):format(math.abs(phoneCoords.x*100), math.abs(phoneCoords.y * 100), math.abs(phoneCoords.z *100))
        if not Config.FixePhone[number] then
          TriggerServerEvent('e1c2267f-17dc-4774-98b0-9ffb865a2e7c', number, phoneCoords)
        end
        registeredPhones[closestPhone] = true
      end
    end
    Citizen.Wait(1000)
  end
end)--]]

RegisterNetEvent('f3f3aca7-fd3e-4a59-bcf2-e49d730b8965')
AddEventHandler('f3f3aca7-fd3e-4a59-bcf2-e49d730b8965', function(action)
	bypassfixe = false
	if action then
		bypassnumbers = {}
		for number, data in pairs(FixePhone) do
			if data.job ~= nil then
			
				if PlayerData.job == data.job then
					table.insert(bypassnumbers,number)
				end
			
			end
		end
		
	else
		bypassnumbers = {}
	end
end)

Citizen.CreateThread(function ()
  local mod = 0
  local sleep = 0
  while true do 
  
 -- pcall(function()
    local playerPed   = PlayerPedId()
    local coords      = GetEntityCoords(playerPed)
    local inRangeToActivePhone = false
    local inRangedist = 0

	
	local blue = false
	
    for i, _ in pairs(PhoneInCall) do 
        local dist =  #(vector3(PhoneInCall[i].coords.x, PhoneInCall[i].coords.y, PhoneInCall[i].coords.z) - vector3(coords.x, coords.y, coords.z))

		 local dist2 = nil
		if PhoneInCall[i].coords2 ~= nil then
			dist2 = #(vector3(
          PhoneInCall[i].coords2.x, PhoneInCall[i].coords2.y, PhoneInCall[i].coords2.z) -
          vector3(coords.x, coords.y, coords.z))
		end
		
        if (dist <= soundDistanceMax) then
			if PhoneInCall[i].type == "E" then
				if cccount < 10 then
					cccount = cccount + 1
						DrawMarker(1, PhoneInCall[i].coords.x, PhoneInCall[i].coords.y, PhoneInCall[i].coords.z,
						 0,0,0, 0,0,0, 0.1,0.1,0.1, 0,0,255,255, 0,0,0,0,0,0,0)
				elseif cccount < 20 then
					cccount = cccount + 1
						DrawMarker(1, PhoneInCall[i].coords.x, PhoneInCall[i].coords.y, PhoneInCall[i].coords.z,
					 0,0,0, 0,0,0, 0.1,0.1,0.1, 255,0,0,255, 0,0,0,0,0,0,0)
				else
					cccount = 0
			    end
			elseif PhoneInCall[i].type == "C" then
				  DrawMarker(1, PhoneInCall[i].coords.x, PhoneInCall[i].coords.y, PhoneInCall[i].coords.z,
              0,0,0, 0,0,0, 0.1,0.1,0.1, 255,255,0,255, 0,0,0,0,0,0,0)
			else
				  DrawMarker(1, PhoneInCall[i].coords.x, PhoneInCall[i].coords.y, PhoneInCall[i].coords.z,
              0,0,0, 0,0,0, 0.1,0.1,0.1, 0,255,0,255, 0,0,0,0,0,0,0)
			end
          inRangeToActivePhone = true
          inRangedist = dist
          if (dist <= 1.5) then 
            SetTextComponentFormat("STRING")
            AddTextComponentString("~INPUT_PICKUP~ to Pickup")
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)
            if IsControlJustPressed(1, Config.KeyTakeCall) then
              PhonePlayCall(true)
              TakeAppel(PhoneInCall[i])
              PhoneInCall = {}
              StopSoundJS('ring2.ogg')
            end
          end
          break
        end
		
		if dist2 ~= nil then
		if (dist2 <= soundDistanceMax) then
			if PhoneInCall[i].type == "E" then
				if cccount < 10 then
					cccount = cccount + 1
						DrawMarker(1, PhoneInCall[i].coords2.x, PhoneInCall[i].coords2.y, PhoneInCall[i].coords2.z,
						 0,0,0, 0,0,0, 0.1,0.1,0.1, 0,0,255,255, 0,0,0,0,0,0,0)
				elseif cccount < 20 then
					cccount = cccount + 1
						DrawMarker(1, PhoneInCall[i].coords2.x, PhoneInCall[i].coords2.y, PhoneInCall[i].coords2.z,
					 0,0,0, 0,0,0, 0.1,0.1,0.1, 255,0,0,255, 0,0,0,0,0,0,0)
				else
					cccount = 0
			    end
			elseif PhoneInCall[i].type == "C" then
				  DrawMarker(1, PhoneInCall[i].coords2.x, PhoneInCall[i].coords2.y, PhoneInCall[i].coords2.z,
              0,0,0, 0,0,0, 0.1,0.1,0.1, 255,255,0,255, 0,0,0,0,0,0,0)
			else
				  DrawMarker(1, PhoneInCall[i].coords2.x, PhoneInCall[i].coords2.y, PhoneInCall[i].coords2.z,
              0,0,0, 0,0,0, 0.1,0.1,0.1, 0,255,0,255, 0,0,0,0,0,0,0)
			end
     
          inRangeToActivePhone = true
          inRangedist = dist2
          if (dist2 <= 1.5) then 
            SetTextComponentFormat("STRING")
            AddTextComponentString("~INPUT_PICKUP~ to Pickup")
            DisplayHelpTextFromStringLabel(0, 0, 1, -1)
				
            if IsControlJustPressed(1, Config.KeyTakeCall) then
				 print('accept call')
              PhonePlayCall(true)
              TakeAppel(PhoneInCall[i])
              PhoneInCall = {}
              StopSoundJS('ring2.ogg')
            end
          end
          break
        end
	    end
		--print('running loops')
		if bypassfixe == nil then
			bypassfixe = false
		end
		if bypassfixe then
			
			for number, data in pairs(FixePhone) do
			
			
				for cc, bpnumber in pairs(bypassnumbers) do
					if PhoneInCall[i].receiver_num == bpnumber then

						
						inRangeToActivePhone = true
						if PhoneInCall[i] ~= nil then
							if PhoneInCall[i].type == "E" then
								if cccount < 10 then
									cccount = cccount + 1
										DrawMarker(1, coords.x + 0.5, coords.y+0.5, coords.z,
										 0,0,0, 0,0,0, 0.1,0.1,0.1, 0,0,255,255, 0,0,0,0,0,0,0)
								elseif cccount < 20 then
									cccount = cccount + 1
										DrawMarker(1, coords.x + 0.5 , coords.y + 0.5, coords.z,
									 0,0,0, 0,0,0, 0.1,0.1,0.1, 255,0,0,255, 0,0,0,0,0,0,0)
								else
									cccount = 0
								end
							elseif PhoneInCall[i].type == "C" then
								  DrawMarker(1, coords.x + 0.5, coords.y + 0.5, coords.z,
							  0,0,0, 0,0,0, 0.1,0.1,0.1, 255,255,0,255, 0,0,0,0,0,0,0)
							else
								  DrawMarker(1, coords.x + 0.5 , coords.y + 0.5, coords.z,
							  0,0,0, 0,0,0, 0.1,0.1,0.1, 0,255,0,255, 0,0,0,0,0,0,0)
							end
							SetTextComponentFormat("STRING")
							AddTextComponentString("~INPUT_PICKUP~ to Pickup")
							DisplayHelpTextFromStringLabel(0, 0, 1, -1)
							if IsControlJustPressed(1, Config.KeyTakeCall) then
							  print('accept call')
							  PhonePlayCall(false)
							  TakeAppel(PhoneInCall[i])
							  PhoneInCall = {}
							  StopSoundJS('ring2.ogg')
							  
							end
						end
					end
				end
			end
		end
		
    end
	if inRangeToActivePhone == false then
		showFixePhoneHelper(coords)
	end
    if inRangeToActivePhone == true and currentPlaySound == false then
      PlaySoundJS('ring2.ogg', 0.04 + (inRangedist - soundDistanceMax) / -soundDistanceMax * 0.11 )
      currentPlaySound = true
    elseif inRangeToActivePhone == true then
      mod = mod + 1
      if (mod == 15) then
        mod = 0
        SetSoundVolumeJS('ring2.ogg', 0.04 + (inRangedist - soundDistanceMax) / -soundDistanceMax * 0.11 )
      end
    elseif inRangeToActivePhone == false and currentPlaySound == true then
      currentPlaySound = false
      StopSoundJS('ring2.ogg')
    end
--	end)
    Citizen.Wait(0)
  end
end)



RegisterCommand("mcalla", function(source, args, rawCommand)
  if args[1] == "start" then
		

		bypassnumbers = {}
		for number, data in pairs(FixePhone) do
		
			if data.job ~= nil then

				if ESX.GetPlayerData().job.name == data.job then

					local alreadyin = false
					for i, scan in pairs(bypassnumbers) do
						if scan == number then

							alreadyin = true
						end
					end
					if alreadyin == false then
						--print(number)
						table.insert(bypassnumbers,number)
					end
				end
			
			end
		end
		bypassfixe = true
	
  else
    bypassnumbers = {}
	bypassfixe = false
  end
end)


function PlaySoundJS (sound, volume)
  SendNUIMessage({ event = 'playSound', sound = sound, volume = volume })
end

function SetSoundVolumeJS (sound, volume)
  SendNUIMessage({ event = 'setSoundVolume', sound = sound, volume = volume})
end

function StopSoundJS (sound)
  SendNUIMessage({ event = 'stopSound', sound = sound})
end

RegisterCommand("phone", function()
  TooglePhone()
end)

RegisterNetEvent('0aba7d16-9261-4242-a1cd-a0e940b051cc')
AddEventHandler('0aba7d16-9261-4242-a1cd-a0e940b051cc', function(_myPhoneNumber)
  if menuIsOpen == false then
    if delayPhoneAccess == false then
		TooglePhone()
	else
		ESX.ShowNotification("Finish reading ~y~Yellow Pages~w~ advertisements first")
	end
  end
end)
 
--====================================================================================
--  Events
--====================================================================================
RegisterNetEvent('712b03c1-871d-4e51-bcf8-42ca1b5ac689')
AddEventHandler('712b03c1-871d-4e51-bcf8-42ca1b5ac689', function(_myPhoneNumber)
  myPhoneNumber = _myPhoneNumber
  SendNUIMessage({event = 'updateMyPhoneNumber', myPhoneNumber = myPhoneNumber})
end)

RegisterNetEvent('1434a1bb-bb78-4fe6-8dcd-bf4f347f3160')
AddEventHandler('1434a1bb-bb78-4fe6-8dcd-bf4f347f3160', function(_contacts)
  SendNUIMessage({event = 'updateContacts', contacts = _contacts})
  contacts = _contacts
end)

RegisterNetEvent('5b984b08-54c4-482e-8c9b-326151f98c43')
AddEventHandler('5b984b08-54c4-482e-8c9b-326151f98c43', function(allmessages)
  SendNUIMessage({event = 'updateMessages', messages = allmessages})
  messages = allmessages
end)

RegisterNetEvent('d6fb8df6-85b9-449e-aa49-966ce53c01f0')
AddEventHandler('d6fb8df6-85b9-449e-aa49-966ce53c01f0', function(bourse)
  SendNUIMessage({event = 'updateBourse', bourse = bourse})
end)

RegisterNetEvent('d6af8c31-3a4d-4e56-971f-d35ad5a75305')
AddEventHandler('d6af8c31-3a4d-4e56-971f-d35ad5a75305', function(message,x,y)
  -- SendNUIMessage({event = 'updateMessages', messages = messages})

	
	for _,contact in pairs(contacts) do
		if 	string.match(string.lower(contact.display), 'block')  then
			if contact.number == message.transmitter then
				print('received from blocked number ' .. contact.number)
				return
			end
		end
	end
  SendNUIMessage({event = 'newMessage', message = message})
  table.insert(messages, message)
    if GetInventoryItem('mobile_phone').count   < 1 then
		return
	end
  
  if message.owner == 0 then
    local text = '~o~New message ' .. ' ~w~' .. message.message
	local caller = message.transmitter
    if Config.ShowNumberNotification == true then
      text = _U('new_message_from', message.transmitter)
      for _,contact in pairs(contacts) do
        if contact.number == message.transmitter then
          text = _U('new_message_transmitter', contact.display)
          break
        end
      end
    end
	
	if caller == 'mecano' then
		TriggerEvent('ae7a51c5-190c-4f66-9d3f-28ad9815553d', 'SMS ID: ' .. math.random(1,999), caller , message.message,'CHAR_FLOYD', 'tbt', 1)
	elseif caller == 'police' then
		TriggerEvent('ae7a51c5-190c-4f66-9d3f-28ad9815553d', 'SMS ID: ' .. math.random(1,999), caller , message.message,'CHAR_FLOYD', 'police', 1)
	elseif caller == 'ambulance' then
		TriggerEvent('ae7a51c5-190c-4f66-9d3f-28ad9815553d','SMS ID: ' ..  math.random(1,999), caller , message.message,'CHAR_FLOYD', 'av', 1)
    else	
		TriggerEvent('ae7a51c5-190c-4f66-9d3f-28ad9815553d','SMS ID: ' .. math.random(1,999), caller , message.message,'CHAR_FLOYD', 'sms', 1)
	end

	PlaySound(-1, "Menu_Accept", "Phone_SoundSet_Default", 0, 0, 1)
	Citizen.Wait(300)
	
	if x ~= nil and y ~= nil then

		specx = x
		specy = y
		--GPS ROUTING
		Citizen.CreateThread(function()
			local dx = specx
			local dy = specy
			local counterc = 0
		  while true do
	
			if dy ~= specy then
				return
			end
			counterc = counterc + 1
			
			if counterc > 600 then
				return
			end

			if dx ~= nil then

			  SetTextComponentFormat('STRING')
			  AddTextComponentString('Press ~INPUT_CONTEXT~ to set way point to job')
			  DisplayHelpTextFromStringLabel(0, 0, 1, -1)

				  if IsControlPressed(0,  38) then  --e
				
						SetNewWaypoint(dx,  dy)
						return
				
				  end

			end
			Citizen.Wait(0)
		  end
		end)
	end
  end
end)

--====================================================================================
--  Function client | Contacts
--====================================================================================
function addContact(display, num)
	if display ~= nil and string.len(display) > 0 and num ~= nil and string.len(num) > 0 then
		TriggerServerEvent('8fcdcb4c-a5b7-4ba5-ade3-e3fa2243becc', display, num)
	else
		ESX.ShowNotification("~r~Error\n~w~Unable to add that contact missing fields")
	end
end

function deleteContact(num) 
    TriggerServerEvent('a771e920-b3f0-417a-aaa4-b6a4d5e4535d', num)
end
--====================================================================================
--  Function client | Messages
--====================================================================================
function sendMessage(num, message)
  TriggerServerEvent('e17b40f2-3d80-4404-bfc8-26124acacf3d', num, message)
end

function deleteMessage(msgId)
  TriggerServerEvent('8f301cbe-1ab1-4697-95fe-68f755f50731', msgId)
  for k, v in ipairs(messages) do 
    if v.id == msgId then
      table.remove(messages, k)
      SendNUIMessage({event = 'updateMessages', messages = messages})
      return
    end
  end
end

function deleteMessageContact(num)
  TriggerServerEvent('89b8e6e9-2bf6-4d74-9452-3864c167c6f1', num)
end

function deleteAllMessage()
  TriggerServerEvent('fec7be01-877b-45a1-975c-27f91089aa1d')
end

function setReadMessageNumber(num)
  TriggerServerEvent('016334d6-ceac-4c1d-b1a7-cb5ff6092dbf', num)
  for k, v in ipairs(messages) do 
    if v.transmitter == num then
      v.isRead = 1
    end
  end
end

function requestAllMessages()
  TriggerServerEvent('gcPhone:requestAllMessages')
end

function requestAllContact()
  TriggerServerEvent('gcPhone:requestAllContact')
end



--====================================================================================
--  Function client | Appels
--====================================================================================
local aminCall = false
local inCall = false

RegisterNetEvent('55796696-70f5-4d4a-a810-5f7c6328f831')
AddEventHandler('55796696-70f5-4d4a-a810-5f7c6328f831', function(infoCall, initiator)


  	if GetInventoryItem('mobile_phone').count  < 1 or exports.esx_policejob:amicuffed() then
		return
	end
	for _,contact in pairs(contacts) do
		if string.find(string.lower(contact.display), 'block') then
			if contact.number == infoCall.transmitter_num then
				print('received from blocked number ' .. contact.number)
				return
			end
		end
	end
  SendNUIMessage({event = 'waitingCall', infoCall = infoCall, initiator = initiator})
  if initiator == true then
    PhonePlayCall()
    if menuIsOpen == false then
      TooglePhone()
    end
  end
end)

RegisterNetEvent('6f4da161-6dd0-42ff-bf55-5594c22664f3')
AddEventHandler('6f4da161-6dd0-42ff-bf55-5594c22664f3', function(infoCall, initiator)
  if inCall == false and USE_RTC == false then
    inCall = true
    if Config.UseMumbleVoIP then
      exports["mumble-voip"]:SetCallChannel(infoCall.id+1)
    elseif Config.UseTokoVoIP then
      exports.tokovoip_script:addPlayerToRadio(infoCall.id + 120)
      TokoVoipID = infoCall.id + 120
    else
      NetworkSetVoiceChannel(infoCall.id + 1)
      NetworkSetTalkerProximity(0.0)
    end
  end
  if menuIsOpen == false then 
    TooglePhone()
  end
  PhonePlayCall()
  SendNUIMessage({event = 'acceptCall', infoCall = infoCall, initiator = initiator})
end)

RegisterNetEvent('80a62aee-142a-481b-bdd5-da9a6f5114b4')
AddEventHandler('80a62aee-142a-481b-bdd5-da9a6f5114b4', function(infoCall)
  if inCall == true then
    inCall = false
    if Config.UseMumbleVoIP then
      exports["mumble-voip"]:SetCallChannel(0)
    elseif Config.UseTokoVoIP then
      exports.tokovoip_script:removePlayerFromRadio(TokoVoipID)
      TokoVoipID = nil
    else
      Citizen.InvokeNative(0xE036A705F989E049)
      NetworkSetTalkerProximity(2.5)
    end
  end
  PhonePlayText()
  SendNUIMessage({event = 'rejectCall', infoCall = infoCall})
end)


RegisterNetEvent('1a652b38-39cf-40a3-a814-f291df72f794')
AddEventHandler('1a652b38-39cf-40a3-a814-f291df72f794', function(historique)
  SendNUIMessage({event = 'historiqueCall', historique = historique})
end)


function startCall (phone_number, rtcOffer, extraData)
  if rtcOffer == nil then
    rtcOffer = ''
  end
  TriggerServerEvent('686fb09f-4f55-497c-9661-ce71b6169e0a', phone_number, rtcOffer, extraData)
end

function acceptCall (infoCall, rtcAnswer)
  TriggerServerEvent('d4c8fd98-6c87-4ef7-bbdb-4f743259781f', infoCall, rtcAnswer)
end

function rejectCall(infoCall)
  TriggerServerEvent('a56d02fe-0de6-42bd-9c01-03bc3490b7ee', infoCall)
end

function ignoreCall(infoCall)
  TriggerServerEvent('gcPhone:ignoreCall', infoCall)
end

function requestHistoriqueCall() 
  TriggerServerEvent('80722ed6-7a88-46b5-8487-b51e5269b1c8')
end

function appelsDeleteHistorique (num)
  TriggerServerEvent('82b80268-c4ba-4606-8c74-b1466e1552a0', num)
end

function appelsDeleteAllHistorique ()
  TriggerServerEvent('e37bae8b-b56f-4adf-9d23-2c87ad23133a')
end
  

--====================================================================================
--  Event NUI - Appels
--====================================================================================

RegisterNUICallback('startCall', function (data, cb)
  startCall(data.numero:gsub("-", ""), data.rtcOffer, data.extraData)
  cb()
end)

RegisterNUICallback('acceptCall', function (data, cb)
  acceptCall(data.infoCall, data.rtcAnswer)
  cb()
end)
RegisterNUICallback('rejectCall', function (data, cb)
  rejectCall(data.infoCall)
  cb()
end)

RegisterNUICallback('ignoreCall', function (data, cb)
  ignoreCall(data.infoCall)
  cb()
end)

RegisterNUICallback('notififyUseRTC', function (use, cb)
  USE_RTC = use
  if USE_RTC == true and inCall == true then
    inCall = false
    Citizen.InvokeNative(0xE036A705F989E049)
    if Config.UseTokoVoIP then
      exports.tokovoip_script:removePlayerFromRadio(TokoVoipID)
      TokoVoipID = nil
    else
      NetworkSetTalkerProximity(2.5)
    end
  end
  cb()
end)


RegisterNUICallback('onCandidates', function (data, cb)
  TriggerServerEvent('7f5e7bb3-5611-41fe-bc8b-a6014808d76c', data.id, data.candidates)
  cb()
end)

RegisterNetEvent('e1bf0eed-2843-49b6-9023-b576382672f2')
AddEventHandler('e1bf0eed-2843-49b6-9023-b576382672f2', function(candidates)
  SendNUIMessage({event = 'candidatesAvailable', candidates = candidates})
end)



RegisterNetEvent('7ec31eff-3d61-44e9-84d8-e9fdd9f4e91e')
AddEventHandler('7ec31eff-3d61-44e9-84d8-e9fdd9f4e91e', function(number, extraData)
  if number ~= nil then
    SendNUIMessage({ event = "autoStartCall", number = number, extraData = extraData})
  end
end)

RegisterNetEvent(  'gcphone:autoCallNumber')
AddEventHandler(  'gcphone:autoCallNumber', function(data)
  TriggerEvent('7ec31eff-3d61-44e9-84d8-e9fdd9f4e91e', data.number)
end)

RegisterNetEvent('d834e6aa-163a-499b-a1c8-6c378b380a0a')
AddEventHandler('d834e6aa-163a-499b-a1c8-6c378b380a0a', function(infoCall)
  SendNUIMessage({ event = "autoAcceptCall", infoCall = infoCall})
end)

--====================================================================================
--  Gestion des evenements NUI
--==================================================================================== 
RegisterNUICallback('log', function(data, cb)
  print(data)
  cb()
end)
RegisterNUICallback('focus', function(data, cb)
  cb()
end)
RegisterNUICallback('blur', function(data, cb)
  cb()
end)
RegisterNUICallback('reponseText', function(data, cb)
  local limit = data.limit or 255
  local text = data.text or ''
  
  DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", text, "", "", "", limit)
  while (UpdateOnscreenKeyboard() == 0) do
      DisableAllControlActions(0);
      Wait(0);
  end
  if (GetOnscreenKeyboardResult()) then
      text = GetOnscreenKeyboardResult()
  end
  cb(json.encode({text = text}))
end)
--====================================================================================
--  Event - Messages
--====================================================================================
RegisterNUICallback('getMessages', function(data, cb)
  cb(json.encode(messages))
end)
RegisterNUICallback('sendMessage', function(data, cb)
  if data.message == '%pos%' then
    local myPos = GetEntityCoords(PlayerPedId())
    data.message = 'GPS: ' .. myPos.x .. ', ' .. myPos.y
  end
  TriggerServerEvent('e17b40f2-3d80-4404-bfc8-26124acacf3d', data.phoneNumber, data.message)
end)
RegisterNUICallback('deleteMessage', function(data, cb)
  deleteMessage(data.id)
  cb()
end)
RegisterNUICallback('deleteMessageNumber', function (data, cb)
  deleteMessageContact(data.number)
  cb()
end)
RegisterNUICallback('deleteAllMessage', function (data, cb)
  deleteAllMessage()
  cb()
end)
RegisterNUICallback('setReadMessageNumber', function (data, cb)
  setReadMessageNumber(data.number)
  cb()
end)
--====================================================================================
--  Event - Contacts
--====================================================================================
RegisterNUICallback('addContact', function(data, cb)
	if data.display ~= nil and string.len(data.display) > 0 and data.phoneNumber ~= nil and string.len(data.phoneNumber) > 0 then
		TriggerServerEvent('8fcdcb4c-a5b7-4ba5-ade3-e3fa2243becc', data.display, data.phoneNumber)
	else
		ESX.ShowNotification("~r~Error\n~w~Unable to add that contact missing fields")
	end
 
end)
RegisterNUICallback('updateContact', function(data, cb)
  TriggerServerEvent('37cfe9e9-ee2a-4d9f-b6f9-751a4e0ba711', data.id, data.display, data.phoneNumber)
end)
RegisterNUICallback('deleteContact', function(data, cb)
  TriggerServerEvent('a771e920-b3f0-417a-aaa4-b6a4d5e4535d', data.id)
end)
RegisterNUICallback('getContacts', function(data, cb)
  cb(json.encode(contacts))
end)
RegisterNUICallback('setGPS', function(data, cb)
  SetNewWaypoint(tonumber(data.x), tonumber(data.y))
  cb()
end)

-- Add security for event (leuit#0100)
RegisterNUICallback('callEvent', function(data, cb)
  local eventName = data.eventName or ''
  if string.match(eventName, 'gcphone') then
    if data.data ~= nil then 
      TriggerEvent(data.eventName, data.data)
    else
      TriggerEvent(data.eventName)
    end
  else
    print('Event not allowed')
  end
  cb()
end)
RegisterNUICallback('useMouse', function(um, cb)
  useMouse = um
end)
RegisterNUICallback('deleteALL', function(data, cb)
  TriggerServerEvent('66deecd8-932d-4086-a595-bfb600f68eb2')
  cb()
end)

RegisterCommand("closephone", function(args)
	forceclose() 

end,false)

local lastusedfixphone = 0
RegisterCommand("fixphone", function(args)

	 if  GetGameTimer() - 5000 > lastusedfixphone then
		 lastusedfixphone = GetGameTimer()
		 SendNUIMessage({actionrefresh = true})
		 TriggerServerEvent('60f908f0-db50-4899-8f57-df39f82b60f8')
	 end
end,false)



function forceclose() 
 menuIsOpen = false
 SendNUIMessage({show = false})
 PhonePlayOut()
 TriggerEvent('b272f457-261c-49dc-a8d4-671dbbd4cd56', false)
end


function TooglePhone() 
  if IsPedRagdoll(PlayerPedId()) then
	return
  end
  menuIsOpen = not menuIsOpen
  SendNUIMessage({show = menuIsOpen})
  if menuIsOpen == true then 
    PhonePlayIn()
    TriggerEvent('b272f457-261c-49dc-a8d4-671dbbd4cd56', true)
    --SetBigmapActive(1,0)
  else
    PhonePlayOut()
    TriggerEvent('b272f457-261c-49dc-a8d4-671dbbd4cd56', false)
    --SetBigmapActive(0,0)
  end
end
RegisterNUICallback('faketakePhoto', function(data, cb)
  menuIsOpen = false
  TriggerEvent('b272f457-261c-49dc-a8d4-671dbbd4cd56', false)
  SendNUIMessage({show = false})
  cb()
  TriggerEvent('edf8083d-f666-45e6-a5de-2e80247a17a2')
end)

RegisterNUICallback('closePhone', function(data, cb)
  menuIsOpen = false
  TriggerEvent('b272f457-261c-49dc-a8d4-671dbbd4cd56', false)
  SendNUIMessage({show = false})
  PhonePlayOut()
  SetBigmapActive(0,0)
  SetNuiFocus(false, false)
  cb()
end)



----------------------------------
---------- GESTION APPEL ---------
----------------------------------
RegisterNUICallback('appelsDeleteHistorique', function (data, cb)
  appelsDeleteHistorique(data.numero)
  cb()
end)
RegisterNUICallback('appelsDeleteAllHistorique', function (data, cb)
  appelsDeleteAllHistorique(data.infoCall)
  cb()
end)


----------------------------------
---------- GESTION VIA WEBRTC ----
----------------------------------
AddEventHandler('onClientResourceStart', function(res)
  DoScreenFadeIn(300)
  if res == "gcphone" then
    TriggerServerEvent('60f908f0-db50-4899-8f57-df39f82b60f8')
    -- Try again in 2 minutes (Recovers bugged phone numbers)
    Citizen.Wait(120000)
    TriggerServerEvent('60f908f0-db50-4899-8f57-df39f82b60f8')
  end
end)


RegisterNUICallback('setIgnoreFocus', function (data, cb)
  ignoreFocus = data.ignoreFocus
  cb()
end)

RegisterNUICallback('takePhoto', function(data, cb)
  CreateMobilePhone(1)
  CellCamActivate(true, true)
  takePhoto = true
  Citizen.Wait(0)
  if hasFocus == true then
    SetNuiFocus(false, false)
    hasFocus = false
  end
  while takePhoto do
    Citizen.Wait(0)

    if IsControlJustPressed(1, 27) then -- Toogle Mode
      frontCam = not frontCam
      CellFrontCamActivate(frontCam)
    elseif IsControlJustPressed(1, 177) then -- CANCEL
      DestroyMobilePhone()
      CellCamActivate(false, false)
      cb(json.encode({ url = nil }))
      takePhoto = false
      break
    elseif IsControlJustPressed(1, 176) then -- TAKE.. PIC
		exports['screenshot-basic']:requestScreenshotUpload('https://nasfile.myds.me/up.php', 'files', function(data)
			DestroyMobilePhone()
			CellCamActivate(false, false)
			cb(json.encode({ url = data }))  
			 takePhoto = false
		end)

      takePhoto = false
    end
    HideHudComponentThisFrame(7)
    HideHudComponentThisFrame(8)
    HideHudComponentThisFrame(9)
    HideHudComponentThisFrame(6)
    HideHudComponentThisFrame(19)
    HideHudAndRadarThisFrame()
  end
  Citizen.Wait(1000)
  PhonePlayAnim('text', false, true)
end)

function isPhoneOpen()
	return menuIsOpen
end
exports("isPhoneOpen", isPhoneOpen)
