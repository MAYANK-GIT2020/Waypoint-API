:while
powershell.exe -ExecutionPolicy Bypass -Command "C:\elim-monitoring\script\testps.ps1"
::powershell.exe -ExecutionPolicy Bypass -Command "C:\elim-monitoring\script\copying_utilies.ps1"

set file=C:\elim-monitoring\script\counter.txt
::for /f "tokens=*" %%A in (%file%) do (echo %%A)
for /f "tokens=*" %%x in (%file%) do (
set /A var=%%x
)

::echo %var%

if %var% EQU 17 (
echo 1 hi 1
) else (
echo 1 hi 0
)
sleep 240
goto :while