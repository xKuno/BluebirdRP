RegisterNetEvent('7c3cd234-ed97-4c8b-b08b-8c77ce78ce18')
AddEventHandler('7c3cd234-ed97-4c8b-b08b-8c77ce78ce18', function(tPID, names2)
		SetNotificationTextEntry("STRING")
		AddTextComponentString("Your Message was sent!")
		SetNotificationMessage("CHAR_DEFAULT", "CHAR_DEFAULT", true, 1, "Message to: ".. names2 .." [".. tPID .."]", "")
		DrawNotification(true, true)
end)

RegisterNetEvent('10edfc63-5d80-47fc-8286-25a00b16d533')
AddEventHandler('10edfc63-5d80-47fc-8286-25a00b16d533', function(source, textmsg, names2, names3 )
		textData.hasRecievedMessage = true
		textData.lastPlayerMessage = textmsg
		textData.lastPlayermessageRecieved = source
		textData.lastMessagenames2 = names3
		SetNotificationTextEntry("STRING")
		AddTextComponentString(textmsg)
		SetNotificationMessage("CHAR_DEFAULT", "CHAR_DEFAULT", true, 1, "Message From: ".. names3 .." [".. source .."]", "")
		DrawNotification(true, true)
end)

RegisterNetEvent('63a83246-805c-4ce9-bb60-6211c831a665')
AddEventHandler('63a83246-805c-4ce9-bb60-6211c831a665', function()
		local textmsg = textData.lastPlayerMessage
		local ply = textData.lastPlayermessageRecieved
		local names3 = textData.lastMessagenames2
		SetNotificationTextEntry("STRING")
		AddTextComponentString(textmsg)
		SetNotificationMessage("CHAR_DEFAULT", "CHAR_DEFAULT", true, 1, "Message From: ".. names3 .." [" .. tostring(ply) .. "]", "")
		DrawNotification(true, true)
end)