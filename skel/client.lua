-- ModFreakz
-- For support, previews and showcases, head to https://discord.gg/ukgQa5K

local MFS = MF_SkeletalSystem

local crouched = false

function skelenabled()
	return true
end
exports("skelenabled",skelenabled)

local plyPed = GetPlayerPed(-1)

function MFS:Start()
  while not ESX do Citizen.Wait(100); end
  while not ESX.IsPlayerLoaded() do Citizen.Wait(50); end

  self:SetupBones()
  while not self.BoneCats do Citizen.Wait(0); end
  self:SetupTextures()

  plyPed = plyPed

  if self.dS and self.cS then
    Citizen.CreateThread(function(...) self:TimerTracker(...); end)
    Citizen.CreateThread(function(...) self:Update(...); end)
    Citizen.CreateThread(function(...) self:DamageEffects(...); end)
  end
end

function MFS:SetupBones()
  ESX.TriggerServerCallback('5fc714e3-cf4a-4e73-9fb0-12d5f5296fe2', function(data)
    self.BoneCats = {}
    self.Bones = {}      
    for bType,v in pairs(self.PedBones) do
      if data then 
        self.BoneCats[bType] = data[bType] 
      else 
        self.BoneCats[bType] = 0
      end

      self.Bones[bType] = {}
      for bone,v in pairs(v) do
        self.Bones[bType][bone] = 0
      end
    end  
  end)
end

function MFS:SetupTextures()  
  self.TextureDictA = "Skelly_TexturesA"
  self.TextureDictB = "Skelly_TexturesB"
  local txdA = CreateRuntimeTxd(self.TextureDictA)
  local txdB = CreateRuntimeTxd(self.TextureDictB)
  CreateRuntimeTextureFromImage(txdA, "Base", "SKELLY_Base.png")
  CreateRuntimeTextureFromImage(txdB, "OtherBase", "OTHER_Base.png")
  for k,v in pairs(self.BoneCats) do
    local texd = CreateRuntimeTxd(k)
    CreateRuntimeTextureFromImage(texd, k, "SKELLY_" .. k .. ".png")
  end
  if not HasStreamedTextureDictLoaded(self.TextureDictA, false) then RequestStreamedTextureDict(self.TextureDictA, false); end
  if not HasStreamedTextureDictLoaded(self.TextureDictB, false) then RequestStreamedTextureDict(self.TextureDictB, false); end
end

MFS.SaveAt = 3 -- minutes
function MFS:Update()
  local timer = GetGameTimer()
  local timerDC = timer
  local timerCD = timerDC
  while self.dS and self.cS do
    Citizen.Wait(0)
   
    
	if self.MenuOpen then
		self:DrawUI()
		self:InputCheck()
	else
		 Citizen.Wait(100)
	end
	local cctime = GetGameTimer()
	if (cctime - timerDC) > (1000 * 60) then 
		 self:DamageCheck()
	end
    if self.MenuPool then self.MenuPool:ProcessMenus(); end
	
	if (cctime - timerCD) >  (30 * 1000) then 
		if self.BoneCats["Head"] > 0 and not self.UsingStress then

			exports['mythic_notify']:SendLongAlert('error', 'You have a head injury, you should seek medical attention.')
	    end
	  timerCD = cctime
	end
    if (cctime - timer) > self.SaveAt * 60 * 1000 then 

      timer = GetGameTimer() 
      if self.MarkedForSave then 
        TriggerServerEvent('a5c14872-1c10-43bf-880d-a7cafea9a39f', self.BoneCats)
        self.MarkedForSave = false
      end 
    end
  end
end

RegisterNetEvent('6bd72c54-ff5a-41b2-9a7e-acb5b2913261')
AddEventHandler('6bd72c54-ff5a-41b2-9a7e-acb5b2913261', function(...) TriggerServerEvent('a5c14872-1c10-43bf-880d-a7cafea9a39f',MFS.BoneCats); end)

function MFS:InputCheck()    
  if self.OpenWithHotkey then
    if (IsControlJustPressed(0, Keys[self.MenuKey]) or IsDisabledControlJustPressed(0, Keys[self.MenuKey])) and not self.ViewingOther then
      self:HandleMenu(true)
    end
  end
  
  if self.MenuOpen then
    if (IsControlJustPressed(0, Keys['LEFT']) or IsDisabledControlJustPressed(0, Keys['LEFT'])) then 
      self:ChangeSelected(-1)    
      self:HandleMenu(false)
    elseif (IsControlJustPressed(0, Keys['RIGHT']) or IsDisabledControlJustPressed(0, Keys['RIGHT'])) then 
      self:ChangeSelected(1) 
      self:HandleMenu(false)
    elseif (IsControlJustPressed(0, Keys['BACKSPACE']) or IsDisabledControlJustPressed(0, Keys['BACKSPACE'])) then 
      self:HandleMenu(true)
    end
  end
  
 
end

local ispedincar = 0
Citizen.CreateThread(function()
  while ESX == nil do
    Citizen.Wait(200)
  end
  while true do
	plyPed = ESX.Game.GetMyPed()
	myCurrentCoords = ESX.Game.GetMyPedLocation()
	ispedincar = ESX.Game.GetVehiclePedIsIn()
	Wait(500)
  end
end)

Citizen.CreateThread( function()
    while true do 
        Citizen.Wait(0)
		pcall(function()
			local ped = plyPed

			if ispedincar == 0 then 
				DisableControlAction( 0, 36, true ) -- INPUT_DUCK  

				
					if ( IsDisabledControlJustPressed( 0, 36 ) ) then 
						if ( not IsPauseMenuActive() ) then 

							if ( crouched == true ) then 
								ResetPedMovementClipset( ped, 0 )
								crouched = false 
							elseif ( crouched == false ) then
								crouched = true 
							   RequestAnimSet( "move_ped_crouched" )

								while ( not HasAnimSetLoaded( "move_ped_crouched" ) ) do 
									Citizen.Wait( 50 )
								end 
								SetPedMovementClipset( ped, "move_ped_crouched", 0.25 )
								
							end 
						end
					end
	
			else
				Wait(500)
			end
		end)
    end
end )

function MFS:ChangeSelected(val)
  if val > 0 then
    if self.ListOpen + val > #self.UIOrder then
      self.ListOpen = 1
      self.MenuOpen = self.UIOrder[self.ListOpen]
    else
      self.MenuOpen = self.UIOrder[self.ListOpen + val]
      self.ListOpen = self.ListOpen + val
    end
  else
    if self.ListOpen + val < 1 then
      self.MenuOpen = self.UIOrder[#self.UIOrder]
      self.ListOpen = #self.UIOrder
    else
      self.MenuOpen = self.UIOrder[self.ListOpen + val]
      self.ListOpen = self.ListOpen + val
    end
  end
end

function MFS:DamageCheck()  
  if self.PauseDamage then return; end
  local plyPed = plyPed
  local prevHealth = (self.plyHealth or GetEntityHealth(plyPed))
  self.plyHealth = GetEntityHealth(plyPed)
  if self.plyHealth < (prevHealth - 5) then    
    ESX.ShowNotification('You are ~o~injured!')
    local bone,bType = self:CheckBone()
    if bone and bType then
      self:DamageBone(bone,bType)
    end
  end
end

function MFS:CheckBone()  
  local _found,_boneId = GetPedLastDamageBone(plyPed)
  if not _found then return false; end
  for bType,v in pairs(self.PedBones) do
    for bone,boneId in pairs(v) do
      if boneId == _boneId then return bone,bType; end
    end
  end; return false
end

function MFS:DamageBone(bone,bType)
  if self.Bones and self.Bones[bType] and self.Bones[bType][bone] and self.BoneCats and self.BoneCats[bType] then
    self.Bones[bType][bone] = self.Bones[bType][bone] + 1
    self.BoneCats[bType] = self.BoneCats[bType] + 1
    --self.MarkedForSave = true
    TriggerServerEvent('a5c14872-1c10-43bf-880d-a7cafea9a39f', self.BoneCats)
  end
end

function MFS:HealBones(bType) 
  if type(bType) ~= "string" then bType = tostring(bType); end
  if bType == "all" then
    for k,v in pairs(self.BoneCats) do self.BoneCats[k] = 0; end
    for k,v in pairs(self.Bones) do self.BoneCats[k] = 0; end
    if self.MenuOpen then self:HandleMenu(false); end
  else
    if self.BoneCats[bType] then
      self.BoneCats[bType] = 0
      for k,v in pairs(self.Bones[bType]) do v = 0; end
    end
  end
  --self.MarkedForSave = true
  TriggerServerEvent('a5c14872-1c10-43bf-880d-a7cafea9a39f', self.BoneCats)
end

function MFS:DamageBones(bType,damage)
  if not bone and not damage then return; end
  if not self.BoneCats[bType] then return; end
  self.BoneCats[bType] = self.BoneCats[bType] + damage
end

function MFS:DrawUI()
  if self.MenuOpen then
    ClampGameplayCamYaw(0.0,0.0) 
    local hp = math.max(GetEntityHealth(plyPed) - 100, 0)
    local str = ""
    if hp > 80 then str = "~g~" elseif hp > 50 then str = "~y~" elseif hp > 20 then str = "~o~"; else str = "~r~"; end

    local templateA = Utils:DrawTextTemplate()
    templateA.text = str .. hp
    templateA.font = 1
    templateA.x = 0.38
    templateA.y = 0.75 
    templateA.outline = 10
    templateA.scale2 = 0.7

    local templateB = Utils:DrawTextTemplate()
    templateB.text = "~t~ / " .. (GetEntityMaxHealth(plyPed) - 75)
    templateB.font = 1
    templateB.x = 0.415
    templateB.y = 0.755 
    templateB.outline = 10
    templateB.scale2 = 0.5

    Utils:DrawText(templateA)
    Utils:DrawText(templateB)

    DrawSprite(self.TextureDictA, "Base",  0.5,  0.5, 0.55, 0.70, 0.0, 255, 255, 255, 255)
    for k,v in pairs(self.BoneCats) do        
      DrawSprite(k, k, 0.5, 0.5, 0.55, 0.70, 0.0, 255, 255, 255, math.min(v * 50,255))
    end   

    local adder = 0.006
    for k,v in pairs(self.UIPositions) do
      if self.BoneCats[k] and type(self.BoneCats[k]) == "number" and self.BoneCats[k] > 0 then      
        for i = 1, math.min(self.BoneCats[k], 10), 1 do
          if self.MenuOpen == k then
            DrawSprite("commonmenu", "gradient_nav", v.x + (adder * (i - 1)), v.y, 0.006, 0.01, 0.0, 100, 0, 0, 255) 
          else 
            DrawSprite("commonmenu", "gradient_nav", v.x + (adder * (i - 1)), v.y, 0.006, 0.01, 0.0, 100, 100, 100, 255) 
          end
        end
      end
    end
  end
end

function MFS:HandleMenu(close)
  if not self.MenuOpen then 
    self.ListOpen = 1    
    self.MenuOpen = self.UIOrder[self.ListOpen]
    self.MenuPool = self.MenuPool or NativeUI.CreatePool()
    self.MenuPool:DisableInstructionalButtons(true)
    self.MenuPool:MouseControlsEnabled(false)    

    if self.Menu then
      for k=1,#self.Menu.Items,1 do
        self.Menu:RemoveItemAt(k)
      end
      self.Menu:Clear()
    end 

    self:RefreshMenu()    
  else      
    if self.Menu then
      for k=1,#self.Menu.Items,1 do
        self.Menu:RemoveItemAt(k)
      end
      self.Menu:Clear()
      self.Menu:Visible(false)
      self.Menu = false
    end 

    if close then 
      self.MenuOpen = false 
    else   
      self:RefreshMenu()  
    end 
  end
end

function MFS:Awake(...)
    while not ESX do Citizen.Wait(0); end
    while not ESX.IsPlayerLoaded() do Citizen.Wait(0); end
    ESX.TriggerServerCallback('7376b99f-587c-4b77-9c42-bb4aa42d428c', function(retVal) self.dS = true; self.cS = retVal; self:Start(); end)
end

function MFS:RefreshMenu()
  local resX,resY = GetActiveScreenResolution(resX,resY)
  local str = "~r~Bone Damage  : " .. tostring(self.MenuOpen)  

  if self.UIPositions[resX .. "x" .. resY] then 
    xPos = resY + self.UIPositions[resX .. "x" .. resY].MenuX
    yPos = self.UIPositions[resX .. "x" .. resY].MenuY 
    widthOffset = self.UIPositions[resX .. "x" .. resY].MenuWidthOffset
    maxPage = self.UIPositions[resX .. "x" .. resY].MaxPages
  else 
    xPos = resY + self.UIPositions["1920x1080"].MenuX
    yPos = self.UIPositions["1920x1080"].MenuY
    widthOffset = self.UIPositions["1920x1080"].MenuWidthOffset
    maxPage = self.UIPositions["1920x1080"].MaxPages
  end

  self.Menu = NativeUI.CreateMenu("", str, xPos, yPos, "", "", "", 77, 77, 77, 255)
  self.Menu:SetMenuWidthOffset(widthOffset)
  self.Menu.Pagination.Max = maxPage
  self.Menu.Pagination.Total = maxPage - 1
  self.Menu:Visible(true) 
  self.Menu.Settings.MouseControlsEnabled = false
  self.Menu.Settings.InstructionalButtons = false

  if self.Bones and type(self.Bones) == "table" then 
    for k,v in pairs(self.Bones[self.MenuOpen]) do      
      local newItem = NativeUI.CreateItem(k .. " : ", "", 1, false, 1, Colours.White, Colours.Red)
      newItem:RightLabel("~r~"..v)
      self.Menu:AddItem(newItem) 
    end
  end 

  self.MenuPool:Add(self.Menu)
  self.MenuPool:RefreshIndex() 
  self.MenuPool:DisableInstructionalButtons(true)
  self.MenuPool:MouseControlsEnabled(false)
end

function MFS:TimerTracker()
  self.Tick = 0
  while self.dS and self.cS do
    Wait(10)
    self.Tick = self.Tick + 1
  end
end

function MFS:DamageEffects()
  RequestAnimSet("move_m@injured")
  local tick = 0
  while self.dS and self.cS do
    Citizen.Wait(15)
    tick = tick + 1
    local plyPed = plyPed
    local plyId = PlayerId()

	
    if self.BoneCats["Head"] > 0 and not self.UsingStress then
      SetTimecycleModifier('BarryFadeOut')
      SetTimecycleModifierStrength(math.min(self.BoneCats["Head"] / 10, 0.6))
      self.HeadInjury = true

    else
      if self.HeadInjury and not self.UsingStress then 
        ClearTimecycleModifier() 
        self.HeadInjury = false 
      end
    end

    if self.BoneCats["Body"] > 0 then
      if tick % (1000 / (self.BoneCats["Body"] / 10)) == 1 then
        local plyHealth = GetEntityHealth(plyPed)
        SetPlayerHealthRechargeMultiplier(plyId, 0.0)
        if plyHealth > 0 then ApplyDamageToPed(plyPed, self.BoneCats["Body"], false) end
        self.DamagedBody = true
      end
    elseif self.DamagedBody then
      SetPlayerHealthRechargeMultiplier(plyId, 1.0)
      self.DamagedBody = false
    end

    if self.BoneCats["RightArm"] > 0 or self.BoneCats["LeftArm"] > 0 then 
      if IsPedShooting(plyPed) then 
        if self.BoneCats["RightArm"] > self.BoneCats["LeftArm"] then   
          ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', self.BoneCats["RightArm"] / 10.0)
        else 
          ShakeGameplayCam('SMALL_EXPLOSION_SHAKE', self.BoneCats["LeftArm"] / 10.0)
        end
      end
    end

    if crouched == false and self.BoneCats and self.BoneCats["LeftLeg"] and self.BoneCats["RightLeg"] and (self.BoneCats["LeftLeg"] >= 2 or self.BoneCats["RightLeg"] >= 2) then

		  self.InjuredLegs = true
		  SetPedMoveRateOverride(plyPed, 0.8)
		  SetPedMovementClipset(plyPed, "move_m@injured", true)

    elseif self.InjuredLegs then
      ResetPedMovementClipset(plyPed)
      ResetPedWeaponMovementClipset(plyPed)
      ResetPedStrafeClipset(plyPed)
      SetPedMoveRateOverride(plyPed, 1.0)
      self.InjuredLegs = false
    end
  end
end

function MFS:UseItem(categories,medic)  
  if not medic then  
    local playerPed = plyPed
    TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', -1, true)
    exports['progressBars']:startUI(10000, "Applying Item")
    Wait(10000)
    TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', -1, false)
    Wait(3000)
    ClearPedTasksImmediately(playerPed)
    ClearPedTasks(playerPed)
  end

  local damage,damagedLimb
  for k,v in pairs(categories) do
    if not damage or (self.BoneCats[v] and self.BoneCats[v] > damage) then 
      damage = self.BoneCats[v]
      damagedLimb = v
    end
  end
  if damagedLimb then 
    self.BoneCats[damagedLimb] = 0 
  end

  if medic then
    TriggerServerEvent('a5c14872-1c10-43bf-880d-a7cafea9a39f', self.BoneCats)
  end
end

function MFS:UseItemMedic()    
  local playerPed = plyPed
  TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', -1, true)
  exports['progressBars']:startUI(10000, "Applying Item")
  Wait(10000)
  TaskStartScenarioInPlace(playerPed, 'CODE_HUMAN_MEDIC_TEND_TO_DEAD', -1, false)
  Wait(3000)
  ClearPedTasksImmediately(playerPed)
  ClearPedTasks(playerPed)
end


function MFS:CheckOther()
  while not ESX do Citizen.Wait(0); end
  while not ESX.IsPlayerLoaded() do Citizen.Wait(0); end
  Citizen.CreateThread(function(...) 
    local plyPed = plyPed
    local plyPos = GetEntityCoords(plyPed)
    local players = ESX.Game.GetPlayersInArea(plyPos, 20.0)

    local closest,dist
    for k,v in pairs(players) do
      local plyId = GetPlayerServerId(v)
      if plyId ~= GetPlayerServerId(PlayerId()) then
        local curDist = Utils:GetVecDist(GetEntityCoords(GetPlayerPed(v)), plyPos)
        if not dist or curDist < dist then
          closest = v
          dist = curDist
        end
      end
    end

    --if not dist or dist > 10.0 then return; end

    ESX.TriggerServerCallback('0ac21abe-7909-489f-aaf6-f5f1d3255f32', function(data) 
      self.ViewBoneCats = {}
      self.ViewBones = {}      
      for bType,v in pairs(self.PedBones) do
        if data then 
          self.ViewBoneCats[bType] = data[bType] 
        else 
          self.ViewBoneCats[bType] = 0
        end

        self.ViewBones[bType] = {}
        for bone,v in pairs(v) do
          self.ViewBones[bType][bone] = 0
        end
      end  
			--insert notification
		if data.deathdata ~= nil then
			ESX.ShowNotification('Injury caused by : ' .. data.deathdata.WeaponClasses)
		end
	

      ClampGameplayCamYaw(0.0,0.0) 
      local hp = math.max(GetEntityHealth(GetPlayerPed(closest)) - 100, 0)
      local str = ""
      if hp > 80 then str = "~g~" elseif hp > 50 then str = "~y~" elseif hp > 20 then str = "~o~"; else str = "~r~"; end

      local templateA = Utils:DrawTextTemplate()
      templateA.text = str .. hp
      templateA.font = 1
      templateA.x = 0.38
      templateA.y = 0.75 
      templateA.outline = 10
      templateA.scale2 = 0.7

      local templateB = Utils:DrawTextTemplate()
      templateB.text = "~t~ / 100"
      templateB.font = 1
      templateB.x = 0.415
      templateB.y = 0.755 
      templateB.outline = 10
      templateB.scale2 = 0.5
      self.ViewingOther = true
      while self.ViewingOther do
        Citizen.Wait(0)
        if Utils:GetKeyPressed("BACKSPACE") then self.ViewingOther = false; end
        Utils:DrawText(templateA)
        Utils:DrawText(templateB)

        DrawSprite(self.TextureDictB, "OtherBase",  0.5,  0.5, 0.55, 0.70, 0.0, 255, 255, 255, 255)
        for k,v in pairs(self.ViewBoneCats) do        
          DrawSprite(k, k, 0.5, 0.5, 0.55, 0.70, 0.0, 255, 255, 255, math.min(v * 50,255))
        end   

        local adder = 0.006
        for k,v in pairs(self.UIPositions) do
          if self.ViewBoneCats[k] and type(self.ViewBoneCats[k]) == "number" and self.ViewBoneCats[k] > 0 then      
            for i = 1, math.min(self.ViewBoneCats[k], 10), 1 do
              if self.MenuOpen == k then
                DrawSprite("commonmenu", "gradient_nav", v.x + (adder * (i - 1)), v.y, 0.006, 0.01, 0.0, 100, 0, 0, 255) 
              else 
                DrawSprite("commonmenu", "gradient_nav", v.x + (adder * (i - 1)), v.y, 0.006, 0.01, 0.0, 100, 100, 100, 255) 
              end
            end
          end
        end
      end
    end, GetPlayerServerId(closest))
  end)
end

function MFS:UseItemOther(...)
  while not ESX do Citizen.Wait(0); end
  while not ESX.IsPlayerLoaded() do Citizen.Wait(0); end
  local plyPos = GetEntityCoords(plyPed)
  local players = ESX.Game.GetPlayersInArea(plyPos, 20.0)

  local closest,dist
  for k,v in pairs(players) do
    local plyId = GetPlayerServerId(v)
    if plyId ~= GetPlayerServerId(PlayerId()) then
      local curDist = Utils:GetVecDist(GetEntityCoords(GetPlayerPed(v)), plyPos)
      if not dist or curDist < dist then
        closest = v
        dist = curDist
      end
    end
  end  

  ESX.TriggerServerCallback('b8843e7e-b58f-4b9e-a423-144b6ccf5a3d', function(items) 
    if not items then return; end
    local elements = {}
    for k,v in pairs(items) do
      table.insert(elements, {label = v.label .. " : ["..v.count.."]", name  = v.name, count = v.count})
    end    
  
    ESX.UI.Menu.Open('default', GetCurrentResourceName(), "Medic_Items", { title = "Medic Items", align = 'right', elements = elements }, 
      function(data,menu)
        menu.close()
        ESX.UI.Menu.CloseAll() 
        TriggerServerEvent('3034d49c-766f-4830-91be-c5a82c34dd4b', GetPlayerServerId(closest), data.current.name)       
      end,    
      function(data,menu)
        menu.close()
        ESX.UI.Menu.CloseAll()
      end
    )
  end)
end

RegisterCommand('useItemOther', function(...) MFS:UseItemOther(...); end)
RegisterCommand('checkOther', function(...) MFS:CheckOther(...); end)
RegisterCommand('skel', function(...) if not MFS.ViewingOther then MFS:HandleMenu(true); end; end)

RegisterNetEvent('3ee39acf-2bfc-4a2e-b12f-6f7239fbe100')
AddEventHandler('3ee39acf-2bfc-4a2e-b12f-6f7239fbe100', function(categories,medic) MFS:UseItem(categories,medic); end)

RegisterNetEvent('50da948e-1803-4dd2-99e7-7c853df2f53b')
AddEventHandler('50da948e-1803-4dd2-99e7-7c853df2f53b', function(...) MFS:UseItemMedic(...); end)

RegisterNetEvent('09369327-4455-4fca-aadc-9608cc3422d1')
AddEventHandler('09369327-4455-4fca-aadc-9608cc3422d1', function(category) MFS:HealBones(category); end)

RegisterNetEvent(  'MF_SkeletalSystem:HealBonesN')
AddEventHandler(  'MF_SkeletalSystem:HealBonesN', function(category) MFS:HealBones(category); end)

RegisterNetEvent('6a49245c-7468-4706-b5fe-f5ae5b9330a3')
AddEventHandler('6a49245c-7468-4706-b5fe-f5ae5b9330a3', function(category) MFS.PauseDamage = true; end)

RegisterNetEvent('1aa04986-66b4-4184-a507-e83a1570c7d1')
AddEventHandler('1aa04986-66b4-4184-a507-e83a1570c7d1', function(category) MFS.PauseDamage = false; end)

RegisterNetEvent('e579e46c-fb90-4b8b-aa82-11eab1d8b55d')
AddEventHandler('e579e46c-fb90-4b8b-aa82-11eab1d8b55d', function() 

end)

RegisterNetEvent('9978c21b-2912-449a-a235-151343263123')
AddEventHandler('9978c21b-2912-449a-a235-151343263123', function() 
	MFS:HandleMenu(false)
end)



Citizen.CreateThread(function(...) MFS:Awake(...); end)