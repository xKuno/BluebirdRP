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

local PlayerData              = {}
local HasAlreadyEnteredMarker = false
local LastStation             = nil
local LastPart                = nil
local LastPartNum             = nil
local LastEntity              = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local IsHandcuffed            = false
local HandcuffTimer           = {}
local scarfsetting 			  = nil
local DragStatus              = {}
DragStatus.IsDragged          = false
local blipsCops               = {}
local hasAlreadyJoined        = false
local isDead                  = false
local CurrentTask             = {}
local playerInService         = false
local dragging				  = false
local myPed					  = PlayerPedId()
local myCurrentCoords          = vector3(0,0,0)

local dragging_closestPlayer  = nil

ESX                           = nil

local fine_warnings = false
local warning_text = "FALSE"

local solid_toggle = false
local solid_text = "FALSE"

local writeticketdesc = {}
local writeticketval = {}

local lastclick = 0



Citizen.CreateThread(function()
  while ESX == nil do
    Citizen.Wait(200)
  end
  while true do
	Wait(500)
	myPed = ESX.Game.GetMyPed()
	myCurrentCoords = ESX.Game.GetMyPedLocation()
  end
end)

RegisterCommand('+policelocation', function()
	if (GetGameTimer() - 5000) > lastclick then
		carlocation()
		lastclick = GetGameTimer()
	end
						
end, false)
RegisterKeyMapping('+policelocation', 'Police: Advise of Location', 'keyboard', 'end')

local priority = false
RegisterCommand('radiopri', function()
	if ESX.GetPlayerData().job.name == 'police' and  ESX.GetPlayerData().job.grade >= 7 then
		if priority == false then
			priority = true
			TriggerEvent( "mumble:togglepriority", true)
		else
			priority = false
			TriggerEvent( "mumble:togglepriority", true)
		end
	else
		ESX.ShowNotification("~r~Error: ~w~Not privileges to use this command.")
	end
end, false)



Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end

	pcall(function()  PlayerData = ESX.GetPlayerData()  end)
	

end)

function SetVehicleMaxMods(vehicle)
	local props = {
		modEngine       = 3,
		modBrakes       = 2,
		modTransmission = 2,
		modSuspension   = 2,
		modTurbo        = false,
	}

	ESX.Game.SetVehicleProperties(vehicle, props)
end


function cleanPlayer(playerPed)
	SetPedArmour(playerPed, 0)
	ClearPedBloodDamage(playerPed)
	ResetPedVisibleDamage(playerPed)
	ClearPedLastWeaponDamage(playerPed)
	ResetPedMovementClipset(playerPed, 0)
end


function setUniform(job, playerPed)
	TriggerEvent('d3bdbe20-bf7d-4df2-9ef6-9026a86a6e87', function(skin)
		if job == 'cirt_wear' then
			loadmodeln(GetHashKey('s_m_m_snowcop_01'))
			return
		end
	
		if skin.sex == 0 then
			if Config.Uniforms[('A'..PlayerData.job.grade)] ~= nil then
				TriggerEvent('1d09cf94-2c53-4220-a089-0339ce8bb123', skin, Config.Uniforms[('A'..PlayerData.job.grade)].male)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end

			if job == 'bullet_wear' then
				SetPedArmour(playerPed, 200)
				--GivePedHelmet(GetPlayerPed(-1),1,1024)
			end
			
			if job == 'phbullet_wear' then
				SetPedArmour(playerPed, 200)
				GivePedHelmet(GetPlayerPed(-1),1,1024)
			end
			
		else
			if Config.Uniforms[('A'..PlayerData.job.grade)].female ~= nil then
				TriggerEvent('1d09cf94-2c53-4220-a089-0339ce8bb123', skin, Config.Uniforms[('A'..PlayerData.job.grade)].female)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end

			if job == 'bullet_wear' then
				SetPedArmour(playerPed, 100)
			end
		end
	end)
end

function setUniformLS(job, playerPed)
	TriggerEvent('d3bdbe20-bf7d-4df2-9ef6-9026a86a6e87', function(skin)
		if job == 'cirt_wear' then
			loadmodeln(GetHashKey('s_m_m_snowcop_01'))
			return
		end
	
		if skin.sex == 0 then
			if Config.Uniforms[('D'..PlayerData.job.grade)] ~= nil then
				TriggerEvent('1d09cf94-2c53-4220-a089-0339ce8bb123', skin, Config.Uniforms[('D'..PlayerData.job.grade)].male)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end

			if job == 'bullet_wear' then
				SetPedArmour(playerPed, 200)
				--GivePedHelmet(GetPlayerPed(-1),1,1024)
			end
			
			if job == 'phbullet_wear' then
				SetPedArmour(playerPed, 200)
				GivePedHelmet(GetPlayerPed(-1),1,1024)
			end
			
		else
			if Config.Uniforms[('D'..PlayerData.job.grade)].female ~= nil then
				TriggerEvent('1d09cf94-2c53-4220-a089-0339ce8bb123', skin, Config.Uniforms[('D'..PlayerData.job.grade)].female)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end

			if job == 'bullet_wear' then
				SetPedArmour(playerPed, 100)
			end
		end
	end)
end

function setUniformBBHV(job, playerPed)
	TriggerEvent('d3bdbe20-bf7d-4df2-9ef6-9026a86a6e87', function(skin)
		if job == 'cirt_wear' then
			loadmodeln(GetHashKey('s_m_m_snowcop_01'))
			return
		end
	
		if skin.sex == 0 then
			if Config.Uniforms[('BBHV'..PlayerData.job.grade)] ~= nil then
				TriggerEvent('1d09cf94-2c53-4220-a089-0339ce8bb123', skin, Config.Uniforms[('BBHV'..PlayerData.job.grade)].male)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end

			if job == 'bullet_wear' then
				SetPedArmour(playerPed, 200)
				--GivePedHelmet(GetPlayerPed(-1),1,1024)
			end
			
			if job == 'phbullet_wear' then
				SetPedArmour(playerPed, 200)
				GivePedHelmet(GetPlayerPed(-1),1,1024)
			end
			
		else
			if Config.Uniforms[('BBHV'..PlayerData.job.grade)].female ~= nil then
				TriggerEvent('1d09cf94-2c53-4220-a089-0339ce8bb123', skin, Config.Uniforms[('BBHV'..PlayerData.job.grade)].female)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end

			if job == 'bullet_wear' then
				SetPedArmour(playerPed, 100)
			end
		end
	end)
end

function setUniformBBV(job, playerPed)
	TriggerEvent('d3bdbe20-bf7d-4df2-9ef6-9026a86a6e87', function(skin)
		if job == 'cirt_wear' then
			loadmodeln(GetHashKey('s_m_m_snowcop_01'))
			return
		end
		print('bbv')
		if skin.sex == 0 then
			if Config.Uniforms[('BBV'..PlayerData.job.grade)] ~= nil then
				TriggerEvent('1d09cf94-2c53-4220-a089-0339ce8bb123', skin, Config.Uniforms[('BBV'..PlayerData.job.grade)].male)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end

			if job == 'bullet_wear' then
				SetPedArmour(playerPed, 200)
				--GivePedHelmet(GetPlayerPed(-1),1,1024)
			end
			
			if job == 'phbullet_wear' then
				SetPedArmour(playerPed, 200)
				GivePedHelmet(GetPlayerPed(-1),1,1024)
			end
			
		else
			if Config.Uniforms[('BBV'..PlayerData.job.grade)].female ~= nil then
				TriggerEvent('1d09cf94-2c53-4220-a089-0339ce8bb123', skin, Config.Uniforms[('BBV'..PlayerData.job.grade)].female)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end

			if job == 'bullet_wear' then
				SetPedArmour(playerPed, 100)
			end
		end
	end)
end




function setUniformB(job, playerPed)
	TriggerEvent('d3bdbe20-bf7d-4df2-9ef6-9026a86a6e87', function(skin)
	
		if skin.sex == 0 then

			if Config.Uniforms[('C'..PlayerData.job.grade)] ~= nil then
				TriggerEvent('1d09cf94-2c53-4220-a089-0339ce8bb123', skin, Config.Uniforms[('C'..PlayerData.job.grade)].male)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end

			if job == 'bullet_wear' then
				SetPedArmour(playerPed, 200)
				--GivePedHelmet(GetPlayerPed(-1),1,1024)
			end
			
			if job == 'phbullet_wear' then
				SetPedArmour(playerPed, 200)
				GivePedHelmet(GetPlayerPed(-1),1,1024)
			end
			
		else
			if Config.Uniforms[('C'..PlayerData.job.grade)].female ~= nil then
				TriggerEvent('1d09cf94-2c53-4220-a089-0339ce8bb123', skin, Config.Uniforms[('C'..PlayerData.job.grade)].female)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end

			if job == 'bullet_wear' then
				SetPedArmour(playerPed, 100)
			end
		end
	end)
end

function setUniformV(typez, playerPed)
	TriggerEvent('d3bdbe20-bf7d-4df2-9ef6-9026a86a6e87', function(skin)
		if skin.sex == 0 then
			if Config.Uniforms[typez] ~= nil then
				TriggerEvent('1d09cf94-2c53-4220-a089-0339ce8bb123', skin, Config.Uniforms[typez].male)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end


		else
			if Config.Uniforms[typez].female ~= nil then
				TriggerEvent('1d09cf94-2c53-4220-a089-0339ce8bb123', skin, Config.Uniforms[typez].female)
			else
				ESX.ShowNotification(_U('no_outfit'))
			end


		end
	end)
end


function setcuffs(state, playerPed)

	TriggerEvent('d3bdbe20-bf7d-4df2-9ef6-9026a86a6e87', function(skin)
		if skin.sex == 0 then
			--males
			if state == true then
				-- true cuffs
				scarfsetting = GetPedDrawableVariation(GetPlayerPed(-1),7)
				SetPedComponentVariation(GetPlayerPed(-1),7,41,0,0)
				
			else
				if scarfsetting == nil then
					SetPedComponentVariation(GetPlayerPed(-1),7,0,0,0)
				elseif scarfsetting == 41 then
					SetPedComponentVariation(GetPlayerPed(-1),7,0,0,0)
				else
					SetPedComponentVariation(GetPlayerPed(-1),7,scarfsetting,0,0)
				end
			end

		else
		--female
			if state == true then
				scarfsetting = GetPedDrawableVariation(GetPlayerPed(-1),7)
				SetPedComponentVariation(GetPlayerPed(-1),7,25,0,0)
			else
				
				if scarfsetting == nil then
					SetPedComponentVariation(GetPlayerPed(-1),7,0,0,0)
				elseif scarfsetting == 25 then
					SetPedComponentVariation(GetPlayerPed(-1),7,0,0,0)
				else
					SetPedComponentVariation(GetPlayerPed(-1),7,scarfsetting,0,0)
				end
				
			end

		end
	end)
end



function setUniformO(job, playerPed)

		-- 368603149
		
		if job == 'cirt_wear' then
				loadmodeln(GetHashKey('s_m_m_snowcop_01'))
		
		elseif PlayerData.job.grade >= 50 then
		
			loadmodeln(2237544099)
			SetPedComponentVariation(GetPlayerPed(-1), 8, 2, 0, 2)
			SetPedComponentVariation(GetPlayerPed(-1), 9, 1, 0, 2)
			SetPedComponentVariation(GetPlayerPed(-1), 9, 2, 0, 2)
		
		elseif PlayerData.job.grade == 0 then
			
			
			
			loadmodeln(1349953339)
			SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 0)  --First Constable

			
		elseif PlayerData.job.grade == 1 then
			
			loadmodeln(1349953339)
			SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 0)  --First Constable

			
		elseif PlayerData.job.grade == 2 then
			loadmodeln(1581098148)
			SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 0)  --First Constable

		elseif PlayerData.job.grade == 3 then
			loadmodeln(1456041926)
			SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 1, 0)  --Senior
			SetPedComponentVariation(GetPlayerPed(-1), 0, 1, 0, 0)

		elseif PlayerData.job.grade == 4 then
			loadmodeln(1456041926)
			SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 0) 
		elseif PlayerData.job.grade == 5 or PlayerData.job.grade == -5 then
			loadmodeln(1456041926)
			SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 0) 
			--SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 1) 
			--SetPedComponentVariation(GetPlayerPed(-1), 9, 2, 0, 1)
			--SetPedComponentVariation(GetPlayerPed(-1),0, 2, 0, 0)
			SetPedComponentVariation(GetPlayerPed(-1),0, 2, 0, 0)
		elseif PlayerData.job.grade == 6 or PlayerData.job.grade == -6 then
			loadmodeln(1349953339)
			SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 5, 0) 
			
		elseif PlayerData.job.grade == 7 or PlayerData.job.grade == -7 then
			loadmodeln(1581098148)
			--SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 0)  --First Constable
		else
			loadmodeln(1581098148)
			SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 0)  --First Constable

		end
		
		Wait(100)
		TriggerEvent('76822202-72be-4e7c-84ee-1530c7df06b7')

end



function loadmodeln(modelnumber)
	local model = modelnumber

	local ped = GetPlayerPed( -1 )

	if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
		SetSkin( model )
		local paletteId = 0
		local componentId = 0
		local drawableId = 10
		local textureId = 0 
		Wait(1000)
		Citizen.Trace("Setting Settings NOW")

		--SetPedComponentVariation(GetPlayerPed(-1), 11, 0, 0, 2)
		--SetPedComponentVariation(GetPlayerPed(-1), 3, 0, 0, 2)
		
		if IsPedComponentVariationValid(ped, 9, 1, 0) then
			--SetPedComponentVariation(ped, 9, 1, 0, 0) --Shirt 
		end

	end 
end

 

function SetSkin( skin )
	local ped = GetPlayerPed( -1 )

	if ( DoesEntityExist( ped ) and not IsEntityDead( ped ) ) then 
		if ( IsModelValid( skin ) ) then 
			_LoadModel( skin )
			SetPlayerModel( PlayerId(), skin )
			
			SetPedDefaultComponentVariation( PlayerId() )
			SetModelAsNoLongerNeeded( skin )
							
		end 
	end 
end 

function _LoadModel( mdl )
    while ( not HasModelLoaded( mdl ) ) do 
        RequestModel( mdl )
        Citizen.Wait( 5 )
    end 
end 

function OpenCloakroomMenu()

	local playerPed = PlayerPedId()
	local grade = PlayerData.job.grade_name

	local elements = {
		{ label = _U('citizen_wear'), value = 'citizen_wear' },
		{ label = 'CIRT', value = 'cirt_wear' },
		{ label = 'Standard Uniform Polo', value = 'standard' },
		{ label = 'Standard Uniform Shirt', value = 'standardb'},
		{ label = 'Long Sleave Shirt', value = 'standardls'},
		{ label = 'Appointments Belt', value = 'BB' },
		{ label = 'Hip Holster', value = 'HH' },
		{ label = 'Thigh Holster', value = 'TH' },
		{ label = 'Remove Belt', value = 'rbelt' },
		{ label = 'Standard Uniform Shirt', value = 'standardb'},
		{ label = 'Operational Vest', value = 'ovstandard' },
		{ label = 'Operational Vest High Vis', value = 'ovstandardhi' },
		{ label = 'Fluro Safety Vest', value = 'fluro' },
		{ label = 'Remove Vest', value = 'rovstandard' },
		{ label = 'Sun glasses', value = 'glasses' },
		{ label = 'Remove Sun glasses', value = 'rglasses' },
		{ label = 'Base Ball Cap', value = 'pbaseball' },
		{ label = 'Remove Base Ball Cap', value = 'rpbaseball' },
		{ label = 'Helmet', value = 'helmet' },
		{ label = 'Remove Helmet', value = 'rhelmet' },
		--{ label = 'Old Uniform', value = 'overalls' },
	}
	

	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'cloakroom',
	{
		title    = _U('cloakroom'),
		align    = 'top-right',
		elements = elements
	}, function(data, menu)

		cleanPlayer(playerPed)

		if data.current.value == 'citizen_wear' then
			
		
				ESX.TriggerServerCallback('4568d939-3661-4833-ae6a-378432ac6ff1', function(skin, jobSkin)
					local isMale = skin.sex == 0

					TriggerEvent('77e258c7-d610-4a49-892b-17aabf7a3aca', isMale, function()
						ESX.TriggerServerCallback('4568d939-3661-4833-ae6a-378432ac6ff1', function(skin)
							TriggerEvent('56a2ee13-8a49-4ad3-a298-1854493c98ee', skin)
						end)
					end)

				end)

			if Config.MaxInService ~= -1 then

				ESX.TriggerServerCallback('d5417c6c-8f4f-42f5-bdb7-b94a92cca4bc', function(isInService)
					if isInService then

						playerInService = false

						local notification = {
							title    = _U('service_anonunce'),
							subject  = '',
							msg      = _U('service_out_announce', GetPlayerName(PlayerId())),
							iconType = 1
						}

						TriggerServerEvent('5d7a516a-2d9c-4489-80dc-65368e4a09bf', notification, 'police')

						TriggerServerEvent('a91f16e6-8b39-4118-b7d3-68f32f337985', 'police')
						TriggerEvent('33b38819-e3bb-42aa-91d2-1a1f89b865c1')
						ESX.ShowNotification(_U('service_out'))
					end
				end, 'police')
			end

		end

		if Config.MaxInService ~= -1 and data.current.value ~= 'citizen_wear' then
			local serviceOk = 'waiting'

			ESX.TriggerServerCallback('d5417c6c-8f4f-42f5-bdb7-b94a92cca4bc', function(isInService)
				if not isInService then

					ESX.TriggerServerCallback('5ec18406-b92f-414f-8d90-64a53778ed0d', function(canTakeService, maxInService, inServiceCount)
						if not canTakeService then
							ESX.ShowNotification(_U('service_max', inServiceCount, maxInService))
						else

							serviceOk = true
							playerInService = true

							local notification = {
								title    = _U('service_anonunce'),
								subject  = '',
								msg      = _U('service_in_announce', GetPlayerName(PlayerId())),
								iconType = 1
							}
	
							TriggerServerEvent('5d7a516a-2d9c-4489-80dc-65368e4a09bf', notification, 'police')
							TriggerEvent('33b38819-e3bb-42aa-91d2-1a1f89b865c1')
							ESX.ShowNotification(_U('service_in'))
						end
					end, 'police')

				else
					serviceOk = true
				end
			end, 'police')

			while type(serviceOk) == 'string' do
				Citizen.Wait(5)
			end

			-- if we couldn't enter service don't let the player get changed
			if not serviceOk then
				return
			end
		end
		SetPedArmour(playerPed,100)
		if
			data.current.value == 'recruit_wear' or
			data.current.value == 'officer_wear' or
			data.current.value == 'sergeant_wear' or
			data.current.value == 'intendent_wear' or
			data.current.value == 'lieutenant_wear' or
			data.current.value == 'chef_wear' or
			data.current.value == 'boss_wear' or
			data.current.value == 'bullet_wear' or
			data.current.value == 'gilet_wear' or 
			data.current.value == 'cirt_wear'
		then
			setUniform(data.current.value, playerPed)
			
		end

		
		
		if
			data.current.value == 'standardb'
		then

			setUniformB(data.current.value, playerPed)
		end
		
		if
			data.current.value == 'standardls'
		then

			setUniformLS(data.current.value, playerPed)
		end
		
		if
			data.current.value == 'standard'
		then
			setUniform(data.current.value, playerPed)
		end

		if
			data.current.value == 'ovstandard'
		then
			setUniformBBV(data.current.value, playerPed)
		end
		
		
		if
			data.current.value == 'rovstandard'
		then
			setUniformV('BN', playerPed)
		end
		
		
		if
			data.current.value == 'ovstandardhi'
		then
			setUniformBBHV(data.current.value, playerPed)
		end

		if
			data.current.value == 'fluro'
		then
			setUniformV('VT', playerPed)
		end
		
		if
			data.current.value == 'BB'
		then
			setUniformV('BB', playerPed)
		end
		
		if
			data.current.value == 'TH'
		then
			setUniformV('TH', playerPed)
		end
		
		if
			data.current.value == 'HH'
		then
			setUniformV('HH', playerPed)
		end
		
				
		if
			data.current.value == 'rbelt'
		then
			setUniformV('rbelt', playerPed)
		end
		
		if
			data.current.value == 'glasses'
		then
			setUniformV('glasses', playerPed)
		end
		if
			data.current.value == 'rglasses'
		then
			setUniformV('rglasses', playerPed)
		end
				
		if
			data.current.value == 'pbaseball'
		then
			setUniformV('pbaseball', playerPed)
		end
		
		if
			data.current.value == 'rpbaseball'
		then
			setUniformV('rmbhelmet', playerPed)
		end
		
		if
			data.current.value == 'helmet'
		then
			setUniformV('mbhelmet', playerPed)
		end
		
		if
			data.current.value == 'rhelmet'
		then
		
			setUniformV('rmbhelmet', playerPed)

		end
		
		if
			data.current.value == 'overalls'
		then
			setUniformO(data.current.value, playerPed)
		end
		
		

		if data.current.value == 'freemode_ped' then
			local modelHash = ''

			ESX.TriggerServerCallback('4568d939-3661-4833-ae6a-378432ac6ff1', function(skin, jobSkin)
				if skin.sex == 0 then
					modelHash = GetHashKey(data.current.maleModel)
				else
					modelHash = GetHashKey(data.current.femaleModel)
				end

				ESX.Streaming.RequestModel(modelHash, function()
					SetPlayerModel(PlayerId(), modelHash)
					SetModelAsNoLongerNeeded(modelHash)
				end)
			end)

		end



	end, function(data, menu)
		menu.close()

		CurrentAction     = 'menu_cloakroom'
		CurrentActionMsg  = _U('open_cloackroom')
		CurrentActionData = {}
	end)
end

function OpenArmoryMenu(station)
	SetPlayerMaxArmour(GetPlayerPed(-1),200)
	SetPedArmour(GetPlayerPed(-1),200)
  if Config.EnableArmoryManagement then

    local elements = {
      {label = _U('get_weapon'),     value = 'get_weapon'},
      --{label = _U('put_weapon'),     value = 'put_weapon'},
      {label = _U('remove_object'),  value = 'get_stock'},
      {label = _U('deposit_object'), value = 'put_stock'},
	  {label = 'Deposit Dirty Money', value = 'put_dm'},
    }

    if PlayerData.job.grade_name == 'boss' then
      table.insert(elements, {label = _U('buy_weapons'), value = 'buy_weapons'})
    end

    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory',
      {
        title    = _U('armory'),
        align    = 'top-right',
        elements = elements,
      },
      function(data, menu)

        if data.current.value == 'get_weapon' then
          OpenGetWeaponMenu()
        end

        if data.current.value == 'put_weapon' then
          OpenPutWeaponMenu()
        end

        if data.current.value == 'buy_weapons' then
          OpenBuyWeaponsMenu(station)
        end

        if data.current.value == 'put_stock' then
          OpenPutStocksMenu()
        end
		
		if data.current.value == 'put_dm' then
			
			ESX.TriggerServerCallback('6ecfd81c-b7ba-4018-8825-6910bc847e43', function(done, amount)
					if done then
						ESX.ShowNotification('~g~Thanks~w~\nYou have deposited the money into Vicpol account $' .. amount .. ', ~b~Thanks Bluey!')
					else
						ESX.ShowNotification('~r~Error~w~\nYou didnt have any dirty money to deposit! - But thanks anyway!')
					end

			  end)
		end

        if data.current.value == 'get_stock' and PlayerData.job.grade_name == 'boss' then
          OpenGetStocksMenu()
		elseif data.current.value == 'get_stock' then
			ESX.ShowNotification('~r~Error~w~\nYou do not have access to remove items from the property office')
        end

      end,
      function(data, menu)

        menu.close()

        CurrentAction     = 'menu_armory'
        CurrentActionMsg  = _U('open_armory')
        CurrentActionData = {station = station}
      end
    )

  else

    local elements = {}
    for i=1, #Config.PoliceStations[station].AuthorizedWeapons, 1 do
      local weapon = Config.PoliceStations[station].AuthorizedWeapons[i]
	  if weapon == 'WEAPON_PROXMINE' then
		table.insert(elements, {label = 'Breathalyser', value = weapon.name})
	  elseif weaponList[i].name == 'WEAPON_VINTAGEPISTOL' then
		table.insert(elements, {label = 'Pro Laser III', value = weaponList[i].name})
	  else
		table.insert(elements, {label = ESX.GetWeaponLabel(weapon.name), value = weapon.name})
	  end
      
    end
	
	table.insert(elements, {label = 'First Aid Kit ||',  value = 'medikit'})
	table.insert(elements, {label = 'Bandages',  value = 'bandage'})
	table.insert(elements, {label = 'GSR Test Kit',  value = 'gsr'})
	table.insert(elements, {label = 'Evidence Bag',  value = 'evidencebag'})


    ESX.UI.Menu.CloseAll()

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory',
      {
        title    = _U('armory'),
        align    = 'top-right',
        elements = elements,
      },
      function(data, menu)
			if data.current.value == 'medikit' or data.current.value == 'gsr' or  data.current.value == 'evidencebag' then
				TriggerServerEvent('8cbb819f-d824-420c-8c14-8bd01465d4bb', data.current.value)
			elseif data.current.value == 'bandage'  or data.current.value == 'policeradio' or data.current.value == 'keycard_police' then
				TriggerServerEvent('8cbb819f-d824-420c-8c14-8bd01465d4bb', data.current.value)
			else
				local weapon = data.current.value
				TriggerServerEvent('fb31e1b0-7893-4a5e-9254-6c396cbd4e8d', weapon,  48)
			end
      end,
      function(data, menu)

        menu.close()

        CurrentAction     = 'menu_armory'
        CurrentActionMsg  = _U('open_armory')
        CurrentActionData = {station = station}

      end )

  end

end

function OpenVehicleSpawnerMenu(station, partNum)

  local vehicles = Config.PoliceStations[station].Vehicles

  ESX.UI.Menu.CloseAll()

  if Config.EnableSocietyOwnedVehicles then

    local elements = {}

    ESX.TriggerServerCallback('8def0e18-67f6-4500-a5e2-6e16aee4eb00', function(garageVehicles)

      for i=1, #garageVehicles, 1 do
	  local vname = ""
	  local model = garageVehicles[i].model
		if model == 2046537925 then
			vname = "Holden Commodore Evoke Divisional Van - GD - Silver Class"
		elseif model == -1627000575 then 
			vname = "Holden Commodore Evoke Sedan - GD - Silver Class"
		elseif model == 1912215274 then 
			vname = "Holden Commodore Evoke Wagon - GD - Silver Class"
		elseif model == -1832756583 then
			vname = "Ford Territory - GD - Silver Class"
		elseif model == -212733971 then
			vname = "Holden Commodore SS Sedan - UM/SM HWP - Gold Class"
		elseif model == 2086913645 then
			vname = "Holden Commodore SS Wagon - UM/SM HWP - Gold Class"
		elseif model == -1654050436 then
			vname = "Holden Commodore SS Wagon - HWP - Gold Class"
		elseif model == -34623805 then
			vname = "BMW Police Bike - HWP - Gold Class"
		elseif model == 1516573866 then
			vname = "Holden Commodore SS Sedan - HWP - Gold Class"
		else
			GetDisplayNameFromVehicleModel(garageVehicles[i].model)
		end
        table.insert(elements, {label = vname .. ' [' .. garageVehicles[i].plate .. ']', value = garageVehicles[i]})
		
		
      end

      ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'vehicle_spawner',
        {
          title    = _U('vehicle_menu'),
          align    = 'top-right',
          elements = elements,
        },
        function(data, menu)

          menu.close()

          local vehicleProps = data.current.value

          ESX.Game.SpawnVehicle(vehicleProps.model, vehicles[partNum].SpawnPoint, 270.0, function(vehicle)
            ESX.Game.SetVehicleProperties(vehicle, vehicleProps)
            local playerPed = GetPlayerPed(-1)
            TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
			SetEntityAsMissionEntity(vehicle,true,true)
          end)

          TriggerServerEvent('293760c8-b5e2-4800-bc04-944c4b572970', 'police', vehicleProps)

        end,
        function(data, menu)

          menu.close()

          CurrentAction     = 'menu_vehicle_spawner'
          CurrentActionMsg  = _U('vehicle_spawner')
          CurrentActionData = {station = station, partNum = partNum}

        end)

    end, 'police')

  else

    local elements = {}
	if PlayerData.job.grade > -10  and PlayerData.job.grade < 1 then
		table.insert(elements, { label = 'General Duties', value = 'gdm'})
	elseif PlayerData.job.grade >= 50 then
		table.insert(elements, { label = 'Sheriff', value = 'sheriff'})
	else
		table.insert(elements, { label = 'General Duties', value = 'gdm'})
		table.insert(elements, { label = 'Highway Patrol', value = 'hwp'})
		table.insert(elements, { label = 'Specialist Units', value = 'su'})
		if PlayerData.job.grade >= 4 then
			table.insert(elements, { label = 'Other Departments - APPROVAL REQUIRED', value = 'od'})
		end
	end

	ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'main_menu',
			{
				title    = 'Departments',
				align    = 'top-right',
				elements = elements
			}, function(data2, menu2)
			
			local elementcars = {}
			local value = data2.current.value
			if value == 'gdm' then
			
				table.insert(elementcars, { label = '--------------NON ELS---------------', value = '-'})
				table.insert(elementcars, { label = 'Ford Territory - Sedan - Silver Class', value = 'gdterry'})
				table.insert(elementcars, { label = 'Holden Commodore - Sedan - Silver Class', value = 'police2'})
				table.insert(elementcars, { label = 'Holden Commodore - Wagon - Silver Class', value = 'police3'})
				table.insert(elementcars, { label = 'Toyota Hilux - Silver Class', value = 'gdhilux2'})
				table.insert(elementcars, { label = 'Hyundai - Santa Fe - Silver Class', value = 'gdsf'})
				table.insert(elementcars, { label = 'Hyundai - Santa Fe II - Silver Class', value = 'gdsf2'})
				table.insert(elementcars, { label = 'Toyota Kluger - AWD - Silver Class', value = 'gdkluga'})
				table.insert(elementcars, { label = 'Holden Colorado 4x4 - Divvy Van - Silver Class', value = 'coldivvy'})
				table.insert(elementcars, { label = 'Holden Commodore ZB - Sedan - Silver Class', value = 'gdzbsedan'})
				 table.insert(elementcars, { label = 'Holden Commodore ZB - Wagon - Silver Class', value = 'gdzb'})
				 table.insert(elementcars, { label = 'Toyota Camry - Sedan II - Silver Class', value = 'gdcamry'})
				 table.insert(elementcars, { label = 'Hyundai - Sonata - Silver Class', value = 'gdsonata'})
				
				table.insert(elementcars, { label = '--------------ELS---------------', value = '-'})
				 table.insert(elementcars, { label = 'Holden Commodore - Divvy Van - Silver Class [ELS]', value = 'police'})
				 table.insert(elementcars, { label = 'Holden Colorado 4x4 - Silver Class [ELS]', value = 'gdcolorado'})
				  --table.insert(elementcars, { label = 'Holden Commodore - Sedan - Silver Class [ELS]', value = 'police2e'})
				  --table.insert(elementcars, { label = 'Holden Commodore - Sedan  II - Silver Class [ELS]', value = 'police2ee'})
				  --table.insert(elementcars, { label = 'Holden Commodore - Wagon - Silver Class [ELS]', value = 'police3e'})
				  --table.insert(elementcars, { label = 'Holden Commodore ZB - Wagon - Silver Class VP [ELS]', value = 'gdzb2'})
			
				  --table.insert(elementcars, { label = 'Ford Territory - Sedan - Silver Class [ELS]', value = 'gdterrye'})
				  --table.insert(elementcars, { label = 'Toyota Camry - Sedan - Silver Class [ELS]', value = 'camrygd'})
				  
				  --table.insert(elementcars, { label = 'Toyota Camry S - Sedan III - Silver Class [ELS]', value = 'gdcamry2'})
				 
				 
				  table.insert(elementcars, { label = 'Mitsubishi Pajero - 4WD - Silver Class [ELS]', value = 'gdtoyota'})
				  table.insert(elementcars, { label = 'VW Passat - Wagon - Silver Class [ELS]', value = 'gdpassat'})
				  table.insert(elementcars, { label = 'KIA Sorento - Silver Class [ELS]', value = 'gdkia'})
				  table.insert(elementcars, { label = 'GD VW T5 Van  [ELS]', value = 'gdvw'})
				 
				  table.insert(elementcars, { label = 'Toyota Landcruiser - GD 4WD - Silver Class [ELS]', value = 'hwplc'})
			elseif value == 'sheriff' then
			
				  --table.insert(elementcars, { label = 'DOJ Sheriff Camry', value = 'dojsheriff'})
				  table.insert(elementcars, { label = 'DOJ Sheriff Commodore', value = 'vicss'})
				  table.insert(elementcars, { label = 'DOJ Sheriff Divvy', value = 'vicdivvy'})


			elseif value == 'hwp' then
			
				table.insert(elementcars, { label = '--------------NON ELS---------------', value = '-'})
				table.insert(elementcars, { label = 'Ford Territory - HWP Sedan - Silver Class', value = 'hwpterry'})
				table.insert(elementcars, { label = 'BMW m5 - HWP Sedan V - Gold Class', value = 'hwpbmw5m'})
				table.insert(elementcars, { label = 'BMW 530d - HWP Wagon V - Gold Class', value = 'hwpbmwwagon2'})
				table.insert(elementcars, { label = 'BMW 530d - HWP Wagon - Gold Class', value = 'hwpbmwwagon'})
				table.insert(elementcars, { label = 'BMW 530d - HWP Sedan V - Gold Class', value = 'hwpbmw'})
			    table.insert(elementcars, { label = 'BMW 530d - HWP Sedan V Unmarked - Gold Class', value = 'hwpumbmw'})
				table.insert(elementcars, { label = 'BMW X5 - HWP SUV - Gold Class', value = 'hwpx55'})
				table.insert(elementcars, { label = 'Chrysler SRT - HWP Sedan - Gold Class', value = 'hwpcrys'})
				table.insert(elementcars, { label = 'Toyota Kluger - AWD - Gold Class', value = 'hwpkluger'})
				table.insert(elementcars, { label = 'Hyundai - Santa Fe II - Gold Class', value = 'hwpsfbb'})
				table.insert(elementcars, { label = 'Kia - Stinger - Gold Class', value = 'hwpstinger'})

				table.insert(elementcars, { label = '--------NON ELS COMMODORES------------', value = '-'})
				table.insert(elementcars, { label = 'Holden Commodore SS - HWP Wagon - Gold Class', value = 'hwpwag'})
				table.insert(elementcars, { label = 'Holden Commodore SS - HWP Wagon Unmarked - Gold Class', value = 'hwpumwag'})
				table.insert(elementcars, { label = 'Holden Commodore SS - HWP Wagon II - Gold Class', value = 'hwpwag2'})
				table.insert(elementcars, { label = 'Holden Commodore SS - HWP Wagon II Unmarked - Gold Class', value = 'umhwpwag2'})
				table.insert(elementcars, { label = 'Holden Commodore SS - HWP Sedan SI - Gold Class', value = 'hwpss1'})
				table.insert(elementcars, { label = 'Holden Commodore SS - HWP Sedan SI Unmarked - Gold Class', value = 'hwpumss1'})
				table.insert(elementcars, { label = 'Holden Commodore SS - HWP Sedan SII - Gold Class', value = 'hwpss'})
				table.insert(elementcars, { label = 'Holden Commodore SS - HWP Sedan SII N - Gold Class', value = 'hwpssn'})
				table.insert(elementcars, { label = 'Holden Commodore SS - HWP Sedan Unmarked - Gold Class', value = 'hwpumss'})
				table.insert(elementcars, { label = '--------------NON ELS---------------', value = '-'})
				--table.insert(elementcars, { label = 'Mercedes Benz - HWP Sedan - Gold Class', value = 'hwpmerc'})
				table.insert(elementcars, { label = 'HSV GTS - HWP Unmarked Sedan - Gold Class', value = 'hwpgts'})
				table.insert(elementcars, { label = 'Ford Falcon FGX - HWP Sedan - Gold Class', value = 'hwpfgx'})
				table.insert(elementcars, { label = 'Ford Falcon FGX V - HWP Sedan - Gold Class', value = 'hwpfgx1'})
				table.insert(elementcars, { label = 'Ford Falcon FGX V - HWP Unmarked Sedan - Gold Class', value = 'umhwpfgx1'})
				table.insert(elementcars, { label = 'Ford Mustang - HWP Coupe - Gold Class', value = 'hwpstang'})
				 table.insert(elementcars, { label = '----------- BIKES ------------------', value = '-'})
				
				 table.insert(elementcars, { label = 'BMW Police Motorbike - HWP Yellow Livery', value = 'policebike'})
				 table.insert(elementcars, { label = 'BMW Police Motorbike - HWP Orange Livery', value = 'policebike3'})
				 table.insert(elementcars, { label = 'BMW Police Motorbike - SHP', value = 'policebike4'})
				 table.insert(elementcars, { label = 'Police Dirt Bike - HWP', value = 'hwpb'})
				 table.insert(elementcars, { label = 'BMW Police Motorbike UM - HWP', value = 'policebum2'})
				 table.insert(elementcars, { label = '-----------------------------', value = '-'})
				 table.insert(elementcars, { label = 'VW Passat - HWP Sedan - Gold Class [ELS]', value = 'hwppassat'})
				  --table.insert(elementcars, { label = 'Holden Commodore SS - HWP Sedan - Gold Class [ELS]', value = 'hwpsse'})
				  
				 --table.insert(elementcars, { label = 'Holden Commodore SS - HWP Sedan Unmarked - Gold Class [ELS]', value = 'hwpumsse'})
				 --table.insert(elementcars, { label = 'Holden Commodore SS - HWP Ute Unmarked - Gold Class [ELS]', value = 'hwpssu'})
				--  table.insert(elementcars, { label = '-----------------------------', value = '-'})
				--  table.insert(elementcars, { label = 'BMW 530d - HWP Sedan Unmarked - Gold Class [ELS]', value = 'fbi'})
				--  table.insert(elementcars, { label = 'BMW 530d - HWP Sedan V SHP - Gold Class [ELS]', value = 'hwpbmws'})
				--  table.insert(elementcars, { label = 'BMW 530d - HWP Sedan N - Gold Class [ELS]', value = 'sheriff'})
				--  table.insert(elementcars, { label = 'BMW m5 - HWP Sedan V - Gold Class [ELS]', value = 'hwpbmw5me'})



				  --[[
				  table.insert(elementcars, { label = 'BMW X5MO - HWP SUV - Gold Class [ELS]', value = 'hwpx5'})
				table.insert(elementcars, { label = 'BMW X5MO - HWP SUV Unmarked - Gold Class [ELS]', value = 'afpumbmw'})
				table.insert(elementcars, { label = 'BMW X5M - HWP SUV - Gold Class [ELS]', value = 'hwpxx5'})			
				table.insert(elementcars, { label = 'BMW X5M - HWP SUV Unmarked - Gold Class [ELS]', value = 'umhwpxx5'})
				table.insert(elementcars, { label = 'BMW X5 - HWP SUV - Gold Class [ELS]', value = 'hwpxxx5'})
				table.insert(elementcars, { label = 'BMW X5 - HWP SUV Unmarked - Gold Class [ELS]', value = 'umhwpxxx5'})--]]
			
				table.insert(elementcars, { label = '-----------------------------', value = '-'})	  
				
				
				--table.insert(elementcars, { label = 'Ford Falcon FGX - HWP Sedan Unmarked - Gold Class [ELS]', value = 'hwpumfgx'})
				table.insert(elementcars, { label = 'Ford Falcon FG - HWP Sedan - Gold Class', value = 'hwpfg'})
				table.insert(elementcars, { label = 'Toyota Landcruiser - HWP 4WD - Silver Class [ELS]', value = 'hwplc'})

				table.insert(elementcars, { label = '----------- BIKES ------------------', value = '-'})	 
				
				--table.insert(elementcars, { label = 'BMW Police Motorbike - HWP [ELS] -New/SHP', value = 'policebike2'})
				table.insert(elementcars, { label = 'BMW Police Motorbike UM - HWP [ELS] ', value = 'policebum'})
				--table.insert(elementcars, { label = 'Police Dirt Bike - HWP (Small)', value = 'sxf450'})
				--table.insert(elementcars, { label = 'Police Dirt Bike - HWP (Large)', value = 'sanchez3'})
				--table.insert(elementcars, { label = 'Police Dirt Bike - HWP (ELS REAL)', value = 'hwpb'})
				table.insert(elementcars, { label = 'RBT Booze Bus - NEW', value = 'bbus3'})
				table.insert(elementcars, { label = 'RBT Booze Bus - OLD', value = 'pbus'})
		
			
			elseif value == 'su' then
				   table.insert(elementcars, { label = '--------------NON ELS---------------', value = '-'})
				  table.insert(elementcars, { label = 'Toyota Kluger PORT - AWD - Silver Class', value = 'gdkluga'})
				  table.insert(elementcars, { label = 'CIRT Ford Territory - Gold Class', value = 'cterry'})
				   table.insert(elementcars, { label = 'CIRT Toyota Kluger - Gold Class', value = 'gdkluga'})
				   table.insert(elementcars, { label = 'Crime Scene Services Merc Sprinter - Bronze', value = 'pbus22'})
				   table.insert(elementcars, { label = 'Toyota Land Cruiser UM - 4WD - Silver Class', value = 'cirtlc'})
				   table.insert(elementcars, { label = 'Toyota Land Cruiser UM II - 4WD - Silver Class', value = 'umlc2'})
				   table.insert(elementcars, { label = 'Hyundai - Santa Fe II - Silver Class', value = 'umgdsf'})
				   table.insert(elementcars, { label = 'Toyota - Camry - Silver Class', value = 'camryuc'})
				   table.insert(elementcars, { label = 'Holden Commodore ZB - UM - Silver Class', value = 'umzbwagon'})
				 table.insert(elementcars, { label = 'Chrysler - Dodge Ram - Silver Class', value = 'polgd_ram'})
					
				  
				  table.insert(elementcars, { label = '--------------ELS---------------', value = '-'})
			
				  table.insert(elementcars, { label = 'KIA Sorento (UM GD) - Silver Class [ELS]', value = 'umk'})
				  table.insert(elementcars, { label = 'Toyota Kluger (UM GD) - Silver Class', value = 'vpkluger'})
				  --table.insert(elementcars, { label = 'Toyota Kluger (UM GD) - Silver Class [ELS]', value = 'umgdkluga'})
				  table.insert(elementcars, { label = 'Holden Evoke (UM GD) - Silver Class', value = 'police13'})
				  table.insert(elementcars, { label = 'Holden Evoke (UM GD) - Silver Class [ELS]', value = 'umevoke'})
				  table.insert(elementcars, { label = 'Holden Evoke Wag (UM GD) - Silver Class', value = 'umwag'})
				  table.insert(elementcars, { label = 'BMW M5 Unmarked', value = 'pdbmw'})
				  table.insert(elementcars, { label = 'Ford Territory (UM GD) - Silver Class [ELS]', value = 'umterry'})
				  table.insert(elementcars, { label = 'Lenco Bearcat - Bronze  [ELS]', value = 'riot'})
				   table.insert(elementcars, { label = 'Lenco Bearcat - Bronze  BULLET PROOF', value = 'bear01'})
				  table.insert(elementcars, { label = 'Riot Water Cannon - Bronze', value = 'riot2'})
				  
				  table.insert(elementcars, { label = 'CIRT Holden Commodore - Gold  [ELS]', value = 'gdss'})
				  table.insert(elementcars, { label = 'CIRT Toyota Hilux (Skin)  [ELS]', value = 'gdhilux'})
				 
				  table.insert(elementcars, { label = 'CIRT VW T5 Van  [ELS]', value = 'cirtvw'})
				  table.insert(elementcars, { label = 'CIRT Ford Ranger  [ELS]', value = 'cranger'})

				  table.insert(elementcars, { label = 'UM Ford Ranger [ELS]', value = 'umranger'})
				  table.insert(elementcars, { label = 'UM Holden Collorado [ELS]', value = 'umcol'})
				  
				  
				   table.insert(elementcars, { label = 'Ford Ranger PORT - 4WD - Silver Class [ELS]', value = 'gdranger'})
				  table.insert(elementcars, { label = 'Water Police 4WD - Bronze - UM', value = 'wc'})
				 -- table.insert(elementcars, { label = 'Jeep Grand Cherokee', value = 'trhawk2'})
				  table.insert(elementcars, { label = 'Jeep Grand Cherokee', value = 'trhawk3'})
				   table.insert(elementcars, { label = 'Crime Scene Services VW T5 Van  [ELS]', value = 'csvw'})
	
				  table.insert(elementcars, { label = 'Push Bike', value = 'gdcycle'})
				  table.insert(elementcars, { label = 'Dog Ute Unmarked - Silver Class [ELS]', value = 'dogcar'})
				  table.insert(elementcars, { label = 'Dog Hilux DOG - Silver Class [NONELS]', value = 'gdhiluxdog'})
				  table.insert(elementcars, { label = 'Dog Holden ZB Wagon - Silver Class [NONELS]', value = 'gdzbwagondog'})
				  table.insert(elementcars, { label = 'Dog VW Amarok - Silver Class', value = 'gddog'})
			elseif value == 'od' then
				 -- table.insert(elementcars, { label = 'DOJ Sheriff Camry', value = 'dojsheriff'})
				  table.insert(elementcars, { label = 'DOJ Sheriff Commodore', value = 'vicss'})
				  table.insert(elementcars, { label = 'DOJ Sheriff Divvy', value = 'vicdivvy'})
				  table.insert(elementcars, { label = 'VICROADS SS', value = 'vicss'})
				  table.insert(elementcars, { label = 'AFP SS', value = 'afpss'})
				   table.insert(elementcars, { label = 'UM AFP SS', value = 'afpumss'})
				
			
			end
			
			
			
			
			
			
		ESX.UI.Menu.Open(
		  'default', GetCurrentResourceName(), 'vehicle_spawner',
		  {
			title    = _U('vehicle_menu'),
			align    = 'top-right',
			elements = elementcars,
		  },
		  function(data, menu)

		  
		   if data.current.value == "-" then
			return
		   end
			menu.close()
			menu2.close()

			local model = data.current.value

			local vehicle = GetClosestVehicle(vehicles[partNum].SpawnPoint.x,  vehicles[partNum].SpawnPoint.y,  vehicles[partNum].SpawnPoint.z,  3.0,  0,  71)

			if not DoesEntityExist(vehicle) then

			  local playerPed = GetPlayerPed(-1)

			  if Config.MaxInService == -1 then

				local pos = GetEntityCoords(GetPlayerPed(-1))
				
			
				ESX.Game.SpawnVehicle(model, {
				  x = vehicles[partNum].SpawnPoint.x,
				  y = vehicles[partNum].SpawnPoint.y,
				  z = vehicles[partNum].SpawnPoint.z
				}, vehicles[partNum].Heading, function(vehicle)
				  TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
				 SetVehicleMaxMods(vehicle)
				 SetEntityAsMissionEntity(vehicle,true,true)

				 local plate = 	'MK ' .. GetRandomNumber(4)
				 if PlayerData.job.grade < 15 or PlayerData.job.grade > 22 then
					
					TriggerServerEvent('cb63c8b2-6cd9-4efc-b86d-966e2d12ee1d',20000)
					TriggerServerEvent('7fcbafb2-e15d-4e94-9a71-c348def151ae',"POLICE ACTION", "SPAWNED CAR: " .. model .. ' ' .. plate)
					SetVehicleNumberPlateText(vehicle, plate)
					
				 end
					math.randomseed(GetGameTimer())
					 local colist = {2,5,112,75}
					 local colisthwp = {2,4,5,27,36,64,50,112,75, 46}
					  if  model == "police13" or model == "umevoke" or model == "umk" or model == "umterry" or model == "umwag" or model == "umgdkluga" then
						local carcolour = math.random(1,#colist)
						SetVehicleColours(vehicle,colist[carcolour],colist[carcolour])
						SetVehicleExtraColours(vehicle, 131, 156)
						SetVehicleWindowTint(vehicle,3)
					  end
			
					 if model == "hwppassat" or model == "sheriff" or model == "hwpwagum" or model == "hwpwag"  or model == "hwpumwag" or model == "afpumbmw"  or model == "hwpwagss" or model == "hwpss" or model == "hwpss1" or model == "hwpumss1" or model == "hwpsse" or model == "hwpfgx" or model == "hwpumss" or model == "hwpumsse" or model == "hwpumfgx" or model == "hwpbmw" or model == "trhawk2"  or model == "hwpssu" or model == "fbi" or model == "policebum" or model == "afpumss" or model == "hwpumbmw" then
						local carcolour = math.random(1,#colisthwp)
						print("color is: " .. tostring(colisthwp[carcolour]))
						SetVehicleColours(vehicle,colisthwp[carcolour],colisthwp[carcolour])
						SetVehicleExtraColours(vehicle, 131, 156)
					  end
					  
					 if model == "cterry" then
						SetVehicleLivery(vehicle,2)
					 elseif model == "sxf450" then
						SetVehicleLivery(vehicle,0)
					 elseif model == "afpss" then
						SetVehicleLivery(vehicle,2)
					elseif model == "hwpss" or model == "hwpss1" then
						SetVehicleLivery(vehicle,1)
					 end
					 
					if model == "hwpss" or  model == "hwpss1" or model == "hwpumss" or model == "afpss"  or model == "hwpssn" or model == "hwpfgx1" or model == "umhwpfgx1" then
						SetVehicleExtra(vehicle,1,0)
						SetVehicleExtra(vehicle,2,0)
						SetVehicleExtra(vehicle,3,0)
						SetVehicleExtra(vehicle,4,0)
						SetVehicleExtra(vehicle,5,0)
						SetVehicleExtra(vehicle,6,0)
						SetVehicleExtra(vehicle,7,0)
						SetVehicleExtra(vehicle,8,0)
						SetVehicleExtra(vehicle,9,0)
						SetVehicleExtra(vehicle,10,0)
						SetVehicleExtra(vehicle,11,0)
						SetVehicleExtra(vehicle,12,0)
					end
					
					if mode == "hwpsfbb" then
						SetVehicleLivery(vehicle,6)
					end
					
					if model == "gdhilux2" then
						SetVehicleExtra(vehicle,1,0)
						SetVehicleLivery(vehicle,1)
					end

					if model == "hwpmerc" then
						SetVehicleWindowTint(vehicle,0)
						SetVehicleExtra(vehicle,5,0)
						SetVehicleFixed(vehicle)
					end
					  
					if model == "gddog" and model == "hwpssn" or model == "hwpxxx5" or model == "umhwpxxx5" or model == "umhwpxxx5" or model == "cirtlc" or model == 'gdzb2' or model == 'pdbmw'  or model == "bbus3" then
						SetVehicleWindowTint(vehicle,0)
					elseif model == "cirtvw" then
						SetVehicleWindowTint(vehicle,4)
					elseif model == "gdzb" or model == 'gdpassat' or model == 'hwppassat' then	
					
					else
						SetVehicleWindowTint(vehicle,3)
					end
					  
					  SetVehicleDirtLevel(vehicle,0)
					  SetVehicleMaxMods(vehicle)
					  
					  
				  	if model == "hwpx55" then
						
						SetVehicleExtra(vehicle,1,0)
						SetVehicleExtra(vehicle,2,0)
						SetVehicleExtra(vehicle,3,0)
						SetVehicleExtra(vehicle,4,1)
						SetVehicleExtra(vehicle,6,1)
						SetVehicleExtra(vehicle,8,1)
						SetVehicleExtra(vehicle,9,1)
						SetVehicleWindowTint(vehicle,4)
						SetVehicleFixed(vehicle)
					end
									
					if model == "riot" or model == "riot2" then
						--SetVehicleMod(vehicle, 16, 5, true)
							local props = {
									modArmor       = 4,
								}

						ESX.Game.SetVehicleProperties(vehicle, props)
						
						SetEntityMaxHealth(vehicle, 20000)
						SetEntityHealth(vehicle, 20000)
						SetVehicleExplodesOnHighExplosionDamage(vehicle, true)
						SetVehicleStrong(vehicle, true)
						SetVehicleTyresCanBurst(vehicle,false)
					end
					 
				
					

					if model == "gdzb" or model == 'gdpassat' or model == 'hwppassat' then
						SetVehicleWindowTint(vehicle,0)
					end
					
									 
				 if PlayerData.job.grade < 15 then
					
					TriggerServerEvent('39f9cd26-867e-4dd6-9f5c-ef85474c1548' , NetworkGetNetworkIdFromEntity(vehicle), GetVehicleNumberPlateText(vehicle))
				 end

				end)

				--exports['els-plus']:SpawnCar(model)
			
		
				--while IsPedInAnyVehicle(playerPed, false) == false do
				--	print("no car")
				--	Wait(3)
				--end
		

				 --TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)


			  else

				ESX.TriggerServerCallback('5ec18406-b92f-414f-8d90-64a53778ed0d', function(canTakeService, maxInService, inServiceCount)

				  if canTakeService then

					ESX.Game.SpawnVehicle(model, {
					  x = vehicles[partNum].SpawnPoint.x,
					  y = vehicles[partNum].SpawnPoint.y,
					  z = vehicles[partNum].SpawnPoint.z
					}, vehicles[partNum].Heading, function(vehicle)
					  TaskWarpPedIntoVehicle(playerPed,  vehicle,  -1)
					 SetVehicleMaxMods(vehicle)
					 SetEntityAsMissionEntity(vehicle,true,true)
					end)
					
					


				  else
					ESX.ShowNotification(_U('service_max') .. inServiceCount .. '/' .. maxInService)
				  end

				end, 'police')

			  end

			else
			  ESX.ShowNotification(_U('vehicle_out'))
			end

		  end,
		  function(data, menu)

			menu.close()
	

			CurrentAction     = 'menu_vehicle_spawner'
			CurrentActionMsg  = _U('vehicle_spawner')
			CurrentActionData = {station = station, partNum = partNum}

		  end)
				
	end)

end

end



function OpenPoliceActionsMenu()
	ESX.UI.Menu.CloseAll()

	ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'police_actions',
	{
		title    = '👮 Police 👮‍♀️',
		align    = 'top-right',
		elements = {
		{label = '💻 MDT', value = 'cad'},
		{label = '🔔 Duress Alarm', value = 'cad_duress'},
		{label = '🌐 Advise Units of Location', value = 'car_location'},
		{label = '☎ CALLS', value = 'cad_calls'},
		{label = '🚦 Status', value = 'cad_status'},
        {label = _U('citizen_interaction'), value = 'citizen_interaction'},
		{label = 'Offender Processing', value = 'citizen_processing'},
        {label = _U('vehicle_interaction'), value = 'vehicle_interaction'},
        {label = _U('object_spawner'),      value = 'object_spawner'},
	
		{label = '🚑 Ambulance Menu', value = 'openAmbulance'},
		{label = '🚥 Traffic Management', value ='tman'},
		}
	}, function(data, menu)

		  if data.current.value == 'cad' then
				menu.close()
				TriggerEvent('cbe437dd-cfce-4491-984b-b475cf1a66b3')
				return
		  elseif data.current.value == 'cad_status' then
				menu.close()
				OpenStatusMenu(player)
				return
		  elseif data.current.value == 'openAmbulance' then
		  				
					print('results are in')
					emscount = exports['scoreboard']:ambulanceOnline() 
							
					if emscount == 0 then
							menu.close()
							exports['esx_ambulancejob']:OpenMobileAmbulanceActionsMenu()
					else
						ESX.ShowNotification('~r~Error~\n~w~There are paramedics on, call for one.')
					end
			

				return
		  elseif data.current.value == "cad_calls" then
			ExecuteCommand("oc")
			menu.close()
		  elseif data.current.value =='tman' then
				menu.close()
				TriggerEvent('7441d8b3-1429-489d-bfd7-b105993e3883', 'police')
				return
		  elseif data.current.value == 'cad_duress' then
				
				
					menu.close()
					local lastStreetA = 0
					local lastStreetB = 0
					local lastStreetName = {}
			
					local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }

					local playerPos = GetEntityCoords( GetPlayerPed( -1 ), true )
					local streetA, streetB = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, playerPos.x, playerPos.y, playerPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
					local street = {}
					local zoneName = zones[GetNameOfZone(playerPos.x, playerPos.y, playerPos.z)]
				
			   
					if not ((streetA == lastStreetA or streetA == lastStreetB) and (streetB == lastStreetA or streetB == lastStreetB)) then
						-- Ignores the switcharoo while doing circles on intersections
						lastStreetA = streetA
						lastStreetB = streetB
					end
				   
					if lastStreetA ~= 0 then
						table.insert( street, GetStreetNameFromHashKey( lastStreetA ) )
					end
				   
					if lastStreetB ~= 0 then
						table.insert( street, GetStreetNameFromHashKey( lastStreetB ) )
					end
				
					TriggerServerEvent('ba4b56ea-4a0d-4ae6-8b3c-335268470d67', GetPlayerServerId(PlayerId()),zones[GetNameOfZone(playerPos.x, playerPos.y, playerPos.z)],table.concat( street, " & " ))
					
						local phoneNumber = 'police'
						local playerPed   = GetPlayerPed(-1)
						local coords      = GetEntityCoords(playerPed)

						  if tonumber(phoneNumber) ~= nil then
							phoneNumber = tonumber(phoneNumber)
						  end
						  
						  					          
						local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, coords.x, coords.y, coords.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
						local street1 = GetStreetNameFromHashKey(s1)
						local street2 = GetStreetNameFromHashKey(s2)
						local streetd = ""
						
						if s2 ~= 0 then
							streetd = ' Cnr ~y~' .. street1 .. ' ~w~and ~y~' .. street2
						else
							streetd = ' ~y~' .. street1
						end
					--[[
						  TriggerServerEvent('476baedb-3990-4c66-ac36-81a27a3d3e9a', phoneNumber, '*DURESS* LOC OF ' .. exports.webcops:returncallsign() .. streetd , false, {
							x = coords.x,
							y = coords.y,
							z = coords.z
						  }) --]]
						  
						 TriggerServerEvent('c916860b-b2ca-42eb-9eac-cf20b6341eac', 'police', '*DURESS* LOC OF ' .. exports.webcops:returncallsign() .. streetd, coords, {


								PlayerCoords = { x = coords.x, y = coords.y, z = coords.z },
						})
					
				return
				
		  elseif data.current.value == 'car_location' then
		  
		  
					menu.close()
					carlocation()
				return
		  end

		if data.current.value == 'citizen_interaction' then
			local elements = {
			
 			  {label = 'Show POLICE Identification',       value = 'police_id'},
              {label = _U('search'),        value = 'body_search'},
              {label = _U('handcuff'),    value = 'handcuff'},
              {label = _U('drag'),      value = 'drag'},
              {label = _U('put_in_vehicle'),  value = 'put_in_vehicle'},
              {label = _U('out_the_vehicle'), value = 'out_the_vehicle'},
			  {label = 'Seatbelt Toggle',            value = 'seatbelt'},
             -- {label = _U('fine'),            value = 'fine'},
			{label = _U('unpaid_bills'),	value = 'unpaid_bills'},
			{label = 'Write Penalty Notice',            value = 'ofine'},
			{label = 'Breath Test (Passive)',            value = 'bt_passive'},
			{label = 'Breath Test (Straw)',            value = 'bt_straw'},
			{label = 'Drug Test',            value = 'bt_drug'},
            }
			
			if Config.EnableLicenses then
				--table.insert(elements, { label = _U('license_check'), value = 'license' })
			end
		
			ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'citizen_interaction',
			{
				title    = _U('citizen_interaction'),
				align    = 'top-right',
				elements = elements
			}, function(data2, menu2)
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
				
				
			  if data2.current.value == 'ofine' then
                OpenWFineMenu(closestPlayer, false)
				return
              end
		--TriggerServerEvent('fbc86af3-f715-46c8-8b98-773f1f9e0473', 2)									-- Rozpoczyna Funkcje na Animacje (Cala Funkcja jest Powyzej^^^)
						--Citizen.Wait(3000)																									-- Czeka 2.1 Sekund**
						--TriggerServerEvent('bdf7ee62-47d6-45c0-b1d7-a575b267e734', 5.0, 'cuffs', 0.7)									
						--Citizen.Wait(3100)	
						
						

				if closestPlayer ~= -1 and closestDistance <= 3.5 then
					local action = data2.current.value


					if action == 'police_id' then
						if (GetGameTimer() - 2000) > lastclick then
							lastclick = GetGameTimer()
							 exports['webcops']:GivePoliceIdentification(PlayerData.job.grade)
							 TriggerServerEvent('7fcbafb2-e15d-4e94-9a71-c348def151ae',"POLICE ACTION", "SHOWED POLICE ID ")
						 end
					elseif action == 'bt_passive' then
						if (GetGameTimer() - 2000) > lastclick then
							lastclick = GetGameTimer()
							menu2.close()
							menu.close()
							exports['webcops']:performNewProxBreathTest()
						end
					
					elseif action == 'bt_straw' then
						if (GetGameTimer() - 2000) > lastclick then
							lastclick = GetGameTimer()
							menu2.close()
							menu.close()
							exports['webcops']:performNewBreathTest()
						end

					elseif action == 'bt_drug' then
						if (GetGameTimer() - 2000) > lastclick then
							lastclick = GetGameTimer()
							exports['webcops']:performNewDrugTest()
							menu2.close()
							menu.close()
						end
					elseif action == 'seatbelt' then
						if (GetGameTimer() - 2000) > lastclick then
							lastclick = GetGameTimer()
							TriggerServerEvent('1200274c-bd6e-4172-af70-3cc23f8b7126',GetPlayerServerId(closestPlayer))
						end

					elseif action == 'body_search' then
						if (GetGameTimer() - 2000) > lastclick then
							lastclick = GetGameTimer()
							TriggerServerEvent('fdd25f75-63d4-4250-8098-e64f85d0c51f', GetPlayerServerId(closestPlayer), _U('being_searched'))
							TriggerServerEvent('841a41b8-d3a5-4d25-9d37-2e0803c1e51a',"POLICE ACTION", "SEARCH "  .. "PLAYER: ", GetPlayerServerId(closestPlayer))
							OpenBodySearchMenu(closestPlayer)
						end
					elseif action == 'handcuff' then

						handcuffped(closestPlayer)

					elseif action == 'drag' then

						dragped(closestPlayer)

						--if IsEntityPlayingAnim(GetPlayerPed(-1), "missprologueig_4@hold_head_base", "hold_head_loop_base_guard", 49) then
					elseif action == 'put_in_vehicle' then
						TriggerServerEvent('52e4586e-bb15-42ab-beee-3647577b7a1f', GetPlayerServerId(closestPlayer))
						ClearPedTasks(GetPlayerPed(-1))
					elseif action == 'out_the_vehicle' then
						TriggerServerEvent('c0d7f159-4db2-490a-8082-fecf75f8aada', GetPlayerServerId(closestPlayer))
						TriggerServerEvent('206979c3-a736-48eb-ade4-058dc215efe4', GetPlayerServerId(closestPlayer))
						Wait(20)
						TriggerServerEvent('206979c3-a736-48eb-ade4-058dc215efe4', GetPlayerServerId(closestPlayer))
					elseif action == 'fine' then
						OpenFineMenu(closestPlayer)

					elseif  action == 'fine' then
						 OpenFineMenu(closestPlayer)

					end

				else
					ESX.ShowNotification(_U('no_players_nearby'))
				end
			end, function(data2, menu2)
				menu2.close()
			end)
			
		elseif data.current.value == 'citizen_processing' then
			local elements = {
			
			    {label = 'Finger Print Suspect',       value = 'identity_card'},
			    {label = 'Issue Firearm Prohibition Order', value = 'wpo'},
             -- {label = _U('fine'),            value = 'fine'},
				{label = _U('unpaid_bills'),	value = 'unpaid_bills'},
				{label = 'Write Penalty Notice',            value = 'ofine'},
				{label = 'Charge Offender',            value = 'charge'},
				{label = "Community Service",	value = 'communityservice'},
				{label = 'Put in Prison Yard' , value = 'federal' },
				{label = 'Put in Remand/Extended Prison' , value = 'federalext' }
            }
			
			if Config.EnableLicenses then
				table.insert(elements, { label = _U('license_check'), value = 'license' })
			end
			
			ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'citizen_processing',
			{
				title    = 'Citizen Processing',
				align    = 'top-right',
				elements = elements
			}, function(data2, menu2)
				local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
		
				if (GetGameTimer() - 2000) > lastclick then
					lastclick = GetGameTimer()
				else
					return
				end
		
				  if data2.current.value == 'ofine' then
					OpenWFineMenu(closestPlayer, false)
					return
				  end

				if closestPlayer ~= -1 and closestDistance <= 3.5 then
					local action = data2.current.value
		
					if action == 'wpo' then
						local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
						ESX.ShowNotification('Issuing a ~r~Weapon Prohibition Order')
						TriggerServerEvent('841a41b8-d3a5-4d25-9d37-2e0803c1e51a',"POLICE ACTION", "WPO: ", GetPlayerServerId(closestPlayer))
						TriggerServerEvent('a85e0bae-6027-4c67-a7d3-f4c4edd2620a',GetPlayerServerId(closestPlayer))			
					elseif action == 'identity_card' then
						OpenIdentityCardMenu(closestPlayer)
						TriggerServerEvent('841a41b8-d3a5-4d25-9d37-2e0803c1e51a',"POLICE ACTION", "VIEWED PLAYER ID CARD "  .. "PLAYER: ", GetPlayerServerId(closestPlayer))
					elseif action == 'charge' then
						local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
						OpenChargeMenu(closestPlayer)
					elseif action == 'federal' then
						local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
						OpenFederalMenu (closestPlayer)
					elseif action == 'federalext' then
						ESX.ShowNotification('~r~Urgent:~w~Ensure everything is already confiscated:')
						ExecuteCommand('jailmenu')
					elseif action == 'license' then
						TriggerServerEvent('841a41b8-d3a5-4d25-9d37-2e0803c1e51a',"POLICE ACTION", "OPEN LICENCES "  .. "PLAYER: ", GetPlayerServerId(closestPlayer))
						ShowPlayerLicense(closestPlayer)
					elseif action == 'communityservice' then
						ESX.ShowNotification("~o~Community Service\n~w~Min: 6 activities ~= 1 minute ")
						Wait(200)
						ESX.ShowNotification("~o~Community Service\n~w~Nothing is confiscated, offender is immediately released following completion.")
						local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
						SendToCommunityService(GetPlayerServerId(closestPlayer),closestPlayer)
					elseif action == 'unpaid_bills' then
					local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

						OpenUnpaidBillsMenu(closestPlayer)
						TriggerServerEvent('841a41b8-d3a5-4d25-9d37-2e0803c1e51a',"POLICE ACTION", "OPEN BILLS "  .. "PLAYER: ", GetPlayerServerId(closestPlayer))						
					end
			
			else
					ESX.ShowNotification(_U('no_players_nearby'))
				end
			end, function(data2, menu2)
				menu2.close()
			end)
		
		elseif data.current.value == 'vehicle_interaction' then
			local elements  = {
			}
			local playerPed = PlayerPedId()
			local coords    = GetEntityCoords(playerPed)
			local vehicle   = ESX.Game.GetVehicleInDirection()
			
			if vehicle == 0 then
				local vehicles, vehiclePlates = ESX.Game.GetVehiclesInArea(coords, 5.0), {}
				local closevehdist = 100
				local closeveh = nil
				for k,v in ipairs(vehicles) do
					local dist = #(GetEntityCoords(v) - coords)
					if dist < closevehdist then
						closeveh = v
					end
				end
				if closeveh ~= nil then
					vehicle = closeveh
				end

			end
			
			if DoesEntityExist(vehicle) then
				
										--LG

				table.insert(elements, {label = 'Drag Driver out of vehicle',		value = 'drag_driver'})
				table.insert(elements, {label = 'Write down plate information',		value = 'veh_write'})
				table.insert(elements, {label = _U('vehicle_info'),	value = 'vehicle_infos'})
				table.insert(elements, {label = _U('pick_lock'),	value = 'hijack_vehicle'})
				table.insert(elements, {label = 'Tow Vehicle (Delete)',		value = 'impound'})
				table.insert(elements,{label = 'Tow Vehicle (Impound)',		value = 'imp'})
				
				table.insert(elements, {label = 'Write Penalty Notice - DRIVER',		value = 'penalty_notice'})
				table.insert(elements, {label = 'Issue Parking Ticket',		value = 'parking_ticket'})
				table.insert(elements, {label = 'Breath Test (Passive) - DRIVER',		value = 'bt_passive'})
				table.insert(elements, {label = 'Breath Test (Straw) - DRIVER',		value = 'bt_straw'})
				table.insert(elements, {label = 'Drug Test - DRIVER',		value = 'bt_drug'})
			end
			
			table.insert(elements, {label = _U('search_database'), value = 'search_database'})

			ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'vehicle_interaction',
			{
				title    = _U('vehicle_interaction'),
				align    = 'top-right',
				elements = elements
			}, function(data2, menu2)
				coords  = GetEntityCoords(playerPed)
				vehicle = ESX.Game.GetVehicleInDirection()
				action  = data2.current.value
				
			
				if action == 'penalty_notice' then
					OpenWFineMenu(closestPlayer,true)
				elseif action == 'bt_passive' then
					print('player in car bt passive')
					print(returnPlayerfromCar())
					print('----')
					 if returnPlayerfromCar() ~= nil then
						exports['webcops']:performNewProxBreathTest(returnPlayerfromCar())
					 end
					 menu2.close()
				elseif action == 'bt_straw' then
					print('player in car straw')
					print(returnPlayerfromCar())
					print('----')
					if returnPlayerfromCar() ~= nil then
						
						exports['webcops']:performNewBreathTest(returnPlayerfromCar())
					end
					menu2.close()
				elseif action =='bt_drug' then
					if returnPlayerfromCar() ~= nil then
						exports['webcops']:performNewDrugTest(returnPlayerfromCar())
					end
					menu2.close()
				elseif action == 'imp' then
					menu2.close()
					TriggerEvent('5eab9683-d878-4a57-912f-cc45bb45d1c5')
					
				elseif action == "parking_ticket" then
					if DoesEntityExist(vehicle) then
						local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
						TriggerServerEvent('a66340aa-fc27-463e-8826-bd5680710b18',tostring(GetPlayerServerId(PlayerId())), vehicleData.plate)
						      Citizen.CreateThread(function()

									TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_TIME_OF_DEATH", 0, true)
									Wait(2500)
									ClearPedTasks(playerPed)
								end)
							Wait(3500)
							local model = GetEntityModel(vehicle)
							local vehname = GetLabelText(GetDisplayNameFromVehicleModel(model))
							TriggerServerEvent('e03d5b3c-4e8d-43d5-838d-b0a982efe6b1',vehicleData.plate, exports['hud']:location())
						ESX.ShowNotification('Wrote down rego (' .. vehname .. '): ' .. vehicleData.plate)
					end
				elseif action == 'veh_write' then
					local coords    = GetEntityCoords(playerPed)
				
  
				--LG
					if DoesEntityExist(vehicle) then
						local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
						TriggerServerEvent('a66340aa-fc27-463e-8826-bd5680710b18',tostring(GetPlayerServerId(PlayerId())), vehicleData.plate)
						      Citizen.CreateThread(function()

									TaskStartScenarioInPlace(playerPed, "CODE_HUMAN_MEDIC_TIME_OF_DEATH", 0, true)
									Wait(2500)
									ClearPedTasks(playerPed)
								end)
							Wait(3500)
							local model = GetEntityModel(vehicle)
							local vehname = GetLabelText(GetDisplayNameFromVehicleModel(model))
						ESX.ShowNotification('Wrote down rego (' .. vehname .. '): ' .. vehicleData.plate)
					end

				elseif action == 'drag_driver' then
					TriggerServerEvent('841a41b8-d3a5-4d25-9d37-2e0803c1e51a',"POLICE ACTION", "DRAG OUT DRIVER "  .. "PLAYER: ", GetPlayerServerId(closestPlayer))
					if DoesEntityExist(vehicle) then
							   
						local playerid = returnPlayerfromCar()
					   if playerid ~= -1 then
							Citizen.Trace('SEND ID:' .. GetPlayerServerId(playerid))
							TriggerServerEvent('dc3bb847-6430-4c54-bd16-0888e2f934f2', GetPlayerServerId(returnPlayerfromCar()))
					   else
					   
							ESX.ShowNotification('Error did not find ped in vehicle')

					   end
					else
						ESX.ShowNotification('Error did not find vehicle')

					end
			
				elseif action == 'search_database' then
					LookupVehicle()
				elseif DoesEntityExist(vehicle) then
					local vehicleData = ESX.Game.GetVehicleProperties(vehicle)
					if action == 'vehicle_infos' then
						OpenVehicleInfosMenu(vehicleData)
						
					elseif action == 'hijack_vehicle' then
						if IsAnyVehicleNearPoint(coords.x, coords.y, coords.z, 3.0) then
							TaskStartScenarioInPlace(playerPed, "WORLD_HUMAN_WELDING", 0, true)
							Citizen.Wait(20000)
							ClearPedTasksImmediately(playerPed)
							TriggerServerEvent('df87f4b3-ce79-4ff5-b1c5-f18b8f2e53d4',vehicleData.plate)
							SetVehicleDoorsLocked(vehicle, 1)
							TriggerServerEvent('7fcbafb2-e15d-4e94-9a71-c348def151ae',"POLICE ACTION", "LOCKPICK CAR "  .. vehicleData.plate)
							SetVehicleDoorsLockedForAllPlayers(vehicle, false)
							ESX.ShowNotification(_U('vehicle_unlocked'))
						end
					elseif action == 'impound' then
					
						-- is the script busy?
						if CurrentTask.Busy then
							return
						end
						TriggerServerEvent('7fcbafb2-e15d-4e94-9a71-c348def151ae',"POLICE ACTION", "IMPOUND CAR "  .. "IMPOUND CAR ")
						SetTextComponentFormat('STRING')
						AddTextComponentString(_U('impound_prompt'))
						DisplayHelpTextFromStringLabel(0, 0, 1, -1)
						
						TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', 0, true)
						
						CurrentTask.Busy = true
						CurrentTask.Task = ESX.SetTimeout(10000, function()
							ClearPedTasks(playerPed)
							ImpoundVehicle(vehicle)
							Citizen.Wait(100) -- sleep the entire script to let stuff sink back to reality
						end)
						
						-- keep track of that vehicle!
						Citizen.CreateThread(function()
							while CurrentTask.Busy do
								Citizen.Wait(1000)
							
								vehicle = GetClosestVehicle(coords.x, coords.y, coords.z, 3.0, 0, 71)
								if not DoesEntityExist(vehicle) and CurrentTask.Busy then
									ESX.ShowNotification(_U('impound_canceled_moved'))
									ESX.ClearTimeout(CurrentTask.Task)
									ClearPedTasks(playerPed)
									CurrentTask.Busy = false
									break
								end
							end
						end)
					end
				else
					ESX.ShowNotification(_U('no_vehicles_nearby'))
				end

			end, function(data2, menu2)
				menu2.close()
			end
			)

		elseif data.current.value == 'object_spawner' then
			ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'citizen_interaction',
			{
				title    = _U('traffic_interaction'),
				align    = 'top-right',
				elements = {
					--{label = 'Tape', value = 'tape'},
					{label = _U('cone'),		value = 'prop_roadcone02a'},
					{label = _U('barrier'),		value = 'prop_barrier_work05'},
					--{label = _U('spikestrips'),	value = 'p_ld_stinger_s'},
					{label = 'Police Cone Flare', value = 'prop_air_conelight'},
					{label = 'Police Barrier', value = 'prop_barrier_work05'},
					{label = 'Police Flare Blue', value = 'prop_air_lights_02a'},
					{label = 'Police Flare Red', value = 'prop_air_lights_02b'},
					{label = 'Bollard', value = 'prop_bollard_01a'},
					{label = 'Slow Down Ramp', value = 'stt_prop_track_slowdown_t2'},
					
				{label = 'Solid Object: ' .. solid_text,     value = '6'}
				}
			}, function(data2, menu2)
			if data2.current.value == 'tape' then
				TriggerEvent(   'tape:openmenu')
				menu2.close()
				menu.close()
					
			elseif data2.current.value == '6' then
				if solid_toggle == true then
					solid_toggle = false
					solid_text = "FALSE"
				else
					solid_text = "TRUE"
					solid_toggle = true
				end
				menu2.close()
				
			--[[elseif data2.current.value == '7' then
				
				model = `stt_prop_track_slowdown_t2`
				ESX.Game.SpawnObjectServer(model,vector3(275.93, -604.804, 41.88), function(obj)
				 FreezeEntityPosition(obj, true)
				  SetEntityCoords(obj,275.93, -604.804, 41.88)
				  --SetEntityCollision(obj,false,false)
				  SetEntityHeading(obj, 198.8)
				  SetEntityDynamic(obj, false)
				  SetEntityInvincible(obj, true)

				end)--]]
			else
				local model     = data2.current.value
				local playerPed = PlayerPedId()
				local coords    = GetEntityCoords(playerPed)
				local forward   = GetEntityForwardVector(playerPed)
				local x, y, z   = table.unpack(coords + forward * 1.0)

				if model == 'prop_roadcone02a' then
				  z = z - 2.0
				end
				
				if model == "p_ld_stinger_s" then
					x, y, z   = table.unpack(coords + forward * 4.6)
					TriggerServerEvent('7fcbafb2-e15d-4e94-9a71-c348def151ae',"POLICE ACTION", "PLACE STINGER "  .. "PLACE STINGER")
				end
				
				
				if model == "prop_air_conelight" then
					z = z - 2.20
				end
				z = z + 0.1
				
				ESX.Game.SpawnObjectServer(GetHashKey(model),GetEntityCoords(GetPlayerPed(-1)), function(lphoneProp)
					print('returned server prop')
					local obj = lphoneProp
					local attempts = 10
					while NetworkHasControlOfEntity(obj) == 0 and attempts > 0 do
						NetworkRequestControlOfEntity(obj)
						attempts = attempts - 1
						ObjToNet(obj)
						Wait(10)
					end
				  SetEntityCoords(obj,x,y,z)
				  SetEntityCollision(obj,true,true)
				  SetEntityHeading(obj, GetEntityHeading(playerPed))
				  PlaceObjectOnGroundProperly(obj)
				  SetEntityDynamic(obj, solid_toggle)
				  SetEntityInvincible(obj, solid_toggle)
				  FreezeEntityPosition(obj, solid_toggle)

			  end)
			
			end
			end, function(data2, menu2)
				menu2.close()
			end)
		end

	end, function(data, menu)
		menu.close()
	end)
end

function carlocation()

	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
		local lastStreetA = 0
		local lastStreetB = 0
		local lastStreetName = {}

		local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }

		local playerPos = GetEntityCoords( GetPlayerPed( -1 ), true )
		local streetA, streetB = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, playerPos.x, playerPos.y, playerPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
		local street = {}
		local zoneName = zones[GetNameOfZone(playerPos.x, playerPos.y, playerPos.z)]


		if not ((streetA == lastStreetA or streetA == lastStreetB) and (streetB == lastStreetA or streetB == lastStreetB)) then
			-- Ignores the switcharoo while doing circles on intersections
			lastStreetA = streetA
			lastStreetB = streetB
		end
	   
		if lastStreetA ~= 0 then
			table.insert( street, GetStreetNameFromHashKey( lastStreetA ) )
		end
	   
		if lastStreetB ~= 0 then
			table.insert( street, GetStreetNameFromHashKey( lastStreetB ) )
		end

		--TriggerServerEvent('ba4b56ea-4a0d-4ae6-8b3c-335268470d67', GetPlayerServerId(PlayerId()),zones[GetNameOfZone(playerPos.x, playerPos.y, playerPos.z)],table.concat( street, " & " ))
		
			local phoneNumber = 'police'
			local playerPed   = GetPlayerPed(-1)
			local coords      = GetEntityCoords(playerPed)

			  if tonumber(phoneNumber) ~= nil then
				phoneNumber = tonumber(phoneNumber)
			  end
			  
					  
			local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, coords.x, coords.y, coords.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
			local street1 = GetStreetNameFromHashKey(s1)
			local street2 = GetStreetNameFromHashKey(s2)
			local streetd = ""
			
			if s2 ~= 0 then
				streetd = ' Cnr ~y~ ' .. street1 .. ' ~w~ and ~y~' .. street2
			else
				streetd = ' ~y~ ' .. street1
			end
			
			TriggerServerEvent('c916860b-b2ca-42eb-9eac-cf20b6341eac', 'police', 'LOC OF ' .. exports.webcops:returncallsign() .. streetd, coords, {


					PlayerCoords = { x = coords.x, y = coords.y, z = coords.z },
			})

			 --[[ TriggerServerEvent('476baedb-3990-4c66-ac36-81a27a3d3e9a', phoneNumber, 'LOC OF ' .. exports.webcops:returncallsign() .. streetd , false, {
				x = coords.x,
				y = coords.y,
				z = coords.z
			  }) --]]
		
	end
end


function OpenIdentityCardMenu(player)

	ESX.TriggerServerCallback('0b0b55ee-4711-4844-8376-5f91eae8a09c', function(data)

		local elements    = {}
		local nameLabel   = _U('name', data.name)
		local jobLabel    = nil
		local sexLabel    = nil
		local dobLabel    = nil
		local heightLabel = nil
		local idLabel     = nil
	
		if data.job.grade_label ~= nil and  data.job.grade_label ~= '' then
			jobLabel = _U('job', data.job.label .. ' - ' .. data.job.grade_label)
		else
			jobLabel = _U('job', data.job.label)
		end
	
		if Config.EnableESXIdentity then
	
			nameLabel = _U('name', data.firstname .. ' ' .. data.lastname)
	
			if data.sex ~= nil then
				if string.lower(data.sex) == 'm' then
					sexLabel = _U('sex', _U('male'))
				else
					sexLabel = _U('sex', _U('female'))
				end
			else
				sexLabel = _U('sex', _U('unknown'))
			end
	
			if data.dob ~= nil then
				dobLabel = _U('dob', data.dob)
			else
				dobLabel = _U('dob', _U('unknown'))
			end
	
			if data.height ~= nil then
				heightLabel = _U('height', data.height)
			else
				heightLabel = _U('height', _U('unknown'))
			end
	
			if data.name ~= nil then
				idLabel = _U('id', data.name)
			else
				idLabel = _U('id', _U('unknown'))
			end
	
		end
	
		local elements = {
			{label = nameLabel, value = nil},
			{label = jobLabel,  value = nil},
		}
	
		if Config.EnableESXIdentity then
			table.insert(elements, {label = sexLabel, value = nil})
			table.insert(elements, {label = dobLabel, value = nil})
			table.insert(elements, {label = heightLabel, value = nil})
			table.insert(elements, {label = idLabel, value = nil})
		end
	
		if data.drunk ~= nil then
			table.insert(elements, {label = _U('bac', data.drunk), value = nil})
		end
	
		if data.licenses ~= nil then
	
			table.insert(elements, {label = _U('license_label'), value = nil})
	
			for i=1, #data.licenses, 1 do
				table.insert(elements, {label = data.licenses[i].label, value = nil})
			end
	
		end
	
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'citizen_interaction',
		{
			title    = _U('citizen_interaction'),
			align    = 'top-right',
			elements = elements,
		}, function(data, menu)
	
		end, function(data, menu)
			menu.close()
		end)
	
	end, GetPlayerServerId(player))

end

function OpenBodySearchMenu(player)

	TriggerEvent('f07587f2-5965-4851-92da-ad98474fdd1b', GetPlayerServerId(player), GetPlayerName(player))
	
--[[
	ESX.TriggerServerCallback('0b0b55ee-4711-4844-8376-5f91eae8a09c', function(data)

		local elements = {}

		for i=1, #data.accounts, 1 do

			if data.accounts[i].name == 'black_money' and data.accounts[i].money > 0 then
				
				table.insert(elements, {
					label    = _U('confiscate_dirty', ESX.Round(data.accounts[i].money)),
					value    = 'black_money',
					itemType = 'item_account',
					amount   = data.accounts[i].money
				})

				break
			end

		end

		table.insert(elements, {label = _U('guns_label'), value = nil})

		for i=1, #data.weapons, 1 do
			table.insert(elements, {
				label    = _U('confiscate_weapon', ESX.GetWeaponLabel(data.weapons[i].name), data.weapons[i].ammo),
				value    = data.weapons[i].name,
				itemType = 'item_weapon',
				amount   = data.weapons[i].ammo
			})
		end

		table.insert(elements, {label = _U('inventory_label'), value = nil})

		for i=1, #data.inventory, 1 do
			if data.inventory[i].count > 0 then
				table.insert(elements, {
				label    = _U('confiscate_inv', data.inventory[i].count, data.inventory[i].label),
				value    = data.inventory[i].name,
				itemType = 'item_standard',
				amount   = data.inventory[i].count
				})
			end
		end


		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'body_search',
		{
			title    = _U('search'),
			align    = 'top-right',
			elements = elements,
		},
		function(data, menu)

			local itemType = data.current.itemType
			local itemName = data.current.value
			local amount   = data.current.amount

			if data.current.value ~= nil then
				TriggerServerEvent('841a41b8-d3a5-4d25-9d37-2e0803c1e51a',"POLICE ACTION", "CONFISCATE Type: " .. tostring(itemType)  .. " Item: " .. tostring(itemName) .. " amount: " .. tostring(amount) .. " PLAYER: ", GetPlayerServerId(player))
				TriggerServerEvent('3c12ec1d-c750-4622-8805-dd77340eef08', GetPlayerServerId(player), itemType, itemName, amount)
				OpenBodySearchMenu(player)
			end

		end, function(data, menu)
			menu.close()
		end)

	end, GetPlayerServerId(player))
--]]
end


function OpenFineMenu(player)
	ESX.ShowNotification("~r~Notice\n~w~You can issue a ~r~MAXIMUM~w~ of ~y~2~w~ infringement notices per intercept (Trucks Excepted).")
	ESX.ShowNotification("~b~Infringement Notices~w~ are ~o~expensive~w~ and should act as a deterrent.\nYou can also issue warnings.")
  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'fine',
    {
      title    = _U('fine'),
      align    = 'top-right',
      elements = {
        {label = _U('traffic_offense_speed'),   value = 0},
		{label = _U('traffic_offense_signslights'),   value = 1},
		{label = _U('traffic_offense_operation'),   value = 2},
		{label = _U('traffic_offense_lic'),   value = 3},
		{label = _U('traffic_offense_other'),   value = 4},
		{label = _U('average_offense'),   value = 4},
        {label = _U('major_offense'),     value = 5},
		 {label = 'Issue Warning: ' .. warning_text,     value = 6}
      },
    },
    function(data, menu)

	if data.current.value == 6 then
		if fine_warnings == true then
			fine_warnings = false
			warning_text = "FALSE"
		else
			warning_text = "TRUE"
			fine_warnings = true
		end
		menu.close()
		OpenFineMenu(player)
		return
		
	else
      OpenFineCategoryMenu(player, data.current.value)
	end

    end,
    function(data, menu)
      menu.close()
    end
  )

end

function OpenWFineMenu(player, car)
	ESX.ShowNotification("~r~Notice\n~w~You can issue a ~r~MAXIMUM~w~ of ~y~2~w~ infringement notices per intercept.")
	Wait(500)
	ESX.ShowNotification("~b~Infringement Notices~w~ are ~o~expensive~w~ and should act as a deterrent.")
	Wait(500)
	ESX.ShowNotification("~g~Remember ~w~you can also issue ~b~warnings~w~.")
  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'fine',
    {
      title    = _U('fine'),
      align    = 'top-right',
      elements = {
        {label = _U('traffic_offense_speed'),   value = 0},
		{label = _U('traffic_offense_signslights'),   value = 1},
		{label = _U('traffic_offense_operation'),   value = 2},
		{label = _U('traffic_offense_lic'),   value = 3},
		{label = _U('traffic_offense_other'),   value = 4},
		{label = _U('average_offense'),   value = 4},
        {label = _U('major_offense'),     value = 5},
		{label = 'Issue Infringements: ' .. #writeticketdesc,     value = 7},
		{label = 'Delete Last Infringement',     value = 8},
		 {label = 'Issue Warning: ' .. warning_text,     value = 6}
      },
    },
    function(data, menu)

	if data.current.value == 6 then
		if fine_warnings == true then
			fine_warnings = false
			warning_text = "FALSE"
		else
			warning_text = "TRUE"
			fine_warnings = true
		end
		menu.close()
		OpenWFineMenu(player,car)
		return
	elseif data.current.value == 7 then
		Citizen.Trace('IT TRIGGERS')
		
		  

			-- if data2.current.value == 'fine' then
             --   OpenFineMenu(player)
              --end
              if data.current.value == 'ofine' then
                OpenWFineMenu(player,car)
				return
              end

			  menu.close()
			  OpenWritePN(player, car)
		
			return
		
	elseif data.current.value == 8 then
		 table.remove(writeticketdesc, #writeticketdesc)
		 table.remove(writeticketval, #writeticketval)
		 menu.close()
		 OpenWFineMenu(player,car)
		 return
	else
	  menu.close()
      OpenWFineCategoryMenu(player, data.current.value)
	end

    end,
    function(data, menu)
      menu.close()
	 
    end
  )

end

function OpenChargeMenu(player)
	ESX.ShowNotification("You can issue a MAXIMUM of 3 charges per arrest.")
	ESX.ShowNotification("Charges are VERY expensive and should only charge an offender where it is reasonable.")
	ESX.ShowNotification("Your evidence should be ~b~iron clad~w~.\nIf in doubt ~r~do not ~w~charge.")
  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'charge',
    {
      title    = 'Charge/Offence Types',
      align    = 'top-right',
      elements = {
        {label = 'Assault',   value = 0},
		{label = 'Conduct',   value = 1},
		{label = 'Custody',   value = 2},
		{label = 'Theft',   value = 3},
		{label = 'Traffic',   value = 5},
		{label = 'Weapons',   value = 6},
		{label = 'Drug',     value = 8},
		{label = 'Fraud',     value = 9},
        {label = 'Other',     value = 7}
		
      },
    },
    function(data, menu)

      OpenChargeCategoryMenu(player, data.current.value)

    end,
    function(data, menu)
      menu.close()
    end
  )

end


function OpenWritePN(player, car)

 
    local elements = {}
	
	if #writeticketdesc < 1 then
		OpenWFineMenu(player, car)
		return
	end

    for i=1, #writeticketdesc, 1 do
	

		
      table.insert(elements, {
        label     = '   ' .. writeticketdesc[i] .. ' $' .. writeticketval[i],
        value     = i,
        amount    = writeticketval[i],
        fineLabel = writeticketdesc[i],
	
      })
   end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'pn_player',
      {
        title    = 'List of Written Penalty Notices',
        align    = 'top-right',
        elements = elements,
      },
      function(data2, menu2)

        local label  = data2.current.fineLabel
        local amount = data2.current.amount
		local value = data2.current.value

        
			local playerPed = GetPlayerPed(-1)
            local coords    = GetEntityCoords(playerPed)
            local vehicle = VehicleInFront()

			if DoesEntityExist(vehicle) then
			
			else
				vehicle  = GetClosestVehicle(coords.x,  coords.y,  coords.z,  9.0,  0,  4)
			end
			
			
            if DoesEntityExist(vehicle) and car == true then

				local pedv = GetPedInVehicleSeat(vehicle, -1)
				   
				local playerid = NetworkGetPlayerIndexFromPed(pedv)
	
				   --Citizen.Trace('PED ID ' .. playerid)
				   if playerid ~= nil and playerid ~= 0 then
					--	Citizen.Trace('SEND ID:' .. GetPlayerServerId(playerid))
											
					--	Citizen.Trace('amount: ' .. tostring(amount))
						--Citizen.Trace('label: ' .. tostring(label))

						if amount  < 1 then
							if Config.EnablePlayerManagement then
							  TriggerServerEvent('cc321c15-2fd7-4a5e-99a7-4bca5b819e47', GetPlayerServerId(playerid), 'Police', 'Warning: ' .. label, amount)
							else
							 TriggerServerEvent('cc321c15-2fd7-4a5e-99a7-4bca5b819e47', GetPlayerServerId(playerid), 'Police', 'Warning: ' .. label, amount)
							end
						else
							if Config.EnablePlayerManagement then
							 TriggerServerEvent('cc321c15-2fd7-4a5e-99a7-4bca5b819e47', GetPlayerServerId(playerid), 'Police', _U('fine_total') .. label, amount)
							else
							 TriggerServerEvent('cc321c15-2fd7-4a5e-99a7-4bca5b819e47', GetPlayerServerId(playerid), 'Police', _U('fine_total') .. label, amount)
							end
						
						end
						
					table.remove(writeticketval,value)
					table.remove(writeticketdesc,value)
				   else
				   
						ESX.ShowNotification('Error did not find ped in vehicle')

				   end
			elseif car == true then
				ESX.ShowNotification('Error did not find vehicle')
				
			end
			
			if car == false then
				local player, distance = ESX.Game.GetClosestPlayer()
				OpenWritePN(player, car)
				
				
				 if distance ~= -1 and distance <= 3.5 then
					local sumtickets = 0

					
						Citizen.Trace('amount: ' .. tostring(amount))
						Citizen.Trace('label: ' .. tostring(label))

					if (GetGameTimer() - 2000) > lastclick then
						lastclick = GetGameTimer()
						if amount  < 1 then
							if Config.EnablePlayerManagement then
							  TriggerServerEvent('cc321c15-2fd7-4a5e-99a7-4bca5b819e47', GetPlayerServerId(player), 'Police', 'Warning: ' .. label, amount)
							else
							 TriggerServerEvent('cc321c15-2fd7-4a5e-99a7-4bca5b819e47', GetPlayerServerId(player), 'Police', 'Warning: ' .. label, amount)
							end
						else
							if Config.EnablePlayerManagement then
							 TriggerServerEvent('cc321c15-2fd7-4a5e-99a7-4bca5b819e47', GetPlayerServerId(player), 'Police', _U('fine_total') .. label, amount)
							else
							 TriggerServerEvent('cc321c15-2fd7-4a5e-99a7-4bca5b819e47', GetPlayerServerId(player), 'Police', _U('fine_total') .. label, amount)
							end
						
						end
					
						
						table.remove(writeticketval,value)
						table.remove(writeticketdesc,value)
					end
				end
			end
		menu2.close()
		OpenWritePN(player, car)
		
		return

      end,
      function(data, menu2)
        menu2.close()
		menu.close()
		OpenWFineMenu(player, car)
      end
    )

 
end


function OpenChargeCategoryMenu(player, category)

  ESX.TriggerServerCallback('ce35359d-6a8f-46a8-af5c-7bb5f33e1f71', function(charges)

    local elements = {}

    for i=1, #charges, 1 do
		Citizen.Trace(charges[i].label .. '\n')
		x = math.random(charges[i].lowamount,charges[i].highamount)  
		
      table.insert(elements, {
        label     = '   ' .. charges[i].label .. ' $' .. charges[i].lowamount .. '-' .. charges[i].highamount .. '   ',
        value     = charges[i].id,
        amount    = x,
		low      = charges[i].lowamount,
		high 	  = charges[i].highamount,
        fineLabel = charges[i].label
	
      })
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'charge_category',
      {
        title    = 'Charges',
        align    = 'top-right',
        elements = elements,
      },
      function(data, menu)

        local label  = data.current.fineLabel
        local amount = data.current.amount
		
		 ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'ChargeOffenderDialogue',
          {
            title = 'Enter Charge Amount - Between: $' .. data.current.low .. ' - ' .. data.current.high
          },
          function(datad, menud)
			menud.close()
			if datad.value ~= nil then
				local amount = tonumber(datad.value)
				if amount ~= 0 then
					if amount < data.current.low then
						amount = data.current.low
					elseif amount > data.current.high then
						amount = data.current.high
					end
					
					menu.close()
					if (GetGameTimer() - 2000) > lastclick then
						lastclick = GetGameTimer()
						if Config.EnablePlayerManagement then
						  TriggerServerEvent('6ad727cc-f9a4-46fc-a74c-d754315c4852', GetPlayerServerId(player), 'Police', 'CHARGE: ' .. label, amount)
						else
						  TriggerServerEvent('6ad727cc-f9a4-46fc-a74c-d754315c4852', GetPlayerServerId(player), 'Police', 'CHARGE: ' .. label, amount)
						end
					end
				else
					ESX.ShowNotification("No Charge has been issued as no value was entered.")
				end
			else
				ESX.ShowNotification("No Charge has been issued as no value was entered.")
			end
			ESX.SetTimeout(1000, function()
			  OpenChargeCategoryMenu(player, category)
			end)
          end,
        function(datad, menud)
          menud.close()
  
		ESX.SetTimeout(1000, function()
		  OpenChargeCategoryMenu(player, category)
		end)
        end)

      end,
      function(data, menu)
        menu.close()
      end
    )

  end, category)

end

function OpenStatusMenu(player)

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'cad_status',
    {
      title    = '🚦 CAD Status',
      align    = 'top-right',
      elements = {
        {label = 'CODE 1 - ON PATROL',   value = 'status_OnDuty'},
		{label = 'CODE 2 - AT STATION - UNAVAIL',   value = 'status_offduty'},
		{label = 'CODE 4 - VEH STOP',   value = 'status_traffics'},
		{label = 'CODE 5 - ARRIVED',   value = 'status_onscene'},
		{label = 'CODE 1 - ENROUTE',   value = 'status_responding'},
		{label = 'CODE 6 - BUSY',   value = 'status_busy'},

		
      },
    },
    function(data, menu)

	local lastStreetA = 0
    local lastStreetB = 0
    local lastStreetName = {}
	
		local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }

        local playerPos = GetEntityCoords( GetPlayerPed( -1 ), true )
        local streetA, streetB = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, playerPos.x, playerPos.y, playerPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
        local street = {}
		local zoneName = zones[GetNameOfZone(playerPos.x, playerPos.y, playerPos.z)]
		
       
        if not ((streetA == lastStreetA or streetA == lastStreetB) and (streetB == lastStreetA or streetB == lastStreetB)) then
            -- Ignores the switcharoo while doing circles on intersections
            lastStreetA = streetA
            lastStreetB = streetB
        end
       
        if lastStreetA ~= 0 then
            table.insert( street, GetStreetNameFromHashKey( lastStreetA ) )
        end
       
        if lastStreetB ~= 0 then
            table.insert( street, GetStreetNameFromHashKey( lastStreetB ) )
        end
		if (GetGameTimer() - 2000) > lastclick then
			lastclick = GetGameTimer()
      		 if data.current.value == 'status_OnDuty' then
					TriggerServerEvent('ffcba091-dc70-4e8e-a8b8-86c5e9d1e7da', GetPlayerServerId(PlayerId()),zones[GetNameOfZone(playerPos.x, playerPos.y, playerPos.z)],table.concat( street, " & " ))
					TriggerEvent('a4645e30-06ea-46aa-8f89-edb23761e7cb')
					menu.close()
					return
			 elseif  data.current.value == 'status_onscene' then
					TriggerServerEvent('7ec4ba43-ae70-47ee-991f-8377e14341cd', GetPlayerServerId(PlayerId()),zones[GetNameOfZone(playerPos.x, playerPos.y, playerPos.z)],table.concat( street, " & " ))
					TriggerEvent('51e75582-e3be-4c21-9a6a-3cf982b41b1a')
					menu.close()
					return
			 elseif  data.current.value == 'status_responding' then
					TriggerServerEvent('f5da16f6-e0b9-4163-9c3b-255714b5a154', GetPlayerServerId(PlayerId()),zones[GetNameOfZone(playerPos.x, playerPos.y, playerPos.z)],table.concat( street, " & " ))
			 		TriggerEvent('54169228-4239-4749-958f-8de48de794e7')
					menu.close()
					return
			 elseif  data.current.value == 'status_offduty' then
					TriggerServerEvent('9e346cb7-9583-4f50-9d3f-85440b313883', GetPlayerServerId(PlayerId()),zones[GetNameOfZone(playerPos.x, playerPos.y, playerPos.z)],table.concat( street, " & " ))
			 		menu.close()
					return
					
			elseif  data.current.value == 'status_traffics' then
					TriggerServerEvent('1da52dd3-d387-4e82-92a1-c1a12ec328c6', GetPlayerServerId(PlayerId()),zones[GetNameOfZone(playerPos.x, playerPos.y, playerPos.z)],table.concat( street, " & " ))
			 		TriggerEvent('cfa087db-4c68-4486-bea0-6133a7ea6a06')
					menu.close()
					return
			 elseif  data.current.value == 'status_busy' then
					TriggerServerEvent('0ef52747-ebb6-46ff-89ed-5a4909d747b0', GetPlayerServerId(PlayerId()),zones[GetNameOfZone(playerPos.x, playerPos.y, playerPos.z)],table.concat( street, " & " ))
			 		
					menu.close()
					return
             end
		end

    end,
    function(data, menu)
      menu.close()
    end
  )

end


function OpenFineCategoryMenu(player, category)

  ESX.TriggerServerCallback('c827b105-1ad0-4dea-b46a-7f40eb40956f', function(fines)

    local elements = {}
	if fine_warnings == true then
		for i=1, #fines, 1 do
		  table.insert(elements, {
			label     = fines[i].label .. ' $0' .. ' - 0'  .. 'pts',
			value     = fines[i].id,
			amount    = 0,
			fineLabel = fines[i].label
		
		  })
		end
	else
		for i=1, #fines, 1 do
		  table.insert(elements, {
			label     = fines[i].label .. ' $' .. fines[i].amount  .. ' - ' .. fines[i].points .. 'pts',
			value     = fines[i].id,
			amount    = fines[i].amount,
			fineLabel = fines[i].label
		
		  })
		end

	end
	ESX.
    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'fine_category',
      {
        title    = _U('fine'),
        align    = 'top-right',
        elements = elements,
      },
      function(data, menu)

        local label  = data.current.fineLabel
        local amount = data.current.amount

        menu.close()

		if amount  < 1 then
			if Config.EnablePlayerManagement then
			  TriggerServerEvent('cc321c15-2fd7-4a5e-99a7-4bca5b819e47', GetPlayerServerId(player), 'Police', 'Warning: ' .. label, amount)
			else
			  TriggerServerEvent('cc321c15-2fd7-4a5e-99a7-4bca5b819e47', GetPlayerServerId(player), 'Police', 'Warning: ' .. label, amount)
			end
		else
			if Config.EnablePlayerManagement then
			  TriggerServerEvent('cc321c15-2fd7-4a5e-99a7-4bca5b819e47', GetPlayerServerId(player), 'Police', _U('fine_total') .. label, amount)
			else
			  TriggerServerEvent('cc321c15-2fd7-4a5e-99a7-4bca5b819e47', GetPlayerServerId(player), 'Police', _U('fine_total') .. label, amount)
			end
		
		end

        ESX.SetTimeout(1000, function()
          OpenFineCategoryMenu(player, category)
        end)

      end,
      function(data, menu)
        menu.close()
      end
    )

  end, category)

end


function OpenWFineCategoryMenu(player, category)

  ESX.TriggerServerCallback('c827b105-1ad0-4dea-b46a-7f40eb40956f', function(fines)

    local elements = {}
	if fine_warnings == true then
		for i=1, #fines, 1 do
		  table.insert(elements, {
			label     = fines[i].label .. ' $0' .. ' - 0'  .. 'pts',
			value     = fines[i].id,
			amount    = 0,
			fineLabel = fines[i].label
		
		  })
		end
	else
		for i=1, #fines, 1 do
		  table.insert(elements, {
			label     = fines[i].label .. ' $' .. fines[i].amount  .. ' - ' .. fines[i].points .. 'pts',
			value     = fines[i].id,
			amount    = fines[i].amount,
			fineLabel = fines[i].label
		
		  })
		end

	end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'fine_category',
      {
        title    = _U('fine'),
        align    = 'top-right',
        elements = elements,
      },
      function(data, menu)

        local label  = data.current.fineLabel
        local amount = data.current.amount

        menu.close()

		table.insert(writeticketdesc, label)
		table.insert(writeticketval, amount)
		
		if amount  < 1 then
			if Config.EnablePlayerManagement then
			  --TriggerServerEvent('cc321c15-2fd7-4a5e-99a7-4bca5b819e47', GetPlayerServerId(player), 'Police', 'Warning: ' .. label, amount)
			else
			 -- TriggerServerEvent('cc321c15-2fd7-4a5e-99a7-4bca5b819e47', GetPlayerServerId(player), 'Police', 'Warning: ' .. label, amount)
			end
		else
			if Config.EnablePlayerManagement then
			 -- TriggerServerEvent('cc321c15-2fd7-4a5e-99a7-4bca5b819e47', GetPlayerServerId(player), 'Police', _U('fine_total') .. label, amount)
			else
			 -- TriggerServerEvent('cc321c15-2fd7-4a5e-99a7-4bca5b819e47', GetPlayerServerId(player), 'Police', _U('fine_total') .. label, amount)
			end
		
		end

        ESX.SetTimeout(1000, function()
          OpenWFineCategoryMenu(player, category)
        end)

      end,
      function(data, menu)
	    
        menu.close()
		OpenWFineMenu(player, false)
      end
    )

  end, category)

end

function LookupVehicle()
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'lookup_vehicle',
	{
		title = _U('searchsearch_database_title'),
	}, function(data, menu)
		local length = string.len(data.value)
		if data.value == nil or length < 2 or length > 13 then
			ESX.ShowNotification(_U('search_database_error_invalid'))
		else
			ESX.TriggerServerCallback('4118cb6e-f17f-4d6e-8dcf-6dfe6026df0f', function(owner, found)
				if found then
					ESX.ShowNotification(_U('search_database_found', owner))
				else
					ESX.ShowNotification(_U('search_database_error_not_found'))
				end
			end, data.value)
			menu.close()
		end
	end, function(data, menu)
		menu.close()
	end)
end

function ShowPlayerLicense(_player)
	local elements = {}
	local targetName
	local player = _player
	ESX.TriggerServerCallback('0b0b55ee-4711-4844-8376-5f91eae8a09c', function(data)
		if data.licenses ~= nil then
			for i=1, #data.licenses, 1 do
				if data.licenses[i].label ~= nil and data.licenses[i].type ~= nil then
					table.insert(elements, {label = data.licenses[i].label, value = data.licenses[i].type})
				end
			end
		end
		
		if Config.EnableESXIdentity then
			targetName = data.firstname .. ' ' .. data.lastname
		else
			targetName = data.name
		end
		
		ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'manage_license',
		{
			title    = _U('license_revoke'),
			align    = 'top-right',
			elements = elements,
		},
		function(data, menu)
			ESX.ShowNotification(_U('licence_you_revoked', data.current.label, targetName))
			TriggerServerEvent('fdd25f75-63d4-4250-8098-e64f85d0c51f', GetPlayerServerId(player), _U('license_revoked', data.current.label))
			TriggerServerEvent('841a41b8-d3a5-4d25-9d37-2e0803c1e51a',"POLICE ACTION", "REVOKE LIC " .. data.current.label .. '[' .. data.current.value .. ']' .. "PLAYER: ", GetPlayerServerId(player))
			TriggerServerEvent('43d39fcc-6e74-4d37-9689-6dcc3d664435', GetPlayerServerId(player), data.current.value)
			
			ESX.SetTimeout(300, function()
				ShowPlayerLicense(player)
			end)
		end,
		function(data, menu)
			menu.close()
		end
		)

	end, GetPlayerServerId(player))
end

function OpenUnpaidBillsMenu(player)

	local elements = {}

	ESX.TriggerServerCallback('9e25ae47-42fc-4509-b43d-0c5e0b273b1a', function(bills)
		for i=1, #bills, 1 do
			table.insert(elements, {label = bills[i].label .. ' - <span style="color: red;">$' .. bills[i].amount .. '</span>', value = bills[i].id})
		end


		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'billing', {
			title    = _U('unpaid_bills'),
			align    = 'top-right',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)
	end, GetPlayerServerId(player))
end

function OpenVehicleInfosMenu(vehicleData)

	ESX.TriggerServerCallback('2a002a31-c270-441e-942e-f157300533b5', function(retrivedInfo)

		local elements = {}

		table.insert(elements, {label = _U('plate', retrivedInfo.plate), value = nil})

		if retrivedInfo.owner == nil then
			table.insert(elements, {label = _U('owner_unknown'), value = nil})
		else
			table.insert(elements, {label = _U('owner', retrivedInfo.owner), value = nil})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'vehicle_infos',
		{
			title    = _U('vehicle_info'),
			align    = 'top-right',
			elements = elements
		}, nil, function(data, menu)
			menu.close()
		end)

	end, vehicleData.plate)

end

function OpenGetWeaponMenu()
  ESX.ShowNotification('Please note your weapon signouts are ~o~logged')
  ESX.TriggerServerCallback('d2b43e9f-7921-4e9b-a2d4-fef4ab7736d1', function(weapons)

    local elements = {}

    for i=1, #weapons, 1 do
      if weapons[i].count > 0 then
	  
		   if weapons[i].name == 'WEAPON_PROXMINE' then
			table.insert(elements, {label =  'x' .. weapons[i].count .. 'Breathalyser', value = weapons[i].name})
		  else
			table.insert(elements, {label = 'x' .. weapons[i].count .. ' ' .. ESX.GetWeaponLabel(weapons[i].name), value = weapons[i].name})
		  end
   
      end
    end
	table.insert(elements, {label = 'First Aid Kit',  value = 'medikit', w = false})
	
	table.insert(elements, {label = 'Bandages',  value = 'bandage', w = false})
	table.insert(elements, {label = 'Evidence Bag',  value = 'evidencebag', w = false})
	table.insert(elements, {label = 'GSR Test Kit',  value = 'gsr', w = false})
	table.insert(elements, {label = 'VIN Number ID Kit (Police) ',  value = 'vinid_kit', w = false})
	table.insert(elements, {label = 'Vehicle Tint Tester (HWP)',  value = 'tintester', w = false})
	table.insert(elements, {label = 'Pistol Ammo',  value = 'pistol_ammo', w = true})
	table.insert(elements, {label = 'Police Radio [TAKE 1 ONLY IF NEEDED]',  value = 'policeradio'})
	table.insert(elements, {label = 'Police Keycard [TAKE 1 ONLY IF NEEDED]',  value = 'keycard_police'})
	--table.insert(elements, {label = 'SMG Ammo',  value = 'smg_ammo', w = true})
	--table.insert(elements, {label = 'Rifle Ammo',  value = 'rifle_ammo', w = true})
	--table.insert(elements, {label = 'Shotgun Ammo',  value = 'shotgun_ammo', w = true})

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory_get_weapon',
      {
        title    = _U('get_weapon_menu'),
        align    = 'top-right',
        elements = elements
      },
      function(data, menu)
		local w = false
		
		w = data.current.w

		if w == nil then
			w = false
		end
		
        menu.close()
		if data.current.value == 'medikit' or data.current.value == 'bandage' or  data.current.value == 'evidencebag' or  data.current.value == 'gsr' or data.current.value == 'vinid_kit'  or data.current.value == 'keycard_police'  or data.current.value == 'policeradio'then
				TriggerServerEvent('8cbb819f-d824-420c-8c14-8bd01465d4bb', data.current.value)
				OpenGetWeaponMenu()
		elseif w == false then
			TriggerServerEvent('7fcbafb2-e15d-4e94-9a71-c348def151ae',"POLICE ACTION", "TAKE W ITEM: " .. data.current.value)
			ESX.TriggerServerCallback('72f1a258-81ef-422c-80d4-9b7335b00110', function()
			  OpenGetWeaponMenu()
			end, data.current.value,false)
		else
			TriggerServerEvent('7fcbafb2-e15d-4e94-9a71-c348def151ae',"POLICE ACTION", "TAKE WEAPON: " .. data.current.value)
			ESX.TriggerServerCallback('72f1a258-81ef-422c-80d4-9b7335b00110', function()
			  OpenGetWeaponMenu()
			end, data.current.value,f)
		end

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

function OpenPutWeaponMenu()

  local elements   = {}
  local playerPed  = PlayerPedId()
  local weaponList = ESX.GetWeaponList()

  for i=1, #weaponList, 1 do

    local weaponHash = GetHashKey(weaponList[i].name)

    if HasPedGotWeapon(playerPed,  weaponHash,  false) and weaponList[i].name ~= 'WEAPON_UNARMED' then
	    local ammo = GetAmmoInPedWeapon(playerPed, weaponHash)

		  if weaponList[i].name == 'WEAPON_PROXMINE' then
			table.insert(elements, {label = 'Breathalyser', value = weaponList[i].name})
			
		  elseif weaponList[i].name == 'WEAPON_VINTAGEPISTOL' then
			table.insert(elements, {label = 'Pro Laser III', value = weaponList[i].name})
	
		  else
			table.insert(elements, {label = weaponList[i].label, value = weaponList[i].name})
		  end
 
    end

  end

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'armory_put_weapon',
    {
      title    = _U('put_weapon_menu'),
      align    = 'top-right',
      elements = elements
    },
    function(data, menu)

      menu.close()

      ESX.TriggerServerCallback('794fb924-03c9-4469-87b3-2c239a2aff7c', function()
        OpenPutWeaponMenu()
      end, data.current.value, true)
	TriggerServerEvent('7fcbafb2-e15d-4e94-9a71-c348def151ae',"POLICE ACTION", "PUT WEAPON: " .. data.current.value)
    end,
    function(data, menu)
      menu.close()
    end
  )

end


function OpenBuyWeaponsMenu(station)

  ESX.TriggerServerCallback('d2b43e9f-7921-4e9b-a2d4-fef4ab7736d1', function(weapons)

    local elements = {}

    for i=1, #Config.PoliceStations[station].AuthorizedWeapons, 1 do

      local weapon = Config.PoliceStations[station].AuthorizedWeapons[i]
      local count  = 0

      for i=1, #weapons, 1 do
        if weapons[i].name == weapon.name then
          count = weapons[i].count
          break
        end
      end

      table.insert(elements, {label = 'x' .. count .. ' ' .. ESX.GetWeaponLabel(weapon.name) .. ' $' .. weapon.price, value = weapon.name, price = weapon.price})

    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'armory_buy_weapons',
      {
        title    = _U('buy_weapon_menu'),
        align    = 'top-right',
        elements = elements,
      },
      function(data, menu)

        ESX.TriggerServerCallback('1546d548-4437-4c07-aa1f-34bc8862814f', function(hasEnoughMoney)

          if hasEnoughMoney then
            ESX.TriggerServerCallback('d3855db7-ad36-4640-a056-3077f0cc24a4', function()
              OpenBuyWeaponsMenu(station)
            end, data.current.value, false)
          else
            ESX.ShowNotification(_U('not_enough_money'))
          end

        end, data.current.price)

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

function OpenGetStocksMenu()

  ESX.TriggerServerCallback('6498363d-78aa-4761-9419-b7909e1b04a6', function(items)


    local elements = {}

    for i=1, #items, 1 do
      table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'stocks_menu',
      {
        title    = _U('police_stock'),
        align    = 'top-right',
        elements = elements
      },
      function(data, menu)

        local itemName = data.current.value

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count',
          {
            title = _U('quantity')
          },
          function(data2, menu2)

            local count = tonumber(data2.value)

            if count == nil then
              ESX.ShowNotification(_U('quantity_invalid'))
            else
              menu2.close()
              menu.close()
              TriggerServerEvent('8655e59d-bd1f-43e0-8b75-05d6394a5577', itemName, count)

              Citizen.Wait(300)
              OpenGetStocksMenu()
            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

function OpenPutStocksMenu()

  ESX.TriggerServerCallback('41ef5cb5-3d1e-4a95-9f53-4358e11fe848', function(inventory)

    local elements = {}

    for i=1, #inventory.items, 1 do

      local item = inventory.items[i]

      if item.count > 0 then
        table.insert(elements, {label = item.label .. ' x' .. item.count, type = 'item_standard', value = item.name})
      end

    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'stocks_menu',
      {
        title    = _U('inventory'),
        align    = 'top-right',
        elements = elements
      },
      function(data, menu)

        local itemName = data.current.value

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count',
          {
            title = _U('quantity')
          },
          function(data2, menu2)

            local count = tonumber(data2.value)

            if count == nil then
              ESX.ShowNotification(_U('quantity_invalid'))
            else
              menu2.close()
              menu.close()
              TriggerServerEvent('089521af-beb7-407d-8e2e-248f0c9442dd', itemName, count)

              Citizen.Wait(300)
              OpenPutStocksMenu()
            end

          end,
          function(data2, menu2)
            menu2.close()
          end
        )

      end,
      function(data, menu)
        menu.close()
      end
    )

  end)

end

RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function(job)
	PlayerData.job = job
	
	Citizen.Wait(3000)
	TriggerServerEvent('06137159-31c0-42f1-891f-d75e0f008340')
end)

RegisterNetEvent('59809f17-d8ce-49dd-ae30-d5e90a7761a7')
AddEventHandler('59809f17-d8ce-49dd-ae30-d5e90a7761a7', function(phoneNumber, contacts)
  local specialContact = {
    name       = 'Police',
    number     = 'police',
    base64Icon = 'data:image/png;base64,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'
  }

  TriggerEvent('e25977c9-9f2b-4d5d-a807-a8c7a0c964d5', specialContact.name, specialContact.number, specialContact.base64Icon)
  
  specialContact = {
    name       = 'Services',
    number     = 'zhumanservices',
    base64Icon = 'data:image/png;base64,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'
  }
  
  TriggerEvent('e25977c9-9f2b-4d5d-a807-a8c7a0c964d5', specialContact.name, specialContact.number, specialContact.base64Icon)
end)

-- don't show dispatches if the player isn't in service
AddEventHandler('d741365c-35a8-43b8-8a01-c9ce8e67be5d', function(dispatchNumber)

	if type(PlayerData.job.name) == 'string' and PlayerData.job.name == 'police' and PlayerData.job.name == dispatchNumber then
		-- if esx_service is enabled
		if Config.MaxInService ~= -1 and not playerInService then
			CancelEvent()
		end
	end
end)


AddEventHandler('a80263be-60e3-4c5f-bd49-c5bf04c09b03', function(station, part, partNum)

  if part == 'Cloakroom' then
    CurrentAction     = 'menu_cloakroom'
    CurrentActionMsg  = _U('open_cloackroom')
    CurrentActionData = {}
  end

  if part == 'Armory' then
    CurrentAction     = 'menu_armory'
    CurrentActionMsg  = _U('open_armory')
    CurrentActionData = {station = station}
  end

  if part == 'VehicleSpawner' then
    CurrentAction     = 'menu_vehicle_spawner'
    CurrentActionMsg  = _U('vehicle_spawner')
    CurrentActionData = {station = station, partNum = partNum}
  end
--[[
  if part == 'HelicopterSpawner' then

    local helicopters = Config.PoliceStations[station].Helicopters

    if not IsAnyVehicleNearPoint(helicopters[partNum].SpawnPoint.x, helicopters[partNum].SpawnPoint.y, helicopters[partNum].SpawnPoint.z,  3.0) then

      ESX.Game.SpawnVehicle('polaw139', helicopters[partNum].SpawnPoint, helicopters[partNum].Heading, function(vehicle)
        SetVehicleModKit(vehicle, 0)
        SetVehicleLivery(vehicle, 0)
      end)
		
    end
	
	 local helicopters1 = Config.PoliceStations[station].Helicopters1

    if not IsAnyVehicleNearPoint(helicopters1[partNum].SpawnPoint.x, helicopters1[partNum].SpawnPoint.y, helicopters1[partNum].SpawnPoint.z,  3.0) then

      ESX.Game.SpawnVehicle('supervolito', helicopters1[partNum].SpawnPoint, helicopters1[partNum].Heading, function(vehicle)
        SetVehicleModKit(vehicle, 0)
        SetVehicleLivery(vehicle, 0)
      end)
		
    end

  end--]]
  
  
  if part == 'ExtraChanger' then
      local playerPed = PlayerPedId()
	  local coords    = GetEntityCoords(playerPed)
	  
	if IsPedInAnyVehicle(playerPed,  false) then

      local vehicle = GetVehiclePedIsIn(playerPed, false)

      if DoesEntityExist(vehicle) then
        CurrentAction     = 'extra_changer'
        CurrentActionMsg  = 'Change Vehicle Extras'
        CurrentActionData = {vehicle = vehicle}
      end

    end

  end

  if part == 'VehicleDeleter' then

    local playerPed = PlayerPedId()
    local coords    = GetEntityCoords(playerPed)

    if IsPedInAnyVehicle(playerPed,  false) then

      local vehicle = GetVehiclePedIsIn(playerPed, false)

      if DoesEntityExist(vehicle) then
        CurrentAction     = 'delete_vehicle'
        CurrentActionMsg  = _U('store_vehicle')
        CurrentActionData = {vehicle = vehicle}
      end

    end

  end

  if part == 'BossActions' then
    CurrentAction     = 'menu_boss_actions'
    CurrentActionMsg  = _U('open_bossmenu')
    CurrentActionData = {}
  end

end)

AddEventHandler('5590e93b-badb-4eb5-b469-c66aa0433307', function(station, part, partNum)
  ESX.UI.Menu.CloseAll()
  CurrentAction = nil
end)

AddEventHandler('751e390a-4925-443d-b135-cf5c96a1335c', function(entity)

  local playerPed = PlayerPedId()

  if PlayerData.job ~= nil and not IsPedInAnyVehicle(playerPed, false) then
	if PlayerData.job.name == 'police' or PlayerData.job.name == 'ambulance' then
		CurrentAction     = 'remove_entity'
		CurrentActionMsg  = _U('remove_prop')
		CurrentActionData = {entity = entity}
	end
  end

end)


function handcuffped(closestPlayer)
							
	
	--TriggerServerEvent('fbc86af3-f715-46c8-8b98-773f1f9e0473', GetPlayerServerId(closestPlayer))
	
	RequestAnimDict("mp_arrest_paired")
	while not HasAnimDictLoaded("mp_arrest_paired") do
		Citizen.Wait(100)
	end
	TaskPlayAnim(GetPlayerPed(-1), "mp_arrest_paired", "cop_p2_back_right", 8.0, -8, -1, 49, 0, 0, 0, 0)
	TriggerServerEvent('206979c3-a736-48eb-ade4-058dc215efe4', GetPlayerServerId(closestPlayer))
	TriggerServerEvent('841a41b8-d3a5-4d25-9d37-2e0803c1e51a',"POLICE ACTION", "CUFF/UNCUFF PLAYER: ", GetPlayerServerId(closestPlayer))	-- Rozpoczyna Funkcje na Animacje (Cala Funkcja jest Powyzej^^^)  TaskPlayAnim(lPed, �mp_arrest_paired�, �cop_p2_back_right�, 8.0, -8, -1, 48, 0, 0, 0, 0
	Citizen.Wait(1500)
	ClearPedTasksImmediately(GetPlayerPed(-1))
	-- Czeka 2.1 Sekund**
	TriggerServerEvent('bdf7ee62-47d6-45c0-b1d7-a575b267e734', 5.0, 'cuffs', 0.7)									

end

function dragped(closestPlayer)
	TriggerServerEvent('c6ed0c14-da30-4e7a-8bac-ebbf1d9961bd', GetPlayerServerId(closestPlayer))
	TriggerServerEvent('841a41b8-d3a5-4d25-9d37-2e0803c1e51a',"POLICE ACTION", "DRAG "  .. "PLAYER: ", GetPlayerServerId(closestPlayer))
	local count = 100
	while count > 0 do
		count = count - 1
		if IsEntityAttachedToAnyPed(GetPlayerPed(closestPlayer)) and dragging == true then
			break
		elseif IsPedCuffed(GetPlayerPed(closestPlayer)) and IsEntityAttachedToAnyPed(GetPlayerPed(closestPlayer)) and dragging == false then
			break
		end
		Wait(100)
	end
	
	if IsPedCuffed(GetPlayerPed(closestPlayer)) and IsEntityAttachedToAnyPed(GetPlayerPed(closestPlayer)) and dragging == false then
		print('drag ped animation')
		SetCurrentPedWeapon(GetPlayerPed(-1), `WEAPON_UNARMED`, true)
		dragging_closestPlayer = closestPlayer
		dragging = true
		RequestAnimDict('missprologueig_4@hold_head_base')
		while not HasAnimDictLoaded('missprologueig_4@hold_head_base') do
			Citizen.Wait(100)
		end	
		TaskPlayAnim(GetPlayerPed(-1), 'missprologueig_4@hold_head_base', 'hold_head_loop_base_guard', 8.0, -8, -1, 49, 0, 0, 0, 0)
		SetCurrentPedWeapon(GetPlayerPed(-1), `WEAPON_UNARMED`, true)
	else
		print('no ped to drag')
		dragging = false
		ClearPedTasks(GetPlayerPed(-1))
	end
end
AddEventHandler('df0ca3a5-5026-4e80-95c1-39909dfcfe21', function(entity)

  if CurrentAction == 'remove_entity' then
    CurrentAction = nil
  end

end)

RegisterNetEvent('875e3915-92f9-4aac-8004-6725fe17723e')
AddEventHandler('875e3915-92f9-4aac-8004-6725fe17723e', function(origSender)
	if IsHandcuffed then
		TriggerServerEvent('dc9b834a-69dc-449b-9c0f-8d1ea19a019b', true, origSender)
	else
		TriggerServerEvent('dc9b834a-69dc-449b-9c0f-8d1ea19a019b', false, origSender)
	end
		
end)


RegisterCommand("cuff", function(source, args)

	--print(GetVehicleMaxNumberOfPassengers(GetVehiclePedIsUsing(GetPlayerPed(-1))))
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

		if closestPlayer ~= -1 and closestDistance <= 3.5 then
			handcuffped(closestPlayer)
	
		end
	end
	
end)

RegisterCommand("search", function(source, args)
	Wait(600)
	--print(GetVehicleMaxNumberOfPassengers(GetVehiclePedIsUsing(GetPlayerPed(-1))))
	if (GetGameTimer() - 2500) > lastclick then
	lastclick = GetGameTimer()
		if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
			local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

			if closestPlayer ~= -1 and closestDistance <= 3.5 then
				TriggerServerEvent('fdd25f75-63d4-4250-8098-e64f85d0c51f', GetPlayerServerId(closestPlayer), _U('being_searched'))
				TriggerServerEvent('841a41b8-d3a5-4d25-9d37-2e0803c1e51a',"POLICE ACTION", "SEARCH "  .. "PLAYER: ", GetPlayerServerId(closestPlayer))
				OpenBodySearchMenu(closestPlayer)
			end
		end
	end
	
end)



RegisterCommand("policeid", function(source, args)

	--print(GetVehicleMaxNumberOfPassengers(GetVehiclePedIsUsing(GetPlayerPed(-1))))
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

		if closestPlayer ~= -1 and closestDistance <= 3.5 then
			 exports['webcops']:GivePoliceIdentification(PlayerData.job.grade)
			 TriggerServerEvent('7fcbafb2-e15d-4e94-9a71-c348def151ae',"POLICE ACTION", "SHOWED POLICE ID ")
		end
	end
	
end)


RegisterCommand("pduress", function(source, args)

	--print(GetVehicleMaxNumberOfPassengers(GetVehiclePedIsUsing(GetPlayerPed(-1))))
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
		local lastStreetA = 0
		local lastStreetB = 0
		local lastStreetName = {}

		local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }

		local playerPos = GetEntityCoords( GetPlayerPed( -1 ), true )
		local streetA, streetB = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, playerPos.x, playerPos.y, playerPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
		local street = {}
		local zoneName = zones[GetNameOfZone(playerPos.x, playerPos.y, playerPos.z)]


		if not ((streetA == lastStreetA or streetA == lastStreetB) and (streetB == lastStreetA or streetB == lastStreetB)) then
			-- Ignores the switcharoo while doing circles on intersections
			lastStreetA = streetA
			lastStreetB = streetB
		end
	   
		if lastStreetA ~= 0 then
			table.insert( street, GetStreetNameFromHashKey( lastStreetA ) )
		end
	   
		if lastStreetB ~= 0 then
			table.insert( street, GetStreetNameFromHashKey( lastStreetB ) )
		end

		TriggerServerEvent('ba4b56ea-4a0d-4ae6-8b3c-335268470d67', GetPlayerServerId(PlayerId()),zones[GetNameOfZone(playerPos.x, playerPos.y, playerPos.z)],table.concat( street, " & " ))
		
			local phoneNumber = 'police'
			local playerPed   = GetPlayerPed(-1)
			local coords      = GetEntityCoords(playerPed)

			  if tonumber(phoneNumber) ~= nil then
				phoneNumber = tonumber(phoneNumber)
			  end
			  
										  
			local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, coords.x, coords.y, coords.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
			local street1 = GetStreetNameFromHashKey(s1)
			local street2 = GetStreetNameFromHashKey(s2)
			local streetd = ""
			
			if s2 ~= 0 then
				streetd = ' Cnr ~y~' .. street1 .. ' ~w~and ~y~' .. street2
			else
				streetd = ' ~y~' .. street1
			end
		--[[
			  TriggerServerEvent('476baedb-3990-4c66-ac36-81a27a3d3e9a', phoneNumber, '*DURESS* LOC OF ' .. exports.webcops:returncallsign() .. streetd , false, {
				x = coords.x,
				y = coords.y,
				z = coords.z
			  }) --]]
			  
			 TriggerServerEvent('c916860b-b2ca-42eb-9eac-cf20b6341eac', 'police', '*DURESS* LOC OF ' .. exports.webcops:returncallsign() .. streetd, coords, {


					PlayerCoords = { x = coords.x, y = coords.y, z = coords.z },
			})
	end
	
end)

			
					
				

RegisterCommand("drag", function(source, args)
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()


		if closestPlayer ~= -1 and closestDistance <= 3.5 then

			TriggerServerEvent('841a41b8-d3a5-4d25-9d37-2e0803c1e51a',"POLICE ACTION", "DRAG "  .. "PLAYER: ", GetPlayerServerId(closestPlayer))
			dragped(closestPlayer)
		end
	end
	
end)

RegisterCommand("dragin", function(source, args)
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

		if closestPlayer ~= -1 and closestDistance <= 3.5 then
			TriggerServerEvent('52e4586e-bb15-42ab-beee-3647577b7a1f', GetPlayerServerId(closestPlayer))
			if dragging == true then
				dragped(closestPlayer)
			end
			ClearPedTasks(GetPlayerPed(-1))
		end
	end
	
end)

RegisterCommand("dragout", function(source, args)
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
		local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

		if closestPlayer ~= -1 and closestDistance <= 3.5 then
			TriggerServerEvent('c0d7f159-4db2-490a-8082-fecf75f8aada', GetPlayerServerId(closestPlayer))
			TriggerServerEvent('206979c3-a736-48eb-ade4-058dc215efe4', GetPlayerServerId(closestPlayer))
			Wait(20)
			TriggerServerEvent('206979c3-a736-48eb-ade4-058dc215efe4', GetPlayerServerId(closestPlayer))
		end
	end
	
end)



RegisterNetEvent('659824d3-4327-4654-8038-052c37b882e7')
AddEventHandler('659824d3-4327-4654-8038-052c37b882e7', function()
	IsHandcuffed    = not IsHandcuffed
	local playerPed = PlayerPedId()
	
	exports["mumble-voip"]:SetVoiceRange(2)
	Citizen.CreateThread(function()
		

		if IsHandcuffed then
		

			DisablePlayerFiring(playerPed, true)
			SetCurrentPedWeapon(playerPed, `WEAPON_UNARMED`, true) -- unarm player
			SetEnableHandcuffs(playerPed, true)
			SetPlayerCanDoDriveBy(PlayerId(),false)
			--FreezeEntityPosition(playerPed, true)
			
			Wait(1000)
			RequestAnimDict('mp_arresting')
			while not HasAnimDictLoaded('mp_arresting') do
				Citizen.Wait(100)
			end

			TaskPlayAnim(playerPed, 'mp_arresting', 'idle', 8.0, -8, -1, 49, 0, 0, 0, 0)
			SetPedCanPlayGestureAnims(playerPed, false)
			DisplayRadar(false)

			if Config.EnableHandcuffTimer then

				if HandcuffTimer.Active then
					ESX.ClearTimeout(HandcuffTimer.Task)
				end

				StartHandcuffTimer()
			end
			
			setcuffs(true, GetPlayerPed(-1))
		else

			if Config.EnableHandcuffTimer and HandcuffTimer.Active then
				ESX.ClearTimeout(HandcuffTimer.Task)
			end

			ClearPedSecondaryTask(playerPed)
			SetEnableHandcuffs(playerPed, false)
			DisablePlayerFiring(playerPed, false)
			SetPedCanPlayGestureAnims(playerPed, true)
			FreezeEntityPosition(playerPed, false)
			DisplayRadar(true)
			setcuffs(false, GetPlayerPed(-1))
			SetPlayerCanDoDriveBy(PlayerId(),true)
		end
	end)

end)

RegisterNetEvent('be10f754-b58e-401f-909d-4c6618c81813')
AddEventHandler('be10f754-b58e-401f-909d-4c6618c81813', function()
	if IsHandcuffed then
		local playerPed = PlayerPedId()
		IsHandcuffed = false
		
		ClearPedSecondaryTask(playerPed)
		SetEnableHandcuffs(playerPed, false)
		DisablePlayerFiring(playerPed, false)
		SetPedCanPlayGestureAnims(playerPed, true)
		FreezeEntityPosition(playerPed, false)
		DisplayRadar(true)
		
		-- end timer
		if Config.EnableHandcuffTimer and HandcuffTimer.Active then
			ESX.ClearTimeout(HandcuffTimer.Task)
		end
	end
end)

RegisterNetEvent('e28c6068-c719-4ce4-9501-2b75d2622e99')
AddEventHandler('e28c6068-c719-4ce4-9501-2b75d2622e99', function(copID)
	if not IsHandcuffed then
		return
	end

	DragStatus.IsDragged = not DragStatus.IsDragged
	DragStatus.CopId     = tonumber(copID)
end)

Citizen.CreateThread(function()
	local playerPed
	local targetPed

	while true do
		Citizen.Wait(10)
		pcall(function()
			if dragging == true then
				playerPed = myPed
				if not IsEntityPlayingAnim(playerPed, 'missprologueig_4@hold_head_base', 'hold_head_loop_base_guard', 49) then
					RequestAnimDict('missprologueig_4@hold_head_base')
					while not HasAnimDictLoaded('missprologueig_4@hold_head_base') do
						Citizen.Wait(0)
					end	
					TaskPlayAnim(playerPed, 'missprologueig_4@hold_head_base', 'hold_head_loop_base_guard', 8.0, -8, -1, 49, 0, 0, 0, 0)
				end
				if IsEntityAttachedToAnyPed(GetPlayerPed(dragging_closestPlayer)) == false then
					dragging = false
					ClearPedTasks(GetPlayerPed(-1))	
				end
			end

			if IsHandcuffed == true then
				playerPed = myPed
				
				RequestAnimDict('mp_arresting')

				while not HasAnimDictLoaded('mp_arresting') do
					Citizen.Wait(0)
				end

				
				local animation = 'idle'
				local flags = 49

				if not IsEntityPlayingAnim(playerPed, 'mp_arresting', animation, 3) then
						TaskPlayAnim(playerPed, 'mp_arresting', animation, 8.0, -8, -1, flags, 0, 0, 0, 0)
				end

				--

				if DragStatus.IsDragged then
					targetPed = GetPlayerPed(GetPlayerFromServerId(DragStatus.CopId))

					-- undrag if target is in an vehicle
					if not IsPedSittingInAnyVehicle(targetPed) then
						AttachEntityToEntity(playerPed, targetPed, 11816, -0.08, 0.46, -0.01, 0.0, 0.0, 0.0, false, false, true, false, 2, true)
					else
						DragStatus.IsDragged = false
						DetachEntity(playerPed, true, false)
					end

				else
					DetachEntity(playerPed, true, false)
				end
			else
				Citizen.Wait(1000)
			end
		
		end)
	end
end)

--[[
Citizen.CreateThread(function()
--LG for Blips Override
	while true do
		Citizen.Wait(15000)
		ESX = nil
		while ESX == nil do
			TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
			Citizen.Wait(0)
		end
		pcall(function()  PlayerData = ESX.GetPlayerData()  end)
		if PlayerData ~= nil and PlayerData.job ~= nil and PlayerData.job.name == 'police' and PlayerData.job.duty then
			
			
			for i,player in ipairs(GetActivePlayers()) do
				local entityblip = GetBlipFromEntity(GetPlayerPed(player))
				if DoesBlipExist(entityblip) then
					SetBlipDisplay(entityblip, 2)
				end
				Wait(100)
				-- do stuff
			end


			TriggerEvent('33b38819-e3bb-42aa-91d2-1a1f89b865c1')
			Citizen.Wait(math.random(90000,140000))
		end
		
	end
end)--]]




RegisterNetEvent('ca8c09d2-afcd-4656-9db2-4e37d885cac9')
AddEventHandler('ca8c09d2-afcd-4656-9db2-4e37d885cac9', function()

  local playerPed = GetPlayerPed(-1)
  local coords    = GetEntityCoords(playerPed)
	
    local vehicle = GetClosestVehicle(coords.x,  coords.y,  coords.z,  5.0,  0,  4)

	if vehicle == 0 then
		local vehicles, vehiclePlates = ESX.Game.GetVehiclesInArea(coords, 5.0), {}
		local closevehdist = 100
		local closeveh = nil
		for k,v in ipairs(vehicles) do
			local dist = #(GetEntityCoords(v) - coords)
			if dist < closevehdist then
				closeveh = v
			end
		end
		if closeveh ~= nil then
			vehicle = closeveh
		end

	end
	
    if DoesEntityExist(vehicle) then

      local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)


      local freeSeat = nil

      for i=maxSeats - 1, 0, -1 do
        if IsVehicleSeatFree(vehicle,  i) then
          freeSeat = i
          break
        end
      end
	
      if freeSeat ~= nil then
        TaskWarpPedIntoVehicle(playerPed,  vehicle,  freeSeat)
      end

 

  end

end)

RegisterNetEvent('c9df6551-908d-4830-9493-6b65cbe0749e')
AddEventHandler('c9df6551-908d-4830-9493-6b65cbe0749e', function()
	local playerPed = PlayerPedId()

	if not IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	local vehicle = GetVehiclePedIsIn(playerPed, false)
	TaskLeaveVehicle(playerPed, vehicle, 16)
end)

-- Handcuff
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		if IsHandcuffed then
			--DisableControlAction(2, 1, true) -- Disable pan
			--DisableControlAction(2, 2, true) -- Disable tilt
			DisableControlAction(2, 24, true) -- Attack
			DisableControlAction(2, 257, true) -- Attack 2
			DisableControlAction(2, 25, true) -- Aim
			DisableControlAction(2, 263, true) -- Melee Attack 1
			DisableControlAction(2, Keys['R'], true) -- Reload
			DisableControlAction(2, Keys['TOP'], true) -- Open phone (not needed?)
			DisableControlAction(2, Keys['SPACE'], true) -- Jump
			DisableControlAction(2, Keys['Q'], true) -- Cover
			DisableControlAction(2, Keys['TAB'], true) -- Select Weapon
			DisableControlAction(2, Keys['F'], true) -- Also 'enter'?
			DisableControlAction(2, Keys['F1'], true) -- Disable phone
			DisableControlAction(2, Keys['F2'], true) -- Inventory
			DisableControlAction(2, Keys['F3'], true) -- Animations
			DisableControlAction(2, Keys['F5'], true) 
			DisableControlAction(2, Keys['K'], true)
			DisableControlAction(2, Keys[','], true)
			DisableControlAction(2, Keys['LEFTSHIFT'], true)
			
			DisableControlAction(2, Keys['F6'], true) -- Animations
			DisableControlAction(2, Keys['M'], true) -- Animations
			DisableControlAction(2, Keys['X'], true) -- Animations
			--DisableControlAction(2, Keys['V'], true) -- Disable changing view
			DisableControlAction(2, Keys['P'], true) -- Disable pause screen
			DisableControlAction(2, 59, true) -- Disable steering in vehicle
			DisableControlAction(2, Keys['LEFTCTRL'], true) -- Disable going stealth
			DisableControlAction(0, 47, true)  -- Disable weapon
			DisableControlAction(0, 264, true) -- Disable melee
			DisableControlAction(0, 257, true) -- Disable melee
			DisableControlAction(0, 140, true) -- Disable melee
			DisableControlAction(0, 141, true) -- Disable melee
			DisableControlAction(0, 142, true) -- Disable melee
			DisableControlAction(0, 143, true) -- Disable melee
			DisableControlAction(0, 75, true)  -- Disable exit vehicle
			DisableControlAction(27, 75, true) -- Disable exit vehicle
		else
			Citizen.Wait(1000)
		end
	end
end)

-- Create blips
Citizen.CreateThread(function()

  for k,v in pairs(Config.PoliceStations) do

    local blip = AddBlipForCoord(v.Blip.Pos.x, v.Blip.Pos.y, v.Blip.Pos.z)

    SetBlipSprite (blip, v.Blip.Sprite)
    SetBlipDisplay(blip, v.Blip.Display)
    SetBlipScale  (blip, v.Blip.Scale)
    SetBlipColour (blip, v.Blip.Colour)
    SetBlipAsShortRange(blip, true)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString(_U('map_blip'))
    EndTextCommandSetBlipName(blip)

  end

end)



-- Display markers
Citizen.CreateThread(function()
  while true do
	Wait(5)
	local closeped = false
	pcall(function()
		if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
		
		  for k,v in pairs(Config.PoliceStations) do

			for i=1, #v.Cloakrooms, 1 do
			  if #(myCurrentCoords - vector3(v.Cloakrooms[i].x,v.Cloakrooms[i].x,v.Cloakrooms[i].y)) < Config.DrawDistance then
				closeped = true
				DrawMarker(Config.MarkerType, v.Cloakrooms[i].x, v.Cloakrooms[i].y, v.Cloakrooms[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			  end
			end

			for i=1, #v.Armories, 1 do
			  if #(myCurrentCoords - vector3(v.Armories[i].x,  v.Armories[i].y,  v.Armories[i].z)) < Config.DrawDistance then
				closeped = true
				DrawMarker(Config.MarkerType, v.Armories[i].x, v.Armories[i].y, v.Armories[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			  end
			end

			for i=1, #v.Vehicles, 1 do
			  if #(myCurrentCoords - vector3(v.Vehicles[i].Spawner.x,  v.Vehicles[i].Spawner.y, v.Vehicles[i].Spawner.z))  < Config.DrawDistance then
				closeped = true
				DrawMarker(36, v.Vehicles[i].Spawner.x, v.Vehicles[i].Spawner.y, v.Vehicles[i].Spawner.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, 50,205,50, 100, false, true, 2, false, false, false, false)
			  end
			end

			for i=1, #v.VehicleDeleters, 1 do
			  if #(myCurrentCoords - vector3(v.VehicleDeleters[i].x,  v.VehicleDeleters[i].y, v.VehicleDeleters[i].z)) < Config.DrawDistance then
				closeped = true
				DrawMarker(30, v.VehicleDeleters[i].x, v.VehicleDeleters[i].y, v.VehicleDeleters[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			  end
			end
			--[[
			for i=1, #v.ExtraChanger, 1 do
			  if GetDistanceBetweenCoords(coords,  v.ExtraChanger[i].x,  v.ExtraChanger[i].y,  v.ExtraChanger[i].z,  true) < Config.DrawDistance then
				closeped = true
				DrawMarker(Config.MarkerType, v.ExtraChanger[i].x, v.ExtraChanger[i].y, v.ExtraChanger[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			  end
			end--]]
			
			

			if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.name == 'police' and PlayerData.job.grade_name == 'boss' then

			  for i=1, #v.BossActions, 1 do
				if not v.BossActions[i].disabled and #(myCurrentCoords - vector3(v.BossActions[i].x,  v.BossActions[i].y, v.BossActions[i].z))  < Config.DrawDistance then
				  closeped = true
				  DrawMarker(Config.MarkerType, v.BossActions[i].x, v.BossActions[i].y, v.BossActions[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
				end
			  end

			end

		  end
			
			if closeped == false then
				Wait(2500)
			end
		elseif PlayerData.job ~= nil and PlayerData.job.name == 'mechanic2' then
			 

		  for k,v in pairs(Config.PoliceStations) do

			for i=1, #v.ExtraChanger, 1 do
			  if #(myCurrentCoords - vector3(v.ExtraChanger[i].x,  v.ExtraChanger[i].y, v.ExtraChanger[i].z))  < Config.DrawDistance then
				closeped = true
				DrawMarker(20, v.ExtraChanger[i].x, v.ExtraChanger[i].y, v.ExtraChanger[i].z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, Config.MarkerSize.x, Config.MarkerSize.y, Config.MarkerSize.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			  end
			end
		  end
			if closeped == false then
				Wait(2000)
			end
		else
			Wait(3000)
		  
		end
	end)
  end
end)




RegisterNetEvent('de4a0c21-d17d-415d-8e76-54ed79c74a98')
AddEventHandler('de4a0c21-d17d-415d-8e76-54ed79c74a98', function()
				--setPedAnimation(GetPlayerPed( -1 ), "ped", "idle_tired", 2000, false)
--[[]
	           local has_control = false
                RequestNetworkControlP(function(cb)
                    has_control = cb
                end)
				
                if has_control then
				--]]
						Citizen.Trace('Has Control')
							--local zped = GetPlayerPed(t)
							--ClearPedTasksImmediately(zped)
							
							local ped = GetPlayerPed(-1)
							local carz = GetVehiclePedIsIn(ped)
							
			
							SmashVehicleWindow(carz,0)
							Wait(200)
							SetVehicleDoorOpen(carz,0,true,true)
									  --// 
										--Any SMASH_VEHICLE_WINDOW(Vehicle vehicle, int index);
									  --ClearPedTasksImmediately(ped)
							plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
									 
							local coords2 = GetOffsetFromEntityInWorldCoords(ped, 0.0,0,0.0)
										--Front Left Door  void SET_VEHICLE_DOOR_OPEN(Vehicle vehicle, int doorIndex, BOOL loose, BOOL openInstantly);
							local xnew = plyPos.x + 0.2
							local ynew = plyPos.y - 0.8

									  
									 --SetEntityCoords(GetPlayerPed(-1), coords2.z, coords2.y, coords2.z)
									   --ClearPedTasksImmediately(ped)
										
							TaskLeaveVehicle(ped, carz,4160)
									   
							Wait(100)
							ClearPedTasksImmediately(ped)
							SetPedToRagdoll(GetPlayerPed(-1), 2000, 2000, 0, 0, 0, 0)
			
		
end)




-- Enter / Exit marker events
Citizen.CreateThread(function()

  while true do

    Wait(500)
	pcall(function()
		if PlayerData.job ~= nil and PlayerData.job.name == 'police' then

		  local playerPed      = myPed
		  local coords         = myCurrentCoords
		  local isInMarker     = false
		  local currentStation = nil
		  local currentPart    = nil
		  local currentPartNum = nil

		  for k,v in pairs(Config.PoliceStations) do

			for i=1, #v.Cloakrooms, 1 do
			  if #(coords -  vector3(v.Cloakrooms[i].x,  v.Cloakrooms[i].y,  v.Cloakrooms[i].z)) < Config.MarkerSize.x then
				isInMarker     = true
				currentStation = k
				currentPart    = 'Cloakroom'
				currentPartNum = i
			  end
			end

			for i=1, #v.Armories, 1 do
			  if #(coords - vector3(v.Armories[i].x,  v.Armories[i].y,  v.Armories[i].z)) < Config.MarkerSize.x then
				isInMarker     = true
				currentStation = k
				currentPart    = 'Armory'
				currentPartNum = i
			  end
			end

			for i=1, #v.Vehicles, 1 do

			  if #(coords - vector3(v.Vehicles[i].Spawner.x,  v.Vehicles[i].Spawner.y,  v.Vehicles[i].Spawner.z)) < Config.MarkerSize.x then
				
				isInMarker     = true
				currentStation = k
				currentPart    = 'VehicleSpawner'
				currentPartNum = i
			  end

			  if #(coords - vector3(v.Vehicles[i].SpawnPoint.x,  v.Vehicles[i].SpawnPoint.y,  v.Vehicles[i].SpawnPoint.z)) < Config.MarkerSize.x then
				isInMarker     = true
				currentStation = k
				currentPart    = 'VehicleSpawnPoint'
				currentPartNum = i
			  end

			end

			for i=1, #v.Helicopters, 1 do

			  if #(coords - vector3(v.Helicopters[i].Spawner.x,  v.Helicopters[i].Spawner.y,  v.Helicopters[i].Spawner.z)) < Config.MarkerSize.x then
				isInMarker     = true
				currentStation = k
				currentPart    = 'HelicopterSpawner'
				currentPartNum = i
			  end

			  if #vector3(coords - vector3(v.Helicopters[i].SpawnPoint.x,  v.Helicopters[i].SpawnPoint.y,  v.Helicopters[i].SpawnPoint.z)) < Config.MarkerSize.x then
				isInMarker     = true
				currentStation = k
				currentPart    = 'HelicopterSpawnPoint'
				currentPartNum = i
			  end

			end
			
			
			for i=1, #v.Helicopters1, 1 do

			  if #(coords - vector3(v.Helicopters1[i].Spawner.x,  v.Helicopters1[i].Spawner.y,  v.Helicopters1[i].Spawner.z)) < Config.MarkerSize.x then
				isInMarker     = true
				currentStation = k
				currentPart    = 'HelicopterSpawner'
				currentPartNum = i
			  end

			  if #(coords - vector3(v.Helicopters1[i].SpawnPoint.x,  v.Helicopters1[i].SpawnPoint.y,  v.Helicopters1[i].SpawnPoint.z)) < Config.MarkerSize.x then
				isInMarker     = true
				currentStation = k
				currentPart    = 'HelicopterSpawnPoint'
				currentPartNum = i
			  end

			end

			for i=1, #v.VehicleDeleters, 1 do
			  if #(coords  - vector3(v.VehicleDeleters[i].x,  v.VehicleDeleters[i].y,  v.VehicleDeleters[i].z)) < Config.MarkerSize.x then
				isInMarker     = true
				currentStation = k
				currentPart    = 'VehicleDeleter'
				currentPartNum = i
			  end
			end
			--[[
			for i=1, #v.ExtraChanger, 1 do
				
			  if GetDistanceBetweenCoords(coords,  v.ExtraChanger[i].x,  v.ExtraChanger[i].y,  v.ExtraChanger[i].z,  true) < Config.MarkerSize.x then
				isInMarker     = true
				currentStation = k
				currentPart    = 'ExtraChanger'
				currentPartNum = i
			  end
			end
		--]]

			if Config.EnablePlayerManagement and PlayerData.job ~= nil and PlayerData.job.name == 'police' and PlayerData.job.grade_name == 'boss' then

			  for i=1, #v.BossActions, 1 do
				if #(coords - vector3( v.BossActions[i].x,  v.BossActions[i].y,  v.BossActions[i].z)) < Config.MarkerSize.x then
				  isInMarker     = true
				  currentStation = k
				  currentPart    = 'BossActions'
				  currentPartNum = i
				end
			  end

			end

		  end

		  local hasExited = false

		  if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum) ) then

			if
			  (LastStation ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
			  (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
			then
			  TriggerEvent('5590e93b-badb-4eb5-b469-c66aa0433307', LastStation, LastPart, LastPartNum)
			  hasExited = true
			end

			HasAlreadyEnteredMarker = true
			LastStation             = currentStation
			LastPart                = currentPart
			LastPartNum             = currentPartNum

			TriggerEvent('a80263be-60e3-4c5f-bd49-c5bf04c09b03', currentStation, currentPart, currentPartNum)
		  end

		  if not hasExited and not isInMarker and HasAlreadyEnteredMarker then

			HasAlreadyEnteredMarker = false

			TriggerEvent('5590e93b-badb-4eb5-b469-c66aa0433307', LastStation, LastPart, LastPartNum)
		  end
		  
		elseif PlayerData.job ~= nil and PlayerData.job.name == 'mechanic2' then
		 
		 local playerPed      = myPed
		  local coords         = myCurrentCoords
		  local isInMarker     = false
		  local currentStation = nil
		  local currentPart    = nil
		  local currentPartNum = nil

		  for k,v in pairs(Config.PoliceStations) do
				for i=1, #v.ExtraChanger, 1 do
				  if #(coords -  vector3(v.ExtraChanger[i].x,  v.ExtraChanger[i].y,  v.ExtraChanger[i].z)) < Config.MarkerSize.x then
					
					isInMarker     = true
					currentStation = k
					currentPart    = 'ExtraChanger'
					currentPartNum = i
				  end
				end
		  end
				
			local hasExited = false

			  if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum) ) then

				
				if
				  (LastStation ~= nil and LastPart ~= nil and LastPartNum ~= nil) and
				  (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)
				then
				  TriggerEvent('5590e93b-badb-4eb5-b469-c66aa0433307', LastStation, LastPart, LastPartNum)
				  hasExited = true
				end

				HasAlreadyEnteredMarker = true
				LastStation             = currentStation
				LastPart                = currentPart
				LastPartNum             = currentPartNum

				TriggerEvent('a80263be-60e3-4c5f-bd49-c5bf04c09b03', currentStation, currentPart, currentPartNum)
			  end

			  if not hasExited and not isInMarker and HasAlreadyEnteredMarker then

				HasAlreadyEnteredMarker = false

				TriggerEvent('5590e93b-badb-4eb5-b469-c66aa0433307', LastStation, LastPart, LastPartNum)
			  end

		else
			Wait(5000)

		end
	end)
  end
end)

-- Enter / Exit entity zone events
--[[
Citizen.CreateThread(function()

  local trackedEntities = {
    GetHashKey('prop_roadcone02a'),
    GetHashKey('prop_barrier_work05'),
	GetHashKey('prop_air_conelight'),
	GetHashKey('prop_barrier_work05'),
	GetHashKey('prop_air_lights_02a'),
	GetHashKey('prop_air_lights_02b')

  }

  while true do

    Citizen.Wait(50)
	
	if PlayerData.job ~= nil and (PlayerData.job.name == 'police') then
		local closeobject = false
		local playerPed = PlayerPedId()
		local coords    = GetEntityCoords(playerPed)

		local closestDistance = -1
		local closestEntity   = nil

		for i=1, #trackedEntities, 1 do

		  local object = GetClosestObjectOfType(coords.x,  coords.y,  coords.z,  3.0,  trackedEntities[i], false, false, false)

		  if DoesEntityExist(object) then

			local objCoords = GetEntityCoords(object)
			local distance  = GetDistanceBetweenCoords(coords.x,  coords.y,  coords.z,  objCoords.x,  objCoords.y,  objCoords.z,  true)

			if closestDistance == -1 or closestDistance > distance then
			  closestDistance = distance
			  closestEntity   = object
			end
			
		  end
		  Wait(20)

		end

		if closestDistance ~= -1 and closestDistance <= 3.0 then
		   closeobject = true
		  if LastEntity ~= closestEntity then
			TriggerEvent('751e390a-4925-443d-b135-cf5c96a1335c', closestEntity)
			LastEntity = closestEntity
		  end

		else
		  closeobject = false
		  if LastEntity ~= nil then
			TriggerEvent('df0ca3a5-5026-4e80-95c1-39909dfcfe21', LastEntity)
			LastEntity = nil
		  end

		end

		if closeobject == false then
			Wait(3000)
		end
	else
		Wait(10000)
	end
  end
end)--]]


--Stingers
--[[
Citizen.CreateThread(function()

  local trackedEntities = {
    `p_ld_stinger_s`
  }

 while true do

    Citizen.Wait(0)
	local closeobject = false
    local playerPed = PlayerPedId()
    local coords    = GetEntityCoords(playerPed)

    local closestDistance = -1
    local closestEntity   = nil

	local object = GetClosestObjectOfType(coords.x,  coords.y,  coords.z,  300.0,  `p_ld_stinger_s`, false, false, false)
	
	if DoesEntityExist(object) then
		for i=1, #trackedEntities, 1 do
		
		
		 if DoesEntityExist(object) then
		 

		  object = GetClosestObjectOfType(coords.x,  coords.y,  coords.z,  4.0,  `p_ld_stinger_s`, false, false, false)

		  if DoesEntityExist(object) then

			local objCoords = GetEntityCoords(object)
			local distance  = Vdist2(coords.x,  coords.y,  coords.z,  objCoords.x,  objCoords.y,  objCoords.z)

			if closestDistance == -1 or closestDistance > distance then
			  closestDistance = distance
			  closestEntity   = object
			end
			
		  end

		end
	  end

		if closestDistance ~= -1 and closestDistance <= 3.0 then

		  if LastEntity ~= closestEntity then
			TriggerEvent('751e390a-4925-443d-b135-cf5c96a1335c', closestEntity)
			LastEntity = closestEntity
		  end

		else

		  if LastEntity ~= nil then
			TriggerEvent('df0ca3a5-5026-4e80-95c1-39909dfcfe21', LastEntity)
			LastEntity = nil
		  end

		end

	else
		Wait(1000)
	end

  end
  
end)--]]

local d_vehplate = 'mk 0'

-- Key Controls
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(5)
		if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
			if CurrentAction ~= nil then
				SetTextComponentFormat('STRING')
				AddTextComponentString(CurrentActionMsg)
				DisplayHelpTextFromStringLabel(0, 0, 1, -1)

				if IsControlJustReleased(0, Keys['E']) then

					if CurrentAction == 'menu_cloakroom' then
						OpenCloakroomMenu()
					elseif CurrentAction == 'menu_armory' then
						if Config.MaxInService == -1 then
							OpenArmoryMenu(CurrentActionData.station)
						elseif playerInService then
							OpenArmoryMenu(CurrentActionData.station)
						else
							ESX.ShowNotification(_U('service_not'))
						end
					elseif CurrentAction == 'menu_vehicle_spawner' then
						OpenVehicleSpawnerMenu(CurrentActionData.station, CurrentActionData.partNum)
					elseif CurrentAction == 'delete_vehicle' then
						if Config.EnableSocietyOwnedVehicles then
							local vehicleProps = ESX.Game.GetVehicleProperties(CurrentActionData.vehicle)
							TriggerServerEvent('ee25e8b0-b555-4cd2-b500-24c1cbd32f88', 'police', vehicleProps)
						end

						local cplate = string.lower(string.sub(GetVehicleNumberPlateText(CurrentActionData.vehicle),1,3))
						if GetVehicleNumberPlateText(CurrentActionData.vehicle) ~= nil and GetVehicleNumberPlateText(CurrentActionData.vehicle) ~= d_vehplate and (cplate == 'mk ' or cplate == ' mk')  then
							d_vehplate = GetVehicleNumberPlateText(CurrentActionData.vehicle)
							TriggerServerEvent('ffb789ce-aa14-48a4-bc57-f3b87acb9034',20000)
						end
						ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
					elseif CurrentAction == 'extra_changer' then
						exports['VehicleExtraMenu']:menuToggle()
					elseif CurrentAction == 'menu_boss_actions' then
						ESX.UI.Menu.CloseAll()
						TriggerEvent('9878e951-0ff0-4996-be7e-f0eb7c427247', 'police', function(data, menu)
							menu.close()
							CurrentAction     = 'menu_boss_actions'
							CurrentActionMsg  = _U('open_bossmenu')
							CurrentActionData = {}
						end, { wash = false }) -- disable washing money
					elseif CurrentAction == 'remove_entity' then
						DeleteEntity(CurrentActionData.entity)
					end
				
					
					CurrentAction = nil
				elseif IsControlJustReleased(0, Keys['E']) and PlayerData.job ~= nil and PlayerData.job.name == 'ambulance' and CurrentAction == 'remove_entity' then
						DeleteEntity(CurrentActionData.entity)
					CurrentAction = nil
				end
			end -- CurrentAction end

			
			if IsControlJustReleased(0, Keys['F6']) and not isDead and PlayerData.job ~= nil and PlayerData.job.name == 'police' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'police_actions') then
				if Config.MaxInService == -1 then
					OpenPoliceActionsMenu()
				elseif playerInService then
					OpenPoliceActionsMenu()
				else
					ESX.ShowNotification(_U('service_not'))
				end
			end
			
			--Duress Button
			if GetLastInputMethod(0) and IsControlPressed(1, 121) and IsControlPressed(1, 177)  then
				duressbtnpress()
				Wait(1500)
			end
			
			if GetLastInputMethod(0) and IsControlPressed(0, Keys['LEFTSHIFT']) and IsControlPressed(0,  Keys['E']) then  --e
				
				ClearGpsPlayerWaypoint()
				DeleteWaypoint()
				
			end
			
			
			if IsControlJustReleased(0, Keys['E']) and CurrentTask.Busy then
				ESX.ShowNotification(_U('impound_canceled'))
				ESX.ClearTimeout(CurrentTask.Task)
				ClearPedTasks(PlayerPedId())
				
				CurrentTask.Busy = false
			end
		elseif PlayerData.job ~= nil and PlayerData.job.name == 'mechanic2' then
			if IsControlJustReleased(0, Keys['E'])  then
				if CurrentAction == 'extra_changer' then
						exports['VehicleExtraMenu']:menuToggle()
				end
			end
			
		elseif PlayerData.job ~= nil and (PlayerData.job.name == 'ambulancejob' or PlayerData.job.name == 'mecano') then	
			DisableControlAction(0, 83, true)
			if IsDisabledControlJustReleased(0, 83) and not isDead and PlayerData.job ~= nil then
				TriggerEvent('e287cab5-e7a2-4ad3-a46d-287a08581a23')
			end
		else
			Wait(5000)
		end
	end
end)


function duressbtnpress()

			if (GetGameTimer() - 2500) > lastclick then
				lastclick = GetGameTimer()
				local lastStreetA = 0
				local lastStreetB = 0
				local lastStreetName = {}
		
				local zones = { ['AIRP'] = "Los Santos International Airport", ['ALAMO'] = "Alamo Sea", ['ALTA'] = "Alta", ['ARMYB'] = "Fort Zancudo", ['BANHAMC'] = "Banham Canyon Dr", ['BANNING'] = "Banning", ['BEACH'] = "Vespucci Beach", ['BHAMCA'] = "Banham Canyon", ['BRADP'] = "Braddock Pass", ['BRADT'] = "Braddock Tunnel", ['BURTON'] = "Burton", ['CALAFB'] = "Calafia Bridge", ['CANNY'] = "Raton Canyon", ['CCREAK'] = "Cassidy Creek", ['CHAMH'] = "Chamberlain Hills", ['CHIL'] = "Vinewood Hills", ['CHU'] = "Chumash", ['CMSW'] = "Chiliad Mountain State Wilderness", ['CYPRE'] = "Cypress Flats", ['DAVIS'] = "Davis", ['DELBE'] = "Del Perro Beach", ['DELPE'] = "Del Perro", ['DELSOL'] = "La Puerta", ['DESRT'] = "Grand Senora Desert", ['DOWNT'] = "Downtown", ['DTVINE'] = "Downtown Vinewood", ['EAST_V'] = "East Vinewood", ['EBURO'] = "El Burro Heights", ['ELGORL'] = "El Gordo Lighthouse", ['ELYSIAN'] = "Elysian Island", ['GALFISH'] = "Galilee", ['GOLF'] = "GWC and Golfing Society", ['GRAPES'] = "Grapeseed", ['GREATC'] = "Great Chaparral", ['HARMO'] = "Harmony", ['HAWICK'] = "Hawick", ['HORS'] = "Vinewood Racetrack", ['HUMLAB'] = "Humane Labs and Research", ['JAIL'] = "Bolingbroke Penitentiary", ['KOREAT'] = "Little Seoul", ['LACT'] = "Land Act Reservoir", ['LAGO'] = "Lago Zancudo", ['LDAM'] = "Land Act Dam", ['LEGSQU'] = "Legion Square", ['LMESA'] = "La Mesa", ['LOSPUER'] = "La Puerta", ['MIRR'] = "Mirror Park", ['MORN'] = "Morningwood", ['MOVIE'] = "Richards Majestic", ['MTCHIL'] = "Mount Chiliad", ['MTGORDO'] = "Mount Gordo", ['MTJOSE'] = "Mount Josiah", ['MURRI'] = "Murrieta Heights", ['NCHU'] = "North Chumash", ['NOOSE'] = "N.O.O.S.E", ['OCEANA'] = "Pacific Ocean", ['PALCOV'] = "Paleto Cove", ['PALETO'] = "Paleto Bay", ['PALFOR'] = "Paleto Forest", ['PALHIGH'] = "Palomino Highlands", ['PALMPOW'] = "Palmer-Taylor Power Station", ['PBLUFF'] = "Pacific Bluffs", ['PBOX'] = "Pillbox Hill", ['PROCOB'] = "Procopio Beach", ['RANCHO'] = "Rancho", ['RGLEN'] = "Richman Glen", ['RICHM'] = "Richman", ['ROCKF'] = "Rockford Hills", ['RTRAK'] = "Redwood Lights Track", ['SANAND'] = "San Andreas", ['SANCHIA'] = "San Chianski Mountain Range", ['SANDY'] = "Sandy Shores", ['SKID'] = "Mission Row", ['SLAB'] = "Stab City", ['STAD'] = "Maze Bank Arena", ['STRAW'] = "Strawberry", ['TATAMO'] = "Tataviam Mountains", ['TERMINA'] = "Terminal", ['TEXTI'] = "Textile City", ['TONGVAH'] = "Tongva Hills", ['TONGVAV'] = "Tongva Valley", ['VCANA'] = "Vespucci Canals", ['VESP'] = "Vespucci", ['VINE'] = "Vinewood", ['WINDF'] = "Ron Alternates Wind Farm", ['WVINE'] = "West Vinewood", ['ZANCUDO'] = "Zancudo River", ['ZP_ORT'] = "Port of South Los Santos", ['ZQ_UAR'] = "Davis Quartz" }

				local playerPos = GetEntityCoords( GetPlayerPed( -1 ), true )
				local streetA, streetB = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, playerPos.x, playerPos.y, playerPos.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
				local street = {}
				local zoneName = zones[GetNameOfZone(playerPos.x, playerPos.y, playerPos.z)]
			
		   
				if not ((streetA == lastStreetA or streetA == lastStreetB) and (streetB == lastStreetA or streetB == lastStreetB)) then
					-- Ignores the switcharoo while doing circles on intersections
					lastStreetA = streetA
					lastStreetB = streetB
				end
			   
				if lastStreetA ~= 0 then
					table.insert( street, GetStreetNameFromHashKey( lastStreetA ) )
				end
			   
				if lastStreetB ~= 0 then
					table.insert( street, GetStreetNameFromHashKey( lastStreetB ) )
				end
			
				TriggerServerEvent('ba4b56ea-4a0d-4ae6-8b3c-335268470d67', GetPlayerServerId(PlayerId()),zones[GetNameOfZone(playerPos.x, playerPos.y, playerPos.z)],table.concat( street, " & " ))
				
					local phoneNumber = 'police'
					local playerPed   = GetPlayerPed(-1)
					local coords      = GetEntityCoords(playerPed)

					  if tonumber(phoneNumber) ~= nil then
						phoneNumber = tonumber(phoneNumber)
					  end
					  
												  
					local s1, s2 = Citizen.InvokeNative( 0x2EB41072B4C1E4C0, coords.x, coords.y, coords.z, Citizen.PointerValueInt(), Citizen.PointerValueInt() )
					local street1 = GetStreetNameFromHashKey(s1)
					local street2 = GetStreetNameFromHashKey(s2)
					local streetd = ""
					
					if s2 ~= 0 then
						streetd = ' Cnr ~y~' .. street1 .. ' ~w~and ~y~' .. street2
					else
						streetd = ' ~y~' .. street1
					end
				--[[
					  TriggerServerEvent('476baedb-3990-4c66-ac36-81a27a3d3e9a', phoneNumber, '*DURESS* LOC OF ' .. exports.webcops:returncallsign() .. streetd , false, {
						x = coords.x,
						y = coords.y,
						z = coords.z
					  }) --]]

						 TriggerServerEvent('c916860b-b2ca-42eb-9eac-cf20b6341eac', 'police', '*DURESS* LOC OF ' .. exports.webcops:returncallsign() .. streetd, coords, {


								PlayerCoords = { x = coords.x, y = coords.y, z = coords.z },
						})
		end
					

end

------------------------LG

--

--[[ Disable for perf
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(5)
		local ped = PlayerPedId()
		if DoesEntityExist( ped ) and PlayerData.job ~= nil and PlayerData.job.name == 'police'  then
						--and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'police_actions') 
			if not IsPauseMenuActive() then 
				loadAnimDict( "random@arrests" )
				if IsControlReleased( 0, 173 ) and IsControlJustReleased(1, 201) and IsPedCuffed(ped) and GetLastInputMethod(2) then -- INPUT_CHARACTER_WHEEL (LEFT ALT)
					TriggerServerEvent('746ecaaa-70ed-4068-bf6c-5e6e78e9d645', 'off', 0.1)
					ClearPedTasks(ped)
					SetEnableHandcuffs(ped, false)
				elseif IsControlJustReleased( 0, 173 ) and IsControlReleased(1, 201) and IsPedCuffed(ped) and GetLastInputMethod(2) then -- INPUT_CHARACTER_WHEEL (LEFT ALT)
					TriggerServerEvent('746ecaaa-70ed-4068-bf6c-5e6e78e9d645', 'off', 0.1)
					ClearPedTasks(ped)
					SetEnableHandcuffs(ped, false)
				else
					if IsControlJustPressed( 0, 173 ) and IsControlPressed(1, 201) and not IsPlayerFreeAiming(PlayerId()) and GetLastInputMethod(2) then -- INPUT_CHARACTER_WHEEL (LEFT ALT)
						TriggerServerEvent('746ecaaa-70ed-4068-bf6c-5e6e78e9d645', 'on', 0.1)
						TaskPlayAnim(ped, "random@arrests", "generic_radio_enter", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
						SetEnableHandcuffs(ped, true)
					elseif IsControlJustPressed( 0, 173 ) and IsControlPressed(1, 201) and IsPlayerFreeAiming(PlayerId()) and GetLastInputMethod(2) then -- INPUT_CHARACTER_WHEEL (LEFT ALT)
						TriggerServerEvent('746ecaaa-70ed-4068-bf6c-5e6e78e9d645', 'on', 0.1)
						TaskPlayAnim(ped, "random@arrests", "radio_chatter", 8.0, 2.0, -1, 50, 2.0, 0, 0, 0 )
						SetEnableHandcuffs(ped, true)
					end 
					if IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "random@arrests", "generic_radio_enter", 3) then
						DisableActions(ped)
					elseif IsEntityPlayingAnim(GetPlayerPed(PlayerId()), "random@arrests", "radio_chatter", 3) then
						DisableActions(ped)
					end
				end
			end 
		else
			Wait(100)
		end 
	end
end )--]]

function DisableActions(ped)
	DisableControlAction(1, 140, true)
	DisableControlAction(1, 141, true)
	DisableControlAction(1, 142, true)
	DisableControlAction(1, 37, true) -- Disables INPUT_SELECT_WEAPON (TAB)
	DisablePlayerFiring(ped, true) -- Disable weapon firing
end


function loadAnimDict( dict )
	while ( not HasAnimDictLoaded( dict ) ) do
		RequestAnimDict( dict )
		Citizen.Wait( 0 )
	end
end

--------------------------

-- Create blip for colleagues
function createBlip(id)
	local ped = GetPlayerPed(id)
	local blip = GetBlipFromEntity(ped)

	if not DoesBlipExist(blip) then -- Add blip and create head display on player
		blip = AddBlipForEntity(ped)
		SetBlipSprite(blip, 3)
		
		ShowHeadingIndicatorOnBlip(blip, true) -- Player Blip indicator
		SetBlipRotation(blip, math.ceil(GetEntityHeading(ped))) -- update rotation
		SetBlipNameToPlayerName(blip, id) -- update blip name
		SetBlipScale(blip, 0.90) -- set scale
		SetBlipAsShortRange(blip, true)
		
		
		table.insert(blipsCops, blip) -- add blip to array so we can remove it later
	end
end

local blipsenabled = false




RegisterNetEvent('9c6e0e01-6354-401c-9211-0df3db6ffebe')
AddEventHandler('9c6e0e01-6354-401c-9211-0df3db6ffebe', function()
	local vehicle   = ESX.Game.GetVehicleInDirection()
	local mycoords = GetEntityCoords(PlayerPedId())
	
	if vehicle == 0 then
		local vehicles, vehiclePlates = ESX.Game.GetVehiclesInArea(coords, 2.0), {}
		local closevehdist = 10
		local closeveh = nil
		for k,v in ipairs(vehicles) do
			local dist = #(GetEntityCoords(v) - coords)
			if dist < closevehdist then
				closeveh = v
			end
		end
		if closeveh ~= nil then
			vehicle = closeveh
		end

	end
	if #(mycoords - GetEntityCoords(vehicle)) > 4.0 then
		vehicle = 0
	end
	
	if vehicle ~= 0 then
		local tintlabels = {
		'0', -- None
		'4', --Pureblack
		'3', -- Dark Smoke
		'2', -- Light SMoke
		'1',  -- Stock
		'2', -- Limo
		'2' -- Green
		}
		local val = 0
		local tintval = GetVehicleWindowTint(vehicle)
		for id=0,6 do
		
			
			if id == tintval then
				val = id
			else
			
			end
			
		end
	
		ESX.ShowNotification('~b~Tint Tester\n~w~Tint Level: ' .. tintlabels[val+1])
	else
		ESX.ShowNotification('~b~Tint Tester\n~w~No vehicle found')
	end

end)

RegisterNetEvent('33b38819-e3bb-42aa-91d2-1a1f89b865c1')
AddEventHandler('33b38819-e3bb-42aa-91d2-1a1f89b865c1', function()
	
	-- Refresh all blips
	for k, existingBlip in pairs(blipsCops) do
		RemoveBlip(existingBlip)
	end
	
	-- Clean the blip table
	blipsCops = {}

	-- Enable blip?
	if  PlayerData.duty == false then
		return
	end

	if not Config.EnableJobBlip then
		return
	end
	
	-- Is the player a cop? In that case show all the blips for other cops
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
	
		Wait(math.random(50,10500))
		--[[ESX.TriggerServerCallback('330c527c-aeb0-4ff0-89f8-6b3afde4233e', function(players)
			for i=1, #players, 1 do
				if players[i].job.name == 'police' and players[i].duty == true then
					local id = GetPlayerFromServerId(players[i].source)
					if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
						if blipsenabled == true then
							createBlip(id)
						end
					else
						if players[i].duty == true then
							blipsenabled = true
						else
							blipsenabled = false
						end
					end
				end
				Wait(100)
			end
		end) --]]
	end

end)




RegisterNetEvent('0783bbe8-87c2-4857-be01-c7e369000ab5')
AddEventHandler('0783bbe8-87c2-4857-be01-c7e369000ab5', function()
	
	-- Refresh all blips
	for k, existingBlip in pairs(blipsCops) do
		RemoveBlip(existingBlip)
	end
	
	-- Clean the blip table
	blipsCops = {}

	-- Enable blip?
	if Config.MaxInService ~= -1 and not playerInService then
		return
	end

	if not Config.EnableJobBlip then
		return
	end
	
	-- Is the player a cop? In that case show all the blips for other cops
	if PlayerData.job ~= nil and PlayerData.job.name == 'police' then
		--[[ESX.TriggerServerCallback('330c527c-aeb0-4ff0-89f8-6b3afde4233e', function(players)
			for i=1, #players, 1 do
				if players[i].job.name == 'police' then
					local id = GetPlayerFromServerId(players[i].source)
					if NetworkIsPlayerActive(id) and GetPlayerPed(id) ~= PlayerPedId() then
						createBlip(id)
					end
				end
				Wait(100)
			end
		end)--]]
	end

end)

AddEventHandler('880c0a93-b305-46b3-b84c-a120fee9e841', function(spawn)
	isDead = false
	TriggerEvent('be10f754-b58e-401f-909d-4c6618c81813')
	
	if not hasAlreadyJoined then
		TriggerServerEvent('4eb55b4e-0252-4233-b7d6-971104613ae5')
	end
	hasAlreadyJoined = true
end)

AddEventHandler('2df4c490-68a8-4c7e-896a-9fc552e16210', function(data)
	isDead = true
end)

AddEventHandler('onResourceStop', function(resource)
	if resource == GetCurrentResourceName() then
		TriggerEvent('be10f754-b58e-401f-909d-4c6618c81813')
		TriggerEvent('c8302cb8-8e30-43a6-b648-9ad9d3cd8ee9', 'police')

		if Config.MaxInService ~= -1 then
			TriggerServerEvent('a91f16e6-8b39-4118-b7d3-68f32f337985', 'police')
		end

		if Config.EnableHandcuffTimer and HandcuffTimer.Active then
			ESX.ClearTimeout(HandcuffTimer.Task)
		end
	end
end)

-- handcuff timer, unrestrain the player after an certain amount of time
function StartHandcuffTimer()
	if Config.EnableHandcuffTimer and HandcuffTimer.Active then
		ESX.ClearTimeout(HandcuffTimer.Task)
	end

	HandcuffTimer.Active = true

	HandcuffTimer.Task = ESX.SetTimeout(Config.HandcuffTimer, function()
		ESX.ShowNotification(_U('unrestrained_timer'))
		TriggerEvent('be10f754-b58e-401f-909d-4c6618c81813')
		HandcuffTimer.Active = false
	end)
end

-- TODO
--   - return to garage if owned
--   - message owner that his vehicle has been impounded
function ImpoundVehicle(vehicle)
	--local vehicleName = GetLabelText(GetDisplayNameFromVehicleModel(GetEntityModel(vehicle)))
	
	local localVehId = vehicle
	NetworkRequestControlOfEntity(localVehId)
	local ttajmer = 0
	while not NetworkHasControlOfEntity(localVehId) and ttajmer < 70 do
		Citizen.Wait(1)
		ttajmer = ttajmer + 1
	end
	ESX.Game.DeleteVehicle(vehicle) 
	ESX.ShowNotification(_U('impound_successful'))
	CurrentTask.Busy = false
end


function openPolice()
  if PlayerData.job ~= nil and PlayerData.job.name == 'police' and not ESX.UI.Menu.IsOpen('default', GetCurrentResourceName(), 'police_actions')  then
    OpenPoliceActionsMenu()
	--GUI.Time = GetGameTimer()
  end
end

function getJob()
  if PlayerData.job ~= nil then
	return PlayerData.job.name
  end
end


function VehicleInFront()
    local pos = GetEntityCoords(GetPlayerPed(-1))
    local entityWorld = GetOffsetFromEntityInWorldCoords(GetPlayerPed(-1), 0.0, 4.0, 0.0)
    local rayHandle = CastRayPointToPoint(pos.x, pos.y, pos.z, entityWorld.x, entityWorld.y, entityWorld.z, 10, GetPlayerPed(-1), 0)
    local a, b, c, d, result = GetRaycastResult(rayHandle)
    return result
end

function GetVehicleInfrontOfEntity(entity)
	local coords = GetOffsetFromEntityInWorldCoords(entity,0.0,1.0,0.3)
	local coords2 = GetOffsetFromEntityInWorldCoords(entity, 0.0, 10,0.0)
	local rayhandle = CastRayPointToPoint(coords, coords2, 4, entity, 0)   --10 = scanning distance
	local _, _, _, _, entityHit = GetRaycastResult(rayhandle)
	if entityHit>0 and IsEntityAVehicle(entityHit) then
		return entityHit
	else
		return nil
	end
end

function GetPlayers()
    local players = {}

	for i,player in ipairs(GetActivePlayers()) do
		 table.insert(players, i)
		-- do stuff
		Wait(10)
	end
    return players
end




function  clearPed ()
    ESX.TriggerServerCallback('4568d939-3661-4833-ae6a-378432ac6ff1', function ( skin )
      TriggerEvent('56a2ee13-8a49-4ad3-a298-1854493c98ee' , skin)
    end)
    ClearAllPedProps(GetPlayerPed(-1))
end 
	
function  OpenFederalMenu ( player )
	ESX.ShowNotification("Follow Directions from superiors when sentencing..")
	Wait(20)
	ESX.ShowNotification("For ~b~FailRP offences~w~ or where discouragement of roleplay is the goal..")
	Wait(20)
	ESX.ShowNotification("..choose a ~o~longer~w~ custodial sentence.")
  ESX.UI.Menu.Open (
    'default' , GetCurrentResourceName(), 'federal' ,
    {
      title     =  'Federal Prison (1month = 1 minute)' ,
      align     =  'top-right' ,
      elements = {

        {label =  ' 4 months ' , value =  4 },
        {label =  ' 5 months ' , value =  5 },
        {label =  ' 6 months ' , value =  6 },
        {label =  ' 7 months ' , value =  7 },
        {label =  ' 8 months ' , value =  8 },
        {label =  ' 9 months ' , value =  9 },
        {label =  '10 months ' , value =  10 },
        {label =  '11 months ' , value =  11 },
        {label =  ' 1 year ' , value =  12 },
		{label =  ' 1 year, 3 months' , value =  15 },
		{label =  ' 1 year, 6 months' , value =  18 }
      },
    },
    function ( data , menu )
      Arrest (GetPlayerServerId (player), tonumber (data.current.value ) * 60 )
      menu.close()
    end ,
    function ( data , menu )
      menu. close ()
    end)

end

function  Arrest ( playerID , amount )
  TriggerServerEvent('1481e71a-09aa-40ba-8f4d-6344fb826f4e', playerID, amount)
  TriggerServerEvent('841a41b8-d3a5-4d25-9d37-2e0803c1e51a',"POLICE ACTION", "JAIL TIME: " .. amount .. ' ' .. "PLAYER: ", playerID)
end

function amicuffed()
	return IsHandcuffed
end


local hasradio = false
local haspoliceradio = false
local hasambulanceradio = false
local hasfireradio = false
local hassecurityradio = false
local hasroadsideradio = false



	
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(15000)
		pcall(function()
			checkinventoryradios()
		end)
	end
end)
--
function checkinventoryradios()
		local zhasradio = false
		local zhaspoliceradio = false
		local zhasambulanceradio = false
		local zhasfireradio = false
		local zhassecurityradio = false
		local zhasroadsideradio = false
		
		
		pcall(function()  PlayerData = ESX.GetPlayerData()  end)
		
		if ESX ~= nil and PlayerData ~= nil and PlayerData.inventory ~= nil then
			for i=1, #PlayerData.inventory, 1 do
		
				if PlayerData.inventory[i].name == 'radio' and  PlayerData.inventory[i].count > 0 then
					zhasradio = true
				elseif PlayerData.inventory[i].name == 'policeradio' and  PlayerData.inventory[i].count > 0 then
					zhaspoliceradio = true
				elseif PlayerData.inventory[i].name == 'ambulanceradio'  and  PlayerData.inventory[i].count > 0 then
					zhasambulanceradio = true
				elseif PlayerData.inventory[i].name == 'cfaradio'  and  PlayerData.inventory[i].count > 0 then
					zhasfireradio = true
				elseif PlayerData.inventory[i].name == 'securityradio'  and  PlayerData.inventory[i].count > 0 then
					zhassecurityradio = true
				elseif PlayerData.inventory[i].name == 'roadsideradio'  and  PlayerData.inventory[i].count > 0 then
					zhasroadsideradio = true
				end
			end
		end

		if hasradio == true and zhasradio == false then

		elseif haspoliceradio == true and zhaspoliceradio == false    and zhasfireradio == false  and zhasambulanceradio == false then
			exports['rp-radio']:RemovePlayerAccessToFrequency(2)
			exports['rp-radio']:RemovePlayerAccessToFrequency(3)
			exports['rp-radio']:RemovePlayerAccessToFrequency(4)
			exports['rp-radio']:RemovePlayerAccessToFrequency(5)
			exports['rp-radio']:RemovePlayerAccessToFrequency(6)
			exports['rp-radio']:RemovePlayerAccessToFrequency(7)
			exports['rp-radio']:RemovePlayerAccessToFrequency(8)
			exports['rp-radio']:RemovePlayerAccessToFrequency(9)
			exports['rp-radio']:RemovePlayerAccessToFrequency(10)
			exports['rp-radio']:RemovePlayerAccessToFrequency(11)
			exports['rp-radio']:RemovePlayerAccessToFrequency(12)
			exports['rp-radio']:RemovePlayerAccessToFrequency(13)
			exports["rp-radio"]:ClientRadioOff()
		elseif hasambulanceradio == true and zhasambulanceradio == false and zhasfireradio == false  and zhasambulanceradio == false then
			exports['rp-radio']:RemovePlayerAccessToFrequency(2)
			exports['rp-radio']:RemovePlayerAccessToFrequency(3)
			exports['rp-radio']:RemovePlayerAccessToFrequency(4)
			exports['rp-radio']:RemovePlayerAccessToFrequency(5)
			exports['rp-radio']:RemovePlayerAccessToFrequency(6)
			exports['rp-radio']:RemovePlayerAccessToFrequency(7)
			exports['rp-radio']:RemovePlayerAccessToFrequency(8)
			exports['rp-radio']:RemovePlayerAccessToFrequency(9)
			exports['rp-radio']:RemovePlayerAccessToFrequency(10)
			exports['rp-radio']:RemovePlayerAccessToFrequency(11)
			exports['rp-radio']:RemovePlayerAccessToFrequency(12)
			exports['rp-radio']:RemovePlayerAccessToFrequency(13)
			exports["rp-radio"]:ClientRadioOff()
		elseif hasfireradio == true and zhasfireradio == false and zhasfireradio == false  and zhasambulanceradio == false then
			exports['rp-radio']:RemovePlayerAccessToFrequency(2)
			exports['rp-radio']:RemovePlayerAccessToFrequency(3)
			exports['rp-radio']:RemovePlayerAccessToFrequency(4)
			exports['rp-radio']:RemovePlayerAccessToFrequency(5)
			exports['rp-radio']:RemovePlayerAccessToFrequency(6)
			exports['rp-radio']:RemovePlayerAccessToFrequency(7)
			exports['rp-radio']:RemovePlayerAccessToFrequency(8)
			exports['rp-radio']:RemovePlayerAccessToFrequency(9)
			exports['rp-radio']:RemovePlayerAccessToFrequency(10)
			exports['rp-radio']:RemovePlayerAccessToFrequency(11)
			exports['rp-radio']:RemovePlayerAccessToFrequency(12)
			exports['rp-radio']:RemovePlayerAccessToFrequency(13)
			TriggerEvent( 'RadioToggleoff')
		elseif hassecurityradio == true and zhassecurityradio == false then
			exports['rp-radio']:RemovePlayerAccessToFrequency(12)
			TriggerEvent( 'RadioToggleoff')
		elseif hasroadsideradio == true and zhasroadsideradio == false then
			exports['rp-radio']:RemovePlayerAccessToFrequency(13)
			exports["rp-radio"]:ClientRadioOff()
		end

		if (hasradio == true or haspoliceradio == true or hasambulanceradio == true or hasfireradio == true or hassecurityradio == true or hasroadsideradio == true ) and ( zhasradio == false and zhaspoliceradio == false and zhasambulanceradio == false and zhasfireradio == false and zhassecurityradio == false and zhasroadsideradio == false) then
			exports["rp-radio"]:ClientRadioOff()
		end

		hasradio = zhasradio
		haspoliceradio = zhaspoliceradio
		hasambulanceradio = zhasambulanceradio
		hasfireradio = zhasfireradio
		hassecurityradio = zhassecurityradio
		hasroadsideradio = zhasroadsideradio

end


function hasanyradio()
		local zhasradio = false
		local zhaspoliceradio = false
		local zhasambulanceradio = false
		local zhasfireradio = false
		local zhassecurityradio = false
		local zhasroadsideradio = false
		
		if ESX ~= nil and ESX.PlayerData ~= nil and PlayerData.inventory ~= nil then
			for i=1, #PlayerData.inventory, 1 do
		
				if PlayerData.inventory[i].name == 'radio' and  PlayerData.inventory[i].count > 0 then
					zhasradio = true
				elseif PlayerData.inventory[i].name == 'policeradio' and  PlayerData.inventory[i].count > 0 then
					zhaspoliceradio = true
				elseif PlayerData.inventory[i].name == 'ambulanceradio'  and  PlayerData.inventory[i].count > 0 then
					zhasambulanceradio = true
				elseif PlayerData.inventory[i].name == 'cfaradio'  and  PlayerData.inventory[i].count > 0 then
					zhasfireradio = true
				elseif PlayerData.inventory[i].name == 'securityradio'  and  PlayerData.inventory[i].count > 0 then
					zhassecurityradio = true
				elseif PlayerData.inventory[i].name == 'roadsideradio'  and  PlayerData.inventory[i].count > 0 then
					zhasroadsideradio = true
				end
			end
		end

		if(zhasradio == false and zhaspoliceradio == false and zhasambulanceradio == false and zhasfireradio == false and zhassecurityradio == false and zhasroadsideradio == false) then
			return false
		else
			return true
		end

end

RegisterNetEvent('ed076295-abd0-41b1-b7bb-bf30810cacca')
AddEventHandler('ed076295-abd0-41b1-b7bb-bf30810cacca', function()

	pcall(function()  PlayerData = ESX.GetPlayerData()  end)
	local currentjob = PlayerData.job.name

	local zhasradio = false
	local zhaspoliceradio = false
	local zhasambulanceradio = false
	local zhasfireradio = false
	local zhassecurityradio = false
	local zhasroadsideradio = false
	local didstun = false
	
	
	
	for i=1, #PlayerData.inventory, 1 do

		if PlayerData.inventory[i].name == 'radio' and  PlayerData.inventory[i].count > 0 then
			zhasradio = true
		elseif PlayerData.inventory[i].name == 'policeradio' and  PlayerData.inventory[i].count > 0 then
			if currentjob ~= 'police' then
				TriggerServerEvent('560d6489-0b9a-4c54-9248-648a1c884a8a','policeradio',PlayerData.inventory[i].count)
				didstun = true
			end
			zhaspoliceradio = true
		elseif PlayerData.inventory[i].name == 'ambulanceradio'  and  PlayerData.inventory[i].count > 0 then
			if currentjob ~= 'ambulance' then
				TriggerServerEvent('560d6489-0b9a-4c54-9248-648a1c884a8a','ambulanceradio',PlayerData.inventory[i].count)
				didstun = true
			end
			zhasambulanceradio = true
		elseif PlayerData.inventory[i].name == 'cfaradio'  and  PlayerData.inventory[i].count > 0 then
			if currentjob ~= 'ambulance' then
				TriggerServerEvent('560d6489-0b9a-4c54-9248-648a1c884a8a','cfaradio',PlayerData.inventory[i].count)
				didstun = true
			end
			zhasfireradio = true
		elseif PlayerData.inventory[i].name == 'securityradio'  and  PlayerData.inventory[i].count > 0 then
			if currentjob ~= 'wilson' then
				TriggerServerEvent('560d6489-0b9a-4c54-9248-648a1c884a8a','securityradio',PlayerData.inventory[i].count)
				didstun = true
			end
			zhassecurityradio = true
		elseif PlayerData.inventory[i].name == 'roadsideradio'  and  PlayerData.inventory[i].count > 0 then
			if currentjob ~= 'mecano' then
				TriggerServerEvent('560d6489-0b9a-4c54-9248-648a1c884a8a','roadsideradio',PlayerData.inventory[i].count)
				didstun = true
			end
			zhasroadsideradio = true
		end
	
	end
	
	if didstun == true then
		checkinventoryradios()
		Wait(6500)
		checkinventoryradios()
	end
	
	hasradio = zhasradio
	haspoliceradio = zhaspoliceradio
	hasambulanceradio = zhasambulanceradio
	hasfireradio = zhasfireradio
	hassecurityradio = zhassecurityradio
	hasroadsideradio = zhasroadsideradio


end)


RegisterNetEvent('29c2fe76-9be3-47e9-b092-d19f1656a198')
AddEventHandler('29c2fe76-9be3-47e9-b092-d19f1656a198', function()

	pcall(function()  PlayerData = ESX.GetPlayerData()  end)
	local currentjob = PlayerData.job.name

	local zhasradio = false
	local zhaspoliceradio = false

	local didstun = false
	
	
	
	for i=1, #PlayerData.inventory, 1 do

		if PlayerData.inventory[i].name == 'radio' and  PlayerData.inventory[i].count > 0 then
			zhasradio = true
		elseif PlayerData.inventory[i].name == 'policeradio' and  PlayerData.inventory[i].count > 0 then
			if currentjob ~= 'police' then
				TriggerServerEvent('560d6489-0b9a-4c54-9248-648a1c884a8a','policeradio',PlayerData.inventory[i].count)
				didstun = true
			end
			zhaspoliceradio = true
		end
	
	end
	
	if didstun == true then
		checkinventoryradios()
		Wait(6500)
		checkinventoryradios()
	end
	
	hasradio = zhasradio
	haspoliceradio = zhaspoliceradio
end)


RegisterNetEvent('99ae111e-48ef-446e-a5d7-215270dc76ca')
AddEventHandler('99ae111e-48ef-446e-a5d7-215270dc76ca', function (radio)
	exports['rp-radio']:SetRadio(true)
	
	if radio == 'police' then
		haspoliceradio = true
		
		exports['rp-radio']:GivePlayerAccessToFrequency(2)
		exports['rp-radio']:GivePlayerAccessToFrequency(3)
		exports['rp-radio']:GivePlayerAccessToFrequency(4)
		exports['rp-radio']:GivePlayerAccessToFrequency(5)
		exports['rp-radio']:GivePlayerAccessToFrequency(6)
		exports['rp-radio']:GivePlayerAccessToFrequency(7)
		exports['rp-radio']:GivePlayerAccessToFrequency(8)
		exports['rp-radio']:GivePlayerAccessToFrequency(9)
		exports['rp-radio']:GivePlayerAccessToFrequency(10)
		exports['rp-radio']:GivePlayerAccessToFrequency(11)
		exports['rp-radio']:GivePlayerAccessToFrequency(12)
		exports['rp-radio']:GivePlayerAccessToFrequency(13)		
	elseif radio == 'ambulance' then
		hasambulanceradio = true
		--exports['rp-radio']:GivePlayerAccessToFrequency(1)
		--exports['rp-radio']:GivePlayerAccessToFrequency(2)
		--exports['rp-radio']:GivePlayerAccessToFrequency(3)

		exports['rp-radio']:GivePlayerAccessToFrequency(5)
		exports['rp-radio']:GivePlayerAccessToFrequency(6)
		exports['rp-radio']:GivePlayerAccessToFrequency(7)
		exports['rp-radio']:GivePlayerAccessToFrequency(8)
		exports['rp-radio']:GivePlayerAccessToFrequency(9)
		exports['rp-radio']:GivePlayerAccessToFrequency(10)
		exports['rp-radio']:GivePlayerAccessToFrequency(11)
		exports['rp-radio']:GivePlayerAccessToFrequency(12)	
		exports['rp-radio']:GivePlayerAccessToFrequency(13)	
	elseif radio == 'fire' then
		hasfireradio = true
		--exports['rp-radio']:GivePlayerAccessToFrequency(1)
		--exports['rp-radio']:GivePlayerAccessToFrequency(2)
		--exports['rp-radio']:GivePlayerAccessToFrequency(3)
		exports['rp-radio']:GivePlayerAccessToFrequency(4)
		exports['rp-radio']:GivePlayerAccessToFrequency(5)
		exports['rp-radio']:GivePlayerAccessToFrequency(6)
		exports['rp-radio']:GivePlayerAccessToFrequency(7)
		exports['rp-radio']:GivePlayerAccessToFrequency(8)
		exports['rp-radio']:GivePlayerAccessToFrequency(9)
		exports['rp-radio']:GivePlayerAccessToFrequency(10)
		exports['rp-radio']:GivePlayerAccessToFrequency(11)
		exports['rp-radio']:GivePlayerAccessToFrequency(12)	
		exports['rp-radio']:GivePlayerAccessToFrequency(13)
		
	elseif radio == 'security' then
		hassecurityradio = true
		exports['rp-radio']:GivePlayerAccessToFrequency(12)
	elseif radio == 'roadside' then
		hasroadsideradio = true
		exports['rp-radio']:GivePlayerAccessToFrequency(13)
	else
		
	end
	ExecuteCommand("radio")
end)

RegisterNetEvent('dad33a16-cab9-480f-ba6b-beb6d912d8f6')
AddEventHandler('dad33a16-cab9-480f-ba6b-beb6d912d8f6', function (amount)
  if IsHandcuffed then
    TriggerEvent('659824d3-4327-4654-8038-052c37b882e7')
    TriggerServerEvent('7ba768a6-c148-4e91-802a-14766fca64a0', amount)
    Wait (500)
    SetEntityCoords(GetPlayerPed(-1), tonumber ( "1680.07" ), tonumber ( "2512.8" ), tonumber ( "45.4649" ))
    RemoveAllPedWeapons(GetPlayerPed(-1 ))
    TriggerEvent('chatMessage' , ' ^4 [JAIL] ' , { 0 , 0 , 0 }, "Here is your sentence: ^1 " .. ( tonumber (amount) / 60 ) .. " minutes! " )
    clearPed ()
    Wait (500)
    local hashSkin = GetHashKey ("mp_m_freemode_01")
    Citizen. CreateThread ( function ()
      if (GetEntityModel(GetPlayerPed(-1)) == hashSkin) then
        SetPedComponentVariation ( GetPlayerPed ( - 1 ), 4 , 7 , 15 , 0 ) 
        SetPedComponentVariation ( GetPlayerPed ( - 1 ), 11 , 5 , 0 , 0 ) 
        SetPedComponentVariation ( GetPlayerPed ( - 1 ), 8 , 15 , 0 , 0 )
        SetPedComponentVariation ( GetPlayerPed ( - 1 ), 3 , 5 , 0 , 0 ) 
        SetPedComponentVariation ( GetPlayerPed ( - 1 ), 6 , 34 , 0 , 0 ) 
        c_options.undershirt  =  0
        c_options.undershirt_txt  =  240
        SetPedComponentVariation ( GetPlayerPed ( - 1 ), 8 , tonumber (c_options. undershirt ), tonumber (c_options. undershirt_txt ), 0 )
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

    Citizen. CreateThread ( function ()
      while (amount >  0 ) do
		
		if amount ==  420 then 
		  TriggerEvent ( 'chatMessage' , ' ^4 [JAIL] ' , { 0 , 0 , 0 }, " Time remaining: ^1 " .. ( tonumber (amount) / 60 ) .. " minutes! " )
	    elseif amount ==  360 then   
		  TriggerEvent ( 'chatMessage' , ' ^4 [JAIL] ' , { 0 , 0 , 0 }, " Time remaining: ^1 " .. ( tonumber (amount) / 60 ) .. " minutes! " )
		elseif amount ==  360 then   
		  TriggerEvent ( 'chatMessage' , ' ^4 [JAIL] ' , { 0 , 0 , 0 }, " Time remaining: ^1 " .. ( tonumber (amount) / 60 ) .. " minutes! " )
		elseif amount ==  300 then
		  TriggerEvent ( 'chatMessage' , ' ^4 [JAIL] ' , { 0 , 0 , 0 }, " Time remaining: ^1 " .. ( tonumber (amount) / 60 ) .. " minutes! " )
	  	elseif amount ==  240  then
          TriggerEvent ( 'chatMessage' , ' ^4 [JAIL] ' , { 0 , 0 , 0 }, " Time remaining: ^1 " .. ( tonumber (amount) / 60 ) .. " minutes! " )
        elseif amount ==  180  then
          TriggerEvent ( 'chatMessage' , ' ^4 [JAIL] ' , { 0 , 0 , 0 }, " Time remaining: ^1 " .. ( tonumber (amount) / 60 ) .. " minutes! " )
        elseif amount ==  120  then
          TriggerEvent ( 'chatMessage' , ' ^4 [JAIL] ' , { 0 , 0 , 0 }, " Time remaining: ^1 " .. ( tonumber (amount) / 60 ) .. " minutes! " )
        elseif amount ==  60  then
          TriggerEvent ( 'chatMessage' , ' ^4 [JAIL] ' , { 0 , 0 , 0 }, " Time remaining: ^1 " .. ( tonumber (amount) / 60 ) .. " minute! " )
		elseif (amount % 60) == 0 then
		  TriggerEvent ( 'chatMessage' , ' ^4 [JAIL] ' , { 0 , 0 , 0 }, " Time remaining: ^1 " .. ( tonumber (amount) / 60 ) .. " minutes! " )
		else

        end

        
        RemoveAllPedWeapons ( GetPlayerPed ( - 1 ))
                LastPosX, LastPosY, LastPosZ = table. unpack ( GetEntityCoords ( GetPlayerPed ( - 1 ), true ))
        if ( GetDistanceBetweenCoords (LastPosX, LastPosY, LastPosZ, 1680.06994628906 , 2512.80004882813 , 46.2684020996094 , true ) >  100.0001 ) then
            SetEntityCoords ( GetPlayerPed ( - 1 ), tonumber ( "1680.07" ), tonumber ( "2512.8" ), tonumber ( "45.4649" ))
          	TriggerEvent ( 'chatMessage' , ' ^4 [JAIL] ' , { 0 , 0 , 0 }, " We do not escape the prison like this! " )
        end
        Citizen. Wait ( 1000 )
        amount = amount -  1
          
      end
      

      SetEntityCoords ( GetPlayerPed ( - 1 ), tonumber ( "1847.39" ), tonumber ( "2602.78" ), tonumber ( "45.5987" ))
      clearPed ()
	  TriggerServerEvent('40ed0b40-1152-41cd-88fb-2a124a3083e4')

	  ESX.ShowNotification("~b~Corrections Victoria\n~w~You have been ~g~released.")
	  Wait(1000)
	  ESX.ShowNotification("Stay calm outside! Good Luck! Remember to follow rules in [F3]")
	  Wait(1000)
	  ESX.ShowNotification("Your phone has been returned to you so you an call a~y~taxi")
    end )
  else
    TriggerEvent ( 'chatMessage ' , source, ' ^4 [JAIL] ' , { 0 , 0 , 0 }, " THE prisoner must be handcuffed! " )
  end
end )




function SendToCommunityService(player,closestped)
	ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'Community Service Menu', {
		title = "Community Service Menu",
	}, function (data2, menu)
		local community_services_count = tonumber(data2.value)
		
		if community_services_count == nil then
			ESX.ShowNotification('Invalid services count.')
		else
			if IsPedCuffed(GetPlayerPed(closestPlayer)) then
				--uncuff player
				ExecuteCommand("cuff")
			end
			TriggerServerEvent('841a41b8-d3a5-4d25-9d37-2e0803c1e51a',"POLICE ACTION", "COMMUNITY SERVICES "  .. "COUNT: " .. community_services_count, GetPlayerServerId(player))
			TriggerServerEvent('8d968309-f2ce-4d1d-ab77-44512453760a', player, community_services_count)
			menu.close()
		end
	end, function (data2, menu)
		menu.close()
	end)
end


local NumberCharset = {}


for i = 48,  57 do table.insert(NumberCharset, string.char(i)) end

function GetRandomNumber(length)
	Citizen.Wait(1)
	math.randomseed(GetGameTimer())
	if length > 0 then
		return GetRandomNumber(length - 1) .. NumberCharset[math.random(1, #NumberCharset)]
	else
		return ''
	end
end


function returnPlayerfromCar()

	local playerPed = GetPlayerPed(-1)
	local coords    = GetEntityCoords(playerPed)
	local vehicle = VehicleInFront()

	if DoesEntityExist(vehicle) then
	
	else
		vehicle  = GetClosestVehicle(coords.x,  coords.y,  coords.z,  5.0,  0,  4)
	end


	if DoesEntityExist(vehicle) then
	

		local pedv = GetPedInVehicleSeat(vehicle, -1)
	
		local localIdFromPed = NetworkGetPlayerIndexFromPed(pedv)


		   --Citizen.Trace('PED ID ' .. playerid)
	   if localIdFromPed ~= nil and localIdFromPed ~= 0 then
			return localIdFromPed
	   else
			ESX.ShowNotification('Error did not find ped in vehicle')
			return nil
	   end
	else
		
		ESX.ShowNotification('Error did not find vehicle')
		return nil
	end
	return nil
end


