#!/bin/bash

# Set the UUID for the USB
USB_UUID="12345678-1234-1234-1234-1234567890AB"  # Replace with the UUID of your USB

# Find the device path using the UUID
USB_DEVICE_PATH=$(lsblk -no PATH,UUID | awk -v uuid="$USB_UUID" '$2 == uuid { print $1 }')

# Set the mount point
MOUNT_POINT="/home/user/usb"

# Check if the USB device is already mounted
if grep -qs "$USB_DEVICE_PATH" /proc/mounts; then
    echo "USB device is already mounted."
else
    # Check if the USB device is connected
    if [ -n "$USB_DEVICE_PATH" ]; then
        # Mount the USB device
        sudo mount "$USB_DEVICE_PATH" "$MOUNT_POINT"

        # Check if the mount was successful
        if [ $? -eq 0 ]; then
            echo "USB device mounted successfully."
        else
            echo "Failed to mount the USB device."
        fi
    else
        echo "USB device not found. Please insert the USB device."
    fi
fi
