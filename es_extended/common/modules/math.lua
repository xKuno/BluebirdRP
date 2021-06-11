ESX.Math = {}

ESX.Math.Round = function(value, numDecimalPlaces)
	UG["Math.Round"] = tonum(UG["Math.Round"])
	return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", value))
end

-- credit http://richard.warburton.it
ESX.Math.GroupDigits = function(value)
	UG["Math.GroupDigits"] = tonum(UG["Math.GroupDigits"])
	local left,num,right = string.match(value,'^([^%d]*%d)(%d*)(.-)$')

	return left..(num:reverse():gsub('(%d%d%d)','%1' .. _U('locale_digit_grouping_symbol')):reverse())..right
end

ESX.Math.Trim = function(value)
	UG["Math.Trim"] = tonum(UG["Math.Trim"])
	if value then
		return (string.gsub(value, "^%s*(.-)%s*$", "%1"))
	else
		return nil
	end
end