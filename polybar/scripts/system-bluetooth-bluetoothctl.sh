#!/bin/sh

bluetooth_print() {
    bluetoothctl | grep --line-buffered 'Device\|#' | while read -r REPLY; do
        if [ "$(systemctl is-active "bluetooth.service")" = "active" ]; then
            printf '%%{F#7804D6}%%{F-}'

            devices_paired=$(bluetoothctl devices Paired | grep Device | cut -d ' ' -f 2)
            counter=0

            for device in $devices_paired; do
                device_info=$(bluetoothctl info "$device")

                if echo "$device_info" | grep -q "Connected: yes"; then
                    device_output=$(echo "$device_info" | grep "Alias" | cut -d ' ' -f 2-)
                    device_battery_percent=$(echo "$device_info" | grep "Battery Percentage" | awk -F'[()]' '{print $2}')

                    if [ -n "$device_battery_percent" ]; then
                        if [ "$device_battery_percent" -gt 90 ]; then
                            device_battery_icon="%%{F#7804D6}%%{F-}"
                        elif [ "$device_battery_percent" -gt 60 ]; then
                            device_battery_icon="%%{F#7804D6}%%{F-}"
                        elif [ "$device_battery_percent" -gt 35 ]; then
                            device_battery_icon="%%{F#7804D6}%%{F-}"
                        elif [ "$device_battery_percent" -gt 10 ]; then
                            device_battery_icon="%%{F#7804D6}%%{F-}"
                        else
                            device_battery_icon="%%{F#7804D6}%%{F-}"
                        fi

                        device_output="$device_output $device_battery_icon $device_battery_percent%%"
                    fi

                    if [ $counter -gt 0 ]; then
                        printf ", %s" "$device_output"
                    else
                        printf " %s" "$device_output"
                    fi

                    counter=$((counter + 1))
                fi
            done

            printf '\n'
        else
            printf '%%{F#7804D6}%%{F-}\n'
        fi
    done
}

bluetooth_toggle() {
    if bluetoothctl show | grep -q "Powered: no"; then
        bluetoothctl power on >> /dev/null
        sleep 1

        devices_paired=$(bluetoothctl devices Paired | grep Device | cut -d ' ' -f 2)
        echo "$devices_paired" | while read -r line; do
            bluetoothctl connect "$line" >> /dev/null
        done
    else
        devices_paired=$(bluetoothctl devices Paired | grep Device | cut -d ' ' -f 2)
        echo "$devices_paired" | while read -r line; do
            bluetoothctl disconnect "$line" >> /dev/null
        done

        bluetoothctl power off >> /dev/null
    fi
}

case "$1" in
    --toggle)
        bluetooth_toggle
        ;;
    *)
        bluetooth_print
        ;;
esac

#!/bin/sh

#!/bin/sh

# bluetooth_print() {
#     if [ "$(systemctl is-active "bluetooth.service")" = "active" ]; then
#         printf '%%{F#7804D6}BT%%{F-}'

#         devices_paired=$(bluetoothctl devices Paired | grep Device | cut -d ' ' -f 2)
#         counter=0
#         device_info_output=""

#         for device in $devices_paired; do
#             device_info=$(bluetoothctl info "$device")

#             if echo "$device_info" | grep -q "Connected: yes"; then
#                 mac_address=$(echo $device_info  | grep  "Device" | cut -d ' ' -f 2)
#                 echo $mac_address
#                 device_output=$(echo "$device_info" | grep "Alias" | cut -d ' ' -f 2-)

#                 if [ $counter -gt 0 ]; then
#                     printf ", %s" "$device_output"
#                 else
#                     printf " %s" "$device_output"
#                 fi

#                 counter=$((counter + 1))
#             fi
#         done

#         printf '\n'

#         # Pass the MAC address as an argument to bluetooth_battery.py
#         if [ $# -eq 1 ]; then
#             device_mac="$1"
#             device_info_output="$device_info_output$(~/scripts/Bluetooth_Headset_Battery_Level/bluetooth_battery.py "$device_mac")"
#         fi

#         printf "$device_info_output\n"
#     else
#         printf '%%{F#7804D6}BT%%{F-}\n'
#     fi
# }

# bluetooth_toggle() {
#     if bluetoothctl show | grep -q "Powered: no"; then
#         bluetoothctl power on >> /dev/null
#         sleep 1

#         devices_paired=$(bluetoothctl devices Paired | grep Device | cut -d ' ' -f 2)
#         echo "$devices_paired" | while read -r line; do
#             bluetoothctl connect "$line" >> /dev/null
#         done
#     else
#         devices_paired=$(bluetoothctl devices Paired | grep Device | cut -d ' ' -f 2)
#         echo "$devices_paired" | while read -r line; do
#             bluetoothctl disconnect "$line" >> /dev/null
#         done

#         bluetoothctl power off >> /dev/null
#     fi
# }

# case "$1" in
#     --toggle)
#         bluetooth_toggle
#         ;;
#     *)
#         bluetooth_print "$2"  # Pass the MAC address as the second argument
#         ;;
# esac

