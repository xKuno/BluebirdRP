--====================================================================================
--  Function APP BANK
--====================================================================================

--[[
      Appeller SendNUIMessage({event = 'updateBankbalance', banking = xxxx})
      à la connection & à chaque changement du compte
--]]

-- ES / ESX Implementation
inMenu                      = true
ESX = nil
local bank = 0
local firstname = ''
local lastname = ''

function setBankBalance (value)
      bank = value
      SendNUIMessage({event = 'updateBankbalance', banking = bank})
end

RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(playerData)
      local accounts = playerData.accounts or {}
      for index, account in ipairs(accounts) do 
            if account.name == 'bank' then
                  setBankBalance(account.money)
                  break
            end
      end
end)

RegisterNetEvent('fa7778f1-012c-465f-9fc9-b60bc0062f79')
AddEventHandler('fa7778f1-012c-465f-9fc9-b60bc0062f79', function(account)
      if account.name == 'bank' then
            setBankBalance(account.money)
      end
end)

RegisterNetEvent('cd382093-7e10-4140-8111-f0fcd71d2274')
AddEventHandler('cd382093-7e10-4140-8111-f0fcd71d2274', function(m)
      setBankBalance(bank + m)
end)

RegisterNetEvent('1b699583-f70c-4016-a481-6e164753bf43')
AddEventHandler('1b699583-f70c-4016-a481-6e164753bf43', function(m)
      setBankBalance(bank - m)
end)

RegisterNetEvent('31d6260f-5f9e-4f22-8a6a-5348b4312030')
AddEventHandler('31d6260f-5f9e-4f22-8a6a-5348b4312030', function(bank)
      setBankBalance(bank)
end)



--===============================================
--==         Transfer Event                    ==
--===============================================
RegisterNUICallback('transfer', function(data)
	ESX.ShowNotification("Error: ~b~Phone Banking ~w~is currently unavailable. Please use an atm/bank.")
	--TriggerServerEvent('e539333b-7141-4704-8e72-7c4e0c3a5e09', data.to, data.amountt)
end)

--===============================================
--==             Ad ve Soyad                   ==
--===============================================

RegisterNetEvent('631663b1-16a8-4355-a38f-e303c78a5c19')
AddEventHandler('631663b1-16a8-4355-a38f-e303c78a5c19', function(_firstname)
  firstname = _firstname
  SendNUIMessage({event = 'updateMyFirstname', firstname = firstname})
end)

RegisterNetEvent('3047f22c-aca4-4fa3-98cc-de88117a40c0')
AddEventHandler('3047f22c-aca4-4fa3-98cc-de88117a40c0', function(_lastname)
  lastname = _lastname
  SendNUIMessage({event = 'updateMyListname', lastname = lastname})
end)


RegisterNetEvent('ee4cae70-62a4-481f-b6cf-d97cd6de13f4')
AddEventHandler('ee4cae70-62a4-481f-b6cf-d97cd6de13f4', function(bankkkkk)
  SendNUIMessage({event = 'bank_billingg', bankkkkk = bankkkkk})
end)

RegisterNUICallback('bank_getBilling', function(data, cb)
  TriggerServerEvent('07e345bd-2ed3-46f5-92ec-b6e014aa2d76', data.type, data.price, data.name)
end)



