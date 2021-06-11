Config = {}

Config.Locale = 'en'

Config.serverLogo = 'https://i.imgur.com/AcgDL9f.png'

Config.font = {
	name 	= 'Montserrat',
	url 	= 'https://fonts.googleapis.com/css?family=Montserrat:300,400,700,900&display=swap'
}

Config.date = {
	format	 	= 'simpleWithHours',
	AmPm		= false
}

Config.oldvoice = false

Config.voice = {

	levels = {
		default = 8.0,
		shout = 40.0,
		pa = 50.0,
		car = 6.0,
		whisper = 1.0,
		current = 0,
		savedcurrent = 0
	},
	
	keys = {
		distance 	= ',',
	}
}


Config.vehicle = {
	speedUnit = 'KMH',
	maxSpeed = 300,

	keys = {
		seatbelt 	= 'F2',
		cruiser		= 'CAPS',
		signalLeft	= 'LEFT',
		signalRight	= 'RIGHT',
		signalBoth	= 'DOWN',
	}
}

Config.ui = {
	showServerLogo		= false,

	showJob		 		= true,

	showWalletMoney 	= false,
	showBankMoney 		= false,
	showBlackMoney 		= false,
	showSocietyMoney	= false,

	showDate 			= true,
	showLocation 		= true,
	showVoice	 		= true,

	showHealth			= true,
	showArmor	 		= true,
	showStamina	 		= false,
	showHunger 			= true,
	showThirst	 		= true,

	showMinimap			= true,

	showWeapons			= true,	
}