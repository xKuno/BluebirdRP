ESX                  = nil
local IsAlreadyDrunk = false
local DrunkLevel     = -1

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

function Drunk(level, start)
  
  Citizen.CreateThread(function()

    local playerPed = GetPlayerPed(-1)

    if start then
      DoScreenFadeOut(800)
      Wait(1000)
    end

    if level == 0 then

      RequestAnimSet("move_m@drunk@slightlydrunk")
      
      while not HasAnimSetLoaded("move_m@drunk@slightlydrunk") do
        Citizen.Wait(0)
      end

      SetPedMovementClipset(playerPed, "move_m@drunk@slightlydrunk", true)
	  ShakeGameplayCam("DRUNK_SHAKE", 0.5)

    elseif level == 1 then

      RequestAnimSet("move_m@drunk@moderatedrunk")
      
      while not HasAnimSetLoaded("move_m@drunk@moderatedrunk") do
        Citizen.Wait(0)
      end

      SetPedMovementClipset(playerPed, "move_m@drunk@moderatedrunk", true)
	  ShakeGameplayCam("DRUNK_SHAKE", 0.75)

    elseif level == 2 then

      RequestAnimSet("move_m@drunk@verydrunk")
      
      while not HasAnimSetLoaded("move_m@drunk@verydrunk") do
        Citizen.Wait(0)
      end

      SetPedMovementClipset(playerPed, "move_m@drunk@verydrunk", true)
	  ShakeGameplayCam("DRUNK_SHAKE", 1.0)

    end

    SetTimecycleModifier("Drug_wobbly")
    SetPedMotionBlur(playerPed, true)
    SetPedIsDrunk(playerPed, true)

    if start then
      DoScreenFadeIn(800)
    end

  end)

end

function Reality()

  Citizen.CreateThread(function()

    local playerPed = GetPlayerPed(-1)

    DoScreenFadeOut(800)
    Wait(1000)

    ClearTimecycleModifier()
    ResetScenarioTypesEnabled()
	StopGameplayCamShaking()
    ResetPedMovementClipset(playerPed, 0)
    SetPedIsDrunk(playerPed, false)
    SetPedMotionBlur(playerPed, false)

    DoScreenFadeIn(800)
    
  end)

end

AddEventHandler('8775fded-dc97-4658-a3f2-1a1e4787535d', function(status)

  TriggerEvent('b9b1be21-5482-41d7-bd83-71d4f8e32d8f', 'drunk', 0, '#8F15A5', 
    function(status)
      if status.val > 0 then
        return true
      else
        return false
      end
    end,
    function(status)
      status.remove(10000)
    end
  )

	Citizen.CreateThread(function()

		while true do

			Wait(10000)

			TriggerEvent('96cc2e86-0b6a-4092-b5c5-9d8057130449', 'drunk', function(status)
				
			if status.val > 0 then
							
				  local start = true

				  if IsAlreadyDrunk then
					start = false
				  end

				  local level = 0

				  if status.val <= 250000 then
					level = 0
				  elseif status.val <= 500000 then
					level = 1
				  else
					level = 2
				  end

				  if level ~= DrunkLevel then
					Drunk(level, start)
				  end

				  IsAlreadyDrunk = true
				  DrunkLevel     = level
			end

			  if status.val == 0 then
			  
				  if IsAlreadyDrunk then
					Reality()
				  end

				  IsAlreadyDrunk = false
				  DrunkLevel     = -1

			 end

			end)

		end

	end)

end)

RegisterNetEvent('45e3f0c5-c4d4-4d9c-988e-6781bb46ffa2')
AddEventHandler('45e3f0c5-c4d4-4d9c-988e-6781bb46ffa2', function()
  
  local playerPed = GetPlayerPed(-1)
  
  TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_DRINKING", 0, 1)
  Citizen.Wait(1000)
  ClearPedTasksImmediately(playerPed)

end)