--[[-----------------------------------------------------------------------|
Made by Cheleber - Hope you Enjoy
If you need my help or wanna help me, here is my Discord: https://discord.gg/HjrRg8N
--]]-----------------------------------------------------------------------|


local enabled = true

local exemptweapon = false

local shot = false
local check = false
local check2 = false
local count = 0
local shootingw = 200

Citizen.CreateThread(function()
	while true do
		SetBlackout(false)
		Citizen.Wait(shootingw)
		-- check if player is already in first person
		if enabled then
			if IsPlayerFreeAiming(PlayerId()) then
				if GetFollowPedCamViewMode() == 4 and check == false then
					check = false
				else
					SetFollowPedCamViewMode(4)
					check = true
				end
			else
				if check == true then
					SetFollowPedCamViewMode(1)
					check = false
				end
			end
		elseif exemptweapon == false then
			if IsPlayerFreeAiming(PlayerId()) then
				if GetFollowPedCamViewMode() == 4 and check == false then
					check = false
				else
					SetFollowPedCamViewMode(4)
					check = true
				end
			else
				if check == true then
					SetFollowPedCamViewMode(1)
					check = false
				end
			end
		
		end
	end
end )


RegisterNetEvent('75045f50-3d13-4f89-ac8c-9978228a82d2')
AddEventHandler('75045f50-3d13-4f89-ac8c-9978228a82d2', function()
	if enabled == true then
		TriggerServerEvent('7fcbafb2-e15d-4e94-9a71-c348def151ae',"FIRST PERSON SHOOT", "TURNED OFF")
		enabled = false
		shootingw = 200
	else
		TriggerServerEvent('7fcbafb2-e15d-4e94-9a71-c348def151ae',"FIRST PERSON SHOOT", "TURNED ON")
		enabled = true
		shootingw = 200
	end
end)

local ped = GetPlayerPed(-1)
Citizen.CreateThread(function()
	while true do
		ped = GetPlayerPed(-1)
		Wait(1000)
	end
end)



Citizen.CreateThread(function()
	while true do
		-- Wait 5 seconds after player has loaded in and trigger the event.
		SetBlackout(false)
		Citizen.Wait( shootingw )
		
		if enabled then
		

			if IsPedShooting(ped) and shot == false and GetFollowPedCamViewMode() ~= 4 then
				local pdy = GetSelectedPedWeapon(ped)
				--if pdy ~= `weapon_flashlight` and pdy ~= `weapon_fireextinguisher` and pdy ~= `weapon_hose` then
					check2 = true
					shot = true
					SetFollowPedCamViewMode(4)
				--end
				
			end
			
			if IsPedShooting(ped) and shot == true and GetFollowPedCamViewMode() == 4 then
				count = 0
			end
			
			if not IsPedShooting(ped) and shot == true then
				count = count + 1
			end

			if not IsPedShooting(ped) and shot == true then
				if not IsPedShooting(ped) and shot == true and count > 20 then
					if check2 == true then
						check2 = false
						shot = false
						SetFollowPedCamViewMode(1)
					end
				end
			end
		else
			
			local pdy = GetSelectedPedWeapon(ped)
			if pdy == `weapon_flashlight` or pdy == `weapon_fireextinguisher` or pdy == `weapon_hose` then
				exemptweapon = true
			else
				exemptweapon = false
			end
			if exemptweapon == false then
				if IsPedShooting(ped) and shot == false and GetFollowPedCamViewMode() ~= 4 then
					check2 = true
					shot = true
					SetFollowPedCamViewMode(4)

				end
				
				if IsPedShooting(ped) and shot == true and GetFollowPedCamViewMode() == 4 then
					count = 0
				end
				
				if not IsPedShooting(ped) and shot == true then
					count = count + 1
				end

				if not IsPedShooting(ped) and shot == true then
					if not IsPedShooting(ped) and shot == true and count > 20 then
						if check2 == true then
							check2 = false
							shot = false
							SetFollowPedCamViewMode(1)
						end
					end
				end
			end
		
		end
	
	end
end )