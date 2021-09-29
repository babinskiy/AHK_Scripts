#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
#SingleInstance force

SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

SPI_SETDEFAULTINPUTLANG := 0x005A
SPIF_SENDWININICHANGE := 2
WM_INPUTLANGCHANGEREQUEST := 0x50


F11::
ThreadId := DllCall("User32.dll\GetWindowThreadProcessId", "Ptr", WinExist("A"), "Ptr", 0, "UInt")
hCurrentKBLayout := DllCall("User32.dll\GetKeyboardLayout", "UInt", ThreadId, "Ptr")
msgbox % Format("0x{:08X}", hCurrentKBLayout)
return

;F12::
;SetWindowKeyboard(WinExist("A"), 0x0409)
;PostMessage, WM_INPUTLANGCHANGEREQUEST, 0, 0x04090409, , ahk_id WinExist("A")
;PostMessage, 0x50, 0, 0x04090409, , ahk_id WinExist("A")
;return

;^Z::
;V++
;M:=mod(V,2)
;if M=1
;   SetWindowKeyboard(0x0419) ; Russian
;else
;   SetWindowKeyboard(0x0409) ; english-US
;return

;^x::
;WinGet, hwnd, ID, A
;a2 := getKeyboardLayout(hwnd)
;msgbox,% "Now=" Format("0x{:x}", a2)
;Return

SetWindowKeyboard(hwnd, LocaleID){
	Global SPI_SETDEFAULTINPUTLANG := 0x005A
	Global SPIF_SENDWININICHANGE := 2
	Global WM_INPUTLANGCHANGEREQUEST := 0x50
	Lan := DllCall("LoadKeyboardLayout", "Str", Format("{:08x}", LocaleID), "Int", 0)
	VarSetCapacity(Lan%LocaleID%, 4, 0)
	NumPut(LocaleID, Lan%LocaleID%)
	DllCall("SystemParametersInfo", "UInt", SPI_SETDEFAULTINPUTLANG, "UInt", 0, "UPtr", &Lan%LocaleID%, "UInt", SPIF_SENDWININICHANGE)
	PostMessage WM_INPUTLANGCHANGEREQUEST, 0, %Lan%, , ahk_id %hwnd%
}

SetGlobalKeyboard(LocaleID){
	Global
	SPI_SETDEFAULTINPUTLANG := 0x005A
	SPIF_SENDWININICHANGE := 2
	Lan := DllCall("LoadKeyboardLayout", "Str", Format("{:08x}", LocaleID), "Int", 0)
	VarSetCapacity(Lan%LocaleID%, 4, 0)
	NumPut(LocaleID, Lan%LocaleID%)
	DllCall("SystemParametersInfo", "UInt", SPI_SETDEFAULTINPUTLANG, "UInt", 0, "UPtr", &Lan%LocaleID%, "UInt", SPIF_SENDWININICHANGE)
	WinGet, windows, List
	Loop %windows% {
		PostMessage 0x50, 0, %Lan%, , % "ahk_id " windows%A_Index%
	}
}

;gets the keyboard layout for window with specified hwnd
getKeyboardLayout(hwnd, ByRef keyBoardLayout = "")
{
    idThread := getWindowThreadProcessId(hwnd)

    keyboardLayout := DllCall("user32.dll\GetKeyboardLayout", "uint", idThread, "uint")

    return keyboardLayout
}

getWindowThreadProcessId(hwnd)
{
    return dllCall("user32\GetWindowThreadProcessId", "Uint", hwnd)
}