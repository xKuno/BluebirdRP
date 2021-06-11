local ESX, selectedspawnposition = nil
local orignalspawn = nil
local homespawn = nil

local pendingspawn = false
local spawnedyet = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) 
			ESX = obj 
		end)

		Citizen.Wait(0)
	end
end)

function stillinhomescreen()
	if pendingspawn == false or spawnedyet == false then
		return true
	else
		return false
	end
end

function monitoringstatus()
	if pendingspawn == false and spawnedyet == false then
		return true
	elseif pendingspawn == true and spawnedyet == false then
		return false
	else
		return true
	end
end

RegisterNUICallback("SpawnPlayer", function()
	if selectedspawnposition ~= nil then
		SpawnPlayer(selectedspawnposition)
		spawnedyet = true
	else
	    selectedspawnposition = { x = orignalspawn.x, y = orignalspawn.y, z = orignalspawn.z, h = 180.0 }

		local playerPed = PlayerPedId()
		SetEntityVisible(playerPed, false, 0)
		SetEntityCoords(playerPed, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z)
		FreezeEntityPosition(playerPed, true)

		startcam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
		SetCamCoord(startcam, -505.09, -1224.11, 232.2)
		SetCamActive(startcam, true)
		PointCamAtCoord(startcam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+200)

		cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
		SetCamCoord(cam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+200)
		PointCamAtCoord(cam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+2)
		SetCamActiveWithInterp(cam, startcam, 3700, true, true)
		Citizen.Wait(3700)

		cam2 = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
		SetCamCoord(cam2, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+1)
		PointCamAtCoord(cam2, selectedspawnposition.x+10, selectedspawnposition.y, selectedspawnposition.z)
		SetCamActiveWithInterp(cam2, cam, 900, true, true)
		SpawnPlayer(selectedspawnposition)
		print("You need to select a spawn point!")
		spawnedyet = true
		-- Send a message to client here that they need to select a spawnpoint to be able to spawn.
	end
end)

RegisterNUICallback("SpawnAirport", function()
    selectedspawnposition = { x = -1037.74, y = -2738.04, z = 20.1693, h = 282.91 }

    local playerPed = PlayerPedId()
    SetEntityVisible(playerPed, false, 0)
    SetEntityCoords(playerPed, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z)
    FreezeEntityPosition(playerPed, true)

    startcam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(startcam, -505.09, -1224.11, 232.2)
    SetCamActive(startcam, true)
    PointCamAtCoord(startcam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+200)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+200)
    PointCamAtCoord(cam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+2)
    SetCamActiveWithInterp(cam, startcam, 3700, true, true)
    Citizen.Wait(3700)

    cam2 = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam2, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+1)
    PointCamAtCoord(cam2, selectedspawnposition.x+10, selectedspawnposition.y, selectedspawnposition.z)
    SetCamActiveWithInterp(cam2, cam, 900, true, true)
	spawnedyet = true
end)

RegisterNUICallback("SpawnBus", function()
    selectedspawnposition = { x = 454.349, y = -661.036, z = 27.6534, h = 282.91 }

    local playerPed = PlayerPedId()
    SetEntityVisible(playerPed, false, 0)
    SetEntityCoords(playerPed, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z)
    FreezeEntityPosition(playerPed, true)

    startcam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(startcam, -505.09, -1224.11, 232.2)
    SetCamActive(startcam, true)
    PointCamAtCoord(startcam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+200)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+200)
    PointCamAtCoord(cam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+2)
    SetCamActiveWithInterp(cam, startcam, 3700, true, true)
    Citizen.Wait(3700)

    cam2 = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam2, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+1)
    PointCamAtCoord(cam2, selectedspawnposition.x+10, selectedspawnposition.y, selectedspawnposition.z)
    SetCamActiveWithInterp(cam2, cam, 900, true, true)
	spawnedyet = true
end)

RegisterNUICallback("SpawnTrain", function()
    selectedspawnposition = { x = -206.674, y = -1015.1, z = 30.1381, h = 282.91 }

    local playerPed = PlayerPedId()
    SetEntityVisible(playerPed, false, 0)
    SetEntityCoords(playerPed, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z)
    FreezeEntityPosition(playerPed, true)

    startcam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(startcam, -505.09, -1224.11, 232.2)
    SetCamActive(startcam, true)
    PointCamAtCoord(startcam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+200)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+200)
    PointCamAtCoord(cam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+2)
    SetCamActiveWithInterp(cam, startcam, 3700, true, true)
    Citizen.Wait(3700)

    cam2 = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam2, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+1)
    PointCamAtCoord(cam2, selectedspawnposition.x+10, selectedspawnposition.y, selectedspawnposition.z)
    SetCamActiveWithInterp(cam2, cam, 900, true, true)
	spawnedyet = true
end)

RegisterNUICallback("SpawnPaleto", function()
    selectedspawnposition = { x = 107.14, y = 6601.61, z = 32.01, h = 75.0}

    local playerPed = PlayerPedId()
    SetEntityVisible(playerPed, false, 0)
    SetEntityCoords(playerPed, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z)
    FreezeEntityPosition(playerPed, true)

    startcam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(startcam, -505.09, -1224.11, 232.2)
    SetCamActive(startcam, true)
    PointCamAtCoord(startcam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+200)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+200)
    PointCamAtCoord(cam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+2)
    SetCamActiveWithInterp(cam, startcam, 3700, true, true)
    Citizen.Wait(3700)

    cam2 = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam2, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+1)
    PointCamAtCoord(cam2, selectedspawnposition.x+10, selectedspawnposition.y, selectedspawnposition.z)
    SetCamActiveWithInterp(cam2, cam, 900, true, true)
	spawnedyet = true
end)

RegisterNUICallback("SpawnSandy", function()
    selectedspawnposition = { x = 1526.42, y = 3771.66, z = 34.51, h = 192.95 }

    local playerPed = PlayerPedId()
    SetEntityVisible(playerPed, false, 0)
    SetEntityCoords(playerPed, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z)
    FreezeEntityPosition(playerPed, true)

    startcam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(startcam, -505.09, -1224.11, 232.2)
    SetCamActive(startcam, true)
    PointCamAtCoord(startcam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+200)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+200)
    PointCamAtCoord(cam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+2)
    SetCamActiveWithInterp(cam, startcam, 3700, true, true)
    Citizen.Wait(3700)

    cam2 = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam2, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+1)
    PointCamAtCoord(cam2, selectedspawnposition.x+10, selectedspawnposition.y, selectedspawnposition.z)
    SetCamActiveWithInterp(cam2, cam, 900, true, true)
	spawnedyet = true
end)

RegisterNUICallback("SpawnPier", function()
    selectedspawnposition = { x = -1686.61, y = -1068.16, z = 13.1522, h = 282.91 }

    local playerPed = PlayerPedId()
    SetEntityVisible(playerPed, false, 0)
    SetEntityCoords(playerPed, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z)
    FreezeEntityPosition(playerPed, true)

    startcam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(startcam, -505.09, -1224.11, 232.2)
    SetCamActive(startcam, true)
    PointCamAtCoord(startcam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+200)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+200)
    PointCamAtCoord(cam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+2)
    SetCamActiveWithInterp(cam, startcam, 3700, true, true)
    Citizen.Wait(3700)

    cam2 = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam2, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+1)
    PointCamAtCoord(cam2, selectedspawnposition.x+10, selectedspawnposition.y, selectedspawnposition.z)
    SetCamActiveWithInterp(cam2, cam, 900, true, true)
	spawnedyet = true
end)

RegisterNUICallback("SpawnVinewood", function()
    --selectedspawnposition = { x = 328.52, y = -200.65, z = 54.23, h = 156.62 }
	selectedspawnposition = { x = 193.43, y = -38.61, z = 68.52, h = 92.94 }

    local playerPed = PlayerPedId()
    SetEntityVisible(playerPed, false, 0)
    SetEntityCoords(playerPed, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z)
    FreezeEntityPosition(playerPed, true)

    startcam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(startcam, -505.09, -1224.11, 232.2)
    SetCamActive(startcam, true)
    PointCamAtCoord(startcam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+200)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+200)
    PointCamAtCoord(cam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+2)
    SetCamActiveWithInterp(cam, startcam, 3700, true, true)
    Citizen.Wait(3700)

    cam2 = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam2, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+1)
    PointCamAtCoord(cam2, selectedspawnposition.x+10, selectedspawnposition.y, selectedspawnposition.z)
    SetCamActiveWithInterp(cam2, cam, 900, true, true)
	spawnedyet = true
end)

RegisterNUICallback("City", function()
    --selectedspawnposition = { x = 32.27, y = -899.27, z =  30.0, h = 13.95 }
    selectedspawnposition = { x = 407.09, y = -1662.53, z =  29.61, h = 337.49 }

	local playerPed = PlayerPedId()
    SetEntityVisible(playerPed, false, 0)
    SetEntityCoords(playerPed, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z)
    FreezeEntityPosition(playerPed, true)

    startcam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(startcam, -505.09, -1224.11, 232.2)
    SetCamActive(startcam, true)
    PointCamAtCoord(startcam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+200)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+200)
    PointCamAtCoord(cam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+2)
    SetCamActiveWithInterp(cam, startcam, 3700, true, true)
    Citizen.Wait(3700)

    cam2 = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam2, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+1)
    PointCamAtCoord(cam2, selectedspawnposition.x+10, selectedspawnposition.y, selectedspawnposition.z)
    SetCamActiveWithInterp(cam2, cam, 900, true, true)
	spawnedyet = true
end)


RegisterNUICallback("LastLocation", function()
    selectedspawnposition = { x = orignalspawn.x, y = orignalspawn.y, z = orignalspawn.z, h = 180.0 }

    local playerPed = PlayerPedId()
    SetEntityVisible(playerPed, false, 0)
    SetEntityCoords(playerPed, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z)
    FreezeEntityPosition(playerPed, true)

    startcam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(startcam, -505.09, -1224.11, 232.2)
    SetCamActive(startcam, true)
    PointCamAtCoord(startcam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+200)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+200)
    PointCamAtCoord(cam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+2)
    SetCamActiveWithInterp(cam, startcam, 3700, true, true)
    Citizen.Wait(3700)

    cam2 = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam2, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+1)
    PointCamAtCoord(cam2, selectedspawnposition.x+10, selectedspawnposition.y, selectedspawnposition.z)
    SetCamActiveWithInterp(cam2, cam, 900, true, true)
	spawnedyet = true
end)

RegisterNUICallback("Home", function()
    selectedspawnposition = { x = homespawn["x"], y = homespawn["y"], z = homespawn["z"], h = 180.0 }

    local playerPed = PlayerPedId()
    SetEntityVisible(playerPed, false, 0)
    SetEntityCoords(playerPed, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z)
    FreezeEntityPosition(playerPed, true)

    startcam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(startcam, -505.09, -1224.11, 232.2)
    SetCamActive(startcam, true)
    PointCamAtCoord(startcam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+200)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+200)
    PointCamAtCoord(cam, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+2)
    SetCamActiveWithInterp(cam, startcam, 3700, true, true)
    Citizen.Wait(3700)

    cam2 = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamCoord(cam2, selectedspawnposition.x, selectedspawnposition.y, selectedspawnposition.z+1)
    PointCamAtCoord(cam2, selectedspawnposition.x+10, selectedspawnposition.y, selectedspawnposition.z)
    SetCamActiveWithInterp(cam2, cam, 900, true, true)
	spawnedyet = true
end)

SpawnPlayer = function(Location)
	local pos = Location
	SetNuiFocus(false, false)
    SetCamActiveWithInterp(cam, cam2, 3700, true, true)
	--callback("ok")
	Citizen.Wait(0)

	PlaySoundFrontend(-1, "Zoom_In", "DLC_HEIST_PLANNING_BOARD_SOUNDS", 1)
    RenderScriptCams(false, true, 500, true, true)
    PlaySoundFrontend(-1, "CAR_BIKE_WHOOSH", "MP_LOBBY_SOUNDS", 1)
    Citizen.Wait(0)

	SetEntityVisible(PlayerPedId(), true, 0)
	FreezeEntityPosition(PlayerPedId(), false)
    SetPlayerInvisibleLocally(PlayerPedId(), false)
    SetPlayerInvincible(PlayerPedId(), false)
    TriggerServerEvent('ef26c3e7-e134-4cf5-98a2-36ec949884df')
    TriggerEvent('a8b5d9e2-1b5b-4ab1-a608-674a9cf651d0')
    DestroyCam(startcam, false)
    DestroyCam(cam, false)
    DestroyCam(cam2, false)
    Citizen.Wait(0)
    FreezeEntityPosition(GetPlayerPed(-1), false)
	SetEntityCoords(PlayerPedId(), pos.x, pos.y, pos.z)
	exports.spawnmanager:setAutoSpawn(false)
    TriggerEvent('b622b051-3a8b-4113-b667-333305a005b7', source)
	DisplayHud(true)
    DisplayRadar(true)
	TriggerEvent('2e36f88d-4f53-4c92-b71a-fe71920fb9c2',true)
	SetNuiFocus(false, false)
	spawnedyet = true
end

RegisterNetEvent('2feea93a-f3f0-497c-82c8-f3970d2d7798')
AddEventHandler('2feea93a-f3f0-497c-82c8-f3970d2d7798', function(orig,isnew,home)
	pendingspawn = true
	SetNuiFocus(true, true)
	if orig ~= nil then
		orignalspawn = orig
	end
	
	if home ~= nil then
		print(home)
		home = json.decode(home)
		homespawn = home
		SendNUIMessage({
			["Home"] = "ADD_HOME"
		})
	
	end

	SendNUIMessage({
		["Action"] = "OPEN_SPAWNMENU"
	})
	
	Wait(500)
	SetNuiFocus(true, true)
end)
