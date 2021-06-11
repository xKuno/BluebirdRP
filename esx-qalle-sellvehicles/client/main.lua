ESX = nil

PlayerData = {}
local GUI							= {}
GUI.Time							= 0

local spawnedvehciles = false

Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(10)

        TriggerEvent('esx:getSharedObject', function(response)
            ESX = response
        end)
    end

    if ESX.IsPlayerLoaded() then
		PlayerData = ESX.GetPlayerData()

		RemoveVehicles()

		Citizen.Wait(500)
		
		LoadSellPlace()
		spawnedvehciles = false
		--SpawnVehicles()
    end
end)

RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(response)
	PlayerData = response
	
	LoadSellPlace()
	spawnedvehciles = false
	--SpawnVehicles()
end)

RegisterNetEvent('7695da53-7901-462a-b8a8-fbd505a15efb')
AddEventHandler('7695da53-7901-462a-b8a8-fbd505a15efb', function()
	RemoveVehicles()

	Citizen.Wait(500)
	spawnedvehciles = false
	
	--SpawnVehicles()
end)

function LoadSellPlace()
	Citizen.CreateThread(function()

		local SellPos = Config.SellPosition

		local Blip = AddBlipForCoord(SellPos["x"], SellPos["y"], SellPos["z"])
		SetBlipSprite (Blip, 225)
		SetBlipDisplay(Blip, 4)
		SetBlipScale  (Blip, 1.0)
		SetBlipColour (Blip, 46)
		SetBlipAsShortRange(Blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString("Used Cars")
		EndTextCommandSetBlipName(Blip)
		

		while true do
			local sleepThread = 700
			
			local ped = PlayerPedId()
			local pedCoords = GetEntityCoords(ped)
			
			local dstCheck = GetDistanceBetweenCoords(pedCoords, SellPos["x"], SellPos["y"], SellPos["z"], true)
			--Marker
			DrawMarker(36, SellPos["x"],SellPos["y"], SellPos["z"], 0.0, 0.0, 0.0, 0, 0.0, 0.0, 3.0, 3.0, 3.0, 0, 0, 255, 100, false, true, 2, false, false, false, false)	


			if dstCheck >= 25.0 and dstCheck <= 60.0 then
				sleepThread = 15
				if spawnedvehciles == false then
					spawnedvehciles = true
					SpawnVehicles()
				end
				
			elseif dstCheck < 25.0 then
				sleepThread = 5
				if spawnedvehciles == false then
					spawnedvehciles = true
					SpawnVehicles()
				end
				if dstCheck <= 4.2 then
					ESX.Game.Utils.DrawText3D(SellPos, "[E] Open Menu", 0.4)
					if IsControlJustPressed(0, 38) then
						if IsPedInAnyVehicle(ped, false) then
							OpenSellMenu(GetVehiclePedIsUsing(ped))
						else
							ESX.ShowNotification("You must sit in a ~g~vehicle")
						end
					end
				end
			else
				if spawnedvehciles == true then
					spawnedvehciles = false
					RemoveVehicles()
				end
				
			end

			for i = 1, #Config.VehiclePositions, 1 do
				if Config.VehiclePositions[i]["entityId"] ~= nil then
					local pedCoords = GetEntityCoords(ped)
					local vehCoords = GetEntityCoords(Config.VehiclePositions[i]["entityId"])

					local dstCheck = GetDistanceBetweenCoords(pedCoords, vehCoords, true)

					if dstCheck <= 2.0 then
						sleepThread = 5

						ESX.Game.Utils.DrawText3D(vehCoords, "[E] " .. Config.VehiclePositions[i]["price"] .. ":-", 0.4)

						if IsControlJustPressed(0, 38) then
							if IsPedInVehicle(ped, Config.VehiclePositions[i]["entityId"], false) then
								OpenSellMenu(Config.VehiclePositions[i]["entityId"], Config.VehiclePositions[i]["price"], true, Config.VehiclePositions[i]["owner"])
							else
								ESX.ShowNotification("You must sit in the ~g~vehicle~s~!")
							end
						end
					end
				end
			end

			Citizen.Wait(sleepThread)
		end
	end)
end

function OpenSellMenu(veh, price, buyVehicle, owner)
	local elements = {}

	if not buyVehicle then
		if price ~= nil then
			table.insert(elements, { ["label"] = "Change Price - " .. price .. " :-", ["value"] = "price" })
			table.insert(elements, { ["label"] = "Put out for sale", ["value"] = "sell" })
			table.insert(elements, { ["label"] = "<span style='color: red;'><b>*Sale Warning*:</b></span><span style='color: grey;'>Suppoter Car Sale vehicles will be sold <b>randomly</b> over the next few weeks.</span>", ["value"] = "  " })
			table.insert(elements, { ["label"] = "<span style='color: grey;'>You wont be able to withdraw the car until it appears in the lot. All tickets raised will</span>", ["value"] = "  " })
			table.insert(elements, { ["label"] = "<span style='color: grey;'>be closed. If you don't agree - do not sell your car. 1 car for sale per person. Vehicles not sold</span>", ["value"] = "  "})
			table.insert(elements, { ["label"] = "<span style='color: grey;'>within 2 week period will be automatically returned to the owners garage in Zone 1. </span>", ["value"] = "  "			})
			table.insert(elements, { ["label"] = "<span style='color: grey;'>There is a $100k in game fee per car requested to be investigated as missing. </span>", ["value"] = "  "			})
			table.insert(elements, { ["label"] = "<span style='color: grey;'>15% fee applies for successful sales.</span>", ["value"] = "  "			})
		else
			table.insert(elements, { ["label"] = "Set Price - :-", ["value"] = "price" })
		end
	else
		table.insert(elements, { ["label"] = "Buy " .. price .. " - :-", ["value"] = "buy" })
		local veh = GetVehiclePedIsIn(GetPlayerPed(-1),false)
		local currentMods = ESX.Game.GetVehicleProperties(veh)
		table.insert(elements, { ["label"] = '<span style="color: orange;"><b>-Custom Mods-</b></span>', ["value"] = "  " })
		if currentMods.modEngine and currentMods.modEngine < 0 then
			table.insert(elements, { ["label"] = "Engine: Stock", ["value"] = "  " })
		elseif currentMods.modEngine and currentMods.modEngine > -1 then
			local val = currentMods.modEngine + 1
			table.insert(elements, { ["label"] = 'Engine: <span style="color: lightblue;">Upgraded Level [' .. val .."]", ["value"] = "  " })
		end
		if currentMods.modBrakes and currentMods.modBrakes < 0 then
			table.insert(elements, { ["label"] = "Brakes: Stock", ["value"] = "  " })
		elseif currentMods.modBrakes and currentMods.modBrakes > -1 then
			local val = currentMods.modBrakes + 1
			table.insert(elements, { ["label"] = 'Brakes: <span style="color: lightblue;">Upgraded Level [' .. val .. "]", ["value"] = "  " })
		end
		if currentMods.modSuspension and currentMods.modSuspension  < 0 then
			table.insert(elements, { ["label"] = "Suspension: Stock", ["value"] = "  " })
		elseif currentMods.modSuspension and currentMods.modSuspension > -1 then
			local val = currentMods.modSuspension + 1
			table.insert(elements, { ["label"] = 'Suspension: <span style="color: lightblue;">Upgraded Level [' .. val.."]", ["value"] = "  " })
		end
		if currentMods.modTransmission and currentMods.modTransmission < 0 then
			table.insert(elements, { ["label"] = "Transmission: Stock", ["value"] = "  " })
		elseif currentMods.modTransmission and currentMods.modTransmission > -1 then
			local val = currentMods.modTransmission + 1
			table.insert(elements, { ["label"] = 'Transmission: <span style="color: lightblue;">Upgraded Level [' .. val .. "]", ["value"] = "  " })
		end
		if currentMods.modTurbo and currentMods.modTurbo > 0 then
			table.insert(elements, { ["label"] = "Turbo: <span style='color: lightblue;'>YES", ["value"] = "  " })
		end
		if currentMods.modArmor and currentMods.modArmor < 0 then
			table.insert(elements, { ["label"] = "Armour: Stock", ["value"] = "  " })
		elseif currentMods.modArmor and currentMods.modArmor > -1 then
			local val = currentMods.modArmor + 1
			table.insert(elements, { ["label"] = 'Armour: <span style="color: lightblue;">Upgraded Level ['.. val .. "]", ["value"] = "  " })
		end

		
		if owner then
			table.insert(elements, { ["label"] = "Remove Vehicle", ["value"] = "remove" })
		end
	end

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'sell_veh',
		{
			title    = "Vehicle Menu",
			align    = 'top-right',
			elements = elements
		},
	function(data, menu)
		local action = data.current.value

		if action == "price" then
			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'sell_veh_price',
				{
					title = "Vehicle Price"
				},
			function(data2, menu2)

				local vehPrice = tonumber(data2.value)

				menu2.close()
				menu.close()

				OpenSellMenu(veh, vehPrice)
			end, function(data2, menu2)
				menu2.close()
			end)
		elseif action == "sell" then
			local vehProps = ESX.Game.GetVehicleProperties(veh)
			if (GetGameTimer() - GUI.Time) > 5000 then
				GUI.Time  = GetGameTimer()
				ESX.TriggerServerCallback('0e9f91dc-3e00-445c-a8b4-ff16073d77ca', function(valid)

					if valid then
						DeleteVehicle(veh)
						ESX.ShowNotification("You put out the ~g~vehicle~s~ for sale - " .. price .. " :-")
						menu.close()
					else
						ESX.ShowNotification("You must ~r~own~s~ the ~g~vehicle!~s~ / it's ~r~already~s~ " .. #Config.VehiclePositions .. " vehicles for sale!")
					end
		
				end, vehProps, price)
				menu.close()
			end
		elseif action == "buy" then
			if GetVehiclePedIsIn(GetPlayerPed(-1),false) ~= 0 then
				if (GetGameTimer() - GUI.Time) > 3000 then
					GUI.Time  = GetGameTimer()
					ESX.TriggerServerCallback('1b399f98-850c-4075-a499-9ff5928eb071', function(isPurchasable, totalMoney)
						if isPurchasable then
							DeleteVehicle(veh)
							ESX.ShowNotification("You ~g~bought~s~ the vehicle for " .. price .. " :-")
							menu.close()
							spawnedvehciles = false
						else
							ESX.ShowNotification("You ~r~don't~s~ have enough cash, it's missing " .. price - totalMoney .. " :-")
						end
					end, ESX.Game.GetVehicleProperties(veh), price)
				end
			else
				ESX.ShowNotification("You must be in the car to purchase it.")
				menu.close()
			end
		elseif action == "remove" then
			if (GetGameTimer() - GUI.Time) > 3000 then
				GUI.Time  = GetGameTimer()
				ESX.TriggerServerCallback('1b399f98-850c-4075-a499-9ff5928eb071', function(isPurchasable, totalMoney)
					if isPurchasable then
						DeleteVehicle(veh)
						ESX.ShowNotification("You ~g~removed~s~ the vehicle")
						menu.close()
						spawnedvehciles = false
					end
				end, ESX.Game.GetVehicleProperties(veh), 0)
			end
		end
		
	end, function(data, menu)
		menu.close()
	end)
end

function RemoveVehicles()
	local VehPos = Config.VehiclePositions

	for i = 1, #VehPos, 1 do
		local veh, distance = ESX.Game.GetClosestVehicle(VehPos[i])

		if DoesEntityExist(veh) and distance <= 1.0 then
			DeleteEntity(veh)
		end
	end
	
end

function SpawnVehicles()
	local VehPos = Config.VehiclePositions

	ESX.TriggerServerCallback('df76b418-5ed0-4e0a-bc83-9b92cbdde3a2', function(vehicles)

		for i = 1, #vehicles, 1 do

			local vehicleProps = vehicles[i]["vehProps"]

			LoadModel(vehicleProps["model"])

			VehPos[i]["entityId"] = CreateVehicle(vehicleProps["model"], VehPos[i]["x"], VehPos[i]["y"], VehPos[i]["z"] - 0.975, VehPos[i]["h"], false)
			VehPos[i]["price"] = vehicles[i]["price"]
			VehPos[i]["owner"] = vehicles[i]["owner"]

			ESX.Game.SetVehicleProperties(VehPos[i]["entityId"], vehicleProps)
			
			SetVehicleOnGroundProperly(VehPos[i]["entityId"])

			FreezeEntityPosition(VehPos[i]["entityId"], true)

			SetEntityAsMissionEntity(VehPos[i]["entityId"], true, true)
		end
	end)

end

LoadModel = function(model)
	while not HasModelLoaded(model) do
		RequestModel(model)

		Citizen.Wait(1)
	end
end