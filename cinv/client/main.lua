isInInventory = false
ESX = nil

s_lasttime = 0
s_requestid = 0
s_waitingOnResults = false

local reloadingweapons = false

RegisterNetEvent('f70a94e1-da28-43f4-be18-84c42ed405b7')
AddEventHandler('44368702-7ebe-4064-b595-9596a2756b35',function()
	s_waitingOnResults = false
end)

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


local fastWeapons = {
	[1] = nil,
	[2] = nil,
	[3] = nil,
    [4] = nil,
    [5] = nil
}
local canPlayAnim = true
local fastItemsHotbar = {}
local itemslist ={}
local isHotbar = false
local permHotbar = false
local handsup = false
local handsonhead = false
local canHandsUp = true
local tmrLastPress = 0

local savepending = false
local fastItemsHotbarChange = false

local first_load = false

RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function()
	Wait(15000)
	first_load = true
end)


AddEventHandler('659824d3-4327-4654-8038-052c37b882e7', function()
	if handsonhead == true then
		handsonhead = false
	end
	
	
	if handsup then
		
		local lPed = GetPlayerPed(-1)
		if DoesEntityExist(lPed) then
			Citizen.CreateThread(function()
		
			handsup = false
			DisablePlayerFiring(lPed, false)
			ClearPedSecondaryTask(lPed)

			end)
		end
	end
	handsup = false
	canHandsUp = true
end)



Citizen.CreateThread(
    function()
        while ESX == nil do
            TriggerEvent(
                "esx:getSharedObject",
                function(obj)
                    ESX = obj
                end
            )
            Citizen.Wait(10)
        end
		
        Citizen.Wait(10000)
		PlayerData = ESX.GetPlayerData()
	    toghud = true
		pcall(function()
			if ESX.GetPlayerData().job.name then 
				first_load = true
			end			
		end)
    end
)


-- HIDE WEAPON WHEEL
Citizen.CreateThread(function ()
        Citizen.Wait(2000)
        while true do
			Citizen.Wait(0)
			HideHudComponentThisFrame(19)
			HideHudComponentThisFrame(20)
			BlockWeaponWheelThisFrame()
			DisableControlAction(0, 37,true)
        end
end)


Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(500)
    end
	while first_load == false do
        Citizen.Wait(500)
    end
  local tmr = GetGameTimer()	
  while true do
	Citizen.Wait(0)
	
		local lPed = PlayerPedId()
		if handsup == true or handsonhead == true then
			DisableControlAction(2, 24, true) -- Attack
			DisableControlAction(2, 257, true) -- Attack 2
			DisableControlAction(2, 25, true) -- Aim
			DisableControlAction(2, 263, true) -- Melee Attack 1
			DisableControlAction(2, Keys['R'], true) -- Reload
			DisableControlAction(2, Keys['TOP'], true) -- Open phone (not needed?)
			DisableControlAction(2, Keys['SPACE'], true) -- Jump
			DisableControlAction(2, Keys['Q'], true) -- Cover
			DisableControlAction(2, Keys['TAB'], true) -- Select Weapon
			DisableControlAction(2, Keys['F'], true) -- Also 'enter'?
			DisableControlAction(2, Keys['F1'], true) -- Disable phone
			DisableControlAction(2, Keys['F2'], true) -- Inventory
			DisableControlAction(2, Keys['F3'], true) -- Animations
			DisableControlAction(2, Keys['M'], true) -- Animations
			--DisableControlAction(2, Keys['V'], true) -- Disable changing view
			DisableControlAction(2, Keys['P'], true) -- Disable pause screen
			DisableControlAction(2, 59, true) -- Disable steering in vehicle
			DisableControlAction(2, Keys['LEFTCTRL'], true) -- Disable going stealth
			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
			
			--[[if IsEntityPlayingAnim(lPed, "random@arrests@busted", "idle_c", 3) == false then
				handsonhead = false
			end
			
			if IsEntityPlayingAnim(lPed, 'random@mugging3', 'handsup_standing_base', 3) == false then
				handsup = false
			end--]]
		
		end

		if canHandsUp then
			
			if IsControlJustPressed(0,Keys['LEFTALT']) and GetLastInputMethod(1) then
				Wait(1500)
				tmr = GetGameTimer()
			elseif (IsControlPressed(1, Keys['Z']) and IsControlPressed(0,Keys['LEFTALT']) == false and IsControlJustPressed(0,Keys['LEFTALT']) == false and GetLastInputMethod(1) and not 	IsPedInAnyVehicle(lPed, true) and exports.k9:isrunning() == false  and GetGameTimer() - 300 > tmr) then 
			
				if handsonhead == false then
					handsonhead = true
					handsup = false
					tmr = GetGameTimer()
					while not HasAnimDictLoaded("random@arrests@busted") do
						RequestAnimDict("random@arrests@busted")
						Citizen.Wait(5)
					end
					TaskPlayAnim(lPed, "random@arrests@busted", "idle_c", 3.0, 1.0, -1, 50, 0, false, false, false)
					
						Citizen.CreateThread(function()
							while true do
								Wait(1000)
								print(IsEntityPlayingAnim(lPed, 'random@arrests@busted', 'idle_c', 3))
								if not IsEntityPlayingAnim(lPed, 'random@arrests@busted', 'idle_c', 3) then
									handsonhead = false
									if handsup == false then
										DisablePlayerFiring(lPed, false)
										ClearPedSecondaryTask(lPed)
									end
									return
								end								
							end
						end)
				else
					tmr = GetGameTimer()
					handsonhead = false
					handsup = false
					ClearPedTasks(lPed)
				end
				
			end
			
			
			if (IsControlPressed(1, Keys['X']) and GetLastInputMethod(1) and not IsPedInAnyVehicle(lPed, true) and GetGameTimer() - 300 > tmr) then
				tmr = GetGameTimer()
				if handsup then
					if DoesEntityExist(lPed) then
						Citizen.CreateThread(function()
							RequestAnimDict("random@mugging3")
							while not HasAnimDictLoaded("random@mugging3") do
								Citizen.Wait(100)
							end

							if handsup then
								handsup = false
										
								DisablePlayerFiring(playerPed, false)
								ClearPedSecondaryTask(lPed)
	
							end
						end)
					end
				else
					if DoesEntityExist(lPed) then
					
						Citizen.CreateThread(function()
							RequestAnimDict("random@mugging3")
							while not HasAnimDictLoaded("random@mugging3") do
								Citizen.Wait(100)
							end

							if not handsup then
								DisablePlayerFiring(playerPed, true)
								handsup = true
								handsonhead = false
								TaskPlayAnim(lPed, "random@mugging3", "handsup_standing_base", 6.0, -6.0, -1, 49, 0, 0, 0, 0)
							end
						end)
						Citizen.CreateThread(function()
							while true do
								Wait(1000)
								if not IsEntityPlayingAnim(lPed, 'random@mugging3', 'handsup_standing_base', 3) then
									handsup = false
									if handsonhead == false then
										DisablePlayerFiring(lPed, false)
										ClearPedSecondaryTask(lPed)
									end
									return
								end								
							end
						end)
					end
				end
				
			end
		end
	end
end)


Citizen.CreateThread(function()
    while ESX == nil do
        Citizen.Wait(500)
    end
	while first_load == false do
        Citizen.Wait(500)
    end
	while  ESX == nil and PlayerData == nil and PlayerData.inventory == nil do
        Citizen.Wait(500)
    end
	Wait(5000)
	local inventoryitems = {}

	if ESX ~= nil and PlayerData ~= nil and PlayerData.inventory ~= nil then
		
		for i=1, #PlayerData.inventory, 1 do
			if PlayerData.inventory[i].usable == true or string.find(PlayerData.inventory[i].name, "weapon_", 1) then
				inventoryitems[tostring(PlayerData.inventory[i].name)] = true
			end
		end
	end
	
    while true do
        Citizen.Wait(0)

        if not IsPlayerDead(PlayerId()) then
            
            if IsDisabledControlJustPressed(1, Config.OpenControl) and GetLastInputMethod(0) and not exports.esx_policejob:amicuffed()  and exports.webcops.isKeyboardOpen() == false and exports.gcphone.isPhoneOpen() == false and GetGameTimer() - 1000 > tmrLastPress  then
					
					tmrLastPress = GetGameTimer()
                    openInventory()
					exports['mythic_notify']:DoCustomHudText('error',"You can only be robbed by <strong>/steal</strong> by another player. You do not need to 'hand over' items to anyone yourself if asked even under duress yourself, it must be via /steal.",15000)
					exports['mythic_notify']:DoCustomHudText('inform',"You cannot be robbed of clean money.",20000)
					exports.pNotify:SendNotification(
					{
						text = "You can only be robbed by <strong>/steal</strong>. You do not need to 'hand over' items to anyone yourself if asked.",
						type = "error",
						timeout = 6000,
						layout = "bottomCenter",
						queue = "inventoryhud"
					}
					)


					--[[
					if not HasAnimDictLoaded('amb@prop_human_parking_meter@male@base') then
                        while (not HasAnimDictLoaded('amb@prop_human_parking_meter@male@base')) do
                            RequestAnimDict('amb@prop_human_parking_meter@male@base')
                            Citizen.Wait(10)
                        end
                    end
                    while isInInventory do
                        if canPlayAnim then
                            TaskPlayAnim(PlayerPedId(),'amb@prop_human_parking_meter@male@base', 'base', 1.0, 1.0, -1, 48, 0.0, 0, 0, 0)
                            Citizen.Wait(2000)
                        end
                        Citizen.Wait(10)
                    end --]]
            --    end
            elseif IsDisabledControlJustReleased(1,  Keys["1"]) and canFire and exports.gcphone.isPhoneOpen() == false and (GetVehiclePedIsIn(PlayerPedId()) > 0 or GetVehiclePedIsIn(PlayerPedId()) ==0) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()),-1) ~= PlayerPedId() and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()),0) ~= PlayerPedId() and GetGameTimer() - 500 > tmrLastPress then
				if not exports.esx_policejob:amicuffed()  then
					if fastWeapons[1] ~= nil then
						tmrLastPress = GetGameTimer()
						--if inventoryitems[tostring(fastWeapons[1])] then
							TriggerServerEvent('733fadfc-add0-42b7-b234-b0dfc85bc348', fastWeapons[1])
						--end
					end
				end
            elseif IsDisabledControlJustReleased(1, Keys["2"]) and canFire and exports.gcphone.isPhoneOpen() == false and (GetVehiclePedIsIn(PlayerPedId()) > 0 or GetVehiclePedIsIn(PlayerPedId()) ==0) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()),-1) ~= PlayerPedId() and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()),0) ~= PlayerPedId() and GetGameTimer() - 500 > tmrLastPress then
                if not exports.esx_policejob:amicuffed() and fastWeapons[2] ~= nil then
					tmrLastPress = GetGameTimer()
					--if inventoryitems[tostring(fastWeapons[2])] then
						TriggerServerEvent('733fadfc-add0-42b7-b234-b0dfc85bc348', fastWeapons[2])
					--end
                end
            elseif IsDisabledControlJustReleased(1, Keys["3"]) and canFire and exports.gcphone.isPhoneOpen() == false and (GetVehiclePedIsIn(PlayerPedId()) > 0 or GetVehiclePedIsIn(PlayerPedId()) ==0) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()),-1) ~= PlayerPedId() and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()),0) ~= PlayerPedId() and GetGameTimer() - 500 > tmrLastPress then
                if not exports.esx_policejob:amicuffed() and fastWeapons[3] ~= nil then
					tmrLastPress = GetGameTimer()
					--if inventoryitems[tostring(fastWeapons[3])] then
						TriggerServerEvent('733fadfc-add0-42b7-b234-b0dfc85bc348', fastWeapons[3])
					--end
                end
            elseif IsDisabledControlJustReleased(1, Keys["4"]) and canFire and exports.gcphone.isPhoneOpen() == false and (GetVehiclePedIsIn(PlayerPedId()) > 0 or GetVehiclePedIsIn(PlayerPedId()) ==0) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()),-1) ~= PlayerPedId() and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()),0) ~= PlayerPedId() and GetGameTimer() - 500 > tmrLastPress then
                if not exports.esx_policejob:amicuffed() and fastWeapons[4] ~= nil then
					tmrLastPress = GetGameTimer()
					--if inventoryitems[tostring(fastWeapons[4])] then
						TriggerServerEvent('733fadfc-add0-42b7-b234-b0dfc85bc348', fastWeapons[4])
					--end
                end
            elseif IsDisabledControlJustReleased(1, Keys["5"]) and canFire and exports.gcphone.isPhoneOpen() == false and (GetVehiclePedIsIn(PlayerPedId()) > 0 or GetVehiclePedIsIn(PlayerPedId()) ==0) and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()),-1) ~= PlayerPedId() and GetPedInVehicleSeat(GetVehiclePedIsIn(PlayerPedId()),0) ~= PlayerPedId() and GetGameTimer() - 500 > tmrLastPress then
                if  not exports.esx_policejob:amicuffed() and fastWeapons[5] ~= nil then
					tmrLastPress = GetGameTimer()
					--if inventoryitems[tostring(fastWeapons[5])] then
						TriggerServerEvent('733fadfc-add0-42b7-b234-b0dfc85bc348', fastWeapons[5])
					--end
                end
            elseif IsDisabledControlJustReleased(1, Config.AltOpenControl) then
				if not exports.esx_policejob:amicuffed()  then
					showHotbar()
				end
            end
			
			
		

		
        end
    end
end)

function lockinv()
    Citizen.CreateThread(function()
        while isInInventory do
            Citizen.Wait(0)
            DisableControlAction(0, 1, true) -- Disable pan
            DisableControlAction(0, 2, true) -- Disable tilt
            DisableControlAction(0, 24, true) -- Attack
            DisableControlAction(0, 257, true) -- Attack 2
            DisableControlAction(0, 25, true) -- Aim
            DisableControlAction(0, 263, true) -- Melee Attack 1
            DisableControlAction(0, Keys["W"], true) -- W
            DisableControlAction(0, Keys["A"], true) -- A
            DisableControlAction(0, 31, true) -- S (fault in Keys table!)
            DisableControlAction(0, 30, true) -- D (fault in Keys table!)

            DisableControlAction(0, Keys["R"], true) -- Reload
            DisableControlAction(0, Keys["SPACE"], true) -- Jump
            DisableControlAction(0, Keys["Q"], true) -- Cover
            DisableControlAction(0, Keys["TAB"], true) -- Select Weapon
            DisableControlAction(0, Keys["F"], true) -- Also 'enter'?

            DisableControlAction(0, Keys["F1"], true) -- Disable phone
            DisableControlAction(0, Keys["F2"], true) -- Inventory
            DisableControlAction(0, Keys["F3"], true) -- Animations
            DisableControlAction(0, Keys["F6"], true) -- Job

            DisableControlAction(0, Keys["V"], true) -- Disable changing view
            DisableControlAction(0, Keys["C"], true) -- Disable looking behind
            DisableControlAction(0, Keys["X"], true) -- Disable clearing animation
            DisableControlAction(2, Keys["P"], true) -- Disable pause screen

            DisableControlAction(0, 59, true) -- Disable steering in vehicle
            DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
            DisableControlAction(0, 72, true) -- Disable reversing in vehicle

            DisableControlAction(2, Keys["LEFTCTRL"], true) -- Disable going stealth

            DisableControlAction(0, 47, true) -- Disable weapon
            DisableControlAction(0, 264, true) -- Disable 
            DisableControlAction(0, 257, true) -- Disable melee
            DisableControlAction(0, 140, true) -- Disable melee
            DisableControlAction(0, 141, true) -- Disable melee
            DisableControlAction(0, 142, true) -- Disable melee
            DisableControlAction(0, 143, true) -- Disable melee
            DisableControlAction(0, 75, true) -- Disable exit vehicle
            DisableControlAction(27, 75, true) -- Disable exit vehicle
        end
    end)
end

function getPlayerWeight()
    Citizen.CreateThread(function()
        ESX.TriggerServerCallback('18cc7340-2884-4f12-8020-d4f093de47cc', function(cb)
            local playerweight = cb
            --[[SendNUIMessage({
                action = "setWeightText",
                text =  "<strong>         "..tostring(playerweight).."/"..tostring(Config.MaxWeight).."KG<strong>"
            })]]
            weight = playerweight
            if weight >= Config.MaxWeight then
                weight = 100
            end
            WeightLoaded = true
        end)
    end)
end



function loadStatus()
        local player = PlayerPedId()
        health = (GetEntityHealth(player) - 100)
        armour = GetPedArmour(player)
		if health  > 100 then
			health = 100
		end
		if armour > 100 then
			armour = 100
		end
        if IsPedOnFoot(player) then
            if IsPedSwimmingUnderWater(player) then
                oxy = (GetPlayerUnderwaterTimeRemaining(PlayerId()))
            else
                oxy = (GetPlayerSprintStaminaRemaining(PlayerId()))
            end
        else
            oxy = 0
        end
		

-- SET YOUR STATUS HERE (ESX BASIC NEEDS, STRESS OR  OR WTV YOU ARE USING)
--[[
        TriggerEvent('d3a452da-a8d5-439a-a3ba-b946cf97edd9', 'hunger', function(hunger)
            TriggerEvent('d3a452da-a8d5-439a-a3ba-b946cf97edd9', 'thirst', function(thirst)
                TriggerEvent('d3a452da-a8d5-439a-a3ba-b946cf97edd9','stress',function(stress)
                    myhunger = hunger.getPercent()
                    mythirst = thirst.getPercent()
                    mystress = stress.getPercent()
                    StatusLoaded = true
                end)
            end)
        end)
        ]]
-- DELETE THIS AFTER COMPLETING THE ABOVE CODE
		
        myhunger = math.floor(exports.esx_status:getStatus('hunger').getPercent())
        mythirst = math.floor(exports.esx_status:getStatus('thirst').getPercent())
        mystress = 0
        StatusLoaded = true
-- DELETE THIS AFTER COMPLETING THE ABOVE CODE

end

function loadItems()
    Citizen.CreateThread(function()
        ESX.TriggerServerCallback('5fc9b3ba-227c-4502-8141-c684b8ac3c9c', function(data)
            items = {}
            fastItems = {}
            inventory = data.inventory
            accounts = data.accounts
            money = data.money
            weapons = data.weapons

            if Config.IncludeCash and money ~= nil and money > 0 then
                moneyData = {
                    label = _U("cash"),
                    name = "cash",
                    type = "item_money",
                    count = money,
                    usable = false,
                    rare = false,
                    weight = 0,
                    canRemove = true
                }

                table.insert(items, moneyData)
            end

            if Config.IncludeAccounts and accounts ~= nil then
                for key, value in pairs(accounts) do
                    if not shouldSkipAccount(accounts[key].name) then
                        local canDrop = accounts[key].name ~= "bank"

                        if accounts[key].money > 0 then
                            accountData = {
                                label = accounts[key].label,
                                count = accounts[key].money,
                                type = "item_account",
                                name = accounts[key].name,
                                usable = false,
                                rare = false,
                                weight = 0,
                                canRemove = canDrop
                            }
                            table.insert(items, accountData)
                        end
                    end
                end
            end
            if inventory ~= nil then
                for key, value in pairs(inventory) do
                    if inventory[key].count <= 0 then
                        inventory[key] = nil
                    else
                        inventory[key].type = "item_standard"
                        local founditem = false
                        for slot, item in pairs(fastWeapons) do
                            if item == inventory[key].name then
                                table.insert(
                                        fastItems,
                                        {
                                            label = inventory[key].label,
                                            count = inventory[key].count,
                                            weight = 0,
                                            type = "item_standard",
                                            name = inventory[key].name,
                                            usable = inventory[key].usable,
                                            rare = inventory[key].rare,
                                            canRemove = true,
                                            slot = slot
                                        }
                                )
                                founditem = true
                                break
                            end
                            end
                            if founditem == false then
                             table.insert(items, inventory[key])

                        end
                    end
                end
            end

            if Config.IncludeWeapons and weapons ~= nil then
                for key, value in pairs(weapons) do
                    local weaponHash = GetHashKey(weapons[key].name)
                    local playerPed = PlayerPedId()
                    if weapons[key].name ~= "WEAPON_UNARMED" then
								local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
								table.insert(
									items,
									{
										label = weapons[key].label,
										count = ammo,
										weight = 0,
										type = "item_weapon",
										name = weapons[key].name,
										usable = false,
										rare = false,
										canRemove = true
									}
								)
							end
                    end
                end
            fastItemsHotbar =  fastItems
            SendNUIMessage(
                {
                    action = "setItems",
                    itemList = items,
                    fastItems = fastItems,
                    weight = weight
                }
            )
            ItemsLoaded = true
        end, GetPlayerServerId(PlayerId()))
    end)
end

function openInventory()
 --   loadPlayerInventory()
    isInInventory = true
	if permHotbar == true then
		SendNUIMessage({
				action = "closehotbar",
		})
		Wait(500)
	end
    lockinv()
    SetNuiFocus(true, true)  
    loadPlayerInventory()


    SendNUIMessage(
        {
            action = "display",
            type = "normal",
            hunger = myhunger,
            thirst = mythirst,
            stress = mystress,
            health = health,
            armour = armour,
            oxygen = oxy,
            weight = weight
        }
    )
end

function closeInventory()
    isInInventory = false
    ClearPedSecondaryTask(PlayerPedId())
    SendNUIMessage(
        {
            action = "hide"
        }
    )
    SetNuiFocus(false, false)
	ClearPedSecondaryTask(PlayerPedId())
end

function shouldCloseInventory(itemName)
    for index, value in ipairs(Config.CloseUiItems) do
        if value == itemName then
            return true
        end
    end

    return false
end


RegisterNetEvent('f9885fd8-614b-4ff3-bf7e-75d2406139bb')
AddEventHandler('f9885fd8-614b-4ff3-bf7e-75d2406139bb', function(name, count)

 print(fastWeapons[1])
 for x,y in pairs(fastWeapons) do
	if fastWeapons[x] == name then
		fastWeapons[x] = nil
		print('removed ' .. name )
	end
 end

--[[
    fastWeapons = {
        [1] = nil,
        [2] = nil,
        [3] = nil,
        [4] = nil,
        [5] = nil
    } --]]
   
end)

function shouldSkipAccount(accountName)
    for index, value in ipairs(Config.ExcludeAccountsList) do
        if value == accountName then
            return true
        end
    end

    return false
end

function loadPlayerInventory()
    WeightLoaded = false
    getPlayerWeight()
    StatusLoaded = false
    loadStatus()
    ItemsLoaded = false
    loadItems()
    while not ItemsLoaded or not StatusLoaded or not WeightLoaded do
        Citizen.Wait(100)
    end
end

function showHotbar()
    if not isHotbar and not permHotbar then
        isHotbar = true
        SendNUIMessage({
            action = "showhotbar",
            fastItems = fastItemsHotbar,
            itemList = itemslist
        })
		
		Citizen.Wait(1500)
		isHotbar = false
    end
end

RegisterCommand("togglehotbar", function(source, args, raw)
	permHotbar = not permHotbar
	if permHotbar == true then
		--print(json.encode(fastItemsHotbar))
		--print('sep')
		--print(json.encode(itemslist))
		SendNUIMessage({
            action = "showhotbarP",
            fastItems = fastItemsHotbar,
            itemList = itemslist
        })
	else
		SendNUIMessage({
            action = "closehotbar",
        })	
	end
end)

RegisterNUICallback("NUIFocusOff", function()
    if isInInventory then
        closeInventory()
		if fastItemsHotbarChange then
			print(json.encode(fastWeapons))
		end
    end
	if permHotbar == true then
		SendNUIMessage({
            action = "showhotbarP",
            fastItems = fastItemsHotbar,
            itemList = itemslist
        })
	end
	isInInventory = false
end)


RegisterNUICallback("GetNearPlayers", function(data, cb)
        local playerPed = PlayerPedId()
		local myCoords = GetEntityCoords(playerPed)
        local players, nearbyPlayer = ESX.Game.GetPlayersInArea(myCoords, 2.0)
        local foundPlayers = false
        local elements = {}

        for i = 1, #players, 1 do
            if players[i] ~= PlayerId() then
                foundPlayers = true
				local loc1 = GetEntityCoords(GetPlayerPed(players[i]))
				local distance = #(myCoords - loc1)
				distance = 0.625 * distance
                table.insert(
                    elements,
                    {
                        label = 'Distance: ' .. string.format("%.2f", distance) .. "m",
                        player = GetPlayerServerId(players[i])
                    }
                )
            end
        end

        if not foundPlayers then
            exports.pNotify:SendNotification(
                {
                    text = _U("players_nearby"),
                    type = "error",
                    timeout = 3000,
                    layout = "bottomCenter",
                    queue = "inventoryhud"
                }
            )
        else
            SendNUIMessage(
                {
                    action = "nearPlayers",
                    foundAny = foundPlayers,
                    players = elements,
                    item = data.item
                }
            )
        end

        cb("ok")
end)




RegisterNUICallback("UseItem",function(data, cb)
		if data.item ~= nil and data.item.name ~= nil and data.slot == nil then
			TriggerServerEvent('733fadfc-add0-42b7-b234-b0dfc85bc348', data.item.name)

			if shouldCloseInventory(data.item.name) then
				closeInventory()
			else
				Citizen.Wait(250)
				loadPlayerInventory()
			end

			cb("ok")
		end
    end
)

RegisterNUICallback("UseItem",function(data, cb)
        TriggerServerEvent('733fadfc-add0-42b7-b234-b0dfc85bc348', fastWeapons[tonumber(data.slot)])
end)

RegisterNUICallback("DropItem",
    function(data, cb)
        if IsPedSittingInAnyVehicle(playerPed) then
            return
        end
		if IsPedRagdoll(PlayerPedId()) then
			return
		end

		if data.item.type == 'item_money' then
			   exports.pNotify:SendNotification(
                {
                    text = 'Error: You cannot get rid of cash like that!',
                    type = "error",
                    timeout = 4000,
                    layout = "bottomCenter",
                    queue = "inventoryhud"
                }
            )
			return
		end

        if type(data.number) == "number" and math.floor(data.number) == data.number then
     --       TriggerServerEvent('051bed4d-4beb-4f04-8421-0a6cb7687a2b', "[DROP ITEM] | "..data.item.name .." quant: "..data.number, GetPlayerServerId(PlayerId()), GetCurrentResourceName())
            TriggerServerEvent('f79a9b3c-e921-438e-8a6f-beb2f22242fa', data.item.type, data.item.name, data.number)
        end

        Wait(500)
        loadPlayerInventory()

        cb("ok")
    end
)


RegisterNUICallback("GiveItem", function(data, cb)

        local playerPed = PlayerPedId()
        local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 3.0)
		local count = tonumber(data.number)
        if data.item.type == "item_weapon" then
            count = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(data.item.name))
        end
        canPlayAnim = false
        ClearPedSecondaryTask(PlayerPedId())
		RequestAnimDict("mp_common")
        while (not HasAnimDictLoaded("mp_common")) do 
            Citizen.Wait(10) 
        end
        local foundPlayer = false
        for i = 1, #players, 1 do
            if players[i] ~= PlayerId() then
                if GetPlayerServerId(players[i]) == data.player then
                    foundPlayer = true
                end
            end
        end

			if foundPlayer then
			local count = tonumber(data.number)
			TaskPlayAnim(PlayerPedId(),"mp_common","givetake1_a",100.0, 200.0, 0.3, 120, 0.2, 0, 0, 0)
			SetCurrentPedWeapon(PlayerPedId(), 0xA2719263) 
			if (Config.PropList[data.item.name] ~= nil) then 
				attachModel = GetHashKey(Config.PropList[data.item.name].model)
				local bone = GetPedBoneIndex(PlayerPedId(), Config.PropList[data.item.name].bone)
				RequestModel(attachModel)
				while not HasModelLoaded(attachModel) do
					Citizen.Wait(10)
				end
				closestEntity = CreateObject(attachModel, 1.0, 1.0, 1.0, 1, 1, 0)
				AttachEntityToEntity(closestEntity, PlayerPedId(), bone, Config.PropList[data.item.name].x, Config.PropList[data.item.name].y, Config.PropList[data.item.name].z,
				Config.PropList[data.item.name].xR, Config.PropList[data.item.name].yR, Config.PropList[data.item.name].zR, 1, 1, 0, true, 2, 1)
				Citizen.Wait(1500)
				if DoesEntityExist(closestEntity) then
					DeleteEntity(closestEntity)
				end
			end
			SetCurrentPedWeapon(PlayerPedId(), GetHashKey("weapon_unarmed"), 1)
			canPlayAnim = true
			--TriggerServerEvent('adaeebd0-faf0-4285-bd54-895c9427c869', GetPlayerServerId(closestPlayer), data.item.type, data.item.name, count)
			--Wait(250)
			--loadPlayerInventory()

			 TriggerServerEvent('cdd99c92-191e-4465-badb-b0229a507645',true, GetPlayerServerId(PlayerId()), data.player, data.item.type, data.item.name, count)

            --TriggerServerEvent('adaeebd0-faf0-4285-bd54-895c9427c869', data.player, data.item.type, data.item.name, count)
            Wait(300)
            loadPlayerInventory()
        else
            exports.pNotify:SendNotification(
                {
                    text = _U("player_nearby"),
                    type = "error",
                    timeout = 3000,
                    layout = "bottomCenter",
                    queue = "inventoryhud"
                }
            )
        end
        cb("ok")
    end)


RegisterNUICallback("PutIntoFast", function(data, cb)
		
		if data.item.slot ~= nil then
			fastWeapons[data.item.slot] = nil
			print('change recorded for hot bar A')
			fastItemsHotbarChange = true
		end
		
		if fastWeapons[data.slot] ~= data.item.name then
			print('change recorded for hot bar B')
			fastItemsHotbarChange = true
		end
		
		if savepending == false then
			savepending = true
			Wait(10000)
			Citizen.CreateThread(function()
				savepending = false
				TriggerServerEvent('7ea04239-7e28-43d0-a47b-547af685ecb6',json.encode(fastWeapons))
			end)
		end

		fastWeapons[data.slot] = data.item.name
		
		loadPlayerInventory()
		cb("ok")
end)

RegisterNUICallback("TakeFromFast", function(data, cb)
	if fastWeapons[data.item.slot] ~= nil then
		print('change recorded for hot bar C')
		fastItemsHotbarChange = true
	end
    fastWeapons[data.item.slot] = nil
    if string.find(data.item.name, "WEAPON_", 1) ~= nil and GetSelectedPedWeapon(PlayerPedId()) == GetHashKey(data.item.name) then
        TriggerEvent('c3fc5fbf-b7c2-4c70-ab6f-78e331158b5c', _source)
        RemoveWeapon(data.item.name)
    end
	
	if savepending == false then
			savepending = true
			Wait(10000)
			Citizen.CreateThread(function()
				savepending = false
				TriggerServerEvent('7ea04239-7e28-43d0-a47b-547af685ecb6',json.encode(fastWeapons))
			end)
		end
    loadPlayerInventory()
    cb("ok")
end)

RegisterNetEvent('93801381-d352-49d3-aa43-2f14dc1f21e1')
AddEventHandler('93801381-d352-49d3-aa43-2f14dc1f21e1', function(disabled)
    canFire = disabled
end)


RegisterNetEvent('46003cb9-b463-4bcb-bf68-145e4e8a3ef7')
AddEventHandler('46003cb9-b463-4bcb-bf68-145e4e8a3ef7', function(fweapons)
	Wait(2000)
	if fweapons ~= nil then
		local fweapons2 = json.decode(fweapons)
		if type(fweapons2) == 'table' then
			fastWeapons = fweapons2
			loadPlayerInventory()
		end
	end
	
end)



RegisterNetEvent('0f7594f9-29a3-4b1f-8967-1dc8f5f1ddc3')
AddEventHandler('0f7594f9-29a3-4b1f-8967-1dc8f5f1ddc3', function(sourceitemname, sourceitemlabel, sourceitemcount, sourceitemremove)
        SendNUIMessage({
            action = "notification",
            itemname = sourceitemname,
            itemlabel = sourceitemlabel,
            itemcount = sourceitemcount,
            itemremove = sourceitemremove
        })
end)

RegisterNetEvent('c3fc5fbf-b7c2-4c70-ab6f-78e331158b5c')
AddEventHandler('c3fc5fbf-b7c2-4c70-ab6f-78e331158b5c', function()
    closeInventory()
end)


--[[
RegisterNetEvent('fb090542-0e34-415b-8e68-52343b85b0be')
AddEventHandler('fb090542-0e34-415b-8e68-52343b85b0be', function()
    fastWeapons = {
        [1] = nil,
        [2] = nil,
        [3] = nil,
        [4] = nil,
        [5] = nil
    }
   
end)--]]

RegisterNetEvent('bba02fe1-8506-42a2-992c-08a7b4080249')
AddEventHandler('179bc2d6-4010-46ed-8419-b537553113a6', function(...) 
    closeInventory(...); 
end)


