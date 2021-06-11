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
local started = false
local displayed = false
local progress = 0
local CurrentVehicle 
local pause = false
local selection = 0
local quality = 0
local oktowhile = false
local myPed = GetPlayerPed(-1)
local myCurrentCoords = vector3(0,0,0)
local myCurrentVehicle = 0

local cancel = false

ESX = nil

local LastCar

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end
Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

Citizen.CreateThread(function()
  while ESX == nil do
    Citizen.Wait(200)
  end
  while true do
	pcall(function()
		myPed = ESX.Game.GetMyPed()
		myCurrentCoords = ESX.Game.GetMyPedLocation()
		myCurrentVehicle = ESX.Game.GetVehiclePedIsIn()
	end)
	Wait(1000)
  end
end)

RegisterNetEvent('a69183ab-c35c-4db5-8e5e-b03fad435679')
AddEventHandler('a69183ab-c35c-4db5-8e5e-b03fad435679', function()
	started = false
	DisplayHelpText("~r~Production stopped...")
	FreezeEntityPosition(LastCar, false)
end)
RegisterNetEvent('83a86ecc-b359-4798-b198-81273bf9b806')
AddEventHandler('83a86ecc-b359-4798-b198-81273bf9b806', function(id)
	FreezeEntityPosition(id, false)
end)
RegisterNetEvent('5864abeb-9e95-438b-8ac1-f75802229a6b')
AddEventHandler('5864abeb-9e95-438b-8ac1-f75802229a6b', function(message)
	ESX.ShowNotification(message)
end)

RegisterNetEvent('78993679-2fc1-4ca8-818a-6c883d195c58')
AddEventHandler('78993679-2fc1-4ca8-818a-6c883d195c58', function()
	DisplayHelpText("~g~Starting production")
	started = true
	FreezeEntityPosition(CurrentVehicle,true)
	displayed = false
	print('Started Meth production')
	ESX.ShowNotification("~r~Meth production has started")	
	SetPedIntoVehicle(GetPlayerPed(-1), CurrentVehicle, 3)
	SetVehicleDoorOpen(CurrentVehicle, 2)
end)

RegisterNetEvent('a211027a-81e2-4294-b565-5b039a4f9fc4')
AddEventHandler('a211027a-81e2-4294-b565-5b039a4f9fc4', function(posx, posy, posz)
	AddExplosion(posx, posy, posz + 2,23, 20.0, true, false, 1.0, true)
	if not HasNamedPtfxAssetLoaded("core") then
		RequestNamedPtfxAsset("core")
		while not HasNamedPtfxAssetLoaded("core") do
			Citizen.Wait(1)
		end
	end
	SetPtfxAssetNextCall("core")
	local fire = StartParticleFxLoopedAtCoord("ent_ray_heli_aprtmnt_l_fire", posx, posy, posz-0.8 , 0.0, 0.0, 0.0, 0.8, false, false, false, false)
	Citizen.Wait(6000)
	StopParticleFxLooped(fire, 0)
	
end)


RegisterNetEvent('2b2efd30-c303-4992-a1ae-23834097cd51')
AddEventHandler('2b2efd30-c303-4992-a1ae-23834097cd51', function(posx, posy, posz, bool)

	if bool == 'a' then

		if not HasNamedPtfxAssetLoaded("core") then
			RequestNamedPtfxAsset("core")
			while not HasNamedPtfxAssetLoaded("core") do
				Citizen.Wait(1)
			end
		end
		SetPtfxAssetNextCall("core")
		local smoke = StartParticleFxLoopedAtCoord("exp_grd_flare", posx, posy, posz + 1.7, 0.0, 0.0, 0.0, 2.0, false, false, false, false)
		SetParticleFxLoopedAlpha(smoke, 0.8)
		SetParticleFxLoopedColour(smoke, 0.0, 0.0, 0.0, 0)
		Citizen.Wait(22000)
		StopParticleFxLooped(smoke, 0)
	else
		StopParticleFxLooped(smoke, 0)
	end

end)
RegisterNetEvent('997d6664-f737-4882-b94a-8f3dd4abe85b')
AddEventHandler('997d6664-f737-4882-b94a-8f3dd4abe85b', function()
	SetTimecycleModifier("drug_drive_blend01")
	SetPedMotionBlur(GetPlayerPed(-1), true)
	SetPedMovementClipset(GetPlayerPed(-1), "MOVE_M@DRUNK@SLIGHTLYDRUNK", true)
	SetPedIsDrunk(GetPlayerPed(-1), true)

	Citizen.Wait(300000)
	ClearTimecycleModifier()
end)




Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		pcall(function()
			playerPed = myPed
			local pos = myCurrentCoords
			if myCurrentVehicle ~= 0 then
				
				
				CurrentVehicle = myCurrentVehicle

				car = myCurrentVehicle
				LastCar = myCurrentVehicle
		
				local model = GetEntityModel(CurrentVehicle)

				if model == `journey` and car then
					oktowhile = true
						if GetPedInVehicleSeat(car, -1) == playerPed then
							if started == false then
								if displayed == false then
									DisplayHelpText("Press ~INPUT_THROW_GRENADE~ to start making drugs")
									displayed = true
								end
							end
							if IsControlJustReleased(0, Keys['G']) then
								if pos.y >= 850 then
									if IsVehicleSeatFree(CurrentVehicle, 3) then
										pos = GetEntityCoords(PlayerPedId())
										TriggerServerEvent('73f74544-b337-47c3-baad-95cad3b3bdc9')	
										progress = 0
										pause = false
										selection = 0
										quality = 0
										
									else
										DisplayHelpText('~r~The car is already occupied')
									end
								else
									ESX.ShowNotification('~r~You are too close to the city, head further up north to begin meth production')
								end
								
								
								
								
			
							end
						elseif GetPedInVehicleSeat(car, 1) == playerPed then
						
						end
						
					
					
				else
					Wait(2000)
				end
				
			else
				Wait(2000) --LG
					oktowhile = false
					if started then
						started = false
						displayed = false
						TriggerEvent('a69183ab-c35c-4db5-8e5e-b03fad435679')
						print('Stopped making drugs')
						FreezeEntityPosition(LastCar,false)
					end
			end
			
			if started == true then
				
				if progress < 96 then
					Citizen.Wait(6000)
					if not pause and IsPedInAnyVehicle(playerPed) then
						progress = progress +  1
						ESX.ShowNotification('~r~Meth production: ~g~~h~' .. progress .. '%')
						Citizen.Wait(6000) 
					end

					--
					--   EVENT 1
					--
					if progress > 22 and progress < 24 then
						pause = true
						if selection == 0 then
							ESX.ShowNotification('~o~The propane pipe is leaking, what do you do?')	
							ESX.ShowNotification('~o~1. Fix using tape')
							ESX.ShowNotification('~o~2. Leave it be ')
							ESX.ShowNotification('~o~3. Replace it')
							ESX.ShowNotification('~c~Press the number of the option you want to do')
						end
						if selection == 1 then
							print("Slected 1")
							ESX.ShowNotification('~r~The tape kinda stopped the leak')
							quality = quality - 3
							pause = false
						end
						if selection == 2 then
							print("Slected 2")
							ESX.ShowNotification('~r~The propane tank blew up, you messed up...')
							TriggerServerEvent('2f332298-706e-4e0d-a7f0-80839b9de46c', pos.x, pos.y, pos.z)
							SetVehicleEngineHealth(CurrentVehicle, 0.0)
							quality = 0
							started = false
							displayed = false
							ApplyDamageToPed(GetPlayerPed(-1), 10, false)
							print('Stopped making drugs')
						end
						if selection == 3 then
							print("Slected 3")
							ESX.ShowNotification('~r~Good job, the pipe wasnt in a good condition')
							pause = false
							quality = quality + 5
						end
					end
					--
					--   EVENT 5
					--
					if progress > 30 and progress < 32 then
						pause = true
						if selection == 0 then
							ESX.ShowNotification('~o~You spilled a bottle of acetone on the ground, what do you do?')	
							ESX.ShowNotification('~o~1. Open the windows to get rid of the smell')
							ESX.ShowNotification('~o~2. Leave it be')
							ESX.ShowNotification('~o~3. Put on a mask with airfilter')
							ESX.ShowNotification('~c~Press the number of the option you want to do')
						end
						if selection == 1 then
							print("Slected 1")
							ESX.ShowNotification('~r~You opened the windows to get rid of the smell')
							quality = quality - 1
							pause = false
						end
						if selection == 2 then
							print("Slected 2")
							ESX.ShowNotification('~r~You got high from inhaling acetone too much')
							pause = false
							TriggerEvent('997d6664-f737-4882-b94a-8f3dd4abe85b')
						end
						if selection == 3 then
							print("Slected 3")
							ESX.ShowNotification('~r~Thats an easy way to fix the issue.. I guess')
							SetPedPropIndex(playerPed, 1, 26, 7, true)
							pause = false
						end
					end
					--
					--   EVENT 2
					--
					if progress > 38 and progress < 40 then
						pause = true
						if selection == 0 then
							ESX.ShowNotification('~o~Meth becomes solid too fast, what do you do? ')	
							ESX.ShowNotification('~o~1. Raise the pressure')
							ESX.ShowNotification('~o~2. Raise the temperature')
							ESX.ShowNotification('~o~3. Lower the pressure')
							ESX.ShowNotification('~c~Press the number of the option you want to do')
						end
						if selection == 1 then
							print("Slected 1")
							ESX.ShowNotification('~r~You raised the pressure and the propane started escaping, you lowered it and its okay for now')
							pause = false
						end
						if selection == 2 then
							print("Slected 2")
							ESX.ShowNotification('~r~Raising the temperature helped...')
							quality = quality + 5
							pause = false
						end
						if selection == 3 then
							print("Slected 3")
							ESX.ShowNotification('~r~Lowering the pressure just made it worse...')
							pause = false
							quality = quality -4
						end
					end
					--
					--   EVENT 8 - 3
					--
					if progress > 41 and progress < 43 then
						pause = true
						if selection == 0 then
							ESX.ShowNotification('~o~You accidentally pour too much acetone, what do you do?')	
							ESX.ShowNotification('~o~1. Do nothing')
							ESX.ShowNotification('~o~2. Try to sucking it out using syringe')
							ESX.ShowNotification('~o~3. Add more lithium to balance it out')
							ESX.ShowNotification('~c~Press the number of the option you want to do')
						end
						if selection == 1 then
							print("Slected 1")
							ESX.ShowNotification('~r~The meth is not smelling like acetone a lot')
							quality = quality - 3
							pause = false
						end
						if selection == 2 then
							print("Slected 2")
							ESX.ShowNotification('~r~It kind of worked but its still too much')
							pause = false
							quality = quality - 1
						end
						if selection == 3 then
							print("Slected 3")
							ESX.ShowNotification('~r~You successfully balanced both chemicals out and its good again')
							pause = false
							quality = quality + 3
						end
					end
					--
					--   EVENT 3
					--
					if progress > 46 and progress < 49 then
						pause = true
						if selection == 0 then
							ESX.ShowNotification('~o~You found some water coloring, what do you do?')	
							ESX.ShowNotification('~o~1. Add it in')
							ESX.ShowNotification('~o~2. Put it away')
							ESX.ShowNotification('~o~3. Drink it')
							ESX.ShowNotification('~c~Press the number of the option you want to do')
						end
						if selection == 1 then
							print("Slected 1")
							ESX.ShowNotification('~r~Good idea, people like colors')
							quality = quality + 4
							pause = false
						end
						if selection == 2 then
							print("Slected 2")
							ESX.ShowNotification('~r~Yeah it might destroy the taste of meth')
							pause = false
						end
						if selection == 3 then
							print("Slected 3")
							ESX.ShowNotification('~r~You are a bit weird and feel dizzy but its all good')
							pause = false
						end
					end
					--
					--   EVENT 4
					--
					if progress > 55 and progress < 58 then
						pause = true
						if selection == 0 then
							ESX.ShowNotification('~o~The filter is clogged, what do you do?')	
							ESX.ShowNotification('~o~1. Clean it using compressed air')
							ESX.ShowNotification('~o~2. Replace the filter')
							ESX.ShowNotification('~o~3. Clean it using a tooth brush')
							ESX.ShowNotification('~c~Press the number of the option you want to do')
						end
						if selection == 1 then
							print("Slected 1")
							ESX.ShowNotification('~r~Compressed air sprayed the liquid meth all over you')
							quality = quality - 2
							pause = false
						end
						if selection == 2 then
							print("Slected 2")
							ESX.ShowNotification('~r~Replacing it was probably the best option')
							pause = false
							quality = quality + 3
						end
						if selection == 3 then
							print("Slected 3")
							ESX.ShowNotification('~r~This worked quite well but its still kinda dirty')
							pause = false
							quality = quality - 1
						end
					end
					--
					--   EVENT 5
					--
					if progress > 58 and progress < 60 then
						pause = true
						if selection == 0 then
							ESX.ShowNotification('~o~You spilled a bottle of acetone on the ground, what do you do?')	
							ESX.ShowNotification('~o~1. Open the windows to get rid of the smell')
							ESX.ShowNotification('~o~2. Leave it be')
							ESX.ShowNotification('~o~3. Put on a mask with airfilter')
							ESX.ShowNotification('~c~Press the number of the option you want to do')
						end
						if selection == 1 then
							print("Slected 1")
							ESX.ShowNotification('~r~You opened the windows to get rid of the smell')
							quality = quality - 1
							pause = false
						end
						if selection == 2 then
							print("Slected 2")
							ESX.ShowNotification('~r~You got high from inhaling acetone too much')
							pause = false
							TriggerEvent('997d6664-f737-4882-b94a-8f3dd4abe85b')
						end
						if selection == 3 then
							print("Slected 3")
							ESX.ShowNotification('~r~Thats an easy way to fix the issue.. I guess')
							SetPedPropIndex(playerPed, 1, 26, 7, true)
							pause = false
						end
					end
					--
					--   EVENT 1 - 6
					--
					if progress > 63 and progress < 65 then
						pause = true
						if selection == 0 then
							ESX.ShowNotification('~o~The propane pipe is leaking, what do you do?')	
							ESX.ShowNotification('~o~1. Fix using tape')
							ESX.ShowNotification('~o~2. Leave it be ')
							ESX.ShowNotification('~o~3. Replace it')
							ESX.ShowNotification('~c~Press the number of the option you want to do')
						end
						if selection == 1 then
							print("Slected 1")
							ESX.ShowNotification('~r~The tape kinda stopped the leak')
							quality = quality - 3
							pause = false
						end
						if selection == 2 then
							print("Slected 2")
							ESX.ShowNotification('~r~The propane tank blew up, you messed up...')
							TriggerServerEvent('2f332298-706e-4e0d-a7f0-80839b9de46c', pos.x, pos.y, pos.z)
							SetVehicleEngineHealth(CurrentVehicle, 0.0)
							quality = 0
							started = false
							displayed = false
							ApplyDamageToPed(GetPlayerPed(-1), 10, false)
							print('Stopped making drugs')
						end
						if selection == 3 then
							print("Slected 3")
							ESX.ShowNotification('~r~Good job, the pipe wasnt in a good condition')
							pause = false
							quality = quality + 5
						end
					end
					--
					--   EVENT 4 - 7
					--
					if progress > 71 and progress < 73 then
						pause = true
						if selection == 0 then
							ESX.ShowNotification('~o~The filter is clogged, what do you do?')	
							ESX.ShowNotification('~o~1. Clean it using compressed air')
							ESX.ShowNotification('~o~2. Replace the filter')
							ESX.ShowNotification('~o~3. Clean it using a tooth brush')
							ESX.ShowNotification('~c~Press the number of the option you want to do')
						end
						if selection == 1 then
							print("Slected 1")
							ESX.ShowNotification('~r~Compressed air sprayed the liquid meth all over you')
							quality = quality - 2
							pause = false
						end
						if selection == 2 then
							print("Slected 2")
							ESX.ShowNotification('~r~Replacing it was probably the best option')
							pause = false
							quality = quality + 3
						end
						if selection == 3 then
							print("Slected 3")
							ESX.ShowNotification('~r~This worked quite well but its still kinda dirty')
							pause = false
							quality = quality - 1
						end
					end
					--
					--   EVENT 8
					--
					if progress > 76 and progress < 78 then
						pause = true
						if selection == 0 then
							ESX.ShowNotification('~o~You accidentally pour too much acetone, what do you do?')	
							ESX.ShowNotification('~o~1. Do nothing')
							ESX.ShowNotification('~o~2. Try to sucking it out using syringe')
							ESX.ShowNotification('~o~3. Add more lithium to balance it out')
							ESX.ShowNotification('~c~Press the number of the option you want to do')
						end
						if selection == 1 then
							print("Slected 1")
							ESX.ShowNotification('~r~The meth is not smelling like acetone a lot')
							quality = quality - 3
							pause = false
						end
						if selection == 2 then
							print("Slected 2")
							ESX.ShowNotification('~r~It kind of worked but its still too much')
							pause = false
							quality = quality - 1
						end
						if selection == 3 then
							print("Slected 3")
							ESX.ShowNotification('~r~You successfully balanced both chemicals out and its good again')
							pause = false
							quality = quality + 3
						end
					end
					--
					--   EVENT 9
					--
					if progress > 82 and progress < 84 then
						pause = true
						if selection == 0 then
							ESX.ShowNotification('~o~You need to take a shit, what do you do?')	
							ESX.ShowNotification('~o~1. Try to hold it')
							ESX.ShowNotification('~o~2. Go outside and take a shit')
							ESX.ShowNotification('~o~3. Shit inside')
							ESX.ShowNotification('~c~Press the number of the option you want to do')
						end
						if selection == 1 then
							print("Slected 1")
							ESX.ShowNotification('~r~Good job, you need to work first, shit later')
							quality = quality + 2
							pause = false
						end
						if selection == 2 then
							print("Slected 2")
							ESX.ShowNotification('~r~While you were outside the glass fell off the table and spilled all over the floor...')
							pause = false
							quality = quality - 2
						end
						if selection == 3 then
							print("Slected 3")
							ESX.ShowNotification('~r~The air smells like shit now, the meth smells like shit now')
							pause = false
							quality = quality - 1
						end
					end
					--
					--   EVENT 10
					--
					if progress > 88 and progress < 90 then
						pause = true
						if selection == 0 then
							ESX.ShowNotification('~o~Do you add some glass pieces to the meth so it looks like you have more of it?')	
							ESX.ShowNotification('~o~1. Yes!')
							ESX.ShowNotification('~o~2. No')
							ESX.ShowNotification('~o~3. What if I add meth to glass instead?')
							ESX.ShowNotification('~c~Press the number of the option you want to do')
						end
						if selection == 1 then
							print("Slected 1")
							ESX.ShowNotification('~r~Now you got few more baggies out of it')
							quality = quality + 1
							pause = false
						end
						if selection == 2 then
							print("Slected 2")
							ESX.ShowNotification('~r~You are a good drug maker, your product is high quality')
							pause = false
							quality = quality + 3
						end
						if selection == 3 then
							print("Slected 3")
							ESX.ShowNotification('~r~Thats a bit too much, its more glass than meth but ok')
							pause = false
							quality = quality - 1
						end
					end
					
					
					
					
					
					
					
					if IsPedInAnyVehicle(playerPed) then
						TriggerServerEvent('46131bba-6378-47de-8fe1-b50b1cfecb03', pos.x,pos.y,pos.z)
						if pause == false then
							selection = 0
							quality = quality + 1
							progress = progress +  math.random(1, 2)
							ESX.ShowNotification('~r~Meth production: ~g~~h~' .. progress .. '%')
						end
					else
						TriggerEvent('a69183ab-c35c-4db5-8e5e-b03fad435679')
					end

				else
					TriggerEvent('a69183ab-c35c-4db5-8e5e-b03fad435679')
					progress = 100
					ESX.ShowNotification('~r~Meth production: ~g~~h~' .. progress .. '%')
					ESX.ShowNotification('~g~~h~Production finished')
					TriggerServerEvent('f2bd9010-8c4f-40bf-954d-5874a9bf7db4', quality)
					FreezeEntityPosition(LastCar, false)
				end	
				
			end
		end)
	end
end)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
		if myCurrentVehicle ~= 0 then
		else
			if started then
				started = false
				displayed = false
				TriggerEvent('a69183ab-c35c-4db5-8e5e-b03fad435679')
				print('Stopped making drugs')
				FreezeEntityPosition(LastCar,false)
			end		
		end
		if oktowhile == false then
			Wait(2000)
		end
	end

end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)		
		if pause == true then
			if IsDisabledControlJustReleased(0, Keys['1']) then
				selection = 1
				ESX.ShowNotification('~g~Selected option number 1')
			end
			if IsDisabledControlJustReleased(0, Keys['2']) then
				selection = 2
				ESX.ShowNotification('~g~Selected option number 2')
			end
			if IsDisabledControlJustReleased(0, Keys['3']) then
				selection = 3
				ESX.ShowNotification('~g~Selected option number 3')
			end
		end
		
		if oktowhile == false then
			Wait(2000)
		end
	end
end)




