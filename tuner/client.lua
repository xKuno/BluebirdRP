local menu = false
ESX = nil

defaultVehicleValues = {}

function getVehData(veh)
    if not DoesEntityExist(veh) then return nil end
	
	if defaultVehicleValues[Get] == nil then
		local cardeets = ESX.Game.GetVehicleProperties(veh)
		defaultVehicleValues[cardeets.plate] = {

				fClutchChangeRateScaleUpShift = GetVehicleHandlingFloat(veh, "CHandlingData", "fClutchChangeRateScaleUpShift"),
				fClutchChangeRateScaleDownShift = GetVehicleHandlingFloat(veh, "CHandlingData", "fClutchChangeRateScaleDownShift"),
				fBrakeBiasFront = GetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeBiasFront"),
				fInitialDragCoeff = GetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDragCoeff"),
				fLowSpeedTractionLossMult = GetVehicleHandlingFloat(veh, "CHandlingData", "fLowSpeedTractionLossMult"),
				boost = GetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveForce"),
				fuelmix = GetVehicleHandlingFloat(veh, "CHandlingData", "fDriveInertia"),
				braking = GetVehicleHandlingFloat(veh ,"CHandlingData", "fBrakeBiasFront"),
				drivetrain = GetVehicleHandlingFloat(veh, "CHandlingData", "fDriveBiasFront"),
				brakeforce = GetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeForce")
				
			}
	end
    local lvehstats = {
        boost = GetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveForce"),
        fuelmix = GetVehicleHandlingFloat(veh, "CHandlingData", "fDriveInertia"),
        braking = GetVehicleHandlingFloat(veh ,"CHandlingData", "fBrakeBiasFront"),
        drivetrain = GetVehicleHandlingFloat(veh, "CHandlingData", "fDriveBiasFront"),
        brakeforce = GetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeForce")
    }
    return lvehstats
end

--[[
        fClutchChangeRateScaleUpShift: GetVehicleHandlingFloat(vehicle, "CHandlingData", "fClutchChangeRateScaleUpShift"),
        fClutchChangeRateScaleDownShift: GetVehicleHandlingFloat(vehicle, "CHandlingData", "fClutchChangeRateScaleDownShift"),
		fBrakeBiasFront: GetVehicleHandlingFloat(vehicle, "CHandlingData", "fBrakeBiasFront"),
		fInitialDragCoeff: GetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDragCoeff"),
		fLowSpeedTractionLossMult: GetVehicleHandlingFloat(vehicle, "CHandlingData", "fLowSpeedTractionLossMult"),

--]]

		
function setVehData(veh,data)
    if not DoesEntityExist(veh) or not data then return nil end
	local cardeets = ESX.Game.GetVehicleProperties(veh)
	print(json.encode(data))
    SetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveForce", data.boost*1.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveInertia", data.fuelmix*1.0)
    SetVehicleEnginePowerMultiplier(veh, data.gearchange*1.0)
	if data.gearchange then
		print(data.gearchange)
	    local newDrag = (defaultVehicleValues[cardeets.plate].fInitialDragCoeff + (data.gearchange / 45));
		SetVehicleHandlingFloat(vehicle, "CHandlingData", "fClutchChangeRateScaleUpShift", data.gearchange)
		SetVehicleHandlingFloat(vehicle, "CHandlingData", "fClutchChangeRateScaleDownShift", data.gearchange)
		SetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDragCoeff", newDrag)
	end
    SetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeBiasFront", data.braking*1.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveBiasFront", data.drivetrain*1.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeForce", data.brakeforce*1.0)

    TriggerServerEvent('c3fed86f-c46f-436f-94b8-1262ca6eb9f1',data,cardeets)
end

function setVehDataNS(veh,data)
	print('has vehicle data')
	print(veh)
	print(data)
    if not DoesEntityExist(veh) or not data then return nil end
	local cardeets = ESX.Game.GetVehicleProperties(veh)
	print('load vehicle save data')
	getVehData(veh)
	data = json.decode(data)
	

    SetVehicleHandlingFloat(veh, "CHandlingData", "fInitialDriveForce", data.boost*1.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveInertia", data.fuelmix*1.0)
    SetVehicleEnginePowerMultiplier(veh, data.gearchange*1.0)
	if data.gearchange then
		print('data gear change')
		print(data.gearchange)
		print('new drag')
	    local newDrag = (defaultVehicleValues[cardeets.plate].fInitialDragCoeff + (data.gearchange / 45));
		SetVehicleHandlingFloat(vehicle, "CHandlingData", "fClutchChangeRateScaleUpShift", data.gearchange)
		SetVehicleHandlingFloat(vehicle, "CHandlingData", "fClutchChangeRateScaleDownShift", data.gearchange)
		SetVehicleHandlingFloat(vehicle, "CHandlingData", "fInitialDragCoeff", newDrag)
	end
    SetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeBiasFront", data.braking*1.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fDriveBiasFront", data.drivetrain*1.0)
    SetVehicleHandlingFloat(veh, "CHandlingData", "fBrakeForce", data.brakeforce*1.0)
end

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function toggleMenu(b,send)
    menu = b
    SetNuiFocus(b,b)
    local vehData = getVehData(GetVehiclePedIsIn(GetPlayerPed(-1),false))
    if send then SendNUIMessage(({type = "togglemenu", state = b, data = vehData})) end
end

RegisterNUICallback("togglemenu",function(data,cb)
    toggleMenu(data.state,false)
end)

RegisterNUICallback("save",function(data,cb)
    local veh = GetVehiclePedIsIn(GetPlayerPed(-1),false)
    if not IsPedInAnyVehicle(GetPlayerPed(-1)) or GetPedInVehicleSeat(veh, -1)~=GetPlayerPed(-1) then return end
    setVehData(veh,data)
    lastVeh = veh
    lastStats = stats
end)

RegisterNetEvent('dba8abc7-3e9e-4f9f-b7d2-dfdc490cf2d3')
AddEventHandler('dba8abc7-3e9e-4f9f-b7d2-dfdc490cf2d3', function()

	local vehicle = GetVehiclePedIsIn(GetPlayerPed(-1),false)

    if not menu then
        exports['progressBars']:startUI(2500, "Connecting Tuner Chip")
        TriggerEvent('a96f43b3-7942-4e85-88eb-620f868bbac7')
        Citizen.Wait(2500)
        TriggerEvent('a96f43b3-7942-4e85-88eb-620f868bbac7')
        local ped = GetPlayerPed(-1)
        toggleMenu(true,true)
        while IsPedInAnyVehicle(ped, false) and GetPedInVehicleSeat(GetVehiclePedIsIn(ped, false), -1)==ped do
            Citizen.Wait(100)
        end
        toggleMenu(false,true)
    else
        return
    end
end)

RegisterNetEvent('e2687247-9a9f-44e3-8629-d924dde9f2c3')
AddEventHandler('e2687247-9a9f-44e3-8629-d924dde9f2c3',function()
    toggleMenu(false,true)
end)

local lastVeh = false
local lastData = false
local gotOut = false
Citizen.CreateThread(function(...)
    while not ESX do Citizen.Wait(0); end
    while not ESX.IsPlayerLoaded() do Citizen.Wait(0); end
	--[[
    while true do
        Citizen.Wait(30)
        if IsPedInAnyVehicle(GetPlayerPed(-1)) then
            local veh = GetVehiclePedIsIn(GetPlayerPed(-1),false)
            if veh ~= lastVeh or gotOut then
                if gotOut then gotOut = false; end
                local responded = false
                ESX.TriggerServerCallback('a8f090ac-fc5f-4420-a1ff-6d76d3ac2431', function(doTune,stats)
                    if doTune then
                        setVehData(veh,stats)
                        lastStats = stats
                    else
                        if lastVeh and veh and lastVeh == veh and lastData then
                            setVehData(veh,lastData)
                        end
                    end
                    lastVeh = veh
                    responded = true
                end, ESX.Game.GetVehicleProperties(veh))
                while not responded do Citizen.Wait(0); end
            end
        else
            if not gotOut then
                gotOut = true
            end
        end
    end--]]
end)

RegisterCommand("untune", function(source, args)
  TriggerServerEvent('3a08b0d6-4dd3-4a31-a3da-ab113b2af527', ESX.Game.GetVehicleProperties(GetVehiclePedIsIn(GetPlayerPed(-1),false)))
end)