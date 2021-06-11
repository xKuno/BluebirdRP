local hospitalCheckin = { x = 308.69, y =  -591.97, z = 43.491839599609, h = 180.4409942627 }

local hospitalCheckinSandy = { x = 1828.32, y = 3685.03 , z =  34.37, h = 66.05 }

local hospitalCheckinPaleto = { x = -255.32, y = 6329.6 , z =  32.61, h = 186.12}

local hospitalMelbParamedic = {x = 340.07366943359, y = -584.72515869141, z= 28.896863555908, h =140.1}

local hospitalMtZonah = {x = -436.13702392, y = -326.27288860156, z= 34.910774, h =140.1}

local hospitalBunnings = {x = 2678.48, y = 3441.73, z= 41.5, h =304}


local pillboxTeleports = {
    { x = 325.48892211914, y = -598.75372314453, z = 43.291839599609, h = 64.513374328613, text = 'Press ~INPUT_CONTEXT~ ~s~to go to lower Pillbox Entrance' },
    { x = 355.47183227539, y = -596.26495361328, z = 28.773477554321, h = 245.85662841797, text = 'Press ~INPUT_CONTEXT~ ~s~to enter Pillbox Hospital' },
    { x = 359.57849121094, y = -584.90911865234, z = 28.817169189453, h = 245.85662841797, text = 'Press ~INPUT_CONTEXT~ ~s~to enter Pillbox Hospital' },
}

local bedOccupying = nil
local bedOccupyingData = nil

local cam = nil

local inBedDict = "anim@gangops@morgue@table@"
local inBedAnim = "ko_front"
local getOutDict = 'switch@franklin@bed'
local getOutAnim = 'sleep_getup_rubeyes'
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function PrintHelpText(message)
    SetTextComponentFormat("STRING")
    AddTextComponentString(message)
    DisplayHelpTextFromStringLabel(0, 0, 1, -1)
end

function LeaveBed()
    RequestAnimDict(getOutDict)
    while not HasAnimDictLoaded(getOutDict) do
        Citizen.Wait(0)
    end

    RenderScriptCams(0, true, 200, true, true)
    DestroyCam(cam, false)

    SetEntityHeading(PlayerPedId(), bedOccupyingData.h - 90)
    TaskPlayAnim(PlayerPedId(), getOutDict , getOutAnim ,8.0, -8.0, -1, 0, 0, false, false, false )
    Citizen.Wait(5000)
    ClearPedTasks(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)
    TriggerServerEvent('2d5f9841-5200-4ba9-bcf7-5d57d7dc83df', bedOccupying)

    bedOccupying = nil
    bedOccupyingData = nil
	TriggerEvent('749862c0-d5c2-4904-a643-f69db2d94845',false)
end

RegisterNetEvent('05cc2c6b-243e-4fb3-8bb4-33caba181e1d')
AddEventHandler('05cc2c6b-243e-4fb3-8bb4-33caba181e1d', function()
    TriggerServerEvent('7f91430c-5cee-4db5-8a12-29dede7ad1c4', GetEntityCoords(PlayerPedId()))
end)

RegisterNetEvent('52dbd0e6-70e9-45db-8f59-b2ce26dd33a4')
AddEventHandler('52dbd0e6-70e9-45db-8f59-b2ce26dd33a4', function(id, data)
    bedOccupying = id
    bedOccupyingData = data

    SetEntityCoords(PlayerPedId(), data.x, data.y, data.z - 0.5)
    
    RequestAnimDict(inBedDict)
    while not HasAnimDictLoaded(inBedDict) do
        Citizen.Wait(0)
    end
	
    TaskPlayAnim(PlayerPedId(), inBedDict , inBedAnim ,8.0, -8.0, -1, 1, 0, false, false, false )
    SetEntityHeading(PlayerPedId(), data.h + 180)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
    AttachCamToPedBone(cam, PlayerPedId(), 31085, 0, 0, 1.0 , true)
    SetCamFov(cam, 90.0)
    SetCamRot(cam, -90.0, 0.0, GetEntityHeading(PlayerPedId()) + 180, true)
            
	exports['mythic_notify']:DoHudText('inform', 'You are going to be ok... but it will take some time.')
    Citizen.CreateThread(function()
        while bedOccupyingData ~= nil do
            Citizen.Wait(60000)
            PrintHelpText('Press ~INPUT_VEH_DUCK~ to get up')
            if IsControlJustReleased(0, 73) then
                LeaveBed()
            end
        end
    end)
end)

RegisterNetEvent('a0ca9ebb-1a25-4b89-85c5-076a3157cdd2')
AddEventHandler('a0ca9ebb-1a25-4b89-85c5-076a3157cdd2', function(id, data)
    bedOccupying = id
    bedOccupyingData = data
	TriggerEvent('749862c0-d5c2-4904-a643-f69db2d94845',true)
    SetEntityCoords(PlayerPedId(), data.x, data.y, data.z - 0.3)
    RequestAnimDict(inBedDict)
    while not HasAnimDictLoaded(inBedDict) do
        Citizen.Wait(0)
    end
    TaskPlayAnim(PlayerPedId(), inBedDict , inBedAnim ,8.0, -8.0, -1, 1, 0, false, false, false )
    SetEntityHeading(PlayerPedId(), data.h + 180)

    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 1)
    SetCamActive(cam, true)
    RenderScriptCams(true, false, 1, true, true)
    AttachCamToPedBone(cam, PlayerPedId(), 31085, 0, 0, 1.0 , true)
    SetCamFov(cam, 90.0)
    SetCamRot(cam, -90.0, 0.0, GetEntityHeading(PlayerPedId()) + 180, true)
	
	TriggerEvent('09369327-4455-4fca-aadc-9608cc3422d1', "all")
	TriggerEvent(  'MF_SkeletalSystem:HealBonesN', "all")
	TriggerServerEvent('9341598e-bf2f-4bc0-a1e2-847c8bbd8112')

    Citizen.CreateThread(function ()
        Citizen.Wait(5)
        local player = PlayerPedId()
		SetEntityHealth(PlayerPedId(), 200)
        exports['mythic_notify']:DoCustomHudText('inform', 'Doctors Are Treating You', 60000)
		Citizen.Wait(20000)
		exports['mythic_notify']:DoCustomHudText('inform', 'You are going to be ok... but it will take some time.', 30000)
		Citizen.Wait(35000)
		exports['mythic_notify']:DoCustomHudText('inform', "Hang in there, we're just finishing up", 30000)
        Citizen.Wait(35000)
        TriggerServerEvent('83d41195-2a57-40f9-878f-4c1d5daaf62a',data.location)
    end)
end)

RegisterNetEvent('21397a08-225c-4766-98cd-0eb820c29252')
AddEventHandler('21397a08-225c-4766-98cd-0eb820c29252', function()

	SetEntityHealth(PlayerPedId(), 200)			
	SetPedArmour(PlayerPedId(), 0)
	ClearPedEnvDirt(PlayerPedId())
	ClearPedBloodDamage(PlayerPedId())
	ResetPedVisibleDamage(PlayerPedId())
	ClearPedLastWeaponDamage(PlayerPedId())
	ResetPedMovementClipset(PlayerPedId(), 0)
	SetEntityInvincible(PlayerPedId(),false)
	SetPedDiesInWater(PlayerPedId(),true)
	SetPedArmour(PlayerPedId(), 0)
	ClearPedEnvDirt(PlayerPedId())
	ClearPedBloodDamage(PlayerPedId())
	ResetPedVisibleDamage(PlayerPedId())
	ClearPedLastWeaponDamage(PlayerPedId())
	ResetPedMovementClipset(PlayerPedId(), 0)

	TriggerEvent('09369327-4455-4fca-aadc-9608cc3422d1', "all")
	TriggerEvent(  'MF_SkeletalSystem:HealBonesN', "all")
    exports['mythic_notify']:DoHudText('inform', 'You\'ve Been Treated & Billed')
    LeaveBed()
end)

RegisterNetEvent('38b13f81-6978-4ba2-922f-8ef67abe71aa')
AddEventHandler('38b13f81-6978-4ba2-922f-8ef67abe71aa', function()
    LeaveBed()
end)
---Make Damage Persistant (Disable Auto-Heal)


Citizen.CreateThread(function()
    while true do
        Citizen.Wait(1)
			local closetohospital = false
			
			local plyCoords = GetEntityCoords(PlayerPedId(), 0)
            local distance = #(vector3(hospitalCheckin.x, hospitalCheckin.y, hospitalCheckin.z) - plyCoords)
			
			local distancePara = #(vector3(hospitalMelbParamedic.x, hospitalMelbParamedic.y, hospitalMelbParamedic.z) - plyCoords)
			
			local distanceS = #(vector3(hospitalCheckinSandy.x, hospitalCheckinSandy.y, hospitalCheckinSandy.z) - plyCoords)
			
			local distanceP = #(vector3(hospitalCheckinPaleto.x, hospitalCheckinPaleto.y, hospitalCheckinPaleto.z) - plyCoords)
			
			local distanceZ = #(vector3(hospitalMtZonah.x, hospitalMtZonah.y, hospitalMtZonah.z) - plyCoords)
			
			--Bunnings Distance
			local distanceB = #(vector3(hospitalBunnings.x, hospitalBunnings.y, hospitalBunnings.z) - plyCoords)
			
			--Bunnings Detection
			
			if distanceB < 12 then
				closetohospital = true
				DrawMarker(27, hospitalBunnings.x, hospitalBunnings.y, hospitalBunnings.z - 1.08, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, true, false, 2, false, false, false, false)
				 if not IsPedInAnyVehicle(PlayerPedId(), true) then
                    if distanceB < 2 then
                        PrintHelpText('Press ~INPUT_CONTEXT~ ~s~to check in')
						ESX.Game.Utils.DrawText3D(vector3(hospitalBunnings.x, hospitalBunnings.y, hospitalBunnings.z + 0.1), '[E] Check in to Hospital', 0.4)
                        if IsControlJustReleased(0, 54) or IsDisabledControlJustReleased(0, 54) then
							if not IsEntityAttached(PlayerPedId()) then
                                exports['mythic_progbar']:Progress({
                                    name = "hospital_action",
                                    duration = 10500,
                                    label = "Checking In",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "missheistdockssetup1clipboard@base",
                                        anim = "base",
                                        flags = 49,
                                    },


                                }, function(status)
                                    if not status then
									
										if IsPedRagdoll(PlayerPedId()) then
											TriggerEvent('c97adeb3-14e4-4be0-b519-a93d5ee530f3')
											Wait(8000)
										end
										Wait(300)
                                        TriggerServerEvent('2a6021bb-9d57-435f-beec-0ee8cd350f9d',"bunnings")
										
                                    end
                                end)
							else
								ESX.ShowNotification("~r~Error:~w~ You must get off first")
							end
						else
                        end
                    end
                end
			end
			
			--Paleto
			
			if distanceP < 12 then
				closetohospital = true
				DrawMarker(27, hospitalCheckinPaleto.x, hospitalCheckinPaleto.y, hospitalCheckinPaleto.z - 1.08, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, true, false, 2, false, false, false, false)
				 if not IsPedInAnyVehicle(PlayerPedId(), true) then
                    if distanceP < 2 then
                        PrintHelpText('Press ~INPUT_CONTEXT~ ~s~to check in')
						ESX.Game.Utils.DrawText3D(vector3(hospitalCheckinPaleto.x, hospitalCheckinPaleto.y, hospitalCheckinPaleto.z + 0.1), '[E] Check in to Hospital', 0.4)
                        if IsControlJustReleased(0, 54) or IsDisabledControlJustReleased(0, 54) then
							if not IsEntityAttached(PlayerPedId()) then
                                exports['mythic_progbar']:Progress({
                                    name = "hospital_action",
                                    duration = 10500,
                                    label = "Checking In",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "missheistdockssetup1clipboard@base",
                                        anim = "base",
                                        flags = 49,
                                    },


                                }, function(status)
                                    if not status then
									
										if IsPedRagdoll(PlayerPedId()) then
											TriggerEvent('c97adeb3-14e4-4be0-b519-a93d5ee530f3')
											Wait(8000)
										end
										Wait(300)
                                        TriggerServerEvent('2a6021bb-9d57-435f-beec-0ee8cd350f9d',"paleto")
										
                                    end
                                end)
							else
								ESX.ShowNotification("~r~Error:~w~ You must get off first")
							end
						else
                        end
                    end
                end
			end
			
			--Sandy
			if distanceS < 16 then
				closetohospital = true
				DrawMarker(27, hospitalCheckinSandy.x, hospitalCheckinSandy.y, hospitalCheckinSandy.z - 1.08, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, true, false, 2, false, false, false, false)
				 if not IsPedInAnyVehicle(PlayerPedId(), true) then
                    if distanceS < 2 then
                        PrintHelpText('Press ~INPUT_CONTEXT~ ~s~to check in')
						ESX.Game.Utils.DrawText3D(vector3(hospitalCheckinSandy.x, hospitalCheckinSandy.y, hospitalCheckinSandy.z + 0.1), '[E] Check in to Hospital', 0.4)
                        if IsControlJustReleased(0, 54) or IsDisabledControlJustReleased(0, 54) then

							if not IsEntityAttached(PlayerPedId()) then
                                exports['mythic_progbar']:Progress({
                                    name = "hospital_action",
                                    duration = 10500,
                                    label = "Checking In",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "missheistdockssetup1clipboard@base",
                                        anim = "base",
                                        flags = 49,
                                    },


                                }, function(status)
                                    if not status then
									
										if IsPedRagdoll(PlayerPedId()) then
											TriggerEvent('c97adeb3-14e4-4be0-b519-a93d5ee530f3')
											Wait(8000)
										end
										Wait(300)
                                        TriggerServerEvent('2a6021bb-9d57-435f-beec-0ee8cd350f9d',"sandy")
										
                                    end
                                end)
								
							else
								ESX.ShowNotification("~r~Error:~w~ You must get off first")
							end

                        end
                    end
                end
			end
			
			--Mt Zonah
            if distanceZ < 16 then
				closetohospital = true
                DrawMarker(27, hospitalMtZonah.x, hospitalMtZonah.y, hospitalMtZonah.z - 0.95, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, true, false, 2, false, false, false, false)

                if not IsPedInAnyVehicle(PlayerPedId(), true) then
                    if distanceZ < 2 then
                     PrintHelpText('Press ~INPUT_CONTEXT~ ~s~to check in')
					ESX.Game.Utils.DrawText3D(vector3(hospitalMtZonah.x, hospitalMtZonah.y, hospitalMtZonah.z + 0.5), '[E] Check in to Hospital', 0.4)
                        if IsControlJustReleased(0, 54) or IsDisabledControlJustReleased(0, 54) then
						
							if not IsEntityAttached(PlayerPedId()) then
	
                                exports['mythic_progbar']:Progress({
                                    name = "hospital_action",
                                    duration = 10500,
                                    label = "Checking In",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "missheistdockssetup1clipboard@base",
                                        anim = "base",
                                        flags = 49,
                                    },
                                 --[[   prop = {
                                        model = "p_amb_clipboard_01",
                                        bone = 18905,
										coords = { x = 0.10, y = 0.02, z = 0.08 },
										rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                    propTwo = {
                                        model = "prop_pencil_01",
                                        bone = 58866,
										coords = { x = 0.12, y = 0.0, z = 0.001 },
										rotation = { x = -150.0, y = 0.0, z = 0.0 },
                                    },]]
                                }, function(status)
                                    if not status then
									
										if IsPedRagdoll(PlayerPedId()) then
											TriggerEvent('c97adeb3-14e4-4be0-b519-a93d5ee530f3')
											Wait(8000)
										end
										Wait(300)
                                        TriggerServerEvent('2a6021bb-9d57-435f-beec-0ee8cd350f9d',"zonah")
										
                                    end
                                end)
								
							else
								ESX.ShowNotification("~r~Error:~w~ You must get off first")
							end

                        end
                    end
                end
            end
			
			--City
            if distance < 16 then
				closetohospital = true
                DrawMarker(27, hospitalCheckin.x, hospitalCheckin.y, hospitalCheckin.z - 1.08, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, true, false, 2, false, false, false, false)

                if not IsPedInAnyVehicle(PlayerPedId(), true) then
                    if distance < 2 then
                     PrintHelpText('Press ~INPUT_CONTEXT~ ~s~to check in')
					ESX.Game.Utils.DrawText3D(vector3(hospitalCheckin.x, hospitalCheckin.y, hospitalCheckin.z + 0.5), '[E] Check in to Hospital', 0.4)
                        if IsControlJustReleased(0, 54) or IsDisabledControlJustReleased(0, 54) then
						
							if not IsEntityAttached(PlayerPedId()) then
	
                                exports['mythic_progbar']:Progress({
                                    name = "hospital_action",
                                    duration = 10500,
                                    label = "Checking In",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "missheistdockssetup1clipboard@base",
                                        anim = "base",
                                        flags = 49,
                                    },
                                 --[[   prop = {
                                        model = "p_amb_clipboard_01",
                                        bone = 18905,
										coords = { x = 0.10, y = 0.02, z = 0.08 },
										rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                    propTwo = {
                                        model = "prop_pencil_01",
                                        bone = 58866,
										coords = { x = 0.12, y = 0.0, z = 0.001 },
										rotation = { x = -150.0, y = 0.0, z = 0.0 },
                                    },]]
                                }, function(status)
                                    if not status then
									
										if IsPedRagdoll(PlayerPedId()) then
											TriggerEvent('c97adeb3-14e4-4be0-b519-a93d5ee530f3')
											Wait(8000)
										end
										Wait(300)
                                        TriggerServerEvent('2a6021bb-9d57-435f-beec-0ee8cd350f9d',"city")
										
                                    end
                                end)
								
							else
								ESX.ShowNotification("~r~Error:~w~ You must get off first")
							end

                        end
                    end
                end
            end
			
			
			if distancePara < 16 then
				closetohospital = true
                DrawMarker(27, hospitalMelbParamedic.x, hospitalMelbParamedic.y, hospitalMelbParamedic.z - 1.08, 0, 0, 0, 0, 0, 0, 0.5, 0.5, 1.0, 1, 157, 0, 155, true, false, 2, false, false, false, false)

                if not IsPedInAnyVehicle(PlayerPedId(), true) then
                    if distancePara < 2 then
                     PrintHelpText('Press ~INPUT_CONTEXT~ ~s~to check in')
					ESX.Game.Utils.DrawText3D(vector3(hospitalMelbParamedic.x, hospitalMelbParamedic.y, hospitalMelbParamedic.z + 0.5), '[E] Check in to Hospital', 0.4)
                        if IsControlJustReleased(0, 54) or IsDisabledControlJustReleased(0, 54) then
						
							if not IsEntityAttached(PlayerPedId()) then
	
                                exports['mythic_progbar']:Progress({
                                    name = "hospital_action",
                                    duration = 10500,
                                    label = "Checking In",
                                    useWhileDead = false,
                                    canCancel = true,
                                    controlDisables = {
                                        disableMovement = true,
                                        disableCarMovement = true,
                                        disableMouse = false,
                                        disableCombat = true,
                                    },
                                    animation = {
                                        animDict = "missheistdockssetup1clipboard@base",
                                        anim = "base",
                                        flags = 49,
                                    },
                                 --[[   prop = {
                                        model = "p_amb_clipboard_01",
                                        bone = 18905,
										coords = { x = 0.10, y = 0.02, z = 0.08 },
										rotation = { x = -80.0, y = 0.0, z = 0.0 },
                                    },
                                    propTwo = {
                                        model = "prop_pencil_01",
                                        bone = 58866,
										coords = { x = 0.12, y = 0.0, z = 0.001 },
										rotation = { x = -150.0, y = 0.0, z = 0.0 },
                                    },]]
                                }, function(status)
                                    if not status then
									
										if IsPedRagdoll(PlayerPedId()) then
											TriggerEvent('c97adeb3-14e4-4be0-b519-a93d5ee530f3')
											Wait(8000)
										end
										Wait(300)
                                        TriggerServerEvent('2a6021bb-9d57-435f-beec-0ee8cd350f9d',"city")
										
                                    end
                                end)
								
							else
								ESX.ShowNotification("~r~Error:~w~ You must get off first")
							end

                        end
                    end
                end
            end
		
			
		if closetohospital == false then
			Wait(2000)
		end
    end
end)
