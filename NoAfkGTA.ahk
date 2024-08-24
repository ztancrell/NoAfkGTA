 ; <Environment Setup>
#NoEnv                       ; Recommended for performance and compatibility with future AutoHotkey releases.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;SendMode Input              ; Recommended for new scripts due to its superior speed and reliability. Breaks in GTA

#SingleInstance Force        ; Ensures only one instance of the script is running.
; </Environment Setup>

if not A_IsAdmin
Run *RunAs "%A_ScriptDir%"

toggle := 0 ; boolean, false : var to toggle the afk loop
sleepTime := 10 ; (In Seconds) We don't need to be constantly moving. Even once every 10 seconds is very quick. (A fast loop will also make the script unreliable)

SetTimer, afkLoop, % sleepTime * 1000
Settimer, afkLoop, Off

Return

$NumpadMult:: 
    toggle := !toggle ; quick way of inversing a boolean in AHK
    SetTimer, afkLoop, % (toggle?"On":"Off")
    ; ToolTip % (toggle?"On":"Off") ; My debugging check to see  if the state was being toggled correctly, and on time. 
    if (toggle) ; beep once to indicate the timer is on
        SoundBeep 
    else { ; beep twice to indicate the timer is off
        SoundBeep  
        SoundBeep 
    } 
Return

^M::ExitApp ; Ctrl+M - Avoid accidently exiting the script while typing.

afkLoop:
    if (!toggle) ; If we somehow get to this point, but don't want to be, we exit here.
        return
    else {
        Send, {A} ; I don't see the point in spamming all move keys. Any two opposing directions should be enough
        Sleep 500 ; The game requires a bit of a pause between presses
        Send, {D}
    }

    KeyWait, NumpadMult, T1 ; Give the user a chance to press NumpadMult again to disable the the afkLoop timer.
return