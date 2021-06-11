ESX                           = nil
local ESXLoaded = false
local robbing = false

local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }


local hlist = flist



--[[

	
	{ coords = vector3(1648.22, 4780.02, 42.02), name= "3 Main St, Grapeseed" },
	{ coords = vector3(1648.22, 4780.02, 42.02), name= "3 Main St, Grapeseed" },
	{ coords = vector3(1648.22, 4780.02, 42.02), name= "3 Main St, Grapeseed" },
	{ coords = vector3(1648.22, 4780.02, 42.02), name= "3 Main St, Grapeseed" },
	{ coords = vector3(1648.22, 4780.02, 42.02), name= "3 Main St, Grapeseed" },
	{ coords = vector3(1648.22, 4780.02, 42.02), name= "3 Main St, Grapeseed" },
	{ coords = vector3(1648.22, 4780.02, 42.02), name= "3 Main St, Grapeseed" },
	{ coords = vector3(1648.22, 4780.02, 42.02), name= "3 Main St, Grapeseed" },
	{ coords = vector3(1648.22, 4780.02, 42.02), name= "3 Main St, Grapeseed" },
	{ coords = vector3(1648.22, 4780.02, 42.02), name= "3 Main St, Grapeseed" },
	{ coords = vector3(1648.22, 4780.02, 42.02), name= "3 Main St, Grapeseed" },
	{ coords = vector3(1648.22, 4780.02, 42.02), name= "3 Main St, Grapeseed" },
	{ coords = vector3(1648.22, 4780.02, 42.02), name= "3 Main St, Grapeseed" },
	{ coords = vector3(1648.22, 4780.02, 42.02), name= "3 Main St, Grapeseed" },
	{ coords = vector3(1648.22, 4780.02, 42.02), name= "3 Main St, Grapeseed" },
	{ coords = vector3(1648.22, 4780.02, 42.02), name= "3 Main St, Grapeseed" },

--]]

local closest = 1000
local distance = 1000



--[[
    for i = 1, #hlist do 
	       
            local blip = AddBlipForCoord(hlist[i].coords)
            SetBlipSprite(blip, 358)
            SetBlipColour(blip, 40)
			SetBlipScale(blip,0.3)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("BREAKIN")
            EndTextCommandSetBlipName(blip)

    end

--]]

Citizen.CreateThread(function ()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end

    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

    ESXLoaded = true
end)


function playAnim(animDict, animName, duration)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
	TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
	RemoveAnimDict(animDict)
end

RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(xPlayer)
  ESX.PlayerData = xPlayer
end)

RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function(job)
    ESX.PlayerData.job = job
end)

local peds = {}
local objects = {}



function _CreatePed(hash, coords, heading)
    RequestModel(hash)
    while not HasModelLoaded(hash) do
        Wait(5)
    end
	math.randomseed(GetGameTimer())

    local targetPed = CreatePed(4, hash, coords,heading, true, false)
    SetEntityHeading(targetPed, heading)
	
	
	local fight = math.random(0,100)
	
	if fight < 90 then
		
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
			SetEntityMaxHealth(targetPed,210)
			SetEntityHealth(targetPed,210)
			SetPedAccuracy(targetPed, 50)
			SetPedDropsWeaponsWhenDead(targetPed,false)
			
			local streetHash = GetStreetNameAtCoord(coords.x, coords.y, coords.z)
			local street = GetStreetNameFromHashKey(streetHash)
			local zname = zones[GetNameOfZone(coords.x, coords.y, coords.z)]
			local message = 'Whitness: Something suss is going down here.'
			if zname == nil then zname = "" end
			
			if cog < 10 then
				GiveWeaponToPed(targetPed, GetHashKey("WEAPON_PISTOL"), 8, false, true)
				if HasPedGotWeapon(targetPed, GetHashKey("WEAPON_PISTOL"), false) then
					SetCurrentPedWeapon(targetPed, GetHashKey("WEAPON_PISTOL"), true)
					
					TaskShootAtEntity(targetPed, PlayerPedId(), -1, 2685983626)
				end
				message = 'Whitness: Help someones mugging someone and is shooting in ' .. street  .. ' ' .. zname
			
			else
				ClearPedTasksImmediately(targetPed)
				local kn = math.random(0,100)
				if kn < 10 then
					
					GiveWeaponToPed(targetPed, GetHashKey("weapon_stungun"), 1, false, true)

					if HasPedGotWeapon(targetPed, GetHashKey("weapon_stungun"), false) then
						SetCurrentPedWeapon(targetPed, GetHashKey("weapon_stungun"), true)
					end

					message = 'Whitness: Help someones mugging someone and has a knife they are fighting ' .. street .. ' ' .. zname
				elseif kn < 15 then
					
					GiveWeaponToPed(targetPed, GetHashKey("WEAPON_KNIFE"), 1, false, true)

					if HasPedGotWeapon(targetPed, GetHashKey("WEAPON_KNIFE"), false) then
						SetCurrentPedWeapon(targetPed, GetHashKey("WEAPON_KNIFE"), true)
					end

					message = 'Whitness: Help someones mugging someone and has a knife they are fighting ' .. street .. ' ' .. zname
				elseif kn < 30 then
					
					GiveWeaponToPed(targetPed, GetHashKey("WEAPON_BAT"), 1, false, true)

					if HasPedGotWeapon(targetPed, GetHashKey("WEAPON_BAT"), false) then
						SetCurrentPedWeapon(targetPed, GetHashKey("WEAPON_BAT"), true)
					end
					message = 'Whitness: Help someones mugging someone and has a knife they are fighting ' .. street .. ' ' .. zname
				else
					message = 'Whitness: Help someones mugging someone and they are fighting ' .. street .. ' ' .. zname
				end
				
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
				TaskCombatPed(targetPed, GetPlayerPed(-1), 0, 16)
				SetPedDropsWeaponsWhenDead(targetPed,false)

				SetEntityAsNoLongerNeeded(targetPed)
			
			end
			--TriggerEvent('0b667689-81d3-40e8-adbe-eefa5014ffd8',message,coords.x,coords.y,coords.z)

		end
	
    return ped
end



Citizen.CreateThread(function()
	while true do
		
		local playerCoords = GetEntityCoords(PlayerPedId())
		local zclosest = 10000
		local pdistance = 10000

		for i = 1, #hlist do 
			local zdistance = #(playerCoords - hlist[i].coords)

			
			if zdistance < 20 then
				if zdistance < pdistance then
					zclosest = i
					pdistance = zdistance
				end
			end
			

		end
		distance = pdistance
		closest = zclosest
		Wait(1000)
	end
end)

local knocking = false
local robbing = false
local lastclick = 0




Citizen.CreateThread(function()
	while true do

		if IsControlJustReleased(0, 38) then
		
		--print('vector coords')
			local playerCoords = GetEntityCoords(PlayerPedId())
			--print("vector3(" ..playerCoords.x .. "," .. playerCoords.y .. "," .. playerCoords.z .." )")
			print(" {coords=vector3(" ..playerCoords.x .. "," .. playerCoords.y .. "," .. playerCoords.z .." ), heading = " .. GetEntityHeading(GetPlayerPed(-1)) .. "}  --" .. exports['hud']:location() )
			--print(" {coords=vector3(" ..playerCoords.x .. "," .. playerCoords.y .. "," .. playerCoords.z .." ), heading = " .. GetEntityHeading(GetPlayerPed(-1)) .. " ,lastime = 0  }, --" .. exports['hud']:location() )
			--print("{ coords=vector3(" ..playerCoords.x .. "," .. playerCoords.y .. "," .. playerCoords.z .." ), name= \"House, " .. exports['hud']:location() .. "\", home = false, lastrobbed = 0, p=false, class = \"L\"}," )
		end
		Wait(10)
	end
end)


Citizen.CreateThread(function()
	while true do

		if distance < 20 and robbing == false and knocking == false then
			
			if distance < 20 then
				
				DrawMarker(27, hlist[closest].coords.x, hlist[closest].coords.y, hlist[closest].coords.z - 0.95, 0, 0, 0, 0, 0, 0, 1.2, 1.2, 1.2, 255, 0, 0, 205, false, false, 2, false, false, false, false)
				if distance < 4 then
					ESX.Game.Utils.DrawText3D(vector3(hlist[closest].coords.x, hlist[closest].coords.y, hlist[closest].coords.z + 0.1), '~h~~g~[E]~s~ BREAK IN', 0.6)
					ESX.Game.Utils.DrawText3D(vector3(hlist[closest].coords.x, hlist[closest].coords.y, hlist[closest].coords.z + 0.2), '~h~~g~[U]~s~ KNOCK', 0.6)
					
					if distance  < 3 then
						if IsControlJustReleased(0, 38) then
							if ESX.GetPlayerData().job.name ~= "mcdonalds" and ESX.GetPlayerData().job.name ~= "gopostal" then
								if (GetGameTimer() - 2500) > lastclick then
									lastclick = GetGameTimer()
									--print('ROB:: now robbing this house')
									local playerCoords = GetEntityCoords(PlayerPedId())
									--print("vector3(" ..hlist[closest].coords.x .. "," .. hlist[closest].coords.y .. "," .. hlist[closest].coords.z .." )")
									TriggerServerEvent('33bc2ba1-b29b-43ee-88a3-448d6fd6b1f2', closest)
									robbing = true
								end
							end
							  
						end
						
						if IsControlJustReleased(0, 303) then
							if ESX.GetPlayerData().job.name ~= "mcdonalds" and ESX.GetPlayerData().job.name ~= "gopostal" then
								if (GetGameTimer() - 2500) > lastclick then
									lastclick = GetGameTimer()
									ESX.ShowNotification("**Knocking**")
									TriggerServerEvent('33d56da8-6c37-44a8-b5cd-c69b6fccd1e7', closest)
									--playAnim('mp_common', 'givetake1_a', 2500)
									playAnim('anim@apt_trans@buzzer', 'buzz_reg', 4500)
									Citizen.Wait(2500)
								end
							end
						end
					end
				end
			end
	
		else
			Wait(0)
		end
		Wait(0)
	end
end)


RegisterNetEvent('fc0d5258-f6d7-4d69-878d-ee4be660b600')
AddEventHandler('fc0d5258-f6d7-4d69-878d-ee4be660b600', function(number, home)
	local playerCoords = GetEntityCoords(PlayerPedId())
	targetPed = _CreatePed(pedlist[math.random(1,#pedlist)], vector3(playerCoords.x - 0.3 , playerCoords.y - 0.3, playerCoords.z + 0.2), math.random(0,300))

end)



RegisterNetEvent('091db27a-bc77-4f28-88d7-9fd4eb338519')
AddEventHandler('091db27a-bc77-4f28-88d7-9fd4eb338519', function(number, home)
	print('trigger home invasion')
  --playAnim('anim@apt_trans@buzzer', 'buzz_reg', 3500)
  playAnim('anim@apt_trans@garage', 'gar_open_1_left', 30000)
	Wait(math.random(2000,5000))
   if home == true then
		local playerCoords = GetEntityCoords(PlayerPedId())
		
		local targetPed = nil
		local targetPed1 = nil
		local targetPed2 = nil
		if home == true and math.random(1,5) > 1 then
			targetPed = _CreatePed(pedlist[math.random(1,#pedlist)], vector3(playerCoords.x - 0.3 , playerCoords.y - 0.3, playerCoords.z + 0.2), math.random(0,300))
			if math.random(1,5) == 1 then
				targetPed1 = _CreatePed(pedlist[math.random(1,#pedlist)], vector3(playerCoords.x - 0.3 , playerCoords.y - 0.3, playerCoords.z + 0.2), math.random(0,300))
				if math.random(1,6) == 1 then
					targetPed2 = _CreatePed(pedlist[math.random(1,#pedlist)], vector3(playerCoords.x - 0.3 , playerCoords.y - 0.3, playerCoords.z + 0.2), math.random(0,300))
				end
			end

		else
			if math.random(1,5) == 1 then
				_CreatePed(pedlist[math.random(1,#pedlist)], vector3(playerCoords.x - 0.3 , playerCoords.y - 0.3, playerCoords.z + 0.2), math.random(0,300))
			end
		end
		Wait(1000)
		 ClearPedTasksImmediately(GetPlayerPed(-1))
		 
		  Citizen.CreateThread(function()
			local playingtask = true
			while robbing == true do
				
				local isFreeAiming = IsPlayerFreeAiming(PlayerId())
				
				if (isFreeAiming == true or IsPedInMeleeCombat(GetPlayerPed(-1)) == true) and playingtask then
					
					playingtask = false
					ClearPedTasksImmediately(GetPlayerPed(-1))
					Wait(5000)
						
				elseif IsPedShooting(GetPlayerPed(-1)) and playingtask then
					ClearPedTasksImmediately(GetPlayerPed(-1))
					playingtask = false
					Wait(5000)
					
				elseif (IsPedInMeleeCombat(GetPlayerPed(-1)) == true or IsPlayerFreeAiming(PlayerId()) == true or IsPlayerFreeAiming(PlayerPedId()) == true) and playingtask  then

					ClearPedTasksImmediately(GetPlayerPed(-1))
					Wait(5000)
				elseif playingtask == false then
					local rv = math.random(1,3)
	
					if rv == 3 then
						ClearPedTasksImmediately(GetPlayerPed(-1))
						playAnim('anim@apt_trans@garage', 'gar_open_1_left', 60000)
					elseif rv == 2 then
						ClearPedTasksImmediately(GetPlayerPed(-1))
						playAnim('anim@heists@ornate_bank@grab_crash_heels', 'grab', 60000)
					elseif rv == 1 then
						ClearPedTasksImmediately(GetPlayerPed(-1))
						playAnim('anim@heists@planning_board@', '6_picture_action', 60000)
					end
					playingtask = true
					Citizen.CreateThread(function()
						Wait(6000)
						playingtask = false
					end)	
					--playAnim('anim@heists@ornate_bank@grab_crash_heels', 'grab', 15000)
				end

				
				if IsPedRagdoll(GetPlayerPed(-1)) then
					robbing = false
					playingtask = true
					ESX.ShowNotification("~r~You were interrupted and couldn't complete the theft.")
					if targetPed ~= nil then
						DeleteEntity(targetPed)
					end
					
					if targetPed1 ~= nil then
						DeleteEntity(targetPed1)
					end
					
					if targetPed2 ~= nil then
						DeleteEntity(targetPed2)
					end
					
				end
				Wait(50)
			end
			  
		  end)

	else
		Citizen.CreateThread(function()
			local playingtask = true
			while robbing == true do

				local isFreeAiming = IsPlayerFreeAiming(PlayerId())
				
				if (isFreeAiming == true or IsPedInMeleeCombat(GetPlayerPed(-1)) == true) and playingtask then

					playingtask = false
					ClearPedTasksImmediately(GetPlayerPed(-1))
					Wait(5000)
						
				elseif IsPedShooting(GetPlayerPed(-1)) and playingtask then
					ClearPedTasksImmediately(GetPlayerPed(-1))
					playingtask = false
					Wait(5000)
					
				elseif (IsPedInMeleeCombat(GetPlayerPed(-1)) == true or IsPlayerFreeAiming(PlayerId()) == true or IsPlayerFreeAiming(PlayerPedId()) == true) and playingtask  then
					ClearPedTasksImmediately(GetPlayerPed(-1))
					Wait(5000)
				elseif playingtask == false then
					local rv = math.random(1,3)
	
					if rv == 3 then
						ClearPedTasksImmediately(GetPlayerPed(-1))
						playAnim('anim@apt_trans@garage', 'gar_open_1_left', 60000)
					elseif rv == 2 then
						ClearPedTasksImmediately(GetPlayerPed(-1))
						playAnim('anim@heists@ornate_bank@grab_crash_heels', 'grab', 60000)
					elseif rv == 1 then
						ClearPedTasksImmediately(GetPlayerPed(-1))
						playAnim('anim@heists@planning_board@', '6_picture_action', 60000)
						
					end
					playingtask = true
					Citizen.CreateThread(function()
						Wait(6000)
						playingtask = false
					end)
					--playAnim('anim@heists@ornate_bank@grab_crash_heels', 'grab', 15000)
				end

				
				if IsPedRagdoll(GetPlayerPed(-1)) then
					robbing = false
					playingtask = true
					ESX.ShowNotification("~r~You were interrupted and couldn't complete the theft.")
				end
				Wait(50)
			end
			  
		  end)
		
   end
   


  Citizen.CreateThread(function()
		local cnumber = number
		zyccountdown = math.random(25,68)
		
		while zyccountdown > 0 do
			--ESX.ShowNotification("~o~In Progress\n~y~Remaining: ~w~" .. countdown .. "~y~ second(s)")
			Wait(1000)
			zyccountdown = zyccountdown - 1
		end
		
		if #(hlist[cnumber].coords - GetEntityCoords(PlayerPedId())) < 10.0 then
			ESX.ShowNotification("~g~Finished Ransacking the place!")
			robbing = false
			ClearPedTasksImmediately(GetPlayerPed(-1))
			TriggerServerEvent('82c4f0f7-424f-447c-b9ab-9754069c3111',cnumber)
		else
			robbing = false
			ClearPedTasksImmediately(GetPlayerPed(-1))
			ESX.ShowNotification("~r~You left the scene of the break in~w~ and didnt get anything.")
			
			ShowMPMessage("You ~r~abandoned ~w~the burglary as you went too far away!","Abandoned Burglary", 3500)
		end
  end)
  
   Citizen.CreateThread(function()
	Wait(2000)
	while zyccountdown > 0 do
		local closest = closest
		if closest ~= nil then
			ESX.Game.Utils.DrawText3D(vector3(hlist[closest].coords.x, hlist[closest].coords.y, hlist[closest].coords.z + 0.1), '~r~Burglary in Progress!', 0.8)
			ESX.Game.Utils.DrawText3D(vector3(hlist[closest].coords.x, hlist[closest].coords.y, hlist[closest].coords.z + 0.2), '~o~Time Remaining: ~b~' .. zyccountdown, 0.8)
		end
		Wait(0)
	end
 end)
end)


RegisterNetEvent('543316e3-92cd-4648-9bd9-d23e1c36a6b6')
AddEventHandler('543316e3-92cd-4648-9bd9-d23e1c36a6b6', function()
	robbing = false
	knocking = false
	ClearPedTasksImmediately(GetPlayerPed(-1))
end)

RegisterNetEvent('2d5881b6-9410-43d1-8e42-667973ce4207')
AddEventHandler('2d5881b6-9410-43d1-8e42-667973ce4207', function(title,message,timer)
	robbing = false
	knocking = false
	ClearPedTasksImmediately(GetPlayerPed(-1))
	--ShowMPMessage(message,title, timer)
end)


loadDict = function(dict)
    RequestAnimDict(dict)
    while not HasAnimDictLoaded(dict) do
        Wait(10)
    end
end

function DrawText3D(coords, text)
    local onScreen, _x, _y = World3dToScreen2d(coords.x, coords.y, coords.z)
    local pX, pY, pZ = table.unpack(GetGameplayCamCoords())
  
    SetTextScale(0.4, 0.4)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextEntry("STRING")
    SetTextCentre(1)
    SetTextColour(255, 255, 255, 255)
    SetTextOutline()
  
    AddTextComponentString(text)
    DrawText(_x, _y)
end


function ShowMPMessage(message, subtitle, ms)
	-- do this in another thread
	Citizen.CreateThread(function()
		local scaleform = RequestScaleformMovie("mp_big_message_freemode")
		while not HasScaleformMovieLoaded(scaleform) do
			Citizen.Wait(0)
		end
		
		BeginScaleformMovieMethod(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
		PushScaleformMovieMethodParameterString(message)
		PushScaleformMovieMethodParameterString(subtitle)
		PushScaleformMovieMethodParameterInt(0)
		EndScaleformMovieMethod()

		local time = GetGameTimer() + ms
        
        while(GetGameTimer() < time) do
			Citizen.Wait(0)
			DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255)
		end
	end)
end