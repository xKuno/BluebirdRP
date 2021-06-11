--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- ORIGINAL SCRIPT BY Marcio FOR CFX-ESX
-- Script serveur No Brain 
-- www.nobrain.org
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
ESX = nil

local truckout 				  = 0

--------------------------------------------------------------------------------
-- NE RIEN MODIFIER
--------------------------------------------------------------------------------
local completepaytable = nil
local tableupdate = false
local temppaytable =  nil
local totalbagpay = 0
local lastpickup = nil
local platenumb = nil
local paused = false
local iscurrentboss = false
local work_truck = nil
local truckdeposit = false
local trashcollection = false
local trashcollectionpos = nil
local bagsoftrash = nil
local currentbag = nil
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
--------------------------------------------------------------------------------
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end

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

RegisterNetEvent('3c989220-3463-4513-a11d-4ec25e1714a6')
AddEventHandler('3c989220-3463-4513-a11d-4ec25e1714a6', function(binpos, platenumber,  bags)
	if isInService then
		if GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), false)) == platenumber then
			work_truck = GetVehiclePedIsIn(GetPlayerPed(-1), false)
			platenumb = platenumber
			trashcollectionpos = binpos
			bagsoftrash = bags
			currentbag = bagsoftrash
			MissionLivraison = false
			trashcollection = true
			paused = true
			CurrentActionMsg = ''
			CollectionAction = 'collection'
		end
	end
end)

RegisterNetEvent('1a1b9817-e381-4512-9655-3151c7cb8cd9')
AddEventHandler('1a1b9817-e381-4512-9655-3151c7cb8cd9', function(platenumber, bags, crewmember)
	if isInService then
		if platenumb == platenumber then
			if iscurrentboss then
				totalbagpay = totalbagpay + bags
				addcremember = true
				if temppaytable == nil then 
					temppaytable = {}
				 end

				for i, v in pairs(temppaytable) do
					
					if temppaytable[i] == crewmember then
						addcremember = false
					end
				end
				if addcremember then
					table.insert(temppaytable, crewmember)
				end
			end
		end
	end
end)

RegisterNetEvent('4dff704a-ee07-4a9d-bda2-5318519dfac4')
AddEventHandler('4dff704a-ee07-4a9d-bda2-5318519dfac4', function(platenumber, amount)
	if isInService then
		if platenumb == platenumber then
			TriggerServerEvent('37b9375a-885b-4bbc-9b7e-131a4dc8c3b9', amount,"398dahljk3422320432hfdsa")
			platenumb = nil
		end
	end
end)

RegisterNetEvent('1a720eab-eb0e-440e-9919-4b21d540a231')
AddEventHandler('1a720eab-eb0e-440e-9919-4b21d540a231', function(platenumber)
	if isInService then
		if platenumb == platenumber then
			currentbag = currentbag - 1
		end
	end
end)

RegisterNetEvent('03fdf08f-c443-4f46-a13b-8e9fedcf83c0')
AddEventHandler('03fdf08f-c443-4f46-a13b-8e9fedcf83c0', function(platenumber)
	if isInService then
		if platenumb == platenumber then
			if not iscurrentboss then
			TriggerServerEvent('95701b49-560f-47b3-923e-3774e3987666', platenumb, totalbagpay,"398dahljk3422320432hfdsa")
			totalbagpay = 0
			end
		end
	end
end)

RegisterNetEvent('b3d400e8-d2d0-40b6-b8b5-7e50a582f12f')
AddEventHandler('b3d400e8-d2d0-40b6-b8b5-7e50a582f12f', function(platenumber)
	if platenumb == platenumber then
		trashcollectionpos = nil
		bagsoftrash = nil
		work_truck = nil
		trashcollection = false
		truckdeposit = false
		CurrentAction = nil
		CollectionAction = nil
		paused = false
	end

end)





-- MENUS
function MenuCloakRoom()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'cloakroom',
		{
			title    = _U('cloakroom'),
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

					  if skin.sex == 0 then
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
			elements = elements
		},
		function(data, menu)
			ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, 270.0, function(vehicle)
				platenum = math.random(10000, 99999)
				SetVehicleNumberPlateText(vehicle, "WAL"..platenum)             
                MissionLivraisonSelect()
				plaquevehicule = "WAL"..platenum
				if data.current.value == 'phantom3' then
				
					local trailerspawn = Config.Zones.VehicleSpawnPoint.Pos
					trailerspawn["z"] = trailerspawn["z"] + 3.5
					ESX.Game.SpawnVehicle("trailers2", trailerspawn, 270.0, function(trailer)
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

function IsJobgarbage()
	if PlayerData ~= nil then
		local isJobgarbage = false
		if PlayerData.job.name ~= nil and PlayerData.job.name == 'garbage' then
			isJobgarbage = true
		end
		return isJobgarbage
	end
end

AddEventHandler('bacd7f44-d01f-4e34-bdd7-97d71ddd374d', function(zone)

	local playerPed = GetPlayerPed(-1)

	if zone == 'CloakRoom' then
		MenuCloakRoom()
	end

	if zone == 'VehicleSpawner' then
		if isInService and IsJobgarbage() then
			if MissionRetourCamion or MissionLivraison then
				CurrentAction = 'hint'
                CurrentActionMsg  = _U('already_have_truck')
			else
				MenuVehicleSpawner()
			end
		end
	end

	if zone == namezone then
		if isInService and MissionLivraison and MissionNum == namezonenum and MissionRegion == namezoneregion and IsJobgarbage() then
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

	if zone == 'AnnulerMission' then
		if isInService and MissionLivraison and IsJobgarbage() then
			if IsPedSittingInAnyVehicle(playerPed) and IsATruck() then
				VerifPlaqueVehiculeActuel()
				
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
		if isInService and MissionRetourCamion and IsJobgarbage() then
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

AddEventHandler('80040dfd-e1d0-4555-a829-ed76c4cce087', function(zone)
	ESX.UI.Menu.CloseAll()    
    CurrentAction = nil
	CurrentActionMsg = ''
end) 

function nouvelledestination()
	livraisonnombre = livraisonnombre+1
	local count = 0
	local multibagpay = 0
		for i, v in pairs(temppaytable) do 
		count = count + 1 
	end

	if Config.MulitplyBags then 
	multibagpay = totalbagpay * (count + 1)
	else
	multibagpay = totalbagpay
	end
	local testprint = (destination.Paye + multibagpay)
	local temppayamount =  (destination.Paye + multibagpay) / (count + 1)
	TriggerServerEvent('a09e1366-7084-4441-b780-566280e63399', platenumb,  temppayamount)
	livraisonTotalPaye = 0
	totalbagpay = 0
	temppayamount = 0
	temppaytable = nil
	multibagpay = 0
	
	if livraisonnombre >= Config.MaxDelivery then
		truckout = 0
		MissionLivraisonStopRetourDepot()
	else

		livraisonsuite = math.random(0, 100)
		
		if livraisonsuite <= 10 and livraisonnombre > 2 then
			truckout = 0
			MissionLivraisonStopRetourDepot()
			
		elseif livraisonsuite <= 99 then
			MissionLivraisonSelect()
		elseif livraisonsuite <= 100 then
			if MissionRegion == 1 then
				MissionRegion = 2
			elseif MissionRegion == 2 then
				MissionRegion = 1
			end
			MissionLivraisonSelect()	
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

function retourcamionperdu_oui()
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

function retourcamionannulermission_oui()
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

function retourcamionperduannulermission_non()	
	ESX.ShowNotification(_U('resume_delivery'))
end

function round(num, numDecimalPlaces)
    local mult = 5^(numDecimalPlaces or 0)
    return math.floor(num * mult + 0.5) / mult
end

function donnerlapaye()
	ped = GetPlayerPed(-1)
	vehicle = GetVehiclePedIsIn(ped, false)
	vievehicule = GetVehicleEngineHealth(vehicle)
	calculargentretire = round(viemaxvehicule-vievehicule)
	
	if calculargentretire <= 0 then
		argentretire = 0
	else
		argentretire = calculargentretire
	end
	argentretire = 0
    ESX.Game.DeleteVehicle(vehicle)
	
	if livraisonTotalPaye > 0 then
		truckout = 0
	end

	local amount = livraisonTotalPaye-argentretire
	
	if vievehicule >= 1 then
		if livraisonTotalPaye == 0 then
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

function donnerlapayesanscamion()
	ped = GetPlayerPed(-1)
	argentretire = Config.TruckPrice
	
	-- donne paye
	local amount = livraisonTotalPaye-argentretire
	
	if livraisonTotalPaye == 0 then

		livraisonTotalPaye = 0
	else
		if amount >= 1 then

			livraisonTotalPaye = 0
		else

			livraisonTotalPaye = 0
		end
	end
end

function SelectBinandCrew()
	work_truck = GetVehiclePedIsIn(GetPlayerPed(-1), true)
	bagsoftrash = math.random(2, 10)
	local NewBin, NewBinDistance = ESX.Game.GetClosestObject(Config.DumpstersAvaialbe)
	trashcollectionpos = GetEntityCoords(NewBin)
	platenumb = GetVehicleNumberPlateText(GetVehiclePedIsIn(GetPlayerPed(-1), true))
	TriggerServerEvent('3f63d1f7-1b0a-45ce-98ab-9fbdce3ba26c', trashcollectionpos, platenumb, bagsoftrash)
end


-- Key Controls
Citizen.CreateThread(function()
    while true do

		Citizen.Wait(0)
		if IsJobgarbage() then
			if CurrentAction ~= nil or CollectionAction ~= nil then
				plyCoords = GetEntityCoords(GetPlayerPed(-1), false)

				SetTextComponentFormat('STRING')
				AddTextComponentString(CurrentActionMsg)
				DisplayHelpTextFromStringLabel(0, 0, 1, -1)

				if IsControlJustReleased(0, 38) then

					if CollectionAction == 'collection' then
						if not HasAnimDictLoaded("anim@heists@narcotics@trash") then
						RequestAnimDict("anim@heists@narcotics@trash") 
						end
						while not HasAnimDictLoaded("anim@heists@narcotics@trash") do 
						Citizen.Wait(0)
						end
						plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
						dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, trashcollectionpos.x, trashcollectionpos.y, trashcollectionpos.z)
						if dist <= 3.5 then
							if currentbag > 0 then
								TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
								TriggerServerEvent('82cedcfd-0199-4c19-8bad-6b671cefee45', platenumb)
								trashcollection = false
								Citizen.Wait(4000)
								ClearPedTasks(PlayerPedId())
								local randombag = math.random(0,2)
								if randombag == 0 then
									garbagebag = CreateObject(GetHashKey("prop_cs_street_binbag_01"), 0, 0, 0, true, true, true) -- creates object
									AttachEntityToEntity(garbagebag, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.4, 0, 0, 0, 270.0, 60.0, true, true, false, true, 1, true) -- object is attached to right hand    
								elseif randombag == 1 then
									garbagebag = CreateObject(GetHashKey("bkr_prop_fakeid_binbag_01"), 0, 0, 0, true, true, true) -- creates object
									AttachEntityToEntity(garbagebag, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), .65, 0, -.1, 0, 270.0, 60.0, true, true, false, true, 1, true) -- object is attached to right hand    
								elseif randombag == 2 then
									garbagebag = CreateObject(GetHashKey("hei_prop_heist_binbag"), 0, 0, 0, true, true, true) -- creates object
									AttachEntityToEntity(garbagebag, GetPlayerPed(-1), GetPedBoneIndex(GetPlayerPed(-1), 57005), 0.12, 0.0, 0.00, 25.0, 270.0, 180.0, true, true, false, true, 1, true) -- object is attached to right hand    
								end   
								TaskPlayAnim(PlayerPedId(-1), 'anim@heists@narcotics@trash', 'walk', 1.0, -1.0,-1,49,0,0, 0,0)
								truckdeposit = true
								CollectionAction = 'deposit'
							else
								if iscurrentboss then
									TaskStartScenarioInPlace(PlayerPedId(), "WORLD_HUMAN_BUM_WASH", 0, true) 
									if temppaytable == nil then
										temppaytable = {}
									end
									TriggerServerEvent('66655ad1-4214-42e1-9ed6-fb128fe8d239', platenumb)
									Citizen.Wait(4000)
									ClearPedTasks(PlayerPedId())
									setring = false
									bagsoftrash = math.random(2,10)
									currentbag = bagsoftrash 
									CurrentAction = nil
									trashcollection = false
									truckdeposit = false
									ESX.ShowNotification("Collection finished return to truck!")
									while not IsPedInVehicle(GetPlayerPed(-1), work_truck, false) do
										Citizen.Wait(0)
									end
									TriggerServerEvent('b0618359-cd61-41b9-93f1-fc3d680435ff', platenumb)
									SetVehicleDoorShut(work_truck,5,false)
									Citizen.Wait(2000)
									nouvelledestination()
								end
							end
						end
					
					elseif CollectionAction == 'deposit'  then
						local trunk = GetWorldPositionOfEntityBone(work_truck, GetEntityBoneIndexByName(work_truck, "platelight"))
						plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
						dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, trunk.x, trunk.y, trunk.z)
						if dist <= 2.0 then
							Citizen.Wait(5)
							ClearPedTasksImmediately(GetPlayerPed(-1))
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
					end  

					if CurrentAction == 'delivery' then
						SelectBinandCrew()
						while work_truck == nil do
							Citizen.Wait(0)
						end
						iscurrentboss = true
						SetVehicleDoorOpen(work_truck,5,false, false)

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
			Wait(2000)
		end
    end
end)

-- DISPLAY MISSION MARKERS AND MARKERS
Citizen.CreateThread(function()
	while true do
		Wait(0)
		if IsJobgarbage() then
			if truckdeposit then
				local trunk = GetWorldPositionOfEntityBone(work_truck, GetEntityBoneIndexByName(work_truck, "platelight"))
				plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
				DrawMarker(27, trunk.x , trunk.y, trunk.z, 0, 0, 0, 0, 0, 0, 1.25, 1.25, 1.0001, 0, 128, 0, 200, 0, 0, 0, 0)
				dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, trunk.x , trunk.y, trunk.z)
				if dist <= 2.0 then
				ESX.Game.Utils.DrawText3D(vector3(trunk.x , trunk.y ,trunk.z + 0.50), "[~g~E~s~] Throw bag in truck.", 1.0)
				end
			end

			if trashcollection then
				DrawMarker(1, trashcollectionpos.x, trashcollectionpos.y, trashcollectionpos.z, 0, 0, 0, 0, 0, 0, 3.001, 3.0001, 1.0001, 255, 0, 0, 200, 0, 0, 0, 0)
				plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
				dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, trashcollectionpos.x, trashcollectionpos.y, trashcollectionpos.z)
				if dist <= 5.0 then
					if currentbag <= 0 then
						if iscurrentboss then
						ESX.Game.Utils.DrawText3D(trashcollectionpos + vector3(0.0, 0.0, 1.0), "[~g~E~s~] Clean up debris", 1.0)		
						else
						ESX.Game.Utils.DrawText3D(trashcollectionpos + vector3(0.0, 0.0, 1.0), "Collection done.. Wait on truck..", 1.0)		
						end
					else
						ESX.Game.Utils.DrawText3D(trashcollectionpos + vector3(0.0, 0.0, 1.0), "[~g~E~s~] Collect bag from Trashbin ["..currentbag.."/"..bagsoftrash.."]", 1.0)
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

				if isInService and (IsJobgarbage() and v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
				end

			end

			for k,v in pairs(Config.Cloakroom) do

				if(IsJobgarbage() and v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
				end

			end
		else
			Wait(2000)
		end
	end
end)

-- Activate menu when player is inside marker
Citizen.CreateThread(function()
	while true do
		
		Wait(300)

		if IsJobgarbage() then
		
			if not paused then 

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
					TriggerEvent('bacd7f44-d01f-4e34-bdd7-97d71ddd374d', currentZone)
				end

				if not isInMarker and hasAlreadyEnteredMarker then
					hasAlreadyEnteredMarker = false
					TriggerEvent('80040dfd-e1d0-4555-a829-ed76c4cce087', lastZone)
				end
			end
		else
			Wait(2000)
		end
		

	end  
end)

-- CREATE BLIPS
Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Cloakroom.CloakRoom.Pos.x, Config.Cloakroom.CloakRoom.Pos.y, Config.Cloakroom.CloakRoom.Pos.z)
  
	SetBlipSprite (blip, 318)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.2)
	SetBlipColour (blip, 5)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(_U('blip_job'))
	EndTextCommandSetBlipName(blip)
end)

-------------------------------------------------
-- Fonctions
-------------------------------------------------
-- Fonction selection nouvelle mission livraison
function MissionLivraisonSelect()
	if MissionRegion == 0 then
		MissionRegion = math.random(1,2)
	end
	
	if MissionRegion == 1 then -- Los santos
		MissionNum = math.random(1, 10)
		while lastpickup == MissionNum do
			Citizen.Wait(50)
			MissionNum = math.random(1, 10)
		end
		if MissionNum == 1 then destination = Config.Livraison.Delivery1LS namezone = "Delivery1LS" namezonenum = 1 namezoneregion = 1
		elseif MissionNum == 2 then destination = Config.Livraison.Delivery2LS namezone = "Delivery2LS" namezonenum = 2 namezoneregion = 1
		elseif MissionNum == 3 then destination = Config.Livraison.Delivery3LS namezone = "Delivery3LS" namezonenum = 3 namezoneregion = 1
		elseif MissionNum == 4 then destination = Config.Livraison.Delivery4LS namezone = "Delivery4LS" namezonenum = 4 namezoneregion = 1
		elseif MissionNum == 5 then destination = Config.Livraison.Delivery5LS namezone = "Delivery5LS" namezonenum = 5 namezoneregion = 1
		elseif MissionNum == 6 then destination = Config.Livraison.Delivery6LS namezone = "Delivery6LS" namezonenum = 6 namezoneregion = 1
		elseif MissionNum == 7 then destination = Config.Livraison.Delivery7LS namezone = "Delivery7LS" namezonenum = 7 namezoneregion = 1
		elseif MissionNum == 8 then destination = Config.Livraison.Delivery8LS namezone = "Delivery8LS" namezonenum = 8 namezoneregion = 1
		elseif MissionNum == 9 then destination = Config.Livraison.Delivery9LS namezone = "Delivery9LS" namezonenum = 9 namezoneregion = 1
		elseif MissionNum == 10 then destination = Config.Livraison.Delivery10LS namezone = "Delivery10LS" namezonenum = 10 namezoneregion = 1
		end
		
	elseif MissionRegion == 2 then -- Blaine County
		MissionNum = math.random(1, 10)
		while lastpickup == MissionNum do
			Citizen.Wait(50)
			MissionNum = math.random(1, 10)
		end
		if MissionNum == 1 then destination = Config.Livraison.Delivery1BC namezone = "Delivery1BC" namezonenum = 1 namezoneregion = 2
		elseif MissionNum == 2 then destination = Config.Livraison.Delivery2BC namezone = "Delivery2BC" namezonenum = 2 namezoneregion = 2
		elseif MissionNum == 3 then destination = Config.Livraison.Delivery3BC namezone = "Delivery3BC" namezonenum = 3 namezoneregion = 2
		elseif MissionNum == 4 then destination = Config.Livraison.Delivery4BC namezone = "Delivery4BC" namezonenum = 4 namezoneregion = 2
		elseif MissionNum == 5 then destination = Config.Livraison.Delivery5BC namezone = "Delivery5BC" namezonenum = 5 namezoneregion = 2
		elseif MissionNum == 6 then destination = Config.Livraison.Delivery6BC namezone = "Delivery6BC" namezonenum = 6 namezoneregion = 2
		elseif MissionNum == 7 then destination = Config.Livraison.Delivery7BC namezone = "Delivery7BC" namezonenum = 7 namezoneregion = 2
		elseif MissionNum == 8 then destination = Config.Livraison.Delivery8BC namezone = "Delivery8BC" namezonenum = 8 namezoneregion = 2
		elseif MissionNum == 9 then destination = Config.Livraison.Delivery9BC namezone = "Delivery9BC" namezonenum = 9 namezoneregion = 2
		elseif MissionNum == 10 then destination = Config.Livraison.Delivery10BC namezone = "Delivery10BC" namezonenum = 10 namezoneregion = 2
		end
		
	end
	lastpickup = MissionNum
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
								