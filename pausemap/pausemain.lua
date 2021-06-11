
function AddTextEntry(key, value)
	Citizen.InvokeNative(`ADD_TEXT_ENTRY`, key, value)
end
local firstrun = false

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		
		
		if IsPauseMenuActive() or firstrun == false then
			firstrun = true
			local plyid = GetPlayerServerId(PlayerId())
			SetHeaderTitle("Welcome to ~b~Blue~w~Bird~b~RP","~w~Your Player ID: ~y~~h~ "..plyid )
			
			SetMenuHeaderTextByIndex(0,"~b~MELBOURNE MAP",true)
			--SetMenuHeaderTextByIndex(1,"cao2",true)
			
			SetMenuAlert(4,"Keybinds|Graphics\nVoice")
				--[[
			for i=3,4 do 
			--SetMenuAlert(i,"nnbb")
			end
			
			for i=5,500 do 
				SetMenuAlert(i,"TT" .. i)
			end
			for i=1,50 do 
				SetHeadingDetailsCustom(i,"CC" .. i)
			end
			for i=1,50 do 
				SetMenuHeaderTextByIndex (i,"MM" .. i)
			end
			

			for i=1,50 do 
				SetHeadingDetailsAddition (i,"AA" .. i)
			end
			for i=1,50 do 
				SetHeadingDetailsCustom (i,"RR" .. i)
			end--]]
			
			 AddTextEntry("MO_VOUT", '~o~~h~Voice Settings ~r~!!!🗣️')
			 AddTextEntry("MO_MIC_VOL", 'Microphone Volume ~y~(your voice)~s~ |  ~b~~h~Turn Up ☝🏻🎙️')
			 AddTextEntry("MO_CHAT_OVOL", 'Voice Output Volume ~y~(others voices)~s~ |  ~b~~h~Turn Up ☝🏻🔊')
			 
			 AddTextEntry("MO_VCHAT_MODE", 'Voice Mode                  | 🎙️ ~b~~h~Set: ~r~Push To Talk')
			 AddTextEntry("MO_OUTP_DVC", 'Output Device                 | 🔊🎧 ~b~~h~Set: ~r~Speakers/Headset')
			 AddTextEntry("MO_INPUT_DVC", 'Input Device                 | 🎙️🎧 ~b~~h~Set: ~r~Microphone/Headset')
			 
			 AddTextEntry("GFXVID_OVERRIDE", 'Ignore suggested limits  👇📺~b~~h~SCROLL DOWN FOR MORE📺👇')
			 AddTextEntry("PM_PANE_GFX", '~b~~h~Graphics ~r~!!!📺')
			 AddTextEntry("GFX_TXTQ", 'Texture Quality    | 📺 ~b~~h~Set: ~r~Normal')
			 AddTextEntry("GFX_SHADERQ", 'Shader Quality     | 📺 ~b~~h~Set: ~g~High  ~y~(bright lights)')
			 AddTextEntry("GFX_POST_FX", 'POST FX      | 📺 ~b~~h~Set: ~g~High  ~y~(bright lights)')
			 SetHeaderTitle("Welcome to ~b~Blue~w~Bird~b~RP","~w~Your Player ID: ~y~~h~ "..plyid )
		else
			Wait(100)
		end
		
	end
end)
Threads.CreateLoop("pause_menu_header",50,function()
    --SetHeadingDetailsAddition(1," Addition1")
    --SetHeadingDetailsAddition(1," Addition2")
    --SetHeadingDetailsAddition(3," Addition3 $100000")
    
    --SetHeadingDetailsCustom(1,"Negbook")
    --SetHeadingDetailsCustom(2,"Custom2")
    --SetHeadingDetailsCustom(3,"Custom3")
	--if IsPauseMenuActive() or firstrun == false then
		
	 --end
	  
end)


function SetHeadingDetailsCustom(slot, str)
    Scaleforms.CallScaleformMovie("pause_menu_header",function(run,send,stop,handle)
    run("SET_HEADING_DETAILS_CUSTOM")
    send(slot-1, str)
    stop()
    end)
end 

function SetHeadingDetailsAddition(slot, str)
    Scaleforms.CallScaleformMovie("pause_menu_header",function(run,send,stop,handle)
    run("SET_HEADING_DETAILS_ADDITION")
    send(slot-1, str)
    stop()
    end)
end 

function ShiftCoronaDesc(shiftDesc, hideTabs)
    Scaleforms.CallScaleformMovie("pause_menu_header",function(run,send,stop,handle)
    run("SHIFT_CORONA_DESC")
    send(shiftDesc, hideTabs)
    stop()
    end)
end 

function SetHeaderTitle(title_, description_)
    local title = title_ and "<font face='$Font2_cond_NOT_GAMERNAME'>"..title_.."</font>" or ""
    local description = description_ and "<font face='$Font2'>".. description_ .."</font>" or ""
 
    Scaleforms.CallScaleformMovie("pause_menu_header",function(run,send,stop,handle)
    run("SET_HEADER_TITLE")
    send(title, false, description, false)
    stop()
    if description and string.len(description) > 0 then 
        ShiftCoronaDesc(true,false)
    else 
        ShiftCoronaDesc(false,false)
    end 
    end)
end 



function LockMenu(menuindex, isLocked)
    Scaleforms.CallScaleformMovie("pause_menu_header",function(run,send,stop,handle)
    run("LOCK_MENU_ITEM")
    send(menuindex, isLocked)
    stop()
    end)
end 

function SetMenuAlert(menuindex, warnStr_)
    local warnStr = warnStr_ and "<font face='$Font2_cond_NOT_GAMERNAME'>"..warnStr_.."</font>" or ""
    Scaleforms.CallScaleformMovie("pause_menu_header",function(run,send,stop,handle)
    run("SET_MENU_ITEM_ALERT")
    send(menuindex, warnStr, 0)
    stop()
    end)
end
function SetMenuHeaderTextByIndex(menuIndex, label, widthSpan)
    Scaleforms.CallScaleformMovie("pause_menu_header",function(run,send,stop,handle)
    run("SET_MENU_HEADER_TEXT_BY_INDEX")
    send(menuIndex, label, widthSpan)
    stop()
    end)
end


