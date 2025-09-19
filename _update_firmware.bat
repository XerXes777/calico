@echo off
REM === ESP32-S3 Firmware Update Script (Windows) ===
REM ---------------------------------------
REM This script update firmware to an ESP32-S3 using esptool.
REM Run this from the project root. Requires: /bin/*.bin and /esptool-v4.9.0-windows/esptool.exe

REM === CONFIGURATION ===
set PORT=
set BAUD=921600
set CHIP=esp32s3
set ESPTOOL=esptool-v4.9.0-windows\esptool.exe

REM === BINARY FILES ===
set BOOT_APP0=bin\ota.bin
set APPLICATION=bin\firmware.bin

REM === Update COMMAND ===
if not "%PORT%"=="" (
  %ESPTOOL% ^
    --chip %CHIP% ^
    --port %PORT% ^
    --baud %BAUD% ^
    --before default_reset ^
    --after hard_reset ^
    write_flash -z ^
    --flash_mode keep ^
    --flash_freq keep ^
    --flash_size keep ^
    0xe000   %BOOT_APP0% ^
    0x10000  %APPLICATION%
) else (
  %ESPTOOL% ^
    --chip %CHIP% ^
    --baud %BAUD% ^
    --before default_reset ^
    --after hard_reset ^
    write_flash -z ^
    --flash_mode keep ^
    --flash_freq keep ^
    --flash_size keep ^
    0xe000   %BOOT_APP0% ^
    0x10000  %APPLICATION%
)

pause
