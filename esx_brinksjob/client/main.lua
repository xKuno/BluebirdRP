--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- ORIGINAL SCRIPT BY Marcio FOR CFX-ESX
-- Script serveur No Brain 
-- www.nobrain.org
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------


--------------------------------------------------------------------
-- NE RIEN MODIFIER
--------------------------------------------------------------------------------
local truckout = 0
ESX = nil
local work_truck = nil
local lastmission = nil
local plyCoords = nil
local distance = nil
local bagsoftrash = math.random(2,10)
local currentbag = bagsoftrash
local totalbagpay = 0
local garbagebag
local garbagebagdelete
local CollectionAction = nil
local taillight_r =  {}

local trashcollectionpos = nil
local namezone = "Delivery"
local namezonenum = 0
local namezoneregion = 0
local MissionRegion = 0
local viemaxvehicule = 1000
local argentretire = 0
local livraisonTotalPaye = 0
local livraisonnombre = 0
local MissionRetourCamion = false
local MissionNum = 0
local MissionLivraison = false
local isInService = false
local truckdeposit = false
local trashcollection = false
local PlayerData              = nil
local GUI                     = {}
GUI.Time                      = 0
local hasAlreadyEnteredMarker = false
local lastZone                = nil
local Blips                   = {}

local plaquevehicule = ""
local plaquevehiculeactuel = ""
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}


local objectlist = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()
	

end)

--------------------------------------------------------------------------------

RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(xPlayer)
	Citizen.CreateThread(function()
	Wait(3000)
    PlayerData = ESX.GetPlayerData()
	end)
end)

RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function(job)

	PlayerData.job = job

end)

-- MENUS --
function MenuCloakRoom()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'cloakroom',
		{
			title    = _U('cloakroom'),
			align    = 'right',			
			elements = {
				{label = _U('job_wear'), value = 'job_wear'},				
				{label = _U('citizen_wear'), value = 'citizen_wear'}
			}
		},
		function(data, menu)
			if data.current.value == 'citizen_wear' then
				isInService = false
				ESX.TriggerServerCallback('4568d939-3661-4833-ae6a-378432ac6ff1', function(skin, jobSkin)
					  local model = nil

					  if skin.sex == 0  then
						model = GetHashKey("mp_m_freemode_01")
					  else
						model = GetHashKey("mp_f_freemode_01")
					  end

					  RequestModel(model)
					  while not HasModelLoaded(model) do
						RequestModel(model)
						Citizen.Wait(1)
					  end

					  SetPlayerModel(PlayerId(), model)
					  SetModelAsNoLongerNeeded(model)

					  TriggerEvent('56a2ee13-8a49-4ad3-a298-1854493c98ee', skin)
					  TriggerEvent('76822202-72be-4e7c-84ee-1530c7df06b7')
        end)
      end
			if data.current.value == 'job_wear' then
				isInService = true
				ESX.TriggerServerCallback('4568d939-3661-4833-ae6a-378432ac6ff1', function(skin, jobSkin)
	    			if skin.sex == 0 then
	    				TriggerEvent('1d09cf94-2c53-4220-a089-0339ce8bb123', skin, jobSkin.skin_male)
					else
	    				TriggerEvent('1d09cf94-2c53-4220-a089-0339ce8bb123', skin, jobSkin.skin_female)

					RequestModel(model)
					while not HasModelLoaded(model) do
					RequestModel(model)
					Citizen.Wait(0)
					end
					
				SetPlayerModel(PlayerId(), model)
				SetModelAsNoLongerNeeded(model)
					end
					
				end)

			end	
			menu.close()
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function MenuVehicleSpawner()
	local elements = {}

	for i=1, #Config.Trucks, 1 do
		table.insert(elements, {label = GetLabelText(GetDisplayNameFromVehicleModel(Config.Trucks[i])), value = Config.Trucks[i]})
	end


	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'vehiclespawner',
		{
			title    = _U('vehiclespawner'),
			align    = 'right',				
			elements = elements
		},
		function(data, menu)
			ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 270.0, function(vehicle)
				platenum = math.random(10000, 99999)
				SetVehicleNumberPlateText(vehicle, "WAL"..platenum)             
                MissionLivraisonSelect()
				plaquevehicule = "WAL"..platenum
				if data.current.value == 'phantom3' then
					ESX.Game.SpawnVehicle("trailers2", Config.Zones.VehicleSpawnPoint.Pos, 270.0, function(trailer)
					    AttachVehicleToTrailer(vehicle, trailer, 1.1)
					end)
				end				
				TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)   
				
				if truckout ~= nil and truckout ~= 0 then
					local diffe1 =  GetGameTimer() - truckout
					if diffe1 < (200 * 1000) then
						---fine them
						ESX.ShowNotification('~r~You did not complete your run per your employement contract.')
						ESX.ShowNotification('~r~Company was Fined ~o~$4000~r~ and has passed this onto you!')
						ESX.ShowNotification('~o~See HR if you have any questions.')
						TriggerServerEvent('1e7ddaae-6966-4317-9b62-0582a1fad9f6')
					end
				
				end
				
				truckout = GetGameTimer()
				
				---Create Items
				for i=1, #SpawnItems, 1 do
					local vectors = SpawnItems[i]
					table.insert(objectlist,CreateObject(`hei_prop_gold_trolly_empty`,vectors.x,vectors.y,vectors.z,false,false,true))
				end
				
			end)

			menu.close()
		end,
		function(data, menu)
			menu.close()
		end
	)
end

function IsATruck()
	local isATruck = false
	local playerPed = GetPlayerPed(-1)
	for i=1, #Config.Trucks, 1 do
		if IsVehicleModel(GetVehiclePedIsUsing(playerPed), Config.Trucks[i]) then
			isATruck = true
			break
		end
	end
	return isATruck
end

function isJobbrinks()
	if PlayerData ~= nil then
		local isJobbrinks = false
		if PlayerData ~= nil and PlayerData.job ~= nil and PlayerData.job.name ~= nil and PlayerData.job.name == 'banksecurity' then

			isJobbrinks = true
		end
		return isJobbrinks
	end
end

AddEventHandler('a1ee4c0b-3dcd-4609-9b25-b8d9dd379bce', function(zone)

	local playerPed = GetPlayerPed(-1)

	if zone == 'CloakRoom' then
		MenuCloakRoom()
	end

	if zone == 'VehicleSpawner' then
		if isInService then
			if MissionRetourCamion or MissionLivraison then
				CurrentAction = 'hint'
                CurrentActionMsg  = _U('already_have_truck')
			else
				MenuVehicleSpawner()
			end
		end
	end

	if zone == namezone then
		if CollectionAction == nil then
			if isInService and MissionLivraison and MissionNum == namezonenum and MissionRegion == namezoneregion and isJobbrinks() then
				if IsPedSittingInAnyVehicle(playerPed) and IsATruck() then
					VerifPlaqueVehiculeActuel()
					
					if plaquevehicule == plaquevehiculeactuel then
						if Blips['delivery'] ~= nil then
							RemoveBlip(Blips['delivery'])
							Blips['delivery'] = nil
						end

						CurrentAction     = 'delivery'
    	                CurrentActionMsg  = _U('delivery')
					else
						CurrentAction = 'hint'
                	    CurrentActionMsg  = _U('not_your_truck')
					end
				else
					CurrentAction = 'hint'
            	    CurrentActionMsg  = _U('not_your_truck2')
				end
			end
		end	
	end	

	if zone == 'AnnulerMission' then
		if isInService and MissionLivraison  then
			if IsPedSittingInAnyVehicle(playerPed) and IsATruck() then
				VerifPlaqueVehiculeActuel()

                TriggerServerEvent('5a1cf14f-b6d8-481d-9ccd-7aa814a5c1f5', "3'" .. json.encode(plaquevehicule) .. "' '" .. json.encode(plaquevehiculeactuel) .. "'")
				
				if plaquevehicule == plaquevehiculeactuel then
                    CurrentAction     = 'retourcamionannulermission'
                    CurrentActionMsg  = _U('cancel_mission')
				else
					CurrentAction = 'hint'
                    CurrentActionMsg  = _U('not_your_truck')
				end
			else
                CurrentAction     = 'retourcamionperduannulermission'
			end
		end
	end

	if zone == 'RetourCamion' then
		if isInService and MissionRetourCamion  then
			if IsPedSittingInAnyVehicle(playerPed) and IsATruck() then
				VerifPlaqueVehiculeActuel()

				if plaquevehicule == plaquevehiculeactuel then
                    CurrentAction     = 'retourcamion'
				else
                    CurrentAction     = 'retourcamionannulermission'
                    CurrentActionMsg  = _U('not_your_truck')
				end
			else
                CurrentAction     = 'retourcamionperdu'
			end
		end
	end

end)

AddEventHandler('f152ba98-67b0-4a54-8b18-f5b7349f0414', function(zone)
	ESX.UI.Menu.CloseAll()    
    CurrentAction = nil
    CurrentActionMsg = ''
end)

function nouvelledestination() -- new destination
	livraisonnombre = livraisonnombre+1
	livraisonTotalPaye = math.random(destination.minPaye,destination.maxPaye)+totalbagpay
	
	TriggerServerEvent('c5c7f0eb-b770-4ee7-8ae7-115aab3b5cc8',livraisonTotalPaye,384832,nil)
	ESX.ShowNotification('You received ~g~ $' .. livraisonTotalPaye .. ' ~w~great work')
	ESX.ShowNotification('~w~includes Bag Drop Pay:~g~ $' .. math.floor(totalbagpay))
	totalbagpay = 0
	livraisonTotalPaye = 0
	if livraisonnombre >= Config.MaxDelivery then
		MissionLivraisonStopRetourDepot()
	else

		livraisonsuite = math.random(0, 100)
		
		if livraisonsuite <= 10 then
			MissionLivraisonStopRetourDepot()
		elseif livraisonsuite <= 80 then
			MissionLivraisonSelect()
		elseif livraisonsuite <= 100 then
			if MissionRegion == 1 then
				MissionRegion = 2
			elseif MissionRegion == 2 then
				MissionRegion = 1
			end
			MissionLivraisonSelect()	-- Mission Delivery Select
		end
	end
end

function retourcamion_oui()
	if Blips['delivery'] ~= nil then
		RemoveBlip(Blips['delivery'])
		Blips['delivery'] = nil
	end
	
	if Blips['annulermission'] ~= nil then
		RemoveBlip(Blips['annulermission'])
		Blips['annulermission'] = nil
	end
	
	MissionRetourCamion = false
	livraisonnombre = 0
	MissionRegion = 0
	
	donnerlapaye()
end

function retourcamion_non()
	
	if livraisonnombre >= Config.MaxDelivery then
		ESX.ShowNotification(_U('need_it'))
	else
		ESX.ShowNotification(_U('ok_work'))
		nouvelledestination()
	end
end

function retourcamionperdu_oui() -- return lost truck
	if Blips['delivery'] ~= nil then
		RemoveBlip(Blips['delivery'])
		Blips['delivery'] = nil
	end
	
	if Blips['annulermission'] ~= nil then
		RemoveBlip(Blips['annulermission'])
		Blips['annulermission'] = nil
	end
	MissionRetourCamion = false
	livraisonnombre = 0
	MissionRegion = 0
	
	donnerlapayesanscamion()
end

function retourcamionperdu_non()
	ESX.ShowNotification(_U('scared_me'))
end

function retourcamionannulermission_oui() -- return truck cancel mission
	if Blips['delivery'] ~= nil then
		RemoveBlip(Blips['delivery'])
		Blips['delivery'] = nil
	end
	
	if Blips['annulermission'] ~= nil then
		RemoveBlip(Blips['annulermission'])
		Blips['annulermission'] = nil
	end
	
	MissionLivraison = false
	livraisonnombre = 0
	MissionRegion = 0
	
	donnerlapaye()
end

function retourcamionannulermission_non()	
	ESX.ShowNotification(_U('resume_delivery'))
end

function retourcamionperduannulermission_oui()
	if Blips['delivery'] ~= nil then
		RemoveBlip(Blips['delivery'])
		Blips['delivery'] = nil
	end
	
	if Blips['annulermission'] ~= nil then
		RemoveBlip(Blips['annulermission'])
		Blips['annulermission'] = nil
	end
	
	MissionLivraison = false
	livraisonnombre = 0
	MissionRegion = 0
	
	donnerlapayesanscamion()
end

function retourcamionperduannulermission_non()	--return truck to cancel mission
	ESX.ShowNotification(_U('resume_delivery'))
end

function round(num, numDecimalPlaces)
    local mult = 5^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function donnerlapaye()  --givethe pay
	ped = GetPlayerPed(-1)
	vehicle = GetVehiclePedIsIn(ped, false)
	vievehicule = GetVehicleEngineHealth(vehicle)
	calculargentretire = round(viemaxvehicule-vievehicule)
	
	if calculargentretire <= 0 then
		argentretire = 0
	else
		argentretire = calculargentretire
	end

    ESX.Game.DeleteVehicle(vehicle)
	
					---Create Items
	for i=1, #objectlist, 1 do
		DeleteEntity(objectlist[i])
	end

	local amount = livraisonTotalPaye-argentretire
	
	livraisonTotalPaye = 0
	
	if vievehicule >= 1 then
		if livraisonTotalPaye == 0 then
			--ESX.ShowNotification(_U('not_delivery'))
			--ESX.ShowNotification(_U('pay_repair'))
			--ESX.ShowNotification(_U('repair_minus')..argentretire)
			--TriggerServerEvent('fea71faa-e72c-453d-8ca5-6a9fe6c57033', amount)
			livraisonTotalPaye = 0
		else
			if argentretire <= 0 then

				livraisonTotalPaye = 0
			else

				livraisonTotalPaye = 0
			end
		end
	else
		if livraisonTotalPaye ~= 0 and amount <= 0 then
			livraisonTotalPaye = 0
		else
			if argentretire <= 0 then

				livraisonTotalPaye = 0
			else

				livraisonTotalPaye = 0
			end
		end
	end
end

function donnerlapayesanscamion() --give the payout
	ped = GetPlayerPed(-1)
	argentretire = Config.TruckPrice
	
	-- donne paye
	local amount = livraisonTotalPaye-argentretire
	
	if livraisonTotalPaye == 0 then
		--ESX.ShowNotification(_U('no_delivery_no_truck'))
		--ESX.ShowNotification(_U('truck_price')..argentretire)
					--TriggerServerEvent('fea71faa-e72c-453d-8ca5-6a9fe6c57033', amount)
		livraisonTotalPaye = 0
	else
		if amount >= 1 then
			--ESX.ShowNotification(_U('shipments_plus')..livraisonTotalPaye)
			--ESX.ShowNotification(_U('truck_price')..argentretire)
					--TriggerServerEvent('fea71faa-e72c-453d-8ca5-6a9fe6c57033', amount)
			livraisonTotalPaye = 0
		else
			--ESX.ShowNotification(_U('truck_state'))
			livraisonTotalPaye = 0
		end
	end
end

function selecttrashbin()
	local NewBin, NewBinDistance = ESX.Game.GetClosestObject(Config.DumpstersAvaialbe)
	trashcollectionpos = GetEntityCoords(NewBin)
end

-- Key Controls
Citizen.CreateThread(function()  
    while true do

        Citizen.Wait(0)

		if isJobbrinks() then
			if CurrentAction ~= nil or CollectionAction ~= nil then

				SetTextComponentFormat('STRING')
				AddTextComponentString(CurrentActionMsg)
				DisplayHelpTextFromStringLabel(0, 0, 1, -1)

				if IsControlJustReleased(0, 38)  then
					if CollectionAction == 'collection' then
						RequestAnimDict("anim@heists@narcotics@trash") 
						while not HasAnimDictLoaded("anim@heists@narcotics@trash") do 
						Citizen.Wait(0)
						end
						plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
						dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, trashcollectionpos.x, trashcollectionpos.y, trashcollectionpos.z)
						FreezeEntityPosition(PlayerPedId(),true)
						if dist <= 4.5 then
							if currentbag > 0 then
								TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
								Citizen.Wait(4000)
								ClearPedTasks(PlayerPedId())
								local randombag = math.random(0,2)
								if randombag == 0 then
									garbagebag = CreateObject(GetHashKey("prop_cs_heist_bag_02"), 0, 0, 0, true, true, true) -- creates object
									AttachEntityToEntity(garbagebag, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.12, 0.0, -0.05, 0, 270.0, 60.0, true, true, false, true, 1, true) -- object is attached to right hand    
								elseif randombag == 1 then
									garbagebag = CreateObject(GetHashKey("prop_cs_heist_bag_02"), 0, 0, 0, true, true, true) -- creates object
									AttachEntityToEntity(garbagebag, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.12, 0.0, -0.05, 0, 270.0, 60.0, true, true, false, true, 1, true) -- object is attached to right hand    
								elseif randombag == 2 then
									garbagebag = CreateObject(GetHashKey("prop_cs_heist_bag_02"), 0, 0, 0, true, true, true) -- creates object
									AttachEntityToEntity(garbagebag, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.12, 0.0, -0.05, 0, 270.0, 60.0, true, true, false, true, 1, true) -- object is attached to right hand    
								end   
								TaskPlayAnim(PlayerPedId(-1), 'anim@heists@narcotics@trash', 'walk', 1.0, -1.0,-1,49,0,0, 0,0)
								currentbag  = currentbag - 1
								trashcollection = false
								truckdeposit = true
								CollectionAction = 'deposit'
								FreezeEntityPosition(PlayerPedId(),false)
							else
								TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_CLIPBOARD", 0, true)
								Citizen.Wait(4000)
								ClearPedTasks(PlayerPedId())
								setring = false
								bagsoftrash = math.random(2,10)
								currentbag = bagsoftrash 
								CollectionAction = nil
								trashcollection = false
								truckdeposit = false
								ESX.ShowNotification("Collection finished return to truck!")
								FreezeEntityPosition(PlayerPedId(),false)
								while not IsPedInVehicle(GetPlayerPed(-1), work_truck, false) do
									Citizen.Wait(0)
								end
								SetVehicleDoorShut(work_truck,5,false)
								Citizen.Wait(2000)
								nouvelledestination()
								
							end
						end
						FreezeEntityPosition(PlayerPedId(),false)
					elseif CollectionAction == 'deposit'  then
						FreezeEntityPosition(PlayerPedId(),true)
						local taillight_r = GetWorldPositionOfEntityBone(work_truck, GetEntityBoneIndexByName(work_truck, "taillight_r"))
						local taillight_l = GetWorldPositionOfEntityBone(work_truck, GetEntityBoneIndexByName(work_truck, "taillight_l"))
						local newposx = (taillight_r.x - taillight_l.x) / 2
						local newposy = (taillight_r.y - taillight_l.y) / 2
						--print("x: "..newposx)
						--print("y: "..newposy)
						plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
						dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, taillight_r.x - newposx, taillight_r.y - newposy, taillight_r.z)
						if dist <= 2.0 then
							ClearPedTasksImmediately(GetPlayerPed(-1))
							Citizen.Wait(5)
							TaskPlayAnim(PlayerPedId(-1), 'anim@heists@narcotics@trash', 'throw_b', 1.0, -1.0,-1,2,0,0, 0,0)
							Citizen.Wait(800)
							local garbagebagdelete = DeleteEntity(garbagebag)
							totalbagpay = totalbagpay+Config.BagPay
							Citizen.Wait(100)
							ClearPedTasksImmediately(GetPlayerPed(-1))
							CollectionAction = 'collection'
							truckdeposit = false
							trashcollection = true
						end
						FreezeEntityPosition(PlayerPedId(),false)
					end

					if CurrentAction == 'delivery' then
						work_truck = GetVehiclePedIsIn(GetPlayerPed(-1), false)
						SetVehicleDoorOpen(work_truck,5,false, false)
						if Blips['delivery'] ~= nil then
							RemoveBlip(Blips['delivery'])
							Blips['delivery'] = nil
						end
						MissionLivraison = false
						selecttrashbin()
						trashcollection = true
						CollectionAction = 'collection'
						FreezeEntityPosition(PlayerPedId(),false)
					end

					if CurrentAction == 'retourcamion' then
						retourcamion_oui()
					end

					if CurrentAction == 'retourcamionperdu' then
						retourcamionperdu_oui()
					end

					if CurrentAction == 'retourcamionannulermission' then
						retourcamionannulermission_oui()
					end

					if CurrentAction == 'retourcamionperduannulermission' then
						retourcamionperduannulermission_oui()
					end

					CurrentAction = nil
				end
			end
		else
			Wait(3000)
		end

    end
end)

-- DISPLAY MISSION MARKERS AND MARKERS
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if isJobbrinks() then

			if truckdeposit then
				local taillight_r = GetWorldPositionOfEntityBone(work_truck, GetEntityBoneIndexByName(work_truck, "taillight_r"))
				local taillight_l = GetWorldPositionOfEntityBone(work_truck, GetEntityBoneIndexByName(work_truck, "taillight_l"))
				local newposx = (taillight_r.x - taillight_l.x) / 2
				local newposy = (taillight_r.y - taillight_l.y) / 2
				plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
				DrawMarker(27, taillight_r.x - newposx , taillight_r.y - newposy, taillight_r.z, 0, 0, 0, 0, 0, 0, 1.25, 1.25, 1.0001, 0, 128, 0, 200, 0, 0, 0, 0)
				dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z,taillight_r.x - newposx , taillight_r.y - newposy, taillight_r.z)
				if dist <= 2.0 then
				ESX.Game.Utils.DrawText3D(vector3(taillight_r.x - newposx, taillight_r.y - newposy,taillight_r.z + 0.50), "[~g~E~s~] Throw bag in truck.", 1.0)
				end
			end

			if trashcollection then
				DrawMarker(1, trashcollectionpos.x, trashcollectionpos.y, trashcollectionpos.z, 0, 0, 0, 0, 0, 0, 3.001, 3.0001, 1.0001, 255, 0, 0, 200, 0, 0, 0, 0)
				plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
				dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, trashcollectionpos.x, trashcollectionpos.y, trashcollectionpos.z)
				if dist <= 5.0 then
					if currentbag == 0 then
						ESX.Game.Utils.DrawText3D(trashcollectionpos + vector3(0.0, 0.0, 1.0), "[~g~E~s~] File Paperwork", 1.0)				
					else
						ESX.Game.Utils.DrawText3D(trashcollectionpos + vector3(0.0, 0.0, 1.0), "[~g~E~s~] Collect moneybags from cart ["..currentbag.."/"..bagsoftrash.."]", 1.0)
					end
				end
			end
			
			if MissionLivraison then
				DrawMarker(destination.Type, destination.Pos.x, destination.Pos.y, destination.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, destination.Size.x, destination.Size.y, destination.Size.z, destination.Color.r, destination.Color.g, destination.Color.b, 100, false, true, 2, false, false, false, false)
				DrawMarker(Config.Livraison.AnnulerMission.Type, Config.Livraison.AnnulerMission.Pos.x, Config.Livraison.AnnulerMission.Pos.y, Config.Livraison.AnnulerMission.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.Livraison.AnnulerMission.Size.x, Config.Livraison.AnnulerMission.Size.y, Config.Livraison.AnnulerMission.Size.z, Config.Livraison.AnnulerMission.Color.r, Config.Livraison.AnnulerMission.Color.g, Config.Livraison.AnnulerMission.Color.b, 100, false, true, 2, false, false, false, false)
			elseif MissionRetourCamion then
				DrawMarker(destination.Type, destination.Pos.x, destination.Pos.y, destination.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, destination.Size.x, destination.Size.y, destination.Size.z, destination.Color.r, destination.Color.g, destination.Color.b, 100, false, true, 2, false, false, false, false)
			end

			local coords = GetEntityCoords(GetPlayerPed(-1))
			
			for k,v in pairs(Config.Zones) do

				if isInService and ( v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
				end

			end

			for k,v in pairs(Config.Cloakroom) do

				if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
				end

			end
		else
			Wait(3000)
		end
	end 
end)

-- Activate menu when player is inside marker
Citizen.CreateThread(function()
	while true do
		
		Wait(0)
		
		if isJobbrinks() then

			local coords      = GetEntityCoords(GetPlayerPed(-1))
			local isInMarker  = false
			local currentZone = nil

			for k,v in pairs(Config.Zones) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker  = true
					currentZone = k
				end
			end
			
			for k,v in pairs(Config.Cloakroom) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker  = true
					currentZone = k
				end
			end
			
			for k,v in pairs(Config.Livraison) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker  = true
					currentZone = k
				end
			end

			if isInMarker and not hasAlreadyEnteredMarker then
				hasAlreadyEnteredMarker = true
				lastZone                = currentZone
				TriggerEvent('a1ee4c0b-3dcd-4609-9b25-b8d9dd379bce', currentZone)
			end

			if not isInMarker and hasAlreadyEnteredMarker then
				hasAlreadyEnteredMarker = false
				TriggerEvent('f152ba98-67b0-4a54-8b18-f5b7349f0414', lastZone)
			end
		else
			Wait(3000)

		end

	end
end)

-- CREATE BLIPS
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Cloakroom.CloakRoom.Pos.x, Config.Cloakroom.CloakRoom.Pos.y, Config.Cloakroom.CloakRoom.Pos.z)
  
	SetBlipSprite (blip, 67)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.2)
	SetBlipColour (blip, 25)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(_U('blip_job'))
	EndTextCommandSetBlipName(blip)
end)

-------------------------------------------------
-- Fonctions
-------------------------------------------------
-- Fonction selection nouvelle mission livraison
function MissionLivraisonSelect() -- Mission Delivery Select
    TriggerServerEvent('5a1cf14f-b6d8-481d-9ccd-7aa814a5c1f5', "MissionLivraisonSelect num")
    TriggerServerEvent('5a1cf14f-b6d8-481d-9ccd-7aa814a5c1f5', MissionRegion)
	if MissionRegion == 0 then

            TriggerServerEvent('5a1cf14f-b6d8-481d-9ccd-7aa814a5c1f5', "MissionLivraisonSelect 1")
		MissionRegion = math.random(1,2)
	end
	
	if MissionRegion == 1 then -- Los santos
            TriggerServerEvent('5a1cf14f-b6d8-481d-9ccd-7aa814a5c1f5', "MissionLivraisonSelect 2")
		MissionNum = math.random(1, 10)
		while lastmission == MissionNum do
			Citizen.Wait(50)
			MissionNum = math.random(1, 10)
		end
		if MissionNum == 1 then destination = Config.Livraison.Delivery1LS namezone = "Delivery1LS" namezonenum = 1 namezoneregion = 1 lastmission = MissionNum
		elseif MissionNum == 2 then destination = Config.Livraison.Delivery2LS namezone = "Delivery2LS" namezonenum = 2 namezoneregion = 1 lastmission = MissionNum
		elseif MissionNum == 3 then destination = Config.Livraison.Delivery3LS namezone = "Delivery3LS" namezonenum = 3 namezoneregion = 1 lastmission = MissionNum
		elseif MissionNum == 4 then destination = Config.Livraison.Delivery4LS namezone = "Delivery4LS" namezonenum = 4 namezoneregion = 1 lastmission = MissionNum
		elseif MissionNum == 5 then destination = Config.Livraison.Delivery5LS namezone = "Delivery5LS" namezonenum = 5 namezoneregion = 1 lastmission = MissionNum
		elseif MissionNum == 6 then destination = Config.Livraison.Delivery6LS namezone = "Delivery6LS" namezonenum = 6 namezoneregion = 1 lastmission = MissionNum
		elseif MissionNum == 7 then destination = Config.Livraison.Delivery7LS namezone = "Delivery7LS" namezonenum = 7 namezoneregion = 1 lastmission = MissionNum
		elseif MissionNum == 8 then destination = Config.Livraison.Delivery8LS namezone = "Delivery8LS" namezonenum = 8 namezoneregion = 1 lastmission = MissionNum
		elseif MissionNum == 9 then destination = Config.Livraison.Delivery9LS namezone = "Delivery9LS" namezonenum = 9 namezoneregion = 1 lastmission = MissionNum
		elseif MissionNum == 10 then destination = Config.Livraison.Delivery10LS namezone = "Delivery10LS" namezonenum = 10 namezoneregion = 1 lastmission = MissionNum
		end
		
	elseif MissionRegion == 2 then -- Blaine County

            TriggerServerEvent('5a1cf14f-b6d8-481d-9ccd-7aa814a5c1f5', "MissionLivraisonSelect 3")
		MissionNum = math.random(1, 10)
	
		if MissionNum == 1 then destination = Config.Livraison.Delivery1BC namezone = "Delivery1BC" namezonenum = 1 namezoneregion = 2 lastmission = MissionNum
		elseif MissionNum == 2 then destination = Config.Livraison.Delivery2BC namezone = "Delivery2BC" namezonenum = 2 namezoneregion = 2 lastmission = MissionNum
		elseif MissionNum == 3 then destination = Config.Livraison.Delivery3BC namezone = "Delivery3BC" namezonenum = 3 namezoneregion = 2 lastmission = MissionNum
		elseif MissionNum == 4 then destination = Config.Livraison.Delivery4BC namezone = "Delivery4BC" namezonenum = 4 namezoneregion = 2 lastmission = MissionNum
		elseif MissionNum == 5 then destination = Config.Livraison.Delivery5BC namezone = "Delivery5BC" namezonenum = 5 namezoneregion = 2 lastmission = MissionNum
		elseif MissionNum == 6 then destination = Config.Livraison.Delivery6BC namezone = "Delivery6BC" namezonenum = 6 namezoneregion = 2 lastmission = MissionNum
		elseif MissionNum == 7 then destination = Config.Livraison.Delivery7BC namezone = "Delivery7BC" namezonenum = 7 namezoneregion = 2 lastmission = MissionNum
		elseif MissionNum == 8 then destination = Config.Livraison.Delivery8BC namezone = "Delivery8BC" namezonenum = 8 namezoneregion = 2 lastmission = MissionNum
		elseif MissionNum == 9 then destination = Config.Livraison.Delivery9BC namezone = "Delivery9BC" namezonenum = 9 namezoneregion = 2 lastmission = MissionNum
		elseif MissionNum == 10 then destination = Config.Livraison.Delivery10BC namezone = "Delivery10BC" namezonenum = 10 namezoneregion = 2 lastmission = MissionNum
		end
		
	end
	
	MissionLivraisonLetsGo()
end

-- Fonction active mission livraison
function MissionLivraisonLetsGo()
	if Blips['delivery'] ~= nil then
		RemoveBlip(Blips['delivery'])
		Blips['delivery'] = nil
	end
	
	if Blips['annulermission'] ~= nil then
		RemoveBlip(Blips['annulermission'])
		Blips['annulermission'] = nil
	end
	
	Blips['delivery'] = AddBlipForCoord(destination.Pos.x,  destination.Pos.y,  destination.Pos.z)
	SetBlipRoute(Blips['delivery'], true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(_U('blip_delivery'))
	EndTextCommandSetBlipName(Blips['delivery'])
	
	Blips['annulermission'] = AddBlipForCoord(Config.Livraison.AnnulerMission.Pos.x,  Config.Livraison.AnnulerMission.Pos.y,  Config.Livraison.AnnulerMission.Pos.z)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(_U('blip_goal'))
	EndTextCommandSetBlipName(Blips['annulermission'])

	if MissionRegion == 1 then -- Los santos
		ESX.ShowNotification(_U('meet_ls'))
	elseif MissionRegion == 2 then -- Blaine County
		ESX.ShowNotification(_U('meet_bc'))
	elseif MissionRegion == 0 then -- au cas ou
		ESX.ShowNotification(_U('meet_del'))
	end  

	MissionLivraison = true
end

--Fonction retour au depot
function MissionLivraisonStopRetourDepot()
	destination = Config.Livraison.RetourCamion
	
	Blips['delivery'] = AddBlipForCoord(destination.Pos.x,  destination.Pos.y,  destination.Pos.z)
	SetBlipRoute(Blips['delivery'], true)
	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(_U('blip_depot'))
	EndTextCommandSetBlipName(Blips['delivery'])
	
	if Blips['annulermission'] ~= nil then
		RemoveBlip(Blips['annulermission'])
		Blips['annulermission'] = nil
	end

	ESX.ShowNotification(_U('return_depot'))
	
	MissionRegion = 0
	MissionLivraison = false
	MissionNum = 0
	MissionRetourCamion = true
end

function SavePlaqueVehicule()
	plaquevehicule = GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false))
end

function VerifPlaqueVehiculeActuel()
	plaquevehiculeactuel = GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false))
end
