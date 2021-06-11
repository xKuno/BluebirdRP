RegisterNetEvent('04af8740-d692-4211-8e91-32e06be39191')
AddEventHandler('04af8740-d692-4211-8e91-32e06be39191', function(data)
	DoHudText(data.type, data.text)
end)

function DoShortHudText(type, text)
	SendNUIMessage({
		action = 'shortnotif',
		type = type,
		text = text,
		length = 1000
	})
end

function DoHudText(type, text)
	SendNUIMessage({
		action = 'notif',
		type = type,
		text = text,
		length = 2500
	})
end
function SendAlert(type, text)
	SendNUIMessage({
		action = 'notif',
		type = type,
		text = text,
		length = 2500
	})
end

function SendLongAlert(type, text)
	SendNUIMessage({
		action = 'notif',
		type = type,
		text = text,
		length = 6000
	})
end

function DoLongHudText(type, text)
	SendNUIMessage({
		action = 'longnotif',
		type = type,
		text = text,
		length = 6000
	})
end

function DoCustomHudText(type, text, length)
	SendNUIMessage({
		action = 'customnotif',
		type = type,
		text = text,
		length = length
	})
end
