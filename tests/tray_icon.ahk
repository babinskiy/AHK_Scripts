#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

Menu, Tray, Icon, %A_ScriptDir%\app.ico

^Q::
Exit, 0
Return


Menu, Connection, Start, ConnectionStart
Menu, Connection, Stop, ConnectionStop
Menu, Connection, Restart, ConnectionRestart