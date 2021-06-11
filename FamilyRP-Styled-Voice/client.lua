local playerNamesDist = 15
local overarch = {}
local citwait = 10

Citizen.CreateThread(function()
    while true do
		if #overarch == 0 then
			citwait = 250
		else
			for i=1, #overarch, 1 do
				ped = GetPlayerPed(overarch[i])
				--	myped =  GetPlayerPed( -1 )
				--x1, y1, z1 = table.unpack( GetEntityCoords( myped, true ) )
                x2, y2, z2 = table.unpack( GetEntityCoords( ped, true ) )
				
				--distance = math.floor(GetDistanceBetweenCoords(x1,  y1,  z1,  x2,  y2,  z2,  true))
				local takeaway = 0.95
				
		
				DrawMarker(25,x2,y2,z2 - takeaway, 0, 0, 0, 0, 0, 0, 1.0, 1.0, 10.3, 55, 160, 205, 40, 0, 0, 2, 0, 0, 0, 0)
			end

			citwait = 1
		end
			
        Citizen.Wait(citwait)
    end
end)


Citizen.CreateThread(function()
	

    while true do
		local typea = {}
		local myped =  GetPlayerPed(-1)
        for _, id in ipairs(GetActivePlayers()) do
		
             --and GetPlayerPed( id ) ~= GetPlayerPed( -1 )) 
                ped = GetPlayerPed( id )
				
                local c1 = GetEntityCoords( myped, true )
                local c2 = GetEntityCoords( ped, true ) 
                distance = math.floor(#(c1-c2))
				local takeaway = 0.95

                if ((distance < playerNamesDist) and IsEntityVisible(ped) ~= myped) then
						if NetworkIsPlayerTalking(id) then
							table.insert(typea,id)
							citwait = 0
						end
                end  
		end

		overarch = typea
        Citizen.Wait(320)
    end
end)
