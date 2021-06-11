Config = {
	DrawDistance = 80,
	Price = 1800,
	MecPrice = 3500,
	BlipInfos = {
		Sprite = 290,
		Color = 3 
	}
}


Config.BikeLocations = {
	bike1 = {
		Pos = {x=-4.16, y= 6515.52, z=30.50},  --
		Marker = 27, --38
  		Color = {r = 0, g = 255, b = 0},
		Size={x = 1.0, y = 1.0, z = 1.0},
		SpawnPoint = {
			Pos = {x=-4.16, y= 6515.52, z=30.50},
		},
	},
	bike2 = {
		Pos = {x=356.16, y= -613.29, z=27.90},  --
		Marker = 27, --38
  		Color = {r = 0, g = 255, b = 0},
		Size={x = 1.0, y = 1.0, z = 1.0},
		SpawnPoint = {
			Pos = {x=356.16, y= -613.29, z=27.90},
		},
	},
	bike3 = {
		Pos = {x=293.51257324219, y= -597.08966064453, z=42.29},  --
		Marker = 27, --38
  		Color = {r = 0, g = 255, b = 0},
		Size={x = 1.0, y = 1.0, z = 1.0},
		SpawnPoint = {
			Pos = {x=295.11,  y= -600.57, z=42.34},
		},
	}
	,
	bike4 = {
		Pos = {x=-407.3471679,  y= -366.623, z=31.4038},  --
		Marker = 27, --38
  		Color = {r = 0, g = 255, b = 0},
		Size={x = 1.0, y = 1.0, z = 1.0},
		SpawnPoint = {
			Pos = {x=-407.3471679,  y= -366.623, z=31.3738},
		},
	}



}

Config.Garages = {

--[[
	City_NearLegion= {	
		Pos = {x =-332.91, y=-936.33, z=31.08},
		Size  = {x = 3.0, y = 3.0, z = 3.0},
		Color = {r = 204, g = 204, b = 0},
		Marker = 29,
		Zone = 1,
		BlipInfos = {
		Sprite = 290,
		Color = 3 
		},
		SpawnPoint = {
			Pos = {x=-330.20,y=-928.36,z=31.08},
			Heading = 84.98,
			Color = {r = 0, g =255, b = 0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 36
		},
		DeletePoint = {
			Pos = {x=-336.30,y=-946.61,z=31.08},
			Color = {r=255,g=0,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 30
		}, 	
	},

	City_NearPolice= {	
		Pos = {x=471.44, y=-1113.07, z=29.2},
		Size  = {x = 3.0, y = 3.0, z = 3.0},
		Color = {r = 204, g = 204, b = 0},
		Marker = 29,
		Zone = 1,
		BlipInfos = {
		Sprite = 290,
		Color = 3 
		},
		SpawnPoint = {
			Pos = {x=482.78, y=-1098.28, z= 28.8},
			Heading = 246.4,
			Color = {r=0,g=255,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 36
		},
		DeletePoint = {
			Pos = {x=458.79, y=-1104.72, z=29.2},
			Color = {r=255,g=0,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 30
		}, 	
	},--]]

	--[[City_LittleSeoul_beach= {	
		Pos = {x=-752.83, y=-1052.64, z=13.48},
		Size  = {x = 3.0, y = 3.0, z = 3.0},
		Color = {r = 204, g = 204, b = 0},
		Marker = 29,
		Zone = 1,
		SpawnPoint = {
			Pos = {x=-740.11, y=-1045.44, z= 12.37},
			Heading = 246.4,
			Color = {r=0,g=255,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 36
		},
		DeletePoint = {
			Pos = {x=-749.81, y=-1027.26, z=13.03},
			Color = {r=255,g=0,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 30
		}, 	
	},--]]
	
	--[[Garage_Centre = {	
		Pos = {x=215.800, y=-810.057, z=29.727},
		Size  = {x = 3.0, y = 3.0, z = 3.0},
		Color = {r = 204, g = 204, b = 0},
		Marker = 29,
		Zone = 1,
		SpawnPoint = {
			Pos = {x=229.700, y= -800.1149, z= 29.5722},
			Heading = 160.0,
			Color = {r=0,g=255,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 36
		},
		DeletePoint = {
			Pos = {x=215.124, y=-791.377, z=29.646},
			Color = {r=255,g=0,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 30
		}, 	
	},
	
	Garage_Centre2 = {	
		Pos = {x = -1523.191,y = -451.017,z = 35.596},
		Heading = 160.0,
		Size  = {x = 3.0, y = 3.0, z = 3.0},
		Color = {r = 204, g = 204, b = 0},
		Marker = 29,
		Zone = 1,
		BlipInfos = {
		Sprite = 290,
		Color = 3 
		},
		SpawnPoint = {
			Pos = {x = -1519.22,y = -434.582,z = 35.442},
			Color = {r=0,g=255,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 36
		},
		DeletePoint = {
			Pos = {x = -1528.022,y = -443.280,z = 35.442},
			Color = {r=255,g=0,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 30
		}, 	
	},		
	--]]
	--[[
		Garage_City_Court = {	
		Pos = {x = -356.63,y= 38.32,z= 48.03},
		Size  = {x = 3.0, y = 3.0, z = 3.0},
		Color = {r = 204, g = 204, b = 0},
		Marker = 29,
		Zone = 1,
		BlipInfos = {
		Sprite = 290,
		Color = 3 
		},
		SpawnPoint = {
			Pos = {x = -358.96,y= 30.21,z= 47.79},
			Heading = 88.37,
			Color = {r=0,g=255,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 36
		},
		DeletePoint = {
			Pos = {x= -370.70,y= 39.73,z= 51.04},
			Color = {r=255,g=0,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 30
		}, 	
	},	
	
	
	Garage_Paleto = {	
		Pos = {x=105.359, y=6613.586, z=32.3973},
		Size  = {x = 3.0, y = 3.0, z = 3.0},
		Color = {r = 204, g = 204, b = 0},
		Marker = 29,
		Zone = 2,
		BlipInfos = {
		Sprite = 290,
		Color = 3 
		},
		SpawnPoint = {
			Pos = {x=128.7822, y= 6622.9965, z= 31.7828},
			Heading = 160.0,
			Color = {r=0,g=255,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 36
		},
		DeletePoint = {
			Pos = {x=126.3572, y=6608.4150, z=31.8565},
			Color = {r=255,g=0,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 30
			
		}, 	
	},
	Garage_SandyShore = {	
		Pos = {x=1530.93, y=3777.1, z=33.99},
		Size  = {x = 3.0, y = 3.0, z = 3.0},
		Color = {r = 204, g = 204, b = 0},
		Marker = 29,
		Zone = 2,
		BlipInfos = {
		Sprite = 290,
		Color = 3 
		},
		SpawnPoint = {
			Pos = {x=1503.82, y= 3762.13, z= 33.79},
			Heading = 212.3,
			Color = {r=0,g=255,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 36
		},
		DeletePoint = {
			Pos = {x = 1549.71,y = 3784.2,z = 33.7},
			Color = {r=255,g=0,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 30
		}, 	
	},
	
	Garage_Ocean1 = {	
		Pos = {x = -3140.323,y = 1124.463,z = 20.706},
		Size  = {x = 3.0, y = 3.0, z = 3.0},
		Color = {r = 204, g = 204, b = 0},
		Marker = 29,
		Zone = 1,
		BlipInfos = {
		Sprite = 290,
		Color = 3 
		},
		SpawnPoint = {
			Pos = {x = -3132.638,y = 1126.662,z = 20.667},
			Heading = 160.0,
			Color = {r=0,g=255,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 36
		},
		DeletePoint = {
			Pos = {x = -3136.902,y = 1102.685,z = 20.654},
			Color = {r=255,g=0,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 30
		}, 	
	},	

		
	Garage_Ocean2 = {	
		Pos = {x = -2982.561,y = 327.506,z = 14.935},
		Size  = {x = 3.0, y = 3.0, z = 3.0},
		Color = {r = 204, g = 204, b = 0},
		Marker = 29,
		Zone = 1,
		BlipInfos = {
		Sprite = 290,
		Color = 3 
		},
		SpawnPoint = {
			Pos = {x = -2977.238,y = 337.777,z = 14.768},
			Heading = 160.0,
			Color = {r=0,g=255,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 36
		},
		DeletePoint = {
			Pos = {x = 404.7,y = -1632.14,z = 28.6},
			Color = {r=255,g=0,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 30
		}, 	
	},	
	
	Garage_PoliceImpound = {	
		Pos = {x = 419.82,y = -1644.61,z = 29.5},
		Size  = {x = 3.0, y = 3.0, z = 3.0},
		Color = {r = 204, g = 204, b = 0},
		Marker = 29,
		Zone = 1,
		BlipInfos = {
		Sprite = 290,
		Color = 3 
		},
		SpawnPoint = {
			Pos = {x = 401.39,y = -1643.55,z = 29.5},
			Heading = 226.0,
			Color = {r=0,g=255,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 36
		},
		DeletePoint = {
			Pos = {x = 405.28,y = -1631.44,z = 29.5},
			Color = {r=255,g=0,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 30
		}, 	
	},	
	
	Garage_Industrial = {	
		Pos = {x = 926.35,y = -2446.77,z = 28.5},
		Size  = {x = 3.0, y = 3.0, z = 3.0},
		Color = {r = 204, g = 204, b = 0},
		Marker = 29,
		Zone = 1,
		BlipInfos = {
		Sprite = 290,
		Color = 3 
		},
		SpawnPoint = {
			Pos = {x = 914.58,y = -2445.9,z = 28.5},
			Heading = 226.0,
			Color = {r=0,g=255,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 36
		},
		DeletePoint = {
			Pos = {x = 937.95,y = -2447.77,z = 28.5},
			Color = {r=255,g=0,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 30
		}, 	
	},	
	
	Garage_City_LSCustoms = {	
		Pos = {x = -382.8 ,y = -134.78,z = 38.69},
		Size  = {x = 3.0, y = 3.0, z = 3.0},
		Color = {r = 204, g = 204, b = 0},
		Marker = 29,
		Zone = 1,
		BlipInfos = {
		Sprite = 290,
		Color = 3 
		},
		SpawnPoint = {
			Pos = {x = -388.27,y = -124.24,z = 38.6},
			Heading = 226.0,
			Color = {r=0,g=255,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 36
		},
		DeletePoint = {
			Pos = {x = -378.26,y = -143.07,z = 38.68},
			Color = {r=255,g=0,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 30
		}, 	
	},	--]]
	
	--[[Job_G_BoatYard = {	
		Pos = {x = 581.99,y = -2305.22,z = -10.6},
		Size  = {x = 3.0, y = 3.0, z = 3.0},
		Color = {r = 204, g = 204, b = 0},
		Marker = 29,
		Zone = 1,
		BlipInfos = {
		Sprite = 290,
		Color = 3 
		},
		SpawnPoint = {
			Pos = {x = 581.99,y = -2305.22,z = 6.00},
			Heading = 80.64,
			Color = {r=0,g=255,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 36
		},
		DeletePoint = {
			Pos = {x = 578.22,y = -2337.5,z = 6.00},
			Color = {r=255,g=0,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 30
		}, 	
	},	
	
	
		
	ButcherJob = {	
		Pos = {x = -970.73,y = -1963.26,z = -10.6},
		Size  = {x = 3.0, y = 3.0, z = 3.0},
		Color = {r = 204, g = 204, b = 0},
		Marker = 29,
		Zone = 1,
		BlipInfos = {
		Sprite = 290,
		Color = 3 
		},
		SpawnPoint = {
			Pos = {x = -970.73,y = -1963.26,z = 13.19},
			Heading = 306.78,
			Color = {r=0,g=255,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 36
		},
		DeletePoint = {
			Pos = {x = -963.84,y = -1970.77,z = 13.19},
			Color = {r=255,g=0,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 30
		},
	},	--]]
	
	--[[
	GarbageJob = {	
		Pos = {x = -320.68,y = -1495.67,z = -10.6},
		Size  = {x = 3.0, y = 3.0, z = 3.0},
		Color = {r = 204, g = 204, b = 0},
		Marker = 29,
		Zone = 1,
		BlipInfos = {
		Sprite = 290,
		Color = 3 
		},
		SpawnPoint = {
			Pos = {x = -329.67,y = -1495.85,z = 30.68},
			Heading = 306.78,
			Color = {r=0,g=255,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 36
		},
		DeletePoint = {
			Pos = {x = -320.68,y = -1495.67,z = 30.68},
			Color = {r=255,g=0,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 30
		},
	},	

	SecurityJob = {	
		Pos = vector3(-1177.58, -891.69, 13.77),
		Size  = {x = 3.0, y = 3.0, z = 3.0},
		Color = {r = 204, g = 204, b = 0},
		Marker = 29,
		Zone = 1,
		BlipInfos = {
		Sprite = 290,
		Color = 3 
		},
		SpawnPoint = {
			Pos = {x = -1171.77,y =  -892.28,z =  13.88},
			Heading = 34.64,
			Color = {r=0,g=255,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 36
		},
		DeletePoint = {
			Pos = {x = -1172.07,y = -875.59,z =  14.16},
			Color = {r=255,g=0,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 30
		},
	},	--]]
	
	
	--[[BoatPierJob = {	
		Pos = {x = -785.28,y = -1279.49,z = -10.6},
		Size  = {x = 3.0, y = 3.0, z = 3.0},
		Color = {r = 204, g = 204, b = 0},
		Marker = 29,
		Zone = 1,
		BlipInfos = {
		Sprite = 290,
		Color = 3 
		},
		SpawnPoint = {
			Pos = {x = -785.28,y = -1279.49,z = 5.00},
			Heading = 164.9,
			Color = {r=0,g=255,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 36
		},
		DeletePoint = {
			Pos = {x = -798.77,y = -1278.95,z = 5.00},
			Color = {r=255,g=0,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 30
		},
	},	
--]]
--[[	
	HarmonyMotel = {	
		Pos = {x = 1109.53,y = 2661.06,z = 37.98},
		Size  = {x = 3.0, y = 3.0, z = 3.0},
		Color = {r = 204, g = 204, b = 0},
		Marker = 29,
		Zone = 2,
		BlipInfos = {
		Sprite = 290,
		Color = 3 
		},
		SpawnPoint = {
			Pos = {x = 1100.17 ,y = 2669.02 ,z = 38.08},
			Heading = 272.5,
			Color = {r=0,g=255,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 36
		},
		DeletePoint = {
			Pos = {x = 1111.34,y = 2647.38,z = 38.0},
			Color = {r=255,g=0,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 30
		},
	},--]]
	--[[
	City577CarPark = {	
		Pos = {x = 65.814552307129,y = 13.9571266,z = 69.060348},
		Size  = {x = 3.0, y = 3.0, z = 3.0},
		Color = {r = 204, g = 204, b = 0},
		Marker = 29,
		Zone = 1,
		BlipInfos = {
		Sprite = 290,
		Color = 3 
		},
		SpawnPoint = {
			Pos = {x = 55.994 ,y = 28.0813 ,z = 70.063},
			Heading = 272.5,
			Color = {r=0,g=255,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 36
		},
		DeletePoint = {
			Pos = {x = 77.99101,y = 20.777,z = 69.0782},
			Color = {r=255,g=0,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 30
		},
	},	
	
	
	
		CityHotelPink = {	
		Pos = vector3(327.03, -196.55, 54.23),
		Size  = {x = 3.0, y = 3.0, z = 3.0},
		Color = {r = 204, g = 204, b = 0},
		Marker = 29,
		Zone = 1,
		BlipInfos = {
		Sprite = 290,
		Color = 3 
		},
		SpawnPoint = {
			Pos = vector3(329.59, -208.02, 54.09),
			Heading = 272.5,
			Color = {r=0,g=255,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 36
		},
		DeletePoint = {
			Pos = vector3(323.65, -202.97, 54.09),
			Color = {r=255,g=0,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 30
		},
	},	--]]
	
	--[[PizzaJob = {	
		Pos = {x = 172.54,y = -27.51,z = 68.05},
		Size  = {x = 3.0, y = 3.0, z = 3.0},
		Color = {r = 204, g = 204, b = 0},
		Marker = 29,
		Zone = 1,
		BlipInfos = {
		Sprite = 290,
		Color = 3 
		},
		SpawnPoint = {
			Pos = {x = 161.21 ,y = -30.54 ,z = 67.78},
			Heading = 67.96,
			Color = {r=0,g=255,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 36
		},
		DeletePoint = {
			Pos = {x = 174.48,y = -35.28,z = 68.03},
			Color = {r=255,g=0,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 30
		},
	},--]]
	
	---  
	
		Zancudo = {	
		Pos = {x = -2260.73,y = 3090.24,z = 31.96},
		Size  = {x = 3.0, y = 3.0, z = 3.0},
		Color = {r = 204, g = 204, b = 0},
		Marker = 29,
		Zone = 2,
		BlipInfos = {
		Sprite = 290,
		Color = 3 
		},
		SpawnPoint = {
			Pos = {x = -2266.2 ,y = 3088.65 ,z = 31.96},
			Heading = 67.96,
			Color = {r=0,g=255,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 36
		},
		DeletePoint = {  ---2272.16 3077.85
			Pos = {x = -2272.16,y = 3077.85,z = 31.96},
			Color = {r=255,g=0,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 30
		},
	},
	
	--[[
	Storage_grapeseed = {	--473
		Pos = {x = 2336.52,y = 4859.22,z = 41.81},
		Size  = {x = 3.0, y = 3.0, z = 3.0},
		Color = {r = 204, g = 0, b = 204},
		Marker = 29,
		Zone = 4,
		BlipInfos = {
		Sprite = 267,
		Color = 27
		},
		SpawnPoint = {
			Pos = {x = 2348.62, y = 4883.58, z = 41.81},
			Heading = 67.96,
			Color = {r=0,g=255,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 36
		},
		DeletePoint = {  ---2272.16 3077.85
			Pos = {x = 2352.73 ,y = 4876.04 ,z = 41.83},
			Color = {r=255,g=0,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 30
		},
	},	--]]
	--[[	
	Garage_Teqil = {	
		Pos = {x = -505.84 ,y = 271.32,z = 83.16},
		Size  = {x = 3.0, y = 3.0, z = 3.0},
		Color = {r = 204, g = 204, b = 0},
		Marker = 29,
		Zone = 1,
		BlipInfos = {
		Sprite = 290,
		Color = 3 
		},
		SpawnPoint = {
			Pos = {x = -516.43,y = 276.93,z = 83.06},
			Heading = 226.0,
			Color = {r=0,g=255,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 36
		},
		DeletePoint = {
			Pos = {x = -468.64,y = 267.16,z = 83.17},
			Color = {r=255,g=0,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 30
		}, 	
	},	
	Garage_MirrorPark = {	
		Pos = {x = 1011.1575927734,y = -766.65875244141,z = 57.880554199219},
		Size  = {x = 3.0, y = 3.0, z = 3.0},
		Color = {r = 204, g = 204, b = 0},
		Marker = 29,
		Zone = 1,
		BlipInfos = {
		Sprite = 290,
		Color = 3 
		},
		SpawnPoint = {
			Pos = {x = 1015.5204467773,y = -762.51519775391,z = 57.913143157959},
			Heading = 226.0,
			Color = {r=0,g=255,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 36
		},
		DeletePoint = {
			Pos = {x = 1016.1030883789,y = -770.50787353516,z = 57.913921356201},
			Color = {r=255,g=0,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 30
		}, 	
	},	--]]
	--[[
	Garage_Galaxy = {	
		Pos = {x = 394.54, y = 289.27, z = 102.97},
		Size  = {x = 3.0, y = 3.0, z = 3.0},
		Color = {r = 204, g = 204, b = 0},
		Marker = 29,
		Zone = 1,
		BlipInfos = {
		Sprite = 290,
		Color = 3 
		},
		SpawnPoint = {
			Pos = {x = 378.95, y = 264.4,z = 103.01},
			Heading = 329.0,
			Color = {r=0,g=255,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 36
		},
		DeletePoint = {
			Pos = {x = 386.98, y = 266.37,z = 103.01},
			Color = {r=255,g=0,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 30
		}, 	
	},--]]
--[[
	CastleGarage = {
		Pos = {x = -1646.58, y = -226.03, z = 55.07},  
		Size  = {x = 3.0, y = 3.0, z = 3.0},
		Color = {r = 204, g = 204, b = 0},
		Marker = 29,
		Zone = 1,
		BlipInfos = {
		Sprite = 290,
		Color = 3, 
		},
		SpawnPoint = {
			Pos = {x = -1654.16, y = -235.05,z = 55.00},
			Heading = 78.74,
			Color = {r=0,g=255,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 36
		},
		DeletePoint = {
			Pos = {x = -1646.67, y = -217.96,z = 55.07},
			Color = {r=255,g=0,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 30
		}, 	
	},--]]
	
	Garage_Arena = {
		invisible = true,
		Pos = {x = 2831.83, y = -3906.2, z = 140.09},
		Size  = {x = 3.0, y = 3.0, z = 3.0},
		Color = {r = 204, g = 204, b = 0},
		Marker = 29,
		Zone = 69,
		BlipInfos = {
		Sprite = 290,
		Color = 3 
		},
		SpawnPoint = {
			Pos = {x = 2835.04, y = -3897.49,z = 140.09},
			Heading = 91.67,
			Color = {r=0,g=255,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 36
		},
		DeletePoint = {
			Pos = {x = 2834.95, y = -3914.75,z = 140.09},
			Color = {r=255,g=0,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 30
		}, 	
	},

	Garage_Dirt = {
		invisible = true,
		Pos = {x = 5939.64, y = 795.57, z = 1298.09},
		Size  = {x = 3.0, y = 3.0, z = 3.0},
		Color = {r = 204, g = 204, b = 0},
		Marker = 29,
		Zone = 1,
		BlipInfos = {
		Sprite = 290,
		Color = 3 
		},
		SpawnPoint = {
			Pos = {x = 5945.1, y = 803.57,z = 1298.09},
			Heading = 1.67,
			Color = {r=0,g=255,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 36
		},
		DeletePoint = {
			Pos = {x = 5933.64, y = 802.57, z = 1298.09},
			Color = {r=255,g=0,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 30
		}, 	
	},


 	 island_airport  = {
		
		Pos = {x = 4494.65, y = -4513.81, z = -1.0},
		Size  = {x = 3.0, y = 3.0, z = 3.0},
		Color = {r = 204, g = 204, b = 0},
		Marker = 29,
		Zone = 5,
		BlipInfos = {
		Sprite = 290,
		Color = 3 
		},
		SpawnPoint = {
			Pos = {x = 4500.49, y = -4511.58,z = 4.02},
			Heading = 1.67,
			Color = {r=0,g=255,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 36
		},
		DeletePoint = {
			Pos = {x = 4506.25, y = -4515.78, z = 4.02},
			Color = {r=255,g=0,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 30
		}, 	
	},
	
	
	island_Dock  = {
		
		Pos = {x = 4987.54, y = -5146.68, z = -1.0},
		Size  = {x = 3.0, y = 3.0, z = 3.0},
		Color = {r = 204, g = 204, b = 0},
		Marker = 29,
		Zone = 5,
		BlipInfos = {
		Sprite = 290,
		Color = 3 
		},
		SpawnPoint = {
			Pos = {x = 4983.76, y = -5147.14,z = 2.53},
			Heading = 190.58,
			Color = {r=0,g=255,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 36
		},
		DeletePoint = {
			Pos = {x = 4969.15, y = -5153.64, z = 2.47},
			Color = {r=255,g=0,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 30
		}, 	
	},

}










Config.GaragesMecano = {

--[[
	Bennys = {
		Marker = 1,
		Zone = 1,
		SpawnPoint = {
			Pos = {x = 477.729,y = -1888.856,z = 25.094},
			Heading = 303.0,
			Color = {r=0,g=255,b=255},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 1
		},
		DeletePoint = {
			Pos = {x = 459.733,y = -1890.335,z = 24.776},
			Color = {r=255,g=140,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 1
		}, 	
	},	
	
	LSCUSTOMS = {
		Marker = 2,
		Zone = 1,
		SpawnPoint = {
			Pos = {x = -378.69,y = -106.47,z = 37.6},
			Heading = 246.5,
			Color = {r=0,g=255,b=255},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 1
		},
		DeletePoint = {
			Pos = {x = -383.69,y = -104.6,z = 37.6},
			Color = {r=255,g=140,b=0},
			Size  = {x = 3.0, y = 3.0, z = 3.0},
			Marker = 1
		}, 	
	},	
	--]]
	
	
	
	-- Bennys2 = {
		-- Marker = 1,
		-- SpawnPoint = {
			-- Pos = {x=-190.455, y= -1290.654, z= 30.295},
			-- Color = {r=0,g=255,b=0},
			-- Size  = {x = 3.0, y = 3.0, z = 3.0},
			-- Marker = 1
		-- },
		-- DeletePoint = {
			-- Pos = {x=-190.379, y=-1284.667, z=30.233},
			-- Color = {r=255,g=0,b=0},
			-- Size  = {x = 3.0, y = 3.0, z = 3.0},
			-- Marker = 1
		-- }, 	
	-- },
}