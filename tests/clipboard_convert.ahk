
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force
; #Warn  ; Enable warnings to assist with detecting common errors.

SendMode Event  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Include, ..\f_text_transform.ahk
#Include, ..\functions.ahk

OSD("Ready")

F12::
 If Clipboard {
    Clipboard := TransformStr(Clipboard, EngKeys, RusKeys)
    OSD("converted")
 }
Return

F11::
 If Clipboard {
    Clipboard := TransformStr(Clipboard, RusKeys, EngKeys)
    OSD("Converted")
 }
Return

F10::
    oldCl := Clipboard
    Clipboard :=
    Send {Ctrl down}c{Ctrl up}
    ClipWait 1
    if (!Clipboard or !RegExMatch(Clipboard, "[A-Za-z0-9]")) {
        OSD("Nothng copied")
        Clipboard := oldCl
        Return
    }
    Clipboard := TransformStr(Clipboard, EngKeys, RusKeys)
    Send {Ctrl down}v{Ctrl up}

    Clipboard := oldCl
Return

F9::
    MsgBox, % Clipboard

Return
