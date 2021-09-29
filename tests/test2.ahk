#SingleInstance force
#NoEnv

KLF_ACTIVATE := 1
KL_NAMELENGTH := 9

KeyboardLayout_EN_US := 0x04090409
KeyboardLayout_RU_UA := 0x04190419
KeyboardLayout_UA    := 0xF0A80422
KeyboardLayout_Dvorak := 0xF0020409

;get and output the current keyboard layout
hwnd := WinExist("A")
; msgBox, % currentKeyboardLayout
LoadKeyboardLayout(KeyboardLayout_EN_US)
setKeyboardLayout(hwnd, KeyboardLayout_EN_US)

;currentKeyboardLayout := getKeyboardLayout(hwnd)
;msgBox, % dec2hex(currentKeyboardLayout)

return


;Loads specified keyboardLayout
;use values form getKeyboardLayout
LoadKeyboardLayout(keyboardLayout)
{
    global KLF_ACTIVATE

    DllCall("user32.dll\LoadKeyboardLayout", "Str", keyboardLayout
        , "uint", KLF_ACTIVATE)
}

;gets the keyboard layout for window with specified hwnd
getKeyboardLayout(hwnd, ByRef keyBoardLayout = "")
{
    idThread := getWindowThreadProcessId(hwnd)

    keyboardLayout := DllCall("user32.dll\GetKeyboardLayout"
        , "uint", idThread, "uint")

    return keyboardLayout
}

;sets the keyboard layout for window with specified hwnd
setKeyboardLayout(hwnd, keyboardLayout)
{
    global WM_INPUTLANGCHANGEREQUEST

    idThread := GetWindowThreadProcessId(hwnd)

    PostMessage, WM_INPUTLANGCHANGEREQUEST, 0, %keyboardLayout%, , ahk_id %hwnd%
}

/*
converts a decimal value to a hex value (with leading "0x")

I use this to convert the getKeyboardLayout value to a hex value
and store the value (as shown above in KeyboardLayout_Dvorak/QWERTY)

ErrorLevol = 0 (if successful)
ErrorLevel = 1 (if inputed decimal value < 0)
*/
dec2hex(decValue)
{
    if (decValue < 0)
    {
        ErrorLevel := 1
        return 0
    }

    hexValue := ""
    base := 16

    Loop
    {
        remainder := mod(decValue, base)
        decValue //= base

        if (remainder >= 0 && remainder <= 9)
        {
            hexValue := remainder . hexValue
        }
        else
        {
            hexValue := Chr(remainder - 10 + Asc("A")) . hexValue
        }

        if (decValue = 0)
        {
            ErrorLevol := 0
            return "0x" . hexValue
        }
    }
}

/*
Not needed by user
gets the thread for the window with given hwnd
used by get/setKeyboardLayout
*/
getWindowThreadProcessId(hwnd)
{
    return dllCall("user32\GetWindowThreadProcessId", "Uint", hwnd)
}