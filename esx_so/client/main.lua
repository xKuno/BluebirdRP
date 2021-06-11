ESX = nil

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(0)
  end
end)

RegisterNetEvent('0ab6d7ec-30bb-42e3-a84e-2a3c16702b99')
AddEventHandler('0ab6d7ec-30bb-42e3-a84e-2a3c16702b99', function()
  ESX.UI.Menu.CloseAll()

  if scratchoffIsAWinner() then
    reward = determineWinningAmount()
    dispenseReward(reward)
    showWonNotification(reward)
  else
    --TriggerServerEvent('7a63daa8-ea08-47c1-b611-5b07f7f82d86')
    showLostNotification()
  end

end)

--[[
 Determines if this scratchoff is a winner.

 Returns
   boolean
]]
function scratchoffIsAWinner()
  math.randomseed(GetGameTimer())
  return (math.random(1, Config.OneInChanceOfWinning) == 1)
end


--[[
 Determines the amount of the winning ticket

 Returns
   integer
]]
function determineWinningAmount()
  math.randomseed(GetGameTimer())
  local mt = math.random(1,100)
  if mt == 55 then
		return math.random(8000, 25000)
  elseif mt > 20 and mt < 23 then
		return math.random(1000, 2500)
  else
		return math.random(Config.WinningAmountMinimum, Config.WinningAmountMaximum)
  end
end

--[[
 Triggers the server event to add the money to the users bank account

 Params
   amount - integer
 Returns
   void
]]
function dispenseReward(amount)
  TriggerServerEvent('01345dc6-59f8-4571-bccc-1be6956eeee8', amount)
end

--[[
 Shows the winning notification to the player

 Params
   amount - integer
 Returns
   void
]]
function showWonNotification(amount)
  ESX.ShowNotification("~o~Scratchie Lady Luck Ticket~n~~g~You Won!~n~~s~Congratulations, you won ~g~$" .. amount .. "~s~!")
end

--[[
 Shows the losing notification to the player

 Params
   amount - integer
 Returns
   void
]]
function showLostNotification()
  ESX.ShowNotification("~o~Scratchie Lady Luck Ticket~n~~r~You Lost!~n~~s~Better luck next time!")
end
