OSD(text)
{
	#Persistent
	; borderless, no progressbar, font size 25, color text 009900
	Progress, hide Y600 W1000 b zh0 cwFFFFFF FM50 CT00BB00,, %text%, AutoHotKeyProgressBar, Backlash BRK
	WinSet, TransColor, FFFFFF 255, AutoHotKeyProgressBar
	;WinSet, Transparent, 50, AutoHotKeyProgressBar
	Progress, show
	SetTimer, RemoveToolTip, 3000

	Return


RemoveToolTip:
	SetTimer, RemoveToolTip, Off
	Progress, Off
	return
}

F12::
OSD("Some text")
Return