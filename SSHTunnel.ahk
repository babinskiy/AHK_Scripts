#Persistent
; #SingleInstance, Force

SendMode Input
SetWorkingDir, %A_ScriptDir%

SSHCommand := "ssh root@165.232.69.229 -D 127.0.0.1:1080 -CnNT"
SSHProcessPID := -1

IconConnected := A_ScriptDir . "\icons\connection_green.ico"
IconDisconnected := A_ScriptDir . "\icons\connection.ico"

Menu, Connection, Add, Start, ConnectionStart
Menu, Connection, Add, Stop, ConnectionStop
Menu, Connection, Add, Restart, ConnectionRestart
Menu, Tray, Add
Menu, Tray, Add, Connection, :Connection
Menu, Tray, Icon, %IconDisconnected%

OnExit, ScriptExit

SetTimer, CheckConnectionStatus, 3000

Return

ConnectionStart:
    if (SSHProcessPID <= 0){
        Run, %SSHCommand%, %A_ScriptDir%, Hide, SSHProcessPID
    }
Return

ConnectionStop:
    if (SSHProcessPID > 0){
        Process, Close, %SSHProcessPID%
        SSHProcessPID := -1
    }
Return

ConnectionRestart:
    Gosub, ConnectionStop
    Sleep, 3000
    Gosub, ConnectionStart
Return

CheckConnectionStatus:
    If (SSHProcessPID <= 0){
        Menu, Tray, Icon, %IconDisconnected%
    } Else {
        Process, Exist, %SSHProcessPID%
        If (ErrorLevel > 0 ){
            Menu, Tray, Icon, %IconConnected%
        } Else {
            SSHProcessPID := -1
            Menu, Tray, Icon, %IconDisconnected%
        }
    }
Return

ScriptExit:
    Gosub, ConnectionStop
    ExitApp, 0
Return

