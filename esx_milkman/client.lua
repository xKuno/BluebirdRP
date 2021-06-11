local Keys = {
	["ESC"] = 322, ["BACKSPACE"] = 177, ["E"] = 38, ["ENTER"] = 18,	["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173
}

ESX                           = nil
local PlayerData                = {}
local menuIsShowed 				 = false
local hasAlreadyEnteredMarker 	 = false
local hasAlreadyEnteredMarkerr 	 = false
local lastZone 					 = nil
local isInJoblistingMarker 		 = false
local isInJoblistingMarkerr 		 = false
local bet = 0
local wtrakcie = false
local model = "prop_bucket_02a"
local bagModel = "prop_bucket_02a"
local bagspawned = nil
local maitem = false
local tekst = 0

local blips = {

	{title="Cows", colour=4, id=141, x = 2438.240, y = 4765.890, z = 35.00},
	{title="Changing room of dairy farmers", colour=4, id=366, x = 2512.990, y = 4762.750, z = 34.90},
	{title="The dairy machine", colour=4, id=402, x = 2502.120, y = 4801.250, z = 43.740}

}

local blips_s = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(5000)
	PlayerData = ESX.GetPlayerData()
	Wait(10500)
	
	for _, info in pairs(blips_s) do
		RemoveBlip(info)
	end
	
	if PlayerData ~= nil and PlayerData.job ~= nil and PlayerData.job.name == 'milkman' then
	   for _, info in pairs(blips) do
		 info.blip = AddBlipForCoord(info.x, info.y, info.z)
		 SetBlipSprite(info.blip, info.id)
		 SetBlipDisplay(info.blip, 4)
		 SetBlipScale(info.blip, 1.0)
		 SetBlipColour(info.blip, info.colour)
		 SetBlipAsShortRange(info.blip, true)
		 BeginTextCommandSetBlipName("STRING")
		 AddTextComponentString(info.title)
		 EndTextCommandSetBlipName(info.blip)
		 table.insert(blips_s,info.blip)
	   end
   end


end)
RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(xPlayer)
  PlayerData = xPlayer
  	for _, info in pairs(blips_s) do
		RemoveBlip(info)
	end
	
	if PlayerData ~= nil and PlayerData.job ~= nil and PlayerData.job.name == 'milkman' then
	   for _, info in pairs(blips) do
		 info.blip = AddBlipForCoord(info.x, info.y, info.z)
		 SetBlipSprite(info.blip, info.id)
		 SetBlipDisplay(info.blip, 4)
		 SetBlipScale(info.blip, 1.0)
		 SetBlipColour(info.blip, info.colour)
		 SetBlipAsShortRange(info.blip, true)
		 BeginTextCommandSetBlipName("STRING")
		 AddTextComponentString(info.title)
		 EndTextCommandSetBlipName(info.blip)
		 table.insert(blips_s,info.blip)
	   end
   end

end)

RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function(job)
	PlayerData.job = job
	
	
	for _, info in pairs(blips_s) do
		RemoveBlip(info)
	end
	Citizen.Wait(2000)
	if PlayerData ~= nil and PlayerData.job ~= nil and PlayerData.job.name == 'milkman' then
	   for _, info in pairs(blips) do
		 info.blip = AddBlipForCoord(info.x, info.y, info.z)
		 SetBlipSprite(info.blip, info.id)
		 SetBlipDisplay(info.blip, 4)
		 SetBlipScale(info.blip, 1.0)
		 SetBlipColour(info.blip, info.colour)
		 SetBlipAsShortRange(info.blip, true)
		 BeginTextCommandSetBlipName("STRING")
		 AddTextComponentString(info.title)
		 EndTextCommandSetBlipName(info.blip)
		 table.insert(blips_s,info.blip)
	   end
   end

end)

Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)
		local coords = GetEntityCoords(GetPlayerPed(-1))

		if (#(coords - vector3(2441.460, 4755.190, 33.70)) < 35.0)  then
		
					ESX.Game.Utils.DrawText3D({ x = 2441.06, y = 4755.05, z = 33.85 }, '~y~[E] ~w~Milk Cow', 0.6)		
					ESX.Game.Utils.DrawText3D({ x = 2443.96, y = 4764.95, z = 33.85 }, '~y~[E] ~w~Milk Cow', 0.6)	
					ESX.Game.Utils.DrawText3D({ x = 2434.870, y = 4764.150, z = 33.80 }, '~y~[E] ~w~Milk Cow', 0.6)				
					ESX.Game.Utils.DrawText3D({ x = 2430.76, y = 4773.95, z = 33.85 }, '~y~[E] ~w~Milk Cow', 0.6)				
			
		else
			Wait(2500)
		end
	end
end)



Citizen.CreateThread(function()
	while true do

		Wait(5)
		local coords      = GetEntityCoords(GetPlayerPed(-1))


		if(#(coords -  vector3(2441.460, 4755.190, 33.70)) < 2.0) or (#(coords - vector3(2443.870, 4764.750, 33.20)) < 2.0) or (#(coords - vector3(2434.870, 4764.150, 33.20)) < 2.0) or (#(coords - vector3(2430.76, 4773.95, 33.85)) < 2.0) then


			local coords      = GetEntityCoords(GetPlayerPed(-1))
			local isInMarker  = false
			local currentZone = nil
			local zaplata = 0


			if PlayerData ~= nil and PlayerData.job ~= nil and PlayerData.job.name == 'milkman' then
				
				if IsControlJustReleased(0, Keys['E']) then

					if wtrakcie == false then
					  zbieranie()
					end
				end
			end
		else
			Wait(2000)
		end -- od getdistance
	end -- od while
end)

function zbieranie()
	TriggerServerEvent('d6e0b0a3-748e-4010-8293-3f22ce58bf22')
	wtrakcie = true
end
RegisterNetEvent('e9750db7-f4d3-41d9-874b-77ed8072d9d9')
AddEventHandler('e9750db7-f4d3-41d9-874b-77ed8072d9d9', function()
	local playerPed = PlayerPedId()
	local coords    = GetEntityCoords(playerPed)
	local forward   = GetEntityForwardVector(playerPed)
	local x, y, z   = table.unpack(coords + forward * 1.0)
if maitem == false then
	ESX.Game.SpawnObject(model, {
		x = x,
		y = y,
		z = z
	}, function(obj)
		SetEntityHeading(obj, GetEntityHeading(playerPed))
		PlaceObjectOnGroundProperly(obj)
		Citizen.Wait(10000)
		DeleteObject(obj)
	end)
end
end)


RegisterNetEvent('005c1c6e-839c-4744-aae8-063b0da5bb5f')
AddEventHandler('005c1c6e-839c-4744-aae8-063b0da5bb5f', function()
	playerPed = PlayerPedId()	
	ClearPedTasks(PlayerPedId())
	FreezeEntityPosition(playerPed, true)
end)
RegisterNetEvent('ddd681ab-24f6-4f55-aa12-8d2398fd9db5')
AddEventHandler('ddd681ab-24f6-4f55-aa12-8d2398fd9db5', function()
	playerPed = PlayerPedId()
	FreezeEntityPosition(playerPed, false)
	ClearPedTasks(PlayerPedId())

	

	TriggerEvent('95bac3d6-b26b-4747-92df-d918159e8a50')
	maitem = true

Citizen.Wait(500)
	wtrakcie = false

end)


RegisterNetEvent('59523407-725f-480a-8d94-b69be2b0cbd6')
AddEventHandler('59523407-725f-480a-8d94-b69be2b0cbd6', function()
	TaskStartScenarioInPlace(PlayerPedId(), "PROP_HUMAN_BUM_BIN", 0, true)
Citizen.Wait(2000)
end)



function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(10)
	end
end
Citizen.CreateThread(function()
  
	RequestModel(`a_c_cow`)
	while not HasModelLoaded(`a_c_cow`) do
		Wait(155)
	end

		local ped =  CreatePed(4, `a_c_cow`, 2441.06, 4755.95, 33.35, -149.404, false, true)
	    FreezeEntityPosition(ped, true)
		SetEntityInvincible(ped, true)
		SetBlockingOfNonTemporaryEvents(ped, true)
		while true do
			Citizen.Wait(10000)
			TaskPedSlideToCoord(ped, 2441.76, 4755.95, 33.45, -149.404, 10)
		end
end)
Citizen.CreateThread(function()

RequestModel(`a_c_cow`)
while not HasModelLoaded(`a_c_cow`) do
	Wait(155)
end

	local ped =  CreatePed(4, `a_c_cow`, 2443.96, 4764.95, 33.35, -349.404, false, true)
	FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	while true do
		Citizen.Wait(10000)
		TaskPedSlideToCoord(ped, 2443.76, 4764.95, 33.45, -349.404, 10)
	end
end)
Citizen.CreateThread(function()

RequestModel(`a_c_cow`)
while not HasModelLoaded(`a_c_cow`) do
	Wait(155)
end

	local ped =  CreatePed(4, `a_c_cow`, 2434.76, 4764.95, 33.35, 149.404, false, true)
	FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	while true do
		Citizen.Wait(10000)
		TaskPedSlideToCoord(ped, 2434.76, 4764.95, 33.45, 749.404, 10)
	end
end)
Citizen.CreateThread(function()

RequestModel(`a_c_cow`)
while not HasModelLoaded(`a_c_cow`) do
	Wait(155)
end

	local ped =  CreatePed(4, `a_c_cow`, 2430.76, 4773.95, 33.45, 749.404, false, true)
	FreezeEntityPosition(ped, true)
	SetEntityInvincible(ped, true)
	SetBlockingOfNonTemporaryEvents(ped, true)
	while true do
		Citizen.Wait(10000)
		TaskPedSlideToCoord(ped, 2430.76, 4773.95, 33.45, 749.404, 10)
	end
end)

Citizen.CreateThread(function()
	while true do

		Wait(5)
		local coords  = GetEntityCoords(GetPlayerPed(-1))


		if(#(coords - vector3(2512.740, 4761.850, 34.90)) < 20.0) or (#(coords - vector3(2500.960, 4800.750, 34.740)) < 5.0) then


			ESX.Game.Utils.DrawText3D({ x = 2512.870, y = 4761.850, z = 34.90 }, '~y~[E] ~w~Cloakroom', 0.6)	
					local coords      = GetEntityCoords(GetPlayerPed(-1))

								local zaplata = 0

								if(#(coords - vector3(2500.960, 4800.750, 34.740)) < 3.0) then
									ESX.ShowAdvancedNotification('Pouring milk', '~y~Farm', '~y~[E] ~w~Pour the milk into the machine', 'CHAR_PROPERTY_SONAR_COLLECTIONS', 3)
										if IsControlJustReleased(0, Keys['E']) then
											  skup()
										end

									end
			

										
										if(#(coords - vector3(2512.740, 4761.850, 34.90)) < 5.0) then
									
											if IsControlJustReleased(0, Keys['E']) then
												
											ubrania()
										end
			
										
								
				end
		else
			Wait(2000)
		end
	end
end)
function ubrania()
	if PlayerData ~= nil and PlayerData.job.name == 'milkman' then
	TriggerEvent('d3bdbe20-bf7d-4df2-9ef6-9026a86a6e87', function(skin)
	
		if skin.tshirt_1 == 15 and skin.torso_1 == 43 then
			ESX.TriggerServerCallback('4568d939-3661-4833-ae6a-378432ac6ff1', function(skin)
				TriggerEvent('56a2ee13-8a49-4ad3-a298-1854493c98ee', skin)
				end)
				
			else
				local clothesSkin = {
					['tshirt_1'] = 15, ['tshirt_2'] = 0,
					['torso_1'] = 43, ['torso_2'] = 0,
					['arms'] = 37, ['arms_2'] = 0,
					['pants_1'] = 27, ['pants_2'] = 3,
					['helmet_1'] = -1,  ['helmet_2'] = 0,
					['shoes_1'] = 4, ['shoes_2'] = 1
					}
					TriggerEvent('1d09cf94-2c53-4220-a089-0339ce8bb123', skin, clothesSkin)
				
		end
	end)
end
end
RegisterNetEvent('95bac3d6-b26b-4747-92df-d918159e8a50')
AddEventHandler('95bac3d6-b26b-4747-92df-d918159e8a50', function()
	local ad = "anim@heists@box_carry@"
	loadAnimDict( ad )
	TaskPlayAnim( PlayerPedId(), ad, "idle", 3.0, -8, -1, 63, 0, 0, 0, 0 )

	local x,y,z = table.unpack(GetEntityCoords(PlayerPedId()))

if maitem == false then
		bagspawned = CreateObject(GetHashKey(bagModel), x, y, z+0.2,  true,  true, true)
		AttachEntityToEntity(bagspawned, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 60309), 0.025, -0.24, 0.355, -75.0, 470.0, 0.0, true, true, false, true, 1, true)
		
end
Citizen.Wait(10000)
end)
RegisterNetEvent('0c1902a4-30f3-4bf8-b971-c1940e998ca3')
AddEventHandler('0c1902a4-30f3-4bf8-b971-c1940e998ca3', function()

	local playerPed = PlayerPedId()
	local lib, anim = 'gestures@m@standing@casual', 'gesture_easy_now'
	FreezeEntityPosition(playerPed, true)
	ESX.Streaming.RequestAnimDict(lib, function()
	TaskPlayAnim(PlayerPedId(), lib, anim, 8.0, -8.0, -1, 0, 0, false, false, false)
end)
end)
function skup()

	TriggerServerEvent('af67b081-eb00-4fe2-b4f1-3919ddf3d5ab')

Citizen.Wait(3500)
	Citizen.Wait(13000)
	FreezeEntityPosition(PlayerPedId(), false)

	wtrakcie = false
end
	
RegisterNetEvent('cc2b5220-ed76-4c84-9349-7202433e156a')
AddEventHandler('cc2b5220-ed76-4c84-9349-7202433e156a', function()
	DetachEntity(bagspawned, 1, 1)
	ClearPedSecondaryTask(PlayerPedId())

end)
RegisterNetEvent('59715bd7-d478-483a-84d8-069eb0ccc5ca')
AddEventHandler('59715bd7-d478-483a-84d8-069eb0ccc5ca', function()
	DeleteObject(bagspawned)

	maitem = false

	FreezeEntityPosition(PlayerPedId(), false)
end)



local UI = { 

	x =  0.000 ,	-- Base Screen Coords 	+ 	 x
	y = -0.001 ,	-- Base Screen Coords 	+ 	-y

}
RegisterNetEvent('53655015-b88f-4921-9b7c-e7aaa9a01748')
AddEventHandler('53655015-b88f-4921-9b7c-e7aaa9a01748', function()
while true do
	Citizen.Wait(1)
	if wtrakcie == true then

	drawTxt(UI.x + 0.9605, UI.y + 0.962, 1.0,0.98,0.4, "~y~[~w~".. tekst .. "%~y~]", 255, 255, 255, 255)

end
end
end)
function drawTxt(x,y ,width,height,scale, text, r,g,b,a)
	SetTextFont(4)
	SetTextProportional(0)
	SetTextScale(scale, scale)
	SetTextColour(r, g, b, a)
	SetTextDropShadow(0, 0, 0, 0,255)
	SetTextEdge(2, 0, 0, 0, 255)
	SetTextDropShadow()
	SetTextOutline()
	SetTextEntry("STRING")
	AddTextComponentString(text)
	DrawText(x - width/2, y - height/2 + 0.005)
end
RegisterNetEvent('d403fae7-b47f-43d0-9e56-893e5e867cdb')
AddEventHandler('d403fae7-b47f-43d0-9e56-893e5e867cdb', function()
wtrakcie = false
end)
RegisterNetEvent('06e3fbfa-37a4-4a5a-a186-b6cf26be6765')
AddEventHandler('06e3fbfa-37a4-4a5a-a186-b6cf26be6765', function()
	Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1
Citizen.Wait(180)
tekst = tekst + 1


Citizen.Wait(2000)
tekst = 0
end)

function loadAnimDict(dict)
	while (not HasAnimDictLoaded(dict)) do
		RequestAnimDict(dict)
		Citizen.Wait(5)
	end
end

