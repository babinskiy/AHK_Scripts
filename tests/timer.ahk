#Persistent
SetWorkingDir, %A_ScriptDir%


NOTEPAD := "C:\Windows\System32\notepad.exe"

Run, %NOTEPAD%, %A_ScriptDir%, , OutputVarPID

; Process, WaitClose, %OutputVarPID% 

SetTimer, CheckProcess, 300

CheckProcess:
Process, WaitClose, %OutputVarPID%, 0
If (ErrorLevel = 0) {
    MsgBox, "Finally"
}
Return