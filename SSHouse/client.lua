ESX	= nil
local timer, drawRange, timeInd, keyRequests, keyChanges, activeKey = 0, 0, -1, 0, 0, 51
local HasAlreadyEnteredMarker, isDead, isInMarker, canUpdate, atShop, inShop, inAuction, shouldDelete, inHome, isUnfurnishing, blinking = false, false, false, false, false, false, false, false, false, false, false
local LastZone, CurrentAction, currentZone, spawnedFurn, homeID, dor2Update, returnPos
local CurrentActionMsg, currentHouseID = '', ''
local CurrentActionData, PlayerData, Houses, ParkedCars, SpawnedHome, FrontDoor, spawnedHouseSpots, scriptBlips, validObjects, spawnedProps, persFurn, ticks, totalKeys = {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}, {}
local Blips, Markers = Config.Blips, Config.Markers

local translog = {}

RegisterNetEvent('d06c57fd-9749-4cea-8a81-5657b1c6c969')
AddEventHandler('d06c57fd-9749-4cea-8a81-5657b1c6c969', function()
	TriggerEvent(Config.Strings.trigEv, function(obj) ESX = obj end)
end)


Citizen.CreateThread(function()
	while true do
		Wait(1000 * 60 * 15)
		print(collectgarbage("collect"))
		Wait(30000)
		print(collectgarbage("collect"))
	end
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerServerEvent('4e7f486a-6dc7-4448-847f-3c0bdc07cfb6')
		Citizen.Wait(10)
	end
	while not ESX.IsPlayerLoaded() do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
	while not HasCollisionLoadedAroundEntity(PlayerPedId()) do 
		ESX.ShowHelpNotification('Final loading, please wait. ', false, false, 100)
		Citizen.Wait(100)
		ESX.ShowHelpNotification('Final loading, please wait.. ', false, false, 100)
		Citizen.Wait(100)
		ESX.ShowHelpNotification('Final loading, please wait...', false, false, 100)
		Citizen.Wait(100)
	end
	if Config.MonthlyContracts then
		TriggerServerEvent('c83daa53-330b-4307-a6e1-87b6419c0a11')
	end
	local blip = AddBlipForCoord(Config.Furnishing.Store.enter)

	SetBlipSprite (blip, Blips.Furniture.Sprite)
	SetBlipScale  (blip, Blips.Furniture.Scale)
	SetBlipAsShortRange(blip, true)
	SetBlipColour (blip, Blips.Furniture.Color)
	SetBlipDisplay(blip, 5)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(Config.Furnishing.Store.name)
	EndTextCommandSetBlipName(blip)
	table.insert(scriptBlips, blip)
	
	Citizen.Wait(math.random(100,15000))
	
	Citizen.Wait(math.random(300,1800))
	
	ESX.TriggerServerCallback('1a7ade14-a928-40cb-87a5-2f1d2f4aa591', function(houses)
		local isRAgent = IsRealEstate()
		for k,v in pairs(houses) do
			local door = json.decode(v.door)
			local storage = json.decode(v.storage)
			local wardrobe = json.decode(v.wardrobe)
			v.door = vector3(door.x, door.y, door.z)
			v.storage = vector3(storage.x, storage.y, storage.z)
			v.wardrobe = vector3(wardrobe.x, wardrobe.y, wardrobe.z)
			v.doors = json.decode(v.doors)
			v.garages = json.decode(v.garages)
			v.furniture = json.decode(v.furniture)
			v.parkings = json.decode(v.parkings)
			v.keys = json.decode(v.keys)
			if v.job ~= nil then
				if v.jobmarker ~= nil then
					local jobmarker = json.decode(v.jobmarker)
					v.jobmarker = vector3(jobmarker.x, jobmarker.y, jobmarker.z)
				end
			end
			Houses[v.id] = v
		end
		for k,v in pairs(Houses) do
			local IsHidden = IsAddressHidden(v.id)
			if not IsHidden then

				if PlayerData.identifier == v.owner then
					local blip = AddBlipForCoord(v.door)
					SetBlipScale  (blip, 1.0)
					SetBlipAsShortRange(blip, true)
					SetBlipSprite (blip, Blips.OwnedHome.Sprite)
					SetBlipColour (blip, Blips.OwnedHome.Color)
					SetBlipScale  (blip, Blips.OwnedHome.Scale)
					SetBlipDisplay(blip, Blips.OwnedHome.Display)
					
					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString(k)
					EndTextCommandSetBlipName(blip)
					table.insert(scriptBlips, blip)
				elseif v.owner == 'nil' then
					
					local blip = AddBlipForCoord(v.door)
					if isRAgent == true  then
						SetBlipScale  (blip, 1.0)
						SetBlipAsShortRange(blip, true)		
						SetBlipSprite (blip, Blips.UnOwnedHome.Sprite)
						SetBlipColour (blip, Blips.UnOwnedHome.Color)
						SetBlipScale  (blip, Blips.UnOwnedHome.Scale)
						SetBlipDisplay(blip, 4)
						
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString(k)
						EndTextCommandSetBlipName(blip)
						table.insert(scriptBlips, blip)
					else
						SetBlipScale  (blip, 1.0)
						SetBlipAsShortRange(blip, true)				
						SetBlipSprite (blip, Blips.UnOwnedHome.Sprite)
						SetBlipColour (blip, Blips.UnOwnedHome.Color)
						SetBlipScale  (blip, Blips.UnOwnedHome.Scale)
						SetBlipDisplay(blip, Blips.UnOwnedHome.Display)
						
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString(k)
						EndTextCommandSetBlipName(blip)
						table.insert(scriptBlips, blip)

					end
				else
					--realestate
					if isRAgent == true  then
						local blip = AddBlipForCoord(v.door)

						SetBlipScale  (blip, 1.0)
						SetBlipAsShortRange(blip, true)					
						SetBlipSprite (blip, Blips.OtherOwnedHome.Sprite)
						SetBlipColour (blip, Blips.OtherOwnedHome.Color)
						SetBlipScale  (blip, Blips.OtherOwnedHome.Scale)
						SetBlipDisplay(blip, Blips.OtherOwnedHome.Display)
						
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString(k)
						EndTextCommandSetBlipName(blip)
						table.insert(scriptBlips, blip)
					end
				end

			end

			
			if v.furniture ~= nil then
				for g,f in pairs(v.furniture.outside) do
					table.insert(persFurn, {model = f.prop, pos = vector3(f.x, f.y, f.z), head = f.heading})
				end
			else
				print('#### PROBLEM #######')
				print(v.id)
				print(json.encode(v.furniture))
			end
		end
		houses = nil
	end)
	
	
	ESX.TriggerServerCallback('07188a7e-9a59-415f-b770-c0d3a510c236', function(address)
		if Houses[address] then
			if Config.ReconnectInside then
				TriggerEvent('248c76d3-2f36-4426-a205-d265b462e289', Houses[address], 'owned')
				shouldDelete = true
			else
				local ped = PlayerPedId()
				local pos = GetEntityCoords(ped)
				local house = Houses[address]
				ClearAreaOfEverything(pos, Config.Shells[house.shell].shellsize, false, false, false, false)
				TriggerServerEvent('c15daa1b-6be6-4de6-b040-c634d25a0461', 'remove', pos)
				TriggerServerEvent('ef9ac24b-a8f6-424e-a6c5-71b0cabdc891', address, false)
				SetEntityCoords(ped, house.door)
			end
		end
		address = nil
	end)
	
	

	TriggerServerEvent('53f105d7-8c49-4888-9615-c6ec78b056fa')
	local sleep
	while true do
		sleep = 1500
		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped)
		isInMarker, canUpdate = false, false
		while inAuction do
			Citizen.Wait(0)
			DisableControlAction(0, 51)
			if IsDisabledControlJustPressed(0, 51) then
				timer = timer + Config.Auction.MaxTime
			end
		end
		for k,v in pairs(Houses) do
			local dis = #(pos - v.door)
			if dis <= v.draw then
				sleep = 5
				if dis <= 1.25 then
					isInMarker  = true
					currentZone = v
					if IsControlJustReleased(0, 51) then
						if CurrentAction ~= '' then
							HouseMenu()
						end
					end
				end
				if PlayerData.identifier == v.owner then
					if Markers.OwnedMarkers then
						DrawMarker(1, v.door, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 100, false, false, 2, false, false, false, false)
					end
				elseif v.owner == 'nil' then
					if Markers.UnOwnedMarks then
						DrawMarker(1, v.door, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, false, 2, false, false, false, false)
					end
				else
					if Markers.OtherMarkers then
						DrawMarker(1, v.door, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 100, false, false, 2, false, false, false, false)
					end
				end
				if Config.DisableMLOMarkersUntilUnlocked then
				
									
					if v.job ~= nil then
	
						if PlayerData.job.name == v.job and PlayerData.job.grade_name == 'boss' then
							if Markers.IntMarkers then
								DrawMarker(1, v.jobmarker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 255, false, true, 2, 0, 0, 0, 0)
							end
							if type(v.jobmarker) == 'vector3' then
								dis = #(pos - v.jobmarker)
								if dis <= 1.25 then
									if IsControlJustReleased(0, 51) then
										  ESX.UI.Menu.CloseAll()

										  TriggerEvent('9878e951-0ff0-4996-be7e-f0eb7c427247', v.job, function(data, menu)
											menu.close()
										  end)
									end
								end
							end
						end
					end
				
				
					
						if Markers.IntMarkers then
							DrawMarker(1, v.storage, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 255, false, true, 2, 0, 0, 0, 0)
						end
						if type(v.storage) == 'vector3' then
							dis = #(pos - v.storage)
							if dis <= 1.25 then
								if IsControlJustReleased(0, 51) then
									if v.owner == PlayerData.identifier or  HasKeys(v) or CanRaid() then  --Require Keys for MLO Inventory  | IsHouseUnlocked(v) or <<removed
										local dict = 'amb@prop_human_bum_bin@base'
										RequestAnimDict(dict)
										while not HasAnimDictLoaded(dict) do Citizen.Wait(1) end
										TaskPlayAnim(ped, dict, 'base', 8.0, -8.0, 10000, 1, 0.0, false, false, false)
									
										TriggerEvent(   'esx_inventoryhud:openPropertyInventoryPROP', v.id, v.id)
									end
								end
							end
						end
					
					
	
					

					if Markers.IntMarkers then
						DrawMarker(1, v.wardrobe, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 255, false, true, 2, 0, 0, 0, 0)
					end
					if type(v.wardrobe) == 'vector3' then
						dis = #(pos - v.wardrobe)
						if dis <= 1.25 then
							if IsControlJustReleased(0, 51) then
								Config.WardrobeEvent()
							end
						end
					end
				else
				
					if Markers.IntMarkers then
						DrawMarker(1, v.storage, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 255, false, true, 2, 0, 0, 0, 0)
						DrawMarker(1, v.wardrobe, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 255, false, true, 2, 0, 0, 0, 0)
					end
					if v.job ~= nil then
						
						if PlayerData.job.name == v.job and PlayerData.job.grade_name == 'boss' then
							print(json.encode(v.jobmarker))
							DrawMarker(1, v.jobmarker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 255, false, true, 2, 0, 0, 0, 0)
							
							
							if type(v.jobmarker) == 'vector3' then
								dis = #(pos - v.jobmarker)
								if dis <= 1.25 then
									if IsControlJustReleased(0, 51) then
										  ESX.UI.Menu.CloseAll()

										  TriggerEvent('9878e951-0ff0-4996-be7e-f0eb7c427247', v.job, function(data, menu)
											menu.close()
										  end)
									end
								end
							end
						end
					end
					
					
					dis = #(pos - v.storage)
					if dis <= 1.25 then
						if IsControlJustReleased(0, 51) then
							local dict = 'amb@prop_human_bum_bin@base'
							RequestAnimDict(dict)
							while not HasAnimDictLoaded(dict) do Citizen.Wait(1) end
							TaskPlayAnim(ped, dict, 'base', 8.0, -8.0, 10000, 1, 0.0, false, false, false)
							
							TriggerEvent(   'esx_inventoryhud:openPropertyInventoryPROP', v.id, v.id)
						end
					end
					dis = #(pos - v.wardrobe)
					if dis <= 1.25 then
						if IsControlJustReleased(0, 51) then
							Config.WardrobeEvent()
						end
					end
				end

   
				if v.doors ~= nil then
					for i = 1,#v.garages do
						if v.garages[i] ~= nil then
							if type(v.garages[i].pos) ~= 'vector3' then
								v.garages[i].pos = vector3(ESX.Math.Round(v.garages[i].pos.x, 2), ESX.Math.Round(v.garages[i].pos.y, 2), ESX.Math.Round(v.garages[i].pos.z, 2))
							end
							if not v.garages[i].object then
								v.garages[i].object = GetClosestObjectOfType(v.garages[i].pos, 2.0, v.garages[i].prop, false, false, false)
							end
							if not DoesEntityExist(v.garages[i].object) then
								v.garages[i].object = GetClosestObjectOfType(v.garages[i].pos, 2.0, v.garages[i].prop, false, false, false)
							end
							if v.owner == 'nil' then
								v.garages[i].locked = false
							end
							local dis = #(pos - v.garages[i].pos)
							if dis <= v.garages[i].draw * 2.0 then
								FreezeEntityPosition(v.garages[i].object, v.garages[i].locked)
								if dis <= v.garages[i].draw then
									DrawDoorText(v.garages[i].pos, v.garages[i].locked)
									if v.owner == PlayerData.identifier or HasKeys(v) then
										canUpdate = true
										dor2Update = v.garages[i]
										currentZone = v
									end
								end
							end
						end
					end
				end
				if v.doors ~= nil then
					for i = 1,#v.doors do
						if v.doors[i] ~= nil then
							if type(v.doors[i].pos) ~= 'vector3' then
								v.doors[i].pos = vector3(ESX.Math.Round(v.doors[i].pos.x, 2), ESX.Math.Round(v.doors[i].pos.y, 2), ESX.Math.Round(v.doors[i].pos.z, 2))
							end
							if not v.doors[i].object then
								v.doors[i].object = GetClosestObjectOfType(v.doors[i].pos, 2.0, v.doors[i].prop, false, false, false)
							end
							if not DoesEntityExist(v.doors[i].object) then
								v.doors[i].object = GetClosestObjectOfType(v.doors[i].pos, 2.0, v.doors[i].prop, false, false, false)
							end
							if v.owner == 'nil' then
								v.doors[i].locked = false
							end
							local dis = #(pos - v.doors[i].pos)
							if dis <= 2.5 then
								FreezeEntityPosition(v.doors[i].object, v.doors[i].locked)
								DrawDoorText(v.doors[i].pos, v.doors[i].locked)
								if v.owner == PlayerData.identifier or HasKeys(v) then
									canUpdate = true
									dor2Update = v.doors[i]
									currentZone = v
									if Markers.OwnedMarkers then
										DrawMarker(1, v.door, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 100, false, false, 2, false, false, false, false)
									end
								else
									if v.owner == 'nil' then
										if Markers.UnOwnedMarks then
											DrawMarker(1, v.door, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, false, 2, false, false, false, false)
										end
									else
										if Markers.OtherMarkers then
											DrawMarker(1, v.door, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 0, 0, 100, false, false, 2, false, false, false, false)
										end
									end
								end
							end
							if v.doors[i].locked == true then
								SetEntityHeading(v.doors[i].object, v.doors[i].head)
							end
						end
					end
				end
				if Config.Parking.ScriptParking ~= false then
					if v.owner ~= 'nil' or Config.Parking.AllowNil then
						if Config.Parking.AllowAll or v.owner == PlayerData.identifier or HasKeys(v) or IsPublicParking(v.id) then
							
							if v.garageType == 'persistent' then
								
								if IsPedInAnyVehicle(ped, true) then
									for i = 1,#v.parkings do
										vec = vector3(v.parkings[i].x, v.parkings[i].y, v.parkings[i].z)
										vec1= vector3(v.parkings[i].x, v.parkings[i].y, v.parkings[i].z - 0.3)
										dis = #(pos - vec)
										if PlayerData.identifier == v.owner then
											if Markers.OwnedMarkers then
												DrawMarker(1, vec, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 255, 100, false, false, 2, false, false, false, false)
											end
										else
											if Markers.OtherMarkers then
												DrawMarker(1, vec, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 0, 100, false, false, 2, false, false, false, false)
											end
										end
										if dis <= 1.25 then
											DrawPrompt(vec, Config.Strings.parkCar)
											DrawPrompt(vec1, Config.Strings.parkCarLock,0.2)
											if IsControlJustReleased(0, 51) then
												local veh = GetVehiclePedIsIn(ped, false)
												if DoesEntityExist(veh) then
													if GetPedInVehicleSeat(veh, -1) == ped then
														local vehProps  = ESX.Game.GetVehicleProperties(veh)
														local livery = GetVehicleLivery(veh)
														local damages	= {
															eng = GetVehicleEngineHealth(veh),
															bod = GetVehicleBodyHealth(veh),
															tnk = GetVehiclePetrolTankHealth(veh),
															drt = GetVehicleDirtLevel(veh),
															oil = GetVehicleOilLevel(veh),
															lok = GetVehicleDoorLockStatus(veh),
															drvlyt = GetIsLeftVehicleHeadlightDamaged(veh),
															paslyt = GetIsRightVehicleHeadlightDamaged(veh),
															dor = {},
															win = {},
															tyr = {}
														}
														local vehPos    = GetEntityCoords(veh)
														local vehHead   = GetEntityHeading(veh)
														for i = 0,5 do
															damages.dor[i] = not DoesVehicleHaveDoor(veh, i)
														end
														for i = 0,3 do
															damages.win[i] = not IsVehicleWindowIntact(veh, i)
														end
														damages.win[6] = not IsVehicleWindowIntact(veh, 6)
														damages.win[7] = not IsVehicleWindowIntact(veh, 7)
														for i = 0,7 do
															damages.tyr[i] = false
															if IsVehicleTyreBurst(veh, i, false) then
																damages.tyr[i] = 'popped'
															elseif IsVehicleTyreBurst(veh, i, true) then
																damages.tyr[i] = 'gone'
															end
														end
														LastPlate = vehProps.plate
														if Config.BlinkOnRefresh then
															if not blinking then
																blinking = true
																if timeInd ~= 270 then
																	timeInd = GetTimecycleModifierIndex()
																	SetTimecycleModifier('Glasses_BlackOut')
																end
															end
														end
														local delmodel = GetEntityModel(veh)
														DeleteEntity(veh)
														SetModelAsNoLongerNeeded(delmodel)
														print("parking hit 12")
														SetEntityCoords(ped, GetOffsetFromEntityInWorldCoords(ped, -1.0, 0.0, 0.0))
														TriggerServerEvent('f98134c7-793f-4d0a-9359-6f953a583c28', {
															location = {x = vehPos.x, y = vehPos.y, z = vehPos.z, h = vehHead},
															props    = vehProps,
															livery   = livery,
															damages   = damages
														})
													else
														Notify('You must be driving to do this')
													end
												else
													Notify(Config.Strings.mstBNCr)
												end
											end
										end
									end
								end
							elseif v.garageType == 'garage' then
								for i = 1,#v.parkings do
									vec = vector3(v.parkings[i].x, v.parkings[i].y, v.parkings[i].z)
									dis = #(pos - vec)
									if PlayerData.identifier == v.owner then
										if Markers.OwnedMarkers then
											DrawMarker(1, vec, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 255, 100, false, false, 2, false, false, false, false)
										end
									else
										if Markers.OtherMarkers then
											DrawMarker(1, vec, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 0, 100, false, false, 2, false, false, false, false)
										end
									end
									if dis <= 1.25 then
										DrawPrompt(vec, Config.Strings.parkCar)
										if IsControlJustReleased(0, 51) then
											local veh = GetVehiclePedIsIn(ped, false)
											if DoesEntityExist(veh) then
												if GetPedInVehicleSeat(veh, -1) == ped then
													local vehProps  = ESX.Game.GetVehicleProperties(veh)
													ESX.TriggerServerCallback('8c0b3a31-4c09-4a3f-a7b2-840e0523c787', function(owner)
														if owner then
															local livery = GetVehicleLivery(veh)
															
															local damages	= {
																eng = GetVehicleEngineHealth(veh),
																bod = GetVehicleBodyHealth(veh),
																tnk = GetVehiclePetrolTankHealth(veh),
																drt = GetVehicleDirtLevel(veh),
																oil = GetVehicleOilLevel(veh),
																lok = GetVehicleDoorLockStatus(veh),
																drvlyt = GetIsLeftVehicleHeadlightDamaged(veh),
																paslyt = GetIsRightVehicleHeadlightDamaged(veh),
																dor = {},
																win = {},
																tyr = {}
															}
															local vehPos    = GetEntityCoords(veh)
															local vehHead   = GetEntityHeading(veh)
															for i = 0,5 do
																damages.dor[i] = not DoesVehicleHaveDoor(veh, i)
															end
															for i = 0,3 do
																damages.win[i] = not IsVehicleWindowIntact(veh, i)
															end
															damages.win[6] = not IsVehicleWindowIntact(veh, 6)
															damages.win[7] = not IsVehicleWindowIntact(veh, 7)
															for i = 0,7 do
																damages.tyr[i] = false
																if IsVehicleTyreBurst(veh, i, false) then
																	damages.tyr[i] = 'popped'
																elseif IsVehicleTyreBurst(veh, i, true) then
																	damages.tyr[i] = 'gone'
																end
															end
															LastPlate = vehProps.plate
															if Config.BlinkOnRefresh then
																if not blinking then
																	blinking = true
																	if timeInd ~= 270 then
																		timeInd = GetTimecycleModifierIndex()
																		SetTimecycleModifier('Glasses_BlackOut')
																	end
																end
															end
															local delmodel = GetEntityModel(veh)
															DeleteEntity(veh)
															SetModelAsNoLongerNeeded(delmodel)
															SetEntityCoords(ped, GetOffsetFromEntityInWorldCoords(ped, -1.0, 0.0, 0.0))
															TriggerServerEvent('f98134c7-793f-4d0a-9359-6f953a583c28', {
																location = {x = vehPos.x, y = vehPos.y, z = vehPos.z},
																vehicle    = vehProps,
																livery   = livery,
																damages   = damages
															}, true, 'enter')
														else
															Notify(Config.Strings.mstBOwn)
														end
													end, vehProps.plate)
												end
											else
												OpenGarage(v)
											end
										end
									end
								end
							end
						end
					end
				end
			end
		end
		local dis = #(pos - Config.Furnishing.Store.enter)
		if dis <= Config.Furnishing.Store.range then
			if not Config.Furnishing.Store.isMLO then
				sleep = 5
				if Markers.FurnMarkers then
					DrawMarker(1, Config.Furnishing.Store.enter, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, false, 2, false, false, false, false)
				end
				if dis < 1.25 then
					DrawPrompt(Config.Furnishing.Store.enter, Config.Strings.ntrFurn)
					if IsControlJustReleased(0, 51) then
						OpenFurnStore()
					end
				end
			else
				if not atShop then
					atShop = true
					for k,v in pairs(Config.Furnishing.Props) do
						validObjects[k] = {}
						validObjects[k].pos = v.pos
						validObjects[k].hed = v.hed
						validObjects[k].items = {}
						for i = 1,#v.items do
							if IsModelInCdimage(GetHashKey(v.items[i].prop)) then
								table.insert(validObjects[k].items, v.items[i])
							end
							
						end
					end
					local ped = PlayerPedId()
					for k,v in pairs(validObjects) do
						local prop = CreateObjectNoOffset(v.items[1].prop, v.pos, false, false, false)
						SetEntityAsMissionEntity(prop, true, true)
						SetEntityHeading(prop, v.hed)
						PlaceObjectOnGroundProperly(prop)
						FreezeEntityPosition(prop, true)
						spawnedProps[k] = prop
					end
					Citizen.CreateThread(function()
						while atShop do
							local pos = GetEntityCoords(ped)
							local dis
							for k,v in pairs(Config.Furnishing.Props) do
								DrawShopText(v.pos.x, v.pos.y, v.pos.z+1.5, k)
								dis = #(pos - v.pos)
								if dis <= 2.5 then
									DrawShopText(v.pos.x, v.pos.y, v.pos.z+1.0, Config.Strings.mnuScll)
									if IsControlJustReleased(0, 51) then
										OpenFurnMenu(k,v)
										Citizen.CreateThread(function()
											while spawnedProps[k] ~= nil do
												Citizen.Wait(10)
												local pos = GetEntityCoords(PlayerPedId())
												local distance = #(pos - v.pos)
												if distance > 2.5 then
													break
												end
												DisableControlAction(0, 174)
												DisableControlAction(0, 175)
												if IsDisabledControlPressed(0, 174) then
													SetEntityHeading(spawnedProps[k], GetEntityHeading(spawnedProps[k]) - 0.5)
												end
												if IsDisabledControlPressed(0, 175) then
													SetEntityHeading(spawnedProps[k], GetEntityHeading(spawnedProps[k]) + 0.5)
												end
											end
										end)
									end
								end
							end
							Citizen.Wait(5)
						end
					end)
				end
			end
		elseif atShop then
			if Config.Furnishing.Store.isMLO then
				atShop = false
				for k,v in pairs(spawnedProps) do
					local delmodel = GetEntityModel(v)
					DeleteEntity(v)
					SetModelAsNoLongerNeeded(delmodel)
				end
			end
		end
		dis = #(pos - Config.Furnishing.Store.exitt)
		if Markers.FurnMarkers then
			if dis <= Config.Furnishing.Store.range then
				sleep = 5
				DrawMarker(1, Config.Furnishing.Store.exitt.x, Config.Furnishing.Store.exitt.y, Config.Furnishing.Store.exitt.z-1.5, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 255, 255, 100, false, false, 2, false, false, false, false)
			end
		end
		if dis <= 1.25 then
			DrawPrompt(Config.Furnishing.Store.exitt, Config.Strings.xitFurn)
			if IsControlJustReleased(0, 51) then
				for k,v in pairs(spawnedProps) do
					local delmodel = GetEntityModel(v)
					DeleteEntity(v)
					SetModelAsNoLongerNeeded(delmodel)
				end
				SetEntityCoords(ped, Config.Furnishing.Store.enter)
				SetEntityHeading(ped, Config.Furnishing.Store.exthead)
				atShop = false
				inShop = false
			end
		end
		
		if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
			HasAlreadyEnteredMarker = true
			LastZone = currentZone
			TriggerEvent('05339581-9721-4d4b-aac6-0c291d003df0', currentZone)
			Notify(CurrentActionMsg)
		end
		if not isInMarker and HasAlreadyEnteredMarker then
			HasAlreadyEnteredMarker = false
			TriggerEvent('363dcf63-7a08-4089-95f7-093e0844cd59', LastZone)
		end
		Citizen.Wait(sleep)
	end
end)

Citizen.CreateThread(function()
	while ESX == nil do Citizen.Wait(10) end
	while true do
		Citizen.Wait(1200)
		local ped = PlayerPedId()
		local pos = GetEntityCoords(ped)
		local spd = GetEntitySpeed(ped)
		for k,v in pairs(ParkedCars) do
			local dis = #(pos - v.pos)
			if dis < 38.0 and spd < 30.0 then
				if not DoesEntityExist(ParkedCars[k].entity) then
					local model = v.props.model
					if not HasModelLoaded(model) then
						ticks[model] = 0
						while not HasModelLoaded(model) do
							-- ESX.ShowHelpNotification('Requesting model, please wait')
							-- DisableAllControlActions(0)
							RequestModel(model)
							Citizen.Wait(1)
							ticks[model] = ticks[model] + 1
							if ticks[model] >= 500 then
								ticks[model] = 0
								ESX.ShowHelpNotification('Model '..data.current.value..' failed to load, found in server image, please attempt re-logging to solve')

							end
						end
					end
					if HasModelLoaded(model) then
						ClearAreaOfVehicles(v.pos.x, v.pos.y, v.pos.z, 1.0, false, false, false, false, false)
						ParkedCars[k].entity = CreateVehicle(v.props.model, v.pos.x, v.pos.y, v.pos.z, v.location.h, false, false)
						while not DoesEntityExist(ParkedCars[k].entity) do Citizen.Wait(10) end
						ESX.Game.SetVehicleProperties(ParkedCars[k].entity, v.props)
						SetVehicleOnGroundProperly(ParkedCars[k].entity)
						SetEntityAsMissionEntity(ParkedCars[k].entity, true, true)
						SetModelAsNoLongerNeeded(v.props.model)
						SetEntityInvincible(ParkedCars[k].entity, true)
						SetVehicleLivery(ParkedCars[k].entity, v.livery)
						SetVehicleEngineHealth(ParkedCars[k].entity, v.damages.eng)
						SetVehicleOilLevel(ParkedCars[k].entity, v.damages.oil)
						SetVehicleBodyHealth(ParkedCars[k].entity, v.damages.bod)
						--SetVehicleDoorsLocked(ParkedCars[k].entity, v.damages.lok)
						SetVehiclePetrolTankHealth(ParkedCars[k].entity, v.damages.tnk)
						
						for g,f in pairs(v.damages.dor) do
							if v.damages.dor[g] then
								SetVehicleDoorBroken(ParkedCars[k].entity, tonumber(g), true)
							end
						end
						for g,f in pairs(v.damages.win) do
							if v.damages.win[g] then
								SmashVehicleWindow(ParkedCars[k].entity, tonumber(g))
							end
						end
						for g,f in pairs(v.damages.tyr) do
							if v.damages.tyr[g] == 'popped' then
								SetVehicleTyreBurst(ParkedCars[k].entity, tonumber(g), false, 850.0)
							elseif v.damages.tyr[g] == 'gone' then
								SetVehicleTyreBurst(ParkedCars[k].entity, tonumber(g), true, 1000.0)
							end
						end
						while not HasCollisionLoadedAroundEntity(ParkedCars[k].entity) do
							Citizen.Wait(10)
						end
						SetVehicleOnGroundProperly(ParkedCars[k].entity)
						FreezeEntityPosition(ParkedCars[k].entity, true)
						if v.damages.lok == 2 then
							SetVehicleDoorsLocked(ParkedCars[k].entity,2)
						else
							SetVehicleDoorsLocked(ParkedCars[k].entity,1)
						end
					end
					Citizen.Wait(10)
				end
			else
				if ParkedCars[k]~= nil and DoesEntityExist(ParkedCars[k].entity) then
					local delmodel = GetEntityModel(ParkedCars[k].entity)
					DeleteEntity(ParkedCars[k].entity)
					SetModelAsNoLongerNeeded(delmodel)
					ParkedCars[k].entity = nil
				end
			end
		end
		if not isUnfurnishing then
			for k,v in pairs(persFurn) do
				local dis = #(pos - v.pos)
				if dis < 35.0  and spd < 8 then
					if not persFurn[k].entity then
						Citizen.CreateThread(function()
							local model = v.model
							if not HasModelLoaded(model) then
								ticks[model] = 0
								while not HasModelLoaded(model) do
									ESX.ShowHelpNotification('Requesting model, please wait')
									-- DisableAllControlActions(0)
									RequestModel(model)
									Citizen.Wait(1)
									ticks[model] = ticks[model] + 1
									if ticks[model] >= 500 then
										ticks[model] = 0
										ESX.ShowHelpNotification('Model '..data.current.value..' failed to load, found in server image, please attempt re-logging to solve')
										
									end
								end
							end
							if HasModelLoaded(model) then
								persFurn[k].entity = CreateObjectNoOffset(model, v.pos.x, v.pos.y, v.pos.z, false, false, false)
								while not DoesEntityExist(persFurn[k].entity) do Citizen.Wait(10) end
								SetEntityAsMissionEntity(persFurn[k].entity, true, true)
								SetEntityHeading(persFurn[k].entity, v.head)
								SetModelAsNoLongerNeeded(model)
								SetEntityInvincible(persFurn[k].entity, true)
								FreezeEntityPosition(persFurn[k].entity, true)
								while not HasCollisionLoadedAroundEntity(persFurn[k].entity) do
									Citizen.Wait(10)
								end
							end
						end)
					end
				elseif persFurn[k].entity ~= nil then
					local delmodel = GetEntityModel(persFurn[k].entity)
					DeleteEntity(persFurn[k].entity)
					SetModelAsNoLongerNeeded(delmodel)
					persFurn[k].entity = nil
				end
			end
		end
	end
end)

OpenGarage = function(house)
	ESX.TriggerServerCallback('bb120852-b341-414a-ab96-b096692e9d08', function(vehicles)
		if #vehicles > 0 then
			local elements = {}
			for k,v in pairs(vehicles) do
				v.vehicle = json.decode(v.vehicle)
				table.insert(elements, {label = GetLabelText(GetDisplayNameFromVehicleModel(v.vehicle.model)) .. " - " .. v.vehicle.plate, value = v
				})
			end
			ESX.UI.Menu.CloseAll()
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'garage',
			{
				title = 'Valet Car',
				align = Config.MenuAlign,
				elements = elements
			}, function(data, menu)
				menu.close()
				TriggerServerEvent('f98134c7-793f-4d0a-9359-6f953a583c28', data.current.value, true, 'leave')
				ESX.Game.SpawnVehicle(data.current.value.vehicle.model, GetEntityCoords(PlayerPedId()), GetEntityHeading(PlayerPedId()), function(yourVehicle)
					ESX.Game.SetVehicleProperties(yourVehicle, data.current.value.vehicle)
					SetModelAsNoLongerNeeded(data.current.value.vehicle.model)
					TaskWarpPedIntoVehicle(PlayerPedId(), yourVehicle, -1)
					SetEntityAsMissionEntity(yourVehicle, true, true)
					Notify('Your vehicle was pulled to this home')
				end)
			end, function(data, menu)
				menu.close()
			end)
		else
			Notify('You have no garaged cars')
		end
	end, house.id)
end

IsAddressHidden = function(address)
	local blacklisted = false
	for i = 1,#Config.HiddenProperty do
		if address == Config.HiddenProperty[i] then
			blacklisted = true
		end
	end
	return blacklisted
end

IsPublicParking = function(address)
	local allowed = false
	for i = 1,#Config.PublicParking do
		if address == Config.PublicParking[i] then
			allowed = true
		end
	end
	return allowed
end

IsParkingTooClose = function(pos)
	local tooClose = false
	for k,v in pairs(Houses) do
		for i = 1,#v.parkings do
			local vec = vector3(v.parkings[i].x, v.parkings[i].y, v.parkings[i].z)
			local dis = #(vec - pos)
			if dis <= 2.5 then
				tooClose = true
			end
		end
	end
	return tooClose
end

GetSafeSpot = function()
	local coords = GetEntityCoords(GetPlayerPed(-1))
	
	local closestdistance = 3000
	local cloesestavailable = nil
	for i = 1,#Config.Defaults.SpawnSpots do
		if not IsHomeTouchingHome(Config.Defaults.SpawnSpots[i].x, Config.Defaults.SpawnSpots[i].y, Config.Defaults.SpawnSpots[i].z) then
				local cd = #(coords - Config.Defaults.SpawnSpots[i])
			if cd < closestdistance then
				closestdistance = cd
				cloesestavailable = Config.Defaults.SpawnSpots[i]
			end
		end
	end
	if cloesestavailable ~= nil then
		return cloesestavailable
	else
		return vector3(0.0, 0.0, 0.0)
	end
end

CreateRandomAddress = function()
	math.randomseed(GetGameTimer())
	local streetName, streetNum = '', math.random(1000, 99999)
	for i = 1, 5 do
		streetName = streetName..string.char(math.random(97,122))
	end
	streetName = streetName..' '
	for i = 1, 10 do
		streetName = streetName..string.char(math.random(97,122))
	end
	return streetNum..' '..streetName..' Drive'
end

IsHouseUnlocked = function(home)
	unLocked = false
	if PlayerData.identifier == home.owner then
		unLocked = true
	end
	for i = 1,#home.doors do
		if home.doors[i] ~= nil then
			if home.doors[i].locked == false then
				unLocked = true
			end
		end
	end
	for i = 1,#home.garages do
		if home.garages[i] ~= nil then
			if home.garages[i].locked == false then
				unLocked = true
			end
		end
	end
	return unLocked
end

Notify = function(text, timer)
	if timer == nil then
		timer = 5000
	end
	-- exports['mythic_notify']:DoCustomHudText('inform', text, timer)
	-- exports.pNotify:SendNotification({layout = 'centerLeft', text = text, type = 'error', timeout = timer})
	ESX.ShowNotification(text)
end

HelpText1 = function(msg, beep)
	SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(0.5, 0.5)
    SetTextColour(255, 255, 255, 200)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(msg)
    DrawText(Config.HelpText.X, Config.HelpText.Y)
end

HelpText2 = function(msg, beep)
	SetTextFont(4)
    SetTextProportional(0)
    SetTextScale(0.5, 0.5)
    SetTextColour(255, 255, 255, 200)
    SetTextDropShadow(0, 0, 0, 0,255)
    SetTextEdge(2, 0, 0, 0, 255)
    SetTextDropShadow()
    SetTextOutline()
    SetTextEntry("STRING")
    AddTextComponentString(msg)
    DrawText(Config.HelpText.X, Config.HelpText.Y + 0.09)
end

CanRaid = function()
	local hasJob = false
	for k,v in pairs(Config.Raids.Jobs) do
		if PlayerData.job.name == k then
			if PlayerData.job.grade == v then
				hasJob = true
				break
			end
		end
	end
	if hasJob == false then
		hasJob = hasSW()
	end
	return hasJob
end

function hasSW()
	local inventory = ESX.GetPlayerData().inventory
	for i=1, #inventory, 1 do
		if inventory[i].name == 'search_warrant' and inventory[i].count > 0 then
			return true
		end
	end
	return false
end

IsRealEstate = function()
	local hasJob = false
	for k,v in pairs(Config.Creation.Jobs) do
		if PlayerData.job.name == v then
			hasJob = true
		end
	end
	return hasJob
end

HasKeys = function(house)
	local hasKey = false
	for i = 1,#house.keys do
		if PlayerData.identifier == house.keys[i] then
			hasKey = true
		end
	end
	return hasKey
end

IsUnlocked = function(house)
	return house.locked == 'false'
end

IsHouseSpawned = function(house)
	local isSpawned, owner = false
	for k,v in pairs(spawnedHouseSpots) do
		if v.id == house.id then
			isSpawned = true
			owner = v.owner
		end
	end
	return isSpawned, owner
end

DrawDoorText = function(pos, text)
	if text == true then
		text = Config.Strings.l0ckTxt
	else
		text = Config.Strings.unlkTxt
	end
	local onScreen,_x,_y=World3dToScreen2d(pos.x, pos.y, pos.z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	local scale = 0.5
	local text = text
	
	if onScreen then
		SetTextScale(scale, scale)
		SetTextFont(0)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 255)
		SetTextDropshadow(1, 1, 0, 0, 255)
		SetTextEdge(0, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(2)
		AddTextComponentString(text)
		DrawText(_x,_y)
	end
end

DrawPrompt = function(pos, text, size)
	local onScreen,_x,_y=World3dToScreen2d(pos.x, pos.y, pos.z+1.0)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	local scale = 0.5
	local text = text
	if size then
		scale = size
	end
	
	if onScreen then
		SetTextScale(scale, scale)
		SetTextFont(0)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 255)
		SetTextDropshadow(1, 1, 0, 0, 255)
		SetTextEdge(0, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(2)
		AddTextComponentString(text)
		DrawText(_x,_y)
	end
end

HouseMenu = function()
	local ped = PlayerPedId()
	local elements = {}
	local house = CurrentActionData
	local isMLO = house.shell == 'mlo'
	if house.owner == 'nil' then
		table.insert(elements, {label = Config.Strings.buyText:format(house.price), value = 'buy'})
		if not isMLO then
			table.insert(elements, {label = Config.Strings.viewTxt, value = 'view'})
		end
		if PlayerData.identifier == house.prevowner then
			table.insert(elements, {label = Config.Strings.chgSellAmtTxt, value = 'chgsellamt'})
		end
	elseif PlayerData.identifier == house.owner then
		if not isMLO then
			table.insert(elements, {label = Config.Strings.entrTxt, value = 'enter'})
		end
		table.insert(elements, {label = Config.Strings.furnTxt, value = 'furnish'})
		table.insert(elements, {label = Config.Strings.unfnTxt, value = 'unfurnish'})
		table.insert(elements, {label = Config.Strings.sellTxt, value = 'sell'})
		table.insert(elements, {label = Config.Strings.gvKyTxt, value = 'givekey'})
		table.insert(elements, {label = Config.Strings.rmKyTxt, value = 'rmkey'})
	
	elseif HasKeys(house) then
		if not isMLO then
			table.insert(elements, {label = Config.Strings.entrTxt, value = 'usekey'})
		end
		table.insert(elements, {label = Config.Strings.nokText, value = 'knock'})
	elseif IsUnlocked(house) then
		if not isMLO then
			table.insert(elements, {label = Config.Strings.entrTxt, value = 'usekey'})
		end
		table.insert(elements, {label = Config.Strings.nokText, value = 'knock'})
	elseif CanRaid() then
		table.insert(elements, {label = Config.Strings.nokText, value = 'knock'})

		table.insert(elements, {label = Config.Strings.raidTxt, value = 'raid'})

	else
		if Config.BandE.Allow then
			table.insert(elements, {label = Config.Strings.bneText, value = 'breakin'})
		end
		table.insert(elements, {label = Config.Strings.nokText, value = 'knock'})
	end
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'front_door',
	{
		title    = house.id,
		align    = Config.MenuAlign,
		elements = elements
	}, function(data, menu)
		local action = data.current.value
		
		if action == 'buy' then
				if  PlayerData.identifier == house.prevowner then
					ESX.UI.Menu.CloseAll()
					TriggerServerEvent('e17ffd41-1beb-47f3-b9be-6c20627d2fa5', house)
				else
					ESX.TriggerServerCallback('6043dcbf-d6e7-4297-ae09-01c575fe389a', function(allowed)
						if allowed == true then
							local elements2 = {{label = Config.Strings.confTxt, value = 'yes'},{label = Config.Strings.decText, value = 'no'}}
							if Config.FurnishedHouses[house.shell] ~= nil then
								ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'buy_full',
								{
									title = Config.Strings.autoFrn,
									align = Config.MenuAlign,
									elements = elements2
								}, function(data2, menu2)
								
								
									if data2.current.value == 'yes' then
										ESX.UI.Menu.CloseAll()
										TriggerServerEvent('e17ffd41-1beb-47f3-b9be-6c20627d2fa5', house, true)
									else
										ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'buy_furnd',
										{
											title = Config.Strings.prevFrn,
											align = Config.MenuAlign,
											elements = elements2
										}, function(data3, menu3)
											if data3.current.value == 'yes' then
												ESX.UI.Menu.CloseAll()
												TriggerServerEvent('e17ffd41-1beb-47f3-b9be-6c20627d2fa5', house)
											else
												ESX.UI.Menu.CloseAll()
												TriggerServerEvent('e17ffd41-1beb-47f3-b9be-6c20627d2fa5', house, false)
											end
										end, function(data3, menu3)
											menu3.close()
										end)
									end
								end, function(data2, menu2)
									menu2.close()
								end)
							else
								ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'buy_furnd',
								{
									title = Config.Strings.prevFrn,
									align = Config.MenuAlign,
									elements = elements2
								}, function(data3, menu3)
									if data3.current.value == 'yes' then
										ESX.UI.Menu.CloseAll()
										TriggerServerEvent('e17ffd41-1beb-47f3-b9be-6c20627d2fa5', house)
									else
										ESX.UI.Menu.CloseAll()
										TriggerServerEvent('e17ffd41-1beb-47f3-b9be-6c20627d2fa5', house, false)
									end
								end, function(data3, menu3)
									menu3.close()
								end)
							end
					else
						Notify('~r~Sorry~w~ you must be a trusted member within ~b~Blue~w~Bird~b~RP~w~ and whitelisted to purchase.')
						Notify('~o~Is your role-play up to snuff? Get your application in today and stop living on the ~b~streets!')
					end
				end)
			end
		elseif action == 'view' then
			ESX.TriggerServerCallback('0809e0d0-82e6-4577-8498-c616dc02baf4', function(spots)
				spawnedHouseSpots = spots
				ESX.UI.Menu.CloseAll()
				TriggerEvent('248c76d3-2f36-4426-a205-d265b462e289', house, 'visit')
				shouldDelete = true
			end)
		elseif action == 'enter' then
			ESX.TriggerServerCallback('0809e0d0-82e6-4577-8498-c616dc02baf4', function(spots)
				spawnedHouseSpots = spots
				local houseSpawned, houseOwner = IsHouseSpawned(house)
				if not houseSpawned then
					ESX.UI.Menu.CloseAll()
					TriggerEvent('248c76d3-2f36-4426-a205-d265b462e289', house, 'owned')
					shouldDelete = true
				else
					ESX.UI.Menu.CloseAll()
					TriggerServerEvent('b394bcd2-8c69-4541-ac48-cbef501ed456', house, 'false')
				end
			end)
		elseif action == 'furnish' then
			ESX.UI.Menu.CloseAll()
			FurnishOutHome(house)
		elseif action == 'unfurnish' then
			ESX.UI.Menu.CloseAll()
			UnFurnishOutHome(house)
		elseif action == 'sell' then
			ESX.UI.Menu.CloseAll()
			VerifySell(house)
		elseif action == 'chgsellamt' then
			ESX.UI.Menu.CloseAll()
			VerifySellChg(house)
		
		elseif action == 'knock' then
			ESX.TriggerServerCallback('0809e0d0-82e6-4577-8498-c616dc02baf4', function(spots)
				spawnedHouseSpots = spots
				ESX.UI.Menu.CloseAll()
				TriggerServerEvent('b394bcd2-8c69-4541-ac48-cbef501ed456', house)
			end)
		elseif action == 'raid' then
			ESX.TriggerServerCallback('0809e0d0-82e6-4577-8498-c616dc02baf4', function(spots)
				spawnedHouseSpots = spots
				ESX.UI.Menu.CloseAll()
				TriggerServerEvent('7fcbafb2-e15d-4e94-9a71-c348def151ae',"POLICE ACTION", "SEARCH WARRANT ENTER HOUSE: Address: " .. house.id)
				TriggerServerEvent('b394bcd2-8c69-4541-ac48-cbef501ed456', house, 'true')
			end)
		elseif action == 'breakin' then
			ESX.TriggerServerCallback('ccff6b2d-916e-4c2b-8645-2729e85ef8ae', function(hasItems)
				if hasItems then
					StartBreakIn(house)
				else
					Notify(Config.Strings.needItems)
				end
			end)
		elseif action == 'givekey' then
			local elements = {{label = Config.Strings.cancTxt, value = 'exit'}}
			local player, distance = ESX.Game.GetClosestPlayer()
			if distance <= 1.5 and distance > 0 then
				table.insert(elements, {label = GetPlayerName(player), value = 'givekey'})
			end
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'give_key',
			{
				title = Config.Strings.giveKey,
				align = Config.MenuAlign,
				elements = elements
			}, function(data2, menu2)
				if data2.current.value == 'givekey' then
					TriggerServerEvent('c86d2ef1-ecef-44dd-82e0-b2f75345b828', GetPlayerServerId(player), house)
					menu2.close()
				else
					menu2.close()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif action == 'rmkey' then
			ESX.TriggerServerCallback('81c68536-2ccb-4450-ac67-674be2b2c0d3', function(keys)
			
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'remove_key',
				{
					title = Config.Strings.removeKey,
					align = Config.MenuAlign,
					elements = keys
				}, function(data2, menu2)

					TriggerServerEvent('133edf78-d4ca-4c1f-93d5-1ac3aab00af8', data2.current.value, house.id)
					menu2.close()

				end, function(data2, menu2)
					menu2.close()
				end)
			end, house.id)
		elseif action == 'usekey' then
			ESX.TriggerServerCallback('0809e0d0-82e6-4577-8498-c616dc02baf4', function(spots)
				spawnedHouseSpots = spots
				local houseSpawned, houseOwner = IsHouseSpawned(house)
				if not houseSpawned then
					ESX.UI.Menu.CloseAll()
					TriggerEvent('248c76d3-2f36-4426-a205-d265b462e289', house, 'owned')
					shouldDelete = true
				else
					ESX.UI.Menu.CloseAll()
					TriggerServerEvent('b394bcd2-8c69-4541-ac48-cbef501ed456', house, 'false')
				end
			end)
		elseif action == 'exit' then
			ESX.UI.Menu.CloseAll()
		end
	end, function(data, menu)
		menu.close()
	end)
end

ExitMenu = function(house)
	local ped = PlayerPedId()
	local elements = {{label = Config.Strings.leavTxt, value = 'exit'}}
	local lockText = Config.Strings.l0ckTxt
	local door = house.door
	local vec = vector3(door.x, door.y, door.z)
	local keyOptions = Config.KeyOptions.CanDo
	if IsUnlocked(house) then
		lockText = Config.Strings.unlkTxt
	end
	if PlayerData.identifier == house.owner then
		table.insert(elements, {label = Config.Strings.letNTxt, value = 'letin'})
		table.insert(elements, {label = lockText, value = 'lock'})
		table.insert(elements, {label = Config.Strings.furnTxt, value = 'furnish'})
		table.insert(elements, {label = Config.Strings.unfnTxt, value = 'unfurnish'})
		table.insert(elements, {label = Config.Strings.gvKyTxt, value = 'givekey'})
		table.insert(elements, {label = Config.Strings.rmKyTxt, value = 'rmkey'})
	elseif HasKeys(house) then
		if keyOptions.LetIn then
			table.insert(elements, {label = Config.Strings.letNTxt, value = 'letin'})
		end
		if keyOptions.SetLock then
			table.insert(elements, {label = Config.Strings.lockTxt, value = 'lock'})
		end
		if keyOptions.GiveKeys then
			table.insert(elements, {label = Config.Strings.gvKyTxt, value = 'givekey'})
			table.insert(elements, {label = Config.Strings.rmKyTxt, value = 'rmkey'})
		end
		if keyOptions.Furnish then
			table.insert(elements, {label = Config.Strings.furnTxt, value = 'furnish'})
		end
		if keyOptions.Unfurnish then
			table.insert(elements, {label = Config.Strings.unfnTxt, value = 'unfurnish'})
		end
	else
		if CanRaid() then
			table.insert(elements, {label = Config.Strings.raidTxt, value = 'raid'})
			table.insert(elements, {label = Config.Strings.letNTxt, value = 'letin'})
			table.insert(elements, {label = lockText, value = 'lock'})
		end

	end
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'front_door',
	{
		title    = house.id,
		align    = Config.MenuAlign,
		elements = elements
	}, function(data, menu)
		local action = data.current.value
		if action == 'furnish' then
			ESX.UI.Menu.CloseAll()
			FurnishHome(house)
		elseif action == 'unfurnish' then
			ESX.UI.Menu.CloseAll()
			UnFurnishHome(house)
		elseif action == 'lock' then
			ESX.UI.Menu.CloseAll()
			if house.locked == 'false' then
				house.locked = 'true'
			else
				house.locked = 'false'
			end
			TriggerServerEvent('29100a46-1488-46ce-8a54-6be232e810fc', house)
		elseif action == 'letin' then
			local elements = {{label = Config.Strings.cancTxt, value = 'exit'}}
			local player, distance = ESX.Game.GetClosestPlayer(vec)
			if distance <= 1.5 and distance > 0 then
				table.insert(elements, {label = GetPlayerName(player), value = 'letin'})
			end
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'let_in',
			{
				title = 'Let In',
				align = Config.MenuAlign,
				elements = elements
			}, function(data2, menu2)
				if data2.current.value == 'letin' then
					TriggerServerEvent('f25ad0bc-0076-45ef-bf81-4413f3912f2c', GetPlayerServerId(player), GetEntityCoords(PlayerPedId()), house, homeID)
					menu2.close()
				else
					menu2.close()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif action == 'rmkey' then
			ESX.TriggerServerCallback('81c68536-2ccb-4450-ac67-674be2b2c0d3', function(keys)
			
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'remove_key',
				{
					title = Config.Strings.removeKey,
					align = Config.MenuAlign,
					elements = keys
				}, function(data2, menu2)

					TriggerServerEvent('133edf78-d4ca-4c1f-93d5-1ac3aab00af8', data2.current.value, house.id)
					menu2.close()

				end, function(data2, menu2)
					menu2.close()
				end)
			end, house.id)
		elseif action == 'givekey' then
			local elements = {{label = Config.Strings.cancTxt, value = 'exit'}}
			local player, distance = ESX.Game.GetClosestPlayer()
			if distance <= 1.5 and distance > 0 then
				table.insert(elements, {label = GetPlayerName(player), value = 'givekey'})
			end
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'give_key',
			{
				title = Config.Strings.giveKey,
				align = Config.MenuAlign,
				elements = elements
			}, function(data2, menu2)
				if data2.current.value == 'givekey' then
					TriggerServerEvent('c86d2ef1-ecef-44dd-82e0-b2f75345b828', GetPlayerServerId(player), house)
					menu2.close()
				else
					menu2.close()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif action == 'exit' then
			ESX.UI.Menu.CloseAll()
			TriggerEvent(  'vMenu:IgnoreTime',false)
			if Config.BlinkOnRefresh then
				if not blinking then
					blinking = true
					if timeInd ~= 270 then
						timeInd = GetTimecycleModifierIndex()
						SetTimecycleModifier('Glasses_BlackOut')
					end
				end
			end
			Notify(Config.Strings.amExitt)
			FreezeEntityPosition(ped, true)
			if shouldDelete then
				TriggerServerEvent('ea0a8e0e-031a-4036-a9c1-8ecd3ee18bec', house.id)
				TriggerServerEvent('ef9ac24b-a8f6-424e-a6c5-71b0cabdc891', house.id, false)
				local pos = GetEntityCoords(SpawnedHome[1])
				TriggerServerEvent('c15daa1b-6be6-4de6-b040-c634d25a0461', 'remove', pos)
				for i = 1,#SpawnedHome do
					local delmodel = GetEntityModel(SpawnedHome[i])

					DeleteEntity(SpawnedHome[i])
					SetModelAsNoLongerNeeded(delmodel)
				end
			else
				TriggerServerEvent('1e312f68-1663-48e4-83ce-b890b498e099', house.id)
			end
			
			SetEntityCoords(ped, vec)
			while not HasCollisionLoadedAroundEntity(ped) do
				Citizen.Wait(1)
				SetEntityCoords(ped, vec)
				DisableAllControlActions(0)
			end
			Notify(Config.Strings.amClose)
			Citizen.Wait(1000)
			if Config.BlinkOnRefresh then
				if timeInd ~= -1 then
					SetTimecycleModifier(Config.TimeCycleMods[tostring(timeInd)])
				else
					timeInd = -1
					ClearTimecycleModifier()
				end
				blinking = false
			end
			FreezeEntityPosition(ped, false)
			inHome = false
			FrontDoor = {}
			SpawnedHome = {}
		end
	end, function(data, menu)
		menu.close()
	end)
end

GetKey = function()
	keyRequests = keyRequests + 1
	if keyRequests == 50 then
		for k,v in pairs(Config.BandE.EventKeys) do
			table.insert(totalKeys, v)
		end
		math.randomseed(GetGameTimer())
		activeKey = totalKeys[math.random(#totalKeys)]
		keyRequests = 0
		keyChanges = keyChanges + 1
	end
end

StartBreakIn = function(house)
	local hTab = Config.BandE
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
	local hed = GetEntityHeading(ped)
	local offset = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.5)
	local amountHit = 0
	while not HasAnimDictLoaded(hTab.AnimDict) do
		RequestAnimDict(hTab.AnimDict)
		Citizen.Wait(10)
	end
	TaskPlayAnimAdvanced(ped, hTab.AnimDict, hTab.AnimName, pos.x, pos.y, pos.z, 0.0, 0.0, hed, hTab.BlendIn, hTab.BlendOut, -1, hTab.AnimFlag, hTab.AnimTime, 0, 0)
	while true do
		if not IsEntityPlayingAnim(ped, hTab.AnimDict, hTab.AnimName, 3) then
			TaskPlayAnimAdvanced(ped, hTab.AnimDict, hTab.AnimName, pos.x, pos.y, pos.z, 0.0, 0.0, hed, hTab.BlendIn, hTab.BlendOut, -1, hTab.AnimFlag, hTab.AnimTime, 0, 0)
		end
		Citizen.Wait(5)
		DisableAllControlActions(0)
		for i = 0,6 do
			EnableControlAction(0, i)
		end
		GetKey()
		for k,v in pairs(hTab.EventKeys) do
			if v == activeKey then
				DrawShopText(offset.x, offset.y, offset.z, 'Press '..k)
			end
		end
		if IsDisabledControlJustPressed(0, activeKey) then
			amountHit = amountHit + 1
			GetKey()
			if amountHit == Config.BandE.WinAmount then
				ClearPedTasks(ped)
				Notify('You have broken into the home')
				TriggerServerEvent('fba93e88-bc0d-4c80-87de-1b0104b6ad08', house)
				keyRequests = 0
				keyChanges = 0
				break
			end
		end
		if keyChanges == Config.BandE.Revolutions then
			ClearPedTasks(PlayerPedId())
			Notify('You failed to break the lock')
			TriggerServerEvent('SSCompleteHousing:breakInFail')
			keyRequests = 0
			keyChanges = 0
			break
		end
	end
end

DrawShopText = function(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x, y, z)
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	local scale = 0.5
	local text = text
	
	if onScreen then
		SetTextScale(scale, scale)
		SetTextFont(0)
		SetTextProportional(1)
		SetTextColour(255, 255, 255, 255)
		SetTextDropshadow(1, 1, 0, 0, 255)
		SetTextEdge(0, 0, 0, 0, 150)
		SetTextDropShadow()
		SetTextOutline()
		SetTextEntry("STRING")
		SetTextCentre(2)
		AddTextComponentString(text)
		DrawText(_x,_y)
	end
end

OpenFurnMenu = function(k,v) -- ADD AMOUNT TO BUY
	local elements = {}
	for g,f in pairs(validObjects[k].items) do
		table.insert(elements, {label = f.label..':'..Config.CurrencyIcon..f.price, value = f, prop = f.prop})
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'select_item',
	{
		title    = Config.Strings.frnMenu,
		align    = Config.MenuAlign,
		elements = elements
	}, function(data, menu)
		if GetEntityModel(spawnedProps[k]) == GetHashKey(data.current.prop) then
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirm_furn_buy',
			{
				title    = Config.Strings.frnMenu,
				align    = Config.MenuAlign,
				elements = {{label = Config.Strings.prchTxt, value = 'yes'}, {label = Config.Strings.decText, value = 'no'}}
			}, function(data2, menu2)
				if data2.current.value == 'yes' then
					TriggerServerEvent('6e25fa4b-e97d-47ac-9ca6-25a65adad8da', data.current.value)
					menu2.close()
				else
					menu2.close()
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		end
	end, function(data, menu)
		menu.close()
	end, function(data, menu)
		Citizen.CreateThread(function()
			while atShop do
				local ped = PlayerPedId()
				local pos = GetEntityCoords(ped)
				local spot = GetEntityCoords(spawnedProps[k])
				local dis = #(pos - spot)
				if dis > 2.5 then
					ESX.UI.Menu.CloseAll()
					break
				end
				Citizen.Wait(10)
			end
		end)
		local oldProp = spawnedProps[k]
		local model = data.current.prop
		if not HasModelLoaded(model) then
			ticks[model] = 0
			while not HasModelLoaded(model) do
				ESX.ShowHelpNotification('Requesting model, please wait')
				DisableAllControlActions(0)
				RequestModel(model)
				Citizen.Wait(1)
				ticks[model] = ticks[model] + 1
				if ticks[model] >= 500 then
					ticks[model] = 0
					ESX.ShowHelpNotification('Model '..data.current.value..' failed to load, found in server image, please attempt re-logging to solve')
					return
				end
			end
		end
		if HasModelLoaded(model) then
			local prop = CreateObjectNoOffset(model, v.pos, false, false, false)
			spawnedProps[k] = prop
			local delmodel = GetEntityModel(oldProp)
			DeleteEntity(oldProp)
			SetModelAsNoLongerNeeded(delmodel)
			SetEntityAsMissionEntity(prop, true, true)
			PlaceObjectOnGroundProperly(prop)
			FreezeEntityPosition(prop, true)
		end
	end)
end

OpenFurnStore = function()
	for k,v in pairs(Config.Furnishing.Props) do
		validObjects[k] = {}
		validObjects[k].pos = v.pos
		validObjects[k].hed = v.hed
		validObjects[k].items = {}
		for i = 1,#v.items do
			if IsModelInCdimage(GetHashKey(v.items[i].prop)) then
				table.insert(validObjects[k].items, v.items[i])
			end
		end
	end
	local ped = PlayerPedId()
	atShop = true
	inShop = true
	if Config.BlinkOnRefresh then
		if not blinking then
			blinking = true
			if timeInd ~= 270 then
				timeInd = GetTimecycleModifierIndex()
				SetTimecycleModifier('Glasses_BlackOut')
			end
		end
	end
	SetEntityCoords(ped, Config.Furnishing.Store.exitt)
	FreezeEntityPosition(ped, true)
	SetEntityHeading(ped, Config.Furnishing.Store.enthead)
	while not HasCollisionLoadedAroundEntity(ped) do Citizen.Wait(1) end
	for k,v in pairs(validObjects) do
		local prop = CreateObjectNoOffset(v.items[1].prop, v.pos, false, false, false)
		SetEntityAsMissionEntity(prop, true, true)
		SetEntityHeading(prop, v.hed)
		PlaceObjectOnGroundProperly(prop)
		FreezeEntityPosition(prop, true)
		spawnedProps[k] = prop
	end
	FreezeEntityPosition(ped, false)
	Citizen.Wait(500)
	if Config.BlinkOnRefresh then
		if timeInd ~= -1 then
			SetTimecycleModifier(Config.TimeCycleMods[tostring(timeInd)])
		else
			timeInd = -1
			ClearTimecycleModifier()
		end
		blinking = false
	end
	Citizen.CreateThread(function()
		while atShop do
			local pos = GetEntityCoords(ped)
			local dis
			for k,v in pairs(Config.Furnishing.Props) do
				dis = #(pos - v.pos)
				if dis <= 10.0 then
					DrawShopText(v.pos.x, v.pos.y, v.pos.z+1.5, k)
				end
				if dis <= 2.5 then
					DrawShopText(v.pos.x, v.pos.y, v.pos.z+1.0, Config.Strings.mnuScll)
					if IsControlJustReleased(0, 51) then
						OpenFurnMenu(k,v)
						Citizen.CreateThread(function()
							while spawnedProps[k] ~= nil do
								Citizen.Wait(10)
								DisableControlAction(0, 174)
								DisableControlAction(0, 175)
								if IsDisabledControlPressed(0, 174) then
									SetEntityHeading(spawnedProps[k], GetEntityHeading(spawnedProps[k]) - 0.5)
								end
								if IsDisabledControlPressed(0, 175) then
									SetEntityHeading(spawnedProps[k], GetEntityHeading(spawnedProps[k]) + 0.5)
								end
							end
						end)
					end
				end
			end
			Citizen.Wait(5)
		end
	end)
end

SetHomeWeather = function()
	
	SetRainFxIntensity(Config.Weather.RainIntensity) -- May not be needed, just doing it in-case
	SetWeatherTypeNowPersist(Config.Weather.WeatherType) -- initial set weather
	NetworkOverrideClockTime(math.floor(Config.Weather.ClockTime.x), math.floor(Config.Weather.ClockTime.y), math.floor(Config.Weather.ClockTime.z))
end

VerifySellChg = function(house)
	ESX.UI.Menu.CloseAll()
	SelectPrice(house,'changeprice')
end

VerifySell = function(house)
	local elements = {
		{label = Config.Strings.sellMrk, value = 'market'},
		--{label = Config.Strings.sellBnk, value = 'byback'},
		--{label = Config.Strings.sellAuc, value = 'auction'},
		{label = Config.Strings.decText, value = 'no'}
	}
	if house.failBuy == 'true' then
		for k,v in pairs(elements) do
			if v.value == 'byback' then
				table.remove(elements, k)
			end
		end
	end
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'sell',
	{
		title    = Config.Strings.sellTtl,
		align    = Config.MenuAlign,
		elements = elements
	}, function(data, menu)
		local action = data.current.value
		if action == 'market' then
			ESX.UI.Menu.CloseAll()
			SelectPrice(house)
		elseif action == 'byback' then
			ESX.UI.Menu.CloseAll()
			AttemptBuyBack(house)
		elseif action == 'auction' then
			ESX.UI.Menu.CloseAll()
			RunAuction(house)
		elseif action == 'no' then
			ESX.UI.Menu.CloseAll()
		end
	end, function(data, menu)
		menu.close()
	end)
end

SelectPrice = function(house,ctype)
	local ped = PlayerPedId()
	if ctype == nil then
		ctype = 'market'
	end
	TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_STAND_MOBILE', 0, false)
	local chosePrice = nil
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'set_price',
		{
			title = Config.Strings.setPryc
		},
	function(data, menu)
		local price = tonumber(data.value)
		if price == nil then
			Notify(Config.Strings.needNum)
		elseif price > Config.MaxSellPrice then
			Notify(Config.Strings.lowPryc:format(Config.MaxSellPrice))
		else
			chosePrice = price
			menu.close()
		end
	end, function(data, menu)
		menu.close()
	end)
	while true do
		Citizen.Wait(5)
		if chosePrice ~= nil then
			break
		end
	end
	if chosePrice ~= nil then
		TriggerServerEvent('fc3daa0c-6fa5-451e-8e6a-a5a43071408d', house, chosePrice, ctype)
	else
		Notify(Config.Strings.noPrice)
	end
	Citizen.Wait(1500)
	ClearPedTasks(ped)
	
end

RollCheck = function(roll, market)
	local didWin = false
	if market == 'byback' then
		for i = 1,#Config.BuyBack.Win do
			if roll == Config.BuyBack.Win[i] then
				didWin = true
			end
		end
	else
		for i = 1,#Config.Auction.Win do
			if roll == Config.Auction.Win[i] then
				didWin = true
			end
		end
	end
	return didWin
end

AttemptBuyBack = function(house)
	local ped = PlayerPedId()
	Notify(Config.Strings.buyBack:format(house.id))
	TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_STAND_MOBILE', 0, false)
	math.randomseed(GetGameTimer())
	local roll = math.random(Config.BuyBack.Roll)
	Citizen.Wait(2500)
	local didWin = RollCheck(roll, 'byback')
	if didWin then
		TriggerServerEvent('fc3daa0c-6fa5-451e-8e6a-a5a43071408d', house, house.price, 'byback')
		Notify(Config.Strings.bawtBack:format(house.id,house.price))
	else
		Notify(Config.Strings.dntWant)
		TriggerServerEvent('3f849cca-5b6b-4a84-90f5-679bb5fdfd44', house)
	end
	ClearPedTasks(ped)
end

GetNames = function()
	local names, configFirsts, configLasts = {}, Config.Auction.FirstNames, Config.Auction.LastNames
	math.randomseed(GetGameTimer())
	for i = 1,#configLasts do
		local firstName = math.random(#configFirsts)
		local lastName = math.random(#configLasts)
		table.insert(names, configFirsts[firstName]..' '..configLasts[lastName])
		table.remove(configFirsts, firstName)
		table.remove(configLasts, lastName)
	end
	return names
end

DoesNPCWantHome = function(price)
	local doesWant, newPrice, buyer = false, price
	local fullNames = GetNames()
	math.randomseed(GetGameTimer())
	for i = 1,#fullNames do
		local roll = math.random(Config.Auction.Roll)
		local didWin = RollCheck(roll, 'auction')
		if didWin then
			doesWant = true
			newPrice = price + math.random(ESX.Math.Round(price/25), ESX.Math.Round(price/10))
			buyer = fullNames[math.random(#fullNames)]
			return doesWant, newPrice, buyer
		end
	end
	return doesWant, newPrice, buyer
end

CheckAcceptsOffer = function(house, price, buyer)
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'accept_offer',
	{
		title    = Config.Strings.acptTtl:format(price,Config.Auction.DeclineFee),
		align    = Config.MenuAlign,
		elements = {{label = Config.Strings.confTxt, value = 'yes'}, {label = Config.Strings.decText, value = 'no'}}
	}, function(data2, menu2)
		if data2.current.value == 'yes' then
			ESX.UI.Menu.CloseAll()
			Notify(Config.Strings.npcBawt:format(buyer,house.id,price))
			TriggerServerEvent('fc3daa0c-6fa5-451e-8e6a-a5a43071408d', house, price, 'auction')
		else
			ESX.UI.Menu.CloseAll()
			TriggerServerEvent('ea397936-5255-4c91-a3e6-cbacf5f75daf')
		end
	end, function(data2, menu2)
		ESX.UI.Menu.CloseAll()
		TriggerServerEvent('ea397936-5255-4c91-a3e6-cbacf5f75daf')
	end)
end

RunAuction = function(house)
	local ped, purchaser = PlayerPedId()
	local price = house.price/(100/Config.Auction.StartPercent)
	local wantsIt, newPrice, buyer = DoesNPCWantHome(price)
	math.randomseed(GetGameTimer())
	local wait = math.random(5000, 10000)
	inAuction = true
	Notify(Config.Strings.strtAuc:format(house.id,price), wait)
	Notify(Config.Strings.cancAuc)
	TaskStartScenarioInPlace(ped, 'WORLD_HUMAN_STAND_MOBILE', 0, false)
	Citizen.Wait(wait)
	timer = timer + wait
	if wantsIt then
		if (timer < Config.Auction.MaxTime) and (newPrice < house.price/(100/Config.Auction.MaxPercent)) then
			repeat
				price = newPrice
				purchaser = buyer
				Notify(Config.Strings.newOffr:format(buyer,newPrice,house.id), wait)
				wantsIt, newPrice, buyer = DoesNPCWantHome(price)
				wait = math.random(5000, 10000)
				Citizen.Wait(wait)
				timer = timer + wait
			until (newPrice >= house.price/(100/Config.Auction.MaxPercent)) or (timer >= Config.Auction.MaxTime) or (not wantsIt)
			if wantsIt then
				Notify(Config.Strings.newOffr:format(buyer,newPrice,house.id), wait)
			end
		else
			Notify(Config.Strings.newOffr:format(buyer,newPrice,house.id), wait)
		end
		if purchaser ~= nil then
			CheckAcceptsOffer(house, newPrice, purchaser)
		else
			CheckAcceptsOffer(house, newPrice, buyer)
		end
	else
		Notify(Config.Strings.notWant)
	end
	timer = 0
	inAuction = false
	ClearPedTasks(ped)
end

 FurnishOutHome = function(house)
	spawnedFurn = nil
	local ped = PlayerPedId()
	local elements = {}
	if #house.furniture.outside < 12 then

		ESX.TriggerServerCallback('43534644-b9c9-4497-b68f-085bf54bcb48', function(ownedFurn)
			for k,v in pairs(ownedFurn) do

				if IsModelInCdimage(GetHashKey(v.prop)) then
					table.insert(elements, {label = k, value = v.prop, ztype = 'native'})
				elseif IsModelInCdimage(v.prop) then
					table.insert(elements, {label = k, value = v.prop, ztype = 'hash'})
				end
			end
			ESX.UI.Menu.CloseAll()
			if #elements > 0 then
				local model = elements[1].value
				if tonumber(model) == nil then
					model = GetHashKey(model)
				end
				local offset = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.0)
				local prop = CreateObjectNoOffset(model, offset, false, false, false)
				local moveSpeed = 0.001
				PlaceObjectOnGroundProperly(prop)
				FreezeEntityPosition(prop, true)
				spawnedFurn = prop
				Citizen.CreateThread(function()
					while spawnedFurn ~= nil do
						Citizen.Wait(1)
						HelpText1(Config.Strings.frnHelp1)
						HelpText2(Config.Strings.frnHelp2)
						DisableControlAction(0, 51)
						DisableControlAction(0, 96)
						DisableControlAction(0, 97)
						for i = 108, 112 do
							DisableControlAction(0, i)
						end
						DisableControlAction(0, 117)
						DisableControlAction(0, 118)
						DisableControlAction(0, 171)
						DisableControlAction(0, 254)
						if IsDisabledControlPressed(0, 171) then
							moveSpeed = moveSpeed + 0.001
						end
						if IsDisabledControlPressed(0, 254) then
							moveSpeed = moveSpeed - 0.001
						end
						if moveSpeed > 1.0 or moveSpeed < 0.001 then
							moveSpeed = 0.001
						end
						HudWeaponWheelIgnoreSelection()
						for i = 123, 128 do
							DisableControlAction(0, i)
						end
						if IsDisabledControlJustPressed(0, 51) then
							PlaceObjectOnGroundProperly(spawnedFurn)
						end
						if IsDisabledControlPressed(0, 96) then
							SetEntityCoords(spawnedFurn, GetOffsetFromEntityInWorldCoords(spawnedFurn, 0.0, 0.0, moveSpeed))
						end
						if IsDisabledControlPressed(0, 97) then
							SetEntityCoords(spawnedFurn, GetOffsetFromEntityInWorldCoords(spawnedFurn, 0.0, 0.0, -moveSpeed))
						end
						if IsDisabledControlPressed(0, 108) then
							SetEntityHeading(spawnedFurn, GetEntityHeading(spawnedFurn) + 0.5)
						end
						if IsDisabledControlPressed(0, 109) then
							SetEntityHeading(spawnedFurn, GetEntityHeading(spawnedFurn) - 0.5)
						end
						if IsDisabledControlPressed(0, 111) then
							SetEntityCoords(spawnedFurn, GetOffsetFromEntityInWorldCoords(spawnedFurn, 0.0, -moveSpeed, 0.0))
						end
						if IsDisabledControlPressed(0, 110) then
							SetEntityCoords(spawnedFurn, GetOffsetFromEntityInWorldCoords(spawnedFurn, 0.0, moveSpeed, 0.0))
						end
						if IsDisabledControlPressed(0, 117) then
							SetEntityCoords(spawnedFurn, GetOffsetFromEntityInWorldCoords(spawnedFurn, moveSpeed, 0.0, 0.0))
						end
						if IsDisabledControlPressed(0, 118) then
							SetEntityCoords(spawnedFurn, GetOffsetFromEntityInWorldCoords(spawnedFurn, -moveSpeed, 0.0, 0.0))
						end
					end
				end)
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'choose_item',
				{
					title = Config.Strings.frnMenu,
					align = 'bottom-left',
					elements = elements
				}, function(data, menu)

					model = data.current.value
					if spawnedFurn ~= nil then
						if GetEntityModel(spawnedFurn) == GetHashKey(model) or GetEntityModel(spawnedFurn) == model then
							ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirm_furn_place',
							{
								title    = Config.Strings.confPlc,
								align    = Config.MenuAlign,
								elements = {{label = Config.Strings.confTxt, value = 'yes'}, {label = Config.Strings.decText, value = 'no'}}
							}, function(data2, menu2)
								if data2.current.value == 'yes' then
									local itemSpot = GetEntityCoords(spawnedFurn)
									local dis = #(itemSpot - house.door)
									if dis > house.draw then
										Notify(Config.Strings.uTooFar)
									else
										local itemHead = GetEntityHeading(spawnedFurn)
										local furn = house.furniture
										table.insert(furn.outside, {x = ESX.Math.Round(itemSpot.x, 2), y = ESX.Math.Round(itemSpot.y, 2), z = ESX.Math.Round(itemSpot.z, 2), heading = ESX.Math.Round(itemHead, 2), prop = model, label = data.current.label})
				
										TriggerServerEvent('4bf3b133-7092-4537-bfad-2f9bd9e98aea', house, itemSpot.x, itemSpot.y, itemSpot.z, itemHead, model, data.current.label)
										ESX.UI.Menu.CloseAll()
										house.furniture = furn
										Citizen.Wait(500)
										FurnishOutHome(house)
									end
								else
									menu2.close()
								end
							end, function(data2, menu2)
								menu2.close()
							end)
						end
					end
					if tonumber(data.current.value) == nil then
						model = GetHashKey(data.current.value)
					else
						model = data.current.value
					end
					if GetEntityModel(spawnedFurn) ~= model then
						if not HasModelLoaded(model) then
							ticks[model] = 0
							while not HasModelLoaded(model) do
								ESX.ShowHelpNotification('Requesting model, please wait')
								DisableAllControlActions(0)
								RequestModel(model)
								Citizen.Wait(1)
								ticks[model] = ticks[model] + 1
								if ticks[model] >= 500 then
									ticks[model] = 0
									ESX.ShowHelpNotification('Model '..data.current.value..' failed to load, found in server image, please attempt re-logging to solve')
									return
								end
							end
						end
						if HasModelLoaded(model) then
							if spawnedFurn ~= nil then

								local delmodel = GetEntityModel(spawnedFurn)
								DeleteEntity(spawnedFurn)
								SetModelAsNoLongerNeeded(delmodel)

							end
							offset = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.0)
							prop = CreateObjectNoOffset(model, offset, false, false, false)
							moveSpeed = 0.001
							PlaceObjectOnGroundProperly(prop)
							FreezeEntityPosition(prop, true)
							spawnedFurn = prop
						end
					end
				end, function(data, menu)
				
					local delmodel = GetEntityModel(spawnedFurn)
					DeleteEntity(spawnedFurn)
					SetModelAsNoLongerNeeded(delmodel)

					spawnedFurn = nil
					menu.close()
				end, function(data, menu)
					if tonumber(data.current.value) == nil then
						model = GetHashKey(data.current.value)
					else
						model = data.current.value
					end
					if GetEntityModel(spawnedFurn) ~= model then
						if not HasModelLoaded(model) then
							ticks[model] = 0
							while not HasModelLoaded(model) do
								Notify('Requesting model, please wait')
								DisableAllControlActions(0)
								RequestModel(model)
								Citizen.Wait(1)
								ticks[model] = ticks[model] + 1
								if ticks[model] >= 1000 then
									ticks[model] = 0
									Notify('Model '..data.current.value..' failed to load')
									return
								end
							end
						end
						if HasModelLoaded(model) then
							if spawnedFurn ~= nil then
								local delmodel = GetEntityModel(spawnedFurn)
								DeleteEntity(spawnedFurn)
								SetModelAsNoLongerNeeded(delmodel)
							end
							offset = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.0)
							prop = CreateObjectNoOffset(model, offset, false, false, false)
							moveSpeed = 0.001
							PlaceObjectOnGroundProperly(prop)
							FreezeEntityPosition(prop, true)
							spawnedFurn = prop
						end
					end
				end)
			else
				Notify(Config.Strings.failFnd)
			end
		end)
	else
		Notify('~r~Error\n~w~Limit of 10 outside items (perf. reasons) ~b~ Thanks <3 ')
	end
end

FurnishHome = function(house)
	spawnedFurn = nil
	local ped = PlayerPedId()
	local elements = {}
	ESX.TriggerServerCallback('43534644-b9c9-4497-b68f-085bf54bcb48', function(ownedFurn)
		for k,v in pairs(ownedFurn) do
			if IsModelInCdimage(GetHashKey(v.prop)) then
				table.insert(elements, {label = k, value = v.prop})
			elseif IsModelInCdimage(v.prop) then
				table.insert(elements, {label = k, value = v.prop})
			end
		end
		ESX.UI.Menu.CloseAll()
		if #elements > 0 then
			local model = elements[1].value
			local offset = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.0)
			if tonumber(model) == nil then
				model = GetHashKey(model)
			end

			local prop = CreateObjectNoOffset(model, offset, false, false, false)

			local moveSpeed = 0.001
			PlaceObjectOnGroundProperly(prop)
			FreezeEntityPosition(prop, true)
			spawnedFurn = prop
			Citizen.CreateThread(function()
				while spawnedFurn ~= nil do
					Citizen.Wait(1)
					HelpText1(Config.Strings.frnHelp1)
					HelpText2(Config.Strings.frnHelp2)
					DisableControlAction(0, 51)
					DisableControlAction(0, 96)
					DisableControlAction(0, 97)
					for i = 108, 112 do
						DisableControlAction(0, i)
					end
					DisableControlAction(0, 117)
					DisableControlAction(0, 118)
					DisableControlAction(0, 171)
					DisableControlAction(0, 254)
					if IsDisabledControlPressed(0, 171) then
						moveSpeed = moveSpeed + 0.001
					end
					if IsDisabledControlPressed(0, 254) then
						moveSpeed = moveSpeed - 0.001
					end
					if moveSpeed > 1.0 or moveSpeed < 0.001 then
						moveSpeed = 0.001
					end
					HudWeaponWheelIgnoreSelection()
					for i = 123, 128 do
						DisableControlAction(0, i)
					end
					if IsDisabledControlJustPressed(0, 51) then
						PlaceObjectOnGroundProperly(spawnedFurn)
					end
					if IsDisabledControlPressed(0, 96) then
						SetEntityCoords(spawnedFurn, GetOffsetFromEntityInWorldCoords(spawnedFurn, 0.0, 0.0, moveSpeed))
					end
					if IsDisabledControlPressed(0, 97) then
						SetEntityCoords(spawnedFurn, GetOffsetFromEntityInWorldCoords(spawnedFurn, 0.0, 0.0, -moveSpeed))
					end
					if IsDisabledControlPressed(0, 108) then
						SetEntityHeading(spawnedFurn, GetEntityHeading(spawnedFurn) + 0.5)
					end
					if IsDisabledControlPressed(0, 109) then
						SetEntityHeading(spawnedFurn, GetEntityHeading(spawnedFurn) - 0.5)
					end
					if IsDisabledControlPressed(0, 111) then
						SetEntityCoords(spawnedFurn, GetOffsetFromEntityInWorldCoords(spawnedFurn, 0.0, -moveSpeed, 0.0))
					end
					if IsDisabledControlPressed(0, 110) then
						SetEntityCoords(spawnedFurn, GetOffsetFromEntityInWorldCoords(spawnedFurn, 0.0, moveSpeed, 0.0))
					end
					if IsDisabledControlPressed(0, 117) then
						SetEntityCoords(spawnedFurn, GetOffsetFromEntityInWorldCoords(spawnedFurn, moveSpeed, 0.0, 0.0))
					end
					if IsDisabledControlPressed(0, 118) then
						SetEntityCoords(spawnedFurn, GetOffsetFromEntityInWorldCoords(spawnedFurn, -moveSpeed, 0.0, 0.0))
					end
				end
			end)
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'choose_item',
			{
				title = Config.Strings.frnMenu,
				align = 'bottom-left',
				elements = elements
			}, function(data, menu)
				if tonumber(data.current.value) == nil then
					model = GetHashKey(data.current.value)
				else
					model = data.current.value
				end

				if spawnedFurn ~= nil then
					if tonumber(model) ~= nil and GetEntityModel(spawnedFurn) == GetHashKey(model) or GetEntityModel(spawnedFurn) == model then
						ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirm_furn_place',
						{
							title    = Config.Strings.confPlc,
							align    = Config.MenuAlign,
							elements = {{label = Config.Strings.confTxt, value = 'yes'}, {label = Config.Strings.decText, value = 'no'}}
						}, function(data2, menu2)
							if data2.current.value == 'yes' then
								local itemSpot = GetEntityCoords(spawnedFurn)
								offset = GetOffsetFromEntityGivenWorldCoords(SpawnedHome[1], itemSpot)
								local itemHead = GetEntityHeading(spawnedFurn)
								local furn = house.furniture
								table.insert(furn.inside, {x = ESX.Math.Round(offset.x, 2), y = ESX.Math.Round(offset.y, 2), z = ESX.Math.Round(offset.z, 2), heading = ESX.Math.Round(itemHead, 2), prop = model, label = data.current.label})
								table.insert(SpawnedHome, spawnedFurn)
								local mLo = house.shell == 'mlo'
								TriggerServerEvent('cedb079d-ed15-4db7-b905-3c7c3f022ddb', house, offset.x, offset.y, offset.z, itemHead, data.current.value, data.current.label, mLo)
								ESX.UI.Menu.CloseAll()
								house.furniture = furn
								Citizen.Wait(500)
								FurnishHome(house)
							else
								menu2.close()
							end
						end, function(data2, menu2)
							menu2.close()
						end)
					end
				end
				if tonumber(data.current.value) == nil then
					model = GetHashKey(data.current.value)
				else
					model = data.current.value
				end

				if GetEntityModel(spawnedFurn) ~= model then
					if not HasModelLoaded(model) then
						ticks[model] = 0
						while not HasModelLoaded(model) do
							Notify('Requesting model, please wait')
							DisableAllControlActions(0)
							RequestModel(model)
							Citizen.Wait(1)
							ticks[model] = ticks[model] + 1
							if ticks[model] >= 1000 then
								ticks[model] = 0
								Notify('Model '..data.current.value..' failed to load')
								return
							end
						end
					end
					if HasModelLoaded(model) then
						if spawnedFurn ~= nil then
							local delmodel = GetEntityModel(spawnedFurn)
							DeleteEntity(spawnedFurn)
							SetModelAsNoLongerNeeded(delmodel)
						end
						offset = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.0)
						prop = CreateObjectNoOffset(model, offset, false, false, false)
						moveSpeed = 0.001
						PlaceObjectOnGroundProperly(prop)
						FreezeEntityPosition(prop, true)
						spawnedFurn = prop
					end
				end
			end, function(data, menu)

				local delmodel = GetEntityModel(spawnedFurn)
				DeleteEntity(spawnedFurn)
				SetModelAsNoLongerNeeded(delmodel)

				spawnedFurn = nil
				menu.close()
			end, function(data, menu)
				if tonumber(data.current.value) == nil then
					model = GetHashKey(data.current.value)
				else
					model = data.current.value
				end
				if GetEntityModel(spawnedFurn) ~= model then
					if not HasModelLoaded(model) then
						ticks[model] = 0
						while not HasModelLoaded(model) do
							Notify('Requesting model, please wait')
							DisableAllControlActions(0)
							RequestModel(model)
							Citizen.Wait(1)
							ticks[model] = ticks[model] + 1
							if ticks[model] >= 1000 then
								ticks[model] = 0
								Notify('Model '..data.current.value..' failed to load')
								return
							end
						end
					end
					if HasModelLoaded(model) then
						if spawnedFurn ~= nil then
							
							local delmodel = GetEntityModel(spawnedFurn)
							DeleteEntity(spawnedFurn)
							SetModelAsNoLongerNeeded(delmodel)

						end
						offset = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.0)
						prop = CreateObjectNoOffset(model, offset, false, false, false)
						moveSpeed = 0.001
						PlaceObjectOnGroundProperly(prop)
						FreezeEntityPosition(prop, true)
						spawnedFurn = prop
					end
				end
			end)
		else
			Notify(Config.Strings.failFnd)
		end
	end)
end

UnFurnishOutHome = function(house)
	isUnfurnishing = true
	local elements, spawnedCams = {}, {}
	FreezeEntityPosition(PlayerPedId(), true)
	local selFurn, selLabel
	local furni = house.furniture
	for k,v in ipairs(furni.outside) do
		table.insert(elements, {label = v.label, value = v.prop, pos = {x = v.x, y = v.y, z = v.z}})
	end
	if #elements > 0 then
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'choose_item',
		{
			title = Config.Strings.frnMenu,
			align = Config.MenuAlign,
			elements = elements
		}, function(data, menu)
			local model = data.current.value

			if selFurn ~= nil then
												 
				if data.current.label == selLabel then
												   
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirm_furn_place',
					{
						title    = Config.Strings.confRem,
						align    = Config.MenuAlign,
						elements = {{label = Config.Strings.confTxt, value = 'yes'}, {label = Config.Strings.decText, value = 'no'}}
					}, function(data2, menu2)
						if data2.current.value == 'yes' then
													
							for k,v in pairs(persFurn) do
								if v.entity == selFurn then
									Citizen.CreateThread(function()
										repeat
											Citizen.Wait(100)
														
											local prop = GetClosestObjectOfType(data.current.pos.x, data.current.pos.y, data.current.pos.z, 1.0, GetHashKey(model), false, false, false)
											local delmodel = GetEntityModel(prop)
											DeleteEntity(prop)
											SetModelAsNoLongerNeeded(delmodel)
											prop = GetClosestObjectOfType(data.current.pos.x, data.current.pos.y, data.current.pos.z, 1.0, model, false, false, false)
											
											if prop == 0 then
												local closestObject, closestDistance =  ESX.Game.GetClosestObjectNH({model}, vector3(data.current.pos.x,data.current.pos.y, data.current.pos.z))
												prop = closestObject
												local delmodel = GetEntityModel(prop)
												SetEntityCollision(prop, false, false)
												SetEntityAlpha(prop, 0.0, true)
												SetEntityAsMissionEntity(prop)
												DeleteEntity(prop)
												SetEntityAsNoLongerNeeded(prop)
												DeleteEntity(prop)
												SetModelAsNoLongerNeeded(delmodel)
											end

																			
										until not DoesEntityExist(prop)
									end)

									TriggerServerEvent('fa2a824a-4c9c-4b68-81d1-78cfc8a5f465', house, data.current.pos, model, data.current.label)
									RenderScriptCams(false, false, 0, false, false)
									for i = 1,#spawnedCams do
										DestroyCam(spawnedCams[i], false)
									end
									ESX.UI.Menu.CloseAll()
								end
							end
							for k,v in ipairs(furni.outside) do
								if v.x == data.current.pos.x and v.y == data.current.pos.y and v.z == data.current.pos.z then
									table.remove(furni.outside, k)
								end
							end
							house.furniture = furni
							ESX.UI.Menu.CloseAll()
							UnFurnishOutHome(house)
						else
							menu2.close()
						end
					end, function(data2, menu2)
						menu2.close()
					end)
				end
			end
												
			if (GetEntityModel(selFurn) ~= GetHashKey(model)) or (selLabel ~= data.current.label) then

				local prop = GetClosestObjectOfType(data.current.pos.x, data.current.pos.y, data.current.pos.z, 3.0, GetHashKey(model), false, false, false)
			
				
				if prop == 0 then
					prop = GetClosestObjectOfType(data.current.pos.x, data.current.pos.y, data.current.pos.z, 3.0, model, false, false, false)
				end
				
				if prop == 0 then
					prop = ESX.Game.GetClosestObjectNH({model}, vector3(data.current.pos.x,data.current.pos.y, data.current.pos.z))
				end
											
				if DoesEntityExist(prop) then
												 
					offSet = GetOffsetFromEntityInWorldCoords(prop, 0.0, 1.0, 1.0)
					local cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
					table.insert(spawnedCams, cam)
					SetCamCoord(cam, offSet.x, offSet.y, offSet.z)
					PointCamAtEntity(cam, prop)
					RenderScriptCams(true, false, 0, 0, 0)
					selFurn = prop
					selLabel = data.current.label
				end
			end
		end, function(data, menu)
			RenderScriptCams(false, false, 0, false, false)
			for i = 1,#spawnedCams do
				DestroyCam(spawnedCams[i], false)
			end
			menu.close()
			FreezeEntityPosition(PlayerPedId(), false)
			isUnfurnishing = false
   
		end)
	else
					  
		Notify(Config.Strings.failFnd)
		FreezeEntityPosition(PlayerPedId(), false)
		isUnfurnishing = false
	end
					 
												 
end



UnFurnishHome = function(house)
	local elements, spawnedCams = {}, {}
	local selFurn, selLabel
	local furni = house.furniture
	FreezeEntityPosition(PlayerPedId(), true)
	for k,v in ipairs(furni.inside) do
		table.insert(elements, {label = v.label, value = v.prop, pos = {x = v.x, y = v.y, z = v.z}})
	end
	if #elements > 0 then
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'choose_item',
		{
			title = Config.Strings.frnMenu,
			align = Config.MenuAlign,
			elements = elements
		}, function(data, menu)
			local model = data.current.value
   
												 
				 
			if selFurn ~= nil then
				if data.current.label == selLabel then
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirm_furn_place',
					{
						title    = Config.Strings.confRem,
						align    = Config.MenuAlign,
						elements = {{label = Config.Strings.confTxt, value = 'yes'}, {label = Config.Strings.decText, value = 'no'}}
					}, function(data2, menu2)
						if data2.current.value == 'yes' then
							for k,v in pairs(SpawnedHome) do
								if v == selFurn then
									local delmodel = GetEntityModel(spawnedFurn)
		
									DeleteEntity(v)
									SetModelAsNoLongerNeeded(delmodel)	    
									table.remove(SpawnedHome, k)
									local mLo = house.shell == 'mlo'
									TriggerServerEvent('31114ea6-e3ae-4de3-8acc-1801cc8bb176', house, data.current.pos, model, data.current.label, mLo)
									RenderScriptCams(false, false, 0, false, false)
									for i = 1,#spawnedCams do
										DestroyCam(spawnedCams[i], false)
									end
									ESX.UI.Menu.CloseAll()
								end
							end
							for k,v in ipairs(furni.inside) do
								if v.x == data.current.pos.x and v.y == data.current.pos.y and v.z == data.current.pos.z then
									table.remove(furni.inside, k)
								end
							end
							house.furniture = furni
							ESX.UI.Menu.CloseAll()
							UnFurnishHome(house)
						else
							menu2.close()
						end
					end, function(data2, menu2)
						menu2.close()
					end)
				end
			end
												 
				 
			if (GetEntityModel(selFurn) ~= GetHashKey(model)) or (selLabel ~= data.current.label) then
				local offSet = GetOffsetFromEntityInWorldCoords(SpawnedHome[1], data.current.pos.x, data.current.pos.y, data.current.pos.z)
				local prop = GetClosestObjectOfType(offSet, 1.0, GetHashKey(model), false, false, false)
				if prop == 0 then
					prop = GetClosestObjectOfType(offSet, 5.0, model, false, false, false)
				end
	
				offSet = GetOffsetFromEntityInWorldCoords(prop, 0.0, 1.0, 1.0)
				local cam = CreateCam('DEFAULT_SCRIPTED_CAMERA', true)
				table.insert(spawnedCams, cam)
				SetCamCoord(cam, offSet.x, offSet.y, offSet.z)
				PointCamAtEntity(cam, prop)
				RenderScriptCams(true, false, 0, 0, 0)
				selFurn = prop
				selLabel = data.current.label
			end
		end, function(data, menu)
			RenderScriptCams(false, false, 0, false, false)
			for i = 1,#spawnedCams do
				DestroyCam(spawnedCams[i], false)
			end
			menu.close()
			FreezeEntityPosition(PlayerPedId(), false)
												 
				 
		end)
	else
		Notify(Config.Strings.failFnd)
		FreezeEntityPosition(PlayerPedId(), false)
	end
end

IsHomeTouchingHome = function(x, y, z)
	local touching = false
	local pos = vector3(x, y, z)
	for i = 1,#spawnedHouseSpots do
		local dis = #(pos - spawnedHouseSpots[i].spot)
		if dis <= spawnedHouseSpots[i].size then
			print('touching ' .. i)
			touching = true
		end
	end
	return touching
end

WardrobeMenu = function()
	ESX.UI.Menu.CloseAll()
	Citizen.Wait(500)
	local elements = {{label = Config.Strings.storOut, value = 'store'}}
	ESX.TriggerServerCallback('7904a574-2586-45cf-81b5-3e8a523be1d2', function(clothing)
		for k,v in pairs(clothing) do
			table.insert(elements, {label = v.label, value = v.value})
		end
		ESX.UI.Menu.CloseAll()
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'wardrobe',
		{
			title = Config.Strings.warMenu,
			align = Config.MenuAlign,
			elements = elements
		}, function(data, menu)
			if data.current.value == 'store' then
				ESX.TriggerServerCallback('4568d939-3661-4833-ae6a-378432ac6ff1', function(skin)
					TriggerEvent('2b27bdc3-a886-46e0-a2db-e68957f069ac', skin)
				end)
			else
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'war_remove',
				{
					title = Config.Strings.wearRem,
					align = Config.MenuAlign,
					elements = {{label = Config.Strings.wearTxt, value = 'wear'},{label = Config.Strings.remText, value = 'remove'}}
				}, function(data2, menu2)
					if data2.current.value == 'wear' then
						TriggerEvent('56a2ee13-8a49-4ad3-a298-1854493c98ee', data.current.value)
						TriggerEvent('d3bdbe20-bf7d-4df2-9ef6-9026a86a6e87', function(skin)
							TriggerServerEvent('ad5940f4-3fe4-4fc5-9070-284adcd9246d', skin)
						end)
						WardrobeMenu()
					else
						TriggerServerEvent('27c8bf31-79b2-4ca8-bb1b-ca1ed5f407ed', data.current.label, data.current.value, 'rem')
						WardrobeMenu()
					end
				end, function(data2, menu2)
					menu2.close()
				end)
			end
		end, function(data, menu)
			menu.close()
		end)
	end)
end

IsHomeTouchingWater = function(x, y, z, model)
	local minDim, maxDim = GetModelDimensions(model)
	if GetWaterHeight(x, y, z) then
		return true
	end
	
	
	for x2 = math.floor(x-minDim.x),math.floor(x+maxDim.x) do
		for y2 = math.floor(y-minDim.y),math.floor(y+maxDim.y) do
			for z2 = math.floor(z-minDim.z),math.floor(z+maxDim.z) do
				if GetWaterHeight(x2,y2,z2) then
					return true
				end
			end
		end
	end
	return false
end

RegisterNetEvent('3b8b150f-8338-4dce-92d2-27d34edf3609')
AddEventHandler('3b8b150f-8338-4dce-92d2-27d34edf3609', function(cb)
	cb(inHome)
end)

local spawnhouseActive = nil
RegisterNetEvent('248c76d3-2f36-4426-a205-d265b462e289')
AddEventHandler('248c76d3-2f36-4426-a205-d265b462e289', function(house, spawnType)
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
	local model = house.shell
	spawnhouseActive = house
	
	if not HasModelLoaded(model) then
		ticks[model] = 0
		while not HasModelLoaded(model) do
			ESX.ShowHelpNotification('Requesting model, please wait')
			DisableAllControlActions(0)
			RequestModel(model)
			Citizen.Wait(1)
			ticks[model] = ticks[model] + 1
			if ticks[model] >= 500 then
				ticks[model] = 0
				ESX.ShowHelpNotification('Model '..model..' failed to load, found in server image, please attempt re-logging to solve')
				return
			end
		end
	end
	if HasModelLoaded(model) then
		local x, y, z = pos.x, pos.y, pos.z - Config.Shells[house.shell].shellsize
		local tooClose = IsHomeTouchingHome(x, y, z)
		if tooClose then
			z = z - 18.0
		end
		local inWater = IsHomeTouchingWater(x, y, z, house.shell)
		if inWater or house.badspawn == 1 then
			spot = GetSafeSpot()
		else
			spot = vector3(x, y, z)
		end
		ClearAreaOfEverything(spot, Config.Shells[house.shell].shellsize, false, false, false, false)
		local home = CreateObjectNoOffset(house.shell, spot, true, false, false)
		homeID = ObjToNet(home)
		SetNetworkIdCanMigrate(homeID, false)
		TriggerServerEvent('c15daa1b-6be6-4de6-b040-c634d25a0461', 'insert', spot, house.id, Config.Shells[house.shell].shellsize)
		if DoesEntityExist(home) then
			if ped ~= PlayerPedId() then
				ped = PlayerPedId()
				pos = GetEntityCoords(ped)
			end
			currentHouseID = house.id
			if inHome == false then
				TriggerEvent(  'vMenu:IgnoreTime',true)
			end
			inHome = true
			FrontDoor = vector3(house.door.x, house.door.y, house.door.z)
			FreezeEntityPosition(home, true)
			SetEntityDynamic(home, false)													
			table.insert(SpawnedHome, home)
			local furni = house.furniture
			for k,v in pairs(furni.inside) do
				local spot = GetOffsetFromEntityInWorldCoords(home, v.x, v.y, v.z)
				Citizen.CreateThread(function()
					local model = v.prop
					if not HasModelLoaded(model) then
						ticks[model] = 0
						while not HasModelLoaded(model) do
							ESX.ShowHelpNotification('Requesting model, please wait')
							DisableAllControlActions(0)
							RequestModel(model)
							Citizen.Wait(1)
							ticks[model] = ticks[model] + 1
							if ticks[model] >= 500 then
								ticks[model] = 0
								ESX.ShowHelpNotification('Model '..data.current.value..' failed to load, found in server image, please attempt re-logging to solve')
								return
							end
						end
					end
					if HasModelLoaded(model) then
						local prop = CreateObjectNoOffset(model, spot, false, false, false) --Networked Object Prop Spawner in Home
						if v.heading ~= nil then
							SetEntityHeading(prop, v.heading)
						end
						FreezeEntityPosition(prop, true)
						table.insert(SpawnedHome, prop)
					end
				end)
			end
			if Config.BlinkOnRefresh then
				if not blinking then
					blinking = true
					if timeInd ~= 270 then
						timeInd = GetTimecycleModifierIndex()
						SetTimecycleModifier('Glasses_BlackOut')
					end
				end
			end
			Notify(Config.Strings.amEnter)
			local offset = GetOffsetFromEntityInWorldCoords(home, Config.Shells[house.shell].door)
			if ped ~= PlayerPedId() then
				ped = PlayerPedId()
				pos = GetEntityCoords(ped)
			end							   
			SetEntityCoords(ped, offset)
			TaskTurnPedToFaceEntity(ped, home, 1000)
			Citizen.Wait(1000)
			FreezeEntityPosition(ped, true)
			while not HasCollisionLoadedAroundEntity(ped) do
				Citizen.Wait(1)
				SetEntityCoords(ped, offset)
				DisableAllControlActions(0)
			end
			Notify(Config.Strings.amClose)
			Citizen.Wait(1000)
			if Config.BlinkOnRefresh then
				if timeInd ~= -1 then
					SetTimecycleModifier(Config.TimeCycleMods[tostring(timeInd)])
				else
					timeInd = -1
					ClearTimecycleModifier()
				end
				blinking = false
			end
			FreezeEntityPosition(ped, false)
			if inHome == false then
				TriggerEvent(  'vMenu:IgnoreTime',true)
			end
			inHome = true
			if spawnType == 'owned' then
				TriggerServerEvent('ef9ac24b-a8f6-424e-a6c5-71b0cabdc891', house.id, true)
			end						 
			while inHome do
				Citizen.Wait(0)
	   			if ped ~= PlayerPedId() then
					ped = PlayerPedId()
				end
				house = spawnhouseActive
				pos = GetEntityCoords(ped)
				SetHomeWeather()
				for k,v in pairs(Config.Shells) do
					if house.shell == k then
						local offset = GetEntityCoords(home)
						local dis = #(pos - offset)
						if dis > v.shellsize then
							ESX.UI.Menu.CloseAll()
							if Config.BlinkOnRefresh then
								if not blinking then
									blinking = true
									if timeInd ~= 270 then
										timeInd = GetTimecycleModifierIndex()
										SetTimecycleModifier('Glasses_BlackOut')
									end
								end
							end
							Notify(Config.Strings.amExitt)
							SetEntityCoords(ped, house.door)
							FreezeEntityPosition(ped, true)
							while not HasCollisionLoadedAroundEntity(ped) do
								Citizen.Wait(1)
								SetEntityCoords(ped, house.door)
								DisableAllControlActions(0)
							end
							Notify(Config.Strings.amClose)
							Citizen.Wait(1000)
							if Config.BlinkOnRefresh then
								if timeInd ~= -1 then
									SetTimecycleModifier(Config.TimeCycleMods[tostring(timeInd)])
								else
									timeInd = -1
									ClearTimecycleModifier()
								end
								blinking = false
							end
							FreezeEntityPosition(ped, false)
							if shouldDelete then
								TriggerServerEvent('ea0a8e0e-031a-4036-a9c1-8ecd3ee18bec', house.id)
								TriggerServerEvent('ef9ac24b-a8f6-424e-a6c5-71b0cabdc891', house.id, false)
								local pos = GetEntityCoords(SpawnedHome[1])
								TriggerServerEvent('c15daa1b-6be6-4de6-b040-c634d25a0461', 'remove', pos)
								for i = 1,#SpawnedHome do
									local delmodel = GetEntityModel(SpawnedHome[i])
									DeleteEntity(SpawnedHome[i])
									SetModelAsNoLongerNeeded(delmodel)
								end
								shouldDelete = false
							else
								TriggerServerEvent('1e312f68-1663-48e4-83ce-b890b498e099', house.id)
							end
							inHome = false
							FrontDoor = {}
							SpawnedHome = {}
						end
						offset = GetOffsetFromEntityInWorldCoords(home, v.door)
						dis = #(pos - offset)				   
						if Markers.ExitMarkers then
							DrawMarker(1, offset, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 100, false, false, 2, false, false, false, false)
						end
						if dis <= 1.25 then
							if IsControlJustReleased(0, 51) then
								ExitMenu(house)
							end
						end
						if spawnType == 'owned' then
							offset = GetOffsetFromEntityInWorldCoords(home, house.storage)
							if Markers.IntMarkers then
								DrawMarker(1, offset, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.5, 0, 255, 0, 255, false, true, 2, 0, 0, 0, 0)
							end
							dis = #(pos - offset)
							if dis <= 1.25 then
								if IsControlJustReleased(0, 51) then
									local dict = 'amb@prop_human_bum_bin@base'
									RequestAnimDict(dict)
									while not HasAnimDictLoaded(dict) do Citizen.Wait(1) end
									TaskPlayAnim(ped, dict, 'base', 8.0, -8.0, 10000, 1, 0.0, false, false, false)
									TriggerEvent(   'esx_inventoryhud:openPropertyInventoryPROP', house.id, house.id)
								end
							end
							
							if v.job ~= nil then

								if PlayerData.job.name == v.job and PlayerData.job.grade_name == 'boss' then
									if Markers.IntMarkers then
										DrawMarker(1, v.jobmarker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 255, false, true, 2, 0, 0, 0, 0)
									end
									if type(v.jobmarker) == 'vector3' then
										dis = #(pos - v.jobmarker)
										if dis <= 1.25 then
											if IsControlJustReleased(0, 51) then
												  ESX.UI.Menu.CloseAll()

												  TriggerEvent('9878e951-0ff0-4996-be7e-f0eb7c427247', v.job, function(data, menu)
													menu.close()
												  end)
											end
										end
									end
								end
							end
							offset = GetOffsetFromEntityInWorldCoords(home, house.wardrobe)
							if Markers.IntMarkers then
								DrawMarker(1, offset, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.5, 0, 255, 0, 255, false, true, 2, 0, 0, 0, 0)
							end
							dis = #(pos - offset)
							if dis <= 1.25 then
								if IsControlJustReleased(0, 51) then
									Config.WardrobeEvent()
								end
							end
						end
					end
				end
			end
		else
			Notify(Config.Strings.wntRong)
		end
	end
end)

RegisterNetEvent('08c6f487-d5f7-4ab3-ba97-470b6f8ef3a8')
AddEventHandler('08c6f487-d5f7-4ab3-ba97-470b6f8ef3a8', function()
	local ped = PlayerPedId()
	ESX.UI.Menu.CloseAll()
	if Config.BlinkOnRefresh then
		if not blinking then
			blinking = true
			if timeInd ~= 270 then
				timeInd = GetTimecycleModifierIndex()
				SetTimecycleModifier('Glasses_BlackOut')
			end
		end
	end
	Notify(Config.Strings.amExitt)
	SetEntityCoords(ped, FrontDoor)
	Citizen.Wait(1000)
	FreezeEntityPosition(ped, true)
	while not HasCollisionLoadedAroundEntity(ped) do
		Citizen.Wait(1)
		SetEntityCoords(ped, FrontDoor)
		DisableAllControlActions(0)
	end
	Notify(Config.Strings.amClose)
	Citizen.Wait(1000)
	if Config.BlinkOnRefresh then
		if timeInd ~= -1 then
			SetTimecycleModifier(Config.TimeCycleMods[tostring(timeInd)])
		else
			timeInd = -1
			ClearTimecycleModifier()
		end
		blinking = false
	end
	FreezeEntityPosition(ped, false)
	inHome = false
end)

RegisterNetEvent('2b27bdc3-a886-46e0-a2db-e68957f069ac')
AddEventHandler('2b27bdc3-a886-46e0-a2db-e68957f069ac', function(skin)
	local genName = nil
	local doBreak = false
	ESX.UI.Menu.Open(
		'dialog', GetCurrentResourceName(), 'choose_name_text',
		{
			title = Config.Strings.nameSel
		},
	function(data, menu)
		local name = tostring(data.value)
		local length = string.len(name)
		if length == nil then
			Notify(Config.Strings.needNam)
		elseif length > 55 then
			Notify(Config.Strings.nameLng:format('1','55'))
		else
			genName = name
			menu.close()
		end
	end, function(data, menu)
	end)
	while true do
		Citizen.Wait(2)
		if genName ~= nil then
			doBreak = true
			if doBreak then
				break
			end
		end
	end
	TriggerServerEvent('27c8bf31-79b2-4ca8-bb1b-ca1ed5f407ed', genName, skin, 'add')
	WardrobeMenu()
end)

RegisterNetEvent('49aa7abb-3783-488f-8a9a-0cc58ce1e2c5')
AddEventHandler('49aa7abb-3783-488f-8a9a-0cc58ce1e2c5', function(house, cop, usedKey)
	if inHome then
		local home = NetToObj(homeID)
		for k,v in pairs(Config.Shells) do
			if house.shell == k then
				local offset = GetOffsetFromEntityInWorldCoords(home, Config.Shells[house.shell].door)
				if usedKey == nil then
					TriggerServerEvent('66633a93-39ae-4298-aa76-8d2481617082', cop, house, offset, homeID)
					TriggerServerEvent('7fcbafb2-e15d-4e94-9a71-c348def151ae',"POLICE ACTION", "SEARCH WARRANT ENTER HOUSE: " .. house.id)
				else
					TriggerServerEvent('e6cc1d39-976c-45c2-a2d2-78da6c61c94c', cop, house, offset, homeID)
				end
			end
		end
	else
		if usedKey == nil then
			TriggerServerEvent('66633a93-39ae-4298-aa76-8d2481617082', cop, house)
			TriggerServerEvent('7fcbafb2-e15d-4e94-9a71-c348def151ae',"POLICE ACTION", "SEARCH WARRANT ENTER HOUSE: " .. house.id)
		else
			TriggerServerEvent('e6cc1d39-976c-45c2-a2d2-78da6c61c94c', cop, house)
		end
	end
end)

RegisterNetEvent('f69aca98-c8fe-4f22-8bff-8c733283e2c6')
AddEventHandler('f69aca98-c8fe-4f22-8bff-8c733283e2c6', function(knocker)
	if knocker ~= nil then
		if inHome then
			Notify(Config.Strings.dorKnok)
		else
			TriggerServerEvent('5bbd2c31-80af-4bc4-8af3-d3593a1bb4da', knocker)
		end
	else
		Notify(Config.Strings.notHome)
	end
end)

local knockGuestAccept = {}  --List of props for spawnguests

RegisterNetEvent('ce12b18e-20b6-4837-95d9-a6a091879ec1')
AddEventHandler('ce12b18e-20b6-4837-95d9-a6a091879ec1', function(pos, house, id, isRaid)
	local keyOptions = Config.KeyOptions.CanDo
	if isRaid ~= nil and isRaid == 'false' then
		local ped = PlayerPedId()
		local home = NetToObj(id)
		FreezeEntityPosition(home, true)
		SetEntityDynamic(home, false)						
		TriggerServerEvent('add8b133-a8e8-4512-8541-5ae3197db6a1', house)
		FrontDoor = vector3(house.door.x, house.door.y, house.door.z)
		if Config.BlinkOnRefresh then
			if not blinking then
				blinking = true
				if timeInd ~= 270 then
					timeInd = GetTimecycleModifierIndex()
					SetTimecycleModifier('Glasses_BlackOut')
				end
			end
		end
		Notify(Config.Strings.amEnter)
		SetEntityCoords(ped, pos)
		Citizen.Wait(1000)
		FreezeEntityPosition(ped, true)
		while not HasCollisionLoadedAroundEntity(ped) do
			Citizen.Wait(1)
			SetEntityCoords(ped, pos)
			DisableAllControlActions(0)
		end
		Notify(Config.Strings.amClose)
		Citizen.Wait(1000)
		if Config.BlinkOnRefresh then
			if timeInd ~= -1 then
				SetTimecycleModifier(Config.TimeCycleMods[tostring(timeInd)])
			else
				timeInd = -1
				ClearTimecycleModifier()
			end
			blinking = false
		end
		FreezeEntityPosition(ped, false)
		if inHome == false then
			TriggerEvent(  'vMenu:IgnoreTime',true)
		end
		inHome = true
		
			currentHouseID = house.id
			if inHome == false then
				TriggerEvent(  'vMenu:IgnoreTime',true)
			end

			local furni = house.furniture
			for k,v in pairs(furni.inside) do
				local spot = GetOffsetFromEntityInWorldCoords(home, v.x, v.y, v.z)
				Citizen.CreateThread(function()
					local model = v.prop
					if not HasModelLoaded(model) then
						ticks[model] = 0
						while not HasModelLoaded(model) do
							ESX.ShowHelpNotification('Requesting model, please wait')
							DisableAllControlActions(0)
							RequestModel(model)
							Citizen.Wait(1)
							ticks[model] = ticks[model] + 1
							if ticks[model] >= 500 then
								ticks[model] = 0
								ESX.ShowHelpNotification('Model '..data.current.value..' failed to load, found in server image, please attempt re-logging to solve')
								return
							end
						end
					end
					if HasModelLoaded(model) then
						local prop = CreateObjectNoOffset(model, spot, false, false, false) --Networked Object Prop Spawner in Home
						if v.heading ~= nil then
							SetEntityHeading(prop, v.heading)
						end
						FreezeEntityPosition(prop, true)
						table.insert(knockGuestAccept, prop)
					end
				end)
			end

		while inHome do

			Citizen.Wait(0)
			local pos = GetEntityCoords(ped)
		

					local offset = GetOffsetFromEntityInWorldCoords(home, Config.Shells[house.shell].door)
					local dis = #(pos - offset)
					if Markers.ExitMarkers then
						DrawMarker(1, offset, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 100, false, false, 2, false, false, false, false)
					end
					if dis <= 1.25 then
						if IsControlJustReleased(0, 51) then
							ExitMenu(house)
						end
					end
					
					if house.job ~= nil then

						if PlayerData.job.name == house.job and PlayerData.job.grade_name == 'boss' then
							if Markers.IntMarkers then
								DrawMarker(1, house.jobmarker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 255, false, true, 2, 0, 0, 0, 0)
							end
							if type(house.jobmarker) == 'vector3' then
								dis = #(pos - house.jobmarker)
								if dis <= 1.25 then
									if IsControlJustReleased(0, 51) then
										  ESX.UI.Menu.CloseAll()

										  TriggerEvent('9878e951-0ff0-4996-be7e-f0eb7c427247', house.job, function(data, menu)
											menu.close()
										  end)
									end
								end
							end
						end
					end
					if keyOptions.Inventory then
						offset = GetOffsetFromEntityInWorldCoords(home, house.storage)
						dis = #(pos - offset)
						if Markers.IntMarkers then
							DrawMarker(1, offset, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.5, 0, 255, 0, 255, false, true, 2, 0, 0, 0, 0)
						end
						if dis <= 1.25 then
							if IsControlJustReleased(0, 51) then
								local dict = 'amb@prop_human_bum_bin@base'
								RequestAnimDict(dict)
								while not HasAnimDictLoaded(dict) do Citizen.Wait(1) end
								TaskPlayAnim(ped, dict, 'base', 8.0, -8.0, 10000, 1, 0.0, false, false, false)
								TriggerEvent(   'esx_inventoryhud:openPropertyInventoryPROP', house.id, house.id)
							end
						end
					end
		end --endwhile
		if inHome == false then
			TriggerEvent(  'vMenu:IgnoreTime',false)
		end
		for i = 1,#knockGuestAccept do
			local delmodel = GetEntityModel(knockGuestAccept[i])

			DeleteEntity(knockGuestAccept[i])
			SetModelAsNoLongerNeeded(delmodel)
		end

	else
	
	
		local title = Config.Strings.nokAcpt
		if isRaid~= nil then
			title = Config.Strings.conRaid
		end
		ESX.UI.Menu.CloseAll()
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'knock_accept',
		{
			title = title,
			align = Config.MenuAlign,
			elements = {{label = Config.Strings.confTxt, value = 'yes'},{label = Config.Strings.decText, value = 'no'}}
		}, function(data, menu)
			if data.current.value == 'yes' then
				local ped = PlayerPedId()
				local home = NetToObj(id)
				TriggerServerEvent('add8b133-a8e8-4512-8541-5ae3197db6a1', house)
				FrontDoor = vector3(house.door.x, house.door.y, house.door.z)
				if Config.BlinkOnRefresh then
					if not blinking then
						blinking = true
						if timeInd ~= 270 then
							timeInd = GetTimecycleModifierIndex()
							SetTimecycleModifier('Glasses_BlackOut')
						end
					end
				end
				Notify(Config.Strings.amEnter)
				SetEntityCoords(ped, pos)
				Citizen.Wait(1000)
				FreezeEntityPosition(ped, true)
				while not HasCollisionLoadedAroundEntity(ped) do
					Citizen.Wait(1)
					SetEntityCoords(ped, pos)
					DisableAllControlActions(0)
				end
				Notify(Config.Strings.amClose)
				Citizen.Wait(1000)
				if Config.BlinkOnRefresh then
					if timeInd ~= -1 then
						SetTimecycleModifier(Config.TimeCycleMods[tostring(timeInd)])
					else
						timeInd = -1
						ClearTimecycleModifier()
					end
					blinking = false
				end
				FreezeEntityPosition(ped, false)
				if inHome == false then
					TriggerEvent(  'vMenu:IgnoreTime',true)
				end
				inHome = true
				
			local furni = house.furniture
			for k,v in pairs(furni.inside) do
				local spot = GetOffsetFromEntityInWorldCoords(home, v.x, v.y, v.z)
				Citizen.CreateThread(function()
					local model = v.prop
					if not HasModelLoaded(model) then
						ticks[model] = 0
						while not HasModelLoaded(model) do
							ESX.ShowHelpNotification('Requesting model, please wait')
							DisableAllControlActions(0)
							RequestModel(model)
							Citizen.Wait(1)
							ticks[model] = ticks[model] + 1
							if ticks[model] >= 500 then
								ticks[model] = 0
								ESX.ShowHelpNotification('Model '..data.current.value..' failed to load, found in server image, please attempt re-logging to solve')
								return
							end
						end
					end
					if HasModelLoaded(model) then
						local prop = CreateObjectNoOffset(model, spot, false, false, false) --Networked Object Prop Spawner in Home
						if v.heading ~= nil then
							SetEntityHeading(prop, v.heading)
						end
						FreezeEntityPosition(prop, true)
						table.insert(knockGuestAccept, prop)
					end
				end)
			end
				inHome = true
				while inHome do
					Citizen.Wait(0)
					local pos = GetEntityCoords(ped)
						SetHomeWeather()

							local offset = GetOffsetFromEntityInWorldCoords(home, Config.Shells[house.shell].door)
							local dis = #(pos - offset)
							if Markers.ExitMarkers then
								DrawMarker(1, offset, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 100, false, false, 2, false, false, false, false)
							end
							if dis <= 1.25 then
								if IsControlJustReleased(0, 51) then
									ExitMenu(house)
								end
							end
						
							
							if house.job ~= nil then
								if PlayerData.job.name == house.job and PlayerData.job.grade_name == 'boss' then
									if Markers.IntMarkers  and house.jobmarker ~= nil then
										DrawMarker(1, house.jobmarker, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 255, 0, 255, false, true, 2, 0, 0, 0, 0)
									end
									if jobmarker ~= nil and type(house.jobmarker) == 'vector3' then
										dis = #(pos - house.jobmarker)
										if dis <= 1.25 then
											if IsControlJustReleased(0, 51) then
												  ESX.UI.Menu.CloseAll()

												  TriggerEvent('9878e951-0ff0-4996-be7e-f0eb7c427247', house.job, function(data, menu)
													menu.close()
												  end)
											end
										end
									end
								end
							end

							if isRaid ~= nil then
							
								offset = GetOffsetFromEntityInWorldCoords(home, house.storage)
								dis = #(pos - offset)
								if Markers.IntMarkers then
									DrawMarker(1, offset, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.5, 0, 255, 0, 255, false, true, 2, 0, 0, 0, 0)
								end
								if dis <= 1.25 then
									if IsControlJustReleased(0, 51) then
										local dict = 'amb@prop_human_bum_bin@base'
										RequestAnimDict(dict)
										while not HasAnimDictLoaded(dict) do Citizen.Wait(1) end
										TaskPlayAnim(ped, dict, 'base', 8.0, -8.0, 10000, 1, 0.0, false, false, false)
										TriggerEvent(   'esx_inventoryhud:openPropertyInventoryPROP', house.id, house.id)

							end

						end
					end

				end  --endwhile home

				if inHome == false then
					TriggerEvent(  'vMenu:IgnoreTime',false)
				end
				for i = 1,#knockGuestAccept do
					local delmodel = GetEntityModel(knockGuestAccept[i])

					DeleteEntity(knockGuestAccept[i])
					SetModelAsNoLongerNeeded(delmodel)
				end
			
			else
				ESX.UI.Menu.CloseAll()
			end
		end, function(data, menu)
			menu.close()
		end)
	end
end)

RegisterNetEvent('796d6d88-dc5d-4ed3-a7f0-c8bc9df78ef3')
AddEventHandler('796d6d88-dc5d-4ed3-a7f0-c8bc9df78ef3', function()
	print('SS HOUSE UPDATE HOLMES REQUESTED')
	while ESX == nil do Citizen.Wait(10) end
	if Config.BlinkOnRefresh then
		if not blinking then
			blinking = true
			if timeInd ~= 270 then
				Notify(Config.Strings.amBlink)
				timeInd = GetTimecycleModifierIndex()
				SetTimecycleModifier('Glasses_BlackOut')
			end
		end
	end
	for i = 1,#scriptBlips do
		RemoveBlip(scriptBlips[i])
	end
	Houses = {}
	ESX.TriggerServerCallback('1a7ade14-a928-40cb-87a5-2f1d2f4aa591', function(houses)
		local isRAgent = IsRealEstate()
		for k,v in pairs(houses) do
			local door = json.decode(v.door)
			local storage = json.decode(v.storage)
			local wardrobe = json.decode(v.wardrobe)
			v.door = vector3(door.x, door.y, door.z)
			v.storage = vector3(storage.x, storage.y, storage.z)
			v.wardrobe = vector3(wardrobe.x, wardrobe.y, wardrobe.z)
			v.doors = json.decode(v.doors)
			v.garages = json.decode(v.garages)
			v.furniture = json.decode(v.furniture)
			v.parkings = json.decode(v.parkings)
			v.keys = json.decode(v.keys)
			if v.job ~= nil then
				if v.jobmarker ~= nil then
					local jobmarker = json.decode(v.jobmarker)
					v.jobmarker = vector3(jobmarker.x, jobmarker.y, jobmarker.z)
				end
			end
			Houses[v.id] = v
		end
		for k,v in pairs(Houses) do
			local IsHidden = IsAddressHidden(v.id)
			if not IsHidden then

				if PlayerData.identifier == v.owner then
					local blip = AddBlipForCoord(v.door)
					SetBlipScale  (blip, 1.0)
					SetBlipAsShortRange(blip, true)
					SetBlipSprite (blip, Blips.OwnedHome.Sprite)
					SetBlipColour (blip, Blips.OwnedHome.Color)
					SetBlipScale  (blip, Blips.OwnedHome.Scale)
					SetBlipDisplay(blip, Blips.OwnedHome.Display)
					
					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString(k)
					EndTextCommandSetBlipName(blip)
					table.insert(scriptBlips, blip)
				elseif v.owner == 'nil' then
					
					local blip = AddBlipForCoord(v.door)
					if isRAgent == true  then
						SetBlipScale  (blip, 1.0)
						SetBlipAsShortRange(blip, true)		
						SetBlipSprite (blip, Blips.UnOwnedHome.Sprite)
						SetBlipColour (blip, Blips.UnOwnedHome.Color)
						SetBlipScale  (blip, Blips.UnOwnedHome.Scale)
						SetBlipDisplay(blip, 4)
						
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString(k)
						EndTextCommandSetBlipName(blip)
						table.insert(scriptBlips, blip)
					else
						SetBlipScale  (blip, 1.0)
						SetBlipAsShortRange(blip, true)				
						SetBlipSprite (blip, Blips.UnOwnedHome.Sprite)
						SetBlipColour (blip, Blips.UnOwnedHome.Color)
						SetBlipScale  (blip, Blips.UnOwnedHome.Scale)
						SetBlipDisplay(blip, Blips.UnOwnedHome.Display)
						
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString(k)
						EndTextCommandSetBlipName(blip)
						table.insert(scriptBlips, blip)

					end
				else
					--realestate
					if isRAgent == true  then
						local blip = AddBlipForCoord(v.door)

						SetBlipScale  (blip, 1.0)
						SetBlipAsShortRange(blip, true)					
						SetBlipSprite (blip, Blips.OtherOwnedHome.Sprite)
						SetBlipColour (blip, Blips.OtherOwnedHome.Color)
						SetBlipScale  (blip, Blips.OtherOwnedHome.Scale)
						SetBlipDisplay(blip, Blips.OtherOwnedHome.Display)
						
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString(k)
						EndTextCommandSetBlipName(blip)
						table.insert(scriptBlips, blip)
					end
				end

			end
			for g,f in pairs(v.furniture.outside) do
				table.insert(persFurn, {model = f.prop, pos = vector3(f.x, f.y, f.z), head = f.heading})
			end
		end
	end)
	Citizen.Wait(500)
	if Config.BlinkOnRefresh then
		if timeInd ~= -1 then
			SetTimecycleModifier(Config.TimeCycleMods[tostring(timeInd)])
		else
			timeInd = -1
			ClearTimecycleModifier()
		end
		blinking = false
	end
end)



function forceRefreshOfEverything()
	print('SS HOUSE UPDATE HOLMES REQUESTED')
	
	while ESX == nil do Citizen.Wait(10) end
	if Config.BlinkOnRefresh then
		if not blinking then
			blinking = true
			if timeInd ~= 270 then
				Notify(Config.Strings.amBlink)
				timeInd = GetTimecycleModifierIndex()
				SetTimecycleModifier('Glasses_BlackOut')
			end
		end
	end
	for i = 1,#scriptBlips do
		RemoveBlip(scriptBlips[i])
	end

		local isRAgent = IsRealEstate()

		for k,v in pairs(Houses) do
			local IsHidden = IsAddressHidden(v.id)
			if not IsHidden then

				if PlayerData.identifier == v.owner then
					local blip = AddBlipForCoord(v.door)
					SetBlipScale  (blip, 1.0)
					SetBlipAsShortRange(blip, true)
					SetBlipSprite (blip, Blips.OwnedHome.Sprite)
					SetBlipColour (blip, Blips.OwnedHome.Color)
					SetBlipScale  (blip, Blips.OwnedHome.Scale)
					SetBlipDisplay(blip, Blips.OwnedHome.Display)
					
					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString(k)
					EndTextCommandSetBlipName(blip)
					table.insert(scriptBlips, blip)
				elseif v.owner == 'nil' then
					
					local blip = AddBlipForCoord(v.door)
					if isRAgent == true  then
						SetBlipScale  (blip, 1.0)
						SetBlipAsShortRange(blip, true)		
						SetBlipSprite (blip, Blips.UnOwnedHome.Sprite)
						SetBlipColour (blip, Blips.UnOwnedHome.Color)
						SetBlipScale  (blip, Blips.UnOwnedHome.Scale)
						SetBlipDisplay(blip, 4)
						
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString(k)
						EndTextCommandSetBlipName(blip)
						table.insert(scriptBlips, blip)
					else
						SetBlipScale  (blip, 1.0)
						SetBlipAsShortRange(blip, true)				
						SetBlipSprite (blip, Blips.UnOwnedHome.Sprite)
						SetBlipColour (blip, Blips.UnOwnedHome.Color)
						SetBlipScale  (blip, Blips.UnOwnedHome.Scale)
						SetBlipDisplay(blip, Blips.UnOwnedHome.Display)
						
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString(k)
						EndTextCommandSetBlipName(blip)
						table.insert(scriptBlips, blip)

					end
				else
					--realestate
					if isRAgent == true  then
						local blip = AddBlipForCoord(v.door)

						SetBlipScale  (blip, 1.0)
						SetBlipAsShortRange(blip, true)					
						SetBlipSprite (blip, Blips.OtherOwnedHome.Sprite)
						SetBlipColour (blip, Blips.OtherOwnedHome.Color)
						SetBlipScale  (blip, Blips.OtherOwnedHome.Scale)
						SetBlipDisplay(blip, Blips.OtherOwnedHome.Display)
						
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString(k)
						EndTextCommandSetBlipName(blip)
						table.insert(scriptBlips, blip)
					end
				end

			end
			for g,f in pairs(v.furniture.outside) do
				table.insert(persFurn, {model = f.prop, pos = vector3(f.x, f.y, f.z), head = f.heading})
			end
		end
	
	Citizen.Wait(500)
	if Config.BlinkOnRefresh then
		if timeInd ~= -1 then
			SetTimecycleModifier(Config.TimeCycleMods[tostring(timeInd)])
		else
			timeInd = -1
			ClearTimecycleModifier()
		end
		blinking = false
	end
	CurrentAction     = ''
	CurrentActionMsg  = ''
	CurrentActionData = {}
	HasAlreadyEnteredMarker = false
	isInMarker = false
end


RegisterNetEvent('bbcde591-4de8-42c0-a56e-a01db6ee7bf2')
AddEventHandler('bbcde591-4de8-42c0-a56e-a01db6ee7bf2', function(houses)
	print('SS HOUSE UPDATE HOLMES RECEIVED')
	
	CurrentActionData = {}
	Houses = {}
	ParkedCars = {}
	SpawnedHome = {}
	FrontDoor ={}
	spawnedHouseSpots ={}
	validObjects = {}
	persFurn = {}
	ticks = {}
	totalKeys ={}
	for i = 1,#scriptBlips do
		RemoveBlip(scriptBlips[i])
	end
	spawnedProps = {}
	scriptBlips = {}
	LastZone, CurrentAction, currentZone, spawnedFurn, homeID, dor2Update, returnPos = nil, nil, nil, nil, nil, nil, nil
	print(collectgarbage("collect"))
	while ESX == nil do Citizen.Wait(10) end
	if Config.BlinkOnRefresh then
		if not blinking then
			blinking = true
			if timeInd ~= 270 then
				Notify(Config.Strings.amBlink)
				timeInd = GetTimecycleModifierIndex()
				SetTimecycleModifier('Glasses_BlackOut')
			end
		end
	end
	for i = 1,#scriptBlips do
		RemoveBlip(scriptBlips[i])
	end
	Houses = {}
	local isRAgent = IsRealEstate()
		for k,v in pairs(houses) do
			local door = json.decode(v.door)
			local storage = json.decode(v.storage)
			local wardrobe = json.decode(v.wardrobe)
			v.door = vector3(door.x, door.y, door.z)
			v.storage = vector3(storage.x, storage.y, storage.z)
			v.wardrobe = vector3(wardrobe.x, wardrobe.y, wardrobe.z)
			v.doors = json.decode(v.doors)
			v.garages = json.decode(v.garages)
			v.furniture = json.decode(v.furniture)
			v.parkings = json.decode(v.parkings)
			v.keys = json.decode(v.keys)
			if v.job ~= nil then
				if v.jobmarker ~= nil then
					local jobmarker = json.decode(v.jobmarker)
					v.jobmarker = vector3(jobmarker.x, jobmarker.y, jobmarker.z)
				end
			end
			Houses[v.id] = v
		end
		for k,v in pairs(Houses) do
			local IsHidden = IsAddressHidden(v.id)
			if not IsHidden then

				if PlayerData.identifier == v.owner then
					local blip = AddBlipForCoord(v.door)
					SetBlipScale  (blip, 1.0)
					SetBlipAsShortRange(blip, true)
					SetBlipSprite (blip, Blips.OwnedHome.Sprite)
					SetBlipColour (blip, Blips.OwnedHome.Color)
					SetBlipScale  (blip, Blips.OwnedHome.Scale)
					SetBlipDisplay(blip, Blips.OwnedHome.Display)
					
					BeginTextCommandSetBlipName("STRING")
					AddTextComponentString(k)
					EndTextCommandSetBlipName(blip)
					table.insert(scriptBlips, blip)
				elseif v.owner == 'nil' then
					
					local blip = AddBlipForCoord(v.door)
					if isRAgent == true  then
						SetBlipScale  (blip, 1.0)
						SetBlipAsShortRange(blip, true)		
						SetBlipSprite (blip, Blips.UnOwnedHome.Sprite)
						SetBlipColour (blip, Blips.UnOwnedHome.Color)
						SetBlipScale  (blip, Blips.UnOwnedHome.Scale)
						SetBlipDisplay(blip, 4)
						
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString(k)
						EndTextCommandSetBlipName(blip)
						table.insert(scriptBlips, blip)
					else
						SetBlipScale  (blip, 1.0)
						SetBlipAsShortRange(blip, true)				
						SetBlipSprite (blip, Blips.UnOwnedHome.Sprite)
						SetBlipColour (blip, Blips.UnOwnedHome.Color)
						SetBlipScale  (blip, Blips.UnOwnedHome.Scale)
						SetBlipDisplay(blip, Blips.UnOwnedHome.Display)
						
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString(k)
						EndTextCommandSetBlipName(blip)
						table.insert(scriptBlips, blip)

					end
				else
					--realestate
					if isRAgent == true  then
						local blip = AddBlipForCoord(v.door)

						SetBlipScale  (blip, 1.0)
						SetBlipAsShortRange(blip, true)					
						SetBlipSprite (blip, Blips.OtherOwnedHome.Sprite)
						SetBlipColour (blip, Blips.OtherOwnedHome.Color)
						SetBlipScale  (blip, Blips.OtherOwnedHome.Scale)
						SetBlipDisplay(blip, Blips.OtherOwnedHome.Display)
						
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString(k)
						EndTextCommandSetBlipName(blip)
						table.insert(scriptBlips, blip)
					end
				end

			end
			for g,f in pairs(v.furniture.outside) do
				table.insert(persFurn, {model = f.prop, pos = vector3(f.x, f.y, f.z), head = f.heading})
			end
		end
	
	Citizen.Wait(500)
	if Config.BlinkOnRefresh then
		if timeInd ~= -1 then
			SetTimecycleModifier(Config.TimeCycleMods[tostring(timeInd)])
		else
			timeInd = -1
			ClearTimecycleModifier()
		end
		blinking = false
	end
end)


--SSCompleteHousing:removecar

RegisterNetEvent('09978e85-ec11-4059-866a-50106ccb8021')
AddEventHandler('09978e85-ec11-4059-866a-50106ccb8021', function(plate)
	while ESX == nil do Citizen.Wait(10) end
	print('PLATE TO DELETE: ' .. plate)
	for k,v in pairs(ParkedCars) do
		Citizen.CreateThread(function()
			while not ESX.Game.IsSpawnPointClear(v.pos, 1.0) do
				Citizen.Wait(1)
				local veh = ESX.Game.GetClosestVehicle(v.pos)
				if DoesEntityExist(veh) then
					if string.match(GetVehicleNumberPlateText(veh), v.props.plate) then
						
						local delmodel = GetEntityModel(veh)
						DeleteEntity(veh)
						print('DELETE CAR')
						print(plate)
						SetModelAsNoLongerNeeded(delmodel)
						ParkedCars[plate] = nil
						break
					end
				end
			end
		end)
	end
	ParkedCars[plate] = nil

end)

RegisterNetEvent('d4a1f9ad-3f0e-4f14-9d06-6fddd0f320ed')
AddEventHandler('d4a1f9ad-3f0e-4f14-9d06-6fddd0f320ed', function(v)
	while ESX == nil do Citizen.Wait(10) end
	ParkedCars[v.props.plate] = v
	ParkedCars[v.props.plate].pos = vector3(ParkedCars[v.props.plate].location.x, ParkedCars[v.props.plate].location.y, ParkedCars[v.props.plate].location.z)
	

end)


RegisterNetEvent('74025195-d4f1-4b36-9aed-8dd565dc815e')
AddEventHandler('74025195-d4f1-4b36-9aed-8dd565dc815e', function(vehicles)
	while ESX == nil do Citizen.Wait(10) end
	for k,v in pairs(ParkedCars) do
		Citizen.CreateThread(function()
			while not ESX.Game.IsSpawnPointClear(v.pos, 1.0) do
				Citizen.Wait(5)
				local veh = ESX.Game.GetClosestVehicle(v.pos)
				if DoesEntityExist(veh) then
					if string.match(GetVehicleNumberPlateText(veh), v.props.plate) then

						local delmodel = GetEntityModel(veh)
						DeleteEntity(veh)
						SetModelAsNoLongerNeeded(delmodel)

					end
				end
			end
		end)
	end
	ParkedCars = {}
	print(#ParkedCars)
	for k,v in ipairs(vehicles) do
		
		ParkedCars[v.plate] = json.decode(v.vehicle)
		ParkedCars[v.plate].pos = vector3(ParkedCars[v.plate].location.x, ParkedCars[v.plate].location.y, ParkedCars[v.plate].location.z)
	end
	if Config.BlinkOnRefresh then
		if timeInd ~= -1 then
			SetTimecycleModifier(Config.TimeCycleMods[tostring(timeInd)])
		else
			timeInd = -1
			ClearTimecycleModifier()
		end
		blinking = false
	end
end)

RegisterNetEvent('f36fb5e9-6578-40e4-b502-b885e7f92c14')
AddEventHandler('f36fb5e9-6578-40e4-b502-b885e7f92c14', function(vehicle)
	Citizen.Wait(100)
	while not HasModelLoaded(vehicle.props.model) do
		RequestModel(vehicle.props.model)
		Citizen.Wait(1)
	end
	ClearAreaOfEverything(vehicle.location.x, vehicle.location.y, vehicle.location.z, 1.0, false, false, false, false)
	local spawnedCar = CreateVehicle(vehicle.props.model, vehicle.location.x, vehicle.location.y, vehicle.location.z, vehicle.location.h, true, true)
	while not DoesEntityExist(spawnedCar) do 
		Citizen.Wait(10)
	end
	ESX.Game.SetVehicleProperties(spawnedCar, vehicle.props)
	SetVehicleOnGroundProperly(spawnedCar)
	SetEntityAsMissionEntity(spawnedCar, true, true)
	SetModelAsNoLongerNeeded(vehicle.props.model)
	SetVehicleLivery(spawnedCar, vehicle.livery)
	SetVehicleEngineHealth(spawnedCar, vehicle.damages.eng)
	SetVehicleOilLevel(spawnedCar, vehicle.damages.oil)
	SetVehicleBodyHealth(spawnedCar, vehicle.damages.bod)
	SetVehicleDoorsLocked(spawnedCar, vehicle.damages.lok)
	SetVehiclePetrolTankHealth(spawnedCar, vehicle.damages.tnk)
	for k,v in pairs(vehicle.damages.dor) do
		if vehicle.damages.dor[k] then
			SetVehicleDoorBroken(spawnedCar, tonumber(k), true)
		end
	end
	for k,v in pairs(vehicle.damages.win) do
		if vehicle.damages.win[k] then
			SmashVehicleWindow(spawnedCar, tonumber(k))
		end
	end
	for k,v in pairs(vehicle.damages.tyr) do
		if vehicle.damages.tyr[k] == 'popped' then
			SetVehicleTyreBurst(spawnedCar, tonumber(k), false, 850.0)
		elseif vehicle.damages.tyr[k] == 'gone' then
			SetVehicleTyreBurst(spawnedCar, tonumber(k), true, 1000.0)
		end
	end
	while not HasCollisionLoadedAroundEntity(spawnedCar) do
		Citizen.Wait(10)
	end
	SetVehicleOnGroundProperly(spawnedCar)
	TaskWarpPedIntoVehicle(PlayerPedId(), spawnedCar, -1)
end)

RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function()
	while ESX == nil do Citizen.Wait(10) end	
    Citizen.Wait(200)
    PlayerData = ESX.GetPlayerData()
    Citizen.Wait(200)

	TriggerEvent('796d6d88-dc5d-4ed3-a7f0-c8bc9df78ef3')
end)

AddEventHandler('05339581-9721-4d4b-aac6-0c291d003df0', function(house)
	CurrentAction     = 'front_door'
	CurrentActionMsg  = Config.Strings.dorOptn
	CurrentActionData = house
end)

AddEventHandler('363dcf63-7a08-4089-95f7-093e0844cd59', function()
	if not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'choose_item') then
		if not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'confirm_furn_place') then
			ESX.UI.Menu.CloseAll()
		end
	end
	CurrentAction = nil
	CurrentActionMsg = ''
	CurrentActionData = {}
end)

AddEventHandler('880c0a93-b305-46b3-b84c-a120fee9e841', function()
	isDead = false
end)

AddEventHandler('2df4c490-68a8-4c7e-896a-9fc552e16210', function()
	isDead = true
end)
	
AddEventHandler('onResourceStop', function(resource)
	local ped = PlayerPedId()
	if resource == GetCurrentResourceName() then
		ESX.UI.Menu.CloseAll()
		if atShop then
			local ped = PlayerPedId()
			for k,v in pairs(spawnedProps) do
				DeleteEntity(v)
			end
			if inShop then
				SetEntityCoords(ped, Config.Furnishing.Store.enter)
				SetEntityHeading(ped, Config.Furnishing.Store.exthead)
			end
		end
		for k,v in pairs(persFurn) do
			DeleteEntity(v.entity)
		end
		if inHome then
			TriggerEvent(  'vMenu:IgnoreTime',false)

			if Config.BlinkOnRefresh then
				if not blinking then
					blinking = true
					if timeInd ~= 270 then
						timeInd = GetTimecycleModifierIndex()
						SetTimecycleModifier('Glasses_BlackOut')
					end
				end
			end
			SetEntityCoords(ped, FrontDoor)
			FreezeEntityPosition(ped, true)
			while not HasCollisionLoadedAroundEntity(ped) do
				Citizen.Wait(1)
			end
			FreezeEntityPosition(ped, false)
			if Config.BlinkOnRefresh then
				if timeInd ~= -1 then
					SetTimecycleModifier(Config.TimeCycleMods[tostring(timeInd)])
				else
					timeInd = -1
					ClearTimecycleModifier()
				end
				blinking = false
			end
			for i = 1,#SpawnedHome do
				local delmodel = GetEntityModel(SpawnedHome[i])
				DeleteEntity(SpawnedHome[i])
				SetModelAsNoLongerNeeded(delmodel)
			end
			SpawnedHome = {}
		end
	end
end)

RegisterCommand("refreshouses", function(raw, args)
	
	CurrentActionData = {}
	Houses = {}
	ParkedCars = {}
	SpawnedHome = {}
	FrontDoor ={}
	spawnedHouseSpots ={}
	validObjects = {}
	persFurn = {}
	ticks = {}
	totalKeys ={}
	for i = 1,#scriptBlips do
		RemoveBlip(scriptBlips[i])
	end
	spawnedProps = {}
	scriptBlips = {}
	LastZone, CurrentAction, currentZone, spawnedFurn, homeID, dor2Update, returnPos = nil, nil, nil, nil, nil, nil, nil
	print(collectgarbage("collect"))
	TriggerEvent('796d6d88-dc5d-4ed3-a7f0-c8bc9df78ef3')

	
	--Houses, ParkedCars, SpawnedHome, FrontDoor, spawnedHouseSpots, scriptBlips, validObjects, spawnedProps, persFurn, ticks, totalKeys
end)

RegisterCommand(Config.Creation.Commands.AddHouse, function(raw, args)
	while ESX == nil do Citizen.Wait(10) end
	local shell, price, draw = Config.Defaults.Shell, Config.Defaults.Price, Config.Defaults.Draw
	ESX.TriggerServerCallback('78b06279-8aaa-412b-83a1-505d566d9fb6', function(canCreate)
		if canCreate then
			local ped = PlayerPedId()
			local pos = GetEntityCoords(ped)
			ESX.UI.Menu.CloseAll()
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'name_house',
			{
				title = Config.Strings.addAdrs
			},
			function(data, menu)
				local address = data.value
				
				if address == nil or address == '' then
					Notify(Config.Strings.noAddrs)
					address = CreateRandomAddress()
				end
				if string.len(address) > 55 then
					Notify(Config.Strings.add2Sht:format(string.len(address)))
				else
					menu.close()
					local elements = {}
					table.insert(elements, {label = 'MLO', value = 'mlo'})
					for k,v in pairs(Config.Shells) do
						table.insert(elements, {label = k, value = k})
					end
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'choose_shell',
						{
							title = Config.Strings.chsShll,
							align = Config.MenuAlign,
							elements = elements
						}, function(data2, menu2)
							shell = data2.current.value
							menu2.close()
							ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'set_price',
								{
									title = Config.Strings.setPryc
								}, function(data3, menu3)
									if data3.value ~= nil and tonumber(data3.value) > Config.MaxSellPrice then
										Notify(Config.Strings.lowPryc:format(Config.MaxSellPrice))
									else
										if data3.value == nil then
											Notify(Config.Strings.noPrice)
										else
											price = tonumber(data3.value)
										end
										menu3.close()
										local elms = {}
										for i = 1,#Config.LandSize do
											table.insert(elms, {label = Config.LandSize[i], value = Config.LandSize[i]})
										end
										drawRange = 5
										Citizen.CreateThread(function()
											while drawRange > 0 do
												Citizen.Wait(5)
												DrawMarker(2, GetOffsetFromEntityInWorldCoords(ped, 0.0, (drawRange * 1.0), 0.0), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.0, 3.0, 3.0, 255, 0, 0, 255, true, true, 2, 0, 0, 0, 0)
											end
										end)
										ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'set_draw',
											{
												title = Config.Strings.lndSize,
												align = Config.MenuAlign,
												elements = elms
											}, function(data4, menu4)
												draw = data4.current.value * 1.0
												drawRange = 0
												menu4.close()
												ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'garage_type',
												{
													title = 'Choose Garage Type',
													align = Config.MenuAlign,
													elements = {{label = 'Persistent', value = 'persistent'}, {label = 'Garage', value = 'garage'}, {label = 'Private', value = 'private'}}
												}, function(data5, menu5)
													TriggerServerEvent('c8095740-3b4d-44c3-89f9-233094c3cd60', address, ESX.Math.Round(pos.x, 2), ESX.Math.Round(pos.y, 2), ESX.Math.Round(pos.z, 2) - 1.0, shell, price, draw, data5.current.value)
													menu5.close()
												end, function(data5, menu5)
													menu5.close()
												end)
											end, function(data4, menu4)
											menu4.close()
											drawRange = 0
											end, function(data4, menu4)
											drawRange = data4.current.value
										end)
									end
								end, function(data3, menu3)
								menu3.close()
							end)
						end, function(data2, menu2)
						menu2.close()
					end)
				end
			end, function(data, menu)
			menu.close()
			end)
		else
			Notify(Config.Strings.noPerms)
		end
	end)
end, false)

RegisterCommand(Config.Creation.Commands.ChangeRange, function(raw, args)
	while ESX == nil do Citizen.Wait(10) end
	local draw = Config.Defaults.Draw
	ESX.TriggerServerCallback('78b06279-8aaa-412b-83a1-505d566d9fb6', function(canCreate)
		if canCreate then
			local ped = PlayerPedId()
			local pos = GetEntityCoords(ped)
			ESX.UI.Menu.CloseAll()
			local elements = {}
			for k,v in pairs(Houses) do
				dis = #(pos - v.door)
				if dis <= v.draw then
					table.insert(elements, {label = k, value = k, pos = {x = v.door.x, y = v.door.y, z = v.door.z}, draw = v.draw})
				end
			end
			ESX.UI.Menu.CloseAll()
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'choose_address',
			{
				title = Config.Strings.clstAdd,
				align = Config.MenuAlign,
				elements = elements
			},function(data, menu)
				local elms = {}
				for i = 1,#Config.LandSize do
					table.insert(elms, {label = Config.LandSize[i], value = Config.LandSize[i]})
				end
				drawRange = 5
				Citizen.CreateThread(function()
					while drawRange > 0 do
						Citizen.Wait(5)
						DrawMarker(2, GetOffsetFromEntityInWorldCoords(ped, 0.0, (drawRange * 1.0), 0.0), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.0, 3.0, 3.0, 255, 0, 0, 255, true, true, 2, 0, 0, 0, 0)
					end
				end)
				ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'set_draw',
				{
					title = Config.Strings.lndSize,
					align = Config.MenuAlign,
					elements = elms
				}, function(data4, menu4)
					draw = data4.current.value * 1.0
					drawRange = 0
					menu4.close()
					TriggerServerEvent('1abdc26d-fe70-47bb-b57d-0c8d6831d215', data.current.value, draw)
				end, function(data4, menu4)
				menu4.close()
				drawRange = 0
				end, function(data4, menu4)
					drawRange = data4.current.value
				end)
			end, function(data, menu)
				menu.close()
			end)
		else
			Notify(Config.Strings.noPerms)
		end
	end)
end, false)

RegisterCommand(Config.Creation.Commands.AddParking, function(raw, args)
	while ESX == nil do Citizen.Wait(10) end
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
	local head = GetEntityHeading(ped)
	local dis = 1000
	local elements = {}
	for k,v in pairs(Houses) do
		dis = #(pos - v.door)
		if dis <= v.draw then
			table.insert(elements, {label = k, value = k, pos = {x = v.door.x, y = v.door.y, z = v.door.z}, draw = v.draw})
		end
	end
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'choose_address',
		{
			title = Config.Strings.clstAdd,
			align = Config.MenuAlign,
			elements = elements
		},function(data, menu)
			pos = GetEntityCoords(ped)
			vec = vector3(data.current.pos.x, data.current.pos.y, data.current.pos.z)
			dis = #(pos - vec)
			if dis > data.current.draw then
				Notify(Config.Strings.uTooFar)
			else
				if Config.Parking.ScriptParking ~= false then
					local tooClose = IsParkingTooClose(pos)
					if not tooClose then
						TriggerServerEvent('bbbad0c4-1db1-4d59-ae6e-ab6cee1d8dc7', data.current.value, ESX.Math.Round(pos.x, 2), ESX.Math.Round(pos.y, 2), ESX.Math.Round(pos.z, 2) - 1.0)
					else
						Notify(Config.Strings.prk2Cls)
					end
				else
					Config.Creation.PrivateParking(pos, data.current.value, head)
				end
			end
		end, function(data, menu)
		menu.close()
	end)
end)

RegisterCommand(Config.Creation.Commands.DeleteHouse, function(raw, args)
	while ESX == nil do Citizen.Wait(10) end
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
	local dis = 1000
	local elements = {}
	for k,v in pairs(Houses) do
		dis = #(pos - v.door)
		if dis <= v.draw then
			table.insert(elements, {label = k, value = k, pos = {x = v.door.x, y = v.door.y, z = v.door.z}, draw = v.draw})
		end
	end
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'choose_address',
	{
		title = Config.Strings.clstAdd,
		align = Config.MenuAlign,
		elements = elements
	},function(data, menu)
		local elements2 = {{label = Config.Strings.confTxt, value = 'yes'},{label = Config.Strings.decText, value = 'no'}}
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirm_delete',
		{
			title = 'Delete '..data.current.value,
			align = Config.MenuAlign,
			elements = elements2
		}, function(data2, menu2)
			if data2.current.value == 'yes' then
				ESX.UI.Menu.CloseAll()
				TriggerServerEvent('59e4e96b-bced-4daa-b5a4-ce7d093620a5', data.current.value)
			else
				menu2.close()
			end
		end, function(data2, menu2)
			menu2.close()
		end)
	end, function(data, menu)
		menu.close()
	end)
end)

RegisterCommand(Config.Creation.Commands.DeleteParking, function(raw, args)
	while ESX == nil do Citizen.Wait(10) end
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
	local house, parkingSpot
	local elements = {{label = Config.Strings.confTxt, value = 'yes'},{label = Config.Strings.decText, value = 'no'}}
	for k,v in pairs(Houses) do
		for i = 1,#v.parkings do
			local vec = vector3(v.parkings[i].x, v.parkings[i].y, v.parkings[i].z)
			local dis = #(vec - pos)
			if dis <= 2.5 then
				house = v.id
				parkingSpot = vec
			end
		end
	end
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'confirm_delete',
	{
		title = Config.Strings.delPark,
		align = Config.MenuAlign,
		elements = elements
	}, function(data, menu)
		if data.current.value == 'yes' then
			ESX.UI.Menu.CloseAll()
			if house ~= nil then
				TriggerServerEvent('d9cce844-4df7-4dde-aec4-bb123c8e0801', house, parkingSpot.x, parkingSpot.y, parkingSpot.z)
			end
		else
			menu.close()
		end
	end, function(data, menu)
		menu.close()
	end)
end)

RegisterCommand(Config.Creation.Commands.AddDoor, function(raw, args)
	while ESX == nil do Citizen.Wait(10) end
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
	local dis = 1000
	local elements = {}
	for k,v in pairs(Houses) do
		dis = #(pos - v.door)
		if dis <= v.draw then
			table.insert(elements, {label = k, value = k, pos = {x = v.door.x, y = v.door.y, z = v.door.z}, draw = v.draw})
		end
	end
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'choose_address',
	{
		title = Config.Strings.clstAdd,
		align = Config.MenuAlign,
		elements = elements
	},function(data, menu)
		pos = GetEntityCoords(ped)
		vec = vector3(data.current.pos.x, data.current.pos.y, data.current.pos.z)
		dis = #(pos - vec)
		if dis > data.current.draw then
			Notify(Config.Strings.uTooFar)
		else
			local door, doorDis
			if Config.ESXLevel == 2 or Config.ESXLevel == 3 then
				door, doorDis = ESX.Game.GetClosestObject(pos)
			else
				door, doorDis = ESX.Game.GetClosestObject(nil, pos)
			end
			if doorDis > 1.0 then
				Notify(Config.Strings.getClsr)
			else
				if DoesEntityExist(door) then
					local doorPos, rotation, propHash = GetEntityCoords(door), GetEntityHeading(door), GetEntityModel(door)
					TriggerServerEvent('b8ba676c-b59d-47e9-90ba-144b096cecf9', data.current.value, doorPos.x, doorPos.y, doorPos.z, rotation, propHash)
				else
					Notify(Config.Strings.dorNtFd)
				end
			end
		end
	end, function(data, menu)
		menu.close()
	end)
end)

RegisterCommand(Config.Creation.Commands.AddGarage, function(raw, args)
	while ESX == nil do Citizen.Wait(10) end
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
	local dis = 1000
	local elements = {}
	for k,v in pairs(Houses) do
		dis = #(pos - v.door)
		if dis <= v.draw then
			table.insert(elements, {label = k, value = k, pos = {x = v.door.x, y = v.door.y, z = v.door.z}, draw = v.draw})
		end
	end
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'choose_address',
	{
		title = Config.Strings.clstAdd,
		align = Config.MenuAlign,
		elements = elements
	},function(data, menu)
		pos = GetEntityCoords(ped)
		vec = vector3(data.current.pos.x, data.current.pos.y, data.current.pos.z)
		dis = #(pos - vec)
		if dis > data.current.draw then
			Notify(Config.Strings.uTooFar)
		else
			local door, doorDis
			if Config.ESXLevel == 2 or Config.ESXLevel == 3 then
				door, doorDis = ESX.Game.GetClosestObject(pos)
			else
				door, doorDis = ESX.Game.GetClosestObject(nil, pos)
			end
			if doorDis > 2.5 then
				Notify(Config.Strings.getClsr)
			else
				if DoesEntityExist(door) then
					local doorPos, rotation, propHash, draw = GetEntityCoords(door), GetEntityHeading(door), GetEntityModel(door)
					menu.close()
					local elms = {}
					for i = 1,#Config.LandSize do
						table.insert(elms, {label = Config.LandSize[i], value = Config.LandSize[i]})
					end
					drawRange = 5
					Citizen.CreateThread(function()
						while drawRange > 0 do
							Citizen.Wait(5)
							DrawMarker(2, GetOffsetFromEntityInWorldCoords(ped, 0.0, (drawRange * 1.0), 0.0), 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 3.0, 3.0, 3.0, 255, 0, 0, 255, true, true, 2, 0, 0, 0, 0)
						end
					end)
					ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'set_draw',
					{
						title = Config.Strings.grgODis,
						align = Config.MenuAlign,
						elements = elms
					}, function(data2, menu2)
						draw = data2.current.value * 1.0
						drawRange = 0
						menu2.close()
						TriggerServerEvent('80418a39-f202-4e75-bc4b-cf8ba5ec705e', data.current.value, doorPos.x, doorPos.y, doorPos.z, propHash, draw)
					end, function(data2, menu2)
						menu2.close()
						drawRange = 0
					end, function(data2, menu2)
						drawRange = data2.current.value
					end)
				else
					Notify(Config.Strings.dorNtFd)
				end
			end
		end
	end, function(data, menu)
		menu.close()
	end)
end)

RegisterCommand(Config.Creation.Commands.DeleteDoor, function(raw, args)
	while ESX == nil do Citizen.Wait(10) end
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
	local dis = 1000
	local elements = {}
	for k,v in pairs(Houses) do
		dis = #(pos - v.door)
		if dis <= v.draw then
			table.insert(elements, {label = k, value = k, pos = {x = v.door.x, y = v.door.y, z = v.door.z}, draw = v.draw})
		end
	end
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'choose_address',
	{
		title = Config.Strings.clstAdd,
		align = Config.MenuAlign,
		elements = elements
	},function(data, menu)
		pos = GetEntityCoords(ped)
		vec = vector3(data.current.pos.x, data.current.pos.y, data.current.pos.z)
		dis = #(pos - vec)
		if dis > data.current.draw then
			Notify(Config.Strings.uTooFar)
		else
			local door, doorDis
			if Config.ESXLevel == 2 or Config.ESXLevel == 3 then
				door, doorDis = ESX.Game.GetClosestObject(pos)
			else
				door, doorDis = ESX.Game.GetClosestObject(nil, pos)
			end
			if doorDis > 2.5 then
				Notify(Config.Strings.getClsr)
			else
				if DoesEntityExist(door) then
					local doorPos, propHash = GetEntityCoords(door), GetEntityModel(door)
					TriggerServerEvent('8cfe2b09-2a3d-48d6-a620-0a7f03fb998f', data.current.value, doorPos.x, doorPos.y, doorPos.z, propHash)
				else
					Notify(Config.Strings.dorNtFd)
				end
			end
		end
	end, function(data, menu)
		menu.close()
	end)
end)

RegisterCommand(Config.Creation.Commands.SetStorage, function(raw, args)
	while ESX == nil do Citizen.Wait(10) end
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
	local dis = 1000
	local elements = {}
	for k,v in pairs(Houses) do
		if SpawnedHome[1] == nil then
			dis = #(pos - v.door)
			if dis <= v.draw then
				table.insert(elements, {label = k, value = k, pos = {x = v.door.x, y = v.door.y, z = v.door.z}, draw = v.draw})
			end
		end
		if SpawnedHome[1] ~= nil then
			if v.id == currentHouseID then
				table.insert(elements, {label = k, value = k, pos = {x = v.door.x, y = v.door.y, z = v.door.z}, draw = v.draw})
			end
		end
	end
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'choose_address',
		{
			title = Config.Strings.clstAdd,
			align = Config.MenuAlign,
			elements = elements
		},function(data, menu)
			pos = GetEntityCoords(ped)
			vec = vector3(data.current.pos.x, data.current.pos.y, data.current.pos.z)
			dis = #(pos - vec)
			if SpawnedHome[1] == nil and dis > data.current.draw then
				Notify(Config.Strings.uTooFar)
			else
				if SpawnedHome[1] ~= nil then
					local home = SpawnedHome[1]
					local offset = GetOffsetFromEntityGivenWorldCoords(home, pos)
					pos = vector3(offset.x, offset.y, offset.z)
					TriggerServerEvent('132acec2-6ac5-419c-a216-64463475903d', data.current.value, ESX.Math.Round(pos.x, 2), ESX.Math.Round(pos.y, 2), ESX.Math.Round(pos.z, 2) - 1.0, true)
				else
					TriggerServerEvent('132acec2-6ac5-419c-a216-64463475903d', data.current.value, ESX.Math.Round(pos.x, 2), ESX.Math.Round(pos.y, 2), ESX.Math.Round(pos.z, 2) - 1.0, true)
				end
			end
		end, function(data, menu)
		menu.close()
	end)
end)



RegisterCommand(Config.Creation.Commands.SetJobLocation, function(raw, args)
	while ESX == nil do Citizen.Wait(10) end
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
	local dis = 1000
	local elements = {}
	for k,v in pairs(Houses) do
		if SpawnedHome[1] == nil then
			dis = #(pos - v.door)
			if dis <= v.draw then
				table.insert(elements, {label = k, value = k, pos = {x = v.door.x, y = v.door.y, z = v.door.z}, draw = v.draw})
			end
		end
		if SpawnedHome[1] ~= nil then
			if v.id == currentHouseID then
				table.insert(elements, {label = k, value = k, pos = {x = v.door.x, y = v.door.y, z = v.door.z}, draw = v.draw})
			end
		end
	end
	ESX.TriggerServerCallback('78b06279-8aaa-412b-83a1-505d566d9fb6', function(canCreate)
		if canCreate then
		
			ESX.UI.Menu.CloseAll()
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'choose_address',
				{
					title = Config.Strings.clstAdd,
					align = Config.MenuAlign,
					elements = elements
				},function(data, menu)
					pos = GetEntityCoords(ped)
					vec = vector3(data.current.pos.x, data.current.pos.y, data.current.pos.z)
					dis = #(pos - vec)
					if SpawnedHome[1] == nil and dis > data.current.draw then
						Notify(Config.Strings.uTooFar)
					else

						local chosenddress = data.current.value
						pos = GetEntityCoords(ped)
						vec = vector3(data.current.pos.x, data.current.pos.y, data.current.pos.z)
						
						dis = #(pos - vec)
						if SpawnedHome[1] == nil and dis > data.current.draw then
							Notify(Config.Strings.uTooFar)
						else
							if SpawnedHome[1] ~= nil then
								local home = SpawnedHome[1]
								local offset = GetOffsetFromEntityGivenWorldCoords(home, pos)
								pos = vector3(offset.x, offset.y, offset.z)
								TriggerServerEvent('d42b9a94-173f-4335-8046-d0cb1a09165b', chosenddress, json.encode({x = ESX.Math.Round(pos.x, 2), y = ESX.Math.Round(pos.y, 2), z =ESX.Math.Round(pos.z, 2) - 1.0 }))
							else

								TriggerServerEvent('d42b9a94-173f-4335-8046-d0cb1a09165b', chosenddress, json.encode({x = ESX.Math.Round(pos.x, 2), y = ESX.Math.Round(pos.y, 2), z =ESX.Math.Round(pos.z, 2) - 1.0 }))
							end
						end

					end
				end, function(data, menu)
							menu.close()
				
				end)

		else
			Notify(Config.Strings.noPerms)
		end
	end)
end)


RegisterCommand(Config.Creation.Commands.SetJob, function(raw, args)
	while ESX == nil do Citizen.Wait(10) end
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
	local dis = 1000
	local elements = {}
	for k,v in pairs(Houses) do
		if SpawnedHome[1] == nil then
			dis = #(pos - v.door)
			if dis <= v.draw then
				table.insert(elements, {label = k, value = k, pos = {x = v.door.x, y = v.door.y, z = v.door.z}, draw = v.draw})
			end
		end
		if SpawnedHome[1] ~= nil then
			if v.id == currentHouseID then
				table.insert(elements, {label = k, value = k, pos = {x = v.door.x, y = v.door.y, z = v.door.z}, draw = v.draw})
			end
		end
	end
	ESX.TriggerServerCallback('78b06279-8aaa-412b-83a1-505d566d9fb6', function(canCreate)
		if canCreate then
		
		
			ESX.UI.Menu.CloseAll()
			ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'choose_address',
				{
					title = Config.Strings.clstAdd,
					align = Config.MenuAlign,
					elements = elements
				},function(data, menu)
					pos = GetEntityCoords(ped)
					vec = vector3(data.current.pos.x, data.current.pos.y, data.current.pos.z)
					dis = #(pos - vec)
					if SpawnedHome[1] == nil and dis > data.current.draw then
						Notify(Config.Strings.uTooFar)
					else
						local chosenddress = data.current.value
					
						ESX.UI.Menu.CloseAll()
						ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'job_name',
						{
							title = Config.Strings.setJobn
						},
						function(data, menu2)
							local jobname = data.value
							
							if jobname == nil or jobname == '' then
								Notify('No job name provided, action cancelled.')
								return
							end
							if string.len(jobname) > 55 then
								Notify('String too long for job name > 55 char')
							else
								menu2.close()
								TriggerServerEvent('428d0208-ee7a-4622-9951-8efa82861050',chosenddress, jobname)
							end
						end, function(data, menu)
							menu2.close()
						end)

					end
				end, function(data, menu)
				menu.close()
			end)

		else
			Notify(Config.Strings.noPerms)
		end
	end)
end)

RegisterCommand(Config.Creation.Commands.SetWardrobe, function(raw, args)
	while ESX == nil do Citizen.Wait(10) end
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
	local dis = 1000
	local elements = {}
	for k,v in pairs(Houses) do
		if SpawnedHome[1] == nil then
			dis = #(pos - v.door)
			if dis <= v.draw then
				table.insert(elements, {label = k, value = k, pos = {x = v.door.x, y = v.door.y, z = v.door.z}, draw = v.draw})
			end
		end
		if SpawnedHome[1] ~= nil then
			if v.id == currentHouseID then
				table.insert(elements, {label = k, value = k, pos = {x = v.door.x, y = v.door.y, z = v.door.z}, draw = v.draw})
			end
		end
	end
	ESX.UI.Menu.CloseAll()
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'choose_address',
		{
			title = Config.Strings.clstAdd,
			align = Config.MenuAlign,
			elements = elements
		},function(data, menu)
			pos = GetEntityCoords(ped)
			vec = vector3(data.current.pos.x, data.current.pos.y, data.current.pos.z)
			dis = #(pos - vec)
			if SpawnedHome[1] == nil and dis > data.current.draw then
				Notify(Config.Strings.uTooFar)
			else
				if SpawnedHome[1] ~= nil then
					local home = SpawnedHome[1]
					local offset = GetOffsetFromEntityGivenWorldCoords(home, pos)
					pos = vector3(offset.x, offset.y, offset.z)
					TriggerServerEvent('132acec2-6ac5-419c-a216-64463475903d', data.current.value, ESX.Math.Round(pos.x, 2), ESX.Math.Round(pos.y, 2), ESX.Math.Round(pos.z, 2) - 1.0)
				else
					TriggerServerEvent('132acec2-6ac5-419c-a216-64463475903d', data.current.value, ESX.Math.Round(pos.x, 2), ESX.Math.Round(pos.y, 2), ESX.Math.Round(pos.z, 2) - 1.0)
				end
			end
		end, function(data, menu)
		menu.close()
	end)
end)

RegisterCommand(Config.Strings.doorLockCom, function(raw)
	while ESX == nil do Citizen.Wait(10) end
	if Config.KeyOptions.Item.Require and Config.KeyOptions.Item.Name ~= '' then
		ESX.TriggerServerCallback('085cf54b-2e5b-4e8d-a048-4b249841ecda', function(hasIt)
			if hasIt then
				if canUpdate then
					TriggerServerEvent('18f67e35-3887-4826-a25c-62bb72bbecec', currentZone.id, dor2Update)
				else
					Notify(Config.Strings.frntDor)
				end
			else
				Notify(Config.Strings.uNoKeys)
			end
		end, Config.KeyOptions.Item.Name)
	else
		if canUpdate then
			TriggerServerEvent('18f67e35-3887-4826-a25c-62bb72bbecec', currentZone.id, dor2Update)
		else
			Notify(Config.Strings.frntDor)
		end
	end							   
end)

RegisterKeyMapping("doorlock1", Config.Strings.keyHelp, 'keyboard', Config.Keys.UnLock)


-- FOLLOWING COMMANDS FOR DEVELOPMENT ONLY (SETTING NEW SHELL DOOR LOCATIONS AND PRE-FURNISHED HOME FURNITURE) --

RegisterCommand(Config.Creation.Commands.TestShell, function(raw, args)
	while ESX == nil do Citizen.Wait(10) end
	ESX.TriggerServerCallback('78b06279-8aaa-412b-83a1-505d566d9fb6', function(canCreate)
		if canCreate then
			local ped = PlayerPedId()
			local pos = GetEntityCoords(ped)
			returnPos = pos
			local model = GetHashKey(args[1])
			if IsModelInCdimage(model) then
				if not HasModelLoaded(model) then
					ticks[model] = 0
					while not HasModelLoaded(model) do
						ESX.ShowHelpNotification('Requesting model, please wait')
						DisableAllControlActions(0)
						RequestModel(model)
						Citizen.Wait(1)
						ticks[model] = ticks[model] + 1
						if ticks[model] >= 500 then
							ticks[model] = 0
							ESX.ShowHelpNotification('Model '..data.current.value..' failed to load, found in server image, please attempt re-logging to solve')
							return
						end
					end
				end
				if HasModelLoaded(model) then
					local x, y, z = pos.x, pos.y, pos.z - 20
					local height = GetWaterHeight(x,y,z)
					local spot
					if height == false then
						spot = vector3(x, y, z)
					else
						spot = GetSafeSpot()
					end
					local spot = vector3(x, y, z)
					local home = CreateObjectNoOffset(model, spot, true, false, false)
					if DoesEntityExist(home) then
						FreezeEntityPosition(home, true)
						SpawnedHome = {}
						table.insert(SpawnedHome, home)
						DoScreenFadeOut(100)
						while not IsScreenFadedOut() do
							Citizen.Wait(1)
						end
						SetEntityCoords(ped, spot)
						Citizen.Wait(1000)
						FreezeEntityPosition(ped, true)
						while not HasCollisionLoadedAroundEntity(ped) do
							Citizen.Wait(1)
						end
						DoScreenFadeIn(100)
						FreezeEntityPosition(ped, false)
					else
						Notify(Config.Strings.wntRong)
					end
				end
			else
				Notify(Config.Strings.modNtFd)
			end
		else
			Notify(Config.Strings.noPerms)
		end
	end)
end, false)

RegisterCommand(Config.Creation.Commands.ClearShell, function(raw)
	while ESX == nil do Citizen.Wait(10) end
	if returnPos ~= nil then
		ESX.TriggerServerCallback('78b06279-8aaa-412b-83a1-505d566d9fb6', function(canCreate)
			if canCreate then
				local ped = PlayerPedId()
				local pos = GetEntityCoords(ped)
				SetEntityCoords(ped, returnPos)
				for i = 1,#SpawnedHome do
					local delmodel = GetEntityModel(SpawnedHome[i])
					DeleteEntity(SpawnedHome[i])
					SetModelAsNoLongerNeeded(delmodel)
				end
				SpawnedHome = {}
				returnPos = nil
			else
				Notify(Config.Strings.noPerms)
			end
		end)
	else
		Notify(Config.Strings.aftrTst)
	end
end, false)

RegisterCommand(Config.Creation.Commands.Offset, function(raw)
	while ESX == nil do Citizen.Wait(10) end
	if SpawnedHome[1] ~= nil then
		ESX.TriggerServerCallback('78b06279-8aaa-412b-83a1-505d566d9fb6', function(canCreate)
			if canCreate then
				local ped = PlayerPedId()
				local pos = GetEntityCoords(ped)
				local home = SpawnedHome[1]
				local offset = GetOffsetFromEntityGivenWorldCoords(home, pos)
				local vec = vector3(offset.x, offset.y, offset.z - 1.0)
				
			else
				Notify(Config.Strings.noPerms)
			end
		end)
	else
		Notify(Config.Strings.noShell)
	end
end)

RegisterCommand(Config.Creation.Commands.SpawnProp, function(raw, args)
	while ESX == nil do Citizen.Wait(10) end
	ESX.TriggerServerCallback('78b06279-8aaa-412b-83a1-505d566d9fb6', function(canCreate)
		if canCreate then
			local ped = PlayerPedId()
			local pos = GetOffsetFromEntityInWorldCoords(ped, 0.0, 1.0, 0.0)
			local model = GetHashKey(args[1])
			if IsModelInCdimage(model) then
				if not HasModelLoaded(model) then
					ticks[model] = 0
					while not HasModelLoaded(model) do
						ESX.ShowHelpNotification('Requesting model, please wait')
						DisableAllControlActions(0)
						RequestModel(model)
						Citizen.Wait(1)
						ticks[model] = ticks[model] + 1
						if ticks[model] >= 500 then
							ticks[model] = 0
							ESX.ShowHelpNotification('Model '..data.current.value..' failed to load, found in server image, please attempt re-logging to solve')
							return
						end
					end
				end
				if HasModelLoaded(model) then
					local prop = CreateObjectNoOffset(model, pos, false, false, false)
					SetEntityHeading(prop, 0.0)
					Citizen.Wait(10000)
					SetEntityAsMissionEntity(prop,true,true)
					DeleteEntity(prop)
					SetModelAsNoLongerNeeded(model)
				end
			else
				Notify(Config.Strings.modNtFd)
			end
		else
			Notify(Config.Strings.noPerms)
		end
	end)
end)


GetClosestObjectNHC = function(filter, coords)
	local objects         = ESX.Game.GetObjects()
	local closestDistance = -1
	local closestObject   = -1
	local filter          = filter
	local coords          = coords

	if type(filter) == 'string' then
		if filter ~= '' then
			filter = {filter}
		end
	end

	if coords == nil then
		local playerPed = PlayerPedId()
		coords = GetEntityCoords(playerPed)
	end

	for i=1, #objects, 1 do
		local foundObject = false

		if filter == nil or (type(filter) == 'table' and #filter == 0) then
			foundObject = true
		else
			local objectModel = GetEntityModel(objects[i])

			for j=1, #filter, 1 do
				--print(objectModel  .. " " .. filter[j])
				if tonumber(objectModel) == tonumber(filter[j]) then
					foundObject = true
				end
			end
		end

		if foundObject then
			local objectCoords = GetEntityCoords(objects[i])
			local distance     = GetDistanceBetweenCoords(objectCoords, coords.x, coords.y, coords.z, true)

			if closestDistance == -1 or closestDistance > distance then
				closestObject   = objects[i]
				closestDistance = distance
			end
		end
	end

	return closestObject, closestDistance
end

RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function()
	while ESX == nil do Citizen.Wait(10) end
	PlayerData = ESX.GetPlayerData()
	if IsRealEstate() then
		TriggerEvent('796d6d88-dc5d-4ed3-a7f0-c8bc9df78ef3')
	end
end)





RegisterNetEvent('75d889cf-8acd-4173-937c-4bb63bd1fcd8')
AddEventHandler('75d889cf-8acd-4173-937c-4bb63bd1fcd8', function(address,locked)

	if Houses ~= nil and Houses[address].locked ~= nil then
		Houses[address].locked = locked
	end
end)


RegisterNetEvent('ed3a52ee-cbb7-42ce-9e09-e6f816d639f1')
AddEventHandler('ed3a52ee-cbb7-42ce-9e09-e6f816d639f1', function(address,job)

	if Houses ~= nil and Houses[address] ~= nil then
		Houses[address].job = job
		if spawnhouseActive ~= nil and spawnhouseActive.id == address then
			spawnhouseActive.job = job
		end
		
	end
end)


RegisterNetEvent('278dcd3d-318d-4782-81a2-7e2785469fdc')
AddEventHandler('278dcd3d-318d-4782-81a2-7e2785469fdc', function(address,jobmarker)

	if Houses ~= nil and Houses[address] ~= nil then
		print(address)
		jobmarker = json.decode(jobmarker)
		Houses[address].jobmarker = vector3(jobmarker.x,jobmarker.y,jobmarker.z)
		if spawnhouseActive ~= nil and spawnhouseActive.id == address then
			spawnhouseActive.jobmarker = vector3(jobmarker.x,jobmarker.y,jobmarker.z)
		end
		
	end
end)



RegisterNetEvent('b063deae-1f2d-4b82-b89a-eb1a81517214')
AddEventHandler('b063deae-1f2d-4b82-b89a-eb1a81517214', function(address,doorpos,lockstatus)
	
	local doors = Houses[address].doors
	local garages = Houses[address].garages
	
	if type(lockstatus) == 'boolean' then
		if lockstatus == true then
			lockstatus = "true"
		else
			lockstatus = "false"
		end
	end
	
	for i = 1,#garages do
			
		if garages[i].pos.x == doorpos.pos.x  and garages[i].pos.y == doorpos.pos.y then
		
			if lockstatus == "true" then
				Houses[address].garages[i].locked = true
				--print('locked ' .. lockstatus )
			else
				Houses[address].garages[i].locked = false
				--print('locked ' .. lockstatus )
			end
		end
	end
	for i = 1,#doors do

		if doors[i].pos.x == doorpos.pos.x and doors[i].pos.y == doorpos.pos.y then
			if lockstatus == "true" then
				Houses[address].doors[i].locked = true
				--print('locked ' .. lockstatus )
			else
				Houses[address].doors[i].locked = false
				--print('locked ' .. lockstatus )
			end
		end
	end
end)


RegisterNetEvent('faad7442-0f45-4873-a202-03f44025aad4')
AddEventHandler('faad7442-0f45-4873-a202-03f44025aad4', function(address,x,y,z)
	print('updatestorageST ' .. address)
	if Houses[address].storage ~= nil then
		Houses[address].storage = vector3(x,y,z)
		if spawnhouseActive ~= nil and spawnhouseActive.id == address then
			spawnhouseActive.storage = vector3(x,y,z)
		end
	end
end)

RegisterNetEvent('eb8714c7-8928-4464-a0c6-7a63e696cba1')
AddEventHandler('eb8714c7-8928-4464-a0c6-7a63e696cba1', function(address,sender, x,y,z, heading, item, name, isMLO)
	print('updatewardrobeST ' .. address)
	if Houses[address] ~= nil  then
		if not isMLO then
			table.insert(Houses[address].furniture.inside, {x = ESX.Math.Round(x, 2), y = ESX.Math.Round(y, 2), z = ESX.Math.Round(z, 2), heading = ESX.Math.Round(heading, 2), prop = item, label = name})
		else

			table.insert(Houses[address].furniture.outside, {x = ESX.Math.Round(x, 2), y = ESX.Math.Round(y, 2), z = ESX.Math.Round(z, 2), heading = ESX.Math.Round(heading, 2), prop = item, label = name})
		end
	end
	forceRefreshOfEverything()
end)


RegisterNetEvent('c29f2501-61f4-4b37-9f21-1dd85c9dc351')
AddEventHandler('c29f2501-61f4-4b37-9f21-1dd85c9dc351', function(address,sender, pos, model, name)
		
		if Houses[address] ~= nil  then
			for k,v in pairs(Houses[address].furniture.outside) do

				if v.x == pos.x and v.y == pos.y and v.z == pos.z then

					table.remove(Houses[address].furniture.outside, k)

				end
			end
		end
		forceRefreshOfEverything()
end)



RegisterNetEvent('fc4ce998-bae0-4e7c-ab0c-3de509abeb0a')
AddEventHandler('fc4ce998-bae0-4e7c-ab0c-3de509abeb0a', function(address, sender, x,y,z, heading, item, name, isMLO)
	print('updatewardrobeST ' .. address)
	if Houses[address] ~= nil  then
	
		if not isMLO then

			for k,v in pairs(Houses[address].furniture.inside) do

				if v.x == x and v.y == y and v.z == z then

					table.remove(Houses[address].furniture.inside, k)

				end

			end

		else

			for k,v in pairs(Houses[address].furniture.outside) do

				if v.x == x and v.y == y and v.z == z then

					table.remove(Houses[address].furniture.outside, k)

				end

			end

		end
		
	end
	forceRefreshOfEverything()
end)


RegisterNetEvent('27cddd97-f135-4375-8ce3-a10bd432aed8')
AddEventHandler('27cddd97-f135-4375-8ce3-a10bd432aed8', function(address,owner,prevowner,price)
	print('sell home price update')
	if Houses[address] ~= nil  then
		if owner ~= nil then
			print('sell home price owner ' .. owner)
			Houses[address].owner = owner
		end
		if prevowner ~= nil then
			print('sell home price prevowner ' .. prevowner )
			Houses[address].prevowner = prevowner
		end
		if price ~= nil then
			print('sell home price price ' .. price)
			Houses[address].price = price
		end
	end
	Wait(100)
	forceRefreshOfEverything()
end)

RegisterNetEvent('7ebd5722-67b5-4cae-964b-9c576ba2df76')
AddEventHandler('7ebd5722-67b5-4cae-964b-9c576ba2df76', function(houses)
	print('create sell home')
		for k,v in pairs(houses) do
			local door = json.decode(v.door)
			local storage = json.decode(v.storage)
			local wardrobe = json.decode(v.wardrobe)
			v.door = vector3(door.x, door.y, door.z)
			v.storage = vector3(storage.x, storage.y, storage.z)
			v.wardrobe = vector3(wardrobe.x, wardrobe.y, wardrobe.z)
			v.doors = json.decode(v.doors)
			v.garages = json.decode(v.garages)
			v.furniture = json.decode(v.furniture)
			v.parkings = json.decode(v.parkings)
			v.keys = json.decode(v.keys)
			Houses[v.id] = v
		end

	Wait(100)
	forceRefreshOfEverything()
end)

RegisterNetEvent('f74b8afd-50d8-40b3-9e27-00d78fb8a412')
AddEventHandler('f74b8afd-50d8-40b3-9e27-00d78fb8a412', function(address,draw)
	print('UpdateLandSize' .. address)
	if Houses[address] ~= nil then
		Houses[address].draw = draw
	end
	forceRefreshOfEverything()
end)

RegisterNetEvent('e785f55c-924d-4936-ae1b-5ba2b16f6f64')
AddEventHandler('e785f55c-924d-4936-ae1b-5ba2b16f6f64', function(address,doors)
	print('AddDoortoHouse' .. address)
	if Houses[address] ~= nil then
		Houses[address].doors = doors
	end
	forceRefreshOfEverything()
end)

RegisterNetEvent('da0f18b4-2427-43ed-b99f-246433d86dca')
AddEventHandler('da0f18b4-2427-43ed-b99f-246433d86dca', function(address,garages)
	print('AddDoortoHouse' .. address)
	if Houses[address] ~= nil then
		Houses[address].garages = garages
	end
	forceRefreshOfEverything()
end)

RegisterNetEvent('758728d9-c4c9-4790-9342-bd989ad583b4')
AddEventHandler('758728d9-c4c9-4790-9342-bd989ad583b4', function(address, doors,garages)
	print('removedoortoHouse' .. address)
	if Houses[address] ~= nil then
		Houses[address].garages = garages
		Houses[address].doors = doors
	end
	forceRefreshOfEverything()
end)

RegisterNetEvent('175fdbbb-c40f-45f1-80a4-361e475c4592')
AddEventHandler('175fdbbb-c40f-45f1-80a4-361e475c4592', function(address, doors)
	print('deleteHome' .. address)
	Houses[address] = nil
	forceRefreshOfEverything()
end)

RegisterNetEvent('09ed390d-b3f7-4d46-9ce5-c915998273e4')
AddEventHandler('09ed390d-b3f7-4d46-9ce5-c915998273e4', function(address, spots)
	print('createParkingST' .. address)
	Houses[address].parkings = spots
	forceRefreshOfEverything()
end)

RegisterNetEvent('5d6e1f0b-caff-45b6-8052-639db05f18b5')
AddEventHandler('5d6e1f0b-caff-45b6-8052-639db05f18b5', function(address, keys)
	print('SSCompleteHousing:giveKey' .. address)
	if Houses[address] ~= nil then
		Houses[address].keys = keys
	end
	forceRefreshOfEverything()
end)

RegisterNetEvent('94b26690-955f-4a36-a2f0-fdafd0d04cc4')
AddEventHandler('94b26690-955f-4a36-a2f0-fdafd0d04cc4', function(address, failbuy)
	print('SSCompleteHousing:buyBackFailST' .. address)
	if Houses[address] ~= nil then
		Houses[address].failBuy = failbuy
	end
	forceRefreshOfEverything()
end)





RegisterNetEvent('cc8fc5a1-a401-4da2-8415-ea41506b26f8')
AddEventHandler('cc8fc5a1-a401-4da2-8415-ea41506b26f8', function(address,owner,prevowner)
	print('SSCompleteHousing:buyBackFailST' .. address)
	if Houses[address] ~= nil then
		Houses[address].owner = owner
		Houses[address].prevowner = prevowner
	end
	forceRefreshOfEverything()
end)



RegisterNetEvent('ea1045cc-0bbd-4b7c-b368-2b456278f4c3')
AddEventHandler('ea1045cc-0bbd-4b7c-b368-2b456278f4c3', function(address, furniture)
	print('SSCompleteHousing:buyBackFailST' .. address)
	if Houses[address] ~= nil then
		Houses[address].owner = owner
		Houses[address].prevowner = prevowner
	end
	forceRefreshOfEverything()
end)





RegisterNetEvent('3e0c85d6-ccd9-4a87-b3a8-9e949c455739')
AddEventHandler('3e0c85d6-ccd9-4a87-b3a8-9e949c455739', function(address,sender, x,y,z, heading, item, name)
	print('updatewardrobeST ' .. address)
	if Houses[address] ~= nil  then
		table.insert(Houses[address].furniture.outside, {x = ESX.Math.Round(x, 2), y = ESX.Math.Round(y, 2), z = ESX.Math.Round(z, 2), heading = ESX.Math.Round(heading, 2), prop = item, label = name})
	end
	forceRefreshOfEverything()
end)