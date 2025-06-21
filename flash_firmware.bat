@echo off
REM === ESP32-S3 Firmware Flash Script (Windows) ===
REM ---------------------------------------
REM This script flashes firmware to an ESP32-S3 using esptool.
REM Run this from the project root. Requires: /build/*.bin and /esptool-v4.9.0-windows/esptool.exe

REM === CONFIGURATION ===
set PORT=
set BAUD=921600
set CHIP=esp32s3
set ESPTOOL=esptool-v4.9.0-windows\esptool.exe

REM === BINARY FILES ===
set BOOTLOADER=build\bootloader.bin
set PARTITIONS=build\partitions.bin
set BOOT_APP0=build\ota.bin
set APPLICATION=build\firmware.bin

REM === FLASH COMMAND ===
if not "%PORT%"=="" (
  %ESPTOOL% ^
    --chip %CHIP% ^
    --port %PORT% ^
    --baud %BAUD% ^
    --before default_reset ^
    --after hard_reset ^
    write_flash -e -z ^
    --flash_mode keep ^
    --flash_freq keep ^
    --flash_size keep ^
    0x0      %BOOTLOADER% ^
    0x8000   %PARTITIONS% ^
    0xe000   %BOOT_APP0% ^
    0x10000  %APPLICATION%
) else (
  %ESPTOOL% ^
    --chip %CHIP% ^
    --baud %BAUD% ^
    --before default_reset ^
    --after hard_reset ^
    write_flash -e -z ^
    --flash_mode keep ^
    --flash_freq keep ^
    --flash_size keep ^
    0x0      %BOOTLOADER% ^
    0x8000   %PARTITIONS% ^
    0xe000   %BOOT_APP0% ^
    0x10000  %APPLICATION%
)

pause
