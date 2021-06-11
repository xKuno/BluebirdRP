local Keys = {
    ["ESC"] = 322,
    ["F1"] = 288,
    ["F2"] = 289,
    ["F3"] = 170,
    ["F5"] = 166,
    ["F6"] = 167,
    ["F7"] = 168,
    ["F8"] = 169,
    ["F9"] = 56,
    ["F10"] = 57,
    ["~"] = 243,
    ["1"] = 157,
    ["2"] = 158,
    ["3"] = 160,
    ["4"] = 164,
    ["5"] = 165,
    ["6"] = 159,
    ["7"] = 161,
    ["8"] = 162,
    ["9"] = 163,
    ["-"] = 84,
    ["="] = 83,
    ["BACKSPACE"] = 177,
    ["TAB"] = 37,
    ["Q"] = 44,
    ["W"] = 32,
    ["E"] = 38,
    ["R"] = 45,
    ["T"] = 245,
    ["Y"] = 246,
    ["U"] = 303,
    ["P"] = 199,
    ["["] = 39,
    ["]"] = 40,
    ["ENTER"] = 18,
    ["CAPS"] = 137,
    ["A"] = 34,
    ["S"] = 8,
    ["D"] = 9,
    ["F"] = 23,
    ["G"] = 47,
    ["H"] = 74,
    ["K"] = 311,
    ["L"] = 182,
    ["LEFTSHIFT"] = 21,
    ["Z"] = 20,
    ["X"] = 73,
    ["C"] = 26,
    ["V"] = 0,
    ["B"] = 29,
    ["N"] = 249,
    ["M"] = 244,
    [","] = 82,
    ["."] = 81,
    ["-"] = 84,
    ["LEFTCTRL"] = 36,
    ["LEFTALT"] = 19,
    ["SPACE"] = 22,
    ["RIGHTCTRL"] = 70,
    ["HOME"] = 213,
    ["PAGEUP"] = 10,
    ["PAGEDOWN"] = 11,
    ["DELETE"] = 178,
    ["LEFT"] = 174,
    ["RIGHT"] = 175,
    ["TOP"] = 27,
    ["DOWN"] = 173,
    ["NENTER"] = 201,
    ["N4"] = 108,
    ["N5"] = 60,
    ["N6"] = 107,
    ["N+"] = 96,
    ["N-"] = 97,
    ["N7"] = 117,
    ["N8"] = 61,
    ["N9"] = 118
}

Config = {}

Config.CheckOwnership = false -- If true, Only owner of vehicle can store items in trunk.
Config.AllowPolice = true -- If true, police will be able to search players' trunks.

Config.Locale = "en"

Config.OpenKey = Keys["-"]

-- Limit, unit can be whatever you want. Originally grams (as average people can hold 25kg)
Config.Limit = 30000

-- Default weight for an item:
-- weight == 0 : The item do not affect character inventory weight
-- weight > 0 : The item cost place on inventory
-- weight < 0 : The item add place on inventory. Smart people will love it.
Config.DefaultWeight = 10



Config.localWeight = {
	bread = 125,
	water = 330,
	sandwich = 150,
	repairkit = 10000,
	fixkit = 10000,
	chocolate = 300,
	redbull = 220,
	icetea = 220,
	cupcake = 20,
	milk = 290,
	beer = 300,
	cocacola = 220,
	wine = 300, -- poid poir une munnition
	black_money = 1, -- poids pour un argent
	money = 1,
	stone = 9000,
	washed_stone = 7000,
	gold = 100,
	copper = 150,
	iron = 160,
	diamond = 10,
	wood = 500,
	cutted_wood = 400,
	packaged_plank = 50,
	drpepper = 100,
	packaged_chicken = 200,
	fish = 10,
	medkit = 1250,
	WEAPON_PETROLCAN = 1,
	WEAPON_FIREEXTINGUISHER = 1,
	weapon_advancedrifle  = 2000 ,
	weapon_appistol  = 2000 ,
	weapon_assaultrifle  = 2000 ,
	weapon_assaultsmg  = 2000 ,
	weapon_autoshotgun  = 2000 ,
	weapon_ball  = 2000 ,
	weapon_bat  = 2000 ,
	weapon_battleaxe  = 2000 ,
	weapon_bottle  = 2000 ,
	weapon_bullpuprifle  = 2000 ,
	weapon_bullpupshotgun  = 2000 ,
	weapon_bzgas  = 2000 ,
	weapon_carbinerifle  = 2000 ,
	weapon_combatmg  = 2000 ,
	weapon_combatpdw  = 2000 ,
	weapon_combatpistol  = 2000 ,
	weapon_compactlauncher  = 2000 ,
	weapon_compactrifle  = 2000 ,
	weapon_crowbar  = 2000 ,
	weapon_dagger  = 2000 ,
	weapon_dbshotgun  = 2000 ,
	weapon_digiscanner  = 2000 ,
	weapon_doubleaction  = 2000 ,
	weapon_fireextinguisher  = 2000 ,
	weapon_firework  = 2000 ,
	weapon_flare  = 2000 ,
	weapon_flaregun  = 2000 ,
	weapon_flashlight  = 2000 ,
	weapon_garbagebag  = 2000 ,
	weapon_golfclub  = 2000 ,
	weapon_grenade  = 2000 ,
	weapon_grenadelauncher  = 2000 ,
	weapon_gusenberg  = 2000 ,
	weapon_hammer  = 2000 ,
	weapon_handcuffs  = 2000 ,
	weapon_hatchet  = 2000 ,
	weapon_heavypistol  = 2000 ,
	weapon_heavyshotgun  = 2000 ,
	weapon_heavysniper  = 2000 ,
	weapon_hominglauncher  = 2000 ,
	weapon_knife  = 2000 ,
	weapon_knuckle  = 2000 ,
	weapon_machete  = 2000 ,
	weapon_machinepistol  = 2000 ,
	weapon_marksmanpistol  = 2000 ,
	weapon_marksmanrifle  = 2000 ,
	weapon_mg  = 2000 ,
	weapon_microsmg  = 2000 ,
	weapon_minigun  = 2000 ,
	weapon_minismg  = 2000 ,
	weapon_molotov  = 2000 ,
	weapon_musket  = 2000 ,
	weapon_nightstick  = 2000 ,
	weapon_petrolcan  = 2000 ,
	weapon_pipebomb  = 2000 ,
	weapon_pistol  = 2000 ,
	weapon_pistol50  = 2000 ,
	weapon_poolcue  = 2000 ,
	weapon_proxmine  = 2000 ,
	weapon_pumpshotgun  = 2000 ,
	weapon_railgun  = 2000 ,
	weapon_remotesniper  = 2000 ,
	weapon_revolver  = 2000 ,
	weapon_rpg  = 2000 ,
	weapon_sawnoffshotgun  = 2000 ,
	weapon_smg  = 2000 ,
	weapon_smokegrenade  = 2000 ,
	weapon_sniperrifle  = 2000 ,
	weapon_snowball  = 2000 ,
	weapon_snspistol  = 2000 ,
	weapon_specialcarbine  = 2000 ,
	weapon_stickybomb  = 2000 ,
	weapon_stinger  = 2000 ,
	weapon_stungun  = 2000 ,
	weapon_switchblade  = 2000 ,
	weapon_vintagepistol  = 2000 ,
	weapon_weapon_assaultshotgun  = 2000 ,
	weapon_wrench  = 2000 ,
}



Config.VehicleLimito = {}
Config.VehicleLimito[tostring(`tug`)] = 5000000
Config.VehicleLimito[tostring(`rumpo`)] = 4000000
Config.VehicleLimito[tostring(`paradise`)] = 4000000
Config.VehicleLimito[tostring(`rumpo3`)] = 4000000
Config.VehicleLimito[tostring(`dinghy2`)] = 4000000
Config.VehicleLimito[tostring(`dinghy4`)] = 4000000
Config.VehicleLimito[tostring(`mower`)] = 5000
Config.VehicleLimito[tostring(`caddy`)] = 5000
Config.VehicleLimito[tostring(`forklift`)] = 5000
Config.VehicleLimito[tostring(`rallytruck`)] = 5000000
Config.VehicleLimito[tostring(`pounder`)] = 5000000



Config.VehicleLimit = {
    [0] = 60000, --Compact
    [1] = 90000, --Sedan
    [2] = 100000, --SUV
    [3] = 60000, --Coupes
    [4] = 60000, --Muscle
    [5] = 40000, --Sports Classics
    [6] = 40000, --Sports
    [7] = 40000, --Super
    [8] = 20000, --Motorcycles
    [9] = 100000, --Off-road
    [10] = 1900000, --Industrial
    [11] = 900000, --Utility
    [12] = 900000, --Vans
    [13] = 0, --Cycles
    [14] = 90000, --Boats
    [15] = 20000, --Helicopters
    [16] = 0, --Planes
    [17] = 80000, --Service
    [18] = 300000, --Emergency
    [19] = 0, --Military
    [20] = 5500000, --Commercial
    [21] = 0, --Trains
}


Config.VehicleLimitGBo = {
}

Config.VehicleLimitGBo[tostring(`seashark`)] = 2500
Config.VehicleLimitGBo[tostring(`seashark2`)] = 2500
Config.VehicleLimitGBo[tostring(`seashark3`)] = 2500

Config.VehicleLimitGB = {
    [0] = 5500, --Compact
    [1] = 5500, --Sedan
    [2] = 5500, --SUV
    [3] = 5500, --Coupes
    [4] = 5500, --Muscle
    [5] = 5500, --Sports Classics
    [6] = 5500, --Sports
    [7] = 5500, --Super
    [8] = 5500, --Motorcycles
    [9] = 5500, --Off-road
    [10] = 5500, --Industrial
    [11] = 5500, --Utility
    [12] = 5500, --Vans
    [13] = 0, --Cycles
    [14] = 70000, --Boats
    [15] = 5500, --Helicopters
    [16] = 70000, --Planes
    [17] = 5500, --Service
    [18] = 10500, --Emergency
    [19] = 5500, --Military
    [20] = 5500, --Commercial
    [21] = 5500, --Trains
}

Config.VehiclePlate = {
    taxi = "TAXI",
    cop = "LSPD",
    ambulance = "EMS0",
    mecano = "MECA"
}


Config.Weapons = {

	{
		name = 'WEAPON_KNIFE',
		label = _U('weapon_knife'),
		components = {}
	},

	{
		name = 'WEAPON_NIGHTSTICK',
		label = _U('weapon_nightstick'),
		components = {}
	},

	{
		name = 'WEAPON_HAMMER',
		label = _U('weapon_hammer'),
		components = {}
	},

	{
		name = 'WEAPON_BAT',
		label = _U('weapon_bat'),
		components = {}
	},

	{
		name = 'WEAPON_GOLFCLUB',
		label = _U('weapon_golfclub'),
		components = {}
	},

	{
		name = 'WEAPON_CROWBAR',
		label = _U('weapon_crowbar'),
		components = {}
	},

	{
		name = 'WEAPON_PISTOL',
		label = _U('weapon_pistol'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_PISTOL_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_PISTOL_CLIP_02') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_PI_FLSH') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP_02') },
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_PISTOL_VARMOD_LUXE') }
		}
	},

	{
		name = 'WEAPON_COMBATPISTOL',
		label = _U('weapon_combatpistol'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_COMBATPISTOL_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_COMBATPISTOL_CLIP_02') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_PI_FLSH') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP') },
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_COMBATPISTOL_VARMOD_LOWRIDER') }
		}
	},

	{
		name = 'WEAPON_APPISTOL',
		label = _U('weapon_appistol'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_APPISTOL_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_APPISTOL_CLIP_02') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_PI_FLSH') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP') },
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_APPISTOL_VARMOD_LUXE') }
		}
	},

	{
		name = 'WEAPON_PISTOL50',
		label = _U('weapon_pistol50'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_PISTOL50_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_PISTOL50_CLIP_02') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_PI_FLSH') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02') },
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_PISTOL50_VARMOD_LUXE') }
		}
	},

	{
		name = 'WEAPON_REVOLVER',
		label = _U('weapon_revolver'),
		components = {}
	},

	{
		name = 'WEAPON_SNSPISTOL',
		label = _U('weapon_snspistol'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_SNSPISTOL_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_SNSPISTOL_CLIP_02') },
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_SNSPISTOL_VARMOD_LOWRIDER') }
		}
	},

	{
		name = 'WEAPON_HEAVYPISTOL',
		label = _U('weapon_heavypistol'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_HEAVYPISTOL_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_HEAVYPISTOL_CLIP_02') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_PI_FLSH') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP') },
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_HEAVYPISTOL_VARMOD_LUXE') }
		}
	},

	{
		name = 'WEAPON_VINTAGEPISTOL',
		label = _U('weapon_vintagepistol'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_VINTAGEPISTOL_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_VINTAGEPISTOL_CLIP_02') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP') }
		}
	},

	{
		name = 'WEAPON_MICROSMG',
		label = _U('weapon_microsmg'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_MICROSMG_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_MICROSMG_CLIP_02') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_PI_FLSH') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02') },
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_MICROSMG_VARMOD_LUXE') }
		}
	},

	{
		name = 'WEAPON_SMG',
		label = _U('weapon_smg'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_SMG_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_SMG_CLIP_02') },
			{ name = 'clip_drum', label = _U('component_clip_drum'), hash = GetHashKey('COMPONENT_SMG_CLIP_03') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO_02') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP') },
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_SMG_VARMOD_LUXE') }
		}
	},

	{
		name = 'WEAPON_ASSAULTSMG',
		label = _U('weapon_assaultsmg'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_ASSAULTSMG_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_ASSAULTSMG_CLIP_02') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02') },
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_ASSAULTSMG_VARMOD_LOWRIDER') }
		}
	},

	{
		name = 'WEAPON_MINISMG',
		label = _U('weapon_minismg'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_MINISMG_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_MINISMG_CLIP_02') }
		}
	},

	{
		name = 'WEAPON_MACHINEPISTOL',
		label = _U('weapon_machinepistol'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_MACHINEPISTOL_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_MACHINEPISTOL_CLIP_02') },
			{ name = 'clip_drum', label = _U('component_clip_drum'), hash = GetHashKey('COMPONENT_MACHINEPISTOL_CLIP_03') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_PI_SUPP') }
		}
	},

	{
		name = 'WEAPON_COMBATPDW',
		label = _U('weapon_combatpdw'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_COMBATPDW_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_COMBATPDW_CLIP_02') },
			{ name = 'clip_drum', label = _U('component_clip_drum'), hash = GetHashKey('COMPONENT_COMBATPDW_CLIP_03') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_SMALL') }
		}
	},
	
	{
		name = 'WEAPON_PUMPSHOTGUN',
		label = _U('weapon_pumpshotgun'),
		components = {
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_SR_SUPP') },
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_PUMPSHOTGUN_VARMOD_LOWRIDER') }
		}
	},

	{
		name = 'WEAPON_SAWNOFFSHOTGUN',
		label = _U('weapon_sawnoffshotgun'),
		components = {
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_SAWNOFFSHOTGUN_VARMOD_LUXE') }
		}
	},

	{
		name = 'WEAPON_ASSAULTSHOTGUN',
		label = _U('weapon_assaultshotgun'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_ASSAULTSHOTGUN_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_ASSAULTSHOTGUN_CLIP_02') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') }
		}
	},

	{
		name = 'WEAPON_BULLPUPSHOTGUN',
		label = _U('weapon_bullpupshotgun'),
		components = {
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') }
		}
	},

	{
		name = 'WEAPON_HEAVYSHOTGUN',
		label = _U('weapon_heavyshotgun'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_HEAVYSHOTGUN_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_HEAVYSHOTGUN_CLIP_02') },
			{ name = 'clip_drum', label = _U('component_clip_drum'), hash = GetHashKey('COMPONENT_HEAVYSHOTGUN_CLIP_03') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') }
		}
	},

	{
		name = 'WEAPON_ASSAULTRIFLE',
		label = _U('weapon_assaultrifle'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_02') },
			{ name = 'clip_drum', label = _U('component_clip_drum'), hash = GetHashKey('COMPONENT_ASSAULTRIFLE_CLIP_03') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MACRO') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') },
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_ASSAULTRIFLE_VARMOD_LUXE') }
		}
	},

	{
		name = 'WEAPON_CARBINERIFLE',
		label = _U('weapon_carbinerifle'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_CARBINERIFLE_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_CARBINERIFLE_CLIP_02') },
			{ name = 'clip_box', label = _U('component_clip_box'), hash = GetHashKey('COMPONENT_CARBINERIFLE_CLIP_03') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MEDIUM') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') },
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_CARBINERIFLE_VARMOD_LUXE') }
		}
	},

	{
		name = 'WEAPON_ADVANCEDRIFLE',
		label = _U('weapon_advancedrifle'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_ADVANCEDRIFLE_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_ADVANCEDRIFLE_CLIP_02') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_SMALL') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP') },
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_ADVANCEDRIFLE_VARMOD_LUXE') }
		}
	},

	{
		name = 'WEAPON_SPECIALCARBINE',
		label = _U('weapon_specialcarbine'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_SPECIALCARBINE_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_SPECIALCARBINE_CLIP_02') },
			{ name = 'clip_drum', label = _U('component_clip_drum'), hash = GetHashKey('COMPONENT_SPECIALCARBINE_CLIP_03') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MEDIUM') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') },
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_SPECIALCARBINE_VARMOD_LOWRIDER') }
		}
	},

	{
		name = 'WEAPON_BULLPUPRIFLE',
		label = _U('weapon_bullpuprifle'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_BULLPUPRIFLE_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_BULLPUPRIFLE_CLIP_02') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_SMALL') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') },
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_BULLPUPRIFLE_VARMOD_LOW') }
		}
	},

	{
		name = 'WEAPON_COMPACTRIFLE',
		label = _U('weapon_compactrifle'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_COMPACTRIFLE_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_COMPACTRIFLE_CLIP_02') },
			{ name = 'clip_drum', label = _U('component_clip_drum'), hash = GetHashKey('COMPONENT_COMPACTRIFLE_CLIP_03') }
		}
	},

	{
		name = 'WEAPON_MG',
		label = _U('weapon_mg'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_MG_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_MG_CLIP_02') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_SMALL_02') },
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_MG_VARMOD_LOWRIDER') }
		}
	},

	{
		name = 'WEAPON_COMBATMG',
		label = _U('weapon_combatmg'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_COMBATMG_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_COMBATMG_CLIP_02') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_MEDIUM') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') },
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_COMBATMG_VARMOD_LOWRIDER') }
		}
	},

	{
		name = 'WEAPON_GUSENBERG',
		label = _U('weapon_gusenberg'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_GUSENBERG_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_GUSENBERG_CLIP_02') },
		}
	},

	{
		name = 'WEAPON_SNIPERRIFLE',
		label = _U('weapon_sniperrifle'),
		components = {
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_LARGE') },
			{ name = 'scope_advanced', label = _U('component_scope_advanced'), hash = GetHashKey('COMPONENT_AT_SCOPE_MAX') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP_02') },
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_SNIPERRIFLE_VARMOD_LUXE') }
		}
	},

	{
		name = 'WEAPON_HEAVYSNIPER',
		label = _U('weapon_heavysniper'),
		components = {
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_LARGE') },
			{ name = 'scope_advanced', label = _U('component_scope_advanced'), hash = GetHashKey('COMPONENT_AT_SCOPE_MAX') }
		}
	},

	{
		name = 'WEAPON_MARKSMANRIFLE',
		label = _U('weapon_marksmanrifle'),
		components = {
			{ name = 'clip_default', label = _U('component_clip_default'), hash = GetHashKey('COMPONENT_MARKSMANRIFLE_CLIP_01') },
			{ name = 'clip_extended', label = _U('component_clip_extended'), hash = GetHashKey('COMPONENT_MARKSMANRIFLE_CLIP_02') },
			{ name = 'flashlight', label = _U('component_flashlight'), hash = GetHashKey('COMPONENT_AT_AR_FLSH') },
			{ name = 'scope', label = _U('component_scope'), hash = GetHashKey('COMPONENT_AT_SCOPE_LARGE_FIXED_ZOOM') },
			{ name = 'suppressor', label = _U('component_suppressor'), hash = GetHashKey('COMPONENT_AT_AR_SUPP') },
			{ name = 'grip', label = _U('component_grip'), hash = GetHashKey('COMPONENT_AT_AR_AFGRIP') },
			{ name = 'luxary_finish', label = _U('component_luxary_finish'), hash = GetHashKey('COMPONENT_MARKSMANRIFLE_VARMOD_LUXE') }
		}
	},

	{
		name = 'WEAPON_GRENADELAUNCHER',
		label = _U('weapon_grenadelauncher'),
		components = {}
	},

	{
		name = 'WEAPON_RPG',
		label = _U('weapon_rpg'),
		components = {}
	},

	{
		name = 'WEAPON_STINGER',
		label = _U('weapon_stinger'),
		components = {}
	},

	{
		name = 'WEAPON_MINIGUN',
		label = _U('weapon_minigun'),
		components = {}
	},

	{
		name = 'WEAPON_GRENADE',
		label = _U('weapon_grenade'),
		components = {}
	},

	{
		name = 'WEAPON_STICKYBOMB',
		label = _U('weapon_stickybomb'),
		components = {}
	},

	{
		name = 'WEAPON_SMOKEGRENADE',
		label = _U('weapon_smokegrenade'),
		components = {}
	},

	{
		name = 'WEAPON_BZGAS',
		label = _U('weapon_bzgas'),
		components = {}
	},

	{
		name = 'WEAPON_MOLOTOV',
		label = _U('weapon_molotov'),
		components = {}
	},

	{
		name = 'WEAPON_FIREEXTINGUISHER',
		label = _U('weapon_fireextinguisher'),
		components = {}
	},

	{
		name = 'WEAPON_PETROLCAN',
		label = _U('weapon_petrolcan'),
		components = {}
	},

	{
		name = 'WEAPON_DIGISCANNER',
		label = _U('weapon_digiscanner'),
		components = {}
	},

	{
		name = 'WEAPON_BALL',
		label = _U('weapon_ball'),
		components = {}
	},

	{
		name = 'WEAPON_BOTTLE',
		label = _U('weapon_bottle'),
		components = {}
	},

	{
		name = 'WEAPON_DAGGER',
		label = _U('weapon_dagger'),
		components = {}
	},

	{
		name = 'WEAPON_FIREWORK',
		label = _U('weapon_firework'),
		components = {}
	},

	{
		name = 'WEAPON_MUSKET',
		label = _U('weapon_musket'),
		components = {}
	},

	{
		name = 'WEAPON_STUNGUN',
		label = _U('weapon_stungun'),
		components = {}
	},

	{
		name = 'WEAPON_HOMINGLAUNCHER',
		label = _U('weapon_hominglauncher'),
		components = {}
	},

	{
		name = 'WEAPON_PROXMINE',
		label = _U('weapon_proxmine'),
		components = {}
	},

	{
		name = 'WEAPON_SNOWBALL',
		label = _U('weapon_snowball'),
		components = {}
	},

	{
		name = 'WEAPON_FLAREGUN',
		label = _U('weapon_flaregun'),
		components = {}
	},

	{
		name = 'WEAPON_GARBAGEBAG',
		label = _U('weapon_garbagebag'),
		components = {}
	},

	{
		name = 'WEAPON_HANDCUFFS',
		label = _U('weapon_handcuffs'),
		components = {}
	},

	{
		name = 'WEAPON_MARKSMANPISTOL',
		label = _U('weapon_marksmanpistol'),
		components = {}
	},

	{
		name = 'WEAPON_KNUCKLE',
		label = _U('weapon_knuckle'),
		components = {}
	},

	{
		name = 'WEAPON_HATCHET',
		label = _U('weapon_hatchet'),
		components = {}
	},

	{
		name = 'WEAPON_RAILGUN',
		label = _U('weapon_railgun'),
		components = {}
	},

	{
		name = 'WEAPON_MACHETE',
		label = _U('weapon_machete'),
		components = {}
	},

	{
		name = 'WEAPON_SWITCHBLADE',
		label = _U('weapon_switchblade'),
		components = {}
	},

	{
		name = 'WEAPON_DBSHOTGUN',
		label = _U('weapon_dbshotgun'),
		components = {}
	},

	{
		name = 'WEAPON_AUTOSHOTGUN',
		label = _U('weapon_autoshotgun'),
		components = {}
	},

	{
		name = 'WEAPON_BATTLEAXE',
		label = _U('weapon_battleaxe'),
		components = {}
	},

	{
		name = 'WEAPON_COMPACTLAUNCHER',
		label = _U('weapon_compactlauncher'),
		components = {}
	},

	{
		name = 'WEAPON_PIPEBOMB',
		label = _U('weapon_pipebomb'),
		components = {}
	},

	{
		name = 'WEAPON_POOLCUE',
		label = _U('weapon_poolcue'),
		components = {}
	},

	{
		name = 'WEAPON_WRENCH',
		label = _U('weapon_wrench'),
		components = {}
	},

	{
		name = 'WEAPON_FLASHLIGHT',
		label = _U('weapon_flashlight'),
		components = {}
	},

	{
		name = 'GADGET_NIGHTVISION',
		label = _U('gadget_nightvision'),
		components = {}
	},

	{
		name = 'GADGET_PARACHUTE',
		label = _U('gadget_parachute'),
		components = {}
	},

	{
		name = 'WEAPON_FLARE',
		label = _U('weapon_flare'),
		components = {}
	},

	{
		name = 'WEAPON_DOUBLEACTION',
		label = _U('weapon_doubleaction'),
		components = {}
	}

}
