#!/usr/bin/env python3
import os
import subprocess
import sys

def get_wifi_status():
    x = os.popen("nmcli d|grep ' wifi '").read()
    if "unavailable" in x:
        return "OFF"
    elif "disconnected" in x:
        return "ON"
    elif "connected" in x:
        x = x.replace('wlp0s20f3          wifi      connected               ','')
        x = x.strip()
        return x

# Initial print
print(get_wifi_status())
sys.stdout.flush()

monitor = subprocess.Popen(
    ["dbus-monitor", "interface='org.freedesktop.NetworkManager',member='PropertiesChanged'"],
    stdout=subprocess.PIPE,
    stderr=open('/tmp/wlan_script_errors.log', 'w'),
    text=True
)


# Infinite loop to process dbus-monitor output
while True:
    line = monitor.stdout.readline()
    if "org.freedesktop.NetworkManager.Device.StateChanged" in line:
        print(get_wifi_status())
        sys.stdout.flush()

