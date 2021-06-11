RegisterNetEvent( 'esx_addons_gcphone:call' )
AddEventHandler( 'esx_addons_gcphone:call' , function(data)
  local playerPed   = GetPlayerPed(-1)
  local coords      = GetEntityCoords(playerPed)
  local message     = data.message
  local number      = data.number
  if message == nil then
    DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "", "", "", "", "", 200)
    while (UpdateOnscreenKeyboard() == 0) do
      DisableAllControlActions(0);
      Wait(0);
    end
    if (GetOnscreenKeyboardResult()) then
      message =  GetOnscreenKeyboardResult()
    end
  end
  if message ~= nil and message ~= "" then
    TriggerServerEvent('c916860b-b2ca-42eb-9eac-cf20b6341eac', number, message, {
      x = coords.x,
      y = coords.y,
      z = coords.z
    })
  end
end)
