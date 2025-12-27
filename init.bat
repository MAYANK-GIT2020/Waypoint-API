@echo off
start C:\"Program Files (x86)"\Adobe\"Reader 11.0"\Reader\AcroRd32.exe
TIMEOUT /T 4

title Centrify DropBox Backup
echo.
echo Initial configuration for automatic backup with Robocopy
echo
robocopy C:\temp\misc D:\ /COPY:DAT /E /V /Z /TEE /R:n /W:n /LOG+:D:\robologs.txt
echo.
echo Done
echo.
exit



::start "C:\Program Files (x86)\Adobe\Reader 11.0\Reader\AcroRd32.exe"

::echo Start Time: %time% > C:\temp\elim.results
::echo Start Date: %date% >> C:\temp\elim.results
::echo. %blank% >> C:\temp\elim.results
::echo. %blank% >> C:\temp\elim.results
::echo hi mayank >> C:\temp\elim.results