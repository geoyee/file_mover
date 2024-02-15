@echo off
setlocal enabledelayedexpansion

@REM 1. Check your phone is in developer mode
@REM 2. Check your phone opend the USB port
@REM *. Some phones like HONOR need to select USB config is "RNDIS(USB Ethernet)"
@REM 3. Change `source_folder` and `target_folder`
@REM 4. Change this file (.bat) to ANSI, not UTF-8

@REM Connected device
adb devices

@REM Change `source_folder` to the local path
set source_folder=C:\Users\XXX\Desktop\music
@REM Change `target_folder` to the phone's path
@REM Use `sdcard` instead
set target_folder=/sdcard/Music/test

@REM Create `target_folder` if it does not exist
adb shell mkdir -p %target_folder%

@REM Save all file's name in sorted_files.txt by last modified time
dir /a-d /od /b "%source_folder%\" > sorted_files.txt

@REM Copy files
for /f "tokens=* delims=" %%f in (sorted_files.txt) do (
    @REM Only Windows platform
    @REM copy "%source_folder%\%%f" "%target_folder%\%%f"
    @REM Push files to Android platform
    echo "Pushing %source_folder%\%%f to %target_folder%/%%f"
    adb push "%source_folder%\%%f" "%target_folder%/%%f"
    @REM Wait 1 second
    timeout /nobreak /t 1
)

pause
