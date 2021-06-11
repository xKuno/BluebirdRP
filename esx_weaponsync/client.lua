ESX = nil

local Weapons = {}
local AmmoTypes = {}

local PlayerData = nil
local AmmoInClip = {}

local CurrentWeapon = nil

local IsShooting = false
local HasBeenShooting = false
local AmmoBefore = 0

----
local cheatLock = false
local itemsCount = nil
local cheatCheck = {}
local lastRebuild = 0
---

local running = true

for name,item in pairs(Config.Weapons) do
  Weapons[item.hash] = item
end

for name,item in pairs(Config.AmmoTypes) do
  AmmoTypes[item.hash] = item
end

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

function GetAmmoItemFromHash(hash)
  for name,item in pairs(Config.Weapons) do
    if hash == item.hash then
      if item.ammo then
        return item.ammo
      else
        return nil
      end
    end
  end
  return nil
end

function GetInventoryItem(name)
  local inventory = PlayerData.inventory
  for i=1, #inventory, 1 do
    if inventory[i].name == name then
      return inventory[i]
    end
  end
  return nil
end

local suppressor = 0
local flashlight = 0
local grip = 0
local clip_extended = 0
local scope = 0

function RebuildLoadout()
  
  if running == true then
	  while not PlayerData do
		Citizen.Wait(0)
	  end
	  
	  local playerPed = GetPlayerPed(-1)
	  
	  local _itemsCount = 0
	  local _itemsRemoved = 0
	  local _itemsRemovedList = {}
	  
	   local _suppressor = GetInventoryItem("suppressor").count
	   local _flashlight = GetInventoryItem("flashlight").count
	   local _grip = GetInventoryItem("grip").count
	   local _clip_extended = GetInventoryItem("clip_extended").count
	   local _scope = GetInventoryItem("scope").count
	  
		local playerPed  = PlayerPedId()
		local weaponHash = GetHashKey(weaponName)



	  for weaponHash,v in pairs(Weapons) do
		local item = GetInventoryItem(v.item)
		if item and item.count > 0 then
		  local ammo = 0
		  local ammoType = GetPedAmmoTypeFromWeapon(playerPed, weaponHash)
			if weaponHash == `weapon_musket` then
				
				--[[
				for c,n in pairs(Config.AmmoTypes) do
					if n.hash == ammoType then
						print('ammo MATCH')
						print(n.hash)
						print(n.item)
					else
						print('.')
					end
				end--]]

				
				
			end
		  if ammoType and AmmoTypes[ammoType] then
			local ammoItem = GetInventoryItem(AmmoTypes[ammoType].item)
			if ammoItem then
			  ammo = ammoItem.count
			end
		  end

		  if string.lower(item.name) == "weapon_fireextinguisher" then
			ammo = 1000
		  end
		  
		  if HasPedGotWeapon(playerPed, weaponHash, false) then
		  
			if suppressor > 0 and _suppressor < 1 then
				local componentHash = nil
				local s, e = pcall(function() componentHash = ESX.GetWeaponComponent(string.upper(v.item), "suppressor").hash end)
				if componentHash then
					RemoveWeaponComponentFromPed(playerPed, weaponHash, componentHash)
				end
			end
			if flashlight > 0 and _flashlight < 1 then
				local componentHash = nil
				local s, e = pcall(function() componentHash = ESX.GetWeaponComponent(string.upper(v.item), "flashlight").hash end)
				if componentHash then
					RemoveWeaponComponentFromPed(playerPed, weaponHash, componentHash)
				end
			end
			if grip > 0 and _grip < 1 then
				local componentHash = nil
				local s, e = pcall(function() componentHash = ESX.GetWeaponComponent(string.upper(v.item), "grip").hash end)
				if componentHash then
					RemoveWeaponComponentFromPed(playerPed, weaponHash, componentHash)
				end
			end
			
			if clip_extended > 0 and _clip_extended < 1 then
				local componentHash = nil
				local s, e = pcall(function() componentHash = ESX.GetWeaponComponent(string.upper(v.item), "clip_extended").hash end)
				if componentHash then
					RemoveWeaponComponentFromPed(playerPed, weaponHash, componentHash)
				end
			end

			if scope > 0 and _scope < 1 then
				local componentHash = nil
				local s, e = pcall(function() componentHash = ESX.GetWeaponComponent(string.upper(v.item), "scope").hash end)
				if componentHash then
					RemoveWeaponComponentFromPed(playerPed, weaponHash, componentHash)
				end
			end

			if GetAmmoInPedWeapon(playerPed, weaponHash) ~= ammo then
			  SetPedAmmo(playerPed, weaponHash, ammo)
			end
		  else
			-- Weapon is missing, give it to the player
			_itemsCount = _itemsCount + 1
			GiveWeaponToPed(playerPed, weaponHash, ammo, false, false)
		  end
		elseif HasPedGotWeapon(playerPed, weaponHash, false) then
		  -- Weapon doesn't belong in loadout
		  _itemsRemoved = _itemsRemoved + 1
		  _itemsRemovedList[v.item] = GetAmmoInPedWeapon(playerPed, weaponHash)
		  RemoveWeaponFromPed(playerPed, weaponHash)
		  
		end
		
	  end
		checkLock = true
	  if checkLock and itemsCount ~= nil and _itemsRemoved > itemsCount then
		--Condition shouldn't occur
		print ('items removed ' .. _itemsRemoved)
		if _itemsRemoved > 3 then
			for cnt,vect in pairs(_itemsRemovedList) do
				TriggerServerEvent('305947f9-8be0-4f8d-b513-a2390d042a7a','WEAPON ISSUE','WEAPON DETECTED WITHOUT AUTH: ' .. cnt .. ' AMMO: ' .. vect)
			end
		end
		RemoveAllPedWeapons(GetPlayerPed(-1),true)
		RebuildLoadout()
	  end
	  
	  itemsCount = _itemsCount
	  flashlight = _flashlight
	  suppressor = _suppressor
	  scope = _scope
	  clip_extended = _clip_extended
  end
	
end

--Need a caching feature


RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(xPlayer)
  Citizen.Wait(10)
  PlayerData = xPlayer
  RebuildLoadout()
  --while count < 30 do
	
  --end
  Citizen.CreateThread(function()
	Wait(500)
	SetCurrentPedWeapon(PlayerPedId(),`WEAPON_UNARMED`,true)
	Wait(200)
	SetCurrentPedWeapon(PlayerPedId(),`WEAPON_UNARMED`,true)
	Wait(200)
	SetCurrentPedWeapon(PlayerPedId(),`WEAPON_UNARMED`,true)
	Wait(200)
	SetCurrentPedWeapon(PlayerPedId(),`WEAPON_UNARMED`,true)
	Wait(200)
	SetCurrentPedWeapon(PlayerPedId(),`WEAPON_UNARMED`,true)
	Wait(200)
	SetCurrentPedWeapon(PlayerPedId(),`WEAPON_UNARMED`,true)
	Wait(200)
	SetCurrentPedWeapon(PlayerPedId(),`WEAPON_UNARMED`,true)
  end)
  Citizen.CreateThread(function()
	Wait(10000)
	cheatLock = true
	
	end)
end)

RegisterNetEvent('cd908022-1c39-4150-8397-9c22eeab8680')
AddEventHandler('cd908022-1c39-4150-8397-9c22eeab8680', function()
  RebuildLoadout()
end)

AddEventHandler('880c0a93-b305-46b3-b84c-a120fee9e841', function()
  RebuildLoadout()
end)

AddEventHandler('3c27e7ae-48fa-44b3-842b-300533df6035', function()
  RebuildLoadout()
end)

RegisterNetEvent('b208de88-03f4-4837-961a-91a430b1cc30')
AddEventHandler('b208de88-03f4-4837-961a-91a430b1cc30', function(name, count)
  Citizen.Wait(1) -- Wait a tick to make sure ESX has updated PlayerData
  PlayerData = ESX.GetPlayerData()
  lastRebuild = GetGameTimer()
  RebuildLoadout()
  
  if CurrentWeapon then
    --AmmoBefore = GetAmmoInPedWeapon(GetPlayerPed(-1), CurrentWeapon)
  end
end)

RegisterNetEvent('f9885fd8-614b-4ff3-bf7e-75d2406139bb')
AddEventHandler('f9885fd8-614b-4ff3-bf7e-75d2406139bb', function(name, count)
  Citizen.Wait(1) -- Wait a tick to make sure ESX has updated PlayerData
  PlayerData = ESX.GetPlayerData()
  lastRebuild = GetGameTimer()

  if string.match(string.lower(name.name), 'weapon_') then
		print('weapon lost instant build')
	   lastRebuild = 0
	   RebuildLoadout()

  end
   Wait(1000)
  if not IsPedShooting(GetPlayerPed(-1)) and HasBeenShooting == false and IsShooting == false then
	   print('fired remove inventory rebuild')
	   RebuildLoadout()
  end
  if CurrentWeapon then
    --AmmoBefore = GetAmmoInPedWeapon(GetPlayerPed(-1), CurrentWeapon)
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)

	if running == true then
		local playerPed = GetPlayerPed(-1)
		local selectedweapon = GetSelectedPedWeapon(playerPed)

		if CurrentWeapon ~= selectedweapon then
		  IsShooting = false
		  RemoveUsedAmmo()
		  CurrentWeapon = selectedweapon
		  AmmoBefore = GetAmmoInPedWeapon(playerPed, CurrentWeapon)
		elseif `weapon_unarmed` == selectedweapon then
			Wait(100)
		end
		
		if IsPedShooting(playerPed) and not IsShooting then
		  IsShooting = true
		  HasBeenShooting = true
		  
		elseif IsShooting and IsControlJustReleased(0, 24) then
		  Wait(100)
		  IsShooting = false
		  AmmoBefore = RemoveUsedAmmo()
		elseif not IsShooting and IsControlJustPressed(0, 45) then
		   --AmmoBefore = GetAmmoInPedWeapon(playerPed, CurrentWeapon)
		  -- AmmoBefore = RemoveUsedAmmo()
		elseif HasBeenShooting == true then
			
			AmmoBefore = RemoveUsedAmmo()
		end
	else
		Wait(200)
	end
  end
end)


local lastdiff = {}

local transactional = {}

function RemoveUsedAmmo()  
  local playerPed = GetPlayerPed(-1)
  local AmmoAfter = GetAmmoInPedWeapon(playerPed, CurrentWeapon)
  local ammoType = AmmoTypes[GetPedAmmoTypeFromWeapon(playerPed, CurrentWeapon)]
  --print(json.encode(ammoType))
  local bf = AmmoBefore
  --print('|| ' ..bf)
  --print(' :' ..AmmoAfter)
  if ammoType and ammoType.item then
    local ammoDiff = AmmoBefore - AmmoAfter
    if ammoDiff > 0 and ammoType.item ~= "weapon_petrolcan" then
		--print("DIFF:" .. ammoDiff)
		--print("BEFORE : " .. AmmoBefore)
		--print("BEFORE : " .. AmmoAfter)
		if (ammoType.item == "pistol_ammo" and ammoDiff > 10) or (ammoType.item == "mg_ammo" and ammoDiff > 25) or (ammoType.item == "smg_ammo" and ammoDiff > 15) or 
		(ammoType.item == "shotgun_ammo" and ammoDiff > 5) or (ammoType.item == "sniper_ammo" and ammoDiff > 8) or (ammoType.item == "rifle_ammo" and ammoDiff > 100) then
		else
			table.insert(transactional,{ammoType = ammoType.item, ammoDiff = ammoDiff})
		end
	else
   
    end
  end
  return AmmoAfter
end

local runningthread = false

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(1000)
		runningthread = true
		local l_transactional = {}
		l_transactional = transactional
		transactional = {}
		local summarry = {}
		local hasvalues_added = false
		
		for _,trans1 in pairs(l_transactional) do
			 hasvalues_added = true
		     if summarry[tostring(trans1.ammoType)] == nil then
				summarry[tostring(trans1.ammoType)] = 0
			 end
			 summarry[tostring(trans1.ammoType)] = summarry[tostring(trans1.ammoType)] + trans1.ammoDiff
		end
		if hasvalues_added == true then
			--print(json.encode(summarry))
			TriggerServerEvent('b4468c8e-48e0-4324-95db-5e149da0ccbb', summarry)
		end
		runningthread = false
	end
end)


function setrunning(state)
	running = state
end


Citizen.CreateThread(function()
  while true do
		Wait(50)
		local currentimer =  GetGameTimer()
		if #transactional  == 0 and runningthread == false and  lastRebuild < (currentimer -10000) then
			lastRebuild = GetGameTimer()
			RebuildLoadout()
			Citizen.Wait(10000)
		elseif lastRebuild < (currentimer -10000) then
			Citizen.Wait(10000)
		end

  end
end)


