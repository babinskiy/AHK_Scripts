OSD_BGColor := A4A4A4
OSD_TextColor := 0F0F0F

OSD(Text, TextColor:="0xFFFFFF", BGColor:="0xA0A0A0", Position := "Screen", Window := ""){
	Global
	TextWidth := StringWidth(Text)
	OSD_YPosition := A_ScreenHeight * 0.8
	SetTimer, RemoveToolTip, -5000
	Gui +LastFound +AlwaysOnTop +ToolWindow -Caption ; +ToolWindow avoids a taskbar button and an alt-tab menu item.
	Gui, Color, BGColor
	WinSet, Transparent, 150
	Gui, Font, s14 c%TextColor%, Arial  ; q3 to non-antialias the text, only works in AHK_L
	GuiControlGet, oldText,, MyText
	if (oldText){
		GuiControl, Move, MyText, w%TextWidth%
	}
	Else
	{
		Gui, Add, Text, vMyText c%TextColor% w%TextWidth%
	}
	;WinSet, TransColor, %BGColor% 150
	If (Position == "Window" And Window){
		GetOSDPosition(Window, WinX, WinY)
		Gui, Show, x%WinX% y%WinY% AutoSize NoActivate  ; NoActivate avoids deactivating the currently active window.
	} else {
		Gui, Show, xCenter y%OSD_YPosition% AutoSize NoActivate  ; NoActivate avoids deactivating the currently active window.
	}
	GuiControl,, MyText, %Text%
	Return

	RemoveToolTip:
	SetTimer, RemoveToolTip, Off
	Gui, Destroy
	Return
}

GetOSDPosition(hwnd, ByRef X:="", ByRef Y:=""){
	WinGetPos, WinX, WinY, WinWidth, WinHeight, ahk_id %hwnd%
	X := WinX + WinWidth/2
	Y := WinY + WinHeight/2
}

StringWidth(String, Font:="Arial", FontSize:=14)
{
	Gui StringWidth:Font, s%FontSize%, %Font%
	Gui StringWidth:Add, Text, R1, %String%
	GuiControlGet T, StringWidth:Pos, Static1
	Gui StringWidth:Destroy
	return TW
}

n := 1

F12::
n++
hwnd := WinExist("A")
OSD("Test" . n, , , "Window", hwnd)
Return
