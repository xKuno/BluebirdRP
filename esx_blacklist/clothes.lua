--Defining ESX and Player Data
ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end
    PlayerData = ESX.GetPlayerData()
end)

--Ensuring we get a Player's new job on Change
RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function(job)
	Wait(1000)
	PlayerData = ESX.GetPlayerData()
end)

--Sets Clients Clothes
RegisterNetEvent('3a8d4949-cc43-4ade-849b-748d02859759')
AddEventHandler('3a8d4949-cc43-4ade-849b-748d02859759', function(clothingTypeId, clothingId, clothingTextureId)
	local pedCurrent = GetPlayerPed(-1)
	if clothingTypeId == 0 then
		SetPedPropIndex(pedCurrent, clothingTypeId, clothingId, clothingTextureId, true)
	else 
		SetPedComponentVariation(pedCurrent, clothingTypeId, clothingId, clothingTextureId, 3)
	end
end)

--Removes Clients Clothes
RegisterNetEvent('278937e3-549b-464a-9d0b-3c576a818652')
AddEventHandler('278937e3-549b-464a-9d0b-3c576a818652', function(clothingTypeId)
	local pedCurrent = GetPlayerPed(-1)
	if clothingTypeId== 11 then	
	
		SetPedComponentVariation(pedCurrent,11,241,0,0)
		
	elseif clothingTypeId == 9 then
		
		SetPedComponentVariation(pedCurrent, 9,-1,0, 9)
		
	elseif clothingTypeId == 5 then
		
		SetPedComponentVariation(pedCurrent, 5,-1,0, 9)
		
	elseif clothingTypeId == 7 then
		
		SetPedComponentVariation(pedCurrent,7,-1,0,0)
		
	elseif clothingTypeId == 0 then
		
		ClearPedProp(pedCurrent,0)
		
	elseif clothingTypeId == 1 then
		
		SetPedComponentVariation(pedCurrent,1,-1,0,0)
		
	elseif clothingTypeId == 4 then
		
		SetPedComponentVariation(pedCurrent, 4,14,0, 9)
		
	elseif clothingTypeId == 10 then
		
		SetPedComponentVariation(pedCurrent, 10,-1,0, 9)
		
	end
end)

--Blacklist Core
Citizen.CreateThread(function()
	local enabled = true
	while enabled do
		Citizen.Wait(12000)
		
		--Defining a Boat-load of Bullshit
		local ped = PlayerPedId()
		local model = GetEntityModel(ped)
		local playerInventory = ESX.GetPlayerData().inventory
		local hasItem = false
		local clothingItem = nil
		local clothingTexture = nil		
		
		for c=1, #Config.Clothing, 1 do
		
			--Defining the Clothing Variation and Texture we are Dealing with
			if Config.Clothing[c].clothingTypeId == 11 then	
			
				clothingItem = GetPedDrawableVariation(ped,11)
				clothingTexture = GetPedTextureVariation(ped,11)
				
			elseif Config.Clothing[c].clothingTypeId == 9 then
		
				clothingItem = GetPedDrawableVariation(ped,9)
				clothingTexture = GetPedTextureVariation(ped,9)
		
			elseif Config.Clothing[c].clothingTypeId == 5 then
		
				clothingItem = GetPedDrawableVariation(ped,5)
				clothingTexture = GetPedTextureVariation(ped,5)
		
			elseif Config.Clothing[c].clothingTypeId == 7 then
		
				clothingItem = GetPedDrawableVariation(ped,7)
				clothingTexture = GetPedPropTextureIndex(ped,7)
		
			elseif Config.Clothing[c].clothingTypeId == 0 then
		
				clothingItem = GetPedPropIndex(ped,0)
				clothingTexture = GetPedPropTextureIndex(ped,0)
		
			elseif Config.Clothing[c].clothingTypeId == 1 then
		
				clothingItem = GetPedDrawableVariation(ped,1)
				clothingTexture = GetPedTextureVariation(ped,1)
		
			elseif Config.Clothing[c].clothingTypeId == 4 then
		
				clothingItem = GetPedDrawableVariation(ped,4)
				clothingTexture = GetPedTextureVariation(ped,4)
		
			elseif Config.Clothing[c].clothingTypeId == 10 then
		
				clothingItem = GetPedDrawableVariation(ped,10)
				clothingTexture = GetPedTextureVariation(ped,10)
		
			end
			
			--Job Whitelist
			if Config.Clothing[c].whitelistType == "job" and Config.Clothing[c].jobName ~= nil and PlayerData ~= nil then
			
				if model == `mp_m_freemode_01`and Config.Clothing[c].gender == "m" then
				
					if clothingItem == Config.Clothing[c].clothingId then

						if clothingTexture == Config.Clothing[c].clothingTextureId or Config.Clothing[c].clothingTextureId == nil then
						
							if PlayerData.job ~= nil and PlayerData.job.name ~= Config.Clothing[c].jobName then
							
								TriggerEvent('278937e3-549b-464a-9d0b-3c576a818652', Config.Clothing[c].clothingTypeId, playerPed)
								ESX.ShowNotification(Config.Clothing[c].message)

							end

						end
					
					end
				elseif model == `mp_f_freemode_01`and Config.Clothing[c].gender == "f" then
				
					if clothingItem == Config.Clothing[c].clothingId then
					
						if clothingTexture == Config.Clothing[c].clothingTextureId or Config.Clothing[c].clothingTextureId == nil then
						
							if PlayerData.job ~= nil and PlayerData.job.name ~= Config.Clothing[c].jobName then
							
								TriggerEvent('278937e3-549b-464a-9d0b-3c576a818652', Config.Clothing[c].clothingTypeId, playerPed)
								ESX.ShowNotification(Config.Clothing[c].message)

							end
						
						end
					
					end
				end	
			--Item Whitelist
			elseif Config.Clothing[c].whitelistType == "item" and Config.Clothing[c].itemName ~= nil and playerInventory ~= nil then
				if model == `mp_m_freemode_01`and Config.Clothing[c].gender == "m" then
				
					if clothingItem == Config.Clothing[c].clothingId then
					
						if clothingTexture == Config.Clothing[c].clothingTextureId or Config.Clothing[c].clothingTextureId == nil then
						
							for i=1, #playerInventory, 1 do
								
								if playerInventory[i].name == Config.Clothing[c].itemName and playerInventory[i].count > 0 then
									
									hasItem = true
									
								end
								
								if not hasItem and playerInventory[i].name == Config.Clothing[c].itemName and playerInventory[i].count < 1 then

									TriggerEvent('278937e3-549b-464a-9d0b-3c576a818652', Config.Clothing[c].clothingTypeId, playerPed)
									ESX.ShowNotification(Config.Clothing[c].message)
							
								end
								
								hasItem = false
								
							end
						
						end
					
					end	
				elseif model == `mp_f_freemode_01`and Config.Clothing[c].gender == "f" then
				
					if clothingItem == Config.Clothing[c].clothingId then
					
						if clothingTexture == Config.Clothing[c].clothingTextureId or Config.Clothing[c].clothingTextureId == nil then
						
							for i=1, #playerInventory, 1 do
								
								if playerInventory[i].name == Config.Clothing[c].itemName and playerInventory[i].count > 0 then
									
									hasItem = true
									
								end
								
								if not hasItem and playerInventory[i].name == Config.Clothing[c].itemName and playerInventory[i].count < 1 then

									TriggerEvent('278937e3-549b-464a-9d0b-3c576a818652', Config.Clothing[c].clothingTypeId, playerPed)
									ESX.ShowNotification(Config.Clothing[c].message)
							
								end
								
								hasItem = false
								
							end
						
						end
					
					end
				
				end
			end	
		end
	end
end)