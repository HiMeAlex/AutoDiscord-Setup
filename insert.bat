@echo off
set dir=C:\Users\%USERNAME%\AppData\Roaming\BetterDiscord
set discord=C:\Users\%USERNAME%\AppData\Local\Discord

if exist %discord%\packages (
    tasklist /fi "ImageName eq Discord.exe" /fo csv 2>NUL | find /I "Discord.exe">NUL
    if "%ERRORLEVEL%"=="0" (
        taskkill /f /im Discord.exe
    )
    if exist %dir%\ ( 
        if exist %dir%\plugins\ (
            rmdir /S /q %dir%\plugins\
        )
        if exist %dir%\themes\ (
            rmdir /S /q %dir%\themes\
        )
    ) else (
        set ERRORLEVEL=0
        ping www.google.com -n 1 -w 1000>NUL
        if %ERRORLEVEL%==0 (
            start /w %~dp0BetterDiscord-Windows.exe
        ) else (
            echo Internet unconnected or unstable, ending.
            exit
        )
    )
) else (
    echo Discord is not installed. Starting installer...
    ping www.google.com -n 1 -w 1000>NUL
    if %ERRORLEVEL%==0 (
        start /w %~dp0DiscordSetup.exe
        timeout /T 1 /NOBREAK>NUL
        :LOOP
        tasklist /fo csv /fi "WindowTitle eq Discord Updater" 2>NUL | find /I /N "Discord.exe">NUL
        IF ERRORLEVEL 1 (
        GOTO CONTINUE
        ) ELSE (
        Timeout /T 1 /NOBREAK>NUL
        GOTO LOOP
        )
        :CONTINUE
        timeout /T 1 /NOBREAK>NUL
        tasklist /fi "ImageName eq Discord.exe" /fo csv 2>NUL | find /I "Discord.exe">NUL
        if "%ERRORLEVEL%"=="0" (
            taskkill /f /im Discord.exe
        )
        start /w BetterDiscord-Windows.exe
    ) else (
        echo Internet unconnected or unstable, ending.
        exit
    )
    if exist %dir%\ ( 
        if exist %dir%\plugins\ (
            rmdir /S /q %dir%\plugins\
        )
        if exist %dir%\themes\ (
            rmdir /S /q %dir%\themes\
        )
    )
)
timeout /T 5 /NOBREAK>NUL
mkdir %dir%\plugins
mkdir %dir%\themes
copy %~dp0plugins %dir%\plugins
copy %~dp0themes %dir%\themes
    
for /D %%G in (%discord%\*) DO (
    start %%G\Discord.exe
    exit
)