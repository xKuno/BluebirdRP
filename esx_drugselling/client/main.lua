ESX = nil

local myJob = nil

local cokeQTE = 0
local coke_poochQTE = 0
local weedQTE = 0
local weed_poochQTE = 0
local methQTE = 0
local meth_poochQTE = 0
local opiumQTE = 0
local opium_poochQTE = 0

local playerPed = nil
local coords = {}
local currentped = nil

local sellingdrugstoggle = false
local drugstosell = "meth_pooch"

local drawing = false
local selling = false

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

Citizen.CreateThread(function()
    while(true) do
		playerPed = PlayerPedId()
		coords = GetEntityCoords(PlayerPedId())
        Citizen.Wait(1000)
    end
end)

function DrawText3Ds(x, y, z, text)
	local onScreen,_x,_y=World3dToScreen2d(x,y,z)
	local factor = #text / 550
	local px,py,pz=table.unpack(GetGameplayCamCoords())
	
	SetTextScale(0.25, 0.25)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextColour(255, 255, 255, 215)
	SetTextEntry("STRING")
	SetTextCentre(1)
	AddTextComponentString(text)
	DrawText(_x,_y)
	DrawRect(_x,_y + 0.0085, 0.005 + factor, 0.02, 0, 0, 0, 120)
end

RegisterNetEvent('f2432b8f-d635-4e37-a3ef-936e7ace34ee')
AddEventHandler('f2432b8f-d635-4e37-a3ef-936e7ace34ee', function(cokeNbr, cokepNbr, methNbr, methpNbr, weedNbr, weedpNbr, opiumNbr, opiumpNbr, Job1)
    cokeQTE       = cokeNbr
    coke_poochQTE = cokepNbr
    methQTE 	  = methNbr
    meth_poochQTE = methpNbr
    weedQTE 	  = weedNbr
    weed_poochQTE = weedpNbr
    opiumQTE       = opiumNbr
    opium_poochQTE = opiumpNbr
	myJob			= Job1
end)

RegisterNetEvent('c3c8b7bb-070f-4534-a6db-f5f8c50b8cb2')
AddEventHandler('c3c8b7bb-070f-4534-a6db-f5f8c50b8cb2', function(Job1)
	myJob = Job1
end)


function chooseDrugsToSell()
	if selling == false then
		  ESX.UI.Menu.Open (
			'default' , GetCurrentResourceName(), 'drugs' ,
			{
			  title     =  'Illegal Items to Sell' ,
			  align     =  'top-right' ,
			  elements = {
			  {label =  ' Sell Illegal Items [<span style="color: green;">ON</span>]' , value =  'drugson' },
			  {label =  ' Sell Illegal Items [<span style="color: orange;">OFF</span>]' , value =  'drugsoff' },
				{label =  ' Weed ' , value =  'weed' },
				{label =  ' Weed Pouch ' , value =  'weed_pooch' },
				{label =  ' Meth ' , value =  'meth' },
				{label =  ' Meth Pouch ' , value = 'meth_pooch' },
				{label =  ' Coke ' , value = 'coke' },
				{label =  ' Coke Pouch ' , value =  'coke_pooch' },
				{label =  ' Opium ' , value =  'opium' },
				{label =  ' Opium Pouch ' , value =  'opium_pooch' },
				{label =  ' LSD Tablet' , value =  'lsd_tablet' },
				{label =  ' Xanax' , value =  'xanax' },
				{label =  ' Fake Credit Cards' , value =  'creditcard_fake' },
				

			  },
			},
			function ( data , menu )
				if data.current.value == 'drugson' then
					ESX.ShowNotification('You are now selling Illegal Items ~g~ON')
					sellingdrugstoggle = true
				elseif data.current.value == 'drugsoff' then
					sellingdrugstoggle = false
					ESX.ShowNotification('You are now selling Illegal Items ~o~OFF')
				else
				  drugstosell = data.current.value
				  ESX.ShowNotification('You are now selling ~o~' .. data.current.label)
				  menu.close()
				end
			end ,
			function ( data , menu )
			  menu. close ()
			end)
	else
		ESX.ShowNotification('You ~r~cannot ~w~access this while moving product')
	end
end

RegisterCommand("drugstosell", function(raw, args)
	chooseDrugsToSell()
end,false)



RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function(job)
  TriggerServerEvent('8f9c45ec-4cdc-410d-9765-96c2bd4878e4')
end)

function Vente(pos1)
    local player = playerPed
    local playerloc = coords
    local distance = #(playerloc - pos1)

    if distance <= 2 then
		TriggerServerEvent('6c4ea4d9-d8e9-4bf8-bd1b-6de7d5af0efa', playerloc,drugstosell)
    elseif distance > 2 then
		TriggerServerEvent('672f7921-919c-41bf-98cb-90cbe9a0cb6c')
    end
end



Citizen.CreateThread(function()
	while true do
		Wait(5)
		
		--if myJob == "police" or myJob == "sheriff" then
			--return
		--end
		
		--if (coke_poochQTE ~= 0 or meth_poochQTE ~= 0 or weed_poochQTE ~= 0 or opium_poochQTE ~= 0) then
			if sellingdrugstoggle == true then
			--[[l78Z7enfGGarnS4x0ojcCwKDXf+SW/+1ERTAio7M8MY=]]
				drawing = false
				local handle, ped = FindFirstPed()
				repeat
					success, ped = FindNextPed(handle)
					local pos = GetEntityCoords(ped)
					local distance = #(coords - pos)
					if not IsPedInAnyVehicle(playerPed) then
						if DoesEntityExist(ped) then
							if not IsPedDeadOrDying(ped) then
								if not IsPedInAnyVehicle(ped) then
									local pedType = GetPedType(ped)
									if pedType ~= 28 and not IsPedAPlayer(ped) then
										currentped = pos

										if distance <= 2 and ped ~= playerPed and ped ~= oldped then
											drawing = true
						
											DrawText3Ds(pos.x, pos.y, pos.z, GuTu.Text['press'])
											if IsControlJustPressed(1, 86) then
											
												local otherselling = false
											
												local drugallowed = nil
												
												local zstatus, zerrorMsg = pcall(function() drugallowed = exports.izone:isPlayerInCatZone(drugstosell,"DRUGS") end)
												local zstatus, zerrorMsg = pcall(function() otherselling = exports.esx_drugselling:robbedRecently() end)
												
												
												--Check to see if we can sell in this zone
												if (drugallowed == nil and otherselling == false ) or (drugallowed ~= nil and drugallowed == true and otherselling == false) then
													oldped = ped
													--SetEntityHeading(ped, 180)
													TaskLookAtCoord(ped, coords['x'], coords['y'], coords['z'], -1, 2048, 3)
													TaskStandStill(ped, 100.0)
													SetEntityAsMissionEntity(ped)
													
													local saleresult = math.random(1,GuTu.PedRejectPercent)
													
													

													
													if saleresult ~= GuTu.PedRejectPercent then
														local copschance = math.random(1,GuTu.CallCopsPercent)
														if copschance == GuTu.CallCopsPercent then
															callpolice()
															--Call Police Random for Good sale
														end
														
														local pos1 = GetEntityCoords(ped)
														
														Wait(1000)
														ESX.ShowNotification(GuTu.Text['process'])
														
														local timetosell = math.random(GuTu.TimeSellingLow,GuTu.TimeSellingHigh)
														selling = true
														
														Citizen.CreateThread(function()
															local times = timetosell
															local ped = oldped
															while selling do
																local player = GetPlayerPed(-1)
																local playerloc = GetEntityCoords(player, 0)
																local distance = GetDistanceBetweenCoords(pos1.x, pos1.y, pos1.z, playerloc['x'], playerloc['y'], playerloc['z'], true)
																local pid = PlayerPedId()
																--TOO FAR
																if distance > 5 then
																	ESX.ShowNotification('Customer is too far away.')
																	selling = false
																	SetEntityAsMissionEntity(oldped)
																	SetPedAsNoLongerNeeded(oldped)
																	FreezeEntityPosition(oldped,false)
																end
																TaskStandStill(ped, timetosell)
																--SUCCESS
																if math.floor(times/1000) <= 1 then			
																	SetEntityAsMissionEntity(oldped)
																	SetPedAsNoLongerNeeded(oldped)
																	FreezeEntityPosition(oldped,false)
																	times = 0
																	sold = true
																	StopAnimTask(pid, "amb@prop_human_bum_bin@idle_b","idle_d", 1.0)
																	StopAnimTask(ped, "amb@prop_human_bum_bin@idle_b","idle_d", 1.0)
																	
																end	
																
																if math.floor(times/1000) == 4  then
																	RequestAnimDict("amb@prop_human_bum_bin@idle_b")
																	while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do 
																		Citizen.Wait(0) 
																	end
																	TaskTurnPedToFaceEntity(pid,ped)
																	TaskPlayAnim(pid,"amb@prop_human_bum_bin@idle_b","idle_d",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
																	ClearPedTasksImmediately(ped)
																	TaskPlayAnim(ped,"amb@prop_human_bum_bin@idle_b","idle_d",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
																	Wait(500)
																end
																if math.floor(times/1000) % 5 == 0 then
																	ESX.ShowNotification('Time left: ' .. math.floor(times/1000) .. ' sec(s)')
																end
																
																Wait(1000)
																times = times - 1000
															end
														end)
														Wait(timetosell)
														--Process Sale after transaction
														if selling == true then
															selling = false
															Vente(pos1)
															Wait(2500)
														end
													else ---Check if Reject
														local copschance = math.random(1,GuTu.PedRejectPercentCallCops)
														if copschance == GuTu.PedRejectPercentCallCops then
															--callpolice()
															--Call Police Random for Bad Sale
														end
														ESX.ShowNotification("~y~Cust: ~w~" ..GuTu.Rejections[math.random(1,#GuTu.Rejections)])
													end --- END REJECT
													SetPedAsNoLongerNeeded(oldped)
												elseif otherselling == true then
													ESX.ShowNotification('~w~He doesnt want to ~o~know~w~ you, he ~o~saw~w~ what you did!')
												else
													ESX.ShowNotification('This stuff doesnt wash here. Try elsewhere.')
													--
											
												end  -- IF for Drug area
											end
										end
									end
								end
							end
						end
					end
					
				until not success
				EndFindPed(handle)
				if drawing == false then
					Wait(1000)
				end
		else		
			Wait(2500)	
			--[[l78Z7enfGGarnS4x0ojcCwKDXf+SW/+1ERTAio7M8MY=]]
		end

	end
end)

RegisterNetEvent('fe681da7-a4a1-4dc5-9dcd-0b0c9dbe00ad')
AddEventHandler('fe681da7-a4a1-4dc5-9dcd-0b0c9dbe00ad', function()
	local pid = PlayerPedId()
	RequestAnimDict("amb@prop_human_bum_bin@idle_b")
	while (not HasAnimDictLoaded("amb@prop_human_bum_bin@idle_b")) do Citizen.Wait(0) end
	TaskPlayAnim(pid,"amb@prop_human_bum_bin@idle_b","idle_d",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
	Wait(750)
	StopAnimTask(pid, "amb@prop_human_bum_bin@idle_b","idle_d", 1.0)
end)

RegisterNetEvent('7ee2abb8-b53c-493d-8eb2-9d1fd24856d3')
AddEventHandler('7ee2abb8-b53c-493d-8eb2-9d1fd24856d3', function(posx, posy, posz)
	TriggerServerEvent('c916860b-b2ca-42eb-9eac-cf20b6341eac', 'police', GuTu.Text['process'], { x = posx, y = posy, z = posz })
end)


RegisterNetEvent('b78c41e5-0c9c-4350-b574-980c3104d4d1')
AddEventHandler('b78c41e5-0c9c-4350-b574-980c3104d4d1', function()
	ESX.ShowNotification("~y~Cust: ~w~" .. GuTu.Trick[math.random(1,#GuTu.Trick)])
	Wait(1300)
	AddRelationshipGroup(oldped)
    SetRelationshipBetweenGroups(5, GetHashKey('PLAYER'), GetHashKey(oldped))
    SetRelationshipBetweenGroups(5, GetHashKey(oldped), GetHashKey('PLAYER'))
	SetPedCanSwitchWeapon(oldped, true)
	SetPedFleeAttributes(oldped, 0, 0)
	SetPedCombatAttributes(oldped, 16, 1)
	SetPedCombatAttributes(oldped, 17, 0)
	SetPedCombatAttributes(oldped, 46, 1)
	SetPedCombatAttributes(oldped, 1424, 0)
	SetPedCombatAttributes(oldped, 5, 1)
	SetPedConfigFlag(oldped,100,1)
	TaskCombatPed(oldped, GetPlayerPed(-1), 0, 16)
	SetPedDropsWeaponsWhenDead(oldped,false)

end)

function callpolice()
	local model = GetEntityModel(GetPlayerPed(-1))
	local sex = "unknown"
	if model == `mp_m_freemode_01` then
		sex = "male"
	elseif model == `mp_f_freemode_01` then
		sex = "female"
	end
	
	PlayerCoords = GetEntityCoords(GetPlayerPed(-1))

	TriggerServerEvent('575a96d1-9d2b-4370-b9d6-4cf0070492da', 'police', string.upper(sex) .. ' Illegal Dealer:'  ..  exports["hud"]:location(), PlayerCoords, {

		PlayerCoords = { x = PlayerCoords.x, y = PlayerCoords.y, z = PlayerCoords.z },
	})

end


--l78Z7enfGGarnS4x0ojcCwKDXf+SW/+1ERTAio7M8MY=