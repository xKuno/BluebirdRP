local type = {money=1,item=2,weapon=3} -- no touchey, thank you
Config = {}

Config.Command = false  -- Change command to true to switch to /daily
Config.random_rewards_enabled = true -- Set to False to Disable Random_Rewards
Config.rblip_enabled = true -- change to false to stop using Marker/blip

Config.rtime   = 86399  -- Seconds 24H:86399 12H:43199 6H:21399
Config.claimed = "~g~You claimed your daily reward"

Config.rewards = {
    {
        type = type.money,
        value = 1000
    },
    {
        type = type.item,
        item = "water",
        count = 3
    },
    {
        type = type.item,
        item = "bread",
        count = 5
    },
    {
        type = type.item,
        item = "pistol_ammo", -- if they already have the weapon, they'll only get the ammo
        ammo = 34
    },
    {
        type = type.item,
        item = "pistol_ammo", -- if they already have the weapon, they'll only get the ammo
        ammo = 34
    }
}

Config.random_rewards = {
	{
			chance = 90, -- this can be any whole number (higher = better chance)
			{
				type = type.money,
				value = math.random(500,800)
			},        
			{
				type = type.item,
				item = "bread",
				count = math.random(1,3)
			},
			
			{
				type = type.item,
				item = "water",
				count = math.random(1,2)
			},

	},
	{
			chance = 80, -- this can be any whole number (higher = better chance)
			{
				type = type.money,
				value = 1000
			},

	},
	{
        chance = 40, -- this can be any whole number (higher = better chance)
        {
            type = type.money,
            value = 3000
        },

	},
	{
        chance = 60, -- this can be any whole number (higher = better chance)
		{
			type = type.item,
			item = "scratchoff", -- if they already have the weapon, they'll only get the ammo
			ammo = math.random(1,2)
		}
	},
	
    {
        chance = 10,
		{
			type = type.item,
			item = "pistol_ammo", -- if they already have the weapon, they'll only get the ammo
			ammo = 34
		}
    },
	{
        chance = 13,
		{
			type = type.item,
			item = "smg_ammo", -- if they already have the weapon, they'll only get the ammo
			ammo = 1000
		}
    },
    {
        chance = 12,
        {
            type = type.item,
            item = "bread",
            count = 5
        },
        {
            type = type.item,
            item = "gsr",
            count = 3
        },
    },
    {
        chance = 5,
        {
            type = type.item,
            item = "weapon_pistol",
            count = 1
        },
    },
	{
        chance = 4,
        {
            type = type.item,
            item = "sniper_ammo",
            count = math.random(2,10)
        },
    }
}


Config.rblip = {
    {id = 586, x = 210.947, y = -932.262, z = 30.691}, --Legion Square
    {id = 586, x = 1707.136, y = 3844.262, z = 34.929}
}
--These are the Markers Change the XYZ to match the Map blips
Config.mblip = { 
    {id = 29, x = 210.947, y = -932.262, z = 30.691}, --Legion Square
    {id = 29, x = 1707.136, y = 3844.262, z = 34.929}
}
