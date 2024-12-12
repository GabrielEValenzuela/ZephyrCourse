#!/bin/bash

# Variables
BUILD_DIR="build/zephyr"
CONFIG_FILE="$BUILD_DIR/.config"
OLD_CONFIG_FILE="$BUILD_DIR/.config.old"
FRAGMENT_FILE="config_fragment.conf"

# Ensure the build directory exists
if [ ! -d "$BUILD_DIR" ]; then
  echo "Build directory not found! Run 'west build' first."
  exit 1
fi

# Backup the current .config file
if [ -f "$CONFIG_FILE" ]; then
  cp "$CONFIG_FILE" "$OLD_CONFIG_FILE"
  echo "Backed up .config to .config.old"
else
  echo ".config file not found in $BUILD_DIR!"
  exit 1
fi

# Run menuconfig
echo "Launching menuconfig..."
west build -t menuconfig

# Check for changes
if diff "$OLD_CONFIG_FILE" "$CONFIG_FILE" > config.diff; then
  echo "No changes detected in configuration."
else
  echo "Changes detected. Generating configuration fragment..."
  python3 $ZEPHYR_BASE/scripts/kconfig/kconfig.py --kconfig-out="$FRAGMENT_FILE"
  echo "Configuration fragment saved to $FRAGMENT_FILE"
  echo "Differences saved to config.diff"
fi

