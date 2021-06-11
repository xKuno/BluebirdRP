--config
local planeblip = {
		{title="North Yankton Flight", colour=62, id=251, x = -1042.72, y = -2745.96, z = 21.36}
}
--------------code-------------


local anim = false
local menuopend = false

local parkedin = true
local engineoff = nil
local alreadyspawned = false
local inNY = false
local forcedhere = false



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


AddEventHandler('bd42fa56-aa7c-442f-b439-552fe21bdf21', function(resource)
	if resource == GetCurrentResourceName() then
		SetDrawMapVisible(false)
		alreadyspawned = true
		Wait(1500)
		print("North Yankton got started.")
	end
end)

CreateThread(function() -- map blip.
	while true do
		Wait(1)
		
		if inNY then
			DrawMarker(7, 5343.00, -5200.17, 81.5 + 2, 100.0, -80.0, 20.36, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 217, 0, 50, true, false, 2, nil, nil, false) --north yankton
			DrawMarker(1, 5343.00, -5200.17, 79.5 + 2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 217, 0, 50, false, false, 2, nil, nil, false)
			
	--north yankton garage
			DrawMarker(1, 5329.96, -5188.59, 79.78 + 2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.5, 2.5, 1.0, 13, 106, 255, 50, false, false, 2, nil, nil, false)
	--delete vehicle		
			DrawMarker(1, 5330.6, -5182.93, 79.79 + 2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.5, 2.5, 1.0, 13, 106, 255, 50, false, false, 2, nil, nil, false)
	--repair marker	
			DrawMarker(1, 5352.36, -5224.6, 79.84 + 2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 12.0, 12.0, 1.0, 70, 209, 46, 100, false, false, 2, nil, nil, false)
		else
			local ped = GetPlayerPed(-1)
			local ec = GetEntityCoords(ped,true)
			if #(ec - vector3(-1042.72, -2745.96, 20.36))  < 15.0 then
				DrawMarker(7, -1042.72, -2745.96, 20.36 + 2, 100.0, -80.0, 20.36, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 255, 217, 0, 50, true, false, 2, nil, nil, false) --los santos
				DrawMarker(1, -1042.72, -2745.96, 18.36 + 2, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.5, 1.5, 1.5, 255, 217, 0, 50, false, false, 2, nil, nil, false)
			else
				Wait(3000)
			end
		end
	end
end)

Citizen.CreateThread(function()	-- adds the blips to the map.

    for _, info in pairs(planeblip) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 4)
      SetBlipScale(info.blip, 1.0)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)


Citizen.CreateThread(function()

	while true do
		Citizen.Wait(15)
		local ped = GetPlayerPed(-1)
		local ec = GetEntityCoords(ped,true)
		
		if inLSpos(ec) then --open menu
			ShowMessageTop("press ~INPUT_CONTEXT~ to open the flight menu")
			if IsControlJustPressed(0, 51) then --51 -> E
				OpenLosSantosMenu()
			end
		elseif InNYradius(ec) then
			if InNYpos(ec) then
				ShowMessageTop("press ~INPUT_CONTEXT~ to open the flight menu")
				if IsControlJustPressed(0, 51) then --51 -> E
					OpenNorthYanktonMenu()
				end
			elseif InRepairpos(ec) then
				ShowMessageTop("press ~INPUT_CONTEXT~ to report a crashed / lost car")
				if IsControlJustPressed(0, 51) then --51 -> E
					brokencar()
				end
			elseif InGaragepos(ec) then
				ShowMessageTop("press ~INPUT_CONTEXT~ to open the garage")
				if IsControlJustPressed(0, 51) then --51 -> E
					OpenGarageMenu()
				end
			elseif InDeletepos(ec) then
				if IsPedInAnyVehicle(ped) then
					ShowMessageTop("press ~INPUT_CONTEXT~ to park your vehicle")
				end
				if IsControlJustPressed(0, 51) then --51 -> E
				
					local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
					if GetVehicleBodyHealth(vehicle) >= 980 then
						SetEntityAsMissionEntity(vehicle, true, true)
						DeleteVehicle(vehicle)
						parkedin = true
					elseif GetVehicleBodyHealth(vehicle) >= 940 and GetVehicleBodyHealth(vehicle) < 980 then
						TriggerServerEvent('1f0c27a4-8ead-4f20-be14-b21cad8ab900')
						SetEntityAsMissionEntity(vehicle, true, true)
						DeleteVehicle(vehicle)
						parkedin = true
						ShowMessage("Sorry, but you have to pay for the damage. the money has been taken from your ~r~bankaccount~w~")			
					elseif GetVehicleBodyHealth(vehicle) >= 800 and GetVehicleBodyHealth(vehicle) < 940 then
						TriggerServerEvent('1232b274-9597-48ac-a490-d8b20dcb0f18')
						SetEntityAsMissionEntity(vehicle, true, true)
						DeleteVehicle(vehicle)
						parkedin = true
						ShowMessage("Sorry, but you have to pay for the damage. the money has been taken from your ~r~bankaccount~w~")	
					elseif GetVehicleBodyHealth(vehicle) < 800 then
						TriggerServerEvent('48dd9b4f-518e-4bf3-8605-2444daeefeff')
						SetEntityAsMissionEntity(vehicle, true, true)
						DeleteVehicle(vehicle)
						parkedin = true
						ShowMessage("Sorry, but you have to pay for the damage. the money has been taken from your ~r~bankaccount~w~")	
					end
					elseif menuopend == true and not inLSpos(ec) then
						ESX.UI.Menu.CloseAll()
						menuopend = false
				end

			end
		else
			Wait(2000)
		end
	end
end)

RegisterCommand("getvehiclehealth", function()
local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
	print(GetVehicleBodyHealth(vehicle))
end)	
	

RegisterNetEvent('507ff162-5cb7-4302-a879-f2682eab77d1')
AddEventHandler('507ff162-5cb7-4302-a879-f2682eab77d1', function()
	ShowMessage('Cause you got no money, we couldnt withdraw money from your account.')
	--well we can't really do something here, if he rans out of money we can only take our car back
end)
		

		
function inLSpos(scoord)
	if scoord ~= nil and #(scoord - vector3(-1042.72, -2745.96, 20.36))  < 2.0 then
		return true
	else
		return false
	end
end

function InRepairpos(scoord)	
	if scoord ~= nil and #(scoord - vector3( 5352.36, -5224.6, 82.84))  < 5.0 then
		return true
	else
		return false
	end
end

function InNYpos(scoord)

	if scoord ~= nil and #(scoord - vector3( 5352.36, -5224.6, 82.84))  < 3.0 then
		return true
	else
		return false
	end

end

function InGaragepos(scoord)

	if scoord ~= nil and #(scoord - vector3(5329.96, -5188.59, 81.78))  < 2.0 then
		return true
	else
		return false
	end

end

function InDeletepos(scoord)

	if scoord ~= nil and #(scoord - vector3( 5330.6, -5182.93, 81.79))  < 1.6 then
		return true
	else
		return false
	end

end

function InNYradius(scoord)

	if scoord ~= nil and #(scoord - vector3(4395.37, -5093.08, 110.17))  < 2000 then
		return true
	else
		return false
	end

end

RegisterCommand("showmap", function(source, args, rawCommand)
	local args = table.concat(args, " ")
	
	SetDrawMapVisible(args)
end)

AddEventHandler('880c0a93-b305-46b3-b84c-a120fee9e841', function(spawn)
	if spawn and not InNYradius() then
		alreadyspawned = true
	else
		if alreadyspawned == false then
			--LSfly()
			--ShowMessage("It has been discovered that your spawning point is in North Yankton. [Return LS]")
			alreadyspawned = true
		end
	end
end)

function ShowMessageTop(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end


--menu's--
function OpenLosSantosMenu()
	menuopend = true
	local playerPed = PlayerPedId()

	local elements = {
		{ label = 'North Yankton', value = 'n_yank' }
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Flyplan', {
		title    = 'Flyplan',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'n_yank' then
			OpenNYMenu()
		end
	end)
end

function OpenNorthYanktonMenu()
	menuopend = true
	local playerPed = PlayerPedId()

	local elements = {
		{ label = 'Los Santos Airport', value = 'l_airport' }
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Flyplan', {
		title    = 'Flyplan',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'l_airport' then
			OpenLSMenu()
		end
	end)
end

function OpenGarageMenu()
	menuopend = true
	local playerPed = PlayerPedId()

	local elements = {
		{ label = 'Kamacho -- '..Config.PreisKamacho, value = 'kamacho' }, --change value to some vehicle spawn names you want to use
		{ label = 'Rancher XL -- '..Config.PreisRancher, value = 'emperor3' },
		{ label = 'Vapid Sadler -- '..Config.PreisVapid, value = 'sadler2' },
		{ label = 'Declasse Burrito -- '..Config.PreisBurrito, value = 'burrito5' },
		{ label = 'Declasse Asea -- '..Config.PreisAsea, value = 'asea2' }
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicles', {
		title    = 'vehicles',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		local selected = data.current.value
		if data.current.value then
			RequestModel(selected)
 			while not HasModelLoaded(selected) or not HasCollisionForModelLoaded(selected) do
				Wait(1)
 			end
			spawncar(selected)
			buy(selected)
		end
	end)
end


function spawncar(selected)
	car = CreateVehicle(selected, 5329.96, -5188.59, 81.78, math.random(), true, true)
	SetEntityHeading(car, 267.78)
	TaskWarpPedIntoVehicle(GetPlayerPed(-1), car, -1)
	ESX.UI.Menu.CloseAll()
end

function buy(selected)
	menuopend = false --this way the menu can't be closed
	engineoff = true --stops the engine, so he can't drive
	local playerPed = PlayerPedId()

	local elements = {
		{ label = 'do you really want to rent the vehicle?', value = 'not_choose_able' },
		{ label = 'Yes', value = 'choose_yes' },
		{ label = 'No', value = 'choose_no' },
		{ label = 'back to the vehicle menu', value = 'choose_back' }
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'LeihMenü', {
		title    = 'Rent-menu',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
			local selcar = data.current.value
		if selcar == 'choose_yes' then
			parkedin = false
			ESX.UI.Menu.CloseAll()
			engineoff = nil
			ShowMessage("~g~ok, have fun with the car, but dont forget, every half our costs money.")
			setprice(selected)
		elseif selcar == 'choose_no' then
			local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
			SetEntityAsMissionEntity(vehicle, true, true)
			DeleteVehicle(vehicle)
			parkedin = true
			engineoff = nil
			ESX.UI.Menu.CloseAll()
			ShowMessage("~b~ok, maybe anothertime.")
		elseif selcar == 'choose_back' then
			local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
			SetEntityAsMissionEntity(vehicle, true, true)
			DeleteVehicle(vehicle)
			parkedin = true
			engineoff = nil
			OpenGarageMenu()
		end
	end)
end

RegisterNetEvent('d06608fb-b240-46bf-9866-a4dee71c8d6b')
AddEventHandler('d06608fb-b240-46bf-9866-a4dee71c8d6b', function()
	if IsPedInAnyVehicle(PlayerPedId(), true) then
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
		SetEntityAsMissionEntity(vehicle, true, true)
		DeleteVehicle(vehicle)
		parkedin = true
		ShowMessage('~r~Your vehicle has been parked, cause you couldnt pay it.')
	elseif GetPlayersLastVehicle() ~= nil then
		local vehicle = GetPlayersLastVehicle()
		SetEntityAsMissionEntity(vehicle, true, true)
		DeleteVehicle(vehicle)
		parkedin = true
		ShowMessage('~r~Your vehicle has been parked, cause you couldnt pay it.')
	else
		ShowMessage("~r~something went wrong, please park your car for the fairness because you do not have enough money left to rent the vehicle.")
	end
end)

function setprice(selected)

	Wait(1800000)
	--Wait(5000) --für Test Zwecke
	if parkedin == false then
		TriggerServerEvent("take"..selected.."money", selected)
		ShowMessage("~g~you've payed the rent of the vehicle.")
	end
end



--[[
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		if engineoff == true then
		local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
			SetVehicleEngineOn(vehicle, false, false, false)
		elseif engineoff == false then
			local vehicle = GetVehiclePedIsIn(PlayerPedId(), false)
			SetVehicleEngineOn(vehicle, true, true, true)
		end
	end
end)--]]


Citizen.CreateThread(function()
	while true do
		Citizen.Wait(1000)
		
		if inNY == true then
			if IsEntityDead(GetPlayerPed(-1)) or IsPedRagdoll(GetPlayerPed(-1)) then
				if forcedhere then
					TriggerEvent('c97adeb3-14e4-4be0-b519-a93d5ee530f3')
				else
					LSflyI()
				end
				
			end
		else
			Wait(10000)
		end
		
	end
end)


RegisterNetEvent('72f4b650-e8d0-4673-b52c-07debc199102')
AddEventHandler('72f4b650-e8d0-4673-b52c-07debc199102', function(carchosen)
	
	setprice(carchosen)
end)
			
	
		
function OpenNYMenu()
	local playerPed = PlayerPedId()
	local source = source

	local elements = {
		{ label = 'Do you want to travel? Price: '..Config.northyanktflyprice..'$', value = 'not_choose_able' },
		{ label = 'Yes', value = 'accept' },
		{ label = 'No', value = 'disaccept' },
		{ label = 'Use daily ticket', value = 'get_ticket' },
		{ label = 'Use the faction ticket', value = 'get_jobticket' }
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Flyplan', {
		title    = 'Flyplan',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'accept' then
			TriggerServerEvent('9360ec51-b481-4a33-9202-1c3fcfb61a3b')
			ESX.UI.Menu.CloseAll()
		elseif data.current.value == 'disaccept' then
			ESX.UI.Menu.CloseAll()
		elseif data.current.value == 'get_ticket' then
			TriggerServerEvent('11fe693d-a525-4ecb-8244-81b86ddd20e3')
		elseif data.current.value == 'get_jobticket' then
			TriggerServerEvent('ba604527-1591-49fb-b5b8-23dc79771d0a')
		end
	end)
end

RegisterNetEvent('c9e17544-4e59-44b3-a591-9f6772c7f387')

AddEventHandler('c9e17544-4e59-44b3-a591-9f6772c7f387', function()
	_source = source
		ShowMessage('~r~You are not in an authorized faction!~s~')
		TriggerEvent('1d3fc604-f865-47e9-97f8-e2193b7d5e3a')
end)

RegisterNetEvent('56e9baa8-4617-4dff-bd97-3348489a52fa')
AddEventHandler('56e9baa8-4617-4dff-bd97-3348489a52fa', function()
	local _source = source
	noticket()
end)

RegisterNetEvent('1d3fc604-f865-47e9-97f8-e2193b7d5e3a')
AddEventHandler('1d3fc604-f865-47e9-97f8-e2193b7d5e3a', function()
	local _source = source
	ESX.UI.Menu.CloseAll()
end)

		
function noticket()
	local playerPed = PlayerPedId()
	local source = source
	
	

	local elements = {
		{ label = 'Do you want to buy a day ticket?', value = 'not_choose_able' },
		{ label = 'Yes', value = 'accept_buy' },
		{ label = 'No', value = 'disaccept_buy' }
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ticket-sales', {
		title    = 'ticket-sales',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'accept_buy' then
			buyticket()
		elseif data.current.value == 'disaccept_buy' then
			ESX.UI.Menu.CloseAll()
		end
	end)
end

function buyticket()
	local playerPed = PlayerPedId()
	local source = source

	local elements = {
		{ label = 'please accept to buy it for: '..Config.ticketprice..'$', value = 'not_choose_able' },
		{ label = 'Yes', value = 'accept_buyticket' },
		{ label = 'No', value = 'disaccept_buyticket' }
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'ticket-sales', {
		title    = 'ticket-sales',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'accept_buyticket' then
			TriggerServerEvent('04076c88-4da5-4495-b5b1-475a8ce170ea')
		elseif data.current.value == 'disaccept_buyticket' then
			ESX.UI.Menu.CloseAll()
		end
	end)
end

RegisterNetEvent('306cfcdf-46cf-4915-bb77-168ba9f8f3a3')
AddEventHandler('306cfcdf-46cf-4915-bb77-168ba9f8f3a3', function()
	local ped = GetPlayerPed(-1)
	local ec = GetEntityCoords(ped,true)
	if inLSpos(ec) then
		TriggerEvent('1d3fc604-f865-47e9-97f8-e2193b7d5e3a')
		NYfly()
	elseif InNYpos(ec) then
		TriggerEvent('1d3fc604-f865-47e9-97f8-e2193b7d5e3a')
		LSfly()
	else
		ShowMessage('~r~You are not near an airport...')
		TriggerEvent('1d3fc604-f865-47e9-97f8-e2193b7d5e3a')
		TriggerServerEvent('85611ff8-41b5-4b48-8b0a-83baf774da71', "Someone has tried to fly outside of the flight zone..("..GetPlayerName(PlayerId())..")")
	end
end)
		
function brokencar()
	local playerPed = PlayerPedId()
	local source = source

	local elements = {
		{ label = 'Your car is broken and you can not fix it?', value = 'not_choose_able' },
		{ label = 'Yes', value = 'accept_broken' },
		{ label = 'No', value = 'disaccept_broken' }
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Vehicledamage', {
		title    = 'Vehicledamage',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'accept_broken' then
			repaircosts()
		elseif data.current.value == 'disaccept_broken' then
			ESX.UI.Menu.CloseAll()
		end
	end)
end

function repaircosts()
	local playerPed = PlayerPedId()
	local source = source

	local elements = {
		{ label = 'The cost for the damage amount '..Config.invoicepay..'$', value = 'not_choose_able' },
		{ label = 'I pay now.', value = 'buy_costs' },
		{ label = 'I can not afford that', value = 'cant_buy' }
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Cehicledamage', {
		title    = 'Vehicledamage',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'buy_costs' and parkedin == false then
			TriggerServerEvent('41a6a5a4-dfaf-4aaa-ae3a-03c76d8c499f')
			ESX.UI.Menu.CloseAll()
		elseif data.current.value == 'cant_buy'then
			ESX.UI.Menu.CloseAll()
		else
			ShowMessage("~r~you haven't rented a vehicle!")
			ESX.UI.Menu.CloseAll()				
		end
	end)
end

RegisterNetEvent('5dd7fc70-0fb5-4f5d-9203-4ec1748545d8')
AddEventHandler('5dd7fc70-0fb5-4f5d-9203-4ec1748545d8', function()
	parkedin = true
end)

function OpenLSMenu()
	local playerPed = PlayerPedId()

	local elements = {
		{ label = 'Are you sure you want to go there? Price: '..Config.lossantosflyprice..'$', value = 'not_choose_able' },
		{ label = 'Yes', value = 'accept' },
		{ label = 'No', value = 'disaccept' },
		{ label = 'Use day ticket', value = 'get_ticket' },
		{ label = 'Use faction ticket', value = 'get_jobticket' }
	}

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'Flugplan', {
		title    = 'Flugplan',
		align    = 'top-left',
		elements = elements
	}, function(data, menu)
		if data.current.value == 'accept' then
			TriggerServerEvent('d92f8fde-4f34-4c18-81c4-e8935b3a15ef')				
		elseif data.current.value == 'disaccept' then
			ESX.UI.Menu.CloseAll()
		elseif data.current.value == 'get_ticket' then
			TriggerServerEvent('11fe693d-a525-4ecb-8244-81b86ddd20e3')
		elseif data.current.value == 'get_jobticket' then
			TriggerServerEvent('ba604527-1591-49fb-b5b8-23dc79771d0a')
		end
	end)
end

RegisterNetEvent('00a7110e-a3ed-46be-9fe1-fc39b0e959cb')
AddEventHandler('00a7110e-a3ed-46be-9fe1-fc39b0e959cb', function()
local _source = source
	NYfly()
	ESX.UI.Menu.CloseAll()
end)

RegisterNetEvent('23f11958-bf9f-4357-957b-afd00a8922f5')
AddEventHandler('23f11958-bf9f-4357-957b-afd00a8922f5', function()
local _source = source
	LSfly()
	ESX.UI.Menu.CloseAll()
end)

RegisterNetEvent('ef9696f7-cb23-43dc-9c1b-4bd996ec3f4b')
AddEventHandler('ef9696f7-cb23-43dc-9c1b-4bd996ec3f4b', function()
local _source = source
	ShowMessage("~r~You have not enough money!")
	ESX.UI.Menu.CloseAll()
end)

function ShowMessage(message)
	SetNotificationTextEntry("STRING") -- shows a message above the map.
	AddTextComponentString(message)
	DrawNotification(0,1)
end


RegisterNetEvent('2a50e48e-31f7-45f0-b7a5-1704c89290a7')
AddEventHandler('2a50e48e-31f7-45f0-b7a5-1704c89290a7', function()

	ShowMessage('~g~You have bought a ticket for '..Config.ticketprice..'$')
end)

RegisterNetEvent('bb31beec-8df9-418a-86f8-e737de6c0890')
AddEventHandler('bb31beec-8df9-418a-86f8-e737de6c0890', function()
	
	ShowMessage('~r~You have no cash and your account is empty...')
end)

function NYfly()
	DoScreenFadeOut(1000) --first part
	Wait(1000)
	NYIpl()
	
	SetEntityCoords(GetPlayerPed(-1), tonumber(514.77), tonumber(4752.67), tonumber(-69) + 0.0, 1, 0, 0, 1) --part two
	SetEntityHeading(GetPlayerPed(-1), 174.76)
	FreezeEntityPosition(GetPlayerPed(-1), true)
	DoScreenFadeIn(1000)
	Wait(1000)
	FreezeEntityPosition(GetPlayerPed(-1), false)

	 --part three
	anim = true
	Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if anim == true then
			local pid = PlayerPedId()
			RequestAnimDict("amb@world_human_leaning@male@wall@back@mobile@exit")
			while (not HasAnimDictLoaded("amb@world_human_leaning@male@wall@back@mobile@exit")) do Citizen.Wait(0) end
			TaskPlayAnim(pid,"amb@world_human_leaning@male@wall@back@mobile@exit", "mobile_to_text_transition" ,1.0,-1.0, 5000, 0, 1, true, true, true)
		else
			Wait(500)
			return
		end
	end
	end)
	Wait(10000)
	  checks = {"FIBlobbyfake",
	  "DT1_03_Gr_Closed",
	  "v_tunnel_hole",
	  "TrevorsMP",
	  "TrevorsTrailer",
	  "farm",
	  "farmint",
	  "farmint_cap",
	  "farm_props",
	  "CS1_02_cf_offmission",
	  "prologue01",
	  "prologue01c",
	  "prologue01d",
	  "prologue01e",
	  "prologue01f",
	  "prologue01g",
	  "prologue01h",
	  "prologue01i",
	  "prologue01j",
	  "prologue01k",
	  "prologue01z",
	  "prologue02",
	  "prologue03",
	  "prologue03b",
	  "prologue04",
	  "prologue04b",
	  "prologue05",
	  "prologue05b",
	  "prologue06",
	  "prologue06b",
	  "prologue06_int",
	  "prologuerd",
	  "prologuerdb ",
	  "prologue_DistantLights",
	  "prologue_LODLights",
	  "prologue_m2_door"
	  }
	 
	 while allactive == false do
		local allactive = true
		for _, info in pairs(checks) do
			if IsIplActive(info) == false then 
				allactive = false
			end
		end
		Wait(10)
	 end
	  

	DoScreenFadeOut(1000)
	Wait(1000)
	anim = false
	SetEntityCoords(GetPlayerPed(-1), tonumber(5338.01), tonumber(-5215.3), tonumber(81.71) + 0.0, 1, 0, 0, 1)
	SetEntityHeading(GetPlayerPed(-1), 275.27)
	Wait(4000)
	FreezeEntityPosition(GetPlayerPed(-1), true) -- go sure that he does not fall through the map.
	SetDrawMapVisible(true)
	--Wait(8000)
	
	Citizen.CreateThread(function()
		print('##PENDING CHECKS FOR LOCATION AND DIRECTION')
		Wait(8000)
		local coords = GetEntityCoords(PlayerPedId())
		print('checking for location and direction')
		if coords.z < 78 then
			--Protection
			ESX.ShowNotification("Your ~b~plane ~w~is ~r~crashing~w~ we're trying to save you!")
			Wait(1000)
			ESX.ShowNotification("Use ~b~/fixmepls ~w~in chat if you end up in the water!")
			Wait(1000)
			SetEntityCoords(GetPlayerPed(-1), tonumber(5338.01), tonumber(-5215.3), tonumber(81.71) + 0.0, 1, 0, 0, 1)
			SetEntityHeading(GetPlayerPed(-1), 275.27)
		end
	end)
	FreezeEntityPosition(GetPlayerPed(-1), false) --unfreeze him.
	DoScreenFadeIn(1000)
	
	inNY = true
end

local finalloc = {x = 5.8368015289307, y =6508.341796875, z = 31.877853393555} 



function NYappear(x,y,z)
	NYIpl()
	finalloc.x = x
	finalloc.y = y
	finalloc.z = z
	  checks = {"FIBlobbyfake",
	  "DT1_03_Gr_Closed",
	  "v_tunnel_hole",
	  "TrevorsMP",
	  "TrevorsTrailer",
	  "farm",
	  "farmint",
	  "farmint_cap",
	  "farm_props",
	  "CS1_02_cf_offmission",
	  "prologue01",
	  "prologue01c",
	  "prologue01d",
	  "prologue01e",
	  "prologue01f",
	  "prologue01g",
	  "prologue01h",
	  "prologue01i",
	  "prologue01j",
	  "prologue01k",
	  "prologue01z",
	  "prologue02",
	  "prologue03",
	  "prologue03b",
	  "prologue04",
	  "prologue04b",
	  "prologue05",
	  "prologue05b",
	  "prologue06",
	  "prologue06b",
	  "prologue06_int",
	  "prologuerd",
	  "prologuerdb ",
	  "prologue_DistantLights",
	  "prologue_LODLights",
	  "prologue_m2_door"
	  }
	 
	 while allactive == false do
		local allactive = true
		for _, info in pairs(checks) do
			if IsIplActive(info) == false then 
				allactive = false
			end
		end
	 end
	SetEntityCoords(GetPlayerPed(-1), tonumber(514.77), tonumber(4752.67), tonumber(-69) + 0.0, 1, 0, 0, 1)
	SetEntityHeading(GetPlayerPed(-1), 174.76)
	Wait(2400)
	SetEntityCoords(GetPlayerPed(-1), tonumber(5306.11), tonumber(-5212.34), tonumber(83.50) + 0.0, 1, 0, 0, 1)
	SetEntityHeading(GetPlayerPed(-1), 275.27)
	FreezeEntityPosition(GetPlayerPed(-1), true) -- go sure that he does not fall through the map.
	Wait(2000)
	SetDrawMapVisible(true)
	
	FreezeEntityPosition(GetPlayerPed(-1), false) --unfreeze him.
	Citizen.CreateThread(function()
		print('##PENDING CHECKS FOR LOCATION AND DIRECTION')
		Wait(8000)
		local coords = GetEntityCoords(PlayerPedId())
		print('checking for location and direction')
		if coords.z < 78 then
			--Protection
			ESX.ShowNotification("Your ~b~plane ~w~is ~r~crashing~w~ we're trying to save you!")
			Wait(1000)
			ESX.ShowNotification("Use ~b~/fixmepls ~w~in chat if you end up in the water!")
			Wait(1000)
			SetEntityCoords(GetPlayerPed(-1), tonumber(5306.11), tonumber(-5212.34), tonumber(83.50) + 0.0, 1, 0, 0, 1)
			SetEntityHeading(GetPlayerPed(-1), 275.27)
		end
	end)
	inNY = true
	SetEntityInvincible(GetPlayerPed(-1),true)
	forcedhere = true
end


function NYLeave()
	SetEntityInvincible(GetPlayerPed(-1),false)
	DoScreenFadeOut(1000) --first part
	Wait(1000)
	unlNYipl()
	
	SetEntityCoords(GetPlayerPed(-1), tonumber(514.77), tonumber(4752.67), tonumber(-69) + 0.0, 1, 0, 0, 1) --part two
	SetEntityHeading(GetPlayerPed(-1), 174.76)
	FreezeEntityPosition(GetPlayerPed(-1), true)
	SetDrawMapVisible(false)
	Wait(1000)
	
	DoScreenFadeIn(1000) --part three
	FreezeEntityPosition(GetPlayerPed(-1), false)
	anim = true
	Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if anim == true then
			local pid = PlayerPedId()
			RequestAnimDict("amb@world_human_leaning@male@wall@back@mobile@exit")
			while (not HasAnimDictLoaded("amb@world_human_leaning@male@wall@back@mobile@exit")) do Citizen.Wait(0) end
			TaskPlayAnim(pid,"amb@world_human_leaning@male@wall@back@mobile@exit", "mobile_to_text_transition" ,1.0,-1.0, 5000, 0, 1, true, true, true)
		else
			Wait(500)
			return
		end
	end
	end)
	Wait(10000)
	
	DoScreenFadeOut(1000)
	
	Wait(1000)
	anim = false
	SetEntityCoords(GetPlayerPed(-1), tonumber(finalloc.x), tonumber(finalloc.y), tonumber(finalloc.z) + 0.0, 1, 0, 0, 1)
	SetEntityHeading(GetPlayerPed(-1), 327.68)
	FreezeEntityPosition(GetPlayerPed(-1), true) -- go sure that he does not fall through the map.
	Wait(2000)
	FreezeEntityPosition(GetPlayerPed(-1), false) --unfreeze him.
	DoScreenFadeIn(1000)
	inNY = false

end




function LSfly()
	SetEntityInvincible(GetPlayerPed(-1),false)
	DoScreenFadeOut(1000) --first part
	Wait(1000)
	unlNYipl()
	
	SetEntityCoords(GetPlayerPed(-1), tonumber(514.77), tonumber(4752.67), tonumber(-69) + 0.0, 1, 0, 0, 1) --part two
	SetEntityHeading(GetPlayerPed(-1), 174.76)
	FreezeEntityPosition(GetPlayerPed(-1), true)
	SetDrawMapVisible(false)
	Wait(1000)
	
	DoScreenFadeIn(1000) --part three
	FreezeEntityPosition(GetPlayerPed(-1), false)
	anim = true
	Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if anim == true then
			local pid = PlayerPedId()
			RequestAnimDict("amb@world_human_leaning@male@wall@back@mobile@exit")
			while (not HasAnimDictLoaded("amb@world_human_leaning@male@wall@back@mobile@exit")) do Citizen.Wait(0) end
			TaskPlayAnim(pid,"amb@world_human_leaning@male@wall@back@mobile@exit", "mobile_to_text_transition" ,1.0,-1.0, 5000, 0, 1, true, true, true)
		else
			Wait(500)
			return
		end
	end
	end)
	Wait(10000)
	
	DoScreenFadeOut(1000)
	
	Wait(1000)
	anim = false
	SetEntityCoords(GetPlayerPed(-1), tonumber(-1038.64), tonumber(-2739.79), tonumber(19.17) + 0.0, 1, 0, 0, 1)
	SetEntityHeading(GetPlayerPed(-1), 327.68)
	FreezeEntityPosition(GetPlayerPed(-1), true) -- go sure that he does not fall through the map.
	Wait(2000)
	FreezeEntityPosition(GetPlayerPed(-1), false) --unfreeze him.
	DoScreenFadeIn(1000)
	inNY = false
end


function LSflyI()
	DoScreenFadeOut(1000) --first part
	Wait(1000)
	unlNYipl()
	
	SetEntityCoords(GetPlayerPed(-1), tonumber(514.77), tonumber(4752.67), tonumber(-69) + 0.0, 1, 0, 0, 1) --part two
	SetEntityHeading(GetPlayerPed(-1), 174.76)
	FreezeEntityPosition(GetPlayerPed(-1), true)
	SetDrawMapVisible(false)
	Wait(1000)
	
	DoScreenFadeIn(1000) --part three
	FreezeEntityPosition(GetPlayerPed(-1), false)
	anim = true
	Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if anim == true then
			local pid = PlayerPedId()
			RequestAnimDict("amb@world_human_leaning@male@wall@back@mobile@exit")
			while (not HasAnimDictLoaded("amb@world_human_leaning@male@wall@back@mobile@exit")) do Citizen.Wait(0) end
			TaskPlayAnim(pid,"amb@world_human_leaning@male@wall@back@mobile@exit", "mobile_to_text_transition" ,1.0,-1.0, 5000, 0, 1, true, true, true)
		else
			Wait(500)
			return
		end
	end
	end)
	Wait(1500)
	
	DoScreenFadeOut(1000)
	
	Wait(1000)
	anim = false
	SetEntityCoords(GetPlayerPed(-1), tonumber(-1038.64), tonumber(-2739.79), tonumber(19.17) + 0.0, 1, 0, 0, 1)
	SetEntityHeading(GetPlayerPed(-1), 327.68)
	FreezeEntityPosition(GetPlayerPed(-1), true) -- go sure that he does not fall through the map.
	Wait(1000)
	FreezeEntityPosition(GetPlayerPed(-1), false) --unfreeze him.
	DoScreenFadeIn(1000)
	inNY = false
end






Citizen.CreateThread(function()
	while true do
	Citizen.Wait(0)
		if menuopend == true then
			if IsControlJustPressed(0, 177) then
				ESX.UI.Menu.CloseAll()
				menuopend = false
			end
		else
			Wait(200)
		end
	end
end)


RegisterNetEvent('236f7897-9bca-4409-8e05-0930ee3ad7eb')
AddEventHandler('236f7897-9bca-4409-8e05-0930ee3ad7eb', function()

local item = 'fly-ticket'

	if source ~= nil then
		TriggerServerEvent('da67402d-4060-4efb-82f6-ed60f0c1f5e8', item)
	end
end)



-------------ipls--------------

function NYIpl()
--load unloaded ipl's
  LoadMpDlcMaps()
  EnableMpDlcMaps(true)
  RequestIpl("FIBlobbyfake")
  RequestIpl("DT1_03_Gr_Closed")
  RequestIpl("v_tunnel_hole")
  RequestIpl("TrevorsMP")
  RequestIpl("TrevorsTrailer")
  RequestIpl("farm")
  RequestIpl("farmint")
  RequestIpl("farmint_cap")
  RequestIpl("farm_props")
  RequestIpl("CS1_02_cf_offmission")
  RequestIpl("prologue01")
  RequestIpl("prologue01c")
  RequestIpl("prologue01d")
  RequestIpl("prologue01e")
  RequestIpl("prologue01f")
  RequestIpl("prologue01g")
  RequestIpl("prologue01h")
  RequestIpl("prologue01i")
  RequestIpl("prologue01j")
  RequestIpl("prologue01k")
  RequestIpl("prologue01z")
  RequestIpl("prologue02")
  RequestIpl("prologue03")
  RequestIpl("prologue03b")
  RequestIpl("prologue04")
  RequestIpl("prologue04b")
  RequestIpl("prologue05")
  RequestIpl("prologue05b")
  RequestIpl("prologue06")
  RequestIpl("prologue06b")
  RequestIpl("prologue06_int")
  RequestIpl("prologuerd")
  RequestIpl("prologuerdb ")
  RequestIpl("prologue_DistantLights")
  RequestIpl("prologue_LODLights")
  RequestIpl("prologue_m2_door")  
end

function unlNYipl()
  LoadMpDlcMaps()
  EnableMpDlcMaps(false)
  RemoveIpl("FIBlobbyfake")
  RemoveIpl("DT1_03_Gr_Closed")
  RemoveIpl("v_tunnel_hole")
  RemoveIpl("TrevorsMP")
  RemoveIpl("TrevorsTrailer")
  RemoveIpl("farm")
  RemoveIpl("farmint")
  RemoveIpl("farmint_cap")
  RemoveIpl("farm_props")
  RemoveIpl("CS1_02_cf_offmission")
  RemoveIpl("prologue01")
  RemoveIpl("prologue01c")
  RemoveIpl("prologue01d")
  RemoveIpl("prologue01e")
  RemoveIpl("prologue01f")
  RemoveIpl("prologue01g")
  RemoveIpl("prologue01h")
  RemoveIpl("prologue01i")
  RemoveIpl("prologue01j")
  RemoveIpl("prologue01k")
  RemoveIpl("prologue01z")
  RemoveIpl("prologue02")
  RemoveIpl("prologue03")
  RemoveIpl("prologue03b")
  RemoveIpl("prologue04")
  RemoveIpl("prologue04b")
  RemoveIpl("prologue05")
  RemoveIpl("prologue05b")
  RemoveIpl("prologue06")
  RemoveIpl("prologue06b")
  RemoveIpl("prologue06_int")
  RemoveIpl("prologuerd")
  RemoveIpl("prologuerdb ")
  RemoveIpl("prologue_DistantLights")
  RemoveIpl("prologue_LODLights")
  RemoveIpl("prologue_m2_door") 
end
