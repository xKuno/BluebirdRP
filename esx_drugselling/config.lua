GuTu = {}


GuTu.EN = {
    ['press'] = 'Press ~r~E ~w~to sell.',
    ['process'] = 'Deal in progress.',
	['meth'] = ' meth pouches',
	['coke'] = ' coke pouches',
	['weed'] = ' weed pouches',
	['opium'] = ' opium pouches',
	['done'] = 'You sold x',
	['for'] = ' for $',
	['no'] = 'The person is not interested!',
	['cops1'] = 'You cannot sell items. ~r~',
	['cops2'] = ' ~s~police online.',
	['dist'] = 'You are too far!'
}
GuTu.Text = GuTu.EN

GuTu.CokePrice = math.random (400,500)
GuTu.WeedPrice = math.random (200,300)
GuTu.MethPrice = math.random (300,400)
GuTu.OpiumPrice = math.random (100,200)

GuTu.CallCopsPercent = 12 -- (min1) if 1 cops will be called every time=100%, 2=50%, 3=33%, 4=25%, 5=20%,  6 = 16%, 7 = 14%, 11 = 9%

GuTu.PedRejectPercent = 5 -- (min1) if 1 ped reject offer=100%, 2=50%, 3=33%, 4=25%, 5=20%, 6=16.66
GuTu.PedRejectPercentCallCops = 8

GuTu.CopsNeeds = 0

GuTu.TimeSellingLow = 20000
GuTu.TimeSellingHigh = 40000


GuTu.Rejections = {
	'Not into the shit bu',
	'Nah not for me bro',
	'Piss off man or we will dance',
	'Take it elsewhere mate',
	'I will call the cops buddy leave!',
	'This aint no hotel buddy',
	'Fuck off prick',
	'No thanks not my thing mate',
	'No thanks not interested buddy',
	'No thanks not interested bitch',
	'How about I shove it square up your arsehole',
	'Not interested pal',
	'Sshuu fly',
	'Nah mate, good luck',
	'Please dont hold me up!',
	'Not into the shit! Sorry',
	'Thanks Homes, I will keep walking',
	'Ill give it the cold shoulder buddy',
	'I will break you',
	'Nick off man',
	'Not my scene man',
	'You do you bu, you do you.',
	'Dont get popped by the po po buddy',
	'You piece of absolute shit',
	'You piece of crap',
	'Rack off you prick',
	'Not up in here sweatheart',
	'I am in neighbourhood watch!',
	'Im gettin a photo of you and callin the cops',
	'In another life sure man',
	'No thanks',
	'Whats up? Na bud',
	'Cool',
	'Whatever man',
	'Great for you',
	'Good, now piss off',
	'Yeah Nah.',
	'Maybe yeah nah.',
	'Get lost man',
	'Pedal the wares elsewhere',
	'Step off mutha',
	'Get out of my face',
	'Dialling the cops right now',
	'Better run buddy I just text the cops',
	'I run these street fool',
	'Get lost',
	'My streets homie, get lost',
}


GuTu.Trick = {
	'You double crossing son of a bitch',
	'Wheres the goods?',
	'Where is the goods??',
	'Deals gone south, so will you.',
	'You double crossed me!',
	'You will pay with your life!',
	'You son of a bitch!',
	'You owe me you fucking prick!',
	'Die you bitch',
	'Where is it huh??? huh??',
	'Lying prick!',
	'You will pay for this!',
	'I will come for you!',
	'Youre going down!',
}