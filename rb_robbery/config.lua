Config = {}
Translation = {}

 -- hash of the shopkeeper ped
Config.Locale = 'en' -- 'en', 'sv' or 'custom'

Config.ShopKeepers = 
{
`s_m_y_busboy_01`,
`ig_chef`,
`g_m_m_chigoon_01`,
`mp_m_shopkeep_01`,
`s_f_y_shop_low`,
`a_m_m_soucent_02`,
`s_f_y_shop_mid`,
`a_f_y_soucent_01`,
`a_f_m_soucent_01`,
`u_f_y_comjane`

}


Config.HighClothes = 
{
`u_m_y_antonb`,
`u_f_y_comjane`


}

Config.Gun = 
{
`u_m_y_antonb`

}

Config.Bank = 
{
`u_m_m_bankman`,
`ig_bankman`,
`ig_barry`,
`a_f_y_bevhills_01`,
`a_f_m_bevhills_02`,
`a_f_y_business_03`,
`u_m_o_finguru_01`

}

Config.NotifyCops = 1100*60*15

Config.Shops = {


 
      
    -- {coords = vector3(x, y, z), heading = peds heading, money = {min, max}, cops = amount of cops required to rob, blip = true: add blip on map false: don't add blip, name = name of the store (when cops get alarm, blip name etc)}
    {coords = vector3(24.03, -1345.63, 29.5-0.98), heading = 266.0, money = {750, 2300}, cops = 0, blip = false, type="s", name = '24/7 Strawberry', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false, },
    {coords = vector3(-705.73, -914.91, 19.22-0.98), heading = 91.0, money = {750, 2300}, cops = 0, blip = false, type="s", name = 'LTD Little Seoul', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false, },
	{coords = vector3(-47.59, -1759.25, 29.42-0.98), heading = 67.97, money = {750, 2300}, cops = 0, blip = false, type="s", name = 'LTD Grove St', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false,},
	{coords = vector3(2678.08,  3279.31, 55.24 -0.98), heading = 330.17, money = {750, 2300}, cops = 0, blip = false, type="s", name = '24/7 Sandy Freeway', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false,},
	{coords = vector3(549.03 , 2671.88, 42.16 -0.98), heading = 89.19, money = {750, 2300}, cops = 0, blip = false, type="s", name = '24/7 Harmony', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false,},
	{coords = vector3(1960.25, 3739.67, 32.34 -0.98), heading = 293.23, money = {750, 2300}, cops = 0, blip = false, type="s", name = '24/7 Sandy', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false,},
	{coords = vector3(1392.24,  3606.19, 34.98 -0.98), heading =  199.81, money = {750, 2300}, cops = 0, blip = false, type="s", name = 'Robs Liquor Sandy', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false,},
	{coords = vector3( 1727.72, 6415.06, 35.04  -0.98), heading =  238.71, money = {750, 2300}, cops = 0, blip = false, type="s", name = '24/7 Paleto Freeway', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false,},
	{coords = vector3( -2966.32, 391.54, 15.04 -0.98), heading =  96.48, money = {750, 2300}, cops = 0, blip = false, type="s", name = 'Robs Liquor Great Ocean Hwy', cooldown = {hour = 0, minute = 0, second = 0}, robbed = false, dead=false,},
	{coords = vector3( -1221.33,  -907.88, 12.33-0.98), heading =  39.61, money = {750, 2300}, cops = 0, blip = false, type="s", name = 'Robs Liquor - Canals', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false,},
	{coords = vector3( 1164.95 , -323.79, 69.21-0.98), heading =   105.08, money = {750, 2300}, cops = 0, blip = false, type="s", name = 'LTD Mirror Park', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false,},
	{coords = vector3( 1134.28,  -983.13, 46.42-0.98), heading =   274.33, money = {750, 2300}, cops = 0, blip = false, type="s", name = 'Robs Liquor Elrancho', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false,},
	{coords = vector3( 372.31,  325.84, 103.57-0.98), heading =  257.47, money = {750, 2300}, cops = 0, blip = false, type="s", name = '24/7 Vinewood', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false,},
	{coords = vector3( 2557.78, 380.7,  108.62-0.98), heading =  357.47, money = {750, 2300}, cops = 0, blip = false, type="s", name = '24/7 Palomino Fwy', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false,},
	{coords = vector3( -3241.68, 999.86, 12.83 -0.98), heading =  353.05, money = {750, 2300}, cops = 0, blip = false, type="s", name = '24/7 Great Ocean Fwy - Lower 2', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false,},
	{coords = vector3(-1819.41, 793.43, 138.09-0.98), heading =  125.64, money = {750, 2300}, cops = 0, blip = false, type="s", name = 'LTD Banham Canyon Dr', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false,},	
	{coords = vector3(1165.52, 2710.83, 38.16 -0.98), heading =  174.9, money = {750, 2300}, cops = 0, blip = false, type="s", name = 'Scoops Liquor Barn Harmony', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false,},	
	{coords = vector3(1697.08,4923.51, 42.06-0.98), heading =  326.07, money = {750, 2300}, cops = 0, blip = false, type="s", name = 'LTD Grapeseed', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false,},	
	{coords = vector3(-1486.77,   -377.42, 40.16-0.98), heading =  140.81, money = {750, 2300}, cops = 0, blip = false, type="s", name = 'Robs Liquor Morningwood', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false,},	
	{coords = vector3(-3038.67, 584.65, 7.91-0.98), heading =  19.11, money = {850, 1800}, cops = 0, blip = false, type="s", name = '24/7 Banham Canyon', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false,},	
	{coords = vector3(160.36730957031,6641.630859375,31.526470184326-0.98), heading =  214.23, money = {500, 1500}, cops = 0, blip = false, type="s", name = '24/7 Paleto Bay Servo', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false,},	
	

		    
	{coords = vector3( -3169.18,  1043.69, 20.86-0.98), heading = 65.85, money = {880, 3300}, cops = 0, blip = false, type="m", name = 'Suburban Great Ocean Fwy', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false, shopkeeper=`ig_molly`},
	{coords = vector3( 127.09, -233.8, 54.56 -0.98), heading = 76.64, money = {880, 3300}, cops = 0, blip = false, type="m", name = 'Suburban Harwick', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false, shopkeeper=`ig_molly`},
	{coords = vector3(612.91,  2762.13,  42.09 -0.98), heading = 260.05, money = {880, 3300}, cops = 0, blip = false, type="m", name = 'Suburban Harmony', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false, shopkeeper=`a_f_y_business_04`},
	{coords = vector3(-1194.51, -767.42, 17.32-0.98), heading = 220.82, money = {880, 3300}, cops = 0, blip = false, type="m", name = 'Suburban Del Perro', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false, shopkeeper=`s_f_y_shop_low`},
	
	
	{coords = vector3(-709.4,  -151.04, 37.42-0.98), heading =  126.94, money = {950, 3900}, cops = 0, blip = false, type="m", name = 'Ponsonbys Rockford Hills', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false, shopkeeper=`cs_debra`},
	{coords = vector3( -165.26, -303.79, 39.73-0.98), heading =  262.95, money = {950, 3900}, cops = 0, blip = false, type="m", name = 'Ponsonbys Burton', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false, shopkeeper=`a_f_y_business_04`},
	
	{coords = vector3(-1448.08, -237.26,39.73-0.98), heading =  63.89, money = {950, 2900}, cops = 0, blip = false, type="m", name = 'Ponsonbys Morningwood', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false, shopkeeper=`cs_debra`},
	
	{coords = vector3(77.24, -1387.57,  29.38-0.98), heading =  188.87, money = {200, 2300}, cops = 0, blip = false, type="m", name = 'Discount Clothes Strawberry', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false, shopkeeper=`ig_ashley`},
	{coords = vector3(1196.82,  2711.67, 38.22-0.98), heading =  186.97, money = {200, 2300}, cops = 0, blip = false, type="m", name = 'Discount Clothes Harmony', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false, shopkeeper=`s_f_y_shop_low`},
	{coords = vector3(1695.44, 4822.87, 42.06-0.98), heading =  96.13, money = {200, 2300}, cops = 0, blip = false, type="m", name = 'Discount Clothes Grapeseed', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false, shopkeeper=`ig_ashley`},
	{coords = vector3(5.65, 6511.25, 31.88-0.98), heading =  23.25, money = {200, 2300}, cops = 0, blip = false, type="m", name = 'Discount Clothes Paleto Bay', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false, shopkeeper=`s_f_y_shop_low`},
	
	{coords = vector3(-822.86, -1072.12, 11.33-0.98), heading = 209.11, money = {200, 2300}, cops = 0, blip = false, type="m", name = 'Binco Clothes Store - Canals', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false, shopkeeper=`s_f_y_shop_low`},
	
	{coords = vector3(427.04, -806.56, 29.49-0.98), heading = 83.25, money = {200, 2300}, cops = 0, blip = false, type="m", name = 'Binco Clothes Store - Sinner St', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false, shopkeeper=`s_f_y_shop_low`},
	
	{coords = vector3(-1102.38, 2711.66, 19.11-0.98), heading = 219.9, money = {100, 2300}, cops = 0, blip = false, type="m", name = 'Discount Store - Zancudo River', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false, shopkeeper=`s_f_y_shop_low`},
	

	  
	{coords = vector3(22.91,  -1105.27, 28.8 -0.98), heading = 167.59, money = {880, 2300}, cops = 0, blip = false, type="g", name = 'City Gun Shop', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false, shopkeeper=`mp_m_exarmy_01`},
	{coords = vector3(253.4, -51.62, 69.94 -0.98), heading =  74.34, money = {880, 2300}, cops = 0, blip = false,  type="g", name = 'Hawick Gun Shop', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false, shopkeeper=`ig_cletus`},
	{coords = vector3(-661.16, -933.5, 21.83 -0.98), heading = 164.9, money = {880, 2300}, cops = 0, blip = false, type="g", name = 'Little Seoul Gun Shop', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false, shopkeeper=`g_m_y_mexgoon_01`},
	{coords = vector3(841.62, -1035.39, 28.19 -0.98), heading = 7.14, money = {880, 2300}, cops = 0, blip = false, type="g", name = 'La Mesa Gun Shop', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false, shopkeeper=`a_m_m_farmer_01`},
	{coords = vector3(809.55, -2159.11, 29.62 -0.98), heading = 353.49, money = {880, 2300}, cops = 0, blip = false, type="g", name = 'Cypress Flats Gun Shop', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false, shopkeeper=`ig_cletus`},
	{coords = vector3(2567.08, 292.55, 108.73 -0.98), heading = 352.76, money = {880, 2300}, cops = 0, blip = false, type="g", name = 'Palomino Fwy Gun Shop', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false, shopkeeper=`g_m_y_mexgoon_01`},
	{coords = vector3(-331.02, 6085.66, 31.45 -0.98), heading = 205.35, money = {880, 2300}, cops = 0, blip = false, type="g", name = 'Paleto Bay Gun Shop', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false, shopkeeper=`mp_m_exarmy_01`},	

	{coords = vector3(1692.92, 3761.62, 34.71 -0.98), heading = 227.68, money = {880, 2300}, cops = 0, blip = false, type="g", name = 'Sandy Shores Gun Shop', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false, shopkeeper=`mp_m_exarmy_01`},	
	{coords = vector3(-1304.2, -395.23, 36.7 -0.98), heading = 83.03, money = {880, 2300}, cops = 0, blip = false, type="g", name = 'Morningwood Gun Shop', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false, shopkeeper=`mp_m_exarmy_01`},	
	{coords = vector3(-1118.62, 2700.15, 18.55 -0.98), heading = 214.11, money = {880, 2300}, cops = 0, blip = false, type="g", name = 'Zancudo River Gun Shop', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false, shopkeeper=`mp_m_exarmy_01`},	        
			
			
		 
		
	
	{coords = vector3(-30.8 , -151.8, 57.08 -0.98), heading =  333.5 , money = {880, 2500}, cops = 0, blip = false,  type="m", name = 'Hair on Harwick', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false,},
	{coords = vector3(134.48, -1707.8, 29.29 -0.98), heading = 137.52 , money = {750, 1000}, cops = 0, blip = false,  type="m", name = 'Herr Kutz Barber - Davis', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false,},
	{coords = vector3(-1284.18, -1115.55, 6.99 -0.98), heading = 85.63 , money = {880, 1600}, cops = 0, blip = false,  type="m", name = 'Beachcombover Barbers - Vespucci', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false,},
	{coords = vector3(1931.09, 3728.37, 32.84 -0.98), heading = 198.36 , money = {750, 1000}, cops = 0, blip = false,  type="m", name = "O'SHEAS BARBERS Sandy Shores", cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false,},
	{coords = vector3(-277.99, 6230.22, 31.7-0.98), heading = 18.86, money = {750, 1000}, cops = 0, blip = false,  type="m", name = 'Herr Kutz Barber - Paleto Bay', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false,},
	{coords = vector3(1211.49, -470.76, 66.21-0.98), heading = 81.64, money = {750, 1000}, cops = 0, blip = false,  type="m", name = 'Herr Kutz Barber - Mirror Park', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false,},
	{coords = vector3(-822.13, -183.54, 37.57 -0.98), heading = 204.3, money = {750, 1000}, cops = 0, blip = false,  type="m", name = 'Bob Mule - Hair & Beauty Rockford Hills', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false,},	   
	
	 
	{coords = vector3(1862.45, 3748.35, 33.03-0.98), heading = 25.98, money = {750, 2300}, cops = 0, blip = false,  type="m", name = 'Sandy Shores Tattoo', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false,},
	{coords = vector3(-291.98, 6199.84, 31.49-0.98), heading = 247.11, money = {750, 2300}, cops = 0, blip = false,  type="m", name = 'Paleto Bay Tattoo', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false,},
	{coords = vector3(-3170.47, 1073.07,  20.83-0.98), heading = 344.4, money = {750, 2300}, cops = 0, blip = false,  type="m", name = 'Ink Inc Tattoos - Great Ocean Hwy', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false,},    
	{coords = vector3(319.93, 181.2, 103.59-0.98), heading = 236.99, money = {750, 2300}, cops = 0, blip = false,  type="m", name = 'Blazing Tattoos Vinewood', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false,},       
	{coords = vector3(-1152.21, -1423.9, 4.95-0.98), heading = 134.04, money = {750, 2300}, cops = 0, blip = false,  type="m", name = 'The Pit Tattoos - City Beach', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false,},   
	{coords = vector3(1324.72, -1650.36, 52.28-0.98), heading = 113.9, money = {750, 2300}, cops = 0, blip = false,  type="m", name = 'Los Santos Tattoos - ElBurro Heights', cooldown = {hour = 0, minute = 30, second = 0}, robbed = false, dead=false,},          
			 
			 
	
		   		   	  --Banks
	{coords = vector3( 1174.88,  2708.22, 38.09 -0.98), heading = 167.51, money = {1500, 3500}, cops = 1, blip = false,  type="b", name = 'Fleeca Bank - Harmony', cooldown = {hour = 1, minute = 0, second = 0}, robbed = false, dead=false,}, 
	{coords = vector3(  149.64, -1042.13, 29.37 -0.98), heading = 356.75, money = {1500, 3500}, cops = 1, blip = false,  type="b", name = 'Fleeca Bank - Legion Square', cooldown = {hour = 1, minute = 0, second = 0}, robbed = false, dead=false,},    
	{coords = vector3(  243.49, 226.37, 106.29 -0.98), heading = 156.09, money = {2000, 3500}, cops = 1, blip = false,  type="b", name = 'Fleeca Bank - Principal Bank', cooldown = {hour = 1, minute = 0, second = 0}, robbed = false, dead=false,},    
	{coords = vector3( -112.21, 6471.09, 31.63 -0.98), heading = 139.55, money = {1500, 3500}, cops = 1, blip = false,  type="b", name = 'Blaine County Savings & Loan - Paleto', cooldown = {hour = 1, minute = 0, second = 0}, robbed = false, dead=false,}, 
	{coords = vector3( -2961.11, 482.98, 15.7 -0.98), heading = 94.26, money = {1500, 3500}, cops = 1, blip = false,  type="b", name = 'Fleeca Bank - Great Ocean Hwy', cooldown = {hour = 1, minute = 0, second = 0}, robbed = false, dead=false,}, 	 
	 
	 
	 
}
    
	
	     
         
Translation = {
    ['en'] = {
        ['shopkeeper'] = 'shopkeeper',
        ['robbed'] = "I was just robbed and ~r~don't ~w~have any money left!",
        ['cashrecieved'] = 'You stole:',
        ['currency'] = '$',
        ['scared'] = 'Scared:',
        ['no_cops'] = 'There are ~r~not~w~ enough police online!',
        ['cop_msg'] = 'Smash n Grab: Suspect fleeing the store, here is a picture from CCTV!',
        ['set_waypoint'] = 'Set waypoint to the store',
        ['hide_box'] = 'Close this box',
        ['robbery'] = 'Robbery in progress',
        ['walked_too_far'] = 'You walked too far away!'
    },
    ['sv'] = {
        ['shopkeeper'] = 'butiksbiträde',
        ['robbed'] = 'Jag blev precis rånad och har inga pengar kvar!',
        ['cashrecieved'] = 'Du fick:',
        ['currency'] = 'SEK',
        ['scared'] = 'Rädd:',
        ['no_cops'] = 'Det är inte tillräckligt med poliser online!',
        ['cop_msg'] = 'Vi har skickat en bild på rånaren från övervakningskamerorna!',
        ['set_waypoint'] = 'Sätt GPS punkt på butiken',
        ['hide_box'] = 'Stäng denna rutan',
        ['robbery'] = 'Pågående butiksrån',
        ['walked_too_far'] = 'Du gick för långt bort!'
    },
    ['custom'] = { -- edit this to your language
        ['shopkeeper'] = '',
        ['robbed'] = '',
        ['cashrecieved'] = '',
        ['currency'] = '',
        ['scared'] = '',
        ['no_cops'] = '',
        ['cop_msg'] = '',
        ['set_waypoint'] = '',
        ['hide_box'] = '',
        ['robbery'] = '',
        ['walked_too_far'] = ''
    }
}