local holdingup = false
local store = ""
local blipRobbery = nil
ESX = nil

local closer = false
local ShopsListing = {}

local lastclick = 0

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

RegisterCommand("norob", function(source, args)
	TriggerServerEvent('f9c1bd71-b65a-4e38-a375-3e84be686491')
end)


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

RegisterNetEvent('1cb5e35b-98ed-4854-8fce-2c5f1e708c16')
AddEventHandler('1cb5e35b-98ed-4854-8fce-2c5f1e708c16', function(robb)
    holdingup = true
    store = robb
end)

RegisterNetEvent('b158b7dd-4e42-4f7e-8b5c-a0ad43e9e074')
AddEventHandler('b158b7dd-4e42-4f7e-8b5c-a0ad43e9e074', function()
    RemoveBlip(blipRobbery)
end)

RegisterNetEvent('d2c34a00-406d-41c1-8435-7385ad64055e')
AddEventHandler('d2c34a00-406d-41c1-8435-7385ad64055e', function(position)
    blipRobbery = AddBlipForCoord(position.x, position.y, position.z)
    SetBlipSprite(blipRobbery , 161)
    SetBlipScale(blipRobbery , 2.0)
    SetBlipColour(blipRobbery, 3)
    PulseBlip(blipRobbery)
end)

RegisterNetEvent('acd06460-aa6f-4090-8f30-4b3c1d3cbe43')
AddEventHandler('acd06460-aa6f-4090-8f30-4b3c1d3cbe43', function(robb)
    holdingup = false
    ESX.ShowNotification(_U('robbery_cancelled'))
    robbingName = ""
    incircle = false
end)

RegisterNetEvent('85fc4d50-5203-46cf-9fe6-2066fbe95477')
AddEventHandler('85fc4d50-5203-46cf-9fe6-2066fbe95477', function(storename,xx,yy,zz,ttype)
		print('trigger po call')
		if ttype ~= nil then
			if ttype == "bank" then
				PlayerCoords = GetEntityCoords(GetPlayerPed(-1), true)
				TriggerServerEvent('575a96d1-9d2b-4370-b9d6-4cf0070492da', 'police', '[PRI-1] ***Silent duress alarm Activation**** :: ' ..storename, PlayerCoords, {

					PlayerCoords = { x = xx, y = yy, z = zz },
				})
			else
				PlayerCoords = GetEntityCoords(GetPlayerPed(-1), true)
				TriggerServerEvent('575a96d1-9d2b-4370-b9d6-4cf0070492da', 'police', '***Silent alarm Activation**** :: ' ..storename, PlayerCoords, {

					PlayerCoords = { x = xx, y = yy, z = zz },
				})
			end

		else
			PlayerCoords = GetEntityCoords(GetPlayerPed(-1), true)
			TriggerServerEvent('575a96d1-9d2b-4370-b9d6-4cf0070492da', 'police', '***Silent alarm Activation**** :: ' ..storename, PlayerCoords, {

				PlayerCoords = { x = xx, y = yy, z = zz },
			})
		end

end)




RegisterNetEvent('4be7d209-589e-4de8-8955-776fc35515e4')
AddEventHandler('4be7d209-589e-4de8-8955-776fc35515e4', function(robb)
    holdingup = false
    ESX.ShowNotification(_U('robbery_complete'))
    store = ""
    incircle = false
end)


RegisterNetEvent('ebad9206-a22e-4ac2-a2d5-3b8995f29adb')
AddEventHandler('ebad9206-a22e-4ac2-a2d5-3b8995f29adb', function(source)
    timer = Stores[store].secondsRemaining
    Citizen.CreateThread(function()
        while timer > 0 do
            Citizen.Wait(0)
            Citizen.Wait(1200)
            if(timer > 0)then
                timer = timer - 1
            end
        end
    end)
    Citizen.CreateThread(function()
        while timer > 0 do
            Citizen.Wait(0)
            if holdingup  then
                drawTxt(0.66, 1.32, 1.0,1.0,0.4, _U('robbery_of') .. timer .. _U('seconds_remaining'), 255, 255, 255, 255)
            end
        end
    end)
end)

--[[
Citizen.CreateThread(function()
    for k,v in pairs(Stores)do
        local ve = v.position

        local blip = AddBlipForCoord(ve.x, ve.y, ve.z)
        SetBlipSprite(blip, 156)
        SetBlipScale(blip, 0.8)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString(_U('shop_robbery'))
        EndTextCommandSetBlipName(blip)
    end
end)--]]
incircle = false

local storec = nil

local locs = nil


Citizen.CreateThread(function()
    while true do
        local pos = GetEntityCoords(GetPlayerPed(-1), true)
		
		local zcloser = false

        for k,v in pairs(Stores)do
            local pos2 = v.position
		
			local distance = #(vector3(pos.x, pos.y, pos.z) - vector3(pos2.x, pos2.y, pos2.z))
			
            if(distance < 15.0) then
			
				storec = k
				locs = v
				zcloser = true

            end
			Wait(100)
        end
		
		if zcloser == true then
			closer = true
		else
			closer = false
			storec = nil
			locs = nil
		end

        Citizen.Wait(2000)
    end
end)

local a = nil
local b = nil

local farwarning = false
Citizen.CreateThread(function()
    while true do
        local pos = GetEntityCoords(GetPlayerPed(-1), true)

		if closer == true then
			if storec ~= nil and locs ~= nil then
				local pos2 = locs.position
				local distance =  #(vector3(pos.x, pos.y, pos.z) - vector3(pos2.x, pos2.y, pos2.z))
				if(distance < 15.0)then
					if not holdingup then
						DrawMarker(1, pos2.x, pos2.y, pos2.z - 1, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.5001, 1555, 0, 0,255, 0, 0, 0,0)

						if(distance < 1.0)then
							if (incircle == false) then
								DisplayHelpText(_U('press_to_rob') .. locs.nameofstore)
							end
							incircle = true
							if IsControlJustReleased(1, 51) then
								
								if IsPedArmed(GetPlayerPed(-1),7) and GetSelectedPedWeapon(GetPlayerPed(-1)) ~= -1569615261 then
							
									if (GetGameTimer() - 3500) > lastclick then
										lastclick = GetGameTimer()
										TriggerServerEvent('6218b367-bd0f-4997-bd07-addb1ecc9ec9', storec)
									end
								else
									ESX.ShowNotification('They turn ~o~laugh!\n~w~What are you going to do, slap them with ya pinkie?')
								end
				
							end
						elseif(distance > 1.0)then
							incircle = false
						end
					end
				end
			end
		

			if holdingup then
				local pos2 = Stores[store].position
				local distance = #(vector3(pos.x, pos.y, pos.z) - vector3(pos2.x, pos2.y, pos2.z))
				if (distance > 9.0 and distance <= 14  and farwarning == false) then
					farwarning = true
					ESX.ShowNotification('You are ~r~heading too far away~o~ go back quick!!')
					Wait(3000)
				elseif(distance > 14) then
					farwarning = false
					TriggerServerEvent('eb2da97c-9544-498e-85e9-e2bf88de3868', store)
				elseif farwarning == true then
					ESX.ShowNotification('You are ~g~safe~w~ to keep robbing!')
					farwarning = false
				end
			end
		else
			Wait(2500)
		end

        Citizen.Wait(3)
    end
end)
