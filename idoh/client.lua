local showPlayerBlips = false
local ignorePlayerNameDistance = false
local playerNamesDist = 30
local displayIDHeight = 1.5 --Height of ID above players head(starts at center body mass)
local toggled  = false
--Set Default Values for Colors
local red = 255
local green = 255
local blue = 255

local timera = 0
local group = 'user'

function DrawText3D(x,y,z, text) 
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
    local scale = (1/dist)*3
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov
    
    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(0)
        SetTextProportional(1)
        SetTextColour(red, green, blue, 255)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(1)
        AddTextComponentString(text)
		World3dToScreen2d(x,y,z, 0) --Added Here
        DrawText(_x,_y)
    end
end

Citizen.CreateThread(function()
    while true do
	
	--[[
        for i=0,99 do
            N_0x31698aa80e0223f8(i)
        end--]]
		if	toggled then
			for _, id in ipairs(GetActivePlayers()) do
				if  GetPlayerPed( id ) ~= GetPlayerPed( -1 ) then
					ped = GetPlayerPed( id )
					blip = GetBlipFromEntity( ped ) 
	 
					x1, y1, z1 = table.unpack( GetEntityCoords( GetPlayerPed( -1 ), true ) )
					x2, y2, z2 = table.unpack( GetEntityCoords( GetPlayerPed( id ), true ) )
					distance = math.floor(Vdist2(x1,  y1,  z1,  x2,  y2,  z2))
				
					if(ignorePlayerNameDistance) then
						if NetworkIsPlayerTalking(id) then
							red = 0
							green = 0
							blue = 255

							
						else
							red = 255
							green = 255
							blue = 255
							
						end
						
						local vehicle = GetVehiclePedIsUsing(ped)
						if vehicle > 0 then
							if ped == GetPedInVehicleSeat(vehicle,-1) then
								DrawText3D(x2, y2, z2 + 0.6 + displayIDHeight, GetPlayerServerId(id) .. ' | [D] ' .. GetPlayerName(id))
							elseif ped ==  GetPedInVehicleSeat(vehicle,0) then
								DrawText3D(x2, y2, z2 + 0.4 + displayIDHeight, GetPlayerServerId(id) .. ' | [F] ' .. GetPlayerName(id))
							elseif ped == GetPedInVehicleSeat(vehicle,1) then
								DrawText3D(x2, y2, z2 + 0.2 + displayIDHeight, GetPlayerServerId(id) .. ' | [BL] ' .. GetPlayerName(id))
							elseif ped ==  GetPedInVehicleSeat(vehicle,2) then
								DrawText3D(x2, y2, z2 + 0.0 + displayIDHeight, GetPlayerServerId(id) .. ' | [BR] ' .. GetPlayerName(id))
							end
						else
							DrawText3D(x2, y2, z2 + displayIDHeight, GetPlayerServerId(id) .. ' | ' .. GetPlayerName(id))
						end
						
						
						
						
					elseif (distance < playerNamesDist) and toggled and IsEntityVisible(ped) then
					  
							if NetworkIsPlayerTalking(id) then
								red = 0
								green = 0
								blue = 255
			
							else
								red = 255
								green = 255
								blue = 255
							
							end
					  
							local vehicle = GetVehiclePedIsUsing(ped)
							if vehicle > 0 then
								if ped == GetPedInVehicleSeat(vehicle,-1) then
									DrawText3D(x2, y2, z2 + 0.6 + displayIDHeight, GetPlayerServerId(id) .. ' | [D] ')
								elseif ped ==  GetPedInVehicleSeat(vehicle,0) then
									DrawText3D(x2, y2, z2 + 0.4 + displayIDHeight, GetPlayerServerId(id) .. ' | [F] ')
								elseif ped == GetPedInVehicleSeat(vehicle,1) then
									DrawText3D(x2, y2, z2 + 0.2 + displayIDHeight, GetPlayerServerId(id) .. ' | [BL]')
								elseif ped ==  GetPedInVehicleSeat(vehicle,2) then
									DrawText3D(x2, y2, z2 + 0.0 + displayIDHeight, GetPlayerServerId(id) .. ' | [BR] ')
								end
							else
								DrawText3D(x2, y2, z2 + displayIDHeight, GetPlayerServerId(id))
							end
						
					  
					end  
				end
			end
		else
			Citizen.Wait(1000)
		end
        Citizen.Wait(0)
    end
end)



RegisterNetEvent('9f179364-8278-4c8c-97d2-298e0c847c89')
AddEventHandler('9f179364-8278-4c8c-97d2-298e0c847c89', function(gpriv)
	print('god received')
	group = gpriv
	if toggled == true then
		toggled = false
		ignorePlayerNameDistance = false
	else
		toggled = true
		ignorePlayerNameDistance = true
		
		if gpriv == 'guide' then
			Citizen.CreateThread(function()
				Wait(60000)
				toggled = false
			end)
		end
	end
end)



RegisterNetEvent('a4c0f024-9937-455a-a61b-f0b915fb1987')
AddEventHandler('a4c0f024-9937-455a-a61b-f0b915fb1987', function()
		print('user received')
	if toggled == false then
		toggled = true
		Citizen.CreateThread(function()
			Wait(60000)
			toggled = false

		end)
	else
		toggled = false
		
	end
end)

