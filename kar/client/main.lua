ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(200)
        TriggerEvent('esx:getSharedObject', function (obj) ESX = obj end)
    end
end)

local cam = nil
local cam2 = nil

IsChoosing = false
IsWaiting = false
choosetimer = 0
-- This Code Was changed to fix error With player spawner as default --
-- Link to the post with the error fix --
-- https://forum.fivem.net/t/release-esx-kashacters-multi-character/251613/316?u=xxfri3ndlyxx --

function sendMessage(title, rgb, text)
	TriggerEvent('chatMessage', title, rgb, text)
end


if GetConvar("kar", "false") == "true" then

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
        if NetworkIsSessionStarted() then
			print('disabling voice')
			NetworkSetVoiceActive(false)
            Citizen.Wait(500)
			print('#######SUBMITTED REQUEST FOR SLOTS TO SERVER')
            TriggerServerEvent('d977af94-bdf7-43f4-ac01-24f7580b495f')
            TriggerEvent('03bd3ddc-0842-43e2-87df-85ddf678bffb')
			IsChoosing = true
			TriggerEvent('2e36f88d-4f53-4c92-b71a-fe71920fb9c2',false)
			choosetimer = 0
			IsWaiting = true

            return -- break the loop
        end
    end
end)



RegisterCommand("reloadchar", function(source, args, rawCommand)
	
	if IsChoosing or IsWaiting then
		print('#######RELOAD CHAR USED')
		TriggerServerEvent('d977af94-bdf7-43f4-ac01-24f7580b495f')
		TriggerEvent('03bd3ddc-0842-43e2-87df-85ddf678bffb')
		IsChoosing = true
		TriggerEvent('2e36f88d-4f53-4c92-b71a-fe71920fb9c2',false)
		
	else
		print('#######RELOAD CHAR DENIED')
		sendMessage("|||", {255,0,0}, "^3ERROR: ... ^*The command you attempted to use is not available at this point of loading.") 
	end

end)

local cancel = false
RegisterNetEvent('ce22643e-1c22-4ef3-977e-937179bb8fc2')
AddEventHandler('ce22643e-1c22-4ef3-977e-937179bb8fc2', function()
	if not exports.esx_policejob:amicuffed()then
		Citizen.CreateThread(function ()
			TriggerEvent('2c4f07a6-bf05-4b02-ba86-fd4472391cbd', 'You are about to switch characters, type ~o~/c~w~ to cancel.')
			Wait(3000)
			local seconds = 20
				Wait(1000)
				
			 while seconds > 0 do
				TriggerEvent('2c4f07a6-bf05-4b02-ba86-fd4472391cbd','Switch  ~y~countdown.. ~b~' .. seconds)
				TriggerServerEvent('d16a3f12-71a5-4ab5-b8d7-bda8f0c46b0a','Changing Character: ' .. seconds)
				seconds = seconds - 1
				Wait(1000)
				if seconds == 6 then
					local pos = GetEntityCoords(PlayerPedId())
					TriggerServerEvent('157a0b53-eb40-47a4-a444-8ac52dc99aed', pos.x, pos.y, pos.z)
					
				end
				Wait(0)
				if cancel == true then
					TriggerEvent('2c4f07a6-bf05-4b02-ba86-fd4472391cbd','Switch Character ~r~Cancelled')
					cancel = false
					return
				end
			 end
			 
			if cancel == false then
				TriggerServerEvent('d977af94-bdf7-43f4-ac01-24f7580b495f')
				TriggerEvent('03bd3ddc-0842-43e2-87df-85ddf678bffb')
				IsChoosing = true
				TriggerEvent('2e36f88d-4f53-4c92-b71a-fe71920fb9c2',false)
			end
		 
		end)
	else
		TriggerEvent('2c4f07a6-bf05-4b02-ba86-fd4472391cbd','Switch Character ~r~Cancelled\n~b~{Handcuffed}')
	end
end)



RegisterNetEvent('c0dfd614-9d70-4ebe-9dd3-62f47cc030a1')
AddEventHandler('c0dfd614-9d70-4ebe-9dd3-62f47cc030a1', function()
	cancel = true
end)


Citizen.CreateThread(function ()
    while true do
        Citizen.Wait(500)
        if IsChoosing then
            DisplayHud(false)
            DisplayRadar(false)
			choosetimer = choosetimer + 500

			if 	IsWaiting then
				if choosetimer == (10000) then
					print('########NOTICE 1 STILL LOADING')
					sendMessage("|||", {255,0,0}, "^3Please wait ... ^*You're still loading characters.") 
				
				end
				
				if choosetimer >=  (20000) then
					print('REQUESTING RELOAD NOTICE IIs')
					SetCamActive(cam, false)
					DestroyCam(cam, true)
					Wait(500)
					choosetimer = 0
					sendMessage("|||", {255,0,0}, "^3Please wait ... ^*^3We've asked the server to resend your characters..") 
					TriggerServerEvent('d977af94-bdf7-43f4-ac01-24f7580b495f')
					TriggerEvent('03bd3ddc-0842-43e2-87df-85ddf678bffb')
					IsChoosing = true
					TriggerEvent('2e36f88d-4f53-4c92-b71a-fe71920fb9c2',false)
					
				
				end
			end
		else
			Wait(1000)
        end
		
    end
end)

end

RegisterNetEvent('03bd3ddc-0842-43e2-87df-85ddf678bffb')
AddEventHandler('03bd3ddc-0842-43e2-87df-85ddf678bffb', function()
    DoScreenFadeOut(10)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
    SetTimecycleModifier('hud_def_blur')
    FreezeEntityPosition(GetPlayerPed(-1), true)
    cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1355.93,-1487.78,520.75, 300.00,0.00,0.00, 100.00, false, 0)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
end)

RegisterNetEvent('4207e885-4025-46c6-ae0e-1a5c5c955c80')
AddEventHandler('4207e885-4025-46c6-ae0e-1a5c5c955c80', function(Characters, permittedCharacters)
	print('####### RECEIVED CHARACTER INFORMATION###')
	if permittedCharacters == nil then
		permittedCharacters = 1
	end
	print('perm: ' .. permittedCharacters)
	choosetimer = 0
	IsWaiting = false
    DoScreenFadeIn(500)
    Citizen.Wait(500)
   SetNuiFocus(true, true)
    SendNUIMessage({
        action = "openui",
        characters = Characters,
		pc = permittedCharacters
    })

end)

RegisterNetEvent('1c2dc6f1-c8d8-4c39-b18f-0e1640d4196a')
AddEventHandler('1c2dc6f1-c8d8-4c39-b18f-0e1640d4196a', function(spawn, isnew,home)
	SetNuiFocus(false, false)
	print('####### STARTED SPAWN IN: scored teh goal here  1')
	DoScreenFadeIn(500)
    local pos = vector3(spawn.x,spawn.y,spawn.z)
	local bckup = vector3(1093,2673,38)
	if #(pos - vector3(0,0,0))  < 20 then
		pos = bckup
	end
	
    --SetEntityCoords(GetPlayerPed(-1), pos.x, pos.y, pos.z)

	
    Citizen.Wait(500)
	print('scored teh goal here  2')
	Citizen.CreateThread(function()
		print('COUNT DOWN TILL VOICE IS ON')
		Wait(5000)
		print('enabling voice settings')
		NetworkSetVoiceActive(true)
	end)
	if isnew == false then

		TriggerEvent('2feea93a-f3f0-497c-82c8-f3970d2d7798',spawn,isnew, home)
		print('scored teh goal here  3')
		SetTimecycleModifier('default')
		 if isnew then
			--TriggerEvent('5a966831-8ada-4a12-ae7d-c8688020ec5b')
		 end
	else
		TriggerServerEvent('ef26c3e7-e134-4cf5-98a2-36ec949884df')
		TriggerEvent('a8b5d9e2-1b5b-4ab1-a608-674a9cf651d0')
		print('####### STARTED SPAWN IN: scored teh goal here  1')
		SetTimecycleModifier('default')
		local pos = vector3(spawn.x,spawn.y,spawn.z)
		local bckup = vector3(1093,2673,38)
		if #(pos - vector3(0,0,0))  < 20 then
			pos = bckup
		end
		SetEntityCoords(GetPlayerPed(-1), pos.x, pos.y, pos.z)
		DoScreenFadeIn(500)
		Citizen.Wait(500)
		
		cam2 = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", -1355.93,-1487.78,520.75, 300.00,0.00,0.00, 100.00, false, 0)
		PointCamAtCoord(cam2, pos.x,pos.y,pos.z+200)
		SetCamActiveWithInterp(cam2, cam, 900, true, true)
		Citizen.Wait(900)
		exports.spawnmanager:setAutoSpawn(false)
		TriggerEvent('b622b051-3a8b-4113-b667-333305a005b7', source)
	
		
		 if isnew then
			--TriggerEvent('5a966831-8ada-4a12-ae7d-c8688020ec5b')
		 end
		
		cam = CreateCamWithParams("DEFAULT_SCRIPTED_CAMERA", pos.x,pos.y,pos.z+200, 300.00,0.00,0.00, 100.00, false, 0)
		PointCamAtCoord(cam, pos.x,pos.y,pos.z+2)
		SetCamActiveWithInterp(cam, cam2, 3700, true, true)
		Citizen.Wait(1000)
		PlaySoundFrontend(-1, "Zoom_Out", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
		RenderScriptCams(false, true, 500, true, true)
		PlaySoundFrontend(-1, "CAR_BIKE_WHOOSH", "MP_LOBBY_SOUNDS", 1)
		FreezeEntityPosition(GetPlayerPed(-1), false)
		Citizen.Wait(500)
		SetCamActive(cam, false)
		DestroyCam(cam, true)
		IsChoosing = false
		IsChoosing = false
		DisplayHud(true)
		DisplayRadar(true)
		TriggerEvent('2e36f88d-4f53-4c92-b71a-fe71920fb9c2',true)
		if isnew then
			exports.esx_passport:NYappear(spawn.x,spawn.y,spawn.z)
		end
	end
	IsChoosing = false
	
end)

RegisterNetEvent('f34699da-1658-4696-af62-e75caa78619a')
AddEventHandler('f34699da-1658-4696-af62-e75caa78619a', function()
    TriggerServerEvent('d977af94-bdf7-43f4-ac01-24f7580b495f')
    TriggerEvent('03bd3ddc-0842-43e2-87df-85ddf678bffb')
end)

RegisterNUICallback("CharacterChosen", function(data, cb)
	if data.charid ~= nil and tonumber(data.charid) ~= 0 then
		SendNUIMessage({
			action = "closeui",
		})
		SendNUIMessage({
			action = "closeui",
		})
		--SetNuiFocus(false,false)
		DoScreenFadeOut(500)
		TriggerServerEvent('51a59fd9-6669-4a7b-964c-50458374fbd0', data.charid, data.ischar)
		while not IsScreenFadedOut() do
			Citizen.Wait(10)
		end
		
		cb("ok")
	end
end)
RegisterNUICallback("DeleteCharacter", function(data, cb)
    --SetNuiFocus(false,false)
    DoScreenFadeOut(500)
    TriggerServerEvent('bfa72ec6-d8e3-4d27-8594-74453cdb1eb3', data.charid)
    while not IsScreenFadedOut() do
        Citizen.Wait(10)
    end
    cb("ok")
end)
