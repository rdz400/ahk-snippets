^F5::Reload

SetWindowPos(multiple_y){
    WinGetPos, x, y,,, A
    CoordMode, Mouse, Client
    DllCall("SetCursorPos", "int", x + 160, "int", y + 400 + (multiple_y * 55))  ; The first number is the X-coordinate and the second is the Y (relative to the screen).
    return    
}

#IfWinActive ahk_exe Todoist.exe
^1::
SetWindowPos(0)
return

^2::
SetWindowPos(1)
return

^3::
SetWindowPos(2)
return

^4::
SetWindowPos(3)
return

^5::
SetWindowPos(4)
return


#IfWinActive ahk_exe ONENOTE.EXE
XButton1::
Send, ^{PgUp}
Return
XButton2::
Send, ^{PgDn}
Return

^Del::
Send, ^!g
Sleep, 100
Send, {Enter}
Send, {Del}
Send, ^!g
Return

#^c:: ; For making code snippets
If (A_Cursor == "IBeam"){
    Sleep, 300
    SendInput, {LAlt}
    Sleep, 300
    SendInput, hff
    SendInput , Roboto Mono{Enter}
    Send, {Esc}
}
Return

#IfWinActive


!^x::
If (UniqueID := WinExist("Productivity ahk_exe msedge.exe")) {
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
    Send, Productivity{Enter}
    Sleep, 300
    Send, ^+o
    Sleep, 1200
    SendInput , Daily Start
    Sleep, 800
    Send, ^{Enter}
    Send, ^w
}
return

#IfWinActive ahk_exe Explorer.EXE
^+c::
MsgBox, Test
Send, {Shift down}{F10}
Send, {Shift up}
Send, a
Return
#IfWinActive

!Volume_Up::
Send, !{F4}
Return

#Hotstring EndChars |
::->::
SendInput, % "--->"
Return
::dt::
SendInput, %A_YYYY%%A_MM%%A_DD%
Return
::rere::
EnvGet, userprofile, userprofile
SendInput, % userprofile
Return

::rissie::
InputBox, OutputVar
SendInput,
(
import os
from pathlib import Path
import re
text=re.escape(r"OutputVar")
for main, folders, files in os.walk(os.getcwd()):
    for file in files:
        name = str(Path(main) / file)
        if re.match(fr"{^}.*{text}.*$", name, flags=re.I):
            print(name)
)
Return

^#f::
Result :=  Trim(Clipboard, OmitChars := """")

If(RegExMatch(Result, "^C:\\Users\\{name}\\OneDrive\\.+xlsx$")){
    NewStr := RegExReplace(Result
        ,"C:\\Users\\{name}\\OneDrive\\"
        ,"https://d.docs.live.net/{code}/"
        ,
        ,1)

    NewStr := RegExReplace(NewStr
        ,"\\"
        ,"/")
    NewClipBoard:="ms-excel:" . NewStr
    MsgBox, % "ms-excel:" . NewStr
    Clipboard := NewClipBoard
} else{
    MsgBox, Nope no match for %Result%
}
Return


#IfWinActive ahk_exe EXCEL.EXE
#\::
Sleep, 200
SendInput, {LAlt}fic
ClipWait  ; Wait for the clipboard to contain text.
Result :=  Trim(Clipboard, OmitChars := """")
SendInput, {Esc}
NewClipBoard:="ms-excel:" . Result
Clipboard := NewClipBoard
Return
#IfWinActive

^#j::
MsgBox Test!
EnvGet, snippets, snippets
MsgBox, %snippets%
Run, cmd /K jupyter lab "%snippets%"
Return

^#[::
MyText:=Clipboard
MyText:=Trim(MyText, """" . A_Space . "`t`n")
If(RegExMatch(MyText, "^[\s\d]+$")){
    MyText:=RegExReplace(MyText, "\s+", " ")

    MyText:=StrSplit(MyText, " ")
    total:=0

    for index, n in MyText{
        if (index is number and Ord(n) != 0) {
            a := n + 0
            total:=total+a
        }
    }
    MsgBox, %total%
}

Return

