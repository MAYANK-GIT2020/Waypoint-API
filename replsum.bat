@echo off

powershell.exe -ExecutionPolicy Bypass -Command "C:\Users\Administrator\Documents\healthcheckscript\replication.ps1"
TIMEOUT /T 10
exit