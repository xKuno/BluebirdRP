local ESX	 = nil

-- ESX
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(200)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	ESX.PlayerData = ESX.GetPlayerData()
	
	TriggerEvent('480c190a-70b7-4118-978c-7806b934c23c', 0.0)
	ESX.UI.HUD.SetDisplay(0.0)
end)


local direction = 'N'
local startcall = false
local savevprox = 'default'
local saveprox = 8.00
local savewasincar = false
local voiceDistance = "default"
local vehicleSpeed = 0

local myPed = GetPlayerPed(-1)


local myserverid = -1

myserverid = GetPlayerServerId(PlayerId())

local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Bendigo Cove", ['PALETO'] = "Bendigo", ['PALFOR'] = "Bendigo Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "MT Thomas", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }

local Keys = {
	["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57, ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177, ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18, ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182, ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81, ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70, ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178, ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173, ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

local AllWeapons = json.decode('{"melee":{"dagger":"0x92A27487","bat":"0x958A4A8F","bottle":"0xF9E6AA4B","crowbar":"0x84BD7BFD","unarmed":"0xA2719263","flashlight":"0x8BB05FD7","golfclub":"0x440E4788","hammer":"0x4E875F73","hatchet":"0xF9DCBF2D","knuckle":"0xD8DF3C3C","knife":"0x99B507EA","machete":"0xDD5DF8D9","switchblade":"0xDFE37640","nightstick":"0x678B81B1","wrench":"0x19044EE0","battleaxe":"0xCD274149","poolcue":"0x94117305","stone_hatchet":"0x3813FC08"},"handguns":{"pistol":"0x1B06D571","pistol_mk2":"0xBFE256D4","combatpistol":"0x5EF9FEC4","appistol":"0x22D8FE39","stungun":"0x3656C8C1","pistol50":"0x99AEEB3B","snspistol":"0xBFD21232","snspistol_mk2":"0x88374054","heavypistol":"0xD205520E","vintagepistol":"0x83839C4","flaregun":"0x47757124","marksmanpistol":"0xDC4DB296","revolver":"0xC1B3C3D1","revolver_mk2":"0xCB96392F","doubleaction":"0x97EA20B8","raypistol":"0xAF3696A1"},"smg":{"microsmg":"0x13532244","smg":"0x2BE6766B","smg_mk2":"0x78A97CD0","assaultsmg":"0xEFE7E2DF","combatpdw":"0xA3D4D34","machinepistol":"0xDB1AA450","minismg":"0xBD248B55","raycarbine":"0x476BF155"},"shotguns":{"pumpshotgun":"0x1D073A89","pumpshotgun_mk2":"0x555AF99A","sawnoffshotgun":"0x7846A318","assaultshotgun":"0xE284C527","bullpupshotgun":"0x9D61E50F","musket":"0xA89CB99E","heavyshotgun":"0x3AABBBAA","dbshotgun":"0xEF951FBB","autoshotgun":"0x12E82D3D"},"assault_rifles":{"assaultrifle":"0xBFEFFF6D","assaultrifle_mk2":"0x394F415C","carbinerifle":"0x83BF0278","carbinerifle_mk2":"0xFAD1F1C9","advancedrifle":"0xAF113F99","specialcarbine":"0xC0A3098D","specialcarbine_mk2":"0x969C3D67","bullpuprifle":"0x7F229F94","bullpuprifle_mk2":"0x84D6FAFD","compactrifle":"0x624FE830"},"machine_guns":{"mg":"0x9D07F764","combatmg":"0x7FD62962","combatmg_mk2":"0xDBBD7280","gusenberg":"0x61012683"},"sniper_rifles":{"sniperrifle":"0x5FC3C11","heavysniper":"0xC472FE2","heavysniper_mk2":"0xA914799","marksmanrifle":"0xC734385A","marksmanrifle_mk2":"0x6A6C02E0"},"heavy_weapons":{"rpg":"0xB1CA77B1","grenadelauncher":"0xA284510B","grenadelauncher_smoke":"0x4DD2DC56","minigun":"0x42BF8A85","firework":"0x7F7497E5","railgun":"0x6D544C99","hominglauncher":"0x63AB0442","compactlauncher":"0x781FE4A","rayminigun":"0xB62D1F67"},"throwables":{"grenade":"0x93E220BD","bzgas":"0xA0973D5E","smokegrenade":"0xFDBC8A50","flare":"0x497FACC3","molotov":"0x24B17070","stickybomb":"0x2C3731D9","proxmine":"0xAB564B93","snowball":"0x787F0BB","pipebomb":"0xBA45E8B8","ball":"0x23C9F95C"},"misc":{"petrolcan":"0x34A67B97","fireextinguisher":"0x60EC506","parachute":"0xFBAB5776","pbg":"0x18EF0FB5"}}')


local AllWeaponsR = {}

--Generate Table of hashes
for key,value in pairs(AllWeapons) do
	for keyTwo,valueTwo in pairs(AllWeapons[key]) do
		local key = GetHashKey('weapon_'..keyTwo)
		AllWeaponsR[tostring(key)] = keyTwo
	end
end

local directions = { [0] = 'N', [45] = 'NW', [90] = 'W', [135] = 'SW', [180] = 'S', [225] = 'SE', [270] = 'E', [315] = 'NE', [360] = 'N', } 


local vehiclesCars = {0,1,2,3,4,5,6,7,8,9,10,11,12,17,18,19,20};

local vehicle = 0
local vehicleClass = 0




-- Hides TREW UI when it's on Pause Menu
Citizen.CreateThread(function()

    local isPauseMenu = false
	local timer1 = 0
	while true do
		Citizen.Wait(0)

		if IsPauseMenuActive() then -- ESC Key
			if not isPauseMenu then
				isPauseMenu = not isPauseMenu
				SendNUIMessage({ action = 'toggleUi', value = false })
				
			end

			timer1 = 0
		elseif timer1 < 500 then
		
			if isPauseMenu then
				isPauseMenu = not isPauseMenu
				SendNUIMessage({ action = 'toggleUi', value = true })
				
			end
			timer1 = timer1 + 1
			HideHudComponentThisFrame(1)  -- Wanted Stars
			HideHudComponentThisFrame(2)  -- Weapon Icon
			HideHudComponentThisFrame(3)  -- Cash
			HideHudComponentThisFrame(4)  -- MP Cash
			HideHudComponentThisFrame(6)  -- Vehicle Name
			HideHudComponentThisFrame(7)  -- Area Name
			HideHudComponentThisFrame(8)  -- Vehicle Class
			HideHudComponentThisFrame(9)  -- Street Name
			HideHudComponentThisFrame(13) -- Cash Change
			HideHudComponentThisFrame(17) -- Save Game
			HideHudComponentThisFrame(20) -- Weapon Stats
		else

			Wait(2000)
		end
		return

	end
end)

RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(xPlayer)
	ESX.PlayerData = xPlayer
	myserverid = GetPlayerServerId(PlayerId())
	PlayerLoaded = true
	updatesetinfo()
end)





-- Date and time update
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		if Config.ui.showDate == true then
			SendNUIMessage({ action = 'setText', id = 'date', value = trewDate() })
		end
	end
end)


NetworkClearVoiceChannel()

AddEventHandler('bf284452-c977-42d3-9ea0-4d13dc11911c', function(xPlayer) 
	NetworkClearVoiceChannel()
end)





RegisterNetEvent('9349cc9b-8dd8-4e46-8594-def9c70055aa')
AddEventHandler('9349cc9b-8dd8-4e46-8594-def9c70055aa', function() 
	if not startcall then
		print('loud hailer fired')
		exports["mumble-voip"]:SetVoiceRange(4)
	end
end)


RegisterNetEvent('5e85d88f-4d63-44e3-9828-388a02e75a73')
AddEventHandler('5e85d88f-4d63-44e3-9828-388a02e75a73', function() 
	ExecuteCommand("hud")
end)

-- Location update
Citizen.CreateThread(function()
	while ESX == nil do
		Citizen.Wait(200)
	end
	while true do
		Citizen.Wait(1000)

		local player = myPed

		local position = myCurrentCoords

		for k,v in pairs(directions)do
			directionH = GetEntityHeading(myPed)
			if(math.abs(directionH - k) < 22.5)then
				directionH = v
				direction = v
				break;
			end
			
		end
		
		if Config.ui.showLocation == true then
			local zoneNameFull = zones[GetNameOfZone(position.x, position.y, position.z)]
			local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(position.x, position.y, position.z))

			local locationMessage = nil

			if zoneNameFull then 
				locationMessage = streetName .. ', ' .. zoneNameFull
			else
				locationMessage = streetName
			end

			locationMessage = string.format(
				Locales[Config.Locale]['you_are_on_location'],
				locationMessage
			)

			SendNUIMessage({ action = 'setText', id = 'location', value = '<b>['.. direction .. '] </b>' .. locationMessage })
		end
		

	end
end)


function location()

			local player = myPed
			local position = myCurrentCoords
			local zoneNameFull = zones[GetNameOfZone(position.x, position.y, position.z)]
			local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(position.x, position.y, position.z))

			local locationMessage = nil

			if zoneNameFull then 
				locationMessage = streetName .. ', ' .. zoneNameFull
			else
				locationMessage = streetName
			end
		return locationMessage

end

function streetc()

		local player = GetPlayerPed(-1)
		local position = GetEntityCoords(player)
		local zoneNameFull = zones[GetNameOfZone(position.x, position.y, position.z)]
		local streetName = GetStreetNameFromHashKey(GetStreetNameAtCoord(position.x, position.y, position.z))

		return streetName
end




-- Vehicle Info
local vehicleCruiser
local vehicleSignalIndicator = 'off'
local seatbeltEjectSpeed = 45.0 
local seatbeltEjectAccel = 100.0
local seatbeltIsOn = false
local currSpeed = 0.0
local prevVelocity = {x = 0.0, y = 0.0, z = 0.0}

Citizen.CreateThread(function()
	while ESX == nil do
		Citizen.Wait(200)
	end
	while true do

		Citizen.Wait(800)
		vehicleIsOn = GetIsVehicleEngineRunning(vehicle)
		vehicleClass = GetVehicleClass(vehicle)
		local vehicleInfo

		if vehicle ~= nil and vehicle ~= 0 and vehicleIsOn then
			local odo = 0.0
					
			-- Vehicle Fuel and Gear
			local vehicleFuel
			local vehicleOil
			vehicleFuel = GetVehicleFuelLevel(vehicle)
			vehicleOil = GetVehicleOilLevel(vehicle)

			local vehicleGear = GetVehicleCurrentGear(vehicle)

			if (vehicleSpeed == 0 and vehicleGear == 0) or (vehicleSpeed == 0 and vehicleGear == 1) then
				vehicleGear = 'N'
			elseif vehicleSpeed > 0 and vehicleGear == 0 then
				vehicleGear = 'R'
			end

			-- Vehicle Lights
			local vehicleVal,vehicleLights,vehicleHighlights  = GetVehicleLightsState(vehicle)
			local vehicleIsLightsOn
			if vehicleLights == 1 and vehicleHighlights == 0 then
				vehicleIsLightsOn = 'normal'
			elseif (vehicleLights == 1 and vehicleHighlights == 1) or (vehicleLights == 0 and vehicleHighlights == 1) then
				vehicleIsLightsOn = 'high'
			else
				vehicleIsLightsOn = 'off'
			end


			-- Vehicle Siren
			local vehicleSiren

			if IsVehicleSirenOn(vehicle) then
				vehicleSiren = true
			else
				vehicleSiren = false
			end
			
			
			local zstatus, zerrorMsg = pcall(function() odo = exports.esx_oilchange:GetVehicleMileage() end)
			
			vehicleInfo = {
				action = 'updateVehicle',

				status = true,
				gear = vehicleGear,
				fuel = vehicleFuel,
				oil = vehicleOil,
				odo = odo,
				lights = vehicleIsLightsOn,
				cruiser = vehicleCruiser,
				siren = vehicleSiren,
				
				seatbelt = {},
				
			}
			vehicleInfo['seatbelt']['status'] = seatbeltIsOn
			SendNUIMessage(vehicleInfo)
		else
			Wait(1000)
		end
	end
end)

Citizen.CreateThread(function()
	while true do
		if vehicle ~= 0 and vehicleSpeed < 4 then
			SetVehicleBrakeLights(vehicle, true)
		else
			Wait(300)
		end
		Wait(0)
	end
end)

Citizen.CreateThread(function()
	while ESX == nil do
		Citizen.Wait(200)
	end
	while true do

		Citizen.Wait(150)

		local vehicleInfo

		if vehicle ~= nil and vehicle ~= 0 and vehicleIsOn then
			
			local player = myPed
			local position = myCurrentCoords



			if Config.ui.showMinimap == false then
				DisplayRadar(true)
			end

			-- Vehicle Speed
			local vehicleSpeedSource = GetEntitySpeed(vehicle)
			
			if Config.vehicle.speedUnit == 'MPH' then
				vehicleSpeed = math.ceil(vehicleSpeedSource * 2.237)
			else
				vehicleSpeed = math.ceil(vehicleSpeedSource * 3.6)
			end


			-- Vehicle Gradient Speed
			local vehicleNailSpeed

			if vehicleSpeed > Config.vehicle.maxSpeed then
				vehicleNailSpeed = math.ceil(  280 - math.ceil( math.ceil(Config.vehicle.maxSpeed * 205) / Config.vehicle.maxSpeed) )
			else
				vehicleNailSpeed = math.ceil(  280 - math.ceil( math.ceil(vehicleSpeed * 205) / Config.vehicle.maxSpeed) )
			end

			

			-- Vehicle Seatbelt
			if vehicleClass and has_value(vehiclesCars, vehicleClass) == true and vehicleClass ~= 8 then

				local prevSpeed = currSpeed
                currSpeed = vehicleSpeedSource

                SetPedConfigFlag(PlayerPedId(), 32, true)

                if not seatbeltIsOn then
                	local vehIsMovingFwd = GetEntitySpeedVector(vehicle, true).y > 1.0
                    local vehAcc = (prevSpeed - currSpeed) / GetFrameTime()
                    if (vehIsMovingFwd and (prevSpeed > (seatbeltEjectSpeed/2.237)) and (vehAcc > (seatbeltEjectAccel*9.81))) then

                        SetEntityCoords(player, position.x, position.y, position.z - 0.47, true, true, true)
                        SetEntityVelocity(player, prevVelocity.x, prevVelocity.y, prevVelocity.z)
                        SetPedToRagdoll(player, 1000, 1000, 0, 0, 0, 0)
                    else
                        -- Update previous velocity for ejecting player
                        prevVelocity = GetEntityVelocity(vehicle)
                    end

                else

                	DisableControlAction(0, 75)

                end

			end


			if vehicleClass == 0 then
				vehicleClass = 1
			end


			vehicleInfo = {
				action = 'updateVehicle',

				status = true,
				speed = vehicleSpeed,
				nail = vehicleNailSpeed,
				cruiser = vehicleCruiser,
				signals = vehicleSignalIndicator,
				type = vehicleClass,
		

				config = {
					speedUnit = Config.vehicle.speedUnit,
					maxSpeed = Config.vehicle.maxSpeed
				}
			}
			
			if vehicle ~= 0 then
			
				if  (has_value(vehiclesCars, vehicleClass) == true and vehicleClass ~= 8) then
					TriggerEvent('68c70830-177a-40e1-b1a0-c604e9ffdd02',seatbeltIsOn)
				end
			end
		
			SendNUIMessage(vehicleInfo)
		else

			
			vehicleCruiser = false
			vehicleNailSpeed = 0
			--vehicleSignalIndicator = 'off'

            seatbeltIsOn = false
			if vehicle ~= 0 then
			
				if  (has_value(vehiclesCars, vehicleClass) == true and vehicleClass ~= 8) then
					TriggerEvent('68c70830-177a-40e1-b1a0-c604e9ffdd02',true)
				end
			end
			

			vehicleInfo = {
				action = 'updateVehicle',

				status = false,
				nail = vehicleNailSpeed,
				seatbelt = { status = seatbeltIsOn },
				cruiser = vehicleCruiser,
				type = 0,
			}

			if Config.ui.showMinimap == false then
				DisplayRadar(false)
				
			end
			SendNUIMessage(vehicleInfo)
			Wait(1000)

		end

		




	end
end)

local networkchannel = 0
local changednetworkchannel = 0

Citizen.CreateThread(function()
  while ESX == nil do
    Citizen.Wait(150)
  end
  while true do
	pcall(function()
		myPed = ESX.Game.GetMyPed()
		myCurrentCoords = ESX.Game.GetMyPedLocation()
		vehicle = ESX.Game.GetVehiclePedIsIn()
	end)
	Wait(900)
  end
end)

-- Player status
Citizen.CreateThread(function()
	while ESX == nil do
		Citizen.Wait(200)
	end
	while true do
		Citizen.Wait(1000)


		local playerStatus 
		local showPlayerStatus = 0
		playerStatus = { action = 'setStatus', status = {} }
		local playerPed = myPed
		
		

		if Config.ui.showHealth == true then
			showPlayerStatus = (showPlayerStatus+1)

			playerStatus['isdead'] = false

			playerStatus['status'][showPlayerStatus] = {
				name = 'health',
				value = GetEntityHealth(playerPed) - 100
			}

			if IsEntityDead(playerPed) or IsPedRagdoll(playerPed) then
				playerStatus.isdead = true
			end
		end

		if Config.ui.showArmor == true then
			showPlayerStatus = (showPlayerStatus+1)

			playerStatus['status'][showPlayerStatus] = {
				name = 'armor',
				value = GetPedArmour(playerPed),
			}
		end

		if Config.ui.showStamina == true then
			showPlayerStatus = (showPlayerStatus+1)

			playerStatus['status'][showPlayerStatus] = {
				name = 'stamina',
				value = 100 - GetPlayerSprintStaminaRemaining(PlayerId()),
			}
		end

	

		if showPlayerStatus > 0 then
			SendNUIMessage(playerStatus)
		end

	end
end)

Citizen.CreateThread(function()

	while true do
		Citizen.Wait(5000)
		updatesetinfo()
		--TriggerServerEvent('7e05f336-b104-4331-8f84-edad598fe9ab')
	end
end)

RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function(job)
		ESX.PlayerData.job = job
		updatesetinfo()
		Wait(1000)
		ESX.PlayerData = ESX.GetPlayerData()
		Wait(100)
		updatesetinfo()


end)





function updatesetinfo()

	if ESX.PlayerData.job ~= nil then

			local job =  ""
			if ESX.PlayerData.job.label == ESX.PlayerData.job.grade_label then
				job = ESX.PlayerData.job.grade_label
			else
				job = ESX.PlayerData.job.label .. ': ' .. ESX.PlayerData.job.grade_label
			end

			SendNUIMessage({ action = 'setText', id = 'job', value = job })

			
				if ESX.PlayerData.job.grade_name ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
					if (Config.ui.showSocietyMoney == true) then
						SendNUIMessage({ action = 'element', task = 'enable', value = 'society' })
					end
					--ESX.TriggerServerCallback('5c97be37-a7f0-4052-b4ca-5126beadc6be', function(money)
					--	SendNUIMessage({ action = 'setMoney', id = 'society', value = money })
					--end, ESX.PlayerData.job.name)
				else
					SendNUIMessage({ action = 'element', task = 'disable', value = 'society' })
				end

		end

		local playerStatus 
		local showPlayerStatus = 0
		playerStatus = { action = 'setStatus', status = {} }


		if Config.ui.showHunger == true then
			showPlayerStatus = (showPlayerStatus+1)
			
			TriggerEvent('96cc2e86-0b6a-4092-b5c5-9d8057130449', 'hunger', function(status)
				playerStatus['status'][showPlayerStatus] = {
					name = 'hunger',
					value = math.floor(100-status.getPercent())
				}
			end)

		end

		if Config.ui.showThirst == true then
			showPlayerStatus = (showPlayerStatus+1)

			TriggerEvent('96cc2e86-0b6a-4092-b5c5-9d8057130449', 'thirst', function(status)
				playerStatus['status'][showPlayerStatus] = {
					name = 'thirst',
					value = math.floor(100-status.getPercent())
				}
			end)
		end

		if showPlayerStatus > 0 then
			SendNUIMessage(playerStatus)
		end

end



-- Overall Info
RegisterNetEvent('0029c1c6-594f-4835-a343-6f1eb3a99e82')
AddEventHandler('0029c1c6-594f-4835-a343-6f1eb3a99e82', function(info)

	SendNUIMessage({ action = 'setText', id = 'job', value = info['job'] })
	--SendNUIMessage({ action = 'setMoney', id = 'wallet', value = info['money'] })
	--SendNUIMessage({ action = 'setMoney', id = 'bank', value = info['bankMoney'] })
	--SendNUIMessage({ action = 'setMoney', id = 'blackMoney', value = info['blackMoney'] })

	TriggerEvent('esx:getSharedObject', function(obj)
		ESX = obj
		ESX.PlayerData = ESX.GetPlayerData()
	end)

	if ESX.PlayerData.job ~= nil then
		if ESX.PlayerData.job.grade_name ~= nil and ESX.PlayerData.job.grade_name == 'boss' then
			if (Config.ui.showSocietyMoney == true) then
				SendNUIMessage({ action = 'element', task = 'enable', value = 'society' })
			end
			--ESX.TriggerServerCallback('5c97be37-a7f0-4052-b4ca-5126beadc6be', function(money)
			--	SendNUIMessage({ action = 'setMoney', id = 'society', value = money })
			--end, ESX.PlayerData.job.name)
		else
			SendNUIMessage({ action = 'element', task = 'disable', value = 'society' })
		end
	end

	local playerStatus 
	local showPlayerStatus = 0
	playerStatus = { action = 'setStatus', status = {} }


	if Config.ui.showHunger == true then
		showPlayerStatus = (showPlayerStatus+1)
		
		TriggerEvent('96cc2e86-0b6a-4092-b5c5-9d8057130449', 'hunger', function(status)
			playerStatus['status'][showPlayerStatus] = {
				name = 'hunger',
				value = math.floor(100-status.getPercent())
			}
		end)

	end

	if Config.ui.showThirst == true then
		showPlayerStatus = (showPlayerStatus+1)

		TriggerEvent('96cc2e86-0b6a-4092-b5c5-9d8057130449', 'thirst', function(status)
			playerStatus['status'][showPlayerStatus] = {
				name = 'thirst',
				value = math.floor(100-status.getPercent())
			}
		end)
	end

	if showPlayerStatus > 0 then
		SendNUIMessage(playerStatus)
	end


end)


-- Voice detection and distance
Citizen.CreateThread(function()

	if Config.ui.showVoice == true then

	    RequestAnimDict('facials@gen_male@variations@normal')
	    RequestAnimDict('mp_facial')

	    while true do
	        Citizen.Wait(500)
	        local playerID = PlayerId()

	        for _,player in ipairs(GetActivePlayers()) do
	            local boolTalking = NetworkIsPlayerTalking(player)

	            if player ~= playerID then
	                if boolTalking then
	                    PlayFacialAnim(GetPlayerPed(player), 'mic_chatter', 'mp_facial')
	                elseif not boolTalking then
	                    PlayFacialAnim(GetPlayerPed(player), 'mood_normal_1', 'facials@gen_male@variations@normal')
	                end
	            end
				Wait(20)
	        end
	    end

	end
end)

local supresschange = false
local ispedinveh = false
Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1500)
			local vpedincar = vehicle

			if vpedincar > 0 and ispedinveh == false then
				ispedinveh = true --ped got in car
				supresschange = true
				exports["mumble-voip"]:SetVoiceRange(2)
				Citizen.CreateThread(function()
					Wait(2000)
					supresschange = false
				end)
			elseif vpedincar == 0 and ispedinveh == true then
				ispedinveh = false --ped got out of car
				supresschange = true
				exports["mumble-voip"]:SetVoiceRange(2)
				Citizen.CreateThread(function()
					Wait(2000)
					supresschange = false
				end)
			end
		end
end)

--[[
Citizen.CreateThread(function()
	if Config.ui.showVoice == true and Config.oldvoice == true then

		local isTalking = false
		voiceDistance = nil

		while true do
			Citizen.Wait(8)

			if NetworkIsPlayerTalking(PlayerId()) and not isTalking then 
				isTalking = not isTalking
				SendNUIMessage({ action = 'isTalking', value = isTalking })
			elseif not NetworkIsPlayerTalking(PlayerId()) and isTalking then 
				isTalking = not isTalking
				SendNUIMessage({ action = 'isTalking', value = isTalking })
			end
			
			

			DisableControlAction(1, 82, true)
			if(GetLastInputMethod(0)) then
				if IsDisabledControlJustPressed(1, Keys[Config.voice.keys.distance]) and startcall == false then

					Config.voice.levels.current = (Config.voice.levels.current + 1) % 4
		
					if Config.voice.levels.current == 0 then
						NetworkSetTalkerProximity(Config.voice.levels.default)
						voiceDistance = 'normal'
					elseif Config.voice.levels.current == 1 then
						NetworkSetTalkerProximity(Config.voice.levels.shout)
						voiceDistance = 'shout'
					elseif Config.voice.levels.current == 3 and IsPedInAnyVehicle(GetPlayerPed(-1)) then
						NetworkSetTalkerProximity(Config.voice.levels.car)
						voiceDistance = 'car'
					elseif Config.voice.levels.current == 2 then
						NetworkSetTalkerProximity(Config.voice.levels.whisper)
						voiceDistance = 'whisper'
					end

					SendNUIMessage({ action = 'setVoiceDistance', value = voiceDistance })
					
				local posPlayer = GetEntityCoords(GetPlayerPed(-1))
				local proxc = NetworkGetTalkerProximity()
				DrawMarker(1, posPlayer.x, posPlayer.y, posPlayer.z - 1, 0, 0, 0, 0, 0, 0,proxc * 2, proxc* 2, 0.8001, 0, 75, 255, 165, 0,0, 0,0)
				end
			end

			if Config.voice.levels.current == 0 then
				voiceDistance = 'normal'
			elseif Config.voice.levels.current == 1 then
				voiceDistance = 'shout'
			elseif Config.voice.levels.current == 2 then
				voiceDistance = 'whisper'
			elseif Config.voice.levels.current == 3 then
				voiceDistance = 'car'
			end
		end
	end
end)

--]]

function section(status,numberc)
	if status == "Normal" then
		voiceDistance = 'normal'
		SendNUIMessage({ action = 'setVoiceDistance', value = voiceDistance })
	elseif status == "Shouting" then
		voiceDistance = 'shout'
		SendNUIMessage({ action = 'setVoiceDistance', value = voiceDistance })
	elseif status == "Whisper" then
		voiceDistance = 'whisper'
		SendNUIMessage({ action = 'setVoiceDistance', value = voiceDistance })
	elseif status == "Conversation" then
		voiceDistance = 'conversation'
		SendNUIMessage({ action = 'setVoiceDistance', value = voiceDistance })
		
	elseif status == "Public Address" then
		voiceDistance = 'pa'
		SendNUIMessage({ action = 'setVoiceDistance', value = voiceDistance })
	end
	if supresschange == false then
		local posPlayer = GetEntityCoords(GetPlayerPed(-1))
		DrawMarker(1, posPlayer.x, posPlayer.y, posPlayer.z - 1, 0, 0, 0, 0, 0, 0,numberc * 2, numberc* 2, 0.8001, 0, 75, 255, 165, 0,0, 0,0)
	end
				
end



local weaponshashes = {}


-- Weapons
Citizen.CreateThread(function()
	if Config.ui.showWeapons == true then
	
		while true do
			Citizen.Wait(1000)

			local player = GetPlayerPed(-1)
			local status = {}

			if IsPedArmed(player, 7) then

				local weapon = GetSelectedPedWeapon(player)
				local ammoTotal = GetAmmoInPedWeapon(player,weapon)
				local bool,ammoClip = GetAmmoInClip(player,weapon)
				local ammoRemaining = math.floor(ammoTotal - ammoClip)
				
				status['armed'] = true

				if AllWeaponsR[tostring(weapon)] ~= nil then
			
							status['weapon'] = AllWeaponsR[tostring(weapon)] 


							if AllWeaponsR[tostring(weapon)] == 'melee' then
								SendNUIMessage({ action = 'element', task = 'disable', value = 'weapon_bullets' })
								SendNUIMessage({ action = 'element', task = 'disable', value = 'bullets' })
							else
								if AllWeaponsR[tostring(weapon)]  == 'stungun' then
									SendNUIMessage({ action = 'element', task = 'disable', value = 'weapon_bullets' })
									SendNUIMessage({ action = 'element', task = 'disable', value = 'bullets' })
								else
									SendNUIMessage({ action = 'element', task = 'enable', value = 'weapon_bullets' })
									SendNUIMessage({ action = 'element', task = 'enable', value = 'bullets' })
								end
							end
				end
				

				SendNUIMessage({ action = 'setText', id = 'weapon_clip', value = ammoClip })
				SendNUIMessage({ action = 'setText', id = 'weapon_ammo', value = ammoRemaining })

			else
				status['armed'] = false	
			end

			SendNUIMessage({ action = 'updateWeapon', status = status })

		end
	end
end)


RegisterNetEvent('ad6ce06c-44fb-4df6-8743-559fcbfc565a')
AddEventHandler('ad6ce06c-44fb-4df6-8743-559fcbfc565a', function(job)
	seatbeltIsOn = not seatbeltIsOn

end)


-- Everything that neededs to be at WAIT 0
Citizen.CreateThread(function()

	while true do
		Citizen.Wait(10)

		local player = myPed


		-- Vehicle Seatbelt
		if vehicle ~= nil and vehicle == 0 then
			Wait(1300)
		else
			if(GetLastInputMethod(0)) then
				if vehicle ~= 0 and vehicleClass ~= 0 then
				
					if IsControlJustReleased(0, Keys[Config.vehicle.keys.seatbelt]) and IsControlPressed(0, Keys['LEFTSHIFT']) == false and (has_value(vehiclesCars, vehicleClass) == true and vehicleClass ~= 8) then
						seatbeltIsOn = not seatbeltIsOn
					end
				
				end
		
			-- Vehicle Cruiser
			--[[
				if IsControlJustPressed(1, Keys[Config.vehicle.keys.cruiser]) and GetPedInVehicleSeat(vehicle, -1) == player and (has_value(vehiclesCars, vehicleClass) == true) then
					
					local vehicleSpeedSource = GetEntitySpeed(vehicle)

					if vehicleCruiser == 'on' then
						vehicleCruiser = 'off'
						SetEntityMaxSpeed(vehicle, GetVehicleHandlingFloat(vehicle,"CHandlingData","fInitialDriveMaxFlatVel"))
						
					else
						vehicleCruiser = 'on'
						SetEntityMaxSpeed(vehicle, vehicleSpeedSource)
					end
				end--]]
				if GetVehicleIndicatorLights == 0 then
					TriggerEvent('9148ba05-1b42-46bb-a076-78563e921fee', "off")
					vehicleSignalIndicator = "off"
				end

				
							-- Vehicle Signal Lights
				if IsControlJustPressed(1, Keys[Config.vehicle.keys.signalLeft]) and (has_value(vehiclesCars, vehicleClass) == true) then
				
					local seatd =  GetPedInVehicleSeat(vehicle,-1)
					local seatp = GetPedInVehicleSeat(vehicle,0)
					local myped = myPed
					if seatd ~= nil and seatd == myped then
						--[[if vehicleSignalIndicator == 'off' then
							vehicleSignalIndicator = 'left'
						else
							vehicleSignalIndicator = 'off'
						end--]]
						if GetVehicleIndicatorLights(vehicle) == 0 then
							vehicleSignalIndicator = 'left'
						else
							vehicleSignalIndicator = 'off'
						end
						TriggerEvent('9148ba05-1b42-46bb-a076-78563e921fee', vehicleSignalIndicator)
					end
				end

				if IsControlJustPressed(1, Keys[Config.vehicle.keys.signalRight]) and (has_value(vehiclesCars, vehicleClass) == true) then
					local seatd =  GetPedInVehicleSeat(vehicle,-1)
					local myped = myPed
					
					if seatd ~= nil and seatd == myped then

						if GetVehicleIndicatorLights(vehicle) == 0 then
							vehicleSignalIndicator = 'right'
						else
							vehicleSignalIndicator = 'off'
						end
						TriggerEvent('9148ba05-1b42-46bb-a076-78563e921fee', vehicleSignalIndicator)
					end
				end

				if IsControlPressed(1, 201) and IsControlJustPressed(1, 173) and (has_value(vehiclesCars, vehicleClass) == true) then
				
					local seatd =  GetPedInVehicleSeat(vehicle,-1)
					local seatp = GetPedInVehicleSeat(vehicle,0)
					local myped = myPed
					
					
					
					if seatd ~= nil and seatd == myped then

						if GetVehicleIndicatorLights(vehicle) == 0 then
							vehicleSignalIndicator = 'both'
						else
							vehicleSignalIndicator = 'off'
						end
						TriggerEvent('9148ba05-1b42-46bb-a076-78563e921fee', vehicleSignalIndicator)
					end
				end

			end
		end

	end
end)




AddEventHandler('onClientMapStart', function()

	SendNUIMessage({ action = 'ui', config = Config.ui })
	SendNUIMessage({ action = 'setFont', url = Config.font.url, name = Config.font.name })
	SendNUIMessage({ action = 'setLogo', value = Config.serverLogo })
	
	if Config.ui.showVoice == true and Config.oldvoice == true then
		if Config.voice.levels.current == 0 then
			NetworkSetTalkerProximity(Config.voice.levels.default)
		elseif Config.voice.levels.current == 1 then
			NetworkSetTalkerProximity(Config.voice.levels.shout)
		elseif Config.voice.levels.current == 2 then
			NetworkSetTalkerProximity(Config.voice.levels.whisper)
		end
	end
end)

AddEventHandler('880c0a93-b305-46b3-b84c-a120fee9e841', function()
	if Config.ui.showVoice == true then
	    NetworkSetTalkerProximity(5.0)
	end

	HideHudComponentThisFrame(7) -- Area
	HideHudComponentThisFrame(9) -- Street
	HideHudComponentThisFrame(6) -- Vehicle
	HideHudComponentThisFrame(3) -- SP Cash
	HideHudComponentThisFrame(4) -- MP Cash
	HideHudComponentThisFrame(13) -- Cash changes!
end)


--fas fa-mobile-alt
--fas fa-microphone-alt

AddEventHandler('9148ba05-1b42-46bb-a076-78563e921fee', function(status)

	local driver = GetVehiclePedIsIn(myPed, false)
	local hasTrailer,vehicleTrailer = GetVehicleTrailerVehicle(driver,vehicleTrailer)
	local leftLight
	local rightLight
	--print('status')
	--print(status)

	if status == 'left' then
		leftLight = false
		rightLight = true
		if hasTrailer then driver = vehicleTrailer end

	elseif status == 'right' then
		leftLight = true
		rightLight = false
		if hasTrailer then driver = vehicleTrailer end

	elseif status == 'both' then
		leftLight = true
		rightLight = true
		if hasTrailer then driver = vehicleTrailer end

	else
		leftLight = false
		rightLight = false
		if hasTrailer then driver = vehicleTrailer end

	end

	TriggerServerEvent('9de55649-f9ec-48c1-8ceb-d1910f089bb5', status)

	SetVehicleIndicatorLights(driver, 0, leftLight)
	SetVehicleIndicatorLights(driver, 1, rightLight)
end)



RegisterNetEvent('dca97d44-ff7e-4fc3-b75c-62f0efe2f2bd')
AddEventHandler('dca97d44-ff7e-4fc3-b75c-62f0efe2f2bd', function(driver, status)

	local playerserverid = GetPlayerFromServerId(driver)
	if playerserverid ~= PlayerId() and playerserverid ~= -1 then
		if myserverid ~= driver then
			local driver = GetVehiclePedIsIn(GetPlayerPed(playerserverid), false)


			if status == 'left' then
				leftLight = false
				rightLight = true

			elseif status == 'right' then
				leftLight = true
				rightLight = false

			elseif status == 'both' then
				leftLight = true
				rightLight = true

			else
				leftLight = false
				rightLight = false
			end

			SetVehicleIndicatorLights(driver, 0, leftLight)
			SetVehicleIndicatorLights(driver, 1, rightLight)
			end
	end
end)




function trewDate()
	local timeString = nil
	local day = _U('day_' .. GetClockDayOfMonth())
	local weekDay = _U('weekDay_' .. GetClockDayOfWeek())
	local month = _U('month_' .. GetClockMonth())
	local day = _U('day_' .. GetClockDayOfMonth())
	local year = GetClockYear()


	local hour = GetClockHours()
	local minutes = GetClockMinutes()
	local time = nil
	local AmPm = ''


	if Config.date.AmPm == true then

		if hour >= 13 and hour <= 24 then
			hour = hour - 12
			AmPm = 'PM'
		else
			if hour == 0 or hour == 24 then
				hour = 12
			end
			AmPm = 'AM'
		end

	end

	if hour <= 9 then
		hour = '0' .. hour
	end
	if minutes <= 9 then
		minutes = '0' .. minutes
	end

	time = hour .. ':' .. minutes .. ' ' .. AmPm




	local date_format = Locales[Config.Locale]['date_format'][Config.date.format]

	if Config.date.format == 'default' then
		timeString = string.format(
			date_format,
			day, month, year
		)
	elseif Config.date.format == 'simple' then
		timeString = string.format(
			date_format,
			day, month
	)
	elseif Config.date.format == 'simpleWithHours' then
		timeString = string.format(
			date_format,
			time, day, month
		)	
	elseif Config.date.format == 'withWeekday' then
		timeString = string.format(
			date_format,
			weekDay, day, month, year
		)
	elseif Config.date.format == 'withHours' then
		timeString = string.format(
			date_format,
			time, day, month, year
		)
	elseif Config.date.format == 'withWeekdayAndHours' then
		timeString = string.format(
			date_format,
			time, weekDay, day, month, year
		)
	end


	

	return timeString
end






function has_value(tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end

    return false
end


local toggleui = false
RegisterCommand('hud', function()
	if  toggleui == false then
	
		SendNUIMessage({ action = 'toggleUi', value = true })
		toggleui = true
	--[[
		SendNUIMessage({ action = 'element', task = 'disable', value = 'job' })
		SendNUIMessage({ action = 'element', task = 'disable', value = 'society' })
		SendNUIMessage({ action = 'element', task = 'disable', value = 'bank' })
		SendNUIMessage({ action = 'element', task = 'disable', value = 'blackMoney' })
		SendNUIMessage({ action = 'element', task = 'disable', value = 'wallet' })
		SendNUIMessage({ action = 'element', task = 'disable', value = 'hunger' })
		SendNUIMessage({ action = 'element', task = 'disable', value = 'thirst' })
		SendNUIMessage({ action = 'element', task = 'disable', value = 'armour' })  --]]
	else
	--[[
		if (Config.ui.showJob == true) then
			SendNUIMessage({ action = 'element', task = 'enable', value = 'job' })
		end
		if (Config.ui.showSocietyMoney == true) then
			SendNUIMessage({ action = 'element', task = 'enable', value = 'society' })
		end
		if (Config.ui.showBankMoney == true) then
			SendNUIMessage({ action = 'element', task = 'enable', value = 'bank' })
		end
		if (Config.ui.showBlackMoney == true) then
			SendNUIMessage({ action = 'element', task = 'enable', value = 'blackMoney' })
		end
		if (Config.ui.showWalletMoney == true) then
			SendNUIMessage({ action = 'element', task = 'enable', value = 'wallet' })
		end--]]
		
		SendNUIMessage({ action = 'toggleUi', value = false })
		toggleui = false
	end

end)

RegisterNetEvent('2e36f88d-4f53-4c92-b71a-fe71920fb9c2')
AddEventHandler('2e36f88d-4f53-4c92-b71a-fe71920fb9c2', function(show)
	
	if  show == false then
	
		SendNUIMessage({ action = 'toggleUi', value = false })
		toggleui = false
	--[[
		SendNUIMessage({ action = 'element', task = 'disable', value = 'job' })
		SendNUIMessage({ action = 'element', task = 'disable', value = 'society' })
		SendNUIMessage({ action = 'element', task = 'disable', value = 'bank' })
		SendNUIMessage({ action = 'element', task = 'disable', value = 'blackMoney' })
		SendNUIMessage({ action = 'element', task = 'disable', value = 'wallet' })
		SendNUIMessage({ action = 'element', task = 'disable', value = 'hunger' })
		SendNUIMessage({ action = 'element', task = 'disable', value = 'thirst' })
		SendNUIMessage({ action = 'element', task = 'disable', value = 'armour' })  --]]
	else
	--[[
		if (Config.ui.showJob == true) then
			SendNUIMessage({ action = 'element', task = 'enable', value = 'job' })
		end
		if (Config.ui.showSocietyMoney == true) then
			SendNUIMessage({ action = 'element', task = 'enable', value = 'society' })
		end
		if (Config.ui.showBankMoney == true) then
			SendNUIMessage({ action = 'element', task = 'enable', value = 'bank' })
		end
		if (Config.ui.showBlackMoney == true) then
			SendNUIMessage({ action = 'element', task = 'enable', value = 'blackMoney' })
		end
		if (Config.ui.showWalletMoney == true) then
			SendNUIMessage({ action = 'element', task = 'enable', value = 'wallet' })
		end--]]
		
		SendNUIMessage({ action = 'toggleUi', value = true })
		toggleui = true
	end

end)




RegisterNetEvent('6bfc45ae-f544-4f6a-8994-5fd9a08c7fc8')
AddEventHandler('6bfc45ae-f544-4f6a-8994-5fd9a08c7fc8', function(show)
	if Config.oldvoice == true then
		startcall = true
		wasinacar = IsPedInAnyVehicle(myPed, true)
		saveprox = NetworkGetTalkerProximity()
		savevprox = voiceDistance
		NetworkSetTalkerProximity(Config.voice.levels.phone)
		voiceDistance = 'phone'
		SendNUIMessage({ action = 'setVoiceDistance', value = "phone" })
	end
end)


RegisterNetEvent('8c567672-84ef-44c9-ac33-cbf6e50bcf89')
AddEventHandler('8c567672-84ef-44c9-ac33-cbf6e50bcf89', function(show)
--[[
	if Config.oldvoice == false then
		return
	end
	startcall = false
	
	if IsPedInAnyVehicle(GetPlayerPed(-1),false) then
		if not savewasinacar then

			voiceDistance = "car"
			NetworkSetTalkerProximity(Config.voice.levels.car)
			saveprox = Config.voice.levels.car
			wasinacar = true
			SetEntityAsMissionEntity(GetVehiclePedIsIn(GetPlayerPed(-1),false),true,true)
		else
			
			voiceDistance = "car"
			saveprox = Config.voice.levels.car
			NetworkSetTalkerProximity(Config.voice.levels.car)
			SetEntityAsMissionEntity(GetVehiclePedIsIn(GetPlayerPed(-1),false),true,true)
		

		end
		
		
		NetworkSetTalkerProximity(saveprox)
		SendNUIMessage({ action = 'setVoiceDistance', value = voiceDistance })
	

	else
		
		voiceDistance = savevprox
		if voiceDistance == "car" then
			voiceDistance = "normal"
			saveprox = Config.voice.levels.default
		end
		
		voiceDistance = "normal"
		saveprox = Config.voice.levels.default

		wasinacar = false
	
		NetworkSetTalkerProximity(saveprox)
		SendNUIMessage({ action = 'setVoiceDistance', value = voiceDistance })
	end
	wasinacar = false
 --]]
end)


exports('createStatus', function(args)
	local statusCreation = { action = 'createStatus', status = args['status'], color = args['color'], icon = args['icon'] }
	SendNUIMessage(statusCreation)
end)


exports('vehiclespeed', function(args)
	return vehicleSpeed
end)


exports('setStatus', function(args)
	local playerStatus = { action = 'setStatus', status = {
		{ name = args['name'], value = args['value'] }
	}}
	SendNUIMessage(playerStatus)
end)





RegisterNetEvent('1c2819cb-9fc5-440e-8b8c-9dd8a8ea2bfd')
AddEventHandler('1c2819cb-9fc5-440e-8b8c-9dd8a8ea2bfd', function()

		if Config.oldvoice == false then
			return
		end
		local playerPed = PlayerPedId()
        local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 38.0)
        local foundPlayers = false
        local elements = {}

        for i = 1, #players, 1 do
            if players[i] ~= PlayerId() then
                foundPlayers = true
				
                table.insert(
                    elements,
                    
                     GetPlayerServerId(players[i])
                    
                )
            end
        end

        if not foundPlayers then
		
		
            exports.pNotify:SendNotification(
                {
                    text = 'No players were found to loud hail',
                    type = "error",
                    timeout = 3000,
                    layout = "bottomCenter",
                    queue = "customui"
                }
            )
        else
			TriggerServerEvent('3e6c5a2b-84ea-46df-8344-4b7d54d0b624', elements)
        end

end)



function ListofPlayersandDistancesSL()
	local players = GetPlayers()
	local closestDistance = -1
	local closestPlayer = -1
	local ply = myPed
	local plyCoords = GetEntityCoords(ply, 0)
	local list = {}
	
	for index,value in ipairs(players) do
		local target = GetPlayerPed(value)
		
		if(target ~= ply) then
			local targetCoords = GetEntityCoords(GetPlayerPed(value), 0)
			local distance = Vdist(targetCoords["x"], targetCoords["y"], targetCoords["z"], plyCoords["x"], plyCoords["y"], plyCoords["z"])
			if distance < 35 then
				table.insert(list, GetPlayerServerId(target))
			end
		end
	end
	
	return list
end


local shortlist = {}

--Runs brakelight check

--[[
Citizen.CreateThread(function()

	while true do
		pcall(function()
		local mycoords = myCurrentCoords
		local vshortlist = {}
		for _, player in ipairs(GetActivePlayers()) do
			local pp = GetPlayerPed(player)
			local vh = GetVehiclePedIsIn(pp)
			
			if vh ~= nil and vh ~= 0 then
				local vseat = GetPedInVehicleSeat(vh, -1)
				if pp == vseat then
					
					if #(pc - mycoords) < 80 then
						table.insert(vshortlist, {player = player, pped = pp, vehicle = vh})
					end
				end
			end
		
			
			Wait(20)
		end
		shortlist = vshortlist
		-- do stuff
		end)
		Citizen.Wait(1500)
	end
	
end)

Citizen.CreateThread(function()
	while true do
		for i = 1, #shortlist, 1 do

			if GetEntitySpeed(shortlist[i].vehicle) < 2.0 then
				SetVehicleBrakeLights(shortlist[i].vehicle, true)
			end
		end
		Wait(3)
	end
end)
--]]

