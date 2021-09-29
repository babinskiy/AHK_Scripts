original_str := "ghbdtn"


; MsgBox % SubStr(eng_keys, 11,1) . " " . StrLen(eng_keys) . "`n" . SubStr(rus_keys, 11, 1) . " " . StrLen(rus_keys) . "`n" eng_keys

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance force
; #Warn  ; Enable warnings to assist with detecting common errors.

SendMode Event  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

eng_keys := "``~1!2@3#4$5`%6^7&8*9(0)-_=+qQwWeErRtTyYuUiIoOpP[{]}\|aAsSdDfFgGhHjJkKlL;:'""zZxXcCvVbBnNmM,<.>/?"
rus_keys :=  "¸¨1!2'3¹4;5`%6:7?8*9(0)-_=+éÉöÖóÓêÊåÅíÍãÃøØùÙçÇõÕúÚ\/ôÔûÛâÂàÀïÏğĞîÎëËäÄæÆıİÿß÷×ñÑìÌèÈòÒüÜáÁşŞ.,"

TransformStr(InString, FromKeys, ToKeys){
    ResultStr := ""
    Loop, Parse, InString
    {
        Char := A_LoopField
        CharPosition := InStr(FromKeys, Char, true)
        if CharPosition
            NewChar := SubStr(ToKeys, CharPosition, 1)
        else
            NewChar := Char
        ResultStr := ResultStr . NewChar
    }
    Return ResultStr
}

TransformStr(original_str, eng_keys, rus_keys)
; MsgBox, % StrLen(rus_keys)

; FileDelete, c:\Users\mbabi\AppData\Local\AHK\tests\out.txt
; Loop, Parse, eng_keys
; {
;     try {
;     FileAppend, % A_LoopField . " - " . SubStr(rus_keys, A_Index, 1) . "`n"  , c:\Users\mbabi\AppData\Local\AHK\tests\out.txt, CP1251
;     }
;     Catch e {
;         MsgBox, % A_LastError
;     }
; }




;F12::
;sgBox % Clipboard . "`n" . StrLen(Clipboard)
;Exit
