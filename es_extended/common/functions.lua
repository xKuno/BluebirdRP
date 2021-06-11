local Charset = {}

local debugmode = false

UG = {}

for i = 48,  57 do table.insert(Charset, string.char(i)) end
for i = 65,  90 do table.insert(Charset, string.char(i)) end
for i = 97, 122 do table.insert(Charset, string.char(i)) end

--Test


RegisterCommand("debugx", function()
	print('====DEBUG X====')
	 for k,v in pairs(UG) do
		print(k .. ' ' .. v)
	 end
end, false)

ESX.GetRandomString = function(length)
	UG["GetRandomString"] = tonum(UG["GetRandomString"])
	math.randomseed(GetGameTimer())

	if length > 0 then
		return ESX.GetRandomString(length - 1) .. Charset[math.random(1, #Charset)]
	else
		return ''
	end
end

ESX.GetConfig = function()
	return Config
end

function tonum(number)
	if number == nil then
		return 1
	else
		return (tonumber(number) + 1)
	end
end

ESX.GetWeapon = function(weaponName)
	UG["getweapon"] = tonum(UG["getweapon"])
	weaponName = string.upper(weaponName)
	local weapons = ESX.GetWeaponList()

	for i=1, #weapons, 1 do
		if weapons[i].name == weaponName then
			return i, weapons[i]
		end
	end
end

ESX.GetWeaponList = function()
	UG["GetWeaponList"] = tonum(UG["GetWeaponList"])
	return Config.Weapons
end

ESX.GetWeaponLabel = function(weaponName)
	UG["GetWeaponLabel"] = tonum(UG["GetWeaponLabel"])
	weaponName = string.upper(weaponName)
	local weapons = ESX.GetWeaponList()

	for i=1, #weapons, 1 do
		if weapons[i].name == weaponName then
			return weapons[i].label
		end
	end
end

ESX.GetWeaponComponent = function(weaponName, weaponComponent)
	UG["GetWeaponComponent"] = tonum(UG["GetWeaponComponent"])
	weaponName = string.upper(weaponName)
	local weapons = ESX.GetWeaponList()

	for i=1, #weapons, 1 do
		if weapons[i].name == weaponName then
			for j=1, #weapons[i].components, 1 do
				if weapons[i].components[j].name == weaponComponent then
					return weapons[i].components[j]
				end
			end
		end
	end
end

ESX.TableContainsValue = function(table, value)
	UG["TableContainsValue"] = tonum(UG["TableContainsValue"])
	for k, v in pairs(table) do
		if v == value then
			return true
		end
	end

	return false
end

ESX.DumpTable = function(table, nb)

	UG["DumpTable"] = tonum(UG["DumpTable"])
	if nb == nil then
		nb = 0
	end

	if type(table) == 'table' then
		local s = ''
		for i = 1, nb + 1, 1 do
			s = s .. "    "
		end

		s = '{\n'
		for k,v in pairs(table) do
			if type(k) ~= 'number' then k = '"'..k..'"' end
			for i = 1, nb, 1 do
				s = s .. "    "
			end
			s = s .. '['..k..'] = ' .. ESX.DumpTable(v, nb + 1) .. ',\n'
		end

		for i = 1, nb, 1 do
			s = s .. "    "
		end

		return s .. '}'
	else
		return tostring(table)
	end
end

ESX.Round = function(value, numDecimalPlaces)
	UG["Round"] = tonum(UG["Round"])
	return ESX.Math.Round(value, numDecimalPlaces)
end
