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
ESX 			    			= nil
local showblip = false
local displayedBlips = {}
local AllBlips = {}
local AllShopBlips = {}
local number = nil
local Shop = {}

local Zones = {}

local isclose = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(0)
		
	end
	Citizen.Wait(5000)
	print('call shops list')
	ESX.TriggerServerCallback('6242b2ee-91e9-4cb0-ae86-89eef4205d5d', function(data)
		Shop = data
		--createShopBlip()

		
	end)
end)


AddEventHandler('onResourceStop', function(resource)
	  if resource == GetCurrentResourceName() then
		  SetNuiFocus(false, false)
	  end
end)
  
RegisterNUICallback('escape', function(data, cb)
	 
	  SetNuiFocus(false, false)
  
	  SendNUIMessage({
		  type = "close",
	  })
end)

RegisterNUICallback('bossactions', function(data, cb)
	 
	SetNuiFocus(false, false)

	SendNUIMessage({
		type = "close",
	})

	OpenBoss(number)
end)

local Cart = {}

RegisterNUICallback('putcart', function(data, cb)
	table.insert(Cart, {item = data.item, label = data.label, count = data.count, id = data.id, price = data.price})
	cb(Cart)
end)

RegisterNUICallback('notify', function(data, cb)
	ESX.ShowNotification(data.msg)
end)

RegisterNUICallback('refresh', function(data, cb)
	 
	Cart = {}

		ESX.TriggerServerCallback('ffb3f153-c567-45f1-99ec-45475e440a06', function(data)
			ESX.TriggerServerCallback('136a6b72-6f07-49d5-a86c-35623e8092ae', function(result)
			
					if data ~= nil then
						Owner = true
					end

					if result ~= nil then

								SetNuiFocus(true, true)
				
								SendNUIMessage({
									type = "shop",
									result = result,
									owner = Owner,
								})
					end

				end, number)
			end, number)
end)

RegisterNUICallback('emptycart', function(data, cb)
	Cart = {}
	
end)

RegisterNUICallback('buy', function(data, cb)
		print('buy')
		print(data.Item)
		print(data.Count)
		TriggerServerEvent('0dbd59ba-42a8-4a49-bbee-1f36b0bc8551', number, data.Item, data.Count)
	Cart = {}
end)

RegisterNetEvent('0f78a991-576b-4d9f-970e-243b45535488')
AddEventHandler('0f78a991-576b-4d9f-970e-243b45535488', function(xPlayer)
   PlayerData = xPlayer
end)

local ShopId           = nil
local Msg        = nil
local HasAlreadyEnteredMarker = false
local LastZone                = nil


AddEventHandler('d703a125-1cbf-479f-a4d2-ea139527fd55', function(zone)
	if zone == 'center' then
		ShopId = zone
		number = zone
		Msg  = _U('press_to_open_center')
	elseif zone <= 100 then
		ShopId = zone
		number = zone
		Msg  = _U('press_to_open')
	elseif zone >= 100 then
		ShopId = zone
		number = zone
		Msg  = _U('press_to_rob')
	end
end)

AddEventHandler('66f314d4-80fa-498c-a1be-0ad0aa254148', function(zone)
	ShopId = nil
end)

local waiting = false
local timerc = GetGameTimer()

Citizen.CreateThread(function ()
 	 while true do
		Citizen.Wait(0)
		if isclose then
			if ShopId ~= nil then

				SetTextComponentFormat('STRING')
				AddTextComponentString(Msg)
				DisplayHelpTextFromStringLabel(0, 0, 1, -1)

					if IsControlJustReleased(0, Keys['E']) and GetGameTimer() > timerc + 3000  then
						print(ShopId)
						timerc = GetGameTimer()
						
						if ShopId == 'center' then
							OpenShopCenter()
						

						elseif ShopId <= 100 then
							if waiting == false then
								waiting = true
								ESX.ShowNotification("~o~Store\n~w~We're getting the shops inventory please wait...")
								ESX.TriggerServerCallback('ffb3f153-c567-45f1-99ec-45475e440a06', function(data)
									ESX.TriggerServerCallback('136a6b72-6f07-49d5-a86c-35623e8092ae', function(result)
										
											if data ~= nil then
												Owner = true
											end
				
											if result ~= nil then

												SetNuiFocus(true, true)
									
												SendNUIMessage({
													type = "shop",
													result = result,
													owner = Owner,
												})
											end
											waiting = false
										end, number)
				
								end, number)
							elseif ShopId >= 100 then
								Robbery(number - 100)
							end
						end

					end
			end
		else
			Wait(2000)
		end
	end
 end)



function OpenShopCenter()

	ESX.UI.Menu.CloseAll()

  	local elements = {}

		if showblip then
			table.insert(elements, {label = 'Hide ALL shops on the map', value = 'removeblip'})
		else
			table.insert(elements, {label = 'Show ALL shops on the map', value = 'showblip'})
		end

			ESX.TriggerServerCallback('f25fc4ab-29f5-4881-9bf2-6cb3011e1aa8', function(data)

				for i=1, #data, 1 do
					table.insert(elements, {label = _U('buy_shop') .. data[i].ShopNumber .. ' [$' .. data[i].ShopValue .. ']', value = 'kop', price = data[i].ShopValue, shop = data[i].ShopNumber})
				end


					ESX.UI.Menu.Open(
					'default', GetCurrentResourceName(), 'shopcenter',
					{
						title    = 'Shop',
						align    = 'left',
						elements = elements
					},
					function(data, menu)

					if data.current.value == 'kop' then
					ESX.UI.Menu.CloseAll()

					ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'name', {
					title = _U('name_shop')
					}, function(data2, menu2)

					local name = data2.value
					TriggerServerEvent('610f4df6-11c8-4414-b50b-b31e73bc08e7', name, data.current.price, data.current.shop, data.current.bought)
					menu2.close()

					end,
					function(data2, menu2)
					menu2.close()
					end)

					elseif data.current.value == 'removeblip' then
						showblip = false
						createForSaleBlips()
						menu.close()
					elseif data.current.value == 'showblip' then
						showblip = true
						createForSaleBlips()
						menu.close()
					end
					end)
				end,
			function(data, menu)
		menu.close()
	end)
end

-- function OpenShop()
--   ESX.UI.Menu.CloseAll()
--   local elements = {}

  
-- 	ESX.TriggerServerCallback('ffb3f153-c567-45f1-99ec-45475e440a06', function(data)
-- 	ESX.TriggerServerCallback('136a6b72-6f07-49d5-a86c-35623e8092ae', function(result)

--         if data ~= nil then
--             table.insert(elements, {label = 'Boss Menu', value = 'boss'})
--         end

-- 	    if result ~= nil then
-- 		    for i=1, #result, 1 do
-- 		        if result[i].count > 0 then
-- 					table.insert(elements, {label = result[i].label .. ' | ' .. result[i].count ..' in your stock for [$' .. result[i].price .. ' per item]', value = 'buy', ItemName = result[i].item})
-- 				end
-- 			end
-- 		end


--   ESX.UI.Menu.Open(
--   'default', GetCurrentResourceName(), 'shops',
--   {
-- 	title    = 'Shop',
-- 	align    = 'left',
-- 	elements = elements
--   },
--   function(data, menu)
-- 	if data.current.value == 'boss' then
--         ESX.UI.Menu.CloseAll()
-- 		OpenBoss()
		
-- 	elseif data.current.value == 'buy' then
--         	ESX.UI.Menu.CloseAll()

-- 			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'mainmeny', {
-- 			title = 'How much whould you like to buy?'
-- 			}, function(data2, menu2)

--        	 	local count = tonumber(data2.value)

-- 				TriggerServerEvent('0dbd59ba-42a8-4a49-bbee-1f36b0bc8551', number, data.current.ItemName, count)
-- 				menu2.close()
	
--                     	end,
--                     	function(data2, menu2)
--                     	menu2.close()
--                 	end)
--                     end
--                 end,
--                 function(data, menu)
-- 				menu.close()
-- 			end)
-- 		end, number)
-- 	end, number)
-- end

function OpenBoss()


  ESX.TriggerServerCallback('ffb3f153-c567-45f1-99ec-45475e440a06', function(data)
  
	local elements = {}

		table.insert(elements, {label = 'You have: $' .. data[1].money .. ' in your company',    value = ''})
		table.insert(elements, {label = 'Shipments',    value = 'shipments'})
        table.insert(elements, {label = 'Put in a item for sale', value = 'putitem'})
        table.insert(elements, {label = 'Take out a item for sale',    value = 'takeitem'})
        table.insert(elements, {label = 'Put in money in your company',    value = 'putmoney'})
        table.insert(elements, {label = 'Take out money from your company',    value = 'takemoney'})
        table.insert(elements, {label = 'Change name on your company: $' .. Config.ChangeNamePrice,    value = 'changename'})
		table.insert(elements, {label = 'Sell your company for $' .. math.floor(data[1].ShopValue / Config.SellValue),   value = 'sell'})
		
		local black = data[1].Black
		
		ESX.UI.Menu.Open(
		'default', GetCurrentResourceName(), 'boss',
		{
			title    = 'Shop',
			align    = 'left',
			elements = elements
		},
		function(data, menu)
        if data.current.value == 'putitem' then
            PutItem(number)
        elseif data.current.value == 'takeitem' then  
            TakeItem(number)
        elseif data.current.value == 'takemoney' then
            

            ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'takeoutmoney', {
                title = 'How much whould you like to take out?'
            }, function(data2, menu2)
  
			local amount = tonumber(data2.value)
			
			TriggerServerEvent('86ca3671-09a8-4af6-837c-6907ee647b94', amount, number)
			
			menu2.close()
        
		end,
		function(data2, menu2)
		menu2.close()
		end)

	 	elseif data.current.value == 'putmoney' then
			ESX.UI.Menu.CloseAll()

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'putinmoney', {
			title = 'How much whould you like to put in?'
			}, function(data3, menu3)
			local amount = tonumber(data3.value)
			TriggerServerEvent('19dc39f2-3caf-4fe8-87c5-7f1a2e87e242', amount, number)
			menu3.close()
				end,
				function(data3, menu3)
			menu3.close()
		end)

		elseif data.current.value == 'sell' then
		  ESX.UI.Menu.CloseAll()    

		  ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'sell', {
			title = 'WRITE: (YES) without parentheses to confim'
          }, function(data4, menu4)
            
            if data4.value == 'YES' then
              TriggerServerEvent('e5d2281f-3273-4db0-b4d4-3b1581386a8d', number)
              menu4.close()
			end
		    	end,
		    	function(data4, menu4)
		    menu4.close()
		end)

	  elseif data.current.value == 'changename' then
		ESX.UI.Menu.CloseAll()    

		ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'changename', {
		  title = 'What whould you like to name your shop?'
        }, function(data5, menu5)
            
            TriggerServerEvent('3f7cf83f-9e5a-4cf0-9255-174184489297', number, data5.value)
            menu5.close()
               		end,
                	function(data5, menu5)
                	menu5.close()
				end)
				
			elseif data.current.value == 'shipments' then
				
				OpenShipments(number,black)

				end
        		end,
        		function(data, menu)
        	menu.close()
	    end)
    end, number)
end

function OpenShipments(id,black)

	local elements = {}

	table.insert(elements, {label = 'Order product', value = 'buy'})
	table.insert(elements, {label = 'Shipments', value = 'shipments'})

	ESX.UI.Menu.Open(
  	'default', GetCurrentResourceName(), 'shipments',
	{
		title    = 'Shop',
		align    = 'left',
		elements = elements
	},
	  function(data, menu)
		
		if data.current.value == 'buy' then
			ESX.UI.Menu.CloseAll()
			OpenShipmentDelivery(id,black)
		elseif data.current.value == 'shipments' then
			ESX.UI.Menu.CloseAll()
			GetAllShipments(id,black)

		end
		end,
	function(data, menu)
	menu.close()
	end)
end

function GetAllShipments(id,black)

	local elements = {}

	ESX.TriggerServerCallback('31d44ce4-655e-4505-a6bc-7f118aa1ee78', function(time)
	ESX.TriggerServerCallback('af5a1871-5c8b-4a44-b20e-2b16054372ce', function(items)

	local once = true
	local once2 = true
	local delivery_time = Config.DeliveryTime
		if black > 0 then
			delivery_time = Config.DirtyDeliveryTime
		end

		for i=1, #items, 1 do

			if time - items[i].time >= delivery_time and once2 then
			table.insert(elements, {label = '--READY SHIPMENTS--'})
			table.insert(elements, {label = 'Get all your shipments', value = 'pickup'})
			once2 = false
			end

			if time - items[i].time >= delivery_time then
			table.insert(elements, {label = items[i].label,	value = items[i].item, price = items[i].price})
			end
			
			if time - items[i].time <= delivery_time and once then
				table.insert(elements, {label = '--PENDING SHIPMENTS--'})
				once = false
			end

			if time - items[i].time <= delivery_time then
				times = time - items[i].time
				table.insert(elements, {label = items[i].label .. ' time left: ' .. math.floor((delivery_time - times) / 60) .. ' minutes' })
			end

		end

	ESX.UI.Menu.Open(
	'default', GetCurrentResourceName(), 'allshipments',
	{
	  title    = 'Shop',
	  align    = 'left',
	  elements = elements
	},
	  function(data, menu)
		
		if data.current.value == 'pickup' then
			TriggerServerEvent('b94d32c2-a055-4132-8733-315dc3b916ee', id)
		else
			ESX.ShowNotification('You must choose to collect ~o~all~w~ your items')
		end
	
		end,
		function(data, menu)
		menu.close()
		end)

	end, id)
	end)
end

function OpenShipmentDelivery(id, black)

	ESX.UI.Menu.CloseAll()
	local elements = {}

		for k,v in pairs(Config.Items) do
		
			if Config.Items[k] and Config.Items[k].black and Config.Items[k].black == true  and black > 0 then
				if Config.Items[k].maxamt then
					table.insert(elements, {labels =  Config.Items[k].label, label =  Config.Items[k].label .. ' for $' .. Config.Items[k].price .. ' a piece ',	value = Config.Items[k].item, price = Config.Items[k].price, maxamt = Config.Items[k].maxamt})
				else
					table.insert(elements, {labels =  Config.Items[k].label, label =  Config.Items[k].label .. ' for $' .. Config.Items[k].price .. ' a piece ',	value = Config.Items[k].item, price = Config.Items[k].price})
				end
			elseif black == 0 and Config.Items[k].black == false then
				table.insert(elements, {labels =  Config.Items[k].label, label =  Config.Items[k].label .. ' for $' .. Config.Items[k].price .. ' a piece ',	value = Config.Items[k].item, price = Config.Items[k].price})
			end
		end
		
		

		ESX.UI.Menu.Open(
			'default', GetCurrentResourceName(), 'shipitem',
			{
			title    = 'Shop',
			align    = 'left',
			elements = elements
			},
			function(data, menu)
				local maxamt = ''
				menu.close()
				if tonumber(data.current.maxamt) then
				 maxamt = ' (Max Amt: ' .. data.current.maxamt .. ')'
				end
				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'krille', {
				title = 'How much do you want to buy?' .. maxamt
				}, function(data2, menu2)
					menu2.close()
					if tonumber(data2.value) > tonumber(data.current.maxamt)  then
						ESX.ShowNotification('~r~Error~w~ Your order was too great! Try a smaller order!')
					else
						TriggerServerEvent('200f289f-5d31-4521-b6ed-996fd5bf8cbe', id, data.current.value, data.current.price, tonumber(data2.value), data.current.labels)
					end

				end, function(data2, menu2)
					menu2.close()
				end)

		end,
		function(data, menu)
		menu.close()
	end)
end


function TakeItem(number)

  local elements = {}

  ESX.TriggerServerCallback('136a6b72-6f07-49d5-a86c-35623e8092ae', function(result)

	for i=1, #result, 1 do
	    if result[i].count > 0 then
	    	table.insert(elements, {label = result[i].label .. ' | ' .. result[i].count ..' pieces in storage [' .. result[i].price .. ' $ per piece', value = 'removeitem', ItemName = result[i].item})
	    end
    end


  ESX.UI.Menu.Open(
  'default', GetCurrentResourceName(), 'takeitem',
  {
	title    = 'Shop',
	align    = 'left',
	elements = elements
  },
  function(data, menu)
local name = data.current.ItemName

    if data.current.value == 'removeitem' then
        menu.close()
        ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'howmuch', {
        title = 'How much whould you like to take out?'
        }, function(data2, menu2)

        local count = tonumber(data2.value)
		menu2.close()
    	TriggerServerEvent('8af7df11-eb91-4ff3-9511-cbdf6f10f7ac', number, count, name)
    
			end, function(data2, menu2)
				menu2.close()
			end)
			end
		end,
		function(data, menu)
		menu.close()
		end)
  	end, number)
end


function PutItem(number)

  local elements = {}

  ESX.TriggerServerCallback('946610a8-74a7-4acf-861b-bd26dc0f5c98', function(result)

    for i=1, #result.items, 1 do
        
      local invitem = result.items[i]
      
	    if invitem.count > 0 then
			table.insert(elements, { label = invitem.label .. ' | ' .. invitem.count .. ' in your bag', count = invitem.count, name = invitem.name})
	    end
	end

  ESX.UI.Menu.Open(
  'default', GetCurrentResourceName(), 'putitem',
  {
	title    = 'Shop',
	align    = 'left',
	elements = elements
  },
  function(data, menu)

        local itemName = data.current.name
        local invcount = data.current.count

			ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'sell', {
			title = _U('how_much')
			}, function(data2, menu2)

			local count = tonumber(data2.value)
		
			if count > invcount then
				ESX.ShowNotification('~r~You can\'t sell more than you own')
				menu2.close()
				menu.close()
			else
				menu2.close()
				menu.close()

				ESX.UI.Menu.Open('dialog', GetCurrentResourceName(), 'sellprice', {
				title = _U('set_price')
				}, function(data3, menu3)

				local price = tonumber(data3.value)
				menu3.close()
				TriggerServerEvent('f2067c04-9f0c-4cf1-8875-4d80042b89f6', number, itemName, count, price)
		
						end)
					end
				end,
				function(data3, menu3)
				menu3.close()
				end)
			end, 
			function(data2, menu2)
			menu2.close()
			end)
        end, function(data, menu)
        menu.close()
    end)
end


Citizen.CreateThread(function ()
  while true do
	Citizen.Wait(1)
		if isclose then
			local coords = GetEntityCoords(GetPlayerPed(-1))

			for k,v in pairs(Zones) do
				if(27 ~= -1 and GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true) < 20.0 and v.Pos.enabled ) then
					if v.Pos.red then
						--DrawMarker(23, v.Pos.x, v.Pos.y, v.Pos.z + 0.05, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.2, 180, 0, 0, 200, false, true, 2, false, false, false, false)
						--DrawMarker(29, v.Pos.x, v.Pos.y, v.Pos.z + 1.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 180, 0, 0, 200, false, true, 2, false, false, false, false)		
					elseif v.Pos.black == 1 then
						DrawMarker(23, v.Pos.x, v.Pos.y, v.Pos.z + 0.05, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.2, 0, 180, 0, 200, false, true, 2, false, false, false, false)
						DrawMarker(30, v.Pos.x, v.Pos.y, v.Pos.z + 1.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 180, 0, 200, false, true, 2, false, false, false, false)
					else
						DrawMarker(23, v.Pos.x, v.Pos.y, v.Pos.z + 0.05, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 1.0, 1.0, 0.2, 0, 180, 0, 200, false, true, 2, false, false, false, false)
						DrawMarker(29, v.Pos.x, v.Pos.y, v.Pos.z + 1.5, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 180, 0, 200, false, true, 2, false, false, false, false)
					end
				end
			end
		else
			Citizen.Wait(2000)
		end
   end
end)



Citizen.CreateThread(function ()
  while true do
	Citizen.Wait(500)

	local coords      = GetEntityCoords(GetPlayerPed(-1))
	local isInMarker  = false
	local currentZone = nil

	local zisclose = false
	
	for k,v in pairs(Zones) do
		if v.Pos.enabled then
			
			local locats = GetDistanceBetweenCoords(coords, v.Pos.x, v.Pos.y, v.Pos.z, true)
			  if(locats < 1.2) then
				zisclose = true
				isclose = true
				isInMarker  = true
				currentZone = v.Pos.number
			  elseif locats < 25 then
				zisclose = true
				isclose = true
			  end
		end
	end
	
	isclose = zisclose

	if (isInMarker and not HasAlreadyEnteredMarker) or (isInMarker and LastZone ~= currentZone) then
	  HasAlreadyEnteredMarker = true
	  LastZone                = currentZone
	  TriggerEvent('d703a125-1cbf-479f-a4d2-ea139527fd55', currentZone)
	end

	if not isInMarker and HasAlreadyEnteredMarker then
	  HasAlreadyEnteredMarker = false
	  TriggerEvent('66f314d4-80fa-498c-a1be-0ad0aa254148', LastZone)
	end
  end
end)

RegisterNetEvent('d4865562-fd59-4b02-8106-a24f0947afb6')
AddEventHandler('d4865562-fd59-4b02-8106-a24f0947afb6', function()

  	ESX.TriggerServerCallback('3a566dee-75da-4e17-a541-080ff40545d1', function(blips)
		
		if blips ~= nil then
			createBlip(blips)
	  	end
   	end)
end)

RegisterNetEvent('83c5030a-de51-4e62-8aa0-b165eda3df68')
AddEventHandler('83c5030a-de51-4e62-8aa0-b165eda3df68', function()

	for i=1, #displayedBlips do
    	RemoveBlip(displayedBlips[i])
	end

end)

AddEventHandler('880c0a93-b305-46b3-b84c-a120fee9e841', function(spawn)
	Citizen.Wait(500)

	ESX.TriggerServerCallback('3a566dee-75da-4e17-a541-080ff40545d1', function(blips)
		Zones = Config.Zones


		if blips ~= nil then
			createBlip(blips)
		end
	end)
end)



Citizen.CreateThread(function()
	Citizen.Wait(math.random(100,2500))

	ESX.TriggerServerCallback('3a566dee-75da-4e17-a541-080ff40545d1', function(blips)
		if blips ~= nil then
			createBlip(blips)
		end
	end)
end)

Citizen.CreateThread(function()
	Citizen.Wait(500)
		local blip = AddBlipForCoord(6.09, -708.89, 44.97)
		
		SetBlipSprite (blip, 605)
		SetBlipDisplay(blip, 4)
		SetBlipScale  (blip, 1.2)
		SetBlipColour (blip, 5)
		SetBlipAsShortRange(blip, true)

		BeginTextCommandSetBlipName("STRING")
		AddTextComponentString('Properties')
		EndTextCommandSetBlipName(blip)
end)

function createBlip(blips)
	
	Zones = Config.Zones

	for i=1, #blips, 1 do

	if blips[i].Enabled == 1 and  blips[i].location ~= nil and blips[i].location ~= '{}' then

			local location = json.decode(blips[i].location)

			table.insert(Zones,{ Pos = { x= location.x, y= location.y, z=location.z, number = blips[i].ShopNumber, enabled = blips[i].Enabled,visible = blips[i].Visible, Black = blips[i].Black, black = blips[i].Black}})
			
			for k,v in pairs(Zones) do
				if v.Pos.number == blips[i].ShopNumber and v.Pos.enabled == 1 and v.Pos.visible == 1 then
					
						local blip = AddBlipForCoord(vector3(v.Pos.x, v.Pos.y, v.Pos.z))
						if blips[i].black == 1 then
							SetBlipSprite (blip, 30)
							SetBlipColour (blip, 29)
						else
							SetBlipSprite (blip, 52)
							SetBlipColour (blip, 29)
						end
						SetBlipDisplay(blip, 4)
						SetBlipScale  (blip, 1.2)
						SetBlipColour (blip, 29)
						SetBlipAsShortRange(blip, true)
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString(blips[i].ShopName)
						EndTextCommandSetBlipName(blip)
						table.insert(displayedBlips, blip)
				end
			end
		end
	end
end


function createShopBlip()

	if not showblip then

		for i=1, #Shop, 1 do
			for k,v in pairs(Zones) do

				if v.Pos.number == Shop[i].ShopNumber and v.Pos.enabled then
					
					local blip = AddBlipForCoord(vector3(v.Pos.x, v.Pos.y, v.Pos.z))
						SetBlipSprite (blip, 52)
						SetBlipDisplay(blip, 4)
						SetBlipScale  (blip, 1.2)
						SetBlipColour (blip, 2)
						SetBlipAsShortRange(blip, true)
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString(Shop[i].ShopName)
						EndTextCommandSetBlipName(blip)
						table.insert(AllShopBlips, blip)
				end
			end
		end
	else
			for i=1, #AllShopBlips, 1 do
				RemoveBlip(AllShopBlips[i])
			end
			AllShopBlips = {}
	end
end



function createForSaleBlips()
	if showblip then
		createShopBlip()

		IDBLIPS = {
			[1] = {x = 373.875,   y = 325.896,  z = 102.566, n = 1},
			[2] = {x = 2557.458,  y = 382.282,  z = 107.622, n = 2},
			[3] = {x = -3038.939, y = 585.954,  z = 6.908, n = 3},
			[4] = {x = -1487.553, y = -379.107,  z = 39.163, n = 4},
			[5] = {x = 1392.562,  y = 3604.684,  z = 33.980, n = 5},
			[6] = {x = -2968.243, y = 390.910,   z = 14.043, n = 6},
			[7] = {x = 2678.916,  y = 3280.671, z = 54.241, n = 7},
			[8] = {x = -48.519,   y = -1757.514, z = 28.421, n = 8},
			[9] = {x = 1163.373,  y = -323.801,  z = 68.205, n = 9},
			[10] = {x = -707.501,  y = -914.260,  z = 18.215, n = 10},
			[11] = {x = -1820.523, y = 792.518,   z = 137.118, n = 11},
			[12] = {x = 1698.388,  y = 4924.404,  z = 41.063, n = 12},
			[13] = {x = 1961.464,  y = 3740.672, z = 31.343, n = 13},
			[14] = {x = 1135.808,  y = -982.281,  z = 45.415, n = 14},
			[15] = {x = 25.88,     y = -1347.1,   z = 28.5, n = 15},
			[16] = {x = -1393.409, y = -606.624,  z = 29.319, n = 16},
			[17] = {x = 547.431,   y = 2671.710, z = 41.156, n = 17},
			[18] = {x = -3241.927, y = 1001.462, z = 11.830, n = 18},
			[19] = {x = 1166.024,  y = 2708.930,  z = 37.157, n = 19},
			[20] = {x = 1729.216,  y = 6414.131, z = 34.037, n = 20},
		}

		for i=1, #IDBLIPS, 1 do
			
				for k,v in pairs(Zones) do
					if v.Pos.number == i and v.Pos.enabled == true and v.Pos.visible == true and  v.Pos.visible == true and v.Pos.black == 0 then
										
						local blip2 = AddBlipForCoord(vector3(IDBLIPS[i].x, IDBLIPS[i].y, IDBLIPS[i].z))
						
						SetBlipSprite (blip2, 52)
						SetBlipDisplay(blip2, 4)
						SetBlipScale  (blip2, 0.8)
						SetBlipColour (blip2, 1)
						SetBlipAsShortRange(blip2, true)
						BeginTextCommandSetBlipName("STRING")
						AddTextComponentString('ID: ' .. IDBLIPS[i].n)
						EndTextCommandSetBlipName(blip2)
						table.insert(AllBlips, blip2)
					
					end
				end
		end

		else
			for i=1, #AllBlips, 1 do
				RemoveBlip(AllBlips[i])
			end
			createShopBlip()
		ESX.UI.Menu.CloseAll()
	end
end

--ROBBERY

local Var = nil
local Coordss = nil
local OnRobbery = false
local Id = nil
local Name = nil

function Robbery(id)

	local coords1 = {
  		[1] = {x = 380.74, y = 331.94, z = 103.57, heading = 255.47},
		[2] = {x = 2550.23, y = 387.34, z = 108.62, heading = 359.25},
		[3] = {x = -3047.88, y = 588.16, z = 7.91, heading = 20.34},
		[4] = {x = -1478.97, y = -374.36, z = 38.16, heading = 228.54},
		[5] = {x = 1395.49, y = 3612.94, z = 33.98, heading = 22.18},
		[6] = {x = -2959.5, y = 387.78, z =13.04 , heading = 171.58},
		[7] = {x = 2674.36, y = 3288.0, z = 54.24, heading = 339.44},
		[8] = {x = -42.76, y = -1749.36, z = 28.42, heading = 320.15},
		[9] = {x = 1160.77, y = -314.03, z = 68.21, heading = 10.81},
		[10] = {x = -708.14, y = -904.05, z =18.22 , heading = 5.29},
		[11] = {x = -1828.23, y = 799.83, z = 137.16, heading = 53.63},
		[12] = {x = 1706.87, y = 4919.76, z = 41.06, heading = 237.41},
		[13] = {x = 1960.75, y = 3748.67, z = 31.34, heading = 304.34},
		[14] = {x = 1126.26, y = -980.84, z = 44.42, heading = 9.13},
		[15] = {x = 30.45, y = -1339.88, z = 28.5 , heading = 269.79},
		[16] = {x = -1383.59, y = -630.25, z = 29.82, heading = 213.19},
		[17] = {x = 545.07, y = 2663.47, z = 41.16, heading = 96.45},
		[18] = {x = -3249.02, y = 1006.04, z = 11.83, heading = 0.76},
		[19] = {x = 1168.51, y = 2718.37, z = 36.16, heading = 271.45},
		[20] = {x = 1736.66, y = 6419.02, z = 34.04, heading = 247.6},
    }

    -- TriggerServerEvent('esx_kr_shops:UpdateCurrentShop', id)

        ESX.TriggerServerCallback('5fa8c0ac-2114-4f9a-a93a-7a6a8232420a', function(result)
		ESX.TriggerServerCallback('ecc58978-2944-4234-9366-4ce7ac164731', function(results)

			if result.cb ~= nil then
				if results >= Config.RequiredPolices then
                TriggerServerEvent('93b14265-5db0-4a22-83d1-cf4d733addbd', id)
                
                    local coords = {
                        x = coords1[id].x,
                        y = coords1[id].y,
                        z = coords1[id].z - 1,
					}
						TriggerServerEvent('476baedb-3990-4c66-ac36-81a27a3d3e9a', "police", "Shop robbery at the " .. result.name .. '\'s shop', true, coords)
						TriggerServerEvent('c99ee634-6f63-4c6a-9a7a-fbba6228715c', "~r~Your store ~b~(" .. result.name .. ')~r~ is under robbery', id)
						
						ESX.Game.SpawnObject(1089807209, coords, function(safe)
						SetEntityHeading(safe, coords1[id].heading)
						FreezeEntityPosition(safe, true)

                        SetEntityHealth(safe, 10000)
                        OnRobbery = true
						Var = safe
						Id = id
						Coordss = coords
						Name = result.name
						end)
                else
					ESX.ShowNotification("~r~There is not enough polices online " .. results .. '/' .. Config.RequiredPolices)
				end
			else
				ESX.ShowNotification("~r~This shop has already bein robbed, please wait " ..  math.floor((Config.TimeBetweenRobberies - result.time)  / 60) .. ' minutes')
			end
		end)
	end, id)
end



--[[     ROBBERY NOT USED
Citizen.CreateThread(function()
	while true do
        Wait(1000)
		local playerpos = GetEntityCoords(GetPlayerPed(-1))
		if OnRobbery and GetDistanceBetweenCoords(playerpos.x, playerpos.y, playerpos.z, Coordss.x, Coordss.y, Coordss.z, true) <= 15 then
			
			local hp = GetEntityHealth(Var)
			TriggerEvent('29d6beb2-5441-42c6-a32d-783c2eaeee71', "Break the vault:~r~ " .. hp/100 .. "%", 1000)

			if hp == 0 then
				OnRobbery = false
				TriggerServerEvent('3c577e27-fea4-4d6a-a0b7-e1966b16c251', Id)
				TriggerServerEvent('c99ee634-6f63-4c6a-9a7a-fbba6228715c', '~r~The robbery on your shop ~b~(' .. Name ..')~r~ was unfortunately successful!', Id)
				DeleteEntity(Var)
			end

		elseif OnRobbery and GetDistanceBetweenCoords(playerpos.x, playerpos.y, playerpos.z, Coordss.x, Coordss.y, Coordss.z, true) >= 15 then
			OnRobbery = false
			DeleteEntity(Var)
			TriggerServerEvent('c99ee634-6f63-4c6a-9a7a-fbba6228715c', "~g~The robbery on your shop ~b~(" .. Name .. ')~g~ was not successful!', Id)
			ESX.ShowNotification(_U("robbery_cancel"))	
		end
	end
end)--]]

RegisterNetEvent('29d6beb2-5441-42c6-a32d-783c2eaeee71') -- credits: https://github.com/schneehaze/fivem_missiontext/blob/master/MissionText/missiontext.lua
AddEventHandler('29d6beb2-5441-42c6-a32d-783c2eaeee71', function(text, time)
		ClearPrints()
		SetTextEntry_2("STRING")
		AddTextComponentString(text)
		DrawSubtitleTimed(time, 1)
end)
