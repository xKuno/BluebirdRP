
RegisterNUICallback('reddit_postChanell', function(data, cb)
  TriggerServerEvent('d4f9c7b4-24cd-4f70-85f9-7440776957a9', data.redgkit)
end)


RegisterNetEvent('7f27bccb-8b69-4bb7-9683-226414ee8c98')
AddEventHandler('7f27bccb-8b69-4bb7-9683-226414ee8c98', function(channnels)
  SendNUIMessage({event = 'reddit_chanells', channnels = channnels})
end)

RegisterNUICallback('reddit_getChanells', function(data, cb)
  TriggerServerEvent('7503f1fb-f34a-4488-99cd-78caeb6d3859', data.redgkit)
end)

RegisterNetEvent('f4895244-6969-46a4-9ee5-b0777736fef7')
AddEventHandler('f4895244-6969-46a4-9ee5-b0777736fef7', function(reditsage)
  SendNUIMessage({event = 'reddit_receive', reditsage = reditsage})
end)

RegisterNetEvent('5897ac89-4ee8-4b4f-9b27-20b4863f87d6')
AddEventHandler('5897ac89-4ee8-4b4f-9b27-20b4863f87d6', function(redgkit, reditsages)
  SendNUIMessage({event = 'reddit_channel', reditsages = reditsages})
end)

RegisterNUICallback('reddit_addMessage', function(data, cb)
  TriggerServerEvent('28297d44-b6c5-43f2-8bac-8b5835adc7bd', data.redgkit, data.reditsage)
end)

RegisterNUICallback('reddit_getChannel', function(data, cb)
  TriggerServerEvent('98c7cd5c-1d94-44f2-a6d5-955ba9c69976', data.redgkit)
end)

