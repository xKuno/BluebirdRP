local messages = {}
local offset = 0.125
local chat = false -- if you want messages to be duplicated in chat
local messagesColor = {37, 175, 134, 255} --{164, 98, 193, 215} -- r,g,b,a
local signColor = {54,136,173, 255} 

local myserverid = GetPlayerServerId(PlayerId())

RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(xPlayer)
	myserverid = GetPlayerServerId(PlayerId())

end)
TriggerEvent('2896af73-6240-4f26-92b0-417518db3f5a', "/snl", "Sign Language above head")
TriggerEvent('2896af73-6240-4f26-92b0-417518db3f5a', "/mev", "Above Head Instructions to Fix Voice")
TriggerEvent('2896af73-6240-4f26-92b0-417518db3f5a', "/meh", "Above Head Help Instructions")

local function DrawText3D(x ,y, z, text, color)
	local r,g,b,a = {255, 255, 255, 215}
	if color then
		r,g,b,a = table.unpack(color)
	end
  local onScreen, _x, _y = World3dToScreen2d(x, y, z)
  local p = GetGameplayCamCoords()
  local distance = GetDistanceBetweenCoords(p.x, p.y, p.z, x, y, z, 1)
  local scale = (1 / distance) * 2
  local fov = (1 / GetGameplayCamFov()) * 100
  local scale = scale * fov
  if onScreen then
		SetTextScale(0.6, 0.6)
		SetTextFont(4)
		SetTextProportional(1)
		SetTextColour(r, g, b, a)
		SetTextEntry("STRING")
		SetTextCentre(1)
		AddTextComponentString(text)
		DrawText(_x,_y)
		-- local factor = (string.len(text)) / 370
		-- DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
    end
end


local function AddMessage(type, msg, color, owner, timeout)
	if not messages[owner] then
		messages[owner] = {}
	end

	table.insert(messages[owner], {
		type = type,
		msg = msg,
		color = color
	})
	SetTimeout(timeout, function()
		table.remove(messages[owner], 1)
		if #messages[owner] == 0 then
			messages[owner] = nil
		end
	end)
end

Citizen.CreateThread(function()
	while true do
		local count = 0
		for k,v in pairs(messages) do
			for i,d in pairs(messages[k]) do
				local x,y,z = table.unpack(GetEntityCoords(k))
				z = z + 0.9 + offset*i
				DrawText3D(x, y, z, d.type..' | '..d.msg, d.color)
			end
			count = count + 1
		end
		if count == 0 then
			Wait(500)
		end
		Wait(0)
	end
end)


RegisterNetEvent('0079782b-16df-4a1f-a681-408d8f190ad6')
AddEventHandler('0079782b-16df-4a1f-a681-408d8f190ad6', function(id, name, message)

	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)

	if sonid == monid then
		ExecuteCommand('e pullover')
		if chat then
			TriggerEvent('chatMessage', "", {255, 0, 0}, " ^6 sign lang | " .. name .."  ".."^6  " .. message )
		end
		if myserverid == id then
			AddMessage('sign lang', message, signColor, PlayerPedId(), 15000)
		end
	elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(GetPlayerPed(sonid)), true) < 7.01 and HasEntityClearLosToEntity(PlayerPedId(), GetPlayerPed(sonid), 17) == 1 then
	
		local playedfordisplay = GetPlayerPed(sonid)
		local myplayerped = GetPlayerPed(-1)
		if chat then
			TriggerEvent('chatMessage', "", {255, 0, 0}, " ^6 sign lang | " .. name .."  ".."^6  " .. message )
		end
		if playedfordisplay == myplayerped and id == myserverid then
			ExecuteCommand('e pullover')
			AddMessage('sign lang', message, signColor, playedfordisplay, 15000)
		elseif id ~= myserverid and playedfordisplay ~= myplayerped then
			AddMessage('sign lang', message, signColor, playedfordisplay, 15000)
		end
	end
end)

RegisterNetEvent('51ec7015-8980-4437-8ef3-7f2fc1c88bd1')
AddEventHandler('51ec7015-8980-4437-8ef3-7f2fc1c88bd1', function(id, name, message)
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)

	if sonid == monid then
		if chat then
			TriggerEvent('chatMessage', "", {255, 0, 0}, " ^6 me | " .. name .."  ".."^6  " .. message )
		end
		if myserverid == id then
			AddMessage('me', message, messagesColor, PlayerPedId(), 12000)
		end
	elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(GetPlayerPed(sonid)), true) < 7.01 and HasEntityClearLosToEntity(PlayerPedId(), GetPlayerPed(sonid), 17) == 1 then
	
		local playedfordisplay = GetPlayerPed(sonid)
		local myplayerped = GetPlayerPed(-1)
		if chat then
			TriggerEvent('chatMessage', "", {255, 0, 0}, " ^6 me | " .. name .."  ".."^6  " .. message )
		end
		if playedfordisplay == myplayerped and id == myserverid then
			AddMessage('me', message, messagesColor, playedfordisplay, 12000)
		elseif id ~= myserverid and playedfordisplay ~= myplayerped then
			AddMessage('me', message, messagesColor, playedfordisplay, 12000)
		end
	end
end)

RegisterNetEvent('c58129d4-b4b5-41d5-b8c9-7beb4489ed7b')
AddEventHandler('c58129d4-b4b5-41d5-b8c9-7beb4489ed7b', function(id, name,msgtype, colour, timet, message)

	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)

	if sonid == monid then

		if myserverid == id then
			AddMessage(msgtype, message, colour, PlayerPedId(), 12000)
		end
	elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(GetPlayerPed(sonid)), true) < 7.01 and HasEntityClearLosToEntity(PlayerPedId(), GetPlayerPed(sonid), 17) == 1 then
	
		local playedfordisplay = GetPlayerPed(sonid)
		local myplayerped = GetPlayerPed(-1)

		if playedfordisplay == myplayerped and id == myserverid then
			AddMessage(msgtype, message, messagesColor, playedfordisplay, 12000)
		elseif id ~= myserverid and playedfordisplay ~= myplayerped then
			AddMessage(msgtype, message, messagesColor, playedfordisplay, 12000)
		end
	end

end)


RegisterNetEvent('8f7ed074-8207-4077-8305-ed283b8cd148')
AddEventHandler('8f7ed074-8207-4077-8305-ed283b8cd148', function(id, name, message)
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)
	if sonid == monid then
		if myserverid == id then
			AddMessage('char', message, {255,255,51,200}, PlayerPedId(), 12000)
		end
	elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(GetPlayerPed(sonid)), true) < 7.01 and HasEntityClearLosToEntity(PlayerPedId(), GetPlayerPed(sonid), 17) == 1 then
		if playedfordisplay == myplayerped and id == myserverid then
			AddMessage('char', message, {255,255,51,200}, GetPlayerPed(sonid), 12000)
		elseif id ~= myserverid and playedfordisplay ~= myplayerped then
			AddMessage('char', message, {255,255,51,200}, GetPlayerPed(sonid), 12000)
		end
	end
end)




RegisterNetEvent('735dcb96-9703-4b9e-a87e-891536b71f2a')
AddEventHandler('735dcb96-9703-4b9e-a87e-891536b71f2a', function(id, name, message)
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)

	if sonid == monid then
		if chat then
			TriggerEvent('chatMessage', "", {255, 0, 0}, " ^6 do | " .. message .."  ".."^6 ((" .. name .. "))")
		end
		if myserverid == id then
			AddMessage('do', message, {253, 88, 0, 255}, PlayerPedId(), 12000)
		end
	elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(GetPlayerPed(sonid)), true) < 7.01 and HasEntityClearLosToEntity(PlayerPedId(), GetPlayerPed(sonid), 17) == 1 then
	
		local playedfordisplay = GetPlayerPed(sonid)
		local myplayerped = GetPlayerPed(-1)
		if chat then
			TriggerEvent('chatMessage', "", {253, 88, 0, 255}, " ^6 do | " .. message .."  ".."^6 ((" .. name .. "))")
		end
		if playedfordisplay == myplayerped and id == myserverid then
			AddMessage('do', message, messagesColor, playedfordisplay, 12000)
		elseif id ~= myserverid and playedfordisplay ~= myplayerped then
			AddMessage('do', message, {253, 88, 0, 255}, playedfordisplay, 12000)
		end
	end
end)

RegisterNetEvent('dcc9c56a-963f-4973-bb8d-65a76b9bb4b0')
AddEventHandler('dcc9c56a-963f-4973-bb8d-65a76b9bb4b0', function(id, name, message, result)
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)
	local resultMessages = {"^2Success", "^1Failure"}
	local resultMessage = resultMessages[result]
	if sonid == monid then
		if chat then
			TriggerEvent('chatMessage', "", {255, 0, 0}, " ^6 try | " .. name .."  ".."^6  " .. message .. " ((".. resultMessage .."^6))")
		end
		AddMessage('try', message.." (("..string.sub(resultMessage, 3).."))", messagesColor, PlayerPedId(), 10000)
	elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(GetPlayerPed(sonid)), true) < 7.01 and HasEntityClearLosToEntity(PlayerPedId(), GetPlayerPed(sonid), 17) == 1 then
		if chat then
			TriggerEvent('chatMessage', "", {255, 0, 0}, " ^6 try | " .. name .."  ".."^6  " .. message .. " ((".. resultMessage .."^6))")
		end
		AddMessage('try', message.." (("..string.sub(resultMessage, 3).."))", messagesColor, GetPlayerPed(sonid), 10000)
	end
end)

RegisterNetEvent('af28c5ca-4a84-48c1-bae4-774c349f385b')
AddEventHandler('af28c5ca-4a84-48c1-bae4-774c349f385b', function(id, name, message)
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)
	if sonid == monid then
		TriggerEvent('chatMessage', "", {255, 0, 0}, "^9 OOC | ^7" .. name ..": " .. message)
	elseif GetDistanceBetweenCoords(GetEntityCoords(PlayerPedId()), GetEntityCoords(GetPlayerPed(sonid)), true) < 7.01 and HasEntityClearLosToEntity(PlayerPedId(), GetPlayerPed(sonid), 17) == 1 then
		TriggerEvent('chatMessage', "", {255, 0, 0}, "^9 OOC | ^7" .. name ..": " .. message)
	end
end)



local maxDice = 2
local maxDiceSides = 6
local rollPrefix = "You rolled a .."
local rpsPrefix = "Rock Paper Scissors .. "

-- Animations
animDict = "mp_player_int_upperwank"
anim1 = "mp_player_int_wank_01_enter"
anim2 = "mp_player_int_wank_01_exit"

-- Display 3D Text with 3dme
function DisplayText(text)
	TriggerServerEvent("3dme:shareDisplay", text) -- Edit if using a 3dme alternative
end

-- Rock, Paper, Scissors
RegisterCommand("rps", function(source, args, command)
	local text = rpsPrefix
	local options = {"Rock!", "Paper!", "Scissors!"}
	local choice = ""
	if args[1] == "r" then
		choice = options[1]
	elseif args[1] == "p" then
		choice = options[2]
	elseif args[1] == "s" then
		choice = options[3]
	else
		return
	end
	text = text ..choice
	RequestAnimDict(animDict)
	TaskPlayAnim(PlayerPedId(-1), animDict, anim1, 8.0, -8, -1, 8, 0, 0, 0, 0)
	Citizen.Wait(700)
	TriggerServerEvent('755f814f-b094-43c2-ba50-12e7182745ce',text)
end)
TriggerEvent('2896af73-6240-4f26-92b0-417518db3f5a', "/rps", "Rock, Paper, Scissors", {
    { name="r/p/s", help="r=Rock, p=Paper or s=Scissors" },
})

-- Flip Coin
RegisterCommand("flip", function(source, args, command)
	local text = flipPrefix
	local options = {"Heads", "Tails"}
	text = text ..options[math.random(1, #options)]
	RequestAnimDict(animDict)
	TaskPlayAnim(PlayerPedId(-1), animDict, anim2, 8.0, -8, -1, 8, 0, 0, 0, 0)
	Citizen.Wait(700)
	TriggerServerEvent('755f814f-b094-43c2-ba50-12e7182745ce',text)
end)
TriggerEvent('2896af73-6240-4f26-92b0-417518db3f5a', "/flip", "Flip a coin")

-- Roll Dice
RegisterCommand("roll", function(source, args, command)
	local text = rollPrefix
	local dice = {}
	local numOfDice = tonumber(args[1]) and tonumber(args[1]) or 1
	local numOfSides = tonumber(args[2]) and tonumber(args[2]) or 6
	if (numOfDice < 1 or numOfDice > maxDice) then numOfDice = 1 end
	if (numOfSides < 2 or numOfSides > maxDiceSides) then numOfSides = 6 end
	for i = 1, numOfDice do
		dice[i] = math.random(1, numOfSides)
		text = text ..dice[i] .." of " ..numOfSides .." sided dice."
	end
	RequestAnimDict(animDict)
	TaskPlayAnim(PlayerPedId(-1), animDict, anim1, 8.0, -8, -1, 8, 0, 0, 0, 0)
	Wait(650)
	TaskPlayAnim(PlayerPedId(-1), animDict, anim2, 8.0, -8, -1, 8, 0, 0, 0, 0)
	Citizen.Wait(700)
	TriggerServerEvent('755f814f-b094-43c2-ba50-12e7182745ce',text)

end)

TriggerEvent('2896af73-6240-4f26-92b0-417518db3f5a', "/roll", "Roll dice", {
    { name="Dice", help="Number of dice (1-" ..maxDice ..")" },
    { name="Sides", help="Number of sides (2-" ..maxDiceSides ..")" },
})