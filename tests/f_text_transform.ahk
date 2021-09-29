
EngKeys := "``~1!2@3#4$5`%6^7&8*9(0)-_=+qQwWeErRtTyYuUiIoOpP[{]}\|aAsSdDfFgGhHjJkKlL;:'""zZxXcCvVbBnNmM,<.>/?"
RusKeys :=  "¸¨1!2'3¹4;5`%6:7?8*9(0)-_=+éÉöÖóÓêÊåÅíÍãÃøØùÙçÇõÕúÚ\/ôÔûÛâÂàÀïÏğĞîÎëËäÄæÆıİÿß÷×ñÑìÌèÈòÒüÜáÁşŞ.,"

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
