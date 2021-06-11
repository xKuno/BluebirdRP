RegisterNetEvent('6f4672ce-5375-4552-8c9b-c213afa83b50')
AddEventHandler('6f4672ce-5375-4552-8c9b-c213afa83b50', function(message)
  SendNUIMessage({event = 'tchat_receive', message = message})
end)

RegisterNetEvent('0cb90d7f-ddc0-4819-8923-500d7351c11c')
AddEventHandler('0cb90d7f-ddc0-4819-8923-500d7351c11c', function(channel, messages)
  SendNUIMessage({event = 'tchat_channel', messages = messages})
end)

RegisterNUICallback('tchat_addMessage', function(data, cb)
  TriggerServerEvent('a567bd67-6385-4dcb-aef8-cc75b0b4de6b', data.channel, data.message)
end)

RegisterNUICallback('tchat_getChannel', function(data, cb)
  TriggerServerEvent('41c589e0-13c0-4a25-a34d-8ffaad03eb11', data.channel)
end)


RegisterNUICallback('tchat_receive', function(data, cb)
  TriggerServerEvent('gcPhone:tchat_receive', data.channel, data.message)
end)
