#!/bin/sh

if bluetoothctl show | grep -q "Powered: no"; then
    bluetoothctl power on
else 
    bluetoothctl power off
fi