RegisterCommand("jailmenu", function(source, args)

	if PlayerData.job.name == "police" then
		OpenJailMenu()
	else
		ESX.ShowNotification("You are not a police officer!")
	end
end)

function LoadAnim(animDict)
	RequestAnimDict(animDict)

	while not HasAnimDictLoaded(animDict) do
		Citizen.Wait(10)
	end
end

function LoadModel(model)
	RequestModel(model)

	while not HasModelLoaded(model) do
		Citizen.Wait(10)
	end
end

function HideHUDThisFrame()
	HideHelpTextThisFrame()
	HideHudAndRadarThisFrame()
	HideHudComponentThisFrame(1)
	HideHudComponentThisFrame(2)
	HideHudComponentThisFrame(3)
	HideHudComponentThisFrame(4)
	HideHudComponentThisFrame(6)
	HideHudComponentThisFrame(7)
	HideHudComponentThisFrame(8)
	HideHudComponentThisFrame(9)
	HideHudComponentThisFrame(13)
	HideHudComponentThisFrame(11)
	HideHudComponentThisFrame(12)
	HideHudComponentThisFrame(15)
	HideHudComponentThisFrame(18)
	HideHudComponentThisFrame(19)
end

function Cutscene()
	DoScreenFadeOut(100)

	Citizen.Wait(250)

	local hashSkin = GetHashKey ("mp_m_freemode_01")
	clearPed ()
    Wait (500)
    Citizen. CreateThread ( function ()
      if (GetEntityModel(GetPlayerPed(-1)) == hashSkin) then
        SetPedComponentVariation ( GetPlayerPed ( - 1 ), 4 , 7 , 15 , 0 ) 
        SetPedComponentVariation ( GetPlayerPed ( - 1 ), 11 , 5 , 0 , 0 ) 
        SetPedComponentVariation ( GetPlayerPed ( - 1 ), 8 , 15 , 0 , 0 )
        SetPedComponentVariation ( GetPlayerPed ( - 1 ), 3 , 5 , 0 , 0 ) 
        SetPedComponentVariation ( GetPlayerPed ( - 1 ), 6 , 34 , 0 , 0 ) 
        c_options.undershirt  =  0
        c_options.undershirt_txt  =  240
        SetPedComponentVariation ( GetPlayerPed ( - 1 ), 8 , tonumber (c_options.undershirt ), tonumber (c_options. undershirt_txt ), 0 )
      else  
        SetPedComponentVariation ( GetPlayerPed ( - 1 ), 4 , 3 , 15 , 0 ) 
        SetPedComponentVariation ( GetPlayerPed ( - 1 ), 11 , 14 , 6 , 0 ) 
        SetPedComponentVariation ( GetPlayerPed ( - 1 ), 8 , 15 , 0 , 0 ) 
        SetPedComponentVariation ( GetPlayerPed ( - 1 ), 3 , 4 , 0 , 0 )
        SetPedComponentVariation ( GetPlayerPed ( - 1 ), 6 , 5 , 0 , 0 )
        c_options.undershirt  =  0
        c_options.undershirt_txt  =  240
        SetPedComponentVariation ( GetPlayerPed ( - 1 ), 8 , tonumber (c_options. undershirt ), tonumber (c_options. undershirt_txt ), 0 )
      end 
    end )

	LoadModel(-1320879687)

	local PolicePosition = Config.Cutscene["PolicePosition"]
	local Police = CreatePed(5, -1320879687, PolicePosition["x"], PolicePosition["y"], PolicePosition["z"], PolicePosition["h"], false)
	TaskStartScenarioInPlace(Police, "WORLD_HUMAN_PAPARAZZI", 0, false)

	local PlayerPosition = Config.Cutscene["PhotoPosition"]
	local PlayerPed = PlayerPedId()
	SetEntityCoords(PlayerPed, PlayerPosition["x"], PlayerPosition["y"], PlayerPosition["z"] - 1)
	SetEntityHeading(PlayerPed, PlayerPosition["h"])
	FreezeEntityPosition(PlayerPed, true)

	Cam()

	Citizen.Wait(1000)

	DoScreenFadeIn(100)

	Citizen.Wait(10000)

	DoScreenFadeOut(250)

	local JailPosition = Config.JailPositions["Cell"]
	SetEntityCoords(PlayerPed, JailPosition["x"], JailPosition["y"], JailPosition["z"])
	DeleteEntity(Police)
	SetModelAsNoLongerNeeded(-1320879687)

	Citizen.Wait(1000)

	DoScreenFadeIn(250)

	TriggerServerEvent('746ecaaa-70ed-4068-bf6c-5e6e78e9d645', "cell", 0.3)

	RenderScriptCams(false,  false,  0,  true,  true)
	FreezeEntityPosition(PlayerPed, false)
	DestroyCam(Config.Cutscene["CameraPos"]["cameraId"])

	InJail()
end

function Cam()
	local CamOptions = Config.Cutscene["CameraPos"]

	CamOptions["cameraId"] = CreateCam("DEFAULT_SCRIPTED_CAMERA", true)

    SetCamCoord(CamOptions["cameraId"], CamOptions["x"], CamOptions["y"], CamOptions["z"])
	SetCamRot(CamOptions["cameraId"], CamOptions["rotationX"], CamOptions["rotationY"], CamOptions["rotationZ"])

	RenderScriptCams(true, false, 0, true, true)
end

function TeleportPlayer(pos)

	local Values = pos

	if #Values["goal"] > 1 then

		local elements = {}

		for i, v in pairs(Values["goal"]) do
			table.insert(elements, { label = v, value = v })
		end

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'teleport_jail',
			{
				title    = "Choose Position",
				align    = 'center',
				elements = elements
			},
		function(data, menu)

			local action = data.current.value
			local position = Config.Teleports[action]
			if action == "Boling Broke" and jailTime  < 1 then
				ESX.ShowNotification("Thanks for visiting!")
			
			elseif  action == "Security" then

				if PlayerData.job.name ~= "police" then
					ESX.ShowNotification("You don't have a key to go here!")
					return
					
				end
			end

			menu.close()

			DoScreenFadeOut(100)

			Citizen.Wait(250)

			SetEntityCoords(PlayerPedId(), position["x"], position["y"], position["z"])

			Citizen.Wait(250)

			DoScreenFadeIn(100)
			
		end,

		function(data, menu)
			menu.close()
		end)
	else
		local position = Config.Teleports[Values["goal"][1]]

		DoScreenFadeOut(100)

		Citizen.Wait(250)

		SetEntityCoords(PlayerPedId(), position["x"], position["y"], position["z"])

		Citizen.Wait(250)

		DoScreenFadeIn(100)
	end
end

--[[Citizen.CreateThread(function()
	local blip = AddBlipForCoord(Config.Teleports["Prison Exterior"]["x"], Config.Teleports["Prison Exterior"]["y"], Config.Teleports["Prison Exterior"]["z"])

    SetBlipSprite (blip, 188)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 0.8)
    SetBlipColour (blip, 49)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString('Boilingbroke Penitentiary')
    EndTextCommandSetBlipName(blip)
end)--]]