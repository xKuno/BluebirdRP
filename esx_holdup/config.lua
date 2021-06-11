Config = {}
Config.Locale = 'en'

--Config.PoliceNumberRequired = 6
--Config.PoliceReqStore = 2
--Config.TimerBeforeNewRob = 2500 -- seconds
--Config.BreakTimer = 800  --Between all robberies
Config.LastRob = {}
Config.LastRob["bank"] = 0
Config.LastRob["shop"] = 0

-- Change secondsRemaining if you want another timer
Stores = {
    ["paleto_twentyfourseven"] = {
        position = { ['x'] = 1736.32092285156, ['y'] = 6419.4970703125, ['z'] = 35.037223815918 },
        reward = math.random(750,2800),
        nameofstore = "24/7. (Paleto Bay)",
        secondsRemaining = math.random(90,160), -- seconds
        lastrobbed = 0,
		cops = 4,
		BreakTimer = 900,
		TimerBeforeNewRob = 2500,
		ttype="shop"
	
    },
	["sandyshores_aceliquor"] = {
        position = { ['x'] = 1393.39, ['y'] = 3608.84, ['z'] = 34.3 },
        reward = math.random(1300,2800),
        nameofstore = "Ace Liquor. (Sandy Shores)",
        secondsRemaining = math.random(80,160), -- seconds
        lastrobbed = 0,
		cops = 4,
		BreakTimer = 900,
		TimerBeforeNewRob = 2500,
		ttype="shop"
    },
	
	
	["harmony_bank"] = {
        position = { ['x'] = 1177.3, ['y'] = 2711.35, ['z'] = 37.5 },
        reward = math.random(130000,180000),
        nameofstore = "Bank (Harmony)",
        secondsRemaining = math.random(230,460), -- seconds
        lastrobbed = 0,
		cops = 8,
		BreakTimer = 5400,
		TimerBeforeNewRob = 7200,
		ttype="bank"
    },

	["fleeca"] = {
        position = { ['x'] = 147.04908752441, ['y'] = -1044.9448242188, ['z'] = 29.36802482605 },
        reward = math.random(150000,160000),
        nameofstore = "Fleeca Bank (Legion Square)",
        secondsRemaining = math.random(230,460), -- seconds
        lastrobbed = 0,
		cops = 8,
		BreakTimer = 5400,
		TimerBeforeNewRob = 7200,
		ttype="bank"
    },
		["fleeca2"] = {
        position = { ['x'] = -2957.6674804688, ['y'] = 481.45776367188, ['z'] = 15.697026252747 },
        reward = math.random(145000,150000),
        nameofstore = "Fleeca Bank (Ocean Highway)",
        secondsRemaining = math.random(230,460), -- seconds
        lastrobbed = 0,
		cops = 8,
		BreakTimer = 5400,
		TimerBeforeNewRob = 7200,
		ttype="bank"
    },
		["blainecounty"] = {
        position = { ['x'] = -107.06505584717, ['y'] = 6474.8012695313, ['z'] = 31.62670135498},
        reward = math.random(143000,180000),
        nameofstore = "Blaine County Savings (Paleto)",
        secondsRemaining = 500, -- seconds
        lastrobbed = 0,
		cops = 8,
		BreakTimer = 5400,
		TimerBeforeNewRob = 7200,
		ttype="bank"
		
    },
	
	["fleeca3"] = {
        position = { ['x'] = -1211.6936035156, ['y'] = -335.79208374023, ['z'] = 36.790775299072 },
        reward = math.random(135000,150000),
        nameofstore = "ANZ Boulevard Del Perro",
        secondsRemaining = math.random(230,460), -- seconds
        lastrobbed = 0,
		cops = 8,
		BreakTimer = 5400,
		TimerBeforeNewRob = 7200,
		ttype="bank"
    },
	
	["fleeca4"] = {
        position = { ['x'] = -354.37020874023, ['y'] = -54.005802154541, ['z'] = 48.746318054199 },
        reward = math.random(135000,150000),
        nameofstore = "ANZ Hawick Ave",
        secondsRemaining = math.random(230,460), -- seconds
        lastrobbed = 0,
		cops = 8,
		BreakTimer = 5400,
		TimerBeforeNewRob = 7200,
		ttype="bank"
    },
	
	--[[
		["PrincipalBank"] = {
        position = { ['x'] = 255.001098632813, ['y'] = 225.855895996094, ['z'] = 101.005694274902 },
        reward = math.random(50000,130000),
        nameofstore = "Principal bank (HQ)",
        secondsRemaining = math.random(400,700), -- seconds
        lastrobbed = 0,
		cops = 6,
		BreakTimer = 750,
		TimerBeforeNewRob = 7200
    },--]]
	
	["harmony_twentyfourseven"] = {
        position = { ['x'] = 544.88, ['y'] = 2663.48, ['z'] = 41.8 },
        reward = math.random(900,2800),
        nameofstore = "24/7. (Harmony)",
        secondsRemaining = math.random(90,160), -- seconds
        lastrobbed = 0,
		cops = 0,
		BreakTimer = 900,
		TimerBeforeNewRob = 2500,
		ttype="shop"
		
    },
	["grapeseed_ltd"] = {
        position = { ['x'] = 1706.03, ['y'] = 4920.7, ['z'] = 41.6 },
        reward = math.random(750,2800),
        nameofstore = "LTD Gasoline. (Grapeseed)",
        secondsRemaining = math.random(90,160), -- seconds
        lastrobbed = 0,
		cops = 4,
		BreakTimer = 900,
		TimerBeforeNewRob = 2500,
		ttype="shop"
    },
	["grapeseed_clothing"] = {
        position = { ['x'] = 1698.18, ['y'] = 4821.69, ['z'] = 41.6 },
        reward = math.random(800,2500),
        nameofstore = "Dicount Clothing. (Grapeseed)",
        secondsRemaining = math.random(90,160), -- seconds
        lastrobbed = 0,
		cops = 4,
		BreakTimer = 900,
		TimerBeforeNewRob = 2500,
		ttype="shop"
    },
    ["sandyshores_twentyfoursever"] = {
        position = { ['x'] = 1961.24682617188, ['y'] = 3749.46069335938, ['z'] = 32.3437461853027 },
        reward = math.random(750,2500),
        nameofstore = "24/7. (Sandy Shores)",
        secondsRemaining = 120, -- seconds
        lastrobbed = 0,
		cops = 4,
		BreakTimer = 900,
		TimerBeforeNewRob = 2500,
		ttype="shop"
    },
	  ["strawberry_twentyfoursever"] = {
        position = { ['x'] = 29.48, ['y'] = -1340.01, ['z'] = 29.5 },
        reward = math.random(750,2900),
        nameofstore = "24/7. (Strawberry)",
        secondsRemaining = math.random(90,160), -- seconds
        lastrobbed = 0,
		cops = 4,
		BreakTimer = 900,
		TimerBeforeNewRob = 2500,
		ttype="shop"
    },
	  --["strawberry_vanillauni"] = {
       -- position = { ['x'] = 93.93, ['y'] = -1292.14, ['z'] = 29.5 },
       -- reward = math.random(800,2500),
      --  nameofstore = "Vanilla Unicorn (strip). (Strawberry)",
      --  secondsRemaining = 180, -- seconds
       -- lastrobbed = 0
   -- },
	--[[["pillboxhill_centrelink"] = {
        position = { ['x'] = -269.01, ['y'] = -956.23, ['z'] = 31.2 },
        reward = math.random(750,2800),
        nameofstore = "Centrelink (i). (Pillbox Hill)",
        secondsRemaining = 200, -- seconds
        lastrobbed = 0,
		cops = 4,
		BreakTimer = 900,
		TimerBeforeNewRob = 2500
    },--]]
    ["grandsenoradesert_twentyfoursever"] = {
        position = { ['x'] = 2673.82, ['y'] = 3287.37, ['z'] = 54.9 },
        reward = math.random(750,2800),
        nameofstore = "24/7. (Grand Senora Desert - FWY)",
        secondsRemaining = 120, -- seconds
        lastrobbed = 0,
		cops = 4,
		BreakTimer = 900,
		TimerBeforeNewRob = 2500,
		ttype="shop"
    },
    --[[["bar_one"] = {
        position = { ['x'] = 1990.579, ['y'] = 3044.957, ['z'] = 47.215171813965 },
        reward = math.random(750,2000),
        nameofstore = "Yellow Jack. (Sandy Shores)",
        secondsRemaining = 120, -- seconds
        lastrobbed = 0,
		cops = 3,
		BreakTimer = 1200,
		TimerBeforeNewRob = 2500
    },--]]
    ["ocean_liquor"] = {
        position = { ['x'] = -2959.33715820313, ['y'] = 388.214172363281, ['z'] = 14.0432071685791 },
        reward = math.random(750,2800),
        nameofstore = "Robs Liquor. (Great Ocean Higway)",
        secondsRemaining = 120, -- seconds
        lastrobbed = 0,
		cops = 4,
		BreakTimer = 900,
		TimerBeforeNewRob = 2500,
		ttype="shop"
    },
	["morningwood_liquor"] = {
        position = { ['x'] = -1482.54, ['y'] = -376.69, ['z'] = 40.1 },
        reward = math.random(750,2800),
        nameofstore = "Robs Liquor. (Morningwood)",
        secondsRemaining = 120, -- seconds
        lastrobbed = 0,
		cops = 4,
		BreakTimer = 900,
		TimerBeforeNewRob = 2500,
		ttype="shop"
    },
    ["sanandreas_liquor"] = {
        position = { ['x'] = -1219.85607910156, ['y'] = -916.276550292969, ['z'] = 11.3262157440186 },
        reward = math.random(900,3500),
        nameofstore = "Robs Liquor. (San andreas Avenue)",
        secondsRemaining = 120, -- seconds
        lastrobbed = 0,
		cops = 4,
		BreakTimer = 900,
		TimerBeforeNewRob = 2500,
		ttype="shop"
    },
    ["grove_ltd"] = {
        position = { ['x'] = -43.4035377502441, ['y'] = -1749.20922851563, ['z'] = 29.421012878418 },
        reward = math.random(750,2500),
        nameofstore = "LTD Gasoline. (Grove Street)",
        secondsRemaining = 120, -- seconds
        lastrobbed = 0,
		cops = 4,
		BreakTimer = 900,
		TimerBeforeNewRob = 2500,
		ttype="shop"
    },
    ["mirror_ltd"] = {
        position = { ['x'] = 1160.67578125, ['y'] = -314.400451660156, ['z'] = 69.2050552368164 },
        reward = math.random(1500,3500),
        nameofstore = "LTD Gasoline. (Mirror Park Boulevard)",
        secondsRemaining = 120, -- seconds
        lastrobbed = 0,
		cops = 4,
		BreakTimer = 900,
		TimerBeforeNewRob = 2500,
		ttype="shop"
    },
    ["littleseoul_ltd"] = {
        position = { ['x'] = -709.17022705078, ['y'] = -904.21722412109, ['z'] = 19.215591430664 },
        reward = math.random(750,3500),
        nameofstore = "LTD Gasoline. (Little Seoul)",
        secondsRemaining = 120, -- seconds
        lastrobbed = 4,
		cops = 0,
		BreakTimer = 900,
		TimerBeforeNewRob = 2500,
		ttype="shop"
    },
	   ["paletobay_twentyfoursever"] = {
        position = { ['x'] = 168.87, ['y'] = 6644.53, ['z'] = 30.57 },
        reward = math.random(750,2200),
        nameofstore = "24/7. (Bendigo - Fuel Station)",
        secondsRemaining = 120, -- seconds
        lastrobbed = 0,
		cops = 4,
		BreakTimer = 900,
		TimerBeforeNewRob = 2500,
		ttype="shop"
    },
	
	
}
