--====================================================================================
-- #Author: Jonathan D @ Gannon
--====================================================================================
RegisterNetEvent('097905ff-da1e-42a2-82b5-9f96034c0b21')
AddEventHandler('097905ff-da1e-42a2-82b5-9f96034c0b21', function(billingg)
  SendNUIMessage({event = 'fatura_billingg', billingg = billingg})
end)

RegisterNUICallback('fatura_getBilling', function(data, cb)
  TriggerServerEvent('0d0ce5ff-731e-4791-98cf-3cfdf41e6fdd', data.label, data.amount, data.sender)
end)

RegisterNUICallback('faturapayBill', function(data)
	ESX.ShowNotification("You can only view past invoices")
--  TriggerServerEvent('35bf0e9f-5507-4509-9c92-7d03f6eb0a65', data.id, data.sender, data.amount, data.target)
end)

