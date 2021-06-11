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

ESX = nil

PlayerData = {}

local jailTime = 0
local playerloaded = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData() == nil do
		Citizen.Wait(10)
	end

	PlayerData = ESX.GetPlayerData()

	LoadTeleporters()
end)

RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(newData)
	print('esx player loaded fire for jail')
	PlayerData = newData
	playerloaded = true


end)


AddEventHandler('880c0a93-b305-46b3-b84c-a120fee9e841', function(spawn)
	if spawn then  -- and not InNYradius() 
		alreadyspawned = true
	else
		if alreadyspawned == false then
			--LSfly()
			--ShowMessage("It has been discovered that your spawning point is in North Yankton. [Return LS]")
			alreadyspawned = true
		end
	end
end)


RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function(response)
	PlayerData["job"] = response
end)

RegisterNetEvent('d30512d0-ca81-49a8-a9a1-21f217771c1d')
AddEventHandler('d30512d0-ca81-49a8-a9a1-21f217771c1d', function()
	OpenJailMenu()
end)

RegisterNetEvent('5580e656-b34a-4e70-aedf-4c977337ada8')
AddEventHandler('5580e656-b34a-4e70-aedf-4c977337ada8', function(newJailTime)
	jailTime = newJailTime
	Cutscene()
end)

RegisterNetEvent('4245898c-7dcb-44e4-bb74-8ef942c7099d')
AddEventHandler('4245898c-7dcb-44e4-bb74-8ef942c7099d', function()
	jailTime = 0

	UnJail()
end)

function  clearPed ()

    ClearAllPedProps(GetPlayerPed(-1))
end 

function JailLogin()
	local JailPosition = Config.JailPositions["Cell"]
	SetEntityCoords(PlayerPedId(), JailPosition["x"], JailPosition["y"], JailPosition["z"] - 1)

	ESX.ShowNotification("~b~Corrections Victoria\n~w~You are still ~o~incarcerated.")
	ESX.ShowNotification("You have been returned to ~y~prison to continue your sentence.")


end

function UnJail()
	InJail()

	ESX.Game.Teleport(PlayerPedId(), Config.Teleports["Prison Exterior"])


	TriggerServerEvent('40ed0b40-1152-41cd-88fb-2a124a3083e4')
	ESX.ShowNotification("~b~Corrections Victoria\n~w~You have been ~g~released.")
	Wait(1000)
	ESX.ShowNotification("Stay calm outside! Good Luck! Remember to follow rules in [F3]")
	Wait(1000)
	ESX.ShowNotification("Your phone has been returned to you so you can call a ~y~taxi")
end

function InJail()

	--Jail Timer--

	Citizen.CreateThread(function()

		while jailTime > 0 do

			jailTime = jailTime - 1

			ESX.ShowNotification("You have " .. jailTime .. " minutes left in prison!")

			TriggerServerEvent('44edbc58-ef13-48e8-b443-8a34f991bf6d', jailTime)

			if jailTime == 0 then
				UnJail()

				TriggerServerEvent('44edbc58-ef13-48e8-b443-8a34f991bf6d', 0)
			end
			
			if IsPedRagdoll(GetPlayerPed(-1)) then
				TriggerServerEvent('1982e9c8-01fb-4254-b49d-0df84f982fef',"prison override")
			end
			
			

			Citizen.Wait(60000)
		end

	end)

	--Jail Timer--

	--Prison Work--

	Citizen.CreateThread(function()
		while jailTime > 0 do
			
			local sleepThread = 500

			local Packages = Config.PrisonWork["Packages"]

			local Ped = PlayerPedId()
			local PedCoords = GetEntityCoords(Ped)

			for posId, v in pairs(Packages) do

				local DistanceCheck = GetDistanceBetweenCoords(PedCoords, v["x"], v["y"], v["z"], true)

				if DistanceCheck <= 10.0 then

					sleepThread = 5

					local PackageText = "Pack"

					if not v["state"] then
						PackageText = "Already Taken"
					end

					ESX.Game.Utils.DrawText3D(v, "[E] " .. PackageText, 0.4)

					if DistanceCheck <= 1.5 then

						if IsControlJustPressed(0, 38) then

							if v["state"] then
								PackPackage(posId)
							else
								ESX.ShowNotification("You've already taken this package!")
							end

						end

					end

				end

			end

			Citizen.Wait(sleepThread)

		end
	end)

	--Prison Work--

end

function LoadTeleporters()
	Citizen.CreateThread(function()
		while true do
			
			local sleepThread = 1000

			local Ped = PlayerPedId()
			local PedCoords = GetEntityCoords(Ped)
			local v3 = vector3(1702.77, 2578.96, -69.5)
			
			local dc = GetDistanceBetweenCoords(PedCoords, 1702.77, 2578.96, -69.5, true)
				if dc <= 8.5 then
					sleepThread = 5
					ESX.Game.Utils.DrawText3D(v3, "[E] To Check Prisoner In", 0.4)
					if dc <= 1.0 then
						if IsControlJustPressed(0, 38) then
							if ESX.GetPlayerData().job.name == 'police' then
								OpenJailMenu()
							end
						end
					end
				end

			for p, v in pairs(Config.Teleports) do

				local DistanceCheck = GetDistanceBetweenCoords(PedCoords, v["x"], v["y"], v["z"], true)

				if DistanceCheck <= 8.5 then

					sleepThread = 5

					ESX.Game.Utils.DrawText3D(v, "[E] Open Door", 0.4)

					if DistanceCheck <= 1.0 then
						if IsControlJustPressed(0, 38) then
							TeleportPlayer(v)
						end
					end
				end
			end

			Citizen.Wait(sleepThread)

		end
	end)
end

function PackPackage(packageId)
	local Package = Config.PrisonWork["Packages"][packageId]

	LoadModel("prop_cs_cardbox_01")

	local PackageObject = CreateObject(GetHashKey("prop_cs_cardbox_01"), Package["x"], Package["y"], Package["z"], true)

	PlaceObjectOnGroundProperly(PackageObject)

	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, false)

	local Packaging = true
	local StartTime = GetGameTimer()

	while Packaging do
		
		Citizen.Wait(1)

		local TimeToTake = 60000 * 1.20 -- Minutes
		local PackPercent = (GetGameTimer() - StartTime) / TimeToTake * 100

		if not IsPedUsingScenario(PlayerPedId(), "PROP_HUMAN_BUM_BIN") then
			DeleteEntity(PackageObject)

			ESX.ShowNotification("Canceled!")

			Packaging = false
		end

		if PackPercent >= 100 then

			Packaging = false

			DeliverPackage(PackageObject)

			Package["state"] = false
		else
			ESX.Game.Utils.DrawText3D(Package, "Packaging... " .. math.ceil(tonumber(PackPercent)) .. "%", 0.4)
		end
		
	end
end

function DeliverPackage(packageId)
	if DoesEntityExist(packageId) then
		AttachEntityToEntity(packageId, PlayerPedId(), GetPedBoneIndex(PlayerPedId(),  28422), 0.0, -0.03, 0.0, 5.0, 0.0, 0.0, 1, 1, 0, 1, 0, 1)

		ClearPedTasks(PlayerPedId())
	else
		return
	end

	local Packaging = true

	LoadAnim("anim@heists@box_carry@")

	while Packaging do

		Citizen.Wait(5)

		if not IsEntityPlayingAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 3) then
			TaskPlayAnim(PlayerPedId(), "anim@heists@box_carry@", "idle", 8.0, 8.0, -1, 50, 0, false, false, false)
		end

		if not IsEntityAttachedToEntity(packageId, PlayerPedId()) then
			Packaging = false
			DeleteEntity(packageId)
		else
			local DeliverPosition = Config.PrisonWork["DeliverPackage"]
			local PedPosition = GetEntityCoords(PlayerPedId())
			local DistanceCheck = GetDistanceBetweenCoords(PedPosition, DeliverPosition["x"], DeliverPosition["y"], DeliverPosition["z"], true)

			ESX.Game.Utils.DrawText3D(DeliverPosition, "[E] Leave Package", 0.4)

			if DistanceCheck <= 2.0 then
				if IsControlJustPressed(0, 38) then
					DeleteEntity(packageId)
					ClearPedTasksImmediately(PlayerPedId())
					Packaging = false

					TriggerServerEvent('1c410242-fc08-4910-a86f-b575ec0c1e39')
				end
			end
		end

	end

end

function OpenJailMenu()
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'jail_prison_menu',
		{
			title    = "Prison Menu",
			align    = 'center',
			elements = {
				{ label = "Jail Closest Person", value = "jail_closest_player" },
				{ label = "Unjail Person", value = "unjail_player" }
			}
		}, 
	function(data, menu)

		local action = data.current.value

		if action == "jail_closest_player" then

			menu.close()

			ESX.UI.Menu.Open(
          		'dialog', GetCurrentResourceName(), 'jail_choose_time_menu',
          		{
            		title = "Prison Time (mins) 1h=60 2h=120 6h=360 1d=1440 2d=2880"
          		},
          	function(data2, menu2)

            	local jailTime = tonumber(data2.value)

            	if jailTime == nil then
              		ESX.ShowNotification("The time needs to be in minutes!")
				elseif jailTime ~= nil and jailTime == 0 then
					ESX.ShowNotification("The time needs to be in minutes and more than 0!")
				else
              		menu2.close()

              		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

              		if closestPlayer == -1 or closestDistance > 3.0 then
                		ESX.ShowNotification("No players nearby!")
					else
						ESX.UI.Menu.Open(
							'dialog', GetCurrentResourceName(), 'jail_choose_reason_menu',
							{
							  title = "Jail Reason"
							},
						function(data3, menu3)
		  
						  	local reason = data3.value
		  
						  	if reason == nil then
								ESX.ShowNotification("You need to put something here!")
						  	else
								menu3.close()
		  
								local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

		  
								if closestPlayer == -1 or closestDistance > 3.0 then
								  	ESX.ShowNotification("No players nearby!")
								else
									if IsPedCuffed(GetPlayerPed(closestPlayer)) then
										--uncuff player
										ExecuteCommand("cuff")
									end
										
								  	TriggerServerEvent('acf135e5-1509-4a0b-9beb-34fff5970dd6', GetPlayerServerId(closestPlayer), jailTime, reason)
									TriggerServerEvent('841a41b8-d3a5-4d25-9d37-2e0803c1e51a',"POLICE ACTION", "JAIL TIMEX: " .. jailTime .. ' ' .. "PLAYER: " .. GetPlayerServerId(closestPlayer) .. " Reason: " .. reason , GetPlayerServerId(closestPlayer))
								end
		  
						  	end
		  
						end, function(data3, menu3)
							menu3.close()
						end)
              		end

				end

          	end, function(data2, menu2)
				menu2.close()
			end)
		elseif action == "unjail_player" then

			local elements = {}

			ESX.TriggerServerCallback('19cb56d7-6584-4140-a84e-54e934d3812f', function(playerArray)

				if #playerArray == 0 then
					ESX.ShowNotification("Your jail is empty!")
					return
				end

				for i = 1, #playerArray, 1 do
					table.insert(elements, {label = "Prisoner: " .. playerArray[i].name .. " | Jail Time: " .. playerArray[i].jailTime .. " minutes", value = playerArray[i].identifier })
				end

				ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'jail_unjail_menu',
					{
						title = "Unjail Player",
						align = "center",
						elements = elements
					},
				function(data2, menu2)

					local action = data2.current.value

					TriggerServerEvent('b27c6ecb-3234-44ab-a61c-9605a0d68cd5', action)
					TriggerServerEvent('841a41b8-d3a5-4d25-9d37-2e0803c1e51a',"POLICE ACTION", "UNJAILX: PLAYER: " .. action  , action)
					menu2.close()

				end, function(data2, menu2)
					menu2.close()
				end)
			end)

		end

	end, function(data, menu)
		menu.close()
	end)	
end

