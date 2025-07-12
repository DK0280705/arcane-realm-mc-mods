@echo off
title Arcane Realm Mods - One-Click Update
echo.
echo ===============================================
echo    Arcane Realm Minecraft Mods Updater
echo ===============================================
echo.
echo Checking for updates...
echo.

REM Change to the script's directory
cd /d "%~dp0"

REM Check if this is a git repository
if not exist ".git" (
    echo ERROR: This folder is not a git repository!
    echo Please make sure you're running this from the correct folder.
    echo.
    pause
    exit /b 1
)

REM Perform git pull with rebase
echo Updating mods from repository...
git pull --rebase > git_output.tmp 2>&1
set PULL_ERROR=%ERRORLEVEL%

REM Check if the command was successful
if %PULL_ERROR% EQU 0 (
    echo.
    echo ===============================================
    echo    SUCCESS! Your mods have been updated!
    echo ===============================================
    echo.
    echo Your Arcane Realm mods are now up to date.
    echo You can close this window and start Minecraft.
    del git_output.tmp
) else (
    echo.
    echo ===============================================
    echo         UPDATE FAILED!
    echo ===============================================
    echo.
    echo Git returned the following error:
    echo.
    type git_output.tmp
    echo.
    echo ===============================================
    echo.
    echo Please contact your server admin for help.
    echo Show them the error message above.
    del git_output.tmp
)

echo.
echo Press any key to close this window...
pause >nul