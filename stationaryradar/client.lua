--===============================================--===============================================
--= stationary radars based on  https://github.com/DreanorGTA5Mods/StationaryRadar           =
--===============================================--===============================================



ESX              = nil
local PlayerData = {}

local maxwarnings = 3
local warnings = 0
local warnings_speed_thresh = 26

local radares = {
   
}

local cradares = {}

Citizen.CreateThread(function()
	while true do
		Wait(1000 * 60 * 10)
		print(collectgarbage("collect"))
		Wait(30000)
		print(collectgarbage("collect"))
	end
end)

--DrawSpotLight(x,y,z, x, y, z, 255, 255, 255, 30, 100, 1, 80, 1)
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
	
	Wait(4000)
	ESX.GetPlayerData()
	TriggerServerEvent('e7978610-a566-4ee4-9984-73d1092259ac')
	
	
	
end)

RegisterNetEvent('75bf3aa6-7d65-4364-827b-e75278ed596d')
AddEventHandler('75bf3aa6-7d65-4364-827b-e75278ed596d', function(radars)
    radares = radars
	
	for k,v in pairs(radares) do
		  blip = AddBlipForRadius(radares[k].x, radares[k].y, radares[k].x, 90.0)
		  SetBlipColour(blip,10)
		  SetBlipAlpha(blip,30)
		  SetBlipSprite(blip,3)
	 end
end)

RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(xPlayer)
    PlayerData = xPlayer
end)

RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function(job)
    PlayerData.job = job
end)




lastchecked = false

Citizen.CreateThread(function()

	
	 while #radares == 0 do
		Wait(10)
	 end
  while true do
        Wait(300)
		local closest = 3000
		local tmpradares = {}
		local player = GetPlayerPed(-1)
		for k,v in pairs(radares) do
			local coords = GetEntityCoords(player, true)
			local v1 = vector3(radares[k].x, radares[k].y, radares[k].z)
			local v2 = vector3(coords["x"], coords["y"], coords["z"])
			local dist = #(v1 - v2)
			
	
			--print(dist)
			if dist < 200.0 then

				table.insert(cradares, v)
				table.insert(tmpradares, v)
			end
			if dist < closest then
				closest = dist
			end
			
			Wait(10)
		end
		cradares = tmpradares
		if closest > 700 then
			Wait(500)
		end
	end
end)


Citizen.CreateThread(function()
	--Add Speed Blips
	
	 while #radares == 0 do
		Wait(10)
	 
	 end
	
	for k,v in pairs(radares) do
		  blip = AddBlipForRadius(radares[k].x, radares[k].y, radares[k].x, 90.0)
		  SetBlipColour(blip,10)
		  SetBlipAlpha(blip,30)
		  SetBlipSprite(blip,3)
	 end

	local lastcheckedv = 0
    while true do
        Wait(10)
		local player = GetPlayerPed(-1)
		
		local vehicle = GetVehiclePedIsIn(player, false)
		
		local closeradar = false
		local ccradares = cradares
		if vehicle ~= 0 then

			local driver = GetPedInVehicleSeat(vehicle, -1)
			
			if driver == player then

				local coords = GetEntityCoords(player, true)
				for k,v in pairs(ccradares) do
				   
					local v1 = vector3(ccradares[k].x, ccradares[k].y, ccradares[k].z)
					local v2 = vector3(coords["x"], coords["y"], coords["z"])
					
					
					local dist = #(v1 - v2)
					
					--local dist = Vdist2(radares[k].x, radares[k].y, radares[k].z, coords["x"], coords["y"], coords["z"])
					
					--print(k)
					--print(Vdist2(radares[k].x, radares[k].y, radares[k].z, coords["x"], coords["y"], coords["z"]))

					if dist < 25 then
						closeradar = true
						if ccradares[k].id ~= lastcheckedv then
							local vehclass = GetVehicleClass(vehicle)
							if vehclass == 18 then
								Wait(10000)
							elseif lastchecked == false then
								lastcheckedv = ccradares[k].id

								checkSpeed(vehicle,ccradares[k].speedlimit,ccradares[k].loc,ccradares[k].x,ccradares[k].y, coords["z"])
								
								Citizen.CreateThread(function()
									local lastv = lastcheckedv
									Wait(5000)
									if lastcheckedv == lastv then
										lastcheckedv = 0
									end
								end)
							end
						end
					elseif dist < 250 then
						closeradar = true
					end
				end
			else
				Wait(1000)
			end
		else
			Wait(1000)
		end
		if closeradar  == false then
			Wait(400)
		end
		
		if #ccradares == 0 then
			Wait(1000)
		end
    end
end)

function checkSpeed(vehicle,speedlimit,loc,x,y,z)
	if lastchecked == false then
		lastchecked = true
		
		local plate = GetVehicleNumberPlateText(vehicle)
		local speed = GetEntitySpeed(vehicle)
		local maxspeed = speedlimit
		local mphspeed = math.ceil(speed*3.6)
		local fineamount = nil
		local finelevel = nil
		
		local truespeed = mphspeed - maxspeed
		
		if truespeed > 12 and driver == pP then
			
			TriggerServerEvent('feb19da4-a247-42ff-9802-fe29ef5b3c70',x,y,z)
			TriggerServerEvent('f1db4fc7-ae85-41a8-a5b9-f6198586ad90', truespeed)
			if truespeed >= 12 and truespeed <= 21 then
				fineamount = Config.Fine
				finelevel = 'Exceed speed limit by 10-20km/h'
			elseif truespeed >= 22 and truespeed <= 31 then
				fineamount = Config.Fine2
				finelevel = 'Exceed speed limit by 20-30km/h'
			elseif truespeed >= 32 and truespeed <= 46 then
				fineamount = Config.Fine3
				finelevel = 'Exceed speed limit by 30-45km/h'
			elseif truespeed >= 47 and truespeed <= 115 then
				fineamount = Config.Fine4
				finelevel = 'Exceed speed limit by 45km/h Plus'
			elseif truespeed >= 116 then
				fineamount = Config.Fine5
				finelevel = 'Exceed Speed limit by 45km/h Plus'
			end
			
			if truespeed < warnings_speed_thresh and warnings < maxwarnings then
				fineamount = 0
				warnings = warnings + 1
			end
			
			
			
			Citizen.Wait(500)
			
			if fineamount ~= nil then
				if fineamount > 0 then
							exports.pNotify:SetQueueMax("left", 1)
					exports.pNotify:SendNotification({
						text = '<br><center><img style="-webkit-user-select: none" src="nui://pNotify/html/vicpol.png" /></center><center><h1><center>Victoria Police</h1><h2>Traffic Camera Office</h2></center>' .. "</br>You've been issued an <strong>infringement notice</strong> for speeding!<br/><br/><strong>Location: " .. loc .. "</strong><br/>Plate Number: " .. plate .. '</br><br/><font color="orange">Penalty: $' .. fineamount .. '</font></br><br/><font color="lightblue">Offence: ' .. finelevel .. "</font><br/></br>Speed Limit: " .. maxspeed .. "</br>Your Speed: " ..mphspeed .. '</br><font color="red"><strong>ALLEGED SPEED: ' .. (mphspeed -2) .. '</strong></font>' ,
						type = "error",
						timeout = 8500,
						layout = "centerLeft",
						queue = "left"
					})
				else
					exports.pNotify:SetQueueMax("left", 1)
					exports.pNotify:SendNotification({
						text = '<br><center><img style="-webkit-user-select: none" src="nui://pNotify/html/vicpol.png" /></center><center><h1><center>Victoria Police</h1><h2>Traffic Camera Office</h2></center>' .. "</br>You've been issued an <strong>official warning</strong> for speeding.<br/><br/><strong>Location: " .. loc .. "</strong><br/>Plate Number: " .. plate .. '</br><br/><font color="orange">Penalty: $' .. fineamount .. '</font><br/></br><font color="lightblue">Offence: ' .. finelevel .. "</font><br/></br>Speed Limit: " .. maxspeed .. "</br>Your Speed: " ..mphspeed .. '</br><font color="red"><strong>ALLEGED SPEED: ' .. (mphspeed -2) .. '</strong></font>' ,
						type = "error",
						timeout = 8500,
						layout = "centerLeft",
						queue = "left"
					})
				end
			end
		end
		
		local holdtimer = 1200
		
		if truespeed > 100 then
			holdtimer = 800
		end
		
		--reset timer
		Citizen.CreateThread(function()
			while true do
				Wait(holdtimer)
				lastchecked = false
			end

		end)
	end
end

RegisterNetEvent('d51ae5fb-c538-4797-9816-7d7ad399d46d')
AddEventHandler('d51ae5fb-c538-4797-9816-7d7ad399d46d', function(x,y,z) 

flash1(x,y,z)
flash2(x,y,z)

end)

local flashon1 = false
local flashon2 = false

function flash1(x,y,z)
	
	flashon1 = true
	Citizen.CreateThread(function()

			Wait(50)
			flashon1 = false


	end)
	Citizen.CreateThread(function()
	
	
		while flashon1 == true do
			--DrawSpotLightWithShadow(x,y,(z +100), x, y, z, 255, 255, 255, 600.0, 10.0, 1.0, 100.0, 200.0, 20.0,1.0)
			DrawSpotLightWithShadow(x,y,(z +2), x, y, z-20, 255, 255, 255, 60.0, 500.0, 1.0, 100.0, 1.0, 1.0)
			DrawSpotLightWithShadow(x,y,(z -2), x-5, y-5, z-20, 255, 255, 255, 60.0, 500.0, 1.0, 100.0, 1.0, 2.0)
			Wait(0)
		end
	end)
end

function flash2(x,y,z)
	
	Wait(50)
	flashon2 = true
	Citizen.CreateThread(function()

			Wait(50)
			flashon2 = false

	end)
	Citizen.CreateThread(function()
	
		while flashon2 == true do
			DrawSpotLightWithShadow(x,y,(z +2), x, y, z-20, 255, 255, 255, 60.0, 500.0, 1.0, 100.0, 1.0, 1.0)
			DrawSpotLightWithShadow(x,y,(z -2), x-5, y-5, z-20, 255, 255, 255, 60.0, 500.0, 1.0, 100.0, 1.0, 2.0)
			--DrawSpotLightWithShadow(x,y,(z +100), x, y, z, 255, 255, 255, 600.0, 10.0, 1.0, 100.0, 200.0, 20.0,1.0)
			--DrawSpotLightWithShadow(x,y,(z +10), x -4, y -4, z, 255, 255, 255, 1000.0, 50.0, 1.0, 60.0, 60.0, 20.0)
			Wait(0)
		end
	end)
end
