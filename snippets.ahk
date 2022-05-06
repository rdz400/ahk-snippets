OpenPage(adress){
    Send, ^t
    Sleep, 500
    Send, %adress%{Enter}
}

MakeIfNotExists(name){
    If (UniqueID := WinExist(name . " ahk_exe msedge.exe")) {
        WinActivate, ahk_id %UniqueID%
    } else {
        SetKeyDelay , -1,-1
        Run, msedge.exe --new-window
        WinActivate, New tab ahk_exe msedge.exe
        WinWaitActive, New tab ahk_exe msedge.exe
        Send, !f
        Send, l
        Send, w
        Sleep, 1000
        Send, %name%{Enter}
        Sleep, 300
        ; Send, ^+o
        ; Sleep, 1200
        ; Send, %name%
        ; Sleep, 800
        ; Send, ^{Enter}
        ; Send, ^w
    }
    return    
}

^!u::
MakeIfNotExists("Belastingdienst")
OpenPage("https://belastingdienst.nl")
return