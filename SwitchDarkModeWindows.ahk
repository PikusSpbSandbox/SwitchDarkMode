#SingleInstance Force                             ; Allow only one instance off this app]
^F10::
; read the System lightmode from the registry 
RegRead,L_LightMode,HKCU,SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize,SystemUsesLightTheme
If L_LightMode {                                  ; if the mode was Light
	; write both system end App lightmode to the registry
	RegWrite,Reg_Dword,HKCU,SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize,SystemUsesLightTheme,0
	RegWrite,Reg_Dword,HKCU,SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize,AppsUseLightTheme   ,0
	}
else {                                            ; if the mode was dark
	; write both system end App lightmode to the registry
	RegWrite,Reg_Dword,HKCU,SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize,SystemUsesLightTheme,1
	RegWrite,Reg_Dword,HKCU,SOFTWARE\Microsoft\Windows\CurrentVersion\Themes\Personalize,AppsUseLightTheme   ,1
	}
; tell the system it needs to refresh the user settings
run,RUNDLL32.EXE USER32.DLL`, UpdatePerUserSystemParameters `,2 `,True
; reload explorer.exe to fix UI for 22h2
RunWait taskkill /F /IM explorer.exe
Run explorer.exe
Return