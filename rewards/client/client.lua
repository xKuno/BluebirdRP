--================================================================================================
--==                                VARIABLES - DO NOT EDIT                                     ==
--================================================================================================
local notify = false

--================================================================================================
--==   vvvvvvvvvvvvvvvvvvvvvvvvvvv  EVENTS - DO NOT EDIT  vvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvvv     ==
--================================================================================================
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(xPlayer)
	TriggerServerEvent('48c78072-a540-4625-bb57-c6b39e5d27d0')
end)

RegisterNetEvent('e64cece6-137a-441e-bebf-56ecd96a7357')
AddEventHandler('e64cece6-137a-441e-bebf-56ecd96a7357', function(state)
	SetNuiFocus(state, state)
	SendNUIMessage({type = "toggleshow", enable = state})
end)

RegisterNetEvent('98ced110-1cb5-49db-be5a-ebf4ab4529fc')
AddEventHandler('98ced110-1cb5-49db-be5a-ebf4ab4529fc', function(t)
	SendNUIMessage({type = "settimeout", timeout = tonumber(t * 1000)})
end)

RegisterNetEvent('c1d4260e-1319-4d0e-8e2e-20f64f4f747c')
AddEventHandler('c1d4260e-1319-4d0e-8e2e-20f64f4f747c', function(wpn,ammo)
	local ped = GetPlayerPed(-1)
	wpn = GetHashKey(wpn)
	if HasPedGotWeapon(ped, wpn, false) then AddAmmoToPed(ped, wpn, ammo) else GiveWeaponToPed(ped, wpn, ammo, false, false) end
end)

RegisterNUICallback("hidemenu", function(data, cb)
	TriggerEvent('e64cece6-137a-441e-bebf-56ecd96a7357', false)
end)
local lastpressedt = 0

RegisterNUICallback("collect", function(data, cb)
	Wait(math.random(500,1000))
	if GetGameTimer() - 4000 > lastpressedt then
		lastpressedt = GetGameTimer()
		print('collect printing multi')
		TriggerServerEvent('7d93eaf4-8fe9-451f-b537-3cf8ece45592', data.t)
	end
end)

Citizen.CreateThread(function()
	TriggerServerEvent('48c78072-a540-4625-bb57-c6b39e5d27d0')
	while true do
		Citizen.Wait(600000)
		TriggerServerEvent('48c78072-a540-4625-bb57-c6b39e5d27d0') -- update timeout every 10 minutes because why not
	end
end)

if Config.Command then
TriggerEvent('2896af73-6240-4f26-92b0-417518db3f5a', '/daily', 'Open daily rewards menu',{})
end

--================================================================================================
--==    ^^^^^^^^^^^^^^^^^^^^^^^^^^  EVENTS - DO NOT EDIT   ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^       ==
--================================================================================================

--===============================================
--==             Open Reward ui                ==
--===============================================

local closer = false
local lastpressed = 0
Citizen.CreateThread(function(source, args, user)
if Config.rblip_enabled then
	  while true do
		  Wait(0)
		 if closer == true then
		 
			for k,v in ipairs(Config.mblip)do
				DrawMarker(v.id, v.x, v.y, v.z-0.7, 0, 0, 0, 0, 0, 0, 1.0001, 1.0001, 1.2001, 0, 0, 255, 100, 0, 0, 0, true)
			 end
			 if nearREW()then
				ShowNotification(('Press ~r~E ~w~to check Daily Rewards'))
				notify = true

				if IsControlJustPressed(1, 51) then
					if GetGameTimer() - 4000 > lastpressed then
						lastpressed = GetGameTimer()
						TriggerEvent('e64cece6-137a-441e-bebf-56ecd96a7357', source, true)
					end
				end
				
	
			end
			
			if IsControlJustPressed(1, 322) then
			inMenu = false
				SetNuiFocus(false, false)
				SendNUIMessage({type = 'close'})
			end
		else
			Wait(2000)
		end
	  end
	end
  end)

--===============================================
--==             Map Blips	                   ==
--===============================================

Citizen.CreateThread(function()
	if Config.rblip_enabled then
	  for k,v in ipairs(Config.rblip)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite (blip, v.id)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 1.0)
		SetBlipColour (blip, 38)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(('Daily Rewards'))
		EndTextCommandSetBlipName(blip)
	  end
	end
end)

Citizen.CreateThread(function()
if Config.rblip_enabled then
	while true do
     Citizen.Wait(300)
	 closer = false
	 for k,v in ipairs(Config.mblip)do
		local distance =  #(GetEntityCoords(GetPlayerPed(-1)) - vector3(v.x, v.y, v.z))
		  if distance <= 15 then
			 closer = true
		  end
	 end
	if closer == false then
		Wait(2000)
	end
   end
 end
end)

--===============================================
--==        Distance From Reward blip          ==
--===============================================

function nearREW()
	local player = GetPlayerPed(-1)
	local playerloc = GetEntityCoords(player, 0)

	for _, search in pairs(Config.rblip) do
		local distance = #(vector3(search.x, search.y, search.z) - playerloc)
        
		if distance <= 2.5 then
			return true

		end
	end
end

function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function ShowNotification(text)
    SetNotificationTextEntry("STRING")
	AddTextComponentString(text)
	DrawNotification(false, false)
end

  