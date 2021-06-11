ESX              = nil
local PlayerData = {}
local inVeh = false
local distance = 0
local vehPlate
local oldvehicle = 0
local newvehicle = -1
local tracking = false
local wasdriver = false
local enforcement_car = true
local lastchange = 0

local x = 0.01135
local y = 0.002
hasKM = 0
showKM = 0
hasOIL = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
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

RegisterNetEvent('2e51d9ee-3dad-4e46-86a7-da8293365ed2')
AddEventHandler('2e51d9ee-3dad-4e46-86a7-da8293365ed2', function(enforcement)
	if enforcement == 1 then
		enforcement_car = true
	else
		enforcement_car = false
	end
end)




function GetVehicleMileage()
	return ' ODO ' .. round(showKM, 1)
end

function DrawAdvancedText(x,y ,w,h,sc, text, r,g,b,a,font,jus)
		SetTextFont(font)
		SetTextProportional(0)
		SetTextScale(sc, sc)
		N_0x4e096588b13ffeca(jus)
		SetTextColour(r, g, b, a)
		SetTextDropShadow(0, 0, 0, 0,255)
		SetTextEdge(1, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		AddTextComponentString(text)
		DrawText(x - 0.1+w, y - 0.02+h)
end

-- print("Script starting...")
Citizen.CreateThread(function()
	  while true do
		Wait(0)
		if tracking == true then
			local oilvalue = hasOIL
			if oilvalue  <= 0.5 then
			   if enforcement_car == true then
					if GetEntitySpeed(oldvehicle) > 15 then
						SetVehicleForwardSpeed(oldvehicle,GetEntitySpeed(oldvehicle)*0.95)
					end
					SetVehicleEngineTorqueMultiplier(oldvehicle, 0.20)
				end
			else
				Wait(1000)
			end
		else
			Wait(2000)
		end
	 end
end)


Citizen.CreateThread(function()

  Citizen.Wait(math.random(300,10000)) -- manages server requests at once
  while true do
		Citizen.Wait(0)
		local ppid = PlayerPedId()
		if IsPedInAnyVehicle(ppid, false) and not inVeh then
			local veh = GetVehiclePedIsIn(ppid,false)
			local driver = GetPedInVehicleSeat(veh, -1)
			if oldvehicle == newvehicle and driver == ppid then
				wasdriver = true
				ProcessMilage(veh, true)
			elseif driver == ppid then
				oldvehicle = veh--GetVehiclePedIsIn(ppid,false)
				if NetworkGetEntityIsNetworked(oldvehicle) then
					ESX.TriggerServerCallback('77956617-7ad0-408c-8c18-5b0db734c4de', function(hasmk)
						print(json.encode(hasmk))
						hasKM = hasmk.km
				
						wasdriver = true
						newvehicle = oldvehicle
						tracking = true
						if hasmk.oil < 0.1 then
							haskmk.oil = 0.6
						end
						hasOIL = hasmk.oil
						SetVehicleOilLevel(oldvehicle,hasmk.oil)
						if hasmk.veh_tuning then
							
							pcall(function() exports["tuner"].setVehDataNS(newvehicle,newvehicle,hasmk.veh_tuning) end)
						end
						
						local fu = hasmk.fuel
						local fp = hasmk.carplate

						exports.esx_lf:SetFuel(newvehicle,tonumber(fu) + 0.0)
						SetVehicleFuelLevel(newvehicle, tonumber(fu) + 0.0)
						--TriggerEvent(  'LegacyFuel:ReturnFuelFromServerTableC',tostring(fp),tonumber(fu))
		
						ProcessMilage(veh,true)
						end, GetVehicleNumberPlateText(oldvehicle),VehToNet(oldvehicle))
				else
					if GetEntitySpeed(oldvehicle) > 3.0 then
						ESX.ShowNotification('~o~Caution: This vehicle is not visible to anyone. ~w~You may need to get it out of your garage again.')
						Wait(2000)
					end
				end
				Wait(1000)
			end
		
			Citizen.Wait(250)
		else
			if oldvehicle == newvehicle and wasdriver == true then
				if vehPlate ~= nil and vehPlate == 'VICROADS' then
				else
					TriggerServerEvent('832b5f5d-a5a9-4e73-96e2-ed7fd49923e7', vehPlate, hasKM, round(hasOIL,7),exports["esx_lf"]:GetFuel(oldvehicle))
				end
			end
			wasdriver = false
			hasKM = 0
			oldvehicle = 0
			newvehicle = -1
			lastchange = 0
			hasOIL = nil
			tracking = false
			Citizen.Wait(1000)
		end
				
   end

end)


function ProcessMilage(veh,driver)

	local veh = GetVehiclePedIsIn(PlayerPedId(),false)
	newvehicle = veh
	vehPlate = GetVehicleNumberPlateText(veh)

	-- print('player is now in a vehicle')
	Citizen.Wait(50)
	local driver = GetPedInVehicleSeat(veh, -1)
	if driver == PlayerPedId() and hasOIL ~= nil then
		inVeh = true
		Citizen.Wait(50)
		--local vehType = GetEntityPopulationType(veh)
								
		showKM = math.floor(hasKM*1.33)/1000

		
		local oldPos = GetEntityCoords(PlayerPedId())
		Citizen.Wait(500)
		local curPos = GetEntityCoords(PlayerPedId())

		if oldPos ~= curPos then
			if IsVehicleOnAllWheels(veh) then
				dist = #(curPos - oldPos)
			end
			-- print("distance is:")
			-- print(dist)
			hasKM = hasKM + dist
			-- print("car km are:")
			-- print(hasKM)
			--print(hasKM)
			--print((dist - lastchange))
			local oilvalue = hasOIL
			if dist > 3 then
				oilvalue = oilvalue - (dist* 0.00003)
				SetVehicleOilLevel(veh,oilvalue)
				hasOIL = oilvalue
			end
			if  (hasKM - lastchange) > 12000 then
				lastchange = hasKM
				if vehPlate ~= nil and vehPlate == 'VICROADS' then
				else
					TriggerServerEvent('832b5f5d-a5a9-4e73-96e2-ed7fd49923e7', vehPlate, hasKM,hasOIL,exports["esx_lf"]:GetFuel(veh))
				end
			end
		end
		inVeh = false

	else
	-- print("salimos del bucle xq somos pasajero")
	end

end

function round(num, numDecimalPlaces)
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end
--displayHud = true
--[[
	Citizen.CreateThread(function()
		while true do
			if IsPedInAnyVehicle(PlayerPedId(), false) then
						local veh = GetVehiclePedIsIn(PlayerPedId(),false)
					local driver = GetPedInVehicleSeat(veh, -1)
					if driver == PlayerPedId() and GetVehicleClass(veh) ~= 13 and GetVehicleClass(veh) ~= 14 and GetVehicleClass(veh) ~= 15 and GetVehicleClass(veh) ~= 16 and GetVehicleClass(veh) ~= 17 and GetVehicleClass(veh) ~= 21 then
				--DrawAdvancedText(0.270 - x, 0.97 - y, 0.005, -0.01, 0.4, round(showKM, 2), 255, 255, 255, 255, 6, 1)
				--DrawAdvancedText(0.270 - x, 0.97 - y, 0.005, 0.01, 0.4, "kms", 255, 255, 255, 255, 6, 1)
				end
			else
				Citizen.Wait(750)
			end

			Citizen.Wait(0)
		end
	end)]]

-- this will be used in the future to add damage to cars with more kms and make them slower

--[[
Citizen.CreateThread(function()
	while true do
	Citizen.Wait(250)
		if IsPedInAnyVehicle(PlayerPedId(), false) then
			local veh = GetVehiclePedIsIn(PlayerPedId(),false)
				local driver = GetPedInVehicleSeat(veh, -1)
					if driver == PlayerPedId() then
						if showKM >= 20 then
						--SetVehicleDirtLevel(veh, 15.0)						
						--SetVehicleEngineHealth(veh, 0)
					end
				end
			else
				Citizen.Wait(15000)
			end
		Citizen.Wait(1)
	end
end) --]]
	
function round(num, numDecimalPlaces)
  local mult = 10^(numDecimalPlaces or 0)
  return math.floor(num * mult + 0.5) / mult
end

function trim1(s)
   return (s:gsub("^%s*(.-)%s*$", "%1"))
end