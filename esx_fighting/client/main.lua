local Keys = {
  ["ESC"] = 322, ["F1"] = 288, ["F2"] = 289, ["F3"] = 170, ["F5"] = 166, ["F6"] = 167, ["F7"] = 168, ["F8"] = 169, ["F9"] = 56, ["F10"] = 57,
  ["~"] = 243, ["1"] = 157, ["2"] = 158, ["3"] = 160, ["4"] = 164, ["5"] = 165, ["6"] = 159, ["7"] = 161, ["8"] = 162, ["9"] = 163, ["-"] = 84, ["="] = 83, ["BACKSPACE"] = 177,
  ["TAB"] = 37, ["Q"] = 44, ["W"] = 32, ["E"] = 38, ["R"] = 45, ["T"] = 245, ["Y"] = 246, ["U"] = 303, ["P"] = 199, ["["] = 39, ["]"] = 40, ["ENTER"] = 18,
  ["CAPS"] = 137, ["A"] = 34, ["S"] = 8, ["D"] = 9, ["F"] = 23, ["G"] = 47, ["H"] = 74, ["K"] = 311, ["L"] = 182,
  ["LEFTSHIFT"] = 21, ["Z"] = 20, ["X"] = 73, ["C"] = 26, ["V"] = 0, ["B"] = 29, ["N"] = 249, ["M"] = 244, [","] = 82, ["."] = 81,
  ["LEFTCTRL"] = 36, ["LEFTALT"] = 19, ["SPACE"] = 22, ["RIGHTCTRL"] = 70,
  ["HOME"] = 213, ["PAGEUP"] = 10, ["PAGEDOWN"] = 11, ["DELETE"] = 178,
  ["LEFT"] = 174, ["RIGHT"] = 175, ["TOP"] = 27, ["DOWN"] = 173,
  ["NENTER"] = 201, ["N4"] = 108, ["N5"] = 60, ["N6"] = 107, ["N+"] = 96, ["N-"] = 97, ["N7"] = 117, ["N8"] = 61, ["N9"] = 118
}

ESX = nil
local PlayerData = {}
local closeby = false
local MenuOpened = false
local Bet = Config.AllowedBets[1]
local Result = ""
local Boxing = false
local InRing = false
local AnnounceString = false
local LastFor = 5
local Pos = 0
local DrawCountDown = false
local CountDown = 3
local Fighters = {
  [1] = false,
  [2] = false
}

Citizen.CreateThread(function()
  while ESX == nil do
    TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
    Citizen.Wait(200)
  end
end)

Citizen.CreateThread(function ()
  AddBlip(Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Blip.sprite, Config.Blip.color, "Fighting")
end)

RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(xPlayer)
  PlayerData = xPlayer
end)

function DrawText3Ds(x,y,z, text)
    local onScreen,_x,_y=World3dToScreen2d(x,y,z)
    local px,py,pz=table.unpack(GetGameplayCamCoords())

    SetTextScale(0.35, 0.35)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(1)
    AddTextComponentString(text)
    DrawText(_x,_y)
    local factor = (string.len(text)) / 370
end

function AddBlip(x, y, z, sprite, color, name)
  local blip = AddBlipForCoord(x, y, z)
    SetBlipSprite (blip, Config.Blip.sprite)
    SetBlipDisplay(blip, 4)
    SetBlipScale  (blip, 1.2)
    SetBlipColour (blip, Config.Blip.color)
    SetBlipAsShortRange(blip, true)
    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(name)
    EndTextCommandSetBlipName(blip)
    return blip
end

function Teleport(coords)
  local ped = GetPlayerPed()
  SetEntityCoords(ped, coords.x, coords.y, coords.z)
end

function StartCountDown()
  DrawCountDown = true
  SetAudioFlag("LoadMPData", true)
  CountDown = 3
  PlaySoundFrontend(-1, "3_2_1", "HUD_MINI_GAME_SOUNDSET", 1)
  Wait(1000)
  CountDown = 2
  PlaySoundFrontend(-1, "3_2_1", "HUD_MINI_GAME_SOUNDSET", 1)
  Wait(1000)
  CountDown = 1
  PlaySoundFrontend(-1, "3_2_1", "HUD_MINI_GAME_SOUNDSET", 1)
  Wait(600)
  PlaySoundFrontend(-1, "GO", "HUD_MINI_GAME_SOUNDSET", 1)
  Wait(400)
  CountDown = "GO"
  local ped = GetPlayerPed(-1)
  FreezeEntityPosition(ped, false)
  Wait(1000)
  DrawCountDown = false
end

function cd(num)
  SetTextCentre(true)
  SetTextFont(6)
  SetTextScale(2.0, 2.0)
  SetTextColour(0, 200, 255, 255)
  SetTextDropShadow(0, 0, 0, 0, 255)
  SetTextEdge(2, 0, 0, 0, 255)
  SetTextDropShadow()
  SetTextOutline()
  SetTextEntry("STRING")
  AddTextComponentString(num)
  DrawText(0.5, 0.25)
end

function OpenFightMenu()
  MenuOpened = true

  local elements = {}

  for i,v in ipairs(Config.AllowedBets) do
    table.insert(elements, {label = "$".. v, value = v})
  end

  ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'bet',
    {
      title    = "Change Bet",
      align    = 'top-right',
      elements = elements
    }, function(data, menu)
      if data.current.value then
        ESX.TriggerServerCallback('61d24cfc-845b-42da-bdb8-1a85f1a37cb2', function(success)
          if success then
            MenuOpened = false
            menu.close()
            ESX.ShowNotification("You've edited the bet")
          end
        end, data.current.value)
      end
    end, function(data, menu)
      MenuOpened = false
      menu.close()
  end)
end

function JoinFight(pos)
  ESX.TriggerServerCallback('c674eb72-c7eb-4f11-99f8-6eae6b7a5f76', function(success)
    if success then
      local ped = GetPlayerPed(-1)
      Teleport(Config.Pos[pos])
      FreezeEntityPosition(ped, true)
      SetEntityHealth(ped, 200)
      SetEntityHeading(ped, Config.Pos[pos].h)
      Pos = pos
      InRing = true
    else
      ESX.ShowNotification("You don't have enough money!")
    end
  end, pos)
end

function LeaveFight(pos)
  ESX.TriggerServerCallback('823df598-1852-4cdb-8e4b-b1e8c3a16e21', function(success)
    if success then
      local ped = GetPlayerPed(-1)
      FreezeEntityPosition(ped, false)
      ESX.ShowNotification("You just entered the fight!")
      InRing = false
    else
      ESX.ShowNotification("You aren't in ring!")
    end
  end, pos)
end

function Initialize(scaleform)
    local scaleform = RequestScaleformMovie(scaleform)
    while not HasScaleformMovieLoaded(scaleform) do
        Citizen.Wait(0)
    end
    PushScaleformMovieFunction(scaleform, "SHOW_SHARD_WASTED_MP_MESSAGE")
    PushScaleformMovieFunctionParameterString(Result)
    PushScaleformMovieFunctionParameterString(AnnounceString)
    PopScaleformMovieFunctionVoid()
    return scaleform
end

function Announce(winner)
  if winner then
    AnnounceString = "You won $" .. Bet*2
    Result = "~g~Winner"
    PlaySoundFrontend(-1, "WIN", "HUD_AWARDS", 1)
    Citizen.Wait(LastFor * 1000)
    AnnounceString = false
    SetEntityHealth(GetPlayerPed(-1), 200)
  else
    AnnounceString = "You lost $" .. Bet
    Result = "~r~Loser"
    PlaySoundFrontend(-1, "LOSER", "HUD_AWARDS", 1)
    Citizen.Wait(LastFor * 1000)
    AnnounceString = false
    TriggerEvent('c97adeb3-14e4-4be0-b519-a93d5ee530f3')
  end
end

RegisterNetEvent('35ca1968-8112-41ce-b92a-7c2e2a389748')
AddEventHandler('35ca1968-8112-41ce-b92a-7c2e2a389748', function (prize)
  Bet = prize
end)

RegisterNetEvent('e7fedf63-0f9a-4421-86b9-c42977ff44cd')
AddEventHandler('e7fedf63-0f9a-4421-86b9-c42977ff44cd', function (pos, state)
  Fighters[pos] = state
end)

RegisterNetEvent('fd4e988d-17be-4ae4-bfef-820666a3b514')
AddEventHandler('fd4e988d-17be-4ae4-bfef-820666a3b514', function ()
  Boxing = true
  StartCountDown()
end)

RegisterNetEvent('c1726048-2eaa-48cf-a19a-e5955b2c0592')
AddEventHandler('c1726048-2eaa-48cf-a19a-e5955b2c0592', function (result)
  Boxing = false
  InRing = false
  Pos = 0
  Announce(result)
end)

Citizen.CreateThread(function()
  local healthoverride = false
  while true do
    Wait(0)

    local coords = GetEntityCoords(GetPlayerPed(-1))
	if #(coords - Config.Ring) < 80 then
		closeby = true
		if DrawCountDown then
		  cd(tostring(CountDown))
		end
		
		if InRing and not Boxing and Pos ~= 0 then
		  ESX.ShowHelpNotification("Press ~INPUT_PICKUP~ to leave the match")
		  if IsControlPressed(0, Keys['E']) and not MenuOpened then
			LeaveFight(Pos)
			Wait(750)
		  end
		end

		if Boxing then
			local myped = PlayerPedId()
		  if GetCurrentPedWeapon(myped, 0)~=-1569615261 then
			SetCurrentPedWeapon(myped, -1569615261, true)
		  end
		  if #(coords - Config.Ring) > Config.Ring_Dist then
			SetEntityCoords(GetPlayerPed(-1),Config.Pos[Pos].vpos)
			SetEntityHeading(GetPlayerPed(-1),Config.Pos[Pos].h)
		  end
		  if not healthoverride then SetPedMaxHealth(GetPlayerPed(-1), 500); SetEntityHealth(GetPlayerPed(-1), 500); healthoverride = true end
		  if GetEntityHealth(GetPlayerPed(-1)) < 150 then
			SetEntityHealth(GetPlayerPed(-1), 200)
			SetPedMaxHealth(GetPlayerPed(-1), 200)
			healthoverride = false
			TriggerServerEvent('651ca34d-e9f4-4dd2-a70b-3877e5483fe9', Pos)
			Boxing = false
		  end
		end

		if not Boxing and healthoverride then SetPedMaxHealth(GetPlayerPed(-1), 200); SetEntityHealth(GetPlayerPed(-1), 200); healthoverride = false end

		if(GetDistanceBetweenCoords(coords, Config.Marker.x, Config.Marker.y, Config.Marker.z, true) < Config.DrawDistance) then
		  DrawText3Ds(Config.Marker.x, Config.Marker.y, Config.Marker.z, "~b~Entry: ~r~$" .. Bet) 
		  if GetDistanceBetweenCoords(coords, Config.Marker.x, Config.Marker.y, Config.Marker.z, true) < 2.0 and not Fighters[1] and not Fighters[2] then
			ESX.ShowHelpNotification("Press ~INPUT_PICKUP~ to edit bet")
			if IsControlPressed(0, Keys['E']) and not MenuOpened then
			  OpenFightMenu()
			end
		  end
		end

		if(#(coords - Config.Pos[1].vpos) < Config.DrawDistance) and not Fighters[1] then
		  DrawText3Ds(Config.Pos[1].vpos.x, Config.Pos[1].vpos.y, Config.Pos[1].vpos.z+1, "Join Fight [~r~E~w~]") 
		  if #(coords - Config.Pos[1].vpos) < 1.0 then
			ESX.ShowHelpNotification("Press ~INPUT_PICKUP~ to join the fight")
			if IsControlPressed(0, Keys['E']) then
			  JoinFight(1)
			  Wait(750)
			end
		  end
		end

		if(#(coords - Config.Pos[2].vpos) < Config.DrawDistance) and not Fighters[2] then
		  DrawText3Ds(Config.Pos[2].vpos.x, Config.Pos[2].vpos.y, Config.Pos[2].vpos.z+1, "Join Fight [~r~E~w~]") 
		  if #(coords - Config.Pos[1].vpos) < 1.0 then
			ESX.ShowHelpNotification("Press ~INPUT_PICKUP~ to join the fight")
			if IsControlPressed(0, Keys['E']) then
			  JoinFight(2)
			  Wait(750)
			end
		  end
		end
	else
		closeby = false
		Wait(5000)
	end
  end
end)

Citizen.CreateThread(function()
  while true do
    Citizen.Wait(0)
	if closeby == true then
		if AnnounceString then
		  scaleform = Initialize("mp_big_message_freemode")
		  DrawScaleformMovieFullscreen(scaleform, 255, 255, 255, 255, 0)
		else
		  Wait(1000)
		end
	else
		Wait(5000)
	end
  end
end)