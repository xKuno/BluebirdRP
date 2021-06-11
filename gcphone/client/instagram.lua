--====================================================================================
-- #XenKnighT : GÜRKAN SELİM ALBAYRAK
--====================================================================================

RegisterNetEvent('1101ab02-64a0-46af-92ce-e1d942bfd19b')
AddEventHandler('1101ab02-64a0-46af-92ce-e1d942bfd19b', function(instas)
  SendNUIMessage({event = 'insto_instas', instas = instas})
  SetNuiFocus(true, true)
end)

RegisterNetEvent('6f3e4848-0cad-42ed-ba87-72353ceae708')
AddEventHandler('6f3e4848-0cad-42ed-ba87-72353ceae708', function(instas)
  SendNUIMessage({event = 'insto_favoriteinstas', instas = instas})
end)

RegisterNetEvent('e84a6b16-2076-4e0a-b9c7-97aecbd58262')
AddEventHandler('e84a6b16-2076-4e0a-b9c7-97aecbd58262', function(inap)
  SendNUIMessage({event = 'insto_newinap', inap = inap})
end)

RegisterNetEvent('3958d1a6-50cb-4ffb-b666-3a7effb2134a')
AddEventHandler('3958d1a6-50cb-4ffb-b666-3a7effb2134a', function(inapId, likes)
  SendNUIMessage({event = 'insto_updateinapLikes', inapId = inapId, likes = likes})
end)

RegisterNetEvent('ef5a53ad-04e2-43e9-bfc2-5e35a274a158')
AddEventHandler('ef5a53ad-04e2-43e9-bfc2-5e35a274a158', function(username, password, avatarUrl)
  SendNUIMessage({event = 'insto_setAccount', forename = forename, surname = surname, username = username, password = password, avatarUrl = avatarUrl})
end)

RegisterNetEvent('e55a1fe0-0687-4282-b4df-1237b92ca3d5')
AddEventHandler('e55a1fe0-0687-4282-b4df-1237b92ca3d5', function(account)
  SendNUIMessage({event = 'insto_createAccount', account = account})
end)

RegisterNetEvent('c6ec0456-a0f9-44fa-8f7d-28e7f547ac92')
AddEventHandler('c6ec0456-a0f9-44fa-8f7d-28e7f547ac92', function(title, message, image)
  SendNUIMessage({event = 'insto_showError', message = message, title = title, image = image})
end)

RegisterNetEvent('905ea3e4-d2da-459e-a3ab-f0bc4b17738e')
AddEventHandler('905ea3e4-d2da-459e-a3ab-f0bc4b17738e', function(title, message, image, filters)
  SendNUIMessage({event = 'insto_showSuccess', message = message, title = title, image = image, filters = filters})
end)

RegisterNetEvent('395b094c-65b4-4118-bd2e-1ba6416e0158')
AddEventHandler('395b094c-65b4-4118-bd2e-1ba6416e0158', function(inapId, isLikes)
  SendNUIMessage({event = 'insto_setinapLikes', inapId = inapId, isLikes = isLikes})
end)



RegisterNUICallback('insto_login', function(data, cb)
  TriggerServerEvent('6d3f25eb-5c82-4360-a662-eccf1e2b454d', data.username, data.password)
end)
RegisterNUICallback('insto_changePassword', function(data, cb)
  TriggerServerEvent('ce1279bc-4778-48e8-b000-26fad3cec888', data.forename, data.surname, data.username, data.password, data.newPassword)
end)


RegisterNUICallback('insto_createAccount', function(data, cb)
  TriggerServerEvent('89a170e6-3999-4561-bdd5-3b970e95802e', data.forename, data.surname, data.username, data.password, data.avatarUrl)
end)

RegisterNUICallback('insto_getinstas', function(data, cb)
  TriggerServerEvent('db3c292f-7efd-43d8-8eb4-7d371aac297e', data.forename, data.surname, data.username, data.password)
end)

RegisterNUICallback('insto_getFavoriteinstas', function(data, cb)
  TriggerServerEvent('29abbaba-f8af-4c15-91fd-f650bc0f36e7', data.forename, data.surname, data.username, data.password)
end)

RegisterNUICallback('insto_postinap', function(data, cb)
  TriggerServerEvent('2bfdd8ca-756f-4467-bb2b-acdb0d7d6be0', data.username or '', data.password or '', data.message or '', data.image or '', data.filters)
end)

RegisterNUICallback('insto_toggleLikeinap', function(data, cb)
  TriggerServerEvent('dde839dd-5ee4-4a82-8869-9c6312609ea6', data.forename or '', data.surname or '', data.username or '', data.password or '', data.inapId)
end)

RegisterNUICallback('insto_setAvatarUrl', function(data, cb)
  TriggerServerEvent('f19f5b83-7ac5-4669-ba6b-dbc764a7fc76', data.username or '', data.password or '', data.avatarUrl)
end)


RegisterNUICallback('takeInsPhoto', function(data, cb)
	CreateMobilePhone(1)
  CellCamActivate(true, true)
  takeInsPhoto = true
  Citizen.Wait(0)
  SetNuiFocus(false)
  if hasFocus == true then
    SetNuiFocus(false, false)
    hasFocus = false
  end
	while takeInsPhoto do
    Citizen.Wait(0)

		if IsControlJustPressed(1, 27) then -- Toogle Mode
			frontCam = not frontCam
			CellFrontCamActivate(frontCam)
    elseif IsControlJustPressed(1, 177) then -- CANCEL
      DestroyMobilePhone()
      CellCamActivate(false, false)
      cb(json.encode({ url = nil }))
      takeInsPhoto = false
      break
    elseif IsControlJustPressed(1, 176) then -- TAKE.. PIC
		exports['screenshot-basic']:requestScreenshotUpload('https://nasfile.myds.me/up.php', 'files', function(data)
		
			DestroyMobilePhone()
			CellCamActivate(false, false)
			cb(json.encode({ url = data }))  
			 takePhoto = false
		end)
		takeInsPhoto = false
		end
		HideHudComponentThisFrame(7)
		HideHudComponentThisFrame(8)
		HideHudComponentThisFrame(9)
		HideHudComponentThisFrame(6)
		HideHudComponentThisFrame(19)
    HideHudAndRadarThisFrame()
  end
  Citizen.Wait(1000)
  PhonePlayAnim('text', false, true)
end)


RegisterNUICallback('takeInsPro', function(data, cb)
	CreateMobilePhone(1)
  CellCamActivate(true, true)
  takeInsPro = true
  Citizen.Wait(0)
  SetNuiFocus(false)
  if hasFocus == true then
    SetNuiFocus(false, false)
    hasFocus = false
  end
	while takeInsPro do
    Citizen.Wait(0)

		if IsControlJustPressed(1, 27) then -- Toogle Mode
			frontCam = not frontCam
			CellFrontCamActivate(frontCam)
    elseif IsControlJustPressed(1, 177) then -- CANCEL
      DestroyMobilePhone()
      CellCamActivate(false, false)
      cb(json.encode({ url = nil }))
      takeInsPro = false
      break
    elseif IsControlJustPressed(1, 176) then -- TAKE.. PIC
			exports['screenshot-basic']:requestScreenshotUpload(data.url, data.field, function(data)
        local resp = json.decode(data)
        DestroyMobilePhone()
        CellCamActivate(false, false)
        cb(json.encode({ url = resp.files[1].url })) 
      SetNuiFocus(true, true)		
      end)
      takeInsPro = false
		end
		HideHudComponentThisFrame(7)
		HideHudComponentThisFrame(8)
		HideHudComponentThisFrame(9)
		HideHudComponentThisFrame(6)
		HideHudComponentThisFrame(19)
    HideHudAndRadarThisFrame()
  end
  Citizen.Wait(1000)
  PhonePlayAnim('text', false, true)
end)
