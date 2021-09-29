
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force
; #Warn  ; Enable warnings to assist with detecting common errors.

SendMode Event  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

#Include, f_text_transform.ahk
#Include, functions.ahk


^F12::
    hwnd := WinExist("A")
    oldCl := Clipboard
    Clipboard :=
    Send {Ctrl down}c{Ctrl up}
    ClipWait 1
    if (!Clipboard or !RegExMatch(Clipboard, "[A-Za-z]")) {
        OSD("Nothng is copied",,,"Window", hwnd)
        Clipboard := oldCl
        Return
    }
    Clipboard := TransformStr(Clipboard, EngKeys, RusKeys)
    Send {Ctrl down}v{Ctrl up}

    Clipboard := oldCl
    OSD("Converted",,,"Window", hwnd)
Return

+F12::
    hwnd := WinExist("A")
    oldCl := Clipboard
    Clipboard :=
    Send {Ctrl down}c{Ctrl up}
    ClipWait 1
    if (!Clipboard or !RegExMatch(Clipboard, "[А-Яа-я]")) {
        OSD("Nothng is copied",,,"Window", hwnd)
        Clipboard := oldCl
        Return
    }
    Clipboard := TransformStr(Clipboard, RusKeys, EngKeys)
    Send {Ctrl down}v{Ctrl up}

    Clipboard := oldCl
    OSD("Converted",,,"Window", hwnd)
Return
