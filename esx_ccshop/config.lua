Config = {} -- DON'T TOUCH

Config.DrawDistance       = 100.0 -- Change the distance before you can see the marker. Less is better performance.
Config.EnableBlips        = true -- Set to false to disable blips.
Config.MarkerType         = 27    -- Change to -1 to disable marker.
Config.MarkerColor        = { r = 255, g = 0, b = 0 } -- Change the marker color.

Config.Locale             = 'en' -- Change the language. Currently available (en or fr).
Config.CooldownMinutes    = 30 -- Minutes between chopping.

Config.CallCops           = true -- Set to true if you want cops to be alerted when chopping is in progress
Config.CallCopsPercent    = 2 -- (min1) if 1 then cops will be called every time=100%, 2=50%, 3=33%, 4=25%, 5=20%.
Config.CopsRequired       = 3

Config.NPCEnable          = true -- Set to false to disable NPC Ped at shop location.
Config.NPCHash			      = 68070371 --Hash of the npc ped. Change only if you know what you are doing.
Config.NPCShop	          = { x = -4.72, y = 6489.94, z = 30.5, h = 230.4 } -- Location of the shop For the npc.

Config.GiveBlack          = true -- Wanna use Blackmoney?

-- Change the time it takes to open door then to break them.
-- Time in Seconde. 1000 = 1 seconde
Config.DoorOpenFrontLeftTime      = 5000
Config.DoorBrokenFrontLeftTime    = 5000
Config.DoorOpenFrontRightTime     = 5000
Config.DoorBrokenFrontRightTime   = 5000
Config.DoorOpenRearLeftTime       = 5000
Config.DoorBrokenRearLeftTime     = 5000
Config.DoorOpenRearRightTime      = 5000
Config.DoorBrokenRearRightTime    = 5000
Config.DoorOpenHoodTime           = 5000
Config.DoorBrokenHoodTime         = 5000
Config.DoorOpenTrunkTime          = 5000
Config.DoorBrokenTrunkTime        = 5000
Config.DeletingVehicleTime        = 10000

Config.Zones = {
    Chopshop = {coords = vector3(-522.87, -1713.99, 18.33), name = _U('map_blip'), color = 49, sprite = 225, radius = 100.0, Pos = { x = -522.87, y = -1713.99, z = 18.33}, Size  = { x = 5.0, y = 5.0, z = 0.5 }, },
    Shop = {coords = vector3(-4.72, 6489.94, 31.5), name = _U('map_blip_shop'), color = 50, sprite = 120, radius = 25.0, Pos = { x = -4.72, y = 6489.94, z = 30.5}, Size  = { x = 3.0, y = 3.0, z = 1.0 }, },
}


Config.SItems = {
    "battery",
	"lowradio",
	"highradio",
	"stockrim",
    "highrim",
	"airbag",
	"steel",
	"plastic",
}

Config.Items = {
    "battery",
	"lowradio",
	"highradio",
	"stockrim",
    "highrim",
    "airbag",
	"elights",
	"leather",
	"bandage",
	"diamond",
	"gold",
	"iron",
	"medkit",
	"c4_bank",
	"blowtorch",
	"screwdriver",
	"nitro",
	"keycard_police",
	"keycard_afp",
	"keycard_biker1",
	"keycard_biker2",
	"keycard_biker3",
	"key",
	"lithium",
	"laptop",
	"applewatch",
	"ipod",
	"methlab",
	"hydrocodone",
	"vicodin",
	"xanax",
	"gauze",
	"mobile_phone",
	"seed_weed",
	"lighter",
	"moneywashp",
	"tv",
	"policeradio",
	"medikit"
	
}

Config.Itemsprice = {
    battery = {low=60, high = 160},
    lowradio = {low=150, high = 230},
	policeradio = {low=1000, high = 3230},
    highradio = {low=400, high = 500},
    stockrim = {low=150, high = 250},
    highrim = {low=350, high = 450},
    airbag = {low=110, high = 230},
	elights = {low=800, high = 1500},
	leather = {low=25, high = 35},
	bandage = {low=10, high = 45},
	diamond = {low=23, high = 45},
	black_diamond = {low=18, high = 50},
	gold = {low=10, high = 35},
	iron = {low = 10, high = 25},
	medkit = {low = 15, high = 50},
	medikit = {low = 15, high = 50},
	c4_bank = {low = 200, high = 500},
	blowtorch = {low = 200, high = 500},
	screwdriver = {low = 200, high = 500},
	nitro = {low = 700, high = 900},
	keycard_police = {low = 500, high= 1500},
	keycard_afp = {low = 500, high= 1500},
	keycard_biker1={low = 200, high= 600},
	keycard_biker2={low = 200, high= 600},
	keycard_biker3={low = 200, high= 600},
	key = {low = 300, high = 500},
	lithium = {low = 300, high = 600},
	laptop = {low = 500, high = 1100},
	applewatch = {low = 200, high = 500},
	ipod = {low = 400, high = 800},
	methlab = {low = 400, high = 900},
	hydrocodone= {low = 200, high = 400},
	vicodin = {low = 200, high = 400},
	xanax = {low = 200, high = 400},
	gauze = {low = 200, high = 400},
	mobile_phone = {low = 500, high = 800},
	seed_weed = {low = 50, high = 80},
	lighter = {low = 5, high = 35},
	moneywashp = {low = 1000, high = 2500},
	tv = {low = 700, high = 1800},
	steel = {low = 700, high = 1900},
	plastic = {low = 700, high = 1900},
	rolex = {low = 800, high = 2000},
	diamond_ring = {low = 3000, high = 6500},
	necklace = {low = 700, high = 1500},
}
