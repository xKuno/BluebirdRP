local Status = {}

function GetStatusData(minimal)

	local status = {}

	for i=1, #Status, 1 do

		if minimal then

			table.insert(status, {
				name    = Status[i].name,
				val     = Status[i].val,
				percent = (Status[i].val / Config.StatusMax) * 100,
			})

		else

			table.insert(status, {
				name    = Status[i].name,
				val     = Status[i].val,
				color   = Status[i].color,
				visible = Status[i].visible(Status[i]),
				max     = Status[i].max,
				percent = (Status[i].val / Config.StatusMax) * 100,
			})

		end

	end

	return status

end

AddEventHandler('b9b1be21-5482-41d7-bd83-71d4f8e32d8f', function(name, default, color, visible, tickCallback)
	local s = CreateStatus(name, default, color, visible, tickCallback)
	table.insert(Status, s)
end)

RegisterNetEvent('753d63b6-5534-4a50-a8cb-95e26f035078')
AddEventHandler('753d63b6-5534-4a50-a8cb-95e26f035078', function(status)

	for i=1, #Status, 1 do
		for j=1, #status, 1 do
			if Status[i].name == status[j].name then
				Status[i].set(status[j].val)
			end
		end
	end

	Citizen.CreateThread(function()
	  while true do

	  	for i=1, #Status, 1 do
	  		Status[i].onTick()
	  	end

			SendNUIMessage({
				update = true,
				status = GetStatusData()
			})
		TriggerEvent('22a0c878-f5db-47b3-a133-a9d036f18ba0', GetStatusData(true))
	    Citizen.Wait(Config.TickTime)
	  end
	end)

end)

RegisterNetEvent('bae0cb2f-301a-47ca-8ab4-355c43902da8')
AddEventHandler('bae0cb2f-301a-47ca-8ab4-355c43902da8', function(name, val)
	
	for i=1, #Status, 1 do
		if Status[i].name == name then
			Status[i].set(val)
			break
		end
	end

	SendNUIMessage({
		update = true,
		status = GetStatusData()
	})

	TriggerServerEvent('68739e14-a217-4ed4-902f-08e9b1f1fc41', GetStatusData(true))

end)

RegisterNetEvent('76149d80-1f9a-44fb-a564-d0fc99a4a96c')
AddEventHandler('76149d80-1f9a-44fb-a564-d0fc99a4a96c', function(name, val)
	
	for i=1, #Status, 1 do
		if Status[i].name == name then
			Status[i].add(val)
			break
		end
	end

	SendNUIMessage({
		update = true,
		status = GetStatusData()
	})

	TriggerServerEvent('68739e14-a217-4ed4-902f-08e9b1f1fc41', GetStatusData(true))

end)

RegisterNetEvent('c764e3e7-9841-46be-bb01-c8e368d6ebcc')
AddEventHandler('c764e3e7-9841-46be-bb01-c8e368d6ebcc', function(name, val)
	
	for i=1, #Status, 1 do
		if Status[i].name == name then
			Status[i].remove(val)
			break
		end
	end

	SendNUIMessage({
		update = true,
		status = GetStatusData()
	})

	TriggerServerEvent('68739e14-a217-4ed4-902f-08e9b1f1fc41', GetStatusData(true))

end)

AddEventHandler('96cc2e86-0b6a-4092-b5c5-9d8057130449', function(name, cb)
	
	for i=1, #Status, 1 do
		if Status[i].name == name then
			cb(Status[i])
			return
		end
	end

end)

function getStatus(name)
	for i=1, #Status, 1 do
		if Status[i].name == name then
			return Status[i]
		end
	end
end

AddEventHandler('4030be4a-e40b-426f-a9a8-75e22cf35564', function(val)

	SendNUIMessage({
		setDisplay = true,
		display    = val
	})

end)

-- Pause menu disable hud display
local isPaused = false

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(500)
    if IsPauseMenuActive() and not isPaused then
      isPaused = true
     	TriggerEvent('4030be4a-e40b-426f-a9a8-75e22cf35564', 0.0)
    elseif not IsPauseMenuActive() and isPaused then
      isPaused = false 
     	TriggerEvent('4030be4a-e40b-426f-a9a8-75e22cf35564', 0.5)
    end
  end
end)

-- Loaded event
Citizen.CreateThread(function()
	TriggerEvent('8775fded-dc97-4658-a3f2-1a1e4787535d')
end)

-- Update server
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(Config.UpdateInterval)
		TriggerServerEvent('68739e14-a217-4ed4-902f-08e9b1f1fc41', GetStatusData(true))
	end
end)