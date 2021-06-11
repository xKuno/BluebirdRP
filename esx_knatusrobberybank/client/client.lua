local startedrobbery = false

local holdingup = false
local hackholdingup = false
local bombholdingup = false
local bank = ""
local savedbank = {}
local secondsRemaining = 0
local dooropen = false
local platingbomb = false
local platingbombtime = 20
local blipRobbery = nil

local lastclick = 0

globalcoords = nil
globalrotation = nil
globalDoortype = nil
globalbombcoords = nil
globalbombrotation = nil
globalbombDoortype = nil

local closeby = false



ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function drawTxt(x,y ,width,height,scale, text, r,g,b,a, outline)
    SetTextFont(0)
    SetTextProportional(0)
    SetTextScale(scale, scale)
    SetTextColour(r, g, b, a)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(1, 0, 0, 0, 255)
    SetTextDropShadow()
    if(outline)then
	    SetTextOutline()
	end
    SetTextEntry("STRING")
    AddTextComponentString(text)
    DrawText(x - width/2, y - height/2 + 0.005)
end

RegisterNetEvent('ad464951-a701-4871-b057-aa85a1c1411f')
AddEventHandler('ad464951-a701-4871-b057-aa85a1c1411f', function(robb)
	holdingup = true
	startedrobbery = true
	bank = robb
	secondsRemaining = 300
end)

RegisterNetEvent('4883a34e-4175-43a5-b28a-825fae41e1ec')
AddEventHandler('4883a34e-4175-43a5-b28a-825fae41e1ec', function(robb, thisbank)
	startedrobbery = true
	hackholdingup = true
	TriggerEvent('0ee1b37e-00fa-484d-b9f2-ce9381968ff7')
	TriggerEvent('1ba533d0-c40c-403d-9a1c-1de79d7174d3',7,150, opendoors)
	savedbank = thisbank
	bank = robb
	secondsRemaining = 300
end)

RegisterNetEvent('1df1b2a2-466e-4100-bbd6-cbb39c2481d8')
AddEventHandler('1df1b2a2-466e-4100-bbd6-cbb39c2481d8', function(robb, thisbank)
	secondsRemaining = 20
	bombholdingup = true
	startedrobbery = true
	savedbank = thisbank
	bank = robb
	plantBombAnimation()
	secondsRemaining = 20
end)



function opendoors(success, timeremaining)
	if success then
		print('Success with '..timeremaining..'s remaining.')
		TriggerEvent('aedcafd6-57b5-4322-ad5b-ed0db6ba4cce')
		TriggerEvent('825b1c3d-5282-4d2d-ba40-9687d16a60b3')

	else
		hackholdingup = false
		ESX.ShowNotification(_U('hack_failed'))
		print('Failure')
		TriggerEvent('aedcafd6-57b5-4322-ad5b-ed0db6ba4cce')
		secondsRemaining = 0
		incircle = false
	end
end

RegisterNetEvent('3742d0d6-e521-4401-9374-4d1b621537d8')
AddEventHandler('3742d0d6-e521-4401-9374-4d1b621537d8', function()
    RemoveBlip(blipRobbery)
end)

RegisterNetEvent('7ce9fdda-fe4f-40be-8040-f6a0fed423cc')
AddEventHandler('7ce9fdda-fe4f-40be-8040-f6a0fed423cc', function(position)
    blipRobbery = AddBlipForCoord(position.x, position.y, position.z)
    SetBlipSprite(blipRobbery , 161)
    SetBlipScale(blipRobbery , 2.0)
    SetBlipColour(blipRobbery, 3)
    PulseBlip(blipRobbery)
end)

RegisterNetEvent('0645dd7e-44b3-4bd7-bf4c-b8bc53644f5b')
AddEventHandler('0645dd7e-44b3-4bd7-bf4c-b8bc53644f5b', function(robb)
	holdingup = false
	bombholdingup = false
	startedrobbery = false
	ESX.ShowNotification(_U('robbery_cancelled'))
	robbingName = ""
	secondsRemaining = 0
	incircle = false
end)

RegisterNetEvent('172b7f37-1fc2-4978-afe8-09aa98092c77')
AddEventHandler('172b7f37-1fc2-4978-afe8-09aa98092c77', function(robb)
	holdingup = false
	startedrobbery = false
	ESX.ShowNotification(_U('robbery_cancelled'))
	robbingName = ""
	secondsRemaining = 0
	incircle = false
end)

RegisterNetEvent('28f5aaa8-e36d-40dc-8bc2-ba7fa1d06d6b')
AddEventHandler('28f5aaa8-e36d-40dc-8bc2-ba7fa1d06d6b', function()
	dooropen = false
end)

RegisterNetEvent('826a4643-35a1-4cdf-9de2-61d6847fc3c4')
AddEventHandler('826a4643-35a1-4cdf-9de2-61d6847fc3c4', function(robb)
	holdingup = false
	
	ESX.ShowNotification(_U('robbery_complete') .. Banks[bank].reward)
	bank = ""
	TriggerEvent('eff21ad7-ab3e-404e-8a53-1e0d3bb836a3')
	TriggerServerEvent('991e24d4-5d99-44b2-97b6-fd22e9063ab9')
	TriggerEvent('f82866a4-fb67-4b57-9279-0174915e692e')
	secondsRemaining = 0
	dooropen = false
	incircle = false
	startedrobbery = false
end)

RegisterNetEvent('825b1c3d-5282-4d2d-ba40-9687d16a60b3')
AddEventHandler('825b1c3d-5282-4d2d-ba40-9687d16a60b3', function()
	hackholdingup = false
	--TriggerServerEvent('221c1b4a-2f68-4660-95e9-ae529ef88090', 79, true)
	startedrobbery = true
	ESX.ShowNotification(_U('hack_complete'))

	TriggerServerEvent('esx_holdupbank:opendoors', Banks[bank].hackposition.x, Banks[bank].hackposition.y, Banks[bank].hackposition.z, Banks[bank].doortype)
	TriggerEvent(   'esx_doorlock:opennear')
	bank = ""

	secondsRemaining = 0
	incircle = false
end)

RegisterNetEvent('0ad0de31-4f76-40e3-be0b-cb0dd9aa6e42')
AddEventHandler('0ad0de31-4f76-40e3-be0b-cb0dd9aa6e42', function(bank)
	bombholdingup = false
	startedrobbery = true
	ESX.ShowNotification(_U('bombplanted_run'))
	TriggerServerEvent('9d9a7aa3-4432-4a44-95b7-a7157b565a25', bank.bombposition.x,  bank.bombposition.y, bank.bombposition.z, bank.bombdoortype)

	incircle = false
end)


RegisterNetEvent('f25ffc14-0c2f-4264-b575-13132c373235')
AddEventHandler('f25ffc14-0c2f-4264-b575-13132c373235', function(storename,xx,yy,zz)
		print('trigger po call')
		PlayerCoords = GetEntityCoords(GetPlayerPed(-1), true)
		TriggerServerEvent('575a96d1-9d2b-4370-b9d6-4cf0070492da', 'police', '[PRI-1] ***Audible Bank Alarm**** :: ' ..storename, PlayerCoords, {

			PlayerCoords = { x = xx, y = yy, z = zz },
		})
end)


RegisterNetEvent('4b4d2581-4a96-4c91-8615-0acc948f3bb5')
AddEventHandler('4b4d2581-4a96-4c91-8615-0acc948f3bb5', function(x,y,z,doortype)
	local coords = {x=x,y=y,z=z}
	local obs, distance = ESX.Game.GetClosestObject(doortype, coords)
	startedrobbery = true
    --AddExplosion( bank.bombposition.x,  bank.bombposition.y, bank.bombposition.z , 0, 0.5, 1, 0, 1065353216, 0)
    AddExplosion( x,  y, z , 0, 0.5, 1, 0, 1065353216, 0)
    AddExplosion( x,  y, z , 0, 0.5, 1, 0, 1065353216, 0)
	AddExplosion( x,  y, z , 0, 0.5, 1, 0, 1065353216, 0)
   -- AddExplosion( bank.bombposition.x,  bank.bombposition.y, bank.bombposition.z , 0, 0.5, 1, 0, 1065353216, 0)

	local rotation = GetEntityHeading(obs) + 47.2869
	SetEntityHeading(obs,rotation)
	globalbombcoords = coords
	globalbombrotation = rotation
	globalbombDoortype = doortype
	Citizen.CreateThread(function()
		while dooropen do
			Wait(2000)
			local obs, distance = ESX.Game.GetClosestObject( globalbombcoords,globalbombDoortype)
			SetEntityHeading(obs, globalbombrotation)
			--DeleteObject(obs)
			Citizen.Wait(0);
		end
	end)
end)


RegisterNetEvent('a881df90-0205-4a1a-8d4d-218dd7f18d85')
AddEventHandler('a881df90-0205-4a1a-8d4d-218dd7f18d85', function(x,y,z,doortype)
	dooropen = true;

	local coords = {x=x,y=y,z=z}
	local obs, distance = ESX.Game.GetClosestObject('hei_v_ilev_bk_gate2_pris', coords)

	local pos = GetEntityCoords(obs);


	local rotation = GetEntityHeading(obs) + 70
	globalcoords = coords
	globalrotation = rotation
	globalDoortype = doortype
	Citizen.CreateThread(function()
	while dooropen do
		Wait(2000)
		local obs, distance = ESX.Game.GetClosestObject(globalDoortype, globalcoords)
		
		SetEntityHeading(obs, globalrotation)
	end
	end)
end)


RegisterNetEvent('2db05016-dd2c-45e9-8f95-a35574419c91')
AddEventHandler('2db05016-dd2c-45e9-8f95-a35574419c91', function(bank)
	SetEntityCoordsNoOffset(GetPlayerPed(-1), bank.hackposition.x , bank.hackposition.y, bank.hackposition.z, 0, 0, 1)
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if holdingup or hackholdingup or bombholdingup then
			if holdingup then
				Citizen.Wait(1000)
				if(secondsRemaining > 0)then
					secondsRemaining = secondsRemaining - 1
				end
			end
			if hackholdingup then
				Citizen.Wait(1000)
				if(secondsRemaining > 0)then
					secondsRemaining = secondsRemaining - 1
				end
			end
			if bombholdingup then
				Citizen.Wait(1000)
				if(secondsRemaining > 0)then
					secondsRemaining = secondsRemaining - 1
				end
			end
		else
			Wait(2000)
		end
		
	end
end)
--[[
Citizen.CreateThread(function()
	for k,v in pairs(Banks)do
		local ve = v.position

		local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
		SetBlipSprite(blip, 255)--156
		SetBlipScale(blip, 0.8)
		SetBlipColour(blip, 75)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('bank_robbery'))
		EndTextCommandSetBlipName(blip)
	end
end)--]]
incircle = false

Citizen.CreateThread(function()
	while true do
		if closeby == true and startedrobbery == true then
			local pos = GetEntityCoords(GetPlayerPed(-1), true)
			local inplace = false
			for k,v in pairs(Banks)do
				local pos2 = v.position
				local pos3 = #(pos - pos2)
				if(pos3 < 15.0)then
					inplace = true
					if not holdingup then
						DrawMarker(1, v.position.x, v.position.y, v.position.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 0, 0,255, 0, 0, 0,0)

						if(pos3 < 1.0)then
							if (incircle == false) then
								DisplayHelpText(_U('press_to_rob') .. v.nameofbank)
							end
							incircle = true
							if IsControlJustReleased(1, 51) then
								if (GetGameTimer() - 2500) > lastclick then
									lastclick = GetGameTimer()
									TriggerServerEvent('3509de02-3762-426c-a4cb-f32a95d55c27', k)
								end
							end
						elseif(pos3 > 1.0)then
							incircle = false
						end
					end
				end
			end
			if inplace == false then
				Wait(1500)
			end

			if holdingup then

				drawTxt(0.66, 1.44, 1.0,1.0,0.4, _U('robbery_of') .. secondsRemaining .. _U('seconds_remaining'), 255, 255, 255, 255)
				DisplayHelpText(_U('press_to_cancel'))

				local pos2 = Banks[bank].position


				if IsControlJustReleased(1, 51) then
					TriggerServerEvent('b3010b44-a4da-437b-a1b2-7e090d4e9e98', bank)
					TriggerEvent('f82866a4-fb67-4b57-9279-0174915e692e')
				end

				if(Vdist2(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 7.5)then
					TriggerServerEvent('b3010b44-a4da-437b-a1b2-7e090d4e9e98', bank)
				end
			end
			
		else
			Wait(2000)
		end

		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
	while true do
		local pos = GetEntityCoords(GetPlayerPed(-1), true)
		local isnear = false
		for k,v in pairs(Banks)do
			local pos2 = v.hackposition
			local distance = #(pos - pos2)
			if (distance < 30.0) then
				isnear = true
			end
			if (distance < 15.0)then
				if not hackholdingup then
					DrawMarker(1, v.hackposition.x, v.hackposition.y, v.hackposition.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 0, 0,255, 0, 0, 0,0)

					if(Vdist2(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) < 1.0)then
						if (incircle == false) then
							DisplayHelpText(_U('press_to_hack') .. v.nameofbank)
						end
						incircle = true
						if IsControlJustReleased(1, 51) then
							if (GetGameTimer() - 2500) > lastclick then
								lastclick = GetGameTimer()
								TriggerServerEvent('b7bb7d3b-6e00-41e9-9774-acc7f6b7b6db', k)
							end
						end
					elseif(Vdist2(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 1.0)then
						incircle = false
					end
				end
			end
		end
		closeby = isnear
		if closeby == false then
			Wait(2000)
		end

		if hackholdingup then

			drawTxt(0.66, 1.44, 1.0,1.0,0.4, _U('hack_of') .. secondsRemaining .. _U('seconds_remaining'), 255, 255, 255, 255)

			local pos2 = Banks[bank].hackposition

			if(Vdist2(pos.x, pos.y, pos.z, pos2.x, pos2.y, pos2.z) > 7.5)then
				TriggerServerEvent('80e12968-54a3-44c5-abcd-43ae1b0f6672', bank)
			end
		end

		Citizen.Wait(0)
	end
end)


Citizen.CreateThread(function()
	while true do
		if closeby == true and startedrobbery == true then
		
			local pos = GetEntityCoords(GetPlayerPed(-1), true)

			for k,v in pairs(Banks)do
				local pos2 = v.bombposition
				if (pos2 ~= nil) then
					if(#(pos - pos2) < 15.0)then
						if not bombholdingup then
							DrawMarker(1, v.bombposition.x, v.bombposition.y, v.bombposition.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 0, 0,255, 0, 0, 0,0)

							if(#(pos - pos2) < 1.0)then
								if (incircle == false) then
									DisplayHelpText(_U('press_to_bomb') .. v.nameofbank)
								end
								incircle = true
								if IsControlJustReleased(1, 51) then
									if (GetGameTimer() - 2500) > lastclick then
										lastclick = GetGameTimer()
										TriggerServerEvent('27d85901-7aa8-481e-8d94-c16eef1d2460', k)
									end
								end
							elseif(#(pos - pos2) > 1.0)then
								incircle = false
							end
						end
					end
				end
			end

			if bombholdingup then

				drawTxt(0.66, 1.44, 1.0,1.0,0.4, _U('bomb_of') .. secondsRemaining .. _U('seconds_remaining'), 255, 255, 255, 255)
				DisplayHelpText(_U('press_to_cancel'))

				local pos2 = Banks[bank].bombposition


				if IsControlJustReleased(1, 51) then
					TriggerServerEvent('b3010b44-a4da-437b-a1b2-7e090d4e9e98', bank)
				end

				if(#(pos - pos2) > 7.5)then
					TriggerServerEvent('b3010b44-a4da-437b-a1b2-7e090d4e9e98', bank)
				end
			end
		else
			Wait(2000)
		end
		Citizen.Wait(0)
	end
end)
function plantBombAnimation()
	local playerPed = GetPlayerPed(-1)

	Citizen.CreateThread(function()
		platingbomb = true
			while platingbomb == true do
				Wait(900)

				TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_KNEEL", 0, true)

				if secondsRemaining <= 1 then
					platingbomb = false
					ClearPedTasksImmediately(PlayerPedId())
					return
				end
				Citizen.Wait(0)
			end

	end)
end