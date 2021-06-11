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

local LoadoutLoaded = false
local IsPaused      = false
local PlayerSpawned = false
local LastLoadout   = {}
local Pickups       = {}
local isDead        = false


local inprogressloading = false





RegisterNetEvent('04b5e35f-5dc7-40d5-9543-358955bc0a4b')
AddEventHandler('04b5e35f-5dc7-40d5-9543-358955bc0a4b', function()
	Pickups       = {}
end)





RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(xPlayer)
	UG["playerLoaded:"] = tonum(UG["playerLoaded:"])
	ESX.PlayerLoaded = true
	ESX.PlayerData   = xPlayer
	
	--Starts timer for allowing weaposn to appear
	weapons_allowed_change = true
	weapons_time_change = 0
	TriggerEvent('eaafb39b-b773-446d-838f-df57862dcac8')
	weapons_time_change = 15
	if Config.EnableHud then

		for i=1, #xPlayer.accounts, 1 do
			local accountTpl = '<div><img src="img/accounts/' .. xPlayer.accounts[i].name .. '.png"/>&nbsp;{{money}}</div>'

			ESX.UI.HUD.RegisterElement('account_' .. xPlayer.accounts[i].name, i-1, 0, accountTpl, {
				money = 0
			})

			ESX.UI.HUD.UpdateElement('account_' .. xPlayer.accounts[i].name, {
				money = ESX.Math.GroupDigits(xPlayer.accounts[i].money)
			})
		end

		local jobTpl = '<div>{{job_label}} - {{grade_label}}</div>'

		if xPlayer.job.grade_label == '' then
			jobTpl = '<div>{{job_label}}</div>'
		end

		ESX.UI.HUD.RegisterElement('job', #xPlayer.accounts, 0, jobTpl, {
			job_label   = '',
			grade_label = ''
		})

		ESX.UI.HUD.UpdateElement('job', {
			job_label   = xPlayer.job.label,
			grade_label = xPlayer.job.grade_label
		})

	else
		TriggerEvent('480c190a-70b7-4118-978c-7806b934c23c', 0.0)
	end
	

end)

AddEventHandler('880c0a93-b305-46b3-b84c-a120fee9e841', function()
	UG["playerSpawned:"] = tonum(UG["playerSpawned:"])
	while not ESX.PlayerLoaded do
		Citizen.Wait(1)
	end

	local playerPed = PlayerPedId()

	-- Restore position
	if ESX.PlayerData.lastPosition ~= nil then
		--SetEntityCoords(playerPed, ESX.PlayerData.lastPosition.x, ESX.PlayerData.lastPosition.y, ESX.PlayerData.lastPosition.z)
	end

	--TriggerEvent('76822202-72be-4e7c-84ee-1530c7df06b7') -- restore loadout

	LoadoutLoaded = true
	PlayerSpawned = true
	isDead = false
end)

AddEventHandler('2df4c490-68a8-4c7e-896a-9fc552e16210', function()
	UG["onPlayerDeath:"] = tonum(UG["onPlayerDeath:"])
	isDead = true
end)

AddEventHandler('77e258c7-d610-4a49-892b-17aabf7a3aca', function()
	UG["loadDefaultModel:"] = tonum(UG["loadDefaultModel:"])
	LoadoutLoaded = false
end)

AddEventHandler('3c27e7ae-48fa-44b3-842b-300533df6035', function()
	UG["modelLoaded:"] = tonum(UG["modelLoaded:"])
	while not ESX.PlayerLoaded do
		Citizen.Wait(1)
	end

	TriggerEvent('76822202-72be-4e7c-84ee-1530c7df06b7')
end)

AddEventHandler('76822202-72be-4e7c-84ee-1530c7df06b7', function()
print('hi')
--[[
	inprogressloading = true
	UG["restoreLoadout:"] = tonum(UG["restoreLoadout:"])
	local playerPed = PlayerPedId()
	local ammoTypes = {}
	
	Wait(3000)

	RemoveAllPedWeapons(playerPed, true)
	

	for i=1, #ESX.PlayerData.loadout, 1 do
		local weaponName = ESX.PlayerData.loadout[i].name
		local weaponHash = GetHashKey(weaponName)
		TriggerEvent('eaafb39b-b773-446d-838f-df57862dcac8')
		GiveWeaponToPed(playerPed, weaponHash, 0, false, false)

		local ammoType = GetPedAmmoTypeFromWeapon(playerPed, weaponHash)
		--LG
		if ESX.PlayerData.loadout[i].components ~= nil then
			for j=1, #ESX.PlayerData.loadout[i].components, 1 do
				local weaponComponent = ESX.PlayerData.loadout[i].components[j]
				local componentHash = nil
				pcall(function() componentHash = ESX.GetWeaponComponent(weaponName, weaponComponent).hash end)
				if componentHash ~= nil then
					GiveWeaponComponentToPed(playerPed, weaponHash, componentHash)
				end
			end
		end
		

		if not ammoTypes[ammoType] then
					--local ammo = 1
		
			if ESX.PlayerData.loadout[i].ammo > 200 then
				ammo = 45
			else
				ammo = ESX.PlayerData.loadout[i].ammo
			end 
			ammo = ESX.PlayerData.loadout[i].ammo
			
			AddAmmoToPed(playerPed, weaponHash, ESX.PlayerData.loadout[i].ammo)
			ammoTypes[ammoType] = true
		end

	end
	inprogressloading = false
	LoadoutLoaded = true
	--]]
end)

pendingWR = false
pendingWRcount = 13000
savedloadout = nil

RegisterNetEvent(  'esxf:restoreLoadout')
AddEventHandler(   'esxf:restoreLoadout', function()
print('hi')
--[[
	print(' esxf restore loadout hit')
	if pendingWR == true then
		pendingWRcount = 15000
	else

		pendingWR = true
		pendingWRcount = 15000
		savedloadout = ESX.PlayerData.loadout
		local playerPed = PlayerPedId()
		RemoveAllPedWeapons(playerPed, true)
		TriggerEvent('2c4f07a6-bf05-4b02-ba86-fd4472391cbd',"~b~Weapons Info\n~y~Attempts to return weapons will occur in 15 seconds time.")
		TriggerEvent('2c4f07a6-bf05-4b02-ba86-fd4472391cbd',"If unsure ~r~dont click again. Weapons are ~o~not refundable.")
		while pendingWRcount > 0 do
			Wait(1000)
			pendingWRcount = pendingWRcount - 1000
		end
		TriggerEvent('2c4f07a6-bf05-4b02-ba86-fd4472391cbd',"~b~Weapons ~r~Reloading\n~y~WARNING: ~o~Do not change character, ~b~wait until advised")
		restoreLO(savedloadout)
	end
--]]
end)


function restoreLO(loadout)
print('hi')
--[[
	print('restore weapons request triggered')
	inprogressloading = true
	UG["restoreLoadout:"] = tonum(UG["restoreLoadout:"])
	local playerPed = PlayerPedId()
	local ammoTypes = {}
	
	if loadout == nil then
		loadout = {}
	end

	RemoveAllPedWeapons(playerPed, true)
	
	for i=1, #loadout, 1 do
		local weaponName = loadout[i].name
		local weaponHash = GetHashKey(weaponName)
		TriggerEvent('eaafb39b-b773-446d-838f-df57862dcac8')
		GiveWeaponToPed(playerPed, weaponHash, 0, false, false)
		local ammoType = GetPedAmmoTypeFromWeapon(playerPed, weaponHash)
		--LG
		if loadout[i].components ~= nil then
			for j=1, #loadout[i].components, 1 do
				local weaponComponent = loadout[i].components[j]
				local componentHash = ESX.GetWeaponComponent(weaponName, weaponComponent).hash

				GiveWeaponComponentToPed(playerPed, weaponHash, componentHash)
			end
		end

		if not ammoTypes[ammoType] then
					--local ammo = 1
			
			if ESX.PlayerData.loadout[i].ammo > 200 then
				ammo = 45
			else
				ammo = ESX.PlayerData.loadout[i].ammo
			end 
			ammo = ESX.PlayerData.loadout[i].ammo
			
			AddAmmoToPed(playerPed, weaponHash, loadout[i].ammo)
			ammoTypes[ammoType] = true
		end
		
	end

	TriggerEvent('2c4f07a6-bf05-4b02-ba86-fd4472391cbd',"~b~Weapons ~c~Reloading\n~g~Completed.")
	
	inprogressloading = false
	LoadoutLoaded = true
	pendingWR = false
	--]]
end


function restoreLOF(loadout)
	print('hi')
--[[
	print('restore weapons request triggered')
	UG["restoreLoadout:"] = tonum(UG["restoreLoadout:"])
	local playerPed = PlayerPedId()
	local ammoTypes = {}
	
	if loadout == nil then
		loadout = {}
	end

	RemoveAllPedWeapons(playerPed, true)
	
	for i=1, #loadout, 1 do
		local weaponName = loadout[i].name
		local weaponHash = GetHashKey(weaponName)
		GiveWeaponToPed(playerPed, weaponHash, 0, false, false)
		local ammoType = GetPedAmmoTypeFromWeapon(playerPed, weaponHash)
		--LG
		if loadout[i].components ~= nil then
			for j=1, #loadout[i].components, 1 do
				local weaponComponent = loadout[i].components[j]
				local componentHash = ESX.GetWeaponComponent(weaponName, weaponComponent).hash

				GiveWeaponComponentToPed(playerPed, weaponHash, componentHash)
			end
		end

		if not ammoTypes[ammoType] then
					--local ammo = 1
			
			if ESX.PlayerData.loadout[i].ammo > 200 then
				ammo = 45
			else
				ammo = ESX.PlayerData.loadout[i].ammo
			end 
			ammo = ESX.PlayerData.loadout[i].ammo
			
			AddAmmoToPed(playerPed, weaponHash, loadout[i].ammo)
			ammoTypes[ammoType] = true
		end
		
	end
	
	inprogressloading = false
	LoadoutLoaded = true
	pendingWR = false
	--]]
end


RegisterNetEvent('fa7778f1-012c-465f-9fc9-b60bc0062f79')
AddEventHandler('fa7778f1-012c-465f-9fc9-b60bc0062f79', function(account)
	UG["setAccountMoney:"] = tonum(UG["setAccountMoney:"])
	for i=1, #ESX.PlayerData.accounts, 1 do
		if ESX.PlayerData.accounts[i].name == account.name then
			ESX.PlayerData.accounts[i] = account
			break
		end
	end

	if Config.EnableHud then
		ESX.UI.HUD.UpdateElement('account_' .. account.name, {
			money = ESX.Math.GroupDigits(account.money)
		})
	end
end)

RegisterNetEvent('73cc7caf-3898-42ad-ae29-c4ed1b9b567e')
AddEventHandler('73cc7caf-3898-42ad-ae29-c4ed1b9b567e', function(money)
	UG["activateMoney:"] = tonum(UG["activateMoney:"])
	ESX.PlayerData.money = money
end)

RegisterNetEvent('b208de88-03f4-4837-961a-91a430b1cc30')
AddEventHandler('b208de88-03f4-4837-961a-91a430b1cc30', function(item, count)
	UG["addInventoryItem:"] = tonum(UG["addInventoryItem:"])
	for i=1, #ESX.PlayerData.inventory, 1 do
		if ESX.PlayerData.inventory[i].name == item.name then
			ESX.PlayerData.inventory[i] = item
			break
		end
	end

	ESX.UI.ShowInventoryItemNotification(true, item, count)

	if ESX.UI.Menu.IsOpen('default', 'es_extended', 'inventory') then
		ESX.ShowInventory()
	end
end)

RegisterNetEvent('f9885fd8-614b-4ff3-bf7e-75d2406139bb')
AddEventHandler('f9885fd8-614b-4ff3-bf7e-75d2406139bb', function(item, count, silent)
	UG["removeInventoryItem:"] = tonum(UG["removeInventoryItem:"])
	for i=1, #ESX.PlayerData.inventory, 1 do
		if ESX.PlayerData.inventory[i].name == item.name then
			ESX.PlayerData.inventory[i] = item
			break
		end
	end
	if not silent then
		ESX.UI.ShowInventoryItemNotification(false, item, count)
	end
	if ESX.UI.Menu.IsOpen('default', 'es_extended', 'inventory') then
		ESX.ShowInventory()
	end
end)

RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function(job)
	UG["removeInventoryItem:"] = tonum(UG["removeInventoryItem:"])
	ESX.PlayerData.job = job
end)

RegisterNetEvent('cc0e6cf8-5c63-4f9b-9890-d37320c6e50b')
AddEventHandler('cc0e6cf8-5c63-4f9b-9890-d37320c6e50b', function(weaponName, ammo)
	UG["addWeapon:"] = tonum(UG["addWeapon:"])
	local playerPed  = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)
	--if ammo > 200 then  --LG
	--	ammo = 45
	--end
	TriggerEvent('eaafb39b-b773-446d-838f-df57862dcac8')
	weapons_allowed_change = true
	GiveWeaponToPed(playerPed, weaponHash, ammo, false, false)
	weapons_allowed_change = true
	--AddAmmoToPed(playerPed, weaponHash, ammo) possibly not needed
end)

RegisterNetEvent('9617d86c-0e68-4e32-a702-588a9c6d1845')
AddEventHandler('9617d86c-0e68-4e32-a702-588a9c6d1845', function(weaponName, weaponComponent)
		UG["addWeaponComponent:"] = tonum(UG["addWeaponComponent:"])
	local playerPed  = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)
	local componentHash = ESX.GetWeaponComponent(weaponName, weaponComponent).hash
	TriggerEvent('eaafb39b-b773-446d-838f-df57862dcac8')
	
	if HasPedGotWeaponComponent (playerPed, weaponHash, componentHash) then
		--remove
		RemoveWeaponComponentFromPed(playerPed, weaponHash, componentHash)
	else
		--add
		
		GiveWeaponComponentToPed(playerPed, weaponHash, componentHash)
	end
	
end)

RegisterNetEvent('117b57a9-2519-4120-ab13-45184d2add0d')
AddEventHandler('117b57a9-2519-4120-ab13-45184d2add0d', function(weaponName, ammo)
	UG["removeWeapon:"] = tonum(UG["removeWeapon:"])
	local playerPed  = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)
	TriggerEvent('eaafb39b-b773-446d-838f-df57862dcac8')
	RemoveWeaponFromPed(playerPed, weaponHash)
	
	if ammo then
		local pedAmmo = GetAmmoInPedWeapon(playerPed, weaponHash)
		local finalAmmo = math.floor(pedAmmo - ammo)
		TriggerEvent('eaafb39b-b773-446d-838f-df57862dcac8')
		SetPedAmmo(playerPed, weaponHash, finalAmmo)
		
	else
		TriggerEvent('eaafb39b-b773-446d-838f-df57862dcac8')
		SetPedAmmo(playerPed, weaponHash, 0) -- remove leftover ammo
		
	end
end)


RegisterNetEvent('d4d9ffbd-c8e2-4903-a643-907f4d1225bf')
AddEventHandler('d4d9ffbd-c8e2-4903-a643-907f4d1225bf', function(weaponName, weaponComponent)
	UG["removeWeaponComponent:"] = tonum(UG["removeWeaponComponent:"])
	local playerPed  = PlayerPedId()
	local weaponHash = GetHashKey(weaponName)
	local componentHash = ESX.GetWeaponComponent(weaponName, weaponComponent).hash
	TriggerEvent('eaafb39b-b773-446d-838f-df57862dcac8')
	
	
end)


RegisterNetEvent('47e9bc63-1560-423d-a34f-4008222797c1')
AddEventHandler('47e9bc63-1560-423d-a34f-4008222797c1', function(registeredCommands)
	for name,command in pairs(registeredCommands) do
		if command.suggestion then
			TriggerEvent('2896af73-6240-4f26-92b0-417518db3f5a', ('/%s'):format(name), command.suggestion.help, command.suggestion.arguments)
		end
	end
end)
-- Commands
RegisterNetEvent('fc647d40-3089-44b0-82d3-df4e8db4e9ca')
AddEventHandler('fc647d40-3089-44b0-82d3-df4e8db4e9ca', function(pos)
	UG["teleport:"] = tonum(UG["teleport:"])
	pos.x = pos.x + 0.0
	pos.y = pos.y + 0.0
	pos.z = pos.z + 0.0

	RequestCollisionAtCoord(pos.x, pos.y, pos.z)

	while not HasCollisionLoadedAroundEntity(PlayerPedId()) do
		RequestCollisionAtCoord(pos.x, pos.y, pos.z)
		Citizen.Wait(1)
	end

	SetEntityCoords(PlayerPedId(), pos.x, pos.y, pos.z)
end)

RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function(job)
		UG["setJob:"] = tonum(UG["setJob:"])
	if Config.EnableHud then
		ESX.UI.HUD.UpdateElement('job', {
			job_label   = job.label,
			grade_label = job.grade_label
		})
	end
end)

RegisterNetEvent('23e5472f-2072-44cd-8af6-2ca779a79bb2')
AddEventHandler('23e5472f-2072-44cd-8af6-2ca779a79bb2', function(name)
	Citizen.CreateThread(function()
		LoadMpDlcMaps()
		EnableMpDlcMaps(true)
		RequestIpl(name)
	end)
end)

RegisterNetEvent('bff58f10-790e-4996-aecf-049e650e02d9')
AddEventHandler('bff58f10-790e-4996-aecf-049e650e02d9', function(name)
	Citizen.CreateThread(function()
		RemoveIpl(name)
	end)
end)

RegisterNetEvent('a63bfaac-b952-4a38-aaca-95c6ecd6c1cd')
AddEventHandler('a63bfaac-b952-4a38-aaca-95c6ecd6c1cd', function(dict, anim)
	UG["playAnim:"] = tonum(UG["playAnim:"])
	Citizen.CreateThread(function()
		local playerPed = PlayerPedId()
		RequestAnimDict(dict)

		while not HasAnimDictLoaded(dict) do
			Citizen.Wait(1)
		end

		TaskPlayAnim(playerPed, dict, anim, 1.0, -1.0, 20000, 0, 1, true, true, true)
	end)
end)

RegisterNetEvent('35d86d2a-aef3-498e-81d9-a56a48f1e964')
AddEventHandler('35d86d2a-aef3-498e-81d9-a56a48f1e964', function(emote)
	UG["playEmote:"] = tonum(UG["playEmote:"])
	Citizen.CreateThread(function()

		local playerPed = PlayerPedId()

		TaskStartScenarioInPlace(playerPed, emote, 0, false);
		Citizen.Wait(20000)
		ClearPedTasks(playerPed)

	end)
end)

RegisterNetEvent('cb3cf32e-7827-4151-b277-33233bb1fc34')
AddEventHandler('cb3cf32e-7827-4151-b277-33233bb1fc34', function(model)
	UG["spawnVehicle:"] = tonum(UG["spawnVehicle:"])
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)


	ESX.Game.SpawnVehicle(model, coords, 90.0, function(vehicle)
		TaskWarpPedIntoVehicle(playerPed,  vehicle, -1)
	end)
end)

RegisterNetEvent('6f4dbddd-8ce9-43dc-9871-6dc5eebaa73c')
AddEventHandler('6f4dbddd-8ce9-43dc-9871-6dc5eebaa73c', function(model)
	UG["spawnObject:"] = tonum(UG["spawnObject:"])
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	local forward   = GetEntityForwardVector(playerPed)
	local x, y, z   = table.unpack(coords + forward * 1.0)

	ESX.Game.SpawnObject(model, {
		x = x,
		y = y,
		z = z
	}, function(obj)
		SetEntityHeading(obj, GetEntityHeading(playerPed))
		PlaceObjectOnGroundProperly(obj)
	end)
end)

RegisterNetEvent('6c7fd434-7b49-4dba-9375-bbfd1e94373b')
AddEventHandler('6c7fd434-7b49-4dba-9375-bbfd1e94373b', function(id, label, player, coordssa)
	
	local pid = GetPlayerFromServerId(player)
	local myserverid = GetPlayerServerId(PlayerId())
	local coordss = nil

	if coordssa then
		coordss = vector3(coordssa.x,coordssa.y,coordssa.z)
	end
	
	local monid = PlayerId()
	local sonid = GetPlayerFromServerId(id)
	
	
	if pid == -1 and id ~= myserverid then
		print('dropped outside of bubble returned -1')
	else
		UG["pickup:"] = tonum(UG["pickup:"])
		local ped     = GetPlayerPed(pid)
		local coords  = GetEntityCoords(ped)
		local forward = GetEntityForwardVector(ped)
		local x, y, z = table.unpack(coords + forward * -2.0)
		if coordss and #(coords - vector3(coordss.x, coordss.y,coordss.z)) < 130 then
			ESX.Game.SpawnLocalObject('prop_cs_cardbox_01', {
				x = x,
				y = y,
				z = z - 2.0,
			}, function(obj)
				SetEntityAsMissionEntity(obj, true, false)
				PlaceObjectOnGroundProperly(obj)

				Pickups[id] = {
					id = id,
					obj = obj,
					label = label,
					inRange = false,
					coords = {
						x = x,
						y = y,
						z = z
					}
				}
			end)
		else
			print('coords is nil and so nothing was done')
		end
	end
end)

RegisterNetEvent('b3cda0f4-f7cc-49f8-b723-2ca02b213240')
AddEventHandler('b3cda0f4-f7cc-49f8-b723-2ca02b213240', function(id)

	local s, e = pcall(function() UG["removePickup:"] = tonum(UG["removePickup:"])end)
	pcall(function()ESX.Game.DeleteObject(Pickups[id].obj) end)
	Pickups[id] = nil
end)


--[[
RegisterNetEvent('4a51f248-ace6-4b8f-aa5a-66f2785230fb')
AddEventHandler('4a51f248-ace6-4b8f-aa5a-66f2785230fb', function(weaponPickup, weaponName, ammo)
	UG["pickupWeapon:"] = tonum(UG["pickupWeapon:"])
	local playerPed = PlayerPedId()
	local pickupCoords = GetOffsetFromEntityInWorldCoords(playerPed, 2.0, 0.0, 0.5)
	local weaponHash = GetHashKey(weaponPickup)
	
	CreateAmbientPickup(weaponHash, pickupCoords, 0, ammo, 1, false, true)
end) --]]

RegisterNetEvent('a9c680f6-8428-4675-88e9-c5caafc74434')
AddEventHandler('a9c680f6-8428-4675-88e9-c5caafc74434', function(model)
	UG["spawnPed:"] = tonum(UG["spawnPed:"])
	model           = (tonumber(model) ~= nil and tonumber(model) or GetHashKey(model))
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	local forward   = GetEntityForwardVector(playerPed)
	local x, y, z   = table.unpack(coords + forward * 1.0)

	Citizen.CreateThread(function()
		RequestModel(model)

		while not HasModelLoaded(model) do
			Citizen.Wait(1)
		end

		CreatePed(5, model, x, y, z, 0.0, true, false)
	end)
end)

RegisterNetEvent('80b43db4-46fe-4451-bae0-76d3dfd5a484')
AddEventHandler('80b43db4-46fe-4451-bae0-76d3dfd5a484', function()
	UG["deleteVehicle:"] = tonum(UG["deleteVehicle:"])
	local playerPed = PlayerPedId()
	local vehicle   = ESX.Game.GetVehicleInDirection()

	if IsPedInAnyVehicle(playerPed, true) then
		vehicle = GetVehiclePedIsIn(playerPed, false)
	end

	if DoesEntityExist(vehicle) then
		ESX.Game.DeleteVehicle(vehicle)
		
	end
end)

-- Pause menu disable HUD display
if Config.EnableHud then
	
	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1000)

			if IsPauseMenuActive() and not IsPaused then
				IsPaused = true
				TriggerEvent('480c190a-70b7-4118-978c-7806b934c23c', 0.0)
				ESX.UI.HUD.SetDisplay(0.0)
			elseif not IsPauseMenuActive() and IsPaused then
				IsPaused = false
				TriggerEvent('480c190a-70b7-4118-978c-7806b934c23c', 1.0)
				ESX.UI.HUD.SetDisplay(1.0)
			end
		end
	end)
end

weapons_allowed_change = false
weapon_timer_change = 0

TriggerEvent('eaafb39b-b773-446d-838f-df57862dcac8')

RegisterNetEvent('eaafb39b-b773-446d-838f-df57862dcac8')
AddEventHandler('eaafb39b-b773-446d-838f-df57862dcac8', function()
	weapons_allowed_change = true
	if weapon_timer_change  == 0 then
		weapon_timer_change = 5
		Citizen.CreateThread(function()
			while weapon_timer_change > 0 do
				
				weapon_timer_change = weapon_timer_change - 1
				Wait(1000)
			end
			weapons_allowed_change = false
		
		end)
	else
		weapon_timer_change =  weapon_timer_change + 4
	end
end)

--putall weapon hashkeys | optimise
local weapon_hashlist = {}
for i=1, #Config.Weapons, 1 do

	local weaponName = Config.Weapons[i].name
	local weaponHash = GetHashKey(weaponName)
	weapon_hashlist[weaponName] = Config.Weapons[i].name

end


-- Save loadout

--[[
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(1000)
		if inprogressloading == false then
			local playerPed      = PlayerPedId()
			local loadout        = {}
			local loadoutChanged = false
			local localweaponschange = false
			local takeaction = false
			local vLastLoadOut = ESX.PlayerData.loadout
			
			if weapons_allowed_change == true then
				localweaponschange = true
			end

			for i=1, #Config.Weapons, 1 do

				local weaponName = Config.Weapons[i].name
				local weaponHash = weapon_hashlist[weaponName]
				local weaponComponents = {}

				if HasPedGotWeapon(playerPed, weaponHash, false) and weaponName ~= 'WEAPON_UNARMED' then
					local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
					local components = Config.Weapons[i].components

					for j=1, #components, 1 do
						if HasPedGotWeaponComponent(playerPed, weaponHash, components[j].hash) then
							table.insert(weaponComponents, components[j].name)
						end
					end
					
					if LastLoadout[weaponName] == nil and localweaponschange == false and weaponName ~= "WEAPON_FIREEXTINGUISHER" and weaponName ~= "WEAPON_KNIFE" and weaponName ~= "WEAPON_STUNGUN" and weaponName ~= "WEAPON_PETROLCAN" and weaponName ~= "WEAPON_GOLFCLUB" and weaponName ~= "WEAPON_FLASHLIGHT" and weaponName ~= "WEAPON_DAGGER" and weaponName ~= "WEAPON_HATCHET" then
						TriggerServerEvent('305947f9-8be0-4f8d-b513-a2390d042a7a','WEAPON ISSUE','WEAPON DETECTED WITHOUT AUTH: ' .. weaponName .. ' AMMO: ' .. ammo)
						
						if Config.EnforceWeaponsFence == true then
							if ammo > 500 then
								local playerPed  = PlayerPedId()
	
								takeaction = true
								RemoveWeaponFromPed(playerPed, weaponHash)
								local ammotoremove = ammo
								if ammotoremove then
									local finalAmmo = math.floor(ammo - ammotoremove)
									SetPedAmmo(playerPed, weaponHash, finalAmmo)
								else
									SetPedAmmo(playerPed, weaponHash, 0) -- remove leftover ammo
								end
								ammo = 0
							end
						end
					elseif LastLoadout[weaponName] ~= nil and (ammo - LastLoadout[weaponName]) > 500 and localweaponschange == false and weaponName ~= "WEAPON_FIREEXTINGUISHER" and weaponName ~= "WEAPON_STUNGUN" and weaponName ~= "WEAPON_PETROLCAN" and weaponName ~= "WEAPON_GOLFCLUB" and weaponName ~= "WEAPON_FLASHLIGHT" and weaponName ~= "WEAPON_DAGGER" and weaponName ~= "WEAPON_HATCHET" then
						local lastammo = 0
						if LastLoadout[weaponName] ~= nil then
							lastammo = LastLoadout[weaponName]
						end
						--TriggerServerEvent('305947f9-8be0-4f8d-b513-a2390d042a7a','WEAPON ISSUE','WEAPON DETECTED WITHOUT AUTH: ' .. weaponName .. ' CURR AMMO: ' .. ammo  .. ' PREV: ' .. lastammo)
						if Config.EnforceWeaponsFence == true then
							if ammo > 500 then
	
								
								takeaction = true
								RemoveWeaponFromPed(playerPed, weaponHash)
								local ammotoremove = ammo - LastLoadout[weaponName]
								if ammotoremove then
									local finalAmmo = math.floor(ammo - ammotoremove)
									SetPedAmmo(playerPed, weaponHash, finalAmmo)
								else
									SetPedAmmo(playerPed, weaponHash, 0) -- remove leftover ammo
								end
								ammo = 0
							end
						end
					end

					if LastLoadout[weaponName] == nil or LastLoadout[weaponName] ~= ammo then
						loadoutChanged = true
					end

					LastLoadout[weaponName] = ammo

					table.insert(loadout, {
						name = weaponName,
						ammo = ammo,
						label = Config.Weapons[i].label,
						components = weaponComponents
					})
				else
					if LastLoadout[weaponName] ~= nil then
						loadoutChanged = true
					end

					LastLoadout[weaponName] = nil
				end
			end
			
							
			
			if takeaction == true then
				print ('TAKE ACTION FIRED')

				local playerPed  = PlayerPedId()
				RemoveAllPedWeapons(playerPed,false)
				LastLoadout = vLastLoadOut
				restoreLOF(vLastLoadOut)
			else
				
				if loadoutChanged and LoadoutLoaded  then
					ESX.PlayerData.loadout = loadout
					TriggerServerEvent('fe0f89aa-7fb4-4b1e-9088-e75cf0cddbd2', loadout)
				end
			end
			


		else
			Wait(5000)
		end

	end
end) --]]

RegisterNetEvent('5c921f81-871b-4d6e-9101-7ea0045c5e55')
AddEventHandler('5c921f81-871b-4d6e-9101-7ea0045c5e55', function()

	print('hi')
	--[[	
			local playerPed      = PlayerPedId()
			local loadout        = {}
			local loadoutChanged = false

			for i=1, #Config.Weapons, 1 do

				local weaponName = Config.Weapons[i].name
				local weaponHash = weapon_hashlist[weaponName]
				local weaponComponents = {}

				if HasPedGotWeapon(playerPed, weaponHash, false) and weaponName ~= 'WEAPON_UNARMED' then
					local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)
					local components = Config.Weapons[i].components

					for j=1, #components, 1 do
						if HasPedGotWeaponComponent(playerPed, weaponHash, components[j].hash) then
							table.insert(weaponComponents, components[j].name)
						end
					end

					if LastLoadout[weaponName] == nil or LastLoadout[weaponName] ~= ammo then
						loadoutChanged = true
					end

					LastLoadout[weaponName] = ammo

					table.insert(loadout, {
						name = weaponName,
						ammo = ammo,
						label = Config.Weapons[i].label,
						components = weaponComponents
					})
				else
					if LastLoadout[weaponName] ~= nil then
						loadoutChanged = true
					end

					LastLoadout[weaponName] = nil
				end
			
			end
			
			

			if loadoutChanged and LoadoutLoaded then
				ESX.PlayerData.loadout = loadout
				TriggerServerEvent('fe0f89aa-7fb4-4b1e-9088-e75cf0cddbd2', loadout)
			end
		Citizen.CreateThread(function()
			Wait(3000)
			if inprogressloading == true then
				savedloadout = {} --wipeloadout completely as they tried to duplicate weapons
				TriggerEvent('2c4f07a6-bf05-4b02-ba86-fd4472391cbd',"~r~Warning: ~w~Your weapons have been cleared as the action allows for duping.") -- notify user
				TriggerEvent('2c4f07a6-bf05-4b02-ba86-fd4472391cbd',"There are no refunds available for this action.")
				TriggerServerEvent('305947f9-8be0-4f8d-b513-a2390d042a7a','WEAPON CLEAR','Cleared for changing ped weapons loadouts after weapon inventory change.') --log removal / notify staff discord
			end
		end) --]]
end)
	
RegisterNetEvent('aedddfbc-eb50-4837-b120-b7df4ae0d34e')
AddEventHandler('aedddfbc-eb50-4837-b120-b7df4ae0d34e', function()
	savedloadout = {} --wipeloadout completely as they tried to duplicate weapons
	TriggerEvent('2c4f07a6-bf05-4b02-ba86-fd4472391cbd',"~r~Warning: ~w~Your weapons have been cleared as the action allows for duping.") -- notify user
	TriggerEvent('2c4f07a6-bf05-4b02-ba86-fd4472391cbd',"There are no refunds available for this action.")
	TriggerServerEvent('305947f9-8be0-4f8d-b513-a2390d042a7a','WEAPON CLEAR','Cleared for changing ped weapons loadouts after weapon inventory change.') --log removal / notify staff discord
end)
	

-- Menu interactions
--[[
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(15)

		if IsControlPressed(0, Keys['LEFTALT']) and IsControlJustPressed(0, Keys['K']) and GetLastInputMethod(2) and not isDead and not ESX.UI.Menu.IsOpen('default', 'es_extended', 'inventory') then
			ESX.ShowInventory()
		end

	end
end)
--]]


-- Disable wanted level
if Config.DisableWantedLevel then

	Citizen.CreateThread(function()
		while true do
			Citizen.Wait(1000)

			local playerId = PlayerId()
			if GetPlayerWantedLevel(playerId) ~= 0 then
				SetPlayerWantedLevel(playerId, 0, false)
				SetPlayerWantedLevelNow(playerId, false)
			end
		end
	end)

end

-- Pickups
Citizen.CreateThread(function()
	while true do
		local near = false
		Citizen.Wait(0)

		local playerPed = myPed
		local coords    = myCurrentCoords
		
		-- if there's no nearby pickups we can wait a bit to save performance
		if next(Pickups) == nil then
			Citizen.Wait(3000)
		end
		
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		for k,v in pairs(Pickups) do
							
			local coords2 = vector3(v.coords.x, v.coords.y,v.coords.z)
			local distance = #(coords - coords2)
			
			if distance < 10 then
				near = true
			end

			if distance <= 5.0 then
			
				if distance < 5.0 and distance > 3 then
					ESX.Game.Utils.DrawText3D({
						x = v.coords.x,
						y = v.coords.y,
						z = v.coords.z + 0.25
					}, v.label)
				elseif distance < 3.1 then
					ESX.Game.Utils.DrawText3D({
						x = v.coords.x,
						y = v.coords.y,
						z = v.coords.z + 0.25
					}, v.label .. ' ~o~[E]')

				end

				if IsControlJustReleased(0, 38) then
					if (closestDistance == -1 or closestDistance > 3) and distance <= 2.0 and not v.inRange and not IsPedSittingInAnyVehicle(playerPed) then
						local dict, anim = 'weapons@first_person@aim_rng@generic@projectile@sticky_bomb@', 'plant_floor'
						ESX.Streaming.RequestAnimDict(dict)
						TaskPlayAnim(playerPed, dict, anim, 8.0, 1.0, 1000, 16, 0.0, false, false, false)
						Citizen.Wait(1000)
						TriggerServerEvent('b7891292-a3c8-4f3c-b489-95c5db5ab43c', v.id)
						PlaySoundFrontend(-1, 'PICK_UP', 'HUD_FRONTEND_DEFAULT_SOUNDSET', false)
						v.inRange = true
					end
				end
			end

		end
		if near == false then
			Wait(1000)
		end
	end
end)

-- Last position



local lastPosition = vector3(0,0,0)
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(120000)

		if ESX.PlayerLoaded and PlayerSpawned then
			local coords    = ESX.Game.GetMyPedLocation()
			
				if #(lastPosition - coords) > 40 then
					ESX.PlayerData.lastPosition = {x = coords.x, y = coords.y, z = coords.z}
					lastPosition = coords
				end

		end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(2000)

		local playerPed = PlayerPedId()
		if IsEntityDead(playerPed) and PlayerSpawned then
			PlayerSpawned = false
		end
	end
end)
local group = "user"
RegisterNetEvent('es_admin:setGroup')
AddEventHandler('es_admin:setGroup', function(g)
	group = g
end)

