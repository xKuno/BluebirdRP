--AddSpeedZoneForCoord(float x, float y, float z, float radius, float speed, BOOL p5);

local speedZoneActive = false
local blip
local speedZone
local GUITime = 0
local speedzones = {}

local police = false
_menuPool = NativeUI.CreatePool()



function ShowNotification(text)
  SetNotificationTextEntry("STRING")
  AddTextComponentString(text)
  DrawNotification(false, false)
end




function ObjectsSubMenu(menu)
  local submenu = _menuPool:AddSubMenu(menu, "Objects Menu")
	_menuPool:MouseControlsEnabled (false)
	_menuPool:MouseEdgeEnabled (false)
	_menuPool:ControlDisablingEnabled(true)


  local objects = {
    "Police Barrier",
    "Big Cone",
    "Small Cone",
    "Scene Lights",
    "Gazebo",
}
  local objectlist = NativeUI.CreateListItem("Object Spawning", objects, 1, "Press enter to select the object to spawn.")
  local deletebutton = NativeUI.CreateItem("Delete", "Delete nearest object.")


  submenu:AddItem(deletebutton)
  deletebutton.Activated = function(sender, item, index)
    local theobject1 = 'prop_barrier_work05'
    local object1 = GetHashKey(theobject1)
    local x, y, z = table.unpack(GetEntityCoords(PlayerPedId(), true))
    if DoesObjectOfTypeExistAtCoords(x, y, z, 0.9, object1, true) then
        local obj1 = GetClosestObjectOfType(x, y, z, 0.9, object1, false, false, false)
        DeleteObject(obj1)
    end

    local theobject2 = 'prop_roadcone01a'
    local object2 = GetHashKey(theobject2)
    if DoesObjectOfTypeExistAtCoords(x, y, z, 0.9, object2, true) then
        local obj2 = GetClosestObjectOfType(x, y, z, 0.9, object2, false, false, false)
        DeleteObject(obj2)
    end

    local theobject4 = 'prop_gazebo_02'
    local object4 = GetHashKey(theobject4)
    if DoesObjectOfTypeExistAtCoords(x, y, z, 0.9, object4, true) then
        local obj4 = GetClosestObjectOfType(x, y, z, 0.9, object4, false, false, false)
        DeleteObject(obj4)
    end

    local theobject5 = 'prop_roadcone02b'
    local object5 = GetHashKey(theobject5)
    if DoesObjectOfTypeExistAtCoords(x, y, z, 0.9, object5, true) then
        local obj5 = GetClosestObjectOfType(x, y, z, 0.9, object5, false, false, false)
        DeleteObject(obj5)
    end

    local theobject3 = 'prop_worklight_03b'
    local object3 = GetHashKey(theobject3)
    if DoesObjectOfTypeExistAtCoords(x, y, z, 0.9, object3, true) then
        local obj3 = GetClosestObjectOfType(x, y, z, 0.9, object3, false, false, false)
        DeleteObject(obj3)
    end
  end

  submenu:AddItem(objectlist)
  objectlist.OnListSelected = function(sender, item, index)
    local Player = GetPlayerPed(-1)
    local heading = GetEntityHeading(Player)
    local x, y, z = table.unpack(GetEntityCoords(Player, true))
     local object = item:IndexToItem(index)
        if object == objects[1] then
        local objectname = 'prop_barrier_work05'
          RequestModel(objectname)
          while not HasModelLoaded(objectname) do
            Citizen.Wait(1)
          end
            local obj = CreateObject(GetHashKey(objectname), x, y, z, true, false);
            PlaceObjectOnGroundProperly(obj)
            SetEntityHeading(obj, heading)
            FreezeEntityPosition(obj, true)
        elseif object == objects[2] then
            local objectname = 'prop_roadcone01a'
            RequestModel(objectname)
            while not HasModelLoaded(objectname) do
              Citizen.Wait(1)
            end
              local obj = CreateObject(GetHashKey(objectname), x, y, z, true, false);
              PlaceObjectOnGroundProperly(obj)
              SetEntityHeading(obj, heading)
              FreezeEntityPosition(obj, true)
        elseif object == objects[4] then
          local objectname = 'prop_worklight_03b'
          RequestModel(objectname)
          while not HasModelLoaded(objectname) do
            Citizen.Wait(1)
          end
            local obj = CreateObject(GetHashKey(objectname), x, y, z, true, false);
            PlaceObjectOnGroundProperly(obj)
            SetEntityHeading(obj, heading)
            FreezeEntityPosition(obj, true)
        elseif object == objects[3] then
            local objectname = 'prop_roadcone02b'
            RequestModel(objectname)
            while not HasModelLoaded(objectname) do
              Citizen.Wait(1)
            end
              local obj = CreateObject(GetHashKey(objectname), x, y, z, true, false);
              PlaceObjectOnGroundProperly(obj)
              SetEntityHeading(obj, heading)
              FreezeEntityPosition(obj, true)
        elseif object == objects[5] then
              local objectname = 'prop_gazebo_02'
              RequestModel(objectname)
              while not HasModelLoaded(objectname) do
                Citizen.Wait(1)
              end
                local obj = CreateObject(GetHashKey(objectname), x, y, z, true, false);
                PlaceObjectOnGroundProperly(obj)
                SetEntityHeading(obj, heading)
                FreezeEntityPosition(obj, true)
        end
end

end

function SpeedZoneSubMenu(menu)
  local submenu = _menuPool:AddSubMenu(menu, "Speed Zone")
  	_menuPool:MouseControlsEnabled (false)
	_menuPool:MouseEdgeEnabled (false)
	_menuPool:ControlDisablingEnabled(true)
  local radiusnum = {
	"10",
    "25",
    "50",
    "75",
    "100",
    "125",
    "150",
    "175",
    "200",
	"250",
	"300",
  }

  local speednum = {
    "0",
    "5",
    "10",
    "15",
    "20",
    "25",
    "30",
    "35",
    "40",
    "45",
    "50",
  }

  local zonecreate = NativeUI.CreateItem("Create Zone", "Creates a zone with the radius and speed specified.")
  local zoneradius = NativeUI.CreateSliderItem("Radius", radiusnum, 1, false)
  local zonespeed = NativeUI.CreateListItem("Speed", speednum, 1)
  local zonedelete = NativeUI.CreateItem("Delete Zone", "Deletes your placed zone.")

  submenu:AddItem(zoneradius)
  submenu:AddItem(zonespeed)
  submenu:AddItem(zonecreate)
  submenu:AddItem(zonedelete)

  zonecreate:SetRightBadge(BadgeStyle.Tick)

  submenu.OnSliderChange = function(sender, item, index)
        radius = item:IndexToItem(index)
        ShowNotification("Changing radius to ~r~" .. radius)
  end

  submenu.OnListChange = function(sender, item, index)
    speed = item:IndexToItem(index)
    ShowNotification("Changing speed to ~r~" .. speed)
  end

  zonedelete.Activated = function(sender, item, index)
      --TriggerServerEvent('aa11f94e-5d66-4942-9416-73c86bdfc395')
	  if GUITime < (GetGameTimer() - 2000) then
		  GUITime = GetGameTimer()
		  TriggerEvent('245f4c9d-2641-425b-b1f7-8404ac83b983')
		  ShowNotification("Disabled zones.")
	  else
		 ShowNotification("Too quick, action ignored")
	  end
  end

  zonecreate.Activated = function(sender, item, index)


	if GUITime < (GetGameTimer() - 2000) then
      if not speed then
        speed = 0
      end

      if not radius then
        ShowNotification("~r~Please change the radius!")
        return
      end

          speedZoneActive = true
          ShowNotification("Created Speed Zone.")
          local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1)))
          radius = radius + 0.0
          speed = speed + 0.0
		 
		  local rawspeed = speed / 1.609
		 --Km/H
      
          local streetName, crossing = GetStreetNameAtCoord(x, y, z)
          streetName = GetStreetNameFromHashKey(streetName)
      
          local message = "^* ^1Traffic Announcement: ^r^*^7Police have ordered that traffic on ^2" .. streetName .. " ^7is to travel at a speed of ^2" .. speed .. "/kmh ^7." 
      

		  TriggerServerEvent('e6b6c764-db37-4d9e-b4ff-2e7cb732d258', message, rawspeed, radius, x, y, z , nil ,false, math.random(1,999999))
	else
		 ShowNotification("Too quick, action ignored")
	end

  end

end


function SpikesZone(menu)
  local submenu = _menuPool:AddSubMenu(menu, "Spike Strip")
	_menuPool:MouseControlsEnabled (false)
	_menuPool:MouseEdgeEnabled (false)
	_menuPool:ControlDisablingEnabled(true)
  local zonecreate = NativeUI.CreateItem("Create Spikes", "Creates a zone with the radius and speed specified.")
  local zonedelete = NativeUI.CreateItem("Delete Spikes", "Deletes your placed zone.")

  submenu:AddItem(zonecreate)
  submenu:AddItem(zonedelete)

  zonecreate:SetRightBadge(BadgeStyle.Tick)


  zonedelete.Activated = function(sender, item, index)
      --TriggerServerEvent('aa11f94e-5d66-4942-9416-73c86bdfc395')
	  TriggerEvent('245f4c9d-2641-425b-b1f7-8404ac83b983','spikes')
      ShowNotification("Disabled zones.")
  end

  zonecreate.Activated = function(sender, item, index)

        speedZoneActive = true
        ShowNotification("Created Spike Strips Zone.")
		local spikeobj
		local objectname = `p_ld_stinger_s`
		RequestModel(objectname)
		while not HasModelLoaded(objectname) do
		  Citizen.Wait(1)
		end
		local coords, forward = GetEntityCoords(PlayerPedId()), GetEntityForwardVector(PlayerPedId())
		local objectCoords = (coords + forward * 4.5)
		local x, y, z = table.unpack(objectCoords)
		spikeobj = CreateObject(objectname, x, y, z, false, false);
		PlaceObjectOnGroundProperly(spikeobj)
		 x, y, z = table.unpack(GetEntityCoords(spikeobj))
		--
		SetEntityHeading(spikeobj, GetEntityHeading(PlayerPedId()))
		FreezeEntityPosition(spikeobj, true)
		DeleteEntity(spikeobj)
		local speed = 60.0
	    local rawspeed = speed / 1.609
		 --Km/H
      
          local streetName, crossing = GetStreetNameAtCoord(x, y, z)
          streetName = GetStreetNameFromHashKey(streetName)
      
          local message = "^* ^1Traffic Announcement: ^r^*^7Police have ordered that traffic on ^2" .. streetName .. " ^7is to travel at a speed of ^2" .. speed .. "/kmh ^7." 
      
          TriggerServerEvent('e6b6c764-db37-4d9e-b4ff-2e7cb732d258', message, rawspeed, 30.0, x, y, z , GetEntityHeading(PlayerPedId()) ,true, math.random(1,999999))

  end

end


Citizen.CreateThread(function()
  while true do
      Citizen.Wait(0)
      _menuPool:ProcessMenus()
     -- if IsControlJustPressed(0, 166) and GetLastInputMethod( 0 ) then
        --  trafficmenu:Visible(not trafficmenu:Visible())
      --end
  end
end)

RegisterNetEvent('7441d8b3-1429-489d-bfd7-b105993e3883')
AddEventHandler('7441d8b3-1429-489d-bfd7-b105993e3883', function(stype)
	police = false
	if stype ~= nil then
		police = stype
	end
    _menuPool = NativeUI.CreatePool()
	trafficmenu = NativeUI.CreateMenu("Scene Menu", "~b~Traffic Policing Helper (By Kye Jones)")
	_menuPool:Add(trafficmenu)
	_menuPool:MouseControlsEnabled (false)
	_menuPool:MouseEdgeEnabled (false)
	_menuPool:ControlDisablingEnabled(true)
	ObjectsSubMenu(trafficmenu)
	SpeedZoneSubMenu(trafficmenu)

		SpikesZone(trafficmenu)

	_menuPool:ProcessMenus()
	trafficmenu:Visible(not trafficmenu:Visible())
end)

RegisterNetEvent('15f6df85-d2c6-4efd-a4e3-b041d5489583')
AddEventHandler('15f6df85-d2c6-4efd-a4e3-b041d5489583', function()
	trafficmenu = NativeUI.CreateMenu("Scene Menu", "~b~Traffic Policing Helper (By Kye Jones)")
	_menuPool:Add(trafficmenu)
	_menuPool:MouseControlsEnabled (false)
	_menuPool:MouseEdgeEnabled (false)
	_menuPool:ControlDisablingEnabled(true)
	ObjectsSubMenu(trafficmenu)
	SpeedZoneSubMenu(trafficmenu)
	_menuPool:ProcessMenus()
	trafficmenu:Visible(not trafficmenu:Visible())
end)


		  SetBlipColour(blip,10)
		  SetBlipAlpha(blip,30)
		  SetBlipSprite(blip,3)

RegisterNetEvent('21614fac-a662-4df2-9f6d-b8c3ec4f4350')
AddEventHandler('21614fac-a662-4df2-9f6d-b8c3ec4f4350', function(speed, radius, x, y, z, heading, spike, id)

	local r2 = radius * 6
	blip = nil
	if spike == false then
		print('add blip')
		blip = AddBlipForRadius(x, y, z, r2)
			  SetBlipColour(blip,idcolor)
			  SetBlipColour(blip,10)
			  SetBlipAlpha(blip,80)
			  SetBlipSprite(blip,3)
			  SetBlipDisplay(blip, 5)
	end
  speedZone = AddSpeedZoneForCoord(x, y, z, radius, speed, false)
  
  local spikeobj
  if spike == true then
		print('creating a spike zone')
		local objectname = `p_ld_stinger_s`
		RequestModel(objectname)
		while not HasModelLoaded(objectname) do
		  Citizen.Wait(1)
		end

		spikeobj = CreateObject(objectname, x, y, z, false, false);
		SetEntityHeading(spikeobj, heading)
		--PlaceObjectOnGroundProperly(obj)
		SetEntityHeading(spikeobj, heading)
		FreezeEntityPosition(spikeobj, true)
  end
  
  print('adding zone')

  table.insert(speedzones, {x, y, z, speedZone, blip, speed, radius, heading, spike, spikeobj, id})
  
  

end)

RegisterNetEvent('c8c5e496-ff89-4515-8520-bcaf7e930be9')
AddEventHandler('c8c5e496-ff89-4515-8520-bcaf7e930be9', function(sz)

    for i = 1, #sz, 1 do
        
		TriggerEvent('21614fac-a662-4df2-9f6d-b8c3ec4f4350',sz[i][4],sz[i][5],sz[i][1], sz[i][2], sz[i][3],sz[i][6])

    end
end)


Citizen.CreateThread(function()
	local notified = false
	local z = 500
	while true do
		Citizen.Wait(z)
		
		local isclose = false
		if NetworkIsSessionStarted() then
			local playerPed = PlayerPedId()
			local playerloc = GetEntityCoords(playerPed, true)
			local distance = 1000
			local zonesize = 0
			local enginekill = false
			local spikestrip = false
			
			for i = 1, #speedzones, 1 do

				distance = #(vector3(speedzones[i][1], speedzones[i][2], speedzones[i][3]) - playerloc )

				if distance < (speedzones[i][7] + 85) and speedzones[i][9] == false then
					isclose = true
					enginekill = true
					zonesize = speedzones[i][7]
					--closestDistance = distance
					--closestSpeedZone = i
					z = 50
				elseif distance < (speedzones[i][7] + 85) and speedzones[i][9] == true then
					isclose = true
					spikestrip = true
					zonesize = speedzones[i][7]
					z = 1
				end
				
			end
			if spikestrip == true then
				enginekill = false
				z = 1
			end
			if isclose == true then
				if notified == false and enginekill == true then
					notified = true
					TriggerEvent('2c4f07a6-bf05-4b02-ba86-fd4472391cbd',"~b~~h~Warning: ~s~~w~You are near an Emergency Worker Zone.\n~o~Speed Limit:~g~~h~ 40 km/h")
				end
				local vehicle = GetVehiclePedIsIn(playerPed,false)
				
				if distance < zonesize then
					if GetVehiclePedIsIn(playerPed,false) ~= 0 then
						local driver = GetPedInVehicleSeat(vehicle, -1)
						local vehclass = GetVehicleClass(vehicle)
						if enginekill == true then
							if GetEntitySpeed(vehicle) *3.6 > 85 and driver == playerPed and vehclass ~= 18 and  enginekill == true then
								TriggerEvent('9614090d-2944-4bc5-aa34-5412918f4777')
								ExecuteCommand("me I WAS SPEEDING @ " .. math.floor(GetEntitySpeed(vehicle) *3.6) .. " KM/H")
								SetVehicleBodyHealth(vehicle,100)
								Wait(5000)
							end
						end
						if spikestrip == true and distance < 1.5 then
							--Activate and blow vehicles wheels
							if vehicle ~= 0 then
		
								for i=0, 7, 1 do
									if IsVehicleTyreBurst(vehicle, i, true) == false then
									
										SetVehicleTyreBurst(vehicle, i, true, 1000)
									end
								end
							end
						end
					end
				end
			else
				notified = false
				z = 600
			end
		end
	end
end)



RegisterNetEvent('8aa08534-407d-4dce-9845-d1021d72acc9')
AddEventHandler('8aa08534-407d-4dce-9845-d1021d72acc9', function(idc)

	print ('received request to deactivate')
    local playerPed = GetPlayerPed(-1)
   -- local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
    local closestSpeedZone = nil
    local closestDistance = 1000
    for i = 1, #speedzones, 1 do
	
	--print( i .. ' *' .. speedzones[i][11] .. '* ' .. speedzones[i][6] .. ' ' .. speedzones[i][7] .. ' ' .. speedzones[i][1] .. ' ' .. speedzones[i][2] .. ' ' .. speedzones[i][3] )
		if idc == speedzones[i][11] then
			--print ( '       // ' .. i)
			closestSpeedZone = i
		end
    end
	if closestSpeedZone ~= nil then
		--print ('cleaning ' .. closestSpeedZone)
		--print( closestSpeedZone .. ' ' .. speedzones[closestSpeedZone][6] .. ' ' .. speedzones[closestSpeedZone][7] .. ' ' .. speedzones[closestSpeedZone][1] .. ' ' .. speedzones[closestSpeedZone][2] .. ' ' .. speedzones[closestSpeedZone][3])
		RemoveSpeedZone(speedzones[closestSpeedZone][4])
		RemoveBlip(speedzones[closestSpeedZone][5])
		
		if speedzones[closestSpeedZone][10] ~= nil then
			print('attempting to delete spike')
			DeleteEntity(speedzones[closestSpeedZone][10])
		end
		table.remove(speedzones, closestSpeedZone)
	else
		--print('cloest zone is nil')
	end
end)


RegisterNetEvent('245f4c9d-2641-425b-b1f7-8404ac83b983')
AddEventHandler('245f4c9d-2641-425b-b1f7-8404ac83b983', function(spikezones)
	
    if speedzones == nil then
      return
    end
	if spikezones == nil then
		spikezones = false
	else 
		spikezones = true
	end
	
    local playerPed = PlayerPedId()
    local x, y, z = table.unpack(GetEntityCoords(playerPed, true))
    local closestSpeedZone = 0
    local closestDistance = 5000
    for i = 1, #speedzones, 1 do
        local distance = #(vector3(speedzones[i][1], speedzones[i][2], speedzones[i][3])- vector3(x, y, z))
		
        if distance < closestDistance and ((speedzones[i][10] ~= nil and spikezones == true) or (speedzones[i][10] == nil and spikezones == false)) then
            closestDistance = distance
            closestSpeedZone = i
        end
    end
	--print ('REMOVE BLIP SEND NOTICE' .. speedzones[closestSpeedZone][6] .. ' ' .. speedzones[closestSpeedZone][7] .. ' ' ..  speedzones[closestSpeedZone][1]  .. ' ' .. speedzones[closestSpeedZone][2] .. ' ' .. speedzones[closestSpeedZone][3])
	
	if closestSpeedZone ~= 0 then
		print('submit delete request')
		local sz1 = speedzones[closestSpeedZone][6]
		local sz2 = speedzones[closestSpeedZone][7]
		local sz3 = speedzones[closestSpeedZone][1]
		local sz4 = speedzones[closestSpeedZone][2]
		local sz5 = speedzones[closestSpeedZone][3]
		local sz6 = speedzones[closestSpeedZone][11]

		--TriggerServerEvent('ZoneDeactivateS', speedzones[closestSpeedZone][7], speedzones[closestSpeedZone][1], speedzones[closestSpeedZone][2], speedzones[closestSpeedZone][3])
		TriggerServerEvent('6fd9c11f-14e0-4ec5-a69e-bcf685615161',sz6)
	end

end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		if NetworkIsSessionStarted() then
			print('trigger retrieve')
			TriggerServerEvent('71539b27-9bf9-48f9-81b7-70404ed24c1b')
			return
		end
	end
end)