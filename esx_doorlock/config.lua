Config = {}
Config.Locale = 'en'

Config.DoorList = {

	--
	-- Mission Row First Floor
	--

	--Front Entrance Perim

	{
	 objName = -165604314,
	objCoords  = {x = 434.71017456055, y = -980.82727050781, z = 30.800775527954 },
	textCoords  = {x = 434.71017456055, y = -980.82727050781, z = 30.800775527954 },
	fixedpos = vector3(0, -0, -90.00002),
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = false,
	distance = 3,
	}
	,
	{
	 objName = 1388858739,
	objCoords  = {x = 434.71200561523, y = -983.06219482422, z = 30.800775527954 },
	textCoords  = {x = 434.71200561523, y = -983.06219482422, z = 30.800775527954 },
	fixedpos = vector3(-0, -0, -89.99997),
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = false,
	distance = 3,
	},

	--Side Perim

	{
	 objName = 1388858739,
	objCoords  = {x = 439.00857543945, y = -998.68127441406, z = 30.79962348938 },
	textCoords  = {x = 439.00857543945, y = -998.68127441406, z = 30.79962348938 },
	fixedpos = vector3(0, -0, 180),
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = true,
	distance = 3,
	autolock = 8000,
	}
	,
	{
	 objName = -165604314,
	objCoords  = {x = 441.24270629883, y = -998.68127441406, z = 30.79962348938 },
	textCoords  = {x = 441.24270629883, y = -998.68127441406, z = 30.79962348938 },
	fixedpos = vector3(0, -0, 180),
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = true,
	distance = 3,
	autolock = 8000,
	},
	{
	 objName = 1388858739,
	objCoords  = {x = 441.59939575195, y = -998.68127441406, z = 30.79962348938 },
	textCoords  = {x = 441.59939575195, y = -998.68127441406, z = 30.79962348938 },
	fixedpos = vector3(0, -0, -180),
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = true,
	distance = 3,
	autolock = 8000,
	},
	{
	 objName = -165604314,
	objCoords  = {x = 443.83966064453, y = -998.68127441406, z = 30.79962348938 },
	textCoords  = {x = 443.83966064453, y = -998.68127441406, z = 30.79962348938 },
	fixedpos = vector3(0, -0, 180),
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = true,
	distance = 3,
	autolock = 8000,
	},
	--Internal Front
	{
	 objName = 165994623,
	objCoords  = {x = 441.76644897461, y = -994.27722167969, z = 30.818710327148 },
	textCoords  = {x = 441.76644897461, y = -994.27722167969, z = 30.818710327148 },
	fixedpos = vector3(-2.748292e-15, -1.701781e-16, -178.8502),
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = true,
	autolock = 6000,
	},

	--Stair Well

	{
	 objName = 165994623,
	objCoords  = {x = 468.17724609375, y = -991.84173583984, z = 30.821771621704 },
	textCoords  = {x = 468.17724609375, y = -991.84173583984, z = 30.821771621704 },
	fixedpos = vector3(0, -0, 180),
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = true,
	autolock = 8000,
	}
	,
	{
	 objName = 165994623,
	objCoords  = {x = 468.17797851562, y = -991.85668945312, z = 25.856079101562 },
	textCoords  = {x = 468.17797851562, y = -991.85668945312, z = 25.856079101562 },
	fixedpos = vector3(0, -0, -180),
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = true,
	autolock = 8000,
	},
	{
	 objName = 165994623,
	objCoords  = {x = 468.17840576172, y = -991.79418945312, z = 34.341567993164 },
	textCoords  = {x = 468.17840576172, y = -991.79418945312, z = 34.341567993164 },
	fixedpos = vector3(0, -0, 180),
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = true,
	autolock = 8000,

	},
	--Custody

	{
	 objName = 165994623,
	objCoords  = {x = 445.34555053711, y = -986.30334472656, z = 34.317951202393 },
	textCoords  = {x = 445.34555053711, y = -986.30334472656, z = 34.317951202393 },
	fixedpos = vector3(-0, -0, -89.99997),
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = true,
	autolock = 6000,
	},
	{
	 objName = -884718443,
	objCoords  = {x = 448.9914855957, y = -984.66967773438, z = 34.340450286865 },
	textCoords  = {x = 448.9914855957, y = -984.66967773438, z = 34.340450286865 },
	fixedpos = vector3(0, -0, -180),
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = true,

	},
	{
	 objName = -884718443,
	objCoords  = {x = 454.91885375977, y = -984.66967773438, z = 34.340450286865 },
	textCoords  = {x = 454.91885375977, y = -984.66967773438, z = 34.340450286865 },
	fixedpos = vector3(0, -0, -180),
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = true,

	},
	{
	 objName = -884718443,
	objCoords  = {x = 460.84661865234, y = -984.66967773438, z = 34.340450286865 },
	textCoords  = {x = 460.84661865234, y = -984.66967773438, z = 34.340450286865 },
	fixedpos = vector3(0, -0, 180),
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = true,

	},
	{
	 objName = -884718443,
	objCoords  = {x = 462.14538574219, y = -989.14440917969, z = 34.337306976318 },
	textCoords  = {x = 462.14538574219, y = -989.14440917969, z = 34.337306976318 },
	fixedpos = vector3(1.556587e-11, -1.104186e-11, 0.2280009),
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = true,

	},
	{
	 objName = -884718443,
	objCoords  = {x = 456.2223815918, y = -989.14440917969, z = 34.337306976318 },
	textCoords  = {x = 456.2223815918, y = -989.14440917969, z = 34.337306976318 },
	fixedpos = vector3(0, -0, 0),
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = true,

	},
	{
	 objName = -884718443,
	objCoords  = {x = 450.28952026367, y = -989.14440917969, z = 34.337306976318 },
	textCoords  = {x = 450.28952026367, y = -989.14440917969, z = 34.337306976318 },
	fixedpos = vector3(0, -0, 0),
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = true,

	},
	---Armoury

	{
	 objName = -1543859032,
	objCoords  = {x = 487.55038452148, y = -997.31805419922, z = 25.855878829956 },
	textCoords  = {x = 487.55038452148, y = -997.31805419922, z = 25.855878829956 },
	fixedpos = vector3(0, -0, -180),
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = true,
	autolock = 8000,
	},
	{
	 objName = 165994623,
	objCoords  = {x = 478.484375, y = -984.67449951172, z = 25.857118606567 },
	textCoords  = {x = 478.484375, y = -984.67449951172, z = 25.857118606567 },
	fixedpos = vector3(-0, -0, -89.99997),
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = true,
	autolock = 8000,
	},
	--Infirmary
	{
	 objName = 165994623,
	objCoords  = {x = 479.45175170898, y = -999.9072265625, z = 34.339561462402 },
	textCoords  = {x = 479.45175170898, y = -999.9072265625, z = 34.339561462402 },
	fixedpos = vector3(1.006977e-07, -3.7756e-08, -80.10541),
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = false,
	},
	
	{
	 objName = 165994623,
	objCoords  = {x = 479.40655517578, y = -995.91204833984, z = 34.339561462402 },
	textCoords  = {x = 479.40655517578, y = -995.91204833984, z = 34.339561462402 },
	fixedpos = vector3(0.0001660855, 0.0003167514, -90.13291),
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = false,
	},
	
	{
	objName = 165994623,
	objCoords  = {x = 479.40655517578, y = -992.11419677734, z = 34.339561462402 },
	textCoords  = {x = 479.40655517578, y = -992.11419677734, z = 34.339561462402 },
	fixedpos = vector3(-3.327425e-15, -8.489015e-16, -90.17925),
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = false,
	},
	{
	 objName = -340230128,
	objCoords  = {x = 464.27444458008, y = -983.37414550781, z = 43.83561706543 },
	textCoords  = {x = 464.27444458008, y = -983.37414550781, z = 43.83561706543 },
	fixedpos = vector3(1.113736e-05, -1.20202e-05, -89.86369),
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = true,
   },

	--Custody Door
	{
	 objName = 165994623,
	objCoords  = {x = 464.87594604492, y = -989.32293701172, z = 25.860218048096 },
	textCoords  = {x = 464.87594604492, y = -989.32293701172, z = 25.860218048096 },
	fixedpos = vector3(-0.0006811213, -0.0007125813, 90.13389),
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = true,
	autolock = 6000,
	},
	{ --Prisoner Separation Gate
	objName = 91564889,
	objCoords  = {x = 444.57727050781, y = -977.06475830078, z = 26.021373748779 },
	textCoords  = {x = 444.57727050781, y = -977.06475830078, z = 26.021373748779 },
	fixedpos = vector3(-2.18685e-06, -1.819246e-05, 89.7764),
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = true,
	autolock = 6000,
	},

	
	--Interview Rooms
	
	{
	objName = -1543859032,
	objCoords  = {x = 441.35687255859, y = -995.25988769531, z = 34.314151763916 },
	textCoords  = {x = 441.35687255859, y = -995.25988769531, z = 34.314151763916 },
	fixedpos = vector3(-3.010931e-15, 1.333938e-15, 89.94125),
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = false,

	},
	{
	objName = -1543859032,
	objCoords  = {x = 435.78787231445, y = -984.85363769531, z = 34.320236206055 },
	textCoords  = {x = 435.78787231445, y = -984.85363769531, z = 34.320236206055 },
	fixedpos = vector3(0, -0, 0),
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = false
	},
	---Garages
	{
	 objName = 1356380196,
	objCoords  = {x = 431.40817260742, y = -1001.2523803711, z = 26.641805648804 },
	textCoords  = {x = 431.40817260742, y = -1001.2523803711, z = 26.641805648804 },
	fixedpos = vector3(0, -0, 0),
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = false,
	distance = 7,
	force = true,
	size = 2
	},
	{
	 objName = 1356380196,
	objCoords  = {x = 436.22341918945, y = -1001.2523803711, z = 26.64214515686 },
	textCoords  = {x = 436.22341918945, y = -1001.2523803711, z = 26.64214515686 },
	fixedpos = vector3(0, -0, 0),
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = false,
	distance = 7,
	force = true,
	size = 2
	}
	,{
	 objName = 1356380196,
	objCoords  = {x = 447.48208618164, y = -1001.1301269531, z = 26.648086547852 },
	textCoords  = {x = 447.48208618164, y = -1001.1301269531, z = 26.648086547852 },
	fixedpos = vector3(0, -0, 0),
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = true,
	distance = 10,
	force = true,
	size = 2
	},
	{
	 objName = 1356380196,
	objCoords  = {x = 452.30166625977, y = -1001.1301269531, z = 26.648086547852 },
	textCoords  = {x = 452.30166625977, y = -1001.1301269531, z = 26.648086547852 },
	fixedpos = vector3(0, -0, 0),
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = true,
	distance = 10,
	force = true,
	size = 2
	}, --BackDoors
	{
	 objName = -2023754432,
	objCoords  = {x = 467.35330200195, y = -1014.5518188477, z = 26.53733253479 },
	textCoords  = {x = 467.35330200195, y = -1014.5518188477, z = 26.53733253479 },
	fixedpos = vector3(0, -0, 0),
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = true,

	},
	{
	 objName = -2023754432,
	objCoords  = {x = 469.95251464844, y = -1014.5518188477, z = 26.53733253479 },
	textCoords  = {x = 469.95251464844, y = -1014.5518188477, z = 26.53733253479 },
	fixedpos = vector3(0, -0, -180),
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = true,

	},

	
   {-- Front Gate
	 objName = 569833973,
	 objCoords  = {x = 409.94985961914, y = -1023.6647949219, z = 28.381837844849 },
	 textCoords  = {x = 410.0, y = -1020.0, z = 31.381834030151 },
	 fixedpos = vector3(0, -0, -90.96438),
	 authorizedJobs = { 'keycard_police','keycard_afp' },
	 locked = true,
	 force = true,
	 distance = 16,
	 size = 2,
	 },
	{-- Back Gate
	objName = -1603817716,
	objCoords  = {x = 488.89477539063, y = -1017.2122802734, z = 27.149345397949 },
	textCoords  = vector3(488.73, -1019.93, 28.21),
	fixedpos = vector3(0, 0, 90),
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = true,
	force = true,
	distance = 11,
	size = 2
	},
	--Side Gate
	{
	 objName = 91564889,
	objCoords  = {x = 424.83578491211, y = -999.97039794922, z = 31.043159484863 },
	textCoords  = {x = 424.83578491211, y = -999.97039794922, z = 31.043159484863 },
	fixedpos = vector3(-0.0001627321, 1.147185e-06, 179.1939),
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = true,
	autolock = 6000,
	},




	
	--
	-- Delperro
	--

	-- Entrance
	{
		objName = 1417577297,
		objCoords  = {x = -1633.1973876953, y = -1015.3305053711, z = 13.378726959229 },
		textCoords = {x = -1633.1973876953, y = -1015.3305053711, z = 13.378726959229 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		fixedpos = vector3(0, -0, 139.8791) ,
		distance = 4,
		locked = true
	},
	{
		objName = 2059227086 ,
		objCoords  = {x = -1631.7370605469, y = -1016.5609741211, z = 13.371068954468 },
		textCoords = {x = -1631.7370605469, y = -1016.5609741211, z = 13.371068954468 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		fixedpos = vector3(0, -0, 139.8791),
		distance = 4,
		locked = true
	},
	{ --back door
		objName = -2023754432 ,
		objCoords  = {x = -1613.3150634766, y = -1027.2573242188, z = 13.303521156311 },
		textCoords = {x = -1613.3150634766, y = -1027.2573242188, z = 13.303521156311 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		fixedpos = vector3(-0.002557307, -0.0004384599, -130.7516),
		locked = true,
		autolock = 6000,
	},
	
	{ 
		objName = -2023754432,
		objCoords  = {x = -1633.0689697266, y = -1028.7290039063, z = 13.303521156311 },
		textCoords = {x = -1633.0689697266, y = -1028.7290039063, z = 13.303521156311 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		fixedpos = vector3(0.002101616, -0.001925861, 139.7629),
		locked = true
	},
	
	 {
	  objName = -1011692606,
	 objCoords  = {x = -1623.2055664062, y = -1023.5737304688, z = 13.382936477661 },
	 textCoords  = {x = -1623.2055664062, y = -1023.5737304688, z = 13.382936477661 },
	 fixedpos = vector3(-0.0002654032, 0.001706177, 139.8401),
	 authorizedJobs = { 'keycard_police','keycard_afp' },
	 locked = true,
	 autolock = 6000,
	},
	
--Cells

	

	{ 
		objName = -1011692606,
		objCoords  = {x = -1614.5361328125, y = -1021.7074584961, z = 13.382936477661 },
		textCoords = {x = -1614.5361328125, y = -1021.7074584961, z = 13.382936477661 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		fixedpos = vector3(0, -0, 139.8791),
		locked = true
	},
	{ 
		objName = -1011692606,
		objCoords  = {x = -1609.9693603516, y = -1023.3565063477, z = 13.382936477661 },
		textCoords = {x = -1609.9693603516, y = -1023.3565063477, z = 13.382936477661 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		fixedpos = vector3(0, -0, -130.2392),
		locked = true
	},
	{ 
		objName = -1011692606,
		objCoords  = {x = -1616.4683837891, y = -1024.0052490234, z = 13.382936477661 },
		textCoords = {x = -1616.4683837891, y = -1024.0052490234, z = 13.382936477661 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		fixedpos = vector3(0, -0, 139.8791),
		locked = true
	},	
	{ 
		objName = -2023754432,
		objCoords  = {x = -1622.8421630859, y = -1028.8361816406, z = 13.303521156311 },
		textCoords = {x = -1622.8421630859, y = -1028.8361816406, z = 13.303521156311 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		fixedpos = vector3(0.002475885, 0.001101918, -131.2224) ,
		locked = true
	},		
	

	--
	-- Sandy Shores
	--

	-- Entrance
	{
		objName = `v_ilev_shrfdoor`,
		objCoords  = {x = 1855.6848144531, y = 3683.9301757812, z = 34.592823028564 },
		textCoords  = {x = 1855.6848144531, y = 3683.9301757812, z = 34.592823028564 },
		fixedpos = vector3(0, 0, 29.99999),
		authorizedJobs = { 'keycard_police','keycard_afp' },
		locked = true
		
	},
	{
		objName = 1557126584 ,
		objCoords  = {x = 1857.2680664063, y = 3690.2788085938, z = 34.41955947876 },
		textCoords = {x = 1857.2680664063, y = 3690.2788085938, z = 34.41955947876 },
		fixedpos = vector3(0, 0, 29.99999),
		authorizedJobs = { 'keycard_police','keycard_afp' },
		locked = true
	},
	
	--Perimter Doors in Sandy
	
	{
		objName = 1557126584,
		objCoords  = {x = 1846.1160888672, y = 3689.2670898438, z = 34.416423797607 },
		textCoords  = {x = 1846.1160888672, y = 3689.2670898438, z = 34.416423797607 },
		fixedpos = vector3(0, 0, 29.99999),
		authorizedJobs = { 'keycard_police','keycard_afp' },
		locked = true,
		autolock = 6000,
	 },

	 {
	  objName = 1557126584,
	 objCoords  = {x = 1850.3798828125, y = 3683.4541015625, z = 34.409999847412 },
	 textCoords  = {x = 1850.3798828125, y = 3683.4541015625, z = 34.409999847412 },
	 fixedpos = vector3(0, -0, 120),
	 authorizedJobs = { 'keycard_police','keycard_afp' },
	 locked = true,
	 autolock = 6000,
	 },

	{
	  objName = 1557126584,
	 objCoords  = {x = 1849.3331298828, y = 3691.1318359375, z = 34.414325714111 },
	 textCoords  = {x = 1849.3331298828, y = 3691.1318359375, z = 34.414325714111 },
	fixedpos = vector3(0, 0, 29.99999),
	 authorizedJobs = { 'keycard_police','keycard_afp' },
	 locked = true,
	 autolock = 6000,
	}
,
		
	
	--Cells Sandy
	
	
	{
	 objName = 631614199,
	objCoords  = {x = 1846.3916015625, y = 3684.4504394531, z = 34.40397644043 },
	textCoords  = {x = 1846.3916015625, y = 3684.4504394531, z = 34.40397644043 },
	fixedpos = vector3(-0, -0, -59.99998),
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = true,

	},

	 {
	 objName = 631614199,
	 objCoords  = {x = 1847.9862060547, y = 3681.6884765625, z = 34.40397644043 },
	 textCoords  = {x = 1847.9862060547, y = 3681.6884765625, z = 34.40397644043 },
	 fixedpos = vector3(0, -0, 120),
	 authorizedJobs = { 'keycard_police','keycard_afp' },
	 locked = true,

	},
		
	--
	-- Paleto Bay
	--

	-- Entrance (double doors)
	{
		objName = `v_ilev_shrf2door`,
		objCoords  = {x = -443.14, y = 6015.685, z = 31.716},
		textCoords = {x = -443.14, y = 6015.685, z = 32.00},
		authorizedJobs = { 'keycard_police','keycard_afp' },
		locked = false,
		distance = 2.5,
		
	},

	{
		objName = `v_ilev_shrf2door`,
		objCoords  = {x = -443.951, y = 6016.622, z = 31.716},
		textCoords = {x = -443.951, y = 6016.622, z = 32.00},
		authorizedJobs = { 'keycard_police','keycard_afp' },
		locked = false,
		distance = 2.5,
		
	},

	--
	-- Bolingbroke Penitentiary
	--

	-- Entrance (Two big gates)
	{
		objName = `prop_gate_prison_01`,
		objCoords  = {x = 1844.998, y = 2604.810, z = 44.638},
		textCoords = {x = 1844.998, y = 2608.50, z = 48.00},
		authorizedJobs = { 'keycard_police','keycard_afp' },
		locked = false,
		distance = 12,
		size = 2
	},

	{
		objName = `prop_gate_prison_01`,
		objCoords  = {x = 1818.542, y = 2604.812, z = 44.611},
		textCoords = {x = 1818.542, y = 2608.40, z = 48.00},
		authorizedJobs = { 'keycard_police','keycard_afp' },
		locked = false,
		distance = 12,
		size = 2
	},
	
	--Double DOors Davis Sheriff
	
		--Double outside doors
	{
		objName = -1501157055,
		objCoords  = {x = 362.30718994141, y = -1584.0595703125 , z = 29.442419052124},
		textCoords = {x = 361.70, y = -1585.21 , z = 29.442419052124},
		authorizedJobs = { 'keycard_police','keycard_afp' },
		locked = false,
		distance = 2.5,

	},	
	{
		objName = -1501157055,
		objCoords  = {x = 360.60494995117, y = -1586.0247802734 , z = 29.442419052124},
		textCoords = {x = 361.70, y = -1585.21 , z = 29.442419052124},
		authorizedJobs = { 'keycard_police','keycard_afp' },
		locked = false,
		distance = 2.5,

	},
			--Front door public/private
	{
		objName = -1320876379,
		objCoords  = {x = 366.17950439453, y = -1588.0673828125, z = 29.447195053101},
		textCoords = {x = 366.17950439453, y = -1588.0673828125, z = 29.447195053101},
		authorizedJobs = { 'keycard_police','keycard_afp' },
		fixedpos = vector3(0, 0, 49.66816),
		locked = true,
		autolock = 5000
	},
	
			--Rear counter public/private
	{
		objName = -1320876379,
		objCoords  = {x = 366.17950439453, y = -1588.0673828125, z = 29.447195053101},
		textCoords = {x = 366.17950439453, y = -1588.0673828125, z = 29.447195053101},
		authorizedJobs = { 'keycard_police','keycard_afp' },
		fixedpos = vector3(0, 0, 49.66817),
		locked = true,
		autolock = 5000
	},
			
	--Cell Doors
	{
		objName = 631614199,
		objCoords  = {x = 353.06173706055, y = -1597.8395996094, z = 29.44278717041 },
		textCoords = {x = 353.06173706055, y = -1597.8395996094, z = 29.44278717041 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		fixedpos = vector3(-0, -0, -40.3946),
		locked = true,
	},
	
	{
		objName = 631614199,
		objCoords  = {x = 355.42993164063, y = -1599.8317871094, z = 29.44278717041 },
		textCoords = {x = 355.42993164063, y = -1599.8317871094, z = 29.44278717041 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		fixedpos = vector3(-0, -0, -40.3946),
		locked = true,
	},

	{
		objName = 631614199,
		objCoords  = {x = 364.33184814453, y = -1607.2838134766, z = 29.44278717041 },
		textCoords = {x = 364.33184814453, y = -1607.2838134766, z = 29.44278717041 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		fixedpos = vector3(-0, -0, -39.75565) ,
		locked = true,
	},
	
		{
		objName = 631614199,
		objCoords  = {x = 366.69827270508, y = -1609.2822265625, z = 29.44278717041 },
		textCoords = {x = 366.69827270508, y = -1609.2822265625, z = 29.44278717041 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		fixedpos = vector3(-0, -0, -39.75565) ,
		locked = true,
	},
	
	
	{
		objName = 631614199,
		objCoords  = {x = 361.2001953125, y = -1611.0101318359, z = 29.442090988159 },
		textCoords = {x = 361.2001953125, y = -1611.0101318359, z = 29.442090988159 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		fixedpos = vector3(-0, -0, -40.77785)  ,
		locked = true,
	},
	
	{
		objName = 631614199,
		objCoords  = {x = 363.57034301758, y = -1613.0065917969, z = 29.442090988159 },
		textCoords = {x = 363.57034301758, y = -1613.0065917969, z = 29.442090988159 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		fixedpos = vector3(-0, -0, -40.77785)  ,
		locked = true,
	},
	
	{
		objName = 631614199,
		objCoords  = {x = 352.32632446289, y = -1603.5372314453, z = 29.442090988159 },
		textCoords = {x = 352.32632446289, y = -1603.5372314453, z = 29.442090988159 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		fixedpos = vector3(-0, -0, -40.77785) ,
		locked = true,
	},
	
	{
		objName = 631614199,
		objCoords  = {x = 349.94711303711, y = -1601.5496826172, z = 29.442090988159 },
		textCoords = {x = 349.94711303711, y = -1601.5496826172, z = 29.442090988159 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		fixedpos = vector3(-0, -0, -40.1173)  ,
		locked = true,
	},
	
	
			--Double outside doors rear
	{
		objName = -1501157055,
		objCoords  = {x = 368.21255493164, y = -1608.2419433594, z = 29.430377960205 },
		textCoords = {x = 368.21255493164, y = -1608.2419433594, z = 29.430377960205 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		fixedpos = vector3(1.831972e-05, -1.300595e-05, -130.1852),
		locked = true,
		distance = 2,
		autolock = 5000

	},	
	{
		objName = -1501157055,
		objCoords  = {x = 369.88708496094, y = -1606.2618408203, z = 29.430377960205 },
		textCoords = {x = 369.88708496094, y = -1606.2618408203, z = 29.430377960205 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		fixedpos = vector3(-9.598146e-05, 0.0001207766, 49.74734),
		locked = true,
		distance = 2,
		autolock = 5000

	},
		
		-- Back Gate Davis
	{
		objName = 1286535678,
		objCoords  = {x = 397.8840637207, y = -1607.3842773438, z = 28.338140487671 },
		textCoords = vector3(400.79, -1609.57, 29.29),
		authorizedJobs = { 'keycard_police','keycard_afp' },
		fixedpos = vector3(0, -0, 140),
		locked = true,
		distance = 14,
		size = 2
	},	
	
	--Other Back Gate
	{
	 objName = -1156020871,
	 objCoords  = {x = 391.86016845703, y = -1636.0701904297, z = 29.974376678467 },
	 textCoords  = {x = 391.86016845703, y = -1636.0701904297, z = 29.974376678467 },
	 fixedpos = vector3(0, 0, 49.99996),
	 authorizedJobs = { 'keycard_police','keycard_afp' },
	 locked = true,
	},
	
		-- Heli
	{
		objName = 1286535678,
		objCoords  = {x = 378.62600708008, y = -1602.4151611328, z = 37.096817016602 },
		textCoords = 	{x = 378.62600708008, y = -1602.4151611328, z = 37.096817016602 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		fixedpos = vector3(0, -0, -130.4223),
		locked = true,
	},
	

	--Vinewood Police
	---front doors
	
	{
		objName = 216678786 ,
		objCoords  = {x = 637.17590332031, y = 0.71897983551025, z = 83.008911132813 },
		textCoords = {x = 637.17590332031, y = 0.71897983551025, z = 83.008911132813 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		fixedpos = vector3(-5.835449e-15, 3.17451e-16, -110.7209),
		locked = false,
		distance = 5
	},	
	{
		objName = 216678786 ,
		objCoords  = {x = 638.14300537109, y = 3.3549394607544, z = 83.008911132813 },
		textCoords = {x = 638.14300537109, y = 3.3549394607544, z = 83.008911132813 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		fixedpos = vector3(0, 0, 71.19115),
		locked = false,
		distance = 5
	}, --side doors
	
	{
		objName = 1955380993 ,
		objCoords  = {x = 618.12774658203, y = 17.186248779297, z = 88.64599609375 },
		textCoords = {x = 618.12774658203, y = 17.186248779297, z = 88.64599609375 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		fixedpos = vector3(-0, -0, -19.54856),
		locked = true,
		distance = 5,
		autolock = 6000,
	},	
	{
		objName = 1955380993,
		objCoords  = {x = 621.15625, y = 16.037929534912, z = 88.64599609375 },
		textCoords = {x = 621.15625, y = 16.037929534912, z = 88.64599609375 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		fixedpos = vector3(0, -0, 158.9991) ,
		locked = true,
		distance = 5,
		autolock = 6000
	},

	{  --Auditoriam
		objName = -1320876379 ,
		objCoords  = {x = 620.06610107422, y = -4.5978274345398, z = 82.932121276855 },
		textCoords = {x = 620.06610107422, y = -4.5978274345398, z = 82.932121276855 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		fixedpos = vector3(0, -0, -20.55429),
		locked = true,
		autolock = 6000
	},
	
	{  --FMain
		objName = -626684119 ,
		objCoords  = {x = 619.54211425781, y = 3.7219495773315, z = 82.920890808105 },
		textCoords = {x = 619.54211425781, y = 3.7219495773315, z = 82.920890808105 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		fixedpos = vector3(0.001351537, 0.0004802284, 70.05936),
		locked = true,
		autolock = 6000,
	},
	
	--Custody
	{  --Main
		objName = 631614199 ,
		objCoords  = {x = 614.69439697266, y = -2.3896293640137, z = 82.931579589844 },
		textCoords = {x = 614.69439697266, y = -2.3896293640137, z = 82.931579589844 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		fixedpos = vector3(-0, -0, -19.60069),
		locked = true,
		autolock = 6000
	},
	{  --other cells
		objName = 631614199 ,
		objCoords  = {x = 611.966796875, y = -11.267857551575, z = 82.928024291992 },
		textCoords = {x = 611.966796875, y = -11.267857551575, z = 82.928024291992 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		fixedpos = vector3(0, -0, 163.5757) ,
		locked = true
	},
	{  --other cells
		objName = 631614199 ,
		objCoords  = {x = 608.13305664063, y = -9.8642406463623, z = 82.928024291992 },
		textCoords = {x = 608.13305664063, y = -9.8642406463623, z = 82.928024291992 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		fixedpos = vector3(0, -0, 163.5757) ,
		locked = true
	},
	{  --other cells
		objName = 631614199 ,
		objCoords  = {x = 604.28552246094, y = -8.4644575119019, z = 82.928024291992 },
		textCoords = {x = 604.28552246094, y = -8.4644575119019, z = 82.928024291992 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		fixedpos = vector3(0, -0, 163.5757) ,
		locked = true
	},
	{  --other cells
		objName = 631614199 ,
		objCoords  = {x = 600.43664550781, y = -7.0602922439575, z = 82.928024291992 },
		textCoords = {x = 600.43664550781, y = -7.0602922439575, z = 82.928024291992 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		fixedpos = vector3(0, -0, 163.5757) ,
		locked = true
	},
	
		--McDonalds City Door locks
	{
		objName = 1468342179,
		objCoords  = {x = 272.29315185547, y = -966.18139648438, z = 29.740074157715 },
		textCoords  = {x = 272.29315185547, y = -966.18139648438, z = 29.740074157715 },
		fixedpos = vector3(0, 0, 33.59703),
		authorizedJobs = { 'keycard_police','keycard_afp' },
		locked = false,
		distance = 6,
	},
	{
		objName = 1468342179,
		objCoords  = {x = 273.77322387695, y = -965.19818115234, z = 29.740074157715 },
		textCoords  = {x = 273.77322387695, y = -965.19818115234, z = 29.740074157715 },
		fixedpos = vector3(0, -0, -146.1068),
		authorizedJobs = { 'keycard_police','keycard_afp' },
		locked = false,
		distance = 6,
	},
	--Biker Club City  981.15051269531  -103.25524902344  74.993576049805  190770132
	--[[{
	 objName = -930593859,
	 objCoords  = {x = 956.45245361328, y = -137.83976745605, z = 73.57160949707 },
	 textCoords  = {x = 956.45245361328, y = -137.83976745605, z = 73.57160949707 },
	 fixedpos = vector3(0, -0, 148.1999),
	 authorizedJobs = { 'keycard_police','keycard_afp','keycard_biker1'  },
	 locked = true,
	 distance = 15,
	 size = 2
	},
 
	{
	 objName = -197537718,
	 objCoords  = {x = 982.38745117188, y = -125.37104797363, z = 74.993133544922 },
	 textCoords  = {x = 982.38745117188, y = -125.37104797363, z = 74.993133544922 },
	 fixedpos = vector3(0, -0, -120.5711),
	 authorizedJobs = { 'keycard_police','keycard_afp','keycard_biker1'},
	 locked = true,
	 },
	 
	{
	  objName = 190770132,
	 objCoords  = {x = 981.15051269531, y = -103.25524902344, z = 74.993576049805 },
	 textCoords  = {x = 981.15051269531, y = -103.25524902344, z = 74.993576049805 },
	 fixedpos = vector3(-0.001821152, 0.0005528853, 61.06295),
	 authorizedJobs = { 'keycard_police','keycard_afp','keycard_biker1' },
	 locked = true,
	},--]]

	--Davis House -14.868921279907    31.193225860596  520341586 
	{
		objName = 520341586,
		objCoords  = {x = -14.868921279907, y = -1441.1821289063, z = 74.993576049805},
		textCoords = {x = -14.28, y = -1442.14, z = 74.993576049805},
		authorizedJobs = { 'keycard_police','keycard_afp' },
		locked = false
	},
	
	--- Paleto Front side Doors
	{
		objName = 964838196 ,
		objCoords  = {x = -442.82150268555, y = 6010.9306640625 , z = 31.866329193115},
		textCoords = {x = -441.7 , y = 6012.03   , z = 31.866329193115},
		authorizedJobs = { 'keycard_police','keycard_afp' },
		locked = true,
		
	},	
	{
		objName = 964838196 ,
		objCoords  = {x = -440.98068237305 , y = 6012.771484375   , z = 31.866329193115},
		textCoords = {x = -441.7 , y = 6012.03   , z = 31.866329193115},
		authorizedJobs = { 'keycard_police','keycard_afp' },
		locked = true,
		
	},
		
	--- Paleto Front side Doors
	
	{
		objName = 245182344,
		objCoords  = {x = -447.70916748047, y = 6006.716796875 , z = 31.8088722229 },
		textCoords = {x = -448.49 , y = 6007.84  , z = 31.866329193115},
		authorizedJobs = { 'keycard_police','keycard_afp' },
		locked = true,
		
	},	
	{
		objName =  -681066206 ,
		objCoords  = {x = -449.55001831055 , y = 6007.51 , z = 31.8088722229},
		textCoords = {x = -448.49 , y = 6007.84   , z = 31.866329193115},
		authorizedJobs = { 'keycard_police','keycard_afp' },
		locked = true,
		
	},
		--Paleto Front Interview Room
	{
		objName = -2023754432,
		objCoords  = {x = -449.79461669922, y = 6015.4482421875, z = 31.866329193115 },
		textCoords = {x = -449.79461669922, y = 6015.4482421875, z = 31.866329193115},
		authorizedJobs = { 'keycard_police','keycard_afp' },
		locked = true
	},
	
	--Paleto Interview Room Prisoner
	{
		objName = -519068795,
		objCoords  = {x = -454.53598022461, y = 6011.2578125, z = 31.869819641113 },
		textCoords = {x = -454.53598022461, y = 6011.2578125, z = 31.869819641113},
		authorizedJobs = { 'keycard_police','keycard_afp' },
		locked = true
	},
	
	--Paleto Back Doors
	{
		objName = 452874391,
		objCoords  = {x = -450.97872924805, y = 6006.0747070313, z = 31.994165420532 },
		textCoords = {x = -450.97872924805, y = 6006.0747070313, z = 31.994165420532 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		locked = true,
		autolock = 5000
	},
	
		{
		objName = 452874391,
		objCoords  = {x = -447.2262878418, y = 6002.3286132813, z = 31.994165420532 },
		textCoords = {x = -447.2262878418, y = 6002.3286132813, z = 31.994165420532},
		authorizedJobs = { 'keycard_police','keycard_afp' },
		locked = true,
		autolock = 5000
	},
		--Property Room
	{
		objName = -1011692606 ,
		objCoords  = {x = -437.61444091797, y = 5992.8193359375, z = 31.936056137085 },
		textCoords = {x = -437.61444091797, y = 5992.8193359375, z = 31.936056137085 },
		authorizedJobs = { 'keycard_afp','keycard_police' },
		locked = true
	},
	--Cells
	
	{
		objName = 631614199 ,
		objCoords  = {x = -432.17544555664, y = 5992.1215820313, z = 31.873119354248 },
		textCoords = {x = -432.17544555664, y = 5992.1215820313, z = 31.873119354248 },
		authorizedJobs = { 'keycard_afp','keycard_police' },
		locked = true
	},
		{
		objName = 631614199 ,
		objCoords  = {x = -428.06463623047, y = 5996.671875, z = 31.873123168945 },
		textCoords = {x = -428.06463623047, y = 5996.671875, z = 31.873123168945 },
		authorizedJobs = { 'keycard_afp','keycard_police' },
		locked = true
	},
		{
		objName = 631614199  ,
		objCoords  = {x = -431.19207763672, y = 5999.7416992188, z = 31.873123168945 },
		textCoords = {x = -431.19207763672, y = 5999.7416992188, z = 31.873123168945 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		locked = true
	},
	
	
	
		--Hospital Sandy Shores
--[[
	{
		objName =  393888353 ,
		objCoords  = {x = 1837.2786865234, y = 3673.3701171875, z = 34.69900894165 },
		textCoords = {x = 1838.75, y = 3674.04, z = 34.694171905518 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		locked = false,
		distance = 4,

	},	
	{
		objName =  393888353 ,
		objCoords  = {x = 1839.8717041016, y = 3674.8679199219, z = 34.696197509766 },
		textCoords = {x = 1838.75, y = 3674.04, z = 34.694171905518 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		locked = false,
		distance = 4,
	
	},
	
	{
		objName =  393888353 ,
		objCoords  = {x = 1827.0426025391, y = 3690.2585449219, z = 34.693000793457 },
		textCoords = {x = 1828.26, y = 3691.02, z = 34.693000793457 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		locked = false,
		distance = 4,

	},	
	{
		objName =  393888353 ,
		objCoords  = {x = 1829.6368408203, y = 3691.7546386719, z = 34.694171905518 },
		textCoords = {x = 1828.26, y = 3691.02, z = 34.693000793457 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		locked = false,
		distance = 4,

	},


--Surgery Doors

	{
		objName =  580361003 ,
		objCoords  = {x = 1821.0350341797, y = 3675.9221191406, z = 34.422130584717 },
		textCoords = {x = 1822.38, y = 3676.52, z = 34.5 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		locked = false,
		distance = 4,

	},	
	{
		objName =  1415151278,
		objCoords  = {x = 1823.2608642578, y = 3677.2109375, z = 34.422130584717 },
		textCoords = {x = 1822.38, y = 3676.52, z = 34.5 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		locked = false,
		distance = 4,

	},	
	
	
	--outer most surgery
		{
		objName =  580361003 ,
		objCoords  = {x = 1825.3356933594, y = 3682.419921875, z = 34.422260284424},
		textCoords = {x = 1825.84, y = 3681.12, z = 34.5 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		locked = false,
		distance = 4,

	},	
	{
		objName =  1415151278,
		objCoords  = {x =1826.6263427734, y = 3680.1928710938, z = 34.422260284424 },
		textCoords = {x = 1825.84, y = 3681.12, z = 34.5 },
		authorizedJobs = { 'keycard_police','keycard_afp' },
		locked = false,
		distance = 4,

	},	 -- ]]
	
	
	--AFP City
	
	{
		objName =  -90456267,
		objCoords  = {x = 105.76067352295, y = -746.64599609375, z = 46.182655334473 },
		textCoords = {x = 105.88, y = -744.72, z = 46.182655334473 },
		authorizedJobs = {'keycard_afp' },
		locked = true,
		fixedpos = vector3(-0.0009496517, -8.491586e-05, 79.27148),
		distance = 6,
		autolock = 8000,
		size = 3,
	
	},
	{
		objName =  -1517873911 ,
		objCoords  = {x = 106.37927246094, y = -742.6982421875, z = 46.181709289551 },
		textCoords = {x = 105.88, y = -744.72, z = 46.182655334473 },
		authorizedJobs = {'keycard_afp','keycard_police' },
		locked = true,

		fixedpos = vector3(-0.0009496517, -8.491586e-05, 79.27148),
		autolock = 8000,
		distance = 6,
		size = 3
	},
	{
		objName =  -1821777087 ,
		objCoords  = {x = 138.5111541748, y = -768.80541992188, z = 242.3021697998 },
		textCoords = {x = 138.5111541748, y = -768.80541992188, z = 242.3021697998},
		authorizedJobs = {'keycard_afp' },
		locked = true,
		autolock = 6000
	},
	{
		objName =  -1821777087 ,
		objCoords  = {x = 127.20916748047, y = -764.69348144531, z = 242.30198669434 },
		textCoords = {x = 127.20916748047, y = -764.69348144531, z = 242.30198669434},
		authorizedJobs = {'keycard_afp' },
		locked = true,
		autolock = 6000
	},
	
	--FBI Custody doors
	
	{
		objName = -1821777087   ,
		objCoords  = {x = 152.45896911621, y = -739.41772460938, z = 242.3021697998 },
		textCoords = {x = 152.45896911621, y = -739.41772460938, z = 242.3021697998 },
		authorizedJobs = { 'keycard_afp','keycard_police' },
		locked = true
	},
	
	{
		objName = -1821777087   ,
		objCoords  = {x = 146.8719329834, y = -754.76794433594, z = 242.3021697998 },
		textCoords = {x = 146.8719329834, y = -754.76794433594, z = 242.3021697998 },
		authorizedJobs = { 'keycard_afp','keycard_police' },
		locked = true
	},
	
	{
		objName = -1821777087   ,
		objCoords  = {x = 151.48048400879, y = -742.10614013672, z = 242.3021697998 },
		textCoords = {x = 151.48048400879, y = -742.10614013672, z = 242.3021697998 },
		authorizedJobs = { 'keycard_afp','keycard_police' },
		locked = true
	},
	
	
	--VAULT Main Principal
	{
		objName = -1932297301 ,
		objCoords  = {x = -1.7279472351074, y = -686.54174804688, z = 16.689130783081 },
		textCoords = {x = -1.7279472351074, y = -686.54174804688, z = 16.689130783081 },
		fixedpos =  vector3(0.0009803294, 0.0003434449, 160.1621),
		authorizedJobs = { 'keycard_afp','keycard_police' },
		locked = true
	},
	
	
	--VAULT Great Ocean Hwy
	--[[{
		objName = -63539571,
		objCoords  = {x = -2958.5385742188, y = 482.27056884766, z = 15.83594417572  },
		textCoords = {x = -2958.5385742188, y = 482.27056884766, z = 15.83594417572  },
		fixedpos =  vector3(0, 0, -2.457949),
		authorizedJobs = { 'keycard_afp','keycard_police' },
		locked = true
	},	
	
		--VAULT Paleto Bay
	{
		objName = -1185205679,
		objCoords  = {x = -104.60489654541, y = 6473.4438476563, z = 31.795324325562 },
		textCoords = {x = -104.60489654541, y = 6473.4438476563, z = 31.795324325562 },
		fixedpos =  vector3(0, 0, 0),
		authorizedJobs = { 'keycard_afp','keycard_police' },
		locked = true
	},	
	
		--VAULT Harmony
	{
		objName = 2121050683,
		objCoords  = {x = 1175.5421142578, y = 2710.861328125, z = 38.226890563965 },
		textCoords = {x = 1175.5421142578, y = 2710.861328125, z = 38.226890563965 },
		fixedpos =  vector3(0, 0, 90),
		authorizedJobs = { 'keycard_afp','keycard_police' },
		locked = true
	},	
		--VAULT City
	{
		objName = 2121050683,
		objCoords  = {x = 148.02661132813, y = -1044.3638916016, z = 29.506931304932 },
		textCoords = {x = 148.02661132813, y = -1044.3638916016, z = 29.506931304932 },
		fixedpos =   vector3(0, 0, -110.1538),
		authorizedJobs = { 'keycard_afp','keycard_police' },
		locked = true
	},	

		--Door to Cash Harmony
	 {
		  objName = -1591004109,
		 objCoords  = {x = 1172.2911376953, y = 2713.1462402344, z = 38.386253356934 },
		 textCoords  = {x = 1172.2911376953, y = 2713.1462402344, z = 38.386253356934 },
		 fixedpos = vector3(0.0003936462, -2.944726e-05, -2.298572),
		 authorizedJobs = { 'keycard_police','keycard_afp' },
		 locked = true,
		 distance = 6,
		size = 2
	 }, --]]


--[[	{
	objName = `hei_v_ilev_bk_gate2_pris`,
	objCoords  = {x = 261.99899291992, y = 221.50576782227, z = 106.68346405029},
	textCoords = {x = 261.99899291992, y = 221.50576782227, z = 107.68346405029},
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = true,
	distance = 12,
	size = 2
},--]]
{
	objName = -1927271438,  --Biker3
	objCoords  = {x = 500.17617797852, y = -1320.5447998047, z = 28.25008392334 },
	textCoords = {x = 495.05, y = -1311.57 , z = 30.28},
	authorizedJobs = { 'keycard_police', 'keycard_biker3' },
	fixedpos =  vector3(0, -0, 122.9001),
	locked = true,
	distance = 10,
	size = 4
},	
	
{
	objName = -1234764774,  --Biker3
	objCoords  = {x = 483.25408935547, y = -1408.0201416016, z = 28.467380523682 },
	textCoords = {x = 486.32, y = -1408.74,  z = 30.28 },
	authorizedJobs = { 'keycard_police', 'keycard_biker3' },
	locked = true,
	distance = 12,
	size = 4
},	
	
{
	objName = -1234764774,  --Biker3  ---2073573168
	objCoords  =  {x =  494.46173095703, y =  -1410.8638916016, z = 28.419162750244 },
	textCoords = {x = 491.54, y = -1410.21 , z = 30.28},
		
	authorizedJobs = { 'keycard_police', 'keycard_biker3' },
	locked = true,
	distance = 12,
	size = 4
},		

{
	objName = -664582244,  --Biker3  ---2073573168
	objCoords  =  {x = 482.81115722656, y = -1311.9530029297, z = 29.350566864014 },
	textCoords = {x = 482.81115722656, y = -1311.9530029297, z = 29.350566864014 },
	fixedpos = vector3(0, 0, 116.876),	
	authorizedJobs = { 'keycard_police', 'keycard_biker3' },
	locked = true,

},		

{
	objName = -190780785,  --Biker3  ---2073573168
	objCoords  =  {x = 484.57354736328, y = -1315.5692138672, z = 30.247938156128 },
	textCoords = {x = 484.57354736328, y = -1315.5692138672, z = 30.247938156128 },
	fixedpos = vector3(-1.67052, -2.187795e-05, 116.876),
	authorizedJobs = { 'keycard_police', 'keycard_biker3' },
	locked = true,
	size = 4
},		

-- Caino management doors
{
	objName = 680601509,  --Left Management door
	objCoords  =  {x = 1005.4370117188, y = 72.909370422363, z = 73.426116943359 },
	textCoords = {x = 1005.4370117188, y = 72.909370422363, z = 73.426116943359 },
	fixedpos = vector3(1.20393e-05, -1.576894e-06, 57.57491),
	authorizedJobs = { 'keycard_police','keycard_casino' },
	locked = true,
	size = 2
},	

{
	objName = 680601509,  --Right Management door
	objCoords  =  {x = 1006.496887207, y = 74.605133056641, z = 73.426116943359 },
	textCoords = {x = 1006.496887207, y = 74.605133056641, z = 73.426116943359 },
	fixedpos = vector3(-1.191867e-06, 4.354375e-06, -121.5872),
	authorizedJobs = { 'keycard_police','keycard_casino' },
	locked = true,
	size = 2
},	

{
	objName = -643593781,  --Left Management office door
	objCoords  =  {x = 988.39672851563, y = 68.851119995117, z = 78.626113891602 },
	textCoords = {x = 988.39672851563, y = 68.851119995117, z = 78.626113891602 },
	fixedpos = vector3(9.745041e-06,1.949403e-05,-32.10892),
	authorizedJobs = { 'keycard_police','keycard_casino' },
	locked = true,
	size = 2
},	

{
	objName = -643593781,  --Right Management office door
	objCoords  =  {x = 990.09246826172, y = 67.791244506836, z = 78.626113891602 },
	textCoords = {x = 990.09246826172, y = 67.791244506836, z = 78.626113891602 },
	fixedpos = vector3(3.081244e-05,-4.452033e-05,148.0984),
	authorizedJobs = { 'keycard_police','keycard_casino' },
	locked = true,
	size = 2
},	

{
	objName = 21324050,  --Left lobby door
	objCoords  =  {x = 947.98114013672, y =40.247951507568 , z =75.820938110352 },
	textCoords = {x = 947.98114013672, y =40.247951507568 , z =75.820938110352 },
	fixedpos = vector3(0,-0,147.9941),
	authorizedJobs = { 'keycard_police','keycard_casino' },
	locked = true,
	size = 2
},	

{
	objName = 21324050,  --Right lobby door
	objCoords  =  {x = 945.85205078125, y = 41.5786781945801, z = 75.820938110352 },
	textCoords = {x = 945.85205078125, y = 41.5786781945801, z = 75.820938110352 },
	fixedpos = vector3(-0,-0,-32.00589),
	authorizedJobs = { 'keycard_police','keycard_casino' },
	locked = true,
	size = 2
},


--Court
{
	objName = 110411286,  --Left lobby door
	objCoords  =  {x = 321.08819580078, y = -1629.4050292969, z = 32.652099609375},
	textCoords = vector3(321.91030883789,-1628.4813232422,32.541465759277),
	fixedpos = vector3(0, 0, 408.6062) ,
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = true,
	distance = 6,
	size = 1
},	

{
	objName = 110411286,  --Right lobby door
	objCoords  =  {x = 322.78671264648, y = -1627.4339599609, z = 32.652099609375 },
	textCoords = vector3(321.91030883789,-1628.4813232422,32.541465759277),
	fixedpos = vector3(-0,-0,230.00589),
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = true,
	distance = 6,
	size = 1
},
	--next doors
{
	objName = 110411286,  --Left lobby door
	objCoords  =  {x = 330.0876159668, y = -1633.5812988281, z = 32.652774810791 },
	textCoords = vector3(329.32452392578,-1634.6335449219,32.541683197021),
	fixedpos = vector3(0, -0, -130.0577) ,
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = true,
	distance = 6,
	size = 1
},	

{
	objName = 110411286,  --Right lobby door
	objCoords  =  {x = 328.41259765625, y = -1635.5734863281, z = 32.652774810791 },
	textCoords = vector3(329.32452392578,-1634.6335449219,32.541683197021),
	fixedpos = vector3(0, 0, 49.94229) ,
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = true,
	distance = 6,
	size = 1
},
{	--Judges door
	objName = 110411286, 
	objCoords  =  {x = 345.77890014648, y = -1642.9030761719, z = 32.653560638428 },
	textCoords = {x = 345.77890014648, y = -1642.9030761719, z = 32.653560638428 },
	fixedpos = vector3(0, 0, 49.94229) ,
	authorizedJobs = { 'keycard_police','keycard_afp' },
	locked = true,

},		


---Front Dors Vespuchi
{
 objName = -1255368438,
 objCoords  = {x = -1093.1550292969, y = -819.28381347656, z = 19.186269760132 },
 textCoords  = {x = -1093.1550292969, y = -819.28381347656, z = 19.186269760132 },
 fixedpos = vector3(0, -0, -142.8956),
 authorizedJobs = { 'keycard_police','keycard_afp' },
 locked = true,
 distance = 6,
 size = 2,
 autolock = 6000
 },
 {
 objName = -1255368438,
 objCoords  = {x = -1091.1040039063, y = -817.72540283203, z = 19.186269760132 },
 textCoords  = {x = -1091.1040039063, y = -817.72540283203, z = 19.186269760132 },
 fixedpos = vector3(0, 0, 37.37489),
 authorizedJobs = { 'keycard_police','keycard_afp' },
 locked = true,
 distance = 6,
 size = 2,
 autolock = 6000
 },
 {
 objName = -147325430,
 objCoords  = {x = -1077.8118896484, y = -830.57299804688, z = 19.198949813843 },
 textCoords  = {x = -1077.8118896484, y = -830.57299804688, z = 19.198949813843 },
 fixedpos = vector3(0, 0, 37.56854),
 authorizedJobs = { 'keycard_police','keycard_afp' },
 locked = true,
 autolock = 6000
 },
 
 {
  objName = -147325430,
 objCoords  = {x = -1090.7186279297, y = -841.96533203125, z = 22.505920410156 },
 textCoords  = {x = -1090.7186279297, y = -841.96533203125, z = 22.505920410156 },
 fixedpos = vector3(0, -0, 127.6971),
 authorizedJobs = { 'keycard_police','keycard_afp' },
 locked = true,
  autolock = 8000,
},
 

  --Outdoor -1 floor Lift door
  {
  objName = -147325430,
 objCoords  = {x = -1070.7868652344, y = -834.05194091797, z = 5.6303462982178 },
 textCoords  = {x = -1070.7868652344, y = -834.05194091797, z = 5.6303462982178 },
 fixedpos = vector3(0.0003008525, 6.735473e-05, 127.5522),
 authorizedJobs = { 'keycard_police','keycard_afp' },
 locked = true,
 distance = 6,
 size = 2,
 autolock = 8000
 }, --Outdoor -1 floor
 {
 objName = -2023754432,
objCoords  = {x = -1056.7559814453, y = -839.11529541016, z = 5.3037819862366 },
textCoords  = {x = -1056.7559814453, y = -839.11529541016, z = 5.3037819862366 },
fixedpos = vector3(0, -0, -142.8956),
authorizedJobs = { 'keycard_police','keycard_afp' },
locked = true,
distance = 6,
size = 2,
autolock = 8000
},
 {
  objName = -2023754432,
 objCoords  = {x = -1058.8229980469, y = -840.68780517578, z = 5.3041172027588 },
 textCoords  = {x = -1058.8229980469, y = -840.68780517578, z = 5.3041172027588 },
 fixedpos = vector3(0, 0, 37.37211),
 authorizedJobs = { 'keycard_police','keycard_afp' },
 locked = true,
 distance = 6,
 size = 2,
 autolock = 8000
 },
 
 {
 objName = -2023754432,
objCoords  = {x = -1066.1119384766, y = -827.07928466797, z = 5.6305637359619 },
textCoords  = {x = -1066.1119384766, y = -827.07928466797, z = 5.6305637359619 },
fixedpos = vector3(-0.0003864706, 0.0004760514, -51.46591),
authorizedJobs = { 'keycard_police','keycard_afp' },
locked = true,
distance = 6,
size = 2,
autolock = 8000
},
 {
  objName = -2023754432,
 objCoords  = {x = -1064.5360107422, y = -829.14050292969, z = 5.6305637359619 },
 textCoords  = {x = -1064.5360107422, y = -829.14050292969, z = 5.6305637359619 },
 fixedpos = vector3(0.001126678, 0.0005387525, 127.5066),
 authorizedJobs = { 'keycard_police','keycard_afp' },
 locked = true,
 distance = 6,
 autolock = 8000
 },
 
{
 objName = -147325430,
 objCoords  = {x = -1090.7210693359, y = -841.96441650391, z = 18.504859924316 },
 textCoords  = {x = -1090.7210693359, y = -841.96441650391, z = 18.504859924316 },
 fixedpos = vector3(0.0002621379, -0.0002076483, 127.2385),
 authorizedJobs = { 'keycard_police','keycard_afp' },
 locked = true,
 distance = 6,
 size = 2,
 autolock = 8000
 },
  --first lot of cells
   {
  objName = 631614199,
 objCoords  = {x = -1073.5805664063, y = -827.48541259766, z = 5.6305637359619 },
 textCoords  = {x = -1073.5805664063, y = -827.48541259766, z = 5.6305637359619 },
 fixedpos = vector3(0, -0, -142.4415),
 authorizedJobs = { 'keycard_police','keycard_afp' },
 locked = true,

 },
 {
  objName = 631614199,
 objCoords  = {x = -1087.7518310547, y = -829.87469482422, z = 5.6305637359619 },
 textCoords  = {x = -1087.7518310547, y = -829.87469482422, z = 5.6305637359619 },
 fixedpos = vector3(0, -0, -142.8956),
 authorizedJobs = { 'keycard_police','keycard_afp' },
 locked = true,


 }
,
{
 objName = 631614199,
objCoords  = {x = -1088.796875, y = -830.25329589844, z = 5.6305637359619 },
textCoords  = {x = -1088.796875, y = -830.25329589844, z = 5.6305637359619 },
fixedpos = vector3(-0, -0, -52.55252),
authorizedJobs = { 'keycard_police','keycard_afp' },
locked = true,


},

 {
 objName = 631614199,
 objCoords  = {x = -1085.8259277344, y = -827.83862304688, z = 5.6305637359619 },
 textCoords  = {x = -1085.8259277344, y = -827.83862304688, z = 5.6305637359619 },
 fixedpos = vector3(-0, -0, -52.55252),
 authorizedJobs = { 'keycard_police','keycard_afp' },
 locked = true,

 },
 {
 objName = 631614199,
 objCoords  = {x = -1088.2309570313, y = -824.77227783203, z = 5.6305637359619 },
 textCoords  = {x = -1088.2309570313, y = -824.77227783203, z = 5.6305637359619 },
 fixedpos = vector3(-0, -0, -52.55252),
 authorizedJobs = { 'keycard_police','keycard_afp' },
 locked = true,

 },

{
 objName = 631614199,
objCoords  = {x = -1093.5518798828, y = -823.85827636719, z = 5.6305637359619 },
textCoords  = {x = -1093.5518798828, y = -823.85827636719, z = 5.6305637359619 },
fixedpos = vector3(-0, -0, -52.55252),
authorizedJobs = { 'keycard_police','keycard_afp' },
locked = true,

},

 {
  objName = 631614199,
 objCoords  = {x = -1090.6400146484, y = -821.62750244141, z = 5.6305637359619 },
 textCoords  = {x = -1090.6400146484, y = -821.62750244141, z = 5.6305637359619 },
 fixedpos = vector3(-0, -0, -52.55252),
 authorizedJobs = { 'keycard_police','keycard_afp' },
 locked = true,

 },
{
  objName = 631614199,
 objCoords  = {x = -1095.95703125, y = -820.72540283203, z = 5.6305637359619 },
 textCoords  = {x = -1095.95703125, y = -820.72540283203, z = 5.6305637359619 },
 fixedpos = vector3(-0, -0, -52.55252),
 authorizedJobs = { 'keycard_police','keycard_afp' },
 locked = true,

 },
 {
  objName = -2023754432,
 objCoords  = {x = -1073.5285644531, y = -821.61480712891, z = 5.6305637359619 },
 textCoords  = {x = -1073.5285644531, y = -821.61480712891, z = 5.6305637359619 },
 fixedpos = vector3(0, -0, -142.8956),
 authorizedJobs = { 'keycard_police','keycard_afp' },
 locked = true,

 },
{
 objName = -2023754432,
 objCoords  = {x = -1075.5904541016, y = -823.18377685547, z = 5.6305637359619 },
 textCoords  = {x = -1075.5904541016, y = -823.18377685547, z = 5.6305637359619 },
 fixedpos = vector3(0, 0, 37.37489),
 authorizedJobs = { 'keycard_police','keycard_afp' },
 locked = true,

 },

 {
  objName = -2023754432,
 objCoords  = {x = -1094.0969238281, y = -816.2119140625, z = 5.6305637359619 },
 textCoords  = {x = -1094.0969238281, y = -816.2119140625, z = 5.6305637359619 },
 fixedpos = vector3(-0.0001235409, 0.0002126983, -52.61831),
 authorizedJobs = { 'keycard_police','keycard_afp' },
 locked = true,
 distance = 6,

 },
 {
  objName = -2023754432,
 objCoords  = {x = -1085.0560302734, y = -812.55657958984, z = 5.6305637359619 },
 textCoords  = {x = -1085.0560302734, y = -812.55657958984, z = 5.6305637359619 },
 fixedpos = vector3(-0.0007317654, 0.001847777, 127.8124),
 authorizedJobs = { 'keycard_police','keycard_afp' },
 locked = true,
 distance = 6,

 }
,
 {
  objName = -2023754432,
 objCoords  = {x = -1086.6319580078, y = -810.49450683594, z = 5.6305637359619 },
 textCoords  = {x = -1086.6319580078, y = -810.49450683594, z = 5.6305637359619 },
 fixedpos = vector3(-0.00196771, 0.0002606079, -53.00035),
 authorizedJobs = { 'keycard_police','keycard_afp' },
 locked = true,
 distance = 6,

 },
 --Pigeon doors near lift
  {
  objName = -2023754432,
 objCoords  = {x = -1090.7269287109, y = -836.03729248047, z = 5.6320953369141 },
 textCoords  = {x = -1090.7269287109, y = -836.03729248047, z = 5.6320953369141 },
 fixedpos = vector3(0.001522081, -0.001495834, 127.3009),
 authorizedJobs = { 'keycard_police','keycard_afp' },
 locked = true,
 distance = 6,

 },
 
  {
  objName = -2023754432,
 objCoords  = {x = -1092.3039550781, y = -833.97570800781, z = 5.6320953369141 },
 textCoords  = {x = -1092.3039550781, y = -833.97570800781, z = 5.6320953369141 },
 fixedpos = vector3(-0.001908891, 0.0005704574, -52.50616),
 authorizedJobs = { 'keycard_police','keycard_afp' },
 locked = true,
 distance = 6,

 },

 

 --Vanilla Unicorn
 
 
 { --Front Door
  objName = -1116041313,
 objCoords  = {x = 127.95523834229, y = -1298.5034179688, z = 29.419622421265 },
 textCoords  = {x = 127.95523834229, y = -1298.5034179688, z = 29.419622421265 },
 fixedpos = vector3(-0.0003015524, 0.0001887208, 30.19281),
 authorizedJobs = { 'keycard_police','keycard_afp','keycard_unicorn' },
 locked = true,
 },
 {
  objName = -495720969, --Middle Door
 objCoords  = {x = 113.98224639893, y = -1297.4304199219, z = 29.418678283691 },
 textCoords  = {x = 113.98224639893, y = -1297.4304199219, z = 29.418678283691 },
 fixedpos = vector3(-2.168697e-05, 2.036331e-06, -59.73568),
 authorizedJobs = { 'keycard_police','keycard_afp','keycard_unicorn' },
 locked = true,

 },

 { --BackDoor
  objName = 668467214,
 objCoords  = {x = 96.091972351074, y = -1284.8537597656, z = 29.43878364563 },
 textCoords  = {x = 96.091972351074, y = -1284.8537597656, z = 29.43878364563 },
 fixedpos = vector3(-0.002422597, 0.001403939, -149.7858),
 authorizedJobs = { 'keycard_police','keycard_afp','keycard_unicorn'},
 locked = true,

 }
 ,
	--Car Shop
 {
 objName = 1501451068,
objCoords  = {x = -765.61932373047, y = -237.94645690918, z = 37.459785461426 },
textCoords  = {x = -765.61932373047, y = -237.94645690918, z = 37.459785461426 },
fixedpos = vector3(-1.494693, 8.761851e-05, 21.89791),
authorizedJobs = { 'keycard_police','keycard_afp','keycard_luxuryautos' },
locked = true,
distance = 10,
size = 2
},
{
 objName = 1501451068,
objCoords  = {x = -770.62860107422, y = -240.01286315918, z = 37.459983825684 },
textCoords  = {x = -770.62860107422, y = -240.01286315918, z = 37.459983825684 },
fixedpos = vector3(-1.505352, 5.987087e-05, 22.85451),
authorizedJobs = { 'keycard_police','keycard_afp','keycard_luxuryautos'  },
locked = true,
distance = 10,
size = 2
}
,
{
  objName = 1015445881,
 objCoords  = {x = -801.96221923828, y = -224.52029418945, z = 37.879753112793 },
 textCoords  = {x = -801.96221923828, y = -224.52029418945, z = 37.879753112793 },
 fixedpos = vector3(-0, -0, -60.03062),
 authorizedJobs = { 'keycard_police','keycard_afp','keycard_luxuryautos' },
 locked = true,
 distance = 4,

 },
 {
  objName = 1015445881,
 objCoords  = {x = -803.02227783203, y = -222.58409118652, z = 37.879753112793 },
 textCoords  = {x = -803.02227783203, y = -222.58409118652, z = 37.879753112793 },
 fixedpos = vector3(0, -0, 120.0742),
 authorizedJobs = { 'keycard_police','keycard_afp','keycard_luxuryautos'},
 locked = true,
 distance = 4,

 },
 {
  objName = 447044832,
 objCoords  = {x = -776.15911865234, y = -243.50129699707, z = 37.333881378174 },
 textCoords  = {x = -776.15911865234, y = -243.50129699707, z = 37.333881378174 },
 fixedpos = vector3(-0.0005891097, -0.0009740159, 21.26864),
 authorizedJobs = { 'keycard_police','keycard_afp','keycard_luxuryautos' },
 locked = true,
 distance = 4,

 },
 {
  objName = 447044832,
 objCoords  = {x = -778.18548583984, y = -244.30130004883, z = 37.333881378174 },
 textCoords  = {x = -778.18548583984, y = -244.30130004883, z = 37.333881378174 },
 fixedpos = vector3(0.0002135235, 7.338457e-05, -158.8126),
 authorizedJobs = { 'keycard_police','keycard_afp','keycard_luxuryautos' },
 locked = true,
 distance = 4,

 },


        -- Noland Racing

        -- Left Gate
    {
        objName = 'hei_prop_station_gate',
        objCoords  = {x = 1269.245, y = 2666.916, z = 36.74466},
        textCoords = {x = 1267.65, y = 2663.54, z = 38.02},
        authorizedJobs = { 'keycard_nrt','keycard_police','keycard_afp'},
        locked = true,
        distance = 16.0
    },
        -- Right Gate

    {
    objName = 'hei_prop_station_gate',
    objCoords  = {x = 1269.169, y = 2655.973, z = 36.74466},
    textCoords = {x = 1267.76, y = 2660.6, z = 38.02},
    authorizedJobs = { 'keycard_nrt','keycard_police','keycard_afp' },
    locked = true,
    distance = 16.0
},  

----Doors up in North Yankton Bank
 {
  objName = 1438783233,
 objCoords  = {x = 5310.1201171875, y = -5204.5385742188, z = 83.668601989746 },
 textCoords  = {x = 5310.1201171875, y = -5204.5385742188, z = 83.668601989746 },
 fixedpos = vector3(1.995371e-05, -3.570088e-05, -179.9597),
 authorizedJobs = { 'keycard_police','keycard_afp' },
 locked = true,
 },

 {
 objName = 1438783233,
 objCoords  = {x = 5307.5200195313, y = -5204.5385742188, z = 83.668601989746 },
 textCoords  = {x = 5307.5200195313, y = -5204.5385742188, z = 83.668601989746 },
 fixedpos = vector3(-3.001738e-05, -0.0001578619, -0.05495318),
 authorizedJobs = { 'keycard_police','keycard_afp' },
 locked = true,
 },

 
 --Grapeseed Police
 
 {
  objName = 749848321,
 objCoords  = {x = 1689.9571533203, y = 4886.3139648438, z = 42.311225891113 },
 textCoords  = {x = 1689.9571533203, y = 4886.3139648438, z = 42.311225891113 },
 fixedpos = vector3(0, -0, -171.1203),
 authorizedJobs = { 'keycard_police','keycard_afp' },
 locked = true,
 autolock = 8000
 },
 {
  objName = -538477509,
 objCoords  = {x = 1693.1589355469, y = 4880.4262695313, z = 42.311225891113 },
 textCoords  = {x = 1693.1589355469, y = 4880.4262695313, z = 42.311225891113 },
 fixedpos = vector3(0, 0, 8.334949),
 authorizedJobs = { 'keycard_police','keycard_afp' },
 locked = true,
 autolock = 8000
 },
 {
  objName = 749848321,
 objCoords  = {x = 1677.1490478516, y = 4870.0576171875, z = 42.313674926758 },
 textCoords  = {x = 1677.1490478516, y = 4870.0576171875, z = 42.313674926758 },
 fixedpos = vector3(-0, -0, -81.84715),
 authorizedJobs = { 'keycard_police','keycard_afp' },
 locked = true,
 autolock = 8000
 },
 {
  objName = -2051651622,
 objCoords  = {x = 1684.3342285156, y = 4875.984375, z = 42.311225891113 },
 textCoords  = {x = 1684.3342285156, y = 4875.984375, z = 42.311225891113 },
 fixedpos = vector3(-0, -0, -81.76544),
 authorizedJobs = { 'keycard_police','keycard_afp' },
 locked = true,
 autolock = 8000
 },
  --cELLS
 {
  objName = 631614199,
 objCoords  = {x = 1689.3330078125, y = 4883.453125, z = 42.311225891113 },
 textCoords  = {x = 1689.3330078125, y = 4883.453125, z = 42.311225891113 },
 fixedpos = vector3(0, 0, 8.334949),
 authorizedJobs = { 'keycard_police','keycard_afp' },
 locked = true,
 autolock = 8000
 },
{
  objName = 631614199,
 objCoords  = {x = 1686.15625, y = 4882.9868164063, z = 42.311225891113 },
 textCoords  = {x = 1686.15625, y = 4882.9868164063, z = 42.311225891113 },
 fixedpos = vector3(-7.968871e-05, 3.194452e-05, 7.751028),
 authorizedJobs = { 'keycard_police','keycard_afp' },
 locked = true,

 },
 {
  objName = -538477509,
 objCoords  = {x = 1686.2354736328, y = 4879.4096679688, z = 42.311225891113 },
 textCoords  = {x = 1686.2354736328, y = 4879.4096679688, z = 42.311225891113 },
 fixedpos = vector3(0, -0, 8.334949),
 authorizedJobs = { 'keycard_police','keycard_afp' },
 locked = true,
 },
 --- casino
 {
  objName = -548272800,
 objCoords  = {x = 923.42431640625, y = 42.697971343994, z = 81.532859802246 },
 textCoords  = {x = 924.18, y = 43.70, z = 81.10 },
 fixedpos = vector3(0, 0, 59.64458),
 authorizedJobs = { 'keycard_police','keycard_afp', 'keycard_casino1' },
 locked = true,
 },
 {
  objName = -548272800,
 objCoords  = {x = 924.75866699219, y = 44.823925018311, z = 81.532859802246 },
 textCoords  = {x = 924.18, y = 43.70, z = 81.10 },
 fixedpos = vector3(0, -0, -119.0462),
 authorizedJobs = { 'keycard_police','keycard_afp', 'keycard_casino1' },
 locked = true,
 },
 {
  objName = -548272800,
 objCoords  = {x = 924.91442871094, y = 45.082683563232, z = 81.532859802246 },
 textCoords  = {x = 925.61, y = 46.12, z = 81.10 },
 fixedpos = vector3(0, 0, 57.68053),
 authorizedJobs = { 'keycard_police','keycard_afp', 'keycard_casino1' },
 locked = true,
 },
 {
  objName = -548272800,
 objCoords  = {x = 926.24884033203, y = 47.208633422852, z = 81.532859802246 },
 textCoords   = {x = 925.61, y = 46.12, z = 81.10 }, 
 fixedpos = vector3(0, -0, -122.7502),
 authorizedJobs = { 'keycard_police','keycard_afp', 'keycard_casino1' },
 locked = true,
 },
 {
  objName = -548272800,
 objCoords  = {x = 926.40936279297, y = 47.475025177002, z = 81.5328590802246 },
 textCoords  = {x = 927.35, y = 48.54, z = 81.10 },
 fixedpos = vector3(0, 0, 58.00001),
 authorizedJobs = { 'keycard_police','keycard_afp', 'keycard_casino1' },
 locked = true,
 },
 {
  objName = -548272800,
 objCoords  = {x = 927.74371337891, y = 49.600978851318, z = 81.532859802246 },
 textCoords  = {x = 927.35, y = 48.54, z = 81.10 },
 fixedpos = vector3(0, -0, -121.4752),
 authorizedJobs = { 'keycard_police','keycard_afp', 'keycard_casino1' },
 locked = true,
 },
 
---^^^ Front Doors
{
  objName = -88942360,
 objCoords  = {x = 952.38031005859, y = 13.649021148682, z = 75.891036987305 },
 textCoords = {x = 952.38031005859, y = 13.649021148682, z = 75.891036987305 },
 fixedpos = vector3(0, -0, 148.00),
 authorizedJobs = { 'keycard_police','keycard_afp', 'keycard_casino1' },
 locked = true,
 },
 {
  objName = -88942360,
 objCoords  = {x = 950.47644042969, y = 8.18821144104, z = 75.891036987305 },
 textCoords = {x = 950.47644042969, y = 8.18821144104, z = 75.891036987305 },
 fixedpos = vector3(0, -0, -36.224),
 authorizedJobs = { 'keycard_police','keycard_afp', 'keycard_casino1' },
 locked = true,
 },
 --Jewellery Store
{
	 objName = 9467943,
	 objCoords  = {x = -630.42651367188, y = -238.43754577637, z = 38.206531524658 },
	 textCoords  = {x = -630.42651367188, y = -238.43754577637, z = 38.206531524658 },
	 fixedpos = vector3(-0, -0, -53.99997),
	 authorizedJobs = { 'keycard_police','keycard_afp' },
	 locked = false,
	 distance = 6,
	 size = 2
 },
 {
  objName = 1425919976,
	 objCoords  = {x = -631.95538330078, y = -236.33326721191, z = 38.206531524658 },
	 textCoords  = {x = -631.95538330078, y = -236.33326721191, z = 38.206531524658 },
	 fixedpos = vector3(-0, -0, -53.99997),
	 authorizedJobs = { 'keycard_police','keycard_afp' },
	 locked = false,
	 distance = 6,
	 size = 2
 }

	           
	--
	-- Addons
	--

	--[[
	-- Entrance Gate (Mission Row mod) https://www.gta5-mods.com/maps/mission-row-pd-ymap-fivem-v1
	{
		objName = 'prop_gate_airport_01',
		objCoords  = {x = 420.133, y = -1017.301, z = 28.086},
		textCoords = {x = 420.133, y = -1021.00, z = 32.00},
		authorizedJobs = { 'keycard_police','keycard_afp' },
		locked = true,
		distance = 14,
		size = 2
	}
	--]]
}