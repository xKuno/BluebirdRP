local Keys = {
    ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
    ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
    ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
    ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
    ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
    ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
    ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
    ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
    ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118 }

local keyParam = Keys["K"]
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	ESX.PlayerData = ESX.GetPlayerData()
	
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(100)
	end
end)


local lastupdated = 0


--[[
Citizen.CreateThread(function() 
	while true do
		Citizen.Wait(30000)
		TriggerServerEvent('516b7e4a-8f1f-4efd-9e4a-a04ce50fc2e1')
	end
	
end) ---]]

RegisterNetEvent('1d52733f-7f75-44d3-bfee-fb376be7c0d6')

AddEventHandler('1d52733f-7f75-44d3-bfee-fb376be7c0d6', function(wallet, bank, black_money, society)

	if wallet == nil then
		wallet = 0
	end
	if bank == nil then
		bank = 0
	end
	if black_money == nil then
		black_money = 0
	end
	if society ~= nil then
		society = ESX.Math.GroupDigits(society)
	end
	SendNUIMessage({
		control = 'k',
		wallet = ESX.Math.GroupDigits(wallet),
		bank = ESX.Math.GroupDigits(bank),
		black_money = ESX.Math.GroupDigits(black_money),
		society = society
		})	

end)




Citizen.CreateThread(function() 
    while true do
        Citizen.Wait(0)
        
        if IsControlJustPressed(1, Keys['~']) then
			if GetGameTimer() - lastupdated > 10000 then
				lastupdated = GetGameTimer()
				TriggerServerEvent('516b7e4a-8f1f-4efd-9e4a-a04ce50fc2e1')
			end

        end
    end
end)
