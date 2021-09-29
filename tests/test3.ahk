#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force
; #Warn  ; Enable warnings to assist with detecting common errors.

SendMode Event  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

F12::
	oldCl := Clipboard
	Clipboard :=
	Send {Ctrl down}c{Ctrl up}
	ClipWait 1
	if (!Clipboard)
		Send {Ctrl down}ac{Ctrl up}
		ClipWait 1
	Clipboard := Clipboard
	newCl := Clipboard
	Clipboard := oldCl

	MsgBox % "Clipboard: " Clipboard "`nnewCl: " newCl "`noldCl" oldCl
return

EnToRu(Text){

return ""
}

RuToEn(Text){

}

