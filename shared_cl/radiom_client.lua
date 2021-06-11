-- Created by Deziel0495 and IllusiveTea --

-- NOTICE
-- This script is licensed under "No License". https://choosealicense.com/no-license/
-- You are allowed to: Download, Use and Edit the Script. 
-- You are not allowed to: Copy, re-release, re-distribute it without our written permission.

--- DO NOT EDIT THIS
local holstered = true

local otherholstered = true
local lweaponhash = `WEAPON_UNARMED`

-- RESTRICTED PEDS --
-- I've only listed peds that have a remote speaker mic, but any ped listed here will do the animations.
local skins = {
	"s_m_y_cop_01",
	"s_f_y_cop_01",
	"s_m_y_hwaycop_01",
	"s_m_y_sheriff_01",
	"s_f_y_sheriff_01",
	"s_m_y_ranger_01",
	"s_f_y_ranger_01",
	"s_m_y_fireman_01",
	"s_m_y_armymech_01",
	"s_m_y_blackops_01",
	"s_m_y_blackops_03",
	"a_m_y_latino_01",
	"s_m_y_uscg_01",
	"s_m_m_ciasec_01",

	
}

local skinsr = {

}

-- Add/remove weapon hashes here to be added for holster checks.
local weapons = {
	`WEAPON_PISTOL`,
	`WEAPON_COMBATPISTOL`,
	`WEAPON_SNSPISTOL`,
	`WEAPON_PISTOL_MK2`
}


local weaponsback = {
	`WEAPON_PISTOL`,
	`WEAPON_APPISTOL`,
	`WEAPON_COMBATPISTOL`,
	`WEAPON_STUNGUN`,	
	`WEAPON_NIGHTSTICK`,
	`WEAPON_FLASHLIGHT`,
	`WEAPON_FIREEXTINGUISHER`,
	`WEAPON_FLARE`,
	`WEAPON_SNSPISTOl`,
	`WEAPON_MACHINEPISTOL`,
	`WEAPON_FLARE`,
	`WEAPON_KNIFE`,
	`WEAPON_KNUCKLE`,
	`WEAPON_NIGHTSTICK`,
	`WEAPON_HAMMER`,
	`WEAPON_BAT`,
	`WEAPON_GOLFCLUB`,
	`WEAPON_CROWBAR1`,
	`WEAPON_BOTTLE`,
	`WEAPON_DAGGER`,
	`WEAPON_HATCHET`,
	`WEAPON_MACHETE`,
	`WEAPON_SWITCHBLADE`,
	`WEAPON_PROXMINE`,
	`WEAPON_APPISTOL`,
	`WEAPON_BZGAS`,
	`WEAPON_SMOKEGRENADE`,
	`WEAPON_MOLOTOV`,
	`WEAPON_MACHINEPISTOL`,	
	`WEAPON_KNIFE`,
			
}

-- RADIO ANIMATIONS --
--[[]
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(15)
		local ped = PlayerPedId()
		if DoesEntityExist( ped ) and not IsEntityDead( ped ) and CheckSkin(ped) then
			if not IsPauseMenuActive() then 
				loadAnimDict( "random@arrests" )
				if IsControlJustReleased( 0, 173 ) and GetLastInputMethod(0) then -- INPUT_CHARACTER_WHEEL (LEFT ALT)
					TriggerServerEvent('746ecaaa-70ed-4068-bf6c-5e6e78e9d645', 'off', 0.1)
					ClearPedTasks(ped)
					SetEnableHandcuffs(ped, false)
				else
					if IsControlJustPressed( 0, 173 ) and CheckSkin(ped) and not IsPlayerFreeAiming(PlayerId()) and GetLastInputMethod(2) then -- INPUT_CHARACTER_WHEEL (LEFT ALT)
						TriggerServerEvent('746ecaaa-70ed-4068-bf6c-5e6e78e9d645', 'on', 0.1)
						TaskPlayAnim(ped, "random@arrests", "generic_radio_enter", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
						SetEnableHandcuffs(ped, true)
					elseif IsControlJustPressed( 0, 173 ) and CheckSkin(ped) and IsPlayerFreeAiming(PlayerId()) and GetLastInputMethod(2) then -- INPUT_CHARACTER_WHEEL (LEFT ALT)
						TriggerServerEvent('746ecaaa-70ed-4068-bf6c-5e6e78e9d645', 'on', 0.1)
						TaskPlayAnim(ped, "random@arrests", "radio_chatter", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
						SetEnableHandcuffs(ped, true)
					end 
					if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "random@arrests", "generic_radio_enter", 3) then
						DisableActions(ped)
					elseif IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "random@arrests", "radio_chatter", 3) then
						DisableActions(ped)
					end
				end
			end 
		end 
	end
end )--]]

-- HOLD WEAPON HOLSTER ANIMATION --

Citizen.CreateThread( function()
	while true do 
		Citizen.Wait(20)
		local ped = PlayerPedId()
		if DoesEntityExist( ped ) and not IsPedInAnyVehicle(PlayerPedId(), true) and CheckSkinc(ped) then 
			DisableControlAction( 0, 246, true ) -- INPUT_MULTIPLAYER_INFO (Z)
			if not IsPauseMenuActive() then 
				loadAnimDict( "reaction@intimidation@cop@unarmed" )		
				if IsDisabledControlJustReleased( 0, 246 ) then -- INPUT_MULTIPLAYER_INFO (Z)
					ClearPedTasks(ped)
					SetEnableHandcuffs(ped, false)
					SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true)
				else
					if IsDisabledControlJustPressed( 0, 246 ) and CheckSkinc(ped) then -- INPUT_MULTIPLAYER_INFO (Z)
						SetEnableHandcuffs(ped, true)
						SetCurrentPedWeapon(ped, `WEAPON_UNARMED`, true) 
						TaskPlayAnim(ped, "reaction@intimidation@cop@unarmed", "intro", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
					end
					if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "reaction@intimidation@cop@unarmed", "intro", 3) then 
						DisableActions(ped)
					end	
				end
			end
		else
			Wait(250)
		end 
	end
end )

-- HOLSTER/UNHOLSTER PISTOL --
 
 Citizen.CreateThread(function()
	while true do
		Citizen.Wait(150)
		local ped = PlayerPedId()
		if DoesEntityExist( ped ) and not IsEntityDead( ped ) and not IsPedInAnyVehicle(PlayerPedId(), true) and CheckSkinc(ped) then
			
			local check_weapon_result = CheckWeapon(ped)
			if check_weapon_result or not inventoryWeapon(ped) then
				if holstered then
					loadAnimDict( "rcmjosh4" )
					loadAnimDict( "weapons@pistol@" )
					while not HasAnimDictLoaded('rcmjosh4') do
						Citizen.Wait(0)
					end
					while not HasAnimDictLoaded('weapons@pistol@') do
						Citizen.Wait(0)
					end
					TaskPlayAnim(ped, "rcmjosh4", "josh_leadout_cop2", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
					Citizen.Wait(600)
					ClearPedTasks(ped)
					holstered = false
				end
				--print('weapon var: not holstered ' .. GetPedDrawableVariation(ped,7))
				local check_result = CheckSkinc(ped) 
				if check_result and GetPedDrawableVariation(ped,7) == 8 then
					SetPedComponentVariation(ped,7,2,0,0)
				elseif check_result and GetPedDrawableVariation(ped,7) == 1 then
					SetPedComponentVariation(ped,7,3,0,0)
				elseif check_result and GetPedDrawableVariation(ped,7) == 6 then
					SetPedComponentVariation(ped,7,5,0,0)
					
				elseif check_result and GetPedDrawableVariation(ped,7) == 9 then
					SetPedComponentVariation(ped,7,7,0,0)
				elseif check_result and GetPedDrawableVariation(ped,5) == 61 then
					SetPedComponentVariation(ped,5,60,0,0)

				end
					
			elseif not CheckWeapon(ped) then
				
				if not holstered then
					loadAnimDict( "rcmjosh4" )
					loadAnimDict( "weapons@pistol@" )
					while not HasAnimDictLoaded('rcmjosh4') do
						Citizen.Wait(0)
					end
					while not HasAnimDictLoaded('weapons@pistol@') do
						Citizen.Wait(0)
					end

					TaskPlayAnim(ped, "weapons@pistol@", "aim_2_holster", 8.0, 2.0, -1, 48, 10, 0, 0, 0 )
					Citizen.Wait(500)
					ClearPedTasks(ped)
					holstered = true
				end
				local check_result = CheckSkinc(ped) 
				--print('weapon var: HOLSTERED ' .. GetPedDrawableVariation(ped,7))
				if check_result and GetPedDrawableVariation(ped,7) == 2 then
					SetPedComponentVariation(ped,7,8,0,0)
				elseif check_result and GetPedDrawableVariation(ped,7) == 3 then
					SetPedComponentVariation(ped,7,1,0,0)
				elseif check_result and GetPedDrawableVariation(ped,7) == 5 then
					SetPedComponentVariation(ped,7,6,0,0)
				elseif check_result and GetPedDrawableVariation(ped,7) == 7 then
					SetPedComponentVariation(ped,7,9,0,0)
				elseif check_result and GetPedDrawableVariation(ped,5) == 60 then
					SetPedComponentVariation(ped,5,61,0,0)
				end
			else
				othercheck(ped)
			end
		else
			othercheck(ped)
			--Other animation
		end
	end
end)


function othercheck(ped)
	if DoesEntityExist( ped ) and not IsEntityDead( ped ) and not IsPedInAnyVehicle(PlayerPedId(), true) then
		local pedweapon = GetSelectedPedWeapon(ped)

		if CheckWeaponBack(ped) then
			if otherholstered == true then
				SetCurrentPedWeapon(ped,`weapon_unarmed`,true)
				loadAnimDict( "reaction@intimidation@1h" )
				loadAnimDict( "weapons@pistol_1h@gang" )
				while not HasAnimDictLoaded('reaction@intimidation@1h') do
					Citizen.Wait(0)
				end
				while not HasAnimDictLoaded('weapons@pistol_1h@gang') do
					Citizen.Wait(0)
				end

				
				TaskPlayAnim(ped, "reaction@intimidation@1h", "intro", 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
				DisablePlayerFiring(GetPlayerPed(-1), true)
				Wait(1000)
				SetCurrentPedWeapon(ped,pedweapon,true)
				Citizen.Wait(1500)
				DisablePlayerFiring(GetPlayerPed(-1), false)
				ClearPedTasks(ped)
				lweaponhash = GetSelectedPedWeapon(ped)

				Citizen.Wait(100)					
				otherholstered = false
			end
		elseif not CheckWeaponBack(ped) then
			if (otherholstered == false )  then
				loadAnimDict( "reaction@intimidation@1h" )
				loadAnimDict( "weapons@pistol_1h@gang" )
				SetCurrentPedWeapon(ped,lweaponhash,true)
				while not HasAnimDictLoaded('reaction@intimidation@1h') do
					Citizen.Wait(0)
				end
				while not HasAnimDictLoaded('weapons@pistol_1h@gang') do
					Citizen.Wait(0)
				end

				TaskPlayAnim(ped, "reaction@intimidation@1h", "outro", 8.0, 2.0, -1, 48, 2, 0, 0, 0 )
				DisablePlayerFiring(GetPlayerPed(-1), true)
				Citizen.Wait(1500)
				SetCurrentPedWeapon(ped,`weapon_unarmed`,true)
				DisablePlayerFiring(GetPlayerPed(-1), false)			
				ClearPedTasks(ped)
				lweaponhash = GetSelectedPedWeapon(ped)

				otherholstered = true
			end
		end
	end

end


-- DO NOT REMOVE THESE! --


function CheckSkinc(ped)
	local peddraw7 = GetPedDrawableVariation(ped,7)
	local peddraw5 = GetPedDrawableVariation(ped,5)
	if peddraw7  == 1 or peddraw7 == 2 or peddraw7 == 3 or peddraw7 == 8 or peddraw7 == 5 or peddraw7 == 6 or peddraw7 == 7 or peddraw7 == 9 or peddraw5 == 60 or peddraw5 == 61 then
		return true
	end

	return false
end



function CheckWeapon(ped)
	local weaponselected = GetSelectedPedWeapon(ped)
	for i = 1, #weapons do
		if weapons[i] == weaponselected then
			return true
		end
	end
	return false
end

function CheckWeaponBack(ped)
	local weaponselected = GetSelectedPedWeapon(ped)
	for i = 1, #weaponsback do
		if weapons[i] == weaponselected then
			return true
		end
	end
	return false
end

function inventoryWeapon(ped)

	for i=1, #weapons do
		if HasPedGotWeapon(ped,weapons[i],false) then
			return true
				
		end
	end
	return false
end



function DisableActions(ped)
	DisableControlAction(1, 140, true)
	DisableControlAction(1, 141, true)
	DisableControlAction(1, 142, true)
	DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
	DisablePlayerFiring(ped, true) -- Disable weapon firing
end

function loadAnimDict( dict )
	while ( not HasAnimDictLoaded( dict ) ) do
		RequestAnimDict( dict )
		Citizen.Wait( 0 )
	end
end

