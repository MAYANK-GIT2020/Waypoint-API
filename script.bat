@echo off
title Centrify DropBox Backup
echo.
echo Initial configuration for automatic backup with Robocopy
echo
robocopy "C:\Users\dropbox\Dropbox (Centrify)\Build Team" "F:\DropboxRepository" /COPY:DAT /E /V /Z /TEE /R:n /W:n /LOG+:D:\Script\robologs.txt
echo.
echo Done
echo.
