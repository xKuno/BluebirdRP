local oocchat = true

local myserverid = GetPlayerServerId(PlayerId())
RegisterNetEvent('3db49612-bbfd-43ce-ab8a-abdccf64eaf2')
AddEventHandler('3db49612-bbfd-43ce-ab8a-abdccf64eaf2', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  	if pid == -1 and id ~= myserverid then

	else
	  if pid == myId then
		TriggerEvent('chatMessage', "^4" .. name .. "", {0, 153, 204}, "^7 " .. message)
	  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
		TriggerEvent('chatMessage', "^4" .. name .. "", {0, 153, 204}, "^7 " .. message)
	  end
	end
end)

RegisterNetEvent('03eadb22-4b41-42ca-837f-eeb71a57a7ba')
AddEventHandler('03eadb22-4b41-42ca-837f-eeb71a57a7ba', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  	if pid == -1 and id ~= myserverid then

	else
	  if pid == myId then
		TriggerEvent('chatMessage', "", {255, 0, 0}, " ^6 " .. name .." ".."^6 " .. message)
	  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
		TriggerEvent('chatMessage', "", {255, 0, 0}, " ^6 " .. name .." ".."^6 " .. message)
	  end
	end
end)

RegisterNetEvent('01e95c7f-194f-403b-bb85-0db36579a1fa')
AddEventHandler('01e95c7f-194f-403b-bb85-0db36579a1fa', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
	if pid == -1 and id ~= myserverid then

	else
	  if pid == myId then
		TriggerEvent('chatMessage', "", {255, 0, 0}, " ^0* " .. name .."  ".."^0  " .. message)
	  elseif GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 19.999 then
		TriggerEvent('chatMessage', "", {255, 0, 0}, " ^0* " .. name .."  ".."^0  " .. message)
	  end
	end
end)


RegisterNetEvent('c7feae43-393a-4f60-a339-b77686c341b4')
AddEventHandler('c7feae43-393a-4f60-a339-b77686c341b4', function(value)
	if oocchat then
		oocchat = false
	else
		oocchat = true
	end
	
	if value ~= nil then
		oocchat = value
	end
end)

RegisterNetEvent('b033eafb-b704-47dc-9117-5f5af139a84e')
AddEventHandler('b033eafb-b704-47dc-9117-5f5af139a84e', function(id, name, message)
	if oocchat then
		TriggerEvent('chatMessage', "OOC | " .. "[" ..id .."] " .. name, {128, 128, 128}, message)
	end
end)