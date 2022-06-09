#Persistent

tfunc := Func("TestFun").Bind("some text2")

TestFun(a) {
    MsgBox, %a%
}

Menu Tray, Add
Menu, Tray, Add, 1, % tfunc
Menu, Tray, Add, 2, % tfunc
; Menu, Tray, Insert, 3&, Run, % tfunc 