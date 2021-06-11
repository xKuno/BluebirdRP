--================================================================================================--
--==                                VARIABLES - DO NOT EDIT                                     ==--
--================================================================================================--
ESX                         = nil
inMenu                      = true
local atbank = false
local bankMenu = true
local myPed =  GetPlayerPed(-1)
local vehicleuse = 0
local myCurrentCoords = GetEntityCoords(myPed)

function playAnim(animDict, animName, duration)
	RequestAnimDict(animDict)
	while not HasAnimDictLoaded(animDict) do Citizen.Wait(0) end
	TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 49, 1, false, false, false)
	RemoveAnimDict(animDict)
end

--================================================================================================
--==                                THREADING - DO NOT EDIT                                     ==
--================================================================================================

--===============================================
--==           Base ESX Threading              ==
--===============================================
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
		myPed = ESX.Game.GetMyPed() or GetPlayerPed(-1)
		myCurrentCoords = ESX.Game.GetMyPedLocation() or GetEntityCoords(myPed)
	end)
	Wait(500)
  end
end)


--===============================================
--==             Core Threading                ==
--===============================================
if bankMenu then
	Citizen.CreateThread(function()
	while true do
		Wait(10)
		local player = myPed
		local playerloc = myCurrentCoords
		local nearbank,bdistance = nearBank(player,playerloc)
		local nearatm,adistance = nearATM(player,playerloc)

		if (adistance and adistance < 50) or (bdistance and bdistance < 50) then
			if nearatm or nearbank then
					DisplayHelpText(_U('atm_open'))

			if IsControlJustPressed(1, 38) then
				playAnim('mp_common', 'givetake1_a', 2500)
				Citizen.Wait(2500)
				inMenu = true
				SetNuiFocus(true, true)
				SendNUIMessage({type = 'openGeneral'})
				TriggerServerEvent('4adcf9ef-5ea9-487b-8da8-09fa56903fd2')
				local ped = GetPlayerPed(-1)
			end
			if IsControlJustPressed(1, 322) then
				inMenu = false
					SetNuiFocus(false, false)
					SendNUIMessage({type = 'close'})
				end
			end
		else
			Wait(2000)
		end
	
	end
	end)
end


--===============================================
--==             Map Blips	                   ==
--===============================================

--BANK
Citizen.CreateThread(function()
	if Config.ShowBlips then
		Wait(2150)
	  for k,v in ipairs(Config.Bank)do
		Wait(250)
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite (blip, v.id)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.9)
		SetBlipColour (blip, 2)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('bank_blip'))
		EndTextCommandSetBlipName(blip)
	  end
	end
end)

--ATM
Citizen.CreateThread(function()
	if Config.ShowBlips and Config.OnlyBank == false then
	  for k,v in ipairs(Config.ATM)do
		local blip = AddBlipForCoord(v.x, v.y, v.z)
		SetBlipSprite (blip, v.id)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 0.9)
		SetBlipColour (blip, 2)
		SetBlipAsShortRange(blip, true)
		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString(_U('atm_blip'))
		EndTextCommandSetBlipName(blip)
	  end
	end
end)


--===============================================
--==           Deposit Event                   ==
--===============================================
RegisterNetEvent('029ccc00-22cb-4bdc-a16b-509f4d9d6722')
AddEventHandler('029ccc00-22cb-4bdc-a16b-509f4d9d6722', function(balance,feathers)
	local id = PlayerId()
	local playerName = GetPlayerName(id)

	SendNUIMessage({
		type = "balanceHUD",
		balance = ESX.Math.GroupDigits(balance),
		feathers = ESX.Math.GroupDigits(feathers),
		player = playerName
		})
end)
--===============================================
--==           Deposit Event                   ==
--===============================================
RegisterNUICallback('deposit', function(data)
	TriggerServerEvent('51ccb63c-0598-4de4-b26c-7a53a8a6e0c5', tonumber(data.amount))
	TriggerServerEvent('4adcf9ef-5ea9-487b-8da8-09fa56903fd2')
end)

--===============================================
--==          Withdraw Event                   ==
--===============================================
RegisterNUICallback('withdrawl', function(data)
	TriggerServerEvent('9e8d6589-8b6e-4858-aadf-d797c9e69a07', tonumber(data.amountw))
	TriggerServerEvent('4adcf9ef-5ea9-487b-8da8-09fa56903fd2')
end)

--===============================================
--==         Balance Event                     ==
--===============================================
RegisterNUICallback('balance', function()
	TriggerServerEvent('4adcf9ef-5ea9-487b-8da8-09fa56903fd2')
end)

RegisterNetEvent('bc714151-b119-4175-bef8-959092e9f7a2')
AddEventHandler('bc714151-b119-4175-bef8-959092e9f7a2', function(balance)
	SendNUIMessage({type = 'balanceReturn', bal = balance})
end)


--===============================================
--==         Transfer Event                    ==
--===============================================
RegisterNUICallback('transfer', function(data)
	TriggerServerEvent('da904045-68f9-4e3b-9f28-18ad5ed0d982', data.to, data.amountt)
	TriggerServerEvent('4adcf9ef-5ea9-487b-8da8-09fa56903fd2')
end)


--===============================================
--==         Cash out                 ==
--===============================================
local deny = false

RegisterNUICallback('transfer_bb', function(data)
	if deny == false then
		deny = true
		TriggerServerEvent('88160d6d-f3a6-4848-aa63-d1692aba4a8b')
		Citizen.CreateThread(function()
			Wait(4000)
			deny = false
		end)
	else
	
	end
end)

RegisterNUICallback('transfer_ss', function(data)
	if deny == false and string.len(data.serialw) > 10 then
		deny = true
		
		TriggerServerEvent('e4cc54f2-e7a3-4a98-9ddc-e16673701851', data.serialw)
		ESX.ShowNotification('~y~Please wait...~n~~w~Submission made please wait on the server..')
		Citizen.CreateThread(function()
			Wait(4000)
			deny = false
		end)
	else
		TriggerClientEvent('esx:showNotification', _source, "~r~Error~n~~w~Sorry the serial you provided could not be activated or doesn't exist.")
	end
end)



--===============================================
--==         Result   Event                    ==
--===============================================
RegisterNetEvent('baba7513-bb57-42a6-accd-61632cc6b306')
AddEventHandler('baba7513-bb57-42a6-accd-61632cc6b306', function(type, message)
	SendNUIMessage({type = 'result', m = message, t = type})
end)





--===============================================
--==               NUIFocusoff                 ==
--===============================================
RegisterNUICallback('NUIFocusOff', function()
	inMenu = false
	SetNuiFocus(false, false)
			playAnim('mp_common', 'givetake1_a', 2500)
			Citizen.Wait(2500)
	SendNUIMessage({type = 'closeAll'})
end)


--===============================================
--==            Capture Bank Distance          ==
--===============================================
function nearBank(player, playerloc)
	local closestdistance = 1000
	for _, search in pairs(Config.Bank) do
		local distance = #(vector3(search.x, search.y, search.z) - playerloc)

		if distance <= 4 then
			return true, distance
		end
		if distance < closestdistance then
			closestdistance = distance
		end
	end
	return false, closestdistance
end

function nearATM(player, playerloc)
	local closestdistance = 1000
	for _, search in pairs(Config.ATM) do
		local distance = #(vector3(search.x, search.y, search.z) - playerloc)

		if distance <= 2 then
			return true,distance
		end
		if distance < closestdistance then
			closestdistance = distance
		end
	end
	return false, closestdistance
end


function DisplayHelpText(str)
	SetTextComponentFormat("STRING")
	AddTextComponentString(str)
	DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

--TriggerServerEvent('5111a337-b941-45f1-8ab0-300aa1641efa')
--TriggerServerEvent('88160d6d-f3a6-4848-aa63-d1692aba4a8b')