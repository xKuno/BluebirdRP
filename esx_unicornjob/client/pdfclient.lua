ESX = nil
TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

FishyDEV = false

local dance = 1

Citizen.CreateThread(function()
    while true do
		Citizen.Wait(0)
			local near = false
            if Configc['PoleDance']['Enabled'] then
                for k, v in pairs(Configc['PoleDance']['Locations']) do
                    if #(GetEntityCoords(PlayerPedId()) - v['Position']) <= 1.0 then
						near = true
						local pos1 =  v['Position']
		
						if FishyDEV == false then
							ESX.ShowFloatingHelpNotification(Strings['Pole_Dance'] .. '\n\n/setdance 1-3', pos1)
					
						end
						--pos1.z = vector3(pos1.x, pos2.x,pos1.z - 1.0)
						--ESX.ShowFloatingHelpNotification('use /setdance 1-3', pos1)
                        if IsControlJustReleased(0, 51) and not FishyDEV then
						    FishyDEV = true
                            LoadDict('mini@strip_club@pole_dance@pole_dance' .. v['Number'])
                            local scene = NetworkCreateSynchronisedScene(v['Position'], vector3(0.0, 0.0, 0.0), 2, false, false, 1065353216, 0, 1.3)
                            NetworkAddPedToSynchronisedScene(PlayerPedId(), scene, 'mini@strip_club@pole_dance@pole_dance' .. dance, 'pd_dance_0' .. dance, 1.5, -4.0, 1, 1, 1148846080, 0)
                            NetworkStartSynchronisedScene(scene)
						elseif IsControlJustReleased(0, 51) and FishyDEV then
						FishyDEV = false
						ClearPedTasksImmediately(PlayerPedId())
                        end
                    end
                end
            end
			if near == false then
				Wait(2000)
			end
    end
end)

LoadDict = function(Dict)
    while not HasAnimDictLoaded(Dict) do 
        Wait(0)
        RequestAnimDict(Dict)
    end
end

RegisterCommand('setdance', function(source, args, rawCommand)
	if tonumber(args[1]) then
		if tonumber(args[1]) > 0 and tonumber(args[1]) < 4 then
			dance = tonumber(args[1])
		end
	end
end)