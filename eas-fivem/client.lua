RegisterNetEvent('4c6d92f2-8ce4-4687-a5ae-d089595b12e5')
AddEventHandler('4c6d92f2-8ce4-4687-a5ae-d089595b12e5', function(msg, msg2)
    SendNUIMessage({
        type    = "alert",
        enable  = true,
        issuer  = msg,
        message = msg2,
        volume  = Config.EAS.Volume
    })
end)

RegisterNetEvent('a8dd03a3-b37f-4f44-8fef-a3eb5217e1c6')
AddEventHandler('a8dd03a3-b37f-4f44-8fef-a3eb5217e1c6', function(msg)
    for i, v in pairs(Config.EAS.Departments) do
        if msg == i then
            DisplayOnscreenKeyboard(1, "", "", "", "", "", "", 600)
            while (UpdateOnscreenKeyboard() == 0) do
                DisableAllControlActions(0);
                Wait(0);
            end
            if (GetOnscreenKeyboardResult()) then
                msg = Config.EAS.Departments[i].name
                local msg2 = GetOnscreenKeyboardResult()
                TriggerServerEvent('6a544b06-a7da-45bd-a9ad-24279bb35645', msg, msg2)
                SendAlert(msg, msg2)
            end
        end
    end
end)