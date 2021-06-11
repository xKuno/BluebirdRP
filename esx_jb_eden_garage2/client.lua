-- Local
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

local CurrentAction = nil
local LZone = 1
local GUI                       = {}
GUI.Time                        = 0
local HasAlreadyEnteredMarker   = false
local LastZone                  = nil
local CurrentActionMsg          = ''
local CurrentActionData         = {}
local PlayerData                = {}

local this_Garage 				= {}
local closer 					= false

local GaragesListing			 = {}

-- Fin Local

-- Init ESX
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) 
		ESX = obj 
		refreshBlips()
		end)
		Citizen.Wait(0)
	end
end)
-- Fin init ESX
RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function(job)
	PlayerData.job = job
end)
--- Gestion Des blips
RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(xPlayer)
    PlayerData = xPlayer
    --TriggerServerEvent('esx_jobs:giveBackCautionInCaseOfDrop')
    --refreshBlips()
end)

function refreshBlips()
	local zones = {}
	local blipInfo = {}	

	for zoneKey,zoneValues in pairs(Config.Garages)do
		if zoneValues.invisible == nil then
			local blip = AddBlipForCoord(zoneValues.Pos.x, zoneValues.Pos.y, zoneValues.Pos.z)
			SetBlipSprite (blip, zoneValues.BlipInfos.Sprite)
			SetBlipDisplay(blip, 4)
			SetBlipScale  (blip, 1.0)
			SetBlipColour (blip, zoneValues.BlipInfos.Color)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			-- AddTextComponentString(zoneKey)
			AddTextComponentString("Garage Cars")
			EndTextCommandSetBlipName(blip)
		end
	end
	--[[
	for zoneKey,zoneValues in pairs(Config.GaragesMecano) do
		local blip = AddBlipForCoord(zoneValues.DeletePoint.Pos.x, zoneValues.DeletePoint.Pos.y, zoneValues.DeletePoint.Pos.z)
		SetBlipSprite (blip, Config.BlipInfos.Sprite)
		SetBlipDisplay(blip, 487)
		SetBlipScale  (blip, 1.0)
		SetBlipColour (blip, 47)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		-- AddTextComponentString(zoneKey)
		AddTextComponentString("Impound")
		EndTextCommandSetBlipName(blip)
	end--]]
end
-- Fin Gestion des Blips

--Fonction Menu

function OpenMenuGarage()
	
	
	ESX.UI.Menu.CloseAll()

	local elements = {
		-- {label = "Liste des véhicules", value = 'list_vehicles'},
		-- {label = "Rentrer vehicules", value = 'stock_vehicle'},
		{label = "Return Vehicle ($"..Config.Price.."- $4000)", value = 'return_vehicle'},
	}
	TriggerEvent('2c4f07a6-bf05-4b02-ba86-fd4472391cbd', 'Vehicle return price varies. You ~r~pay more~w~ if mechanics are online.')

	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'garage_menu',
		{
			title    = '** RACV Insurance **  "There for you"',
			align    = 'top-right',
			elements = elements,
		},
		function(data, menu)
			if 	(GetGameTimer() - GUI.Time) > 2000 then
					GUI.Time      = GetGameTimer()
				menu.close()
				-- if(data.current.value == 'list_vehicles') then
					-- ListVehiclesMenu()
				-- end
				-- if(data.current.value == 'stock_vehicle') then
					-- StockVehicleMenu()
				-- end
				if(data.current.value == 'return_vehicle') then
					ReturnVehicleMenu()
				end

				local playerPed = GetPlayerPed(-1)
				SpawnVehicle(data.current.value)
				--local coords    = societyConfig.Zones.VehicleSpawnPoint.Pos
			end
		end,
		function(data, menu)
			menu.close()
			--CurrentAction = 'open_garage_action'
		end
	)	
end
-- Afficher les listes des vehicules
function ListVehiclesMenu()
	local elements = {}
	print ('YOU ARE IN ZONE ' .. LZone)
	local pzone = LZone
	
	local zonename1 = "City Parking Zone"
	local zonename2 = "Blaine Parking Zone"
	local count = 0
	
	
	local carsfromelsewhere =false
	
	ESX.TriggerServerCallback('17486e18-6784-436b-a030-9f00e08e45c8', function(data)

		if data ~= nil and data[1] ~= nil and data[1].pDmvLicenceSuspended ~= nil and data[1].pDmvLicenceSuspended == 1 then

			exports["esx_newweaponshop"]:ShowMPMessage("~o~Licence Suspended", "~b~POLICE~w~ have ~o~suspended~w~ your licence and have taken your car keys. \n\n You will either need to wait out the day suspension period or take the matter to court.\n\n~r~Warning: ~w~It is an offence to drive on a suspended licence. Your licence may have also been disqualified and cancelled.", 20000)
			ESX.ShowNotification("~b~Police Licence Suspension~w~\nPolice have suspended your drivers licence.")
			ESX.ShowNotification("You are ~r~unable~w~ to access your vehicles until your licence is ~o~unsuspended..")
			Wait(3000)
			ESX.ShowNotification("Licences are automatically unsuspended the following day.")
			return
		end
		local carselsewhere = ''
		local carelsecount = 0
		local cmenucount = 0
				
		local vehicles = {}
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(vehicles, {vehicle = vehicle, state = v.state, fourrieremecano = v.fourrieremecano, pimp = v.pimp, plate = v.plate, garagezone = v.garagezone})
		end	

		for _,v in pairs(vehicles) do
			count = count + 1
			if cmenucount < 32 then
			local hashVehicule = v.vehicle.model
    		local vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)
    		local labelvehicle = ''
			
			if (v.pimp > 0) then
				labelvehicle = vehicleName.. ' [' .. v.plate .. '] '..': 👮 POLICE Impounded'
				table.insert(elements, {label =labelvehicle , value = v})
				cmenucount = cmenucount + 1
			elseif(v.fourrieremecano)then
				labelvehicle = vehicleName.. ' [' .. v.plate .. '] '..': 🚚 RACV Impounded'
				table.insert(elements, {label =labelvehicle , value = v})
				cmenucount = cmenucount + 1
			elseif (v.garagezone ~= pzone) then
				
				if tonumber(v.garagezone) == 1 then
					carsfromelsewhere = true
					carelsecount = carelsecount + 1
					labelvehicle = vehicleName.. ' [' .. v.plate .. '] '..': 🚫 Stored in ' .. zonename1
					carselsewhere = carselsewhere  .. labelvehicle .. '<br />'
				elseif tonumber(v.garagezone) == 2 then
					carsfromelsewhere = true
					carelsecount = carelsecount + 1
					labelvehicle = vehicleName.. ' [' .. v.plate .. '] '..': 🚫 Stored in ' .. zonename2
					carselsewhere = carselsewhere  .. labelvehicle .. '<br />'
				else
					
					labelvehicle = vehicleName.. ' [' .. v.plate .. '] '..': 🚫 Not here in ' .. v.garagezone
				end
				
    		elseif(v.state)then
				labelvehicle = vehicleName.. ' [' .. v.plate .. '] '..': ✔️ Available'
				table.insert(elements, {label =labelvehicle , value = v})
				cmenucount = cmenucount + 1
				
    		else
				labelvehicle = vehicleName .. ' [' .. v.plate .. '] '..': ⛔ Unavailable'
				table.insert(elements, {label =labelvehicle , value = v})
				cmenucount = cmenucount + 1
    		end	
			--table.insert(elements, {label =labelvehicle , value = v})
			end
		end
		if carelsecount > 0 then
			table.insert(elements, {label = '<strong>CARS STORED IN OTHER ZONES:</strong>: ' .. carelsecount .. '<br />There are 2 zones: Blaine County & City Zone'  , value = ''})
		end

		ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'spawn_vehicle',
		{
			title    = 'Garage - Your Garage',
			align    = 'top-right',
			elements = elements,
		},
		function(data, menu)
			if (data.current.value.pimp > 0) then
				TriggerEvent('2c4f07a6-bf05-4b02-ba86-fd4472391cbd', 'See Police automated system at the Police impound.')
			elseif (data.current.value.fourrieremecano) then
				TriggerEvent('2c4f07a6-bf05-4b02-ba86-fd4472391cbd', 'See RACV, your vehicle is in the impounded.')
				
			elseif (data.current.value.garagezone ~= pzone) then
				TriggerEvent('2c4f07a6-bf05-4b02-ba86-fd4472391cbd', 'Car is not stored in this zone. There are 2 zones: Blaine & City')

			elseif(data.current.value.state)then
				menu.close()
				SpawnVehicle(data.current.value.vehicle)
			else
				TriggerEvent('2c4f07a6-bf05-4b02-ba86-fd4472391cbd', 'Your vehicle is not in the garage!')
				TriggerEvent('2c4f07a6-bf05-4b02-ba86-fd4472391cbd', 'You may be able to claim insurance from the ~y~yellow ~w~circle.')
			end
		end,
		function(data, menu)
			menu.close()
			-- CurrentAction = 'open_garage_action'
		end
	)	
	end, LZone)
end
-- Fin Afficher les listes des vehicules

-- Afficher les listes des vehicules de fourriere
function ListVehiclesFourriereMenu()
	local elements = {}

	ESX.TriggerServerCallback('1d8c2955-a786-497f-95df-f933be40d200', function(vehicles)

		for _,v in pairs(vehicles) do

			local hashVehicule = v.vehicle.model
    		local vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)

			table.insert(elements, {label =vehicleName.." | "..v.firstname.." "..v.lastname , value = v})
			
		end

		ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'spawn_vehicle',
		{
			title    = 'Garage - RACV "There for you"',
			align    = 'top-right',
			elements = elements,
		},
		function(data, menu)
			-- if(data.current.value.state)then
				menu.close()
				SpawnVehicleMecano(data.current.value.vehicle)
				TriggerServerEvent('c1ffca63-99ed-4642-8d0e-5a0b89923b86', data.current.value.vehicle, false)
			-- else
				-- TriggerEvent('2c4f07a6-bf05-4b02-ba86-fd4472391cbd', 'Votre véhicule est déjà sorti')
			-- end
		end,
		function(data, menu)
			menu.close()
			--CurrentAction = 'open_garage_action'
		end
	)	
	end)
end
-- Fin Afficher les listes des vehicules de fourriere




-- Fonction qui permet de rentrer un vehicule
function StockVehicleMenu()
	local playerPed  = GetPlayerPed(-1)
	-- if IsAnyVehicleNearPoint(this_Garage.DeletePoint.Pos.x,  this_Garage.DeletePoint.Pos.y,  this_Garage.DeletePoint.Pos.z,  3.5) then
	if IsPedInAnyVehicle(playerPed,  false) then
		-- local vehicle       = GetClosestVehicle(this_Garage.DeletePoint.Pos.x, this_Garage.DeletePoint.Pos.y, this_Garage.DeletePoint.Pos.z, this_Garage.DeletePoint.Size.x, 0, 70)
		local vehicle =GetVehiclePedIsIn(playerPed,false)
		local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
		-- local GotTrailer, TrailerHandle = GetVehicleTrailerVehicle(GetVehiclePedIsIn(playerPed, true))
		local GotTrailer, TrailerHandle = GetVehicleTrailerVehicle(vehicle)
		local trailerProps  = ESX.Game.GetVehicleProperties(TrailerHandle)
		if GotTrailer then
			ESX.TriggerServerCallback('aac5d2a4-3a64-4ca2-afc8-c0a4197f0f7f',function(valid)

				if(valid) then
					TriggerServerEvent('6b78315f-a809-47c1-97b9-0370e1e47683', TrailerHandle)
					SetEntityAsMissionEntity(vehicle,true,true)
					Wait(50)
					DeleteVehicle(TrailerHandle)
					ESX.Game.DeleteVehicle(vehicle)
					TriggerServerEvent('31930d0f-04bc-4421-ab7c-da13e2ef4a45', trailerProps, true, LZone)
					TriggerEvent('2c4f07a6-bf05-4b02-ba86-fd4472391cbd', 'Your vehicle is now in the garage.')
				else
					TriggerEvent('2c4f07a6-bf05-4b02-ba86-fd4472391cbd', 'You can not store this vehicle')
				end
			end,trailerProps)
			hasAlreadyEnteredMarker = false
		else
			ESX.TriggerServerCallback('aac5d2a4-3a64-4ca2-afc8-c0a4197f0f7f',function(valid)
				if(valid) then
					TriggerServerEvent('6b78315f-a809-47c1-97b9-0370e1e47683', vehicle)
					SetEntityAsMissionEntity(vehicle,true,true)
					Wait(50)
					DeleteVehicle(vehicle)
					Wait(1)
					DeleteVehicle(vehicle)
					ESX.Game.DeleteVehicle(vehicle)
					TriggerServerEvent('31930d0f-04bc-4421-ab7c-da13e2ef4a45', vehicleProps, true, LZone)
					TriggerEvent('2c4f07a6-bf05-4b02-ba86-fd4472391cbd', 'Your vehicle is now in the garage.')
				else
					TriggerEvent('2c4f07a6-bf05-4b02-ba86-fd4472391cbd', 'You can not store this vehicle, numberplate does not exist in VicRoads.')
					Wait(50)
					DeleteVehicle(vehicle)
					Wait(1)
					DeleteVehicle(vehicle)
					ESX.Game.DeleteVehicle(vehicle)
					TriggerEvent('2c4f07a6-bf05-4b02-ba86-fd4472391cbd', 'RACV has taken this vehicle and removed it for you.')
				end
			end,vehicleProps)
		end
	else
		TriggerEvent('2c4f07a6-bf05-4b02-ba86-fd4472391cbd', 'There is no vehicle to enter.')
	end
	CurrentAction = 'garage_delete'
end
-- Fin fonction qui permet de rentrer un vehicule 

-- Fonction qui permet de rentrer un vehicule dans fourriere
function StockVehicleFourriereMenu()
	local playerPed  = GetPlayerPed(-1)
	-- if IsAnyVehicleNearPoint(this_Garage.DeletePoint.Pos.x,  this_Garage.DeletePoint.Pos.y,  this_Garage.DeletePoint.Pos.z,  3.5) then
	if IsPedInAnyVehicle(playerPed,  false) then
		-- local vehicle       = GetClosestVehicle(this_Garage.DeletePoint.Pos.x, this_Garage.DeletePoint.Pos.y, this_Garage.DeletePoint.Pos.z, this_Garage.DeletePoint.Size.x, 0, 70)
		local vehicle =GetVehiclePedIsIn(playerPed,false)
		local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
		-- local GotTrailer, TrailerHandle = GetVehicleTrailerVehicle(GetVehiclePedIsIn(playerPed, true))
		local GotTrailer, TrailerHandle = GetVehicleTrailerVehicle(vehicle)
		local trailerProps  = ESX.Game.GetVehicleProperties(TrailerHandle)
		if GotTrailer then
			ESX.TriggerServerCallback('7d71aab8-8029-4415-888f-e8468ee19716',function(valid)

				if(valid) then
					-- TriggerServerEvent('6b78315f-a809-47c1-97b9-0370e1e47683', TrailerHandle)
					SetEntityAsMissionEntity(TrailerHandle,true,true)
					Wait(50)
					DeleteVehicle(TrailerHandle)
					ESX.Game.DeleteVehicle(TrailerHandle)
					TriggerServerEvent('c1ffca63-99ed-4642-8d0e-5a0b89923b86', trailerProps, true)
					TriggerEvent('2c4f07a6-bf05-4b02-ba86-fd4472391cbd', 'You have returned your vehicle.')
				else
					TriggerEvent('2c4f07a6-bf05-4b02-ba86-fd4472391cbd', 'You can not store this vehicle.')
				end
			end,trailerProps)
			hasAlreadyEnteredMarker = false
		else
			ESX.TriggerServerCallback('7d71aab8-8029-4415-888f-e8468ee19716',function(valid)
				if(valid) then
					-- TriggerServerEvent('6b78315f-a809-47c1-97b9-0370e1e47683', vehicle)
					SetEntityAsMissionEntity(vehicle,true,true)
					Wait(50)
					DeleteVehicle(vehicle)
					ESX.Game.DeleteVehicle(vehicle)
					TriggerServerEvent('c1ffca63-99ed-4642-8d0e-5a0b89923b86', vehicleProps, true)
					TriggerEvent('2c4f07a6-bf05-4b02-ba86-fd4472391cbd', 'You have returned your vehicle')
				else
					TriggerEvent('2c4f07a6-bf05-4b02-ba86-fd4472391cbd', 'You can not store this vehicle')
				end
			end,vehicleProps)
		end
	else
		TriggerEvent('2c4f07a6-bf05-4b02-ba86-fd4472391cbd', 'There is no vehicle to enter')
	end
	CurrentAction = 'garagemecano_delete'
end
-- Fin fonction qui permet de rentrer un vehicule dans fourriere
--Fin fonction Menu


--Fonction pour spawn vehicule
function reSpawnVehicle()

	local playerPed  = GetPlayerPed(-1)
	local vehicle =GetVehiclePedIsIn(playerPed,false)
	local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
	local heading = GetEntityHeading(GetPlayerPed(-1))
	local Pos = GetEntityCoords(GetPlayerPed(-1))	
	DeleteEntity(vehicle)
	Wait(100)
	vehicle = vehicleProps
	ESX.Game.SpawnVehicle(vehicle.model, {
		x = Pos.x ,
		y = Pos.y,
		z = Pos.z + 1											
		},heading, function(callback_vehicle)
		ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
			TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
		
		end)
	
end

function SpawnVehicle(vehicle)

	ESX.Game.SpawnVehicle(vehicle.model, {
		x = this_Garage.SpawnPoint.Pos.x ,
		y = this_Garage.SpawnPoint.Pos.y,
		z = this_Garage.SpawnPoint.Pos.z + 1											
		},this_Garage.SpawnPoint.Heading, function(callback_vehicle)
		ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
		TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
		 local platep = vehicle.plate
		  TriggerEvent('6e50bab1-3501-471a-9782-c68e8214c3e1',platep)
		  Citizen.InvokeNative(0x51BB2D88D31A914B, callback_vehicle, true)
		
		end)
	
	TriggerServerEvent('31930d0f-04bc-4421-ab7c-da13e2ef4a45', vehicle, false, tonumber(LZone))

end

function SpawnBike(vehicle)

	ESX.Game.SpawnVehicle(vehicle, {
		x = this_Garage.SpawnPoint.Pos.x ,
		y = this_Garage.SpawnPoint.Pos.y,
		z = this_Garage.SpawnPoint.Pos.z + 1											
		},this_Garage.SpawnPoint.Heading, function(callback_vehicle)
		ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
			TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
			SetVehicleNumberPlateText(callback_vehicle,"FREE"..math.random(1,9999))
		end)
	

end





RegisterNetEvent('92a3b519-d2b8-4b70-b8d0-00e72b3cdeda')
AddEventHandler('92a3b519-d2b8-4b70-b8d0-00e72b3cdeda', function()
	reSpawnVehicle()
end)
--Fin fonction pour spawn vehicule

--Fonction pour spawn vehicule fourriere mecano
function SpawnVehicleMecano(vehicle)

	ESX.Game.SpawnVehicle(vehicle.model, {
		x = this_Garage.SpawnPoint.Pos.x ,
		y = this_Garage.SpawnPoint.Pos.y,
		z = this_Garage.SpawnPoint.Pos.z + 1											
		},this_Garage.SpawnPoint.Heading, function(callback_vehicle)
		ESX.Game.SetVehicleProperties(callback_vehicle, vehicle)
		TaskWarpPedIntoVehicle(GetPlayerPed(-1), callback_vehicle, -1)
		  local platep = vehicle.plate
		  TriggerEvent('6e50bab1-3501-471a-9782-c68e8214c3e1',platep)
		end)
	TriggerServerEvent('c1ffca63-99ed-4642-8d0e-5a0b89923b86', vehicle, false)
end
--Fin fonction pour spawn vehicule fourriere mecano

--Action das les markers
AddEventHandler('720ab0de-aa85-4a7e-914d-d2576745e6fb', function(zone)

	if zone == 'garage' then
		CurrentAction     = 'garage_action_menu'
		CurrentActionMsg  = "Press ~INPUT_PICKUP~ to open the garage"
		CurrentActionData = {}
	end
	
	if zone == 'spawn' then
		CurrentAction     = 'garage_spawn'
		CurrentActionMsg  = "Press ~INPUT_PICKUP~ take out your vehicle"
		CurrentActionData = {}
	end	
	
	if zone == 'delete' then
		CurrentAction     = 'garage_delete'
		CurrentActionMsg  = "Press ~INPUT_PICKUP~ to park your vehicle"
		CurrentActionData = {}
	end	
	
	if zone == 'spawnmecano' then
		CurrentAction     = 'garagemecano_spawn'
		CurrentActionMsg  = "Press ~INPUT_PICKUP~ to take a vehicle out of the garage"
		CurrentActionData = {}
	end	
	
	if zone == 'deletemecano' then
		CurrentAction     = 'garagemecano_delete'
		CurrentActionMsg  = "Press ~INPUT_PICKUP~ to place vehicle into the garage"
		CurrentActionData = {}
	end
	if zone == 'free_bike' then
		CurrentAction     = 'free_bike'
		CurrentActionMsg  = "Press ~INPUT_PICKUP~ to get a free bike"
		CurrentActionData = {}
	end
end)

AddEventHandler('42fb2cc8-6419-4e21-9472-39e5200f100b', function(zone)
	ESX.UI.Menu.CloseAll()
	CurrentAction = nil
end)
--Fin Action das les markers

function ReturnVehicleMenu()

	ESX.TriggerServerCallback('9c81c667-97ff-4cc3-8de2-d7953e9d406d', function(data)
		local elements = {}
		
		if data ~= nil and data[1] ~= nil and data[1].pDmvLicenceSuspended ~= nil and data[1].pDmvLicenceSuspended == 1 then

			exports["esx_newweaponshop"]:ShowMPMessage("~o~Licence Suspended", "~b~POLICE~w~ have ~o~suspended~w~ your licence and have taken your car keys. \n\n You will either need to wait out the day suspension period or take the matter to court.\n\n~r~Warning: ~w~It is an offence to drive on a suspended licence. Your licence may have also been disqualified and cancelled.", 20000)
			ESX.ShowNotification("~b~Police Licence Suspension~w~\nPolice have suspended your drivers licence.")
			ESX.ShowNotification("You are ~r~unable~w~ to access your vehicles until your licence is ~o~unsuspended..")
			Wait(3000)
			ESX.ShowNotification("Licences are automatically unsuspended the following day.")
			return
		end
		local vehicles = {}
		for _,v in pairs(data) do
			local vehicle = json.decode(v.vehicle)
			table.insert(vehicles, {vehicle =vehicle, fourrieremecano = v.fourrieremecano, pimp = v.pimp})
		end
		

		for _,v in pairs(vehicles) do

			local hashVehicule = v.vehicle.model
    		local vehicleName = GetDisplayNameFromVehicleModel(hashVehicule)
    		local labelvehicle
			
			if (v.pimp > 0) then
				labelvehicle = vehicleName..': POLICE Impounded'
				table.insert(elements, {label =labelvehicle , value = 'policeimpound'})
			elseif v.fourrieremecano then
				labelvehicle = vehicleName..': Impound'
				table.insert(elements, {label =labelvehicle , value = 'fourrieremecano'})
			else
				labelvehicle = vehicleName..': Vehicle'
				table.insert(elements, {label =labelvehicle , value = v.vehicle})
			end
		end
		ESX.ShowNotification("Prices range from ~r~$2-4k~w~ depending if theres a mecanic on.")
		ESX.ShowNotification("Save ~g~$$~w~ by using ~y~RACV~w~ when they're on.")
		ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'return_vehicle',
		{
			title    = '** RACV Insurance **  "There for you"',
			align    = 'top-right',
			elements = elements,
		},
		function(data, menu)
			if 	(GetGameTimer() - GUI.Time) > 2000 then
				GUI.Time      = GetGameTimer()
				if data.current.value == 'policeimpound' then
					ESX.ShowNotification("Vehicles can be claimed back after impound duration from POLICE in La Messa.")
				elseif data.current.value == 'fourrieremecano' then
					ESX.ShowNotification("Go see a mechanic to get your vehicle back from the impound.")
				else
					ESX.TriggerServerCallback('738a736a-9828-47eb-abe7-6533b3e7796a', function(hasEnoughMoney)
						if hasEnoughMoney then
									
							TriggerServerEvent('328008da-c006-4e48-99e4-a5136c457ab3')
							SpawnVehicle(data.current.value)
						else
							ESX.ShowNotification('You do not have enough money')						
						end
					end)				
				end
			end
		end,
		function(data, menu)
			menu.close()
			-- CurrentAction = 'garage_spawn'
		end
		)	
	end,zone)
end

-- Affichage markers


Citizen.CreateThread(function()
	while true do
		Wait(1500)
		pcall(function()
		local coords = ESX.Game.GetMyPedLocation()		
		local zGaragesListing = {}
		local zcloser = false
		for k,v in pairs(Config.Garages) do
		
			if v.Pos ~= nil and (#(coords - vector3(v.Pos.x, v.Pos.y, v.Pos.z)) < Config.DrawDistance) then	
				zGaragesListing[k] = v
				zcloser = true
			end	
			Wait(100)
		end	
		for _,v in pairs(Config.BikeLocations) do
			if #(vector3(v.Pos.x,v.Pos.y,v.Pos.z) - coords) < Config.DrawDistance then
				zcloser = true
			end
		end
		GaragesListing = zGaragesListing
		if zcloser then
			closer = true
		else
			closer = false
		end
		--[[
		if PlayerData.job ~= nil and PlayerData.job.name == 'mecano' then
			for k,v in pairs(Config.GaragesMecano) do
				if(GetDistanceBetweenCoords(coords, v.DeletePoint.Pos.x, v.DeletePoint.Pos.y, v.DeletePoint.Pos.z, true) < Config.DrawDistance) then		
					DrawMarker(v.SpawnPoint.Marker, v.SpawnPoint.Pos.x, v.SpawnPoint.Pos.y, v.SpawnPoint.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.SpawnPoint.Size.x, v.SpawnPoint.Size.y, v.SpawnPoint.Size.z, v.SpawnPoint.Color.r, v.SpawnPoint.Color.g, v.SpawnPoint.Color.b, 100, false, true, 2, false, false, false, false)	
					DrawMarker(v.DeletePoint.Marker, v.DeletePoint.Pos.x, v.DeletePoint.Pos.y, v.DeletePoint.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.DeletePoint.Size.x, v.DeletePoint.Size.y, v.DeletePoint.Size.z, v.DeletePoint.Color.r, v.DeletePoint.Color.g, v.DeletePoint.Color.b, 100, false, true, 2, false, false, false, false)	
				end		
			end
		end
		--]]
		end)
	end
end)

Citizen.CreateThread(function()
	while true do
		Wait(0)	
		pcall(function()
			local coords = ESX.Game.GetMyPedLocation()
			if closer then
				for k,v in pairs(GaragesListing) do			
					if v and v.Pos ~= nil and (#(coords - vector3(v.Pos.x, v.Pos.y, v.Pos.z)) < 40.0) then	

						DrawMarker(v.Marker, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
						DrawMarker(v.SpawnPoint.Marker, v.SpawnPoint.Pos.x, v.SpawnPoint.Pos.y, v.SpawnPoint.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.SpawnPoint.Size.x, v.SpawnPoint.Size.y, v.SpawnPoint.Size.z, v.SpawnPoint.Color.r, v.SpawnPoint.Color.g, v.SpawnPoint.Color.b, 100, false, true, 2, false, false, false, false)	
						DrawMarker(v.DeletePoint.Marker, v.DeletePoint.Pos.x, v.DeletePoint.Pos.y, v.DeletePoint.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.DeletePoint.Size.x, v.DeletePoint.Size.y, v.DeletePoint.Size.z, v.DeletePoint.Color.r, v.DeletePoint.Color.g, v.DeletePoint.Color.b, 100, false, true, 2, false, false, false, false)	
					end	

				end
				for _,v in pairs(Config.BikeLocations) do
					if #(vector3(v.Pos.x,v.Pos.y,v.Pos.z) - coords) < 20.0 then
						ESX.Game.Utils.DrawText3D(vector3(v.Pos.x, v.Pos.y, v.Pos.z + 0.8), 'Press ~g~[E]~w~ to get a free Bike', 0.5)
						DrawMarker(v.Marker, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, v.Color.r, v.Color.g, v.Color.b, 100, false, true, 2, false, false, false, false)
					end
				end
			else
				Wait(1000)
			end
		end)
	end
end)
-- Fin affichage markers
function PrintHelpText(message)
    SetTextComponentFormat("STRING")
    AddTextComponentString(message)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
-- Activer le menu quand player dedans
Citizen.CreateThread(function()
	-- local currentZone = 'garage'
	while true do
	
		Wait(200)
		pcall(function()
			if closer then
				local coords      = ESX.Game.GetMyPedLocation()
				local isInMarker  = false
				local currentZone = nil
				
				for _,v in pairs(GaragesListing) do

					if v and v.Pos ~= nil and (#(coords - vector3(v.Pos.x, v.Pos.y, v.Pos.z)) < v.Size.x) then
						isInMarker  = true
						currentZone = 'garage'
						LZone = v.Zone
						this_Garage = v
					end			
					
					if v and v.Pos ~= nil and(#(coords - vector3(v.SpawnPoint.Pos.x, v.SpawnPoint.Pos.y, v.SpawnPoint.Pos.z)) < v.Size.x) then
						isInMarker  = true
						currentZone = 'spawn'
						LZone = v.Zone
						this_Garage = v
					end
					
					if v and v.Pos ~= nil and (#(coords - vector3(v.DeletePoint.Pos.x , v.DeletePoint.Pos.y, v.DeletePoint.Pos.z)) < v.Size.x) then
						isInMarker  = true
						currentZone = 'delete'
						LZone = v.Zone
						this_Garage = v
					end
				end	
				for _,v in pairs(Config.BikeLocations) do
		
					if #(vector3(v.Pos.x,v.Pos.y,v.Pos.z) - coords) < 1.8 then
						
						isInMarker  = true
						currentZone = 'free_bike'
						LZone = 0
						this_Garage = v
					end
				end
				--[[]
				if PlayerData.job ~= nil and PlayerData.job.name == 'mecano' then
					for _,v in pairs(Config.GaragesMecano) do
						if(GetDistanceBetweenCoords(coords, v.SpawnPoint.Pos.x, v.SpawnPoint.Pos.y, v.SpawnPoint.Pos.z, true) < 3) then
							isInMarker  = true
							currentZone = 'spawnmecano'
							LZone = v.Zone
							this_Garage = v
						end
						
						if(GetDistanceBetweenCoords(coords, v.DeletePoint.Pos.x, v.DeletePoint.Pos.y, v.DeletePoint.Pos.z, true) < 3) then
							isInMarker  = true
							currentZone = 'deletemecano'
							LZone = v.Zone
							this_Garage = v
						end
					end
				end--]]

				if isInMarker and not hasAlreadyEnteredMarker then
					hasAlreadyEnteredMarker = true
					LastZone                = currentZone
					TriggerEvent('720ab0de-aa85-4a7e-914d-d2576745e6fb', currentZone)
				end

				if not isInMarker and hasAlreadyEnteredMarker then
				-- if not isInMarker then
					hasAlreadyEnteredMarker = false
					TriggerEvent('42fb2cc8-6419-4e21-9472-39e5200f100b', LastZone)
				end
			else
				Wait(1000)
			end
		end)
	end
end)


-- Fin activer le menu quand player dedans

-- Controle touche
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(10)

		if closer then
			if CurrentAction ~= nil then

				SetTextComponentFormat('STRING')
				AddTextComponentString(CurrentActionMsg)

				DisplayHelpTextFromStringLabel(0, 0, 1, -1)

				if IsControlPressed(0,  Keys['E']) and (GetGameTimer() - GUI.Time) > 150 then

					if CurrentAction == 'garage_action_menu' then
						OpenMenuGarage()
					end
					
					if CurrentAction == 'free_bike' then
						SpawnBike('tribike')
					end
					
					if CurrentAction == 'garage_spawn' then
						ListVehiclesMenu()
					end
					
					if CurrentAction == 'garage_delete' then
						StockVehicleMenu()
					end
					
					if CurrentAction == 'garagemecano_spawn' then
						ListVehiclesFourriereMenu()
					end
					
					if CurrentAction == 'garagemecano_delete' then
						StockVehicleFourriereMenu()
					end

					CurrentAction = nil
					GUI.Time      = GetGameTimer()

				end
			end
		else
			Wait(1000)
		end
	end
end)
-- Fin controle touche
function dump(o, nb)
  if nb == nil then
    nb = 0
  end
   if type(o) == 'table' then
      local s = ''
      for i = 1, nb + 1, 1 do
        s = s .. "    "
      end
      s = '{\n'
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
          for i = 1, nb, 1 do
            s = s .. "    "
          end
         s = s .. '['..k..'] = ' .. dump(v, nb + 1) .. ',\n'
      end
      for i = 1, nb, 1 do
        s = s .. "    "
      end
      return s .. '}'
   else
      return tostring(o)
   end
end



