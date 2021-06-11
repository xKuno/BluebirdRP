-----COPYRIGHT/OWNER INFO-----
-- Author: Theebu#9267
-- Copyright- This work is protected by:
-- "http://creativecommons.org/licenses/by-nc-nd/4.0/"
-- Creative Commons Attribution-NonCommercial-NoDerivatives 4.0 International License
-- You must:    Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made.
--                     You may do so in any reasonable manner, but not in any way that suggests the licensor endorses you or your use.
--              NonCommercial — You may not use the material for commercial purposes. IE you may not sell this



Config = {}

Config.MarkerType    			  = 25
Config.MarkerColor                = { r = 0, g = 255, b = 100 }
Config.CarMarkerSize   			  = { x = 2.0, y = 2.0, z = 1.0 }
Config.BikeMarkerSize   		  = { x = 1.0, y = 1.0, z = 1.0 }


Config.bikes        = {8,13}
Config.cars         = {0,1,2,3,4,5,6,7,9,10,11,12,17,18,15}
Config.large        = {10,11,19,20}
Config.boats        = {14}

Config.ShowMarkers  = true
Config.UseESX       = true  --allows for menu of attached cars -optional

AddTextEntry('VEH_E_DETATCH', 'Press ~INPUT_VEH_HORN~ to detach the vehicle')        -- Text for external detach point
AddTextEntry('VEH_I_AORD', 'Press ~INPUT_VEH_HORN~ to attach/detach the vehicle')   -- Text for in boat attach/detach
AddTextEntry('VEH_I_RAMP', 'Press ~INPUT_VEH_HORN~ to toggle the ramp')   -- Text for in boat attach/detach

Config.Trailers = {
    {  --cotrailer
        model = `cotrailer`,
        
        hasRamp = true,
        unloadPos = {vector3(-2.0,2.0,-0.55)},
        rampPos = {vector3(-2.0,-4.0,-0.55),vector3(2.0,-4.0,-0.55)},
        isRampExtra = false,
        rampDoorNum = 5,
        doorwithRamp = false,
        doorwithRampNums = {},
        closeTrunk = false,
        hasDoors = false,
        doorPositions = {},
        doorText = '',
        width = 3.0,
        length = 9.0,
        loffset = -1.0

    },
    {  --shauler
        model = `shauler`,
        
        hasRamp = true,
        unloadPos = {vector3(-2.0,2.0,0.25)},
        rampPos = {vector3(-2.0,-4.0,0.25),vector3(2.0,-4.0,0.25)},
        isRampExtra = false,
        rampDoorNum = 5,
        doorwithRamp = false,
        doorwithRampNums = {},
        closeTrunk = false,
        hasDoors = false,
        doorPositions = {},
        doorText = '',
        width = 3.0,
        length = 11.0,
        loffset = 0.0

    },
  --[[  {  --godzcoe
        model = `godzcoe`,
        
        hasRamp = false,
        unloadPos = {vector3(-2.0,2.0,-0.25)},
        rampPos = {vector3(-2.0,-4.0,-0.55),vector3(2.0,-4.0,-0.55)},
        isRampExtra = false,
        rampDoorNum = 5,
        doorwithRamp = false,
        doorwithRampNums = {},
        closeTrunk = false,
        hasDoors = false,
        doorPositions = {},
        doorText = '',
        width = 3.0,
        length = 10.0,
        loffset = -1.0

    },--]]
    {  --thauler
        model = `eagerbeaver`,
        
        hasRamp = true,
        unloadPos = {vector3(-1.5,1.5,-0.25)},
        rampPos = {vector3(1.5, -3.0, -0.25), vector3(-1.5, -3.0, -0.25)},
        isRampExtra = false,
        rampDoorNum = 5,
        doorwithRamp = false,
        doorwithRampNums = {},
        closeTrunk = false,
        hasDoors = false,
        doorPositions = {},
        doorText = '',
        width = 2.0,
        length = 8.0,
        loffset = -0.0

    },
    {  --btrailer
        model = `btrailer`,
        
        hasRamp = true,
        unloadPos = {vector3(-1.5,1.5,-0.45)},
        rampPos = {vector3(1.5, -3.0, -0.45), vector3(-1.5, -3.0, -0.45)},
        isRampExtra = false,
        rampDoorNum = 5,
        doorwithRamp = false,
        doorwithRampNums = {},
        closeTrunk = false,
        hasDoors = false,
        doorPositions = {},
        doorText = '',
        width = 2.0,
        length = 6.0,
        loffset = -0.0

    },
 {  --trailersmall
        model = `trailersmall`,
        
        hasRamp = true,
        unloadPos = {vector3(-1.5,1.5,-0.2)},
        rampPos = {vector3(1.5, -3.0, -0.2), vector3(-1.5, -3.0, -0.2)},
        isRampExtra = false,
        rampDoorNum = 5,
        doorwithRamp = false,
        doorwithRampNums = {},
        closeTrunk = false,
        hasDoors = false,
        doorPositions = {},
        doorText = '',
        width = 2.0,
        length = 6.0,
        loffset = -0.0

    },
    {  --bclandscape
        model = `bclandscape`,
        
        hasRamp = true,
        unloadPos = {vector3(-1.5,-1.0,-0.45)},
        rampPos = {vector3(1.5, -4.0, -0.45), vector3(-1.5, -4.0, -0.45)},
        isRampExtra = false,
        rampDoorNum = 5,
        doorwithRamp = false,
        doorwithRampNums = {},
        closeTrunk = false,
        hasDoors = false,
        doorPositions = {},
        doorText = '',
        width = 2.0,
        length = 6.0,
        loffset = -0.0

    },
    {  --camperman
        model = `camperman`,
        
        hasRamp = true,
        unloadPos = {vector3(0.3,-6.5,0.8)},
        rampPos = {vector3(2.0, -6.0, 0.1), vector3(-1.5, -6.0, 0.1)},
        isRampExtra = false,
        rampDoorNum = 4,
        doorwithRamp = false,
        doorwithRampNums = {},
        closeTrunk = false,
        hasDoors = false,
        doorPositions = {},
        doorText = '',
        width = 3.0,
        length = 14.0,
        loffset = -0.0

    },
    {  --chauler
        model = `chauler`,
        hasRamp = true,
        unloadPos = {vector3(-1.5, 2.5, -0.25)},
        rampPos = {vector3(1.5, -2.7, -0.25), vector3(-1.5, -2.7, -0.25)},
        isRampExtra = false,
        rampDoorNum = 5,
        doorwithRamp = false,
        doorwithRampNums = {},
        closeTrunk = true,
        hasDoors = false,
        doorPositions = {},
        doorText = '',
        width = 2.0,
        length = 8.0,
        loffset = -1.0
    },
    {  --cartrailer
        model = `cartrailer`,
        
        hasRamp = true,
        unloadPos = {vector3(-2.0,1.0, -0.75)},
        rampPos = {vector3(1.5, -3.7, -1.0), vector3(-1.5, -3.7, -1.0)},
        isRampExtra = true,
        rampDoorNum = 5,
        doorwithRamp = false,
        rampextraNum = 1,
        doorwithRampNums = {},
        closeTrunk = true,
        hasDoors = false,
        doorPositions = {},
        doorText = '',
        width = 2.0,
        length = 8.0,
        loffset = -1.0
    },
    {  --semihauler
        model = `semihauler`,
        
        hasRamp = true,
        unloadPos = {vector3(-1.8,0.0,-1.4)},
        rampPos = {vector3(-1.8, -7.5, -1.4), vector3(1.8, -7.5, -1.4)},
        isRampExtra = false,
        rampDoorNum = 5,
        doorwithRamp = false,
        doorwithRampNums = {},
        closeTrunk = false,
        hasDoors = false,
        doorPositions = {},
        doorText = '',
        width = 3.0,
        length = 14.0,
        loffset = 0.0
    },
    {  --bigtex20
        model = `bigtex20`,
        
        hasRamp = true,
        unloadPos = {vector3(-1.8,3.0,-0.8)},
        rampPos = {vector3(-1.8, -3.0, -0.8), vector3(1.8, -3.0, -0.8)},
        isRampExtra = false,
        rampDoorNum = 5,
        doorwithRamp = false,
        doorwithRampNums = {},
        closeTrunk = false,
        hasDoors = false,
        doorPositions = {},
        doorText = '',
        width = 2.5,
        length = 8.0,
        loffset = 0.5
    },
{  --bigtex40
        model = `bigtex40`,
        
        hasRamp = true,
        unloadPos = {vector3(-1.8,5.0,-0.8)},
        rampPos = {vector3(-1.8, -5.0, -0.8), vector3(1.8, -5.0, -0.8)},
        isRampExtra = false,
        rampDoorNum = 5,
        doorwithRamp = false,
        doorwithRampNums = {},
        closeTrunk = false,
        hasDoors = false,
        doorPositions = {},
        doorText = '',
        width = 2.5,
        length = 11.0,
        loffset = 0.0
    },
    --[[{  --godzhauler
        model = `carhauler`,
        
        hasRamp = true,
        unloadPos = {vector3(-1.8, 1.0,0.1)},
        rampPos = {vector3(-1.8, -5.0, 0.1), vector3(1.8, -5.0, 0.1)},
        isRampExtra = false,
        rampDoorNum = 5,
        doorwithRamp = false,
        doorwithRampNums = {},
        closeTrunk = false,
        hasDoors = false,
        doorPositions = {},
        doorText = '',
        width = 2.5,
        length = 16.0,
        loffset = 0.0
    },
    {  --godzenclosed
        model = `godzenclosed`,
        
        hasRamp = true,
        unloadPos = {vector3(0.0, -6.0, -0.5)},
        rampPos = {vector3(-1.8, -5.5, -0.5), vector3(1.8, -5.5, -0.5)},
        isRampExtra = false,
        rampDoorNum = -1,
        doorwithRamp = true,
        rampextraNum = 3,
        doorwithRampNums = {2,3},
        closeTrunk = false,
        hasDoors = true,
        doorPositions = {},
        doorText = '',
        width = 2.5,
        length = 11.0,
        loffset = -1.5
    },--]]
    {  --enclosedgoose
        model = `enclosedgoose`,
        
        hasRamp = true,
        unloadPos = {vector3(0.0, -6.0, 0.0)},
        rampPos = {vector3(-1.8, -5.5, -0.5), vector3(1.8, -5.5, -0.5)},
        isRampExtra = false,
        rampDoorNum = 5,
        doorwithRamp = false,
        rampextraNum = -1,
        doorwithRampNums = {},
        closeTrunk = false,
        hasDoors = false,
        doorPositions = {},
        doorText = '',
        width = 2.5,
        length = 12.0,
        loffset = -0.5
    },
    --[[{  --godzbenson
        model = `godzbenson`,
        
        hasRamp = true,
        unloadPos = {vector3(0.0, -6.0, -1.0)},
        rampPos = {vector3(-1.8, -5.5, -1.0), vector3(1.8, -5.5, -1.0)},
        isRampExtra = false,
        rampDoorNum = 5,
        doorwithRamp = false,
        rampextraNum = -1,
        doorwithRampNums = {},
        closeTrunk = false,
        hasDoors = false,
        doorPositions = {},
        doorText = '',
        width = 2.8,
        length = 10.0,
        loffset = -0.5
    },--]]
    {  --trailers3
        model = `trailers3`,
        
        hasRamp = true,
        unloadPos = {vector3(0.0, -5.5, -1.50)},
        rampPos = {vector3(-1.8, -5.5, -3.0), vector3(1.8, -5.5, -3.0)},
        isRampExtra = false,
        rampDoorNum = 5,
        doorwithRamp = false,
        doorwithRampNums = {},
        closeTrunk = false,
        hasDoors = false,
        doorPositions = {},
        doorText = '',
        width = 2.0,
        length = 12.0,
        loffset = -0.3
    },
    {  --trflat
        model = `trflat`,
        
        hasRamp = false,
        unloadPos = {vector3(-2.0, 0.0, -1.00),vector3(2.0, 0.0, -1.00)},
        rampPos = {vector3(-1.8, -5.5, 0.0), vector3(1.8, -5.5, 0.0)},
        isRampExtra = false,
        rampDoorNum = 5,
        doorwithRamp = false,
        doorwithRampNums = {},
        closeTrunk = false,
        hasDoors = false,
        doorPositions = {},
        doorText = '',
        width = 2.0,
        length = 12.0,
        loffset = -0.3
    },
    --[[{  --17fontaine
        model = `17fontaine`,
        
        hasRamp = false,
        unloadPos = {vector3(-2.0, 0.0, -0.3),vector3(2.0, 0.0, -0.3)},
        rampPos = {vector3(-1.8, -5.5, -3.0), vector3(1.8, -5.5, -3.0)},
        isRampExtra = false,
        rampDoorNum = 5,
        doorwithRamp = false,
        doorwithRampNums = {},
        closeTrunk = false,
        hasDoors = false,
        doorPositions = {},
        doorText = '',
        width = 2.0,
        length = 14.0,
        loffset = -0.3
    },
    {  --17fontainev2
        model = `17fontainev2`,
        
        hasRamp = false,
        unloadPos = {vector3(-2.0, 0.0, -0.3),vector3(2.0, 0.0, -0.3)},
        rampPos = {vector3(-1.8, -5.5, -3.0), vector3(1.8, -5.5, -3.0)},
        isRampExtra = false,
        rampDoorNum = 5,
        doorwithRamp = false,
        doorwithRampNums = {},
        closeTrunk = false,
        hasDoors = false,
        doorPositions = {},
        doorText = '',
        width = 2.0,
        length = 14.0,
        loffset = -0.3
    },
    {  --17fontainev3
        model = `17fontainev3`,
        
        hasRamp = false,
        unloadPos = {vector3(-2.0, 0.0, -0.3),vector3(2.0, 0.0, -0.3)},
        rampPos = {vector3(-1.8, -5.5, -3.0), vector3(1.8, -5.5, -3.0)},
        isRampExtra = false,
        rampDoorNum = 5,
        doorwithRamp = false,
        doorwithRampNums = {},
        closeTrunk = false,
        hasDoors = false,
        doorPositions = {},
        doorText = '',
        width = 2.0,
        length = 14.0,
        loffset = -0.3
    },
    {  --17fontainev4
        model = `17fontainev4`,
        
        hasRamp = false,
        unloadPos = {vector3(-2.0, 0.0, -0.3),vector3(2.0, 0.0, -0.3)},
        rampPos = {vector3(-1.8, -5.5, -3.0), vector3(1.8, -5.5, -3.0)},
        isRampExtra = false,
        rampDoorNum = 5,
        doorwithRamp = false,
        doorwithRampNums = {},
        closeTrunk = false,
        hasDoors = false,
        doorPositions = {},
        doorText = '',
        width = 2.0,
        length = 14.0,
        loffset = -0.3
    },--]]
    {  --20fttrailer
        model = `20fttrailer`,
        
        hasRamp = true,
        unloadPos = {vector3(-2.0,1.0, -0.75)},
        rampPos = {vector3(1.5, -3.7, -1.0), vector3(-1.5, -3.7, -1.0)},
        isRampExtra = true,
        rampDoorNum = 3,
        doorwithRamp = false,
        rampextraNum = 3,
        doorwithRampNums = {},
        closeTrunk = true,
        hasDoors = false,
        doorPositions = {},
        doorText = '',
        width = 2.5,
        length = 6.5,
        loffset = -3.2
    },
{  --pjtrailer
        model = `pjtrailer`,
        
        hasRamp = true,
        unloadPos = {vector3(-1.8,5.0,-0.8)},
        rampPos = {vector3(-1.8, -5.0, -0.8), vector3(1.8, -5.0, -0.8)},
        isRampExtra = false,
        rampDoorNum = 5,
        doorwithRamp = false,
        doorwithRampNums = {},
        closeTrunk = false,
        hasDoors = false,
        doorPositions = {},
        doorText = '',
        width = 2.5,
        length = 12.0,
        loffset = 0.0
    },
{  --bcfl
        model = `bcfl`,
        
        hasRamp = true,
        unloadPos = {vector3(0.0, -1.0, 0.2)},
        rampPos = {vector3(-2.0, -8.0, 0.0), vector3(2.0, -8.0, 0.0)},
        isRampExtra = false,
        rampDoorNum = 5,
        doorwithRamp = false,
        doorwithRampNums = {},
        closeTrunk = false,
        hasDoors = false,
        doorPositions = {},
        doorText = '',
        width = 2.7,
	length = 12.0,
	loffset = -2.0
    },
	{  --Ferry boat
        model = `lcac`,
        
        hasRamp = true,
        unloadPos = {vector3(-1.8,5.0,-0.8)},
        rampPos = {vector3(-1.8, -10.0, -0.8), vector3(1.8, -10.0, -0.8)},
        isRampExtra = false,
        rampDoorNum = 5,
        doorwithRamp = false,
        doorwithRampNums = {},
        closeTrunk = false,
        hasDoors = false,
        doorPositions = {},
        doorText = '',
        width = 5.00,
        length = 40.00,
        loffset = 2.0
    },
}
	
