
-- Change this to your server name
local servername = "Welcome to Blue~w~Bird~b~RP! <3"

local menuEnabled = false
local commandopen = false

	
RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(xPlayer)
	print('player loaded xxxx')
	Citizen.CreateThread(function()
	Wait(10000)
	print('server trigger called')
		TriggerServerEvent('12452488-24f8-4b5b-88a2-51d5bea31aa9',false)
	end)
end)

RegisterNetEvent('77595f7c-5b83-424a-98dc-36274ea30a0c')
AddEventHandler('77595f7c-5b83-424a-98dc-36274ea30a0c', function(commando)
	commandopen = commando
		--
	
		SetNuiFocus( true, true ) 
		SendNUIMessage({
			showPlayerMenu = true 
		})
end)

RegisterNetEvent('87c15702-fb6a-4dc6-b868-f7565f7cde3d')
AddEventHandler('87c15702-fb6a-4dc6-b868-f7565f7cde3d', function()
	killTutorialMenu() 
	TriggerServerEvent('a2d04cfc-c68c-4726-a28d-586c34a52dcf', tostring(GetPlayerServerId(PlayerId())))

end)

RegisterNetEvent('4c8889c5-d28b-481d-beac-129f922d0177')
AddEventHandler('4c8889c5-d28b-481d-beac-129f922d0177', function()

	--TriggerEvent('5ad0c096-c37d-4d48-b3e1-71ec3994aec5')

end)



function ToggleActionMenu()
	Citizen.Trace("tutorial launch")
	menuEnabled = not menuEnabled
	if ( menuEnabled ) then 
		SetNuiFocus( true, true ) 
		SendNUIMessage({
			showPlayerMenu = true 
		})
	else 
		SetNuiFocus( false )
		SendNUIMessage({
			showPlayerMenu = false
		})
	end 
end 

function killTutorialMenu() 
SetNuiFocus( false )
		SendNUIMessage({
			showPlayerMenu = false
		})
		menuEnabled = false

end



RegisterNUICallback('close', function(data, cb)  
  ToggleActionMenu()
  cb('ok')
end)


RegisterNUICallback('spawnButton', function(data, cb) 

	if commano == false then
		TriggerEvent('ee3ad84a-3183-4fc9-ac10-9c149304c24f', source)
	end
	SetNotificationTextEntry("STRING")
  AddTextComponentString("~w~Welcome to ~b~".. servername .."~w~!")
  DrawNotification(true, false)
  	ToggleActionMenu()
  	SetNuiFocus( false )
		SendNUIMessage({
			showPlayerMenu = false
		})
		
		TriggerServerEvent('12452488-24f8-4b5b-88a2-51d5bea31aa9',true)
	menuEnabled = false
	Citizen.Wait(100)
	SetNuiFocus( false )
  	cb('ok')
end)




