-----------------------------------
--- Vote to Kick, Made by FAXES ---
-----------------------------------

local playerVoted = false

TriggerEvent('2896af73-6240-4f26-92b0-417518db3f5a', '/votekick', 'Start a votekick against a player', {
    { name="PlayerID", help="Enter the Player ID to be kicked" },
	{name="Reason", help="Reason for votekick" },})
	
TriggerEvent('2896af73-6240-4f26-92b0-417518db3f5a', '/voteyes', 'Votes YES against a votekick', {})

TriggerEvent('2896af73-6240-4f26-92b0-417518db3f5a', '/voteno', 'Votes NO against a votekick', {})

TriggerEvent('2896af73-6240-4f26-92b0-417518db3f5a', '/votes', 'Tells you the count of vote kicks', {})

RegisterNetEvent('60c035fa-0e34-477c-97a7-d512ede6a2ec')
AddEventHandler('60c035fa-0e34-477c-97a7-d512ede6a2ec', function(vote)
    local src = source
    if playerVoted then
        TriggerEvent('chatMessage', "^*^1You have already voted!")
    else
        if vote == "yes" then
            TriggerServerEvent('ccbc0392-3da9-4f6c-b62d-4bdb13e19327')
            TriggerEvent('chatMessage', "^2You have voted!")
        elseif vote == "no" then
			TriggerServerEvent('ad8236b7-b13c-4498-8295-2efcc8bf2045')
			
            TriggerEvent('chatMessage', "^2You have voted!")
        end
        playerVoted = true
    end
end)

RegisterNetEvent('8f58b6a7-e34d-44b5-ae51-ad6b3fe305da')
AddEventHandler('8f58b6a7-e34d-44b5-ae51-ad6b3fe305da', function()
    playerVoted = false
end)