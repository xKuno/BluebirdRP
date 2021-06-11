-- Author: Xinerki (https://forum.fivem.net/t/release-cellphone-camera/43599)


phone = false
phoneId = 0

RegisterNetEvent('edf8083d-f666-45e6-a5de-2e80247a17a2')
AddEventHandler('edf8083d-f666-45e6-a5de-2e80247a17a2', function()
    CreateMobilePhone(1)
	CellCamActivate(true, true)
	phone = true
    PhonePlayOut()
end)


takingf = false

frontCam = false

function CellFrontCamActivate(activate)
	return Citizen.InvokeNative(0x2491A93618B7D838, activate)
end


Citizen.CreateThread(function()
	DestroyMobilePhone()
	while true do
		Citizen.Wait(0)
				
		if IsControlJustPressed(1, 177) and phone == true then -- CLOSE PHONE
			DestroyMobilePhone()
			phone = false
			CellCamActivate(false, false)
			if firstTime == true then 
				firstTime = false 
				Citizen.Wait(2500)
				displayDoneMission = true
			end
		end
		
		if IsControlJustPressed(1, 27) and phone == true then -- SELFIE MODE
			
			frontCam = not frontCam
			CellFrontCamActivate(frontCam)
		end
		
		if IsControlJustReleased(1, 22) and phone == true and takingf == false then -- TAKE.. PIC
			takingf = true
			Citizen.CreateThread(function()
				while takingf == true do
				HideHudComponentThisFrame(7)
				HideHudComponentThisFrame(8)
				HideHudComponentThisFrame(9)
				HideHudComponentThisFrame(6)
				HideHudComponentThisFrame(19)
				HideHudAndRadarThisFrame()
				Wait(0)
				end
			end)
		
			phone = true

			
				exports['screenshot-basic']:requestScreenshotUpload('https://nasfile.myds.me:444/camera.php', 'files', function(data)
					  local limit =  255
					  local text =  'Type your caption'
					  DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", text, "", "", "", limit)
					  while (UpdateOnscreenKeyboard() == 0) do
						  DisableAllControlActions(0);
						  Wait(0);
					  end
					  if (GetOnscreenKeyboardResult()) then
						  text = GetOnscreenKeyboardResult()
					  end
		
					if text ~= "cancel" and text ~= "CANCEL" and text ~= "Type your caption" then
						TriggerServerEvent('82625481-5a4f-4f8b-8d0f-b77f87880a9a',data,text)
					end
					

					
					
					DestroyMobilePhone()
					phone = false
					CellCamActivate(false, false)
					if firstTime == true then 
						firstTime = false 
						Citizen.Wait(2500)
						displayDoneMission = true
					end
					takePhoto = false
					takingf = false
	
				end)
				
		end

	
		
			

		if phone == true then
			HideHudComponentThisFrame(7)
			HideHudComponentThisFrame(8)
			HideHudComponentThisFrame(9)
			HideHudComponentThisFrame(6)
			HideHudComponentThisFrame(19)
			HideHudAndRadarThisFrame()
		end
			
		ren = GetMobilePhoneRenderId()
		SetTextRenderId(ren)
		
		-- Everything rendered inside here will appear on your phone.
		
		SetTextRenderId(1) -- NOTE: 1 is default
	end
end)
