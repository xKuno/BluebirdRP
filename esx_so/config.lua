Config = {}

-- Should a used scratchoff ticket be dispensed after use
Config.GiveUsedScratchoffAfterUse = false

-- The chance of winning. By default this is set to 2 (1 in 2 chance of winning).
-- In order to determine a winner the system picks a number between 1 and
-- Config.WinningOdds. If the matching number is a 1 then it is considered a
-- winning ticket. By default a value of "2" gives a 50% chance to win.
Config.OneInChanceOfWinning = 7

-- The minimum amount of a winning ticket
Config.WinningAmountMinimum = 25

-- The maximum amount of a winning ticket
Config.WinningAmountMaximum = math.random(80,170)
