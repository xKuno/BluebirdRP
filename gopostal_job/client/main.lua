ESX = nil

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
-- NE RIEN MODIFIER
local CurrentDelivery 		  = false -- Le joeur en livraison ?
local DeliveryPoint			  = nil
local Blips 		  		  = {}
local district 		  		  = {}
local progress 		  		  = 1
local colis 		  	  	  = 0
local lettre 		  		  = 0
local isInService 			  = false
local hasAlreadyEnteredMarker = false
local lastZone                = nil
local Blips                   = {}
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local vehicleMaxHealth 	      = nil
local spawnvehicleModel 	 = 0
local GUITime = GetGameTimer()
--------------------------------------------------------------------------------
Citizen.CreateThread(function()
		pcall(function()
		Wait(5000)
		if ESX.GetPlayerData().job.name == 'gopostal' then
			blip = AddBlipForCoord(Config.Zones.CloakRoom.Pos.x, Config.Zones.CloakRoom.Pos.y, Config.Zones.CloakRoom.Pos.z)
		  
			SetBlipSprite (blip, 267)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, 1.2)
			SetBlipColour (blip, 75)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U('blip_job'))
			EndTextCommandSetBlipName(blip)
		end
		end)
	end)
RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(xPlayer)
    PlayerData = xPlayer
	-- CREATE BLIPS
	Citizen.CreateThread(function()
		pcall(function()
		if blip ~= nil then
			RemoveBlip(blip)
			blip = nil
		end
		if xPlayer.job.name == 'gopostal' then
			blip = AddBlipForCoord(Config.Zones.CloakRoom.Pos.x, Config.Zones.CloakRoom.Pos.y, Config.Zones.CloakRoom.Pos.z)
		  
			SetBlipSprite (blip, 267)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, 1.2)
			SetBlipColour (blip, 75)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U('blip_job'))
			EndTextCommandSetBlipName(blip)
		end
		end)
	end)
end)

RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function(job)
	PlayerData.job = job
	
	-- CREATE BLIPS
	Citizen.CreateThread(function()
		if blip ~= nil then
			RemoveBlip(blip)
			blip = nil
		end
		if job.name == 'gopostal' then
			blip = AddBlipForCoord(Config.Zones.CloakRoom.Pos.x, Config.Zones.CloakRoom.Pos.y, Config.Zones.CloakRoom.Pos.z)
		  
			SetBlipSprite (blip, 267)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, 1.2)
			SetBlipColour (blip, 75)
			SetBlipAsShortRange(blip, true)

			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(_U('blip_job'))
			EndTextCommandSetBlipName(blip)
		end
	end)

end)

function IsJobTrucker() -- Check si le joueur est bien du métier
	if PlayerData ~= nil then
		local isJobTrucker = false
		if PlayerData.job.name ~= nil and PlayerData.job.name == 'gopostal' then
			isJobTrucker = true
		end
		return isJobTrucker
	end
end

function Draw3DText(x, y, z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = #(vector3(px,py,pz) - vector3(x,y,z))
 
    local scale = 0.5
   
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
--------------------------------------------------------------------------------

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- 									CLOAKROOM	
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
function setUniform(playerPed)
	TriggerEvent('d3bdbe20-bf7d-4df2-9ef6-9026a86a6e87', function(skin)
		if skin.sex == 0 then
			if Config.Uniforms.male then
				TriggerEvent('1d09cf94-2c53-4220-a089-0339ce8bb123', skin, Config.Uniforms.male)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end
		else
			if Config.Uniforms.female then
				TriggerEvent('1d09cf94-2c53-4220-a089-0339ce8bb123', skin, Config.Uniforms.female)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end
		end
	end)
end

function cloakroom()
	if isInService then
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
		isInService = false
	else
	    setUniform(PlayerPedId())
	    isInService = true
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- 									VEHICLE	
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

function VehiculeSpawner()
	local elements = {}
	local len = 0
	for i=1, #Config.Vehicle, 1 do len = len + 1 end

	local plate = Config.JobVehiclePlate .. math.random(1,99999)


	if len > 1 then

		for i=1, #Config.Vehicle, 1 do
			table.insert(elements, {label = GetLabelText(GetDisplayNameFromVehicleModel(Config.Vehicle[i])), value = Config.Vehicle[i]})
		end


		ESX.UI.Menu.CloseAll()

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'vehiclespawner',
			{
				title    = _U('vehiclespawner'),
				elements = elements
			},
			function(data, menu)

				TriggerServerEvent('1b344529-8e88-4e05-bc45-41fc69d8ccaa', 'take', Config.Caution)
				ESX.ShowAdvancedNotification('Get Letters', '', 'Go and get your letters and parcels from the place just up the lane.', 'CHAR_BRYONY', 1 )
				ESX.ShowAdvancedNotification('Press F6 to start', '', 'When you are ready to start delivery press [F6]', 'CHAR_BRYONY', 1 )
				ESX.Game.SpawnVehicle(data.current.value, Config.Zones.VehicleSpawnPoint.Pos, Config.Zones.VehicleSpawnPoint.Heading, function(vehicle)
					vehicleMaxHealth = GetVehicleEngineHealth(vehicle)
					SetVehicleNumberPlateText(vehicle, plate)             	
					TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)
					spawnvehicleModel = GetEntityModel(vehicle)					
				end)
				menu.close()

			end,
			function(data, menu)
				menu.close()
			end
		)
	else
		TriggerServerEvent('1b344529-8e88-4e05-bc45-41fc69d8ccaa', 'take', Config.Caution)
				ESX.ShowAdvancedNotification('Get Letters', '', 'Go and get your letters and parcels from the place just up the lane.', 'CHAR_BRYONY', 1 )
				ESX.ShowAdvancedNotification('Press F6 to start', '', 'When you are ready to start delivery press [F6]', 'CHAR_BRYONY', 1 )

		
		ESX.Game.SpawnVehicle(Config.Vehicle[1], Config.Zones.VehicleSpawnPoint.Pos, Config.Zones.VehicleSpawnPoint.Heading, function(vehicle)
			vehicleMaxHealth = GetVehicleEngineHealth(vehicle)
			SetVehicleNumberPlateText(vehicle, plate)             			
			TaskWarpPedIntoVehicle(GetPlayerPed(-1), vehicle, -1)   
			spawnvehicleModel = GetEntityModel(vehicle)
		end)
	end
end

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- 									Distribution	
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
function MenuDistribution()
	local elements = {
		-- Courrier
		{label      = _U('letter'),
		item       = 'letter',

		-- menu properties
		value      = 1,
		type       = 'slider',
		min        = 1,
		max        = 100},

		--Colis
		{label      = _U('colis'),
		item       = 'parcel',

		-- menu properties
		value      = 1,
		type       = 'slider',
		min        = 1,
		max        = 100}
	}

	ESX.UI.Menu.CloseAll()
	ESX.ShowAdvancedNotification('Get Letters', '', 'You can hold 20 letters and parcels on you. You can put ~b~more ~w~in your ~y~truck~w~ if you need to.', 'CHAR_BRYONY', 1 )
	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'distribution', {
		title    = _U('distribution'),
		align    = 'top-right',
		elements = elements
	}, function(data, menu)

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'distribution_choice', {
			title    = 'x'.. data.current.value .. ' ' .. data.current.label,
			align    = 'top-right',
			elements = {
				{label = _U('pick'),  value = 'pick'},
				{label = _U('deposit'), value = 'deposit'}
			}
		}, function(data2, menu2)
			if data2.current.value == 'pick' then
				TriggerServerEvent('4afafb9f-04a5-4c81-80f3-bd89f3e7cf5a', data.current.item, data.current.value, data.current.label, 'pick')
			elseif data2.current.value == 'deposit' then
				TriggerServerEvent('4afafb9f-04a5-4c81-80f3-bd89f3e7cf5a', data.current.item, data.current.value, data.current.label, 'deposit')
			end
			ESX.ShowAdvancedNotification('Press F6 to start', '', 'When you are ready to start delivery press [F6]', 'CHAR_BRYONY', 1 )
			menu2.close()
		end, function(data2, menu2)
			menu2.close()
		end)

		
	end, function(data, menu)
		menu.close()

		CurrentAction     = 'distribution'
		CurrentActionMsg  = _U('open_distribution')
		CurrentActionData = {}
	end)
end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- 									ZONE
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

AddEventHandler('9089138f-4e91-4fcc-9c24-26e43cda7645', function(zone)

	local playerPed = GetPlayerPed(-1)

	if zone == 'CloakRoom' then
		CurrentAction     = 'cloakroom'
		CurrentActionMsg  = _U('open_cloakroom')
		CurrentActionData = {}
	end

	if zone == 'VehicleSpawner' and isInService then
		CurrentAction     = 'vehiclespawner'
		CurrentActionMsg  = _U('sort_vehicle')
		CurrentActionData = {}
	end

	if zone == 'VehicleDeleter' and isInService then
		local playerPed = GetPlayerPed(-1)
		local coords    = GetEntityCoords(playerPed)
			
		if IsPedInAnyVehicle(playerPed,  false) then

			local vehicle, distance = ESX.Game.GetClosestVehicle({
				x = coords.x,
				y = coords.y,
				z = coords.z
			})
			
			local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)

			CurrentAction     = 'vehicledeleter'
			CurrentActionMsg  = _U('return_vehicle')
			CurrentActionData = {vehicle = vehicle}
					
		end

	end

	if zone == 'Distribution' and isInService then
		CurrentAction     = 'distribution'
		CurrentActionMsg  = _U('open_distribution')
		CurrentActionData = {}
	end

end)

AddEventHandler('b79c2db1-b27a-40f9-b2a1-c33455fc0f0d', function(zone)
	ESX.UI.Menu.CloseAll()    
    CurrentAction = nil
    CurrentActionMsg = ''
end)

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- 									KEY CONTROLS
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
Citizen.CreateThread(function()
    while true do

        Citizen.Wait(0)
		
		if IsJobTrucker() then

			if CurrentAction ~= nil then

				SetTextComponentFormat('STRING')
				AddTextComponentString(CurrentActionMsg)
				DisplayHelpTextFromStringLabel(0, 0, 1, -1)

				if IsControlJustReleased(0, 38) then -- Touche E
					
					if CurrentAction == 'cloakroom' then
						cloakroom()
					end

					if CurrentAction == 'vehiclespawner' then
						VehiculeSpawner()
					end

					if CurrentAction == 'distribution' then
						MenuDistribution()
					end

					if CurrentAction == 'vehicledeleter' then

						local vehicleHealth = GetVehicleEngineHealth(CurrentActionData.vehicle)
						local giveBack = ESX.Math.Round(vehicleHealth / vehicleMaxHealth, 2)

						TriggerServerEvent('1b344529-8e88-4e05-bc45-41fc69d8ccaa', "give_back", giveBack)
						ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
					end


					CurrentAction = nil
				end
			end

			if IsControlJustReleased(0, 167) and isInService then -- Touche F6 si il est bien dans le job & en service
				Livraison()
			end
		else
			Wait(5000)
		end

    end
end)

--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- 									MARKERS & BLIP
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------

-- DISPLAY MISSION MARKERS AND MARKERS
Citizen.CreateThread(function()
	while true do
		Wait(0)
		
		if IsJobTrucker() then
			local coords = GetEntityCoords(GetPlayerPed(-1))
			
			for k,v in pairs(Config.Zones) do
				if k == 'CloakRoom' and (v.Type ~= -1 and #(coords - vector3(v.Pos.x, v.Pos.y, v.Pos.z)) < Config.DrawDistance) then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
				elseif isInService and (v.Type ~= -1 and #(coords -vector3(v.Pos.x, v.Pos.y, v.Pos.z)) < Config.DrawDistance) then
					DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
				end

			end
		else
			Wait(5000)
		end

		
	end
end)

-- Activate menu when player is inside marker
Citizen.CreateThread(function()
	while true do
		
		Wait(0)
		
		if IsJobTrucker() then

			local coords      = GetEntityCoords(GetPlayerPed(-1))
			local isInMarker  = false
			local currentZone = nil

			for k,v in pairs(Config.Zones) do
				if(#(coords -  vector3(v.Pos.x, v.Pos.y, v.Pos.z)) < v.Size.x) then
					isInMarker  = true
					currentZone = k
				end
			end
			

			if isInMarker and not hasAlreadyEnteredMarker then
				hasAlreadyEnteredMarker = true
				lastZone                = currentZone
				TriggerEvent('9089138f-4e91-4fcc-9c24-26e43cda7645', currentZone)
			end

			if not isInMarker and hasAlreadyEnteredMarker then
				hasAlreadyEnteredMarker = false
				TriggerEvent('b79c2db1-b27a-40f9-b2a1-c33455fc0f0d', lastZone)
			end
		else
			Wait(5000)

		end

	end
end)


--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- 									LIVRAISON
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
function Livraison()

	District = SelectDistrict()

	if CurrentDelivery then
		LivraisonStop(district, true)
		CurrentDelivery = false
		
	else
		CurrentDelivery = true
		ESX.ShowAdvancedNotification(_U('notif_title_delivery'), '', _U('notif_district', district.label), 'CHAR_BRYONY', 1 )
		ESX.ShowAdvancedNotification(_U('notif_title_delivery'), '', _U('create_itinary'), 'CHAR_ANDREAS', 1 )
		LivraisonStart(district)
	end
end

function SelectDistrict() -- Selection du quartier pour la ronde

	for k,v in pairs (Config.Livraisons) do
		local DistrictLong = 0
		for i=1, #Config.Livraisons[k].Pos, 1 do 
			DistrictLong = DistrictLong + 1 
		end

		table.insert(district, {label = _U(k), value = k, long = DistrictLong} )
	end
	district = district[ math.random( #district ) ]
	return district;
end

function LivraisonStart(district)
	if CurrentDelivery then
		DeliveryPoint = district.value 
		local zone = Config.Livraisons[district.value]

		Blips['DeliveryPoint'] = AddBlipForCoord(zone.Pos[progress].x, zone.Pos[progress].y, zone.Pos[progress].z)
		SetBlipRoute(Blips['DeliveryPoint'], true)
		LetterAndColis()
		ESX.ShowNotification(_U('join_next'))
	end
end

function LivraisonStop(district, cancel)
	if Blips['DeliveryPoint'] ~= nil then
	    RemoveBlip(Blips['DeliveryPoint'])
	    Blips['DeliveryPoint'] = nil
	end

	if cancel then
		ESX.ShowNotification(_U('cancel_delivery'))
		CurrentDelivery = false
	else
		if progress < district.long then
			progress = progress + 1
			LivraisonStart(district)
		else
			CurrentDelivery = false
			progress = 1
			ESX.ShowAdvancedNotification(_U('notif_title_delivery'), '', _U('finish_delivery'), 'CHAR_BRYONY', 1 )
		end
	end
end


function LetterAndColis()

	local zone = Config.Livraisons[district.value]

	if zone.Pos[progress].letter then
		lettre = math.random(Config.MinLetter, Config.MaxLetter)
	else
		lettre = 0
	end

	if zone.Pos[progress].parcel then
		colis = math.random(Config.Minparcel, Config.Maxparcel)
	else
		colis = 0
	end
	
	if lettre == 0 and lettre == 0 then
		if math.random(1,2) == 1 then
			lettre = 1
		else
			colis = 1
		end
	
	end
	
end


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		if IsJobTrucker() then
			if DeliveryPoint ~= nil then
				if CurrentDelivery then
					local coords = GetEntityCoords(GetPlayerPed(-1))
					local zone = Config.Livraisons[district.value]

					if #(coords - vector3(zone.Pos[progress].x, zone.Pos[progress].y, zone.Pos[progress].z)) < 100.0 then
						DrawMarker(zone.Type, zone.Pos[progress].x, zone.Pos[progress].y, zone.Pos[progress].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, zone.Size.x, zone.Size.y, zone.Size.z, zone.Color.r, zone.Color.g, zone.Color.b, 100, false, true, 2, false, false, false, false)
						Draw3DText(zone.Pos[progress].x, zone.Pos[progress].y, zone.Pos[progress].z + 1.5 , _U('letter') .. ' ' .. lettre .. '\n' .. _U('colis') .. ' ' .. colis)
						if #(coords - vector3(zone.Pos[progress].x, zone.Pos[progress].y, zone.Pos[progress].z)) < 3.0 then
							HelpPromt(_U('pickup'))
							if IsControlJustReleased(0, 38) and IsJobTrucker() and isInService then
								if not IsPedInAnyVehicle(PlayerPedId(), false) then
									if GetEntityModel(GetVehiclePedIsIn(PlayerPedId(),true)) == spawnvehicleModel then
										
										if (GetGameTimer() - 3500) > GUITime then
											GUITime = GetGameTimer()
											ESX.TriggerServerCallback('91c327c3-1989-431c-9aa9-54f93744002e', function(haveItem)
												if haveItem then
													TriggerServerEvent('4fef2c32-d780-4542-97a4-0e670e484c77', lettre, colis)
													LivraisonStop(district, false)
												end

											end, lettre, colis)
										else
											GUITime = GetGameTimer()
											ESX.ShowNotification('You pressed buttons too quickly. Action ignored.')
										end
									else
										--Attempted to Exploit
										TriggerServerEvent('7fcbafb2-e15d-4e94-9a71-c348def151ae',"esx_gopostaljob:cheat", "Attempted to cheat using: " .. spawnvehicleModel)
										ESX.ShowNotification('Cheat Event Logged: You may receive a ~y~warning~w~ or a ~r~ban~w~ in the future.')
									end
								else
									ESX.ShowNotification(_U('must_be_walking'))
								end
							end
						end
					end
				end
			else
				Wait(500)
			end
		else
			Wait(5000)
		end
	end
end)

function HelpPromt(text)
	Citizen.CreateThread(function()
    	SetTextComponentFormat('STRING')
        AddTextComponentString(text)
       	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
  	end)
end
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
-- 									CMD COORD
--------------------------------------------------------------------------------
--------------------------------------------------------------------------------
RegisterNetEvent('cd604ee0-ced3-43af-aee3-de66dfb9adae')
AddEventHandler('cd604ee0-ced3-43af-aee3-de66dfb9adae', function(message)
		x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), true))
	    local PlayerName = GetPlayerName()
	    TriggerServerEvent("SaveCoords", PlayerName , x , y , z, message)			
end)
