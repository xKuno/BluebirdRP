Config              = {}
Config.DrawDistance = 30
Config.Size         = {x = 1.5, y = 1.5, z = 1.5}
Config.Color        = {r = 0, g = 128, b = 255}
Config.Type         = 0
Config.Locale       = 'en'

Config.Zones = {

	TwentyFourSeven = {
		Items = {bread,water,chocolate,sandwich,hamburger,cupcake,cocacola,icetea,redbull,milk,cigarett,lighter},
		Pos = {
			vector3( 373.875, 325.896,102.566),
			vector3(2557.458,382.282,107.622),
			vector3( -3038.939,585.954, 6.908),
			vector3(-3241.927, 1001.462,11.830),
		--	{x = 547.431,   y = 2671.710, z = 41.156}, Shop 17
		--	{x = 1961.464,  y = 3740.672, z = 31.343},  Shop 13
			vector3(2678.916,  3280.671, 54.241),
			vector3(1729.216, 6414.131,34.037),
			--24/7 Strawberry vector3(26.29, -1346.86, 28.2),
			vector3(161.29,6640.24, 31.23),
			vector3(2801.71, -3908.16, 140.0)
			
			 
		}
	},

	RobsLiquor = {
		Items = {bread,water,chocolate,sandwich,hamburger,cupcake,cocacola,icetea,redbull,milk,cigarett,lighter},
		Pos = {
			vector3(1135.808,-982.281,45.415),
			vector3(-1222.915, -906.983, 11.326),
			vector3(-1487.553, -379.107,39.163),
			vector3(-2968.243, 390.910, 14.043),
			vector3(1166.024, 2708.930, 37.157),
			vector3(1392.562, 3604.684, 33.980),

		}
	},

	LTDgasoline = {
		Items = {bread,water,chocolate,sandwich,hamburger,cupcake,cocacola,icetea,redbull,milk,cigarett,lighter},
		Pos = {
			vector3(-48.519, -1757.514, 28.421),
			vector3(1163.373, -323.801, 68.205),
			vector3(-707.501,-914.260, 18.215),
			vector3( -1820.523,792.518, 137.118),
			vector3(1698.388,4924.404,41.063)
		}
	},


    Bar = {
        Items = {wine,beer,vodka,tequila,whisky},
        Pos = {
            --{x = 127.830,   y = -1284.796, z = 28.280}, --StripClub
            vector3(-1393.409, -606.624, 29.319), --Bahamamas
            --{x = -559.906,  y = 287.093,   z = 81.176}, --Tequila la
            vector3(1986.18, 3054.31,46.32)
        }
    },
	
	 Black = {
        Items = {wine,beer,vodka,tequila,whisky},
		Hidden = true,
        Pos = {
			vector3(2930.98,4623.74,47.72)--Bahamamas  2930,98   4623,74, 47.72
            --{x = 127.830,   y = -1284.796, z = 28.280}, --StripClub
     
            --{x = -559.906,  y = 287.093,   z = 81.176}, --Tequila la
          
        }
    },
}
