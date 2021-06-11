--------------------------------------------------------------------------------------------------------------
------------First off, many thanks to @anders for help with the majority of this script. ---------------------
------------Also shout out to @setro for helping understand pNotify better.              ---------------------
--------------------------------------------------------------------------------------------------------------
------------To configure: Add/replace your own coords in the sectiong directly below.    ---------------------
------------        Goto LINE 90 and change "50" to your desired SafeZone Radius.        ---------------------
------------        Goto LINE 130 to edit the Marker( Holographic circle.)               ---------------------
--------------------------------------------------------------------------------------------------------------
-- Place your own coords here!

ESX                           = nil
local PlayerData              = {}

local zones = {
	vector3( -63.88,6235.19,31.22),
	vector3( 1856.9,3684.0,34.27),
	vector3( 440.48,-999.38,30.72),
	--vector3( 296.67,-587.51,43.23), Pillbox
   -- vector3( 129.67,-1066.51,29.23),
	vector3(-482.05218505859,-327.0693359375,61.908912658691), --Mt Zoriah
	vector3( 116.67,-603.51,36.23),
	vector3(5311.52, -5208.96, 83.52),
	vector3(335.11, -1639.366, 32.55),  --Court 
	vector3(326.0915222168,-210.34561157227,58.463417053223), --PinkCage
	vector3(-1887.1761474609,3990.6533203125,40.109504699707) --New Immigration

}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()

end)

RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function(job)
	PlayerData.job = job
	PlayerData = ESX.GetPlayerData()
end)

local notifIn = false
local notifOut = true
local closestZone = 1
local playerin = false


--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
-------                              Creating Blips at the locations. 							--------------
-------You can comment out this section if you dont want any blips showing the zones on the map.--------------
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
--[[
Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	
	for i = 1, #zones, 1 do
		local szBlip = AddBlipForCoord(zones[i].x, zones[i].y, zones[i].z)
		SetBlipAsShortRange(szBlip, true)
		SetBlipColour(szBlip, 2)  --Change the blip color: https://gtaforums.com/topic/864881-all-blip-color-ids-pictured/
		SetBlipSprite(szBlip, 398) -- Change the blip itself: https://marekkraus.sk/gtav/blips/list.html
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("SAFE ZONE") -- What it will say when you hover over the blip on your map.
		EndTextCommandSetBlipName(szBlip)
	end
end)--]]

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
----------------   Getting your distance from any one of the locations  --------------------------------------
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------


Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(10)
	end
	
	while true do
		local playerPed = GetPlayerPed(-1)
		local playerloc = GetEntityCoords(playerPed, true)
		local minDistance = 100000
		local closestZonez = closestZone
		for i = 1, #zones, 1 do
			dist = #(playerloc - zones[i])
			if dist < minDistance then
				minDistance = dist
				closestZonez = i
			end
			Wait(100)
		end
		closestZone = closestZonez
		Citizen.Wait(15000)
	end
end)

--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------
---------   Setting of friendly fire on and off, disabling your weapons, and sending pNoty   -----------------
--------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------

Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end
	local exemptrole = false
	
	while true do
		Citizen.Wait(0)
		local player = GetPlayerPed(-1)
		local playerloc = GetEntityCoords(player, true)
		local dist = #(playerloc - zones[closestZone])
				
		if PlayerData.job ~= nil and PlayerData.job.name ~= nil then
		
			if  PlayerData.job.name ~= nil then
				if type(PlayerData.job.name) == 'string' and (PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' or PlayerData.job.name == 'wilson' or PlayerData.job.name == 'blues') then
					exemptrole = true
					notifIn = false
				else
					exemptrole = false
				end
			end
		else

		end
		
		if exemptrole == true then
			Citizen.Wait(10000)
			
			
		else
			if dist <= 70.0 then  ------------------------------------------------------------------------------ Here you can change the RADIUS of the Safe Zone. Remember, whatever you put here will DOUBLE because 
				if not notifIn then																			  -- it is a sphere. So 50 will actually result in a diameter of 100. I assume it is meters. No clue to be honest.
					NetworkSetFriendlyFireOption(false)
					ClearPlayerWantedLevel(PlayerId())
					SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true)
					TriggerEvent('61329ade-cca4-49b0-ae5e-47119f350c2d',{
						text = "<b style='color:#1E90FF'>You are in a SafeZone</b><br/>Be aware: You are now no longer paid while in a safe zone.",
						type = "success",
						timeout = (6000),
						layout = "bottomcenter",
						queue = "global"
					})
					notifIn = true
					notifOut = false
				end
			elseif dist > 79 then
				if not notifOut then
					NetworkSetFriendlyFireOption(true)
					TriggerEvent('61329ade-cca4-49b0-ae5e-47119f350c2d',{
						text = "<b style='color:#1E90FF'>You are in NO LONGER a SafeZone</b>",
						type = "error",
						timeout = (3000),
						layout = "bottomcenter",
						queue = "global"
					})
					notifOut = true
					notifIn = false
				end
			end
			if notifIn then
			DisableControlAction(2, 37, true) -- disable weapon wheel (Tab)
			DisablePlayerFiring(player,true) -- Disables firing all together if they somehow bypass inzone Mouse Disable
			DisableControlAction(0, 106, true) -- Disable in-game mouse controls
			DisableControlAction(2, 45, true)
			DisableControlAction(0, 45, true)		-- Disables R
			DisableControlAction(0, 140, true) -- Hitting your vehicle (R)
				if IsDisabledControlJustPressed(2, 37) then --if Tab is pressed, send error message
					SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true) -- if tab is pressed it will set them to unarmed (this is to cover the vehicle glitch until I sort that all out)
					TriggerEvent('61329ade-cca4-49b0-ae5e-47119f350c2d',{
						text = "<b style='color:#1E90FF'>You can not use weapons in a Safe Zone</b>",
						type = "error",
						timeout = (3000),
						layout = "bottomcenter",
						queue = "global"
					})
				end
				if IsDisabledControlJustPressed(0, 106) then --if LeftClick is pressed, send error message
					SetCurrentPedWeapon(player,GetHashKey("WEAPON_UNARMED"),true) -- If they click it will set them to unarmed
					TriggerEvent('61329ade-cca4-49b0-ae5e-47119f350c2d',{
						text = "<b style='color:#1E90FF'>You can not do that in a Safe Zone</b>",
						type = "error",
						timeout = (3000),
						layout = "bottomcenter",
						queue = "global"
					})
				end
			else
				Wait(1000)
			end
			-- Comment out lines 142 - 145 if you dont want a marker.
			if notifOut == true then
				Citizen.Wait(3000)
			end
		end
	end
end)

function isPlayerInSafeZone()
	return notifIn
end