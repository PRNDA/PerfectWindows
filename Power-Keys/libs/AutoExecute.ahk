﻿AutoExecute:

if A_Is64bitOS&(bit=86)
{
    msgbox,0x40010,Power Keys,%_Require64%
    exitapp
}

if !A_IsAdmin
{
    try
    {
        Run *RunAs "%A_ScriptFullPath%" /restart
    }
    ExitApp
}

Suspend,off

regread,temp,HKLM\Software\Microsoft\Windows\CurrentVersion\Run, Power Keys
if !ErrorLevel
{
    RegWrite, REG_SZ, HKLM\Software\Microsoft\Windows\CurrentVersion\Run, Power Keys, %A_ScriptFullPath%
    StartUp=1
}
Else
{
    StartUp=0
}

regread,temp,HKLM\Software\szzhiyang\Power Keys,SpaceDisabled
if temp
SpaceDisabled=1

EnvGet,AppDataLocal,LocalAppData

FileCreateDir,%AppDataLocal%\Power Keys
SetWorkingDir,%AppDataLocal%\Power Keys

Gui,welcome: +LastFound +AlwaysOnTop -Caption +ToolWindow
Gui,welcome: Color, red
Gui,welcome: Font,cwhite s%FontSize% wbold q5,Segoe UI
Gui,welcome: Add, Text, ,Power Keys
Gui,welcome: Show,AutoSize Center NoActivate
sleep 1000
Gui,welcome: Hide

RegDelete, HKLM\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run, Power Keys
RegDelete, HKCU\Software\Microsoft\Windows\CurrentVersion\Run, Power Keys
RegDelete, HKCU\Software\Microsoft\Windows\CurrentVersion\Policies\Explorer\Run, Power Keys

Gosub, Createtray
Gosub, CreateGUI

return