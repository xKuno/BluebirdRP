ESX                           = nil
local PlayerData              = {}

local cped = GetPlayerPed(-1)
Citizen.CreateThread(function()

	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	
	PlayerData = ESX.GetPlayerData()

end)

math.randomseed(GetGameTimer())

RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function(job)
  PlayerData.job = job
end)

--Config
local timer = 1 --in minutes - Set the time during the player is outlaw
local showOutlaw = true --Set if show outlaw act on map
local gunshotAlert = true --Set if show alert when player use gun
local carJackingAlert = true --Set if show when player do carjacking
local meleeAlert = false --Set if show when player fight in melee
local blipGunTime = 30 --in second
local blipMeleeTime = 30 --in second
local blipJackingTime = 30 -- in second
local showcopsmisbehave = true  --show notification when cops steal too
local toggleevents = true

--End config

local timing = timer * 60000 --Don't touche it

GetPlayerName()
RegisterNetEvent('dc7bb8d5-afb9-41ef-958e-1c8525018602')
AddEventHandler('dc7bb8d5-afb9-41ef-958e-1c8525018602', function(alert)

		if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
			if toggleevents == true then
				Notify(alert)
			end
        end
end)


RegisterNetEvent('fb521f91-1581-4381-b65b-b095cb6b7ee0')
AddEventHandler('fb521f91-1581-4381-b65b-b095cb6b7ee0', function()
	meleeAlert = false
	gunshotAlert = false
end)

RegisterNetEvent('3eb4c0e1-bd91-45b0-a92a-87a5194844f0')
AddEventHandler('3eb4c0e1-bd91-45b0-a92a-87a5194844f0', function()
	meleeAlert = true
	gunshotAlert = true
end)

RegisterNetEvent('5c3375cd-5037-43e0-996d-1fcbe6b95657')
AddEventHandler('5c3375cd-5037-43e0-996d-1fcbe6b95657', function()
	meleeAlert = true
	gunshotAlert = true
end)

RegisterNetEvent('9dc54af2-b773-4f34-b368-f676f07db60c')
AddEventHandler('9dc54af2-b773-4f34-b368-f676f07db60c', function()
	meleeAlert = false
	gunshotAlert = false
end)

RegisterNetEvent('ac998105-792e-4d25-bc15-03efb93c8f2c')
AddEventHandler('ac998105-792e-4d25-bc15-03efb93c8f2c', function()
	meleeAlert = true
	gunshotAlert = true
end)

RegisterNetEvent('c1726048-2eaa-48cf-a19a-e5955b2c0592')
AddEventHandler('c1726048-2eaa-48cf-a19a-e5955b2c0592', function()
	meleeAlert = true
	gunshotAlert = true
end)






RegisterNetEvent('7a86f674-0043-4ac9-a4b5-750cdb944563')
AddEventHandler('7a86f674-0043-4ac9-a4b5-750cdb944563', function()
	print ("trigerred outlaw remote")

            if toggleevents == false then
				toggleevents = true
				Notify("Event Notifications on")
			else
				Notify("Event Notifications off")
				toggleevents = false
			end

end)


function Notify(text)
	
 			SetNotificationTextEntry('STRING')
			AddTextComponentString(text)
			DrawNotification(false, false)

end

Citizen.CreateThread(function()
    while true do
        Wait(10)
        if NetworkIsSessionStarted() then
            DecorRegister("IsOutlaw",  3)
            DecorSetInt(GetPlayerPed(-1), "IsOutlaw", 1)
            return
        end
    end
end)

RegisterNetEvent('8e00c0ec-7cb4-4785-8a18-88a8d6418263')
AddEventHandler('8e00c0ec-7cb4-4785-8a18-88a8d6418263', function(tx, ty, tz)
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' and toggleevents == true then
		if carJackingAlert then
			local transT = 250
			local thiefBlip = AddBlipForCoord(tx, ty, tz)
			SetBlipSprite(thiefBlip,  10)
			SetBlipColour(thiefBlip,  1)
			SetBlipAlpha(thiefBlip,  transT)
			SetBlipAsShortRange(thiefBlip,  1)
			while transT ~= 0 do
				Wait(blipJackingTime * 4)
				transT = transT - 1
				SetBlipAlpha(thiefBlip,  transT)
				if transT == 0 then
					SetBlipSprite(thiefBlip,  2)
					return
				end
			end
			
		end
	end
end)

RegisterNetEvent('4438265e-cc84-472f-a2cd-64d3af2a4be3')
AddEventHandler('4438265e-cc84-472f-a2cd-64d3af2a4be3', function(gx, gy, gz)
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' and toggleevents == true  then
		if gunshotAlert == true then

			local transG = 250
			local gunshotBlip = AddBlipForCoord(gx, gy, gz,10,10)
			SetBlipSprite(gunshotBlip,  10)
			SetBlipColour(gunshotBlip,  1)
			SetBlipRotation(gunshotBlip, 0)
			SetBlipAlpha(gunshotBlip,  transG)
			SetBlipAsShortRange(gunshotBlip,  1)
			SetBlipScale(gunshotBlip, 1.3)
			--SetBlipScale(gunshotBlip, 1.0)
			while transG ~= 0 do
				Wait(blipGunTime * 4)
				transG = transG - 1
				SetBlipAlpha(gunshotBlip,  transG)
				if transG == 0 then
					SetBlipSprite(gunshotBlip,  2)
					return
				end
			end
		   
		end
	end
end)

RegisterNetEvent('650b84bd-ecd0-4e52-9753-02a8d72e73a5')
AddEventHandler('650b84bd-ecd0-4e52-9753-02a8d72e73a5', function(mx, my, mz)
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' and toggleevents == true  then
		if meleeAlert then
			local transM = 250
			local meleeBlip = AddBlipForCoord(mx, my, mz)
			SetBlipSprite(meleeBlip,  1)
			SetBlipColour(meleeBlip,  17)
			SetBlipAlpha(meleeBlip,  transG)
			SetBlipAsShortRange(meleeBlip,  1)
			while transM ~= 0 do
				Wait(blipMeleeTime * 4)
				transM = transM - 1
				SetBlipAlpha(meleeBlip,  transM)
				if transM == 0 then
					SetBlipSprite(meleeBlip,  2)
					return
				end
			end
			
		end
	end
end)

--Star color
--[[1- White
2- Black
3- Grey
4- Clear grey
5-
6-
7- Clear orange
8-
9-
10-
11-
12- Clear blue]]

-- Citizen.CreateThread( function()
    -- while true do
        -- Wait(0)
        -- if showOutlaw then
            -- for i = 0, 31 do
				-- if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
					-- if DecorGetInt(GetPlayerPed(i), "IsOutlaw") == 2 and GetPlayerPed(i) ~= cped then
						-- gamerTagId = Citizen.InvokeNative(0xBFEFE3321A3F5015, GetPlayerPed(i), ".", false, false, "", 0 )
						-- Citizen.InvokeNative(0xCF228E2AA03099C3, gamerTagId, 0) --Show a star
						-- Citizen.InvokeNative(0x63BB75ABEDC1F6A0, gamerTagId, 7, true) --Active gamerTagId
						-- Citizen.InvokeNative(0x613ED644950626AE, gamerTagId, 7, 1) --White star
					-- elseif DecorGetInt(GetPlayerPed(i), "IsOutlaw") == 1 then
						-- Citizen.InvokeNative(0x613ED644950626AE, gamerTagId, 7, 255) -- Set Color to 255
						-- Citizen.InvokeNative(0x63BB75ABEDC1F6A0, gamerTagId, 7, false) --Unactive gamerTagId
					-- end
				-- end
            -- end
        -- end
    -- end
-- end)




local colorNames1 = {
    ['0'] = "Metallic Black",
    ['1'] = "Metallic Graphite Black",
    ['2'] = "Metallic Black Steal",
    ['3'] = "Metallic Dark Silver",
    ['4'] = "Metallic Silver",
    ['5'] = "Metallic Blue Silver",
    ['6'] = "Metallic Steel Gray",
    ['7'] = "Metallic Shadow Silver",
    ['8'] = "Metallic Stone Silver",
    ['9'] = "Metallic Midnight Silver",
    ['10'] = "Metallic Gun Metal",
    ['11'] = "Metallic Anthracite Grey",
    ['12'] = "Matte Black",
    ['13'] = "Matte Gray",
    ['14'] = "Matte Light Grey",
    ['15'] = "Util Black",
    ['16'] = "Util Black Poly",
    ['17'] = "Util Dark silver",
    ['18'] = "Util Silver",
    ['19'] = "Util Gun Metal",
    ['20'] = "Util Shadow Silver",
    ['21'] = "Worn Black",
    ['22'] = "Worn Graphite",
    ['23'] = "Worn Silver Grey",
    ['24'] = "Worn Silver",
    ['25'] = "Worn Blue Silver",
    ['26'] = "Worn Shadow Silver",
    ['27'] = "Metallic Red",
    ['28'] = "Metallic Torino Red",
    ['29'] = "Metallic Formula Red",
    ['30'] = "Metallic Blaze Red",
    ['31'] = "Metallic Graceful Red",
    ['32'] = "Metallic Garnet Red",
    ['33'] = "Metallic Desert Red",
    ['34'] = "Metallic Cabernet Red",
    ['35'] = "Metallic Candy Red",
    ['36'] = "Metallic Sunrise Orange",
    ['37'] = "Metallic Classic Gold",
    ['38'] = "Metallic Orange",
    ['39'] = "Matte Red",
    ['40'] = "Matte Dark Red",
    ['41'] = "Matte Orange",
    ['42'] = "Matte Yellow",
    ['43'] = "Util Red",
    ['44'] = "Util Bright Red",
    ['45'] = "Util Garnet Red",
    ['46'] = "Worn Red",
    ['47'] = "Worn Golden Red",
    ['48'] = "Worn Dark Red",
    ['49'] = "Metallic Dark Green",
    ['50'] = "Metallic Racing Green",
    ['51'] = "Metallic Sea Green",
    ['52'] = "Metallic Olive Green",
    ['53'] = "Metallic Green",
    ['54'] = "Metallic Gasoline Blue Green",
    ['55'] = "Matte Lime Green",
    ['56'] = "Util Dark Green",
    ['57'] = "Util Green",
    ['58'] = "Worn Dark Green",
    ['59'] = "Worn Green",
    ['60'] = "Worn Sea Wash",
    ['61'] = "Metallic Midnight Blue",
    ['62'] = "Metallic Dark Blue",
    ['63'] = "Metallic Saxony Blue",
    ['64'] = "Metallic Blue",
    ['65'] = "Metallic Mariner Blue",
    ['66'] = "Metallic Harbor Blue",
    ['67'] = "Metallic Diamond Blue",
    ['68'] = "Metallic Surf Blue",
    ['69'] = "Metallic Nautical Blue",
    ['70'] = "Metallic Bright Blue",
    ['71'] = "Metallic Purple Blue",
    ['72'] = "Metallic Spinnaker Blue",
    ['73'] = "Metallic Ultra Blue",
    ['74'] = "Metallic Bright Blue",
    ['75'] = "Util Dark Blue",
    ['76'] = "Util Midnight Blue",
    ['77'] = "Util Blue",
    ['78'] = "Util Sea Foam Blue",
    ['79'] = "Uil Lightning blue",
    ['80'] = "Util Maui Blue Poly",
    ['81'] = "Util Bright Blue",
    ['82'] = "Matte Dark Blue",
    ['83'] = "Matte Blue",
    ['84'] = "Matte Midnight Blue",
    ['85'] = "Worn Dark blue",
    ['86'] = "Worn Blue",
    ['87'] = "Worn Light blue",
    ['88'] = "Metallic Taxi Yellow",
    ['89'] = "Metallic Race Yellow",
    ['90'] = "Metallic Bronze",
    ['91'] = "Metallic Yellow Bird",
    ['92'] = "Metallic Lime",
    ['93'] = "Metallic Champagne",
    ['94'] = "Metallic Pueblo Beige",
    ['95'] = "Metallic Dark Ivory",
    ['96'] = "Metallic Choco Brown",
    ['97'] = "Metallic Golden Brown",
    ['98'] = "Metallic Light Brown",
    ['99'] = "Metallic Straw Beige",
    ['100'] = "Metallic Moss Brown",
    ['101'] = "Metallic Biston Brown",
    ['102'] = "Metallic Beechwood",
    ['103'] = "Metallic Dark Beechwood",
    ['104'] = "Metallic Choco Orange",
    ['105'] = "Metallic Beach Sand",
    ['106'] = "Metallic Sun Bleeched Sand",
    ['107'] = "Metallic Cream",
    ['108'] = "Util Brown",
    ['109'] = "Util Medium Brown",
    ['110'] = "Util Light Brown",
    ['111'] = "Metallic White",
    ['112'] = "Metallic Frost White",
    ['113'] = "Worn Honey Beige",
    ['114'] = "Worn Brown",
    ['115'] = "Worn Dark Brown",
    ['116'] = "Worn straw beige",
    ['117'] = "Brushed Steel",
    ['118'] = "Brushed Black steel",
    ['119'] = "Brushed Aluminium",
    ['120'] = "Chrome",
    ['121'] = "Worn Off White",
    ['122'] = "Util Off White",
    ['123'] = "Worn Orange",
    ['124'] = "Worn Light Orange",
    ['125'] = "Metallic Securicor Green",
    ['126'] = "Worn Taxi Yellow",
    ['127'] = "police car blue",
    ['128'] = "Matte Green",
    ['129'] = "Matte Brown",
    ['130'] = "Worn Orange",
    ['131'] = "Matte White",
    ['132'] = "Worn White",
    ['133'] = "Worn Olive Army Green",
    ['134'] = "Pure White",
    ['135'] = "Hot Pink",
    ['136'] = "Salmon pink",
    ['137'] = "Metallic Vermillion Pink",
    ['138'] = "Orange",
    ['139'] = "Green",
    ['140'] = "Blue",
    ['141'] = "Mettalic Black Blue",
    ['142'] = "Metallic Black Purple",
    ['143'] = "Metallic Black Red",
    ['144'] = "hunter green",
    ['145'] = "Metallic Purple",
    ['146'] = "Metaillic V Dark Blue",
    ['147'] = "MODSHOP BLACK1",
    ['148'] = "Matte Purple",
    ['149'] = "Matte Dark Purple",
    ['150'] = "Metallic Lava Red",
    ['151'] = "Matte Forest Green",
    ['152'] = "Matte Olive Drab",
    ['153'] = "Matte Desert Brown",
    ['154'] = "Matte Desert Tan",
    ['155'] = "Matte Foilage Green",
    ['156'] = "DEFAULT ALLOY COLOR",
    ['157'] = "Epsilon Blue",
}



local colorNames = {
    ['0'] = "Black",
    ['1'] = "Black",
    ['2'] = "Black",
    ['3'] = "Grey",
    ['4'] = "Silver",
    ['5'] = "Silver",
    ['6'] = "Silver",
    ['7'] = "Grey",
    ['8'] = "Silver",
    ['9'] = "Grey",
    ['10'] = "Grey",
    ['11'] = "Grey",
    ['12'] = "Black",
    ['13'] = "Gray",
    ['14'] = "Grey",
    ['15'] = "Black",
    ['16'] = "Black",
    ['17'] = "Grey",
    ['18'] = "Silver",
    ['19'] = "Grey",
    ['20'] = "Grey",
    ['21'] = "Black",
    ['22'] = "Grey",
    ['23'] = "Silver",
    ['24'] = "Silver",
    ['25'] = "Silver",
    ['26'] = "Silver",
    ['27'] = "Red",
    ['28'] = "Red",
    ['29'] = "Red",
    ['30'] = "Red",
    ['31'] = "Red",
    ['32'] = "Red",
    ['33'] = "Red",
    ['34'] = "Red",
    ['35'] = "Red",
    ['36'] = "Orange",
    ['37'] = "Yellow",
    ['38'] = "Orange",
    ['39'] = "Red",
    ['40'] = "Red",
    ['41'] = "Orange",
    ['42'] = "Yellow",
    ['43'] = "Red",
    ['44'] = "Red",
    ['45'] = "Red",
    ['46'] = "Red",
    ['47'] = "Red",
    ['48'] = "Red",
    ['49'] = "Green",
    ['50'] = "Green",
    ['51'] = "Green",
    ['52'] = "Green",
    ['53'] = "Green",
    ['54'] = "Green",
    ['55'] = "Green",
    ['56'] = "Green",
    ['57'] = "Green",
    ['58'] = "Green",
    ['59'] = "Green",
    ['60'] = "Green",
    ['61'] = "Blue",
    ['62'] = "Blue",
    ['63'] = "Blue",
    ['64'] = "Blue",
    ['65'] = "Blue",
    ['66'] = "Blue",
    ['67'] = "Blue",
    ['68'] = "Blue",
    ['69'] = "Blue",
    ['70'] = "Blue",
    ['71'] = "Purple",
    ['72'] = "Purple",
    ['73'] = "Blue",
    ['74'] = "Blue",
    ['75'] = "Blue",
    ['76'] = "Blue",
    ['77'] = "Blue",
    ['78'] = "Blue",
    ['79'] = "Blue",
    ['80'] = "Blue",
    ['81'] = "Blue",
    ['82'] = "Blue",
    ['83'] = "Blue",
    ['84'] = "Blue",
    ['85'] = "Blue",
    ['86'] = "Blue",
    ['87'] = "Blue",
    ['88'] = "Yellow",
    ['89'] = "Yellow",
    ['90'] = "Brown",
    ['91'] = "Yellow",
    ['92'] = "Green",
    ['93'] = "Brown",
    ['94'] = "Brown",
    ['95'] = "Brown",
    ['96'] = "Brown",
    ['97'] = "Brown",
    ['98'] = "Brown",
    ['99'] = "Brown",
    ['100'] = "Brown",
    ['101'] = "Brown",
    ['102'] = "Brown",
    ['103'] = "Brown",
    ['104'] = "Brown",
    ['105'] = "Yellow",
    ['106'] = "Yellow",
    ['107'] = "White",
    ['108'] = "Brown",
    ['109'] = "Brown",
    ['110'] = "Brown",
    ['111'] = "White",
    ['112'] = "White",
    ['113'] = "Yellow",
    ['114'] = "Brown",
    ['115'] = "Brown",
    ['116'] = "Yellow",
    ['117'] = "Silver",
    ['118'] = "Black",
    ['119'] = "Silver",
    ['120'] = "Chrome",
    ['121'] = "White",
    ['122'] = "White",
    ['123'] = "Orange",
    ['124'] = "Orange",
    ['125'] = "Green",
    ['126'] = "Yellow",
    ['127'] = "Blue",
    ['128'] = "Green",
    ['129'] = "Brown",
    ['130'] = "Orange",
    ['131'] = "White",
    ['132'] = "White",
    ['133'] = "Green",
    ['134'] = "White",
    ['135'] = "Pink",
    ['136'] = "Pink",
    ['137'] = "Pink",
    ['138'] = "Orange",
    ['139'] = "Green",
    ['140'] = "Blue",
    ['141'] = "Blue",
    ['142'] = "Purple",
    ['143'] = "Red",
    ['144'] = "Green",
    ['145'] = "Purple",
    ['146'] = "Blue",
    ['147'] = "Black",
    ['148'] = "Purple",
    ['149'] = "Purple",
    ['150'] = "Red",
    ['151'] = "Green",
    ['152'] = "Green",
    ['153'] = "Brown",
    ['154'] = "Brown",
    ['155'] = "Green",
    ['156'] = "Silver",
    ['157'] = "Blue",
}


Citizen.CreateThread( function()
    while true do
       
		cped = GetPlayerPed(-1)
        if DecorGetInt(cped, "IsOutlaw") == 2 then
            Wait( math.ceil(timing) )
            DecorSetInt(cped, "IsOutlaw", 1)
        end
		 Wait(1000)
    end
end)
--[[
Citizen.CreateThread( function()
    while true do
        Wait(30)
		local cped = GetPlayerPed(-1)
        if IsPedTryingToEnterALockedVehicle(cped) or IsPedJacking(cped) then
			local plyPos = GetEntityCoords(cped,  true)
			local s1, s2 = GetStreetNameAtCoord(plyPos.x, plyPos.y, plyPos.z)
			local street1 = GetStreetNameFromHashKey(s1)
			local street2 = GetStreetNameFromHashKey(s2)
			TriggerServerEvent('6b78315f-a809-47c1-97b9-0370e1e47683', "carjacking!")
			Wait(3000)
			DecorSetInt(cped, "IsOutlaw", 2)
			local playerPed = cped
			local coords    = GetEntityCoords(playerPed)
			local vehicle =GetVehiclePedIsIn(playerPed,false)
			local vehicleProps  = ESX.Game.GetVehicleProperties(vehicle)
			if PlayerData.job ~= nil and PlayerData.job.name == 'police' and (showcopsmisbehave == false or exports['webcops']:amiloggedin()) then
			elseif PlayerData.job ~= nil and PlayerData.job.name == 'police' and showcopsmisbehave  then
				ESX.TriggerServerCallback('414dabe3-5bb2-47a7-a6a4-e63dcfd9d0f9',function(valid)
					if (valid) then
					else
						ESX.TriggerServerCallback('4568d939-3661-4833-ae6a-378432ac6ff1', function(skin, jobSkin)
							local sex = nil
							if skin.sex == 0 then
								sex = "male"
							else
								sex = "female"
							end
							TriggerServerEvent('2637ec08-ad1d-4523-b480-68cda5128be7', plyPos.x, plyPos.y, plyPos.z)
							--local vehicle = GetVehiclePedIsTryingToEnter(cped)
							local model = GetEntityModel(vehicle)
							local vehName = GetLabelText(GetDisplayNameFromVehicleModel(model))
							local primary, secondary = cGetVehicleColours(vehicle)
							
							if s2 == 0 then
								if IsPedInAnyPoliceVehicle(cped) then
									TriggerServerEvent('thiefInProgressS1police', street1, vehName .. ' ' .. primary .. ' ', sex)
								else
									TriggerServerEvent('e5d0d2cd-4b53-40de-ab12-126781bfeea6', street1, vehName .. ' ' .. primary .. ' ', sex)
								end
								
							elseif s2 ~= 0 then
								if IsPedInAnyPoliceVehicle(cped) then
									TriggerServerEvent('791bb2a3-23c0-4eae-a446-fc5253075919', street1, street2, vehName .. ' ' .. primary .. ' ', sex)
								else
									TriggerServerEvent('d8f758e5-40ea-4720-aee2-df156e1f4a78', street1, street2, vehName .. ' ' .. primary .. ' ', sex)
								end
								
							end
						end)
						Wait(10000)
					end
				end,vehicleProps)
			else
				ESX.TriggerServerCallback('414dabe3-5bb2-47a7-a6a4-e63dcfd9d0f9',function(valid)
					if (valid) then
					else
						ESX.TriggerServerCallback('4568d939-3661-4833-ae6a-378432ac6ff1', function(skin, jobSkin)
							local sex = nil
							if skin.sex == 0 then
								sex = "male"
							else
								sex = "female"
							end
							TriggerServerEvent('2637ec08-ad1d-4523-b480-68cda5128be7', plyPos.x, plyPos.y, plyPos.z)
							--local vehicle = GetVehiclePedIsTryingToEnter(cped)
							local model = GetEntityModel(vehicle)
							local vehName = GetLabelText(GetDisplayNameFromVehicleModel(model))
							local primary, secondary = cGetVehicleColours(vehicle)
							if s2 == 0 then
								TriggerServerEvent('e5d0d2cd-4b53-40de-ab12-126781bfeea6', street1, vehName .. ' ' .. primary .. ' ', sex)
							elseif s2 ~= 0 then
								TriggerServerEvent('d8f758e5-40ea-4720-aee2-df156e1f4a78', street1, street2, vehName .. ' ' .. primary .. ' ', sex)
							end
						end)
					end
				end,vehicleProps)
				Wait(10000)
			end
        end
    end
end)--]]


function cGetVehicleColours(cvehicle)
	if GetIsVehiclePrimaryColourCustom(cvehicle) then  
		return "Custom","Custom"
	elseif GetIsVehicleSecondaryColourCustom(cvehicle) then
		local primary, secondary = cGetVehicleColours(cvehicle)
		primary = colorNames[tostring(primary)]
		--Citizen.Trace('Primary Color Reg: ' .. primary)
		return primary, "Custom"
		
	else
	
		local primary, secondary = GetVehicleColours(cvehicle)
		if primary == nil then
			primary = "unknown"
			secondary = "unknown"
		elseif secondary == nil then
			primary = colorNames[tostring(primary)]
			secondary = nil
		else
			primary = colorNames[tostring(primary)]
			secondary = colorNames[tostring(secondary)]
		end
		--Citizen.Trace('Primary Color Reg: ' .. primary)
		return primary, secondary
	end

end

--[[
Citizen.CreateThread( function()
    while true do
        Wait(70)
		local cped = GetPlayerPed(-1)
        if IsPedInMeleeCombat(cped) then
			local plyPos = GetEntityCoords(cped,  true)
			local s1, s2 = GetStreetNameAtCoord(plyPos.x, plyPos.y, plyPos.z)
			local street1 = GetStreetNameFromHashKey(s1)
			local street2 = GetStreetNameFromHashKey(s2)
            DecorSetInt(cped, "IsOutlaw", 2)
			if PlayerData.job ~= nil and PlayerData.job.name == 'police' and (showcopsmisbehave == false or exports['webcops']:amiloggedin() ) then
			elseif PlayerData.job ~= nil and PlayerData.job.name == 'police' and showcopsmisbehave then
				ESX.TriggerServerCallback('4568d939-3661-4833-ae6a-378432ac6ff1', function(skin, jobSkin)
					local sex = nil
					if skin.sex == 0 then
						sex = "male"
					else
						sex = "female"
					end
					TriggerServerEvent('0aa1a4e7-c6de-4121-bb71-269eb0a646e2', plyPos.x, plyPos.y, plyPos.z)
					if s2 == 0 then
						TriggerServerEvent('121fd2ce-59d4-460e-9c1d-8f2cdc0d8776', street1, sex)
					elseif s2 ~= 0 then
						TriggerServerEvent('f487a121-ce92-45a4-97d6-3c88e3c38382', street1, street2, sex)
					end
				end)
				Wait(10000)
			else
				ESX.TriggerServerCallback('4568d939-3661-4833-ae6a-378432ac6ff1', function(skin, jobSkin)
					local sex = nil
					if skin.sex == 0 then
						sex = "male"
					else
						sex = "female"
					end
					TriggerServerEvent('0aa1a4e7-c6de-4121-bb71-269eb0a646e2', plyPos.x, plyPos.y, plyPos.z)
					if s2 == 0 then
						TriggerServerEvent('121fd2ce-59d4-460e-9c1d-8f2cdc0d8776', street1, sex)
					elseif s2 ~= 0 then
						TriggerServerEvent('f487a121-ce92-45a4-97d6-3c88e3c38382', street1, street2, sex)
					end
				end)
				Wait(10000)
			end
			
		else
			Wait(500)
        end
    end
end)--]]



local weapons = {
"WEAPON_KNIFE",
"WEAPON_NIGHTSTICK",
"WEAPON_HAMMER",
"WEAPON_BAT",
"WEAPON_GOLFCLUB",
"WEAPON_CROWBAR",
"WEAPON_PISTOL",
"WEAPON_COMBATPISTOL",
"WEAPON_APPISTOL",
"WEAPON_PISTOL50",
"WEAPON_MICROSMG",
"WEAPON_SMG",
"WEAPON_ASSAULTSMG",
"WEAPON_ASSAULTRIFLE",
"WEAPON_CARBINERIFLE",
"WEAPON_ADVANCEDRIFLE",
"WEAPON_MG",
"WEAPON_COMBATMG",
"WEAPON_PUMPSHOTGUN",
"WEAPON_SAWNOFFSHOTGUN",
"WEAPON_ASSAULTSHOTGUN",
"WEAPON_BULLPUPSHOTGUN",
"WEAPON_STUNGUN",
"WEAPON_SNIPERRIFLE",
"WEAPON_HEAVYSNIPER",
"WEAPON_REMOTESNIPER",
"WEAPON_GRENADELAUNCHER",
"WEAPON_GRENADELAUNCHER_SMOKE",
"WEAPON_RPG",
"WEAPON_STINGER",
"WEAPON_MINIGUN",
"WEAPON_GRENADE",
"WEAPON_STICKYBOMB",
"WEAPON_SMOKEGRENADE",
"WEAPON_BZGAS",
"WEAPON_MOLOTOV",
"WEAPON_FIREEXTINGUISHER",
"WEAPON_PETROLCAN",
"WEAPON_BALL",
"WEAPON_FLARE",
"WEAPON_VEHICLE_ROCKET",
"WEAPON_EXPLOSION",
"WEAPON_EXHAUSTION",
"WEAPON_HELI_CRASH",
"WEAPON_FIRE",
"WEAPON_SNSPISTOL",
"WEAPON_BOTTLE",
"WEAPON_GUSENBERG",
"WEAPON_SPECIALCARBINE",
"WEAPON_HEAVYPISTOL",
"WEAPON_BULLPUPRIFLE",
"WEAPON_DAGGER",
"WEAPON_VINTAGEPISTOL",
"WEAPON_FIREWORK",
"WEAPON_MUSKET",
"WEAPON_HEAVYSHOTGUN",
"WEAPON_MARKSMANRIFLE",
"WEAPON_HOMINGLAUNCHER",
"WEAPON_PROXMINE",
"WEAPON_SNOWBALL",
"WEAPON_FLAREGUN",
"WEAPON_GARBAGEBAG",
"WEAPON_HANDCUFFS",
"WEAPON_COMBATPDW",
"WEAPON_MARKSMANPISTOL",
"WEAPON_KNUCKLE",
"WEAPON_HATCHET",
"WEAPON_RAILGUN",
"WEAPON_MACHETE",
"WEAPON_MACHINEPISTOL",
"WEAPON_AIR_DEFENCE_GUN",
"WEAPON_SWITCHBLADE",
"WEAPON_REVOLVER",
"WEAPON_DBSHOTGUN",
"WEAPON_COMPACTRIFLE",
"WEAPON_AUTOSHOTGUN",
"WEAPON_BATTLEAXE",
"WEAPON_COMPACTLAUNCHER",
"WEAPON_MINISMG",
"WEAPON_PIPEBOMB",
"WEAPON_POOLCUE",
"WEAPON_WRENCH",
}

meleeweapons = {}

meleeweapons[`WEAPON_FIREEXTINGUISHER`] = 1
meleeweapons[`WEAPON_SNOWBALL`] = 1
meleeweapons[`WEAPON_PETROLCANR`] = 1
meleeweapons[`WEAPON_WRENCH`] = 1
meleeweapons[`WEAPON_SWITCHBLADE`] = 1
meleeweapons[`WEAPON_MACHETE`] = 1
meleeweapons[`WEAPON_PROXMINE`] = 1
meleeweapons[`WEAPON_DAGGER`] = 1
meleeweapons[`WEAPON_BOTTLE`] = 1
meleeweapons[`WEAPON_KNIFE`] = 1
meleeweapons[`WEAPON_HAMMER`] = 1
meleeweapons[`WEAPON_BAT`] = 1
meleeweapons[`WEAPON_NIGHTSTICK`] = 1
meleeweapons[`WEAPON_GOLFCLUB`] = 1
meleeweapons[`WEAPON_CROWBAR`] = 1
meleeweapons[`WEAPON_STUNGUN`] = 1



local lasttimefired = 0


RegisterNetEvent('62a9e101-751e-4452-8cef-a8ac78c140fc')
AddEventHandler('62a9e101-751e-4452-8cef-a8ac78c140fc', function(player)

		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		TriggerServerEvent('b98bf1d1-fa8b-4686-b4bb-dd295c3d8ad1',player,GetPlayerServerId(closestPlayer))
end)

RegisterNetEvent('d3569d4c-df41-4fc4-84f1-8958d6477402')
AddEventHandler('d3569d4c-df41-4fc4-84f1-8958d6477402', function(player)

	local result = false
	if lasttimefired > (GetGameTimer() - (15 * 1000 * 60)) and lasttimefired ~= 0 then
		result = true
	else
		result = false
	end
	TriggerServerEvent('5164d98f-09ba-42ef-8735-468c564226de',player,result)
end)




Citizen.CreateThread( function()
    while true do
        Wait(20)
		
		if IsPedArmed(cped, 6) and gunshotAlert == true then
			if IsPedShooting(cped) then
				--GSR
				if  meleeweapons[fweapon] == nil then
					lasttimefired = GetGameTimer()
				end
			
				if not IsPedCurrentWeaponSilenced(cped) then
					local chance = math.random(1,10)
					local permission2 = true
					if chance < 5 then
						local plyPos = GetEntityCoords(cped,  true)
						local plyPosreal = plyPos
						local xxx = math.random(-90,90) + 0.1
						local yyy = math.random(-90,90) + 0.1
						
						if #(vector3(479.81893920898,-1000.0877075195,25.734663009644) - plyPos) <  8 then
							permission2 = false
							Wait(1000)
						elseif #(vector3(12.624784469604,-1097.7542724609,29.797019958496) - plyPos) < 8 then
							permission2 = false
							Wait(1000)
						end
						
						plyPos = vector3(plyPos.x + xxx,plyPos.y + yyy, plyPos.z )
				
						local s1, s2 = GetStreetNameAtCoord(plyPos.x, plyPos.y, plyPos.z)
						
						--Citizen.InvokeNative( 0x2EB41072B4C1E4C0, plyPos.x, plyPos.y, plyPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
						local street1 = GetStreetNameFromHashKey(s1)
						local street2 = GetStreetNameFromHashKey(s2)
						local fweapon = GetSelectedPedWeapon(cped)
						
						---- weapon check
						
						
						if  meleeweapons[fweapon] == nil and permission2 == true then
							
								DecorSetInt(cped, "IsOutlaw", 2)
								if PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' then
								
								elseif PlayerData.job ~= nil and PlayerData.job.name == 'police' and (showcopsmisbehave == false or exports['webcops']:amiloggedin()) then
											local fweapon = GetSelectedPedWeapon(cped)
											local weaponname = ' '
											
											
									--for i = 1, #weapons do
									--	if HasPedGotWeapon(fweapon,GetHashKey(weapons[i]),false) then
									--		weaponname = weapons[i]
									--	end
								--	end
									local gun = ' '
									if weaponname == nil then
										gun = 'POLICE FIRE: ' .. tostring(fweapon)
									else
										gun = 'POLICE FIRE: ' .. weaponname .. tostring(fweapon)
									end
									--print (gun)
									TriggerServerEvent('5d8da193-e139-4447-82dc-e409af494b91', gun)
									Wait(2000)
								elseif PlayerData.job ~= nil and PlayerData.job.name == 'police' and showcopsmisbehave then
									
										local sex = nil
										local entitymodel = GetEntityModel(cped)
										if entitymodel == `mp_m_freemode_01` then
											sex = "male"
										elseif entitymodel == `mp_f_freemode_01` then
											sex = "female"
										else
											sex = "unknown gender"
										end
												
										if  meleeweapons[fweapon] ~= nil then
												TriggerServerEvent('0aa1a4e7-c6de-4121-bb71-269eb0a646e2', plyPos.x, plyPos.y, plyPos.z)
												if s2 == 0 then
													TriggerServerEvent('121fd2ce-59d4-460e-9c1d-8f2cdc0d8776', street1, sex)
												elseif s2 ~= 0 then
													TriggerServerEvent('f487a121-ce92-45a4-97d6-3c88e3c38382', street1, street2, sex)
												end
										else
										
											TriggerServerEvent('31ed5b35-7cb7-4aa9-ae10-8b14bcaf5420', plyPos.x, plyPos.y, plyPos.z,plyPosreal)
											if s2 == 0 then
												TriggerServerEvent('aa94255c-9c6f-420b-9d36-df828f6eab28', street1, sex)
											elseif s2 ~= 0 then
												TriggerServerEvent('03387af4-db5f-4d73-a1d5-51567bf65aa3', street1, street2, sex)
											end
											
										end
							
									if PlayerData.job.name == 'police' then
											local fweapon = GetSelectedPedWeapon(cped)
											local weaponname = ' '
											for i = 1, #weapons do
												if fweapon == GetHashKey(weapons[i]) then
													weaponname = weapons[i]
												end
											end
											local gun = ' '
											if weaponname == nil then
												gun = 'POLICE FIRE: ' .. tostring(fweapon)
											else
												gun = 'POLICE FIRE: ' .. weaponname .. ' ' .. tostring(fweapon)
											end
											--print (gun)
											TriggerServerEvent('5d8da193-e139-4447-82dc-e409af494b91', gun)
											Wait(2000)
									else
										Wait(20000)
									end
								else
										local entitymodel = GetEntityModel(cped)
										if entitymodel == `mp_m_freemode_01` then
											sex = "male"
										elseif entitymodel == `mp_f_freemode_01` then
											sex = "female"
										else
											sex = "unknown gender"
										end
										
										if meleeweapons[fweapon] ~= nil then
											TriggerServerEvent('0aa1a4e7-c6de-4121-bb71-269eb0a646e2', plyPos.x, plyPos.y, plyPos.z)
											if s2 == 0 then
												TriggerServerEvent('121fd2ce-59d4-460e-9c1d-8f2cdc0d8776', street1, sex)
											elseif s2 ~= 0 then
												TriggerServerEvent('f487a121-ce92-45a4-97d6-3c88e3c38382', street1, street2, sex)
											end
										else
											TriggerServerEvent('31ed5b35-7cb7-4aa9-ae10-8b14bcaf5420', plyPos.x, plyPos.y, plyPos.z,plyPosreal)
											if s2 == 0 then
												TriggerServerEvent('aa94255c-9c6f-420b-9d36-df828f6eab28', street1, sex)
											elseif s2 ~= 0 then
												TriggerServerEvent('03387af4-db5f-4d73-a1d5-51567bf65aa3', street1, street2, sex)
											end
										end
									Wait(20000)
								end
						end
					end
				end
			end
		else
			Wait(500)
		end
    end
end)




