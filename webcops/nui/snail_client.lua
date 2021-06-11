snail = "not on" -- don't touch the snail

anprplayersetting = false

-- you can touch this tho
ScanningDistance = 25.0 -- how far the Plate Reader should look
ControlInputGroup = 27 -- control stuff for changing the key, leave if you don't understand this
ControlKey = 132 -- Default Key is the Control key

-- you shouldn't touch anything under this if you don't understand it

local anprmodels =  {
'hwpbmw5me','hwpbmw5m','gdcamry2','hwpgts','hwpx5','hwpfg', 'afpumbmw','hwppassat','hwpss','hwpsse','hwpwag','hwpumwag','hwpumss','hwpumsse','hwpumfgx','hwpfgx','hwpssu','hwpbmw','hwpterry','sheriff',"hwpssn","fbi","hwplc","hwpkluger","policebike","policeum","dojsheriff","vicdivvy","vicss","afpss","afpumss","hwpbmws","hwpumbmw","hwpxx5","umhwpxx5","hwpxxx5","umhwpxxx5","hwpmerc","hwpcrys","hwpx55","hwpbmwwagon","hwpfgx1","umhwpfgx1","gdhilux2","hwpwag2","hwpss1","hwpumss1","hwpstang","hwpbmwwagon2","hwpsfbb","gdsf2","polgdram","gdzb","gdsonata","umhwpwag2","gdcamry","gdzbsedan","hwpstinger"
}
--hwpumsse,hwpumss,hwpsse,hwpwag, hawpssu, sheriff, hwpbmw, fbi, hwpfgx, hwpumfgx, hwpterry, hwplc, hwpkluger, policebike, policeum, dojsheriff, vicss,vicdivvy
ESX = nil
local PlayerData                = {}
 

RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function(job)
  PlayerData.job = job
 
end)


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('fbd9f4e7-4b03-42f0-9162-d42a130cffd4')
AddEventHandler('fbd9f4e7-4b03-42f0-9162-d42a130cffd4', function(anpr)
 
  print('anpr toggle hit')
		if anprplayersetting == true then

				if IsPedInAnyPoliceVehicle(GetPlayerPed(-1))  == false then
					--Turns off ANPR if in non cop car
					snail = "not on"
						if   1 == 1 then		--isCarWhitelisted(carModel)

						else
							snail = "not on"
							displayNotification("ANPR ~r~NOT FITTED ~w~to car")
							anprplayersetting = false
						end
				else
					--Turns it back on in cop car
					snail = "on"
				end
		else
		
			snail = "not on"
		end
		
		if DoesEntityExist(GetVehiclePedIsIn(GetPlayerPed(-1))) then
			if snail == "on" then
				displayNotification("ANPR ~r~OFF")
				snail = "not on"
				anprplayersetting = false
			elseif snail == "not on"  then
				if IsPedInAnyPoliceVehicle(GetPlayerPed(-1))  then
					if nswloggedInCops == true then
						cvcar = GetVehiclePedIsIn(GetPlayerPed(-1), false)
						carModel = GetEntityModel(cvcar)
						if  1 == 1 then   -- isCarWhitelisted(carModel)
							displayNotification("ANPR ~g~ON")
							snail = "on"
							anprplayersetting = true
						else
							--displayNotification("ANPR ~g~ON")
							--snail = "on"
							--anprplayersetting = true
							snail = "not on"
							displayNotification("ANPR ~r~NOT FITTED ~w~to car")
							anprplayersetting = false
						end
					end
				end
			end
		end
 
end)




local veh = nil
local displayplate = false
local timerelasped = false
Citizen.CreateThread(function()

	while true do

		if IsControlJustPressed(1,208) and IsPedInAnyPoliceVehicle(GetPlayerPed(-1)) then
			if GetLastInputMethod(1) then
					local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1))
					if DoesEntityExist(vehicle) then
					local vh = GetPoliceCarVehicleS(vehicle,10.0)

					timerelasped = true

					Citizen.CreateThread(function()
							Wait(3000)
							timerelasped = false
					end)
					local numc = 1.0
					while timerelasped do
						vh = GetPoliceCarVehicleS(vehicle,numc)


						if numc > 30.0 then
							numc = 1.0
						end
						numc = numc + 3.5
						Wait(0)
						if vh ~= nil and vh ~= 0 then
							break
						end
						
						--local coordsa = GetOffsetFromEntityInWorldCoords(vehicle,0.0,1.0,0.3)
						--local coordsb = GetOffsetFromEntityInWorldCoords(vehicle, 0.0,numc,0.0)
						--DrawMarker(1, coordsa.x, coordsa.y, coordsa.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 255, 255, 0, 100, false, true, 2, false, false, false, false)
						--DrawMarker(1, coordsb.x, coordsb.y, coordsb.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.0, 255, 255, 255, 100, false, true, 2, false, false, false, false)
					end
				
					print (vh)
					if vh ~= nil then
					if vh ~= 0 then
						print('plate found ' .. GetVehicleNumberPlateText(vh))
						local vehicleData = ESX.Game.GetVehicleProperties(vh)
						if displayplate then
							indepchk(vh)
						else
							TriggerServerEvent('a66340aa-fc27-463e-8826-bd5680710b18',tostring(GetPlayerServerId(PlayerId())), vehicleData.plate)
						end
						displayplate = true
						Citizen.CreateThread(function()
							Wait(6000)
							displayplate = false

						end)
						local text = GetVehicleNumberPlateText(vh)
						local x = 0.4000
						local y = 0.35
						local scale = 1.40
						
						Citizen.CreateThread(function()
							while displayplate do
							
									SetTextFont(0)
									SetTextProportional(1)
									SetTextScale(scale, scale)
									SetTextColour(255, 255, 255, 255)
									SetTextDropshadow(2, 2, 0, 0, 0)  
									SetTextEdge(1, 0, 0, 0, 205) 
									SetTextCentre(true)
									SetTextWrap(0.0,1.0)
									SetTextDropShadow()
									SetTextOutline()
									SetTextEntry("STRING")
									AddTextComponentString(text)
									DrawText(y, x)
								Wait(0)
							end
						end)

					end
					end
					
					
				end
			end
		end
		Citizen.Wait(10)
	end

end)



function GetPoliceCarVehicleS(entity,scan)
	local coords = GetOffsetFromEntityInWorldCoords(entity,0.0,1.0,0.3)
	local coords2 = GetOffsetFromEntityInWorldCoords(entity, 0.0, scan,0.0)
	local rayhandle = CastRayPointToPoint(coords, coords2, 10, entity, 0)
	local _, _, _, _, entityHit = GetRaycastResult(rayhandle)
	if entityHit>0 and IsEntityAVehicle(entityHit) then
		return entityHit
	else
		return nil
	end
end



function GetPoliceCarVehicle(entity,scan)

	   
	local coords = GetOffsetFromEntityInWorldCoords(entity,0.0,1.0,0.3)
	local coords2 = GetOffsetFromEntityInWorldCoords(entity, 0.0, scan,0.0)
	local rayhandle = CastRayPointToPoint(coords, coords2, 10, entity, 0)
	local _, _, _, _, entityHit = GetRaycastResult(rayhandle)
	if entityHit>0 and IsEntityAVehicle(entityHit) then
		return entityHit
	else
		return nil
	end
end


function GetVehicleInfrontOfEntity(entity)
	local coords = GetOffsetFromEntityInWorldCoords(entity,0.0,1.0,0.3)
	local coords2 = GetOffsetFromEntityInWorldCoords(entity, 0.0, ScanningDistance,0.0)
	local rayhandle = CastRayPointToPoint(coords, coords2, 10, entity, 0)
	local _, _, _, _, entityHit = GetRaycastResult(rayhandle)
	if entityHit>0 and IsEntityAVehicle(entityHit) then
		return entityHit
	else
		return nil
	end
end

function GetVehicleInfrontOfEntitySide(entity)
	local coords = GetOffsetFromEntityInWorldCoords(entity,-0.3,1.0,0.3)
	local coords2 = GetOffsetFromEntityInWorldCoords(entity, -30.0, ScanningDistance,0.0)
	local rayhandle = CastRayPointToPoint(coords, coords2, 10, entity, 0)
	local _, _, _, _, entityHit = GetRaycastResult(rayhandle)
	if entityHit>0 and IsEntityAVehicle(entityHit) then
		return entityHit
	else
		return nil
	end
end

function GetVehicleInfrontOfEntityRightSide(entity)
	local coords = GetOffsetFromEntityInWorldCoords(entity,-0.3,1.0,0.3)
	local coords2 = GetOffsetFromEntityInWorldCoords(entity, 30.0, ScanningDistance,0.0)
	local rayhandle = CastRayPointToPoint(coords, coords2, 10, entity, 0)
	local _, _, _, _, entityHit = GetRaycastResult(rayhandle)
	if entityHit>0 and IsEntityAVehicle(entityHit) then
		return entityHit
	else
		return nil
	end
end

function RenderVehicleInfo(vehicle)
	local model = GetEntityModel(vehicle)
	local vehname = GetLabelText(GetDisplayNameFromVehicleModel(model))
	local licenseplate = GetVehicleNumberPlateText(vehicle)
	local passNum = GetVehicleNumberOfPassengers(vehicle)
	local primary, secondary = cGetVehicleColours(vehicle)
	
	if primary == nil then
		primary = 'Unknown'
	end
	--if not IsVehicleSeatFree() then
	--	passNum = passNum + 1
	--end

	displaySubtitle("Model: "..vehname.."\nPlate: "..licenseplate.."\nColour: "..primary)
end

function RotAnglesToVec(rot) -- input vector3
	local z = math.rad(rot.z)
	local x = math.rad(rot.x)
	local num = math.abs(math.cos(x))
	return vector3(-math.sin(z)*num, math.cos(z)*num, math.sin(x))
end

function isCarWhitelisted(model)


	for _, wlcar in pairs(anprmodels) do
		if model == GetHashKey(wlcar) then
			return true
		end
	end
	
	return false
end






Citizen.CreateThread(function()
	local lastchecked
	local lastchecked2
	local lastchecked3
	while true do
	
	
		Citizen.Wait(5)
		if anprplayersetting == true then
				if IsPedInAnyPoliceVehicle(GetPlayerPed(-1))  == false then
					--Turns off ANPR if in non cop car
					snail = "not on"
						if  isCarWhitelisted(carModel) then

						else
							snail = "not on"
							displayNotification("ANPR ~r~NOT FITTED ~w~to car")
							anprplayersetting = false
						end
				else
					--Turns it back on in cop car
					snail = "on"
				end
		else
		
			snail = "not on"
		end
		
		if DoesEntityExist(GetVehiclePedIsIn(GetPlayerPed(-1))) then
			if snail == "on" and GetLastInputMethod(0) and IsControlPressed(1, 132) and IsControlJustPressed(1,64) then
				displayNotification("ANPR ~r~OFF")
				snail = "not on"
				anprplayersetting = false
			elseif snail == "not on" and GetLastInputMethod(0) and IsControlPressed(1, 132) and IsControlJustPressed(1,64) then
				if IsPedInAnyPoliceVehicle(GetPlayerPed(-1))  then
					if nswloggedInCops == true then
						cvcar = GetVehiclePedIsIn(GetPlayerPed(-1), false)
						carModel = GetEntityModel(cvcar)
						if  isCarWhitelisted(carModel) then
							displayNotification("ANPR ~g~ON")
							snail = "on"
							anprplayersetting = true
						else
							--displayNotification("ANPR ~g~ON")
							--snail = "on"
							--anprplayersetting = true
							snail = "not on"
							displayNotification("ANPR ~r~NOT FITTED ~w~to car")
							anprplayersetting = false
						end
					end
				end
			end
			if snail == "on" then
	
				local vehicle_detected = GetVehicleInfrontOfEntitySide(GetVehiclePedIsIn(GetPlayerPed(-1)))
				if DoesEntityExist(vehicle_detected) then
				
				else
					vehicle_detected = GetVehicleInfrontOfEntityRightSide(GetVehiclePedIsIn(GetPlayerPed(-1)))
					if DoesEntityExist(vehicle_detected) then
						
					else
						vehicle_detected = GetVehicleInfrontOfEntity(GetVehiclePedIsIn(GetPlayerPed(-1)))
					end
				end
				if DoesEntityExist(vehicle_detected) then
					 RenderVehicleInfo(vehicle_detected)
					if lastchecked == vehicle_detected then
						
					elseif lastchecked2 == vehicle_detected then
					
					elseif lastchecked3 == vehicle_detected then
					
					else	
						    SendNUIMessage({
							transactionType     = 'playSound',
							transactionFile     = "platescan",
							transactionVolume   = 0.009
							})
						CheckPlate(vehicle_detected)
						lastchecked3 = lastchecked2
						lastchecked2 = lastchecked
						lastchecked = vehicle_detected
					end
				end
			end
		
		elseif snail == "on" then
				displayNotification("ANPR ~r~OFF")
				snail = "not on"
				anprplayersetting = false
		
		end
	end
end)


function CheckPlate(vehicle)
	local players = GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local ply = GetPlayerPed(-1)
	local plyCoords = GetEntityCoords(ply, 0)
	
	
	if PlayerData.job.name == 'police' and (PlayerData.job.grade_name ~= 50 or PlayerData.job.grade_name ~= 51)  then
		
		local pedusing = false
			for index,value in ipairs(players) do
				local target = GetPlayerPed(value)
				car = GetVehiclePedIsUsing(target)
				if vehicle == car then
					pedusing = true
				end
			end
				if (GetVehicleClass(vehicle) ~= 18 and GetVehicleClass(vehicle) ~= 13) then
					local model = GetEntityModel(vehicle)
					local vehname = GetLabelText(GetDisplayNameFromVehicleModel(model))
					local primary, secondary = cGetVehicleColours(vehicle)
					local vehicleClass = GetVehicleClass(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)
					print("PLATE ")
					
					plate = tostring(plate)
					--print(tostring(plate))
					--print(string.len(plate))
				
					if plate == nil then
						TriggerEvent('ba899eb5-167a-47a8-bbe3-d9817b3d9b37', "~o~ANPR\n~w~" .. vehname .. "\n NO PLATE\n" .. primary, "flag", "~y~FLAGS:\n~r~STOLEN NPC");
						TriggerEvent('75380609-4b35-4a79-a85c-f2b383c76722',"flag",0.45)
					elseif tostring(plate) == '        ' then
						TriggerEvent('ba899eb5-167a-47a8-bbe3-d9817b3d9b37', "~o~ANPR\n~w~" .. vehname .. "\n NO PLATE\n" .. primary, "flag", "~y~FLAGS:\n~r~STOLEN NPC");
						TriggerEvent('75380609-4b35-4a79-a85c-f2b383c76722',"flag",0.45)
					--elseif string.match(tostring(plate),'WORK[0-9][0-9][0-9][0-9]') then
					elseif string.match(tostring(plate),'[W-W][A-A][L-L][0-9][0-9][0-9][0-9]%s*') then
					elseif string.match(tostring(plate),'[W-W][O-O][R-R][K-K][0-9][0-9][0-9]%s*') then
						print('plate not submitted to server and was captured')
					elseif string.match(tostring(plate),'[A-Za-z][A-Za-z][A-Za-z] [0-9][0-9][0-9]') then
						TriggerServerEvent('5574ef25-f62a-4dbc-b20a-54622bca3dc3',getHandle(),GetVehicleNumberPlateText(vehicle),"", vehname, primary, vehicleClass, pedusing)
						TriggerEvent('75380609-4b35-4a79-a85c-f2b383c76722',"platescan",0.01)
					elseif pedusing == true then
						TriggerServerEvent('5574ef25-f62a-4dbc-b20a-54622bca3dc3',getHandle(),GetVehicleNumberPlateText(vehicle),"", vehname, primary, vehicleClass, pedusing)
						TriggerEvent('75380609-4b35-4a79-a85c-f2b383c76722',"platescan",0.01)
					else
						TriggerServerEvent('5574ef25-f62a-4dbc-b20a-54622bca3dc3',getHandle(),GetVehicleNumberPlateText(vehicle),"", vehname, primary, vehicleClass, pedusing)
						TriggerEvent('75380609-4b35-4a79-a85c-f2b383c76722',"platescan",0.01)
					end
				
				end
	
		return
	end

	for index,value in ipairs(players) do
		local target = GetPlayerPed(value)
		
		---if(target ~= ply) then
			local car
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = Vdist(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"])
			if(closestDistance == -1 or closestDistance > distance) then
				closestPlayer = value
				closestDistance = distance
			end
		
			car = GetVehiclePedIsUsing(target)
							
			if vehicle == car then
				--displayNotification("CKH~g~MATCH RCHK")

				if (IsPedInAnyPoliceVehicle(target) == false) then
					local model = GetEntityModel(vehicle)
					local vehname = GetLabelText(GetDisplayNameFromVehicleModel(model))
					local primary, secondary = cGetVehicleColours(vehicle)
					local vehicleClass = GetVehicleClass(vehicle)
					local plate = GetVehicleNumberPlateText(vehicle)

					if plate == nil then
						TriggerEvent('ba899eb5-167a-47a8-bbe3-d9817b3d9b37', "~o~ANPR\n~w~" .. vehname .. "\n NO PLATE\n" .. primary, "flag", "~y~FLAGS:\n~r~STOLEN NPC");
						TriggerEvent('75380609-4b35-4a79-a85c-f2b383c76722',"flag",0.45)
					elseif tostring(plate) == '        ' then
						TriggerEvent('ba899eb5-167a-47a8-bbe3-d9817b3d9b37', "~o~ANPR\n~w~" .. vehname .. "\n NO PLATE\n" .. primary, "flag", "~y~FLAGS:\n~r~STOLEN NPC");
						TriggerEvent('75380609-4b35-4a79-a85c-f2b383c76722',"flag",0.45)
					elseif string.match(tostring(plate),'WORK[0-9][0-9][0-9][0-9]') then
					else
						TriggerServerEvent('5574ef25-f62a-4dbc-b20a-54622bca3dc3',getHandle(),GetVehicleNumberPlateText(vehicle),"", vehname, primary, vehicleClass, true)
						TriggerEvent('75380609-4b35-4a79-a85c-f2b383c76722',"platescan",0.01)
					end
				end
				
			else
			
				--Any Car
				local model = GetEntityModel(vehicle)
				local vehname = GetLabelText(GetDisplayNameFromVehicleModel(model))
				TriggerEvent('75380609-4b35-4a79-a85c-f2b383c76722',"platescan",0.01)
				TriggerServerEvent('5574ef25-f62a-4dbc-b20a-54622bca3dc3',getHandle(),GetVehicleNumberPlateText(vehicle), "", vehname)
			end
		---end
	end



end

function indepchk(vehicle)

	local model = GetEntityModel(vehicle)
	local vehname = GetLabelText(GetDisplayNameFromVehicleModel(model))
	local primary, secondary = cGetVehicleColours(vehicle)
	local vehicleClass = GetVehicleClass(vehicle)
	local plate = GetVehicleNumberPlateText(vehicle)
	local hasplayer = false
	local Peddriver = GetPedInVehicleSeat(vehicle,-1)
	if Peddriver ~= nil then
		hasplayer = IsPedAPlayer(Peddriver)
	end

		TriggerServerEvent('f4be1bdf-2dba-46e0-957b-b207c826dda5',getHandle(),GetVehicleNumberPlateText(vehicle),"", vehname, primary, vehicleClass, hasplayer)
	

end

function displaySubtitle(text)

	local urtime = 0
	--while urtime < 1000 do
	--	Wait(0)
		SetTextFont(0)
		SetTextProportional(1)
		SetTextScale(0.0, 0.55)
		SetTextColour(255, 255, 255, 255)
		SetTextDropshadow(0, 0, 0, 0, 255)
		SetTextEdge(1, 0, 0, 0, 255)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		AddTextComponentString(text)
		DrawText(0.45, 0.88)
	--	Wait(0)
		--urtime = urtime + 1
	--end
end

function displayNotification(text)
	SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

function CheckVehicleRestriction(vehicle, VehicleList)



	for i = 1, #VehicleList do
		if GetHashKey(VehicleList[i]) == GetEntityModel(vehicle) then
		displayNotification("ALPR ~g~OK")
			return true
		end
	end
	displayNotification("ALPR ~r~NO")
	return false
end
