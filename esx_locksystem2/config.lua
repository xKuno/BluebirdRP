-- [[ Version 1.0.4 ]] --

-- [[ Hope RP - connect 193.70.80.35:30120 ]] --
-- [[ Discord Shorty Ward - https://discord.gg/rH7fheS  ]] --

Config = {}

Config.Locale      = 'en'  -- [[ Local Language en by default                          ]] --
Config.notifca     = true -- [[ Show lock and unlock messages, false default          ]] --
Config.lockKey     = 11   -- [[ Key to Lock / Unlock Vehicle L by default       (page)       ]] --
Config.lockNPC     = false  -- [[ Lock all NPC cars True By Default                     ]] --
Config.defLock     = false -- [[ Default setting for Owned vehicles false by default   ]] --
Config.lChance     = 30    -- [[ Percent chance of vehicle being unlocked              ]] --
Config.rDist       = 10    -- [[ Distance for vehicles in area default 10              ]] --
Config.rentalPlate = 'RENT'-- [[ Rental Plate None Unique letters Default is RENT      ]] --

-- [[ Names of emergency jobs for emergency vehicle locks  ]] --
Config.emergencyJob = {

}

-- [[ Job name and Number Plate NOTE: this removes any numbers E.G PDM 477 will read PDM  ]] --
Config.JobsandPlates = {
  [1] = {job = 'police',           plate = 'MK'},
  [2] = {job = 'ambulance',            plate = 'MB'},
  [3] = {job = 'mecano',            plate = 'RACV'},
  [4] = {job = 'mecano2',            plate = 'TRUBLU'},
  
}

-- [[ These vehicles will always be LOCKED and cannot be Unlocked   ]] --
Config.blacklistVehicles = {
  `T20`,
  `RHINO`
}

-- [[ Vehicles wich will never be locked, great when using vehicles and no job or plate is Set  ]] --
Config.whitelistVehicles = {

}
-- [[ Same as Job plates but any vehicles with this plate can remote lock/unlock by anyone, great for jobs like ESX-Moneylaundering etc   ]] --

Config.whitelistPlates = { 
	"VICROADS",
	"",
	"        "
}
