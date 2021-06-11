local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local PlayerData              = {}
local HasAlreadyEnteredMarker = false
local LastZone                = nil
local LastStation              = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local OnJob                   = false
local CurrentlyTowedVehicle   = nil
local Blips                   = {}
local NPCOnJob                = false
local NPCTargetTowable        = nil
local NPCTargetTowableZone    = nil
local NPCHasSpawnedTowable    = false
local NPCLastCancel           = GetGameTimer() - 5 * 60000
local NPCHasBeenNextToTowable = false
local NPCTargetDeleterZone    = false
local IsDead                  = false
local IsBusy                  = false

local solid_toggle = false
local solid_text = "FALSE"

ESX                           = nil

local isduty 				     = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	Citizen.Wait(2000)
	PlayerData = ESX.GetPlayerData()
end)

function SelectRandomTowable()

  local index = GetRandomIntInRange(1,  #Config.Towables)
  for l,w in pairs(Config.Zones) do
	  for k,v in pairs(w) do
		if v.Pos.x == Config.Towables[index].x and v.Pos.y == Config.Towables[index].y and v.Pos.z == Config.Towables[index].z then
		  return k,w
		end
	  end
  end

end

function StartNPCJob()

  NPCOnJob = true

 local NPCTargetTowableZone, NPCStation = SelectRandomTowable()
  local zone  = Config.Zones[NPCStation][NPCTargetTowableZone]

  Blips['NPCTargetTowableZone'] = AddBlipForCoord(zone.Pos.x,  zone.Pos.y,  zone.Pos.z)
  SetBlipRoute(Blips['NPCTargetTowableZone'], true)

  ESX.ShowNotification(_U('drive_to_indicated'))
end

function StopNPCJob(cancel)

  if Blips['NPCTargetTowableZone'] ~= nil then
    RemoveBlip(Blips['NPCTargetTowableZone'])
    Blips['NPCTargetTowableZone'] = nil
  end

  if Blips['NPCDelivery'] ~= nil then
    RemoveBlip(Blips['NPCDelivery'])
    Blips['NPCDelivery'] = nil
  end


  Config.Zones[NPCStation][NPCTargetTowableZone].VehicleDelivery.Type = -1

  NPCOnJob                = false
  NPCTargetTowable        = nil
  NPCTargetTowableZone    = nil
  NPCStation			  = nil
  NPCHasSpawnedTowable    = false
  NPCHasBeenNextToTowable = false

  if cancel then
    ESX.ShowNotification(_U('mission_canceled'))
  else
    TriggerServerEvent('esx_mecanojob:onNPCJobCompleted')
  end

end

function OpenMecanoActionsMenu()

  local elements = {
    {label = _U('vehicle_list'),   value = 'vehicle_list'},
    {label = _U('work_wear'),      value = 'cloakroom'},
    {label = _U('civ_wear'),       value = 'cloakroom2'},
    {label = _U('deposit_stock'),  value = 'put_stock'},
    {label = _U('withdraw_stock'), value = 'get_stock'}
  }
  if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.grade_name == 'boss' then
    table.insert(elements, {label = _U('boss_actions'), value = 'boss_actions'})
  end

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'mecano_actions',
    {
      title    = _U('mechanic'),
      align    = 'top-right',
      elements = elements
    },
    function(data, menu)
      if data.current.value == 'vehicle_list' then

        if Config.EnableSocietyOwnedVehicles then

            local elements = {}

            ESX.TriggerServerCallback('8def0e18-67f6-4500-a5e2-6e16aee4eb00', function(vehicles)

              for i=1, #vehicles, 1 do
                table.insert(elements, {label = GetDisplayNameFromVehicleModel(vehicles[i].model) .. ' [' .. vehicles[i].plate .. ']', value = vehicles[i]})
              end

              ESX.UI.Menu.Open(
                'default', GetCurrentResourceName(), 'vehicle_spawner',
                {
                  title    = _U('service_vehicle'),
                  align    = 'top-right',
                  elements = elements,
                },
                function(data, menu)

                  menu.close()

                  local vehicleProps = data.current.value

                  ESX.Game.SpawnVehicle(vehicleProps.model, Config.Zones[CurrentActionData.station].VehicleSpawnPoint.Pos, 195.39, function(vehicle)
                    ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
                    local playerPed = ESX.Game.GetMyPed()
                    TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
                  end)

                  TriggerServerEvent('293760c8-b5e2-4800-bc04-944c4b572970', 'mecano', vehicleProps)

                end,
                function(data, menu)
                  menu.close()
                end
              )

            end, 'mecano')

          else
			local elements = {}
			
			if PlayerData.job.grade_name == 'contract' then
			
				elements = {
						{label = 'RACV Subcontractor',  value = 'flatbed'},
					}
			else
				elements = {
							{label = 'Roadside ute',  value = 'tranger'},
                                                        {label = 'Roadside silverado',  value = '17silv'},
							{label = 'Pilot ute',  value = 'firesadler'},
							{label = '4 door flatbed',  value = 'cxttow'},
							{label = '2 door flatbed',  value = 'tow'},
                                                        {label = '2 door flatbed 2',  value = 'flatbed9'},
							{label = 'Not so big Wrecker',  value = 'isgtow'},
							{label = 'Little bit bigger Wrecker',  value = 'hvywrecker'},
							{label = 'Biggest Wrecker',  value = 'hdwrecker'},
							{label = 'Rotator Wrecker',  value = 'foxwrecker'},
							{label = 'Hauler Truck',  value = 'phantomhd'},
							{label = 'Hauler Trailer',  value = 'lowboy'},
				}
			end
			
			

            if Config.EnablePlayerManagement and PlayerData.job ~= nil and
              (PlayerData.job.grade_name == 'boss' or PlayerData.job.grade_name == 'chef') then
              table.insert(elements, {label = 'xclass', value = 'class'})
            end

            ESX.UI.Menu.CloseAll()

            ESX.UI.Menu.Open(
              'default', GetCurrentResourceName(), 'spawn_vehicle',
              {
                title    = _U('service_vehicle'),
                align    = 'top-right',
                elements = elements
              },
              function(data, menu)
                for i=1, #elements, 1 do
                  if Config.MaxInService == -1 then
                    ESX.Game.SpawnVehicle(data.current.value, Config.Zones[CurrentActionData.station].VehicleSpawnPoint.Pos, 197.35, function(vehicle)
                      local playerPed = ESX.Game.GetMyPed()
                      TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
					  SetVehicleNumberPlateText(vehicle, 'TOW ' .. GetRandomNumber(4))
					  SetVehicleWindowTint( vehicle, 0)
					  Wait(200)
					
					    SetVehicleWindowTint( vehicle, 0)
						Citizen.Trace(GetVehicleWindowTint(vehicle))
						while GetVehiclePedIsIn(ESX.Game.GetMyPed()) == nil do
							Wait(0)
						end
						

                    end)
                    break
                  else
                    ESX.TriggerServerCallback('5ec18406-b92f-414f-8d90-64a53778ed0d', function(canTakeService, maxInService, inServiceCount)
                      if canTakeService then
                        ESX.Game.SpawnVehicle(data.current.value, Config.Zones[CurrentActionData.station].VehicleSpawnPoint.Pos, 195.39, function(vehicle)
                          local playerPed = ESX.Game.GetMyPed()
                          TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
						  
			
						 
                        end)
                      else
                        ESX.ShowNotification(_U('service_full') .. inServiceCount .. '/' .. maxInService)
                      end
                    end, 'mecano')
                    break
                  end
                end
                menu.close()
              end,
              function(data, menu)
                menu.close()
                OpenMecanoActionsMenu()
              end
            )

          end
      end

      if data.current.value == 'cloakroom' then
        menu.close()
        ESX.TriggerServerCallback('4568d939-3661-4833-ae6a-378432ac6ff1', function(skin, jobSkin)

            if skin.sex == 0 then
                TriggerEvent('1d09cf94-2c53-4220-a089-0339ce8bb123', skin, jobSkin.skin_male)
            else
                TriggerEvent('1d09cf94-2c53-4220-a089-0339ce8bb123', skin, jobSkin.skin_female)
            end

        end)
      end

      if data.current.value == 'cloakroom2' then
        menu.close()
        ESX.TriggerServerCallback('4568d939-3661-4833-ae6a-378432ac6ff1', function(skin, jobSkin)

            TriggerEvent('56a2ee13-8a49-4ad3-a298-1854493c98ee', skin)

        end)
      end

      if data.current.value == 'put_stock' then
        OpenPutStocksMenu()
      end

      if data.current.value == 'get_stock' then
        OpenGetStocksMenu()
      end

      if data.current.value == 'boss_actions' then
        TriggerEvent('9878e951-0ff0-4996-be7e-f0eb7c427247', 'mecano', function(data, menu)
          menu.close()
        end)
      end

    end,
    function(data, menu)
      menu.close()
      CurrentAction     = 'mecano_actions_menu'
      CurrentActionMsg  = _U('open_actions')
      CurrentActionData = {}
    end
  )
end



function OpenMecanoHarvestMenu()

  if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.grade_name ~= 'recrue' and PlayerData.job.grade > 1 then
    local elements = {
      {label = _U('gas_can'), value = 'gaz_bottle'},
      {label = _U('repair_tools'), value = 'fix_tool'},
      {label = _U('body_work_tools'), value = 'caro_tool'}
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'mecano_harvest',
      {
        title    = _U('harvest'),
        align    = 'top-right',
        elements = elements
      },
      function(data, menu)
        if data.current.value == 'gaz_bottle' then
          menu.close()
          TriggerServerEvent('4b7941a1-12a6-4836-be3a-a03e6780698f')
        end

        if data.current.value == 'fix_tool' then
          menu.close()
          TriggerServerEvent('c4d7b5ca-1292-4c76-9864-0c614e112a5c')
        end

        if data.current.value == 'caro_tool' then
          menu.close()
          TriggerServerEvent('eb0f15a0-d173-4194-93c3-3d441658923a')
        end

      end,
      function(data, menu)
        menu.close()
        CurrentAction     = 'mecano_harvest_menu'
        CurrentActionMsg  = _U('harvest_menu')
        CurrentActionData = {}
      end
    )
  else
    ESX.ShowNotification(_U('not_experienced_enough'))
  end
end

local NumberCharset = {}


for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

function GetRandomNumber(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end

function OpenMecanoCraftMenu()
  if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.grade_name ~= 'recrue' then

    local elements = {
      {label = _U('blowtorch'),  value = 'blow_pipe'},
      {label = _U('repair_kit'), value = 'fix_kit'},
      {label = _U('body_kit'),   value = 'caro_kit'}
    }

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'mecano_craft',
      {
        title    = _U('craft'),
        align    = 'top-right',
        elements = elements
      },
      function(data, menu)
        if data.current.value == 'blow_pipe' then
          menu.close()
          TriggerServerEvent('ac11511c-9935-4b44-aa68-f67ff425bde0')
        end

        if data.current.value == 'fix_kit' then
          menu.close()
          TriggerServerEvent('01ef99df-ec6f-46a7-b973-65f0275917e0')
        end

        if data.current.value == 'caro_kit' then
          menu.close()
          TriggerServerEvent('74a99834-6c13-4e5d-8bab-c5178d1d9140')
        end

      end,
      function(data, menu)
        menu.close()
        CurrentAction     = 'mecano_craft_menu'
        CurrentActionMsg  = _U('craft_menu')
        CurrentActionData = {}
      end
    )
  else
    ESX.ShowNotification(_U('not_experienced_enough'))
  end
end

function OpenMobileMecanoActionsMenu()

  ESX.UI.Menu.CloseAll()
  
  local elements = {}
  
  if PlayerData.job.grade_name == 'contract' then
	   elements = {
        {label = _U('billing'),       value = 'billing_contractor'},
       -- {label = _U('repair'),        value = 'fix_vehicle'},
        {label = _U('clean'),         value = 'clean_vehicle'},
        {label = _U('flat_bed'),      value = 'dep_vehicle'},
		{label = 'Go on Duty',     value = 'onduty'},
		{label = 'Go off Duty',     value = 'offduty'},
		}
  else
  
	 elements = {
        {label = _U('billing'),       value = 'billing'},
        {label = _U('hijack'),        value = 'hijack_vehicle'},
        {label = _U('repair'),        value = 'fix_vehicle'},
        {label = _U('clean'),         value = 'clean_vehicle'},
        {label = _U('imp_veh'),       value = 'del_vehicle'},
		 {label = 'Fill Oil',       value = 'refil_oil'},
        {label = _U('flat_bed'),      value = 'dep_vehicle'},
        {label = _U('place_objects'), value = 'object_spawner'},
		{label = 'Start/Stop NPC Job', value = 'npc_job'},
		{label = 'Go on Duty',     value = 'onduty'},
		{label = 'Go off Duty',     value = 'offduty'},
      }
  
  end

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'mobile_mecano_actions',
    {
      title    = _U('mechanic'),
      align    = 'top-right',
      elements = elements
    },
	function(data, menu)
      if IsBusy then return end

      if data.current.value == 'billing' then

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'billing',
          {
		  
            title = _U('invoice_amount')
          },
          function(data, menu)
            local amount = tonumber(data.value)
            if amount == nil or amount < 0 then
              ESX.ShowNotification(_U('amount_invalid'))
            else
              
              local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
              if closestPlayer == -1 or closestDistance > 3.0 then
                ESX.ShowNotification(_U('no_players_nearby'))
			  else
				menu.close()
                TriggerServerEvent('c9ac0436-8b83-467d-abe5-4978cdf78f9b', GetPlayerServerId(closestPlayer), 'society_mecano', _U('mechanic'), amount)
              end
            end
          end,
        function(data, menu)
          menu.close()
        end
        )
      end
	  
	  if data.current.value == 'billing_contractor' then
		TriggerEvent('ae7a51c5-190c-4f66-9d3f-28ad9815553d', 'Important Notice #1', "RACV" , "1. Do not overcharge, the penalties for you are more severe.\n2. Ensure you receive payment via invoice before proceeding with work",'CHAR_FLOYD', 'tbt', 1)
		Wait(2500)
		TriggerEvent('ae7a51c5-190c-4f66-9d3f-28ad9815553d', 'Important Notice #2', "RACV" , "3. You must have repair kits on you to provide the Repair Kit services. Source them from where you like.",'CHAR_FLOYD', 'tbt', 1)
		ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'mobile_mecano_billing_contractor',
          {
            title    = _U('objects'),
            align    = 'top-right',
            elements = {
              {label = 'Invoice for Service: Tow to Location', value = '2000'},
			  {label = 'Invoice for Service: Repair Kit Only', value = '2000'},
              {label = 'Invoice for Service: Repair Kit & Fitting', value = '2500'},

            },
          },
          function(data2, menu2)
		  
		      local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
              if closestPlayer == -1 or closestDistance > 3.0 then
                ESX.ShowNotification(_U('no_players_nearby'))
			  else
				menu2.close()
				menu.close()
                TriggerServerEvent('c9ac0436-8b83-467d-abe5-4978cdf78f9b', GetPlayerServerId(closestPlayer), 'society_mecano', data2.current.label,  tonumber(data2.current.value))
              end
				 
          end,
          function(data2, menu2)
            menu2.close()
          end)
      end
	  
	 if data.current.value == 'npc_job' then
	     if NPCOnJob then

            if GetGameTimer() - NPCLastCancel > 5 * 60000 then
              StopNPCJob(true)
              NPCLastCancel = GetGameTimer()
            else
              ESX.ShowNotification(_U('wait_five'))
            end

          else

            local playerPed = ESX.Game.GetMyPed()

            if IsPedInAnyVehicle(playerPed, false) and IsVehicleModel(GetVehiclePedIsIn(playerPed, false), GetHashKey("cxttow")) or IsVehicleModel(GetVehiclePedIsIn(playerPed, false), GetHashKey("flatbed9")) or IsVehicleModel(GetVehiclePedIsIn(playerPed, false), GetHashKey("flatbed")) or IsVehicleModel(GetVehiclePedIsIn(playerPed, false), GetHashKey("tow")) then
              StartNPCJob()
            else
              ESX.ShowNotification(_U('must_in_flatbed'))
            end

          end
						
	end
	  
	 if data.current.value == 'onduty' then
		TriggerServerEvent('es:setJobDuty',tostring(GetPlayerServerId(PlayerId())), true)
		isduty = true
		TriggerServerEvent('7fcbafb2-e15d-4e94-9a71-c348def151ae',"esx_mecanojob", "ON DUTY")
						
	end
						
		if data.current.value == 'offduty' then
			TriggerServerEvent('es:setJobDuty',tostring(GetPlayerServerId(PlayerId())), false)
			isduty = false
			TriggerServerEvent('7fcbafb2-e15d-4e94-9a71-c348def151ae',"esx_mecanojob", "ON OFFDUTY")
		end
      if data.current.value == 'hijack_vehicle' then

		local playerPed = ESX.Game.GetMyPed()
		local vehicle   = ESX.Game.GetVehicleInDirection()
		local coords    = ESX.Game.GetMyPedLocation()
		
		if DoesEntityExist(vehicle) == false then
			local vc, dtance = ESX.Game.GetClosestVehicle()
			if dtance < 5.0 then
				vehicle = vc
			end
		end


		if IsPedSittingInAnyVehicle(playerPed) then
			ESX.ShowNotification(_U('inside_vehicle'))
			return
		end

		if DoesEntityExist(vehicle) then
			IsBusy = true
			TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
			Citizen.CreateThread(function()
				Citizen.Wait(10000)

				SetVehicleDoorsLocked(vehicle, 1)
				SetVehicleDoorsLockedForAllPlayers(vehicle, false)
				ClearPedTasksImmediately(playerPed)
				TriggerServerEvent('7fcbafb2-e15d-4e94-9a71-c348def151ae',"esx_mecanojob", "UNLOCK VEHICLE: "  .. GetVehicleNumberPlateText(vehicle))
				ESX.ShowNotification(_U('vehicle_unlocked'))
				IsBusy = false
			end)
		else
			ESX.ShowNotification(_U('no_vehicle_nearby'))
		end
	elseif data.current.value == 'refil_oil' and PlayerData.job.grade_name ~= 'contract' then
		if isduty == false then
			ESX.ShowNotification('~b~True~w~ Blue ~b~Towing~n~~r~You must be on duty to use this feature. ~o~Duty functions are recorded')
			return
		end

		
		
		local playerPed = ESX.Game.GetMyPed()
		local vehicle   = ESX.Game.GetVehicleInDirection()
		local coords    = ESX.Game.GetMyPedLocation()
		
		local permission = false
		local mycoords = ESX.Game.GetMyPedLocation()
		 for l,w in pairs(Config.Zones) do

			if Config.Zones[l]["MecanoActions"] ~= nil and Config.Zones[l]["MecanoActions"].Pos ~= nil then
				local pos = Config.Zones[l]["MecanoActions"].Pos
				if #(mycoords - vector3(pos.x,pos.y,pos.z)) < 120 then
					permission = true
				end
			end
		 end
		 
		 if permission == false then
		 	ESX.ShowNotification('~r~You can only perform this action at the Depot')
			return
		 end
		 
		if DoesEntityExist(vehicle) == false then
			local vc, dtance = ESX.Game.GetClosestVehicle()
			if dtance < 5.0 then
				vehicle = vc
			end
		end
	
		ESX.TriggerServerCallback('56329a0a-1406-483e-9ff8-02045a2e8eee', function(owned)
			if owned == true then
				TriggerServerEvent('7fcbafb2-e15d-4e94-9a71-c348def151ae',"esx_mecanojob", "FAILED OIL OWNED VEHICLE: "  .. GetVehicleNumberPlateText(ESX.Game.GetVehicleInDirection()))
				ESX.ShowNotification("~b~True~w~ Blue ~b~Towing~n~~r~Company policy prohibits filling your own oil")
				menu.close()
				return
			else
					 playerPed = ESX.Game.GetMyPed()
					 ped = playerPed
					 vehicle   = ESX.Game.GetVehicleInDirection()
					 coords    = ESX.Game.GetMyPedLocation()
					
					if DoesEntityExist(vehicle) == false then
						local vc, dtance = ESX.Game.GetClosestVehicle()
						if dtance < 5.0 then
							vehicle = vc
						end
					end
					
					if IsPedSittingInAnyVehicle(playerPed) then
						ESX.ShowNotification(_U('inside_vehicle'))
						return
					end

					if DoesEntityExist(vehicle) then
		
					
						NetworkRequestControlOfEntity(vehicle)
						NetworkRequestControlOfEntity(vehicle)
						IsBusy = true
							local dict
							local model = 'prop_carjack'
							local offset = GetOffsetFromEntityInWorldCoords(ped, 0.0, -2.0, 0.0)
							local headin = GetEntityHeading(ped)
							local veh = vehicle
							FreezeEntityPosition(veh, true)
							local vehpos = GetEntityCoords(veh)
							dict = 'mp_car_bomb'
							RequestAnimDict(dict)
							RequestModel(model)
							while not HasAnimDictLoaded(dict) or not HasModelLoaded(model) do
								Citizen.Wait(1)
							end
							local vehjack = CreateObject(GetHashKey(model), vehpos.x, vehpos.y, vehpos.z - 0.5, true, true, true)
							exports['progressBars']:startUI(14000, "Jacking up the vehicle") -- TRANSLATE THIS, THAT SAY WHEN YOU PUT THE CRIC
							AttachEntityToEntity(vehjack, veh, 0, 0.0, 0.0, -1.0, 0.0, 0.0, 0.0, false, false, false, false, 0, true)
							TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1250, 1, 0.0, 1, 1)
							Citizen.Wait(1500)
							SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.01, true, true, true)
							TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
							Citizen.Wait(2000)
							SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.025, true, true, true)
							TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
							Citizen.Wait(1500)
							SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.05, true, true, true)
							TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
							Citizen.Wait(1500)
							SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.1, true, true, true)
							TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
							Citizen.Wait(2000)
							SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.15, true, true, true)
							TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
							Citizen.Wait(2000)
							SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.2, true, true, true)
							TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
							Citizen.Wait(2000)
							SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.3, true, true, true)
							TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
							dict = 'move_crawl'
							Citizen.Wait(1500)
							SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.4, true, true, true)
							TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
							SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.5, true, true, true)
							SetEntityCollision(veh, false, false)
							TaskPedSlideToCoord(ped, offset, headin, 1000)
							Citizen.Wait(1000)
							RequestAnimDict(dict)
							while not HasAnimDictLoaded(dict) do
								Citizen.Wait(100)
							end
							exports['progressBars']:startUI(23000, "Changing the vehicles oil") -- TRANSLATE THIS - THAT SAY WHEN YOU REPAIR THE VEHICLE
							TaskPlayAnimAdvanced(ped, dict, 'onback_bwd', coords, 0.0, 0.0, headin - 180, 1.0, 0.5, 3000, 1, 0.0, 1, 1)
							dict = 'amb@world_human_vehicle_mechanic@male@base'
							Citizen.Wait(3000)
							RequestAnimDict(dict)
							while not HasAnimDictLoaded(dict) do
								Citizen.Wait(1)
							end

							TaskPlayAnim(ped, dict, 'base', 8.0, -8.0, 18000, 1, 0, false, false, false)
							dict = 'move_crawl'
							Citizen.Wait(18000)
							local coords2 = GetEntityCoords(ped)
							RequestAnimDict(dict)
							while not HasAnimDictLoaded(dict) do
								Citizen.Wait(1)
							end
							TaskPlayAnimAdvanced(ped, dict, 'onback_fwd', coords2, 0.0, 0.0, headin - 180, 1.0, 0.5, 2000, 1, 0.0, 1, 1)
							Citizen.Wait(3000)
							dict = 'mp_car_bomb'
							RequestAnimDict(dict)
							while not HasAnimDictLoaded(dict) do
								Citizen.Wait(1)
							end
							SetVehicleFixed(vehicle)
							SetVehicleDeformationFixed(vehicle)
							SetVehicleUndriveable(vehicle, false)
							SetVehicleEngineOn(vehicle, true, true)
							ClearPedTasksImmediately(playerPed)
							exports['progressBars']:startUI(15000, "Lowering the Vehicle") -- TLANSTALE THIS - THAT SAY WHEN YOU LEAVE THE CRIC
							TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1250, 1, 0.0, 1, 1)
							Citizen.Wait(2000)
							SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.4, true, true, true)
							TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
							Citizen.Wait(2000)
							SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.3, true, true, true)
							TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
							Citizen.Wait(2000)
							SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.2, true, true, true)
							TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
							Citizen.Wait(2000)
							SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.15, true, true, true)
							TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
							Citizen.Wait(2000)
							SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.1, true, true, true)
							TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
							Citizen.Wait(2000)
							SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.05, true, true, true)
							TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
							Citizen.Wait(2000)
							SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.025, true, true, true)
							TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
							dict = 'move_crawl'
							Citizen.Wait(1000)
							SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z + 0.01, true, true, true)
							TaskPlayAnimAdvanced(ped, dict, 'car_bomb_mechanic', coords, 0.0, 0.0, headin, 1.0, 0.5, 1000, 1, 0.25, 1, 1)
							SetEntityCoordsNoOffset(veh, vehpos.x, vehpos.y, vehpos.z, true, true, true)
							FreezeEntityPosition(veh, false)
							DeleteObject(vehjack)
							SetEntityCollision(veh, true, true)
						TriggerServerEvent('7fcbafb2-e15d-4e94-9a71-c348def151ae',"esx_mecanojob", "OIL VEHICLE: "  .. GetVehicleNumberPlateText(vehicle))
						Citizen.CreateThread(function()

							SetVehicleOilLevel(vehicle,100.00)
							ESX.TriggerServerCallback('77956617-7ad0-408c-8c18-5b0db734c4de', function(hasmk)
								TriggerServerEvent('832b5f5d-a5a9-4e73-96e2-ed7fd49923e7',GetVehicleNumberPlateText(veh),hasmk.km,100.00)
							end, GetVehicleNumberPlateText(veh),VehToNet(veh))
									
							ESX.ShowNotification('Vehicle has been filled with oil')
							IsBusy = false
						end)
					else
						ESX.ShowNotification(_U('no_vehicle_nearby'))
					end
			end
		end, GetVehicleNumberPlateText(vehicle), GetVehicleNumberPlateText(vehicle))
		

	elseif data.current.value == 'fix_vehicle'  then
		if isduty == false then
			ESX.ShowNotification('~b~True~w~ Blue ~b~Towing~n~~r~You must be on duty to use this feature. ~o~Duty functions are recorded.')
			return
		end
		
		local playerPed = ESX.Game.GetMyPed()
		local vehicle   = ESX.Game.GetVehicleInDirection()
		local coords    = ESX.Game.GetMyPedLocation()
		
		if DoesEntityExist(vehicle) == false then
			local vc, dtance = ESX.Game.GetClosestVehicle()
			if dtance < 5.0 then
				vehicle = vc
			end
		end
		
		if PlayerData.job.grade_name ~= 'contract' then

			ESX.TriggerServerCallback('56329a0a-1406-483e-9ff8-02045a2e8eee', function(owned)
				if owned == true then
					TriggerServerEvent('7fcbafb2-e15d-4e94-9a71-c348def151ae',"esx_mecanojob", "FAILED REPAIR OWNED VEHICLE: "  .. GetVehicleNumberPlateText(ESX.Game.GetVehicleInDirection()))
					ESX.ShowNotification("~b~True~w~ Blue ~b~Towing~n~~r~Company policy prohibits repairing a vehicle you own.")
					menu.close()
					return
				else
						 playerPed = ESX.Game.GetMyPed()
						 vehicle   = ESX.Game.GetVehicleInDirection()
						 coords    = ESX.Game.GetMyPedLocation()
						
						if DoesEntityExist(vehicle) == false then
							local vc, dtance = ESX.Game.GetClosestVehicle()
							if dtance < 5.0 then
								vehicle = vc
							end
						end
						
					

						if IsPedSittingInAnyVehicle(playerPed) then
							ESX.ShowNotification(_U('inside_vehicle'))
							return
						end

						if DoesEntityExist(vehicle) then
							NetworkRequestControlOfEntity(vehicle)
							NetworkRequestControlOfEntity(vehicle)
							IsBusy = true
							TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
							TriggerServerEvent('7fcbafb2-e15d-4e94-9a71-c348def151ae',"esx_mecanojob", "REPAIR VEHICLE: "  .. GetVehicleNumberPlateText(vehicle))
							Citizen.CreateThread(function()
								Citizen.Wait(20000)

								SetVehicleFixed(vehicle)
								SetVehicleDeformationFixed(vehicle)
								SetVehicleUndriveable(vehicle, false)
								SetVehicleEngineOn(vehicle, true, true)
								ClearPedTasksImmediately(playerPed)
								ESX.TriggerServerCallback('77956617-7ad0-408c-8c18-5b0db734c4de', function(hasmk)
									SetVehicleOilLevel(vehicle,hasmk.oil)
								end, GetVehicleNumberPlateText(vehicle),VehToNet(vehicle))

								ESX.ShowNotification(_U('vehicle_repaired'))
								IsBusy = false
							end)
						else
							ESX.ShowNotification(_U('no_vehicle_nearby'))
						end
				end
			end, GetVehicleNumberPlateText(vehicle), GetVehicleNumberPlateText(vehicle))
		else
			ESX.ShowNotification("~b~True~w~ Blue ~b~Towing~n~~o~You cannot use repair tools away from base.")
		end



	elseif data.current.value == 'clean_vehicle' then

		local playerPed = ESX.Game.GetMyPed()
		local vehicle   = ESX.Game.GetVehicleInDirection()
		local coords    = ESX.Game.GetMyPedLocation()
		 
		
		if DoesEntityExist(vehicle) == false then
			local vc, dtance = ESX.Game.GetClosestVehicle()
			if dtance < 5.0 then
				vehicle = vc
			end
		end

		if IsPedSittingInAnyVehicle(playerPed) then
			ESX.ShowNotification(_U('inside_vehicle'))
			return
		end

		if DoesEntityExist(vehicle) then
			IsBusy = true
			TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_MAID_CLEAN", 0, true)
			Citizen.CreateThread(function()
				Citizen.Wait(10000)

				SetVehicleDirtLevel(vehicle, 0)
				ClearPedTasksImmediately(playerPed)

				ESX.ShowNotification(_U('vehicle_cleaned'))
				IsBusy = false
			end)
		else
			ESX.ShowNotification(_U('no_vehicle_nearby'))
		end

      elseif data.current.value == 'del_vehicle' then

        local ped = ESX.Game.GetMyPed()

        if DoesEntityExist(ped) and not IsEntityDead(ped) then
          local pos = ESX.Game.GetMyPedLocation()

          if IsPedSittingInAnyVehicle(ped) then
            local vehicle = GetVehiclePedIsIn( ped, false )

            if GetPedInVehicleSeat(vehicle, -1) == ped then
              ESX.ShowNotification(_U('vehicle_impounded'))
              ESX.Game.DeleteVehicle(vehicle)
            else
              ESX.ShowNotification(_U('must_seat_driver'))
            end
          else
            local vehicle = ESX.Game.GetVehicleInDirection()
			
			if DoesEntityExist(vehicle) == false then
				local vc, dtance = ESX.Game.GetClosestVehicle()
				if dtance < 3.5 then
					vehicle = vc
				end
			end

            if DoesEntityExist(vehicle) then
              ESX.ShowNotification(_U('vehicle_impounded'))
              ESX.Game.DeleteVehicle(vehicle)
            else
              ESX.ShowNotification(_U('must_near'))
            end
          end
        end
      end

      if data.current.value == 'dep_vehicle' then

        local playerped = ESX.Game.GetMyPed()
        local vehicle = GetVehiclePedIsIn(playerped, true)
		
        local towmodel = `cxttow`
		local towmodel2 = `dsflatbed`
		local towmodel3 = `flatbed`
		local towmodel4 = `flatbed9`
		local towmodel5 = `tow`
        local isVehicleTow = false
		
		if IsVehicleModel(vehicle, towmodel) or IsVehicleModel(vehicle, towmodel2) or IsVehicleModel(vehicle, towmodel3) or IsVehicleModel(vehicle, towmodel4) or IsVehicleModel(vehicle, towmodel5) then
			isVehicleTow = true
		end
		

        if isVehicleTow then
          local targetVehicle = ESX.Game.GetVehicleInDirection()
		  
			if DoesEntityExist(targetVehicle) == false then
				local vc, dtance = ESX.Game.GetClosestVehicle()
				if dtance < 8.0 then
					targetVehicle = vc
				end
			end

          if CurrentlyTowedVehicle == nil then
            if targetVehicle ~= 0 then
              if not IsPedInAnyVehicle(playerped, true) then
                if vehicle ~= targetVehicle then
				
					SetNetworkIdCanMigrate(vehicle, true)
					NetworkRequestControlOfEntity(vehicle)
					while not NetworkHasControlOfEntity(vehicle) do
						NetworkRequestControlOfEntity(vehicle)
						Citizen.Wait(0)
					end
					
				
					SetNetworkIdCanMigrate(targetVehicle, true)
					NetworkRequestControlOfEntity(targetVehicle)
					while not NetworkHasControlOfEntity(targetVehicle) do
						NetworkRequestControlOfEntity(targetVehicle)
						Citizen.Wait(0)
					end
					
				
                  AttachEntityToEntity(targetVehicle, vehicle, 9.0, 2, -4.0, 1.0, 0, 0.0, 0.0, false, false, false, false, 20, true)
                  CurrentlyTowedVehicle = targetVehicle
                  ESX.ShowNotification(_U('vehicle_success_attached'))

                  if NPCOnJob then

                    if NPCTargetTowable == targetVehicle then
                      ESX.ShowNotification(_U('please_drop_off'))

                      Config.zones[CurrentActionData.station].VehicleDelivery.Type = 1

                      if Blips['NPCTargetTowableZone'] ~= nil then
                        RemoveBlip(Blips['NPCTargetTowableZone'])
                        Blips['NPCTargetTowableZone'] = nil
                      end

                      Blips['NPCDelivery'] = AddBlipForCoord(Config.Zones[CurrentActionData.station].VehicleDelivery.Pos.x,  Config.Zones[CurrentActionData.station][CurrentActionData.zone].VehicleDelivery.Pos.y,  Config.Zones[CurrentActionData.station].VehicleDelivery.Pos.z)

                      SetBlipRoute(Blips['NPCDelivery'], true)

                    end

                  end

                else
                  ESX.ShowNotification(_U('cant_attach_own_tt'))
                end
              end
            else
              ESX.ShowNotification(_U('no_veh_att'))
            end
          else

            AttachEntityToEntity(CurrentlyTowedVehicle, vehicle, 20, -0.5, -12.0, 1.0, 0.0, 0.0, 0.0, false, false, false, false, 20, true)
            DetachEntity(CurrentlyTowedVehicle, true, true)

            if NPCOnJob then

              if NPCTargetDeleterZone then

                if CurrentlyTowedVehicle == NPCTargetTowable then
                  ESX.Game.DeleteVehicle(NPCTargetTowable)
                  TriggerServerEvent('6e087cd5-456c-4c4e-8db7-111499f9c3be')
                  StopNPCJob()
                  NPCTargetDeleterZone = false

                else
                  ESX.ShowNotification(_U('not_right_veh'))
                end

              else
                ESX.ShowNotification(_U('not_right_place'))
              end

            end

            CurrentlyTowedVehicle = nil

            ESX.ShowNotification(_U('veh_det_succ'))
          end
        else
          ESX.ShowNotification(_U('imp_flatbed'))
        end
      end

      if data.current.value == 'object_spawner' and PlayerData.job.grade_name ~= 'contract' then
		local playerPed = ESX.Game.GetMyPed()

		if IsPedSittingInAnyVehicle(playerPed) then
			ESX.ShowNotification(_U('inside_vehicle'))
			return
		end

        ESX.UI.Menu.Open(
          'default', GetCurrentResourceName(), 'mobile_mecano_actions_spawn',
          {
            title    = _U('objects'),
            align    = 'top-right',
            elements = {
              {label = _U('roadcone'),     value = 'prop_roadcone02a'},
              {label = _U('toolbox'), value = 'prop_toolchest_01'},
			  {label = 'Solid Object: ' .. solid_text,     value = '6'}
            },
          },
          function(data2, menu2)
						if data2.current.value == '6' then
							if solid_toggle == true then
								solid_toggle = false
								solid_text = "FALSE"
							else
								solid_text = "TRUE"
								solid_toggle = true
							end
							menu2.close()
							
						else
							local model     = data2.current.value
							local coords    = GetEntityCoords(playerPed)
							local forward   = GetEntityForwardVector(playerPed)
							local x, y, z   = table.unpack(coords + forward * 1.0)

							if model == 'prop_roadcone02a' then
							  z = z - 2.0
							elseif model == 'prop_toolchest_01' then
							  z = z - 2.0
							end

							ESX.Game.SpawnObject(model, {
							  x = x,
							  y = y,
							  z = z
							}, function(obj)
							  SetEntityHeading(obj, GetEntityHeading(playerPed))
							  PlaceObjectOnGroundProperly(obj)
								SetEntityDynamic(obj, solid_toggle)
								SetEntityInvincible(obj, solid_toggle)
								FreezeEntityPosition(obj, solid_toggle)
							end)
			end
          end,
          function(data2, menu2)
            menu2.close()
          end)

      end

    end,
  function(data, menu)
    menu.close()
  end
  )
end

function OpenGetStocksMenu()
  ESX.TriggerServerCallback('a98c8aa5-20f6-477c-a2c9-1508a67bc5f1', function(items)
    local elements = {}

    for i=1, #items, 1 do
      table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'stocks_menu',
      {
        title    = _U('mechanic_stock'),
        align    = 'top-right',
        elements = elements
      },
      function(data, menu)

        local itemName = data.current.value

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count',
          {
            title = _U('quantity')
          },
          function(data2, menu2)

            local count = tonumber(data2.value)

            if count == nil then
              ESX.ShowNotification(_U('invalid_quantity'))
            else
              menu2.close()
              menu.close()
              TriggerServerEvent('4b6a65e7-cf05-475b-8b0d-b0eb90b2e1b6', itemName, count)

              Citizen.Wait(1000)
              OpenGetStocksMenu()
            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

function OpenPutStocksMenu()

ESX.TriggerServerCallback('b586e34f-2ab0-4d1f-a5c0-66299dabb71b', function(inventory)

    local elements = {}

    for i=1, #inventory.items, 1 do

      local item = inventory.items[i]

      if item.count > 0 then
        table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
      end

    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'stocks_menu',
      {
        title    = _U('inventory'),
        align    = 'top-right',
        elements = elements
      },
      function(data, menu)

        local itemName = data.current.value

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count',
          {
            title = _U('quantity')
          },
          function(data2, menu2)

            local count = tonumber(data2.value)

            if count == nil then
              ESX.ShowNotification(_U('invalid_quantity'))
            else
              menu2.close()
              menu.close()
              TriggerServerEvent('7ff0d625-b039-4fcd-872e-4b89fd4c55d5', itemName, count)

              Citizen.Wait(1000)
              OpenPutStocksMenu()
            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end


RegisterNetEvent('5bf2c8ad-e1eb-4b20-b4bd-39c689e244dd')
AddEventHandler('5bf2c8ad-e1eb-4b20-b4bd-39c689e244dd', function()
  local playerPed = ESX.Game.GetMyPed()
  local coords    = ESX.Game.GetMyPedLocation()

  if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

    local vehicle = nil

    if IsPedInAnyVehicle(playerPed, false) then
      vehicle = GetVehiclePedIsIn(playerPed, false)
    else
      vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
    end

    local crochete = math.random(100)
    local alarm    = math.random(100)

    if DoesEntityExist(vehicle) then
      if alarm <= 33 then
        SetVehicleAlarm(vehicle, true)
        StartVehicleAlarm(vehicle)
      end
      TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
      Citizen.CreateThread(function()
        Citizen.Wait(10000)
        if crochete <= 66 then
		  TriggerServerEvent('305947f9-8be0-4f8d-b513-a2390d042a7a','TRUB DOOR UNLOCK','DOOR WAS UNLOCKED FOR VEHICLE USING BLOWTORCH PLATE: ' .. GetVehicleNumberPlateText(vehicle))
          SetVehicleDoorsLocked(vehicle, 1)
          SetVehicleDoorsLockedForAllPlayers(vehicle, false)
          ClearPedTasksImmediately(playerPed)
          ESX.ShowNotification(_U('veh_unlocked'))
        else
          ESX.ShowNotification(_U('hijack_failed'))
          ClearPedTasksImmediately(playerPed)
        end
      end)
    end

  end
end)

RegisterNetEvent('a8cd1134-431d-4c83-8d83-f7b5f0a6e00d')
AddEventHandler('a8cd1134-431d-4c83-8d83-f7b5f0a6e00d', function()
  local playerPed = ESX.Game.GetMyPed()
  local coords    = ESX.Game.GetMyPedLocation()

  if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

    local vehicle = nil

    if IsPedInAnyVehicle(playerPed, false) then
      vehicle = GetVehiclePedIsIn(playerPed, false)
    else
      vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
    end

    if DoesEntityExist(vehicle) then
      TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_HAMMERING", 0, true)
      Citizen.CreateThread(function()
        Citizen.Wait(30000)
        SetVehicleFixed(vehicle)
        SetVehicleDeformationFixed(vehicle)
        ClearPedTasksImmediately(playerPed)
        ESX.ShowNotification(_U('body_repaired'))
      end)
    end
  end
end)

RegisterNetEvent('783a4db0-ca59-4522-bf9f-03dc508763a3')
AddEventHandler('783a4db0-ca59-4522-bf9f-03dc508763a3', function()
  local playerPed = ESX.Game.GetMyPed()
  local coords    = ESX.Game.GetMyPedLocation()

  if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 5.0) then

    local vehicle = nil

    if IsPedInAnyVehicle(playerPed, false) then
      vehicle = GetVehiclePedIsIn(playerPed, false)
    else
      vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 5.0, 0, 71)
    end

    if DoesEntityExist(vehicle) then
      TaskStartScenarioInPlace(playerPed, "PROP_HUMAN_BUM_BIN", 0, true)
      Citizen.CreateThread(function()
        Citizen.Wait(20000)
		SetNetworkIdCanMigrate(vehicle, true)
		NetworkRequestControlOfEntity(vehicle)
		while not NetworkHasControlOfEntity(vehicle) do
			NetworkRequestControlOfEntity(vehicle)
			Citizen.Wait(0)
		end
		Wait(500)
		SetVehicleUndriveable(vehicle,false)
		SetVehicleBodyHealth(vehicle,1000)
		SetVehicleEngineHealth(vehicle,1000)
		SetVehicleDeformationFixed(vehicle)
		SetVehicleFixed(vehicle)
        SetVehicleDeformationFixed(vehicle)
        SetVehicleUndriveable(vehicle, false)
		ESX.TriggerServerCallback('77956617-7ad0-408c-8c18-5b0db734c4de', function(hasmk)
			SetVehicleOilLevel(vehicle,hasmk.oil)
		end, GetVehicleNumberPlateText(vehicle),VehToNet(vehicle))
		
        ClearPedTasksImmediately(playerPed)
        ESX.ShowNotification(_U('veh_repaired'))
      end)
    end
  end
end)

RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function(job)
	
	PlayerData.job = job
	print(PlayerData.job.name)
end)

AddEventHandler('57050b8d-50a6-44ca-8285-cb0220228d94', function(zone, station)

  if zone == NPCJobTargetTowable then

  end

  if zone =='VehicleDelivery' then
    NPCTargetDeleterZone = true
  end

  if zone == 'MecanoActions' then
    CurrentAction     = 'mecano_actions_menu'
    CurrentActionMsg  = _U('open_actions')
    CurrentActionData = {zone = zone, station = station}
  end

  if zone == 'Garage' then
    CurrentAction     = 'mecano_harvest_menu'
    CurrentActionMsg  = _U('harvest_menu')
    CurrentActionData = {zone = zone, station = station}
  end

  if zone == 'Craft' then
    CurrentAction     = 'mecano_craft_menu'
    CurrentActionMsg  = _U('craft_menu')
    CurrentActionData = {zone = zone, station = station}
  end

  if zone == 'VehicleDeleter' then

    local playerPed = ESX.Game.GetMyPed()

    if IsPedInAnyVehicle(playerPed,  false) then

      local vehicle = GetVehiclePedIsIn(playerPed,  false)

      CurrentAction     = 'delete_vehicle'
      CurrentActionMsg  = _U('veh_stored')
      CurrentActionData = {vehicle = vehicle,zone = zone, station = station}
    end
  end

end)

AddEventHandler('78619f56-eeba-4c2c-934e-77f5d1279e90', function(zone, station)

  if zone =='VehicleDelivery' then
    NPCTargetDeleterZone = false
  end

  if zone == 'Craft' then
    TriggerServerEvent('9dca1649-3de1-42aa-b1b1-f68103502bee')
    TriggerServerEvent('1fec8e39-96d1-4ac3-a82e-51e1823ac5d9')
    TriggerServerEvent('c517a254-a4f8-4247-8f32-fff978246d68')
  end

  if zone == 'Garage' then
    TriggerServerEvent('4d25ab77-b338-4547-8d37-71ecfa5fdab1')
    TriggerServerEvent('f764a723-86c3-4db9-8513-b9ca3edc93eb')
    TriggerServerEvent('3fe0eb56-1d53-486e-8d6b-0c3a3596ab84')
  end

  CurrentAction = nil
  ESX.UI.Menu.CloseAll()
end)

AddEventHandler('8f57d912-19b0-4dfc-adcc-bc0429d05a19', function(entity)

  local playerPed = ESX.Game.GetMyPed()

  if PlayerData.job ~= nil and PlayerData.job.name == 'mecano' and not IsPedInAnyVehicle(playerPed, false) then
    CurrentAction     = 'remove_entity'
    CurrentActionMsg  = _U('press_remove_obj')
    CurrentActionData = {entity = entity}
  end

end)

AddEventHandler('7ff810d8-17a6-4d14-925e-258717fc7cac', function(entity)

  if CurrentAction == 'remove_entity' then
    CurrentAction = nil
  end

end)

RegisterNetEvent('59809f17-d8ce-49dd-ae30-d5e90a7761a7')
AddEventHandler('59809f17-d8ce-49dd-ae30-d5e90a7761a7', function(phoneNumber, contacts)
  local specialContact = {
    name       = 'True Blue Towing',
    number     = 'mecano',
    base64Icon = 'data:image/png;base64,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'
  }
  TriggerEvent('e25977c9-9f2b-4d5d-a807-a8c7a0c964d5', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

-- Pop NPC mission vehicle when inside area
Citizen.CreateThread(function()
  while true do

    Wait(10)
	pcall(function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'mecano' then
		if NPCTargetTowableZone ~= nil and not NPCHasSpawnedTowable then

		  local coords = ESX.Game.GetMyPedLocation()
		  local zone   = Config.Zones[NPCTargetTowableZone]

		  if GetDistanceBetweenCoords(coords, zone.Pos.x, zone.Pos.y, zone.Pos.z, true) < Config.NPCSpawnDistance then

			local model = Config.Vehicles[GetRandomIntInRange(1,  #Config.Vehicles)]

			ESX.Game.SpawnVehicle(model, zone.Pos, 0, function(vehicle)
			  NPCTargetTowable = vehicle
			end)

			NPCHasSpawnedTowable = true

		  end

		end

		if NPCTargetTowableZone ~= nil and NPCHasSpawnedTowable and not NPCHasBeenNextToTowable then

		  local coords = GetEntityCoords(ESX.Game.GetMyPed())
		  local zone   = Config.Zones[NPCTargetTowableZone]

		  if(GetDistanceBetweenCoords(coords, zone.Pos.x, zone.Pos.y, zone.Pos.z, true) < Config.NPCNextToDistance) then
			ESX.ShowNotification(_U('please_tow'))
			NPCHasBeenNextToTowable = true
		  end

		end
	else
		Wait(5000)
	end
	end)
  end
end)

-- Create Blips
Citizen.CreateThread(function()

--needs loop
	for l,w in pairs(Config.Zones) do

	  local blip = AddBlipForCoord(Config.Zones[l].MecanoActions.Pos.x, Config.Zones[l].MecanoActions.Pos.y, Config.Zones[l].MecanoActions.Pos.z)
	  SetBlipSprite (blip, 446)
	  SetBlipDisplay(blip, 4)
	  SetBlipScale  (blip, 1.8)
	  SetBlipColour (blip, 5)
	  SetBlipAsShortRange(blip, true)
	  BeginTextCommandSetBlipName("STRING")
	  AddTextComponentString(_U('mechanic'))
	  EndTextCommandSetBlipName(blip)
	end
end)


-- Display markers
local nearmarkers = false
Citizen.CreateThread(function()
  while true do
    Wait(0)
	pcall(function()
    if PlayerData.job ~= nil and PlayerData.job.name == 'mecano' then

      local coords = GetEntityCoords(ESX.Game.GetMyPed())
		nearmarkers = false
		
	  for l,w in pairs(Config.Zones) do
		  for k,v in pairs(w) do
			if(v.Type ~= -1 and #(coords - vector3(v.Pos.x, v.Pos.y, v.Pos.z)) < Config.DrawDistance) then
				nearmarkers = true
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
			end
		  end
	  end
	 
	else
		Wait(4000)
    end
	
	if nearmarkers == false then
		Wait(1000)
	end
	end)
  end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function()
  while true do
    Wait(100)
	pcall(function()
    if PlayerData.job ~= nil and PlayerData.job.name == 'mecano' then
      local coords      = GetEntityCoords(ESX.Game.GetMyPed())
      local isInMarker  = false
      local currentZone = nil
	  local currentStation = nil
      for l,w in pairs(Config.Zones) do
		 for k,v in pairs(w) do
			if(#(coords - vector3(v.Pos.x, v.Pos.y, v.Pos.z)) < v.Size.x) then
			  isInMarker  = true
			  currentStation = l
			  currentZone = k
			end
		end
      end
      if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone and currentStation ~= LastStation) then
        HasAlreadyEnteredMarker = true
        LastZone                = currentZone
		LastStation				= currentStation
        TriggerEvent('57050b8d-50a6-44ca-8285-cb0220228d94', currentZone, currentStation)
      end
      if not isInMarker and HasAlreadyEnteredMarker then
        HasAlreadyEnteredMarker = false
        TriggerEvent('78619f56-eeba-4c2c-934e-77f5d1279e90', LastZone,LastStation)
      end
	else
		Wait(4000)
    end
	if nearmarkers == false then
		Wait(1000)
	end
	end)
  end
end)

Citizen.CreateThread(function()

  local trackedEntities = {
      `prop_roadcone02a`
  }

  while true do
	
    Citizen.Wait(20)
	pcall(function()
		if PlayerData.job ~= nil and PlayerData.job.name == 'mecano' then
			local playerPed = ESX.Game.GetMyPed()
			local coords    = ESX.Game.GetMyPedLocation()

			local closestDistance = -1
			local closestEntity   = nil

			for i=1, #trackedEntities, 1 do

			  local object = GetClosestObjectOfType(coords.x,  coords.y,  coords.z,  3.0,  trackedEntities[i], false, false, false)

			  if DoesEntityExist(object) then

				local objCoords = GetEntityCoords(object)
				local distance  = #(coords - objCoords)

				if closestDistance == -1 or closestDistance > distance then
				  closestDistance = distance
				  closestEntity   = object
				end

			  end

			end

			if closestDistance ~= -1 and closestDistance <= 3.0 then

			  if LastEntity ~= closestEntity then
				TriggerEvent('8f57d912-19b0-4dfc-adcc-bc0429d05a19', closestEntity)
				LastEntity = closestEntity
			  end

			else
				 Citizen.Wait(500)
			  if LastEntity ~= nil then
				TriggerEvent('7ff810d8-17a6-4d14-925e-258717fc7cac', LastEntity)
				LastEntity = nil
			  end

			end
		else
			Wait(15000)
		end
	end)
  end
end)

-- Key Controls
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(10)
		pcall(function()
		if PlayerData.job ~= nil and PlayerData.job.name == 'mecano' then
			if CurrentAction ~= nil then

			  SetTextComponentFormat('STRING')
			  AddTextComponentString(CurrentActionMsg)
			  DisplayHelpTextFromStringLabel(0, 0, 1, -1)

			  if IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'mecano' then

				if CurrentAction == 'mecano_actions_menu' then
					OpenMecanoActionsMenu()
				end

				if CurrentAction == 'mecano_harvest_menu' then
					OpenMecanoHarvestMenu()
				end

				if CurrentAction == 'mecano_craft_menu' then
					OpenMecanoCraftMenu()
				end

				if CurrentAction == 'delete_vehicle' then

				  if Config.EnableSocietyOwnedVehicles then

					local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
					TriggerServerEvent('ee25e8b0-b555-4cd2-b500-24c1cbd32f88', 'mecano', vehicleProps)

				  else

					if
					  GetEntityModel(vehicle) == GetHashKey('towtruck2') or
					  GetEntityModel(vehicle) == GetHashKey('cxttow') or
					  GetEntityModel(vehicle) == GetHashKey('slamvan3')
					   or
					  GetEntityModel(vehicle) == GetHashKey('tmcute')
						 or
					  GetEntityModel(vehicle) == GetHashKey('prranger')
						or
					  GetEntityModel(vehicle) == GetHashKey('racvcar')
					then
					  TriggerServerEvent('a91f16e6-8b39-4118-b7d3-68f32f337985', 'mecano')
					end

				  end

				  ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
				end

				if CurrentAction == 'remove_entity' then
				  DeleteEntity(CurrentActionData.entity)
				end

				CurrentAction = nil
			  end
			end

			if IsControlJustReleased(0, Keys['F6']) and not IsDead and PlayerData.job ~= nil and PlayerData.job.name == 'mecano' then
				OpenMobileMecanoActionsMenu()
			end

			--if IsControlJustReleased(0, Keys['PAGEUP']) and not IsDead and PlayerData.job ~= nil and PlayerData.job.name == 'mecano' then
		else
			Wait(5000)
		end

		end)
    end
end)

AddEventHandler('2df4c490-68a8-4c7e-896a-9fc552e16210', function()
	IsDead = true
end)

AddEventHandler('880c0a93-b305-46b3-b84c-a120fee9e841', function(spawn)
	IsDead = false
end)