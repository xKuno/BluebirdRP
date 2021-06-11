
--CORE EVIDENCE 2.0

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


local shots = {}
local blood = {}
GUITime = 0

local update = true
local last = 0
local time = 0
local open = false
local analyzing = false
local analyzingDone = false
local ignore = false
local ped = GetPlayerPed(-1)

local job = ""
local grade = 0

local evidence = {}

Citizen.CreateThread(
    function()
        while ESX == nil do
            TriggerEvent('esx:getSharedObject',function(obj)
                    ESX = obj
                end
            )
            Citizen.Wait(0)
        end

        while ESX.GetPlayerData().job == nil do
            Citizen.Wait(10)
        end

        job = ESX.GetPlayerData().job.name
        grade = ESX.GetPlayerData().job.grade
    end
)

RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d',function(j)
        job = j.name
        grade = j.grade
    end
)

Citizen.CreateThread(
    function()
		while ped == nil do
			Wait(500)
		end
        while true do
            Citizen.Wait(1)

            local playerid = PlayerId()

            if not IsPlayerFreeAiming(playerid) then
                update = true
                Citizen.Wait(1000)
            else
                local playerPed = ped

                if IsPlayerFreeAiming(playerid) and GetSelectedPedWeapon(playerPed) == `WEAPON_FLASHLIGHT` then
                    if update then
                        ESX.TriggerServerCallback('e0f46ad2-b890-49fb-9e86-51cd67346755',function(ans)
                                shots = ans.shots
                                blood = ans.blood
                                time = ans.time
                            end
                        )
                        update = false
                    end
					local pedentityCoords = GetEntityCoords(playerPed)
                    for t, s in pairs(blood) do
						
                        if #(vector3(s.coords.x,s.coords.y,s.coords.z) - pedentityCoords) < 30 then
                            DrawMarker(
                                1,
                                s.coords[1],
                                s.coords[2],
                                s.coords[3] - 0.9,
                                0.0,
                                0.0,
                                0.0,
                                0,
                                0.0,
                                0.0,
                                0.2,
                                0.2,
                                0.2,
                                255,
                                41,
                                41,
                                100,
                                false,
                                true,
                                2,
                                false,
                                false,
                                false,
                                false
                            )
                        end

                        if #(vector3(s.coords.x,s.coords.y,s.coords.z) - pedentityCoords) < 5 then
                            DrawText3D(s.coords[1], s.coords[2], s.coords[3] - 0.5, Config.Text["blood_hologram"])

                            local passed = time - t

                            if passed > 300 and passed < 600 then
                                DrawText3D(
                                    s.coords[1],
                                    s.coords[2],
                                    s.coords[3] - 0.57,
                                    Config.Text["blood_after_5_minutes"]
                                )
                            elseif passed > 600 then
                                DrawText3D(
                                    s.coords[1],
                                    s.coords[2],
                                    s.coords[3] - 0.57,
                                    Config.Text["blood_after_10_minutes"]
                                )
                            else
                                DrawText3D(
                                    s.coords[1],
                                    s.coords[2],
                                    s.coords[3] - 0.57,
                                    Config.Text["blood_after_0_minutes"]
                                )
                            end
                        end

                        if #(vector3(s.coords.x,s.coords.y,s.coords.z) - pedentityCoords) < 1 then
                            if job == Config.JobRequired and grade >= Config.JobGradeRequired then
                                DrawText3D(
                                    s.coords[1],
                                    s.coords[2],
                                    s.coords[3] - 0.65,
                                    Config.Text["pick_up_evidence_text"]
                                )
                                if IsControlJustReleased(0, Keys[Config.PickupEvidenceKey]) then
                                    if #evidence < 3 then
                                        local dict, anim =
                                            "weapons@first_person@aim_rng@generic@projectile@sticky_bomb@",
                                            "plant_floor"
                                        ESX.Streaming.RequestAnimDict(dict)
                                        TaskPlayAnim(
                                            playerPed,
                                            dict,
                                            anim,
                                            8.0,
                                            1.0,
                                            1000,
                                            16,
                                            0.0,
                                            false,
                                            false,
                                            false
                                        )
                                        Citizen.Wait(1000)
                                        blood[t] = nil
                                        evidence[#evidence + 1] = {type = "blood", evidence = s.reportInfo}
                                        TriggerServerEvent('53441ad6-14c0-4aa9-b4cc-d9221ab32b40', t)
                                        SendTextMessage(
                                            string.gsub(Config.Text["evidence_colleted"], "{number}", #evidence)
                                        )
                                        PlaySoundFrontend(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                                    else
                                        SendTextMessage(Config.Text["no_more_space"])
                                    end
                                end
                            else
                                DrawText3D(s.coords[1], s.coords[2], s.coords[3] - 0.65, Config.Text["remove_evidence"])
                                if IsControlJustReleased(0, Keys[Config.PickupEvidenceKey]) then
                                    if (time - t) > Config.TimeBeforeCrimsCanDestory then
                                        local dict, anim =
                                            "weapons@first_person@aim_rng@generic@projectile@sticky_bomb@",
                                            "plant_floor"
                                        ESX.Streaming.RequestAnimDict(dict)
                                        TaskPlayAnim(
                                            playerPed,
                                            dict,
                                            anim,
                                            8.0,
                                            1.0,
                                            1000,
                                            16,
                                            0.0,
                                            false,
                                            false,
                                            false
                                        )
                                        Citizen.Wait(1000)
                                        blood[t] = nil

                                        TriggerServerEvent('53441ad6-14c0-4aa9-b4cc-d9221ab32b40', t)
                                        SendTextMessage(Config.Text["evidence_removed"])
                                        PlaySoundFrontend(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                                    else
                                        SendTextMessage(Config.Text["cooldown_before_pickup"])
                                    end
                                end
                            end
                        end
                    end

                    for t, s in pairs(shots) do
                        if #(vector3(s.coords.x,s.coords.y,s.coords.z) - pedentityCoords) < 30 then
                            DrawMarker(
                                3,
                                s.coords[1],
                                s.coords[2],
                                s.coords[3] - 0.9,
                                0.0,
                                0.0,
                                0.0,
                                0,
                                0.0,
                                0.0,
                                0.15,
                                0.15,
                                0.2,
                                66,
                                135,
                                245,
                                100,
                                false,
                                true,
                                2,
                                false,
                                false,
                                false,
                                false
                            )
                        end

                        if #(vector3(s.coords.x,s.coords.y,s.coords.z) - pedentityCoords) < 5 then
                            DrawText3D(
                                s.coords[1],
                                s.coords[2],
                                s.coords[3] - 0.5,
                                string.gsub(Config.Text["shell_hologram"], "{guncategory}", s.bullet)
                            )

                            local passed = time - t

                            if passed > 300 and passed < 600 then
                                DrawText3D(
                                    s.coords[1],
                                    s.coords[2],
                                    s.coords[3] - 0.57,
                                    Config.Text["shell_after_5_minutes"]
                                )
                            elseif passed > 600 then
                                DrawText3D(
                                    s.coords[1],
                                    s.coords[2],
                                    s.coords[3] - 0.57,
                                    Config.Text["shell_after_10_minutes"]
                                )
                            else
                                DrawText3D(
                                    s.coords[1],
                                    s.coords[2],
                                    s.coords[3] - 0.57,
                                    Config.Text["shell_after_0_minutes"]
                                )
                            end
                        end

                        if #(vector3(s.coords.x,s.coords.y,s.coords.z) - pedentityCoords) < 1 then
                            if job == Config.JobRequired and grade >= Config.JobGradeRequired then
                                DrawText3D(
                                    s.coords[1],
                                    s.coords[2],
                                    s.coords[3] - 0.65,
                                    Config.Text["pick_up_evidence_text"]
                                )
                                if IsControlJustReleased(0, Keys[Config.PickupEvidenceKey]) then
                                    if #evidence < 3 then
                                        local dict, anim =
                                            "weapons@first_person@aim_rng@generic@projectile@sticky_bomb@",
                                            "plant_floor"
                                        ESX.Streaming.RequestAnimDict(dict)
                                        TaskPlayAnim(
                                            playerPed,
                                            dict,
                                            anim,
                                            8.0,
                                            1.0,
                                            1000,
                                            16,
                                            0.0,
                                            false,
                                            false,
                                            false
                                        )
                                        Citizen.Wait(1000)
                                        shots[t] = nil
                                        evidence[#evidence + 1] = {type = "bullet", evidence = s.reportInfo}
                                        TriggerServerEvent('97e60526-b084-465d-a355-8c5bc3dd338e', t)
                                        SendTextMessage(
                                            string.gsub(Config.Text["evidence_colleted"], "{number}", #evidence)
                                        )
                                        PlaySoundFrontend(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                                    else
                                        SendTextMessage(Config.Text["no_more_space"])
                                    end
                                end
                            else
                                DrawText3D(s.coords[1], s.coords[2], s.coords[3] - 0.65, Config.Text["remove_evidence"])
                                if IsControlJustReleased(0, Keys[Config.PickupEvidenceKey]) then
                                    if (time - t) > Config.TimeBeforeCrimsCanDestory then
                                        local dict, anim =
                                            "weapons@first_person@aim_rng@generic@projectile@sticky_bomb@",
                                            "plant_floor"
                                        ESX.Streaming.RequestAnimDict(dict)
                                        TaskPlayAnim(
                                            playerPed,
                                            dict,
                                            anim,
                                            8.0,
                                            1.0,
                                            1000,
                                            16,
                                            0.0,
                                            false,
                                            false,
                                            false
                                        )
                                        Citizen.Wait(1000)
                                        shots[t] = nil

                                        TriggerServerEvent('97e60526-b084-465d-a355-8c5bc3dd338e', t)
                                        SendTextMessage(Config.Text["evidence_removed"])
                                        PlaySoundFrontend(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                                    else
                                        SendTextMessage(Config.Text["cooldown_before_pickup"])
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
)


Citizen.CreateThread(
    function()
		while ped == nil do
			Wait(500)
		end
        while true do
            Citizen.Wait(1)

            if job == Config.JobRequired and grade >= Config.JobGradeRequired then
               
                local veh = GetVehiclePedIsTryingToEnter(ped)
                local seat = GetSeatPedIsTryingToEnter(ped)
                local coords = GetEntityCoords(ped)

                if #(coords - Config.EvidenceStorageLocation) < 1.5 then
                    DrawText3D(
                        Config.EvidenceStorageLocation[1],
                        Config.EvidenceStorageLocation[2],
                        Config.EvidenceStorageLocation[3],
                        Config.Text["open_evidence_archive"]
                    )

                    if IsControlJustReleased(0, 38) and (GetGameTimer() - 3500) > GUITime then
						GUITime = GetGameTimer()
                        ESX.TriggerServerCallback('04e35930-4766-4916-a368-36fa262467f4',function(data)
                                ESX.UI.Menu.CloseAll()

                                local elements = {}

                                for _, v in ipairs(data) do
                                    table.insert(
                                        elements,
                                        {label = Config.Text["report_list"] .. v.id .. ' ' .. v.dt .. ' ['  .. v.name .. ']', value = v.data, id = v.id}
                                    )
                                end

                                ESX.UI.Menu.Open(
                                    "default",
                                    GetCurrentResourceName(),
                                    "evidence_storage",
                                    {
                                        title = Config.Text["evidence_archive"],
                                        align = "center",
                                        elements = elements
                                    },
                                    function(data, menu)
                                        ESX.UI.Menu.Open(
                                            "default",
                                            GetCurrentResourceName(),
                                            "evidence_options",
                                            {
                                                title = data.current.label,
                                                align = "center",
                                                elements = {
                                                    {label = Config.Text["view"], value = "view"},
                                                    {label = Config.Text["delete"], value = "delete"}
                                                }
                                            },
                                            function(data2, menu2)
                                                if data2.current.value == "view" then
                                                    SendNUIMessage(
                                                        {
                                                            type = "showReport",
                                                            evidence = data.current.value
                                                        }
                                                    )
                                                    open = true
                                                elseif data2.current.value == "delete" and (GetGameTimer() - 3500) > GUITime then
													GUITime = GetGameTimer()
                                                    TriggerServerEvent('6221cac6-5fbf-480d-8cbc-2989e3071648',data.current.id)
                                                    SendTextMessage(Config.Text["evidence_deleted_from_archive"])
                                                end
                                                menu2.close()
                                            end,
                                            function(data2, menu2)
                                                menu2.close()
                                            end
                                        )
                                        menu.close()
                                    end,
                                    function(data, menu)
                                        menu.close()
                                    end
                                )
                            end
                        )
                    end
                elseif #(coords - Config.EvidenceAlanysisLocation) < 1.5 then
                    if not analyzing and not analyzingDone then
                        DrawText3D(
                            Config.EvidenceAlanysisLocation[1],
                            Config.EvidenceAlanysisLocation[2],
                            Config.EvidenceAlanysisLocation[3],
                            Config.Text["analyze_evidence"]
                        )
                    elseif analyzingDone then
                        DrawText3D(
                            Config.EvidenceAlanysisLocation[1],
                            Config.EvidenceAlanysisLocation[2],
                            Config.EvidenceAlanysisLocation[3],
                            Config.Text["read_evidence_report"]
                        )
                    else
                        DrawText3D(
                            Config.EvidenceAlanysisLocation[1],
                            Config.EvidenceAlanysisLocation[2],
                            Config.EvidenceAlanysisLocation[3],
                            Config.Text["evidence_being_analyzed_hologram"]
                        )
                    end
                    if IsControlJustReleased(0, 38) and not analyzing and not analyzingDone and (GetGameTimer() - 3500) > GUITime  then
						ESX.ShowNotification('Analysis in progress please wait...')
						GUITime = GetGameTimer()
                        if #evidence > 0 then
                            Citizen.CreateThread(
                                function()
                                    SendTextMessage(Config.Text["evidence_being_analyzed"])

                                    analyzing = true
                                    Citizen.Wait(Config.TimeToAnalyze)

                                    analyzingDone = true
                                    analyzing = false
                                end
                            )
                        else
                            SendTextMessage(Config.Text["no_evidence_to_analyze"])
                        end
                    elseif IsControlJustReleased(0, 38) and not analyzing and analyzingDone and (GetGameTimer() - 3500) > GUITime then
						GUITime = GetGameTimer()
                        ESX.TriggerServerCallback('cb41fc09-6345-4822-ba26-ea52e0890b1f',function(evidence_s)
                            SendNUIMessage(
								{
									type = "showReport",
									evidence = json.encode(evidence_s)
								}
							)
							
							if Config.PlayClipboardAnimation then
								TaskStartScenarioInPlace(ped, "WORLD_HUMAN_CLIPBOARD", 0, true)
							end
							open = true
							analyzingDone = false
							evidence = {}
						end,evidence)
						

                    end
                end

                if IsControlJustReleased(0, Keys[Config.CloseReportKey]) and open then
                    SendNUIMessage(
                        {
                            type = "close"
                        }
                    )
                    ClearPedTasks(ped)
                    open = false
                end

                if veh ~= 0 then
                    local lastped = GetLastPedInVehicleSeat(veh, seat)
                    local gloves = GetPedDrawableVariation(PlayerPedId(), 3)

                    if gloves > 15 and gloves ~= 112 and gloves ~= 113 and gloves ~= 114 then
                        last = 0
                    else
                        last = lastped
                    end
                end
			else
				Wait(5000)
            end
        end
    end
)

RegisterNetEvent('47d390bf-2d30-48d2-b568-87be007df67b')
AddEventHandler('47d390bf-2d30-48d2-b568-87be007df67b',function(report)
        Citizen.CreateThread(
            function()
                SendTextMessage(Config.Text["analyzing_car"])

                local dict, anim = "anim@heists@prison_heiststation@cop_reactions", "cop_b_idle"
                ESX.Streaming.RequestAnimDict(dict)
                TaskPlayAnim(ped, dict, anim, 8.0, 1.0, 1000, 16, 0.0, false, false, false)

                Citizen.Wait(Config.TimeToFindFingerprints)

                if #evidence < 3 then
                    evidence[#evidence + 1] = {type = "fingerprint", evidence = report}

                    SendTextMessage(string.gsub(Config.Text["evidence_colleted"], "{number}", #evidence))
                    PlaySoundFrontend(-1, "PICK_UP", "HUD_FRONTEND_DEFAULT_SOUNDSET", false)
                else
                    SendTextMessage(Config.Text["no_more_space"])
                end
            end
        )
    end
)

RegisterNetEvent('b2117dbe-7af1-451b-9021-18c47495ce6a')
AddEventHandler('b2117dbe-7af1-451b-9021-18c47495ce6a', function(value)
        ignore = value
    end
)

RegisterNetEvent('58e941cc-17d0-40ba-9cc2-d974add839c4')
AddEventHandler('58e941cc-17d0-40ba-9cc2-d974add839c4',
    function(msg)
        SendTextMessage(msg)
    end)

RegisterNetEvent('f53a95a8-04eb-47e6-919a-3c0e824abddb')
AddEventHandler('f53a95a8-04eb-47e6-919a-3c0e824abddb',function()
        if IsPedInAnyVehicle(ped, false) then
            TriggerServerEvent('d1e0f640-617a-466c-a4d0-0587d562532d', NetworkGetNetworkIdFromEntity(last))
        else
            SendTextMessage(Config.Text["not_in_vehicle"])
        end
    end
)
RegisterNetEvent('9b4bc7cc-042b-4c06-aa15-bcef4ac14e61')
AddEventHandler('9b4bc7cc-042b-4c06-aa15-bcef4ac14e61',function(evd)
	evidence = evd
end)



Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(5000)
            if Config.RainRemovesEvidence then
                if GetRainLevel() > 0.3 then
                    TriggerServerEvent('0900094e-e5a5-4644-853b-3c4426178c6a')
                    Citizen.Wait(math.random(10000,180000))
                end
            end
        end
    end
)

Citizen.CreateThread(
    function()
        while true do
            Citizen.Wait(1000)
            ped = PlayerPedId()
		end
end)
          

Citizen.CreateThread(
    function()
	
		while ped == nil do
			Wait(500)
		end
        while true do
            Citizen.Wait(10)


            local coords = GetEntityCoords(ped)

            if IsShockingEventInSphere(102, 235.497, 2894.511, 43.339, 999999.0) then
                if HasEntityBeenDamagedByAnyPed(ped) then
                    ClearEntityLastDamageEntity(ped)

                    if Config.ShowBloodSplatsOnGround then
                        local stain =
                            CreateObject(`p_bloodsplat_s`,
                            coords[1],
                            coords[2],
                            coords[3] - 2.0,
                            true,
                            true,
                            false
                        )

                        PlaceObjectOnGroundProperly(stain)
                        local stainCoords = GetEntityCoords(stain)
                        SetEntityCoords(stain, stainCoords[1], stainCoords[2], stainCoords[3] - 0.25)
                        SetEntityAsMissionEntity(stain, true, true)
                        SetEntityRotation(stain, -90.0, 0.0, 0.0, 2, false)
                        FreezeEntityPosition(stain, true)
                    end

                    TriggerServerEvent('feb412f0-1ebf-4f9a-a305-f77249161732', coords, GetInteriorFromEntity(ped))
                    Citizen.Wait(2000)
                end
            end

            if IsPedShooting(ped) and not ignore then
				local wtype = GetSelectedPedWeapon(ped)
				if wtype ~= `WEAPON_FIREEXTINGUISHER` then
					TriggerServerEvent('e0c79c08-6c9a-4069-a3c5-05a73f2f87f8', coords,getWeaponName(wtype),GetInteriorFromEntity(ped))
					Wait(200)
				else
					Wait(1000)
				end
				
            end
        end
    end
)



function getWeaponName(hash)

    if GetWeapontypeGroup(hash) == -957766203 then
        return Config.Text["submachine_category"]
    end
    if GetWeapontypeGroup(hash) == 416676503 then
        return Config.Text["pistol_category"]
    end
    if GetWeapontypeGroup(hash) == 860033945 then
        return Config.Text["shotgun_category"]
    end
    if GetWeapontypeGroup(hash) == 970310034 then
        return Config.Text["assault_category"]
    end
    if GetWeapontypeGroup(hash) == 1159398588 then
        return Config.Text["lightmachine_category"]
    end
    if GetWeapontypeGroup(hash) == -1212426201 then
        return Config.Text["sniper_category"]
    end
    if GetWeapontypeGroup(hash) == -1569042529 then
        return Config.Text["heavy_category"]
    end

    return GetWeapontypeGroup(hash)
end

function DrawText3D(x, y, z, text)
    local onScreen, _x, _y = World3dToScreen2d(x, y, z)
    local px, py, pz = table.unpack(GetGameplayCamCoord())
    local dist = GetDistanceBetweenCoords(px, py, pz, x, y, z, 1)

    local scale = ((1 / dist) * 2) * (1 / GetGameplayCamFov()) * 100

    if onScreen then
        SetTextColour(255, 255, 255, 255)
        SetTextScale(0.0 * scale, 0.35 * scale)
        SetTextFont(4)
        SetTextProportional(1)
        SetTextCentre(true)

        SetTextDropshadow(1, 1, 1, 1, 255)

        BeginTextCommandWidth("STRING")
        AddTextComponentString(text)
        local height = GetTextScaleHeight(0.55 * scale, 4)
        local width = EndTextCommandGetWidth(4)

        SetTextEntry("STRING")
        AddTextComponentString(text)
        EndTextCommandDisplayText(_x, _y)
    end
end

RegisterNetEvent('0450592c-ed62-4cc2-8d0e-1b14a63002f0')
AddEventHandler('0450592c-ed62-4cc2-8d0e-1b14a63002f0', function( player )


		--local ped = GetPlayerPed(player)
		
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		if closestDistance > 3.0 then
			ESX.ShowNotification('~r~Bugger~w~ No one is near you to swab DNA from.')
		else
			ESX.ShowNotification('~g~Grabbed~w~ DNA from the person and sent it to the lab.')
			TriggerServerEvent('c508fc3c-a895-46f7-89a8-111d29365c25',GetPlayerServerId(closestPlayer))
		end

end)


