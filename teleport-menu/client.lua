POS_actual = 1
PED_hasBeenTeleported = false
local PlayerData              = {}
ESX                           = nil

myPed = GetPlayerPed(-1)
myCurrentCoords = vector3(0,0,0)

Citizen.CreateThread(function ()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(200)
  end
  
  	Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function (xPlayer)
  PlayerData = xPlayer
end)

RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function (job)
  PlayerData.job = job
end)


function teleport(pos)
    local ped = myPed
    Citizen.CreateThread(function()
        PED_hasBeenTeleported = true
        NetworkFadeOutEntity(ped, true, false)
        Citizen.Wait(300)

		if #(vector3(pos.pos.x,pos.pos.y,pos.pos.z) - vector3(-266.17, -2017.67, 30.25))  < 3.0 then
			--Destination Home --Unload
			TriggerEvent(  'unloadareanaipl')
		elseif #(vector3(pos.pos.x,pos.pos.y,pos.pos.z) - vector3(2845.00, -3911.31, 140))  < 3.0 then
			--Destination Arena - Load
			TriggerEvent(  'loadareanaipl')
			while IsIplActive(exports.Ariana:AreanaIPListing()) == false do
				
				Wait(100)
			end
			Wait(500)
		end
		

        
        SetEntityCoords(ped, pos.pos.x, pos.pos.y, pos.pos.z, 1, 0, 0, 1)
        SetEntityHeading(ped, pos.h)
        if #(vector3(pos.pos.x,pos.pos.y,pos.pos.z) - vector3(5984.17, 843.67, 1298.95))  < 3.0 then
			Wait(2000)
end
        NetworkFadeInEntity(ped, 0)

        Citizen.Wait(300)
        PED_hasBeenTeleported = false
    end)
end


local waitcheck = 0

local closelist = {}

Citizen.CreateThread(function()

  while ESX == nil do
    Citizen.Wait(200)
  end
  while true do
	pcall(function()
		myPed = ESX.Game.GetMyPed()
		myCurrentCoords = ESX.Game.GetMyPedLocation()
		Wait(500)
	end)
  end
end)

Citizen.CreateThread(function()
	
	while PlayerData.job == nil do

		Wait(100)
	end
	local nearby = false
    while true do
        Citizen.Wait(0)
		
		pcall(function()
			local znearby = false
			local sleep = 100

			local ped = myPed
			local playerPos = myCurrentCoords
			local closest = 0
			local closelista = {}
			
			if nearby == false then
				sleep = 200
			else
				sleep = 0
			end
			for i,pos in pairs(INTERIORS) do
			
				local distance = #(playerPos - pos.pos)

				if distance < 30.0 then
					znearby = true
					--table.insert(closelista,pos)
					DrawMarker(1, pos.pos.x, pos.pos.y, pos.pos.z-1, 0, 0, 0, 0, 0, 0, 1.0,1.0,0.5, 255,255,255, 200, 0, 0, 2, 0, 0, 0, 0)
					if (distance < 1.2) and (not PED_hasBeenTeleported) then
						POS_actual = pos.id
						
						if not gui_interiors.opened then
							if pos.job == nil then
								gui_interiors_OpenMenu()
							else
								if PlayerData.job.name == pos.job or PlayerData.job.name == 'police' then
									gui_interiors_OpenMenu()
								end
							end
							--gui_interiors_OpenMenu()
						end
					end
				end
				if nearby == false then
					Wait(sleep)
				end
			end
			nearby = znearby
			
			if nearby == false then
				waitcheck = 0
				Wait(4000)
			else
				waitcheck = 0
			end
		end)
    end
end)
