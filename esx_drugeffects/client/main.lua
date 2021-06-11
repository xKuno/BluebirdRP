ESX                  = nil
local IsAlreadyDrug = false
local DrugLevel     = -1

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(250)
  end
end)

AddEventHandler('8775fded-dc97-4658-a3f2-1a1e4787535d', function(status)

  TriggerEvent('b9b1be21-5482-41d7-bd83-71d4f8e32d8f', 'drug', 0, '#9ec617', 
    function(status)
      if status.val > 0 then
        return true
      else
        return false
      end
    end,
    function(status)
      status.remove(1500)
    end
  )

	Citizen.CreateThread(function()

		while true do

			Wait(1500)

		TriggerEvent('96cc2e86-0b6a-4092-b5c5-9d8057130449', 'drug', function(status)
				
			if status.val > 0 then
						
			  local start = true

			  if IsAlreadyDrug then
				start = false
			  end

			  local level = 0

			  if status.val <= 999999 then
				level = 0
			  else
				overdose()
			  end

			  if level ~= DrugLevel then
			  end

			  IsAlreadyDrug = true
			  DrugLevel     = level
			end

				if status.val == 0 then
          
          if IsAlreadyDrug then
            Normal()
          end

          IsAlreadyDrug = false
          DrugLevel     = -1

				end

			end)

		end

	end)

end)

--When effects ends go back to normal
function Normal()

  Citizen.CreateThread(function()
    
    local playerPed = GetPlayerPed(-1)
			
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    --ResetPedMovementClipset(playerPed, 0) <- it might cause the push of the vehicles
    SetPedIsDrug(playerPed, false)
    SetPedMotionBlur(playerPed, false)
  end)

end

--In case too much drugs dies of overdose set everything back
function overdose()

  Citizen.CreateThread(function()

    local playerPed = GetPlayerPed(-1)
	
    SetEntityHealth(playerPed, 0)
    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
    ResetPedMovementClipset(playerPed, 0)
    SetPedIsDrug(playerPed, false)
    SetPedMotionBlur(playerPed, false)

  end)

end

--Drugs Effects

--Weed
RegisterNetEvent('6ee08eb5-122a-4280-b9fb-141926977391')
AddEventHandler('6ee08eb5-122a-4280-b9fb-141926977391', function()
  
  local playerPed = GetPlayerPed(-1)
  
    RequestAnimSet("move_m@hipster@a") 
    while not HasAnimSetLoaded("move_m@hipster@a") do
      Citizen.Wait(0)
    end    

    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
    Citizen.Wait(3000)
    ClearPedTasksImmediately(playerPed)
    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedMovementClipset(playerPed, "move_m@hipster@a", true)
    SetPedIsDrug(playerPed, true)
    
    --Efects
    local player = PlayerId()
    SetRunSprintMultiplierForPlayer(player, 1.3)
        
    Wait(300000)

    SetRunSprintMultiplierForPlayer(player, 1.0)		
end)

--Opium
RegisterNetEvent('a84c5053-c535-4ee2-83e0-752cf4eef774')
AddEventHandler('a84c5053-c535-4ee2-83e0-752cf4eef774', function()
  
  local playerPed = GetPlayerPed(-1)
  
        RequestAnimSet("move_m@drunk@moderatedrunk") 
    while not HasAnimSetLoaded("move_m@drunk@moderatedrunk") do
      Citizen.Wait(0)
    end    

    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
    Citizen.Wait(3000)
    ClearPedTasksImmediately(playerPed)
    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedMovementClipset(playerPed, "move_m@drunk@moderatedrunk", true)
    SetPedIsDrug(playerPed, true)
    
    --Efects
    local player = PlayerId()
    SetRunSprintMultiplierForPlayer(player, 1.2)
    SetSwimMultiplierForPlayer(player, 1.3)

    Wait(520000)

    SetRunSprintMultiplierForPlayer(player, 1.0)
    SetSwimMultiplierForPlayer(player, 1.0)
 end)

--Meth
RegisterNetEvent('004a6db5-2293-4a78-95eb-17a516f00583')
AddEventHandler('004a6db5-2293-4a78-95eb-17a516f00583', function()
  
  local playerPed = GetPlayerPed(-1)
  local maxHealth = GetEntityMaxHealth(playerPed)

        RequestAnimSet("move_injured_generic") 
    while not HasAnimSetLoaded("move_injured_generic") do
      Citizen.Wait(0)
    end    

    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
    Citizen.Wait(3000)
    ClearPedTasksImmediately(playerPed)
    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedMovementClipset(playerPed, "move_injured_generic", true)
    SetPedIsDrug(playerPed, true)
	
    
   --Efects
    local player = PlayerId()
	AddArmourToPed(playerPed, 100)
    local health = GetEntityHealth(playerPed)
    local newHealth = math.min(maxHealth , math.floor(health + maxHealth/8))
    SetEntityHealth(playerPed, newHealth)
    
end)

--Coke
RegisterNetEvent('60c0bd55-1dd3-4a93-b03d-d3de2c648a1d')
AddEventHandler('60c0bd55-1dd3-4a93-b03d-d3de2c648a1d', function()
  
  local playerPed = GetPlayerPed(-1)
  local maxHealth = GetEntityMaxHealth(playerPed)

        RequestAnimSet("move_m@hurry_butch@a") 
    while not HasAnimSetLoaded("move_m@hurry_butch@a") do
      Citizen.Wait(0)
    end    

    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
    Citizen.Wait(3000)
    ClearPedTasksImmediately(playerPed)
    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedMovementClipset(playerPed, "move_m@hurry_butch@a", true)
    SetPedIsDrug(playerPed, true)
    
    --Efects
    local player = PlayerId()
    
    local health = GetEntityHealth(playerPed)
    local newHealth = math.min(maxHealth , math.floor(health + maxHealth/6))
    SetEntityHealth(playerPed, newHealth)
    
end)


RegisterNetEvent('a490dcd3-d41f-4d2b-bfea-1aeec9ae4325')
AddEventHandler('a490dcd3-d41f-4d2b-bfea-1aeec9ae4325', function()
  
  local playerPed = GetPlayerPed(-1)
  local maxHealth = GetEntityMaxHealth(playerPed)

        RequestAnimSet("move_m@hurry_butch@a") 
    while not HasAnimSetLoaded("move_m@hurry_butch@a") do
      Citizen.Wait(0)
    end    

    TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_SMOKING_POT", 0, 1)
    Citizen.Wait(3000)
    ClearPedTasksImmediately(playerPed)
    SetTimecycleModifier("spectator5")
    SetPedMotionBlur(playerPed, true)
    SetPedMovementClipset(playerPed, "move_m@hurry_butch@a", true)
    SetPedIsDrug(playerPed, true)
    
    --Efects
    local player = PlayerId()
    
    local health = GetEntityHealth(playerPed)
    local newHealth = math.min(maxHealth , math.floor(health + maxHealth/6))
    SetEntityHealth(playerPed, newHealth)
    
end)