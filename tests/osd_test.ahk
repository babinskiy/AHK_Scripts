CustomColor = D4D4D4  ; Can be any RGB color (it will be made transparent below).
Gui +LastFound +AlwaysOnTop +ToolWindow -Caption ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
Gui, Color, %CustomColor%
Gui, Font, s14 q3  ; q3 to non-antialias the text, only works in AHK_L
Gui, Add, Text, vMyText cLime w300
WinSet, TransColor, %CustomColor% 150
Gui, Show, x0 y400 NoActivate  ; NoActivate avoids deactivating the currently active window.
return

~F12:: ;The '~' prevents AHK from blocking the input of the button
GetKeyState, caps, F12, T
If Caps = D
{
GuiControl,, MyText, F12 ON
}
else
{
GuiControl,, MyText, 
}
return