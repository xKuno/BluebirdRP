Config = {}

-- Script locale (only .Lua)
Config.Locale = 'en'



Config.ValePrice = 3000 -- Vale Price

Config.AutoFindFixePhones = false -- Automatically add pay phones as they are found by their models.

Config.FixePhone = {
  -- Mission Row
  ['000'] = { 
    name =  'Police Emergency', 
    coords = vector3(443.74801635742,-988.14910888672,30.68931388855) 
  },
  ['police'] = { 
    name =  'Police Emergency', 
    coords = vector3(443.74801635742,-988.14910888672,30.68931388855)
	},
 ['131444'] = { 
    name =  'Police City Desk', 
    coords = vector3(443.59655761719,-987.99975585938,30.689317703247) 
  },
  
  ['0940'] = { 
      name =  'Bank Harmony', 
	  coords = vector3(1180.6893310547,2708.0007324219,38.087810516357) 
   },
 
--  ['372-9663'] = {
--    name = _U('phone_booth'),
--    coords = { x = 372.305, y = -966.373, z = 28.413 } 
--  },
}

FixePhone = {
  -- Mission Row
  ['000'] = { 
    name =  'Police Emergency', 
    coords = vector3(438.76184082031,-992.11157226562,30.689338684082) 
  },
  ['police'] = { 
    name =  'Police Emergency', 
    coords = vector3(443.74801635742,-988.14910888672,30.68931388855)
	},
 ['131444'] = { 
    name =  'Police City Desk', 
    coords = vector3(443.59655761719,-987.99975585938,30.689317703247) 
  },
    
  ['0940'] = { 
      name =  'Bank Harmony', 
	  coords = vector3(1180.6893310547,2708.0007324219,38.087810516357) 
   },
 ['03019'] = { 
      name =  'Bank Bendigo', 
	  coords = vector3(-105.73166656494,6470.66796875,31.626707077026) 
   },
  ['0814'] = { 
      name =  'Bank Great Ocean Hwy', 
	  coords = vector3(-2961.9260253906,477.25332641602,15.696871757507) 
   },  
   
  ['0575'] = { 
      name =  'Bank Principal Upstairs', 
	  coords = vector3(247.70530700684,209.91931152344,106.28678894043) 
	},  
  ['05725'] = { 
      name =  'Bank Principal Downstairs', 
	  coords = vector3(  264.08743286133,220.06578063965,101.68326568604) 
	},  
	
	
  ['0656'] = { 
      name =  'Bank Rockford Hills', 
	  coords = vector3(-1217.2800292969,-334.28109741211,37.780838012695) 
  },  
  ['0206'] = { 
      name =  'Bank Legion Square', 
	  coords = vector3(144.13528442383,-1039.9658203125,29.367874145508) 
   },  

  ['0697'] = { 
      name =  'Jewellery Store', 
	  coords = vector3(-622.7890625,-229.3119354248,38.057006835938) 
   },  

 



   

  
--  ['372-9663'] = {
--    name = _U('phone_booth'),
--    coords = { x = 372.305, y = -966.373, z = 28.413 } 
--  },
}


--[[
FixePhone = {
  -- Poste de police
 -- ['000'] = { name =  "Police", coords = { x = 441.2, y = -979.7, z = 30.58 }, job = "any" },
 -- ['police'] = { name =  "Police", coords = { x = 441.2, y = -979.7, z = 30.58 } , job = "any"},
  ['000'] = { name =  "Police", coords = vector3(443.57055664062,-979.53704833984,30.689334869385), job="police", type = "E" },
  ['police'] = { name =  "Police", coords = vector3(443.57055664062,-979.53704833984,30.689334869385), job="police", type = "E" }, 
  ['131444'] = { name =  "Police City Desk", coords = vector3(443.59655761719,-987.99975585938,30.689317703247), job="police", type = "C" },
  --['policed1'] = { name =  "Police City Desk", coords = vector3( 441.2,-979.7,30.58), job = "any", type = "A" },
  --['policec1'] = { name =  "Police City Custody", coords = vector3(459.74, -988.84, 24.91), job = "any", type = "A" },
  --['mechanic'] = { name =  "Elite Auto Sports", coords = { x = -1149.95, y = -1714.82, z =  4.45 }, job = "any", type = "C" },
    ['mechanic2'] = { name =  "Grease Monkey Garage", coords = vector3( 773.35,  3566.62,34.99), job = "any", type = "C" },
	['avocat'] = { name =  "Courts Victoria", coords = vector3( 330.25, -1626.21, 32.54 ), job="avocat", type = "C" },
 -- ['1335483'] = { name =  "Elite Auto Sports", coords = { x = -1149.95, y = -1714.82, z =  4.45 }, job = "any", type = "C" },
  --, , 
  ["tequil"] = { name = "Tequi la la", coords = vector3( -560.12, 284.92, 85.38), job="tequil", type = "C"},
  -- Cabine proche du poste de police
  ['008-0001'] = { name = "Telstra Phone Box", coords = vector3(372.25, -965.75, 28.58), job="any" , type = "A"},
  
   ['1133386'] = { name = "Franky's Fun House", coords = vector3(372.25, -965.75, 28.58), job="any" , type = "C"},
  
}

FixePhone2 = {

  ['131444'] = { name =  "Police City Desk", coords = vector3(1854.16,  3690.03, 34.15), job="police", type = "C" },
  

  ['000'] = { name =  "Police", coords = vector3(1854.16, 3690.03, 34.15 ), job="police", type = "A"  },
  ['police'] = { name =  "Police",  coords = vector3(1854.16, 3690.03, 34.15), job="police", type = "A"  }, 
  ['mechanic2'] = { name =  "Grease Monkey Garage", coords = vector3( 772.02, 3584.32, 34.98 ), job = "any", type = "C" },
  
       
} --]]
Config.KeyOpenClose = 244 -- M
Config.KeyTakeCall  = 38  -- E

Config.UseMumbleVoIP = true -- Use Frazzle's Mumble-VoIP Resource (Recomended!) https://github.com/FrazzIe/mumble-voip
Config.UseTokoVoIP   = false

Config.ShowNumberNotification = false -- Show Number or Contact Name when you receive new SMS