#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

NOTEPAD := "C:\Windows\System32\notepad.exe"
; NOTEPAD := "C:\Windows\System32\notepad.exe"

; Process, Wait, NOTEPAD

Run, %NOTEPAD%, %A_ScriptDir%, , OutputVarPID

Process, Wait, %OutputVarPID%

OnExit, KillNP

Process, WaitClose, %OutputVarPID% 

MsgBox, "Exited"



KillNP:
Process, Close, %OutputVarPID% 
Return