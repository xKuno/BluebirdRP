  glassesOn = false
  currentGlasses = nil
  myGlasses = nil
  sgTexture = nil
  glassesSet = false
  noGlasses = false

RegisterNetEvent('7e6f9e8b-b408-4fb6-888e-3c32e1006fcc')
AddEventHandler('7e6f9e8b-b408-4fb6-888e-3c32e1006fcc', function()
--[[
  Sets variables for if sunglasses are on and which sunglasses they are
]]--
  local player = GetPlayerPed(-1)
  local currentGlasses = GetPedPropIndex(player, 1)
  if currentGlasses == -1 and glassesSet == false then
    noGlasses = true
    glassesSet = false
  elseif currentGlasses ~= -1 and glassesSet == false then
    myGlasses = GetPedPropIndex(player, 1)
    sgTexture = GetPedPropTextureIndex(player, 1)
    noGlasses = false
    glassesSet = true
    glassesOn = true
  elseif currentGlasses == -1 and glassesSet == true then
    glassesOn = false
  elseif glassesSet == true and currentGlasses ~= -1 and myGlasses ~= currentGlasses then
    myGlasses = GetPedPropIndex(player, 1)
    sgTexture = GetPedPropTextureIndex(player, 1)
    glassesSet = true
    noGlasses = false
    glassesOn = true
  end 

--Takes Glasses off / Puts them On
if not noGlasses then
  glassesOn = not glassesOn
  if glassesOn then
    SetPedPropIndex(player, 1, myGlasses, sgTexture, 2)
    ShowNotification('Sunglasses are on')
  else
    ClearPedProp(player, 1)
    ShowNotification('Sunglasses are off')
  end
else
  ShowNotification('You are not wearing sunglasses')
end

end, false)

RegisterCommand('sg', function()
  TriggerEvent('7e6f9e8b-b408-4fb6-888e-3c32e1006fcc')
end)

--Function to show the notification

function ShowNotification( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
  end
  
  
  
  
  
  
hatsOn = false
currentHats = nil
myHats = nil
sgTextureH = nil
hatsSet = false
noHats = false

RegisterNetEvent('13289f76-c9f0-4b7a-be9d-a03701181081')
AddEventHandler('13289f76-c9f0-4b7a-be9d-a03701181081', function()
--[[
  Sets variables for if sunglasses are on and which sunglasses they are
]]--
  local player = GetPlayerPed(-1)
  local currentHats = GetPedPropIndex(player, 0)
  if currentHats == -1 and hatsSet == false then
    noHats = true
    hatsSet = false
  elseif currentHats ~= -1 and hatsSet == false then
    myHats = GetPedPropIndex(player, 0)
    sgTextureH = GetPedPropTextureIndex(player, 0)
    noHats = false
    hatsSet = true
    hatsOn = true
  elseif currentHats == -1 and hatsSet == true then
    hatsOn = false
  elseif hatsSet == true and currentHats ~= -1 and myHats ~= currentHats then
    myHats = GetPedPropIndex(player, 0)
    sgTextureH = GetPedPropTextureIndex(player, 0)
    hatsSet = true
    noHats = false
    hatsOn = true
  end 

--Takes Glasses off / Puts them On
if not noHats then
  hatsOn = not hatsOn
  if hatsOn then
    SetPedPropIndex(player, 0, myHats, sgTextureH, 2)
    ShowNotification('Hat is on')
  else
    ClearPedProp(player, 0)
    ShowNotification('Hat is off')
  end
else
  ShowNotification('You are not wearing a hat')
end

end, false)

RegisterCommand('hat', function()
  TriggerEvent('13289f76-c9f0-4b7a-be9d-a03701181081')
end)




maskOn = false
currentMasks = nil
myMasks = nil
sgTextureM = nil
masksSet = false
noMasks = false

RegisterNetEvent('ca18db3c-42ea-4be9-98f2-81d262929a1e')
AddEventHandler('ca18db3c-42ea-4be9-98f2-81d262929a1e', function()
--[[
  Sets variables for if sunglasses are on and which sunglasses they are
]]--


  local player = GetPlayerPed(-1)
  local currentMasks = GetPedDrawableVariation(player, 1)
  if currentMasks == -1 and masksSet == false then
    noMasks = true
    masksSet = false
  elseif currentMasks ~= -1 and masksSet == false then
    myMasks = GetPedDrawableVariation(player, 1)
    sgTextureM = GetPedTextureVariation(player, 1)
    noMasks = false
    masksSet = true
    maskOn = true
  elseif currentMasks == -1 and masksSet == true then
    maskOn = false
  elseif masksSet == true and currentMasks ~= -1 and myMasks ~= currentMasks then
    myMasks = GetPedDrawableVariation(player, 1)
    sgTextureM = GetPedTextureVariation(player, 1)
    masksSet = true
    noMasks = false
    maskOn = true
  end 

--Takes Glasses off / Puts them On
if not noMasks then
  masksOn = not masksOn
  if masksOn then
	SetPedComponentVariation(player, 1,	myMasks,sgTextureM, 2)		
    --SetPedPropIndex(player, 1, myMasks, sgTextureM, 2)
    ShowNotification('Mask is on')
  else
	SetPedComponentVariation(player, 1,	-1,0, 2)
    --ClearPedProp(player, 1)
    ShowNotification('Mask is off')
  end
else
  ShowNotification('You are not wearing a mask')
end

end, false)

RegisterCommand('mask', function()
  TriggerEvent('ca18db3c-42ea-4be9-98f2-81d262929a1e')
end)




badgeOn = false
currentBadges = nil
myBadges = nil
bgTextureM = nil
badgesSet = false
noBadges = false

RegisterNetEvent('5bf85ac0-331a-44ab-bdef-d4db53d5e9a2')
AddEventHandler('5bf85ac0-331a-44ab-bdef-d4db53d5e9a2', function()
--[[
  Sets variables for if sunglasses are on and which sunglasses they are
]]--

  print( ' smy badges')
  print(myBadges)
  
  print(' stexture')
  print(bgTextureM)


  local player = GetPlayerPed(-1)
  local currentBadges = GetPedDrawableVariation(player, 1)
  print('current badges')
  print(currentBadges)
  if currentBadges == -1 and badgesSet == false then
    noBadges = true
    badgesSet = false
  elseif (currentBadges ~= -1 or currentBadges ~= 0) and badgesSet == false then
    myBadges = GetPedDrawableVariation(player, 9)
    bgTextureM = GetPedTextureVariation(player, 9)
    noBadges = false
    badgesSet = true
    badgeOn = true
  elseif (currentBadges == -1 or currentBadges == 0) and badgesSet == true then
    badgeOn = false
  elseif badgesSet == true and currentBadges ~= -1 and myBadges ~= currentBadges then
    myBadges = GetPedDrawableVariation(player, 9)
    bgTextureM = GetPedTextureVariation(player, 9)
    badgesSet = true
    noBadges = false
    badgeOn = true
  end 
  
  print('my badges')
  print(myBadges)
  
  print('texture')
  print(bgTextureM)

--Takes Glasses off / Puts them On
if not noBadges then
  badgesOn = not badgesOn
  if badgesOn then
	SetPedComponentVariation(player,9,	myBadges,bgTextureM, 2)		
    --SetPedPropIndex(player, 1, myBadges, bgTextureM, 2)
    ShowNotification('Badge is on')
  else
	SetPedComponentVariation(player, 9,	-1,0, 9)
    --ClearPedProp(player, 1)
    ShowNotification('Badge is off')
  end
else
  ShowNotification('You are not wearing a Badge')
end

end, false)

RegisterCommand('bd', function()
  TriggerEvent('5bf85ac0-331a-44ab-bdef-d4db53d5e9a2')
end)



--Function to show the notification

function ShowNotification( text )
    SetNotificationTextEntry( "STRING" )
    AddTextComponentString( text )
    DrawNotification( false, false )
  end