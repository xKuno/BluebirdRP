Config = {}
Config.Locale = 'en'
Config.NumberOfCopsRequired = 6

--Updated to choose between cash or black money
Config.moneyType = 'black' -- 'cash' or 'black'

Banks = {
	--[[["fleeca"] = {
	
		position = { ['x'] = 148.91908752441, ['y'] = -1050.7448242188, ['z'] = 29.36802482605 }, -- position of robbery, when you have tu use the item "blowtorch"
		hackposition = { ['x'] = 149.46, ['y'] = -1046.3, ['z'] = 29.35 }, -- position where you have to do hack with the minigame to open a door
		bombposition = {['x'] = 147.04908752441, ['y'] = -1044.9448242188, ['z'] = 29.36802482605 },
		--hackteleport = { ['x'] = 148.79908752441, ['y'] = -1045.5748242188, ['z'] = 29.36802482605 }, -- ignore this
		reward = math.random(80000,120000), -- the random range of amount of money you will get for robbery this site
		nameofbank = "Fleeca Bank", --Visual Name that will be the site
		lastrobbed = 0, -- DONT TOUCH THIS variable used to make a delay to robb other time
		cops = 6,
		doortype = 'V_ILEV_GB_VAULDR', -- Name or ID of the gameobject that will be rotate to make the open efect, you can check what id or name you need here: https://objects.gt-mp.net/ if you dont find it, contact with you developer, he will know how to get it in game
	},
	["fleeca2"] = {
		position = { ['x'] = -2954.2874804688, ['y'] = 486.14476367188, ['z'] = 15.697026252747 },
		hackposition = { ['x'] = -2957.54, ['y'] =  484.53, ['z'] =  15.68 },
		bombposition = { ['x'] = -2958.47  , ['y'] =  478.97 , ['z'] = 15.7 },
		reward = math.random(80000,100000),
		nameofbank = "Fleeca Bank || Great Ocean Hwy",
		bombdoortype = 'hei_prop_heist_sec_door', 
		lastrobbed = 0,
		doortype = 'hei_prop_heist_sec_door',
		cops = 6,
	},
	
	
	["fleeca3"] = {
		position = { ['x'] = 1172.76, ['y'] =  2716.76, ['z'] = 38.07 },
		hackposition = { ['x'] = 1173.41, ['y'] =  2712.06, ['z'] =  38.07 },        
		bombposition = { ['x'] = 1176.82  , ['y'] =  2711.81 , ['z'] = 38.1 },
		reward = math.random(80000,120000),
		nameofbank = "Fleeca Bank || Harmony",
		bombdoortype = 'hei_prop_heist_sec_door', 
		lastrobbed = 0,
		doortype = 'hei_prop_heist_sec_door',
		cops = 6,
	},
		
	   
	
	
	["blainecounty"] = {
		position = { ['x'] = -107.06505584717, ['y'] = 6474.8012695313, ['z'] = 31.62670135498 },
		hackposition = { ['x'] = -107.06505584717, ['y'] = 6474.8012695313, ['z'] = 31.62670135498 },
		reward = math.random(15000,25000),
		nameofbank = "Blaine County Savings",

		lastrobbed = 0
	},--]]
	
	["PrincipalBank"] = {
		position = vector3( 264.99899291992,213.50576782227,101.68346405029),
		hackposition = vector3( 261.49499291992, 223.06776782227, 106.28346405029 ),
        bombposition = vector3(254.12199291992, 225.50576782227, 101.87346405029 ), -- if this var is set will appear a site to plant a bomb which will open the door defined at var "bombdoortype"
		reward = math.random(220000,355000),
		nameofbank = "Principal bank",
		lastrobbed = 0,
        bombdoortype = 'v_ilev_bk_vaultdoor', -- If this var is set you will need set the var "bombposition" to work properly , you can find the name or id here: https://objects.gt-mp.net/  if you dont find it, contact with your devs
        doortype = 'hei_v_ilev_bk_gate2_pris',
		cops = 10,
    },

}

