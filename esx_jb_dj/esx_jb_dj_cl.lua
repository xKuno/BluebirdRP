--DO-NOT-EDIT-BELLOW-THIS-LINE--
-- Init ESX
ESX = nil
local GUI                       = {}
GUI.Time                        = 0
local PlayerData                = {}

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
	while true do
		-- removes audio from vanilla unicorn
		SetStaticEmitterEnabled('LOS_SANTOS_VANILLA_UNICORN_01_STAGE', false)
		SetStaticEmitterEnabled('LOS_SANTOS_VANILLA_UNICORN_02_MAIN_ROOM', false)
		SetStaticEmitterEnabled('LOS_SANTOS_VANILLA_UNICORN_03_BACK_ROOM', false)
		Citizen.Wait(5000)
	end
end)


RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(xPlayer)
  	PlayerData = xPlayer
end)

RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function(job)
  PlayerData.job = job
end)

RegisterNetEvent('a1105585-d0e9-46a7-992f-37f5effd49bc')
AddEventHandler('a1105585-d0e9-46a7-992f-37f5effd49bc', function(job)
  PlayerData.second_job = job
end)
-- Fin init ESX

function exitmarkerdjbooth()
	ESX.UI.Menu.CloseAll()
end


--fonctions jobs
RegisterNetEvent(  'esx_jb_dj:enabledjbooth')
AddEventHandler(  'esx_jb_dj:enabledjbooth', function(enabled,venue)
	print(venue)
    for k,v in pairs(Config.nightclubs) do
		if enabled then
			exports.ft_libs:EnableArea("esx_jb_dj_"..venue.."_djbooth")
		else
			exports.ft_libs:DisableArea("esx_jb_dj_"..venue.."_djbooth")
		end
	end
end)


RegisterNetEvent(  "ft_libs:OnClientReady")
AddEventHandler(  'ft_libs:OnClientReady', function()
	for k,v in pairs (Config.nightclubs) do
		exports.ft_libs:AddArea("esx_jb_dj_"..k.."_dancefloor", {
			trigger = {
				weight = v.dancefloor.Marker.w,
				active = {
					callback = function()
						local ped = GetPlayerPed(-1)
						local coords      = GetEntityCoords(ped)
						local distance = GetDistanceBetweenCoords(coords, v.dancefloor.Pos.x, v.dancefloor.Pos.y, v.dancefloor.Pos.z, true)
						-- local number =distance/v.dancefloor.Marker.w
						-- local volume = round((1-number), 2)
						local number =distance/v.dancefloor.Marker.w
						local volume = round(((1-number)/10), 2)
						SendNUIMessage({setvolume = volume, dancefloor = k})	
					end,
				},
				exit = {
					callback = function()
						SendNUIMessage({setvolume = 0.0, dancefloor = k})	
					end,
				},
			},
			locations = {
				{
					x = v.dancefloor.Pos.x,
					y = v.dancefloor.Pos.y,
					z = v.dancefloor.Pos.z,
				},
			},
		})
		
		exports.ft_libs:AddArea("esx_jb_dj_"..k.."_djbooth", {
			enable = false,
			marker = {
				weight = v.djbooth.Marker.w,
				height = v.djbooth.Marker.h,
				red = v.djbooth.Marker.r,
				green = v.djbooth.Marker.g,
				blue = v.djbooth.Marker.b,
			},
			trigger = {
				weight = v.djbooth.Marker.w,
				active = {
					callback = function()
						exports.ft_libs:HelpPromt(v.djbooth.HelpPrompt)
						if IsControlJustPressed(1, 38) and GetLastInputMethod(2) and (GetGameTimer() - GUI.Time) > 150 then
							OpenDjMenu(k)
							GUI.Time = GetGameTimer()
						end
					end,
				},
				exit = {
					callback = exitmarkerdjbooth
				},
			},
			locations = {
				{
					x = v.djbooth.Pos.x,
					y = v.djbooth.Pos.y,
					z = v.djbooth.Pos.z,
				},
			},
		})
	end
end)

function OpenDjMenu(dancefloor)
	local elements = {}
	table.insert(elements, {label = 'Play Music', value = 'play_music'})
	table.insert(elements, {label = 'Pause Music', value = 'pause_music'})
	table.insert(elements, {label = 'Stop Music', value = 'stop_music'})
	table.insert(elements, {label = 'Custom Link', value = 'customlink'})
	table.insert(elements, {label = 'Custom YouTube ID', value = 'customutube'})
	for k,v in pairs (Config.Songs) do
		if v.fullink ~= nil then
			table.insert(elements, {label = v.label, value = v.song, fullink = v.fullink})
		else
			table.insert(elements, {label = v.label, value = v.song})
		end
	end
	ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'menuperso_gpsrapide',
		{
			title    = 'Playlist Items',
			align    = 'top-right',
			elements = elements,
		},
		function(data2, menu2)
			if data2.current.value == "pause_music" then
				TriggerServerEvent(  'esx_jb_dj:setcommandc', "pause", "", dancefloor)
			elseif data2.current.value == "customlink" then
                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'playmp3',
                    {
                        title = 'Play MP3 Link (eg: http://url/file.mp3',
                    }, function(data, menu)
                        TriggerServerEvent(  'esx_jb_dj:setcommandc', "playsonglink", data.value,dancefloor)
                        menu.close()
                    end, function(data, menu)
                        menu.close()
                    end)
			elseif data2.current.value == "customutube" then
                ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'playmp3',
                    {
                        title = 'Play YouTube id eg : http://youtube.com/p?v=id',
                    }, function(data, menu)
						
							TriggerServerEvent(  'esx_jb_dj:setcommandc', "playsong", data.value, dancefloor)
					
                        menu.close()
                    end, function(data, menu)
                        menu.close()
                    end)
				
			elseif data2.current.value == "play_music" then
				TriggerServerEvent(  'esx_jb_dj:setcommandc', "play", "", dancefloor)
			elseif data2.current.value == "stop_music" then
				TriggerServerEvent(  'esx_jb_dj:setcommandc', "stop", "", dancefloor)
			elseif data2.current.fullink ~= nil then
				TriggerServerEvent(  'esx_jb_dj:setcommandc', "playsonglink", data2.current.value,dancefloor)
			else
				TriggerServerEvent(  'esx_jb_dj:setcommandc', "playsong", data2.current.value, dancefloor)
			end
		end,
		function(data2, menu2)
			menu2.close()
		end
	)
end

RegisterNetEvent(  'esx_jb_dj:setmusicforeveryone')
AddEventHandler(  'esx_jb_dj:setmusicforeveryone', function(command, songname, dancefloor)
	-- print(dancefloor)
	print(command)
	print(songname)
	print(dancefloor)
	
	SendNUIMessage({musiccommand = command, songname = songname, dancefloor = dancefloor})
end)

function round(num, dec)
  local mult = 10^(dec or 0)
  return math.floor(num * mult + 0.5) / mult
end

function dump(o, nb)
  if nb == nil then
    nb = 0
  end
   if type(o) == 'table' then
      local s = ''
      for i = 1, nb + 1, 1 do
        s = s .. "    "
      end
      s = '{\n'
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
          for i = 1, nb, 1 do
            s = s .. "    "
          end
         s = s .. '['..k..'] = ' .. dump(v, nb + 1) .. ',\n'
      end
      for i = 1, nb, 1 do
        s = s .. "    "
      end
      return s .. '}'
   else
      return tostring(o)
   end
end
