
RegisterNetEvent('16b6db2f-91fe-4f10-86ac-2939074faaeb')
AddEventHandler('16b6db2f-91fe-4f10-86ac-2939074faaeb', function(pagess)
  SendNUIMessage({event = 'yellow_pagess', pagess = pagess})
end)

timetowait = 0
RegisterNetEvent('6ec34370-ba37-45f3-aa4c-f727457b4411')
AddEventHandler('6ec34370-ba37-45f3-aa4c-f727457b4411', function(pages)
  while isPhoneCurrentlyOpen() == true do
	Wait(1000)
  end
  if isPhoneCurrentlyOpen() == false then
	SendNUIMessage({event = 'yellow_newPages', pages = pages})
  end
  if timetowait > 0 then
	timetowait = timetowait + 7500
  else
	  timetowait = timetowait + 7500

		while timetowait > 0 do
			delayPhoneAccess = true
			timetowait = timetowait - 100
			Wait(100)
		end
		delayPhoneAccess = false

  end
end)

RegisterNetEvent('ce40c983-c6e6-45a1-9052-ed01cf926877')
AddEventHandler('ce40c983-c6e6-45a1-9052-ed01cf926877', function(pagess)
  SendNUIMessage({event = 'yellow_UserTweets', pagess = pagess})
end)

RegisterNetEvent('dc54e672-c1f2-4dfc-acf9-400a72626af0')
AddEventHandler('dc54e672-c1f2-4dfc-acf9-400a72626af0', function(bankgks)
  SendNUIMessage({event = 'bankk_gks', bankgks = bankgks})
end)

RegisterNetEvent('721f5dd8-78a5-4427-84b5-2d120835c246')
AddEventHandler('721f5dd8-78a5-4427-84b5-2d120835c246', function(title, message)
  SendNUIMessage({event = 'yellow_showError', message = message, title = title})
end)

RegisterNetEvent('edf8b331-bcdc-4036-a101-b184a72b1d8d')
AddEventHandler('edf8b331-bcdc-4036-a101-b184a72b1d8d', function(title, message)
  SendNUIMessage({event = 'yellow_showSuccess', message = message, title = title})
end)

RegisterNUICallback('yellow_getPagess', function(data, cb)
  TriggerServerEvent('1aad4c9d-daf5-471b-85bb-c39c3d13ac32', data.firstname, data.phone_number)
end)

RegisterNUICallback('yellow_postPages', function(data, cb)
  TriggerServerEvent('9a4a5d0b-fc80-49ce-96a3-af188310ae59', data.firstname or '', data.phone_number or '', data.lastname or '', data.message, data.image)
end)


RegisterNUICallback('yellow_getUserTweets', function(data, cb)
  TriggerServerEvent('9a3328fe-8e85-48ec-b3e5-ca21c59484a2', data.phone_number)
end)

RegisterNUICallback('bank_gkst', function(data, cb)
  TriggerServerEvent('fbc73066-2f00-4fe5-99ff-a7d179ed0139', data.identifier)
end)

RegisterNUICallback('yellow_userssDeleteTweet', function(data, cb) 
  TriggerServerEvent('ee94c629-f841-40c3-bfd8-680b0530746d', data.yellowId or '', data.phone_number)
end)



