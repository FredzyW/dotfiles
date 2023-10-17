#!/bin/sh

LAST_STATUS=""

dbus-monitor "interface=org.bluez.Adapter1" |
while read -r line; do
    # Check if the bluetooth.service is active
    if [ "$(systemctl is-active "bluetooth.service")" = "active" ]; then
        # Check if Bluetooth is powered on
        if bluetoothctl show | grep -q "Powered: yes"; then
            # Check if any device is connected
            if bluetoothctl info | grep -q "Connected: yes"; then
                NAME=$(bluetoothctl info | grep "Name:" | awk -F": " '{print $2}')
                if [ "$LAST_STATUS" != "$NAME" ]; then
                    echo $NAME
                    LAST_STATUS=$NAME
                fi
            else 
                if [ "$LAST_STATUS" != "ON" ]; then
                    echo ON
                    LAST_STATUS="ON"
                fi
            fi
        else 
            if [ "$LAST_STATUS" != "OFF" ]; then
                echo OFF
                LAST_STATUS="OFF"
            fi
        fi
    else
        if [ "$LAST_STATUS" != "SERVICE DISABLED" ]; then
            echo 'SERVICE DISABLED'
            LAST_STATUS="SERVICE DISABLED"
        fi
    fi
done

