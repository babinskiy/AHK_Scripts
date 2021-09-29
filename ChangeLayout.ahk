#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force
; #Warn  ; Enable warnings to assist with detecting common errors.

SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Include functions.ahk

capslock::
	hwnd := WinExist("A")
	currKBLayout := GetCurrKeyboard(hwnd)
	if (Format("0x{:08x}", currKBLayout) != "0x04090409"){
		LangCode := 0x0409
		LangName := "English"
	} else {
		LangCode := 0x0419
		LangName := "Russian"
	}
	SetWindowKeyboard(hwnd, LangCode)
	OSD("LANG: " . LangName,,,"Window", hwnd)

return

#!t::
	WinSet, AlwaysOnTop, Toggle, A
return


#!Up::
winHandle := WinExist("A") ; Get a handle to the active window
winResult := GetCurrScreen(winHandle, monitorLeft, monitorTop, monitorRight, monitorBottom, workLeft, workTop, workRight, workBottom, isPrimary)
if (winResult)
 	WinMove, ahk_id %winHandle%,, workLeft, workTop, (workRight-workLeft), (workBottom - workTop)/2
else
    MsgBox, Failed to get monitor info.
return

#!Down::
winHandle := WinExist("A") ; Get a handle to the active window
winResult := GetCurrScreen(winHandle, monitorLeft, monitorTop, monitorRight, monitorBottom, workLeft, workTop, workRight, workBottom, isPrimary)
if (winResult)
 	WinMove, ahk_id %winHandle%,, workLeft, workTop + (workBottom - workTop)/2, (workRight-workLeft), (workBottom - workTop)/2
else
    MsgBox, Failed to get monitor info.
return

; #x::
; winHandle := WinExist("A") ; Get a handle to the active window
; ; MonitorFromWindow https://msdn.microsoft.com/en-us/library/windows/desktop/dd145064%28v=vs.85%29.aspx
; ; GetMonitorInfo https://msdn.microsoft.com/en-us/library/windows/desktop/dd144901%28v=vs.85%29.aspx
; ; MONITORINFO https://msdn.microsoft.com/en-us/library/windows/desktop/dd145065%28v=vs.85%29.aspx
; VarSetCapacity(monitorInfo, 40), NumPut(40, monitorInfo)
; if (monitorHandle := DllCall("MonitorFromWindow", "Ptr", winHandle, "UInt", 0x2))
;     && DllCall("GetMonitorInfo", "Ptr", monitorHandle, "Ptr", &monitorInfo) {
;     monitorLeft   := NumGet(monitorInfo,  4, "Int")
;     monitorTop    := NumGet(monitorInfo,  8, "Int")
;     monitorRight  := NumGet(monitorInfo, 12, "Int")
;     monitorBottom := NumGet(monitorInfo, 16, "Int")
;     workLeft      := NumGet(monitorInfo, 20, "Int")
;     workTop       := NumGet(monitorInfo, 24, "Int")
;     workRight     := NumGet(monitorInfo, 28, "Int")
;     workBottom    := NumGet(monitorInfo, 32, "Int")
;     isPrimary     := NumGet(monitorInfo, 36, "Int") & 1

;     MsgBox, % "monitorLeft:`t"      monitorLeft   "`n"
;             . "monitorTop:`t"       monitorTop    "`n"
;             . "monitorRight:`t"     monitorRight  "`n"
;             . "monitorBottom:`t"    monitorBottom "`n"
;             . "workLeft:`t`t"       workLeft      "`n"
;             . "workTop:`t`t"        workTop       "`n"
;             . "workRight:`t"        workRight     "`n"
;             . "workBottom:`t"       workBottom    "`n"
;             . "isPrimary:`t`t"      isPrimary
; }
; else
;     MsgBox, Failed to get monitor info.
; return
