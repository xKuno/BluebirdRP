local WaitTime = 10000 -- How often do you want to update the status (In MS)

local DiscordAppId = tonumber(GetConvar("RichAppId", "541891454960926740"))
local DiscordAppAsset = GetConvar("RichAssetId", "fivem_large")

local players = 0





RegisterNetEvent('esx_scoreboard:updateConnectedPlayers')
AddEventHandler('esx_scoreboard:updateConnectedPlayers', function(lconnected,Connected,connectedPlayers)
	players = connectedPlayers
end)

	
Citizen.CreateThread(function()
	SetDiscordAppId(DiscordAppId)
	SetDiscordRichPresenceAsset(DiscordAppAsset)
	SetDiscordRichPresenceAction(0, "Play BlueBird FiveM", "fivem://connect/fivem.bluebirdrp.com:30120")
	SetDiscordRichPresenceAction(1, "Visit Website", "https://bluebirdrp.live")

	
	Wait(5000)
	local myid = GetPlayerServerId(PlayerId())
	while true do

		Citizen.Wait(WaitTime)
		local x,y,z = table.unpack(GetEntityCoords(PlayerPedId(),true))
		local StreetHash = GetStreetNameAtCoord(x, y, z)
		
	
		local pcount = '[#'..myid..']' .. ' Playing with [' .. players .. "] others."
		SetRichPresence(pcount)
		
		--[[
		if StreetHash ~= nil then
			StreetName = GetStreetNameFromHashKey(StreetHash)
			if IsPedOnFoot(PlayerPedId()) and not IsEntityInWater(PlayerPedId()) then
				if IsPedSprinting(PlayerPedId()) then
					SetRichPresence(pcount .. " Sprinting down "..StreetName)
				elseif IsPedRunning(PlayerPedId()) then
					SetRichPresence(pcount .. " Running down "..StreetName)
				elseif IsPedWalking(PlayerPedId()) then
					SetRichPresence(pcount .. " Walking down "..StreetName)
				elseif IsPedStill(PlayerPedId()) then
					SetRichPresence(pcount .. " Standing on "..StreetName)
				end
			elseif GetVehiclePedIsUsing(PlayerPedId()) ~= nil and not IsPedInAnyHeli(PlayerPedId()) and not IsPedInAnyPlane(PlayerPedId()) and not IsPedOnFoot(PlayerPedId()) and not IsPedInAnySub(PlayerPedId()) and not IsPedInAnyBoat(PlayerPedId()) then
				local MPH = math.ceil(GetEntitySpeed(GetVehiclePedIsUsing(PlayerPedId())) * 2.236936)
				local VehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))))
				if MPH > 50 then
					SetRichPresence(pcount .. " Speeding down "..StreetName.." In a "..VehName)
				elseif MPH <= 50 and MPH > 0 then
					SetRichPresence(pcount .. " Cruising down "..StreetName.." In a "..VehName)
				elseif MPH == 0 then
					SetRichPresence(pcount .. " Parked on "..StreetName.." In a "..VehName)
				end
			elseif IsPedInAnyHeli(PlayerPedId()) or IsPedInAnyPlane(PlayerPedId()) then
				local VehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))))
				if IsEntityInAir(GetVehiclePedIsUsing(PlayerPedId())) or GetEntityHeightAboveGround(GetVehiclePedIsUsing(PlayerPedId())) > 5.0 then
					SetRichPresence(pcount .. " Flying over "..StreetName.." in a "..VehName)
				else
					SetRichPresence(pcount .. " Landed at "..StreetName.." in a "..VehName)
				end
			elseif IsEntityInWater(PlayerPedId()) then
				SetRichPresence(pcount .. " Swimming around")
			elseif IsPedInAnyBoat(PlayerPedId()) and IsEntityInWater(GetVehiclePedIsUsing(PlayerPedId())) then
				local VehName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(GetVehiclePedIsUsing(PlayerPedId()))))
				SetRichPresence(pcount .. " Sailing around in a "..VehName)
			elseif IsPedInAnySub(PlayerPedId()) and IsEntityInWater(GetVehiclePedIsUsing(PlayerPedId())) then
				SetRichPresence(pcount .. " In a yellow submarine")
			end
		end--]]
	end
end)
