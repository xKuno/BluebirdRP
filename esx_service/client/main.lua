ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

RegisterNetEvent('c0b28d10-fab2-4c71-b886-a313d829791b')
AddEventHandler('c0b28d10-fab2-4c71-b886-a313d829791b', function(notification, target)
	target = GetPlayerFromServerId(target)
	if target == PlayerId() then return end

	local targetPed = GetPlayerPed(target)
	local mugshot, mugshotStr = ESX.Game.GetPedMugshot(targetPed)

	ESX.ShowAdvancedNotification(notification.title, notification.subject, notification.msg, mugshotStr, notification.iconType)
	UnregisterPedheadshot(mugshot)
end)