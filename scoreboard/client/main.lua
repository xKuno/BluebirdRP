local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, 
	["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, 
	["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
	["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
	["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
	["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, 
	["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
	["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local idVisable = false
ESX = nil
local group = "user"
local ambulanceO = 0
local policeO = 0

local totalPlayersL = 0

SendNUIMessage({
	action = 'noplayers',
	state = 0
})

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	--[[Citizen.Wait(math.random(2000,4000))
	ESX.TriggerServerCallback('esx_scoreboard:getConnectedPlayers', function(connectedPlayers)
		UpdatePlayerTable(connectedPlayers, police,0)
	end)--]]
end)

Citizen.CreateThread(function()
	Citizen.Wait(500)
	SendNUIMessage({
		action = 'updateServerInfo',

		maxPlayers = GetConvarInt('sv_maxclients', 64),
		uptime = 'unknown',
		playTime = '00h 00m'
	})
	
	SendNUIMessage({
			action = 'toggleID',
			state = idVisable
		})
end)

RegisterNetEvent('esx_scoreboard:updateConnectedPlayers')
AddEventHandler('esx_scoreboard:updateConnectedPlayers', function(connectedPlayers,jobs,totalPlayers)
	UpdatePlayerTable(connectedPlayers,jobs,totalPlayers)
end)

RegisterNetEvent('es_admin:setGroup')
AddEventHandler('es_admin:setGroup', function(g)
	group = g
	if group ~= 'user' then
		if idVisable == true then
			idVisable = true
			SendNUIMessage({
				action = 'toggleID',
				state = idVisable
			})
		end
	else
		idVisable = false
		SendNUIMessage({
			action = 'toggleID',
			state = idVisable
		})
	end
end)

RegisterNetEvent('esx_scoreboard:updatePing')
AddEventHandler('esx_scoreboard:updatePing', function(connectedPlayers)
	SendNUIMessage({
		action  = 'updatePing',
		players = connectedPlayers
	})
end)

RegisterNetEvent('esx_scoreboard:toggleID')
AddEventHandler('esx_scoreboard:toggleID', function(state)
	if state then
		idVisable = state
	else
		idVisable = not idVisable
	end

	SendNUIMessage({
		action = 'toggleID',
		state = idVisable
	})
	
end)


RegisterNetEvent('uptime:tick')
AddEventHandler('uptime:tick', function(uptime)
	SendNUIMessage({
		action = 'updateServerInfo',
		uptime = uptime
	})
end)

function UpdatePlayerTable(connectedPlayers,jobcount,totalPlayers)
	local formattedPlayerList, num = {}, 1
	local ems, police, taxi, mechanic, fire, bil, wilson,mcv , players = 0, 0, 0, 0, 0, 0, 0, 0,0
	local plyid = GetPlayerServerId(PlayerId())
	
	if jobcount == nil then
		return
	end
	
	mcv = jobcount["avocat"]
	police = jobcount["police"]
	ems = jobcount["ambulance"]
	mechanic = jobcount["mecano"]
	wilson = jobcount["wilson"]
	taxi = jobcount["taxi"]
	fire = jobcount["fire"]
	local countplayersrun = 0
	for k,v in pairs(connectedPlayers) do
		
		countplayersrun = countplayersrun + 1
		local name = ' '
		if plyid == v.id then
			name = '<strong><font color="yellow"><u>' .. v.name .. ' [' .. v.id ..']' ..  '</u></font></strong>'
		else
			name = v.name
		end
		
		--for i = 0, 100 do
			if num == 1 then
				table.insert(formattedPlayerList, ('<tr><td>%s</td><td>%s</td><td>%s</td>'):format(name, v.id, v.ping))
				num = 2
			elseif num == 2 then
				table.insert(formattedPlayerList, ('<td>%s</td><td>%s</td><td>%s</td>'):format(name, v.id, v.ping))
				num = 3
			elseif num == 3 then
				table.insert(formattedPlayerList, ('<td>%s</td><td>%s</td><td>%s</td>'):format(name, v.id, v.ping))
				num = 4
			elseif num == 4 then
				table.insert(formattedPlayerList, ('<td>%s</td><td>%s</td><td>%s</td>'):format(name, v.id, v.ping))
				num = 5
			elseif num == 5 then
				table.insert(formattedPlayerList, ('<td>%s</td><td>%s</td><td>%s</td></tr>'):format(name, v.id, v.ping))
				num = 1	
			end
		
			players = players + 1
		--end
		--[[
		if v.job == 'ambulance' then
			if v.duty and v.jobgrade < 20 then
				ems = ems + 1
			elseif v.duty and v.jobgrade >= 20 then
				fire = fire + 1
			end
		elseif v.job == 'police' then
			if v.duty and v.jobgrade < 50 then
				police = police + 1
			end
		elseif v.job == 'taxi' then
				taxi = taxi + 1
		elseif v.job == 'mecano' then
			if v.duty then
				mechanic = mechanic + 1
			end
		elseif v.job == 'mecano2' then
			if v.duty then
				bil = bil + 1
			end
		elseif v.job == 'wilson' then
			if v.duty then
				wilson = wilson + 1
			end
		elseif v.job == 'avocat' and v.jobgrade >= 2 then
			--if v.duty then
				mcv = mcv + 1
			--end
		end--]]
		Wait(25)
	end
	if countplayersrun > 0 then
		SendNUIMessage({
			action = 'hasplayers',
			state = 0
		})
	else
		SendNUIMessage({
			action = 'noplayers',
			state = 0
		})
	end
	totalPlayersL = players
	ambulanceO = ems
	policeO = police


	if num == 1 then
		table.insert(formattedPlayerList, '</tr>')
	end

	SendNUIMessage({
		action  = 'updatePlayerList',
		players = table.concat(formattedPlayerList)
	})

	SendNUIMessage({
		action = 'updatePlayerJobs',
		jobs   = {ems = ems, police = police, taxi = taxi, mechanic = mechanic, fire = fire, bil = bil, wilson = wilson, mcv = mcv, player_count = totalPlayers}
	})
	
	SendNUIMessage({
		action = 'toggleID',
		state = idVisable
	})
end

function ambulanceOnline()
	return ambulanceO
end

function policeOnline()
	return policeO
end

function totalPlayers()
	return totalPlayersL
end


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)

		
		if IsControlPressed(0,Keys['LEFTALT']) and IsControlJustPressed(0, Keys['Z']) and IsInputDisabled(0) then
			ToggleScoreBoard()
			Citizen.Wait(300)
			
		-- D-pad up on controllers works, too!
--		elseif IsControlJustReleased(0, 172) and not IsInputDisabled(0) then
	--		ToggleScoreBoard()
	--		Citizen.Wait(200)
		end
	end
end)

-- Close scoreboard when game is paused
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(500)

		if IsPauseMenuActive() and not IsPaused then
			IsPaused = true
			SendNUIMessage({
				action  = 'close'
			})
		elseif not IsPauseMenuActive() and IsPaused then
			IsPaused = false
		end
	end
end)

function ToggleScoreBoard()
	SendNUIMessage({
		action = 'toggle'
	})
end

Citizen.CreateThread(function()
	local playMinute, playHour = 0, 0

	while true do
		Citizen.Wait(1000 * 60) -- every minute
		playMinute = playMinute + 1
	
		if playMinute == 60 then
			playMinute = 0
			playHour = playHour + 1
		end

		SendNUIMessage({
			action = 'updateServerInfo',
			playTime = string.format("%02dh %02dm", playHour, playMinute)
		})
	end
end)
