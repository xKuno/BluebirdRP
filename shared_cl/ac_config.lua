Config = {}

-- Amount of Time to Blackout, in milliseconds
-- 2000 = 2 seconds
Config.BlackoutTime = 1300

--[[ Config.Effect = {
    Time = {8 ,13 ,19 ,25 ,33},
    Damage = {15, 25, 45, 65, 100}
    Speed = {20, 45, 65,95, 130}
} ]]

Config.EffectTimeLevel1 = 8
Config.EffectTimeLevel2 = 13
Config.EffectTimeLevel3 = 19
Config.EffectTimeLevel4 = 25
Config.EffectTimeLevel5 = 33

-- Enable blacking out due to vehicle damage
-- If a vehicle suffers an impact greater than the specified value, the player blacks out
Config.BlackoutDamageRequiredLevel1 = 80
Config.BlackoutDamageRequiredLevel2 = 100
Config.BlackoutDamageRequiredLevel3 = 125
Config.BlackoutDamageRequiredLevel4 = 180
Config.BlackoutDamageRequiredLevel5 = 300

-- Enable blacking out due to speed deceleration
-- If a vehicle slows down rapidly over this threshold, the player blacks out
Config.BlackoutSpeedRequiredLevel1 = 50 -- Speed in MPH  32
Config.BlackoutSpeedRequiredLevel2 = 55  -- 72km/h
Config.BlackoutSpeedRequiredLevel3 = 85
Config.BlackoutSpeedRequiredLevel4 = 95
Config.BlackoutSpeedRequiredLevel5 = 115

-- Enable the disabling of controls if the player is blacked out
Config.DisableControlsOnBlackout = true
Config.TimeLeftToEnableControls = 10

-- Multiplier of screen shaking strength
Config.ScreenShakeMultiplier = 0.1
