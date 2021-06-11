Config              = {}
Config.DrawDistance = 100.0
Config.Locale       = 'en'

Config.JobVehiclePlate = 'WAL' -- Plaque des vehicules du job (maximun 8 caractères)
Config.MaxLetter	   = 2 -- Maximum de lettre par point
Config.MinLetter	   = 0 -- Maximum de lettre par point
Config.Maxparcel		   = 1 -- Maximum de parcel par point
Config.Minparcel		   = 0 -- Maximum de parcel par point

Config.Caution 		   = 100
Config.PricePerLetterMin  = 85
Config.PricePerLetterMax  = 140
Config.PricePerParcelMin   = 100
Config.PricePerParcelMax   = 220


Config.Vehicle = { -- Ajouter les véhicules du métier ici
	"boxville2"
}

Config.Zones = { -- Emplacement des points
	CloakRoom = {
		Pos   = {x = 78.899, y = 111.934, z = 80.1},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 231, g = 76, b = 60},
		Type  = 1
	},

	VehicleSpawner = {
		Pos   = {x = 71.73582458, y = 115.2844, z = 78.1},  
		Size  = {x = 2.0, y = 2.0, z = 1.0},
		Color = {r = 142, g = 68, b = 173},
		Type  = 1
	},

	VehicleSpawnPoint = {
		Pos     = {x = 66.232, y = 121.310, z = 79.112},
		Heading = 160.0, -- Orientation 
		Size    = {x = 3.0, y = 3.0, z = 1.0},
		Type    = -1
	},

	VehicleDeleter = {
		Pos   = {x = 56.015781, y = 101.98659, z = 77.6},
		Size  = {x = 4.0, y = 4.0, z = 1.5},
		Color = {r = 142, g = 68, b = 173},
		Type  = 1
	},

	Distribution = { -- point pr récuperer les parcel & courrier
		Pos   = {x = 115.141, y = 100.649, z = 79.890},
		Size  = {x = 3.0, y = 3.0, z = 1.0},
		Color = {r = 236, g = 240, b = 241},
		Type  = 1
	},
}

Config.Uniforms = { -- Tenue de service
	
	male = {
		['tshirt_1'] = 15,  ['tshirt_2'] = 0,
		['torso_1'] = 9,   ['torso_2'] = 15,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 0,	
		['arms_1'] = 0,	 ['arms_2'] = 0,
		['pants_1'] = 80,   ['pants_2'] = 2,
		['shoes_1'] = 8,   ['shoes_2'] = 2,
		['helmet_1'] = -1,  ['helmet_2'] = 0,
		--['chain_1'] = 12,    ['chain_2'] = 2,
		['ears_1'] = 0,     ['ears_2'] = 0,
		['glasses_1'] = 15,     ['glasses_2'] = 0
	},
	female = {
		['tshirt_1'] = 17,  ['tshirt_2'] = 0,
		['torso_1'] = 14,   ['torso_2'] = 11,
		['decals_1'] = 0,   ['decals_2'] = 0,
		['arms'] = 0, 
		['arms_1'] = 14, ['arms_2'] = 0,
		['pants_1'] = 82,   ['pants_2'] = 2,
		['shoes_1'] = 32,   ['shoes_2'] = 1,
		['helmet_1'] = -1,  ['helmet_2'] = 0,
		['chain_1'] = 0,    ['chain_2'] = 2,
		['ears_1'] = 0,     ['ears_2'] = 0
	}
}


-- Point des livraisons

Config.Livraisons = {
	Richman = {
		Pos = {
			{x = -1129.1517, y = 395.020, z = 69.651, letter = true, parcel = false},
			{x = -1103.568, y = 284.569, z = 63.094, letter = true, parcel = false},
			{x = -1473.558, y = -10.789, z = 54.525, letter = true, parcel = false},
			{x = -1532.2011, y = -37.736, z = 57.381, letter = true, parcel = false},
			{x = -1545.794, y = -33.281, z = 56.891, letter = true, parcel = false},
			{x = -1464.423, y = 51.018, z = 53.988, letter = true, parcel = false},
			{x = -1470.73046875, y = 63.990886688232, z = 51.173046112061, letter = true, parcel = true},
			{x = -1504.2097167969, y = 44.28625869751, z = 53.951641082764, letter = true, parcel = false},
			{x = -1585.7332763672, y = 44.503841400146, z = 59.00085067749, letter = true, parcel = false},
			{x = -1619.6723632813, y = 57.411979675293, z = 59.791728973389, letter = true, parcel = true},
			{x = -1615.3327636719, y = 74.720077514648, z = 59.412998199463, letter = true, parcel = false},
			{x = -1493.3347167969, y = -149.43423461914, z = 50.509246826172, letter = true, parcel = false},
			{x=-1471.2154541015626,y=-134.962646484375,z=50.089839935302737, letter = true, parcel = false},
			{x=-1484.007568359375,y=-225.59017944335938,z=49.011634826660159, letter = true, parcel = true},
			{x=-1488.638427734375,y=-206.81393432617188,z=49.49311828613281, letter = true, parcel = false},
			{x=-1561.45361328125,y=-210.54017639160157,z=54.53590393066406, letter = true, parcel = false},
			{x=-1532.8349609375,y=-275.83685302734377,z=48.72993087768555, letter = true, parcel = false},
			{x=-1566.1619873046876,y=-280.2131652832031,z=47.27570724487305, letter = true, parcel = false},
			{x=-1565.968994140625,y=-232.18902587890626,z=49.46929168701172, letter = true, parcel = true}
		
			
		},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
        Color = {r = 211, g = 84, b = 0},
        Type  = 1
	},

	RockfordHills = {
		Pos = {
			{x = -822.11590576172, y = -28.949552536011, z = 37.660648345947, letter = true, parcel = true},
			{x = -877.12579345703, y = 1.4300217628479, z = 43.068756103516, letter = true, parcel = false},
			{x = -883.50225830078, y = 19.95990562439, z = 43.858791351318, letter = true, parcel = false},
			{x = -904.48303222656, y = 17.959585189819, z = 45.375545501709, letter = true, parcel = true},
			{x = -849.53887939453, y = 103.97817993164, z = 51.921394348145, letter = true, parcel = false},
			{x = -851.21838378906, y = 178.97734069824, z = 68.720985412598, letter = true, parcel = false},
			{x = -923.23107910156, y = 178.72102355957, z = 65.937400817871, letter = true, parcel = false},
			{x = -954.20562744141, y = 177.81230163574, z = 64.367691040039, letter = true, parcel = false},
			{x = -934.73480224609, y = 123.06588745117, z = 55.740001678467, letter = true, parcel = false},
			{x = -950.38397216797, y = 125.10294342041, z = 56.440544128418, letter = true, parcel = true},
			{x = -979.54205322266, y = 147.44619750977, z = 59.907157897949, letter = true, parcel = false},
			{x = -1046.2899169922, y = 209.78942871094, z = 62.423046112061, letter = true, parcel = false},			
		},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
        Color = {r = 46, g = 204, b = 113},
        Type  = 1
	},

	Vespucci = {
		Pos = {
			{x = -1091.9807128906, y = -923.61407470703, z = 2.1418874263763, letter = true, parcel = false},
			{x = -1038.87109375, y = -891.09130859375, z = 4.2144069671631, letter = true, parcel = true},
			{x = -948.60479736328, y = -898.53344726563, z = 1.1630630493164, letter = true, parcel = true},
			{x = -919.51391601563, y = -952.21594238281, z = 1.162935256958, letter = true, parcel = false},
			{x = -933.55932617188, y = -1081.3103027344, z = 1.1503119468689, letter = true, parcel = false},
			{x = -954.99682617188, y = -1083.3701171875, z = 1.1503119468689, letter = true, parcel = false},
			{x = -1025.9075927734, y = -1129.6602783203, z = 1.1702592372894, letter = true, parcel = true},
			{x = -1061.0762939453, y = -1155.3466796875, z = 1.1118972301483, letter = true, parcel = false},
			{x = -1253.8918457031, y = -1330.2947998047, z = 3.0237193107605, letter = true, parcel = true},
			{x = -1106.5417480469, y = -1534.9737548828, z = 3.3808641433716, letter = true, parcel = false},
			{x = -1116.1688232422, y = -1575.6658935547, z = 3.3870568275452, letter = true, parcel = false},
			
			
		},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
        Color = {r = 52, g = 152, b = 219},
        Type  = 1
	},

	SLS = {
		Pos = {
			{x = -50.930358886719, y = -1783.6270751953, z = 27.300802230835, letter = true, parcel = false},
			{x = 13.642129898071, y = -1850.1307373047, z = 23.055648803711, letter = true, parcel = false},
			{x = 110.53960418701, y = -1956.0163574219, z = 19.751287460327, letter = true, parcel = false},
			{x = 151.61938476563, y = -1896.3343505859, z = 22.092262268066, letter = true, parcel = false},
			{x = 158.33076477051, y = -1876.6044921875, z = 22.980903625488, letter = true, parcel = true},
			{x = 221.90466308594, y = -1720.8103027344, z = 28.202871322632, letter = true, parcel = false},
			{x = 249.87113952637, y = -1730.8135986328, z = 28.669330596924, letter = true, parcel = false},
			{x = 263.07949829102, y = -1704.0960693359, z = 28.205499649048, letter = true, parcel = false},
			{x = 332.95666503906, y = -1742.1281738281, z = 28.730531692505, letter = true, parcel = false},
			{x = 326.57717895508, y = -1763.9366455078, z = 28.015428543091, letter = true, parcel = false},
			{x = 321.9792175293, y = -1838.9698486328, z = 26.227586746216, letter = true, parcel = false},
			{x = 440.62481689453, y = -1840.9602050781, z = 26.871042251587, letter = true, parcel = false},
			{x = 385.88714599609, y = -1882.3186035156, z = 24.838005065918, letter = true, parcel = false},
			{x = -86.579170227051, y = -1274.9234619141, z = 28.29808807373, letter = true, parcel = false},
			{x = -86.579170227051, y = -1274.9234619141, z = 28.29808807373, letter = true, parcel = true},
			{x = -121.39896392822, y = -1290.6066894531, z = 29.335803985596, letter = true, parcel = true},
			{x = -229.55625915527, y = -1377.3094482422, z = 29.258224487305, letter = true, parcel = false},
			{x = 252.50109863281, y = -1721.5405273438, z = 28.278797149658, letter = true, parcel = true},
			{x = 221.89227294922, y = -1705.4808349, z = 28.2836112976, letter = true, parcel = true},

		},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
        Color = {r = 241, g = 196, b = 15},
        Type  = 1
    }

}
