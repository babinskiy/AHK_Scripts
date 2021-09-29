SPI_SETDEFAULTINPUTLANG := 0x005A
SPIF_SENDWININICHANGE := 2
WM_INPUTLANGCHANGEREQUEST := 0x50


GetCurrScreen(winHandle, ByRef monitorLeft, ByRef monitorTop, ByRef monitorRight, ByRef monitorBottom, ByRef workLeft, ByRef workTop, ByRef workRight, ByRef workBottom, ByRef isPrimary){
; MonitorFromWindow https://msdn.microsoft.com/en-us/library/windows/desktop/dd145064%28v=vs.85%29.aspx
; GetMonitorInfo https://msdn.microsoft.com/en-us/library/windows/desktop/dd144901%28v=vs.85%29.aspx
; MONITORINFO https://msdn.microsoft.com/en-us/library/windows/desktop/dd145065%28v=vs.85%29.aspx
	VarSetCapacity(monitorInfo, 40), NumPut(40, monitorInfo)
	if (monitorHandle := DllCall("MonitorFromWindow", "Ptr", winHandle, "UInt", 0x2))
	    && DllCall("GetMonitorInfo", "Ptr", monitorHandle, "Ptr", &monitorInfo) {
	    monitorLeft   := NumGet(monitorInfo,  4, "Int")
	    monitorTop    := NumGet(monitorInfo,  8, "Int")
	    monitorRight  := NumGet(monitorInfo, 12, "Int")
	    monitorBottom := NumGet(monitorInfo, 16, "Int")
	    workLeft      := NumGet(monitorInfo, 20, "Int")
	    workTop       := NumGet(monitorInfo, 24, "Int")
	    workRight     := NumGet(monitorInfo, 28, "Int")
	    workBottom    := NumGet(monitorInfo, 32, "Int")
	    isPrimary     := NumGet(monitorInfo, 36, "Int") & 1
	}
	else
	    return false
	return true
}

GetCurrKeyboard(hwnd, ByRef hCurrentKBLayout = ""){
	ThreadId := DllCall("User32.dll\GetWindowThreadProcessId", "Ptr", hwnd, "Ptr", 0, "UInt")
	hCurrentKBLayout := DllCall("User32.dll\GetKeyboardLayout", "UInt", ThreadId, "Ptr")
	return hCurrentKBLayout
}

SetGlobalKeyboard(LocaleID){
	Global SPI_SETDEFAULTINPUTLANG
	Global SPIF_SENDWININICHANGE
	Global WM_INPUTLANGCHANGEREQUEST
	Lan := DllCall("LoadKeyboardLayout", "Str", Format("{:08x}", LocaleID), "Int", 0)
	VarSetCapacity(Lan%LocaleID%, 4, 0)
	NumPut(LocaleID, Lan%LocaleID%)
	DllCall("SystemParametersInfo", "UInt", SPI_SETDEFAULTINPUTLANG, "UInt", 0, "UPtr", &Lan%LocaleID%, "UInt", SPIF_SENDWININICHANGE)
	WinGet, windows, List
	Loop %windows% {
		PostMessage WM_INPUTLANGCHANGEREQUEST, 0, %Lan%, , % "ahk_id " windows%A_Index%
	}
}

SetWindowKeyboard(hwnd, LocaleID){
	Global SPI_SETDEFAULTINPUTLANG
	Global SPIF_SENDWININICHANGE
	Global WM_INPUTLANGCHANGEREQUEST
	Lan := DllCall("LoadKeyboardLayout", "Str", Format("{:08x}", LocaleID), "Int", 0)
	VarSetCapacity(Lan%LocaleID%, 4, 0)
	NumPut(LocaleID, Lan%LocaleID%)
	DllCall("SystemParametersInfo", "UInt", SPI_SETDEFAULTINPUTLANG, "UInt", 0, "UPtr", &Lan%LocaleID%, "UInt", SPIF_SENDWININICHANGE)
	PostMessage WM_INPUTLANGCHANGEREQUEST, 0, %Lan%, , ahk_id %hwnd%
}

OSD(Text, TextColor:="0xFFFFFF", BGColor:="0xA0A0A0", Position := "Screen", Window := ""){
	Global
	TextWidth := StringWidth(Text)
	OSD_YPosition := A_ScreenHeight * 0.85
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
	Y := WinY + WinHeight * .8
}

StringWidth(String, Font:="Arial", FontSize:=14){
	Gui StringWidth:Font, s%FontSize%, %Font%
	Gui StringWidth:Add, Text, R1, %String%
	GuiControlGet T, StringWidth:Pos, Static1
	Gui StringWidth:Destroy
	return TW
}
