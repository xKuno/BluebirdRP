ESX.Table = {}

-- nil proof alternative to #table
function ESX.Table.SizeOf(t)

	UG["Table.SizeOf"] = tonum(UG["Table.SizeOf"])
	local count = 0

	for _,_ in pairs(t) do
		count = count + 1
	end

	return count
end

function ESX.Table.IndexOf(t, value)
	UG["Table.IndexOf"] = tonum(UG["Table.IndexOf"])
	for i=1, #t, 1 do
		if t[i] == value then
			return i
		end
	end

	return -1
end

function ESX.Table.LastIndexOf(t, value)
	UG["Table.LastIndexOf"] = tonum(UG["Table.LastIndexOf"])
	for i=#t, 1, -1 do
		if t[i] == value then
			return i
		end
	end

	return -1
end

function ESX.Table.Find(t, cb)
	UG["Table.Find"] = tonum(UG["Table.Find"])
	for i=1, #t, 1 do
		if cb(t[i]) then
			return t[i]
		end
	end

	return nil
end

function ESX.Table.FindIndex(t, cb)
	UG["Table.FindIndex"] = tonum(UG["Table.FindIndex"])
	for i=1, #t, 1 do
		if cb(t[i]) then
			return i
		end
	end

	return -1
end

function ESX.Table.Filter(t, cb)
	UG["Table.Filter"] = tonum(UG["Table.Filter"])
	local newTable = {}

	for i=1, #t, 1 do
		if cb(t[i]) then
			table.insert(newTable, t[i])
		end
	end

	return newTable
end

function ESX.Table.Map(t, cb)
	UG["Table.Map"] = tonum(UG["Table.Map"])
	local newTable = {}

	for i=1, #t, 1 do
		newTable[i] = cb(t[i], i)
	end

	return newTable
end

function ESX.Table.Reverse(t)
	UG["Table.Reverse"] = tonum(UG["Table.Reverse"])
	local newTable = {}

	for i=#t, 1, -1 do
		table.insert(newTable, t[i])
	end

	return newTable
end

function ESX.Table.Clone(t)
	UG["Table.Clone"] = tonum(UG["Table.Clone"])
	if type(t) ~= 'table' then return t end

	local meta = getmetatable(t)
	local target = {}

	for k,v in pairs(t) do
		if type(v) == 'table' then
			target[k] = ESX.Table.Clone(v)
		else
			target[k] = v
		end
	end

	setmetatable(target, meta)

	return target
end

function ESX.Table.Concat(t1, t2)
	UG["Table.Concat"] = tonum(UG["Table.Concat"])
	local t3 = ESX.Table.Clone(t1)

	for i=1, #t2, 1 do
		table.insert(t3, t2[i])
	end

	return t3
end

function ESX.Table.Join(t, sep)
	UG["Table.Join"] = tonum(UG["Table.Join"])
	local sep = sep or ','
	local str = ''

	for i=1, #t, 1 do
		if i > 1 then
			str = str .. sep
		end

		str = str .. t[i]
	end

	return str
end

-- Credit: https://stackoverflow.com/a/15706820
-- Description: sort function for pairs
function ESX.Table.Sort(t, order)
	UG["Table.Sort"] = tonum(UG["Table.Sort"])
	-- collect the keys
	local keys = {}

	for k,_ in pairs(t) do
		keys[#keys + 1] = k
	end

	-- if order function given, sort by it by passing the table and keys a, b,
	-- otherwise just sort the keys
	if order then
		table.sort(keys, function(a,b)
			return order(t, a, b)
		end)
	else
		table.sort(keys)
	end

	-- return the iterator function
	local i = 0

	return function()
		i = i + 1
		if keys[i] then
			return keys[i], t[keys[i]]
		end
	end
end