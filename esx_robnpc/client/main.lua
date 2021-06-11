ESX = nil

local robbedRecently = false


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

function amirobbing()
	return robbedRecently
end

local acount = 0

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(20)

      --  if IsControlJustPressed(0, 303) then
            local aiming, targetPed = GetEntityPlayerIsFreeAimingAt(PlayerId(-1))
	
            if aiming then
                local playerPed = GetPlayerPed(-1)
                local pCoords = GetEntityCoords(playerPed, true)
                local tCoords = GetEntityCoords(targetPed, true)
				local dist1 = #(vector3(pCoords.x, pCoords.y, pCoords.z) -  vector3(tCoords.x, tCoords.y, tCoords.z))
			
                if DoesEntityExist(targetPed) and IsEntityAPed(targetPed) and not IsPedAPlayer(targetPed) and GetEntityModel(targetPed) ~= `s_m_m_security_01` and IsPedArmed(playerPed,7) then
					if exports['rb_robbery']:isclosetostore() == false then
						local weaptrue,weaphash = GetCurrentPedWeapon(playerPed,1)
						if weaphash ~= `weapon_flashlight` then
							if robbedRecently then
							   -- ESX.ShowNotification(_U('robbed_too_recently'))
							elseif IsPedDeadOrDying(targetPed, true) then
								--ESX.ShowNotification(_U('target_dead'))
							elseif dist1 > Config.RobDistance then
								if dist1 < 17 then
									ESX.ShowNotification(_U('target_too_far'))
								end
							else
								acount = acount + 25
								if acount > 1300 then
									if GetEntityPopulationType(targetPed) ~= 7 then
										robNpc(targetPed)
									end
								end
							end
						end
					end
                end
			else
				acount = 0
            end
       -- end
    end
end)


local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }




function robNpc(targetPed)
    robbedRecently = true
	

    Citizen.CreateThread(function()
        local dict = 'random@mugging3'
        RequestAnimDict(dict)
        while not HasAnimDictLoaded(dict) do
            Citizen.Wait(10)
        end

		local fight = math.random(0,100)
		local coords = GetEntityCoords(PlayerPedId())
		local streetHash = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
		local street = GetStreetNameFromHashKey(streetHash)

		local zname = zones[GetNameOfZone(coords.x, coords.y, coords.z)]
		local message = 'Witness: Something suss is going down here.'
		print('fight')
		print(fight)
		if fight < Config.FightBack then
		
			--fight
			if IsPedSittingInAnyVehicle(targetPed) then
				--incar
				veh = GetVehiclePedIsUsing(targetPed)
				TaskLeaveVehicle(targetPed, veh,256)
			end
			
			
			local cog = math.random(0,100)
			ClearPedTasks(targetPed)
			PlayPain(targetPed, 7, 0)
			FreezeEntityPosition(targetPed, false)
			
			if cog < 50 then
				GiveWeaponToPed(targetPed, GetHashKey("WEAPON_PISTOL"), 8, false, true)
				if HasPedGotWeapon(targetPed, GetHashKey("WEAPON_PISTOL"), false) then
					SetCurrentPedWeapon(targetPed, GetHashKey("WEAPON_PISTOL"), true)
					SetPedAccuracy(targetPed, 40)
					TaskShootAtEntity(targetPed, PlayerPedId(), -1, 2685983626)
				end
				
				message = 'Witness: Help someones mugging someone and is shooting in ' .. street  .. ' ' .. zname
			
			else
				ClearPedTasksImmediately(targetPed)
				local kn = math.random(0,100)
				if kn < 40 then
					
					GiveWeaponToPed(targetPed, GetHashKey("WEAPON_KNIFE"), 1, false, true)

					if HasPedGotWeapon(targetPed, GetHashKey("WEAPON_KNIFE"), false) then
						SetCurrentPedWeapon(targetPed, GetHashKey("WEAPON_KNIFE"), true)
					end
					message = 'Witness: Help someones mugging someone and has a knife they are fighting ' .. street .. ' ' .. zname
				else
					message = 'Witness: Help someones mugging someone and they are fighting ' .. street .. ' ' .. zname
				end
				FreezeEntityPosition(targetPed, false)
				
				AddRelationshipGroup(targetPed)
               SetRelationshipBetweenGroups(5, GetHashKey('PLAYER'), GetHashKey(targetPed))
               SetRelationshipBetweenGroups(5, GetHashKey(targetPed), GetHashKey('PLAYER'))
			   SetPedCanSwitchWeapon(targetPed, true)
			   SetPedFleeAttributes(targetPed, 0, 0)
				SetPedCombatAttributes(targetPed, 16, 1)
				SetPedCombatAttributes(targetPed, 17, 0)
				SetPedCombatAttributes(targetPed, 46, 1)
				SetPedCombatAttributes(targetPed, 1424, 0)
				SetPedCombatAttributes(targetPed, 5, 1)
				SetPedConfigFlag(targetPed,100,1)
				SetPedAccuracy(targetPed, 40)
				TaskCombatPed(targetPed, PlayerPedId(), 0, 16)

			end
			callcops(message,coords.x,coords.y,coords.z)

		else
			local idea = math.random(0,100)
			if idea > 50 then
				TaskCower(targetPed, Config.RobAnimationSeconds * 1000)
			else
				TaskStandStill(targetPed, Config.RobAnimationSeconds * 1000)
				
				TaskPlayAnim(targetPed, dict, 'handsup_standing_base', 8.0, -8, .01, 49, 0, 0, 0, 0)
			end
			
			FreezeEntityPosition(targetPed, true)
			ESX.ShowNotification(_U('robbery_started'))
			

			if IsPedSittingInAnyVehicle(targetPed) then
				--incar
				veh = GetVehiclePedIsUsing(targetPed)
				FreezeEntityPosition(veh,true)
			end

			Citizen.Wait(Config.RobAnimationSeconds * 1000)
			message = 'Help me, Ive just been mugged on ' .. street  .. ' ' .. zname

			ESX.TriggerServerCallback('8a0b5439-9409-45df-80ec-1de52b0b65c1', function(amount)
				FreezeEntityPosition(targetPed, false)
				
			if IsPedSittingInAnyVehicle(targetPed) then
				--incar
				
				veh = GetVehiclePedIsUsing(targetPed)
				FreezeEntityPosition(veh,false)
			end

				ESX.ShowNotification(_U('robbery_completed', amount))
			end,message,coords.x,coords.y,coords.z)

			if Config.ShouldWaitBetweenRobbing then
				Citizen.Wait(math.random(Config.MinWaitSeconds, Config.MaxWaitSeconds) * 1000)
				
				ESX.ShowNotification(_U('can_rob_again'))
			end
		end
        robbedRecently = false
    end)
end


local lastcallvector = vector3(0,0,0)
RegisterNetEvent('0b667689-81d3-40e8-adbe-eefa5014ffd8')
AddEventHandler('0b667689-81d3-40e8-adbe-eefa5014ffd8', function(message,xx,yy,zz)
		print('trigger po call')
		if #(vector3(xx,yy,zz) - lastcallvector) > 1.0 then
			lastcallvector = vector3(xx,yy,zz)
			PlayerCoords = GetEntityCoords(GetPlayerPed(-1), true)
			TriggerServerEvent('575a96d1-9d2b-4370-b9d6-4cf0070492da', 'police', message , PlayerCoords, {

				PlayerCoords = { x = xx, y = yy, z = zz },
			})
		end
end)

function callcops(message,xx,yy,zz)
	print('trigger po call')
	if #(vector3(xx,yy,zz) - lastcallvector) > 5.0 then
		lastcallvector = vector3(xx,yy,zz)
		PlayerCoords = GetEntityCoords(GetPlayerPed(-1), true)
		TriggerServerEvent('575a96d1-9d2b-4370-b9d6-4cf0070492da', 'police', message , PlayerCoords, {

			PlayerCoords = { x = xx, y = yy, z = zz },
		})
	end
end
