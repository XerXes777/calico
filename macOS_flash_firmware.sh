#!/bin/bash
# === ESP32-S3 Firmware Flash Script (macOS/Linux) ===
# -----------------------------------------------------
# Run this script from the project root.
# Requires: ./build/*.bin and ./esptool-v4.6/macos/esptool

# === CONFIGURATION ===
PORT=""
BAUD=921600
CHIP=esp32s3
ESPTOOL="./esptool-v4.6/macos/esptool"

# === BINARY FILES ===
BOOTLOADER="build/bootloader.bin"
PARTITIONS="build/partitions.bin"
BOOT_APP0="build/ota.bin"
APPLICATION="build/firmware.bin"

# === FLASH COMMAND ===
if [ -n "$PORT" ]; then
  $ESPTOOL \
    --chip $CHIP \
    --port "$PORT" \
    --baud $BAUD \
    --before default_reset \
    --after hard_reset \
    write_flash -e -z \
    --flash_mode keep \
    --flash_freq keep \
    --flash_size keep \
    0x0      "$BOOTLOADER" \
    0x8000   "$PARTITIONS" \
    0xe000   "$BOOT_APP0" \
    0x10000  "$APPLICATION"
else
  $ESPTOOL \
    --chip $CHIP \
    --baud $BAUD \
    --before default_reset \
    --after hard_reset \
    write_flash -e -z \
    --flash_mode keep \
    --flash_freq keep \
    --flash_size keep \
    0x0      "$BOOTLOADER" \
    0x8000   "$PARTITIONS" \
    0xe000   "$BOOT_APP0" \
    0x10000  "$APPLICATION"
fi
