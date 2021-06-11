-- Version 0.1
-- Devloped by Everett aka Mr. Yellow aka Munky aka De_verett
local carSpawned = false
local newVeh = nil
local inLightbarMenu = false
local lightBool = false
local sirenBool = false
local oldSirenBool = false
local controlsDisabled = false
local xCoord = 0
local yCoord = 0
local zCoord = 0
local xrot = 0.0
local yrot = 0.0
local zrot = 0.0
local snd_pwrcall = {}
local airHornSirenID = nil
local sirenTone = "RESIDENT_VEHICLES_SIREN_QUICK_03"--"VEHICLES_HORNS_SIREN_1"
local vehPlateBoolSavedData = nil
local isPlateCar = false
local isAirhornKeyPressed = false
local deleteVehicleLightbars = {}

local waittimer = 1000

Citizen.CreateThread(function()
    while true do
      Citizen.Wait(waittimer)
      if inLightbarMenu then
        printControlsText()
      end
        local player = GetPlayerPed(-1)
        if (IsControlJustReleased(1, 44)) then -- Q to turn on lights
         toggleLights()
         end
         if (IsControlJustReleased(1, 47)) then -- G to turn on siren
          sirenTone = "RESIDENT_VEHICLES_SIREN_QUICK_03" -- sets siren to default siren
         toggleSiren()
         end
         if (IsControlJustReleased(1, 210)) then -- Left control to change siren tone
          changeSirenTone()
          end
          if IsControlJustPressed(1, 184) and not isAirhornKeyPressed then
            playAirHorn(true)
            isAirhornKeyPressed = true
            if sirenBool then
              oldSirenBool = sirenBool
              toggleSiren()
            end
          end
          if IsControlJustReleased(1, 184) then
            playAirHorn(false)
            isAirhornKeyPressed = false
            if oldSirenBool then
              toggleSiren()
              oldSirenBool = false
            end
          end
          if isPlateCar then DisableControlAction(0,86,true) end -- Disables Veh horn
    end
  end)

function printControlsText()
                SetTextFont(0)
                SetTextProportional(1)
                SetTextScale(0.0, 0.4)
                SetTextColour(128, 128, 255, 255)
                SetTextDropshadow(0, 0, 0, 0, 255)
                SetTextEdge(1, 0, 0, 0, 255)
                SetTextDropShadow()
                SetTextOutline()
                SetTextEntry("STRING")
                AddTextComponentString("Use your ↑ ↓ → ← Arrow Keys for Lateral Movements, Pg Up and Pg Down for Altitude Change")
                DrawText(0.25, 0.9)
                -- 
                SetTextFont(0)
                SetTextProportional(1)
                SetTextScale(0.0, 0.4)
                SetTextColour(128, 128, 255, 255)
                SetTextDropshadow(0, 0, 0, 0, 255)
                SetTextEdge(1, 0, 0, 0, 255)
                SetTextDropShadow()
                SetTextOutline()
                SetTextEntry("STRING")
                AddTextComponentString("and Insert and Delete for rotation. SPACE to save, DELETE to cancel")
                DrawText(0.25, 0.93)
end
  


function toggleLights()
  local player = GetPlayerPed(-1)
  TriggerServerEvent('5788e869-a885-4044-8492-90ed104565bc', GetVehicleNumberPlateText(GetVehiclePedIsIn(player, false)))
  if sirenBool == true then
  TriggerServerEvent('0f39d41c-a8f7-4f17-9307-379f05028e4e', GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false)))
  end
end

function changeSirenTone()
  local currPlate = GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false))
  if not(vehPlateBoolSavedData == currPlate) then
      TriggerServerEvent('1fc4bbb5-eda2-4488-a088-ce65c0ed273a')
      while true do
          if(vehPlateBoolSavedData == GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false))) then
              break
          end
          if not(currPlate == GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false))) then
              return
          end
          Citizen.Wait(10)
      end
  end
if isPlateCar then
  if sirenTone == "VEHICLES_HORNS_SIREN_1" then
    sirenTone = "VEHICLES_HORNS_SIREN_2"
    toggleSiren()
    toggleSiren()
  elseif sirenTone == "VEHICLES_HORNS_SIREN_2" then
    sirenTone = "VEHICLES_HORNS_POLICE_WARNING"
    toggleSiren()
    toggleSiren()
  else
    sirenTone = "VEHICLES_HORNS_SIREN_1"
    toggleSiren()
    toggleSiren()
  end
end
end

RegisterNetEvent('bd90d142-86c7-47c6-8740-8e7d71807fdf')
AddEventHandler('bd90d142-86c7-47c6-8740-8e7d71807fdf', function(lightbarModel)
  lightMenu(lightbarModel)
end)

RegisterNetEvent('08df2563-be9e-4b67-b883-f066437d743d')
AddEventHandler('08df2563-be9e-4b67-b883-f066437d743d', function(lightsArray, lightsStatus, hostVehiclePointer)
  Citizen.CreateThread(function()
    for k,v in pairs(lightsArray) do 
      NetworkRequestControlOfNetworkId(v) 
      while not NetworkHasControlOfNetworkId(v) do
        Citizen.Wait(0)
      end
      local test1 = NetToVeh(v)
      lightBool = lightsStatus
      SetVehicleSiren(test1, not lightsStatus)
	  end
  end)
end)

function toggleSiren()
  if lightBool == false then
    TriggerServerEvent('0f39d41c-a8f7-4f17-9307-379f05028e4e', GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false)))
  end
end

function spawnLightbar(lightbarModel)
  print("Got to spawn")
  local player = GetPlayerPed(-1)
  local vehiclehash1 = GetHashKey(lightbarModel)
  RequestModel(vehiclehash1)
  Citizen.CreateThread(function() 
      while not HasModelLoaded(vehiclehash1) do
          Citizen.Wait(100)
      end
      local coords = GetEntityCoords(player)
      newVeh = CreateVehicle(vehiclehash1, coords.x, coords.y, coords.z, GetEntityHeading(PlayerPedId()), true, 0)
      SetEntityCollision(newVeh, false, false)
      SetVehicleDoorsLocked(newVeh, 2)
      SetEntityAsMissionEntity(newVeh, true, true)
  end)
end

function lightMenu(lightbarModel)
  if not inLightbarMenu then
    inLightbarMenu = true
    local player = GetPlayerPed(-1)
    spawnLightbar(lightbarModel)
    controlsDisabled = true
    disableControls()
    AttachEntityToEntity(newVeh, GetVehiclePedIsIn(player, false), 0, 0, 0, 0, 0.0, 0.0, 0.0, true, true, true, true, 0, true)
    while true do
      Citizen.Wait(10)
      --resetOffSets()
      moveObj(newVeh)
      if (IsControlJustReleased(1, 22)) then -- attatch obj and close
        TriggerServerEvent('b293261c-21b4-4466-8f43-ba880672c193', GetVehicleNumberPlateText(GetVehiclePedIsIn(player, false)), VehToNet(newVeh), GetVehiclePedIsIn(player, false))
        inLightbarMenu = false
        newVeh=nil
        controlsDisabled = false
        if(vehPlateBoolSavedData == GetVehicleNumberPlateText(GetVehiclePedIsIn(player, false))) then
          isPlateCar = true
        end
        break
      end  
      if (IsControlJustReleased(1, 177)) then -- close menu
        inLightbarMenu = false
        DeleteVehicle(newVeh)
        newVeh = nil
        controlsDisabled = false
        break
      end  
    end
  end
end

function moveObj(veh)
  local player = GetPlayerPed(-1)
  local MOVEMENT_CONSTANT = 0.01
  local vehOffset = GetOffsetFromEntityInWorldCoords(newVeh, 0.0, 1.3, 0.0)

  if (IsControlJustReleased(1, 121)) then -- rotate 180 upside down
    yrot = yrot + 180.0
    print("yrot = " .. yrot)
    DetachEntity(newVeh, 0, 0)
    AttachEntityToEntity(newVeh, GetVehiclePedIsIn(player, false), 0, xCoord, yCoord, zCoord, xrot, yrot, zrot, true, true, true, true, 0, true)
   end  
   if (IsControlJustReleased(1, 178)) then -- rotate 180 
    zrot = zrot + 180
    DetachEntity(newVeh, 0, 0)
    AttachEntityToEntity(newVeh, GetVehiclePedIsIn(player, false), 0, xCoord, yCoord, zCoord, xrot, yrot, zrot, true, true, true, true, 0, true)
   end  
  if (IsControlPressed(1, 190)) then -- move forward
    xCoord = xCoord + MOVEMENT_CONSTANT
    DetachEntity(newVeh, 0, 0)
    AttachEntityToEntity(newVeh, GetVehiclePedIsIn(player, false), 0, xCoord, yCoord, zCoord, xrot, yrot, zrot, true, true, true, true, 0, true)
   end       
   if (IsControlPressed(1, 189)) then -- move backwards
    xCoord = xCoord - MOVEMENT_CONSTANT
    DetachEntity(newVeh, 0, 0)
    AttachEntityToEntity(newVeh, GetVehiclePedIsIn(player, false), 0, xCoord, yCoord, zCoord, xrot, yrot, zrot, true, true, true, true, 0, true)
   end        
   if (IsControlPressed(1, 27)) then -- move right
    yCoord = yCoord + MOVEMENT_CONSTANT
    DetachEntity(newVeh, 0, 0)
    AttachEntityToEntity(newVeh, GetVehiclePedIsIn(player, false), 0, xCoord, yCoord, zCoord, xrot, yrot, zrot, true, true, true, true, 0, true)
   end       
   if (IsControlPressed(1, 187)) then -- move left
    yCoord = yCoord - MOVEMENT_CONSTANT
    DetachEntity(newVeh, 0, 0)
    AttachEntityToEntity(newVeh, GetVehiclePedIsIn(player, false), 0, xCoord, yCoord, zCoord, xrot, yrot, zrot, true, true, true, true, 0, true)
   end     
   if (IsControlPressed(1, 208)) then -- move up
    zCoord = zCoord + MOVEMENT_CONSTANT
    DetachEntity(newVeh, 0, 0)
    AttachEntityToEntity(newVeh, GetVehiclePedIsIn(player, false), 0, xCoord, yCoord, zCoord, xrot, yrot, zrot, true, true, true, true, 0, true)
   end      
   if (IsControlPressed(1, 207)) then -- move down
    zCoord = zCoord - MOVEMENT_CONSTANT
    DetachEntity(newVeh, 0, 0)
    AttachEntityToEntity(newVeh, GetVehiclePedIsIn(player, false), 0, xCoord, yCoord, zCoord, xrot, yrot, zrot, true, true, true, true, 0, true)
   end
end

function resetOffSets()
  xCoord = 0
  yCoord = 0
  zCoord = 0
  xrot = 0
  yrot = 0
  zrot = 0
end

function disableControls()
  Citizen.CreateThread(function()
    while controlsDisabled do
      Citizen.Wait(0)
          DisableControlAction(0,21,true) -- disable sprint
          DisableControlAction(0,24,true) -- disable attack
          DisableControlAction(0,25,true) -- disable aim
          DisableControlAction(0,47,true) -- disable weapon
          DisableControlAction(0,58,true) -- disable weapon
          DisableControlAction(0,263,true) -- disable melee
          DisableControlAction(0,264,true) -- disable melee
          DisableControlAction(0,257,true) -- disable melee
          DisableControlAction(0,140,true) -- disable melee
          DisableControlAction(0,141,true) -- disable melee
          DisableControlAction(0,142,true) -- disable melee
          DisableControlAction(0,143,true) -- disable melee
          DisableControlAction(0,75,true) -- disable exit vehicle
          DisableControlAction(27,75,true) -- disable exit vehicle
          DisableControlAction(0,32,true) -- move (w)
          DisableControlAction(0,34,true) -- move (a)
          DisableControlAction(0,33,true) -- move (s)
          DisableControlAction(0,35,true) -- move (d)
          DisableControlAction(0,71,true) -- move (d)
          DisableControlAction(0,72,true) -- move (d)
    end
  end)
end


RegisterNetEvent('90d19e75-12b1-4042-b19c-bbaad71813a7')
AddEventHandler('90d19e75-12b1-4042-b19c-bbaad71813a7', function(sender, toggle)

	local player_s = GetPlayerFromServerId(sender)
	local ped_s = GetPlayerPed(player_s)
	if DoesEntityExist(ped_s) and not IsEntityDead(ped_s) then
		local sid = GetPlayerServerId(PlayerId())  --myserverid
		local myped = GetPlayerPed(-1)
		if sid == sender and ped_s == myped then
			if IsPedInAnyVehicle(ped_s, false) then
				local veh = GetVehiclePedIsUsing(ped_s)
				TogPowercallStateForVeh(veh, toggle)
			end
		elseif sid ~= sender and ped_s ~= myped then 
			if IsPedInAnyVehicle(ped_s, false) then
				local veh = GetVehiclePedIsUsing(ped_s)
				TogPowercallStateForVeh(veh, toggle)
			end
		end
	end
end)

function TogPowercallStateForVeh(veh, toggle)
	if DoesEntityExist(veh) and not IsEntityDead(veh) then
		if toggle == true then
			if snd_pwrcall[veh] == nil then
        snd_pwrcall[veh] = GetSoundId()
          PlaySoundFromEntity(snd_pwrcall[veh], sirenTone, veh, 0, 0, 0)
          sirenBool = true
			end
		else
      if snd_pwrcall[veh] ~= nil then
        --sirenToneNumber = 1
				StopSound(snd_pwrcall[veh])
				ReleaseSoundId(snd_pwrcall[veh])
        snd_pwrcall[veh] = nil
        sirenBool = false
			end
		end
	end
end


function playAirHorn(bool)
  local tempVeh = GetVehiclePedIsIn(GetPlayerPed(-1), false)
  local currPlate = GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false))
  if not(vehPlateBoolSavedData == currPlate) then
      TriggerServerEvent('1fc4bbb5-eda2-4488-a088-ce65c0ed273a')
      while true do
          if(vehPlateBoolSavedData == GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false))) then
              break
          end
          if not(currPlate == GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false))) then
              return
          end
          Citizen.Wait(10)
      end
  end
  if not(tempVeh == nil) and isPlateCar and vehPlateBoolSavedData == currPlate then
      if bool then
          airHornSirenID = GetSoundId()
          PlaySoundFromEntity(airHornSirenID, "SIRENS_AIRHORN", tempVeh, 0, 0, 0)
      end
      if not bool then
          StopSound(airHornSirenID)
          ReleaseSoundId(airHornSirenIDs)
          airHornSirenID = nil
      end
  end
end


RegisterNetEvent('bebb7138-4099-42f5-bfb8-d4ee0f6b4a18')
AddEventHandler('bebb7138-4099-42f5-bfb8-d4ee0f6b4a18', function(platesArr)
  local player = GetPlayerPed(-1)
  local currPlate = GetVehicleNumberPlateText(GetVehiclePedIsIn(player, false))
  for k,v in pairs(platesArr) do 
    if currPlate == v then
      vehPlateBoolSavedData = currPlate
      isPlateCar = true
      return
		end
  end
  vehPlateBoolSavedData = currPlate
  isPlateCar = false
end)

function deleteArray()
  for k,v in pairs(deleteVehicleLightbars) do 
    DeleteVehicle(NetToVeh(v))
  end
end

RegisterNetEvent('d85fa724-47c6-40c9-9375-149a2de4431d')
AddEventHandler('d85fa724-47c6-40c9-9375-149a2de4431d', function(mainVehPlate)
  TriggerServerEvent('7e821e58-0689-45c4-96f8-b76bfc254157', mainVehPlate)
end)

RegisterNetEvent('d4bc46e0-d7ba-4117-b2cb-de5453753ef8')
AddEventHandler('d4bc46e0-d7ba-4117-b2cb-de5453753ef8', function(plates)
  deleteVehicleLightbars = plates
  if sirenBool then
    toggleLights()
  end
  deleteArray()
  isPlateCar = false
  lightBool = false
  sirenBool = false
end)

RegisterNetEvent('dbb73966-15cd-44bc-b7ec-1cc8260f2997')
AddEventHandler('dbb73966-15cd-44bc-b7ec-1cc8260f2997', function()
  xCoord = 0
  yCoord = 0
  zCoord = 0
  xrot = 0
  yrot = 0
  zrot = 0
end)


-------------------MENU-------------------------


local stationGarage = {
--    {x=452.115966796875, y=-1018.10681152344, z=28.55, r=10}, -- Mission row PD
--    {x=1866.84, y=3697.15, z=33.65, r=20}, -- Sandy Shores PD
   -- {x=-457.88, y=6024.79, z=31.4, r=20}, -- Paleto Bay PD
--    {x=-237.292, y=6332.39, z=32.8, r=20}, -- Paleto Medical
--    {x=1842.364, y=3707.348, z=33.57, r=20}, -- Sandy Medical (x=1842.64, y=3667.10, z=33.9)
    --{x=-657.582, y=293.92, z=81.9, r=10}, -- Eclipse Medical
    --{x=-875.983, y=-294.837, z=39.9, r=10}, -- Portola Medical
--    {x=1169.01, y=-1509.82, z=34.9, r=20}, -- St Fiacre Medical
--    {x=303.086, y=-1439.04, z=29.84, r=20}, -- Central Medical
------    {x=289.94, y=-591.10, z=43.12, r=20}, -- Pillbox
--        {x=-1073.0, y=-856.19, z=4.87, r=20}, -- Vespucci PD
--           {x=2030.98, y=3002.75, z=-72.70, r=10}, -- Vinewood PD
--        {x=386.35, y=-1633.96, z=29.29, r=20}, -- Innocence
----        {x=-570.88, y=-143.93, z=37.54, r=20}, -- Rockford
--        {x=969.84, y=-3020.10, z=-39.65, r=20}, -- Rockford

  --  {x=-468.105, y=-338.575, z=34.45, r=10}, -- Mount Zonah Medical
}

   
_menuPool = MenuPool.New()
mainMenu = NativeUI.CreateMenu("Lightbar Menu", "")
_menuPool:Add(mainMenu)
_menuPool:RefreshIndex()
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(waittimer)
        _menuPool:ProcessMenus()
       
--[[
	   if IsControlJustReleased(0, 289)  then -- F2
        				--if exports.policejob:getIsInService() then 

            for i = 1, #stationGarage do
            ply = GetPlayerPed(-1)
            plyCoords = GetEntityCoords(ply, 0)
            local distance = GetDistanceBetweenCoords(stationGarage[i].x, stationGarage[i].y, stationGarage[i].z, plyCoords["x"], plyCoords["y"], plyCoords["z"], true)
            if(distance < stationGarage[i].r) then 
				mainMenu:Clear()               
				lightbarMenu(mainMenu)
				_menuPool:RefreshIndex()
				mainMenu:Visible(not mainMenu:Visible())
			end
		end 
--end
     end--]]
    end
end)


RegisterNetEvent('2f0a8194-ec62-41c5-8e73-28ee70f42687')
AddEventHandler('2f0a8194-ec62-41c5-8e73-28ee70f42687', function()
	waittimer = 0
	mainMenu:Clear()               
	lightbarMenu(mainMenu)
	_menuPool:RefreshIndex()
	mainMenu:Visible(not mainMenu:Visible())
end)

function lightbarMenu(menu)
    lightbarIndex = 1

    local item1 = NativeUI.CreateItem("Small Stick Light ", "")
    mainMenu:AddItem(item1)
    local item2 = NativeUI.CreateItem("Blue Stick Light ", "")
    mainMenu:AddItem(item2)
    local item3 = NativeUI.CreateItem("Red Stick Light ", "")
    mainMenu:AddItem(item3)
    local item4 = NativeUI.CreateItem("Blue Dome Light ", "")
    mainMenu:AddItem(item4)
    local item5 = NativeUI.CreateItem("Remove All Lights ", "")
    mainMenu:AddItem(item5)
    local item6 = NativeUI.CreateItem("Center Lightbar ", "")
    mainMenu:AddItem(item6)

    mainMenu.OnIndexChange= function(menu, newindex)
        print("Old index: " .. lightbarIndex)
        lightbarIndex = newindex
        print("New index: " .. lightbarIndex)
    end

    mainMenu.OnItemSelect = function (sender, item, index)
        if lightbarIndex == 1 then
            TriggerEvent('bd90d142-86c7-47c6-8740-8e7d71807fdf', "lightbarTwoSticks")
        elseif lightbarIndex == 2 then
            TriggerEvent('bd90d142-86c7-47c6-8740-8e7d71807fdf', "longLightbar")
        elseif lightbarIndex == 3 then
            TriggerEvent('bd90d142-86c7-47c6-8740-8e7d71807fdf', "longLightbarRed")
        elseif lightbarIndex == 4 then
            TriggerEvent('bd90d142-86c7-47c6-8740-8e7d71807fdf', "fbiold")
        elseif lightbarIndex == 5 then
          TriggerEvent('d85fa724-47c6-40c9-9375-149a2de4431d', GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false)))
        elseif lightbarIndex == 6 then
          TriggerEvent('dbb73966-15cd-44bc-b7ec-1cc8260f2997')
        end
    end
end
lightbarMenu(mainMenu)

