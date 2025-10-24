@echo off
title Zomboid Save Scum Installer
setlocal

for /f "delims=" %%a in ('powershell -NoProfile -Command "$HOME"') do set "USERHOME=%%a"


set "ZOMBOIDDIR=%USERHOME%\Zomboid\Saves"
set "SCRIPT=%ZOMBOIDDIR%\SaveScum.ps1"
set "ICON=%ZOMBOIDDIR%\savescum.ico"

if not exist "%ZOMBOIDDIR%" (
    echo.
    echo ERROR: The directory "%ZOMBOIDDIR%" does not exist.
    echo Please launch Project Zomboid at least once to generate the save folder, then rerun this installer.
    echo.
    pause
    exit /b 1
)

echo === Installing ZomboidSaveScum ===
echo.

echo Installing ZomboidSaveScum to: %SCRIPT%

echo Downloading Contents...
powershell -NoLogo -Command ^
  "Invoke-WebRequest 'https://raw.githubusercontent.com/morkohl/project_zomboid_savescum/refs/heads/main/SaveScum.ps1' -OutFile '%SCRIPT%'"

powershell -NoLogo -Command ^
  "Invoke-WebRequest 'https://raw.githubusercontent.com/morkohl/project_zomboid_savescum/refs/heads/main/savescum.ico' -OutFile '%ICON%'"

echo Creating Start Menu shortcut...
powershell -NoLogo -Command ^
  "$shell = New-Object -ComObject WScript.Shell;" ^
  "$shortcut = $shell.CreateShortcut('%APPDATA%\Microsoft\Windows\Start Menu\Programs\Zomboid Save Scum.lnk');" ^
  "$shortcut.TargetPath = 'powershell.exe';" ^
  "$shortcut.Arguments = '-ExecutionPolicy Bypass -File ""%SCRIPT%""';" ^
  "$shortcut.IconLocation = '%ICON%';" ^
  "$shortcut.Save()"

echo.
echo === Successfully installed ZomboidSaveScum ===
echo.
echo You can now open the Start Menu (Windows Button) and search for 'Zomboid Save Scum' to launch it.
echo.

pause
