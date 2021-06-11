
RegisterNetEvent('8d38e0b0-bb72-47b4-afb4-529e72e90827')
AddEventHandler('8d38e0b0-bb72-47b4-afb4-529e72e90827', function(markets)
  SendNUIMessage({event = 'market_Itemm', markets = markets})
end)

RegisterNUICallback('market_getItem', function(data, cb)
  TriggerServerEvent('a5a1e49a-f1de-4ff1-8c76-e7514011794b', data.store, data.item, data.price, data.label)
end)

RegisterNUICallback('buyMarket', function(data)
  TriggerServerEvent('7f92f291-1dbc-42a0-b6f3-d0bfa566bded', data.item, 1, data.price, data.label)
end)



