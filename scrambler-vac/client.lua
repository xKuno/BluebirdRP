local events = {
  'esx:playerLoaded',
  'esx:setJob',
  'esx_casinojob:hasEnteredMarker',
  'esx_casinojob:hasExitedMarker',
  'esx_phone:loaded',
  'skinchanger:getSkin',
  'skinchanger:loadClothes',
  'skinchanger:loadSkin',
  'ft_animation:ClFinish',
  'esx_phone:addSpecialContact',
  'esx_society:openBossMenu',
  'route68_ruletka:start',
  'esx_roulette:start_game',
  'esx_slots:UpdateSlots',
  'pNotify:SendNotification',
  'es_admin2:toggleduty',
  'es_admin2:seemycar_c',
  'es_admin2:getplayerloc_wp',
  'es_admin2:getplayerloc_c',
  'blipcheck',
  'es_admin:nonaus',
  'es_admin:history',
  'es_admin:userlist',
  'es_admin:quick',
  'es_admin:spawnVehicle',
  'es_admin:freezePlayer',
  'es_admin:teleportUser',
  'es_admin:slap',
  'es_admin:givePosition',
  'es_admin:kill',
  'es_admin:heal',
  'es_admin:crash',
  'es_admin:noclip',
  'es_admin:qlist',
  'fivem:rerun',
  'fixmepls',
  'chat:addSuggestion',
  'dispatchsystem:banclient',
  'dispatchsystem:verbal',
  'dispatchsystem:kickclient',
  'dispatchsystem:warnclient',
  'playerSpawned',
  'es_admin2:killerlog',
  'esx:serverCallback',
  'esx:showNotification',
  'esx:showAdvancedNotification',
  'esx:showAdvancedNotification2',
  'esx:showHelpNotification',
  'esx:clearpickups',
  'esx:onPlayerDeath',
  'skinchanger:loadDefaultModel',
  'skinchanger:modelLoaded',
  'esx:restoreLoadout',
  'esx:setAccountMoney',
  'es:activateMoney',
  'esx:addInventoryItem',
  'esx:removeInventoryItem',
  'esx:addWeapon',
  'esx:addWeaponComponent',
  'esx:removeWeapon',
  'esx:removeWeaponComponent',
  'esx:registerSuggestions',
  'esx:teleport',
  'esx:loadIPL',
  'esx:unloadIPL',
  'esx:playAnim',
  'esx:playEmote',
  'esx:spawnVehicle',
  'esx:spawnObject',
  'esx:pickup',
  'esx:removePickup',
  'esx:pickupWeapon',
  'esx:spawnPed',
  'esx:deleteVehicle',
  'zzweaponspermittedchange',
  'esx:saveweapons',
  'esx:clearadminloadout',
  'es:setMoneyDisplay',
  'es_admin2:friendlyfire',
  'es:setPlayerDecorator',
  'dispatchsystem:displaySideBar',
  'esx_mafiajob:hasEnteredMarker',
  'esx_mafiajob:hasExitedMarker',
  'esx_mafiajob:hasEnteredEntityZone',
  'esx_mafiajob:hasExitedEntityZone',
  'NB:openMenuMafia',
  'blue_vehicleshop:sendCategories',
  'blue_vehicleshop:sendVehicles',
  'blue_vehicleshop:hasEnteredMarker',
  'blue_vehicleshop:hasExitedMarker',
  'RRP_BODYBAG:PutInBag',
  'salty_crafting:craftnote',
  'salty_crafting:openMenu',
  'esx_trunk:clearloc',
  'esx_policejob:handcuff',
  'tqrp_inventory:disablenumbers',
  'conde-inventoryhud:setFastWeapons',
  'conde-inventoryhud:notification',
  'conde-inventoryhud:closeinventory',
  'conde-inventoryhud:clearfastitems',
  'conde_inventory_inventoryhud:doClose',
  'tqrp_status:getStatus',
  'esx_inventoryhud:openPlayerInventory',
  'conde_inventory:openPlayerInventory',
  'chat:removeSuggestion',
  'suku:OpenCustomShopInventory',
  'conde_inventory:openShopInventory',
  'suku:AddAmmoToWeapon',
  'esx_inventoryhud:openTrunkInventoryG',
  'esx_inventoryhud:openTrunkInventory',
  'esx_inventoryhud:openPropInventory',
  'esx_inventoryhud:openPropertyInventory',
  'esx_inventoryhud:openPropertyInventoryPolice',
  'esx_inventoryhud:refreshPropInventory',
  'conde-inventoryhud:useWeapon',
  'conde-inventoryhud:removeCurrentWeapon',
  'tqrp_inventoryhud:useAttach',
  'joca_fuel:useJerryCan',
  'esx_inventoryhud:openPlayerInventorySteal',
  'conde-inventoryhud:stealc',
  'menu:setCharacters',
  'menu:setIdentifier',
  'menu:getSteamIdent',
  'sendProximityMessageID',
  'sendProximityMessagePhone',
  'esx_ambulancejob:releaseifdead',
  'loaf_paintball:start',
  'loaf_paintball:matchOver',
  'esx_ambulancejob:cancelitemloss',
  'esx_ambulancejob:useItem',
  'esx_ambulancejob:revive',
  'esx_ambulancejob:reviveall',
  'esx_ambulancejob:increasebo',
  'esx_ambulance:fire',
  'MF_SkeletalSystem:ShowOnDeath',
  'esx_ambulancejob:heal',
  'MF_SkeletalSystem:OpenMenu',
  'esx:onPlayerSpawn',
  'mythic_hospital:client:RemoveBleed',
  'mythic_hospital:client:ResetLimbs',
  'esx_ambulancejob:hasEnteredMarker',
  'esx_ambulancejob:hasExitedMarker',
  'esx_ambulancejob:putInVehicle',
  'ARPF-EMS:opendoors',
  'zscenemenua',
  'iamhost',
  'sharedID',
  'sharedObj',
  'sharedPos',
  'rewardNotif',
  'robbing:notif',
  'esx_robnpc:callcops',
  'esx_ruski_areszt:aresztowany',
  'esx_ruski_areszt:aresztuj',
  'esx_atm:closeATM',
  'esx_bahama_mamas:hasEnteredMarker',
  'esx_bahama_mamas:hasExitedMarker',
  'esx_bahama_mamas:teleportMarkers',
  'esx_bankerjob:hasEnteredMarker',
  'esx_bankerjob:hasExitedMarker',
  'esx_banksecurity:hasEnteredMarker',
  'esx_banksecurityjob:hasExitedMarker',
  'esx_banksecurity:hasExitedMarker',
  'esx_barbershop:hasEnteredMarker',
  'esx_barbershop:hasExitedMarker',
  'esx_skin:openRestrictedMenu',
  'esx_skin:getLastSkin',
  'esx_basicneeds:resetStatus',
  'esx_basicneeds:healPlayer',
  'esx_status:loaded',
  'esx_basicneeds:isEating',
  'esx_basicneeds:onEat',
  'esx_basicneeds:onDrink',
  'esx_status:set',
  'esx_status:registerStatus',
  'esx_status:getStatus',
  'esx_bikerjob:hasEnteredMarker',
  'esx_bikerjob:hasExitedMarker',
  'esx_bikerjob:hasEnteredEntityZone',
  'esx_bikerjob:hasExitedEntityZone',
  'esx_bikerjob:handcuff',
  'esx_bikerjob:drag',
  'esx_bikerjob:putInVehicle',
  'esx_bikerjob:OutVehicle',
  'NB:openMenuBiker',
  'esx_bikerjob2:hasEnteredMarker',
  'esx_bikerjob2:hasExitedMarker',
  'esx_bikerjob2:hasEnteredEntityZone',
  'esx_bikerjob2:hasExitedEntityZone',
  'esx_bikerjob2:handcuff',
  'esx_bikerjob2:drag',
  'esx_bikerjob2:putInVehicle',
  'esx_bikerjob2:OutVehicle',
  'esx:setClothingClient',
  'esx:removeClothingClient',
  'esx_boatshop:loadLicenses',
  'esx_boatshop:sendCategories',
  'esx_boatshop:sendVehicles',
  'esx_boatshop:openPersonnalVehicleMenu',
  'esx_boatshop:hasEnteredMarker',
  'esx_boatshop:hasExitedMarker',
  'esx_brinksjob:hasEnteredMarker',
  'esx_brinksjob:hasExitedMarker',
  'esx_phone:cancelMessage',
  'esx_bsjob:hasEnteredMarker',
  'esx_bsjob:hasExitedMarker',
  'esx_bsjob:hasEnteredEntityZone',
  'esx_bsjob:hasExitedEntityZone',
  'esx_bsjob:handcuff',
  'esx_bsjob:unrestrain',
  'esx_bsjob:drag',
  'esx_bsjob:putInVehicle',
  'esx_bsjob:OutVehicle',
  'esx_bsjob:updateBlip',
  'esx_phone:removeSpecialContact',
  'esx_burglary:callpolice',
  'esx_burglary:police',
  't1ger_carthief:OutlawNotifyBlip',
  't1ger_carthief:OutlawNotifyCL',
  't1ger:ShowNotifyESX',
  'chat:addMessage',
  't1ger_carthief:spawnNPC',
  't1ger_carthief:BrowseAvailableJobs',
  't1ger_carthief:StartTheJob',
  't1ger_carthief:syncJobsData',
  'ChairBedSystem:Client:Animation',
  'mythic_hospital:INBED',
  'lenzh_chopshop:hasEnteredMarker',
  'lenzh_chopshop:hasExitedMarker',
  'outlawChopNotify',
  'lenzh_chopshop:notify2',
  'Choplocation',
  'chopEnable',
  'setVehPrice',
  'soldvehicle',
  'esx_cityworks:hasEnteredMarker',
  'esx_cityworks:hasExitedMarker',
  'esx_clotheshop:hasEnteredMarker',
  'esx_clotheshop:hasExitedMarker',
  'esx_communityservice:inCommunityService',
  'esx_communityservice:finishCommunityService',
  'EngineToggle:RPDamage',
  'esx:LOUDHAILER',
  'ui:StartVoice',
  'ui:ResetVoice',
  'ui:toggle',
  'esx_customui:updateStatus',
  'esx_customui:updateWeight',
  'esx_customui:listofplayers_loud',
  'InteractSound_CL:PlayOnOne',
  'esx_dh:characterChanged',
  'dh_coach:hasExitedMarker',
  'dh_gas:settofull',
  'esx_dmvschool_pb:hasEnteredMarker',
  'esx_dmvschool_pb:hasExitedMarker',
  'esx_dmvschool_pb:loadLicenses',
  'esx_dmvschool_sandy:hasEnteredMarker',
  'esx_dmvschool_sandy:hasExitedMarker',
  'esx_dmvschool_sandy:loadLicenses',
  'esx_dmvschool:hasEnteredMarker',
  'esx_dmvschool:hasExitedMarker',
  'esx_dmvschool:loadLicenses',
  'esx_documents:viewDocument',
  'esx_documents:copyForm',
  'esx_doorlock:setState',
  'esx_drugeffects:onWeed',
  'esx_drugeffects:onOpium',
  'esx_drugeffects:onMeth',
  'esx_drugeffects:onCoke',
  'esx_drugeffects:OnAcid',
  'esx_drugs:hasEnteredMarker',
  'esx_drugs:hasExitedMarker',
  'esx_drugs:onPot',
  'esx_drugs:ReturnInventory',
  'KCoke:start',
  'KCoke:new',
  'KCoke:message',
  'esx_npcdrugsales:ReturnInventory',
  'esx_npcdrugsales:RefreshJob',
  'esx_npcdrugsales:animation',
  'esx_npcdrugsales:poucave',
  'esx_npcdrugsales:rippedoff',
  'eden_boatgarage:hasEnteredMarker',
  'eden_boatgarage:hasExitedMarker',
  'esx_foodtruck:refreshMarket',
  'esx_foodtruck:hasEnteredMarker',
  'esx_foodtruck:hasExitedMarker',
  'esx_foodtruck:hasEnteredEntityZone',
  'esx_foodtruck:hasExitedEntityZone',
  'esx_fueldev:hasEnteredMarker',
  'esx_fueldev:hasExitedMarker',
  'instance:onCreate',
  'esx_garage:hasEnteredMarker',
  'esx_property:hasExitedMarker',
  'instance:registerType',
  'instance:enter',
  'instance:create',
  'instance:close',
  'ls:newVehicle2',
  'esx_garbagejob:setbin',
  'esx_garbagejob:addbags',
  'esx_garbagejob:startpayrequest',
  'esx_garbagejob:removedbag',
  'esx_garbagejob:countbagtotal',
  'esx_garbagejob:clearjob',
  'esx_garbagejob:hasEnteredMarker',
  'esx_garbagejob:hasExitedMarker',
  'esx_handcuffs:cuff',
  'esx_handcuffs:uncuff',
  'esx_handcuffs:cuffcheck',
  'esx_handcuffs:nyckelcheck',
  'esx_handcuffs:unlockingcuffs',
  'esx_hifi:place_hifi',
  'esx_hifi:play_music',
  'esx_hifi:stop_music',
  'esx_hifi:setVolume',
  'esx_holdup:currentlyrobbing',
  'esx_holdup:killblip',
  'esx_holdup:setblip',
  'esx_holdup:toofarlocal',
  'esx_holdup:callcops',
  'esx_holdup:robberycomplete',
  'esx_holdup:starttimer',
  'esx_identity:showRegisterIdentity',
  'esx_identity:identityCheck',
  'esx_identity:saveID',
  'esx_skin:openSaveableMenu',
  'HRP:ESX:SetCharacter',
  'HRP:ESX:SetVehicleAndOwner',
  'HRP:Impound:SetImpoundedVehicles',
  'HRP:Impound:VehicleUnimpounded',
  'HRP:Impound:CannotUnimpound',
  'HRP:TriggerMenu',
  'onResourceStart',
  'esx_trunk_inventory:setOwnedVehicule',
  'testrs',
  'esx_inventoryhud:refreshTrunkInventory',
  'esx_inventoryhud:refreshTrunkInventoryG',
  'esx-qalle-jail:openJailMenu',
  'esx-qalle-jail:jailPlayer',
  'esx-qalle-jail:unJailPlayer',
  'esx:setSecondJob',
  'spawninvisiblecar',
  'eden_garage:hasEnteredMarker',
  'eden_garage:hasExitedMarker',
  'esx_joblisting:hasExitedMarker',
  'esx_jobs:action',
  'esx_jobs:hasExitedMarker',
  'esx_jobs:spawnJobVehicle',
  'esx_blowtorch:startblowtorch',
  'esx_blowtorch:finishclear',
  'esx_blowtorch:clearweld',
  'esx_blowtorch:stopblowtorching',
  'esx_blowtorch:opendoors',
  'esx_holdupbank:currentlyrobbing',
  'esx_holdupbank:currentlyhacking',
  'esx_holdupbank:plantingbomb',
  'esx_holdupbank:killblip',
  'esx_holdupbank:setblip',
  'esx_holdupbank:toofarlocal',
  'esx_holdupbank:toofarlocalhack',
  'esx_holdupbank:closedoor',
  'esx_holdupbank:robberycomplete',
  'esx_holdupbank:hackcomplete',
  'esx_holdupbank:plantbombcomplete',
  'esx_holdupbank:callcops',
  'esx_holdupbank:plantedbomb',
  'esx_holdupbank:opendoors',
  'esx_holdupbank:exit',
  'mhacking:show',
  'mhacking:start',
  'mhacking:hide',
  'esx_kekke_tackle:getTackled',
  'esx_kekke_tackle:playTackle',
  'LegacyFuel:ReturnFuelFromServerTable',
  'LegacyFuel:RecieveCashOnHand',
  'fuel:startFuelUpTick',
  'fuel:refuelFromPump',
  'shorty_slocks:setvehicleLock',
  'shorty_slocks:setvehicleLockMenu',
  'shorty_slocks:notify',
  'esx_lscustom:installMod',
  'esx_lscustom:cancelInstallMod',
  'esx_lscustom2:installMod',
  'esx_lscustom2:cancelInstallMod',
  'esx_lscustom3:installMod',
  'esx_lscustom3:cancelInstallMod',
  'esx_mafiajob2:hasEnteredMarker',
  'esx_mafiajob2:hasExitedMarker',
  'esx_mafiajob2:hasEnteredEntityZone',
  'esx_mafiajob2:hasExitedEntityZone',
  'esx_mecanojob:onHijack',
  'esx_mecanojob:onCarokit',
  'esx_mecanojob:onFixkit',
  'esx_mecanojob:hasEnteredMarker',
  'esx_mecanojob:hasExitedMarker',
  'esx_mecanojob:hasEnteredEntityZone',
  'esx_mecanojob:hasExitedEntityZone',
  'esx_mecanojob2:onHijack',
  'esx_mecanojob2:onCarokit',
  'esx_mecanojob2:onFixkit',
  'esx_mecanojob2:hasEnteredMarker',
  'esx_mecanojob2:hasExitedMarker',
  'esx_mecanojob2:hasEnteredEntityZone',
  'esx_mecanojob2:hasExitedEntityZone',
  'esx_mechanicjob:onHijack',
  'esx_mechanicjob:onCarokit',
  'esx_mechanicjob:onFixkit',
  'esx_mechanicjob:hasEnteredMarker',
  'esx_mechanicjob:hasExitedMarker',
  'esx_mechanicjob:hasEnteredEntityZone',
  'esx_mechanicjob:hasExitedEntityZone',
  'esx_methcar:stop',
  'esx_methcar:stopfreeze',
  'esx_methcar:notify',
  'esx_methcar:startprod',
  'esx_methcar:blowup',
  'esx_methcar:smoke',
  'esx_methcar:drugged',
  'wiadro:postaw',
  'smerfik:zamrozcrft222',
  'smerfik:odmrozcrft222',
  'smerfik:craftanimacja222',
  'podlacz:propa22',
  'sprzedawanie:jablekanim22',
  'odlacz:propa3',
  'odlacz:propa2',
  'smerfik:tekstjab22',
  'smerfik:zdejmijznaczek22',
  'zacznijtekst22',
  'esx:sendoutaped',
  'esx:starthrob',
  'esx:finishedhrob',
  'esx:finishedhrobnotifcation',
  'esx:showmpmessage',
  'esx_newweaponshop:hasEnteredMarker',
  'esx_newweaponshop:hasExitedMarker',
  'esx:issuedProhibitionOrder',
  'esx:newweapongsr',
  'esx:newweaponshoparmour',
  'esx:newweaponshopparachute',
  'esx_nightclubjob:hasEnteredMarker',
  'esx_nightclubjob:hasExitedMarker',
  'esx_nightclubjob:teleportMarkers',
  'esx_carmileage:enforce',
  'esx_optionalneeds:onDrink',
  'outlawNotify',
  'loaf_paintball:stop',
  'esx_fighting:JoinFight',
  'esx_fighting:LeaveFight',
  'esx_fighting:Result',
  'toggleoutlaw',
  'thiefPlace',
  'gunshotPlace',
  'meleePlace',
  'esx:gsrtestgetplayer',
  'esx:gsrtest',
  'NYappear',
  'NYLeave',
  'esx_passport:hasEnteredMarker',
  'esx_passport:hasExitedMarker',
  'esx_passport:loadLicenses',
  'dispatchsystem:toggleCivNUI',
  'fuel:setFuel',
  'esx_phone:addContact',
  'esx_phone:removeContact',
  'esx_phone:onMessage',
  'esx_phone:onMessageCAD',
  'esx_phone:stopDispatch',
  'esx_phone:setPhoneNumberSource',
  'esx_pilot:onHijack',
  'esx_pilot:onCarokit',
  'esx_pilot:onFixkit',
  'esx_pilot:hasEnteredMarker',
  'esx_pilot:hasExitedMarker',
  'esx_pilot:hasEnteredEntityZone',
  'esx_pilot:hasExitedEntityZone',
  'esx_pizza:hasEnteredMarker',
  'esx_pizza:hasExitedMarker',
  'esx_policejob:hasEnteredMarker',
  'esx_policejob:hasExitedMarker',
  'esx_policejob:hasEnteredEntityZone',
  'esx_policejob:hasExitedEntityZone',
  'esx_policejob:chandcuff',
  'esx_policejob:unrestrain',
  'esx_policejob:drag',
  'esx_policejob:putInVehicle',
  'esx_policejob:OutVehicle',
  'esx_policejob:DragOutDriver',
  'esx_policejob:testtint',
  'esx_policejob:updateBlip',
  'esx_policejob:updateBlipD',
  'esx_policejob:stunradio',
  'esx_policejob:policeradio',
  'esx_policejob:turnonradio',
  'jail:teleportPlayer',
  'dispatchsystem:toggleLeoNUI',
  'zscenemenu',
  'esx_police_cad:code1',
  'esx_police_cad:arrived',
  'esx_police_cad:responding',
  'esx_police_cad:traffics',
  'esx_police_cad:openmdt',
  'esx_poolcleaner:hasEnteredMarker',
  'esx_poolcleaner:hasExitedMarker',
  'esx_property:sendProperties',
  'instance:loaded',
  'esx_property:getProperties',
  'esx_property:getProperty',
  'esx_property:getGateway',
  'esx_property:setPropertyOwned',
  'instance:onEnter',
  'instance:onPlayerLeft',
  'esx_property:hasEnteredMarker',
  'instance:invite',
  'esx_skin:setLastSkin',
  'instance:leave',
  'iens:repair',
  'iens:notAllowed',
  'esx_repairkit:onUse',
  'esx_repairkit:onUseownercheck',
  'esx_repairkit:useoil',
  'esx_repairkit:onUseslow',
  'esx_repairkit:vin_carcheck',
  'esx_repairkit:reanimateVNETScrewDrive',
  'esx_repairkit:screwonUse',
  'esx_rope:cuff',
  'esx_rope:uncuff',
  'esx_rope:cuffcheck',
  'esx_rope:ropecheck',
  'esx_rope:nyckelcheck',
  'esx_rope:unlockingcuffs',
  'sendProximityMessage',
  'sendProximityMessageMe',
  'sendProximityMessageDo',
  'noooc',
  'sendooc',
  'MF_SafeCracker:StartMinigame',
  'MF_SafeCracker:EndGame',
  'MF_SafeCracker:SpawnSafe',
  'MF_SafeCracker:EndMinigame',
  'UnderwaterSearch:start',
  'UnderwaterSearch:new',
  'UnderwaterSearch:message',
  'esx_securitycam:hasEnteredMarker',
  'esx_securitycam:hasExitedMarker',
  'esx_securitycam:freeze',
  'esx_securitycam:unhackanim',
  'esx_securitycam:setBankHackedState',
  'esx_securitycam:setPoliceHackedState',
  'esx_status:setDisplay',
  'esx_service:notifyAllInService',
  'esx_shops:hasEnteredMarker',
  'esx_shops:hasExitedMarker',
  'esx_skin:resetFirstSpawn',
  'esx_skin:playerRegistered',
  'esx_skin:openMenu',
  'esx_skin:openSaveableRestrictedMenu',
  'esx_skin:requestSaveSkin',
  'esx_skin:mask1',
  'skinchanger:getData',
  'skinchanger:change',
  'alertFromPeds',
  'criminalLocation',
  'animationAlert',
  'scratchoffs:view',
  'esx_addonaccount:setMoney',
  'esx_status:load',
  'esx_status:add',
  'esx_status:remove',
  'esx_tattooshop:hasEnteredMarker',
  'esx_tattooshop:hasExitedMarker',
  'esx_taxijob:hasEnteredMarker',
  'esx_taxijob:hasExitedMarker',
  'esx:ShowMenu',
  'esx_taximeter:updatePassenger',
  'esx_taximeter:updateLocation',
  'esx_taximeter:resetMeter',
  'esx_teqiljob:hasEnteredMarker',
  'esx_teqiljob:hasExitedMarker',
  'esx_teqiljob:teleportMarkers',
  'handsup:toggle',
  'esx_TruckRobbery:outlawNotify',
  'esx_TruckRobbery:TruckRobberyInProgress',
  'esx_TruckRobbery:HackingMiniGame',
  'esx_TruckRobbery:startMission',
  'esx_TruckRobbery:startTheEvent',
  'esx_TruckRobbery:syncMissionData',
  'esx_unicornjob:hasEnteredMarker',
  'esx_unicornjob:hasExitedMarker',
  'esx_unicornjob:teleportMarkers',
  'esx_vehicleshop_arena_auto:sendCategories',
  'esx_vehicleshop_arena_auto:sendVehicles',
  'esx_vehicleshop_arena_auto:openPersonnalVehicleMenu',
  'esx_vehicleshop_arena_auto:hasEnteredMarker',
  'esx_vehicleshop_arena_auto:hasExitedMarker',
  'esx_vehicleshop_auto:sendCategories',
  'esx_vehicleshop_auto:sendVehicles',
  'esx_vehicleshop_auto:openPersonnalVehicleMenu',
  'esx_vehicleshop_auto:hasEnteredMarker',
  'esx_vehicleshop_auto:hasExitedMarker',
  'esx_vehicleshop_nice:sendCategories',
  'esx_vehicleshop_nice:customnames',
  'esx_vehicleshop_nice:openPersonnalVehicleMenu',
  'esx_vehicleshop_nice:hasEnteredMarker',
  'esx_vehicleshop_nice:hasExitedMarker',
  'esx_vehicleshop_patreon:sendCategories',
  'esx_vehicleshop_patreon:sendVehicles',
  'esx_vehicleshop_patreon:openPersonnalVehicleMenu',
  'esx_vehicleshop_patreon:hasEnteredMarker',
  'esx_vehicleshop_patreon:hasExitedMarker',
  'esx_vehicleshop_sandy:sendCategories',
  'esx_vehicleshop_sandy:sendVehicles',
  'esx_vehicleshop_sandy:openPersonnalVehicleMenu',
  'esx_vehicleshop_sandy:hasEnteredMarker',
  'esx_vehicleshop_sandy:hasExitedMarker',
  'esx_vehicleshop:sendCategories',
  'esx_vehicleshop:customnames',
  'esx_vehicleshop:openPersonnalVehicleMenu',
  'esx_vehicleshop:hasEnteredMarker',
  'esx_vehicleshop:hasExitedMarker',
  'esx_vigneronjob:hasEnteredMarker',
  'esx_vigneronjob:hasExitedMarker',
  'MF_Vangelico:NotifyPolice',
  'MF_Vangelico:SyncLoot',
  'MF_Vangelico:SyncCops',
  'esx:modelChanged',
  'esx_weashop:loadLicenses',
  'esx_weashop:hasEnteredMarker',
  'esx_weashop:hasExitedMarker',
  'esx_wilsonjob:hasEnteredMarker',
  'esx_wilsonjob:hasExitedMarker',
  'esx_wilsonjob:hasEnteredEntityZone',
  'esx_wilsonjob:hasExitedEntityZone',
  'esx_wilsonjob:handcuff',
  'esx_wilsonjob:unrestrain',
  'esx_wilsonjob:drag',
  'esx_wilsonjob:putInVehicle',
  'esx_wilsonjob:OutVehicle',
  'esx_wilsonjob:updateBlip',
  'esx_wolfconstruction:onHijack',
  'esx_wolfconstruction:onCarokit',
  'esx_wolfconstruction:onFixkit',
  'esx_wolfconstruction:hasEnteredMarker',
  'esx_wolfconstruction:hasExitedMarker',
  'esx_wolfconstruction:hasEnteredEntityZone',
  'esx_wolfconstruction:hasExitedEntityZone',
  'esx_kr_shop:hasEnteredMarker',
  'esx_kr_shop:hasExitedMarker',
  'esx_kr_shops:setBlip',
  'esx_kr_shops:removeBlip',
  'mt:missiontext',
  'esx-qalle-sellvehicles_sandy:refreshVehicles',
  'esx-qalle-sellvehicles:refreshVehicles',
  'gcPhone:setEnableApp',
  'gcPhone:notifyFixePhoneChange',
  'gcPhone:register_FixePhone',
  'gcPhone:bypassfixe',
  'gcPhone:forceOpenPhone',
  'gcPhone:myPhoneNumber',
  'gcPhone:contactList',
  'gcPhone:allMessage',
  'gcPhone:getBourse',
  'gcPhone:receiveMessage',
  'gcPhone:waitingCall',
  'gcPhone:acceptCall',
  'gcPhone:rejectCall',
  'gcPhone:historiqueCall',
  'gcPhone:candidates',
  'gcphone:autoCall',
  'gcphone:autoAcceptCall',
  'gcPhone:setMenuStatus',
  'camera:open',
  'gcPhone:tchat_receive',
  'gcPhone:tchat_channeldumpamistocazzo',
  'es:addedBank',
  'es:removedBank',
  'es:displayBank',
  'gcPhone:firstname',
  'gcPhone:lastname',
  'gcPhone:bank_getBilling',
  'gcPhone:twitter_getTweets',
  'gcPhone:twitter_getFavoriteTweets',
  'gcPhone:twitter_getUserTweets',
  'gcPhone:twitter_newTweets',
  'gcPhone:twitter_updateTweetLikes',
  'gcPhone:twitter_setAccount',
  'gcPhone:twitter_createAccount',
  'gcPhone:twitter_showError',
  'gcPhone:twitter_showSuccess',
  'gcPhone:twitter_setTweetLikes',
  'gcPhone:yellow_getPagess',
  'gcPhone:yellow_newPagess',
  'gcPhone:yellow_getUserTweets',
  'gcPhone:bank_gkst',
  'gcPhone:yellow_showError',
  'gcPhone:yellow_showSuccess',
  'gcPhone:fatura_getBilling',
  'gcPhone:insto_getinstas',
  'gcPhone:insto_getFavoriteinstas',
  'gcPhone:insto_newinstas',
  'gcPhone:insto_updateinapLikes',
  'gcPhone:insto_setAccount',
  'gcPhone:insto_createAccount',
  'gcPhone:insto_showError',
  'gcPhone:insto_showSuccess',
  'gcPhone:insto_setinapLikes',
  'gcPhone:reddit_getChanells',
  'gcPhone:reddit_receive',
  'gcPhone:reddit_channel',
  'gcPhone:market_getItem',
  'gopostal_job:hasEnteredMarker',
  'gopostal_job:hasExitedMarker',
  'SaveCommand',
  'hypr9speed:activar',
  'hypr9speed:activarp',
  'currentbalance1',
  'balance:back',
  'bank:result',
  'free:toggleFreeMenu',
  'free:setTimeout',
  'free:giveWpn',
  'PlayerHungerThirst',
  'UpdateFoodDrink',
  'esx_deliveries:setPlayerJob:client',
  'esx_deliveries:startJob:client',
  'MpGameMessage:send',
  'esx_fighting:BetEdited',
  'esx_fighting:EditPos',
  'esx_fighting:StartFight',
  'stats:playerLoaded',
  'stats:set',
  'stats:add',
  'stats:getStats',
  'stats:togglexp',
  'goldmeth:meth',
  'loaf_paintball:queueInfo',
  'loaf_paintball:hudNotify',
  'loaf_paintball:died',
  'james_motels:keyTransfered',
  'james_motels:eventHandler',
  'SmartTrafficLights:setLight',
  'StartTrain',
  'playerSpawn',
  'loaf_tv:update',
  'loaf_tv:delete',
  'loaf_tv:updatevolume',
  'tuning:useLaptop',
  'tuning:closeMenu',
  'esx_inventoryhud:doClose',
  'sendMessageSNL',
  'sendMessageMe',
  'sendMessageSPC',
  'sendMessageCharChange',
  'sendMessageDo',
  'sendMessageTry',
  'sendMessageOOC',
  'ObjectDeleteGunOn',
  'ObjectDeleteGunOff',
  'noPermissions',
  'objectDeleteCar',
  'allcity_wallet:setValues',
  'installBaitCar',
  'disableBaitCar',
  'unlockBaitCar',
  'resetBaitCar',
  'rearmBaitCar',
  'getNetID_disable',
  'getNetID_unlock',
  'getNetID_rearm',
  'BaitCarPro.returnIsAllowed',
  'spawnselect:setNui',
  'es:allowedToSpawn',
  'esx_ambulancejob:multicharacter',
  'core:ShowHelpText',
  'winch',
  'AddedRope',
  'burglary:finished',
  'cmg2_animations:syncTarget',
  'cmg2_animations:syncMe',
  'cmg2_animations:cl_stop',
  'fbcmg2_animations:cl_stop',
  'connectqueue:kickC',
  'disclaimer:show',
  'disclaimer:display',
  'DnaTracker:PickupEvidenceC',
  'DnaTracker:AnalyzeDNA',
  'DnaTracker:AnalyzeAmmo',
  'DnaTracker:PlaceEvidenceC',
  'SendAlert',
  'alert:Send',
  'ebu_bcfl:updateTrailer',
  'ebu:updateTrailer',
  'els:updateElsVehicles',
  'els:CLEARALL_c',
  'els:changeLightStage_c',
  'els:changePartState_c',
  'els:changeAdvisorPattern_c',
  'els:changeSecondaryPattern_c',
  'els:changePrimaryPattern_c',
  'els:setSirenState_c',
  'els:setHornState_c',
  'els:setSceneLightState_c',
  'els:setCruiseLights_c',
  'els:setTakedownState_c',
  'elscleanz',
  'elsdebugsz',
  'EngineToggle:Engine',
  'esx_police_cad:notify',
  'esx_police_cad:server_calls',
  'esx_police_cad:returnsearch',
  'esx_police_cad:showdataplate',
  'esx_police_cad:showdateplateNotFound',
  'esx_police_cad:show-cr',
  'esx_police_cad:show-notes',
  'esx_police_cad:show-license',
  'esx_police_cad:note_deleted',
  'esx_police_cad:note_not_deleted',
  'esx_police_cad:cr_deleted',
  'esx_police_cad:cr_not_deleted',
  'esx_police_cad:show-bolos',
  'esx_police_cad:bolo-deleted',
  'esx_police_cad:bolo-not-deleted',
  'core_evidence:addFingerPrint',
  'core_evidence:unmarkedBullets',
  'core_evidence:SendTextMessage',
  'core_evidence:checkForFingerprints',
  'core_evidence:returnEvidence',
  'core_evidence:getdna',
  'customs:receive',
  'customs:receive2',
  'customs:receive3',
  'customs:lock',
  'fpas',
  'Hose',
  'hoseEffect',
  'fivem-speedometer:playSound',
  'fivem-speedometer:stopSound',
  'ft_libs:Notification',
  'ft_libs:AdvancedNotification',
  'ft_libs:TextNotification',
  'sung',
  'hats',
  'masks',
  'badges',
  'esx:playerLoader',
  'esx:runhud',
  'trew_hud_ui:setInfo',
  'esx:seabeltToggle',
  'trew_hud_ui:setCarSignalLights',
  'trew_hud_ui:syncCarLights',
  'esx:seatbelton',
  'SetGod',
  'npb:toggleblips',
  'instance:get',
  'instance:onInstancedPlayersData',
  'instance:onLeave',
  'instance:onClose',
  'instance:onPlayerEntered',
  'instance:onInvite',
  'izone:refreshClientZones',
  'izone:notification',
  'izone:initiateATrapZone',
  'izone:trapPlayerInZone',
  'izone:getZoneCenter',
  'izone:isPlayerInZone',
  'izone:isPlayerInCatZone',
  'izone:getZonessThePlayerIsIn',
  'izone:isPlayerInAtLeastInOneZoneInCat',
  'izone:isPointInZone',
  'jsfour-dna:remove',
  'jsfour-dna:get',
  'jsfour-dna:callback',
  'K9:UpdateLanguage',
  'K9:searchresults',
  'K9:OpenMenu',
  'K9:IdentifierRestricted',
  'K9:ToggleK9',
  'K9:ToggleFollow',
  'K9:ToggleVehicle',
  'K9:ToggleAttack',
  'kashactersC:setupstart',
  'kashactersC:cancelswap',
  'kashactersC:SetupCharacters',
  'kashactersC:SetupUI',
  'kashactersC:SpawnCharacter',
  'kashactersC:ReloadCharacters',
  'openLightbarMenu',
  'clientToggleLights',
  'sound1Client',
  'sendLightBarVehiclePlates',
  'deleteLightbarVehicle',
  'updateLightbarArray',
  'centerLightbarMenu',
  'esx_repairkit:elights',
  'ls:notify',
  'ls:updateVehiclePlate',
  'ls:getHasOwner',
  'ls:newVehicle',
  'ls:giveKeys',
  'InteractSound_CL:PlayWithinDistance',
  'mhacking:setmessage',
  'mhacking:seqstart',
  'mellotrainer:receiveConfigSetting',
  'mellotrainer:adminStatusReceived',
  'mellotrainer:init',
  'wk:RecieveSavedToggles',
  'mellotrainer:playerSpawned',
  'mellotrainer:playerEnteredVehicle',
  'mellotrainer:playerDeath',
  'mellotrainer:updateTime',
  'mellotrainer:updateBlackout',
  'mellotrainer:updateWind',
  'mellotrainer:updateWeather',
  'mellotrainer:adminstatus',
  'mythic_hospital:client:SyncBleed',
  'mythic_hospital:client:FieldTreatLimbs',
  'mythic_hospital:client:FieldTreatBleed',
  'mythic_hospital:client:ReduceBleed',
  'mythic_hospital:client:UsePainKiller',
  'mythic_hospital:client:UseAdrenaline',
  'mythic_hospital:client:RPCheckPos',
  'mythic_hospital:client:RPSendToBed',
  'mythic_hospital:client:SendToBed',
  'mythic_hospital:client:FinishServices',
  'mythic_hospital:client:ForceLeaveBed',
  'MF_SkeletalSystem:HealBones',
  'mythic_hospital:items:gauze',
  'mythic_hospital:items:bandage',
  'mythic_hospital:items:firstaid',
  'mythic_hospital:items:medkit',
  'mythic_hospital:items:vicodin',
  'mythic_hospital:items:hydrocodone',
  'mythic_hospital:items:morphine',
  'mythic_notify:client:SendAlert',
  'mythic_progbar:client:progress',
  'mythic_progbar:client:ProgressWithStartEvent',
  'mythic_progbar:client:ProgressWithTickEvent',
  'mythic_progbar:client:ProgressWithStartAndTick',
  'mythic_progbar:client:cancel',
  'mythic_progbar:client:actionCleanup',
  'mythic_base:client:SendAlert',
  'no_money',
  'delete-vehicle',
  'setprice',
  'nolegaljob',
  'no-daily-ticket',
  'closemenu',
  'fly',
  'solve_invoice',
  'flyNY',
  'flyLS',
  'aintfly',
  'bought_ticket',
  'no_money_or_bank',
  'check_ticket',
  'pis:mimic',
  'po:mimic',
  'po:unmimic',
  'pis:follow',
  'po:follow',
  'po:unfollow',
  'po:pullover',
  'pis:ticket',
  'pis:getplate',
  'pis:runplate',
  'pis:runid',
  'pis:search',
  'pis:breath',
  'pis:drug',
  'pis:askid',
  'pis:exit',
  'pis:mount',
  'pis:release',
  'pis:warn',
  'pis:drunk:q',
  'pis:drug:q',
  'pis:illegal:q',
  'pis:search:q',
  'pis:hello',
  'po:release',
  'po:lock',
  'po:unlock',
  'po:stop',
  'po:flee',
  'po:shoot',
  'lastalpr',
  'getInfo',
  'getFlags',
  'radio',
  'search',
  'anim:mimic',
  'ticket',
  'pis:arr:pt',
  'pis:arr:handcuff',
  'arresting',
  'freeing',
  'secure',
  'pis:arr:unsecure',
  'pis:arr:grab',
  'pis:arr:kneel',
  'pis:arr:book',
  'pis:yellowjack',
  'pis:vinewoodhouse',
  'pis:harmonybank',
  'pis:68drug',
  'pis:sandy24/7',
  'pis:knifeCallout',
  'pis:abandonedVeh',
  'pis:shoplifting:spawn',
  'pis:shoplifting',
  'pis:fight:spawn',
  'pis:fight',
  'pis:shots:spawn',
  'pis:shots',
  'pis:crazy:spawn',
  'pis:crazy',
  'pis:weapon:spawn',
  'pis:weapon',
  'pis:weapon:drop:q',
  'pis:weapon:face:q',
  'pis:weapon:threat:q',
  'pis:weapon:knees:q',
  'pis:code4',
  'pis:randveh',
  'pis:notification',
  'ldt:cop',
  'ldt:carbine',
  'ldt:shotgun',
  'drop',
  'pNotify:SetQueueMax',
  'heli:forward.spotlight',
  'heli:Tspotlight',
  'heli:Tspotlight.toggle',
  'heli:pause.Tspotlight',
  'heli:Mspotlight',
  'heli:Mspotlight.toggle',
  'heli:light.up',
  'heli:light.down',
  'heli:radius.up',
  'heli:radius.down',
  'polheli2:forward.spotlight',
  'polheli2:Tspotlight',
  'polheli2:Tspotlight.toggle',
  'polheli2:pause.Tspotlight',
  'polheli2:Mspotlight',
  'polheli2:Mspotlight.toggle',
  'polheli2:light.up',
  'polheli2:light.down',
  'polheli2:radius.up',
  'polheli2:radius.down',
  'tackleClient',
  'wk:carsoff',
  'wk:carson',
  'wk:cleantoggle',
  'pop:createcar',
  'pv:syncIndicator',
  'pv:setIndicator',
  'pv:setHazards',
  'tow',
  'InteractSound_CL:PlayOnAll',
  'loffe_robbery:onPedDeath',
  'loffe_robbery:msgPolice',
  'loffe_robbery:removePickup',
  'loffe_robbery:robberyOver',
  'loffe_robbery:talk',
  'loffe_robbery:rob',
  'loffe_robbery:resetStore',
  'Radiant_Animations:KillProps',
  'Radiant_Animations:AttachProp',
  'Radiant_Animations:Animation',
  'Radiant_Animations:StopAnimations',
  'Radiant_Animations:Scenario',
  'Radiant_Animations:Walking',
  'Radiant_Animations:Surrender',
  'sendProximityMessageRoll',
  'de42dc9a-bd46-4c47-9b9a-4ed60cfacd51',
  'b716ffff-1eb0-45ce-b9db-5a356f1955b6',
  'aa9d4cb7-fc91-4bb9-be2e-ee043fefcc0a',
  'Zone',
  'speedzones',
  'ZRM',
  'RemoveBlipC',
  'stopkiller',
  'wk:cleanhackersoff',
  'wk:cleanhackerson',
  'wk:loadcars',
  'wk:loadcarsS',
  'heli:spotlight',
  'simp:textsent',
  'simp:textmsg',
  'simp:recovermessage',
  'vSync:updateWeather',
  'vSync:updateTime',
  'vSync:notify',
  'seatbelt:tablesync',
  'seatbelt:entryupdate',
  'cmg3_animations:syncTarget',
  'cmg3_animations:syncMe',
  'cmg3_animations:cl_stop',
  'thecrasheffect',
  'crashEffect',
  'MountZonah:Option',
  'MountZonah:Update',
  'MountZonahGetBool:Option',
  'MountZonah:UpdateOption',
  'ZONAH:fade',
  'kenzh1N:OpenSim',
  'NB:carteSIM',
  'gcphone:Open',
  'MF_SkeletalSystem:DoUpdate',
  'MF_SkeletalSystem:UseItem',
  'MF_SkeletalSystem:UseItemMedic',
  'MF_SkeletalSystem:PauseDamage',
  'MF_SkeletalSystem:EnableDamage',
  'FaxSM:SendMessage',
  'FaxSM:Broken',
  'esx_karting:onFixkit',
  'esx_karting:hasEnteredMarker',
  'esx_karting:hasExitedMarker',
  'esx_karting:annonce',
  'esx_karting:annoncestop',
  'matif_garage:addGarage',
  'SSCompleteHousing:getESX',
  'SSCompleteHousing:getIsInHouse',
  'SSCompleteHousing:spawnHome',
  'SSCompleteHousing:ownerLeft',
  'SSCompleteHousing:createName',
  'SSCompleteHousing:getHouse',
  'SSCompleteHousing:doorKnock',
  'SSCompleteHousing:knockAccept',
  'SSCompleteHousing:updateHomes',
  'SSCompleteHousing:updateHomesST',
  'SSCompleteHousing:removecar',
  'SSCompleteHousing:insertcar',
  'SSCompleteHousing:refreshVehicles',
  'SSCompleteHousing:driveCar',
  'SSCompleteHousing:hasEnteredMarker',
  'SSCompleteHousing:hasExitedMarker',
  'SSCompleteHousing:updateHomesLocksST',
  'SSCompleteHousing:SetJob',
  'SSCompleteHousing:SetJobmarker',
  'SSCompleteHousing:updateDoorST',
  'SSCompleteHousing:updateHomesStorageST',
  'SSCompleteHousing:updateHomesPlaceFurnitureST',
  'SSCompleteHousing:updateHomesRemoveOutFurnitureST',
  'SSCompleteHousing:updateHomesRemoveFurnitureST',
  'SSCompleteHousing:updateHomesSellHomeST',
  'SSCompleteHousing:CreateHomesST',
  'SSCompleteHousing:updateLandSizeST',
  'SSCompleteHousing:addDoorToHomeST',
  'SSCompleteHousing:addGarageToHomeST',
  'SSCompleteHousing:removeDoorFromHomeST',
  'SSCompleteHousing:deleteHomeST',
  'SSCompleteHousing:createParkingST',
  'SSCompleteHousing:giveKeyST',
  'SSCompleteHousing:buyBackFailST',
  'SSCompleteHousing:purchaseHomeST',
  'SSCompleteHousing:SyncFurnST',
  'SSCompleteHousing:updateHomesPlaceOutFurnitureST',
  'sellingdrugs',
  'sold',
  'showSellInfo',
  'nomoredrugs',
  'playerhasdrugs',
  'drugsPlace',
  'drugsEnable',
  'esx_stationaryradars',
  'wk:flash',
  'ARPF-EMS:togglestrincar',
  'ARPF-EMS:pushstreacherss',
  'ARPF-EMS:getintostretcher',
  'sit',
  'unsit',
  'stretcher:pushoffbed',
  'stretcher:putonbed',
  'raceReceiveScores',
  'raceCountdown',
  'raceRaceActive',
  'Trunk',
  'Hood',
  'ToggleActionmenu',
  'KillTutorialMenu',
  'KillPromptName',
  'tutorial:spawn',
  'esx:playerLoadedFinishedTute',
  'wk:spawnTow',
  'wk:cancelTow',
  'FaxVTK:SubmitVote',
  'FaxVTK:ResetVotes',
  'serverVote:showSubtitle',
  'Cam:ToggleCam',
  'camera:Activate',
  'Mic:ToggleMic',
  'Mic:ToggleBMic',
  'dispatchsystem:ANPRAlert',
  'dispatchsystem:displayChange',
  'dispatchsystem:displayChangeDT',
  'webcops:vehlist',
  'dispatchsystem:toggleBTProxNUI',
  'dispatchsystem:toggleBTNUI',
  'dispatchsystem:toggleDTNUI',
  'dispatchsystem:EXITALL',
  'dispatchsystem:resetNUI',
  'dispatchsystem:pushbackData',
  'dispatchsystem:displayLIC',
  'dispatchsystem:returnedhistory',
  'dispatchsystem:namecheck',
  'dispatchsystem:carcheck',
  'dispatchsystem:pinhistory',
  'dispatchsystem:crimhistory',
  'dispatchsystem:reporthistory',
  'dispatchsystem:supers',
  'dispatchsystem:sheriffob',
  'dispatchsystem:loggedin',
  'dispatchsystem:loggedout',
  'dispatchsystem:showpoliceid',
  'CInteractSound_CL:PlayOnOne',
  'CInteractSound_CL:PlayOnAll',
  'CInteractSound_CL:PlayWithinDistance',
  'CInteractSound_CL:PlayWithinDistanceDiminishing',
  'dispatchsystem:anprtoggle',
  'UpdateCooldown',
  'UpdatePriority',
  'UpdateHold',
  'customUpdate',
  'whistle:Status',
}


for i=1, #events, 1 do
  AddEventHandler(events[i], function()
    TriggerServerEvent('5875747c-dcc2-4f7e-962d-e10edb29be9c', events[i])
  end)
end

