Config = {

-- IMPORTANT! To configure report text navigate to /html/script.js and find the text you want to replace

EvidenceReportInformationBullet = "firstname, lastname, address, sex", -- The information displayd from users table in mysql in the evidence report (ONLY CHANGE IF YOU KNOW WHAT ARE YOU DOING)
EvidenceReportInformationFingerprint = "firstname, lastname, address, sex", -- The information displayd from users table in mysql in the evidence report (ONLY CHANGE IF YOU KNOW WHAT ARE YOU DOING)
EvidenceReportInformationBlood = "firstname, lastname, address, sex", -- The information displayd from users table in mysql in the evidence report (ONLY CHANGE IF YOU KNOW WHAT ARE YOU DOING)

ShowBloodSplatsOnGround = false, -- Show blood on the ground when player is shot
PlayClipboardAnimation = true, -- Play clipboard animation when reading report

JobRequired = 'police', -- The job needed to use evidence system
JobGradeRequired = -2, -- The MINIMUM job grade required to use evidence system (If you use 0 all job grades can use the system)

CloseReportKey = 'BACKSPACE', -- The key used to close the report
PickupEvidenceKey = 'E', -- The key used to pick up evidence

EvidenceAlanysisLocation = vector3(480.59494018555,-1012.2313232422,34.229225158691), -- The place where the evidence will be Analysed and report generated
TimeToAnalyze = 15000, -- Time in miliseconds to Analyse the given evidence
TimeToFindFingerprints = 15000, -- Time in miliseconds to find fingerprints in a car

--UPDATE V2
RainRemovesEvidence = false, -- Removes evidence when it starts raining!
TimeBeforeCrimsCanDestory = 180, -- Seconds before Criminals can destroy evidence (300 is the time when evidence coolsdown and shows up as WARM)
EvidenceStorageLocation = vector3(475.24911499023,-1006.701171875,34.217079162598), -- The place where all evidence are being archived! You can view old evidence or delete it
--

Text = {

	--UPDATE V2
	['not_in_vehicle'] = 'To use this you need to be in a vehicle!',
	['remove_evidence'] = 'Destroy evidence [~r~E~w~]',
	['cooldown_before_pickup'] = 'The evidence is too fresh/hot to destroy',
	['evidence_removed'] = 'Evidence destroyed!',
	['open_evidence_archive'] = '[~b~E~w~] View evidence archive',
	['evidence_archive'] = 'Evidence Archive',
	['view'] = 'View',
	['delete'] = 'Delete',
	['report_list'] = 'Report #',
	['evidence_deleted_from_archive'] = 'Evidence deleted from archive!',
	--

	['evidence_colleted'] = 'Evidence #{number} collected!',
	['no_more_space'] = 'Not enough space for evidence 3/3!',
	['Analyze_evidence'] = '[~b~E~w~] Analyse the evidence',
	['evidence_being_Analyzed'] = 'The evidence is being analysed by forensics! Please Wait',
	['evidence_being_Analyzed_hologram'] = '~b~The evidence is being Analysed',
	['read_evidence_report'] = '[~b~E~w~] Read evidence report',
	['analyzing_car'] = 'The car is being Analysed! Please wait',
	['pick_up_evidence_text'] = 'Take evidence [~r~E~w~]',
	['no_fingerprints_found'] = 'No fingerprints found!',
	['no_evidence_to_Analyze'] = "No evidence to Analyse!",
	['shell_hologram'] = '~b~ {guncategory} ~w~ bullet shell',
	['blood_hologram'] = '~r~Blood Splat',

	['blood_after_0_minutes'] = 'Status: ~r~FRESH',
	['blood_after_5_minutes'] = 'Status: ~y~AGED',
	['blood_after_10_minutes'] = 'Status: ~b~OLD',

	['shell_after_0_minutes'] = 'Status: ~r~HOT',
	['shell_after_5_minutes'] = 'Status: ~y~WARM',
	['shell_after_10_minutes'] = 'Status: ~b~COLD',


	['submachine_category'] = 'Submachine',
	['pistol_category'] = 'Pistol',
	['shotgun_category'] = 'Shotgun',
	['assault_category'] = 'Assault Rifle',
	['lightmachine_category'] = 'Light Machine Gun',
	['sniper_category'] = 'Sniper',
	['heavy_category'] = 'Heavy Weapon'


}
	

}

-- Only change if you know what are you doing!
function SendTextMessage(msg)

		SetNotificationTextEntry('STRING')
		AddTextComponentString(msg)
		DrawNotification(0,1)

		--EXAMPLE USED IN VIDEO
		--exports['mythic_notify']:SendAlert('inform', msg)

end
