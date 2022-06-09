#Persistent
SendMode Input
SetWorkingDir, %A_ScriptDir%

OnMessage(WM_LBUTTONUP , "GotDoubleClick")

GotDoubleClick(){
    MsgBox, "Got double click!"
}
