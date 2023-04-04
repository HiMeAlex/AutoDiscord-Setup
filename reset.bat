@echo off
echo Removing discord and better discord...
tasklist /fi "ImageName eq Discord.exe" /fo csv 2>NUL | find /I "Discord.exe">NUL
    if "%ERRORLEVEL%"=="0" (
        taskkill /f /im Discord.exe
    )
timeout /T 2 /NOBREAK>nul
rmdir /S /q C:\Users\%USERNAME%\AppData\Roaming\discord\
rmdir /S /q C:\Users\%USERNAME%\AppData\Local\Discord\
rmdir /S /q "C:\Users\%USERNAME%\AppData\Roaming\BetterDiscord Installer\"
rmdir /S /q C:\Users\%USERNAME%\AppData\Roaming\BetterDiscord\
rmdir /S /q "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\Discord Inc\"
del /q C:\Users\%USERNAME%\OneDrive\Desktop\Discord.lnk
reg delete HKEY_CURRENT_USER\Software\Discord /f 
reg delete HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Uninstall\Discord /f
reg delete HKEY_CLASSES_ROOT\Discord /f
echo Removal finished.
