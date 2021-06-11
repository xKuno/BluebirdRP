

ESX = nil
Citizen.CreateThread(function()
	while true do
		Wait(5)
		if ESX ~= nil then
		
		else
			ESX = nil
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		end
	end
end)

local locations = {}
local lastpress = 0


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
local spawned = false
Citizen.CreateThread( function()
Citizen.Wait(10000)
while true do
Citizen.Wait(3000)
	if GetDistanceBetweenCoords(Config.PickupBlip.x,Config.PickupBlip.y,Config.PickupBlip.z, GetEntityCoords(GetPlayerPed(-1))) <= 200 then
		if spawned == false or #locations < 1 then
			TriggerEvent('0c663c3d-db96-45e1-aa30-a4fe4de48440')
			TriggerEvent('0c663c3d-db96-45e1-aa30-a4fe4de48440')
			TriggerEvent('0c663c3d-db96-45e1-aa30-a4fe4de48440')
			TriggerEvent('0c663c3d-db96-45e1-aa30-a4fe4de48440')
			TriggerEvent('0c663c3d-db96-45e1-aa30-a4fe4de48440')
			TriggerEvent('0c663c3d-db96-45e1-aa30-a4fe4de48440')
			TriggerEvent('0c663c3d-db96-45e1-aa30-a4fe4de48440')
			--TriggerEvent('0c663c3d-db96-45e1-aa30-a4fe4de48440')
			--TriggerEvent('0c663c3d-db96-45e1-aa30-a4fe4de48440')
			--TriggerEvent('0c663c3d-db96-45e1-aa30-a4fe4de48440')
			--TriggerEvent('0c663c3d-db96-45e1-aa30-a4fe4de48440')
			--TriggerEvent('0c663c3d-db96-45e1-aa30-a4fe4de48440')
			--TriggerEvent('0c663c3d-db96-45e1-aa30-a4fe4de48440')
		end
		spawned = true
	else
		if spawned then
			locations = {}
		end
		spawned = false
		
	end
end
end)


local displayed = false
local menuOpen = false


--[[
local blipPickup = AddBlipForCoord(Config.PickupBlip.x,Config.PickupBlip.y,Config.PickupBlip.z)

			SetBlipSprite (blipPickup, 514)
			SetBlipDisplay(blipPickup, 4)
			SetBlipScale  (blipPickup, 1.1)
			SetBlipColour (blipPickup, 24)
			SetBlipAsShortRange(blipPickup, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Cocoa Leaves Plantation")
			EndTextCommandSetBlipName(blipPickup)
			
local blipProcess = AddBlipForCoord(Config.Processing.x, Config.Processing.y, Config.Processing.z)

			SetBlipSprite (blipProcess, 514)
			SetBlipDisplay(blipProcess, 4)
			SetBlipScale  (blipProcess, 1.1)
			SetBlipColour (blipProcess, 24)
			SetBlipAsShortRange(blipProcess, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString("Cocaine production")
			EndTextCommandSetBlipName(blipProcess)
			--]]


local process = true



local isclose = false
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
			local is_close = false
			for k in pairs(locations) do
					local distance1 =  GetDistanceBetweenCoords(locations[k].x, locations[k].y, locations[k].z, GetEntityCoords(GetPlayerPed(-1)))
				if distance1 < 150 then
					is_close = true
					DrawMarker(3, locations[k].x, locations[k].y, locations[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 1.0, 0, 200, 0, 110, 0, 1, 0, 0)	
					
					if distance1 < 2 then		
						TriggerServerEvent('928d1060-9afb-4435-92bd-1cfc123e69a7')
						TriggerEvent('aa3f2c2e-f4c5-4171-8ede-a79dadc2c719', k)
					end
				
				end
			end
			

			if GetDistanceBetweenCoords(Config.Processing.x, Config.Processing.y, Config.Processing.z, GetEntityCoords(GetPlayerPed(-1))) < 80 then
				is_close = true
				DrawMarker(1, Config.Processing.x, Config.Processing.y, Config.Processing.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.3, 1.3, 1.0, 0, 200, 0, 110, 0, 1, 0, 0)	
				if GetDistanceBetweenCoords(Config.Processing.x, Config.Processing.y, Config.Processing.z, GetEntityCoords(GetPlayerPed(-1)), true) < 2 then			
					Draw3DText( Config.Processing.x, Config.Processing.y, Config.Processing.z , "~w~Cocaine Production~y~\nPress [~b~E~y~] to start processing",4,0.15,0.1)
					if IsControlJustReleased(0, Keys['E']) and not process then
						if  GetGameTimer() - 8000 > lastpress then
							lastpress = GetGameTimer()
							Citizen.CreateThread(function()
								Process()
							end)
						end
					end
				end
				
				if GetDistanceBetweenCoords(Config.Processing.x, Config.Processing.y, Config.Processing.z, GetEntityCoords(GetPlayerPed(-1)), true) < 5 and GetDistanceBetweenCoords(Config.Processing.x, Config.Processing.y, Config.Processing.z, GetEntityCoords(GetPlayerPed(-1)), true) > 3 then
					process = false
				end
			end
			
			if GetDistanceBetweenCoords(Config.ProcessingWeed2.x, Config.ProcessingWeed2.y, Config.ProcessingWeed2.z, GetEntityCoords(GetPlayerPed(-1))) < 80 then
				is_close = true
				DrawMarker(1, Config.ProcessingWeed2.x, Config.ProcessingWeed2.y, Config.ProcessingWeed2.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.5, 2.5, 2.5, 0, 200, 0, 110, 0, 1, 0, 0)	
				
				if GetDistanceBetweenCoords(Config.ProcessingWeed2.x, Config.ProcessingWeed2.y, Config.ProcessingWeed2.z, GetEntityCoords(GetPlayerPed(-1)), true) < 3 then			
					Draw3DText( Config.ProcessingWeed2.x, Config.ProcessingWeed2.y, Config.ProcessingWeed2.z , "~w~Weed Bagging~y~\nPress [~b~E~y~] to create a weed baggie",4,0.15,0.1)
					if IsControlJustReleased(0, Keys['E']) and not process then
						if  GetGameTimer() - 8000 > lastpress then
							lastpress = GetGameTimer()
							Citizen.CreateThread(function()
								ProcessWeed()
							end)
						end
					end
				end
				
				if GetDistanceBetweenCoords(Config.ProcessingWeed2.x, Config.ProcessingWeed2.y, Config.ProcessingWeed2.z, GetEntityCoords(GetPlayerPed(-1)), true) < 5 and GetDistanceBetweenCoords(Config.ProcessingWeed2.x, Config.ProcessingWeed2.y, Config.ProcessingWeed2.z, GetEntityCoords(GetPlayerPed(-1)), true) > 4 then
					process = false
				end
			end
			
			
			if GetDistanceBetweenCoords(Config.OpiumProcessing1.x, Config.OpiumProcessing1.y, Config.OpiumProcessing1.z, GetEntityCoords(GetPlayerPed(-1))) < 80 then
				is_close = true
				DrawMarker(1, Config.OpiumProcessing1.x, Config.OpiumProcessing1.y, Config.OpiumProcessing1.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 2.5, 2.5, 2.5, 0, 200, 0, 110, 0, 1, 0, 0)	
				
				if GetDistanceBetweenCoords(Config.OpiumProcessing1.x, Config.OpiumProcessing1.y, Config.OpiumProcessing1.z, GetEntityCoords(GetPlayerPed(-1)), true) < 3 then			
					Draw3DText( Config.OpiumProcessing1.x, Config.OpiumProcessing1.y, Config.OpiumProcessing1.z , "~w~Opium Bagging~y~\nPress [~b~E~y~] to create a opium baggie",4,0.15,0.1)
					if IsControlJustReleased(0, Keys['E']) and not process then
						if  GetGameTimer() - 8000 > lastpress then
							lastpress = GetGameTimer()
							Citizen.CreateThread(function()
								ProcessOpium()
							end)
						end
					end
				end
				
				if GetDistanceBetweenCoords(Config.OpiumProcessing1.x, Config.OpiumProcessing1.y, Config.OpiumProcessing1.z, GetEntityCoords(GetPlayerPed(-1)), true) < 5 and GetDistanceBetweenCoords(Config.OpiumProcessing1.x, Config.OpiumProcessing1.y, Config.OpiumProcessing1.z, GetEntityCoords(GetPlayerPed(-1)), true) > 4 then
					process = false
				end
			end
			
			if is_close == false then
				isclose = false
				Wait(2000)
				
			else
				isclose = true
			end
		

    end
end)



function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
         local px,py,pz=table.unpack(GetGameplayCamCoords())
         local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)    
         local scale = (1/dist)*20
         local fov = (1/GetGameplayCamFov())*100
         local scale = scale*fov   
         SetTextScale(scaleX*scale, scaleY*scale)
         SetTextFont(fontId)
         SetTextProportional(1)
		 if inDist then
			SetTextColour(0, 190, 0, 220)		-- You can change the text color here
		 else
		 	SetTextColour(220, 0, 0, 220)		-- You can change the text color here
		 end
         SetTextDropshadow(1, 1, 1, 1, 255)
         SetTextEdge(2, 0, 0, 0, 150)
         SetTextDropShadow()
         SetTextOutline()
         SetTextEntry("STRING")
         SetTextCentre(1)
         AddTextComponentString(textInput)
         SetDrawOrigin(x,y,z+2, 0)
         DrawText(0.0, 0.0)
         ClearDrawOrigin()
end

function Process()
process = true
--local making = true
	--while making and process do
	TriggerEvent('2c4f07a6-bf05-4b02-ba86-fd4472391cbd', '~g~Packing the ~w~Cocaine ~g~batch')
	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_PARKING_METER",0, false)
	Citizen.Wait(8000)
	
	ESX.TriggerServerCallback('3fa9ccae-f792-4638-b557-df8b2c19ecc2', function(output)
			making = output
		end)
		
	ClearPedTasks(PlayerPedId())
	process = false

--	end
end


function ProcessWeed()
	process = true
	--local making = false
	--while making and process do
	TriggerEvent('2c4f07a6-bf05-4b02-ba86-fd4472391cbd', '~g~Bagging ~w~Weed Budds ~g~ into a bag')
	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_PARKING_METER",0, false) --TaskStartScenarioInPlace(, anim, 0, false)
	Citizen.Wait(6000)
	
	ESX.TriggerServerCallback('1036fa3e-6dbe-456d-9964-6a96e9327daf', function(output)
			making = output
		end)
		
	ClearPedTasks(PlayerPedId())
	process = false
--	end
end


function ProcessOpium()
	process = true
	--local making = false
	--while making and process do
	TriggerEvent('2c4f07a6-bf05-4b02-ba86-fd4472391cbd', '~g~Bagging ~w~Opium Budds ~g~ into a bag')
	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_PARKING_METER",0, false) --TaskStartScenarioInPlace(, anim, 0, false)
	Citizen.Wait(6000)
	
	ESX.TriggerServerCallback('94048702-122a-437a-ba43-18bd0cf92fd3', function(output)
			making = output
		end)
		
	ClearPedTasks(PlayerPedId())
	process = false
--	end
end


RegisterNetEvent('0c663c3d-db96-45e1-aa30-a4fe4de48440')
AddEventHandler('0c663c3d-db96-45e1-aa30-a4fe4de48440', function()
	local set = false
	Citizen.Wait(20)
	
	local rnX = Config.PickupBlip.x + math.random(-15, 15)
	local rnY = Config.PickupBlip.y + math.random(-15, 15)
	
	local u, Z = GetGroundZFor_3dCoord(rnX ,rnY ,300.0,0)
	
		
	table.insert(locations,{x=rnX, y=rnY, z=Z + 0.3});

	

end)


RegisterNetEvent('aa3f2c2e-f4c5-4171-8ede-a79dadc2c719')
AddEventHandler('aa3f2c2e-f4c5-4171-8ede-a79dadc2c719', function(id)
	local set = false
	Citizen.Wait(10)
	
	
	local rnX = Config.PickupBlip.x + math.random(-15, 15)
	local rnY = Config.PickupBlip.y + math.random(-15, 15)
	
	local u, Z = GetGroundZFor_3dCoord(rnX ,rnY ,300.0,0)
	
	locations[id].x = rnX
	locations[id].y = rnY
	locations[id].z = Z + 0.3

end)

RegisterNetEvent('4246ced4-ab78-405f-9aee-4ae189529028')
AddEventHandler('4246ced4-ab78-405f-9aee-4ae189529028', function(message)
	ESX.ShowNotification(message)
end)
			
function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end









