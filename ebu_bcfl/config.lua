-----COPYRIGHT/OWNER INFO-----
-- Author: Theebu#9267
-- Copyright- This work is protected by:
-- "http://creativecommons.org/licenses/by-nc-nd/4.0/"
-- Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License
-- You must:    Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made.
--                            You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
--              NonCommercial — You may not use the material for commercial purposes. IE you may not sell this
--
-- You may:     Remix, transform, or build upon the material, however you may not distribute that material
--
-- TL;DR: Use this as you will, just don't share it.
-- I only ask you follow this as this is a labor of love. If you wish to share this work with others,
-- send them to: 

Config = {}

Config.MarkerType    			  = 25
Config.MarkerColor                = { r = 0, g = 255, b = 100 }
Config.CarMarkerSize   			  = { x = 2.0, y = 2.0, z = 1.0 }
Config.BikeMarkerSize   		  = { x = 1.0, y = 1.0, z = 1.0 }


Config.bikes = {8,13}
Config.cars  = {0,1,2,3,4,5,6,7,9,11,12,17,18}
Config.large = {10,11,19,20}
Config.boats = {14}

Config.UseESX = false
Config.ShowMarkers = true

AddTextEntry('VEH_E_UPACK','Press ~INPUT_CONTEXT~ to deploy. ~INPUT_DETONATE~ to unpack')
AddTextEntry('VEH_E_PACK','Press ~INPUT_CONTEXT~ to deploy. ~INPUT_DETONATE~ to pack')
AddTextEntry('VEH_E_DOOR','Press ~INPUT_CONTEXT~ to open / close door')
AddTextEntry('VEH_E_ELE','Press ~INPUT_CONTEXT~ extend / retract ramp. ~INPUT_DETONATE~ for elevator.')
AddTextEntry('VEH_E_DETATCH', 'Press ~INPUT_CONTEXT~ to detach the vehicle')        -- Text for external detach point
AddTextEntry('VEH_I_AORDBC', 'Press ~INPUT_CONTEXT~ to attach/detach the vehicle. ~INPUT_DETONATE~ for elevator.')   -- Text for in boat attach/detach
