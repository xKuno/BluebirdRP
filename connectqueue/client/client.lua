Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if NetworkIsSessionStarted() then
			if CanPlayOnline == 0 then
				TriggerServerEvent('2261a5e2-115d-44e1-a48d-3e58b74180be', 0)
			else
				TriggerServerEvent('2261a5e2-115d-44e1-a48d-3e58b74180be', 1)
			end
			return
		end
	end
end)


RegisterNetEvent('c43d2526-14b9-48ad-83f5-7d868619d6e9')
AddEventHandler('c43d2526-14b9-48ad-83f5-7d868619d6e9', function()
	TriggerServerEvent('f7678d3b-1852-421a-bfd2-4b5474b46ec2')
	--Button Press
	--TriggerServerEvent('db0ecf65-a24f-44c4-8be7-78b672d63764', getHandle(), GetPlayerServerId(closePlayer), closeDistance)
end)