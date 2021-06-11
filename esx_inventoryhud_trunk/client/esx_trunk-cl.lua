ESX = nil
local GUI = {}
local PlayerData = {}
local lastVehicle = nil
local lastOpen = false
GUI.Time = 0
local vehiclePlate = {}
local arrayWeight = Config.localWeight
local CloseToVehicle = false
local entityWorld = nil
local globalplate = nil
local lastChecked = 0



Citizen.CreateThread(
  function()
    while ESX == nil do
      TriggerEvent('esx:getSharedObject', function(obj)
          ESX = obj
        end)
      Citizen.Wait(0)
    end
  end
)

RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488',function(xPlayer)

	PlayerData = xPlayer
	TriggerServerEvent('161f0939-550d-4373-a8b5-89c196cf90c4')
	lastChecked = GetGameTimer()

end)

AddEventHandler('bd42fa56-aa7c-442f-b439-552fe21bdf21', function()
    PlayerData = xPlayer
    lastChecked = GetGameTimer()
  end
)

RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function(job)
	if PlayerData ~= nil then
		PlayerData.job = job
	end
  end
)

RegisterNetEvent('970704a1-c9a2-4b73-a6c7-c1b4c7ba06cc')
AddEventHandler('970704a1-c9a2-4b73-a6c7-c1b4c7ba06cc', function(vehicle)
    vehiclePlate = vehicle
    --print("vehiclePlate: ", ESX.DumpTable(vehiclePlate))
  end
)




function getItemyWeight(item)
  local weight = 0
  local itemWeight = 0
  if item ~= nil then
    itemWeight = Config.DefaultWeight
    if arrayWeight[item] ~= nil then
      itemWeight = arrayWeight[item]
    end
  end
  return itemWeight
end

function VehicleInFront()
  local pos = GetEntityCoords(GetPlayerPed(-1))
  local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 4.0, 0.0)
  local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
  local a, b, c, d, result = GetRaycastResult(rayHandle)
  return result
end

function openmenuvehicle()
  local playerPed = GetPlayerPed(-1)
  local coords = GetEntityCoords(playerPed)
  local vehicle = VehicleInFront()
  globalplate = GetVehicleNumberPlateText(vehicle)

  if not IsPedInAnyVehicle(playerPed) then
	  TriggerServerEvent('ec37e036-65b0-4a63-93da-3c5d91df7ecb', globalplate)
    myVeh = false
    local thisVeh = VehicleInFront()
    PlayerData = ESX.GetPlayerData()

    for i = 1, #vehiclePlate do
      local vPlate = all_trim(vehiclePlate[i].plate)
      local vFront = all_trim(GetVehicleNumberPlateText(thisVeh))
      --print('vPlate: ',vPlate)
      --print('vFront: ',vFront)
      --if vehiclePlate[i].plate == GetVehicleNumberPlateText(vehFront) then
      if vPlate == vFront then
        myVeh = true
      elseif lastChecked < GetGameTimer() - 60000 then
        TriggerServerEvent('161f0939-550d-4373-a8b5-89c196cf90c4')
        lastChecked = GetGameTimer()
        Wait(2000)
        for i = 1, #vehiclePlate do
          local vPlate = all_trim(vehiclePlate[i].plate)
          local vFront = all_trim(GetVehicleNumberPlateText(thisVeh))
          if vPlate == vFront then
            myVeh = true
          end
        end
      end
    end
	
    if not Config.CheckOwnership or (Config.AllowPolice and PlayerData.job.name == "police") or (Config.CheckOwnership and myVeh) then
      if globalplate ~= nil or globalplate ~= "" or globalplate ~= " " then
        CloseToVehicle = true
        local vehFront = vehicle
        local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
        local closecar = GetClosestVehicle(x, y, z, 1.3, 0, 71)
		local carforuse
		if closecar ~= 0 then
			carforuse = closecar
		elseif vehFront ~= 0 then
			carforuse = vehFront
		end
		
		local pln = GetVehicleNumberPlateText(carforuse)
		if pln ~= "        " then
			
		else
			exports.pNotify:SendNotification(
			{
			  text = 'When you screw drivered the rear plate, you screwed the boot.',
			  type = "error",
			  timeout = 3000,
			  layout = "bottomCenter",
			  queue = "trunk"
			})
			return
		end


        if carforuse ~= nil and carforuse > 0 and GetPedInVehicleSeat(carforuse, -1) == 0  then
          lastVehicle = carforuse
          local model = GetDisplayNameFromVehicleModel(GetEntityModel(carforuse))
		  local mdl = GetEntityModel(carforuse)
          local locked = GetVehicleDoorLockStatus(carforuse)
          local class = GetVehicleClass(carforuse)
		  local weight = Config.VehicleLimit[class]

			if Config.VehicleLimito[tostring(mdl)] ~= nil then
				weight = Config.VehicleLimito[tostring(mdl)]
			end
          --ESX.UI.Menu.CloseAll()
		--   print('boot open 1')
		  SetVehicleDoorOpen(carforuse, 5, false, false)

          --if ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "inventory") then
            
      --    else
		 --  print('boot closed 1')
			SetVehicleDoorShut(carforuse, 5, false)

            if locked == 1 or class == 15 or class == 16 or class == 14 then
				if class ~= 14 then
					TaskStartScenarioInPlace(GetPlayerPed(-1), "PROP_HUMAN_BUM_BIN", 0, true)
				end
              
              ESX.UI.Menu.CloseAll()

              if globalplate ~= nil or globalplate ~= "" or globalplate ~= " " then
                CloseToVehicle = true
                OpenCoffreInventoryMenu(GetVehicleNumberPlateText(carforuse), weight, myVeh)
				-- print('boot Open 2')
				SetVehicleDoorOpen(carforuse, 5, false, false)
              end
            else
			  -- print('trunk closed')
			   
			  if GetVehicleNumberPlateText(carforuse) ~= nil then
				TriggerServerEvent('sx_trunk:exitTrunk',GetVehicleNumberPlateText(carforuse))
			  end
              exports.pNotify:SendNotification(
                {
                  text = _U("trunk_closed"),
                  type = "error",
                  timeout = 3000,
                  layout = "bottomCenter",
                  queue = "trunk"
                }
              )
            end
        --  end
        else
          exports.pNotify:SendNotification(
            {
              text = _U("no_veh_nearby"),
              type = "error",
              timeout = 3000,
              layout = "bottomCenter",
              queue = "trunk"
            }
          )
        end
        lastOpen = true
        GUI.Time = GetGameTimer()
      end
    else
      -- Not their vehicle
      exports.pNotify:SendNotification(
        {
          text = _U("nacho_veh"),
          type = "error",
          timeout = 3000,
          layout = "bottomCenter",
          queue = "trunk"
        }
      )
    end
  end
end
local count = 0


RegisterCommand('+openvehicleinventory', function()
	if (GetGameTimer() - GUI.Time) > 1000 then
		if not exports.esx_policejob:amicuffed()then
			local ped = GetPlayerPed(-1)

			if IsPedInAnyVehicle(ped,false)  then
				
				local vh = GetVehiclePedIsIn(ped,false)
				if GetPedInVehicleSeat(vh,-1)  == ped or GetPedInVehicleSeat(vh,0) then
					--Allow it to open
					
					local class = GetVehicleClass(vh)
					local model = GetEntityModel(vh)
					local locked = GetVehicleDoorLockStatus(vh)
					local weight = Config.VehicleLimitGB[class]

					if Config.VehicleLimitGBo[tostring(model)] ~= nil then
						weight = Config.VehicleLimitGBo[tostring(model)]
					end
					if locked == 1 or class == 15 or class == 16 or class == 14 then
						local pln = GetVehicleNumberPlateText(vh)
		
						if pln ~= "        " then
							OpenCoffreInventoryMenuG(pln,  weight, true)
						else
							exports.pNotify:SendNotification(
							{
							  text = 'When you screw drivered the rear plate, you screwed the glove box.',
							  type = "error",
							  timeout = 3000,
							  layout = "bottomCenter",
							  queue = "trunk"
							})
						end
					else
						 exports.pNotify:SendNotification(
							{
							  text = _U("glove_closed"),
							  type = "error",
							  timeout = 3000,
							  layout = "bottomCenter",
							  queue = "trunk"
							})
							
					end
					
				end
			
			else
				if IsPedSwimming(ped) == false then
					openmenuvehicle()
				end
			end
			GUI.Time = GetGameTimer()
		  end
      end
end, false)

RegisterKeyMapping('+openvehicleinventory', 'Vehicle :: Vehicle Inventory', 'keyboard', 'MINUS')



-- Key controls
--[[
Citizen.CreateThread(
  function()
    while true do
      Wait(15)
      if IsControlJustPressed(0, Config.OpenKey) and not IsControlPressed(0,19) and (GetGameTimer() - GUI.Time) > 1000 then
		local ped = GetPlayerPed(-1)
		if IsPedInAnyVehicle(ped,false) then
			print('is in any vehicle')
			local vh = GetVehiclePedIsIn(ped,false)
			if GetPedInVehicleSeat(vh,-1)  == ped or GetPedInVehicleSeat(vh,0) then
				--Allow it to open
				print('access seat')
				local class = GetVehicleClass(vh)
				local locked = GetVehicleDoorLockStatus(vh)
				if locked == 1 or class == 15 or class == 16 or class == 14 then
					print('should open')
					local pln = GetVehicleNumberPlateText(vh)
					if pln ~= " " then
						OpenCoffreInventoryMenuG(pln, 100, true)
					else
						exports.pNotify:SendNotification(
						{
						  text = 'When you screw drivered the rear plate, you screwed the boot.',
						  type = "error",
						  timeout = 3000,
						  layout = "bottomCenter",
						  queue = "trunk"
						})
					end
				else
					 exports.pNotify:SendNotification(
						{
						  text = _U("glove_closed"),
						  type = "error",
						  timeout = 3000,
						  layout = "bottomCenter",
						  queue = "trunk"
						})
						
				end
				
			end
		
		else
			openmenuvehicle()
		end
        GUI.Time = GetGameTimer()
      end
    end
  end
)--]]

Citizen.CreateThread(
  function()
    while true do
      Wait(15)
      local pos = GetEntityCoords(GetPlayerPed(-1))
	  local plyCoords = pos
	  
      if CloseToVehicle then
		local targetCoords = GetEntityCoords(lastVehicle)
		local distance = #(targetCoords  - plyCoords)
        local vehicle = GetClosestVehicle(pos["x"], pos["y"], pos["z"], 2.7, 0, 71)
		
        if DoesEntityExist(vehicle) and distance <= 2.6 then
          CloseToVehicle = true
		  
        else
			-- if not ESX.UI.Menu.IsOpen("default", GetCurrentResourceName(), "inventory") then
				  CloseToVehicle = false
				  lastOpen = false
				--  ESX.UI.Menu.CloseAll()
				  print('close door 2')
		
				 
				  SetVehicleDoorShut(lastVehicle, 5, false)
				   if globalplate ~= nil then
						--TriggerServerEvent('e4fe04a4-bf78-477e-9b66-d18f8c253cf5',globalplate)
				   else
						if GetVehicleNumberPlateText(lastVehicle) ~= nil then
							--TriggerServerEvent('e4fe04a4-bf78-477e-9b66-d18f8c253cf5',GetVehicleNumberPlateText(lastVehicle))
						end
				   end
				  Wait(200)
			--end
        end
	  else
		Wait(50)
      end
    end
  end)

RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(xPlayer)
    PlayerData = xPlayer
    TriggerServerEvent('161f0939-550d-4373-a8b5-89c196cf90c4')
    lastChecked = GetGameTimer()
  end)


RegisterNetEvent('e292d5f9-b582-44a4-af64-d92faa4e3ecb')
AddEventHandler('e292d5f9-b582-44a4-af64-d92faa4e3ecb', function(xPlayer)
		openmenuvehicle()
 end)




function OpenCoffreInventoryMenu(plate, max, myVeh)
  ESX.TriggerServerCallback('39139597-f11a-4ebd-97ae-ba15ed575d21', function(inventory)
	
		print('received inventory info from server')
	  if inventory.weight == nil then
		text = _U("trunk_info", plate, (0 / 1000), (max / 1000))
	  else
		text = _U("trunk_info", plate, (string.format("%.2f", inventory.weight / 1000)), (max / 1000))
	  end
      data = {plate = plate, max = max, myVeh = myVeh, text = text}
      TriggerEvent('85b1b203-c89b-4252-9177-f8d92cbbc51d', data, inventory.blackMoney, inventory.items, inventory.weapons)
    end, plate)
end



function OpenCoffreInventoryMenuG(plate, max, myVeh)
  ESX.TriggerServerCallback('7bd966ba-a327-4561-9db3-c215246efe24', function(inventory)
	
		print('received inventory info from server for glvoebox')
	  if inventory.weight == nil then
		text = _U("glove_info", plate, (0 / 1000), (max / 1000))
	  else
		text = _U("glove_info", plate, (string.format("%.2f", inventory.weight / 1000)), (max / 1000))
	  end
      data = {plate = plate, max = max, myVeh = myVeh, text = text}
	  ExecuteCommand("me opens glovebox")
      TriggerEvent('a60448dc-eb7b-4161-85a5-5d2b8a2a6130', data, inventory.blackMoney, inventory.items, inventory.weapons)
    end, plate)
end

function all_trim(s)
  if s then
    return s:match "^%s*(.*)":match "(.-)%s*$"
  else
    return "noTagProvided"
  end
end

function dump(o)
  if type(o) == "table" then
    local s = "{ "
    for k, v in pairs(o) do
      if type(k) ~= "number" then
        k = '"' .. k .. '"'
      end
      s = s .. "[" .. k .. "] = " .. dump(v) .. ","
    end
    return s .. "} "
  else
    return tostring(o)
  end
end
