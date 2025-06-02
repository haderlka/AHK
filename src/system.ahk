;#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.

; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
SetTitleMatchMode, 2 ; approximate match

ActivateOrLaunch(appName, exePath) {
    winID := "ahk_exe " . appName

    if WinExist(winID)
    {
        if WinActive(winID)
        {
            WinMinimize  ; Minimize the current active window
        }
        else
        {
            WinActivate  ; Bring the window to the foreground
        }
    }
    else
    {
        Run, %exePath%
    }
}

ActivateOrLaunchClass(className, exePath := "") {
    winID := "ahk_class " . className

    if WinExist(winID)
    {
        if WinActive(winID)
        {
            WinMinimize
        }
        else
        {
            WinActivate
        }
    }
    else if (exePath != "")
    {
        Run, %exePath%
    }
}


; ################################################################################
;
; Copy/Paste
; Allow pasting to CMD via Ctrl+V / Always remove formatting when pasting in cmd
;
; via [Ctrl+V]
; ################################################################################

#IfWinActive ahk_class ConsoleWindowClass
^V::
	SendInput {Raw}%clipboard%
return
#IfWinActive

; ################################################################################
;
; Copy/Paste
; remove formatting from clipboard and paste plain text
;
; via [Windows+V]
; ################################################################################
^#v::
	Clipboard=%Clipboard%   ; will remove formatting
	Sleep, 100   ; wait for Clipboard to update
	Send ^v
	Return
	
; ################################################################################
;
; Send Date
;
; via [Windows+D]
; ################################################################################
^#d::
	FormatTime, Date,, yyyy-MM-dd
	Send %Date% 
	Return

; ################################################################################
;
; Convert Windows path in clipboard to unix path and paste
;
; via [Windows+U]
; ################################################################################
#u::
    temp := Clipboard
    if (InStr(temp,":\"))
	{
		temp := Strreplace(temp,"\","/")
		temp := Strreplace(temp,":","")
		temp := "/" temp
	}
	else
	{
		temp := Strreplace(temp,"\","/")
	}
	Clipboard := temp
	Sleep, 100   ; wait for Clipboard to update
	Send ^v
	Return
	
; ################################################################################
; Open bash (MSYS2 terminal) or bring to front
; ################################################################################	
#F1::
ActivateOrLaunch("mintty.exe", "C:\Program Files\Git\git-bash.exe")
return

; ################################################################################
; Open Chrome or bring to front
; ################################################################################	
#F2::
ActivateOrLaunch("chrome.exe", "C:\Program Files\Google\Chrome\Application\chrome.exe")
return

; ################################################################################
; Open VSCode or bring to front
; ################################################################################	
#F3::  ; Win + V for VS Code
ActivateOrLaunch("Code.exe", A_UserProfile . "\AppData\Local\Programs\Microsoft VS Code\Code.exe")
return

; ################################################################################
;
; Open File Explorer or bring to front
;
; via [Windows+e]
; ################################################################################
#e::  ; Ctrl + Alt + E
ActivateOrLaunchClass("CabinetWClass", "explorer.exe")
return

; ################################################################################
; Open additional File Explorer
; ################################################################################
^#e::
Run, explorer.exe
return
	