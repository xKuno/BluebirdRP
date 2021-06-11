seqSwitch = nil
seqRemaingingTime = 0

AddEventHandler('313fbe9a-9fc8-4e69-89ca-6a5b3b4f138b', function(solutionlength, duration, callback)
	if type(solutionlength) ~= 'table' and type(duration) ~= 'table' then
		TriggerEvent('0ee1b37e-00fa-484d-b9f2-ce9381968ff7')
		TriggerEvent('1ba533d0-c40c-403d-9a1c-1de79d7174d3', solutionlength, duration, mhackingSeqCallback)
		while seqSwitch == nil do
			Citizen.Wait(5)
		end
		TriggerEvent('aedcafd6-57b5-4322-ad5b-ed0db6ba4cce')
		callback(seqSwitch, seqRemaingingTime, true)
		seqRemaingingTime = 0
		seqSwitch = nil
		
	elseif type(solutionlength) == 'table' and type(duration) ~= 'table' then
		TriggerEvent('0ee1b37e-00fa-484d-b9f2-ce9381968ff7')
		seqRemaingingTime = duration
		for _, sollen in pairs(solutionlength) do
			TriggerEvent('1ba533d0-c40c-403d-9a1c-1de79d7174d3', sollen, seqRemaingingTime, mhackingSeqCallback)	
			while seqSwitch == nil do
				Citizen.Wait(5)
			end
			
			if next(solutionlength,_) == nil or seqRemaingingTime == 0 then
				callback(seqSwitch, seqRemaingingTime, true)
			else
				callback(seqSwitch, seqRemaingingTime, false)
			end
			seqSwitch = nil
		end
		seqRemaingingTime = 0
		TriggerEvent('aedcafd6-57b5-4322-ad5b-ed0db6ba4cce')
		
	elseif type(solutionlength) ~= 'table' and type(duration) == 'table' then
		TriggerEvent('0ee1b37e-00fa-484d-b9f2-ce9381968ff7')
		for _, dur in pairs(duration) do
			TriggerEvent('1ba533d0-c40c-403d-9a1c-1de79d7174d3', solutionlength, dur, mhackingSeqCallback)	
			while seqSwitch == nil do
				Citizen.Wait(5)
			end
			if next(duration,_) == nil then
				callback(seqSwitch, seqRemaingingTime, true)
			else
				callback(seqSwitch, seqRemaingingTime, false)
			end
			seqSwitch = nil
		end
		seqRemaingingTime = 0
		TriggerEvent('aedcafd6-57b5-4322-ad5b-ed0db6ba4cce')
	
	elseif type(solutionlength) == 'table' and type(duration) == 'table' then
		local itrTbl = {}
		local solTblLen = 0
		local durTblLen = 0
		for _ in ipairs(solutionlength) do solTblLen = solTblLen + 1 end
		for _ in ipairs(duration) do durTblLen = durTblLen + 1 end
		itrTbl = duration
		if solTblLen > durTblLen then itrTbl = solutionlength end	
		TriggerEvent('0ee1b37e-00fa-484d-b9f2-ce9381968ff7')
		for idx in ipairs(itrTbl) do
			TriggerEvent('1ba533d0-c40c-403d-9a1c-1de79d7174d3', solutionlength[idx], duration[idx], mhackingSeqCallback)	
			while seqSwitch == nil do
				Citizen.Wait(5)
			end
			if next(itrTbl,idx) == nil then
				callback(seqSwitch, seqRemaingingTime, true)
			else
				callback(seqSwitch, seqRemaingingTime, false)
			end
			seqSwitch = nil
		end
		seqRemaingingTime = 0
		TriggerEvent('aedcafd6-57b5-4322-ad5b-ed0db6ba4cce')
		
	end
end)

function mhackingSeqCallback(success, remainingtime)
	seqSwitch = success
	seqRemaingingTime = math.floor(remainingtime/1000.0 + 0.5)
end