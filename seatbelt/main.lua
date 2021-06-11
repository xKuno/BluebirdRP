local isUiOpen = false 
local speedBuffer  = {}
local velBuffer    = {}
local beltOn       = false
local wasInCar     = false

local PlayerData  = {}

local server_list = {}

local lastclick = GetGameTimer()

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Wait(100)
	PlayerData = ESX.GetPlayerData()
	
end)


RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(xPlayer)
	PlayerData = xPlayer
end)



--beltOn = not beltOn 
RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function(job)
	PlayerData = ESX.GetPlayerData()
end)

--[[
RegisterNetEvent('ad6ce06c-44fb-4df6-8743-559fcbfc565a')
AddEventHandler('ad6ce06c-44fb-4df6-8743-559fcbfc565a', function(job)
	beltOn = not beltOn
	if beltOn then 
	  TriggerEvent('61329ade-cca4-49b0-ae5e-47119f350c2d', {text = "Seatbelt On", type = "success", timeout = 1400, layout = "centerLeft"})
		TriggerServerEvent('67a583d5-7a25-4284-8f41-6c5f9e9a4bf7',true)
	  SendNUIMessage({
		displayWindow = 'false'
		})
	  isUiOpen = true 
	else 
	  TriggerEvent('61329ade-cca4-49b0-ae5e-47119f350c2d', {text = "Seatbelt Off", type = "error", timeout = 1400, layout = "centerLeft"}) 
		TriggerServerEvent('67a583d5-7a25-4284-8f41-6c5f9e9a4bf7',false)
	  SendNUIMessage({
		 displayWindow = 'true'
		 })
	  isUiOpen = true  
	end
	
end)--]]


IsCar = function(veh)
        local vc = GetVehicleClass(veh)
        return (vc >= 0 and vc <= 7) or (vc >= 9 and vc <= 12) or (vc >= 17 and vc <= 20)
        end 

Fwv = function (entity)
        local hr = GetEntityHeading(entity) + 90.0
        if hr < 0.0 then hr = 360.0 + hr end
        hr = hr * 0.0174533
        return { x = math.cos(hr) * 2.0, y = math.sin(hr) * 2.0 }
      end
	  
	  
RegisterNetEvent('3673baac-8c02-4153-b9aa-4a707e9ef9a8')
AddEventHandler('3673baac-8c02-4153-b9aa-4a707e9ef9a8', function(seattable)
	server_list = seattable
end)	

RegisterNetEvent('1a0e4fd6-5893-4de1-8d4d-e28fc75d726f')
AddEventHandler('1a0e4fd6-5893-4de1-8d4d-e28fc75d726f', function(source, change)
	--print("source")
	--print(source)
	if change == true then
		
		server_list[source] = true
	else
		server_list[source] = false
		
	end
end)	

--local color = {r = 136 , g = 11, b =17}

local color = {r = 255 , g = 255, b =255}
--[[
Citizen.CreateThread(function()

	--GetClosestPlayer
	while  ESX == nil do
		Wait(5000)
	end
	while  PlayerData.job == nil do
		Wait(5000)
	end
	while true do
		Wait(20)
		
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		--if  PlayerData.job.name ~= 'police' then
			--Wait(5000)

		if closestDistance > 500 then
			Wait(2000)
		elseif closestDistance > 20 then
			Wait(500)

		else
			
			local player = GetPlayerPed(-1)
			--local players = GetPlayers()
			local coords = GetEntityCoords(player)
			local players = ESX.Game.GetPlayersInArea(coords,12)
			--table.insert(players, GetPlayerPed(-1))
			for index,value in ipairs(players) do
				local target = GetPlayerPed(value)
				if(target ~= player) then
					
					local  vehicle = GetVehiclePedIsIn(target, false)
	
					if vehicle ~= 0 then
						--print(index)

						local pserverid = GetPlayerServerId(value)
						--print('serverid')
						--print(pserverid)

						 if(not server_list[pserverid]) and (GetEntitySpeed(vehicle) * 3.6) < 120 	then  
									--Display Not wearing seatbelt
									--print('printing a')
								if target == GetPedInVehicleSeat(vehicle,-1) then
									local pos, x, y, z = GetPedBoneCoords(target, 0xfcd9, 0.11, 0, 0)
									DrawText3D(pos.x, pos.y, (pos.z + .05), '[----]', color)
								elseif target ==  GetPedInVehicleSeat(vehicle,0) then
									local pos, x, y, z = GetPedBoneCoords(target, 0x29d2, 0.11, 0, 0)
									DrawText3D(pos.x, pos.y, (pos.z + .05), '[----]', color)
								elseif target == GetPedInVehicleSeat(vehicle,1) then
									local pos, x, y, z = GetPedBoneCoords(target, 0xfcd9, 0.11, 0, 0)
									DrawText3D(pos.x, pos.y, (pos.z + .05), '[----]', color)
								elseif target ==  GetPedInVehicleSeat(vehicle,2) then
									local pos, x, y, z = GetPedBoneCoords(target, 0x29d2, 0.11, 0, 0)
									DrawText3D(pos.x, pos.y, (pos.z + .05), '[----]', color)
								
								else
									local posa, xa, ya, za = GetPedBoneCoords(target, 0xfcd9, 0.11, 0, 0)
									DrawText3D(posa.x, posa.y, (posa.z + .05), '[----]', color)
									local pos, x, y, z = GetPedBoneCoords(target, 0x29d2, 0.11, 0, 0)
									DrawText3D(pos.x, pos.y, (pos.z + .05), '[----]', color)
								end
								
						end
					end
				end
			end
		end
	end


end)
--]]

function DrawText3D(x,y,z, text, color) -- some useful function, use it if you want!
  local onScreen,_x,_y=World3dToScreen2d(x,y,z)
  local px,py,pz=table.unpack(GetGameplayCamCoords())
  local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)

  local scale = (1/dist)*2
  local fov = (1/GetGameplayCamFov())*100
  local scale = scale*fov

  if onScreen then
      SetTextScale(0.0*scale, 0.20*scale)
      SetTextFont(0)
      SetTextProportional(1)
      -- SetTextScale(0.0, 0.55)
      SetTextColour(color.r, color.b, color.g, 255)
      SetTextDropshadow(0, 0, 0, 0, 255)
      SetTextEdge(2, 0, 0, 0, 150)
      SetTextDropShadow()
      SetTextOutline()
      SetTextEntry("STRING")
      SetTextCentre(1)
      AddTextComponentString(text)
      DrawText(_x,_y)
  end
end

--[[
Citizen.CreateThread(function()
	Citizen.Wait(3000)
	TriggerServerEvent('11286720-762e-4628-ba99-f10631ca4727')
 end) 
 
Citizen.CreateThread(function()
  while true do
  Citizen.Wait(1)
  
    local ped = GetPlayerPed(-1)
    local car = GetVehiclePedIsIn(ped)
    
    if car ~= 0 and (wasInCar or IsCar(car)) then
      wasInCar = true
             if isUiOpen == false and not IsPlayerDead(PlayerId()) then
                SendNUIMessage({
            	   displayWindow = 'true'
            	   })
                isUiOpen = true 			
            end

      if beltOn then DisableControlAction(0, 75) end

      speedBuffer[2] = speedBuffer[1]
      speedBuffer[1] = GetEntitySpeed(car)
--	  if speedBuffer[2] ~= nil then
--		print ('2: ' .. speedBuffer[2] .. ' 1: ' .. speedBuffer[1]   .. '  P1 '   ..  (speedBuffer[2] - speedBuffer[1]) .. ' P2 ' .. (speedBuffer[1] * 0.255)   )
--      end
      if speedBuffer[2] ~= nil 
         and not beltOn
         and GetEntitySpeedVector(car, true).y > 1.0  
         and speedBuffer[1] > 14.75 
         and (speedBuffer[2] - speedBuffer[1]) > (speedBuffer[1] * 0.254) then  --255
         
		
		 if (GetEntitySpeed(car) * 3.6) < 65 then
		
			Citizen.CreateThread(function()
				Citizen.Wait(1500)
				local ht = GetEntityHealth(ped) - 40
				SetEntityHealth(ped, ht)
			end)
		 
		 elseif (GetEntitySpeed(car) * 3.6) > 75 then
			Citizen.CreateThread(function()
				Citizen.Wait(1500)
			local ht = GetEntityHealth(ped) - 200
			SetEntityHealth(ped, ht)
			end)
		
		 end
        local co = GetEntityCoords(ped)
        local fw = Fwv(ped)
        SetEntityCoords(ped, co.x + fw.x, co.y + fw.y, co.z - 0.47, true, true, true)
        SetEntityVelocity(ped, velBuffer[2].x, velBuffer[2].y, velBuffer[2].z)
        Citizen.Wait(1)
        SetPedToRagdoll(ped, 1000, 1000, 0, 0, 0, 0)
      end
        
      velBuffer[2] = velBuffer[1]
      velBuffer[1] = GetEntityVelocity(car)
        
      if IsControlJustReleased(0, 289) and GetLastInputMethod(2) then
		if lastclick < GetGameTimer() - 1500 then
			lastclick = GetGameTimer()
			beltOn = not beltOn 
			if beltOn then 
			  TriggerEvent('61329ade-cca4-49b0-ae5e-47119f350c2d', {text = "Seatbelt On", type = "success", timeout = 1400, layout = "centerLeft"})
				--TriggerServerEvent('67a583d5-7a25-4284-8f41-6c5f9e9a4bf7',true)
			  SendNUIMessage({
				displayWindow = 'false'
				})
			  isUiOpen = true 
			else 
			  TriggerEvent('61329ade-cca4-49b0-ae5e-47119f350c2d', {text = "Seatbelt Off", type = "error", timeout = 1400, layout = "centerLeft"}) 
				--TriggerServerEvent('67a583d5-7a25-4284-8f41-6c5f9e9a4bf7',false)
			  SendNUIMessage({
				 displayWindow = 'true'
				 })
			  isUiOpen = true  
			end
		end
      end
      
    elseif wasInCar then
	
	
      wasInCar = false
      beltOn = false
	  --TriggerServerEvent('67a583d5-7a25-4284-8f41-6c5f9e9a4bf7',false)
      speedBuffer[1], speedBuffer[2] = 0.0, 0.0
             if isUiOpen == true and not IsPlayerDead(PlayerId()) then
                SendNUIMessage({
            	   displayWindow = 'false'
            	   })
                isUiOpen = false 
            end
    end
    
  end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(100)
        if IsPlayerDead(PlayerId()) and isUiOpen == true then
            SendNUIMessage({
                    displayWindow = 'false'
               })
            isUiOpen = false
        end    

    end
end)--]]


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(2000)
        if IsPedInAnyVehicle(GetPlayerPed(-1)) == false and isUiOpen == true then
            SendNUIMessage({
                    displayWindow = 'false'
               })
            isUiOpen = false
        end    
    end
end)

RegisterNetEvent('68c70830-177a-40e1-b1a0-c604e9ffdd02')
AddEventHandler('68c70830-177a-40e1-b1a0-c604e9ffdd02', function(advice)

		if advice == true then
			SendNUIMessage({
					displayWindow = 'false'
			   })
				isUiOpen = false
		else
				SendNUIMessage({
				 displayWindow = 'true'
				 })
			  isUiOpen = true  
		end
end)




function GetPlayers()
    local players = {}

    for _, player in ipairs(GetActivePlayers()) do
        
            table.insert(players, player)
     
    end

    return players
end
