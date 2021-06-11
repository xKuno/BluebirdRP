AddEventHandler('esx:getSharedObject', function(cb)
	UG["getSharedObject"] = tonum(UG["getSharedObject"])
	cb(ESX)
end)

function getSharedObject()
	UG["FNgetSharedObject"] = tonum(UG["FNgetSharedObject"])
	return ESX
end
