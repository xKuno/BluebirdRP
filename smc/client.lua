---------------------------------------
-- Solo Session Alert, Made by FAXES --
---------------------------------------
-- Starts the checking process
local serverid = GetConvarInt("bb_id", 00)
Citizen.CreateThread(function()
	math.randomseed(GetGameTimer())
	
	Wait(math.random(60000,85000))
	print('checking if in solo')
		
	TriggerServerEvent('6ef0527b-27b3-4437-93ef-78f2a707565b') 
	while true do
		Wait(math.random(60000,90000))
		TriggerServerEvent('258fa4e7-9c74-4e13-8063-1d89343cb909') -- Start solo check via serverProblemSolo
	end
	

end)

RegisterNetEvent('a6c7268e-0d1c-43e6-a104-7bf3a462369d')
AddEventHandler('a6c7268e-0d1c-43e6-a104-7bf3a462369d', function()
	DrawText("You may be in a solo session. Please reconnect.")		
end)


RegisterNetEvent('c6e4226d-32a1-4809-8b8b-54d114b2dbc7')
AddEventHandler('c6e4226d-32a1-4809-8b8b-54d114b2dbc7', function()
	print('playing broken')
	Citizen.CreateThread(function()
		
			TriggerEvent('chatMessage', "^4 ⚠️CAUTION⚠️", {0, 153, 204}, "^3 You have identified as being in a solo session... 😭 no one will be able to interact with you and your vehicles will constantly disconnect. Please leave the rejoin the server.\n\nAnother check will be performed shortly, if that check fails you'll be removed from the server ❤️ ^5BlueBird")
			
			Wait(20000)
			
			TriggerEvent('chatMessage', "^4 ⚠️CAUTION⚠️", {0, 153, 204}, "^3 You have identified as being in a solo session... 😭 no one will be able to interact with you and your vehicles will constantly disconnect. Please leave the rejoin the server.\n\nAnother check will be performed shortly, if that check fails you'll be removed from the server ❤️ ^5BlueBird")
			Wait(20000)
			
			TriggerEvent('chatMessage', "^4 ⚠️CAUTION⚠️", {0, 153, 204}, "^3 You have identified as being in a solo session... 😭 no one will be able to interact with you and your vehicles will constantly disconnect. Please leave the rejoin the server.\n\nAnother check will be performed shortly, if that check fails you'll be removed from the server ❤️ ^5BlueBird")
			
	
	end)

end)

function DrawText(text)
	SetTextFont(0)
	SetTextProportional(1)
	SetTextScale(0.0, 0.45)
	SetTextDropshadow(1, 0, 0, 0, 255)
	SetTextEdge(1, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(0.40, 0.10)
end

