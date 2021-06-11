ESX = nil
local PlayerData = {}

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(200)
  end
  Wait(3000)
  PlayerData = ESX.GetPlayerData()
end)


RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function(job)
	PlayerData.job = job
	
end)

local lit_1 = {
    {anim = "savecouch@",lib = "t_sleep_loop_couch",name = Config.Language.anim.lie_back, x = 0, y = 0.2, z = 1.1, r = 180.0},
	{anim = "amb@prop_human_seat_chair_food@male@base",lib = "base",name = Config.Language.anim.sit_right, x = 0.0, y = -0.2, z =0.55, r = -90.0},
	{anim = "amb@prop_human_seat_chair_food@male@base",lib = "base",name = Config.Language.anim.sit_left, x = 0.0, y = -0.2, z =0.55, r = 90.0},
	{anim = "amb@world_human_stupor@male_looking_left@base",lib = "base",name = Config.Language.anim.pls, x = 0.0, y = 0.3, z = 1.5, r = 180.0},
}

local lit = {
	{lit = `trump-stretcher`, distance_stop = 2.4, name = lit_1, title = Config.Language.lit_1}
}

prop_amb = false
veh_detect = 0


Citizen.CreateThread(function()
	WarMenu.CreateMenu('hopital', Config.Language.name_hospital)
	
	local isparamedic = false
	
	while true do
		local sleep = 2500	
		local myped = PlayerPedId()
		local pedCoords = GetEntityCoords(myped)
		local job = "unemployed"
		pcall(function() job = PlayerData.job.name end)
		for _,i in pairs(lit) do
			local closestObject = GetClosestVehicle(pedCoords, 6.0, `trump-stretcher`, 70)
		
			if  DoesEntityExist(closestObject) then
				sleep = 5
				local propCoords = GetEntityCoords(closestObject)
				local propForward = GetEntityForwardVector(closestObject)
				local litCoords = (propCoords + propForward)
				local sitCoords = (propCoords + propForward * 0.1)
				local pickupCoords = (propCoords + propForward * 1.2)
				local pickupCoords2 = (propCoords + propForward * - 1.2)
				
				local isattached = IsEntityAttachedToAnyVehicle(closestObject)
			

				if isattached == false then
					if #(pedCoords - litCoords) <= 4.5 then
						if #(pedCoords - sitCoords) <= 2.0 then
							hintToDisplay(Config.Language.do_action)
							if IsControlJustPressed(0, Config.Press.do_action) then
								WarMenu.OpenMenu('hopital')
							end
						elseif IsEntityAttachedToEntity(closestObject, myped) == false and not IsEntityPlayingAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 3) then
							if #(pedCoords - pickupCoords) <= 0.5 then
								hintToDisplay(Config.Language.take_bed)
								if IsControlJustPressed(0, Config.Press.take_bed) then
									SetVehicleExtra(closestObject, 1, 0)
									SetVehicleExtra(closestObject, 2, 1)
									prop_exist = 0
									prendre(closestObject)
								end
							end

							if #(pedCoords - pickupCoords2) <= 1.5 then
								hintToDisplay(Config.Language.take_bed)
								if IsControlJustPressed(0, Config.Press.take_bed) then
									SetVehicleExtra(closestObject, 1, 0)
									SetVehicleExtra(closestObject, 2, 1)
								prop_exist = 0
									prendre(closestObject)
								end
							end
						end
					end
				elseif isattached == true and IsEntityAttachedToEntity(closestObject, myped) == true then
					if #(pedCoords - litCoords) <= 5.0 then
						if #(pedCoords - sitCoords) <= 2.5 then
							hintToDisplay(Config.Language.do_action)
							if IsControlJustPressed(0, Config.Press.do_action) then
								WarMenu.OpenMenu('hopital')
							end
						elseif IsEntityAttachedToEntity(closestObject, myped) == false and not IsEntityPlayingAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 3) then
							if #(pedCoords - pickupCoords) <= 0.5 then
								hintToDisplay(Config.Language.take_bed)
								if IsControlJustPressed(0, Config.Press.take_bed) then
									SetVehicleExtra(closestObject, 1, 0)
									SetVehicleExtra(closestObject, 2, 1)
									prop_exist = 0
									prendre(closestObject)
								end
							end

							if #(pedCoords - pickupCoords2) <= 1.5 then
								hintToDisplay(Config.Language.take_bed)
								if IsControlJustPressed(0, Config.Press.take_bed) then
									SetVehicleExtra(closestObject, 1, 0)
									SetVehicleExtra(closestObject, 2, 1)
								prop_exist = 0
									prendre(closestObject)
								end
							end
						end
					end
				end

				if WarMenu.IsMenuOpened('hopital') then
					if isattached == false then
						for _,k in pairs(i.name) do
							if WarMenu.Button(k.name) then
								LoadAnim(k.anim)
								if (k.name == Config.Language.anim.pls) then
									SetVehicleDoorOpen(closestObject, 4, false)
								end
								AttachEntityToEntity(myped, closestObject, myped, k.x, k.y, k.z, 0.0, 0.0, k.r, 0.0, false, false, false, false, 2, true)
								WarMenu.CloseMenu('hopital')
								TaskPlayAnim(myped, k.anim, k.lib, 8.0, 8.0, -1, 1, 0, false, false, false)
							end
						end
					end
					if job == 'ambulance' or job == 'police' then
						if WarMenu.Button(Config.Language.toggle_backboard) then
							if IsVehicleExtraTurnedOn(closestObject, 3) == false then
								SetVehicleExtra(closestObject, 3, 0)
							else
								SetVehicleExtra(closestObject, 3, 1)
							end
						end
						
						if WarMenu.Button(Config.Language.toggle_lifepak) then
							if IsVehicleExtraTurnedOn(closestObject, 5) == false then
								SetVehicleExtra(closestObject, 5, 0)
							else
								SetVehicleExtra(closestObject, 5, 1)
							end
						end
						
						if WarMenu.Button(Config.Language.toggle_bag) then
							if IsVehicleExtraTurnedOn(closestObject, 6) == false then
								SetVehicleExtra(closestObject, 6, 0)
							else
								SetVehicleExtra(closestObject, 6, 1)
							end
						end
						
						if WarMenu.Button(Config.Language.toggle_backpack) then
							if IsVehicleExtraTurnedOn(closestObject, 7) == false then
								SetVehicleExtra(closestObject, 7, 0)
							else
								SetVehicleExtra(closestObject, 7, 1)
							end
						end
						
						if WarMenu.Button(Config.Language.toggle_seat) then
							if IsVehicleExtraTurnedOn(closestObject, 11) == false then
								SetVehicleExtra(closestObject, 11, 0)
								SetVehicleExtra(closestObject, 12, 1)
							else
								SetVehicleExtra(closestObject, 11, 1)
								SetVehicleExtra(closestObject, 12, 0)
							end
						end
					end
					if WarMenu.Button(Config.Language.go_out_bed) then
						DetachEntity(myped, true, true)
						local x, y, z = table.unpack(GetEntityCoords(closestObject) + GetEntityForwardVector(closestObject) * - i.distance_stop)
						SetEntityCoords(myped, x, y, z)
						WarMenu.CloseMenu('hopital')
					end
					WarMenu.Display()
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)

Citizen.CreateThread(function()
	prop_exist = 0
	
	while true do
		local sleep = 4500
		local myped = PlayerPedId()
		local mycoords = GetEntityCoords(myped)
		for _,g in pairs(Config.Hash) do
			local closestObject = GetClosestVehicle(mycoords, 5.0, g.hash, 18)
			
			if closestObject ~= 0 then
	
				--if GetVehicleDoorLockStatus(closestObject)  < 2 then
					veh_detect = closestObject
					veh_detection = g.detection
					prop_depth = g.depth
					prop_height = g.height
					prop_width = tonumber(g.width)
					sleep = 5
				--end
			end
		end
		if prop_amb == false then
			if GetVehiclePedIsIn(GetPlayerPed(-1)) == 0 then
				if DoesEntityExist(veh_detect) then
					sleep = 5
					local coords = GetEntityCoords(veh_detect) + GetEntityForwardVector(veh_detect) * - veh_detection
					local coords_spawn = coords + GetEntityForwardVector(veh_detect) * - (veh_detection + 2.5)
					if #(mycoords - vector3(coords.x , coords.y, coords.z)) <= 1.0 then
					
						if not IsEntityPlayingAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 3)  then
							hintToDisplay(Config.Language.out_vehicle_bed)
							for _,m in pairs(lit) do
								local prop = GetClosestObjectOfType(mycoords, 9.0, m.lit)
								if prop ~= 0 then 
									prop_exist = prop
								end
							end
							if IsEntityAttachedToEntity(prop, myped) ~= 0 or prop ~= 0 then
								if IsControlJustPressed(0, Config.Press.out_vehicle_bed) then
									--if GetVehicleDoorLockStatus(veh_detect)  < 2 then
									while not HasModelLoaded("trump-stretcher") do
										RequestModel("trump-stretcher")
										Citizen.Wait(1)
									end
									local object = CreateVehicle(`trump-stretcher`, coords_spawn, true, true)
									SetVehicleExtra(object, 1, 0)
									SetVehicleExtra(object, 2, 1)
									SetVehicleExtra(object, 12, 1)
									SetVehicleExtra(object, 11, 0)
									SetEntityHeading(myped, GetEntityHeading(myped) - 180.0)
									SetVehicleEngineOn(object, 1, 1, 1)
									prendre(object, vehicle)
									--end
								end
							end
						end
					end
				end
			end
		end
		Citizen.Wait(sleep)
	end
end)


function prendre(propObject, hash)
	NetworkRequestControlOfEntity(propObject)

	LoadAnim("anim@heists@box_carry@")

	AttachEntityToEntity(propObject, GetPlayerPed(-1), GetPlayerPed(-1), -0.05, 1.3, -0.345 , 180.0, 180.0, 180.0, 0.0, false, false, true, false, 2, true)
		---
	while IsEntityAttachedToEntity(propObject, GetPlayerPed(-1)) do

		Citizen.Wait(5)

		if not IsEntityPlayingAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 3) then
			TaskPlayAnim(PlayerPedId(), 'anim@heists@box_carry@', 'idle', 8.0, 8.0, -1, 50, 0, false, false, false)
		end

		if IsPedDeadOrDying(GetPlayerPed(-1)) then
			ClearPedTasksImmediately(GetPlayerPed(-1))
			SetVehicleExtra(propObject, 1, 1)
			SetVehicleExtra(propObject, 2, 0)
			DetachEntity(propObject, true, true)
		end
		if #(GetEntityCoords(GetPlayerPed(-1)) - GetEntityCoords(veh_detect)) <= 4.0 then
			hintToDisplay(Config.Language.in_vehicle_bed)
			if (IsControlJustPressed(0, Config.Press.in_vehicle_bed)) then
				ClearPedTasksImmediately(GetPlayerPed(-1))
				SetVehicleExtra(propObject, 1, 1)
				SetVehicleExtra(propObject, 2, 0)
				--SetVehicleExtra(propObject, 3, 0)

				DetachEntity(propObject, true, true)
				prop_amb = true

				in_ambulance(propObject, veh_detect, prop_depth, prop_height, prop_width)
			end
		else
			hintToDisplay(Config.Language.release_bed)
		end

		if IsControlJustPressed(0, Config.Press.release_bed) then
			ClearPedTasksImmediately(GetPlayerPed(-1))
			SetVehicleExtra(propObject, 1, 1)
			SetVehicleExtra(propObject, 2, 0)
			DetachEntity(propObject, true, false)
			SetVehicleOnGroundProperly(propObject)
		end
		
	end
end

function in_ambulance(propObject, amb, depth, height, width)
	veh_detect = 0
	NetworkRequestControlOfEntity(amb)
	width = tonumber(width)

	AttachEntityToEntity(propObject, amb, 0.0, width, depth, height, 0.0, 0.0, 0.0, 0.0, false, false, true, false, 2, true)
	
	while IsEntityAttachedToEntity(propObject, amb) do
		Citizen.Wait(10)

		if GetVehiclePedIsIn(GetPlayerPed(-1)) == 0 then
			if #(GetEntityCoords(GetPlayerPed(-1)) - GetEntityCoords(amb)) <= 7.0 then
				hintToDisplay(Config.Language.out_vehicle_bed)
				if IsControlJustPressed(0, Config.Press.out_vehicle_bed) then
					DetachEntity(propObject, true, true)
					prop_amb = false
					SetEntityHeading(GetPlayerPed(-1), GetEntityHeading(GetPlayerPed(-1)) - 180.0)
					SetVehicleExtra(propObject, 1, 0)
					SetVehicleExtra(propObject, 2, 1)
					prendre(propObject)
				end
			end
		end
	end
end

function LoadAnim(dict)
	while not HasAnimDictLoaded(dict) do
		RequestAnimDict(dict)
		Citizen.Wait(1)
	end
end

function hintToDisplay(text)
    SetTextComponentFormat("STRING")
    AddTextComponentString(text)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function ShowNotification( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
end

function DrawText3D(coords, text, size)

    local onScreen,_x,_y=World3dToScreen2d(coords.x,coords.y,coords.z + 1.0)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    
    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
    DrawRect(_x,_y+0.0125, 0.015+ factor, 0.03, 41, 11, 41, 68)
end