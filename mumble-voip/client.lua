local initialised = false
local playerServerId = GetPlayerServerId(PlayerId())
local unmutedPlayers = {}
local gridTargets = {}
local radioTargets = {}
local callTargets = {}
local speakerTargets = {}
local nearbySpeakerTargets = {}
local resetTargets = false
local playerChunk = nil
local voiceTarget = 2
local vehicleTargets = {}
local wasPlayerInVehicle = false

local lastTargetList = ""

local hasPriority = false  --allows the user to bypass radio restrictions

local pttToggle = false

local useController = true

local currentvolume = 3

local volumeInCars = 0.35

local radioVolume = 0.3

-- Functions
function SetVoiceData(key, value, target)
	TriggerServerEvent("mumble:SetVoiceData", key, value, target)
end

function PlayMicClick(channel, value)
	if channel <= mumbleConfig.radioClickMaxChannel then
		if mumbleConfig.micClicks then
			if (value and mumbleConfig.micClickOn) or (not value and mumbleConfig.micClickOff) then
				SendNUIMessage({ sound = (value and "audio_on" or "audio_off"), volume = mumbleConfig.micClickVolume })
			end
		end
	end
end


function SetVoiceRange(range)
	local playerData = voiceData[playerServerId]
		local playerMode = 2
		local playerRadio = 0
		local playerRadioActive = false
		local playerCall = 0
		local playerCallSpeaker = false

		if playerData ~= nil then
			playerMode = playerData.mode or 2
			playerRadio = playerData.radio or 0
			playerRadioActive = playerData.radioActive or false
			playerCall = playerData.call or 0
			playerCallSpeaker = playerData.callSpeaker or false
		end



		local voiceMode = playerMode
	
		local newMode = range
	
		if newMode > #mumbleConfig.voiceModes then
			voiceMode = 1
		else
			voiceMode = newMode
		end
		
		if mumbleConfig.use3dAudio then
			NetworkSetTalkerProximity(mumbleConfig.voiceModes[voiceMode][1])
		else
			NetworkSetTalkerProximity(mumbleConfig.voiceModes[voiceMode][1])
		end
		exports.hud:section(mumbleConfig.voiceModes[voiceMode][2],mumbleConfig.voiceModes[voiceMode][1])
		
		SetVoiceData("mode", voiceMode)
		playerData.mode = voiceMode

end
exports("SetVoiceRange", SetVoiceRange)

function getChannelName(playerRadio)
	return mumbleConfig.radioChannelNames[playerRadio] ~= nil and mumbleConfig.radioChannelNames[playerRadio] or ""
end
exports("getCurrentRadioChannelName", getChannelName)


-- Events
RegisterNetEvent(  "mumble:togglepriority")
AddEventHandler(  "mumble:togglepriority", function(toggle)
	hasPriority = toggle
end)

function SetGridTargets(pos, reset) -- Used to set the players voice targets depending on where they are in the map
	local currentChunk = GetCurrentChunk(pos)
	local nearbyChunks = GetNearbyChunks(pos)
	local nearbyChunksStr = "None"
	local targets = {}
	local playerData = voiceData[playerServerId]

	if not playerData then
		playerData  = {
			mode = 2,
			radio = 0,
			radioActive = false,
			call = 0,
			callSpeaker = false,
			speakerTargets = {},
			radioName = GetRandomPhoneticLetter() .. "-" .. playerServerId
		}
	end

	for i = 1, #nearbyChunks do
		if nearbyChunks[i] ~= currentChunk then
			targets[nearbyChunks[i]] = true

			if gridTargets[nearbyChunks[i]] then
				gridTargets[nearbyChunks[i]] = nil
			end

			if nearbyChunksStr ~= "None" then
				nearbyChunksStr = nearbyChunksStr .. ", " .. nearbyChunks[i]
			else
				nearbyChunksStr = nearbyChunks[i]
			end
		end
	end

	local newGridTargets = false

	for channel, exists in pairs(gridTargets) do
		if exists then
			newGridTargets = true
			break
		end
	end

	if reset then
		NetworkSetTalkerProximity(mumbleConfig.voiceModes[playerData.mode][1] + 0.0) -- Set voice proximity
		MumbleClearVoiceTarget(voiceTarget) -- Reset voice target
	end

	if playerChunk ~= currentChunk or newGridTargets or reset then -- Only reset target channels if the current chunk or any nearby chunks have changed
		MumbleClearVoiceTargetChannels(voiceTarget)

		MumbleAddVoiceTargetChannel(voiceTarget, currentChunk)

		for channel, _ in pairs(targets) do
			MumbleAddVoiceTargetChannel(voiceTarget, channel)
		end

		NetworkSetVoiceChannel(currentChunk)

		playerChunk = currentChunk
		gridTargets = targets

		DebugMsg("Current Chunk: " .. currentChunk .. ", Nearby Chunks: " .. nearbyChunksStr)

		if reset then
			SetPlayerTargets(callTargets, speakerTargets, vehicleTargets, playerData.radioActive and radioTargets or nil)

			resetTargets = false
		end
	end
end

function SetPlayerTargets(...)	
	local targets = { ... }
	local targetList = ""
	local addedTargets = {}
	
	MumbleClearVoiceTargetPlayers(voiceTarget)
	MumbleClearVoiceTargetPlayers(voiceTarget)

	for i = 1, #targets do
		for id, _ in pairs(targets[i]) do
			if not addedTargets[id] then
				MumbleAddVoiceTargetPlayerByServerId(voiceTarget, id)

				if targetList == "" then
					targetList = targetList .. id
				else
					targetList = targetList .. ", " .. id
				end

				addedTargets[id] = true
			end
		end
	end

	if targetList ~= "" then
		lastTargetList = targetList
		DebugMsg("Sending voice to Player " .. targetList)
	else
		lastTargetList = "nobody"
		DebugMsg("Sending voice to Nobody")
	end
end

-- default submix incase people want to fiddle with it.
-- freq_low = 389.0
-- freq_hi = 3248.0
-- fudge = 0.0
-- rm_mod_freq = 0.0
-- rm_mix = 0.16
-- o_freq_lo = 348.0
-- 0_freq_hi = 4900.0

-- radio submix
local radioEffectId = CreateAudioSubmix('Radio')
SetAudioSubmixEffectRadioFx(radioEffectId, 0)
SetAudioSubmixEffectParamInt(radioEffectId, 0, GetHashKey('default'), 1)
AddAudioSubmixOutput(radioEffectId, 0)

local phoneEffectId = CreateAudioSubmix('Phone')
SetAudioSubmixEffectRadioFx(phoneEffectId, 4)
SetAudioSubmixEffectParamInt(phoneEffectId, 1, `default`, 1)
SetAudioSubmixEffectParamFloat(phoneEffectId, 1, `freq_low`, 300.0)
SetAudioSubmixEffectParamFloat(phoneEffectId, 1, `freq_hi`, 6000.0)
AddAudioSubmixOutput(phoneEffectId, 1)

local submixFunctions = {
	['radio'] = function(serverId)
		MumbleSetSubmixForServerId(serverId, radioEffectId)
	end,
	['phone'] = function(serverId)
		MumbleSetSubmixForServerId(serverId, phoneEffectId)
	end
}

function TogglePlayerVoice(serverId, value ,submixType, volume)
	local msg = false
	local vol = 1.0
	if volume ~= nil then
		vol = volume
	end

	if value then
		if not unmutedPlayers[serverId] then
			unmutedPlayers[serverId] = true
			MumbleSetVolumeOverrideByServerId(serverId, vol)
			if submixType then
				submixFunctions[submixType](serverId)
			else
				MumbleSetSubmixForServerId(serverId, -1)
			end
			msg = true
		end
	else
		if unmutedPlayers[serverId] then
			unmutedPlayers[serverId] = nil
			MumbleSetVolumeOverrideByServerId(serverId, -1.0)
			Citizen.CreateThread(function()
				Wait(300)
				MumbleSetSubmixForServerId(serverId, -1)
				msg = true
			end)
		end		
	end

	if msg then
		DebugMsg((value and "Unmuting" or "Muting") .. " Player " .. serverId)
	end
end

function SetRadioChannel(channel)
	local channel = tonumber(channel)

	if channel ~= nil then
		SetVoiceData("radio", channel)

		if radioData[channel] then -- Check if anyone is talking and unmute if so
			for id, _ in pairs(radioData[channel]) do
				if id ~= playerServerId then					
					if not unmutedPlayers[id] then
						local playerData = voiceData[id]

						if playerData ~= nil then
							if playerData.radioActive then
								TogglePlayerVoice(id, true)
							end
						end
					end
				end
			end
		end
	end
end

function SetCallChannel(channel)
	local channel = tonumber(channel)

	if channel ~= nil then
		SetVoiceData("call", channel)

		if callData[channel] then -- Unmute current call participants
			for id, _ in pairs(callData[channel]) do
				if id ~= playerServerId then
					if not unmutedPlayers[id] then
						TogglePlayerVoice(id, true)
					end
				end
			end
		end
	end
end

function CheckVoiceSetting(varName, msg)
	local setting = GetConvarInt(varName, -1)

	if setting == 0 then
		SendNUIMessage({ warningId = varName, warningMsg = msg })

		Citizen.CreateThread(function()
			local varName = varName
			while GetConvarInt(varName, -1) == 0 do
				Citizen.Wait(1000)
			end

			SendNUIMessage({ warningId = varName })
		end)
	end

	DebugMsg("Checking setting: " .. varName .. " = " .. setting)

	return setting == 1
end

function CompareChannels(playerData, type, channel)
	local match = false

	if playerData[type] ~= nil then
		if playerData[type] == channel then
			match = true
		end
	end

	return match
end

function GetVehiclePassengers(vehicle)
	local passengers = {}
	local passengerCount = 0
	local seatCount = GetVehicleNumberOfPassengers(vehicle)

	for seat = -1, seatCount do
		if not IsVehicleSeatFree(vehicle, seat) then
			passengers[GetPedInVehicleSeat(vehicle, seat)] = true
			passengerCount = passengerCount + 1
		end
	end

	return passengerCount, passengers
end

function MuteVehiclePassengers(playerData)
	local changed = false

	for id, exists in pairs(vehicleTargets) do
		if exists then
			changed = true
			if playerData.radio > 0 and playerData.call > 0 then -- Only mute player if they are not in call or radio channel with client
				--print('remove a')
				local remotePlayerData = voiceData[id]
				if remotePlayerData ~= nil then
					if playerData.radio == remotePlayerData.radio then
						if not remotePlayerData.radioActive and playerData.call ~= remotePlayerData.call then
							TogglePlayerVoice(id, false)
						end
					elseif playerData.call ~= remotePlayerData.call then
						--print('toggled to false |a| Mute Vehicle Passengers id: ' .. id)
						TogglePlayerVoice(id, false)
					end
				end
			elseif playerData.call > 0 then
				--print('remove b')
				local remotePlayerData = voiceData[id]
				if remotePlayerData ~= nil then
					if playerData.call ~= remotePlayerData.call then
						--print('toggled to false |b| Mute Vehicle Passengers id: ' .. id)
						TogglePlayerVoice(id, false)
					end
				end
			elseif playerData.radio > 0 then
				--print('remove c')
				local remotePlayerData = voiceData[id]
				if remotePlayerData ~= nil then
						--print('me')
						--print(json.encode(playerData))
						--print('them')
						--print(json.encode(remotePlayerData))
					if playerData.radio == remotePlayerData.radio then
						if not remotePlayerData.radioActive then
							--print('toggled to false |c| Mute Vehicle Passengers id: ' .. id)
							TogglePlayerVoice(id, false)
						end
					else
						TogglePlayerVoice(id, false)
					end
				end
			else
				--print('remove d')
				--print('toggled to false |d| Mute Vehicle Passengers id: '.. id)
				TogglePlayerVoice(id, false)
			end
		end
	end

	return changed
end

-- Events
AddEventHandler("onClientResourceStart", function(resName) -- Initialises the script, sets up voice range, voice targets and request sync with server
	if GetCurrentResourceName() ~= resName then
		return
	end

	DebugMsg("Initialising")

	Citizen.Wait(1000)

	if mumbleConfig.useExternalServer then
		MumbleSetServerAddress(mumbleConfig.externalAddress, mumbleConfig.externalPort)
	end

	CheckVoiceSetting("profile_voiceEnable", "Voice chat disabled")
	CheckVoiceSetting("profile_voiceTalkEnabled", "Microphone disabled")

	if not MumbleIsConnected() then
		SendNUIMessage({ warningId = "mumble_is_connected", warningMsg = "Not connected to mumble" })

		while not MumbleIsConnected() do
			Citizen.Wait(250)
		end

		SendNUIMessage({ warningId = "mumble_is_connected" })
	end

	Citizen.Wait(1000)

	MumbleClearVoiceTarget(voiceTarget) -- Reset voice target
	MumbleSetVoiceTarget(voiceTarget)

	Citizen.Wait(1000)

	voiceData[playerServerId] = {
		mode = 2,
		radio = 0,
		radioActive = false,
		call = 0,
		callSpeaker = false,
		speakerTargets = {},
		radioName = GetRandomPhoneticLetter() .. "-" .. playerServerId
	}

	SetGridTargets(GetEntityCoords(PlayerPedId()), true) -- Add voice targets

	TriggerServerEvent("mumble:Initialise")

	SendNUIMessage({ speakerOption = mumbleConfig.callSpeakerEnabled })

	TriggerEvent("mumble:Initialised")

	initialised = true
end)

RegisterNetEvent("mumble:SetVoiceData") -- Used to sync players data each time something changes
AddEventHandler("mumble:SetVoiceData", function(player, key, value)
	if not voiceData[player] then
		voiceData[player] = {
			mode = 2,
			radio = 0,
			radioActive = false,
			call = 0,
			callSpeaker = false,
			speakerTargets = {},
			radioName = GetRandomPhoneticLetter() .. "-" .. player
		}
	end

	local radioChannel = voiceData[player]["radio"]
	local callChannel = voiceData[player]["call"]
	local radioActive = voiceData[player]["radioActive"]
	local playerData = voiceData[playerServerId]

	if not playerData then
		playerData = {
			mode = 2,
			radio = 0,
			radioActive = false,
			call = 0,
			callSpeaker = false,
			speakerTargets = {},
			radioName = GetRandomPhoneticLetter() .. "-" .. playerServerId
		}
	end

	if key == "radio" and radioChannel ~= value then -- Check if channel has changed
		if radioChannel > 0 then -- Check if player was in a radio channel
			if radioData[radioChannel] then  -- Remove player from radio channel
				if radioData[radioChannel][player] then
					DebugMsg("Player " .. player .. " was removed from radio channel " .. radioChannel)
					radioData[radioChannel][player] = nil

					if CompareChannels(playerData, "radio", radioChannel) then
						if playerServerId ~= player then
							if unmutedPlayers[player] then
								if not vehicleTargets[player] then -- Mute if player is not in client vehicle
									if playerData.call > 0 then -- Check if the client is in a call
										if not CompareChannels(voiceData[player], "call", playerData.call) then -- Check if the client is in a call with the unmuted player
											TogglePlayerVoice(player, false)
										end
									else
										TogglePlayerVoice(player, false) -- mute player on radio channel leave
									end
								end
							end

							if radioTargets[player] then
								radioTargets[player] = nil

								if mumbleConfig.showRadioList then
									SendNUIMessage({ radioId = player }) -- Remove player from radio list
								end
							end
						elseif playerServerId == player then
							for id, _ in pairs(radioData[radioChannel]) do -- Mute players that aren't supposed to be unmuted
								if id ~= playerServerId then
									if unmutedPlayers[id] then -- Check if a player isn't muted
										if not vehicleTargets[id] then -- Mute if player is not in client vehicle
											if playerData.call > 0 then -- Check if the client is in a call
												if not CompareChannels(voiceData[id], "call", playerData.call) then -- Check if the client is in a call with the unmuted player
													TogglePlayerVoice(id, false)
												end
											else
												TogglePlayerVoice(id, false)
											end
										end
									end
								end
							end
							
							radioTargets = {} -- Remove all radio targets as client has left the radio channel

							if mumbleConfig.showRadioList then
								SendNUIMessage({ clearRadioList = true }) -- Clear radio list
							end

							if playerData.radioActive then
								SetPlayerTargets(callTargets, speakerTargets, vehicleTargets) -- Reset active targets if for some reason if the client was talking on the radio when the client left
							end
						end
					end
				end
			end
		end

		if value > 0 then
			if not radioData[value] then -- Create channel if it does not exist
				DebugMsg("Player " .. player .. " is creating channel: " .. value)
				radioData[value] = {}
			end
			
			DebugMsg("Player " .. player .. " was added to channel: " .. value)
			radioData[value][player] = true -- Add player to channel

			if CompareChannels(playerData, "radio", value) then
				if playerServerId ~= player then
					if not radioTargets[player] then
						radioTargets[player] = true							
						
						if mumbleConfig.showRadioList then
							SendNUIMessage({ radioId = player, radioName = voiceData[player].radioName }) -- Add player to radio list
						end

						if playerData.radioActive then
							SetPlayerTargets(callTargets, speakerTargets, vehicleTargets, radioTargets)
						end
					end
				end
			end

			if playerServerId == player then
				if mumbleConfig.showRadioList then
					SendNUIMessage({ radioId = playerServerId, radioName = playerData.radioName, self = true }) -- Add client to radio list
				end

				for id, _ in pairs(radioData[value]) do -- Add radio targets of existing players in channel
					if id ~= playerServerId then
						if not radioTargets[id] then
							radioTargets[id] = true

							if mumbleConfig.showRadioList then
								if voiceData[id] ~= nil then
									if voiceData[id].radioName ~= nil then
										SendNUIMessage({ radioId = id, radioName = voiceData[id].radioName }) -- Add player to radio list
									end
								end								
							end
						end
					end
				end
			end
		end
	elseif key == "call" and callChannel ~= value then
		if callChannel > 0 then -- Check if player was in a call channel
			if callData[callChannel] then  -- Remove player from call channel
				if callData[callChannel][player] then
					DebugMsg("Player " .. player .. " was removed from call channel " .. callChannel)
					callData[callChannel][player] = nil

					if CompareChannels(playerData, "call", callChannel) then
						if playerServerId ~= player then
							if unmutedPlayers[player] then
								if not vehicleTargets[player] then -- Mute if player is not in client vehicle
									if playerData.radio > 0 then -- Check if the client is on the radio
										if not CompareChannels(voiceData[player], "radio", playerData.radio) then -- Check if the client is in a radio channel with the unmuted player
											TogglePlayerVoice(player, false)
										else
											if voiceData[player] ~= nil then
												if not voiceData[player].radioActive then -- Check if the unmuted player isn't talking
													TogglePlayerVoice(player, false)
												end
											else
												TogglePlayerVoice(player, false)
											end
										end
									else
										TogglePlayerVoice(player, false) -- mute player on radio channel leave
									end
								end
							end

							if callTargets[player] then
								callTargets[player] = nil
								SetPlayerTargets(callTargets, speakerTargets, vehicleTargets, playerData.radioActive and radioTargets or nil)
							end
						elseif playerServerId == player then
							for id, _ in pairs(callData[callChannel]) do -- Mute players that aren't supposed to be unmuted
								if id ~= playerServerId then
									if unmutedPlayers[id] then -- Check if a player isn't muted
										if not vehicleTargets[id] then -- Mute if player is not in client vehicle
											if playerData.radio > 0 then -- Check if the client is in a radio channel
												if not CompareChannels(voiceData[id], "radio", playerData.radio) then -- Check if the client isn't in the radio channel with the unmuted player
													TogglePlayerVoice(id, false)
												else -- Client is in the same radio channel with unmuted player
													if voiceData[id] ~= nil then
														if not voiceData[id].radioActive then -- Check if the unmuted player isn't talking
															TogglePlayerVoice(id, false)
														end
													else
														TogglePlayerVoice(id, false)
													end
												end
											else
												TogglePlayerVoice(id, false)
											end
										end
									end
								end
							end
							
							callTargets = {} -- Remove all call targets as client has left the call

							SetPlayerTargets(callTargets, speakerTargets, vehicleTargets, playerData.radioActive and radioTargets or nil) -- Reset player targets
						end
					end
				end
			end
		end

		if value > 0 then
			if not callData[value] then -- Create call if it does not exist
				DebugMsg("Player " .. player .. " is creating call: " .. value)
				callData[value] = {}
			end
			
			DebugMsg("Player " .. player .. " was added to call: " .. value)
			callData[value][player] = true -- Add player to call

			if CompareChannels(playerData, "call", value) then
				if playerServerId ~= player then
					TogglePlayerVoice(player, value)

					if not callTargets[player] then
						callTargets[player] = true
						SetPlayerTargets(callTargets, speakerTargets, vehicleTargets, playerData.radioActive and radioTargets or nil)
					end
				end
			end
			
			if playerServerId == player then
				for id, _ in pairs(callData[value]) do
					if id ~= playerServerId then
						if not unmutedPlayers[id] then
							TogglePlayerVoice(id, true)
						end

						if not callTargets[id] then
							callTargets[id] = true
							SetPlayerTargets(callTargets, speakerTargets, vehicleTargets, playerData.radioActive and radioTargets or nil)
						end
					end
				end
			end
		end
	elseif key == "radioActive" and radioActive ~= value then
		DebugMsg("Player " .. player .. " radio talking state was changed from: " .. tostring(radioActive):upper() .. " to: " .. tostring(value):upper())
		if radioChannel > 0 then
			if CompareChannels(playerData, "radio", radioChannel) then -- Check if player is in the same radio channel as you
				if playerServerId ~= player then
					if value then
						TogglePlayerVoice(player, true,"radio", radioVolume) -- unmute player
						
					else
						if not vehicleTargets[player] then -- Mute if player is not in client vehicle
							if playerData.call > 0 then -- Check if the client is in a call
								if not CompareChannels(voiceData[player], "call", playerData.call) then -- Check if the client is in a call with the unmuted player
									TogglePlayerVoice(player, false)
								end
							else
								TogglePlayerVoice(player, false) -- mute player on radio channel leave
							end
						end
					end
					Citizen.CreateThread(function()
						Wait(250)
						PlayMicClick(radioChannel, value) -- play on/off clicks
					end)

					if mumbleConfig.showRadioList then
						SendNUIMessage({ radioId = player, radioTalking = value }) -- Set player talking in radio list
					end
				end
			end
		end
	elseif key == "speakerTargets" then
		local speakerTargetsRemoved = false
		local speakerTargetsAdded = {}

		for id, _ in pairs(value) do
			if voiceData[player] ~= nil then
				if voiceData[player][key] ~= nil then
					if voiceData[player][key][id] then
						voiceData[player][key][id] = nil
					else
						if playerServerId == id then -- Check if the client is gonna hear a nearby call
							TogglePlayerVoice(player, true) -- Unmute
						end

						if playerServerId == player then -- Check if the client is a paricipant in the phone call whose voice is heard through the speaker
							if not speakerTargets[id] then -- Send voice to player
								speakerTargets[id] = true
								speakerTargetsAdded[#speakerTargetsAdded + 1] = id
							end
						end
					end
				end
			end
		end

		if voiceData[player] ~= nil then
			if voiceData[player][key] ~= nil then
				for id, _ in pairs(voiceData[player][key]) do
					if playerServerId == id then -- Check if the client has been removed from a nearby call
						if not vehicleTargets[player] then -- Mute if player is not in client vehicle
							TogglePlayerVoice(player, false) -- Mute
						end
					end

					if playerServerId == player then -- Check if the client is a paricipant in the phone call whose voice is heard through the speaker
						if speakerTargets[id] then -- Stop sending voice to player
							speakerTargets[id] = nil
							speakerTargetsRemoved = true
						end
					end	
				end
			end
		end

		if speakerTargetsRemoved or #speakerTargetsAdded > 0 then
			SetPlayerTargets(callTargets, speakerTargets, vehicleTargets, playerData.radioActive and radioTargets or nil)
		end
	elseif key == "callSpeaker" and not value then
		if voiceData[player] ~= nil then
			if voiceData[player].call ~= nil then
				if voiceData[player].call > 0  then
					if callData[voiceData[player].call] ~= nil then -- Check if the call exists
						for id, _ in pairs(callData[voiceData[player].call]) do -- Loop through each call participant
							if voiceData[id] ~= nil then
								if voiceData[id].speakerTargets ~= nil then
									local speakerTargetsRemoved = false

									for targetId, _ in pairs(voiceData[id].speakerTargets) do -- Loop through each call participants speaker targets
										if playerServerId == targetId then -- Check if the client was a target and mute the call
											if not vehicleTargets[id] then -- Mute if player is not in client vehicle
												TogglePlayerVoice(id, false) -- Mute
											end
										end

										if playerServerId == id then -- Check if the client is a paricipant in the phone call whose voice is heard through the speaker
											if speakerTargets[targetId] then -- Stop sending voice to player
												speakerTargets[targetId] = nil
												speakerTargetsRemoved = true
											end
										end	
									end

									if speakerTargetsRemoved then
										SetPlayerTargets(callTargets, speakerTargets, vehicleTargets, playerData.radioActive and radioTargets or nil)
									end
								end
							end
						end
					end
				end
			end 
		end
	end

	voiceData[player][key] = value

	DebugMsg("Player " .. player .. " changed " .. key .. " to: " .. tostring(value))
end)

RegisterNetEvent("mumble:SyncVoiceData") -- Used to sync players data on initialising
AddEventHandler("mumble:SyncVoiceData", function(voice, radio, call)
	voiceData = voice
	radioData = radio
	callData = call
end)

RegisterNetEvent("mumble:getvoicedata") -- Used to sync players data on initialising
AddEventHandler("mumble:getvoicedata", function(requester)
	TriggerServerEvent('mumble:readiogetplayers',lastTargetList,json.encode(vehicleTargets),requester)
end)




RegisterNetEvent("mumble:RemoveVoiceData") -- Used to remove redundant data when a player disconnects
AddEventHandler("mumble:RemoveVoiceData", function(player)
	if voiceData[player] then
		local radioChannel = voiceData[player]["radio"] or 0
		local callChannel = voiceData[player]["call"] or 0

		if radioChannel > 0 then -- Check if player was in a radio channel
			if radioData[radioChannel] then  -- Remove player from radio channel
				if radioData[radioChannel][player] then
					DebugMsg("Player " .. player .. " was removed from radio channel " .. radioChannel)
					radioData[radioChannel][player] = nil
				end
			end
		end

		if callChannel > 0 then -- Check if player was in a call channel
			if callData[callChannel] then  -- Remove player from call channel
				if callData[callChannel][player] then
					DebugMsg("Player " .. player .. " was removed from call channel " .. callChannel)
					callData[callChannel][player] = nil
				end
			end
		end

		if radioTargets[player] or callTargets[player] or speakerTargets[player] then
			local playerData = voiceData[playerServerId]

			if not playerData then
				playerData = {
					mode = 2,
					radio = 0,
					radioActive = false,
					call = 0,
					callSpeaker = false,
					speakerTargets = {},
					radioName = GetRandomPhoneticLetter() .. "-" .. playerServerId
				}
			end

			radioTargets[player] = nil
			callTargets[player] = nil
			speakerTargets[player] = nil

			SetPlayerTargets(callTargets, speakerTargets, vehicleTargets, playerData.radioActive and radioTargets or nil)
		end

		voiceData[player] = nil
	end
end)

-- Simulate PTT when radio is active
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)

		if initialised then
			local playerData = voiceData[playerServerId]

			if not playerData then
				playerData = {
					mode = 2,
					radio = 0,
					radioActive = false,
					call = 0,
					callSpeaker = false,
					speakerTargets = {},
				}
			end

			if playerData.radioActive then -- Force PTT enabled
				SetControlNormal(0, 249, 1.0)
				SetControlNormal(1, 249, 1.0)
				SetControlNormal(2, 249, 1.0)
			end
			--[[
			if IsControlJustPressed(0, mumbleConfig.controls.proximity.key) then
				local secondaryPressed = true

				if mumbleConfig.controls.speaker.key ~= mumbleConfig.controls.proximity.key or mumbleConfig.controls.speaker.secondary == nil then
					secondaryPressed = false
				else
					secondaryPressed = IsControlPressed(0, mumbleConfig.controls.speaker.secondary) and (playerData.call > 0)
				end

				if not secondaryPressed then
					local voiceMode = playerData.mode
				
					local newMode = voiceMode + 1
				
					if newMode > #mumbleConfig.voiceModes then
						voiceMode = 1
					else
						voiceMode = newMode
					end
					
					NetworkSetTalkerProximity(mumbleConfig.voiceModes[voiceMode][1] + 0.0)

					SetVoiceData("mode", voiceMode)
					playerData.mode = voiceMode
				end
			end--]]

			if mumbleConfig.radioEnabled then
			
				if(GetLastInputMethod(0)) then
					
				else
					if not mumbleConfig.controls.radio.pressed then
						local ped = GetPlayerPed(-1)
						local IsInCar = GetVehiclePedIsIn(ped,false)

						local onperson = IsControlJustPressed(0, 19)
						local aim_key = IsControlPressed(0,25)
						local aim_key2 = IsControlJustPressed(0,25)

						if  (onperson and IsInCar == 0 and useController == true and aim_key == false and aim_key2 == false ) or (IsControlJustPressed(0,120) and IsInCar > 0 and useController == true) then

							if playerData.radio > 0  and not exports.esx_policejob:amicuffed() then
								SetVoiceData("radioActive", true)
								playerData.radioActive = true
								exports["rp-radio"]:pttpress()
								SetPlayerTargets(callTargets, speakerTargets, vehicleTargets, radioTargets) -- Send voice to everyone in the radio and call
								PlayMicClick(playerData.radio, true)
								if mumbleConfig.showRadioList then
									SendNUIMessage({ radioId = playerServerId, radioTalking = true }) -- Set client talking in radio list
								end
								mumbleConfig.controls.radio.pressed = true

								Citizen.CreateThread(function()
										while (IsControlPressed(0, 19) and IsInCar == 0) or (IsControlPressed(0,120) and IsInCar > 0) do
										Citizen.Wait(0)
									end
									SetVoiceData("radioActive", false)
									SetPlayerTargets(callTargets, speakerTargets, vehicleTargets) -- Stop sending voice to everyone in the radio
									PlayMicClick(playerData.radio, false)
									if mumbleConfig.showRadioList then
										SendNUIMessage({ radioId = playerServerId, radioTalking = false }) -- Set client talking in radio list
									end
									playerData.radioActive = false
									mumbleConfig.controls.radio.pressed = false
									exports["rp-radio"]:pttdepress()
								end)
							end
						end
					end
				end

			else
				if playerData.radioActive then
					SetVoiceData("radioActive", false)
					playerData.radioActive = false
				end
			end

			if mumbleConfig.callSpeakerEnabled then
				local secondaryPressed = false

				if mumbleConfig.controls.speaker.secondary ~= nil then
					secondaryPressed = IsControlPressed(0, mumbleConfig.controls.speaker.secondary)
				else
					secondaryPressed = true
				end

				if IsControlJustPressed(0, mumbleConfig.controls.speaker.key) and secondaryPressed then
					if playerData.call > 0 then
						SetVoiceData("callSpeaker", not playerData.callSpeaker)
						playerData.callSpeaker = not playerData.callSpeaker
					end
				end
			end
		end
	end
end)


local isPTTToggled = false
local isPTTblocked = false
local presstimer = GetGameTimer()
RegisterCommand('+pttpress', function()
	local cuffed = exports.esx_policejob:amicuffed()
	if presstimer > GetGameTimer() - 500 then
		SendNUIMessage({ sound = "audio_tdt", volume = mumbleConfig.micClickVolume })
		isPTTblocked = true
		return
	end

	if  (initialised and pttToggle == true and isPTTToggled == false and not cuffed) or emergnotice == true  or (pttToggle == false and not cuffed) then

		local playerData = voiceData[playerServerId]

		if not playerData then
			playerData = {
				mode = 2,
				radio = 0,
				radioActive = false,
				call = 0,
				callSpeaker = false,
				speakerTargets = {},
			}
		end

		if playerData.radioActive then -- Force PTT enabled
			SetControlNormal(0, 249, 1.0)
			SetControlNormal(1, 249, 1.0)
			SetControlNormal(2, 249, 1.0)
		end
		if mumbleConfig.radioEnabled then
			if not mumbleConfig.controls.radio.pressed then
				if emergnotice == nil then
					exports["rp-radio"]:pttpress()
				elseif emergnotice ~= nil and emergnotice == false then
					exports["rp-radio"]:pttpress()
				end
				if playerData.radio > 0 then
					
					local permissiontotalk = true
					if hasPriority == false then
						
						for a , datav in pairs(voiceData) do
							if datav.radio == playerData.radio then
								if datav.radioActive == true then
									permissiontotalk = false
									
								end
							end
						end
					end
					if permissiontotalk == false then
						isPTTblocked = true
						SendNUIMessage({ sound = "audio_tdt", volume = mumbleConfig.micClickVolume })
					end
					if playerData.radio > 0 and permissiontotalk == true then
						presstimer = GetGameTimer()
						SetVoiceData("radioActive", true)
						playerData.radioActive = true
						SetPlayerTargets(callTargets, speakerTargets, vehicleTargets, radioTargets) -- Send voice to everyone in the radio and call
						PlayMicClick(playerData.radio, true)
						if mumbleConfig.showRadioList then
							SendNUIMessage({ radioId = playerServerId, radioTalking = true }) -- Set client talking in radio list
						end
						mumbleConfig.controls.radio.pressed = true
					end
					

				end
		end
		else
			if playerRadioActive then
				SetVoiceData("radioActive", false)
				playerData.radioActive = false
			end
		
		end
		if pttToggle == true and isPTTToggled == false then
			isPTTToggled = true
			
			Citizen.CreateThread(function()
				local zzcncoutndown = 15
				while zzcncoutndown >= 0 and isPTTToggled == true do
					Wait(1000)
					zzcncoutndown = zzcncoutndown - 1
				end
				if isPTTToggled == true then
					--ExecuteCommand("+pttpress")
				end
				
			end)
		end
	elseif pttToggle == true and isPTTToggled == true then
		
		local playerData = voiceData[playerServerId]

		if not playerData then
			playerData = {
				mode = 2,
				radio = 0,
				radioActive = false,
				call = 0,
				callSpeaker = false,
				speakerTargets = {},
			}
		end
		if mumbleConfig.radioEnabled then
				print('depress hit 1')
				exports["rp-radio"]:pttdepress()

				SetVoiceData("radioActive", false)
				PlayMicClick(playerData.radio, false)
				playerData.radioActive = false
				mumbleConfig.controls.radio.pressed = false
	
		end
		isPTTToggled = false
	end

end, false)
RegisterCommand('-pttpress', function()
		if emergnotice == true or pttToggle == false then
			
			exports["rp-radio"]:pttdepress()
			
			local playerData = voiceData[playerServerId]
	
			if not playerData then
				playerData = {
					mode = 2,
					radio = 0,
					radioActive = false,
					call = 0,
					callSpeaker = false,
					speakerTargets = {},
				}
			end
			
			if mumbleConfig.radioEnabled then
					
					if isPTTblocked == false or playerData.radioActive == true then
						SetVoiceData("radioActive", false)
						exports["rp-radio"]:pttdepress()
						PlayMicClick(playerData.radio, false)
						
						isPTTblocked = false
						playerData.radioActive = false
						mumbleConfig.controls.radio.pressed = false
						
						SetVoiceData("radioActive", false)
						SetPlayerTargets(callTargets, speakerTargets, vehicleTargets) -- Stop sending voice to everyone in the radio
						if mumbleConfig.showRadioList then
							SendNUIMessage({ radioId = playerServerId, radioTalking = false }) -- Set client talking in radio list
						end
						playerData.radioActive = false
						mumbleConfig.controls.radio.pressed = false
					end
		
			end
		end
			
end,false)
RegisterKeyMapping('+pttpress', 'Radio PTT Press', 'keyboard', 'ADD')


-- UI
Citizen.CreateThread(function()
	while true do
	
			local playerId = PlayerId()
			local playerData = voiceData[playerServerId]
			local playerTalking = NetworkIsPlayerTalking(playerId)
			local playerMode = 2
			local playerRadio = 0
			local playerRadioActive = false
			local playerCall = 0
			local playerCallSpeaker = false

			if playerData ~= nil then
				playerMode = playerData.mode or 2
				playerRadio = playerData.radio or 0
				playerRadioActive = playerData.radioActive or false
				playerCall = playerData.call or 0
				playerCallSpeaker = playerData.callSpeaker or false
			end
			
			local talking = false
			local talkingid = nil
			local tcount = 0
			
			for a , datav in pairs(voiceData) do
				if datav.radio == playerRadio then
					if datav.radioActive == true then
						talking = true
						if tcount > 0 then
							talkingid = talkingid .. ", " .. a
						else
							talkingid = a
						end
						tcount = tcount + 1
					end
				end
			end

			-- Update UI
			SendNUIMessage({
				talking = playerTalking,
				mode = mumbleConfig.voiceModes[playerMode][2],
				radio = mumbleConfig.radioChannelNames[playerRadio] ~= nil and mumbleConfig.radioChannelNames[playerRadio] or playerRadio,
				radioActive = playerRadioActive,
				call = mumbleConfig.callChannelNames[playerCall] ~= nil and mumbleConfig.callChannelNames[playerCall] or playerCall,
				speaker = playerCallSpeaker,
				onchannel = talkingid
			})

			Citizen.Wait(400)
	end
end)

-- Manage Grid Target Channels
Citizen.CreateThread(function()
	Wait(8000)
	while true do
		
		if initialised then
			if not MumbleIsConnected() then
				SendNUIMessage({ warningId = "mumble_is_connected", warningMsg = "Not connected to mumble" })

				while not MumbleIsConnected() do
					Citizen.Wait(250)
				end

				SendNUIMessage({ warningId = "mumble_is_connected" })

				resetTargets = true
			end

			local playerPed = PlayerPedId()
			local playerCoords = GetEntityCoords(playerPed)
			
			SetGridTargets(playerCoords, resetTargets)

			Citizen.Wait(2500)
		else
			Citizen.Wait(0)
		end
	end
end)

-- Manage hearing nearby players on call
Citizen.CreateThread(function()
	while true do
		if initialised then
			if mumbleConfig.callSpeakerEnabled then
				local playerData = voiceData[playerServerId]

				if not playerData then
					playerData  = {
						mode = 2,
						radio = 0,
						radioActive = false,
						call = 0,
						callSpeaker = false,
						speakerTargets = {},
					}
				end
				
				if playerData.call > 0 then -- Check if player is in call
					if playerData.callSpeaker then -- Check if they have loud speaker on
						local playerId = PlayerId()
						local playerPed = PlayerPedId()
						local playerPos = GetEntityCoords(playerPed)
						local playerList = GetActivePlayers()
						local nearbyPlayers = {}
						local nearbyPlayerAdded = false
						local nearbyPlayerRemoved = false

						for i = 1, #playerList do -- Get a list of all players within loud speaker range
							local remotePlayerId = playerList[i]
							if playerId ~= remotePlayerId then
								local remotePlayerServerId = GetPlayerServerId(remotePlayerId)
								local remotePlayerPed = GetPlayerPed(remotePlayerId)
								local remotePlayerPos = GetEntityCoords(remotePlayerPed)
								local distance = #(playerPos - remotePlayerPos)
								
								if distance <= mumbleConfig.speakerRange then
									local remotePlayerData = voiceData[remotePlayerServerId]

									if remotePlayerData ~= nil then
										if remotePlayerData.call ~= nil then
											if remotePlayerData.call ~= playerData.call then
												nearbyPlayers[remotePlayerServerId] = true
												
												if nearbySpeakerTargets[remotePlayerServerId] then
													nearbySpeakerTargets[remotePlayerServerId] = nil
												else
													nearbyPlayerAdded = true
												end
											end
										end
									end
								end
							end
						end
						
						for id, exists in pairs(nearbySpeakerTargets) do
							if exists then
								nearbyPlayerRemoved = true
							end
						end

						if nearbyPlayerAdded or nearbyPlayerRemoved then -- Check that we don't send an empty list
							if callData[playerData.call] ~= nil then -- Check if the call still exists
								for id, _ in pairs(callData[playerData.call]) do -- Send a copy of the nearby players to each participant in the call
									if playerServerId ~= id then
										SetVoiceData("speakerTargets", nearbyPlayers, id)
									end
								end
							end
						end

						nearbySpeakerTargets = nearbyPlayers
					end
				end
			end

			Citizen.Wait(1500)
		else
			Citizen.Wait(0)
		end
	end
end)



-- Set vehicle passengers to 2D voice and ignore distance checks
Citizen.CreateThread(function()
	while true do
		if initialised then
			if mumbleConfig.use2dAudioInVehicles then
				local playerPed = PlayerPedId()
				local playerData = voiceData[playerServerId]

				if not playerData then
					playerData = {
						mode = 2,
						radio = 0,
						radioActive = false,
						call = 0,
						callSpeaker = false,
						speakerTargets = {},
					}
				end

				if IsPedInAnyVehicle(playerPed, false) then
					local playerVehicle = GetVehiclePedIsIn(playerPed, false)
					local passengerCount, passengers = GetVehiclePassengers(playerVehicle)

					if passengerCount > 1 then --people in car yes?
						local playerId = PlayerId()
						local playerList = GetActivePlayers()
						local targets = {}
						local targetList = ""
						local newPassengers = false

						for i = 1, #playerList do --go thorugh this list
							local remotePlayerId = playerList[i]
							if playerId ~= remotePlayerId then
								local remotePlayerPed = GetPlayerPed(remotePlayerId)
								if passengers[remotePlayerPed] then  --check if in vehicle
									local remotePlayerServerId = GetPlayerServerId(remotePlayerId)

									targets[remotePlayerServerId] = true --targets them

									if targetList == "" then
										targetList = remotePlayerServerId
									else
										targetList = targetList .. ", " .. remotePlayerServerId
									end

									if vehicleTargets[remotePlayerServerId] then
										vehicleTargets[remotePlayerServerId] = nil
									else
										newPassengers = true
									end
								end
							end
						end

						local removedPassengers = MuteVehiclePassengers(playerData)

						vehicleTargets = targets
						wasPlayerInVehicle = true

						if newPassengers or removedPassengers then
						
							for id, exists in pairs(targets) do
								if exists then
									print('VEH 2d voice was toggled: ' .. id .. ' volumeInCars: ' ..volumeInCars) 
									TogglePlayerVoice(id,true)  --TogglePlayerVoice(id,true,nil,volumeInCars)
								end
							end

							if targetList ~= "" then
								DebugMsg("Unmuted passengers: " .. targetList)
							else
								DebugMsg("Unmuting 0 passengers")
							end

							SetPlayerTargets(callTargets, speakerTargets, vehicleTargets, playerData.radioActive and radioTargets or nil)
						end
					else
						if wasPlayerInVehicle then					
							MuteVehiclePassengers(playerData)
							vehicleTargets = {}
							wasPlayerInVehicle = false
							SetPlayerTargets(callTargets, speakerTargets, vehicleTargets, playerData.radioActive and radioTargets or nil)
						end
					end
				else
					if wasPlayerInVehicle then
						MuteVehiclePassengers(playerData)
						vehicleTargets = {}
						wasPlayerInVehicle = false
						SetPlayerTargets(callTargets, speakerTargets, vehicleTargets, playerData.radioActive and radioTargets or nil)
					end
				end
			end

			Citizen.Wait(2000)
		else
			Citizen.Wait(0)
		end
	end
end)

-- Exports
exports("SetRadioChannel", SetRadioChannel)
exports("addPlayerToRadio", SetRadioChannel)
exports("removePlayerFromRadio", function()
	SetRadioChannel(0)
end)

exports("SetCallChannel", SetCallChannel)
exports("addPlayerToCall", SetCallChannel)
exports("removePlayerFromCall", function()
	SetCallChannel(0)
end)




function getChannelName(playerRadio)
	return mumbleConfig.radioChannelNames[playerRadio] ~= nil and mumbleConfig.radioChannelNames[playerRadio] or ""
end
exports("getCurrentRadioChannelName", getChannelName)


exports("setvolume", function(volume)
	SetVoiceVolume(volume)
end)



function DrawTxt(x,y ,width,height,scale, text, r,g,b,a)
    SetTextFont(6)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end


RegisterNetEvent("mumble:VoiceTempPriority")
AddEventHandler("mumble:VoiceTempPriority", function(player, key, value)
	emergnotice = true
	Citizen.CreateThread(function()
		hasPriority = true
		Wait(60000)
		hasPriority = false
	end)
	Citizen.CreateThread(function()
		Wait(1500)
		emergnotice = true
		ExecuteCommand("+pttpress")
		Wait(10000)
		emergnotice = false
		ExecuteCommand("-pttpress")
		
	end)
	local zzcncoutndown = 10
	Citizen.CreateThread(function()
		Wait(1500)
		while zzcncoutndown >= 0 do
			Wait(1000)
			zzcncoutndown = zzcncoutndown - 1
		end
	end)
	
	Citizen.CreateThread(function()
		Wait(500)
		while emergnotice == true do
			DrawTxt(1.130, 0.800, 1.0,1.0,0.95,"~r~DURESS OPEN MIC ~w~|~r~ REMAINING:" .. "~w~ " .. zzcncoutndown .. " SECS", 255,255,255,255)
			Citizen.InvokeNative(0x552369F549563AD5,false)
			Wait(0)
		end

	end)

end)



RegisterCommand("radiotoggledebug",function()
	print('debug has been toggled')
	mumbleConfig.debug = not mumbleConfig.debug
	DebugMsg("Testing Debug Msg")
	
end)

RegisterCommand("printlist",function()

	print('list here')

	
	for a , datav in pairs(voiceData) do
		print(a)
		print(json.encode(datav))
	end
	print('one player')
	print(json.encode(voiceData[4]))
end)

RegisterCommand("radiopttt",function()
	pttToggle = not pttToggle
end)

RegisterCommand("radiohc",function()
	useController = not useController
end)




RegisterCommand('+voicerange', function()

		local playerData = voiceData[playerServerId]
		local playerMode = 2
		local playerRadio = 0
		local playerRadioActive = false
		local playerCall = 0
		local playerCallSpeaker = false

		if playerData ~= nil then
			playerMode = playerData.mode or 2
			playerRadio = playerData.radio or 0
			playerRadioActive = playerData.radioActive or false
			playerCall = playerData.call or 0
			playerCallSpeaker = playerData.callSpeaker or false
		end




		local voiceMode = playerMode
	
		local newMode = voiceMode + 1
	
		if newMode > #mumbleConfig.voiceModes then
			voiceMode = 1
		else
			voiceMode = newMode
		end
		
		if mumbleConfig.use3dAudio then
			NetworkSetTalkerProximity(mumbleConfig.voiceModes[voiceMode][1])
		else
			NetworkSetTalkerProximity(mumbleConfig.voiceModes[voiceMode][1])
		end
		exports.hud:section(mumbleConfig.voiceModes[voiceMode][2],mumbleConfig.voiceModes[voiceMode][1])
		
		SetVoiceData("mode", voiceMode)
		playerData.mode = voiceMode


end, false)
RegisterKeyMapping('+voicerange', 'Voice Radius Change', 'keyboard', 'COMMA')


RegisterCommand('+halfmuteradio', function()
		local playerData = voiceData[playerServerId]
		local playerMode = 2
		local playerRadio = 0
		local playerRadioActive = false
		local playerCall = 0
		local playerCallSpeaker = false

		if playerData ~= nil then
			playerMode = playerData.mode or 2
			playerRadio = playerData.radio or 0
			playerRadioActive = playerData.radioActive or false
			playerCall = playerData.call or 0
			playerCallSpeaker = playerData.callSpeaker or false
		end

			
		local voiceMode = currentvolume
	
		local newMode = currentvolume + 1
	
		if newMode > #mumbleConfig.radioVLevels then
			voiceMode = 1
		else
			voiceMode = newMode
		end

		exports['mythic_notify']:DoShortHudText('inform', 'Radio Volume: ' .. mumbleConfig.radioVLevels[voiceMode][2])
		currentvolume = voiceMode
		radioVolume = mumbleConfig.radioVLevels[currentvolume][1]



end, false)
RegisterKeyMapping('+halfmuteradio', 'Voice Radio Volume Toggle', 'keyboard', 'OEM_5')

RegisterCommand('setrvol', function(source, args, rawCommand)
		local playerData = voiceData[playerServerId]
		local playerMode = 2
		local playerRadio = 0
		local playerRadioActive = false
		local playerCall = 0
		local playerCallSpeaker = false

		if playerData ~= nil then
			playerMode = playerData.mode or 2
			playerRadio = playerData.radio or 0
			playerRadioActive = playerData.radioActive or false
			playerCall = playerData.call or 0
			playerCallSpeaker = playerData.callSpeaker or false
		end




		if tonumber(args[1]) > 0 then
			exports['mythic_notify']:DoShortHudText('inform', 'Radio Volume: ' .. tonumber(args[1]))
			radioVolume = tonumber(args[1])
		end

end, false)

RegisterCommand('setcvol', function(source, args, rawCommand)

		if tonumber(args[1]) > 0 then
			exports['mythic_notify']:DoShortHudText('inform', 'In Car Volume: ' .. tonumber(args[1]))
			volumeInCars = tonumber(args[1])
		end

end, false)


