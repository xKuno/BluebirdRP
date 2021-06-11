ESX = nil
local PlayerData                = {}
local UI_MOUSE_FOCUS = false
local USER_DOCUMENTS = {}
local SHARED_DOCUMENTS = {}
local fontId
local CURRENT_DOCUMENT = nil
local DOCUMENT_FORMS = nil

local presentlyInMarker = false
local currentpostbox = nil

local MENU_OPTIONS = {
    x = 0.5,
    y = 0.2,
    width = 0.5,
    height = 0.04,
    scale = 0.4,
    font = fontId,
    --menu_title = "Document Actions",
    menu_subtitle = "Document Options",
    color_r = 0,
    color_g = 128,
    color_b = 255,
}


Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
    while ESX.IsPlayerLoaded == false do
        Citizen.Wait(10)
    end

    PlayerData = ESX.GetPlayerData()

    DOCUMENT_FORMS = Config.Documents[Config.Locale]
   -- print(dump(DOCUMENT_FORMS))

    if Config.UseCustomFonts == true then
        RegisterFontFile(Config.CustomFontFile)
        fontId = RegisterFontId(Config.CustomFontId)
        MENU_OPTIONS.font = fontId
    else 
        MENU_OPTIONS.font = 4
    end
    



end)

RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(xPlayer)
    PlayerData = xPlayer
	
    GetAllUserForms()
    SetNuiFocus(false, false)

end)




Citizen.CreateThread(function()
	while true do
		Wait(30000)
		for k,v in pairs(Config.PostOffices) do


			
			RequestModel(`prop_letterbox_04`)
			while not HasModelLoaded(`prop_letterbox_04`) do
			   Wait(1)
			end
			
			local object = GetClosestObjectOfType(v.coords.x,  v.coords.y,  v.coords.z,  5.0,  `prop_letterbox_04`, false, false, false)
			if DoesEntityExist(object) then
				DeleteEntity(object)
			end
			local obj1 = CreateObject(`prop_letterbox_04`, v.coords.x, v.coords.y, v.coords.z - 1.0, false, true, true)
			--PlaceObjectOnGroundProperly(obj1)
			


			
			
			--[[
			local nbObjetsCrees = 0
			while nbObjetsCrees < 5 do
				local objc = GetClosestObjectOfType( v.coords.x, v.coords.y, v.coords.z, 5.0,GetHashKey("prop_letterbox_04"),true,true, true)
				DeleteObject(objc)
				DeleteEntity(objc)
				nbObjetsCrees = nbObjetsCrees + 1
				Wait(0)
			end
			print('finished delete') --]]
		end
		return
	end
end)

-- Draw markers & Marker logic
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)
		local playerCoords = GetEntityCoords(PlayerPedId())
		local letSleep, isInMarker, hasExited = true, false, false

		for k,v in ipairs(Config.PostOffices) do
			local distance = GetDistanceBetweenCoords(playerCoords, v.coords, true)

			if distance < Config.DrawDistance then
				local c = v.coords
				c = vector3(c.x,c.y,c.z -1.0)
				DrawMarker(Config.Marker.type, c, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, Config.Marker.x, Config.Marker.y, Config.Marker.z, Config.Marker.r, Config.Marker.g, Config.Marker.b, Config.Marker.a, false, false, 2, Config.Marker.rotate, nil, nil, false)
				letSleep = false
			end

			if distance < Config.Marker.x then
				isInMarker = true
				currentpostbox = v
				break
			else
			
			end
			
			
		end
		if presentlyInMarker == true and currentpostbox ~= nil then
			ESX.ShowHelpNotification('Post Box: ' .. currentpostbox.title)
		  --DrawText3D(currentpostbox.coords.x, currentpostbox.coords.y, currentpostbox.coords.z+1, currentpostbox.title)
		end
		if isInMarker == false then
			presentlyInMarker = false
		else
			presentlyInMarker = true
		end
		
		if letSleep then
			Citizen.Wait(1500)
		end
	end
end)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
       
        if UI_MOUSE_FOCUS == true then

            --[[
            if IsControlJustReleased(0, 142) then -- MeleeAttackAlternate
                --SendNUIMessage({type = "click"})
                
            end
            --]]
        end
    
		if(GetLastInputMethod(0)) then
			if IsControlJustReleased(0, Config.MenuKey)  then
				Menu.hidden = false
				OpenMainMenu()
				
				--[[
				SetNuiFocus(true, true)
				SendNUIMessage({
					type = "ShowDocument",
					enable = true
				})
				UI_MOUSE_FOCUS = true
				--]]

			end
		end

        Menu.renderGUI(MENU_OPTIONS)
    end
 end)
 
RegisterCommand("documents", function(source, args, raw)
	Menu.hidden = false
	OpenMainMenu()
end,false)
 
RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function (job)
	PlayerData = ESX.GetPlayerData()

end)

function OpenMainMenu()
    ClearMenu()
    Menu.addButton("Public Documents", "OpenNewPublicFormMenu", nil)
    Menu.addButton("Job Documents", "OpenNewJobFormMenu", nil)
    Menu.addButton("Saved Documents", "OpenMyDocumentsMenu", nil)
	if presentlyInMarker == true then
		if PlayerData == nil or PlayerData.Job == nil then
			 PlayerData = ESX.GetPlayerData()
		end
		if PlayerData.job.name == currentpostbox.job and PlayerData.job.grade >= currentpostbox.grade then
			Menu.addButton("Open PostBox: " .. currentpostbox.title, "OpenMyPostBox", nil)
		end
	end
    Menu.addButton("Close","CloseMenu",nil) 
    Menu.hidden = false
end

function CopyFormToPlayer(aPlayer)
    --TriggerServerEvent('2f7ca9fe-ba2a-4775-ad09-4b91d6baa0c8', GetPlayerServerId(player), aDocument)
    TriggerServerEvent('2f7ca9fe-ba2a-4775-ad09-4b91d6baa0c8', aPlayer, CURRENT_DOCUMENT)
    CURRENT_DOCUMENT = nil;
    CloseMenu()
end

function ShowToNearestPlayers(aDocument)
    ClearMenu()
    local players_clean = GetNeareastPlayers()
    CURRENT_DOCUMENT = aDocument
    if #players_clean > 0 then
        for i=1, #players_clean, 1 do
            --local tmpObject = { pId = players_clean[i].playerId, pForm = aDocument }
            Menu.addButton( "[" .. tostring(players_clean[i].playerId) .. "]", "ShowDocument", players_clean[i].playerId)  --  players_clean[i].playerName ..
        end
    else

        Menu.addButton("No players found", "CloseMenu", nil)
    end

    --Menu.addButton("Go Back", "OpenFormPropertiesMenu", aDocument)
    Menu.addButton("Close", "CloseMenu", nil)
end

function CopyToPostBox(aDocument)

	CURRENT_DOCUMENT = aDocument.data
    TriggerServerEvent('76ee8c2b-2102-4896-9c3a-0e8af1ffb3fb', currentpostbox, CURRENT_DOCUMENT)
    CURRENT_DOCUMENT = nil;
    CloseMenu()
end


function PostInPostBox(aDocument)

	CURRENT_DOCUMENT = aDocument.data
    TriggerServerEvent('11368493-f65c-4b42-8ab7-521e667f5307', currentpostbox, CURRENT_DOCUMENT, aDocument.id)
    CURRENT_DOCUMENT = nil;
    CloseMenu()
	
		--remove form_close
	for i=1, #USER_DOCUMENTS, 1 do
		if USER_DOCUMENTS[i].id == aDocument.id then
			key_to_remove = i
		end
	end

	if key_to_remove ~= nil then
		table.remove(USER_DOCUMENTS, key_to_remove)
	end
	--OpenMyDocumentsMenu()
	
end



function CopyToNearestPlayers(aDocument)
    ClearMenu()
    local players_clean = GetNeareastPlayers()
    CURRENT_DOCUMENT = aDocument
    if #players_clean > 0 then
        for i=1, #players_clean, 1 do
            
            Menu.addButton("[" .. tostring(players_clean[i].playerId) .. "]", "CopyFormToPlayer", players_clean[i].playerId) --  players_clean[i].playerName .. 
        end
    else

        Menu.addButton("No players found", "CloseMenu", nil)
    end

    Menu.addButton("Go Back", "OpenFormPropertiesMenu", aDocument)
    Menu.addButton("Close", "CloseMenu", nil)
end

function OpenNewPublicFormMenu()
    ClearMenu()
    for i=1, #DOCUMENT_FORMS["public"], 1 do
        Menu.addButton(DOCUMENT_FORMS["public"][i].headerTitle, "CreateNewForm", DOCUMENT_FORMS["public"][i])
    end
    Menu.addButton("Close","CloseMenu",nil) 
    Menu.hidden = false
end

function OpenNewJobFormMenu()
    ClearMenu()
	
    PlayerData = ESX.GetPlayerData()
    if DOCUMENT_FORMS[PlayerData.job.name] ~= nil then

        for i=1, #DOCUMENT_FORMS[PlayerData.job.name], 1 do
            Menu.addButton(DOCUMENT_FORMS[PlayerData.job.name][i].headerTitle, "CreateNewForm", DOCUMENT_FORMS[PlayerData.job.name][i])
        end
    end
    Menu.addButton("Close","CloseMenu",nil) 
    Menu.hidden = false
end



function OpenMyPostBox()
		
		ESX.TriggerServerCallback('e51c60c8-5ea5-40e4-9470-6e9524101a1a', function (cb_forms)
			if cb_forms ~= nil then
				print("Received dump : " .. dump(cb_forms))
				SHARED_DOCUMENTS = cb_forms
			else
				print ("Received nil from newely created scale object.")
			end
			
			ClearMenu()
			for i=#SHARED_DOCUMENTS, 1, -1 do

				local date_created = ""
				if SHARED_DOCUMENTS[i].data.headerDateCreated ~= nil then
					date_created = SHARED_DOCUMENTS[i].data.headerDateCreated .. " - "
				end

				Menu.addButton(date_created .. SHARED_DOCUMENTS[i].data.headerTitle, "OpenFormPropertiesSharedMenu", SHARED_DOCUMENTS[i])
			end
			Menu.addButton("Close", "CloseMenu", nil)
			Menu.hidden = false


		end, currentpostbox.id)

end

function OpenMyDocumentsMenu()
    ClearMenu()
    for i=#USER_DOCUMENTS, 1, -1 do

        local date_created = ""
        if USER_DOCUMENTS[i] ~= nil and USER_DOCUMENTS[i].data ~= nil and USER_DOCUMENTS[i].data.headerDateCreated ~= nil then
            date_created = USER_DOCUMENTS[i].data.headerDateCreated .. " - "
        end
		if USER_DOCUMENTS[i] ~= nil and USER_DOCUMENTS[i].data ~= nil and USER_DOCUMENTS[i].data.headerTitle then
			Menu.addButton(date_created .. USER_DOCUMENTS[i].data.headerTitle, "OpenFormPropertiesMenu", USER_DOCUMENTS[i])
		end
    end
    Menu.addButton("Close", "CloseMenu", nil)
    Menu.hidden = false
end

function OpenFormPropertiesMenu(aDocument)
    ClearMenu()
	if PlayerData == nil or PlayerData.Job == nil then
		 PlayerData = ESX.GetPlayerData()
	end
	if presentlyInMarker == true then
		local allowed = true
		if currentpostbox.public == false then
			if currentpostbox.job ~= PlayerData.job.name then
				allowed = false
			end
		end
		if allowed == true then
			Menu.addButton("Post in Postbox: " .. currentpostbox.title, "PostInPostBox", aDocument)
			Menu.addButton("Copy to Postbox: " .. currentpostbox.title, "CopyToPostBox", aDocument)
		end
	end
    Menu.addButton("View", "ViewDocument", aDocument.data)
    Menu.addButton("Show", "ShowToNearestPlayers", aDocument.data)
    Menu.addButton("Give Copy", "CopyToNearestPlayers", aDocument.data)
    Menu.addButton("Delete", "OpenDeleteFormMenu", aDocument)
    Menu.addButton("Go Back", "OpenMyDocumentsMenu", nil)
    Menu.addButton("Close", "CloseMenu", nil)
    Menu.hidden = false
end

function OpenFormPropertiesSharedMenu(aDocument)
    ClearMenu()
    Menu.addButton("View", "ViewDocument", aDocument.data)
    Menu.addButton("Show", "ShowToNearestPlayers", aDocument.data)
    Menu.addButton("Give Copy", "CopyToNearestPlayers", aDocument.data)
	Menu.addButton("Save a Copy", "SaveMeACopy", aDocument.data)
    Menu.addButton("Delete", "OpenDeleteSharedFormMenu", aDocument)
    Menu.addButton("Go Back", "OpenMyPostBox", nil)
    Menu.addButton("Close", "CloseMenu", nil)
    Menu.hidden = false
end

function SaveMeACopy(aDocument)
	CURRENT_DOCUMENT = aDocument
    TriggerServerEvent('2f7ca9fe-ba2a-4775-ad09-4b91d6baa0c8', GetPlayerServerId(PlayerId()), CURRENT_DOCUMENT)
	
end

function DeleteDocumentShared(aDocument)
    
    local key_to_remove = nil

    ESX.TriggerServerCallback('0c3434e3-7120-4148-a8fc-65e53e88207f', function (cb)
        if cb == true then
            --remove form_close
            for i=1, #SHARED_DOCUMENTS, 1 do
                if SHARED_DOCUMENTS[i].id == aDocument.id then
                    key_to_remove = i
                end
            end

            if key_to_remove ~= nil then
                table.remove(SHARED_DOCUMENTS, key_to_remove)
            end
            OpenMyPostBox()
        end
    end, aDocument.id)
end


function OpenDeleteSharedFormMenu(aDocument)
    ClearMenu()
    Menu.addButton("Yes Delete", "DeleteDocumentShared", aDocument)
    Menu.addButton("Go Back", "OpenFormPropertiesSharedMenu", aDocument)
    Menu.addButton("Close", "CloseMenu", nil)
    Menu.hidden = false
end

function OpenDeleteFormMenu(aDocument)
    ClearMenu()
    Menu.addButton("Yes Delete", "DeleteDocument", aDocument)
    Menu.addButton("Go Back", "OpenFormPropertiesMenu", aDocument)
    Menu.addButton("Close", "CloseMenu", nil)
    Menu.hidden = false
end



function CloseMenu()
    ClearMenu()
    Menu.hidden = true
end


function DeleteDocument(aDocument)
    
    local key_to_remove = nil

    ESX.TriggerServerCallback('f2c7175c-c15f-47c7-b1da-e7975089c1b4', function (cb)
        if cb == true then
            --remove form_close
            for i=1, #USER_DOCUMENTS, 1 do
                if USER_DOCUMENTS[i].id == aDocument.id then
                    key_to_remove = i
                end
            end

            if key_to_remove ~= nil then
                table.remove(USER_DOCUMENTS, key_to_remove)
            end
            OpenMyDocumentsMenu()
        end
    end, aDocument.id)
end

function CreateNewForm(aDocument)

    PlayerData = ESX.GetPlayerData()
    ESX.TriggerServerCallback('88f23faa-ea71-42e6-b7c1-2c8869a1f665', function (cb_player_details)
        if cb_player_details ~= nil then
            --print("Received dump : " .. dump(cb_player_details))
            SetNuiFocus(true, true)
            aDocument.headerFirstName = cb_player_details.firstname
            aDocument.headerLastName = cb_player_details.lastname
            aDocument.headerDateOfBirth = cb_player_details.dateofbirth
            aDocument.headerJobLabel = PlayerData.job.label
            aDocument.headerJobGrade = PlayerData.job.grade_label
            aDocument.locale = Config.Locale

            SendNUIMessage({
                type = "createNewForm",
                data = aDocument
            })
        else
            print ("Received nil from newely created scale object.")
        end
    end, data)

end

function ShowDocument(aPlayer)
        print("ssss: " .. dump(aPlayer))
        TriggerServerEvent('05708bef-dba0-48de-9cb4-d0724fca62f8', aPlayer, CURRENT_DOCUMENT)
        CURRENT_DOCUMENT = nil
        CloseMenu()
end

RegisterNetEvent('806e41b9-f0d2-4f54-9ceb-fafa2fe35ffe')
AddEventHandler('806e41b9-f0d2-4f54-9ceb-fafa2fe35ffe', function( data )

    ViewDocument(data)
end)

function ViewDocument(aDocument)
    SetNuiFocus(true, true)
    SendNUIMessage({
        type = "ShowDocument",
        data = aDocument
    })
end

RegisterNetEvent('a30f859b-a06b-428f-af9c-9c0493f5799d')
AddEventHandler('a30f859b-a06b-428f-af9c-9c0493f5799d', function( data )
         print("dump: " .. dump(data))

    table.insert(USER_DOCUMENTS, data)
end)

function CopyForm(aDocument)
    --table.insert(USER_DOCUMENTS, aDocument)
end

function GetAllUserForms()

    ESX.TriggerServerCallback('1bcf1e0a-74bd-4c68-8b81-fa1848978c01', function (cb_forms)
        if cb_forms ~= nil then
            print("Received dump : " .. dump(cb_forms))
            USER_DOCUMENTS = cb_forms
        else
            print ("Received nil from newely created scale object.")
        end
    end, data)

end    


RegisterNUICallback('form_close', function()
    SetNuiFocus(false, false)
end)

RegisterNUICallback('form_submit', function(data, cb) 
    print("received: " .. dump(data))
    CloseMenu()
    ESX.TriggerServerCallback('f3cabbf0-2d66-4850-82d0-a07216b28f6b', function (cb_form)
        if cb_form ~= nil then
            print("Received dump : " .. dump(cb_form))
            table.insert(USER_DOCUMENTS, cb_form)
            OpenFormPropertiesMenu(cb_form)
        else
            print ("Received nil from newely created scale object.")
        end
    end, data)

    SetNuiFocus(false, false)

end)


function GetNeareastPlayers()
    local playerPed = PlayerPedId()
    local players, nearbyPlayer = ESX.Game.GetPlayersInArea(GetEntityCoords(playerPed), 2.5)
    
    local players_clean = {}  
    local found_players = false    
    
    for i=1, #players, 1 do
        if players[i] ~= PlayerId() then
            found_players = true
            table.insert(players_clean, {playerName = ' ', playerId = GetPlayerServerId(players[i])} )  -- GetPlayerName(players[i])
        end
    end
    return players_clean
end


function dump(o)
   if type(o) == 'table' then
      local s = '{ '
      for k,v in pairs(o) do
         if type(k) ~= 'number' then k = '"'..k..'"' end
         s = s .. '['..k..'] = ' .. dump(v) .. ','
      end
      return s .. '} '
   else
      return tostring(o)
   end
end


local color = {r = 37, g = 175, b = 134, alpha = 255} -- Color of the text 
local font = 0 -- Font of the text
local time = 500 -- Duration of the display of the text : 500 ~= 13sec


function DrawText3D(x,y,z, text)
    local onScreen,_x,_y = World3dToScreen2d(x,y,z)
    local px,py,pz = table.unpack(GetGameplayCamCoord())
    local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
 
    local scale = (1/dist)*3
    local fov = (1/GetGameplayCamFov())*100
    local scale = scale*fov

    if onScreen then
        SetTextScale(0.0*scale, 0.55*scale)
        SetTextFont(font)
        SetTextProportional(1)
        SetTextColour(color.r, color.g, color.b, color.alpha)
        SetTextDropshadow(0, 0, 0, 0, 255)
        SetTextEdge(2, 0, 0, 0, 150)
        SetTextDropShadow()
        SetTextOutline()
        SetTextEntry("STRING")
        SetTextCentre(true)
        AddTextComponentString(text)
        EndTextCommandDisplayText(_x, _y)
    end
end