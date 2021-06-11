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



local HasAlreadyEnteredMarker = false
local LastZone                = nil
local CurrentAction           = nil
local CurrentActionMsg        = ''
local CurrentActionData       = {}
local IsInShopMenu            = false
local Categories              = {}
local Vehicles                = {}
local LastVehicles            = {}
local CurrentVehicleData      = nil
local closer 				  = false


--- esx
local PlayerData              = {}
local GUI = {}
ESX                           = nil
GUI.Time                      = 0

local  attemptcount 		  = 0

local  limitattemptcount	  = 6


AddTextEntry('models', 'Telstra ModelS')
AddTextEntry('hwpss', 'Police')
AddTextEntry('hwpsse', 'Police')
AddTextEntry('hwpssn', 'Police')
AddTextEntry('hwpumss', 'Police')
AddTextEntry('hwpumsse', 'Police')
AddTextEntry('gdhilux', 'Police')
AddTextEntry('hwpbmws', 'Police')
AddTextEntry('cirtvw', 'Police')
AddTextEntry('dogcar', 'Police')
AddTextEntry('gdkluga', 'Police')
AddTextEntry('police5', 'Police')
AddTextEntry('afpss', 'Police')
AddTextEntry('afpumss', 'Police')
AddTextEntry('hwpx5', 'Police')
AddTextEntry('gdterry', 'Police')
AddTextEntry('gdterrye', 'Police')
AddTextEntry('gdumevoke', 'Police')
AddTextEntry('HWPFGX', 'Police')
AddTextEntry('HWPFJR', 'Police')
AddTextEntry('hwpkluger', 'Police')
AddTextEntry('hwplc', 'Police')
AddTextEntry('hwppassat', 'Police')
AddTextEntry('hwpssu', 'Police')
AddTextEntry('hwpterry', 'Police')
AddTextEntry('hwpumbmw', 'Police')
AddTextEntry('HWPUMFGX', 'Police')
AddTextEntry('hwpumterry', 'Police')
AddTextEntry('HWPUMWAG', 'Police')
AddTextEntry('hwpbmw', 'Police')
AddTextEntry('gdcamry', 'Police')
AddTextEntry('gdss', 'Police')
AddTextEntry('policebike', 'Police')
AddTextEntry('hwpx55', 'Police')
AddTextEntry('gddog', 'Police')
AddTextEntry('hwpbmwwag', 'Police')
AddTextEntry('hwpbmwwag2', 'Police')
AddTextEntry('foodcar4', "Domino's Pizza Car")





local soldcount = 0

local colorNames1 = {
    ['0'] = "Metallic Black",
    ['1'] = "Metallic Graphite Black",
    ['2'] = "Metallic Black Steal",
    ['3'] = "Metallic Dark Silver",
    ['4'] = "Metallic Silver",
    ['5'] = "Metallic Blue Silver",
    ['6'] = "Metallic Steel Gray",
    ['7'] = "Metallic Shadow Silver",
    ['8'] = "Metallic Stone Silver",
    ['9'] = "Metallic Midnight Silver",
    ['10'] = "Metallic Gun Metal",
    ['11'] = "Metallic Anthracite Grey",
    ['12'] = "Matte Black",
    ['13'] = "Matte Gray",
    ['14'] = "Matte Light Grey",
    ['15'] = "Util Black",
    ['16'] = "Util Black Poly",
    ['17'] = "Util Dark silver",
    ['18'] = "Util Silver",
    ['19'] = "Util Gun Metal",
    ['20'] = "Util Shadow Silver",
    ['21'] = "Worn Black",
    ['22'] = "Worn Graphite",
    ['23'] = "Worn Silver Grey",
    ['24'] = "Worn Silver",
    ['25'] = "Worn Blue Silver",
    ['26'] = "Worn Shadow Silver",
    ['27'] = "Metallic Red",
    ['28'] = "Metallic Torino Red",
    ['29'] = "Metallic Formula Red",
    ['30'] = "Metallic Blaze Red",
    ['31'] = "Metallic Graceful Red",
    ['32'] = "Metallic Garnet Red",
    ['33'] = "Metallic Desert Red",
    ['34'] = "Metallic Cabernet Red",
    ['35'] = "Metallic Candy Red",
    ['36'] = "Metallic Sunrise Orange",
    ['37'] = "Metallic Classic Gold",
    ['38'] = "Metallic Orange",
    ['39'] = "Matte Red",
    ['40'] = "Matte Dark Red",
    ['41'] = "Matte Orange",
    ['42'] = "Matte Yellow",
    ['43'] = "Util Red",
    ['44'] = "Util Bright Red",
    ['45'] = "Util Garnet Red",
    ['46'] = "Worn Red",
    ['47'] = "Worn Golden Red",
    ['48'] = "Worn Dark Red",
    ['49'] = "Metallic Dark Green",
    ['50'] = "Metallic Racing Green",
    ['51'] = "Metallic Sea Green",
    ['52'] = "Metallic Olive Green",
    ['53'] = "Metallic Green",
    ['54'] = "Metallic Gasoline Blue Green",
    ['55'] = "Matte Lime Green",
    ['56'] = "Util Dark Green",
    ['57'] = "Util Green",
    ['58'] = "Worn Dark Green",
    ['59'] = "Worn Green",
    ['60'] = "Worn Sea Wash",
    ['61'] = "Metallic Midnight Blue",
    ['62'] = "Metallic Dark Blue",
    ['63'] = "Metallic Saxony Blue",
    ['64'] = "Metallic Blue",
    ['65'] = "Metallic Mariner Blue",
    ['66'] = "Metallic Harbor Blue",
    ['67'] = "Metallic Diamond Blue",
    ['68'] = "Metallic Surf Blue",
    ['69'] = "Metallic Nautical Blue",
    ['70'] = "Metallic Bright Blue",
    ['71'] = "Metallic Purple Blue",
    ['72'] = "Metallic Spinnaker Blue",
    ['73'] = "Metallic Ultra Blue",
    ['74'] = "Metallic Bright Blue",
    ['75'] = "Util Dark Blue",
    ['76'] = "Util Midnight Blue",
    ['77'] = "Util Blue",
    ['78'] = "Util Sea Foam Blue",
    ['79'] = "Uil Lightning blue",
    ['80'] = "Util Maui Blue Poly",
    ['81'] = "Util Bright Blue",
    ['82'] = "Matte Dark Blue",
    ['83'] = "Matte Blue",
    ['84'] = "Matte Midnight Blue",
    ['85'] = "Worn Dark blue",
    ['86'] = "Worn Blue",
    ['87'] = "Worn Light blue",
    ['88'] = "Metallic Taxi Yellow",
    ['89'] = "Metallic Race Yellow",
    ['90'] = "Metallic Bronze",
    ['91'] = "Metallic Yellow Bird",
    ['92'] = "Metallic Lime",
    ['93'] = "Metallic Champagne",
    ['94'] = "Metallic Pueblo Beige",
    ['95'] = "Metallic Dark Ivory",
    ['96'] = "Metallic Choco Brown",
    ['97'] = "Metallic Golden Brown",
    ['98'] = "Metallic Light Brown",
    ['99'] = "Metallic Straw Beige",
    ['100'] = "Metallic Moss Brown",
    ['101'] = "Metallic Biston Brown",
    ['102'] = "Metallic Beechwood",
    ['103'] = "Metallic Dark Beechwood",
    ['104'] = "Metallic Choco Orange",
    ['105'] = "Metallic Beach Sand",
    ['106'] = "Metallic Sun Bleeched Sand",
    ['107'] = "Metallic Cream",
    ['108'] = "Util Brown",
    ['109'] = "Util Medium Brown",
    ['110'] = "Util Light Brown",
    ['111'] = "Metallic White",
    ['112'] = "Metallic Frost White",
    ['113'] = "Worn Honey Beige",
    ['114'] = "Worn Brown",
    ['115'] = "Worn Dark Brown",
    ['116'] = "Worn straw beige",
    ['117'] = "Brushed Steel",
    ['118'] = "Brushed Black steel",
    ['119'] = "Brushed Aluminium",
    ['120'] = "Chrome",
    ['121'] = "Worn Off White",
    ['122'] = "Util Off White",
    ['123'] = "Worn Orange",
    ['124'] = "Worn Light Orange",
    ['125'] = "Metallic Securicor Green",
    ['126'] = "Worn Taxi Yellow",
    ['127'] = "police car blue",
    ['128'] = "Matte Green",
    ['129'] = "Matte Brown",
    ['130'] = "Worn Orange",
    ['131'] = "Matte White",
    ['132'] = "Worn White",
    ['133'] = "Worn Olive Army Green",
    ['134'] = "Pure White",
    ['135'] = "Hot Pink",
    ['136'] = "Salmon pink",
    ['137'] = "Metallic Vermillion Pink",
    ['138'] = "Orange",
    ['139'] = "Green",
    ['140'] = "Blue",
    ['141'] = "Mettalic Black Blue",
    ['142'] = "Metallic Black Purple",
    ['143'] = "Metallic Black Red",
    ['144'] = "hunter green",
    ['145'] = "Metallic Purple",
    ['146'] = "Metaillic V Dark Blue",
    ['147'] = "MODSHOP BLACK1",
    ['148'] = "Matte Purple",
    ['149'] = "Matte Dark Purple",
    ['150'] = "Metallic Lava Red",
    ['151'] = "Matte Forest Green",
    ['152'] = "Matte Olive Drab",
    ['153'] = "Matte Desert Brown",
    ['154'] = "Matte Desert Tan",
    ['155'] = "Matte Foilage Green",
    ['156'] = "DEFAULT ALLOY COLOR",
    ['157'] = "Epsilon Blue",
}



local colorNames = {
    ['0'] = "Black",
    ['1'] = "Black",
    ['2'] = "Black",
    ['3'] = "Grey",
    ['4'] = "Silver",
    ['5'] = "Silver",
    ['6'] = "Silver",
    ['7'] = "Grey",
    ['8'] = "Silver",
    ['9'] = "Grey",
    ['10'] = "Grey",
    ['11'] = "Grey",
    ['12'] = "Black",
    ['13'] = "Gray",
    ['14'] = "Grey",
    ['15'] = "Black",
    ['16'] = "Black",
    ['17'] = "Grey",
    ['18'] = "Silver",
    ['19'] = "Grey",
    ['20'] = "Grey",
    ['21'] = "Black",
    ['22'] = "Grey",
    ['23'] = "Silver",
    ['24'] = "Silver",
    ['25'] = "Silver",
    ['26'] = "Silver",
    ['27'] = "Red",
    ['28'] = "Red",
    ['29'] = "Red",
    ['30'] = "Red",
    ['31'] = "Red",
    ['32'] = "Red",
    ['33'] = "Red",
    ['34'] = "Red",
    ['35'] = "Red",
    ['36'] = "Orange",
    ['37'] = "Yellow",
    ['38'] = "Orange",
    ['39'] = "Red",
    ['40'] = "Red",
    ['41'] = "Orange",
    ['42'] = "Yellow",
    ['43'] = "Red",
    ['44'] = "Red",
    ['45'] = "Red",
    ['46'] = "Red",
    ['47'] = "Red",
    ['48'] = "Red",
    ['49'] = "Green",
    ['50'] = "Green",
    ['51'] = "Green",
    ['52'] = "Green",
    ['53'] = "Green",
    ['54'] = "Green",
    ['55'] = "Green",
    ['56'] = "Green",
    ['57'] = "Green",
    ['58'] = "Green",
    ['59'] = "Green",
    ['60'] = "Green",
    ['61'] = "Blue",
    ['62'] = "Blue",
    ['63'] = "Blue",
    ['64'] = "Blue",
    ['65'] = "Blue",
    ['66'] = "Blue",
    ['67'] = "Blue",
    ['68'] = "Blue",
    ['69'] = "Blue",
    ['70'] = "Blue",
    ['71'] = "Purple",
    ['72'] = "Purple",
    ['73'] = "Blue",
    ['74'] = "Blue",
    ['75'] = "Blue",
    ['76'] = "Blue",
    ['77'] = "Blue",
    ['78'] = "Blue",
    ['79'] = "Blue",
    ['80'] = "Blue",
    ['81'] = "Blue",
    ['82'] = "Blue",
    ['83'] = "Blue",
    ['84'] = "Blue",
    ['85'] = "Blue",
    ['86'] = "Blue",
    ['87'] = "Blue",
    ['88'] = "Yellow",
    ['89'] = "Yellow",
    ['90'] = "Brown",
    ['91'] = "Yellow",
    ['92'] = "Green",
    ['93'] = "Brown",
    ['94'] = "Brown",
    ['95'] = "Brown",
    ['96'] = "Brown",
    ['97'] = "Brown",
    ['98'] = "Brown",
    ['99'] = "Brown",
    ['100'] = "Brown",
    ['101'] = "Brown",
    ['102'] = "Brown",
    ['103'] = "Brown",
    ['104'] = "Brown",
    ['105'] = "Yellow",
    ['106'] = "Yellow",
    ['107'] = "White",
    ['108'] = "Brown",
    ['109'] = "Brown",
    ['110'] = "Brown",
    ['111'] = "White",
    ['112'] = "White",
    ['113'] = "Yellow",
    ['114'] = "Brown",
    ['115'] = "Brown",
    ['116'] = "Yellow",
    ['117'] = "Silver",
    ['118'] = "Black",
    ['119'] = "Silver",
    ['120'] = "Chrome",
    ['121'] = "White",
    ['122'] = "White",
    ['123'] = "Orange",
    ['124'] = "Orange",
    ['125'] = "Green",
    ['126'] = "Yellow",
    ['127'] = "Blue",
    ['128'] = "Green",
    ['129'] = "Brown",
    ['130'] = "Orange",
    ['131'] = "White",
    ['132'] = "White",
    ['133'] = "Green",
    ['134'] = "White",
    ['135'] = "Pink",
    ['136'] = "Pink",
    ['137'] = "Pink",
    ['138'] = "Orange",
    ['139'] = "Green",
    ['140'] = "Blue",
    ['141'] = "Blue",
    ['142'] = "Purple",
    ['143'] = "Red",
    ['144'] = "Green",
    ['145'] = "Purple",
    ['146'] = "Blue",
    ['147'] = "Black",
    ['148'] = "Purple",
    ['149'] = "Purple",
    ['150'] = "Red",
    ['151'] = "Green",
    ['152'] = "Green",
    ['153'] = "Brown",
    ['154'] = "Brown",
    ['155'] = "Green",
    ['156'] = "Silver",
    ['157'] = "Blue",
}

Citizen.CreateThread(function ()
	while true do
		attemptcount = 0
		Wait(300000)
	end
end)

Citizen.CreateThread(function ()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end

	Citizen.Wait(10000)

	ESX.TriggerServerCallback('b4eb4c62-417b-4c93-9e6a-295b70298b32', function (categories)
		Categories = categories
	end)

	ESX.TriggerServerCallback('7c61bd5e-fa86-4437-a7cf-5f0fb10e9d94', function (vehicles)
		Vehicles = vehicles
	end)

	if Config.EnablePlayerManagement then
		if ESX.PlayerData ~= nil and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'cardealer' then
			Config.Zones.ShopEntering.Type = 1

			if ESX.PlayerData.job.grade_name == 'boss' then
				Config.Zones.BossActions.Type = 1
			end

		else
			Config.Zones.ShopEntering.Type = -1
			Config.Zones.BossActions.Type  = -1
		end
	end
end)





RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(xPlayer)
	ESX.PlayerData = xPlayer

	if Config.EnablePlayerManagement then
		if ESX.PlayerData.job.name == 'cardealer' then
			Config.Zones.ShopEntering.Type = 1

			if ESX.PlayerData.job.grade_name == 'boss' then
				Config.Zones.BossActions.Type = 1
			end

		else
			Config.Zones.ShopEntering.Type = -1
			Config.Zones.BossActions.Type  = -1
		end
	end
end)

RegisterNetEvent('bbda38ff-e53f-412e-8ac7-900b3ff15ab5')
AddEventHandler('bbda38ff-e53f-412e-8ac7-900b3ff15ab5', function (categories,vehicles,vlisting)
	Categories = categories
	Vehicles = vehicles
	
	Citizen.CreateThread(function ()
		for i=1, #vlisting, 1 do
			AddTextEntry(vlisting[i].model, vlisting[i].name)
		--	print(vlisting[i].model  ..  " = " .. GetHashKey(vlisting[i].model)  .. " = " ..  vlisting[i].name)
		end
	end)
end)

RegisterNetEvent('94518888-a2b3-40df-8131-7b7c88cd87d9')
AddEventHandler('94518888-a2b3-40df-8131-7b7c88cd87d9', function (vlisting)

	Citizen.CreateThread(function ()
		for i=1, #vlisting, 1 do
			AddTextEntry(vlisting[i].model, vlisting[i].name)
		end
	end)
	
end)




function DeleteShopInsideVehicles ()
  while #LastVehicles > 0 do
    local vehicle = LastVehicles[1]
    ESX.Game.DeleteVehicle(vehicle)
    table.remove(LastVehicles, 1)
  end
end

function ReturnVehicleProvider()
	ESX.TriggerServerCallback('d2bdaa6c-8b1b-49b6-9952-512a9ddf285f', function (vehicles)
		local elements = {}
		local returnPrice
		for i=1, #vehicles, 1 do
			returnPrice = ESX.Round(vehicles[i].price * 0.75)

			table.insert(elements, {
				label = vehicles[i].name .. ' [<span style="color: orange;">$' .. returnPrice .. '</span>]',
				value = vehicles[i].name
			})
		end
	
		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'return_provider_menu',
		{
			title    = _U('return_provider_menu'),
			align    = 'top-right',
			elements = elements
		}, function (data, menu)
			TriggerServerEvent('d2adab4c-5f1b-40b7-a39b-35eb6b1760db', data.current.value)

			Citizen.Wait(300)
			menu.close()

			ReturnVehicleProvider()
		end, function (data, menu)
			menu.close()
		end)
	end)

end


function OpenShopMenu ()
  IsInShopMenu = true

  ESX.UI.Menu.CloseAll()

  local playerPed = PlayerPedId()

  FreezeEntityPosition(playerPed, true)
  SetEntityVisible(playerPed, false)
  SetEntityCoords(playerPed, Config.Zones.ShopInside.Pos.x, Config.Zones.ShopInside.Pos.y, Config.Zones.ShopInside.Pos.z)

  local vehiclesByCategory = {}
  local elements           = {}
  local firstVehicleData   = nil

  for i=1, #Categories, 1 do
    vehiclesByCategory[Categories[i].name] = {}
  end

  for i=1, #Vehicles, 1 do
    table.insert(vehiclesByCategory[Vehicles[i].category], Vehicles[i])
  end

  for i=1, #Categories, 1 do
    local category         = Categories[i]
    local categoryVehicles = vehiclesByCategory[category.name]
    local options          = {}

    for j=1, #categoryVehicles, 1 do
      local vehicle = categoryVehicles[j]

      if i == 1 and j == 1 then
        firstVehicleData = vehicle
      end

      table.insert(options, vehicle.name .. ' <span style="color: green;">$' .. vehicle.price .. '</span>')
    end

    table.insert(elements, {
      name    = category.name,
      label   = category.label,
      value   = 0,
      type    = 'slider',
      max     = #Categories[i],
      options = options
    })
  end

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'vehicle_shop',
    {
      title    = _U('car_dealer'),
      align    = 'top-right',
      elements = elements
    },
    function (data, menu)
      local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]

      ESX.UI.Menu.Open(
        'default', GetCurrentResourceName(), 'shop_confirm',
        {
          title = _U('buy_vehicle_shop', vehicleData.name, vehicleData.price),
          align = 'top-right',
          elements = {
            {label = _U('yes'), value = 'yes'},
            {label = _U('no'),  value = 'no'},
			--{label = 'Attempt to Drive off with Vehicle',  value = 'steal'},
          },
        },
        function (data2, menu2)
          if data2.current.value == 'yes' then
            if Config.EnablePlayerManagement then
              ESX.TriggerServerCallback('4b35dd99-c3a3-43dc-b533-47e7ace906a2', function (hasEnoughMoney)
                if hasEnoughMoney then
                  IsInShopMenu = false

                  DeleteShopInsideVehicles()

                  local playerPed = PlayerPedId()

                  CurrentAction     = 'shop_menu'
                  CurrentActionMsg  = _U('shop_menu')
                  CurrentActionData = {}

                  FreezeEntityPosition(playerPed, false)
                  SetEntityVisible(playerPed, true)
                  SetEntityCoords(playerPed, Config.Zones.ShopEntering.Pos.x, Config.Zones.ShopEntering.Pos.y, Config.Zones.ShopEntering.Pos.z)

                  menu2.close()
                  menu.close()

                  ESX.ShowNotification(_U('vehicle_purchased'))
                else
                  ESX.ShowNotification(_U('broke_company'))
                end

              end, 'cardealer', vehicleData.model)
			
            else
              local playerData = ESX.GetPlayerData()

              if Config.EnableSocietyOwnedVehicles and playerData.job.grade_name == 'boss' then
                ESX.UI.Menu.Open(
                  'default', GetCurrentResourceName(), 'shop_confirm_buy_type',
                  {
                    title = _U('purchase_type'),
                    align = 'top-right',
                    elements = {
                      {label = _U('staff_type'),   value = 'personnal'},
                    --  {label = _U('society_type'), value = 'society'},
                    },
                  },
                  function (data3, menu3)

                    if data3.current.value == 'personnal' then
                      ESX.TriggerServerCallback('67367413-abcb-43dd-a822-d62d34b21ed6', function (hasEnoughMoney)
                        if hasEnoughMoney then
                          IsInShopMenu = false

                          menu3.close()
                          menu2.close()
                          menu.close()
						  
						Citizen.Trace('Primary Color Reg: ')
                          DeleteShopInsideVehicles()
							Citizen.Trace('Test C')
                          ESX.Game.SpawnVehicleClient(vehicleData.model, Config.Zones.ShopOutside.Pos, Config.Zones.ShopOutside.Heading, function (vehicle)

                            TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

                            local newPlate     = GeneratePlate()
                            local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                            vehicleProps.plate = newPlate
                            SetVehicleNumberPlateText(vehicle, newPlate)
							local model = GetEntityModel(vehicle)
							local vehname = GetLabelText(GetDisplayNameFromVehicleModel(model))
							local primary, secondary = cGetVehicleColours(vehicle)
							SetEntityAsMissionEntity(vehicle,true,true)
                            if Config.EnableOwnedVehicles then
                              TriggerServerEvent('3074e980-4cc8-4882-838a-659e0f634631', vehicleProps, vehname, primary)
                            end

                            ESX.ShowNotification(_U('vehicle_purchased'))
                          end)

                          FreezeEntityPosition(playerPed, false)
                          SetEntityVisible(playerPed, true)
                        else
                          ESX.ShowNotification(_U('not_enough_money'))
                        end
                      end, vehicleData.model)
                    end

                    if data3.current.value == 'society' then
                      ESX.TriggerServerCallback('4b35dd99-c3a3-43dc-b533-47e7ace906a2', function (hasEnoughMoney)
                        if hasEnoughMoney then

                          IsInShopMenu = false

                          menu3.close()
                          menu2.close()
                          menu.close()

                          DeleteShopInsideVehicles()

                          ESX.Game.SpawnVehicleClient(vehicleData.model, Config.Zones.ShopOutside.Pos, Config.Zones.ShopOutside.Heading, function (vehicle)

                            TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

                            local newPlate     = GeneratePlate()
                            local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                            vehicleProps.plate = newPlate
                            SetVehicleNumberPlateText(vehicle, newPlate)
							SetEntityAsMissionEntity(vehicle,true,true)
                            TriggerServerEvent('dff3e3e9-ce94-4e02-a7c1-038f523cd2a9', playerData.job.name, vehicleProps)

                            ESX.ShowNotification(_U('vehicle_purchased'))

                          end)

                          FreezeEntityPosition(playerPed, false)
                          SetEntityVisible(playerPed, true)
                        else
                          ESX.ShowNotification(_U('broke_company'))
                        end
                      end, playerData.job.name, vehicleData.model)
                    end
                  end,
                  function (data3, menu3)
                    menu3.close()
                  end
                )
              else
                ESX.TriggerServerCallback('67367413-abcb-43dd-a822-d62d34b21ed6', function (hasEnoughMoney)
                  if hasEnoughMoney then

                    IsInShopMenu = false

                    menu2.close()
                    menu.close()

                    DeleteShopInsideVehicles()

                    ESX.Game.SpawnVehicleClient(vehicleData.model, Config.Zones.ShopOutside.Pos, Config.Zones.ShopOutside.Heading, function (vehicle)

                      TaskWarpPedIntoVehicle(playerPed, vehicle, -1)

                      local newPlate     = GeneratePlate()
                      local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
                      vehicleProps.plate = newPlate
                      SetVehicleNumberPlateText(vehicle, newPlate)

							SetEntityAsMissionEntity(vehicle,true,true)
					  		local model = GetEntityModel(vehicle)
							local vehname = GetLabelText(GetDisplayNameFromVehicleModel(vehicleData.model))
							local primary, secondary = cGetVehicleColours(vehicle)
							if primary == nil then
								primary = "Unknown"
							end
							Citizen.Trace('Test')
							Citizen.Trace(model)
							Citizen.Trace(vehname)
							Citizen.Trace(primary)
                            if Config.EnableOwnedVehicles then
                              TriggerServerEvent('3074e980-4cc8-4882-838a-659e0f634631', vehicleProps, vehname, primary)
                            end

       
                      ESX.ShowNotification(_U('vehicle_purchased'))
                    end)

                    FreezeEntityPosition(playerPed, false)
                    SetEntityVisible(playerPed, true)
                  else
                    ESX.ShowNotification(_U('not_enough_money'))
                  end
                end, vehicleData.model)
              end
            end
          end

		   if data2.current.value == 'steal' then
			
					if attemptcount > limitattemptcount then
						ESX.ShowNotification("Sorry the Manager has trespassed you off the property for a while. The cops have been called.")
						return
					end
					
					attemptcount = attemptcount + 1
				
					print('Car Dealer Steal Car')
					local sex = "unknown"
					IsInShopMenu = false

                        
                          menu2.close()
                          menu.close()
						  
                         DeleteShopInsideVehicles()
							  
							local theftchance = 10
							
							if vehicleData.price < 45000 then
								theftchance = 10
							elseif vehicleData.price < 60000 then
								theftchance = 15
							elseif vehicleData.price < 80000 then
								theftchance = 28
							elseif vehicleData.price < 100000 then
								theftchance = 30	
							else
								theftchance = 45	
							end
							
							local theft = math.random(0,theftchance)
							
							if theft ~= 6 then
								if vehicleData.price <= 60000 then
									ESX.ShowNotification('You must roll a 6, you rolled: ' .. tostring(theft))
									ESX.ShowNotification("Manager snatched the keys back off you.")
									return
								end
							end
									
            
						   ESX.TriggerServerCallback('4568d939-3661-4833-ae6a-378432ac6ff1', function(skin, jobSkin)

								if skin.sex == 0 then
									sex = "male"
								else
									sex = "female"
								end
								
								ESX.ShowNotification('You must roll a 6, you rolled: ' .. tostring(theft))
								if theft ~= 6 then
									if vehicleData.price > 90000 then
										local plyPos = GetEntityCoords(GetPlayerPed(-1),  true)
										TriggerServerEvent('2637ec08-ad1d-4523-b480-68cda5128be7', plyPos.x, plyPos.y, plyPos.z)
										TriggerServerEvent('e5d0d2cd-4b53-40de-ab12-126781bfeea6', " City Car Dealer ", " attempt only ", sex)
									end 
									ESX.ShowNotification("Manager snatched the keys back off you.")
									return
								else
						                ESX.Game.SpawnVehicleClient(vehicleData.model, Config.Zones.ShopOutside.Pos, Config.Zones.ShopOutside.Heading, function (vehicle)

											TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
											SetEntityAsMissionEntity(vehicle,true,true)
											local newPlate     = GeneratePlate()
											local vehicleProps = ESX.Game.GetVehicleProperties(vehicle)
											vehicleProps.plate = newPlate
											SetVehicleNumberPlateText(vehicle, '')
											local model = GetEntityModel(vehicle)
											local vehname = GetLabelText(GetDisplayNameFromVehicleModel(model))
											local primary, secondary = cGetVehicleColours(vehicle)
											if primary == nil then
												primary = "unknown"
											end
									
									
												TriggerServerEvent('67cc61df-e6be-41d8-9bec-023459661970', tostring(GetPlayerServerId(PlayerId())), 'CarDlrMgrCity - Stolen Car Make: ' .. vehname .. ' Colour: ' .. primary .. ' by ' .. sex, "" ,  1224.45, 2724.9, 36.7 , 'police', '000', true)
												ESX.ShowNotification("You've just stolen a car! What are you thinking??")
										end)
							
									
								end
							end)
						
					
                         
							FreezeEntityPosition(playerPed, false)
							SetEntityVisible(playerPed, true)
						

                       
					
			
		    end
          if data2.current.value == 'no' then

          end

        end,
        function (data2, menu2)
          menu2.close()
        end
      )

    end,
    function (data, menu)

      menu.close()

      DeleteShopInsideVehicles()

      local playerPed = PlayerPedId()

      CurrentAction     = 'shop_menu'
      CurrentActionMsg  = _U('shop_menu')
      CurrentActionData = {}

      FreezeEntityPosition(playerPed, false)
      SetEntityVisible(playerPed, true)
      SetEntityCoords(playerPed, Config.Zones.ShopEntering.Pos.x, Config.Zones.ShopEntering.Pos.y, Config.Zones.ShopEntering.Pos.z)

      IsInShopMenu = false

    end,
    function (data, menu)
      local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]
      local playerPed   = PlayerPedId()
	Citizen.Trace('Bull1')
      DeleteShopInsideVehicles()

      ESX.Game.SpawnLocalVehicle(vehicleData.model, Config.Zones.ShopInside.Pos, Config.Zones.ShopInside.Heading, function (vehicle)
        table.insert(LastVehicles, vehicle)
		SetVehicleNumberPlateText(vehicle,"CARDEALR")
        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
        FreezeEntityPosition(vehicle, true)
      end)
    end
  )

  DeleteShopInsideVehicles()
	Citizen.Trace('Bull2')
  ESX.Game.SpawnLocalVehicle(firstVehicleData.model, Config.Zones.ShopInside.Pos, Config.Zones.ShopInside.Heading, function (vehicle)
    table.insert(LastVehicles, vehicle)
	SetVehicleNumberPlateText(vehicle,"CARDEALR")
    TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
    FreezeEntityPosition(vehicle, true)
  end)
	Citizen.CreateThread(function ()
	print(collectgarbage("collect"))
	Wait(20000)
	print(collectgarbage("collect"))
	end)
end

function OpenResellerMenu ()

  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'reseller',
    {
      title    = _U('car_dealer'),
      align    = 'top-right',
      elements = {
        {label = _U('buy_vehicle'),                    value = 'buy_vehicle'},
        {label = _U('pop_vehicle'),                    value = 'pop_vehicle'},
        {label = _U('depop_vehicle'),                  value = 'depop_vehicle'},
        {label = _U('return_provider'),                value = 'return_provider'},
        {label = _U('create_bill'),                    value = 'create_bill'},
        {label = _U('get_rented_vehicles'),            value = 'get_rented_vehicles'},
        {label = _U('set_vehicle_owner_sell'),         value = 'set_vehicle_owner_sell'},
        {label = _U('set_vehicle_owner_rent'),         value = 'set_vehicle_owner_rent'},
        {label = _U('set_vehicle_owner_sell_society'), value = 'set_vehicle_owner_sell_society'},
        {label = _U('deposit_stock'),                  value = 'put_stock'},
        {label = _U('take_stock'),                     value = 'get_stock'},
      }
    },
    function (data, menu)
      local action = data.current.value

      if action == 'buy_vehicle' then
        OpenShopMenu()
      elseif action == 'put_stock' then
        OpenPutStocksMenu()
      elseif action == 'get_stock' then
        OpenGetStocksMenu()
      elseif action == 'pop_vehicle' then
        OpenPopVehicleMenu()
      elseif action == 'depop_vehicle' then
        DeleteShopInsideVehicles()
      elseif action == 'return_provider' then
        ReturnVehicleProvider()
      elseif action == 'create_bill' then
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
        if closestPlayer == -1 or closestDistance > 3.0 then
          ESX.ShowNotification(_U('no_players'))
          return
        end
        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'set_vehicle_owner_sell_amount',
          {
            title = _U('invoice_amount'),
          },
          function (data2, menu)

            local amount = tonumber(data2.value)

            if amount == nil then
              ESX.ShowNotification(_U('invoice_amount'))
            else
              menu.close()

              local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

              if closestPlayer == -1 or closestDistance > 3.0 then
                ESX.ShowNotification(_U('no_players'))
              else
                TriggerServerEvent('c9ac0436-8b83-467d-abe5-4978cdf78f9b', GetPlayerServerId(closestPlayer), 'society_cardealer', _U('car_dealer'), tonumber(data2.value))
              end
            end
          end,
          function (data2, menu)
            menu.close()
          end
        )
      elseif action == 'get_rented_vehicles' then
        OpenRentedVehiclesMenu()
      elseif action == 'set_vehicle_owner_sell' then
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

        if closestPlayer == -1 or closestDistance > 3.0 then
          ESX.ShowNotification(_U('no_players'))
        else
          
          local newPlate     = GeneratePlate()
          local vehicleProps = ESX.Game.GetVehicleProperties(LastVehicles[#LastVehicles])
          local model        = CurrentVehicleData.model
          vehicleProps.plate = newPlate
          SetVehicleNumberPlateText(LastVehicles[#LastVehicles], newPlate)
			local vehname = GetLabelText(GetDisplayNameFromVehicleModel(model))
			local primary, secondary = cGetVehicleColours(LastVehicles[#LastVehicles])

          TriggerServerEvent('3f52a280-a088-4332-881d-be7aaf0be752', model)

          if Config.EnableOwnedVehicles then
            TriggerServerEvent('72a99e82-5ab1-476a-bc1a-bf68a3f2f58b', GetPlayerServerId(closestPlayer), vehicleProps,vehname, primary)
            ESX.ShowNotification(_U('vehicle_set_owned', vehicleProps.plate, GetPlayerName(closestPlayer)))
          else
            ESX.ShowNotification(_U('vehicle_sold_to', vehicleProps.plate, GetPlayerName(closestPlayer)))
          end
        end
      elseif action == 'set_vehicle_owner_sell_society' then
        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

        if closestPlayer == -1 or closestDistance > 3.0 then
          ESX.ShowNotification(_U('no_players'))
        else
          ESX.TriggerServerCallback('51d8bbd2-80ed-4c38-9e84-321449b2847c', function (xPlayer)
            local newPlate     = GeneratePlate()
            local vehicleProps = ESX.Game.GetVehicleProperties(LastVehicles[#LastVehicles])
            local model        = CurrentVehicleData.model
            vehicleProps.plate = newPlate
            SetVehicleNumberPlateText(LastVehicles[#LastVehicles], newPlate)
  
            TriggerServerEvent('3f52a280-a088-4332-881d-be7aaf0be752', model)

            if Config.EnableSocietyOwnedVehicles then
              TriggerServerEvent('dff3e3e9-ce94-4e02-a7c1-038f523cd2a9', xPlayer.job.name, vehicleProps)
              ESX.ShowNotification(_U('vehicle_set_owned', vehicleProps.plate, GetPlayerName(closestPlayer)))
            else
              ESX.ShowNotification(_U('vehicle_sold_to', vehicleProps.plate, GetPlayerName(closestPlayer)))
            end
          end, GetPlayerServerId(closestPlayer))
        end
     elseif action == 'set_vehicle_owner_rent' then
        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'set_vehicle_owner_rent_amount',
          {
            title = _U('rental_amount'),
          },
          function (data2, menu)
            local amount = tonumber(data2.value)

            if amount == nil then
              ESX.ShowNotification(_U('invalid_amount'))
            else
              menu.close()

              local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

              if closestPlayer == -1 or closestDistance > 5.0 then
                ESX.ShowNotification(_U('no_players'))
              else
                
                local newPlate     = 'RENT' .. string.upper(ESX.GetRandomString(4))
                local vehicleProps = ESX.Game.GetVehicleProperties(LastVehicles[#LastVehicles])
                local model        = CurrentVehicleData.model
                vehicleProps.plate = newPlate
                SetVehicleNumberPlateText(LastVehicles[#LastVehicles], newPlate)

                TriggerServerEvent('a0412910-5b0f-4934-8b67-3c2cb2fc157e', model, vehicleProps.plate, GetPlayerName(closestPlayer), CurrentVehicleData.price, amount, GetPlayerServerId(closestPlayer))

                if Config.EnableOwnedVehicles then
                  TriggerServerEvent('72a99e82-5ab1-476a-bc1a-bf68a3f2f58b', GetPlayerServerId(closestPlayer), vehicleProps)
                end

                ESX.ShowNotification(_U('vehicle_set_rented', vehicleProps.plate, GetPlayerName(closestPlayer)))

                TriggerServerEvent('88ec4b25-3ae6-4562-949a-fedcf83c3cdb', vehicleProps, Config.Zones.ShopInside.Pos.x, Config.Zones.ShopInside.Pos.y, Config.Zones.ShopInside.Pos.z, 5.0)
              end
            end
          end,
          function (data2, menu)
            menu.close()
          end
        )
      end
    end,
    function (data, menu)
      menu.close()

      CurrentAction     = 'reseller_menu'
      CurrentActionMsg  = _U('shop_menu')
      CurrentActionData = {}
    end
  )

end

function GetPlayers()
    local players = {}


		for i,player in ipairs(GetActivePlayers()) do
			table.insert(players, player)
			Wait(30)
		end

    return players
end

function OpenPersonnalVehicleMenu()

  ESX.UI.Menu.CloseAll()

  ESX.TriggerServerCallback('b8900e7e-4825-448c-8c78-af3db8b44be0', function (vehicles)
    local elements = {}

    for i=1, #vehicles, 1 do
      for j=1, #Vehicles, 1 do
        if vehicles[i].model == GetHashKey(Vehicles[j].model) then
          vehicles[i].name = Vehicles[j].name
        end
      end
    end

    for i=1, #vehicles, 1 do
      table.insert(elements, {label = vehicles[i].name .. ' [<span style="color: orange;">' .. vehicles[i].plate .. '</span>]', value = vehicles[i]})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'personnal_vehicle',
      {
        title    = _U('personal_vehicle'),
        align    = 'top-right',
        elements = elements,
      },
      function (data, menu)
        local playerPed   = PlayerPedId()
        local coords      = GetEntityCoords(playerPed)
        local heading     = GetEntityHeading(playerPed)
        local vehicleData = data.current.value

        menu.close()
		local players = GetPlayers()

	
				
		local pedusing = false
		for index,value in ipairs(players) do
			local target = GetPlayerPed(value)
			car = GetVehiclePedIsUsing(target)
			if vehicle == car then
				pedusing = true
			end
		end
		
		if pedusing then
			ESX.ShowNotification('You cannot claim insurance on this vehicle yet as its in ~r~use.')
			
			ESX.ShowNotification('If it has been ~r~stolen ~w~call Police and make them aware.')
		
		else
			ESX.Game.SpawnVehicleClient(vehicleData.model, {
				x = coords.x,
				y = coords.y,
				z = coords.z
			  }, heading, function (vehicle)
			  ESX.Game.SetVehicleProperties(vehicle, vehicleData)
			  TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
			  SetEntityAsMissionEntity(vehicle,true,true)
			  
			  Wait(100)
			  print('plate spawn: ' .. vehicleData.plate)
			  local platep = tostring(vehicleData.plate)
			  TriggerEvent('6e50bab1-3501-471a-9782-c68e8214c3e1',platep)
			  ESX.ShowNotification('You have paid insurance excess of $500')
			  --xPlayer.removeBank('500')
			end)
		end
		
      end,
      function (data, menu)
        menu.close()
      end
    )
  end)
end

function OpenPopVehicleMenu ()
	ESX.TriggerServerCallback('d2bdaa6c-8b1b-49b6-9952-512a9ddf285f', function (vehicles)
		local elements = {}

		for i=1, #vehicles, 1 do
			table.insert(elements, {
				label = vehicles[i].name .. ' [MSRP <span style="color: green;">$' .. vehicles[i].price .. '</span>]',
				value = vehicles[i].name
			})
		end

		ESX.UI.Menu.Open('default', GetCurrentResourceName(), 'commercial_vehicles',
		{
			title    = _U('vehicle_dealer'),
			align    = 'top-right',
			elements = elements
		}, function (data, menu)
			local model = data.current.value

			DeleteShopInsideVehicles()

			ESX.Game.SpawnVehicleClient(model, Config.Zones.ShopInside.Pos, Config.Zones.ShopInside.Heading, function (vehicle)
				table.insert(LastVehicles, vehicle)

				for i=1, #Vehicles, 1 do
					if model == Vehicles[i].model then
						CurrentVehicleData = Vehicles[i]
					end
				end
			end)

		end, function (data, menu)
			menu.close()
		end)
	end)
end

function OpenRentedVehiclesMenu ()
  ESX.TriggerServerCallback('60e1e607-b908-4796-9792-a5a5abfffb77', function (vehicles)
    local elements = {}

    for i=1, #vehicles, 1 do
      table.insert(elements, {label = vehicles[i].playerName .. ' : ' .. vehicles[i].name .. ' - ' .. vehicles[i].plate, value = vehicles[i].name})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'rented_vehicles',
      {
        title    = _U('rent_vehicle'),
        align    = 'top-right',
        elements = elements
      },
      nil,
      function (data, menu)
        menu.close()
      end
    )
  end)
end

function OpenBossActionsMenu ()
  ESX.UI.Menu.CloseAll()

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'reseller',
    {
      title    = _U('dealer_boss'),
      align    = 'top-right',
      elements = {
        {label = _U('boss_actions'),   value = 'boss_actions'},
      },
    },
    function (data, menu)
      if data.current.value == 'boss_actions' then
        TriggerEvent('9878e951-0ff0-4996-be7e-f0eb7c427247', 'cardealer', function(data, menu)
          menu.close()
        end)
      end
    end,
    function (data, menu)
      menu.close()

      CurrentAction     = 'boss_actions_menu'
      CurrentActionMsg  = _U('shop_menu')
      CurrentActionData = {}
    end
  )
end


function OpenGetStocksMenu ()
  ESX.TriggerServerCallback('a6a58d45-8447-4792-ba0d-ba86bdb0983c', function (items)
    local elements = {}

    for i=1, #items, 1 do
      table.insert(elements, {label = 'x' .. items[i].count .. ' ' .. items[i].label, value = items[i].name})
    end

    ESX.UI.Menu.Open(
      'default', GetCurrentResourceName(), 'stocks_menu',
      {
        title    = _U('dealership_stock'),
        align    = 'top-right',
        elements = elements
      },
      function (data, menu)
        local itemName = data.current.value

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'stocks_menu_get_item_count',
          {
            title = _U('amount'),
          },
          function (data2, menu2)
            local count = tonumber(data2.value)

            if count == nil then
              ESX.ShowNotification(_U('quantity_invalid'))
            else
              TriggerServerEvent('b39771c5-96f5-40db-a42d-7900e7a3b9b3', itemName, count)
              menu2.close()
              menu.close()
              OpenGetStocksMenu()

              
            end
          end,
          function (data2, menu2)
            menu2.close()
          end
        )
      end,
      function (data, menu)
        menu.close()
      end
    )
  end)
end

function OpenPutStocksMenu ()
  ESX.TriggerServerCallback('0d2c57d2-9cb9-4a53-8f13-7998fdf52510', function (inventory)
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
      function (data, menu)
        local itemName = data.current.value

        ESX.UI.Menu.Open(
          'dialog', GetCurrentResourceName(), 'stocks_menu_put_item_count',
          {
            title = _U('amount'),
          },
          function (data2, menu2)
            local count = tonumber(data2.value)

            if count == nil then
              ESX.ShowNotification(_U('quantity_invalid'))
            else
              TriggerServerEvent('0a7d99fe-e08d-40f7-84bb-70b857b39019', itemName, count)
              menu2.close()
              menu.close()
              OpenPutStocksMenu()
            end

          end,
          function (data2, menu2)
            menu2.close()
          end
        )
      end,
      function (data, menu)
        menu.close()
      end
    )
  end)
end

RegisterNetEvent('3038e7d6-cfde-4086-9da9-383f7b30903d')
AddEventHandler('3038e7d6-cfde-4086-9da9-383f7b30903d', function (job)
	ESX.PlayerData.job = job

	if Config.EnablePlayerManagement then
		if ESX.PlayerData.job.name == 'cardealer' then
			Config.Zones.ShopEntering.Type = 1

			if ESX.PlayerData.job.grade_name == 'boss' then
				Config.Zones.BossActions.Type = 1
			end

		else
			Config.Zones.ShopEntering.Type = -1
			Config.Zones.BossActions.Type  = -1
		end
	end
end)

RegisterNetEvent('e624aa84-5e86-48f7-a8bf-243da86275c4')
AddEventHandler('e624aa84-5e86-48f7-a8bf-243da86275c4', function ()
  OpenPersonnalVehicleMenu()
end)

AddEventHandler('592e40d6-c84c-4ee2-9843-92d6792923c7', function (zone)
  if zone == 'ShopEntering' then
    if Config.EnablePlayerManagement then
      if ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'cardealer' then
        CurrentAction     = 'reseller_menu'
        CurrentActionMsg  = _U('shop_menu')
        CurrentActionData = {}
      end
	  
	  
    else
      CurrentAction     = 'shop_menu'
      CurrentActionMsg  = _U('shop_menu')
      CurrentActionData = {}
    end
  end
  
   if zone == 'GoDownFrom' then
    CurrentAction     = 'go_down_from'
    CurrentActionMsg  = 'Press ~b~E~w~ To go down'
    CurrentActionData = {}
  end

  if zone == 'GoUpFrom' then
    CurrentAction     = 'go_up_from'
    CurrentActionMsg  = 'Press ~b~E~w~ To go up'
    CurrentActionData = {}
  end
  
  
    if zone == 'ShopBrowsing' then
      CurrentAction     = 'shop_browsing'
      CurrentActionMsg  = 'Browse the Car Catalogue'
      CurrentActionData = {}
	end

  if zone == 'GiveBackVehicle' and Config.EnablePlayerManagement then
    local playerPed = PlayerPedId()

    if IsPedInAnyVehicle(playerPed, false) then
      local vehicle = GetVehiclePedIsIn(playerPed, false)

      CurrentAction     = 'give_back_vehicle'
      CurrentActionMsg  = _U('vehicle_menu')

      CurrentActionData = {
        vehicle = vehicle
      }
	  
    end

  end

  if zone == 'ResellVehicle' then
    local playerPed = PlayerPedId()

    if IsPedInAnyVehicle(playerPed, false) then
      local vehicle     = GetVehiclePedIsIn(playerPed, false)
      local vehicleData = nil

      for i=1, #Vehicles, 1 do
        if GetHashKey(Vehicles[i].model) == GetEntityModel(vehicle) then
          vehicleData = Vehicles[i]
          break
        end
      end

      local resellPrice = math.floor(vehicleData.price / 100 * Config.ResellPercentage)

      CurrentAction     = 'resell_vehicle'
      CurrentActionMsg  = _U('sell_menu', vehicleData.name, resellPrice)

      CurrentActionData = {
        vehicle = vehicle,
        price   = resellPrice
      }
    end
  end

  if zone == 'BossActions' and Config.EnablePlayerManagement and ESX.PlayerData.job ~= nil and ESX.PlayerData.job.name == 'cardealer' and ESX.PlayerData.job.grade_name == 'boss' then
    CurrentAction     = 'boss_actions_menu'
    CurrentActionMsg  = _U('shop_menu')
    CurrentActionData = {}
  end
end)

AddEventHandler('5f399a22-1d87-45ca-8a15-f5c06c0f0992', function (zone)
	if not IsInShopMenu then
		ESX.UI.Menu.CloseAll()
	end

	CurrentAction = nil
end)

if Config.EnablePlayerManagement then
	RegisterNetEvent('59809f17-d8ce-49dd-ae30-d5e90a7761a7')
	AddEventHandler('59809f17-d8ce-49dd-ae30-d5e90a7761a7', function (phoneNumber, contacts)
		local specialContact = {
			name       = _U('dealership'),
			number     = 'cardealer',
			base64Icon = 'data:image/x-icon;base64,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'
		}

		TriggerEvent('e25977c9-9f2b-4d5d-a807-a8c7a0c964d5', specialContact.name, specialContact.number, specialContact.base64Icon)
	end)
end

-- Create Blips
Citizen.CreateThread(function ()
	local blip = AddBlipForCoord(Config.Zones.ShopEntering.Pos.x, Config.Zones.ShopEntering.Pos.y, Config.Zones.ShopEntering.Pos.z)

	SetBlipSprite (blip, 326)
	SetBlipDisplay(blip, 4)
	SetBlipScale  (blip, 1.0)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName("STRING")
	AddTextComponentString(_U('car_dealer'))
	EndTextCommandSetBlipName(blip)
end)

-- Display markers
Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)
		local closerc = false
		local coords = GetEntityCoords(PlayerPedId())

		for k,v in pairs(Config.Zones) do
			if(v.Type ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < Config.DrawDistance) then
				closerc = true
				DrawMarker(v.Type, v.Pos.x, v.Pos.y, v.Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, v.Size.x, v.Size.y, v.Size.z, Config.MarkerColor.r, Config.MarkerColor.g, Config.MarkerColor.b, 100, false, true, 2, false, false, false, false)
			end
		end
		if closerc == false then
			closer = false
			Wait(2000)
		else
		
			closer = true
		end
	end
end)

-- Enter / Exit marker events
Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(0)

		if closer then
			local coords      = GetEntityCoords(PlayerPedId())
			local isInMarker  = false
			local currentZone = nil
			
			
			
			for k,v in pairs(Config.Zones) do
				if(GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < v.Size.x) then
					isInMarker  = true
					currentZone = k
				end
				Wait(100)
			end

			if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
				HasAlreadyEnteredMarker = true
				LastZone                = currentZone
				TriggerEvent('592e40d6-c84c-4ee2-9843-92d6792923c7', currentZone)
			end

			if not isInMarker and HasAlreadyEnteredMarker then
				HasAlreadyEnteredMarker = false
				TriggerEvent('5f399a22-1d87-45ca-8a15-f5c06c0f0992', LastZone)
			end
	
  
		else
			Wait(2500)
		end
	end
end)

-- Key controls
Citizen.CreateThread(function ()
	while true do
		Citizen.Wait(10)

		if closer then
			if CurrentAction == nil then
				Citizen.Wait(200)
			else
                  
				  
				ESX.ShowHelpNotification(CurrentActionMsg)

				if IsControlJustReleased(0, Keys['E']) then
					if CurrentAction == 'shop_menu' then
						OpenShopMenu()
					elseif CurrentAction == 'reseller_menu' then
						OpenResellerMenu()
					elseif CurrentAction == "shop_browsing" then
						OpenBrowseMenu()
					elseif CurrentAction == 'give_back_vehicle' then
					 
						ESX.TriggerServerCallback('cfce5b52-79e4-4a43-bb57-eadd0f3a0cab', function (isRentedVehicle)
							if isRentedVehicle then
								ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
								ESX.ShowNotification(_U('delivered'))
							else
								ESX.ShowNotification(_U('not_rental'))
							end
						end, GetVehicleNumberPlateText(CurrentActionData.vehicle))
					elseif CurrentAction == 'resell_vehicle' then
							print('entity model')
							print(GetEntityModel(CurrentActionData.vehicle))
						ESX.TriggerServerCallback('6a5a1213-4d5a-4477-a21c-b94f531d04da', function (isOwnedVehicle)
							if isOwnedVehicle then
								soldcount = soldcount + 1
								ESX.Game.DeleteVehicle(CurrentActionData.vehicle)
								ESX.ShowNotification(_U('vehicle_sold'))
							else
								ESX.ShowNotification(_U('not_yours'))
							end
							print('entity model')
							print(GetEntityModel(CurrentActionData.vehicle))
						end, GetVehicleNumberPlateText(CurrentActionData.vehicle), CurrentActionData.price, GetEntityModel(CurrentActionData.vehicle))
					elseif CurrentAction == 'boss_actions_menu' then
						OpenBossActionsMenu()
					end
					
					 if CurrentAction == 'go_down_from' then
            local playerPed = GetPlayerPed(-1)
            DoScreenFadeOut(1000)
            Wait(1000)
            DoScreenFadeIn(1000)
            SetEntityCoords(playerPed, Config.Zones.GoUpFrom.Pos.x, Config.Zones.GoUpFrom.Pos.y, Config.Zones.GoUpFrom.Pos.z)
        end

        if CurrentAction == 'go_up_from' then
            local playerPed = GetPlayerPed(-1)
            DoScreenFadeOut(1000)
            Wait(1000)
            DoScreenFadeIn(1000)
            SetEntityCoords(playerPed, Config.Zones.GoDownFrom.Pos.x, Config.Zones.GoDownFrom.Pos.y, Config.Zones.GoDownFrom.Pos.z)
        end

					CurrentAction = nil
				end
			end
		else
			Wait(2500)
		end
	end
end)


function cGetVehicleColours(cvehicle)
	if GetIsVehiclePrimaryColourCustom(cvehicle) then  
		return "Custom","Custom"
	elseif GetIsVehicleSecondaryColourCustom(cvehicle) then
		local primary, secondary = cGetVehicleColours(cvehicle)
		primary = colorNames[tostring(primary)]
		--Citizen.Trace('Primary Color Reg: ' .. primary)
		return primary, "Custom"
		
	else
	
		local primary, secondary = GetVehicleColours(cvehicle)
		if primary == nil then
			primary = "unknown"
			secondary = "unknown"
		elseif secondary == nil then
			primary = colorNames[tostring(primary)]
			secondary = nil
		else
			primary = colorNames[tostring(primary)]
			secondary = colorNames[tostring(secondary)]
		end
		--Citizen.Trace('Primary Color Reg: ' .. primary)
		return primary, secondary
	end

end

-- Load IPLS
Citizen.CreateThread(function ()
	RemoveIpl('v_carshowroom')
	RemoveIpl('shutter_open')
	RemoveIpl('shutter_closed')
	RemoveIpl('shr_int')
	RemoveIpl('csr_inMission')
	RequestIpl('v_carshowroom')
	RequestIpl('shr_int')
	RequestIpl('shutter_closed')
end)




function OpenBrowseMenu()
  IsInShopMenu = true

  ESX.UI.Menu.CloseAll()

  local playerPed = PlayerPedId()

  FreezeEntityPosition(playerPed, true)
  SetEntityVisible(playerPed, false)
  SetEntityCoords(playerPed, Config.Zones.ShopBrowsingInside.Pos.x, Config.Zones.ShopBrowsingInside.Pos.y, Config.Zones.ShopBrowsingInside.Pos.z)

  local vehiclesByCategory = {}
  local elements           = {}
  local firstVehicleData   = nil

  for i=1, #Categories, 1 do
    vehiclesByCategory[Categories[i].name] = {}
  end

  for i=1, #Vehicles, 1 do
    table.insert(vehiclesByCategory[Vehicles[i].category], Vehicles[i])
  end

  for i=1, #Categories, 1 do
    local category         = Categories[i]
    local categoryVehicles = vehiclesByCategory[category.name]
    local options          = {}

    for j=1, #categoryVehicles, 1 do
      local vehicle = categoryVehicles[j]

      if i == 1 and j == 1 then
        firstVehicleData = vehicle
      end
	  
	  local vehprice =  vehicle.price
	  if readonly then
		vehprice = ''
	  end
	  

      table.insert(options, vehicle.name .. ' <span style="color: green;"> SALE ON NOW! </span>')
    end
	
	print('running')

    table.insert(elements, {
      name    = category.name,
      label   = category.label,
      value   = 0,
      type    = 'slider',
      max     = #Categories[i],
      options = options
    })
  end

  ESX.UI.Menu.Open(
    'default', GetCurrentResourceName(), 'vehicle_shop',
    {
      title    = _U('car_dealer'),
      align    = 'top-right',
      elements = elements
    },
    function (data, menu)
      local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]

    

    end,
    function (data, menu)

      menu.close()

      DeleteShopInsideVehicles()

      local playerPed = PlayerPedId()

      CurrentAction     = 'shop_browsing'
      CurrentActionMsg  = _U('shop_menu')
      CurrentActionData = {}

      FreezeEntityPosition(playerPed, false)
      SetEntityVisible(playerPed, true)
      SetEntityCoords(playerPed, Config.Zones.ShopBrowsingInside.Pos.x, Config.Zones.ShopBrowsingInside.Pos.y, Config.Zones.ShopBrowsingInside.Pos.z)

      IsInShopMenu = false

    end,
    function (data, menu)
      local vehicleData = vehiclesByCategory[data.current.name][data.current.value + 1]
      local playerPed   = PlayerPedId()
	Citizen.Trace('Bull1')
      DeleteShopInsideVehicles()

      ESX.Game.SpawnLocalVehicle(vehicleData.model, Config.Zones.ShopBrowsingInside.Pos, Config.Zones.ShopBrowsingInside.Heading, function (vehicle)
        table.insert(LastVehicles, vehicle)
		SetVehicleNumberPlateText(vehicle,"CARDEALR")
        TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
        FreezeEntityPosition(vehicle, true)
      end)
    end
  )

  DeleteShopInsideVehicles()
	Citizen.Trace('Bull2')
  ESX.Game.SpawnLocalVehicle(firstVehicleData.model, Config.Zones.ShopBrowsingInside.Pos, Config.Zones.ShopBrowsingInside.Heading, function (vehicle)
    table.insert(LastVehicles, vehicle)
	SetVehicleNumberPlateText(vehicle,"CARDEALR")
    TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
    FreezeEntityPosition(vehicle, true)
  end)

end



--keycontrols





