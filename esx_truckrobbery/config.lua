--------------------------------
------- Created by Hamza -------
-------------------------------- 

Config = {}

-- Police Settings:
Config.RequiredPoliceOnline = 10			-- required police online for players to do missions
Config.PoliceDatabaseName = "police"	-- set the exact name from your jobs database for police
Config.PoliceNotfiyEnabled = true		-- police notification upon truck robbery enabled (true) or disabled (false)
Config.PoliceBlipShow = true			-- enable or disable blip on map on police notify
Config.PoliceBlipTime = 30				-- miliseconds that blip is active on map (this value is multiplied with 4 in the script)
Config.PoliceBlipRadius = 50.0			-- set radius of the police notify blip
Config.PoliceBlipAlpha = 250			-- set alpha of the blip
Config.PoliceBlipColor = 76				-- set blip color

-- Set cooldown timer, which player has to wait before being able to do a mission again, in minutes here:
Config.CooldownTimer =  70

-- Enable or disable player wearing a 'heist money bag' after the robbery:
Config.EnablePlayerMoneyBag = true

-- Hacking Settings:
Config.EnableAnimationB4Hacking = true			-- enable/disable hacking or typing animation
Config.HackingBlocks = 4						-- amount of blocks u have to match
Config.HackingSeconds = 40						-- seconds to hack

-- Mission Cost Settings:
Config.MissionCost = 2000		-- taken from bank account // set to 0 to disable mission cost

-- Reward Settings:
Config.MinReward = 20000						-- set minimum reward amount
Config.MaxReward = 60000						-- set maximum reward amount
Config.RewardInDirtyMoney = true			-- reward as dirty money (true) or as normal cash (false)
Config.EnableItemReward = true 				-- requires to add your desired items into your items table in database
Config.ItemName1 = "black_diamond"				-- exact name of your item1
Config.ItemMinAmount1 = 5					-- set minimum reward amount of item1
Config.ItemMaxAmount1 = 85					-- set maximum reward amount of item1
Config.EnableRareItemReward = false			-- add another item as reward but this has only 25% chance 
Config.ItemName2 = "PutItemNameHere"				-- exact name of your item2
Config.ItemMinAmount2 = 1					-- set minimum reward amount of item2
Config.ItemMaxAmount2 = 3					-- set maximum reward amount of item2
Config.RandomChance = 2						-- Set chance, 1/2 is default, which is 50% chance. If u e.g. change value to 4, then 1/4 equals 25% chance.

-- Mission Blip Settings:
Config.EnableMapBlip = true							-- set between true/false
Config.BlipNameOnMap = "Armored Truck Mission"		-- set name of the blip
Config.BlipSprite = 67								-- set blip sprite, lists of sprite ids are here: https://docs.fivem.net/game-references/blips/
Config.BlipDisplay = 4								-- set blip display behaviour, find list of types here: https://runtime.fivem.net/doc/natives/#_0x9029B2F3DA924928
Config.BlipScale = 0.7								-- set blip scale/size on your map
Config.BlipColour = 50								-- set blip color, list of colors available in the bottom of this link: https://docs.fivem.net/game-references/blips/

-- Armored Truck Blip Settings:
Config.BlipNameForTruck = "Armored Truck"			-- set name of the blip
Config.BlipSpriteTruck = 1							-- set blip sprite, lists of sprite ids are here: https://docs.fivem.net/game-references/blips/
Config.BlipColourTruck = 5							-- set blip color, list of colors available in the bottom of this link: https://docs.fivem.net/game-references/blips/
Config.BlipScaleTruck = 0.9							-- set blip scale/size on your map

-- Mission Start Location:
Config.MissionSpot = {
	{ ["x"] = 1275.55, ["y"] = -1710.4, ["z"] = 54.77, ["h"] = 0 },
}

-- Mission Marker Settings:
Config.MissionMarker = 27 												-- marker type
Config.MissionMarkerColor = { r = 240, g = 52, b = 52, a = 100 } 		-- rgba color of the marker
Config.MissionMarkerScale = { x = 1.25, y = 1.25, z = 1.25 }  			-- the scale for the marker on the x, y and z axis
Config.Draw3DText = "Press ~g~[E]~s~ for ~y~Mission~s~"					-- set your desired text here

-- Control Keys
Config.KeyToStartMission = 38	-- default: [E] // set key to start the mission
Config.KeyToOpenTruckDoor = 47
Config.KeyToRobFromTruck = 38										

-- ESX.ShowNotifications:
Config.NoMissionsAvailable = "No ~y~missions~s~ are currently available, please try again later!"
Config.HackingFailed = "You ~r~failed~s~ the hacking~s~"
Config.TruckMarkedOnMap = "~y~Armored Truck~s~ is marked on your map"
Config.KillTheGuards = "~r~Kill~s~ the guards in the ~y~Armored Truck~s~"
Config.MissionCompleted = "~g~Mission Completed:~s~ You successfully ~r~robbed~s~ the ~y~Armored Truck~s~"
Config.BeginToRobTruck = "Go to the ~y~Armored Truck~s~ and begin to rob"
Config.GuardsNotKilledYet = "Take out the ~b~driver~s~ and/or the ~b~passenger~s~ from the ~y~Armored Truck~s~"
Config.TruckIsNotStopped = "Stop the ~y~Armored Truck~s~ before ~r~robbing~s~!"
Config.NotEnoughMoney = "You need ~g~$"..Config.MissionCost.."~s~ on your ~b~bank-account~s~ to pay for location.~s~"
Config.NotEnoughPolice = "To do ~y~missions~s~ there needs to be at least: ~b~"..Config.RequiredPoliceOnline.. " cops~s~ online!"
Config.CooldownMessage = "You can do another ~y~mission~s~ in: ~b~%s minutes~s~"
Config.RewardMessage = "You received ~g~$%s ~s~ from the ~y~Armored Truck~s~"
Config.Item1Message = "You received ~b~%sx~s~ Black Diamons from the ~y~Armored Truck~s~"
Config.Item2Message = "You received ~b~%sx~s~ Gold Bars from the ~y~Armored Truck~s~"
Config.DispatchMessage = "^3 10-90 ^0 on a Armored Truck at ^5%s^0"

-- ESX.ShowHelpNotifications:
Config.OpenTruckDoor = "Press ~INPUT_DETONATE~ to open the door"
Config.RobFromTruck = "Press ~INPUT_PICKUP~ to rob from the Truck"

-- ProgressBars text
Config.Progress1 = "RETRIEVING TRUCK INFO"
Config.Progress2 = "PLANTING C4"
Config.Progress3 = "TIME UNTIL DETONATION"
Config.Progress4 = "ROBBING THE TRUCK"

-- ProgressBar Timers, in seconds:
Config.RetrieveMissionTimer = 7.5	-- time from pressed E to receving location on the truck
Config.DetonateTimer = 45			-- time until bomb is detonated
Config.RobTruckTimer = 45			-- time spent to rob the truck

-- Guards Weapons:
Config.DriverWeapon = "WEAPON_PUMPSHOTGUN"		-- weapon for driver
Config.PassengerWeapon = "WEAPON_PUMPSHOTGUN_MK2" 			-- weapon for passenger

-- Armored Truck Spawn Locations
Config.ArmoredTruck = 
{
	{ 
		Location = vector3(1444.58, -1892.1, 71.68), 
		InUse = false
	},
	{ 
		Location = vector3(1354.58, -1803.07, 58.53), 
		InUse = false
	},
	{ 
		Location = vector3(1233.15, -1808.96, 39.75), 
		InUse = false
	},
	{ 
		Location = vector3(1286.35, -1580.33, 51.32), 
		InUse = false
	},
	{ 
		Location = vector3(1373.53, -1525.96, 56.71), 
		InUse = false
	},
	{ 
		Location = vector3(1190.2, -1508.46, 34.69), 
		InUse = false
	}
	
}

