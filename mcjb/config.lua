Config = {}
--			General
Config.Locale				= 'en'

--			Settings
--			  Jobs
Config.EnablePlayerJobs		= true		--Enables Jobs for Players to use.
Config.EnablePlayerCook		= true		--Cook gets drinks, makes burgers and fries and gives to clerk both for NPC orders and Player orders.
Config.EnablePlayerClerk	= true		--Clerk receives orders, gives to cook, receives orders from cook, and gives to customer. 				
Config.EnablePlayerDriver	= true		--Driver delivers orders marked for delivery.

Config.EnableNPCWorkers		= false		--NPC Workers are there if player jobs are disabled
Config.EnableNPCOrders		= true		--MUST be false if player jobs are disabled, gives RP NPC orders for players to undertake

Config.CookJobPayMin		= 130
Config.CookJobPayMax		= 160		--The amount the cook is paid per meal made.
Config.CashJobPayMin		= 150
Config.CashJobPayMax		= 160		--The amount the cashier is paid per meal delivered to table.
Config.DelivJobPayMin		= 280		--The amount the delivery driver is paid per delivery.
Config.DelivJobPayMax		= 475

Config.PayDeposit			= true		--If true the below cost will take effect when taking out a work vehicle
Config.VanDepositAmount		= 300		--The amount that it cost to take out the van work vehicle
Config.BikeDepositAmount	= 150		--The amount that it cost to take out the bike work vehicle
Config.CarToSpawn			= 'vwcaddy'
Config.BikeToSpawn			= 'nrg'

Config.EnableMoreWorkMorePay	= false	--Each Time you complete a job, if true you get a pay rise for the next job.

--			Blips
Config.EnableBlips			= true
--		McDonalds Blip	
Config.blipLocationM		= vector2(276.84,-971.98)	--Location
Config.blipLocationMS		= vector2(1704.71,3779.49)
Config.blipIDM				= 78						--ID
Config.blipColorM			= 5							--Color
Config.blipScaleM			= 0.75						--Size
--	  McDonalds Job Blip	
Config.EnableJobBlip		= false						--true means show to all players, false only shows to players who have Mcdonalds Job Title.

Config.blipLocationJ		= vector2(138.78, -1060.86)	--Location
Config.blipLocationJS		= vector2(138.78, -1060.86)	--Location
Config.blipIDJ				= 500						--ID
Config.blipColorJ			= 69						--Color
Config.blipScaleJ			= 0.65						--Size

Config.JobMarkerColor			= {r = 112, g = 255, b = 237, a = 75}	--Job Marker Color Default Cyan
Config.DeliveryMarkerColor		= {r = 120, g = 255, b = 142, a = 75}	--Marker Color Default Green
Config.CarDespawnMarkerColor	= {r = 255, g = 50, b = 50, a = 75}
Config.JobMarkerDistance		= 1.05									--The distance from the center of the marker to enable menu/text
Config.JobExtendedDistance		= 2.5
--		Cook Times
Config.CookDrinkTime		= 10 * 1000		--The time that it takes to make a drink.
Config.CookFriesTime		= 10 * 1000		--The time that it takes to make fries.
Config.CookBurgerTime		= 10 * 1000		--The time that it takes to make a burger.
Config.CookPrepareTime		= 10 * 1000		--The time that it takes to prepare the meal.
--	   Cashier Times
Config.CashOrderTime		= 10 * 1000		--The time that it takes to take an order.
Config.CashMealTime			= 15 * 1000		--The time that it takes to get a prepared meal.
Config.CashDelivTime		= 8 * 1000		--The time that it takes to give the customer the meal.

Config.EnableDowntownDeliveries		= true
Config.EnableBeachSideDeliveries	= false
Config.EnableHighEndDeliveries		= false

Config.Prefix = "^0[^1mmm ^3McDonalds^0]:^4 "



--	   List of Coords

Config.JobMenuCoords		= vector3(279.6308,-979.369,28.425)
Config.JobMenuCoordsS		= vector3(1702.5749511719,3787.0131835938,33.736221313477)

Config.CookBurgerCoords		= vector3(281.363,-978.91,28.422)
Config.CookBurgerCoordsS	= vector3(1695.131,3781.7087,33.736)

Config.CookFriesCoords		= vector3(278.240,-977.6862,28.425)
Config.CookFriesCoordsS		= vector3(1697.34,3785.341,33.736)
Config.CookDrinkCoords		= vector3(283.187,-975.254,28.425)
Config.CookDrinkCoordsS		= vector3(1693.84,3783.92,33.736)
Config.CookPrepareCoords	= vector3(280.12,-978.10,28.42)
Config.CookPrepareCoordsS	= vector3(1694.63,3782.59,33.7362)


Config.CashTakeOrder		= vector3(282.561,-974.5065,28.4257)
Config.CashTakeOrderS		= vector3(1695.91,3780.37,33.7362)
Config.CashTakeOrder1		= vector3(281.022,-974.388,28.4257)
Config.CashTakeOrder1S		= vector3(1697.120,3781.15,33.736)
Config.CashTakeOrder2		= vector3(279.505,-974.4065,28.4257)
Config.CashTakeOrder2S		= vector3(1698.28,3782.04,33.73)
--Config.CashTakeOrder3		= vector3(133.24,-1071.73,28.2)
--Config.CashTakeOrder4		= vector3(132.43,-1073.60,28.2)
--Config.CashTakeOrder5		= vector3(133.83,-1074.63,28.2)
Config.CashCollectMeal		= vector3(280.97,-975.395,29.4257)
Config.CashCollectMealS		= vector3(1699.685,3783.085,33.736)


Config.DeliveryCarSpawn			= {x = 264.38009643555,y = -973.3986,z = 29.331771850586,h = 338.74}
Config.DeliveryCarSpawnMarker	= vector3(270.3631,-964.4562,28.2866)
Config.DeliveryCarDespawn		= vector3(273.1927,-957.233,28.20368576)

Config.DeliveryCarSpawnS	= {x = 1714.7178955078,y = 3784.9125976562,z = 34.709453582764,h = 311.85}
Config.DeliveryCarSpawnMarkerS	= vector3(1711.093,3782.553,33.77874)
Config.DeliveryCarDespawnS		= vector3(1714.9069824219,3787.5749511719,33.702281951904)

Config.minDistance = 3
--	List of Cashier Deliver Points
Config.cashDeliveryPoints = {
	[1] = vector3(272.23376464844,-976.13604736328,28.425777435303),
	[2] = vector3(270.44137573242,-975.16198730469,28.425779342651),
	[3] = vector3(271.5485534668,-972.19781494141,28.425779342651),
	[4] = vector3(279.72927856445,-966.71917724609,28.425777435303),
	[5] = vector3(283.20629882812,-966.80999755859,28.42578125),
	[6] = vector3(283.26690673828,-967.48614501953,28.42578125),
	[7] = vector3(279.90017700195,-967.49719238281,28.42578125),
	[8] = vector3(278.41363525391,-972.40899658203,28.425798416138),
}

Config.cashSandyDeliveryPoints = {
	[1] = vector3(1700.2657470703,3779.8413085938,33.736190795898),
	[2] = vector3(1697.2438964844,3777.7702636719,33.736213684082),
	[3] = vector3(1703.1781005859,3784.3608398438,33.73620223999),
	[4] = vector3(1706.3995361328,3783.2377929688,33.736175537109),
	[5] = vector3(1708.5555419922,3784.6413574219,33.736213684082),
	[6] = vector3(1700.7030029297,3781.9377441406,33.736213684082),
}




--Downtown Delivery Locations
Config.driveDeliveryPoints = {
	[1] = {x = 288.96, y = -1792.33, z = 28},
	[2] = {x = 299.79, y = -1784.21, z = 28},
	[3] = {x = 304.44, y = -1775.45, z = 29},
	[4] = {x = 332.85, y = -1741.05, z = 28},
	[5] = {x = 405.67, y = -1751.25, z = 28},
	[6] = {x = 431.22, y = -1725.63, z = 28},
	[7] = {x = 443.23, y = -1707.17, z = 28.1},
	[8] = {x = 412.74, y = -1855.71, z = 27.5},
	[9] = {x = 385.26, y = -1881.84, z = 26},
	[10] = {x = 368.55, y = -1896.02, z = 25},
	[11] = {x = 324.29, y = -1937.81, z = 25},
	[12] = {x = 295.98, y = -1972.00, z = 23},
	[13] = {x = 273.37, y = -1997.46, z = 20.2},
	[14] = {x = 256.55, y = -2023.67, z = 19.20},
	[15] = {x = 286.91, y = -2034.94, z = 19.77},
	[16] = {x = 312.62, y = -2053.89, z = 21},
	[17] = {x = 332.56, y = -2070.61, z = 21},
	[18] = {x = 302.63, y = -2080.1, z = 17.7},
	[19] = {x = 321.55, y = -2099.77, z = 18.2},
	[20] = vector3(109.37495422363,-1089.8580322266,27.302471160889),
	[21] = vector3(156.04745483398,-1067.2359619141,27.263969421387),
	[22] = vector3(185.18843078613,-1078.3498535156,27.274560928345),
	[23] = vector3(231.87275695801,-1094.8389892578,28.294189453125),
	[24] = vector3(278.44195556641,-1118.2202148438,28.419662475586),
	[25] = vector3(288.04681396484,-1095.0656738281,28.419660568237),
	[26] = vector3(292.08395385742,-1078.5961914062,28.404888153076),
	[27] = vector3(279.06546020508,-1070.5869140625,28.438264846802),
	[28] = vector3(279.06546020508,-1070.5869140625,28.438264846802),
	[29] = vector3(261.30218505859,-1070.4777832031,28.418836593628),
	[30] = vector3(265.21136474609,-981.94360351562,28.361791610718),
	[31] = vector3(127.95339202881,-1028.0587158203,28.357334136963),
	[32] = vector3(73.086479187012,-1027.2294921875,28.475761413574),
	[33] = vector3(57.806568145752,-1003.8500976562,28.357400894165),
	[34] = vector3(43.388607025146,-998.16723632812,28.341241836548),
	[35] = vector3(20.167486190796,-991.10046386719,28.357404708862),
	[36] = vector3(-3.619936466217,-982.96417236328,28.357351303101),
	[37] = vector3(104.95310974121,-933.39965820312,28.809268951416),
	[38] = vector3(121.85985565186,-879.41107177734,30.12308883667),
	[39] = vector3(134.59487915039,-859.65576171875,29.765205383301),
	[40] = vector3(321.10653686523,-823.30139160156,28.267377853394),
	[41] = vector3(329.31420898438,-800.76147460938,28.266496658325),
	[42] = vector3(394.31579589844,-729.5380859375,28.282091140747),
	[43] = vector3(394.45553588867,-806.62469482422,28.291872024536),
	[44] = vector3(392.73583984375,-831.86047363281,28.291687011719),
	
	
	
	
}



Config.SandydriveDeliveryPoints = {
	[1] = vector3(1878.5583496094,3920.6342773438,32.156246185303),
	[2] = vector3(1846.0900878906,3914.490234375,32.466281890869),
	[3] = vector3(1842.0290527344,3928.1857910156,32.320121765137),
	[4] = vector3(1837.4156494141,3906.6604003906,32.236549377441),
	[5] = vector3(1818.4171142578,3897.0988769531,32.726902008057),
	[6] = vector3(1808.912109375,3907.7524414062,32.732158660889),
	[7] = vector3(1832.7774658203,3863.0336914062,32.801704406738),
	[8] = vector3(1830.2578125,3867.5495605469,32.80810546875),
	[9] = vector3(1812.5476074219,3856.1828613281,32.775947570801),
	[10] = vector3(1807.1680908203,3852.7729492188,32.985939025879),
	[11] = vector3(1744.5910644531,3886.1079101562,33.893123626709),
	[12] = vector3(1737.5170898438,3898.634765625,34.559188842773),
	[13] = vector3(1718.8969726562,3885.6430664062,33.903453826904),
	[14] = vector3(1700.0087890625,3866.8764648438,33.903087615967),
	[15] = vector3(1690.2401123047,3867.0046386719,33.905963897705),
	[16] = vector3(1729.7341308594,3849.9519042969,33.722339630127),
	[17] = vector3(1763.4450683594,3824.1901855469,33.767631530762),
	[18] = vector3(1760.0953369141,3821.537109375,33.76734161377),
	[19] = vector3(1733.2291259766,3809.4616699219,33.798809051514),
	[20] = vector3(1742.5620117188,3804.439453125,34.118183135986),
	[21] = vector3(1745.5389404297,3788.1982421875,33.835018157959),
	[22] = vector3(1777.2591552734,3799.5122070312,33.523204803467),
	[23] = vector3(1774.7725830078,3742.6181640625,33.655132293701),
	[24] = vector3(1777.3391113281,3738.1364746094,33.65506362915),
	[25] = vector3(1827.2454833984,3729.4733886719,32.961902618408),
	[26] = vector3(1831.2669677734,3738.3078613281,32.961894989014),
	[27] = vector3(1858.0261230469,3750.4460449219,32.064086914062),
	[28] = vector3(1861.8317871094,3749.6433105469,32.031913757324),
	[29] = vector3(1843.1181640625,3777.6096191406,32.36413192749),
	[30] = vector3(1900.375,3771.7145996094,31.881885528564),
	[31] = vector3(1931.3687744141,3726.6640625,31.844478607178),
	[32] = vector3(1960.6892089844,3741.5258789062,31.343738555908),
	[33] = vector3(2001.3909912109,3779.7946777344,31.180824279785),
	[34] = vector3(2003.9384765625,3790.78125,31.180828094482),
	[35] = vector3(1974.6767578125,3813.8400878906,32.42663192749),
	[36] = vector3(1952.2738037109,3841.9619140625,31.177280426025),
	[37] = vector3(1945.2951660156,3848.1511230469,31.162063598633),
	[38] = vector3(1936.5524902344,3891.462890625,31.747234344482),
	[39] = vector3(1927.2198486328,3898.6799316406,31.523933410645),
	[40] = vector3(1916.3514404297,3908.9733886719,32.441650390625),
	[41] = vector3(1919.7819824219,3914.0646972656,32.441646575928),
	[42] = vector3(1890.0091552734,3928.3161621094,31.926342010498),
	[43] = vector3(1425.0926513672,3671.8696289062,33.171276092529),
	[44] = vector3(1351.5712890625,3610.1354980469,33.871162414551),
	[45] = vector3(1390.6290283203,3604.2729492188,34.980934143066),
	[46] = vector3(961.35736083984,3625.8266601562,32.366691589355),
	[47] = vector3(910.99761962891,3644.3449707031,32.677314758301),
	
	
	
	
	
	
}